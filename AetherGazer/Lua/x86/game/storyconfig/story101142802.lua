return {
	Play114282001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 114282001
		arg_1_1.duration_ = 5.74

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play114282002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0.5

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				arg_1_1.fswbg_:SetActive(true)
				arg_1_1.dialog_:SetActive(false)

				arg_1_1.fswtw_.percent = 0

				local var_4_1 = arg_1_1:GetWordFromCfg(114282001)
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

			local var_4_4 = 24
			local var_4_5 = 1.6
			local var_4_6 = arg_1_1:GetWordFromCfg(114282001)
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

			local var_4_11 = 1.6
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
			local var_4_27 = 5.237
			local var_4_28 = manager.audio:GetVoiceLength("story_v_out_114282", "114282001", "story_v_out_114282.awb") / 1000

			if var_4_28 > 0 and var_4_27 < var_4_28 and var_4_28 + var_4_26 > arg_1_1.duration_ then
				local var_4_29 = var_4_28

				arg_1_1.duration_ = var_4_28 + var_4_26
			end

			if var_4_26 < arg_1_1.time_ and arg_1_1.time_ <= var_4_26 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "voice"

				arg_1_1:AudioAction(var_4_30, var_4_31, "story_v_out_114282", "114282001", "story_v_out_114282.awb")
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play114282002 = function(arg_6_0, arg_6_1)
		arg_6_1.time_ = 0
		arg_6_1.frameCnt_ = 0
		arg_6_1.state_ = "playing"
		arg_6_1.curTalkId_ = 114282002
		arg_6_1.duration_ = 3.78

		SetActive(arg_6_1.tipsGo_, false)

		function arg_6_1.onSingleLineFinish_()
			arg_6_1.onSingleLineUpdate_ = nil
			arg_6_1.onSingleLineFinish_ = nil
			arg_6_1.state_ = "waiting"
		end

		function arg_6_1.playNext_(arg_8_0)
			if arg_8_0 == 1 then
				arg_6_0:Play114282003(arg_6_1)
			end
		end

		function arg_6_1.onSingleLineUpdate_(arg_9_0)
			local var_9_0 = 0

			if var_9_0 < arg_6_1.time_ and arg_6_1.time_ <= var_9_0 + arg_9_0 then
				arg_6_1.var_.oldValueTypewriter = arg_6_1.fswtw_.percent

				SetActive(arg_6_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_6_1:ShowNextGo(false)
			end

			local var_9_1 = 18
			local var_9_2 = 1.2
			local var_9_3 = arg_6_1:GetWordFromCfg(114282001)
			local var_9_4 = arg_6_1:FormatText(var_9_3.content)
			local var_9_5, var_9_6 = arg_6_1:GetPercentByPara(var_9_4, 2)

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

			local var_9_8 = 1.2
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
			local var_9_12 = 3.782
			local var_9_13 = manager.audio:GetVoiceLength("story_v_out_114282", "114282002", "story_v_out_114282.awb") / 1000

			if var_9_13 > 0 and var_9_12 < var_9_13 and var_9_13 + var_9_11 > arg_6_1.duration_ then
				local var_9_14 = var_9_13

				arg_6_1.duration_ = var_9_13 + var_9_11
			end

			if var_9_11 < arg_6_1.time_ and arg_6_1.time_ <= var_9_11 + arg_9_0 then
				local var_9_15 = "play"
				local var_9_16 = "voice"

				arg_6_1:AudioAction(var_9_15, var_9_16, "story_v_out_114282", "114282002", "story_v_out_114282.awb")
			end
		end

		arg_6_1.nodeConfigList_ = {}

		arg_6_1:InitPlayNodeList()
	end,
	Play114282003 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 114282003
		arg_10_1.duration_ = 1

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play114282004(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			local var_13_0 = 0

			if var_13_0 < arg_10_1.time_ and arg_10_1.time_ <= var_13_0 + arg_13_0 then
				arg_10_1.var_.oldValueTypewriter = arg_10_1.fswtw_.percent

				SetActive(arg_10_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_10_1:ShowNextGo(false)
			end

			local var_13_1 = 10
			local var_13_2 = 0.666666666666667
			local var_13_3 = arg_10_1:GetWordFromCfg(114282001)
			local var_13_4 = arg_10_1:FormatText(var_13_3.content)
			local var_13_5, var_13_6 = arg_10_1:GetPercentByPara(var_13_4, 3)

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

			local var_13_8 = 0.666666666666667
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
			local var_13_12 = 0.803
			local var_13_13 = manager.audio:GetVoiceLength("story_v_out_114282", "114282003", "story_v_out_114282.awb") / 1000

			if var_13_13 > 0 and var_13_12 < var_13_13 and var_13_13 + var_13_11 > arg_10_1.duration_ then
				local var_13_14 = var_13_13

				arg_10_1.duration_ = var_13_13 + var_13_11
			end

			if var_13_11 < arg_10_1.time_ and arg_10_1.time_ <= var_13_11 + arg_13_0 then
				local var_13_15 = "play"
				local var_13_16 = "voice"

				arg_10_1:AudioAction(var_13_15, var_13_16, "story_v_out_114282", "114282003", "story_v_out_114282.awb")
			end
		end

		arg_10_1.nodeConfigList_ = {}

		arg_10_1:InitPlayNodeList()
	end,
	Play114282004 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 114282004
		arg_14_1.duration_ = 1.65

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play114282005(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = 0

			if var_17_0 < arg_14_1.time_ and arg_14_1.time_ <= var_17_0 + arg_17_0 then
				arg_14_1.var_.oldValueTypewriter = arg_14_1.fswtw_.percent

				SetActive(arg_14_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_14_1:ShowNextGo(false)
			end

			local var_17_1 = 13
			local var_17_2 = 0.866666666666667
			local var_17_3 = arg_14_1:GetWordFromCfg(114282001)
			local var_17_4 = arg_14_1:FormatText(var_17_3.content)
			local var_17_5, var_17_6 = arg_14_1:GetPercentByPara(var_17_4, 4)

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

			local var_17_8 = 0.866666666666667
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
			local var_17_12 = 1.648
			local var_17_13 = manager.audio:GetVoiceLength("story_v_out_114282", "114282004", "story_v_out_114282.awb") / 1000

			if var_17_13 > 0 and var_17_12 < var_17_13 and var_17_13 + var_17_11 > arg_14_1.duration_ then
				local var_17_14 = var_17_13

				arg_14_1.duration_ = var_17_13 + var_17_11
			end

			if var_17_11 < arg_14_1.time_ and arg_14_1.time_ <= var_17_11 + arg_17_0 then
				local var_17_15 = "play"
				local var_17_16 = "voice"

				arg_14_1:AudioAction(var_17_15, var_17_16, "story_v_out_114282", "114282004", "story_v_out_114282.awb")
			end
		end

		arg_14_1.nodeConfigList_ = {}

		arg_14_1:InitPlayNodeList()
	end,
	Play114282005 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 114282005
		arg_18_1.duration_ = 3.2

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play114282006(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = 0

			if var_21_0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_0 + arg_21_0 then
				arg_18_1.var_.oldValueTypewriter = arg_18_1.fswtw_.percent

				SetActive(arg_18_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_18_1:ShowNextGo(false)
			end

			local var_21_1 = 48
			local var_21_2 = 3.2
			local var_21_3 = arg_18_1:GetWordFromCfg(114282001)
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

			local var_21_8 = 3.2
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
	Play114282006 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 114282006
		arg_22_1.duration_ = 8.49

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play114282007(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = 0

			if var_25_0 < arg_22_1.time_ and arg_22_1.time_ <= var_25_0 + arg_25_0 then
				arg_22_1.var_.oldValueTypewriter = arg_22_1.fswtw_.percent

				SetActive(arg_22_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_22_1:ShowNextGo(false)
			end

			local var_25_1 = 30
			local var_25_2 = 2
			local var_25_3 = arg_22_1:GetWordFromCfg(114282001)
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

			local var_25_8 = 2
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
			local var_25_12 = 8.487
			local var_25_13 = manager.audio:GetVoiceLength("story_v_out_114282", "114282006", "story_v_out_114282.awb") / 1000

			if var_25_13 > 0 and var_25_12 < var_25_13 and var_25_13 + var_25_11 > arg_22_1.duration_ then
				local var_25_14 = var_25_13

				arg_22_1.duration_ = var_25_13 + var_25_11
			end

			if var_25_11 < arg_22_1.time_ and arg_22_1.time_ <= var_25_11 + arg_25_0 then
				local var_25_15 = "play"
				local var_25_16 = "voice"

				arg_22_1:AudioAction(var_25_15, var_25_16, "story_v_out_114282", "114282006", "story_v_out_114282.awb")
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play114282007 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 114282007
		arg_26_1.duration_ = 1

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play114282008(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = 0

			if var_29_0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_0 + arg_29_0 then
				arg_26_1.var_.oldValueTypewriter = arg_26_1.fswtw_.percent

				SetActive(arg_26_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_26_1:ShowNextGo(false)
			end

			local var_29_1 = 11
			local var_29_2 = 0.733333333333333
			local var_29_3 = arg_26_1:GetWordFromCfg(114282001)
			local var_29_4 = arg_26_1:FormatText(var_29_3.content)
			local var_29_5, var_29_6 = arg_26_1:GetPercentByPara(var_29_4, 7)

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

			local var_29_8 = 0.733333333333333
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
			local var_29_12 = 0.767
			local var_29_13 = manager.audio:GetVoiceLength("story_v_out_114282", "114282007", "story_v_out_114282.awb") / 1000

			if var_29_13 > 0 and var_29_12 < var_29_13 and var_29_13 + var_29_11 > arg_26_1.duration_ then
				local var_29_14 = var_29_13

				arg_26_1.duration_ = var_29_13 + var_29_11
			end

			if var_29_11 < arg_26_1.time_ and arg_26_1.time_ <= var_29_11 + arg_29_0 then
				local var_29_15 = "play"
				local var_29_16 = "voice"

				arg_26_1:AudioAction(var_29_15, var_29_16, "story_v_out_114282", "114282007", "story_v_out_114282.awb")
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play114282008 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 114282008
		arg_30_1.duration_ = 2.39

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play114282009(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = 0

			if var_33_0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_0 + arg_33_0 then
				arg_30_1.var_.oldValueTypewriter = arg_30_1.fswtw_.percent

				SetActive(arg_30_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_30_1:ShowNextGo(false)
			end

			local var_33_1 = 0
			local var_33_2 = 0
			local var_33_3 = arg_30_1:GetWordFromCfg(114282001)
			local var_33_4 = arg_30_1:FormatText(var_33_3.content)
			local var_33_5, var_33_6 = arg_30_1:GetPercentByPara(var_33_4, 7)

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

			local var_33_8 = 0
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

			if var_33_11 < arg_30_1.time_ and arg_30_1.time_ <= var_33_11 + arg_33_0 then
				arg_30_1.fswbg_:SetActive(true)
				arg_30_1.dialog_:SetActive(false)

				arg_30_1.fswtw_.percent = 0

				local var_33_12 = arg_30_1:GetWordFromCfg(114282008)
				local var_33_13 = arg_30_1:FormatText(var_33_12.content)

				arg_30_1.fswt_.text = var_33_13

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.fswt_)

				arg_30_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_30_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_30_1.fswtw_:SetDirty()

				arg_30_1.typewritterCharCountI18N = 0

				SetActive(arg_30_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_30_1:ShowNextGo(false)
			end

			local var_33_14 = 0.0166666666666667

			if var_33_14 < arg_30_1.time_ and arg_30_1.time_ <= var_33_14 + arg_33_0 then
				arg_30_1.var_.oldValueTypewriter = arg_30_1.fswtw_.percent

				SetActive(arg_30_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_30_1:ShowNextGo(false)
			end

			local var_33_15 = 16
			local var_33_16 = 1.06666666666667
			local var_33_17 = arg_30_1:GetWordFromCfg(114282008)
			local var_33_18 = arg_30_1:FormatText(var_33_17.content)
			local var_33_19, var_33_20 = arg_30_1:GetPercentByPara(var_33_18, 1)

			if var_33_14 < arg_30_1.time_ and arg_30_1.time_ <= var_33_14 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0

				local var_33_21 = var_33_15 <= 0 and var_33_16 or var_33_16 * ((var_33_20 - arg_30_1.typewritterCharCountI18N) / var_33_15)

				if var_33_21 > 0 and var_33_16 < var_33_21 then
					arg_30_1.talkMaxDuration = var_33_21

					if var_33_21 + var_33_14 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_21 + var_33_14
					end
				end
			end

			local var_33_22 = 1.06666666666667
			local var_33_23 = math.max(var_33_22, arg_30_1.talkMaxDuration)

			if var_33_14 <= arg_30_1.time_ and arg_30_1.time_ < var_33_14 + var_33_23 then
				local var_33_24 = (arg_30_1.time_ - var_33_14) / var_33_23

				arg_30_1.fswtw_.percent = Mathf.Lerp(arg_30_1.var_.oldValueTypewriter, var_33_19, var_33_24)
				arg_30_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_30_1.fswtw_:SetDirty()
			end

			if arg_30_1.time_ >= var_33_14 + var_33_23 and arg_30_1.time_ < var_33_14 + var_33_23 + arg_33_0 then
				arg_30_1.fswtw_.percent = var_33_19

				arg_30_1.fswtw_:SetDirty()
				arg_30_1:ShowNextGo(true)

				arg_30_1.typewritterCharCountI18N = var_33_20
			end

			local var_33_25 = 0
			local var_33_26 = 2.395
			local var_33_27 = manager.audio:GetVoiceLength("story_v_out_114282", "114282008", "story_v_out_114282.awb") / 1000

			if var_33_27 > 0 and var_33_26 < var_33_27 and var_33_27 + var_33_25 > arg_30_1.duration_ then
				local var_33_28 = var_33_27

				arg_30_1.duration_ = var_33_27 + var_33_25
			end

			if var_33_25 < arg_30_1.time_ and arg_30_1.time_ <= var_33_25 + arg_33_0 then
				local var_33_29 = "play"
				local var_33_30 = "voice"

				arg_30_1:AudioAction(var_33_29, var_33_30, "story_v_out_114282", "114282008", "story_v_out_114282.awb")
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play114282009 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 114282009
		arg_34_1.duration_ = 4.93

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play114282010(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = 0

			if var_37_0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_0 + arg_37_0 then
				arg_34_1.var_.oldValueTypewriter = arg_34_1.fswtw_.percent

				SetActive(arg_34_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_34_1:ShowNextGo(false)
			end

			local var_37_1 = 29
			local var_37_2 = 1.93333333333333
			local var_37_3 = arg_34_1:GetWordFromCfg(114282008)
			local var_37_4 = arg_34_1:FormatText(var_37_3.content)
			local var_37_5, var_37_6 = arg_34_1:GetPercentByPara(var_37_4, 2)

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

			local var_37_8 = 1.93333333333333
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
			local var_37_12 = 4.927
			local var_37_13 = manager.audio:GetVoiceLength("story_v_out_114282", "114282009", "story_v_out_114282.awb") / 1000

			if var_37_13 > 0 and var_37_12 < var_37_13 and var_37_13 + var_37_11 > arg_34_1.duration_ then
				local var_37_14 = var_37_13

				arg_34_1.duration_ = var_37_13 + var_37_11
			end

			if var_37_11 < arg_34_1.time_ and arg_34_1.time_ <= var_37_11 + arg_37_0 then
				local var_37_15 = "play"
				local var_37_16 = "voice"

				arg_34_1:AudioAction(var_37_15, var_37_16, "story_v_out_114282", "114282009", "story_v_out_114282.awb")
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play114282010 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 114282010
		arg_38_1.duration_ = 13

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play114282011(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = 0

			if var_41_0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_0 + arg_41_0 then
				arg_38_1.var_.oldValueTypewriter = arg_38_1.fswtw_.percent

				SetActive(arg_38_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_38_1:ShowNextGo(false)
			end

			local var_41_1 = 59
			local var_41_2 = 3.93333333333333
			local var_41_3 = arg_38_1:GetWordFromCfg(114282008)
			local var_41_4 = arg_38_1:FormatText(var_41_3.content)
			local var_41_5, var_41_6 = arg_38_1:GetPercentByPara(var_41_4, 3)

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

			local var_41_8 = 3.93333333333333
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
			local var_41_12 = 13.004
			local var_41_13 = manager.audio:GetVoiceLength("story_v_out_114282", "114282010", "story_v_out_114282.awb") / 1000

			if var_41_13 > 0 and var_41_12 < var_41_13 and var_41_13 + var_41_11 > arg_38_1.duration_ then
				local var_41_14 = var_41_13

				arg_38_1.duration_ = var_41_13 + var_41_11
			end

			if var_41_11 < arg_38_1.time_ and arg_38_1.time_ <= var_41_11 + arg_41_0 then
				local var_41_15 = "play"
				local var_41_16 = "voice"

				arg_38_1:AudioAction(var_41_15, var_41_16, "story_v_out_114282", "114282010", "story_v_out_114282.awb")
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play114282011 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 114282011
		arg_42_1.duration_ = 2.21

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play114282012(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = 0

			if var_45_0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_0 + arg_45_0 then
				arg_42_1.var_.oldValueTypewriter = arg_42_1.fswtw_.percent

				SetActive(arg_42_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_42_1:ShowNextGo(false)
			end

			local var_45_1 = 18
			local var_45_2 = 1.2
			local var_45_3 = arg_42_1:GetWordFromCfg(114282008)
			local var_45_4 = arg_42_1:FormatText(var_45_3.content)
			local var_45_5, var_45_6 = arg_42_1:GetPercentByPara(var_45_4, 4)

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

			local var_45_8 = 1.2
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
			local var_45_12 = 2.21
			local var_45_13 = manager.audio:GetVoiceLength("story_v_out_114282", "114282011", "story_v_out_114282.awb") / 1000

			if var_45_13 > 0 and var_45_12 < var_45_13 and var_45_13 + var_45_11 > arg_42_1.duration_ then
				local var_45_14 = var_45_13

				arg_42_1.duration_ = var_45_13 + var_45_11
			end

			if var_45_11 < arg_42_1.time_ and arg_42_1.time_ <= var_45_11 + arg_45_0 then
				local var_45_15 = "play"
				local var_45_16 = "voice"

				arg_42_1:AudioAction(var_45_15, var_45_16, "story_v_out_114282", "114282011", "story_v_out_114282.awb")
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play114282012 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 114282012
		arg_46_1.duration_ = 15.63

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play114282013(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = 0

			if var_49_0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_0 + arg_49_0 then
				arg_46_1.var_.oldValueTypewriter = arg_46_1.fswtw_.percent

				SetActive(arg_46_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_46_1:ShowNextGo(false)
			end

			local var_49_1 = 67
			local var_49_2 = 4.4
			local var_49_3 = arg_46_1:GetWordFromCfg(114282008)
			local var_49_4 = arg_46_1:FormatText(var_49_3.content)
			local var_49_5, var_49_6 = arg_46_1:GetPercentByPara(var_49_4, 5)

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

			local var_49_8 = 4.4
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
			local var_49_12 = 15.627
			local var_49_13 = manager.audio:GetVoiceLength("story_v_out_114282", "114282012", "story_v_out_114282.awb") / 1000

			if var_49_13 > 0 and var_49_12 < var_49_13 and var_49_13 + var_49_11 > arg_46_1.duration_ then
				local var_49_14 = var_49_13

				arg_46_1.duration_ = var_49_13 + var_49_11
			end

			if var_49_11 < arg_46_1.time_ and arg_46_1.time_ <= var_49_11 + arg_49_0 then
				local var_49_15 = "play"
				local var_49_16 = "voice"

				arg_46_1:AudioAction(var_49_15, var_49_16, "story_v_out_114282", "114282012", "story_v_out_114282.awb")
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play114282013 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 114282013
		arg_50_1.duration_ = 2.15

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play114282014(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = 0

			if var_53_0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_0 + arg_53_0 then
				arg_50_1.fswbg_:SetActive(true)
				arg_50_1.dialog_:SetActive(false)

				arg_50_1.fswtw_.percent = 0

				local var_53_1 = arg_50_1:GetWordFromCfg(114282013)
				local var_53_2 = arg_50_1:FormatText(var_53_1.content)

				arg_50_1.fswt_.text = var_53_2

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.fswt_)

				arg_50_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_50_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_50_1.fswtw_:SetDirty()

				arg_50_1.typewritterCharCountI18N = 0

				SetActive(arg_50_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_50_1:ShowNextGo(false)
			end

			local var_53_3 = 0.0166666666666667

			if var_53_3 < arg_50_1.time_ and arg_50_1.time_ <= var_53_3 + arg_53_0 then
				arg_50_1.var_.oldValueTypewriter = arg_50_1.fswtw_.percent

				SetActive(arg_50_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_50_1:ShowNextGo(false)
			end

			local var_53_4 = 32
			local var_53_5 = 2.13333333333333
			local var_53_6 = arg_50_1:GetWordFromCfg(114282013)
			local var_53_7 = arg_50_1:FormatText(var_53_6.content)
			local var_53_8, var_53_9 = arg_50_1:GetPercentByPara(var_53_7, 1)

			if var_53_3 < arg_50_1.time_ and arg_50_1.time_ <= var_53_3 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0

				local var_53_10 = var_53_4 <= 0 and var_53_5 or var_53_5 * ((var_53_9 - arg_50_1.typewritterCharCountI18N) / var_53_4)

				if var_53_10 > 0 and var_53_5 < var_53_10 then
					arg_50_1.talkMaxDuration = var_53_10

					if var_53_10 + var_53_3 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_10 + var_53_3
					end
				end
			end

			local var_53_11 = 2.13333333333333
			local var_53_12 = math.max(var_53_11, arg_50_1.talkMaxDuration)

			if var_53_3 <= arg_50_1.time_ and arg_50_1.time_ < var_53_3 + var_53_12 then
				local var_53_13 = (arg_50_1.time_ - var_53_3) / var_53_12

				arg_50_1.fswtw_.percent = Mathf.Lerp(arg_50_1.var_.oldValueTypewriter, var_53_8, var_53_13)
				arg_50_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_50_1.fswtw_:SetDirty()
			end

			if arg_50_1.time_ >= var_53_3 + var_53_12 and arg_50_1.time_ < var_53_3 + var_53_12 + arg_53_0 then
				arg_50_1.fswtw_.percent = var_53_8

				arg_50_1.fswtw_:SetDirty()
				arg_50_1:ShowNextGo(true)

				arg_50_1.typewritterCharCountI18N = var_53_9
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play114282014 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 114282014
		arg_54_1.duration_ = 4.93

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play114282015(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = 0

			if var_57_0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_0 + arg_57_0 then
				arg_54_1.var_.oldValueTypewriter = arg_54_1.fswtw_.percent

				SetActive(arg_54_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_54_1:ShowNextGo(false)
			end

			local var_57_1 = 11
			local var_57_2 = 0.733333333333333
			local var_57_3 = arg_54_1:GetWordFromCfg(114282013)
			local var_57_4 = arg_54_1:FormatText(var_57_3.content)
			local var_57_5, var_57_6 = arg_54_1:GetPercentByPara(var_57_4, 2)

			if var_57_0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_0 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0

				local var_57_7 = var_57_1 <= 0 and var_57_2 or var_57_2 * ((var_57_6 - arg_54_1.typewritterCharCountI18N) / var_57_1)

				if var_57_7 > 0 and var_57_2 < var_57_7 then
					arg_54_1.talkMaxDuration = var_57_7

					if var_57_7 + var_57_0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_7 + var_57_0
					end
				end
			end

			local var_57_8 = 0.733333333333333
			local var_57_9 = math.max(var_57_8, arg_54_1.talkMaxDuration)

			if var_57_0 <= arg_54_1.time_ and arg_54_1.time_ < var_57_0 + var_57_9 then
				local var_57_10 = (arg_54_1.time_ - var_57_0) / var_57_9

				arg_54_1.fswtw_.percent = Mathf.Lerp(arg_54_1.var_.oldValueTypewriter, var_57_5, var_57_10)
				arg_54_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_54_1.fswtw_:SetDirty()
			end

			if arg_54_1.time_ >= var_57_0 + var_57_9 and arg_54_1.time_ < var_57_0 + var_57_9 + arg_57_0 then
				arg_54_1.fswtw_.percent = var_57_5

				arg_54_1.fswtw_:SetDirty()
				arg_54_1:ShowNextGo(true)

				arg_54_1.typewritterCharCountI18N = var_57_6
			end

			local var_57_11 = 0
			local var_57_12 = 4.927
			local var_57_13 = manager.audio:GetVoiceLength("story_v_out_114282", "114282014", "story_v_out_114282.awb") / 1000

			if var_57_13 > 0 and var_57_12 < var_57_13 and var_57_13 + var_57_11 > arg_54_1.duration_ then
				local var_57_14 = var_57_13

				arg_54_1.duration_ = var_57_13 + var_57_11
			end

			if var_57_11 < arg_54_1.time_ and arg_54_1.time_ <= var_57_11 + arg_57_0 then
				local var_57_15 = "play"
				local var_57_16 = "voice"

				arg_54_1:AudioAction(var_57_15, var_57_16, "story_v_out_114282", "114282014", "story_v_out_114282.awb")
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play114282015 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 114282015
		arg_58_1.duration_ = 2.47

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play114282016(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = 0

			if var_61_0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_0 + arg_61_0 then
				arg_58_1.var_.oldValueTypewriter = arg_58_1.fswtw_.percent

				SetActive(arg_58_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_58_1:ShowNextGo(false)
			end

			local var_61_1 = 37
			local var_61_2 = 2.46666666666667
			local var_61_3 = arg_58_1:GetWordFromCfg(114282013)
			local var_61_4 = arg_58_1:FormatText(var_61_3.content)
			local var_61_5, var_61_6 = arg_58_1:GetPercentByPara(var_61_4, 3)

			if var_61_0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_0 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0

				local var_61_7 = var_61_1 <= 0 and var_61_2 or var_61_2 * ((var_61_6 - arg_58_1.typewritterCharCountI18N) / var_61_1)

				if var_61_7 > 0 and var_61_2 < var_61_7 then
					arg_58_1.talkMaxDuration = var_61_7

					if var_61_7 + var_61_0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_7 + var_61_0
					end
				end
			end

			local var_61_8 = 2.46666666666667
			local var_61_9 = math.max(var_61_8, arg_58_1.talkMaxDuration)

			if var_61_0 <= arg_58_1.time_ and arg_58_1.time_ < var_61_0 + var_61_9 then
				local var_61_10 = (arg_58_1.time_ - var_61_0) / var_61_9

				arg_58_1.fswtw_.percent = Mathf.Lerp(arg_58_1.var_.oldValueTypewriter, var_61_5, var_61_10)
				arg_58_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_58_1.fswtw_:SetDirty()
			end

			if arg_58_1.time_ >= var_61_0 + var_61_9 and arg_58_1.time_ < var_61_0 + var_61_9 + arg_61_0 then
				arg_58_1.fswtw_.percent = var_61_5

				arg_58_1.fswtw_:SetDirty()
				arg_58_1:ShowNextGo(true)

				arg_58_1.typewritterCharCountI18N = var_61_6
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play114282016 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 114282016
		arg_62_1.duration_ = 2.53

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play114282017(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = 0

			if var_65_0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_0 + arg_65_0 then
				arg_62_1.var_.oldValueTypewriter = arg_62_1.fswtw_.percent

				SetActive(arg_62_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_62_1:ShowNextGo(false)
			end

			local var_65_1 = 38
			local var_65_2 = 2.53333333333333
			local var_65_3 = arg_62_1:GetWordFromCfg(114282013)
			local var_65_4 = arg_62_1:FormatText(var_65_3.content)
			local var_65_5, var_65_6 = arg_62_1:GetPercentByPara(var_65_4, 4)

			if var_65_0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_0 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0

				local var_65_7 = var_65_1 <= 0 and var_65_2 or var_65_2 * ((var_65_6 - arg_62_1.typewritterCharCountI18N) / var_65_1)

				if var_65_7 > 0 and var_65_2 < var_65_7 then
					arg_62_1.talkMaxDuration = var_65_7

					if var_65_7 + var_65_0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_7 + var_65_0
					end
				end
			end

			local var_65_8 = 2.53333333333333
			local var_65_9 = math.max(var_65_8, arg_62_1.talkMaxDuration)

			if var_65_0 <= arg_62_1.time_ and arg_62_1.time_ < var_65_0 + var_65_9 then
				local var_65_10 = (arg_62_1.time_ - var_65_0) / var_65_9

				arg_62_1.fswtw_.percent = Mathf.Lerp(arg_62_1.var_.oldValueTypewriter, var_65_5, var_65_10)
				arg_62_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_62_1.fswtw_:SetDirty()
			end

			if arg_62_1.time_ >= var_65_0 + var_65_9 and arg_62_1.time_ < var_65_0 + var_65_9 + arg_65_0 then
				arg_62_1.fswtw_.percent = var_65_5

				arg_62_1.fswtw_:SetDirty()
				arg_62_1:ShowNextGo(true)

				arg_62_1.typewritterCharCountI18N = var_65_6
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play114282017 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 114282017
		arg_66_1.duration_ = 3.93

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play114282018(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = 0

			if var_69_0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_0 + arg_69_0 then
				arg_66_1.var_.oldValueTypewriter = arg_66_1.fswtw_.percent

				SetActive(arg_66_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_66_1:ShowNextGo(false)
			end

			local var_69_1 = 59
			local var_69_2 = 3.93333333333333
			local var_69_3 = arg_66_1:GetWordFromCfg(114282013)
			local var_69_4 = arg_66_1:FormatText(var_69_3.content)
			local var_69_5, var_69_6 = arg_66_1:GetPercentByPara(var_69_4, 5)

			if var_69_0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_0 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0

				local var_69_7 = var_69_1 <= 0 and var_69_2 or var_69_2 * ((var_69_6 - arg_66_1.typewritterCharCountI18N) / var_69_1)

				if var_69_7 > 0 and var_69_2 < var_69_7 then
					arg_66_1.talkMaxDuration = var_69_7

					if var_69_7 + var_69_0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_7 + var_69_0
					end
				end
			end

			local var_69_8 = 3.93333333333333
			local var_69_9 = math.max(var_69_8, arg_66_1.talkMaxDuration)

			if var_69_0 <= arg_66_1.time_ and arg_66_1.time_ < var_69_0 + var_69_9 then
				local var_69_10 = (arg_66_1.time_ - var_69_0) / var_69_9

				arg_66_1.fswtw_.percent = Mathf.Lerp(arg_66_1.var_.oldValueTypewriter, var_69_5, var_69_10)
				arg_66_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_66_1.fswtw_:SetDirty()
			end

			if arg_66_1.time_ >= var_69_0 + var_69_9 and arg_66_1.time_ < var_69_0 + var_69_9 + arg_69_0 then
				arg_66_1.fswtw_.percent = var_69_5

				arg_66_1.fswtw_:SetDirty()
				arg_66_1:ShowNextGo(true)

				arg_66_1.typewritterCharCountI18N = var_69_6
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play114282018 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 114282018
		arg_70_1.duration_ = 14.12

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play114282019(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = 0

			if var_73_0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_0 + arg_73_0 then
				arg_70_1.var_.oldValueTypewriter = arg_70_1.fswtw_.percent

				SetActive(arg_70_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_70_1:ShowNextGo(false)
			end

			local var_73_1 = 55
			local var_73_2 = 3.66666666666667
			local var_73_3 = arg_70_1:GetWordFromCfg(114282013)
			local var_73_4 = arg_70_1:FormatText(var_73_3.content)
			local var_73_5, var_73_6 = arg_70_1:GetPercentByPara(var_73_4, 6)

			if var_73_0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_0 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0

				local var_73_7 = var_73_1 <= 0 and var_73_2 or var_73_2 * ((var_73_6 - arg_70_1.typewritterCharCountI18N) / var_73_1)

				if var_73_7 > 0 and var_73_2 < var_73_7 then
					arg_70_1.talkMaxDuration = var_73_7

					if var_73_7 + var_73_0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_7 + var_73_0
					end
				end
			end

			local var_73_8 = 3.66666666666667
			local var_73_9 = math.max(var_73_8, arg_70_1.talkMaxDuration)

			if var_73_0 <= arg_70_1.time_ and arg_70_1.time_ < var_73_0 + var_73_9 then
				local var_73_10 = (arg_70_1.time_ - var_73_0) / var_73_9

				arg_70_1.fswtw_.percent = Mathf.Lerp(arg_70_1.var_.oldValueTypewriter, var_73_5, var_73_10)
				arg_70_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_70_1.fswtw_:SetDirty()
			end

			if arg_70_1.time_ >= var_73_0 + var_73_9 and arg_70_1.time_ < var_73_0 + var_73_9 + arg_73_0 then
				arg_70_1.fswtw_.percent = var_73_5

				arg_70_1.fswtw_:SetDirty()
				arg_70_1:ShowNextGo(true)

				arg_70_1.typewritterCharCountI18N = var_73_6
			end

			local var_73_11 = 0
			local var_73_12 = 14.12
			local var_73_13 = manager.audio:GetVoiceLength("story_v_out_114282", "114282018", "story_v_out_114282.awb") / 1000

			if var_73_13 > 0 and var_73_12 < var_73_13 and var_73_13 + var_73_11 > arg_70_1.duration_ then
				local var_73_14 = var_73_13

				arg_70_1.duration_ = var_73_13 + var_73_11
			end

			if var_73_11 < arg_70_1.time_ and arg_70_1.time_ <= var_73_11 + arg_73_0 then
				local var_73_15 = "play"
				local var_73_16 = "voice"

				arg_70_1:AudioAction(var_73_15, var_73_16, "story_v_out_114282", "114282018", "story_v_out_114282.awb")
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play114282019 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 114282019
		arg_74_1.duration_ = 5.03

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play114282020(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0

			if var_77_0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_0 + arg_77_0 then
				arg_74_1.var_.oldValueTypewriter = arg_74_1.fswtw_.percent

				SetActive(arg_74_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_74_1:ShowNextGo(false)
			end

			local var_77_1 = 26
			local var_77_2 = 1.73333333333333
			local var_77_3 = arg_74_1:GetWordFromCfg(114282013)
			local var_77_4 = arg_74_1:FormatText(var_77_3.content)
			local var_77_5, var_77_6 = arg_74_1:GetPercentByPara(var_77_4, 7)

			if var_77_0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0

				local var_77_7 = var_77_1 <= 0 and var_77_2 or var_77_2 * ((var_77_6 - arg_74_1.typewritterCharCountI18N) / var_77_1)

				if var_77_7 > 0 and var_77_2 < var_77_7 then
					arg_74_1.talkMaxDuration = var_77_7

					if var_77_7 + var_77_0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_7 + var_77_0
					end
				end
			end

			local var_77_8 = 1.73333333333333
			local var_77_9 = math.max(var_77_8, arg_74_1.talkMaxDuration)

			if var_77_0 <= arg_74_1.time_ and arg_74_1.time_ < var_77_0 + var_77_9 then
				local var_77_10 = (arg_74_1.time_ - var_77_0) / var_77_9

				arg_74_1.fswtw_.percent = Mathf.Lerp(arg_74_1.var_.oldValueTypewriter, var_77_5, var_77_10)
				arg_74_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_74_1.fswtw_:SetDirty()
			end

			if arg_74_1.time_ >= var_77_0 + var_77_9 and arg_74_1.time_ < var_77_0 + var_77_9 + arg_77_0 then
				arg_74_1.fswtw_.percent = var_77_5

				arg_74_1.fswtw_:SetDirty()
				arg_74_1:ShowNextGo(true)

				arg_74_1.typewritterCharCountI18N = var_77_6
			end

			local var_77_11 = 0
			local var_77_12 = 5.026
			local var_77_13 = manager.audio:GetVoiceLength("story_v_out_114282", "114282019", "story_v_out_114282.awb") / 1000

			if var_77_13 > 0 and var_77_12 < var_77_13 and var_77_13 + var_77_11 > arg_74_1.duration_ then
				local var_77_14 = var_77_13

				arg_74_1.duration_ = var_77_13 + var_77_11
			end

			if var_77_11 < arg_74_1.time_ and arg_74_1.time_ <= var_77_11 + arg_77_0 then
				local var_77_15 = "play"
				local var_77_16 = "voice"

				arg_74_1:AudioAction(var_77_15, var_77_16, "story_v_out_114282", "114282019", "story_v_out_114282.awb")
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play114282020 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 114282020
		arg_78_1.duration_ = 6.7

		local var_78_0 = {
			ja = 6.633,
			ko = 6.3,
			zh = 6.7,
			en = 6.266
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
				arg_78_0:Play114282021(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = "10023"

			if arg_78_1.actors_[var_81_0] == nil then
				local var_81_1 = Object.Instantiate(arg_78_1.imageGo_, arg_78_1.canvasGo_.transform)

				var_81_1.transform:SetSiblingIndex(1)

				var_81_1.name = var_81_0

				local var_81_2 = var_81_1:GetComponent(typeof(Image))

				var_81_2.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "10023")

				var_81_2:SetNativeSize()

				var_81_1.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_78_1.actors_[var_81_0] = var_81_1
			end

			local var_81_3 = arg_78_1.actors_["10023"].transform
			local var_81_4 = 3.8

			if var_81_4 < arg_78_1.time_ and arg_78_1.time_ <= var_81_4 + arg_81_0 then
				arg_78_1.var_.moveOldPos10023 = var_81_3.localPosition
				var_81_3.localScale = Vector3.New(1, 1, 1)

				arg_78_1:CheckSpriteTmpPos("10023", 2)
			end

			local var_81_5 = 0.001

			if var_81_4 <= arg_78_1.time_ and arg_78_1.time_ < var_81_4 + var_81_5 then
				local var_81_6 = (arg_78_1.time_ - var_81_4) / var_81_5
				local var_81_7 = Vector3.New(-390, -350, -180)

				var_81_3.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos10023, var_81_7, var_81_6)
			end

			if arg_78_1.time_ >= var_81_4 + var_81_5 and arg_78_1.time_ < var_81_4 + var_81_5 + arg_81_0 then
				var_81_3.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_81_8 = arg_78_1.actors_["10023"]
			local var_81_9 = 3.8

			if var_81_9 < arg_78_1.time_ and arg_78_1.time_ <= var_81_9 + arg_81_0 and not isNil(var_81_8) then
				local var_81_10 = var_81_8:GetComponent("Image")

				if var_81_10 then
					arg_78_1.var_.highlightMatValue10023 = var_81_10
				end
			end

			local var_81_11 = 0.034

			if var_81_9 <= arg_78_1.time_ and arg_78_1.time_ < var_81_9 + var_81_11 and not isNil(var_81_8) then
				local var_81_12 = (arg_78_1.time_ - var_81_9) / var_81_11

				if arg_78_1.var_.highlightMatValue10023 then
					local var_81_13 = Mathf.Lerp(0.5, 1, var_81_12)
					local var_81_14 = arg_78_1.var_.highlightMatValue10023
					local var_81_15 = var_81_14.color

					var_81_15.r = var_81_13
					var_81_15.g = var_81_13
					var_81_15.b = var_81_13
					var_81_14.color = var_81_15
				end
			end

			if arg_78_1.time_ >= var_81_9 + var_81_11 and arg_78_1.time_ < var_81_9 + var_81_11 + arg_81_0 and not isNil(var_81_8) and arg_78_1.var_.highlightMatValue10023 then
				local var_81_16 = 1

				var_81_8.transform:SetSiblingIndex(1)

				local var_81_17 = arg_78_1.var_.highlightMatValue10023
				local var_81_18 = var_81_17.color

				var_81_18.r = var_81_16
				var_81_18.g = var_81_16
				var_81_18.b = var_81_16
				var_81_17.color = var_81_18
			end

			local var_81_19 = 1.98333333333333

			if var_81_19 < arg_78_1.time_ and arg_78_1.time_ <= var_81_19 + arg_81_0 then
				arg_78_1.fswbg_:SetActive(false)
				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_78_1:ShowNextGo(false)
			end

			local var_81_20 = arg_78_1.actors_["10023"]
			local var_81_21 = 3.8

			if var_81_21 < arg_78_1.time_ and arg_78_1.time_ <= var_81_21 + arg_81_0 then
				local var_81_22 = var_81_20:GetComponent("Image")

				if var_81_22 then
					arg_78_1.var_.alphaMatValue10023 = var_81_22
					arg_78_1.var_.alphaOldValue10023 = var_81_22.color.a
				end

				arg_78_1.var_.alphaOldValue10023 = 0
			end

			local var_81_23 = 0.5

			if var_81_21 <= arg_78_1.time_ and arg_78_1.time_ < var_81_21 + var_81_23 then
				local var_81_24 = (arg_78_1.time_ - var_81_21) / var_81_23
				local var_81_25 = Mathf.Lerp(arg_78_1.var_.alphaOldValue10023, 1, var_81_24)

				if arg_78_1.var_.alphaMatValue10023 then
					local var_81_26 = arg_78_1.var_.alphaMatValue10023.color

					var_81_26.a = var_81_25
					arg_78_1.var_.alphaMatValue10023.color = var_81_26
				end
			end

			if arg_78_1.time_ >= var_81_21 + var_81_23 and arg_78_1.time_ < var_81_21 + var_81_23 + arg_81_0 and arg_78_1.var_.alphaMatValue10023 then
				local var_81_27 = arg_78_1.var_.alphaMatValue10023
				local var_81_28 = var_81_27.color

				var_81_28.a = 1
				var_81_27.color = var_81_28
			end

			local var_81_29 = 0

			if var_81_29 < arg_78_1.time_ and arg_78_1.time_ <= var_81_29 + arg_81_0 then
				arg_78_1.mask_.enabled = true
				arg_78_1.mask_.raycastTarget = true

				arg_78_1:SetGaussion(false)
			end

			local var_81_30 = 2

			if var_81_29 <= arg_78_1.time_ and arg_78_1.time_ < var_81_29 + var_81_30 then
				local var_81_31 = (arg_78_1.time_ - var_81_29) / var_81_30
				local var_81_32 = Color.New(0, 0, 0)

				var_81_32.a = Mathf.Lerp(0, 1, var_81_31)
				arg_78_1.mask_.color = var_81_32
			end

			if arg_78_1.time_ >= var_81_29 + var_81_30 and arg_78_1.time_ < var_81_29 + var_81_30 + arg_81_0 then
				local var_81_33 = Color.New(0, 0, 0)

				var_81_33.a = 1
				arg_78_1.mask_.color = var_81_33
			end

			local var_81_34 = 2

			if var_81_34 < arg_78_1.time_ and arg_78_1.time_ <= var_81_34 + arg_81_0 then
				arg_78_1.mask_.enabled = true
				arg_78_1.mask_.raycastTarget = true

				arg_78_1:SetGaussion(false)
			end

			local var_81_35 = 2

			if var_81_34 <= arg_78_1.time_ and arg_78_1.time_ < var_81_34 + var_81_35 then
				local var_81_36 = (arg_78_1.time_ - var_81_34) / var_81_35
				local var_81_37 = Color.New(0, 0, 0)

				var_81_37.a = Mathf.Lerp(1, 0, var_81_36)
				arg_78_1.mask_.color = var_81_37
			end

			if arg_78_1.time_ >= var_81_34 + var_81_35 and arg_78_1.time_ < var_81_34 + var_81_35 + arg_81_0 then
				local var_81_38 = Color.New(0, 0, 0)
				local var_81_39 = 0

				arg_78_1.mask_.enabled = false
				var_81_38.a = var_81_39
				arg_78_1.mask_.color = var_81_38
			end

			local var_81_40 = "F04"

			if arg_78_1.bgs_[var_81_40] == nil then
				local var_81_41 = Object.Instantiate(arg_78_1.paintGo_)

				var_81_41:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_81_40)
				var_81_41.name = var_81_40
				var_81_41.transform.parent = arg_78_1.stage_.transform
				var_81_41.transform.localPosition = Vector3.New(0, 100, 0)
				arg_78_1.bgs_[var_81_40] = var_81_41
			end

			local var_81_42 = 2

			if var_81_42 < arg_78_1.time_ and arg_78_1.time_ <= var_81_42 + arg_81_0 then
				local var_81_43 = manager.ui.mainCamera.transform.localPosition
				local var_81_44 = Vector3.New(0, 0, 10) + Vector3.New(var_81_43.x, var_81_43.y, 0)
				local var_81_45 = arg_78_1.bgs_.F04

				var_81_45.transform.localPosition = var_81_44
				var_81_45.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_81_46 = var_81_45:GetComponent("SpriteRenderer")

				if var_81_46 and var_81_46.sprite then
					local var_81_47 = (var_81_45.transform.localPosition - var_81_43).z
					local var_81_48 = manager.ui.mainCameraCom_
					local var_81_49 = 2 * var_81_47 * Mathf.Tan(var_81_48.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_81_50 = var_81_49 * var_81_48.aspect
					local var_81_51 = var_81_46.sprite.bounds.size.x
					local var_81_52 = var_81_46.sprite.bounds.size.y
					local var_81_53 = var_81_50 / var_81_51
					local var_81_54 = var_81_49 / var_81_52
					local var_81_55 = var_81_54 < var_81_53 and var_81_53 or var_81_54

					var_81_45.transform.localScale = Vector3.New(var_81_55, var_81_55, 0)
				end

				for iter_81_0, iter_81_1 in pairs(arg_78_1.bgs_) do
					if iter_81_0 ~= "F04" then
						iter_81_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_81_56 = 2
			local var_81_57 = 2.63333333333333

			if var_81_56 < arg_78_1.time_ and arg_78_1.time_ <= var_81_56 + arg_81_0 then
				local var_81_58 = "play"
				local var_81_59 = "music"

				arg_78_1:AudioAction(var_81_58, var_81_59, "bgm_activity_1_3_story_outdoor", "bgm_activity_1_3_story_outdoor", "bgm_activity_1_3_story_outdoor.awb")

				local var_81_60 = ""
				local var_81_61 = manager.audio:GetAudioName("bgm_activity_1_3_story_outdoor", "bgm_activity_1_3_story_outdoor")

				if var_81_61 ~= "" then
					if arg_78_1.bgmTxt_.text ~= var_81_61 and arg_78_1.bgmTxt_.text ~= "" then
						if arg_78_1.bgmTxt2_.text ~= "" then
							arg_78_1.bgmTxt_.text = arg_78_1.bgmTxt2_.text
						end

						arg_78_1.bgmTxt2_.text = var_81_61

						arg_78_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_78_1.bgmTxt_.text = var_81_61
						arg_78_1.bgmTxt2_.text = var_81_61
					end

					if arg_78_1.bgmTimer then
						arg_78_1.bgmTimer:Stop()

						arg_78_1.bgmTimer = nil
					end

					if arg_78_1.settingData.show_music_name == 1 then
						arg_78_1.musicController:SetSelectedState("show")
						arg_78_1.musicAnimator_:Play("open", 0, 0)

						if arg_78_1.settingData.music_time ~= 0 then
							arg_78_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_78_1.settingData.music_time), function()
								if arg_78_1 == nil or isNil(arg_78_1.bgmTxt_) then
									return
								end

								arg_78_1.musicController:SetSelectedState("hide")
								arg_78_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_78_1.frameCnt_ <= 1 then
				arg_78_1.dialog_:SetActive(false)
			end

			local var_81_62 = 4
			local var_81_63 = 0.225

			if var_81_62 < arg_78_1.time_ and arg_78_1.time_ <= var_81_62 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0

				arg_78_1.dialog_:SetActive(true)

				arg_78_1.dialogCg_.alpha = 0

				local var_81_64 = LeanTween.value(arg_78_1.dialog_, 0, 1, 0.3)

				var_81_64:setOnUpdate(LuaHelper.FloatAction(function(arg_83_0)
					arg_78_1.dialogCg_.alpha = arg_83_0
				end))
				var_81_64:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_78_1.dialog_)
					var_81_64:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_78_1.duration_ = arg_78_1.duration_ + 0.3

				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_65 = arg_78_1:FormatText(StoryNameCfg[259].name)

				arg_78_1.leftNameTxt_.text = var_81_65

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_66 = arg_78_1:GetWordFromCfg(114282020)
				local var_81_67 = arg_78_1:FormatText(var_81_66.content)

				arg_78_1.text_.text = var_81_67

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_68 = 9
				local var_81_69 = utf8.len(var_81_67)
				local var_81_70 = var_81_68 <= 0 and var_81_63 or var_81_63 * (var_81_69 / var_81_68)

				if var_81_70 > 0 and var_81_63 < var_81_70 then
					arg_78_1.talkMaxDuration = var_81_70
					var_81_62 = var_81_62 + 0.3

					if var_81_70 + var_81_62 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_70 + var_81_62
					end
				end

				arg_78_1.text_.text = var_81_67
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114282", "114282020", "story_v_out_114282.awb") ~= 0 then
					local var_81_71 = manager.audio:GetVoiceLength("story_v_out_114282", "114282020", "story_v_out_114282.awb") / 1000

					if var_81_71 + var_81_62 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_71 + var_81_62
					end

					if var_81_66.prefab_name ~= "" and arg_78_1.actors_[var_81_66.prefab_name] ~= nil then
						local var_81_72 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_66.prefab_name].transform, "story_v_out_114282", "114282020", "story_v_out_114282.awb")

						arg_78_1:RecordAudio("114282020", var_81_72)
						arg_78_1:RecordAudio("114282020", var_81_72)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_114282", "114282020", "story_v_out_114282.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_114282", "114282020", "story_v_out_114282.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_73 = var_81_62 + 0.3
			local var_81_74 = math.max(var_81_63, arg_78_1.talkMaxDuration)

			if var_81_73 <= arg_78_1.time_ and arg_78_1.time_ < var_81_73 + var_81_74 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_73) / var_81_74

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_73 + var_81_74 and arg_78_1.time_ < var_81_73 + var_81_74 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10023",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_78_1:InitPlayNodeList()
	end,
	Play114282021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 114282021
		arg_85_1.duration_ = 1.63

		local var_85_0 = {
			ja = 1.5,
			ko = 1.3,
			zh = 1.633,
			en = 1.066
		}
		local var_85_1 = manager.audio:GetLocalizationFlag()

		if var_85_0[var_85_1] ~= nil then
			arg_85_1.duration_ = var_85_0[var_85_1]
		end

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play114282022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = "10022"

			if arg_85_1.actors_[var_88_0] == nil then
				local var_88_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10022")

				if not isNil(var_88_1) then
					local var_88_2 = Object.Instantiate(var_88_1, arg_85_1.canvasGo_.transform)

					var_88_2.transform:SetSiblingIndex(1)

					var_88_2.name = var_88_0
					var_88_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_85_1.actors_[var_88_0] = var_88_2

					local var_88_3 = var_88_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_85_1.isInRecall_ then
						for iter_88_0, iter_88_1 in ipairs(var_88_3) do
							iter_88_1.color = arg_85_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_88_4 = arg_85_1.actors_["10022"]
			local var_88_5 = 0

			if var_88_5 < arg_85_1.time_ and arg_85_1.time_ <= var_88_5 + arg_88_0 then
				local var_88_6 = var_88_4:GetComponentInChildren(typeof(CanvasGroup))

				if var_88_6 then
					arg_85_1.var_.alphaOldValue10022 = var_88_6.alpha
					arg_85_1.var_.characterEffect10022 = var_88_6
				end

				arg_85_1.var_.alphaOldValue10022 = 0
			end

			local var_88_7 = 0.5

			if var_88_5 <= arg_85_1.time_ and arg_85_1.time_ < var_88_5 + var_88_7 then
				local var_88_8 = (arg_85_1.time_ - var_88_5) / var_88_7
				local var_88_9 = Mathf.Lerp(arg_85_1.var_.alphaOldValue10022, 1, var_88_8)

				if arg_85_1.var_.characterEffect10022 then
					arg_85_1.var_.characterEffect10022.alpha = var_88_9
				end
			end

			if arg_85_1.time_ >= var_88_5 + var_88_7 and arg_85_1.time_ < var_88_5 + var_88_7 + arg_88_0 and arg_85_1.var_.characterEffect10022 then
				arg_85_1.var_.characterEffect10022.alpha = 1
			end

			local var_88_10 = arg_85_1.actors_["10023"].transform
			local var_88_11 = 0

			if var_88_11 < arg_85_1.time_ and arg_85_1.time_ <= var_88_11 + arg_88_0 then
				arg_85_1.var_.moveOldPos10023 = var_88_10.localPosition
				var_88_10.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("10023", 7)
			end

			local var_88_12 = 0.001

			if var_88_11 <= arg_85_1.time_ and arg_85_1.time_ < var_88_11 + var_88_12 then
				local var_88_13 = (arg_85_1.time_ - var_88_11) / var_88_12
				local var_88_14 = Vector3.New(0, -2000, -180)

				var_88_10.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10023, var_88_14, var_88_13)
			end

			if arg_85_1.time_ >= var_88_11 + var_88_12 and arg_85_1.time_ < var_88_11 + var_88_12 + arg_88_0 then
				var_88_10.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_88_15 = arg_85_1.actors_["10022"].transform
			local var_88_16 = 0

			if var_88_16 < arg_85_1.time_ and arg_85_1.time_ <= var_88_16 + arg_88_0 then
				arg_85_1.var_.moveOldPos10022 = var_88_15.localPosition
				var_88_15.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("10022", 2)

				local var_88_17 = var_88_15.childCount

				for iter_88_2 = 0, var_88_17 - 1 do
					local var_88_18 = var_88_15:GetChild(iter_88_2)

					if var_88_18.name == "split_6" or not string.find(var_88_18.name, "split") then
						var_88_18.gameObject:SetActive(true)
					else
						var_88_18.gameObject:SetActive(false)
					end
				end
			end

			local var_88_19 = 0.001

			if var_88_16 <= arg_85_1.time_ and arg_85_1.time_ < var_88_16 + var_88_19 then
				local var_88_20 = (arg_85_1.time_ - var_88_16) / var_88_19
				local var_88_21 = Vector3.New(-390, -350, -180)

				var_88_15.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10022, var_88_21, var_88_20)
			end

			if arg_85_1.time_ >= var_88_16 + var_88_19 and arg_85_1.time_ < var_88_16 + var_88_19 + arg_88_0 then
				var_88_15.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_88_22 = "10017"

			if arg_85_1.actors_[var_88_22] == nil then
				local var_88_23 = Object.Instantiate(arg_85_1.imageGo_, arg_85_1.canvasGo_.transform)

				var_88_23.transform:SetSiblingIndex(1)

				var_88_23.name = var_88_22

				local var_88_24 = var_88_23:GetComponent(typeof(Image))

				var_88_24.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "10017")

				var_88_24:SetNativeSize()

				var_88_23.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_85_1.actors_[var_88_22] = var_88_23
			end

			local var_88_25 = arg_85_1.actors_["10017"].transform
			local var_88_26 = 0

			if var_88_26 < arg_85_1.time_ and arg_85_1.time_ <= var_88_26 + arg_88_0 then
				arg_85_1.var_.moveOldPos10017 = var_88_25.localPosition
				var_88_25.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("10017", 4)
			end

			local var_88_27 = 0.001

			if var_88_26 <= arg_85_1.time_ and arg_85_1.time_ < var_88_26 + var_88_27 then
				local var_88_28 = (arg_85_1.time_ - var_88_26) / var_88_27
				local var_88_29 = Vector3.New(390, -350, -180)

				var_88_25.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10017, var_88_29, var_88_28)
			end

			if arg_85_1.time_ >= var_88_26 + var_88_27 and arg_85_1.time_ < var_88_26 + var_88_27 + arg_88_0 then
				var_88_25.localPosition = Vector3.New(390, -350, -180)
			end

			local var_88_30 = arg_85_1.actors_["10022"]
			local var_88_31 = 0

			if var_88_31 < arg_85_1.time_ and arg_85_1.time_ <= var_88_31 + arg_88_0 and not isNil(var_88_30) and arg_85_1.var_.actorSpriteComps10022 == nil then
				arg_85_1.var_.actorSpriteComps10022 = var_88_30:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_32 = 0.034

			if var_88_31 <= arg_85_1.time_ and arg_85_1.time_ < var_88_31 + var_88_32 and not isNil(var_88_30) then
				local var_88_33 = (arg_85_1.time_ - var_88_31) / var_88_32

				if arg_85_1.var_.actorSpriteComps10022 then
					for iter_88_3, iter_88_4 in pairs(arg_85_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_88_4 then
							if arg_85_1.isInRecall_ then
								local var_88_34 = Mathf.Lerp(iter_88_4.color.r, arg_85_1.hightColor1.r, var_88_33)
								local var_88_35 = Mathf.Lerp(iter_88_4.color.g, arg_85_1.hightColor1.g, var_88_33)
								local var_88_36 = Mathf.Lerp(iter_88_4.color.b, arg_85_1.hightColor1.b, var_88_33)

								iter_88_4.color = Color.New(var_88_34, var_88_35, var_88_36)
							else
								local var_88_37 = Mathf.Lerp(iter_88_4.color.r, 1, var_88_33)

								iter_88_4.color = Color.New(var_88_37, var_88_37, var_88_37)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= var_88_31 + var_88_32 and arg_85_1.time_ < var_88_31 + var_88_32 + arg_88_0 and not isNil(var_88_30) and arg_85_1.var_.actorSpriteComps10022 then
				for iter_88_5, iter_88_6 in pairs(arg_85_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_88_6 then
						if arg_85_1.isInRecall_ then
							iter_88_6.color = arg_85_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_88_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_85_1.var_.actorSpriteComps10022 = nil
			end

			local var_88_38 = arg_85_1.actors_["10017"]
			local var_88_39 = 0

			if var_88_39 < arg_85_1.time_ and arg_85_1.time_ <= var_88_39 + arg_88_0 and not isNil(var_88_38) then
				local var_88_40 = var_88_38:GetComponent("Image")

				if var_88_40 then
					arg_85_1.var_.highlightMatValue10017 = var_88_40
				end
			end

			local var_88_41 = 0.034

			if var_88_39 <= arg_85_1.time_ and arg_85_1.time_ < var_88_39 + var_88_41 and not isNil(var_88_38) then
				local var_88_42 = (arg_85_1.time_ - var_88_39) / var_88_41

				if arg_85_1.var_.highlightMatValue10017 then
					local var_88_43 = Mathf.Lerp(1, 0.5, var_88_42)
					local var_88_44 = arg_85_1.var_.highlightMatValue10017
					local var_88_45 = var_88_44.color

					var_88_45.r = var_88_43
					var_88_45.g = var_88_43
					var_88_45.b = var_88_43
					var_88_44.color = var_88_45
				end
			end

			if arg_85_1.time_ >= var_88_39 + var_88_41 and arg_85_1.time_ < var_88_39 + var_88_41 + arg_88_0 and not isNil(var_88_38) and arg_85_1.var_.highlightMatValue10017 then
				local var_88_46 = 0.5
				local var_88_47 = arg_85_1.var_.highlightMatValue10017
				local var_88_48 = var_88_47.color

				var_88_48.r = var_88_46
				var_88_48.g = var_88_46
				var_88_48.b = var_88_46
				var_88_47.color = var_88_48
			end

			local var_88_49 = arg_85_1.actors_["10017"]
			local var_88_50 = 0

			if var_88_50 < arg_85_1.time_ and arg_85_1.time_ <= var_88_50 + arg_88_0 then
				local var_88_51 = var_88_49:GetComponent("Image")

				if var_88_51 then
					arg_85_1.var_.alphaMatValue10017 = var_88_51
					arg_85_1.var_.alphaOldValue10017 = var_88_51.color.a
				end

				arg_85_1.var_.alphaOldValue10017 = 0
			end

			local var_88_52 = 0.5

			if var_88_50 <= arg_85_1.time_ and arg_85_1.time_ < var_88_50 + var_88_52 then
				local var_88_53 = (arg_85_1.time_ - var_88_50) / var_88_52
				local var_88_54 = Mathf.Lerp(arg_85_1.var_.alphaOldValue10017, 1, var_88_53)

				if arg_85_1.var_.alphaMatValue10017 then
					local var_88_55 = arg_85_1.var_.alphaMatValue10017.color

					var_88_55.a = var_88_54
					arg_85_1.var_.alphaMatValue10017.color = var_88_55
				end
			end

			if arg_85_1.time_ >= var_88_50 + var_88_52 and arg_85_1.time_ < var_88_50 + var_88_52 + arg_88_0 and arg_85_1.var_.alphaMatValue10017 then
				local var_88_56 = arg_85_1.var_.alphaMatValue10017
				local var_88_57 = var_88_56.color

				var_88_57.a = 1
				var_88_56.color = var_88_57
			end

			local var_88_58 = 0
			local var_88_59 = 0.075

			if var_88_58 < arg_85_1.time_ and arg_85_1.time_ <= var_88_58 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_60 = arg_85_1:FormatText(StoryNameCfg[235].name)

				arg_85_1.leftNameTxt_.text = var_88_60

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_61 = arg_85_1:GetWordFromCfg(114282021)
				local var_88_62 = arg_85_1:FormatText(var_88_61.content)

				arg_85_1.text_.text = var_88_62

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_63 = 3
				local var_88_64 = utf8.len(var_88_62)
				local var_88_65 = var_88_63 <= 0 and var_88_59 or var_88_59 * (var_88_64 / var_88_63)

				if var_88_65 > 0 and var_88_59 < var_88_65 then
					arg_85_1.talkMaxDuration = var_88_65

					if var_88_65 + var_88_58 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_65 + var_88_58
					end
				end

				arg_85_1.text_.text = var_88_62
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114282", "114282021", "story_v_out_114282.awb") ~= 0 then
					local var_88_66 = manager.audio:GetVoiceLength("story_v_out_114282", "114282021", "story_v_out_114282.awb") / 1000

					if var_88_66 + var_88_58 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_66 + var_88_58
					end

					if var_88_61.prefab_name ~= "" and arg_85_1.actors_[var_88_61.prefab_name] ~= nil then
						local var_88_67 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_61.prefab_name].transform, "story_v_out_114282", "114282021", "story_v_out_114282.awb")

						arg_85_1:RecordAudio("114282021", var_88_67)
						arg_85_1:RecordAudio("114282021", var_88_67)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_114282", "114282021", "story_v_out_114282.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_114282", "114282021", "story_v_out_114282.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_68 = math.max(var_88_59, arg_85_1.talkMaxDuration)

			if var_88_58 <= arg_85_1.time_ and arg_85_1.time_ < var_88_58 + var_88_68 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_58) / var_88_68

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_58 + var_88_68 and arg_85_1.time_ < var_88_58 + var_88_68 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10023",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			},
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10017",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play114282022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 114282022
		arg_89_1.duration_ = 1.8

		local var_89_0 = {
			ja = 1.8,
			ko = 1.466,
			zh = 1.633,
			en = 1.5
		}
		local var_89_1 = manager.audio:GetLocalizationFlag()

		if var_89_0[var_89_1] ~= nil then
			arg_89_1.duration_ = var_89_0[var_89_1]
		end

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play114282023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["10022"]
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.actorSpriteComps10022 == nil then
				arg_89_1.var_.actorSpriteComps10022 = var_92_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_2 = 0.034

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 and not isNil(var_92_0) then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2

				if arg_89_1.var_.actorSpriteComps10022 then
					for iter_92_0, iter_92_1 in pairs(arg_89_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_92_1 then
							if arg_89_1.isInRecall_ then
								local var_92_4 = Mathf.Lerp(iter_92_1.color.r, arg_89_1.hightColor2.r, var_92_3)
								local var_92_5 = Mathf.Lerp(iter_92_1.color.g, arg_89_1.hightColor2.g, var_92_3)
								local var_92_6 = Mathf.Lerp(iter_92_1.color.b, arg_89_1.hightColor2.b, var_92_3)

								iter_92_1.color = Color.New(var_92_4, var_92_5, var_92_6)
							else
								local var_92_7 = Mathf.Lerp(iter_92_1.color.r, 0.5, var_92_3)

								iter_92_1.color = Color.New(var_92_7, var_92_7, var_92_7)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.actorSpriteComps10022 then
				for iter_92_2, iter_92_3 in pairs(arg_89_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_92_3 then
						if arg_89_1.isInRecall_ then
							iter_92_3.color = arg_89_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_92_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_89_1.var_.actorSpriteComps10022 = nil
			end

			local var_92_8 = arg_89_1.actors_["10017"]
			local var_92_9 = 0

			if var_92_9 < arg_89_1.time_ and arg_89_1.time_ <= var_92_9 + arg_92_0 and not isNil(var_92_8) then
				local var_92_10 = var_92_8:GetComponent("Image")

				if var_92_10 then
					arg_89_1.var_.highlightMatValue10017 = var_92_10
				end
			end

			local var_92_11 = 0.034

			if var_92_9 <= arg_89_1.time_ and arg_89_1.time_ < var_92_9 + var_92_11 and not isNil(var_92_8) then
				local var_92_12 = (arg_89_1.time_ - var_92_9) / var_92_11

				if arg_89_1.var_.highlightMatValue10017 then
					local var_92_13 = Mathf.Lerp(0.5, 1, var_92_12)
					local var_92_14 = arg_89_1.var_.highlightMatValue10017
					local var_92_15 = var_92_14.color

					var_92_15.r = var_92_13
					var_92_15.g = var_92_13
					var_92_15.b = var_92_13
					var_92_14.color = var_92_15
				end
			end

			if arg_89_1.time_ >= var_92_9 + var_92_11 and arg_89_1.time_ < var_92_9 + var_92_11 + arg_92_0 and not isNil(var_92_8) and arg_89_1.var_.highlightMatValue10017 then
				local var_92_16 = 1

				var_92_8.transform:SetSiblingIndex(1)

				local var_92_17 = arg_89_1.var_.highlightMatValue10017
				local var_92_18 = var_92_17.color

				var_92_18.r = var_92_16
				var_92_18.g = var_92_16
				var_92_18.b = var_92_16
				var_92_17.color = var_92_18
			end

			local var_92_19 = 0
			local var_92_20 = 0.175

			if var_92_19 < arg_89_1.time_ and arg_89_1.time_ <= var_92_19 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_21 = arg_89_1:FormatText(StoryNameCfg[255].name)

				arg_89_1.leftNameTxt_.text = var_92_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_22 = arg_89_1:GetWordFromCfg(114282022)
				local var_92_23 = arg_89_1:FormatText(var_92_22.content)

				arg_89_1.text_.text = var_92_23

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_24 = 7
				local var_92_25 = utf8.len(var_92_23)
				local var_92_26 = var_92_24 <= 0 and var_92_20 or var_92_20 * (var_92_25 / var_92_24)

				if var_92_26 > 0 and var_92_20 < var_92_26 then
					arg_89_1.talkMaxDuration = var_92_26

					if var_92_26 + var_92_19 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_26 + var_92_19
					end
				end

				arg_89_1.text_.text = var_92_23
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114282", "114282022", "story_v_out_114282.awb") ~= 0 then
					local var_92_27 = manager.audio:GetVoiceLength("story_v_out_114282", "114282022", "story_v_out_114282.awb") / 1000

					if var_92_27 + var_92_19 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_27 + var_92_19
					end

					if var_92_22.prefab_name ~= "" and arg_89_1.actors_[var_92_22.prefab_name] ~= nil then
						local var_92_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_22.prefab_name].transform, "story_v_out_114282", "114282022", "story_v_out_114282.awb")

						arg_89_1:RecordAudio("114282022", var_92_28)
						arg_89_1:RecordAudio("114282022", var_92_28)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_114282", "114282022", "story_v_out_114282.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_114282", "114282022", "story_v_out_114282.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_29 = math.max(var_92_20, arg_89_1.talkMaxDuration)

			if var_92_19 <= arg_89_1.time_ and arg_89_1.time_ < var_92_19 + var_92_29 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_19) / var_92_29

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_19 + var_92_29 and arg_89_1.time_ < var_92_19 + var_92_29 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play114282023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 114282023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play114282024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["10017"]
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 and not isNil(var_96_0) then
				local var_96_2 = var_96_0:GetComponent("Image")

				if var_96_2 then
					arg_93_1.var_.highlightMatValue10017 = var_96_2
				end
			end

			local var_96_3 = 0.034

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_3 and not isNil(var_96_0) then
				local var_96_4 = (arg_93_1.time_ - var_96_1) / var_96_3

				if arg_93_1.var_.highlightMatValue10017 then
					local var_96_5 = Mathf.Lerp(1, 0.5, var_96_4)
					local var_96_6 = arg_93_1.var_.highlightMatValue10017
					local var_96_7 = var_96_6.color

					var_96_7.r = var_96_5
					var_96_7.g = var_96_5
					var_96_7.b = var_96_5
					var_96_6.color = var_96_7
				end
			end

			if arg_93_1.time_ >= var_96_1 + var_96_3 and arg_93_1.time_ < var_96_1 + var_96_3 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.highlightMatValue10017 then
				local var_96_8 = 0.5
				local var_96_9 = arg_93_1.var_.highlightMatValue10017
				local var_96_10 = var_96_9.color

				var_96_10.r = var_96_8
				var_96_10.g = var_96_8
				var_96_10.b = var_96_8
				var_96_9.color = var_96_10
			end

			local var_96_11 = arg_93_1.actors_["10022"]
			local var_96_12 = 0

			if var_96_12 < arg_93_1.time_ and arg_93_1.time_ <= var_96_12 + arg_96_0 then
				local var_96_13 = var_96_11:GetComponentInChildren(typeof(CanvasGroup))

				if var_96_13 then
					arg_93_1.var_.alphaOldValue10022 = var_96_13.alpha
					arg_93_1.var_.characterEffect10022 = var_96_13
				end

				arg_93_1.var_.alphaOldValue10022 = 1
			end

			local var_96_14 = 0.5

			if var_96_12 <= arg_93_1.time_ and arg_93_1.time_ < var_96_12 + var_96_14 then
				local var_96_15 = (arg_93_1.time_ - var_96_12) / var_96_14
				local var_96_16 = Mathf.Lerp(arg_93_1.var_.alphaOldValue10022, 0, var_96_15)

				if arg_93_1.var_.characterEffect10022 then
					arg_93_1.var_.characterEffect10022.alpha = var_96_16
				end
			end

			if arg_93_1.time_ >= var_96_12 + var_96_14 and arg_93_1.time_ < var_96_12 + var_96_14 + arg_96_0 and arg_93_1.var_.characterEffect10022 then
				arg_93_1.var_.characterEffect10022.alpha = 0
			end

			local var_96_17 = arg_93_1.actors_["10017"]
			local var_96_18 = 0

			if var_96_18 < arg_93_1.time_ and arg_93_1.time_ <= var_96_18 + arg_96_0 then
				local var_96_19 = var_96_17:GetComponent("Image")

				if var_96_19 then
					arg_93_1.var_.alphaMatValue10017 = var_96_19
					arg_93_1.var_.alphaOldValue10017 = var_96_19.color.a
				end

				arg_93_1.var_.alphaOldValue10017 = 1
			end

			local var_96_20 = 0.5

			if var_96_18 <= arg_93_1.time_ and arg_93_1.time_ < var_96_18 + var_96_20 then
				local var_96_21 = (arg_93_1.time_ - var_96_18) / var_96_20
				local var_96_22 = Mathf.Lerp(arg_93_1.var_.alphaOldValue10017, 0, var_96_21)

				if arg_93_1.var_.alphaMatValue10017 then
					local var_96_23 = arg_93_1.var_.alphaMatValue10017.color

					var_96_23.a = var_96_22
					arg_93_1.var_.alphaMatValue10017.color = var_96_23
				end
			end

			if arg_93_1.time_ >= var_96_18 + var_96_20 and arg_93_1.time_ < var_96_18 + var_96_20 + arg_96_0 and arg_93_1.var_.alphaMatValue10017 then
				local var_96_24 = arg_93_1.var_.alphaMatValue10017
				local var_96_25 = var_96_24.color

				var_96_25.a = 0
				var_96_24.color = var_96_25
			end

			local var_96_26 = 0
			local var_96_27 = 1.05

			if var_96_26 < arg_93_1.time_ and arg_93_1.time_ <= var_96_26 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_28 = arg_93_1:GetWordFromCfg(114282023)
				local var_96_29 = arg_93_1:FormatText(var_96_28.content)

				arg_93_1.text_.text = var_96_29

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_30 = 42
				local var_96_31 = utf8.len(var_96_29)
				local var_96_32 = var_96_30 <= 0 and var_96_27 or var_96_27 * (var_96_31 / var_96_30)

				if var_96_32 > 0 and var_96_27 < var_96_32 then
					arg_93_1.talkMaxDuration = var_96_32

					if var_96_32 + var_96_26 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_32 + var_96_26
					end
				end

				arg_93_1.text_.text = var_96_29
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_33 = math.max(var_96_27, arg_93_1.talkMaxDuration)

			if var_96_26 <= arg_93_1.time_ and arg_93_1.time_ < var_96_26 + var_96_33 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_26) / var_96_33

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_26 + var_96_33 and arg_93_1.time_ < var_96_26 + var_96_33 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play114282024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 114282024
		arg_97_1.duration_ = 3.77

		local var_97_0 = {
			ja = 3.766,
			ko = 2.833,
			zh = 3.333,
			en = 2.9
		}
		local var_97_1 = manager.audio:GetLocalizationFlag()

		if var_97_0[var_97_1] ~= nil then
			arg_97_1.duration_ = var_97_0[var_97_1]
		end

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play114282025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["10023"]
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				local var_100_2 = var_100_0:GetComponent("Image")

				if var_100_2 then
					arg_97_1.var_.alphaMatValue10023 = var_100_2
					arg_97_1.var_.alphaOldValue10023 = var_100_2.color.a
				end

				arg_97_1.var_.alphaOldValue10023 = 0
			end

			local var_100_3 = 0.5

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_3 then
				local var_100_4 = (arg_97_1.time_ - var_100_1) / var_100_3
				local var_100_5 = Mathf.Lerp(arg_97_1.var_.alphaOldValue10023, 1, var_100_4)

				if arg_97_1.var_.alphaMatValue10023 then
					local var_100_6 = arg_97_1.var_.alphaMatValue10023.color

					var_100_6.a = var_100_5
					arg_97_1.var_.alphaMatValue10023.color = var_100_6
				end
			end

			if arg_97_1.time_ >= var_100_1 + var_100_3 and arg_97_1.time_ < var_100_1 + var_100_3 + arg_100_0 and arg_97_1.var_.alphaMatValue10023 then
				local var_100_7 = arg_97_1.var_.alphaMatValue10023
				local var_100_8 = var_100_7.color

				var_100_8.a = 1
				var_100_7.color = var_100_8
			end

			local var_100_9 = arg_97_1.actors_["10023"].transform
			local var_100_10 = 0

			if var_100_10 < arg_97_1.time_ and arg_97_1.time_ <= var_100_10 + arg_100_0 then
				arg_97_1.var_.moveOldPos10023 = var_100_9.localPosition
				var_100_9.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("10023", 2)
			end

			local var_100_11 = 0.001

			if var_100_10 <= arg_97_1.time_ and arg_97_1.time_ < var_100_10 + var_100_11 then
				local var_100_12 = (arg_97_1.time_ - var_100_10) / var_100_11
				local var_100_13 = Vector3.New(-390, -350, -180)

				var_100_9.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10023, var_100_13, var_100_12)
			end

			if arg_97_1.time_ >= var_100_10 + var_100_11 and arg_97_1.time_ < var_100_10 + var_100_11 + arg_100_0 then
				var_100_9.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_100_14 = arg_97_1.actors_["10023"]
			local var_100_15 = 0

			if var_100_15 < arg_97_1.time_ and arg_97_1.time_ <= var_100_15 + arg_100_0 and not isNil(var_100_14) then
				local var_100_16 = var_100_14:GetComponent("Image")

				if var_100_16 then
					arg_97_1.var_.highlightMatValue10023 = var_100_16
				end
			end

			local var_100_17 = 0.034

			if var_100_15 <= arg_97_1.time_ and arg_97_1.time_ < var_100_15 + var_100_17 and not isNil(var_100_14) then
				local var_100_18 = (arg_97_1.time_ - var_100_15) / var_100_17

				if arg_97_1.var_.highlightMatValue10023 then
					local var_100_19 = Mathf.Lerp(0.5, 1, var_100_18)
					local var_100_20 = arg_97_1.var_.highlightMatValue10023
					local var_100_21 = var_100_20.color

					var_100_21.r = var_100_19
					var_100_21.g = var_100_19
					var_100_21.b = var_100_19
					var_100_20.color = var_100_21
				end
			end

			if arg_97_1.time_ >= var_100_15 + var_100_17 and arg_97_1.time_ < var_100_15 + var_100_17 + arg_100_0 and not isNil(var_100_14) and arg_97_1.var_.highlightMatValue10023 then
				local var_100_22 = 1

				var_100_14.transform:SetSiblingIndex(1)

				local var_100_23 = arg_97_1.var_.highlightMatValue10023
				local var_100_24 = var_100_23.color

				var_100_24.r = var_100_22
				var_100_24.g = var_100_22
				var_100_24.b = var_100_22
				var_100_23.color = var_100_24
			end

			local var_100_25 = 0
			local var_100_26 = 0.325

			if var_100_25 < arg_97_1.time_ and arg_97_1.time_ <= var_100_25 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_27 = arg_97_1:FormatText(StoryNameCfg[259].name)

				arg_97_1.leftNameTxt_.text = var_100_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_28 = arg_97_1:GetWordFromCfg(114282024)
				local var_100_29 = arg_97_1:FormatText(var_100_28.content)

				arg_97_1.text_.text = var_100_29

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_30 = 13
				local var_100_31 = utf8.len(var_100_29)
				local var_100_32 = var_100_30 <= 0 and var_100_26 or var_100_26 * (var_100_31 / var_100_30)

				if var_100_32 > 0 and var_100_26 < var_100_32 then
					arg_97_1.talkMaxDuration = var_100_32

					if var_100_32 + var_100_25 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_32 + var_100_25
					end
				end

				arg_97_1.text_.text = var_100_29
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114282", "114282024", "story_v_out_114282.awb") ~= 0 then
					local var_100_33 = manager.audio:GetVoiceLength("story_v_out_114282", "114282024", "story_v_out_114282.awb") / 1000

					if var_100_33 + var_100_25 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_33 + var_100_25
					end

					if var_100_28.prefab_name ~= "" and arg_97_1.actors_[var_100_28.prefab_name] ~= nil then
						local var_100_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_28.prefab_name].transform, "story_v_out_114282", "114282024", "story_v_out_114282.awb")

						arg_97_1:RecordAudio("114282024", var_100_34)
						arg_97_1:RecordAudio("114282024", var_100_34)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_114282", "114282024", "story_v_out_114282.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_114282", "114282024", "story_v_out_114282.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_35 = math.max(var_100_26, arg_97_1.talkMaxDuration)

			if var_100_25 <= arg_97_1.time_ and arg_97_1.time_ < var_100_25 + var_100_35 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_25) / var_100_35

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_25 + var_100_35 and arg_97_1.time_ < var_100_25 + var_100_35 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10023",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play114282025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 114282025
		arg_101_1.duration_ = 9.43

		local var_101_0 = {
			ja = 8.666,
			ko = 6.733,
			zh = 6.3,
			en = 9.433
		}
		local var_101_1 = manager.audio:GetLocalizationFlag()

		if var_101_0[var_101_1] ~= nil then
			arg_101_1.duration_ = var_101_0[var_101_1]
		end

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play114282026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["10017"].transform
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.var_.moveOldPos10017 = var_104_0.localPosition
				var_104_0.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("10017", 4)
			end

			local var_104_2 = 0.001

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2
				local var_104_4 = Vector3.New(390, -350, -180)

				var_104_0.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos10017, var_104_4, var_104_3)
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 then
				var_104_0.localPosition = Vector3.New(390, -350, -180)
			end

			local var_104_5 = arg_101_1.actors_["10023"]
			local var_104_6 = 0

			if var_104_6 < arg_101_1.time_ and arg_101_1.time_ <= var_104_6 + arg_104_0 and not isNil(var_104_5) then
				local var_104_7 = var_104_5:GetComponent("Image")

				if var_104_7 then
					arg_101_1.var_.highlightMatValue10023 = var_104_7
				end
			end

			local var_104_8 = 0.034

			if var_104_6 <= arg_101_1.time_ and arg_101_1.time_ < var_104_6 + var_104_8 and not isNil(var_104_5) then
				local var_104_9 = (arg_101_1.time_ - var_104_6) / var_104_8

				if arg_101_1.var_.highlightMatValue10023 then
					local var_104_10 = Mathf.Lerp(1, 0.5, var_104_9)
					local var_104_11 = arg_101_1.var_.highlightMatValue10023
					local var_104_12 = var_104_11.color

					var_104_12.r = var_104_10
					var_104_12.g = var_104_10
					var_104_12.b = var_104_10
					var_104_11.color = var_104_12
				end
			end

			if arg_101_1.time_ >= var_104_6 + var_104_8 and arg_101_1.time_ < var_104_6 + var_104_8 + arg_104_0 and not isNil(var_104_5) and arg_101_1.var_.highlightMatValue10023 then
				local var_104_13 = 0.5
				local var_104_14 = arg_101_1.var_.highlightMatValue10023
				local var_104_15 = var_104_14.color

				var_104_15.r = var_104_13
				var_104_15.g = var_104_13
				var_104_15.b = var_104_13
				var_104_14.color = var_104_15
			end

			local var_104_16 = arg_101_1.actors_["10017"]
			local var_104_17 = 0

			if var_104_17 < arg_101_1.time_ and arg_101_1.time_ <= var_104_17 + arg_104_0 and not isNil(var_104_16) then
				local var_104_18 = var_104_16:GetComponent("Image")

				if var_104_18 then
					arg_101_1.var_.highlightMatValue10017 = var_104_18
				end
			end

			local var_104_19 = 0.034

			if var_104_17 <= arg_101_1.time_ and arg_101_1.time_ < var_104_17 + var_104_19 and not isNil(var_104_16) then
				local var_104_20 = (arg_101_1.time_ - var_104_17) / var_104_19

				if arg_101_1.var_.highlightMatValue10017 then
					local var_104_21 = Mathf.Lerp(0.5, 1, var_104_20)
					local var_104_22 = arg_101_1.var_.highlightMatValue10017
					local var_104_23 = var_104_22.color

					var_104_23.r = var_104_21
					var_104_23.g = var_104_21
					var_104_23.b = var_104_21
					var_104_22.color = var_104_23
				end
			end

			if arg_101_1.time_ >= var_104_17 + var_104_19 and arg_101_1.time_ < var_104_17 + var_104_19 + arg_104_0 and not isNil(var_104_16) and arg_101_1.var_.highlightMatValue10017 then
				local var_104_24 = 1

				var_104_16.transform:SetSiblingIndex(1)

				local var_104_25 = arg_101_1.var_.highlightMatValue10017
				local var_104_26 = var_104_25.color

				var_104_26.r = var_104_24
				var_104_26.g = var_104_24
				var_104_26.b = var_104_24
				var_104_25.color = var_104_26
			end

			local var_104_27 = arg_101_1.actors_["10017"]
			local var_104_28 = 0

			if var_104_28 < arg_101_1.time_ and arg_101_1.time_ <= var_104_28 + arg_104_0 then
				local var_104_29 = var_104_27:GetComponent("Image")

				if var_104_29 then
					arg_101_1.var_.alphaMatValue10017 = var_104_29
					arg_101_1.var_.alphaOldValue10017 = var_104_29.color.a
				end

				arg_101_1.var_.alphaOldValue10017 = 0
			end

			local var_104_30 = 0.5

			if var_104_28 <= arg_101_1.time_ and arg_101_1.time_ < var_104_28 + var_104_30 then
				local var_104_31 = (arg_101_1.time_ - var_104_28) / var_104_30
				local var_104_32 = Mathf.Lerp(arg_101_1.var_.alphaOldValue10017, 1, var_104_31)

				if arg_101_1.var_.alphaMatValue10017 then
					local var_104_33 = arg_101_1.var_.alphaMatValue10017.color

					var_104_33.a = var_104_32
					arg_101_1.var_.alphaMatValue10017.color = var_104_33
				end
			end

			if arg_101_1.time_ >= var_104_28 + var_104_30 and arg_101_1.time_ < var_104_28 + var_104_30 + arg_104_0 and arg_101_1.var_.alphaMatValue10017 then
				local var_104_34 = arg_101_1.var_.alphaMatValue10017
				local var_104_35 = var_104_34.color

				var_104_35.a = 1
				var_104_34.color = var_104_35
			end

			local var_104_36 = 0
			local var_104_37 = 0.825

			if var_104_36 < arg_101_1.time_ and arg_101_1.time_ <= var_104_36 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_38 = arg_101_1:FormatText(StoryNameCfg[255].name)

				arg_101_1.leftNameTxt_.text = var_104_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_39 = arg_101_1:GetWordFromCfg(114282025)
				local var_104_40 = arg_101_1:FormatText(var_104_39.content)

				arg_101_1.text_.text = var_104_40

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_41 = 33
				local var_104_42 = utf8.len(var_104_40)
				local var_104_43 = var_104_41 <= 0 and var_104_37 or var_104_37 * (var_104_42 / var_104_41)

				if var_104_43 > 0 and var_104_37 < var_104_43 then
					arg_101_1.talkMaxDuration = var_104_43

					if var_104_43 + var_104_36 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_43 + var_104_36
					end
				end

				arg_101_1.text_.text = var_104_40
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114282", "114282025", "story_v_out_114282.awb") ~= 0 then
					local var_104_44 = manager.audio:GetVoiceLength("story_v_out_114282", "114282025", "story_v_out_114282.awb") / 1000

					if var_104_44 + var_104_36 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_44 + var_104_36
					end

					if var_104_39.prefab_name ~= "" and arg_101_1.actors_[var_104_39.prefab_name] ~= nil then
						local var_104_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_39.prefab_name].transform, "story_v_out_114282", "114282025", "story_v_out_114282.awb")

						arg_101_1:RecordAudio("114282025", var_104_45)
						arg_101_1:RecordAudio("114282025", var_104_45)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_114282", "114282025", "story_v_out_114282.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_114282", "114282025", "story_v_out_114282.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_46 = math.max(var_104_37, arg_101_1.talkMaxDuration)

			if var_104_36 <= arg_101_1.time_ and arg_101_1.time_ < var_104_36 + var_104_46 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_36) / var_104_46

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_36 + var_104_46 and arg_101_1.time_ < var_104_36 + var_104_46 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10017",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play114282026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 114282026
		arg_105_1.duration_ = 7.97

		local var_105_0 = {
			ja = 5.266,
			ko = 7.4,
			zh = 6.233,
			en = 7.966
		}
		local var_105_1 = manager.audio:GetLocalizationFlag()

		if var_105_0[var_105_1] ~= nil then
			arg_105_1.duration_ = var_105_0[var_105_1]
		end

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play114282027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["10023"]
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 and not isNil(var_108_0) then
				local var_108_2 = var_108_0:GetComponent("Image")

				if var_108_2 then
					arg_105_1.var_.highlightMatValue10023 = var_108_2
				end
			end

			local var_108_3 = 0.034

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_3 and not isNil(var_108_0) then
				local var_108_4 = (arg_105_1.time_ - var_108_1) / var_108_3

				if arg_105_1.var_.highlightMatValue10023 then
					local var_108_5 = Mathf.Lerp(0.5, 1, var_108_4)
					local var_108_6 = arg_105_1.var_.highlightMatValue10023
					local var_108_7 = var_108_6.color

					var_108_7.r = var_108_5
					var_108_7.g = var_108_5
					var_108_7.b = var_108_5
					var_108_6.color = var_108_7
				end
			end

			if arg_105_1.time_ >= var_108_1 + var_108_3 and arg_105_1.time_ < var_108_1 + var_108_3 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.highlightMatValue10023 then
				local var_108_8 = 1

				var_108_0.transform:SetSiblingIndex(1)

				local var_108_9 = arg_105_1.var_.highlightMatValue10023
				local var_108_10 = var_108_9.color

				var_108_10.r = var_108_8
				var_108_10.g = var_108_8
				var_108_10.b = var_108_8
				var_108_9.color = var_108_10
			end

			local var_108_11 = arg_105_1.actors_["10017"]
			local var_108_12 = 0

			if var_108_12 < arg_105_1.time_ and arg_105_1.time_ <= var_108_12 + arg_108_0 and not isNil(var_108_11) then
				local var_108_13 = var_108_11:GetComponent("Image")

				if var_108_13 then
					arg_105_1.var_.highlightMatValue10017 = var_108_13
				end
			end

			local var_108_14 = 0.034

			if var_108_12 <= arg_105_1.time_ and arg_105_1.time_ < var_108_12 + var_108_14 and not isNil(var_108_11) then
				local var_108_15 = (arg_105_1.time_ - var_108_12) / var_108_14

				if arg_105_1.var_.highlightMatValue10017 then
					local var_108_16 = Mathf.Lerp(1, 0.5, var_108_15)
					local var_108_17 = arg_105_1.var_.highlightMatValue10017
					local var_108_18 = var_108_17.color

					var_108_18.r = var_108_16
					var_108_18.g = var_108_16
					var_108_18.b = var_108_16
					var_108_17.color = var_108_18
				end
			end

			if arg_105_1.time_ >= var_108_12 + var_108_14 and arg_105_1.time_ < var_108_12 + var_108_14 + arg_108_0 and not isNil(var_108_11) and arg_105_1.var_.highlightMatValue10017 then
				local var_108_19 = 0.5
				local var_108_20 = arg_105_1.var_.highlightMatValue10017
				local var_108_21 = var_108_20.color

				var_108_21.r = var_108_19
				var_108_21.g = var_108_19
				var_108_21.b = var_108_19
				var_108_20.color = var_108_21
			end

			local var_108_22 = 0
			local var_108_23 = 0.6

			if var_108_22 < arg_105_1.time_ and arg_105_1.time_ <= var_108_22 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_24 = arg_105_1:FormatText(StoryNameCfg[259].name)

				arg_105_1.leftNameTxt_.text = var_108_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_25 = arg_105_1:GetWordFromCfg(114282026)
				local var_108_26 = arg_105_1:FormatText(var_108_25.content)

				arg_105_1.text_.text = var_108_26

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_27 = 24
				local var_108_28 = utf8.len(var_108_26)
				local var_108_29 = var_108_27 <= 0 and var_108_23 or var_108_23 * (var_108_28 / var_108_27)

				if var_108_29 > 0 and var_108_23 < var_108_29 then
					arg_105_1.talkMaxDuration = var_108_29

					if var_108_29 + var_108_22 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_29 + var_108_22
					end
				end

				arg_105_1.text_.text = var_108_26
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114282", "114282026", "story_v_out_114282.awb") ~= 0 then
					local var_108_30 = manager.audio:GetVoiceLength("story_v_out_114282", "114282026", "story_v_out_114282.awb") / 1000

					if var_108_30 + var_108_22 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_30 + var_108_22
					end

					if var_108_25.prefab_name ~= "" and arg_105_1.actors_[var_108_25.prefab_name] ~= nil then
						local var_108_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_25.prefab_name].transform, "story_v_out_114282", "114282026", "story_v_out_114282.awb")

						arg_105_1:RecordAudio("114282026", var_108_31)
						arg_105_1:RecordAudio("114282026", var_108_31)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_114282", "114282026", "story_v_out_114282.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_114282", "114282026", "story_v_out_114282.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_32 = math.max(var_108_23, arg_105_1.talkMaxDuration)

			if var_108_22 <= arg_105_1.time_ and arg_105_1.time_ < var_108_22 + var_108_32 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_22) / var_108_32

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_22 + var_108_32 and arg_105_1.time_ < var_108_22 + var_108_32 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play114282027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 114282027
		arg_109_1.duration_ = 5.63

		local var_109_0 = {
			ja = 1.733,
			ko = 5.633,
			zh = 4.4,
			en = 5.566
		}
		local var_109_1 = manager.audio:GetLocalizationFlag()

		if var_109_0[var_109_1] ~= nil then
			arg_109_1.duration_ = var_109_0[var_109_1]
		end

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play114282028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["10023"]
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 and not isNil(var_112_0) then
				local var_112_2 = var_112_0:GetComponent("Image")

				if var_112_2 then
					arg_109_1.var_.highlightMatValue10023 = var_112_2
				end
			end

			local var_112_3 = 0.034

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_3 and not isNil(var_112_0) then
				local var_112_4 = (arg_109_1.time_ - var_112_1) / var_112_3

				if arg_109_1.var_.highlightMatValue10023 then
					local var_112_5 = Mathf.Lerp(1, 0.5, var_112_4)
					local var_112_6 = arg_109_1.var_.highlightMatValue10023
					local var_112_7 = var_112_6.color

					var_112_7.r = var_112_5
					var_112_7.g = var_112_5
					var_112_7.b = var_112_5
					var_112_6.color = var_112_7
				end
			end

			if arg_109_1.time_ >= var_112_1 + var_112_3 and arg_109_1.time_ < var_112_1 + var_112_3 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.highlightMatValue10023 then
				local var_112_8 = 0.5
				local var_112_9 = arg_109_1.var_.highlightMatValue10023
				local var_112_10 = var_112_9.color

				var_112_10.r = var_112_8
				var_112_10.g = var_112_8
				var_112_10.b = var_112_8
				var_112_9.color = var_112_10
			end

			local var_112_11 = arg_109_1.actors_["10017"]
			local var_112_12 = 0

			if var_112_12 < arg_109_1.time_ and arg_109_1.time_ <= var_112_12 + arg_112_0 and not isNil(var_112_11) then
				local var_112_13 = var_112_11:GetComponent("Image")

				if var_112_13 then
					arg_109_1.var_.highlightMatValue10017 = var_112_13
				end
			end

			local var_112_14 = 0.034

			if var_112_12 <= arg_109_1.time_ and arg_109_1.time_ < var_112_12 + var_112_14 and not isNil(var_112_11) then
				local var_112_15 = (arg_109_1.time_ - var_112_12) / var_112_14

				if arg_109_1.var_.highlightMatValue10017 then
					local var_112_16 = Mathf.Lerp(0.5, 1, var_112_15)
					local var_112_17 = arg_109_1.var_.highlightMatValue10017
					local var_112_18 = var_112_17.color

					var_112_18.r = var_112_16
					var_112_18.g = var_112_16
					var_112_18.b = var_112_16
					var_112_17.color = var_112_18
				end
			end

			if arg_109_1.time_ >= var_112_12 + var_112_14 and arg_109_1.time_ < var_112_12 + var_112_14 + arg_112_0 and not isNil(var_112_11) and arg_109_1.var_.highlightMatValue10017 then
				local var_112_19 = 1

				var_112_11.transform:SetSiblingIndex(1)

				local var_112_20 = arg_109_1.var_.highlightMatValue10017
				local var_112_21 = var_112_20.color

				var_112_21.r = var_112_19
				var_112_21.g = var_112_19
				var_112_21.b = var_112_19
				var_112_20.color = var_112_21
			end

			local var_112_22 = 0
			local var_112_23 = 0.475

			if var_112_22 < arg_109_1.time_ and arg_109_1.time_ <= var_112_22 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_24 = arg_109_1:FormatText(StoryNameCfg[255].name)

				arg_109_1.leftNameTxt_.text = var_112_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_25 = arg_109_1:GetWordFromCfg(114282027)
				local var_112_26 = arg_109_1:FormatText(var_112_25.content)

				arg_109_1.text_.text = var_112_26

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_27 = 19
				local var_112_28 = utf8.len(var_112_26)
				local var_112_29 = var_112_27 <= 0 and var_112_23 or var_112_23 * (var_112_28 / var_112_27)

				if var_112_29 > 0 and var_112_23 < var_112_29 then
					arg_109_1.talkMaxDuration = var_112_29

					if var_112_29 + var_112_22 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_29 + var_112_22
					end
				end

				arg_109_1.text_.text = var_112_26
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114282", "114282027", "story_v_out_114282.awb") ~= 0 then
					local var_112_30 = manager.audio:GetVoiceLength("story_v_out_114282", "114282027", "story_v_out_114282.awb") / 1000

					if var_112_30 + var_112_22 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_30 + var_112_22
					end

					if var_112_25.prefab_name ~= "" and arg_109_1.actors_[var_112_25.prefab_name] ~= nil then
						local var_112_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_25.prefab_name].transform, "story_v_out_114282", "114282027", "story_v_out_114282.awb")

						arg_109_1:RecordAudio("114282027", var_112_31)
						arg_109_1:RecordAudio("114282027", var_112_31)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_114282", "114282027", "story_v_out_114282.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_114282", "114282027", "story_v_out_114282.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_32 = math.max(var_112_23, arg_109_1.talkMaxDuration)

			if var_112_22 <= arg_109_1.time_ and arg_109_1.time_ < var_112_22 + var_112_32 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_22) / var_112_32

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_22 + var_112_32 and arg_109_1.time_ < var_112_22 + var_112_32 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play114282028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 114282028
		arg_113_1.duration_ = 13.2

		local var_113_0 = {
			ja = 13.2,
			ko = 9.8,
			zh = 8.833,
			en = 8.6
		}
		local var_113_1 = manager.audio:GetLocalizationFlag()

		if var_113_0[var_113_1] ~= nil then
			arg_113_1.duration_ = var_113_0[var_113_1]
		end

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play114282029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["10023"]
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 and not isNil(var_116_0) then
				local var_116_2 = var_116_0:GetComponent("Image")

				if var_116_2 then
					arg_113_1.var_.highlightMatValue10023 = var_116_2
				end
			end

			local var_116_3 = 0.034

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_3 and not isNil(var_116_0) then
				local var_116_4 = (arg_113_1.time_ - var_116_1) / var_116_3

				if arg_113_1.var_.highlightMatValue10023 then
					local var_116_5 = Mathf.Lerp(0.5, 1, var_116_4)
					local var_116_6 = arg_113_1.var_.highlightMatValue10023
					local var_116_7 = var_116_6.color

					var_116_7.r = var_116_5
					var_116_7.g = var_116_5
					var_116_7.b = var_116_5
					var_116_6.color = var_116_7
				end
			end

			if arg_113_1.time_ >= var_116_1 + var_116_3 and arg_113_1.time_ < var_116_1 + var_116_3 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.highlightMatValue10023 then
				local var_116_8 = 1

				var_116_0.transform:SetSiblingIndex(1)

				local var_116_9 = arg_113_1.var_.highlightMatValue10023
				local var_116_10 = var_116_9.color

				var_116_10.r = var_116_8
				var_116_10.g = var_116_8
				var_116_10.b = var_116_8
				var_116_9.color = var_116_10
			end

			local var_116_11 = arg_113_1.actors_["10017"]
			local var_116_12 = 0

			if var_116_12 < arg_113_1.time_ and arg_113_1.time_ <= var_116_12 + arg_116_0 and not isNil(var_116_11) then
				local var_116_13 = var_116_11:GetComponent("Image")

				if var_116_13 then
					arg_113_1.var_.highlightMatValue10017 = var_116_13
				end
			end

			local var_116_14 = 0.034

			if var_116_12 <= arg_113_1.time_ and arg_113_1.time_ < var_116_12 + var_116_14 and not isNil(var_116_11) then
				local var_116_15 = (arg_113_1.time_ - var_116_12) / var_116_14

				if arg_113_1.var_.highlightMatValue10017 then
					local var_116_16 = Mathf.Lerp(1, 0.5, var_116_15)
					local var_116_17 = arg_113_1.var_.highlightMatValue10017
					local var_116_18 = var_116_17.color

					var_116_18.r = var_116_16
					var_116_18.g = var_116_16
					var_116_18.b = var_116_16
					var_116_17.color = var_116_18
				end
			end

			if arg_113_1.time_ >= var_116_12 + var_116_14 and arg_113_1.time_ < var_116_12 + var_116_14 + arg_116_0 and not isNil(var_116_11) and arg_113_1.var_.highlightMatValue10017 then
				local var_116_19 = 0.5
				local var_116_20 = arg_113_1.var_.highlightMatValue10017
				local var_116_21 = var_116_20.color

				var_116_21.r = var_116_19
				var_116_21.g = var_116_19
				var_116_21.b = var_116_19
				var_116_20.color = var_116_21
			end

			local var_116_22 = 0
			local var_116_23 = 0.975

			if var_116_22 < arg_113_1.time_ and arg_113_1.time_ <= var_116_22 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_24 = arg_113_1:FormatText(StoryNameCfg[259].name)

				arg_113_1.leftNameTxt_.text = var_116_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_25 = arg_113_1:GetWordFromCfg(114282028)
				local var_116_26 = arg_113_1:FormatText(var_116_25.content)

				arg_113_1.text_.text = var_116_26

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_27 = 39
				local var_116_28 = utf8.len(var_116_26)
				local var_116_29 = var_116_27 <= 0 and var_116_23 or var_116_23 * (var_116_28 / var_116_27)

				if var_116_29 > 0 and var_116_23 < var_116_29 then
					arg_113_1.talkMaxDuration = var_116_29

					if var_116_29 + var_116_22 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_29 + var_116_22
					end
				end

				arg_113_1.text_.text = var_116_26
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114282", "114282028", "story_v_out_114282.awb") ~= 0 then
					local var_116_30 = manager.audio:GetVoiceLength("story_v_out_114282", "114282028", "story_v_out_114282.awb") / 1000

					if var_116_30 + var_116_22 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_30 + var_116_22
					end

					if var_116_25.prefab_name ~= "" and arg_113_1.actors_[var_116_25.prefab_name] ~= nil then
						local var_116_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_25.prefab_name].transform, "story_v_out_114282", "114282028", "story_v_out_114282.awb")

						arg_113_1:RecordAudio("114282028", var_116_31)
						arg_113_1:RecordAudio("114282028", var_116_31)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_114282", "114282028", "story_v_out_114282.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_114282", "114282028", "story_v_out_114282.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_32 = math.max(var_116_23, arg_113_1.talkMaxDuration)

			if var_116_22 <= arg_113_1.time_ and arg_113_1.time_ < var_116_22 + var_116_32 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_22) / var_116_32

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_22 + var_116_32 and arg_113_1.time_ < var_116_22 + var_116_32 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play114282029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 114282029
		arg_117_1.duration_ = 9.87

		local var_117_0 = {
			ja = 5,
			ko = 6.366,
			zh = 7.6,
			en = 9.866
		}
		local var_117_1 = manager.audio:GetLocalizationFlag()

		if var_117_0[var_117_1] ~= nil then
			arg_117_1.duration_ = var_117_0[var_117_1]
		end

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play114282030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["10023"]
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 and not isNil(var_120_0) then
				local var_120_2 = var_120_0:GetComponent("Image")

				if var_120_2 then
					arg_117_1.var_.highlightMatValue10023 = var_120_2
				end
			end

			local var_120_3 = 0.034

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_3 and not isNil(var_120_0) then
				local var_120_4 = (arg_117_1.time_ - var_120_1) / var_120_3

				if arg_117_1.var_.highlightMatValue10023 then
					local var_120_5 = Mathf.Lerp(1, 0.5, var_120_4)
					local var_120_6 = arg_117_1.var_.highlightMatValue10023
					local var_120_7 = var_120_6.color

					var_120_7.r = var_120_5
					var_120_7.g = var_120_5
					var_120_7.b = var_120_5
					var_120_6.color = var_120_7
				end
			end

			if arg_117_1.time_ >= var_120_1 + var_120_3 and arg_117_1.time_ < var_120_1 + var_120_3 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.highlightMatValue10023 then
				local var_120_8 = 0.5
				local var_120_9 = arg_117_1.var_.highlightMatValue10023
				local var_120_10 = var_120_9.color

				var_120_10.r = var_120_8
				var_120_10.g = var_120_8
				var_120_10.b = var_120_8
				var_120_9.color = var_120_10
			end

			local var_120_11 = arg_117_1.actors_["10017"]
			local var_120_12 = 0

			if var_120_12 < arg_117_1.time_ and arg_117_1.time_ <= var_120_12 + arg_120_0 and not isNil(var_120_11) then
				local var_120_13 = var_120_11:GetComponent("Image")

				if var_120_13 then
					arg_117_1.var_.highlightMatValue10017 = var_120_13
				end
			end

			local var_120_14 = 0.034

			if var_120_12 <= arg_117_1.time_ and arg_117_1.time_ < var_120_12 + var_120_14 and not isNil(var_120_11) then
				local var_120_15 = (arg_117_1.time_ - var_120_12) / var_120_14

				if arg_117_1.var_.highlightMatValue10017 then
					local var_120_16 = Mathf.Lerp(0.5, 1, var_120_15)
					local var_120_17 = arg_117_1.var_.highlightMatValue10017
					local var_120_18 = var_120_17.color

					var_120_18.r = var_120_16
					var_120_18.g = var_120_16
					var_120_18.b = var_120_16
					var_120_17.color = var_120_18
				end
			end

			if arg_117_1.time_ >= var_120_12 + var_120_14 and arg_117_1.time_ < var_120_12 + var_120_14 + arg_120_0 and not isNil(var_120_11) and arg_117_1.var_.highlightMatValue10017 then
				local var_120_19 = 1

				var_120_11.transform:SetSiblingIndex(1)

				local var_120_20 = arg_117_1.var_.highlightMatValue10017
				local var_120_21 = var_120_20.color

				var_120_21.r = var_120_19
				var_120_21.g = var_120_19
				var_120_21.b = var_120_19
				var_120_20.color = var_120_21
			end

			local var_120_22 = 0
			local var_120_23 = 0.5

			if var_120_22 < arg_117_1.time_ and arg_117_1.time_ <= var_120_22 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_24 = arg_117_1:FormatText(StoryNameCfg[255].name)

				arg_117_1.leftNameTxt_.text = var_120_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_25 = arg_117_1:GetWordFromCfg(114282029)
				local var_120_26 = arg_117_1:FormatText(var_120_25.content)

				arg_117_1.text_.text = var_120_26

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_27 = 20
				local var_120_28 = utf8.len(var_120_26)
				local var_120_29 = var_120_27 <= 0 and var_120_23 or var_120_23 * (var_120_28 / var_120_27)

				if var_120_29 > 0 and var_120_23 < var_120_29 then
					arg_117_1.talkMaxDuration = var_120_29

					if var_120_29 + var_120_22 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_29 + var_120_22
					end
				end

				arg_117_1.text_.text = var_120_26
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114282", "114282029", "story_v_out_114282.awb") ~= 0 then
					local var_120_30 = manager.audio:GetVoiceLength("story_v_out_114282", "114282029", "story_v_out_114282.awb") / 1000

					if var_120_30 + var_120_22 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_30 + var_120_22
					end

					if var_120_25.prefab_name ~= "" and arg_117_1.actors_[var_120_25.prefab_name] ~= nil then
						local var_120_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_25.prefab_name].transform, "story_v_out_114282", "114282029", "story_v_out_114282.awb")

						arg_117_1:RecordAudio("114282029", var_120_31)
						arg_117_1:RecordAudio("114282029", var_120_31)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_114282", "114282029", "story_v_out_114282.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_114282", "114282029", "story_v_out_114282.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_32 = math.max(var_120_23, arg_117_1.talkMaxDuration)

			if var_120_22 <= arg_117_1.time_ and arg_117_1.time_ < var_120_22 + var_120_32 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_22) / var_120_32

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_22 + var_120_32 and arg_117_1.time_ < var_120_22 + var_120_32 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play114282030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 114282030
		arg_121_1.duration_ = 3.4

		local var_121_0 = {
			ja = 1.4,
			ko = 2.1,
			zh = 3.4,
			en = 3.066
		}
		local var_121_1 = manager.audio:GetLocalizationFlag()

		if var_121_0[var_121_1] ~= nil then
			arg_121_1.duration_ = var_121_0[var_121_1]
		end

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play114282031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0
			local var_124_1 = 0.25

			if var_124_0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_2 = arg_121_1:FormatText(StoryNameCfg[255].name)

				arg_121_1.leftNameTxt_.text = var_124_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_3 = arg_121_1:GetWordFromCfg(114282030)
				local var_124_4 = arg_121_1:FormatText(var_124_3.content)

				arg_121_1.text_.text = var_124_4

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_5 = 10
				local var_124_6 = utf8.len(var_124_4)
				local var_124_7 = var_124_5 <= 0 and var_124_1 or var_124_1 * (var_124_6 / var_124_5)

				if var_124_7 > 0 and var_124_1 < var_124_7 then
					arg_121_1.talkMaxDuration = var_124_7

					if var_124_7 + var_124_0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_7 + var_124_0
					end
				end

				arg_121_1.text_.text = var_124_4
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114282", "114282030", "story_v_out_114282.awb") ~= 0 then
					local var_124_8 = manager.audio:GetVoiceLength("story_v_out_114282", "114282030", "story_v_out_114282.awb") / 1000

					if var_124_8 + var_124_0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_8 + var_124_0
					end

					if var_124_3.prefab_name ~= "" and arg_121_1.actors_[var_124_3.prefab_name] ~= nil then
						local var_124_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_3.prefab_name].transform, "story_v_out_114282", "114282030", "story_v_out_114282.awb")

						arg_121_1:RecordAudio("114282030", var_124_9)
						arg_121_1:RecordAudio("114282030", var_124_9)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_114282", "114282030", "story_v_out_114282.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_114282", "114282030", "story_v_out_114282.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_10 = math.max(var_124_1, arg_121_1.talkMaxDuration)

			if var_124_0 <= arg_121_1.time_ and arg_121_1.time_ < var_124_0 + var_124_10 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_0) / var_124_10

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_0 + var_124_10 and arg_121_1.time_ < var_124_0 + var_124_10 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play114282031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 114282031
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play114282032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["10017"]
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 then
				local var_128_2 = var_128_0:GetComponent("Image")

				if var_128_2 then
					arg_125_1.var_.alphaMatValue10017 = var_128_2
					arg_125_1.var_.alphaOldValue10017 = var_128_2.color.a
				end

				arg_125_1.var_.alphaOldValue10017 = 1
			end

			local var_128_3 = 0.5

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_3 then
				local var_128_4 = (arg_125_1.time_ - var_128_1) / var_128_3
				local var_128_5 = Mathf.Lerp(arg_125_1.var_.alphaOldValue10017, 0, var_128_4)

				if arg_125_1.var_.alphaMatValue10017 then
					local var_128_6 = arg_125_1.var_.alphaMatValue10017.color

					var_128_6.a = var_128_5
					arg_125_1.var_.alphaMatValue10017.color = var_128_6
				end
			end

			if arg_125_1.time_ >= var_128_1 + var_128_3 and arg_125_1.time_ < var_128_1 + var_128_3 + arg_128_0 and arg_125_1.var_.alphaMatValue10017 then
				local var_128_7 = arg_125_1.var_.alphaMatValue10017
				local var_128_8 = var_128_7.color

				var_128_8.a = 0
				var_128_7.color = var_128_8
			end

			local var_128_9 = arg_125_1.actors_["10023"]
			local var_128_10 = 0

			if var_128_10 < arg_125_1.time_ and arg_125_1.time_ <= var_128_10 + arg_128_0 then
				local var_128_11 = var_128_9:GetComponent("Image")

				if var_128_11 then
					arg_125_1.var_.alphaMatValue10023 = var_128_11
					arg_125_1.var_.alphaOldValue10023 = var_128_11.color.a
				end

				arg_125_1.var_.alphaOldValue10023 = 1
			end

			local var_128_12 = 0.5

			if var_128_10 <= arg_125_1.time_ and arg_125_1.time_ < var_128_10 + var_128_12 then
				local var_128_13 = (arg_125_1.time_ - var_128_10) / var_128_12
				local var_128_14 = Mathf.Lerp(arg_125_1.var_.alphaOldValue10023, 0, var_128_13)

				if arg_125_1.var_.alphaMatValue10023 then
					local var_128_15 = arg_125_1.var_.alphaMatValue10023.color

					var_128_15.a = var_128_14
					arg_125_1.var_.alphaMatValue10023.color = var_128_15
				end
			end

			if arg_125_1.time_ >= var_128_10 + var_128_12 and arg_125_1.time_ < var_128_10 + var_128_12 + arg_128_0 and arg_125_1.var_.alphaMatValue10023 then
				local var_128_16 = arg_125_1.var_.alphaMatValue10023
				local var_128_17 = var_128_16.color

				var_128_17.a = 0
				var_128_16.color = var_128_17
			end

			local var_128_18 = 0
			local var_128_19 = 0.95

			if var_128_18 < arg_125_1.time_ and arg_125_1.time_ <= var_128_18 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_20 = arg_125_1:GetWordFromCfg(114282031)
				local var_128_21 = arg_125_1:FormatText(var_128_20.content)

				arg_125_1.text_.text = var_128_21

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_22 = 38
				local var_128_23 = utf8.len(var_128_21)
				local var_128_24 = var_128_22 <= 0 and var_128_19 or var_128_19 * (var_128_23 / var_128_22)

				if var_128_24 > 0 and var_128_19 < var_128_24 then
					arg_125_1.talkMaxDuration = var_128_24

					if var_128_24 + var_128_18 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_24 + var_128_18
					end
				end

				arg_125_1.text_.text = var_128_21
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_25 = math.max(var_128_19, arg_125_1.talkMaxDuration)

			if var_128_18 <= arg_125_1.time_ and arg_125_1.time_ < var_128_18 + var_128_25 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_18) / var_128_25

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_18 + var_128_25 and arg_125_1.time_ < var_128_18 + var_128_25 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play114282032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 114282032
		arg_129_1.duration_ = 1.1

		local var_129_0 = {
			ja = 1.1,
			ko = 1.033,
			zh = 0.999999999999,
			en = 0.999999999999
		}
		local var_129_1 = manager.audio:GetLocalizationFlag()

		if var_129_0[var_129_1] ~= nil then
			arg_129_1.duration_ = var_129_0[var_129_1]
		end

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play114282033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["10022"].transform
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 then
				arg_129_1.var_.moveOldPos10022 = var_132_0.localPosition
				var_132_0.localScale = Vector3.New(1, 1, 1)

				arg_129_1:CheckSpriteTmpPos("10022", 2)

				local var_132_2 = var_132_0.childCount

				for iter_132_0 = 0, var_132_2 - 1 do
					local var_132_3 = var_132_0:GetChild(iter_132_0)

					if var_132_3.name == "split_6" or not string.find(var_132_3.name, "split") then
						var_132_3.gameObject:SetActive(true)
					else
						var_132_3.gameObject:SetActive(false)
					end
				end
			end

			local var_132_4 = 0.001

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_4 then
				local var_132_5 = (arg_129_1.time_ - var_132_1) / var_132_4
				local var_132_6 = Vector3.New(-390, -350, -180)

				var_132_0.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos10022, var_132_6, var_132_5)
			end

			if arg_129_1.time_ >= var_132_1 + var_132_4 and arg_129_1.time_ < var_132_1 + var_132_4 + arg_132_0 then
				var_132_0.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_132_7 = arg_129_1.actors_["10022"]
			local var_132_8 = 0

			if var_132_8 < arg_129_1.time_ and arg_129_1.time_ <= var_132_8 + arg_132_0 and not isNil(var_132_7) and arg_129_1.var_.actorSpriteComps10022 == nil then
				arg_129_1.var_.actorSpriteComps10022 = var_132_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_132_9 = 0.034

			if var_132_8 <= arg_129_1.time_ and arg_129_1.time_ < var_132_8 + var_132_9 and not isNil(var_132_7) then
				local var_132_10 = (arg_129_1.time_ - var_132_8) / var_132_9

				if arg_129_1.var_.actorSpriteComps10022 then
					for iter_132_1, iter_132_2 in pairs(arg_129_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_132_2 then
							if arg_129_1.isInRecall_ then
								local var_132_11 = Mathf.Lerp(iter_132_2.color.r, arg_129_1.hightColor1.r, var_132_10)
								local var_132_12 = Mathf.Lerp(iter_132_2.color.g, arg_129_1.hightColor1.g, var_132_10)
								local var_132_13 = Mathf.Lerp(iter_132_2.color.b, arg_129_1.hightColor1.b, var_132_10)

								iter_132_2.color = Color.New(var_132_11, var_132_12, var_132_13)
							else
								local var_132_14 = Mathf.Lerp(iter_132_2.color.r, 1, var_132_10)

								iter_132_2.color = Color.New(var_132_14, var_132_14, var_132_14)
							end
						end
					end
				end
			end

			if arg_129_1.time_ >= var_132_8 + var_132_9 and arg_129_1.time_ < var_132_8 + var_132_9 + arg_132_0 and not isNil(var_132_7) and arg_129_1.var_.actorSpriteComps10022 then
				for iter_132_3, iter_132_4 in pairs(arg_129_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_132_4 then
						if arg_129_1.isInRecall_ then
							iter_132_4.color = arg_129_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_132_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_129_1.var_.actorSpriteComps10022 = nil
			end

			local var_132_15 = arg_129_1.actors_["10022"]
			local var_132_16 = 0

			if var_132_16 < arg_129_1.time_ and arg_129_1.time_ <= var_132_16 + arg_132_0 then
				local var_132_17 = var_132_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_132_17 then
					arg_129_1.var_.alphaOldValue10022 = var_132_17.alpha
					arg_129_1.var_.characterEffect10022 = var_132_17
				end

				arg_129_1.var_.alphaOldValue10022 = 0
			end

			local var_132_18 = 0.5

			if var_132_16 <= arg_129_1.time_ and arg_129_1.time_ < var_132_16 + var_132_18 then
				local var_132_19 = (arg_129_1.time_ - var_132_16) / var_132_18
				local var_132_20 = Mathf.Lerp(arg_129_1.var_.alphaOldValue10022, 1, var_132_19)

				if arg_129_1.var_.characterEffect10022 then
					arg_129_1.var_.characterEffect10022.alpha = var_132_20
				end
			end

			if arg_129_1.time_ >= var_132_16 + var_132_18 and arg_129_1.time_ < var_132_16 + var_132_18 + arg_132_0 and arg_129_1.var_.characterEffect10022 then
				arg_129_1.var_.characterEffect10022.alpha = 1
			end

			local var_132_21 = 0
			local var_132_22 = 0.1

			if var_132_21 < arg_129_1.time_ and arg_129_1.time_ <= var_132_21 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_23 = arg_129_1:FormatText(StoryNameCfg[235].name)

				arg_129_1.leftNameTxt_.text = var_132_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_24 = arg_129_1:GetWordFromCfg(114282032)
				local var_132_25 = arg_129_1:FormatText(var_132_24.content)

				arg_129_1.text_.text = var_132_25

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_26 = 4
				local var_132_27 = utf8.len(var_132_25)
				local var_132_28 = var_132_26 <= 0 and var_132_22 or var_132_22 * (var_132_27 / var_132_26)

				if var_132_28 > 0 and var_132_22 < var_132_28 then
					arg_129_1.talkMaxDuration = var_132_28

					if var_132_28 + var_132_21 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_28 + var_132_21
					end
				end

				arg_129_1.text_.text = var_132_25
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114282", "114282032", "story_v_out_114282.awb") ~= 0 then
					local var_132_29 = manager.audio:GetVoiceLength("story_v_out_114282", "114282032", "story_v_out_114282.awb") / 1000

					if var_132_29 + var_132_21 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_29 + var_132_21
					end

					if var_132_24.prefab_name ~= "" and arg_129_1.actors_[var_132_24.prefab_name] ~= nil then
						local var_132_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_24.prefab_name].transform, "story_v_out_114282", "114282032", "story_v_out_114282.awb")

						arg_129_1:RecordAudio("114282032", var_132_30)
						arg_129_1:RecordAudio("114282032", var_132_30)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_114282", "114282032", "story_v_out_114282.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_114282", "114282032", "story_v_out_114282.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_31 = math.max(var_132_22, arg_129_1.talkMaxDuration)

			if var_132_21 <= arg_129_1.time_ and arg_129_1.time_ < var_132_21 + var_132_31 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_21) / var_132_31

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_21 + var_132_31 and arg_129_1.time_ < var_132_21 + var_132_31 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_129_1:InitPlayNodeList()
	end,
	Play114282033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 114282033
		arg_133_1.duration_ = 3.3

		local var_133_0 = {
			ja = 2.366,
			ko = 1.6,
			zh = 3.3,
			en = 1.433
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
				arg_133_0:Play114282034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["10017"].transform
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 then
				arg_133_1.var_.moveOldPos10017 = var_136_0.localPosition
				var_136_0.localScale = Vector3.New(1, 1, 1)

				arg_133_1:CheckSpriteTmpPos("10017", 4)
			end

			local var_136_2 = 0.001

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_2 then
				local var_136_3 = (arg_133_1.time_ - var_136_1) / var_136_2
				local var_136_4 = Vector3.New(390, -350, -180)

				var_136_0.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos10017, var_136_4, var_136_3)
			end

			if arg_133_1.time_ >= var_136_1 + var_136_2 and arg_133_1.time_ < var_136_1 + var_136_2 + arg_136_0 then
				var_136_0.localPosition = Vector3.New(390, -350, -180)
			end

			local var_136_5 = arg_133_1.actors_["10022"]
			local var_136_6 = 0

			if var_136_6 < arg_133_1.time_ and arg_133_1.time_ <= var_136_6 + arg_136_0 and not isNil(var_136_5) and arg_133_1.var_.actorSpriteComps10022 == nil then
				arg_133_1.var_.actorSpriteComps10022 = var_136_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_136_7 = 0.034

			if var_136_6 <= arg_133_1.time_ and arg_133_1.time_ < var_136_6 + var_136_7 and not isNil(var_136_5) then
				local var_136_8 = (arg_133_1.time_ - var_136_6) / var_136_7

				if arg_133_1.var_.actorSpriteComps10022 then
					for iter_136_0, iter_136_1 in pairs(arg_133_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_136_1 then
							if arg_133_1.isInRecall_ then
								local var_136_9 = Mathf.Lerp(iter_136_1.color.r, arg_133_1.hightColor2.r, var_136_8)
								local var_136_10 = Mathf.Lerp(iter_136_1.color.g, arg_133_1.hightColor2.g, var_136_8)
								local var_136_11 = Mathf.Lerp(iter_136_1.color.b, arg_133_1.hightColor2.b, var_136_8)

								iter_136_1.color = Color.New(var_136_9, var_136_10, var_136_11)
							else
								local var_136_12 = Mathf.Lerp(iter_136_1.color.r, 0.5, var_136_8)

								iter_136_1.color = Color.New(var_136_12, var_136_12, var_136_12)
							end
						end
					end
				end
			end

			if arg_133_1.time_ >= var_136_6 + var_136_7 and arg_133_1.time_ < var_136_6 + var_136_7 + arg_136_0 and not isNil(var_136_5) and arg_133_1.var_.actorSpriteComps10022 then
				for iter_136_2, iter_136_3 in pairs(arg_133_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_136_3 then
						if arg_133_1.isInRecall_ then
							iter_136_3.color = arg_133_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_136_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_133_1.var_.actorSpriteComps10022 = nil
			end

			local var_136_13 = arg_133_1.actors_["10017"]
			local var_136_14 = 0

			if var_136_14 < arg_133_1.time_ and arg_133_1.time_ <= var_136_14 + arg_136_0 and not isNil(var_136_13) then
				local var_136_15 = var_136_13:GetComponent("Image")

				if var_136_15 then
					arg_133_1.var_.highlightMatValue10017 = var_136_15
				end
			end

			local var_136_16 = 0.034

			if var_136_14 <= arg_133_1.time_ and arg_133_1.time_ < var_136_14 + var_136_16 and not isNil(var_136_13) then
				local var_136_17 = (arg_133_1.time_ - var_136_14) / var_136_16

				if arg_133_1.var_.highlightMatValue10017 then
					local var_136_18 = Mathf.Lerp(0.5, 1, var_136_17)
					local var_136_19 = arg_133_1.var_.highlightMatValue10017
					local var_136_20 = var_136_19.color

					var_136_20.r = var_136_18
					var_136_20.g = var_136_18
					var_136_20.b = var_136_18
					var_136_19.color = var_136_20
				end
			end

			if arg_133_1.time_ >= var_136_14 + var_136_16 and arg_133_1.time_ < var_136_14 + var_136_16 + arg_136_0 and not isNil(var_136_13) and arg_133_1.var_.highlightMatValue10017 then
				local var_136_21 = 1

				var_136_13.transform:SetSiblingIndex(1)

				local var_136_22 = arg_133_1.var_.highlightMatValue10017
				local var_136_23 = var_136_22.color

				var_136_23.r = var_136_21
				var_136_23.g = var_136_21
				var_136_23.b = var_136_21
				var_136_22.color = var_136_23
			end

			local var_136_24 = arg_133_1.actors_["10017"]
			local var_136_25 = 0

			if var_136_25 < arg_133_1.time_ and arg_133_1.time_ <= var_136_25 + arg_136_0 then
				local var_136_26 = var_136_24:GetComponent("Image")

				if var_136_26 then
					arg_133_1.var_.alphaMatValue10017 = var_136_26
					arg_133_1.var_.alphaOldValue10017 = var_136_26.color.a
				end

				arg_133_1.var_.alphaOldValue10017 = 0
			end

			local var_136_27 = 0.5

			if var_136_25 <= arg_133_1.time_ and arg_133_1.time_ < var_136_25 + var_136_27 then
				local var_136_28 = (arg_133_1.time_ - var_136_25) / var_136_27
				local var_136_29 = Mathf.Lerp(arg_133_1.var_.alphaOldValue10017, 1, var_136_28)

				if arg_133_1.var_.alphaMatValue10017 then
					local var_136_30 = arg_133_1.var_.alphaMatValue10017.color

					var_136_30.a = var_136_29
					arg_133_1.var_.alphaMatValue10017.color = var_136_30
				end
			end

			if arg_133_1.time_ >= var_136_25 + var_136_27 and arg_133_1.time_ < var_136_25 + var_136_27 + arg_136_0 and arg_133_1.var_.alphaMatValue10017 then
				local var_136_31 = arg_133_1.var_.alphaMatValue10017
				local var_136_32 = var_136_31.color

				var_136_32.a = 1
				var_136_31.color = var_136_32
			end

			local var_136_33 = 0
			local var_136_34 = 0.125

			if var_136_33 < arg_133_1.time_ and arg_133_1.time_ <= var_136_33 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_35 = arg_133_1:FormatText(StoryNameCfg[255].name)

				arg_133_1.leftNameTxt_.text = var_136_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_36 = arg_133_1:GetWordFromCfg(114282033)
				local var_136_37 = arg_133_1:FormatText(var_136_36.content)

				arg_133_1.text_.text = var_136_37

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_38 = 5
				local var_136_39 = utf8.len(var_136_37)
				local var_136_40 = var_136_38 <= 0 and var_136_34 or var_136_34 * (var_136_39 / var_136_38)

				if var_136_40 > 0 and var_136_34 < var_136_40 then
					arg_133_1.talkMaxDuration = var_136_40

					if var_136_40 + var_136_33 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_40 + var_136_33
					end
				end

				arg_133_1.text_.text = var_136_37
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114282", "114282033", "story_v_out_114282.awb") ~= 0 then
					local var_136_41 = manager.audio:GetVoiceLength("story_v_out_114282", "114282033", "story_v_out_114282.awb") / 1000

					if var_136_41 + var_136_33 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_41 + var_136_33
					end

					if var_136_36.prefab_name ~= "" and arg_133_1.actors_[var_136_36.prefab_name] ~= nil then
						local var_136_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_36.prefab_name].transform, "story_v_out_114282", "114282033", "story_v_out_114282.awb")

						arg_133_1:RecordAudio("114282033", var_136_42)
						arg_133_1:RecordAudio("114282033", var_136_42)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_114282", "114282033", "story_v_out_114282.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_114282", "114282033", "story_v_out_114282.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_43 = math.max(var_136_34, arg_133_1.talkMaxDuration)

			if var_136_33 <= arg_133_1.time_ and arg_133_1.time_ < var_136_33 + var_136_43 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_33) / var_136_43

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_33 + var_136_43 and arg_133_1.time_ < var_136_33 + var_136_43 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10017",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play114282034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 114282034
		arg_137_1.duration_ = 10.63

		local var_137_0 = {
			ja = 10.633,
			ko = 8.033,
			zh = 7.4,
			en = 7.5
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
				arg_137_0:Play114282035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["10022"].transform
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 then
				arg_137_1.var_.moveOldPos10022 = var_140_0.localPosition
				var_140_0.localScale = Vector3.New(1, 1, 1)

				arg_137_1:CheckSpriteTmpPos("10022", 7)

				local var_140_2 = var_140_0.childCount

				for iter_140_0 = 0, var_140_2 - 1 do
					local var_140_3 = var_140_0:GetChild(iter_140_0)

					if var_140_3.name == "split_6" or not string.find(var_140_3.name, "split") then
						var_140_3.gameObject:SetActive(true)
					else
						var_140_3.gameObject:SetActive(false)
					end
				end
			end

			local var_140_4 = 0.001

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_4 then
				local var_140_5 = (arg_137_1.time_ - var_140_1) / var_140_4
				local var_140_6 = Vector3.New(0, -2000, -180)

				var_140_0.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos10022, var_140_6, var_140_5)
			end

			if arg_137_1.time_ >= var_140_1 + var_140_4 and arg_137_1.time_ < var_140_1 + var_140_4 + arg_140_0 then
				var_140_0.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_140_7 = arg_137_1.actors_["10017"].transform
			local var_140_8 = 0

			if var_140_8 < arg_137_1.time_ and arg_137_1.time_ <= var_140_8 + arg_140_0 then
				arg_137_1.var_.moveOldPos10017 = var_140_7.localPosition
				var_140_7.localScale = Vector3.New(1, 1, 1)

				arg_137_1:CheckSpriteTmpPos("10017", 7)
			end

			local var_140_9 = 0.001

			if var_140_8 <= arg_137_1.time_ and arg_137_1.time_ < var_140_8 + var_140_9 then
				local var_140_10 = (arg_137_1.time_ - var_140_8) / var_140_9
				local var_140_11 = Vector3.New(0, -2000, 500)

				var_140_7.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos10017, var_140_11, var_140_10)
			end

			if arg_137_1.time_ >= var_140_8 + var_140_9 and arg_137_1.time_ < var_140_8 + var_140_9 + arg_140_0 then
				var_140_7.localPosition = Vector3.New(0, -2000, 500)
			end

			local var_140_12 = 0
			local var_140_13 = 0.7

			if var_140_12 < arg_137_1.time_ and arg_137_1.time_ <= var_140_12 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_14 = arg_137_1:FormatText(StoryNameCfg[208].name)

				arg_137_1.leftNameTxt_.text = var_140_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, true)
				arg_137_1.iconController_:SetSelectedState("hero")

				arg_137_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10015")

				arg_137_1.callingController_:SetSelectedState("normal")

				arg_137_1.keyicon_.color = Color.New(1, 1, 1)
				arg_137_1.icon_.color = Color.New(1, 1, 1)

				local var_140_15 = arg_137_1:GetWordFromCfg(114282034)
				local var_140_16 = arg_137_1:FormatText(var_140_15.content)

				arg_137_1.text_.text = var_140_16

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_17 = 28
				local var_140_18 = utf8.len(var_140_16)
				local var_140_19 = var_140_17 <= 0 and var_140_13 or var_140_13 * (var_140_18 / var_140_17)

				if var_140_19 > 0 and var_140_13 < var_140_19 then
					arg_137_1.talkMaxDuration = var_140_19

					if var_140_19 + var_140_12 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_19 + var_140_12
					end
				end

				arg_137_1.text_.text = var_140_16
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114282", "114282034", "story_v_out_114282.awb") ~= 0 then
					local var_140_20 = manager.audio:GetVoiceLength("story_v_out_114282", "114282034", "story_v_out_114282.awb") / 1000

					if var_140_20 + var_140_12 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_20 + var_140_12
					end

					if var_140_15.prefab_name ~= "" and arg_137_1.actors_[var_140_15.prefab_name] ~= nil then
						local var_140_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_15.prefab_name].transform, "story_v_out_114282", "114282034", "story_v_out_114282.awb")

						arg_137_1:RecordAudio("114282034", var_140_21)
						arg_137_1:RecordAudio("114282034", var_140_21)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_114282", "114282034", "story_v_out_114282.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_114282", "114282034", "story_v_out_114282.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_22 = math.max(var_140_13, arg_137_1.talkMaxDuration)

			if var_140_12 <= arg_137_1.time_ and arg_137_1.time_ < var_140_12 + var_140_22 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_12) / var_140_22

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_12 + var_140_22 and arg_137_1.time_ < var_140_12 + var_140_22 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10017",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_137_1:InitPlayNodeList()
	end,
	Play114282035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 114282035
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play114282036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0
			local var_144_1 = 1.45

			if var_144_0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, false)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_2 = arg_141_1:GetWordFromCfg(114282035)
				local var_144_3 = arg_141_1:FormatText(var_144_2.content)

				arg_141_1.text_.text = var_144_3

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_4 = 58
				local var_144_5 = utf8.len(var_144_3)
				local var_144_6 = var_144_4 <= 0 and var_144_1 or var_144_1 * (var_144_5 / var_144_4)

				if var_144_6 > 0 and var_144_1 < var_144_6 then
					arg_141_1.talkMaxDuration = var_144_6

					if var_144_6 + var_144_0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_6 + var_144_0
					end
				end

				arg_141_1.text_.text = var_144_3
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_7 = math.max(var_144_1, arg_141_1.talkMaxDuration)

			if var_144_0 <= arg_141_1.time_ and arg_141_1.time_ < var_144_0 + var_144_7 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_0) / var_144_7

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_0 + var_144_7 and arg_141_1.time_ < var_144_0 + var_144_7 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play114282036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 114282036
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play114282037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0
			local var_148_1 = 1.4

			if var_148_0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_2 = arg_145_1:GetWordFromCfg(114282036)
				local var_148_3 = arg_145_1:FormatText(var_148_2.content)

				arg_145_1.text_.text = var_148_3

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_4 = 56
				local var_148_5 = utf8.len(var_148_3)
				local var_148_6 = var_148_4 <= 0 and var_148_1 or var_148_1 * (var_148_5 / var_148_4)

				if var_148_6 > 0 and var_148_1 < var_148_6 then
					arg_145_1.talkMaxDuration = var_148_6

					if var_148_6 + var_148_0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_6 + var_148_0
					end
				end

				arg_145_1.text_.text = var_148_3
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_7 = math.max(var_148_1, arg_145_1.talkMaxDuration)

			if var_148_0 <= arg_145_1.time_ and arg_145_1.time_ < var_148_0 + var_148_7 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_0) / var_148_7

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_0 + var_148_7 and arg_145_1.time_ < var_148_0 + var_148_7 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play114282037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 114282037
		arg_149_1.duration_ = 6.03

		local var_149_0 = {
			ja = 6.033,
			ko = 4.7,
			zh = 4.833,
			en = 3.533
		}
		local var_149_1 = manager.audio:GetLocalizationFlag()

		if var_149_0[var_149_1] ~= nil then
			arg_149_1.duration_ = var_149_0[var_149_1]
		end

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play114282038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["10022"]
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 then
				local var_152_2 = var_152_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_152_2 then
					arg_149_1.var_.alphaOldValue10022 = var_152_2.alpha
					arg_149_1.var_.characterEffect10022 = var_152_2
				end

				arg_149_1.var_.alphaOldValue10022 = 0
			end

			local var_152_3 = 0.5

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_3 then
				local var_152_4 = (arg_149_1.time_ - var_152_1) / var_152_3
				local var_152_5 = Mathf.Lerp(arg_149_1.var_.alphaOldValue10022, 1, var_152_4)

				if arg_149_1.var_.characterEffect10022 then
					arg_149_1.var_.characterEffect10022.alpha = var_152_5
				end
			end

			if arg_149_1.time_ >= var_152_1 + var_152_3 and arg_149_1.time_ < var_152_1 + var_152_3 + arg_152_0 and arg_149_1.var_.characterEffect10022 then
				arg_149_1.var_.characterEffect10022.alpha = 1
			end

			local var_152_6 = arg_149_1.actors_["10022"].transform
			local var_152_7 = 0

			if var_152_7 < arg_149_1.time_ and arg_149_1.time_ <= var_152_7 + arg_152_0 then
				arg_149_1.var_.moveOldPos10022 = var_152_6.localPosition
				var_152_6.localScale = Vector3.New(1, 1, 1)

				arg_149_1:CheckSpriteTmpPos("10022", 3)

				local var_152_8 = var_152_6.childCount

				for iter_152_0 = 0, var_152_8 - 1 do
					local var_152_9 = var_152_6:GetChild(iter_152_0)

					if var_152_9.name == "split_2" or not string.find(var_152_9.name, "split") then
						var_152_9.gameObject:SetActive(true)
					else
						var_152_9.gameObject:SetActive(false)
					end
				end
			end

			local var_152_10 = 0.001

			if var_152_7 <= arg_149_1.time_ and arg_149_1.time_ < var_152_7 + var_152_10 then
				local var_152_11 = (arg_149_1.time_ - var_152_7) / var_152_10
				local var_152_12 = Vector3.New(0, -350, -180)

				var_152_6.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos10022, var_152_12, var_152_11)
			end

			if arg_149_1.time_ >= var_152_7 + var_152_10 and arg_149_1.time_ < var_152_7 + var_152_10 + arg_152_0 then
				var_152_6.localPosition = Vector3.New(0, -350, -180)
			end

			local var_152_13 = arg_149_1.actors_["10022"]
			local var_152_14 = 0

			if var_152_14 < arg_149_1.time_ and arg_149_1.time_ <= var_152_14 + arg_152_0 and not isNil(var_152_13) and arg_149_1.var_.actorSpriteComps10022 == nil then
				arg_149_1.var_.actorSpriteComps10022 = var_152_13:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_15 = 0.034

			if var_152_14 <= arg_149_1.time_ and arg_149_1.time_ < var_152_14 + var_152_15 and not isNil(var_152_13) then
				local var_152_16 = (arg_149_1.time_ - var_152_14) / var_152_15

				if arg_149_1.var_.actorSpriteComps10022 then
					for iter_152_1, iter_152_2 in pairs(arg_149_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_152_2 then
							if arg_149_1.isInRecall_ then
								local var_152_17 = Mathf.Lerp(iter_152_2.color.r, arg_149_1.hightColor1.r, var_152_16)
								local var_152_18 = Mathf.Lerp(iter_152_2.color.g, arg_149_1.hightColor1.g, var_152_16)
								local var_152_19 = Mathf.Lerp(iter_152_2.color.b, arg_149_1.hightColor1.b, var_152_16)

								iter_152_2.color = Color.New(var_152_17, var_152_18, var_152_19)
							else
								local var_152_20 = Mathf.Lerp(iter_152_2.color.r, 1, var_152_16)

								iter_152_2.color = Color.New(var_152_20, var_152_20, var_152_20)
							end
						end
					end
				end
			end

			if arg_149_1.time_ >= var_152_14 + var_152_15 and arg_149_1.time_ < var_152_14 + var_152_15 + arg_152_0 and not isNil(var_152_13) and arg_149_1.var_.actorSpriteComps10022 then
				for iter_152_3, iter_152_4 in pairs(arg_149_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_152_4 then
						if arg_149_1.isInRecall_ then
							iter_152_4.color = arg_149_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_152_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_149_1.var_.actorSpriteComps10022 = nil
			end

			local var_152_21 = 0
			local var_152_22 = 0.425

			if var_152_21 < arg_149_1.time_ and arg_149_1.time_ <= var_152_21 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_23 = arg_149_1:FormatText(StoryNameCfg[235].name)

				arg_149_1.leftNameTxt_.text = var_152_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_24 = arg_149_1:GetWordFromCfg(114282037)
				local var_152_25 = arg_149_1:FormatText(var_152_24.content)

				arg_149_1.text_.text = var_152_25

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_26 = 17
				local var_152_27 = utf8.len(var_152_25)
				local var_152_28 = var_152_26 <= 0 and var_152_22 or var_152_22 * (var_152_27 / var_152_26)

				if var_152_28 > 0 and var_152_22 < var_152_28 then
					arg_149_1.talkMaxDuration = var_152_28

					if var_152_28 + var_152_21 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_28 + var_152_21
					end
				end

				arg_149_1.text_.text = var_152_25
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114282", "114282037", "story_v_out_114282.awb") ~= 0 then
					local var_152_29 = manager.audio:GetVoiceLength("story_v_out_114282", "114282037", "story_v_out_114282.awb") / 1000

					if var_152_29 + var_152_21 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_29 + var_152_21
					end

					if var_152_24.prefab_name ~= "" and arg_149_1.actors_[var_152_24.prefab_name] ~= nil then
						local var_152_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_24.prefab_name].transform, "story_v_out_114282", "114282037", "story_v_out_114282.awb")

						arg_149_1:RecordAudio("114282037", var_152_30)
						arg_149_1:RecordAudio("114282037", var_152_30)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_114282", "114282037", "story_v_out_114282.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_114282", "114282037", "story_v_out_114282.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_31 = math.max(var_152_22, arg_149_1.talkMaxDuration)

			if var_152_21 <= arg_149_1.time_ and arg_149_1.time_ < var_152_21 + var_152_31 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_21) / var_152_31

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_21 + var_152_31 and arg_149_1.time_ < var_152_21 + var_152_31 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_149_1:InitPlayNodeList()
	end,
	Play114282038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 114282038
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play114282039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["10022"]
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 then
				local var_156_2 = var_156_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_156_2 then
					arg_153_1.var_.alphaOldValue10022 = var_156_2.alpha
					arg_153_1.var_.characterEffect10022 = var_156_2
				end

				arg_153_1.var_.alphaOldValue10022 = 1
			end

			local var_156_3 = 0.5

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_3 then
				local var_156_4 = (arg_153_1.time_ - var_156_1) / var_156_3
				local var_156_5 = Mathf.Lerp(arg_153_1.var_.alphaOldValue10022, 0, var_156_4)

				if arg_153_1.var_.characterEffect10022 then
					arg_153_1.var_.characterEffect10022.alpha = var_156_5
				end
			end

			if arg_153_1.time_ >= var_156_1 + var_156_3 and arg_153_1.time_ < var_156_1 + var_156_3 + arg_156_0 and arg_153_1.var_.characterEffect10022 then
				arg_153_1.var_.characterEffect10022.alpha = 0
			end

			local var_156_6 = 0
			local var_156_7 = 1.575

			if var_156_6 < arg_153_1.time_ and arg_153_1.time_ <= var_156_6 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, false)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_8 = arg_153_1:GetWordFromCfg(114282038)
				local var_156_9 = arg_153_1:FormatText(var_156_8.content)

				arg_153_1.text_.text = var_156_9

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_10 = 62
				local var_156_11 = utf8.len(var_156_9)
				local var_156_12 = var_156_10 <= 0 and var_156_7 or var_156_7 * (var_156_11 / var_156_10)

				if var_156_12 > 0 and var_156_7 < var_156_12 then
					arg_153_1.talkMaxDuration = var_156_12

					if var_156_12 + var_156_6 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_12 + var_156_6
					end
				end

				arg_153_1.text_.text = var_156_9
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_13 = math.max(var_156_7, arg_153_1.talkMaxDuration)

			if var_156_6 <= arg_153_1.time_ and arg_153_1.time_ < var_156_6 + var_156_13 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_6) / var_156_13

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_6 + var_156_13 and arg_153_1.time_ < var_156_6 + var_156_13 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play114282039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 114282039
		arg_157_1.duration_ = 14.47

		local var_157_0 = {
			ja = 7.766,
			ko = 9.733,
			zh = 11.5,
			en = 14.466
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
				arg_157_0:Play114282040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["10017"]
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 then
				local var_160_2 = var_160_0:GetComponent("Image")

				if var_160_2 then
					arg_157_1.var_.alphaMatValue10017 = var_160_2
					arg_157_1.var_.alphaOldValue10017 = var_160_2.color.a
				end

				arg_157_1.var_.alphaOldValue10017 = 0
			end

			local var_160_3 = 0.5

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_3 then
				local var_160_4 = (arg_157_1.time_ - var_160_1) / var_160_3
				local var_160_5 = Mathf.Lerp(arg_157_1.var_.alphaOldValue10017, 1, var_160_4)

				if arg_157_1.var_.alphaMatValue10017 then
					local var_160_6 = arg_157_1.var_.alphaMatValue10017.color

					var_160_6.a = var_160_5
					arg_157_1.var_.alphaMatValue10017.color = var_160_6
				end
			end

			if arg_157_1.time_ >= var_160_1 + var_160_3 and arg_157_1.time_ < var_160_1 + var_160_3 + arg_160_0 and arg_157_1.var_.alphaMatValue10017 then
				local var_160_7 = arg_157_1.var_.alphaMatValue10017
				local var_160_8 = var_160_7.color

				var_160_8.a = 1
				var_160_7.color = var_160_8
			end

			local var_160_9 = arg_157_1.actors_["10017"].transform
			local var_160_10 = 0

			if var_160_10 < arg_157_1.time_ and arg_157_1.time_ <= var_160_10 + arg_160_0 then
				arg_157_1.var_.moveOldPos10017 = var_160_9.localPosition
				var_160_9.localScale = Vector3.New(1, 1, 1)

				arg_157_1:CheckSpriteTmpPos("10017", 2)
			end

			local var_160_11 = 0.001

			if var_160_10 <= arg_157_1.time_ and arg_157_1.time_ < var_160_10 + var_160_11 then
				local var_160_12 = (arg_157_1.time_ - var_160_10) / var_160_11
				local var_160_13 = Vector3.New(-390, -350, -180)

				var_160_9.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos10017, var_160_13, var_160_12)
			end

			if arg_157_1.time_ >= var_160_10 + var_160_11 and arg_157_1.time_ < var_160_10 + var_160_11 + arg_160_0 then
				var_160_9.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_160_14 = arg_157_1.actors_["10017"]
			local var_160_15 = 0

			if var_160_15 < arg_157_1.time_ and arg_157_1.time_ <= var_160_15 + arg_160_0 and not isNil(var_160_14) then
				local var_160_16 = var_160_14:GetComponent("Image")

				if var_160_16 then
					arg_157_1.var_.highlightMatValue10017 = var_160_16
				end
			end

			local var_160_17 = 0.034

			if var_160_15 <= arg_157_1.time_ and arg_157_1.time_ < var_160_15 + var_160_17 and not isNil(var_160_14) then
				local var_160_18 = (arg_157_1.time_ - var_160_15) / var_160_17

				if arg_157_1.var_.highlightMatValue10017 then
					local var_160_19 = Mathf.Lerp(0.5, 1, var_160_18)
					local var_160_20 = arg_157_1.var_.highlightMatValue10017
					local var_160_21 = var_160_20.color

					var_160_21.r = var_160_19
					var_160_21.g = var_160_19
					var_160_21.b = var_160_19
					var_160_20.color = var_160_21
				end
			end

			if arg_157_1.time_ >= var_160_15 + var_160_17 and arg_157_1.time_ < var_160_15 + var_160_17 + arg_160_0 and not isNil(var_160_14) and arg_157_1.var_.highlightMatValue10017 then
				local var_160_22 = 1

				var_160_14.transform:SetSiblingIndex(1)

				local var_160_23 = arg_157_1.var_.highlightMatValue10017
				local var_160_24 = var_160_23.color

				var_160_24.r = var_160_22
				var_160_24.g = var_160_22
				var_160_24.b = var_160_22
				var_160_23.color = var_160_24
			end

			local var_160_25 = 0
			local var_160_26 = 1.125

			if var_160_25 < arg_157_1.time_ and arg_157_1.time_ <= var_160_25 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_27 = arg_157_1:FormatText(StoryNameCfg[255].name)

				arg_157_1.leftNameTxt_.text = var_160_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_28 = arg_157_1:GetWordFromCfg(114282039)
				local var_160_29 = arg_157_1:FormatText(var_160_28.content)

				arg_157_1.text_.text = var_160_29

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_30 = 44
				local var_160_31 = utf8.len(var_160_29)
				local var_160_32 = var_160_30 <= 0 and var_160_26 or var_160_26 * (var_160_31 / var_160_30)

				if var_160_32 > 0 and var_160_26 < var_160_32 then
					arg_157_1.talkMaxDuration = var_160_32

					if var_160_32 + var_160_25 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_32 + var_160_25
					end
				end

				arg_157_1.text_.text = var_160_29
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114282", "114282039", "story_v_out_114282.awb") ~= 0 then
					local var_160_33 = manager.audio:GetVoiceLength("story_v_out_114282", "114282039", "story_v_out_114282.awb") / 1000

					if var_160_33 + var_160_25 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_33 + var_160_25
					end

					if var_160_28.prefab_name ~= "" and arg_157_1.actors_[var_160_28.prefab_name] ~= nil then
						local var_160_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_28.prefab_name].transform, "story_v_out_114282", "114282039", "story_v_out_114282.awb")

						arg_157_1:RecordAudio("114282039", var_160_34)
						arg_157_1:RecordAudio("114282039", var_160_34)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_114282", "114282039", "story_v_out_114282.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_114282", "114282039", "story_v_out_114282.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_35 = math.max(var_160_26, arg_157_1.talkMaxDuration)

			if var_160_25 <= arg_157_1.time_ and arg_157_1.time_ < var_160_25 + var_160_35 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_25) / var_160_35

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_25 + var_160_35 and arg_157_1.time_ < var_160_25 + var_160_35 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10017",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_157_1:InitPlayNodeList()
	end,
	Play114282040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 114282040
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play114282041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = arg_161_1.actors_["10017"]
			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 and not isNil(var_164_0) then
				local var_164_2 = var_164_0:GetComponent("Image")

				if var_164_2 then
					arg_161_1.var_.highlightMatValue10017 = var_164_2
				end
			end

			local var_164_3 = 0.034

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_3 and not isNil(var_164_0) then
				local var_164_4 = (arg_161_1.time_ - var_164_1) / var_164_3

				if arg_161_1.var_.highlightMatValue10017 then
					local var_164_5 = Mathf.Lerp(1, 0.5, var_164_4)
					local var_164_6 = arg_161_1.var_.highlightMatValue10017
					local var_164_7 = var_164_6.color

					var_164_7.r = var_164_5
					var_164_7.g = var_164_5
					var_164_7.b = var_164_5
					var_164_6.color = var_164_7
				end
			end

			if arg_161_1.time_ >= var_164_1 + var_164_3 and arg_161_1.time_ < var_164_1 + var_164_3 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.highlightMatValue10017 then
				local var_164_8 = 0.5
				local var_164_9 = arg_161_1.var_.highlightMatValue10017
				local var_164_10 = var_164_9.color

				var_164_10.r = var_164_8
				var_164_10.g = var_164_8
				var_164_10.b = var_164_8
				var_164_9.color = var_164_10
			end

			local var_164_11 = 0
			local var_164_12 = 1.05

			if var_164_11 < arg_161_1.time_ and arg_161_1.time_ <= var_164_11 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, false)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_13 = arg_161_1:GetWordFromCfg(114282040)
				local var_164_14 = arg_161_1:FormatText(var_164_13.content)

				arg_161_1.text_.text = var_164_14

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_15 = 42
				local var_164_16 = utf8.len(var_164_14)
				local var_164_17 = var_164_15 <= 0 and var_164_12 or var_164_12 * (var_164_16 / var_164_15)

				if var_164_17 > 0 and var_164_12 < var_164_17 then
					arg_161_1.talkMaxDuration = var_164_17

					if var_164_17 + var_164_11 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_17 + var_164_11
					end
				end

				arg_161_1.text_.text = var_164_14
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_18 = math.max(var_164_12, arg_161_1.talkMaxDuration)

			if var_164_11 <= arg_161_1.time_ and arg_161_1.time_ < var_164_11 + var_164_18 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_11) / var_164_18

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_11 + var_164_18 and arg_161_1.time_ < var_164_11 + var_164_18 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play114282041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 114282041
		arg_165_1.duration_ = 10.73

		local var_165_0 = {
			ja = 10.733,
			ko = 5.366,
			zh = 6.166,
			en = 5.133
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
				arg_165_0:Play114282042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = "10015"

			if arg_165_1.actors_[var_168_0] == nil then
				local var_168_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10015")

				if not isNil(var_168_1) then
					local var_168_2 = Object.Instantiate(var_168_1, arg_165_1.canvasGo_.transform)

					var_168_2.transform:SetSiblingIndex(1)

					var_168_2.name = var_168_0
					var_168_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_165_1.actors_[var_168_0] = var_168_2

					local var_168_3 = var_168_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_165_1.isInRecall_ then
						for iter_168_0, iter_168_1 in ipairs(var_168_3) do
							iter_168_1.color = arg_165_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_168_4 = arg_165_1.actors_["10015"]
			local var_168_5 = 0

			if var_168_5 < arg_165_1.time_ and arg_165_1.time_ <= var_168_5 + arg_168_0 then
				local var_168_6 = var_168_4:GetComponentInChildren(typeof(CanvasGroup))

				if var_168_6 then
					arg_165_1.var_.alphaOldValue10015 = var_168_6.alpha
					arg_165_1.var_.characterEffect10015 = var_168_6
				end

				arg_165_1.var_.alphaOldValue10015 = 0
			end

			local var_168_7 = 0.5

			if var_168_5 <= arg_165_1.time_ and arg_165_1.time_ < var_168_5 + var_168_7 then
				local var_168_8 = (arg_165_1.time_ - var_168_5) / var_168_7
				local var_168_9 = Mathf.Lerp(arg_165_1.var_.alphaOldValue10015, 1, var_168_8)

				if arg_165_1.var_.characterEffect10015 then
					arg_165_1.var_.characterEffect10015.alpha = var_168_9
				end
			end

			if arg_165_1.time_ >= var_168_5 + var_168_7 and arg_165_1.time_ < var_168_5 + var_168_7 + arg_168_0 and arg_165_1.var_.characterEffect10015 then
				arg_165_1.var_.characterEffect10015.alpha = 1
			end

			local var_168_10 = arg_165_1.actors_["10015"].transform
			local var_168_11 = 0

			if var_168_11 < arg_165_1.time_ and arg_165_1.time_ <= var_168_11 + arg_168_0 then
				arg_165_1.var_.moveOldPos10015 = var_168_10.localPosition
				var_168_10.localScale = Vector3.New(1, 1, 1)

				arg_165_1:CheckSpriteTmpPos("10015", 4)

				local var_168_12 = var_168_10.childCount

				for iter_168_2 = 0, var_168_12 - 1 do
					local var_168_13 = var_168_10:GetChild(iter_168_2)

					if var_168_13.name == "split_1" or not string.find(var_168_13.name, "split") then
						var_168_13.gameObject:SetActive(true)
					else
						var_168_13.gameObject:SetActive(false)
					end
				end
			end

			local var_168_14 = 0.001

			if var_168_11 <= arg_165_1.time_ and arg_165_1.time_ < var_168_11 + var_168_14 then
				local var_168_15 = (arg_165_1.time_ - var_168_11) / var_168_14
				local var_168_16 = Vector3.New(390, -350, -180)

				var_168_10.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos10015, var_168_16, var_168_15)
			end

			if arg_165_1.time_ >= var_168_11 + var_168_14 and arg_165_1.time_ < var_168_11 + var_168_14 + arg_168_0 then
				var_168_10.localPosition = Vector3.New(390, -350, -180)
			end

			local var_168_17 = arg_165_1.actors_["10015"]
			local var_168_18 = 0

			if var_168_18 < arg_165_1.time_ and arg_165_1.time_ <= var_168_18 + arg_168_0 and not isNil(var_168_17) and arg_165_1.var_.actorSpriteComps10015 == nil then
				arg_165_1.var_.actorSpriteComps10015 = var_168_17:GetComponentsInChildren(typeof(Image), true)
			end

			local var_168_19 = 0.034

			if var_168_18 <= arg_165_1.time_ and arg_165_1.time_ < var_168_18 + var_168_19 and not isNil(var_168_17) then
				local var_168_20 = (arg_165_1.time_ - var_168_18) / var_168_19

				if arg_165_1.var_.actorSpriteComps10015 then
					for iter_168_3, iter_168_4 in pairs(arg_165_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_168_4 then
							if arg_165_1.isInRecall_ then
								local var_168_21 = Mathf.Lerp(iter_168_4.color.r, arg_165_1.hightColor1.r, var_168_20)
								local var_168_22 = Mathf.Lerp(iter_168_4.color.g, arg_165_1.hightColor1.g, var_168_20)
								local var_168_23 = Mathf.Lerp(iter_168_4.color.b, arg_165_1.hightColor1.b, var_168_20)

								iter_168_4.color = Color.New(var_168_21, var_168_22, var_168_23)
							else
								local var_168_24 = Mathf.Lerp(iter_168_4.color.r, 1, var_168_20)

								iter_168_4.color = Color.New(var_168_24, var_168_24, var_168_24)
							end
						end
					end
				end
			end

			if arg_165_1.time_ >= var_168_18 + var_168_19 and arg_165_1.time_ < var_168_18 + var_168_19 + arg_168_0 and not isNil(var_168_17) and arg_165_1.var_.actorSpriteComps10015 then
				for iter_168_5, iter_168_6 in pairs(arg_165_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_168_6 then
						if arg_165_1.isInRecall_ then
							iter_168_6.color = arg_165_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_168_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_165_1.var_.actorSpriteComps10015 = nil
			end

			local var_168_25 = 0
			local var_168_26 = 0.4

			if var_168_25 < arg_165_1.time_ and arg_165_1.time_ <= var_168_25 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_27 = arg_165_1:FormatText(StoryNameCfg[208].name)

				arg_165_1.leftNameTxt_.text = var_168_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_28 = arg_165_1:GetWordFromCfg(114282041)
				local var_168_29 = arg_165_1:FormatText(var_168_28.content)

				arg_165_1.text_.text = var_168_29

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_30 = 16
				local var_168_31 = utf8.len(var_168_29)
				local var_168_32 = var_168_30 <= 0 and var_168_26 or var_168_26 * (var_168_31 / var_168_30)

				if var_168_32 > 0 and var_168_26 < var_168_32 then
					arg_165_1.talkMaxDuration = var_168_32

					if var_168_32 + var_168_25 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_32 + var_168_25
					end
				end

				arg_165_1.text_.text = var_168_29
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114282", "114282041", "story_v_out_114282.awb") ~= 0 then
					local var_168_33 = manager.audio:GetVoiceLength("story_v_out_114282", "114282041", "story_v_out_114282.awb") / 1000

					if var_168_33 + var_168_25 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_33 + var_168_25
					end

					if var_168_28.prefab_name ~= "" and arg_165_1.actors_[var_168_28.prefab_name] ~= nil then
						local var_168_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_28.prefab_name].transform, "story_v_out_114282", "114282041", "story_v_out_114282.awb")

						arg_165_1:RecordAudio("114282041", var_168_34)
						arg_165_1:RecordAudio("114282041", var_168_34)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_114282", "114282041", "story_v_out_114282.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_114282", "114282041", "story_v_out_114282.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_35 = math.max(var_168_26, arg_165_1.talkMaxDuration)

			if var_168_25 <= arg_165_1.time_ and arg_165_1.time_ < var_168_25 + var_168_35 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_25) / var_168_35

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_25 + var_168_35 and arg_165_1.time_ < var_168_25 + var_168_35 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
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

		arg_165_1:InitPlayNodeList()
	end,
	Play114282042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 114282042
		arg_169_1.duration_ = 2.17

		local var_169_0 = {
			ja = 2.166,
			ko = 1.033,
			zh = 1.3,
			en = 1.3
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
				arg_169_0:Play114282043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.actors_["10017"]
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 and not isNil(var_172_0) then
				local var_172_2 = var_172_0:GetComponent("Image")

				if var_172_2 then
					arg_169_1.var_.highlightMatValue10017 = var_172_2
				end
			end

			local var_172_3 = 0.034

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_3 and not isNil(var_172_0) then
				local var_172_4 = (arg_169_1.time_ - var_172_1) / var_172_3

				if arg_169_1.var_.highlightMatValue10017 then
					local var_172_5 = Mathf.Lerp(0.5, 1, var_172_4)
					local var_172_6 = arg_169_1.var_.highlightMatValue10017
					local var_172_7 = var_172_6.color

					var_172_7.r = var_172_5
					var_172_7.g = var_172_5
					var_172_7.b = var_172_5
					var_172_6.color = var_172_7
				end
			end

			if arg_169_1.time_ >= var_172_1 + var_172_3 and arg_169_1.time_ < var_172_1 + var_172_3 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.highlightMatValue10017 then
				local var_172_8 = 1

				var_172_0.transform:SetSiblingIndex(1)

				local var_172_9 = arg_169_1.var_.highlightMatValue10017
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
			local var_172_20 = 0.075

			if var_172_19 < arg_169_1.time_ and arg_169_1.time_ <= var_172_19 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_21 = arg_169_1:FormatText(StoryNameCfg[255].name)

				arg_169_1.leftNameTxt_.text = var_172_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_22 = arg_169_1:GetWordFromCfg(114282042)
				local var_172_23 = arg_169_1:FormatText(var_172_22.content)

				arg_169_1.text_.text = var_172_23

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_24 = 3
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

				if manager.audio:GetVoiceLength("story_v_out_114282", "114282042", "story_v_out_114282.awb") ~= 0 then
					local var_172_27 = manager.audio:GetVoiceLength("story_v_out_114282", "114282042", "story_v_out_114282.awb") / 1000

					if var_172_27 + var_172_19 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_27 + var_172_19
					end

					if var_172_22.prefab_name ~= "" and arg_169_1.actors_[var_172_22.prefab_name] ~= nil then
						local var_172_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_22.prefab_name].transform, "story_v_out_114282", "114282042", "story_v_out_114282.awb")

						arg_169_1:RecordAudio("114282042", var_172_28)
						arg_169_1:RecordAudio("114282042", var_172_28)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_114282", "114282042", "story_v_out_114282.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_114282", "114282042", "story_v_out_114282.awb")
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
	Play114282043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 114282043
		arg_173_1.duration_ = 4.77

		local var_173_0 = {
			ja = 4.766,
			ko = 4.333,
			zh = 3.766,
			en = 4.433
		}
		local var_173_1 = manager.audio:GetLocalizationFlag()

		if var_173_0[var_173_1] ~= nil then
			arg_173_1.duration_ = var_173_0[var_173_1]
		end

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play114282044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["10015"]
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.actorSpriteComps10015 == nil then
				arg_173_1.var_.actorSpriteComps10015 = var_176_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_176_2 = 0.034

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_2 and not isNil(var_176_0) then
				local var_176_3 = (arg_173_1.time_ - var_176_1) / var_176_2

				if arg_173_1.var_.actorSpriteComps10015 then
					for iter_176_0, iter_176_1 in pairs(arg_173_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_176_1 then
							if arg_173_1.isInRecall_ then
								local var_176_4 = Mathf.Lerp(iter_176_1.color.r, arg_173_1.hightColor1.r, var_176_3)
								local var_176_5 = Mathf.Lerp(iter_176_1.color.g, arg_173_1.hightColor1.g, var_176_3)
								local var_176_6 = Mathf.Lerp(iter_176_1.color.b, arg_173_1.hightColor1.b, var_176_3)

								iter_176_1.color = Color.New(var_176_4, var_176_5, var_176_6)
							else
								local var_176_7 = Mathf.Lerp(iter_176_1.color.r, 1, var_176_3)

								iter_176_1.color = Color.New(var_176_7, var_176_7, var_176_7)
							end
						end
					end
				end
			end

			if arg_173_1.time_ >= var_176_1 + var_176_2 and arg_173_1.time_ < var_176_1 + var_176_2 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.actorSpriteComps10015 then
				for iter_176_2, iter_176_3 in pairs(arg_173_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_176_3 then
						if arg_173_1.isInRecall_ then
							iter_176_3.color = arg_173_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_176_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_173_1.var_.actorSpriteComps10015 = nil
			end

			local var_176_8 = arg_173_1.actors_["10017"]
			local var_176_9 = 0

			if var_176_9 < arg_173_1.time_ and arg_173_1.time_ <= var_176_9 + arg_176_0 and not isNil(var_176_8) then
				local var_176_10 = var_176_8:GetComponent("Image")

				if var_176_10 then
					arg_173_1.var_.highlightMatValue10017 = var_176_10
				end
			end

			local var_176_11 = 0.034

			if var_176_9 <= arg_173_1.time_ and arg_173_1.time_ < var_176_9 + var_176_11 and not isNil(var_176_8) then
				local var_176_12 = (arg_173_1.time_ - var_176_9) / var_176_11

				if arg_173_1.var_.highlightMatValue10017 then
					local var_176_13 = Mathf.Lerp(1, 0.5, var_176_12)
					local var_176_14 = arg_173_1.var_.highlightMatValue10017
					local var_176_15 = var_176_14.color

					var_176_15.r = var_176_13
					var_176_15.g = var_176_13
					var_176_15.b = var_176_13
					var_176_14.color = var_176_15
				end
			end

			if arg_173_1.time_ >= var_176_9 + var_176_11 and arg_173_1.time_ < var_176_9 + var_176_11 + arg_176_0 and not isNil(var_176_8) and arg_173_1.var_.highlightMatValue10017 then
				local var_176_16 = 0.5
				local var_176_17 = arg_173_1.var_.highlightMatValue10017
				local var_176_18 = var_176_17.color

				var_176_18.r = var_176_16
				var_176_18.g = var_176_16
				var_176_18.b = var_176_16
				var_176_17.color = var_176_18
			end

			local var_176_19 = 0
			local var_176_20 = 0.4

			if var_176_19 < arg_173_1.time_ and arg_173_1.time_ <= var_176_19 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_21 = arg_173_1:FormatText(StoryNameCfg[208].name)

				arg_173_1.leftNameTxt_.text = var_176_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_22 = arg_173_1:GetWordFromCfg(114282043)
				local var_176_23 = arg_173_1:FormatText(var_176_22.content)

				arg_173_1.text_.text = var_176_23

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_24 = 16
				local var_176_25 = utf8.len(var_176_23)
				local var_176_26 = var_176_24 <= 0 and var_176_20 or var_176_20 * (var_176_25 / var_176_24)

				if var_176_26 > 0 and var_176_20 < var_176_26 then
					arg_173_1.talkMaxDuration = var_176_26

					if var_176_26 + var_176_19 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_26 + var_176_19
					end
				end

				arg_173_1.text_.text = var_176_23
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114282", "114282043", "story_v_out_114282.awb") ~= 0 then
					local var_176_27 = manager.audio:GetVoiceLength("story_v_out_114282", "114282043", "story_v_out_114282.awb") / 1000

					if var_176_27 + var_176_19 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_27 + var_176_19
					end

					if var_176_22.prefab_name ~= "" and arg_173_1.actors_[var_176_22.prefab_name] ~= nil then
						local var_176_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_22.prefab_name].transform, "story_v_out_114282", "114282043", "story_v_out_114282.awb")

						arg_173_1:RecordAudio("114282043", var_176_28)
						arg_173_1:RecordAudio("114282043", var_176_28)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_114282", "114282043", "story_v_out_114282.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_114282", "114282043", "story_v_out_114282.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_29 = math.max(var_176_20, arg_173_1.talkMaxDuration)

			if var_176_19 <= arg_173_1.time_ and arg_173_1.time_ < var_176_19 + var_176_29 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_19) / var_176_29

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_19 + var_176_29 and arg_173_1.time_ < var_176_19 + var_176_29 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play114282044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 114282044
		arg_177_1.duration_ = 5.7

		local var_177_0 = {
			ja = 3.5,
			ko = 4.6,
			zh = 5.066,
			en = 5.7
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
				arg_177_0:Play114282045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["10017"]
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 and not isNil(var_180_0) then
				local var_180_2 = var_180_0:GetComponent("Image")

				if var_180_2 then
					arg_177_1.var_.highlightMatValue10017 = var_180_2
				end
			end

			local var_180_3 = 0.034

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_3 and not isNil(var_180_0) then
				local var_180_4 = (arg_177_1.time_ - var_180_1) / var_180_3

				if arg_177_1.var_.highlightMatValue10017 then
					local var_180_5 = Mathf.Lerp(0.5, 1, var_180_4)
					local var_180_6 = arg_177_1.var_.highlightMatValue10017
					local var_180_7 = var_180_6.color

					var_180_7.r = var_180_5
					var_180_7.g = var_180_5
					var_180_7.b = var_180_5
					var_180_6.color = var_180_7
				end
			end

			if arg_177_1.time_ >= var_180_1 + var_180_3 and arg_177_1.time_ < var_180_1 + var_180_3 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.highlightMatValue10017 then
				local var_180_8 = 1

				var_180_0.transform:SetSiblingIndex(1)

				local var_180_9 = arg_177_1.var_.highlightMatValue10017
				local var_180_10 = var_180_9.color

				var_180_10.r = var_180_8
				var_180_10.g = var_180_8
				var_180_10.b = var_180_8
				var_180_9.color = var_180_10
			end

			local var_180_11 = arg_177_1.actors_["10015"]
			local var_180_12 = 0

			if var_180_12 < arg_177_1.time_ and arg_177_1.time_ <= var_180_12 + arg_180_0 and not isNil(var_180_11) and arg_177_1.var_.actorSpriteComps10015 == nil then
				arg_177_1.var_.actorSpriteComps10015 = var_180_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_13 = 0.034

			if var_180_12 <= arg_177_1.time_ and arg_177_1.time_ < var_180_12 + var_180_13 and not isNil(var_180_11) then
				local var_180_14 = (arg_177_1.time_ - var_180_12) / var_180_13

				if arg_177_1.var_.actorSpriteComps10015 then
					for iter_180_0, iter_180_1 in pairs(arg_177_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_180_1 then
							if arg_177_1.isInRecall_ then
								local var_180_15 = Mathf.Lerp(iter_180_1.color.r, arg_177_1.hightColor2.r, var_180_14)
								local var_180_16 = Mathf.Lerp(iter_180_1.color.g, arg_177_1.hightColor2.g, var_180_14)
								local var_180_17 = Mathf.Lerp(iter_180_1.color.b, arg_177_1.hightColor2.b, var_180_14)

								iter_180_1.color = Color.New(var_180_15, var_180_16, var_180_17)
							else
								local var_180_18 = Mathf.Lerp(iter_180_1.color.r, 0.5, var_180_14)

								iter_180_1.color = Color.New(var_180_18, var_180_18, var_180_18)
							end
						end
					end
				end
			end

			if arg_177_1.time_ >= var_180_12 + var_180_13 and arg_177_1.time_ < var_180_12 + var_180_13 + arg_180_0 and not isNil(var_180_11) and arg_177_1.var_.actorSpriteComps10015 then
				for iter_180_2, iter_180_3 in pairs(arg_177_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_180_3 then
						if arg_177_1.isInRecall_ then
							iter_180_3.color = arg_177_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_180_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_177_1.var_.actorSpriteComps10015 = nil
			end

			local var_180_19 = 0
			local var_180_20 = 0.625

			if var_180_19 < arg_177_1.time_ and arg_177_1.time_ <= var_180_19 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_21 = arg_177_1:FormatText(StoryNameCfg[255].name)

				arg_177_1.leftNameTxt_.text = var_180_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_22 = arg_177_1:GetWordFromCfg(114282044)
				local var_180_23 = arg_177_1:FormatText(var_180_22.content)

				arg_177_1.text_.text = var_180_23

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_24 = 25
				local var_180_25 = utf8.len(var_180_23)
				local var_180_26 = var_180_24 <= 0 and var_180_20 or var_180_20 * (var_180_25 / var_180_24)

				if var_180_26 > 0 and var_180_20 < var_180_26 then
					arg_177_1.talkMaxDuration = var_180_26

					if var_180_26 + var_180_19 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_26 + var_180_19
					end
				end

				arg_177_1.text_.text = var_180_23
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114282", "114282044", "story_v_out_114282.awb") ~= 0 then
					local var_180_27 = manager.audio:GetVoiceLength("story_v_out_114282", "114282044", "story_v_out_114282.awb") / 1000

					if var_180_27 + var_180_19 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_27 + var_180_19
					end

					if var_180_22.prefab_name ~= "" and arg_177_1.actors_[var_180_22.prefab_name] ~= nil then
						local var_180_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_22.prefab_name].transform, "story_v_out_114282", "114282044", "story_v_out_114282.awb")

						arg_177_1:RecordAudio("114282044", var_180_28)
						arg_177_1:RecordAudio("114282044", var_180_28)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_114282", "114282044", "story_v_out_114282.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_114282", "114282044", "story_v_out_114282.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_29 = math.max(var_180_20, arg_177_1.talkMaxDuration)

			if var_180_19 <= arg_177_1.time_ and arg_177_1.time_ < var_180_19 + var_180_29 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_19) / var_180_29

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_19 + var_180_29 and arg_177_1.time_ < var_180_19 + var_180_29 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play114282045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 114282045
		arg_181_1.duration_ = 10.77

		local var_181_0 = {
			ja = 10.766,
			ko = 8.6,
			zh = 7.766,
			en = 10.033
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
				arg_181_0:Play114282046(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["10023"].transform
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 then
				arg_181_1.var_.moveOldPos10023 = var_184_0.localPosition
				var_184_0.localScale = Vector3.New(1, 1, 1)

				arg_181_1:CheckSpriteTmpPos("10023", 2)
			end

			local var_184_2 = 0.001

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_2 then
				local var_184_3 = (arg_181_1.time_ - var_184_1) / var_184_2
				local var_184_4 = Vector3.New(-390, -350, -180)

				var_184_0.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos10023, var_184_4, var_184_3)
			end

			if arg_181_1.time_ >= var_184_1 + var_184_2 and arg_181_1.time_ < var_184_1 + var_184_2 + arg_184_0 then
				var_184_0.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_184_5 = arg_181_1.actors_["10023"]
			local var_184_6 = 0

			if var_184_6 < arg_181_1.time_ and arg_181_1.time_ <= var_184_6 + arg_184_0 and not isNil(var_184_5) then
				local var_184_7 = var_184_5:GetComponent("Image")

				if var_184_7 then
					arg_181_1.var_.highlightMatValue10023 = var_184_7
				end
			end

			local var_184_8 = 0.034

			if var_184_6 <= arg_181_1.time_ and arg_181_1.time_ < var_184_6 + var_184_8 and not isNil(var_184_5) then
				local var_184_9 = (arg_181_1.time_ - var_184_6) / var_184_8

				if arg_181_1.var_.highlightMatValue10023 then
					local var_184_10 = Mathf.Lerp(0.5, 1, var_184_9)
					local var_184_11 = arg_181_1.var_.highlightMatValue10023
					local var_184_12 = var_184_11.color

					var_184_12.r = var_184_10
					var_184_12.g = var_184_10
					var_184_12.b = var_184_10
					var_184_11.color = var_184_12
				end
			end

			if arg_181_1.time_ >= var_184_6 + var_184_8 and arg_181_1.time_ < var_184_6 + var_184_8 + arg_184_0 and not isNil(var_184_5) and arg_181_1.var_.highlightMatValue10023 then
				local var_184_13 = 1

				var_184_5.transform:SetSiblingIndex(1)

				local var_184_14 = arg_181_1.var_.highlightMatValue10023
				local var_184_15 = var_184_14.color

				var_184_15.r = var_184_13
				var_184_15.g = var_184_13
				var_184_15.b = var_184_13
				var_184_14.color = var_184_15
			end

			local var_184_16 = arg_181_1.actors_["10023"]
			local var_184_17 = 0

			if var_184_17 < arg_181_1.time_ and arg_181_1.time_ <= var_184_17 + arg_184_0 then
				local var_184_18 = var_184_16:GetComponent("Image")

				if var_184_18 then
					arg_181_1.var_.alphaMatValue10023 = var_184_18
					arg_181_1.var_.alphaOldValue10023 = var_184_18.color.a
				end

				arg_181_1.var_.alphaOldValue10023 = 0
			end

			local var_184_19 = 0.5

			if var_184_17 <= arg_181_1.time_ and arg_181_1.time_ < var_184_17 + var_184_19 then
				local var_184_20 = (arg_181_1.time_ - var_184_17) / var_184_19
				local var_184_21 = Mathf.Lerp(arg_181_1.var_.alphaOldValue10023, 1, var_184_20)

				if arg_181_1.var_.alphaMatValue10023 then
					local var_184_22 = arg_181_1.var_.alphaMatValue10023.color

					var_184_22.a = var_184_21
					arg_181_1.var_.alphaMatValue10023.color = var_184_22
				end
			end

			if arg_181_1.time_ >= var_184_17 + var_184_19 and arg_181_1.time_ < var_184_17 + var_184_19 + arg_184_0 and arg_181_1.var_.alphaMatValue10023 then
				local var_184_23 = arg_181_1.var_.alphaMatValue10023
				local var_184_24 = var_184_23.color

				var_184_24.a = 1
				var_184_23.color = var_184_24
			end

			local var_184_25 = 0
			local var_184_26 = 0.825

			if var_184_25 < arg_181_1.time_ and arg_181_1.time_ <= var_184_25 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_27 = arg_181_1:FormatText(StoryNameCfg[259].name)

				arg_181_1.leftNameTxt_.text = var_184_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_28 = arg_181_1:GetWordFromCfg(114282045)
				local var_184_29 = arg_181_1:FormatText(var_184_28.content)

				arg_181_1.text_.text = var_184_29

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_30 = 33
				local var_184_31 = utf8.len(var_184_29)
				local var_184_32 = var_184_30 <= 0 and var_184_26 or var_184_26 * (var_184_31 / var_184_30)

				if var_184_32 > 0 and var_184_26 < var_184_32 then
					arg_181_1.talkMaxDuration = var_184_32

					if var_184_32 + var_184_25 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_32 + var_184_25
					end
				end

				arg_181_1.text_.text = var_184_29
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114282", "114282045", "story_v_out_114282.awb") ~= 0 then
					local var_184_33 = manager.audio:GetVoiceLength("story_v_out_114282", "114282045", "story_v_out_114282.awb") / 1000

					if var_184_33 + var_184_25 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_33 + var_184_25
					end

					if var_184_28.prefab_name ~= "" and arg_181_1.actors_[var_184_28.prefab_name] ~= nil then
						local var_184_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_28.prefab_name].transform, "story_v_out_114282", "114282045", "story_v_out_114282.awb")

						arg_181_1:RecordAudio("114282045", var_184_34)
						arg_181_1:RecordAudio("114282045", var_184_34)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_114282", "114282045", "story_v_out_114282.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_114282", "114282045", "story_v_out_114282.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_35 = math.max(var_184_26, arg_181_1.talkMaxDuration)

			if var_184_25 <= arg_181_1.time_ and arg_181_1.time_ < var_184_25 + var_184_35 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_25) / var_184_35

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_25 + var_184_35 and arg_181_1.time_ < var_184_25 + var_184_35 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10023",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_181_1:InitPlayNodeList()
	end,
	Play114282046 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 114282046
		arg_185_1.duration_ = 12.43

		local var_185_0 = {
			ja = 12.433,
			ko = 5.133,
			zh = 4.633,
			en = 3.033
		}
		local var_185_1 = manager.audio:GetLocalizationFlag()

		if var_185_0[var_185_1] ~= nil then
			arg_185_1.duration_ = var_185_0[var_185_1]
		end

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play114282047(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.actors_["10015"]
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.actorSpriteComps10015 == nil then
				arg_185_1.var_.actorSpriteComps10015 = var_188_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_188_2 = 0.034

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_2 and not isNil(var_188_0) then
				local var_188_3 = (arg_185_1.time_ - var_188_1) / var_188_2

				if arg_185_1.var_.actorSpriteComps10015 then
					for iter_188_0, iter_188_1 in pairs(arg_185_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_188_1 then
							if arg_185_1.isInRecall_ then
								local var_188_4 = Mathf.Lerp(iter_188_1.color.r, arg_185_1.hightColor1.r, var_188_3)
								local var_188_5 = Mathf.Lerp(iter_188_1.color.g, arg_185_1.hightColor1.g, var_188_3)
								local var_188_6 = Mathf.Lerp(iter_188_1.color.b, arg_185_1.hightColor1.b, var_188_3)

								iter_188_1.color = Color.New(var_188_4, var_188_5, var_188_6)
							else
								local var_188_7 = Mathf.Lerp(iter_188_1.color.r, 1, var_188_3)

								iter_188_1.color = Color.New(var_188_7, var_188_7, var_188_7)
							end
						end
					end
				end
			end

			if arg_185_1.time_ >= var_188_1 + var_188_2 and arg_185_1.time_ < var_188_1 + var_188_2 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.actorSpriteComps10015 then
				for iter_188_2, iter_188_3 in pairs(arg_185_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_188_3 then
						if arg_185_1.isInRecall_ then
							iter_188_3.color = arg_185_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_188_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_185_1.var_.actorSpriteComps10015 = nil
			end

			local var_188_8 = arg_185_1.actors_["10023"]
			local var_188_9 = 0

			if var_188_9 < arg_185_1.time_ and arg_185_1.time_ <= var_188_9 + arg_188_0 and not isNil(var_188_8) then
				local var_188_10 = var_188_8:GetComponent("Image")

				if var_188_10 then
					arg_185_1.var_.highlightMatValue10023 = var_188_10
				end
			end

			local var_188_11 = 0.034

			if var_188_9 <= arg_185_1.time_ and arg_185_1.time_ < var_188_9 + var_188_11 and not isNil(var_188_8) then
				local var_188_12 = (arg_185_1.time_ - var_188_9) / var_188_11

				if arg_185_1.var_.highlightMatValue10023 then
					local var_188_13 = Mathf.Lerp(1, 0.5, var_188_12)
					local var_188_14 = arg_185_1.var_.highlightMatValue10023
					local var_188_15 = var_188_14.color

					var_188_15.r = var_188_13
					var_188_15.g = var_188_13
					var_188_15.b = var_188_13
					var_188_14.color = var_188_15
				end
			end

			if arg_185_1.time_ >= var_188_9 + var_188_11 and arg_185_1.time_ < var_188_9 + var_188_11 + arg_188_0 and not isNil(var_188_8) and arg_185_1.var_.highlightMatValue10023 then
				local var_188_16 = 0.5
				local var_188_17 = arg_185_1.var_.highlightMatValue10023
				local var_188_18 = var_188_17.color

				var_188_18.r = var_188_16
				var_188_18.g = var_188_16
				var_188_18.b = var_188_16
				var_188_17.color = var_188_18
			end

			local var_188_19 = 0
			local var_188_20 = 0.425

			if var_188_19 < arg_185_1.time_ and arg_185_1.time_ <= var_188_19 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_21 = arg_185_1:FormatText(StoryNameCfg[208].name)

				arg_185_1.leftNameTxt_.text = var_188_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_22 = arg_185_1:GetWordFromCfg(114282046)
				local var_188_23 = arg_185_1:FormatText(var_188_22.content)

				arg_185_1.text_.text = var_188_23

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_24 = 17
				local var_188_25 = utf8.len(var_188_23)
				local var_188_26 = var_188_24 <= 0 and var_188_20 or var_188_20 * (var_188_25 / var_188_24)

				if var_188_26 > 0 and var_188_20 < var_188_26 then
					arg_185_1.talkMaxDuration = var_188_26

					if var_188_26 + var_188_19 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_26 + var_188_19
					end
				end

				arg_185_1.text_.text = var_188_23
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114282", "114282046", "story_v_out_114282.awb") ~= 0 then
					local var_188_27 = manager.audio:GetVoiceLength("story_v_out_114282", "114282046", "story_v_out_114282.awb") / 1000

					if var_188_27 + var_188_19 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_27 + var_188_19
					end

					if var_188_22.prefab_name ~= "" and arg_185_1.actors_[var_188_22.prefab_name] ~= nil then
						local var_188_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_22.prefab_name].transform, "story_v_out_114282", "114282046", "story_v_out_114282.awb")

						arg_185_1:RecordAudio("114282046", var_188_28)
						arg_185_1:RecordAudio("114282046", var_188_28)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_114282", "114282046", "story_v_out_114282.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_114282", "114282046", "story_v_out_114282.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_29 = math.max(var_188_20, arg_185_1.talkMaxDuration)

			if var_188_19 <= arg_185_1.time_ and arg_185_1.time_ < var_188_19 + var_188_29 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_19) / var_188_29

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_19 + var_188_29 and arg_185_1.time_ < var_188_19 + var_188_29 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play114282047 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 114282047
		arg_189_1.duration_ = 1.87

		local var_189_0 = {
			ja = 1.366,
			ko = 1.266,
			zh = 1.6,
			en = 1.866
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
				arg_189_0:Play114282048(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["10017"].transform
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 then
				arg_189_1.var_.moveOldPos10017 = var_192_0.localPosition
				var_192_0.localScale = Vector3.New(1, 1, 1)

				arg_189_1:CheckSpriteTmpPos("10017", 2)
			end

			local var_192_2 = 0.001

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_2 then
				local var_192_3 = (arg_189_1.time_ - var_192_1) / var_192_2
				local var_192_4 = Vector3.New(-390, -350, -180)

				var_192_0.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos10017, var_192_4, var_192_3)
			end

			if arg_189_1.time_ >= var_192_1 + var_192_2 and arg_189_1.time_ < var_192_1 + var_192_2 + arg_192_0 then
				var_192_0.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_192_5 = arg_189_1.actors_["10017"]
			local var_192_6 = 0

			if var_192_6 < arg_189_1.time_ and arg_189_1.time_ <= var_192_6 + arg_192_0 and not isNil(var_192_5) then
				local var_192_7 = var_192_5:GetComponent("Image")

				if var_192_7 then
					arg_189_1.var_.highlightMatValue10017 = var_192_7
				end
			end

			local var_192_8 = 0.034

			if var_192_6 <= arg_189_1.time_ and arg_189_1.time_ < var_192_6 + var_192_8 and not isNil(var_192_5) then
				local var_192_9 = (arg_189_1.time_ - var_192_6) / var_192_8

				if arg_189_1.var_.highlightMatValue10017 then
					local var_192_10 = Mathf.Lerp(0.5, 1, var_192_9)
					local var_192_11 = arg_189_1.var_.highlightMatValue10017
					local var_192_12 = var_192_11.color

					var_192_12.r = var_192_10
					var_192_12.g = var_192_10
					var_192_12.b = var_192_10
					var_192_11.color = var_192_12
				end
			end

			if arg_189_1.time_ >= var_192_6 + var_192_8 and arg_189_1.time_ < var_192_6 + var_192_8 + arg_192_0 and not isNil(var_192_5) and arg_189_1.var_.highlightMatValue10017 then
				local var_192_13 = 1

				var_192_5.transform:SetSiblingIndex(1)

				local var_192_14 = arg_189_1.var_.highlightMatValue10017
				local var_192_15 = var_192_14.color

				var_192_15.r = var_192_13
				var_192_15.g = var_192_13
				var_192_15.b = var_192_13
				var_192_14.color = var_192_15
			end

			local var_192_16 = arg_189_1.actors_["10015"]
			local var_192_17 = 0

			if var_192_17 < arg_189_1.time_ and arg_189_1.time_ <= var_192_17 + arg_192_0 and not isNil(var_192_16) and arg_189_1.var_.actorSpriteComps10015 == nil then
				arg_189_1.var_.actorSpriteComps10015 = var_192_16:GetComponentsInChildren(typeof(Image), true)
			end

			local var_192_18 = 0.034

			if var_192_17 <= arg_189_1.time_ and arg_189_1.time_ < var_192_17 + var_192_18 and not isNil(var_192_16) then
				local var_192_19 = (arg_189_1.time_ - var_192_17) / var_192_18

				if arg_189_1.var_.actorSpriteComps10015 then
					for iter_192_0, iter_192_1 in pairs(arg_189_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_192_1 then
							if arg_189_1.isInRecall_ then
								local var_192_20 = Mathf.Lerp(iter_192_1.color.r, arg_189_1.hightColor2.r, var_192_19)
								local var_192_21 = Mathf.Lerp(iter_192_1.color.g, arg_189_1.hightColor2.g, var_192_19)
								local var_192_22 = Mathf.Lerp(iter_192_1.color.b, arg_189_1.hightColor2.b, var_192_19)

								iter_192_1.color = Color.New(var_192_20, var_192_21, var_192_22)
							else
								local var_192_23 = Mathf.Lerp(iter_192_1.color.r, 0.5, var_192_19)

								iter_192_1.color = Color.New(var_192_23, var_192_23, var_192_23)
							end
						end
					end
				end
			end

			if arg_189_1.time_ >= var_192_17 + var_192_18 and arg_189_1.time_ < var_192_17 + var_192_18 + arg_192_0 and not isNil(var_192_16) and arg_189_1.var_.actorSpriteComps10015 then
				for iter_192_2, iter_192_3 in pairs(arg_189_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_192_3 then
						if arg_189_1.isInRecall_ then
							iter_192_3.color = arg_189_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_192_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_189_1.var_.actorSpriteComps10015 = nil
			end

			local var_192_24 = arg_189_1.actors_["10017"]
			local var_192_25 = 0

			if var_192_25 < arg_189_1.time_ and arg_189_1.time_ <= var_192_25 + arg_192_0 then
				local var_192_26 = var_192_24:GetComponent("Image")

				if var_192_26 then
					arg_189_1.var_.alphaMatValue10017 = var_192_26
					arg_189_1.var_.alphaOldValue10017 = var_192_26.color.a
				end

				arg_189_1.var_.alphaOldValue10017 = 0
			end

			local var_192_27 = 0.5

			if var_192_25 <= arg_189_1.time_ and arg_189_1.time_ < var_192_25 + var_192_27 then
				local var_192_28 = (arg_189_1.time_ - var_192_25) / var_192_27
				local var_192_29 = Mathf.Lerp(arg_189_1.var_.alphaOldValue10017, 1, var_192_28)

				if arg_189_1.var_.alphaMatValue10017 then
					local var_192_30 = arg_189_1.var_.alphaMatValue10017.color

					var_192_30.a = var_192_29
					arg_189_1.var_.alphaMatValue10017.color = var_192_30
				end
			end

			if arg_189_1.time_ >= var_192_25 + var_192_27 and arg_189_1.time_ < var_192_25 + var_192_27 + arg_192_0 and arg_189_1.var_.alphaMatValue10017 then
				local var_192_31 = arg_189_1.var_.alphaMatValue10017
				local var_192_32 = var_192_31.color

				var_192_32.a = 1
				var_192_31.color = var_192_32
			end

			local var_192_33 = 0
			local var_192_34 = 0.05

			if var_192_33 < arg_189_1.time_ and arg_189_1.time_ <= var_192_33 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_35 = arg_189_1:FormatText(StoryNameCfg[255].name)

				arg_189_1.leftNameTxt_.text = var_192_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_36 = arg_189_1:GetWordFromCfg(114282047)
				local var_192_37 = arg_189_1:FormatText(var_192_36.content)

				arg_189_1.text_.text = var_192_37

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_38 = 2
				local var_192_39 = utf8.len(var_192_37)
				local var_192_40 = var_192_38 <= 0 and var_192_34 or var_192_34 * (var_192_39 / var_192_38)

				if var_192_40 > 0 and var_192_34 < var_192_40 then
					arg_189_1.talkMaxDuration = var_192_40

					if var_192_40 + var_192_33 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_40 + var_192_33
					end
				end

				arg_189_1.text_.text = var_192_37
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114282", "114282047", "story_v_out_114282.awb") ~= 0 then
					local var_192_41 = manager.audio:GetVoiceLength("story_v_out_114282", "114282047", "story_v_out_114282.awb") / 1000

					if var_192_41 + var_192_33 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_41 + var_192_33
					end

					if var_192_36.prefab_name ~= "" and arg_189_1.actors_[var_192_36.prefab_name] ~= nil then
						local var_192_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_36.prefab_name].transform, "story_v_out_114282", "114282047", "story_v_out_114282.awb")

						arg_189_1:RecordAudio("114282047", var_192_42)
						arg_189_1:RecordAudio("114282047", var_192_42)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_114282", "114282047", "story_v_out_114282.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_114282", "114282047", "story_v_out_114282.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_43 = math.max(var_192_34, arg_189_1.talkMaxDuration)

			if var_192_33 <= arg_189_1.time_ and arg_189_1.time_ < var_192_33 + var_192_43 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_33) / var_192_43

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_33 + var_192_43 and arg_189_1.time_ < var_192_33 + var_192_43 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10017",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_189_1:InitPlayNodeList()
	end,
	Play114282048 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 114282048
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play114282049(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["10017"]
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 and not isNil(var_196_0) then
				local var_196_2 = var_196_0:GetComponent("Image")

				if var_196_2 then
					arg_193_1.var_.highlightMatValue10017 = var_196_2
				end
			end

			local var_196_3 = 0.034

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_3 and not isNil(var_196_0) then
				local var_196_4 = (arg_193_1.time_ - var_196_1) / var_196_3

				if arg_193_1.var_.highlightMatValue10017 then
					local var_196_5 = Mathf.Lerp(1, 0.5, var_196_4)
					local var_196_6 = arg_193_1.var_.highlightMatValue10017
					local var_196_7 = var_196_6.color

					var_196_7.r = var_196_5
					var_196_7.g = var_196_5
					var_196_7.b = var_196_5
					var_196_6.color = var_196_7
				end
			end

			if arg_193_1.time_ >= var_196_1 + var_196_3 and arg_193_1.time_ < var_196_1 + var_196_3 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.highlightMatValue10017 then
				local var_196_8 = 0.5
				local var_196_9 = arg_193_1.var_.highlightMatValue10017
				local var_196_10 = var_196_9.color

				var_196_10.r = var_196_8
				var_196_10.g = var_196_8
				var_196_10.b = var_196_8
				var_196_9.color = var_196_10
			end

			local var_196_11 = 0
			local var_196_12 = 0.775

			if var_196_11 < arg_193_1.time_ and arg_193_1.time_ <= var_196_11 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, false)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_13 = arg_193_1:GetWordFromCfg(114282048)
				local var_196_14 = arg_193_1:FormatText(var_196_13.content)

				arg_193_1.text_.text = var_196_14

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_15 = 31
				local var_196_16 = utf8.len(var_196_14)
				local var_196_17 = var_196_15 <= 0 and var_196_12 or var_196_12 * (var_196_16 / var_196_15)

				if var_196_17 > 0 and var_196_12 < var_196_17 then
					arg_193_1.talkMaxDuration = var_196_17

					if var_196_17 + var_196_11 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_17 + var_196_11
					end
				end

				arg_193_1.text_.text = var_196_14
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_18 = math.max(var_196_12, arg_193_1.talkMaxDuration)

			if var_196_11 <= arg_193_1.time_ and arg_193_1.time_ < var_196_11 + var_196_18 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_11) / var_196_18

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_11 + var_196_18 and arg_193_1.time_ < var_196_11 + var_196_18 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play114282049 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 114282049
		arg_197_1.duration_ = 11.33

		local var_197_0 = {
			ja = 9.2,
			ko = 10.9,
			zh = 7.933,
			en = 11.333
		}
		local var_197_1 = manager.audio:GetLocalizationFlag()

		if var_197_0[var_197_1] ~= nil then
			arg_197_1.duration_ = var_197_0[var_197_1]
		end

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play114282050(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = arg_197_1.actors_["10017"]
			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 and not isNil(var_200_0) then
				local var_200_2 = var_200_0:GetComponent("Image")

				if var_200_2 then
					arg_197_1.var_.highlightMatValue10017 = var_200_2
				end
			end

			local var_200_3 = 0.034

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_3 and not isNil(var_200_0) then
				local var_200_4 = (arg_197_1.time_ - var_200_1) / var_200_3

				if arg_197_1.var_.highlightMatValue10017 then
					local var_200_5 = Mathf.Lerp(0.5, 1, var_200_4)
					local var_200_6 = arg_197_1.var_.highlightMatValue10017
					local var_200_7 = var_200_6.color

					var_200_7.r = var_200_5
					var_200_7.g = var_200_5
					var_200_7.b = var_200_5
					var_200_6.color = var_200_7
				end
			end

			if arg_197_1.time_ >= var_200_1 + var_200_3 and arg_197_1.time_ < var_200_1 + var_200_3 + arg_200_0 and not isNil(var_200_0) and arg_197_1.var_.highlightMatValue10017 then
				local var_200_8 = 1

				var_200_0.transform:SetSiblingIndex(1)

				local var_200_9 = arg_197_1.var_.highlightMatValue10017
				local var_200_10 = var_200_9.color

				var_200_10.r = var_200_8
				var_200_10.g = var_200_8
				var_200_10.b = var_200_8
				var_200_9.color = var_200_10
			end

			local var_200_11 = 0
			local var_200_12 = 0.975

			if var_200_11 < arg_197_1.time_ and arg_197_1.time_ <= var_200_11 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_13 = arg_197_1:FormatText(StoryNameCfg[255].name)

				arg_197_1.leftNameTxt_.text = var_200_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_14 = arg_197_1:GetWordFromCfg(114282049)
				local var_200_15 = arg_197_1:FormatText(var_200_14.content)

				arg_197_1.text_.text = var_200_15

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_16 = 39
				local var_200_17 = utf8.len(var_200_15)
				local var_200_18 = var_200_16 <= 0 and var_200_12 or var_200_12 * (var_200_17 / var_200_16)

				if var_200_18 > 0 and var_200_12 < var_200_18 then
					arg_197_1.talkMaxDuration = var_200_18

					if var_200_18 + var_200_11 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_18 + var_200_11
					end
				end

				arg_197_1.text_.text = var_200_15
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114282", "114282049", "story_v_out_114282.awb") ~= 0 then
					local var_200_19 = manager.audio:GetVoiceLength("story_v_out_114282", "114282049", "story_v_out_114282.awb") / 1000

					if var_200_19 + var_200_11 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_19 + var_200_11
					end

					if var_200_14.prefab_name ~= "" and arg_197_1.actors_[var_200_14.prefab_name] ~= nil then
						local var_200_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_14.prefab_name].transform, "story_v_out_114282", "114282049", "story_v_out_114282.awb")

						arg_197_1:RecordAudio("114282049", var_200_20)
						arg_197_1:RecordAudio("114282049", var_200_20)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_114282", "114282049", "story_v_out_114282.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_114282", "114282049", "story_v_out_114282.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_21 = math.max(var_200_12, arg_197_1.talkMaxDuration)

			if var_200_11 <= arg_197_1.time_ and arg_197_1.time_ < var_200_11 + var_200_21 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_11) / var_200_21

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_11 + var_200_21 and arg_197_1.time_ < var_200_11 + var_200_21 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play114282050 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 114282050
		arg_201_1.duration_ = 2.97

		local var_201_0 = {
			ja = 2.833,
			ko = 2.966,
			zh = 2,
			en = 2.533
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
			local var_204_0 = arg_201_1.actors_["10015"]
			local var_204_1 = 0

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.actorSpriteComps10015 == nil then
				arg_201_1.var_.actorSpriteComps10015 = var_204_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_204_2 = 0.034

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_2 and not isNil(var_204_0) then
				local var_204_3 = (arg_201_1.time_ - var_204_1) / var_204_2

				if arg_201_1.var_.actorSpriteComps10015 then
					for iter_204_0, iter_204_1 in pairs(arg_201_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_204_1 then
							if arg_201_1.isInRecall_ then
								local var_204_4 = Mathf.Lerp(iter_204_1.color.r, arg_201_1.hightColor1.r, var_204_3)
								local var_204_5 = Mathf.Lerp(iter_204_1.color.g, arg_201_1.hightColor1.g, var_204_3)
								local var_204_6 = Mathf.Lerp(iter_204_1.color.b, arg_201_1.hightColor1.b, var_204_3)

								iter_204_1.color = Color.New(var_204_4, var_204_5, var_204_6)
							else
								local var_204_7 = Mathf.Lerp(iter_204_1.color.r, 1, var_204_3)

								iter_204_1.color = Color.New(var_204_7, var_204_7, var_204_7)
							end
						end
					end
				end
			end

			if arg_201_1.time_ >= var_204_1 + var_204_2 and arg_201_1.time_ < var_204_1 + var_204_2 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.actorSpriteComps10015 then
				for iter_204_2, iter_204_3 in pairs(arg_201_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_204_3 then
						if arg_201_1.isInRecall_ then
							iter_204_3.color = arg_201_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_204_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_201_1.var_.actorSpriteComps10015 = nil
			end

			local var_204_8 = arg_201_1.actors_["10017"]
			local var_204_9 = 0

			if var_204_9 < arg_201_1.time_ and arg_201_1.time_ <= var_204_9 + arg_204_0 and not isNil(var_204_8) then
				local var_204_10 = var_204_8:GetComponent("Image")

				if var_204_10 then
					arg_201_1.var_.highlightMatValue10017 = var_204_10
				end
			end

			local var_204_11 = 0.034

			if var_204_9 <= arg_201_1.time_ and arg_201_1.time_ < var_204_9 + var_204_11 and not isNil(var_204_8) then
				local var_204_12 = (arg_201_1.time_ - var_204_9) / var_204_11

				if arg_201_1.var_.highlightMatValue10017 then
					local var_204_13 = Mathf.Lerp(1, 0.5, var_204_12)
					local var_204_14 = arg_201_1.var_.highlightMatValue10017
					local var_204_15 = var_204_14.color

					var_204_15.r = var_204_13
					var_204_15.g = var_204_13
					var_204_15.b = var_204_13
					var_204_14.color = var_204_15
				end
			end

			if arg_201_1.time_ >= var_204_9 + var_204_11 and arg_201_1.time_ < var_204_9 + var_204_11 + arg_204_0 and not isNil(var_204_8) and arg_201_1.var_.highlightMatValue10017 then
				local var_204_16 = 0.5
				local var_204_17 = arg_201_1.var_.highlightMatValue10017
				local var_204_18 = var_204_17.color

				var_204_18.r = var_204_16
				var_204_18.g = var_204_16
				var_204_18.b = var_204_16
				var_204_17.color = var_204_18
			end

			local var_204_19 = arg_201_1.actors_["10015"].transform
			local var_204_20 = 0

			if var_204_20 < arg_201_1.time_ and arg_201_1.time_ <= var_204_20 + arg_204_0 then
				arg_201_1.var_.moveOldPos10015 = var_204_19.localPosition
				var_204_19.localScale = Vector3.New(1, 1, 1)

				arg_201_1:CheckSpriteTmpPos("10015", 4)

				local var_204_21 = var_204_19.childCount

				for iter_204_4 = 0, var_204_21 - 1 do
					local var_204_22 = var_204_19:GetChild(iter_204_4)

					if var_204_22.name == "split_5" or not string.find(var_204_22.name, "split") then
						var_204_22.gameObject:SetActive(true)
					else
						var_204_22.gameObject:SetActive(false)
					end
				end
			end

			local var_204_23 = 0.001

			if var_204_20 <= arg_201_1.time_ and arg_201_1.time_ < var_204_20 + var_204_23 then
				local var_204_24 = (arg_201_1.time_ - var_204_20) / var_204_23
				local var_204_25 = Vector3.New(390, -350, -180)

				var_204_19.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos10015, var_204_25, var_204_24)
			end

			if arg_201_1.time_ >= var_204_20 + var_204_23 and arg_201_1.time_ < var_204_20 + var_204_23 + arg_204_0 then
				var_204_19.localPosition = Vector3.New(390, -350, -180)
			end

			local var_204_26 = 0
			local var_204_27 = 0.15

			if var_204_26 < arg_201_1.time_ and arg_201_1.time_ <= var_204_26 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_28 = arg_201_1:FormatText(StoryNameCfg[208].name)

				arg_201_1.leftNameTxt_.text = var_204_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_29 = arg_201_1:GetWordFromCfg(114282050)
				local var_204_30 = arg_201_1:FormatText(var_204_29.content)

				arg_201_1.text_.text = var_204_30

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_31 = 6
				local var_204_32 = utf8.len(var_204_30)
				local var_204_33 = var_204_31 <= 0 and var_204_27 or var_204_27 * (var_204_32 / var_204_31)

				if var_204_33 > 0 and var_204_27 < var_204_33 then
					arg_201_1.talkMaxDuration = var_204_33

					if var_204_33 + var_204_26 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_33 + var_204_26
					end
				end

				arg_201_1.text_.text = var_204_30
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114282", "114282050", "story_v_out_114282.awb") ~= 0 then
					local var_204_34 = manager.audio:GetVoiceLength("story_v_out_114282", "114282050", "story_v_out_114282.awb") / 1000

					if var_204_34 + var_204_26 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_34 + var_204_26
					end

					if var_204_29.prefab_name ~= "" and arg_201_1.actors_[var_204_29.prefab_name] ~= nil then
						local var_204_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_29.prefab_name].transform, "story_v_out_114282", "114282050", "story_v_out_114282.awb")

						arg_201_1:RecordAudio("114282050", var_204_35)
						arg_201_1:RecordAudio("114282050", var_204_35)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_114282", "114282050", "story_v_out_114282.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_114282", "114282050", "story_v_out_114282.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_36 = math.max(var_204_27, arg_201_1.talkMaxDuration)

			if var_204_26 <= arg_201_1.time_ and arg_201_1.time_ < var_204_26 + var_204_36 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_26) / var_204_36

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_26 + var_204_36 and arg_201_1.time_ < var_204_26 + var_204_36 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
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

		arg_201_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/F04"
	},
	voices = {
		"story_v_out_114282.awb"
	}
}
