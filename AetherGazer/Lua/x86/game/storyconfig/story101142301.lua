return {
	Play114231001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 114231001
		arg_1_1.duration_ = 4.23

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play114231002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0.5

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				arg_1_1.fswbg_:SetActive(true)
				arg_1_1.dialog_:SetActive(false)

				arg_1_1.fswtw_.percent = 0

				local var_4_1 = arg_1_1:GetWordFromCfg(114231001)
				local var_4_2 = arg_1_1:FormatText(var_4_1.content)

				arg_1_1.fswt_.text = var_4_2

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.fswt_)

				arg_1_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_1_1.fswtw_:SetDirty()

				arg_1_1.typewritterCharCountI18N = 0

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_3 = 0.516666666666667

			if var_4_3 < arg_1_1.time_ and arg_1_1.time_ <= var_4_3 + arg_4_0 then
				arg_1_1.var_.oldValueTypewriter = arg_1_1.fswtw_.percent

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_4 = 19
			local var_4_5 = 1.26666666666667
			local var_4_6 = arg_1_1:GetWordFromCfg(114231001)
			local var_4_7 = arg_1_1:FormatText(var_4_6.content)
			local var_4_8, var_4_9 = arg_1_1:GetPercentByPara(var_4_7, 1)

			if var_4_3 < arg_1_1.time_ and arg_1_1.time_ <= var_4_3 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				local var_4_10 = var_4_4 <= 0 and var_4_5 or var_4_5 * ((var_4_9 - arg_1_1.typewritterCharCountI18N) / var_4_4)

				if var_4_10 > 0 and var_4_5 < var_4_10 then
					arg_1_1.talkMaxDuration = var_4_10

					if var_4_10 + var_4_3 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_10 + var_4_3
					end
				end
			end

			local var_4_11 = 1.26666666666667
			local var_4_12 = math.max(var_4_11, arg_1_1.talkMaxDuration)

			if var_4_3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_3 + var_4_12 then
				local var_4_13 = (arg_1_1.time_ - var_4_3) / var_4_12

				arg_1_1.fswtw_.percent = Mathf.Lerp(arg_1_1.var_.oldValueTypewriter, var_4_8, var_4_13)
				arg_1_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_1_1.fswtw_:SetDirty()
			end

			if arg_1_1.time_ >= var_4_3 + var_4_12 and arg_1_1.time_ < var_4_3 + var_4_12 + arg_4_0 then
				arg_1_1.fswtw_.percent = var_4_8

				arg_1_1.fswtw_:SetDirty()
				arg_1_1:ShowNextGo(true)

				arg_1_1.typewritterCharCountI18N = var_4_9
			end

			local var_4_14 = 0

			if var_4_14 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_15 = 2

			if var_4_14 <= arg_1_1.time_ and arg_1_1.time_ < var_4_14 + var_4_15 then
				local var_4_16 = (arg_1_1.time_ - var_4_14) / var_4_15
				local var_4_17 = Color.New(0, 0, 0)

				var_4_17.a = Mathf.Lerp(1, 0, var_4_16)
				arg_1_1.mask_.color = var_4_17
			end

			if arg_1_1.time_ >= var_4_14 + var_4_15 and arg_1_1.time_ < var_4_14 + var_4_15 + arg_4_0 then
				local var_4_18 = Color.New(0, 0, 0)
				local var_4_19 = 0

				arg_1_1.mask_.enabled = false
				var_4_18.a = var_4_19
				arg_1_1.mask_.color = var_4_18
			end

			local var_4_20 = 0
			local var_4_21 = 1

			if var_4_20 < arg_1_1.time_ and arg_1_1.time_ <= var_4_20 + arg_4_0 then
				local var_4_22 = "play"
				local var_4_23 = "music"

				arg_1_1:AudioAction(var_4_22, var_4_23, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_24 = ""
				local var_4_25 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_25 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_25 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_25

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_25
						arg_1_1.bgmTxt2_.text = var_4_25
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

			local var_4_26 = 0.5
			local var_4_27 = 3.572
			local var_4_28 = manager.audio:GetVoiceLength("story_v_out_114231", "114231001", "story_v_out_114231.awb") / 1000

			if var_4_28 > 0 and var_4_27 < var_4_28 and var_4_28 + var_4_26 > arg_1_1.duration_ then
				local var_4_29 = var_4_28

				arg_1_1.duration_ = var_4_28 + var_4_26
			end

			if var_4_26 < arg_1_1.time_ and arg_1_1.time_ <= var_4_26 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "voice"

				arg_1_1:AudioAction(var_4_30, var_4_31, "story_v_out_114231", "114231001", "story_v_out_114231.awb")
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play114231002 = function(arg_6_0, arg_6_1)
		arg_6_1.time_ = 0
		arg_6_1.frameCnt_ = 0
		arg_6_1.state_ = "playing"
		arg_6_1.curTalkId_ = 114231002
		arg_6_1.duration_ = 1.88

		SetActive(arg_6_1.tipsGo_, false)

		function arg_6_1.onSingleLineFinish_()
			arg_6_1.onSingleLineUpdate_ = nil
			arg_6_1.onSingleLineFinish_ = nil
			arg_6_1.state_ = "waiting"
		end

		function arg_6_1.playNext_(arg_8_0)
			if arg_8_0 == 1 then
				arg_6_0:Play114231003(arg_6_1)
			end
		end

		function arg_6_1.onSingleLineUpdate_(arg_9_0)
			local var_9_0 = 0

			if var_9_0 < arg_6_1.time_ and arg_6_1.time_ <= var_9_0 + arg_9_0 then
				arg_6_1.var_.oldValueTypewriter = arg_6_1.fswtw_.percent

				SetActive(arg_6_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_6_1:ShowNextGo(false)
			end

			local var_9_1 = 0
			local var_9_2 = 0
			local var_9_3 = arg_6_1:GetWordFromCfg(114231001)
			local var_9_4 = arg_6_1:FormatText(var_9_3.content)
			local var_9_5, var_9_6 = arg_6_1:GetPercentByPara(var_9_4, 1)

			if var_9_0 < arg_6_1.time_ and arg_6_1.time_ <= var_9_0 + arg_9_0 then
				arg_6_1.talkMaxDuration = 0

				local var_9_7 = var_9_1 <= 0 and var_9_2 or var_9_2 * ((var_9_6 - arg_6_1.typewritterCharCountI18N) / var_9_1)

				if var_9_7 > 0 and var_9_2 < var_9_7 then
					arg_6_1.talkMaxDuration = var_9_7

					if var_9_7 + var_9_0 > arg_6_1.duration_ then
						arg_6_1.duration_ = var_9_7 + var_9_0
					end
				end
			end

			local var_9_8 = 0
			local var_9_9 = math.max(var_9_8, arg_6_1.talkMaxDuration)

			if var_9_0 <= arg_6_1.time_ and arg_6_1.time_ < var_9_0 + var_9_9 then
				local var_9_10 = (arg_6_1.time_ - var_9_0) / var_9_9

				arg_6_1.fswtw_.percent = Mathf.Lerp(arg_6_1.var_.oldValueTypewriter, var_9_5, var_9_10)
				arg_6_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_6_1.fswtw_:SetDirty()
			end

			if arg_6_1.time_ >= var_9_0 + var_9_9 and arg_6_1.time_ < var_9_0 + var_9_9 + arg_9_0 then
				arg_6_1.fswtw_.percent = var_9_5

				arg_6_1.fswtw_:SetDirty()
				arg_6_1:ShowNextGo(true)

				arg_6_1.typewritterCharCountI18N = var_9_6
			end

			local var_9_11 = 0

			if var_9_11 < arg_6_1.time_ and arg_6_1.time_ <= var_9_11 + arg_9_0 then
				arg_6_1.var_.oldValueTypewriter = arg_6_1.fswtw_.percent

				SetActive(arg_6_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_6_1:ShowNextGo(false)
			end

			local var_9_12 = 9
			local var_9_13 = 0.6
			local var_9_14 = arg_6_1:GetWordFromCfg(114231001)
			local var_9_15 = arg_6_1:FormatText(var_9_14.content)
			local var_9_16, var_9_17 = arg_6_1:GetPercentByPara(var_9_15, 2)

			if var_9_11 < arg_6_1.time_ and arg_6_1.time_ <= var_9_11 + arg_9_0 then
				arg_6_1.talkMaxDuration = 0

				local var_9_18 = var_9_12 <= 0 and var_9_13 or var_9_13 * ((var_9_17 - arg_6_1.typewritterCharCountI18N) / var_9_12)

				if var_9_18 > 0 and var_9_13 < var_9_18 then
					arg_6_1.talkMaxDuration = var_9_18

					if var_9_18 + var_9_11 > arg_6_1.duration_ then
						arg_6_1.duration_ = var_9_18 + var_9_11
					end
				end
			end

			local var_9_19 = 0.6
			local var_9_20 = math.max(var_9_19, arg_6_1.talkMaxDuration)

			if var_9_11 <= arg_6_1.time_ and arg_6_1.time_ < var_9_11 + var_9_20 then
				local var_9_21 = (arg_6_1.time_ - var_9_11) / var_9_20

				arg_6_1.fswtw_.percent = Mathf.Lerp(arg_6_1.var_.oldValueTypewriter, var_9_16, var_9_21)
				arg_6_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_6_1.fswtw_:SetDirty()
			end

			if arg_6_1.time_ >= var_9_11 + var_9_20 and arg_6_1.time_ < var_9_11 + var_9_20 + arg_9_0 then
				arg_6_1.fswtw_.percent = var_9_16

				arg_6_1.fswtw_:SetDirty()
				arg_6_1:ShowNextGo(true)

				arg_6_1.typewritterCharCountI18N = var_9_17
			end

			local var_9_22 = 0
			local var_9_23 = 1.878
			local var_9_24 = manager.audio:GetVoiceLength("story_v_out_114231", "114231002", "story_v_out_114231.awb") / 1000

			if var_9_24 > 0 and var_9_23 < var_9_24 and var_9_24 + var_9_22 > arg_6_1.duration_ then
				local var_9_25 = var_9_24

				arg_6_1.duration_ = var_9_24 + var_9_22
			end

			if var_9_22 < arg_6_1.time_ and arg_6_1.time_ <= var_9_22 + arg_9_0 then
				local var_9_26 = "play"
				local var_9_27 = "voice"

				arg_6_1:AudioAction(var_9_26, var_9_27, "story_v_out_114231", "114231002", "story_v_out_114231.awb")
			end
		end

		arg_6_1.nodeConfigList_ = {}

		arg_6_1:InitPlayNodeList()
	end,
	Play114231003 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 114231003
		arg_10_1.duration_ = 3.47

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play114231004(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			local var_13_0 = 0

			if var_13_0 < arg_10_1.time_ and arg_10_1.time_ <= var_13_0 + arg_13_0 then
				arg_10_1.var_.oldValueTypewriter = arg_10_1.fswtw_.percent

				SetActive(arg_10_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_10_1:ShowNextGo(false)
			end

			local var_13_1 = 0
			local var_13_2 = 0
			local var_13_3 = arg_10_1:GetWordFromCfg(114231001)
			local var_13_4 = arg_10_1:FormatText(var_13_3.content)
			local var_13_5, var_13_6 = arg_10_1:GetPercentByPara(var_13_4, 1)

			if var_13_0 < arg_10_1.time_ and arg_10_1.time_ <= var_13_0 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0

				local var_13_7 = var_13_1 <= 0 and var_13_2 or var_13_2 * ((var_13_6 - arg_10_1.typewritterCharCountI18N) / var_13_1)

				if var_13_7 > 0 and var_13_2 < var_13_7 then
					arg_10_1.talkMaxDuration = var_13_7

					if var_13_7 + var_13_0 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_7 + var_13_0
					end
				end
			end

			local var_13_8 = 0
			local var_13_9 = math.max(var_13_8, arg_10_1.talkMaxDuration)

			if var_13_0 <= arg_10_1.time_ and arg_10_1.time_ < var_13_0 + var_13_9 then
				local var_13_10 = (arg_10_1.time_ - var_13_0) / var_13_9

				arg_10_1.fswtw_.percent = Mathf.Lerp(arg_10_1.var_.oldValueTypewriter, var_13_5, var_13_10)
				arg_10_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_10_1.fswtw_:SetDirty()
			end

			if arg_10_1.time_ >= var_13_0 + var_13_9 and arg_10_1.time_ < var_13_0 + var_13_9 + arg_13_0 then
				arg_10_1.fswtw_.percent = var_13_5

				arg_10_1.fswtw_:SetDirty()
				arg_10_1:ShowNextGo(true)

				arg_10_1.typewritterCharCountI18N = var_13_6
			end

			local var_13_11 = 0

			if var_13_11 < arg_10_1.time_ and arg_10_1.time_ <= var_13_11 + arg_13_0 then
				arg_10_1.var_.oldValueTypewriter = arg_10_1.fswtw_.percent

				SetActive(arg_10_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_10_1:ShowNextGo(false)
			end

			local var_13_12 = 52
			local var_13_13 = 3.46666666666667
			local var_13_14 = arg_10_1:GetWordFromCfg(114231001)
			local var_13_15 = arg_10_1:FormatText(var_13_14.content)
			local var_13_16, var_13_17 = arg_10_1:GetPercentByPara(var_13_15, 3)

			if var_13_11 < arg_10_1.time_ and arg_10_1.time_ <= var_13_11 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0

				local var_13_18 = var_13_12 <= 0 and var_13_13 or var_13_13 * ((var_13_17 - arg_10_1.typewritterCharCountI18N) / var_13_12)

				if var_13_18 > 0 and var_13_13 < var_13_18 then
					arg_10_1.talkMaxDuration = var_13_18

					if var_13_18 + var_13_11 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_18 + var_13_11
					end
				end
			end

			local var_13_19 = 3.46666666666667
			local var_13_20 = math.max(var_13_19, arg_10_1.talkMaxDuration)

			if var_13_11 <= arg_10_1.time_ and arg_10_1.time_ < var_13_11 + var_13_20 then
				local var_13_21 = (arg_10_1.time_ - var_13_11) / var_13_20

				arg_10_1.fswtw_.percent = Mathf.Lerp(arg_10_1.var_.oldValueTypewriter, var_13_16, var_13_21)
				arg_10_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_10_1.fswtw_:SetDirty()
			end

			if arg_10_1.time_ >= var_13_11 + var_13_20 and arg_10_1.time_ < var_13_11 + var_13_20 + arg_13_0 then
				arg_10_1.fswtw_.percent = var_13_16

				arg_10_1.fswtw_:SetDirty()
				arg_10_1:ShowNextGo(true)

				arg_10_1.typewritterCharCountI18N = var_13_17
			end
		end

		arg_10_1.nodeConfigList_ = {}

		arg_10_1:InitPlayNodeList()
	end,
	Play114231004 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 114231004
		arg_14_1.duration_ = 19.12

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play114231005(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = 0

			if var_17_0 < arg_14_1.time_ and arg_14_1.time_ <= var_17_0 + arg_17_0 then
				arg_14_1.var_.oldValueTypewriter = arg_14_1.fswtw_.percent

				SetActive(arg_14_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_14_1:ShowNextGo(false)
			end

			local var_17_1 = 0
			local var_17_2 = 0
			local var_17_3 = arg_14_1:GetWordFromCfg(114231001)
			local var_17_4 = arg_14_1:FormatText(var_17_3.content)
			local var_17_5, var_17_6 = arg_14_1:GetPercentByPara(var_17_4, 1)

			if var_17_0 < arg_14_1.time_ and arg_14_1.time_ <= var_17_0 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0

				local var_17_7 = var_17_1 <= 0 and var_17_2 or var_17_2 * ((var_17_6 - arg_14_1.typewritterCharCountI18N) / var_17_1)

				if var_17_7 > 0 and var_17_2 < var_17_7 then
					arg_14_1.talkMaxDuration = var_17_7

					if var_17_7 + var_17_0 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_7 + var_17_0
					end
				end
			end

			local var_17_8 = 0
			local var_17_9 = math.max(var_17_8, arg_14_1.talkMaxDuration)

			if var_17_0 <= arg_14_1.time_ and arg_14_1.time_ < var_17_0 + var_17_9 then
				local var_17_10 = (arg_14_1.time_ - var_17_0) / var_17_9

				arg_14_1.fswtw_.percent = Mathf.Lerp(arg_14_1.var_.oldValueTypewriter, var_17_5, var_17_10)
				arg_14_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_14_1.fswtw_:SetDirty()
			end

			if arg_14_1.time_ >= var_17_0 + var_17_9 and arg_14_1.time_ < var_17_0 + var_17_9 + arg_17_0 then
				arg_14_1.fswtw_.percent = var_17_5

				arg_14_1.fswtw_:SetDirty()
				arg_14_1:ShowNextGo(true)

				arg_14_1.typewritterCharCountI18N = var_17_6
			end

			local var_17_11 = 0

			if var_17_11 < arg_14_1.time_ and arg_14_1.time_ <= var_17_11 + arg_17_0 then
				arg_14_1.var_.oldValueTypewriter = arg_14_1.fswtw_.percent

				SetActive(arg_14_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_14_1:ShowNextGo(false)
			end

			local var_17_12 = 61
			local var_17_13 = 4.06666666666667
			local var_17_14 = arg_14_1:GetWordFromCfg(114231001)
			local var_17_15 = arg_14_1:FormatText(var_17_14.content)
			local var_17_16, var_17_17 = arg_14_1:GetPercentByPara(var_17_15, 4)

			if var_17_11 < arg_14_1.time_ and arg_14_1.time_ <= var_17_11 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0

				local var_17_18 = var_17_12 <= 0 and var_17_13 or var_17_13 * ((var_17_17 - arg_14_1.typewritterCharCountI18N) / var_17_12)

				if var_17_18 > 0 and var_17_13 < var_17_18 then
					arg_14_1.talkMaxDuration = var_17_18

					if var_17_18 + var_17_11 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_18 + var_17_11
					end
				end
			end

			local var_17_19 = 4.06666666666667
			local var_17_20 = math.max(var_17_19, arg_14_1.talkMaxDuration)

			if var_17_11 <= arg_14_1.time_ and arg_14_1.time_ < var_17_11 + var_17_20 then
				local var_17_21 = (arg_14_1.time_ - var_17_11) / var_17_20

				arg_14_1.fswtw_.percent = Mathf.Lerp(arg_14_1.var_.oldValueTypewriter, var_17_16, var_17_21)
				arg_14_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_14_1.fswtw_:SetDirty()
			end

			if arg_14_1.time_ >= var_17_11 + var_17_20 and arg_14_1.time_ < var_17_11 + var_17_20 + arg_17_0 then
				arg_14_1.fswtw_.percent = var_17_16

				arg_14_1.fswtw_:SetDirty()
				arg_14_1:ShowNextGo(true)

				arg_14_1.typewritterCharCountI18N = var_17_17
			end

			local var_17_22 = 0
			local var_17_23 = 19.125
			local var_17_24 = manager.audio:GetVoiceLength("story_v_out_114231", "114231004", "story_v_out_114231.awb") / 1000

			if var_17_24 > 0 and var_17_23 < var_17_24 and var_17_24 + var_17_22 > arg_14_1.duration_ then
				local var_17_25 = var_17_24

				arg_14_1.duration_ = var_17_24 + var_17_22
			end

			if var_17_22 < arg_14_1.time_ and arg_14_1.time_ <= var_17_22 + arg_17_0 then
				local var_17_26 = "play"
				local var_17_27 = "voice"

				arg_14_1:AudioAction(var_17_26, var_17_27, "story_v_out_114231", "114231004", "story_v_out_114231.awb")
			end
		end

		arg_14_1.nodeConfigList_ = {}

		arg_14_1:InitPlayNodeList()
	end,
	Play114231005 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 114231005
		arg_18_1.duration_ = 2.67

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play114231006(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = 0

			if var_21_0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_0 + arg_21_0 then
				arg_18_1.var_.oldValueTypewriter = arg_18_1.fswtw_.percent

				SetActive(arg_18_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_18_1:ShowNextGo(false)
			end

			local var_21_1 = 40
			local var_21_2 = 2.66666666666667
			local var_21_3 = arg_18_1:GetWordFromCfg(114231001)
			local var_21_4 = arg_18_1:FormatText(var_21_3.content)
			local var_21_5, var_21_6 = arg_18_1:GetPercentByPara(var_21_4, 5)

			if var_21_0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_0 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0

				local var_21_7 = var_21_1 <= 0 and var_21_2 or var_21_2 * ((var_21_6 - arg_18_1.typewritterCharCountI18N) / var_21_1)

				if var_21_7 > 0 and var_21_2 < var_21_7 then
					arg_18_1.talkMaxDuration = var_21_7

					if var_21_7 + var_21_0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_7 + var_21_0
					end
				end
			end

			local var_21_8 = 2.66666666666667
			local var_21_9 = math.max(var_21_8, arg_18_1.talkMaxDuration)

			if var_21_0 <= arg_18_1.time_ and arg_18_1.time_ < var_21_0 + var_21_9 then
				local var_21_10 = (arg_18_1.time_ - var_21_0) / var_21_9

				arg_18_1.fswtw_.percent = Mathf.Lerp(arg_18_1.var_.oldValueTypewriter, var_21_5, var_21_10)
				arg_18_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_18_1.fswtw_:SetDirty()
			end

			if arg_18_1.time_ >= var_21_0 + var_21_9 and arg_18_1.time_ < var_21_0 + var_21_9 + arg_21_0 then
				arg_18_1.fswtw_.percent = var_21_5

				arg_18_1.fswtw_:SetDirty()
				arg_18_1:ShowNextGo(true)

				arg_18_1.typewritterCharCountI18N = var_21_6
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play114231006 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 114231006
		arg_22_1.duration_ = 3.46

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play114231007(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = 0

			if var_25_0 < arg_22_1.time_ and arg_22_1.time_ <= var_25_0 + arg_25_0 then
				arg_22_1.var_.oldValueTypewriter = arg_22_1.fswtw_.percent

				SetActive(arg_22_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_22_1:ShowNextGo(false)
			end

			local var_25_1 = 25
			local var_25_2 = 1.66666666666667
			local var_25_3 = arg_22_1:GetWordFromCfg(114231001)
			local var_25_4 = arg_22_1:FormatText(var_25_3.content)
			local var_25_5, var_25_6 = arg_22_1:GetPercentByPara(var_25_4, 6)

			if var_25_0 < arg_22_1.time_ and arg_22_1.time_ <= var_25_0 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0

				local var_25_7 = var_25_1 <= 0 and var_25_2 or var_25_2 * ((var_25_6 - arg_22_1.typewritterCharCountI18N) / var_25_1)

				if var_25_7 > 0 and var_25_2 < var_25_7 then
					arg_22_1.talkMaxDuration = var_25_7

					if var_25_7 + var_25_0 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_7 + var_25_0
					end
				end
			end

			local var_25_8 = 1.66666666666667
			local var_25_9 = math.max(var_25_8, arg_22_1.talkMaxDuration)

			if var_25_0 <= arg_22_1.time_ and arg_22_1.time_ < var_25_0 + var_25_9 then
				local var_25_10 = (arg_22_1.time_ - var_25_0) / var_25_9

				arg_22_1.fswtw_.percent = Mathf.Lerp(arg_22_1.var_.oldValueTypewriter, var_25_5, var_25_10)
				arg_22_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_22_1.fswtw_:SetDirty()
			end

			if arg_22_1.time_ >= var_25_0 + var_25_9 and arg_22_1.time_ < var_25_0 + var_25_9 + arg_25_0 then
				arg_22_1.fswtw_.percent = var_25_5

				arg_22_1.fswtw_:SetDirty()
				arg_22_1:ShowNextGo(true)

				arg_22_1.typewritterCharCountI18N = var_25_6
			end

			local var_25_11 = 0
			local var_25_12 = 3.461
			local var_25_13 = manager.audio:GetVoiceLength("story_v_out_114231", "114231006", "story_v_out_114231.awb") / 1000

			if var_25_13 > 0 and var_25_12 < var_25_13 and var_25_13 + var_25_11 > arg_22_1.duration_ then
				local var_25_14 = var_25_13

				arg_22_1.duration_ = var_25_13 + var_25_11
			end

			if var_25_11 < arg_22_1.time_ and arg_22_1.time_ <= var_25_11 + arg_25_0 then
				local var_25_15 = "play"
				local var_25_16 = "voice"

				arg_22_1:AudioAction(var_25_15, var_25_16, "story_v_out_114231", "114231006", "story_v_out_114231.awb")
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play114231007 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 114231007
		arg_26_1.duration_ = 10.63

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play114231008(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = 0

			if var_29_0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_0 + arg_29_0 then
				arg_26_1.fswbg_:SetActive(true)
				arg_26_1.dialog_:SetActive(false)

				arg_26_1.fswtw_.percent = 0

				local var_29_1 = arg_26_1:GetWordFromCfg(114231007)
				local var_29_2 = arg_26_1:FormatText(var_29_1.content)

				arg_26_1.fswt_.text = var_29_2

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.fswt_)

				arg_26_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_26_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_26_1.fswtw_:SetDirty()

				arg_26_1.typewritterCharCountI18N = 0

				SetActive(arg_26_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_26_1:ShowNextGo(false)
			end

			local var_29_3 = 0.0166666666666667

			if var_29_3 < arg_26_1.time_ and arg_26_1.time_ <= var_29_3 + arg_29_0 then
				arg_26_1.var_.oldValueTypewriter = arg_26_1.fswtw_.percent

				SetActive(arg_26_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_26_1:ShowNextGo(false)
			end

			local var_29_4 = 59
			local var_29_5 = 3.93333333333333
			local var_29_6 = arg_26_1:GetWordFromCfg(114231007)
			local var_29_7 = arg_26_1:FormatText(var_29_6.content)
			local var_29_8, var_29_9 = arg_26_1:GetPercentByPara(var_29_7, 1)

			if var_29_3 < arg_26_1.time_ and arg_26_1.time_ <= var_29_3 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0

				local var_29_10 = var_29_4 <= 0 and var_29_5 or var_29_5 * ((var_29_9 - arg_26_1.typewritterCharCountI18N) / var_29_4)

				if var_29_10 > 0 and var_29_5 < var_29_10 then
					arg_26_1.talkMaxDuration = var_29_10

					if var_29_10 + var_29_3 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_10 + var_29_3
					end
				end
			end

			local var_29_11 = 3.93333333333333
			local var_29_12 = math.max(var_29_11, arg_26_1.talkMaxDuration)

			if var_29_3 <= arg_26_1.time_ and arg_26_1.time_ < var_29_3 + var_29_12 then
				local var_29_13 = (arg_26_1.time_ - var_29_3) / var_29_12

				arg_26_1.fswtw_.percent = Mathf.Lerp(arg_26_1.var_.oldValueTypewriter, var_29_8, var_29_13)
				arg_26_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_26_1.fswtw_:SetDirty()
			end

			if arg_26_1.time_ >= var_29_3 + var_29_12 and arg_26_1.time_ < var_29_3 + var_29_12 + arg_29_0 then
				arg_26_1.fswtw_.percent = var_29_8

				arg_26_1.fswtw_:SetDirty()
				arg_26_1:ShowNextGo(true)

				arg_26_1.typewritterCharCountI18N = var_29_9
			end

			local var_29_14 = 0
			local var_29_15 = 10.626
			local var_29_16 = manager.audio:GetVoiceLength("story_v_out_114231", "114231007", "story_v_out_114231.awb") / 1000

			if var_29_16 > 0 and var_29_15 < var_29_16 and var_29_16 + var_29_14 > arg_26_1.duration_ then
				local var_29_17 = var_29_16

				arg_26_1.duration_ = var_29_16 + var_29_14
			end

			if var_29_14 < arg_26_1.time_ and arg_26_1.time_ <= var_29_14 + arg_29_0 then
				local var_29_18 = "play"
				local var_29_19 = "voice"

				arg_26_1:AudioAction(var_29_18, var_29_19, "story_v_out_114231", "114231007", "story_v_out_114231.awb")
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play114231008 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 114231008
		arg_30_1.duration_ = 1.6

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play114231009(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = 0

			if var_33_0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_0 + arg_33_0 then
				arg_30_1.var_.oldValueTypewriter = arg_30_1.fswtw_.percent

				SetActive(arg_30_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_30_1:ShowNextGo(false)
			end

			local var_33_1 = 24
			local var_33_2 = 1.6
			local var_33_3 = arg_30_1:GetWordFromCfg(114231007)
			local var_33_4 = arg_30_1:FormatText(var_33_3.content)
			local var_33_5, var_33_6 = arg_30_1:GetPercentByPara(var_33_4, 2)

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

			local var_33_8 = 1.6
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
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play114231009 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 114231009
		arg_34_1.duration_ = 2.07

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play114231010(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = 0

			if var_37_0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_0 + arg_37_0 then
				arg_34_1.var_.oldValueTypewriter = arg_34_1.fswtw_.percent

				SetActive(arg_34_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_34_1:ShowNextGo(false)
			end

			local var_37_1 = 31
			local var_37_2 = 2.06666666666667
			local var_37_3 = arg_34_1:GetWordFromCfg(114231007)
			local var_37_4 = arg_34_1:FormatText(var_37_3.content)
			local var_37_5, var_37_6 = arg_34_1:GetPercentByPara(var_37_4, 3)

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

			local var_37_8 = 2.06666666666667
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
			local var_37_12 = 1.878
			local var_37_13 = manager.audio:GetVoiceLength("story_v_out_114231", "114231009", "story_v_out_114231.awb") / 1000

			if var_37_13 > 0 and var_37_12 < var_37_13 and var_37_13 + var_37_11 > arg_34_1.duration_ then
				local var_37_14 = var_37_13

				arg_34_1.duration_ = var_37_13 + var_37_11
			end

			if var_37_11 < arg_34_1.time_ and arg_34_1.time_ <= var_37_11 + arg_37_0 then
				local var_37_15 = "play"
				local var_37_16 = "voice"

				arg_34_1:AudioAction(var_37_15, var_37_16, "story_v_out_114231", "114231009", "story_v_out_114231.awb")
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play114231010 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 114231010
		arg_38_1.duration_ = 2.29

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play114231011(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = 0

			if var_41_0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_0 + arg_41_0 then
				arg_38_1.var_.oldValueTypewriter = arg_38_1.fswtw_.percent

				SetActive(arg_38_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_38_1:ShowNextGo(false)
			end

			local var_41_1 = 13
			local var_41_2 = 0.866666666666667
			local var_41_3 = arg_38_1:GetWordFromCfg(114231007)
			local var_41_4 = arg_38_1:FormatText(var_41_3.content)
			local var_41_5, var_41_6 = arg_38_1:GetPercentByPara(var_41_4, 4)

			if var_41_0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_0 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0

				local var_41_7 = var_41_1 <= 0 and var_41_2 or var_41_2 * ((var_41_6 - arg_38_1.typewritterCharCountI18N) / var_41_1)

				if var_41_7 > 0 and var_41_2 < var_41_7 then
					arg_38_1.talkMaxDuration = var_41_7

					if var_41_7 + var_41_0 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_7 + var_41_0
					end
				end
			end

			local var_41_8 = 0.866666666666667
			local var_41_9 = math.max(var_41_8, arg_38_1.talkMaxDuration)

			if var_41_0 <= arg_38_1.time_ and arg_38_1.time_ < var_41_0 + var_41_9 then
				local var_41_10 = (arg_38_1.time_ - var_41_0) / var_41_9

				arg_38_1.fswtw_.percent = Mathf.Lerp(arg_38_1.var_.oldValueTypewriter, var_41_5, var_41_10)
				arg_38_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_38_1.fswtw_:SetDirty()
			end

			if arg_38_1.time_ >= var_41_0 + var_41_9 and arg_38_1.time_ < var_41_0 + var_41_9 + arg_41_0 then
				arg_38_1.fswtw_.percent = var_41_5

				arg_38_1.fswtw_:SetDirty()
				arg_38_1:ShowNextGo(true)

				arg_38_1.typewritterCharCountI18N = var_41_6
			end

			local var_41_11 = 0
			local var_41_12 = 2.29
			local var_41_13 = manager.audio:GetVoiceLength("story_v_out_114231", "114231010", "story_v_out_114231.awb") / 1000

			if var_41_13 > 0 and var_41_12 < var_41_13 and var_41_13 + var_41_11 > arg_38_1.duration_ then
				local var_41_14 = var_41_13

				arg_38_1.duration_ = var_41_13 + var_41_11
			end

			if var_41_11 < arg_38_1.time_ and arg_38_1.time_ <= var_41_11 + arg_41_0 then
				local var_41_15 = "play"
				local var_41_16 = "voice"

				arg_38_1:AudioAction(var_41_15, var_41_16, "story_v_out_114231", "114231010", "story_v_out_114231.awb")
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play114231011 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 114231011
		arg_42_1.duration_ = 4.07

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play114231012(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = 0

			if var_45_0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_0 + arg_45_0 then
				arg_42_1.var_.oldValueTypewriter = arg_42_1.fswtw_.percent

				SetActive(arg_42_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_42_1:ShowNextGo(false)
			end

			local var_45_1 = 61
			local var_45_2 = 4.06666666666667
			local var_45_3 = arg_42_1:GetWordFromCfg(114231007)
			local var_45_4 = arg_42_1:FormatText(var_45_3.content)
			local var_45_5, var_45_6 = arg_42_1:GetPercentByPara(var_45_4, 5)

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

			local var_45_8 = 4.06666666666667
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
			local var_45_12 = 1.878
			local var_45_13 = manager.audio:GetVoiceLength("story_v_out_114231", "114231011", "story_v_out_114231.awb") / 1000

			if var_45_13 > 0 and var_45_12 < var_45_13 and var_45_13 + var_45_11 > arg_42_1.duration_ then
				local var_45_14 = var_45_13

				arg_42_1.duration_ = var_45_13 + var_45_11
			end

			if var_45_11 < arg_42_1.time_ and arg_42_1.time_ <= var_45_11 + arg_45_0 then
				local var_45_15 = "play"
				local var_45_16 = "voice"

				arg_42_1:AudioAction(var_45_15, var_45_16, "story_v_out_114231", "114231011", "story_v_out_114231.awb")
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play114231012 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 114231012
		arg_46_1.duration_ = 2.46

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play114231013(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = 0

			if var_49_0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_0 + arg_49_0 then
				arg_46_1.var_.oldValueTypewriter = arg_46_1.fswtw_.percent

				SetActive(arg_46_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_46_1:ShowNextGo(false)
			end

			local var_49_1 = 15
			local var_49_2 = 1
			local var_49_3 = arg_46_1:GetWordFromCfg(114231007)
			local var_49_4 = arg_46_1:FormatText(var_49_3.content)
			local var_49_5, var_49_6 = arg_46_1:GetPercentByPara(var_49_4, 6)

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

			local var_49_8 = 1
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
			local var_49_12 = 2.464
			local var_49_13 = manager.audio:GetVoiceLength("story_v_out_114231", "114231012", "story_v_out_114231.awb") / 1000

			if var_49_13 > 0 and var_49_12 < var_49_13 and var_49_13 + var_49_11 > arg_46_1.duration_ then
				local var_49_14 = var_49_13

				arg_46_1.duration_ = var_49_13 + var_49_11
			end

			if var_49_11 < arg_46_1.time_ and arg_46_1.time_ <= var_49_11 + arg_49_0 then
				local var_49_15 = "play"
				local var_49_16 = "voice"

				arg_46_1:AudioAction(var_49_15, var_49_16, "story_v_out_114231", "114231012", "story_v_out_114231.awb")
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play114231013 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 114231013
		arg_50_1.duration_ = 9

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play114231014(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = "F03a"

			if arg_50_1.bgs_[var_53_0] == nil then
				local var_53_1 = Object.Instantiate(arg_50_1.paintGo_)

				var_53_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_53_0)
				var_53_1.name = var_53_0
				var_53_1.transform.parent = arg_50_1.stage_.transform
				var_53_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_50_1.bgs_[var_53_0] = var_53_1
			end

			local var_53_2 = 2

			if var_53_2 < arg_50_1.time_ and arg_50_1.time_ <= var_53_2 + arg_53_0 then
				local var_53_3 = manager.ui.mainCamera.transform.localPosition
				local var_53_4 = Vector3.New(0, 0, 10) + Vector3.New(var_53_3.x, var_53_3.y, 0)
				local var_53_5 = arg_50_1.bgs_.F03a

				var_53_5.transform.localPosition = var_53_4
				var_53_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_53_6 = var_53_5:GetComponent("SpriteRenderer")

				if var_53_6 and var_53_6.sprite then
					local var_53_7 = (var_53_5.transform.localPosition - var_53_3).z
					local var_53_8 = manager.ui.mainCameraCom_
					local var_53_9 = 2 * var_53_7 * Mathf.Tan(var_53_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_53_10 = var_53_9 * var_53_8.aspect
					local var_53_11 = var_53_6.sprite.bounds.size.x
					local var_53_12 = var_53_6.sprite.bounds.size.y
					local var_53_13 = var_53_10 / var_53_11
					local var_53_14 = var_53_9 / var_53_12
					local var_53_15 = var_53_14 < var_53_13 and var_53_13 or var_53_14

					var_53_5.transform.localScale = Vector3.New(var_53_15, var_53_15, 0)
				end

				for iter_53_0, iter_53_1 in pairs(arg_50_1.bgs_) do
					if iter_53_0 ~= "F03a" then
						iter_53_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_53_16 = 0

			if var_53_16 < arg_50_1.time_ and arg_50_1.time_ <= var_53_16 + arg_53_0 then
				arg_50_1.mask_.enabled = true
				arg_50_1.mask_.raycastTarget = true

				arg_50_1:SetGaussion(false)
			end

			local var_53_17 = 2

			if var_53_16 <= arg_50_1.time_ and arg_50_1.time_ < var_53_16 + var_53_17 then
				local var_53_18 = (arg_50_1.time_ - var_53_16) / var_53_17
				local var_53_19 = Color.New(0, 0, 0)

				var_53_19.a = Mathf.Lerp(0, 1, var_53_18)
				arg_50_1.mask_.color = var_53_19
			end

			if arg_50_1.time_ >= var_53_16 + var_53_17 and arg_50_1.time_ < var_53_16 + var_53_17 + arg_53_0 then
				local var_53_20 = Color.New(0, 0, 0)

				var_53_20.a = 1
				arg_50_1.mask_.color = var_53_20
			end

			local var_53_21 = 2

			if var_53_21 < arg_50_1.time_ and arg_50_1.time_ <= var_53_21 + arg_53_0 then
				arg_50_1.mask_.enabled = true
				arg_50_1.mask_.raycastTarget = true

				arg_50_1:SetGaussion(false)
			end

			local var_53_22 = 2

			if var_53_21 <= arg_50_1.time_ and arg_50_1.time_ < var_53_21 + var_53_22 then
				local var_53_23 = (arg_50_1.time_ - var_53_21) / var_53_22
				local var_53_24 = Color.New(0, 0, 0)

				var_53_24.a = Mathf.Lerp(1, 0, var_53_23)
				arg_50_1.mask_.color = var_53_24
			end

			if arg_50_1.time_ >= var_53_21 + var_53_22 and arg_50_1.time_ < var_53_21 + var_53_22 + arg_53_0 then
				local var_53_25 = Color.New(0, 0, 0)
				local var_53_26 = 0

				arg_50_1.mask_.enabled = false
				var_53_25.a = var_53_26
				arg_50_1.mask_.color = var_53_25
			end

			local var_53_27 = 1.98333333333333

			if var_53_27 < arg_50_1.time_ and arg_50_1.time_ <= var_53_27 + arg_53_0 then
				arg_50_1.fswbg_:SetActive(false)
				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_50_1:ShowNextGo(false)
			end

			local var_53_28 = 2.9
			local var_53_29 = 1.33333333333333

			if var_53_28 < arg_50_1.time_ and arg_50_1.time_ <= var_53_28 + arg_53_0 then
				local var_53_30 = "play"
				local var_53_31 = "music"

				arg_50_1:AudioAction(var_53_30, var_53_31, "bgm_activity_1_3_story_indoor", "bgm_activity_1_3_story_indoor", "bgm_activity_1_3_story_indoor.awb")

				local var_53_32 = ""
				local var_53_33 = manager.audio:GetAudioName("bgm_activity_1_3_story_indoor", "bgm_activity_1_3_story_indoor")

				if var_53_33 ~= "" then
					if arg_50_1.bgmTxt_.text ~= var_53_33 and arg_50_1.bgmTxt_.text ~= "" then
						if arg_50_1.bgmTxt2_.text ~= "" then
							arg_50_1.bgmTxt_.text = arg_50_1.bgmTxt2_.text
						end

						arg_50_1.bgmTxt2_.text = var_53_33

						arg_50_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_50_1.bgmTxt_.text = var_53_33
						arg_50_1.bgmTxt2_.text = var_53_33
					end

					if arg_50_1.bgmTimer then
						arg_50_1.bgmTimer:Stop()

						arg_50_1.bgmTimer = nil
					end

					if arg_50_1.settingData.show_music_name == 1 then
						arg_50_1.musicController:SetSelectedState("show")
						arg_50_1.musicAnimator_:Play("open", 0, 0)

						if arg_50_1.settingData.music_time ~= 0 then
							arg_50_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_50_1.settingData.music_time), function()
								if arg_50_1 == nil or isNil(arg_50_1.bgmTxt_) then
									return
								end

								arg_50_1.musicController:SetSelectedState("hide")
								arg_50_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_50_1.frameCnt_ <= 1 then
				arg_50_1.dialog_:SetActive(false)
			end

			local var_53_34 = 4
			local var_53_35 = 0.05

			if var_53_34 < arg_50_1.time_ and arg_50_1.time_ <= var_53_34 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0

				arg_50_1.dialog_:SetActive(true)

				arg_50_1.dialogCg_.alpha = 0

				local var_53_36 = LeanTween.value(arg_50_1.dialog_, 0, 1, 0.3)

				var_53_36:setOnUpdate(LuaHelper.FloatAction(function(arg_55_0)
					arg_50_1.dialogCg_.alpha = arg_55_0
				end))
				var_53_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_50_1.dialog_)
					var_53_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_50_1.duration_ = arg_50_1.duration_ + 0.3

				SetActive(arg_50_1.leftNameGo_, false)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_37 = arg_50_1:GetWordFromCfg(114231013)
				local var_53_38 = arg_50_1:FormatText(var_53_37.content)

				arg_50_1.text_.text = var_53_38

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_39 = 2
				local var_53_40 = utf8.len(var_53_38)
				local var_53_41 = var_53_39 <= 0 and var_53_35 or var_53_35 * (var_53_40 / var_53_39)

				if var_53_41 > 0 and var_53_35 < var_53_41 then
					arg_50_1.talkMaxDuration = var_53_41
					var_53_34 = var_53_34 + 0.3

					if var_53_41 + var_53_34 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_41 + var_53_34
					end
				end

				arg_50_1.text_.text = var_53_38
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)
				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_42 = var_53_34 + 0.3
			local var_53_43 = math.max(var_53_35, arg_50_1.talkMaxDuration)

			if var_53_42 <= arg_50_1.time_ and arg_50_1.time_ < var_53_42 + var_53_43 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_42) / var_53_43

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_42 + var_53_43 and arg_50_1.time_ < var_53_42 + var_53_43 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play114231014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 114231014
		arg_57_1.duration_ = 5.83

		local var_57_0 = {
			ja = 5.833,
			ko = 2.433,
			zh = 4.133,
			en = 2.033
		}
		local var_57_1 = manager.audio:GetLocalizationFlag()

		if var_57_0[var_57_1] ~= nil then
			arg_57_1.duration_ = var_57_0[var_57_1]
		end

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play114231015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = "10015"

			if arg_57_1.actors_[var_60_0] == nil then
				local var_60_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10015")

				if not isNil(var_60_1) then
					local var_60_2 = Object.Instantiate(var_60_1, arg_57_1.canvasGo_.transform)

					var_60_2.transform:SetSiblingIndex(1)

					var_60_2.name = var_60_0
					var_60_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_57_1.actors_[var_60_0] = var_60_2

					local var_60_3 = var_60_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_57_1.isInRecall_ then
						for iter_60_0, iter_60_1 in ipairs(var_60_3) do
							iter_60_1.color = arg_57_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_60_4 = arg_57_1.actors_["10015"].transform
			local var_60_5 = 0

			if var_60_5 < arg_57_1.time_ and arg_57_1.time_ <= var_60_5 + arg_60_0 then
				arg_57_1.var_.moveOldPos10015 = var_60_4.localPosition
				var_60_4.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("10015", 3)

				local var_60_6 = var_60_4.childCount

				for iter_60_2 = 0, var_60_6 - 1 do
					local var_60_7 = var_60_4:GetChild(iter_60_2)

					if var_60_7.name == "split_5" or not string.find(var_60_7.name, "split") then
						var_60_7.gameObject:SetActive(true)
					else
						var_60_7.gameObject:SetActive(false)
					end
				end
			end

			local var_60_8 = 0.001

			if var_60_5 <= arg_57_1.time_ and arg_57_1.time_ < var_60_5 + var_60_8 then
				local var_60_9 = (arg_57_1.time_ - var_60_5) / var_60_8
				local var_60_10 = Vector3.New(0, -350, -180)

				var_60_4.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10015, var_60_10, var_60_9)
			end

			if arg_57_1.time_ >= var_60_5 + var_60_8 and arg_57_1.time_ < var_60_5 + var_60_8 + arg_60_0 then
				var_60_4.localPosition = Vector3.New(0, -350, -180)
			end

			local var_60_11 = arg_57_1.actors_["10015"]
			local var_60_12 = 0

			if var_60_12 < arg_57_1.time_ and arg_57_1.time_ <= var_60_12 + arg_60_0 and not isNil(var_60_11) and arg_57_1.var_.actorSpriteComps10015 == nil then
				arg_57_1.var_.actorSpriteComps10015 = var_60_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_13 = 0.034

			if var_60_12 <= arg_57_1.time_ and arg_57_1.time_ < var_60_12 + var_60_13 and not isNil(var_60_11) then
				local var_60_14 = (arg_57_1.time_ - var_60_12) / var_60_13

				if arg_57_1.var_.actorSpriteComps10015 then
					for iter_60_3, iter_60_4 in pairs(arg_57_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_60_4 then
							if arg_57_1.isInRecall_ then
								local var_60_15 = Mathf.Lerp(iter_60_4.color.r, arg_57_1.hightColor1.r, var_60_14)
								local var_60_16 = Mathf.Lerp(iter_60_4.color.g, arg_57_1.hightColor1.g, var_60_14)
								local var_60_17 = Mathf.Lerp(iter_60_4.color.b, arg_57_1.hightColor1.b, var_60_14)

								iter_60_4.color = Color.New(var_60_15, var_60_16, var_60_17)
							else
								local var_60_18 = Mathf.Lerp(iter_60_4.color.r, 1, var_60_14)

								iter_60_4.color = Color.New(var_60_18, var_60_18, var_60_18)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= var_60_12 + var_60_13 and arg_57_1.time_ < var_60_12 + var_60_13 + arg_60_0 and not isNil(var_60_11) and arg_57_1.var_.actorSpriteComps10015 then
				for iter_60_5, iter_60_6 in pairs(arg_57_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_60_6 then
						if arg_57_1.isInRecall_ then
							iter_60_6.color = arg_57_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_60_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_57_1.var_.actorSpriteComps10015 = nil
			end

			local var_60_19 = arg_57_1.actors_["10015"]
			local var_60_20 = 0

			if var_60_20 < arg_57_1.time_ and arg_57_1.time_ <= var_60_20 + arg_60_0 then
				local var_60_21 = var_60_19:GetComponentInChildren(typeof(CanvasGroup))

				if var_60_21 then
					arg_57_1.var_.alphaOldValue10015 = var_60_21.alpha
					arg_57_1.var_.characterEffect10015 = var_60_21
				end

				arg_57_1.var_.alphaOldValue10015 = 0
			end

			local var_60_22 = 0.5

			if var_60_20 <= arg_57_1.time_ and arg_57_1.time_ < var_60_20 + var_60_22 then
				local var_60_23 = (arg_57_1.time_ - var_60_20) / var_60_22
				local var_60_24 = Mathf.Lerp(arg_57_1.var_.alphaOldValue10015, 1, var_60_23)

				if arg_57_1.var_.characterEffect10015 then
					arg_57_1.var_.characterEffect10015.alpha = var_60_24
				end
			end

			if arg_57_1.time_ >= var_60_20 + var_60_22 and arg_57_1.time_ < var_60_20 + var_60_22 + arg_60_0 and arg_57_1.var_.characterEffect10015 then
				arg_57_1.var_.characterEffect10015.alpha = 1
			end

			local var_60_25 = 0
			local var_60_26 = 0.2

			if var_60_25 < arg_57_1.time_ and arg_57_1.time_ <= var_60_25 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_27 = arg_57_1:FormatText(StoryNameCfg[208].name)

				arg_57_1.leftNameTxt_.text = var_60_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_28 = arg_57_1:GetWordFromCfg(114231014)
				local var_60_29 = arg_57_1:FormatText(var_60_28.content)

				arg_57_1.text_.text = var_60_29

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_30 = 8
				local var_60_31 = utf8.len(var_60_29)
				local var_60_32 = var_60_30 <= 0 and var_60_26 or var_60_26 * (var_60_31 / var_60_30)

				if var_60_32 > 0 and var_60_26 < var_60_32 then
					arg_57_1.talkMaxDuration = var_60_32

					if var_60_32 + var_60_25 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_32 + var_60_25
					end
				end

				arg_57_1.text_.text = var_60_29
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114231", "114231014", "story_v_out_114231.awb") ~= 0 then
					local var_60_33 = manager.audio:GetVoiceLength("story_v_out_114231", "114231014", "story_v_out_114231.awb") / 1000

					if var_60_33 + var_60_25 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_33 + var_60_25
					end

					if var_60_28.prefab_name ~= "" and arg_57_1.actors_[var_60_28.prefab_name] ~= nil then
						local var_60_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_28.prefab_name].transform, "story_v_out_114231", "114231014", "story_v_out_114231.awb")

						arg_57_1:RecordAudio("114231014", var_60_34)
						arg_57_1:RecordAudio("114231014", var_60_34)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_114231", "114231014", "story_v_out_114231.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_114231", "114231014", "story_v_out_114231.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_35 = math.max(var_60_26, arg_57_1.talkMaxDuration)

			if var_60_25 <= arg_57_1.time_ and arg_57_1.time_ < var_60_25 + var_60_35 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_25) / var_60_35

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_25 + var_60_35 and arg_57_1.time_ < var_60_25 + var_60_35 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play114231015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 114231015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play114231016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["10015"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				local var_64_2 = var_64_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_64_2 then
					arg_61_1.var_.alphaOldValue10015 = var_64_2.alpha
					arg_61_1.var_.characterEffect10015 = var_64_2
				end

				arg_61_1.var_.alphaOldValue10015 = 1
			end

			local var_64_3 = 0.5

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_3 then
				local var_64_4 = (arg_61_1.time_ - var_64_1) / var_64_3
				local var_64_5 = Mathf.Lerp(arg_61_1.var_.alphaOldValue10015, 0, var_64_4)

				if arg_61_1.var_.characterEffect10015 then
					arg_61_1.var_.characterEffect10015.alpha = var_64_5
				end
			end

			if arg_61_1.time_ >= var_64_1 + var_64_3 and arg_61_1.time_ < var_64_1 + var_64_3 + arg_64_0 and arg_61_1.var_.characterEffect10015 then
				arg_61_1.var_.characterEffect10015.alpha = 0
			end

			local var_64_6 = 0
			local var_64_7 = 1.1

			if var_64_6 < arg_61_1.time_ and arg_61_1.time_ <= var_64_6 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_8 = arg_61_1:GetWordFromCfg(114231015)
				local var_64_9 = arg_61_1:FormatText(var_64_8.content)

				arg_61_1.text_.text = var_64_9

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_10 = 44
				local var_64_11 = utf8.len(var_64_9)
				local var_64_12 = var_64_10 <= 0 and var_64_7 or var_64_7 * (var_64_11 / var_64_10)

				if var_64_12 > 0 and var_64_7 < var_64_12 then
					arg_61_1.talkMaxDuration = var_64_12

					if var_64_12 + var_64_6 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_12 + var_64_6
					end
				end

				arg_61_1.text_.text = var_64_9
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_13 = math.max(var_64_7, arg_61_1.talkMaxDuration)

			if var_64_6 <= arg_61_1.time_ and arg_61_1.time_ < var_64_6 + var_64_13 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_6) / var_64_13

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_6 + var_64_13 and arg_61_1.time_ < var_64_6 + var_64_13 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play114231016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 114231016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play114231017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0
			local var_68_1 = 0.75

			if var_68_0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_2 = arg_65_1:GetWordFromCfg(114231016)
				local var_68_3 = arg_65_1:FormatText(var_68_2.content)

				arg_65_1.text_.text = var_68_3

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_4 = 30
				local var_68_5 = utf8.len(var_68_3)
				local var_68_6 = var_68_4 <= 0 and var_68_1 or var_68_1 * (var_68_5 / var_68_4)

				if var_68_6 > 0 and var_68_1 < var_68_6 then
					arg_65_1.talkMaxDuration = var_68_6

					if var_68_6 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_6 + var_68_0
					end
				end

				arg_65_1.text_.text = var_68_3
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_7 = math.max(var_68_1, arg_65_1.talkMaxDuration)

			if var_68_0 <= arg_65_1.time_ and arg_65_1.time_ < var_68_0 + var_68_7 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_0) / var_68_7

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_0 + var_68_7 and arg_65_1.time_ < var_68_0 + var_68_7 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play114231017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 114231017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play114231018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0
			local var_72_1 = 0.65

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_2 = arg_69_1:GetWordFromCfg(114231017)
				local var_72_3 = arg_69_1:FormatText(var_72_2.content)

				arg_69_1.text_.text = var_72_3

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_4 = 26
				local var_72_5 = utf8.len(var_72_3)
				local var_72_6 = var_72_4 <= 0 and var_72_1 or var_72_1 * (var_72_5 / var_72_4)

				if var_72_6 > 0 and var_72_1 < var_72_6 then
					arg_69_1.talkMaxDuration = var_72_6

					if var_72_6 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_6 + var_72_0
					end
				end

				arg_69_1.text_.text = var_72_3
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_7 = math.max(var_72_1, arg_69_1.talkMaxDuration)

			if var_72_0 <= arg_69_1.time_ and arg_69_1.time_ < var_72_0 + var_72_7 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_0) / var_72_7

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_0 + var_72_7 and arg_69_1.time_ < var_72_0 + var_72_7 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play114231018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 114231018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play114231019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0
			local var_76_1 = 1.4

			if var_76_0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_2 = arg_73_1:GetWordFromCfg(114231018)
				local var_76_3 = arg_73_1:FormatText(var_76_2.content)

				arg_73_1.text_.text = var_76_3

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_4 = 56
				local var_76_5 = utf8.len(var_76_3)
				local var_76_6 = var_76_4 <= 0 and var_76_1 or var_76_1 * (var_76_5 / var_76_4)

				if var_76_6 > 0 and var_76_1 < var_76_6 then
					arg_73_1.talkMaxDuration = var_76_6

					if var_76_6 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_6 + var_76_0
					end
				end

				arg_73_1.text_.text = var_76_3
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_7 = math.max(var_76_1, arg_73_1.talkMaxDuration)

			if var_76_0 <= arg_73_1.time_ and arg_73_1.time_ < var_76_0 + var_76_7 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_0) / var_76_7

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_0 + var_76_7 and arg_73_1.time_ < var_76_0 + var_76_7 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play114231019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 114231019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play114231020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0
			local var_80_1 = 1.075

			if var_80_0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_2 = arg_77_1:GetWordFromCfg(114231019)
				local var_80_3 = arg_77_1:FormatText(var_80_2.content)

				arg_77_1.text_.text = var_80_3

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_4 = 43
				local var_80_5 = utf8.len(var_80_3)
				local var_80_6 = var_80_4 <= 0 and var_80_1 or var_80_1 * (var_80_5 / var_80_4)

				if var_80_6 > 0 and var_80_1 < var_80_6 then
					arg_77_1.talkMaxDuration = var_80_6

					if var_80_6 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_6 + var_80_0
					end
				end

				arg_77_1.text_.text = var_80_3
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_7 = math.max(var_80_1, arg_77_1.talkMaxDuration)

			if var_80_0 <= arg_77_1.time_ and arg_77_1.time_ < var_80_0 + var_80_7 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_0) / var_80_7

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_0 + var_80_7 and arg_77_1.time_ < var_80_0 + var_80_7 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play114231020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 114231020
		arg_81_1.duration_ = 1.27

		local var_81_0 = {
			ja = 1.133,
			ko = 1,
			zh = 0.999999999999,
			en = 1.266
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
				arg_81_0:Play114231021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0
			local var_84_1 = 0.1

			if var_84_0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_2 = arg_81_1:FormatText(StoryNameCfg[36].name)

				arg_81_1.leftNameTxt_.text = var_84_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_3 = arg_81_1:GetWordFromCfg(114231020)
				local var_84_4 = arg_81_1:FormatText(var_84_3.content)

				arg_81_1.text_.text = var_84_4

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_5 = 4
				local var_84_6 = utf8.len(var_84_4)
				local var_84_7 = var_84_5 <= 0 and var_84_1 or var_84_1 * (var_84_6 / var_84_5)

				if var_84_7 > 0 and var_84_1 < var_84_7 then
					arg_81_1.talkMaxDuration = var_84_7

					if var_84_7 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_7 + var_84_0
					end
				end

				arg_81_1.text_.text = var_84_4
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114231", "114231020", "story_v_out_114231.awb") ~= 0 then
					local var_84_8 = manager.audio:GetVoiceLength("story_v_out_114231", "114231020", "story_v_out_114231.awb") / 1000

					if var_84_8 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_8 + var_84_0
					end

					if var_84_3.prefab_name ~= "" and arg_81_1.actors_[var_84_3.prefab_name] ~= nil then
						local var_84_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_3.prefab_name].transform, "story_v_out_114231", "114231020", "story_v_out_114231.awb")

						arg_81_1:RecordAudio("114231020", var_84_9)
						arg_81_1:RecordAudio("114231020", var_84_9)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_114231", "114231020", "story_v_out_114231.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_114231", "114231020", "story_v_out_114231.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_10 = math.max(var_84_1, arg_81_1.talkMaxDuration)

			if var_84_0 <= arg_81_1.time_ and arg_81_1.time_ < var_84_0 + var_84_10 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_0) / var_84_10

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_0 + var_84_10 and arg_81_1.time_ < var_84_0 + var_84_10 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play114231021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 114231021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play114231022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0
			local var_88_1 = 1.3

			if var_88_0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, false)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_2 = arg_85_1:GetWordFromCfg(114231021)
				local var_88_3 = arg_85_1:FormatText(var_88_2.content)

				arg_85_1.text_.text = var_88_3

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_4 = 52
				local var_88_5 = utf8.len(var_88_3)
				local var_88_6 = var_88_4 <= 0 and var_88_1 or var_88_1 * (var_88_5 / var_88_4)

				if var_88_6 > 0 and var_88_1 < var_88_6 then
					arg_85_1.talkMaxDuration = var_88_6

					if var_88_6 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_6 + var_88_0
					end
				end

				arg_85_1.text_.text = var_88_3
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_7 = math.max(var_88_1, arg_85_1.talkMaxDuration)

			if var_88_0 <= arg_85_1.time_ and arg_85_1.time_ < var_88_0 + var_88_7 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_0) / var_88_7

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_0 + var_88_7 and arg_85_1.time_ < var_88_0 + var_88_7 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play114231022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 114231022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play114231023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0
			local var_92_1 = 0.675

			if var_92_0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_2 = arg_89_1:GetWordFromCfg(114231022)
				local var_92_3 = arg_89_1:FormatText(var_92_2.content)

				arg_89_1.text_.text = var_92_3

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_4 = 27
				local var_92_5 = utf8.len(var_92_3)
				local var_92_6 = var_92_4 <= 0 and var_92_1 or var_92_1 * (var_92_5 / var_92_4)

				if var_92_6 > 0 and var_92_1 < var_92_6 then
					arg_89_1.talkMaxDuration = var_92_6

					if var_92_6 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_6 + var_92_0
					end
				end

				arg_89_1.text_.text = var_92_3
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_7 = math.max(var_92_1, arg_89_1.talkMaxDuration)

			if var_92_0 <= arg_89_1.time_ and arg_89_1.time_ < var_92_0 + var_92_7 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_0) / var_92_7

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_0 + var_92_7 and arg_89_1.time_ < var_92_0 + var_92_7 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play114231023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 114231023
		arg_93_1.duration_ = 7

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play114231024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = "OM0504"

			if arg_93_1.bgs_[var_96_0] == nil then
				local var_96_1 = Object.Instantiate(arg_93_1.paintGo_)

				var_96_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_96_0)
				var_96_1.name = var_96_0
				var_96_1.transform.parent = arg_93_1.stage_.transform
				var_96_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_93_1.bgs_[var_96_0] = var_96_1
			end

			local var_96_2 = 0

			if var_96_2 < arg_93_1.time_ and arg_93_1.time_ <= var_96_2 + arg_96_0 then
				local var_96_3 = manager.ui.mainCamera.transform.localPosition
				local var_96_4 = Vector3.New(0, 0, 10) + Vector3.New(var_96_3.x, var_96_3.y, 0)
				local var_96_5 = arg_93_1.bgs_.OM0504

				var_96_5.transform.localPosition = var_96_4
				var_96_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_96_6 = var_96_5:GetComponent("SpriteRenderer")

				if var_96_6 and var_96_6.sprite then
					local var_96_7 = (var_96_5.transform.localPosition - var_96_3).z
					local var_96_8 = manager.ui.mainCameraCom_
					local var_96_9 = 2 * var_96_7 * Mathf.Tan(var_96_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_96_10 = var_96_9 * var_96_8.aspect
					local var_96_11 = var_96_6.sprite.bounds.size.x
					local var_96_12 = var_96_6.sprite.bounds.size.y
					local var_96_13 = var_96_10 / var_96_11
					local var_96_14 = var_96_9 / var_96_12
					local var_96_15 = var_96_14 < var_96_13 and var_96_13 or var_96_14

					var_96_5.transform.localScale = Vector3.New(var_96_15, var_96_15, 0)
				end

				for iter_96_0, iter_96_1 in pairs(arg_93_1.bgs_) do
					if iter_96_0 ~= "OM0504" then
						iter_96_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_96_16 = 0

			if var_96_16 < arg_93_1.time_ and arg_93_1.time_ <= var_96_16 + arg_96_0 then
				arg_93_1.mask_.enabled = true
				arg_93_1.mask_.raycastTarget = false

				arg_93_1:SetGaussion(false)
			end

			local var_96_17 = 2

			if var_96_16 <= arg_93_1.time_ and arg_93_1.time_ < var_96_16 + var_96_17 then
				local var_96_18 = (arg_93_1.time_ - var_96_16) / var_96_17
				local var_96_19 = Color.New(1, 1, 1)

				var_96_19.a = Mathf.Lerp(1, 0, var_96_18)
				arg_93_1.mask_.color = var_96_19
			end

			if arg_93_1.time_ >= var_96_16 + var_96_17 and arg_93_1.time_ < var_96_16 + var_96_17 + arg_96_0 then
				local var_96_20 = Color.New(1, 1, 1)
				local var_96_21 = 0

				arg_93_1.mask_.enabled = false
				var_96_20.a = var_96_21
				arg_93_1.mask_.color = var_96_20
			end

			local var_96_22 = arg_93_1.bgs_.OM0504.transform
			local var_96_23 = 0

			if var_96_23 < arg_93_1.time_ and arg_93_1.time_ <= var_96_23 + arg_96_0 then
				arg_93_1.var_.moveOldPosOM0504 = var_96_22.localPosition
			end

			local var_96_24 = 0.001

			if var_96_23 <= arg_93_1.time_ and arg_93_1.time_ < var_96_23 + var_96_24 then
				local var_96_25 = (arg_93_1.time_ - var_96_23) / var_96_24
				local var_96_26 = Vector3.New(0, 1, 9.5)

				var_96_22.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPosOM0504, var_96_26, var_96_25)
			end

			if arg_93_1.time_ >= var_96_23 + var_96_24 and arg_93_1.time_ < var_96_23 + var_96_24 + arg_96_0 then
				var_96_22.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_96_27 = arg_93_1.bgs_.OM0504.transform
			local var_96_28 = 0.034

			if var_96_28 < arg_93_1.time_ and arg_93_1.time_ <= var_96_28 + arg_96_0 then
				arg_93_1.var_.moveOldPosOM0504 = var_96_27.localPosition
			end

			local var_96_29 = 2.5

			if var_96_28 <= arg_93_1.time_ and arg_93_1.time_ < var_96_28 + var_96_29 then
				local var_96_30 = (arg_93_1.time_ - var_96_28) / var_96_29
				local var_96_31 = Vector3.New(0, 1, 10)

				var_96_27.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPosOM0504, var_96_31, var_96_30)
			end

			if arg_93_1.time_ >= var_96_28 + var_96_29 and arg_93_1.time_ < var_96_28 + var_96_29 + arg_96_0 then
				var_96_27.localPosition = Vector3.New(0, 1, 10)
			end

			local var_96_32 = 1.999999999999

			if var_96_32 < arg_93_1.time_ and arg_93_1.time_ <= var_96_32 + arg_96_0 then
				arg_93_1.allBtn_.enabled = false
			end

			local var_96_33 = 0.534000000001

			if arg_93_1.time_ >= var_96_32 + var_96_33 and arg_93_1.time_ < var_96_32 + var_96_33 + arg_96_0 then
				arg_93_1.allBtn_.enabled = true
			end

			if arg_93_1.frameCnt_ <= 1 then
				arg_93_1.dialog_:SetActive(false)
			end

			local var_96_34 = 1.999999999999
			local var_96_35 = 0.6

			if var_96_34 < arg_93_1.time_ and arg_93_1.time_ <= var_96_34 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0

				arg_93_1.dialog_:SetActive(true)

				arg_93_1.dialogCg_.alpha = 0

				local var_96_36 = LeanTween.value(arg_93_1.dialog_, 0, 1, 0.3)

				var_96_36:setOnUpdate(LuaHelper.FloatAction(function(arg_97_0)
					arg_93_1.dialogCg_.alpha = arg_97_0
				end))
				var_96_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_93_1.dialog_)
					var_96_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_93_1.duration_ = arg_93_1.duration_ + 0.3

				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_37 = arg_93_1:GetWordFromCfg(114231023)
				local var_96_38 = arg_93_1:FormatText(var_96_37.content)

				arg_93_1.text_.text = var_96_38

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_39 = 24
				local var_96_40 = utf8.len(var_96_38)
				local var_96_41 = var_96_39 <= 0 and var_96_35 or var_96_35 * (var_96_40 / var_96_39)

				if var_96_41 > 0 and var_96_35 < var_96_41 then
					arg_93_1.talkMaxDuration = var_96_41
					var_96_34 = var_96_34 + 0.3

					if var_96_41 + var_96_34 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_41 + var_96_34
					end
				end

				arg_93_1.text_.text = var_96_38
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_42 = var_96_34 + 0.3
			local var_96_43 = math.max(var_96_35, arg_93_1.talkMaxDuration)

			if var_96_42 <= arg_93_1.time_ and arg_93_1.time_ < var_96_42 + var_96_43 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_42) / var_96_43

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_42 + var_96_43 and arg_93_1.time_ < var_96_42 + var_96_43 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "OM0504",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "OM0504",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.5,
				className = "StoryMoveNode",
				startTime = 0.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play114231024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 114231024
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play114231025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0
			local var_102_1 = 0.725

			if var_102_0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, false)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_2 = arg_99_1:GetWordFromCfg(114231024)
				local var_102_3 = arg_99_1:FormatText(var_102_2.content)

				arg_99_1.text_.text = var_102_3

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_4 = 29
				local var_102_5 = utf8.len(var_102_3)
				local var_102_6 = var_102_4 <= 0 and var_102_1 or var_102_1 * (var_102_5 / var_102_4)

				if var_102_6 > 0 and var_102_1 < var_102_6 then
					arg_99_1.talkMaxDuration = var_102_6

					if var_102_6 + var_102_0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_6 + var_102_0
					end
				end

				arg_99_1.text_.text = var_102_3
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_7 = math.max(var_102_1, arg_99_1.talkMaxDuration)

			if var_102_0 <= arg_99_1.time_ and arg_99_1.time_ < var_102_0 + var_102_7 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_0) / var_102_7

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_0 + var_102_7 and arg_99_1.time_ < var_102_0 + var_102_7 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play114231025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 114231025
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play114231026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 0
			local var_106_1 = 1.075

			if var_106_0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_0 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, false)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_2 = arg_103_1:GetWordFromCfg(114231025)
				local var_106_3 = arg_103_1:FormatText(var_106_2.content)

				arg_103_1.text_.text = var_106_3

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_4 = 43
				local var_106_5 = utf8.len(var_106_3)
				local var_106_6 = var_106_4 <= 0 and var_106_1 or var_106_1 * (var_106_5 / var_106_4)

				if var_106_6 > 0 and var_106_1 < var_106_6 then
					arg_103_1.talkMaxDuration = var_106_6

					if var_106_6 + var_106_0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_6 + var_106_0
					end
				end

				arg_103_1.text_.text = var_106_3
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_7 = math.max(var_106_1, arg_103_1.talkMaxDuration)

			if var_106_0 <= arg_103_1.time_ and arg_103_1.time_ < var_106_0 + var_106_7 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_0) / var_106_7

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_0 + var_106_7 and arg_103_1.time_ < var_106_0 + var_106_7 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play114231026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 114231026
		arg_107_1.duration_ = 7

		local var_107_0 = {
			ja = 6.9,
			ko = 7,
			zh = 4.9,
			en = 6.266
		}
		local var_107_1 = manager.audio:GetLocalizationFlag()

		if var_107_0[var_107_1] ~= nil then
			arg_107_1.duration_ = var_107_0[var_107_1]
		end

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play114231027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 0
			local var_110_1 = 0.525

			if var_110_0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_0 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_2 = arg_107_1:FormatText(StoryNameCfg[36].name)

				arg_107_1.leftNameTxt_.text = var_110_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_3 = arg_107_1:GetWordFromCfg(114231026)
				local var_110_4 = arg_107_1:FormatText(var_110_3.content)

				arg_107_1.text_.text = var_110_4

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_5 = 21
				local var_110_6 = utf8.len(var_110_4)
				local var_110_7 = var_110_5 <= 0 and var_110_1 or var_110_1 * (var_110_6 / var_110_5)

				if var_110_7 > 0 and var_110_1 < var_110_7 then
					arg_107_1.talkMaxDuration = var_110_7

					if var_110_7 + var_110_0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_7 + var_110_0
					end
				end

				arg_107_1.text_.text = var_110_4
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114231", "114231026", "story_v_out_114231.awb") ~= 0 then
					local var_110_8 = manager.audio:GetVoiceLength("story_v_out_114231", "114231026", "story_v_out_114231.awb") / 1000

					if var_110_8 + var_110_0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_8 + var_110_0
					end

					if var_110_3.prefab_name ~= "" and arg_107_1.actors_[var_110_3.prefab_name] ~= nil then
						local var_110_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_3.prefab_name].transform, "story_v_out_114231", "114231026", "story_v_out_114231.awb")

						arg_107_1:RecordAudio("114231026", var_110_9)
						arg_107_1:RecordAudio("114231026", var_110_9)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_114231", "114231026", "story_v_out_114231.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_114231", "114231026", "story_v_out_114231.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_10 = math.max(var_110_1, arg_107_1.talkMaxDuration)

			if var_110_0 <= arg_107_1.time_ and arg_107_1.time_ < var_110_0 + var_110_10 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_0) / var_110_10

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_0 + var_110_10 and arg_107_1.time_ < var_110_0 + var_110_10 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play114231027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 114231027
		arg_111_1.duration_ = 4.6

		local var_111_0 = {
			ja = 3.9,
			ko = 4.166,
			zh = 4.6,
			en = 3.8
		}
		local var_111_1 = manager.audio:GetLocalizationFlag()

		if var_111_0[var_111_1] ~= nil then
			arg_111_1.duration_ = var_111_0[var_111_1]
		end

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play114231028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0
			local var_114_1 = 0.425

			if var_114_0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_2 = arg_111_1:FormatText(StoryNameCfg[208].name)

				arg_111_1.leftNameTxt_.text = var_114_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, true)
				arg_111_1.iconController_:SetSelectedState("hero")

				arg_111_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10015")

				arg_111_1.callingController_:SetSelectedState("normal")

				arg_111_1.keyicon_.color = Color.New(1, 1, 1)
				arg_111_1.icon_.color = Color.New(1, 1, 1)

				local var_114_3 = arg_111_1:GetWordFromCfg(114231027)
				local var_114_4 = arg_111_1:FormatText(var_114_3.content)

				arg_111_1.text_.text = var_114_4

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_5 = 17
				local var_114_6 = utf8.len(var_114_4)
				local var_114_7 = var_114_5 <= 0 and var_114_1 or var_114_1 * (var_114_6 / var_114_5)

				if var_114_7 > 0 and var_114_1 < var_114_7 then
					arg_111_1.talkMaxDuration = var_114_7

					if var_114_7 + var_114_0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_7 + var_114_0
					end
				end

				arg_111_1.text_.text = var_114_4
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114231", "114231027", "story_v_out_114231.awb") ~= 0 then
					local var_114_8 = manager.audio:GetVoiceLength("story_v_out_114231", "114231027", "story_v_out_114231.awb") / 1000

					if var_114_8 + var_114_0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_8 + var_114_0
					end

					if var_114_3.prefab_name ~= "" and arg_111_1.actors_[var_114_3.prefab_name] ~= nil then
						local var_114_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_3.prefab_name].transform, "story_v_out_114231", "114231027", "story_v_out_114231.awb")

						arg_111_1:RecordAudio("114231027", var_114_9)
						arg_111_1:RecordAudio("114231027", var_114_9)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_114231", "114231027", "story_v_out_114231.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_114231", "114231027", "story_v_out_114231.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_10 = math.max(var_114_1, arg_111_1.talkMaxDuration)

			if var_114_0 <= arg_111_1.time_ and arg_111_1.time_ < var_114_0 + var_114_10 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_0) / var_114_10

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_0 + var_114_10 and arg_111_1.time_ < var_114_0 + var_114_10 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play114231028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 114231028
		arg_115_1.duration_ = 12.07

		local var_115_0 = {
			ja = 12.066,
			ko = 8.933,
			zh = 8.1,
			en = 9.9
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
				arg_115_0:Play114231029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 0
			local var_118_1 = 0.75

			if var_118_0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_2 = arg_115_1:FormatText(StoryNameCfg[36].name)

				arg_115_1.leftNameTxt_.text = var_118_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_3 = arg_115_1:GetWordFromCfg(114231028)
				local var_118_4 = arg_115_1:FormatText(var_118_3.content)

				arg_115_1.text_.text = var_118_4

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_5 = 30
				local var_118_6 = utf8.len(var_118_4)
				local var_118_7 = var_118_5 <= 0 and var_118_1 or var_118_1 * (var_118_6 / var_118_5)

				if var_118_7 > 0 and var_118_1 < var_118_7 then
					arg_115_1.talkMaxDuration = var_118_7

					if var_118_7 + var_118_0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_7 + var_118_0
					end
				end

				arg_115_1.text_.text = var_118_4
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114231", "114231028", "story_v_out_114231.awb") ~= 0 then
					local var_118_8 = manager.audio:GetVoiceLength("story_v_out_114231", "114231028", "story_v_out_114231.awb") / 1000

					if var_118_8 + var_118_0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_8 + var_118_0
					end

					if var_118_3.prefab_name ~= "" and arg_115_1.actors_[var_118_3.prefab_name] ~= nil then
						local var_118_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_3.prefab_name].transform, "story_v_out_114231", "114231028", "story_v_out_114231.awb")

						arg_115_1:RecordAudio("114231028", var_118_9)
						arg_115_1:RecordAudio("114231028", var_118_9)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_114231", "114231028", "story_v_out_114231.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_114231", "114231028", "story_v_out_114231.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_10 = math.max(var_118_1, arg_115_1.talkMaxDuration)

			if var_118_0 <= arg_115_1.time_ and arg_115_1.time_ < var_118_0 + var_118_10 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_0) / var_118_10

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_0 + var_118_10 and arg_115_1.time_ < var_118_0 + var_118_10 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play114231029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 114231029
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play114231030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 0
			local var_122_1 = 1.125

			if var_122_0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_0 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, false)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_2 = arg_119_1:GetWordFromCfg(114231029)
				local var_122_3 = arg_119_1:FormatText(var_122_2.content)

				arg_119_1.text_.text = var_122_3

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_4 = 45
				local var_122_5 = utf8.len(var_122_3)
				local var_122_6 = var_122_4 <= 0 and var_122_1 or var_122_1 * (var_122_5 / var_122_4)

				if var_122_6 > 0 and var_122_1 < var_122_6 then
					arg_119_1.talkMaxDuration = var_122_6

					if var_122_6 + var_122_0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_6 + var_122_0
					end
				end

				arg_119_1.text_.text = var_122_3
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_7 = math.max(var_122_1, arg_119_1.talkMaxDuration)

			if var_122_0 <= arg_119_1.time_ and arg_119_1.time_ < var_122_0 + var_122_7 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_0) / var_122_7

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_0 + var_122_7 and arg_119_1.time_ < var_122_0 + var_122_7 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play114231030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 114231030
		arg_123_1.duration_ = 4.23

		local var_123_0 = {
			ja = 4.233,
			ko = 3.8,
			zh = 3.7,
			en = 2.5
		}
		local var_123_1 = manager.audio:GetLocalizationFlag()

		if var_123_0[var_123_1] ~= nil then
			arg_123_1.duration_ = var_123_0[var_123_1]
		end

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play114231031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0
			local var_126_1 = 0.425

			if var_126_0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_2 = arg_123_1:FormatText(StoryNameCfg[208].name)

				arg_123_1.leftNameTxt_.text = var_126_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, true)
				arg_123_1.iconController_:SetSelectedState("hero")

				arg_123_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10015")

				arg_123_1.callingController_:SetSelectedState("normal")

				arg_123_1.keyicon_.color = Color.New(1, 1, 1)
				arg_123_1.icon_.color = Color.New(1, 1, 1)

				local var_126_3 = arg_123_1:GetWordFromCfg(114231030)
				local var_126_4 = arg_123_1:FormatText(var_126_3.content)

				arg_123_1.text_.text = var_126_4

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_5 = 17
				local var_126_6 = utf8.len(var_126_4)
				local var_126_7 = var_126_5 <= 0 and var_126_1 or var_126_1 * (var_126_6 / var_126_5)

				if var_126_7 > 0 and var_126_1 < var_126_7 then
					arg_123_1.talkMaxDuration = var_126_7

					if var_126_7 + var_126_0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_7 + var_126_0
					end
				end

				arg_123_1.text_.text = var_126_4
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114231", "114231030", "story_v_out_114231.awb") ~= 0 then
					local var_126_8 = manager.audio:GetVoiceLength("story_v_out_114231", "114231030", "story_v_out_114231.awb") / 1000

					if var_126_8 + var_126_0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_8 + var_126_0
					end

					if var_126_3.prefab_name ~= "" and arg_123_1.actors_[var_126_3.prefab_name] ~= nil then
						local var_126_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_3.prefab_name].transform, "story_v_out_114231", "114231030", "story_v_out_114231.awb")

						arg_123_1:RecordAudio("114231030", var_126_9)
						arg_123_1:RecordAudio("114231030", var_126_9)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_114231", "114231030", "story_v_out_114231.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_114231", "114231030", "story_v_out_114231.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_10 = math.max(var_126_1, arg_123_1.talkMaxDuration)

			if var_126_0 <= arg_123_1.time_ and arg_123_1.time_ < var_126_0 + var_126_10 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_0) / var_126_10

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_0 + var_126_10 and arg_123_1.time_ < var_126_0 + var_126_10 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play114231031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 114231031
		arg_127_1.duration_ = 9.2

		local var_127_0 = {
			ja = 8.965999999998,
			ko = 9.199999999998,
			zh = 8.165999999998,
			en = 7.732999999998
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
				arg_127_0:Play114231032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = "ST25"

			if arg_127_1.bgs_[var_130_0] == nil then
				local var_130_1 = Object.Instantiate(arg_127_1.paintGo_)

				var_130_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_130_0)
				var_130_1.name = var_130_0
				var_130_1.transform.parent = arg_127_1.stage_.transform
				var_130_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_127_1.bgs_[var_130_0] = var_130_1
			end

			local var_130_2 = 1.999999999999

			if var_130_2 < arg_127_1.time_ and arg_127_1.time_ <= var_130_2 + arg_130_0 then
				local var_130_3 = manager.ui.mainCamera.transform.localPosition
				local var_130_4 = Vector3.New(0, 0, 10) + Vector3.New(var_130_3.x, var_130_3.y, 0)
				local var_130_5 = arg_127_1.bgs_.ST25

				var_130_5.transform.localPosition = var_130_4
				var_130_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_130_6 = var_130_5:GetComponent("SpriteRenderer")

				if var_130_6 and var_130_6.sprite then
					local var_130_7 = (var_130_5.transform.localPosition - var_130_3).z
					local var_130_8 = manager.ui.mainCameraCom_
					local var_130_9 = 2 * var_130_7 * Mathf.Tan(var_130_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_130_10 = var_130_9 * var_130_8.aspect
					local var_130_11 = var_130_6.sprite.bounds.size.x
					local var_130_12 = var_130_6.sprite.bounds.size.y
					local var_130_13 = var_130_10 / var_130_11
					local var_130_14 = var_130_9 / var_130_12
					local var_130_15 = var_130_14 < var_130_13 and var_130_13 or var_130_14

					var_130_5.transform.localScale = Vector3.New(var_130_15, var_130_15, 0)
				end

				for iter_130_0, iter_130_1 in pairs(arg_127_1.bgs_) do
					if iter_130_0 ~= "ST25" then
						iter_130_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_130_16 = 0

			if var_130_16 < arg_127_1.time_ and arg_127_1.time_ <= var_130_16 + arg_130_0 then
				arg_127_1.mask_.enabled = true
				arg_127_1.mask_.raycastTarget = true

				arg_127_1:SetGaussion(false)
			end

			local var_130_17 = 2

			if var_130_16 <= arg_127_1.time_ and arg_127_1.time_ < var_130_16 + var_130_17 then
				local var_130_18 = (arg_127_1.time_ - var_130_16) / var_130_17
				local var_130_19 = Color.New(0, 0, 0)

				var_130_19.a = Mathf.Lerp(0, 1, var_130_18)
				arg_127_1.mask_.color = var_130_19
			end

			if arg_127_1.time_ >= var_130_16 + var_130_17 and arg_127_1.time_ < var_130_16 + var_130_17 + arg_130_0 then
				local var_130_20 = Color.New(0, 0, 0)

				var_130_20.a = 1
				arg_127_1.mask_.color = var_130_20
			end

			local var_130_21 = 1.999999999999

			if var_130_21 < arg_127_1.time_ and arg_127_1.time_ <= var_130_21 + arg_130_0 then
				arg_127_1.mask_.enabled = true
				arg_127_1.mask_.raycastTarget = true

				arg_127_1:SetGaussion(false)
			end

			local var_130_22 = 2

			if var_130_21 <= arg_127_1.time_ and arg_127_1.time_ < var_130_21 + var_130_22 then
				local var_130_23 = (arg_127_1.time_ - var_130_21) / var_130_22
				local var_130_24 = Color.New(0, 0, 0)

				var_130_24.a = Mathf.Lerp(1, 0, var_130_23)
				arg_127_1.mask_.color = var_130_24
			end

			if arg_127_1.time_ >= var_130_21 + var_130_22 and arg_127_1.time_ < var_130_21 + var_130_22 + arg_130_0 then
				local var_130_25 = Color.New(0, 0, 0)
				local var_130_26 = 0

				arg_127_1.mask_.enabled = false
				var_130_25.a = var_130_26
				arg_127_1.mask_.color = var_130_25
			end

			local var_130_27 = "10018"

			if arg_127_1.actors_[var_130_27] == nil then
				local var_130_28 = Object.Instantiate(arg_127_1.imageGo_, arg_127_1.canvasGo_.transform)

				var_130_28.transform:SetSiblingIndex(1)

				var_130_28.name = var_130_27

				local var_130_29 = var_130_28:GetComponent(typeof(Image))

				var_130_29.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "10018")

				var_130_29:SetNativeSize()

				var_130_28.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_127_1.actors_[var_130_27] = var_130_28
			end

			local var_130_30 = arg_127_1.actors_["10018"].transform
			local var_130_31 = 3.8

			if var_130_31 < arg_127_1.time_ and arg_127_1.time_ <= var_130_31 + arg_130_0 then
				arg_127_1.var_.moveOldPos10018 = var_130_30.localPosition
				var_130_30.localScale = Vector3.New(1, 1, 1)

				arg_127_1:CheckSpriteTmpPos("10018", 2)
			end

			local var_130_32 = 0.001

			if var_130_31 <= arg_127_1.time_ and arg_127_1.time_ < var_130_31 + var_130_32 then
				local var_130_33 = (arg_127_1.time_ - var_130_31) / var_130_32
				local var_130_34 = Vector3.New(-390, -350, -180)

				var_130_30.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos10018, var_130_34, var_130_33)
			end

			if arg_127_1.time_ >= var_130_31 + var_130_32 and arg_127_1.time_ < var_130_31 + var_130_32 + arg_130_0 then
				var_130_30.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_130_35 = arg_127_1.actors_["10018"]
			local var_130_36 = 3.8

			if var_130_36 < arg_127_1.time_ and arg_127_1.time_ <= var_130_36 + arg_130_0 and not isNil(var_130_35) then
				local var_130_37 = var_130_35:GetComponent("Image")

				if var_130_37 then
					arg_127_1.var_.highlightMatValue10018 = var_130_37
				end
			end

			local var_130_38 = 0.034

			if var_130_36 <= arg_127_1.time_ and arg_127_1.time_ < var_130_36 + var_130_38 and not isNil(var_130_35) then
				local var_130_39 = (arg_127_1.time_ - var_130_36) / var_130_38

				if arg_127_1.var_.highlightMatValue10018 then
					local var_130_40 = Mathf.Lerp(0.5, 1, var_130_39)
					local var_130_41 = arg_127_1.var_.highlightMatValue10018
					local var_130_42 = var_130_41.color

					var_130_42.r = var_130_40
					var_130_42.g = var_130_40
					var_130_42.b = var_130_40
					var_130_41.color = var_130_42
				end
			end

			if arg_127_1.time_ >= var_130_36 + var_130_38 and arg_127_1.time_ < var_130_36 + var_130_38 + arg_130_0 and not isNil(var_130_35) and arg_127_1.var_.highlightMatValue10018 then
				local var_130_43 = 1

				var_130_35.transform:SetSiblingIndex(1)

				local var_130_44 = arg_127_1.var_.highlightMatValue10018
				local var_130_45 = var_130_44.color

				var_130_45.r = var_130_43
				var_130_45.g = var_130_43
				var_130_45.b = var_130_43
				var_130_44.color = var_130_45
			end

			local var_130_46 = arg_127_1.actors_["10018"]
			local var_130_47 = 3.8

			if var_130_47 < arg_127_1.time_ and arg_127_1.time_ <= var_130_47 + arg_130_0 then
				local var_130_48 = var_130_46:GetComponent("Image")

				if var_130_48 then
					arg_127_1.var_.alphaMatValue10018 = var_130_48
					arg_127_1.var_.alphaOldValue10018 = var_130_48.color.a
				end

				arg_127_1.var_.alphaOldValue10018 = 0
			end

			local var_130_49 = 0.5

			if var_130_47 <= arg_127_1.time_ and arg_127_1.time_ < var_130_47 + var_130_49 then
				local var_130_50 = (arg_127_1.time_ - var_130_47) / var_130_49
				local var_130_51 = Mathf.Lerp(arg_127_1.var_.alphaOldValue10018, 1, var_130_50)

				if arg_127_1.var_.alphaMatValue10018 then
					local var_130_52 = arg_127_1.var_.alphaMatValue10018.color

					var_130_52.a = var_130_51
					arg_127_1.var_.alphaMatValue10018.color = var_130_52
				end
			end

			if arg_127_1.time_ >= var_130_47 + var_130_49 and arg_127_1.time_ < var_130_47 + var_130_49 + arg_130_0 and arg_127_1.var_.alphaMatValue10018 then
				local var_130_53 = arg_127_1.var_.alphaMatValue10018
				local var_130_54 = var_130_53.color

				var_130_54.a = 1
				var_130_53.color = var_130_54
			end

			if arg_127_1.frameCnt_ <= 1 then
				arg_127_1.dialog_:SetActive(false)
			end

			local var_130_55 = 3.999999999998
			local var_130_56 = 0.425

			if var_130_55 < arg_127_1.time_ and arg_127_1.time_ <= var_130_55 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0

				arg_127_1.dialog_:SetActive(true)

				arg_127_1.dialogCg_.alpha = 0

				local var_130_57 = LeanTween.value(arg_127_1.dialog_, 0, 1, 0.3)

				var_130_57:setOnUpdate(LuaHelper.FloatAction(function(arg_131_0)
					arg_127_1.dialogCg_.alpha = arg_131_0
				end))
				var_130_57:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_127_1.dialog_)
					var_130_57:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_127_1.duration_ = arg_127_1.duration_ + 0.3

				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_58 = arg_127_1:FormatText(StoryNameCfg[36].name)

				arg_127_1.leftNameTxt_.text = var_130_58

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_59 = arg_127_1:GetWordFromCfg(114231031)
				local var_130_60 = arg_127_1:FormatText(var_130_59.content)

				arg_127_1.text_.text = var_130_60

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_61 = 17
				local var_130_62 = utf8.len(var_130_60)
				local var_130_63 = var_130_61 <= 0 and var_130_56 or var_130_56 * (var_130_62 / var_130_61)

				if var_130_63 > 0 and var_130_56 < var_130_63 then
					arg_127_1.talkMaxDuration = var_130_63
					var_130_55 = var_130_55 + 0.3

					if var_130_63 + var_130_55 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_63 + var_130_55
					end
				end

				arg_127_1.text_.text = var_130_60
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114231", "114231031", "story_v_out_114231.awb") ~= 0 then
					local var_130_64 = manager.audio:GetVoiceLength("story_v_out_114231", "114231031", "story_v_out_114231.awb") / 1000

					if var_130_64 + var_130_55 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_64 + var_130_55
					end

					if var_130_59.prefab_name ~= "" and arg_127_1.actors_[var_130_59.prefab_name] ~= nil then
						local var_130_65 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_59.prefab_name].transform, "story_v_out_114231", "114231031", "story_v_out_114231.awb")

						arg_127_1:RecordAudio("114231031", var_130_65)
						arg_127_1:RecordAudio("114231031", var_130_65)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_114231", "114231031", "story_v_out_114231.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_114231", "114231031", "story_v_out_114231.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_66 = var_130_55 + 0.3
			local var_130_67 = math.max(var_130_56, arg_127_1.talkMaxDuration)

			if var_130_66 <= arg_127_1.time_ and arg_127_1.time_ < var_130_66 + var_130_67 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_66) / var_130_67

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_66 + var_130_67 and arg_127_1.time_ < var_130_66 + var_130_67 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10018",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_127_1:InitPlayNodeList()
	end,
	Play114231032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 114231032
		arg_133_1.duration_ = 13.9

		local var_133_0 = {
			ja = 10.9,
			ko = 11.4,
			zh = 13.166,
			en = 13.9
		}
		local var_133_1 = manager.audio:GetLocalizationFlag()

		if var_133_0[var_133_1] ~= nil then
			arg_133_1.duration_ = var_133_0[var_133_1]
		end

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play114231033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0
			local var_136_1 = 1.4

			if var_136_0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_2 = arg_133_1:FormatText(StoryNameCfg[36].name)

				arg_133_1.leftNameTxt_.text = var_136_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_3 = arg_133_1:GetWordFromCfg(114231032)
				local var_136_4 = arg_133_1:FormatText(var_136_3.content)

				arg_133_1.text_.text = var_136_4

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_5 = 56
				local var_136_6 = utf8.len(var_136_4)
				local var_136_7 = var_136_5 <= 0 and var_136_1 or var_136_1 * (var_136_6 / var_136_5)

				if var_136_7 > 0 and var_136_1 < var_136_7 then
					arg_133_1.talkMaxDuration = var_136_7

					if var_136_7 + var_136_0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_7 + var_136_0
					end
				end

				arg_133_1.text_.text = var_136_4
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114231", "114231032", "story_v_out_114231.awb") ~= 0 then
					local var_136_8 = manager.audio:GetVoiceLength("story_v_out_114231", "114231032", "story_v_out_114231.awb") / 1000

					if var_136_8 + var_136_0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_8 + var_136_0
					end

					if var_136_3.prefab_name ~= "" and arg_133_1.actors_[var_136_3.prefab_name] ~= nil then
						local var_136_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_3.prefab_name].transform, "story_v_out_114231", "114231032", "story_v_out_114231.awb")

						arg_133_1:RecordAudio("114231032", var_136_9)
						arg_133_1:RecordAudio("114231032", var_136_9)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_114231", "114231032", "story_v_out_114231.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_114231", "114231032", "story_v_out_114231.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_10 = math.max(var_136_1, arg_133_1.talkMaxDuration)

			if var_136_0 <= arg_133_1.time_ and arg_133_1.time_ < var_136_0 + var_136_10 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_0) / var_136_10

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_0 + var_136_10 and arg_133_1.time_ < var_136_0 + var_136_10 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play114231033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 114231033
		arg_137_1.duration_ = 1.37

		local var_137_0 = {
			ja = 1,
			ko = 0.999999999999,
			zh = 1.366,
			en = 1.033
		}
		local var_137_1 = manager.audio:GetLocalizationFlag()

		if var_137_0[var_137_1] ~= nil then
			arg_137_1.duration_ = var_137_0[var_137_1]
		end

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play114231034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["10015"].transform
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 then
				arg_137_1.var_.moveOldPos10015 = var_140_0.localPosition
				var_140_0.localScale = Vector3.New(1, 1, 1)

				arg_137_1:CheckSpriteTmpPos("10015", 4)

				local var_140_2 = var_140_0.childCount

				for iter_140_0 = 0, var_140_2 - 1 do
					local var_140_3 = var_140_0:GetChild(iter_140_0)

					if var_140_3.name == "split_5" or not string.find(var_140_3.name, "split") then
						var_140_3.gameObject:SetActive(true)
					else
						var_140_3.gameObject:SetActive(false)
					end
				end
			end

			local var_140_4 = 0.001

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_4 then
				local var_140_5 = (arg_137_1.time_ - var_140_1) / var_140_4
				local var_140_6 = Vector3.New(390, -350, -180)

				var_140_0.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos10015, var_140_6, var_140_5)
			end

			if arg_137_1.time_ >= var_140_1 + var_140_4 and arg_137_1.time_ < var_140_1 + var_140_4 + arg_140_0 then
				var_140_0.localPosition = Vector3.New(390, -350, -180)
			end

			local var_140_7 = arg_137_1.actors_["10018"]
			local var_140_8 = 0

			if var_140_8 < arg_137_1.time_ and arg_137_1.time_ <= var_140_8 + arg_140_0 and not isNil(var_140_7) then
				local var_140_9 = var_140_7:GetComponent("Image")

				if var_140_9 then
					arg_137_1.var_.highlightMatValue10018 = var_140_9
				end
			end

			local var_140_10 = 0.034

			if var_140_8 <= arg_137_1.time_ and arg_137_1.time_ < var_140_8 + var_140_10 and not isNil(var_140_7) then
				local var_140_11 = (arg_137_1.time_ - var_140_8) / var_140_10

				if arg_137_1.var_.highlightMatValue10018 then
					local var_140_12 = Mathf.Lerp(1, 0.5, var_140_11)
					local var_140_13 = arg_137_1.var_.highlightMatValue10018
					local var_140_14 = var_140_13.color

					var_140_14.r = var_140_12
					var_140_14.g = var_140_12
					var_140_14.b = var_140_12
					var_140_13.color = var_140_14
				end
			end

			if arg_137_1.time_ >= var_140_8 + var_140_10 and arg_137_1.time_ < var_140_8 + var_140_10 + arg_140_0 and not isNil(var_140_7) and arg_137_1.var_.highlightMatValue10018 then
				local var_140_15 = 0.5
				local var_140_16 = arg_137_1.var_.highlightMatValue10018
				local var_140_17 = var_140_16.color

				var_140_17.r = var_140_15
				var_140_17.g = var_140_15
				var_140_17.b = var_140_15
				var_140_16.color = var_140_17
			end

			local var_140_18 = arg_137_1.actors_["10015"]
			local var_140_19 = 0

			if var_140_19 < arg_137_1.time_ and arg_137_1.time_ <= var_140_19 + arg_140_0 and not isNil(var_140_18) and arg_137_1.var_.actorSpriteComps10015 == nil then
				arg_137_1.var_.actorSpriteComps10015 = var_140_18:GetComponentsInChildren(typeof(Image), true)
			end

			local var_140_20 = 0.034

			if var_140_19 <= arg_137_1.time_ and arg_137_1.time_ < var_140_19 + var_140_20 and not isNil(var_140_18) then
				local var_140_21 = (arg_137_1.time_ - var_140_19) / var_140_20

				if arg_137_1.var_.actorSpriteComps10015 then
					for iter_140_1, iter_140_2 in pairs(arg_137_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_140_2 then
							if arg_137_1.isInRecall_ then
								local var_140_22 = Mathf.Lerp(iter_140_2.color.r, arg_137_1.hightColor1.r, var_140_21)
								local var_140_23 = Mathf.Lerp(iter_140_2.color.g, arg_137_1.hightColor1.g, var_140_21)
								local var_140_24 = Mathf.Lerp(iter_140_2.color.b, arg_137_1.hightColor1.b, var_140_21)

								iter_140_2.color = Color.New(var_140_22, var_140_23, var_140_24)
							else
								local var_140_25 = Mathf.Lerp(iter_140_2.color.r, 1, var_140_21)

								iter_140_2.color = Color.New(var_140_25, var_140_25, var_140_25)
							end
						end
					end
				end
			end

			if arg_137_1.time_ >= var_140_19 + var_140_20 and arg_137_1.time_ < var_140_19 + var_140_20 + arg_140_0 and not isNil(var_140_18) and arg_137_1.var_.actorSpriteComps10015 then
				for iter_140_3, iter_140_4 in pairs(arg_137_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_140_4 then
						if arg_137_1.isInRecall_ then
							iter_140_4.color = arg_137_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_140_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_137_1.var_.actorSpriteComps10015 = nil
			end

			local var_140_26 = arg_137_1.actors_["10015"]
			local var_140_27 = 0

			if var_140_27 < arg_137_1.time_ and arg_137_1.time_ <= var_140_27 + arg_140_0 then
				local var_140_28 = var_140_26:GetComponentInChildren(typeof(CanvasGroup))

				if var_140_28 then
					arg_137_1.var_.alphaOldValue10015 = var_140_28.alpha
					arg_137_1.var_.characterEffect10015 = var_140_28
				end

				arg_137_1.var_.alphaOldValue10015 = 0
			end

			local var_140_29 = 0.5

			if var_140_27 <= arg_137_1.time_ and arg_137_1.time_ < var_140_27 + var_140_29 then
				local var_140_30 = (arg_137_1.time_ - var_140_27) / var_140_29
				local var_140_31 = Mathf.Lerp(arg_137_1.var_.alphaOldValue10015, 1, var_140_30)

				if arg_137_1.var_.characterEffect10015 then
					arg_137_1.var_.characterEffect10015.alpha = var_140_31
				end
			end

			if arg_137_1.time_ >= var_140_27 + var_140_29 and arg_137_1.time_ < var_140_27 + var_140_29 + arg_140_0 and arg_137_1.var_.characterEffect10015 then
				arg_137_1.var_.characterEffect10015.alpha = 1
			end

			local var_140_32 = 0
			local var_140_33 = 0.05

			if var_140_32 < arg_137_1.time_ and arg_137_1.time_ <= var_140_32 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_34 = arg_137_1:FormatText(StoryNameCfg[208].name)

				arg_137_1.leftNameTxt_.text = var_140_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_35 = arg_137_1:GetWordFromCfg(114231033)
				local var_140_36 = arg_137_1:FormatText(var_140_35.content)

				arg_137_1.text_.text = var_140_36

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_37 = 2
				local var_140_38 = utf8.len(var_140_36)
				local var_140_39 = var_140_37 <= 0 and var_140_33 or var_140_33 * (var_140_38 / var_140_37)

				if var_140_39 > 0 and var_140_33 < var_140_39 then
					arg_137_1.talkMaxDuration = var_140_39

					if var_140_39 + var_140_32 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_39 + var_140_32
					end
				end

				arg_137_1.text_.text = var_140_36
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114231", "114231033", "story_v_out_114231.awb") ~= 0 then
					local var_140_40 = manager.audio:GetVoiceLength("story_v_out_114231", "114231033", "story_v_out_114231.awb") / 1000

					if var_140_40 + var_140_32 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_40 + var_140_32
					end

					if var_140_35.prefab_name ~= "" and arg_137_1.actors_[var_140_35.prefab_name] ~= nil then
						local var_140_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_35.prefab_name].transform, "story_v_out_114231", "114231033", "story_v_out_114231.awb")

						arg_137_1:RecordAudio("114231033", var_140_41)
						arg_137_1:RecordAudio("114231033", var_140_41)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_114231", "114231033", "story_v_out_114231.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_114231", "114231033", "story_v_out_114231.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_42 = math.max(var_140_33, arg_137_1.talkMaxDuration)

			if var_140_32 <= arg_137_1.time_ and arg_137_1.time_ < var_140_32 + var_140_42 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_32) / var_140_42

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_32 + var_140_42 and arg_137_1.time_ < var_140_32 + var_140_42 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_137_1:InitPlayNodeList()
	end,
	Play114231034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 114231034
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play114231035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["10015"]
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.actorSpriteComps10015 == nil then
				arg_141_1.var_.actorSpriteComps10015 = var_144_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_2 = 0.034

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 and not isNil(var_144_0) then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / var_144_2

				if arg_141_1.var_.actorSpriteComps10015 then
					for iter_144_0, iter_144_1 in pairs(arg_141_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_144_1 then
							if arg_141_1.isInRecall_ then
								local var_144_4 = Mathf.Lerp(iter_144_1.color.r, arg_141_1.hightColor2.r, var_144_3)
								local var_144_5 = Mathf.Lerp(iter_144_1.color.g, arg_141_1.hightColor2.g, var_144_3)
								local var_144_6 = Mathf.Lerp(iter_144_1.color.b, arg_141_1.hightColor2.b, var_144_3)

								iter_144_1.color = Color.New(var_144_4, var_144_5, var_144_6)
							else
								local var_144_7 = Mathf.Lerp(iter_144_1.color.r, 0.5, var_144_3)

								iter_144_1.color = Color.New(var_144_7, var_144_7, var_144_7)
							end
						end
					end
				end
			end

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.actorSpriteComps10015 then
				for iter_144_2, iter_144_3 in pairs(arg_141_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_144_3 then
						if arg_141_1.isInRecall_ then
							iter_144_3.color = arg_141_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_144_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_141_1.var_.actorSpriteComps10015 = nil
			end

			local var_144_8 = 0
			local var_144_9 = 1.35

			if var_144_8 < arg_141_1.time_ and arg_141_1.time_ <= var_144_8 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, false)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_10 = arg_141_1:GetWordFromCfg(114231034)
				local var_144_11 = arg_141_1:FormatText(var_144_10.content)

				arg_141_1.text_.text = var_144_11

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_12 = 53
				local var_144_13 = utf8.len(var_144_11)
				local var_144_14 = var_144_12 <= 0 and var_144_9 or var_144_9 * (var_144_13 / var_144_12)

				if var_144_14 > 0 and var_144_9 < var_144_14 then
					arg_141_1.talkMaxDuration = var_144_14

					if var_144_14 + var_144_8 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_14 + var_144_8
					end
				end

				arg_141_1.text_.text = var_144_11
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_15 = math.max(var_144_9, arg_141_1.talkMaxDuration)

			if var_144_8 <= arg_141_1.time_ and arg_141_1.time_ < var_144_8 + var_144_15 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_8) / var_144_15

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_8 + var_144_15 and arg_141_1.time_ < var_144_8 + var_144_15 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play114231035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 114231035
		arg_145_1.duration_ = 7.8

		local var_145_0 = {
			ja = 4.933,
			ko = 5.133,
			zh = 6.4,
			en = 7.8
		}
		local var_145_1 = manager.audio:GetLocalizationFlag()

		if var_145_0[var_145_1] ~= nil then
			arg_145_1.duration_ = var_145_0[var_145_1]
		end

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play114231036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["10015"]
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.actorSpriteComps10015 == nil then
				arg_145_1.var_.actorSpriteComps10015 = var_148_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_148_2 = 0.034

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_2 and not isNil(var_148_0) then
				local var_148_3 = (arg_145_1.time_ - var_148_1) / var_148_2

				if arg_145_1.var_.actorSpriteComps10015 then
					for iter_148_0, iter_148_1 in pairs(arg_145_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_148_1 then
							if arg_145_1.isInRecall_ then
								local var_148_4 = Mathf.Lerp(iter_148_1.color.r, arg_145_1.hightColor1.r, var_148_3)
								local var_148_5 = Mathf.Lerp(iter_148_1.color.g, arg_145_1.hightColor1.g, var_148_3)
								local var_148_6 = Mathf.Lerp(iter_148_1.color.b, arg_145_1.hightColor1.b, var_148_3)

								iter_148_1.color = Color.New(var_148_4, var_148_5, var_148_6)
							else
								local var_148_7 = Mathf.Lerp(iter_148_1.color.r, 1, var_148_3)

								iter_148_1.color = Color.New(var_148_7, var_148_7, var_148_7)
							end
						end
					end
				end
			end

			if arg_145_1.time_ >= var_148_1 + var_148_2 and arg_145_1.time_ < var_148_1 + var_148_2 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.actorSpriteComps10015 then
				for iter_148_2, iter_148_3 in pairs(arg_145_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_148_3 then
						if arg_145_1.isInRecall_ then
							iter_148_3.color = arg_145_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_148_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_145_1.var_.actorSpriteComps10015 = nil
			end

			local var_148_8 = 0
			local var_148_9 = 0.65

			if var_148_8 < arg_145_1.time_ and arg_145_1.time_ <= var_148_8 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_10 = arg_145_1:FormatText(StoryNameCfg[208].name)

				arg_145_1.leftNameTxt_.text = var_148_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_11 = arg_145_1:GetWordFromCfg(114231035)
				local var_148_12 = arg_145_1:FormatText(var_148_11.content)

				arg_145_1.text_.text = var_148_12

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_13 = 26
				local var_148_14 = utf8.len(var_148_12)
				local var_148_15 = var_148_13 <= 0 and var_148_9 or var_148_9 * (var_148_14 / var_148_13)

				if var_148_15 > 0 and var_148_9 < var_148_15 then
					arg_145_1.talkMaxDuration = var_148_15

					if var_148_15 + var_148_8 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_15 + var_148_8
					end
				end

				arg_145_1.text_.text = var_148_12
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114231", "114231035", "story_v_out_114231.awb") ~= 0 then
					local var_148_16 = manager.audio:GetVoiceLength("story_v_out_114231", "114231035", "story_v_out_114231.awb") / 1000

					if var_148_16 + var_148_8 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_16 + var_148_8
					end

					if var_148_11.prefab_name ~= "" and arg_145_1.actors_[var_148_11.prefab_name] ~= nil then
						local var_148_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_11.prefab_name].transform, "story_v_out_114231", "114231035", "story_v_out_114231.awb")

						arg_145_1:RecordAudio("114231035", var_148_17)
						arg_145_1:RecordAudio("114231035", var_148_17)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_114231", "114231035", "story_v_out_114231.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_114231", "114231035", "story_v_out_114231.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_18 = math.max(var_148_9, arg_145_1.talkMaxDuration)

			if var_148_8 <= arg_145_1.time_ and arg_145_1.time_ < var_148_8 + var_148_18 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_8) / var_148_18

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_8 + var_148_18 and arg_145_1.time_ < var_148_8 + var_148_18 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play114231036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 114231036
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play114231037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["10015"]
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.actorSpriteComps10015 == nil then
				arg_149_1.var_.actorSpriteComps10015 = var_152_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_2 = 0.034

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_2 and not isNil(var_152_0) then
				local var_152_3 = (arg_149_1.time_ - var_152_1) / var_152_2

				if arg_149_1.var_.actorSpriteComps10015 then
					for iter_152_0, iter_152_1 in pairs(arg_149_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_152_1 then
							if arg_149_1.isInRecall_ then
								local var_152_4 = Mathf.Lerp(iter_152_1.color.r, arg_149_1.hightColor2.r, var_152_3)
								local var_152_5 = Mathf.Lerp(iter_152_1.color.g, arg_149_1.hightColor2.g, var_152_3)
								local var_152_6 = Mathf.Lerp(iter_152_1.color.b, arg_149_1.hightColor2.b, var_152_3)

								iter_152_1.color = Color.New(var_152_4, var_152_5, var_152_6)
							else
								local var_152_7 = Mathf.Lerp(iter_152_1.color.r, 0.5, var_152_3)

								iter_152_1.color = Color.New(var_152_7, var_152_7, var_152_7)
							end
						end
					end
				end
			end

			if arg_149_1.time_ >= var_152_1 + var_152_2 and arg_149_1.time_ < var_152_1 + var_152_2 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.actorSpriteComps10015 then
				for iter_152_2, iter_152_3 in pairs(arg_149_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_152_3 then
						if arg_149_1.isInRecall_ then
							iter_152_3.color = arg_149_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_152_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_149_1.var_.actorSpriteComps10015 = nil
			end

			local var_152_8 = 0
			local var_152_9 = 1.2

			if var_152_8 < arg_149_1.time_ and arg_149_1.time_ <= var_152_8 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, false)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_10 = arg_149_1:GetWordFromCfg(114231036)
				local var_152_11 = arg_149_1:FormatText(var_152_10.content)

				arg_149_1.text_.text = var_152_11

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_12 = 48
				local var_152_13 = utf8.len(var_152_11)
				local var_152_14 = var_152_12 <= 0 and var_152_9 or var_152_9 * (var_152_13 / var_152_12)

				if var_152_14 > 0 and var_152_9 < var_152_14 then
					arg_149_1.talkMaxDuration = var_152_14

					if var_152_14 + var_152_8 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_14 + var_152_8
					end
				end

				arg_149_1.text_.text = var_152_11
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_15 = math.max(var_152_9, arg_149_1.talkMaxDuration)

			if var_152_8 <= arg_149_1.time_ and arg_149_1.time_ < var_152_8 + var_152_15 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_8) / var_152_15

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_8 + var_152_15 and arg_149_1.time_ < var_152_8 + var_152_15 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play114231037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 114231037
		arg_153_1.duration_ = 5.1

		local var_153_0 = {
			ja = 5.1,
			ko = 2.766,
			zh = 3.5,
			en = 2.9
		}
		local var_153_1 = manager.audio:GetLocalizationFlag()

		if var_153_0[var_153_1] ~= nil then
			arg_153_1.duration_ = var_153_0[var_153_1]
		end

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play114231038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["10018"]
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 and not isNil(var_156_0) then
				local var_156_2 = var_156_0:GetComponent("Image")

				if var_156_2 then
					arg_153_1.var_.highlightMatValue10018 = var_156_2
				end
			end

			local var_156_3 = 0.034

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_3 and not isNil(var_156_0) then
				local var_156_4 = (arg_153_1.time_ - var_156_1) / var_156_3

				if arg_153_1.var_.highlightMatValue10018 then
					local var_156_5 = Mathf.Lerp(0.5, 1, var_156_4)
					local var_156_6 = arg_153_1.var_.highlightMatValue10018
					local var_156_7 = var_156_6.color

					var_156_7.r = var_156_5
					var_156_7.g = var_156_5
					var_156_7.b = var_156_5
					var_156_6.color = var_156_7
				end
			end

			if arg_153_1.time_ >= var_156_1 + var_156_3 and arg_153_1.time_ < var_156_1 + var_156_3 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.highlightMatValue10018 then
				local var_156_8 = 1

				var_156_0.transform:SetSiblingIndex(1)

				local var_156_9 = arg_153_1.var_.highlightMatValue10018
				local var_156_10 = var_156_9.color

				var_156_10.r = var_156_8
				var_156_10.g = var_156_8
				var_156_10.b = var_156_8
				var_156_9.color = var_156_10
			end

			local var_156_11 = 0
			local var_156_12 = 0.175

			if var_156_11 < arg_153_1.time_ and arg_153_1.time_ <= var_156_11 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_13 = arg_153_1:FormatText(StoryNameCfg[36].name)

				arg_153_1.leftNameTxt_.text = var_156_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_14 = arg_153_1:GetWordFromCfg(114231037)
				local var_156_15 = arg_153_1:FormatText(var_156_14.content)

				arg_153_1.text_.text = var_156_15

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_16 = 7
				local var_156_17 = utf8.len(var_156_15)
				local var_156_18 = var_156_16 <= 0 and var_156_12 or var_156_12 * (var_156_17 / var_156_16)

				if var_156_18 > 0 and var_156_12 < var_156_18 then
					arg_153_1.talkMaxDuration = var_156_18

					if var_156_18 + var_156_11 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_18 + var_156_11
					end
				end

				arg_153_1.text_.text = var_156_15
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114231", "114231037", "story_v_out_114231.awb") ~= 0 then
					local var_156_19 = manager.audio:GetVoiceLength("story_v_out_114231", "114231037", "story_v_out_114231.awb") / 1000

					if var_156_19 + var_156_11 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_19 + var_156_11
					end

					if var_156_14.prefab_name ~= "" and arg_153_1.actors_[var_156_14.prefab_name] ~= nil then
						local var_156_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_14.prefab_name].transform, "story_v_out_114231", "114231037", "story_v_out_114231.awb")

						arg_153_1:RecordAudio("114231037", var_156_20)
						arg_153_1:RecordAudio("114231037", var_156_20)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_114231", "114231037", "story_v_out_114231.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_114231", "114231037", "story_v_out_114231.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_21 = math.max(var_156_12, arg_153_1.talkMaxDuration)

			if var_156_11 <= arg_153_1.time_ and arg_153_1.time_ < var_156_11 + var_156_21 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_11) / var_156_21

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_11 + var_156_21 and arg_153_1.time_ < var_156_11 + var_156_21 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play114231038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 114231038
		arg_157_1.duration_ = 2.07

		local var_157_0 = {
			ja = 1.2,
			ko = 1.666,
			zh = 1.5,
			en = 2.066
		}
		local var_157_1 = manager.audio:GetLocalizationFlag()

		if var_157_0[var_157_1] ~= nil then
			arg_157_1.duration_ = var_157_0[var_157_1]
		end

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play114231039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["10018"]
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 and not isNil(var_160_0) then
				local var_160_2 = var_160_0:GetComponent("Image")

				if var_160_2 then
					arg_157_1.var_.highlightMatValue10018 = var_160_2
				end
			end

			local var_160_3 = 0.034

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_3 and not isNil(var_160_0) then
				local var_160_4 = (arg_157_1.time_ - var_160_1) / var_160_3

				if arg_157_1.var_.highlightMatValue10018 then
					local var_160_5 = Mathf.Lerp(1, 0.5, var_160_4)
					local var_160_6 = arg_157_1.var_.highlightMatValue10018
					local var_160_7 = var_160_6.color

					var_160_7.r = var_160_5
					var_160_7.g = var_160_5
					var_160_7.b = var_160_5
					var_160_6.color = var_160_7
				end
			end

			if arg_157_1.time_ >= var_160_1 + var_160_3 and arg_157_1.time_ < var_160_1 + var_160_3 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.highlightMatValue10018 then
				local var_160_8 = 0.5
				local var_160_9 = arg_157_1.var_.highlightMatValue10018
				local var_160_10 = var_160_9.color

				var_160_10.r = var_160_8
				var_160_10.g = var_160_8
				var_160_10.b = var_160_8
				var_160_9.color = var_160_10
			end

			local var_160_11 = arg_157_1.actors_["10015"]
			local var_160_12 = 0

			if var_160_12 < arg_157_1.time_ and arg_157_1.time_ <= var_160_12 + arg_160_0 and not isNil(var_160_11) and arg_157_1.var_.actorSpriteComps10015 == nil then
				arg_157_1.var_.actorSpriteComps10015 = var_160_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_13 = 0.034

			if var_160_12 <= arg_157_1.time_ and arg_157_1.time_ < var_160_12 + var_160_13 and not isNil(var_160_11) then
				local var_160_14 = (arg_157_1.time_ - var_160_12) / var_160_13

				if arg_157_1.var_.actorSpriteComps10015 then
					for iter_160_0, iter_160_1 in pairs(arg_157_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_160_1 then
							if arg_157_1.isInRecall_ then
								local var_160_15 = Mathf.Lerp(iter_160_1.color.r, arg_157_1.hightColor1.r, var_160_14)
								local var_160_16 = Mathf.Lerp(iter_160_1.color.g, arg_157_1.hightColor1.g, var_160_14)
								local var_160_17 = Mathf.Lerp(iter_160_1.color.b, arg_157_1.hightColor1.b, var_160_14)

								iter_160_1.color = Color.New(var_160_15, var_160_16, var_160_17)
							else
								local var_160_18 = Mathf.Lerp(iter_160_1.color.r, 1, var_160_14)

								iter_160_1.color = Color.New(var_160_18, var_160_18, var_160_18)
							end
						end
					end
				end
			end

			if arg_157_1.time_ >= var_160_12 + var_160_13 and arg_157_1.time_ < var_160_12 + var_160_13 + arg_160_0 and not isNil(var_160_11) and arg_157_1.var_.actorSpriteComps10015 then
				for iter_160_2, iter_160_3 in pairs(arg_157_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_160_3 then
						if arg_157_1.isInRecall_ then
							iter_160_3.color = arg_157_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_160_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_157_1.var_.actorSpriteComps10015 = nil
			end

			local var_160_19 = 0
			local var_160_20 = 0.075

			if var_160_19 < arg_157_1.time_ and arg_157_1.time_ <= var_160_19 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_21 = arg_157_1:FormatText(StoryNameCfg[208].name)

				arg_157_1.leftNameTxt_.text = var_160_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_22 = arg_157_1:GetWordFromCfg(114231038)
				local var_160_23 = arg_157_1:FormatText(var_160_22.content)

				arg_157_1.text_.text = var_160_23

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_24 = 3
				local var_160_25 = utf8.len(var_160_23)
				local var_160_26 = var_160_24 <= 0 and var_160_20 or var_160_20 * (var_160_25 / var_160_24)

				if var_160_26 > 0 and var_160_20 < var_160_26 then
					arg_157_1.talkMaxDuration = var_160_26

					if var_160_26 + var_160_19 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_26 + var_160_19
					end
				end

				arg_157_1.text_.text = var_160_23
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114231", "114231038", "story_v_out_114231.awb") ~= 0 then
					local var_160_27 = manager.audio:GetVoiceLength("story_v_out_114231", "114231038", "story_v_out_114231.awb") / 1000

					if var_160_27 + var_160_19 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_27 + var_160_19
					end

					if var_160_22.prefab_name ~= "" and arg_157_1.actors_[var_160_22.prefab_name] ~= nil then
						local var_160_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_22.prefab_name].transform, "story_v_out_114231", "114231038", "story_v_out_114231.awb")

						arg_157_1:RecordAudio("114231038", var_160_28)
						arg_157_1:RecordAudio("114231038", var_160_28)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_114231", "114231038", "story_v_out_114231.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_114231", "114231038", "story_v_out_114231.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_29 = math.max(var_160_20, arg_157_1.talkMaxDuration)

			if var_160_19 <= arg_157_1.time_ and arg_157_1.time_ < var_160_19 + var_160_29 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_19) / var_160_29

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_19 + var_160_29 and arg_157_1.time_ < var_160_19 + var_160_29 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play114231039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 114231039
		arg_161_1.duration_ = 15.33

		local var_161_0 = {
			ja = 6.033,
			ko = 10.3,
			zh = 10.1,
			en = 15.333
		}
		local var_161_1 = manager.audio:GetLocalizationFlag()

		if var_161_0[var_161_1] ~= nil then
			arg_161_1.duration_ = var_161_0[var_161_1]
		end

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play114231040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = arg_161_1.actors_["10018"]
			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 and not isNil(var_164_0) then
				local var_164_2 = var_164_0:GetComponent("Image")

				if var_164_2 then
					arg_161_1.var_.highlightMatValue10018 = var_164_2
				end
			end

			local var_164_3 = 0.034

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_3 and not isNil(var_164_0) then
				local var_164_4 = (arg_161_1.time_ - var_164_1) / var_164_3

				if arg_161_1.var_.highlightMatValue10018 then
					local var_164_5 = Mathf.Lerp(0.5, 1, var_164_4)
					local var_164_6 = arg_161_1.var_.highlightMatValue10018
					local var_164_7 = var_164_6.color

					var_164_7.r = var_164_5
					var_164_7.g = var_164_5
					var_164_7.b = var_164_5
					var_164_6.color = var_164_7
				end
			end

			if arg_161_1.time_ >= var_164_1 + var_164_3 and arg_161_1.time_ < var_164_1 + var_164_3 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.highlightMatValue10018 then
				local var_164_8 = 1

				var_164_0.transform:SetSiblingIndex(1)

				local var_164_9 = arg_161_1.var_.highlightMatValue10018
				local var_164_10 = var_164_9.color

				var_164_10.r = var_164_8
				var_164_10.g = var_164_8
				var_164_10.b = var_164_8
				var_164_9.color = var_164_10
			end

			local var_164_11 = arg_161_1.actors_["10015"]
			local var_164_12 = 0

			if var_164_12 < arg_161_1.time_ and arg_161_1.time_ <= var_164_12 + arg_164_0 and not isNil(var_164_11) and arg_161_1.var_.actorSpriteComps10015 == nil then
				arg_161_1.var_.actorSpriteComps10015 = var_164_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_164_13 = 0.034

			if var_164_12 <= arg_161_1.time_ and arg_161_1.time_ < var_164_12 + var_164_13 and not isNil(var_164_11) then
				local var_164_14 = (arg_161_1.time_ - var_164_12) / var_164_13

				if arg_161_1.var_.actorSpriteComps10015 then
					for iter_164_0, iter_164_1 in pairs(arg_161_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_164_1 then
							if arg_161_1.isInRecall_ then
								local var_164_15 = Mathf.Lerp(iter_164_1.color.r, arg_161_1.hightColor2.r, var_164_14)
								local var_164_16 = Mathf.Lerp(iter_164_1.color.g, arg_161_1.hightColor2.g, var_164_14)
								local var_164_17 = Mathf.Lerp(iter_164_1.color.b, arg_161_1.hightColor2.b, var_164_14)

								iter_164_1.color = Color.New(var_164_15, var_164_16, var_164_17)
							else
								local var_164_18 = Mathf.Lerp(iter_164_1.color.r, 0.5, var_164_14)

								iter_164_1.color = Color.New(var_164_18, var_164_18, var_164_18)
							end
						end
					end
				end
			end

			if arg_161_1.time_ >= var_164_12 + var_164_13 and arg_161_1.time_ < var_164_12 + var_164_13 + arg_164_0 and not isNil(var_164_11) and arg_161_1.var_.actorSpriteComps10015 then
				for iter_164_2, iter_164_3 in pairs(arg_161_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_164_3 then
						if arg_161_1.isInRecall_ then
							iter_164_3.color = arg_161_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_164_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_161_1.var_.actorSpriteComps10015 = nil
			end

			local var_164_19 = 0
			local var_164_20 = 1.2

			if var_164_19 < arg_161_1.time_ and arg_161_1.time_ <= var_164_19 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_21 = arg_161_1:FormatText(StoryNameCfg[36].name)

				arg_161_1.leftNameTxt_.text = var_164_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_22 = arg_161_1:GetWordFromCfg(114231039)
				local var_164_23 = arg_161_1:FormatText(var_164_22.content)

				arg_161_1.text_.text = var_164_23

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_24 = 48
				local var_164_25 = utf8.len(var_164_23)
				local var_164_26 = var_164_24 <= 0 and var_164_20 or var_164_20 * (var_164_25 / var_164_24)

				if var_164_26 > 0 and var_164_20 < var_164_26 then
					arg_161_1.talkMaxDuration = var_164_26

					if var_164_26 + var_164_19 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_26 + var_164_19
					end
				end

				arg_161_1.text_.text = var_164_23
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114231", "114231039", "story_v_out_114231.awb") ~= 0 then
					local var_164_27 = manager.audio:GetVoiceLength("story_v_out_114231", "114231039", "story_v_out_114231.awb") / 1000

					if var_164_27 + var_164_19 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_27 + var_164_19
					end

					if var_164_22.prefab_name ~= "" and arg_161_1.actors_[var_164_22.prefab_name] ~= nil then
						local var_164_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_22.prefab_name].transform, "story_v_out_114231", "114231039", "story_v_out_114231.awb")

						arg_161_1:RecordAudio("114231039", var_164_28)
						arg_161_1:RecordAudio("114231039", var_164_28)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_114231", "114231039", "story_v_out_114231.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_114231", "114231039", "story_v_out_114231.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_29 = math.max(var_164_20, arg_161_1.talkMaxDuration)

			if var_164_19 <= arg_161_1.time_ and arg_161_1.time_ < var_164_19 + var_164_29 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_19) / var_164_29

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_19 + var_164_29 and arg_161_1.time_ < var_164_19 + var_164_29 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play114231040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 114231040
		arg_165_1.duration_ = 3.6

		local var_165_0 = {
			ja = 2.7,
			ko = 3.6,
			zh = 2.766,
			en = 3.133
		}
		local var_165_1 = manager.audio:GetLocalizationFlag()

		if var_165_0[var_165_1] ~= nil then
			arg_165_1.duration_ = var_165_0[var_165_1]
		end

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play114231041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = arg_165_1.actors_["10018"]
			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 and not isNil(var_168_0) then
				local var_168_2 = var_168_0:GetComponent("Image")

				if var_168_2 then
					arg_165_1.var_.highlightMatValue10018 = var_168_2
				end
			end

			local var_168_3 = 0.034

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_3 and not isNil(var_168_0) then
				local var_168_4 = (arg_165_1.time_ - var_168_1) / var_168_3

				if arg_165_1.var_.highlightMatValue10018 then
					local var_168_5 = Mathf.Lerp(1, 0.5, var_168_4)
					local var_168_6 = arg_165_1.var_.highlightMatValue10018
					local var_168_7 = var_168_6.color

					var_168_7.r = var_168_5
					var_168_7.g = var_168_5
					var_168_7.b = var_168_5
					var_168_6.color = var_168_7
				end
			end

			if arg_165_1.time_ >= var_168_1 + var_168_3 and arg_165_1.time_ < var_168_1 + var_168_3 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.highlightMatValue10018 then
				local var_168_8 = 0.5
				local var_168_9 = arg_165_1.var_.highlightMatValue10018
				local var_168_10 = var_168_9.color

				var_168_10.r = var_168_8
				var_168_10.g = var_168_8
				var_168_10.b = var_168_8
				var_168_9.color = var_168_10
			end

			local var_168_11 = arg_165_1.actors_["10015"]
			local var_168_12 = 0

			if var_168_12 < arg_165_1.time_ and arg_165_1.time_ <= var_168_12 + arg_168_0 and not isNil(var_168_11) and arg_165_1.var_.actorSpriteComps10015 == nil then
				arg_165_1.var_.actorSpriteComps10015 = var_168_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_168_13 = 0.034

			if var_168_12 <= arg_165_1.time_ and arg_165_1.time_ < var_168_12 + var_168_13 and not isNil(var_168_11) then
				local var_168_14 = (arg_165_1.time_ - var_168_12) / var_168_13

				if arg_165_1.var_.actorSpriteComps10015 then
					for iter_168_0, iter_168_1 in pairs(arg_165_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_168_1 then
							if arg_165_1.isInRecall_ then
								local var_168_15 = Mathf.Lerp(iter_168_1.color.r, arg_165_1.hightColor1.r, var_168_14)
								local var_168_16 = Mathf.Lerp(iter_168_1.color.g, arg_165_1.hightColor1.g, var_168_14)
								local var_168_17 = Mathf.Lerp(iter_168_1.color.b, arg_165_1.hightColor1.b, var_168_14)

								iter_168_1.color = Color.New(var_168_15, var_168_16, var_168_17)
							else
								local var_168_18 = Mathf.Lerp(iter_168_1.color.r, 1, var_168_14)

								iter_168_1.color = Color.New(var_168_18, var_168_18, var_168_18)
							end
						end
					end
				end
			end

			if arg_165_1.time_ >= var_168_12 + var_168_13 and arg_165_1.time_ < var_168_12 + var_168_13 + arg_168_0 and not isNil(var_168_11) and arg_165_1.var_.actorSpriteComps10015 then
				for iter_168_2, iter_168_3 in pairs(arg_165_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_168_3 then
						if arg_165_1.isInRecall_ then
							iter_168_3.color = arg_165_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_168_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_165_1.var_.actorSpriteComps10015 = nil
			end

			local var_168_19 = 0
			local var_168_20 = 0.3

			if var_168_19 < arg_165_1.time_ and arg_165_1.time_ <= var_168_19 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_21 = arg_165_1:FormatText(StoryNameCfg[208].name)

				arg_165_1.leftNameTxt_.text = var_168_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_22 = arg_165_1:GetWordFromCfg(114231040)
				local var_168_23 = arg_165_1:FormatText(var_168_22.content)

				arg_165_1.text_.text = var_168_23

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_24 = 12
				local var_168_25 = utf8.len(var_168_23)
				local var_168_26 = var_168_24 <= 0 and var_168_20 or var_168_20 * (var_168_25 / var_168_24)

				if var_168_26 > 0 and var_168_20 < var_168_26 then
					arg_165_1.talkMaxDuration = var_168_26

					if var_168_26 + var_168_19 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_26 + var_168_19
					end
				end

				arg_165_1.text_.text = var_168_23
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114231", "114231040", "story_v_out_114231.awb") ~= 0 then
					local var_168_27 = manager.audio:GetVoiceLength("story_v_out_114231", "114231040", "story_v_out_114231.awb") / 1000

					if var_168_27 + var_168_19 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_27 + var_168_19
					end

					if var_168_22.prefab_name ~= "" and arg_165_1.actors_[var_168_22.prefab_name] ~= nil then
						local var_168_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_22.prefab_name].transform, "story_v_out_114231", "114231040", "story_v_out_114231.awb")

						arg_165_1:RecordAudio("114231040", var_168_28)
						arg_165_1:RecordAudio("114231040", var_168_28)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_114231", "114231040", "story_v_out_114231.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_114231", "114231040", "story_v_out_114231.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_29 = math.max(var_168_20, arg_165_1.talkMaxDuration)

			if var_168_19 <= arg_165_1.time_ and arg_165_1.time_ < var_168_19 + var_168_29 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_19) / var_168_29

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_19 + var_168_29 and arg_165_1.time_ < var_168_19 + var_168_29 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play114231041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 114231041
		arg_169_1.duration_ = 13.97

		local var_169_0 = {
			ja = 9.533,
			ko = 12.166,
			zh = 13.966,
			en = 12.533
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
				arg_169_0:Play114231042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.actors_["10018"]
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 and not isNil(var_172_0) then
				local var_172_2 = var_172_0:GetComponent("Image")

				if var_172_2 then
					arg_169_1.var_.highlightMatValue10018 = var_172_2
				end
			end

			local var_172_3 = 0.034

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_3 and not isNil(var_172_0) then
				local var_172_4 = (arg_169_1.time_ - var_172_1) / var_172_3

				if arg_169_1.var_.highlightMatValue10018 then
					local var_172_5 = Mathf.Lerp(0.5, 1, var_172_4)
					local var_172_6 = arg_169_1.var_.highlightMatValue10018
					local var_172_7 = var_172_6.color

					var_172_7.r = var_172_5
					var_172_7.g = var_172_5
					var_172_7.b = var_172_5
					var_172_6.color = var_172_7
				end
			end

			if arg_169_1.time_ >= var_172_1 + var_172_3 and arg_169_1.time_ < var_172_1 + var_172_3 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.highlightMatValue10018 then
				local var_172_8 = 1

				var_172_0.transform:SetSiblingIndex(1)

				local var_172_9 = arg_169_1.var_.highlightMatValue10018
				local var_172_10 = var_172_9.color

				var_172_10.r = var_172_8
				var_172_10.g = var_172_8
				var_172_10.b = var_172_8
				var_172_9.color = var_172_10
			end

			local var_172_11 = arg_169_1.actors_["10015"]
			local var_172_12 = 0

			if var_172_12 < arg_169_1.time_ and arg_169_1.time_ <= var_172_12 + arg_172_0 and not isNil(var_172_11) and arg_169_1.var_.actorSpriteComps10015 == nil then
				arg_169_1.var_.actorSpriteComps10015 = var_172_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_172_13 = 0.034

			if var_172_12 <= arg_169_1.time_ and arg_169_1.time_ < var_172_12 + var_172_13 and not isNil(var_172_11) then
				local var_172_14 = (arg_169_1.time_ - var_172_12) / var_172_13

				if arg_169_1.var_.actorSpriteComps10015 then
					for iter_172_0, iter_172_1 in pairs(arg_169_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_172_1 then
							if arg_169_1.isInRecall_ then
								local var_172_15 = Mathf.Lerp(iter_172_1.color.r, arg_169_1.hightColor2.r, var_172_14)
								local var_172_16 = Mathf.Lerp(iter_172_1.color.g, arg_169_1.hightColor2.g, var_172_14)
								local var_172_17 = Mathf.Lerp(iter_172_1.color.b, arg_169_1.hightColor2.b, var_172_14)

								iter_172_1.color = Color.New(var_172_15, var_172_16, var_172_17)
							else
								local var_172_18 = Mathf.Lerp(iter_172_1.color.r, 0.5, var_172_14)

								iter_172_1.color = Color.New(var_172_18, var_172_18, var_172_18)
							end
						end
					end
				end
			end

			if arg_169_1.time_ >= var_172_12 + var_172_13 and arg_169_1.time_ < var_172_12 + var_172_13 + arg_172_0 and not isNil(var_172_11) and arg_169_1.var_.actorSpriteComps10015 then
				for iter_172_2, iter_172_3 in pairs(arg_169_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_172_3 then
						if arg_169_1.isInRecall_ then
							iter_172_3.color = arg_169_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_172_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_169_1.var_.actorSpriteComps10015 = nil
			end

			local var_172_19 = 0
			local var_172_20 = 1.425

			if var_172_19 < arg_169_1.time_ and arg_169_1.time_ <= var_172_19 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_21 = arg_169_1:FormatText(StoryNameCfg[36].name)

				arg_169_1.leftNameTxt_.text = var_172_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_22 = arg_169_1:GetWordFromCfg(114231041)
				local var_172_23 = arg_169_1:FormatText(var_172_22.content)

				arg_169_1.text_.text = var_172_23

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_24 = 57
				local var_172_25 = utf8.len(var_172_23)
				local var_172_26 = var_172_24 <= 0 and var_172_20 or var_172_20 * (var_172_25 / var_172_24)

				if var_172_26 > 0 and var_172_20 < var_172_26 then
					arg_169_1.talkMaxDuration = var_172_26

					if var_172_26 + var_172_19 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_26 + var_172_19
					end
				end

				arg_169_1.text_.text = var_172_23
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114231", "114231041", "story_v_out_114231.awb") ~= 0 then
					local var_172_27 = manager.audio:GetVoiceLength("story_v_out_114231", "114231041", "story_v_out_114231.awb") / 1000

					if var_172_27 + var_172_19 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_27 + var_172_19
					end

					if var_172_22.prefab_name ~= "" and arg_169_1.actors_[var_172_22.prefab_name] ~= nil then
						local var_172_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_22.prefab_name].transform, "story_v_out_114231", "114231041", "story_v_out_114231.awb")

						arg_169_1:RecordAudio("114231041", var_172_28)
						arg_169_1:RecordAudio("114231041", var_172_28)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_114231", "114231041", "story_v_out_114231.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_114231", "114231041", "story_v_out_114231.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_29 = math.max(var_172_20, arg_169_1.talkMaxDuration)

			if var_172_19 <= arg_169_1.time_ and arg_169_1.time_ < var_172_19 + var_172_29 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_19) / var_172_29

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_19 + var_172_29 and arg_169_1.time_ < var_172_19 + var_172_29 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play114231042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 114231042
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play114231043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["10018"]
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 and not isNil(var_176_0) then
				local var_176_2 = var_176_0:GetComponent("Image")

				if var_176_2 then
					arg_173_1.var_.highlightMatValue10018 = var_176_2
				end
			end

			local var_176_3 = 0.034

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_3 and not isNil(var_176_0) then
				local var_176_4 = (arg_173_1.time_ - var_176_1) / var_176_3

				if arg_173_1.var_.highlightMatValue10018 then
					local var_176_5 = Mathf.Lerp(1, 0.5, var_176_4)
					local var_176_6 = arg_173_1.var_.highlightMatValue10018
					local var_176_7 = var_176_6.color

					var_176_7.r = var_176_5
					var_176_7.g = var_176_5
					var_176_7.b = var_176_5
					var_176_6.color = var_176_7
				end
			end

			if arg_173_1.time_ >= var_176_1 + var_176_3 and arg_173_1.time_ < var_176_1 + var_176_3 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.highlightMatValue10018 then
				local var_176_8 = 0.5
				local var_176_9 = arg_173_1.var_.highlightMatValue10018
				local var_176_10 = var_176_9.color

				var_176_10.r = var_176_8
				var_176_10.g = var_176_8
				var_176_10.b = var_176_8
				var_176_9.color = var_176_10
			end

			local var_176_11 = 0
			local var_176_12 = 0.95

			if var_176_11 < arg_173_1.time_ and arg_173_1.time_ <= var_176_11 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, false)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_13 = arg_173_1:GetWordFromCfg(114231042)
				local var_176_14 = arg_173_1:FormatText(var_176_13.content)

				arg_173_1.text_.text = var_176_14

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_15 = 38
				local var_176_16 = utf8.len(var_176_14)
				local var_176_17 = var_176_15 <= 0 and var_176_12 or var_176_12 * (var_176_16 / var_176_15)

				if var_176_17 > 0 and var_176_12 < var_176_17 then
					arg_173_1.talkMaxDuration = var_176_17

					if var_176_17 + var_176_11 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_17 + var_176_11
					end
				end

				arg_173_1.text_.text = var_176_14
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_18 = math.max(var_176_12, arg_173_1.talkMaxDuration)

			if var_176_11 <= arg_173_1.time_ and arg_173_1.time_ < var_176_11 + var_176_18 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_11) / var_176_18

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_11 + var_176_18 and arg_173_1.time_ < var_176_11 + var_176_18 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play114231043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 114231043
		arg_177_1.duration_ = 6.27

		local var_177_0 = {
			ja = 6.266,
			ko = 2.566,
			zh = 2.333,
			en = 4
		}
		local var_177_1 = manager.audio:GetLocalizationFlag()

		if var_177_0[var_177_1] ~= nil then
			arg_177_1.duration_ = var_177_0[var_177_1]
		end

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play114231044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["10015"]
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.actorSpriteComps10015 == nil then
				arg_177_1.var_.actorSpriteComps10015 = var_180_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_2 = 0.034

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_2 and not isNil(var_180_0) then
				local var_180_3 = (arg_177_1.time_ - var_180_1) / var_180_2

				if arg_177_1.var_.actorSpriteComps10015 then
					for iter_180_0, iter_180_1 in pairs(arg_177_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_180_1 then
							if arg_177_1.isInRecall_ then
								local var_180_4 = Mathf.Lerp(iter_180_1.color.r, arg_177_1.hightColor1.r, var_180_3)
								local var_180_5 = Mathf.Lerp(iter_180_1.color.g, arg_177_1.hightColor1.g, var_180_3)
								local var_180_6 = Mathf.Lerp(iter_180_1.color.b, arg_177_1.hightColor1.b, var_180_3)

								iter_180_1.color = Color.New(var_180_4, var_180_5, var_180_6)
							else
								local var_180_7 = Mathf.Lerp(iter_180_1.color.r, 1, var_180_3)

								iter_180_1.color = Color.New(var_180_7, var_180_7, var_180_7)
							end
						end
					end
				end
			end

			if arg_177_1.time_ >= var_180_1 + var_180_2 and arg_177_1.time_ < var_180_1 + var_180_2 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.actorSpriteComps10015 then
				for iter_180_2, iter_180_3 in pairs(arg_177_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_180_3 then
						if arg_177_1.isInRecall_ then
							iter_180_3.color = arg_177_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_180_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_177_1.var_.actorSpriteComps10015 = nil
			end

			local var_180_8 = 0
			local var_180_9 = 0.3

			if var_180_8 < arg_177_1.time_ and arg_177_1.time_ <= var_180_8 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_10 = arg_177_1:FormatText(StoryNameCfg[208].name)

				arg_177_1.leftNameTxt_.text = var_180_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_11 = arg_177_1:GetWordFromCfg(114231043)
				local var_180_12 = arg_177_1:FormatText(var_180_11.content)

				arg_177_1.text_.text = var_180_12

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_13 = 12
				local var_180_14 = utf8.len(var_180_12)
				local var_180_15 = var_180_13 <= 0 and var_180_9 or var_180_9 * (var_180_14 / var_180_13)

				if var_180_15 > 0 and var_180_9 < var_180_15 then
					arg_177_1.talkMaxDuration = var_180_15

					if var_180_15 + var_180_8 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_15 + var_180_8
					end
				end

				arg_177_1.text_.text = var_180_12
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114231", "114231043", "story_v_out_114231.awb") ~= 0 then
					local var_180_16 = manager.audio:GetVoiceLength("story_v_out_114231", "114231043", "story_v_out_114231.awb") / 1000

					if var_180_16 + var_180_8 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_16 + var_180_8
					end

					if var_180_11.prefab_name ~= "" and arg_177_1.actors_[var_180_11.prefab_name] ~= nil then
						local var_180_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_11.prefab_name].transform, "story_v_out_114231", "114231043", "story_v_out_114231.awb")

						arg_177_1:RecordAudio("114231043", var_180_17)
						arg_177_1:RecordAudio("114231043", var_180_17)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_114231", "114231043", "story_v_out_114231.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_114231", "114231043", "story_v_out_114231.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_18 = math.max(var_180_9, arg_177_1.talkMaxDuration)

			if var_180_8 <= arg_177_1.time_ and arg_177_1.time_ < var_180_8 + var_180_18 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_8) / var_180_18

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_8 + var_180_18 and arg_177_1.time_ < var_180_8 + var_180_18 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play114231044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 114231044
		arg_181_1.duration_ = 3

		local var_181_0 = {
			ja = 1.866,
			ko = 2.366,
			zh = 2.866,
			en = 3
		}
		local var_181_1 = manager.audio:GetLocalizationFlag()

		if var_181_0[var_181_1] ~= nil then
			arg_181_1.duration_ = var_181_0[var_181_1]
		end

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play114231045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["10018"]
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 and not isNil(var_184_0) then
				local var_184_2 = var_184_0:GetComponent("Image")

				if var_184_2 then
					arg_181_1.var_.highlightMatValue10018 = var_184_2
				end
			end

			local var_184_3 = 0.034

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_3 and not isNil(var_184_0) then
				local var_184_4 = (arg_181_1.time_ - var_184_1) / var_184_3

				if arg_181_1.var_.highlightMatValue10018 then
					local var_184_5 = Mathf.Lerp(0.5, 1, var_184_4)
					local var_184_6 = arg_181_1.var_.highlightMatValue10018
					local var_184_7 = var_184_6.color

					var_184_7.r = var_184_5
					var_184_7.g = var_184_5
					var_184_7.b = var_184_5
					var_184_6.color = var_184_7
				end
			end

			if arg_181_1.time_ >= var_184_1 + var_184_3 and arg_181_1.time_ < var_184_1 + var_184_3 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.highlightMatValue10018 then
				local var_184_8 = 1

				var_184_0.transform:SetSiblingIndex(1)

				local var_184_9 = arg_181_1.var_.highlightMatValue10018
				local var_184_10 = var_184_9.color

				var_184_10.r = var_184_8
				var_184_10.g = var_184_8
				var_184_10.b = var_184_8
				var_184_9.color = var_184_10
			end

			local var_184_11 = arg_181_1.actors_["10015"]
			local var_184_12 = 0

			if var_184_12 < arg_181_1.time_ and arg_181_1.time_ <= var_184_12 + arg_184_0 and not isNil(var_184_11) and arg_181_1.var_.actorSpriteComps10015 == nil then
				arg_181_1.var_.actorSpriteComps10015 = var_184_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_13 = 0.034

			if var_184_12 <= arg_181_1.time_ and arg_181_1.time_ < var_184_12 + var_184_13 and not isNil(var_184_11) then
				local var_184_14 = (arg_181_1.time_ - var_184_12) / var_184_13

				if arg_181_1.var_.actorSpriteComps10015 then
					for iter_184_0, iter_184_1 in pairs(arg_181_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_184_1 then
							if arg_181_1.isInRecall_ then
								local var_184_15 = Mathf.Lerp(iter_184_1.color.r, arg_181_1.hightColor2.r, var_184_14)
								local var_184_16 = Mathf.Lerp(iter_184_1.color.g, arg_181_1.hightColor2.g, var_184_14)
								local var_184_17 = Mathf.Lerp(iter_184_1.color.b, arg_181_1.hightColor2.b, var_184_14)

								iter_184_1.color = Color.New(var_184_15, var_184_16, var_184_17)
							else
								local var_184_18 = Mathf.Lerp(iter_184_1.color.r, 0.5, var_184_14)

								iter_184_1.color = Color.New(var_184_18, var_184_18, var_184_18)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= var_184_12 + var_184_13 and arg_181_1.time_ < var_184_12 + var_184_13 + arg_184_0 and not isNil(var_184_11) and arg_181_1.var_.actorSpriteComps10015 then
				for iter_184_2, iter_184_3 in pairs(arg_181_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_184_3 then
						if arg_181_1.isInRecall_ then
							iter_184_3.color = arg_181_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_184_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_181_1.var_.actorSpriteComps10015 = nil
			end

			local var_184_19 = 0
			local var_184_20 = 0.2

			if var_184_19 < arg_181_1.time_ and arg_181_1.time_ <= var_184_19 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_21 = arg_181_1:FormatText(StoryNameCfg[36].name)

				arg_181_1.leftNameTxt_.text = var_184_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_22 = arg_181_1:GetWordFromCfg(114231044)
				local var_184_23 = arg_181_1:FormatText(var_184_22.content)

				arg_181_1.text_.text = var_184_23

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_24 = 8
				local var_184_25 = utf8.len(var_184_23)
				local var_184_26 = var_184_24 <= 0 and var_184_20 or var_184_20 * (var_184_25 / var_184_24)

				if var_184_26 > 0 and var_184_20 < var_184_26 then
					arg_181_1.talkMaxDuration = var_184_26

					if var_184_26 + var_184_19 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_26 + var_184_19
					end
				end

				arg_181_1.text_.text = var_184_23
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114231", "114231044", "story_v_out_114231.awb") ~= 0 then
					local var_184_27 = manager.audio:GetVoiceLength("story_v_out_114231", "114231044", "story_v_out_114231.awb") / 1000

					if var_184_27 + var_184_19 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_27 + var_184_19
					end

					if var_184_22.prefab_name ~= "" and arg_181_1.actors_[var_184_22.prefab_name] ~= nil then
						local var_184_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_22.prefab_name].transform, "story_v_out_114231", "114231044", "story_v_out_114231.awb")

						arg_181_1:RecordAudio("114231044", var_184_28)
						arg_181_1:RecordAudio("114231044", var_184_28)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_114231", "114231044", "story_v_out_114231.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_114231", "114231044", "story_v_out_114231.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_29 = math.max(var_184_20, arg_181_1.talkMaxDuration)

			if var_184_19 <= arg_181_1.time_ and arg_181_1.time_ < var_184_19 + var_184_29 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_19) / var_184_29

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_19 + var_184_29 and arg_181_1.time_ < var_184_19 + var_184_29 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play114231045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 114231045
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play114231046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.actors_["10018"]
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 and not isNil(var_188_0) then
				local var_188_2 = var_188_0:GetComponent("Image")

				if var_188_2 then
					arg_185_1.var_.highlightMatValue10018 = var_188_2
				end
			end

			local var_188_3 = 0.034

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_3 and not isNil(var_188_0) then
				local var_188_4 = (arg_185_1.time_ - var_188_1) / var_188_3

				if arg_185_1.var_.highlightMatValue10018 then
					local var_188_5 = Mathf.Lerp(1, 0.5, var_188_4)
					local var_188_6 = arg_185_1.var_.highlightMatValue10018
					local var_188_7 = var_188_6.color

					var_188_7.r = var_188_5
					var_188_7.g = var_188_5
					var_188_7.b = var_188_5
					var_188_6.color = var_188_7
				end
			end

			if arg_185_1.time_ >= var_188_1 + var_188_3 and arg_185_1.time_ < var_188_1 + var_188_3 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.highlightMatValue10018 then
				local var_188_8 = 0.5
				local var_188_9 = arg_185_1.var_.highlightMatValue10018
				local var_188_10 = var_188_9.color

				var_188_10.r = var_188_8
				var_188_10.g = var_188_8
				var_188_10.b = var_188_8
				var_188_9.color = var_188_10
			end

			local var_188_11 = 0
			local var_188_12 = 0.925

			if var_188_11 < arg_185_1.time_ and arg_185_1.time_ <= var_188_11 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, false)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_13 = arg_185_1:GetWordFromCfg(114231045)
				local var_188_14 = arg_185_1:FormatText(var_188_13.content)

				arg_185_1.text_.text = var_188_14

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_15 = 37
				local var_188_16 = utf8.len(var_188_14)
				local var_188_17 = var_188_15 <= 0 and var_188_12 or var_188_12 * (var_188_16 / var_188_15)

				if var_188_17 > 0 and var_188_12 < var_188_17 then
					arg_185_1.talkMaxDuration = var_188_17

					if var_188_17 + var_188_11 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_17 + var_188_11
					end
				end

				arg_185_1.text_.text = var_188_14
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_18 = math.max(var_188_12, arg_185_1.talkMaxDuration)

			if var_188_11 <= arg_185_1.time_ and arg_185_1.time_ < var_188_11 + var_188_18 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_11) / var_188_18

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_11 + var_188_18 and arg_185_1.time_ < var_188_11 + var_188_18 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play114231046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 114231046
		arg_189_1.duration_ = 13.13

		local var_189_0 = {
			ja = 13.133,
			ko = 5.2,
			zh = 4.433,
			en = 4.766
		}
		local var_189_1 = manager.audio:GetLocalizationFlag()

		if var_189_0[var_189_1] ~= nil then
			arg_189_1.duration_ = var_189_0[var_189_1]
		end

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play114231047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["10015"].transform
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 then
				arg_189_1.var_.moveOldPos10015 = var_192_0.localPosition
				var_192_0.localScale = Vector3.New(1, 1, 1)

				arg_189_1:CheckSpriteTmpPos("10015", 4)

				local var_192_2 = var_192_0.childCount

				for iter_192_0 = 0, var_192_2 - 1 do
					local var_192_3 = var_192_0:GetChild(iter_192_0)

					if var_192_3.name == "split_1" or not string.find(var_192_3.name, "split") then
						var_192_3.gameObject:SetActive(true)
					else
						var_192_3.gameObject:SetActive(false)
					end
				end
			end

			local var_192_4 = 0.001

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_4 then
				local var_192_5 = (arg_189_1.time_ - var_192_1) / var_192_4
				local var_192_6 = Vector3.New(390, -350, -180)

				var_192_0.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos10015, var_192_6, var_192_5)
			end

			if arg_189_1.time_ >= var_192_1 + var_192_4 and arg_189_1.time_ < var_192_1 + var_192_4 + arg_192_0 then
				var_192_0.localPosition = Vector3.New(390, -350, -180)
			end

			local var_192_7 = arg_189_1.actors_["10015"]
			local var_192_8 = 0

			if var_192_8 < arg_189_1.time_ and arg_189_1.time_ <= var_192_8 + arg_192_0 and not isNil(var_192_7) and arg_189_1.var_.actorSpriteComps10015 == nil then
				arg_189_1.var_.actorSpriteComps10015 = var_192_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_192_9 = 0.034

			if var_192_8 <= arg_189_1.time_ and arg_189_1.time_ < var_192_8 + var_192_9 and not isNil(var_192_7) then
				local var_192_10 = (arg_189_1.time_ - var_192_8) / var_192_9

				if arg_189_1.var_.actorSpriteComps10015 then
					for iter_192_1, iter_192_2 in pairs(arg_189_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_192_2 then
							if arg_189_1.isInRecall_ then
								local var_192_11 = Mathf.Lerp(iter_192_2.color.r, arg_189_1.hightColor1.r, var_192_10)
								local var_192_12 = Mathf.Lerp(iter_192_2.color.g, arg_189_1.hightColor1.g, var_192_10)
								local var_192_13 = Mathf.Lerp(iter_192_2.color.b, arg_189_1.hightColor1.b, var_192_10)

								iter_192_2.color = Color.New(var_192_11, var_192_12, var_192_13)
							else
								local var_192_14 = Mathf.Lerp(iter_192_2.color.r, 1, var_192_10)

								iter_192_2.color = Color.New(var_192_14, var_192_14, var_192_14)
							end
						end
					end
				end
			end

			if arg_189_1.time_ >= var_192_8 + var_192_9 and arg_189_1.time_ < var_192_8 + var_192_9 + arg_192_0 and not isNil(var_192_7) and arg_189_1.var_.actorSpriteComps10015 then
				for iter_192_3, iter_192_4 in pairs(arg_189_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_192_4 then
						if arg_189_1.isInRecall_ then
							iter_192_4.color = arg_189_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_192_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_189_1.var_.actorSpriteComps10015 = nil
			end

			local var_192_15 = 0
			local var_192_16 = 0.575

			if var_192_15 < arg_189_1.time_ and arg_189_1.time_ <= var_192_15 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_17 = arg_189_1:FormatText(StoryNameCfg[208].name)

				arg_189_1.leftNameTxt_.text = var_192_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_18 = arg_189_1:GetWordFromCfg(114231046)
				local var_192_19 = arg_189_1:FormatText(var_192_18.content)

				arg_189_1.text_.text = var_192_19

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_20 = 23
				local var_192_21 = utf8.len(var_192_19)
				local var_192_22 = var_192_20 <= 0 and var_192_16 or var_192_16 * (var_192_21 / var_192_20)

				if var_192_22 > 0 and var_192_16 < var_192_22 then
					arg_189_1.talkMaxDuration = var_192_22

					if var_192_22 + var_192_15 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_22 + var_192_15
					end
				end

				arg_189_1.text_.text = var_192_19
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114231", "114231046", "story_v_out_114231.awb") ~= 0 then
					local var_192_23 = manager.audio:GetVoiceLength("story_v_out_114231", "114231046", "story_v_out_114231.awb") / 1000

					if var_192_23 + var_192_15 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_23 + var_192_15
					end

					if var_192_18.prefab_name ~= "" and arg_189_1.actors_[var_192_18.prefab_name] ~= nil then
						local var_192_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_18.prefab_name].transform, "story_v_out_114231", "114231046", "story_v_out_114231.awb")

						arg_189_1:RecordAudio("114231046", var_192_24)
						arg_189_1:RecordAudio("114231046", var_192_24)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_114231", "114231046", "story_v_out_114231.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_114231", "114231046", "story_v_out_114231.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_25 = math.max(var_192_16, arg_189_1.talkMaxDuration)

			if var_192_15 <= arg_189_1.time_ and arg_189_1.time_ < var_192_15 + var_192_25 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_15) / var_192_25

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_15 + var_192_25 and arg_189_1.time_ < var_192_15 + var_192_25 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_189_1:InitPlayNodeList()
	end,
	Play114231047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 114231047
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play114231048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["10015"]
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.actorSpriteComps10015 == nil then
				arg_193_1.var_.actorSpriteComps10015 = var_196_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_2 = 0.034

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_2 and not isNil(var_196_0) then
				local var_196_3 = (arg_193_1.time_ - var_196_1) / var_196_2

				if arg_193_1.var_.actorSpriteComps10015 then
					for iter_196_0, iter_196_1 in pairs(arg_193_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_196_1 then
							if arg_193_1.isInRecall_ then
								local var_196_4 = Mathf.Lerp(iter_196_1.color.r, arg_193_1.hightColor2.r, var_196_3)
								local var_196_5 = Mathf.Lerp(iter_196_1.color.g, arg_193_1.hightColor2.g, var_196_3)
								local var_196_6 = Mathf.Lerp(iter_196_1.color.b, arg_193_1.hightColor2.b, var_196_3)

								iter_196_1.color = Color.New(var_196_4, var_196_5, var_196_6)
							else
								local var_196_7 = Mathf.Lerp(iter_196_1.color.r, 0.5, var_196_3)

								iter_196_1.color = Color.New(var_196_7, var_196_7, var_196_7)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= var_196_1 + var_196_2 and arg_193_1.time_ < var_196_1 + var_196_2 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.actorSpriteComps10015 then
				for iter_196_2, iter_196_3 in pairs(arg_193_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_196_3 then
						if arg_193_1.isInRecall_ then
							iter_196_3.color = arg_193_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_196_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_193_1.var_.actorSpriteComps10015 = nil
			end

			local var_196_8 = 0
			local var_196_9 = 1.375

			if var_196_8 < arg_193_1.time_ and arg_193_1.time_ <= var_196_8 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, false)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_10 = arg_193_1:GetWordFromCfg(114231047)
				local var_196_11 = arg_193_1:FormatText(var_196_10.content)

				arg_193_1.text_.text = var_196_11

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_12 = 55
				local var_196_13 = utf8.len(var_196_11)
				local var_196_14 = var_196_12 <= 0 and var_196_9 or var_196_9 * (var_196_13 / var_196_12)

				if var_196_14 > 0 and var_196_9 < var_196_14 then
					arg_193_1.talkMaxDuration = var_196_14

					if var_196_14 + var_196_8 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_14 + var_196_8
					end
				end

				arg_193_1.text_.text = var_196_11
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_15 = math.max(var_196_9, arg_193_1.talkMaxDuration)

			if var_196_8 <= arg_193_1.time_ and arg_193_1.time_ < var_196_8 + var_196_15 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_8) / var_196_15

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_8 + var_196_15 and arg_193_1.time_ < var_196_8 + var_196_15 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play114231048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 114231048
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play114231049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0
			local var_200_1 = 0.65

			if var_200_0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, false)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_2 = arg_197_1:GetWordFromCfg(114231048)
				local var_200_3 = arg_197_1:FormatText(var_200_2.content)

				arg_197_1.text_.text = var_200_3

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_4 = 26
				local var_200_5 = utf8.len(var_200_3)
				local var_200_6 = var_200_4 <= 0 and var_200_1 or var_200_1 * (var_200_5 / var_200_4)

				if var_200_6 > 0 and var_200_1 < var_200_6 then
					arg_197_1.talkMaxDuration = var_200_6

					if var_200_6 + var_200_0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_6 + var_200_0
					end
				end

				arg_197_1.text_.text = var_200_3
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_7 = math.max(var_200_1, arg_197_1.talkMaxDuration)

			if var_200_0 <= arg_197_1.time_ and arg_197_1.time_ < var_200_0 + var_200_7 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_0) / var_200_7

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_0 + var_200_7 and arg_197_1.time_ < var_200_0 + var_200_7 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play114231049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 114231049
		arg_201_1.duration_ = 6.87

		local var_201_0 = {
			ja = 5.4,
			ko = 4.5,
			zh = 6.866,
			en = 3.866
		}
		local var_201_1 = manager.audio:GetLocalizationFlag()

		if var_201_0[var_201_1] ~= nil then
			arg_201_1.duration_ = var_201_0[var_201_1]
		end

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
			arg_201_1.auto_ = false
		end

		function arg_201_1.playNext_(arg_203_0)
			arg_201_1.onStoryFinished_()
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = arg_201_1.actors_["10018"]
			local var_204_1 = 0

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 and not isNil(var_204_0) then
				local var_204_2 = var_204_0:GetComponent("Image")

				if var_204_2 then
					arg_201_1.var_.highlightMatValue10018 = var_204_2
				end
			end

			local var_204_3 = 0.034

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_3 and not isNil(var_204_0) then
				local var_204_4 = (arg_201_1.time_ - var_204_1) / var_204_3

				if arg_201_1.var_.highlightMatValue10018 then
					local var_204_5 = Mathf.Lerp(0.5, 1, var_204_4)
					local var_204_6 = arg_201_1.var_.highlightMatValue10018
					local var_204_7 = var_204_6.color

					var_204_7.r = var_204_5
					var_204_7.g = var_204_5
					var_204_7.b = var_204_5
					var_204_6.color = var_204_7
				end
			end

			if arg_201_1.time_ >= var_204_1 + var_204_3 and arg_201_1.time_ < var_204_1 + var_204_3 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.highlightMatValue10018 then
				local var_204_8 = 1

				var_204_0.transform:SetSiblingIndex(1)

				local var_204_9 = arg_201_1.var_.highlightMatValue10018
				local var_204_10 = var_204_9.color

				var_204_10.r = var_204_8
				var_204_10.g = var_204_8
				var_204_10.b = var_204_8
				var_204_9.color = var_204_10
			end

			local var_204_11 = 0
			local var_204_12 = 0.45

			if var_204_11 < arg_201_1.time_ and arg_201_1.time_ <= var_204_11 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_13 = arg_201_1:FormatText(StoryNameCfg[36].name)

				arg_201_1.leftNameTxt_.text = var_204_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_14 = arg_201_1:GetWordFromCfg(114231049)
				local var_204_15 = arg_201_1:FormatText(var_204_14.content)

				arg_201_1.text_.text = var_204_15

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_16 = 18
				local var_204_17 = utf8.len(var_204_15)
				local var_204_18 = var_204_16 <= 0 and var_204_12 or var_204_12 * (var_204_17 / var_204_16)

				if var_204_18 > 0 and var_204_12 < var_204_18 then
					arg_201_1.talkMaxDuration = var_204_18

					if var_204_18 + var_204_11 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_18 + var_204_11
					end
				end

				arg_201_1.text_.text = var_204_15
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114231", "114231049", "story_v_out_114231.awb") ~= 0 then
					local var_204_19 = manager.audio:GetVoiceLength("story_v_out_114231", "114231049", "story_v_out_114231.awb") / 1000

					if var_204_19 + var_204_11 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_19 + var_204_11
					end

					if var_204_14.prefab_name ~= "" and arg_201_1.actors_[var_204_14.prefab_name] ~= nil then
						local var_204_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_14.prefab_name].transform, "story_v_out_114231", "114231049", "story_v_out_114231.awb")

						arg_201_1:RecordAudio("114231049", var_204_20)
						arg_201_1:RecordAudio("114231049", var_204_20)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_114231", "114231049", "story_v_out_114231.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_114231", "114231049", "story_v_out_114231.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_21 = math.max(var_204_12, arg_201_1.talkMaxDuration)

			if var_204_11 <= arg_201_1.time_ and arg_201_1.time_ < var_204_11 + var_204_21 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_11) / var_204_21

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_11 + var_204_21 and arg_201_1.time_ < var_204_11 + var_204_21 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/F03a",
		"TextureConfig/Background/OM0504",
		"TextureConfig/Background/ST25"
	},
	voices = {
		"story_v_out_114231.awb"
	}
}
