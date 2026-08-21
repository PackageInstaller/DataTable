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
			local var_4_0 = 0
			local var_4_1 = 0.2

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				local var_4_2 = "play"
				local var_4_3 = "music"

				arg_1_1:AudioAction(var_4_2, var_4_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_4 = ""
				local var_4_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_5 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_5 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_5

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_5
						arg_1_1.bgmTxt2_.text = var_4_5
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

			local var_4_6 = 0

			if var_4_6 < arg_1_1.time_ and arg_1_1.time_ <= var_4_6 + arg_4_0 then
				arg_1_1.fswbg_:SetActive(true)
				arg_1_1.dialog_:SetActive(false)

				arg_1_1.fswtw_.percent = 0

				local var_4_7 = arg_1_1:GetWordFromCfg(319631001)
				local var_4_8 = arg_1_1:FormatText(var_4_7.content)

				arg_1_1.fswt_.text = var_4_8

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.fswt_)

				arg_1_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_1_1.fswtw_:SetDirty()

				arg_1_1.typewritterCharCountI18N = 0

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_9 = 0.2

			if var_4_9 < arg_1_1.time_ and arg_1_1.time_ <= var_4_9 + arg_4_0 then
				arg_1_1.var_.oldValueTypewriter = arg_1_1.fswtw_.percent

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_10 = 14
			local var_4_11 = 0.933333333333333
			local var_4_12 = arg_1_1:GetWordFromCfg(319631001)
			local var_4_13 = arg_1_1:FormatText(var_4_12.content)
			local var_4_14, var_4_15 = arg_1_1:GetPercentByPara(var_4_13, 1)

			if var_4_9 < arg_1_1.time_ and arg_1_1.time_ <= var_4_9 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				local var_4_16 = var_4_10 <= 0 and var_4_11 or var_4_11 * ((var_4_15 - arg_1_1.typewritterCharCountI18N) / var_4_10)

				if var_4_16 > 0 and var_4_11 < var_4_16 then
					arg_1_1.talkMaxDuration = var_4_16

					if var_4_16 + var_4_9 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_16 + var_4_9
					end
				end
			end

			local var_4_17 = 0.933333333333333
			local var_4_18 = math.max(var_4_17, arg_1_1.talkMaxDuration)

			if var_4_9 <= arg_1_1.time_ and arg_1_1.time_ < var_4_9 + var_4_18 then
				local var_4_19 = (arg_1_1.time_ - var_4_9) / var_4_18

				arg_1_1.fswtw_.percent = Mathf.Lerp(arg_1_1.var_.oldValueTypewriter, var_4_14, var_4_19)
				arg_1_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_1_1.fswtw_:SetDirty()
			end

			if arg_1_1.time_ >= var_4_9 + var_4_18 and arg_1_1.time_ < var_4_9 + var_4_18 + arg_4_0 then
				arg_1_1.fswtw_.percent = var_4_14

				arg_1_1.fswtw_:SetDirty()
				arg_1_1:ShowNextGo(true)

				arg_1_1.typewritterCharCountI18N = var_4_15
			end

			local var_4_20 = 0

			if var_4_20 < arg_1_1.time_ and arg_1_1.time_ <= var_4_20 + arg_4_0 then
				local var_4_21 = arg_1_1.fswbg_.transform:Find("textbox/adapt/content") or arg_1_1.fswbg_.transform:Find("textbox/content")
				local var_4_22 = arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_4_23 = var_4_21:GetComponent("Text")
				local var_4_24 = var_4_21:GetComponent("RectTransform")

				var_4_23.alignment = UnityEngine.TextAnchor.LowerCenter
				var_4_24.offsetMin = Vector2.New(0, 0)
				var_4_24.offsetMax = Vector2.New(0, 0)
			end

			local var_4_25 = 0

			if var_4_25 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				arg_1_1.cswbg_:SetActive(true)

				local var_4_26 = arg_1_1.cswt_:GetComponent("RectTransform")

				arg_1_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_4_26.offsetMin = Vector2.New(410, 330)
				var_4_26.offsetMax = Vector2.New(-400, -180)

				local var_4_27 = arg_1_1:GetWordFromCfg(419033)
				local var_4_28 = arg_1_1:FormatText(var_4_27.content)

				arg_1_1.cswt_.text = var_4_28

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.cswt_)

				arg_1_1.cswt_.fontSize = 175
				arg_1_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_1_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_1_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_4_29 = 0
			local var_4_30 = 3.7
			local var_4_31 = manager.audio:GetVoiceLength("story_v_out_319631", "319631001", "story_v_out_319631.awb") / 1000

			if var_4_31 > 0 and var_4_30 < var_4_31 and var_4_31 + var_4_29 > arg_1_1.duration_ then
				local var_4_32 = var_4_31

				arg_1_1.duration_ = var_4_31 + var_4_29
			end

			if var_4_29 < arg_1_1.time_ and arg_1_1.time_ <= var_4_29 + arg_4_0 then
				local var_4_33 = "play"
				local var_4_34 = "voice"

				arg_1_1:AudioAction(var_4_33, var_4_34, "story_v_out_319631", "319631001", "story_v_out_319631.awb")
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
			local var_9_0 = 0

			if var_9_0 < arg_6_1.time_ and arg_6_1.time_ <= var_9_0 + arg_9_0 then
				local var_9_1 = arg_6_1.fswbg_.transform:Find("textbox/adapt/content") or arg_6_1.fswbg_.transform:Find("textbox/content")
				local var_9_2 = arg_6_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_9_3 = var_9_1:GetComponent("Text")
				local var_9_4 = var_9_1:GetComponent("RectTransform")

				var_9_3.alignment = UnityEngine.TextAnchor.LowerCenter
				var_9_4.offsetMin = Vector2.New(0, 0)
				var_9_4.offsetMax = Vector2.New(0, 0)
			end

			local var_9_5 = 0
			local var_9_6 = 5.266
			local var_9_7 = manager.audio:GetVoiceLength("story_v_out_319631", "319631002", "story_v_out_319631.awb") / 1000

			if var_9_7 > 0 and var_9_6 < var_9_7 and var_9_7 + var_9_5 > arg_6_1.duration_ then
				local var_9_8 = var_9_7

				arg_6_1.duration_ = var_9_7 + var_9_5
			end

			if var_9_5 < arg_6_1.time_ and arg_6_1.time_ <= var_9_5 + arg_9_0 then
				local var_9_9 = "play"
				local var_9_10 = "voice"

				arg_6_1:AudioAction(var_9_9, var_9_10, "story_v_out_319631", "319631002", "story_v_out_319631.awb")
			end

			local var_9_11 = 0

			if var_9_11 < arg_6_1.time_ and arg_6_1.time_ <= var_9_11 + arg_9_0 then
				arg_6_1.fswbg_:SetActive(true)
				arg_6_1.dialog_:SetActive(false)

				arg_6_1.fswtw_.percent = 0

				local var_9_12 = arg_6_1:GetWordFromCfg(319631002)
				local var_9_13 = arg_6_1:FormatText(var_9_12.content)

				arg_6_1.fswt_.text = var_9_13

				LuaForUtil.ClearLinePrefixSymbol(arg_6_1.fswt_)

				arg_6_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_6_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_6_1.fswtw_:SetDirty()

				arg_6_1.typewritterCharCountI18N = 0

				SetActive(arg_6_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_6_1:ShowNextGo(false)
			end

			local var_9_14 = 0.2

			if var_9_14 < arg_6_1.time_ and arg_6_1.time_ <= var_9_14 + arg_9_0 then
				arg_6_1.var_.oldValueTypewriter = arg_6_1.fswtw_.percent

				SetActive(arg_6_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_6_1:ShowNextGo(false)
			end

			local var_9_15 = 23
			local var_9_16 = 1.53333333333333
			local var_9_17 = arg_6_1:GetWordFromCfg(319631002)
			local var_9_18 = arg_6_1:FormatText(var_9_17.content)
			local var_9_19, var_9_20 = arg_6_1:GetPercentByPara(var_9_18, 1)

			if var_9_14 < arg_6_1.time_ and arg_6_1.time_ <= var_9_14 + arg_9_0 then
				arg_6_1.talkMaxDuration = 0

				local var_9_21 = var_9_15 <= 0 and var_9_16 or var_9_16 * ((var_9_20 - arg_6_1.typewritterCharCountI18N) / var_9_15)

				if var_9_21 > 0 and var_9_16 < var_9_21 then
					arg_6_1.talkMaxDuration = var_9_21

					if var_9_21 + var_9_14 > arg_6_1.duration_ then
						arg_6_1.duration_ = var_9_21 + var_9_14
					end
				end
			end

			local var_9_22 = 1.53333333333333
			local var_9_23 = math.max(var_9_22, arg_6_1.talkMaxDuration)

			if var_9_14 <= arg_6_1.time_ and arg_6_1.time_ < var_9_14 + var_9_23 then
				local var_9_24 = (arg_6_1.time_ - var_9_14) / var_9_23

				arg_6_1.fswtw_.percent = Mathf.Lerp(arg_6_1.var_.oldValueTypewriter, var_9_19, var_9_24)
				arg_6_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_6_1.fswtw_:SetDirty()
			end

			if arg_6_1.time_ >= var_9_14 + var_9_23 and arg_6_1.time_ < var_9_14 + var_9_23 + arg_9_0 then
				arg_6_1.fswtw_.percent = var_9_19

				arg_6_1.fswtw_:SetDirty()
				arg_6_1:ShowNextGo(true)

				arg_6_1.typewritterCharCountI18N = var_9_20
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
			local var_13_0 = 0

			if var_13_0 < arg_10_1.time_ and arg_10_1.time_ <= var_13_0 + arg_13_0 then
				arg_10_1.fswbg_:SetActive(true)
				arg_10_1.dialog_:SetActive(false)

				arg_10_1.fswtw_.percent = 0

				local var_13_1 = arg_10_1:GetWordFromCfg(319631003)
				local var_13_2 = arg_10_1:FormatText(var_13_1.content)

				arg_10_1.fswt_.text = var_13_2

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.fswt_)

				arg_10_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_10_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_10_1.fswtw_:SetDirty()

				arg_10_1.typewritterCharCountI18N = 0

				SetActive(arg_10_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_10_1:ShowNextGo(false)
			end

			local var_13_3 = 0.2

			if var_13_3 < arg_10_1.time_ and arg_10_1.time_ <= var_13_3 + arg_13_0 then
				arg_10_1.var_.oldValueTypewriter = arg_10_1.fswtw_.percent

				SetActive(arg_10_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_10_1:ShowNextGo(false)
			end

			local var_13_4 = 12
			local var_13_5 = 0.8
			local var_13_6 = arg_10_1:GetWordFromCfg(319631003)
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

			local var_13_11 = 0.8
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

			local var_13_14 = 0
			local var_13_15 = 2.566
			local var_13_16 = manager.audio:GetVoiceLength("story_v_out_319631", "319631003", "story_v_out_319631.awb") / 1000

			if var_13_16 > 0 and var_13_15 < var_13_16 and var_13_16 + var_13_14 > arg_10_1.duration_ then
				local var_13_17 = var_13_16

				arg_10_1.duration_ = var_13_16 + var_13_14
			end

			if var_13_14 < arg_10_1.time_ and arg_10_1.time_ <= var_13_14 + arg_13_0 then
				local var_13_18 = "play"
				local var_13_19 = "voice"

				arg_10_1:AudioAction(var_13_18, var_13_19, "story_v_out_319631", "319631003", "story_v_out_319631.awb")
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
			local var_17_0 = 0

			if var_17_0 < arg_14_1.time_ and arg_14_1.time_ <= var_17_0 + arg_17_0 then
				arg_14_1.fswbg_:SetActive(true)
				arg_14_1.dialog_:SetActive(false)

				arg_14_1.fswtw_.percent = 0

				local var_17_1 = arg_14_1:GetWordFromCfg(319631004)
				local var_17_2 = arg_14_1:FormatText(var_17_1.content)

				arg_14_1.fswt_.text = var_17_2

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.fswt_)

				arg_14_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_14_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_14_1.fswtw_:SetDirty()

				arg_14_1.typewritterCharCountI18N = 0

				SetActive(arg_14_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_14_1:ShowNextGo(false)
			end

			local var_17_3 = 0.2

			if var_17_3 < arg_14_1.time_ and arg_14_1.time_ <= var_17_3 + arg_17_0 then
				arg_14_1.var_.oldValueTypewriter = arg_14_1.fswtw_.percent

				SetActive(arg_14_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_14_1:ShowNextGo(false)
			end

			local var_17_4 = 19
			local var_17_5 = 0.933333333333333
			local var_17_6 = arg_14_1:GetWordFromCfg(319631004)
			local var_17_7 = arg_14_1:FormatText(var_17_6.content)
			local var_17_8, var_17_9 = arg_14_1:GetPercentByPara(var_17_7, 1)

			if var_17_3 < arg_14_1.time_ and arg_14_1.time_ <= var_17_3 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0

				local var_17_10 = var_17_4 <= 0 and var_17_5 or var_17_5 * ((var_17_9 - arg_14_1.typewritterCharCountI18N) / var_17_4)

				if var_17_10 > 0 and var_17_5 < var_17_10 then
					arg_14_1.talkMaxDuration = var_17_10

					if var_17_10 + var_17_3 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_10 + var_17_3
					end
				end
			end

			local var_17_11 = 0.933333333333333
			local var_17_12 = math.max(var_17_11, arg_14_1.talkMaxDuration)

			if var_17_3 <= arg_14_1.time_ and arg_14_1.time_ < var_17_3 + var_17_12 then
				local var_17_13 = (arg_14_1.time_ - var_17_3) / var_17_12

				arg_14_1.fswtw_.percent = Mathf.Lerp(arg_14_1.var_.oldValueTypewriter, var_17_8, var_17_13)
				arg_14_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_14_1.fswtw_:SetDirty()
			end

			if arg_14_1.time_ >= var_17_3 + var_17_12 and arg_14_1.time_ < var_17_3 + var_17_12 + arg_17_0 then
				arg_14_1.fswtw_.percent = var_17_8

				arg_14_1.fswtw_:SetDirty()
				arg_14_1:ShowNextGo(true)

				arg_14_1.typewritterCharCountI18N = var_17_9
			end

			local var_17_14 = 0
			local var_17_15 = 4.966
			local var_17_16 = manager.audio:GetVoiceLength("story_v_out_319631", "319631004", "story_v_out_319631.awb") / 1000

			if var_17_16 > 0 and var_17_15 < var_17_16 and var_17_16 + var_17_14 > arg_14_1.duration_ then
				local var_17_17 = var_17_16

				arg_14_1.duration_ = var_17_16 + var_17_14
			end

			if var_17_14 < arg_14_1.time_ and arg_14_1.time_ <= var_17_14 + arg_17_0 then
				local var_17_18 = "play"
				local var_17_19 = "voice"

				arg_14_1:AudioAction(var_17_18, var_17_19, "story_v_out_319631", "319631004", "story_v_out_319631.awb")
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
			local var_21_0 = 0

			if var_21_0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_0 + arg_21_0 then
				arg_18_1.fswbg_:SetActive(true)
				arg_18_1.dialog_:SetActive(false)

				arg_18_1.fswtw_.percent = 0

				local var_21_1 = arg_18_1:GetWordFromCfg(319631005)
				local var_21_2 = arg_18_1:FormatText(var_21_1.content)

				arg_18_1.fswt_.text = var_21_2

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.fswt_)

				arg_18_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_18_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_18_1.fswtw_:SetDirty()

				arg_18_1.typewritterCharCountI18N = 0

				SetActive(arg_18_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_18_1:ShowNextGo(false)
			end

			local var_21_3 = 0.2

			if var_21_3 < arg_18_1.time_ and arg_18_1.time_ <= var_21_3 + arg_21_0 then
				arg_18_1.var_.oldValueTypewriter = arg_18_1.fswtw_.percent

				SetActive(arg_18_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_18_1:ShowNextGo(false)
			end

			local var_21_4 = 4
			local var_21_5 = 0.266666666666667
			local var_21_6 = arg_18_1:GetWordFromCfg(319631005)
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

			local var_21_11 = 0.266666666666667
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

			local var_21_14 = 0
			local var_21_15 = 1.266
			local var_21_16 = manager.audio:GetVoiceLength("story_v_out_319631", "319631005", "story_v_out_319631.awb") / 1000

			if var_21_16 > 0 and var_21_15 < var_21_16 and var_21_16 + var_21_14 > arg_18_1.duration_ then
				local var_21_17 = var_21_16

				arg_18_1.duration_ = var_21_16 + var_21_14
			end

			if var_21_14 < arg_18_1.time_ and arg_18_1.time_ <= var_21_14 + arg_21_0 then
				local var_21_18 = "play"
				local var_21_19 = "voice"

				arg_18_1:AudioAction(var_21_18, var_21_19, "story_v_out_319631", "319631005", "story_v_out_319631.awb")
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
			local var_25_0 = "Z03f"

			if arg_22_1.bgs_[var_25_0] == nil then
				local var_25_1 = Object.Instantiate(arg_22_1.paintGo_)

				var_25_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_25_0)
				var_25_1.name = var_25_0
				var_25_1.transform.parent = arg_22_1.stage_.transform
				var_25_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_22_1.bgs_[var_25_0] = var_25_1
			end

			local var_25_2 = 0

			if var_25_2 < arg_22_1.time_ and arg_22_1.time_ <= var_25_2 + arg_25_0 then
				local var_25_3 = manager.ui.mainCamera.transform.localPosition
				local var_25_4 = Vector3.New(0, 0, 10) + Vector3.New(var_25_3.x, var_25_3.y, 0)
				local var_25_5 = arg_22_1.bgs_.Z03f

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
					if iter_25_0 ~= "Z03f" then
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

			local var_25_19 = 0.2

			if var_25_18 <= arg_22_1.time_ and arg_22_1.time_ < var_25_18 + var_25_19 then
				local var_25_20 = (arg_22_1.time_ - var_25_18) / var_25_19
				local var_25_21 = Color.New(0, 0, 0)

				var_25_21.a = Mathf.Lerp(1, 0, var_25_20)
				arg_22_1.mask_.color = var_25_21
			end

			if arg_22_1.time_ >= var_25_18 + var_25_19 and arg_22_1.time_ < var_25_18 + var_25_19 + arg_25_0 then
				local var_25_22 = Color.New(0, 0, 0)
				local var_25_23 = 0

				arg_22_1.mask_.enabled = false
				var_25_22.a = var_25_23
				arg_22_1.mask_.color = var_25_22
			end

			local var_25_24 = 0
			local var_25_25 = 0.2

			if var_25_24 < arg_22_1.time_ and arg_22_1.time_ <= var_25_24 + arg_25_0 then
				local var_25_26 = "play"
				local var_25_27 = "music"

				arg_22_1:AudioAction(var_25_26, var_25_27, "ui_battle", "ui_battle_stopbgm", "")

				local var_25_28 = ""
				local var_25_29 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_25_29 ~= "" then
					if arg_22_1.bgmTxt_.text ~= var_25_29 and arg_22_1.bgmTxt_.text ~= "" then
						if arg_22_1.bgmTxt2_.text ~= "" then
							arg_22_1.bgmTxt_.text = arg_22_1.bgmTxt2_.text
						end

						arg_22_1.bgmTxt2_.text = var_25_29

						arg_22_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_22_1.bgmTxt_.text = var_25_29
						arg_22_1.bgmTxt2_.text = var_25_29
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

			local var_25_30 = 0.233333333333333
			local var_25_31 = 1

			if var_25_30 < arg_22_1.time_ and arg_22_1.time_ <= var_25_30 + arg_25_0 then
				local var_25_32 = "play"
				local var_25_33 = "music"

				arg_22_1:AudioAction(var_25_32, var_25_33, "bgm_activity_1_6_story_intense", "bgm_activity_1_6_story_intense", "bgm_activity_1_6_story_intense.awb")

				local var_25_34 = ""
				local var_25_35 = manager.audio:GetAudioName("bgm_activity_1_6_story_intense", "bgm_activity_1_6_story_intense")

				if var_25_35 ~= "" then
					if arg_22_1.bgmTxt_.text ~= var_25_35 and arg_22_1.bgmTxt_.text ~= "" then
						if arg_22_1.bgmTxt2_.text ~= "" then
							arg_22_1.bgmTxt_.text = arg_22_1.bgmTxt2_.text
						end

						arg_22_1.bgmTxt2_.text = var_25_35

						arg_22_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_22_1.bgmTxt_.text = var_25_35
						arg_22_1.bgmTxt2_.text = var_25_35
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

			local var_25_36 = 0

			if var_25_36 < arg_22_1.time_ and arg_22_1.time_ <= var_25_36 + arg_25_0 then
				arg_22_1.fswbg_:SetActive(false)
				arg_22_1.dialog_:SetActive(false)
				SetActive(arg_22_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_22_1:ShowNextGo(false)
			end

			local var_25_37 = 0.2

			if var_25_37 < arg_22_1.time_ and arg_22_1.time_ <= var_25_37 + arg_25_0 then
				arg_22_1.fswbg_:SetActive(false)
				arg_22_1.dialog_:SetActive(false)
				SetActive(arg_22_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_22_1:ShowNextGo(false)
			end

			local var_25_38 = 0

			if var_25_38 < arg_22_1.time_ and arg_22_1.time_ <= var_25_38 + arg_25_0 then
				arg_22_1.cswbg_:SetActive(false)
			end

			if arg_22_1.frameCnt_ <= 1 then
				arg_22_1.dialog_:SetActive(false)
			end

			local var_25_39 = 1.075
			local var_25_40 = 0.925

			if var_25_39 < arg_22_1.time_ and arg_22_1.time_ <= var_25_39 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0

				arg_22_1.dialog_:SetActive(true)

				arg_22_1.dialogCg_.alpha = 0

				local var_25_41 = LeanTween.value(arg_22_1.dialog_, 0, 1, 0.3)

				var_25_41:setOnUpdate(LuaHelper.FloatAction(function(arg_28_0)
					arg_22_1.dialogCg_.alpha = arg_28_0
				end))
				var_25_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_22_1.dialog_)
					var_25_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_22_1.duration_ = arg_22_1.duration_ + 0.3

				SetActive(arg_22_1.leftNameGo_, false)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_42 = arg_22_1:GetWordFromCfg(319631006)
				local var_25_43 = arg_22_1:FormatText(var_25_42.content)

				arg_22_1.text_.text = var_25_43

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_44 = 37
				local var_25_45 = utf8.len(var_25_43)
				local var_25_46 = var_25_44 <= 0 and var_25_40 or var_25_40 * (var_25_45 / var_25_44)

				if var_25_46 > 0 and var_25_40 < var_25_46 then
					arg_22_1.talkMaxDuration = var_25_46
					var_25_39 = var_25_39 + 0.3

					if var_25_46 + var_25_39 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_46 + var_25_39
					end
				end

				arg_22_1.text_.text = var_25_43
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)
				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_47 = var_25_39 + 0.3
			local var_25_48 = math.max(var_25_40, arg_22_1.talkMaxDuration)

			if var_25_47 <= arg_22_1.time_ and arg_22_1.time_ < var_25_47 + var_25_48 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_47) / var_25_48

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_47 + var_25_48 and arg_22_1.time_ < var_25_47 + var_25_48 + arg_25_0 then
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
			local var_33_0 = 0
			local var_33_1 = 1.075

			if var_33_0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_0 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, false)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_2 = arg_30_1:GetWordFromCfg(319631007)
				local var_33_3 = arg_30_1:FormatText(var_33_2.content)

				arg_30_1.text_.text = var_33_3

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_4 = 43
				local var_33_5 = utf8.len(var_33_3)
				local var_33_6 = var_33_4 <= 0 and var_33_1 or var_33_1 * (var_33_5 / var_33_4)

				if var_33_6 > 0 and var_33_1 < var_33_6 then
					arg_30_1.talkMaxDuration = var_33_6

					if var_33_6 + var_33_0 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_6 + var_33_0
					end
				end

				arg_30_1.text_.text = var_33_3
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)
				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_7 = math.max(var_33_1, arg_30_1.talkMaxDuration)

			if var_33_0 <= arg_30_1.time_ and arg_30_1.time_ < var_33_0 + var_33_7 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_0) / var_33_7

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_0 + var_33_7 and arg_30_1.time_ < var_33_0 + var_33_7 + arg_33_0 then
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
			local var_37_0 = "10079ui_story"

			if arg_34_1.actors_[var_37_0] == nil then
				local var_37_1 = Asset.Load("Char/" .. "10079ui_story")

				if not isNil(var_37_1) then
					local var_37_2 = Object.Instantiate(Asset.Load("Char/" .. "10079ui_story"), arg_34_1.stage_.transform)

					var_37_2.name = var_37_0
					var_37_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_34_1.actors_[var_37_0] = var_37_2

					local var_37_3 = var_37_2:GetComponentInChildren(typeof(CharacterEffect))

					var_37_3.enabled = true

					local var_37_4 = GameObjectTools.GetOrAddComponent(var_37_2, typeof(DynamicBoneHelper))

					if var_37_4 then
						var_37_4:EnableDynamicBone(false)
					end

					arg_34_1:ShowWeapon(var_37_3.transform, false)

					arg_34_1.var_[var_37_0 .. "Animator"] = var_37_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_34_1.var_[var_37_0 .. "Animator"].applyRootMotion = true
					arg_34_1.var_[var_37_0 .. "LipSync"] = var_37_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_37_5 = arg_34_1.actors_["10079ui_story"].transform
			local var_37_6 = 0

			if var_37_6 < arg_34_1.time_ and arg_34_1.time_ <= var_37_6 + arg_37_0 then
				arg_34_1.var_.moveOldPos10079ui_story = var_37_5.localPosition

				local var_37_7 = "10079ui_story"

				arg_34_1:ShowWeapon(arg_34_1.var_[var_37_7 .. "Animator"].transform, false)
			end

			local var_37_8 = 0.001

			if var_37_6 <= arg_34_1.time_ and arg_34_1.time_ < var_37_6 + var_37_8 then
				local var_37_9 = (arg_34_1.time_ - var_37_6) / var_37_8
				local var_37_10 = Vector3.New(0, -0.95, -6.05)

				var_37_5.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPos10079ui_story, var_37_10, var_37_9)

				local var_37_11 = manager.ui.mainCamera.transform.position - var_37_5.position

				var_37_5.forward = Vector3.New(var_37_11.x, var_37_11.y, var_37_11.z)

				local var_37_12 = var_37_5.localEulerAngles

				var_37_12.z = 0
				var_37_12.x = 0
				var_37_5.localEulerAngles = var_37_12
			end

			if arg_34_1.time_ >= var_37_6 + var_37_8 and arg_34_1.time_ < var_37_6 + var_37_8 + arg_37_0 then
				var_37_5.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_37_13 = manager.ui.mainCamera.transform.position - var_37_5.position

				var_37_5.forward = Vector3.New(var_37_13.x, var_37_13.y, var_37_13.z)

				local var_37_14 = var_37_5.localEulerAngles

				var_37_14.z = 0
				var_37_14.x = 0
				var_37_5.localEulerAngles = var_37_14
			end

			local var_37_15 = arg_34_1.actors_["10079ui_story"]
			local var_37_16 = 0

			if var_37_16 < arg_34_1.time_ and arg_34_1.time_ <= var_37_16 + arg_37_0 and not isNil(var_37_15) and arg_34_1.var_.characterEffect10079ui_story == nil then
				arg_34_1.var_.characterEffect10079ui_story = var_37_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_17 = 0.200000002980232

			if var_37_16 <= arg_34_1.time_ and arg_34_1.time_ < var_37_16 + var_37_17 and not isNil(var_37_15) then
				local var_37_18 = (arg_34_1.time_ - var_37_16) / var_37_17

				if arg_34_1.var_.characterEffect10079ui_story and not isNil(var_37_15) then
					arg_34_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_34_1.time_ >= var_37_16 + var_37_17 and arg_34_1.time_ < var_37_16 + var_37_17 + arg_37_0 and not isNil(var_37_15) and arg_34_1.var_.characterEffect10079ui_story then
				arg_34_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_37_19 = 0

			if var_37_19 < arg_34_1.time_ and arg_34_1.time_ <= var_37_19 + arg_37_0 then
				arg_34_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_37_20 = 0

			if var_37_20 < arg_34_1.time_ and arg_34_1.time_ <= var_37_20 + arg_37_0 then
				arg_34_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_37_21 = 0
			local var_37_22 = 0.3

			if var_37_21 < arg_34_1.time_ and arg_34_1.time_ <= var_37_21 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				local var_37_23 = arg_34_1:FormatText(StoryNameCfg[6].name)

				arg_34_1.leftNameTxt_.text = var_37_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_24 = arg_34_1:GetWordFromCfg(319631008)
				local var_37_25 = arg_34_1:FormatText(var_37_24.content)

				arg_34_1.text_.text = var_37_25

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_26 = 12
				local var_37_27 = utf8.len(var_37_25)
				local var_37_28 = var_37_26 <= 0 and var_37_22 or var_37_22 * (var_37_27 / var_37_26)

				if var_37_28 > 0 and var_37_22 < var_37_28 then
					arg_34_1.talkMaxDuration = var_37_28

					if var_37_28 + var_37_21 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_28 + var_37_21
					end
				end

				arg_34_1.text_.text = var_37_25
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631008", "story_v_out_319631.awb") ~= 0 then
					local var_37_29 = manager.audio:GetVoiceLength("story_v_out_319631", "319631008", "story_v_out_319631.awb") / 1000

					if var_37_29 + var_37_21 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_29 + var_37_21
					end

					if var_37_24.prefab_name ~= "" and arg_34_1.actors_[var_37_24.prefab_name] ~= nil then
						local var_37_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_24.prefab_name].transform, "story_v_out_319631", "319631008", "story_v_out_319631.awb")

						arg_34_1:RecordAudio("319631008", var_37_30)
						arg_34_1:RecordAudio("319631008", var_37_30)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_319631", "319631008", "story_v_out_319631.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_319631", "319631008", "story_v_out_319631.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_31 = math.max(var_37_22, arg_34_1.talkMaxDuration)

			if var_37_21 <= arg_34_1.time_ and arg_34_1.time_ < var_37_21 + var_37_31 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_21) / var_37_31

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_21 + var_37_31 and arg_34_1.time_ < var_37_21 + var_37_31 + arg_37_0 then
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
			local var_41_0 = 0
			local var_41_1 = 0.4

			if var_41_0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_0 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				local var_41_2 = arg_38_1:FormatText(StoryNameCfg[6].name)

				arg_38_1.leftNameTxt_.text = var_41_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_3 = arg_38_1:GetWordFromCfg(319631009)
				local var_41_4 = arg_38_1:FormatText(var_41_3.content)

				arg_38_1.text_.text = var_41_4

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_5 = 16
				local var_41_6 = utf8.len(var_41_4)
				local var_41_7 = var_41_5 <= 0 and var_41_1 or var_41_1 * (var_41_6 / var_41_5)

				if var_41_7 > 0 and var_41_1 < var_41_7 then
					arg_38_1.talkMaxDuration = var_41_7

					if var_41_7 + var_41_0 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_7 + var_41_0
					end
				end

				arg_38_1.text_.text = var_41_4
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631009", "story_v_out_319631.awb") ~= 0 then
					local var_41_8 = manager.audio:GetVoiceLength("story_v_out_319631", "319631009", "story_v_out_319631.awb") / 1000

					if var_41_8 + var_41_0 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_8 + var_41_0
					end

					if var_41_3.prefab_name ~= "" and arg_38_1.actors_[var_41_3.prefab_name] ~= nil then
						local var_41_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_3.prefab_name].transform, "story_v_out_319631", "319631009", "story_v_out_319631.awb")

						arg_38_1:RecordAudio("319631009", var_41_9)
						arg_38_1:RecordAudio("319631009", var_41_9)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_319631", "319631009", "story_v_out_319631.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_319631", "319631009", "story_v_out_319631.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_10 = math.max(var_41_1, arg_38_1.talkMaxDuration)

			if var_41_0 <= arg_38_1.time_ and arg_38_1.time_ < var_41_0 + var_41_10 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_0) / var_41_10

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_0 + var_41_10 and arg_38_1.time_ < var_41_0 + var_41_10 + arg_41_0 then
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
			local var_45_0 = "1095ui_story"

			if arg_42_1.actors_[var_45_0] == nil then
				local var_45_1 = Asset.Load("Char/" .. "1095ui_story")

				if not isNil(var_45_1) then
					local var_45_2 = Object.Instantiate(Asset.Load("Char/" .. "1095ui_story"), arg_42_1.stage_.transform)

					var_45_2.name = var_45_0
					var_45_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_42_1.actors_[var_45_0] = var_45_2

					local var_45_3 = var_45_2:GetComponentInChildren(typeof(CharacterEffect))

					var_45_3.enabled = true

					local var_45_4 = GameObjectTools.GetOrAddComponent(var_45_2, typeof(DynamicBoneHelper))

					if var_45_4 then
						var_45_4:EnableDynamicBone(false)
					end

					arg_42_1:ShowWeapon(var_45_3.transform, false)

					arg_42_1.var_[var_45_0 .. "Animator"] = var_45_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_42_1.var_[var_45_0 .. "Animator"].applyRootMotion = true
					arg_42_1.var_[var_45_0 .. "LipSync"] = var_45_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_45_5 = arg_42_1.actors_["1095ui_story"].transform
			local var_45_6 = 0

			if var_45_6 < arg_42_1.time_ and arg_42_1.time_ <= var_45_6 + arg_45_0 then
				arg_42_1.var_.moveOldPos1095ui_story = var_45_5.localPosition
			end

			local var_45_7 = 0.001

			if var_45_6 <= arg_42_1.time_ and arg_42_1.time_ < var_45_6 + var_45_7 then
				local var_45_8 = (arg_42_1.time_ - var_45_6) / var_45_7
				local var_45_9 = Vector3.New(0.7, -0.98, -6.1)

				var_45_5.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos1095ui_story, var_45_9, var_45_8)

				local var_45_10 = manager.ui.mainCamera.transform.position - var_45_5.position

				var_45_5.forward = Vector3.New(var_45_10.x, var_45_10.y, var_45_10.z)

				local var_45_11 = var_45_5.localEulerAngles

				var_45_11.z = 0
				var_45_11.x = 0
				var_45_5.localEulerAngles = var_45_11
			end

			if arg_42_1.time_ >= var_45_6 + var_45_7 and arg_42_1.time_ < var_45_6 + var_45_7 + arg_45_0 then
				var_45_5.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_45_12 = manager.ui.mainCamera.transform.position - var_45_5.position

				var_45_5.forward = Vector3.New(var_45_12.x, var_45_12.y, var_45_12.z)

				local var_45_13 = var_45_5.localEulerAngles

				var_45_13.z = 0
				var_45_13.x = 0
				var_45_5.localEulerAngles = var_45_13
			end

			local var_45_14 = arg_42_1.actors_["1095ui_story"]
			local var_45_15 = 0

			if var_45_15 < arg_42_1.time_ and arg_42_1.time_ <= var_45_15 + arg_45_0 and not isNil(var_45_14) and arg_42_1.var_.characterEffect1095ui_story == nil then
				arg_42_1.var_.characterEffect1095ui_story = var_45_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_16 = 0.200000002980232

			if var_45_15 <= arg_42_1.time_ and arg_42_1.time_ < var_45_15 + var_45_16 and not isNil(var_45_14) then
				local var_45_17 = (arg_42_1.time_ - var_45_15) / var_45_16

				if arg_42_1.var_.characterEffect1095ui_story and not isNil(var_45_14) then
					arg_42_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_42_1.time_ >= var_45_15 + var_45_16 and arg_42_1.time_ < var_45_15 + var_45_16 + arg_45_0 and not isNil(var_45_14) and arg_42_1.var_.characterEffect1095ui_story then
				arg_42_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_45_18 = 0

			if var_45_18 < arg_42_1.time_ and arg_42_1.time_ <= var_45_18 + arg_45_0 then
				arg_42_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_45_19 = 0

			if var_45_19 < arg_42_1.time_ and arg_42_1.time_ <= var_45_19 + arg_45_0 then
				arg_42_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_45_20 = arg_42_1.actors_["10079ui_story"].transform
			local var_45_21 = 0

			if var_45_21 < arg_42_1.time_ and arg_42_1.time_ <= var_45_21 + arg_45_0 then
				arg_42_1.var_.moveOldPos10079ui_story = var_45_20.localPosition
			end

			local var_45_22 = 0.001

			if var_45_21 <= arg_42_1.time_ and arg_42_1.time_ < var_45_21 + var_45_22 then
				local var_45_23 = (arg_42_1.time_ - var_45_21) / var_45_22
				local var_45_24 = Vector3.New(-0.7, -0.95, -6.05)

				var_45_20.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos10079ui_story, var_45_24, var_45_23)

				local var_45_25 = manager.ui.mainCamera.transform.position - var_45_20.position

				var_45_20.forward = Vector3.New(var_45_25.x, var_45_25.y, var_45_25.z)

				local var_45_26 = var_45_20.localEulerAngles

				var_45_26.z = 0
				var_45_26.x = 0
				var_45_20.localEulerAngles = var_45_26
			end

			if arg_42_1.time_ >= var_45_21 + var_45_22 and arg_42_1.time_ < var_45_21 + var_45_22 + arg_45_0 then
				var_45_20.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_45_27 = manager.ui.mainCamera.transform.position - var_45_20.position

				var_45_20.forward = Vector3.New(var_45_27.x, var_45_27.y, var_45_27.z)

				local var_45_28 = var_45_20.localEulerAngles

				var_45_28.z = 0
				var_45_28.x = 0
				var_45_20.localEulerAngles = var_45_28
			end

			local var_45_29 = arg_42_1.actors_["10079ui_story"]
			local var_45_30 = 0

			if var_45_30 < arg_42_1.time_ and arg_42_1.time_ <= var_45_30 + arg_45_0 and not isNil(var_45_29) and arg_42_1.var_.characterEffect10079ui_story == nil then
				arg_42_1.var_.characterEffect10079ui_story = var_45_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_31 = 0.200000002980232

			if var_45_30 <= arg_42_1.time_ and arg_42_1.time_ < var_45_30 + var_45_31 and not isNil(var_45_29) then
				local var_45_32 = (arg_42_1.time_ - var_45_30) / var_45_31

				if arg_42_1.var_.characterEffect10079ui_story and not isNil(var_45_29) then
					local var_45_33 = Mathf.Lerp(0, 0.5, var_45_32)

					arg_42_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_42_1.var_.characterEffect10079ui_story.fillRatio = var_45_33
				end
			end

			if arg_42_1.time_ >= var_45_30 + var_45_31 and arg_42_1.time_ < var_45_30 + var_45_31 + arg_45_0 and not isNil(var_45_29) and arg_42_1.var_.characterEffect10079ui_story then
				local var_45_34 = 0.5

				arg_42_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_42_1.var_.characterEffect10079ui_story.fillRatio = var_45_34
			end

			local var_45_35 = 0
			local var_45_36 = 0.4

			if var_45_35 < arg_42_1.time_ and arg_42_1.time_ <= var_45_35 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				local var_45_37 = arg_42_1:FormatText(StoryNameCfg[471].name)

				arg_42_1.leftNameTxt_.text = var_45_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_38 = arg_42_1:GetWordFromCfg(319631010)
				local var_45_39 = arg_42_1:FormatText(var_45_38.content)

				arg_42_1.text_.text = var_45_39

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_40 = 16
				local var_45_41 = utf8.len(var_45_39)
				local var_45_42 = var_45_40 <= 0 and var_45_36 or var_45_36 * (var_45_41 / var_45_40)

				if var_45_42 > 0 and var_45_36 < var_45_42 then
					arg_42_1.talkMaxDuration = var_45_42

					if var_45_42 + var_45_35 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_42 + var_45_35
					end
				end

				arg_42_1.text_.text = var_45_39
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631010", "story_v_out_319631.awb") ~= 0 then
					local var_45_43 = manager.audio:GetVoiceLength("story_v_out_319631", "319631010", "story_v_out_319631.awb") / 1000

					if var_45_43 + var_45_35 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_43 + var_45_35
					end

					if var_45_38.prefab_name ~= "" and arg_42_1.actors_[var_45_38.prefab_name] ~= nil then
						local var_45_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_38.prefab_name].transform, "story_v_out_319631", "319631010", "story_v_out_319631.awb")

						arg_42_1:RecordAudio("319631010", var_45_44)
						arg_42_1:RecordAudio("319631010", var_45_44)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_319631", "319631010", "story_v_out_319631.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_319631", "319631010", "story_v_out_319631.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_45 = math.max(var_45_36, arg_42_1.talkMaxDuration)

			if var_45_35 <= arg_42_1.time_ and arg_42_1.time_ < var_45_35 + var_45_45 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_35) / var_45_45

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_35 + var_45_45 and arg_42_1.time_ < var_45_35 + var_45_45 + arg_45_0 then
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
			local var_49_0 = arg_46_1.actors_["1095ui_story"]
			local var_49_1 = 0

			if var_49_1 < arg_46_1.time_ and arg_46_1.time_ <= var_49_1 + arg_49_0 and not isNil(var_49_0) and arg_46_1.var_.characterEffect1095ui_story == nil then
				arg_46_1.var_.characterEffect1095ui_story = var_49_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_2 = 0.200000002980232

			if var_49_1 <= arg_46_1.time_ and arg_46_1.time_ < var_49_1 + var_49_2 and not isNil(var_49_0) then
				local var_49_3 = (arg_46_1.time_ - var_49_1) / var_49_2

				if arg_46_1.var_.characterEffect1095ui_story and not isNil(var_49_0) then
					local var_49_4 = Mathf.Lerp(0, 0.5, var_49_3)

					arg_46_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_46_1.var_.characterEffect1095ui_story.fillRatio = var_49_4
				end
			end

			if arg_46_1.time_ >= var_49_1 + var_49_2 and arg_46_1.time_ < var_49_1 + var_49_2 + arg_49_0 and not isNil(var_49_0) and arg_46_1.var_.characterEffect1095ui_story then
				local var_49_5 = 0.5

				arg_46_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_46_1.var_.characterEffect1095ui_story.fillRatio = var_49_5
			end

			local var_49_6 = 0
			local var_49_7 = 1.35

			if var_49_6 < arg_46_1.time_ and arg_46_1.time_ <= var_49_6 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, false)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_8 = arg_46_1:GetWordFromCfg(319631011)
				local var_49_9 = arg_46_1:FormatText(var_49_8.content)

				arg_46_1.text_.text = var_49_9

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_10 = 54
				local var_49_11 = utf8.len(var_49_9)
				local var_49_12 = var_49_10 <= 0 and var_49_7 or var_49_7 * (var_49_11 / var_49_10)

				if var_49_12 > 0 and var_49_7 < var_49_12 then
					arg_46_1.talkMaxDuration = var_49_12

					if var_49_12 + var_49_6 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_12 + var_49_6
					end
				end

				arg_46_1.text_.text = var_49_9
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)
				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_13 = math.max(var_49_7, arg_46_1.talkMaxDuration)

			if var_49_6 <= arg_46_1.time_ and arg_46_1.time_ < var_49_6 + var_49_13 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_6) / var_49_13

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_6 + var_49_13 and arg_46_1.time_ < var_49_6 + var_49_13 + arg_49_0 then
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
			local var_53_0 = arg_50_1.actors_["10079ui_story"].transform
			local var_53_1 = 0

			if var_53_1 < arg_50_1.time_ and arg_50_1.time_ <= var_53_1 + arg_53_0 then
				arg_50_1.var_.moveOldPos10079ui_story = var_53_0.localPosition
			end

			local var_53_2 = 0.001

			if var_53_1 <= arg_50_1.time_ and arg_50_1.time_ < var_53_1 + var_53_2 then
				local var_53_3 = (arg_50_1.time_ - var_53_1) / var_53_2
				local var_53_4 = Vector3.New(-0.7, -0.95, -6.05)

				var_53_0.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos10079ui_story, var_53_4, var_53_3)

				local var_53_5 = manager.ui.mainCamera.transform.position - var_53_0.position

				var_53_0.forward = Vector3.New(var_53_5.x, var_53_5.y, var_53_5.z)

				local var_53_6 = var_53_0.localEulerAngles

				var_53_6.z = 0
				var_53_6.x = 0
				var_53_0.localEulerAngles = var_53_6
			end

			if arg_50_1.time_ >= var_53_1 + var_53_2 and arg_50_1.time_ < var_53_1 + var_53_2 + arg_53_0 then
				var_53_0.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_53_7 = manager.ui.mainCamera.transform.position - var_53_0.position

				var_53_0.forward = Vector3.New(var_53_7.x, var_53_7.y, var_53_7.z)

				local var_53_8 = var_53_0.localEulerAngles

				var_53_8.z = 0
				var_53_8.x = 0
				var_53_0.localEulerAngles = var_53_8
			end

			local var_53_9 = arg_50_1.actors_["10079ui_story"]
			local var_53_10 = 0

			if var_53_10 < arg_50_1.time_ and arg_50_1.time_ <= var_53_10 + arg_53_0 and not isNil(var_53_9) and arg_50_1.var_.characterEffect10079ui_story == nil then
				arg_50_1.var_.characterEffect10079ui_story = var_53_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_11 = 0.200000002980232

			if var_53_10 <= arg_50_1.time_ and arg_50_1.time_ < var_53_10 + var_53_11 and not isNil(var_53_9) then
				local var_53_12 = (arg_50_1.time_ - var_53_10) / var_53_11

				if arg_50_1.var_.characterEffect10079ui_story and not isNil(var_53_9) then
					arg_50_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_50_1.time_ >= var_53_10 + var_53_11 and arg_50_1.time_ < var_53_10 + var_53_11 + arg_53_0 and not isNil(var_53_9) and arg_50_1.var_.characterEffect10079ui_story then
				arg_50_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_53_13 = 0

			if var_53_13 < arg_50_1.time_ and arg_50_1.time_ <= var_53_13 + arg_53_0 then
				arg_50_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_53_14 = 0
			local var_53_15 = 0.1

			if var_53_14 < arg_50_1.time_ and arg_50_1.time_ <= var_53_14 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				local var_53_16 = arg_50_1:FormatText(StoryNameCfg[6].name)

				arg_50_1.leftNameTxt_.text = var_53_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_17 = arg_50_1:GetWordFromCfg(319631012)
				local var_53_18 = arg_50_1:FormatText(var_53_17.content)

				arg_50_1.text_.text = var_53_18

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_19 = 4
				local var_53_20 = utf8.len(var_53_18)
				local var_53_21 = var_53_19 <= 0 and var_53_15 or var_53_15 * (var_53_20 / var_53_19)

				if var_53_21 > 0 and var_53_15 < var_53_21 then
					arg_50_1.talkMaxDuration = var_53_21

					if var_53_21 + var_53_14 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_21 + var_53_14
					end
				end

				arg_50_1.text_.text = var_53_18
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631012", "story_v_out_319631.awb") ~= 0 then
					local var_53_22 = manager.audio:GetVoiceLength("story_v_out_319631", "319631012", "story_v_out_319631.awb") / 1000

					if var_53_22 + var_53_14 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_22 + var_53_14
					end

					if var_53_17.prefab_name ~= "" and arg_50_1.actors_[var_53_17.prefab_name] ~= nil then
						local var_53_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_17.prefab_name].transform, "story_v_out_319631", "319631012", "story_v_out_319631.awb")

						arg_50_1:RecordAudio("319631012", var_53_23)
						arg_50_1:RecordAudio("319631012", var_53_23)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_319631", "319631012", "story_v_out_319631.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_319631", "319631012", "story_v_out_319631.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_24 = math.max(var_53_15, arg_50_1.talkMaxDuration)

			if var_53_14 <= arg_50_1.time_ and arg_50_1.time_ < var_53_14 + var_53_24 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_14) / var_53_24

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_14 + var_53_24 and arg_50_1.time_ < var_53_14 + var_53_24 + arg_53_0 then
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
			local var_57_0 = arg_54_1.actors_["1095ui_story"].transform
			local var_57_1 = 0

			if var_57_1 < arg_54_1.time_ and arg_54_1.time_ <= var_57_1 + arg_57_0 then
				arg_54_1.var_.moveOldPos1095ui_story = var_57_0.localPosition
			end

			local var_57_2 = 0.001

			if var_57_1 <= arg_54_1.time_ and arg_54_1.time_ < var_57_1 + var_57_2 then
				local var_57_3 = (arg_54_1.time_ - var_57_1) / var_57_2
				local var_57_4 = Vector3.New(0.7, -0.98, -6.1)

				var_57_0.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos1095ui_story, var_57_4, var_57_3)

				local var_57_5 = manager.ui.mainCamera.transform.position - var_57_0.position

				var_57_0.forward = Vector3.New(var_57_5.x, var_57_5.y, var_57_5.z)

				local var_57_6 = var_57_0.localEulerAngles

				var_57_6.z = 0
				var_57_6.x = 0
				var_57_0.localEulerAngles = var_57_6
			end

			if arg_54_1.time_ >= var_57_1 + var_57_2 and arg_54_1.time_ < var_57_1 + var_57_2 + arg_57_0 then
				var_57_0.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_57_7 = manager.ui.mainCamera.transform.position - var_57_0.position

				var_57_0.forward = Vector3.New(var_57_7.x, var_57_7.y, var_57_7.z)

				local var_57_8 = var_57_0.localEulerAngles

				var_57_8.z = 0
				var_57_8.x = 0
				var_57_0.localEulerAngles = var_57_8
			end

			local var_57_9 = arg_54_1.actors_["1095ui_story"]
			local var_57_10 = 0

			if var_57_10 < arg_54_1.time_ and arg_54_1.time_ <= var_57_10 + arg_57_0 and not isNil(var_57_9) and arg_54_1.var_.characterEffect1095ui_story == nil then
				arg_54_1.var_.characterEffect1095ui_story = var_57_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_11 = 0.200000002980232

			if var_57_10 <= arg_54_1.time_ and arg_54_1.time_ < var_57_10 + var_57_11 and not isNil(var_57_9) then
				local var_57_12 = (arg_54_1.time_ - var_57_10) / var_57_11

				if arg_54_1.var_.characterEffect1095ui_story and not isNil(var_57_9) then
					arg_54_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_54_1.time_ >= var_57_10 + var_57_11 and arg_54_1.time_ < var_57_10 + var_57_11 + arg_57_0 and not isNil(var_57_9) and arg_54_1.var_.characterEffect1095ui_story then
				arg_54_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_57_13 = 0

			if var_57_13 < arg_54_1.time_ and arg_54_1.time_ <= var_57_13 + arg_57_0 then
				arg_54_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_57_14 = 0

			if var_57_14 < arg_54_1.time_ and arg_54_1.time_ <= var_57_14 + arg_57_0 then
				arg_54_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_57_15 = arg_54_1.actors_["10079ui_story"]
			local var_57_16 = 0

			if var_57_16 < arg_54_1.time_ and arg_54_1.time_ <= var_57_16 + arg_57_0 and not isNil(var_57_15) and arg_54_1.var_.characterEffect10079ui_story == nil then
				arg_54_1.var_.characterEffect10079ui_story = var_57_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_17 = 0.200000002980232

			if var_57_16 <= arg_54_1.time_ and arg_54_1.time_ < var_57_16 + var_57_17 and not isNil(var_57_15) then
				local var_57_18 = (arg_54_1.time_ - var_57_16) / var_57_17

				if arg_54_1.var_.characterEffect10079ui_story and not isNil(var_57_15) then
					local var_57_19 = Mathf.Lerp(0, 0.5, var_57_18)

					arg_54_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_54_1.var_.characterEffect10079ui_story.fillRatio = var_57_19
				end
			end

			if arg_54_1.time_ >= var_57_16 + var_57_17 and arg_54_1.time_ < var_57_16 + var_57_17 + arg_57_0 and not isNil(var_57_15) and arg_54_1.var_.characterEffect10079ui_story then
				local var_57_20 = 0.5

				arg_54_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_54_1.var_.characterEffect10079ui_story.fillRatio = var_57_20
			end

			local var_57_21 = 0
			local var_57_22 = 0.45

			if var_57_21 < arg_54_1.time_ and arg_54_1.time_ <= var_57_21 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				local var_57_23 = arg_54_1:FormatText(StoryNameCfg[471].name)

				arg_54_1.leftNameTxt_.text = var_57_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_24 = arg_54_1:GetWordFromCfg(319631013)
				local var_57_25 = arg_54_1:FormatText(var_57_24.content)

				arg_54_1.text_.text = var_57_25

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_26 = 18
				local var_57_27 = utf8.len(var_57_25)
				local var_57_28 = var_57_26 <= 0 and var_57_22 or var_57_22 * (var_57_27 / var_57_26)

				if var_57_28 > 0 and var_57_22 < var_57_28 then
					arg_54_1.talkMaxDuration = var_57_28

					if var_57_28 + var_57_21 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_28 + var_57_21
					end
				end

				arg_54_1.text_.text = var_57_25
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631013", "story_v_out_319631.awb") ~= 0 then
					local var_57_29 = manager.audio:GetVoiceLength("story_v_out_319631", "319631013", "story_v_out_319631.awb") / 1000

					if var_57_29 + var_57_21 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_29 + var_57_21
					end

					if var_57_24.prefab_name ~= "" and arg_54_1.actors_[var_57_24.prefab_name] ~= nil then
						local var_57_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_24.prefab_name].transform, "story_v_out_319631", "319631013", "story_v_out_319631.awb")

						arg_54_1:RecordAudio("319631013", var_57_30)
						arg_54_1:RecordAudio("319631013", var_57_30)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_319631", "319631013", "story_v_out_319631.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_319631", "319631013", "story_v_out_319631.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_31 = math.max(var_57_22, arg_54_1.talkMaxDuration)

			if var_57_21 <= arg_54_1.time_ and arg_54_1.time_ < var_57_21 + var_57_31 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_21) / var_57_31

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_21 + var_57_31 and arg_54_1.time_ < var_57_21 + var_57_31 + arg_57_0 then
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
			local var_61_0 = arg_58_1.actors_["10079ui_story"].transform
			local var_61_1 = 0

			if var_61_1 < arg_58_1.time_ and arg_58_1.time_ <= var_61_1 + arg_61_0 then
				arg_58_1.var_.moveOldPos10079ui_story = var_61_0.localPosition
			end

			local var_61_2 = 0.001

			if var_61_1 <= arg_58_1.time_ and arg_58_1.time_ < var_61_1 + var_61_2 then
				local var_61_3 = (arg_58_1.time_ - var_61_1) / var_61_2
				local var_61_4 = Vector3.New(-0.7, -0.95, -6.05)

				var_61_0.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos10079ui_story, var_61_4, var_61_3)

				local var_61_5 = manager.ui.mainCamera.transform.position - var_61_0.position

				var_61_0.forward = Vector3.New(var_61_5.x, var_61_5.y, var_61_5.z)

				local var_61_6 = var_61_0.localEulerAngles

				var_61_6.z = 0
				var_61_6.x = 0
				var_61_0.localEulerAngles = var_61_6
			end

			if arg_58_1.time_ >= var_61_1 + var_61_2 and arg_58_1.time_ < var_61_1 + var_61_2 + arg_61_0 then
				var_61_0.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_61_7 = manager.ui.mainCamera.transform.position - var_61_0.position

				var_61_0.forward = Vector3.New(var_61_7.x, var_61_7.y, var_61_7.z)

				local var_61_8 = var_61_0.localEulerAngles

				var_61_8.z = 0
				var_61_8.x = 0
				var_61_0.localEulerAngles = var_61_8
			end

			local var_61_9 = arg_58_1.actors_["10079ui_story"]
			local var_61_10 = 0

			if var_61_10 < arg_58_1.time_ and arg_58_1.time_ <= var_61_10 + arg_61_0 and not isNil(var_61_9) and arg_58_1.var_.characterEffect10079ui_story == nil then
				arg_58_1.var_.characterEffect10079ui_story = var_61_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_11 = 0.200000002980232

			if var_61_10 <= arg_58_1.time_ and arg_58_1.time_ < var_61_10 + var_61_11 and not isNil(var_61_9) then
				local var_61_12 = (arg_58_1.time_ - var_61_10) / var_61_11

				if arg_58_1.var_.characterEffect10079ui_story and not isNil(var_61_9) then
					arg_58_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_58_1.time_ >= var_61_10 + var_61_11 and arg_58_1.time_ < var_61_10 + var_61_11 + arg_61_0 and not isNil(var_61_9) and arg_58_1.var_.characterEffect10079ui_story then
				arg_58_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_61_13 = 0

			if var_61_13 < arg_58_1.time_ and arg_58_1.time_ <= var_61_13 + arg_61_0 then
				arg_58_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_61_14 = arg_58_1.actors_["1095ui_story"]
			local var_61_15 = 0

			if var_61_15 < arg_58_1.time_ and arg_58_1.time_ <= var_61_15 + arg_61_0 and not isNil(var_61_14) and arg_58_1.var_.characterEffect1095ui_story == nil then
				arg_58_1.var_.characterEffect1095ui_story = var_61_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_16 = 0.200000002980232

			if var_61_15 <= arg_58_1.time_ and arg_58_1.time_ < var_61_15 + var_61_16 and not isNil(var_61_14) then
				local var_61_17 = (arg_58_1.time_ - var_61_15) / var_61_16

				if arg_58_1.var_.characterEffect1095ui_story and not isNil(var_61_14) then
					local var_61_18 = Mathf.Lerp(0, 0.5, var_61_17)

					arg_58_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_58_1.var_.characterEffect1095ui_story.fillRatio = var_61_18
				end
			end

			if arg_58_1.time_ >= var_61_15 + var_61_16 and arg_58_1.time_ < var_61_15 + var_61_16 + arg_61_0 and not isNil(var_61_14) and arg_58_1.var_.characterEffect1095ui_story then
				local var_61_19 = 0.5

				arg_58_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_58_1.var_.characterEffect1095ui_story.fillRatio = var_61_19
			end

			local var_61_20 = 0
			local var_61_21 = 0.175

			if var_61_20 < arg_58_1.time_ and arg_58_1.time_ <= var_61_20 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_22 = arg_58_1:FormatText(StoryNameCfg[6].name)

				arg_58_1.leftNameTxt_.text = var_61_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_23 = arg_58_1:GetWordFromCfg(319631014)
				local var_61_24 = arg_58_1:FormatText(var_61_23.content)

				arg_58_1.text_.text = var_61_24

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_25 = 7
				local var_61_26 = utf8.len(var_61_24)
				local var_61_27 = var_61_25 <= 0 and var_61_21 or var_61_21 * (var_61_26 / var_61_25)

				if var_61_27 > 0 and var_61_21 < var_61_27 then
					arg_58_1.talkMaxDuration = var_61_27

					if var_61_27 + var_61_20 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_27 + var_61_20
					end
				end

				arg_58_1.text_.text = var_61_24
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631014", "story_v_out_319631.awb") ~= 0 then
					local var_61_28 = manager.audio:GetVoiceLength("story_v_out_319631", "319631014", "story_v_out_319631.awb") / 1000

					if var_61_28 + var_61_20 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_28 + var_61_20
					end

					if var_61_23.prefab_name ~= "" and arg_58_1.actors_[var_61_23.prefab_name] ~= nil then
						local var_61_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_23.prefab_name].transform, "story_v_out_319631", "319631014", "story_v_out_319631.awb")

						arg_58_1:RecordAudio("319631014", var_61_29)
						arg_58_1:RecordAudio("319631014", var_61_29)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_319631", "319631014", "story_v_out_319631.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_319631", "319631014", "story_v_out_319631.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_30 = math.max(var_61_21, arg_58_1.talkMaxDuration)

			if var_61_20 <= arg_58_1.time_ and arg_58_1.time_ < var_61_20 + var_61_30 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_20) / var_61_30

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_20 + var_61_30 and arg_58_1.time_ < var_61_20 + var_61_30 + arg_61_0 then
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
			local var_65_0 = 0

			if var_65_0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_0 + arg_65_0 then
				arg_62_1.fswbg_:SetActive(true)
				arg_62_1.dialog_:SetActive(false)

				arg_62_1.fswtw_.percent = 0

				local var_65_1 = arg_62_1:GetWordFromCfg(319631015)
				local var_65_2 = arg_62_1:FormatText(var_65_1.content)

				arg_62_1.fswt_.text = var_65_2

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.fswt_)

				arg_62_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_62_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_62_1.fswtw_:SetDirty()

				arg_62_1.typewritterCharCountI18N = 0

				SetActive(arg_62_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_62_1:ShowNextGo(false)
			end

			local var_65_3 = 0.2

			if var_65_3 < arg_62_1.time_ and arg_62_1.time_ <= var_65_3 + arg_65_0 then
				arg_62_1.var_.oldValueTypewriter = arg_62_1.fswtw_.percent

				SetActive(arg_62_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_62_1:ShowNextGo(false)
			end

			local var_65_4 = 48
			local var_65_5 = 3.2
			local var_65_6 = arg_62_1:GetWordFromCfg(319631015)
			local var_65_7 = arg_62_1:FormatText(var_65_6.content)
			local var_65_8, var_65_9 = arg_62_1:GetPercentByPara(var_65_7, 1)

			if var_65_3 < arg_62_1.time_ and arg_62_1.time_ <= var_65_3 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0

				local var_65_10 = var_65_4 <= 0 and var_65_5 or var_65_5 * ((var_65_9 - arg_62_1.typewritterCharCountI18N) / var_65_4)

				if var_65_10 > 0 and var_65_5 < var_65_10 then
					arg_62_1.talkMaxDuration = var_65_10

					if var_65_10 + var_65_3 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_10 + var_65_3
					end
				end
			end

			local var_65_11 = 3.2
			local var_65_12 = math.max(var_65_11, arg_62_1.talkMaxDuration)

			if var_65_3 <= arg_62_1.time_ and arg_62_1.time_ < var_65_3 + var_65_12 then
				local var_65_13 = (arg_62_1.time_ - var_65_3) / var_65_12

				arg_62_1.fswtw_.percent = Mathf.Lerp(arg_62_1.var_.oldValueTypewriter, var_65_8, var_65_13)
				arg_62_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_62_1.fswtw_:SetDirty()
			end

			if arg_62_1.time_ >= var_65_3 + var_65_12 and arg_62_1.time_ < var_65_3 + var_65_12 + arg_65_0 then
				arg_62_1.fswtw_.percent = var_65_8

				arg_62_1.fswtw_:SetDirty()
				arg_62_1:ShowNextGo(true)

				arg_62_1.typewritterCharCountI18N = var_65_9
			end

			local var_65_14 = 0

			if var_65_14 < arg_62_1.time_ and arg_62_1.time_ <= var_65_14 + arg_65_0 then
				local var_65_15 = arg_62_1.fswbg_.transform:Find("textbox/adapt/content") or arg_62_1.fswbg_.transform:Find("textbox/content")
				local var_65_16 = arg_62_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_65_17 = var_65_15:GetComponent("Text")
				local var_65_18 = var_65_15:GetComponent("RectTransform")

				var_65_17.alignment = UnityEngine.TextAnchor.LowerCenter
				var_65_18.offsetMin = Vector2.New(0, 0)
				var_65_18.offsetMax = Vector2.New(0, 0)
			end

			local var_65_19 = "STblack"

			if arg_62_1.bgs_[var_65_19] == nil then
				local var_65_20 = Object.Instantiate(arg_62_1.paintGo_)

				var_65_20:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_65_19)
				var_65_20.name = var_65_19
				var_65_20.transform.parent = arg_62_1.stage_.transform
				var_65_20.transform.localPosition = Vector3.New(0, 100, 0)
				arg_62_1.bgs_[var_65_19] = var_65_20
			end

			local var_65_21 = 0

			if var_65_21 < arg_62_1.time_ and arg_62_1.time_ <= var_65_21 + arg_65_0 then
				local var_65_22 = manager.ui.mainCamera.transform.localPosition
				local var_65_23 = Vector3.New(0, 0, 10) + Vector3.New(var_65_22.x, var_65_22.y, 0)
				local var_65_24 = arg_62_1.bgs_.STblack

				var_65_24.transform.localPosition = var_65_23
				var_65_24.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_65_25 = var_65_24:GetComponent("SpriteRenderer")

				if var_65_25 and var_65_25.sprite then
					local var_65_26 = (var_65_24.transform.localPosition - var_65_22).z
					local var_65_27 = manager.ui.mainCameraCom_
					local var_65_28 = 2 * var_65_26 * Mathf.Tan(var_65_27.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_65_29 = var_65_28 * var_65_27.aspect
					local var_65_30 = var_65_25.sprite.bounds.size.x
					local var_65_31 = var_65_25.sprite.bounds.size.y
					local var_65_32 = var_65_29 / var_65_30
					local var_65_33 = var_65_28 / var_65_31
					local var_65_34 = var_65_33 < var_65_32 and var_65_32 or var_65_33

					var_65_24.transform.localScale = Vector3.New(var_65_34, var_65_34, 0)
				end

				for iter_65_0, iter_65_1 in pairs(arg_62_1.bgs_) do
					if iter_65_0 ~= "STblack" then
						iter_65_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_65_35 = arg_62_1.actors_["1095ui_story"].transform
			local var_65_36 = 0

			if var_65_36 < arg_62_1.time_ and arg_62_1.time_ <= var_65_36 + arg_65_0 then
				arg_62_1.var_.moveOldPos1095ui_story = var_65_35.localPosition
			end

			local var_65_37 = 0.001

			if var_65_36 <= arg_62_1.time_ and arg_62_1.time_ < var_65_36 + var_65_37 then
				local var_65_38 = (arg_62_1.time_ - var_65_36) / var_65_37
				local var_65_39 = Vector3.New(0, 100, 0)

				var_65_35.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos1095ui_story, var_65_39, var_65_38)

				local var_65_40 = manager.ui.mainCamera.transform.position - var_65_35.position

				var_65_35.forward = Vector3.New(var_65_40.x, var_65_40.y, var_65_40.z)

				local var_65_41 = var_65_35.localEulerAngles

				var_65_41.z = 0
				var_65_41.x = 0
				var_65_35.localEulerAngles = var_65_41
			end

			if arg_62_1.time_ >= var_65_36 + var_65_37 and arg_62_1.time_ < var_65_36 + var_65_37 + arg_65_0 then
				var_65_35.localPosition = Vector3.New(0, 100, 0)

				local var_65_42 = manager.ui.mainCamera.transform.position - var_65_35.position

				var_65_35.forward = Vector3.New(var_65_42.x, var_65_42.y, var_65_42.z)

				local var_65_43 = var_65_35.localEulerAngles

				var_65_43.z = 0
				var_65_43.x = 0
				var_65_35.localEulerAngles = var_65_43
			end

			local var_65_44 = arg_62_1.actors_["10079ui_story"].transform
			local var_65_45 = 0

			if var_65_45 < arg_62_1.time_ and arg_62_1.time_ <= var_65_45 + arg_65_0 then
				arg_62_1.var_.moveOldPos10079ui_story = var_65_44.localPosition
			end

			local var_65_46 = 0.001

			if var_65_45 <= arg_62_1.time_ and arg_62_1.time_ < var_65_45 + var_65_46 then
				local var_65_47 = (arg_62_1.time_ - var_65_45) / var_65_46
				local var_65_48 = Vector3.New(0, 100, 0)

				var_65_44.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos10079ui_story, var_65_48, var_65_47)

				local var_65_49 = manager.ui.mainCamera.transform.position - var_65_44.position

				var_65_44.forward = Vector3.New(var_65_49.x, var_65_49.y, var_65_49.z)

				local var_65_50 = var_65_44.localEulerAngles

				var_65_50.z = 0
				var_65_50.x = 0
				var_65_44.localEulerAngles = var_65_50
			end

			if arg_62_1.time_ >= var_65_45 + var_65_46 and arg_62_1.time_ < var_65_45 + var_65_46 + arg_65_0 then
				var_65_44.localPosition = Vector3.New(0, 100, 0)

				local var_65_51 = manager.ui.mainCamera.transform.position - var_65_44.position

				var_65_44.forward = Vector3.New(var_65_51.x, var_65_51.y, var_65_51.z)

				local var_65_52 = var_65_44.localEulerAngles

				var_65_52.z = 0
				var_65_52.x = 0
				var_65_44.localEulerAngles = var_65_52
			end

			local var_65_53 = 0

			if var_65_53 < arg_62_1.time_ and arg_62_1.time_ <= var_65_53 + arg_65_0 then
				arg_62_1.cswbg_:SetActive(true)

				local var_65_54 = arg_62_1.cswt_:GetComponent("RectTransform")

				arg_62_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_65_54.offsetMin = Vector2.New(410, 330)
				var_65_54.offsetMax = Vector2.New(-400, -175)

				local var_65_55 = arg_62_1:GetWordFromCfg(419034)
				local var_65_56 = arg_62_1:FormatText(var_65_55.content)

				arg_62_1.cswt_.text = var_65_56

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
			local var_69_0 = arg_66_1.actors_["10079ui_story"]
			local var_69_1 = 0

			if var_69_1 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect10079ui_story == nil then
				arg_66_1.var_.characterEffect10079ui_story = var_69_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_2 = 0.200000002980232

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_2 and not isNil(var_69_0) then
				local var_69_3 = (arg_66_1.time_ - var_69_1) / var_69_2

				if arg_66_1.var_.characterEffect10079ui_story and not isNil(var_69_0) then
					arg_66_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= var_69_1 + var_69_2 and arg_66_1.time_ < var_69_1 + var_69_2 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect10079ui_story then
				arg_66_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_69_4 = 0

			if var_69_4 < arg_66_1.time_ and arg_66_1.time_ <= var_69_4 + arg_69_0 then
				arg_66_1.fswbg_:SetActive(true)
				arg_66_1.dialog_:SetActive(false)

				arg_66_1.fswtw_.percent = 0

				local var_69_5 = arg_66_1:GetWordFromCfg(319631016)
				local var_69_6 = arg_66_1:FormatText(var_69_5.content)

				arg_66_1.fswt_.text = var_69_6

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.fswt_)

				arg_66_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_66_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_66_1.fswtw_:SetDirty()

				arg_66_1.typewritterCharCountI18N = 0

				SetActive(arg_66_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_66_1:ShowNextGo(false)
			end

			local var_69_7 = 0.3

			if var_69_7 < arg_66_1.time_ and arg_66_1.time_ <= var_69_7 + arg_69_0 then
				arg_66_1.var_.oldValueTypewriter = arg_66_1.fswtw_.percent

				SetActive(arg_66_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_66_1:ShowNextGo(false)
			end

			local var_69_8 = 6
			local var_69_9 = 0.4
			local var_69_10 = arg_66_1:GetWordFromCfg(319631016)
			local var_69_11 = arg_66_1:FormatText(var_69_10.content)
			local var_69_12, var_69_13 = arg_66_1:GetPercentByPara(var_69_11, 1)

			if var_69_7 < arg_66_1.time_ and arg_66_1.time_ <= var_69_7 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0

				local var_69_14 = var_69_8 <= 0 and var_69_9 or var_69_9 * ((var_69_13 - arg_66_1.typewritterCharCountI18N) / var_69_8)

				if var_69_14 > 0 and var_69_9 < var_69_14 then
					arg_66_1.talkMaxDuration = var_69_14

					if var_69_14 + var_69_7 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_14 + var_69_7
					end
				end
			end

			local var_69_15 = 0.4
			local var_69_16 = math.max(var_69_15, arg_66_1.talkMaxDuration)

			if var_69_7 <= arg_66_1.time_ and arg_66_1.time_ < var_69_7 + var_69_16 then
				local var_69_17 = (arg_66_1.time_ - var_69_7) / var_69_16

				arg_66_1.fswtw_.percent = Mathf.Lerp(arg_66_1.var_.oldValueTypewriter, var_69_12, var_69_17)
				arg_66_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_66_1.fswtw_:SetDirty()
			end

			if arg_66_1.time_ >= var_69_7 + var_69_16 and arg_66_1.time_ < var_69_7 + var_69_16 + arg_69_0 then
				arg_66_1.fswtw_.percent = var_69_12

				arg_66_1.fswtw_:SetDirty()
				arg_66_1:ShowNextGo(true)

				arg_66_1.typewritterCharCountI18N = var_69_13
			end

			local var_69_18 = 0
			local var_69_19 = 1
			local var_69_20 = manager.audio:GetVoiceLength("story_v_out_319631", "319631016", "story_v_out_319631.awb") / 1000

			if var_69_20 > 0 and var_69_19 < var_69_20 and var_69_20 + var_69_18 > arg_66_1.duration_ then
				local var_69_21 = var_69_20

				arg_66_1.duration_ = var_69_20 + var_69_18
			end

			if var_69_18 < arg_66_1.time_ and arg_66_1.time_ <= var_69_18 + arg_69_0 then
				local var_69_22 = "play"
				local var_69_23 = "voice"

				arg_66_1:AudioAction(var_69_22, var_69_23, "story_v_out_319631", "319631016", "story_v_out_319631.awb")
			end

			local var_69_24 = 0

			if var_69_24 < arg_66_1.time_ and arg_66_1.time_ <= var_69_24 + arg_69_0 then
				arg_66_1.cswbg_:SetActive(true)

				local var_69_25 = arg_66_1.cswt_:GetComponent("RectTransform")

				arg_66_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_69_25.offsetMin = Vector2.New(410, 330)
				var_69_25.offsetMax = Vector2.New(-400, -175)

				local var_69_26 = arg_66_1:GetWordFromCfg(419035)
				local var_69_27 = arg_66_1:FormatText(var_69_26.content)

				arg_66_1.cswt_.text = var_69_27

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
			local var_73_0 = arg_70_1.actors_["1095ui_story"].transform
			local var_73_1 = 0

			if var_73_1 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 then
				arg_70_1.var_.moveOldPos1095ui_story = var_73_0.localPosition
			end

			local var_73_2 = 0.001

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_2 then
				local var_73_3 = (arg_70_1.time_ - var_73_1) / var_73_2
				local var_73_4 = Vector3.New(0, 100, 0)

				var_73_0.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos1095ui_story, var_73_4, var_73_3)

				local var_73_5 = manager.ui.mainCamera.transform.position - var_73_0.position

				var_73_0.forward = Vector3.New(var_73_5.x, var_73_5.y, var_73_5.z)

				local var_73_6 = var_73_0.localEulerAngles

				var_73_6.z = 0
				var_73_6.x = 0
				var_73_0.localEulerAngles = var_73_6
			end

			if arg_70_1.time_ >= var_73_1 + var_73_2 and arg_70_1.time_ < var_73_1 + var_73_2 + arg_73_0 then
				var_73_0.localPosition = Vector3.New(0, 100, 0)

				local var_73_7 = manager.ui.mainCamera.transform.position - var_73_0.position

				var_73_0.forward = Vector3.New(var_73_7.x, var_73_7.y, var_73_7.z)

				local var_73_8 = var_73_0.localEulerAngles

				var_73_8.z = 0
				var_73_8.x = 0
				var_73_0.localEulerAngles = var_73_8
			end

			local var_73_9 = 0

			if var_73_9 < arg_70_1.time_ and arg_70_1.time_ <= var_73_9 + arg_73_0 then
				arg_70_1.fswbg_:SetActive(true)
				arg_70_1.dialog_:SetActive(false)

				arg_70_1.fswtw_.percent = 0

				local var_73_10 = arg_70_1:GetWordFromCfg(319631017)
				local var_73_11 = arg_70_1:FormatText(var_73_10.content)

				arg_70_1.fswt_.text = var_73_11

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.fswt_)

				arg_70_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_70_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_70_1.fswtw_:SetDirty()

				arg_70_1.typewritterCharCountI18N = 0

				SetActive(arg_70_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_70_1:ShowNextGo(false)
			end

			local var_73_12 = 0.0166666666666667

			if var_73_12 < arg_70_1.time_ and arg_70_1.time_ <= var_73_12 + arg_73_0 then
				arg_70_1.var_.oldValueTypewriter = arg_70_1.fswtw_.percent

				SetActive(arg_70_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_70_1:ShowNextGo(false)
			end

			local var_73_13 = 8
			local var_73_14 = 0.533333333333333
			local var_73_15 = arg_70_1:GetWordFromCfg(319631017)
			local var_73_16 = arg_70_1:FormatText(var_73_15.content)
			local var_73_17, var_73_18 = arg_70_1:GetPercentByPara(var_73_16, 1)

			if var_73_12 < arg_70_1.time_ and arg_70_1.time_ <= var_73_12 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0

				local var_73_19 = var_73_13 <= 0 and var_73_14 or var_73_14 * ((var_73_18 - arg_70_1.typewritterCharCountI18N) / var_73_13)

				if var_73_19 > 0 and var_73_14 < var_73_19 then
					arg_70_1.talkMaxDuration = var_73_19

					if var_73_19 + var_73_12 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_19 + var_73_12
					end
				end
			end

			local var_73_20 = 0.533333333333333
			local var_73_21 = math.max(var_73_20, arg_70_1.talkMaxDuration)

			if var_73_12 <= arg_70_1.time_ and arg_70_1.time_ < var_73_12 + var_73_21 then
				local var_73_22 = (arg_70_1.time_ - var_73_12) / var_73_21

				arg_70_1.fswtw_.percent = Mathf.Lerp(arg_70_1.var_.oldValueTypewriter, var_73_17, var_73_22)
				arg_70_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_70_1.fswtw_:SetDirty()
			end

			if arg_70_1.time_ >= var_73_12 + var_73_21 and arg_70_1.time_ < var_73_12 + var_73_21 + arg_73_0 then
				arg_70_1.fswtw_.percent = var_73_17

				arg_70_1.fswtw_:SetDirty()
				arg_70_1:ShowNextGo(true)

				arg_70_1.typewritterCharCountI18N = var_73_18
			end

			local var_73_23 = 0
			local var_73_24 = 2.166
			local var_73_25 = manager.audio:GetVoiceLength("story_v_out_319631", "319631017", "story_v_out_319631.awb") / 1000

			if var_73_25 > 0 and var_73_24 < var_73_25 and var_73_25 + var_73_23 > arg_70_1.duration_ then
				local var_73_26 = var_73_25

				arg_70_1.duration_ = var_73_25 + var_73_23
			end

			if var_73_23 < arg_70_1.time_ and arg_70_1.time_ <= var_73_23 + arg_73_0 then
				local var_73_27 = "play"
				local var_73_28 = "voice"

				arg_70_1:AudioAction(var_73_27, var_73_28, "story_v_out_319631", "319631017", "story_v_out_319631.awb")
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
			local var_77_0 = arg_74_1.actors_["1095ui_story"].transform
			local var_77_1 = 0

			if var_77_1 < arg_74_1.time_ and arg_74_1.time_ <= var_77_1 + arg_77_0 then
				arg_74_1.var_.moveOldPos1095ui_story = var_77_0.localPosition
			end

			local var_77_2 = 0.001

			if var_77_1 <= arg_74_1.time_ and arg_74_1.time_ < var_77_1 + var_77_2 then
				local var_77_3 = (arg_74_1.time_ - var_77_1) / var_77_2
				local var_77_4 = Vector3.New(0, -0.98, -6.1)

				var_77_0.localPosition = Vector3.Lerp(arg_74_1.var_.moveOldPos1095ui_story, var_77_4, var_77_3)

				local var_77_5 = manager.ui.mainCamera.transform.position - var_77_0.position

				var_77_0.forward = Vector3.New(var_77_5.x, var_77_5.y, var_77_5.z)

				local var_77_6 = var_77_0.localEulerAngles

				var_77_6.z = 0
				var_77_6.x = 0
				var_77_0.localEulerAngles = var_77_6
			end

			if arg_74_1.time_ >= var_77_1 + var_77_2 and arg_74_1.time_ < var_77_1 + var_77_2 + arg_77_0 then
				var_77_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_77_7 = manager.ui.mainCamera.transform.position - var_77_0.position

				var_77_0.forward = Vector3.New(var_77_7.x, var_77_7.y, var_77_7.z)

				local var_77_8 = var_77_0.localEulerAngles

				var_77_8.z = 0
				var_77_8.x = 0
				var_77_0.localEulerAngles = var_77_8
			end

			local var_77_9 = arg_74_1.actors_["1095ui_story"]
			local var_77_10 = 0

			if var_77_10 < arg_74_1.time_ and arg_74_1.time_ <= var_77_10 + arg_77_0 and not isNil(var_77_9) and arg_74_1.var_.characterEffect1095ui_story == nil then
				arg_74_1.var_.characterEffect1095ui_story = var_77_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_11 = 0.200000002980232

			if var_77_10 <= arg_74_1.time_ and arg_74_1.time_ < var_77_10 + var_77_11 and not isNil(var_77_9) then
				local var_77_12 = (arg_74_1.time_ - var_77_10) / var_77_11

				if arg_74_1.var_.characterEffect1095ui_story and not isNil(var_77_9) then
					arg_74_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_74_1.time_ >= var_77_10 + var_77_11 and arg_74_1.time_ < var_77_10 + var_77_11 + arg_77_0 and not isNil(var_77_9) and arg_74_1.var_.characterEffect1095ui_story then
				arg_74_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_77_13 = 0

			if var_77_13 < arg_74_1.time_ and arg_74_1.time_ <= var_77_13 + arg_77_0 then
				arg_74_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_77_14 = 0

			if var_77_14 < arg_74_1.time_ and arg_74_1.time_ <= var_77_14 + arg_77_0 then
				arg_74_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_77_15 = arg_74_1.actors_["10079ui_story"]
			local var_77_16 = 0

			if var_77_16 < arg_74_1.time_ and arg_74_1.time_ <= var_77_16 + arg_77_0 and not isNil(var_77_15) and arg_74_1.var_.characterEffect10079ui_story == nil then
				arg_74_1.var_.characterEffect10079ui_story = var_77_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_17 = 0.200000002980232

			if var_77_16 <= arg_74_1.time_ and arg_74_1.time_ < var_77_16 + var_77_17 and not isNil(var_77_15) then
				local var_77_18 = (arg_74_1.time_ - var_77_16) / var_77_17

				if arg_74_1.var_.characterEffect10079ui_story and not isNil(var_77_15) then
					local var_77_19 = Mathf.Lerp(0, 0.5, var_77_18)

					arg_74_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_74_1.var_.characterEffect10079ui_story.fillRatio = var_77_19
				end
			end

			if arg_74_1.time_ >= var_77_16 + var_77_17 and arg_74_1.time_ < var_77_16 + var_77_17 + arg_77_0 and not isNil(var_77_15) and arg_74_1.var_.characterEffect10079ui_story then
				local var_77_20 = 0.5

				arg_74_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_74_1.var_.characterEffect10079ui_story.fillRatio = var_77_20
			end

			local var_77_21 = arg_74_1.actors_["10079ui_story"].transform
			local var_77_22 = 0

			if var_77_22 < arg_74_1.time_ and arg_74_1.time_ <= var_77_22 + arg_77_0 then
				arg_74_1.var_.moveOldPos10079ui_story = var_77_21.localPosition
			end

			local var_77_23 = 0.001

			if var_77_22 <= arg_74_1.time_ and arg_74_1.time_ < var_77_22 + var_77_23 then
				local var_77_24 = (arg_74_1.time_ - var_77_22) / var_77_23
				local var_77_25 = Vector3.New(0, 100, 0)

				var_77_21.localPosition = Vector3.Lerp(arg_74_1.var_.moveOldPos10079ui_story, var_77_25, var_77_24)

				local var_77_26 = manager.ui.mainCamera.transform.position - var_77_21.position

				var_77_21.forward = Vector3.New(var_77_26.x, var_77_26.y, var_77_26.z)

				local var_77_27 = var_77_21.localEulerAngles

				var_77_27.z = 0
				var_77_27.x = 0
				var_77_21.localEulerAngles = var_77_27
			end

			if arg_74_1.time_ >= var_77_22 + var_77_23 and arg_74_1.time_ < var_77_22 + var_77_23 + arg_77_0 then
				var_77_21.localPosition = Vector3.New(0, 100, 0)

				local var_77_28 = manager.ui.mainCamera.transform.position - var_77_21.position

				var_77_21.forward = Vector3.New(var_77_28.x, var_77_28.y, var_77_28.z)

				local var_77_29 = var_77_21.localEulerAngles

				var_77_29.z = 0
				var_77_29.x = 0
				var_77_21.localEulerAngles = var_77_29
			end

			local var_77_30 = 0

			if var_77_30 < arg_74_1.time_ and arg_74_1.time_ <= var_77_30 + arg_77_0 then
				arg_74_1.fswbg_:SetActive(false)
				arg_74_1.dialog_:SetActive(false)
				SetActive(arg_74_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_74_1:ShowNextGo(false)
			end

			local var_77_31 = 0.0166666666666667

			if var_77_31 < arg_74_1.time_ and arg_74_1.time_ <= var_77_31 + arg_77_0 then
				arg_74_1.fswbg_:SetActive(false)
				arg_74_1.dialog_:SetActive(false)
				SetActive(arg_74_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_74_1:ShowNextGo(false)
			end

			local var_77_32 = 0

			if var_77_32 < arg_74_1.time_ and arg_74_1.time_ <= var_77_32 + arg_77_0 then
				arg_74_1.cswbg_:SetActive(false)
			end

			local var_77_33 = 0

			if var_77_33 < arg_74_1.time_ and arg_74_1.time_ <= var_77_33 + arg_77_0 then
				local var_77_34 = manager.ui.mainCamera.transform.localPosition
				local var_77_35 = Vector3.New(0, 0, 10) + Vector3.New(var_77_34.x, var_77_34.y, 0)
				local var_77_36 = arg_74_1.bgs_.Z03f

				var_77_36.transform.localPosition = var_77_35
				var_77_36.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_77_37 = var_77_36:GetComponent("SpriteRenderer")

				if var_77_37 and var_77_37.sprite then
					local var_77_38 = (var_77_36.transform.localPosition - var_77_34).z
					local var_77_39 = manager.ui.mainCameraCom_
					local var_77_40 = 2 * var_77_38 * Mathf.Tan(var_77_39.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_77_41 = var_77_40 * var_77_39.aspect
					local var_77_42 = var_77_37.sprite.bounds.size.x
					local var_77_43 = var_77_37.sprite.bounds.size.y
					local var_77_44 = var_77_41 / var_77_42
					local var_77_45 = var_77_40 / var_77_43
					local var_77_46 = var_77_45 < var_77_44 and var_77_44 or var_77_45

					var_77_36.transform.localScale = Vector3.New(var_77_46, var_77_46, 0)
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

			local var_77_47 = 0.1
			local var_77_48 = 0.275

			if var_77_47 < arg_74_1.time_ and arg_74_1.time_ <= var_77_47 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0

				arg_74_1.dialog_:SetActive(true)

				arg_74_1.dialogCg_.alpha = 0

				local var_77_49 = LeanTween.value(arg_74_1.dialog_, 0, 1, 0.3)

				var_77_49:setOnUpdate(LuaHelper.FloatAction(function(arg_78_0)
					arg_74_1.dialogCg_.alpha = arg_78_0
				end))
				var_77_49:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_74_1.dialog_)
					var_77_49:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_74_1.duration_ = arg_74_1.duration_ + 0.3

				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_50 = arg_74_1:FormatText(StoryNameCfg[471].name)

				arg_74_1.leftNameTxt_.text = var_77_50

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_51 = arg_74_1:GetWordFromCfg(319631018)
				local var_77_52 = arg_74_1:FormatText(var_77_51.content)

				arg_74_1.text_.text = var_77_52

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_53 = 11
				local var_77_54 = utf8.len(var_77_52)
				local var_77_55 = var_77_53 <= 0 and var_77_48 or var_77_48 * (var_77_54 / var_77_53)

				if var_77_55 > 0 and var_77_48 < var_77_55 then
					arg_74_1.talkMaxDuration = var_77_55
					var_77_47 = var_77_47 + 0.3

					if var_77_55 + var_77_47 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_55 + var_77_47
					end
				end

				arg_74_1.text_.text = var_77_52
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631018", "story_v_out_319631.awb") ~= 0 then
					local var_77_56 = manager.audio:GetVoiceLength("story_v_out_319631", "319631018", "story_v_out_319631.awb") / 1000

					if var_77_56 + var_77_47 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_56 + var_77_47
					end

					if var_77_51.prefab_name ~= "" and arg_74_1.actors_[var_77_51.prefab_name] ~= nil then
						local var_77_57 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_51.prefab_name].transform, "story_v_out_319631", "319631018", "story_v_out_319631.awb")

						arg_74_1:RecordAudio("319631018", var_77_57)
						arg_74_1:RecordAudio("319631018", var_77_57)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_319631", "319631018", "story_v_out_319631.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_319631", "319631018", "story_v_out_319631.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_58 = var_77_47 + 0.3
			local var_77_59 = math.max(var_77_48, arg_74_1.talkMaxDuration)

			if var_77_58 <= arg_74_1.time_ and arg_74_1.time_ < var_77_58 + var_77_59 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_58) / var_77_59

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_58 + var_77_59 and arg_74_1.time_ < var_77_58 + var_77_59 + arg_77_0 then
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
			local var_83_0 = arg_80_1.actors_["1095ui_story"]
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect1095ui_story == nil then
				arg_80_1.var_.characterEffect1095ui_story = var_83_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_2 = 0.200000002980232

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_2 and not isNil(var_83_0) then
				local var_83_3 = (arg_80_1.time_ - var_83_1) / var_83_2

				if arg_80_1.var_.characterEffect1095ui_story and not isNil(var_83_0) then
					local var_83_4 = Mathf.Lerp(0, 0.5, var_83_3)

					arg_80_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_80_1.var_.characterEffect1095ui_story.fillRatio = var_83_4
				end
			end

			if arg_80_1.time_ >= var_83_1 + var_83_2 and arg_80_1.time_ < var_83_1 + var_83_2 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect1095ui_story then
				local var_83_5 = 0.5

				arg_80_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_80_1.var_.characterEffect1095ui_story.fillRatio = var_83_5
			end

			local var_83_6 = 0
			local var_83_7 = 0.7

			if var_83_6 < arg_80_1.time_ and arg_80_1.time_ <= var_83_6 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, false)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_8 = arg_80_1:GetWordFromCfg(319631019)
				local var_83_9 = arg_80_1:FormatText(var_83_8.content)

				arg_80_1.text_.text = var_83_9

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_10 = 28
				local var_83_11 = utf8.len(var_83_9)
				local var_83_12 = var_83_10 <= 0 and var_83_7 or var_83_7 * (var_83_11 / var_83_10)

				if var_83_12 > 0 and var_83_7 < var_83_12 then
					arg_80_1.talkMaxDuration = var_83_12

					if var_83_12 + var_83_6 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_12 + var_83_6
					end
				end

				arg_80_1.text_.text = var_83_9
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_13 = math.max(var_83_7, arg_80_1.talkMaxDuration)

			if var_83_6 <= arg_80_1.time_ and arg_80_1.time_ < var_83_6 + var_83_13 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_6) / var_83_13

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_6 + var_83_13 and arg_80_1.time_ < var_83_6 + var_83_13 + arg_83_0 then
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
			local var_87_0 = arg_84_1.actors_["10079ui_story"].transform
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 then
				arg_84_1.var_.moveOldPos10079ui_story = var_87_0.localPosition
			end

			local var_87_2 = 0.001

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_2 then
				local var_87_3 = (arg_84_1.time_ - var_87_1) / var_87_2
				local var_87_4 = Vector3.New(-0.7, -0.95, -6.05)

				var_87_0.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos10079ui_story, var_87_4, var_87_3)

				local var_87_5 = manager.ui.mainCamera.transform.position - var_87_0.position

				var_87_0.forward = Vector3.New(var_87_5.x, var_87_5.y, var_87_5.z)

				local var_87_6 = var_87_0.localEulerAngles

				var_87_6.z = 0
				var_87_6.x = 0
				var_87_0.localEulerAngles = var_87_6
			end

			if arg_84_1.time_ >= var_87_1 + var_87_2 and arg_84_1.time_ < var_87_1 + var_87_2 + arg_87_0 then
				var_87_0.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_87_7 = manager.ui.mainCamera.transform.position - var_87_0.position

				var_87_0.forward = Vector3.New(var_87_7.x, var_87_7.y, var_87_7.z)

				local var_87_8 = var_87_0.localEulerAngles

				var_87_8.z = 0
				var_87_8.x = 0
				var_87_0.localEulerAngles = var_87_8
			end

			local var_87_9 = arg_84_1.actors_["10079ui_story"]
			local var_87_10 = 0

			if var_87_10 < arg_84_1.time_ and arg_84_1.time_ <= var_87_10 + arg_87_0 and not isNil(var_87_9) and arg_84_1.var_.characterEffect10079ui_story == nil then
				arg_84_1.var_.characterEffect10079ui_story = var_87_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_11 = 0.200000002980232

			if var_87_10 <= arg_84_1.time_ and arg_84_1.time_ < var_87_10 + var_87_11 and not isNil(var_87_9) then
				local var_87_12 = (arg_84_1.time_ - var_87_10) / var_87_11

				if arg_84_1.var_.characterEffect10079ui_story and not isNil(var_87_9) then
					arg_84_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= var_87_10 + var_87_11 and arg_84_1.time_ < var_87_10 + var_87_11 + arg_87_0 and not isNil(var_87_9) and arg_84_1.var_.characterEffect10079ui_story then
				arg_84_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_87_13 = 0

			if var_87_13 < arg_84_1.time_ and arg_84_1.time_ <= var_87_13 + arg_87_0 then
				arg_84_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_87_14 = arg_84_1.actors_["1095ui_story"].transform
			local var_87_15 = 0

			if var_87_15 < arg_84_1.time_ and arg_84_1.time_ <= var_87_15 + arg_87_0 then
				arg_84_1.var_.moveOldPos1095ui_story = var_87_14.localPosition
			end

			local var_87_16 = 0.001

			if var_87_15 <= arg_84_1.time_ and arg_84_1.time_ < var_87_15 + var_87_16 then
				local var_87_17 = (arg_84_1.time_ - var_87_15) / var_87_16
				local var_87_18 = Vector3.New(0.7, -0.98, -6.1)

				var_87_14.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1095ui_story, var_87_18, var_87_17)

				local var_87_19 = manager.ui.mainCamera.transform.position - var_87_14.position

				var_87_14.forward = Vector3.New(var_87_19.x, var_87_19.y, var_87_19.z)

				local var_87_20 = var_87_14.localEulerAngles

				var_87_20.z = 0
				var_87_20.x = 0
				var_87_14.localEulerAngles = var_87_20
			end

			if arg_84_1.time_ >= var_87_15 + var_87_16 and arg_84_1.time_ < var_87_15 + var_87_16 + arg_87_0 then
				var_87_14.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_87_21 = manager.ui.mainCamera.transform.position - var_87_14.position

				var_87_14.forward = Vector3.New(var_87_21.x, var_87_21.y, var_87_21.z)

				local var_87_22 = var_87_14.localEulerAngles

				var_87_22.z = 0
				var_87_22.x = 0
				var_87_14.localEulerAngles = var_87_22
			end

			local var_87_23 = arg_84_1.actors_["1095ui_story"]
			local var_87_24 = 0

			if var_87_24 < arg_84_1.time_ and arg_84_1.time_ <= var_87_24 + arg_87_0 and not isNil(var_87_23) and arg_84_1.var_.characterEffect1095ui_story == nil then
				arg_84_1.var_.characterEffect1095ui_story = var_87_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_25 = 0.200000002980232

			if var_87_24 <= arg_84_1.time_ and arg_84_1.time_ < var_87_24 + var_87_25 and not isNil(var_87_23) then
				local var_87_26 = (arg_84_1.time_ - var_87_24) / var_87_25

				if arg_84_1.var_.characterEffect1095ui_story and not isNil(var_87_23) then
					local var_87_27 = Mathf.Lerp(0, 0.5, var_87_26)

					arg_84_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_84_1.var_.characterEffect1095ui_story.fillRatio = var_87_27
				end
			end

			if arg_84_1.time_ >= var_87_24 + var_87_25 and arg_84_1.time_ < var_87_24 + var_87_25 + arg_87_0 and not isNil(var_87_23) and arg_84_1.var_.characterEffect1095ui_story then
				local var_87_28 = 0.5

				arg_84_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_84_1.var_.characterEffect1095ui_story.fillRatio = var_87_28
			end

			local var_87_29 = 0
			local var_87_30 = 0.55

			if var_87_29 < arg_84_1.time_ and arg_84_1.time_ <= var_87_29 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_31 = arg_84_1:FormatText(StoryNameCfg[6].name)

				arg_84_1.leftNameTxt_.text = var_87_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_32 = arg_84_1:GetWordFromCfg(319631020)
				local var_87_33 = arg_84_1:FormatText(var_87_32.content)

				arg_84_1.text_.text = var_87_33

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_34 = 22
				local var_87_35 = utf8.len(var_87_33)
				local var_87_36 = var_87_34 <= 0 and var_87_30 or var_87_30 * (var_87_35 / var_87_34)

				if var_87_36 > 0 and var_87_30 < var_87_36 then
					arg_84_1.talkMaxDuration = var_87_36

					if var_87_36 + var_87_29 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_36 + var_87_29
					end
				end

				arg_84_1.text_.text = var_87_33
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631020", "story_v_out_319631.awb") ~= 0 then
					local var_87_37 = manager.audio:GetVoiceLength("story_v_out_319631", "319631020", "story_v_out_319631.awb") / 1000

					if var_87_37 + var_87_29 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_37 + var_87_29
					end

					if var_87_32.prefab_name ~= "" and arg_84_1.actors_[var_87_32.prefab_name] ~= nil then
						local var_87_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_32.prefab_name].transform, "story_v_out_319631", "319631020", "story_v_out_319631.awb")

						arg_84_1:RecordAudio("319631020", var_87_38)
						arg_84_1:RecordAudio("319631020", var_87_38)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_319631", "319631020", "story_v_out_319631.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_319631", "319631020", "story_v_out_319631.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_39 = math.max(var_87_30, arg_84_1.talkMaxDuration)

			if var_87_29 <= arg_84_1.time_ and arg_84_1.time_ < var_87_29 + var_87_39 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_29) / var_87_39

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_29 + var_87_39 and arg_84_1.time_ < var_87_29 + var_87_39 + arg_87_0 then
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
			local var_91_0 = arg_88_1.actors_["10079ui_story"]
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect10079ui_story == nil then
				arg_88_1.var_.characterEffect10079ui_story = var_91_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_2 = 0.200000002980232

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_2 and not isNil(var_91_0) then
				local var_91_3 = (arg_88_1.time_ - var_91_1) / var_91_2

				if arg_88_1.var_.characterEffect10079ui_story and not isNil(var_91_0) then
					local var_91_4 = Mathf.Lerp(0, 0.5, var_91_3)

					arg_88_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_88_1.var_.characterEffect10079ui_story.fillRatio = var_91_4
				end
			end

			if arg_88_1.time_ >= var_91_1 + var_91_2 and arg_88_1.time_ < var_91_1 + var_91_2 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect10079ui_story then
				local var_91_5 = 0.5

				arg_88_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_88_1.var_.characterEffect10079ui_story.fillRatio = var_91_5
			end

			local var_91_6 = arg_88_1.actors_["1095ui_story"]
			local var_91_7 = 0

			if var_91_7 < arg_88_1.time_ and arg_88_1.time_ <= var_91_7 + arg_91_0 and not isNil(var_91_6) and arg_88_1.var_.characterEffect1095ui_story == nil then
				arg_88_1.var_.characterEffect1095ui_story = var_91_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_8 = 0.200000002980232

			if var_91_7 <= arg_88_1.time_ and arg_88_1.time_ < var_91_7 + var_91_8 and not isNil(var_91_6) then
				local var_91_9 = (arg_88_1.time_ - var_91_7) / var_91_8

				if arg_88_1.var_.characterEffect1095ui_story and not isNil(var_91_6) then
					arg_88_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= var_91_7 + var_91_8 and arg_88_1.time_ < var_91_7 + var_91_8 + arg_91_0 and not isNil(var_91_6) and arg_88_1.var_.characterEffect1095ui_story then
				arg_88_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_91_10 = 0
			local var_91_11 = 0.225

			if var_91_10 < arg_88_1.time_ and arg_88_1.time_ <= var_91_10 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_12 = arg_88_1:FormatText(StoryNameCfg[471].name)

				arg_88_1.leftNameTxt_.text = var_91_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_13 = arg_88_1:GetWordFromCfg(319631021)
				local var_91_14 = arg_88_1:FormatText(var_91_13.content)

				arg_88_1.text_.text = var_91_14

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_15 = 9
				local var_91_16 = utf8.len(var_91_14)
				local var_91_17 = var_91_15 <= 0 and var_91_11 or var_91_11 * (var_91_16 / var_91_15)

				if var_91_17 > 0 and var_91_11 < var_91_17 then
					arg_88_1.talkMaxDuration = var_91_17

					if var_91_17 + var_91_10 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_17 + var_91_10
					end
				end

				arg_88_1.text_.text = var_91_14
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631021", "story_v_out_319631.awb") ~= 0 then
					local var_91_18 = manager.audio:GetVoiceLength("story_v_out_319631", "319631021", "story_v_out_319631.awb") / 1000

					if var_91_18 + var_91_10 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_18 + var_91_10
					end

					if var_91_13.prefab_name ~= "" and arg_88_1.actors_[var_91_13.prefab_name] ~= nil then
						local var_91_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_13.prefab_name].transform, "story_v_out_319631", "319631021", "story_v_out_319631.awb")

						arg_88_1:RecordAudio("319631021", var_91_19)
						arg_88_1:RecordAudio("319631021", var_91_19)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_319631", "319631021", "story_v_out_319631.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_319631", "319631021", "story_v_out_319631.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_20 = math.max(var_91_11, arg_88_1.talkMaxDuration)

			if var_91_10 <= arg_88_1.time_ and arg_88_1.time_ < var_91_10 + var_91_20 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_10) / var_91_20

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_10 + var_91_20 and arg_88_1.time_ < var_91_10 + var_91_20 + arg_91_0 then
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
			local var_95_0 = 0

			if var_95_0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_0 + arg_95_0 then
				arg_92_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			local var_95_1 = arg_92_1.actors_["10079ui_story"]
			local var_95_2 = 0

			if var_95_2 < arg_92_1.time_ and arg_92_1.time_ <= var_95_2 + arg_95_0 and not isNil(var_95_1) and arg_92_1.var_.characterEffect10079ui_story == nil then
				arg_92_1.var_.characterEffect10079ui_story = var_95_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_3 = 0.200000002980232

			if var_95_2 <= arg_92_1.time_ and arg_92_1.time_ < var_95_2 + var_95_3 and not isNil(var_95_1) then
				local var_95_4 = (arg_92_1.time_ - var_95_2) / var_95_3

				if arg_92_1.var_.characterEffect10079ui_story and not isNil(var_95_1) then
					arg_92_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= var_95_2 + var_95_3 and arg_92_1.time_ < var_95_2 + var_95_3 + arg_95_0 and not isNil(var_95_1) and arg_92_1.var_.characterEffect10079ui_story then
				arg_92_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_95_5 = arg_92_1.actors_["1095ui_story"]
			local var_95_6 = 0

			if var_95_6 < arg_92_1.time_ and arg_92_1.time_ <= var_95_6 + arg_95_0 and not isNil(var_95_5) and arg_92_1.var_.characterEffect1095ui_story == nil then
				arg_92_1.var_.characterEffect1095ui_story = var_95_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_7 = 0.200000002980232

			if var_95_6 <= arg_92_1.time_ and arg_92_1.time_ < var_95_6 + var_95_7 and not isNil(var_95_5) then
				local var_95_8 = (arg_92_1.time_ - var_95_6) / var_95_7

				if arg_92_1.var_.characterEffect1095ui_story and not isNil(var_95_5) then
					local var_95_9 = Mathf.Lerp(0, 0.5, var_95_8)

					arg_92_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_92_1.var_.characterEffect1095ui_story.fillRatio = var_95_9
				end
			end

			if arg_92_1.time_ >= var_95_6 + var_95_7 and arg_92_1.time_ < var_95_6 + var_95_7 + arg_95_0 and not isNil(var_95_5) and arg_92_1.var_.characterEffect1095ui_story then
				local var_95_10 = 0.5

				arg_92_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_92_1.var_.characterEffect1095ui_story.fillRatio = var_95_10
			end

			local var_95_11 = 0
			local var_95_12 = 0.6

			if var_95_11 < arg_92_1.time_ and arg_92_1.time_ <= var_95_11 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_13 = arg_92_1:FormatText(StoryNameCfg[6].name)

				arg_92_1.leftNameTxt_.text = var_95_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_14 = arg_92_1:GetWordFromCfg(319631022)
				local var_95_15 = arg_92_1:FormatText(var_95_14.content)

				arg_92_1.text_.text = var_95_15

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_16 = 24
				local var_95_17 = utf8.len(var_95_15)
				local var_95_18 = var_95_16 <= 0 and var_95_12 or var_95_12 * (var_95_17 / var_95_16)

				if var_95_18 > 0 and var_95_12 < var_95_18 then
					arg_92_1.talkMaxDuration = var_95_18

					if var_95_18 + var_95_11 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_18 + var_95_11
					end
				end

				arg_92_1.text_.text = var_95_15
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631022", "story_v_out_319631.awb") ~= 0 then
					local var_95_19 = manager.audio:GetVoiceLength("story_v_out_319631", "319631022", "story_v_out_319631.awb") / 1000

					if var_95_19 + var_95_11 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_19 + var_95_11
					end

					if var_95_14.prefab_name ~= "" and arg_92_1.actors_[var_95_14.prefab_name] ~= nil then
						local var_95_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_14.prefab_name].transform, "story_v_out_319631", "319631022", "story_v_out_319631.awb")

						arg_92_1:RecordAudio("319631022", var_95_20)
						arg_92_1:RecordAudio("319631022", var_95_20)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_319631", "319631022", "story_v_out_319631.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_319631", "319631022", "story_v_out_319631.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_21 = math.max(var_95_12, arg_92_1.talkMaxDuration)

			if var_95_11 <= arg_92_1.time_ and arg_92_1.time_ < var_95_11 + var_95_21 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_11) / var_95_21

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_11 + var_95_21 and arg_92_1.time_ < var_95_11 + var_95_21 + arg_95_0 then
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
			local var_99_0 = arg_96_1.actors_["10079ui_story"].transform
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 then
				arg_96_1.var_.moveOldPos10079ui_story = var_99_0.localPosition
			end

			local var_99_2 = 0.001

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_2 then
				local var_99_3 = (arg_96_1.time_ - var_99_1) / var_99_2
				local var_99_4 = Vector3.New(0, 100, 0)

				var_99_0.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos10079ui_story, var_99_4, var_99_3)

				local var_99_5 = manager.ui.mainCamera.transform.position - var_99_0.position

				var_99_0.forward = Vector3.New(var_99_5.x, var_99_5.y, var_99_5.z)

				local var_99_6 = var_99_0.localEulerAngles

				var_99_6.z = 0
				var_99_6.x = 0
				var_99_0.localEulerAngles = var_99_6
			end

			if arg_96_1.time_ >= var_99_1 + var_99_2 and arg_96_1.time_ < var_99_1 + var_99_2 + arg_99_0 then
				var_99_0.localPosition = Vector3.New(0, 100, 0)

				local var_99_7 = manager.ui.mainCamera.transform.position - var_99_0.position

				var_99_0.forward = Vector3.New(var_99_7.x, var_99_7.y, var_99_7.z)

				local var_99_8 = var_99_0.localEulerAngles

				var_99_8.z = 0
				var_99_8.x = 0
				var_99_0.localEulerAngles = var_99_8
			end

			local var_99_9 = arg_96_1.actors_["10079ui_story"]
			local var_99_10 = 0

			if var_99_10 < arg_96_1.time_ and arg_96_1.time_ <= var_99_10 + arg_99_0 and not isNil(var_99_9) and arg_96_1.var_.characterEffect10079ui_story == nil then
				arg_96_1.var_.characterEffect10079ui_story = var_99_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_11 = 0.200000002980232

			if var_99_10 <= arg_96_1.time_ and arg_96_1.time_ < var_99_10 + var_99_11 and not isNil(var_99_9) then
				local var_99_12 = (arg_96_1.time_ - var_99_10) / var_99_11

				if arg_96_1.var_.characterEffect10079ui_story and not isNil(var_99_9) then
					local var_99_13 = Mathf.Lerp(0, 0.5, var_99_12)

					arg_96_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_96_1.var_.characterEffect10079ui_story.fillRatio = var_99_13
				end
			end

			if arg_96_1.time_ >= var_99_10 + var_99_11 and arg_96_1.time_ < var_99_10 + var_99_11 + arg_99_0 and not isNil(var_99_9) and arg_96_1.var_.characterEffect10079ui_story then
				local var_99_14 = 0.5

				arg_96_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_96_1.var_.characterEffect10079ui_story.fillRatio = var_99_14
			end

			local var_99_15 = arg_96_1.actors_["1095ui_story"].transform
			local var_99_16 = 0

			if var_99_16 < arg_96_1.time_ and arg_96_1.time_ <= var_99_16 + arg_99_0 then
				arg_96_1.var_.moveOldPos1095ui_story = var_99_15.localPosition
			end

			local var_99_17 = 0.001

			if var_99_16 <= arg_96_1.time_ and arg_96_1.time_ < var_99_16 + var_99_17 then
				local var_99_18 = (arg_96_1.time_ - var_99_16) / var_99_17
				local var_99_19 = Vector3.New(0, 100, 0)

				var_99_15.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos1095ui_story, var_99_19, var_99_18)

				local var_99_20 = manager.ui.mainCamera.transform.position - var_99_15.position

				var_99_15.forward = Vector3.New(var_99_20.x, var_99_20.y, var_99_20.z)

				local var_99_21 = var_99_15.localEulerAngles

				var_99_21.z = 0
				var_99_21.x = 0
				var_99_15.localEulerAngles = var_99_21
			end

			if arg_96_1.time_ >= var_99_16 + var_99_17 and arg_96_1.time_ < var_99_16 + var_99_17 + arg_99_0 then
				var_99_15.localPosition = Vector3.New(0, 100, 0)

				local var_99_22 = manager.ui.mainCamera.transform.position - var_99_15.position

				var_99_15.forward = Vector3.New(var_99_22.x, var_99_22.y, var_99_22.z)

				local var_99_23 = var_99_15.localEulerAngles

				var_99_23.z = 0
				var_99_23.x = 0
				var_99_15.localEulerAngles = var_99_23
			end

			local var_99_24 = arg_96_1.actors_["1095ui_story"]
			local var_99_25 = 0

			if var_99_25 < arg_96_1.time_ and arg_96_1.time_ <= var_99_25 + arg_99_0 and not isNil(var_99_24) and arg_96_1.var_.characterEffect1095ui_story == nil then
				arg_96_1.var_.characterEffect1095ui_story = var_99_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_26 = 0.200000002980232

			if var_99_25 <= arg_96_1.time_ and arg_96_1.time_ < var_99_25 + var_99_26 and not isNil(var_99_24) then
				local var_99_27 = (arg_96_1.time_ - var_99_25) / var_99_26

				if arg_96_1.var_.characterEffect1095ui_story and not isNil(var_99_24) then
					local var_99_28 = Mathf.Lerp(0, 0.5, var_99_27)

					arg_96_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_96_1.var_.characterEffect1095ui_story.fillRatio = var_99_28
				end
			end

			if arg_96_1.time_ >= var_99_25 + var_99_26 and arg_96_1.time_ < var_99_25 + var_99_26 + arg_99_0 and not isNil(var_99_24) and arg_96_1.var_.characterEffect1095ui_story then
				local var_99_29 = 0.5

				arg_96_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_96_1.var_.characterEffect1095ui_story.fillRatio = var_99_29
			end

			local var_99_30 = 0
			local var_99_31 = 1.25

			if var_99_30 < arg_96_1.time_ and arg_96_1.time_ <= var_99_30 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, false)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_32 = arg_96_1:GetWordFromCfg(319631023)
				local var_99_33 = arg_96_1:FormatText(var_99_32.content)

				arg_96_1.text_.text = var_99_33

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_34 = 50
				local var_99_35 = utf8.len(var_99_33)
				local var_99_36 = var_99_34 <= 0 and var_99_31 or var_99_31 * (var_99_35 / var_99_34)

				if var_99_36 > 0 and var_99_31 < var_99_36 then
					arg_96_1.talkMaxDuration = var_99_36

					if var_99_36 + var_99_30 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_36 + var_99_30
					end
				end

				arg_96_1.text_.text = var_99_33
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_37 = math.max(var_99_31, arg_96_1.talkMaxDuration)

			if var_99_30 <= arg_96_1.time_ and arg_96_1.time_ < var_99_30 + var_99_37 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_30) / var_99_37

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_30 + var_99_37 and arg_96_1.time_ < var_99_30 + var_99_37 + arg_99_0 then
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
			local var_103_0 = "4037ui_story"

			if arg_100_1.actors_[var_103_0] == nil then
				local var_103_1 = Asset.Load("Char/" .. "4037ui_story")

				if not isNil(var_103_1) then
					local var_103_2 = Object.Instantiate(Asset.Load("Char/" .. "4037ui_story"), arg_100_1.stage_.transform)

					var_103_2.name = var_103_0
					var_103_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_100_1.actors_[var_103_0] = var_103_2

					local var_103_3 = var_103_2:GetComponentInChildren(typeof(CharacterEffect))

					var_103_3.enabled = true

					local var_103_4 = GameObjectTools.GetOrAddComponent(var_103_2, typeof(DynamicBoneHelper))

					if var_103_4 then
						var_103_4:EnableDynamicBone(false)
					end

					arg_100_1:ShowWeapon(var_103_3.transform, false)

					arg_100_1.var_[var_103_0 .. "Animator"] = var_103_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_100_1.var_[var_103_0 .. "Animator"].applyRootMotion = true
					arg_100_1.var_[var_103_0 .. "LipSync"] = var_103_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_103_5 = arg_100_1.actors_["4037ui_story"].transform
			local var_103_6 = 0

			if var_103_6 < arg_100_1.time_ and arg_100_1.time_ <= var_103_6 + arg_103_0 then
				arg_100_1.var_.moveOldPos4037ui_story = var_103_5.localPosition
			end

			local var_103_7 = 0.001

			if var_103_6 <= arg_100_1.time_ and arg_100_1.time_ < var_103_6 + var_103_7 then
				local var_103_8 = (arg_100_1.time_ - var_103_6) / var_103_7
				local var_103_9 = Vector3.New(0, -1.12, -6.2)

				var_103_5.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos4037ui_story, var_103_9, var_103_8)

				local var_103_10 = manager.ui.mainCamera.transform.position - var_103_5.position

				var_103_5.forward = Vector3.New(var_103_10.x, var_103_10.y, var_103_10.z)

				local var_103_11 = var_103_5.localEulerAngles

				var_103_11.z = 0
				var_103_11.x = 0
				var_103_5.localEulerAngles = var_103_11
			end

			if arg_100_1.time_ >= var_103_6 + var_103_7 and arg_100_1.time_ < var_103_6 + var_103_7 + arg_103_0 then
				var_103_5.localPosition = Vector3.New(0, -1.12, -6.2)

				local var_103_12 = manager.ui.mainCamera.transform.position - var_103_5.position

				var_103_5.forward = Vector3.New(var_103_12.x, var_103_12.y, var_103_12.z)

				local var_103_13 = var_103_5.localEulerAngles

				var_103_13.z = 0
				var_103_13.x = 0
				var_103_5.localEulerAngles = var_103_13
			end

			local var_103_14 = arg_100_1.actors_["4037ui_story"]
			local var_103_15 = 0

			if var_103_15 < arg_100_1.time_ and arg_100_1.time_ <= var_103_15 + arg_103_0 and not isNil(var_103_14) and arg_100_1.var_.characterEffect4037ui_story == nil then
				arg_100_1.var_.characterEffect4037ui_story = var_103_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_16 = 0.200000002980232

			if var_103_15 <= arg_100_1.time_ and arg_100_1.time_ < var_103_15 + var_103_16 and not isNil(var_103_14) then
				local var_103_17 = (arg_100_1.time_ - var_103_15) / var_103_16

				if arg_100_1.var_.characterEffect4037ui_story and not isNil(var_103_14) then
					arg_100_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_100_1.time_ >= var_103_15 + var_103_16 and arg_100_1.time_ < var_103_15 + var_103_16 + arg_103_0 and not isNil(var_103_14) and arg_100_1.var_.characterEffect4037ui_story then
				arg_100_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_103_18 = 0

			if var_103_18 < arg_100_1.time_ and arg_100_1.time_ <= var_103_18 + arg_103_0 then
				arg_100_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			local var_103_19 = 0

			if var_103_19 < arg_100_1.time_ and arg_100_1.time_ <= var_103_19 + arg_103_0 then
				arg_100_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_103_20 = 0
			local var_103_21 = 0.5

			if var_103_20 < arg_100_1.time_ and arg_100_1.time_ <= var_103_20 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_22 = arg_100_1:FormatText(StoryNameCfg[453].name)

				arg_100_1.leftNameTxt_.text = var_103_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_23 = arg_100_1:GetWordFromCfg(319631024)
				local var_103_24 = arg_100_1:FormatText(var_103_23.content)

				arg_100_1.text_.text = var_103_24

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_25 = 20
				local var_103_26 = utf8.len(var_103_24)
				local var_103_27 = var_103_25 <= 0 and var_103_21 or var_103_21 * (var_103_26 / var_103_25)

				if var_103_27 > 0 and var_103_21 < var_103_27 then
					arg_100_1.talkMaxDuration = var_103_27

					if var_103_27 + var_103_20 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_27 + var_103_20
					end
				end

				arg_100_1.text_.text = var_103_24
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631024", "story_v_out_319631.awb") ~= 0 then
					local var_103_28 = manager.audio:GetVoiceLength("story_v_out_319631", "319631024", "story_v_out_319631.awb") / 1000

					if var_103_28 + var_103_20 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_28 + var_103_20
					end

					if var_103_23.prefab_name ~= "" and arg_100_1.actors_[var_103_23.prefab_name] ~= nil then
						local var_103_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_23.prefab_name].transform, "story_v_out_319631", "319631024", "story_v_out_319631.awb")

						arg_100_1:RecordAudio("319631024", var_103_29)
						arg_100_1:RecordAudio("319631024", var_103_29)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_319631", "319631024", "story_v_out_319631.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_319631", "319631024", "story_v_out_319631.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_30 = math.max(var_103_21, arg_100_1.talkMaxDuration)

			if var_103_20 <= arg_100_1.time_ and arg_100_1.time_ < var_103_20 + var_103_30 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_20) / var_103_30

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_20 + var_103_30 and arg_100_1.time_ < var_103_20 + var_103_30 + arg_103_0 then
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
			local var_107_0 = 0

			if var_107_0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_0 + arg_107_0 then
				arg_104_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_107_1 = 0.633333333333333

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 then
				arg_104_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action4_1")
			end

			local var_107_2 = 0
			local var_107_3 = 0.775

			if var_107_2 < arg_104_1.time_ and arg_104_1.time_ <= var_107_2 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_4 = arg_104_1:FormatText(StoryNameCfg[453].name)

				arg_104_1.leftNameTxt_.text = var_107_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_5 = arg_104_1:GetWordFromCfg(319631025)
				local var_107_6 = arg_104_1:FormatText(var_107_5.content)

				arg_104_1.text_.text = var_107_6

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_7 = 31
				local var_107_8 = utf8.len(var_107_6)
				local var_107_9 = var_107_7 <= 0 and var_107_3 or var_107_3 * (var_107_8 / var_107_7)

				if var_107_9 > 0 and var_107_3 < var_107_9 then
					arg_104_1.talkMaxDuration = var_107_9

					if var_107_9 + var_107_2 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_9 + var_107_2
					end
				end

				arg_104_1.text_.text = var_107_6
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631025", "story_v_out_319631.awb") ~= 0 then
					local var_107_10 = manager.audio:GetVoiceLength("story_v_out_319631", "319631025", "story_v_out_319631.awb") / 1000

					if var_107_10 + var_107_2 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_10 + var_107_2
					end

					if var_107_5.prefab_name ~= "" and arg_104_1.actors_[var_107_5.prefab_name] ~= nil then
						local var_107_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_5.prefab_name].transform, "story_v_out_319631", "319631025", "story_v_out_319631.awb")

						arg_104_1:RecordAudio("319631025", var_107_11)
						arg_104_1:RecordAudio("319631025", var_107_11)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_319631", "319631025", "story_v_out_319631.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_319631", "319631025", "story_v_out_319631.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_12 = math.max(var_107_3, arg_104_1.talkMaxDuration)

			if var_107_2 <= arg_104_1.time_ and arg_104_1.time_ < var_107_2 + var_107_12 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_2) / var_107_12

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_2 + var_107_12 and arg_104_1.time_ < var_107_2 + var_107_12 + arg_107_0 then
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
			local var_111_0 = arg_108_1.actors_["10079ui_story"].transform
			local var_111_1 = 0

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 then
				arg_108_1.var_.moveOldPos10079ui_story = var_111_0.localPosition
			end

			local var_111_2 = 0.001

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_2 then
				local var_111_3 = (arg_108_1.time_ - var_111_1) / var_111_2
				local var_111_4 = Vector3.New(0, -0.95, -6.05)

				var_111_0.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos10079ui_story, var_111_4, var_111_3)

				local var_111_5 = manager.ui.mainCamera.transform.position - var_111_0.position

				var_111_0.forward = Vector3.New(var_111_5.x, var_111_5.y, var_111_5.z)

				local var_111_6 = var_111_0.localEulerAngles

				var_111_6.z = 0
				var_111_6.x = 0
				var_111_0.localEulerAngles = var_111_6
			end

			if arg_108_1.time_ >= var_111_1 + var_111_2 and arg_108_1.time_ < var_111_1 + var_111_2 + arg_111_0 then
				var_111_0.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_111_7 = manager.ui.mainCamera.transform.position - var_111_0.position

				var_111_0.forward = Vector3.New(var_111_7.x, var_111_7.y, var_111_7.z)

				local var_111_8 = var_111_0.localEulerAngles

				var_111_8.z = 0
				var_111_8.x = 0
				var_111_0.localEulerAngles = var_111_8
			end

			local var_111_9 = arg_108_1.actors_["10079ui_story"]
			local var_111_10 = 0

			if var_111_10 < arg_108_1.time_ and arg_108_1.time_ <= var_111_10 + arg_111_0 and not isNil(var_111_9) and arg_108_1.var_.characterEffect10079ui_story == nil then
				arg_108_1.var_.characterEffect10079ui_story = var_111_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_11 = 0.200000002980232

			if var_111_10 <= arg_108_1.time_ and arg_108_1.time_ < var_111_10 + var_111_11 and not isNil(var_111_9) then
				local var_111_12 = (arg_108_1.time_ - var_111_10) / var_111_11

				if arg_108_1.var_.characterEffect10079ui_story and not isNil(var_111_9) then
					arg_108_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_108_1.time_ >= var_111_10 + var_111_11 and arg_108_1.time_ < var_111_10 + var_111_11 + arg_111_0 and not isNil(var_111_9) and arg_108_1.var_.characterEffect10079ui_story then
				arg_108_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_111_13 = 0

			if var_111_13 < arg_108_1.time_ and arg_108_1.time_ <= var_111_13 + arg_111_0 then
				arg_108_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_111_14 = 0

			if var_111_14 < arg_108_1.time_ and arg_108_1.time_ <= var_111_14 + arg_111_0 then
				arg_108_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_111_15 = arg_108_1.actors_["4037ui_story"].transform
			local var_111_16 = 0

			if var_111_16 < arg_108_1.time_ and arg_108_1.time_ <= var_111_16 + arg_111_0 then
				arg_108_1.var_.moveOldPos4037ui_story = var_111_15.localPosition
			end

			local var_111_17 = 0.001

			if var_111_16 <= arg_108_1.time_ and arg_108_1.time_ < var_111_16 + var_111_17 then
				local var_111_18 = (arg_108_1.time_ - var_111_16) / var_111_17
				local var_111_19 = Vector3.New(0, 100, 0)

				var_111_15.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos4037ui_story, var_111_19, var_111_18)

				local var_111_20 = manager.ui.mainCamera.transform.position - var_111_15.position

				var_111_15.forward = Vector3.New(var_111_20.x, var_111_20.y, var_111_20.z)

				local var_111_21 = var_111_15.localEulerAngles

				var_111_21.z = 0
				var_111_21.x = 0
				var_111_15.localEulerAngles = var_111_21
			end

			if arg_108_1.time_ >= var_111_16 + var_111_17 and arg_108_1.time_ < var_111_16 + var_111_17 + arg_111_0 then
				var_111_15.localPosition = Vector3.New(0, 100, 0)

				local var_111_22 = manager.ui.mainCamera.transform.position - var_111_15.position

				var_111_15.forward = Vector3.New(var_111_22.x, var_111_22.y, var_111_22.z)

				local var_111_23 = var_111_15.localEulerAngles

				var_111_23.z = 0
				var_111_23.x = 0
				var_111_15.localEulerAngles = var_111_23
			end

			local var_111_24 = arg_108_1.actors_["4037ui_story"]
			local var_111_25 = 0

			if var_111_25 < arg_108_1.time_ and arg_108_1.time_ <= var_111_25 + arg_111_0 and not isNil(var_111_24) and arg_108_1.var_.characterEffect4037ui_story == nil then
				arg_108_1.var_.characterEffect4037ui_story = var_111_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_26 = 0.200000002980232

			if var_111_25 <= arg_108_1.time_ and arg_108_1.time_ < var_111_25 + var_111_26 and not isNil(var_111_24) then
				local var_111_27 = (arg_108_1.time_ - var_111_25) / var_111_26

				if arg_108_1.var_.characterEffect4037ui_story and not isNil(var_111_24) then
					local var_111_28 = Mathf.Lerp(0, 0.5, var_111_27)

					arg_108_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_108_1.var_.characterEffect4037ui_story.fillRatio = var_111_28
				end
			end

			if arg_108_1.time_ >= var_111_25 + var_111_26 and arg_108_1.time_ < var_111_25 + var_111_26 + arg_111_0 and not isNil(var_111_24) and arg_108_1.var_.characterEffect4037ui_story then
				local var_111_29 = 0.5

				arg_108_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_108_1.var_.characterEffect4037ui_story.fillRatio = var_111_29
			end

			local var_111_30 = 0
			local var_111_31 = 0.125

			if var_111_30 < arg_108_1.time_ and arg_108_1.time_ <= var_111_30 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_32 = arg_108_1:FormatText(StoryNameCfg[6].name)

				arg_108_1.leftNameTxt_.text = var_111_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_33 = arg_108_1:GetWordFromCfg(319631026)
				local var_111_34 = arg_108_1:FormatText(var_111_33.content)

				arg_108_1.text_.text = var_111_34

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_35 = 5
				local var_111_36 = utf8.len(var_111_34)
				local var_111_37 = var_111_35 <= 0 and var_111_31 or var_111_31 * (var_111_36 / var_111_35)

				if var_111_37 > 0 and var_111_31 < var_111_37 then
					arg_108_1.talkMaxDuration = var_111_37

					if var_111_37 + var_111_30 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_37 + var_111_30
					end
				end

				arg_108_1.text_.text = var_111_34
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631026", "story_v_out_319631.awb") ~= 0 then
					local var_111_38 = manager.audio:GetVoiceLength("story_v_out_319631", "319631026", "story_v_out_319631.awb") / 1000

					if var_111_38 + var_111_30 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_38 + var_111_30
					end

					if var_111_33.prefab_name ~= "" and arg_108_1.actors_[var_111_33.prefab_name] ~= nil then
						local var_111_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_33.prefab_name].transform, "story_v_out_319631", "319631026", "story_v_out_319631.awb")

						arg_108_1:RecordAudio("319631026", var_111_39)
						arg_108_1:RecordAudio("319631026", var_111_39)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_319631", "319631026", "story_v_out_319631.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_319631", "319631026", "story_v_out_319631.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_40 = math.max(var_111_31, arg_108_1.talkMaxDuration)

			if var_111_30 <= arg_108_1.time_ and arg_108_1.time_ < var_111_30 + var_111_40 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_30) / var_111_40

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_30 + var_111_40 and arg_108_1.time_ < var_111_30 + var_111_40 + arg_111_0 then
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
			local var_115_0 = arg_112_1.actors_["1095ui_story"].transform
			local var_115_1 = 0

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 then
				arg_112_1.var_.moveOldPos1095ui_story = var_115_0.localPosition
			end

			local var_115_2 = 0.001

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_2 then
				local var_115_3 = (arg_112_1.time_ - var_115_1) / var_115_2
				local var_115_4 = Vector3.New(0.7, -0.98, -6.1)

				var_115_0.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos1095ui_story, var_115_4, var_115_3)

				local var_115_5 = manager.ui.mainCamera.transform.position - var_115_0.position

				var_115_0.forward = Vector3.New(var_115_5.x, var_115_5.y, var_115_5.z)

				local var_115_6 = var_115_0.localEulerAngles

				var_115_6.z = 0
				var_115_6.x = 0
				var_115_0.localEulerAngles = var_115_6
			end

			if arg_112_1.time_ >= var_115_1 + var_115_2 and arg_112_1.time_ < var_115_1 + var_115_2 + arg_115_0 then
				var_115_0.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_115_7 = manager.ui.mainCamera.transform.position - var_115_0.position

				var_115_0.forward = Vector3.New(var_115_7.x, var_115_7.y, var_115_7.z)

				local var_115_8 = var_115_0.localEulerAngles

				var_115_8.z = 0
				var_115_8.x = 0
				var_115_0.localEulerAngles = var_115_8
			end

			local var_115_9 = arg_112_1.actors_["1095ui_story"]
			local var_115_10 = 0

			if var_115_10 < arg_112_1.time_ and arg_112_1.time_ <= var_115_10 + arg_115_0 and not isNil(var_115_9) and arg_112_1.var_.characterEffect1095ui_story == nil then
				arg_112_1.var_.characterEffect1095ui_story = var_115_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_11 = 0.200000002980232

			if var_115_10 <= arg_112_1.time_ and arg_112_1.time_ < var_115_10 + var_115_11 and not isNil(var_115_9) then
				local var_115_12 = (arg_112_1.time_ - var_115_10) / var_115_11

				if arg_112_1.var_.characterEffect1095ui_story and not isNil(var_115_9) then
					arg_112_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_112_1.time_ >= var_115_10 + var_115_11 and arg_112_1.time_ < var_115_10 + var_115_11 + arg_115_0 and not isNil(var_115_9) and arg_112_1.var_.characterEffect1095ui_story then
				arg_112_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_115_13 = 0

			if var_115_13 < arg_112_1.time_ and arg_112_1.time_ <= var_115_13 + arg_115_0 then
				arg_112_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			local var_115_14 = 0

			if var_115_14 < arg_112_1.time_ and arg_112_1.time_ <= var_115_14 + arg_115_0 then
				arg_112_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_115_15 = arg_112_1.actors_["10079ui_story"].transform
			local var_115_16 = 0

			if var_115_16 < arg_112_1.time_ and arg_112_1.time_ <= var_115_16 + arg_115_0 then
				arg_112_1.var_.moveOldPos10079ui_story = var_115_15.localPosition
			end

			local var_115_17 = 0.001

			if var_115_16 <= arg_112_1.time_ and arg_112_1.time_ < var_115_16 + var_115_17 then
				local var_115_18 = (arg_112_1.time_ - var_115_16) / var_115_17
				local var_115_19 = Vector3.New(-0.7, -0.95, -6.05)

				var_115_15.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos10079ui_story, var_115_19, var_115_18)

				local var_115_20 = manager.ui.mainCamera.transform.position - var_115_15.position

				var_115_15.forward = Vector3.New(var_115_20.x, var_115_20.y, var_115_20.z)

				local var_115_21 = var_115_15.localEulerAngles

				var_115_21.z = 0
				var_115_21.x = 0
				var_115_15.localEulerAngles = var_115_21
			end

			if arg_112_1.time_ >= var_115_16 + var_115_17 and arg_112_1.time_ < var_115_16 + var_115_17 + arg_115_0 then
				var_115_15.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_115_22 = manager.ui.mainCamera.transform.position - var_115_15.position

				var_115_15.forward = Vector3.New(var_115_22.x, var_115_22.y, var_115_22.z)

				local var_115_23 = var_115_15.localEulerAngles

				var_115_23.z = 0
				var_115_23.x = 0
				var_115_15.localEulerAngles = var_115_23
			end

			local var_115_24 = arg_112_1.actors_["10079ui_story"]
			local var_115_25 = 0

			if var_115_25 < arg_112_1.time_ and arg_112_1.time_ <= var_115_25 + arg_115_0 and not isNil(var_115_24) and arg_112_1.var_.characterEffect10079ui_story == nil then
				arg_112_1.var_.characterEffect10079ui_story = var_115_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_26 = 0.200000002980232

			if var_115_25 <= arg_112_1.time_ and arg_112_1.time_ < var_115_25 + var_115_26 and not isNil(var_115_24) then
				local var_115_27 = (arg_112_1.time_ - var_115_25) / var_115_26

				if arg_112_1.var_.characterEffect10079ui_story and not isNil(var_115_24) then
					local var_115_28 = Mathf.Lerp(0, 0.5, var_115_27)

					arg_112_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_112_1.var_.characterEffect10079ui_story.fillRatio = var_115_28
				end
			end

			if arg_112_1.time_ >= var_115_25 + var_115_26 and arg_112_1.time_ < var_115_25 + var_115_26 + arg_115_0 and not isNil(var_115_24) and arg_112_1.var_.characterEffect10079ui_story then
				local var_115_29 = 0.5

				arg_112_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_112_1.var_.characterEffect10079ui_story.fillRatio = var_115_29
			end

			local var_115_30 = 0
			local var_115_31 = 0.725

			if var_115_30 < arg_112_1.time_ and arg_112_1.time_ <= var_115_30 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_32 = arg_112_1:FormatText(StoryNameCfg[471].name)

				arg_112_1.leftNameTxt_.text = var_115_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_33 = arg_112_1:GetWordFromCfg(319631027)
				local var_115_34 = arg_112_1:FormatText(var_115_33.content)

				arg_112_1.text_.text = var_115_34

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_35 = 29
				local var_115_36 = utf8.len(var_115_34)
				local var_115_37 = var_115_35 <= 0 and var_115_31 or var_115_31 * (var_115_36 / var_115_35)

				if var_115_37 > 0 and var_115_31 < var_115_37 then
					arg_112_1.talkMaxDuration = var_115_37

					if var_115_37 + var_115_30 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_37 + var_115_30
					end
				end

				arg_112_1.text_.text = var_115_34
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631027", "story_v_out_319631.awb") ~= 0 then
					local var_115_38 = manager.audio:GetVoiceLength("story_v_out_319631", "319631027", "story_v_out_319631.awb") / 1000

					if var_115_38 + var_115_30 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_38 + var_115_30
					end

					if var_115_33.prefab_name ~= "" and arg_112_1.actors_[var_115_33.prefab_name] ~= nil then
						local var_115_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_33.prefab_name].transform, "story_v_out_319631", "319631027", "story_v_out_319631.awb")

						arg_112_1:RecordAudio("319631027", var_115_39)
						arg_112_1:RecordAudio("319631027", var_115_39)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_319631", "319631027", "story_v_out_319631.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_319631", "319631027", "story_v_out_319631.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_40 = math.max(var_115_31, arg_112_1.talkMaxDuration)

			if var_115_30 <= arg_112_1.time_ and arg_112_1.time_ < var_115_30 + var_115_40 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_30) / var_115_40

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_30 + var_115_40 and arg_112_1.time_ < var_115_30 + var_115_40 + arg_115_0 then
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
			local var_119_0 = 0
			local var_119_1 = 0.625

			if var_119_0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_0 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_2 = arg_116_1:FormatText(StoryNameCfg[471].name)

				arg_116_1.leftNameTxt_.text = var_119_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_3 = arg_116_1:GetWordFromCfg(319631028)
				local var_119_4 = arg_116_1:FormatText(var_119_3.content)

				arg_116_1.text_.text = var_119_4

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_5 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631028", "story_v_out_319631.awb") ~= 0 then
					local var_119_8 = manager.audio:GetVoiceLength("story_v_out_319631", "319631028", "story_v_out_319631.awb") / 1000

					if var_119_8 + var_119_0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_8 + var_119_0
					end

					if var_119_3.prefab_name ~= "" and arg_116_1.actors_[var_119_3.prefab_name] ~= nil then
						local var_119_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_3.prefab_name].transform, "story_v_out_319631", "319631028", "story_v_out_319631.awb")

						arg_116_1:RecordAudio("319631028", var_119_9)
						arg_116_1:RecordAudio("319631028", var_119_9)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_319631", "319631028", "story_v_out_319631.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_319631", "319631028", "story_v_out_319631.awb")
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
			local var_123_0 = arg_120_1.actors_["10079ui_story"].transform
			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 then
				arg_120_1.var_.moveOldPos10079ui_story = var_123_0.localPosition
			end

			local var_123_2 = 0.001

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_2 then
				local var_123_3 = (arg_120_1.time_ - var_123_1) / var_123_2
				local var_123_4 = Vector3.New(-0.7, -0.95, -6.05)

				var_123_0.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos10079ui_story, var_123_4, var_123_3)

				local var_123_5 = manager.ui.mainCamera.transform.position - var_123_0.position

				var_123_0.forward = Vector3.New(var_123_5.x, var_123_5.y, var_123_5.z)

				local var_123_6 = var_123_0.localEulerAngles

				var_123_6.z = 0
				var_123_6.x = 0
				var_123_0.localEulerAngles = var_123_6
			end

			if arg_120_1.time_ >= var_123_1 + var_123_2 and arg_120_1.time_ < var_123_1 + var_123_2 + arg_123_0 then
				var_123_0.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_123_7 = manager.ui.mainCamera.transform.position - var_123_0.position

				var_123_0.forward = Vector3.New(var_123_7.x, var_123_7.y, var_123_7.z)

				local var_123_8 = var_123_0.localEulerAngles

				var_123_8.z = 0
				var_123_8.x = 0
				var_123_0.localEulerAngles = var_123_8
			end

			local var_123_9 = arg_120_1.actors_["10079ui_story"]
			local var_123_10 = 0

			if var_123_10 < arg_120_1.time_ and arg_120_1.time_ <= var_123_10 + arg_123_0 and not isNil(var_123_9) and arg_120_1.var_.characterEffect10079ui_story == nil then
				arg_120_1.var_.characterEffect10079ui_story = var_123_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_11 = 0.200000002980232

			if var_123_10 <= arg_120_1.time_ and arg_120_1.time_ < var_123_10 + var_123_11 and not isNil(var_123_9) then
				local var_123_12 = (arg_120_1.time_ - var_123_10) / var_123_11

				if arg_120_1.var_.characterEffect10079ui_story and not isNil(var_123_9) then
					arg_120_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_120_1.time_ >= var_123_10 + var_123_11 and arg_120_1.time_ < var_123_10 + var_123_11 + arg_123_0 and not isNil(var_123_9) and arg_120_1.var_.characterEffect10079ui_story then
				arg_120_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_123_13 = 0

			if var_123_13 < arg_120_1.time_ and arg_120_1.time_ <= var_123_13 + arg_123_0 then
				arg_120_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			local var_123_14 = 0

			if var_123_14 < arg_120_1.time_ and arg_120_1.time_ <= var_123_14 + arg_123_0 then
				arg_120_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_123_15 = arg_120_1.actors_["1095ui_story"]
			local var_123_16 = 0

			if var_123_16 < arg_120_1.time_ and arg_120_1.time_ <= var_123_16 + arg_123_0 and not isNil(var_123_15) and arg_120_1.var_.characterEffect1095ui_story == nil then
				arg_120_1.var_.characterEffect1095ui_story = var_123_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_17 = 0.200000002980232

			if var_123_16 <= arg_120_1.time_ and arg_120_1.time_ < var_123_16 + var_123_17 and not isNil(var_123_15) then
				local var_123_18 = (arg_120_1.time_ - var_123_16) / var_123_17

				if arg_120_1.var_.characterEffect1095ui_story and not isNil(var_123_15) then
					local var_123_19 = Mathf.Lerp(0, 0.5, var_123_18)

					arg_120_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_120_1.var_.characterEffect1095ui_story.fillRatio = var_123_19
				end
			end

			if arg_120_1.time_ >= var_123_16 + var_123_17 and arg_120_1.time_ < var_123_16 + var_123_17 + arg_123_0 and not isNil(var_123_15) and arg_120_1.var_.characterEffect1095ui_story then
				local var_123_20 = 0.5

				arg_120_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_120_1.var_.characterEffect1095ui_story.fillRatio = var_123_20
			end

			local var_123_21 = 0
			local var_123_22 = 0.225

			if var_123_21 < arg_120_1.time_ and arg_120_1.time_ <= var_123_21 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_23 = arg_120_1:FormatText(StoryNameCfg[6].name)

				arg_120_1.leftNameTxt_.text = var_123_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_24 = arg_120_1:GetWordFromCfg(319631029)
				local var_123_25 = arg_120_1:FormatText(var_123_24.content)

				arg_120_1.text_.text = var_123_25

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_26 = 9
				local var_123_27 = utf8.len(var_123_25)
				local var_123_28 = var_123_26 <= 0 and var_123_22 or var_123_22 * (var_123_27 / var_123_26)

				if var_123_28 > 0 and var_123_22 < var_123_28 then
					arg_120_1.talkMaxDuration = var_123_28

					if var_123_28 + var_123_21 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_28 + var_123_21
					end
				end

				arg_120_1.text_.text = var_123_25
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631029", "story_v_out_319631.awb") ~= 0 then
					local var_123_29 = manager.audio:GetVoiceLength("story_v_out_319631", "319631029", "story_v_out_319631.awb") / 1000

					if var_123_29 + var_123_21 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_29 + var_123_21
					end

					if var_123_24.prefab_name ~= "" and arg_120_1.actors_[var_123_24.prefab_name] ~= nil then
						local var_123_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_24.prefab_name].transform, "story_v_out_319631", "319631029", "story_v_out_319631.awb")

						arg_120_1:RecordAudio("319631029", var_123_30)
						arg_120_1:RecordAudio("319631029", var_123_30)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_319631", "319631029", "story_v_out_319631.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_319631", "319631029", "story_v_out_319631.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_31 = math.max(var_123_22, arg_120_1.talkMaxDuration)

			if var_123_21 <= arg_120_1.time_ and arg_120_1.time_ < var_123_21 + var_123_31 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_21) / var_123_31

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_21 + var_123_31 and arg_120_1.time_ < var_123_21 + var_123_31 + arg_123_0 then
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
			local var_127_0 = "10037ui_story"

			if arg_124_1.actors_[var_127_0] == nil then
				local var_127_1 = Asset.Load("Char/" .. "10037ui_story")

				if not isNil(var_127_1) then
					local var_127_2 = Object.Instantiate(Asset.Load("Char/" .. "10037ui_story"), arg_124_1.stage_.transform)

					var_127_2.name = var_127_0
					var_127_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_124_1.actors_[var_127_0] = var_127_2

					local var_127_3 = var_127_2:GetComponentInChildren(typeof(CharacterEffect))

					var_127_3.enabled = true

					local var_127_4 = GameObjectTools.GetOrAddComponent(var_127_2, typeof(DynamicBoneHelper))

					if var_127_4 then
						var_127_4:EnableDynamicBone(false)
					end

					arg_124_1:ShowWeapon(var_127_3.transform, false)

					arg_124_1.var_[var_127_0 .. "Animator"] = var_127_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_124_1.var_[var_127_0 .. "Animator"].applyRootMotion = true
					arg_124_1.var_[var_127_0 .. "LipSync"] = var_127_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_127_5 = arg_124_1.actors_["10037ui_story"].transform
			local var_127_6 = 0

			if var_127_6 < arg_124_1.time_ and arg_124_1.time_ <= var_127_6 + arg_127_0 then
				arg_124_1.var_.moveOldPos10037ui_story = var_127_5.localPosition

				local var_127_7 = "10037ui_story"

				arg_124_1:ShowWeapon(arg_124_1.var_[var_127_7 .. "Animator"].transform, false)
			end

			local var_127_8 = 0.001

			if var_127_6 <= arg_124_1.time_ and arg_124_1.time_ < var_127_6 + var_127_8 then
				local var_127_9 = (arg_124_1.time_ - var_127_6) / var_127_8
				local var_127_10 = Vector3.New(0, -1.13, -6.2)

				var_127_5.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos10037ui_story, var_127_10, var_127_9)

				local var_127_11 = manager.ui.mainCamera.transform.position - var_127_5.position

				var_127_5.forward = Vector3.New(var_127_11.x, var_127_11.y, var_127_11.z)

				local var_127_12 = var_127_5.localEulerAngles

				var_127_12.z = 0
				var_127_12.x = 0
				var_127_5.localEulerAngles = var_127_12
			end

			if arg_124_1.time_ >= var_127_6 + var_127_8 and arg_124_1.time_ < var_127_6 + var_127_8 + arg_127_0 then
				var_127_5.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_127_13 = manager.ui.mainCamera.transform.position - var_127_5.position

				var_127_5.forward = Vector3.New(var_127_13.x, var_127_13.y, var_127_13.z)

				local var_127_14 = var_127_5.localEulerAngles

				var_127_14.z = 0
				var_127_14.x = 0
				var_127_5.localEulerAngles = var_127_14
			end

			local var_127_15 = arg_124_1.actors_["10037ui_story"]
			local var_127_16 = 0

			if var_127_16 < arg_124_1.time_ and arg_124_1.time_ <= var_127_16 + arg_127_0 and not isNil(var_127_15) and arg_124_1.var_.characterEffect10037ui_story == nil then
				arg_124_1.var_.characterEffect10037ui_story = var_127_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_17 = 0.200000002980232

			if var_127_16 <= arg_124_1.time_ and arg_124_1.time_ < var_127_16 + var_127_17 and not isNil(var_127_15) then
				local var_127_18 = (arg_124_1.time_ - var_127_16) / var_127_17

				if arg_124_1.var_.characterEffect10037ui_story and not isNil(var_127_15) then
					arg_124_1.var_.characterEffect10037ui_story.fillFlat = false
				end
			end

			if arg_124_1.time_ >= var_127_16 + var_127_17 and arg_124_1.time_ < var_127_16 + var_127_17 + arg_127_0 and not isNil(var_127_15) and arg_124_1.var_.characterEffect10037ui_story then
				arg_124_1.var_.characterEffect10037ui_story.fillFlat = false
			end

			local var_127_19 = 0

			if var_127_19 < arg_124_1.time_ and arg_124_1.time_ <= var_127_19 + arg_127_0 then
				arg_124_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/story10037/story10037action/10037action1_1")
			end

			local var_127_20 = 0

			if var_127_20 < arg_124_1.time_ and arg_124_1.time_ <= var_127_20 + arg_127_0 then
				arg_124_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_127_21 = arg_124_1.actors_["1095ui_story"].transform
			local var_127_22 = 0

			if var_127_22 < arg_124_1.time_ and arg_124_1.time_ <= var_127_22 + arg_127_0 then
				arg_124_1.var_.moveOldPos1095ui_story = var_127_21.localPosition
			end

			local var_127_23 = 0.001

			if var_127_22 <= arg_124_1.time_ and arg_124_1.time_ < var_127_22 + var_127_23 then
				local var_127_24 = (arg_124_1.time_ - var_127_22) / var_127_23
				local var_127_25 = Vector3.New(0, 100, 0)

				var_127_21.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos1095ui_story, var_127_25, var_127_24)

				local var_127_26 = manager.ui.mainCamera.transform.position - var_127_21.position

				var_127_21.forward = Vector3.New(var_127_26.x, var_127_26.y, var_127_26.z)

				local var_127_27 = var_127_21.localEulerAngles

				var_127_27.z = 0
				var_127_27.x = 0
				var_127_21.localEulerAngles = var_127_27
			end

			if arg_124_1.time_ >= var_127_22 + var_127_23 and arg_124_1.time_ < var_127_22 + var_127_23 + arg_127_0 then
				var_127_21.localPosition = Vector3.New(0, 100, 0)

				local var_127_28 = manager.ui.mainCamera.transform.position - var_127_21.position

				var_127_21.forward = Vector3.New(var_127_28.x, var_127_28.y, var_127_28.z)

				local var_127_29 = var_127_21.localEulerAngles

				var_127_29.z = 0
				var_127_29.x = 0
				var_127_21.localEulerAngles = var_127_29
			end

			local var_127_30 = arg_124_1.actors_["1095ui_story"]
			local var_127_31 = 0

			if var_127_31 < arg_124_1.time_ and arg_124_1.time_ <= var_127_31 + arg_127_0 and not isNil(var_127_30) and arg_124_1.var_.characterEffect1095ui_story == nil then
				arg_124_1.var_.characterEffect1095ui_story = var_127_30:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_32 = 0.200000002980232

			if var_127_31 <= arg_124_1.time_ and arg_124_1.time_ < var_127_31 + var_127_32 and not isNil(var_127_30) then
				local var_127_33 = (arg_124_1.time_ - var_127_31) / var_127_32

				if arg_124_1.var_.characterEffect1095ui_story and not isNil(var_127_30) then
					local var_127_34 = Mathf.Lerp(0, 0.5, var_127_33)

					arg_124_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_124_1.var_.characterEffect1095ui_story.fillRatio = var_127_34
				end
			end

			if arg_124_1.time_ >= var_127_31 + var_127_32 and arg_124_1.time_ < var_127_31 + var_127_32 + arg_127_0 and not isNil(var_127_30) and arg_124_1.var_.characterEffect1095ui_story then
				local var_127_35 = 0.5

				arg_124_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_124_1.var_.characterEffect1095ui_story.fillRatio = var_127_35
			end

			local var_127_36 = arg_124_1.actors_["10079ui_story"].transform
			local var_127_37 = 0

			if var_127_37 < arg_124_1.time_ and arg_124_1.time_ <= var_127_37 + arg_127_0 then
				arg_124_1.var_.moveOldPos10079ui_story = var_127_36.localPosition
			end

			local var_127_38 = 0.001

			if var_127_37 <= arg_124_1.time_ and arg_124_1.time_ < var_127_37 + var_127_38 then
				local var_127_39 = (arg_124_1.time_ - var_127_37) / var_127_38
				local var_127_40 = Vector3.New(0, 100, 0)

				var_127_36.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos10079ui_story, var_127_40, var_127_39)

				local var_127_41 = manager.ui.mainCamera.transform.position - var_127_36.position

				var_127_36.forward = Vector3.New(var_127_41.x, var_127_41.y, var_127_41.z)

				local var_127_42 = var_127_36.localEulerAngles

				var_127_42.z = 0
				var_127_42.x = 0
				var_127_36.localEulerAngles = var_127_42
			end

			if arg_124_1.time_ >= var_127_37 + var_127_38 and arg_124_1.time_ < var_127_37 + var_127_38 + arg_127_0 then
				var_127_36.localPosition = Vector3.New(0, 100, 0)

				local var_127_43 = manager.ui.mainCamera.transform.position - var_127_36.position

				var_127_36.forward = Vector3.New(var_127_43.x, var_127_43.y, var_127_43.z)

				local var_127_44 = var_127_36.localEulerAngles

				var_127_44.z = 0
				var_127_44.x = 0
				var_127_36.localEulerAngles = var_127_44
			end

			local var_127_45 = arg_124_1.actors_["10079ui_story"]
			local var_127_46 = 0

			if var_127_46 < arg_124_1.time_ and arg_124_1.time_ <= var_127_46 + arg_127_0 and not isNil(var_127_45) and arg_124_1.var_.characterEffect10079ui_story == nil then
				arg_124_1.var_.characterEffect10079ui_story = var_127_45:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_47 = 0.200000002980232

			if var_127_46 <= arg_124_1.time_ and arg_124_1.time_ < var_127_46 + var_127_47 and not isNil(var_127_45) then
				local var_127_48 = (arg_124_1.time_ - var_127_46) / var_127_47

				if arg_124_1.var_.characterEffect10079ui_story and not isNil(var_127_45) then
					local var_127_49 = Mathf.Lerp(0, 0.5, var_127_48)

					arg_124_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_124_1.var_.characterEffect10079ui_story.fillRatio = var_127_49
				end
			end

			if arg_124_1.time_ >= var_127_46 + var_127_47 and arg_124_1.time_ < var_127_46 + var_127_47 + arg_127_0 and not isNil(var_127_45) and arg_124_1.var_.characterEffect10079ui_story then
				local var_127_50 = 0.5

				arg_124_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_124_1.var_.characterEffect10079ui_story.fillRatio = var_127_50
			end

			local var_127_51 = 0
			local var_127_52 = 0.4

			if var_127_51 < arg_124_1.time_ and arg_124_1.time_ <= var_127_51 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_53 = arg_124_1:FormatText(StoryNameCfg[383].name)

				arg_124_1.leftNameTxt_.text = var_127_53

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_54 = arg_124_1:GetWordFromCfg(319631030)
				local var_127_55 = arg_124_1:FormatText(var_127_54.content)

				arg_124_1.text_.text = var_127_55

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_56 = 16
				local var_127_57 = utf8.len(var_127_55)
				local var_127_58 = var_127_56 <= 0 and var_127_52 or var_127_52 * (var_127_57 / var_127_56)

				if var_127_58 > 0 and var_127_52 < var_127_58 then
					arg_124_1.talkMaxDuration = var_127_58

					if var_127_58 + var_127_51 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_58 + var_127_51
					end
				end

				arg_124_1.text_.text = var_127_55
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631030", "story_v_out_319631.awb") ~= 0 then
					local var_127_59 = manager.audio:GetVoiceLength("story_v_out_319631", "319631030", "story_v_out_319631.awb") / 1000

					if var_127_59 + var_127_51 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_59 + var_127_51
					end

					if var_127_54.prefab_name ~= "" and arg_124_1.actors_[var_127_54.prefab_name] ~= nil then
						local var_127_60 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_54.prefab_name].transform, "story_v_out_319631", "319631030", "story_v_out_319631.awb")

						arg_124_1:RecordAudio("319631030", var_127_60)
						arg_124_1:RecordAudio("319631030", var_127_60)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_319631", "319631030", "story_v_out_319631.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_319631", "319631030", "story_v_out_319631.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_61 = math.max(var_127_52, arg_124_1.talkMaxDuration)

			if var_127_51 <= arg_124_1.time_ and arg_124_1.time_ < var_127_51 + var_127_61 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_51) / var_127_61

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_51 + var_127_61 and arg_124_1.time_ < var_127_51 + var_127_61 + arg_127_0 then
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
			local var_131_0 = arg_128_1.actors_["4037ui_story"].transform
			local var_131_1 = 0

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 then
				arg_128_1.var_.moveOldPos4037ui_story = var_131_0.localPosition
			end

			local var_131_2 = 0.001

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_2 then
				local var_131_3 = (arg_128_1.time_ - var_131_1) / var_131_2
				local var_131_4 = Vector3.New(0, -1.12, -6.2)

				var_131_0.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos4037ui_story, var_131_4, var_131_3)

				local var_131_5 = manager.ui.mainCamera.transform.position - var_131_0.position

				var_131_0.forward = Vector3.New(var_131_5.x, var_131_5.y, var_131_5.z)

				local var_131_6 = var_131_0.localEulerAngles

				var_131_6.z = 0
				var_131_6.x = 0
				var_131_0.localEulerAngles = var_131_6
			end

			if arg_128_1.time_ >= var_131_1 + var_131_2 and arg_128_1.time_ < var_131_1 + var_131_2 + arg_131_0 then
				var_131_0.localPosition = Vector3.New(0, -1.12, -6.2)

				local var_131_7 = manager.ui.mainCamera.transform.position - var_131_0.position

				var_131_0.forward = Vector3.New(var_131_7.x, var_131_7.y, var_131_7.z)

				local var_131_8 = var_131_0.localEulerAngles

				var_131_8.z = 0
				var_131_8.x = 0
				var_131_0.localEulerAngles = var_131_8
			end

			local var_131_9 = arg_128_1.actors_["4037ui_story"]
			local var_131_10 = 0

			if var_131_10 < arg_128_1.time_ and arg_128_1.time_ <= var_131_10 + arg_131_0 and not isNil(var_131_9) and arg_128_1.var_.characterEffect4037ui_story == nil then
				arg_128_1.var_.characterEffect4037ui_story = var_131_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_11 = 0.200000002980232

			if var_131_10 <= arg_128_1.time_ and arg_128_1.time_ < var_131_10 + var_131_11 and not isNil(var_131_9) then
				local var_131_12 = (arg_128_1.time_ - var_131_10) / var_131_11

				if arg_128_1.var_.characterEffect4037ui_story and not isNil(var_131_9) then
					arg_128_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= var_131_10 + var_131_11 and arg_128_1.time_ < var_131_10 + var_131_11 + arg_131_0 and not isNil(var_131_9) and arg_128_1.var_.characterEffect4037ui_story then
				arg_128_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_131_13 = arg_128_1.actors_["10037ui_story"].transform
			local var_131_14 = 0

			if var_131_14 < arg_128_1.time_ and arg_128_1.time_ <= var_131_14 + arg_131_0 then
				arg_128_1.var_.moveOldPos10037ui_story = var_131_13.localPosition
			end

			local var_131_15 = 0.001

			if var_131_14 <= arg_128_1.time_ and arg_128_1.time_ < var_131_14 + var_131_15 then
				local var_131_16 = (arg_128_1.time_ - var_131_14) / var_131_15
				local var_131_17 = Vector3.New(0, 100, 0)

				var_131_13.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos10037ui_story, var_131_17, var_131_16)

				local var_131_18 = manager.ui.mainCamera.transform.position - var_131_13.position

				var_131_13.forward = Vector3.New(var_131_18.x, var_131_18.y, var_131_18.z)

				local var_131_19 = var_131_13.localEulerAngles

				var_131_19.z = 0
				var_131_19.x = 0
				var_131_13.localEulerAngles = var_131_19
			end

			if arg_128_1.time_ >= var_131_14 + var_131_15 and arg_128_1.time_ < var_131_14 + var_131_15 + arg_131_0 then
				var_131_13.localPosition = Vector3.New(0, 100, 0)

				local var_131_20 = manager.ui.mainCamera.transform.position - var_131_13.position

				var_131_13.forward = Vector3.New(var_131_20.x, var_131_20.y, var_131_20.z)

				local var_131_21 = var_131_13.localEulerAngles

				var_131_21.z = 0
				var_131_21.x = 0
				var_131_13.localEulerAngles = var_131_21
			end

			local var_131_22 = arg_128_1.actors_["10037ui_story"]
			local var_131_23 = 0

			if var_131_23 < arg_128_1.time_ and arg_128_1.time_ <= var_131_23 + arg_131_0 and not isNil(var_131_22) and arg_128_1.var_.characterEffect10037ui_story == nil then
				arg_128_1.var_.characterEffect10037ui_story = var_131_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_24 = 0.200000002980232

			if var_131_23 <= arg_128_1.time_ and arg_128_1.time_ < var_131_23 + var_131_24 and not isNil(var_131_22) then
				local var_131_25 = (arg_128_1.time_ - var_131_23) / var_131_24

				if arg_128_1.var_.characterEffect10037ui_story and not isNil(var_131_22) then
					local var_131_26 = Mathf.Lerp(0, 0.5, var_131_25)

					arg_128_1.var_.characterEffect10037ui_story.fillFlat = true
					arg_128_1.var_.characterEffect10037ui_story.fillRatio = var_131_26
				end
			end

			if arg_128_1.time_ >= var_131_23 + var_131_24 and arg_128_1.time_ < var_131_23 + var_131_24 + arg_131_0 and not isNil(var_131_22) and arg_128_1.var_.characterEffect10037ui_story then
				local var_131_27 = 0.5

				arg_128_1.var_.characterEffect10037ui_story.fillFlat = true
				arg_128_1.var_.characterEffect10037ui_story.fillRatio = var_131_27
			end

			local var_131_28 = 0

			if var_131_28 < arg_128_1.time_ and arg_128_1.time_ <= var_131_28 + arg_131_0 then
				arg_128_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action4_2")
			end

			local var_131_29 = 0

			if var_131_29 < arg_128_1.time_ and arg_128_1.time_ <= var_131_29 + arg_131_0 then
				arg_128_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_131_30 = 0
			local var_131_31 = 1.25

			if var_131_30 < arg_128_1.time_ and arg_128_1.time_ <= var_131_30 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_32 = arg_128_1:FormatText(StoryNameCfg[453].name)

				arg_128_1.leftNameTxt_.text = var_131_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_33 = arg_128_1:GetWordFromCfg(319631031)
				local var_131_34 = arg_128_1:FormatText(var_131_33.content)

				arg_128_1.text_.text = var_131_34

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_35 = 50
				local var_131_36 = utf8.len(var_131_34)
				local var_131_37 = var_131_35 <= 0 and var_131_31 or var_131_31 * (var_131_36 / var_131_35)

				if var_131_37 > 0 and var_131_31 < var_131_37 then
					arg_128_1.talkMaxDuration = var_131_37

					if var_131_37 + var_131_30 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_37 + var_131_30
					end
				end

				arg_128_1.text_.text = var_131_34
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631031", "story_v_out_319631.awb") ~= 0 then
					local var_131_38 = manager.audio:GetVoiceLength("story_v_out_319631", "319631031", "story_v_out_319631.awb") / 1000

					if var_131_38 + var_131_30 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_38 + var_131_30
					end

					if var_131_33.prefab_name ~= "" and arg_128_1.actors_[var_131_33.prefab_name] ~= nil then
						local var_131_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_33.prefab_name].transform, "story_v_out_319631", "319631031", "story_v_out_319631.awb")

						arg_128_1:RecordAudio("319631031", var_131_39)
						arg_128_1:RecordAudio("319631031", var_131_39)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_319631", "319631031", "story_v_out_319631.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_319631", "319631031", "story_v_out_319631.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_40 = math.max(var_131_31, arg_128_1.talkMaxDuration)

			if var_131_30 <= arg_128_1.time_ and arg_128_1.time_ < var_131_30 + var_131_40 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_30) / var_131_40

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_30 + var_131_40 and arg_128_1.time_ < var_131_30 + var_131_40 + arg_131_0 then
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
			local var_135_0 = 0
			local var_135_1 = 0.625

			if var_135_0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_0 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_2 = arg_132_1:FormatText(StoryNameCfg[453].name)

				arg_132_1.leftNameTxt_.text = var_135_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_3 = arg_132_1:GetWordFromCfg(319631032)
				local var_135_4 = arg_132_1:FormatText(var_135_3.content)

				arg_132_1.text_.text = var_135_4

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_5 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631032", "story_v_out_319631.awb") ~= 0 then
					local var_135_8 = manager.audio:GetVoiceLength("story_v_out_319631", "319631032", "story_v_out_319631.awb") / 1000

					if var_135_8 + var_135_0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_8 + var_135_0
					end

					if var_135_3.prefab_name ~= "" and arg_132_1.actors_[var_135_3.prefab_name] ~= nil then
						local var_135_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_3.prefab_name].transform, "story_v_out_319631", "319631032", "story_v_out_319631.awb")

						arg_132_1:RecordAudio("319631032", var_135_9)
						arg_132_1:RecordAudio("319631032", var_135_9)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_319631", "319631032", "story_v_out_319631.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_319631", "319631032", "story_v_out_319631.awb")
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
			local var_139_0 = arg_136_1.actors_["4037ui_story"]
			local var_139_1 = 0

			if var_139_1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect4037ui_story == nil then
				arg_136_1.var_.characterEffect4037ui_story = var_139_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_2 = 0.200000002980232

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_2 and not isNil(var_139_0) then
				local var_139_3 = (arg_136_1.time_ - var_139_1) / var_139_2

				if arg_136_1.var_.characterEffect4037ui_story and not isNil(var_139_0) then
					local var_139_4 = Mathf.Lerp(0, 0.5, var_139_3)

					arg_136_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_136_1.var_.characterEffect4037ui_story.fillRatio = var_139_4
				end
			end

			if arg_136_1.time_ >= var_139_1 + var_139_2 and arg_136_1.time_ < var_139_1 + var_139_2 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect4037ui_story then
				local var_139_5 = 0.5

				arg_136_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_136_1.var_.characterEffect4037ui_story.fillRatio = var_139_5
			end

			local var_139_6 = 0
			local var_139_7 = 0.725

			if var_139_6 < arg_136_1.time_ and arg_136_1.time_ <= var_139_6 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, false)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_8 = arg_136_1:GetWordFromCfg(319631033)
				local var_139_9 = arg_136_1:FormatText(var_139_8.content)

				arg_136_1.text_.text = var_139_9

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_10 = 29
				local var_139_11 = utf8.len(var_139_9)
				local var_139_12 = var_139_10 <= 0 and var_139_7 or var_139_7 * (var_139_11 / var_139_10)

				if var_139_12 > 0 and var_139_7 < var_139_12 then
					arg_136_1.talkMaxDuration = var_139_12

					if var_139_12 + var_139_6 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_12 + var_139_6
					end
				end

				arg_136_1.text_.text = var_139_9
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)
				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_13 = math.max(var_139_7, arg_136_1.talkMaxDuration)

			if var_139_6 <= arg_136_1.time_ and arg_136_1.time_ < var_139_6 + var_139_13 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_6) / var_139_13

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_6 + var_139_13 and arg_136_1.time_ < var_139_6 + var_139_13 + arg_139_0 then
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
			local var_143_0 = arg_140_1.actors_["4037ui_story"]
			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect4037ui_story == nil then
				arg_140_1.var_.characterEffect4037ui_story = var_143_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_2 = 0.200000002980232

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_2 and not isNil(var_143_0) then
				local var_143_3 = (arg_140_1.time_ - var_143_1) / var_143_2

				if arg_140_1.var_.characterEffect4037ui_story and not isNil(var_143_0) then
					arg_140_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_140_1.time_ >= var_143_1 + var_143_2 and arg_140_1.time_ < var_143_1 + var_143_2 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect4037ui_story then
				arg_140_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_143_4 = 0
			local var_143_5 = 1

			if var_143_4 < arg_140_1.time_ and arg_140_1.time_ <= var_143_4 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_6 = arg_140_1:FormatText(StoryNameCfg[453].name)

				arg_140_1.leftNameTxt_.text = var_143_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_7 = arg_140_1:GetWordFromCfg(319631034)
				local var_143_8 = arg_140_1:FormatText(var_143_7.content)

				arg_140_1.text_.text = var_143_8

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_9 = 40
				local var_143_10 = utf8.len(var_143_8)
				local var_143_11 = var_143_9 <= 0 and var_143_5 or var_143_5 * (var_143_10 / var_143_9)

				if var_143_11 > 0 and var_143_5 < var_143_11 then
					arg_140_1.talkMaxDuration = var_143_11

					if var_143_11 + var_143_4 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_11 + var_143_4
					end
				end

				arg_140_1.text_.text = var_143_8
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631034", "story_v_out_319631.awb") ~= 0 then
					local var_143_12 = manager.audio:GetVoiceLength("story_v_out_319631", "319631034", "story_v_out_319631.awb") / 1000

					if var_143_12 + var_143_4 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_12 + var_143_4
					end

					if var_143_7.prefab_name ~= "" and arg_140_1.actors_[var_143_7.prefab_name] ~= nil then
						local var_143_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_7.prefab_name].transform, "story_v_out_319631", "319631034", "story_v_out_319631.awb")

						arg_140_1:RecordAudio("319631034", var_143_13)
						arg_140_1:RecordAudio("319631034", var_143_13)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_319631", "319631034", "story_v_out_319631.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_319631", "319631034", "story_v_out_319631.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_14 = math.max(var_143_5, arg_140_1.talkMaxDuration)

			if var_143_4 <= arg_140_1.time_ and arg_140_1.time_ < var_143_4 + var_143_14 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_4) / var_143_14

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_4 + var_143_14 and arg_140_1.time_ < var_143_4 + var_143_14 + arg_143_0 then
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
			local var_147_0 = 0
			local var_147_1 = 0.95

			if var_147_0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_0 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_2 = arg_144_1:FormatText(StoryNameCfg[453].name)

				arg_144_1.leftNameTxt_.text = var_147_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_3 = arg_144_1:GetWordFromCfg(319631035)
				local var_147_4 = arg_144_1:FormatText(var_147_3.content)

				arg_144_1.text_.text = var_147_4

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_5 = 38
				local var_147_6 = utf8.len(var_147_4)
				local var_147_7 = var_147_5 <= 0 and var_147_1 or var_147_1 * (var_147_6 / var_147_5)

				if var_147_7 > 0 and var_147_1 < var_147_7 then
					arg_144_1.talkMaxDuration = var_147_7

					if var_147_7 + var_147_0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_7 + var_147_0
					end
				end

				arg_144_1.text_.text = var_147_4
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631035", "story_v_out_319631.awb") ~= 0 then
					local var_147_8 = manager.audio:GetVoiceLength("story_v_out_319631", "319631035", "story_v_out_319631.awb") / 1000

					if var_147_8 + var_147_0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_8 + var_147_0
					end

					if var_147_3.prefab_name ~= "" and arg_144_1.actors_[var_147_3.prefab_name] ~= nil then
						local var_147_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_3.prefab_name].transform, "story_v_out_319631", "319631035", "story_v_out_319631.awb")

						arg_144_1:RecordAudio("319631035", var_147_9)
						arg_144_1:RecordAudio("319631035", var_147_9)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_319631", "319631035", "story_v_out_319631.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_319631", "319631035", "story_v_out_319631.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_10 = math.max(var_147_1, arg_144_1.talkMaxDuration)

			if var_147_0 <= arg_144_1.time_ and arg_144_1.time_ < var_147_0 + var_147_10 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_0) / var_147_10

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_0 + var_147_10 and arg_144_1.time_ < var_147_0 + var_147_10 + arg_147_0 then
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
			local var_151_0 = arg_148_1.actors_["4037ui_story"].transform
			local var_151_1 = 0

			if var_151_1 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 then
				arg_148_1.var_.moveOldPos4037ui_story = var_151_0.localPosition
			end

			local var_151_2 = 0.001

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_2 then
				local var_151_3 = (arg_148_1.time_ - var_151_1) / var_151_2
				local var_151_4 = Vector3.New(0, -1.12, -6.2)

				var_151_0.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos4037ui_story, var_151_4, var_151_3)

				local var_151_5 = manager.ui.mainCamera.transform.position - var_151_0.position

				var_151_0.forward = Vector3.New(var_151_5.x, var_151_5.y, var_151_5.z)

				local var_151_6 = var_151_0.localEulerAngles

				var_151_6.z = 0
				var_151_6.x = 0
				var_151_0.localEulerAngles = var_151_6
			end

			if arg_148_1.time_ >= var_151_1 + var_151_2 and arg_148_1.time_ < var_151_1 + var_151_2 + arg_151_0 then
				var_151_0.localPosition = Vector3.New(0, -1.12, -6.2)

				local var_151_7 = manager.ui.mainCamera.transform.position - var_151_0.position

				var_151_0.forward = Vector3.New(var_151_7.x, var_151_7.y, var_151_7.z)

				local var_151_8 = var_151_0.localEulerAngles

				var_151_8.z = 0
				var_151_8.x = 0
				var_151_0.localEulerAngles = var_151_8
			end

			local var_151_9 = 0

			if var_151_9 < arg_148_1.time_ and arg_148_1.time_ <= var_151_9 + arg_151_0 then
				arg_148_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action3_1")
			end

			local var_151_10 = 0

			if var_151_10 < arg_148_1.time_ and arg_148_1.time_ <= var_151_10 + arg_151_0 then
				arg_148_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_151_11 = 0
			local var_151_12 = 0.95

			if var_151_11 < arg_148_1.time_ and arg_148_1.time_ <= var_151_11 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				local var_151_13 = arg_148_1:FormatText(StoryNameCfg[453].name)

				arg_148_1.leftNameTxt_.text = var_151_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_14 = arg_148_1:GetWordFromCfg(319631036)
				local var_151_15 = arg_148_1:FormatText(var_151_14.content)

				arg_148_1.text_.text = var_151_15

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_16 = 38
				local var_151_17 = utf8.len(var_151_15)
				local var_151_18 = var_151_16 <= 0 and var_151_12 or var_151_12 * (var_151_17 / var_151_16)

				if var_151_18 > 0 and var_151_12 < var_151_18 then
					arg_148_1.talkMaxDuration = var_151_18

					if var_151_18 + var_151_11 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_18 + var_151_11
					end
				end

				arg_148_1.text_.text = var_151_15
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631036", "story_v_out_319631.awb") ~= 0 then
					local var_151_19 = manager.audio:GetVoiceLength("story_v_out_319631", "319631036", "story_v_out_319631.awb") / 1000

					if var_151_19 + var_151_11 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_19 + var_151_11
					end

					if var_151_14.prefab_name ~= "" and arg_148_1.actors_[var_151_14.prefab_name] ~= nil then
						local var_151_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_14.prefab_name].transform, "story_v_out_319631", "319631036", "story_v_out_319631.awb")

						arg_148_1:RecordAudio("319631036", var_151_20)
						arg_148_1:RecordAudio("319631036", var_151_20)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_319631", "319631036", "story_v_out_319631.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_319631", "319631036", "story_v_out_319631.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_21 = math.max(var_151_12, arg_148_1.talkMaxDuration)

			if var_151_11 <= arg_148_1.time_ and arg_148_1.time_ < var_151_11 + var_151_21 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_11) / var_151_21

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_11 + var_151_21 and arg_148_1.time_ < var_151_11 + var_151_21 + arg_151_0 then
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
			local var_155_0 = arg_152_1.actors_["10079ui_story"].transform
			local var_155_1 = 0

			if var_155_1 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 then
				arg_152_1.var_.moveOldPos10079ui_story = var_155_0.localPosition
			end

			local var_155_2 = 0.001

			if var_155_1 <= arg_152_1.time_ and arg_152_1.time_ < var_155_1 + var_155_2 then
				local var_155_3 = (arg_152_1.time_ - var_155_1) / var_155_2
				local var_155_4 = Vector3.New(0, -0.95, -6.05)

				var_155_0.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos10079ui_story, var_155_4, var_155_3)

				local var_155_5 = manager.ui.mainCamera.transform.position - var_155_0.position

				var_155_0.forward = Vector3.New(var_155_5.x, var_155_5.y, var_155_5.z)

				local var_155_6 = var_155_0.localEulerAngles

				var_155_6.z = 0
				var_155_6.x = 0
				var_155_0.localEulerAngles = var_155_6
			end

			if arg_152_1.time_ >= var_155_1 + var_155_2 and arg_152_1.time_ < var_155_1 + var_155_2 + arg_155_0 then
				var_155_0.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_155_7 = manager.ui.mainCamera.transform.position - var_155_0.position

				var_155_0.forward = Vector3.New(var_155_7.x, var_155_7.y, var_155_7.z)

				local var_155_8 = var_155_0.localEulerAngles

				var_155_8.z = 0
				var_155_8.x = 0
				var_155_0.localEulerAngles = var_155_8
			end

			local var_155_9 = arg_152_1.actors_["10079ui_story"]
			local var_155_10 = 0

			if var_155_10 < arg_152_1.time_ and arg_152_1.time_ <= var_155_10 + arg_155_0 and not isNil(var_155_9) and arg_152_1.var_.characterEffect10079ui_story == nil then
				arg_152_1.var_.characterEffect10079ui_story = var_155_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_11 = 0.200000002980232

			if var_155_10 <= arg_152_1.time_ and arg_152_1.time_ < var_155_10 + var_155_11 and not isNil(var_155_9) then
				local var_155_12 = (arg_152_1.time_ - var_155_10) / var_155_11

				if arg_152_1.var_.characterEffect10079ui_story and not isNil(var_155_9) then
					arg_152_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= var_155_10 + var_155_11 and arg_152_1.time_ < var_155_10 + var_155_11 + arg_155_0 and not isNil(var_155_9) and arg_152_1.var_.characterEffect10079ui_story then
				arg_152_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_155_13 = 0

			if var_155_13 < arg_152_1.time_ and arg_152_1.time_ <= var_155_13 + arg_155_0 then
				arg_152_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_2")
			end

			local var_155_14 = 0

			if var_155_14 < arg_152_1.time_ and arg_152_1.time_ <= var_155_14 + arg_155_0 then
				arg_152_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_155_15 = arg_152_1.actors_["4037ui_story"].transform
			local var_155_16 = 0

			if var_155_16 < arg_152_1.time_ and arg_152_1.time_ <= var_155_16 + arg_155_0 then
				arg_152_1.var_.moveOldPos4037ui_story = var_155_15.localPosition
			end

			local var_155_17 = 0.001

			if var_155_16 <= arg_152_1.time_ and arg_152_1.time_ < var_155_16 + var_155_17 then
				local var_155_18 = (arg_152_1.time_ - var_155_16) / var_155_17
				local var_155_19 = Vector3.New(0, 100, 0)

				var_155_15.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos4037ui_story, var_155_19, var_155_18)

				local var_155_20 = manager.ui.mainCamera.transform.position - var_155_15.position

				var_155_15.forward = Vector3.New(var_155_20.x, var_155_20.y, var_155_20.z)

				local var_155_21 = var_155_15.localEulerAngles

				var_155_21.z = 0
				var_155_21.x = 0
				var_155_15.localEulerAngles = var_155_21
			end

			if arg_152_1.time_ >= var_155_16 + var_155_17 and arg_152_1.time_ < var_155_16 + var_155_17 + arg_155_0 then
				var_155_15.localPosition = Vector3.New(0, 100, 0)

				local var_155_22 = manager.ui.mainCamera.transform.position - var_155_15.position

				var_155_15.forward = Vector3.New(var_155_22.x, var_155_22.y, var_155_22.z)

				local var_155_23 = var_155_15.localEulerAngles

				var_155_23.z = 0
				var_155_23.x = 0
				var_155_15.localEulerAngles = var_155_23
			end

			local var_155_24 = arg_152_1.actors_["4037ui_story"]
			local var_155_25 = 0

			if var_155_25 < arg_152_1.time_ and arg_152_1.time_ <= var_155_25 + arg_155_0 and not isNil(var_155_24) and arg_152_1.var_.characterEffect4037ui_story == nil then
				arg_152_1.var_.characterEffect4037ui_story = var_155_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_26 = 0.200000002980232

			if var_155_25 <= arg_152_1.time_ and arg_152_1.time_ < var_155_25 + var_155_26 and not isNil(var_155_24) then
				local var_155_27 = (arg_152_1.time_ - var_155_25) / var_155_26

				if arg_152_1.var_.characterEffect4037ui_story and not isNil(var_155_24) then
					local var_155_28 = Mathf.Lerp(0, 0.5, var_155_27)

					arg_152_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_152_1.var_.characterEffect4037ui_story.fillRatio = var_155_28
				end
			end

			if arg_152_1.time_ >= var_155_25 + var_155_26 and arg_152_1.time_ < var_155_25 + var_155_26 + arg_155_0 and not isNil(var_155_24) and arg_152_1.var_.characterEffect4037ui_story then
				local var_155_29 = 0.5

				arg_152_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_152_1.var_.characterEffect4037ui_story.fillRatio = var_155_29
			end

			local var_155_30 = 0
			local var_155_31 = 0.4

			if var_155_30 < arg_152_1.time_ and arg_152_1.time_ <= var_155_30 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_32 = arg_152_1:FormatText(StoryNameCfg[6].name)

				arg_152_1.leftNameTxt_.text = var_155_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_33 = arg_152_1:GetWordFromCfg(319631037)
				local var_155_34 = arg_152_1:FormatText(var_155_33.content)

				arg_152_1.text_.text = var_155_34

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_35 = 16
				local var_155_36 = utf8.len(var_155_34)
				local var_155_37 = var_155_35 <= 0 and var_155_31 or var_155_31 * (var_155_36 / var_155_35)

				if var_155_37 > 0 and var_155_31 < var_155_37 then
					arg_152_1.talkMaxDuration = var_155_37

					if var_155_37 + var_155_30 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_37 + var_155_30
					end
				end

				arg_152_1.text_.text = var_155_34
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631037", "story_v_out_319631.awb") ~= 0 then
					local var_155_38 = manager.audio:GetVoiceLength("story_v_out_319631", "319631037", "story_v_out_319631.awb") / 1000

					if var_155_38 + var_155_30 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_38 + var_155_30
					end

					if var_155_33.prefab_name ~= "" and arg_152_1.actors_[var_155_33.prefab_name] ~= nil then
						local var_155_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_33.prefab_name].transform, "story_v_out_319631", "319631037", "story_v_out_319631.awb")

						arg_152_1:RecordAudio("319631037", var_155_39)
						arg_152_1:RecordAudio("319631037", var_155_39)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_319631", "319631037", "story_v_out_319631.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_319631", "319631037", "story_v_out_319631.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_40 = math.max(var_155_31, arg_152_1.talkMaxDuration)

			if var_155_30 <= arg_152_1.time_ and arg_152_1.time_ < var_155_30 + var_155_40 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_30) / var_155_40

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_30 + var_155_40 and arg_152_1.time_ < var_155_30 + var_155_40 + arg_155_0 then
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
			local var_159_0 = arg_156_1.actors_["4037ui_story"].transform
			local var_159_1 = 0

			if var_159_1 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 then
				arg_156_1.var_.moveOldPos4037ui_story = var_159_0.localPosition
			end

			local var_159_2 = 0.001

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_2 then
				local var_159_3 = (arg_156_1.time_ - var_159_1) / var_159_2
				local var_159_4 = Vector3.New(-0.7, -1.12, -6.2)

				var_159_0.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos4037ui_story, var_159_4, var_159_3)

				local var_159_5 = manager.ui.mainCamera.transform.position - var_159_0.position

				var_159_0.forward = Vector3.New(var_159_5.x, var_159_5.y, var_159_5.z)

				local var_159_6 = var_159_0.localEulerAngles

				var_159_6.z = 0
				var_159_6.x = 0
				var_159_0.localEulerAngles = var_159_6
			end

			if arg_156_1.time_ >= var_159_1 + var_159_2 and arg_156_1.time_ < var_159_1 + var_159_2 + arg_159_0 then
				var_159_0.localPosition = Vector3.New(-0.7, -1.12, -6.2)

				local var_159_7 = manager.ui.mainCamera.transform.position - var_159_0.position

				var_159_0.forward = Vector3.New(var_159_7.x, var_159_7.y, var_159_7.z)

				local var_159_8 = var_159_0.localEulerAngles

				var_159_8.z = 0
				var_159_8.x = 0
				var_159_0.localEulerAngles = var_159_8
			end

			local var_159_9 = arg_156_1.actors_["4037ui_story"]
			local var_159_10 = 0

			if var_159_10 < arg_156_1.time_ and arg_156_1.time_ <= var_159_10 + arg_159_0 and not isNil(var_159_9) and arg_156_1.var_.characterEffect4037ui_story == nil then
				arg_156_1.var_.characterEffect4037ui_story = var_159_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_11 = 0.200000002980232

			if var_159_10 <= arg_156_1.time_ and arg_156_1.time_ < var_159_10 + var_159_11 and not isNil(var_159_9) then
				local var_159_12 = (arg_156_1.time_ - var_159_10) / var_159_11

				if arg_156_1.var_.characterEffect4037ui_story and not isNil(var_159_9) then
					arg_156_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_156_1.time_ >= var_159_10 + var_159_11 and arg_156_1.time_ < var_159_10 + var_159_11 + arg_159_0 and not isNil(var_159_9) and arg_156_1.var_.characterEffect4037ui_story then
				arg_156_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_159_13 = arg_156_1.actors_["10079ui_story"].transform
			local var_159_14 = 0

			if var_159_14 < arg_156_1.time_ and arg_156_1.time_ <= var_159_14 + arg_159_0 then
				arg_156_1.var_.moveOldPos10079ui_story = var_159_13.localPosition
			end

			local var_159_15 = 0.001

			if var_159_14 <= arg_156_1.time_ and arg_156_1.time_ < var_159_14 + var_159_15 then
				local var_159_16 = (arg_156_1.time_ - var_159_14) / var_159_15
				local var_159_17 = Vector3.New(0.7, -0.95, -6.05)

				var_159_13.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos10079ui_story, var_159_17, var_159_16)

				local var_159_18 = manager.ui.mainCamera.transform.position - var_159_13.position

				var_159_13.forward = Vector3.New(var_159_18.x, var_159_18.y, var_159_18.z)

				local var_159_19 = var_159_13.localEulerAngles

				var_159_19.z = 0
				var_159_19.x = 0
				var_159_13.localEulerAngles = var_159_19
			end

			if arg_156_1.time_ >= var_159_14 + var_159_15 and arg_156_1.time_ < var_159_14 + var_159_15 + arg_159_0 then
				var_159_13.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_159_20 = manager.ui.mainCamera.transform.position - var_159_13.position

				var_159_13.forward = Vector3.New(var_159_20.x, var_159_20.y, var_159_20.z)

				local var_159_21 = var_159_13.localEulerAngles

				var_159_21.z = 0
				var_159_21.x = 0
				var_159_13.localEulerAngles = var_159_21
			end

			local var_159_22 = arg_156_1.actors_["10079ui_story"]
			local var_159_23 = 0

			if var_159_23 < arg_156_1.time_ and arg_156_1.time_ <= var_159_23 + arg_159_0 and not isNil(var_159_22) and arg_156_1.var_.characterEffect10079ui_story == nil then
				arg_156_1.var_.characterEffect10079ui_story = var_159_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_24 = 0.200000002980232

			if var_159_23 <= arg_156_1.time_ and arg_156_1.time_ < var_159_23 + var_159_24 and not isNil(var_159_22) then
				local var_159_25 = (arg_156_1.time_ - var_159_23) / var_159_24

				if arg_156_1.var_.characterEffect10079ui_story and not isNil(var_159_22) then
					local var_159_26 = Mathf.Lerp(0, 0.5, var_159_25)

					arg_156_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_156_1.var_.characterEffect10079ui_story.fillRatio = var_159_26
				end
			end

			if arg_156_1.time_ >= var_159_23 + var_159_24 and arg_156_1.time_ < var_159_23 + var_159_24 + arg_159_0 and not isNil(var_159_22) and arg_156_1.var_.characterEffect10079ui_story then
				local var_159_27 = 0.5

				arg_156_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_156_1.var_.characterEffect10079ui_story.fillRatio = var_159_27
			end

			local var_159_28 = 0
			local var_159_29 = 0.55

			if var_159_28 < arg_156_1.time_ and arg_156_1.time_ <= var_159_28 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_30 = arg_156_1:FormatText(StoryNameCfg[453].name)

				arg_156_1.leftNameTxt_.text = var_159_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_31 = arg_156_1:GetWordFromCfg(319631038)
				local var_159_32 = arg_156_1:FormatText(var_159_31.content)

				arg_156_1.text_.text = var_159_32

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_33 = 22
				local var_159_34 = utf8.len(var_159_32)
				local var_159_35 = var_159_33 <= 0 and var_159_29 or var_159_29 * (var_159_34 / var_159_33)

				if var_159_35 > 0 and var_159_29 < var_159_35 then
					arg_156_1.talkMaxDuration = var_159_35

					if var_159_35 + var_159_28 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_35 + var_159_28
					end
				end

				arg_156_1.text_.text = var_159_32
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631038", "story_v_out_319631.awb") ~= 0 then
					local var_159_36 = manager.audio:GetVoiceLength("story_v_out_319631", "319631038", "story_v_out_319631.awb") / 1000

					if var_159_36 + var_159_28 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_36 + var_159_28
					end

					if var_159_31.prefab_name ~= "" and arg_156_1.actors_[var_159_31.prefab_name] ~= nil then
						local var_159_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_31.prefab_name].transform, "story_v_out_319631", "319631038", "story_v_out_319631.awb")

						arg_156_1:RecordAudio("319631038", var_159_37)
						arg_156_1:RecordAudio("319631038", var_159_37)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_319631", "319631038", "story_v_out_319631.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_319631", "319631038", "story_v_out_319631.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_38 = math.max(var_159_29, arg_156_1.talkMaxDuration)

			if var_159_28 <= arg_156_1.time_ and arg_156_1.time_ < var_159_28 + var_159_38 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_28) / var_159_38

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_28 + var_159_38 and arg_156_1.time_ < var_159_28 + var_159_38 + arg_159_0 then
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
			local var_163_0 = arg_160_1.actors_["10079ui_story"].transform
			local var_163_1 = 0

			if var_163_1 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 then
				arg_160_1.var_.moveOldPos10079ui_story = var_163_0.localPosition
			end

			local var_163_2 = 0.001

			if var_163_1 <= arg_160_1.time_ and arg_160_1.time_ < var_163_1 + var_163_2 then
				local var_163_3 = (arg_160_1.time_ - var_163_1) / var_163_2
				local var_163_4 = Vector3.New(0.7, -0.95, -6.05)

				var_163_0.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos10079ui_story, var_163_4, var_163_3)

				local var_163_5 = manager.ui.mainCamera.transform.position - var_163_0.position

				var_163_0.forward = Vector3.New(var_163_5.x, var_163_5.y, var_163_5.z)

				local var_163_6 = var_163_0.localEulerAngles

				var_163_6.z = 0
				var_163_6.x = 0
				var_163_0.localEulerAngles = var_163_6
			end

			if arg_160_1.time_ >= var_163_1 + var_163_2 and arg_160_1.time_ < var_163_1 + var_163_2 + arg_163_0 then
				var_163_0.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_163_7 = manager.ui.mainCamera.transform.position - var_163_0.position

				var_163_0.forward = Vector3.New(var_163_7.x, var_163_7.y, var_163_7.z)

				local var_163_8 = var_163_0.localEulerAngles

				var_163_8.z = 0
				var_163_8.x = 0
				var_163_0.localEulerAngles = var_163_8
			end

			local var_163_9 = arg_160_1.actors_["10079ui_story"]
			local var_163_10 = 0

			if var_163_10 < arg_160_1.time_ and arg_160_1.time_ <= var_163_10 + arg_163_0 and not isNil(var_163_9) and arg_160_1.var_.characterEffect10079ui_story == nil then
				arg_160_1.var_.characterEffect10079ui_story = var_163_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_11 = 0.200000002980232

			if var_163_10 <= arg_160_1.time_ and arg_160_1.time_ < var_163_10 + var_163_11 and not isNil(var_163_9) then
				local var_163_12 = (arg_160_1.time_ - var_163_10) / var_163_11

				if arg_160_1.var_.characterEffect10079ui_story and not isNil(var_163_9) then
					arg_160_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_160_1.time_ >= var_163_10 + var_163_11 and arg_160_1.time_ < var_163_10 + var_163_11 + arg_163_0 and not isNil(var_163_9) and arg_160_1.var_.characterEffect10079ui_story then
				arg_160_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_163_13 = 0

			if var_163_13 < arg_160_1.time_ and arg_160_1.time_ <= var_163_13 + arg_163_0 then
				arg_160_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			local var_163_14 = 0

			if var_163_14 < arg_160_1.time_ and arg_160_1.time_ <= var_163_14 + arg_163_0 then
				arg_160_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_163_15 = arg_160_1.actors_["4037ui_story"].transform
			local var_163_16 = 0

			if var_163_16 < arg_160_1.time_ and arg_160_1.time_ <= var_163_16 + arg_163_0 then
				arg_160_1.var_.moveOldPos4037ui_story = var_163_15.localPosition
			end

			local var_163_17 = 0.001

			if var_163_16 <= arg_160_1.time_ and arg_160_1.time_ < var_163_16 + var_163_17 then
				local var_163_18 = (arg_160_1.time_ - var_163_16) / var_163_17
				local var_163_19 = Vector3.New(-0.7, -1.12, -6.2)

				var_163_15.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos4037ui_story, var_163_19, var_163_18)

				local var_163_20 = manager.ui.mainCamera.transform.position - var_163_15.position

				var_163_15.forward = Vector3.New(var_163_20.x, var_163_20.y, var_163_20.z)

				local var_163_21 = var_163_15.localEulerAngles

				var_163_21.z = 0
				var_163_21.x = 0
				var_163_15.localEulerAngles = var_163_21
			end

			if arg_160_1.time_ >= var_163_16 + var_163_17 and arg_160_1.time_ < var_163_16 + var_163_17 + arg_163_0 then
				var_163_15.localPosition = Vector3.New(-0.7, -1.12, -6.2)

				local var_163_22 = manager.ui.mainCamera.transform.position - var_163_15.position

				var_163_15.forward = Vector3.New(var_163_22.x, var_163_22.y, var_163_22.z)

				local var_163_23 = var_163_15.localEulerAngles

				var_163_23.z = 0
				var_163_23.x = 0
				var_163_15.localEulerAngles = var_163_23
			end

			local var_163_24 = arg_160_1.actors_["4037ui_story"]
			local var_163_25 = 0

			if var_163_25 < arg_160_1.time_ and arg_160_1.time_ <= var_163_25 + arg_163_0 and not isNil(var_163_24) and arg_160_1.var_.characterEffect4037ui_story == nil then
				arg_160_1.var_.characterEffect4037ui_story = var_163_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_26 = 0.200000002980232

			if var_163_25 <= arg_160_1.time_ and arg_160_1.time_ < var_163_25 + var_163_26 and not isNil(var_163_24) then
				local var_163_27 = (arg_160_1.time_ - var_163_25) / var_163_26

				if arg_160_1.var_.characterEffect4037ui_story and not isNil(var_163_24) then
					local var_163_28 = Mathf.Lerp(0, 0.5, var_163_27)

					arg_160_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_160_1.var_.characterEffect4037ui_story.fillRatio = var_163_28
				end
			end

			if arg_160_1.time_ >= var_163_25 + var_163_26 and arg_160_1.time_ < var_163_25 + var_163_26 + arg_163_0 and not isNil(var_163_24) and arg_160_1.var_.characterEffect4037ui_story then
				local var_163_29 = 0.5

				arg_160_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_160_1.var_.characterEffect4037ui_story.fillRatio = var_163_29
			end

			local var_163_30 = 0
			local var_163_31 = 0.525

			if var_163_30 < arg_160_1.time_ and arg_160_1.time_ <= var_163_30 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				local var_163_32 = arg_160_1:FormatText(StoryNameCfg[6].name)

				arg_160_1.leftNameTxt_.text = var_163_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_33 = arg_160_1:GetWordFromCfg(319631039)
				local var_163_34 = arg_160_1:FormatText(var_163_33.content)

				arg_160_1.text_.text = var_163_34

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_35 = 21
				local var_163_36 = utf8.len(var_163_34)
				local var_163_37 = var_163_35 <= 0 and var_163_31 or var_163_31 * (var_163_36 / var_163_35)

				if var_163_37 > 0 and var_163_31 < var_163_37 then
					arg_160_1.talkMaxDuration = var_163_37

					if var_163_37 + var_163_30 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_37 + var_163_30
					end
				end

				arg_160_1.text_.text = var_163_34
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631039", "story_v_out_319631.awb") ~= 0 then
					local var_163_38 = manager.audio:GetVoiceLength("story_v_out_319631", "319631039", "story_v_out_319631.awb") / 1000

					if var_163_38 + var_163_30 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_38 + var_163_30
					end

					if var_163_33.prefab_name ~= "" and arg_160_1.actors_[var_163_33.prefab_name] ~= nil then
						local var_163_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_33.prefab_name].transform, "story_v_out_319631", "319631039", "story_v_out_319631.awb")

						arg_160_1:RecordAudio("319631039", var_163_39)
						arg_160_1:RecordAudio("319631039", var_163_39)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_319631", "319631039", "story_v_out_319631.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_319631", "319631039", "story_v_out_319631.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_40 = math.max(var_163_31, arg_160_1.talkMaxDuration)

			if var_163_30 <= arg_160_1.time_ and arg_160_1.time_ < var_163_30 + var_163_40 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_30) / var_163_40

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_30 + var_163_40 and arg_160_1.time_ < var_163_30 + var_163_40 + arg_163_0 then
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
			local var_167_0 = arg_164_1.actors_["4037ui_story"].transform
			local var_167_1 = 0

			if var_167_1 < arg_164_1.time_ and arg_164_1.time_ <= var_167_1 + arg_167_0 then
				arg_164_1.var_.moveOldPos4037ui_story = var_167_0.localPosition
			end

			local var_167_2 = 0.001

			if var_167_1 <= arg_164_1.time_ and arg_164_1.time_ < var_167_1 + var_167_2 then
				local var_167_3 = (arg_164_1.time_ - var_167_1) / var_167_2
				local var_167_4 = Vector3.New(-0.7, -1.12, -6.2)

				var_167_0.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos4037ui_story, var_167_4, var_167_3)

				local var_167_5 = manager.ui.mainCamera.transform.position - var_167_0.position

				var_167_0.forward = Vector3.New(var_167_5.x, var_167_5.y, var_167_5.z)

				local var_167_6 = var_167_0.localEulerAngles

				var_167_6.z = 0
				var_167_6.x = 0
				var_167_0.localEulerAngles = var_167_6
			end

			if arg_164_1.time_ >= var_167_1 + var_167_2 and arg_164_1.time_ < var_167_1 + var_167_2 + arg_167_0 then
				var_167_0.localPosition = Vector3.New(-0.7, -1.12, -6.2)

				local var_167_7 = manager.ui.mainCamera.transform.position - var_167_0.position

				var_167_0.forward = Vector3.New(var_167_7.x, var_167_7.y, var_167_7.z)

				local var_167_8 = var_167_0.localEulerAngles

				var_167_8.z = 0
				var_167_8.x = 0
				var_167_0.localEulerAngles = var_167_8
			end

			local var_167_9 = arg_164_1.actors_["4037ui_story"]
			local var_167_10 = 0

			if var_167_10 < arg_164_1.time_ and arg_164_1.time_ <= var_167_10 + arg_167_0 and not isNil(var_167_9) and arg_164_1.var_.characterEffect4037ui_story == nil then
				arg_164_1.var_.characterEffect4037ui_story = var_167_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_11 = 0.200000002980232

			if var_167_10 <= arg_164_1.time_ and arg_164_1.time_ < var_167_10 + var_167_11 and not isNil(var_167_9) then
				local var_167_12 = (arg_164_1.time_ - var_167_10) / var_167_11

				if arg_164_1.var_.characterEffect4037ui_story and not isNil(var_167_9) then
					arg_164_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_164_1.time_ >= var_167_10 + var_167_11 and arg_164_1.time_ < var_167_10 + var_167_11 + arg_167_0 and not isNil(var_167_9) and arg_164_1.var_.characterEffect4037ui_story then
				arg_164_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_167_13 = 0

			if var_167_13 < arg_164_1.time_ and arg_164_1.time_ <= var_167_13 + arg_167_0 then
				arg_164_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action3_2")
			end

			local var_167_14 = 0

			if var_167_14 < arg_164_1.time_ and arg_164_1.time_ <= var_167_14 + arg_167_0 then
				arg_164_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_167_15 = arg_164_1.actors_["10079ui_story"].transform
			local var_167_16 = 0

			if var_167_16 < arg_164_1.time_ and arg_164_1.time_ <= var_167_16 + arg_167_0 then
				arg_164_1.var_.moveOldPos10079ui_story = var_167_15.localPosition
			end

			local var_167_17 = 0.001

			if var_167_16 <= arg_164_1.time_ and arg_164_1.time_ < var_167_16 + var_167_17 then
				local var_167_18 = (arg_164_1.time_ - var_167_16) / var_167_17
				local var_167_19 = Vector3.New(0.7, -0.95, -6.05)

				var_167_15.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos10079ui_story, var_167_19, var_167_18)

				local var_167_20 = manager.ui.mainCamera.transform.position - var_167_15.position

				var_167_15.forward = Vector3.New(var_167_20.x, var_167_20.y, var_167_20.z)

				local var_167_21 = var_167_15.localEulerAngles

				var_167_21.z = 0
				var_167_21.x = 0
				var_167_15.localEulerAngles = var_167_21
			end

			if arg_164_1.time_ >= var_167_16 + var_167_17 and arg_164_1.time_ < var_167_16 + var_167_17 + arg_167_0 then
				var_167_15.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_167_22 = manager.ui.mainCamera.transform.position - var_167_15.position

				var_167_15.forward = Vector3.New(var_167_22.x, var_167_22.y, var_167_22.z)

				local var_167_23 = var_167_15.localEulerAngles

				var_167_23.z = 0
				var_167_23.x = 0
				var_167_15.localEulerAngles = var_167_23
			end

			local var_167_24 = arg_164_1.actors_["10079ui_story"]
			local var_167_25 = 0

			if var_167_25 < arg_164_1.time_ and arg_164_1.time_ <= var_167_25 + arg_167_0 and not isNil(var_167_24) and arg_164_1.var_.characterEffect10079ui_story == nil then
				arg_164_1.var_.characterEffect10079ui_story = var_167_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_26 = 0.200000002980232

			if var_167_25 <= arg_164_1.time_ and arg_164_1.time_ < var_167_25 + var_167_26 and not isNil(var_167_24) then
				local var_167_27 = (arg_164_1.time_ - var_167_25) / var_167_26

				if arg_164_1.var_.characterEffect10079ui_story and not isNil(var_167_24) then
					local var_167_28 = Mathf.Lerp(0, 0.5, var_167_27)

					arg_164_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_164_1.var_.characterEffect10079ui_story.fillRatio = var_167_28
				end
			end

			if arg_164_1.time_ >= var_167_25 + var_167_26 and arg_164_1.time_ < var_167_25 + var_167_26 + arg_167_0 and not isNil(var_167_24) and arg_164_1.var_.characterEffect10079ui_story then
				local var_167_29 = 0.5

				arg_164_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_164_1.var_.characterEffect10079ui_story.fillRatio = var_167_29
			end

			local var_167_30 = 0
			local var_167_31 = 0.1

			if var_167_30 < arg_164_1.time_ and arg_164_1.time_ <= var_167_30 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				local var_167_32 = arg_164_1:FormatText(StoryNameCfg[453].name)

				arg_164_1.leftNameTxt_.text = var_167_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_33 = arg_164_1:GetWordFromCfg(319631040)
				local var_167_34 = arg_164_1:FormatText(var_167_33.content)

				arg_164_1.text_.text = var_167_34

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_35 = 4
				local var_167_36 = utf8.len(var_167_34)
				local var_167_37 = var_167_35 <= 0 and var_167_31 or var_167_31 * (var_167_36 / var_167_35)

				if var_167_37 > 0 and var_167_31 < var_167_37 then
					arg_164_1.talkMaxDuration = var_167_37

					if var_167_37 + var_167_30 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_37 + var_167_30
					end
				end

				arg_164_1.text_.text = var_167_34
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631040", "story_v_out_319631.awb") ~= 0 then
					local var_167_38 = manager.audio:GetVoiceLength("story_v_out_319631", "319631040", "story_v_out_319631.awb") / 1000

					if var_167_38 + var_167_30 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_38 + var_167_30
					end

					if var_167_33.prefab_name ~= "" and arg_164_1.actors_[var_167_33.prefab_name] ~= nil then
						local var_167_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_33.prefab_name].transform, "story_v_out_319631", "319631040", "story_v_out_319631.awb")

						arg_164_1:RecordAudio("319631040", var_167_39)
						arg_164_1:RecordAudio("319631040", var_167_39)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_319631", "319631040", "story_v_out_319631.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_319631", "319631040", "story_v_out_319631.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_40 = math.max(var_167_31, arg_164_1.talkMaxDuration)

			if var_167_30 <= arg_164_1.time_ and arg_164_1.time_ < var_167_30 + var_167_40 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_30) / var_167_40

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_30 + var_167_40 and arg_164_1.time_ < var_167_30 + var_167_40 + arg_167_0 then
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
			local var_171_0 = arg_168_1.actors_["10079ui_story"]
			local var_171_1 = 0

			if var_171_1 < arg_168_1.time_ and arg_168_1.time_ <= var_171_1 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.characterEffect10079ui_story == nil then
				arg_168_1.var_.characterEffect10079ui_story = var_171_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_2 = 0.200000002980232

			if var_171_1 <= arg_168_1.time_ and arg_168_1.time_ < var_171_1 + var_171_2 and not isNil(var_171_0) then
				local var_171_3 = (arg_168_1.time_ - var_171_1) / var_171_2

				if arg_168_1.var_.characterEffect10079ui_story and not isNil(var_171_0) then
					arg_168_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_168_1.time_ >= var_171_1 + var_171_2 and arg_168_1.time_ < var_171_1 + var_171_2 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.characterEffect10079ui_story then
				arg_168_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_171_4 = 0

			if var_171_4 < arg_168_1.time_ and arg_168_1.time_ <= var_171_4 + arg_171_0 then
				arg_168_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			local var_171_5 = 0

			if var_171_5 < arg_168_1.time_ and arg_168_1.time_ <= var_171_5 + arg_171_0 then
				arg_168_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_171_6 = arg_168_1.actors_["4037ui_story"]
			local var_171_7 = 0

			if var_171_7 < arg_168_1.time_ and arg_168_1.time_ <= var_171_7 + arg_171_0 and not isNil(var_171_6) and arg_168_1.var_.characterEffect4037ui_story == nil then
				arg_168_1.var_.characterEffect4037ui_story = var_171_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_8 = 0.200000002980232

			if var_171_7 <= arg_168_1.time_ and arg_168_1.time_ < var_171_7 + var_171_8 and not isNil(var_171_6) then
				local var_171_9 = (arg_168_1.time_ - var_171_7) / var_171_8

				if arg_168_1.var_.characterEffect4037ui_story and not isNil(var_171_6) then
					local var_171_10 = Mathf.Lerp(0, 0.5, var_171_9)

					arg_168_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_168_1.var_.characterEffect4037ui_story.fillRatio = var_171_10
				end
			end

			if arg_168_1.time_ >= var_171_7 + var_171_8 and arg_168_1.time_ < var_171_7 + var_171_8 + arg_171_0 and not isNil(var_171_6) and arg_168_1.var_.characterEffect4037ui_story then
				local var_171_11 = 0.5

				arg_168_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_168_1.var_.characterEffect4037ui_story.fillRatio = var_171_11
			end

			local var_171_12 = 0
			local var_171_13 = 0.45

			if var_171_12 < arg_168_1.time_ and arg_168_1.time_ <= var_171_12 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				local var_171_14 = arg_168_1:FormatText(StoryNameCfg[6].name)

				arg_168_1.leftNameTxt_.text = var_171_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_15 = arg_168_1:GetWordFromCfg(319631041)
				local var_171_16 = arg_168_1:FormatText(var_171_15.content)

				arg_168_1.text_.text = var_171_16

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_17 = 18
				local var_171_18 = utf8.len(var_171_16)
				local var_171_19 = var_171_17 <= 0 and var_171_13 or var_171_13 * (var_171_18 / var_171_17)

				if var_171_19 > 0 and var_171_13 < var_171_19 then
					arg_168_1.talkMaxDuration = var_171_19

					if var_171_19 + var_171_12 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_19 + var_171_12
					end
				end

				arg_168_1.text_.text = var_171_16
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631041", "story_v_out_319631.awb") ~= 0 then
					local var_171_20 = manager.audio:GetVoiceLength("story_v_out_319631", "319631041", "story_v_out_319631.awb") / 1000

					if var_171_20 + var_171_12 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_20 + var_171_12
					end

					if var_171_15.prefab_name ~= "" and arg_168_1.actors_[var_171_15.prefab_name] ~= nil then
						local var_171_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_15.prefab_name].transform, "story_v_out_319631", "319631041", "story_v_out_319631.awb")

						arg_168_1:RecordAudio("319631041", var_171_21)
						arg_168_1:RecordAudio("319631041", var_171_21)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_319631", "319631041", "story_v_out_319631.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_319631", "319631041", "story_v_out_319631.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_22 = math.max(var_171_13, arg_168_1.talkMaxDuration)

			if var_171_12 <= arg_168_1.time_ and arg_168_1.time_ < var_171_12 + var_171_22 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_12) / var_171_22

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_12 + var_171_22 and arg_168_1.time_ < var_171_12 + var_171_22 + arg_171_0 then
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
			local var_175_0 = arg_172_1.actors_["4037ui_story"]
			local var_175_1 = 0

			if var_175_1 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.characterEffect4037ui_story == nil then
				arg_172_1.var_.characterEffect4037ui_story = var_175_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_2 = 0.200000002980232

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_2 and not isNil(var_175_0) then
				local var_175_3 = (arg_172_1.time_ - var_175_1) / var_175_2

				if arg_172_1.var_.characterEffect4037ui_story and not isNil(var_175_0) then
					arg_172_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_172_1.time_ >= var_175_1 + var_175_2 and arg_172_1.time_ < var_175_1 + var_175_2 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.characterEffect4037ui_story then
				arg_172_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_175_4 = 0

			if var_175_4 < arg_172_1.time_ and arg_172_1.time_ <= var_175_4 + arg_175_0 then
				arg_172_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			local var_175_5 = 0

			if var_175_5 < arg_172_1.time_ and arg_172_1.time_ <= var_175_5 + arg_175_0 then
				arg_172_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_175_6 = arg_172_1.actors_["10079ui_story"]
			local var_175_7 = 0

			if var_175_7 < arg_172_1.time_ and arg_172_1.time_ <= var_175_7 + arg_175_0 and not isNil(var_175_6) and arg_172_1.var_.characterEffect10079ui_story == nil then
				arg_172_1.var_.characterEffect10079ui_story = var_175_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_8 = 0.200000002980232

			if var_175_7 <= arg_172_1.time_ and arg_172_1.time_ < var_175_7 + var_175_8 and not isNil(var_175_6) then
				local var_175_9 = (arg_172_1.time_ - var_175_7) / var_175_8

				if arg_172_1.var_.characterEffect10079ui_story and not isNil(var_175_6) then
					local var_175_10 = Mathf.Lerp(0, 0.5, var_175_9)

					arg_172_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_172_1.var_.characterEffect10079ui_story.fillRatio = var_175_10
				end
			end

			if arg_172_1.time_ >= var_175_7 + var_175_8 and arg_172_1.time_ < var_175_7 + var_175_8 + arg_175_0 and not isNil(var_175_6) and arg_172_1.var_.characterEffect10079ui_story then
				local var_175_11 = 0.5

				arg_172_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_172_1.var_.characterEffect10079ui_story.fillRatio = var_175_11
			end

			local var_175_12 = 0
			local var_175_13 = 0.775

			if var_175_12 < arg_172_1.time_ and arg_172_1.time_ <= var_175_12 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				local var_175_14 = arg_172_1:FormatText(StoryNameCfg[453].name)

				arg_172_1.leftNameTxt_.text = var_175_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_15 = arg_172_1:GetWordFromCfg(319631042)
				local var_175_16 = arg_172_1:FormatText(var_175_15.content)

				arg_172_1.text_.text = var_175_16

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_17 = 31
				local var_175_18 = utf8.len(var_175_16)
				local var_175_19 = var_175_17 <= 0 and var_175_13 or var_175_13 * (var_175_18 / var_175_17)

				if var_175_19 > 0 and var_175_13 < var_175_19 then
					arg_172_1.talkMaxDuration = var_175_19

					if var_175_19 + var_175_12 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_19 + var_175_12
					end
				end

				arg_172_1.text_.text = var_175_16
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631042", "story_v_out_319631.awb") ~= 0 then
					local var_175_20 = manager.audio:GetVoiceLength("story_v_out_319631", "319631042", "story_v_out_319631.awb") / 1000

					if var_175_20 + var_175_12 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_20 + var_175_12
					end

					if var_175_15.prefab_name ~= "" and arg_172_1.actors_[var_175_15.prefab_name] ~= nil then
						local var_175_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_15.prefab_name].transform, "story_v_out_319631", "319631042", "story_v_out_319631.awb")

						arg_172_1:RecordAudio("319631042", var_175_21)
						arg_172_1:RecordAudio("319631042", var_175_21)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_319631", "319631042", "story_v_out_319631.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_319631", "319631042", "story_v_out_319631.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_22 = math.max(var_175_13, arg_172_1.talkMaxDuration)

			if var_175_12 <= arg_172_1.time_ and arg_172_1.time_ < var_175_12 + var_175_22 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_12) / var_175_22

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_12 + var_175_22 and arg_172_1.time_ < var_175_12 + var_175_22 + arg_175_0 then
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
			local var_179_0 = 0
			local var_179_1 = 0.85

			if var_179_0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_0 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				local var_179_2 = arg_176_1:FormatText(StoryNameCfg[453].name)

				arg_176_1.leftNameTxt_.text = var_179_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_3 = arg_176_1:GetWordFromCfg(319631043)
				local var_179_4 = arg_176_1:FormatText(var_179_3.content)

				arg_176_1.text_.text = var_179_4

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_5 = 34
				local var_179_6 = utf8.len(var_179_4)
				local var_179_7 = var_179_5 <= 0 and var_179_1 or var_179_1 * (var_179_6 / var_179_5)

				if var_179_7 > 0 and var_179_1 < var_179_7 then
					arg_176_1.talkMaxDuration = var_179_7

					if var_179_7 + var_179_0 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_7 + var_179_0
					end
				end

				arg_176_1.text_.text = var_179_4
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631043", "story_v_out_319631.awb") ~= 0 then
					local var_179_8 = manager.audio:GetVoiceLength("story_v_out_319631", "319631043", "story_v_out_319631.awb") / 1000

					if var_179_8 + var_179_0 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_8 + var_179_0
					end

					if var_179_3.prefab_name ~= "" and arg_176_1.actors_[var_179_3.prefab_name] ~= nil then
						local var_179_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_3.prefab_name].transform, "story_v_out_319631", "319631043", "story_v_out_319631.awb")

						arg_176_1:RecordAudio("319631043", var_179_9)
						arg_176_1:RecordAudio("319631043", var_179_9)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_319631", "319631043", "story_v_out_319631.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_319631", "319631043", "story_v_out_319631.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_10 = math.max(var_179_1, arg_176_1.talkMaxDuration)

			if var_179_0 <= arg_176_1.time_ and arg_176_1.time_ < var_179_0 + var_179_10 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_0) / var_179_10

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_0 + var_179_10 and arg_176_1.time_ < var_179_0 + var_179_10 + arg_179_0 then
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
			local var_183_0 = arg_180_1.actors_["1095ui_story"].transform
			local var_183_1 = 0

			if var_183_1 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 then
				arg_180_1.var_.moveOldPos1095ui_story = var_183_0.localPosition
			end

			local var_183_2 = 0.001

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_2 then
				local var_183_3 = (arg_180_1.time_ - var_183_1) / var_183_2
				local var_183_4 = Vector3.New(0, -0.98, -6.1)

				var_183_0.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos1095ui_story, var_183_4, var_183_3)

				local var_183_5 = manager.ui.mainCamera.transform.position - var_183_0.position

				var_183_0.forward = Vector3.New(var_183_5.x, var_183_5.y, var_183_5.z)

				local var_183_6 = var_183_0.localEulerAngles

				var_183_6.z = 0
				var_183_6.x = 0
				var_183_0.localEulerAngles = var_183_6
			end

			if arg_180_1.time_ >= var_183_1 + var_183_2 and arg_180_1.time_ < var_183_1 + var_183_2 + arg_183_0 then
				var_183_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_183_7 = manager.ui.mainCamera.transform.position - var_183_0.position

				var_183_0.forward = Vector3.New(var_183_7.x, var_183_7.y, var_183_7.z)

				local var_183_8 = var_183_0.localEulerAngles

				var_183_8.z = 0
				var_183_8.x = 0
				var_183_0.localEulerAngles = var_183_8
			end

			local var_183_9 = arg_180_1.actors_["1095ui_story"]
			local var_183_10 = 0

			if var_183_10 < arg_180_1.time_ and arg_180_1.time_ <= var_183_10 + arg_183_0 and not isNil(var_183_9) and arg_180_1.var_.characterEffect1095ui_story == nil then
				arg_180_1.var_.characterEffect1095ui_story = var_183_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_11 = 0.200000002980232

			if var_183_10 <= arg_180_1.time_ and arg_180_1.time_ < var_183_10 + var_183_11 and not isNil(var_183_9) then
				local var_183_12 = (arg_180_1.time_ - var_183_10) / var_183_11

				if arg_180_1.var_.characterEffect1095ui_story and not isNil(var_183_9) then
					arg_180_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_180_1.time_ >= var_183_10 + var_183_11 and arg_180_1.time_ < var_183_10 + var_183_11 + arg_183_0 and not isNil(var_183_9) and arg_180_1.var_.characterEffect1095ui_story then
				arg_180_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_183_13 = 0

			if var_183_13 < arg_180_1.time_ and arg_180_1.time_ <= var_183_13 + arg_183_0 then
				arg_180_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_2")
			end

			local var_183_14 = 0

			if var_183_14 < arg_180_1.time_ and arg_180_1.time_ <= var_183_14 + arg_183_0 then
				arg_180_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_183_15 = arg_180_1.actors_["4037ui_story"].transform
			local var_183_16 = 0

			if var_183_16 < arg_180_1.time_ and arg_180_1.time_ <= var_183_16 + arg_183_0 then
				arg_180_1.var_.moveOldPos4037ui_story = var_183_15.localPosition
			end

			local var_183_17 = 0.001

			if var_183_16 <= arg_180_1.time_ and arg_180_1.time_ < var_183_16 + var_183_17 then
				local var_183_18 = (arg_180_1.time_ - var_183_16) / var_183_17
				local var_183_19 = Vector3.New(0, 100, 0)

				var_183_15.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos4037ui_story, var_183_19, var_183_18)

				local var_183_20 = manager.ui.mainCamera.transform.position - var_183_15.position

				var_183_15.forward = Vector3.New(var_183_20.x, var_183_20.y, var_183_20.z)

				local var_183_21 = var_183_15.localEulerAngles

				var_183_21.z = 0
				var_183_21.x = 0
				var_183_15.localEulerAngles = var_183_21
			end

			if arg_180_1.time_ >= var_183_16 + var_183_17 and arg_180_1.time_ < var_183_16 + var_183_17 + arg_183_0 then
				var_183_15.localPosition = Vector3.New(0, 100, 0)

				local var_183_22 = manager.ui.mainCamera.transform.position - var_183_15.position

				var_183_15.forward = Vector3.New(var_183_22.x, var_183_22.y, var_183_22.z)

				local var_183_23 = var_183_15.localEulerAngles

				var_183_23.z = 0
				var_183_23.x = 0
				var_183_15.localEulerAngles = var_183_23
			end

			local var_183_24 = arg_180_1.actors_["4037ui_story"]
			local var_183_25 = 0

			if var_183_25 < arg_180_1.time_ and arg_180_1.time_ <= var_183_25 + arg_183_0 and not isNil(var_183_24) and arg_180_1.var_.characterEffect4037ui_story == nil then
				arg_180_1.var_.characterEffect4037ui_story = var_183_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_26 = 0.200000002980232

			if var_183_25 <= arg_180_1.time_ and arg_180_1.time_ < var_183_25 + var_183_26 and not isNil(var_183_24) then
				local var_183_27 = (arg_180_1.time_ - var_183_25) / var_183_26

				if arg_180_1.var_.characterEffect4037ui_story and not isNil(var_183_24) then
					local var_183_28 = Mathf.Lerp(0, 0.5, var_183_27)

					arg_180_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_180_1.var_.characterEffect4037ui_story.fillRatio = var_183_28
				end
			end

			if arg_180_1.time_ >= var_183_25 + var_183_26 and arg_180_1.time_ < var_183_25 + var_183_26 + arg_183_0 and not isNil(var_183_24) and arg_180_1.var_.characterEffect4037ui_story then
				local var_183_29 = 0.5

				arg_180_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_180_1.var_.characterEffect4037ui_story.fillRatio = var_183_29
			end

			local var_183_30 = arg_180_1.actors_["10079ui_story"].transform
			local var_183_31 = 0

			if var_183_31 < arg_180_1.time_ and arg_180_1.time_ <= var_183_31 + arg_183_0 then
				arg_180_1.var_.moveOldPos10079ui_story = var_183_30.localPosition
			end

			local var_183_32 = 0.001

			if var_183_31 <= arg_180_1.time_ and arg_180_1.time_ < var_183_31 + var_183_32 then
				local var_183_33 = (arg_180_1.time_ - var_183_31) / var_183_32
				local var_183_34 = Vector3.New(0, 100, 0)

				var_183_30.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos10079ui_story, var_183_34, var_183_33)

				local var_183_35 = manager.ui.mainCamera.transform.position - var_183_30.position

				var_183_30.forward = Vector3.New(var_183_35.x, var_183_35.y, var_183_35.z)

				local var_183_36 = var_183_30.localEulerAngles

				var_183_36.z = 0
				var_183_36.x = 0
				var_183_30.localEulerAngles = var_183_36
			end

			if arg_180_1.time_ >= var_183_31 + var_183_32 and arg_180_1.time_ < var_183_31 + var_183_32 + arg_183_0 then
				var_183_30.localPosition = Vector3.New(0, 100, 0)

				local var_183_37 = manager.ui.mainCamera.transform.position - var_183_30.position

				var_183_30.forward = Vector3.New(var_183_37.x, var_183_37.y, var_183_37.z)

				local var_183_38 = var_183_30.localEulerAngles

				var_183_38.z = 0
				var_183_38.x = 0
				var_183_30.localEulerAngles = var_183_38
			end

			local var_183_39 = 0
			local var_183_40 = 0.725

			if var_183_39 < arg_180_1.time_ and arg_180_1.time_ <= var_183_39 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				local var_183_41 = arg_180_1:FormatText(StoryNameCfg[471].name)

				arg_180_1.leftNameTxt_.text = var_183_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_42 = arg_180_1:GetWordFromCfg(319631044)
				local var_183_43 = arg_180_1:FormatText(var_183_42.content)

				arg_180_1.text_.text = var_183_43

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_44 = 29
				local var_183_45 = utf8.len(var_183_43)
				local var_183_46 = var_183_44 <= 0 and var_183_40 or var_183_40 * (var_183_45 / var_183_44)

				if var_183_46 > 0 and var_183_40 < var_183_46 then
					arg_180_1.talkMaxDuration = var_183_46

					if var_183_46 + var_183_39 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_46 + var_183_39
					end
				end

				arg_180_1.text_.text = var_183_43
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631044", "story_v_out_319631.awb") ~= 0 then
					local var_183_47 = manager.audio:GetVoiceLength("story_v_out_319631", "319631044", "story_v_out_319631.awb") / 1000

					if var_183_47 + var_183_39 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_47 + var_183_39
					end

					if var_183_42.prefab_name ~= "" and arg_180_1.actors_[var_183_42.prefab_name] ~= nil then
						local var_183_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_42.prefab_name].transform, "story_v_out_319631", "319631044", "story_v_out_319631.awb")

						arg_180_1:RecordAudio("319631044", var_183_48)
						arg_180_1:RecordAudio("319631044", var_183_48)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_319631", "319631044", "story_v_out_319631.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_319631", "319631044", "story_v_out_319631.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_49 = math.max(var_183_40, arg_180_1.talkMaxDuration)

			if var_183_39 <= arg_180_1.time_ and arg_180_1.time_ < var_183_39 + var_183_49 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_39) / var_183_49

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_39 + var_183_49 and arg_180_1.time_ < var_183_39 + var_183_49 + arg_183_0 then
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
			local var_187_0 = arg_184_1.actors_["4037ui_story"].transform
			local var_187_1 = 0

			if var_187_1 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 then
				arg_184_1.var_.moveOldPos4037ui_story = var_187_0.localPosition
			end

			local var_187_2 = 0.001

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_2 then
				local var_187_3 = (arg_184_1.time_ - var_187_1) / var_187_2
				local var_187_4 = Vector3.New(0, -1.12, -6.2)

				var_187_0.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos4037ui_story, var_187_4, var_187_3)

				local var_187_5 = manager.ui.mainCamera.transform.position - var_187_0.position

				var_187_0.forward = Vector3.New(var_187_5.x, var_187_5.y, var_187_5.z)

				local var_187_6 = var_187_0.localEulerAngles

				var_187_6.z = 0
				var_187_6.x = 0
				var_187_0.localEulerAngles = var_187_6
			end

			if arg_184_1.time_ >= var_187_1 + var_187_2 and arg_184_1.time_ < var_187_1 + var_187_2 + arg_187_0 then
				var_187_0.localPosition = Vector3.New(0, -1.12, -6.2)

				local var_187_7 = manager.ui.mainCamera.transform.position - var_187_0.position

				var_187_0.forward = Vector3.New(var_187_7.x, var_187_7.y, var_187_7.z)

				local var_187_8 = var_187_0.localEulerAngles

				var_187_8.z = 0
				var_187_8.x = 0
				var_187_0.localEulerAngles = var_187_8
			end

			local var_187_9 = arg_184_1.actors_["4037ui_story"]
			local var_187_10 = 0

			if var_187_10 < arg_184_1.time_ and arg_184_1.time_ <= var_187_10 + arg_187_0 and not isNil(var_187_9) and arg_184_1.var_.characterEffect4037ui_story == nil then
				arg_184_1.var_.characterEffect4037ui_story = var_187_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_11 = 0.200000002980232

			if var_187_10 <= arg_184_1.time_ and arg_184_1.time_ < var_187_10 + var_187_11 and not isNil(var_187_9) then
				local var_187_12 = (arg_184_1.time_ - var_187_10) / var_187_11

				if arg_184_1.var_.characterEffect4037ui_story and not isNil(var_187_9) then
					arg_184_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_184_1.time_ >= var_187_10 + var_187_11 and arg_184_1.time_ < var_187_10 + var_187_11 + arg_187_0 and not isNil(var_187_9) and arg_184_1.var_.characterEffect4037ui_story then
				arg_184_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_187_13 = 0

			if var_187_13 < arg_184_1.time_ and arg_184_1.time_ <= var_187_13 + arg_187_0 then
				arg_184_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action2_1")
			end

			local var_187_14 = 0

			if var_187_14 < arg_184_1.time_ and arg_184_1.time_ <= var_187_14 + arg_187_0 then
				arg_184_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_187_15 = arg_184_1.actors_["1095ui_story"].transform
			local var_187_16 = 0

			if var_187_16 < arg_184_1.time_ and arg_184_1.time_ <= var_187_16 + arg_187_0 then
				arg_184_1.var_.moveOldPos1095ui_story = var_187_15.localPosition
			end

			local var_187_17 = 0.001

			if var_187_16 <= arg_184_1.time_ and arg_184_1.time_ < var_187_16 + var_187_17 then
				local var_187_18 = (arg_184_1.time_ - var_187_16) / var_187_17
				local var_187_19 = Vector3.New(0, 100, 0)

				var_187_15.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos1095ui_story, var_187_19, var_187_18)

				local var_187_20 = manager.ui.mainCamera.transform.position - var_187_15.position

				var_187_15.forward = Vector3.New(var_187_20.x, var_187_20.y, var_187_20.z)

				local var_187_21 = var_187_15.localEulerAngles

				var_187_21.z = 0
				var_187_21.x = 0
				var_187_15.localEulerAngles = var_187_21
			end

			if arg_184_1.time_ >= var_187_16 + var_187_17 and arg_184_1.time_ < var_187_16 + var_187_17 + arg_187_0 then
				var_187_15.localPosition = Vector3.New(0, 100, 0)

				local var_187_22 = manager.ui.mainCamera.transform.position - var_187_15.position

				var_187_15.forward = Vector3.New(var_187_22.x, var_187_22.y, var_187_22.z)

				local var_187_23 = var_187_15.localEulerAngles

				var_187_23.z = 0
				var_187_23.x = 0
				var_187_15.localEulerAngles = var_187_23
			end

			local var_187_24 = arg_184_1.actors_["1095ui_story"]
			local var_187_25 = 0

			if var_187_25 < arg_184_1.time_ and arg_184_1.time_ <= var_187_25 + arg_187_0 and not isNil(var_187_24) and arg_184_1.var_.characterEffect1095ui_story == nil then
				arg_184_1.var_.characterEffect1095ui_story = var_187_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_26 = 0.200000002980232

			if var_187_25 <= arg_184_1.time_ and arg_184_1.time_ < var_187_25 + var_187_26 and not isNil(var_187_24) then
				local var_187_27 = (arg_184_1.time_ - var_187_25) / var_187_26

				if arg_184_1.var_.characterEffect1095ui_story and not isNil(var_187_24) then
					local var_187_28 = Mathf.Lerp(0, 0.5, var_187_27)

					arg_184_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_184_1.var_.characterEffect1095ui_story.fillRatio = var_187_28
				end
			end

			if arg_184_1.time_ >= var_187_25 + var_187_26 and arg_184_1.time_ < var_187_25 + var_187_26 + arg_187_0 and not isNil(var_187_24) and arg_184_1.var_.characterEffect1095ui_story then
				local var_187_29 = 0.5

				arg_184_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_184_1.var_.characterEffect1095ui_story.fillRatio = var_187_29
			end

			local var_187_30 = 0
			local var_187_31 = 1

			if var_187_30 < arg_184_1.time_ and arg_184_1.time_ <= var_187_30 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				local var_187_32 = arg_184_1:FormatText(StoryNameCfg[453].name)

				arg_184_1.leftNameTxt_.text = var_187_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_33 = arg_184_1:GetWordFromCfg(319631045)
				local var_187_34 = arg_184_1:FormatText(var_187_33.content)

				arg_184_1.text_.text = var_187_34

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_35 = 40
				local var_187_36 = utf8.len(var_187_34)
				local var_187_37 = var_187_35 <= 0 and var_187_31 or var_187_31 * (var_187_36 / var_187_35)

				if var_187_37 > 0 and var_187_31 < var_187_37 then
					arg_184_1.talkMaxDuration = var_187_37

					if var_187_37 + var_187_30 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_37 + var_187_30
					end
				end

				arg_184_1.text_.text = var_187_34
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631045", "story_v_out_319631.awb") ~= 0 then
					local var_187_38 = manager.audio:GetVoiceLength("story_v_out_319631", "319631045", "story_v_out_319631.awb") / 1000

					if var_187_38 + var_187_30 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_38 + var_187_30
					end

					if var_187_33.prefab_name ~= "" and arg_184_1.actors_[var_187_33.prefab_name] ~= nil then
						local var_187_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_33.prefab_name].transform, "story_v_out_319631", "319631045", "story_v_out_319631.awb")

						arg_184_1:RecordAudio("319631045", var_187_39)
						arg_184_1:RecordAudio("319631045", var_187_39)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_319631", "319631045", "story_v_out_319631.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_319631", "319631045", "story_v_out_319631.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_40 = math.max(var_187_31, arg_184_1.talkMaxDuration)

			if var_187_30 <= arg_184_1.time_ and arg_184_1.time_ < var_187_30 + var_187_40 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_30) / var_187_40

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_30 + var_187_40 and arg_184_1.time_ < var_187_30 + var_187_40 + arg_187_0 then
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
			local var_191_0 = 0
			local var_191_1 = 1.1

			if var_191_0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_0 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				local var_191_2 = arg_188_1:FormatText(StoryNameCfg[453].name)

				arg_188_1.leftNameTxt_.text = var_191_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_3 = arg_188_1:GetWordFromCfg(319631046)
				local var_191_4 = arg_188_1:FormatText(var_191_3.content)

				arg_188_1.text_.text = var_191_4

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_5 = 44
				local var_191_6 = utf8.len(var_191_4)
				local var_191_7 = var_191_5 <= 0 and var_191_1 or var_191_1 * (var_191_6 / var_191_5)

				if var_191_7 > 0 and var_191_1 < var_191_7 then
					arg_188_1.talkMaxDuration = var_191_7

					if var_191_7 + var_191_0 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_7 + var_191_0
					end
				end

				arg_188_1.text_.text = var_191_4
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631046", "story_v_out_319631.awb") ~= 0 then
					local var_191_8 = manager.audio:GetVoiceLength("story_v_out_319631", "319631046", "story_v_out_319631.awb") / 1000

					if var_191_8 + var_191_0 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_8 + var_191_0
					end

					if var_191_3.prefab_name ~= "" and arg_188_1.actors_[var_191_3.prefab_name] ~= nil then
						local var_191_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_3.prefab_name].transform, "story_v_out_319631", "319631046", "story_v_out_319631.awb")

						arg_188_1:RecordAudio("319631046", var_191_9)
						arg_188_1:RecordAudio("319631046", var_191_9)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_319631", "319631046", "story_v_out_319631.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_319631", "319631046", "story_v_out_319631.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_10 = math.max(var_191_1, arg_188_1.talkMaxDuration)

			if var_191_0 <= arg_188_1.time_ and arg_188_1.time_ < var_191_0 + var_191_10 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_0) / var_191_10

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_0 + var_191_10 and arg_188_1.time_ < var_191_0 + var_191_10 + arg_191_0 then
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
			local var_195_0 = 0
			local var_195_1 = 0.95

			if var_195_0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_0 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				local var_195_2 = arg_192_1:FormatText(StoryNameCfg[453].name)

				arg_192_1.leftNameTxt_.text = var_195_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_3 = arg_192_1:GetWordFromCfg(319631047)
				local var_195_4 = arg_192_1:FormatText(var_195_3.content)

				arg_192_1.text_.text = var_195_4

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_5 = 38
				local var_195_6 = utf8.len(var_195_4)
				local var_195_7 = var_195_5 <= 0 and var_195_1 or var_195_1 * (var_195_6 / var_195_5)

				if var_195_7 > 0 and var_195_1 < var_195_7 then
					arg_192_1.talkMaxDuration = var_195_7

					if var_195_7 + var_195_0 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_7 + var_195_0
					end
				end

				arg_192_1.text_.text = var_195_4
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631047", "story_v_out_319631.awb") ~= 0 then
					local var_195_8 = manager.audio:GetVoiceLength("story_v_out_319631", "319631047", "story_v_out_319631.awb") / 1000

					if var_195_8 + var_195_0 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_8 + var_195_0
					end

					if var_195_3.prefab_name ~= "" and arg_192_1.actors_[var_195_3.prefab_name] ~= nil then
						local var_195_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_3.prefab_name].transform, "story_v_out_319631", "319631047", "story_v_out_319631.awb")

						arg_192_1:RecordAudio("319631047", var_195_9)
						arg_192_1:RecordAudio("319631047", var_195_9)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_319631", "319631047", "story_v_out_319631.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_319631", "319631047", "story_v_out_319631.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_10 = math.max(var_195_1, arg_192_1.talkMaxDuration)

			if var_195_0 <= arg_192_1.time_ and arg_192_1.time_ < var_195_0 + var_195_10 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_0) / var_195_10

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_0 + var_195_10 and arg_192_1.time_ < var_195_0 + var_195_10 + arg_195_0 then
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
			local var_199_0 = arg_196_1.actors_["1095ui_story"].transform
			local var_199_1 = 0

			if var_199_1 < arg_196_1.time_ and arg_196_1.time_ <= var_199_1 + arg_199_0 then
				arg_196_1.var_.moveOldPos1095ui_story = var_199_0.localPosition
			end

			local var_199_2 = 0.001

			if var_199_1 <= arg_196_1.time_ and arg_196_1.time_ < var_199_1 + var_199_2 then
				local var_199_3 = (arg_196_1.time_ - var_199_1) / var_199_2
				local var_199_4 = Vector3.New(0, -0.98, -6.1)

				var_199_0.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos1095ui_story, var_199_4, var_199_3)

				local var_199_5 = manager.ui.mainCamera.transform.position - var_199_0.position

				var_199_0.forward = Vector3.New(var_199_5.x, var_199_5.y, var_199_5.z)

				local var_199_6 = var_199_0.localEulerAngles

				var_199_6.z = 0
				var_199_6.x = 0
				var_199_0.localEulerAngles = var_199_6
			end

			if arg_196_1.time_ >= var_199_1 + var_199_2 and arg_196_1.time_ < var_199_1 + var_199_2 + arg_199_0 then
				var_199_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_199_7 = manager.ui.mainCamera.transform.position - var_199_0.position

				var_199_0.forward = Vector3.New(var_199_7.x, var_199_7.y, var_199_7.z)

				local var_199_8 = var_199_0.localEulerAngles

				var_199_8.z = 0
				var_199_8.x = 0
				var_199_0.localEulerAngles = var_199_8
			end

			local var_199_9 = arg_196_1.actors_["1095ui_story"]
			local var_199_10 = 0

			if var_199_10 < arg_196_1.time_ and arg_196_1.time_ <= var_199_10 + arg_199_0 and not isNil(var_199_9) and arg_196_1.var_.characterEffect1095ui_story == nil then
				arg_196_1.var_.characterEffect1095ui_story = var_199_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_199_11 = 0.200000002980232

			if var_199_10 <= arg_196_1.time_ and arg_196_1.time_ < var_199_10 + var_199_11 and not isNil(var_199_9) then
				local var_199_12 = (arg_196_1.time_ - var_199_10) / var_199_11

				if arg_196_1.var_.characterEffect1095ui_story and not isNil(var_199_9) then
					arg_196_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_196_1.time_ >= var_199_10 + var_199_11 and arg_196_1.time_ < var_199_10 + var_199_11 + arg_199_0 and not isNil(var_199_9) and arg_196_1.var_.characterEffect1095ui_story then
				arg_196_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_199_13 = 0

			if var_199_13 < arg_196_1.time_ and arg_196_1.time_ <= var_199_13 + arg_199_0 then
				arg_196_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_199_14 = arg_196_1.actors_["4037ui_story"].transform
			local var_199_15 = 0

			if var_199_15 < arg_196_1.time_ and arg_196_1.time_ <= var_199_15 + arg_199_0 then
				arg_196_1.var_.moveOldPos4037ui_story = var_199_14.localPosition
			end

			local var_199_16 = 0.001

			if var_199_15 <= arg_196_1.time_ and arg_196_1.time_ < var_199_15 + var_199_16 then
				local var_199_17 = (arg_196_1.time_ - var_199_15) / var_199_16
				local var_199_18 = Vector3.New(0, 100, 0)

				var_199_14.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos4037ui_story, var_199_18, var_199_17)

				local var_199_19 = manager.ui.mainCamera.transform.position - var_199_14.position

				var_199_14.forward = Vector3.New(var_199_19.x, var_199_19.y, var_199_19.z)

				local var_199_20 = var_199_14.localEulerAngles

				var_199_20.z = 0
				var_199_20.x = 0
				var_199_14.localEulerAngles = var_199_20
			end

			if arg_196_1.time_ >= var_199_15 + var_199_16 and arg_196_1.time_ < var_199_15 + var_199_16 + arg_199_0 then
				var_199_14.localPosition = Vector3.New(0, 100, 0)

				local var_199_21 = manager.ui.mainCamera.transform.position - var_199_14.position

				var_199_14.forward = Vector3.New(var_199_21.x, var_199_21.y, var_199_21.z)

				local var_199_22 = var_199_14.localEulerAngles

				var_199_22.z = 0
				var_199_22.x = 0
				var_199_14.localEulerAngles = var_199_22
			end

			local var_199_23 = arg_196_1.actors_["4037ui_story"]
			local var_199_24 = 0

			if var_199_24 < arg_196_1.time_ and arg_196_1.time_ <= var_199_24 + arg_199_0 and not isNil(var_199_23) and arg_196_1.var_.characterEffect4037ui_story == nil then
				arg_196_1.var_.characterEffect4037ui_story = var_199_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_199_25 = 0.200000002980232

			if var_199_24 <= arg_196_1.time_ and arg_196_1.time_ < var_199_24 + var_199_25 and not isNil(var_199_23) then
				local var_199_26 = (arg_196_1.time_ - var_199_24) / var_199_25

				if arg_196_1.var_.characterEffect4037ui_story and not isNil(var_199_23) then
					local var_199_27 = Mathf.Lerp(0, 0.5, var_199_26)

					arg_196_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_196_1.var_.characterEffect4037ui_story.fillRatio = var_199_27
				end
			end

			if arg_196_1.time_ >= var_199_24 + var_199_25 and arg_196_1.time_ < var_199_24 + var_199_25 + arg_199_0 and not isNil(var_199_23) and arg_196_1.var_.characterEffect4037ui_story then
				local var_199_28 = 0.5

				arg_196_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_196_1.var_.characterEffect4037ui_story.fillRatio = var_199_28
			end

			local var_199_29 = 0
			local var_199_30 = 0.25

			if var_199_29 < arg_196_1.time_ and arg_196_1.time_ <= var_199_29 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				local var_199_31 = arg_196_1:FormatText(StoryNameCfg[471].name)

				arg_196_1.leftNameTxt_.text = var_199_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_32 = arg_196_1:GetWordFromCfg(319631048)
				local var_199_33 = arg_196_1:FormatText(var_199_32.content)

				arg_196_1.text_.text = var_199_33

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_34 = 10
				local var_199_35 = utf8.len(var_199_33)
				local var_199_36 = var_199_34 <= 0 and var_199_30 or var_199_30 * (var_199_35 / var_199_34)

				if var_199_36 > 0 and var_199_30 < var_199_36 then
					arg_196_1.talkMaxDuration = var_199_36

					if var_199_36 + var_199_29 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_36 + var_199_29
					end
				end

				arg_196_1.text_.text = var_199_33
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631048", "story_v_out_319631.awb") ~= 0 then
					local var_199_37 = manager.audio:GetVoiceLength("story_v_out_319631", "319631048", "story_v_out_319631.awb") / 1000

					if var_199_37 + var_199_29 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_37 + var_199_29
					end

					if var_199_32.prefab_name ~= "" and arg_196_1.actors_[var_199_32.prefab_name] ~= nil then
						local var_199_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_32.prefab_name].transform, "story_v_out_319631", "319631048", "story_v_out_319631.awb")

						arg_196_1:RecordAudio("319631048", var_199_38)
						arg_196_1:RecordAudio("319631048", var_199_38)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_319631", "319631048", "story_v_out_319631.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_319631", "319631048", "story_v_out_319631.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_39 = math.max(var_199_30, arg_196_1.talkMaxDuration)

			if var_199_29 <= arg_196_1.time_ and arg_196_1.time_ < var_199_29 + var_199_39 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_29) / var_199_39

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_29 + var_199_39 and arg_196_1.time_ < var_199_29 + var_199_39 + arg_199_0 then
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
			local var_203_0 = arg_200_1.actors_["4037ui_story"].transform
			local var_203_1 = 0

			if var_203_1 < arg_200_1.time_ and arg_200_1.time_ <= var_203_1 + arg_203_0 then
				arg_200_1.var_.moveOldPos4037ui_story = var_203_0.localPosition
			end

			local var_203_2 = 0.001

			if var_203_1 <= arg_200_1.time_ and arg_200_1.time_ < var_203_1 + var_203_2 then
				local var_203_3 = (arg_200_1.time_ - var_203_1) / var_203_2
				local var_203_4 = Vector3.New(0, -1.12, -6.2)

				var_203_0.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos4037ui_story, var_203_4, var_203_3)

				local var_203_5 = manager.ui.mainCamera.transform.position - var_203_0.position

				var_203_0.forward = Vector3.New(var_203_5.x, var_203_5.y, var_203_5.z)

				local var_203_6 = var_203_0.localEulerAngles

				var_203_6.z = 0
				var_203_6.x = 0
				var_203_0.localEulerAngles = var_203_6
			end

			if arg_200_1.time_ >= var_203_1 + var_203_2 and arg_200_1.time_ < var_203_1 + var_203_2 + arg_203_0 then
				var_203_0.localPosition = Vector3.New(0, -1.12, -6.2)

				local var_203_7 = manager.ui.mainCamera.transform.position - var_203_0.position

				var_203_0.forward = Vector3.New(var_203_7.x, var_203_7.y, var_203_7.z)

				local var_203_8 = var_203_0.localEulerAngles

				var_203_8.z = 0
				var_203_8.x = 0
				var_203_0.localEulerAngles = var_203_8
			end

			local var_203_9 = arg_200_1.actors_["4037ui_story"]
			local var_203_10 = 0

			if var_203_10 < arg_200_1.time_ and arg_200_1.time_ <= var_203_10 + arg_203_0 and not isNil(var_203_9) and arg_200_1.var_.characterEffect4037ui_story == nil then
				arg_200_1.var_.characterEffect4037ui_story = var_203_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_11 = 0.200000002980232

			if var_203_10 <= arg_200_1.time_ and arg_200_1.time_ < var_203_10 + var_203_11 and not isNil(var_203_9) then
				local var_203_12 = (arg_200_1.time_ - var_203_10) / var_203_11

				if arg_200_1.var_.characterEffect4037ui_story and not isNil(var_203_9) then
					arg_200_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_200_1.time_ >= var_203_10 + var_203_11 and arg_200_1.time_ < var_203_10 + var_203_11 + arg_203_0 and not isNil(var_203_9) and arg_200_1.var_.characterEffect4037ui_story then
				arg_200_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_203_13 = 0

			if var_203_13 < arg_200_1.time_ and arg_200_1.time_ <= var_203_13 + arg_203_0 then
				arg_200_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action2_2")
			end

			local var_203_14 = 0

			if var_203_14 < arg_200_1.time_ and arg_200_1.time_ <= var_203_14 + arg_203_0 then
				arg_200_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_203_15 = arg_200_1.actors_["1095ui_story"].transform
			local var_203_16 = 0

			if var_203_16 < arg_200_1.time_ and arg_200_1.time_ <= var_203_16 + arg_203_0 then
				arg_200_1.var_.moveOldPos1095ui_story = var_203_15.localPosition
			end

			local var_203_17 = 0.001

			if var_203_16 <= arg_200_1.time_ and arg_200_1.time_ < var_203_16 + var_203_17 then
				local var_203_18 = (arg_200_1.time_ - var_203_16) / var_203_17
				local var_203_19 = Vector3.New(0, 100, 0)

				var_203_15.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos1095ui_story, var_203_19, var_203_18)

				local var_203_20 = manager.ui.mainCamera.transform.position - var_203_15.position

				var_203_15.forward = Vector3.New(var_203_20.x, var_203_20.y, var_203_20.z)

				local var_203_21 = var_203_15.localEulerAngles

				var_203_21.z = 0
				var_203_21.x = 0
				var_203_15.localEulerAngles = var_203_21
			end

			if arg_200_1.time_ >= var_203_16 + var_203_17 and arg_200_1.time_ < var_203_16 + var_203_17 + arg_203_0 then
				var_203_15.localPosition = Vector3.New(0, 100, 0)

				local var_203_22 = manager.ui.mainCamera.transform.position - var_203_15.position

				var_203_15.forward = Vector3.New(var_203_22.x, var_203_22.y, var_203_22.z)

				local var_203_23 = var_203_15.localEulerAngles

				var_203_23.z = 0
				var_203_23.x = 0
				var_203_15.localEulerAngles = var_203_23
			end

			local var_203_24 = arg_200_1.actors_["1095ui_story"]
			local var_203_25 = 0

			if var_203_25 < arg_200_1.time_ and arg_200_1.time_ <= var_203_25 + arg_203_0 and not isNil(var_203_24) and arg_200_1.var_.characterEffect1095ui_story == nil then
				arg_200_1.var_.characterEffect1095ui_story = var_203_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_26 = 0.200000002980232

			if var_203_25 <= arg_200_1.time_ and arg_200_1.time_ < var_203_25 + var_203_26 and not isNil(var_203_24) then
				local var_203_27 = (arg_200_1.time_ - var_203_25) / var_203_26

				if arg_200_1.var_.characterEffect1095ui_story and not isNil(var_203_24) then
					local var_203_28 = Mathf.Lerp(0, 0.5, var_203_27)

					arg_200_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_200_1.var_.characterEffect1095ui_story.fillRatio = var_203_28
				end
			end

			if arg_200_1.time_ >= var_203_25 + var_203_26 and arg_200_1.time_ < var_203_25 + var_203_26 + arg_203_0 and not isNil(var_203_24) and arg_200_1.var_.characterEffect1095ui_story then
				local var_203_29 = 0.5

				arg_200_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_200_1.var_.characterEffect1095ui_story.fillRatio = var_203_29
			end

			local var_203_30 = 0
			local var_203_31 = 0.9

			if var_203_30 < arg_200_1.time_ and arg_200_1.time_ <= var_203_30 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				local var_203_32 = arg_200_1:FormatText(StoryNameCfg[453].name)

				arg_200_1.leftNameTxt_.text = var_203_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_33 = arg_200_1:GetWordFromCfg(319631049)
				local var_203_34 = arg_200_1:FormatText(var_203_33.content)

				arg_200_1.text_.text = var_203_34

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_35 = 36
				local var_203_36 = utf8.len(var_203_34)
				local var_203_37 = var_203_35 <= 0 and var_203_31 or var_203_31 * (var_203_36 / var_203_35)

				if var_203_37 > 0 and var_203_31 < var_203_37 then
					arg_200_1.talkMaxDuration = var_203_37

					if var_203_37 + var_203_30 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_37 + var_203_30
					end
				end

				arg_200_1.text_.text = var_203_34
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631049", "story_v_out_319631.awb") ~= 0 then
					local var_203_38 = manager.audio:GetVoiceLength("story_v_out_319631", "319631049", "story_v_out_319631.awb") / 1000

					if var_203_38 + var_203_30 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_38 + var_203_30
					end

					if var_203_33.prefab_name ~= "" and arg_200_1.actors_[var_203_33.prefab_name] ~= nil then
						local var_203_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_33.prefab_name].transform, "story_v_out_319631", "319631049", "story_v_out_319631.awb")

						arg_200_1:RecordAudio("319631049", var_203_39)
						arg_200_1:RecordAudio("319631049", var_203_39)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_319631", "319631049", "story_v_out_319631.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_319631", "319631049", "story_v_out_319631.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_40 = math.max(var_203_31, arg_200_1.talkMaxDuration)

			if var_203_30 <= arg_200_1.time_ and arg_200_1.time_ < var_203_30 + var_203_40 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_30) / var_203_40

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_30 + var_203_40 and arg_200_1.time_ < var_203_30 + var_203_40 + arg_203_0 then
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
			local var_207_0 = 0
			local var_207_1 = 0.525

			if var_207_0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_0 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				local var_207_2 = arg_204_1:FormatText(StoryNameCfg[453].name)

				arg_204_1.leftNameTxt_.text = var_207_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_3 = arg_204_1:GetWordFromCfg(319631050)
				local var_207_4 = arg_204_1:FormatText(var_207_3.content)

				arg_204_1.text_.text = var_207_4

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_5 = 21
				local var_207_6 = utf8.len(var_207_4)
				local var_207_7 = var_207_5 <= 0 and var_207_1 or var_207_1 * (var_207_6 / var_207_5)

				if var_207_7 > 0 and var_207_1 < var_207_7 then
					arg_204_1.talkMaxDuration = var_207_7

					if var_207_7 + var_207_0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_7 + var_207_0
					end
				end

				arg_204_1.text_.text = var_207_4
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631050", "story_v_out_319631.awb") ~= 0 then
					local var_207_8 = manager.audio:GetVoiceLength("story_v_out_319631", "319631050", "story_v_out_319631.awb") / 1000

					if var_207_8 + var_207_0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_8 + var_207_0
					end

					if var_207_3.prefab_name ~= "" and arg_204_1.actors_[var_207_3.prefab_name] ~= nil then
						local var_207_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_3.prefab_name].transform, "story_v_out_319631", "319631050", "story_v_out_319631.awb")

						arg_204_1:RecordAudio("319631050", var_207_9)
						arg_204_1:RecordAudio("319631050", var_207_9)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_319631", "319631050", "story_v_out_319631.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_319631", "319631050", "story_v_out_319631.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_10 = math.max(var_207_1, arg_204_1.talkMaxDuration)

			if var_207_0 <= arg_204_1.time_ and arg_204_1.time_ < var_207_0 + var_207_10 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_0) / var_207_10

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_0 + var_207_10 and arg_204_1.time_ < var_207_0 + var_207_10 + arg_207_0 then
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
			local var_211_0 = arg_208_1.actors_["4037ui_story"]
			local var_211_1 = 0

			if var_211_1 < arg_208_1.time_ and arg_208_1.time_ <= var_211_1 + arg_211_0 and not isNil(var_211_0) and arg_208_1.var_.characterEffect4037ui_story == nil then
				arg_208_1.var_.characterEffect4037ui_story = var_211_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_2 = 0.200000002980232

			if var_211_1 <= arg_208_1.time_ and arg_208_1.time_ < var_211_1 + var_211_2 and not isNil(var_211_0) then
				local var_211_3 = (arg_208_1.time_ - var_211_1) / var_211_2

				if arg_208_1.var_.characterEffect4037ui_story and not isNil(var_211_0) then
					local var_211_4 = Mathf.Lerp(0, 0.5, var_211_3)

					arg_208_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_208_1.var_.characterEffect4037ui_story.fillRatio = var_211_4
				end
			end

			if arg_208_1.time_ >= var_211_1 + var_211_2 and arg_208_1.time_ < var_211_1 + var_211_2 + arg_211_0 and not isNil(var_211_0) and arg_208_1.var_.characterEffect4037ui_story then
				local var_211_5 = 0.5

				arg_208_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_208_1.var_.characterEffect4037ui_story.fillRatio = var_211_5
			end

			local var_211_6 = 0
			local var_211_7 = 1.275

			if var_211_6 < arg_208_1.time_ and arg_208_1.time_ <= var_211_6 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, false)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_8 = arg_208_1:GetWordFromCfg(319631051)
				local var_211_9 = arg_208_1:FormatText(var_211_8.content)

				arg_208_1.text_.text = var_211_9

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_10 = 51
				local var_211_11 = utf8.len(var_211_9)
				local var_211_12 = var_211_10 <= 0 and var_211_7 or var_211_7 * (var_211_11 / var_211_10)

				if var_211_12 > 0 and var_211_7 < var_211_12 then
					arg_208_1.talkMaxDuration = var_211_12

					if var_211_12 + var_211_6 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_12 + var_211_6
					end
				end

				arg_208_1.text_.text = var_211_9
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)
				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_13 = math.max(var_211_7, arg_208_1.talkMaxDuration)

			if var_211_6 <= arg_208_1.time_ and arg_208_1.time_ < var_211_6 + var_211_13 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_6) / var_211_13

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_6 + var_211_13 and arg_208_1.time_ < var_211_6 + var_211_13 + arg_211_0 then
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
			local var_215_0 = arg_212_1.actors_["10079ui_story"].transform
			local var_215_1 = 0

			if var_215_1 < arg_212_1.time_ and arg_212_1.time_ <= var_215_1 + arg_215_0 then
				arg_212_1.var_.moveOldPos10079ui_story = var_215_0.localPosition
			end

			local var_215_2 = 0.001

			if var_215_1 <= arg_212_1.time_ and arg_212_1.time_ < var_215_1 + var_215_2 then
				local var_215_3 = (arg_212_1.time_ - var_215_1) / var_215_2
				local var_215_4 = Vector3.New(0, -0.95, -6.05)

				var_215_0.localPosition = Vector3.Lerp(arg_212_1.var_.moveOldPos10079ui_story, var_215_4, var_215_3)

				local var_215_5 = manager.ui.mainCamera.transform.position - var_215_0.position

				var_215_0.forward = Vector3.New(var_215_5.x, var_215_5.y, var_215_5.z)

				local var_215_6 = var_215_0.localEulerAngles

				var_215_6.z = 0
				var_215_6.x = 0
				var_215_0.localEulerAngles = var_215_6
			end

			if arg_212_1.time_ >= var_215_1 + var_215_2 and arg_212_1.time_ < var_215_1 + var_215_2 + arg_215_0 then
				var_215_0.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_215_7 = manager.ui.mainCamera.transform.position - var_215_0.position

				var_215_0.forward = Vector3.New(var_215_7.x, var_215_7.y, var_215_7.z)

				local var_215_8 = var_215_0.localEulerAngles

				var_215_8.z = 0
				var_215_8.x = 0
				var_215_0.localEulerAngles = var_215_8
			end

			local var_215_9 = arg_212_1.actors_["10079ui_story"]
			local var_215_10 = 0

			if var_215_10 < arg_212_1.time_ and arg_212_1.time_ <= var_215_10 + arg_215_0 and not isNil(var_215_9) and arg_212_1.var_.characterEffect10079ui_story == nil then
				arg_212_1.var_.characterEffect10079ui_story = var_215_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_11 = 0.200000002980232

			if var_215_10 <= arg_212_1.time_ and arg_212_1.time_ < var_215_10 + var_215_11 and not isNil(var_215_9) then
				local var_215_12 = (arg_212_1.time_ - var_215_10) / var_215_11

				if arg_212_1.var_.characterEffect10079ui_story and not isNil(var_215_9) then
					arg_212_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_212_1.time_ >= var_215_10 + var_215_11 and arg_212_1.time_ < var_215_10 + var_215_11 + arg_215_0 and not isNil(var_215_9) and arg_212_1.var_.characterEffect10079ui_story then
				arg_212_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_215_13 = 0

			if var_215_13 < arg_212_1.time_ and arg_212_1.time_ <= var_215_13 + arg_215_0 then
				arg_212_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_215_14 = 0

			if var_215_14 < arg_212_1.time_ and arg_212_1.time_ <= var_215_14 + arg_215_0 then
				arg_212_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_215_15 = arg_212_1.actors_["4037ui_story"].transform
			local var_215_16 = 0

			if var_215_16 < arg_212_1.time_ and arg_212_1.time_ <= var_215_16 + arg_215_0 then
				arg_212_1.var_.moveOldPos4037ui_story = var_215_15.localPosition
			end

			local var_215_17 = 0.001

			if var_215_16 <= arg_212_1.time_ and arg_212_1.time_ < var_215_16 + var_215_17 then
				local var_215_18 = (arg_212_1.time_ - var_215_16) / var_215_17
				local var_215_19 = Vector3.New(0, 100, 0)

				var_215_15.localPosition = Vector3.Lerp(arg_212_1.var_.moveOldPos4037ui_story, var_215_19, var_215_18)

				local var_215_20 = manager.ui.mainCamera.transform.position - var_215_15.position

				var_215_15.forward = Vector3.New(var_215_20.x, var_215_20.y, var_215_20.z)

				local var_215_21 = var_215_15.localEulerAngles

				var_215_21.z = 0
				var_215_21.x = 0
				var_215_15.localEulerAngles = var_215_21
			end

			if arg_212_1.time_ >= var_215_16 + var_215_17 and arg_212_1.time_ < var_215_16 + var_215_17 + arg_215_0 then
				var_215_15.localPosition = Vector3.New(0, 100, 0)

				local var_215_22 = manager.ui.mainCamera.transform.position - var_215_15.position

				var_215_15.forward = Vector3.New(var_215_22.x, var_215_22.y, var_215_22.z)

				local var_215_23 = var_215_15.localEulerAngles

				var_215_23.z = 0
				var_215_23.x = 0
				var_215_15.localEulerAngles = var_215_23
			end

			local var_215_24 = arg_212_1.actors_["4037ui_story"]
			local var_215_25 = 0

			if var_215_25 < arg_212_1.time_ and arg_212_1.time_ <= var_215_25 + arg_215_0 and not isNil(var_215_24) and arg_212_1.var_.characterEffect4037ui_story == nil then
				arg_212_1.var_.characterEffect4037ui_story = var_215_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_26 = 0.200000002980232

			if var_215_25 <= arg_212_1.time_ and arg_212_1.time_ < var_215_25 + var_215_26 and not isNil(var_215_24) then
				local var_215_27 = (arg_212_1.time_ - var_215_25) / var_215_26

				if arg_212_1.var_.characterEffect4037ui_story and not isNil(var_215_24) then
					local var_215_28 = Mathf.Lerp(0, 0.5, var_215_27)

					arg_212_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_212_1.var_.characterEffect4037ui_story.fillRatio = var_215_28
				end
			end

			if arg_212_1.time_ >= var_215_25 + var_215_26 and arg_212_1.time_ < var_215_25 + var_215_26 + arg_215_0 and not isNil(var_215_24) and arg_212_1.var_.characterEffect4037ui_story then
				local var_215_29 = 0.5

				arg_212_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_212_1.var_.characterEffect4037ui_story.fillRatio = var_215_29
			end

			local var_215_30 = 0
			local var_215_31 = 0.175

			if var_215_30 < arg_212_1.time_ and arg_212_1.time_ <= var_215_30 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				local var_215_32 = arg_212_1:FormatText(StoryNameCfg[6].name)

				arg_212_1.leftNameTxt_.text = var_215_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_33 = arg_212_1:GetWordFromCfg(319631052)
				local var_215_34 = arg_212_1:FormatText(var_215_33.content)

				arg_212_1.text_.text = var_215_34

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_35 = 7
				local var_215_36 = utf8.len(var_215_34)
				local var_215_37 = var_215_35 <= 0 and var_215_31 or var_215_31 * (var_215_36 / var_215_35)

				if var_215_37 > 0 and var_215_31 < var_215_37 then
					arg_212_1.talkMaxDuration = var_215_37

					if var_215_37 + var_215_30 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_37 + var_215_30
					end
				end

				arg_212_1.text_.text = var_215_34
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631052", "story_v_out_319631.awb") ~= 0 then
					local var_215_38 = manager.audio:GetVoiceLength("story_v_out_319631", "319631052", "story_v_out_319631.awb") / 1000

					if var_215_38 + var_215_30 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_38 + var_215_30
					end

					if var_215_33.prefab_name ~= "" and arg_212_1.actors_[var_215_33.prefab_name] ~= nil then
						local var_215_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_33.prefab_name].transform, "story_v_out_319631", "319631052", "story_v_out_319631.awb")

						arg_212_1:RecordAudio("319631052", var_215_39)
						arg_212_1:RecordAudio("319631052", var_215_39)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_319631", "319631052", "story_v_out_319631.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_319631", "319631052", "story_v_out_319631.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_40 = math.max(var_215_31, arg_212_1.talkMaxDuration)

			if var_215_30 <= arg_212_1.time_ and arg_212_1.time_ < var_215_30 + var_215_40 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_30) / var_215_40

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_30 + var_215_40 and arg_212_1.time_ < var_215_30 + var_215_40 + arg_215_0 then
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
			local var_219_0 = arg_216_1.actors_["4037ui_story"].transform
			local var_219_1 = 0

			if var_219_1 < arg_216_1.time_ and arg_216_1.time_ <= var_219_1 + arg_219_0 then
				arg_216_1.var_.moveOldPos4037ui_story = var_219_0.localPosition
			end

			local var_219_2 = 0.001

			if var_219_1 <= arg_216_1.time_ and arg_216_1.time_ < var_219_1 + var_219_2 then
				local var_219_3 = (arg_216_1.time_ - var_219_1) / var_219_2
				local var_219_4 = Vector3.New(-0.7, -1.12, -6.2)

				var_219_0.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPos4037ui_story, var_219_4, var_219_3)

				local var_219_5 = manager.ui.mainCamera.transform.position - var_219_0.position

				var_219_0.forward = Vector3.New(var_219_5.x, var_219_5.y, var_219_5.z)

				local var_219_6 = var_219_0.localEulerAngles

				var_219_6.z = 0
				var_219_6.x = 0
				var_219_0.localEulerAngles = var_219_6
			end

			if arg_216_1.time_ >= var_219_1 + var_219_2 and arg_216_1.time_ < var_219_1 + var_219_2 + arg_219_0 then
				var_219_0.localPosition = Vector3.New(-0.7, -1.12, -6.2)

				local var_219_7 = manager.ui.mainCamera.transform.position - var_219_0.position

				var_219_0.forward = Vector3.New(var_219_7.x, var_219_7.y, var_219_7.z)

				local var_219_8 = var_219_0.localEulerAngles

				var_219_8.z = 0
				var_219_8.x = 0
				var_219_0.localEulerAngles = var_219_8
			end

			local var_219_9 = arg_216_1.actors_["4037ui_story"]
			local var_219_10 = 0

			if var_219_10 < arg_216_1.time_ and arg_216_1.time_ <= var_219_10 + arg_219_0 and not isNil(var_219_9) and arg_216_1.var_.characterEffect4037ui_story == nil then
				arg_216_1.var_.characterEffect4037ui_story = var_219_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_11 = 0.200000002980232

			if var_219_10 <= arg_216_1.time_ and arg_216_1.time_ < var_219_10 + var_219_11 and not isNil(var_219_9) then
				local var_219_12 = (arg_216_1.time_ - var_219_10) / var_219_11

				if arg_216_1.var_.characterEffect4037ui_story and not isNil(var_219_9) then
					arg_216_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_216_1.time_ >= var_219_10 + var_219_11 and arg_216_1.time_ < var_219_10 + var_219_11 + arg_219_0 and not isNil(var_219_9) and arg_216_1.var_.characterEffect4037ui_story then
				arg_216_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_219_13 = 0

			if var_219_13 < arg_216_1.time_ and arg_216_1.time_ <= var_219_13 + arg_219_0 then
				arg_216_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			local var_219_14 = 0

			if var_219_14 < arg_216_1.time_ and arg_216_1.time_ <= var_219_14 + arg_219_0 then
				arg_216_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_219_15 = arg_216_1.actors_["10079ui_story"].transform
			local var_219_16 = 0

			if var_219_16 < arg_216_1.time_ and arg_216_1.time_ <= var_219_16 + arg_219_0 then
				arg_216_1.var_.moveOldPos10079ui_story = var_219_15.localPosition
			end

			local var_219_17 = 0.001

			if var_219_16 <= arg_216_1.time_ and arg_216_1.time_ < var_219_16 + var_219_17 then
				local var_219_18 = (arg_216_1.time_ - var_219_16) / var_219_17
				local var_219_19 = Vector3.New(0.7, -0.95, -6.05)

				var_219_15.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPos10079ui_story, var_219_19, var_219_18)

				local var_219_20 = manager.ui.mainCamera.transform.position - var_219_15.position

				var_219_15.forward = Vector3.New(var_219_20.x, var_219_20.y, var_219_20.z)

				local var_219_21 = var_219_15.localEulerAngles

				var_219_21.z = 0
				var_219_21.x = 0
				var_219_15.localEulerAngles = var_219_21
			end

			if arg_216_1.time_ >= var_219_16 + var_219_17 and arg_216_1.time_ < var_219_16 + var_219_17 + arg_219_0 then
				var_219_15.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_219_22 = manager.ui.mainCamera.transform.position - var_219_15.position

				var_219_15.forward = Vector3.New(var_219_22.x, var_219_22.y, var_219_22.z)

				local var_219_23 = var_219_15.localEulerAngles

				var_219_23.z = 0
				var_219_23.x = 0
				var_219_15.localEulerAngles = var_219_23
			end

			local var_219_24 = arg_216_1.actors_["10079ui_story"]
			local var_219_25 = 0

			if var_219_25 < arg_216_1.time_ and arg_216_1.time_ <= var_219_25 + arg_219_0 and not isNil(var_219_24) and arg_216_1.var_.characterEffect10079ui_story == nil then
				arg_216_1.var_.characterEffect10079ui_story = var_219_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_26 = 0.200000002980232

			if var_219_25 <= arg_216_1.time_ and arg_216_1.time_ < var_219_25 + var_219_26 and not isNil(var_219_24) then
				local var_219_27 = (arg_216_1.time_ - var_219_25) / var_219_26

				if arg_216_1.var_.characterEffect10079ui_story and not isNil(var_219_24) then
					local var_219_28 = Mathf.Lerp(0, 0.5, var_219_27)

					arg_216_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_216_1.var_.characterEffect10079ui_story.fillRatio = var_219_28
				end
			end

			if arg_216_1.time_ >= var_219_25 + var_219_26 and arg_216_1.time_ < var_219_25 + var_219_26 + arg_219_0 and not isNil(var_219_24) and arg_216_1.var_.characterEffect10079ui_story then
				local var_219_29 = 0.5

				arg_216_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_216_1.var_.characterEffect10079ui_story.fillRatio = var_219_29
			end

			local var_219_30 = 0
			local var_219_31 = 0.425

			if var_219_30 < arg_216_1.time_ and arg_216_1.time_ <= var_219_30 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				local var_219_32 = arg_216_1:FormatText(StoryNameCfg[453].name)

				arg_216_1.leftNameTxt_.text = var_219_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_33 = arg_216_1:GetWordFromCfg(319631053)
				local var_219_34 = arg_216_1:FormatText(var_219_33.content)

				arg_216_1.text_.text = var_219_34

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_35 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631053", "story_v_out_319631.awb") ~= 0 then
					local var_219_38 = manager.audio:GetVoiceLength("story_v_out_319631", "319631053", "story_v_out_319631.awb") / 1000

					if var_219_38 + var_219_30 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_38 + var_219_30
					end

					if var_219_33.prefab_name ~= "" and arg_216_1.actors_[var_219_33.prefab_name] ~= nil then
						local var_219_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_33.prefab_name].transform, "story_v_out_319631", "319631053", "story_v_out_319631.awb")

						arg_216_1:RecordAudio("319631053", var_219_39)
						arg_216_1:RecordAudio("319631053", var_219_39)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_319631", "319631053", "story_v_out_319631.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_319631", "319631053", "story_v_out_319631.awb")
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
			local var_223_0 = arg_220_1.actors_["10079ui_story"]
			local var_223_1 = 0

			if var_223_1 < arg_220_1.time_ and arg_220_1.time_ <= var_223_1 + arg_223_0 and not isNil(var_223_0) and arg_220_1.var_.characterEffect10079ui_story == nil then
				arg_220_1.var_.characterEffect10079ui_story = var_223_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_2 = 0.200000002980232

			if var_223_1 <= arg_220_1.time_ and arg_220_1.time_ < var_223_1 + var_223_2 and not isNil(var_223_0) then
				local var_223_3 = (arg_220_1.time_ - var_223_1) / var_223_2

				if arg_220_1.var_.characterEffect10079ui_story and not isNil(var_223_0) then
					arg_220_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_220_1.time_ >= var_223_1 + var_223_2 and arg_220_1.time_ < var_223_1 + var_223_2 + arg_223_0 and not isNil(var_223_0) and arg_220_1.var_.characterEffect10079ui_story then
				arg_220_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_223_4 = 0

			if var_223_4 < arg_220_1.time_ and arg_220_1.time_ <= var_223_4 + arg_223_0 then
				arg_220_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_1")
			end

			local var_223_5 = 0

			if var_223_5 < arg_220_1.time_ and arg_220_1.time_ <= var_223_5 + arg_223_0 then
				arg_220_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_223_6 = arg_220_1.actors_["4037ui_story"]
			local var_223_7 = 0

			if var_223_7 < arg_220_1.time_ and arg_220_1.time_ <= var_223_7 + arg_223_0 and not isNil(var_223_6) and arg_220_1.var_.characterEffect4037ui_story == nil then
				arg_220_1.var_.characterEffect4037ui_story = var_223_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_8 = 0.200000002980232

			if var_223_7 <= arg_220_1.time_ and arg_220_1.time_ < var_223_7 + var_223_8 and not isNil(var_223_6) then
				local var_223_9 = (arg_220_1.time_ - var_223_7) / var_223_8

				if arg_220_1.var_.characterEffect4037ui_story and not isNil(var_223_6) then
					local var_223_10 = Mathf.Lerp(0, 0.5, var_223_9)

					arg_220_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_220_1.var_.characterEffect4037ui_story.fillRatio = var_223_10
				end
			end

			if arg_220_1.time_ >= var_223_7 + var_223_8 and arg_220_1.time_ < var_223_7 + var_223_8 + arg_223_0 and not isNil(var_223_6) and arg_220_1.var_.characterEffect4037ui_story then
				local var_223_11 = 0.5

				arg_220_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_220_1.var_.characterEffect4037ui_story.fillRatio = var_223_11
			end

			local var_223_12 = 0
			local var_223_13 = 0.575

			if var_223_12 < arg_220_1.time_ and arg_220_1.time_ <= var_223_12 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				local var_223_14 = arg_220_1:FormatText(StoryNameCfg[6].name)

				arg_220_1.leftNameTxt_.text = var_223_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_15 = arg_220_1:GetWordFromCfg(319631054)
				local var_223_16 = arg_220_1:FormatText(var_223_15.content)

				arg_220_1.text_.text = var_223_16

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_17 = 23
				local var_223_18 = utf8.len(var_223_16)
				local var_223_19 = var_223_17 <= 0 and var_223_13 or var_223_13 * (var_223_18 / var_223_17)

				if var_223_19 > 0 and var_223_13 < var_223_19 then
					arg_220_1.talkMaxDuration = var_223_19

					if var_223_19 + var_223_12 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_19 + var_223_12
					end
				end

				arg_220_1.text_.text = var_223_16
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631054", "story_v_out_319631.awb") ~= 0 then
					local var_223_20 = manager.audio:GetVoiceLength("story_v_out_319631", "319631054", "story_v_out_319631.awb") / 1000

					if var_223_20 + var_223_12 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_20 + var_223_12
					end

					if var_223_15.prefab_name ~= "" and arg_220_1.actors_[var_223_15.prefab_name] ~= nil then
						local var_223_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_15.prefab_name].transform, "story_v_out_319631", "319631054", "story_v_out_319631.awb")

						arg_220_1:RecordAudio("319631054", var_223_21)
						arg_220_1:RecordAudio("319631054", var_223_21)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_319631", "319631054", "story_v_out_319631.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_319631", "319631054", "story_v_out_319631.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_22 = math.max(var_223_13, arg_220_1.talkMaxDuration)

			if var_223_12 <= arg_220_1.time_ and arg_220_1.time_ < var_223_12 + var_223_22 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_12) / var_223_22

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_12 + var_223_22 and arg_220_1.time_ < var_223_12 + var_223_22 + arg_223_0 then
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
			local var_227_0 = arg_224_1.actors_["10079ui_story"].transform
			local var_227_1 = 0

			if var_227_1 < arg_224_1.time_ and arg_224_1.time_ <= var_227_1 + arg_227_0 then
				arg_224_1.var_.moveOldPos10079ui_story = var_227_0.localPosition
			end

			local var_227_2 = 0.001

			if var_227_1 <= arg_224_1.time_ and arg_224_1.time_ < var_227_1 + var_227_2 then
				local var_227_3 = (arg_224_1.time_ - var_227_1) / var_227_2
				local var_227_4 = Vector3.New(0, 100, 0)

				var_227_0.localPosition = Vector3.Lerp(arg_224_1.var_.moveOldPos10079ui_story, var_227_4, var_227_3)

				local var_227_5 = manager.ui.mainCamera.transform.position - var_227_0.position

				var_227_0.forward = Vector3.New(var_227_5.x, var_227_5.y, var_227_5.z)

				local var_227_6 = var_227_0.localEulerAngles

				var_227_6.z = 0
				var_227_6.x = 0
				var_227_0.localEulerAngles = var_227_6
			end

			if arg_224_1.time_ >= var_227_1 + var_227_2 and arg_224_1.time_ < var_227_1 + var_227_2 + arg_227_0 then
				var_227_0.localPosition = Vector3.New(0, 100, 0)

				local var_227_7 = manager.ui.mainCamera.transform.position - var_227_0.position

				var_227_0.forward = Vector3.New(var_227_7.x, var_227_7.y, var_227_7.z)

				local var_227_8 = var_227_0.localEulerAngles

				var_227_8.z = 0
				var_227_8.x = 0
				var_227_0.localEulerAngles = var_227_8
			end

			local var_227_9 = arg_224_1.actors_["10079ui_story"]
			local var_227_10 = 0

			if var_227_10 < arg_224_1.time_ and arg_224_1.time_ <= var_227_10 + arg_227_0 and not isNil(var_227_9) and arg_224_1.var_.characterEffect10079ui_story == nil then
				arg_224_1.var_.characterEffect10079ui_story = var_227_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_11 = 0.200000002980232

			if var_227_10 <= arg_224_1.time_ and arg_224_1.time_ < var_227_10 + var_227_11 and not isNil(var_227_9) then
				local var_227_12 = (arg_224_1.time_ - var_227_10) / var_227_11

				if arg_224_1.var_.characterEffect10079ui_story and not isNil(var_227_9) then
					local var_227_13 = Mathf.Lerp(0, 0.5, var_227_12)

					arg_224_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_224_1.var_.characterEffect10079ui_story.fillRatio = var_227_13
				end
			end

			if arg_224_1.time_ >= var_227_10 + var_227_11 and arg_224_1.time_ < var_227_10 + var_227_11 + arg_227_0 and not isNil(var_227_9) and arg_224_1.var_.characterEffect10079ui_story then
				local var_227_14 = 0.5

				arg_224_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_224_1.var_.characterEffect10079ui_story.fillRatio = var_227_14
			end

			local var_227_15 = arg_224_1.actors_["4037ui_story"].transform
			local var_227_16 = 0

			if var_227_16 < arg_224_1.time_ and arg_224_1.time_ <= var_227_16 + arg_227_0 then
				arg_224_1.var_.moveOldPos4037ui_story = var_227_15.localPosition
			end

			local var_227_17 = 0.001

			if var_227_16 <= arg_224_1.time_ and arg_224_1.time_ < var_227_16 + var_227_17 then
				local var_227_18 = (arg_224_1.time_ - var_227_16) / var_227_17
				local var_227_19 = Vector3.New(0, 100, 0)

				var_227_15.localPosition = Vector3.Lerp(arg_224_1.var_.moveOldPos4037ui_story, var_227_19, var_227_18)

				local var_227_20 = manager.ui.mainCamera.transform.position - var_227_15.position

				var_227_15.forward = Vector3.New(var_227_20.x, var_227_20.y, var_227_20.z)

				local var_227_21 = var_227_15.localEulerAngles

				var_227_21.z = 0
				var_227_21.x = 0
				var_227_15.localEulerAngles = var_227_21
			end

			if arg_224_1.time_ >= var_227_16 + var_227_17 and arg_224_1.time_ < var_227_16 + var_227_17 + arg_227_0 then
				var_227_15.localPosition = Vector3.New(0, 100, 0)

				local var_227_22 = manager.ui.mainCamera.transform.position - var_227_15.position

				var_227_15.forward = Vector3.New(var_227_22.x, var_227_22.y, var_227_22.z)

				local var_227_23 = var_227_15.localEulerAngles

				var_227_23.z = 0
				var_227_23.x = 0
				var_227_15.localEulerAngles = var_227_23
			end

			local var_227_24 = 0
			local var_227_25 = 1.15

			if var_227_24 < arg_224_1.time_ and arg_224_1.time_ <= var_227_24 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, false)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_26 = arg_224_1:GetWordFromCfg(319631055)
				local var_227_27 = arg_224_1:FormatText(var_227_26.content)

				arg_224_1.text_.text = var_227_27

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_28 = 46
				local var_227_29 = utf8.len(var_227_27)
				local var_227_30 = var_227_28 <= 0 and var_227_25 or var_227_25 * (var_227_29 / var_227_28)

				if var_227_30 > 0 and var_227_25 < var_227_30 then
					arg_224_1.talkMaxDuration = var_227_30

					if var_227_30 + var_227_24 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_30 + var_227_24
					end
				end

				arg_224_1.text_.text = var_227_27
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)
				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_31 = math.max(var_227_25, arg_224_1.talkMaxDuration)

			if var_227_24 <= arg_224_1.time_ and arg_224_1.time_ < var_227_24 + var_227_31 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_24) / var_227_31

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_24 + var_227_31 and arg_224_1.time_ < var_227_24 + var_227_31 + arg_227_0 then
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
			local var_231_0 = arg_228_1.actors_["4037ui_story"].transform
			local var_231_1 = 0

			if var_231_1 < arg_228_1.time_ and arg_228_1.time_ <= var_231_1 + arg_231_0 then
				arg_228_1.var_.moveOldPos4037ui_story = var_231_0.localPosition
			end

			local var_231_2 = 0.001

			if var_231_1 <= arg_228_1.time_ and arg_228_1.time_ < var_231_1 + var_231_2 then
				local var_231_3 = (arg_228_1.time_ - var_231_1) / var_231_2
				local var_231_4 = Vector3.New(0, -1.12, -6.2)

				var_231_0.localPosition = Vector3.Lerp(arg_228_1.var_.moveOldPos4037ui_story, var_231_4, var_231_3)

				local var_231_5 = manager.ui.mainCamera.transform.position - var_231_0.position

				var_231_0.forward = Vector3.New(var_231_5.x, var_231_5.y, var_231_5.z)

				local var_231_6 = var_231_0.localEulerAngles

				var_231_6.z = 0
				var_231_6.x = 0
				var_231_0.localEulerAngles = var_231_6
			end

			if arg_228_1.time_ >= var_231_1 + var_231_2 and arg_228_1.time_ < var_231_1 + var_231_2 + arg_231_0 then
				var_231_0.localPosition = Vector3.New(0, -1.12, -6.2)

				local var_231_7 = manager.ui.mainCamera.transform.position - var_231_0.position

				var_231_0.forward = Vector3.New(var_231_7.x, var_231_7.y, var_231_7.z)

				local var_231_8 = var_231_0.localEulerAngles

				var_231_8.z = 0
				var_231_8.x = 0
				var_231_0.localEulerAngles = var_231_8
			end

			local var_231_9 = arg_228_1.actors_["4037ui_story"]
			local var_231_10 = 0

			if var_231_10 < arg_228_1.time_ and arg_228_1.time_ <= var_231_10 + arg_231_0 and not isNil(var_231_9) and arg_228_1.var_.characterEffect4037ui_story == nil then
				arg_228_1.var_.characterEffect4037ui_story = var_231_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_11 = 0.200000002980232

			if var_231_10 <= arg_228_1.time_ and arg_228_1.time_ < var_231_10 + var_231_11 and not isNil(var_231_9) then
				local var_231_12 = (arg_228_1.time_ - var_231_10) / var_231_11

				if arg_228_1.var_.characterEffect4037ui_story and not isNil(var_231_9) then
					arg_228_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_228_1.time_ >= var_231_10 + var_231_11 and arg_228_1.time_ < var_231_10 + var_231_11 + arg_231_0 and not isNil(var_231_9) and arg_228_1.var_.characterEffect4037ui_story then
				arg_228_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_231_13 = 0

			if var_231_13 < arg_228_1.time_ and arg_228_1.time_ <= var_231_13 + arg_231_0 then
				arg_228_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action5_1")
			end

			local var_231_14 = 0

			if var_231_14 < arg_228_1.time_ and arg_228_1.time_ <= var_231_14 + arg_231_0 then
				arg_228_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if arg_228_1.frameCnt_ <= 1 then
				arg_228_1.dialog_:SetActive(false)
			end

			local var_231_15 = 0.666666666666667
			local var_231_16 = 0.1

			if var_231_15 < arg_228_1.time_ and arg_228_1.time_ <= var_231_15 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0

				arg_228_1.dialog_:SetActive(true)

				arg_228_1.dialogCg_.alpha = 0

				local var_231_17 = LeanTween.value(arg_228_1.dialog_, 0, 1, 0.3)

				var_231_17:setOnUpdate(LuaHelper.FloatAction(function(arg_232_0)
					arg_228_1.dialogCg_.alpha = arg_232_0
				end))
				var_231_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_228_1.dialog_)
					var_231_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_228_1.duration_ = arg_228_1.duration_ + 0.3

				SetActive(arg_228_1.leftNameGo_, true)

				local var_231_18 = arg_228_1:FormatText(StoryNameCfg[453].name)

				arg_228_1.leftNameTxt_.text = var_231_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_19 = arg_228_1:GetWordFromCfg(319631056)
				local var_231_20 = arg_228_1:FormatText(var_231_19.content)

				arg_228_1.text_.text = var_231_20

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_21 = 4
				local var_231_22 = utf8.len(var_231_20)
				local var_231_23 = var_231_21 <= 0 and var_231_16 or var_231_16 * (var_231_22 / var_231_21)

				if var_231_23 > 0 and var_231_16 < var_231_23 then
					arg_228_1.talkMaxDuration = var_231_23
					var_231_15 = var_231_15 + 0.3

					if var_231_23 + var_231_15 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_23 + var_231_15
					end
				end

				arg_228_1.text_.text = var_231_20
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631056", "story_v_out_319631.awb") ~= 0 then
					local var_231_24 = manager.audio:GetVoiceLength("story_v_out_319631", "319631056", "story_v_out_319631.awb") / 1000

					if var_231_24 + var_231_15 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_24 + var_231_15
					end

					if var_231_19.prefab_name ~= "" and arg_228_1.actors_[var_231_19.prefab_name] ~= nil then
						local var_231_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_19.prefab_name].transform, "story_v_out_319631", "319631056", "story_v_out_319631.awb")

						arg_228_1:RecordAudio("319631056", var_231_25)
						arg_228_1:RecordAudio("319631056", var_231_25)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_out_319631", "319631056", "story_v_out_319631.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_out_319631", "319631056", "story_v_out_319631.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_26 = var_231_15 + 0.3
			local var_231_27 = math.max(var_231_16, arg_228_1.talkMaxDuration)

			if var_231_26 <= arg_228_1.time_ and arg_228_1.time_ < var_231_26 + var_231_27 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_26) / var_231_27

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_26 + var_231_27 and arg_228_1.time_ < var_231_26 + var_231_27 + arg_231_0 then
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
			local var_237_0 = arg_234_1.actors_["10037ui_story"].transform
			local var_237_1 = 0

			if var_237_1 < arg_234_1.time_ and arg_234_1.time_ <= var_237_1 + arg_237_0 then
				arg_234_1.var_.moveOldPos10037ui_story = var_237_0.localPosition
			end

			local var_237_2 = 0.001

			if var_237_1 <= arg_234_1.time_ and arg_234_1.time_ < var_237_1 + var_237_2 then
				local var_237_3 = (arg_234_1.time_ - var_237_1) / var_237_2
				local var_237_4 = Vector3.New(0.7, -1.13, -6.2)

				var_237_0.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos10037ui_story, var_237_4, var_237_3)

				local var_237_5 = manager.ui.mainCamera.transform.position - var_237_0.position

				var_237_0.forward = Vector3.New(var_237_5.x, var_237_5.y, var_237_5.z)

				local var_237_6 = var_237_0.localEulerAngles

				var_237_6.z = 0
				var_237_6.x = 0
				var_237_0.localEulerAngles = var_237_6
			end

			if arg_234_1.time_ >= var_237_1 + var_237_2 and arg_234_1.time_ < var_237_1 + var_237_2 + arg_237_0 then
				var_237_0.localPosition = Vector3.New(0.7, -1.13, -6.2)

				local var_237_7 = manager.ui.mainCamera.transform.position - var_237_0.position

				var_237_0.forward = Vector3.New(var_237_7.x, var_237_7.y, var_237_7.z)

				local var_237_8 = var_237_0.localEulerAngles

				var_237_8.z = 0
				var_237_8.x = 0
				var_237_0.localEulerAngles = var_237_8
			end

			local var_237_9 = arg_234_1.actors_["10037ui_story"]
			local var_237_10 = 0

			if var_237_10 < arg_234_1.time_ and arg_234_1.time_ <= var_237_10 + arg_237_0 and not isNil(var_237_9) and arg_234_1.var_.characterEffect10037ui_story == nil then
				arg_234_1.var_.characterEffect10037ui_story = var_237_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_11 = 0.200000002980232

			if var_237_10 <= arg_234_1.time_ and arg_234_1.time_ < var_237_10 + var_237_11 and not isNil(var_237_9) then
				local var_237_12 = (arg_234_1.time_ - var_237_10) / var_237_11

				if arg_234_1.var_.characterEffect10037ui_story and not isNil(var_237_9) then
					arg_234_1.var_.characterEffect10037ui_story.fillFlat = false
				end
			end

			if arg_234_1.time_ >= var_237_10 + var_237_11 and arg_234_1.time_ < var_237_10 + var_237_11 + arg_237_0 and not isNil(var_237_9) and arg_234_1.var_.characterEffect10037ui_story then
				arg_234_1.var_.characterEffect10037ui_story.fillFlat = false
			end

			local var_237_13 = 0

			if var_237_13 < arg_234_1.time_ and arg_234_1.time_ <= var_237_13 + arg_237_0 then
				arg_234_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/story10037/story10037action/10037action3_1")
			end

			local var_237_14 = 0

			if var_237_14 < arg_234_1.time_ and arg_234_1.time_ <= var_237_14 + arg_237_0 then
				arg_234_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_237_15 = arg_234_1.actors_["4037ui_story"].transform
			local var_237_16 = 0

			if var_237_16 < arg_234_1.time_ and arg_234_1.time_ <= var_237_16 + arg_237_0 then
				arg_234_1.var_.moveOldPos4037ui_story = var_237_15.localPosition
			end

			local var_237_17 = 0.001

			if var_237_16 <= arg_234_1.time_ and arg_234_1.time_ < var_237_16 + var_237_17 then
				local var_237_18 = (arg_234_1.time_ - var_237_16) / var_237_17
				local var_237_19 = Vector3.New(-0.7, -1.12, -6.2)

				var_237_15.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos4037ui_story, var_237_19, var_237_18)

				local var_237_20 = manager.ui.mainCamera.transform.position - var_237_15.position

				var_237_15.forward = Vector3.New(var_237_20.x, var_237_20.y, var_237_20.z)

				local var_237_21 = var_237_15.localEulerAngles

				var_237_21.z = 0
				var_237_21.x = 0
				var_237_15.localEulerAngles = var_237_21
			end

			if arg_234_1.time_ >= var_237_16 + var_237_17 and arg_234_1.time_ < var_237_16 + var_237_17 + arg_237_0 then
				var_237_15.localPosition = Vector3.New(-0.7, -1.12, -6.2)

				local var_237_22 = manager.ui.mainCamera.transform.position - var_237_15.position

				var_237_15.forward = Vector3.New(var_237_22.x, var_237_22.y, var_237_22.z)

				local var_237_23 = var_237_15.localEulerAngles

				var_237_23.z = 0
				var_237_23.x = 0
				var_237_15.localEulerAngles = var_237_23
			end

			local var_237_24 = arg_234_1.actors_["4037ui_story"]
			local var_237_25 = 0

			if var_237_25 < arg_234_1.time_ and arg_234_1.time_ <= var_237_25 + arg_237_0 and not isNil(var_237_24) and arg_234_1.var_.characterEffect4037ui_story == nil then
				arg_234_1.var_.characterEffect4037ui_story = var_237_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_26 = 0.200000002980232

			if var_237_25 <= arg_234_1.time_ and arg_234_1.time_ < var_237_25 + var_237_26 and not isNil(var_237_24) then
				local var_237_27 = (arg_234_1.time_ - var_237_25) / var_237_26

				if arg_234_1.var_.characterEffect4037ui_story and not isNil(var_237_24) then
					local var_237_28 = Mathf.Lerp(0, 0.5, var_237_27)

					arg_234_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_234_1.var_.characterEffect4037ui_story.fillRatio = var_237_28
				end
			end

			if arg_234_1.time_ >= var_237_25 + var_237_26 and arg_234_1.time_ < var_237_25 + var_237_26 + arg_237_0 and not isNil(var_237_24) and arg_234_1.var_.characterEffect4037ui_story then
				local var_237_29 = 0.5

				arg_234_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_234_1.var_.characterEffect4037ui_story.fillRatio = var_237_29
			end

			local var_237_30 = 0
			local var_237_31 = 0.425

			if var_237_30 < arg_234_1.time_ and arg_234_1.time_ <= var_237_30 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				local var_237_32 = arg_234_1:FormatText(StoryNameCfg[383].name)

				arg_234_1.leftNameTxt_.text = var_237_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_33 = arg_234_1:GetWordFromCfg(319631057)
				local var_237_34 = arg_234_1:FormatText(var_237_33.content)

				arg_234_1.text_.text = var_237_34

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_35 = 17
				local var_237_36 = utf8.len(var_237_34)
				local var_237_37 = var_237_35 <= 0 and var_237_31 or var_237_31 * (var_237_36 / var_237_35)

				if var_237_37 > 0 and var_237_31 < var_237_37 then
					arg_234_1.talkMaxDuration = var_237_37

					if var_237_37 + var_237_30 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_37 + var_237_30
					end
				end

				arg_234_1.text_.text = var_237_34
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631057", "story_v_out_319631.awb") ~= 0 then
					local var_237_38 = manager.audio:GetVoiceLength("story_v_out_319631", "319631057", "story_v_out_319631.awb") / 1000

					if var_237_38 + var_237_30 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_38 + var_237_30
					end

					if var_237_33.prefab_name ~= "" and arg_234_1.actors_[var_237_33.prefab_name] ~= nil then
						local var_237_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_33.prefab_name].transform, "story_v_out_319631", "319631057", "story_v_out_319631.awb")

						arg_234_1:RecordAudio("319631057", var_237_39)
						arg_234_1:RecordAudio("319631057", var_237_39)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_319631", "319631057", "story_v_out_319631.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_319631", "319631057", "story_v_out_319631.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_40 = math.max(var_237_31, arg_234_1.talkMaxDuration)

			if var_237_30 <= arg_234_1.time_ and arg_234_1.time_ < var_237_30 + var_237_40 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_30) / var_237_40

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_30 + var_237_40 and arg_234_1.time_ < var_237_30 + var_237_40 + arg_237_0 then
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
			local var_241_0 = 0
			local var_241_1 = 0.75

			if var_241_0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_0 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				local var_241_2 = arg_238_1:FormatText(StoryNameCfg[383].name)

				arg_238_1.leftNameTxt_.text = var_241_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_3 = arg_238_1:GetWordFromCfg(319631058)
				local var_241_4 = arg_238_1:FormatText(var_241_3.content)

				arg_238_1.text_.text = var_241_4

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_5 = 30
				local var_241_6 = utf8.len(var_241_4)
				local var_241_7 = var_241_5 <= 0 and var_241_1 or var_241_1 * (var_241_6 / var_241_5)

				if var_241_7 > 0 and var_241_1 < var_241_7 then
					arg_238_1.talkMaxDuration = var_241_7

					if var_241_7 + var_241_0 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_7 + var_241_0
					end
				end

				arg_238_1.text_.text = var_241_4
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631058", "story_v_out_319631.awb") ~= 0 then
					local var_241_8 = manager.audio:GetVoiceLength("story_v_out_319631", "319631058", "story_v_out_319631.awb") / 1000

					if var_241_8 + var_241_0 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_8 + var_241_0
					end

					if var_241_3.prefab_name ~= "" and arg_238_1.actors_[var_241_3.prefab_name] ~= nil then
						local var_241_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_3.prefab_name].transform, "story_v_out_319631", "319631058", "story_v_out_319631.awb")

						arg_238_1:RecordAudio("319631058", var_241_9)
						arg_238_1:RecordAudio("319631058", var_241_9)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_out_319631", "319631058", "story_v_out_319631.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_out_319631", "319631058", "story_v_out_319631.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_10 = math.max(var_241_1, arg_238_1.talkMaxDuration)

			if var_241_0 <= arg_238_1.time_ and arg_238_1.time_ < var_241_0 + var_241_10 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_0) / var_241_10

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_0 + var_241_10 and arg_238_1.time_ < var_241_0 + var_241_10 + arg_241_0 then
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
			local var_245_0 = arg_242_1.actors_["10079ui_story"].transform
			local var_245_1 = 0

			if var_245_1 < arg_242_1.time_ and arg_242_1.time_ <= var_245_1 + arg_245_0 then
				arg_242_1.var_.moveOldPos10079ui_story = var_245_0.localPosition
			end

			local var_245_2 = 0.001

			if var_245_1 <= arg_242_1.time_ and arg_242_1.time_ < var_245_1 + var_245_2 then
				local var_245_3 = (arg_242_1.time_ - var_245_1) / var_245_2
				local var_245_4 = Vector3.New(0, -0.95, -6.05)

				var_245_0.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos10079ui_story, var_245_4, var_245_3)

				local var_245_5 = manager.ui.mainCamera.transform.position - var_245_0.position

				var_245_0.forward = Vector3.New(var_245_5.x, var_245_5.y, var_245_5.z)

				local var_245_6 = var_245_0.localEulerAngles

				var_245_6.z = 0
				var_245_6.x = 0
				var_245_0.localEulerAngles = var_245_6
			end

			if arg_242_1.time_ >= var_245_1 + var_245_2 and arg_242_1.time_ < var_245_1 + var_245_2 + arg_245_0 then
				var_245_0.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_245_7 = manager.ui.mainCamera.transform.position - var_245_0.position

				var_245_0.forward = Vector3.New(var_245_7.x, var_245_7.y, var_245_7.z)

				local var_245_8 = var_245_0.localEulerAngles

				var_245_8.z = 0
				var_245_8.x = 0
				var_245_0.localEulerAngles = var_245_8
			end

			local var_245_9 = arg_242_1.actors_["10079ui_story"]
			local var_245_10 = 0

			if var_245_10 < arg_242_1.time_ and arg_242_1.time_ <= var_245_10 + arg_245_0 and not isNil(var_245_9) and arg_242_1.var_.characterEffect10079ui_story == nil then
				arg_242_1.var_.characterEffect10079ui_story = var_245_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_11 = 0.200000002980232

			if var_245_10 <= arg_242_1.time_ and arg_242_1.time_ < var_245_10 + var_245_11 and not isNil(var_245_9) then
				local var_245_12 = (arg_242_1.time_ - var_245_10) / var_245_11

				if arg_242_1.var_.characterEffect10079ui_story and not isNil(var_245_9) then
					arg_242_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_242_1.time_ >= var_245_10 + var_245_11 and arg_242_1.time_ < var_245_10 + var_245_11 + arg_245_0 and not isNil(var_245_9) and arg_242_1.var_.characterEffect10079ui_story then
				arg_242_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_245_13 = 0

			if var_245_13 < arg_242_1.time_ and arg_242_1.time_ <= var_245_13 + arg_245_0 then
				arg_242_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action453")
			end

			local var_245_14 = 0

			if var_245_14 < arg_242_1.time_ and arg_242_1.time_ <= var_245_14 + arg_245_0 then
				arg_242_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2201cva")
			end

			local var_245_15 = arg_242_1.actors_["10037ui_story"].transform
			local var_245_16 = 0

			if var_245_16 < arg_242_1.time_ and arg_242_1.time_ <= var_245_16 + arg_245_0 then
				arg_242_1.var_.moveOldPos10037ui_story = var_245_15.localPosition
			end

			local var_245_17 = 0.001

			if var_245_16 <= arg_242_1.time_ and arg_242_1.time_ < var_245_16 + var_245_17 then
				local var_245_18 = (arg_242_1.time_ - var_245_16) / var_245_17
				local var_245_19 = Vector3.New(0, 100, 0)

				var_245_15.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos10037ui_story, var_245_19, var_245_18)

				local var_245_20 = manager.ui.mainCamera.transform.position - var_245_15.position

				var_245_15.forward = Vector3.New(var_245_20.x, var_245_20.y, var_245_20.z)

				local var_245_21 = var_245_15.localEulerAngles

				var_245_21.z = 0
				var_245_21.x = 0
				var_245_15.localEulerAngles = var_245_21
			end

			if arg_242_1.time_ >= var_245_16 + var_245_17 and arg_242_1.time_ < var_245_16 + var_245_17 + arg_245_0 then
				var_245_15.localPosition = Vector3.New(0, 100, 0)

				local var_245_22 = manager.ui.mainCamera.transform.position - var_245_15.position

				var_245_15.forward = Vector3.New(var_245_22.x, var_245_22.y, var_245_22.z)

				local var_245_23 = var_245_15.localEulerAngles

				var_245_23.z = 0
				var_245_23.x = 0
				var_245_15.localEulerAngles = var_245_23
			end

			local var_245_24 = arg_242_1.actors_["10037ui_story"]
			local var_245_25 = 0

			if var_245_25 < arg_242_1.time_ and arg_242_1.time_ <= var_245_25 + arg_245_0 and not isNil(var_245_24) and arg_242_1.var_.characterEffect10037ui_story == nil then
				arg_242_1.var_.characterEffect10037ui_story = var_245_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_26 = 0.200000002980232

			if var_245_25 <= arg_242_1.time_ and arg_242_1.time_ < var_245_25 + var_245_26 and not isNil(var_245_24) then
				local var_245_27 = (arg_242_1.time_ - var_245_25) / var_245_26

				if arg_242_1.var_.characterEffect10037ui_story and not isNil(var_245_24) then
					local var_245_28 = Mathf.Lerp(0, 0.5, var_245_27)

					arg_242_1.var_.characterEffect10037ui_story.fillFlat = true
					arg_242_1.var_.characterEffect10037ui_story.fillRatio = var_245_28
				end
			end

			if arg_242_1.time_ >= var_245_25 + var_245_26 and arg_242_1.time_ < var_245_25 + var_245_26 + arg_245_0 and not isNil(var_245_24) and arg_242_1.var_.characterEffect10037ui_story then
				local var_245_29 = 0.5

				arg_242_1.var_.characterEffect10037ui_story.fillFlat = true
				arg_242_1.var_.characterEffect10037ui_story.fillRatio = var_245_29
			end

			local var_245_30 = arg_242_1.actors_["4037ui_story"].transform
			local var_245_31 = 0

			if var_245_31 < arg_242_1.time_ and arg_242_1.time_ <= var_245_31 + arg_245_0 then
				arg_242_1.var_.moveOldPos4037ui_story = var_245_30.localPosition
			end

			local var_245_32 = 0.001

			if var_245_31 <= arg_242_1.time_ and arg_242_1.time_ < var_245_31 + var_245_32 then
				local var_245_33 = (arg_242_1.time_ - var_245_31) / var_245_32
				local var_245_34 = Vector3.New(0, 100, 0)

				var_245_30.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos4037ui_story, var_245_34, var_245_33)

				local var_245_35 = manager.ui.mainCamera.transform.position - var_245_30.position

				var_245_30.forward = Vector3.New(var_245_35.x, var_245_35.y, var_245_35.z)

				local var_245_36 = var_245_30.localEulerAngles

				var_245_36.z = 0
				var_245_36.x = 0
				var_245_30.localEulerAngles = var_245_36
			end

			if arg_242_1.time_ >= var_245_31 + var_245_32 and arg_242_1.time_ < var_245_31 + var_245_32 + arg_245_0 then
				var_245_30.localPosition = Vector3.New(0, 100, 0)

				local var_245_37 = manager.ui.mainCamera.transform.position - var_245_30.position

				var_245_30.forward = Vector3.New(var_245_37.x, var_245_37.y, var_245_37.z)

				local var_245_38 = var_245_30.localEulerAngles

				var_245_38.z = 0
				var_245_38.x = 0
				var_245_30.localEulerAngles = var_245_38
			end

			local var_245_39 = arg_242_1.actors_["4037ui_story"]
			local var_245_40 = 0

			if var_245_40 < arg_242_1.time_ and arg_242_1.time_ <= var_245_40 + arg_245_0 and not isNil(var_245_39) and arg_242_1.var_.characterEffect4037ui_story == nil then
				arg_242_1.var_.characterEffect4037ui_story = var_245_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_41 = 0.200000002980232

			if var_245_40 <= arg_242_1.time_ and arg_242_1.time_ < var_245_40 + var_245_41 and not isNil(var_245_39) then
				local var_245_42 = (arg_242_1.time_ - var_245_40) / var_245_41

				if arg_242_1.var_.characterEffect4037ui_story and not isNil(var_245_39) then
					local var_245_43 = Mathf.Lerp(0, 0.5, var_245_42)

					arg_242_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_242_1.var_.characterEffect4037ui_story.fillRatio = var_245_43
				end
			end

			if arg_242_1.time_ >= var_245_40 + var_245_41 and arg_242_1.time_ < var_245_40 + var_245_41 + arg_245_0 and not isNil(var_245_39) and arg_242_1.var_.characterEffect4037ui_story then
				local var_245_44 = 0.5

				arg_242_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_242_1.var_.characterEffect4037ui_story.fillRatio = var_245_44
			end

			if arg_242_1.frameCnt_ <= 1 then
				arg_242_1.dialog_:SetActive(false)
			end

			local var_245_45 = 0.433333333333333
			local var_245_46 = 0.075

			if var_245_45 < arg_242_1.time_ and arg_242_1.time_ <= var_245_45 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0

				arg_242_1.dialog_:SetActive(true)

				arg_242_1.dialogCg_.alpha = 0

				local var_245_47 = LeanTween.value(arg_242_1.dialog_, 0, 1, 0.3)

				var_245_47:setOnUpdate(LuaHelper.FloatAction(function(arg_246_0)
					arg_242_1.dialogCg_.alpha = arg_246_0
				end))
				var_245_47:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_242_1.dialog_)
					var_245_47:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_242_1.duration_ = arg_242_1.duration_ + 0.3

				SetActive(arg_242_1.leftNameGo_, true)

				local var_245_48 = arg_242_1:FormatText(StoryNameCfg[6].name)

				arg_242_1.leftNameTxt_.text = var_245_48

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_49 = arg_242_1:GetWordFromCfg(319631059)
				local var_245_50 = arg_242_1:FormatText(var_245_49.content)

				arg_242_1.text_.text = var_245_50

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_51 = 3
				local var_245_52 = utf8.len(var_245_50)
				local var_245_53 = var_245_51 <= 0 and var_245_46 or var_245_46 * (var_245_52 / var_245_51)

				if var_245_53 > 0 and var_245_46 < var_245_53 then
					arg_242_1.talkMaxDuration = var_245_53
					var_245_45 = var_245_45 + 0.3

					if var_245_53 + var_245_45 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_53 + var_245_45
					end
				end

				arg_242_1.text_.text = var_245_50
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631059", "story_v_out_319631.awb") ~= 0 then
					local var_245_54 = manager.audio:GetVoiceLength("story_v_out_319631", "319631059", "story_v_out_319631.awb") / 1000

					if var_245_54 + var_245_45 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_54 + var_245_45
					end

					if var_245_49.prefab_name ~= "" and arg_242_1.actors_[var_245_49.prefab_name] ~= nil then
						local var_245_55 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_49.prefab_name].transform, "story_v_out_319631", "319631059", "story_v_out_319631.awb")

						arg_242_1:RecordAudio("319631059", var_245_55)
						arg_242_1:RecordAudio("319631059", var_245_55)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_out_319631", "319631059", "story_v_out_319631.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_out_319631", "319631059", "story_v_out_319631.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_56 = var_245_45 + 0.3
			local var_245_57 = math.max(var_245_46, arg_242_1.talkMaxDuration)

			if var_245_56 <= arg_242_1.time_ and arg_242_1.time_ < var_245_56 + var_245_57 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_56) / var_245_57

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_56 + var_245_57 and arg_242_1.time_ < var_245_56 + var_245_57 + arg_245_0 then
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
			local var_251_0 = 2

			if var_251_0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_0 + arg_251_0 then
				local var_251_1 = manager.ui.mainCamera.transform.localPosition
				local var_251_2 = Vector3.New(0, 0, 10) + Vector3.New(var_251_1.x, var_251_1.y, 0)
				local var_251_3 = arg_248_1.bgs_.STblack

				var_251_3.transform.localPosition = var_251_2
				var_251_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_251_4 = var_251_3:GetComponent("SpriteRenderer")

				if var_251_4 and var_251_4.sprite then
					local var_251_5 = (var_251_3.transform.localPosition - var_251_1).z
					local var_251_6 = manager.ui.mainCameraCom_
					local var_251_7 = 2 * var_251_5 * Mathf.Tan(var_251_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_251_8 = var_251_7 * var_251_6.aspect
					local var_251_9 = var_251_4.sprite.bounds.size.x
					local var_251_10 = var_251_4.sprite.bounds.size.y
					local var_251_11 = var_251_8 / var_251_9
					local var_251_12 = var_251_7 / var_251_10
					local var_251_13 = var_251_12 < var_251_11 and var_251_11 or var_251_12

					var_251_3.transform.localScale = Vector3.New(var_251_13, var_251_13, 0)
				end

				for iter_251_0, iter_251_1 in pairs(arg_248_1.bgs_) do
					if iter_251_0 ~= "STblack" then
						iter_251_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_251_14 = 2

			if var_251_14 < arg_248_1.time_ and arg_248_1.time_ <= var_251_14 + arg_251_0 then
				arg_248_1.fswbg_:SetActive(true)
				arg_248_1.dialog_:SetActive(false)

				arg_248_1.fswtw_.percent = 0

				local var_251_15 = arg_248_1:GetWordFromCfg(319631060)
				local var_251_16 = arg_248_1:FormatText(var_251_15.content)

				arg_248_1.fswt_.text = var_251_16

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.fswt_)

				arg_248_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_248_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_248_1.fswtw_:SetDirty()

				arg_248_1.typewritterCharCountI18N = 0

				SetActive(arg_248_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_248_1:ShowNextGo(false)
			end

			local var_251_17 = 2.86666666666667

			if var_251_17 < arg_248_1.time_ and arg_248_1.time_ <= var_251_17 + arg_251_0 then
				arg_248_1.var_.oldValueTypewriter = arg_248_1.fswtw_.percent

				SetActive(arg_248_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_248_1:ShowNextGo(false)
			end

			local var_251_18 = 14
			local var_251_19 = 0.533333333333333
			local var_251_20 = arg_248_1:GetWordFromCfg(319631060)
			local var_251_21 = arg_248_1:FormatText(var_251_20.content)
			local var_251_22, var_251_23 = arg_248_1:GetPercentByPara(var_251_21, 1)

			if var_251_17 < arg_248_1.time_ and arg_248_1.time_ <= var_251_17 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0

				local var_251_24 = var_251_18 <= 0 and var_251_19 or var_251_19 * ((var_251_23 - arg_248_1.typewritterCharCountI18N) / var_251_18)

				if var_251_24 > 0 and var_251_19 < var_251_24 then
					arg_248_1.talkMaxDuration = var_251_24

					if var_251_24 + var_251_17 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_24 + var_251_17
					end
				end
			end

			local var_251_25 = 0.533333333333333
			local var_251_26 = math.max(var_251_25, arg_248_1.talkMaxDuration)

			if var_251_17 <= arg_248_1.time_ and arg_248_1.time_ < var_251_17 + var_251_26 then
				local var_251_27 = (arg_248_1.time_ - var_251_17) / var_251_26

				arg_248_1.fswtw_.percent = Mathf.Lerp(arg_248_1.var_.oldValueTypewriter, var_251_22, var_251_27)
				arg_248_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_248_1.fswtw_:SetDirty()
			end

			if arg_248_1.time_ >= var_251_17 + var_251_26 and arg_248_1.time_ < var_251_17 + var_251_26 + arg_251_0 then
				arg_248_1.fswtw_.percent = var_251_22

				arg_248_1.fswtw_:SetDirty()
				arg_248_1:ShowNextGo(true)

				arg_248_1.typewritterCharCountI18N = var_251_23
			end

			local var_251_28 = 0

			if var_251_28 < arg_248_1.time_ and arg_248_1.time_ <= var_251_28 + arg_251_0 then
				arg_248_1.mask_.enabled = true
				arg_248_1.mask_.raycastTarget = true

				arg_248_1:SetGaussion(false)
			end

			local var_251_29 = 2

			if var_251_28 <= arg_248_1.time_ and arg_248_1.time_ < var_251_28 + var_251_29 then
				local var_251_30 = (arg_248_1.time_ - var_251_28) / var_251_29
				local var_251_31 = Color.New(0, 0, 0)

				var_251_31.a = Mathf.Lerp(0, 1, var_251_30)
				arg_248_1.mask_.color = var_251_31
			end

			if arg_248_1.time_ >= var_251_28 + var_251_29 and arg_248_1.time_ < var_251_28 + var_251_29 + arg_251_0 then
				local var_251_32 = Color.New(0, 0, 0)

				var_251_32.a = 1
				arg_248_1.mask_.color = var_251_32
			end

			local var_251_33 = 2

			if var_251_33 < arg_248_1.time_ and arg_248_1.time_ <= var_251_33 + arg_251_0 then
				arg_248_1.mask_.enabled = true
				arg_248_1.mask_.raycastTarget = true

				arg_248_1:SetGaussion(false)
			end

			local var_251_34 = 0.966333333333333

			if var_251_33 <= arg_248_1.time_ and arg_248_1.time_ < var_251_33 + var_251_34 then
				local var_251_35 = (arg_248_1.time_ - var_251_33) / var_251_34
				local var_251_36 = Color.New(0, 0, 0)

				var_251_36.a = Mathf.Lerp(1, 0, var_251_35)
				arg_248_1.mask_.color = var_251_36
			end

			if arg_248_1.time_ >= var_251_33 + var_251_34 and arg_248_1.time_ < var_251_33 + var_251_34 + arg_251_0 then
				local var_251_37 = Color.New(0, 0, 0)
				local var_251_38 = 0

				arg_248_1.mask_.enabled = false
				var_251_37.a = var_251_38
				arg_248_1.mask_.color = var_251_37
			end

			local var_251_39 = arg_248_1.actors_["10079ui_story"].transform
			local var_251_40 = 2

			if var_251_40 < arg_248_1.time_ and arg_248_1.time_ <= var_251_40 + arg_251_0 then
				arg_248_1.var_.moveOldPos10079ui_story = var_251_39.localPosition
			end

			local var_251_41 = 0.001

			if var_251_40 <= arg_248_1.time_ and arg_248_1.time_ < var_251_40 + var_251_41 then
				local var_251_42 = (arg_248_1.time_ - var_251_40) / var_251_41
				local var_251_43 = Vector3.New(0, 100, 0)

				var_251_39.localPosition = Vector3.Lerp(arg_248_1.var_.moveOldPos10079ui_story, var_251_43, var_251_42)

				local var_251_44 = manager.ui.mainCamera.transform.position - var_251_39.position

				var_251_39.forward = Vector3.New(var_251_44.x, var_251_44.y, var_251_44.z)

				local var_251_45 = var_251_39.localEulerAngles

				var_251_45.z = 0
				var_251_45.x = 0
				var_251_39.localEulerAngles = var_251_45
			end

			if arg_248_1.time_ >= var_251_40 + var_251_41 and arg_248_1.time_ < var_251_40 + var_251_41 + arg_251_0 then
				var_251_39.localPosition = Vector3.New(0, 100, 0)

				local var_251_46 = manager.ui.mainCamera.transform.position - var_251_39.position

				var_251_39.forward = Vector3.New(var_251_46.x, var_251_46.y, var_251_46.z)

				local var_251_47 = var_251_39.localEulerAngles

				var_251_47.z = 0
				var_251_47.x = 0
				var_251_39.localEulerAngles = var_251_47
			end

			local var_251_48 = arg_248_1.actors_["10079ui_story"]
			local var_251_49 = 0

			if var_251_49 < arg_248_1.time_ and arg_248_1.time_ <= var_251_49 + arg_251_0 and not isNil(var_251_48) and arg_248_1.var_.characterEffect10079ui_story == nil then
				arg_248_1.var_.characterEffect10079ui_story = var_251_48:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_251_50 = 0.200000002980232

			if var_251_49 <= arg_248_1.time_ and arg_248_1.time_ < var_251_49 + var_251_50 and not isNil(var_251_48) then
				local var_251_51 = (arg_248_1.time_ - var_251_49) / var_251_50

				if arg_248_1.var_.characterEffect10079ui_story and not isNil(var_251_48) then
					local var_251_52 = Mathf.Lerp(0, 0.5, var_251_51)

					arg_248_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_248_1.var_.characterEffect10079ui_story.fillRatio = var_251_52
				end
			end

			if arg_248_1.time_ >= var_251_49 + var_251_50 and arg_248_1.time_ < var_251_49 + var_251_50 + arg_251_0 and not isNil(var_251_48) and arg_248_1.var_.characterEffect10079ui_story then
				local var_251_53 = 0.5

				arg_248_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_248_1.var_.characterEffect10079ui_story.fillRatio = var_251_53
			end

			local var_251_54 = 2.86666666666667

			if var_251_54 < arg_248_1.time_ and arg_248_1.time_ <= var_251_54 + arg_251_0 then
				local var_251_55 = arg_248_1.fswbg_.transform:Find("textbox/adapt/content") or arg_248_1.fswbg_.transform:Find("textbox/content")
				local var_251_56 = arg_248_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_251_57 = var_251_55:GetComponent("Text")
				local var_251_58 = var_251_55:GetComponent("RectTransform")

				var_251_57.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_251_58.offsetMin = Vector2.New(0, 0)
				var_251_58.offsetMax = Vector2.New(0, 0)
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
			local var_255_0 = 1

			if var_255_0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_0 + arg_255_0 then
				local var_255_1 = manager.ui.mainCamera.transform.localPosition
				local var_255_2 = Vector3.New(0, 0, 10) + Vector3.New(var_255_1.x, var_255_1.y, 0)
				local var_255_3 = arg_252_1.bgs_.Z03f

				var_255_3.transform.localPosition = var_255_2
				var_255_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_255_4 = var_255_3:GetComponent("SpriteRenderer")

				if var_255_4 and var_255_4.sprite then
					local var_255_5 = (var_255_3.transform.localPosition - var_255_1).z
					local var_255_6 = manager.ui.mainCameraCom_
					local var_255_7 = 2 * var_255_5 * Mathf.Tan(var_255_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_255_8 = var_255_7 * var_255_6.aspect
					local var_255_9 = var_255_4.sprite.bounds.size.x
					local var_255_10 = var_255_4.sprite.bounds.size.y
					local var_255_11 = var_255_8 / var_255_9
					local var_255_12 = var_255_7 / var_255_10
					local var_255_13 = var_255_12 < var_255_11 and var_255_11 or var_255_12

					var_255_3.transform.localScale = Vector3.New(var_255_13, var_255_13, 0)
				end

				for iter_255_0, iter_255_1 in pairs(arg_252_1.bgs_) do
					if iter_255_0 ~= "Z03f" then
						iter_255_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_255_14 = 0

			if var_255_14 < arg_252_1.time_ and arg_252_1.time_ <= var_255_14 + arg_255_0 then
				arg_252_1.allBtn_.enabled = false
			end

			local var_255_15 = 0.3

			if arg_252_1.time_ >= var_255_14 + var_255_15 and arg_252_1.time_ < var_255_14 + var_255_15 + arg_255_0 then
				arg_252_1.allBtn_.enabled = true
			end

			local var_255_16 = 0

			if var_255_16 < arg_252_1.time_ and arg_252_1.time_ <= var_255_16 + arg_255_0 then
				arg_252_1.mask_.enabled = true
				arg_252_1.mask_.raycastTarget = true

				arg_252_1:SetGaussion(false)
			end

			local var_255_17 = 1

			if var_255_16 <= arg_252_1.time_ and arg_252_1.time_ < var_255_16 + var_255_17 then
				local var_255_18 = (arg_252_1.time_ - var_255_16) / var_255_17
				local var_255_19 = Color.New(0, 0, 0)

				var_255_19.a = Mathf.Lerp(0, 1, var_255_18)
				arg_252_1.mask_.color = var_255_19
			end

			if arg_252_1.time_ >= var_255_16 + var_255_17 and arg_252_1.time_ < var_255_16 + var_255_17 + arg_255_0 then
				local var_255_20 = Color.New(0, 0, 0)

				var_255_20.a = 1
				arg_252_1.mask_.color = var_255_20
			end

			local var_255_21 = 1

			if var_255_21 < arg_252_1.time_ and arg_252_1.time_ <= var_255_21 + arg_255_0 then
				arg_252_1.mask_.enabled = true
				arg_252_1.mask_.raycastTarget = true

				arg_252_1:SetGaussion(false)
			end

			local var_255_22 = 2

			if var_255_21 <= arg_252_1.time_ and arg_252_1.time_ < var_255_21 + var_255_22 then
				local var_255_23 = (arg_252_1.time_ - var_255_21) / var_255_22
				local var_255_24 = Color.New(0, 0, 0)

				var_255_24.a = Mathf.Lerp(1, 0, var_255_23)
				arg_252_1.mask_.color = var_255_24
			end

			if arg_252_1.time_ >= var_255_21 + var_255_22 and arg_252_1.time_ < var_255_21 + var_255_22 + arg_255_0 then
				local var_255_25 = Color.New(0, 0, 0)
				local var_255_26 = 0

				arg_252_1.mask_.enabled = false
				var_255_25.a = var_255_26
				arg_252_1.mask_.color = var_255_25
			end

			local var_255_27 = arg_252_1.actors_["10079ui_story"].transform
			local var_255_28 = 3

			if var_255_28 < arg_252_1.time_ and arg_252_1.time_ <= var_255_28 + arg_255_0 then
				arg_252_1.var_.moveOldPos10079ui_story = var_255_27.localPosition
			end

			local var_255_29 = 0.001

			if var_255_28 <= arg_252_1.time_ and arg_252_1.time_ < var_255_28 + var_255_29 then
				local var_255_30 = (arg_252_1.time_ - var_255_28) / var_255_29
				local var_255_31 = Vector3.New(0, -0.95, -6.05)

				var_255_27.localPosition = Vector3.Lerp(arg_252_1.var_.moveOldPos10079ui_story, var_255_31, var_255_30)

				local var_255_32 = manager.ui.mainCamera.transform.position - var_255_27.position

				var_255_27.forward = Vector3.New(var_255_32.x, var_255_32.y, var_255_32.z)

				local var_255_33 = var_255_27.localEulerAngles

				var_255_33.z = 0
				var_255_33.x = 0
				var_255_27.localEulerAngles = var_255_33
			end

			if arg_252_1.time_ >= var_255_28 + var_255_29 and arg_252_1.time_ < var_255_28 + var_255_29 + arg_255_0 then
				var_255_27.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_255_34 = manager.ui.mainCamera.transform.position - var_255_27.position

				var_255_27.forward = Vector3.New(var_255_34.x, var_255_34.y, var_255_34.z)

				local var_255_35 = var_255_27.localEulerAngles

				var_255_35.z = 0
				var_255_35.x = 0
				var_255_27.localEulerAngles = var_255_35
			end

			local var_255_36 = arg_252_1.actors_["10079ui_story"]
			local var_255_37 = 3

			if var_255_37 < arg_252_1.time_ and arg_252_1.time_ <= var_255_37 + arg_255_0 and not isNil(var_255_36) and arg_252_1.var_.characterEffect10079ui_story == nil then
				arg_252_1.var_.characterEffect10079ui_story = var_255_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_255_38 = 0.200000002980232

			if var_255_37 <= arg_252_1.time_ and arg_252_1.time_ < var_255_37 + var_255_38 and not isNil(var_255_36) then
				local var_255_39 = (arg_252_1.time_ - var_255_37) / var_255_38

				if arg_252_1.var_.characterEffect10079ui_story and not isNil(var_255_36) then
					arg_252_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_252_1.time_ >= var_255_37 + var_255_38 and arg_252_1.time_ < var_255_37 + var_255_38 + arg_255_0 and not isNil(var_255_36) and arg_252_1.var_.characterEffect10079ui_story then
				arg_252_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_255_40 = 3

			if var_255_40 < arg_252_1.time_ and arg_252_1.time_ <= var_255_40 + arg_255_0 then
				arg_252_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_255_41 = 1

			if var_255_41 < arg_252_1.time_ and arg_252_1.time_ <= var_255_41 + arg_255_0 then
				arg_252_1.fswbg_:SetActive(false)
				arg_252_1.dialog_:SetActive(false)
				SetActive(arg_252_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_252_1:ShowNextGo(false)
			end

			local var_255_42 = 1.033

			if var_255_42 < arg_252_1.time_ and arg_252_1.time_ <= var_255_42 + arg_255_0 then
				arg_252_1.fswbg_:SetActive(false)
				arg_252_1.dialog_:SetActive(false)
				SetActive(arg_252_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_252_1:ShowNextGo(false)
			end

			if arg_252_1.frameCnt_ <= 1 then
				arg_252_1.dialog_:SetActive(false)
			end

			local var_255_43 = 3.20000000298023
			local var_255_44 = 0.2

			if var_255_43 < arg_252_1.time_ and arg_252_1.time_ <= var_255_43 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0

				arg_252_1.dialog_:SetActive(true)

				arg_252_1.dialogCg_.alpha = 0

				local var_255_45 = LeanTween.value(arg_252_1.dialog_, 0, 1, 0.3)

				var_255_45:setOnUpdate(LuaHelper.FloatAction(function(arg_256_0)
					arg_252_1.dialogCg_.alpha = arg_256_0
				end))
				var_255_45:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_252_1.dialog_)
					var_255_45:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_252_1.duration_ = arg_252_1.duration_ + 0.3

				SetActive(arg_252_1.leftNameGo_, true)

				local var_255_46 = arg_252_1:FormatText(StoryNameCfg[6].name)

				arg_252_1.leftNameTxt_.text = var_255_46

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_47 = arg_252_1:GetWordFromCfg(319631061)
				local var_255_48 = arg_252_1:FormatText(var_255_47.content)

				arg_252_1.text_.text = var_255_48

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_49 = 8
				local var_255_50 = utf8.len(var_255_48)
				local var_255_51 = var_255_49 <= 0 and var_255_44 or var_255_44 * (var_255_50 / var_255_49)

				if var_255_51 > 0 and var_255_44 < var_255_51 then
					arg_252_1.talkMaxDuration = var_255_51
					var_255_43 = var_255_43 + 0.3

					if var_255_51 + var_255_43 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_51 + var_255_43
					end
				end

				arg_252_1.text_.text = var_255_48
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631061", "story_v_out_319631.awb") ~= 0 then
					local var_255_52 = manager.audio:GetVoiceLength("story_v_out_319631", "319631061", "story_v_out_319631.awb") / 1000

					if var_255_52 + var_255_43 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_52 + var_255_43
					end

					if var_255_47.prefab_name ~= "" and arg_252_1.actors_[var_255_47.prefab_name] ~= nil then
						local var_255_53 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_47.prefab_name].transform, "story_v_out_319631", "319631061", "story_v_out_319631.awb")

						arg_252_1:RecordAudio("319631061", var_255_53)
						arg_252_1:RecordAudio("319631061", var_255_53)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_319631", "319631061", "story_v_out_319631.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_319631", "319631061", "story_v_out_319631.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_54 = var_255_43 + 0.3
			local var_255_55 = math.max(var_255_44, arg_252_1.talkMaxDuration)

			if var_255_54 <= arg_252_1.time_ and arg_252_1.time_ < var_255_54 + var_255_55 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_54) / var_255_55

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_54 + var_255_55 and arg_252_1.time_ < var_255_54 + var_255_55 + arg_255_0 then
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
			local var_261_0 = arg_258_1.actors_["4037ui_story"].transform
			local var_261_1 = 0

			if var_261_1 < arg_258_1.time_ and arg_258_1.time_ <= var_261_1 + arg_261_0 then
				arg_258_1.var_.moveOldPos4037ui_story = var_261_0.localPosition
			end

			local var_261_2 = 0.001

			if var_261_1 <= arg_258_1.time_ and arg_258_1.time_ < var_261_1 + var_261_2 then
				local var_261_3 = (arg_258_1.time_ - var_261_1) / var_261_2
				local var_261_4 = Vector3.New(-0.7, -1.12, -6.2)

				var_261_0.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos4037ui_story, var_261_4, var_261_3)

				local var_261_5 = manager.ui.mainCamera.transform.position - var_261_0.position

				var_261_0.forward = Vector3.New(var_261_5.x, var_261_5.y, var_261_5.z)

				local var_261_6 = var_261_0.localEulerAngles

				var_261_6.z = 0
				var_261_6.x = 0
				var_261_0.localEulerAngles = var_261_6
			end

			if arg_258_1.time_ >= var_261_1 + var_261_2 and arg_258_1.time_ < var_261_1 + var_261_2 + arg_261_0 then
				var_261_0.localPosition = Vector3.New(-0.7, -1.12, -6.2)

				local var_261_7 = manager.ui.mainCamera.transform.position - var_261_0.position

				var_261_0.forward = Vector3.New(var_261_7.x, var_261_7.y, var_261_7.z)

				local var_261_8 = var_261_0.localEulerAngles

				var_261_8.z = 0
				var_261_8.x = 0
				var_261_0.localEulerAngles = var_261_8
			end

			local var_261_9 = arg_258_1.actors_["4037ui_story"]
			local var_261_10 = 0

			if var_261_10 < arg_258_1.time_ and arg_258_1.time_ <= var_261_10 + arg_261_0 and not isNil(var_261_9) and arg_258_1.var_.characterEffect4037ui_story == nil then
				arg_258_1.var_.characterEffect4037ui_story = var_261_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_11 = 0.200000002980232

			if var_261_10 <= arg_258_1.time_ and arg_258_1.time_ < var_261_10 + var_261_11 and not isNil(var_261_9) then
				local var_261_12 = (arg_258_1.time_ - var_261_10) / var_261_11

				if arg_258_1.var_.characterEffect4037ui_story and not isNil(var_261_9) then
					arg_258_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_258_1.time_ >= var_261_10 + var_261_11 and arg_258_1.time_ < var_261_10 + var_261_11 + arg_261_0 and not isNil(var_261_9) and arg_258_1.var_.characterEffect4037ui_story then
				arg_258_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_261_13 = arg_258_1.actors_["10079ui_story"].transform
			local var_261_14 = 0

			if var_261_14 < arg_258_1.time_ and arg_258_1.time_ <= var_261_14 + arg_261_0 then
				arg_258_1.var_.moveOldPos10079ui_story = var_261_13.localPosition
			end

			local var_261_15 = 0.001

			if var_261_14 <= arg_258_1.time_ and arg_258_1.time_ < var_261_14 + var_261_15 then
				local var_261_16 = (arg_258_1.time_ - var_261_14) / var_261_15
				local var_261_17 = Vector3.New(0.7, -0.95, -6.05)

				var_261_13.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos10079ui_story, var_261_17, var_261_16)

				local var_261_18 = manager.ui.mainCamera.transform.position - var_261_13.position

				var_261_13.forward = Vector3.New(var_261_18.x, var_261_18.y, var_261_18.z)

				local var_261_19 = var_261_13.localEulerAngles

				var_261_19.z = 0
				var_261_19.x = 0
				var_261_13.localEulerAngles = var_261_19
			end

			if arg_258_1.time_ >= var_261_14 + var_261_15 and arg_258_1.time_ < var_261_14 + var_261_15 + arg_261_0 then
				var_261_13.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_261_20 = manager.ui.mainCamera.transform.position - var_261_13.position

				var_261_13.forward = Vector3.New(var_261_20.x, var_261_20.y, var_261_20.z)

				local var_261_21 = var_261_13.localEulerAngles

				var_261_21.z = 0
				var_261_21.x = 0
				var_261_13.localEulerAngles = var_261_21
			end

			local var_261_22 = arg_258_1.actors_["10079ui_story"]
			local var_261_23 = 0

			if var_261_23 < arg_258_1.time_ and arg_258_1.time_ <= var_261_23 + arg_261_0 and not isNil(var_261_22) and arg_258_1.var_.characterEffect10079ui_story == nil then
				arg_258_1.var_.characterEffect10079ui_story = var_261_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_24 = 0.200000002980232

			if var_261_23 <= arg_258_1.time_ and arg_258_1.time_ < var_261_23 + var_261_24 and not isNil(var_261_22) then
				local var_261_25 = (arg_258_1.time_ - var_261_23) / var_261_24

				if arg_258_1.var_.characterEffect10079ui_story and not isNil(var_261_22) then
					local var_261_26 = Mathf.Lerp(0, 0.5, var_261_25)

					arg_258_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_258_1.var_.characterEffect10079ui_story.fillRatio = var_261_26
				end
			end

			if arg_258_1.time_ >= var_261_23 + var_261_24 and arg_258_1.time_ < var_261_23 + var_261_24 + arg_261_0 and not isNil(var_261_22) and arg_258_1.var_.characterEffect10079ui_story then
				local var_261_27 = 0.5

				arg_258_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_258_1.var_.characterEffect10079ui_story.fillRatio = var_261_27
			end

			local var_261_28 = 0
			local var_261_29 = 0.3

			if var_261_28 < arg_258_1.time_ and arg_258_1.time_ <= var_261_28 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				local var_261_30 = arg_258_1:FormatText(StoryNameCfg[453].name)

				arg_258_1.leftNameTxt_.text = var_261_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_31 = arg_258_1:GetWordFromCfg(319631062)
				local var_261_32 = arg_258_1:FormatText(var_261_31.content)

				arg_258_1.text_.text = var_261_32

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_33 = 12
				local var_261_34 = utf8.len(var_261_32)
				local var_261_35 = var_261_33 <= 0 and var_261_29 or var_261_29 * (var_261_34 / var_261_33)

				if var_261_35 > 0 and var_261_29 < var_261_35 then
					arg_258_1.talkMaxDuration = var_261_35

					if var_261_35 + var_261_28 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_35 + var_261_28
					end
				end

				arg_258_1.text_.text = var_261_32
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631062", "story_v_out_319631.awb") ~= 0 then
					local var_261_36 = manager.audio:GetVoiceLength("story_v_out_319631", "319631062", "story_v_out_319631.awb") / 1000

					if var_261_36 + var_261_28 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_36 + var_261_28
					end

					if var_261_31.prefab_name ~= "" and arg_258_1.actors_[var_261_31.prefab_name] ~= nil then
						local var_261_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_31.prefab_name].transform, "story_v_out_319631", "319631062", "story_v_out_319631.awb")

						arg_258_1:RecordAudio("319631062", var_261_37)
						arg_258_1:RecordAudio("319631062", var_261_37)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_out_319631", "319631062", "story_v_out_319631.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_out_319631", "319631062", "story_v_out_319631.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_38 = math.max(var_261_29, arg_258_1.talkMaxDuration)

			if var_261_28 <= arg_258_1.time_ and arg_258_1.time_ < var_261_28 + var_261_38 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_28) / var_261_38

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_28 + var_261_38 and arg_258_1.time_ < var_261_28 + var_261_38 + arg_261_0 then
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
			local var_265_0 = arg_262_1.actors_["10079ui_story"]
			local var_265_1 = 0

			if var_265_1 < arg_262_1.time_ and arg_262_1.time_ <= var_265_1 + arg_265_0 and not isNil(var_265_0) and arg_262_1.var_.characterEffect10079ui_story == nil then
				arg_262_1.var_.characterEffect10079ui_story = var_265_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_2 = 0.200000002980232

			if var_265_1 <= arg_262_1.time_ and arg_262_1.time_ < var_265_1 + var_265_2 and not isNil(var_265_0) then
				local var_265_3 = (arg_262_1.time_ - var_265_1) / var_265_2

				if arg_262_1.var_.characterEffect10079ui_story and not isNil(var_265_0) then
					arg_262_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_262_1.time_ >= var_265_1 + var_265_2 and arg_262_1.time_ < var_265_1 + var_265_2 + arg_265_0 and not isNil(var_265_0) and arg_262_1.var_.characterEffect10079ui_story then
				arg_262_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_265_4 = arg_262_1.actors_["4037ui_story"]
			local var_265_5 = 0

			if var_265_5 < arg_262_1.time_ and arg_262_1.time_ <= var_265_5 + arg_265_0 and not isNil(var_265_4) and arg_262_1.var_.characterEffect4037ui_story == nil then
				arg_262_1.var_.characterEffect4037ui_story = var_265_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_6 = 0.200000002980232

			if var_265_5 <= arg_262_1.time_ and arg_262_1.time_ < var_265_5 + var_265_6 and not isNil(var_265_4) then
				local var_265_7 = (arg_262_1.time_ - var_265_5) / var_265_6

				if arg_262_1.var_.characterEffect4037ui_story and not isNil(var_265_4) then
					local var_265_8 = Mathf.Lerp(0, 0.5, var_265_7)

					arg_262_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_262_1.var_.characterEffect4037ui_story.fillRatio = var_265_8
				end
			end

			if arg_262_1.time_ >= var_265_5 + var_265_6 and arg_262_1.time_ < var_265_5 + var_265_6 + arg_265_0 and not isNil(var_265_4) and arg_262_1.var_.characterEffect4037ui_story then
				local var_265_9 = 0.5

				arg_262_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_262_1.var_.characterEffect4037ui_story.fillRatio = var_265_9
			end

			local var_265_10 = 0
			local var_265_11 = 0.875

			if var_265_10 < arg_262_1.time_ and arg_262_1.time_ <= var_265_10 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				local var_265_12 = arg_262_1:FormatText(StoryNameCfg[6].name)

				arg_262_1.leftNameTxt_.text = var_265_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_13 = arg_262_1:GetWordFromCfg(319631063)
				local var_265_14 = arg_262_1:FormatText(var_265_13.content)

				arg_262_1.text_.text = var_265_14

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_15 = 35
				local var_265_16 = utf8.len(var_265_14)
				local var_265_17 = var_265_15 <= 0 and var_265_11 or var_265_11 * (var_265_16 / var_265_15)

				if var_265_17 > 0 and var_265_11 < var_265_17 then
					arg_262_1.talkMaxDuration = var_265_17

					if var_265_17 + var_265_10 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_17 + var_265_10
					end
				end

				arg_262_1.text_.text = var_265_14
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631063", "story_v_out_319631.awb") ~= 0 then
					local var_265_18 = manager.audio:GetVoiceLength("story_v_out_319631", "319631063", "story_v_out_319631.awb") / 1000

					if var_265_18 + var_265_10 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_18 + var_265_10
					end

					if var_265_13.prefab_name ~= "" and arg_262_1.actors_[var_265_13.prefab_name] ~= nil then
						local var_265_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_13.prefab_name].transform, "story_v_out_319631", "319631063", "story_v_out_319631.awb")

						arg_262_1:RecordAudio("319631063", var_265_19)
						arg_262_1:RecordAudio("319631063", var_265_19)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_out_319631", "319631063", "story_v_out_319631.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_out_319631", "319631063", "story_v_out_319631.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_20 = math.max(var_265_11, arg_262_1.talkMaxDuration)

			if var_265_10 <= arg_262_1.time_ and arg_262_1.time_ < var_265_10 + var_265_20 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_10) / var_265_20

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_10 + var_265_20 and arg_262_1.time_ < var_265_10 + var_265_20 + arg_265_0 then
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
			local var_269_0 = 0

			if var_269_0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_0 + arg_269_0 then
				arg_266_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			local var_269_1 = 0

			if var_269_1 < arg_266_1.time_ and arg_266_1.time_ <= var_269_1 + arg_269_0 then
				arg_266_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_269_2 = 0
			local var_269_3 = 0.775

			if var_269_2 < arg_266_1.time_ and arg_266_1.time_ <= var_269_2 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				local var_269_4 = arg_266_1:FormatText(StoryNameCfg[6].name)

				arg_266_1.leftNameTxt_.text = var_269_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_5 = arg_266_1:GetWordFromCfg(319631064)
				local var_269_6 = arg_266_1:FormatText(var_269_5.content)

				arg_266_1.text_.text = var_269_6

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_7 = 31
				local var_269_8 = utf8.len(var_269_6)
				local var_269_9 = var_269_7 <= 0 and var_269_3 or var_269_3 * (var_269_8 / var_269_7)

				if var_269_9 > 0 and var_269_3 < var_269_9 then
					arg_266_1.talkMaxDuration = var_269_9

					if var_269_9 + var_269_2 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_9 + var_269_2
					end
				end

				arg_266_1.text_.text = var_269_6
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631064", "story_v_out_319631.awb") ~= 0 then
					local var_269_10 = manager.audio:GetVoiceLength("story_v_out_319631", "319631064", "story_v_out_319631.awb") / 1000

					if var_269_10 + var_269_2 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_10 + var_269_2
					end

					if var_269_5.prefab_name ~= "" and arg_266_1.actors_[var_269_5.prefab_name] ~= nil then
						local var_269_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_5.prefab_name].transform, "story_v_out_319631", "319631064", "story_v_out_319631.awb")

						arg_266_1:RecordAudio("319631064", var_269_11)
						arg_266_1:RecordAudio("319631064", var_269_11)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_out_319631", "319631064", "story_v_out_319631.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_out_319631", "319631064", "story_v_out_319631.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_12 = math.max(var_269_3, arg_266_1.talkMaxDuration)

			if var_269_2 <= arg_266_1.time_ and arg_266_1.time_ < var_269_2 + var_269_12 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_2) / var_269_12

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_2 + var_269_12 and arg_266_1.time_ < var_269_2 + var_269_12 + arg_269_0 then
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
			local var_273_0 = arg_270_1.actors_["4037ui_story"]
			local var_273_1 = 0

			if var_273_1 < arg_270_1.time_ and arg_270_1.time_ <= var_273_1 + arg_273_0 and not isNil(var_273_0) and arg_270_1.var_.characterEffect4037ui_story == nil then
				arg_270_1.var_.characterEffect4037ui_story = var_273_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_2 = 0.200000002980232

			if var_273_1 <= arg_270_1.time_ and arg_270_1.time_ < var_273_1 + var_273_2 and not isNil(var_273_0) then
				local var_273_3 = (arg_270_1.time_ - var_273_1) / var_273_2

				if arg_270_1.var_.characterEffect4037ui_story and not isNil(var_273_0) then
					arg_270_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_270_1.time_ >= var_273_1 + var_273_2 and arg_270_1.time_ < var_273_1 + var_273_2 + arg_273_0 and not isNil(var_273_0) and arg_270_1.var_.characterEffect4037ui_story then
				arg_270_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_273_4 = arg_270_1.actors_["10079ui_story"]
			local var_273_5 = 0

			if var_273_5 < arg_270_1.time_ and arg_270_1.time_ <= var_273_5 + arg_273_0 and not isNil(var_273_4) and arg_270_1.var_.characterEffect10079ui_story == nil then
				arg_270_1.var_.characterEffect10079ui_story = var_273_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_6 = 0.200000002980232

			if var_273_5 <= arg_270_1.time_ and arg_270_1.time_ < var_273_5 + var_273_6 and not isNil(var_273_4) then
				local var_273_7 = (arg_270_1.time_ - var_273_5) / var_273_6

				if arg_270_1.var_.characterEffect10079ui_story and not isNil(var_273_4) then
					local var_273_8 = Mathf.Lerp(0, 0.5, var_273_7)

					arg_270_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_270_1.var_.characterEffect10079ui_story.fillRatio = var_273_8
				end
			end

			if arg_270_1.time_ >= var_273_5 + var_273_6 and arg_270_1.time_ < var_273_5 + var_273_6 + arg_273_0 and not isNil(var_273_4) and arg_270_1.var_.characterEffect10079ui_story then
				local var_273_9 = 0.5

				arg_270_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_270_1.var_.characterEffect10079ui_story.fillRatio = var_273_9
			end

			local var_273_10 = 0
			local var_273_11 = 0.525

			if var_273_10 < arg_270_1.time_ and arg_270_1.time_ <= var_273_10 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				local var_273_12 = arg_270_1:FormatText(StoryNameCfg[453].name)

				arg_270_1.leftNameTxt_.text = var_273_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_13 = arg_270_1:GetWordFromCfg(319631065)
				local var_273_14 = arg_270_1:FormatText(var_273_13.content)

				arg_270_1.text_.text = var_273_14

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_15 = 21
				local var_273_16 = utf8.len(var_273_14)
				local var_273_17 = var_273_15 <= 0 and var_273_11 or var_273_11 * (var_273_16 / var_273_15)

				if var_273_17 > 0 and var_273_11 < var_273_17 then
					arg_270_1.talkMaxDuration = var_273_17

					if var_273_17 + var_273_10 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_17 + var_273_10
					end
				end

				arg_270_1.text_.text = var_273_14
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631065", "story_v_out_319631.awb") ~= 0 then
					local var_273_18 = manager.audio:GetVoiceLength("story_v_out_319631", "319631065", "story_v_out_319631.awb") / 1000

					if var_273_18 + var_273_10 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_18 + var_273_10
					end

					if var_273_13.prefab_name ~= "" and arg_270_1.actors_[var_273_13.prefab_name] ~= nil then
						local var_273_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_13.prefab_name].transform, "story_v_out_319631", "319631065", "story_v_out_319631.awb")

						arg_270_1:RecordAudio("319631065", var_273_19)
						arg_270_1:RecordAudio("319631065", var_273_19)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_out_319631", "319631065", "story_v_out_319631.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_out_319631", "319631065", "story_v_out_319631.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_20 = math.max(var_273_11, arg_270_1.talkMaxDuration)

			if var_273_10 <= arg_270_1.time_ and arg_270_1.time_ < var_273_10 + var_273_20 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_10) / var_273_20

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_10 + var_273_20 and arg_270_1.time_ < var_273_10 + var_273_20 + arg_273_0 then
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
			local var_277_0 = 0

			if var_277_0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_0 + arg_277_0 then
				arg_274_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037actionlink/4037action453")
			end

			local var_277_1 = 0

			if var_277_1 < arg_274_1.time_ and arg_274_1.time_ <= var_277_1 + arg_277_0 then
				arg_274_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_277_2 = 0
			local var_277_3 = 1.075

			if var_277_2 < arg_274_1.time_ and arg_274_1.time_ <= var_277_2 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				local var_277_4 = arg_274_1:FormatText(StoryNameCfg[453].name)

				arg_274_1.leftNameTxt_.text = var_277_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_5 = arg_274_1:GetWordFromCfg(319631066)
				local var_277_6 = arg_274_1:FormatText(var_277_5.content)

				arg_274_1.text_.text = var_277_6

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_7 = 43
				local var_277_8 = utf8.len(var_277_6)
				local var_277_9 = var_277_7 <= 0 and var_277_3 or var_277_3 * (var_277_8 / var_277_7)

				if var_277_9 > 0 and var_277_3 < var_277_9 then
					arg_274_1.talkMaxDuration = var_277_9

					if var_277_9 + var_277_2 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_9 + var_277_2
					end
				end

				arg_274_1.text_.text = var_277_6
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631066", "story_v_out_319631.awb") ~= 0 then
					local var_277_10 = manager.audio:GetVoiceLength("story_v_out_319631", "319631066", "story_v_out_319631.awb") / 1000

					if var_277_10 + var_277_2 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_10 + var_277_2
					end

					if var_277_5.prefab_name ~= "" and arg_274_1.actors_[var_277_5.prefab_name] ~= nil then
						local var_277_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_5.prefab_name].transform, "story_v_out_319631", "319631066", "story_v_out_319631.awb")

						arg_274_1:RecordAudio("319631066", var_277_11)
						arg_274_1:RecordAudio("319631066", var_277_11)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_out_319631", "319631066", "story_v_out_319631.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_out_319631", "319631066", "story_v_out_319631.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_12 = math.max(var_277_3, arg_274_1.talkMaxDuration)

			if var_277_2 <= arg_274_1.time_ and arg_274_1.time_ < var_277_2 + var_277_12 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_2) / var_277_12

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_2 + var_277_12 and arg_274_1.time_ < var_277_2 + var_277_12 + arg_277_0 then
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
			local var_281_0 = arg_278_1.actors_["10079ui_story"]
			local var_281_1 = 0

			if var_281_1 < arg_278_1.time_ and arg_278_1.time_ <= var_281_1 + arg_281_0 and not isNil(var_281_0) and arg_278_1.var_.characterEffect10079ui_story == nil then
				arg_278_1.var_.characterEffect10079ui_story = var_281_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_281_2 = 0.200000002980232

			if var_281_1 <= arg_278_1.time_ and arg_278_1.time_ < var_281_1 + var_281_2 and not isNil(var_281_0) then
				local var_281_3 = (arg_278_1.time_ - var_281_1) / var_281_2

				if arg_278_1.var_.characterEffect10079ui_story and not isNil(var_281_0) then
					arg_278_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_278_1.time_ >= var_281_1 + var_281_2 and arg_278_1.time_ < var_281_1 + var_281_2 + arg_281_0 and not isNil(var_281_0) and arg_278_1.var_.characterEffect10079ui_story then
				arg_278_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_281_4 = 0

			if var_281_4 < arg_278_1.time_ and arg_278_1.time_ <= var_281_4 + arg_281_0 then
				arg_278_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_281_5 = 0

			if var_281_5 < arg_278_1.time_ and arg_278_1.time_ <= var_281_5 + arg_281_0 then
				arg_278_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_281_6 = arg_278_1.actors_["4037ui_story"]
			local var_281_7 = 0

			if var_281_7 < arg_278_1.time_ and arg_278_1.time_ <= var_281_7 + arg_281_0 and not isNil(var_281_6) and arg_278_1.var_.characterEffect4037ui_story == nil then
				arg_278_1.var_.characterEffect4037ui_story = var_281_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_281_8 = 0.200000002980232

			if var_281_7 <= arg_278_1.time_ and arg_278_1.time_ < var_281_7 + var_281_8 and not isNil(var_281_6) then
				local var_281_9 = (arg_278_1.time_ - var_281_7) / var_281_8

				if arg_278_1.var_.characterEffect4037ui_story and not isNil(var_281_6) then
					local var_281_10 = Mathf.Lerp(0, 0.5, var_281_9)

					arg_278_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_278_1.var_.characterEffect4037ui_story.fillRatio = var_281_10
				end
			end

			if arg_278_1.time_ >= var_281_7 + var_281_8 and arg_278_1.time_ < var_281_7 + var_281_8 + arg_281_0 and not isNil(var_281_6) and arg_278_1.var_.characterEffect4037ui_story then
				local var_281_11 = 0.5

				arg_278_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_278_1.var_.characterEffect4037ui_story.fillRatio = var_281_11
			end

			local var_281_12 = 0
			local var_281_13 = 0.425

			if var_281_12 < arg_278_1.time_ and arg_278_1.time_ <= var_281_12 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				local var_281_14 = arg_278_1:FormatText(StoryNameCfg[6].name)

				arg_278_1.leftNameTxt_.text = var_281_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_15 = arg_278_1:GetWordFromCfg(319631067)
				local var_281_16 = arg_278_1:FormatText(var_281_15.content)

				arg_278_1.text_.text = var_281_16

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_17 = 17
				local var_281_18 = utf8.len(var_281_16)
				local var_281_19 = var_281_17 <= 0 and var_281_13 or var_281_13 * (var_281_18 / var_281_17)

				if var_281_19 > 0 and var_281_13 < var_281_19 then
					arg_278_1.talkMaxDuration = var_281_19

					if var_281_19 + var_281_12 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_19 + var_281_12
					end
				end

				arg_278_1.text_.text = var_281_16
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631067", "story_v_out_319631.awb") ~= 0 then
					local var_281_20 = manager.audio:GetVoiceLength("story_v_out_319631", "319631067", "story_v_out_319631.awb") / 1000

					if var_281_20 + var_281_12 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_20 + var_281_12
					end

					if var_281_15.prefab_name ~= "" and arg_278_1.actors_[var_281_15.prefab_name] ~= nil then
						local var_281_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_278_1.actors_[var_281_15.prefab_name].transform, "story_v_out_319631", "319631067", "story_v_out_319631.awb")

						arg_278_1:RecordAudio("319631067", var_281_21)
						arg_278_1:RecordAudio("319631067", var_281_21)
					else
						arg_278_1:AudioAction("play", "voice", "story_v_out_319631", "319631067", "story_v_out_319631.awb")
					end

					arg_278_1:RecordHistoryTalkVoice("story_v_out_319631", "319631067", "story_v_out_319631.awb")
				end

				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_22 = math.max(var_281_13, arg_278_1.talkMaxDuration)

			if var_281_12 <= arg_278_1.time_ and arg_278_1.time_ < var_281_12 + var_281_22 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_12) / var_281_22

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_12 + var_281_22 and arg_278_1.time_ < var_281_12 + var_281_22 + arg_281_0 then
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
			local var_285_0 = arg_282_1.actors_["10079ui_story"].transform
			local var_285_1 = 0

			if var_285_1 < arg_282_1.time_ and arg_282_1.time_ <= var_285_1 + arg_285_0 then
				arg_282_1.var_.moveOldPos10079ui_story = var_285_0.localPosition
			end

			local var_285_2 = 0.001

			if var_285_1 <= arg_282_1.time_ and arg_282_1.time_ < var_285_1 + var_285_2 then
				local var_285_3 = (arg_282_1.time_ - var_285_1) / var_285_2
				local var_285_4 = Vector3.New(0, 100, 0)

				var_285_0.localPosition = Vector3.Lerp(arg_282_1.var_.moveOldPos10079ui_story, var_285_4, var_285_3)

				local var_285_5 = manager.ui.mainCamera.transform.position - var_285_0.position

				var_285_0.forward = Vector3.New(var_285_5.x, var_285_5.y, var_285_5.z)

				local var_285_6 = var_285_0.localEulerAngles

				var_285_6.z = 0
				var_285_6.x = 0
				var_285_0.localEulerAngles = var_285_6
			end

			if arg_282_1.time_ >= var_285_1 + var_285_2 and arg_282_1.time_ < var_285_1 + var_285_2 + arg_285_0 then
				var_285_0.localPosition = Vector3.New(0, 100, 0)

				local var_285_7 = manager.ui.mainCamera.transform.position - var_285_0.position

				var_285_0.forward = Vector3.New(var_285_7.x, var_285_7.y, var_285_7.z)

				local var_285_8 = var_285_0.localEulerAngles

				var_285_8.z = 0
				var_285_8.x = 0
				var_285_0.localEulerAngles = var_285_8
			end

			local var_285_9 = arg_282_1.actors_["10079ui_story"]
			local var_285_10 = 0

			if var_285_10 < arg_282_1.time_ and arg_282_1.time_ <= var_285_10 + arg_285_0 and not isNil(var_285_9) and arg_282_1.var_.characterEffect10079ui_story == nil then
				arg_282_1.var_.characterEffect10079ui_story = var_285_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_285_11 = 0.200000002980232

			if var_285_10 <= arg_282_1.time_ and arg_282_1.time_ < var_285_10 + var_285_11 and not isNil(var_285_9) then
				local var_285_12 = (arg_282_1.time_ - var_285_10) / var_285_11

				if arg_282_1.var_.characterEffect10079ui_story and not isNil(var_285_9) then
					local var_285_13 = Mathf.Lerp(0, 0.5, var_285_12)

					arg_282_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_282_1.var_.characterEffect10079ui_story.fillRatio = var_285_13
				end
			end

			if arg_282_1.time_ >= var_285_10 + var_285_11 and arg_282_1.time_ < var_285_10 + var_285_11 + arg_285_0 and not isNil(var_285_9) and arg_282_1.var_.characterEffect10079ui_story then
				local var_285_14 = 0.5

				arg_282_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_282_1.var_.characterEffect10079ui_story.fillRatio = var_285_14
			end

			local var_285_15 = arg_282_1.actors_["4037ui_story"].transform
			local var_285_16 = 0

			if var_285_16 < arg_282_1.time_ and arg_282_1.time_ <= var_285_16 + arg_285_0 then
				arg_282_1.var_.moveOldPos4037ui_story = var_285_15.localPosition
			end

			local var_285_17 = 0.001

			if var_285_16 <= arg_282_1.time_ and arg_282_1.time_ < var_285_16 + var_285_17 then
				local var_285_18 = (arg_282_1.time_ - var_285_16) / var_285_17
				local var_285_19 = Vector3.New(0, 100, 0)

				var_285_15.localPosition = Vector3.Lerp(arg_282_1.var_.moveOldPos4037ui_story, var_285_19, var_285_18)

				local var_285_20 = manager.ui.mainCamera.transform.position - var_285_15.position

				var_285_15.forward = Vector3.New(var_285_20.x, var_285_20.y, var_285_20.z)

				local var_285_21 = var_285_15.localEulerAngles

				var_285_21.z = 0
				var_285_21.x = 0
				var_285_15.localEulerAngles = var_285_21
			end

			if arg_282_1.time_ >= var_285_16 + var_285_17 and arg_282_1.time_ < var_285_16 + var_285_17 + arg_285_0 then
				var_285_15.localPosition = Vector3.New(0, 100, 0)

				local var_285_22 = manager.ui.mainCamera.transform.position - var_285_15.position

				var_285_15.forward = Vector3.New(var_285_22.x, var_285_22.y, var_285_22.z)

				local var_285_23 = var_285_15.localEulerAngles

				var_285_23.z = 0
				var_285_23.x = 0
				var_285_15.localEulerAngles = var_285_23
			end

			local var_285_24 = 0
			local var_285_25 = 0.95

			if var_285_24 < arg_282_1.time_ and arg_282_1.time_ <= var_285_24 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, false)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_26 = arg_282_1:GetWordFromCfg(319631068)
				local var_285_27 = arg_282_1:FormatText(var_285_26.content)

				arg_282_1.text_.text = var_285_27

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_28 = 38
				local var_285_29 = utf8.len(var_285_27)
				local var_285_30 = var_285_28 <= 0 and var_285_25 or var_285_25 * (var_285_29 / var_285_28)

				if var_285_30 > 0 and var_285_25 < var_285_30 then
					arg_282_1.talkMaxDuration = var_285_30

					if var_285_30 + var_285_24 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_30 + var_285_24
					end
				end

				arg_282_1.text_.text = var_285_27
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)
				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_31 = math.max(var_285_25, arg_282_1.talkMaxDuration)

			if var_285_24 <= arg_282_1.time_ and arg_282_1.time_ < var_285_24 + var_285_31 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_24) / var_285_31

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_24 + var_285_31 and arg_282_1.time_ < var_285_24 + var_285_31 + arg_285_0 then
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
			local var_289_0 = arg_286_1.actors_["4037ui_story"].transform
			local var_289_1 = 0

			if var_289_1 < arg_286_1.time_ and arg_286_1.time_ <= var_289_1 + arg_289_0 then
				arg_286_1.var_.moveOldPos4037ui_story = var_289_0.localPosition
			end

			local var_289_2 = 0.001

			if var_289_1 <= arg_286_1.time_ and arg_286_1.time_ < var_289_1 + var_289_2 then
				local var_289_3 = (arg_286_1.time_ - var_289_1) / var_289_2
				local var_289_4 = Vector3.New(0, -1.12, -6.2)

				var_289_0.localPosition = Vector3.Lerp(arg_286_1.var_.moveOldPos4037ui_story, var_289_4, var_289_3)

				local var_289_5 = manager.ui.mainCamera.transform.position - var_289_0.position

				var_289_0.forward = Vector3.New(var_289_5.x, var_289_5.y, var_289_5.z)

				local var_289_6 = var_289_0.localEulerAngles

				var_289_6.z = 0
				var_289_6.x = 0
				var_289_0.localEulerAngles = var_289_6
			end

			if arg_286_1.time_ >= var_289_1 + var_289_2 and arg_286_1.time_ < var_289_1 + var_289_2 + arg_289_0 then
				var_289_0.localPosition = Vector3.New(0, -1.12, -6.2)

				local var_289_7 = manager.ui.mainCamera.transform.position - var_289_0.position

				var_289_0.forward = Vector3.New(var_289_7.x, var_289_7.y, var_289_7.z)

				local var_289_8 = var_289_0.localEulerAngles

				var_289_8.z = 0
				var_289_8.x = 0
				var_289_0.localEulerAngles = var_289_8
			end

			local var_289_9 = arg_286_1.actors_["4037ui_story"]
			local var_289_10 = 0

			if var_289_10 < arg_286_1.time_ and arg_286_1.time_ <= var_289_10 + arg_289_0 and not isNil(var_289_9) and arg_286_1.var_.characterEffect4037ui_story == nil then
				arg_286_1.var_.characterEffect4037ui_story = var_289_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_289_11 = 0.200000002980232

			if var_289_10 <= arg_286_1.time_ and arg_286_1.time_ < var_289_10 + var_289_11 and not isNil(var_289_9) then
				local var_289_12 = (arg_286_1.time_ - var_289_10) / var_289_11

				if arg_286_1.var_.characterEffect4037ui_story and not isNil(var_289_9) then
					arg_286_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_286_1.time_ >= var_289_10 + var_289_11 and arg_286_1.time_ < var_289_10 + var_289_11 + arg_289_0 and not isNil(var_289_9) and arg_286_1.var_.characterEffect4037ui_story then
				arg_286_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_289_13 = 0

			if var_289_13 < arg_286_1.time_ and arg_286_1.time_ <= var_289_13 + arg_289_0 then
				arg_286_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action3_2")
			end

			local var_289_14 = 0

			if var_289_14 < arg_286_1.time_ and arg_286_1.time_ <= var_289_14 + arg_289_0 then
				arg_286_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_289_15 = 0
			local var_289_16 = 0.8

			if var_289_15 < arg_286_1.time_ and arg_286_1.time_ <= var_289_15 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				local var_289_17 = arg_286_1:FormatText(StoryNameCfg[453].name)

				arg_286_1.leftNameTxt_.text = var_289_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_18 = arg_286_1:GetWordFromCfg(319631069)
				local var_289_19 = arg_286_1:FormatText(var_289_18.content)

				arg_286_1.text_.text = var_289_19

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_20 = 32
				local var_289_21 = utf8.len(var_289_19)
				local var_289_22 = var_289_20 <= 0 and var_289_16 or var_289_16 * (var_289_21 / var_289_20)

				if var_289_22 > 0 and var_289_16 < var_289_22 then
					arg_286_1.talkMaxDuration = var_289_22

					if var_289_22 + var_289_15 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_22 + var_289_15
					end
				end

				arg_286_1.text_.text = var_289_19
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631069", "story_v_out_319631.awb") ~= 0 then
					local var_289_23 = manager.audio:GetVoiceLength("story_v_out_319631", "319631069", "story_v_out_319631.awb") / 1000

					if var_289_23 + var_289_15 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_23 + var_289_15
					end

					if var_289_18.prefab_name ~= "" and arg_286_1.actors_[var_289_18.prefab_name] ~= nil then
						local var_289_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_18.prefab_name].transform, "story_v_out_319631", "319631069", "story_v_out_319631.awb")

						arg_286_1:RecordAudio("319631069", var_289_24)
						arg_286_1:RecordAudio("319631069", var_289_24)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_out_319631", "319631069", "story_v_out_319631.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_out_319631", "319631069", "story_v_out_319631.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_25 = math.max(var_289_16, arg_286_1.talkMaxDuration)

			if var_289_15 <= arg_286_1.time_ and arg_286_1.time_ < var_289_15 + var_289_25 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_15) / var_289_25

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_15 + var_289_25 and arg_286_1.time_ < var_289_15 + var_289_25 + arg_289_0 then
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
			local var_293_0 = 0
			local var_293_1 = 0.95

			if var_293_0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_0 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				local var_293_2 = arg_290_1:FormatText(StoryNameCfg[453].name)

				arg_290_1.leftNameTxt_.text = var_293_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_3 = arg_290_1:GetWordFromCfg(319631070)
				local var_293_4 = arg_290_1:FormatText(var_293_3.content)

				arg_290_1.text_.text = var_293_4

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_5 = 38
				local var_293_6 = utf8.len(var_293_4)
				local var_293_7 = var_293_5 <= 0 and var_293_1 or var_293_1 * (var_293_6 / var_293_5)

				if var_293_7 > 0 and var_293_1 < var_293_7 then
					arg_290_1.talkMaxDuration = var_293_7

					if var_293_7 + var_293_0 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_7 + var_293_0
					end
				end

				arg_290_1.text_.text = var_293_4
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631070", "story_v_out_319631.awb") ~= 0 then
					local var_293_8 = manager.audio:GetVoiceLength("story_v_out_319631", "319631070", "story_v_out_319631.awb") / 1000

					if var_293_8 + var_293_0 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_8 + var_293_0
					end

					if var_293_3.prefab_name ~= "" and arg_290_1.actors_[var_293_3.prefab_name] ~= nil then
						local var_293_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_290_1.actors_[var_293_3.prefab_name].transform, "story_v_out_319631", "319631070", "story_v_out_319631.awb")

						arg_290_1:RecordAudio("319631070", var_293_9)
						arg_290_1:RecordAudio("319631070", var_293_9)
					else
						arg_290_1:AudioAction("play", "voice", "story_v_out_319631", "319631070", "story_v_out_319631.awb")
					end

					arg_290_1:RecordHistoryTalkVoice("story_v_out_319631", "319631070", "story_v_out_319631.awb")
				end

				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_10 = math.max(var_293_1, arg_290_1.talkMaxDuration)

			if var_293_0 <= arg_290_1.time_ and arg_290_1.time_ < var_293_0 + var_293_10 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_0) / var_293_10

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_0 + var_293_10 and arg_290_1.time_ < var_293_0 + var_293_10 + arg_293_0 then
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
			local var_297_0 = 0
			local var_297_1 = 0.75

			if var_297_0 < arg_294_1.time_ and arg_294_1.time_ <= var_297_0 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, true)

				local var_297_2 = arg_294_1:FormatText(StoryNameCfg[453].name)

				arg_294_1.leftNameTxt_.text = var_297_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_3 = arg_294_1:GetWordFromCfg(319631071)
				local var_297_4 = arg_294_1:FormatText(var_297_3.content)

				arg_294_1.text_.text = var_297_4

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_5 = 30
				local var_297_6 = utf8.len(var_297_4)
				local var_297_7 = var_297_5 <= 0 and var_297_1 or var_297_1 * (var_297_6 / var_297_5)

				if var_297_7 > 0 and var_297_1 < var_297_7 then
					arg_294_1.talkMaxDuration = var_297_7

					if var_297_7 + var_297_0 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_7 + var_297_0
					end
				end

				arg_294_1.text_.text = var_297_4
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631071", "story_v_out_319631.awb") ~= 0 then
					local var_297_8 = manager.audio:GetVoiceLength("story_v_out_319631", "319631071", "story_v_out_319631.awb") / 1000

					if var_297_8 + var_297_0 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_8 + var_297_0
					end

					if var_297_3.prefab_name ~= "" and arg_294_1.actors_[var_297_3.prefab_name] ~= nil then
						local var_297_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_294_1.actors_[var_297_3.prefab_name].transform, "story_v_out_319631", "319631071", "story_v_out_319631.awb")

						arg_294_1:RecordAudio("319631071", var_297_9)
						arg_294_1:RecordAudio("319631071", var_297_9)
					else
						arg_294_1:AudioAction("play", "voice", "story_v_out_319631", "319631071", "story_v_out_319631.awb")
					end

					arg_294_1:RecordHistoryTalkVoice("story_v_out_319631", "319631071", "story_v_out_319631.awb")
				end

				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_10 = math.max(var_297_1, arg_294_1.talkMaxDuration)

			if var_297_0 <= arg_294_1.time_ and arg_294_1.time_ < var_297_0 + var_297_10 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_0) / var_297_10

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_0 + var_297_10 and arg_294_1.time_ < var_297_0 + var_297_10 + arg_297_0 then
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
			local var_301_0 = 0

			if var_301_0 < arg_298_1.time_ and arg_298_1.time_ <= var_301_0 + arg_301_0 then
				arg_298_1.mask_.enabled = true
				arg_298_1.mask_.raycastTarget = true

				arg_298_1:SetGaussion(false)
			end

			local var_301_1 = 1

			if var_301_0 <= arg_298_1.time_ and arg_298_1.time_ < var_301_0 + var_301_1 then
				local var_301_2 = (arg_298_1.time_ - var_301_0) / var_301_1
				local var_301_3 = Color.New(0, 0, 0)

				var_301_3.a = Mathf.Lerp(0, 1, var_301_2)
				arg_298_1.mask_.color = var_301_3
			end

			if arg_298_1.time_ >= var_301_0 + var_301_1 and arg_298_1.time_ < var_301_0 + var_301_1 + arg_301_0 then
				local var_301_4 = Color.New(0, 0, 0)

				var_301_4.a = 1
				arg_298_1.mask_.color = var_301_4
			end

			local var_301_5 = 1

			if var_301_5 < arg_298_1.time_ and arg_298_1.time_ <= var_301_5 + arg_301_0 then
				arg_298_1.mask_.enabled = true
				arg_298_1.mask_.raycastTarget = true

				arg_298_1:SetGaussion(false)
			end

			local var_301_6 = 0.1

			if var_301_5 <= arg_298_1.time_ and arg_298_1.time_ < var_301_5 + var_301_6 then
				local var_301_7 = (arg_298_1.time_ - var_301_5) / var_301_6
				local var_301_8 = Color.New(0, 0, 0)

				var_301_8.a = Mathf.Lerp(1, 0, var_301_7)
				arg_298_1.mask_.color = var_301_8
			end

			if arg_298_1.time_ >= var_301_5 + var_301_6 and arg_298_1.time_ < var_301_5 + var_301_6 + arg_301_0 then
				local var_301_9 = Color.New(0, 0, 0)
				local var_301_10 = 0

				arg_298_1.mask_.enabled = false
				var_301_9.a = var_301_10
				arg_298_1.mask_.color = var_301_9
			end

			local var_301_11 = 1

			if var_301_11 < arg_298_1.time_ and arg_298_1.time_ <= var_301_11 + arg_301_0 then
				SetActive(arg_298_1.dialog_, false)
				SetActive(arg_298_1.allBtn_.gameObject, false)
				arg_298_1.hideBtnsController_:SetSelectedIndex(1)
				arg_298_1:StopAllVoice()

				arg_298_1.marker = "mlv06"

				manager.video:Play("SofdecAsset/story/story_1031963.usm", function(arg_302_0)
					arg_298_1:Skip(arg_302_0)
					manager.video:Dispose()
				end, nil, nil, function(arg_303_0)
					if arg_303_0 then
						arg_298_1.state_ = "pause"
					else
						arg_298_1.state_ = "playing"
					end
				end, 1031963)
				manager.video.transform_:SetSiblingIndex(1)
			end

			local var_301_12 = 12.5416666666667

			if var_301_11 <= arg_298_1.time_ and arg_298_1.time_ < var_301_11 + var_301_12 then
				-- block empty
			end

			if arg_298_1.time_ >= var_301_11 + var_301_12 and arg_298_1.time_ < var_301_11 + var_301_12 + arg_301_0 then
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
