return {
	Play111011001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 111011001
		arg_1_1.duration_ = 3.9

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play111011002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				arg_1_1.fswbg_:SetActive(true)
				arg_1_1.dialog_:SetActive(false)

				arg_1_1.fswtw_.percent = 0

				local var_4_1 = arg_1_1:GetWordFromCfg(111011001)
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

			local var_4_3 = 0.366666666666666

			if var_4_3 < arg_1_1.time_ and arg_1_1.time_ <= var_4_3 + arg_4_0 then
				arg_1_1.var_.oldValueTypewriter = arg_1_1.fswtw_.percent

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_4 = 9
			local var_4_5 = 0.54
			local var_4_6 = arg_1_1:GetWordFromCfg(111011001)
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

			local var_4_11 = 0.54
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

				arg_1_1:AudioAction(var_4_16, var_4_17, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_18 = ""
				local var_4_19 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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
			local var_4_21 = 3.9
			local var_4_22 = manager.audio:GetVoiceLength("story_v_out_111011", "111011001", "story_v_out_111011.awb") / 1000

			if var_4_22 > 0 and var_4_21 < var_4_22 and var_4_22 + var_4_20 > arg_1_1.duration_ then
				local var_4_23 = var_4_22

				arg_1_1.duration_ = var_4_22 + var_4_20
			end

			if var_4_20 < arg_1_1.time_ and arg_1_1.time_ <= var_4_20 + arg_4_0 then
				local var_4_24 = "play"
				local var_4_25 = "voice"

				arg_1_1:AudioAction(var_4_24, var_4_25, "story_v_out_111011", "111011001", "story_v_out_111011.awb")
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play111011002 = function(arg_6_0, arg_6_1)
		arg_6_1.time_ = 0
		arg_6_1.frameCnt_ = 0
		arg_6_1.state_ = "playing"
		arg_6_1.curTalkId_ = 111011002
		arg_6_1.duration_ = 1

		SetActive(arg_6_1.tipsGo_, false)

		function arg_6_1.onSingleLineFinish_()
			arg_6_1.onSingleLineUpdate_ = nil
			arg_6_1.onSingleLineFinish_ = nil
			arg_6_1.state_ = "waiting"
		end

		function arg_6_1.playNext_(arg_8_0)
			if arg_8_0 == 1 then
				arg_6_0:Play111011003(arg_6_1)
			end
		end

		function arg_6_1.onSingleLineUpdate_(arg_9_0)
			local var_9_0 = 0

			if var_9_0 < arg_6_1.time_ and arg_6_1.time_ <= var_9_0 + arg_9_0 then
				arg_6_1.var_.oldValueTypewriter = arg_6_1.fswtw_.percent

				SetActive(arg_6_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_6_1:ShowNextGo(false)
			end

			local var_9_1 = 15
			local var_9_2 = 0.9
			local var_9_3 = arg_6_1:GetWordFromCfg(111011001)
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

			local var_9_8 = 0.9
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
			local var_9_12 = 1
			local var_9_13 = manager.audio:GetVoiceLength("story_v_out_111011", "111011002", "story_v_out_111011.awb") / 1000

			if var_9_13 > 0 and var_9_12 < var_9_13 and var_9_13 + var_9_11 > arg_6_1.duration_ then
				local var_9_14 = var_9_13

				arg_6_1.duration_ = var_9_13 + var_9_11
			end

			if var_9_11 < arg_6_1.time_ and arg_6_1.time_ <= var_9_11 + arg_9_0 then
				local var_9_15 = "play"
				local var_9_16 = "voice"

				arg_6_1:AudioAction(var_9_15, var_9_16, "story_v_out_111011", "111011002", "story_v_out_111011.awb")
			end
		end

		arg_6_1.nodeConfigList_ = {}

		arg_6_1:InitPlayNodeList()
	end,
	Play111011003 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 111011003
		arg_10_1.duration_ = 2.16

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play111011004(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			local var_13_0 = 0

			if var_13_0 < arg_10_1.time_ and arg_10_1.time_ <= var_13_0 + arg_13_0 then
				arg_10_1.var_.oldValueTypewriter = arg_10_1.fswtw_.percent

				SetActive(arg_10_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_10_1:ShowNextGo(false)
			end

			local var_13_1 = 32
			local var_13_2 = 2.16
			local var_13_3 = arg_10_1:GetWordFromCfg(111011001)
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

			local var_13_8 = 2.16
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
			local var_13_12 = 1
			local var_13_13 = manager.audio:GetVoiceLength("story_v_out_111011", "111011003", "story_v_out_111011.awb") / 1000

			if var_13_13 > 0 and var_13_12 < var_13_13 and var_13_13 + var_13_11 > arg_10_1.duration_ then
				local var_13_14 = var_13_13

				arg_10_1.duration_ = var_13_13 + var_13_11
			end

			if var_13_11 < arg_10_1.time_ and arg_10_1.time_ <= var_13_11 + arg_13_0 then
				local var_13_15 = "play"
				local var_13_16 = "voice"

				arg_10_1:AudioAction(var_13_15, var_13_16, "story_v_out_111011", "111011003", "story_v_out_111011.awb")
			end
		end

		arg_10_1.nodeConfigList_ = {}

		arg_10_1:InitPlayNodeList()
	end,
	Play111011004 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 111011004
		arg_14_1.duration_ = 1.84

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play111011005(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = 0

			if var_17_0 < arg_14_1.time_ and arg_14_1.time_ <= var_17_0 + arg_17_0 then
				arg_14_1.var_.oldValueTypewriter = arg_14_1.fswtw_.percent

				SetActive(arg_14_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_14_1:ShowNextGo(false)
			end

			local var_17_1 = 26
			local var_17_2 = 1.84
			local var_17_3 = arg_14_1:GetWordFromCfg(111011001)
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

			local var_17_8 = 1.84
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
			local var_17_12 = 1
			local var_17_13 = manager.audio:GetVoiceLength("story_v_out_111011", "111011004", "story_v_out_111011.awb") / 1000

			if var_17_13 > 0 and var_17_12 < var_17_13 and var_17_13 + var_17_11 > arg_14_1.duration_ then
				local var_17_14 = var_17_13

				arg_14_1.duration_ = var_17_13 + var_17_11
			end

			if var_17_11 < arg_14_1.time_ and arg_14_1.time_ <= var_17_11 + arg_17_0 then
				local var_17_15 = "play"
				local var_17_16 = "voice"

				arg_14_1:AudioAction(var_17_15, var_17_16, "story_v_out_111011", "111011004", "story_v_out_111011.awb")
			end
		end

		arg_14_1.nodeConfigList_ = {}

		arg_14_1:InitPlayNodeList()
	end,
	Play111011005 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 111011005
		arg_18_1.duration_ = 1.38

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play111011006(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = 0

			if var_21_0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_0 + arg_21_0 then
				arg_18_1.var_.oldValueTypewriter = arg_18_1.fswtw_.percent

				SetActive(arg_18_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_18_1:ShowNextGo(false)
			end

			local var_21_1 = 23
			local var_21_2 = 1.38
			local var_21_3 = arg_18_1:GetWordFromCfg(111011001)
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

			local var_21_8 = 1.38
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
			local var_21_12 = 1
			local var_21_13 = manager.audio:GetVoiceLength("story_v_out_111011", "111011005", "story_v_out_111011.awb") / 1000

			if var_21_13 > 0 and var_21_12 < var_21_13 and var_21_13 + var_21_11 > arg_18_1.duration_ then
				local var_21_14 = var_21_13

				arg_18_1.duration_ = var_21_13 + var_21_11
			end

			if var_21_11 < arg_18_1.time_ and arg_18_1.time_ <= var_21_11 + arg_21_0 then
				local var_21_15 = "play"
				local var_21_16 = "voice"

				arg_18_1:AudioAction(var_21_15, var_21_16, "story_v_out_111011", "111011005", "story_v_out_111011.awb")
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play111011006 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 111011006
		arg_22_1.duration_ = 7.1

		local var_22_0 = {
			ja = 5.066,
			ko = 4.266,
			zh = 5.9,
			en = 7.1
		}
		local var_22_1 = manager.audio:GetLocalizationFlag()

		if var_22_0[var_22_1] ~= nil then
			arg_22_1.duration_ = var_22_0[var_22_1]
		end

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play111011007(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = "D999"

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
				local var_25_5 = arg_22_1.bgs_.D999

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
					if iter_25_0 ~= "D999" then
						iter_25_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_25_16 = arg_22_1.bgs_.D999
			local var_25_17 = 0

			if var_25_17 < arg_22_1.time_ and arg_22_1.time_ <= var_25_17 + arg_25_0 then
				local var_25_18 = var_25_16:GetComponent("SpriteRenderer")

				if var_25_18 then
					arg_22_1.var_.alphaOldValueD999 = var_25_18.color.a
					arg_22_1.var_.alphaMatValueD999 = var_25_18
				end

				arg_22_1.var_.alphaOldValueD999 = 0
			end

			local var_25_19 = 1.5

			if var_25_17 <= arg_22_1.time_ and arg_22_1.time_ < var_25_17 + var_25_19 then
				local var_25_20 = (arg_22_1.time_ - var_25_17) / var_25_19
				local var_25_21 = Mathf.Lerp(arg_22_1.var_.alphaOldValueD999, 1, var_25_20)

				if arg_22_1.var_.alphaMatValueD999 then
					local var_25_22 = arg_22_1.var_.alphaMatValueD999.color

					var_25_22.a = var_25_21
					arg_22_1.var_.alphaMatValueD999.color = var_25_22
				end
			end

			if arg_22_1.time_ >= var_25_17 + var_25_19 and arg_22_1.time_ < var_25_17 + var_25_19 + arg_25_0 and arg_22_1.var_.alphaMatValueD999 then
				local var_25_23 = arg_22_1.var_.alphaMatValueD999
				local var_25_24 = var_25_23.color

				var_25_24.a = 1
				var_25_23.color = var_25_24
			end

			local var_25_25 = 0

			if var_25_25 < arg_22_1.time_ and arg_22_1.time_ <= var_25_25 + arg_25_0 then
				arg_22_1.allBtn_.enabled = false
			end

			local var_25_26 = 1.5

			if arg_22_1.time_ >= var_25_25 + var_25_26 and arg_22_1.time_ < var_25_25 + var_25_26 + arg_25_0 then
				arg_22_1.allBtn_.enabled = true
			end

			local var_25_27 = 0

			if var_25_27 < arg_22_1.time_ and arg_22_1.time_ <= var_25_27 + arg_25_0 then
				arg_22_1.fswbg_:SetActive(false)
				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_22_1:ShowNextGo(false)
			end

			if arg_22_1.frameCnt_ <= 1 then
				arg_22_1.dialog_:SetActive(false)
			end

			local var_25_28 = 1.5
			local var_25_29 = 0.4

			if var_25_28 < arg_22_1.time_ and arg_22_1.time_ <= var_25_28 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0

				arg_22_1.dialog_:SetActive(true)

				arg_22_1.dialogCg_.alpha = 0

				local var_25_30 = LeanTween.value(arg_22_1.dialog_, 0, 1, 0.3)

				var_25_30:setOnUpdate(LuaHelper.FloatAction(function(arg_26_0)
					arg_22_1.dialogCg_.alpha = arg_26_0
				end))
				var_25_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_22_1.dialog_)
					var_25_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_22_1.duration_ = arg_22_1.duration_ + 0.3

				SetActive(arg_22_1.leftNameGo_, true)

				local var_25_31 = arg_22_1:FormatText(StoryNameCfg[36].name)

				arg_22_1.leftNameTxt_.text = var_25_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_32 = arg_22_1:GetWordFromCfg(111011006)
				local var_25_33 = arg_22_1:FormatText(var_25_32.content)

				arg_22_1.text_.text = var_25_33

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_34 = 16
				local var_25_35 = utf8.len(var_25_33)
				local var_25_36 = var_25_34 <= 0 and var_25_29 or var_25_29 * (var_25_35 / var_25_34)

				if var_25_36 > 0 and var_25_29 < var_25_36 then
					arg_22_1.talkMaxDuration = var_25_36
					var_25_28 = var_25_28 + 0.3

					if var_25_36 + var_25_28 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_36 + var_25_28
					end
				end

				arg_22_1.text_.text = var_25_33
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111011", "111011006", "story_v_out_111011.awb") ~= 0 then
					local var_25_37 = manager.audio:GetVoiceLength("story_v_out_111011", "111011006", "story_v_out_111011.awb") / 1000

					if var_25_37 + var_25_28 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_37 + var_25_28
					end

					if var_25_32.prefab_name ~= "" and arg_22_1.actors_[var_25_32.prefab_name] ~= nil then
						local var_25_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_32.prefab_name].transform, "story_v_out_111011", "111011006", "story_v_out_111011.awb")

						arg_22_1:RecordAudio("111011006", var_25_38)
						arg_22_1:RecordAudio("111011006", var_25_38)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_out_111011", "111011006", "story_v_out_111011.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_out_111011", "111011006", "story_v_out_111011.awb")
				end

				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_39 = var_25_28 + 0.3
			local var_25_40 = math.max(var_25_29, arg_22_1.talkMaxDuration)

			if var_25_39 <= arg_22_1.time_ and arg_22_1.time_ < var_25_39 + var_25_40 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_39) / var_25_40

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_39 + var_25_40 and arg_22_1.time_ < var_25_39 + var_25_40 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play111011007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 111011007
		arg_28_1.duration_ = 5.4

		local var_28_0 = {
			ja = 3.6,
			ko = 2.933,
			zh = 4.766,
			en = 5.4
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
				arg_28_0:Play111011008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0
			local var_31_1 = 0.325

			if var_31_0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_2 = arg_28_1:FormatText(StoryNameCfg[36].name)

				arg_28_1.leftNameTxt_.text = var_31_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_3 = arg_28_1:GetWordFromCfg(111011007)
				local var_31_4 = arg_28_1:FormatText(var_31_3.content)

				arg_28_1.text_.text = var_31_4

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_5 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_111011", "111011007", "story_v_out_111011.awb") ~= 0 then
					local var_31_8 = manager.audio:GetVoiceLength("story_v_out_111011", "111011007", "story_v_out_111011.awb") / 1000

					if var_31_8 + var_31_0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_8 + var_31_0
					end

					if var_31_3.prefab_name ~= "" and arg_28_1.actors_[var_31_3.prefab_name] ~= nil then
						local var_31_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_3.prefab_name].transform, "story_v_out_111011", "111011007", "story_v_out_111011.awb")

						arg_28_1:RecordAudio("111011007", var_31_9)
						arg_28_1:RecordAudio("111011007", var_31_9)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_111011", "111011007", "story_v_out_111011.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_111011", "111011007", "story_v_out_111011.awb")
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
	Play111011008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 111011008
		arg_32_1.duration_ = 6.77

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play111011009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 5.76666666666667
			local var_35_1 = 1

			if var_35_0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_0 + arg_35_0 then
				local var_35_2 = "play"
				local var_35_3 = "effect"

				arg_32_1:AudioAction(var_35_2, var_35_3, "se_story_activity_1_1", "se_story_activity_1_1_doorslam", "")
			end

			local var_35_4 = 0
			local var_35_5 = 0.425

			if var_35_4 < arg_32_1.time_ and arg_32_1.time_ <= var_35_4 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_6 = arg_32_1:FormatText(StoryNameCfg[36].name)

				arg_32_1.leftNameTxt_.text = var_35_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_7 = arg_32_1:GetWordFromCfg(111011008)
				local var_35_8 = arg_32_1:FormatText(var_35_7.content)

				arg_32_1.text_.text = var_35_8

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_9 = 17
				local var_35_10 = utf8.len(var_35_8)
				local var_35_11 = var_35_9 <= 0 and var_35_5 or var_35_5 * (var_35_10 / var_35_9)

				if var_35_11 > 0 and var_35_5 < var_35_11 then
					arg_32_1.talkMaxDuration = var_35_11

					if var_35_11 + var_35_4 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_11 + var_35_4
					end
				end

				arg_32_1.text_.text = var_35_8
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111011", "111011008", "story_v_out_111011.awb") ~= 0 then
					local var_35_12 = manager.audio:GetVoiceLength("story_v_out_111011", "111011008", "story_v_out_111011.awb") / 1000

					if var_35_12 + var_35_4 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_12 + var_35_4
					end

					if var_35_7.prefab_name ~= "" and arg_32_1.actors_[var_35_7.prefab_name] ~= nil then
						local var_35_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_7.prefab_name].transform, "story_v_out_111011", "111011008", "story_v_out_111011.awb")

						arg_32_1:RecordAudio("111011008", var_35_13)
						arg_32_1:RecordAudio("111011008", var_35_13)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_111011", "111011008", "story_v_out_111011.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_111011", "111011008", "story_v_out_111011.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_14 = math.max(var_35_5, arg_32_1.talkMaxDuration)

			if var_35_4 <= arg_32_1.time_ and arg_32_1.time_ < var_35_4 + var_35_14 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_4) / var_35_14

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_4 + var_35_14 and arg_32_1.time_ < var_35_4 + var_35_14 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play111011009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 111011009
		arg_36_1.duration_ = 6.07

		local var_36_0 = {
			ja = 6.066,
			ko = 2.733,
			zh = 4.733,
			en = 2.7
		}
		local var_36_1 = manager.audio:GetLocalizationFlag()

		if var_36_0[var_36_1] ~= nil then
			arg_36_1.duration_ = var_36_0[var_36_1]
		end

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play111011010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0
			local var_39_1 = 0.3

			if var_39_0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_2 = arg_36_1:FormatText(StoryNameCfg[176].name)

				arg_36_1.leftNameTxt_.text = var_39_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, true)
				arg_36_1.iconController_:SetSelectedState("hero")

				arg_36_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_helena")

				arg_36_1.callingController_:SetSelectedState("normal")

				arg_36_1.keyicon_.color = Color.New(1, 1, 1)
				arg_36_1.icon_.color = Color.New(1, 1, 1)

				local var_39_3 = arg_36_1:GetWordFromCfg(111011009)
				local var_39_4 = arg_36_1:FormatText(var_39_3.content)

				arg_36_1.text_.text = var_39_4

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_5 = 12
				local var_39_6 = utf8.len(var_39_4)
				local var_39_7 = var_39_5 <= 0 and var_39_1 or var_39_1 * (var_39_6 / var_39_5)

				if var_39_7 > 0 and var_39_1 < var_39_7 then
					arg_36_1.talkMaxDuration = var_39_7

					if var_39_7 + var_39_0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_7 + var_39_0
					end
				end

				arg_36_1.text_.text = var_39_4
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111011", "111011009", "story_v_out_111011.awb") ~= 0 then
					local var_39_8 = manager.audio:GetVoiceLength("story_v_out_111011", "111011009", "story_v_out_111011.awb") / 1000

					if var_39_8 + var_39_0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_8 + var_39_0
					end

					if var_39_3.prefab_name ~= "" and arg_36_1.actors_[var_39_3.prefab_name] ~= nil then
						local var_39_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_3.prefab_name].transform, "story_v_out_111011", "111011009", "story_v_out_111011.awb")

						arg_36_1:RecordAudio("111011009", var_39_9)
						arg_36_1:RecordAudio("111011009", var_39_9)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_111011", "111011009", "story_v_out_111011.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_111011", "111011009", "story_v_out_111011.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_10 = math.max(var_39_1, arg_36_1.talkMaxDuration)

			if var_39_0 <= arg_36_1.time_ and arg_36_1.time_ < var_39_0 + var_39_10 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_0) / var_39_10

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_0 + var_39_10 and arg_36_1.time_ < var_39_0 + var_39_10 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play111011010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 111011010
		arg_40_1.duration_ = 4.77

		local var_40_0 = {
			ja = 4.766,
			ko = 2.533,
			zh = 2.733,
			en = 2.5
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
				arg_40_0:Play111011011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0
			local var_43_1 = 0.225

			if var_43_0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_2 = arg_40_1:FormatText(StoryNameCfg[176].name)

				arg_40_1.leftNameTxt_.text = var_43_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_helena")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_3 = arg_40_1:GetWordFromCfg(111011010)
				local var_43_4 = arg_40_1:FormatText(var_43_3.content)

				arg_40_1.text_.text = var_43_4

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_5 = 9
				local var_43_6 = utf8.len(var_43_4)
				local var_43_7 = var_43_5 <= 0 and var_43_1 or var_43_1 * (var_43_6 / var_43_5)

				if var_43_7 > 0 and var_43_1 < var_43_7 then
					arg_40_1.talkMaxDuration = var_43_7

					if var_43_7 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_7 + var_43_0
					end
				end

				arg_40_1.text_.text = var_43_4
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111011", "111011010", "story_v_out_111011.awb") ~= 0 then
					local var_43_8 = manager.audio:GetVoiceLength("story_v_out_111011", "111011010", "story_v_out_111011.awb") / 1000

					if var_43_8 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_8 + var_43_0
					end

					if var_43_3.prefab_name ~= "" and arg_40_1.actors_[var_43_3.prefab_name] ~= nil then
						local var_43_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_3.prefab_name].transform, "story_v_out_111011", "111011010", "story_v_out_111011.awb")

						arg_40_1:RecordAudio("111011010", var_43_9)
						arg_40_1:RecordAudio("111011010", var_43_9)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_111011", "111011010", "story_v_out_111011.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_111011", "111011010", "story_v_out_111011.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_10 = math.max(var_43_1, arg_40_1.talkMaxDuration)

			if var_43_0 <= arg_40_1.time_ and arg_40_1.time_ < var_43_0 + var_43_10 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_0) / var_43_10

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_0 + var_43_10 and arg_40_1.time_ < var_43_0 + var_43_10 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play111011011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 111011011
		arg_44_1.duration_ = 6.53

		local var_44_0 = {
			ja = 6.533,
			ko = 3.433,
			zh = 4.366,
			en = 2.7
		}
		local var_44_1 = manager.audio:GetLocalizationFlag()

		if var_44_0[var_44_1] ~= nil then
			arg_44_1.duration_ = var_44_0[var_44_1]
		end

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play111011012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0
			local var_47_1 = 0.325

			if var_47_0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_2 = arg_44_1:FormatText(StoryNameCfg[176].name)

				arg_44_1.leftNameTxt_.text = var_47_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, true)
				arg_44_1.iconController_:SetSelectedState("hero")

				arg_44_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_helena")

				arg_44_1.callingController_:SetSelectedState("normal")

				arg_44_1.keyicon_.color = Color.New(1, 1, 1)
				arg_44_1.icon_.color = Color.New(1, 1, 1)

				local var_47_3 = arg_44_1:GetWordFromCfg(111011011)
				local var_47_4 = arg_44_1:FormatText(var_47_3.content)

				arg_44_1.text_.text = var_47_4

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_5 = 13
				local var_47_6 = utf8.len(var_47_4)
				local var_47_7 = var_47_5 <= 0 and var_47_1 or var_47_1 * (var_47_6 / var_47_5)

				if var_47_7 > 0 and var_47_1 < var_47_7 then
					arg_44_1.talkMaxDuration = var_47_7

					if var_47_7 + var_47_0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_7 + var_47_0
					end
				end

				arg_44_1.text_.text = var_47_4
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111011", "111011011", "story_v_out_111011.awb") ~= 0 then
					local var_47_8 = manager.audio:GetVoiceLength("story_v_out_111011", "111011011", "story_v_out_111011.awb") / 1000

					if var_47_8 + var_47_0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_8 + var_47_0
					end

					if var_47_3.prefab_name ~= "" and arg_44_1.actors_[var_47_3.prefab_name] ~= nil then
						local var_47_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_3.prefab_name].transform, "story_v_out_111011", "111011011", "story_v_out_111011.awb")

						arg_44_1:RecordAudio("111011011", var_47_9)
						arg_44_1:RecordAudio("111011011", var_47_9)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_111011", "111011011", "story_v_out_111011.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_111011", "111011011", "story_v_out_111011.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_10 = math.max(var_47_1, arg_44_1.talkMaxDuration)

			if var_47_0 <= arg_44_1.time_ and arg_44_1.time_ < var_47_0 + var_47_10 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_0) / var_47_10

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_0 + var_47_10 and arg_44_1.time_ < var_47_0 + var_47_10 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play111011012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 111011012
		arg_48_1.duration_ = 9.8

		local var_48_0 = {
			ja = 9.8,
			ko = 2.766,
			zh = 5.666,
			en = 3.933
		}
		local var_48_1 = manager.audio:GetLocalizationFlag()

		if var_48_0[var_48_1] ~= nil then
			arg_48_1.duration_ = var_48_0[var_48_1]
		end

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play111011013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0
			local var_51_1 = 0.425

			if var_51_0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_2 = arg_48_1:FormatText(StoryNameCfg[176].name)

				arg_48_1.leftNameTxt_.text = var_51_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, true)
				arg_48_1.iconController_:SetSelectedState("hero")

				arg_48_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_helena")

				arg_48_1.callingController_:SetSelectedState("normal")

				arg_48_1.keyicon_.color = Color.New(1, 1, 1)
				arg_48_1.icon_.color = Color.New(1, 1, 1)

				local var_51_3 = arg_48_1:GetWordFromCfg(111011012)
				local var_51_4 = arg_48_1:FormatText(var_51_3.content)

				arg_48_1.text_.text = var_51_4

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_5 = 17
				local var_51_6 = utf8.len(var_51_4)
				local var_51_7 = var_51_5 <= 0 and var_51_1 or var_51_1 * (var_51_6 / var_51_5)

				if var_51_7 > 0 and var_51_1 < var_51_7 then
					arg_48_1.talkMaxDuration = var_51_7

					if var_51_7 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_7 + var_51_0
					end
				end

				arg_48_1.text_.text = var_51_4
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111011", "111011012", "story_v_out_111011.awb") ~= 0 then
					local var_51_8 = manager.audio:GetVoiceLength("story_v_out_111011", "111011012", "story_v_out_111011.awb") / 1000

					if var_51_8 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_8 + var_51_0
					end

					if var_51_3.prefab_name ~= "" and arg_48_1.actors_[var_51_3.prefab_name] ~= nil then
						local var_51_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_3.prefab_name].transform, "story_v_out_111011", "111011012", "story_v_out_111011.awb")

						arg_48_1:RecordAudio("111011012", var_51_9)
						arg_48_1:RecordAudio("111011012", var_51_9)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_111011", "111011012", "story_v_out_111011.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_111011", "111011012", "story_v_out_111011.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_10 = math.max(var_51_1, arg_48_1.talkMaxDuration)

			if var_51_0 <= arg_48_1.time_ and arg_48_1.time_ < var_51_0 + var_51_10 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_0) / var_51_10

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_0 + var_51_10 and arg_48_1.time_ < var_51_0 + var_51_10 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play111011013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 111011013
		arg_52_1.duration_ = 6.47

		local var_52_0 = {
			ja = 6.46666666666667,
			ko = 5.299999999999,
			zh = 5.83266666666667,
			en = 5.299999999999
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
				arg_52_0:Play111011014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = "ST03a"

			if arg_52_1.bgs_[var_55_0] == nil then
				local var_55_1 = Object.Instantiate(arg_52_1.paintGo_)

				var_55_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_55_0)
				var_55_1.name = var_55_0
				var_55_1.transform.parent = arg_52_1.stage_.transform
				var_55_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_52_1.bgs_[var_55_0] = var_55_1
			end

			local var_55_2 = 1.5

			if var_55_2 < arg_52_1.time_ and arg_52_1.time_ <= var_55_2 + arg_55_0 then
				local var_55_3 = manager.ui.mainCamera.transform.localPosition
				local var_55_4 = Vector3.New(0, 0, 10) + Vector3.New(var_55_3.x, var_55_3.y, 0)
				local var_55_5 = arg_52_1.bgs_.ST03a

				var_55_5.transform.localPosition = var_55_4
				var_55_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_55_6 = var_55_5:GetComponent("SpriteRenderer")

				if var_55_6 and var_55_6.sprite then
					local var_55_7 = (var_55_5.transform.localPosition - var_55_3).z
					local var_55_8 = manager.ui.mainCameraCom_
					local var_55_9 = 2 * var_55_7 * Mathf.Tan(var_55_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_55_10 = var_55_9 * var_55_8.aspect
					local var_55_11 = var_55_6.sprite.bounds.size.x
					local var_55_12 = var_55_6.sprite.bounds.size.y
					local var_55_13 = var_55_10 / var_55_11
					local var_55_14 = var_55_9 / var_55_12
					local var_55_15 = var_55_14 < var_55_13 and var_55_13 or var_55_14

					var_55_5.transform.localScale = Vector3.New(var_55_15, var_55_15, 0)
				end

				for iter_55_0, iter_55_1 in pairs(arg_52_1.bgs_) do
					if iter_55_0 ~= "ST03a" then
						iter_55_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_55_16 = arg_52_1.bgs_.ST03a
			local var_55_17 = 1.5

			if var_55_17 < arg_52_1.time_ and arg_52_1.time_ <= var_55_17 + arg_55_0 then
				local var_55_18 = var_55_16:GetComponent("SpriteRenderer")

				if var_55_18 then
					arg_52_1.var_.alphaOldValueST03a = var_55_18.color.a
					arg_52_1.var_.alphaMatValueST03a = var_55_18
				end

				arg_52_1.var_.alphaOldValueST03a = 0
			end

			local var_55_19 = 1.5

			if var_55_17 <= arg_52_1.time_ and arg_52_1.time_ < var_55_17 + var_55_19 then
				local var_55_20 = (arg_52_1.time_ - var_55_17) / var_55_19
				local var_55_21 = Mathf.Lerp(arg_52_1.var_.alphaOldValueST03a, 1, var_55_20)

				if arg_52_1.var_.alphaMatValueST03a then
					local var_55_22 = arg_52_1.var_.alphaMatValueST03a.color

					var_55_22.a = var_55_21
					arg_52_1.var_.alphaMatValueST03a.color = var_55_22
				end
			end

			if arg_52_1.time_ >= var_55_17 + var_55_19 and arg_52_1.time_ < var_55_17 + var_55_19 + arg_55_0 and arg_52_1.var_.alphaMatValueST03a then
				local var_55_23 = arg_52_1.var_.alphaMatValueST03a
				local var_55_24 = var_55_23.color

				var_55_24.a = 1
				var_55_23.color = var_55_24
			end

			local var_55_25 = arg_52_1.bgs_.ST03a
			local var_55_26 = 3

			if var_55_26 < arg_52_1.time_ and arg_52_1.time_ <= var_55_26 + arg_55_0 then
				local var_55_27 = var_55_25:GetComponent("SpriteRenderer")

				if var_55_27 then
					arg_52_1.var_.alphaOldValueST03a = var_55_27.color.a
					arg_52_1.var_.alphaMatValueST03a = var_55_27
				end

				arg_52_1.var_.alphaOldValueST03a = 1
			end

			local var_55_28 = 0.8

			if var_55_26 <= arg_52_1.time_ and arg_52_1.time_ < var_55_26 + var_55_28 then
				local var_55_29 = (arg_52_1.time_ - var_55_26) / var_55_28
				local var_55_30 = Mathf.Lerp(arg_52_1.var_.alphaOldValueST03a, 0, var_55_29)

				if arg_52_1.var_.alphaMatValueST03a then
					local var_55_31 = arg_52_1.var_.alphaMatValueST03a.color

					var_55_31.a = var_55_30
					arg_52_1.var_.alphaMatValueST03a.color = var_55_31
				end
			end

			if arg_52_1.time_ >= var_55_26 + var_55_28 and arg_52_1.time_ < var_55_26 + var_55_28 + arg_55_0 and arg_52_1.var_.alphaMatValueST03a then
				local var_55_32 = arg_52_1.var_.alphaMatValueST03a
				local var_55_33 = var_55_32.color

				var_55_33.a = 0
				var_55_32.color = var_55_33
			end

			local var_55_34 = arg_52_1.bgs_.ST03a
			local var_55_35 = 3.8

			if var_55_35 < arg_52_1.time_ and arg_52_1.time_ <= var_55_35 + arg_55_0 then
				local var_55_36 = var_55_34:GetComponent("SpriteRenderer")

				if var_55_36 then
					arg_52_1.var_.alphaOldValueST03a = var_55_36.color.a
					arg_52_1.var_.alphaMatValueST03a = var_55_36
				end

				arg_52_1.var_.alphaOldValueST03a = 0
			end

			local var_55_37 = 1.5

			if var_55_35 <= arg_52_1.time_ and arg_52_1.time_ < var_55_35 + var_55_37 then
				local var_55_38 = (arg_52_1.time_ - var_55_35) / var_55_37
				local var_55_39 = Mathf.Lerp(arg_52_1.var_.alphaOldValueST03a, 1, var_55_38)

				if arg_52_1.var_.alphaMatValueST03a then
					local var_55_40 = arg_52_1.var_.alphaMatValueST03a.color

					var_55_40.a = var_55_39
					arg_52_1.var_.alphaMatValueST03a.color = var_55_40
				end
			end

			if arg_52_1.time_ >= var_55_35 + var_55_37 and arg_52_1.time_ < var_55_35 + var_55_37 + arg_55_0 and arg_52_1.var_.alphaMatValueST03a then
				local var_55_41 = arg_52_1.var_.alphaMatValueST03a
				local var_55_42 = var_55_41.color

				var_55_42.a = 1
				var_55_41.color = var_55_42
			end

			local var_55_43 = 1.5

			arg_52_1.isInRecall_ = false

			if var_55_43 < arg_52_1.time_ and arg_52_1.time_ <= var_55_43 + arg_55_0 then
				arg_52_1.screenFilterGo_:SetActive(false)

				for iter_55_2, iter_55_3 in pairs(arg_52_1.actors_) do
					local var_55_44 = iter_55_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_55_4, iter_55_5 in ipairs(var_55_44) do
						if iter_55_5.color.r > 0.51 then
							iter_55_5.color = Color.New(1, 1, 1)
						else
							iter_55_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_55_45 = 0.2

			if var_55_43 <= arg_52_1.time_ and arg_52_1.time_ < var_55_43 + var_55_45 then
				local var_55_46 = (arg_52_1.time_ - var_55_43) / var_55_45

				arg_52_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_55_46)
			end

			if arg_52_1.time_ >= var_55_43 + var_55_45 and arg_52_1.time_ < var_55_43 + var_55_45 + arg_55_0 then
				arg_52_1.screenFilterEffect_.weight = 0
			end

			local var_55_47 = 0

			if var_55_47 < arg_52_1.time_ and arg_52_1.time_ <= var_55_47 + arg_55_0 then
				arg_52_1.allBtn_.enabled = false
			end

			local var_55_48 = 5.3

			if arg_52_1.time_ >= var_55_47 + var_55_48 and arg_52_1.time_ < var_55_47 + var_55_48 + arg_55_0 then
				arg_52_1.allBtn_.enabled = true
			end

			local var_55_49 = arg_52_1.bgs_.D999
			local var_55_50 = 0

			if var_55_50 < arg_52_1.time_ and arg_52_1.time_ <= var_55_50 + arg_55_0 then
				local var_55_51 = var_55_49:GetComponent("SpriteRenderer")

				if var_55_51 then
					arg_52_1.var_.alphaOldValueD999 = var_55_51.color.a
					arg_52_1.var_.alphaMatValueD999 = var_55_51
				end

				arg_52_1.var_.alphaOldValueD999 = 1
			end

			local var_55_52 = 1.5

			if var_55_50 <= arg_52_1.time_ and arg_52_1.time_ < var_55_50 + var_55_52 then
				local var_55_53 = (arg_52_1.time_ - var_55_50) / var_55_52
				local var_55_54 = Mathf.Lerp(arg_52_1.var_.alphaOldValueD999, 0, var_55_53)

				if arg_52_1.var_.alphaMatValueD999 then
					local var_55_55 = arg_52_1.var_.alphaMatValueD999.color

					var_55_55.a = var_55_54
					arg_52_1.var_.alphaMatValueD999.color = var_55_55
				end
			end

			if arg_52_1.time_ >= var_55_50 + var_55_52 and arg_52_1.time_ < var_55_50 + var_55_52 + arg_55_0 and arg_52_1.var_.alphaMatValueD999 then
				local var_55_56 = arg_52_1.var_.alphaMatValueD999
				local var_55_57 = var_55_56.color

				var_55_57.a = 0
				var_55_56.color = var_55_57
			end

			local var_55_58 = 3.26666666666667
			local var_55_59 = 1

			if var_55_58 < arg_52_1.time_ and arg_52_1.time_ <= var_55_58 + arg_55_0 then
				local var_55_60 = "play"
				local var_55_61 = "music"

				arg_52_1:AudioAction(var_55_60, var_55_61, "bgm_activity_1_1_hel_story", "bgm_activity_1_1_hel_story", "bgm_activity_1_1_hel_story.awb")

				local var_55_62 = ""
				local var_55_63 = manager.audio:GetAudioName("bgm_activity_1_1_hel_story", "bgm_activity_1_1_hel_story")

				if var_55_63 ~= "" then
					if arg_52_1.bgmTxt_.text ~= var_55_63 and arg_52_1.bgmTxt_.text ~= "" then
						if arg_52_1.bgmTxt2_.text ~= "" then
							arg_52_1.bgmTxt_.text = arg_52_1.bgmTxt2_.text
						end

						arg_52_1.bgmTxt2_.text = var_55_63

						arg_52_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_52_1.bgmTxt_.text = var_55_63
						arg_52_1.bgmTxt2_.text = var_55_63
					end

					if arg_52_1.bgmTimer then
						arg_52_1.bgmTimer:Stop()

						arg_52_1.bgmTimer = nil
					end

					if arg_52_1.settingData.show_music_name == 1 then
						arg_52_1.musicController:SetSelectedState("show")
						arg_52_1.musicAnimator_:Play("open", 0, 0)

						if arg_52_1.settingData.music_time ~= 0 then
							arg_52_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_52_1.settingData.music_time), function()
								if arg_52_1 == nil or isNil(arg_52_1.bgmTxt_) then
									return
								end

								arg_52_1.musicController:SetSelectedState("hide")
								arg_52_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_52_1.frameCnt_ <= 1 then
				arg_52_1.dialog_:SetActive(false)
			end

			local var_55_64 = 2.66666666666667
			local var_55_65 = 0.6

			if var_55_64 < arg_52_1.time_ and arg_52_1.time_ <= var_55_64 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0

				arg_52_1.dialog_:SetActive(true)

				arg_52_1.dialogCg_.alpha = 0

				local var_55_66 = LeanTween.value(arg_52_1.dialog_, 0, 1, 0.3)

				var_55_66:setOnUpdate(LuaHelper.FloatAction(function(arg_57_0)
					arg_52_1.dialogCg_.alpha = arg_57_0
				end))
				var_55_66:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_52_1.dialog_)
					var_55_66:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_52_1.duration_ = arg_52_1.duration_ + 0.3

				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_67 = arg_52_1:FormatText(StoryNameCfg[177].name)

				arg_52_1.leftNameTxt_.text = var_55_67

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_68 = arg_52_1:GetWordFromCfg(111011013)
				local var_55_69 = arg_52_1:FormatText(var_55_68.content)

				arg_52_1.text_.text = var_55_69

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_70 = 12
				local var_55_71 = utf8.len(var_55_69)
				local var_55_72 = var_55_70 <= 0 and var_55_65 or var_55_65 * (var_55_71 / var_55_70)

				if var_55_72 > 0 and var_55_65 < var_55_72 then
					arg_52_1.talkMaxDuration = var_55_72
					var_55_64 = var_55_64 + 0.3

					if var_55_72 + var_55_64 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_72 + var_55_64
					end
				end

				arg_52_1.text_.text = var_55_69
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111011", "111011013", "story_v_out_111011.awb") ~= 0 then
					local var_55_73 = manager.audio:GetVoiceLength("story_v_out_111011", "111011013", "story_v_out_111011.awb") / 1000

					if var_55_73 + var_55_64 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_73 + var_55_64
					end

					if var_55_68.prefab_name ~= "" and arg_52_1.actors_[var_55_68.prefab_name] ~= nil then
						local var_55_74 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_68.prefab_name].transform, "story_v_out_111011", "111011013", "story_v_out_111011.awb")

						arg_52_1:RecordAudio("111011013", var_55_74)
						arg_52_1:RecordAudio("111011013", var_55_74)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_111011", "111011013", "story_v_out_111011.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_111011", "111011013", "story_v_out_111011.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_75 = var_55_64 + 0.3
			local var_55_76 = math.max(var_55_65, arg_52_1.talkMaxDuration)

			if var_55_75 <= arg_52_1.time_ and arg_52_1.time_ < var_55_75 + var_55_76 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_75) / var_55_76

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_75 + var_55_76 and arg_52_1.time_ < var_55_75 + var_55_76 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play111011014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 111011014
		arg_59_1.duration_ = 8.3

		local var_59_0 = {
			ja = 8.3,
			ko = 4.2,
			zh = 5.033,
			en = 4.533
		}
		local var_59_1 = manager.audio:GetLocalizationFlag()

		if var_59_0[var_59_1] ~= nil then
			arg_59_1.duration_ = var_59_0[var_59_1]
		end

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play111011015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0
			local var_62_1 = 0.625

			if var_62_0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_2 = arg_59_1:FormatText(StoryNameCfg[177].name)

				arg_59_1.leftNameTxt_.text = var_62_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, true)
				arg_59_1.iconController_:SetSelectedState("hero")

				arg_59_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_59_1.callingController_:SetSelectedState("normal")

				arg_59_1.keyicon_.color = Color.New(1, 1, 1)
				arg_59_1.icon_.color = Color.New(1, 1, 1)

				local var_62_3 = arg_59_1:GetWordFromCfg(111011014)
				local var_62_4 = arg_59_1:FormatText(var_62_3.content)

				arg_59_1.text_.text = var_62_4

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_5 = 25
				local var_62_6 = utf8.len(var_62_4)
				local var_62_7 = var_62_5 <= 0 and var_62_1 or var_62_1 * (var_62_6 / var_62_5)

				if var_62_7 > 0 and var_62_1 < var_62_7 then
					arg_59_1.talkMaxDuration = var_62_7

					if var_62_7 + var_62_0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_7 + var_62_0
					end
				end

				arg_59_1.text_.text = var_62_4
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111011", "111011014", "story_v_out_111011.awb") ~= 0 then
					local var_62_8 = manager.audio:GetVoiceLength("story_v_out_111011", "111011014", "story_v_out_111011.awb") / 1000

					if var_62_8 + var_62_0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_8 + var_62_0
					end

					if var_62_3.prefab_name ~= "" and arg_59_1.actors_[var_62_3.prefab_name] ~= nil then
						local var_62_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_3.prefab_name].transform, "story_v_out_111011", "111011014", "story_v_out_111011.awb")

						arg_59_1:RecordAudio("111011014", var_62_9)
						arg_59_1:RecordAudio("111011014", var_62_9)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_111011", "111011014", "story_v_out_111011.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_111011", "111011014", "story_v_out_111011.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_10 = math.max(var_62_1, arg_59_1.talkMaxDuration)

			if var_62_0 <= arg_59_1.time_ and arg_59_1.time_ < var_62_0 + var_62_10 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_0) / var_62_10

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_0 + var_62_10 and arg_59_1.time_ < var_62_0 + var_62_10 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play111011015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 111011015
		arg_63_1.duration_ = 9.47

		local var_63_0 = {
			ja = 6.966,
			ko = 9.466,
			zh = 8.5,
			en = 7.533
		}
		local var_63_1 = manager.audio:GetLocalizationFlag()

		if var_63_0[var_63_1] ~= nil then
			arg_63_1.duration_ = var_63_0[var_63_1]
		end

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play111011016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0
			local var_66_1 = 1.1

			if var_66_0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_2 = arg_63_1:FormatText(StoryNameCfg[177].name)

				arg_63_1.leftNameTxt_.text = var_66_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, true)
				arg_63_1.iconController_:SetSelectedState("hero")

				arg_63_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_63_1.callingController_:SetSelectedState("normal")

				arg_63_1.keyicon_.color = Color.New(1, 1, 1)
				arg_63_1.icon_.color = Color.New(1, 1, 1)

				local var_66_3 = arg_63_1:GetWordFromCfg(111011015)
				local var_66_4 = arg_63_1:FormatText(var_66_3.content)

				arg_63_1.text_.text = var_66_4

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_5 = 44
				local var_66_6 = utf8.len(var_66_4)
				local var_66_7 = var_66_5 <= 0 and var_66_1 or var_66_1 * (var_66_6 / var_66_5)

				if var_66_7 > 0 and var_66_1 < var_66_7 then
					arg_63_1.talkMaxDuration = var_66_7

					if var_66_7 + var_66_0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_7 + var_66_0
					end
				end

				arg_63_1.text_.text = var_66_4
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111011", "111011015", "story_v_out_111011.awb") ~= 0 then
					local var_66_8 = manager.audio:GetVoiceLength("story_v_out_111011", "111011015", "story_v_out_111011.awb") / 1000

					if var_66_8 + var_66_0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_8 + var_66_0
					end

					if var_66_3.prefab_name ~= "" and arg_63_1.actors_[var_66_3.prefab_name] ~= nil then
						local var_66_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_3.prefab_name].transform, "story_v_out_111011", "111011015", "story_v_out_111011.awb")

						arg_63_1:RecordAudio("111011015", var_66_9)
						arg_63_1:RecordAudio("111011015", var_66_9)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_111011", "111011015", "story_v_out_111011.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_111011", "111011015", "story_v_out_111011.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_10 = math.max(var_66_1, arg_63_1.talkMaxDuration)

			if var_66_0 <= arg_63_1.time_ and arg_63_1.time_ < var_66_0 + var_66_10 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_0) / var_66_10

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_0 + var_66_10 and arg_63_1.time_ < var_66_0 + var_66_10 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play111011016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 111011016
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play111011017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = "1094ui_story"

			if arg_67_1.actors_[var_70_0] == nil then
				local var_70_1 = Asset.Load("Char/" .. "1094ui_story")

				if not isNil(var_70_1) then
					local var_70_2 = Object.Instantiate(Asset.Load("Char/" .. "1094ui_story"), arg_67_1.stage_.transform)

					var_70_2.name = var_70_0
					var_70_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_67_1.actors_[var_70_0] = var_70_2

					local var_70_3 = var_70_2:GetComponentInChildren(typeof(CharacterEffect))

					var_70_3.enabled = true

					local var_70_4 = GameObjectTools.GetOrAddComponent(var_70_2, typeof(DynamicBoneHelper))

					if var_70_4 then
						var_70_4:EnableDynamicBone(false)
					end

					arg_67_1:ShowWeapon(var_70_3.transform, false)

					arg_67_1.var_[var_70_0 .. "Animator"] = var_70_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_67_1.var_[var_70_0 .. "Animator"].applyRootMotion = true
					arg_67_1.var_[var_70_0 .. "LipSync"] = var_70_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_70_5 = arg_67_1.actors_["1094ui_story"].transform
			local var_70_6 = 0

			if var_70_6 < arg_67_1.time_ and arg_67_1.time_ <= var_70_6 + arg_70_0 then
				arg_67_1.var_.moveOldPos1094ui_story = var_70_5.localPosition
			end

			local var_70_7 = 0.001

			if var_70_6 <= arg_67_1.time_ and arg_67_1.time_ < var_70_6 + var_70_7 then
				local var_70_8 = (arg_67_1.time_ - var_70_6) / var_70_7
				local var_70_9 = Vector3.New(0, 100, 0)

				var_70_5.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1094ui_story, var_70_9, var_70_8)

				local var_70_10 = manager.ui.mainCamera.transform.position - var_70_5.position

				var_70_5.forward = Vector3.New(var_70_10.x, var_70_10.y, var_70_10.z)

				local var_70_11 = var_70_5.localEulerAngles

				var_70_11.z = 0
				var_70_11.x = 0
				var_70_5.localEulerAngles = var_70_11
			end

			if arg_67_1.time_ >= var_70_6 + var_70_7 and arg_67_1.time_ < var_70_6 + var_70_7 + arg_70_0 then
				var_70_5.localPosition = Vector3.New(0, 100, 0)

				local var_70_12 = manager.ui.mainCamera.transform.position - var_70_5.position

				var_70_5.forward = Vector3.New(var_70_12.x, var_70_12.y, var_70_12.z)

				local var_70_13 = var_70_5.localEulerAngles

				var_70_13.z = 0
				var_70_13.x = 0
				var_70_5.localEulerAngles = var_70_13
			end

			local var_70_14 = 0

			if var_70_14 < arg_67_1.time_ and arg_67_1.time_ <= var_70_14 + arg_70_0 then
				arg_67_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_70_15 = 0

			if var_70_15 < arg_67_1.time_ and arg_67_1.time_ <= var_70_15 + arg_70_0 then
				arg_67_1.allBtn_.enabled = false
			end

			local var_70_16 = 0.65

			if arg_67_1.time_ >= var_70_15 + var_70_16 and arg_67_1.time_ < var_70_15 + var_70_16 + arg_70_0 then
				arg_67_1.allBtn_.enabled = true
			end

			local var_70_17 = 0
			local var_70_18 = 0.65

			if var_70_17 < arg_67_1.time_ and arg_67_1.time_ <= var_70_17 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, false)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_19 = arg_67_1:GetWordFromCfg(111011016)
				local var_70_20 = arg_67_1:FormatText(var_70_19.content)

				arg_67_1.text_.text = var_70_20

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_21 = 26
				local var_70_22 = utf8.len(var_70_20)
				local var_70_23 = var_70_21 <= 0 and var_70_18 or var_70_18 * (var_70_22 / var_70_21)

				if var_70_23 > 0 and var_70_18 < var_70_23 then
					arg_67_1.talkMaxDuration = var_70_23

					if var_70_23 + var_70_17 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_23 + var_70_17
					end
				end

				arg_67_1.text_.text = var_70_20
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_24 = math.max(var_70_18, arg_67_1.talkMaxDuration)

			if var_70_17 <= arg_67_1.time_ and arg_67_1.time_ < var_70_17 + var_70_24 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_17) / var_70_24

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_17 + var_70_24 and arg_67_1.time_ < var_70_17 + var_70_24 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_67_1:InitPlayNodeList()
	end,
	Play111011017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 111011017
		arg_71_1.duration_ = 3.97

		local var_71_0 = {
			ja = 1.999999999999,
			ko = 2.333,
			zh = 3.966,
			en = 2.733
		}
		local var_71_1 = manager.audio:GetLocalizationFlag()

		if var_71_0[var_71_1] ~= nil then
			arg_71_1.duration_ = var_71_0[var_71_1]
		end

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play111011018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = arg_71_1.actors_["1094ui_story"].transform
			local var_74_1 = 0

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 then
				arg_71_1.var_.moveOldPos1094ui_story = var_74_0.localPosition
			end

			local var_74_2 = 0.001

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_2 then
				local var_74_3 = (arg_71_1.time_ - var_74_1) / var_74_2
				local var_74_4 = Vector3.New(0, -0.84, -6.1)

				var_74_0.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1094ui_story, var_74_4, var_74_3)

				local var_74_5 = manager.ui.mainCamera.transform.position - var_74_0.position

				var_74_0.forward = Vector3.New(var_74_5.x, var_74_5.y, var_74_5.z)

				local var_74_6 = var_74_0.localEulerAngles

				var_74_6.z = 0
				var_74_6.x = 0
				var_74_0.localEulerAngles = var_74_6
			end

			if arg_71_1.time_ >= var_74_1 + var_74_2 and arg_71_1.time_ < var_74_1 + var_74_2 + arg_74_0 then
				var_74_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_74_7 = manager.ui.mainCamera.transform.position - var_74_0.position

				var_74_0.forward = Vector3.New(var_74_7.x, var_74_7.y, var_74_7.z)

				local var_74_8 = var_74_0.localEulerAngles

				var_74_8.z = 0
				var_74_8.x = 0
				var_74_0.localEulerAngles = var_74_8
			end

			local var_74_9 = 0

			if var_74_9 < arg_71_1.time_ and arg_71_1.time_ <= var_74_9 + arg_74_0 then
				arg_71_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_74_10 = 0

			if var_74_10 < arg_71_1.time_ and arg_71_1.time_ <= var_74_10 + arg_74_0 then
				arg_71_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action1_1")
			end

			local var_74_11 = arg_71_1.actors_["1094ui_story"]
			local var_74_12 = 0

			if var_74_12 < arg_71_1.time_ and arg_71_1.time_ <= var_74_12 + arg_74_0 and not isNil(var_74_11) and arg_71_1.var_.characterEffect1094ui_story == nil then
				arg_71_1.var_.characterEffect1094ui_story = var_74_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_13 = 0.2

			if var_74_12 <= arg_71_1.time_ and arg_71_1.time_ < var_74_12 + var_74_13 and not isNil(var_74_11) then
				local var_74_14 = (arg_71_1.time_ - var_74_12) / var_74_13

				if arg_71_1.var_.characterEffect1094ui_story and not isNil(var_74_11) then
					arg_71_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= var_74_12 + var_74_13 and arg_71_1.time_ < var_74_12 + var_74_13 + arg_74_0 and not isNil(var_74_11) and arg_71_1.var_.characterEffect1094ui_story then
				arg_71_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_74_15 = 0
			local var_74_16 = 0.2

			if var_74_15 < arg_71_1.time_ and arg_71_1.time_ <= var_74_15 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_17 = arg_71_1:FormatText(StoryNameCfg[181].name)

				arg_71_1.leftNameTxt_.text = var_74_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_18 = arg_71_1:GetWordFromCfg(111011017)
				local var_74_19 = arg_71_1:FormatText(var_74_18.content)

				arg_71_1.text_.text = var_74_19

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_20 = 8
				local var_74_21 = utf8.len(var_74_19)
				local var_74_22 = var_74_20 <= 0 and var_74_16 or var_74_16 * (var_74_21 / var_74_20)

				if var_74_22 > 0 and var_74_16 < var_74_22 then
					arg_71_1.talkMaxDuration = var_74_22

					if var_74_22 + var_74_15 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_22 + var_74_15
					end
				end

				arg_71_1.text_.text = var_74_19
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111011", "111011017", "story_v_out_111011.awb") ~= 0 then
					local var_74_23 = manager.audio:GetVoiceLength("story_v_out_111011", "111011017", "story_v_out_111011.awb") / 1000

					if var_74_23 + var_74_15 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_23 + var_74_15
					end

					if var_74_18.prefab_name ~= "" and arg_71_1.actors_[var_74_18.prefab_name] ~= nil then
						local var_74_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_18.prefab_name].transform, "story_v_out_111011", "111011017", "story_v_out_111011.awb")

						arg_71_1:RecordAudio("111011017", var_74_24)
						arg_71_1:RecordAudio("111011017", var_74_24)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_111011", "111011017", "story_v_out_111011.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_111011", "111011017", "story_v_out_111011.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_25 = math.max(var_74_16, arg_71_1.talkMaxDuration)

			if var_74_15 <= arg_71_1.time_ and arg_71_1.time_ < var_74_15 + var_74_25 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_15) / var_74_25

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_15 + var_74_25 and arg_71_1.time_ < var_74_15 + var_74_25 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_71_1:InitPlayNodeList()
	end,
	Play111011018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 111011018
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play111011019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0

			if var_78_0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_0 + arg_78_0 then
				arg_75_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_78_1 = arg_75_1.actors_["1094ui_story"]
			local var_78_2 = 0

			if var_78_2 < arg_75_1.time_ and arg_75_1.time_ <= var_78_2 + arg_78_0 and not isNil(var_78_1) and arg_75_1.var_.characterEffect1094ui_story == nil then
				arg_75_1.var_.characterEffect1094ui_story = var_78_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_3 = 0.2

			if var_78_2 <= arg_75_1.time_ and arg_75_1.time_ < var_78_2 + var_78_3 and not isNil(var_78_1) then
				local var_78_4 = (arg_75_1.time_ - var_78_2) / var_78_3

				if arg_75_1.var_.characterEffect1094ui_story and not isNil(var_78_1) then
					local var_78_5 = Mathf.Lerp(0, 0.5, var_78_4)

					arg_75_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_75_1.var_.characterEffect1094ui_story.fillRatio = var_78_5
				end
			end

			if arg_75_1.time_ >= var_78_2 + var_78_3 and arg_75_1.time_ < var_78_2 + var_78_3 + arg_78_0 and not isNil(var_78_1) and arg_75_1.var_.characterEffect1094ui_story then
				local var_78_6 = 0.5

				arg_75_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_75_1.var_.characterEffect1094ui_story.fillRatio = var_78_6
			end

			local var_78_7 = 0

			if var_78_7 < arg_75_1.time_ and arg_75_1.time_ <= var_78_7 + arg_78_0 then
				arg_75_1.allBtn_.enabled = false
			end

			local var_78_8 = 0.725

			if arg_75_1.time_ >= var_78_7 + var_78_8 and arg_75_1.time_ < var_78_7 + var_78_8 + arg_78_0 then
				arg_75_1.allBtn_.enabled = true
			end

			local var_78_9 = 0
			local var_78_10 = 0.725

			if var_78_9 < arg_75_1.time_ and arg_75_1.time_ <= var_78_9 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, false)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_11 = arg_75_1:GetWordFromCfg(111011018)
				local var_78_12 = arg_75_1:FormatText(var_78_11.content)

				arg_75_1.text_.text = var_78_12

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_13 = 29
				local var_78_14 = utf8.len(var_78_12)
				local var_78_15 = var_78_13 <= 0 and var_78_10 or var_78_10 * (var_78_14 / var_78_13)

				if var_78_15 > 0 and var_78_10 < var_78_15 then
					arg_75_1.talkMaxDuration = var_78_15

					if var_78_15 + var_78_9 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_15 + var_78_9
					end
				end

				arg_75_1.text_.text = var_78_12
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_16 = math.max(var_78_10, arg_75_1.talkMaxDuration)

			if var_78_9 <= arg_75_1.time_ and arg_75_1.time_ < var_78_9 + var_78_16 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_9) / var_78_16

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_9 + var_78_16 and arg_75_1.time_ < var_78_9 + var_78_16 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play111011019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 111011019
		arg_79_1.duration_ = 2

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play111011020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0

			if var_82_0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_0 + arg_82_0 then
				arg_79_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action1_1")
			end

			local var_82_1 = 0

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 then
				arg_79_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_82_2 = arg_79_1.actors_["1094ui_story"]
			local var_82_3 = 0

			if var_82_3 < arg_79_1.time_ and arg_79_1.time_ <= var_82_3 + arg_82_0 and not isNil(var_82_2) and arg_79_1.var_.characterEffect1094ui_story == nil then
				arg_79_1.var_.characterEffect1094ui_story = var_82_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_4 = 0.2

			if var_82_3 <= arg_79_1.time_ and arg_79_1.time_ < var_82_3 + var_82_4 and not isNil(var_82_2) then
				local var_82_5 = (arg_79_1.time_ - var_82_3) / var_82_4

				if arg_79_1.var_.characterEffect1094ui_story and not isNil(var_82_2) then
					arg_79_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= var_82_3 + var_82_4 and arg_79_1.time_ < var_82_3 + var_82_4 + arg_82_0 and not isNil(var_82_2) and arg_79_1.var_.characterEffect1094ui_story then
				arg_79_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_82_6 = 0
			local var_82_7 = 0.1

			if var_82_6 < arg_79_1.time_ and arg_79_1.time_ <= var_82_6 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_8 = arg_79_1:FormatText(StoryNameCfg[181].name)

				arg_79_1.leftNameTxt_.text = var_82_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_9 = arg_79_1:GetWordFromCfg(111011019)
				local var_82_10 = arg_79_1:FormatText(var_82_9.content)

				arg_79_1.text_.text = var_82_10

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_11 = 4
				local var_82_12 = utf8.len(var_82_10)
				local var_82_13 = var_82_11 <= 0 and var_82_7 or var_82_7 * (var_82_12 / var_82_11)

				if var_82_13 > 0 and var_82_7 < var_82_13 then
					arg_79_1.talkMaxDuration = var_82_13

					if var_82_13 + var_82_6 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_13 + var_82_6
					end
				end

				arg_79_1.text_.text = var_82_10
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111011", "111011019", "story_v_out_111011.awb") ~= 0 then
					local var_82_14 = manager.audio:GetVoiceLength("story_v_out_111011", "111011019", "story_v_out_111011.awb") / 1000

					if var_82_14 + var_82_6 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_14 + var_82_6
					end

					if var_82_9.prefab_name ~= "" and arg_79_1.actors_[var_82_9.prefab_name] ~= nil then
						local var_82_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_9.prefab_name].transform, "story_v_out_111011", "111011019", "story_v_out_111011.awb")

						arg_79_1:RecordAudio("111011019", var_82_15)
						arg_79_1:RecordAudio("111011019", var_82_15)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_111011", "111011019", "story_v_out_111011.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_111011", "111011019", "story_v_out_111011.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_16 = math.max(var_82_7, arg_79_1.talkMaxDuration)

			if var_82_6 <= arg_79_1.time_ and arg_79_1.time_ < var_82_6 + var_82_16 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_6) / var_82_16

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_6 + var_82_16 and arg_79_1.time_ < var_82_6 + var_82_16 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play111011020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 111011020
		arg_83_1.duration_ = 6.73

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play111011021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = arg_83_1.actors_["1094ui_story"].transform
			local var_86_1 = 0

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 then
				arg_83_1.var_.moveOldPos1094ui_story = var_86_0.localPosition
			end

			local var_86_2 = 0.001

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_2 then
				local var_86_3 = (arg_83_1.time_ - var_86_1) / var_86_2
				local var_86_4 = Vector3.New(0, 100, 0)

				var_86_0.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1094ui_story, var_86_4, var_86_3)

				local var_86_5 = manager.ui.mainCamera.transform.position - var_86_0.position

				var_86_0.forward = Vector3.New(var_86_5.x, var_86_5.y, var_86_5.z)

				local var_86_6 = var_86_0.localEulerAngles

				var_86_6.z = 0
				var_86_6.x = 0
				var_86_0.localEulerAngles = var_86_6
			end

			if arg_83_1.time_ >= var_86_1 + var_86_2 and arg_83_1.time_ < var_86_1 + var_86_2 + arg_86_0 then
				var_86_0.localPosition = Vector3.New(0, 100, 0)

				local var_86_7 = manager.ui.mainCamera.transform.position - var_86_0.position

				var_86_0.forward = Vector3.New(var_86_7.x, var_86_7.y, var_86_7.z)

				local var_86_8 = var_86_0.localEulerAngles

				var_86_8.z = 0
				var_86_8.x = 0
				var_86_0.localEulerAngles = var_86_8
			end

			local var_86_9 = arg_83_1.bgs_.ST03a
			local var_86_10 = 0

			if var_86_10 < arg_83_1.time_ and arg_83_1.time_ <= var_86_10 + arg_86_0 then
				local var_86_11 = var_86_9:GetComponent("SpriteRenderer")

				if var_86_11 then
					arg_83_1.var_.alphaOldValueST03a = var_86_11.color.a
					arg_83_1.var_.alphaMatValueST03a = var_86_11
				end

				arg_83_1.var_.alphaOldValueST03a = 1
			end

			local var_86_12 = 1

			if var_86_10 <= arg_83_1.time_ and arg_83_1.time_ < var_86_10 + var_86_12 then
				local var_86_13 = (arg_83_1.time_ - var_86_10) / var_86_12
				local var_86_14 = Mathf.Lerp(arg_83_1.var_.alphaOldValueST03a, 0, var_86_13)

				if arg_83_1.var_.alphaMatValueST03a then
					local var_86_15 = arg_83_1.var_.alphaMatValueST03a.color

					var_86_15.a = var_86_14
					arg_83_1.var_.alphaMatValueST03a.color = var_86_15
				end
			end

			if arg_83_1.time_ >= var_86_10 + var_86_12 and arg_83_1.time_ < var_86_10 + var_86_12 + arg_86_0 and arg_83_1.var_.alphaMatValueST03a then
				local var_86_16 = arg_83_1.var_.alphaMatValueST03a
				local var_86_17 = var_86_16.color

				var_86_17.a = 0
				var_86_16.color = var_86_17
			end

			local var_86_18 = arg_83_1.bgs_.ST03a
			local var_86_19 = 1

			if var_86_19 < arg_83_1.time_ and arg_83_1.time_ <= var_86_19 + arg_86_0 then
				local var_86_20 = var_86_18:GetComponent("SpriteRenderer")

				if var_86_20 then
					arg_83_1.var_.alphaOldValueST03a = var_86_20.color.a
					arg_83_1.var_.alphaMatValueST03a = var_86_20
				end

				arg_83_1.var_.alphaOldValueST03a = 0
			end

			local var_86_21 = 1

			if var_86_19 <= arg_83_1.time_ and arg_83_1.time_ < var_86_19 + var_86_21 then
				local var_86_22 = (arg_83_1.time_ - var_86_19) / var_86_21
				local var_86_23 = Mathf.Lerp(arg_83_1.var_.alphaOldValueST03a, 1, var_86_22)

				if arg_83_1.var_.alphaMatValueST03a then
					local var_86_24 = arg_83_1.var_.alphaMatValueST03a.color

					var_86_24.a = var_86_23
					arg_83_1.var_.alphaMatValueST03a.color = var_86_24
				end
			end

			if arg_83_1.time_ >= var_86_19 + var_86_21 and arg_83_1.time_ < var_86_19 + var_86_21 + arg_86_0 and arg_83_1.var_.alphaMatValueST03a then
				local var_86_25 = arg_83_1.var_.alphaMatValueST03a
				local var_86_26 = var_86_25.color

				var_86_26.a = 1
				var_86_25.color = var_86_26
			end

			local var_86_27 = 0

			if var_86_27 < arg_83_1.time_ and arg_83_1.time_ <= var_86_27 + arg_86_0 then
				arg_83_1.allBtn_.enabled = false
			end

			local var_86_28 = 1.73333333333333

			if arg_83_1.time_ >= var_86_27 + var_86_28 and arg_83_1.time_ < var_86_27 + var_86_28 + arg_86_0 then
				arg_83_1.allBtn_.enabled = true
			end

			local var_86_29 = arg_83_1.bgs_.ST03a.transform
			local var_86_30 = 1

			if var_86_30 < arg_83_1.time_ and arg_83_1.time_ <= var_86_30 + arg_86_0 then
				arg_83_1.var_.moveOldPosST03a = var_86_29.localPosition
			end

			local var_86_31 = 1

			if var_86_30 <= arg_83_1.time_ and arg_83_1.time_ < var_86_30 + var_86_31 then
				local var_86_32 = (arg_83_1.time_ - var_86_30) / var_86_31
				local var_86_33 = Vector3.New(0, 1, 7)

				var_86_29.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPosST03a, var_86_33, var_86_32)
			end

			if arg_83_1.time_ >= var_86_30 + var_86_31 and arg_83_1.time_ < var_86_30 + var_86_31 + arg_86_0 then
				var_86_29.localPosition = Vector3.New(0, 1, 7)
			end

			local var_86_34 = 1.73333333333333
			local var_86_35 = 0.8

			if var_86_34 < arg_83_1.time_ and arg_83_1.time_ <= var_86_34 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_36 = arg_83_1:GetWordFromCfg(111011020)
				local var_86_37 = arg_83_1:FormatText(var_86_36.content)

				arg_83_1.text_.text = var_86_37

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_38 = 32
				local var_86_39 = utf8.len(var_86_37)
				local var_86_40 = var_86_38 <= 0 and var_86_35 or var_86_35 * (var_86_39 / var_86_38)

				if var_86_40 > 0 and var_86_35 < var_86_40 then
					arg_83_1.talkMaxDuration = var_86_40

					if var_86_40 + var_86_34 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_40 + var_86_34
					end
				end

				arg_83_1.text_.text = var_86_37
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_41 = math.max(var_86_35, arg_83_1.talkMaxDuration)

			if var_86_34 <= arg_83_1.time_ and arg_83_1.time_ < var_86_34 + var_86_41 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_34) / var_86_41

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_34 + var_86_41 and arg_83_1.time_ < var_86_34 + var_86_41 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "ST03a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_83_1:InitPlayNodeList()
	end,
	Play111011021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 111011021
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play111011022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0
			local var_90_1 = 0.7

			if var_90_0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, false)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_2 = arg_87_1:GetWordFromCfg(111011021)
				local var_90_3 = arg_87_1:FormatText(var_90_2.content)

				arg_87_1.text_.text = var_90_3

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_4 = 28
				local var_90_5 = utf8.len(var_90_3)
				local var_90_6 = var_90_4 <= 0 and var_90_1 or var_90_1 * (var_90_5 / var_90_4)

				if var_90_6 > 0 and var_90_1 < var_90_6 then
					arg_87_1.talkMaxDuration = var_90_6

					if var_90_6 + var_90_0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_6 + var_90_0
					end
				end

				arg_87_1.text_.text = var_90_3
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_7 = math.max(var_90_1, arg_87_1.talkMaxDuration)

			if var_90_0 <= arg_87_1.time_ and arg_87_1.time_ < var_90_0 + var_90_7 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_0) / var_90_7

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_0 + var_90_7 and arg_87_1.time_ < var_90_0 + var_90_7 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play111011022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 111011022
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play111011023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = arg_91_1.bgs_.ST03a
			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 then
				local var_94_2 = var_94_0:GetComponent("SpriteRenderer")

				if var_94_2 then
					arg_91_1.var_.alphaOldValueST03a = var_94_2.color.a
					arg_91_1.var_.alphaMatValueST03a = var_94_2
				end

				arg_91_1.var_.alphaOldValueST03a = 1
			end

			local var_94_3 = 1.5

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_3 then
				local var_94_4 = (arg_91_1.time_ - var_94_1) / var_94_3
				local var_94_5 = Mathf.Lerp(arg_91_1.var_.alphaOldValueST03a, 0, var_94_4)

				if arg_91_1.var_.alphaMatValueST03a then
					local var_94_6 = arg_91_1.var_.alphaMatValueST03a.color

					var_94_6.a = var_94_5
					arg_91_1.var_.alphaMatValueST03a.color = var_94_6
				end
			end

			if arg_91_1.time_ >= var_94_1 + var_94_3 and arg_91_1.time_ < var_94_1 + var_94_3 + arg_94_0 and arg_91_1.var_.alphaMatValueST03a then
				local var_94_7 = arg_91_1.var_.alphaMatValueST03a
				local var_94_8 = var_94_7.color

				var_94_8.a = 0
				var_94_7.color = var_94_8
			end

			local var_94_9 = 0

			if var_94_9 < arg_91_1.time_ and arg_91_1.time_ <= var_94_9 + arg_94_0 then
				arg_91_1.allBtn_.enabled = false
			end

			local var_94_10 = 1.5

			if arg_91_1.time_ >= var_94_9 + var_94_10 and arg_91_1.time_ < var_94_9 + var_94_10 + arg_94_0 then
				arg_91_1.allBtn_.enabled = true
			end

			local var_94_11 = 0.5
			local var_94_12 = 1

			if var_94_11 < arg_91_1.time_ and arg_91_1.time_ <= var_94_11 + arg_94_0 then
				local var_94_13 = "play"
				local var_94_14 = "music"

				arg_91_1:AudioAction(var_94_13, var_94_14, "ui_battle", "ui_battle_stopbgm", "")

				local var_94_15 = ""
				local var_94_16 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_94_16 ~= "" then
					if arg_91_1.bgmTxt_.text ~= var_94_16 and arg_91_1.bgmTxt_.text ~= "" then
						if arg_91_1.bgmTxt2_.text ~= "" then
							arg_91_1.bgmTxt_.text = arg_91_1.bgmTxt2_.text
						end

						arg_91_1.bgmTxt2_.text = var_94_16

						arg_91_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_91_1.bgmTxt_.text = var_94_16
						arg_91_1.bgmTxt2_.text = var_94_16
					end

					if arg_91_1.bgmTimer then
						arg_91_1.bgmTimer:Stop()

						arg_91_1.bgmTimer = nil
					end

					if arg_91_1.settingData.show_music_name == 1 then
						arg_91_1.musicController:SetSelectedState("show")
						arg_91_1.musicAnimator_:Play("open", 0, 0)

						if arg_91_1.settingData.music_time ~= 0 then
							arg_91_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_91_1.settingData.music_time), function()
								if arg_91_1 == nil or isNil(arg_91_1.bgmTxt_) then
									return
								end

								arg_91_1.musicController:SetSelectedState("hide")
								arg_91_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_94_17 = 0
			local var_94_18 = 0.575

			if var_94_17 < arg_91_1.time_ and arg_91_1.time_ <= var_94_17 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, false)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_19 = arg_91_1:GetWordFromCfg(111011022)
				local var_94_20 = arg_91_1:FormatText(var_94_19.content)

				arg_91_1.text_.text = var_94_20

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_21 = 23
				local var_94_22 = utf8.len(var_94_20)
				local var_94_23 = var_94_21 <= 0 and var_94_18 or var_94_18 * (var_94_22 / var_94_21)

				if var_94_23 > 0 and var_94_18 < var_94_23 then
					arg_91_1.talkMaxDuration = var_94_23

					if var_94_23 + var_94_17 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_23 + var_94_17
					end
				end

				arg_91_1.text_.text = var_94_20
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_24 = math.max(var_94_18, arg_91_1.talkMaxDuration)

			if var_94_17 <= arg_91_1.time_ and arg_91_1.time_ < var_94_17 + var_94_24 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_17) / var_94_24

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_17 + var_94_24 and arg_91_1.time_ < var_94_17 + var_94_24 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play111011023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 111011023
		arg_96_1.duration_ = 7

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play111011024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = "ST07a"

			if arg_96_1.bgs_[var_99_0] == nil then
				local var_99_1 = Object.Instantiate(arg_96_1.paintGo_)

				var_99_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_99_0)
				var_99_1.name = var_99_0
				var_99_1.transform.parent = arg_96_1.stage_.transform
				var_99_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_96_1.bgs_[var_99_0] = var_99_1
			end

			local var_99_2 = 0

			if var_99_2 < arg_96_1.time_ and arg_96_1.time_ <= var_99_2 + arg_99_0 then
				local var_99_3 = manager.ui.mainCamera.transform.localPosition
				local var_99_4 = Vector3.New(0, 0, 10) + Vector3.New(var_99_3.x, var_99_3.y, 0)
				local var_99_5 = arg_96_1.bgs_.ST07a

				var_99_5.transform.localPosition = var_99_4
				var_99_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_99_6 = var_99_5:GetComponent("SpriteRenderer")

				if var_99_6 and var_99_6.sprite then
					local var_99_7 = (var_99_5.transform.localPosition - var_99_3).z
					local var_99_8 = manager.ui.mainCameraCom_
					local var_99_9 = 2 * var_99_7 * Mathf.Tan(var_99_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_99_10 = var_99_9 * var_99_8.aspect
					local var_99_11 = var_99_6.sprite.bounds.size.x
					local var_99_12 = var_99_6.sprite.bounds.size.y
					local var_99_13 = var_99_10 / var_99_11
					local var_99_14 = var_99_9 / var_99_12
					local var_99_15 = var_99_14 < var_99_13 and var_99_13 or var_99_14

					var_99_5.transform.localScale = Vector3.New(var_99_15, var_99_15, 0)
				end

				for iter_99_0, iter_99_1 in pairs(arg_96_1.bgs_) do
					if iter_99_0 ~= "ST07a" then
						iter_99_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_99_16 = arg_96_1.bgs_.ST07a
			local var_99_17 = 0

			if var_99_17 < arg_96_1.time_ and arg_96_1.time_ <= var_99_17 + arg_99_0 then
				local var_99_18 = var_99_16:GetComponent("SpriteRenderer")

				if var_99_18 then
					arg_96_1.var_.alphaOldValueST07a = var_99_18.color.a
					arg_96_1.var_.alphaMatValueST07a = var_99_18
				end

				arg_96_1.var_.alphaOldValueST07a = 0
			end

			local var_99_19 = 1.5

			if var_99_17 <= arg_96_1.time_ and arg_96_1.time_ < var_99_17 + var_99_19 then
				local var_99_20 = (arg_96_1.time_ - var_99_17) / var_99_19
				local var_99_21 = Mathf.Lerp(arg_96_1.var_.alphaOldValueST07a, 1, var_99_20)

				if arg_96_1.var_.alphaMatValueST07a then
					local var_99_22 = arg_96_1.var_.alphaMatValueST07a.color

					var_99_22.a = var_99_21
					arg_96_1.var_.alphaMatValueST07a.color = var_99_22
				end
			end

			if arg_96_1.time_ >= var_99_17 + var_99_19 and arg_96_1.time_ < var_99_17 + var_99_19 + arg_99_0 and arg_96_1.var_.alphaMatValueST07a then
				local var_99_23 = arg_96_1.var_.alphaMatValueST07a
				local var_99_24 = var_99_23.color

				var_99_24.a = 1
				var_99_23.color = var_99_24
			end

			local var_99_25 = 0

			if var_99_25 < arg_96_1.time_ and arg_96_1.time_ <= var_99_25 + arg_99_0 then
				arg_96_1.allBtn_.enabled = false
			end

			local var_99_26 = 2

			if arg_96_1.time_ >= var_99_25 + var_99_26 and arg_96_1.time_ < var_99_25 + var_99_26 + arg_99_0 then
				arg_96_1.allBtn_.enabled = true
			end

			if arg_96_1.frameCnt_ <= 1 then
				arg_96_1.dialog_:SetActive(false)
			end

			local var_99_27 = 2
			local var_99_28 = 1.1

			if var_99_27 < arg_96_1.time_ and arg_96_1.time_ <= var_99_27 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0

				arg_96_1.dialog_:SetActive(true)

				arg_96_1.dialogCg_.alpha = 0

				local var_99_29 = LeanTween.value(arg_96_1.dialog_, 0, 1, 0.3)

				var_99_29:setOnUpdate(LuaHelper.FloatAction(function(arg_100_0)
					arg_96_1.dialogCg_.alpha = arg_100_0
				end))
				var_99_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_96_1.dialog_)
					var_99_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_96_1.duration_ = arg_96_1.duration_ + 0.3

				SetActive(arg_96_1.leftNameGo_, false)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_30 = arg_96_1:GetWordFromCfg(111011023)
				local var_99_31 = arg_96_1:FormatText(var_99_30.content)

				arg_96_1.text_.text = var_99_31

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_32 = 44
				local var_99_33 = utf8.len(var_99_31)
				local var_99_34 = var_99_32 <= 0 and var_99_28 or var_99_28 * (var_99_33 / var_99_32)

				if var_99_34 > 0 and var_99_28 < var_99_34 then
					arg_96_1.talkMaxDuration = var_99_34
					var_99_27 = var_99_27 + 0.3

					if var_99_34 + var_99_27 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_34 + var_99_27
					end
				end

				arg_96_1.text_.text = var_99_31
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_35 = var_99_27 + 0.3
			local var_99_36 = math.max(var_99_28, arg_96_1.talkMaxDuration)

			if var_99_35 <= arg_96_1.time_ and arg_96_1.time_ < var_99_35 + var_99_36 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_35) / var_99_36

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_35 + var_99_36 and arg_96_1.time_ < var_99_35 + var_99_36 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play111011024 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 111011024
		arg_102_1.duration_ = 2.23

		local var_102_0 = {
			ja = 2.233,
			ko = 1.999999999999,
			zh = 2,
			en = 2.166
		}
		local var_102_1 = manager.audio:GetLocalizationFlag()

		if var_102_0[var_102_1] ~= nil then
			arg_102_1.duration_ = var_102_0[var_102_1]
		end

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play111011025(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = "1066ui_story"

			if arg_102_1.actors_[var_105_0] == nil then
				local var_105_1 = Asset.Load("Char/" .. "1066ui_story")

				if not isNil(var_105_1) then
					local var_105_2 = Object.Instantiate(Asset.Load("Char/" .. "1066ui_story"), arg_102_1.stage_.transform)

					var_105_2.name = var_105_0
					var_105_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_102_1.actors_[var_105_0] = var_105_2

					local var_105_3 = var_105_2:GetComponentInChildren(typeof(CharacterEffect))

					var_105_3.enabled = true

					local var_105_4 = GameObjectTools.GetOrAddComponent(var_105_2, typeof(DynamicBoneHelper))

					if var_105_4 then
						var_105_4:EnableDynamicBone(false)
					end

					arg_102_1:ShowWeapon(var_105_3.transform, false)

					arg_102_1.var_[var_105_0 .. "Animator"] = var_105_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_102_1.var_[var_105_0 .. "Animator"].applyRootMotion = true
					arg_102_1.var_[var_105_0 .. "LipSync"] = var_105_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_105_5 = arg_102_1.actors_["1066ui_story"].transform
			local var_105_6 = 0

			if var_105_6 < arg_102_1.time_ and arg_102_1.time_ <= var_105_6 + arg_105_0 then
				arg_102_1.var_.moveOldPos1066ui_story = var_105_5.localPosition
			end

			local var_105_7 = 0.001

			if var_105_6 <= arg_102_1.time_ and arg_102_1.time_ < var_105_6 + var_105_7 then
				local var_105_8 = (arg_102_1.time_ - var_105_6) / var_105_7
				local var_105_9 = Vector3.New(-0.7, -0.77, -6.1)

				var_105_5.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos1066ui_story, var_105_9, var_105_8)

				local var_105_10 = manager.ui.mainCamera.transform.position - var_105_5.position

				var_105_5.forward = Vector3.New(var_105_10.x, var_105_10.y, var_105_10.z)

				local var_105_11 = var_105_5.localEulerAngles

				var_105_11.z = 0
				var_105_11.x = 0
				var_105_5.localEulerAngles = var_105_11
			end

			if arg_102_1.time_ >= var_105_6 + var_105_7 and arg_102_1.time_ < var_105_6 + var_105_7 + arg_105_0 then
				var_105_5.localPosition = Vector3.New(-0.7, -0.77, -6.1)

				local var_105_12 = manager.ui.mainCamera.transform.position - var_105_5.position

				var_105_5.forward = Vector3.New(var_105_12.x, var_105_12.y, var_105_12.z)

				local var_105_13 = var_105_5.localEulerAngles

				var_105_13.z = 0
				var_105_13.x = 0
				var_105_5.localEulerAngles = var_105_13
			end

			local var_105_14 = 0

			if var_105_14 < arg_102_1.time_ and arg_102_1.time_ <= var_105_14 + arg_105_0 then
				arg_102_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action5_1")
			end

			local var_105_15 = 0

			if var_105_15 < arg_102_1.time_ and arg_102_1.time_ <= var_105_15 + arg_105_0 then
				arg_102_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_105_16 = arg_102_1.actors_["1066ui_story"]
			local var_105_17 = 0

			if var_105_17 < arg_102_1.time_ and arg_102_1.time_ <= var_105_17 + arg_105_0 and not isNil(var_105_16) and arg_102_1.var_.characterEffect1066ui_story == nil then
				arg_102_1.var_.characterEffect1066ui_story = var_105_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_18 = 0.2

			if var_105_17 <= arg_102_1.time_ and arg_102_1.time_ < var_105_17 + var_105_18 and not isNil(var_105_16) then
				local var_105_19 = (arg_102_1.time_ - var_105_17) / var_105_18

				if arg_102_1.var_.characterEffect1066ui_story and not isNil(var_105_16) then
					arg_102_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= var_105_17 + var_105_18 and arg_102_1.time_ < var_105_17 + var_105_18 + arg_105_0 and not isNil(var_105_16) and arg_102_1.var_.characterEffect1066ui_story then
				arg_102_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_105_20 = 0
			local var_105_21 = 1

			if var_105_20 < arg_102_1.time_ and arg_102_1.time_ <= var_105_20 + arg_105_0 then
				local var_105_22 = "play"
				local var_105_23 = "music"

				arg_102_1:AudioAction(var_105_22, var_105_23, "bgm_story_office", "bgm_story_office", "bgm_story_office.awb")

				local var_105_24 = ""
				local var_105_25 = manager.audio:GetAudioName("bgm_story_office", "bgm_story_office")

				if var_105_25 ~= "" then
					if arg_102_1.bgmTxt_.text ~= var_105_25 and arg_102_1.bgmTxt_.text ~= "" then
						if arg_102_1.bgmTxt2_.text ~= "" then
							arg_102_1.bgmTxt_.text = arg_102_1.bgmTxt2_.text
						end

						arg_102_1.bgmTxt2_.text = var_105_25

						arg_102_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_102_1.bgmTxt_.text = var_105_25
						arg_102_1.bgmTxt2_.text = var_105_25
					end

					if arg_102_1.bgmTimer then
						arg_102_1.bgmTimer:Stop()

						arg_102_1.bgmTimer = nil
					end

					if arg_102_1.settingData.show_music_name == 1 then
						arg_102_1.musicController:SetSelectedState("show")
						arg_102_1.musicAnimator_:Play("open", 0, 0)

						if arg_102_1.settingData.music_time ~= 0 then
							arg_102_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_102_1.settingData.music_time), function()
								if arg_102_1 == nil or isNil(arg_102_1.bgmTxt_) then
									return
								end

								arg_102_1.musicController:SetSelectedState("hide")
								arg_102_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_105_26 = 0
			local var_105_27 = 0.125

			if var_105_26 < arg_102_1.time_ and arg_102_1.time_ <= var_105_26 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_28 = arg_102_1:FormatText(StoryNameCfg[32].name)

				arg_102_1.leftNameTxt_.text = var_105_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_29 = arg_102_1:GetWordFromCfg(111011024)
				local var_105_30 = arg_102_1:FormatText(var_105_29.content)

				arg_102_1.text_.text = var_105_30

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_31 = 5
				local var_105_32 = utf8.len(var_105_30)
				local var_105_33 = var_105_31 <= 0 and var_105_27 or var_105_27 * (var_105_32 / var_105_31)

				if var_105_33 > 0 and var_105_27 < var_105_33 then
					arg_102_1.talkMaxDuration = var_105_33

					if var_105_33 + var_105_26 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_33 + var_105_26
					end
				end

				arg_102_1.text_.text = var_105_30
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111011", "111011024", "story_v_out_111011.awb") ~= 0 then
					local var_105_34 = manager.audio:GetVoiceLength("story_v_out_111011", "111011024", "story_v_out_111011.awb") / 1000

					if var_105_34 + var_105_26 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_34 + var_105_26
					end

					if var_105_29.prefab_name ~= "" and arg_102_1.actors_[var_105_29.prefab_name] ~= nil then
						local var_105_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_29.prefab_name].transform, "story_v_out_111011", "111011024", "story_v_out_111011.awb")

						arg_102_1:RecordAudio("111011024", var_105_35)
						arg_102_1:RecordAudio("111011024", var_105_35)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_111011", "111011024", "story_v_out_111011.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_111011", "111011024", "story_v_out_111011.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_36 = math.max(var_105_27, arg_102_1.talkMaxDuration)

			if var_105_26 <= arg_102_1.time_ and arg_102_1.time_ < var_105_26 + var_105_36 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_26) / var_105_36

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_26 + var_105_36 and arg_102_1.time_ < var_105_26 + var_105_36 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_102_1:InitPlayNodeList()
	end,
	Play111011025 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 111011025
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play111011026(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.actors_["1066ui_story"]
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.characterEffect1066ui_story == nil then
				arg_107_1.var_.characterEffect1066ui_story = var_110_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_2 = 0.1

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_2 and not isNil(var_110_0) then
				local var_110_3 = (arg_107_1.time_ - var_110_1) / var_110_2

				if arg_107_1.var_.characterEffect1066ui_story and not isNil(var_110_0) then
					local var_110_4 = Mathf.Lerp(0, 0.5, var_110_3)

					arg_107_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_107_1.var_.characterEffect1066ui_story.fillRatio = var_110_4
				end
			end

			if arg_107_1.time_ >= var_110_1 + var_110_2 and arg_107_1.time_ < var_110_1 + var_110_2 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.characterEffect1066ui_story then
				local var_110_5 = 0.5

				arg_107_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_107_1.var_.characterEffect1066ui_story.fillRatio = var_110_5
			end

			local var_110_6 = 0
			local var_110_7 = 0.225

			if var_110_6 < arg_107_1.time_ and arg_107_1.time_ <= var_110_6 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_8 = arg_107_1:FormatText(StoryNameCfg[7].name)

				arg_107_1.leftNameTxt_.text = var_110_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, true)
				arg_107_1.iconController_:SetSelectedState("hero")

				arg_107_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_107_1.callingController_:SetSelectedState("normal")

				arg_107_1.keyicon_.color = Color.New(1, 1, 1)
				arg_107_1.icon_.color = Color.New(1, 1, 1)

				local var_110_9 = arg_107_1:GetWordFromCfg(111011025)
				local var_110_10 = arg_107_1:FormatText(var_110_9.content)

				arg_107_1.text_.text = var_110_10

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_11 = 9
				local var_110_12 = utf8.len(var_110_10)
				local var_110_13 = var_110_11 <= 0 and var_110_7 or var_110_7 * (var_110_12 / var_110_11)

				if var_110_13 > 0 and var_110_7 < var_110_13 then
					arg_107_1.talkMaxDuration = var_110_13

					if var_110_13 + var_110_6 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_13 + var_110_6
					end
				end

				arg_107_1.text_.text = var_110_10
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_14 = math.max(var_110_7, arg_107_1.talkMaxDuration)

			if var_110_6 <= arg_107_1.time_ and arg_107_1.time_ < var_110_6 + var_110_14 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_6) / var_110_14

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_6 + var_110_14 and arg_107_1.time_ < var_110_6 + var_110_14 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play111011026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 111011026
		arg_111_1.duration_ = 5.73

		local var_111_0 = {
			ja = 4.6,
			ko = 4.1,
			zh = 3.333,
			en = 5.733
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
				arg_111_0:Play111011027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0

			if var_114_0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_0 + arg_114_0 then
				arg_111_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 then
				arg_111_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action453")
			end

			local var_114_2 = arg_111_1.actors_["1066ui_story"]
			local var_114_3 = 0

			if var_114_3 < arg_111_1.time_ and arg_111_1.time_ <= var_114_3 + arg_114_0 and not isNil(var_114_2) and arg_111_1.var_.characterEffect1066ui_story == nil then
				arg_111_1.var_.characterEffect1066ui_story = var_114_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_4 = 0.2

			if var_114_3 <= arg_111_1.time_ and arg_111_1.time_ < var_114_3 + var_114_4 and not isNil(var_114_2) then
				local var_114_5 = (arg_111_1.time_ - var_114_3) / var_114_4

				if arg_111_1.var_.characterEffect1066ui_story and not isNil(var_114_2) then
					arg_111_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= var_114_3 + var_114_4 and arg_111_1.time_ < var_114_3 + var_114_4 + arg_114_0 and not isNil(var_114_2) and arg_111_1.var_.characterEffect1066ui_story then
				arg_111_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_114_6 = 0
			local var_114_7 = 0.45

			if var_114_6 < arg_111_1.time_ and arg_111_1.time_ <= var_114_6 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_8 = arg_111_1:FormatText(StoryNameCfg[32].name)

				arg_111_1.leftNameTxt_.text = var_114_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_9 = arg_111_1:GetWordFromCfg(111011026)
				local var_114_10 = arg_111_1:FormatText(var_114_9.content)

				arg_111_1.text_.text = var_114_10

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_11 = 18
				local var_114_12 = utf8.len(var_114_10)
				local var_114_13 = var_114_11 <= 0 and var_114_7 or var_114_7 * (var_114_12 / var_114_11)

				if var_114_13 > 0 and var_114_7 < var_114_13 then
					arg_111_1.talkMaxDuration = var_114_13

					if var_114_13 + var_114_6 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_13 + var_114_6
					end
				end

				arg_111_1.text_.text = var_114_10
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111011", "111011026", "story_v_out_111011.awb") ~= 0 then
					local var_114_14 = manager.audio:GetVoiceLength("story_v_out_111011", "111011026", "story_v_out_111011.awb") / 1000

					if var_114_14 + var_114_6 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_14 + var_114_6
					end

					if var_114_9.prefab_name ~= "" and arg_111_1.actors_[var_114_9.prefab_name] ~= nil then
						local var_114_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_9.prefab_name].transform, "story_v_out_111011", "111011026", "story_v_out_111011.awb")

						arg_111_1:RecordAudio("111011026", var_114_15)
						arg_111_1:RecordAudio("111011026", var_114_15)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_111011", "111011026", "story_v_out_111011.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_111011", "111011026", "story_v_out_111011.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_16 = math.max(var_114_7, arg_111_1.talkMaxDuration)

			if var_114_6 <= arg_111_1.time_ and arg_111_1.time_ < var_114_6 + var_114_16 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_6) / var_114_16

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_6 + var_114_16 and arg_111_1.time_ < var_114_6 + var_114_16 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play111011027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 111011027
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play111011028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["1066ui_story"]
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect1066ui_story == nil then
				arg_115_1.var_.characterEffect1066ui_story = var_118_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_2 = 0.2

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_2 and not isNil(var_118_0) then
				local var_118_3 = (arg_115_1.time_ - var_118_1) / var_118_2

				if arg_115_1.var_.characterEffect1066ui_story and not isNil(var_118_0) then
					local var_118_4 = Mathf.Lerp(0, 0.5, var_118_3)

					arg_115_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_115_1.var_.characterEffect1066ui_story.fillRatio = var_118_4
				end
			end

			if arg_115_1.time_ >= var_118_1 + var_118_2 and arg_115_1.time_ < var_118_1 + var_118_2 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect1066ui_story then
				local var_118_5 = 0.5

				arg_115_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_115_1.var_.characterEffect1066ui_story.fillRatio = var_118_5
			end

			local var_118_6 = 0
			local var_118_7 = 0.25

			if var_118_6 < arg_115_1.time_ and arg_115_1.time_ <= var_118_6 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_8 = arg_115_1:FormatText(StoryNameCfg[7].name)

				arg_115_1.leftNameTxt_.text = var_118_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, true)
				arg_115_1.iconController_:SetSelectedState("hero")

				arg_115_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_115_1.callingController_:SetSelectedState("normal")

				arg_115_1.keyicon_.color = Color.New(1, 1, 1)
				arg_115_1.icon_.color = Color.New(1, 1, 1)

				local var_118_9 = arg_115_1:GetWordFromCfg(111011027)
				local var_118_10 = arg_115_1:FormatText(var_118_9.content)

				arg_115_1.text_.text = var_118_10

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_11 = 10
				local var_118_12 = utf8.len(var_118_10)
				local var_118_13 = var_118_11 <= 0 and var_118_7 or var_118_7 * (var_118_12 / var_118_11)

				if var_118_13 > 0 and var_118_7 < var_118_13 then
					arg_115_1.talkMaxDuration = var_118_13

					if var_118_13 + var_118_6 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_13 + var_118_6
					end
				end

				arg_115_1.text_.text = var_118_10
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_14 = math.max(var_118_7, arg_115_1.talkMaxDuration)

			if var_118_6 <= arg_115_1.time_ and arg_115_1.time_ < var_118_6 + var_118_14 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_6) / var_118_14

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_6 + var_118_14 and arg_115_1.time_ < var_118_6 + var_118_14 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play111011028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 111011028
		arg_119_1.duration_ = 5.67

		local var_119_0 = {
			ja = 5.233,
			ko = 4.533,
			zh = 4.933,
			en = 5.666
		}
		local var_119_1 = manager.audio:GetLocalizationFlag()

		if var_119_0[var_119_1] ~= nil then
			arg_119_1.duration_ = var_119_0[var_119_1]
		end

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play111011029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 0

			if var_122_0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_0 + arg_122_0 then
				arg_119_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 then
				arg_119_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_122_2 = arg_119_1.actors_["1066ui_story"]
			local var_122_3 = 0

			if var_122_3 < arg_119_1.time_ and arg_119_1.time_ <= var_122_3 + arg_122_0 and not isNil(var_122_2) and arg_119_1.var_.characterEffect1066ui_story == nil then
				arg_119_1.var_.characterEffect1066ui_story = var_122_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_4 = 0.2

			if var_122_3 <= arg_119_1.time_ and arg_119_1.time_ < var_122_3 + var_122_4 and not isNil(var_122_2) then
				local var_122_5 = (arg_119_1.time_ - var_122_3) / var_122_4

				if arg_119_1.var_.characterEffect1066ui_story and not isNil(var_122_2) then
					arg_119_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= var_122_3 + var_122_4 and arg_119_1.time_ < var_122_3 + var_122_4 + arg_122_0 and not isNil(var_122_2) and arg_119_1.var_.characterEffect1066ui_story then
				arg_119_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_122_6 = 0
			local var_122_7 = 0.725

			if var_122_6 < arg_119_1.time_ and arg_119_1.time_ <= var_122_6 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_8 = arg_119_1:FormatText(StoryNameCfg[32].name)

				arg_119_1.leftNameTxt_.text = var_122_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_9 = arg_119_1:GetWordFromCfg(111011028)
				local var_122_10 = arg_119_1:FormatText(var_122_9.content)

				arg_119_1.text_.text = var_122_10

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_11 = 29
				local var_122_12 = utf8.len(var_122_10)
				local var_122_13 = var_122_11 <= 0 and var_122_7 or var_122_7 * (var_122_12 / var_122_11)

				if var_122_13 > 0 and var_122_7 < var_122_13 then
					arg_119_1.talkMaxDuration = var_122_13

					if var_122_13 + var_122_6 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_13 + var_122_6
					end
				end

				arg_119_1.text_.text = var_122_10
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111011", "111011028", "story_v_out_111011.awb") ~= 0 then
					local var_122_14 = manager.audio:GetVoiceLength("story_v_out_111011", "111011028", "story_v_out_111011.awb") / 1000

					if var_122_14 + var_122_6 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_14 + var_122_6
					end

					if var_122_9.prefab_name ~= "" and arg_119_1.actors_[var_122_9.prefab_name] ~= nil then
						local var_122_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_9.prefab_name].transform, "story_v_out_111011", "111011028", "story_v_out_111011.awb")

						arg_119_1:RecordAudio("111011028", var_122_15)
						arg_119_1:RecordAudio("111011028", var_122_15)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_111011", "111011028", "story_v_out_111011.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_111011", "111011028", "story_v_out_111011.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_16 = math.max(var_122_7, arg_119_1.talkMaxDuration)

			if var_122_6 <= arg_119_1.time_ and arg_119_1.time_ < var_122_6 + var_122_16 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_6) / var_122_16

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_6 + var_122_16 and arg_119_1.time_ < var_122_6 + var_122_16 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play111011029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 111011029
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play111011030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["1066ui_story"]
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.characterEffect1066ui_story == nil then
				arg_123_1.var_.characterEffect1066ui_story = var_126_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_2 = 0.225

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_2 and not isNil(var_126_0) then
				local var_126_3 = (arg_123_1.time_ - var_126_1) / var_126_2

				if arg_123_1.var_.characterEffect1066ui_story and not isNil(var_126_0) then
					local var_126_4 = Mathf.Lerp(0, 0.5, var_126_3)

					arg_123_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_123_1.var_.characterEffect1066ui_story.fillRatio = var_126_4
				end
			end

			if arg_123_1.time_ >= var_126_1 + var_126_2 and arg_123_1.time_ < var_126_1 + var_126_2 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.characterEffect1066ui_story then
				local var_126_5 = 0.5

				arg_123_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_123_1.var_.characterEffect1066ui_story.fillRatio = var_126_5
			end

			local var_126_6 = 0
			local var_126_7 = 0.225

			if var_126_6 < arg_123_1.time_ and arg_123_1.time_ <= var_126_6 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_8 = arg_123_1:FormatText(StoryNameCfg[7].name)

				arg_123_1.leftNameTxt_.text = var_126_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, true)
				arg_123_1.iconController_:SetSelectedState("hero")

				arg_123_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_123_1.callingController_:SetSelectedState("normal")

				arg_123_1.keyicon_.color = Color.New(1, 1, 1)
				arg_123_1.icon_.color = Color.New(1, 1, 1)

				local var_126_9 = arg_123_1:GetWordFromCfg(111011029)
				local var_126_10 = arg_123_1:FormatText(var_126_9.content)

				arg_123_1.text_.text = var_126_10

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_11 = 9
				local var_126_12 = utf8.len(var_126_10)
				local var_126_13 = var_126_11 <= 0 and var_126_7 or var_126_7 * (var_126_12 / var_126_11)

				if var_126_13 > 0 and var_126_7 < var_126_13 then
					arg_123_1.talkMaxDuration = var_126_13

					if var_126_13 + var_126_6 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_13 + var_126_6
					end
				end

				arg_123_1.text_.text = var_126_10
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_14 = math.max(var_126_7, arg_123_1.talkMaxDuration)

			if var_126_6 <= arg_123_1.time_ and arg_123_1.time_ < var_126_6 + var_126_14 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_6) / var_126_14

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_6 + var_126_14 and arg_123_1.time_ < var_126_6 + var_126_14 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play111011030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 111011030
		arg_127_1.duration_ = 6.13

		local var_127_0 = {
			ja = 4.666,
			ko = 4.5,
			zh = 5.633,
			en = 6.133
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
				arg_127_0:Play111011031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = "1019ui_story"

			if arg_127_1.actors_[var_130_0] == nil then
				local var_130_1 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_130_1) then
					local var_130_2 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_127_1.stage_.transform)

					var_130_2.name = var_130_0
					var_130_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_127_1.actors_[var_130_0] = var_130_2

					local var_130_3 = var_130_2:GetComponentInChildren(typeof(CharacterEffect))

					var_130_3.enabled = true

					local var_130_4 = GameObjectTools.GetOrAddComponent(var_130_2, typeof(DynamicBoneHelper))

					if var_130_4 then
						var_130_4:EnableDynamicBone(false)
					end

					arg_127_1:ShowWeapon(var_130_3.transform, false)

					arg_127_1.var_[var_130_0 .. "Animator"] = var_130_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_127_1.var_[var_130_0 .. "Animator"].applyRootMotion = true
					arg_127_1.var_[var_130_0 .. "LipSync"] = var_130_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_130_5 = arg_127_1.actors_["1019ui_story"].transform
			local var_130_6 = 0

			if var_130_6 < arg_127_1.time_ and arg_127_1.time_ <= var_130_6 + arg_130_0 then
				arg_127_1.var_.moveOldPos1019ui_story = var_130_5.localPosition
			end

			local var_130_7 = 0.001

			if var_130_6 <= arg_127_1.time_ and arg_127_1.time_ < var_130_6 + var_130_7 then
				local var_130_8 = (arg_127_1.time_ - var_130_6) / var_130_7
				local var_130_9 = Vector3.New(0.7, -1.08, -5.9)

				var_130_5.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1019ui_story, var_130_9, var_130_8)

				local var_130_10 = manager.ui.mainCamera.transform.position - var_130_5.position

				var_130_5.forward = Vector3.New(var_130_10.x, var_130_10.y, var_130_10.z)

				local var_130_11 = var_130_5.localEulerAngles

				var_130_11.z = 0
				var_130_11.x = 0
				var_130_5.localEulerAngles = var_130_11
			end

			if arg_127_1.time_ >= var_130_6 + var_130_7 and arg_127_1.time_ < var_130_6 + var_130_7 + arg_130_0 then
				var_130_5.localPosition = Vector3.New(0.7, -1.08, -5.9)

				local var_130_12 = manager.ui.mainCamera.transform.position - var_130_5.position

				var_130_5.forward = Vector3.New(var_130_12.x, var_130_12.y, var_130_12.z)

				local var_130_13 = var_130_5.localEulerAngles

				var_130_13.z = 0
				var_130_13.x = 0
				var_130_5.localEulerAngles = var_130_13
			end

			local var_130_14 = 0

			if var_130_14 < arg_127_1.time_ and arg_127_1.time_ <= var_130_14 + arg_130_0 then
				arg_127_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_1")
			end

			local var_130_15 = 0

			if var_130_15 < arg_127_1.time_ and arg_127_1.time_ <= var_130_15 + arg_130_0 then
				arg_127_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_130_16 = arg_127_1.actors_["1019ui_story"]
			local var_130_17 = 0

			if var_130_17 < arg_127_1.time_ and arg_127_1.time_ <= var_130_17 + arg_130_0 and not isNil(var_130_16) and arg_127_1.var_.characterEffect1019ui_story == nil then
				arg_127_1.var_.characterEffect1019ui_story = var_130_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_18 = 0.2

			if var_130_17 <= arg_127_1.time_ and arg_127_1.time_ < var_130_17 + var_130_18 and not isNil(var_130_16) then
				local var_130_19 = (arg_127_1.time_ - var_130_17) / var_130_18

				if arg_127_1.var_.characterEffect1019ui_story and not isNil(var_130_16) then
					arg_127_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= var_130_17 + var_130_18 and arg_127_1.time_ < var_130_17 + var_130_18 + arg_130_0 and not isNil(var_130_16) and arg_127_1.var_.characterEffect1019ui_story then
				arg_127_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_130_20 = 0
			local var_130_21 = 0.75

			if var_130_20 < arg_127_1.time_ and arg_127_1.time_ <= var_130_20 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_22 = arg_127_1:FormatText(StoryNameCfg[13].name)

				arg_127_1.leftNameTxt_.text = var_130_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_23 = arg_127_1:GetWordFromCfg(111011030)
				local var_130_24 = arg_127_1:FormatText(var_130_23.content)

				arg_127_1.text_.text = var_130_24

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_25 = 30
				local var_130_26 = utf8.len(var_130_24)
				local var_130_27 = var_130_25 <= 0 and var_130_21 or var_130_21 * (var_130_26 / var_130_25)

				if var_130_27 > 0 and var_130_21 < var_130_27 then
					arg_127_1.talkMaxDuration = var_130_27

					if var_130_27 + var_130_20 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_27 + var_130_20
					end
				end

				arg_127_1.text_.text = var_130_24
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111011", "111011030", "story_v_out_111011.awb") ~= 0 then
					local var_130_28 = manager.audio:GetVoiceLength("story_v_out_111011", "111011030", "story_v_out_111011.awb") / 1000

					if var_130_28 + var_130_20 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_28 + var_130_20
					end

					if var_130_23.prefab_name ~= "" and arg_127_1.actors_[var_130_23.prefab_name] ~= nil then
						local var_130_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_23.prefab_name].transform, "story_v_out_111011", "111011030", "story_v_out_111011.awb")

						arg_127_1:RecordAudio("111011030", var_130_29)
						arg_127_1:RecordAudio("111011030", var_130_29)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_111011", "111011030", "story_v_out_111011.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_111011", "111011030", "story_v_out_111011.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_30 = math.max(var_130_21, arg_127_1.talkMaxDuration)

			if var_130_20 <= arg_127_1.time_ and arg_127_1.time_ < var_130_20 + var_130_30 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_20) / var_130_30

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_20 + var_130_30 and arg_127_1.time_ < var_130_20 + var_130_30 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_127_1:InitPlayNodeList()
	end,
	Play111011031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 111011031
		arg_131_1.duration_ = 13.1

		local var_131_0 = {
			ja = 13.1,
			ko = 8.633,
			zh = 7.7,
			en = 9.233
		}
		local var_131_1 = manager.audio:GetLocalizationFlag()

		if var_131_0[var_131_1] ~= nil then
			arg_131_1.duration_ = var_131_0[var_131_1]
		end

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play111011032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0

			if var_134_0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_0 + arg_134_0 then
				arg_131_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_134_1 = arg_131_1.actors_["1019ui_story"]
			local var_134_2 = 0

			if var_134_2 < arg_131_1.time_ and arg_131_1.time_ <= var_134_2 + arg_134_0 and not isNil(var_134_1) and arg_131_1.var_.characterEffect1019ui_story == nil then
				arg_131_1.var_.characterEffect1019ui_story = var_134_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_3 = 0.2

			if var_134_2 <= arg_131_1.time_ and arg_131_1.time_ < var_134_2 + var_134_3 and not isNil(var_134_1) then
				local var_134_4 = (arg_131_1.time_ - var_134_2) / var_134_3

				if arg_131_1.var_.characterEffect1019ui_story and not isNil(var_134_1) then
					arg_131_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= var_134_2 + var_134_3 and arg_131_1.time_ < var_134_2 + var_134_3 + arg_134_0 and not isNil(var_134_1) and arg_131_1.var_.characterEffect1019ui_story then
				arg_131_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_134_5 = 0
			local var_134_6 = 0.9

			if var_134_5 < arg_131_1.time_ and arg_131_1.time_ <= var_134_5 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_7 = arg_131_1:FormatText(StoryNameCfg[13].name)

				arg_131_1.leftNameTxt_.text = var_134_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_8 = arg_131_1:GetWordFromCfg(111011031)
				local var_134_9 = arg_131_1:FormatText(var_134_8.content)

				arg_131_1.text_.text = var_134_9

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_10 = 36
				local var_134_11 = utf8.len(var_134_9)
				local var_134_12 = var_134_10 <= 0 and var_134_6 or var_134_6 * (var_134_11 / var_134_10)

				if var_134_12 > 0 and var_134_6 < var_134_12 then
					arg_131_1.talkMaxDuration = var_134_12

					if var_134_12 + var_134_5 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_12 + var_134_5
					end
				end

				arg_131_1.text_.text = var_134_9
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111011", "111011031", "story_v_out_111011.awb") ~= 0 then
					local var_134_13 = manager.audio:GetVoiceLength("story_v_out_111011", "111011031", "story_v_out_111011.awb") / 1000

					if var_134_13 + var_134_5 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_13 + var_134_5
					end

					if var_134_8.prefab_name ~= "" and arg_131_1.actors_[var_134_8.prefab_name] ~= nil then
						local var_134_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_8.prefab_name].transform, "story_v_out_111011", "111011031", "story_v_out_111011.awb")

						arg_131_1:RecordAudio("111011031", var_134_14)
						arg_131_1:RecordAudio("111011031", var_134_14)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_111011", "111011031", "story_v_out_111011.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_111011", "111011031", "story_v_out_111011.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_15 = math.max(var_134_6, arg_131_1.talkMaxDuration)

			if var_134_5 <= arg_131_1.time_ and arg_131_1.time_ < var_134_5 + var_134_15 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_5) / var_134_15

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_5 + var_134_15 and arg_131_1.time_ < var_134_5 + var_134_15 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play111011032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 111011032
		arg_135_1.duration_ = 6.5

		local var_135_0 = {
			ja = 4.533,
			ko = 6.5,
			zh = 4.566,
			en = 5.333
		}
		local var_135_1 = manager.audio:GetLocalizationFlag()

		if var_135_0[var_135_1] ~= nil then
			arg_135_1.duration_ = var_135_0[var_135_1]
		end

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play111011033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 0

			if var_138_0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_0 + arg_138_0 then
				arg_135_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action434")
			end

			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 then
				arg_135_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_138_2 = arg_135_1.actors_["1066ui_story"]
			local var_138_3 = 0

			if var_138_3 < arg_135_1.time_ and arg_135_1.time_ <= var_138_3 + arg_138_0 and not isNil(var_138_2) and arg_135_1.var_.characterEffect1066ui_story == nil then
				arg_135_1.var_.characterEffect1066ui_story = var_138_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_4 = 0.2

			if var_138_3 <= arg_135_1.time_ and arg_135_1.time_ < var_138_3 + var_138_4 and not isNil(var_138_2) then
				local var_138_5 = (arg_135_1.time_ - var_138_3) / var_138_4

				if arg_135_1.var_.characterEffect1066ui_story and not isNil(var_138_2) then
					arg_135_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= var_138_3 + var_138_4 and arg_135_1.time_ < var_138_3 + var_138_4 + arg_138_0 and not isNil(var_138_2) and arg_135_1.var_.characterEffect1066ui_story then
				arg_135_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_138_6 = arg_135_1.actors_["1019ui_story"]
			local var_138_7 = 0

			if var_138_7 < arg_135_1.time_ and arg_135_1.time_ <= var_138_7 + arg_138_0 and not isNil(var_138_6) and arg_135_1.var_.characterEffect1019ui_story == nil then
				arg_135_1.var_.characterEffect1019ui_story = var_138_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_8 = 0.2

			if var_138_7 <= arg_135_1.time_ and arg_135_1.time_ < var_138_7 + var_138_8 and not isNil(var_138_6) then
				local var_138_9 = (arg_135_1.time_ - var_138_7) / var_138_8

				if arg_135_1.var_.characterEffect1019ui_story and not isNil(var_138_6) then
					local var_138_10 = Mathf.Lerp(0, 0.5, var_138_9)

					arg_135_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_135_1.var_.characterEffect1019ui_story.fillRatio = var_138_10
				end
			end

			if arg_135_1.time_ >= var_138_7 + var_138_8 and arg_135_1.time_ < var_138_7 + var_138_8 + arg_138_0 and not isNil(var_138_6) and arg_135_1.var_.characterEffect1019ui_story then
				local var_138_11 = 0.5

				arg_135_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_135_1.var_.characterEffect1019ui_story.fillRatio = var_138_11
			end

			local var_138_12 = 0
			local var_138_13 = 0.65

			if var_138_12 < arg_135_1.time_ and arg_135_1.time_ <= var_138_12 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_14 = arg_135_1:FormatText(StoryNameCfg[32].name)

				arg_135_1.leftNameTxt_.text = var_138_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_15 = arg_135_1:GetWordFromCfg(111011032)
				local var_138_16 = arg_135_1:FormatText(var_138_15.content)

				arg_135_1.text_.text = var_138_16

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_17 = 26
				local var_138_18 = utf8.len(var_138_16)
				local var_138_19 = var_138_17 <= 0 and var_138_13 or var_138_13 * (var_138_18 / var_138_17)

				if var_138_19 > 0 and var_138_13 < var_138_19 then
					arg_135_1.talkMaxDuration = var_138_19

					if var_138_19 + var_138_12 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_19 + var_138_12
					end
				end

				arg_135_1.text_.text = var_138_16
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111011", "111011032", "story_v_out_111011.awb") ~= 0 then
					local var_138_20 = manager.audio:GetVoiceLength("story_v_out_111011", "111011032", "story_v_out_111011.awb") / 1000

					if var_138_20 + var_138_12 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_20 + var_138_12
					end

					if var_138_15.prefab_name ~= "" and arg_135_1.actors_[var_138_15.prefab_name] ~= nil then
						local var_138_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_15.prefab_name].transform, "story_v_out_111011", "111011032", "story_v_out_111011.awb")

						arg_135_1:RecordAudio("111011032", var_138_21)
						arg_135_1:RecordAudio("111011032", var_138_21)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_111011", "111011032", "story_v_out_111011.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_111011", "111011032", "story_v_out_111011.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_22 = math.max(var_138_13, arg_135_1.talkMaxDuration)

			if var_138_12 <= arg_135_1.time_ and arg_135_1.time_ < var_138_12 + var_138_22 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_12) / var_138_22

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_12 + var_138_22 and arg_135_1.time_ < var_138_12 + var_138_22 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play111011033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 111011033
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play111011034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["1066ui_story"]
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.characterEffect1066ui_story == nil then
				arg_139_1.var_.characterEffect1066ui_story = var_142_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_2 = 0.2

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 and not isNil(var_142_0) then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / var_142_2

				if arg_139_1.var_.characterEffect1066ui_story and not isNil(var_142_0) then
					local var_142_4 = Mathf.Lerp(0, 0.5, var_142_3)

					arg_139_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_139_1.var_.characterEffect1066ui_story.fillRatio = var_142_4
				end
			end

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.characterEffect1066ui_story then
				local var_142_5 = 0.5

				arg_139_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_139_1.var_.characterEffect1066ui_story.fillRatio = var_142_5
			end

			local var_142_6 = 0
			local var_142_7 = 0.725

			if var_142_6 < arg_139_1.time_ and arg_139_1.time_ <= var_142_6 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, false)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_8 = arg_139_1:GetWordFromCfg(111011033)
				local var_142_9 = arg_139_1:FormatText(var_142_8.content)

				arg_139_1.text_.text = var_142_9

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_10 = 29
				local var_142_11 = utf8.len(var_142_9)
				local var_142_12 = var_142_10 <= 0 and var_142_7 or var_142_7 * (var_142_11 / var_142_10)

				if var_142_12 > 0 and var_142_7 < var_142_12 then
					arg_139_1.talkMaxDuration = var_142_12

					if var_142_12 + var_142_6 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_12 + var_142_6
					end
				end

				arg_139_1.text_.text = var_142_9
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_13 = math.max(var_142_7, arg_139_1.talkMaxDuration)

			if var_142_6 <= arg_139_1.time_ and arg_139_1.time_ < var_142_6 + var_142_13 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_6) / var_142_13

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_6 + var_142_13 and arg_139_1.time_ < var_142_6 + var_142_13 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play111011034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 111011034
		arg_143_1.duration_ = 7.9

		local var_143_0 = {
			ja = 7.9,
			ko = 4.833,
			zh = 4.333,
			en = 6.1
		}
		local var_143_1 = manager.audio:GetLocalizationFlag()

		if var_143_0[var_143_1] ~= nil then
			arg_143_1.duration_ = var_143_0[var_143_1]
		end

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play111011035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0

			if var_146_0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_0 + arg_146_0 then
				arg_143_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_2")
			end

			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 then
				arg_143_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_146_2 = arg_143_1.actors_["1019ui_story"]
			local var_146_3 = 0

			if var_146_3 < arg_143_1.time_ and arg_143_1.time_ <= var_146_3 + arg_146_0 and not isNil(var_146_2) and arg_143_1.var_.characterEffect1019ui_story == nil then
				arg_143_1.var_.characterEffect1019ui_story = var_146_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_4 = 0.2

			if var_146_3 <= arg_143_1.time_ and arg_143_1.time_ < var_146_3 + var_146_4 and not isNil(var_146_2) then
				local var_146_5 = (arg_143_1.time_ - var_146_3) / var_146_4

				if arg_143_1.var_.characterEffect1019ui_story and not isNil(var_146_2) then
					arg_143_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= var_146_3 + var_146_4 and arg_143_1.time_ < var_146_3 + var_146_4 + arg_146_0 and not isNil(var_146_2) and arg_143_1.var_.characterEffect1019ui_story then
				arg_143_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_146_6 = 0
			local var_146_7 = 0.45

			if var_146_6 < arg_143_1.time_ and arg_143_1.time_ <= var_146_6 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_8 = arg_143_1:FormatText(StoryNameCfg[13].name)

				arg_143_1.leftNameTxt_.text = var_146_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_9 = arg_143_1:GetWordFromCfg(111011034)
				local var_146_10 = arg_143_1:FormatText(var_146_9.content)

				arg_143_1.text_.text = var_146_10

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_11 = 18
				local var_146_12 = utf8.len(var_146_10)
				local var_146_13 = var_146_11 <= 0 and var_146_7 or var_146_7 * (var_146_12 / var_146_11)

				if var_146_13 > 0 and var_146_7 < var_146_13 then
					arg_143_1.talkMaxDuration = var_146_13

					if var_146_13 + var_146_6 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_13 + var_146_6
					end
				end

				arg_143_1.text_.text = var_146_10
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111011", "111011034", "story_v_out_111011.awb") ~= 0 then
					local var_146_14 = manager.audio:GetVoiceLength("story_v_out_111011", "111011034", "story_v_out_111011.awb") / 1000

					if var_146_14 + var_146_6 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_14 + var_146_6
					end

					if var_146_9.prefab_name ~= "" and arg_143_1.actors_[var_146_9.prefab_name] ~= nil then
						local var_146_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_9.prefab_name].transform, "story_v_out_111011", "111011034", "story_v_out_111011.awb")

						arg_143_1:RecordAudio("111011034", var_146_15)
						arg_143_1:RecordAudio("111011034", var_146_15)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_111011", "111011034", "story_v_out_111011.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_111011", "111011034", "story_v_out_111011.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_16 = math.max(var_146_7, arg_143_1.talkMaxDuration)

			if var_146_6 <= arg_143_1.time_ and arg_143_1.time_ < var_146_6 + var_146_16 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_6) / var_146_16

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_6 + var_146_16 and arg_143_1.time_ < var_146_6 + var_146_16 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play111011035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 111011035
		arg_147_1.duration_ = 0.2

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"

			SetActive(arg_147_1.choicesGo_, true)

			for iter_148_0, iter_148_1 in ipairs(arg_147_1.choices_) do
				local var_148_0 = iter_148_0 <= 2

				SetActive(iter_148_1.go, var_148_0)
			end

			arg_147_1.choices_[1].txt.text = arg_147_1:FormatText(StoryChoiceCfg[112].name)
			arg_147_1.choices_[2].txt.text = arg_147_1:FormatText(StoryChoiceCfg[113].name)
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play111011036(arg_147_1)
			end

			if arg_149_0 == 2 then
				arg_147_0:Play111011036(arg_147_1)
			end

			arg_147_1:RecordChoiceLog(111011035, 112, 113)
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = arg_147_1.actors_["1019ui_story"]
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.characterEffect1019ui_story == nil then
				arg_147_1.var_.characterEffect1019ui_story = var_150_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_2 = 0.2

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_2 and not isNil(var_150_0) then
				local var_150_3 = (arg_147_1.time_ - var_150_1) / var_150_2

				if arg_147_1.var_.characterEffect1019ui_story and not isNil(var_150_0) then
					local var_150_4 = Mathf.Lerp(0, 0.5, var_150_3)

					arg_147_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_147_1.var_.characterEffect1019ui_story.fillRatio = var_150_4
				end
			end

			if arg_147_1.time_ >= var_150_1 + var_150_2 and arg_147_1.time_ < var_150_1 + var_150_2 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.characterEffect1019ui_story then
				local var_150_5 = 0.5

				arg_147_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_147_1.var_.characterEffect1019ui_story.fillRatio = var_150_5
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play111011036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 111011036
		arg_151_1.duration_ = 14.27

		local var_151_0 = {
			ja = 12.5,
			ko = 14.266,
			zh = 13.1,
			en = 14.233
		}
		local var_151_1 = manager.audio:GetLocalizationFlag()

		if var_151_0[var_151_1] ~= nil then
			arg_151_1.duration_ = var_151_0[var_151_1]
		end

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play111011037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["1019ui_story"]
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect1019ui_story == nil then
				arg_151_1.var_.characterEffect1019ui_story = var_154_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.2

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 and not isNil(var_154_0) then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2

				if arg_151_1.var_.characterEffect1019ui_story and not isNil(var_154_0) then
					arg_151_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect1019ui_story then
				arg_151_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_154_4 = 0
			local var_154_5 = 1.825

			if var_154_4 < arg_151_1.time_ and arg_151_1.time_ <= var_154_4 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0

				arg_151_1.dialog_:SetActive(true)

				arg_151_1.dialogCg_.alpha = 0

				local var_154_6 = LeanTween.value(arg_151_1.dialog_, 0, 1, 0.3)

				var_154_6:setOnUpdate(LuaHelper.FloatAction(function(arg_155_0)
					arg_151_1.dialogCg_.alpha = arg_155_0
				end))
				var_154_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_151_1.dialog_)
					var_154_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_151_1.duration_ = arg_151_1.duration_ + 0.3

				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_7 = arg_151_1:FormatText(StoryNameCfg[13].name)

				arg_151_1.leftNameTxt_.text = var_154_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_8 = arg_151_1:GetWordFromCfg(111011036)
				local var_154_9 = arg_151_1:FormatText(var_154_8.content)

				arg_151_1.text_.text = var_154_9

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_10 = 73
				local var_154_11 = utf8.len(var_154_9)
				local var_154_12 = var_154_10 <= 0 and var_154_5 or var_154_5 * (var_154_11 / var_154_10)

				if var_154_12 > 0 and var_154_5 < var_154_12 then
					arg_151_1.talkMaxDuration = var_154_12
					var_154_4 = var_154_4 + 0.3

					if var_154_12 + var_154_4 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_12 + var_154_4
					end
				end

				arg_151_1.text_.text = var_154_9
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111011", "111011036", "story_v_out_111011.awb") ~= 0 then
					local var_154_13 = manager.audio:GetVoiceLength("story_v_out_111011", "111011036", "story_v_out_111011.awb") / 1000

					if var_154_13 + var_154_4 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_13 + var_154_4
					end

					if var_154_8.prefab_name ~= "" and arg_151_1.actors_[var_154_8.prefab_name] ~= nil then
						local var_154_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_8.prefab_name].transform, "story_v_out_111011", "111011036", "story_v_out_111011.awb")

						arg_151_1:RecordAudio("111011036", var_154_14)
						arg_151_1:RecordAudio("111011036", var_154_14)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_111011", "111011036", "story_v_out_111011.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_111011", "111011036", "story_v_out_111011.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_15 = var_154_4 + 0.3
			local var_154_16 = math.max(var_154_5, arg_151_1.talkMaxDuration)

			if var_154_15 <= arg_151_1.time_ and arg_151_1.time_ < var_154_15 + var_154_16 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_15) / var_154_16

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_15 + var_154_16 and arg_151_1.time_ < var_154_15 + var_154_16 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play111011037 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 111011037
		arg_157_1.duration_ = 13.1

		local var_157_0 = {
			ja = 10.866,
			ko = 9.2,
			zh = 8.466,
			en = 13.1
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
				arg_157_0:Play111011038(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0

			if var_160_0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_0 + arg_160_0 then
				arg_157_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 then
				arg_157_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_160_2 = arg_157_1.actors_["1019ui_story"]
			local var_160_3 = 0

			if var_160_3 < arg_157_1.time_ and arg_157_1.time_ <= var_160_3 + arg_160_0 and not isNil(var_160_2) and arg_157_1.var_.characterEffect1019ui_story == nil then
				arg_157_1.var_.characterEffect1019ui_story = var_160_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_4 = 0.2

			if var_160_3 <= arg_157_1.time_ and arg_157_1.time_ < var_160_3 + var_160_4 and not isNil(var_160_2) then
				local var_160_5 = (arg_157_1.time_ - var_160_3) / var_160_4

				if arg_157_1.var_.characterEffect1019ui_story and not isNil(var_160_2) then
					arg_157_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= var_160_3 + var_160_4 and arg_157_1.time_ < var_160_3 + var_160_4 + arg_160_0 and not isNil(var_160_2) and arg_157_1.var_.characterEffect1019ui_story then
				arg_157_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_160_6 = 0
			local var_160_7 = 1.05

			if var_160_6 < arg_157_1.time_ and arg_157_1.time_ <= var_160_6 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_8 = arg_157_1:FormatText(StoryNameCfg[13].name)

				arg_157_1.leftNameTxt_.text = var_160_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_9 = arg_157_1:GetWordFromCfg(111011037)
				local var_160_10 = arg_157_1:FormatText(var_160_9.content)

				arg_157_1.text_.text = var_160_10

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_11 = 44
				local var_160_12 = utf8.len(var_160_10)
				local var_160_13 = var_160_11 <= 0 and var_160_7 or var_160_7 * (var_160_12 / var_160_11)

				if var_160_13 > 0 and var_160_7 < var_160_13 then
					arg_157_1.talkMaxDuration = var_160_13

					if var_160_13 + var_160_6 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_13 + var_160_6
					end
				end

				arg_157_1.text_.text = var_160_10
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111011", "111011037", "story_v_out_111011.awb") ~= 0 then
					local var_160_14 = manager.audio:GetVoiceLength("story_v_out_111011", "111011037", "story_v_out_111011.awb") / 1000

					if var_160_14 + var_160_6 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_14 + var_160_6
					end

					if var_160_9.prefab_name ~= "" and arg_157_1.actors_[var_160_9.prefab_name] ~= nil then
						local var_160_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_9.prefab_name].transform, "story_v_out_111011", "111011037", "story_v_out_111011.awb")

						arg_157_1:RecordAudio("111011037", var_160_15)
						arg_157_1:RecordAudio("111011037", var_160_15)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_111011", "111011037", "story_v_out_111011.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_111011", "111011037", "story_v_out_111011.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_16 = math.max(var_160_7, arg_157_1.talkMaxDuration)

			if var_160_6 <= arg_157_1.time_ and arg_157_1.time_ < var_160_6 + var_160_16 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_6) / var_160_16

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_6 + var_160_16 and arg_157_1.time_ < var_160_6 + var_160_16 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play111011038 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 111011038
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play111011039(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = arg_161_1.actors_["1019ui_story"]
			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.characterEffect1019ui_story == nil then
				arg_161_1.var_.characterEffect1019ui_story = var_164_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_2 = 0.2

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_2 and not isNil(var_164_0) then
				local var_164_3 = (arg_161_1.time_ - var_164_1) / var_164_2

				if arg_161_1.var_.characterEffect1019ui_story and not isNil(var_164_0) then
					local var_164_4 = Mathf.Lerp(0, 0.5, var_164_3)

					arg_161_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_161_1.var_.characterEffect1019ui_story.fillRatio = var_164_4
				end
			end

			if arg_161_1.time_ >= var_164_1 + var_164_2 and arg_161_1.time_ < var_164_1 + var_164_2 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.characterEffect1019ui_story then
				local var_164_5 = 0.5

				arg_161_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_161_1.var_.characterEffect1019ui_story.fillRatio = var_164_5
			end

			local var_164_6 = 0
			local var_164_7 = 0.525

			if var_164_6 < arg_161_1.time_ and arg_161_1.time_ <= var_164_6 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_8 = arg_161_1:FormatText(StoryNameCfg[7].name)

				arg_161_1.leftNameTxt_.text = var_164_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, true)
				arg_161_1.iconController_:SetSelectedState("hero")

				arg_161_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_161_1.callingController_:SetSelectedState("normal")

				arg_161_1.keyicon_.color = Color.New(1, 1, 1)
				arg_161_1.icon_.color = Color.New(1, 1, 1)

				local var_164_9 = arg_161_1:GetWordFromCfg(111011038)
				local var_164_10 = arg_161_1:FormatText(var_164_9.content)

				arg_161_1.text_.text = var_164_10

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_11 = 21
				local var_164_12 = utf8.len(var_164_10)
				local var_164_13 = var_164_11 <= 0 and var_164_7 or var_164_7 * (var_164_12 / var_164_11)

				if var_164_13 > 0 and var_164_7 < var_164_13 then
					arg_161_1.talkMaxDuration = var_164_13

					if var_164_13 + var_164_6 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_13 + var_164_6
					end
				end

				arg_161_1.text_.text = var_164_10
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_14 = math.max(var_164_7, arg_161_1.talkMaxDuration)

			if var_164_6 <= arg_161_1.time_ and arg_161_1.time_ < var_164_6 + var_164_14 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_6) / var_164_14

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_6 + var_164_14 and arg_161_1.time_ < var_164_6 + var_164_14 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play111011039 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 111011039
		arg_165_1.duration_ = 13.07

		local var_165_0 = {
			ja = 12.6,
			ko = 11.9,
			zh = 12.033,
			en = 13.066
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
				arg_165_0:Play111011040(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0

			if var_168_0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_0 + arg_168_0 then
				arg_165_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_168_1 = arg_165_1.actors_["1019ui_story"]
			local var_168_2 = 0

			if var_168_2 < arg_165_1.time_ and arg_165_1.time_ <= var_168_2 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect1019ui_story == nil then
				arg_165_1.var_.characterEffect1019ui_story = var_168_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_3 = 0.2

			if var_168_2 <= arg_165_1.time_ and arg_165_1.time_ < var_168_2 + var_168_3 and not isNil(var_168_1) then
				local var_168_4 = (arg_165_1.time_ - var_168_2) / var_168_3

				if arg_165_1.var_.characterEffect1019ui_story and not isNil(var_168_1) then
					arg_165_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= var_168_2 + var_168_3 and arg_165_1.time_ < var_168_2 + var_168_3 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect1019ui_story then
				arg_165_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_168_5 = 0
			local var_168_6 = 1.15

			if var_168_5 < arg_165_1.time_ and arg_165_1.time_ <= var_168_5 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_7 = arg_165_1:FormatText(StoryNameCfg[13].name)

				arg_165_1.leftNameTxt_.text = var_168_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_8 = arg_165_1:GetWordFromCfg(111011039)
				local var_168_9 = arg_165_1:FormatText(var_168_8.content)

				arg_165_1.text_.text = var_168_9

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_10 = 46
				local var_168_11 = utf8.len(var_168_9)
				local var_168_12 = var_168_10 <= 0 and var_168_6 or var_168_6 * (var_168_11 / var_168_10)

				if var_168_12 > 0 and var_168_6 < var_168_12 then
					arg_165_1.talkMaxDuration = var_168_12

					if var_168_12 + var_168_5 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_12 + var_168_5
					end
				end

				arg_165_1.text_.text = var_168_9
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111011", "111011039", "story_v_out_111011.awb") ~= 0 then
					local var_168_13 = manager.audio:GetVoiceLength("story_v_out_111011", "111011039", "story_v_out_111011.awb") / 1000

					if var_168_13 + var_168_5 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_13 + var_168_5
					end

					if var_168_8.prefab_name ~= "" and arg_165_1.actors_[var_168_8.prefab_name] ~= nil then
						local var_168_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_8.prefab_name].transform, "story_v_out_111011", "111011039", "story_v_out_111011.awb")

						arg_165_1:RecordAudio("111011039", var_168_14)
						arg_165_1:RecordAudio("111011039", var_168_14)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_111011", "111011039", "story_v_out_111011.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_111011", "111011039", "story_v_out_111011.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_15 = math.max(var_168_6, arg_165_1.talkMaxDuration)

			if var_168_5 <= arg_165_1.time_ and arg_165_1.time_ < var_168_5 + var_168_15 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_5) / var_168_15

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_5 + var_168_15 and arg_165_1.time_ < var_168_5 + var_168_15 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play111011040 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 111011040
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play111011041(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.actors_["1019ui_story"]
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.characterEffect1019ui_story == nil then
				arg_169_1.var_.characterEffect1019ui_story = var_172_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_2 = 0.2

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_2 and not isNil(var_172_0) then
				local var_172_3 = (arg_169_1.time_ - var_172_1) / var_172_2

				if arg_169_1.var_.characterEffect1019ui_story and not isNil(var_172_0) then
					local var_172_4 = Mathf.Lerp(0, 0.5, var_172_3)

					arg_169_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_169_1.var_.characterEffect1019ui_story.fillRatio = var_172_4
				end
			end

			if arg_169_1.time_ >= var_172_1 + var_172_2 and arg_169_1.time_ < var_172_1 + var_172_2 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.characterEffect1019ui_story then
				local var_172_5 = 0.5

				arg_169_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_169_1.var_.characterEffect1019ui_story.fillRatio = var_172_5
			end

			local var_172_6 = 0
			local var_172_7 = 0.45

			if var_172_6 < arg_169_1.time_ and arg_169_1.time_ <= var_172_6 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_8 = arg_169_1:FormatText(StoryNameCfg[7].name)

				arg_169_1.leftNameTxt_.text = var_172_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, true)
				arg_169_1.iconController_:SetSelectedState("hero")

				arg_169_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_169_1.callingController_:SetSelectedState("normal")

				arg_169_1.keyicon_.color = Color.New(1, 1, 1)
				arg_169_1.icon_.color = Color.New(1, 1, 1)

				local var_172_9 = arg_169_1:GetWordFromCfg(111011040)
				local var_172_10 = arg_169_1:FormatText(var_172_9.content)

				arg_169_1.text_.text = var_172_10

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_11 = 18
				local var_172_12 = utf8.len(var_172_10)
				local var_172_13 = var_172_11 <= 0 and var_172_7 or var_172_7 * (var_172_12 / var_172_11)

				if var_172_13 > 0 and var_172_7 < var_172_13 then
					arg_169_1.talkMaxDuration = var_172_13

					if var_172_13 + var_172_6 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_13 + var_172_6
					end
				end

				arg_169_1.text_.text = var_172_10
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
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
	Play111011041 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 111011041
		arg_173_1.duration_ = 6.7

		local var_173_0 = {
			ja = 6.7,
			ko = 5.366,
			zh = 5.033,
			en = 6.366
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
				arg_173_0:Play111011042(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0

			if var_176_0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_0 + arg_176_0 then
				arg_173_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action4_2")
			end

			local var_176_1 = arg_173_1.actors_["1066ui_story"]
			local var_176_2 = 0

			if var_176_2 < arg_173_1.time_ and arg_173_1.time_ <= var_176_2 + arg_176_0 and not isNil(var_176_1) and arg_173_1.var_.characterEffect1066ui_story == nil then
				arg_173_1.var_.characterEffect1066ui_story = var_176_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_3 = 0.2

			if var_176_2 <= arg_173_1.time_ and arg_173_1.time_ < var_176_2 + var_176_3 and not isNil(var_176_1) then
				local var_176_4 = (arg_173_1.time_ - var_176_2) / var_176_3

				if arg_173_1.var_.characterEffect1066ui_story and not isNil(var_176_1) then
					arg_173_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= var_176_2 + var_176_3 and arg_173_1.time_ < var_176_2 + var_176_3 + arg_176_0 and not isNil(var_176_1) and arg_173_1.var_.characterEffect1066ui_story then
				arg_173_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_176_5 = arg_173_1.actors_["1019ui_story"]
			local var_176_6 = 0

			if var_176_6 < arg_173_1.time_ and arg_173_1.time_ <= var_176_6 + arg_176_0 and not isNil(var_176_5) and arg_173_1.var_.characterEffect1019ui_story == nil then
				arg_173_1.var_.characterEffect1019ui_story = var_176_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_7 = 0.2

			if var_176_6 <= arg_173_1.time_ and arg_173_1.time_ < var_176_6 + var_176_7 and not isNil(var_176_5) then
				local var_176_8 = (arg_173_1.time_ - var_176_6) / var_176_7

				if arg_173_1.var_.characterEffect1019ui_story and not isNil(var_176_5) then
					local var_176_9 = Mathf.Lerp(0, 0.5, var_176_8)

					arg_173_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_173_1.var_.characterEffect1019ui_story.fillRatio = var_176_9
				end
			end

			if arg_173_1.time_ >= var_176_6 + var_176_7 and arg_173_1.time_ < var_176_6 + var_176_7 + arg_176_0 and not isNil(var_176_5) and arg_173_1.var_.characterEffect1019ui_story then
				local var_176_10 = 0.5

				arg_173_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_173_1.var_.characterEffect1019ui_story.fillRatio = var_176_10
			end

			local var_176_11 = 0

			if var_176_11 < arg_173_1.time_ and arg_173_1.time_ <= var_176_11 + arg_176_0 then
				arg_173_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_176_12 = 0
			local var_176_13 = 0.625

			if var_176_12 < arg_173_1.time_ and arg_173_1.time_ <= var_176_12 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_14 = arg_173_1:FormatText(StoryNameCfg[32].name)

				arg_173_1.leftNameTxt_.text = var_176_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_15 = arg_173_1:GetWordFromCfg(111011041)
				local var_176_16 = arg_173_1:FormatText(var_176_15.content)

				arg_173_1.text_.text = var_176_16

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_17 = 25
				local var_176_18 = utf8.len(var_176_16)
				local var_176_19 = var_176_17 <= 0 and var_176_13 or var_176_13 * (var_176_18 / var_176_17)

				if var_176_19 > 0 and var_176_13 < var_176_19 then
					arg_173_1.talkMaxDuration = var_176_19

					if var_176_19 + var_176_12 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_19 + var_176_12
					end
				end

				arg_173_1.text_.text = var_176_16
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111011", "111011041", "story_v_out_111011.awb") ~= 0 then
					local var_176_20 = manager.audio:GetVoiceLength("story_v_out_111011", "111011041", "story_v_out_111011.awb") / 1000

					if var_176_20 + var_176_12 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_20 + var_176_12
					end

					if var_176_15.prefab_name ~= "" and arg_173_1.actors_[var_176_15.prefab_name] ~= nil then
						local var_176_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_15.prefab_name].transform, "story_v_out_111011", "111011041", "story_v_out_111011.awb")

						arg_173_1:RecordAudio("111011041", var_176_21)
						arg_173_1:RecordAudio("111011041", var_176_21)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_111011", "111011041", "story_v_out_111011.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_111011", "111011041", "story_v_out_111011.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_22 = math.max(var_176_13, arg_173_1.talkMaxDuration)

			if var_176_12 <= arg_173_1.time_ and arg_173_1.time_ < var_176_12 + var_176_22 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_12) / var_176_22

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_12 + var_176_22 and arg_173_1.time_ < var_176_12 + var_176_22 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play111011042 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 111011042
		arg_177_1.duration_ = 11.3

		local var_177_0 = {
			ja = 9.9,
			ko = 11.266,
			zh = 10.133,
			en = 11.3
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
				arg_177_0:Play111011043(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0

			if var_180_0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_0 + arg_180_0 then
				arg_177_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action425")
			end

			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 then
				arg_177_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_180_2 = arg_177_1.actors_["1019ui_story"]
			local var_180_3 = 0

			if var_180_3 < arg_177_1.time_ and arg_177_1.time_ <= var_180_3 + arg_180_0 and not isNil(var_180_2) and arg_177_1.var_.characterEffect1019ui_story == nil then
				arg_177_1.var_.characterEffect1019ui_story = var_180_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_4 = 0.2

			if var_180_3 <= arg_177_1.time_ and arg_177_1.time_ < var_180_3 + var_180_4 and not isNil(var_180_2) then
				local var_180_5 = (arg_177_1.time_ - var_180_3) / var_180_4

				if arg_177_1.var_.characterEffect1019ui_story and not isNil(var_180_2) then
					arg_177_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= var_180_3 + var_180_4 and arg_177_1.time_ < var_180_3 + var_180_4 + arg_180_0 and not isNil(var_180_2) and arg_177_1.var_.characterEffect1019ui_story then
				arg_177_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_180_6 = arg_177_1.actors_["1066ui_story"]
			local var_180_7 = 0

			if var_180_7 < arg_177_1.time_ and arg_177_1.time_ <= var_180_7 + arg_180_0 and not isNil(var_180_6) and arg_177_1.var_.characterEffect1066ui_story == nil then
				arg_177_1.var_.characterEffect1066ui_story = var_180_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_8 = 0.2

			if var_180_7 <= arg_177_1.time_ and arg_177_1.time_ < var_180_7 + var_180_8 and not isNil(var_180_6) then
				local var_180_9 = (arg_177_1.time_ - var_180_7) / var_180_8

				if arg_177_1.var_.characterEffect1066ui_story and not isNil(var_180_6) then
					local var_180_10 = Mathf.Lerp(0, 0.5, var_180_9)

					arg_177_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_177_1.var_.characterEffect1066ui_story.fillRatio = var_180_10
				end
			end

			if arg_177_1.time_ >= var_180_7 + var_180_8 and arg_177_1.time_ < var_180_7 + var_180_8 + arg_180_0 and not isNil(var_180_6) and arg_177_1.var_.characterEffect1066ui_story then
				local var_180_11 = 0.5

				arg_177_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_177_1.var_.characterEffect1066ui_story.fillRatio = var_180_11
			end

			local var_180_12 = 0
			local var_180_13 = 1.4

			if var_180_12 < arg_177_1.time_ and arg_177_1.time_ <= var_180_12 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_14 = arg_177_1:FormatText(StoryNameCfg[13].name)

				arg_177_1.leftNameTxt_.text = var_180_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_15 = arg_177_1:GetWordFromCfg(111011042)
				local var_180_16 = arg_177_1:FormatText(var_180_15.content)

				arg_177_1.text_.text = var_180_16

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_17 = 56
				local var_180_18 = utf8.len(var_180_16)
				local var_180_19 = var_180_17 <= 0 and var_180_13 or var_180_13 * (var_180_18 / var_180_17)

				if var_180_19 > 0 and var_180_13 < var_180_19 then
					arg_177_1.talkMaxDuration = var_180_19

					if var_180_19 + var_180_12 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_19 + var_180_12
					end
				end

				arg_177_1.text_.text = var_180_16
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111011", "111011042", "story_v_out_111011.awb") ~= 0 then
					local var_180_20 = manager.audio:GetVoiceLength("story_v_out_111011", "111011042", "story_v_out_111011.awb") / 1000

					if var_180_20 + var_180_12 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_20 + var_180_12
					end

					if var_180_15.prefab_name ~= "" and arg_177_1.actors_[var_180_15.prefab_name] ~= nil then
						local var_180_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_15.prefab_name].transform, "story_v_out_111011", "111011042", "story_v_out_111011.awb")

						arg_177_1:RecordAudio("111011042", var_180_21)
						arg_177_1:RecordAudio("111011042", var_180_21)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_111011", "111011042", "story_v_out_111011.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_111011", "111011042", "story_v_out_111011.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_22 = math.max(var_180_13, arg_177_1.talkMaxDuration)

			if var_180_12 <= arg_177_1.time_ and arg_177_1.time_ < var_180_12 + var_180_22 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_12) / var_180_22

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_12 + var_180_22 and arg_177_1.time_ < var_180_12 + var_180_22 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play111011043 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 111011043
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play111011044(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["1019ui_story"]
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.characterEffect1019ui_story == nil then
				arg_181_1.var_.characterEffect1019ui_story = var_184_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_2 = 0.2

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_2 and not isNil(var_184_0) then
				local var_184_3 = (arg_181_1.time_ - var_184_1) / var_184_2

				if arg_181_1.var_.characterEffect1019ui_story and not isNil(var_184_0) then
					local var_184_4 = Mathf.Lerp(0, 0.5, var_184_3)

					arg_181_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1019ui_story.fillRatio = var_184_4
				end
			end

			if arg_181_1.time_ >= var_184_1 + var_184_2 and arg_181_1.time_ < var_184_1 + var_184_2 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.characterEffect1019ui_story then
				local var_184_5 = 0.5

				arg_181_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1019ui_story.fillRatio = var_184_5
			end

			local var_184_6 = 0
			local var_184_7 = 0.45

			if var_184_6 < arg_181_1.time_ and arg_181_1.time_ <= var_184_6 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_8 = arg_181_1:FormatText(StoryNameCfg[7].name)

				arg_181_1.leftNameTxt_.text = var_184_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, true)
				arg_181_1.iconController_:SetSelectedState("hero")

				arg_181_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_181_1.callingController_:SetSelectedState("normal")

				arg_181_1.keyicon_.color = Color.New(1, 1, 1)
				arg_181_1.icon_.color = Color.New(1, 1, 1)

				local var_184_9 = arg_181_1:GetWordFromCfg(111011043)
				local var_184_10 = arg_181_1:FormatText(var_184_9.content)

				arg_181_1.text_.text = var_184_10

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_11 = 18
				local var_184_12 = utf8.len(var_184_10)
				local var_184_13 = var_184_11 <= 0 and var_184_7 or var_184_7 * (var_184_12 / var_184_11)

				if var_184_13 > 0 and var_184_7 < var_184_13 then
					arg_181_1.talkMaxDuration = var_184_13

					if var_184_13 + var_184_6 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_13 + var_184_6
					end
				end

				arg_181_1.text_.text = var_184_10
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_14 = math.max(var_184_7, arg_181_1.talkMaxDuration)

			if var_184_6 <= arg_181_1.time_ and arg_181_1.time_ < var_184_6 + var_184_14 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_6) / var_184_14

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_6 + var_184_14 and arg_181_1.time_ < var_184_6 + var_184_14 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play111011044 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 111011044
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play111011045(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0
			local var_188_1 = 0.85

			if var_188_0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, false)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_2 = arg_185_1:GetWordFromCfg(111011044)
				local var_188_3 = arg_185_1:FormatText(var_188_2.content)

				arg_185_1.text_.text = var_188_3

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_4 = 34
				local var_188_5 = utf8.len(var_188_3)
				local var_188_6 = var_188_4 <= 0 and var_188_1 or var_188_1 * (var_188_5 / var_188_4)

				if var_188_6 > 0 and var_188_1 < var_188_6 then
					arg_185_1.talkMaxDuration = var_188_6

					if var_188_6 + var_188_0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_6 + var_188_0
					end
				end

				arg_185_1.text_.text = var_188_3
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_7 = math.max(var_188_1, arg_185_1.talkMaxDuration)

			if var_188_0 <= arg_185_1.time_ and arg_185_1.time_ < var_188_0 + var_188_7 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_0) / var_188_7

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_0 + var_188_7 and arg_185_1.time_ < var_188_0 + var_188_7 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play111011045 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 111011045
		arg_189_1.duration_ = 3.43

		local var_189_0 = {
			ja = 3.433,
			ko = 2.6,
			zh = 2.166,
			en = 2.5
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
				arg_189_0:Play111011046(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0

			if var_192_0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_0 + arg_192_0 then
				arg_189_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_192_1 = arg_189_1.actors_["1019ui_story"]
			local var_192_2 = 0

			if var_192_2 < arg_189_1.time_ and arg_189_1.time_ <= var_192_2 + arg_192_0 and not isNil(var_192_1) and arg_189_1.var_.characterEffect1019ui_story == nil then
				arg_189_1.var_.characterEffect1019ui_story = var_192_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_3 = 0.2

			if var_192_2 <= arg_189_1.time_ and arg_189_1.time_ < var_192_2 + var_192_3 and not isNil(var_192_1) then
				local var_192_4 = (arg_189_1.time_ - var_192_2) / var_192_3

				if arg_189_1.var_.characterEffect1019ui_story and not isNil(var_192_1) then
					arg_189_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_189_1.time_ >= var_192_2 + var_192_3 and arg_189_1.time_ < var_192_2 + var_192_3 + arg_192_0 and not isNil(var_192_1) and arg_189_1.var_.characterEffect1019ui_story then
				arg_189_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_192_5 = 0
			local var_192_6 = 0.275

			if var_192_5 < arg_189_1.time_ and arg_189_1.time_ <= var_192_5 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_7 = arg_189_1:FormatText(StoryNameCfg[13].name)

				arg_189_1.leftNameTxt_.text = var_192_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_8 = arg_189_1:GetWordFromCfg(111011045)
				local var_192_9 = arg_189_1:FormatText(var_192_8.content)

				arg_189_1.text_.text = var_192_9

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_10 = 11
				local var_192_11 = utf8.len(var_192_9)
				local var_192_12 = var_192_10 <= 0 and var_192_6 or var_192_6 * (var_192_11 / var_192_10)

				if var_192_12 > 0 and var_192_6 < var_192_12 then
					arg_189_1.talkMaxDuration = var_192_12

					if var_192_12 + var_192_5 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_12 + var_192_5
					end
				end

				arg_189_1.text_.text = var_192_9
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111011", "111011045", "story_v_out_111011.awb") ~= 0 then
					local var_192_13 = manager.audio:GetVoiceLength("story_v_out_111011", "111011045", "story_v_out_111011.awb") / 1000

					if var_192_13 + var_192_5 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_13 + var_192_5
					end

					if var_192_8.prefab_name ~= "" and arg_189_1.actors_[var_192_8.prefab_name] ~= nil then
						local var_192_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_8.prefab_name].transform, "story_v_out_111011", "111011045", "story_v_out_111011.awb")

						arg_189_1:RecordAudio("111011045", var_192_14)
						arg_189_1:RecordAudio("111011045", var_192_14)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_111011", "111011045", "story_v_out_111011.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_111011", "111011045", "story_v_out_111011.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_15 = math.max(var_192_6, arg_189_1.talkMaxDuration)

			if var_192_5 <= arg_189_1.time_ and arg_189_1.time_ < var_192_5 + var_192_15 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_5) / var_192_15

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_5 + var_192_15 and arg_189_1.time_ < var_192_5 + var_192_15 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play111011046 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 111011046
		arg_193_1.duration_ = 6.9

		local var_193_0 = {
			ja = 3.1,
			ko = 6.9,
			zh = 4.266,
			en = 6.333
		}
		local var_193_1 = manager.audio:GetLocalizationFlag()

		if var_193_0[var_193_1] ~= nil then
			arg_193_1.duration_ = var_193_0[var_193_1]
		end

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play111011047(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["1066ui_story"]
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.characterEffect1066ui_story == nil then
				arg_193_1.var_.characterEffect1066ui_story = var_196_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_2 = 0.2

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_2 and not isNil(var_196_0) then
				local var_196_3 = (arg_193_1.time_ - var_196_1) / var_196_2

				if arg_193_1.var_.characterEffect1066ui_story and not isNil(var_196_0) then
					arg_193_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= var_196_1 + var_196_2 and arg_193_1.time_ < var_196_1 + var_196_2 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.characterEffect1066ui_story then
				arg_193_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_196_4 = arg_193_1.actors_["1019ui_story"]
			local var_196_5 = 0

			if var_196_5 < arg_193_1.time_ and arg_193_1.time_ <= var_196_5 + arg_196_0 and not isNil(var_196_4) and arg_193_1.var_.characterEffect1019ui_story == nil then
				arg_193_1.var_.characterEffect1019ui_story = var_196_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_6 = 0.2

			if var_196_5 <= arg_193_1.time_ and arg_193_1.time_ < var_196_5 + var_196_6 and not isNil(var_196_4) then
				local var_196_7 = (arg_193_1.time_ - var_196_5) / var_196_6

				if arg_193_1.var_.characterEffect1019ui_story and not isNil(var_196_4) then
					local var_196_8 = Mathf.Lerp(0, 0.5, var_196_7)

					arg_193_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_193_1.var_.characterEffect1019ui_story.fillRatio = var_196_8
				end
			end

			if arg_193_1.time_ >= var_196_5 + var_196_6 and arg_193_1.time_ < var_196_5 + var_196_6 + arg_196_0 and not isNil(var_196_4) and arg_193_1.var_.characterEffect1019ui_story then
				local var_196_9 = 0.5

				arg_193_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_193_1.var_.characterEffect1019ui_story.fillRatio = var_196_9
			end

			local var_196_10 = 0

			if var_196_10 < arg_193_1.time_ and arg_193_1.time_ <= var_196_10 + arg_196_0 then
				arg_193_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action1_1")
			end

			local var_196_11 = 0

			if var_196_11 < arg_193_1.time_ and arg_193_1.time_ <= var_196_11 + arg_196_0 then
				arg_193_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_196_12 = 0
			local var_196_13 = 0.55

			if var_196_12 < arg_193_1.time_ and arg_193_1.time_ <= var_196_12 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_14 = arg_193_1:FormatText(StoryNameCfg[32].name)

				arg_193_1.leftNameTxt_.text = var_196_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_15 = arg_193_1:GetWordFromCfg(111011046)
				local var_196_16 = arg_193_1:FormatText(var_196_15.content)

				arg_193_1.text_.text = var_196_16

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_17 = 22
				local var_196_18 = utf8.len(var_196_16)
				local var_196_19 = var_196_17 <= 0 and var_196_13 or var_196_13 * (var_196_18 / var_196_17)

				if var_196_19 > 0 and var_196_13 < var_196_19 then
					arg_193_1.talkMaxDuration = var_196_19

					if var_196_19 + var_196_12 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_19 + var_196_12
					end
				end

				arg_193_1.text_.text = var_196_16
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111011", "111011046", "story_v_out_111011.awb") ~= 0 then
					local var_196_20 = manager.audio:GetVoiceLength("story_v_out_111011", "111011046", "story_v_out_111011.awb") / 1000

					if var_196_20 + var_196_12 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_20 + var_196_12
					end

					if var_196_15.prefab_name ~= "" and arg_193_1.actors_[var_196_15.prefab_name] ~= nil then
						local var_196_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_15.prefab_name].transform, "story_v_out_111011", "111011046", "story_v_out_111011.awb")

						arg_193_1:RecordAudio("111011046", var_196_21)
						arg_193_1:RecordAudio("111011046", var_196_21)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_111011", "111011046", "story_v_out_111011.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_111011", "111011046", "story_v_out_111011.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_22 = math.max(var_196_13, arg_193_1.talkMaxDuration)

			if var_196_12 <= arg_193_1.time_ and arg_193_1.time_ < var_196_12 + var_196_22 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_12) / var_196_22

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_12 + var_196_22 and arg_193_1.time_ < var_196_12 + var_196_22 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play111011047 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 111011047
		arg_197_1.duration_ = 5.97

		local var_197_0 = {
			ja = 5.966,
			ko = 2.9,
			zh = 3.4,
			en = 3.666
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
				arg_197_0:Play111011048(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0

			if var_200_0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_0 + arg_200_0 then
				arg_197_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action1_1")
			end

			local var_200_1 = arg_197_1.actors_["1066ui_story"]
			local var_200_2 = 0

			if var_200_2 < arg_197_1.time_ and arg_197_1.time_ <= var_200_2 + arg_200_0 and not isNil(var_200_1) and arg_197_1.var_.characterEffect1066ui_story == nil then
				arg_197_1.var_.characterEffect1066ui_story = var_200_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_3 = 0.2

			if var_200_2 <= arg_197_1.time_ and arg_197_1.time_ < var_200_2 + var_200_3 and not isNil(var_200_1) then
				local var_200_4 = (arg_197_1.time_ - var_200_2) / var_200_3

				if arg_197_1.var_.characterEffect1066ui_story and not isNil(var_200_1) then
					arg_197_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= var_200_2 + var_200_3 and arg_197_1.time_ < var_200_2 + var_200_3 + arg_200_0 and not isNil(var_200_1) and arg_197_1.var_.characterEffect1066ui_story then
				arg_197_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_200_5 = arg_197_1.actors_["1019ui_story"]
			local var_200_6 = 0

			if var_200_6 < arg_197_1.time_ and arg_197_1.time_ <= var_200_6 + arg_200_0 and not isNil(var_200_5) and arg_197_1.var_.characterEffect1019ui_story == nil then
				arg_197_1.var_.characterEffect1019ui_story = var_200_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_7 = 0.2

			if var_200_6 <= arg_197_1.time_ and arg_197_1.time_ < var_200_6 + var_200_7 and not isNil(var_200_5) then
				local var_200_8 = (arg_197_1.time_ - var_200_6) / var_200_7

				if arg_197_1.var_.characterEffect1019ui_story and not isNil(var_200_5) then
					local var_200_9 = Mathf.Lerp(0, 0.5, var_200_8)

					arg_197_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_197_1.var_.characterEffect1019ui_story.fillRatio = var_200_9
				end
			end

			if arg_197_1.time_ >= var_200_6 + var_200_7 and arg_197_1.time_ < var_200_6 + var_200_7 + arg_200_0 and not isNil(var_200_5) and arg_197_1.var_.characterEffect1019ui_story then
				local var_200_10 = 0.5

				arg_197_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_197_1.var_.characterEffect1019ui_story.fillRatio = var_200_10
			end

			local var_200_11 = 0

			if var_200_11 < arg_197_1.time_ and arg_197_1.time_ <= var_200_11 + arg_200_0 then
				arg_197_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_200_12 = 0
			local var_200_13 = 0.375

			if var_200_12 < arg_197_1.time_ and arg_197_1.time_ <= var_200_12 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_14 = arg_197_1:FormatText(StoryNameCfg[32].name)

				arg_197_1.leftNameTxt_.text = var_200_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_15 = arg_197_1:GetWordFromCfg(111011047)
				local var_200_16 = arg_197_1:FormatText(var_200_15.content)

				arg_197_1.text_.text = var_200_16

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_17 = 15
				local var_200_18 = utf8.len(var_200_16)
				local var_200_19 = var_200_17 <= 0 and var_200_13 or var_200_13 * (var_200_18 / var_200_17)

				if var_200_19 > 0 and var_200_13 < var_200_19 then
					arg_197_1.talkMaxDuration = var_200_19

					if var_200_19 + var_200_12 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_19 + var_200_12
					end
				end

				arg_197_1.text_.text = var_200_16
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111011", "111011047", "story_v_out_111011.awb") ~= 0 then
					local var_200_20 = manager.audio:GetVoiceLength("story_v_out_111011", "111011047", "story_v_out_111011.awb") / 1000

					if var_200_20 + var_200_12 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_20 + var_200_12
					end

					if var_200_15.prefab_name ~= "" and arg_197_1.actors_[var_200_15.prefab_name] ~= nil then
						local var_200_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_15.prefab_name].transform, "story_v_out_111011", "111011047", "story_v_out_111011.awb")

						arg_197_1:RecordAudio("111011047", var_200_21)
						arg_197_1:RecordAudio("111011047", var_200_21)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_111011", "111011047", "story_v_out_111011.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_111011", "111011047", "story_v_out_111011.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_22 = math.max(var_200_13, arg_197_1.talkMaxDuration)

			if var_200_12 <= arg_197_1.time_ and arg_197_1.time_ < var_200_12 + var_200_22 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_12) / var_200_22

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_12 + var_200_22 and arg_197_1.time_ < var_200_12 + var_200_22 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play111011048 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 111011048
		arg_201_1.duration_ = 7.33

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play111011049(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = "B13a"

			if arg_201_1.bgs_[var_204_0] == nil then
				local var_204_1 = Object.Instantiate(arg_201_1.paintGo_)

				var_204_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_204_0)
				var_204_1.name = var_204_0
				var_204_1.transform.parent = arg_201_1.stage_.transform
				var_204_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_201_1.bgs_[var_204_0] = var_204_1
			end

			local var_204_2 = 1.5

			if var_204_2 < arg_201_1.time_ and arg_201_1.time_ <= var_204_2 + arg_204_0 then
				local var_204_3 = manager.ui.mainCamera.transform.localPosition
				local var_204_4 = Vector3.New(0, 0, 10) + Vector3.New(var_204_3.x, var_204_3.y, 0)
				local var_204_5 = arg_201_1.bgs_.B13a

				var_204_5.transform.localPosition = var_204_4
				var_204_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_204_6 = var_204_5:GetComponent("SpriteRenderer")

				if var_204_6 and var_204_6.sprite then
					local var_204_7 = (var_204_5.transform.localPosition - var_204_3).z
					local var_204_8 = manager.ui.mainCameraCom_
					local var_204_9 = 2 * var_204_7 * Mathf.Tan(var_204_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_204_10 = var_204_9 * var_204_8.aspect
					local var_204_11 = var_204_6.sprite.bounds.size.x
					local var_204_12 = var_204_6.sprite.bounds.size.y
					local var_204_13 = var_204_10 / var_204_11
					local var_204_14 = var_204_9 / var_204_12
					local var_204_15 = var_204_14 < var_204_13 and var_204_13 or var_204_14

					var_204_5.transform.localScale = Vector3.New(var_204_15, var_204_15, 0)
				end

				for iter_204_0, iter_204_1 in pairs(arg_201_1.bgs_) do
					if iter_204_0 ~= "B13a" then
						iter_204_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_204_16 = arg_201_1.bgs_.ST07a
			local var_204_17 = 0

			if var_204_17 < arg_201_1.time_ and arg_201_1.time_ <= var_204_17 + arg_204_0 then
				local var_204_18 = var_204_16:GetComponent("SpriteRenderer")

				if var_204_18 then
					arg_201_1.var_.alphaOldValueST07a = var_204_18.color.a
					arg_201_1.var_.alphaMatValueST07a = var_204_18
				end

				arg_201_1.var_.alphaOldValueST07a = 1
			end

			local var_204_19 = 1.5

			if var_204_17 <= arg_201_1.time_ and arg_201_1.time_ < var_204_17 + var_204_19 then
				local var_204_20 = (arg_201_1.time_ - var_204_17) / var_204_19
				local var_204_21 = Mathf.Lerp(arg_201_1.var_.alphaOldValueST07a, 0, var_204_20)

				if arg_201_1.var_.alphaMatValueST07a then
					local var_204_22 = arg_201_1.var_.alphaMatValueST07a.color

					var_204_22.a = var_204_21
					arg_201_1.var_.alphaMatValueST07a.color = var_204_22
				end
			end

			if arg_201_1.time_ >= var_204_17 + var_204_19 and arg_201_1.time_ < var_204_17 + var_204_19 + arg_204_0 and arg_201_1.var_.alphaMatValueST07a then
				local var_204_23 = arg_201_1.var_.alphaMatValueST07a
				local var_204_24 = var_204_23.color

				var_204_24.a = 0
				var_204_23.color = var_204_24
			end

			local var_204_25 = arg_201_1.bgs_.B13a
			local var_204_26 = 1.5

			if var_204_26 < arg_201_1.time_ and arg_201_1.time_ <= var_204_26 + arg_204_0 then
				local var_204_27 = var_204_25:GetComponent("SpriteRenderer")

				if var_204_27 then
					arg_201_1.var_.alphaOldValueB13a = var_204_27.color.a
					arg_201_1.var_.alphaMatValueB13a = var_204_27
				end

				arg_201_1.var_.alphaOldValueB13a = 0
			end

			local var_204_28 = 1.5

			if var_204_26 <= arg_201_1.time_ and arg_201_1.time_ < var_204_26 + var_204_28 then
				local var_204_29 = (arg_201_1.time_ - var_204_26) / var_204_28
				local var_204_30 = Mathf.Lerp(arg_201_1.var_.alphaOldValueB13a, 1, var_204_29)

				if arg_201_1.var_.alphaMatValueB13a then
					local var_204_31 = arg_201_1.var_.alphaMatValueB13a.color

					var_204_31.a = var_204_30
					arg_201_1.var_.alphaMatValueB13a.color = var_204_31
				end
			end

			if arg_201_1.time_ >= var_204_26 + var_204_28 and arg_201_1.time_ < var_204_26 + var_204_28 + arg_204_0 and arg_201_1.var_.alphaMatValueB13a then
				local var_204_32 = arg_201_1.var_.alphaMatValueB13a
				local var_204_33 = var_204_32.color

				var_204_33.a = 1
				var_204_32.color = var_204_33
			end

			local var_204_34 = arg_201_1.actors_["1066ui_story"].transform
			local var_204_35 = 0

			if var_204_35 < arg_201_1.time_ and arg_201_1.time_ <= var_204_35 + arg_204_0 then
				arg_201_1.var_.moveOldPos1066ui_story = var_204_34.localPosition
			end

			local var_204_36 = 0.001

			if var_204_35 <= arg_201_1.time_ and arg_201_1.time_ < var_204_35 + var_204_36 then
				local var_204_37 = (arg_201_1.time_ - var_204_35) / var_204_36
				local var_204_38 = Vector3.New(0, 100, 0)

				var_204_34.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos1066ui_story, var_204_38, var_204_37)

				local var_204_39 = manager.ui.mainCamera.transform.position - var_204_34.position

				var_204_34.forward = Vector3.New(var_204_39.x, var_204_39.y, var_204_39.z)

				local var_204_40 = var_204_34.localEulerAngles

				var_204_40.z = 0
				var_204_40.x = 0
				var_204_34.localEulerAngles = var_204_40
			end

			if arg_201_1.time_ >= var_204_35 + var_204_36 and arg_201_1.time_ < var_204_35 + var_204_36 + arg_204_0 then
				var_204_34.localPosition = Vector3.New(0, 100, 0)

				local var_204_41 = manager.ui.mainCamera.transform.position - var_204_34.position

				var_204_34.forward = Vector3.New(var_204_41.x, var_204_41.y, var_204_41.z)

				local var_204_42 = var_204_34.localEulerAngles

				var_204_42.z = 0
				var_204_42.x = 0
				var_204_34.localEulerAngles = var_204_42
			end

			local var_204_43 = arg_201_1.actors_["1019ui_story"].transform
			local var_204_44 = 0

			if var_204_44 < arg_201_1.time_ and arg_201_1.time_ <= var_204_44 + arg_204_0 then
				arg_201_1.var_.moveOldPos1019ui_story = var_204_43.localPosition
			end

			local var_204_45 = 0.001

			if var_204_44 <= arg_201_1.time_ and arg_201_1.time_ < var_204_44 + var_204_45 then
				local var_204_46 = (arg_201_1.time_ - var_204_44) / var_204_45
				local var_204_47 = Vector3.New(0, 100, 0)

				var_204_43.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos1019ui_story, var_204_47, var_204_46)

				local var_204_48 = manager.ui.mainCamera.transform.position - var_204_43.position

				var_204_43.forward = Vector3.New(var_204_48.x, var_204_48.y, var_204_48.z)

				local var_204_49 = var_204_43.localEulerAngles

				var_204_49.z = 0
				var_204_49.x = 0
				var_204_43.localEulerAngles = var_204_49
			end

			if arg_201_1.time_ >= var_204_44 + var_204_45 and arg_201_1.time_ < var_204_44 + var_204_45 + arg_204_0 then
				var_204_43.localPosition = Vector3.New(0, 100, 0)

				local var_204_50 = manager.ui.mainCamera.transform.position - var_204_43.position

				var_204_43.forward = Vector3.New(var_204_50.x, var_204_50.y, var_204_50.z)

				local var_204_51 = var_204_43.localEulerAngles

				var_204_51.z = 0
				var_204_51.x = 0
				var_204_43.localEulerAngles = var_204_51
			end

			local var_204_52 = 0

			if var_204_52 < arg_201_1.time_ and arg_201_1.time_ <= var_204_52 + arg_204_0 then
				arg_201_1.allBtn_.enabled = false
			end

			local var_204_53 = 2.33333333333333

			if arg_201_1.time_ >= var_204_52 + var_204_53 and arg_201_1.time_ < var_204_52 + var_204_53 + arg_204_0 then
				arg_201_1.allBtn_.enabled = true
			end

			if arg_201_1.frameCnt_ <= 1 then
				arg_201_1.dialog_:SetActive(false)
			end

			local var_204_54 = 2.33333333333333
			local var_204_55 = 1.4

			if var_204_54 < arg_201_1.time_ and arg_201_1.time_ <= var_204_54 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0

				arg_201_1.dialog_:SetActive(true)

				arg_201_1.dialogCg_.alpha = 0

				local var_204_56 = LeanTween.value(arg_201_1.dialog_, 0, 1, 0.3)

				var_204_56:setOnUpdate(LuaHelper.FloatAction(function(arg_205_0)
					arg_201_1.dialogCg_.alpha = arg_205_0
				end))
				var_204_56:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_201_1.dialog_)
					var_204_56:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_201_1.duration_ = arg_201_1.duration_ + 0.3

				SetActive(arg_201_1.leftNameGo_, false)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_57 = arg_201_1:GetWordFromCfg(111011048)
				local var_204_58 = arg_201_1:FormatText(var_204_57.content)

				arg_201_1.text_.text = var_204_58

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_59 = 56
				local var_204_60 = utf8.len(var_204_58)
				local var_204_61 = var_204_59 <= 0 and var_204_55 or var_204_55 * (var_204_60 / var_204_59)

				if var_204_61 > 0 and var_204_55 < var_204_61 then
					arg_201_1.talkMaxDuration = var_204_61
					var_204_54 = var_204_54 + 0.3

					if var_204_61 + var_204_54 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_61 + var_204_54
					end
				end

				arg_201_1.text_.text = var_204_58
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_62 = var_204_54 + 0.3
			local var_204_63 = math.max(var_204_55, arg_201_1.talkMaxDuration)

			if var_204_62 <= arg_201_1.time_ and arg_201_1.time_ < var_204_62 + var_204_63 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_62) / var_204_63

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_62 + var_204_63 and arg_201_1.time_ < var_204_62 + var_204_63 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_201_1:InitPlayNodeList()
	end,
	Play111011049 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 111011049
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play111011050(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 0
			local var_210_1 = 0.95

			if var_210_0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, false)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_2 = arg_207_1:GetWordFromCfg(111011049)
				local var_210_3 = arg_207_1:FormatText(var_210_2.content)

				arg_207_1.text_.text = var_210_3

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_4 = 38
				local var_210_5 = utf8.len(var_210_3)
				local var_210_6 = var_210_4 <= 0 and var_210_1 or var_210_1 * (var_210_5 / var_210_4)

				if var_210_6 > 0 and var_210_1 < var_210_6 then
					arg_207_1.talkMaxDuration = var_210_6

					if var_210_6 + var_210_0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_6 + var_210_0
					end
				end

				arg_207_1.text_.text = var_210_3
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_7 = math.max(var_210_1, arg_207_1.talkMaxDuration)

			if var_210_0 <= arg_207_1.time_ and arg_207_1.time_ < var_210_0 + var_210_7 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_0) / var_210_7

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_0 + var_210_7 and arg_207_1.time_ < var_210_0 + var_210_7 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play111011050 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 111011050
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play111011051(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 0
			local var_214_1 = 0.85

			if var_214_0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_0 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_2 = arg_211_1:GetWordFromCfg(111011050)
				local var_214_3 = arg_211_1:FormatText(var_214_2.content)

				arg_211_1.text_.text = var_214_3

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_4 = 34
				local var_214_5 = utf8.len(var_214_3)
				local var_214_6 = var_214_4 <= 0 and var_214_1 or var_214_1 * (var_214_5 / var_214_4)

				if var_214_6 > 0 and var_214_1 < var_214_6 then
					arg_211_1.talkMaxDuration = var_214_6

					if var_214_6 + var_214_0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_6 + var_214_0
					end
				end

				arg_211_1.text_.text = var_214_3
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_7 = math.max(var_214_1, arg_211_1.talkMaxDuration)

			if var_214_0 <= arg_211_1.time_ and arg_211_1.time_ < var_214_0 + var_214_7 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_0) / var_214_7

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_0 + var_214_7 and arg_211_1.time_ < var_214_0 + var_214_7 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play111011051 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 111011051
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play111011052(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 0
			local var_218_1 = 0.175

			if var_218_0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_2 = arg_215_1:FormatText(StoryNameCfg[7].name)

				arg_215_1.leftNameTxt_.text = var_218_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, true)
				arg_215_1.iconController_:SetSelectedState("hero")

				arg_215_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_215_1.callingController_:SetSelectedState("normal")

				arg_215_1.keyicon_.color = Color.New(1, 1, 1)
				arg_215_1.icon_.color = Color.New(1, 1, 1)

				local var_218_3 = arg_215_1:GetWordFromCfg(111011051)
				local var_218_4 = arg_215_1:FormatText(var_218_3.content)

				arg_215_1.text_.text = var_218_4

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_5 = 7
				local var_218_6 = utf8.len(var_218_4)
				local var_218_7 = var_218_5 <= 0 and var_218_1 or var_218_1 * (var_218_6 / var_218_5)

				if var_218_7 > 0 and var_218_1 < var_218_7 then
					arg_215_1.talkMaxDuration = var_218_7

					if var_218_7 + var_218_0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_7 + var_218_0
					end
				end

				arg_215_1.text_.text = var_218_4
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_8 = math.max(var_218_1, arg_215_1.talkMaxDuration)

			if var_218_0 <= arg_215_1.time_ and arg_215_1.time_ < var_218_0 + var_218_8 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_0) / var_218_8

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_0 + var_218_8 and arg_215_1.time_ < var_218_0 + var_218_8 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play111011052 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 111011052
		arg_219_1.duration_ = 1.53

		local var_219_0 = {
			ko = 1.533,
			en = 1.166
		}
		local var_219_1 = manager.audio:GetLocalizationFlag()

		if var_219_0[var_219_1] ~= nil then
			arg_219_1.duration_ = var_219_0[var_219_1]
		end

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play111011053(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 0
			local var_222_1 = 0.05

			if var_222_0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				local var_222_2 = arg_219_1:FormatText(StoryNameCfg[36].name)

				arg_219_1.leftNameTxt_.text = var_222_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_3 = arg_219_1:GetWordFromCfg(111011052)
				local var_222_4 = arg_219_1:FormatText(var_222_3.content)

				arg_219_1.text_.text = var_222_4

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_5 = 2
				local var_222_6 = utf8.len(var_222_4)
				local var_222_7 = var_222_5 <= 0 and var_222_1 or var_222_1 * (var_222_6 / var_222_5)

				if var_222_7 > 0 and var_222_1 < var_222_7 then
					arg_219_1.talkMaxDuration = var_222_7

					if var_222_7 + var_222_0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_7 + var_222_0
					end
				end

				arg_219_1.text_.text = var_222_4
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111011", "111011052", "story_v_out_111011.awb") ~= 0 then
					local var_222_8 = manager.audio:GetVoiceLength("story_v_out_111011", "111011052", "story_v_out_111011.awb") / 1000

					if var_222_8 + var_222_0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_8 + var_222_0
					end

					if var_222_3.prefab_name ~= "" and arg_219_1.actors_[var_222_3.prefab_name] ~= nil then
						local var_222_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_3.prefab_name].transform, "story_v_out_111011", "111011052", "story_v_out_111011.awb")

						arg_219_1:RecordAudio("111011052", var_222_9)
						arg_219_1:RecordAudio("111011052", var_222_9)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_111011", "111011052", "story_v_out_111011.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_111011", "111011052", "story_v_out_111011.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_10 = math.max(var_222_1, arg_219_1.talkMaxDuration)

			if var_222_0 <= arg_219_1.time_ and arg_219_1.time_ < var_222_0 + var_222_10 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_0) / var_222_10

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_0 + var_222_10 and arg_219_1.time_ < var_222_0 + var_222_10 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play111011053 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 111011053
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play111011054(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = 0
			local var_226_1 = 1.2

			if var_226_0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_0 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, false)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_2 = arg_223_1:GetWordFromCfg(111011053)
				local var_226_3 = arg_223_1:FormatText(var_226_2.content)

				arg_223_1.text_.text = var_226_3

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_4 = 48
				local var_226_5 = utf8.len(var_226_3)
				local var_226_6 = var_226_4 <= 0 and var_226_1 or var_226_1 * (var_226_5 / var_226_4)

				if var_226_6 > 0 and var_226_1 < var_226_6 then
					arg_223_1.talkMaxDuration = var_226_6

					if var_226_6 + var_226_0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_6 + var_226_0
					end
				end

				arg_223_1.text_.text = var_226_3
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_7 = math.max(var_226_1, arg_223_1.talkMaxDuration)

			if var_226_0 <= arg_223_1.time_ and arg_223_1.time_ < var_226_0 + var_226_7 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_0) / var_226_7

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_0 + var_226_7 and arg_223_1.time_ < var_226_0 + var_226_7 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play111011054 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 111011054
		arg_227_1.duration_ = 7.85

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play111011055(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = "ST01a"

			if arg_227_1.bgs_[var_230_0] == nil then
				local var_230_1 = Object.Instantiate(arg_227_1.paintGo_)

				var_230_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_230_0)
				var_230_1.name = var_230_0
				var_230_1.transform.parent = arg_227_1.stage_.transform
				var_230_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_227_1.bgs_[var_230_0] = var_230_1
			end

			local var_230_2 = 1.5

			if var_230_2 < arg_227_1.time_ and arg_227_1.time_ <= var_230_2 + arg_230_0 then
				local var_230_3 = manager.ui.mainCamera.transform.localPosition
				local var_230_4 = Vector3.New(0, 0, 10) + Vector3.New(var_230_3.x, var_230_3.y, 0)
				local var_230_5 = arg_227_1.bgs_.ST01a

				var_230_5.transform.localPosition = var_230_4
				var_230_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_230_6 = var_230_5:GetComponent("SpriteRenderer")

				if var_230_6 and var_230_6.sprite then
					local var_230_7 = (var_230_5.transform.localPosition - var_230_3).z
					local var_230_8 = manager.ui.mainCameraCom_
					local var_230_9 = 2 * var_230_7 * Mathf.Tan(var_230_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_230_10 = var_230_9 * var_230_8.aspect
					local var_230_11 = var_230_6.sprite.bounds.size.x
					local var_230_12 = var_230_6.sprite.bounds.size.y
					local var_230_13 = var_230_10 / var_230_11
					local var_230_14 = var_230_9 / var_230_12
					local var_230_15 = var_230_14 < var_230_13 and var_230_13 or var_230_14

					var_230_5.transform.localScale = Vector3.New(var_230_15, var_230_15, 0)
				end

				for iter_230_0, iter_230_1 in pairs(arg_227_1.bgs_) do
					if iter_230_0 ~= "ST01a" then
						iter_230_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_230_16 = arg_227_1.bgs_.B13a
			local var_230_17 = 0

			if var_230_17 < arg_227_1.time_ and arg_227_1.time_ <= var_230_17 + arg_230_0 then
				local var_230_18 = var_230_16:GetComponent("SpriteRenderer")

				if var_230_18 then
					arg_227_1.var_.alphaOldValueB13a = var_230_18.color.a
					arg_227_1.var_.alphaMatValueB13a = var_230_18
				end

				arg_227_1.var_.alphaOldValueB13a = 1
			end

			local var_230_19 = 1.5

			if var_230_17 <= arg_227_1.time_ and arg_227_1.time_ < var_230_17 + var_230_19 then
				local var_230_20 = (arg_227_1.time_ - var_230_17) / var_230_19
				local var_230_21 = Mathf.Lerp(arg_227_1.var_.alphaOldValueB13a, 0, var_230_20)

				if arg_227_1.var_.alphaMatValueB13a then
					local var_230_22 = arg_227_1.var_.alphaMatValueB13a.color

					var_230_22.a = var_230_21
					arg_227_1.var_.alphaMatValueB13a.color = var_230_22
				end
			end

			if arg_227_1.time_ >= var_230_17 + var_230_19 and arg_227_1.time_ < var_230_17 + var_230_19 + arg_230_0 and arg_227_1.var_.alphaMatValueB13a then
				local var_230_23 = arg_227_1.var_.alphaMatValueB13a
				local var_230_24 = var_230_23.color

				var_230_24.a = 0
				var_230_23.color = var_230_24
			end

			local var_230_25 = arg_227_1.bgs_.ST01a
			local var_230_26 = 1.5

			if var_230_26 < arg_227_1.time_ and arg_227_1.time_ <= var_230_26 + arg_230_0 then
				local var_230_27 = var_230_25:GetComponent("SpriteRenderer")

				if var_230_27 then
					arg_227_1.var_.alphaOldValueST01a = var_230_27.color.a
					arg_227_1.var_.alphaMatValueST01a = var_230_27
				end

				arg_227_1.var_.alphaOldValueST01a = 0
			end

			local var_230_28 = 1.5

			if var_230_26 <= arg_227_1.time_ and arg_227_1.time_ < var_230_26 + var_230_28 then
				local var_230_29 = (arg_227_1.time_ - var_230_26) / var_230_28
				local var_230_30 = Mathf.Lerp(arg_227_1.var_.alphaOldValueST01a, 1, var_230_29)

				if arg_227_1.var_.alphaMatValueST01a then
					local var_230_31 = arg_227_1.var_.alphaMatValueST01a.color

					var_230_31.a = var_230_30
					arg_227_1.var_.alphaMatValueST01a.color = var_230_31
				end
			end

			if arg_227_1.time_ >= var_230_26 + var_230_28 and arg_227_1.time_ < var_230_26 + var_230_28 + arg_230_0 and arg_227_1.var_.alphaMatValueST01a then
				local var_230_32 = arg_227_1.var_.alphaMatValueST01a
				local var_230_33 = var_230_32.color

				var_230_33.a = 1
				var_230_32.color = var_230_33
			end

			local var_230_34 = 0

			if var_230_34 < arg_227_1.time_ and arg_227_1.time_ <= var_230_34 + arg_230_0 then
				arg_227_1.allBtn_.enabled = false
			end

			local var_230_35 = 2.85

			if arg_227_1.time_ >= var_230_34 + var_230_35 and arg_227_1.time_ < var_230_34 + var_230_35 + arg_230_0 then
				arg_227_1.allBtn_.enabled = true
			end

			if arg_227_1.frameCnt_ <= 1 then
				arg_227_1.dialog_:SetActive(false)
			end

			local var_230_36 = 2.85
			local var_230_37 = 0.15

			if var_230_36 < arg_227_1.time_ and arg_227_1.time_ <= var_230_36 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0

				arg_227_1.dialog_:SetActive(true)

				arg_227_1.dialogCg_.alpha = 0

				local var_230_38 = LeanTween.value(arg_227_1.dialog_, 0, 1, 0.3)

				var_230_38:setOnUpdate(LuaHelper.FloatAction(function(arg_231_0)
					arg_227_1.dialogCg_.alpha = arg_231_0
				end))
				var_230_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_227_1.dialog_)
					var_230_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_227_1.duration_ = arg_227_1.duration_ + 0.3

				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_39 = arg_227_1:FormatText(StoryNameCfg[7].name)

				arg_227_1.leftNameTxt_.text = var_230_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, true)
				arg_227_1.iconController_:SetSelectedState("hero")

				arg_227_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_227_1.callingController_:SetSelectedState("normal")

				arg_227_1.keyicon_.color = Color.New(1, 1, 1)
				arg_227_1.icon_.color = Color.New(1, 1, 1)

				local var_230_40 = arg_227_1:GetWordFromCfg(111011054)
				local var_230_41 = arg_227_1:FormatText(var_230_40.content)

				arg_227_1.text_.text = var_230_41

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_42 = 6
				local var_230_43 = utf8.len(var_230_41)
				local var_230_44 = var_230_42 <= 0 and var_230_37 or var_230_37 * (var_230_43 / var_230_42)

				if var_230_44 > 0 and var_230_37 < var_230_44 then
					arg_227_1.talkMaxDuration = var_230_44
					var_230_36 = var_230_36 + 0.3

					if var_230_44 + var_230_36 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_44 + var_230_36
					end
				end

				arg_227_1.text_.text = var_230_41
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_45 = var_230_36 + 0.3
			local var_230_46 = math.max(var_230_37, arg_227_1.talkMaxDuration)

			if var_230_45 <= arg_227_1.time_ and arg_227_1.time_ < var_230_45 + var_230_46 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_45) / var_230_46

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_45 + var_230_46 and arg_227_1.time_ < var_230_45 + var_230_46 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play111011055 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 111011055
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play111011056(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = arg_233_1.bgs_.ST01a
			local var_236_1 = 0.8

			if var_236_1 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 then
				local var_236_2 = var_236_0:GetComponent("SpriteRenderer")

				if var_236_2 then
					arg_233_1.var_.alphaOldValueST01a = var_236_2.color.a
					arg_233_1.var_.alphaMatValueST01a = var_236_2
				end

				arg_233_1.var_.alphaOldValueST01a = 1
			end

			local var_236_3 = 2.5

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_3 then
				local var_236_4 = (arg_233_1.time_ - var_236_1) / var_236_3
				local var_236_5 = Mathf.Lerp(arg_233_1.var_.alphaOldValueST01a, 0, var_236_4)

				if arg_233_1.var_.alphaMatValueST01a then
					local var_236_6 = arg_233_1.var_.alphaMatValueST01a.color

					var_236_6.a = var_236_5
					arg_233_1.var_.alphaMatValueST01a.color = var_236_6
				end
			end

			if arg_233_1.time_ >= var_236_1 + var_236_3 and arg_233_1.time_ < var_236_1 + var_236_3 + arg_236_0 and arg_233_1.var_.alphaMatValueST01a then
				local var_236_7 = arg_233_1.var_.alphaMatValueST01a
				local var_236_8 = var_236_7.color

				var_236_8.a = 0
				var_236_7.color = var_236_8
			end

			local var_236_9 = 0

			if var_236_9 < arg_233_1.time_ and arg_233_1.time_ <= var_236_9 + arg_236_0 then
				arg_233_1.allBtn_.enabled = false
			end

			local var_236_10 = 3.3

			if arg_233_1.time_ >= var_236_9 + var_236_10 and arg_233_1.time_ < var_236_9 + var_236_10 + arg_236_0 then
				arg_233_1.allBtn_.enabled = true
			end

			local var_236_11 = 0
			local var_236_12 = 0.625

			if var_236_11 < arg_233_1.time_ and arg_233_1.time_ <= var_236_11 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, false)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_13 = arg_233_1:GetWordFromCfg(111011055)
				local var_236_14 = arg_233_1:FormatText(var_236_13.content)

				arg_233_1.text_.text = var_236_14

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_15 = 25
				local var_236_16 = utf8.len(var_236_14)
				local var_236_17 = var_236_15 <= 0 and var_236_12 or var_236_12 * (var_236_16 / var_236_15)

				if var_236_17 > 0 and var_236_12 < var_236_17 then
					arg_233_1.talkMaxDuration = var_236_17

					if var_236_17 + var_236_11 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_17 + var_236_11
					end
				end

				arg_233_1.text_.text = var_236_14
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_18 = math.max(var_236_12, arg_233_1.talkMaxDuration)

			if var_236_11 <= arg_233_1.time_ and arg_233_1.time_ < var_236_11 + var_236_18 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_11) / var_236_18

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_11 + var_236_18 and arg_233_1.time_ < var_236_11 + var_236_18 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play111011056 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 111011056
		arg_237_1.duration_ = 7.33

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play111011057(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = 0

			if var_240_0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_0 + arg_240_0 then
				local var_240_1 = manager.ui.mainCamera.transform.localPosition
				local var_240_2 = Vector3.New(0, 0, 10) + Vector3.New(var_240_1.x, var_240_1.y, 0)
				local var_240_3 = arg_237_1.bgs_.D999

				var_240_3.transform.localPosition = var_240_2
				var_240_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_240_4 = var_240_3:GetComponent("SpriteRenderer")

				if var_240_4 and var_240_4.sprite then
					local var_240_5 = (var_240_3.transform.localPosition - var_240_1).z
					local var_240_6 = manager.ui.mainCameraCom_
					local var_240_7 = 2 * var_240_5 * Mathf.Tan(var_240_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_240_8 = var_240_7 * var_240_6.aspect
					local var_240_9 = var_240_4.sprite.bounds.size.x
					local var_240_10 = var_240_4.sprite.bounds.size.y
					local var_240_11 = var_240_8 / var_240_9
					local var_240_12 = var_240_7 / var_240_10
					local var_240_13 = var_240_12 < var_240_11 and var_240_11 or var_240_12

					var_240_3.transform.localScale = Vector3.New(var_240_13, var_240_13, 0)
				end

				for iter_240_0, iter_240_1 in pairs(arg_237_1.bgs_) do
					if iter_240_0 ~= "D999" then
						iter_240_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_240_14 = arg_237_1.bgs_.D999
			local var_240_15 = 0

			if var_240_15 < arg_237_1.time_ and arg_237_1.time_ <= var_240_15 + arg_240_0 then
				local var_240_16 = var_240_14:GetComponent("SpriteRenderer")

				if var_240_16 then
					arg_237_1.var_.alphaOldValueD999 = var_240_16.color.a
					arg_237_1.var_.alphaMatValueD999 = var_240_16
				end
			end

			local var_240_17 = 1.5

			if var_240_15 <= arg_237_1.time_ and arg_237_1.time_ < var_240_15 + var_240_17 then
				local var_240_18 = (arg_237_1.time_ - var_240_15) / var_240_17
				local var_240_19 = Mathf.Lerp(arg_237_1.var_.alphaOldValueD999, 0.5, var_240_18)

				if arg_237_1.var_.alphaMatValueD999 then
					local var_240_20 = arg_237_1.var_.alphaMatValueD999.color

					var_240_20.a = var_240_19
					arg_237_1.var_.alphaMatValueD999.color = var_240_20
				end
			end

			if arg_237_1.time_ >= var_240_15 + var_240_17 and arg_237_1.time_ < var_240_15 + var_240_17 + arg_240_0 and arg_237_1.var_.alphaMatValueD999 then
				local var_240_21 = arg_237_1.var_.alphaMatValueD999
				local var_240_22 = var_240_21.color

				var_240_22.a = 0.5
				var_240_21.color = var_240_22
			end

			local var_240_23 = 0

			if var_240_23 < arg_237_1.time_ and arg_237_1.time_ <= var_240_23 + arg_240_0 then
				arg_237_1.mask_.enabled = true
				arg_237_1.mask_.raycastTarget = false

				arg_237_1:SetGaussion(false)
			end

			local var_240_24 = 0.333333333333333

			if var_240_23 <= arg_237_1.time_ and arg_237_1.time_ < var_240_23 + var_240_24 then
				local var_240_25 = (arg_237_1.time_ - var_240_23) / var_240_24
				local var_240_26 = Color.New(1, 1, 1)

				var_240_26.a = Mathf.Lerp(1, 0, var_240_25)
				arg_237_1.mask_.color = var_240_26
			end

			if arg_237_1.time_ >= var_240_23 + var_240_24 and arg_237_1.time_ < var_240_23 + var_240_24 + arg_240_0 then
				local var_240_27 = Color.New(1, 1, 1)
				local var_240_28 = 0

				arg_237_1.mask_.enabled = false
				var_240_27.a = var_240_28
				arg_237_1.mask_.color = var_240_27
			end

			local var_240_29 = 0

			if var_240_29 < arg_237_1.time_ and arg_237_1.time_ <= var_240_29 + arg_240_0 then
				arg_237_1.allBtn_.enabled = false
			end

			local var_240_30 = 2.33333333333333

			if arg_237_1.time_ >= var_240_29 + var_240_30 and arg_237_1.time_ < var_240_29 + var_240_30 + arg_240_0 then
				arg_237_1.allBtn_.enabled = true
			end

			if arg_237_1.frameCnt_ <= 1 then
				arg_237_1.dialog_:SetActive(false)
			end

			local var_240_31 = 2.33333333333333
			local var_240_32 = 0.875

			if var_240_31 < arg_237_1.time_ and arg_237_1.time_ <= var_240_31 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0

				arg_237_1.dialog_:SetActive(true)

				arg_237_1.dialogCg_.alpha = 0

				local var_240_33 = LeanTween.value(arg_237_1.dialog_, 0, 1, 0.3)

				var_240_33:setOnUpdate(LuaHelper.FloatAction(function(arg_241_0)
					arg_237_1.dialogCg_.alpha = arg_241_0
				end))
				var_240_33:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_237_1.dialog_)
					var_240_33:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_237_1.duration_ = arg_237_1.duration_ + 0.3

				SetActive(arg_237_1.leftNameGo_, false)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_34 = arg_237_1:GetWordFromCfg(111011056)
				local var_240_35 = arg_237_1:FormatText(var_240_34.content)

				arg_237_1.text_.text = var_240_35

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_36 = 35
				local var_240_37 = utf8.len(var_240_35)
				local var_240_38 = var_240_36 <= 0 and var_240_32 or var_240_32 * (var_240_37 / var_240_36)

				if var_240_38 > 0 and var_240_32 < var_240_38 then
					arg_237_1.talkMaxDuration = var_240_38
					var_240_31 = var_240_31 + 0.3

					if var_240_38 + var_240_31 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_38 + var_240_31
					end
				end

				arg_237_1.text_.text = var_240_35
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_39 = var_240_31 + 0.3
			local var_240_40 = math.max(var_240_32, arg_237_1.talkMaxDuration)

			if var_240_39 <= arg_237_1.time_ and arg_237_1.time_ < var_240_39 + var_240_40 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_39) / var_240_40

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_39 + var_240_40 and arg_237_1.time_ < var_240_39 + var_240_40 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play111011057 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 111011057
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play111011058(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 0
			local var_246_1 = 1.575

			if var_246_0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_0 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, false)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_2 = arg_243_1:GetWordFromCfg(111011057)
				local var_246_3 = arg_243_1:FormatText(var_246_2.content)

				arg_243_1.text_.text = var_246_3

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_4 = 63
				local var_246_5 = utf8.len(var_246_3)
				local var_246_6 = var_246_4 <= 0 and var_246_1 or var_246_1 * (var_246_5 / var_246_4)

				if var_246_6 > 0 and var_246_1 < var_246_6 then
					arg_243_1.talkMaxDuration = var_246_6

					if var_246_6 + var_246_0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_6 + var_246_0
					end
				end

				arg_243_1.text_.text = var_246_3
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_7 = math.max(var_246_1, arg_243_1.talkMaxDuration)

			if var_246_0 <= arg_243_1.time_ and arg_243_1.time_ < var_246_0 + var_246_7 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_0) / var_246_7

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_0 + var_246_7 and arg_243_1.time_ < var_246_0 + var_246_7 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play111011058 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 111011058
		arg_247_1.duration_ = 4.7

		local var_247_0 = {
			ja = 3.566,
			ko = 2.3,
			zh = 4.7,
			en = 3.133
		}
		local var_247_1 = manager.audio:GetLocalizationFlag()

		if var_247_0[var_247_1] ~= nil then
			arg_247_1.duration_ = var_247_0[var_247_1]
		end

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play111011059(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = 0
			local var_250_1 = 1

			if var_250_0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_0 + arg_250_0 then
				local var_250_2 = "play"
				local var_250_3 = "music"

				arg_247_1:AudioAction(var_250_2, var_250_3, "bgm_activity_1_1_hel_story", "bgm_activity_1_1_hel_story", "bgm_activity_1_1_hel_story.awb")

				local var_250_4 = ""
				local var_250_5 = manager.audio:GetAudioName("bgm_activity_1_1_hel_story", "bgm_activity_1_1_hel_story")

				if var_250_5 ~= "" then
					if arg_247_1.bgmTxt_.text ~= var_250_5 and arg_247_1.bgmTxt_.text ~= "" then
						if arg_247_1.bgmTxt2_.text ~= "" then
							arg_247_1.bgmTxt_.text = arg_247_1.bgmTxt2_.text
						end

						arg_247_1.bgmTxt2_.text = var_250_5

						arg_247_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_247_1.bgmTxt_.text = var_250_5
						arg_247_1.bgmTxt2_.text = var_250_5
					end

					if arg_247_1.bgmTimer then
						arg_247_1.bgmTimer:Stop()

						arg_247_1.bgmTimer = nil
					end

					if arg_247_1.settingData.show_music_name == 1 then
						arg_247_1.musicController:SetSelectedState("show")
						arg_247_1.musicAnimator_:Play("open", 0, 0)

						if arg_247_1.settingData.music_time ~= 0 then
							arg_247_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_247_1.settingData.music_time), function()
								if arg_247_1 == nil or isNil(arg_247_1.bgmTxt_) then
									return
								end

								arg_247_1.musicController:SetSelectedState("hide")
								arg_247_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_250_6 = 0
			local var_250_7 = 0.225

			if var_250_6 < arg_247_1.time_ and arg_247_1.time_ <= var_250_6 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_8 = arg_247_1:FormatText(StoryNameCfg[178].name)

				arg_247_1.leftNameTxt_.text = var_250_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, true)
				arg_247_1.iconController_:SetSelectedState("hero")

				arg_247_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_heidie")

				arg_247_1.callingController_:SetSelectedState("normal")

				arg_247_1.keyicon_.color = Color.New(1, 1, 1)
				arg_247_1.icon_.color = Color.New(1, 1, 1)

				local var_250_9 = arg_247_1:GetWordFromCfg(111011058)
				local var_250_10 = arg_247_1:FormatText(var_250_9.content)

				arg_247_1.text_.text = var_250_10

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_11 = 9
				local var_250_12 = utf8.len(var_250_10)
				local var_250_13 = var_250_11 <= 0 and var_250_7 or var_250_7 * (var_250_12 / var_250_11)

				if var_250_13 > 0 and var_250_7 < var_250_13 then
					arg_247_1.talkMaxDuration = var_250_13

					if var_250_13 + var_250_6 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_13 + var_250_6
					end
				end

				arg_247_1.text_.text = var_250_10
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111011", "111011058", "story_v_out_111011.awb") ~= 0 then
					local var_250_14 = manager.audio:GetVoiceLength("story_v_out_111011", "111011058", "story_v_out_111011.awb") / 1000

					if var_250_14 + var_250_6 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_14 + var_250_6
					end

					if var_250_9.prefab_name ~= "" and arg_247_1.actors_[var_250_9.prefab_name] ~= nil then
						local var_250_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_9.prefab_name].transform, "story_v_out_111011", "111011058", "story_v_out_111011.awb")

						arg_247_1:RecordAudio("111011058", var_250_15)
						arg_247_1:RecordAudio("111011058", var_250_15)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_111011", "111011058", "story_v_out_111011.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_111011", "111011058", "story_v_out_111011.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_16 = math.max(var_250_7, arg_247_1.talkMaxDuration)

			if var_250_6 <= arg_247_1.time_ and arg_247_1.time_ < var_250_6 + var_250_16 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_6) / var_250_16

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_6 + var_250_16 and arg_247_1.time_ < var_250_6 + var_250_16 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play111011059 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 111011059
		arg_252_1.duration_ = 4.07

		local var_252_0 = {
			ja = 4.066,
			ko = 1.566,
			zh = 1.8,
			en = 1.566
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
				arg_252_0:Play111011060(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = 0
			local var_255_1 = 0.125

			if var_255_0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_0 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				local var_255_2 = arg_252_1:FormatText(StoryNameCfg[178].name)

				arg_252_1.leftNameTxt_.text = var_255_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, true)
				arg_252_1.iconController_:SetSelectedState("hero")

				arg_252_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_heidie")

				arg_252_1.callingController_:SetSelectedState("normal")

				arg_252_1.keyicon_.color = Color.New(1, 1, 1)
				arg_252_1.icon_.color = Color.New(1, 1, 1)

				local var_255_3 = arg_252_1:GetWordFromCfg(111011059)
				local var_255_4 = arg_252_1:FormatText(var_255_3.content)

				arg_252_1.text_.text = var_255_4

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_5 = 5
				local var_255_6 = utf8.len(var_255_4)
				local var_255_7 = var_255_5 <= 0 and var_255_1 or var_255_1 * (var_255_6 / var_255_5)

				if var_255_7 > 0 and var_255_1 < var_255_7 then
					arg_252_1.talkMaxDuration = var_255_7

					if var_255_7 + var_255_0 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_7 + var_255_0
					end
				end

				arg_252_1.text_.text = var_255_4
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111011", "111011059", "story_v_out_111011.awb") ~= 0 then
					local var_255_8 = manager.audio:GetVoiceLength("story_v_out_111011", "111011059", "story_v_out_111011.awb") / 1000

					if var_255_8 + var_255_0 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_8 + var_255_0
					end

					if var_255_3.prefab_name ~= "" and arg_252_1.actors_[var_255_3.prefab_name] ~= nil then
						local var_255_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_3.prefab_name].transform, "story_v_out_111011", "111011059", "story_v_out_111011.awb")

						arg_252_1:RecordAudio("111011059", var_255_9)
						arg_252_1:RecordAudio("111011059", var_255_9)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_111011", "111011059", "story_v_out_111011.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_111011", "111011059", "story_v_out_111011.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_10 = math.max(var_255_1, arg_252_1.talkMaxDuration)

			if var_255_0 <= arg_252_1.time_ and arg_252_1.time_ < var_255_0 + var_255_10 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_0) / var_255_10

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_0 + var_255_10 and arg_252_1.time_ < var_255_0 + var_255_10 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play111011060 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 111011060
		arg_256_1.duration_ = 5

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play111011061(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = 0
			local var_259_1 = 1.425

			if var_259_0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_0 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, false)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_2 = arg_256_1:GetWordFromCfg(111011060)
				local var_259_3 = arg_256_1:FormatText(var_259_2.content)

				arg_256_1.text_.text = var_259_3

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_4 = 57
				local var_259_5 = utf8.len(var_259_3)
				local var_259_6 = var_259_4 <= 0 and var_259_1 or var_259_1 * (var_259_5 / var_259_4)

				if var_259_6 > 0 and var_259_1 < var_259_6 then
					arg_256_1.talkMaxDuration = var_259_6

					if var_259_6 + var_259_0 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_6 + var_259_0
					end
				end

				arg_256_1.text_.text = var_259_3
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)
				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_7 = math.max(var_259_1, arg_256_1.talkMaxDuration)

			if var_259_0 <= arg_256_1.time_ and arg_256_1.time_ < var_259_0 + var_259_7 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_0) / var_259_7

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_0 + var_259_7 and arg_256_1.time_ < var_259_0 + var_259_7 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play111011061 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 111011061
		arg_260_1.duration_ = 5

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play111011062(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = 0
			local var_263_1 = 0.75

			if var_263_0 < arg_260_1.time_ and arg_260_1.time_ <= var_263_0 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, false)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_2 = arg_260_1:GetWordFromCfg(111011061)
				local var_263_3 = arg_260_1:FormatText(var_263_2.content)

				arg_260_1.text_.text = var_263_3

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_4 = 30
				local var_263_5 = utf8.len(var_263_3)
				local var_263_6 = var_263_4 <= 0 and var_263_1 or var_263_1 * (var_263_5 / var_263_4)

				if var_263_6 > 0 and var_263_1 < var_263_6 then
					arg_260_1.talkMaxDuration = var_263_6

					if var_263_6 + var_263_0 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_6 + var_263_0
					end
				end

				arg_260_1.text_.text = var_263_3
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)
				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_7 = math.max(var_263_1, arg_260_1.talkMaxDuration)

			if var_263_0 <= arg_260_1.time_ and arg_260_1.time_ < var_263_0 + var_263_7 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_0) / var_263_7

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_0 + var_263_7 and arg_260_1.time_ < var_263_0 + var_263_7 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play111011062 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 111011062
		arg_264_1.duration_ = 13.43

		local var_264_0 = {
			ja = 13.433,
			ko = 5.766,
			zh = 6.666,
			en = 6.433
		}
		local var_264_1 = manager.audio:GetLocalizationFlag()

		if var_264_0[var_264_1] ~= nil then
			arg_264_1.duration_ = var_264_0[var_264_1]
		end

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play111011063(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			local var_267_0 = 0
			local var_267_1 = 0.5

			if var_267_0 < arg_264_1.time_ and arg_264_1.time_ <= var_267_0 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				local var_267_2 = arg_264_1:FormatText(StoryNameCfg[178].name)

				arg_264_1.leftNameTxt_.text = var_267_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, true)
				arg_264_1.iconController_:SetSelectedState("hero")

				arg_264_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_heidie")

				arg_264_1.callingController_:SetSelectedState("normal")

				arg_264_1.keyicon_.color = Color.New(1, 1, 1)
				arg_264_1.icon_.color = Color.New(1, 1, 1)

				local var_267_3 = arg_264_1:GetWordFromCfg(111011062)
				local var_267_4 = arg_264_1:FormatText(var_267_3.content)

				arg_264_1.text_.text = var_267_4

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_5 = 20
				local var_267_6 = utf8.len(var_267_4)
				local var_267_7 = var_267_5 <= 0 and var_267_1 or var_267_1 * (var_267_6 / var_267_5)

				if var_267_7 > 0 and var_267_1 < var_267_7 then
					arg_264_1.talkMaxDuration = var_267_7

					if var_267_7 + var_267_0 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_7 + var_267_0
					end
				end

				arg_264_1.text_.text = var_267_4
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111011", "111011062", "story_v_out_111011.awb") ~= 0 then
					local var_267_8 = manager.audio:GetVoiceLength("story_v_out_111011", "111011062", "story_v_out_111011.awb") / 1000

					if var_267_8 + var_267_0 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_8 + var_267_0
					end

					if var_267_3.prefab_name ~= "" and arg_264_1.actors_[var_267_3.prefab_name] ~= nil then
						local var_267_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_3.prefab_name].transform, "story_v_out_111011", "111011062", "story_v_out_111011.awb")

						arg_264_1:RecordAudio("111011062", var_267_9)
						arg_264_1:RecordAudio("111011062", var_267_9)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_out_111011", "111011062", "story_v_out_111011.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_out_111011", "111011062", "story_v_out_111011.awb")
				end

				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_10 = math.max(var_267_1, arg_264_1.talkMaxDuration)

			if var_267_0 <= arg_264_1.time_ and arg_264_1.time_ < var_267_0 + var_267_10 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_0) / var_267_10

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_0 + var_267_10 and arg_264_1.time_ < var_267_0 + var_267_10 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {}

		arg_264_1:InitPlayNodeList()
	end,
	Play111011063 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 111011063
		arg_268_1.duration_ = 3.6

		local var_268_0 = {
			ja = 3.6,
			ko = 2.6,
			zh = 2.633,
			en = 2.766
		}
		local var_268_1 = manager.audio:GetLocalizationFlag()

		if var_268_0[var_268_1] ~= nil then
			arg_268_1.duration_ = var_268_0[var_268_1]
		end

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play111011064(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			local var_271_0 = 0
			local var_271_1 = 0.25

			if var_271_0 < arg_268_1.time_ and arg_268_1.time_ <= var_271_0 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				local var_271_2 = arg_268_1:FormatText(StoryNameCfg[178].name)

				arg_268_1.leftNameTxt_.text = var_271_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, true)
				arg_268_1.iconController_:SetSelectedState("hero")

				arg_268_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_heidie")

				arg_268_1.callingController_:SetSelectedState("normal")

				arg_268_1.keyicon_.color = Color.New(1, 1, 1)
				arg_268_1.icon_.color = Color.New(1, 1, 1)

				local var_271_3 = arg_268_1:GetWordFromCfg(111011063)
				local var_271_4 = arg_268_1:FormatText(var_271_3.content)

				arg_268_1.text_.text = var_271_4

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_5 = 10
				local var_271_6 = utf8.len(var_271_4)
				local var_271_7 = var_271_5 <= 0 and var_271_1 or var_271_1 * (var_271_6 / var_271_5)

				if var_271_7 > 0 and var_271_1 < var_271_7 then
					arg_268_1.talkMaxDuration = var_271_7

					if var_271_7 + var_271_0 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_7 + var_271_0
					end
				end

				arg_268_1.text_.text = var_271_4
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111011", "111011063", "story_v_out_111011.awb") ~= 0 then
					local var_271_8 = manager.audio:GetVoiceLength("story_v_out_111011", "111011063", "story_v_out_111011.awb") / 1000

					if var_271_8 + var_271_0 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_8 + var_271_0
					end

					if var_271_3.prefab_name ~= "" and arg_268_1.actors_[var_271_3.prefab_name] ~= nil then
						local var_271_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_268_1.actors_[var_271_3.prefab_name].transform, "story_v_out_111011", "111011063", "story_v_out_111011.awb")

						arg_268_1:RecordAudio("111011063", var_271_9)
						arg_268_1:RecordAudio("111011063", var_271_9)
					else
						arg_268_1:AudioAction("play", "voice", "story_v_out_111011", "111011063", "story_v_out_111011.awb")
					end

					arg_268_1:RecordHistoryTalkVoice("story_v_out_111011", "111011063", "story_v_out_111011.awb")
				end

				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_10 = math.max(var_271_1, arg_268_1.talkMaxDuration)

			if var_271_0 <= arg_268_1.time_ and arg_268_1.time_ < var_271_0 + var_271_10 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_0) / var_271_10

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_0 + var_271_10 and arg_268_1.time_ < var_271_0 + var_271_10 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play111011064 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 111011064
		arg_272_1.duration_ = 5.5

		local var_272_0 = {
			ja = 5.5,
			ko = 2.9,
			zh = 2.533,
			en = 1.2
		}
		local var_272_1 = manager.audio:GetLocalizationFlag()

		if var_272_0[var_272_1] ~= nil then
			arg_272_1.duration_ = var_272_0[var_272_1]
		end

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play111011065(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			local var_275_0 = 0
			local var_275_1 = 0.25

			if var_275_0 < arg_272_1.time_ and arg_272_1.time_ <= var_275_0 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				local var_275_2 = arg_272_1:FormatText(StoryNameCfg[178].name)

				arg_272_1.leftNameTxt_.text = var_275_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, true)
				arg_272_1.iconController_:SetSelectedState("hero")

				arg_272_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_heidie")

				arg_272_1.callingController_:SetSelectedState("normal")

				arg_272_1.keyicon_.color = Color.New(1, 1, 1)
				arg_272_1.icon_.color = Color.New(1, 1, 1)

				local var_275_3 = arg_272_1:GetWordFromCfg(111011064)
				local var_275_4 = arg_272_1:FormatText(var_275_3.content)

				arg_272_1.text_.text = var_275_4

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_5 = 10
				local var_275_6 = utf8.len(var_275_4)
				local var_275_7 = var_275_5 <= 0 and var_275_1 or var_275_1 * (var_275_6 / var_275_5)

				if var_275_7 > 0 and var_275_1 < var_275_7 then
					arg_272_1.talkMaxDuration = var_275_7

					if var_275_7 + var_275_0 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_7 + var_275_0
					end
				end

				arg_272_1.text_.text = var_275_4
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111011", "111011064", "story_v_out_111011.awb") ~= 0 then
					local var_275_8 = manager.audio:GetVoiceLength("story_v_out_111011", "111011064", "story_v_out_111011.awb") / 1000

					if var_275_8 + var_275_0 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_8 + var_275_0
					end

					if var_275_3.prefab_name ~= "" and arg_272_1.actors_[var_275_3.prefab_name] ~= nil then
						local var_275_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_3.prefab_name].transform, "story_v_out_111011", "111011064", "story_v_out_111011.awb")

						arg_272_1:RecordAudio("111011064", var_275_9)
						arg_272_1:RecordAudio("111011064", var_275_9)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_out_111011", "111011064", "story_v_out_111011.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_out_111011", "111011064", "story_v_out_111011.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_10 = math.max(var_275_1, arg_272_1.talkMaxDuration)

			if var_275_0 <= arg_272_1.time_ and arg_272_1.time_ < var_275_0 + var_275_10 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_0) / var_275_10

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_0 + var_275_10 and arg_272_1.time_ < var_275_0 + var_275_10 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {}

		arg_272_1:InitPlayNodeList()
	end,
	Play111011065 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 111011065
		arg_276_1.duration_ = 5

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play111011066(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			local var_279_0 = 0
			local var_279_1 = 1

			if var_279_0 < arg_276_1.time_ and arg_276_1.time_ <= var_279_0 + arg_279_0 then
				local var_279_2 = "play"
				local var_279_3 = "effect"

				arg_276_1:AudioAction(var_279_2, var_279_3, "se_story_activity_1_1", "se_story_activity_1_1_flap", "")
			end

			local var_279_4 = 0
			local var_279_5 = 0.9

			if var_279_4 < arg_276_1.time_ and arg_276_1.time_ <= var_279_4 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, false)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_6 = arg_276_1:GetWordFromCfg(111011065)
				local var_279_7 = arg_276_1:FormatText(var_279_6.content)

				arg_276_1.text_.text = var_279_7

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_8 = 36
				local var_279_9 = utf8.len(var_279_7)
				local var_279_10 = var_279_8 <= 0 and var_279_5 or var_279_5 * (var_279_9 / var_279_8)

				if var_279_10 > 0 and var_279_5 < var_279_10 then
					arg_276_1.talkMaxDuration = var_279_10

					if var_279_10 + var_279_4 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_10 + var_279_4
					end
				end

				arg_276_1.text_.text = var_279_7
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)
				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_11 = math.max(var_279_5, arg_276_1.talkMaxDuration)

			if var_279_4 <= arg_276_1.time_ and arg_276_1.time_ < var_279_4 + var_279_11 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_4) / var_279_11

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_4 + var_279_11 and arg_276_1.time_ < var_279_4 + var_279_11 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	Play111011066 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 111011066
		arg_280_1.duration_ = 5

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play111011067(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			local var_283_0 = 0
			local var_283_1 = 1.15

			if var_283_0 < arg_280_1.time_ and arg_280_1.time_ <= var_283_0 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, false)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_2 = arg_280_1:GetWordFromCfg(111011066)
				local var_283_3 = arg_280_1:FormatText(var_283_2.content)

				arg_280_1.text_.text = var_283_3

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_4 = 46
				local var_283_5 = utf8.len(var_283_3)
				local var_283_6 = var_283_4 <= 0 and var_283_1 or var_283_1 * (var_283_5 / var_283_4)

				if var_283_6 > 0 and var_283_1 < var_283_6 then
					arg_280_1.talkMaxDuration = var_283_6

					if var_283_6 + var_283_0 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_6 + var_283_0
					end
				end

				arg_280_1.text_.text = var_283_3
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)
				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_7 = math.max(var_283_1, arg_280_1.talkMaxDuration)

			if var_283_0 <= arg_280_1.time_ and arg_280_1.time_ < var_283_0 + var_283_7 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_0) / var_283_7

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_0 + var_283_7 and arg_280_1.time_ < var_283_0 + var_283_7 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play111011067 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 111011067
		arg_284_1.duration_ = 5

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
			arg_284_1.auto_ = false
		end

		function arg_284_1.playNext_(arg_286_0)
			arg_284_1.onStoryFinished_()
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			local var_287_0 = 0
			local var_287_1 = 0.825

			if var_287_0 < arg_284_1.time_ and arg_284_1.time_ <= var_287_0 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, false)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_2 = arg_284_1:GetWordFromCfg(111011067)
				local var_287_3 = arg_284_1:FormatText(var_287_2.content)

				arg_284_1.text_.text = var_287_3

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_4 = 33
				local var_287_5 = utf8.len(var_287_3)
				local var_287_6 = var_287_4 <= 0 and var_287_1 or var_287_1 * (var_287_5 / var_287_4)

				if var_287_6 > 0 and var_287_1 < var_287_6 then
					arg_284_1.talkMaxDuration = var_287_6

					if var_287_6 + var_287_0 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_6 + var_287_0
					end
				end

				arg_284_1.text_.text = var_287_3
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)
				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_7 = math.max(var_287_1, arg_284_1.talkMaxDuration)

			if var_287_0 <= arg_284_1.time_ and arg_284_1.time_ < var_287_0 + var_287_7 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_0) / var_287_7

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_0 + var_287_7 and arg_284_1.time_ < var_287_0 + var_287_7 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/D999",
		"TextureConfig/Background/ST03a",
		"TextureConfig/Background/ST07a",
		"TextureConfig/Background/B13a",
		"TextureConfig/Background/ST01a"
	},
	voices = {
		"story_v_out_111011.awb"
	}
}
