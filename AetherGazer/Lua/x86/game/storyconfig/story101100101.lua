return {
	Play110011001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 110011001
		arg_1_1.duration_ = 11.42

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play110011002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				arg_1_1.fswbg_:SetActive(true)
				arg_1_1.dialog_:SetActive(false)

				arg_1_1.fswtw_.percent = 0

				local var_4_1 = arg_1_1:GetWordFromCfg(110011001)
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

			local var_4_4 = 49
			local var_4_5 = 3.26666666666667
			local var_4_6 = arg_1_1:GetWordFromCfg(110011001)
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

			local var_4_11 = 3.26666666666667
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
			local var_4_15 = 11.418
			local var_4_16 = manager.audio:GetVoiceLength("story_v_out_110011", "110011001", "story_v_out_110011.awb") / 1000

			if var_4_16 > 0 and var_4_15 < var_4_16 and var_4_16 + var_4_14 > arg_1_1.duration_ then
				local var_4_17 = var_4_16

				arg_1_1.duration_ = var_4_16 + var_4_14
			end

			if var_4_14 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				local var_4_18 = "play"
				local var_4_19 = "voice"

				arg_1_1:AudioAction(var_4_18, var_4_19, "story_v_out_110011", "110011001", "story_v_out_110011.awb")
			end

			local var_4_20 = 0
			local var_4_21 = 0.6

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

			local var_4_26 = 0.738461699336767
			local var_4_27 = 1

			if var_4_26 < arg_1_1.time_ and arg_1_1.time_ <= var_4_26 + arg_4_0 then
				local var_4_28 = "play"
				local var_4_29 = "music"

				arg_1_1:AudioAction(var_4_28, var_4_29, "bgm_activity_1_0_1_osiris_ui", "bgm_activity_1_0_1_osiris_ui", "bgm_activity_1_0_1_osiris_ui.awb")

				local var_4_30 = ""
				local var_4_31 = manager.audio:GetAudioName("bgm_activity_1_0_1_osiris_ui", "bgm_activity_1_0_1_osiris_ui")

				if var_4_31 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_31 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_31

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_31
						arg_1_1.bgmTxt2_.text = var_4_31
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
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play110011002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 110011002
		arg_7_1.duration_ = 11.42

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play110011003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			local var_10_0 = 0

			if var_10_0 < arg_7_1.time_ and arg_7_1.time_ <= var_10_0 + arg_10_0 then
				arg_7_1.var_.oldValueTypewriter = arg_7_1.fswtw_.percent

				SetActive(arg_7_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_7_1:ShowNextGo(false)
			end

			local var_10_1 = 30
			local var_10_2 = 2.06666666666667
			local var_10_3 = arg_7_1:GetWordFromCfg(110011001)
			local var_10_4 = arg_7_1:FormatText(var_10_3.content)
			local var_10_5, var_10_6 = arg_7_1:GetPercentByPara(var_10_4, 2)

			if var_10_0 < arg_7_1.time_ and arg_7_1.time_ <= var_10_0 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0

				local var_10_7 = var_10_1 <= 0 and var_10_2 or var_10_2 * ((var_10_6 - arg_7_1.typewritterCharCountI18N) / var_10_1)

				if var_10_7 > 0 and var_10_2 < var_10_7 then
					arg_7_1.talkMaxDuration = var_10_7

					if var_10_7 + var_10_0 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_7 + var_10_0
					end
				end
			end

			local var_10_8 = 2.06666666666667
			local var_10_9 = math.max(var_10_8, arg_7_1.talkMaxDuration)

			if var_10_0 <= arg_7_1.time_ and arg_7_1.time_ < var_10_0 + var_10_9 then
				local var_10_10 = (arg_7_1.time_ - var_10_0) / var_10_9

				arg_7_1.fswtw_.percent = Mathf.Lerp(arg_7_1.var_.oldValueTypewriter, var_10_5, var_10_10)
				arg_7_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_7_1.fswtw_:SetDirty()
			end

			if arg_7_1.time_ >= var_10_0 + var_10_9 and arg_7_1.time_ < var_10_0 + var_10_9 + arg_10_0 then
				arg_7_1.fswtw_.percent = var_10_5

				arg_7_1.fswtw_:SetDirty()
				arg_7_1:ShowNextGo(true)

				arg_7_1.typewritterCharCountI18N = var_10_6
			end

			local var_10_11 = 0
			local var_10_12 = 11.418
			local var_10_13 = manager.audio:GetVoiceLength("story_v_out_110011", "110011002", "story_v_out_110011.awb") / 1000

			if var_10_13 > 0 and var_10_12 < var_10_13 and var_10_13 + var_10_11 > arg_7_1.duration_ then
				local var_10_14 = var_10_13

				arg_7_1.duration_ = var_10_13 + var_10_11
			end

			if var_10_11 < arg_7_1.time_ and arg_7_1.time_ <= var_10_11 + arg_10_0 then
				local var_10_15 = "play"
				local var_10_16 = "voice"

				arg_7_1:AudioAction(var_10_15, var_10_16, "story_v_out_110011", "110011002", "story_v_out_110011.awb")
			end
		end

		arg_7_1.nodeConfigList_ = {}

		arg_7_1:InitPlayNodeList()
	end,
	Play110011003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 110011003
		arg_11_1.duration_ = 10.5

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play110011004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			local var_14_0 = 0

			if var_14_0 < arg_11_1.time_ and arg_11_1.time_ <= var_14_0 + arg_14_0 then
				arg_11_1.var_.oldValueTypewriter = arg_11_1.fswtw_.percent

				SetActive(arg_11_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_11_1:ShowNextGo(false)
			end

			local var_14_1 = 40
			local var_14_2 = 2.66666666666667
			local var_14_3 = arg_11_1:GetWordFromCfg(110011001)
			local var_14_4 = arg_11_1:FormatText(var_14_3.content)
			local var_14_5, var_14_6 = arg_11_1:GetPercentByPara(var_14_4, 3)

			if var_14_0 < arg_11_1.time_ and arg_11_1.time_ <= var_14_0 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0

				local var_14_7 = var_14_1 <= 0 and var_14_2 or var_14_2 * ((var_14_6 - arg_11_1.typewritterCharCountI18N) / var_14_1)

				if var_14_7 > 0 and var_14_2 < var_14_7 then
					arg_11_1.talkMaxDuration = var_14_7

					if var_14_7 + var_14_0 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_7 + var_14_0
					end
				end
			end

			local var_14_8 = 2.66666666666667
			local var_14_9 = math.max(var_14_8, arg_11_1.talkMaxDuration)

			if var_14_0 <= arg_11_1.time_ and arg_11_1.time_ < var_14_0 + var_14_9 then
				local var_14_10 = (arg_11_1.time_ - var_14_0) / var_14_9

				arg_11_1.fswtw_.percent = Mathf.Lerp(arg_11_1.var_.oldValueTypewriter, var_14_5, var_14_10)
				arg_11_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_11_1.fswtw_:SetDirty()
			end

			if arg_11_1.time_ >= var_14_0 + var_14_9 and arg_11_1.time_ < var_14_0 + var_14_9 + arg_14_0 then
				arg_11_1.fswtw_.percent = var_14_5

				arg_11_1.fswtw_:SetDirty()
				arg_11_1:ShowNextGo(true)

				arg_11_1.typewritterCharCountI18N = var_14_6
			end

			local var_14_11 = 0
			local var_14_12 = 10.504
			local var_14_13 = manager.audio:GetVoiceLength("story_v_out_110011", "110011003", "story_v_out_110011.awb") / 1000

			if var_14_13 > 0 and var_14_12 < var_14_13 and var_14_13 + var_14_11 > arg_11_1.duration_ then
				local var_14_14 = var_14_13

				arg_11_1.duration_ = var_14_13 + var_14_11
			end

			if var_14_11 < arg_11_1.time_ and arg_11_1.time_ <= var_14_11 + arg_14_0 then
				local var_14_15 = "play"
				local var_14_16 = "voice"

				arg_11_1:AudioAction(var_14_15, var_14_16, "story_v_out_110011", "110011003", "story_v_out_110011.awb")
			end
		end

		arg_11_1.nodeConfigList_ = {}

		arg_11_1:InitPlayNodeList()
	end,
	Play110011004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 110011004
		arg_15_1.duration_ = 7.06

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play110011005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = 0

			if var_18_0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_0 + arg_18_0 then
				arg_15_1.var_.oldValueTypewriter = arg_15_1.fswtw_.percent

				SetActive(arg_15_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_15_1:ShowNextGo(false)
			end

			local var_18_1 = 27
			local var_18_2 = 1.8
			local var_18_3 = arg_15_1:GetWordFromCfg(110011001)
			local var_18_4 = arg_15_1:FormatText(var_18_3.content)
			local var_18_5, var_18_6 = arg_15_1:GetPercentByPara(var_18_4, 4)

			if var_18_0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_0 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0

				local var_18_7 = var_18_1 <= 0 and var_18_2 or var_18_2 * ((var_18_6 - arg_15_1.typewritterCharCountI18N) / var_18_1)

				if var_18_7 > 0 and var_18_2 < var_18_7 then
					arg_15_1.talkMaxDuration = var_18_7

					if var_18_7 + var_18_0 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_7 + var_18_0
					end
				end
			end

			local var_18_8 = 1.8
			local var_18_9 = math.max(var_18_8, arg_15_1.talkMaxDuration)

			if var_18_0 <= arg_15_1.time_ and arg_15_1.time_ < var_18_0 + var_18_9 then
				local var_18_10 = (arg_15_1.time_ - var_18_0) / var_18_9

				arg_15_1.fswtw_.percent = Mathf.Lerp(arg_15_1.var_.oldValueTypewriter, var_18_5, var_18_10)
				arg_15_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_15_1.fswtw_:SetDirty()
			end

			if arg_15_1.time_ >= var_18_0 + var_18_9 and arg_15_1.time_ < var_18_0 + var_18_9 + arg_18_0 then
				arg_15_1.fswtw_.percent = var_18_5

				arg_15_1.fswtw_:SetDirty()
				arg_15_1:ShowNextGo(true)

				arg_15_1.typewritterCharCountI18N = var_18_6
			end

			local var_18_11 = 0
			local var_18_12 = 7.061
			local var_18_13 = manager.audio:GetVoiceLength("story_v_out_110011", "110011004", "story_v_out_110011.awb") / 1000

			if var_18_13 > 0 and var_18_12 < var_18_13 and var_18_13 + var_18_11 > arg_15_1.duration_ then
				local var_18_14 = var_18_13

				arg_15_1.duration_ = var_18_13 + var_18_11
			end

			if var_18_11 < arg_15_1.time_ and arg_15_1.time_ <= var_18_11 + arg_18_0 then
				local var_18_15 = "play"
				local var_18_16 = "voice"

				arg_15_1:AudioAction(var_18_15, var_18_16, "story_v_out_110011", "110011004", "story_v_out_110011.awb")
			end
		end

		arg_15_1.nodeConfigList_ = {}

		arg_15_1:InitPlayNodeList()
	end,
	Play110011005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 110011005
		arg_19_1.duration_ = 11.7

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play110011006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = 0

			if var_22_0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_0 + arg_22_0 then
				arg_19_1.var_.oldValueTypewriter = arg_19_1.fswtw_.percent

				SetActive(arg_19_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_19_1:ShowNextGo(false)
			end

			local var_22_1 = 42
			local var_22_2 = 2.8
			local var_22_3 = arg_19_1:GetWordFromCfg(110011001)
			local var_22_4 = arg_19_1:FormatText(var_22_3.content)
			local var_22_5, var_22_6 = arg_19_1:GetPercentByPara(var_22_4, 5)

			if var_22_0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_0 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0

				local var_22_7 = var_22_1 <= 0 and var_22_2 or var_22_2 * ((var_22_6 - arg_19_1.typewritterCharCountI18N) / var_22_1)

				if var_22_7 > 0 and var_22_2 < var_22_7 then
					arg_19_1.talkMaxDuration = var_22_7

					if var_22_7 + var_22_0 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_7 + var_22_0
					end
				end
			end

			local var_22_8 = 2.8
			local var_22_9 = math.max(var_22_8, arg_19_1.talkMaxDuration)

			if var_22_0 <= arg_19_1.time_ and arg_19_1.time_ < var_22_0 + var_22_9 then
				local var_22_10 = (arg_19_1.time_ - var_22_0) / var_22_9

				arg_19_1.fswtw_.percent = Mathf.Lerp(arg_19_1.var_.oldValueTypewriter, var_22_5, var_22_10)
				arg_19_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_19_1.fswtw_:SetDirty()
			end

			if arg_19_1.time_ >= var_22_0 + var_22_9 and arg_19_1.time_ < var_22_0 + var_22_9 + arg_22_0 then
				arg_19_1.fswtw_.percent = var_22_5

				arg_19_1.fswtw_:SetDirty()
				arg_19_1:ShowNextGo(true)

				arg_19_1.typewritterCharCountI18N = var_22_6
			end

			local var_22_11 = 0
			local var_22_12 = 11.696
			local var_22_13 = manager.audio:GetVoiceLength("story_v_out_110011", "110011005", "story_v_out_110011.awb") / 1000

			if var_22_13 > 0 and var_22_12 < var_22_13 and var_22_13 + var_22_11 > arg_19_1.duration_ then
				local var_22_14 = var_22_13

				arg_19_1.duration_ = var_22_13 + var_22_11
			end

			if var_22_11 < arg_19_1.time_ and arg_19_1.time_ <= var_22_11 + arg_22_0 then
				local var_22_15 = "play"
				local var_22_16 = "voice"

				arg_19_1:AudioAction(var_22_15, var_22_16, "story_v_out_110011", "110011005", "story_v_out_110011.awb")
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play110011006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 110011006
		arg_23_1.duration_ = 5.66

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play110011007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = 0

			if var_26_0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_0 + arg_26_0 then
				arg_23_1.fswbg_:SetActive(true)
				arg_23_1.dialog_:SetActive(false)

				arg_23_1.fswtw_.percent = 0

				local var_26_1 = arg_23_1:GetWordFromCfg(110011006)
				local var_26_2 = arg_23_1:FormatText(var_26_1.content)

				arg_23_1.fswt_.text = var_26_2

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.fswt_)

				arg_23_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_23_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_23_1.fswtw_:SetDirty()

				arg_23_1.typewritterCharCountI18N = 0

				SetActive(arg_23_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_23_1:ShowNextGo(false)
			end

			local var_26_3 = 0.0166666666666667

			if var_26_3 < arg_23_1.time_ and arg_23_1.time_ <= var_26_3 + arg_26_0 then
				arg_23_1.var_.oldValueTypewriter = arg_23_1.fswtw_.percent

				SetActive(arg_23_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_23_1:ShowNextGo(false)
			end

			local var_26_4 = 24
			local var_26_5 = 1.6
			local var_26_6 = arg_23_1:GetWordFromCfg(110011006)
			local var_26_7 = arg_23_1:FormatText(var_26_6.content)
			local var_26_8, var_26_9 = arg_23_1:GetPercentByPara(var_26_7, 1)

			if var_26_3 < arg_23_1.time_ and arg_23_1.time_ <= var_26_3 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0

				local var_26_10 = var_26_4 <= 0 and var_26_5 or var_26_5 * ((var_26_9 - arg_23_1.typewritterCharCountI18N) / var_26_4)

				if var_26_10 > 0 and var_26_5 < var_26_10 then
					arg_23_1.talkMaxDuration = var_26_10

					if var_26_10 + var_26_3 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_10 + var_26_3
					end
				end
			end

			local var_26_11 = 1.6
			local var_26_12 = math.max(var_26_11, arg_23_1.talkMaxDuration)

			if var_26_3 <= arg_23_1.time_ and arg_23_1.time_ < var_26_3 + var_26_12 then
				local var_26_13 = (arg_23_1.time_ - var_26_3) / var_26_12

				arg_23_1.fswtw_.percent = Mathf.Lerp(arg_23_1.var_.oldValueTypewriter, var_26_8, var_26_13)
				arg_23_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_23_1.fswtw_:SetDirty()
			end

			if arg_23_1.time_ >= var_26_3 + var_26_12 and arg_23_1.time_ < var_26_3 + var_26_12 + arg_26_0 then
				arg_23_1.fswtw_.percent = var_26_8

				arg_23_1.fswtw_:SetDirty()
				arg_23_1:ShowNextGo(true)

				arg_23_1.typewritterCharCountI18N = var_26_9
			end

			local var_26_14 = 0
			local var_26_15 = 5.661
			local var_26_16 = manager.audio:GetVoiceLength("story_v_out_110011", "110011006", "story_v_out_110011.awb") / 1000

			if var_26_16 > 0 and var_26_15 < var_26_16 and var_26_16 + var_26_14 > arg_23_1.duration_ then
				local var_26_17 = var_26_16

				arg_23_1.duration_ = var_26_16 + var_26_14
			end

			if var_26_14 < arg_23_1.time_ and arg_23_1.time_ <= var_26_14 + arg_26_0 then
				local var_26_18 = "play"
				local var_26_19 = "voice"

				arg_23_1:AudioAction(var_26_18, var_26_19, "story_v_out_110011", "110011006", "story_v_out_110011.awb")
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play110011007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 110011007
		arg_27_1.duration_ = 4.08

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play110011008(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = 0

			if var_30_0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_0 + arg_30_0 then
				arg_27_1.var_.oldValueTypewriter = arg_27_1.fswtw_.percent

				SetActive(arg_27_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_27_1:ShowNextGo(false)
			end

			local var_30_1 = 20
			local var_30_2 = 1.33333333333333
			local var_30_3 = arg_27_1:GetWordFromCfg(110011006)
			local var_30_4 = arg_27_1:FormatText(var_30_3.content)
			local var_30_5, var_30_6 = arg_27_1:GetPercentByPara(var_30_4, 2)

			if var_30_0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_0 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0

				local var_30_7 = var_30_1 <= 0 and var_30_2 or var_30_2 * ((var_30_6 - arg_27_1.typewritterCharCountI18N) / var_30_1)

				if var_30_7 > 0 and var_30_2 < var_30_7 then
					arg_27_1.talkMaxDuration = var_30_7

					if var_30_7 + var_30_0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_7 + var_30_0
					end
				end
			end

			local var_30_8 = 1.33333333333333
			local var_30_9 = math.max(var_30_8, arg_27_1.talkMaxDuration)

			if var_30_0 <= arg_27_1.time_ and arg_27_1.time_ < var_30_0 + var_30_9 then
				local var_30_10 = (arg_27_1.time_ - var_30_0) / var_30_9

				arg_27_1.fswtw_.percent = Mathf.Lerp(arg_27_1.var_.oldValueTypewriter, var_30_5, var_30_10)
				arg_27_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_27_1.fswtw_:SetDirty()
			end

			if arg_27_1.time_ >= var_30_0 + var_30_9 and arg_27_1.time_ < var_30_0 + var_30_9 + arg_30_0 then
				arg_27_1.fswtw_.percent = var_30_5

				arg_27_1.fswtw_:SetDirty()
				arg_27_1:ShowNextGo(true)

				arg_27_1.typewritterCharCountI18N = var_30_6
			end

			local var_30_11 = 0
			local var_30_12 = 4.082
			local var_30_13 = manager.audio:GetVoiceLength("story_v_out_110011", "110011007", "story_v_out_110011.awb") / 1000

			if var_30_13 > 0 and var_30_12 < var_30_13 and var_30_13 + var_30_11 > arg_27_1.duration_ then
				local var_30_14 = var_30_13

				arg_27_1.duration_ = var_30_13 + var_30_11
			end

			if var_30_11 < arg_27_1.time_ and arg_27_1.time_ <= var_30_11 + arg_30_0 then
				local var_30_15 = "play"
				local var_30_16 = "voice"

				arg_27_1:AudioAction(var_30_15, var_30_16, "story_v_out_110011", "110011007", "story_v_out_110011.awb")
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play110011008 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 110011008
		arg_31_1.duration_ = 15.9

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play110011009(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = 0

			if var_34_0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_0 + arg_34_0 then
				arg_31_1.var_.oldValueTypewriter = arg_31_1.fswtw_.percent

				SetActive(arg_31_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_31_1:ShowNextGo(false)
			end

			local var_34_1 = 62
			local var_34_2 = 4.13333333333333
			local var_34_3 = arg_31_1:GetWordFromCfg(110011006)
			local var_34_4 = arg_31_1:FormatText(var_34_3.content)
			local var_34_5, var_34_6 = arg_31_1:GetPercentByPara(var_34_4, 3)

			if var_34_0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_0 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0

				local var_34_7 = var_34_1 <= 0 and var_34_2 or var_34_2 * ((var_34_6 - arg_31_1.typewritterCharCountI18N) / var_34_1)

				if var_34_7 > 0 and var_34_2 < var_34_7 then
					arg_31_1.talkMaxDuration = var_34_7

					if var_34_7 + var_34_0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_7 + var_34_0
					end
				end
			end

			local var_34_8 = 4.13333333333333
			local var_34_9 = math.max(var_34_8, arg_31_1.talkMaxDuration)

			if var_34_0 <= arg_31_1.time_ and arg_31_1.time_ < var_34_0 + var_34_9 then
				local var_34_10 = (arg_31_1.time_ - var_34_0) / var_34_9

				arg_31_1.fswtw_.percent = Mathf.Lerp(arg_31_1.var_.oldValueTypewriter, var_34_5, var_34_10)
				arg_31_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_31_1.fswtw_:SetDirty()
			end

			if arg_31_1.time_ >= var_34_0 + var_34_9 and arg_31_1.time_ < var_34_0 + var_34_9 + arg_34_0 then
				arg_31_1.fswtw_.percent = var_34_5

				arg_31_1.fswtw_:SetDirty()
				arg_31_1:ShowNextGo(true)

				arg_31_1.typewritterCharCountI18N = var_34_6
			end

			local var_34_11 = 0
			local var_34_12 = 15.896
			local var_34_13 = manager.audio:GetVoiceLength("story_v_out_110011", "110011008", "story_v_out_110011.awb") / 1000

			if var_34_13 > 0 and var_34_12 < var_34_13 and var_34_13 + var_34_11 > arg_31_1.duration_ then
				local var_34_14 = var_34_13

				arg_31_1.duration_ = var_34_13 + var_34_11
			end

			if var_34_11 < arg_31_1.time_ and arg_31_1.time_ <= var_34_11 + arg_34_0 then
				local var_34_15 = "play"
				local var_34_16 = "voice"

				arg_31_1:AudioAction(var_34_15, var_34_16, "story_v_out_110011", "110011008", "story_v_out_110011.awb")
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play110011009 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 110011009
		arg_35_1.duration_ = 13.39

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play110011010(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 0

			if var_38_0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_0 + arg_38_0 then
				arg_35_1.var_.oldValueTypewriter = arg_35_1.fswtw_.percent

				SetActive(arg_35_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_35_1:ShowNextGo(false)
			end

			local var_38_1 = 58
			local var_38_2 = 3.86666666666667
			local var_38_3 = arg_35_1:GetWordFromCfg(110011006)
			local var_38_4 = arg_35_1:FormatText(var_38_3.content)
			local var_38_5, var_38_6 = arg_35_1:GetPercentByPara(var_38_4, 4)

			if var_38_0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_0 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0

				local var_38_7 = var_38_1 <= 0 and var_38_2 or var_38_2 * ((var_38_6 - arg_35_1.typewritterCharCountI18N) / var_38_1)

				if var_38_7 > 0 and var_38_2 < var_38_7 then
					arg_35_1.talkMaxDuration = var_38_7

					if var_38_7 + var_38_0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_7 + var_38_0
					end
				end
			end

			local var_38_8 = 3.86666666666667
			local var_38_9 = math.max(var_38_8, arg_35_1.talkMaxDuration)

			if var_38_0 <= arg_35_1.time_ and arg_35_1.time_ < var_38_0 + var_38_9 then
				local var_38_10 = (arg_35_1.time_ - var_38_0) / var_38_9

				arg_35_1.fswtw_.percent = Mathf.Lerp(arg_35_1.var_.oldValueTypewriter, var_38_5, var_38_10)
				arg_35_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_35_1.fswtw_:SetDirty()
			end

			if arg_35_1.time_ >= var_38_0 + var_38_9 and arg_35_1.time_ < var_38_0 + var_38_9 + arg_38_0 then
				arg_35_1.fswtw_.percent = var_38_5

				arg_35_1.fswtw_:SetDirty()
				arg_35_1:ShowNextGo(true)

				arg_35_1.typewritterCharCountI18N = var_38_6
			end

			local var_38_11 = 0
			local var_38_12 = 13.386
			local var_38_13 = manager.audio:GetVoiceLength("story_v_out_110011", "110011009", "story_v_out_110011.awb") / 1000

			if var_38_13 > 0 and var_38_12 < var_38_13 and var_38_13 + var_38_11 > arg_35_1.duration_ then
				local var_38_14 = var_38_13

				arg_35_1.duration_ = var_38_13 + var_38_11
			end

			if var_38_11 < arg_35_1.time_ and arg_35_1.time_ <= var_38_11 + arg_38_0 then
				local var_38_15 = "play"
				local var_38_16 = "voice"

				arg_35_1:AudioAction(var_38_15, var_38_16, "story_v_out_110011", "110011009", "story_v_out_110011.awb")
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play110011010 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 110011010
		arg_39_1.duration_ = 11.5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play110011011(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0

			if var_42_0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_0 + arg_42_0 then
				arg_39_1.var_.oldValueTypewriter = arg_39_1.fswtw_.percent

				SetActive(arg_39_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_39_1:ShowNextGo(false)
			end

			local var_42_1 = 39
			local var_42_2 = 2.66666666666667
			local var_42_3 = arg_39_1:GetWordFromCfg(110011006)
			local var_42_4 = arg_39_1:FormatText(var_42_3.content)
			local var_42_5, var_42_6 = arg_39_1:GetPercentByPara(var_42_4, 5)

			if var_42_0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0

				local var_42_7 = var_42_1 <= 0 and var_42_2 or var_42_2 * ((var_42_6 - arg_39_1.typewritterCharCountI18N) / var_42_1)

				if var_42_7 > 0 and var_42_2 < var_42_7 then
					arg_39_1.talkMaxDuration = var_42_7

					if var_42_7 + var_42_0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_7 + var_42_0
					end
				end
			end

			local var_42_8 = 2.66666666666667
			local var_42_9 = math.max(var_42_8, arg_39_1.talkMaxDuration)

			if var_42_0 <= arg_39_1.time_ and arg_39_1.time_ < var_42_0 + var_42_9 then
				local var_42_10 = (arg_39_1.time_ - var_42_0) / var_42_9

				arg_39_1.fswtw_.percent = Mathf.Lerp(arg_39_1.var_.oldValueTypewriter, var_42_5, var_42_10)
				arg_39_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_39_1.fswtw_:SetDirty()
			end

			if arg_39_1.time_ >= var_42_0 + var_42_9 and arg_39_1.time_ < var_42_0 + var_42_9 + arg_42_0 then
				arg_39_1.fswtw_.percent = var_42_5

				arg_39_1.fswtw_:SetDirty()
				arg_39_1:ShowNextGo(true)

				arg_39_1.typewritterCharCountI18N = var_42_6
			end

			local var_42_11 = 0
			local var_42_12 = 11.501
			local var_42_13 = manager.audio:GetVoiceLength("story_v_out_110011", "110011010", "story_v_out_110011.awb") / 1000

			if var_42_13 > 0 and var_42_12 < var_42_13 and var_42_13 + var_42_11 > arg_39_1.duration_ then
				local var_42_14 = var_42_13

				arg_39_1.duration_ = var_42_13 + var_42_11
			end

			if var_42_11 < arg_39_1.time_ and arg_39_1.time_ <= var_42_11 + arg_42_0 then
				local var_42_15 = "play"
				local var_42_16 = "voice"

				arg_39_1:AudioAction(var_42_15, var_42_16, "story_v_out_110011", "110011010", "story_v_out_110011.awb")
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play110011011 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 110011011
		arg_43_1.duration_ = 5.22

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play110011012(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 0

			if var_46_0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_0 + arg_46_0 then
				arg_43_1.fswbg_:SetActive(true)
				arg_43_1.dialog_:SetActive(false)

				arg_43_1.fswtw_.percent = 0

				local var_46_1 = arg_43_1:GetWordFromCfg(110011011)
				local var_46_2 = arg_43_1:FormatText(var_46_1.content)

				arg_43_1.fswt_.text = var_46_2

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.fswt_)

				arg_43_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_43_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_43_1.fswtw_:SetDirty()

				arg_43_1.typewritterCharCountI18N = 0

				SetActive(arg_43_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_43_1:ShowNextGo(false)
			end

			local var_46_3 = 0.0166666666666667

			if var_46_3 < arg_43_1.time_ and arg_43_1.time_ <= var_46_3 + arg_46_0 then
				arg_43_1.var_.oldValueTypewriter = arg_43_1.fswtw_.percent

				SetActive(arg_43_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_43_1:ShowNextGo(false)
			end

			local var_46_4 = 28
			local var_46_5 = 1.86666666666667
			local var_46_6 = arg_43_1:GetWordFromCfg(110011011)
			local var_46_7 = arg_43_1:FormatText(var_46_6.content)
			local var_46_8, var_46_9 = arg_43_1:GetPercentByPara(var_46_7, 1)

			if var_46_3 < arg_43_1.time_ and arg_43_1.time_ <= var_46_3 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0

				local var_46_10 = var_46_4 <= 0 and var_46_5 or var_46_5 * ((var_46_9 - arg_43_1.typewritterCharCountI18N) / var_46_4)

				if var_46_10 > 0 and var_46_5 < var_46_10 then
					arg_43_1.talkMaxDuration = var_46_10

					if var_46_10 + var_46_3 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_10 + var_46_3
					end
				end
			end

			local var_46_11 = 1.86666666666667
			local var_46_12 = math.max(var_46_11, arg_43_1.talkMaxDuration)

			if var_46_3 <= arg_43_1.time_ and arg_43_1.time_ < var_46_3 + var_46_12 then
				local var_46_13 = (arg_43_1.time_ - var_46_3) / var_46_12

				arg_43_1.fswtw_.percent = Mathf.Lerp(arg_43_1.var_.oldValueTypewriter, var_46_8, var_46_13)
				arg_43_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_43_1.fswtw_:SetDirty()
			end

			if arg_43_1.time_ >= var_46_3 + var_46_12 and arg_43_1.time_ < var_46_3 + var_46_12 + arg_46_0 then
				arg_43_1.fswtw_.percent = var_46_8

				arg_43_1.fswtw_:SetDirty()
				arg_43_1:ShowNextGo(true)

				arg_43_1.typewritterCharCountI18N = var_46_9
			end

			local var_46_14 = 0
			local var_46_15 = 5.216
			local var_46_16 = manager.audio:GetVoiceLength("story_v_out_110011", "110011011", "story_v_out_110011.awb") / 1000

			if var_46_16 > 0 and var_46_15 < var_46_16 and var_46_16 + var_46_14 > arg_43_1.duration_ then
				local var_46_17 = var_46_16

				arg_43_1.duration_ = var_46_16 + var_46_14
			end

			if var_46_14 < arg_43_1.time_ and arg_43_1.time_ <= var_46_14 + arg_46_0 then
				local var_46_18 = "play"
				local var_46_19 = "voice"

				arg_43_1:AudioAction(var_46_18, var_46_19, "story_v_out_110011", "110011011", "story_v_out_110011.awb")
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play110011012 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 110011012
		arg_47_1.duration_ = 7.65

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play110011013(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = 0

			if var_50_0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_0 + arg_50_0 then
				arg_47_1.var_.oldValueTypewriter = arg_47_1.fswtw_.percent

				SetActive(arg_47_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_47_1:ShowNextGo(false)
			end

			local var_50_1 = 36
			local var_50_2 = 2.4
			local var_50_3 = arg_47_1:GetWordFromCfg(110011011)
			local var_50_4 = arg_47_1:FormatText(var_50_3.content)
			local var_50_5, var_50_6 = arg_47_1:GetPercentByPara(var_50_4, 2)

			if var_50_0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_0 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0

				local var_50_7 = var_50_1 <= 0 and var_50_2 or var_50_2 * ((var_50_6 - arg_47_1.typewritterCharCountI18N) / var_50_1)

				if var_50_7 > 0 and var_50_2 < var_50_7 then
					arg_47_1.talkMaxDuration = var_50_7

					if var_50_7 + var_50_0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_7 + var_50_0
					end
				end
			end

			local var_50_8 = 2.4
			local var_50_9 = math.max(var_50_8, arg_47_1.talkMaxDuration)

			if var_50_0 <= arg_47_1.time_ and arg_47_1.time_ < var_50_0 + var_50_9 then
				local var_50_10 = (arg_47_1.time_ - var_50_0) / var_50_9

				arg_47_1.fswtw_.percent = Mathf.Lerp(arg_47_1.var_.oldValueTypewriter, var_50_5, var_50_10)
				arg_47_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_47_1.fswtw_:SetDirty()
			end

			if arg_47_1.time_ >= var_50_0 + var_50_9 and arg_47_1.time_ < var_50_0 + var_50_9 + arg_50_0 then
				arg_47_1.fswtw_.percent = var_50_5

				arg_47_1.fswtw_:SetDirty()
				arg_47_1:ShowNextGo(true)

				arg_47_1.typewritterCharCountI18N = var_50_6
			end

			local var_50_11 = 0
			local var_50_12 = 7.648
			local var_50_13 = manager.audio:GetVoiceLength("story_v_out_110011", "110011012", "story_v_out_110011.awb") / 1000

			if var_50_13 > 0 and var_50_12 < var_50_13 and var_50_13 + var_50_11 > arg_47_1.duration_ then
				local var_50_14 = var_50_13

				arg_47_1.duration_ = var_50_13 + var_50_11
			end

			if var_50_11 < arg_47_1.time_ and arg_47_1.time_ <= var_50_11 + arg_50_0 then
				local var_50_15 = "play"
				local var_50_16 = "voice"

				arg_47_1:AudioAction(var_50_15, var_50_16, "story_v_out_110011", "110011012", "story_v_out_110011.awb")
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play110011013 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 110011013
		arg_51_1.duration_ = 5.31

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play110011014(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 0

			if var_54_0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_0 + arg_54_0 then
				arg_51_1.var_.oldValueTypewriter = arg_51_1.fswtw_.percent

				SetActive(arg_51_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_51_1:ShowNextGo(false)
			end

			local var_54_1 = 30
			local var_54_2 = 2
			local var_54_3 = arg_51_1:GetWordFromCfg(110011011)
			local var_54_4 = arg_51_1:FormatText(var_54_3.content)
			local var_54_5, var_54_6 = arg_51_1:GetPercentByPara(var_54_4, 3)

			if var_54_0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0

				local var_54_7 = var_54_1 <= 0 and var_54_2 or var_54_2 * ((var_54_6 - arg_51_1.typewritterCharCountI18N) / var_54_1)

				if var_54_7 > 0 and var_54_2 < var_54_7 then
					arg_51_1.talkMaxDuration = var_54_7

					if var_54_7 + var_54_0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_7 + var_54_0
					end
				end
			end

			local var_54_8 = 2
			local var_54_9 = math.max(var_54_8, arg_51_1.talkMaxDuration)

			if var_54_0 <= arg_51_1.time_ and arg_51_1.time_ < var_54_0 + var_54_9 then
				local var_54_10 = (arg_51_1.time_ - var_54_0) / var_54_9

				arg_51_1.fswtw_.percent = Mathf.Lerp(arg_51_1.var_.oldValueTypewriter, var_54_5, var_54_10)
				arg_51_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_51_1.fswtw_:SetDirty()
			end

			if arg_51_1.time_ >= var_54_0 + var_54_9 and arg_51_1.time_ < var_54_0 + var_54_9 + arg_54_0 then
				arg_51_1.fswtw_.percent = var_54_5

				arg_51_1.fswtw_:SetDirty()
				arg_51_1:ShowNextGo(true)

				arg_51_1.typewritterCharCountI18N = var_54_6
			end

			local var_54_11 = 0
			local var_54_12 = 5.307
			local var_54_13 = manager.audio:GetVoiceLength("story_v_out_110011", "110011013", "story_v_out_110011.awb") / 1000

			if var_54_13 > 0 and var_54_12 < var_54_13 and var_54_13 + var_54_11 > arg_51_1.duration_ then
				local var_54_14 = var_54_13

				arg_51_1.duration_ = var_54_13 + var_54_11
			end

			if var_54_11 < arg_51_1.time_ and arg_51_1.time_ <= var_54_11 + arg_54_0 then
				local var_54_15 = "play"
				local var_54_16 = "voice"

				arg_51_1:AudioAction(var_54_15, var_54_16, "story_v_out_110011", "110011013", "story_v_out_110011.awb")
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play110011014 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 110011014
		arg_55_1.duration_ = 3.32

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play110011015(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0

			if var_58_0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_0 + arg_58_0 then
				arg_55_1.var_.oldValueTypewriter = arg_55_1.fswtw_.percent

				SetActive(arg_55_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_55_1:ShowNextGo(false)
			end

			local var_58_1 = 15
			local var_58_2 = 1
			local var_58_3 = arg_55_1:GetWordFromCfg(110011011)
			local var_58_4 = arg_55_1:FormatText(var_58_3.content)
			local var_58_5, var_58_6 = arg_55_1:GetPercentByPara(var_58_4, 4)

			if var_58_0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0

				local var_58_7 = var_58_1 <= 0 and var_58_2 or var_58_2 * ((var_58_6 - arg_55_1.typewritterCharCountI18N) / var_58_1)

				if var_58_7 > 0 and var_58_2 < var_58_7 then
					arg_55_1.talkMaxDuration = var_58_7

					if var_58_7 + var_58_0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_7 + var_58_0
					end
				end
			end

			local var_58_8 = 1
			local var_58_9 = math.max(var_58_8, arg_55_1.talkMaxDuration)

			if var_58_0 <= arg_55_1.time_ and arg_55_1.time_ < var_58_0 + var_58_9 then
				local var_58_10 = (arg_55_1.time_ - var_58_0) / var_58_9

				arg_55_1.fswtw_.percent = Mathf.Lerp(arg_55_1.var_.oldValueTypewriter, var_58_5, var_58_10)
				arg_55_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_55_1.fswtw_:SetDirty()
			end

			if arg_55_1.time_ >= var_58_0 + var_58_9 and arg_55_1.time_ < var_58_0 + var_58_9 + arg_58_0 then
				arg_55_1.fswtw_.percent = var_58_5

				arg_55_1.fswtw_:SetDirty()
				arg_55_1:ShowNextGo(true)

				arg_55_1.typewritterCharCountI18N = var_58_6
			end

			local var_58_11 = 0
			local var_58_12 = 3.322
			local var_58_13 = manager.audio:GetVoiceLength("story_v_out_110011", "110011014", "story_v_out_110011.awb") / 1000

			if var_58_13 > 0 and var_58_12 < var_58_13 and var_58_13 + var_58_11 > arg_55_1.duration_ then
				local var_58_14 = var_58_13

				arg_55_1.duration_ = var_58_13 + var_58_11
			end

			if var_58_11 < arg_55_1.time_ and arg_55_1.time_ <= var_58_11 + arg_58_0 then
				local var_58_15 = "play"
				local var_58_16 = "voice"

				arg_55_1:AudioAction(var_58_15, var_58_16, "story_v_out_110011", "110011014", "story_v_out_110011.awb")
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play110011015 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 110011015
		arg_59_1.duration_ = 5.48

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play110011016(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0

			if var_62_0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_0 + arg_62_0 then
				arg_59_1.var_.oldValueTypewriter = arg_59_1.fswtw_.percent

				SetActive(arg_59_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_59_1:ShowNextGo(false)
			end

			local var_62_1 = 28
			local var_62_2 = 1.86666666666667
			local var_62_3 = arg_59_1:GetWordFromCfg(110011011)
			local var_62_4 = arg_59_1:FormatText(var_62_3.content)
			local var_62_5, var_62_6 = arg_59_1:GetPercentByPara(var_62_4, 5)

			if var_62_0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0

				local var_62_7 = var_62_1 <= 0 and var_62_2 or var_62_2 * ((var_62_6 - arg_59_1.typewritterCharCountI18N) / var_62_1)

				if var_62_7 > 0 and var_62_2 < var_62_7 then
					arg_59_1.talkMaxDuration = var_62_7

					if var_62_7 + var_62_0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_7 + var_62_0
					end
				end
			end

			local var_62_8 = 1.86666666666667
			local var_62_9 = math.max(var_62_8, arg_59_1.talkMaxDuration)

			if var_62_0 <= arg_59_1.time_ and arg_59_1.time_ < var_62_0 + var_62_9 then
				local var_62_10 = (arg_59_1.time_ - var_62_0) / var_62_9

				arg_59_1.fswtw_.percent = Mathf.Lerp(arg_59_1.var_.oldValueTypewriter, var_62_5, var_62_10)
				arg_59_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_59_1.fswtw_:SetDirty()
			end

			if arg_59_1.time_ >= var_62_0 + var_62_9 and arg_59_1.time_ < var_62_0 + var_62_9 + arg_62_0 then
				arg_59_1.fswtw_.percent = var_62_5

				arg_59_1.fswtw_:SetDirty()
				arg_59_1:ShowNextGo(true)

				arg_59_1.typewritterCharCountI18N = var_62_6
			end

			local var_62_11 = 0
			local var_62_12 = 5.485
			local var_62_13 = manager.audio:GetVoiceLength("story_v_out_110011", "110011015", "story_v_out_110011.awb") / 1000

			if var_62_13 > 0 and var_62_12 < var_62_13 and var_62_13 + var_62_11 > arg_59_1.duration_ then
				local var_62_14 = var_62_13

				arg_59_1.duration_ = var_62_13 + var_62_11
			end

			if var_62_11 < arg_59_1.time_ and arg_59_1.time_ <= var_62_11 + arg_62_0 then
				local var_62_15 = "play"
				local var_62_16 = "voice"

				arg_59_1:AudioAction(var_62_15, var_62_16, "story_v_out_110011", "110011015", "story_v_out_110011.awb")
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play110011016 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 110011016
		arg_63_1.duration_ = 4.34

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
			arg_63_1.auto_ = false
		end

		function arg_63_1.playNext_(arg_65_0)
			arg_63_1.onStoryFinished_()
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0

			if var_66_0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_0 + arg_66_0 then
				arg_63_1.var_.oldValueTypewriter = arg_63_1.fswtw_.percent

				SetActive(arg_63_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_63_1:ShowNextGo(false)
			end

			local var_66_1 = 16
			local var_66_2 = 1.06666666666667
			local var_66_3 = arg_63_1:GetWordFromCfg(110011011)
			local var_66_4 = arg_63_1:FormatText(var_66_3.content)
			local var_66_5, var_66_6 = arg_63_1:GetPercentByPara(var_66_4, 6)

			if var_66_0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0

				local var_66_7 = var_66_1 <= 0 and var_66_2 or var_66_2 * ((var_66_6 - arg_63_1.typewritterCharCountI18N) / var_66_1)

				if var_66_7 > 0 and var_66_2 < var_66_7 then
					arg_63_1.talkMaxDuration = var_66_7

					if var_66_7 + var_66_0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_7 + var_66_0
					end
				end
			end

			local var_66_8 = 1.06666666666667
			local var_66_9 = math.max(var_66_8, arg_63_1.talkMaxDuration)

			if var_66_0 <= arg_63_1.time_ and arg_63_1.time_ < var_66_0 + var_66_9 then
				local var_66_10 = (arg_63_1.time_ - var_66_0) / var_66_9

				arg_63_1.fswtw_.percent = Mathf.Lerp(arg_63_1.var_.oldValueTypewriter, var_66_5, var_66_10)
				arg_63_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_63_1.fswtw_:SetDirty()
			end

			if arg_63_1.time_ >= var_66_0 + var_66_9 and arg_63_1.time_ < var_66_0 + var_66_9 + arg_66_0 then
				arg_63_1.fswtw_.percent = var_66_5

				arg_63_1.fswtw_:SetDirty()
				arg_63_1:ShowNextGo(true)

				arg_63_1.typewritterCharCountI18N = var_66_6
			end

			local var_66_11 = 0
			local var_66_12 = 4.336
			local var_66_13 = manager.audio:GetVoiceLength("story_v_out_110011", "110011016", "story_v_out_110011.awb") / 1000

			if var_66_13 > 0 and var_66_12 < var_66_13 and var_66_13 + var_66_11 > arg_63_1.duration_ then
				local var_66_14 = var_66_13

				arg_63_1.duration_ = var_66_13 + var_66_11
			end

			if var_66_11 < arg_63_1.time_ and arg_63_1.time_ <= var_66_11 + arg_66_0 then
				local var_66_15 = "play"
				local var_66_16 = "voice"

				arg_63_1:AudioAction(var_66_15, var_66_16, "story_v_out_110011", "110011016", "story_v_out_110011.awb")
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	assets = {},
	voices = {
		"story_v_out_110011.awb"
	}
}
