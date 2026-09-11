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
			if 0.5 < arg_1_1.time_ and arg_1_1.time_ <= 0.5 + arg_4_0 then
				arg_1_1.fswbg_:SetActive(true)
				arg_1_1.dialog_:SetActive(false)

				arg_1_1.fswtw_.percent = 0
				arg_1_1.fswt_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(114282001).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.fswt_)

				arg_1_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_1_1.fswtw_:SetDirty()

				arg_1_1.typewritterCharCountI18N = 0

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_0 = 0.516666666666667

			if 0.516666666666667 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				arg_1_1.var_.oldValueTypewriter = arg_1_1.fswtw_.percent

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_1 = 24
			local var_4_2 = 1.6
			local var_4_3, var_4_4 = arg_1_1:GetPercentByPara(arg_1_1:FormatText(arg_1_1:GetWordFromCfg(114282001).content), 1)

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				local var_4_5 = var_4_1 <= 0 and var_4_2 or var_4_2 * ((var_4_4 - arg_1_1.typewritterCharCountI18N) / var_4_1)

				if (var_4_1 <= 0 and var_4_2 or var_4_2 * ((var_4_4 - arg_1_1.typewritterCharCountI18N) / var_4_1)) > 0 and var_4_2 < var_4_5 then
					arg_1_1.talkMaxDuration = var_4_5

					if var_4_5 + var_4_0 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_5 + var_4_0
					end
				end
			end

			local var_4_6 = math.max(1.6, arg_1_1.talkMaxDuration)

			if var_4_0 <= arg_1_1.time_ and arg_1_1.time_ < var_4_0 + var_4_6 then
				arg_1_1.fswtw_.percent = Mathf.Lerp(arg_1_1.var_.oldValueTypewriter, var_4_3, (arg_1_1.time_ - var_4_0) / var_4_6)
				arg_1_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_1_1.fswtw_:SetDirty()
			end

			if arg_1_1.time_ >= var_4_0 + var_4_6 and arg_1_1.time_ < var_4_0 + var_4_6 + arg_4_0 then
				arg_1_1.fswtw_.percent = var_4_3

				arg_1_1.fswtw_:SetDirty()
				arg_1_1:ShowNextGo(true)

				arg_1_1.typewritterCharCountI18N = var_4_4
			end

			local var_4_7 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_7 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_8 = 2

			if var_4_7 <= arg_1_1.time_ and arg_1_1.time_ < var_4_7 + var_4_8 then
				local var_4_9 = Color.New(0, 0, 0)

				var_4_9.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_7) / var_4_8)
				arg_1_1.mask_.color = var_4_9
			end

			if arg_1_1.time_ >= var_4_7 + var_4_8 and arg_1_1.time_ < var_4_7 + var_4_8 + arg_4_0 then
				local var_4_10 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_10.a = 0
				arg_1_1.mask_.color = var_4_10
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_13 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_13 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_13

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_13
						arg_1_1.bgmTxt2_.text = var_4_13
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

			local var_4_14 = 0.5
			local var_4_15 = manager.audio:GetVoiceLength("story_v_out_114282", "114282001", "story_v_out_114282.awb") / 1000

			if var_4_15 > 0 and 5.237 < var_4_15 and var_4_15 + var_4_14 > arg_1_1.duration_ then
				arg_1_1.duration_ = var_4_15 + var_4_14
			end

			if var_4_14 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1:AudioAction("play", "voice", "story_v_out_114282", "114282001", "story_v_out_114282.awb")
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
			if 0 < arg_6_1.time_ and arg_6_1.time_ <= 0 + arg_9_0 then
				arg_6_1.var_.oldValueTypewriter = arg_6_1.fswtw_.percent

				SetActive(arg_6_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_6_1:ShowNextGo(false)
			end

			local var_9_0 = 18
			local var_9_1 = 1.2
			local var_9_2, var_9_3 = arg_6_1:GetPercentByPara(arg_6_1:FormatText(arg_6_1:GetWordFromCfg(114282001).content), 2)

			if 0 < arg_6_1.time_ and arg_6_1.time_ <= 0 + arg_9_0 then
				arg_6_1.talkMaxDuration = 0

				local var_9_4 = var_9_0 <= 0 and var_9_1 or var_9_1 * ((var_9_3 - arg_6_1.typewritterCharCountI18N) / var_9_0)

				if (var_9_0 <= 0 and var_9_1 or var_9_1 * ((var_9_3 - arg_6_1.typewritterCharCountI18N) / var_9_0)) > 0 and var_9_1 < var_9_4 then
					arg_6_1.talkMaxDuration = var_9_4

					if var_9_4 + 0 > arg_6_1.duration_ then
						arg_6_1.duration_ = var_9_4 + 0
					end
				end
			end

			local var_9_5 = math.max(1.2, arg_6_1.talkMaxDuration)

			if 0 <= arg_6_1.time_ and arg_6_1.time_ < 0 + var_9_5 then
				arg_6_1.fswtw_.percent = Mathf.Lerp(arg_6_1.var_.oldValueTypewriter, var_9_2, (arg_6_1.time_ - 0) / var_9_5)
				arg_6_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_6_1.fswtw_:SetDirty()
			end

			if arg_6_1.time_ >= 0 + var_9_5 and arg_6_1.time_ < 0 + var_9_5 + arg_9_0 then
				arg_6_1.fswtw_.percent = var_9_2

				arg_6_1.fswtw_:SetDirty()
				arg_6_1:ShowNextGo(true)

				arg_6_1.typewritterCharCountI18N = var_9_3
			end

			local var_9_6 = 0
			local var_9_7 = manager.audio:GetVoiceLength("story_v_out_114282", "114282002", "story_v_out_114282.awb") / 1000

			if var_9_7 > 0 and 3.782 < var_9_7 and var_9_7 + var_9_6 > arg_6_1.duration_ then
				arg_6_1.duration_ = var_9_7 + var_9_6
			end

			if var_9_6 < arg_6_1.time_ and arg_6_1.time_ <= var_9_6 + arg_9_0 then
				arg_6_1:AudioAction("play", "voice", "story_v_out_114282", "114282002", "story_v_out_114282.awb")
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
			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 then
				arg_10_1.var_.oldValueTypewriter = arg_10_1.fswtw_.percent

				SetActive(arg_10_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_10_1:ShowNextGo(false)
			end

			local var_13_0 = 10
			local var_13_1 = 0.666666666666667
			local var_13_2, var_13_3 = arg_10_1:GetPercentByPara(arg_10_1:FormatText(arg_10_1:GetWordFromCfg(114282001).content), 3)

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0

				local var_13_4 = var_13_0 <= 0 and var_13_1 or var_13_1 * ((var_13_3 - arg_10_1.typewritterCharCountI18N) / var_13_0)

				if (var_13_0 <= 0 and var_13_1 or var_13_1 * ((var_13_3 - arg_10_1.typewritterCharCountI18N) / var_13_0)) > 0 and var_13_1 < var_13_4 then
					arg_10_1.talkMaxDuration = var_13_4

					if var_13_4 + 0 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_4 + 0
					end
				end
			end

			local var_13_5 = math.max(0.666666666666667, arg_10_1.talkMaxDuration)

			if 0 <= arg_10_1.time_ and arg_10_1.time_ < 0 + var_13_5 then
				arg_10_1.fswtw_.percent = Mathf.Lerp(arg_10_1.var_.oldValueTypewriter, var_13_2, (arg_10_1.time_ - 0) / var_13_5)
				arg_10_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_10_1.fswtw_:SetDirty()
			end

			if arg_10_1.time_ >= 0 + var_13_5 and arg_10_1.time_ < 0 + var_13_5 + arg_13_0 then
				arg_10_1.fswtw_.percent = var_13_2

				arg_10_1.fswtw_:SetDirty()
				arg_10_1:ShowNextGo(true)

				arg_10_1.typewritterCharCountI18N = var_13_3
			end

			local var_13_6 = 0
			local var_13_7 = manager.audio:GetVoiceLength("story_v_out_114282", "114282003", "story_v_out_114282.awb") / 1000

			if var_13_7 > 0 and 0.803 < var_13_7 and var_13_7 + var_13_6 > arg_10_1.duration_ then
				arg_10_1.duration_ = var_13_7 + var_13_6
			end

			if var_13_6 < arg_10_1.time_ and arg_10_1.time_ <= var_13_6 + arg_13_0 then
				arg_10_1:AudioAction("play", "voice", "story_v_out_114282", "114282003", "story_v_out_114282.awb")
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
			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 then
				arg_14_1.var_.oldValueTypewriter = arg_14_1.fswtw_.percent

				SetActive(arg_14_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_14_1:ShowNextGo(false)
			end

			local var_17_0 = 13
			local var_17_1 = 0.866666666666667
			local var_17_2, var_17_3 = arg_14_1:GetPercentByPara(arg_14_1:FormatText(arg_14_1:GetWordFromCfg(114282001).content), 4)

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0

				local var_17_4 = var_17_0 <= 0 and var_17_1 or var_17_1 * ((var_17_3 - arg_14_1.typewritterCharCountI18N) / var_17_0)

				if (var_17_0 <= 0 and var_17_1 or var_17_1 * ((var_17_3 - arg_14_1.typewritterCharCountI18N) / var_17_0)) > 0 and var_17_1 < var_17_4 then
					arg_14_1.talkMaxDuration = var_17_4

					if var_17_4 + 0 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_4 + 0
					end
				end
			end

			local var_17_5 = math.max(0.866666666666667, arg_14_1.talkMaxDuration)

			if 0 <= arg_14_1.time_ and arg_14_1.time_ < 0 + var_17_5 then
				arg_14_1.fswtw_.percent = Mathf.Lerp(arg_14_1.var_.oldValueTypewriter, var_17_2, (arg_14_1.time_ - 0) / var_17_5)
				arg_14_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_14_1.fswtw_:SetDirty()
			end

			if arg_14_1.time_ >= 0 + var_17_5 and arg_14_1.time_ < 0 + var_17_5 + arg_17_0 then
				arg_14_1.fswtw_.percent = var_17_2

				arg_14_1.fswtw_:SetDirty()
				arg_14_1:ShowNextGo(true)

				arg_14_1.typewritterCharCountI18N = var_17_3
			end

			local var_17_6 = 0
			local var_17_7 = manager.audio:GetVoiceLength("story_v_out_114282", "114282004", "story_v_out_114282.awb") / 1000

			if var_17_7 > 0 and 1.648 < var_17_7 and var_17_7 + var_17_6 > arg_14_1.duration_ then
				arg_14_1.duration_ = var_17_7 + var_17_6
			end

			if var_17_6 < arg_14_1.time_ and arg_14_1.time_ <= var_17_6 + arg_17_0 then
				arg_14_1:AudioAction("play", "voice", "story_v_out_114282", "114282004", "story_v_out_114282.awb")
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
			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1.var_.oldValueTypewriter = arg_18_1.fswtw_.percent

				SetActive(arg_18_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_18_1:ShowNextGo(false)
			end

			local var_21_0 = 48
			local var_21_1 = 3.2
			local var_21_2, var_21_3 = arg_18_1:GetPercentByPara(arg_18_1:FormatText(arg_18_1:GetWordFromCfg(114282001).content), 5)

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0

				local var_21_4 = var_21_0 <= 0 and var_21_1 or var_21_1 * ((var_21_3 - arg_18_1.typewritterCharCountI18N) / var_21_0)

				if (var_21_0 <= 0 and var_21_1 or var_21_1 * ((var_21_3 - arg_18_1.typewritterCharCountI18N) / var_21_0)) > 0 and var_21_1 < var_21_4 then
					arg_18_1.talkMaxDuration = var_21_4

					if var_21_4 + 0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_4 + 0
					end
				end
			end

			local var_21_5 = math.max(3.2, arg_18_1.talkMaxDuration)

			if 0 <= arg_18_1.time_ and arg_18_1.time_ < 0 + var_21_5 then
				arg_18_1.fswtw_.percent = Mathf.Lerp(arg_18_1.var_.oldValueTypewriter, var_21_2, (arg_18_1.time_ - 0) / var_21_5)
				arg_18_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_18_1.fswtw_:SetDirty()
			end

			if arg_18_1.time_ >= 0 + var_21_5 and arg_18_1.time_ < 0 + var_21_5 + arg_21_0 then
				arg_18_1.fswtw_.percent = var_21_2

				arg_18_1.fswtw_:SetDirty()
				arg_18_1:ShowNextGo(true)

				arg_18_1.typewritterCharCountI18N = var_21_3
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
			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 then
				arg_22_1.var_.oldValueTypewriter = arg_22_1.fswtw_.percent

				SetActive(arg_22_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_22_1:ShowNextGo(false)
			end

			local var_25_0 = 30
			local var_25_1 = 2
			local var_25_2, var_25_3 = arg_22_1:GetPercentByPara(arg_22_1:FormatText(arg_22_1:GetWordFromCfg(114282001).content), 6)

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0

				local var_25_4 = var_25_0 <= 0 and var_25_1 or var_25_1 * ((var_25_3 - arg_22_1.typewritterCharCountI18N) / var_25_0)

				if (var_25_0 <= 0 and var_25_1 or var_25_1 * ((var_25_3 - arg_22_1.typewritterCharCountI18N) / var_25_0)) > 0 and var_25_1 < var_25_4 then
					arg_22_1.talkMaxDuration = var_25_4

					if var_25_4 + 0 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_4 + 0
					end
				end
			end

			local var_25_5 = math.max(2, arg_22_1.talkMaxDuration)

			if 0 <= arg_22_1.time_ and arg_22_1.time_ < 0 + var_25_5 then
				arg_22_1.fswtw_.percent = Mathf.Lerp(arg_22_1.var_.oldValueTypewriter, var_25_2, (arg_22_1.time_ - 0) / var_25_5)
				arg_22_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_22_1.fswtw_:SetDirty()
			end

			if arg_22_1.time_ >= 0 + var_25_5 and arg_22_1.time_ < 0 + var_25_5 + arg_25_0 then
				arg_22_1.fswtw_.percent = var_25_2

				arg_22_1.fswtw_:SetDirty()
				arg_22_1:ShowNextGo(true)

				arg_22_1.typewritterCharCountI18N = var_25_3
			end

			local var_25_6 = 0
			local var_25_7 = manager.audio:GetVoiceLength("story_v_out_114282", "114282006", "story_v_out_114282.awb") / 1000

			if var_25_7 > 0 and 8.487 < var_25_7 and var_25_7 + var_25_6 > arg_22_1.duration_ then
				arg_22_1.duration_ = var_25_7 + var_25_6
			end

			if var_25_6 < arg_22_1.time_ and arg_22_1.time_ <= var_25_6 + arg_25_0 then
				arg_22_1:AudioAction("play", "voice", "story_v_out_114282", "114282006", "story_v_out_114282.awb")
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
			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				arg_26_1.var_.oldValueTypewriter = arg_26_1.fswtw_.percent

				SetActive(arg_26_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_26_1:ShowNextGo(false)
			end

			local var_29_0 = 11
			local var_29_1 = 0.733333333333333
			local var_29_2, var_29_3 = arg_26_1:GetPercentByPara(arg_26_1:FormatText(arg_26_1:GetWordFromCfg(114282001).content), 7)

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0

				local var_29_4 = var_29_0 <= 0 and var_29_1 or var_29_1 * ((var_29_3 - arg_26_1.typewritterCharCountI18N) / var_29_0)

				if (var_29_0 <= 0 and var_29_1 or var_29_1 * ((var_29_3 - arg_26_1.typewritterCharCountI18N) / var_29_0)) > 0 and var_29_1 < var_29_4 then
					arg_26_1.talkMaxDuration = var_29_4

					if var_29_4 + 0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_4 + 0
					end
				end
			end

			local var_29_5 = math.max(0.733333333333333, arg_26_1.talkMaxDuration)

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_5 then
				arg_26_1.fswtw_.percent = Mathf.Lerp(arg_26_1.var_.oldValueTypewriter, var_29_2, (arg_26_1.time_ - 0) / var_29_5)
				arg_26_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_26_1.fswtw_:SetDirty()
			end

			if arg_26_1.time_ >= 0 + var_29_5 and arg_26_1.time_ < 0 + var_29_5 + arg_29_0 then
				arg_26_1.fswtw_.percent = var_29_2

				arg_26_1.fswtw_:SetDirty()
				arg_26_1:ShowNextGo(true)

				arg_26_1.typewritterCharCountI18N = var_29_3
			end

			local var_29_6 = 0
			local var_29_7 = manager.audio:GetVoiceLength("story_v_out_114282", "114282007", "story_v_out_114282.awb") / 1000

			if var_29_7 > 0 and 0.767 < var_29_7 and var_29_7 + var_29_6 > arg_26_1.duration_ then
				arg_26_1.duration_ = var_29_7 + var_29_6
			end

			if var_29_6 < arg_26_1.time_ and arg_26_1.time_ <= var_29_6 + arg_29_0 then
				arg_26_1:AudioAction("play", "voice", "story_v_out_114282", "114282007", "story_v_out_114282.awb")
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
			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				arg_30_1.var_.oldValueTypewriter = arg_30_1.fswtw_.percent

				SetActive(arg_30_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_30_1:ShowNextGo(false)
			end

			local var_33_0 = 0
			local var_33_1 = 0
			local var_33_2, var_33_3 = arg_30_1:GetPercentByPara(arg_30_1:FormatText(arg_30_1:GetWordFromCfg(114282001).content), 7)

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0

				local var_33_4 = var_33_0 <= 0 and var_33_1 or var_33_1 * ((var_33_3 - arg_30_1.typewritterCharCountI18N) / var_33_0)

				if (var_33_0 <= 0 and var_33_1 or var_33_1 * ((var_33_3 - arg_30_1.typewritterCharCountI18N) / var_33_0)) > 0 and var_33_1 < var_33_4 then
					arg_30_1.talkMaxDuration = var_33_4

					if var_33_4 + 0 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_4 + 0
					end
				end
			end

			local var_33_5 = math.max(0, arg_30_1.talkMaxDuration)

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_5 then
				arg_30_1.fswtw_.percent = Mathf.Lerp(arg_30_1.var_.oldValueTypewriter, var_33_2, (arg_30_1.time_ - 0) / var_33_5)
				arg_30_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_30_1.fswtw_:SetDirty()
			end

			if arg_30_1.time_ >= 0 + var_33_5 and arg_30_1.time_ < 0 + var_33_5 + arg_33_0 then
				arg_30_1.fswtw_.percent = var_33_2

				arg_30_1.fswtw_:SetDirty()
				arg_30_1:ShowNextGo(true)

				arg_30_1.typewritterCharCountI18N = var_33_3
			end

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				arg_30_1.fswbg_:SetActive(true)
				arg_30_1.dialog_:SetActive(false)

				arg_30_1.fswtw_.percent = 0
				arg_30_1.fswt_.text = arg_30_1:FormatText(arg_30_1:GetWordFromCfg(114282008).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.fswt_)

				arg_30_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_30_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_30_1.fswtw_:SetDirty()

				arg_30_1.typewritterCharCountI18N = 0

				SetActive(arg_30_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_30_1:ShowNextGo(false)
			end

			local var_33_6 = 0.0166666666666667

			if 0.0166666666666667 < arg_30_1.time_ and arg_30_1.time_ <= var_33_6 + arg_33_0 then
				arg_30_1.var_.oldValueTypewriter = arg_30_1.fswtw_.percent

				SetActive(arg_30_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_30_1:ShowNextGo(false)
			end

			local var_33_7 = 16
			local var_33_8 = 1.06666666666667
			local var_33_9, var_33_10 = arg_30_1:GetPercentByPara(arg_30_1:FormatText(arg_30_1:GetWordFromCfg(114282008).content), 1)

			if var_33_6 < arg_30_1.time_ and arg_30_1.time_ <= var_33_6 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0

				local var_33_11 = var_33_7 <= 0 and var_33_8 or var_33_8 * ((var_33_10 - arg_30_1.typewritterCharCountI18N) / var_33_7)

				if (var_33_7 <= 0 and var_33_8 or var_33_8 * ((var_33_10 - arg_30_1.typewritterCharCountI18N) / var_33_7)) > 0 and var_33_8 < var_33_11 then
					arg_30_1.talkMaxDuration = var_33_11

					if var_33_11 + var_33_6 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_11 + var_33_6
					end
				end
			end

			local var_33_12 = math.max(1.06666666666667, arg_30_1.talkMaxDuration)

			if var_33_6 <= arg_30_1.time_ and arg_30_1.time_ < var_33_6 + var_33_12 then
				arg_30_1.fswtw_.percent = Mathf.Lerp(arg_30_1.var_.oldValueTypewriter, var_33_9, (arg_30_1.time_ - var_33_6) / var_33_12)
				arg_30_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_30_1.fswtw_:SetDirty()
			end

			if arg_30_1.time_ >= var_33_6 + var_33_12 and arg_30_1.time_ < var_33_6 + var_33_12 + arg_33_0 then
				arg_30_1.fswtw_.percent = var_33_9

				arg_30_1.fswtw_:SetDirty()
				arg_30_1:ShowNextGo(true)

				arg_30_1.typewritterCharCountI18N = var_33_10
			end

			local var_33_13 = 0
			local var_33_14 = manager.audio:GetVoiceLength("story_v_out_114282", "114282008", "story_v_out_114282.awb") / 1000

			if var_33_14 > 0 and 2.395 < var_33_14 and var_33_14 + var_33_13 > arg_30_1.duration_ then
				arg_30_1.duration_ = var_33_14 + var_33_13
			end

			if var_33_13 < arg_30_1.time_ and arg_30_1.time_ <= var_33_13 + arg_33_0 then
				arg_30_1:AudioAction("play", "voice", "story_v_out_114282", "114282008", "story_v_out_114282.awb")
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
			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1.var_.oldValueTypewriter = arg_34_1.fswtw_.percent

				SetActive(arg_34_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_34_1:ShowNextGo(false)
			end

			local var_37_0 = 29
			local var_37_1 = 1.93333333333333
			local var_37_2, var_37_3 = arg_34_1:GetPercentByPara(arg_34_1:FormatText(arg_34_1:GetWordFromCfg(114282008).content), 2)

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0

				local var_37_4 = var_37_0 <= 0 and var_37_1 or var_37_1 * ((var_37_3 - arg_34_1.typewritterCharCountI18N) / var_37_0)

				if (var_37_0 <= 0 and var_37_1 or var_37_1 * ((var_37_3 - arg_34_1.typewritterCharCountI18N) / var_37_0)) > 0 and var_37_1 < var_37_4 then
					arg_34_1.talkMaxDuration = var_37_4

					if var_37_4 + 0 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_4 + 0
					end
				end
			end

			local var_37_5 = math.max(1.93333333333333, arg_34_1.talkMaxDuration)

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_5 then
				arg_34_1.fswtw_.percent = Mathf.Lerp(arg_34_1.var_.oldValueTypewriter, var_37_2, (arg_34_1.time_ - 0) / var_37_5)
				arg_34_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_34_1.fswtw_:SetDirty()
			end

			if arg_34_1.time_ >= 0 + var_37_5 and arg_34_1.time_ < 0 + var_37_5 + arg_37_0 then
				arg_34_1.fswtw_.percent = var_37_2

				arg_34_1.fswtw_:SetDirty()
				arg_34_1:ShowNextGo(true)

				arg_34_1.typewritterCharCountI18N = var_37_3
			end

			local var_37_6 = 0
			local var_37_7 = manager.audio:GetVoiceLength("story_v_out_114282", "114282009", "story_v_out_114282.awb") / 1000

			if var_37_7 > 0 and 4.927 < var_37_7 and var_37_7 + var_37_6 > arg_34_1.duration_ then
				arg_34_1.duration_ = var_37_7 + var_37_6
			end

			if var_37_6 < arg_34_1.time_ and arg_34_1.time_ <= var_37_6 + arg_37_0 then
				arg_34_1:AudioAction("play", "voice", "story_v_out_114282", "114282009", "story_v_out_114282.awb")
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
			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1.var_.oldValueTypewriter = arg_38_1.fswtw_.percent

				SetActive(arg_38_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_38_1:ShowNextGo(false)
			end

			local var_41_0 = 59
			local var_41_1 = 3.93333333333333
			local var_41_2, var_41_3 = arg_38_1:GetPercentByPara(arg_38_1:FormatText(arg_38_1:GetWordFromCfg(114282008).content), 3)

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0

				local var_41_4 = var_41_0 <= 0 and var_41_1 or var_41_1 * ((var_41_3 - arg_38_1.typewritterCharCountI18N) / var_41_0)

				if (var_41_0 <= 0 and var_41_1 or var_41_1 * ((var_41_3 - arg_38_1.typewritterCharCountI18N) / var_41_0)) > 0 and var_41_1 < var_41_4 then
					arg_38_1.talkMaxDuration = var_41_4

					if var_41_4 + 0 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_4 + 0
					end
				end
			end

			local var_41_5 = math.max(3.93333333333333, arg_38_1.talkMaxDuration)

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_5 then
				arg_38_1.fswtw_.percent = Mathf.Lerp(arg_38_1.var_.oldValueTypewriter, var_41_2, (arg_38_1.time_ - 0) / var_41_5)
				arg_38_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_38_1.fswtw_:SetDirty()
			end

			if arg_38_1.time_ >= 0 + var_41_5 and arg_38_1.time_ < 0 + var_41_5 + arg_41_0 then
				arg_38_1.fswtw_.percent = var_41_2

				arg_38_1.fswtw_:SetDirty()
				arg_38_1:ShowNextGo(true)

				arg_38_1.typewritterCharCountI18N = var_41_3
			end

			local var_41_6 = 0
			local var_41_7 = manager.audio:GetVoiceLength("story_v_out_114282", "114282010", "story_v_out_114282.awb") / 1000

			if var_41_7 > 0 and 13.004 < var_41_7 and var_41_7 + var_41_6 > arg_38_1.duration_ then
				arg_38_1.duration_ = var_41_7 + var_41_6
			end

			if var_41_6 < arg_38_1.time_ and arg_38_1.time_ <= var_41_6 + arg_41_0 then
				arg_38_1:AudioAction("play", "voice", "story_v_out_114282", "114282010", "story_v_out_114282.awb")
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
			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1.var_.oldValueTypewriter = arg_42_1.fswtw_.percent

				SetActive(arg_42_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_42_1:ShowNextGo(false)
			end

			local var_45_0 = 18
			local var_45_1 = 1.2
			local var_45_2, var_45_3 = arg_42_1:GetPercentByPara(arg_42_1:FormatText(arg_42_1:GetWordFromCfg(114282008).content), 4)

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0

				local var_45_4 = var_45_0 <= 0 and var_45_1 or var_45_1 * ((var_45_3 - arg_42_1.typewritterCharCountI18N) / var_45_0)

				if (var_45_0 <= 0 and var_45_1 or var_45_1 * ((var_45_3 - arg_42_1.typewritterCharCountI18N) / var_45_0)) > 0 and var_45_1 < var_45_4 then
					arg_42_1.talkMaxDuration = var_45_4

					if var_45_4 + 0 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_4 + 0
					end
				end
			end

			local var_45_5 = math.max(1.2, arg_42_1.talkMaxDuration)

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_5 then
				arg_42_1.fswtw_.percent = Mathf.Lerp(arg_42_1.var_.oldValueTypewriter, var_45_2, (arg_42_1.time_ - 0) / var_45_5)
				arg_42_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_42_1.fswtw_:SetDirty()
			end

			if arg_42_1.time_ >= 0 + var_45_5 and arg_42_1.time_ < 0 + var_45_5 + arg_45_0 then
				arg_42_1.fswtw_.percent = var_45_2

				arg_42_1.fswtw_:SetDirty()
				arg_42_1:ShowNextGo(true)

				arg_42_1.typewritterCharCountI18N = var_45_3
			end

			local var_45_6 = 0
			local var_45_7 = manager.audio:GetVoiceLength("story_v_out_114282", "114282011", "story_v_out_114282.awb") / 1000

			if var_45_7 > 0 and 2.21 < var_45_7 and var_45_7 + var_45_6 > arg_42_1.duration_ then
				arg_42_1.duration_ = var_45_7 + var_45_6
			end

			if var_45_6 < arg_42_1.time_ and arg_42_1.time_ <= var_45_6 + arg_45_0 then
				arg_42_1:AudioAction("play", "voice", "story_v_out_114282", "114282011", "story_v_out_114282.awb")
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
			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1.var_.oldValueTypewriter = arg_46_1.fswtw_.percent

				SetActive(arg_46_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_46_1:ShowNextGo(false)
			end

			local var_49_0 = 67
			local var_49_1 = 4.4
			local var_49_2, var_49_3 = arg_46_1:GetPercentByPara(arg_46_1:FormatText(arg_46_1:GetWordFromCfg(114282008).content), 5)

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0

				local var_49_4 = var_49_0 <= 0 and var_49_1 or var_49_1 * ((var_49_3 - arg_46_1.typewritterCharCountI18N) / var_49_0)

				if (var_49_0 <= 0 and var_49_1 or var_49_1 * ((var_49_3 - arg_46_1.typewritterCharCountI18N) / var_49_0)) > 0 and var_49_1 < var_49_4 then
					arg_46_1.talkMaxDuration = var_49_4

					if var_49_4 + 0 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_4 + 0
					end
				end
			end

			local var_49_5 = math.max(4.4, arg_46_1.talkMaxDuration)

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_5 then
				arg_46_1.fswtw_.percent = Mathf.Lerp(arg_46_1.var_.oldValueTypewriter, var_49_2, (arg_46_1.time_ - 0) / var_49_5)
				arg_46_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_46_1.fswtw_:SetDirty()
			end

			if arg_46_1.time_ >= 0 + var_49_5 and arg_46_1.time_ < 0 + var_49_5 + arg_49_0 then
				arg_46_1.fswtw_.percent = var_49_2

				arg_46_1.fswtw_:SetDirty()
				arg_46_1:ShowNextGo(true)

				arg_46_1.typewritterCharCountI18N = var_49_3
			end

			local var_49_6 = 0
			local var_49_7 = manager.audio:GetVoiceLength("story_v_out_114282", "114282012", "story_v_out_114282.awb") / 1000

			if var_49_7 > 0 and 15.627 < var_49_7 and var_49_7 + var_49_6 > arg_46_1.duration_ then
				arg_46_1.duration_ = var_49_7 + var_49_6
			end

			if var_49_6 < arg_46_1.time_ and arg_46_1.time_ <= var_49_6 + arg_49_0 then
				arg_46_1:AudioAction("play", "voice", "story_v_out_114282", "114282012", "story_v_out_114282.awb")
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
			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.fswbg_:SetActive(true)
				arg_50_1.dialog_:SetActive(false)

				arg_50_1.fswtw_.percent = 0
				arg_50_1.fswt_.text = arg_50_1:FormatText(arg_50_1:GetWordFromCfg(114282013).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.fswt_)

				arg_50_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_50_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_50_1.fswtw_:SetDirty()

				arg_50_1.typewritterCharCountI18N = 0

				SetActive(arg_50_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_50_1:ShowNextGo(false)
			end

			local var_53_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_50_1.time_ and arg_50_1.time_ <= var_53_0 + arg_53_0 then
				arg_50_1.var_.oldValueTypewriter = arg_50_1.fswtw_.percent

				SetActive(arg_50_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_50_1:ShowNextGo(false)
			end

			local var_53_1 = 32
			local var_53_2 = 2.13333333333333
			local var_53_3, var_53_4 = arg_50_1:GetPercentByPara(arg_50_1:FormatText(arg_50_1:GetWordFromCfg(114282013).content), 1)

			if var_53_0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_0 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0

				local var_53_5 = var_53_1 <= 0 and var_53_2 or var_53_2 * ((var_53_4 - arg_50_1.typewritterCharCountI18N) / var_53_1)

				if (var_53_1 <= 0 and var_53_2 or var_53_2 * ((var_53_4 - arg_50_1.typewritterCharCountI18N) / var_53_1)) > 0 and var_53_2 < var_53_5 then
					arg_50_1.talkMaxDuration = var_53_5

					if var_53_5 + var_53_0 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_5 + var_53_0
					end
				end
			end

			local var_53_6 = math.max(2.13333333333333, arg_50_1.talkMaxDuration)

			if var_53_0 <= arg_50_1.time_ and arg_50_1.time_ < var_53_0 + var_53_6 then
				arg_50_1.fswtw_.percent = Mathf.Lerp(arg_50_1.var_.oldValueTypewriter, var_53_3, (arg_50_1.time_ - var_53_0) / var_53_6)
				arg_50_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_50_1.fswtw_:SetDirty()
			end

			if arg_50_1.time_ >= var_53_0 + var_53_6 and arg_50_1.time_ < var_53_0 + var_53_6 + arg_53_0 then
				arg_50_1.fswtw_.percent = var_53_3

				arg_50_1.fswtw_:SetDirty()
				arg_50_1:ShowNextGo(true)

				arg_50_1.typewritterCharCountI18N = var_53_4
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
			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1.var_.oldValueTypewriter = arg_54_1.fswtw_.percent

				SetActive(arg_54_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_54_1:ShowNextGo(false)
			end

			local var_57_0 = 11
			local var_57_1 = 0.733333333333333
			local var_57_2, var_57_3 = arg_54_1:GetPercentByPara(arg_54_1:FormatText(arg_54_1:GetWordFromCfg(114282013).content), 2)

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0

				local var_57_4 = var_57_0 <= 0 and var_57_1 or var_57_1 * ((var_57_3 - arg_54_1.typewritterCharCountI18N) / var_57_0)

				if (var_57_0 <= 0 and var_57_1 or var_57_1 * ((var_57_3 - arg_54_1.typewritterCharCountI18N) / var_57_0)) > 0 and var_57_1 < var_57_4 then
					arg_54_1.talkMaxDuration = var_57_4

					if var_57_4 + 0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_4 + 0
					end
				end
			end

			local var_57_5 = math.max(0.733333333333333, arg_54_1.talkMaxDuration)

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_5 then
				arg_54_1.fswtw_.percent = Mathf.Lerp(arg_54_1.var_.oldValueTypewriter, var_57_2, (arg_54_1.time_ - 0) / var_57_5)
				arg_54_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_54_1.fswtw_:SetDirty()
			end

			if arg_54_1.time_ >= 0 + var_57_5 and arg_54_1.time_ < 0 + var_57_5 + arg_57_0 then
				arg_54_1.fswtw_.percent = var_57_2

				arg_54_1.fswtw_:SetDirty()
				arg_54_1:ShowNextGo(true)

				arg_54_1.typewritterCharCountI18N = var_57_3
			end

			local var_57_6 = 0
			local var_57_7 = manager.audio:GetVoiceLength("story_v_out_114282", "114282014", "story_v_out_114282.awb") / 1000

			if var_57_7 > 0 and 4.927 < var_57_7 and var_57_7 + var_57_6 > arg_54_1.duration_ then
				arg_54_1.duration_ = var_57_7 + var_57_6
			end

			if var_57_6 < arg_54_1.time_ and arg_54_1.time_ <= var_57_6 + arg_57_0 then
				arg_54_1:AudioAction("play", "voice", "story_v_out_114282", "114282014", "story_v_out_114282.awb")
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
			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1.var_.oldValueTypewriter = arg_58_1.fswtw_.percent

				SetActive(arg_58_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_58_1:ShowNextGo(false)
			end

			local var_61_0 = 37
			local var_61_1 = 2.46666666666667
			local var_61_2, var_61_3 = arg_58_1:GetPercentByPara(arg_58_1:FormatText(arg_58_1:GetWordFromCfg(114282013).content), 3)

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0

				local var_61_4 = var_61_0 <= 0 and var_61_1 or var_61_1 * ((var_61_3 - arg_58_1.typewritterCharCountI18N) / var_61_0)

				if (var_61_0 <= 0 and var_61_1 or var_61_1 * ((var_61_3 - arg_58_1.typewritterCharCountI18N) / var_61_0)) > 0 and var_61_1 < var_61_4 then
					arg_58_1.talkMaxDuration = var_61_4

					if var_61_4 + 0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_4 + 0
					end
				end
			end

			local var_61_5 = math.max(2.46666666666667, arg_58_1.talkMaxDuration)

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_5 then
				arg_58_1.fswtw_.percent = Mathf.Lerp(arg_58_1.var_.oldValueTypewriter, var_61_2, (arg_58_1.time_ - 0) / var_61_5)
				arg_58_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_58_1.fswtw_:SetDirty()
			end

			if arg_58_1.time_ >= 0 + var_61_5 and arg_58_1.time_ < 0 + var_61_5 + arg_61_0 then
				arg_58_1.fswtw_.percent = var_61_2

				arg_58_1.fswtw_:SetDirty()
				arg_58_1:ShowNextGo(true)

				arg_58_1.typewritterCharCountI18N = var_61_3
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
			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.var_.oldValueTypewriter = arg_62_1.fswtw_.percent

				SetActive(arg_62_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_62_1:ShowNextGo(false)
			end

			local var_65_0 = 38
			local var_65_1 = 2.53333333333333
			local var_65_2, var_65_3 = arg_62_1:GetPercentByPara(arg_62_1:FormatText(arg_62_1:GetWordFromCfg(114282013).content), 4)

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0

				local var_65_4 = var_65_0 <= 0 and var_65_1 or var_65_1 * ((var_65_3 - arg_62_1.typewritterCharCountI18N) / var_65_0)

				if (var_65_0 <= 0 and var_65_1 or var_65_1 * ((var_65_3 - arg_62_1.typewritterCharCountI18N) / var_65_0)) > 0 and var_65_1 < var_65_4 then
					arg_62_1.talkMaxDuration = var_65_4

					if var_65_4 + 0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_4 + 0
					end
				end
			end

			local var_65_5 = math.max(2.53333333333333, arg_62_1.talkMaxDuration)

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_5 then
				arg_62_1.fswtw_.percent = Mathf.Lerp(arg_62_1.var_.oldValueTypewriter, var_65_2, (arg_62_1.time_ - 0) / var_65_5)
				arg_62_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_62_1.fswtw_:SetDirty()
			end

			if arg_62_1.time_ >= 0 + var_65_5 and arg_62_1.time_ < 0 + var_65_5 + arg_65_0 then
				arg_62_1.fswtw_.percent = var_65_2

				arg_62_1.fswtw_:SetDirty()
				arg_62_1:ShowNextGo(true)

				arg_62_1.typewritterCharCountI18N = var_65_3
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
			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.var_.oldValueTypewriter = arg_66_1.fswtw_.percent

				SetActive(arg_66_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_66_1:ShowNextGo(false)
			end

			local var_69_0 = 59
			local var_69_1 = 3.93333333333333
			local var_69_2, var_69_3 = arg_66_1:GetPercentByPara(arg_66_1:FormatText(arg_66_1:GetWordFromCfg(114282013).content), 5)

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0

				local var_69_4 = var_69_0 <= 0 and var_69_1 or var_69_1 * ((var_69_3 - arg_66_1.typewritterCharCountI18N) / var_69_0)

				if (var_69_0 <= 0 and var_69_1 or var_69_1 * ((var_69_3 - arg_66_1.typewritterCharCountI18N) / var_69_0)) > 0 and var_69_1 < var_69_4 then
					arg_66_1.talkMaxDuration = var_69_4

					if var_69_4 + 0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_4 + 0
					end
				end
			end

			local var_69_5 = math.max(3.93333333333333, arg_66_1.talkMaxDuration)

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_5 then
				arg_66_1.fswtw_.percent = Mathf.Lerp(arg_66_1.var_.oldValueTypewriter, var_69_2, (arg_66_1.time_ - 0) / var_69_5)
				arg_66_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_66_1.fswtw_:SetDirty()
			end

			if arg_66_1.time_ >= 0 + var_69_5 and arg_66_1.time_ < 0 + var_69_5 + arg_69_0 then
				arg_66_1.fswtw_.percent = var_69_2

				arg_66_1.fswtw_:SetDirty()
				arg_66_1:ShowNextGo(true)

				arg_66_1.typewritterCharCountI18N = var_69_3
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
			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.var_.oldValueTypewriter = arg_70_1.fswtw_.percent

				SetActive(arg_70_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_70_1:ShowNextGo(false)
			end

			local var_73_0 = 55
			local var_73_1 = 3.66666666666667
			local var_73_2, var_73_3 = arg_70_1:GetPercentByPara(arg_70_1:FormatText(arg_70_1:GetWordFromCfg(114282013).content), 6)

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0

				local var_73_4 = var_73_0 <= 0 and var_73_1 or var_73_1 * ((var_73_3 - arg_70_1.typewritterCharCountI18N) / var_73_0)

				if (var_73_0 <= 0 and var_73_1 or var_73_1 * ((var_73_3 - arg_70_1.typewritterCharCountI18N) / var_73_0)) > 0 and var_73_1 < var_73_4 then
					arg_70_1.talkMaxDuration = var_73_4

					if var_73_4 + 0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_4 + 0
					end
				end
			end

			local var_73_5 = math.max(3.66666666666667, arg_70_1.talkMaxDuration)

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_5 then
				arg_70_1.fswtw_.percent = Mathf.Lerp(arg_70_1.var_.oldValueTypewriter, var_73_2, (arg_70_1.time_ - 0) / var_73_5)
				arg_70_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_70_1.fswtw_:SetDirty()
			end

			if arg_70_1.time_ >= 0 + var_73_5 and arg_70_1.time_ < 0 + var_73_5 + arg_73_0 then
				arg_70_1.fswtw_.percent = var_73_2

				arg_70_1.fswtw_:SetDirty()
				arg_70_1:ShowNextGo(true)

				arg_70_1.typewritterCharCountI18N = var_73_3
			end

			local var_73_6 = 0
			local var_73_7 = manager.audio:GetVoiceLength("story_v_out_114282", "114282018", "story_v_out_114282.awb") / 1000

			if var_73_7 > 0 and 14.12 < var_73_7 and var_73_7 + var_73_6 > arg_70_1.duration_ then
				arg_70_1.duration_ = var_73_7 + var_73_6
			end

			if var_73_6 < arg_70_1.time_ and arg_70_1.time_ <= var_73_6 + arg_73_0 then
				arg_70_1:AudioAction("play", "voice", "story_v_out_114282", "114282018", "story_v_out_114282.awb")
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
			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1.var_.oldValueTypewriter = arg_74_1.fswtw_.percent

				SetActive(arg_74_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_74_1:ShowNextGo(false)
			end

			local var_77_0 = 26
			local var_77_1 = 1.73333333333333
			local var_77_2, var_77_3 = arg_74_1:GetPercentByPara(arg_74_1:FormatText(arg_74_1:GetWordFromCfg(114282013).content), 7)

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0

				local var_77_4 = var_77_0 <= 0 and var_77_1 or var_77_1 * ((var_77_3 - arg_74_1.typewritterCharCountI18N) / var_77_0)

				if (var_77_0 <= 0 and var_77_1 or var_77_1 * ((var_77_3 - arg_74_1.typewritterCharCountI18N) / var_77_0)) > 0 and var_77_1 < var_77_4 then
					arg_74_1.talkMaxDuration = var_77_4

					if var_77_4 + 0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_4 + 0
					end
				end
			end

			local var_77_5 = math.max(1.73333333333333, arg_74_1.talkMaxDuration)

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_5 then
				arg_74_1.fswtw_.percent = Mathf.Lerp(arg_74_1.var_.oldValueTypewriter, var_77_2, (arg_74_1.time_ - 0) / var_77_5)
				arg_74_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_74_1.fswtw_:SetDirty()
			end

			if arg_74_1.time_ >= 0 + var_77_5 and arg_74_1.time_ < 0 + var_77_5 + arg_77_0 then
				arg_74_1.fswtw_.percent = var_77_2

				arg_74_1.fswtw_:SetDirty()
				arg_74_1:ShowNextGo(true)

				arg_74_1.typewritterCharCountI18N = var_77_3
			end

			local var_77_6 = 0
			local var_77_7 = manager.audio:GetVoiceLength("story_v_out_114282", "114282019", "story_v_out_114282.awb") / 1000

			if var_77_7 > 0 and 5.026 < var_77_7 and var_77_7 + var_77_6 > arg_74_1.duration_ then
				arg_74_1.duration_ = var_77_7 + var_77_6
			end

			if var_77_6 < arg_74_1.time_ and arg_74_1.time_ <= var_77_6 + arg_77_0 then
				arg_74_1:AudioAction("play", "voice", "story_v_out_114282", "114282019", "story_v_out_114282.awb")
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
			if arg_78_1.actors_["10023"] == nil then
				local var_81_0 = Object.Instantiate(arg_78_1.imageGo_, arg_78_1.canvasGo_.transform)

				var_81_0.transform:SetSiblingIndex(1)

				var_81_0.name = "10023"

				local var_81_1 = var_81_0:GetComponent(typeof(Image))

				var_81_1.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "10023")

				var_81_1:SetNativeSize()

				var_81_0.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_78_1.actors_["10023"] = var_81_0
			end

			local var_81_2 = arg_78_1.actors_["10023"].transform

			if 3.8 < arg_78_1.time_ and arg_78_1.time_ <= 3.8 + arg_81_0 then
				arg_78_1.var_.moveOldPos10023 = var_81_2.localPosition
				var_81_2.localScale = Vector3.New(1, 1, 1)

				arg_78_1:CheckSpriteTmpPos("10023", 2)
			end

			local var_81_3 = 0.001

			if 3.8 <= arg_78_1.time_ and arg_78_1.time_ < 3.8 + var_81_3 then
				var_81_2.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos10023, Vector3.New(-390, -350, -180), (arg_78_1.time_ - 3.8) / var_81_3)
			end

			if arg_78_1.time_ >= 3.8 + var_81_3 and arg_78_1.time_ < 3.8 + var_81_3 + arg_81_0 then
				var_81_2.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_81_4 = arg_78_1.actors_["10023"]

			if 3.8 < arg_78_1.time_ and arg_78_1.time_ <= 3.8 + arg_81_0 and not isNil(var_81_4) then
				local var_81_5 = var_81_4:GetComponent("Image")

				if var_81_5 then
					arg_78_1.var_.highlightMatValue10023 = var_81_5
				end
			end

			local var_81_6 = 0.034

			if 3.8 <= arg_78_1.time_ and arg_78_1.time_ < 3.8 + var_81_6 and not isNil(var_81_4) then
				if arg_78_1.var_.highlightMatValue10023 then
					local var_81_7 = Mathf.Lerp(0.5, 1, (arg_78_1.time_ - 3.8) / var_81_6)

					arg_78_1.var_.highlightMatValue10023.color.r = var_81_7
					arg_78_1.var_.highlightMatValue10023.color.g = var_81_7
					arg_78_1.var_.highlightMatValue10023.color.b = var_81_7
					arg_78_1.var_.highlightMatValue10023.color = arg_78_1.var_.highlightMatValue10023.color
				end
			end

			if arg_78_1.time_ >= 3.8 + var_81_6 and arg_78_1.time_ < 3.8 + var_81_6 + arg_81_0 and not isNil(var_81_4) and arg_78_1.var_.highlightMatValue10023 then
				var_81_4.transform:SetSiblingIndex(1)

				arg_78_1.var_.highlightMatValue10023.color.r = 1
				arg_78_1.var_.highlightMatValue10023.color.g = 1
				arg_78_1.var_.highlightMatValue10023.color.b = 1
				arg_78_1.var_.highlightMatValue10023.color = arg_78_1.var_.highlightMatValue10023.color
			end

			if 1.98333333333333 < arg_78_1.time_ and arg_78_1.time_ <= 1.98333333333333 + arg_81_0 then
				arg_78_1.fswbg_:SetActive(false)
				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_78_1:ShowNextGo(false)
			end

			if 3.8 < arg_78_1.time_ and arg_78_1.time_ <= 3.8 + arg_81_0 then
				local var_81_8 = arg_78_1.actors_["10023"]:GetComponent("Image")

				if var_81_8 then
					arg_78_1.var_.alphaMatValue10023 = var_81_8
					arg_78_1.var_.alphaOldValue10023 = var_81_8.color.a
				end

				arg_78_1.var_.alphaOldValue10023 = 0
			end

			local var_81_9 = 0.5

			if 3.8 <= arg_78_1.time_ and arg_78_1.time_ < 3.8 + var_81_9 then
				if arg_78_1.var_.alphaMatValue10023 then
					arg_78_1.var_.alphaMatValue10023.color.a = Mathf.Lerp(arg_78_1.var_.alphaOldValue10023, 1, (arg_78_1.time_ - 3.8) / var_81_9)
					arg_78_1.var_.alphaMatValue10023.color = arg_78_1.var_.alphaMatValue10023.color
				end
			end

			if arg_78_1.time_ >= 3.8 + var_81_9 and arg_78_1.time_ < 3.8 + var_81_9 + arg_81_0 and arg_78_1.var_.alphaMatValue10023 then
				arg_78_1.var_.alphaMatValue10023.color.a = 1
				arg_78_1.var_.alphaMatValue10023.color = arg_78_1.var_.alphaMatValue10023.color
			end

			local var_81_10 = 0

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_10 + arg_81_0 then
				arg_78_1.mask_.enabled = true
				arg_78_1.mask_.raycastTarget = true

				arg_78_1:SetGaussion(false)
			end

			local var_81_11 = 2

			if var_81_10 <= arg_78_1.time_ and arg_78_1.time_ < var_81_10 + var_81_11 then
				local var_81_12 = Color.New(0, 0, 0)

				var_81_12.a = Mathf.Lerp(0, 1, (arg_78_1.time_ - var_81_10) / var_81_11)
				arg_78_1.mask_.color = var_81_12
			end

			if arg_78_1.time_ >= var_81_10 + var_81_11 and arg_78_1.time_ < var_81_10 + var_81_11 + arg_81_0 then
				local var_81_13 = Color.New(0, 0, 0)

				var_81_13.a = 1
				arg_78_1.mask_.color = var_81_13
			end

			local var_81_14 = 2

			if 2 < arg_78_1.time_ and arg_78_1.time_ <= var_81_14 + arg_81_0 then
				arg_78_1.mask_.enabled = true
				arg_78_1.mask_.raycastTarget = true

				arg_78_1:SetGaussion(false)
			end

			local var_81_15 = 2

			if var_81_14 <= arg_78_1.time_ and arg_78_1.time_ < var_81_14 + var_81_15 then
				local var_81_16 = Color.New(0, 0, 0)

				var_81_16.a = Mathf.Lerp(1, 0, (arg_78_1.time_ - var_81_14) / var_81_15)
				arg_78_1.mask_.color = var_81_16
			end

			if arg_78_1.time_ >= var_81_14 + var_81_15 and arg_78_1.time_ < var_81_14 + var_81_15 + arg_81_0 then
				local var_81_17 = Color.New(0, 0, 0)

				arg_78_1.mask_.enabled = false
				var_81_17.a = 0
				arg_78_1.mask_.color = var_81_17
			end

			local var_81_18 = "F04"

			if arg_78_1.bgs_.F04 == nil then
				local var_81_19 = Object.Instantiate(arg_78_1.paintGo_)

				var_81_19:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_81_18)
				var_81_19.name = var_81_18
				var_81_19.transform.parent = arg_78_1.stage_.transform
				var_81_19.transform.localPosition = Vector3.New(0, 100, 0)
				arg_78_1.bgs_[var_81_18] = var_81_19
			end

			if 2 < arg_78_1.time_ and arg_78_1.time_ <= 2 + arg_81_0 then
				local var_81_20 = arg_78_1.bgs_.F04

				arg_78_1.bgs_.F04.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_81_20.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_81_21 = var_81_20:GetComponent("SpriteRenderer")

				if var_81_21 and var_81_21.sprite then
					local var_81_22 = 2 * (var_81_20.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_81_20.transform.localScale = Vector3.New(var_81_22 / var_81_21.sprite.bounds.size.y < var_81_22 * manager.ui.mainCameraCom_.aspect / var_81_21.sprite.bounds.size.x and var_81_22 * manager.ui.mainCameraCom_.aspect / var_81_21.sprite.bounds.size.x or var_81_22 / var_81_21.sprite.bounds.size.y, var_81_22 / var_81_21.sprite.bounds.size.y < var_81_22 * manager.ui.mainCameraCom_.aspect / var_81_21.sprite.bounds.size.x and var_81_22 * manager.ui.mainCameraCom_.aspect / var_81_21.sprite.bounds.size.x or var_81_22 / var_81_21.sprite.bounds.size.y, 0)
				end

				for iter_81_0, iter_81_1 in pairs(arg_78_1.bgs_) do
					if iter_81_0 ~= "F04" then
						iter_81_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 2 < arg_78_1.time_ and arg_78_1.time_ <= 2 + arg_81_0 then
				arg_78_1:AudioAction("play", "music", "bgm_activity_1_3_story_outdoor", "bgm_activity_1_3_story_outdoor", "bgm_activity_1_3_story_outdoor.awb")

				local var_81_25 = manager.audio:GetAudioName("bgm_activity_1_3_story_outdoor", "bgm_activity_1_3_story_outdoor")

				if "" ~= "" then
					if arg_78_1.bgmTxt_.text ~= var_81_25 and arg_78_1.bgmTxt_.text ~= "" then
						if arg_78_1.bgmTxt2_.text ~= "" then
							arg_78_1.bgmTxt_.text = arg_78_1.bgmTxt2_.text
						end

						arg_78_1.bgmTxt2_.text = var_81_25

						arg_78_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_78_1.bgmTxt_.text = var_81_25
						arg_78_1.bgmTxt2_.text = var_81_25
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

			local var_81_26 = 4
			local var_81_27 = 0.225

			if 4 < arg_78_1.time_ and arg_78_1.time_ <= var_81_26 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0

				arg_78_1.dialog_:SetActive(true)

				arg_78_1.dialogCg_.alpha = 0

				local var_81_28 = LeanTween.value(arg_78_1.dialog_, 0, 1, 0.3)

				var_81_28:setOnUpdate(LuaHelper.FloatAction(function(arg_83_0)
					arg_78_1.dialogCg_.alpha = arg_83_0
				end))
				var_81_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_78_1.dialog_)
					var_81_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_78_1.duration_ = arg_78_1.duration_ + 0.3

				SetActive(arg_78_1.leftNameGo_, true)

				arg_78_1.leftNameTxt_.text = arg_78_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_29 = arg_78_1:GetWordFromCfg(114282020)
				local var_81_30 = arg_78_1:FormatText(var_81_29.content)

				arg_78_1.text_.text = var_81_30

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_32 = 9 <= 0 and var_81_27 or var_81_27 * (utf8.len(var_81_30) / 9)

				if (9 <= 0 and var_81_27 or var_81_27 * (utf8.len(var_81_30) / 9)) > 0 and var_81_27 < var_81_32 then
					arg_78_1.talkMaxDuration = var_81_32
					var_81_26 = var_81_26 + 0.3

					if var_81_32 + var_81_26 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_32 + var_81_26
					end
				end

				arg_78_1.text_.text = var_81_30
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114282", "114282020", "story_v_out_114282.awb") ~= 0 then
					local var_81_33 = manager.audio:GetVoiceLength("story_v_out_114282", "114282020", "story_v_out_114282.awb") / 1000

					if var_81_33 + var_81_26 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_33 + var_81_26
					end

					if var_81_29.prefab_name ~= "" and arg_78_1.actors_[var_81_29.prefab_name] ~= nil then
						local var_81_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_29.prefab_name].transform, "story_v_out_114282", "114282020", "story_v_out_114282.awb")

						arg_78_1:RecordAudio("114282020", var_81_34)
						arg_78_1:RecordAudio("114282020", var_81_34)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_114282", "114282020", "story_v_out_114282.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_114282", "114282020", "story_v_out_114282.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_35 = var_81_26 + 0.3
			local var_81_36 = math.max(var_81_27, arg_78_1.talkMaxDuration)

			if var_81_26 + 0.3 <= arg_78_1.time_ and arg_78_1.time_ < var_81_35 + var_81_36 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_35) / var_81_36

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_35 + var_81_36 and arg_78_1.time_ < var_81_35 + var_81_36 + arg_81_0 then
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
			if arg_85_1.actors_["10022"] == nil then
				local var_88_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10022")

				if not isNil(var_88_0) then
					local var_88_1 = Object.Instantiate(var_88_0, arg_85_1.canvasGo_.transform)

					var_88_1.transform:SetSiblingIndex(1)

					var_88_1.name = "10022"
					var_88_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_85_1.actors_["10022"] = var_88_1

					if arg_85_1.isInRecall_ then
						for iter_88_0, iter_88_1 in ipairs((var_88_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_88_1.color = arg_85_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				local var_88_2 = arg_85_1.actors_["10022"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_88_2 then
					arg_85_1.var_.alphaOldValue10022 = var_88_2.alpha
					arg_85_1.var_.characterEffect10022 = var_88_2
				end

				arg_85_1.var_.alphaOldValue10022 = 0
			end

			local var_88_3 = 0.5

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_3 then
				if arg_85_1.var_.characterEffect10022 then
					arg_85_1.var_.characterEffect10022.alpha = Mathf.Lerp(arg_85_1.var_.alphaOldValue10022, 1, (arg_85_1.time_ - 0) / var_88_3)
				end
			end

			if arg_85_1.time_ >= 0 + var_88_3 and arg_85_1.time_ < 0 + var_88_3 + arg_88_0 and arg_85_1.var_.characterEffect10022 then
				arg_85_1.var_.characterEffect10022.alpha = 1
			end

			local var_88_4 = arg_85_1.actors_["10023"].transform

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos10023 = var_88_4.localPosition
				var_88_4.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("10023", 7)
			end

			local var_88_5 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_5 then
				var_88_4.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10023, Vector3.New(0, -2000, -180), (arg_85_1.time_ - 0) / var_88_5)
			end

			if arg_85_1.time_ >= 0 + var_88_5 and arg_85_1.time_ < 0 + var_88_5 + arg_88_0 then
				var_88_4.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_88_6 = arg_85_1.actors_["10022"].transform

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos10022 = var_88_6.localPosition
				var_88_6.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("10022", 2)

				for iter_88_2 = 0, var_88_6.childCount - 1 do
					local var_88_7 = var_88_6:GetChild(iter_88_2)

					if var_88_7.name == "split_6" or not string.find(var_88_7.name, "split") then
						var_88_7.gameObject:SetActive(true)
					else
						var_88_7.gameObject:SetActive(false)
					end
				end
			end

			local var_88_8 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_8 then
				var_88_6.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10022, Vector3.New(-390, -350, -180), (arg_85_1.time_ - 0) / var_88_8)
			end

			if arg_85_1.time_ >= 0 + var_88_8 and arg_85_1.time_ < 0 + var_88_8 + arg_88_0 then
				var_88_6.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_88_9 = "10017"

			if arg_85_1.actors_["10017"] == nil then
				local var_88_10 = Object.Instantiate(arg_85_1.imageGo_, arg_85_1.canvasGo_.transform)

				var_88_10.transform:SetSiblingIndex(1)

				var_88_10.name = var_88_9

				local var_88_11 = var_88_10:GetComponent(typeof(Image))

				var_88_11.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "10017")

				var_88_11:SetNativeSize()

				var_88_10.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_85_1.actors_[var_88_9] = var_88_10
			end

			local var_88_12 = arg_85_1.actors_["10017"].transform

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos10017 = var_88_12.localPosition
				var_88_12.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("10017", 4)
			end

			local var_88_13 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_13 then
				var_88_12.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10017, Vector3.New(390, -350, -180), (arg_85_1.time_ - 0) / var_88_13)
			end

			if arg_85_1.time_ >= 0 + var_88_13 and arg_85_1.time_ < 0 + var_88_13 + arg_88_0 then
				var_88_12.localPosition = Vector3.New(390, -350, -180)
			end

			local var_88_14 = arg_85_1.actors_["10022"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_14) and arg_85_1.var_.actorSpriteComps10022 == nil then
				arg_85_1.var_.actorSpriteComps10022 = var_88_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_15 = 0.034

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_15 and not isNil(var_88_14) then
				if arg_85_1.var_.actorSpriteComps10022 then
					for iter_88_3, iter_88_4 in pairs(arg_85_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_88_4 then
							if arg_85_1.isInRecall_ then
								iter_88_4.color = Color.New(Mathf.Lerp(iter_88_4.color.r, arg_85_1.hightColor1.r, (arg_85_1.time_ - 0) / var_88_15), Mathf.Lerp(iter_88_4.color.g, arg_85_1.hightColor1.g, (arg_85_1.time_ - 0) / var_88_15), (Mathf.Lerp(iter_88_4.color.b, arg_85_1.hightColor1.b, (arg_85_1.time_ - 0) / var_88_15)))
							else
								local var_88_16 = Mathf.Lerp(iter_88_4.color.r, 1, (arg_85_1.time_ - 0) / var_88_15)

								iter_88_4.color = Color.New(var_88_16, var_88_16, var_88_16)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= 0 + var_88_15 and arg_85_1.time_ < 0 + var_88_15 + arg_88_0 and not isNil(var_88_14) and arg_85_1.var_.actorSpriteComps10022 then
				for iter_88_5, iter_88_6 in pairs(arg_85_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_88_6 then
						iter_88_6.color = arg_85_1.isInRecall_ and (arg_85_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_85_1.var_.actorSpriteComps10022 = nil
			end

			local var_88_17 = arg_85_1.actors_["10017"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_17) then
				local var_88_18 = var_88_17:GetComponent("Image")

				if var_88_18 then
					arg_85_1.var_.highlightMatValue10017 = var_88_18
				end
			end

			local var_88_19 = 0.034

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_19 and not isNil(var_88_17) then
				if arg_85_1.var_.highlightMatValue10017 then
					local var_88_20 = Mathf.Lerp(1, 0.5, (arg_85_1.time_ - 0) / var_88_19)

					arg_85_1.var_.highlightMatValue10017.color.r = var_88_20
					arg_85_1.var_.highlightMatValue10017.color.g = var_88_20
					arg_85_1.var_.highlightMatValue10017.color.b = var_88_20
					arg_85_1.var_.highlightMatValue10017.color = arg_85_1.var_.highlightMatValue10017.color
				end
			end

			if arg_85_1.time_ >= 0 + var_88_19 and arg_85_1.time_ < 0 + var_88_19 + arg_88_0 and not isNil(var_88_17) and arg_85_1.var_.highlightMatValue10017 then
				arg_85_1.var_.highlightMatValue10017.color.r = 0.5
				arg_85_1.var_.highlightMatValue10017.color.g = 0.5
				arg_85_1.var_.highlightMatValue10017.color.b = 0.5
				arg_85_1.var_.highlightMatValue10017.color = arg_85_1.var_.highlightMatValue10017.color
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				local var_88_21 = arg_85_1.actors_["10017"]:GetComponent("Image")

				if var_88_21 then
					arg_85_1.var_.alphaMatValue10017 = var_88_21
					arg_85_1.var_.alphaOldValue10017 = var_88_21.color.a
				end

				arg_85_1.var_.alphaOldValue10017 = 0
			end

			local var_88_22 = 0.5

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_22 then
				if arg_85_1.var_.alphaMatValue10017 then
					arg_85_1.var_.alphaMatValue10017.color.a = Mathf.Lerp(arg_85_1.var_.alphaOldValue10017, 1, (arg_85_1.time_ - 0) / var_88_22)
					arg_85_1.var_.alphaMatValue10017.color = arg_85_1.var_.alphaMatValue10017.color
				end
			end

			if arg_85_1.time_ >= 0 + var_88_22 and arg_85_1.time_ < 0 + var_88_22 + arg_88_0 and arg_85_1.var_.alphaMatValue10017 then
				arg_85_1.var_.alphaMatValue10017.color.a = 1
				arg_85_1.var_.alphaMatValue10017.color = arg_85_1.var_.alphaMatValue10017.color
			end

			local var_88_23 = 0
			local var_88_24 = 0.075

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_23 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[235].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_25 = arg_85_1:GetWordFromCfg(114282021)
				local var_88_26 = arg_85_1:FormatText(var_88_25.content)

				arg_85_1.text_.text = var_88_26

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_28 = 3 <= 0 and var_88_24 or var_88_24 * (utf8.len(var_88_26) / 3)

				if (3 <= 0 and var_88_24 or var_88_24 * (utf8.len(var_88_26) / 3)) > 0 and var_88_24 < var_88_28 then
					arg_85_1.talkMaxDuration = var_88_28

					if var_88_28 + var_88_23 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_28 + var_88_23
					end
				end

				arg_85_1.text_.text = var_88_26
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114282", "114282021", "story_v_out_114282.awb") ~= 0 then
					local var_88_29 = manager.audio:GetVoiceLength("story_v_out_114282", "114282021", "story_v_out_114282.awb") / 1000

					if var_88_29 + var_88_23 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_29 + var_88_23
					end

					if var_88_25.prefab_name ~= "" and arg_85_1.actors_[var_88_25.prefab_name] ~= nil then
						local var_88_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_25.prefab_name].transform, "story_v_out_114282", "114282021", "story_v_out_114282.awb")

						arg_85_1:RecordAudio("114282021", var_88_30)
						arg_85_1:RecordAudio("114282021", var_88_30)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_114282", "114282021", "story_v_out_114282.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_114282", "114282021", "story_v_out_114282.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_31 = math.max(var_88_24, arg_85_1.talkMaxDuration)

			if var_88_23 <= arg_85_1.time_ and arg_85_1.time_ < var_88_23 + var_88_31 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_23) / var_88_31

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_23 + var_88_31 and arg_85_1.time_ < var_88_23 + var_88_31 + arg_88_0 then
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
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(arg_89_1.actors_["10022"]) and arg_89_1.var_.actorSpriteComps10022 == nil then
				arg_89_1.var_.actorSpriteComps10022 = arg_89_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_0 = 0.034

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 and not isNil(arg_89_1.actors_["10022"]) then
				if arg_89_1.var_.actorSpriteComps10022 then
					for iter_92_0, iter_92_1 in pairs(arg_89_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_92_1 then
							if arg_89_1.isInRecall_ then
								iter_92_1.color = Color.New(Mathf.Lerp(iter_92_1.color.r, arg_89_1.hightColor2.r, (arg_89_1.time_ - 0) / var_92_0), Mathf.Lerp(iter_92_1.color.g, arg_89_1.hightColor2.g, (arg_89_1.time_ - 0) / var_92_0), (Mathf.Lerp(iter_92_1.color.b, arg_89_1.hightColor2.b, (arg_89_1.time_ - 0) / var_92_0)))
							else
								local var_92_1 = Mathf.Lerp(iter_92_1.color.r, 0.5, (arg_89_1.time_ - 0) / var_92_0)

								iter_92_1.color = Color.New(var_92_1, var_92_1, var_92_1)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 and not isNil(arg_89_1.actors_["10022"]) and arg_89_1.var_.actorSpriteComps10022 then
				for iter_92_2, iter_92_3 in pairs(arg_89_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_92_3 then
						iter_92_3.color = arg_89_1.isInRecall_ and (arg_89_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_89_1.var_.actorSpriteComps10022 = nil
			end

			local var_92_2 = arg_89_1.actors_["10017"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_2) then
				local var_92_3 = var_92_2:GetComponent("Image")

				if var_92_3 then
					arg_89_1.var_.highlightMatValue10017 = var_92_3
				end
			end

			local var_92_4 = 0.034

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_4 and not isNil(var_92_2) then
				if arg_89_1.var_.highlightMatValue10017 then
					local var_92_5 = Mathf.Lerp(0.5, 1, (arg_89_1.time_ - 0) / var_92_4)

					arg_89_1.var_.highlightMatValue10017.color.r = var_92_5
					arg_89_1.var_.highlightMatValue10017.color.g = var_92_5
					arg_89_1.var_.highlightMatValue10017.color.b = var_92_5
					arg_89_1.var_.highlightMatValue10017.color = arg_89_1.var_.highlightMatValue10017.color
				end
			end

			if arg_89_1.time_ >= 0 + var_92_4 and arg_89_1.time_ < 0 + var_92_4 + arg_92_0 and not isNil(var_92_2) and arg_89_1.var_.highlightMatValue10017 then
				var_92_2.transform:SetSiblingIndex(1)

				arg_89_1.var_.highlightMatValue10017.color.r = 1
				arg_89_1.var_.highlightMatValue10017.color.g = 1
				arg_89_1.var_.highlightMatValue10017.color.b = 1
				arg_89_1.var_.highlightMatValue10017.color = arg_89_1.var_.highlightMatValue10017.color
			end

			local var_92_6 = 0
			local var_92_7 = 0.175

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_6 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[255].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_8 = arg_89_1:GetWordFromCfg(114282022)
				local var_92_9 = arg_89_1:FormatText(var_92_8.content)

				arg_89_1.text_.text = var_92_9

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_11 = 7 <= 0 and var_92_7 or var_92_7 * (utf8.len(var_92_9) / 7)

				if (7 <= 0 and var_92_7 or var_92_7 * (utf8.len(var_92_9) / 7)) > 0 and var_92_7 < var_92_11 then
					arg_89_1.talkMaxDuration = var_92_11

					if var_92_11 + var_92_6 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_11 + var_92_6
					end
				end

				arg_89_1.text_.text = var_92_9
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114282", "114282022", "story_v_out_114282.awb") ~= 0 then
					local var_92_12 = manager.audio:GetVoiceLength("story_v_out_114282", "114282022", "story_v_out_114282.awb") / 1000

					if var_92_12 + var_92_6 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_12 + var_92_6
					end

					if var_92_8.prefab_name ~= "" and arg_89_1.actors_[var_92_8.prefab_name] ~= nil then
						local var_92_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_8.prefab_name].transform, "story_v_out_114282", "114282022", "story_v_out_114282.awb")

						arg_89_1:RecordAudio("114282022", var_92_13)
						arg_89_1:RecordAudio("114282022", var_92_13)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_114282", "114282022", "story_v_out_114282.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_114282", "114282022", "story_v_out_114282.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_14 = math.max(var_92_7, arg_89_1.talkMaxDuration)

			if var_92_6 <= arg_89_1.time_ and arg_89_1.time_ < var_92_6 + var_92_14 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_6) / var_92_14

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_6 + var_92_14 and arg_89_1.time_ < var_92_6 + var_92_14 + arg_92_0 then
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
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(arg_93_1.actors_["10017"]) then
				local var_96_0 = arg_93_1.actors_["10017"]:GetComponent("Image")

				if var_96_0 then
					arg_93_1.var_.highlightMatValue10017 = var_96_0
				end
			end

			local var_96_1 = 0.034

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_1 and not isNil(arg_93_1.actors_["10017"]) then
				if arg_93_1.var_.highlightMatValue10017 then
					local var_96_2 = Mathf.Lerp(1, 0.5, (arg_93_1.time_ - 0) / var_96_1)

					arg_93_1.var_.highlightMatValue10017.color.r = var_96_2
					arg_93_1.var_.highlightMatValue10017.color.g = var_96_2
					arg_93_1.var_.highlightMatValue10017.color.b = var_96_2
					arg_93_1.var_.highlightMatValue10017.color = arg_93_1.var_.highlightMatValue10017.color
				end
			end

			if arg_93_1.time_ >= 0 + var_96_1 and arg_93_1.time_ < 0 + var_96_1 + arg_96_0 and not isNil(arg_93_1.actors_["10017"]) and arg_93_1.var_.highlightMatValue10017 then
				arg_93_1.var_.highlightMatValue10017.color.r = 0.5
				arg_93_1.var_.highlightMatValue10017.color.g = 0.5
				arg_93_1.var_.highlightMatValue10017.color.b = 0.5
				arg_93_1.var_.highlightMatValue10017.color = arg_93_1.var_.highlightMatValue10017.color
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				local var_96_3 = arg_93_1.actors_["10022"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_96_3 then
					arg_93_1.var_.alphaOldValue10022 = var_96_3.alpha
					arg_93_1.var_.characterEffect10022 = var_96_3
				end

				arg_93_1.var_.alphaOldValue10022 = 1
			end

			local var_96_4 = 0.5

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_4 then
				if arg_93_1.var_.characterEffect10022 then
					arg_93_1.var_.characterEffect10022.alpha = Mathf.Lerp(arg_93_1.var_.alphaOldValue10022, 0, (arg_93_1.time_ - 0) / var_96_4)
				end
			end

			if arg_93_1.time_ >= 0 + var_96_4 and arg_93_1.time_ < 0 + var_96_4 + arg_96_0 and arg_93_1.var_.characterEffect10022 then
				arg_93_1.var_.characterEffect10022.alpha = 0
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				local var_96_5 = arg_93_1.actors_["10017"]:GetComponent("Image")

				if var_96_5 then
					arg_93_1.var_.alphaMatValue10017 = var_96_5
					arg_93_1.var_.alphaOldValue10017 = var_96_5.color.a
				end

				arg_93_1.var_.alphaOldValue10017 = 1
			end

			local var_96_6 = 0.5

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_6 then
				if arg_93_1.var_.alphaMatValue10017 then
					arg_93_1.var_.alphaMatValue10017.color.a = Mathf.Lerp(arg_93_1.var_.alphaOldValue10017, 0, (arg_93_1.time_ - 0) / var_96_6)
					arg_93_1.var_.alphaMatValue10017.color = arg_93_1.var_.alphaMatValue10017.color
				end
			end

			if arg_93_1.time_ >= 0 + var_96_6 and arg_93_1.time_ < 0 + var_96_6 + arg_96_0 and arg_93_1.var_.alphaMatValue10017 then
				arg_93_1.var_.alphaMatValue10017.color.a = 0
				arg_93_1.var_.alphaMatValue10017.color = arg_93_1.var_.alphaMatValue10017.color
			end

			local var_96_7 = 0
			local var_96_8 = 1.05

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_7 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_9 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(114282023).content)

				arg_93_1.text_.text = var_96_9

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_11 = 42 <= 0 and var_96_8 or var_96_8 * (utf8.len(var_96_9) / 42)

				if (42 <= 0 and var_96_8 or var_96_8 * (utf8.len(var_96_9) / 42)) > 0 and var_96_8 < var_96_11 then
					arg_93_1.talkMaxDuration = var_96_11

					if var_96_11 + var_96_7 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_11 + var_96_7
					end
				end

				arg_93_1.text_.text = var_96_9
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_12 = math.max(var_96_8, arg_93_1.talkMaxDuration)

			if var_96_7 <= arg_93_1.time_ and arg_93_1.time_ < var_96_7 + var_96_12 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_7) / var_96_12

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_7 + var_96_12 and arg_93_1.time_ < var_96_7 + var_96_12 + arg_96_0 then
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
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				local var_100_0 = arg_97_1.actors_["10023"]:GetComponent("Image")

				if var_100_0 then
					arg_97_1.var_.alphaMatValue10023 = var_100_0
					arg_97_1.var_.alphaOldValue10023 = var_100_0.color.a
				end

				arg_97_1.var_.alphaOldValue10023 = 0
			end

			local var_100_1 = 0.5

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_1 then
				if arg_97_1.var_.alphaMatValue10023 then
					arg_97_1.var_.alphaMatValue10023.color.a = Mathf.Lerp(arg_97_1.var_.alphaOldValue10023, 1, (arg_97_1.time_ - 0) / var_100_1)
					arg_97_1.var_.alphaMatValue10023.color = arg_97_1.var_.alphaMatValue10023.color
				end
			end

			if arg_97_1.time_ >= 0 + var_100_1 and arg_97_1.time_ < 0 + var_100_1 + arg_100_0 and arg_97_1.var_.alphaMatValue10023 then
				arg_97_1.var_.alphaMatValue10023.color.a = 1
				arg_97_1.var_.alphaMatValue10023.color = arg_97_1.var_.alphaMatValue10023.color
			end

			local var_100_2 = arg_97_1.actors_["10023"].transform

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos10023 = var_100_2.localPosition
				var_100_2.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("10023", 2)
			end

			local var_100_3 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_3 then
				var_100_2.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10023, Vector3.New(-390, -350, -180), (arg_97_1.time_ - 0) / var_100_3)
			end

			if arg_97_1.time_ >= 0 + var_100_3 and arg_97_1.time_ < 0 + var_100_3 + arg_100_0 then
				var_100_2.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_100_4 = arg_97_1.actors_["10023"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_4) then
				local var_100_5 = var_100_4:GetComponent("Image")

				if var_100_5 then
					arg_97_1.var_.highlightMatValue10023 = var_100_5
				end
			end

			local var_100_6 = 0.034

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_6 and not isNil(var_100_4) then
				if arg_97_1.var_.highlightMatValue10023 then
					local var_100_7 = Mathf.Lerp(0.5, 1, (arg_97_1.time_ - 0) / var_100_6)

					arg_97_1.var_.highlightMatValue10023.color.r = var_100_7
					arg_97_1.var_.highlightMatValue10023.color.g = var_100_7
					arg_97_1.var_.highlightMatValue10023.color.b = var_100_7
					arg_97_1.var_.highlightMatValue10023.color = arg_97_1.var_.highlightMatValue10023.color
				end
			end

			if arg_97_1.time_ >= 0 + var_100_6 and arg_97_1.time_ < 0 + var_100_6 + arg_100_0 and not isNil(var_100_4) and arg_97_1.var_.highlightMatValue10023 then
				var_100_4.transform:SetSiblingIndex(1)

				arg_97_1.var_.highlightMatValue10023.color.r = 1
				arg_97_1.var_.highlightMatValue10023.color.g = 1
				arg_97_1.var_.highlightMatValue10023.color.b = 1
				arg_97_1.var_.highlightMatValue10023.color = arg_97_1.var_.highlightMatValue10023.color
			end

			local var_100_8 = 0
			local var_100_9 = 0.325

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_8 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_10 = arg_97_1:GetWordFromCfg(114282024)
				local var_100_11 = arg_97_1:FormatText(var_100_10.content)

				arg_97_1.text_.text = var_100_11

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_13 = 13 <= 0 and var_100_9 or var_100_9 * (utf8.len(var_100_11) / 13)

				if (13 <= 0 and var_100_9 or var_100_9 * (utf8.len(var_100_11) / 13)) > 0 and var_100_9 < var_100_13 then
					arg_97_1.talkMaxDuration = var_100_13

					if var_100_13 + var_100_8 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_13 + var_100_8
					end
				end

				arg_97_1.text_.text = var_100_11
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114282", "114282024", "story_v_out_114282.awb") ~= 0 then
					local var_100_14 = manager.audio:GetVoiceLength("story_v_out_114282", "114282024", "story_v_out_114282.awb") / 1000

					if var_100_14 + var_100_8 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_14 + var_100_8
					end

					if var_100_10.prefab_name ~= "" and arg_97_1.actors_[var_100_10.prefab_name] ~= nil then
						local var_100_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_10.prefab_name].transform, "story_v_out_114282", "114282024", "story_v_out_114282.awb")

						arg_97_1:RecordAudio("114282024", var_100_15)
						arg_97_1:RecordAudio("114282024", var_100_15)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_114282", "114282024", "story_v_out_114282.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_114282", "114282024", "story_v_out_114282.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_16 = math.max(var_100_9, arg_97_1.talkMaxDuration)

			if var_100_8 <= arg_97_1.time_ and arg_97_1.time_ < var_100_8 + var_100_16 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_8) / var_100_16

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_8 + var_100_16 and arg_97_1.time_ < var_100_8 + var_100_16 + arg_100_0 then
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
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos10017 = arg_101_1.actors_["10017"].transform.localPosition
				arg_101_1.actors_["10017"].transform.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("10017", 4)
			end

			local var_104_0 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 then
				arg_101_1.actors_["10017"].transform.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos10017, Vector3.New(390, -350, -180), (arg_101_1.time_ - 0) / var_104_0)
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 then
				arg_101_1.actors_["10017"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_104_1 = arg_101_1.actors_["10023"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_1) then
				local var_104_2 = var_104_1:GetComponent("Image")

				if var_104_2 then
					arg_101_1.var_.highlightMatValue10023 = var_104_2
				end
			end

			local var_104_3 = 0.034

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_3 and not isNil(var_104_1) then
				if arg_101_1.var_.highlightMatValue10023 then
					local var_104_4 = Mathf.Lerp(1, 0.5, (arg_101_1.time_ - 0) / var_104_3)

					arg_101_1.var_.highlightMatValue10023.color.r = var_104_4
					arg_101_1.var_.highlightMatValue10023.color.g = var_104_4
					arg_101_1.var_.highlightMatValue10023.color.b = var_104_4
					arg_101_1.var_.highlightMatValue10023.color = arg_101_1.var_.highlightMatValue10023.color
				end
			end

			if arg_101_1.time_ >= 0 + var_104_3 and arg_101_1.time_ < 0 + var_104_3 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.highlightMatValue10023 then
				arg_101_1.var_.highlightMatValue10023.color.r = 0.5
				arg_101_1.var_.highlightMatValue10023.color.g = 0.5
				arg_101_1.var_.highlightMatValue10023.color.b = 0.5
				arg_101_1.var_.highlightMatValue10023.color = arg_101_1.var_.highlightMatValue10023.color
			end

			local var_104_5 = arg_101_1.actors_["10017"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_5) then
				local var_104_6 = var_104_5:GetComponent("Image")

				if var_104_6 then
					arg_101_1.var_.highlightMatValue10017 = var_104_6
				end
			end

			local var_104_7 = 0.034

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_7 and not isNil(var_104_5) then
				if arg_101_1.var_.highlightMatValue10017 then
					local var_104_8 = Mathf.Lerp(0.5, 1, (arg_101_1.time_ - 0) / var_104_7)

					arg_101_1.var_.highlightMatValue10017.color.r = var_104_8
					arg_101_1.var_.highlightMatValue10017.color.g = var_104_8
					arg_101_1.var_.highlightMatValue10017.color.b = var_104_8
					arg_101_1.var_.highlightMatValue10017.color = arg_101_1.var_.highlightMatValue10017.color
				end
			end

			if arg_101_1.time_ >= 0 + var_104_7 and arg_101_1.time_ < 0 + var_104_7 + arg_104_0 and not isNil(var_104_5) and arg_101_1.var_.highlightMatValue10017 then
				var_104_5.transform:SetSiblingIndex(1)

				arg_101_1.var_.highlightMatValue10017.color.r = 1
				arg_101_1.var_.highlightMatValue10017.color.g = 1
				arg_101_1.var_.highlightMatValue10017.color.b = 1
				arg_101_1.var_.highlightMatValue10017.color = arg_101_1.var_.highlightMatValue10017.color
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				local var_104_9 = arg_101_1.actors_["10017"]:GetComponent("Image")

				if var_104_9 then
					arg_101_1.var_.alphaMatValue10017 = var_104_9
					arg_101_1.var_.alphaOldValue10017 = var_104_9.color.a
				end

				arg_101_1.var_.alphaOldValue10017 = 0
			end

			local var_104_10 = 0.5

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_10 then
				if arg_101_1.var_.alphaMatValue10017 then
					arg_101_1.var_.alphaMatValue10017.color.a = Mathf.Lerp(arg_101_1.var_.alphaOldValue10017, 1, (arg_101_1.time_ - 0) / var_104_10)
					arg_101_1.var_.alphaMatValue10017.color = arg_101_1.var_.alphaMatValue10017.color
				end
			end

			if arg_101_1.time_ >= 0 + var_104_10 and arg_101_1.time_ < 0 + var_104_10 + arg_104_0 and arg_101_1.var_.alphaMatValue10017 then
				arg_101_1.var_.alphaMatValue10017.color.a = 1
				arg_101_1.var_.alphaMatValue10017.color = arg_101_1.var_.alphaMatValue10017.color
			end

			local var_104_11 = 0
			local var_104_12 = 0.825

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_11 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[255].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_13 = arg_101_1:GetWordFromCfg(114282025)
				local var_104_14 = arg_101_1:FormatText(var_104_13.content)

				arg_101_1.text_.text = var_104_14

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_16 = 33 <= 0 and var_104_12 or var_104_12 * (utf8.len(var_104_14) / 33)

				if (33 <= 0 and var_104_12 or var_104_12 * (utf8.len(var_104_14) / 33)) > 0 and var_104_12 < var_104_16 then
					arg_101_1.talkMaxDuration = var_104_16

					if var_104_16 + var_104_11 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_16 + var_104_11
					end
				end

				arg_101_1.text_.text = var_104_14
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114282", "114282025", "story_v_out_114282.awb") ~= 0 then
					local var_104_17 = manager.audio:GetVoiceLength("story_v_out_114282", "114282025", "story_v_out_114282.awb") / 1000

					if var_104_17 + var_104_11 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_17 + var_104_11
					end

					if var_104_13.prefab_name ~= "" and arg_101_1.actors_[var_104_13.prefab_name] ~= nil then
						local var_104_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_13.prefab_name].transform, "story_v_out_114282", "114282025", "story_v_out_114282.awb")

						arg_101_1:RecordAudio("114282025", var_104_18)
						arg_101_1:RecordAudio("114282025", var_104_18)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_114282", "114282025", "story_v_out_114282.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_114282", "114282025", "story_v_out_114282.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_19 = math.max(var_104_12, arg_101_1.talkMaxDuration)

			if var_104_11 <= arg_101_1.time_ and arg_101_1.time_ < var_104_11 + var_104_19 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_11) / var_104_19

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_11 + var_104_19 and arg_101_1.time_ < var_104_11 + var_104_19 + arg_104_0 then
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
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(arg_105_1.actors_["10023"]) then
				local var_108_0 = arg_105_1.actors_["10023"]:GetComponent("Image")

				if var_108_0 then
					arg_105_1.var_.highlightMatValue10023 = var_108_0
				end
			end

			local var_108_1 = 0.034

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_1 and not isNil(arg_105_1.actors_["10023"]) then
				if arg_105_1.var_.highlightMatValue10023 then
					local var_108_2 = Mathf.Lerp(0.5, 1, (arg_105_1.time_ - 0) / var_108_1)

					arg_105_1.var_.highlightMatValue10023.color.r = var_108_2
					arg_105_1.var_.highlightMatValue10023.color.g = var_108_2
					arg_105_1.var_.highlightMatValue10023.color.b = var_108_2
					arg_105_1.var_.highlightMatValue10023.color = arg_105_1.var_.highlightMatValue10023.color
				end
			end

			if arg_105_1.time_ >= 0 + var_108_1 and arg_105_1.time_ < 0 + var_108_1 + arg_108_0 and not isNil(arg_105_1.actors_["10023"]) and arg_105_1.var_.highlightMatValue10023 then
				arg_105_1.actors_["10023"].transform:SetSiblingIndex(1)

				arg_105_1.var_.highlightMatValue10023.color.r = 1
				arg_105_1.var_.highlightMatValue10023.color.g = 1
				arg_105_1.var_.highlightMatValue10023.color.b = 1
				arg_105_1.var_.highlightMatValue10023.color = arg_105_1.var_.highlightMatValue10023.color
			end

			local var_108_3 = arg_105_1.actors_["10017"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_3) then
				local var_108_4 = var_108_3:GetComponent("Image")

				if var_108_4 then
					arg_105_1.var_.highlightMatValue10017 = var_108_4
				end
			end

			local var_108_5 = 0.034

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_5 and not isNil(var_108_3) then
				if arg_105_1.var_.highlightMatValue10017 then
					local var_108_6 = Mathf.Lerp(1, 0.5, (arg_105_1.time_ - 0) / var_108_5)

					arg_105_1.var_.highlightMatValue10017.color.r = var_108_6
					arg_105_1.var_.highlightMatValue10017.color.g = var_108_6
					arg_105_1.var_.highlightMatValue10017.color.b = var_108_6
					arg_105_1.var_.highlightMatValue10017.color = arg_105_1.var_.highlightMatValue10017.color
				end
			end

			if arg_105_1.time_ >= 0 + var_108_5 and arg_105_1.time_ < 0 + var_108_5 + arg_108_0 and not isNil(var_108_3) and arg_105_1.var_.highlightMatValue10017 then
				arg_105_1.var_.highlightMatValue10017.color.r = 0.5
				arg_105_1.var_.highlightMatValue10017.color.g = 0.5
				arg_105_1.var_.highlightMatValue10017.color.b = 0.5
				arg_105_1.var_.highlightMatValue10017.color = arg_105_1.var_.highlightMatValue10017.color
			end

			local var_108_7 = 0
			local var_108_8 = 0.6

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_7 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_9 = arg_105_1:GetWordFromCfg(114282026)
				local var_108_10 = arg_105_1:FormatText(var_108_9.content)

				arg_105_1.text_.text = var_108_10

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_12 = 24 <= 0 and var_108_8 or var_108_8 * (utf8.len(var_108_10) / 24)

				if (24 <= 0 and var_108_8 or var_108_8 * (utf8.len(var_108_10) / 24)) > 0 and var_108_8 < var_108_12 then
					arg_105_1.talkMaxDuration = var_108_12

					if var_108_12 + var_108_7 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_12 + var_108_7
					end
				end

				arg_105_1.text_.text = var_108_10
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114282", "114282026", "story_v_out_114282.awb") ~= 0 then
					local var_108_13 = manager.audio:GetVoiceLength("story_v_out_114282", "114282026", "story_v_out_114282.awb") / 1000

					if var_108_13 + var_108_7 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_13 + var_108_7
					end

					if var_108_9.prefab_name ~= "" and arg_105_1.actors_[var_108_9.prefab_name] ~= nil then
						local var_108_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_9.prefab_name].transform, "story_v_out_114282", "114282026", "story_v_out_114282.awb")

						arg_105_1:RecordAudio("114282026", var_108_14)
						arg_105_1:RecordAudio("114282026", var_108_14)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_114282", "114282026", "story_v_out_114282.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_114282", "114282026", "story_v_out_114282.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_15 = math.max(var_108_8, arg_105_1.talkMaxDuration)

			if var_108_7 <= arg_105_1.time_ and arg_105_1.time_ < var_108_7 + var_108_15 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_7) / var_108_15

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_7 + var_108_15 and arg_105_1.time_ < var_108_7 + var_108_15 + arg_108_0 then
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
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(arg_109_1.actors_["10023"]) then
				local var_112_0 = arg_109_1.actors_["10023"]:GetComponent("Image")

				if var_112_0 then
					arg_109_1.var_.highlightMatValue10023 = var_112_0
				end
			end

			local var_112_1 = 0.034

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_1 and not isNil(arg_109_1.actors_["10023"]) then
				if arg_109_1.var_.highlightMatValue10023 then
					local var_112_2 = Mathf.Lerp(1, 0.5, (arg_109_1.time_ - 0) / var_112_1)

					arg_109_1.var_.highlightMatValue10023.color.r = var_112_2
					arg_109_1.var_.highlightMatValue10023.color.g = var_112_2
					arg_109_1.var_.highlightMatValue10023.color.b = var_112_2
					arg_109_1.var_.highlightMatValue10023.color = arg_109_1.var_.highlightMatValue10023.color
				end
			end

			if arg_109_1.time_ >= 0 + var_112_1 and arg_109_1.time_ < 0 + var_112_1 + arg_112_0 and not isNil(arg_109_1.actors_["10023"]) and arg_109_1.var_.highlightMatValue10023 then
				arg_109_1.var_.highlightMatValue10023.color.r = 0.5
				arg_109_1.var_.highlightMatValue10023.color.g = 0.5
				arg_109_1.var_.highlightMatValue10023.color.b = 0.5
				arg_109_1.var_.highlightMatValue10023.color = arg_109_1.var_.highlightMatValue10023.color
			end

			local var_112_3 = arg_109_1.actors_["10017"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_3) then
				local var_112_4 = var_112_3:GetComponent("Image")

				if var_112_4 then
					arg_109_1.var_.highlightMatValue10017 = var_112_4
				end
			end

			local var_112_5 = 0.034

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_5 and not isNil(var_112_3) then
				if arg_109_1.var_.highlightMatValue10017 then
					local var_112_6 = Mathf.Lerp(0.5, 1, (arg_109_1.time_ - 0) / var_112_5)

					arg_109_1.var_.highlightMatValue10017.color.r = var_112_6
					arg_109_1.var_.highlightMatValue10017.color.g = var_112_6
					arg_109_1.var_.highlightMatValue10017.color.b = var_112_6
					arg_109_1.var_.highlightMatValue10017.color = arg_109_1.var_.highlightMatValue10017.color
				end
			end

			if arg_109_1.time_ >= 0 + var_112_5 and arg_109_1.time_ < 0 + var_112_5 + arg_112_0 and not isNil(var_112_3) and arg_109_1.var_.highlightMatValue10017 then
				var_112_3.transform:SetSiblingIndex(1)

				arg_109_1.var_.highlightMatValue10017.color.r = 1
				arg_109_1.var_.highlightMatValue10017.color.g = 1
				arg_109_1.var_.highlightMatValue10017.color.b = 1
				arg_109_1.var_.highlightMatValue10017.color = arg_109_1.var_.highlightMatValue10017.color
			end

			local var_112_7 = 0
			local var_112_8 = 0.475

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_7 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[255].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_9 = arg_109_1:GetWordFromCfg(114282027)
				local var_112_10 = arg_109_1:FormatText(var_112_9.content)

				arg_109_1.text_.text = var_112_10

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_12 = 19 <= 0 and var_112_8 or var_112_8 * (utf8.len(var_112_10) / 19)

				if (19 <= 0 and var_112_8 or var_112_8 * (utf8.len(var_112_10) / 19)) > 0 and var_112_8 < var_112_12 then
					arg_109_1.talkMaxDuration = var_112_12

					if var_112_12 + var_112_7 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_12 + var_112_7
					end
				end

				arg_109_1.text_.text = var_112_10
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114282", "114282027", "story_v_out_114282.awb") ~= 0 then
					local var_112_13 = manager.audio:GetVoiceLength("story_v_out_114282", "114282027", "story_v_out_114282.awb") / 1000

					if var_112_13 + var_112_7 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_13 + var_112_7
					end

					if var_112_9.prefab_name ~= "" and arg_109_1.actors_[var_112_9.prefab_name] ~= nil then
						local var_112_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_9.prefab_name].transform, "story_v_out_114282", "114282027", "story_v_out_114282.awb")

						arg_109_1:RecordAudio("114282027", var_112_14)
						arg_109_1:RecordAudio("114282027", var_112_14)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_114282", "114282027", "story_v_out_114282.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_114282", "114282027", "story_v_out_114282.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_15 = math.max(var_112_8, arg_109_1.talkMaxDuration)

			if var_112_7 <= arg_109_1.time_ and arg_109_1.time_ < var_112_7 + var_112_15 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_7) / var_112_15

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_7 + var_112_15 and arg_109_1.time_ < var_112_7 + var_112_15 + arg_112_0 then
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
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(arg_113_1.actors_["10023"]) then
				local var_116_0 = arg_113_1.actors_["10023"]:GetComponent("Image")

				if var_116_0 then
					arg_113_1.var_.highlightMatValue10023 = var_116_0
				end
			end

			local var_116_1 = 0.034

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_1 and not isNil(arg_113_1.actors_["10023"]) then
				if arg_113_1.var_.highlightMatValue10023 then
					local var_116_2 = Mathf.Lerp(0.5, 1, (arg_113_1.time_ - 0) / var_116_1)

					arg_113_1.var_.highlightMatValue10023.color.r = var_116_2
					arg_113_1.var_.highlightMatValue10023.color.g = var_116_2
					arg_113_1.var_.highlightMatValue10023.color.b = var_116_2
					arg_113_1.var_.highlightMatValue10023.color = arg_113_1.var_.highlightMatValue10023.color
				end
			end

			if arg_113_1.time_ >= 0 + var_116_1 and arg_113_1.time_ < 0 + var_116_1 + arg_116_0 and not isNil(arg_113_1.actors_["10023"]) and arg_113_1.var_.highlightMatValue10023 then
				arg_113_1.actors_["10023"].transform:SetSiblingIndex(1)

				arg_113_1.var_.highlightMatValue10023.color.r = 1
				arg_113_1.var_.highlightMatValue10023.color.g = 1
				arg_113_1.var_.highlightMatValue10023.color.b = 1
				arg_113_1.var_.highlightMatValue10023.color = arg_113_1.var_.highlightMatValue10023.color
			end

			local var_116_3 = arg_113_1.actors_["10017"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_3) then
				local var_116_4 = var_116_3:GetComponent("Image")

				if var_116_4 then
					arg_113_1.var_.highlightMatValue10017 = var_116_4
				end
			end

			local var_116_5 = 0.034

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_5 and not isNil(var_116_3) then
				if arg_113_1.var_.highlightMatValue10017 then
					local var_116_6 = Mathf.Lerp(1, 0.5, (arg_113_1.time_ - 0) / var_116_5)

					arg_113_1.var_.highlightMatValue10017.color.r = var_116_6
					arg_113_1.var_.highlightMatValue10017.color.g = var_116_6
					arg_113_1.var_.highlightMatValue10017.color.b = var_116_6
					arg_113_1.var_.highlightMatValue10017.color = arg_113_1.var_.highlightMatValue10017.color
				end
			end

			if arg_113_1.time_ >= 0 + var_116_5 and arg_113_1.time_ < 0 + var_116_5 + arg_116_0 and not isNil(var_116_3) and arg_113_1.var_.highlightMatValue10017 then
				arg_113_1.var_.highlightMatValue10017.color.r = 0.5
				arg_113_1.var_.highlightMatValue10017.color.g = 0.5
				arg_113_1.var_.highlightMatValue10017.color.b = 0.5
				arg_113_1.var_.highlightMatValue10017.color = arg_113_1.var_.highlightMatValue10017.color
			end

			local var_116_7 = 0
			local var_116_8 = 0.975

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_7 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_9 = arg_113_1:GetWordFromCfg(114282028)
				local var_116_10 = arg_113_1:FormatText(var_116_9.content)

				arg_113_1.text_.text = var_116_10

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_12 = 39 <= 0 and var_116_8 or var_116_8 * (utf8.len(var_116_10) / 39)

				if (39 <= 0 and var_116_8 or var_116_8 * (utf8.len(var_116_10) / 39)) > 0 and var_116_8 < var_116_12 then
					arg_113_1.talkMaxDuration = var_116_12

					if var_116_12 + var_116_7 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_12 + var_116_7
					end
				end

				arg_113_1.text_.text = var_116_10
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114282", "114282028", "story_v_out_114282.awb") ~= 0 then
					local var_116_13 = manager.audio:GetVoiceLength("story_v_out_114282", "114282028", "story_v_out_114282.awb") / 1000

					if var_116_13 + var_116_7 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_13 + var_116_7
					end

					if var_116_9.prefab_name ~= "" and arg_113_1.actors_[var_116_9.prefab_name] ~= nil then
						local var_116_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_9.prefab_name].transform, "story_v_out_114282", "114282028", "story_v_out_114282.awb")

						arg_113_1:RecordAudio("114282028", var_116_14)
						arg_113_1:RecordAudio("114282028", var_116_14)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_114282", "114282028", "story_v_out_114282.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_114282", "114282028", "story_v_out_114282.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_15 = math.max(var_116_8, arg_113_1.talkMaxDuration)

			if var_116_7 <= arg_113_1.time_ and arg_113_1.time_ < var_116_7 + var_116_15 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_7) / var_116_15

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_7 + var_116_15 and arg_113_1.time_ < var_116_7 + var_116_15 + arg_116_0 then
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
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(arg_117_1.actors_["10023"]) then
				local var_120_0 = arg_117_1.actors_["10023"]:GetComponent("Image")

				if var_120_0 then
					arg_117_1.var_.highlightMatValue10023 = var_120_0
				end
			end

			local var_120_1 = 0.034

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_1 and not isNil(arg_117_1.actors_["10023"]) then
				if arg_117_1.var_.highlightMatValue10023 then
					local var_120_2 = Mathf.Lerp(1, 0.5, (arg_117_1.time_ - 0) / var_120_1)

					arg_117_1.var_.highlightMatValue10023.color.r = var_120_2
					arg_117_1.var_.highlightMatValue10023.color.g = var_120_2
					arg_117_1.var_.highlightMatValue10023.color.b = var_120_2
					arg_117_1.var_.highlightMatValue10023.color = arg_117_1.var_.highlightMatValue10023.color
				end
			end

			if arg_117_1.time_ >= 0 + var_120_1 and arg_117_1.time_ < 0 + var_120_1 + arg_120_0 and not isNil(arg_117_1.actors_["10023"]) and arg_117_1.var_.highlightMatValue10023 then
				arg_117_1.var_.highlightMatValue10023.color.r = 0.5
				arg_117_1.var_.highlightMatValue10023.color.g = 0.5
				arg_117_1.var_.highlightMatValue10023.color.b = 0.5
				arg_117_1.var_.highlightMatValue10023.color = arg_117_1.var_.highlightMatValue10023.color
			end

			local var_120_3 = arg_117_1.actors_["10017"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_3) then
				local var_120_4 = var_120_3:GetComponent("Image")

				if var_120_4 then
					arg_117_1.var_.highlightMatValue10017 = var_120_4
				end
			end

			local var_120_5 = 0.034

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_5 and not isNil(var_120_3) then
				if arg_117_1.var_.highlightMatValue10017 then
					local var_120_6 = Mathf.Lerp(0.5, 1, (arg_117_1.time_ - 0) / var_120_5)

					arg_117_1.var_.highlightMatValue10017.color.r = var_120_6
					arg_117_1.var_.highlightMatValue10017.color.g = var_120_6
					arg_117_1.var_.highlightMatValue10017.color.b = var_120_6
					arg_117_1.var_.highlightMatValue10017.color = arg_117_1.var_.highlightMatValue10017.color
				end
			end

			if arg_117_1.time_ >= 0 + var_120_5 and arg_117_1.time_ < 0 + var_120_5 + arg_120_0 and not isNil(var_120_3) and arg_117_1.var_.highlightMatValue10017 then
				var_120_3.transform:SetSiblingIndex(1)

				arg_117_1.var_.highlightMatValue10017.color.r = 1
				arg_117_1.var_.highlightMatValue10017.color.g = 1
				arg_117_1.var_.highlightMatValue10017.color.b = 1
				arg_117_1.var_.highlightMatValue10017.color = arg_117_1.var_.highlightMatValue10017.color
			end

			local var_120_7 = 0
			local var_120_8 = 0.5

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_7 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[255].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_9 = arg_117_1:GetWordFromCfg(114282029)
				local var_120_10 = arg_117_1:FormatText(var_120_9.content)

				arg_117_1.text_.text = var_120_10

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_12 = 20 <= 0 and var_120_8 or var_120_8 * (utf8.len(var_120_10) / 20)

				if (20 <= 0 and var_120_8 or var_120_8 * (utf8.len(var_120_10) / 20)) > 0 and var_120_8 < var_120_12 then
					arg_117_1.talkMaxDuration = var_120_12

					if var_120_12 + var_120_7 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_12 + var_120_7
					end
				end

				arg_117_1.text_.text = var_120_10
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114282", "114282029", "story_v_out_114282.awb") ~= 0 then
					local var_120_13 = manager.audio:GetVoiceLength("story_v_out_114282", "114282029", "story_v_out_114282.awb") / 1000

					if var_120_13 + var_120_7 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_13 + var_120_7
					end

					if var_120_9.prefab_name ~= "" and arg_117_1.actors_[var_120_9.prefab_name] ~= nil then
						local var_120_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_9.prefab_name].transform, "story_v_out_114282", "114282029", "story_v_out_114282.awb")

						arg_117_1:RecordAudio("114282029", var_120_14)
						arg_117_1:RecordAudio("114282029", var_120_14)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_114282", "114282029", "story_v_out_114282.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_114282", "114282029", "story_v_out_114282.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_15 = math.max(var_120_8, arg_117_1.talkMaxDuration)

			if var_120_7 <= arg_117_1.time_ and arg_117_1.time_ < var_120_7 + var_120_15 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_7) / var_120_15

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_7 + var_120_15 and arg_117_1.time_ < var_120_7 + var_120_15 + arg_120_0 then
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
			local var_124_0 = 0.25

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[255].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_1 = arg_121_1:GetWordFromCfg(114282030)
				local var_124_2 = arg_121_1:FormatText(var_124_1.content)

				arg_121_1.text_.text = var_124_2

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_4 = 10 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_2) / 10)

				if (10 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_2) / 10)) > 0 and var_124_0 < var_124_4 then
					arg_121_1.talkMaxDuration = var_124_4

					if var_124_4 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_4 + 0
					end
				end

				arg_121_1.text_.text = var_124_2
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114282", "114282030", "story_v_out_114282.awb") ~= 0 then
					local var_124_5 = manager.audio:GetVoiceLength("story_v_out_114282", "114282030", "story_v_out_114282.awb") / 1000

					if var_124_5 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_5 + 0
					end

					if var_124_1.prefab_name ~= "" and arg_121_1.actors_[var_124_1.prefab_name] ~= nil then
						local var_124_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_1.prefab_name].transform, "story_v_out_114282", "114282030", "story_v_out_114282.awb")

						arg_121_1:RecordAudio("114282030", var_124_6)
						arg_121_1:RecordAudio("114282030", var_124_6)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_114282", "114282030", "story_v_out_114282.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_114282", "114282030", "story_v_out_114282.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_7 = math.max(var_124_0, arg_121_1.talkMaxDuration)

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_7 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - 0) / var_124_7

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= 0 + var_124_7 and arg_121_1.time_ < 0 + var_124_7 + arg_124_0 then
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
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				local var_128_0 = arg_125_1.actors_["10017"]:GetComponent("Image")

				if var_128_0 then
					arg_125_1.var_.alphaMatValue10017 = var_128_0
					arg_125_1.var_.alphaOldValue10017 = var_128_0.color.a
				end

				arg_125_1.var_.alphaOldValue10017 = 1
			end

			local var_128_1 = 0.5

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_1 then
				if arg_125_1.var_.alphaMatValue10017 then
					arg_125_1.var_.alphaMatValue10017.color.a = Mathf.Lerp(arg_125_1.var_.alphaOldValue10017, 0, (arg_125_1.time_ - 0) / var_128_1)
					arg_125_1.var_.alphaMatValue10017.color = arg_125_1.var_.alphaMatValue10017.color
				end
			end

			if arg_125_1.time_ >= 0 + var_128_1 and arg_125_1.time_ < 0 + var_128_1 + arg_128_0 and arg_125_1.var_.alphaMatValue10017 then
				arg_125_1.var_.alphaMatValue10017.color.a = 0
				arg_125_1.var_.alphaMatValue10017.color = arg_125_1.var_.alphaMatValue10017.color
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				local var_128_2 = arg_125_1.actors_["10023"]:GetComponent("Image")

				if var_128_2 then
					arg_125_1.var_.alphaMatValue10023 = var_128_2
					arg_125_1.var_.alphaOldValue10023 = var_128_2.color.a
				end

				arg_125_1.var_.alphaOldValue10023 = 1
			end

			local var_128_3 = 0.5

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_3 then
				if arg_125_1.var_.alphaMatValue10023 then
					arg_125_1.var_.alphaMatValue10023.color.a = Mathf.Lerp(arg_125_1.var_.alphaOldValue10023, 0, (arg_125_1.time_ - 0) / var_128_3)
					arg_125_1.var_.alphaMatValue10023.color = arg_125_1.var_.alphaMatValue10023.color
				end
			end

			if arg_125_1.time_ >= 0 + var_128_3 and arg_125_1.time_ < 0 + var_128_3 + arg_128_0 and arg_125_1.var_.alphaMatValue10023 then
				arg_125_1.var_.alphaMatValue10023.color.a = 0
				arg_125_1.var_.alphaMatValue10023.color = arg_125_1.var_.alphaMatValue10023.color
			end

			local var_128_4 = 0
			local var_128_5 = 0.95

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_4 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_6 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(114282031).content)

				arg_125_1.text_.text = var_128_6

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_8 = 38 <= 0 and var_128_5 or var_128_5 * (utf8.len(var_128_6) / 38)

				if (38 <= 0 and var_128_5 or var_128_5 * (utf8.len(var_128_6) / 38)) > 0 and var_128_5 < var_128_8 then
					arg_125_1.talkMaxDuration = var_128_8

					if var_128_8 + var_128_4 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_8 + var_128_4
					end
				end

				arg_125_1.text_.text = var_128_6
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_9 = math.max(var_128_5, arg_125_1.talkMaxDuration)

			if var_128_4 <= arg_125_1.time_ and arg_125_1.time_ < var_128_4 + var_128_9 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_4) / var_128_9

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_4 + var_128_9 and arg_125_1.time_ < var_128_4 + var_128_9 + arg_128_0 then
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
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos10022 = arg_129_1.actors_["10022"].transform.localPosition
				arg_129_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_129_1:CheckSpriteTmpPos("10022", 2)

				for iter_132_0 = 0, arg_129_1.actors_["10022"].transform.childCount - 1 do
					local var_132_0 = arg_129_1.actors_["10022"].transform:GetChild(iter_132_0)

					if var_132_0.name == "split_6" or not string.find(var_132_0.name, "split") then
						var_132_0.gameObject:SetActive(true)
					else
						var_132_0.gameObject:SetActive(false)
					end
				end
			end

			local var_132_1 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_1 then
				arg_129_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos10022, Vector3.New(-390, -350, -180), (arg_129_1.time_ - 0) / var_132_1)
			end

			if arg_129_1.time_ >= 0 + var_132_1 and arg_129_1.time_ < 0 + var_132_1 + arg_132_0 then
				arg_129_1.actors_["10022"].transform.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_132_2 = arg_129_1.actors_["10022"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_2) and arg_129_1.var_.actorSpriteComps10022 == nil then
				arg_129_1.var_.actorSpriteComps10022 = var_132_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_132_3 = 0.034

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_3 and not isNil(var_132_2) then
				if arg_129_1.var_.actorSpriteComps10022 then
					for iter_132_1, iter_132_2 in pairs(arg_129_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_132_2 then
							if arg_129_1.isInRecall_ then
								iter_132_2.color = Color.New(Mathf.Lerp(iter_132_2.color.r, arg_129_1.hightColor1.r, (arg_129_1.time_ - 0) / var_132_3), Mathf.Lerp(iter_132_2.color.g, arg_129_1.hightColor1.g, (arg_129_1.time_ - 0) / var_132_3), (Mathf.Lerp(iter_132_2.color.b, arg_129_1.hightColor1.b, (arg_129_1.time_ - 0) / var_132_3)))
							else
								local var_132_4 = Mathf.Lerp(iter_132_2.color.r, 1, (arg_129_1.time_ - 0) / var_132_3)

								iter_132_2.color = Color.New(var_132_4, var_132_4, var_132_4)
							end
						end
					end
				end
			end

			if arg_129_1.time_ >= 0 + var_132_3 and arg_129_1.time_ < 0 + var_132_3 + arg_132_0 and not isNil(var_132_2) and arg_129_1.var_.actorSpriteComps10022 then
				for iter_132_3, iter_132_4 in pairs(arg_129_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_132_4 then
						iter_132_4.color = arg_129_1.isInRecall_ and (arg_129_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_129_1.var_.actorSpriteComps10022 = nil
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				local var_132_5 = arg_129_1.actors_["10022"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_132_5 then
					arg_129_1.var_.alphaOldValue10022 = var_132_5.alpha
					arg_129_1.var_.characterEffect10022 = var_132_5
				end

				arg_129_1.var_.alphaOldValue10022 = 0
			end

			local var_132_6 = 0.5

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_6 then
				if arg_129_1.var_.characterEffect10022 then
					arg_129_1.var_.characterEffect10022.alpha = Mathf.Lerp(arg_129_1.var_.alphaOldValue10022, 1, (arg_129_1.time_ - 0) / var_132_6)
				end
			end

			if arg_129_1.time_ >= 0 + var_132_6 and arg_129_1.time_ < 0 + var_132_6 + arg_132_0 and arg_129_1.var_.characterEffect10022 then
				arg_129_1.var_.characterEffect10022.alpha = 1
			end

			local var_132_7 = 0
			local var_132_8 = 0.1

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_7 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[235].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_9 = arg_129_1:GetWordFromCfg(114282032)
				local var_132_10 = arg_129_1:FormatText(var_132_9.content)

				arg_129_1.text_.text = var_132_10

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_12 = 4 <= 0 and var_132_8 or var_132_8 * (utf8.len(var_132_10) / 4)

				if (4 <= 0 and var_132_8 or var_132_8 * (utf8.len(var_132_10) / 4)) > 0 and var_132_8 < var_132_12 then
					arg_129_1.talkMaxDuration = var_132_12

					if var_132_12 + var_132_7 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_12 + var_132_7
					end
				end

				arg_129_1.text_.text = var_132_10
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114282", "114282032", "story_v_out_114282.awb") ~= 0 then
					local var_132_13 = manager.audio:GetVoiceLength("story_v_out_114282", "114282032", "story_v_out_114282.awb") / 1000

					if var_132_13 + var_132_7 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_13 + var_132_7
					end

					if var_132_9.prefab_name ~= "" and arg_129_1.actors_[var_132_9.prefab_name] ~= nil then
						local var_132_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_9.prefab_name].transform, "story_v_out_114282", "114282032", "story_v_out_114282.awb")

						arg_129_1:RecordAudio("114282032", var_132_14)
						arg_129_1:RecordAudio("114282032", var_132_14)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_114282", "114282032", "story_v_out_114282.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_114282", "114282032", "story_v_out_114282.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_15 = math.max(var_132_8, arg_129_1.talkMaxDuration)

			if var_132_7 <= arg_129_1.time_ and arg_129_1.time_ < var_132_7 + var_132_15 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_7) / var_132_15

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_7 + var_132_15 and arg_129_1.time_ < var_132_7 + var_132_15 + arg_132_0 then
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
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos10017 = arg_133_1.actors_["10017"].transform.localPosition
				arg_133_1.actors_["10017"].transform.localScale = Vector3.New(1, 1, 1)

				arg_133_1:CheckSpriteTmpPos("10017", 4)
			end

			local var_136_0 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 then
				arg_133_1.actors_["10017"].transform.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos10017, Vector3.New(390, -350, -180), (arg_133_1.time_ - 0) / var_136_0)
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 then
				arg_133_1.actors_["10017"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_136_1 = arg_133_1.actors_["10022"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.actorSpriteComps10022 == nil then
				arg_133_1.var_.actorSpriteComps10022 = var_136_1:GetComponentsInChildren(typeof(Image), true)
			end

			local var_136_2 = 0.034

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_2 and not isNil(var_136_1) then
				if arg_133_1.var_.actorSpriteComps10022 then
					for iter_136_0, iter_136_1 in pairs(arg_133_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_136_1 then
							if arg_133_1.isInRecall_ then
								iter_136_1.color = Color.New(Mathf.Lerp(iter_136_1.color.r, arg_133_1.hightColor2.r, (arg_133_1.time_ - 0) / var_136_2), Mathf.Lerp(iter_136_1.color.g, arg_133_1.hightColor2.g, (arg_133_1.time_ - 0) / var_136_2), (Mathf.Lerp(iter_136_1.color.b, arg_133_1.hightColor2.b, (arg_133_1.time_ - 0) / var_136_2)))
							else
								local var_136_3 = Mathf.Lerp(iter_136_1.color.r, 0.5, (arg_133_1.time_ - 0) / var_136_2)

								iter_136_1.color = Color.New(var_136_3, var_136_3, var_136_3)
							end
						end
					end
				end
			end

			if arg_133_1.time_ >= 0 + var_136_2 and arg_133_1.time_ < 0 + var_136_2 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.actorSpriteComps10022 then
				for iter_136_2, iter_136_3 in pairs(arg_133_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_136_3 then
						iter_136_3.color = arg_133_1.isInRecall_ and (arg_133_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_133_1.var_.actorSpriteComps10022 = nil
			end

			local var_136_4 = arg_133_1.actors_["10017"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_4) then
				local var_136_5 = var_136_4:GetComponent("Image")

				if var_136_5 then
					arg_133_1.var_.highlightMatValue10017 = var_136_5
				end
			end

			local var_136_6 = 0.034

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_6 and not isNil(var_136_4) then
				if arg_133_1.var_.highlightMatValue10017 then
					local var_136_7 = Mathf.Lerp(0.5, 1, (arg_133_1.time_ - 0) / var_136_6)

					arg_133_1.var_.highlightMatValue10017.color.r = var_136_7
					arg_133_1.var_.highlightMatValue10017.color.g = var_136_7
					arg_133_1.var_.highlightMatValue10017.color.b = var_136_7
					arg_133_1.var_.highlightMatValue10017.color = arg_133_1.var_.highlightMatValue10017.color
				end
			end

			if arg_133_1.time_ >= 0 + var_136_6 and arg_133_1.time_ < 0 + var_136_6 + arg_136_0 and not isNil(var_136_4) and arg_133_1.var_.highlightMatValue10017 then
				var_136_4.transform:SetSiblingIndex(1)

				arg_133_1.var_.highlightMatValue10017.color.r = 1
				arg_133_1.var_.highlightMatValue10017.color.g = 1
				arg_133_1.var_.highlightMatValue10017.color.b = 1
				arg_133_1.var_.highlightMatValue10017.color = arg_133_1.var_.highlightMatValue10017.color
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				local var_136_8 = arg_133_1.actors_["10017"]:GetComponent("Image")

				if var_136_8 then
					arg_133_1.var_.alphaMatValue10017 = var_136_8
					arg_133_1.var_.alphaOldValue10017 = var_136_8.color.a
				end

				arg_133_1.var_.alphaOldValue10017 = 0
			end

			local var_136_9 = 0.5

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_9 then
				if arg_133_1.var_.alphaMatValue10017 then
					arg_133_1.var_.alphaMatValue10017.color.a = Mathf.Lerp(arg_133_1.var_.alphaOldValue10017, 1, (arg_133_1.time_ - 0) / var_136_9)
					arg_133_1.var_.alphaMatValue10017.color = arg_133_1.var_.alphaMatValue10017.color
				end
			end

			if arg_133_1.time_ >= 0 + var_136_9 and arg_133_1.time_ < 0 + var_136_9 + arg_136_0 and arg_133_1.var_.alphaMatValue10017 then
				arg_133_1.var_.alphaMatValue10017.color.a = 1
				arg_133_1.var_.alphaMatValue10017.color = arg_133_1.var_.alphaMatValue10017.color
			end

			local var_136_10 = 0
			local var_136_11 = 0.125

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_10 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[255].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_12 = arg_133_1:GetWordFromCfg(114282033)
				local var_136_13 = arg_133_1:FormatText(var_136_12.content)

				arg_133_1.text_.text = var_136_13

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_15 = 5 <= 0 and var_136_11 or var_136_11 * (utf8.len(var_136_13) / 5)

				if (5 <= 0 and var_136_11 or var_136_11 * (utf8.len(var_136_13) / 5)) > 0 and var_136_11 < var_136_15 then
					arg_133_1.talkMaxDuration = var_136_15

					if var_136_15 + var_136_10 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_15 + var_136_10
					end
				end

				arg_133_1.text_.text = var_136_13
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114282", "114282033", "story_v_out_114282.awb") ~= 0 then
					local var_136_16 = manager.audio:GetVoiceLength("story_v_out_114282", "114282033", "story_v_out_114282.awb") / 1000

					if var_136_16 + var_136_10 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_16 + var_136_10
					end

					if var_136_12.prefab_name ~= "" and arg_133_1.actors_[var_136_12.prefab_name] ~= nil then
						local var_136_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_12.prefab_name].transform, "story_v_out_114282", "114282033", "story_v_out_114282.awb")

						arg_133_1:RecordAudio("114282033", var_136_17)
						arg_133_1:RecordAudio("114282033", var_136_17)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_114282", "114282033", "story_v_out_114282.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_114282", "114282033", "story_v_out_114282.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_18 = math.max(var_136_11, arg_133_1.talkMaxDuration)

			if var_136_10 <= arg_133_1.time_ and arg_133_1.time_ < var_136_10 + var_136_18 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_10) / var_136_18

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_10 + var_136_18 and arg_133_1.time_ < var_136_10 + var_136_18 + arg_136_0 then
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
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos10022 = arg_137_1.actors_["10022"].transform.localPosition
				arg_137_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_137_1:CheckSpriteTmpPos("10022", 7)

				for iter_140_0 = 0, arg_137_1.actors_["10022"].transform.childCount - 1 do
					local var_140_0 = arg_137_1.actors_["10022"].transform:GetChild(iter_140_0)

					if var_140_0.name == "split_6" or not string.find(var_140_0.name, "split") then
						var_140_0.gameObject:SetActive(true)
					else
						var_140_0.gameObject:SetActive(false)
					end
				end
			end

			local var_140_1 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_1 then
				arg_137_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos10022, Vector3.New(0, -2000, -180), (arg_137_1.time_ - 0) / var_140_1)
			end

			if arg_137_1.time_ >= 0 + var_140_1 and arg_137_1.time_ < 0 + var_140_1 + arg_140_0 then
				arg_137_1.actors_["10022"].transform.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_140_2 = arg_137_1.actors_["10017"].transform

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos10017 = var_140_2.localPosition
				var_140_2.localScale = Vector3.New(1, 1, 1)

				arg_137_1:CheckSpriteTmpPos("10017", 7)
			end

			local var_140_3 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_3 then
				var_140_2.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos10017, Vector3.New(0, -2000, 500), (arg_137_1.time_ - 0) / var_140_3)
			end

			if arg_137_1.time_ >= 0 + var_140_3 and arg_137_1.time_ < 0 + var_140_3 + arg_140_0 then
				var_140_2.localPosition = Vector3.New(0, -2000, 500)
			end

			local var_140_4 = 0
			local var_140_5 = 0.7

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_4 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[208].name)

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

				local var_140_6 = arg_137_1:GetWordFromCfg(114282034)
				local var_140_7 = arg_137_1:FormatText(var_140_6.content)

				arg_137_1.text_.text = var_140_7

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_9 = 28 <= 0 and var_140_5 or var_140_5 * (utf8.len(var_140_7) / 28)

				if (28 <= 0 and var_140_5 or var_140_5 * (utf8.len(var_140_7) / 28)) > 0 and var_140_5 < var_140_9 then
					arg_137_1.talkMaxDuration = var_140_9

					if var_140_9 + var_140_4 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_9 + var_140_4
					end
				end

				arg_137_1.text_.text = var_140_7
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114282", "114282034", "story_v_out_114282.awb") ~= 0 then
					local var_140_10 = manager.audio:GetVoiceLength("story_v_out_114282", "114282034", "story_v_out_114282.awb") / 1000

					if var_140_10 + var_140_4 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_10 + var_140_4
					end

					if var_140_6.prefab_name ~= "" and arg_137_1.actors_[var_140_6.prefab_name] ~= nil then
						local var_140_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_6.prefab_name].transform, "story_v_out_114282", "114282034", "story_v_out_114282.awb")

						arg_137_1:RecordAudio("114282034", var_140_11)
						arg_137_1:RecordAudio("114282034", var_140_11)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_114282", "114282034", "story_v_out_114282.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_114282", "114282034", "story_v_out_114282.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_12 = math.max(var_140_5, arg_137_1.talkMaxDuration)

			if var_140_4 <= arg_137_1.time_ and arg_137_1.time_ < var_140_4 + var_140_12 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_4) / var_140_12

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_4 + var_140_12 and arg_137_1.time_ < var_140_4 + var_140_12 + arg_140_0 then
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
			local var_144_0 = 1.45

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, false)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_1 = arg_141_1:FormatText(arg_141_1:GetWordFromCfg(114282035).content)

				arg_141_1.text_.text = var_144_1

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_3 = 58 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_1) / 58)

				if (58 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_1) / 58)) > 0 and var_144_0 < var_144_3 then
					arg_141_1.talkMaxDuration = var_144_3

					if var_144_3 + 0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_3 + 0
					end
				end

				arg_141_1.text_.text = var_144_1
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_4 = math.max(var_144_0, arg_141_1.talkMaxDuration)

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_4 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - 0) / var_144_4

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= 0 + var_144_4 and arg_141_1.time_ < 0 + var_144_4 + arg_144_0 then
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
			local var_148_0 = 1.4

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_1 = arg_145_1:FormatText(arg_145_1:GetWordFromCfg(114282036).content)

				arg_145_1.text_.text = var_148_1

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_3 = 56 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_1) / 56)

				if (56 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_1) / 56)) > 0 and var_148_0 < var_148_3 then
					arg_145_1.talkMaxDuration = var_148_3

					if var_148_3 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_3 + 0
					end
				end

				arg_145_1.text_.text = var_148_1
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_4 = math.max(var_148_0, arg_145_1.talkMaxDuration)

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_4 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - 0) / var_148_4

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= 0 + var_148_4 and arg_145_1.time_ < 0 + var_148_4 + arg_148_0 then
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
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				local var_152_0 = arg_149_1.actors_["10022"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_152_0 then
					arg_149_1.var_.alphaOldValue10022 = var_152_0.alpha
					arg_149_1.var_.characterEffect10022 = var_152_0
				end

				arg_149_1.var_.alphaOldValue10022 = 0
			end

			local var_152_1 = 0.5

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_1 then
				if arg_149_1.var_.characterEffect10022 then
					arg_149_1.var_.characterEffect10022.alpha = Mathf.Lerp(arg_149_1.var_.alphaOldValue10022, 1, (arg_149_1.time_ - 0) / var_152_1)
				end
			end

			if arg_149_1.time_ >= 0 + var_152_1 and arg_149_1.time_ < 0 + var_152_1 + arg_152_0 and arg_149_1.var_.characterEffect10022 then
				arg_149_1.var_.characterEffect10022.alpha = 1
			end

			local var_152_2 = arg_149_1.actors_["10022"].transform

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.var_.moveOldPos10022 = var_152_2.localPosition
				var_152_2.localScale = Vector3.New(1, 1, 1)

				arg_149_1:CheckSpriteTmpPos("10022", 3)

				for iter_152_0 = 0, var_152_2.childCount - 1 do
					local var_152_3 = var_152_2:GetChild(iter_152_0)

					if var_152_3.name == "split_2" or not string.find(var_152_3.name, "split") then
						var_152_3.gameObject:SetActive(true)
					else
						var_152_3.gameObject:SetActive(false)
					end
				end
			end

			local var_152_4 = 0.001

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_4 then
				var_152_2.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos10022, Vector3.New(0, -350, -180), (arg_149_1.time_ - 0) / var_152_4)
			end

			if arg_149_1.time_ >= 0 + var_152_4 and arg_149_1.time_ < 0 + var_152_4 + arg_152_0 then
				var_152_2.localPosition = Vector3.New(0, -350, -180)
			end

			local var_152_5 = arg_149_1.actors_["10022"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_5) and arg_149_1.var_.actorSpriteComps10022 == nil then
				arg_149_1.var_.actorSpriteComps10022 = var_152_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_6 = 0.034

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_6 and not isNil(var_152_5) then
				if arg_149_1.var_.actorSpriteComps10022 then
					for iter_152_1, iter_152_2 in pairs(arg_149_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_152_2 then
							if arg_149_1.isInRecall_ then
								iter_152_2.color = Color.New(Mathf.Lerp(iter_152_2.color.r, arg_149_1.hightColor1.r, (arg_149_1.time_ - 0) / var_152_6), Mathf.Lerp(iter_152_2.color.g, arg_149_1.hightColor1.g, (arg_149_1.time_ - 0) / var_152_6), (Mathf.Lerp(iter_152_2.color.b, arg_149_1.hightColor1.b, (arg_149_1.time_ - 0) / var_152_6)))
							else
								local var_152_7 = Mathf.Lerp(iter_152_2.color.r, 1, (arg_149_1.time_ - 0) / var_152_6)

								iter_152_2.color = Color.New(var_152_7, var_152_7, var_152_7)
							end
						end
					end
				end
			end

			if arg_149_1.time_ >= 0 + var_152_6 and arg_149_1.time_ < 0 + var_152_6 + arg_152_0 and not isNil(var_152_5) and arg_149_1.var_.actorSpriteComps10022 then
				for iter_152_3, iter_152_4 in pairs(arg_149_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_152_4 then
						iter_152_4.color = arg_149_1.isInRecall_ and (arg_149_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_149_1.var_.actorSpriteComps10022 = nil
			end

			local var_152_8 = 0
			local var_152_9 = 0.425

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_8 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[235].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_10 = arg_149_1:GetWordFromCfg(114282037)
				local var_152_11 = arg_149_1:FormatText(var_152_10.content)

				arg_149_1.text_.text = var_152_11

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_13 = 17 <= 0 and var_152_9 or var_152_9 * (utf8.len(var_152_11) / 17)

				if (17 <= 0 and var_152_9 or var_152_9 * (utf8.len(var_152_11) / 17)) > 0 and var_152_9 < var_152_13 then
					arg_149_1.talkMaxDuration = var_152_13

					if var_152_13 + var_152_8 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_13 + var_152_8
					end
				end

				arg_149_1.text_.text = var_152_11
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114282", "114282037", "story_v_out_114282.awb") ~= 0 then
					local var_152_14 = manager.audio:GetVoiceLength("story_v_out_114282", "114282037", "story_v_out_114282.awb") / 1000

					if var_152_14 + var_152_8 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_14 + var_152_8
					end

					if var_152_10.prefab_name ~= "" and arg_149_1.actors_[var_152_10.prefab_name] ~= nil then
						local var_152_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_10.prefab_name].transform, "story_v_out_114282", "114282037", "story_v_out_114282.awb")

						arg_149_1:RecordAudio("114282037", var_152_15)
						arg_149_1:RecordAudio("114282037", var_152_15)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_114282", "114282037", "story_v_out_114282.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_114282", "114282037", "story_v_out_114282.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_16 = math.max(var_152_9, arg_149_1.talkMaxDuration)

			if var_152_8 <= arg_149_1.time_ and arg_149_1.time_ < var_152_8 + var_152_16 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_8) / var_152_16

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_8 + var_152_16 and arg_149_1.time_ < var_152_8 + var_152_16 + arg_152_0 then
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
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				local var_156_0 = arg_153_1.actors_["10022"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_156_0 then
					arg_153_1.var_.alphaOldValue10022 = var_156_0.alpha
					arg_153_1.var_.characterEffect10022 = var_156_0
				end

				arg_153_1.var_.alphaOldValue10022 = 1
			end

			local var_156_1 = 0.5

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_1 then
				if arg_153_1.var_.characterEffect10022 then
					arg_153_1.var_.characterEffect10022.alpha = Mathf.Lerp(arg_153_1.var_.alphaOldValue10022, 0, (arg_153_1.time_ - 0) / var_156_1)
				end
			end

			if arg_153_1.time_ >= 0 + var_156_1 and arg_153_1.time_ < 0 + var_156_1 + arg_156_0 and arg_153_1.var_.characterEffect10022 then
				arg_153_1.var_.characterEffect10022.alpha = 0
			end

			local var_156_2 = 0
			local var_156_3 = 1.575

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_2 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, false)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_4 = arg_153_1:FormatText(arg_153_1:GetWordFromCfg(114282038).content)

				arg_153_1.text_.text = var_156_4

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_6 = 62 <= 0 and var_156_3 or var_156_3 * (utf8.len(var_156_4) / 62)

				if (62 <= 0 and var_156_3 or var_156_3 * (utf8.len(var_156_4) / 62)) > 0 and var_156_3 < var_156_6 then
					arg_153_1.talkMaxDuration = var_156_6

					if var_156_6 + var_156_2 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_6 + var_156_2
					end
				end

				arg_153_1.text_.text = var_156_4
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_7 = math.max(var_156_3, arg_153_1.talkMaxDuration)

			if var_156_2 <= arg_153_1.time_ and arg_153_1.time_ < var_156_2 + var_156_7 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_2) / var_156_7

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_2 + var_156_7 and arg_153_1.time_ < var_156_2 + var_156_7 + arg_156_0 then
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
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				local var_160_0 = arg_157_1.actors_["10017"]:GetComponent("Image")

				if var_160_0 then
					arg_157_1.var_.alphaMatValue10017 = var_160_0
					arg_157_1.var_.alphaOldValue10017 = var_160_0.color.a
				end

				arg_157_1.var_.alphaOldValue10017 = 0
			end

			local var_160_1 = 0.5

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_1 then
				if arg_157_1.var_.alphaMatValue10017 then
					arg_157_1.var_.alphaMatValue10017.color.a = Mathf.Lerp(arg_157_1.var_.alphaOldValue10017, 1, (arg_157_1.time_ - 0) / var_160_1)
					arg_157_1.var_.alphaMatValue10017.color = arg_157_1.var_.alphaMatValue10017.color
				end
			end

			if arg_157_1.time_ >= 0 + var_160_1 and arg_157_1.time_ < 0 + var_160_1 + arg_160_0 and arg_157_1.var_.alphaMatValue10017 then
				arg_157_1.var_.alphaMatValue10017.color.a = 1
				arg_157_1.var_.alphaMatValue10017.color = arg_157_1.var_.alphaMatValue10017.color
			end

			local var_160_2 = arg_157_1.actors_["10017"].transform

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos10017 = var_160_2.localPosition
				var_160_2.localScale = Vector3.New(1, 1, 1)

				arg_157_1:CheckSpriteTmpPos("10017", 2)
			end

			local var_160_3 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_3 then
				var_160_2.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos10017, Vector3.New(-390, -350, -180), (arg_157_1.time_ - 0) / var_160_3)
			end

			if arg_157_1.time_ >= 0 + var_160_3 and arg_157_1.time_ < 0 + var_160_3 + arg_160_0 then
				var_160_2.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_160_4 = arg_157_1.actors_["10017"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_4) then
				local var_160_5 = var_160_4:GetComponent("Image")

				if var_160_5 then
					arg_157_1.var_.highlightMatValue10017 = var_160_5
				end
			end

			local var_160_6 = 0.034

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_6 and not isNil(var_160_4) then
				if arg_157_1.var_.highlightMatValue10017 then
					local var_160_7 = Mathf.Lerp(0.5, 1, (arg_157_1.time_ - 0) / var_160_6)

					arg_157_1.var_.highlightMatValue10017.color.r = var_160_7
					arg_157_1.var_.highlightMatValue10017.color.g = var_160_7
					arg_157_1.var_.highlightMatValue10017.color.b = var_160_7
					arg_157_1.var_.highlightMatValue10017.color = arg_157_1.var_.highlightMatValue10017.color
				end
			end

			if arg_157_1.time_ >= 0 + var_160_6 and arg_157_1.time_ < 0 + var_160_6 + arg_160_0 and not isNil(var_160_4) and arg_157_1.var_.highlightMatValue10017 then
				var_160_4.transform:SetSiblingIndex(1)

				arg_157_1.var_.highlightMatValue10017.color.r = 1
				arg_157_1.var_.highlightMatValue10017.color.g = 1
				arg_157_1.var_.highlightMatValue10017.color.b = 1
				arg_157_1.var_.highlightMatValue10017.color = arg_157_1.var_.highlightMatValue10017.color
			end

			local var_160_8 = 0
			local var_160_9 = 1.125

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_8 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[255].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_10 = arg_157_1:GetWordFromCfg(114282039)
				local var_160_11 = arg_157_1:FormatText(var_160_10.content)

				arg_157_1.text_.text = var_160_11

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_13 = 44 <= 0 and var_160_9 or var_160_9 * (utf8.len(var_160_11) / 44)

				if (44 <= 0 and var_160_9 or var_160_9 * (utf8.len(var_160_11) / 44)) > 0 and var_160_9 < var_160_13 then
					arg_157_1.talkMaxDuration = var_160_13

					if var_160_13 + var_160_8 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_13 + var_160_8
					end
				end

				arg_157_1.text_.text = var_160_11
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114282", "114282039", "story_v_out_114282.awb") ~= 0 then
					local var_160_14 = manager.audio:GetVoiceLength("story_v_out_114282", "114282039", "story_v_out_114282.awb") / 1000

					if var_160_14 + var_160_8 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_14 + var_160_8
					end

					if var_160_10.prefab_name ~= "" and arg_157_1.actors_[var_160_10.prefab_name] ~= nil then
						local var_160_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_10.prefab_name].transform, "story_v_out_114282", "114282039", "story_v_out_114282.awb")

						arg_157_1:RecordAudio("114282039", var_160_15)
						arg_157_1:RecordAudio("114282039", var_160_15)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_114282", "114282039", "story_v_out_114282.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_114282", "114282039", "story_v_out_114282.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_16 = math.max(var_160_9, arg_157_1.talkMaxDuration)

			if var_160_8 <= arg_157_1.time_ and arg_157_1.time_ < var_160_8 + var_160_16 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_8) / var_160_16

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_8 + var_160_16 and arg_157_1.time_ < var_160_8 + var_160_16 + arg_160_0 then
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
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(arg_161_1.actors_["10017"]) then
				local var_164_0 = arg_161_1.actors_["10017"]:GetComponent("Image")

				if var_164_0 then
					arg_161_1.var_.highlightMatValue10017 = var_164_0
				end
			end

			local var_164_1 = 0.034

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_1 and not isNil(arg_161_1.actors_["10017"]) then
				if arg_161_1.var_.highlightMatValue10017 then
					local var_164_2 = Mathf.Lerp(1, 0.5, (arg_161_1.time_ - 0) / var_164_1)

					arg_161_1.var_.highlightMatValue10017.color.r = var_164_2
					arg_161_1.var_.highlightMatValue10017.color.g = var_164_2
					arg_161_1.var_.highlightMatValue10017.color.b = var_164_2
					arg_161_1.var_.highlightMatValue10017.color = arg_161_1.var_.highlightMatValue10017.color
				end
			end

			if arg_161_1.time_ >= 0 + var_164_1 and arg_161_1.time_ < 0 + var_164_1 + arg_164_0 and not isNil(arg_161_1.actors_["10017"]) and arg_161_1.var_.highlightMatValue10017 then
				arg_161_1.var_.highlightMatValue10017.color.r = 0.5
				arg_161_1.var_.highlightMatValue10017.color.g = 0.5
				arg_161_1.var_.highlightMatValue10017.color.b = 0.5
				arg_161_1.var_.highlightMatValue10017.color = arg_161_1.var_.highlightMatValue10017.color
			end

			local var_164_3 = 0
			local var_164_4 = 1.05

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_3 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, false)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_5 = arg_161_1:FormatText(arg_161_1:GetWordFromCfg(114282040).content)

				arg_161_1.text_.text = var_164_5

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_7 = 42 <= 0 and var_164_4 or var_164_4 * (utf8.len(var_164_5) / 42)

				if (42 <= 0 and var_164_4 or var_164_4 * (utf8.len(var_164_5) / 42)) > 0 and var_164_4 < var_164_7 then
					arg_161_1.talkMaxDuration = var_164_7

					if var_164_7 + var_164_3 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_7 + var_164_3
					end
				end

				arg_161_1.text_.text = var_164_5
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_8 = math.max(var_164_4, arg_161_1.talkMaxDuration)

			if var_164_3 <= arg_161_1.time_ and arg_161_1.time_ < var_164_3 + var_164_8 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_3) / var_164_8

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_3 + var_164_8 and arg_161_1.time_ < var_164_3 + var_164_8 + arg_164_0 then
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
			if arg_165_1.actors_["10015"] == nil then
				local var_168_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10015")

				if not isNil(var_168_0) then
					local var_168_1 = Object.Instantiate(var_168_0, arg_165_1.canvasGo_.transform)

					var_168_1.transform:SetSiblingIndex(1)

					var_168_1.name = "10015"
					var_168_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_165_1.actors_["10015"] = var_168_1

					if arg_165_1.isInRecall_ then
						for iter_168_0, iter_168_1 in ipairs((var_168_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_168_1.color = arg_165_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				local var_168_2 = arg_165_1.actors_["10015"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_168_2 then
					arg_165_1.var_.alphaOldValue10015 = var_168_2.alpha
					arg_165_1.var_.characterEffect10015 = var_168_2
				end

				arg_165_1.var_.alphaOldValue10015 = 0
			end

			local var_168_3 = 0.5

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_3 then
				if arg_165_1.var_.characterEffect10015 then
					arg_165_1.var_.characterEffect10015.alpha = Mathf.Lerp(arg_165_1.var_.alphaOldValue10015, 1, (arg_165_1.time_ - 0) / var_168_3)
				end
			end

			if arg_165_1.time_ >= 0 + var_168_3 and arg_165_1.time_ < 0 + var_168_3 + arg_168_0 and arg_165_1.var_.characterEffect10015 then
				arg_165_1.var_.characterEffect10015.alpha = 1
			end

			local var_168_4 = arg_165_1.actors_["10015"].transform

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos10015 = var_168_4.localPosition
				var_168_4.localScale = Vector3.New(1, 1, 1)

				arg_165_1:CheckSpriteTmpPos("10015", 4)

				for iter_168_2 = 0, var_168_4.childCount - 1 do
					local var_168_5 = var_168_4:GetChild(iter_168_2)

					if var_168_5.name == "split_1" or not string.find(var_168_5.name, "split") then
						var_168_5.gameObject:SetActive(true)
					else
						var_168_5.gameObject:SetActive(false)
					end
				end
			end

			local var_168_6 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_6 then
				var_168_4.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos10015, Vector3.New(390, -350, -180), (arg_165_1.time_ - 0) / var_168_6)
			end

			if arg_165_1.time_ >= 0 + var_168_6 and arg_165_1.time_ < 0 + var_168_6 + arg_168_0 then
				var_168_4.localPosition = Vector3.New(390, -350, -180)
			end

			local var_168_7 = arg_165_1.actors_["10015"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_7) and arg_165_1.var_.actorSpriteComps10015 == nil then
				arg_165_1.var_.actorSpriteComps10015 = var_168_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_168_8 = 0.034

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_8 and not isNil(var_168_7) then
				if arg_165_1.var_.actorSpriteComps10015 then
					for iter_168_3, iter_168_4 in pairs(arg_165_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_168_4 then
							if arg_165_1.isInRecall_ then
								iter_168_4.color = Color.New(Mathf.Lerp(iter_168_4.color.r, arg_165_1.hightColor1.r, (arg_165_1.time_ - 0) / var_168_8), Mathf.Lerp(iter_168_4.color.g, arg_165_1.hightColor1.g, (arg_165_1.time_ - 0) / var_168_8), (Mathf.Lerp(iter_168_4.color.b, arg_165_1.hightColor1.b, (arg_165_1.time_ - 0) / var_168_8)))
							else
								local var_168_9 = Mathf.Lerp(iter_168_4.color.r, 1, (arg_165_1.time_ - 0) / var_168_8)

								iter_168_4.color = Color.New(var_168_9, var_168_9, var_168_9)
							end
						end
					end
				end
			end

			if arg_165_1.time_ >= 0 + var_168_8 and arg_165_1.time_ < 0 + var_168_8 + arg_168_0 and not isNil(var_168_7) and arg_165_1.var_.actorSpriteComps10015 then
				for iter_168_5, iter_168_6 in pairs(arg_165_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_168_6 then
						iter_168_6.color = arg_165_1.isInRecall_ and (arg_165_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_165_1.var_.actorSpriteComps10015 = nil
			end

			local var_168_10 = 0
			local var_168_11 = 0.4

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_10 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_12 = arg_165_1:GetWordFromCfg(114282041)
				local var_168_13 = arg_165_1:FormatText(var_168_12.content)

				arg_165_1.text_.text = var_168_13

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_15 = 16 <= 0 and var_168_11 or var_168_11 * (utf8.len(var_168_13) / 16)

				if (16 <= 0 and var_168_11 or var_168_11 * (utf8.len(var_168_13) / 16)) > 0 and var_168_11 < var_168_15 then
					arg_165_1.talkMaxDuration = var_168_15

					if var_168_15 + var_168_10 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_15 + var_168_10
					end
				end

				arg_165_1.text_.text = var_168_13
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114282", "114282041", "story_v_out_114282.awb") ~= 0 then
					local var_168_16 = manager.audio:GetVoiceLength("story_v_out_114282", "114282041", "story_v_out_114282.awb") / 1000

					if var_168_16 + var_168_10 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_16 + var_168_10
					end

					if var_168_12.prefab_name ~= "" and arg_165_1.actors_[var_168_12.prefab_name] ~= nil then
						local var_168_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_12.prefab_name].transform, "story_v_out_114282", "114282041", "story_v_out_114282.awb")

						arg_165_1:RecordAudio("114282041", var_168_17)
						arg_165_1:RecordAudio("114282041", var_168_17)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_114282", "114282041", "story_v_out_114282.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_114282", "114282041", "story_v_out_114282.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_18 = math.max(var_168_11, arg_165_1.talkMaxDuration)

			if var_168_10 <= arg_165_1.time_ and arg_165_1.time_ < var_168_10 + var_168_18 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_10) / var_168_18

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_10 + var_168_18 and arg_165_1.time_ < var_168_10 + var_168_18 + arg_168_0 then
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
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(arg_169_1.actors_["10017"]) then
				local var_172_0 = arg_169_1.actors_["10017"]:GetComponent("Image")

				if var_172_0 then
					arg_169_1.var_.highlightMatValue10017 = var_172_0
				end
			end

			local var_172_1 = 0.034

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_1 and not isNil(arg_169_1.actors_["10017"]) then
				if arg_169_1.var_.highlightMatValue10017 then
					local var_172_2 = Mathf.Lerp(0.5, 1, (arg_169_1.time_ - 0) / var_172_1)

					arg_169_1.var_.highlightMatValue10017.color.r = var_172_2
					arg_169_1.var_.highlightMatValue10017.color.g = var_172_2
					arg_169_1.var_.highlightMatValue10017.color.b = var_172_2
					arg_169_1.var_.highlightMatValue10017.color = arg_169_1.var_.highlightMatValue10017.color
				end
			end

			if arg_169_1.time_ >= 0 + var_172_1 and arg_169_1.time_ < 0 + var_172_1 + arg_172_0 and not isNil(arg_169_1.actors_["10017"]) and arg_169_1.var_.highlightMatValue10017 then
				arg_169_1.actors_["10017"].transform:SetSiblingIndex(1)

				arg_169_1.var_.highlightMatValue10017.color.r = 1
				arg_169_1.var_.highlightMatValue10017.color.g = 1
				arg_169_1.var_.highlightMatValue10017.color.b = 1
				arg_169_1.var_.highlightMatValue10017.color = arg_169_1.var_.highlightMatValue10017.color
			end

			local var_172_3 = arg_169_1.actors_["10015"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_3) and arg_169_1.var_.actorSpriteComps10015 == nil then
				arg_169_1.var_.actorSpriteComps10015 = var_172_3:GetComponentsInChildren(typeof(Image), true)
			end

			local var_172_4 = 0.034

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_4 and not isNil(var_172_3) then
				if arg_169_1.var_.actorSpriteComps10015 then
					for iter_172_0, iter_172_1 in pairs(arg_169_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_172_1 then
							if arg_169_1.isInRecall_ then
								iter_172_1.color = Color.New(Mathf.Lerp(iter_172_1.color.r, arg_169_1.hightColor2.r, (arg_169_1.time_ - 0) / var_172_4), Mathf.Lerp(iter_172_1.color.g, arg_169_1.hightColor2.g, (arg_169_1.time_ - 0) / var_172_4), (Mathf.Lerp(iter_172_1.color.b, arg_169_1.hightColor2.b, (arg_169_1.time_ - 0) / var_172_4)))
							else
								local var_172_5 = Mathf.Lerp(iter_172_1.color.r, 0.5, (arg_169_1.time_ - 0) / var_172_4)

								iter_172_1.color = Color.New(var_172_5, var_172_5, var_172_5)
							end
						end
					end
				end
			end

			if arg_169_1.time_ >= 0 + var_172_4 and arg_169_1.time_ < 0 + var_172_4 + arg_172_0 and not isNil(var_172_3) and arg_169_1.var_.actorSpriteComps10015 then
				for iter_172_2, iter_172_3 in pairs(arg_169_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_172_3 then
						iter_172_3.color = arg_169_1.isInRecall_ and (arg_169_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_169_1.var_.actorSpriteComps10015 = nil
			end

			local var_172_6 = 0
			local var_172_7 = 0.075

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_6 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[255].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_8 = arg_169_1:GetWordFromCfg(114282042)
				local var_172_9 = arg_169_1:FormatText(var_172_8.content)

				arg_169_1.text_.text = var_172_9

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_11 = 3 <= 0 and var_172_7 or var_172_7 * (utf8.len(var_172_9) / 3)

				if (3 <= 0 and var_172_7 or var_172_7 * (utf8.len(var_172_9) / 3)) > 0 and var_172_7 < var_172_11 then
					arg_169_1.talkMaxDuration = var_172_11

					if var_172_11 + var_172_6 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_11 + var_172_6
					end
				end

				arg_169_1.text_.text = var_172_9
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114282", "114282042", "story_v_out_114282.awb") ~= 0 then
					local var_172_12 = manager.audio:GetVoiceLength("story_v_out_114282", "114282042", "story_v_out_114282.awb") / 1000

					if var_172_12 + var_172_6 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_12 + var_172_6
					end

					if var_172_8.prefab_name ~= "" and arg_169_1.actors_[var_172_8.prefab_name] ~= nil then
						local var_172_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_8.prefab_name].transform, "story_v_out_114282", "114282042", "story_v_out_114282.awb")

						arg_169_1:RecordAudio("114282042", var_172_13)
						arg_169_1:RecordAudio("114282042", var_172_13)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_114282", "114282042", "story_v_out_114282.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_114282", "114282042", "story_v_out_114282.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_14 = math.max(var_172_7, arg_169_1.talkMaxDuration)

			if var_172_6 <= arg_169_1.time_ and arg_169_1.time_ < var_172_6 + var_172_14 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_6) / var_172_14

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_6 + var_172_14 and arg_169_1.time_ < var_172_6 + var_172_14 + arg_172_0 then
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
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(arg_173_1.actors_["10015"]) and arg_173_1.var_.actorSpriteComps10015 == nil then
				arg_173_1.var_.actorSpriteComps10015 = arg_173_1.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_176_0 = 0.034

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 and not isNil(arg_173_1.actors_["10015"]) then
				if arg_173_1.var_.actorSpriteComps10015 then
					for iter_176_0, iter_176_1 in pairs(arg_173_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_176_1 then
							if arg_173_1.isInRecall_ then
								iter_176_1.color = Color.New(Mathf.Lerp(iter_176_1.color.r, arg_173_1.hightColor1.r, (arg_173_1.time_ - 0) / var_176_0), Mathf.Lerp(iter_176_1.color.g, arg_173_1.hightColor1.g, (arg_173_1.time_ - 0) / var_176_0), (Mathf.Lerp(iter_176_1.color.b, arg_173_1.hightColor1.b, (arg_173_1.time_ - 0) / var_176_0)))
							else
								local var_176_1 = Mathf.Lerp(iter_176_1.color.r, 1, (arg_173_1.time_ - 0) / var_176_0)

								iter_176_1.color = Color.New(var_176_1, var_176_1, var_176_1)
							end
						end
					end
				end
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 and not isNil(arg_173_1.actors_["10015"]) and arg_173_1.var_.actorSpriteComps10015 then
				for iter_176_2, iter_176_3 in pairs(arg_173_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_176_3 then
						iter_176_3.color = arg_173_1.isInRecall_ and (arg_173_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_173_1.var_.actorSpriteComps10015 = nil
			end

			local var_176_2 = arg_173_1.actors_["10017"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_2) then
				local var_176_3 = var_176_2:GetComponent("Image")

				if var_176_3 then
					arg_173_1.var_.highlightMatValue10017 = var_176_3
				end
			end

			local var_176_4 = 0.034

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_4 and not isNil(var_176_2) then
				if arg_173_1.var_.highlightMatValue10017 then
					local var_176_5 = Mathf.Lerp(1, 0.5, (arg_173_1.time_ - 0) / var_176_4)

					arg_173_1.var_.highlightMatValue10017.color.r = var_176_5
					arg_173_1.var_.highlightMatValue10017.color.g = var_176_5
					arg_173_1.var_.highlightMatValue10017.color.b = var_176_5
					arg_173_1.var_.highlightMatValue10017.color = arg_173_1.var_.highlightMatValue10017.color
				end
			end

			if arg_173_1.time_ >= 0 + var_176_4 and arg_173_1.time_ < 0 + var_176_4 + arg_176_0 and not isNil(var_176_2) and arg_173_1.var_.highlightMatValue10017 then
				arg_173_1.var_.highlightMatValue10017.color.r = 0.5
				arg_173_1.var_.highlightMatValue10017.color.g = 0.5
				arg_173_1.var_.highlightMatValue10017.color.b = 0.5
				arg_173_1.var_.highlightMatValue10017.color = arg_173_1.var_.highlightMatValue10017.color
			end

			local var_176_6 = 0
			local var_176_7 = 0.4

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_6 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_8 = arg_173_1:GetWordFromCfg(114282043)
				local var_176_9 = arg_173_1:FormatText(var_176_8.content)

				arg_173_1.text_.text = var_176_9

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_11 = 16 <= 0 and var_176_7 or var_176_7 * (utf8.len(var_176_9) / 16)

				if (16 <= 0 and var_176_7 or var_176_7 * (utf8.len(var_176_9) / 16)) > 0 and var_176_7 < var_176_11 then
					arg_173_1.talkMaxDuration = var_176_11

					if var_176_11 + var_176_6 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_11 + var_176_6
					end
				end

				arg_173_1.text_.text = var_176_9
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114282", "114282043", "story_v_out_114282.awb") ~= 0 then
					local var_176_12 = manager.audio:GetVoiceLength("story_v_out_114282", "114282043", "story_v_out_114282.awb") / 1000

					if var_176_12 + var_176_6 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_12 + var_176_6
					end

					if var_176_8.prefab_name ~= "" and arg_173_1.actors_[var_176_8.prefab_name] ~= nil then
						local var_176_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_8.prefab_name].transform, "story_v_out_114282", "114282043", "story_v_out_114282.awb")

						arg_173_1:RecordAudio("114282043", var_176_13)
						arg_173_1:RecordAudio("114282043", var_176_13)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_114282", "114282043", "story_v_out_114282.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_114282", "114282043", "story_v_out_114282.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_14 = math.max(var_176_7, arg_173_1.talkMaxDuration)

			if var_176_6 <= arg_173_1.time_ and arg_173_1.time_ < var_176_6 + var_176_14 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_6) / var_176_14

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_6 + var_176_14 and arg_173_1.time_ < var_176_6 + var_176_14 + arg_176_0 then
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
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(arg_177_1.actors_["10017"]) then
				local var_180_0 = arg_177_1.actors_["10017"]:GetComponent("Image")

				if var_180_0 then
					arg_177_1.var_.highlightMatValue10017 = var_180_0
				end
			end

			local var_180_1 = 0.034

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_1 and not isNil(arg_177_1.actors_["10017"]) then
				if arg_177_1.var_.highlightMatValue10017 then
					local var_180_2 = Mathf.Lerp(0.5, 1, (arg_177_1.time_ - 0) / var_180_1)

					arg_177_1.var_.highlightMatValue10017.color.r = var_180_2
					arg_177_1.var_.highlightMatValue10017.color.g = var_180_2
					arg_177_1.var_.highlightMatValue10017.color.b = var_180_2
					arg_177_1.var_.highlightMatValue10017.color = arg_177_1.var_.highlightMatValue10017.color
				end
			end

			if arg_177_1.time_ >= 0 + var_180_1 and arg_177_1.time_ < 0 + var_180_1 + arg_180_0 and not isNil(arg_177_1.actors_["10017"]) and arg_177_1.var_.highlightMatValue10017 then
				arg_177_1.actors_["10017"].transform:SetSiblingIndex(1)

				arg_177_1.var_.highlightMatValue10017.color.r = 1
				arg_177_1.var_.highlightMatValue10017.color.g = 1
				arg_177_1.var_.highlightMatValue10017.color.b = 1
				arg_177_1.var_.highlightMatValue10017.color = arg_177_1.var_.highlightMatValue10017.color
			end

			local var_180_3 = arg_177_1.actors_["10015"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_3) and arg_177_1.var_.actorSpriteComps10015 == nil then
				arg_177_1.var_.actorSpriteComps10015 = var_180_3:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_4 = 0.034

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_4 and not isNil(var_180_3) then
				if arg_177_1.var_.actorSpriteComps10015 then
					for iter_180_0, iter_180_1 in pairs(arg_177_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_180_1 then
							if arg_177_1.isInRecall_ then
								iter_180_1.color = Color.New(Mathf.Lerp(iter_180_1.color.r, arg_177_1.hightColor2.r, (arg_177_1.time_ - 0) / var_180_4), Mathf.Lerp(iter_180_1.color.g, arg_177_1.hightColor2.g, (arg_177_1.time_ - 0) / var_180_4), (Mathf.Lerp(iter_180_1.color.b, arg_177_1.hightColor2.b, (arg_177_1.time_ - 0) / var_180_4)))
							else
								local var_180_5 = Mathf.Lerp(iter_180_1.color.r, 0.5, (arg_177_1.time_ - 0) / var_180_4)

								iter_180_1.color = Color.New(var_180_5, var_180_5, var_180_5)
							end
						end
					end
				end
			end

			if arg_177_1.time_ >= 0 + var_180_4 and arg_177_1.time_ < 0 + var_180_4 + arg_180_0 and not isNil(var_180_3) and arg_177_1.var_.actorSpriteComps10015 then
				for iter_180_2, iter_180_3 in pairs(arg_177_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_180_3 then
						iter_180_3.color = arg_177_1.isInRecall_ and (arg_177_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_177_1.var_.actorSpriteComps10015 = nil
			end

			local var_180_6 = 0
			local var_180_7 = 0.625

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_6 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[255].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_8 = arg_177_1:GetWordFromCfg(114282044)
				local var_180_9 = arg_177_1:FormatText(var_180_8.content)

				arg_177_1.text_.text = var_180_9

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_11 = 25 <= 0 and var_180_7 or var_180_7 * (utf8.len(var_180_9) / 25)

				if (25 <= 0 and var_180_7 or var_180_7 * (utf8.len(var_180_9) / 25)) > 0 and var_180_7 < var_180_11 then
					arg_177_1.talkMaxDuration = var_180_11

					if var_180_11 + var_180_6 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_11 + var_180_6
					end
				end

				arg_177_1.text_.text = var_180_9
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114282", "114282044", "story_v_out_114282.awb") ~= 0 then
					local var_180_12 = manager.audio:GetVoiceLength("story_v_out_114282", "114282044", "story_v_out_114282.awb") / 1000

					if var_180_12 + var_180_6 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_12 + var_180_6
					end

					if var_180_8.prefab_name ~= "" and arg_177_1.actors_[var_180_8.prefab_name] ~= nil then
						local var_180_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_8.prefab_name].transform, "story_v_out_114282", "114282044", "story_v_out_114282.awb")

						arg_177_1:RecordAudio("114282044", var_180_13)
						arg_177_1:RecordAudio("114282044", var_180_13)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_114282", "114282044", "story_v_out_114282.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_114282", "114282044", "story_v_out_114282.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_14 = math.max(var_180_7, arg_177_1.talkMaxDuration)

			if var_180_6 <= arg_177_1.time_ and arg_177_1.time_ < var_180_6 + var_180_14 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_6) / var_180_14

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_6 + var_180_14 and arg_177_1.time_ < var_180_6 + var_180_14 + arg_180_0 then
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
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos10023 = arg_181_1.actors_["10023"].transform.localPosition
				arg_181_1.actors_["10023"].transform.localScale = Vector3.New(1, 1, 1)

				arg_181_1:CheckSpriteTmpPos("10023", 2)
			end

			local var_184_0 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 then
				arg_181_1.actors_["10023"].transform.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos10023, Vector3.New(-390, -350, -180), (arg_181_1.time_ - 0) / var_184_0)
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 then
				arg_181_1.actors_["10023"].transform.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_184_1 = arg_181_1.actors_["10023"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_1) then
				local var_184_2 = var_184_1:GetComponent("Image")

				if var_184_2 then
					arg_181_1.var_.highlightMatValue10023 = var_184_2
				end
			end

			local var_184_3 = 0.034

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_3 and not isNil(var_184_1) then
				if arg_181_1.var_.highlightMatValue10023 then
					local var_184_4 = Mathf.Lerp(0.5, 1, (arg_181_1.time_ - 0) / var_184_3)

					arg_181_1.var_.highlightMatValue10023.color.r = var_184_4
					arg_181_1.var_.highlightMatValue10023.color.g = var_184_4
					arg_181_1.var_.highlightMatValue10023.color.b = var_184_4
					arg_181_1.var_.highlightMatValue10023.color = arg_181_1.var_.highlightMatValue10023.color
				end
			end

			if arg_181_1.time_ >= 0 + var_184_3 and arg_181_1.time_ < 0 + var_184_3 + arg_184_0 and not isNil(var_184_1) and arg_181_1.var_.highlightMatValue10023 then
				var_184_1.transform:SetSiblingIndex(1)

				arg_181_1.var_.highlightMatValue10023.color.r = 1
				arg_181_1.var_.highlightMatValue10023.color.g = 1
				arg_181_1.var_.highlightMatValue10023.color.b = 1
				arg_181_1.var_.highlightMatValue10023.color = arg_181_1.var_.highlightMatValue10023.color
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				local var_184_5 = arg_181_1.actors_["10023"]:GetComponent("Image")

				if var_184_5 then
					arg_181_1.var_.alphaMatValue10023 = var_184_5
					arg_181_1.var_.alphaOldValue10023 = var_184_5.color.a
				end

				arg_181_1.var_.alphaOldValue10023 = 0
			end

			local var_184_6 = 0.5

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_6 then
				if arg_181_1.var_.alphaMatValue10023 then
					arg_181_1.var_.alphaMatValue10023.color.a = Mathf.Lerp(arg_181_1.var_.alphaOldValue10023, 1, (arg_181_1.time_ - 0) / var_184_6)
					arg_181_1.var_.alphaMatValue10023.color = arg_181_1.var_.alphaMatValue10023.color
				end
			end

			if arg_181_1.time_ >= 0 + var_184_6 and arg_181_1.time_ < 0 + var_184_6 + arg_184_0 and arg_181_1.var_.alphaMatValue10023 then
				arg_181_1.var_.alphaMatValue10023.color.a = 1
				arg_181_1.var_.alphaMatValue10023.color = arg_181_1.var_.alphaMatValue10023.color
			end

			local var_184_7 = 0
			local var_184_8 = 0.825

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_7 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_9 = arg_181_1:GetWordFromCfg(114282045)
				local var_184_10 = arg_181_1:FormatText(var_184_9.content)

				arg_181_1.text_.text = var_184_10

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_12 = 33 <= 0 and var_184_8 or var_184_8 * (utf8.len(var_184_10) / 33)

				if (33 <= 0 and var_184_8 or var_184_8 * (utf8.len(var_184_10) / 33)) > 0 and var_184_8 < var_184_12 then
					arg_181_1.talkMaxDuration = var_184_12

					if var_184_12 + var_184_7 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_12 + var_184_7
					end
				end

				arg_181_1.text_.text = var_184_10
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114282", "114282045", "story_v_out_114282.awb") ~= 0 then
					local var_184_13 = manager.audio:GetVoiceLength("story_v_out_114282", "114282045", "story_v_out_114282.awb") / 1000

					if var_184_13 + var_184_7 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_13 + var_184_7
					end

					if var_184_9.prefab_name ~= "" and arg_181_1.actors_[var_184_9.prefab_name] ~= nil then
						local var_184_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_9.prefab_name].transform, "story_v_out_114282", "114282045", "story_v_out_114282.awb")

						arg_181_1:RecordAudio("114282045", var_184_14)
						arg_181_1:RecordAudio("114282045", var_184_14)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_114282", "114282045", "story_v_out_114282.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_114282", "114282045", "story_v_out_114282.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_15 = math.max(var_184_8, arg_181_1.talkMaxDuration)

			if var_184_7 <= arg_181_1.time_ and arg_181_1.time_ < var_184_7 + var_184_15 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_7) / var_184_15

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_7 + var_184_15 and arg_181_1.time_ < var_184_7 + var_184_15 + arg_184_0 then
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
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(arg_185_1.actors_["10015"]) and arg_185_1.var_.actorSpriteComps10015 == nil then
				arg_185_1.var_.actorSpriteComps10015 = arg_185_1.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_188_0 = 0.034

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_0 and not isNil(arg_185_1.actors_["10015"]) then
				if arg_185_1.var_.actorSpriteComps10015 then
					for iter_188_0, iter_188_1 in pairs(arg_185_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_188_1 then
							if arg_185_1.isInRecall_ then
								iter_188_1.color = Color.New(Mathf.Lerp(iter_188_1.color.r, arg_185_1.hightColor1.r, (arg_185_1.time_ - 0) / var_188_0), Mathf.Lerp(iter_188_1.color.g, arg_185_1.hightColor1.g, (arg_185_1.time_ - 0) / var_188_0), (Mathf.Lerp(iter_188_1.color.b, arg_185_1.hightColor1.b, (arg_185_1.time_ - 0) / var_188_0)))
							else
								local var_188_1 = Mathf.Lerp(iter_188_1.color.r, 1, (arg_185_1.time_ - 0) / var_188_0)

								iter_188_1.color = Color.New(var_188_1, var_188_1, var_188_1)
							end
						end
					end
				end
			end

			if arg_185_1.time_ >= 0 + var_188_0 and arg_185_1.time_ < 0 + var_188_0 + arg_188_0 and not isNil(arg_185_1.actors_["10015"]) and arg_185_1.var_.actorSpriteComps10015 then
				for iter_188_2, iter_188_3 in pairs(arg_185_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_188_3 then
						iter_188_3.color = arg_185_1.isInRecall_ and (arg_185_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_185_1.var_.actorSpriteComps10015 = nil
			end

			local var_188_2 = arg_185_1.actors_["10023"]

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(var_188_2) then
				local var_188_3 = var_188_2:GetComponent("Image")

				if var_188_3 then
					arg_185_1.var_.highlightMatValue10023 = var_188_3
				end
			end

			local var_188_4 = 0.034

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_4 and not isNil(var_188_2) then
				if arg_185_1.var_.highlightMatValue10023 then
					local var_188_5 = Mathf.Lerp(1, 0.5, (arg_185_1.time_ - 0) / var_188_4)

					arg_185_1.var_.highlightMatValue10023.color.r = var_188_5
					arg_185_1.var_.highlightMatValue10023.color.g = var_188_5
					arg_185_1.var_.highlightMatValue10023.color.b = var_188_5
					arg_185_1.var_.highlightMatValue10023.color = arg_185_1.var_.highlightMatValue10023.color
				end
			end

			if arg_185_1.time_ >= 0 + var_188_4 and arg_185_1.time_ < 0 + var_188_4 + arg_188_0 and not isNil(var_188_2) and arg_185_1.var_.highlightMatValue10023 then
				arg_185_1.var_.highlightMatValue10023.color.r = 0.5
				arg_185_1.var_.highlightMatValue10023.color.g = 0.5
				arg_185_1.var_.highlightMatValue10023.color.b = 0.5
				arg_185_1.var_.highlightMatValue10023.color = arg_185_1.var_.highlightMatValue10023.color
			end

			local var_188_6 = 0
			local var_188_7 = 0.425

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_6 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_8 = arg_185_1:GetWordFromCfg(114282046)
				local var_188_9 = arg_185_1:FormatText(var_188_8.content)

				arg_185_1.text_.text = var_188_9

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_11 = 17 <= 0 and var_188_7 or var_188_7 * (utf8.len(var_188_9) / 17)

				if (17 <= 0 and var_188_7 or var_188_7 * (utf8.len(var_188_9) / 17)) > 0 and var_188_7 < var_188_11 then
					arg_185_1.talkMaxDuration = var_188_11

					if var_188_11 + var_188_6 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_11 + var_188_6
					end
				end

				arg_185_1.text_.text = var_188_9
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114282", "114282046", "story_v_out_114282.awb") ~= 0 then
					local var_188_12 = manager.audio:GetVoiceLength("story_v_out_114282", "114282046", "story_v_out_114282.awb") / 1000

					if var_188_12 + var_188_6 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_12 + var_188_6
					end

					if var_188_8.prefab_name ~= "" and arg_185_1.actors_[var_188_8.prefab_name] ~= nil then
						local var_188_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_8.prefab_name].transform, "story_v_out_114282", "114282046", "story_v_out_114282.awb")

						arg_185_1:RecordAudio("114282046", var_188_13)
						arg_185_1:RecordAudio("114282046", var_188_13)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_114282", "114282046", "story_v_out_114282.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_114282", "114282046", "story_v_out_114282.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_14 = math.max(var_188_7, arg_185_1.talkMaxDuration)

			if var_188_6 <= arg_185_1.time_ and arg_185_1.time_ < var_188_6 + var_188_14 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_6) / var_188_14

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_6 + var_188_14 and arg_185_1.time_ < var_188_6 + var_188_14 + arg_188_0 then
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
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos10017 = arg_189_1.actors_["10017"].transform.localPosition
				arg_189_1.actors_["10017"].transform.localScale = Vector3.New(1, 1, 1)

				arg_189_1:CheckSpriteTmpPos("10017", 2)
			end

			local var_192_0 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 then
				arg_189_1.actors_["10017"].transform.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos10017, Vector3.New(-390, -350, -180), (arg_189_1.time_ - 0) / var_192_0)
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 then
				arg_189_1.actors_["10017"].transform.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_192_1 = arg_189_1.actors_["10017"]

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(var_192_1) then
				local var_192_2 = var_192_1:GetComponent("Image")

				if var_192_2 then
					arg_189_1.var_.highlightMatValue10017 = var_192_2
				end
			end

			local var_192_3 = 0.034

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_3 and not isNil(var_192_1) then
				if arg_189_1.var_.highlightMatValue10017 then
					local var_192_4 = Mathf.Lerp(0.5, 1, (arg_189_1.time_ - 0) / var_192_3)

					arg_189_1.var_.highlightMatValue10017.color.r = var_192_4
					arg_189_1.var_.highlightMatValue10017.color.g = var_192_4
					arg_189_1.var_.highlightMatValue10017.color.b = var_192_4
					arg_189_1.var_.highlightMatValue10017.color = arg_189_1.var_.highlightMatValue10017.color
				end
			end

			if arg_189_1.time_ >= 0 + var_192_3 and arg_189_1.time_ < 0 + var_192_3 + arg_192_0 and not isNil(var_192_1) and arg_189_1.var_.highlightMatValue10017 then
				var_192_1.transform:SetSiblingIndex(1)

				arg_189_1.var_.highlightMatValue10017.color.r = 1
				arg_189_1.var_.highlightMatValue10017.color.g = 1
				arg_189_1.var_.highlightMatValue10017.color.b = 1
				arg_189_1.var_.highlightMatValue10017.color = arg_189_1.var_.highlightMatValue10017.color
			end

			local var_192_5 = arg_189_1.actors_["10015"]

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(var_192_5) and arg_189_1.var_.actorSpriteComps10015 == nil then
				arg_189_1.var_.actorSpriteComps10015 = var_192_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_192_6 = 0.034

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_6 and not isNil(var_192_5) then
				if arg_189_1.var_.actorSpriteComps10015 then
					for iter_192_0, iter_192_1 in pairs(arg_189_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_192_1 then
							if arg_189_1.isInRecall_ then
								iter_192_1.color = Color.New(Mathf.Lerp(iter_192_1.color.r, arg_189_1.hightColor2.r, (arg_189_1.time_ - 0) / var_192_6), Mathf.Lerp(iter_192_1.color.g, arg_189_1.hightColor2.g, (arg_189_1.time_ - 0) / var_192_6), (Mathf.Lerp(iter_192_1.color.b, arg_189_1.hightColor2.b, (arg_189_1.time_ - 0) / var_192_6)))
							else
								local var_192_7 = Mathf.Lerp(iter_192_1.color.r, 0.5, (arg_189_1.time_ - 0) / var_192_6)

								iter_192_1.color = Color.New(var_192_7, var_192_7, var_192_7)
							end
						end
					end
				end
			end

			if arg_189_1.time_ >= 0 + var_192_6 and arg_189_1.time_ < 0 + var_192_6 + arg_192_0 and not isNil(var_192_5) and arg_189_1.var_.actorSpriteComps10015 then
				for iter_192_2, iter_192_3 in pairs(arg_189_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_192_3 then
						iter_192_3.color = arg_189_1.isInRecall_ and (arg_189_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_189_1.var_.actorSpriteComps10015 = nil
			end

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				local var_192_8 = arg_189_1.actors_["10017"]:GetComponent("Image")

				if var_192_8 then
					arg_189_1.var_.alphaMatValue10017 = var_192_8
					arg_189_1.var_.alphaOldValue10017 = var_192_8.color.a
				end

				arg_189_1.var_.alphaOldValue10017 = 0
			end

			local var_192_9 = 0.5

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_9 then
				if arg_189_1.var_.alphaMatValue10017 then
					arg_189_1.var_.alphaMatValue10017.color.a = Mathf.Lerp(arg_189_1.var_.alphaOldValue10017, 1, (arg_189_1.time_ - 0) / var_192_9)
					arg_189_1.var_.alphaMatValue10017.color = arg_189_1.var_.alphaMatValue10017.color
				end
			end

			if arg_189_1.time_ >= 0 + var_192_9 and arg_189_1.time_ < 0 + var_192_9 + arg_192_0 and arg_189_1.var_.alphaMatValue10017 then
				arg_189_1.var_.alphaMatValue10017.color.a = 1
				arg_189_1.var_.alphaMatValue10017.color = arg_189_1.var_.alphaMatValue10017.color
			end

			local var_192_10 = 0
			local var_192_11 = 0.05

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_10 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[255].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_12 = arg_189_1:GetWordFromCfg(114282047)
				local var_192_13 = arg_189_1:FormatText(var_192_12.content)

				arg_189_1.text_.text = var_192_13

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_15 = 2 <= 0 and var_192_11 or var_192_11 * (utf8.len(var_192_13) / 2)

				if (2 <= 0 and var_192_11 or var_192_11 * (utf8.len(var_192_13) / 2)) > 0 and var_192_11 < var_192_15 then
					arg_189_1.talkMaxDuration = var_192_15

					if var_192_15 + var_192_10 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_15 + var_192_10
					end
				end

				arg_189_1.text_.text = var_192_13
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114282", "114282047", "story_v_out_114282.awb") ~= 0 then
					local var_192_16 = manager.audio:GetVoiceLength("story_v_out_114282", "114282047", "story_v_out_114282.awb") / 1000

					if var_192_16 + var_192_10 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_16 + var_192_10
					end

					if var_192_12.prefab_name ~= "" and arg_189_1.actors_[var_192_12.prefab_name] ~= nil then
						local var_192_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_12.prefab_name].transform, "story_v_out_114282", "114282047", "story_v_out_114282.awb")

						arg_189_1:RecordAudio("114282047", var_192_17)
						arg_189_1:RecordAudio("114282047", var_192_17)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_114282", "114282047", "story_v_out_114282.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_114282", "114282047", "story_v_out_114282.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_18 = math.max(var_192_11, arg_189_1.talkMaxDuration)

			if var_192_10 <= arg_189_1.time_ and arg_189_1.time_ < var_192_10 + var_192_18 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_10) / var_192_18

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_10 + var_192_18 and arg_189_1.time_ < var_192_10 + var_192_18 + arg_192_0 then
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
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(arg_193_1.actors_["10017"]) then
				local var_196_0 = arg_193_1.actors_["10017"]:GetComponent("Image")

				if var_196_0 then
					arg_193_1.var_.highlightMatValue10017 = var_196_0
				end
			end

			local var_196_1 = 0.034

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_1 and not isNil(arg_193_1.actors_["10017"]) then
				if arg_193_1.var_.highlightMatValue10017 then
					local var_196_2 = Mathf.Lerp(1, 0.5, (arg_193_1.time_ - 0) / var_196_1)

					arg_193_1.var_.highlightMatValue10017.color.r = var_196_2
					arg_193_1.var_.highlightMatValue10017.color.g = var_196_2
					arg_193_1.var_.highlightMatValue10017.color.b = var_196_2
					arg_193_1.var_.highlightMatValue10017.color = arg_193_1.var_.highlightMatValue10017.color
				end
			end

			if arg_193_1.time_ >= 0 + var_196_1 and arg_193_1.time_ < 0 + var_196_1 + arg_196_0 and not isNil(arg_193_1.actors_["10017"]) and arg_193_1.var_.highlightMatValue10017 then
				arg_193_1.var_.highlightMatValue10017.color.r = 0.5
				arg_193_1.var_.highlightMatValue10017.color.g = 0.5
				arg_193_1.var_.highlightMatValue10017.color.b = 0.5
				arg_193_1.var_.highlightMatValue10017.color = arg_193_1.var_.highlightMatValue10017.color
			end

			local var_196_3 = 0
			local var_196_4 = 0.775

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_3 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, false)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_5 = arg_193_1:FormatText(arg_193_1:GetWordFromCfg(114282048).content)

				arg_193_1.text_.text = var_196_5

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_7 = 31 <= 0 and var_196_4 or var_196_4 * (utf8.len(var_196_5) / 31)

				if (31 <= 0 and var_196_4 or var_196_4 * (utf8.len(var_196_5) / 31)) > 0 and var_196_4 < var_196_7 then
					arg_193_1.talkMaxDuration = var_196_7

					if var_196_7 + var_196_3 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_7 + var_196_3
					end
				end

				arg_193_1.text_.text = var_196_5
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_8 = math.max(var_196_4, arg_193_1.talkMaxDuration)

			if var_196_3 <= arg_193_1.time_ and arg_193_1.time_ < var_196_3 + var_196_8 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_3) / var_196_8

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_3 + var_196_8 and arg_193_1.time_ < var_196_3 + var_196_8 + arg_196_0 then
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
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(arg_197_1.actors_["10017"]) then
				local var_200_0 = arg_197_1.actors_["10017"]:GetComponent("Image")

				if var_200_0 then
					arg_197_1.var_.highlightMatValue10017 = var_200_0
				end
			end

			local var_200_1 = 0.034

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_1 and not isNil(arg_197_1.actors_["10017"]) then
				if arg_197_1.var_.highlightMatValue10017 then
					local var_200_2 = Mathf.Lerp(0.5, 1, (arg_197_1.time_ - 0) / var_200_1)

					arg_197_1.var_.highlightMatValue10017.color.r = var_200_2
					arg_197_1.var_.highlightMatValue10017.color.g = var_200_2
					arg_197_1.var_.highlightMatValue10017.color.b = var_200_2
					arg_197_1.var_.highlightMatValue10017.color = arg_197_1.var_.highlightMatValue10017.color
				end
			end

			if arg_197_1.time_ >= 0 + var_200_1 and arg_197_1.time_ < 0 + var_200_1 + arg_200_0 and not isNil(arg_197_1.actors_["10017"]) and arg_197_1.var_.highlightMatValue10017 then
				arg_197_1.actors_["10017"].transform:SetSiblingIndex(1)

				arg_197_1.var_.highlightMatValue10017.color.r = 1
				arg_197_1.var_.highlightMatValue10017.color.g = 1
				arg_197_1.var_.highlightMatValue10017.color.b = 1
				arg_197_1.var_.highlightMatValue10017.color = arg_197_1.var_.highlightMatValue10017.color
			end

			local var_200_3 = 0
			local var_200_4 = 0.975

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_3 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[255].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_5 = arg_197_1:GetWordFromCfg(114282049)
				local var_200_6 = arg_197_1:FormatText(var_200_5.content)

				arg_197_1.text_.text = var_200_6

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_8 = 39 <= 0 and var_200_4 or var_200_4 * (utf8.len(var_200_6) / 39)

				if (39 <= 0 and var_200_4 or var_200_4 * (utf8.len(var_200_6) / 39)) > 0 and var_200_4 < var_200_8 then
					arg_197_1.talkMaxDuration = var_200_8

					if var_200_8 + var_200_3 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_8 + var_200_3
					end
				end

				arg_197_1.text_.text = var_200_6
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114282", "114282049", "story_v_out_114282.awb") ~= 0 then
					local var_200_9 = manager.audio:GetVoiceLength("story_v_out_114282", "114282049", "story_v_out_114282.awb") / 1000

					if var_200_9 + var_200_3 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_9 + var_200_3
					end

					if var_200_5.prefab_name ~= "" and arg_197_1.actors_[var_200_5.prefab_name] ~= nil then
						local var_200_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_5.prefab_name].transform, "story_v_out_114282", "114282049", "story_v_out_114282.awb")

						arg_197_1:RecordAudio("114282049", var_200_10)
						arg_197_1:RecordAudio("114282049", var_200_10)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_114282", "114282049", "story_v_out_114282.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_114282", "114282049", "story_v_out_114282.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_11 = math.max(var_200_4, arg_197_1.talkMaxDuration)

			if var_200_3 <= arg_197_1.time_ and arg_197_1.time_ < var_200_3 + var_200_11 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_3) / var_200_11

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_3 + var_200_11 and arg_197_1.time_ < var_200_3 + var_200_11 + arg_200_0 then
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
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(arg_201_1.actors_["10015"]) and arg_201_1.var_.actorSpriteComps10015 == nil then
				arg_201_1.var_.actorSpriteComps10015 = arg_201_1.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_204_0 = 0.034

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_0 and not isNil(arg_201_1.actors_["10015"]) then
				if arg_201_1.var_.actorSpriteComps10015 then
					for iter_204_0, iter_204_1 in pairs(arg_201_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_204_1 then
							if arg_201_1.isInRecall_ then
								iter_204_1.color = Color.New(Mathf.Lerp(iter_204_1.color.r, arg_201_1.hightColor1.r, (arg_201_1.time_ - 0) / var_204_0), Mathf.Lerp(iter_204_1.color.g, arg_201_1.hightColor1.g, (arg_201_1.time_ - 0) / var_204_0), (Mathf.Lerp(iter_204_1.color.b, arg_201_1.hightColor1.b, (arg_201_1.time_ - 0) / var_204_0)))
							else
								local var_204_1 = Mathf.Lerp(iter_204_1.color.r, 1, (arg_201_1.time_ - 0) / var_204_0)

								iter_204_1.color = Color.New(var_204_1, var_204_1, var_204_1)
							end
						end
					end
				end
			end

			if arg_201_1.time_ >= 0 + var_204_0 and arg_201_1.time_ < 0 + var_204_0 + arg_204_0 and not isNil(arg_201_1.actors_["10015"]) and arg_201_1.var_.actorSpriteComps10015 then
				for iter_204_2, iter_204_3 in pairs(arg_201_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_204_3 then
						iter_204_3.color = arg_201_1.isInRecall_ and (arg_201_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_201_1.var_.actorSpriteComps10015 = nil
			end

			local var_204_2 = arg_201_1.actors_["10017"]

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(var_204_2) then
				local var_204_3 = var_204_2:GetComponent("Image")

				if var_204_3 then
					arg_201_1.var_.highlightMatValue10017 = var_204_3
				end
			end

			local var_204_4 = 0.034

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_4 and not isNil(var_204_2) then
				if arg_201_1.var_.highlightMatValue10017 then
					local var_204_5 = Mathf.Lerp(1, 0.5, (arg_201_1.time_ - 0) / var_204_4)

					arg_201_1.var_.highlightMatValue10017.color.r = var_204_5
					arg_201_1.var_.highlightMatValue10017.color.g = var_204_5
					arg_201_1.var_.highlightMatValue10017.color.b = var_204_5
					arg_201_1.var_.highlightMatValue10017.color = arg_201_1.var_.highlightMatValue10017.color
				end
			end

			if arg_201_1.time_ >= 0 + var_204_4 and arg_201_1.time_ < 0 + var_204_4 + arg_204_0 and not isNil(var_204_2) and arg_201_1.var_.highlightMatValue10017 then
				arg_201_1.var_.highlightMatValue10017.color.r = 0.5
				arg_201_1.var_.highlightMatValue10017.color.g = 0.5
				arg_201_1.var_.highlightMatValue10017.color.b = 0.5
				arg_201_1.var_.highlightMatValue10017.color = arg_201_1.var_.highlightMatValue10017.color
			end

			local var_204_6 = arg_201_1.actors_["10015"].transform

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.var_.moveOldPos10015 = var_204_6.localPosition
				var_204_6.localScale = Vector3.New(1, 1, 1)

				arg_201_1:CheckSpriteTmpPos("10015", 4)

				for iter_204_4 = 0, var_204_6.childCount - 1 do
					local var_204_7 = var_204_6:GetChild(iter_204_4)

					if var_204_7.name == "split_5" or not string.find(var_204_7.name, "split") then
						var_204_7.gameObject:SetActive(true)
					else
						var_204_7.gameObject:SetActive(false)
					end
				end
			end

			local var_204_8 = 0.001

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_8 then
				var_204_6.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos10015, Vector3.New(390, -350, -180), (arg_201_1.time_ - 0) / var_204_8)
			end

			if arg_201_1.time_ >= 0 + var_204_8 and arg_201_1.time_ < 0 + var_204_8 + arg_204_0 then
				var_204_6.localPosition = Vector3.New(390, -350, -180)
			end

			local var_204_9 = 0
			local var_204_10 = 0.15

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_9 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_11 = arg_201_1:GetWordFromCfg(114282050)
				local var_204_12 = arg_201_1:FormatText(var_204_11.content)

				arg_201_1.text_.text = var_204_12

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_14 = 6 <= 0 and var_204_10 or var_204_10 * (utf8.len(var_204_12) / 6)

				if (6 <= 0 and var_204_10 or var_204_10 * (utf8.len(var_204_12) / 6)) > 0 and var_204_10 < var_204_14 then
					arg_201_1.talkMaxDuration = var_204_14

					if var_204_14 + var_204_9 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_14 + var_204_9
					end
				end

				arg_201_1.text_.text = var_204_12
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114282", "114282050", "story_v_out_114282.awb") ~= 0 then
					local var_204_15 = manager.audio:GetVoiceLength("story_v_out_114282", "114282050", "story_v_out_114282.awb") / 1000

					if var_204_15 + var_204_9 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_15 + var_204_9
					end

					if var_204_11.prefab_name ~= "" and arg_201_1.actors_[var_204_11.prefab_name] ~= nil then
						local var_204_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_11.prefab_name].transform, "story_v_out_114282", "114282050", "story_v_out_114282.awb")

						arg_201_1:RecordAudio("114282050", var_204_16)
						arg_201_1:RecordAudio("114282050", var_204_16)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_114282", "114282050", "story_v_out_114282.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_114282", "114282050", "story_v_out_114282.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_17 = math.max(var_204_10, arg_201_1.talkMaxDuration)

			if var_204_9 <= arg_201_1.time_ and arg_201_1.time_ < var_204_9 + var_204_17 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_9) / var_204_17

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_9 + var_204_17 and arg_201_1.time_ < var_204_9 + var_204_17 + arg_204_0 then
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
