return {
	Play109041001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 109041001
		arg_1_1.duration_ = 1.41

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play109041003(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				arg_1_1.fswbg_:SetActive(true)
				arg_1_1.dialog_:SetActive(false)

				arg_1_1.fswtw_.percent = 0

				local var_4_1 = arg_1_1:GetWordFromCfg(109041001)
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

			local var_4_3 = 0.0166666666666667

			if var_4_3 < arg_1_1.time_ and arg_1_1.time_ <= var_4_3 + arg_4_0 then
				arg_1_1.var_.oldValueTypewriter = arg_1_1.fswtw_.percent

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_4 = 7
			local var_4_5 = 0.42
			local var_4_6 = arg_1_1:GetWordFromCfg(109041001)
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

			local var_4_11 = 0.42
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
			local var_4_15 = 1

			if var_4_14 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				local var_4_16 = "play"
				local var_4_17 = "music"

				arg_1_1:AudioAction(var_4_16, var_4_17, "bgm_story_scheme", "bgm_story_scheme", "bgm_story_scheme.awb")

				local var_4_18 = ""
				local var_4_19 = manager.audio:GetAudioName("bgm_story_scheme", "bgm_story_scheme")

				if var_4_19 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_19 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_19

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_19
						arg_1_1.bgmTxt2_.text = var_4_19
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

			local var_4_20 = 0
			local var_4_21 = 0.73169900663197

			if var_4_20 < arg_1_1.time_ and arg_1_1.time_ <= var_4_20 + arg_4_0 then
				local var_4_22 = "play"
				local var_4_23 = "effect"

				arg_1_1:AudioAction(var_4_22, var_4_23, "se_story_9", "se_story_9_fire_environment_loop", "")
			end

			local var_4_24 = 0
			local var_4_25 = 1.406
			local var_4_26 = manager.audio:GetVoiceLength("story_v_out_109041", "109041001", "story_v_out_109041.awb") / 1000

			if var_4_26 > 0 and var_4_25 < var_4_26 and var_4_26 + var_4_24 > arg_1_1.duration_ then
				local var_4_27 = var_4_26

				arg_1_1.duration_ = var_4_26 + var_4_24
			end

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_28 = "play"
				local var_4_29 = "voice"

				arg_1_1:AudioAction(var_4_28, var_4_29, "story_v_out_109041", "109041001", "story_v_out_109041.awb")
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play109041003 = function(arg_6_0, arg_6_1)
		arg_6_1.time_ = 0
		arg_6_1.frameCnt_ = 0
		arg_6_1.state_ = "playing"
		arg_6_1.curTalkId_ = 109041003
		arg_6_1.duration_ = 5.94

		SetActive(arg_6_1.tipsGo_, false)

		function arg_6_1.onSingleLineFinish_()
			arg_6_1.onSingleLineUpdate_ = nil
			arg_6_1.onSingleLineFinish_ = nil
			arg_6_1.state_ = "waiting"
		end

		function arg_6_1.playNext_(arg_8_0)
			if arg_8_0 == 1 then
				arg_6_0:Play109041004(arg_6_1)
			end
		end

		function arg_6_1.onSingleLineUpdate_(arg_9_0)
			local var_9_0 = 0

			if var_9_0 < arg_6_1.time_ and arg_6_1.time_ <= var_9_0 + arg_9_0 then
				arg_6_1.var_.oldValueTypewriter = arg_6_1.fswtw_.percent

				SetActive(arg_6_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_6_1:ShowNextGo(false)
			end

			local var_9_1 = 26
			local var_9_2 = 1.56
			local var_9_3 = arg_6_1:GetWordFromCfg(109041001)
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

			local var_9_8 = 1.56
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
			local var_9_12 = 5.937
			local var_9_13 = manager.audio:GetVoiceLength("story_v_out_109041", "109041003", "story_v_out_109041.awb") / 1000

			if var_9_13 > 0 and var_9_12 < var_9_13 and var_9_13 + var_9_11 > arg_6_1.duration_ then
				local var_9_14 = var_9_13

				arg_6_1.duration_ = var_9_13 + var_9_11
			end

			if var_9_11 < arg_6_1.time_ and arg_6_1.time_ <= var_9_11 + arg_9_0 then
				local var_9_15 = "play"
				local var_9_16 = "voice"

				arg_6_1:AudioAction(var_9_15, var_9_16, "story_v_out_109041", "109041003", "story_v_out_109041.awb")
			end
		end

		arg_6_1.nodeConfigList_ = {}

		arg_6_1:InitPlayNodeList()
	end,
	Play109041004 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 109041004
		arg_10_1.duration_ = 7.51

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play109041005(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			local var_13_0 = 0

			if var_13_0 < arg_10_1.time_ and arg_10_1.time_ <= var_13_0 + arg_13_0 then
				arg_10_1.var_.oldValueTypewriter = arg_10_1.fswtw_.percent

				SetActive(arg_10_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_10_1:ShowNextGo(false)
			end

			local var_13_1 = 33
			local var_13_2 = 1.98
			local var_13_3 = arg_10_1:GetWordFromCfg(109041001)
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

			local var_13_8 = 1.98
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
			local var_13_12 = 7.51
			local var_13_13 = manager.audio:GetVoiceLength("story_v_out_109041", "109041004", "story_v_out_109041.awb") / 1000

			if var_13_13 > 0 and var_13_12 < var_13_13 and var_13_13 + var_13_11 > arg_10_1.duration_ then
				local var_13_14 = var_13_13

				arg_10_1.duration_ = var_13_13 + var_13_11
			end

			if var_13_11 < arg_10_1.time_ and arg_10_1.time_ <= var_13_11 + arg_13_0 then
				local var_13_15 = "play"
				local var_13_16 = "voice"

				arg_10_1:AudioAction(var_13_15, var_13_16, "story_v_out_109041", "109041004", "story_v_out_109041.awb")
			end
		end

		arg_10_1.nodeConfigList_ = {}

		arg_10_1:InitPlayNodeList()
	end,
	Play109041005 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 109041005
		arg_14_1.duration_ = 6.32

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play109041006(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = 0

			if var_17_0 < arg_14_1.time_ and arg_14_1.time_ <= var_17_0 + arg_17_0 then
				arg_14_1.var_.oldValueTypewriter = arg_14_1.fswtw_.percent

				SetActive(arg_14_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_14_1:ShowNextGo(false)
			end

			local var_17_1 = 30
			local var_17_2 = 1.8
			local var_17_3 = arg_14_1:GetWordFromCfg(109041001)
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

			local var_17_8 = 1.8
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
			local var_17_12 = 6.32
			local var_17_13 = manager.audio:GetVoiceLength("story_v_out_109041", "109041005", "story_v_out_109041.awb") / 1000

			if var_17_13 > 0 and var_17_12 < var_17_13 and var_17_13 + var_17_11 > arg_14_1.duration_ then
				local var_17_14 = var_17_13

				arg_14_1.duration_ = var_17_13 + var_17_11
			end

			if var_17_11 < arg_14_1.time_ and arg_14_1.time_ <= var_17_11 + arg_17_0 then
				local var_17_15 = "play"
				local var_17_16 = "voice"

				arg_14_1:AudioAction(var_17_15, var_17_16, "story_v_out_109041", "109041005", "story_v_out_109041.awb")
			end
		end

		arg_14_1.nodeConfigList_ = {}

		arg_14_1:InitPlayNodeList()
	end,
	Play109041006 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 109041006
		arg_18_1.duration_ = 6.91

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play109041007(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = 0

			if var_21_0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_0 + arg_21_0 then
				arg_18_1.var_.oldValueTypewriter = arg_18_1.fswtw_.percent

				SetActive(arg_18_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_18_1:ShowNextGo(false)
			end

			local var_21_1 = 28
			local var_21_2 = 1.68
			local var_21_3 = arg_18_1:GetWordFromCfg(109041001)
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

			local var_21_8 = 1.68
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

			local var_21_11 = 0
			local var_21_12 = 6.915
			local var_21_13 = manager.audio:GetVoiceLength("story_v_out_109041", "109041006", "story_v_out_109041.awb") / 1000

			if var_21_13 > 0 and var_21_12 < var_21_13 and var_21_13 + var_21_11 > arg_18_1.duration_ then
				local var_21_14 = var_21_13

				arg_18_1.duration_ = var_21_13 + var_21_11
			end

			if var_21_11 < arg_18_1.time_ and arg_18_1.time_ <= var_21_11 + arg_21_0 then
				local var_21_15 = "play"
				local var_21_16 = "voice"

				arg_18_1:AudioAction(var_21_15, var_21_16, "story_v_out_109041", "109041006", "story_v_out_109041.awb")
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play109041007 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 109041007
		arg_22_1.duration_ = 10.89

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play109041008(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = 0

			if var_25_0 < arg_22_1.time_ and arg_22_1.time_ <= var_25_0 + arg_25_0 then
				arg_22_1.var_.oldValueTypewriter = arg_22_1.fswtw_.percent

				SetActive(arg_22_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_22_1:ShowNextGo(false)
			end

			local var_25_1 = 38
			local var_25_2 = 2.28
			local var_25_3 = arg_22_1:GetWordFromCfg(109041001)
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

			local var_25_8 = 2.28
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
			local var_25_12 = 10.889
			local var_25_13 = manager.audio:GetVoiceLength("story_v_out_109041", "109041007", "story_v_out_109041.awb") / 1000

			if var_25_13 > 0 and var_25_12 < var_25_13 and var_25_13 + var_25_11 > arg_22_1.duration_ then
				local var_25_14 = var_25_13

				arg_22_1.duration_ = var_25_13 + var_25_11
			end

			if var_25_11 < arg_22_1.time_ and arg_22_1.time_ <= var_25_11 + arg_25_0 then
				local var_25_15 = "play"
				local var_25_16 = "voice"

				arg_22_1:AudioAction(var_25_15, var_25_16, "story_v_out_109041", "109041007", "story_v_out_109041.awb")
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play109041008 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 109041008
		arg_26_1.duration_ = 9.8

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play109041010(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = 0

			if var_29_0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_0 + arg_29_0 then
				arg_26_1.var_.oldValueTypewriter = arg_26_1.fswtw_.percent

				SetActive(arg_26_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_26_1:ShowNextGo(false)
			end

			local var_29_1 = 36
			local var_29_2 = 2.16
			local var_29_3 = arg_26_1:GetWordFromCfg(109041001)
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

			local var_29_8 = 2.16
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
			local var_29_12 = 9.804
			local var_29_13 = manager.audio:GetVoiceLength("story_v_out_109041", "109041008", "story_v_out_109041.awb") / 1000

			if var_29_13 > 0 and var_29_12 < var_29_13 and var_29_13 + var_29_11 > arg_26_1.duration_ then
				local var_29_14 = var_29_13

				arg_26_1.duration_ = var_29_13 + var_29_11
			end

			if var_29_11 < arg_26_1.time_ and arg_26_1.time_ <= var_29_11 + arg_29_0 then
				local var_29_15 = "play"
				local var_29_16 = "voice"

				arg_26_1:AudioAction(var_29_15, var_29_16, "story_v_out_109041", "109041008", "story_v_out_109041.awb")
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play109041010 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 109041010
		arg_30_1.duration_ = 4.9

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play109041012(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = 0

			if var_33_0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_0 + arg_33_0 then
				arg_30_1.fswbg_:SetActive(true)
				arg_30_1.dialog_:SetActive(false)

				arg_30_1.fswtw_.percent = 0

				local var_33_1 = arg_30_1:GetWordFromCfg(109041010)
				local var_33_2 = arg_30_1:FormatText(var_33_1.content)

				arg_30_1.fswt_.text = var_33_2

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.fswt_)

				arg_30_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_30_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_30_1.fswtw_:SetDirty()

				arg_30_1.typewritterCharCountI18N = 0

				SetActive(arg_30_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_30_1:ShowNextGo(false)
			end

			local var_33_3 = 0.0166666666666667

			if var_33_3 < arg_30_1.time_ and arg_30_1.time_ <= var_33_3 + arg_33_0 then
				arg_30_1.var_.oldValueTypewriter = arg_30_1.fswtw_.percent

				SetActive(arg_30_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_30_1:ShowNextGo(false)
			end

			local var_33_4 = 18
			local var_33_5 = 1.08
			local var_33_6 = arg_30_1:GetWordFromCfg(109041010)
			local var_33_7 = arg_30_1:FormatText(var_33_6.content)
			local var_33_8, var_33_9 = arg_30_1:GetPercentByPara(var_33_7, 1)

			if var_33_3 < arg_30_1.time_ and arg_30_1.time_ <= var_33_3 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0

				local var_33_10 = var_33_4 <= 0 and var_33_5 or var_33_5 * ((var_33_9 - arg_30_1.typewritterCharCountI18N) / var_33_4)

				if var_33_10 > 0 and var_33_5 < var_33_10 then
					arg_30_1.talkMaxDuration = var_33_10

					if var_33_10 + var_33_3 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_10 + var_33_3
					end
				end
			end

			local var_33_11 = 1.08
			local var_33_12 = math.max(var_33_11, arg_30_1.talkMaxDuration)

			if var_33_3 <= arg_30_1.time_ and arg_30_1.time_ < var_33_3 + var_33_12 then
				local var_33_13 = (arg_30_1.time_ - var_33_3) / var_33_12

				arg_30_1.fswtw_.percent = Mathf.Lerp(arg_30_1.var_.oldValueTypewriter, var_33_8, var_33_13)
				arg_30_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_30_1.fswtw_:SetDirty()
			end

			if arg_30_1.time_ >= var_33_3 + var_33_12 and arg_30_1.time_ < var_33_3 + var_33_12 + arg_33_0 then
				arg_30_1.fswtw_.percent = var_33_8

				arg_30_1.fswtw_:SetDirty()
				arg_30_1:ShowNextGo(true)

				arg_30_1.typewritterCharCountI18N = var_33_9
			end

			local var_33_14 = 0
			local var_33_15 = 4.899
			local var_33_16 = manager.audio:GetVoiceLength("story_v_out_109041", "109041010", "story_v_out_109041.awb") / 1000

			if var_33_16 > 0 and var_33_15 < var_33_16 and var_33_16 + var_33_14 > arg_30_1.duration_ then
				local var_33_17 = var_33_16

				arg_30_1.duration_ = var_33_16 + var_33_14
			end

			if var_33_14 < arg_30_1.time_ and arg_30_1.time_ <= var_33_14 + arg_33_0 then
				local var_33_18 = "play"
				local var_33_19 = "voice"

				arg_30_1:AudioAction(var_33_18, var_33_19, "story_v_out_109041", "109041010", "story_v_out_109041.awb")
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play109041012 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 109041012
		arg_34_1.duration_ = 12.38

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play109041013(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = 0

			if var_37_0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_0 + arg_37_0 then
				arg_34_1.var_.oldValueTypewriter = arg_34_1.fswtw_.percent

				SetActive(arg_34_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_34_1:ShowNextGo(false)
			end

			local var_37_1 = 50
			local var_37_2 = 3
			local var_37_3 = arg_34_1:GetWordFromCfg(109041010)
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

			local var_37_8 = 3
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
			local var_37_12 = 12.377
			local var_37_13 = manager.audio:GetVoiceLength("story_v_out_109041", "109041012", "story_v_out_109041.awb") / 1000

			if var_37_13 > 0 and var_37_12 < var_37_13 and var_37_13 + var_37_11 > arg_34_1.duration_ then
				local var_37_14 = var_37_13

				arg_34_1.duration_ = var_37_13 + var_37_11
			end

			if var_37_11 < arg_34_1.time_ and arg_34_1.time_ <= var_37_11 + arg_37_0 then
				local var_37_15 = "play"
				local var_37_16 = "voice"

				arg_34_1:AudioAction(var_37_15, var_37_16, "story_v_out_109041", "109041012", "story_v_out_109041.awb")
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play109041013 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 109041013
		arg_38_1.duration_ = 12.06

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play109041014(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = 0

			if var_41_0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_0 + arg_41_0 then
				arg_38_1.var_.oldValueTypewriter = arg_38_1.fswtw_.percent

				SetActive(arg_38_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_38_1:ShowNextGo(false)
			end

			local var_41_1 = 47
			local var_41_2 = 2.82
			local var_41_3 = arg_38_1:GetWordFromCfg(109041010)
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

			local var_41_8 = 2.82
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
			local var_41_12 = 12.063
			local var_41_13 = manager.audio:GetVoiceLength("story_v_out_109041", "109041013", "story_v_out_109041.awb") / 1000

			if var_41_13 > 0 and var_41_12 < var_41_13 and var_41_13 + var_41_11 > arg_38_1.duration_ then
				local var_41_14 = var_41_13

				arg_38_1.duration_ = var_41_13 + var_41_11
			end

			if var_41_11 < arg_38_1.time_ and arg_38_1.time_ <= var_41_11 + arg_41_0 then
				local var_41_15 = "play"
				local var_41_16 = "voice"

				arg_38_1:AudioAction(var_41_15, var_41_16, "story_v_out_109041", "109041013", "story_v_out_109041.awb")
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play109041014 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 109041014
		arg_42_1.duration_ = 14.49

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play109041016(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = 0

			if var_45_0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_0 + arg_45_0 then
				arg_42_1.var_.oldValueTypewriter = arg_42_1.fswtw_.percent

				SetActive(arg_42_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_42_1:ShowNextGo(false)
			end

			local var_45_1 = 57
			local var_45_2 = 3.42
			local var_45_3 = arg_42_1:GetWordFromCfg(109041010)
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

			local var_45_8 = 3.42
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
			local var_45_12 = 14.489
			local var_45_13 = manager.audio:GetVoiceLength("story_v_out_109041", "109041014", "story_v_out_109041.awb") / 1000

			if var_45_13 > 0 and var_45_12 < var_45_13 and var_45_13 + var_45_11 > arg_42_1.duration_ then
				local var_45_14 = var_45_13

				arg_42_1.duration_ = var_45_13 + var_45_11
			end

			if var_45_11 < arg_42_1.time_ and arg_42_1.time_ <= var_45_11 + arg_45_0 then
				local var_45_15 = "play"
				local var_45_16 = "voice"

				arg_42_1:AudioAction(var_45_15, var_45_16, "story_v_out_109041", "109041014", "story_v_out_109041.awb")
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play109041016 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 109041016
		arg_46_1.duration_ = 3.6

		local var_46_0 = {
			ja = 3.5,
			ko = 3.533,
			zh = 3.4,
			en = 3.6
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
				arg_46_0:Play109041017(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = "ST06a"

			if arg_46_1.bgs_[var_49_0] == nil then
				local var_49_1 = Object.Instantiate(arg_46_1.paintGo_)

				var_49_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_49_0)
				var_49_1.name = var_49_0
				var_49_1.transform.parent = arg_46_1.stage_.transform
				var_49_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_46_1.bgs_[var_49_0] = var_49_1
			end

			local var_49_2 = 0

			if var_49_2 < arg_46_1.time_ and arg_46_1.time_ <= var_49_2 + arg_49_0 then
				local var_49_3 = manager.ui.mainCamera.transform.localPosition
				local var_49_4 = Vector3.New(0, 0, 10) + Vector3.New(var_49_3.x, var_49_3.y, 0)
				local var_49_5 = arg_46_1.bgs_.ST06a

				var_49_5.transform.localPosition = var_49_4
				var_49_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_49_6 = var_49_5:GetComponent("SpriteRenderer")

				if var_49_6 and var_49_6.sprite then
					local var_49_7 = (var_49_5.transform.localPosition - var_49_3).z
					local var_49_8 = manager.ui.mainCameraCom_
					local var_49_9 = 2 * var_49_7 * Mathf.Tan(var_49_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_49_10 = var_49_9 * var_49_8.aspect
					local var_49_11 = var_49_6.sprite.bounds.size.x
					local var_49_12 = var_49_6.sprite.bounds.size.y
					local var_49_13 = var_49_10 / var_49_11
					local var_49_14 = var_49_9 / var_49_12
					local var_49_15 = var_49_14 < var_49_13 and var_49_13 or var_49_14

					var_49_5.transform.localScale = Vector3.New(var_49_15, var_49_15, 0)
				end

				for iter_49_0, iter_49_1 in pairs(arg_46_1.bgs_) do
					if iter_49_0 ~= "ST06a" then
						iter_49_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_49_16 = arg_46_1.bgs_.ST06a
			local var_49_17 = 0

			if var_49_17 < arg_46_1.time_ and arg_46_1.time_ <= var_49_17 + arg_49_0 then
				local var_49_18 = var_49_16:GetComponent("SpriteRenderer")

				if var_49_18 then
					arg_46_1.var_.alphaOldValueST06a = var_49_18.color.a
					arg_46_1.var_.alphaMatValueST06a = var_49_18
				end

				arg_46_1.var_.alphaOldValueST06a = 0
			end

			local var_49_19 = 1.5

			if var_49_17 <= arg_46_1.time_ and arg_46_1.time_ < var_49_17 + var_49_19 then
				local var_49_20 = (arg_46_1.time_ - var_49_17) / var_49_19
				local var_49_21 = Mathf.Lerp(arg_46_1.var_.alphaOldValueST06a, 1, var_49_20)

				if arg_46_1.var_.alphaMatValueST06a then
					local var_49_22 = arg_46_1.var_.alphaMatValueST06a.color

					var_49_22.a = var_49_21
					arg_46_1.var_.alphaMatValueST06a.color = var_49_22
				end
			end

			if arg_46_1.time_ >= var_49_17 + var_49_19 and arg_46_1.time_ < var_49_17 + var_49_19 + arg_49_0 and arg_46_1.var_.alphaMatValueST06a then
				local var_49_23 = arg_46_1.var_.alphaMatValueST06a
				local var_49_24 = var_49_23.color

				var_49_24.a = 1
				var_49_23.color = var_49_24
			end

			local var_49_25 = 0

			if var_49_25 < arg_46_1.time_ and arg_46_1.time_ <= var_49_25 + arg_49_0 then
				arg_46_1.fswbg_:SetActive(false)
				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_46_1:ShowNextGo(false)
			end

			local var_49_26 = 0
			local var_49_27 = 2.05

			if var_49_26 < arg_46_1.time_ and arg_46_1.time_ <= var_49_26 + arg_49_0 then
				local var_49_28 = "stop"
				local var_49_29 = "music"

				arg_46_1:AudioAction(var_49_28, var_49_29, "se_story_9", "se_story_9_fire_environment_loop", "")

				local var_49_30 = ""
				local var_49_31 = manager.audio:GetAudioName("se_story_9", "se_story_9_fire_environment_loop")

				if var_49_31 ~= "" then
					if arg_46_1.bgmTxt_.text ~= var_49_31 and arg_46_1.bgmTxt_.text ~= "" then
						if arg_46_1.bgmTxt2_.text ~= "" then
							arg_46_1.bgmTxt_.text = arg_46_1.bgmTxt2_.text
						end

						arg_46_1.bgmTxt2_.text = var_49_31

						arg_46_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_46_1.bgmTxt_.text = var_49_31
						arg_46_1.bgmTxt2_.text = var_49_31
					end

					if arg_46_1.bgmTimer then
						arg_46_1.bgmTimer:Stop()

						arg_46_1.bgmTimer = nil
					end

					if arg_46_1.settingData.show_music_name == 1 then
						arg_46_1.musicController:SetSelectedState("show")
						arg_46_1.musicAnimator_:Play("open", 0, 0)

						if arg_46_1.settingData.music_time ~= 0 then
							arg_46_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_46_1.settingData.music_time), function()
								if arg_46_1 == nil or isNil(arg_46_1.bgmTxt_) then
									return
								end

								arg_46_1.musicController:SetSelectedState("hide")
								arg_46_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_46_1.frameCnt_ <= 1 then
				arg_46_1.dialog_:SetActive(false)
			end

			local var_49_32 = 2
			local var_49_33 = 0.05

			if var_49_32 < arg_46_1.time_ and arg_46_1.time_ <= var_49_32 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0

				arg_46_1.dialog_:SetActive(true)

				arg_46_1.dialogCg_.alpha = 0

				local var_49_34 = LeanTween.value(arg_46_1.dialog_, 0, 1, 0.3)

				var_49_34:setOnUpdate(LuaHelper.FloatAction(function(arg_51_0)
					arg_46_1.dialogCg_.alpha = arg_51_0
				end))
				var_49_34:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_46_1.dialog_)
					var_49_34:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_46_1.duration_ = arg_46_1.duration_ + 0.3

				SetActive(arg_46_1.leftNameGo_, true)

				local var_49_35 = arg_46_1:FormatText(StoryNameCfg[99].name)

				arg_46_1.leftNameTxt_.text = var_49_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, true)
				arg_46_1.iconController_:SetSelectedState("hero")

				arg_46_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_46_1.callingController_:SetSelectedState("normal")

				arg_46_1.keyicon_.color = Color.New(1, 1, 1)
				arg_46_1.icon_.color = Color.New(1, 1, 1)

				local var_49_36 = arg_46_1:GetWordFromCfg(109041016)
				local var_49_37 = arg_46_1:FormatText(var_49_36.content)

				arg_46_1.text_.text = var_49_37

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_38 = 2
				local var_49_39 = utf8.len(var_49_37)
				local var_49_40 = var_49_38 <= 0 and var_49_33 or var_49_33 * (var_49_39 / var_49_38)

				if var_49_40 > 0 and var_49_33 < var_49_40 then
					arg_46_1.talkMaxDuration = var_49_40
					var_49_32 = var_49_32 + 0.3

					if var_49_40 + var_49_32 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_40 + var_49_32
					end
				end

				arg_46_1.text_.text = var_49_37
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109041", "109041016", "story_v_out_109041.awb") ~= 0 then
					local var_49_41 = manager.audio:GetVoiceLength("story_v_out_109041", "109041016", "story_v_out_109041.awb") / 1000

					if var_49_41 + var_49_32 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_41 + var_49_32
					end

					if var_49_36.prefab_name ~= "" and arg_46_1.actors_[var_49_36.prefab_name] ~= nil then
						local var_49_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_36.prefab_name].transform, "story_v_out_109041", "109041016", "story_v_out_109041.awb")

						arg_46_1:RecordAudio("109041016", var_49_42)
						arg_46_1:RecordAudio("109041016", var_49_42)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_109041", "109041016", "story_v_out_109041.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_109041", "109041016", "story_v_out_109041.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_43 = var_49_32 + 0.3
			local var_49_44 = math.max(var_49_33, arg_46_1.talkMaxDuration)

			if var_49_43 <= arg_46_1.time_ and arg_46_1.time_ < var_49_43 + var_49_44 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_43) / var_49_44

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_43 + var_49_44 and arg_46_1.time_ < var_49_43 + var_49_44 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play109041017 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 109041017
		arg_53_1.duration_ = 4.73

		local var_53_0 = {
			ja = 4.7,
			ko = 4.733,
			zh = 4,
			en = 4.566
		}
		local var_53_1 = manager.audio:GetLocalizationFlag()

		if var_53_0[var_53_1] ~= nil then
			arg_53_1.duration_ = var_53_0[var_53_1]
		end

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play109041018(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0
			local var_56_1 = 0.45

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_2 = arg_53_1:FormatText(StoryNameCfg[99].name)

				arg_53_1.leftNameTxt_.text = var_56_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_3 = arg_53_1:GetWordFromCfg(109041017)
				local var_56_4 = arg_53_1:FormatText(var_56_3.content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 18
				local var_56_6 = utf8.len(var_56_4)
				local var_56_7 = var_56_5 <= 0 and var_56_1 or var_56_1 * (var_56_6 / var_56_5)

				if var_56_7 > 0 and var_56_1 < var_56_7 then
					arg_53_1.talkMaxDuration = var_56_7

					if var_56_7 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_0
					end
				end

				arg_53_1.text_.text = var_56_4
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109041", "109041017", "story_v_out_109041.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_out_109041", "109041017", "story_v_out_109041.awb") / 1000

					if var_56_8 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_0
					end

					if var_56_3.prefab_name ~= "" and arg_53_1.actors_[var_56_3.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_3.prefab_name].transform, "story_v_out_109041", "109041017", "story_v_out_109041.awb")

						arg_53_1:RecordAudio("109041017", var_56_9)
						arg_53_1:RecordAudio("109041017", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_109041", "109041017", "story_v_out_109041.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_109041", "109041017", "story_v_out_109041.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_10 = math.max(var_56_1, arg_53_1.talkMaxDuration)

			if var_56_0 <= arg_53_1.time_ and arg_53_1.time_ < var_56_0 + var_56_10 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_0) / var_56_10

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_0 + var_56_10 and arg_53_1.time_ < var_56_0 + var_56_10 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play109041018 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 109041018
		arg_57_1.duration_ = 16.43

		local var_57_0 = {
			ja = 16.433,
			ko = 13.133,
			zh = 11.566,
			en = 10.5
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
				arg_57_0:Play109041019(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0
			local var_60_1 = 1.325

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_2 = arg_57_1:FormatText(StoryNameCfg[99].name)

				arg_57_1.leftNameTxt_.text = var_60_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_3 = arg_57_1:GetWordFromCfg(109041018)
				local var_60_4 = arg_57_1:FormatText(var_60_3.content)

				arg_57_1.text_.text = var_60_4

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 53
				local var_60_6 = utf8.len(var_60_4)
				local var_60_7 = var_60_5 <= 0 and var_60_1 or var_60_1 * (var_60_6 / var_60_5)

				if var_60_7 > 0 and var_60_1 < var_60_7 then
					arg_57_1.talkMaxDuration = var_60_7

					if var_60_7 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_7 + var_60_0
					end
				end

				arg_57_1.text_.text = var_60_4
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109041", "109041018", "story_v_out_109041.awb") ~= 0 then
					local var_60_8 = manager.audio:GetVoiceLength("story_v_out_109041", "109041018", "story_v_out_109041.awb") / 1000

					if var_60_8 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_8 + var_60_0
					end

					if var_60_3.prefab_name ~= "" and arg_57_1.actors_[var_60_3.prefab_name] ~= nil then
						local var_60_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_3.prefab_name].transform, "story_v_out_109041", "109041018", "story_v_out_109041.awb")

						arg_57_1:RecordAudio("109041018", var_60_9)
						arg_57_1:RecordAudio("109041018", var_60_9)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_109041", "109041018", "story_v_out_109041.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_109041", "109041018", "story_v_out_109041.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_10 = math.max(var_60_1, arg_57_1.talkMaxDuration)

			if var_60_0 <= arg_57_1.time_ and arg_57_1.time_ < var_60_0 + var_60_10 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_0) / var_60_10

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_0 + var_60_10 and arg_57_1.time_ < var_60_0 + var_60_10 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play109041019 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 109041019
		arg_61_1.duration_ = 13.13

		local var_61_0 = {
			ja = 13.133,
			ko = 6.966,
			zh = 8.2,
			en = 7.3
		}
		local var_61_1 = manager.audio:GetLocalizationFlag()

		if var_61_0[var_61_1] ~= nil then
			arg_61_1.duration_ = var_61_0[var_61_1]
		end

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play109041020(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = "3004_tpose"

			if arg_61_1.actors_[var_64_0] == nil then
				local var_64_1 = Asset.Load("Char/" .. "3004_tpose")

				if not isNil(var_64_1) then
					local var_64_2 = Object.Instantiate(Asset.Load("Char/" .. "3004_tpose"), arg_61_1.stage_.transform)

					var_64_2.name = var_64_0
					var_64_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_61_1.actors_[var_64_0] = var_64_2

					local var_64_3 = var_64_2:GetComponentInChildren(typeof(CharacterEffect))

					var_64_3.enabled = true

					local var_64_4 = GameObjectTools.GetOrAddComponent(var_64_2, typeof(DynamicBoneHelper))

					if var_64_4 then
						var_64_4:EnableDynamicBone(false)
					end

					arg_61_1:ShowWeapon(var_64_3.transform, false)

					arg_61_1.var_[var_64_0 .. "Animator"] = var_64_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_61_1.var_[var_64_0 .. "Animator"].applyRootMotion = true
					arg_61_1.var_[var_64_0 .. "LipSync"] = var_64_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_64_5 = arg_61_1.actors_["3004_tpose"].transform
			local var_64_6 = 0

			if var_64_6 < arg_61_1.time_ and arg_61_1.time_ <= var_64_6 + arg_64_0 then
				arg_61_1.var_.moveOldPos3004_tpose = var_64_5.localPosition

				local var_64_7 = GameObjectTools.GetOrAddComponent(var_64_5.gameObject, typeof(DynamicBoneHelper))

				if var_64_7 then
					var_64_7:EnableDynamicBone(false)
				end
			end

			local var_64_8 = 0.001

			if var_64_6 <= arg_61_1.time_ and arg_61_1.time_ < var_64_6 + var_64_8 then
				local var_64_9 = (arg_61_1.time_ - var_64_6) / var_64_8
				local var_64_10 = Vector3.New(0, -2.22, -3.1)

				var_64_5.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos3004_tpose, var_64_10, var_64_9)

				local var_64_11 = manager.ui.mainCamera.transform.position - var_64_5.position

				var_64_5.forward = Vector3.New(var_64_11.x, var_64_11.y, var_64_11.z)

				local var_64_12 = var_64_5.localEulerAngles

				var_64_12.z = 0
				var_64_12.x = 0
				var_64_5.localEulerAngles = var_64_12
			end

			if arg_61_1.time_ >= var_64_6 + var_64_8 and arg_61_1.time_ < var_64_6 + var_64_8 + arg_64_0 then
				var_64_5.localPosition = Vector3.New(0, -2.22, -3.1)

				local var_64_13 = manager.ui.mainCamera.transform.position - var_64_5.position

				var_64_5.forward = Vector3.New(var_64_13.x, var_64_13.y, var_64_13.z)

				local var_64_14 = var_64_5.localEulerAngles

				var_64_14.z = 0
				var_64_14.x = 0
				var_64_5.localEulerAngles = var_64_14

				local var_64_15 = GameObjectTools.GetOrAddComponent(var_64_5.gameObject, typeof(DynamicBoneHelper))

				if var_64_15 then
					var_64_15:EnableDynamicBone(true)
				end
			end

			local var_64_16 = arg_61_1.actors_["3004_tpose"]
			local var_64_17 = 0

			if var_64_17 < arg_61_1.time_ and arg_61_1.time_ <= var_64_17 + arg_64_0 and not isNil(var_64_16) and arg_61_1.var_.characterEffect3004_tpose == nil then
				arg_61_1.var_.characterEffect3004_tpose = var_64_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_18 = 0.2

			if var_64_17 <= arg_61_1.time_ and arg_61_1.time_ < var_64_17 + var_64_18 and not isNil(var_64_16) then
				local var_64_19 = (arg_61_1.time_ - var_64_17) / var_64_18

				if arg_61_1.var_.characterEffect3004_tpose and not isNil(var_64_16) then
					arg_61_1.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if arg_61_1.time_ >= var_64_17 + var_64_18 and arg_61_1.time_ < var_64_17 + var_64_18 + arg_64_0 and not isNil(var_64_16) and arg_61_1.var_.characterEffect3004_tpose then
				arg_61_1.var_.characterEffect3004_tpose.fillFlat = false
			end

			local var_64_20 = 0

			if var_64_20 < arg_61_1.time_ and arg_61_1.time_ <= var_64_20 + arg_64_0 then
				arg_61_1:PlayTimeline("3004_tpose", "StoryTimeline/CharAction/story3004/story3004action/3004action1_1")
			end

			local var_64_21 = 0
			local var_64_22 = 0.875

			if var_64_21 < arg_61_1.time_ and arg_61_1.time_ <= var_64_21 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_23 = arg_61_1:FormatText(StoryNameCfg[82].name)

				arg_61_1.leftNameTxt_.text = var_64_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_24 = arg_61_1:GetWordFromCfg(109041019)
				local var_64_25 = arg_61_1:FormatText(var_64_24.content)

				arg_61_1.text_.text = var_64_25

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_26 = 35
				local var_64_27 = utf8.len(var_64_25)
				local var_64_28 = var_64_26 <= 0 and var_64_22 or var_64_22 * (var_64_27 / var_64_26)

				if var_64_28 > 0 and var_64_22 < var_64_28 then
					arg_61_1.talkMaxDuration = var_64_28

					if var_64_28 + var_64_21 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_28 + var_64_21
					end
				end

				arg_61_1.text_.text = var_64_25
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109041", "109041019", "story_v_out_109041.awb") ~= 0 then
					local var_64_29 = manager.audio:GetVoiceLength("story_v_out_109041", "109041019", "story_v_out_109041.awb") / 1000

					if var_64_29 + var_64_21 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_29 + var_64_21
					end

					if var_64_24.prefab_name ~= "" and arg_61_1.actors_[var_64_24.prefab_name] ~= nil then
						local var_64_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_24.prefab_name].transform, "story_v_out_109041", "109041019", "story_v_out_109041.awb")

						arg_61_1:RecordAudio("109041019", var_64_30)
						arg_61_1:RecordAudio("109041019", var_64_30)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_109041", "109041019", "story_v_out_109041.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_109041", "109041019", "story_v_out_109041.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_31 = math.max(var_64_22, arg_61_1.talkMaxDuration)

			if var_64_21 <= arg_61_1.time_ and arg_61_1.time_ < var_64_21 + var_64_31 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_21) / var_64_31

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_21 + var_64_31 and arg_61_1.time_ < var_64_21 + var_64_31 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3004_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play109041020 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 109041020
		arg_65_1.duration_ = 7.5

		local var_65_0 = {
			ja = 4.666,
			ko = 7.5,
			zh = 6,
			en = 6.866
		}
		local var_65_1 = manager.audio:GetLocalizationFlag()

		if var_65_0[var_65_1] ~= nil then
			arg_65_1.duration_ = var_65_0[var_65_1]
		end

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play109041021(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["3004_tpose"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect3004_tpose == nil then
				arg_65_1.var_.characterEffect3004_tpose = var_68_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.2

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.characterEffect3004_tpose and not isNil(var_68_0) then
					local var_68_4 = Mathf.Lerp(0, 0.5, var_68_3)

					arg_65_1.var_.characterEffect3004_tpose.fillFlat = true
					arg_65_1.var_.characterEffect3004_tpose.fillRatio = var_68_4
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect3004_tpose then
				local var_68_5 = 0.5

				arg_65_1.var_.characterEffect3004_tpose.fillFlat = true
				arg_65_1.var_.characterEffect3004_tpose.fillRatio = var_68_5
			end

			local var_68_6 = 0
			local var_68_7 = 0.725

			if var_68_6 < arg_65_1.time_ and arg_65_1.time_ <= var_68_6 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_8 = arg_65_1:FormatText(StoryNameCfg[99].name)

				arg_65_1.leftNameTxt_.text = var_68_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_9 = arg_65_1:GetWordFromCfg(109041020)
				local var_68_10 = arg_65_1:FormatText(var_68_9.content)

				arg_65_1.text_.text = var_68_10

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_11 = 29
				local var_68_12 = utf8.len(var_68_10)
				local var_68_13 = var_68_11 <= 0 and var_68_7 or var_68_7 * (var_68_12 / var_68_11)

				if var_68_13 > 0 and var_68_7 < var_68_13 then
					arg_65_1.talkMaxDuration = var_68_13

					if var_68_13 + var_68_6 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_13 + var_68_6
					end
				end

				arg_65_1.text_.text = var_68_10
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109041", "109041020", "story_v_out_109041.awb") ~= 0 then
					local var_68_14 = manager.audio:GetVoiceLength("story_v_out_109041", "109041020", "story_v_out_109041.awb") / 1000

					if var_68_14 + var_68_6 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_14 + var_68_6
					end

					if var_68_9.prefab_name ~= "" and arg_65_1.actors_[var_68_9.prefab_name] ~= nil then
						local var_68_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_9.prefab_name].transform, "story_v_out_109041", "109041020", "story_v_out_109041.awb")

						arg_65_1:RecordAudio("109041020", var_68_15)
						arg_65_1:RecordAudio("109041020", var_68_15)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_109041", "109041020", "story_v_out_109041.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_109041", "109041020", "story_v_out_109041.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_16 = math.max(var_68_7, arg_65_1.talkMaxDuration)

			if var_68_6 <= arg_65_1.time_ and arg_65_1.time_ < var_68_6 + var_68_16 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_6) / var_68_16

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_6 + var_68_16 and arg_65_1.time_ < var_68_6 + var_68_16 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play109041021 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 109041021
		arg_69_1.duration_ = 14.27

		local var_69_0 = {
			ja = 14.266,
			ko = 4.3,
			zh = 5.466,
			en = 5.033
		}
		local var_69_1 = manager.audio:GetLocalizationFlag()

		if var_69_0[var_69_1] ~= nil then
			arg_69_1.duration_ = var_69_0[var_69_1]
		end

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play109041022(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0
			local var_72_1 = 0.525

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_2 = arg_69_1:FormatText(StoryNameCfg[99].name)

				arg_69_1.leftNameTxt_.text = var_72_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_3 = arg_69_1:GetWordFromCfg(109041021)
				local var_72_4 = arg_69_1:FormatText(var_72_3.content)

				arg_69_1.text_.text = var_72_4

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 21
				local var_72_6 = utf8.len(var_72_4)
				local var_72_7 = var_72_5 <= 0 and var_72_1 or var_72_1 * (var_72_6 / var_72_5)

				if var_72_7 > 0 and var_72_1 < var_72_7 then
					arg_69_1.talkMaxDuration = var_72_7

					if var_72_7 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_7 + var_72_0
					end
				end

				arg_69_1.text_.text = var_72_4
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109041", "109041021", "story_v_out_109041.awb") ~= 0 then
					local var_72_8 = manager.audio:GetVoiceLength("story_v_out_109041", "109041021", "story_v_out_109041.awb") / 1000

					if var_72_8 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_8 + var_72_0
					end

					if var_72_3.prefab_name ~= "" and arg_69_1.actors_[var_72_3.prefab_name] ~= nil then
						local var_72_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_3.prefab_name].transform, "story_v_out_109041", "109041021", "story_v_out_109041.awb")

						arg_69_1:RecordAudio("109041021", var_72_9)
						arg_69_1:RecordAudio("109041021", var_72_9)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_109041", "109041021", "story_v_out_109041.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_109041", "109041021", "story_v_out_109041.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_10 = math.max(var_72_1, arg_69_1.talkMaxDuration)

			if var_72_0 <= arg_69_1.time_ and arg_69_1.time_ < var_72_0 + var_72_10 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_0) / var_72_10

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_0 + var_72_10 and arg_69_1.time_ < var_72_0 + var_72_10 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play109041022 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 109041022
		arg_73_1.duration_ = 14.53

		local var_73_0 = {
			ja = 13.5,
			ko = 9.033,
			zh = 10,
			en = 14.533
		}
		local var_73_1 = manager.audio:GetLocalizationFlag()

		if var_73_0[var_73_1] ~= nil then
			arg_73_1.duration_ = var_73_0[var_73_1]
		end

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play109041023(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0
			local var_76_1 = 1.05

			if var_76_0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_2 = arg_73_1:FormatText(StoryNameCfg[99].name)

				arg_73_1.leftNameTxt_.text = var_76_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_3 = arg_73_1:GetWordFromCfg(109041022)
				local var_76_4 = arg_73_1:FormatText(var_76_3.content)

				arg_73_1.text_.text = var_76_4

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_5 = 42
				local var_76_6 = utf8.len(var_76_4)
				local var_76_7 = var_76_5 <= 0 and var_76_1 or var_76_1 * (var_76_6 / var_76_5)

				if var_76_7 > 0 and var_76_1 < var_76_7 then
					arg_73_1.talkMaxDuration = var_76_7

					if var_76_7 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_7 + var_76_0
					end
				end

				arg_73_1.text_.text = var_76_4
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109041", "109041022", "story_v_out_109041.awb") ~= 0 then
					local var_76_8 = manager.audio:GetVoiceLength("story_v_out_109041", "109041022", "story_v_out_109041.awb") / 1000

					if var_76_8 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_8 + var_76_0
					end

					if var_76_3.prefab_name ~= "" and arg_73_1.actors_[var_76_3.prefab_name] ~= nil then
						local var_76_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_3.prefab_name].transform, "story_v_out_109041", "109041022", "story_v_out_109041.awb")

						arg_73_1:RecordAudio("109041022", var_76_9)
						arg_73_1:RecordAudio("109041022", var_76_9)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_109041", "109041022", "story_v_out_109041.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_109041", "109041022", "story_v_out_109041.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_10 = math.max(var_76_1, arg_73_1.talkMaxDuration)

			if var_76_0 <= arg_73_1.time_ and arg_73_1.time_ < var_76_0 + var_76_10 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_0) / var_76_10

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_0 + var_76_10 and arg_73_1.time_ < var_76_0 + var_76_10 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play109041023 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 109041023
		arg_77_1.duration_ = 5.03

		local var_77_0 = {
			ja = 1.3,
			ko = 1.466,
			zh = 5.033,
			en = 2.266
		}
		local var_77_1 = manager.audio:GetLocalizationFlag()

		if var_77_0[var_77_1] ~= nil then
			arg_77_1.duration_ = var_77_0[var_77_1]
		end

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play109041024(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["3004_tpose"]
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect3004_tpose == nil then
				arg_77_1.var_.characterEffect3004_tpose = var_80_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.2

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 and not isNil(var_80_0) then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2

				if arg_77_1.var_.characterEffect3004_tpose and not isNil(var_80_0) then
					arg_77_1.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect3004_tpose then
				arg_77_1.var_.characterEffect3004_tpose.fillFlat = false
			end

			local var_80_4 = 0
			local var_80_5 = 0.05

			if var_80_4 < arg_77_1.time_ and arg_77_1.time_ <= var_80_4 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_6 = arg_77_1:FormatText(StoryNameCfg[82].name)

				arg_77_1.leftNameTxt_.text = var_80_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_7 = arg_77_1:GetWordFromCfg(109041023)
				local var_80_8 = arg_77_1:FormatText(var_80_7.content)

				arg_77_1.text_.text = var_80_8

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_9 = 2
				local var_80_10 = utf8.len(var_80_8)
				local var_80_11 = var_80_9 <= 0 and var_80_5 or var_80_5 * (var_80_10 / var_80_9)

				if var_80_11 > 0 and var_80_5 < var_80_11 then
					arg_77_1.talkMaxDuration = var_80_11

					if var_80_11 + var_80_4 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_11 + var_80_4
					end
				end

				arg_77_1.text_.text = var_80_8
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109041", "109041023", "story_v_out_109041.awb") ~= 0 then
					local var_80_12 = manager.audio:GetVoiceLength("story_v_out_109041", "109041023", "story_v_out_109041.awb") / 1000

					if var_80_12 + var_80_4 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_12 + var_80_4
					end

					if var_80_7.prefab_name ~= "" and arg_77_1.actors_[var_80_7.prefab_name] ~= nil then
						local var_80_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_7.prefab_name].transform, "story_v_out_109041", "109041023", "story_v_out_109041.awb")

						arg_77_1:RecordAudio("109041023", var_80_13)
						arg_77_1:RecordAudio("109041023", var_80_13)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_109041", "109041023", "story_v_out_109041.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_109041", "109041023", "story_v_out_109041.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_14 = math.max(var_80_5, arg_77_1.talkMaxDuration)

			if var_80_4 <= arg_77_1.time_ and arg_77_1.time_ < var_80_4 + var_80_14 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_4) / var_80_14

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_4 + var_80_14 and arg_77_1.time_ < var_80_4 + var_80_14 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play109041024 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 109041024
		arg_81_1.duration_ = 10.97

		local var_81_0 = {
			ja = 10.966,
			ko = 6.233,
			zh = 8.233,
			en = 8.8
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
				arg_81_0:Play109041025(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["3004_tpose"]
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect3004_tpose == nil then
				arg_81_1.var_.characterEffect3004_tpose = var_84_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.2

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 and not isNil(var_84_0) then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2

				if arg_81_1.var_.characterEffect3004_tpose and not isNil(var_84_0) then
					local var_84_4 = Mathf.Lerp(0, 0.5, var_84_3)

					arg_81_1.var_.characterEffect3004_tpose.fillFlat = true
					arg_81_1.var_.characterEffect3004_tpose.fillRatio = var_84_4
				end
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect3004_tpose then
				local var_84_5 = 0.5

				arg_81_1.var_.characterEffect3004_tpose.fillFlat = true
				arg_81_1.var_.characterEffect3004_tpose.fillRatio = var_84_5
			end

			local var_84_6 = 0
			local var_84_7 = 0.775

			if var_84_6 < arg_81_1.time_ and arg_81_1.time_ <= var_84_6 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_8 = arg_81_1:FormatText(StoryNameCfg[99].name)

				arg_81_1.leftNameTxt_.text = var_84_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(1, 1, 1)
				arg_81_1.icon_.color = Color.New(1, 1, 1)

				local var_84_9 = arg_81_1:GetWordFromCfg(109041024)
				local var_84_10 = arg_81_1:FormatText(var_84_9.content)

				arg_81_1.text_.text = var_84_10

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_11 = 33
				local var_84_12 = utf8.len(var_84_10)
				local var_84_13 = var_84_11 <= 0 and var_84_7 or var_84_7 * (var_84_12 / var_84_11)

				if var_84_13 > 0 and var_84_7 < var_84_13 then
					arg_81_1.talkMaxDuration = var_84_13

					if var_84_13 + var_84_6 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_13 + var_84_6
					end
				end

				arg_81_1.text_.text = var_84_10
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109041", "109041024", "story_v_out_109041.awb") ~= 0 then
					local var_84_14 = manager.audio:GetVoiceLength("story_v_out_109041", "109041024", "story_v_out_109041.awb") / 1000

					if var_84_14 + var_84_6 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_14 + var_84_6
					end

					if var_84_9.prefab_name ~= "" and arg_81_1.actors_[var_84_9.prefab_name] ~= nil then
						local var_84_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_9.prefab_name].transform, "story_v_out_109041", "109041024", "story_v_out_109041.awb")

						arg_81_1:RecordAudio("109041024", var_84_15)
						arg_81_1:RecordAudio("109041024", var_84_15)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_109041", "109041024", "story_v_out_109041.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_109041", "109041024", "story_v_out_109041.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_16 = math.max(var_84_7, arg_81_1.talkMaxDuration)

			if var_84_6 <= arg_81_1.time_ and arg_81_1.time_ < var_84_6 + var_84_16 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_6) / var_84_16

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_6 + var_84_16 and arg_81_1.time_ < var_84_6 + var_84_16 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play109041025 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 109041025
		arg_85_1.duration_ = 2.43

		local var_85_0 = {
			ja = 1.566,
			ko = 1.366,
			zh = 1.4,
			en = 2.433
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
				arg_85_0:Play109041026(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["3004_tpose"]
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect3004_tpose == nil then
				arg_85_1.var_.characterEffect3004_tpose = var_88_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.2

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 and not isNil(var_88_0) then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2

				if arg_85_1.var_.characterEffect3004_tpose and not isNil(var_88_0) then
					arg_85_1.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect3004_tpose then
				arg_85_1.var_.characterEffect3004_tpose.fillFlat = false
			end

			local var_88_4 = 0
			local var_88_5 = 0.05

			if var_88_4 < arg_85_1.time_ and arg_85_1.time_ <= var_88_4 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_6 = arg_85_1:FormatText(StoryNameCfg[82].name)

				arg_85_1.leftNameTxt_.text = var_88_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_7 = arg_85_1:GetWordFromCfg(109041025)
				local var_88_8 = arg_85_1:FormatText(var_88_7.content)

				arg_85_1.text_.text = var_88_8

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_9 = 2
				local var_88_10 = utf8.len(var_88_8)
				local var_88_11 = var_88_9 <= 0 and var_88_5 or var_88_5 * (var_88_10 / var_88_9)

				if var_88_11 > 0 and var_88_5 < var_88_11 then
					arg_85_1.talkMaxDuration = var_88_11

					if var_88_11 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_11 + var_88_4
					end
				end

				arg_85_1.text_.text = var_88_8
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109041", "109041025", "story_v_out_109041.awb") ~= 0 then
					local var_88_12 = manager.audio:GetVoiceLength("story_v_out_109041", "109041025", "story_v_out_109041.awb") / 1000

					if var_88_12 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_12 + var_88_4
					end

					if var_88_7.prefab_name ~= "" and arg_85_1.actors_[var_88_7.prefab_name] ~= nil then
						local var_88_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_7.prefab_name].transform, "story_v_out_109041", "109041025", "story_v_out_109041.awb")

						arg_85_1:RecordAudio("109041025", var_88_13)
						arg_85_1:RecordAudio("109041025", var_88_13)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_109041", "109041025", "story_v_out_109041.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_109041", "109041025", "story_v_out_109041.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_14 = math.max(var_88_5, arg_85_1.talkMaxDuration)

			if var_88_4 <= arg_85_1.time_ and arg_85_1.time_ < var_88_4 + var_88_14 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_4) / var_88_14

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_4 + var_88_14 and arg_85_1.time_ < var_88_4 + var_88_14 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play109041026 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 109041026
		arg_89_1.duration_ = 5.43

		local var_89_0 = {
			ja = 1.333,
			ko = 4.533,
			zh = 5.433,
			en = 5.4
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
			arg_89_1.auto_ = false
		end

		function arg_89_1.playNext_(arg_91_0)
			arg_89_1.onStoryFinished_()
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0
			local var_92_1 = 0.35

			if var_92_0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_2 = arg_89_1:FormatText(StoryNameCfg[82].name)

				arg_89_1.leftNameTxt_.text = var_92_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_3 = arg_89_1:GetWordFromCfg(109041026)
				local var_92_4 = arg_89_1:FormatText(var_92_3.content)

				arg_89_1.text_.text = var_92_4

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 14
				local var_92_6 = utf8.len(var_92_4)
				local var_92_7 = var_92_5 <= 0 and var_92_1 or var_92_1 * (var_92_6 / var_92_5)

				if var_92_7 > 0 and var_92_1 < var_92_7 then
					arg_89_1.talkMaxDuration = var_92_7

					if var_92_7 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_7 + var_92_0
					end
				end

				arg_89_1.text_.text = var_92_4
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109041", "109041026", "story_v_out_109041.awb") ~= 0 then
					local var_92_8 = manager.audio:GetVoiceLength("story_v_out_109041", "109041026", "story_v_out_109041.awb") / 1000

					if var_92_8 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_8 + var_92_0
					end

					if var_92_3.prefab_name ~= "" and arg_89_1.actors_[var_92_3.prefab_name] ~= nil then
						local var_92_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_3.prefab_name].transform, "story_v_out_109041", "109041026", "story_v_out_109041.awb")

						arg_89_1:RecordAudio("109041026", var_92_9)
						arg_89_1:RecordAudio("109041026", var_92_9)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_109041", "109041026", "story_v_out_109041.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_109041", "109041026", "story_v_out_109041.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_10 = math.max(var_92_1, arg_89_1.talkMaxDuration)

			if var_92_0 <= arg_89_1.time_ and arg_89_1.time_ < var_92_0 + var_92_10 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_0) / var_92_10

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_0 + var_92_10 and arg_89_1.time_ < var_92_0 + var_92_10 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST06a"
	},
	voices = {
		"story_v_out_109041.awb"
	}
}
