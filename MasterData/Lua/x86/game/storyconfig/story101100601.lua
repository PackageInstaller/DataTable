return {
	Play110061001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 110061001
		arg_1_1.duration_ = 12.62

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play110061002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.fswbg_:SetActive(true)
				arg_1_1.dialog_:SetActive(false)

				arg_1_1.fswtw_.percent = 0
				arg_1_1.fswt_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(110061001).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.fswt_)

				arg_1_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_1_1.fswtw_:SetDirty()

				arg_1_1.typewritterCharCountI18N = 0

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				arg_1_1.var_.oldValueTypewriter = arg_1_1.fswtw_.percent

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_1 = 50
			local var_4_2 = 3.33333333333333
			local var_4_3, var_4_4 = arg_1_1:GetPercentByPara(arg_1_1:FormatText(arg_1_1:GetWordFromCfg(110061001).content), 1)

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

			local var_4_6 = math.max(3.33333333333333, arg_1_1.talkMaxDuration)

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
			local var_4_8 = manager.audio:GetVoiceLength("story_v_out_110061", "110061001", "story_v_out_110061.awb") / 1000

			if var_4_8 > 0 and 12.624 < var_4_8 and var_4_8 + var_4_7 > arg_1_1.duration_ then
				arg_1_1.duration_ = var_4_8 + var_4_7
			end

			if var_4_7 < arg_1_1.time_ and arg_1_1.time_ <= var_4_7 + arg_4_0 then
				arg_1_1:AudioAction("play", "voice", "story_v_out_110061", "110061001", "story_v_out_110061.awb")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_12 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_12 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_12

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_12
						arg_1_1.bgmTxt2_.text = var_4_12
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

			if 0.738461699336767 < arg_1_1.time_ and arg_1_1.time_ <= 0.738461699336767 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_1_0_1_osiris_ui", "bgm_activity_1_0_1_osiris_ui", "bgm_activity_1_0_1_osiris_ui.awb")

				local var_4_15 = manager.audio:GetAudioName("bgm_activity_1_0_1_osiris_ui", "bgm_activity_1_0_1_osiris_ui")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_15 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_15

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_15
						arg_1_1.bgmTxt2_.text = var_4_15
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
	Play110061002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 110061002
		arg_7_1.duration_ = 5.34

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play110061003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1.var_.oldValueTypewriter = arg_7_1.fswtw_.percent

				SetActive(arg_7_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_7_1:ShowNextGo(false)
			end

			local var_10_0 = 27
			local var_10_1 = 1.8
			local var_10_2, var_10_3 = arg_7_1:GetPercentByPara(arg_7_1:FormatText(arg_7_1:GetWordFromCfg(110061001).content), 2)

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0

				local var_10_4 = var_10_0 <= 0 and var_10_1 or var_10_1 * ((var_10_3 - arg_7_1.typewritterCharCountI18N) / var_10_0)

				if (var_10_0 <= 0 and var_10_1 or var_10_1 * ((var_10_3 - arg_7_1.typewritterCharCountI18N) / var_10_0)) > 0 and var_10_1 < var_10_4 then
					arg_7_1.talkMaxDuration = var_10_4

					if var_10_4 + 0 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_4 + 0
					end
				end
			end

			local var_10_5 = math.max(1.8, arg_7_1.talkMaxDuration)

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_5 then
				arg_7_1.fswtw_.percent = Mathf.Lerp(arg_7_1.var_.oldValueTypewriter, var_10_2, (arg_7_1.time_ - 0) / var_10_5)
				arg_7_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_7_1.fswtw_:SetDirty()
			end

			if arg_7_1.time_ >= 0 + var_10_5 and arg_7_1.time_ < 0 + var_10_5 + arg_10_0 then
				arg_7_1.fswtw_.percent = var_10_2

				arg_7_1.fswtw_:SetDirty()
				arg_7_1:ShowNextGo(true)

				arg_7_1.typewritterCharCountI18N = var_10_3
			end

			local var_10_6 = 0
			local var_10_7 = manager.audio:GetVoiceLength("story_v_out_110061", "110061002", "story_v_out_110061.awb") / 1000

			if var_10_7 > 0 and 5.341 < var_10_7 and var_10_7 + var_10_6 > arg_7_1.duration_ then
				arg_7_1.duration_ = var_10_7 + var_10_6
			end

			if var_10_6 < arg_7_1.time_ and arg_7_1.time_ <= var_10_6 + arg_10_0 then
				arg_7_1:AudioAction("play", "voice", "story_v_out_110061", "110061002", "story_v_out_110061.awb")
			end
		end

		arg_7_1.nodeConfigList_ = {}

		arg_7_1:InitPlayNodeList()
	end,
	Play110061003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 110061003
		arg_11_1.duration_ = 4.57

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play110061004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1.var_.oldValueTypewriter = arg_11_1.fswtw_.percent

				SetActive(arg_11_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_11_1:ShowNextGo(false)
			end

			local var_14_0 = 21
			local var_14_1 = 1.4
			local var_14_2, var_14_3 = arg_11_1:GetPercentByPara(arg_11_1:FormatText(arg_11_1:GetWordFromCfg(110061001).content), 3)

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0

				local var_14_4 = var_14_0 <= 0 and var_14_1 or var_14_1 * ((var_14_3 - arg_11_1.typewritterCharCountI18N) / var_14_0)

				if (var_14_0 <= 0 and var_14_1 or var_14_1 * ((var_14_3 - arg_11_1.typewritterCharCountI18N) / var_14_0)) > 0 and var_14_1 < var_14_4 then
					arg_11_1.talkMaxDuration = var_14_4

					if var_14_4 + 0 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_4 + 0
					end
				end
			end

			local var_14_5 = math.max(1.4, arg_11_1.talkMaxDuration)

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_5 then
				arg_11_1.fswtw_.percent = Mathf.Lerp(arg_11_1.var_.oldValueTypewriter, var_14_2, (arg_11_1.time_ - 0) / var_14_5)
				arg_11_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_11_1.fswtw_:SetDirty()
			end

			if arg_11_1.time_ >= 0 + var_14_5 and arg_11_1.time_ < 0 + var_14_5 + arg_14_0 then
				arg_11_1.fswtw_.percent = var_14_2

				arg_11_1.fswtw_:SetDirty()
				arg_11_1:ShowNextGo(true)

				arg_11_1.typewritterCharCountI18N = var_14_3
			end

			local var_14_6 = 0
			local var_14_7 = manager.audio:GetVoiceLength("story_v_out_110061", "110061003", "story_v_out_110061.awb") / 1000

			if var_14_7 > 0 and 4.573 < var_14_7 and var_14_7 + var_14_6 > arg_11_1.duration_ then
				arg_11_1.duration_ = var_14_7 + var_14_6
			end

			if var_14_6 < arg_11_1.time_ and arg_11_1.time_ <= var_14_6 + arg_14_0 then
				arg_11_1:AudioAction("play", "voice", "story_v_out_110061", "110061003", "story_v_out_110061.awb")
			end
		end

		arg_11_1.nodeConfigList_ = {}

		arg_11_1:InitPlayNodeList()
	end,
	Play110061004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 110061004
		arg_15_1.duration_ = 4.69

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play110061005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1.var_.oldValueTypewriter = arg_15_1.fswtw_.percent

				SetActive(arg_15_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_15_1:ShowNextGo(false)
			end

			local var_18_0 = 25
			local var_18_1 = 1.66666666666667
			local var_18_2, var_18_3 = arg_15_1:GetPercentByPara(arg_15_1:FormatText(arg_15_1:GetWordFromCfg(110061001).content), 4)

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0

				local var_18_4 = var_18_0 <= 0 and var_18_1 or var_18_1 * ((var_18_3 - arg_15_1.typewritterCharCountI18N) / var_18_0)

				if (var_18_0 <= 0 and var_18_1 or var_18_1 * ((var_18_3 - arg_15_1.typewritterCharCountI18N) / var_18_0)) > 0 and var_18_1 < var_18_4 then
					arg_15_1.talkMaxDuration = var_18_4

					if var_18_4 + 0 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_4 + 0
					end
				end
			end

			local var_18_5 = math.max(1.66666666666667, arg_15_1.talkMaxDuration)

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_5 then
				arg_15_1.fswtw_.percent = Mathf.Lerp(arg_15_1.var_.oldValueTypewriter, var_18_2, (arg_15_1.time_ - 0) / var_18_5)
				arg_15_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_15_1.fswtw_:SetDirty()
			end

			if arg_15_1.time_ >= 0 + var_18_5 and arg_15_1.time_ < 0 + var_18_5 + arg_18_0 then
				arg_15_1.fswtw_.percent = var_18_2

				arg_15_1.fswtw_:SetDirty()
				arg_15_1:ShowNextGo(true)

				arg_15_1.typewritterCharCountI18N = var_18_3
			end

			local var_18_6 = 0
			local var_18_7 = manager.audio:GetVoiceLength("story_v_out_110061", "110061004", "story_v_out_110061.awb") / 1000

			if var_18_7 > 0 and 4.693 < var_18_7 and var_18_7 + var_18_6 > arg_15_1.duration_ then
				arg_15_1.duration_ = var_18_7 + var_18_6
			end

			if var_18_6 < arg_15_1.time_ and arg_15_1.time_ <= var_18_6 + arg_18_0 then
				arg_15_1:AudioAction("play", "voice", "story_v_out_110061", "110061004", "story_v_out_110061.awb")
			end
		end

		arg_15_1.nodeConfigList_ = {}

		arg_15_1:InitPlayNodeList()
	end,
	Play110061005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 110061005
		arg_19_1.duration_ = 10.87

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play110061006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1.var_.oldValueTypewriter = arg_19_1.fswtw_.percent

				SetActive(arg_19_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_19_1:ShowNextGo(false)
			end

			local var_22_0 = 48
			local var_22_1 = 3.2
			local var_22_2, var_22_3 = arg_19_1:GetPercentByPara(arg_19_1:FormatText(arg_19_1:GetWordFromCfg(110061001).content), 5)

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0

				local var_22_4 = var_22_0 <= 0 and var_22_1 or var_22_1 * ((var_22_3 - arg_19_1.typewritterCharCountI18N) / var_22_0)

				if (var_22_0 <= 0 and var_22_1 or var_22_1 * ((var_22_3 - arg_19_1.typewritterCharCountI18N) / var_22_0)) > 0 and var_22_1 < var_22_4 then
					arg_19_1.talkMaxDuration = var_22_4

					if var_22_4 + 0 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_4 + 0
					end
				end
			end

			local var_22_5 = math.max(3.2, arg_19_1.talkMaxDuration)

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_5 then
				arg_19_1.fswtw_.percent = Mathf.Lerp(arg_19_1.var_.oldValueTypewriter, var_22_2, (arg_19_1.time_ - 0) / var_22_5)
				arg_19_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_19_1.fswtw_:SetDirty()
			end

			if arg_19_1.time_ >= 0 + var_22_5 and arg_19_1.time_ < 0 + var_22_5 + arg_22_0 then
				arg_19_1.fswtw_.percent = var_22_2

				arg_19_1.fswtw_:SetDirty()
				arg_19_1:ShowNextGo(true)

				arg_19_1.typewritterCharCountI18N = var_22_3
			end

			local var_22_6 = 0
			local var_22_7 = manager.audio:GetVoiceLength("story_v_out_110061", "110061005", "story_v_out_110061.awb") / 1000

			if var_22_7 > 0 and 10.866 < var_22_7 and var_22_7 + var_22_6 > arg_19_1.duration_ then
				arg_19_1.duration_ = var_22_7 + var_22_6
			end

			if var_22_6 < arg_19_1.time_ and arg_19_1.time_ <= var_22_6 + arg_22_0 then
				arg_19_1:AudioAction("play", "voice", "story_v_out_110061", "110061005", "story_v_out_110061.awb")
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play110061006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 110061006
		arg_23_1.duration_ = 6.16

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play110061007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.var_.oldValueTypewriter = arg_23_1.fswtw_.percent

				SetActive(arg_23_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_23_1:ShowNextGo(false)
			end

			local var_26_0 = 34
			local var_26_1 = 2.26666666666667
			local var_26_2, var_26_3 = arg_23_1:GetPercentByPara(arg_23_1:FormatText(arg_23_1:GetWordFromCfg(110061001).content), 6)

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0

				local var_26_4 = var_26_0 <= 0 and var_26_1 or var_26_1 * ((var_26_3 - arg_23_1.typewritterCharCountI18N) / var_26_0)

				if (var_26_0 <= 0 and var_26_1 or var_26_1 * ((var_26_3 - arg_23_1.typewritterCharCountI18N) / var_26_0)) > 0 and var_26_1 < var_26_4 then
					arg_23_1.talkMaxDuration = var_26_4

					if var_26_4 + 0 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_4 + 0
					end
				end
			end

			local var_26_5 = math.max(2.26666666666667, arg_23_1.talkMaxDuration)

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_5 then
				arg_23_1.fswtw_.percent = Mathf.Lerp(arg_23_1.var_.oldValueTypewriter, var_26_2, (arg_23_1.time_ - 0) / var_26_5)
				arg_23_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_23_1.fswtw_:SetDirty()
			end

			if arg_23_1.time_ >= 0 + var_26_5 and arg_23_1.time_ < 0 + var_26_5 + arg_26_0 then
				arg_23_1.fswtw_.percent = var_26_2

				arg_23_1.fswtw_:SetDirty()
				arg_23_1:ShowNextGo(true)

				arg_23_1.typewritterCharCountI18N = var_26_3
			end

			local var_26_6 = 0
			local var_26_7 = manager.audio:GetVoiceLength("story_v_out_110061", "110061006", "story_v_out_110061.awb") / 1000

			if var_26_7 > 0 and 6.163 < var_26_7 and var_26_7 + var_26_6 > arg_23_1.duration_ then
				arg_23_1.duration_ = var_26_7 + var_26_6
			end

			if var_26_6 < arg_23_1.time_ and arg_23_1.time_ <= var_26_6 + arg_26_0 then
				arg_23_1:AudioAction("play", "voice", "story_v_out_110061", "110061006", "story_v_out_110061.awb")
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play110061007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 110061007
		arg_27_1.duration_ = 5.14

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play110061008(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.fswbg_:SetActive(true)
				arg_27_1.dialog_:SetActive(false)

				arg_27_1.fswtw_.percent = 0
				arg_27_1.fswt_.text = arg_27_1:FormatText(arg_27_1:GetWordFromCfg(110061007).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.fswt_)

				arg_27_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_27_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_27_1.fswtw_:SetDirty()

				arg_27_1.typewritterCharCountI18N = 0

				SetActive(arg_27_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_27_1:ShowNextGo(false)
			end

			local var_30_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_27_1.time_ and arg_27_1.time_ <= var_30_0 + arg_30_0 then
				arg_27_1.var_.oldValueTypewriter = arg_27_1.fswtw_.percent

				SetActive(arg_27_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_27_1:ShowNextGo(false)
			end

			local var_30_1 = 22
			local var_30_2 = 1.46666666666667
			local var_30_3, var_30_4 = arg_27_1:GetPercentByPara(arg_27_1:FormatText(arg_27_1:GetWordFromCfg(110061007).content), 1)

			if var_30_0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_0 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0

				local var_30_5 = var_30_1 <= 0 and var_30_2 or var_30_2 * ((var_30_4 - arg_27_1.typewritterCharCountI18N) / var_30_1)

				if (var_30_1 <= 0 and var_30_2 or var_30_2 * ((var_30_4 - arg_27_1.typewritterCharCountI18N) / var_30_1)) > 0 and var_30_2 < var_30_5 then
					arg_27_1.talkMaxDuration = var_30_5

					if var_30_5 + var_30_0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_5 + var_30_0
					end
				end
			end

			local var_30_6 = math.max(1.46666666666667, arg_27_1.talkMaxDuration)

			if var_30_0 <= arg_27_1.time_ and arg_27_1.time_ < var_30_0 + var_30_6 then
				arg_27_1.fswtw_.percent = Mathf.Lerp(arg_27_1.var_.oldValueTypewriter, var_30_3, (arg_27_1.time_ - var_30_0) / var_30_6)
				arg_27_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_27_1.fswtw_:SetDirty()
			end

			if arg_27_1.time_ >= var_30_0 + var_30_6 and arg_27_1.time_ < var_30_0 + var_30_6 + arg_30_0 then
				arg_27_1.fswtw_.percent = var_30_3

				arg_27_1.fswtw_:SetDirty()
				arg_27_1:ShowNextGo(true)

				arg_27_1.typewritterCharCountI18N = var_30_4
			end

			local var_30_7 = 0
			local var_30_8 = manager.audio:GetVoiceLength("story_v_out_110061", "110061007", "story_v_out_110061.awb") / 1000

			if var_30_8 > 0 and 5.144 < var_30_8 and var_30_8 + var_30_7 > arg_27_1.duration_ then
				arg_27_1.duration_ = var_30_8 + var_30_7
			end

			if var_30_7 < arg_27_1.time_ and arg_27_1.time_ <= var_30_7 + arg_30_0 then
				arg_27_1:AudioAction("play", "voice", "story_v_out_110061", "110061007", "story_v_out_110061.awb")
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play110061008 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 110061008
		arg_31_1.duration_ = 8.32

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play110061009(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.var_.oldValueTypewriter = arg_31_1.fswtw_.percent

				SetActive(arg_31_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_31_1:ShowNextGo(false)
			end

			local var_34_0 = 31
			local var_34_1 = 2.06666666666667
			local var_34_2, var_34_3 = arg_31_1:GetPercentByPara(arg_31_1:FormatText(arg_31_1:GetWordFromCfg(110061007).content), 2)

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0

				local var_34_4 = var_34_0 <= 0 and var_34_1 or var_34_1 * ((var_34_3 - arg_31_1.typewritterCharCountI18N) / var_34_0)

				if (var_34_0 <= 0 and var_34_1 or var_34_1 * ((var_34_3 - arg_31_1.typewritterCharCountI18N) / var_34_0)) > 0 and var_34_1 < var_34_4 then
					arg_31_1.talkMaxDuration = var_34_4

					if var_34_4 + 0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_4 + 0
					end
				end
			end

			local var_34_5 = math.max(2.06666666666667, arg_31_1.talkMaxDuration)

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_5 then
				arg_31_1.fswtw_.percent = Mathf.Lerp(arg_31_1.var_.oldValueTypewriter, var_34_2, (arg_31_1.time_ - 0) / var_34_5)
				arg_31_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_31_1.fswtw_:SetDirty()
			end

			if arg_31_1.time_ >= 0 + var_34_5 and arg_31_1.time_ < 0 + var_34_5 + arg_34_0 then
				arg_31_1.fswtw_.percent = var_34_2

				arg_31_1.fswtw_:SetDirty()
				arg_31_1:ShowNextGo(true)

				arg_31_1.typewritterCharCountI18N = var_34_3
			end

			local var_34_6 = 0
			local var_34_7 = manager.audio:GetVoiceLength("story_v_out_110061", "110061008", "story_v_out_110061.awb") / 1000

			if var_34_7 > 0 and 8.325 < var_34_7 and var_34_7 + var_34_6 > arg_31_1.duration_ then
				arg_31_1.duration_ = var_34_7 + var_34_6
			end

			if var_34_6 < arg_31_1.time_ and arg_31_1.time_ <= var_34_6 + arg_34_0 then
				arg_31_1:AudioAction("play", "voice", "story_v_out_110061", "110061008", "story_v_out_110061.awb")
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play110061009 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 110061009
		arg_35_1.duration_ = 8.05

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play110061010(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.var_.oldValueTypewriter = arg_35_1.fswtw_.percent

				SetActive(arg_35_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_35_1:ShowNextGo(false)
			end

			local var_38_0 = 37
			local var_38_1 = 2.46666666666667
			local var_38_2, var_38_3 = arg_35_1:GetPercentByPara(arg_35_1:FormatText(arg_35_1:GetWordFromCfg(110061007).content), 3)

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0

				local var_38_4 = var_38_0 <= 0 and var_38_1 or var_38_1 * ((var_38_3 - arg_35_1.typewritterCharCountI18N) / var_38_0)

				if (var_38_0 <= 0 and var_38_1 or var_38_1 * ((var_38_3 - arg_35_1.typewritterCharCountI18N) / var_38_0)) > 0 and var_38_1 < var_38_4 then
					arg_35_1.talkMaxDuration = var_38_4

					if var_38_4 + 0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_4 + 0
					end
				end
			end

			local var_38_5 = math.max(2.46666666666667, arg_35_1.talkMaxDuration)

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_5 then
				arg_35_1.fswtw_.percent = Mathf.Lerp(arg_35_1.var_.oldValueTypewriter, var_38_2, (arg_35_1.time_ - 0) / var_38_5)
				arg_35_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_35_1.fswtw_:SetDirty()
			end

			if arg_35_1.time_ >= 0 + var_38_5 and arg_35_1.time_ < 0 + var_38_5 + arg_38_0 then
				arg_35_1.fswtw_.percent = var_38_2

				arg_35_1.fswtw_:SetDirty()
				arg_35_1:ShowNextGo(true)

				arg_35_1.typewritterCharCountI18N = var_38_3
			end

			local var_38_6 = 0
			local var_38_7 = manager.audio:GetVoiceLength("story_v_out_110061", "110061009", "story_v_out_110061.awb") / 1000

			if var_38_7 > 0 and 8.053 < var_38_7 and var_38_7 + var_38_6 > arg_35_1.duration_ then
				arg_35_1.duration_ = var_38_7 + var_38_6
			end

			if var_38_6 < arg_35_1.time_ and arg_35_1.time_ <= var_38_6 + arg_38_0 then
				arg_35_1:AudioAction("play", "voice", "story_v_out_110061", "110061009", "story_v_out_110061.awb")
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play110061010 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 110061010
		arg_39_1.duration_ = 6.29

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play110061011(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.var_.oldValueTypewriter = arg_39_1.fswtw_.percent

				SetActive(arg_39_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_39_1:ShowNextGo(false)
			end

			local var_42_0 = 27
			local var_42_1 = 1.8
			local var_42_2, var_42_3 = arg_39_1:GetPercentByPara(arg_39_1:FormatText(arg_39_1:GetWordFromCfg(110061007).content), 4)

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0

				local var_42_4 = var_42_0 <= 0 and var_42_1 or var_42_1 * ((var_42_3 - arg_39_1.typewritterCharCountI18N) / var_42_0)

				if (var_42_0 <= 0 and var_42_1 or var_42_1 * ((var_42_3 - arg_39_1.typewritterCharCountI18N) / var_42_0)) > 0 and var_42_1 < var_42_4 then
					arg_39_1.talkMaxDuration = var_42_4

					if var_42_4 + 0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_4 + 0
					end
				end
			end

			local var_42_5 = math.max(1.8, arg_39_1.talkMaxDuration)

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_5 then
				arg_39_1.fswtw_.percent = Mathf.Lerp(arg_39_1.var_.oldValueTypewriter, var_42_2, (arg_39_1.time_ - 0) / var_42_5)
				arg_39_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_39_1.fswtw_:SetDirty()
			end

			if arg_39_1.time_ >= 0 + var_42_5 and arg_39_1.time_ < 0 + var_42_5 + arg_42_0 then
				arg_39_1.fswtw_.percent = var_42_2

				arg_39_1.fswtw_:SetDirty()
				arg_39_1:ShowNextGo(true)

				arg_39_1.typewritterCharCountI18N = var_42_3
			end

			local var_42_6 = 0
			local var_42_7 = manager.audio:GetVoiceLength("story_v_out_110061", "110061010", "story_v_out_110061.awb") / 1000

			if var_42_7 > 0 and 6.288 < var_42_7 and var_42_7 + var_42_6 > arg_39_1.duration_ then
				arg_39_1.duration_ = var_42_7 + var_42_6
			end

			if var_42_6 < arg_39_1.time_ and arg_39_1.time_ <= var_42_6 + arg_42_0 then
				arg_39_1:AudioAction("play", "voice", "story_v_out_110061", "110061010", "story_v_out_110061.awb")
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play110061011 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 110061011
		arg_43_1.duration_ = 0.5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play110061012(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.oldValueTypewriter = arg_43_1.fswtw_.percent

				SetActive(arg_43_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_43_1:ShowNextGo(false)
			end

			local var_46_0 = 3
			local var_46_1 = 0.2
			local var_46_2, var_46_3 = arg_43_1:GetPercentByPara(arg_43_1:FormatText(arg_43_1:GetWordFromCfg(110061007).content), 5)

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0

				local var_46_4 = var_46_0 <= 0 and var_46_1 or var_46_1 * ((var_46_3 - arg_43_1.typewritterCharCountI18N) / var_46_0)

				if (var_46_0 <= 0 and var_46_1 or var_46_1 * ((var_46_3 - arg_43_1.typewritterCharCountI18N) / var_46_0)) > 0 and var_46_1 < var_46_4 then
					arg_43_1.talkMaxDuration = var_46_4

					if var_46_4 + 0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_4 + 0
					end
				end
			end

			local var_46_5 = math.max(0.2, arg_43_1.talkMaxDuration)

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_5 then
				arg_43_1.fswtw_.percent = Mathf.Lerp(arg_43_1.var_.oldValueTypewriter, var_46_2, (arg_43_1.time_ - 0) / var_46_5)
				arg_43_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_43_1.fswtw_:SetDirty()
			end

			if arg_43_1.time_ >= 0 + var_46_5 and arg_43_1.time_ < 0 + var_46_5 + arg_46_0 then
				arg_43_1.fswtw_.percent = var_46_2

				arg_43_1.fswtw_:SetDirty()
				arg_43_1:ShowNextGo(true)

				arg_43_1.typewritterCharCountI18N = var_46_3
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play110061012 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 110061012
		arg_47_1.duration_ = 2.43

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play110061013(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.var_.oldValueTypewriter = arg_47_1.fswtw_.percent

				SetActive(arg_47_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_47_1:ShowNextGo(false)
			end

			local var_50_0 = 17
			local var_50_1 = 1.13333333333333
			local var_50_2, var_50_3 = arg_47_1:GetPercentByPara(arg_47_1:FormatText(arg_47_1:GetWordFromCfg(110061007).content), 6)

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0

				local var_50_4 = var_50_0 <= 0 and var_50_1 or var_50_1 * ((var_50_3 - arg_47_1.typewritterCharCountI18N) / var_50_0)

				if (var_50_0 <= 0 and var_50_1 or var_50_1 * ((var_50_3 - arg_47_1.typewritterCharCountI18N) / var_50_0)) > 0 and var_50_1 < var_50_4 then
					arg_47_1.talkMaxDuration = var_50_4

					if var_50_4 + 0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_4 + 0
					end
				end
			end

			local var_50_5 = math.max(1.13333333333333, arg_47_1.talkMaxDuration)

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_5 then
				arg_47_1.fswtw_.percent = Mathf.Lerp(arg_47_1.var_.oldValueTypewriter, var_50_2, (arg_47_1.time_ - 0) / var_50_5)
				arg_47_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_47_1.fswtw_:SetDirty()
			end

			if arg_47_1.time_ >= 0 + var_50_5 and arg_47_1.time_ < 0 + var_50_5 + arg_50_0 then
				arg_47_1.fswtw_.percent = var_50_2

				arg_47_1.fswtw_:SetDirty()
				arg_47_1:ShowNextGo(true)

				arg_47_1.typewritterCharCountI18N = var_50_3
			end

			local var_50_6 = 0
			local var_50_7 = manager.audio:GetVoiceLength("story_v_out_110061", "110061012", "story_v_out_110061.awb") / 1000

			if var_50_7 > 0 and 2.427 < var_50_7 and var_50_7 + var_50_6 > arg_47_1.duration_ then
				arg_47_1.duration_ = var_50_7 + var_50_6
			end

			if var_50_6 < arg_47_1.time_ and arg_47_1.time_ <= var_50_6 + arg_50_0 then
				arg_47_1:AudioAction("play", "voice", "story_v_out_110061", "110061012", "story_v_out_110061.awb")
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play110061013 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 110061013
		arg_51_1.duration_ = 3.32

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
			arg_51_1.auto_ = false
		end

		function arg_51_1.playNext_(arg_53_0)
			arg_51_1.onStoryFinished_()
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.oldValueTypewriter = arg_51_1.fswtw_.percent

				SetActive(arg_51_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_51_1:ShowNextGo(false)
			end

			local var_54_0 = 21
			local var_54_1 = 1.4
			local var_54_2, var_54_3 = arg_51_1:GetPercentByPara(arg_51_1:FormatText(arg_51_1:GetWordFromCfg(110061007).content), 7)

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0

				local var_54_4 = var_54_0 <= 0 and var_54_1 or var_54_1 * ((var_54_3 - arg_51_1.typewritterCharCountI18N) / var_54_0)

				if (var_54_0 <= 0 and var_54_1 or var_54_1 * ((var_54_3 - arg_51_1.typewritterCharCountI18N) / var_54_0)) > 0 and var_54_1 < var_54_4 then
					arg_51_1.talkMaxDuration = var_54_4

					if var_54_4 + 0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_4 + 0
					end
				end
			end

			local var_54_5 = math.max(1.4, arg_51_1.talkMaxDuration)

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_5 then
				arg_51_1.fswtw_.percent = Mathf.Lerp(arg_51_1.var_.oldValueTypewriter, var_54_2, (arg_51_1.time_ - 0) / var_54_5)
				arg_51_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_51_1.fswtw_:SetDirty()
			end

			if arg_51_1.time_ >= 0 + var_54_5 and arg_51_1.time_ < 0 + var_54_5 + arg_54_0 then
				arg_51_1.fswtw_.percent = var_54_2

				arg_51_1.fswtw_:SetDirty()
				arg_51_1:ShowNextGo(true)

				arg_51_1.typewritterCharCountI18N = var_54_3
			end

			local var_54_6 = 0
			local var_54_7 = manager.audio:GetVoiceLength("story_v_out_110061", "110061013", "story_v_out_110061.awb") / 1000

			if var_54_7 > 0 and 3.325 < var_54_7 and var_54_7 + var_54_6 > arg_51_1.duration_ then
				arg_51_1.duration_ = var_54_7 + var_54_6
			end

			if var_54_6 < arg_51_1.time_ and arg_51_1.time_ <= var_54_6 + arg_54_0 then
				arg_51_1:AudioAction("play", "voice", "story_v_out_110061", "110061013", "story_v_out_110061.awb")
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	assets = {},
	voices = {
		"story_v_out_110061.awb"
	}
}
