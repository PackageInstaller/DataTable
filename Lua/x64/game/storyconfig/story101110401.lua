return {
	Play111041001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 111041001
		arg_1_1.duration_ = 2

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play111041002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				arg_1_1.fswbg_:SetActive(true)
				arg_1_1.dialog_:SetActive(false)

				arg_1_1.fswtw_.percent = 0

				local var_4_1 = arg_1_1:GetWordFromCfg(111041001)
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

			local var_4_4 = 17
			local var_4_5 = 1.02
			local var_4_6 = arg_1_1:GetWordFromCfg(111041001)
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

			local var_4_11 = 1.02
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
			local var_4_21 = 1
			local var_4_22 = manager.audio:GetVoiceLength("story_v_out_111041", "111041001", "story_v_out_111041.awb") / 1000

			if var_4_22 > 0 and var_4_21 < var_4_22 and var_4_22 + var_4_20 > arg_1_1.duration_ then
				local var_4_23 = var_4_22

				arg_1_1.duration_ = var_4_22 + var_4_20
			end

			if var_4_20 < arg_1_1.time_ and arg_1_1.time_ <= var_4_20 + arg_4_0 then
				local var_4_24 = "play"
				local var_4_25 = "voice"

				arg_1_1:AudioAction(var_4_24, var_4_25, "story_v_out_111041", "111041001", "story_v_out_111041.awb")
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play111041002 = function(arg_6_0, arg_6_1)
		arg_6_1.time_ = 0
		arg_6_1.frameCnt_ = 0
		arg_6_1.state_ = "playing"
		arg_6_1.curTalkId_ = 111041002
		arg_6_1.duration_ = 1.14

		SetActive(arg_6_1.tipsGo_, false)

		function arg_6_1.onSingleLineFinish_()
			arg_6_1.onSingleLineUpdate_ = nil
			arg_6_1.onSingleLineFinish_ = nil
			arg_6_1.state_ = "waiting"
		end

		function arg_6_1.playNext_(arg_8_0)
			if arg_8_0 == 1 then
				arg_6_0:Play111041003(arg_6_1)
			end
		end

		function arg_6_1.onSingleLineUpdate_(arg_9_0)
			local var_9_0 = 0

			if var_9_0 < arg_6_1.time_ and arg_6_1.time_ <= var_9_0 + arg_9_0 then
				arg_6_1.var_.oldValueTypewriter = arg_6_1.fswtw_.percent

				SetActive(arg_6_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_6_1:ShowNextGo(false)
			end

			local var_9_1 = 19
			local var_9_2 = 1.14
			local var_9_3 = arg_6_1:GetWordFromCfg(111041001)
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

			local var_9_8 = 1.14
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
			local var_9_13 = manager.audio:GetVoiceLength("story_v_out_111041", "111041002", "story_v_out_111041.awb") / 1000

			if var_9_13 > 0 and var_9_12 < var_9_13 and var_9_13 + var_9_11 > arg_6_1.duration_ then
				local var_9_14 = var_9_13

				arg_6_1.duration_ = var_9_13 + var_9_11
			end

			if var_9_11 < arg_6_1.time_ and arg_6_1.time_ <= var_9_11 + arg_9_0 then
				local var_9_15 = "play"
				local var_9_16 = "voice"

				arg_6_1:AudioAction(var_9_15, var_9_16, "story_v_out_111041", "111041002", "story_v_out_111041.awb")
			end
		end

		arg_6_1.nodeConfigList_ = {}

		arg_6_1:InitPlayNodeList()
	end,
	Play111041003 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 111041003
		arg_10_1.duration_ = 1.48

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play111041004(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			local var_13_0 = 0

			if var_13_0 < arg_10_1.time_ and arg_10_1.time_ <= var_13_0 + arg_13_0 then
				arg_10_1.var_.oldValueTypewriter = arg_10_1.fswtw_.percent

				SetActive(arg_10_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_10_1:ShowNextGo(false)
			end

			local var_13_1 = 23
			local var_13_2 = 1.48
			local var_13_3 = arg_10_1:GetWordFromCfg(111041001)
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

			local var_13_8 = 1.48
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
			local var_13_13 = manager.audio:GetVoiceLength("story_v_out_111041", "111041003", "story_v_out_111041.awb") / 1000

			if var_13_13 > 0 and var_13_12 < var_13_13 and var_13_13 + var_13_11 > arg_10_1.duration_ then
				local var_13_14 = var_13_13

				arg_10_1.duration_ = var_13_13 + var_13_11
			end

			if var_13_11 < arg_10_1.time_ and arg_10_1.time_ <= var_13_11 + arg_13_0 then
				local var_13_15 = "play"
				local var_13_16 = "voice"

				arg_10_1:AudioAction(var_13_15, var_13_16, "story_v_out_111041", "111041003", "story_v_out_111041.awb")
			end
		end

		arg_10_1.nodeConfigList_ = {}

		arg_10_1:InitPlayNodeList()
	end,
	Play111041004 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 111041004
		arg_14_1.duration_ = 1.74

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play111041005(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = 0

			if var_17_0 < arg_14_1.time_ and arg_14_1.time_ <= var_17_0 + arg_17_0 then
				arg_14_1.var_.oldValueTypewriter = arg_14_1.fswtw_.percent

				SetActive(arg_14_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_14_1:ShowNextGo(false)
			end

			local var_17_1 = 29
			local var_17_2 = 1.74
			local var_17_3 = arg_14_1:GetWordFromCfg(111041001)
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

			local var_17_8 = 1.74
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
			local var_17_13 = manager.audio:GetVoiceLength("story_v_out_111041", "111041004", "story_v_out_111041.awb") / 1000

			if var_17_13 > 0 and var_17_12 < var_17_13 and var_17_13 + var_17_11 > arg_14_1.duration_ then
				local var_17_14 = var_17_13

				arg_14_1.duration_ = var_17_13 + var_17_11
			end

			if var_17_11 < arg_14_1.time_ and arg_14_1.time_ <= var_17_11 + arg_17_0 then
				local var_17_15 = "play"
				local var_17_16 = "voice"

				arg_14_1:AudioAction(var_17_15, var_17_16, "story_v_out_111041", "111041004", "story_v_out_111041.awb")
			end
		end

		arg_14_1.nodeConfigList_ = {}

		arg_14_1:InitPlayNodeList()
	end,
	Play111041005 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 111041005
		arg_18_1.duration_ = 5.43

		local var_18_0 = {
			ja = 4.933,
			ko = 5.433,
			zh = 4.866,
			en = 4.4
		}
		local var_18_1 = manager.audio:GetLocalizationFlag()

		if var_18_0[var_18_1] ~= nil then
			arg_18_1.duration_ = var_18_0[var_18_1]
		end

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play111041006(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = "D09"

			if arg_18_1.bgs_[var_21_0] == nil then
				local var_21_1 = Object.Instantiate(arg_18_1.paintGo_)

				var_21_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_21_0)
				var_21_1.name = var_21_0
				var_21_1.transform.parent = arg_18_1.stage_.transform
				var_21_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_18_1.bgs_[var_21_0] = var_21_1
			end

			local var_21_2 = 0

			if var_21_2 < arg_18_1.time_ and arg_18_1.time_ <= var_21_2 + arg_21_0 then
				local var_21_3 = manager.ui.mainCamera.transform.localPosition
				local var_21_4 = Vector3.New(0, 0, 10) + Vector3.New(var_21_3.x, var_21_3.y, 0)
				local var_21_5 = arg_18_1.bgs_.D09

				var_21_5.transform.localPosition = var_21_4
				var_21_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_21_6 = var_21_5:GetComponent("SpriteRenderer")

				if var_21_6 and var_21_6.sprite then
					local var_21_7 = (var_21_5.transform.localPosition - var_21_3).z
					local var_21_8 = manager.ui.mainCameraCom_
					local var_21_9 = 2 * var_21_7 * Mathf.Tan(var_21_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_21_10 = var_21_9 * var_21_8.aspect
					local var_21_11 = var_21_6.sprite.bounds.size.x
					local var_21_12 = var_21_6.sprite.bounds.size.y
					local var_21_13 = var_21_10 / var_21_11
					local var_21_14 = var_21_9 / var_21_12
					local var_21_15 = var_21_14 < var_21_13 and var_21_13 or var_21_14

					var_21_5.transform.localScale = Vector3.New(var_21_15, var_21_15, 0)
				end

				for iter_21_0, iter_21_1 in pairs(arg_18_1.bgs_) do
					if iter_21_0 ~= "D09" then
						iter_21_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_21_16 = 0

			if var_21_16 < arg_18_1.time_ and arg_18_1.time_ <= var_21_16 + arg_21_0 then
				arg_18_1.fswbg_:SetActive(false)
				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_18_1:ShowNextGo(false)
			end

			local var_21_17 = arg_18_1.bgs_.D09
			local var_21_18 = 0

			if var_21_18 < arg_18_1.time_ and arg_18_1.time_ <= var_21_18 + arg_21_0 then
				local var_21_19 = var_21_17:GetComponent("SpriteRenderer")

				if var_21_19 then
					arg_18_1.var_.alphaOldValueD09 = var_21_19.color.a
					arg_18_1.var_.alphaMatValueD09 = var_21_19
				end

				arg_18_1.var_.alphaOldValueD09 = 0
			end

			local var_21_20 = 1.5

			if var_21_18 <= arg_18_1.time_ and arg_18_1.time_ < var_21_18 + var_21_20 then
				local var_21_21 = (arg_18_1.time_ - var_21_18) / var_21_20
				local var_21_22 = Mathf.Lerp(arg_18_1.var_.alphaOldValueD09, 1, var_21_21)

				if arg_18_1.var_.alphaMatValueD09 then
					local var_21_23 = arg_18_1.var_.alphaMatValueD09.color

					var_21_23.a = var_21_22
					arg_18_1.var_.alphaMatValueD09.color = var_21_23
				end
			end

			if arg_18_1.time_ >= var_21_18 + var_21_20 and arg_18_1.time_ < var_21_18 + var_21_20 + arg_21_0 and arg_18_1.var_.alphaMatValueD09 then
				local var_21_24 = arg_18_1.var_.alphaMatValueD09
				local var_21_25 = var_21_24.color

				var_21_25.a = 1
				var_21_24.color = var_21_25
			end

			local var_21_26 = 0

			if var_21_26 < arg_18_1.time_ and arg_18_1.time_ <= var_21_26 + arg_21_0 then
				arg_18_1.allBtn_.enabled = false
			end

			local var_21_27 = 2

			if arg_18_1.time_ >= var_21_26 + var_21_27 and arg_18_1.time_ < var_21_26 + var_21_27 + arg_21_0 then
				arg_18_1.allBtn_.enabled = true
			end

			local var_21_28 = 0
			local var_21_29 = 1

			if var_21_28 < arg_18_1.time_ and arg_18_1.time_ <= var_21_28 + arg_21_0 then
				local var_21_30 = "play"
				local var_21_31 = "music"

				arg_18_1:AudioAction(var_21_30, var_21_31, "bgm_activity_1_1_hel_story", "bgm_activity_1_1_hel_story", "bgm_activity_1_1_hel_story.awb")

				local var_21_32 = ""
				local var_21_33 = manager.audio:GetAudioName("bgm_activity_1_1_hel_story", "bgm_activity_1_1_hel_story")

				if var_21_33 ~= "" then
					if arg_18_1.bgmTxt_.text ~= var_21_33 and arg_18_1.bgmTxt_.text ~= "" then
						if arg_18_1.bgmTxt2_.text ~= "" then
							arg_18_1.bgmTxt_.text = arg_18_1.bgmTxt2_.text
						end

						arg_18_1.bgmTxt2_.text = var_21_33

						arg_18_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_18_1.bgmTxt_.text = var_21_33
						arg_18_1.bgmTxt2_.text = var_21_33
					end

					if arg_18_1.bgmTimer then
						arg_18_1.bgmTimer:Stop()

						arg_18_1.bgmTimer = nil
					end

					if arg_18_1.settingData.show_music_name == 1 then
						arg_18_1.musicController:SetSelectedState("show")
						arg_18_1.musicAnimator_:Play("open", 0, 0)

						if arg_18_1.settingData.music_time ~= 0 then
							arg_18_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_18_1.settingData.music_time), function()
								if arg_18_1 == nil or isNil(arg_18_1.bgmTxt_) then
									return
								end

								arg_18_1.musicController:SetSelectedState("hide")
								arg_18_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_18_1.frameCnt_ <= 1 then
				arg_18_1.dialog_:SetActive(false)
			end

			local var_21_34 = 2
			local var_21_35 = 0.3

			if var_21_34 < arg_18_1.time_ and arg_18_1.time_ <= var_21_34 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0

				arg_18_1.dialog_:SetActive(true)

				arg_18_1.dialogCg_.alpha = 0

				local var_21_36 = LeanTween.value(arg_18_1.dialog_, 0, 1, 0.3)

				var_21_36:setOnUpdate(LuaHelper.FloatAction(function(arg_23_0)
					arg_18_1.dialogCg_.alpha = arg_23_0
				end))
				var_21_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_18_1.dialog_)
					var_21_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_18_1.duration_ = arg_18_1.duration_ + 0.3

				SetActive(arg_18_1.leftNameGo_, true)

				local var_21_37 = arg_18_1:FormatText(StoryNameCfg[177].name)

				arg_18_1.leftNameTxt_.text = var_21_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, true)
				arg_18_1.iconController_:SetSelectedState("hero")

				arg_18_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_18_1.callingController_:SetSelectedState("normal")

				arg_18_1.keyicon_.color = Color.New(1, 1, 1)
				arg_18_1.icon_.color = Color.New(1, 1, 1)

				local var_21_38 = arg_18_1:GetWordFromCfg(111041005)
				local var_21_39 = arg_18_1:FormatText(var_21_38.content)

				arg_18_1.text_.text = var_21_39

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_40 = 12
				local var_21_41 = utf8.len(var_21_39)
				local var_21_42 = var_21_40 <= 0 and var_21_35 or var_21_35 * (var_21_41 / var_21_40)

				if var_21_42 > 0 and var_21_35 < var_21_42 then
					arg_18_1.talkMaxDuration = var_21_42
					var_21_34 = var_21_34 + 0.3

					if var_21_42 + var_21_34 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_42 + var_21_34
					end
				end

				arg_18_1.text_.text = var_21_39
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111041", "111041005", "story_v_out_111041.awb") ~= 0 then
					local var_21_43 = manager.audio:GetVoiceLength("story_v_out_111041", "111041005", "story_v_out_111041.awb") / 1000

					if var_21_43 + var_21_34 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_43 + var_21_34
					end

					if var_21_38.prefab_name ~= "" and arg_18_1.actors_[var_21_38.prefab_name] ~= nil then
						local var_21_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_38.prefab_name].transform, "story_v_out_111041", "111041005", "story_v_out_111041.awb")

						arg_18_1:RecordAudio("111041005", var_21_44)
						arg_18_1:RecordAudio("111041005", var_21_44)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_111041", "111041005", "story_v_out_111041.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_111041", "111041005", "story_v_out_111041.awb")
				end

				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_45 = var_21_34 + 0.3
			local var_21_46 = math.max(var_21_35, arg_18_1.talkMaxDuration)

			if var_21_45 <= arg_18_1.time_ and arg_18_1.time_ < var_21_45 + var_21_46 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_45) / var_21_46

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_45 + var_21_46 and arg_18_1.time_ < var_21_45 + var_21_46 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play111041006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 111041006
		arg_25_1.duration_ = 4.33

		local var_25_0 = {
			ja = 4.333,
			ko = 3.266,
			zh = 2.866,
			en = 2.533
		}
		local var_25_1 = manager.audio:GetLocalizationFlag()

		if var_25_0[var_25_1] ~= nil then
			arg_25_1.duration_ = var_25_0[var_25_1]
		end

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play111041007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 0.425

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_2 = arg_25_1:FormatText(StoryNameCfg[177].name)

				arg_25_1.leftNameTxt_.text = var_28_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_3 = arg_25_1:GetWordFromCfg(111041006)
				local var_28_4 = arg_25_1:FormatText(var_28_3.content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 17
				local var_28_6 = utf8.len(var_28_4)
				local var_28_7 = var_28_5 <= 0 and var_28_1 or var_28_1 * (var_28_6 / var_28_5)

				if var_28_7 > 0 and var_28_1 < var_28_7 then
					arg_25_1.talkMaxDuration = var_28_7

					if var_28_7 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_7 + var_28_0
					end
				end

				arg_25_1.text_.text = var_28_4
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111041", "111041006", "story_v_out_111041.awb") ~= 0 then
					local var_28_8 = manager.audio:GetVoiceLength("story_v_out_111041", "111041006", "story_v_out_111041.awb") / 1000

					if var_28_8 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_8 + var_28_0
					end

					if var_28_3.prefab_name ~= "" and arg_25_1.actors_[var_28_3.prefab_name] ~= nil then
						local var_28_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_3.prefab_name].transform, "story_v_out_111041", "111041006", "story_v_out_111041.awb")

						arg_25_1:RecordAudio("111041006", var_28_9)
						arg_25_1:RecordAudio("111041006", var_28_9)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_111041", "111041006", "story_v_out_111041.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_111041", "111041006", "story_v_out_111041.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_10 = math.max(var_28_1, arg_25_1.talkMaxDuration)

			if var_28_0 <= arg_25_1.time_ and arg_25_1.time_ < var_28_0 + var_28_10 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_0) / var_28_10

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_0 + var_28_10 and arg_25_1.time_ < var_28_0 + var_28_10 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play111041007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 111041007
		arg_29_1.duration_ = 3.27

		local var_29_0 = {
			ja = 1.999999999999,
			ko = 2.633,
			zh = 3.266,
			en = 3
		}
		local var_29_1 = manager.audio:GetLocalizationFlag()

		if var_29_0[var_29_1] ~= nil then
			arg_29_1.duration_ = var_29_0[var_29_1]
		end

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play111041008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = "1094ui_story"

			if arg_29_1.actors_[var_32_0] == nil then
				local var_32_1 = Asset.Load("Char/" .. "1094ui_story")

				if not isNil(var_32_1) then
					local var_32_2 = Object.Instantiate(Asset.Load("Char/" .. "1094ui_story"), arg_29_1.stage_.transform)

					var_32_2.name = var_32_0
					var_32_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_29_1.actors_[var_32_0] = var_32_2

					local var_32_3 = var_32_2:GetComponentInChildren(typeof(CharacterEffect))

					var_32_3.enabled = true

					local var_32_4 = GameObjectTools.GetOrAddComponent(var_32_2, typeof(DynamicBoneHelper))

					if var_32_4 then
						var_32_4:EnableDynamicBone(false)
					end

					arg_29_1:ShowWeapon(var_32_3.transform, false)

					arg_29_1.var_[var_32_0 .. "Animator"] = var_32_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_29_1.var_[var_32_0 .. "Animator"].applyRootMotion = true
					arg_29_1.var_[var_32_0 .. "LipSync"] = var_32_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_32_5 = arg_29_1.actors_["1094ui_story"].transform
			local var_32_6 = 0

			if var_32_6 < arg_29_1.time_ and arg_29_1.time_ <= var_32_6 + arg_32_0 then
				arg_29_1.var_.moveOldPos1094ui_story = var_32_5.localPosition
			end

			local var_32_7 = 0.001

			if var_32_6 <= arg_29_1.time_ and arg_29_1.time_ < var_32_6 + var_32_7 then
				local var_32_8 = (arg_29_1.time_ - var_32_6) / var_32_7
				local var_32_9 = Vector3.New(0, -0.84, -6.1)

				var_32_5.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1094ui_story, var_32_9, var_32_8)

				local var_32_10 = manager.ui.mainCamera.transform.position - var_32_5.position

				var_32_5.forward = Vector3.New(var_32_10.x, var_32_10.y, var_32_10.z)

				local var_32_11 = var_32_5.localEulerAngles

				var_32_11.z = 0
				var_32_11.x = 0
				var_32_5.localEulerAngles = var_32_11
			end

			if arg_29_1.time_ >= var_32_6 + var_32_7 and arg_29_1.time_ < var_32_6 + var_32_7 + arg_32_0 then
				var_32_5.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_32_12 = manager.ui.mainCamera.transform.position - var_32_5.position

				var_32_5.forward = Vector3.New(var_32_12.x, var_32_12.y, var_32_12.z)

				local var_32_13 = var_32_5.localEulerAngles

				var_32_13.z = 0
				var_32_13.x = 0
				var_32_5.localEulerAngles = var_32_13
			end

			local var_32_14 = 0

			if var_32_14 < arg_29_1.time_ and arg_29_1.time_ <= var_32_14 + arg_32_0 then
				arg_29_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action1_1")
			end

			local var_32_15 = 0

			if var_32_15 < arg_29_1.time_ and arg_29_1.time_ <= var_32_15 + arg_32_0 then
				arg_29_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_32_16 = arg_29_1.actors_["1094ui_story"]
			local var_32_17 = 0

			if var_32_17 < arg_29_1.time_ and arg_29_1.time_ <= var_32_17 + arg_32_0 and not isNil(var_32_16) and arg_29_1.var_.characterEffect1094ui_story == nil then
				arg_29_1.var_.characterEffect1094ui_story = var_32_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_18 = 0.2

			if var_32_17 <= arg_29_1.time_ and arg_29_1.time_ < var_32_17 + var_32_18 and not isNil(var_32_16) then
				local var_32_19 = (arg_29_1.time_ - var_32_17) / var_32_18

				if arg_29_1.var_.characterEffect1094ui_story and not isNil(var_32_16) then
					arg_29_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_17 + var_32_18 and arg_29_1.time_ < var_32_17 + var_32_18 + arg_32_0 and not isNil(var_32_16) and arg_29_1.var_.characterEffect1094ui_story then
				arg_29_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_32_20 = 0
			local var_32_21 = 0.225

			if var_32_20 < arg_29_1.time_ and arg_29_1.time_ <= var_32_20 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_22 = arg_29_1:FormatText(StoryNameCfg[181].name)

				arg_29_1.leftNameTxt_.text = var_32_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_23 = arg_29_1:GetWordFromCfg(111041007)
				local var_32_24 = arg_29_1:FormatText(var_32_23.content)

				arg_29_1.text_.text = var_32_24

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_25 = 9
				local var_32_26 = utf8.len(var_32_24)
				local var_32_27 = var_32_25 <= 0 and var_32_21 or var_32_21 * (var_32_26 / var_32_25)

				if var_32_27 > 0 and var_32_21 < var_32_27 then
					arg_29_1.talkMaxDuration = var_32_27

					if var_32_27 + var_32_20 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_27 + var_32_20
					end
				end

				arg_29_1.text_.text = var_32_24
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111041", "111041007", "story_v_out_111041.awb") ~= 0 then
					local var_32_28 = manager.audio:GetVoiceLength("story_v_out_111041", "111041007", "story_v_out_111041.awb") / 1000

					if var_32_28 + var_32_20 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_28 + var_32_20
					end

					if var_32_23.prefab_name ~= "" and arg_29_1.actors_[var_32_23.prefab_name] ~= nil then
						local var_32_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_23.prefab_name].transform, "story_v_out_111041", "111041007", "story_v_out_111041.awb")

						arg_29_1:RecordAudio("111041007", var_32_29)
						arg_29_1:RecordAudio("111041007", var_32_29)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_111041", "111041007", "story_v_out_111041.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_111041", "111041007", "story_v_out_111041.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_30 = math.max(var_32_21, arg_29_1.talkMaxDuration)

			if var_32_20 <= arg_29_1.time_ and arg_29_1.time_ < var_32_20 + var_32_30 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_20) / var_32_30

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_20 + var_32_30 and arg_29_1.time_ < var_32_20 + var_32_30 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
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

		arg_29_1:InitPlayNodeList()
	end,
	Play111041008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 111041008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play111041009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_36_1 = arg_33_1.actors_["1094ui_story"]
			local var_36_2 = 0

			if var_36_2 < arg_33_1.time_ and arg_33_1.time_ <= var_36_2 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1094ui_story == nil then
				arg_33_1.var_.characterEffect1094ui_story = var_36_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_3 = 0.2

			if var_36_2 <= arg_33_1.time_ and arg_33_1.time_ < var_36_2 + var_36_3 and not isNil(var_36_1) then
				local var_36_4 = (arg_33_1.time_ - var_36_2) / var_36_3

				if arg_33_1.var_.characterEffect1094ui_story and not isNil(var_36_1) then
					local var_36_5 = Mathf.Lerp(0, 0.5, var_36_4)

					arg_33_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1094ui_story.fillRatio = var_36_5
				end
			end

			if arg_33_1.time_ >= var_36_2 + var_36_3 and arg_33_1.time_ < var_36_2 + var_36_3 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1094ui_story then
				local var_36_6 = 0.5

				arg_33_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1094ui_story.fillRatio = var_36_6
			end

			local var_36_7 = 0
			local var_36_8 = 0.625

			if var_36_7 < arg_33_1.time_ and arg_33_1.time_ <= var_36_7 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_9 = arg_33_1:GetWordFromCfg(111041008)
				local var_36_10 = arg_33_1:FormatText(var_36_9.content)

				arg_33_1.text_.text = var_36_10

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_11 = 25
				local var_36_12 = utf8.len(var_36_10)
				local var_36_13 = var_36_11 <= 0 and var_36_8 or var_36_8 * (var_36_12 / var_36_11)

				if var_36_13 > 0 and var_36_8 < var_36_13 then
					arg_33_1.talkMaxDuration = var_36_13

					if var_36_13 + var_36_7 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_13 + var_36_7
					end
				end

				arg_33_1.text_.text = var_36_10
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_14 = math.max(var_36_8, arg_33_1.talkMaxDuration)

			if var_36_7 <= arg_33_1.time_ and arg_33_1.time_ < var_36_7 + var_36_14 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_7) / var_36_14

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_7 + var_36_14 and arg_33_1.time_ < var_36_7 + var_36_14 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play111041009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 111041009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play111041010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0
			local var_40_1 = 0.775

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_2 = arg_37_1:GetWordFromCfg(111041009)
				local var_40_3 = arg_37_1:FormatText(var_40_2.content)

				arg_37_1.text_.text = var_40_3

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_4 = 31
				local var_40_5 = utf8.len(var_40_3)
				local var_40_6 = var_40_4 <= 0 and var_40_1 or var_40_1 * (var_40_5 / var_40_4)

				if var_40_6 > 0 and var_40_1 < var_40_6 then
					arg_37_1.talkMaxDuration = var_40_6

					if var_40_6 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_6 + var_40_0
					end
				end

				arg_37_1.text_.text = var_40_3
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_7 = math.max(var_40_1, arg_37_1.talkMaxDuration)

			if var_40_0 <= arg_37_1.time_ and arg_37_1.time_ < var_40_0 + var_40_7 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_0) / var_40_7

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_0 + var_40_7 and arg_37_1.time_ < var_40_0 + var_40_7 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play111041010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 111041010
		arg_41_1.duration_ = 3.03

		local var_41_0 = {
			ja = 3.033,
			ko = 2.6,
			zh = 2.366,
			en = 2.6
		}
		local var_41_1 = manager.audio:GetLocalizationFlag()

		if var_41_0[var_41_1] ~= nil then
			arg_41_1.duration_ = var_41_0[var_41_1]
		end

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play111041011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0
			local var_44_1 = 0.225

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_2 = arg_41_1:FormatText(StoryNameCfg[177].name)

				arg_41_1.leftNameTxt_.text = var_44_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_3 = arg_41_1:GetWordFromCfg(111041010)
				local var_44_4 = arg_41_1:FormatText(var_44_3.content)

				arg_41_1.text_.text = var_44_4

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 9
				local var_44_6 = utf8.len(var_44_4)
				local var_44_7 = var_44_5 <= 0 and var_44_1 or var_44_1 * (var_44_6 / var_44_5)

				if var_44_7 > 0 and var_44_1 < var_44_7 then
					arg_41_1.talkMaxDuration = var_44_7

					if var_44_7 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_7 + var_44_0
					end
				end

				arg_41_1.text_.text = var_44_4
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111041", "111041010", "story_v_out_111041.awb") ~= 0 then
					local var_44_8 = manager.audio:GetVoiceLength("story_v_out_111041", "111041010", "story_v_out_111041.awb") / 1000

					if var_44_8 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_8 + var_44_0
					end

					if var_44_3.prefab_name ~= "" and arg_41_1.actors_[var_44_3.prefab_name] ~= nil then
						local var_44_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_3.prefab_name].transform, "story_v_out_111041", "111041010", "story_v_out_111041.awb")

						arg_41_1:RecordAudio("111041010", var_44_9)
						arg_41_1:RecordAudio("111041010", var_44_9)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_111041", "111041010", "story_v_out_111041.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_111041", "111041010", "story_v_out_111041.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_10 = math.max(var_44_1, arg_41_1.talkMaxDuration)

			if var_44_0 <= arg_41_1.time_ and arg_41_1.time_ < var_44_0 + var_44_10 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_0) / var_44_10

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_0 + var_44_10 and arg_41_1.time_ < var_44_0 + var_44_10 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play111041011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 111041011
		arg_45_1.duration_ = 3.87

		local var_45_0 = {
			ja = 2.066,
			ko = 3.4,
			zh = 3.866,
			en = 2.8
		}
		local var_45_1 = manager.audio:GetLocalizationFlag()

		if var_45_0[var_45_1] ~= nil then
			arg_45_1.duration_ = var_45_0[var_45_1]
		end

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play111041012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action3_1")
			end

			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_48_2 = arg_45_1.actors_["1094ui_story"]
			local var_48_3 = 0

			if var_48_3 < arg_45_1.time_ and arg_45_1.time_ <= var_48_3 + arg_48_0 and not isNil(var_48_2) and arg_45_1.var_.characterEffect1094ui_story == nil then
				arg_45_1.var_.characterEffect1094ui_story = var_48_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_4 = 0.2

			if var_48_3 <= arg_45_1.time_ and arg_45_1.time_ < var_48_3 + var_48_4 and not isNil(var_48_2) then
				local var_48_5 = (arg_45_1.time_ - var_48_3) / var_48_4

				if arg_45_1.var_.characterEffect1094ui_story and not isNil(var_48_2) then
					arg_45_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= var_48_3 + var_48_4 and arg_45_1.time_ < var_48_3 + var_48_4 + arg_48_0 and not isNil(var_48_2) and arg_45_1.var_.characterEffect1094ui_story then
				arg_45_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_48_6 = 0
			local var_48_7 = 0.3

			if var_48_6 < arg_45_1.time_ and arg_45_1.time_ <= var_48_6 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_8 = arg_45_1:FormatText(StoryNameCfg[181].name)

				arg_45_1.leftNameTxt_.text = var_48_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_9 = arg_45_1:GetWordFromCfg(111041011)
				local var_48_10 = arg_45_1:FormatText(var_48_9.content)

				arg_45_1.text_.text = var_48_10

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_11 = 12
				local var_48_12 = utf8.len(var_48_10)
				local var_48_13 = var_48_11 <= 0 and var_48_7 or var_48_7 * (var_48_12 / var_48_11)

				if var_48_13 > 0 and var_48_7 < var_48_13 then
					arg_45_1.talkMaxDuration = var_48_13

					if var_48_13 + var_48_6 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_13 + var_48_6
					end
				end

				arg_45_1.text_.text = var_48_10
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111041", "111041011", "story_v_out_111041.awb") ~= 0 then
					local var_48_14 = manager.audio:GetVoiceLength("story_v_out_111041", "111041011", "story_v_out_111041.awb") / 1000

					if var_48_14 + var_48_6 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_14 + var_48_6
					end

					if var_48_9.prefab_name ~= "" and arg_45_1.actors_[var_48_9.prefab_name] ~= nil then
						local var_48_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_9.prefab_name].transform, "story_v_out_111041", "111041011", "story_v_out_111041.awb")

						arg_45_1:RecordAudio("111041011", var_48_15)
						arg_45_1:RecordAudio("111041011", var_48_15)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_111041", "111041011", "story_v_out_111041.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_111041", "111041011", "story_v_out_111041.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_16 = math.max(var_48_7, arg_45_1.talkMaxDuration)

			if var_48_6 <= arg_45_1.time_ and arg_45_1.time_ < var_48_6 + var_48_16 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_6) / var_48_16

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_6 + var_48_16 and arg_45_1.time_ < var_48_6 + var_48_16 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play111041012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 111041012
		arg_49_1.duration_ = 4.7

		local var_49_0 = {
			ja = 4.6,
			ko = 4.6,
			zh = 4.4,
			en = 4.7
		}
		local var_49_1 = manager.audio:GetLocalizationFlag()

		if var_49_0[var_49_1] ~= nil then
			arg_49_1.duration_ = var_49_0[var_49_1]
		end

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play111041013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1094ui_story"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1094ui_story == nil then
				arg_49_1.var_.characterEffect1094ui_story = var_52_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.2

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.characterEffect1094ui_story and not isNil(var_52_0) then
					local var_52_4 = Mathf.Lerp(0, 0.5, var_52_3)

					arg_49_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1094ui_story.fillRatio = var_52_4
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1094ui_story then
				local var_52_5 = 0.5

				arg_49_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1094ui_story.fillRatio = var_52_5
			end

			local var_52_6 = 0
			local var_52_7 = 0.475

			if var_52_6 < arg_49_1.time_ and arg_49_1.time_ <= var_52_6 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_8 = arg_49_1:FormatText(StoryNameCfg[177].name)

				arg_49_1.leftNameTxt_.text = var_52_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_9 = arg_49_1:GetWordFromCfg(111041012)
				local var_52_10 = arg_49_1:FormatText(var_52_9.content)

				arg_49_1.text_.text = var_52_10

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_11 = 19
				local var_52_12 = utf8.len(var_52_10)
				local var_52_13 = var_52_11 <= 0 and var_52_7 or var_52_7 * (var_52_12 / var_52_11)

				if var_52_13 > 0 and var_52_7 < var_52_13 then
					arg_49_1.talkMaxDuration = var_52_13

					if var_52_13 + var_52_6 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_13 + var_52_6
					end
				end

				arg_49_1.text_.text = var_52_10
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111041", "111041012", "story_v_out_111041.awb") ~= 0 then
					local var_52_14 = manager.audio:GetVoiceLength("story_v_out_111041", "111041012", "story_v_out_111041.awb") / 1000

					if var_52_14 + var_52_6 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_14 + var_52_6
					end

					if var_52_9.prefab_name ~= "" and arg_49_1.actors_[var_52_9.prefab_name] ~= nil then
						local var_52_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_9.prefab_name].transform, "story_v_out_111041", "111041012", "story_v_out_111041.awb")

						arg_49_1:RecordAudio("111041012", var_52_15)
						arg_49_1:RecordAudio("111041012", var_52_15)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_111041", "111041012", "story_v_out_111041.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_111041", "111041012", "story_v_out_111041.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_16 = math.max(var_52_7, arg_49_1.talkMaxDuration)

			if var_52_6 <= arg_49_1.time_ and arg_49_1.time_ < var_52_6 + var_52_16 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_6) / var_52_16

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_6 + var_52_16 and arg_49_1.time_ < var_52_6 + var_52_16 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play111041013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 111041013
		arg_53_1.duration_ = 1.07

		local var_53_0 = {
			ja = 0.999999999999,
			ko = 0.999999999999,
			zh = 0.999999999999,
			en = 1.066
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
				arg_53_0:Play111041014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["1094ui_story"]
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect1094ui_story == nil then
				arg_53_1.var_.characterEffect1094ui_story = var_56_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.2

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 and not isNil(var_56_0) then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2

				if arg_53_1.var_.characterEffect1094ui_story and not isNil(var_56_0) then
					arg_53_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect1094ui_story then
				arg_53_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_56_4 = 0
			local var_56_5 = 0.05

			if var_56_4 < arg_53_1.time_ and arg_53_1.time_ <= var_56_4 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_6 = arg_53_1:FormatText(StoryNameCfg[181].name)

				arg_53_1.leftNameTxt_.text = var_56_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_7 = arg_53_1:GetWordFromCfg(111041013)
				local var_56_8 = arg_53_1:FormatText(var_56_7.content)

				arg_53_1.text_.text = var_56_8

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_9 = 2
				local var_56_10 = utf8.len(var_56_8)
				local var_56_11 = var_56_9 <= 0 and var_56_5 or var_56_5 * (var_56_10 / var_56_9)

				if var_56_11 > 0 and var_56_5 < var_56_11 then
					arg_53_1.talkMaxDuration = var_56_11

					if var_56_11 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_11 + var_56_4
					end
				end

				arg_53_1.text_.text = var_56_8
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111041", "111041013", "story_v_out_111041.awb") ~= 0 then
					local var_56_12 = manager.audio:GetVoiceLength("story_v_out_111041", "111041013", "story_v_out_111041.awb") / 1000

					if var_56_12 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_12 + var_56_4
					end

					if var_56_7.prefab_name ~= "" and arg_53_1.actors_[var_56_7.prefab_name] ~= nil then
						local var_56_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_7.prefab_name].transform, "story_v_out_111041", "111041013", "story_v_out_111041.awb")

						arg_53_1:RecordAudio("111041013", var_56_13)
						arg_53_1:RecordAudio("111041013", var_56_13)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_111041", "111041013", "story_v_out_111041.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_111041", "111041013", "story_v_out_111041.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_14 = math.max(var_56_5, arg_53_1.talkMaxDuration)

			if var_56_4 <= arg_53_1.time_ and arg_53_1.time_ < var_56_4 + var_56_14 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_4) / var_56_14

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_4 + var_56_14 and arg_53_1.time_ < var_56_4 + var_56_14 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play111041014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 111041014
		arg_57_1.duration_ = 2

		local var_57_0 = {
			ja = 1.1,
			ko = 2,
			zh = 1.266,
			en = 1.333
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
				arg_57_0:Play111041015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["1094ui_story"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect1094ui_story == nil then
				arg_57_1.var_.characterEffect1094ui_story = var_60_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.2

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 and not isNil(var_60_0) then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.characterEffect1094ui_story and not isNil(var_60_0) then
					local var_60_4 = Mathf.Lerp(0, 0.5, var_60_3)

					arg_57_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1094ui_story.fillRatio = var_60_4
				end
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect1094ui_story then
				local var_60_5 = 0.5

				arg_57_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1094ui_story.fillRatio = var_60_5
			end

			local var_60_6 = 0
			local var_60_7 = 0.125

			if var_60_6 < arg_57_1.time_ and arg_57_1.time_ <= var_60_6 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_8 = arg_57_1:FormatText(StoryNameCfg[177].name)

				arg_57_1.leftNameTxt_.text = var_60_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_9 = arg_57_1:GetWordFromCfg(111041014)
				local var_60_10 = arg_57_1:FormatText(var_60_9.content)

				arg_57_1.text_.text = var_60_10

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_11 = 5
				local var_60_12 = utf8.len(var_60_10)
				local var_60_13 = var_60_11 <= 0 and var_60_7 or var_60_7 * (var_60_12 / var_60_11)

				if var_60_13 > 0 and var_60_7 < var_60_13 then
					arg_57_1.talkMaxDuration = var_60_13

					if var_60_13 + var_60_6 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_13 + var_60_6
					end
				end

				arg_57_1.text_.text = var_60_10
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111041", "111041014", "story_v_out_111041.awb") ~= 0 then
					local var_60_14 = manager.audio:GetVoiceLength("story_v_out_111041", "111041014", "story_v_out_111041.awb") / 1000

					if var_60_14 + var_60_6 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_14 + var_60_6
					end

					if var_60_9.prefab_name ~= "" and arg_57_1.actors_[var_60_9.prefab_name] ~= nil then
						local var_60_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_9.prefab_name].transform, "story_v_out_111041", "111041014", "story_v_out_111041.awb")

						arg_57_1:RecordAudio("111041014", var_60_15)
						arg_57_1:RecordAudio("111041014", var_60_15)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_111041", "111041014", "story_v_out_111041.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_111041", "111041014", "story_v_out_111041.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_16 = math.max(var_60_7, arg_57_1.talkMaxDuration)

			if var_60_6 <= arg_57_1.time_ and arg_57_1.time_ < var_60_6 + var_60_16 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_6) / var_60_16

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_6 + var_60_16 and arg_57_1.time_ < var_60_6 + var_60_16 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play111041015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 111041015
		arg_61_1.duration_ = 2

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play111041016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action3_2")
			end

			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_64_2 = arg_61_1.actors_["1094ui_story"]
			local var_64_3 = 0

			if var_64_3 < arg_61_1.time_ and arg_61_1.time_ <= var_64_3 + arg_64_0 and not isNil(var_64_2) and arg_61_1.var_.characterEffect1094ui_story == nil then
				arg_61_1.var_.characterEffect1094ui_story = var_64_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_4 = 0.2

			if var_64_3 <= arg_61_1.time_ and arg_61_1.time_ < var_64_3 + var_64_4 and not isNil(var_64_2) then
				local var_64_5 = (arg_61_1.time_ - var_64_3) / var_64_4

				if arg_61_1.var_.characterEffect1094ui_story and not isNil(var_64_2) then
					arg_61_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= var_64_3 + var_64_4 and arg_61_1.time_ < var_64_3 + var_64_4 + arg_64_0 and not isNil(var_64_2) and arg_61_1.var_.characterEffect1094ui_story then
				arg_61_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_64_6 = 0
			local var_64_7 = 0.075

			if var_64_6 < arg_61_1.time_ and arg_61_1.time_ <= var_64_6 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_8 = arg_61_1:FormatText(StoryNameCfg[181].name)

				arg_61_1.leftNameTxt_.text = var_64_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_9 = arg_61_1:GetWordFromCfg(111041015)
				local var_64_10 = arg_61_1:FormatText(var_64_9.content)

				arg_61_1.text_.text = var_64_10

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_11 = 3
				local var_64_12 = utf8.len(var_64_10)
				local var_64_13 = var_64_11 <= 0 and var_64_7 or var_64_7 * (var_64_12 / var_64_11)

				if var_64_13 > 0 and var_64_7 < var_64_13 then
					arg_61_1.talkMaxDuration = var_64_13

					if var_64_13 + var_64_6 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_13 + var_64_6
					end
				end

				arg_61_1.text_.text = var_64_10
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111041", "111041015", "story_v_out_111041.awb") ~= 0 then
					local var_64_14 = manager.audio:GetVoiceLength("story_v_out_111041", "111041015", "story_v_out_111041.awb") / 1000

					if var_64_14 + var_64_6 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_14 + var_64_6
					end

					if var_64_9.prefab_name ~= "" and arg_61_1.actors_[var_64_9.prefab_name] ~= nil then
						local var_64_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_9.prefab_name].transform, "story_v_out_111041", "111041015", "story_v_out_111041.awb")

						arg_61_1:RecordAudio("111041015", var_64_15)
						arg_61_1:RecordAudio("111041015", var_64_15)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_111041", "111041015", "story_v_out_111041.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_111041", "111041015", "story_v_out_111041.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_16 = math.max(var_64_7, arg_61_1.talkMaxDuration)

			if var_64_6 <= arg_61_1.time_ and arg_61_1.time_ < var_64_6 + var_64_16 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_6) / var_64_16

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_6 + var_64_16 and arg_61_1.time_ < var_64_6 + var_64_16 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play111041016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 111041016
		arg_65_1.duration_ = 8.2

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play111041017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = "D06_1"

			if arg_65_1.bgs_[var_68_0] == nil then
				local var_68_1 = Object.Instantiate(arg_65_1.paintGo_)

				var_68_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_68_0)
				var_68_1.name = var_68_0
				var_68_1.transform.parent = arg_65_1.stage_.transform
				var_68_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_65_1.bgs_[var_68_0] = var_68_1
			end

			local var_68_2 = 1.5

			if var_68_2 < arg_65_1.time_ and arg_65_1.time_ <= var_68_2 + arg_68_0 then
				local var_68_3 = manager.ui.mainCamera.transform.localPosition
				local var_68_4 = Vector3.New(0, 0, 10) + Vector3.New(var_68_3.x, var_68_3.y, 0)
				local var_68_5 = arg_65_1.bgs_.D06_1

				var_68_5.transform.localPosition = var_68_4
				var_68_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_68_6 = var_68_5:GetComponent("SpriteRenderer")

				if var_68_6 and var_68_6.sprite then
					local var_68_7 = (var_68_5.transform.localPosition - var_68_3).z
					local var_68_8 = manager.ui.mainCameraCom_
					local var_68_9 = 2 * var_68_7 * Mathf.Tan(var_68_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_68_10 = var_68_9 * var_68_8.aspect
					local var_68_11 = var_68_6.sprite.bounds.size.x
					local var_68_12 = var_68_6.sprite.bounds.size.y
					local var_68_13 = var_68_10 / var_68_11
					local var_68_14 = var_68_9 / var_68_12
					local var_68_15 = var_68_14 < var_68_13 and var_68_13 or var_68_14

					var_68_5.transform.localScale = Vector3.New(var_68_15, var_68_15, 0)
				end

				for iter_68_0, iter_68_1 in pairs(arg_65_1.bgs_) do
					if iter_68_0 ~= "D06_1" then
						iter_68_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_68_16 = arg_65_1.actors_["1094ui_story"].transform
			local var_68_17 = 0

			if var_68_17 < arg_65_1.time_ and arg_65_1.time_ <= var_68_17 + arg_68_0 then
				arg_65_1.var_.moveOldPos1094ui_story = var_68_16.localPosition
			end

			local var_68_18 = 0.001

			if var_68_17 <= arg_65_1.time_ and arg_65_1.time_ < var_68_17 + var_68_18 then
				local var_68_19 = (arg_65_1.time_ - var_68_17) / var_68_18
				local var_68_20 = Vector3.New(0, 100, 0)

				var_68_16.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1094ui_story, var_68_20, var_68_19)

				local var_68_21 = manager.ui.mainCamera.transform.position - var_68_16.position

				var_68_16.forward = Vector3.New(var_68_21.x, var_68_21.y, var_68_21.z)

				local var_68_22 = var_68_16.localEulerAngles

				var_68_22.z = 0
				var_68_22.x = 0
				var_68_16.localEulerAngles = var_68_22
			end

			if arg_65_1.time_ >= var_68_17 + var_68_18 and arg_65_1.time_ < var_68_17 + var_68_18 + arg_68_0 then
				var_68_16.localPosition = Vector3.New(0, 100, 0)

				local var_68_23 = manager.ui.mainCamera.transform.position - var_68_16.position

				var_68_16.forward = Vector3.New(var_68_23.x, var_68_23.y, var_68_23.z)

				local var_68_24 = var_68_16.localEulerAngles

				var_68_24.z = 0
				var_68_24.x = 0
				var_68_16.localEulerAngles = var_68_24
			end

			local var_68_25 = arg_65_1.bgs_.D06_1
			local var_68_26 = 1.5

			if var_68_26 < arg_65_1.time_ and arg_65_1.time_ <= var_68_26 + arg_68_0 then
				local var_68_27 = var_68_25:GetComponent("SpriteRenderer")

				if var_68_27 then
					arg_65_1.var_.alphaOldValueD06_1 = var_68_27.color.a
					arg_65_1.var_.alphaMatValueD06_1 = var_68_27
				end

				arg_65_1.var_.alphaOldValueD06_1 = 0
			end

			local var_68_28 = 1.5

			if var_68_26 <= arg_65_1.time_ and arg_65_1.time_ < var_68_26 + var_68_28 then
				local var_68_29 = (arg_65_1.time_ - var_68_26) / var_68_28
				local var_68_30 = Mathf.Lerp(arg_65_1.var_.alphaOldValueD06_1, 1, var_68_29)

				if arg_65_1.var_.alphaMatValueD06_1 then
					local var_68_31 = arg_65_1.var_.alphaMatValueD06_1.color

					var_68_31.a = var_68_30
					arg_65_1.var_.alphaMatValueD06_1.color = var_68_31
				end
			end

			if arg_65_1.time_ >= var_68_26 + var_68_28 and arg_65_1.time_ < var_68_26 + var_68_28 + arg_68_0 and arg_65_1.var_.alphaMatValueD06_1 then
				local var_68_32 = arg_65_1.var_.alphaMatValueD06_1
				local var_68_33 = var_68_32.color

				var_68_33.a = 1
				var_68_32.color = var_68_33
			end

			local var_68_34 = arg_65_1.bgs_.D09
			local var_68_35 = 0

			if var_68_35 < arg_65_1.time_ and arg_65_1.time_ <= var_68_35 + arg_68_0 then
				local var_68_36 = var_68_34:GetComponent("SpriteRenderer")

				if var_68_36 then
					arg_65_1.var_.alphaOldValueD09 = var_68_36.color.a
					arg_65_1.var_.alphaMatValueD09 = var_68_36
				end

				arg_65_1.var_.alphaOldValueD09 = 1
			end

			local var_68_37 = 1.5

			if var_68_35 <= arg_65_1.time_ and arg_65_1.time_ < var_68_35 + var_68_37 then
				local var_68_38 = (arg_65_1.time_ - var_68_35) / var_68_37
				local var_68_39 = Mathf.Lerp(arg_65_1.var_.alphaOldValueD09, 0, var_68_38)

				if arg_65_1.var_.alphaMatValueD09 then
					local var_68_40 = arg_65_1.var_.alphaMatValueD09.color

					var_68_40.a = var_68_39
					arg_65_1.var_.alphaMatValueD09.color = var_68_40
				end
			end

			if arg_65_1.time_ >= var_68_35 + var_68_37 and arg_65_1.time_ < var_68_35 + var_68_37 + arg_68_0 and arg_65_1.var_.alphaMatValueD09 then
				local var_68_41 = arg_65_1.var_.alphaMatValueD09
				local var_68_42 = var_68_41.color

				var_68_42.a = 0
				var_68_41.color = var_68_42
			end

			local var_68_43 = 0

			if var_68_43 < arg_65_1.time_ and arg_65_1.time_ <= var_68_43 + arg_68_0 then
				arg_65_1.allBtn_.enabled = false
			end

			local var_68_44 = 3.2

			if arg_65_1.time_ >= var_68_43 + var_68_44 and arg_65_1.time_ < var_68_43 + var_68_44 + arg_68_0 then
				arg_65_1.allBtn_.enabled = true
			end

			local var_68_45 = 0
			local var_68_46 = 1

			if var_68_45 < arg_65_1.time_ and arg_65_1.time_ <= var_68_45 + arg_68_0 then
				local var_68_47 = "play"
				local var_68_48 = "effect"

				arg_65_1:AudioAction(var_68_47, var_68_48, "se_story", "se_story_crowdloop", "")
			end

			if arg_65_1.frameCnt_ <= 1 then
				arg_65_1.dialog_:SetActive(false)
			end

			local var_68_49 = 3.2
			local var_68_50 = 0.85

			if var_68_49 < arg_65_1.time_ and arg_65_1.time_ <= var_68_49 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0

				arg_65_1.dialog_:SetActive(true)

				arg_65_1.dialogCg_.alpha = 0

				local var_68_51 = LeanTween.value(arg_65_1.dialog_, 0, 1, 0.3)

				var_68_51:setOnUpdate(LuaHelper.FloatAction(function(arg_69_0)
					arg_65_1.dialogCg_.alpha = arg_69_0
				end))
				var_68_51:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_65_1.dialog_)
					var_68_51:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_65_1.duration_ = arg_65_1.duration_ + 0.3

				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_52 = arg_65_1:GetWordFromCfg(111041016)
				local var_68_53 = arg_65_1:FormatText(var_68_52.content)

				arg_65_1.text_.text = var_68_53

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_54 = 34
				local var_68_55 = utf8.len(var_68_53)
				local var_68_56 = var_68_54 <= 0 and var_68_50 or var_68_50 * (var_68_55 / var_68_54)

				if var_68_56 > 0 and var_68_50 < var_68_56 then
					arg_65_1.talkMaxDuration = var_68_56
					var_68_49 = var_68_49 + 0.3

					if var_68_56 + var_68_49 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_56 + var_68_49
					end
				end

				arg_65_1.text_.text = var_68_53
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_57 = var_68_49 + 0.3
			local var_68_58 = math.max(var_68_50, arg_65_1.talkMaxDuration)

			if var_68_57 <= arg_65_1.time_ and arg_65_1.time_ < var_68_57 + var_68_58 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_57) / var_68_58

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_57 + var_68_58 and arg_65_1.time_ < var_68_57 + var_68_58 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
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

		arg_65_1:InitPlayNodeList()
	end,
	Play111041017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 111041017
		arg_71_1.duration_ = 3.7

		local var_71_0 = {
			ja = 3.333,
			ko = 2.966,
			zh = 3.5,
			en = 3.7
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
				arg_71_0:Play111041018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = "1084ui_story"

			if arg_71_1.actors_[var_74_0] == nil then
				local var_74_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_74_1) then
					local var_74_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_71_1.stage_.transform)

					var_74_2.name = var_74_0
					var_74_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_71_1.actors_[var_74_0] = var_74_2

					local var_74_3 = var_74_2:GetComponentInChildren(typeof(CharacterEffect))

					var_74_3.enabled = true

					local var_74_4 = GameObjectTools.GetOrAddComponent(var_74_2, typeof(DynamicBoneHelper))

					if var_74_4 then
						var_74_4:EnableDynamicBone(false)
					end

					arg_71_1:ShowWeapon(var_74_3.transform, false)

					arg_71_1.var_[var_74_0 .. "Animator"] = var_74_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_71_1.var_[var_74_0 .. "Animator"].applyRootMotion = true
					arg_71_1.var_[var_74_0 .. "LipSync"] = var_74_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_74_5 = arg_71_1.actors_["1084ui_story"].transform
			local var_74_6 = 0

			if var_74_6 < arg_71_1.time_ and arg_71_1.time_ <= var_74_6 + arg_74_0 then
				arg_71_1.var_.moveOldPos1084ui_story = var_74_5.localPosition
			end

			local var_74_7 = 0.001

			if var_74_6 <= arg_71_1.time_ and arg_71_1.time_ < var_74_6 + var_74_7 then
				local var_74_8 = (arg_71_1.time_ - var_74_6) / var_74_7
				local var_74_9 = Vector3.New(-0.7, -0.97, -6)

				var_74_5.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1084ui_story, var_74_9, var_74_8)

				local var_74_10 = manager.ui.mainCamera.transform.position - var_74_5.position

				var_74_5.forward = Vector3.New(var_74_10.x, var_74_10.y, var_74_10.z)

				local var_74_11 = var_74_5.localEulerAngles

				var_74_11.z = 0
				var_74_11.x = 0
				var_74_5.localEulerAngles = var_74_11
			end

			if arg_71_1.time_ >= var_74_6 + var_74_7 and arg_71_1.time_ < var_74_6 + var_74_7 + arg_74_0 then
				var_74_5.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_74_12 = manager.ui.mainCamera.transform.position - var_74_5.position

				var_74_5.forward = Vector3.New(var_74_12.x, var_74_12.y, var_74_12.z)

				local var_74_13 = var_74_5.localEulerAngles

				var_74_13.z = 0
				var_74_13.x = 0
				var_74_5.localEulerAngles = var_74_13
			end

			local var_74_14 = 0

			if var_74_14 < arg_71_1.time_ and arg_71_1.time_ <= var_74_14 + arg_74_0 then
				arg_71_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_74_15 = 0

			if var_74_15 < arg_71_1.time_ and arg_71_1.time_ <= var_74_15 + arg_74_0 then
				arg_71_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_74_16 = arg_71_1.actors_["1084ui_story"]
			local var_74_17 = 0

			if var_74_17 < arg_71_1.time_ and arg_71_1.time_ <= var_74_17 + arg_74_0 and not isNil(var_74_16) and arg_71_1.var_.characterEffect1084ui_story == nil then
				arg_71_1.var_.characterEffect1084ui_story = var_74_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_18 = 0.2

			if var_74_17 <= arg_71_1.time_ and arg_71_1.time_ < var_74_17 + var_74_18 and not isNil(var_74_16) then
				local var_74_19 = (arg_71_1.time_ - var_74_17) / var_74_18

				if arg_71_1.var_.characterEffect1084ui_story and not isNil(var_74_16) then
					arg_71_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= var_74_17 + var_74_18 and arg_71_1.time_ < var_74_17 + var_74_18 + arg_74_0 and not isNil(var_74_16) and arg_71_1.var_.characterEffect1084ui_story then
				arg_71_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_74_20 = 0
			local var_74_21 = 0.3

			if var_74_20 < arg_71_1.time_ and arg_71_1.time_ <= var_74_20 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_22 = arg_71_1:FormatText(StoryNameCfg[6].name)

				arg_71_1.leftNameTxt_.text = var_74_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_23 = arg_71_1:GetWordFromCfg(111041017)
				local var_74_24 = arg_71_1:FormatText(var_74_23.content)

				arg_71_1.text_.text = var_74_24

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_25 = 13
				local var_74_26 = utf8.len(var_74_24)
				local var_74_27 = var_74_25 <= 0 and var_74_21 or var_74_21 * (var_74_26 / var_74_25)

				if var_74_27 > 0 and var_74_21 < var_74_27 then
					arg_71_1.talkMaxDuration = var_74_27

					if var_74_27 + var_74_20 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_27 + var_74_20
					end
				end

				arg_71_1.text_.text = var_74_24
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111041", "111041017", "story_v_out_111041.awb") ~= 0 then
					local var_74_28 = manager.audio:GetVoiceLength("story_v_out_111041", "111041017", "story_v_out_111041.awb") / 1000

					if var_74_28 + var_74_20 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_28 + var_74_20
					end

					if var_74_23.prefab_name ~= "" and arg_71_1.actors_[var_74_23.prefab_name] ~= nil then
						local var_74_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_23.prefab_name].transform, "story_v_out_111041", "111041017", "story_v_out_111041.awb")

						arg_71_1:RecordAudio("111041017", var_74_29)
						arg_71_1:RecordAudio("111041017", var_74_29)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_111041", "111041017", "story_v_out_111041.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_111041", "111041017", "story_v_out_111041.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_30 = math.max(var_74_21, arg_71_1.talkMaxDuration)

			if var_74_20 <= arg_71_1.time_ and arg_71_1.time_ < var_74_20 + var_74_30 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_20) / var_74_30

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_20 + var_74_30 and arg_71_1.time_ < var_74_20 + var_74_30 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
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
	Play111041018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 111041018
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play111041019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = arg_75_1.actors_["1084ui_story"]
			local var_78_1 = 0

			if var_78_1 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 and not isNil(var_78_0) and arg_75_1.var_.characterEffect1084ui_story == nil then
				arg_75_1.var_.characterEffect1084ui_story = var_78_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_2 = 0.2

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_2 and not isNil(var_78_0) then
				local var_78_3 = (arg_75_1.time_ - var_78_1) / var_78_2

				if arg_75_1.var_.characterEffect1084ui_story and not isNil(var_78_0) then
					local var_78_4 = Mathf.Lerp(0, 0.5, var_78_3)

					arg_75_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_75_1.var_.characterEffect1084ui_story.fillRatio = var_78_4
				end
			end

			if arg_75_1.time_ >= var_78_1 + var_78_2 and arg_75_1.time_ < var_78_1 + var_78_2 + arg_78_0 and not isNil(var_78_0) and arg_75_1.var_.characterEffect1084ui_story then
				local var_78_5 = 0.5

				arg_75_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_75_1.var_.characterEffect1084ui_story.fillRatio = var_78_5
			end

			local var_78_6 = 0
			local var_78_7 = 0.525

			if var_78_6 < arg_75_1.time_ and arg_75_1.time_ <= var_78_6 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_8 = arg_75_1:FormatText(StoryNameCfg[7].name)

				arg_75_1.leftNameTxt_.text = var_78_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, true)
				arg_75_1.iconController_:SetSelectedState("hero")

				arg_75_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_75_1.callingController_:SetSelectedState("normal")

				arg_75_1.keyicon_.color = Color.New(1, 1, 1)
				arg_75_1.icon_.color = Color.New(1, 1, 1)

				local var_78_9 = arg_75_1:GetWordFromCfg(111041018)
				local var_78_10 = arg_75_1:FormatText(var_78_9.content)

				arg_75_1.text_.text = var_78_10

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_11 = 21
				local var_78_12 = utf8.len(var_78_10)
				local var_78_13 = var_78_11 <= 0 and var_78_7 or var_78_7 * (var_78_12 / var_78_11)

				if var_78_13 > 0 and var_78_7 < var_78_13 then
					arg_75_1.talkMaxDuration = var_78_13

					if var_78_13 + var_78_6 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_13 + var_78_6
					end
				end

				arg_75_1.text_.text = var_78_10
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_14 = math.max(var_78_7, arg_75_1.talkMaxDuration)

			if var_78_6 <= arg_75_1.time_ and arg_75_1.time_ < var_78_6 + var_78_14 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_6) / var_78_14

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_6 + var_78_14 and arg_75_1.time_ < var_78_6 + var_78_14 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play111041019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 111041019
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play111041020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0
			local var_82_1 = 0.85

			if var_82_0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_2 = arg_79_1:FormatText(StoryNameCfg[7].name)

				arg_79_1.leftNameTxt_.text = var_82_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, true)
				arg_79_1.iconController_:SetSelectedState("hero")

				arg_79_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_79_1.callingController_:SetSelectedState("normal")

				arg_79_1.keyicon_.color = Color.New(1, 1, 1)
				arg_79_1.icon_.color = Color.New(1, 1, 1)

				local var_82_3 = arg_79_1:GetWordFromCfg(111041019)
				local var_82_4 = arg_79_1:FormatText(var_82_3.content)

				arg_79_1.text_.text = var_82_4

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_5 = 34
				local var_82_6 = utf8.len(var_82_4)
				local var_82_7 = var_82_5 <= 0 and var_82_1 or var_82_1 * (var_82_6 / var_82_5)

				if var_82_7 > 0 and var_82_1 < var_82_7 then
					arg_79_1.talkMaxDuration = var_82_7

					if var_82_7 + var_82_0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_7 + var_82_0
					end
				end

				arg_79_1.text_.text = var_82_4
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_8 = math.max(var_82_1, arg_79_1.talkMaxDuration)

			if var_82_0 <= arg_79_1.time_ and arg_79_1.time_ < var_82_0 + var_82_8 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_0) / var_82_8

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_0 + var_82_8 and arg_79_1.time_ < var_82_0 + var_82_8 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play111041020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 111041020
		arg_83_1.duration_ = 4.97

		local var_83_0 = {
			ja = 3.4,
			ko = 3.966,
			zh = 3.933,
			en = 4.966
		}
		local var_83_1 = manager.audio:GetLocalizationFlag()

		if var_83_0[var_83_1] ~= nil then
			arg_83_1.duration_ = var_83_0[var_83_1]
		end

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play111041021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = "1048ui_story"

			if arg_83_1.actors_[var_86_0] == nil then
				local var_86_1 = Asset.Load("Char/" .. "1048ui_story")

				if not isNil(var_86_1) then
					local var_86_2 = Object.Instantiate(Asset.Load("Char/" .. "1048ui_story"), arg_83_1.stage_.transform)

					var_86_2.name = var_86_0
					var_86_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_83_1.actors_[var_86_0] = var_86_2

					local var_86_3 = var_86_2:GetComponentInChildren(typeof(CharacterEffect))

					var_86_3.enabled = true

					local var_86_4 = GameObjectTools.GetOrAddComponent(var_86_2, typeof(DynamicBoneHelper))

					if var_86_4 then
						var_86_4:EnableDynamicBone(false)
					end

					arg_83_1:ShowWeapon(var_86_3.transform, false)

					arg_83_1.var_[var_86_0 .. "Animator"] = var_86_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_83_1.var_[var_86_0 .. "Animator"].applyRootMotion = true
					arg_83_1.var_[var_86_0 .. "LipSync"] = var_86_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_86_5 = arg_83_1.actors_["1048ui_story"].transform
			local var_86_6 = 0

			if var_86_6 < arg_83_1.time_ and arg_83_1.time_ <= var_86_6 + arg_86_0 then
				arg_83_1.var_.moveOldPos1048ui_story = var_86_5.localPosition
			end

			local var_86_7 = 0.001

			if var_86_6 <= arg_83_1.time_ and arg_83_1.time_ < var_86_6 + var_86_7 then
				local var_86_8 = (arg_83_1.time_ - var_86_6) / var_86_7
				local var_86_9 = Vector3.New(0.7, -0.8, -6.2)

				var_86_5.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1048ui_story, var_86_9, var_86_8)

				local var_86_10 = manager.ui.mainCamera.transform.position - var_86_5.position

				var_86_5.forward = Vector3.New(var_86_10.x, var_86_10.y, var_86_10.z)

				local var_86_11 = var_86_5.localEulerAngles

				var_86_11.z = 0
				var_86_11.x = 0
				var_86_5.localEulerAngles = var_86_11
			end

			if arg_83_1.time_ >= var_86_6 + var_86_7 and arg_83_1.time_ < var_86_6 + var_86_7 + arg_86_0 then
				var_86_5.localPosition = Vector3.New(0.7, -0.8, -6.2)

				local var_86_12 = manager.ui.mainCamera.transform.position - var_86_5.position

				var_86_5.forward = Vector3.New(var_86_12.x, var_86_12.y, var_86_12.z)

				local var_86_13 = var_86_5.localEulerAngles

				var_86_13.z = 0
				var_86_13.x = 0
				var_86_5.localEulerAngles = var_86_13
			end

			local var_86_14 = 0

			if var_86_14 < arg_83_1.time_ and arg_83_1.time_ <= var_86_14 + arg_86_0 then
				arg_83_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048action/1048action5_1")
			end

			local var_86_15 = 0

			if var_86_15 < arg_83_1.time_ and arg_83_1.time_ <= var_86_15 + arg_86_0 then
				arg_83_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_86_16 = arg_83_1.actors_["1048ui_story"]
			local var_86_17 = 0

			if var_86_17 < arg_83_1.time_ and arg_83_1.time_ <= var_86_17 + arg_86_0 and not isNil(var_86_16) and arg_83_1.var_.characterEffect1048ui_story == nil then
				arg_83_1.var_.characterEffect1048ui_story = var_86_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_18 = 0.2

			if var_86_17 <= arg_83_1.time_ and arg_83_1.time_ < var_86_17 + var_86_18 and not isNil(var_86_16) then
				local var_86_19 = (arg_83_1.time_ - var_86_17) / var_86_18

				if arg_83_1.var_.characterEffect1048ui_story and not isNil(var_86_16) then
					arg_83_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_83_1.time_ >= var_86_17 + var_86_18 and arg_83_1.time_ < var_86_17 + var_86_18 + arg_86_0 and not isNil(var_86_16) and arg_83_1.var_.characterEffect1048ui_story then
				arg_83_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			local var_86_20 = 0
			local var_86_21 = 0.325

			if var_86_20 < arg_83_1.time_ and arg_83_1.time_ <= var_86_20 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_22 = arg_83_1:FormatText(StoryNameCfg[8].name)

				arg_83_1.leftNameTxt_.text = var_86_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_23 = arg_83_1:GetWordFromCfg(111041020)
				local var_86_24 = arg_83_1:FormatText(var_86_23.content)

				arg_83_1.text_.text = var_86_24

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_25 = 13
				local var_86_26 = utf8.len(var_86_24)
				local var_86_27 = var_86_25 <= 0 and var_86_21 or var_86_21 * (var_86_26 / var_86_25)

				if var_86_27 > 0 and var_86_21 < var_86_27 then
					arg_83_1.talkMaxDuration = var_86_27

					if var_86_27 + var_86_20 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_27 + var_86_20
					end
				end

				arg_83_1.text_.text = var_86_24
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111041", "111041020", "story_v_out_111041.awb") ~= 0 then
					local var_86_28 = manager.audio:GetVoiceLength("story_v_out_111041", "111041020", "story_v_out_111041.awb") / 1000

					if var_86_28 + var_86_20 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_28 + var_86_20
					end

					if var_86_23.prefab_name ~= "" and arg_83_1.actors_[var_86_23.prefab_name] ~= nil then
						local var_86_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_23.prefab_name].transform, "story_v_out_111041", "111041020", "story_v_out_111041.awb")

						arg_83_1:RecordAudio("111041020", var_86_29)
						arg_83_1:RecordAudio("111041020", var_86_29)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_111041", "111041020", "story_v_out_111041.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_111041", "111041020", "story_v_out_111041.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_30 = math.max(var_86_21, arg_83_1.talkMaxDuration)

			if var_86_20 <= arg_83_1.time_ and arg_83_1.time_ < var_86_20 + var_86_30 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_20) / var_86_30

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_20 + var_86_30 and arg_83_1.time_ < var_86_20 + var_86_30 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_83_1:InitPlayNodeList()
	end,
	Play111041021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 111041021
		arg_87_1.duration_ = 8.87

		local var_87_0 = {
			ja = 8.866,
			ko = 5.833,
			zh = 5.533,
			en = 4.733
		}
		local var_87_1 = manager.audio:GetLocalizationFlag()

		if var_87_0[var_87_1] ~= nil then
			arg_87_1.duration_ = var_87_0[var_87_1]
		end

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play111041022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = "1039ui_story"

			if arg_87_1.actors_[var_90_0] == nil then
				local var_90_1 = Asset.Load("Char/" .. "1039ui_story")

				if not isNil(var_90_1) then
					local var_90_2 = Object.Instantiate(Asset.Load("Char/" .. "1039ui_story"), arg_87_1.stage_.transform)

					var_90_2.name = var_90_0
					var_90_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_87_1.actors_[var_90_0] = var_90_2

					local var_90_3 = var_90_2:GetComponentInChildren(typeof(CharacterEffect))

					var_90_3.enabled = true

					local var_90_4 = GameObjectTools.GetOrAddComponent(var_90_2, typeof(DynamicBoneHelper))

					if var_90_4 then
						var_90_4:EnableDynamicBone(false)
					end

					arg_87_1:ShowWeapon(var_90_3.transform, false)

					arg_87_1.var_[var_90_0 .. "Animator"] = var_90_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_87_1.var_[var_90_0 .. "Animator"].applyRootMotion = true
					arg_87_1.var_[var_90_0 .. "LipSync"] = var_90_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_90_5 = arg_87_1.actors_["1039ui_story"]
			local var_90_6 = 0

			if var_90_6 < arg_87_1.time_ and arg_87_1.time_ <= var_90_6 + arg_90_0 and not isNil(var_90_5) and arg_87_1.var_.characterEffect1039ui_story == nil then
				arg_87_1.var_.characterEffect1039ui_story = var_90_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_7 = 0.2

			if var_90_6 <= arg_87_1.time_ and arg_87_1.time_ < var_90_6 + var_90_7 and not isNil(var_90_5) then
				local var_90_8 = (arg_87_1.time_ - var_90_6) / var_90_7

				if arg_87_1.var_.characterEffect1039ui_story and not isNil(var_90_5) then
					arg_87_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= var_90_6 + var_90_7 and arg_87_1.time_ < var_90_6 + var_90_7 + arg_90_0 and not isNil(var_90_5) and arg_87_1.var_.characterEffect1039ui_story then
				arg_87_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_90_9 = arg_87_1.actors_["1048ui_story"]
			local var_90_10 = 0

			if var_90_10 < arg_87_1.time_ and arg_87_1.time_ <= var_90_10 + arg_90_0 and not isNil(var_90_9) and arg_87_1.var_.characterEffect1048ui_story == nil then
				arg_87_1.var_.characterEffect1048ui_story = var_90_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_11 = 0.2

			if var_90_10 <= arg_87_1.time_ and arg_87_1.time_ < var_90_10 + var_90_11 and not isNil(var_90_9) then
				local var_90_12 = (arg_87_1.time_ - var_90_10) / var_90_11

				if arg_87_1.var_.characterEffect1048ui_story and not isNil(var_90_9) then
					local var_90_13 = Mathf.Lerp(0, 0.5, var_90_12)

					arg_87_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_87_1.var_.characterEffect1048ui_story.fillRatio = var_90_13
				end
			end

			if arg_87_1.time_ >= var_90_10 + var_90_11 and arg_87_1.time_ < var_90_10 + var_90_11 + arg_90_0 and not isNil(var_90_9) and arg_87_1.var_.characterEffect1048ui_story then
				local var_90_14 = 0.5

				arg_87_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_87_1.var_.characterEffect1048ui_story.fillRatio = var_90_14
			end

			local var_90_15 = arg_87_1.actors_["1039ui_story"].transform
			local var_90_16 = 0

			if var_90_16 < arg_87_1.time_ and arg_87_1.time_ <= var_90_16 + arg_90_0 then
				arg_87_1.var_.moveOldPos1039ui_story = var_90_15.localPosition
			end

			local var_90_17 = 0.001

			if var_90_16 <= arg_87_1.time_ and arg_87_1.time_ < var_90_16 + var_90_17 then
				local var_90_18 = (arg_87_1.time_ - var_90_16) / var_90_17
				local var_90_19 = Vector3.New(0, -1.01, -5.9)

				var_90_15.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1039ui_story, var_90_19, var_90_18)

				local var_90_20 = manager.ui.mainCamera.transform.position - var_90_15.position

				var_90_15.forward = Vector3.New(var_90_20.x, var_90_20.y, var_90_20.z)

				local var_90_21 = var_90_15.localEulerAngles

				var_90_21.z = 0
				var_90_21.x = 0
				var_90_15.localEulerAngles = var_90_21
			end

			if arg_87_1.time_ >= var_90_16 + var_90_17 and arg_87_1.time_ < var_90_16 + var_90_17 + arg_90_0 then
				var_90_15.localPosition = Vector3.New(0, -1.01, -5.9)

				local var_90_22 = manager.ui.mainCamera.transform.position - var_90_15.position

				var_90_15.forward = Vector3.New(var_90_22.x, var_90_22.y, var_90_22.z)

				local var_90_23 = var_90_15.localEulerAngles

				var_90_23.z = 0
				var_90_23.x = 0
				var_90_15.localEulerAngles = var_90_23
			end

			local var_90_24 = 0

			if var_90_24 < arg_87_1.time_ and arg_87_1.time_ <= var_90_24 + arg_90_0 then
				arg_87_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action4_1")
			end

			local var_90_25 = 0

			if var_90_25 < arg_87_1.time_ and arg_87_1.time_ <= var_90_25 + arg_90_0 then
				arg_87_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_90_26 = 0
			local var_90_27 = 0.675

			if var_90_26 < arg_87_1.time_ and arg_87_1.time_ <= var_90_26 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_28 = arg_87_1:FormatText(StoryNameCfg[9].name)

				arg_87_1.leftNameTxt_.text = var_90_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_29 = arg_87_1:GetWordFromCfg(111041021)
				local var_90_30 = arg_87_1:FormatText(var_90_29.content)

				arg_87_1.text_.text = var_90_30

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_31 = 27
				local var_90_32 = utf8.len(var_90_30)
				local var_90_33 = var_90_31 <= 0 and var_90_27 or var_90_27 * (var_90_32 / var_90_31)

				if var_90_33 > 0 and var_90_27 < var_90_33 then
					arg_87_1.talkMaxDuration = var_90_33

					if var_90_33 + var_90_26 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_33 + var_90_26
					end
				end

				arg_87_1.text_.text = var_90_30
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111041", "111041021", "story_v_out_111041.awb") ~= 0 then
					local var_90_34 = manager.audio:GetVoiceLength("story_v_out_111041", "111041021", "story_v_out_111041.awb") / 1000

					if var_90_34 + var_90_26 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_34 + var_90_26
					end

					if var_90_29.prefab_name ~= "" and arg_87_1.actors_[var_90_29.prefab_name] ~= nil then
						local var_90_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_29.prefab_name].transform, "story_v_out_111041", "111041021", "story_v_out_111041.awb")

						arg_87_1:RecordAudio("111041021", var_90_35)
						arg_87_1:RecordAudio("111041021", var_90_35)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_111041", "111041021", "story_v_out_111041.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_111041", "111041021", "story_v_out_111041.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_36 = math.max(var_90_27, arg_87_1.talkMaxDuration)

			if var_90_26 <= arg_87_1.time_ and arg_87_1.time_ < var_90_26 + var_90_36 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_26) / var_90_36

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_26 + var_90_36 and arg_87_1.time_ < var_90_26 + var_90_36 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_87_1:InitPlayNodeList()
	end,
	Play111041022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 111041022
		arg_91_1.duration_ = 8.2

		local var_91_0 = {
			ja = 8.2,
			ko = 7.433,
			zh = 5.8,
			en = 6.9
		}
		local var_91_1 = manager.audio:GetLocalizationFlag()

		if var_91_0[var_91_1] ~= nil then
			arg_91_1.duration_ = var_91_0[var_91_1]
		end

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play111041023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 0

			if var_94_0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_0 + arg_94_0 then
				arg_91_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_94_1 = 0
			local var_94_2 = 0.7

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_3 = arg_91_1:FormatText(StoryNameCfg[9].name)

				arg_91_1.leftNameTxt_.text = var_94_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_4 = arg_91_1:GetWordFromCfg(111041022)
				local var_94_5 = arg_91_1:FormatText(var_94_4.content)

				arg_91_1.text_.text = var_94_5

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_6 = 28
				local var_94_7 = utf8.len(var_94_5)
				local var_94_8 = var_94_6 <= 0 and var_94_2 or var_94_2 * (var_94_7 / var_94_6)

				if var_94_8 > 0 and var_94_2 < var_94_8 then
					arg_91_1.talkMaxDuration = var_94_8

					if var_94_8 + var_94_1 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_8 + var_94_1
					end
				end

				arg_91_1.text_.text = var_94_5
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111041", "111041022", "story_v_out_111041.awb") ~= 0 then
					local var_94_9 = manager.audio:GetVoiceLength("story_v_out_111041", "111041022", "story_v_out_111041.awb") / 1000

					if var_94_9 + var_94_1 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_9 + var_94_1
					end

					if var_94_4.prefab_name ~= "" and arg_91_1.actors_[var_94_4.prefab_name] ~= nil then
						local var_94_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_4.prefab_name].transform, "story_v_out_111041", "111041022", "story_v_out_111041.awb")

						arg_91_1:RecordAudio("111041022", var_94_10)
						arg_91_1:RecordAudio("111041022", var_94_10)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_111041", "111041022", "story_v_out_111041.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_111041", "111041022", "story_v_out_111041.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_11 = math.max(var_94_2, arg_91_1.talkMaxDuration)

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_11 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_1) / var_94_11

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_1 + var_94_11 and arg_91_1.time_ < var_94_1 + var_94_11 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play111041023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 111041023
		arg_95_1.duration_ = 8.03

		local var_95_0 = {
			ja = 8.033,
			ko = 5.1,
			zh = 6.8,
			en = 7.9
		}
		local var_95_1 = manager.audio:GetLocalizationFlag()

		if var_95_0[var_95_1] ~= nil then
			arg_95_1.duration_ = var_95_0[var_95_1]
		end

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play111041024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 0

			if var_98_0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_0 + arg_98_0 then
				arg_95_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048actionlink/1048action456")
			end

			local var_98_1 = 0

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 then
				arg_95_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_98_2 = arg_95_1.actors_["1048ui_story"]
			local var_98_3 = 0

			if var_98_3 < arg_95_1.time_ and arg_95_1.time_ <= var_98_3 + arg_98_0 and not isNil(var_98_2) and arg_95_1.var_.characterEffect1048ui_story == nil then
				arg_95_1.var_.characterEffect1048ui_story = var_98_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_4 = 0.2

			if var_98_3 <= arg_95_1.time_ and arg_95_1.time_ < var_98_3 + var_98_4 and not isNil(var_98_2) then
				local var_98_5 = (arg_95_1.time_ - var_98_3) / var_98_4

				if arg_95_1.var_.characterEffect1048ui_story and not isNil(var_98_2) then
					arg_95_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= var_98_3 + var_98_4 and arg_95_1.time_ < var_98_3 + var_98_4 + arg_98_0 and not isNil(var_98_2) and arg_95_1.var_.characterEffect1048ui_story then
				arg_95_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			local var_98_6 = arg_95_1.actors_["1039ui_story"]
			local var_98_7 = 0

			if var_98_7 < arg_95_1.time_ and arg_95_1.time_ <= var_98_7 + arg_98_0 and not isNil(var_98_6) and arg_95_1.var_.characterEffect1039ui_story == nil then
				arg_95_1.var_.characterEffect1039ui_story = var_98_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_8 = 0.2

			if var_98_7 <= arg_95_1.time_ and arg_95_1.time_ < var_98_7 + var_98_8 and not isNil(var_98_6) then
				local var_98_9 = (arg_95_1.time_ - var_98_7) / var_98_8

				if arg_95_1.var_.characterEffect1039ui_story and not isNil(var_98_6) then
					local var_98_10 = Mathf.Lerp(0, 0.5, var_98_9)

					arg_95_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_95_1.var_.characterEffect1039ui_story.fillRatio = var_98_10
				end
			end

			if arg_95_1.time_ >= var_98_7 + var_98_8 and arg_95_1.time_ < var_98_7 + var_98_8 + arg_98_0 and not isNil(var_98_6) and arg_95_1.var_.characterEffect1039ui_story then
				local var_98_11 = 0.5

				arg_95_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_95_1.var_.characterEffect1039ui_story.fillRatio = var_98_11
			end

			local var_98_12 = 0
			local var_98_13 = 0.675

			if var_98_12 < arg_95_1.time_ and arg_95_1.time_ <= var_98_12 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_14 = arg_95_1:FormatText(StoryNameCfg[8].name)

				arg_95_1.leftNameTxt_.text = var_98_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_15 = arg_95_1:GetWordFromCfg(111041023)
				local var_98_16 = arg_95_1:FormatText(var_98_15.content)

				arg_95_1.text_.text = var_98_16

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_17 = 27
				local var_98_18 = utf8.len(var_98_16)
				local var_98_19 = var_98_17 <= 0 and var_98_13 or var_98_13 * (var_98_18 / var_98_17)

				if var_98_19 > 0 and var_98_13 < var_98_19 then
					arg_95_1.talkMaxDuration = var_98_19

					if var_98_19 + var_98_12 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_19 + var_98_12
					end
				end

				arg_95_1.text_.text = var_98_16
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111041", "111041023", "story_v_out_111041.awb") ~= 0 then
					local var_98_20 = manager.audio:GetVoiceLength("story_v_out_111041", "111041023", "story_v_out_111041.awb") / 1000

					if var_98_20 + var_98_12 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_20 + var_98_12
					end

					if var_98_15.prefab_name ~= "" and arg_95_1.actors_[var_98_15.prefab_name] ~= nil then
						local var_98_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_15.prefab_name].transform, "story_v_out_111041", "111041023", "story_v_out_111041.awb")

						arg_95_1:RecordAudio("111041023", var_98_21)
						arg_95_1:RecordAudio("111041023", var_98_21)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_111041", "111041023", "story_v_out_111041.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_111041", "111041023", "story_v_out_111041.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_22 = math.max(var_98_13, arg_95_1.talkMaxDuration)

			if var_98_12 <= arg_95_1.time_ and arg_95_1.time_ < var_98_12 + var_98_22 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_12) / var_98_22

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_12 + var_98_22 and arg_95_1.time_ < var_98_12 + var_98_22 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play111041024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 111041024
		arg_99_1.duration_ = 5.57

		local var_99_0 = {
			ja = 5.566,
			ko = 4.9,
			zh = 3.633,
			en = 4.3
		}
		local var_99_1 = manager.audio:GetLocalizationFlag()

		if var_99_0[var_99_1] ~= nil then
			arg_99_1.duration_ = var_99_0[var_99_1]
		end

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play111041025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0

			if var_102_0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_0 + arg_102_0 then
				arg_99_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			local var_102_1 = 0

			if var_102_1 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 then
				arg_99_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2204cva")
			end

			local var_102_2 = arg_99_1.actors_["1084ui_story"]
			local var_102_3 = 0

			if var_102_3 < arg_99_1.time_ and arg_99_1.time_ <= var_102_3 + arg_102_0 and not isNil(var_102_2) and arg_99_1.var_.characterEffect1084ui_story == nil then
				arg_99_1.var_.characterEffect1084ui_story = var_102_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_4 = 0.2

			if var_102_3 <= arg_99_1.time_ and arg_99_1.time_ < var_102_3 + var_102_4 and not isNil(var_102_2) then
				local var_102_5 = (arg_99_1.time_ - var_102_3) / var_102_4

				if arg_99_1.var_.characterEffect1084ui_story and not isNil(var_102_2) then
					arg_99_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_99_1.time_ >= var_102_3 + var_102_4 and arg_99_1.time_ < var_102_3 + var_102_4 + arg_102_0 and not isNil(var_102_2) and arg_99_1.var_.characterEffect1084ui_story then
				arg_99_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_102_6 = arg_99_1.actors_["1048ui_story"]
			local var_102_7 = 0

			if var_102_7 < arg_99_1.time_ and arg_99_1.time_ <= var_102_7 + arg_102_0 and not isNil(var_102_6) and arg_99_1.var_.characterEffect1048ui_story == nil then
				arg_99_1.var_.characterEffect1048ui_story = var_102_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_8 = 0.2

			if var_102_7 <= arg_99_1.time_ and arg_99_1.time_ < var_102_7 + var_102_8 and not isNil(var_102_6) then
				local var_102_9 = (arg_99_1.time_ - var_102_7) / var_102_8

				if arg_99_1.var_.characterEffect1048ui_story and not isNil(var_102_6) then
					local var_102_10 = Mathf.Lerp(0, 0.5, var_102_9)

					arg_99_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_99_1.var_.characterEffect1048ui_story.fillRatio = var_102_10
				end
			end

			if arg_99_1.time_ >= var_102_7 + var_102_8 and arg_99_1.time_ < var_102_7 + var_102_8 + arg_102_0 and not isNil(var_102_6) and arg_99_1.var_.characterEffect1048ui_story then
				local var_102_11 = 0.5

				arg_99_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_99_1.var_.characterEffect1048ui_story.fillRatio = var_102_11
			end

			local var_102_12 = 0

			if var_102_12 < arg_99_1.time_ and arg_99_1.time_ <= var_102_12 + arg_102_0 then
				arg_99_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_102_13 = 0

			if var_102_13 < arg_99_1.time_ and arg_99_1.time_ <= var_102_13 + arg_102_0 then
				arg_99_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048action/1048action6_2")
			end

			local var_102_14 = 0
			local var_102_15 = 0.45

			if var_102_14 < arg_99_1.time_ and arg_99_1.time_ <= var_102_14 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_16 = arg_99_1:FormatText(StoryNameCfg[6].name)

				arg_99_1.leftNameTxt_.text = var_102_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_17 = arg_99_1:GetWordFromCfg(111041024)
				local var_102_18 = arg_99_1:FormatText(var_102_17.content)

				arg_99_1.text_.text = var_102_18

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_19 = 18
				local var_102_20 = utf8.len(var_102_18)
				local var_102_21 = var_102_19 <= 0 and var_102_15 or var_102_15 * (var_102_20 / var_102_19)

				if var_102_21 > 0 and var_102_15 < var_102_21 then
					arg_99_1.talkMaxDuration = var_102_21

					if var_102_21 + var_102_14 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_21 + var_102_14
					end
				end

				arg_99_1.text_.text = var_102_18
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111041", "111041024", "story_v_out_111041.awb") ~= 0 then
					local var_102_22 = manager.audio:GetVoiceLength("story_v_out_111041", "111041024", "story_v_out_111041.awb") / 1000

					if var_102_22 + var_102_14 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_22 + var_102_14
					end

					if var_102_17.prefab_name ~= "" and arg_99_1.actors_[var_102_17.prefab_name] ~= nil then
						local var_102_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_17.prefab_name].transform, "story_v_out_111041", "111041024", "story_v_out_111041.awb")

						arg_99_1:RecordAudio("111041024", var_102_23)
						arg_99_1:RecordAudio("111041024", var_102_23)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_111041", "111041024", "story_v_out_111041.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_111041", "111041024", "story_v_out_111041.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_24 = math.max(var_102_15, arg_99_1.talkMaxDuration)

			if var_102_14 <= arg_99_1.time_ and arg_99_1.time_ < var_102_14 + var_102_24 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_14) / var_102_24

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_14 + var_102_24 and arg_99_1.time_ < var_102_14 + var_102_24 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play111041025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 111041025
		arg_103_1.duration_ = 2.97

		local var_103_0 = {
			ja = 2.933,
			ko = 1.999999999999,
			zh = 2.966,
			en = 1.999999999999
		}
		local var_103_1 = manager.audio:GetLocalizationFlag()

		if var_103_0[var_103_1] ~= nil then
			arg_103_1.duration_ = var_103_0[var_103_1]
		end

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play111041026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 0

			if var_106_0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_0 + arg_106_0 then
				arg_103_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_106_1 = arg_103_1.actors_["1048ui_story"]
			local var_106_2 = 0

			if var_106_2 < arg_103_1.time_ and arg_103_1.time_ <= var_106_2 + arg_106_0 and not isNil(var_106_1) and arg_103_1.var_.characterEffect1048ui_story == nil then
				arg_103_1.var_.characterEffect1048ui_story = var_106_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_3 = 0.2

			if var_106_2 <= arg_103_1.time_ and arg_103_1.time_ < var_106_2 + var_106_3 and not isNil(var_106_1) then
				local var_106_4 = (arg_103_1.time_ - var_106_2) / var_106_3

				if arg_103_1.var_.characterEffect1048ui_story and not isNil(var_106_1) then
					arg_103_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= var_106_2 + var_106_3 and arg_103_1.time_ < var_106_2 + var_106_3 + arg_106_0 and not isNil(var_106_1) and arg_103_1.var_.characterEffect1048ui_story then
				arg_103_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			local var_106_5 = arg_103_1.actors_["1084ui_story"]
			local var_106_6 = 0

			if var_106_6 < arg_103_1.time_ and arg_103_1.time_ <= var_106_6 + arg_106_0 and not isNil(var_106_5) and arg_103_1.var_.characterEffect1084ui_story == nil then
				arg_103_1.var_.characterEffect1084ui_story = var_106_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_7 = 0.2

			if var_106_6 <= arg_103_1.time_ and arg_103_1.time_ < var_106_6 + var_106_7 and not isNil(var_106_5) then
				local var_106_8 = (arg_103_1.time_ - var_106_6) / var_106_7

				if arg_103_1.var_.characterEffect1084ui_story and not isNil(var_106_5) then
					local var_106_9 = Mathf.Lerp(0, 0.5, var_106_8)

					arg_103_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_103_1.var_.characterEffect1084ui_story.fillRatio = var_106_9
				end
			end

			if arg_103_1.time_ >= var_106_6 + var_106_7 and arg_103_1.time_ < var_106_6 + var_106_7 + arg_106_0 and not isNil(var_106_5) and arg_103_1.var_.characterEffect1084ui_story then
				local var_106_10 = 0.5

				arg_103_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_103_1.var_.characterEffect1084ui_story.fillRatio = var_106_10
			end

			local var_106_11 = 0
			local var_106_12 = 0.175

			if var_106_11 < arg_103_1.time_ and arg_103_1.time_ <= var_106_11 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_13 = arg_103_1:FormatText(StoryNameCfg[8].name)

				arg_103_1.leftNameTxt_.text = var_106_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_14 = arg_103_1:GetWordFromCfg(111041025)
				local var_106_15 = arg_103_1:FormatText(var_106_14.content)

				arg_103_1.text_.text = var_106_15

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_16 = 7
				local var_106_17 = utf8.len(var_106_15)
				local var_106_18 = var_106_16 <= 0 and var_106_12 or var_106_12 * (var_106_17 / var_106_16)

				if var_106_18 > 0 and var_106_12 < var_106_18 then
					arg_103_1.talkMaxDuration = var_106_18

					if var_106_18 + var_106_11 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_18 + var_106_11
					end
				end

				arg_103_1.text_.text = var_106_15
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111041", "111041025", "story_v_out_111041.awb") ~= 0 then
					local var_106_19 = manager.audio:GetVoiceLength("story_v_out_111041", "111041025", "story_v_out_111041.awb") / 1000

					if var_106_19 + var_106_11 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_19 + var_106_11
					end

					if var_106_14.prefab_name ~= "" and arg_103_1.actors_[var_106_14.prefab_name] ~= nil then
						local var_106_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_14.prefab_name].transform, "story_v_out_111041", "111041025", "story_v_out_111041.awb")

						arg_103_1:RecordAudio("111041025", var_106_20)
						arg_103_1:RecordAudio("111041025", var_106_20)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_111041", "111041025", "story_v_out_111041.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_111041", "111041025", "story_v_out_111041.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_21 = math.max(var_106_12, arg_103_1.talkMaxDuration)

			if var_106_11 <= arg_103_1.time_ and arg_103_1.time_ < var_106_11 + var_106_21 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_11) / var_106_21

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_11 + var_106_21 and arg_103_1.time_ < var_106_11 + var_106_21 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play111041026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 111041026
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play111041027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.actors_["1048ui_story"]
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.characterEffect1048ui_story == nil then
				arg_107_1.var_.characterEffect1048ui_story = var_110_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_2 = 0.2

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_2 and not isNil(var_110_0) then
				local var_110_3 = (arg_107_1.time_ - var_110_1) / var_110_2

				if arg_107_1.var_.characterEffect1048ui_story and not isNil(var_110_0) then
					local var_110_4 = Mathf.Lerp(0, 0.5, var_110_3)

					arg_107_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_107_1.var_.characterEffect1048ui_story.fillRatio = var_110_4
				end
			end

			if arg_107_1.time_ >= var_110_1 + var_110_2 and arg_107_1.time_ < var_110_1 + var_110_2 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.characterEffect1048ui_story then
				local var_110_5 = 0.5

				arg_107_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_107_1.var_.characterEffect1048ui_story.fillRatio = var_110_5
			end

			local var_110_6 = 0
			local var_110_7 = 0.425

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

				local var_110_9 = arg_107_1:GetWordFromCfg(111041026)
				local var_110_10 = arg_107_1:FormatText(var_110_9.content)

				arg_107_1.text_.text = var_110_10

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_11 = 17
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
	Play111041027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 111041027
		arg_111_1.duration_ = 7.17

		local var_111_0 = {
			ja = 7.166,
			ko = 3.066,
			zh = 3.233,
			en = 3.933
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
				arg_111_0:Play111041028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = arg_111_1.actors_["1039ui_story"]
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.characterEffect1039ui_story == nil then
				arg_111_1.var_.characterEffect1039ui_story = var_114_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_2 = 0.2

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_2 and not isNil(var_114_0) then
				local var_114_3 = (arg_111_1.time_ - var_114_1) / var_114_2

				if arg_111_1.var_.characterEffect1039ui_story and not isNil(var_114_0) then
					arg_111_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= var_114_1 + var_114_2 and arg_111_1.time_ < var_114_1 + var_114_2 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.characterEffect1039ui_story then
				arg_111_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_114_4 = 0

			if var_114_4 < arg_111_1.time_ and arg_111_1.time_ <= var_114_4 + arg_114_0 then
				arg_111_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action445")
			end

			local var_114_5 = 0

			if var_114_5 < arg_111_1.time_ and arg_111_1.time_ <= var_114_5 + arg_114_0 then
				arg_111_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_114_6 = 0
			local var_114_7 = 0.425

			if var_114_6 < arg_111_1.time_ and arg_111_1.time_ <= var_114_6 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_8 = arg_111_1:FormatText(StoryNameCfg[9].name)

				arg_111_1.leftNameTxt_.text = var_114_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_9 = arg_111_1:GetWordFromCfg(111041027)
				local var_114_10 = arg_111_1:FormatText(var_114_9.content)

				arg_111_1.text_.text = var_114_10

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_11 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_111041", "111041027", "story_v_out_111041.awb") ~= 0 then
					local var_114_14 = manager.audio:GetVoiceLength("story_v_out_111041", "111041027", "story_v_out_111041.awb") / 1000

					if var_114_14 + var_114_6 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_14 + var_114_6
					end

					if var_114_9.prefab_name ~= "" and arg_111_1.actors_[var_114_9.prefab_name] ~= nil then
						local var_114_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_9.prefab_name].transform, "story_v_out_111041", "111041027", "story_v_out_111041.awb")

						arg_111_1:RecordAudio("111041027", var_114_15)
						arg_111_1:RecordAudio("111041027", var_114_15)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_111041", "111041027", "story_v_out_111041.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_111041", "111041027", "story_v_out_111041.awb")
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
	Play111041028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 111041028
		arg_115_1.duration_ = 8.73

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play111041029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 0

			if var_118_0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_0 + arg_118_0 then
				arg_115_1.mask_.enabled = true
				arg_115_1.mask_.raycastTarget = true

				arg_115_1:SetGaussion(false)
			end

			local var_118_1 = 2

			if var_118_0 <= arg_115_1.time_ and arg_115_1.time_ < var_118_0 + var_118_1 then
				local var_118_2 = (arg_115_1.time_ - var_118_0) / var_118_1
				local var_118_3 = Color.New(0, 0, 0)

				var_118_3.a = Mathf.Lerp(0, 1, var_118_2)
				arg_115_1.mask_.color = var_118_3
			end

			if arg_115_1.time_ >= var_118_0 + var_118_1 and arg_115_1.time_ < var_118_0 + var_118_1 + arg_118_0 then
				local var_118_4 = Color.New(0, 0, 0)

				var_118_4.a = 1
				arg_115_1.mask_.color = var_118_4
			end

			local var_118_5 = 2

			if var_118_5 < arg_115_1.time_ and arg_115_1.time_ <= var_118_5 + arg_118_0 then
				arg_115_1.mask_.enabled = true
				arg_115_1.mask_.raycastTarget = true

				arg_115_1:SetGaussion(false)
			end

			local var_118_6 = 2

			if var_118_5 <= arg_115_1.time_ and arg_115_1.time_ < var_118_5 + var_118_6 then
				local var_118_7 = (arg_115_1.time_ - var_118_5) / var_118_6
				local var_118_8 = Color.New(0, 0, 0)

				var_118_8.a = Mathf.Lerp(1, 0, var_118_7)
				arg_115_1.mask_.color = var_118_8
			end

			if arg_115_1.time_ >= var_118_5 + var_118_6 and arg_115_1.time_ < var_118_5 + var_118_6 + arg_118_0 then
				local var_118_9 = Color.New(0, 0, 0)
				local var_118_10 = 0

				arg_115_1.mask_.enabled = false
				var_118_9.a = var_118_10
				arg_115_1.mask_.color = var_118_9
			end

			local var_118_11 = arg_115_1.actors_["1048ui_story"].transform
			local var_118_12 = 0

			if var_118_12 < arg_115_1.time_ and arg_115_1.time_ <= var_118_12 + arg_118_0 then
				arg_115_1.var_.moveOldPos1048ui_story = var_118_11.localPosition
			end

			local var_118_13 = 0.001

			if var_118_12 <= arg_115_1.time_ and arg_115_1.time_ < var_118_12 + var_118_13 then
				local var_118_14 = (arg_115_1.time_ - var_118_12) / var_118_13
				local var_118_15 = Vector3.New(0, 100, 0)

				var_118_11.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1048ui_story, var_118_15, var_118_14)

				local var_118_16 = manager.ui.mainCamera.transform.position - var_118_11.position

				var_118_11.forward = Vector3.New(var_118_16.x, var_118_16.y, var_118_16.z)

				local var_118_17 = var_118_11.localEulerAngles

				var_118_17.z = 0
				var_118_17.x = 0
				var_118_11.localEulerAngles = var_118_17
			end

			if arg_115_1.time_ >= var_118_12 + var_118_13 and arg_115_1.time_ < var_118_12 + var_118_13 + arg_118_0 then
				var_118_11.localPosition = Vector3.New(0, 100, 0)

				local var_118_18 = manager.ui.mainCamera.transform.position - var_118_11.position

				var_118_11.forward = Vector3.New(var_118_18.x, var_118_18.y, var_118_18.z)

				local var_118_19 = var_118_11.localEulerAngles

				var_118_19.z = 0
				var_118_19.x = 0
				var_118_11.localEulerAngles = var_118_19
			end

			local var_118_20 = arg_115_1.actors_["1084ui_story"].transform
			local var_118_21 = 0

			if var_118_21 < arg_115_1.time_ and arg_115_1.time_ <= var_118_21 + arg_118_0 then
				arg_115_1.var_.moveOldPos1084ui_story = var_118_20.localPosition
			end

			local var_118_22 = 0.001

			if var_118_21 <= arg_115_1.time_ and arg_115_1.time_ < var_118_21 + var_118_22 then
				local var_118_23 = (arg_115_1.time_ - var_118_21) / var_118_22
				local var_118_24 = Vector3.New(0, 100, 0)

				var_118_20.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1084ui_story, var_118_24, var_118_23)

				local var_118_25 = manager.ui.mainCamera.transform.position - var_118_20.position

				var_118_20.forward = Vector3.New(var_118_25.x, var_118_25.y, var_118_25.z)

				local var_118_26 = var_118_20.localEulerAngles

				var_118_26.z = 0
				var_118_26.x = 0
				var_118_20.localEulerAngles = var_118_26
			end

			if arg_115_1.time_ >= var_118_21 + var_118_22 and arg_115_1.time_ < var_118_21 + var_118_22 + arg_118_0 then
				var_118_20.localPosition = Vector3.New(0, 100, 0)

				local var_118_27 = manager.ui.mainCamera.transform.position - var_118_20.position

				var_118_20.forward = Vector3.New(var_118_27.x, var_118_27.y, var_118_27.z)

				local var_118_28 = var_118_20.localEulerAngles

				var_118_28.z = 0
				var_118_28.x = 0
				var_118_20.localEulerAngles = var_118_28
			end

			local var_118_29 = arg_115_1.actors_["1039ui_story"].transform
			local var_118_30 = 0

			if var_118_30 < arg_115_1.time_ and arg_115_1.time_ <= var_118_30 + arg_118_0 then
				arg_115_1.var_.moveOldPos1039ui_story = var_118_29.localPosition
			end

			local var_118_31 = 0.001

			if var_118_30 <= arg_115_1.time_ and arg_115_1.time_ < var_118_30 + var_118_31 then
				local var_118_32 = (arg_115_1.time_ - var_118_30) / var_118_31
				local var_118_33 = Vector3.New(0, 100, 0)

				var_118_29.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1039ui_story, var_118_33, var_118_32)

				local var_118_34 = manager.ui.mainCamera.transform.position - var_118_29.position

				var_118_29.forward = Vector3.New(var_118_34.x, var_118_34.y, var_118_34.z)

				local var_118_35 = var_118_29.localEulerAngles

				var_118_35.z = 0
				var_118_35.x = 0
				var_118_29.localEulerAngles = var_118_35
			end

			if arg_115_1.time_ >= var_118_30 + var_118_31 and arg_115_1.time_ < var_118_30 + var_118_31 + arg_118_0 then
				var_118_29.localPosition = Vector3.New(0, 100, 0)

				local var_118_36 = manager.ui.mainCamera.transform.position - var_118_29.position

				var_118_29.forward = Vector3.New(var_118_36.x, var_118_36.y, var_118_36.z)

				local var_118_37 = var_118_29.localEulerAngles

				var_118_37.z = 0
				var_118_37.x = 0
				var_118_29.localEulerAngles = var_118_37
			end

			if arg_115_1.frameCnt_ <= 1 then
				arg_115_1.dialog_:SetActive(false)
			end

			local var_118_38 = 3.73333333333333
			local var_118_39 = 1.35

			if var_118_38 < arg_115_1.time_ and arg_115_1.time_ <= var_118_38 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0

				arg_115_1.dialog_:SetActive(true)

				arg_115_1.dialogCg_.alpha = 0

				local var_118_40 = LeanTween.value(arg_115_1.dialog_, 0, 1, 0.3)

				var_118_40:setOnUpdate(LuaHelper.FloatAction(function(arg_119_0)
					arg_115_1.dialogCg_.alpha = arg_119_0
				end))
				var_118_40:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_115_1.dialog_)
					var_118_40:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_115_1.duration_ = arg_115_1.duration_ + 0.3

				SetActive(arg_115_1.leftNameGo_, false)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_41 = arg_115_1:GetWordFromCfg(111041028)
				local var_118_42 = arg_115_1:FormatText(var_118_41.content)

				arg_115_1.text_.text = var_118_42

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_43 = 54
				local var_118_44 = utf8.len(var_118_42)
				local var_118_45 = var_118_43 <= 0 and var_118_39 or var_118_39 * (var_118_44 / var_118_43)

				if var_118_45 > 0 and var_118_39 < var_118_45 then
					arg_115_1.talkMaxDuration = var_118_45
					var_118_38 = var_118_38 + 0.3

					if var_118_45 + var_118_38 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_45 + var_118_38
					end
				end

				arg_115_1.text_.text = var_118_42
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_46 = var_118_38 + 0.3
			local var_118_47 = math.max(var_118_39, arg_115_1.talkMaxDuration)

			if var_118_46 <= arg_115_1.time_ and arg_115_1.time_ < var_118_46 + var_118_47 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_46) / var_118_47

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_46 + var_118_47 and arg_115_1.time_ < var_118_46 + var_118_47 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_115_1:InitPlayNodeList()
	end,
	Play111041029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 111041029
		arg_121_1.duration_ = 7

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play111041030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = "D999"

			if arg_121_1.bgs_[var_124_0] == nil then
				local var_124_1 = Object.Instantiate(arg_121_1.paintGo_)

				var_124_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_124_0)
				var_124_1.name = var_124_0
				var_124_1.transform.parent = arg_121_1.stage_.transform
				var_124_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_121_1.bgs_[var_124_0] = var_124_1
			end

			local var_124_2 = arg_121_1.bgs_.D999.transform
			local var_124_3 = 0

			if var_124_3 < arg_121_1.time_ and arg_121_1.time_ <= var_124_3 + arg_124_0 then
				arg_121_1.var_.moveOldPosD999 = var_124_2.localPosition
			end

			local var_124_4 = 0.001

			if var_124_3 <= arg_121_1.time_ and arg_121_1.time_ < var_124_3 + var_124_4 then
				local var_124_5 = (arg_121_1.time_ - var_124_3) / var_124_4
				local var_124_6 = Vector3.New(0, 1, 10)

				var_124_2.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPosD999, var_124_6, var_124_5)
			end

			if arg_121_1.time_ >= var_124_3 + var_124_4 and arg_121_1.time_ < var_124_3 + var_124_4 + arg_124_0 then
				var_124_2.localPosition = Vector3.New(0, 1, 10)
			end

			local var_124_7 = arg_121_1.bgs_.D999
			local var_124_8 = 0

			if var_124_8 < arg_121_1.time_ and arg_121_1.time_ <= var_124_8 + arg_124_0 then
				local var_124_9 = var_124_7:GetComponent("SpriteRenderer")

				if var_124_9 then
					arg_121_1.var_.alphaOldValueD999 = var_124_9.color.a
					arg_121_1.var_.alphaMatValueD999 = var_124_9
				end
			end

			local var_124_10 = 1.5

			if var_124_8 <= arg_121_1.time_ and arg_121_1.time_ < var_124_8 + var_124_10 then
				local var_124_11 = (arg_121_1.time_ - var_124_8) / var_124_10
				local var_124_12 = Mathf.Lerp(arg_121_1.var_.alphaOldValueD999, 0.3, var_124_11)

				if arg_121_1.var_.alphaMatValueD999 then
					local var_124_13 = arg_121_1.var_.alphaMatValueD999.color

					var_124_13.a = var_124_12
					arg_121_1.var_.alphaMatValueD999.color = var_124_13
				end
			end

			if arg_121_1.time_ >= var_124_8 + var_124_10 and arg_121_1.time_ < var_124_8 + var_124_10 + arg_124_0 and arg_121_1.var_.alphaMatValueD999 then
				local var_124_14 = arg_121_1.var_.alphaMatValueD999
				local var_124_15 = var_124_14.color

				var_124_15.a = 0.3
				var_124_14.color = var_124_15
			end

			local var_124_16 = arg_121_1.bgs_.D999.transform
			local var_124_17 = 0

			if var_124_17 < arg_121_1.time_ and arg_121_1.time_ <= var_124_17 + arg_124_0 then
				arg_121_1.var_.moveOldPosD999 = var_124_16.localPosition
				var_124_16.localScale = Vector3.New(1.3, 1.3, 1.3)
			end

			local var_124_18 = 2.65

			if var_124_17 <= arg_121_1.time_ and arg_121_1.time_ < var_124_17 + var_124_18 then
				local var_124_19 = (arg_121_1.time_ - var_124_17) / var_124_18
				local var_124_20 = Vector3.New(0, 1, 10)

				var_124_16.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPosD999, var_124_20, var_124_19)
			end

			if arg_121_1.time_ >= var_124_17 + var_124_18 and arg_121_1.time_ < var_124_17 + var_124_18 + arg_124_0 then
				var_124_16.localPosition = Vector3.New(0, 1, 10)
			end

			local var_124_21 = 0

			if var_124_21 < arg_121_1.time_ and arg_121_1.time_ <= var_124_21 + arg_124_0 then
				arg_121_1.allBtn_.enabled = false
			end

			local var_124_22 = 2.65

			if arg_121_1.time_ >= var_124_21 + var_124_22 and arg_121_1.time_ < var_124_21 + var_124_22 + arg_124_0 then
				arg_121_1.allBtn_.enabled = true
			end

			local var_124_23 = 0
			local var_124_24 = 1

			if var_124_23 < arg_121_1.time_ and arg_121_1.time_ <= var_124_23 + arg_124_0 then
				local var_124_25 = "stop"
				local var_124_26 = "effect"

				arg_121_1:AudioAction(var_124_25, var_124_26, "se_story", "se_story_crowdloop", "")
			end

			if arg_121_1.frameCnt_ <= 1 then
				arg_121_1.dialog_:SetActive(false)
			end

			local var_124_27 = 2
			local var_124_28 = 0.65

			if var_124_27 < arg_121_1.time_ and arg_121_1.time_ <= var_124_27 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0

				arg_121_1.dialog_:SetActive(true)

				arg_121_1.dialogCg_.alpha = 0

				local var_124_29 = LeanTween.value(arg_121_1.dialog_, 0, 1, 0.3)

				var_124_29:setOnUpdate(LuaHelper.FloatAction(function(arg_125_0)
					arg_121_1.dialogCg_.alpha = arg_125_0
				end))
				var_124_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_121_1.dialog_)
					var_124_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_121_1.duration_ = arg_121_1.duration_ + 0.3

				SetActive(arg_121_1.leftNameGo_, false)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_30 = arg_121_1:GetWordFromCfg(111041029)
				local var_124_31 = arg_121_1:FormatText(var_124_30.content)

				arg_121_1.text_.text = var_124_31

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_32 = 26
				local var_124_33 = utf8.len(var_124_31)
				local var_124_34 = var_124_32 <= 0 and var_124_28 or var_124_28 * (var_124_33 / var_124_32)

				if var_124_34 > 0 and var_124_28 < var_124_34 then
					arg_121_1.talkMaxDuration = var_124_34
					var_124_27 = var_124_27 + 0.3

					if var_124_34 + var_124_27 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_34 + var_124_27
					end
				end

				arg_121_1.text_.text = var_124_31
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_35 = var_124_27 + 0.3
			local var_124_36 = math.max(var_124_28, arg_121_1.talkMaxDuration)

			if var_124_35 <= arg_121_1.time_ and arg_121_1.time_ < var_124_35 + var_124_36 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_35) / var_124_36

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_35 + var_124_36 and arg_121_1.time_ < var_124_35 + var_124_36 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "D999",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "D999",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.65,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play111041030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 111041030
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play111041031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0
			local var_130_1 = 0.2

			if var_130_0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_2 = arg_127_1:FormatText(StoryNameCfg[7].name)

				arg_127_1.leftNameTxt_.text = var_130_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, true)
				arg_127_1.iconController_:SetSelectedState("hero")

				arg_127_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_127_1.callingController_:SetSelectedState("normal")

				arg_127_1.keyicon_.color = Color.New(1, 1, 1)
				arg_127_1.icon_.color = Color.New(1, 1, 1)

				local var_130_3 = arg_127_1:GetWordFromCfg(111041030)
				local var_130_4 = arg_127_1:FormatText(var_130_3.content)

				arg_127_1.text_.text = var_130_4

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_5 = 8
				local var_130_6 = utf8.len(var_130_4)
				local var_130_7 = var_130_5 <= 0 and var_130_1 or var_130_1 * (var_130_6 / var_130_5)

				if var_130_7 > 0 and var_130_1 < var_130_7 then
					arg_127_1.talkMaxDuration = var_130_7

					if var_130_7 + var_130_0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_7 + var_130_0
					end
				end

				arg_127_1.text_.text = var_130_4
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_8 = math.max(var_130_1, arg_127_1.talkMaxDuration)

			if var_130_0 <= arg_127_1.time_ and arg_127_1.time_ < var_130_0 + var_130_8 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_0) / var_130_8

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_0 + var_130_8 and arg_127_1.time_ < var_130_0 + var_130_8 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play111041031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 111041031
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play111041032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0
			local var_134_1 = 1.7

			if var_134_0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, false)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_2 = arg_131_1:GetWordFromCfg(111041031)
				local var_134_3 = arg_131_1:FormatText(var_134_2.content)

				arg_131_1.text_.text = var_134_3

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_4 = 68
				local var_134_5 = utf8.len(var_134_3)
				local var_134_6 = var_134_4 <= 0 and var_134_1 or var_134_1 * (var_134_5 / var_134_4)

				if var_134_6 > 0 and var_134_1 < var_134_6 then
					arg_131_1.talkMaxDuration = var_134_6

					if var_134_6 + var_134_0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_6 + var_134_0
					end
				end

				arg_131_1.text_.text = var_134_3
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_7 = math.max(var_134_1, arg_131_1.talkMaxDuration)

			if var_134_0 <= arg_131_1.time_ and arg_131_1.time_ < var_134_0 + var_134_7 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_0) / var_134_7

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_0 + var_134_7 and arg_131_1.time_ < var_134_0 + var_134_7 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play111041032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 111041032
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play111041033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 0
			local var_138_1 = 1.175

			if var_138_0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, false)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_2 = arg_135_1:GetWordFromCfg(111041032)
				local var_138_3 = arg_135_1:FormatText(var_138_2.content)

				arg_135_1.text_.text = var_138_3

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_4 = 47
				local var_138_5 = utf8.len(var_138_3)
				local var_138_6 = var_138_4 <= 0 and var_138_1 or var_138_1 * (var_138_5 / var_138_4)

				if var_138_6 > 0 and var_138_1 < var_138_6 then
					arg_135_1.talkMaxDuration = var_138_6

					if var_138_6 + var_138_0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_6 + var_138_0
					end
				end

				arg_135_1.text_.text = var_138_3
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_7 = math.max(var_138_1, arg_135_1.talkMaxDuration)

			if var_138_0 <= arg_135_1.time_ and arg_135_1.time_ < var_138_0 + var_138_7 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_0) / var_138_7

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_0 + var_138_7 and arg_135_1.time_ < var_138_0 + var_138_7 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play111041033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 111041033
		arg_139_1.duration_ = 7

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play111041034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = "AS0103"

			if arg_139_1.bgs_[var_142_0] == nil then
				local var_142_1 = Object.Instantiate(arg_139_1.paintGo_)

				var_142_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_142_0)
				var_142_1.name = var_142_0
				var_142_1.transform.parent = arg_139_1.stage_.transform
				var_142_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_139_1.bgs_[var_142_0] = var_142_1
			end

			local var_142_2 = 0

			if var_142_2 < arg_139_1.time_ and arg_139_1.time_ <= var_142_2 + arg_142_0 then
				local var_142_3 = manager.ui.mainCamera.transform.localPosition
				local var_142_4 = Vector3.New(0, 0, 10) + Vector3.New(var_142_3.x, var_142_3.y, 0)
				local var_142_5 = arg_139_1.bgs_.AS0103

				var_142_5.transform.localPosition = var_142_4
				var_142_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_142_6 = var_142_5:GetComponent("SpriteRenderer")

				if var_142_6 and var_142_6.sprite then
					local var_142_7 = (var_142_5.transform.localPosition - var_142_3).z
					local var_142_8 = manager.ui.mainCameraCom_
					local var_142_9 = 2 * var_142_7 * Mathf.Tan(var_142_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_142_10 = var_142_9 * var_142_8.aspect
					local var_142_11 = var_142_6.sprite.bounds.size.x
					local var_142_12 = var_142_6.sprite.bounds.size.y
					local var_142_13 = var_142_10 / var_142_11
					local var_142_14 = var_142_9 / var_142_12
					local var_142_15 = var_142_14 < var_142_13 and var_142_13 or var_142_14

					var_142_5.transform.localScale = Vector3.New(var_142_15, var_142_15, 0)
				end

				for iter_142_0, iter_142_1 in pairs(arg_139_1.bgs_) do
					if iter_142_0 ~= "AS0103" then
						iter_142_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_142_16 = arg_139_1.bgs_.D999
			local var_142_17 = 0

			if var_142_17 < arg_139_1.time_ and arg_139_1.time_ <= var_142_17 + arg_142_0 then
				local var_142_18 = var_142_16:GetComponent("SpriteRenderer")

				if var_142_18 then
					arg_139_1.var_.alphaOldValueD999 = var_142_18.color.a
					arg_139_1.var_.alphaMatValueD999 = var_142_18
				end

				arg_139_1.var_.alphaOldValueD999 = 1
			end

			local var_142_19 = 1.5

			if var_142_17 <= arg_139_1.time_ and arg_139_1.time_ < var_142_17 + var_142_19 then
				local var_142_20 = (arg_139_1.time_ - var_142_17) / var_142_19
				local var_142_21 = Mathf.Lerp(arg_139_1.var_.alphaOldValueD999, 0, var_142_20)

				if arg_139_1.var_.alphaMatValueD999 then
					local var_142_22 = arg_139_1.var_.alphaMatValueD999.color

					var_142_22.a = var_142_21
					arg_139_1.var_.alphaMatValueD999.color = var_142_22
				end
			end

			if arg_139_1.time_ >= var_142_17 + var_142_19 and arg_139_1.time_ < var_142_17 + var_142_19 + arg_142_0 and arg_139_1.var_.alphaMatValueD999 then
				local var_142_23 = arg_139_1.var_.alphaMatValueD999
				local var_142_24 = var_142_23.color

				var_142_24.a = 0
				var_142_23.color = var_142_24
			end

			local var_142_25 = 0

			if var_142_25 < arg_139_1.time_ and arg_139_1.time_ <= var_142_25 + arg_142_0 then
				arg_139_1.allBtn_.enabled = false
			end

			local var_142_26 = 2

			if arg_139_1.time_ >= var_142_25 + var_142_26 and arg_139_1.time_ < var_142_25 + var_142_26 + arg_142_0 then
				arg_139_1.allBtn_.enabled = true
			end

			local var_142_27 = 0

			if var_142_27 < arg_139_1.time_ and arg_139_1.time_ <= var_142_27 + arg_142_0 then
				arg_139_1.mask_.enabled = true
				arg_139_1.mask_.raycastTarget = false

				arg_139_1:SetGaussion(false)
			end

			local var_142_28 = 1

			if var_142_27 <= arg_139_1.time_ and arg_139_1.time_ < var_142_27 + var_142_28 then
				local var_142_29 = (arg_139_1.time_ - var_142_27) / var_142_28
				local var_142_30 = Color.New(1, 1, 1)

				var_142_30.a = Mathf.Lerp(1, 0, var_142_29)
				arg_139_1.mask_.color = var_142_30
			end

			if arg_139_1.time_ >= var_142_27 + var_142_28 and arg_139_1.time_ < var_142_27 + var_142_28 + arg_142_0 then
				local var_142_31 = Color.New(1, 1, 1)
				local var_142_32 = 0

				arg_139_1.mask_.enabled = false
				var_142_31.a = var_142_32
				arg_139_1.mask_.color = var_142_31
			end

			if arg_139_1.frameCnt_ <= 1 then
				arg_139_1.dialog_:SetActive(false)
			end

			local var_142_33 = 2
			local var_142_34 = 0.4

			if var_142_33 < arg_139_1.time_ and arg_139_1.time_ <= var_142_33 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0

				arg_139_1.dialog_:SetActive(true)

				arg_139_1.dialogCg_.alpha = 0

				local var_142_35 = LeanTween.value(arg_139_1.dialog_, 0, 1, 0.3)

				var_142_35:setOnUpdate(LuaHelper.FloatAction(function(arg_143_0)
					arg_139_1.dialogCg_.alpha = arg_143_0
				end))
				var_142_35:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_139_1.dialog_)
					var_142_35:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_139_1.duration_ = arg_139_1.duration_ + 0.3

				SetActive(arg_139_1.leftNameGo_, false)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_36 = arg_139_1:GetWordFromCfg(111041033)
				local var_142_37 = arg_139_1:FormatText(var_142_36.content)

				arg_139_1.text_.text = var_142_37

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_38 = 16
				local var_142_39 = utf8.len(var_142_37)
				local var_142_40 = var_142_38 <= 0 and var_142_34 or var_142_34 * (var_142_39 / var_142_38)

				if var_142_40 > 0 and var_142_34 < var_142_40 then
					arg_139_1.talkMaxDuration = var_142_40
					var_142_33 = var_142_33 + 0.3

					if var_142_40 + var_142_33 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_40 + var_142_33
					end
				end

				arg_139_1.text_.text = var_142_37
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_41 = var_142_33 + 0.3
			local var_142_42 = math.max(var_142_34, arg_139_1.talkMaxDuration)

			if var_142_41 <= arg_139_1.time_ and arg_139_1.time_ < var_142_41 + var_142_42 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_41) / var_142_42

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_41 + var_142_42 and arg_139_1.time_ < var_142_41 + var_142_42 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play111041034 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 111041034
		arg_145_1.duration_ = 2.43

		local var_145_0 = {
			ja = 1.366,
			ko = 1.366,
			zh = 2.433,
			en = 1.566
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
				arg_145_0:Play111041035(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0
			local var_148_1 = 0.125

			if var_148_0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_2 = arg_145_1:FormatText(StoryNameCfg[36].name)

				arg_145_1.leftNameTxt_.text = var_148_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, true)
				arg_145_1.iconController_:SetSelectedState("hero")

				arg_145_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_145_1.callingController_:SetSelectedState("normal")

				arg_145_1.keyicon_.color = Color.New(1, 1, 1)
				arg_145_1.icon_.color = Color.New(1, 1, 1)

				local var_148_3 = arg_145_1:GetWordFromCfg(111041034)
				local var_148_4 = arg_145_1:FormatText(var_148_3.content)

				arg_145_1.text_.text = var_148_4

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_5 = 5
				local var_148_6 = utf8.len(var_148_4)
				local var_148_7 = var_148_5 <= 0 and var_148_1 or var_148_1 * (var_148_6 / var_148_5)

				if var_148_7 > 0 and var_148_1 < var_148_7 then
					arg_145_1.talkMaxDuration = var_148_7

					if var_148_7 + var_148_0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_7 + var_148_0
					end
				end

				arg_145_1.text_.text = var_148_4
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111041", "111041034", "story_v_out_111041.awb") ~= 0 then
					local var_148_8 = manager.audio:GetVoiceLength("story_v_out_111041", "111041034", "story_v_out_111041.awb") / 1000

					if var_148_8 + var_148_0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_8 + var_148_0
					end

					if var_148_3.prefab_name ~= "" and arg_145_1.actors_[var_148_3.prefab_name] ~= nil then
						local var_148_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_3.prefab_name].transform, "story_v_out_111041", "111041034", "story_v_out_111041.awb")

						arg_145_1:RecordAudio("111041034", var_148_9)
						arg_145_1:RecordAudio("111041034", var_148_9)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_111041", "111041034", "story_v_out_111041.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_111041", "111041034", "story_v_out_111041.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_10 = math.max(var_148_1, arg_145_1.talkMaxDuration)

			if var_148_0 <= arg_145_1.time_ and arg_145_1.time_ < var_148_0 + var_148_10 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_0) / var_148_10

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_0 + var_148_10 and arg_145_1.time_ < var_148_0 + var_148_10 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play111041035 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 111041035
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play111041036(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0
			local var_152_1 = 0.525

			if var_152_0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_2 = arg_149_1:FormatText(StoryNameCfg[7].name)

				arg_149_1.leftNameTxt_.text = var_152_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, true)
				arg_149_1.iconController_:SetSelectedState("hero")

				arg_149_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_149_1.callingController_:SetSelectedState("normal")

				arg_149_1.keyicon_.color = Color.New(1, 1, 1)
				arg_149_1.icon_.color = Color.New(1, 1, 1)

				local var_152_3 = arg_149_1:GetWordFromCfg(111041035)
				local var_152_4 = arg_149_1:FormatText(var_152_3.content)

				arg_149_1.text_.text = var_152_4

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_5 = 21
				local var_152_6 = utf8.len(var_152_4)
				local var_152_7 = var_152_5 <= 0 and var_152_1 or var_152_1 * (var_152_6 / var_152_5)

				if var_152_7 > 0 and var_152_1 < var_152_7 then
					arg_149_1.talkMaxDuration = var_152_7

					if var_152_7 + var_152_0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_7 + var_152_0
					end
				end

				arg_149_1.text_.text = var_152_4
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_8 = math.max(var_152_1, arg_149_1.talkMaxDuration)

			if var_152_0 <= arg_149_1.time_ and arg_149_1.time_ < var_152_0 + var_152_8 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_0) / var_152_8

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_0 + var_152_8 and arg_149_1.time_ < var_152_0 + var_152_8 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play111041036 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 111041036
		arg_153_1.duration_ = 9.63

		local var_153_0 = {
			ja = 7.233,
			ko = 8.666,
			zh = 8.233,
			en = 9.633
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
				arg_153_0:Play111041037(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0
			local var_156_1 = 0.8

			if var_156_0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_2 = arg_153_1:FormatText(StoryNameCfg[183].name)

				arg_153_1.leftNameTxt_.text = var_156_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, true)
				arg_153_1.iconController_:SetSelectedState("hero")

				arg_153_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_153_1.callingController_:SetSelectedState("normal")

				arg_153_1.keyicon_.color = Color.New(1, 1, 1)
				arg_153_1.icon_.color = Color.New(1, 1, 1)

				local var_156_3 = arg_153_1:GetWordFromCfg(111041036)
				local var_156_4 = arg_153_1:FormatText(var_156_3.content)

				arg_153_1.text_.text = var_156_4

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_5 = 32
				local var_156_6 = utf8.len(var_156_4)
				local var_156_7 = var_156_5 <= 0 and var_156_1 or var_156_1 * (var_156_6 / var_156_5)

				if var_156_7 > 0 and var_156_1 < var_156_7 then
					arg_153_1.talkMaxDuration = var_156_7

					if var_156_7 + var_156_0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_7 + var_156_0
					end
				end

				arg_153_1.text_.text = var_156_4
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111041", "111041036", "story_v_out_111041.awb") ~= 0 then
					local var_156_8 = manager.audio:GetVoiceLength("story_v_out_111041", "111041036", "story_v_out_111041.awb") / 1000

					if var_156_8 + var_156_0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_8 + var_156_0
					end

					if var_156_3.prefab_name ~= "" and arg_153_1.actors_[var_156_3.prefab_name] ~= nil then
						local var_156_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_3.prefab_name].transform, "story_v_out_111041", "111041036", "story_v_out_111041.awb")

						arg_153_1:RecordAudio("111041036", var_156_9)
						arg_153_1:RecordAudio("111041036", var_156_9)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_111041", "111041036", "story_v_out_111041.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_111041", "111041036", "story_v_out_111041.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_10 = math.max(var_156_1, arg_153_1.talkMaxDuration)

			if var_156_0 <= arg_153_1.time_ and arg_153_1.time_ < var_156_0 + var_156_10 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_0) / var_156_10

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_0 + var_156_10 and arg_153_1.time_ < var_156_0 + var_156_10 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play111041037 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 111041037
		arg_157_1.duration_ = 4.13

		local var_157_0 = {
			ja = 3.666,
			ko = 2.366,
			zh = 4.133,
			en = 3.033
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
				arg_157_0:Play111041038(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0
			local var_160_1 = 0.325

			if var_160_0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_2 = arg_157_1:FormatText(StoryNameCfg[183].name)

				arg_157_1.leftNameTxt_.text = var_160_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, true)
				arg_157_1.iconController_:SetSelectedState("hero")

				arg_157_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_157_1.callingController_:SetSelectedState("normal")

				arg_157_1.keyicon_.color = Color.New(1, 1, 1)
				arg_157_1.icon_.color = Color.New(1, 1, 1)

				local var_160_3 = arg_157_1:GetWordFromCfg(111041037)
				local var_160_4 = arg_157_1:FormatText(var_160_3.content)

				arg_157_1.text_.text = var_160_4

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_5 = 13
				local var_160_6 = utf8.len(var_160_4)
				local var_160_7 = var_160_5 <= 0 and var_160_1 or var_160_1 * (var_160_6 / var_160_5)

				if var_160_7 > 0 and var_160_1 < var_160_7 then
					arg_157_1.talkMaxDuration = var_160_7

					if var_160_7 + var_160_0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_7 + var_160_0
					end
				end

				arg_157_1.text_.text = var_160_4
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111041", "111041037", "story_v_out_111041.awb") ~= 0 then
					local var_160_8 = manager.audio:GetVoiceLength("story_v_out_111041", "111041037", "story_v_out_111041.awb") / 1000

					if var_160_8 + var_160_0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_8 + var_160_0
					end

					if var_160_3.prefab_name ~= "" and arg_157_1.actors_[var_160_3.prefab_name] ~= nil then
						local var_160_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_3.prefab_name].transform, "story_v_out_111041", "111041037", "story_v_out_111041.awb")

						arg_157_1:RecordAudio("111041037", var_160_9)
						arg_157_1:RecordAudio("111041037", var_160_9)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_111041", "111041037", "story_v_out_111041.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_111041", "111041037", "story_v_out_111041.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_10 = math.max(var_160_1, arg_157_1.talkMaxDuration)

			if var_160_0 <= arg_157_1.time_ and arg_157_1.time_ < var_160_0 + var_160_10 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_0) / var_160_10

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_0 + var_160_10 and arg_157_1.time_ < var_160_0 + var_160_10 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play111041038 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 111041038
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play111041039(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0
			local var_164_1 = 0.75

			if var_164_0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_2 = arg_161_1:FormatText(StoryNameCfg[7].name)

				arg_161_1.leftNameTxt_.text = var_164_2

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

				local var_164_3 = arg_161_1:GetWordFromCfg(111041038)
				local var_164_4 = arg_161_1:FormatText(var_164_3.content)

				arg_161_1.text_.text = var_164_4

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_5 = 30
				local var_164_6 = utf8.len(var_164_4)
				local var_164_7 = var_164_5 <= 0 and var_164_1 or var_164_1 * (var_164_6 / var_164_5)

				if var_164_7 > 0 and var_164_1 < var_164_7 then
					arg_161_1.talkMaxDuration = var_164_7

					if var_164_7 + var_164_0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_7 + var_164_0
					end
				end

				arg_161_1.text_.text = var_164_4
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_8 = math.max(var_164_1, arg_161_1.talkMaxDuration)

			if var_164_0 <= arg_161_1.time_ and arg_161_1.time_ < var_164_0 + var_164_8 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_0) / var_164_8

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_0 + var_164_8 and arg_161_1.time_ < var_164_0 + var_164_8 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play111041039 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 111041039
		arg_165_1.duration_ = 7.43

		local var_165_0 = {
			ja = 6.733,
			ko = 5.266,
			zh = 7.333,
			en = 7.433
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
				arg_165_0:Play111041040(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0
			local var_168_1 = 0.675

			if var_168_0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_2 = arg_165_1:FormatText(StoryNameCfg[183].name)

				arg_165_1.leftNameTxt_.text = var_168_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, true)
				arg_165_1.iconController_:SetSelectedState("hero")

				arg_165_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_165_1.callingController_:SetSelectedState("normal")

				arg_165_1.keyicon_.color = Color.New(1, 1, 1)
				arg_165_1.icon_.color = Color.New(1, 1, 1)

				local var_168_3 = arg_165_1:GetWordFromCfg(111041039)
				local var_168_4 = arg_165_1:FormatText(var_168_3.content)

				arg_165_1.text_.text = var_168_4

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_5 = 28
				local var_168_6 = utf8.len(var_168_4)
				local var_168_7 = var_168_5 <= 0 and var_168_1 or var_168_1 * (var_168_6 / var_168_5)

				if var_168_7 > 0 and var_168_1 < var_168_7 then
					arg_165_1.talkMaxDuration = var_168_7

					if var_168_7 + var_168_0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_7 + var_168_0
					end
				end

				arg_165_1.text_.text = var_168_4
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111041", "111041039", "story_v_out_111041.awb") ~= 0 then
					local var_168_8 = manager.audio:GetVoiceLength("story_v_out_111041", "111041039", "story_v_out_111041.awb") / 1000

					if var_168_8 + var_168_0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_8 + var_168_0
					end

					if var_168_3.prefab_name ~= "" and arg_165_1.actors_[var_168_3.prefab_name] ~= nil then
						local var_168_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_3.prefab_name].transform, "story_v_out_111041", "111041039", "story_v_out_111041.awb")

						arg_165_1:RecordAudio("111041039", var_168_9)
						arg_165_1:RecordAudio("111041039", var_168_9)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_111041", "111041039", "story_v_out_111041.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_111041", "111041039", "story_v_out_111041.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_10 = math.max(var_168_1, arg_165_1.talkMaxDuration)

			if var_168_0 <= arg_165_1.time_ and arg_165_1.time_ < var_168_0 + var_168_10 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_0) / var_168_10

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_0 + var_168_10 and arg_165_1.time_ < var_168_0 + var_168_10 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play111041040 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 111041040
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play111041041(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0
			local var_172_1 = 0.275

			if var_172_0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_2 = arg_169_1:FormatText(StoryNameCfg[7].name)

				arg_169_1.leftNameTxt_.text = var_172_2

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

				local var_172_3 = arg_169_1:GetWordFromCfg(111041040)
				local var_172_4 = arg_169_1:FormatText(var_172_3.content)

				arg_169_1.text_.text = var_172_4

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_5 = 11
				local var_172_6 = utf8.len(var_172_4)
				local var_172_7 = var_172_5 <= 0 and var_172_1 or var_172_1 * (var_172_6 / var_172_5)

				if var_172_7 > 0 and var_172_1 < var_172_7 then
					arg_169_1.talkMaxDuration = var_172_7

					if var_172_7 + var_172_0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_7 + var_172_0
					end
				end

				arg_169_1.text_.text = var_172_4
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_8 = math.max(var_172_1, arg_169_1.talkMaxDuration)

			if var_172_0 <= arg_169_1.time_ and arg_169_1.time_ < var_172_0 + var_172_8 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_0) / var_172_8

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_0 + var_172_8 and arg_169_1.time_ < var_172_0 + var_172_8 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play111041041 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 111041041
		arg_173_1.duration_ = 5.67

		local var_173_0 = {
			ja = 4.633,
			ko = 5.6,
			zh = 4.6,
			en = 5.666
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
				arg_173_0:Play111041042(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0
			local var_176_1 = 0.425

			if var_176_0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_2 = arg_173_1:FormatText(StoryNameCfg[183].name)

				arg_173_1.leftNameTxt_.text = var_176_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, true)
				arg_173_1.iconController_:SetSelectedState("hero")

				arg_173_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_173_1.callingController_:SetSelectedState("normal")

				arg_173_1.keyicon_.color = Color.New(1, 1, 1)
				arg_173_1.icon_.color = Color.New(1, 1, 1)

				local var_176_3 = arg_173_1:GetWordFromCfg(111041041)
				local var_176_4 = arg_173_1:FormatText(var_176_3.content)

				arg_173_1.text_.text = var_176_4

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_5 = 17
				local var_176_6 = utf8.len(var_176_4)
				local var_176_7 = var_176_5 <= 0 and var_176_1 or var_176_1 * (var_176_6 / var_176_5)

				if var_176_7 > 0 and var_176_1 < var_176_7 then
					arg_173_1.talkMaxDuration = var_176_7

					if var_176_7 + var_176_0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_7 + var_176_0
					end
				end

				arg_173_1.text_.text = var_176_4
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111041", "111041041", "story_v_out_111041.awb") ~= 0 then
					local var_176_8 = manager.audio:GetVoiceLength("story_v_out_111041", "111041041", "story_v_out_111041.awb") / 1000

					if var_176_8 + var_176_0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_8 + var_176_0
					end

					if var_176_3.prefab_name ~= "" and arg_173_1.actors_[var_176_3.prefab_name] ~= nil then
						local var_176_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_3.prefab_name].transform, "story_v_out_111041", "111041041", "story_v_out_111041.awb")

						arg_173_1:RecordAudio("111041041", var_176_9)
						arg_173_1:RecordAudio("111041041", var_176_9)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_111041", "111041041", "story_v_out_111041.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_111041", "111041041", "story_v_out_111041.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_10 = math.max(var_176_1, arg_173_1.talkMaxDuration)

			if var_176_0 <= arg_173_1.time_ and arg_173_1.time_ < var_176_0 + var_176_10 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_0) / var_176_10

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_0 + var_176_10 and arg_173_1.time_ < var_176_0 + var_176_10 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play111041042 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 111041042
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play111041043(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0
			local var_180_1 = 0.075

			if var_180_0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_2 = arg_177_1:FormatText(StoryNameCfg[7].name)

				arg_177_1.leftNameTxt_.text = var_180_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, true)
				arg_177_1.iconController_:SetSelectedState("hero")

				arg_177_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_177_1.callingController_:SetSelectedState("normal")

				arg_177_1.keyicon_.color = Color.New(1, 1, 1)
				arg_177_1.icon_.color = Color.New(1, 1, 1)

				local var_180_3 = arg_177_1:GetWordFromCfg(111041042)
				local var_180_4 = arg_177_1:FormatText(var_180_3.content)

				arg_177_1.text_.text = var_180_4

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_5 = 3
				local var_180_6 = utf8.len(var_180_4)
				local var_180_7 = var_180_5 <= 0 and var_180_1 or var_180_1 * (var_180_6 / var_180_5)

				if var_180_7 > 0 and var_180_1 < var_180_7 then
					arg_177_1.talkMaxDuration = var_180_7

					if var_180_7 + var_180_0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_7 + var_180_0
					end
				end

				arg_177_1.text_.text = var_180_4
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_8 = math.max(var_180_1, arg_177_1.talkMaxDuration)

			if var_180_0 <= arg_177_1.time_ and arg_177_1.time_ < var_180_0 + var_180_8 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_0) / var_180_8

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_0 + var_180_8 and arg_177_1.time_ < var_180_0 + var_180_8 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play111041043 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 111041043
		arg_181_1.duration_ = 7

		local var_181_0 = {
			ja = 7,
			ko = 4.133,
			zh = 5.533,
			en = 4.8
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
				arg_181_0:Play111041044(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0
			local var_184_1 = 0.625

			if var_184_0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_2 = arg_181_1:FormatText(StoryNameCfg[183].name)

				arg_181_1.leftNameTxt_.text = var_184_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, true)
				arg_181_1.iconController_:SetSelectedState("hero")

				arg_181_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_181_1.callingController_:SetSelectedState("normal")

				arg_181_1.keyicon_.color = Color.New(1, 1, 1)
				arg_181_1.icon_.color = Color.New(1, 1, 1)

				local var_184_3 = arg_181_1:GetWordFromCfg(111041043)
				local var_184_4 = arg_181_1:FormatText(var_184_3.content)

				arg_181_1.text_.text = var_184_4

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_5 = 24
				local var_184_6 = utf8.len(var_184_4)
				local var_184_7 = var_184_5 <= 0 and var_184_1 or var_184_1 * (var_184_6 / var_184_5)

				if var_184_7 > 0 and var_184_1 < var_184_7 then
					arg_181_1.talkMaxDuration = var_184_7

					if var_184_7 + var_184_0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_7 + var_184_0
					end
				end

				arg_181_1.text_.text = var_184_4
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111041", "111041043", "story_v_out_111041.awb") ~= 0 then
					local var_184_8 = manager.audio:GetVoiceLength("story_v_out_111041", "111041043", "story_v_out_111041.awb") / 1000

					if var_184_8 + var_184_0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_8 + var_184_0
					end

					if var_184_3.prefab_name ~= "" and arg_181_1.actors_[var_184_3.prefab_name] ~= nil then
						local var_184_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_3.prefab_name].transform, "story_v_out_111041", "111041043", "story_v_out_111041.awb")

						arg_181_1:RecordAudio("111041043", var_184_9)
						arg_181_1:RecordAudio("111041043", var_184_9)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_111041", "111041043", "story_v_out_111041.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_111041", "111041043", "story_v_out_111041.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_10 = math.max(var_184_1, arg_181_1.talkMaxDuration)

			if var_184_0 <= arg_181_1.time_ and arg_181_1.time_ < var_184_0 + var_184_10 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_0) / var_184_10

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_0 + var_184_10 and arg_181_1.time_ < var_184_0 + var_184_10 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play111041044 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 111041044
		arg_185_1.duration_ = 12.3

		local var_185_0 = {
			ja = 12.3,
			ko = 10.266,
			zh = 10.9,
			en = 11.033
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
				arg_185_0:Play111041045(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0
			local var_188_1 = 1.45

			if var_188_0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_2 = arg_185_1:FormatText(StoryNameCfg[183].name)

				arg_185_1.leftNameTxt_.text = var_188_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, true)
				arg_185_1.iconController_:SetSelectedState("hero")

				arg_185_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_185_1.callingController_:SetSelectedState("normal")

				arg_185_1.keyicon_.color = Color.New(1, 1, 1)
				arg_185_1.icon_.color = Color.New(1, 1, 1)

				local var_188_3 = arg_185_1:GetWordFromCfg(111041044)
				local var_188_4 = arg_185_1:FormatText(var_188_3.content)

				arg_185_1.text_.text = var_188_4

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_5 = 58
				local var_188_6 = utf8.len(var_188_4)
				local var_188_7 = var_188_5 <= 0 and var_188_1 or var_188_1 * (var_188_6 / var_188_5)

				if var_188_7 > 0 and var_188_1 < var_188_7 then
					arg_185_1.talkMaxDuration = var_188_7

					if var_188_7 + var_188_0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_7 + var_188_0
					end
				end

				arg_185_1.text_.text = var_188_4
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111041", "111041044", "story_v_out_111041.awb") ~= 0 then
					local var_188_8 = manager.audio:GetVoiceLength("story_v_out_111041", "111041044", "story_v_out_111041.awb") / 1000

					if var_188_8 + var_188_0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_8 + var_188_0
					end

					if var_188_3.prefab_name ~= "" and arg_185_1.actors_[var_188_3.prefab_name] ~= nil then
						local var_188_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_3.prefab_name].transform, "story_v_out_111041", "111041044", "story_v_out_111041.awb")

						arg_185_1:RecordAudio("111041044", var_188_9)
						arg_185_1:RecordAudio("111041044", var_188_9)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_111041", "111041044", "story_v_out_111041.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_111041", "111041044", "story_v_out_111041.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_10 = math.max(var_188_1, arg_185_1.talkMaxDuration)

			if var_188_0 <= arg_185_1.time_ and arg_185_1.time_ < var_188_0 + var_188_10 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_0) / var_188_10

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_0 + var_188_10 and arg_185_1.time_ < var_188_0 + var_188_10 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play111041045 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 111041045
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play111041046(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0
			local var_192_1 = 0.675

			if var_192_0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, false)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_2 = arg_189_1:GetWordFromCfg(111041045)
				local var_192_3 = arg_189_1:FormatText(var_192_2.content)

				arg_189_1.text_.text = var_192_3

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_4 = 27
				local var_192_5 = utf8.len(var_192_3)
				local var_192_6 = var_192_4 <= 0 and var_192_1 or var_192_1 * (var_192_5 / var_192_4)

				if var_192_6 > 0 and var_192_1 < var_192_6 then
					arg_189_1.talkMaxDuration = var_192_6

					if var_192_6 + var_192_0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_6 + var_192_0
					end
				end

				arg_189_1.text_.text = var_192_3
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_7 = math.max(var_192_1, arg_189_1.talkMaxDuration)

			if var_192_0 <= arg_189_1.time_ and arg_189_1.time_ < var_192_0 + var_192_7 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_0) / var_192_7

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_0 + var_192_7 and arg_189_1.time_ < var_192_0 + var_192_7 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play111041046 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 111041046
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play111041047(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0
			local var_196_1 = 0.3

			if var_196_0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_2 = arg_193_1:FormatText(StoryNameCfg[7].name)

				arg_193_1.leftNameTxt_.text = var_196_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, true)
				arg_193_1.iconController_:SetSelectedState("hero")

				arg_193_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_193_1.callingController_:SetSelectedState("normal")

				arg_193_1.keyicon_.color = Color.New(1, 1, 1)
				arg_193_1.icon_.color = Color.New(1, 1, 1)

				local var_196_3 = arg_193_1:GetWordFromCfg(111041046)
				local var_196_4 = arg_193_1:FormatText(var_196_3.content)

				arg_193_1.text_.text = var_196_4

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_5 = 12
				local var_196_6 = utf8.len(var_196_4)
				local var_196_7 = var_196_5 <= 0 and var_196_1 or var_196_1 * (var_196_6 / var_196_5)

				if var_196_7 > 0 and var_196_1 < var_196_7 then
					arg_193_1.talkMaxDuration = var_196_7

					if var_196_7 + var_196_0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_7 + var_196_0
					end
				end

				arg_193_1.text_.text = var_196_4
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_8 = math.max(var_196_1, arg_193_1.talkMaxDuration)

			if var_196_0 <= arg_193_1.time_ and arg_193_1.time_ < var_196_0 + var_196_8 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_0) / var_196_8

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_0 + var_196_8 and arg_193_1.time_ < var_196_0 + var_196_8 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play111041047 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 111041047
		arg_197_1.duration_ = 0.03

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"

			SetActive(arg_197_1.choicesGo_, true)

			for iter_198_0, iter_198_1 in ipairs(arg_197_1.choices_) do
				local var_198_0 = iter_198_0 <= 1

				SetActive(iter_198_1.go, var_198_0)
			end

			arg_197_1.choices_[1].txt.text = arg_197_1:FormatText(StoryChoiceCfg[114].name)
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play111041048(arg_197_1)
			end

			arg_197_1:RecordChoiceLog(111041047, 114)
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			return
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play111041048 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 111041048
		arg_201_1.duration_ = 8

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play111041049(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 1.5

			if var_204_0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_0 + arg_204_0 then
				local var_204_1 = manager.ui.mainCamera.transform.localPosition
				local var_204_2 = Vector3.New(0, 0, 10) + Vector3.New(var_204_1.x, var_204_1.y, 0)
				local var_204_3 = arg_201_1.bgs_.D06_1

				var_204_3.transform.localPosition = var_204_2
				var_204_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_204_4 = var_204_3:GetComponent("SpriteRenderer")

				if var_204_4 and var_204_4.sprite then
					local var_204_5 = (var_204_3.transform.localPosition - var_204_1).z
					local var_204_6 = manager.ui.mainCameraCom_
					local var_204_7 = 2 * var_204_5 * Mathf.Tan(var_204_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_204_8 = var_204_7 * var_204_6.aspect
					local var_204_9 = var_204_4.sprite.bounds.size.x
					local var_204_10 = var_204_4.sprite.bounds.size.y
					local var_204_11 = var_204_8 / var_204_9
					local var_204_12 = var_204_7 / var_204_10
					local var_204_13 = var_204_12 < var_204_11 and var_204_11 or var_204_12

					var_204_3.transform.localScale = Vector3.New(var_204_13, var_204_13, 0)
				end

				for iter_204_0, iter_204_1 in pairs(arg_201_1.bgs_) do
					if iter_204_0 ~= "D06_1" then
						iter_204_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_204_14 = arg_201_1.bgs_.D06_1
			local var_204_15 = 1.5

			if var_204_15 < arg_201_1.time_ and arg_201_1.time_ <= var_204_15 + arg_204_0 then
				local var_204_16 = var_204_14:GetComponent("SpriteRenderer")

				if var_204_16 then
					arg_201_1.var_.alphaOldValueD06_1 = var_204_16.color.a
					arg_201_1.var_.alphaMatValueD06_1 = var_204_16
				end

				arg_201_1.var_.alphaOldValueD06_1 = 0
			end

			local var_204_17 = 1.5

			if var_204_15 <= arg_201_1.time_ and arg_201_1.time_ < var_204_15 + var_204_17 then
				local var_204_18 = (arg_201_1.time_ - var_204_15) / var_204_17
				local var_204_19 = Mathf.Lerp(arg_201_1.var_.alphaOldValueD06_1, 1, var_204_18)

				if arg_201_1.var_.alphaMatValueD06_1 then
					local var_204_20 = arg_201_1.var_.alphaMatValueD06_1.color

					var_204_20.a = var_204_19
					arg_201_1.var_.alphaMatValueD06_1.color = var_204_20
				end
			end

			if arg_201_1.time_ >= var_204_15 + var_204_17 and arg_201_1.time_ < var_204_15 + var_204_17 + arg_204_0 and arg_201_1.var_.alphaMatValueD06_1 then
				local var_204_21 = arg_201_1.var_.alphaMatValueD06_1
				local var_204_22 = var_204_21.color

				var_204_22.a = 1
				var_204_21.color = var_204_22
			end

			local var_204_23 = arg_201_1.bgs_.AS0103
			local var_204_24 = 0

			if var_204_24 < arg_201_1.time_ and arg_201_1.time_ <= var_204_24 + arg_204_0 then
				local var_204_25 = var_204_23:GetComponent("SpriteRenderer")

				if var_204_25 then
					arg_201_1.var_.alphaOldValueAS0103 = var_204_25.color.a
					arg_201_1.var_.alphaMatValueAS0103 = var_204_25
				end

				arg_201_1.var_.alphaOldValueAS0103 = 1
			end

			local var_204_26 = 1.5

			if var_204_24 <= arg_201_1.time_ and arg_201_1.time_ < var_204_24 + var_204_26 then
				local var_204_27 = (arg_201_1.time_ - var_204_24) / var_204_26
				local var_204_28 = Mathf.Lerp(arg_201_1.var_.alphaOldValueAS0103, 0, var_204_27)

				if arg_201_1.var_.alphaMatValueAS0103 then
					local var_204_29 = arg_201_1.var_.alphaMatValueAS0103.color

					var_204_29.a = var_204_28
					arg_201_1.var_.alphaMatValueAS0103.color = var_204_29
				end
			end

			if arg_201_1.time_ >= var_204_24 + var_204_26 and arg_201_1.time_ < var_204_24 + var_204_26 + arg_204_0 and arg_201_1.var_.alphaMatValueAS0103 then
				local var_204_30 = arg_201_1.var_.alphaMatValueAS0103
				local var_204_31 = var_204_30.color

				var_204_31.a = 0
				var_204_30.color = var_204_31
			end

			local var_204_32 = 0

			if var_204_32 < arg_201_1.time_ and arg_201_1.time_ <= var_204_32 + arg_204_0 then
				arg_201_1.allBtn_.enabled = false
			end

			local var_204_33 = 3

			if arg_201_1.time_ >= var_204_32 + var_204_33 and arg_201_1.time_ < var_204_32 + var_204_33 + arg_204_0 then
				arg_201_1.allBtn_.enabled = true
			end

			if arg_201_1.frameCnt_ <= 1 then
				arg_201_1.dialog_:SetActive(false)
			end

			local var_204_34 = 3
			local var_204_35 = 0.3

			if var_204_34 < arg_201_1.time_ and arg_201_1.time_ <= var_204_34 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0

				arg_201_1.dialog_:SetActive(true)

				arg_201_1.dialogCg_.alpha = 0

				local var_204_36 = LeanTween.value(arg_201_1.dialog_, 0, 1, 0.3)

				var_204_36:setOnUpdate(LuaHelper.FloatAction(function(arg_205_0)
					arg_201_1.dialogCg_.alpha = arg_205_0
				end))
				var_204_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_201_1.dialog_)
					var_204_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_201_1.duration_ = arg_201_1.duration_ + 0.3

				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_37 = arg_201_1:FormatText(StoryNameCfg[7].name)

				arg_201_1.leftNameTxt_.text = var_204_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, true)
				arg_201_1.iconController_:SetSelectedState("hero")

				arg_201_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_201_1.callingController_:SetSelectedState("normal")

				arg_201_1.keyicon_.color = Color.New(1, 1, 1)
				arg_201_1.icon_.color = Color.New(1, 1, 1)

				local var_204_38 = arg_201_1:GetWordFromCfg(111041048)
				local var_204_39 = arg_201_1:FormatText(var_204_38.content)

				arg_201_1.text_.text = var_204_39

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_40 = 12
				local var_204_41 = utf8.len(var_204_39)
				local var_204_42 = var_204_40 <= 0 and var_204_35 or var_204_35 * (var_204_41 / var_204_40)

				if var_204_42 > 0 and var_204_35 < var_204_42 then
					arg_201_1.talkMaxDuration = var_204_42
					var_204_34 = var_204_34 + 0.3

					if var_204_42 + var_204_34 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_42 + var_204_34
					end
				end

				arg_201_1.text_.text = var_204_39
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_43 = var_204_34 + 0.3
			local var_204_44 = math.max(var_204_35, arg_201_1.talkMaxDuration)

			if var_204_43 <= arg_201_1.time_ and arg_201_1.time_ < var_204_43 + var_204_44 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_43) / var_204_44

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_43 + var_204_44 and arg_201_1.time_ < var_204_43 + var_204_44 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play111041049 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 111041049
		arg_207_1.duration_ = 10

		local var_207_0 = {
			ja = 5.7,
			ko = 9.3,
			zh = 8.966,
			en = 10
		}
		local var_207_1 = manager.audio:GetLocalizationFlag()

		if var_207_0[var_207_1] ~= nil then
			arg_207_1.duration_ = var_207_0[var_207_1]
		end

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play111041050(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 0
			local var_210_1 = 0.95

			if var_210_0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_2 = arg_207_1:FormatText(StoryNameCfg[183].name)

				arg_207_1.leftNameTxt_.text = var_210_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, true)
				arg_207_1.iconController_:SetSelectedState("hero")

				arg_207_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_207_1.callingController_:SetSelectedState("normal")

				arg_207_1.keyicon_.color = Color.New(1, 1, 1)
				arg_207_1.icon_.color = Color.New(1, 1, 1)

				local var_210_3 = arg_207_1:GetWordFromCfg(111041049)
				local var_210_4 = arg_207_1:FormatText(var_210_3.content)

				arg_207_1.text_.text = var_210_4

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_5 = 38
				local var_210_6 = utf8.len(var_210_4)
				local var_210_7 = var_210_5 <= 0 and var_210_1 or var_210_1 * (var_210_6 / var_210_5)

				if var_210_7 > 0 and var_210_1 < var_210_7 then
					arg_207_1.talkMaxDuration = var_210_7

					if var_210_7 + var_210_0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_7 + var_210_0
					end
				end

				arg_207_1.text_.text = var_210_4
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111041", "111041049", "story_v_out_111041.awb") ~= 0 then
					local var_210_8 = manager.audio:GetVoiceLength("story_v_out_111041", "111041049", "story_v_out_111041.awb") / 1000

					if var_210_8 + var_210_0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_8 + var_210_0
					end

					if var_210_3.prefab_name ~= "" and arg_207_1.actors_[var_210_3.prefab_name] ~= nil then
						local var_210_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_3.prefab_name].transform, "story_v_out_111041", "111041049", "story_v_out_111041.awb")

						arg_207_1:RecordAudio("111041049", var_210_9)
						arg_207_1:RecordAudio("111041049", var_210_9)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_111041", "111041049", "story_v_out_111041.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_111041", "111041049", "story_v_out_111041.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_10 = math.max(var_210_1, arg_207_1.talkMaxDuration)

			if var_210_0 <= arg_207_1.time_ and arg_207_1.time_ < var_210_0 + var_210_10 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_0) / var_210_10

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_0 + var_210_10 and arg_207_1.time_ < var_210_0 + var_210_10 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play111041050 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 111041050
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play111041051(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 0
			local var_214_1 = 0.7

			if var_214_0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_0 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				local var_214_2 = arg_211_1:FormatText(StoryNameCfg[7].name)

				arg_211_1.leftNameTxt_.text = var_214_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, true)
				arg_211_1.iconController_:SetSelectedState("hero")

				arg_211_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_211_1.callingController_:SetSelectedState("normal")

				arg_211_1.keyicon_.color = Color.New(1, 1, 1)
				arg_211_1.icon_.color = Color.New(1, 1, 1)

				local var_214_3 = arg_211_1:GetWordFromCfg(111041050)
				local var_214_4 = arg_211_1:FormatText(var_214_3.content)

				arg_211_1.text_.text = var_214_4

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_5 = 28
				local var_214_6 = utf8.len(var_214_4)
				local var_214_7 = var_214_5 <= 0 and var_214_1 or var_214_1 * (var_214_6 / var_214_5)

				if var_214_7 > 0 and var_214_1 < var_214_7 then
					arg_211_1.talkMaxDuration = var_214_7

					if var_214_7 + var_214_0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_7 + var_214_0
					end
				end

				arg_211_1.text_.text = var_214_4
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_8 = math.max(var_214_1, arg_211_1.talkMaxDuration)

			if var_214_0 <= arg_211_1.time_ and arg_211_1.time_ < var_214_0 + var_214_8 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_0) / var_214_8

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_0 + var_214_8 and arg_211_1.time_ < var_214_0 + var_214_8 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play111041051 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 111041051
		arg_215_1.duration_ = 7.77

		local var_215_0 = {
			ja = 7.133,
			ko = 4.966,
			zh = 7.766,
			en = 5.366
		}
		local var_215_1 = manager.audio:GetLocalizationFlag()

		if var_215_0[var_215_1] ~= nil then
			arg_215_1.duration_ = var_215_0[var_215_1]
		end

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play111041052(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 0
			local var_218_1 = 0.425

			if var_218_0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_2 = arg_215_1:FormatText(StoryNameCfg[183].name)

				arg_215_1.leftNameTxt_.text = var_218_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, true)
				arg_215_1.iconController_:SetSelectedState("hero")

				arg_215_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_215_1.callingController_:SetSelectedState("normal")

				arg_215_1.keyicon_.color = Color.New(1, 1, 1)
				arg_215_1.icon_.color = Color.New(1, 1, 1)

				local var_218_3 = arg_215_1:GetWordFromCfg(111041051)
				local var_218_4 = arg_215_1:FormatText(var_218_3.content)

				arg_215_1.text_.text = var_218_4

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_5 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_111041", "111041051", "story_v_out_111041.awb") ~= 0 then
					local var_218_8 = manager.audio:GetVoiceLength("story_v_out_111041", "111041051", "story_v_out_111041.awb") / 1000

					if var_218_8 + var_218_0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_8 + var_218_0
					end

					if var_218_3.prefab_name ~= "" and arg_215_1.actors_[var_218_3.prefab_name] ~= nil then
						local var_218_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_3.prefab_name].transform, "story_v_out_111041", "111041051", "story_v_out_111041.awb")

						arg_215_1:RecordAudio("111041051", var_218_9)
						arg_215_1:RecordAudio("111041051", var_218_9)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_111041", "111041051", "story_v_out_111041.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_111041", "111041051", "story_v_out_111041.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_10 = math.max(var_218_1, arg_215_1.talkMaxDuration)

			if var_218_0 <= arg_215_1.time_ and arg_215_1.time_ < var_218_0 + var_218_10 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_0) / var_218_10

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_0 + var_218_10 and arg_215_1.time_ < var_218_0 + var_218_10 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play111041052 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 111041052
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play111041053(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 0
			local var_222_1 = 1.1

			if var_222_0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, false)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_2 = arg_219_1:GetWordFromCfg(111041052)
				local var_222_3 = arg_219_1:FormatText(var_222_2.content)

				arg_219_1.text_.text = var_222_3

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_4 = 44
				local var_222_5 = utf8.len(var_222_3)
				local var_222_6 = var_222_4 <= 0 and var_222_1 or var_222_1 * (var_222_5 / var_222_4)

				if var_222_6 > 0 and var_222_1 < var_222_6 then
					arg_219_1.talkMaxDuration = var_222_6

					if var_222_6 + var_222_0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_6 + var_222_0
					end
				end

				arg_219_1.text_.text = var_222_3
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_7 = math.max(var_222_1, arg_219_1.talkMaxDuration)

			if var_222_0 <= arg_219_1.time_ and arg_219_1.time_ < var_222_0 + var_222_7 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_0) / var_222_7

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_0 + var_222_7 and arg_219_1.time_ < var_222_0 + var_222_7 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play111041053 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 111041053
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play111041054(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = 0
			local var_226_1 = 0.275

			if var_226_0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_0 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_2 = arg_223_1:FormatText(StoryNameCfg[7].name)

				arg_223_1.leftNameTxt_.text = var_226_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, true)
				arg_223_1.iconController_:SetSelectedState("hero")

				arg_223_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_223_1.callingController_:SetSelectedState("normal")

				arg_223_1.keyicon_.color = Color.New(1, 1, 1)
				arg_223_1.icon_.color = Color.New(1, 1, 1)

				local var_226_3 = arg_223_1:GetWordFromCfg(111041053)
				local var_226_4 = arg_223_1:FormatText(var_226_3.content)

				arg_223_1.text_.text = var_226_4

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_5 = 11
				local var_226_6 = utf8.len(var_226_4)
				local var_226_7 = var_226_5 <= 0 and var_226_1 or var_226_1 * (var_226_6 / var_226_5)

				if var_226_7 > 0 and var_226_1 < var_226_7 then
					arg_223_1.talkMaxDuration = var_226_7

					if var_226_7 + var_226_0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_7 + var_226_0
					end
				end

				arg_223_1.text_.text = var_226_4
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_8 = math.max(var_226_1, arg_223_1.talkMaxDuration)

			if var_226_0 <= arg_223_1.time_ and arg_223_1.time_ < var_226_0 + var_226_8 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_0) / var_226_8

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_0 + var_226_8 and arg_223_1.time_ < var_226_0 + var_226_8 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play111041054 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 111041054
		arg_227_1.duration_ = 5.03

		local var_227_0 = {
			ja = 5.033,
			ko = 3.8,
			zh = 4.766,
			en = 4.133
		}
		local var_227_1 = manager.audio:GetLocalizationFlag()

		if var_227_0[var_227_1] ~= nil then
			arg_227_1.duration_ = var_227_0[var_227_1]
		end

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play111041055(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 0
			local var_230_1 = 0.45

			if var_230_0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_2 = arg_227_1:FormatText(StoryNameCfg[183].name)

				arg_227_1.leftNameTxt_.text = var_230_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, true)
				arg_227_1.iconController_:SetSelectedState("hero")

				arg_227_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_227_1.callingController_:SetSelectedState("normal")

				arg_227_1.keyicon_.color = Color.New(1, 1, 1)
				arg_227_1.icon_.color = Color.New(1, 1, 1)

				local var_230_3 = arg_227_1:GetWordFromCfg(111041054)
				local var_230_4 = arg_227_1:FormatText(var_230_3.content)

				arg_227_1.text_.text = var_230_4

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_5 = 19
				local var_230_6 = utf8.len(var_230_4)
				local var_230_7 = var_230_5 <= 0 and var_230_1 or var_230_1 * (var_230_6 / var_230_5)

				if var_230_7 > 0 and var_230_1 < var_230_7 then
					arg_227_1.talkMaxDuration = var_230_7

					if var_230_7 + var_230_0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_7 + var_230_0
					end
				end

				arg_227_1.text_.text = var_230_4
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111041", "111041054", "story_v_out_111041.awb") ~= 0 then
					local var_230_8 = manager.audio:GetVoiceLength("story_v_out_111041", "111041054", "story_v_out_111041.awb") / 1000

					if var_230_8 + var_230_0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_8 + var_230_0
					end

					if var_230_3.prefab_name ~= "" and arg_227_1.actors_[var_230_3.prefab_name] ~= nil then
						local var_230_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_3.prefab_name].transform, "story_v_out_111041", "111041054", "story_v_out_111041.awb")

						arg_227_1:RecordAudio("111041054", var_230_9)
						arg_227_1:RecordAudio("111041054", var_230_9)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_111041", "111041054", "story_v_out_111041.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_111041", "111041054", "story_v_out_111041.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_10 = math.max(var_230_1, arg_227_1.talkMaxDuration)

			if var_230_0 <= arg_227_1.time_ and arg_227_1.time_ < var_230_0 + var_230_10 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_0) / var_230_10

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_0 + var_230_10 and arg_227_1.time_ < var_230_0 + var_230_10 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play111041055 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 111041055
		arg_231_1.duration_ = 6.87

		local var_231_0 = {
			ja = 6.866,
			ko = 4.5,
			zh = 6.766,
			en = 6.3
		}
		local var_231_1 = manager.audio:GetLocalizationFlag()

		if var_231_0[var_231_1] ~= nil then
			arg_231_1.duration_ = var_231_0[var_231_1]
		end

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play111041056(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = 0
			local var_234_1 = 0.5

			if var_234_0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_0 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_2 = arg_231_1:FormatText(StoryNameCfg[183].name)

				arg_231_1.leftNameTxt_.text = var_234_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, true)
				arg_231_1.iconController_:SetSelectedState("hero")

				arg_231_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_231_1.callingController_:SetSelectedState("normal")

				arg_231_1.keyicon_.color = Color.New(1, 1, 1)
				arg_231_1.icon_.color = Color.New(1, 1, 1)

				local var_234_3 = arg_231_1:GetWordFromCfg(111041055)
				local var_234_4 = arg_231_1:FormatText(var_234_3.content)

				arg_231_1.text_.text = var_234_4

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_5 = 20
				local var_234_6 = utf8.len(var_234_4)
				local var_234_7 = var_234_5 <= 0 and var_234_1 or var_234_1 * (var_234_6 / var_234_5)

				if var_234_7 > 0 and var_234_1 < var_234_7 then
					arg_231_1.talkMaxDuration = var_234_7

					if var_234_7 + var_234_0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_7 + var_234_0
					end
				end

				arg_231_1.text_.text = var_234_4
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111041", "111041055", "story_v_out_111041.awb") ~= 0 then
					local var_234_8 = manager.audio:GetVoiceLength("story_v_out_111041", "111041055", "story_v_out_111041.awb") / 1000

					if var_234_8 + var_234_0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_8 + var_234_0
					end

					if var_234_3.prefab_name ~= "" and arg_231_1.actors_[var_234_3.prefab_name] ~= nil then
						local var_234_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_3.prefab_name].transform, "story_v_out_111041", "111041055", "story_v_out_111041.awb")

						arg_231_1:RecordAudio("111041055", var_234_9)
						arg_231_1:RecordAudio("111041055", var_234_9)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_111041", "111041055", "story_v_out_111041.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_111041", "111041055", "story_v_out_111041.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_10 = math.max(var_234_1, arg_231_1.talkMaxDuration)

			if var_234_0 <= arg_231_1.time_ and arg_231_1.time_ < var_234_0 + var_234_10 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_0) / var_234_10

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_0 + var_234_10 and arg_231_1.time_ < var_234_0 + var_234_10 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play111041056 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 111041056
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play111041057(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 0
			local var_238_1 = 0.325

			if var_238_0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_2 = arg_235_1:FormatText(StoryNameCfg[7].name)

				arg_235_1.leftNameTxt_.text = var_238_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, true)
				arg_235_1.iconController_:SetSelectedState("hero")

				arg_235_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_235_1.callingController_:SetSelectedState("normal")

				arg_235_1.keyicon_.color = Color.New(1, 1, 1)
				arg_235_1.icon_.color = Color.New(1, 1, 1)

				local var_238_3 = arg_235_1:GetWordFromCfg(111041056)
				local var_238_4 = arg_235_1:FormatText(var_238_3.content)

				arg_235_1.text_.text = var_238_4

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_5 = 13
				local var_238_6 = utf8.len(var_238_4)
				local var_238_7 = var_238_5 <= 0 and var_238_1 or var_238_1 * (var_238_6 / var_238_5)

				if var_238_7 > 0 and var_238_1 < var_238_7 then
					arg_235_1.talkMaxDuration = var_238_7

					if var_238_7 + var_238_0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_7 + var_238_0
					end
				end

				arg_235_1.text_.text = var_238_4
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_8 = math.max(var_238_1, arg_235_1.talkMaxDuration)

			if var_238_0 <= arg_235_1.time_ and arg_235_1.time_ < var_238_0 + var_238_8 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_0) / var_238_8

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_0 + var_238_8 and arg_235_1.time_ < var_238_0 + var_238_8 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play111041057 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 111041057
		arg_239_1.duration_ = 7.67

		local var_239_0 = {
			ja = 7.333,
			ko = 6.233,
			zh = 7.2,
			en = 7.666
		}
		local var_239_1 = manager.audio:GetLocalizationFlag()

		if var_239_0[var_239_1] ~= nil then
			arg_239_1.duration_ = var_239_0[var_239_1]
		end

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play111041058(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0
			local var_242_1 = 0.65

			if var_242_0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_2 = arg_239_1:FormatText(StoryNameCfg[183].name)

				arg_239_1.leftNameTxt_.text = var_242_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, true)
				arg_239_1.iconController_:SetSelectedState("hero")

				arg_239_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_239_1.callingController_:SetSelectedState("normal")

				arg_239_1.keyicon_.color = Color.New(1, 1, 1)
				arg_239_1.icon_.color = Color.New(1, 1, 1)

				local var_242_3 = arg_239_1:GetWordFromCfg(111041057)
				local var_242_4 = arg_239_1:FormatText(var_242_3.content)

				arg_239_1.text_.text = var_242_4

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_5 = 26
				local var_242_6 = utf8.len(var_242_4)
				local var_242_7 = var_242_5 <= 0 and var_242_1 or var_242_1 * (var_242_6 / var_242_5)

				if var_242_7 > 0 and var_242_1 < var_242_7 then
					arg_239_1.talkMaxDuration = var_242_7

					if var_242_7 + var_242_0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_7 + var_242_0
					end
				end

				arg_239_1.text_.text = var_242_4
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111041", "111041057", "story_v_out_111041.awb") ~= 0 then
					local var_242_8 = manager.audio:GetVoiceLength("story_v_out_111041", "111041057", "story_v_out_111041.awb") / 1000

					if var_242_8 + var_242_0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_8 + var_242_0
					end

					if var_242_3.prefab_name ~= "" and arg_239_1.actors_[var_242_3.prefab_name] ~= nil then
						local var_242_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_3.prefab_name].transform, "story_v_out_111041", "111041057", "story_v_out_111041.awb")

						arg_239_1:RecordAudio("111041057", var_242_9)
						arg_239_1:RecordAudio("111041057", var_242_9)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_111041", "111041057", "story_v_out_111041.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_111041", "111041057", "story_v_out_111041.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_10 = math.max(var_242_1, arg_239_1.talkMaxDuration)

			if var_242_0 <= arg_239_1.time_ and arg_239_1.time_ < var_242_0 + var_242_10 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_0) / var_242_10

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_0 + var_242_10 and arg_239_1.time_ < var_242_0 + var_242_10 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play111041058 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 111041058
		arg_243_1.duration_ = 13.3

		local var_243_0 = {
			ja = 13.3,
			ko = 9.7,
			zh = 9.333,
			en = 8.633
		}
		local var_243_1 = manager.audio:GetLocalizationFlag()

		if var_243_0[var_243_1] ~= nil then
			arg_243_1.duration_ = var_243_0[var_243_1]
		end

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play111041059(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 0
			local var_246_1 = 0.9

			if var_246_0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_0 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_2 = arg_243_1:FormatText(StoryNameCfg[183].name)

				arg_243_1.leftNameTxt_.text = var_246_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, true)
				arg_243_1.iconController_:SetSelectedState("hero")

				arg_243_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_243_1.callingController_:SetSelectedState("normal")

				arg_243_1.keyicon_.color = Color.New(1, 1, 1)
				arg_243_1.icon_.color = Color.New(1, 1, 1)

				local var_246_3 = arg_243_1:GetWordFromCfg(111041058)
				local var_246_4 = arg_243_1:FormatText(var_246_3.content)

				arg_243_1.text_.text = var_246_4

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_5 = 36
				local var_246_6 = utf8.len(var_246_4)
				local var_246_7 = var_246_5 <= 0 and var_246_1 or var_246_1 * (var_246_6 / var_246_5)

				if var_246_7 > 0 and var_246_1 < var_246_7 then
					arg_243_1.talkMaxDuration = var_246_7

					if var_246_7 + var_246_0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_7 + var_246_0
					end
				end

				arg_243_1.text_.text = var_246_4
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111041", "111041058", "story_v_out_111041.awb") ~= 0 then
					local var_246_8 = manager.audio:GetVoiceLength("story_v_out_111041", "111041058", "story_v_out_111041.awb") / 1000

					if var_246_8 + var_246_0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_8 + var_246_0
					end

					if var_246_3.prefab_name ~= "" and arg_243_1.actors_[var_246_3.prefab_name] ~= nil then
						local var_246_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_3.prefab_name].transform, "story_v_out_111041", "111041058", "story_v_out_111041.awb")

						arg_243_1:RecordAudio("111041058", var_246_9)
						arg_243_1:RecordAudio("111041058", var_246_9)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_111041", "111041058", "story_v_out_111041.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_111041", "111041058", "story_v_out_111041.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_10 = math.max(var_246_1, arg_243_1.talkMaxDuration)

			if var_246_0 <= arg_243_1.time_ and arg_243_1.time_ < var_246_0 + var_246_10 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_0) / var_246_10

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_0 + var_246_10 and arg_243_1.time_ < var_246_0 + var_246_10 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play111041059 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 111041059
		arg_247_1.duration_ = 5

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play111041060(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = 0
			local var_250_1 = 0.175

			if var_250_0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_0 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_2 = arg_247_1:FormatText(StoryNameCfg[7].name)

				arg_247_1.leftNameTxt_.text = var_250_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, true)
				arg_247_1.iconController_:SetSelectedState("hero")

				arg_247_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_247_1.callingController_:SetSelectedState("normal")

				arg_247_1.keyicon_.color = Color.New(1, 1, 1)
				arg_247_1.icon_.color = Color.New(1, 1, 1)

				local var_250_3 = arg_247_1:GetWordFromCfg(111041059)
				local var_250_4 = arg_247_1:FormatText(var_250_3.content)

				arg_247_1.text_.text = var_250_4

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_5 = 7
				local var_250_6 = utf8.len(var_250_4)
				local var_250_7 = var_250_5 <= 0 and var_250_1 or var_250_1 * (var_250_6 / var_250_5)

				if var_250_7 > 0 and var_250_1 < var_250_7 then
					arg_247_1.talkMaxDuration = var_250_7

					if var_250_7 + var_250_0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_7 + var_250_0
					end
				end

				arg_247_1.text_.text = var_250_4
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)
				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_8 = math.max(var_250_1, arg_247_1.talkMaxDuration)

			if var_250_0 <= arg_247_1.time_ and arg_247_1.time_ < var_250_0 + var_250_8 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_0) / var_250_8

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_0 + var_250_8 and arg_247_1.time_ < var_250_0 + var_250_8 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play111041060 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 111041060
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play111041061(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = 0
			local var_254_1 = 1.275

			if var_254_0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_0 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, false)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_2 = arg_251_1:GetWordFromCfg(111041060)
				local var_254_3 = arg_251_1:FormatText(var_254_2.content)

				arg_251_1.text_.text = var_254_3

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_4 = 51
				local var_254_5 = utf8.len(var_254_3)
				local var_254_6 = var_254_4 <= 0 and var_254_1 or var_254_1 * (var_254_5 / var_254_4)

				if var_254_6 > 0 and var_254_1 < var_254_6 then
					arg_251_1.talkMaxDuration = var_254_6

					if var_254_6 + var_254_0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_6 + var_254_0
					end
				end

				arg_251_1.text_.text = var_254_3
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_7 = math.max(var_254_1, arg_251_1.talkMaxDuration)

			if var_254_0 <= arg_251_1.time_ and arg_251_1.time_ < var_254_0 + var_254_7 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_0) / var_254_7

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_0 + var_254_7 and arg_251_1.time_ < var_254_0 + var_254_7 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play111041061 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 111041061
		arg_255_1.duration_ = 5

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play111041062(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = 0
			local var_258_1 = 1.525

			if var_258_0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_0 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, false)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_2 = arg_255_1:GetWordFromCfg(111041061)
				local var_258_3 = arg_255_1:FormatText(var_258_2.content)

				arg_255_1.text_.text = var_258_3

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_4 = 61
				local var_258_5 = utf8.len(var_258_3)
				local var_258_6 = var_258_4 <= 0 and var_258_1 or var_258_1 * (var_258_5 / var_258_4)

				if var_258_6 > 0 and var_258_1 < var_258_6 then
					arg_255_1.talkMaxDuration = var_258_6

					if var_258_6 + var_258_0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_6 + var_258_0
					end
				end

				arg_255_1.text_.text = var_258_3
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)
				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_7 = math.max(var_258_1, arg_255_1.talkMaxDuration)

			if var_258_0 <= arg_255_1.time_ and arg_255_1.time_ < var_258_0 + var_258_7 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_0) / var_258_7

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_0 + var_258_7 and arg_255_1.time_ < var_258_0 + var_258_7 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play111041062 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 111041062
		arg_259_1.duration_ = 8

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play111041063(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = 1.5

			if var_262_0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_0 + arg_262_0 then
				local var_262_1 = manager.ui.mainCamera.transform.localPosition
				local var_262_2 = Vector3.New(0, 0, 10) + Vector3.New(var_262_1.x, var_262_1.y, 0)
				local var_262_3 = arg_259_1.bgs_.D999

				var_262_3.transform.localPosition = var_262_2
				var_262_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_262_4 = var_262_3:GetComponent("SpriteRenderer")

				if var_262_4 and var_262_4.sprite then
					local var_262_5 = (var_262_3.transform.localPosition - var_262_1).z
					local var_262_6 = manager.ui.mainCameraCom_
					local var_262_7 = 2 * var_262_5 * Mathf.Tan(var_262_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_262_8 = var_262_7 * var_262_6.aspect
					local var_262_9 = var_262_4.sprite.bounds.size.x
					local var_262_10 = var_262_4.sprite.bounds.size.y
					local var_262_11 = var_262_8 / var_262_9
					local var_262_12 = var_262_7 / var_262_10
					local var_262_13 = var_262_12 < var_262_11 and var_262_11 or var_262_12

					var_262_3.transform.localScale = Vector3.New(var_262_13, var_262_13, 0)
				end

				for iter_262_0, iter_262_1 in pairs(arg_259_1.bgs_) do
					if iter_262_0 ~= "D999" then
						iter_262_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_262_14 = arg_259_1.bgs_.D06_1
			local var_262_15 = 0

			if var_262_15 < arg_259_1.time_ and arg_259_1.time_ <= var_262_15 + arg_262_0 then
				local var_262_16 = var_262_14:GetComponent("SpriteRenderer")

				if var_262_16 then
					arg_259_1.var_.alphaOldValueD06_1 = var_262_16.color.a
					arg_259_1.var_.alphaMatValueD06_1 = var_262_16
				end

				arg_259_1.var_.alphaOldValueD06_1 = 1
			end

			local var_262_17 = 1.5

			if var_262_15 <= arg_259_1.time_ and arg_259_1.time_ < var_262_15 + var_262_17 then
				local var_262_18 = (arg_259_1.time_ - var_262_15) / var_262_17
				local var_262_19 = Mathf.Lerp(arg_259_1.var_.alphaOldValueD06_1, 0, var_262_18)

				if arg_259_1.var_.alphaMatValueD06_1 then
					local var_262_20 = arg_259_1.var_.alphaMatValueD06_1.color

					var_262_20.a = var_262_19
					arg_259_1.var_.alphaMatValueD06_1.color = var_262_20
				end
			end

			if arg_259_1.time_ >= var_262_15 + var_262_17 and arg_259_1.time_ < var_262_15 + var_262_17 + arg_262_0 and arg_259_1.var_.alphaMatValueD06_1 then
				local var_262_21 = arg_259_1.var_.alphaMatValueD06_1
				local var_262_22 = var_262_21.color

				var_262_22.a = 0
				var_262_21.color = var_262_22
			end

			local var_262_23 = 1.5

			if var_262_23 < arg_259_1.time_ and arg_259_1.time_ <= var_262_23 + arg_262_0 then
				arg_259_1.mask_.enabled = true
				arg_259_1.mask_.raycastTarget = false

				arg_259_1:SetGaussion(false)
			end

			local var_262_24 = 1.5

			if var_262_23 <= arg_259_1.time_ and arg_259_1.time_ < var_262_23 + var_262_24 then
				local var_262_25 = (arg_259_1.time_ - var_262_23) / var_262_24
				local var_262_26 = Color.New(1, 1, 1)

				var_262_26.a = Mathf.Lerp(1, 0, var_262_25)
				arg_259_1.mask_.color = var_262_26
			end

			if arg_259_1.time_ >= var_262_23 + var_262_24 and arg_259_1.time_ < var_262_23 + var_262_24 + arg_262_0 then
				local var_262_27 = Color.New(1, 1, 1)
				local var_262_28 = 0

				arg_259_1.mask_.enabled = false
				var_262_27.a = var_262_28
				arg_259_1.mask_.color = var_262_27
			end

			local var_262_29 = 0

			if var_262_29 < arg_259_1.time_ and arg_259_1.time_ <= var_262_29 + arg_262_0 then
				arg_259_1.allBtn_.enabled = false
			end

			local var_262_30 = 3

			if arg_259_1.time_ >= var_262_29 + var_262_30 and arg_259_1.time_ < var_262_29 + var_262_30 + arg_262_0 then
				arg_259_1.allBtn_.enabled = true
			end

			if arg_259_1.frameCnt_ <= 1 then
				arg_259_1.dialog_:SetActive(false)
			end

			local var_262_31 = 3
			local var_262_32 = 0.875

			if var_262_31 < arg_259_1.time_ and arg_259_1.time_ <= var_262_31 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0

				arg_259_1.dialog_:SetActive(true)

				arg_259_1.dialogCg_.alpha = 0

				local var_262_33 = LeanTween.value(arg_259_1.dialog_, 0, 1, 0.3)

				var_262_33:setOnUpdate(LuaHelper.FloatAction(function(arg_263_0)
					arg_259_1.dialogCg_.alpha = arg_263_0
				end))
				var_262_33:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_259_1.dialog_)
					var_262_33:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_259_1.duration_ = arg_259_1.duration_ + 0.3

				SetActive(arg_259_1.leftNameGo_, false)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_34 = arg_259_1:GetWordFromCfg(111041062)
				local var_262_35 = arg_259_1:FormatText(var_262_34.content)

				arg_259_1.text_.text = var_262_35

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_36 = 35
				local var_262_37 = utf8.len(var_262_35)
				local var_262_38 = var_262_36 <= 0 and var_262_32 or var_262_32 * (var_262_37 / var_262_36)

				if var_262_38 > 0 and var_262_32 < var_262_38 then
					arg_259_1.talkMaxDuration = var_262_38
					var_262_31 = var_262_31 + 0.3

					if var_262_38 + var_262_31 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_38 + var_262_31
					end
				end

				arg_259_1.text_.text = var_262_35
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)
				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_39 = var_262_31 + 0.3
			local var_262_40 = math.max(var_262_32, arg_259_1.talkMaxDuration)

			if var_262_39 <= arg_259_1.time_ and arg_259_1.time_ < var_262_39 + var_262_40 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_39) / var_262_40

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_39 + var_262_40 and arg_259_1.time_ < var_262_39 + var_262_40 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play111041063 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 111041063
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play111041064(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 0
			local var_268_1 = 1.25

			if var_268_0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_0 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, false)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_2 = arg_265_1:GetWordFromCfg(111041063)
				local var_268_3 = arg_265_1:FormatText(var_268_2.content)

				arg_265_1.text_.text = var_268_3

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_4 = 50
				local var_268_5 = utf8.len(var_268_3)
				local var_268_6 = var_268_4 <= 0 and var_268_1 or var_268_1 * (var_268_5 / var_268_4)

				if var_268_6 > 0 and var_268_1 < var_268_6 then
					arg_265_1.talkMaxDuration = var_268_6

					if var_268_6 + var_268_0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_6 + var_268_0
					end
				end

				arg_265_1.text_.text = var_268_3
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_7 = math.max(var_268_1, arg_265_1.talkMaxDuration)

			if var_268_0 <= arg_265_1.time_ and arg_265_1.time_ < var_268_0 + var_268_7 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_0) / var_268_7

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_0 + var_268_7 and arg_265_1.time_ < var_268_0 + var_268_7 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play111041064 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 111041064
		arg_269_1.duration_ = 5

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play111041065(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = 0
			local var_272_1 = 1.45

			if var_272_0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_0 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, false)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_2 = arg_269_1:GetWordFromCfg(111041064)
				local var_272_3 = arg_269_1:FormatText(var_272_2.content)

				arg_269_1.text_.text = var_272_3

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_4 = 58
				local var_272_5 = utf8.len(var_272_3)
				local var_272_6 = var_272_4 <= 0 and var_272_1 or var_272_1 * (var_272_5 / var_272_4)

				if var_272_6 > 0 and var_272_1 < var_272_6 then
					arg_269_1.talkMaxDuration = var_272_6

					if var_272_6 + var_272_0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_6 + var_272_0
					end
				end

				arg_269_1.text_.text = var_272_3
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)
				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_7 = math.max(var_272_1, arg_269_1.talkMaxDuration)

			if var_272_0 <= arg_269_1.time_ and arg_269_1.time_ < var_272_0 + var_272_7 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_0) / var_272_7

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_0 + var_272_7 and arg_269_1.time_ < var_272_0 + var_272_7 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play111041065 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 111041065
		arg_273_1.duration_ = 1.6

		local var_273_0 = {
			ja = 1.6,
			ko = 1.533,
			zh = 1.233,
			en = 1.233
		}
		local var_273_1 = manager.audio:GetLocalizationFlag()

		if var_273_0[var_273_1] ~= nil then
			arg_273_1.duration_ = var_273_0[var_273_1]
		end

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play111041066(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = 0
			local var_276_1 = 0.125

			if var_276_0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_0 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				local var_276_2 = arg_273_1:FormatText(StoryNameCfg[176].name)

				arg_273_1.leftNameTxt_.text = var_276_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, true)
				arg_273_1.iconController_:SetSelectedState("hero")

				arg_273_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_helena")

				arg_273_1.callingController_:SetSelectedState("normal")

				arg_273_1.keyicon_.color = Color.New(1, 1, 1)
				arg_273_1.icon_.color = Color.New(1, 1, 1)

				local var_276_3 = arg_273_1:GetWordFromCfg(111041065)
				local var_276_4 = arg_273_1:FormatText(var_276_3.content)

				arg_273_1.text_.text = var_276_4

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_5 = 5
				local var_276_6 = utf8.len(var_276_4)
				local var_276_7 = var_276_5 <= 0 and var_276_1 or var_276_1 * (var_276_6 / var_276_5)

				if var_276_7 > 0 and var_276_1 < var_276_7 then
					arg_273_1.talkMaxDuration = var_276_7

					if var_276_7 + var_276_0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_7 + var_276_0
					end
				end

				arg_273_1.text_.text = var_276_4
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111041", "111041065", "story_v_out_111041.awb") ~= 0 then
					local var_276_8 = manager.audio:GetVoiceLength("story_v_out_111041", "111041065", "story_v_out_111041.awb") / 1000

					if var_276_8 + var_276_0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_8 + var_276_0
					end

					if var_276_3.prefab_name ~= "" and arg_273_1.actors_[var_276_3.prefab_name] ~= nil then
						local var_276_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_3.prefab_name].transform, "story_v_out_111041", "111041065", "story_v_out_111041.awb")

						arg_273_1:RecordAudio("111041065", var_276_9)
						arg_273_1:RecordAudio("111041065", var_276_9)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_111041", "111041065", "story_v_out_111041.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_111041", "111041065", "story_v_out_111041.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_10 = math.max(var_276_1, arg_273_1.talkMaxDuration)

			if var_276_0 <= arg_273_1.time_ and arg_273_1.time_ < var_276_0 + var_276_10 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_0) / var_276_10

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_0 + var_276_10 and arg_273_1.time_ < var_276_0 + var_276_10 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play111041066 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 111041066
		arg_277_1.duration_ = 5

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play111041067(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 0
			local var_280_1 = 0.125

			if var_280_0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_2 = arg_277_1:FormatText(StoryNameCfg[7].name)

				arg_277_1.leftNameTxt_.text = var_280_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, true)
				arg_277_1.iconController_:SetSelectedState("hero")

				arg_277_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_277_1.callingController_:SetSelectedState("normal")

				arg_277_1.keyicon_.color = Color.New(1, 1, 1)
				arg_277_1.icon_.color = Color.New(1, 1, 1)

				local var_280_3 = arg_277_1:GetWordFromCfg(111041066)
				local var_280_4 = arg_277_1:FormatText(var_280_3.content)

				arg_277_1.text_.text = var_280_4

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_5 = 5
				local var_280_6 = utf8.len(var_280_4)
				local var_280_7 = var_280_5 <= 0 and var_280_1 or var_280_1 * (var_280_6 / var_280_5)

				if var_280_7 > 0 and var_280_1 < var_280_7 then
					arg_277_1.talkMaxDuration = var_280_7

					if var_280_7 + var_280_0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_7 + var_280_0
					end
				end

				arg_277_1.text_.text = var_280_4
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)
				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_8 = math.max(var_280_1, arg_277_1.talkMaxDuration)

			if var_280_0 <= arg_277_1.time_ and arg_277_1.time_ < var_280_0 + var_280_8 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_0) / var_280_8

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_0 + var_280_8 and arg_277_1.time_ < var_280_0 + var_280_8 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play111041067 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 111041067
		arg_281_1.duration_ = 4.8

		local var_281_0 = {
			ja = 3.533,
			ko = 3.166,
			zh = 4.8,
			en = 4.4
		}
		local var_281_1 = manager.audio:GetLocalizationFlag()

		if var_281_0[var_281_1] ~= nil then
			arg_281_1.duration_ = var_281_0[var_281_1]
		end

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play111041068(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 0
			local var_284_1 = 0.325

			if var_284_0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_0 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_2 = arg_281_1:FormatText(StoryNameCfg[182].name)

				arg_281_1.leftNameTxt_.text = var_284_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, true)
				arg_281_1.iconController_:SetSelectedState("hero")

				arg_281_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vena")

				arg_281_1.callingController_:SetSelectedState("normal")

				arg_281_1.keyicon_.color = Color.New(1, 1, 1)
				arg_281_1.icon_.color = Color.New(1, 1, 1)

				local var_284_3 = arg_281_1:GetWordFromCfg(111041067)
				local var_284_4 = arg_281_1:FormatText(var_284_3.content)

				arg_281_1.text_.text = var_284_4

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_5 = 13
				local var_284_6 = utf8.len(var_284_4)
				local var_284_7 = var_284_5 <= 0 and var_284_1 or var_284_1 * (var_284_6 / var_284_5)

				if var_284_7 > 0 and var_284_1 < var_284_7 then
					arg_281_1.talkMaxDuration = var_284_7

					if var_284_7 + var_284_0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_7 + var_284_0
					end
				end

				arg_281_1.text_.text = var_284_4
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111041", "111041067", "story_v_out_111041.awb") ~= 0 then
					local var_284_8 = manager.audio:GetVoiceLength("story_v_out_111041", "111041067", "story_v_out_111041.awb") / 1000

					if var_284_8 + var_284_0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_8 + var_284_0
					end

					if var_284_3.prefab_name ~= "" and arg_281_1.actors_[var_284_3.prefab_name] ~= nil then
						local var_284_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_3.prefab_name].transform, "story_v_out_111041", "111041067", "story_v_out_111041.awb")

						arg_281_1:RecordAudio("111041067", var_284_9)
						arg_281_1:RecordAudio("111041067", var_284_9)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_111041", "111041067", "story_v_out_111041.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_111041", "111041067", "story_v_out_111041.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_10 = math.max(var_284_1, arg_281_1.talkMaxDuration)

			if var_284_0 <= arg_281_1.time_ and arg_281_1.time_ < var_284_0 + var_284_10 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_0) / var_284_10

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_0 + var_284_10 and arg_281_1.time_ < var_284_0 + var_284_10 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play111041068 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 111041068
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play111041069(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = 0
			local var_288_1 = 1.3

			if var_288_0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_0 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, false)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_2 = arg_285_1:GetWordFromCfg(111041068)
				local var_288_3 = arg_285_1:FormatText(var_288_2.content)

				arg_285_1.text_.text = var_288_3

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_4 = 52
				local var_288_5 = utf8.len(var_288_3)
				local var_288_6 = var_288_4 <= 0 and var_288_1 or var_288_1 * (var_288_5 / var_288_4)

				if var_288_6 > 0 and var_288_1 < var_288_6 then
					arg_285_1.talkMaxDuration = var_288_6

					if var_288_6 + var_288_0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_6 + var_288_0
					end
				end

				arg_285_1.text_.text = var_288_3
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_7 = math.max(var_288_1, arg_285_1.talkMaxDuration)

			if var_288_0 <= arg_285_1.time_ and arg_285_1.time_ < var_288_0 + var_288_7 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_0) / var_288_7

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_0 + var_288_7 and arg_285_1.time_ < var_288_0 + var_288_7 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play111041069 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 111041069
		arg_289_1.duration_ = 3.2

		local var_289_0 = {
			ja = 3.2,
			ko = 2.733,
			zh = 2.7,
			en = 2.1
		}
		local var_289_1 = manager.audio:GetLocalizationFlag()

		if var_289_0[var_289_1] ~= nil then
			arg_289_1.duration_ = var_289_0[var_289_1]
		end

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play111041070(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = 0
			local var_292_1 = 0.3

			if var_292_0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_0 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				local var_292_2 = arg_289_1:FormatText(StoryNameCfg[176].name)

				arg_289_1.leftNameTxt_.text = var_292_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, true)
				arg_289_1.iconController_:SetSelectedState("hero")

				arg_289_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_helena")

				arg_289_1.callingController_:SetSelectedState("normal")

				arg_289_1.keyicon_.color = Color.New(1, 1, 1)
				arg_289_1.icon_.color = Color.New(1, 1, 1)

				local var_292_3 = arg_289_1:GetWordFromCfg(111041069)
				local var_292_4 = arg_289_1:FormatText(var_292_3.content)

				arg_289_1.text_.text = var_292_4

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_5 = 12
				local var_292_6 = utf8.len(var_292_4)
				local var_292_7 = var_292_5 <= 0 and var_292_1 or var_292_1 * (var_292_6 / var_292_5)

				if var_292_7 > 0 and var_292_1 < var_292_7 then
					arg_289_1.talkMaxDuration = var_292_7

					if var_292_7 + var_292_0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_7 + var_292_0
					end
				end

				arg_289_1.text_.text = var_292_4
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111041", "111041069", "story_v_out_111041.awb") ~= 0 then
					local var_292_8 = manager.audio:GetVoiceLength("story_v_out_111041", "111041069", "story_v_out_111041.awb") / 1000

					if var_292_8 + var_292_0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_8 + var_292_0
					end

					if var_292_3.prefab_name ~= "" and arg_289_1.actors_[var_292_3.prefab_name] ~= nil then
						local var_292_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_3.prefab_name].transform, "story_v_out_111041", "111041069", "story_v_out_111041.awb")

						arg_289_1:RecordAudio("111041069", var_292_9)
						arg_289_1:RecordAudio("111041069", var_292_9)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_111041", "111041069", "story_v_out_111041.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_111041", "111041069", "story_v_out_111041.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_10 = math.max(var_292_1, arg_289_1.talkMaxDuration)

			if var_292_0 <= arg_289_1.time_ and arg_289_1.time_ < var_292_0 + var_292_10 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_0) / var_292_10

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_0 + var_292_10 and arg_289_1.time_ < var_292_0 + var_292_10 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play111041070 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 111041070
		arg_293_1.duration_ = 7.43

		local var_293_0 = {
			ja = 7.433,
			ko = 4.5,
			zh = 6,
			en = 5.533
		}
		local var_293_1 = manager.audio:GetLocalizationFlag()

		if var_293_0[var_293_1] ~= nil then
			arg_293_1.duration_ = var_293_0[var_293_1]
		end

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play111041071(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = 0
			local var_296_1 = 0.45

			if var_296_0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_0 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				local var_296_2 = arg_293_1:FormatText(StoryNameCfg[182].name)

				arg_293_1.leftNameTxt_.text = var_296_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, true)
				arg_293_1.iconController_:SetSelectedState("hero")

				arg_293_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vena")

				arg_293_1.callingController_:SetSelectedState("normal")

				arg_293_1.keyicon_.color = Color.New(1, 1, 1)
				arg_293_1.icon_.color = Color.New(1, 1, 1)

				local var_296_3 = arg_293_1:GetWordFromCfg(111041070)
				local var_296_4 = arg_293_1:FormatText(var_296_3.content)

				arg_293_1.text_.text = var_296_4

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_5 = 18
				local var_296_6 = utf8.len(var_296_4)
				local var_296_7 = var_296_5 <= 0 and var_296_1 or var_296_1 * (var_296_6 / var_296_5)

				if var_296_7 > 0 and var_296_1 < var_296_7 then
					arg_293_1.talkMaxDuration = var_296_7

					if var_296_7 + var_296_0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_7 + var_296_0
					end
				end

				arg_293_1.text_.text = var_296_4
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111041", "111041070", "story_v_out_111041.awb") ~= 0 then
					local var_296_8 = manager.audio:GetVoiceLength("story_v_out_111041", "111041070", "story_v_out_111041.awb") / 1000

					if var_296_8 + var_296_0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_8 + var_296_0
					end

					if var_296_3.prefab_name ~= "" and arg_293_1.actors_[var_296_3.prefab_name] ~= nil then
						local var_296_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_3.prefab_name].transform, "story_v_out_111041", "111041070", "story_v_out_111041.awb")

						arg_293_1:RecordAudio("111041070", var_296_9)
						arg_293_1:RecordAudio("111041070", var_296_9)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_111041", "111041070", "story_v_out_111041.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_111041", "111041070", "story_v_out_111041.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_10 = math.max(var_296_1, arg_293_1.talkMaxDuration)

			if var_296_0 <= arg_293_1.time_ and arg_293_1.time_ < var_296_0 + var_296_10 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_0) / var_296_10

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_0 + var_296_10 and arg_293_1.time_ < var_296_0 + var_296_10 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play111041071 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 111041071
		arg_297_1.duration_ = 4.07

		local var_297_0 = {
			ja = 3.666,
			ko = 4.066,
			zh = 3.4,
			en = 4.033
		}
		local var_297_1 = manager.audio:GetLocalizationFlag()

		if var_297_0[var_297_1] ~= nil then
			arg_297_1.duration_ = var_297_0[var_297_1]
		end

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play111041072(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = 0
			local var_300_1 = 0.375

			if var_300_0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_0 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				local var_300_2 = arg_297_1:FormatText(StoryNameCfg[176].name)

				arg_297_1.leftNameTxt_.text = var_300_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, true)
				arg_297_1.iconController_:SetSelectedState("hero")

				arg_297_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_helena")

				arg_297_1.callingController_:SetSelectedState("normal")

				arg_297_1.keyicon_.color = Color.New(1, 1, 1)
				arg_297_1.icon_.color = Color.New(1, 1, 1)

				local var_300_3 = arg_297_1:GetWordFromCfg(111041071)
				local var_300_4 = arg_297_1:FormatText(var_300_3.content)

				arg_297_1.text_.text = var_300_4

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_5 = 15
				local var_300_6 = utf8.len(var_300_4)
				local var_300_7 = var_300_5 <= 0 and var_300_1 or var_300_1 * (var_300_6 / var_300_5)

				if var_300_7 > 0 and var_300_1 < var_300_7 then
					arg_297_1.talkMaxDuration = var_300_7

					if var_300_7 + var_300_0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_7 + var_300_0
					end
				end

				arg_297_1.text_.text = var_300_4
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111041", "111041071", "story_v_out_111041.awb") ~= 0 then
					local var_300_8 = manager.audio:GetVoiceLength("story_v_out_111041", "111041071", "story_v_out_111041.awb") / 1000

					if var_300_8 + var_300_0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_8 + var_300_0
					end

					if var_300_3.prefab_name ~= "" and arg_297_1.actors_[var_300_3.prefab_name] ~= nil then
						local var_300_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_3.prefab_name].transform, "story_v_out_111041", "111041071", "story_v_out_111041.awb")

						arg_297_1:RecordAudio("111041071", var_300_9)
						arg_297_1:RecordAudio("111041071", var_300_9)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_111041", "111041071", "story_v_out_111041.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_111041", "111041071", "story_v_out_111041.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_10 = math.max(var_300_1, arg_297_1.talkMaxDuration)

			if var_300_0 <= arg_297_1.time_ and arg_297_1.time_ < var_300_0 + var_300_10 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_0) / var_300_10

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_0 + var_300_10 and arg_297_1.time_ < var_300_0 + var_300_10 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play111041072 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 111041072
		arg_301_1.duration_ = 9.5

		local var_301_0 = {
			ja = 8.066,
			ko = 6.366,
			zh = 9.5,
			en = 8.566
		}
		local var_301_1 = manager.audio:GetLocalizationFlag()

		if var_301_0[var_301_1] ~= nil then
			arg_301_1.duration_ = var_301_0[var_301_1]
		end

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play111041073(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = 0
			local var_304_1 = 0.85

			if var_304_0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_0 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				local var_304_2 = arg_301_1:FormatText(StoryNameCfg[182].name)

				arg_301_1.leftNameTxt_.text = var_304_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, true)
				arg_301_1.iconController_:SetSelectedState("hero")

				arg_301_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vena")

				arg_301_1.callingController_:SetSelectedState("normal")

				arg_301_1.keyicon_.color = Color.New(1, 1, 1)
				arg_301_1.icon_.color = Color.New(1, 1, 1)

				local var_304_3 = arg_301_1:GetWordFromCfg(111041072)
				local var_304_4 = arg_301_1:FormatText(var_304_3.content)

				arg_301_1.text_.text = var_304_4

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_5 = 34
				local var_304_6 = utf8.len(var_304_4)
				local var_304_7 = var_304_5 <= 0 and var_304_1 or var_304_1 * (var_304_6 / var_304_5)

				if var_304_7 > 0 and var_304_1 < var_304_7 then
					arg_301_1.talkMaxDuration = var_304_7

					if var_304_7 + var_304_0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_7 + var_304_0
					end
				end

				arg_301_1.text_.text = var_304_4
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111041", "111041072", "story_v_out_111041.awb") ~= 0 then
					local var_304_8 = manager.audio:GetVoiceLength("story_v_out_111041", "111041072", "story_v_out_111041.awb") / 1000

					if var_304_8 + var_304_0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_8 + var_304_0
					end

					if var_304_3.prefab_name ~= "" and arg_301_1.actors_[var_304_3.prefab_name] ~= nil then
						local var_304_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_3.prefab_name].transform, "story_v_out_111041", "111041072", "story_v_out_111041.awb")

						arg_301_1:RecordAudio("111041072", var_304_9)
						arg_301_1:RecordAudio("111041072", var_304_9)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_111041", "111041072", "story_v_out_111041.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_111041", "111041072", "story_v_out_111041.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_10 = math.max(var_304_1, arg_301_1.talkMaxDuration)

			if var_304_0 <= arg_301_1.time_ and arg_301_1.time_ < var_304_0 + var_304_10 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_0) / var_304_10

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_0 + var_304_10 and arg_301_1.time_ < var_304_0 + var_304_10 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play111041073 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 111041073
		arg_305_1.duration_ = 9.17

		local var_305_0 = {
			ja = 9.166,
			ko = 4.666,
			zh = 3.733,
			en = 1.966
		}
		local var_305_1 = manager.audio:GetLocalizationFlag()

		if var_305_0[var_305_1] ~= nil then
			arg_305_1.duration_ = var_305_0[var_305_1]
		end

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play111041074(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 0
			local var_308_1 = 0.3

			if var_308_0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_0 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				local var_308_2 = arg_305_1:FormatText(StoryNameCfg[176].name)

				arg_305_1.leftNameTxt_.text = var_308_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, true)
				arg_305_1.iconController_:SetSelectedState("hero")

				arg_305_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_helena")

				arg_305_1.callingController_:SetSelectedState("normal")

				arg_305_1.keyicon_.color = Color.New(1, 1, 1)
				arg_305_1.icon_.color = Color.New(1, 1, 1)

				local var_308_3 = arg_305_1:GetWordFromCfg(111041073)
				local var_308_4 = arg_305_1:FormatText(var_308_3.content)

				arg_305_1.text_.text = var_308_4

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_5 = 13
				local var_308_6 = utf8.len(var_308_4)
				local var_308_7 = var_308_5 <= 0 and var_308_1 or var_308_1 * (var_308_6 / var_308_5)

				if var_308_7 > 0 and var_308_1 < var_308_7 then
					arg_305_1.talkMaxDuration = var_308_7

					if var_308_7 + var_308_0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_7 + var_308_0
					end
				end

				arg_305_1.text_.text = var_308_4
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111041", "111041073", "story_v_out_111041.awb") ~= 0 then
					local var_308_8 = manager.audio:GetVoiceLength("story_v_out_111041", "111041073", "story_v_out_111041.awb") / 1000

					if var_308_8 + var_308_0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_8 + var_308_0
					end

					if var_308_3.prefab_name ~= "" and arg_305_1.actors_[var_308_3.prefab_name] ~= nil then
						local var_308_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_3.prefab_name].transform, "story_v_out_111041", "111041073", "story_v_out_111041.awb")

						arg_305_1:RecordAudio("111041073", var_308_9)
						arg_305_1:RecordAudio("111041073", var_308_9)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_111041", "111041073", "story_v_out_111041.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_111041", "111041073", "story_v_out_111041.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_10 = math.max(var_308_1, arg_305_1.talkMaxDuration)

			if var_308_0 <= arg_305_1.time_ and arg_305_1.time_ < var_308_0 + var_308_10 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_0) / var_308_10

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_0 + var_308_10 and arg_305_1.time_ < var_308_0 + var_308_10 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play111041074 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 111041074
		arg_309_1.duration_ = 12.2

		local var_309_0 = {
			ja = 7.733,
			ko = 7.133,
			zh = 12.2,
			en = 8.966
		}
		local var_309_1 = manager.audio:GetLocalizationFlag()

		if var_309_0[var_309_1] ~= nil then
			arg_309_1.duration_ = var_309_0[var_309_1]
		end

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play111041075(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 0
			local var_312_1 = 0.75

			if var_312_0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_0 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				local var_312_2 = arg_309_1:FormatText(StoryNameCfg[182].name)

				arg_309_1.leftNameTxt_.text = var_312_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, true)
				arg_309_1.iconController_:SetSelectedState("hero")

				arg_309_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vena")

				arg_309_1.callingController_:SetSelectedState("normal")

				arg_309_1.keyicon_.color = Color.New(1, 1, 1)
				arg_309_1.icon_.color = Color.New(1, 1, 1)

				local var_312_3 = arg_309_1:GetWordFromCfg(111041074)
				local var_312_4 = arg_309_1:FormatText(var_312_3.content)

				arg_309_1.text_.text = var_312_4

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_5 = 30
				local var_312_6 = utf8.len(var_312_4)
				local var_312_7 = var_312_5 <= 0 and var_312_1 or var_312_1 * (var_312_6 / var_312_5)

				if var_312_7 > 0 and var_312_1 < var_312_7 then
					arg_309_1.talkMaxDuration = var_312_7

					if var_312_7 + var_312_0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_7 + var_312_0
					end
				end

				arg_309_1.text_.text = var_312_4
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111041", "111041074", "story_v_out_111041.awb") ~= 0 then
					local var_312_8 = manager.audio:GetVoiceLength("story_v_out_111041", "111041074", "story_v_out_111041.awb") / 1000

					if var_312_8 + var_312_0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_8 + var_312_0
					end

					if var_312_3.prefab_name ~= "" and arg_309_1.actors_[var_312_3.prefab_name] ~= nil then
						local var_312_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_3.prefab_name].transform, "story_v_out_111041", "111041074", "story_v_out_111041.awb")

						arg_309_1:RecordAudio("111041074", var_312_9)
						arg_309_1:RecordAudio("111041074", var_312_9)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_111041", "111041074", "story_v_out_111041.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_111041", "111041074", "story_v_out_111041.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_10 = math.max(var_312_1, arg_309_1.talkMaxDuration)

			if var_312_0 <= arg_309_1.time_ and arg_309_1.time_ < var_312_0 + var_312_10 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_0) / var_312_10

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_0 + var_312_10 and arg_309_1.time_ < var_312_0 + var_312_10 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play111041075 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 111041075
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play111041076(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = 0
			local var_316_1 = 0.925

			if var_316_0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_0 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, false)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_2 = arg_313_1:GetWordFromCfg(111041075)
				local var_316_3 = arg_313_1:FormatText(var_316_2.content)

				arg_313_1.text_.text = var_316_3

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_4 = 37
				local var_316_5 = utf8.len(var_316_3)
				local var_316_6 = var_316_4 <= 0 and var_316_1 or var_316_1 * (var_316_5 / var_316_4)

				if var_316_6 > 0 and var_316_1 < var_316_6 then
					arg_313_1.talkMaxDuration = var_316_6

					if var_316_6 + var_316_0 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_6 + var_316_0
					end
				end

				arg_313_1.text_.text = var_316_3
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_7 = math.max(var_316_1, arg_313_1.talkMaxDuration)

			if var_316_0 <= arg_313_1.time_ and arg_313_1.time_ < var_316_0 + var_316_7 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_0) / var_316_7

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_0 + var_316_7 and arg_313_1.time_ < var_316_0 + var_316_7 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play111041076 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 111041076
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play111041077(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = 0
			local var_320_1 = 0.65

			if var_320_0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_0 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, false)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_2 = arg_317_1:GetWordFromCfg(111041076)
				local var_320_3 = arg_317_1:FormatText(var_320_2.content)

				arg_317_1.text_.text = var_320_3

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_4 = 26
				local var_320_5 = utf8.len(var_320_3)
				local var_320_6 = var_320_4 <= 0 and var_320_1 or var_320_1 * (var_320_5 / var_320_4)

				if var_320_6 > 0 and var_320_1 < var_320_6 then
					arg_317_1.talkMaxDuration = var_320_6

					if var_320_6 + var_320_0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_6 + var_320_0
					end
				end

				arg_317_1.text_.text = var_320_3
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_7 = math.max(var_320_1, arg_317_1.talkMaxDuration)

			if var_320_0 <= arg_317_1.time_ and arg_317_1.time_ < var_320_0 + var_320_7 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_0) / var_320_7

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_0 + var_320_7 and arg_317_1.time_ < var_320_0 + var_320_7 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play111041077 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 111041077
		arg_321_1.duration_ = 5

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play111041078(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = 0
			local var_324_1 = 0.9

			if var_324_0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_0 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, false)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_2 = arg_321_1:GetWordFromCfg(111041077)
				local var_324_3 = arg_321_1:FormatText(var_324_2.content)

				arg_321_1.text_.text = var_324_3

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_4 = 36
				local var_324_5 = utf8.len(var_324_3)
				local var_324_6 = var_324_4 <= 0 and var_324_1 or var_324_1 * (var_324_5 / var_324_4)

				if var_324_6 > 0 and var_324_1 < var_324_6 then
					arg_321_1.talkMaxDuration = var_324_6

					if var_324_6 + var_324_0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_6 + var_324_0
					end
				end

				arg_321_1.text_.text = var_324_3
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)
				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_7 = math.max(var_324_1, arg_321_1.talkMaxDuration)

			if var_324_0 <= arg_321_1.time_ and arg_321_1.time_ < var_324_0 + var_324_7 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_0) / var_324_7

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_0 + var_324_7 and arg_321_1.time_ < var_324_0 + var_324_7 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play111041078 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 111041078
		arg_325_1.duration_ = 13.43

		local var_325_0 = {
			ja = 13.433,
			ko = 5.766,
			zh = 6.9,
			en = 8.966
		}
		local var_325_1 = manager.audio:GetLocalizationFlag()

		if var_325_0[var_325_1] ~= nil then
			arg_325_1.duration_ = var_325_0[var_325_1]
		end

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play111041079(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = 0
			local var_328_1 = 0.5

			if var_328_0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_0 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				local var_328_2 = arg_325_1:FormatText(StoryNameCfg[178].name)

				arg_325_1.leftNameTxt_.text = var_328_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, true)
				arg_325_1.iconController_:SetSelectedState("hero")

				arg_325_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_heidie")

				arg_325_1.callingController_:SetSelectedState("normal")

				arg_325_1.keyicon_.color = Color.New(1, 1, 1)
				arg_325_1.icon_.color = Color.New(1, 1, 1)

				local var_328_3 = arg_325_1:GetWordFromCfg(111041078)
				local var_328_4 = arg_325_1:FormatText(var_328_3.content)

				arg_325_1.text_.text = var_328_4

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_5 = 20
				local var_328_6 = utf8.len(var_328_4)
				local var_328_7 = var_328_5 <= 0 and var_328_1 or var_328_1 * (var_328_6 / var_328_5)

				if var_328_7 > 0 and var_328_1 < var_328_7 then
					arg_325_1.talkMaxDuration = var_328_7

					if var_328_7 + var_328_0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_7 + var_328_0
					end
				end

				arg_325_1.text_.text = var_328_4
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111041", "111041078", "story_v_out_111041.awb") ~= 0 then
					local var_328_8 = manager.audio:GetVoiceLength("story_v_out_111041", "111041078", "story_v_out_111041.awb") / 1000

					if var_328_8 + var_328_0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_8 + var_328_0
					end

					if var_328_3.prefab_name ~= "" and arg_325_1.actors_[var_328_3.prefab_name] ~= nil then
						local var_328_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_3.prefab_name].transform, "story_v_out_111041", "111041078", "story_v_out_111041.awb")

						arg_325_1:RecordAudio("111041078", var_328_9)
						arg_325_1:RecordAudio("111041078", var_328_9)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_111041", "111041078", "story_v_out_111041.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_111041", "111041078", "story_v_out_111041.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_10 = math.max(var_328_1, arg_325_1.talkMaxDuration)

			if var_328_0 <= arg_325_1.time_ and arg_325_1.time_ < var_328_0 + var_328_10 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_0) / var_328_10

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_0 + var_328_10 and arg_325_1.time_ < var_328_0 + var_328_10 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play111041079 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 111041079
		arg_329_1.duration_ = 3.6

		local var_329_0 = {
			ja = 3.6,
			ko = 3.566,
			zh = 2.4,
			en = 2.866
		}
		local var_329_1 = manager.audio:GetLocalizationFlag()

		if var_329_0[var_329_1] ~= nil then
			arg_329_1.duration_ = var_329_0[var_329_1]
		end

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play111041080(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = 0
			local var_332_1 = 0.25

			if var_332_0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_0 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				local var_332_2 = arg_329_1:FormatText(StoryNameCfg[178].name)

				arg_329_1.leftNameTxt_.text = var_332_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, true)
				arg_329_1.iconController_:SetSelectedState("hero")

				arg_329_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_heidie")

				arg_329_1.callingController_:SetSelectedState("normal")

				arg_329_1.keyicon_.color = Color.New(1, 1, 1)
				arg_329_1.icon_.color = Color.New(1, 1, 1)

				local var_332_3 = arg_329_1:GetWordFromCfg(111041079)
				local var_332_4 = arg_329_1:FormatText(var_332_3.content)

				arg_329_1.text_.text = var_332_4

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_5 = 10
				local var_332_6 = utf8.len(var_332_4)
				local var_332_7 = var_332_5 <= 0 and var_332_1 or var_332_1 * (var_332_6 / var_332_5)

				if var_332_7 > 0 and var_332_1 < var_332_7 then
					arg_329_1.talkMaxDuration = var_332_7

					if var_332_7 + var_332_0 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_7 + var_332_0
					end
				end

				arg_329_1.text_.text = var_332_4
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111041", "111041079", "story_v_out_111041.awb") ~= 0 then
					local var_332_8 = manager.audio:GetVoiceLength("story_v_out_111041", "111041079", "story_v_out_111041.awb") / 1000

					if var_332_8 + var_332_0 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_8 + var_332_0
					end

					if var_332_3.prefab_name ~= "" and arg_329_1.actors_[var_332_3.prefab_name] ~= nil then
						local var_332_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_3.prefab_name].transform, "story_v_out_111041", "111041079", "story_v_out_111041.awb")

						arg_329_1:RecordAudio("111041079", var_332_9)
						arg_329_1:RecordAudio("111041079", var_332_9)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_out_111041", "111041079", "story_v_out_111041.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_out_111041", "111041079", "story_v_out_111041.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_10 = math.max(var_332_1, arg_329_1.talkMaxDuration)

			if var_332_0 <= arg_329_1.time_ and arg_329_1.time_ < var_332_0 + var_332_10 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_0) / var_332_10

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_0 + var_332_10 and arg_329_1.time_ < var_332_0 + var_332_10 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play111041080 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 111041080
		arg_333_1.duration_ = 5

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play111041081(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = 0
			local var_336_1 = 0.45

			if var_336_0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_0 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, false)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_2 = arg_333_1:GetWordFromCfg(111041080)
				local var_336_3 = arg_333_1:FormatText(var_336_2.content)

				arg_333_1.text_.text = var_336_3

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_4 = 18
				local var_336_5 = utf8.len(var_336_3)
				local var_336_6 = var_336_4 <= 0 and var_336_1 or var_336_1 * (var_336_5 / var_336_4)

				if var_336_6 > 0 and var_336_1 < var_336_6 then
					arg_333_1.talkMaxDuration = var_336_6

					if var_336_6 + var_336_0 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_6 + var_336_0
					end
				end

				arg_333_1.text_.text = var_336_3
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)
				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_7 = math.max(var_336_1, arg_333_1.talkMaxDuration)

			if var_336_0 <= arg_333_1.time_ and arg_333_1.time_ < var_336_0 + var_336_7 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_0) / var_336_7

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_0 + var_336_7 and arg_333_1.time_ < var_336_0 + var_336_7 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play111041081 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 111041081
		arg_337_1.duration_ = 8.2

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play111041082(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = "ST01a"

			if arg_337_1.bgs_[var_340_0] == nil then
				local var_340_1 = Object.Instantiate(arg_337_1.paintGo_)

				var_340_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_340_0)
				var_340_1.name = var_340_0
				var_340_1.transform.parent = arg_337_1.stage_.transform
				var_340_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_337_1.bgs_[var_340_0] = var_340_1
			end

			local var_340_2 = 1

			if var_340_2 < arg_337_1.time_ and arg_337_1.time_ <= var_340_2 + arg_340_0 then
				local var_340_3 = manager.ui.mainCamera.transform.localPosition
				local var_340_4 = Vector3.New(0, 0, 10) + Vector3.New(var_340_3.x, var_340_3.y, 0)
				local var_340_5 = arg_337_1.bgs_.ST01a

				var_340_5.transform.localPosition = var_340_4
				var_340_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_340_6 = var_340_5:GetComponent("SpriteRenderer")

				if var_340_6 and var_340_6.sprite then
					local var_340_7 = (var_340_5.transform.localPosition - var_340_3).z
					local var_340_8 = manager.ui.mainCameraCom_
					local var_340_9 = 2 * var_340_7 * Mathf.Tan(var_340_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_340_10 = var_340_9 * var_340_8.aspect
					local var_340_11 = var_340_6.sprite.bounds.size.x
					local var_340_12 = var_340_6.sprite.bounds.size.y
					local var_340_13 = var_340_10 / var_340_11
					local var_340_14 = var_340_9 / var_340_12
					local var_340_15 = var_340_14 < var_340_13 and var_340_13 or var_340_14

					var_340_5.transform.localScale = Vector3.New(var_340_15, var_340_15, 0)
				end

				for iter_340_0, iter_340_1 in pairs(arg_337_1.bgs_) do
					if iter_340_0 ~= "ST01a" then
						iter_340_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_340_16 = 0

			if var_340_16 < arg_337_1.time_ and arg_337_1.time_ <= var_340_16 + arg_340_0 then
				arg_337_1.mask_.enabled = true
				arg_337_1.mask_.raycastTarget = true

				arg_337_1:SetGaussion(false)
			end

			local var_340_17 = 1

			if var_340_16 <= arg_337_1.time_ and arg_337_1.time_ < var_340_16 + var_340_17 then
				local var_340_18 = (arg_337_1.time_ - var_340_16) / var_340_17
				local var_340_19 = Color.New(1, 1, 1)

				var_340_19.a = Mathf.Lerp(0, 1, var_340_18)
				arg_337_1.mask_.color = var_340_19
			end

			if arg_337_1.time_ >= var_340_16 + var_340_17 and arg_337_1.time_ < var_340_16 + var_340_17 + arg_340_0 then
				local var_340_20 = Color.New(1, 1, 1)

				var_340_20.a = 1
				arg_337_1.mask_.color = var_340_20
			end

			local var_340_21 = 1

			if var_340_21 < arg_337_1.time_ and arg_337_1.time_ <= var_340_21 + arg_340_0 then
				arg_337_1.mask_.enabled = true
				arg_337_1.mask_.raycastTarget = true

				arg_337_1:SetGaussion(false)
			end

			local var_340_22 = 1.75

			if var_340_21 <= arg_337_1.time_ and arg_337_1.time_ < var_340_21 + var_340_22 then
				local var_340_23 = (arg_337_1.time_ - var_340_21) / var_340_22
				local var_340_24 = Color.New(1, 1, 1)

				var_340_24.a = Mathf.Lerp(1, 0, var_340_23)
				arg_337_1.mask_.color = var_340_24
			end

			if arg_337_1.time_ >= var_340_21 + var_340_22 and arg_337_1.time_ < var_340_21 + var_340_22 + arg_340_0 then
				local var_340_25 = Color.New(1, 1, 1)
				local var_340_26 = 0

				arg_337_1.mask_.enabled = false
				var_340_25.a = var_340_26
				arg_337_1.mask_.color = var_340_25
			end

			local var_340_27 = 0

			if var_340_27 < arg_337_1.time_ and arg_337_1.time_ <= var_340_27 + arg_340_0 then
				arg_337_1.allBtn_.enabled = false
			end

			local var_340_28 = 3.2

			if arg_337_1.time_ >= var_340_27 + var_340_28 and arg_337_1.time_ < var_340_27 + var_340_28 + arg_340_0 then
				arg_337_1.allBtn_.enabled = true
			end

			if arg_337_1.frameCnt_ <= 1 then
				arg_337_1.dialog_:SetActive(false)
			end

			local var_340_29 = 3.2
			local var_340_30 = 0.75

			if var_340_29 < arg_337_1.time_ and arg_337_1.time_ <= var_340_29 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0

				arg_337_1.dialog_:SetActive(true)

				arg_337_1.dialogCg_.alpha = 0

				local var_340_31 = LeanTween.value(arg_337_1.dialog_, 0, 1, 0.3)

				var_340_31:setOnUpdate(LuaHelper.FloatAction(function(arg_341_0)
					arg_337_1.dialogCg_.alpha = arg_341_0
				end))
				var_340_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_337_1.dialog_)
					var_340_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_337_1.duration_ = arg_337_1.duration_ + 0.3

				SetActive(arg_337_1.leftNameGo_, false)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_32 = arg_337_1:GetWordFromCfg(111041081)
				local var_340_33 = arg_337_1:FormatText(var_340_32.content)

				arg_337_1.text_.text = var_340_33

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_34 = 30
				local var_340_35 = utf8.len(var_340_33)
				local var_340_36 = var_340_34 <= 0 and var_340_30 or var_340_30 * (var_340_35 / var_340_34)

				if var_340_36 > 0 and var_340_30 < var_340_36 then
					arg_337_1.talkMaxDuration = var_340_36
					var_340_29 = var_340_29 + 0.3

					if var_340_36 + var_340_29 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_36 + var_340_29
					end
				end

				arg_337_1.text_.text = var_340_33
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)
				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_37 = var_340_29 + 0.3
			local var_340_38 = math.max(var_340_30, arg_337_1.talkMaxDuration)

			if var_340_37 <= arg_337_1.time_ and arg_337_1.time_ < var_340_37 + var_340_38 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_37) / var_340_38

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_37 + var_340_38 and arg_337_1.time_ < var_340_37 + var_340_38 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play111041082 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 111041082
		arg_343_1.duration_ = 5

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play111041083(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = 0
			local var_346_1 = 0.725

			if var_346_0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_0 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, false)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_2 = arg_343_1:GetWordFromCfg(111041082)
				local var_346_3 = arg_343_1:FormatText(var_346_2.content)

				arg_343_1.text_.text = var_346_3

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_4 = 29
				local var_346_5 = utf8.len(var_346_3)
				local var_346_6 = var_346_4 <= 0 and var_346_1 or var_346_1 * (var_346_5 / var_346_4)

				if var_346_6 > 0 and var_346_1 < var_346_6 then
					arg_343_1.talkMaxDuration = var_346_6

					if var_346_6 + var_346_0 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_6 + var_346_0
					end
				end

				arg_343_1.text_.text = var_346_3
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)
				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_7 = math.max(var_346_1, arg_343_1.talkMaxDuration)

			if var_346_0 <= arg_343_1.time_ and arg_343_1.time_ < var_346_0 + var_346_7 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_0) / var_346_7

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_0 + var_346_7 and arg_343_1.time_ < var_346_0 + var_346_7 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play111041083 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 111041083
		arg_347_1.duration_ = 8.43

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play111041084(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = "B13a"

			if arg_347_1.bgs_[var_350_0] == nil then
				local var_350_1 = Object.Instantiate(arg_347_1.paintGo_)

				var_350_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_350_0)
				var_350_1.name = var_350_0
				var_350_1.transform.parent = arg_347_1.stage_.transform
				var_350_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_347_1.bgs_[var_350_0] = var_350_1
			end

			local var_350_2 = 1.5

			if var_350_2 < arg_347_1.time_ and arg_347_1.time_ <= var_350_2 + arg_350_0 then
				local var_350_3 = manager.ui.mainCamera.transform.localPosition
				local var_350_4 = Vector3.New(0, 0, 10) + Vector3.New(var_350_3.x, var_350_3.y, 0)
				local var_350_5 = arg_347_1.bgs_.B13a

				var_350_5.transform.localPosition = var_350_4
				var_350_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_350_6 = var_350_5:GetComponent("SpriteRenderer")

				if var_350_6 and var_350_6.sprite then
					local var_350_7 = (var_350_5.transform.localPosition - var_350_3).z
					local var_350_8 = manager.ui.mainCameraCom_
					local var_350_9 = 2 * var_350_7 * Mathf.Tan(var_350_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_350_10 = var_350_9 * var_350_8.aspect
					local var_350_11 = var_350_6.sprite.bounds.size.x
					local var_350_12 = var_350_6.sprite.bounds.size.y
					local var_350_13 = var_350_10 / var_350_11
					local var_350_14 = var_350_9 / var_350_12
					local var_350_15 = var_350_14 < var_350_13 and var_350_13 or var_350_14

					var_350_5.transform.localScale = Vector3.New(var_350_15, var_350_15, 0)
				end

				for iter_350_0, iter_350_1 in pairs(arg_347_1.bgs_) do
					if iter_350_0 ~= "B13a" then
						iter_350_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_350_16 = arg_347_1.bgs_.ST01a
			local var_350_17 = 0

			if var_350_17 < arg_347_1.time_ and arg_347_1.time_ <= var_350_17 + arg_350_0 then
				local var_350_18 = var_350_16:GetComponent("SpriteRenderer")

				if var_350_18 then
					arg_347_1.var_.alphaOldValueST01a = var_350_18.color.a
					arg_347_1.var_.alphaMatValueST01a = var_350_18
				end

				arg_347_1.var_.alphaOldValueST01a = 1
			end

			local var_350_19 = 1.5

			if var_350_17 <= arg_347_1.time_ and arg_347_1.time_ < var_350_17 + var_350_19 then
				local var_350_20 = (arg_347_1.time_ - var_350_17) / var_350_19
				local var_350_21 = Mathf.Lerp(arg_347_1.var_.alphaOldValueST01a, 0, var_350_20)

				if arg_347_1.var_.alphaMatValueST01a then
					local var_350_22 = arg_347_1.var_.alphaMatValueST01a.color

					var_350_22.a = var_350_21
					arg_347_1.var_.alphaMatValueST01a.color = var_350_22
				end
			end

			if arg_347_1.time_ >= var_350_17 + var_350_19 and arg_347_1.time_ < var_350_17 + var_350_19 + arg_350_0 and arg_347_1.var_.alphaMatValueST01a then
				local var_350_23 = arg_347_1.var_.alphaMatValueST01a
				local var_350_24 = var_350_23.color

				var_350_24.a = 0
				var_350_23.color = var_350_24
			end

			local var_350_25 = arg_347_1.bgs_.B13a
			local var_350_26 = 1.5

			if var_350_26 < arg_347_1.time_ and arg_347_1.time_ <= var_350_26 + arg_350_0 then
				local var_350_27 = var_350_25:GetComponent("SpriteRenderer")

				if var_350_27 then
					arg_347_1.var_.alphaOldValueB13a = var_350_27.color.a
					arg_347_1.var_.alphaMatValueB13a = var_350_27
				end

				arg_347_1.var_.alphaOldValueB13a = 0
			end

			local var_350_28 = 1.5

			if var_350_26 <= arg_347_1.time_ and arg_347_1.time_ < var_350_26 + var_350_28 then
				local var_350_29 = (arg_347_1.time_ - var_350_26) / var_350_28
				local var_350_30 = Mathf.Lerp(arg_347_1.var_.alphaOldValueB13a, 1, var_350_29)

				if arg_347_1.var_.alphaMatValueB13a then
					local var_350_31 = arg_347_1.var_.alphaMatValueB13a.color

					var_350_31.a = var_350_30
					arg_347_1.var_.alphaMatValueB13a.color = var_350_31
				end
			end

			if arg_347_1.time_ >= var_350_26 + var_350_28 and arg_347_1.time_ < var_350_26 + var_350_28 + arg_350_0 and arg_347_1.var_.alphaMatValueB13a then
				local var_350_32 = arg_347_1.var_.alphaMatValueB13a
				local var_350_33 = var_350_32.color

				var_350_33.a = 1
				var_350_32.color = var_350_33
			end

			local var_350_34 = 0

			if var_350_34 < arg_347_1.time_ and arg_347_1.time_ <= var_350_34 + arg_350_0 then
				arg_347_1.allBtn_.enabled = false
			end

			local var_350_35 = 3.43333333333333

			if arg_347_1.time_ >= var_350_34 + var_350_35 and arg_347_1.time_ < var_350_34 + var_350_35 + arg_350_0 then
				arg_347_1.allBtn_.enabled = true
			end

			if arg_347_1.frameCnt_ <= 1 then
				arg_347_1.dialog_:SetActive(false)
			end

			local var_350_36 = 3.43333333333333
			local var_350_37 = 1.175

			if var_350_36 < arg_347_1.time_ and arg_347_1.time_ <= var_350_36 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0

				arg_347_1.dialog_:SetActive(true)

				arg_347_1.dialogCg_.alpha = 0

				local var_350_38 = LeanTween.value(arg_347_1.dialog_, 0, 1, 0.3)

				var_350_38:setOnUpdate(LuaHelper.FloatAction(function(arg_351_0)
					arg_347_1.dialogCg_.alpha = arg_351_0
				end))
				var_350_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_347_1.dialog_)
					var_350_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_347_1.duration_ = arg_347_1.duration_ + 0.3

				SetActive(arg_347_1.leftNameGo_, false)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_39 = arg_347_1:GetWordFromCfg(111041083)
				local var_350_40 = arg_347_1:FormatText(var_350_39.content)

				arg_347_1.text_.text = var_350_40

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_41 = 47
				local var_350_42 = utf8.len(var_350_40)
				local var_350_43 = var_350_41 <= 0 and var_350_37 or var_350_37 * (var_350_42 / var_350_41)

				if var_350_43 > 0 and var_350_37 < var_350_43 then
					arg_347_1.talkMaxDuration = var_350_43
					var_350_36 = var_350_36 + 0.3

					if var_350_43 + var_350_36 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_43 + var_350_36
					end
				end

				arg_347_1.text_.text = var_350_40
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)
				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_44 = var_350_36 + 0.3
			local var_350_45 = math.max(var_350_37, arg_347_1.talkMaxDuration)

			if var_350_44 <= arg_347_1.time_ and arg_347_1.time_ < var_350_44 + var_350_45 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_44) / var_350_45

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_44 + var_350_45 and arg_347_1.time_ < var_350_44 + var_350_45 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play111041084 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 111041084
		arg_353_1.duration_ = 5

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play111041085(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = 0
			local var_356_1 = 1

			if var_356_0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_0 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, false)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_2 = arg_353_1:GetWordFromCfg(111041084)
				local var_356_3 = arg_353_1:FormatText(var_356_2.content)

				arg_353_1.text_.text = var_356_3

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_4 = 40
				local var_356_5 = utf8.len(var_356_3)
				local var_356_6 = var_356_4 <= 0 and var_356_1 or var_356_1 * (var_356_5 / var_356_4)

				if var_356_6 > 0 and var_356_1 < var_356_6 then
					arg_353_1.talkMaxDuration = var_356_6

					if var_356_6 + var_356_0 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_6 + var_356_0
					end
				end

				arg_353_1.text_.text = var_356_3
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)
				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_7 = math.max(var_356_1, arg_353_1.talkMaxDuration)

			if var_356_0 <= arg_353_1.time_ and arg_353_1.time_ < var_356_0 + var_356_7 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_0) / var_356_7

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_0 + var_356_7 and arg_353_1.time_ < var_356_0 + var_356_7 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play111041085 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 111041085
		arg_357_1.duration_ = 5

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play111041086(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			local var_360_0 = 0
			local var_360_1 = 1.15

			if var_360_0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_0 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, false)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_2 = arg_357_1:GetWordFromCfg(111041085)
				local var_360_3 = arg_357_1:FormatText(var_360_2.content)

				arg_357_1.text_.text = var_360_3

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_4 = 46
				local var_360_5 = utf8.len(var_360_3)
				local var_360_6 = var_360_4 <= 0 and var_360_1 or var_360_1 * (var_360_5 / var_360_4)

				if var_360_6 > 0 and var_360_1 < var_360_6 then
					arg_357_1.talkMaxDuration = var_360_6

					if var_360_6 + var_360_0 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_6 + var_360_0
					end
				end

				arg_357_1.text_.text = var_360_3
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)
				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_7 = math.max(var_360_1, arg_357_1.talkMaxDuration)

			if var_360_0 <= arg_357_1.time_ and arg_357_1.time_ < var_360_0 + var_360_7 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_0) / var_360_7

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_0 + var_360_7 and arg_357_1.time_ < var_360_0 + var_360_7 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play111041086 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 111041086
		arg_361_1.duration_ = 5

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play111041087(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = 0
			local var_364_1 = 0.1

			if var_364_0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_0 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				local var_364_2 = arg_361_1:FormatText(StoryNameCfg[7].name)

				arg_361_1.leftNameTxt_.text = var_364_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, true)
				arg_361_1.iconController_:SetSelectedState("hero")

				arg_361_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_361_1.callingController_:SetSelectedState("normal")

				arg_361_1.keyicon_.color = Color.New(1, 1, 1)
				arg_361_1.icon_.color = Color.New(1, 1, 1)

				local var_364_3 = arg_361_1:GetWordFromCfg(111041086)
				local var_364_4 = arg_361_1:FormatText(var_364_3.content)

				arg_361_1.text_.text = var_364_4

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_5 = 4
				local var_364_6 = utf8.len(var_364_4)
				local var_364_7 = var_364_5 <= 0 and var_364_1 or var_364_1 * (var_364_6 / var_364_5)

				if var_364_7 > 0 and var_364_1 < var_364_7 then
					arg_361_1.talkMaxDuration = var_364_7

					if var_364_7 + var_364_0 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_7 + var_364_0
					end
				end

				arg_361_1.text_.text = var_364_4
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)
				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_8 = math.max(var_364_1, arg_361_1.talkMaxDuration)

			if var_364_0 <= arg_361_1.time_ and arg_361_1.time_ < var_364_0 + var_364_8 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_0) / var_364_8

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_0 + var_364_8 and arg_361_1.time_ < var_364_0 + var_364_8 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play111041087 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 111041087
		arg_365_1.duration_ = 5

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play111041088(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = 0
			local var_368_1 = 0.525

			if var_368_0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_0 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, false)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_2 = arg_365_1:GetWordFromCfg(111041087)
				local var_368_3 = arg_365_1:FormatText(var_368_2.content)

				arg_365_1.text_.text = var_368_3

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_4 = 21
				local var_368_5 = utf8.len(var_368_3)
				local var_368_6 = var_368_4 <= 0 and var_368_1 or var_368_1 * (var_368_5 / var_368_4)

				if var_368_6 > 0 and var_368_1 < var_368_6 then
					arg_365_1.talkMaxDuration = var_368_6

					if var_368_6 + var_368_0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_6 + var_368_0
					end
				end

				arg_365_1.text_.text = var_368_3
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)
				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_7 = math.max(var_368_1, arg_365_1.talkMaxDuration)

			if var_368_0 <= arg_365_1.time_ and arg_365_1.time_ < var_368_0 + var_368_7 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_0) / var_368_7

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_0 + var_368_7 and arg_365_1.time_ < var_368_0 + var_368_7 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play111041088 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 111041088
		arg_369_1.duration_ = 5

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play111041089(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = arg_369_1.actors_["1094ui_story"].transform
			local var_372_1 = 0

			if var_372_1 < arg_369_1.time_ and arg_369_1.time_ <= var_372_1 + arg_372_0 then
				arg_369_1.var_.moveOldPos1094ui_story = var_372_0.localPosition
			end

			local var_372_2 = 0.001

			if var_372_1 <= arg_369_1.time_ and arg_369_1.time_ < var_372_1 + var_372_2 then
				local var_372_3 = (arg_369_1.time_ - var_372_1) / var_372_2
				local var_372_4 = Vector3.New(0, -0.84, -6.1)

				var_372_0.localPosition = Vector3.Lerp(arg_369_1.var_.moveOldPos1094ui_story, var_372_4, var_372_3)

				local var_372_5 = manager.ui.mainCamera.transform.position - var_372_0.position

				var_372_0.forward = Vector3.New(var_372_5.x, var_372_5.y, var_372_5.z)

				local var_372_6 = var_372_0.localEulerAngles

				var_372_6.z = 0
				var_372_6.x = 0
				var_372_0.localEulerAngles = var_372_6
			end

			if arg_369_1.time_ >= var_372_1 + var_372_2 and arg_369_1.time_ < var_372_1 + var_372_2 + arg_372_0 then
				var_372_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_372_7 = manager.ui.mainCamera.transform.position - var_372_0.position

				var_372_0.forward = Vector3.New(var_372_7.x, var_372_7.y, var_372_7.z)

				local var_372_8 = var_372_0.localEulerAngles

				var_372_8.z = 0
				var_372_8.x = 0
				var_372_0.localEulerAngles = var_372_8
			end

			local var_372_9 = 0

			if var_372_9 < arg_369_1.time_ and arg_369_1.time_ <= var_372_9 + arg_372_0 then
				arg_369_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action1_1")
			end

			local var_372_10 = arg_369_1.actors_["1094ui_story"]
			local var_372_11 = 0

			if var_372_11 < arg_369_1.time_ and arg_369_1.time_ <= var_372_11 + arg_372_0 and not isNil(var_372_10) and arg_369_1.var_.characterEffect1094ui_story == nil then
				arg_369_1.var_.characterEffect1094ui_story = var_372_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_372_12 = 0.2

			if var_372_11 <= arg_369_1.time_ and arg_369_1.time_ < var_372_11 + var_372_12 and not isNil(var_372_10) then
				local var_372_13 = (arg_369_1.time_ - var_372_11) / var_372_12

				if arg_369_1.var_.characterEffect1094ui_story and not isNil(var_372_10) then
					local var_372_14 = Mathf.Lerp(0, 0.5, var_372_13)

					arg_369_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_369_1.var_.characterEffect1094ui_story.fillRatio = var_372_14
				end
			end

			if arg_369_1.time_ >= var_372_11 + var_372_12 and arg_369_1.time_ < var_372_11 + var_372_12 + arg_372_0 and not isNil(var_372_10) and arg_369_1.var_.characterEffect1094ui_story then
				local var_372_15 = 0.5

				arg_369_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_369_1.var_.characterEffect1094ui_story.fillRatio = var_372_15
			end

			local var_372_16 = 0
			local var_372_17 = 0.875

			if var_372_16 < arg_369_1.time_ and arg_369_1.time_ <= var_372_16 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, false)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_18 = arg_369_1:GetWordFromCfg(111041088)
				local var_372_19 = arg_369_1:FormatText(var_372_18.content)

				arg_369_1.text_.text = var_372_19

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_20 = 35
				local var_372_21 = utf8.len(var_372_19)
				local var_372_22 = var_372_20 <= 0 and var_372_17 or var_372_17 * (var_372_21 / var_372_20)

				if var_372_22 > 0 and var_372_17 < var_372_22 then
					arg_369_1.talkMaxDuration = var_372_22

					if var_372_22 + var_372_16 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_22 + var_372_16
					end
				end

				arg_369_1.text_.text = var_372_19
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)
				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_23 = math.max(var_372_17, arg_369_1.talkMaxDuration)

			if var_372_16 <= arg_369_1.time_ and arg_369_1.time_ < var_372_16 + var_372_23 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_16) / var_372_23

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_16 + var_372_23 and arg_369_1.time_ < var_372_16 + var_372_23 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {
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

		arg_369_1:InitPlayNodeList()
	end,
	Play111041089 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 111041089
		arg_373_1.duration_ = 5.83

		local var_373_0 = {
			ja = 3.6,
			ko = 3.7,
			zh = 5.833,
			en = 4.8
		}
		local var_373_1 = manager.audio:GetLocalizationFlag()

		if var_373_0[var_373_1] ~= nil then
			arg_373_1.duration_ = var_373_0[var_373_1]
		end

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play111041090(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			local var_376_0 = arg_373_1.actors_["1094ui_story"].transform
			local var_376_1 = 0

			if var_376_1 < arg_373_1.time_ and arg_373_1.time_ <= var_376_1 + arg_376_0 then
				arg_373_1.var_.moveOldPos1094ui_story = var_376_0.localPosition
			end

			local var_376_2 = 0.001

			if var_376_1 <= arg_373_1.time_ and arg_373_1.time_ < var_376_1 + var_376_2 then
				local var_376_3 = (arg_373_1.time_ - var_376_1) / var_376_2
				local var_376_4 = Vector3.New(0, -0.84, -6.1)

				var_376_0.localPosition = Vector3.Lerp(arg_373_1.var_.moveOldPos1094ui_story, var_376_4, var_376_3)

				local var_376_5 = manager.ui.mainCamera.transform.position - var_376_0.position

				var_376_0.forward = Vector3.New(var_376_5.x, var_376_5.y, var_376_5.z)

				local var_376_6 = var_376_0.localEulerAngles

				var_376_6.z = 0
				var_376_6.x = 0
				var_376_0.localEulerAngles = var_376_6
			end

			if arg_373_1.time_ >= var_376_1 + var_376_2 and arg_373_1.time_ < var_376_1 + var_376_2 + arg_376_0 then
				var_376_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_376_7 = manager.ui.mainCamera.transform.position - var_376_0.position

				var_376_0.forward = Vector3.New(var_376_7.x, var_376_7.y, var_376_7.z)

				local var_376_8 = var_376_0.localEulerAngles

				var_376_8.z = 0
				var_376_8.x = 0
				var_376_0.localEulerAngles = var_376_8
			end

			local var_376_9 = 0

			if var_376_9 < arg_373_1.time_ and arg_373_1.time_ <= var_376_9 + arg_376_0 then
				arg_373_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action3_1")
			end

			local var_376_10 = 0

			if var_376_10 < arg_373_1.time_ and arg_373_1.time_ <= var_376_10 + arg_376_0 then
				arg_373_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_376_11 = arg_373_1.actors_["1094ui_story"]
			local var_376_12 = 0

			if var_376_12 < arg_373_1.time_ and arg_373_1.time_ <= var_376_12 + arg_376_0 and not isNil(var_376_11) and arg_373_1.var_.characterEffect1094ui_story == nil then
				arg_373_1.var_.characterEffect1094ui_story = var_376_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_376_13 = 0.2

			if var_376_12 <= arg_373_1.time_ and arg_373_1.time_ < var_376_12 + var_376_13 and not isNil(var_376_11) then
				local var_376_14 = (arg_373_1.time_ - var_376_12) / var_376_13

				if arg_373_1.var_.characterEffect1094ui_story and not isNil(var_376_11) then
					arg_373_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_373_1.time_ >= var_376_12 + var_376_13 and arg_373_1.time_ < var_376_12 + var_376_13 + arg_376_0 and not isNil(var_376_11) and arg_373_1.var_.characterEffect1094ui_story then
				arg_373_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_376_15 = 0
			local var_376_16 = 0.375

			if var_376_15 < arg_373_1.time_ and arg_373_1.time_ <= var_376_15 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				local var_376_17 = arg_373_1:FormatText(StoryNameCfg[181].name)

				arg_373_1.leftNameTxt_.text = var_376_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_18 = arg_373_1:GetWordFromCfg(111041089)
				local var_376_19 = arg_373_1:FormatText(var_376_18.content)

				arg_373_1.text_.text = var_376_19

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_20 = 15
				local var_376_21 = utf8.len(var_376_19)
				local var_376_22 = var_376_20 <= 0 and var_376_16 or var_376_16 * (var_376_21 / var_376_20)

				if var_376_22 > 0 and var_376_16 < var_376_22 then
					arg_373_1.talkMaxDuration = var_376_22

					if var_376_22 + var_376_15 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_22 + var_376_15
					end
				end

				arg_373_1.text_.text = var_376_19
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111041", "111041089", "story_v_out_111041.awb") ~= 0 then
					local var_376_23 = manager.audio:GetVoiceLength("story_v_out_111041", "111041089", "story_v_out_111041.awb") / 1000

					if var_376_23 + var_376_15 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_23 + var_376_15
					end

					if var_376_18.prefab_name ~= "" and arg_373_1.actors_[var_376_18.prefab_name] ~= nil then
						local var_376_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_373_1.actors_[var_376_18.prefab_name].transform, "story_v_out_111041", "111041089", "story_v_out_111041.awb")

						arg_373_1:RecordAudio("111041089", var_376_24)
						arg_373_1:RecordAudio("111041089", var_376_24)
					else
						arg_373_1:AudioAction("play", "voice", "story_v_out_111041", "111041089", "story_v_out_111041.awb")
					end

					arg_373_1:RecordHistoryTalkVoice("story_v_out_111041", "111041089", "story_v_out_111041.awb")
				end

				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_25 = math.max(var_376_16, arg_373_1.talkMaxDuration)

			if var_376_15 <= arg_373_1.time_ and arg_373_1.time_ < var_376_15 + var_376_25 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_15) / var_376_25

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_15 + var_376_25 and arg_373_1.time_ < var_376_15 + var_376_25 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {
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

		arg_373_1:InitPlayNodeList()
	end,
	Play111041090 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 111041090
		arg_377_1.duration_ = 2

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play111041091(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = 0

			if var_380_0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_0 + arg_380_0 then
				arg_377_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_380_1 = arg_377_1.actors_["1094ui_story"]
			local var_380_2 = 0

			if var_380_2 < arg_377_1.time_ and arg_377_1.time_ <= var_380_2 + arg_380_0 and not isNil(var_380_1) and arg_377_1.var_.characterEffect1094ui_story == nil then
				arg_377_1.var_.characterEffect1094ui_story = var_380_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_380_3 = 0.2

			if var_380_2 <= arg_377_1.time_ and arg_377_1.time_ < var_380_2 + var_380_3 and not isNil(var_380_1) then
				local var_380_4 = (arg_377_1.time_ - var_380_2) / var_380_3

				if arg_377_1.var_.characterEffect1094ui_story and not isNil(var_380_1) then
					arg_377_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_377_1.time_ >= var_380_2 + var_380_3 and arg_377_1.time_ < var_380_2 + var_380_3 + arg_380_0 and not isNil(var_380_1) and arg_377_1.var_.characterEffect1094ui_story then
				arg_377_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_380_5 = 0
			local var_380_6 = 0.05

			if var_380_5 < arg_377_1.time_ and arg_377_1.time_ <= var_380_5 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				local var_380_7 = arg_377_1:FormatText(StoryNameCfg[181].name)

				arg_377_1.leftNameTxt_.text = var_380_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_8 = arg_377_1:GetWordFromCfg(111041090)
				local var_380_9 = arg_377_1:FormatText(var_380_8.content)

				arg_377_1.text_.text = var_380_9

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_10 = 2
				local var_380_11 = utf8.len(var_380_9)
				local var_380_12 = var_380_10 <= 0 and var_380_6 or var_380_6 * (var_380_11 / var_380_10)

				if var_380_12 > 0 and var_380_6 < var_380_12 then
					arg_377_1.talkMaxDuration = var_380_12

					if var_380_12 + var_380_5 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_12 + var_380_5
					end
				end

				arg_377_1.text_.text = var_380_9
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111041", "111041090", "story_v_out_111041.awb") ~= 0 then
					local var_380_13 = manager.audio:GetVoiceLength("story_v_out_111041", "111041090", "story_v_out_111041.awb") / 1000

					if var_380_13 + var_380_5 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_13 + var_380_5
					end

					if var_380_8.prefab_name ~= "" and arg_377_1.actors_[var_380_8.prefab_name] ~= nil then
						local var_380_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_8.prefab_name].transform, "story_v_out_111041", "111041090", "story_v_out_111041.awb")

						arg_377_1:RecordAudio("111041090", var_380_14)
						arg_377_1:RecordAudio("111041090", var_380_14)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_out_111041", "111041090", "story_v_out_111041.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_out_111041", "111041090", "story_v_out_111041.awb")
				end

				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_15 = math.max(var_380_6, arg_377_1.talkMaxDuration)

			if var_380_5 <= arg_377_1.time_ and arg_377_1.time_ < var_380_5 + var_380_15 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_5) / var_380_15

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_5 + var_380_15 and arg_377_1.time_ < var_380_5 + var_380_15 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {}

		arg_377_1:InitPlayNodeList()
	end,
	Play111041091 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 111041091
		arg_381_1.duration_ = 4.83

		local var_381_0 = {
			ja = 3.6,
			ko = 2.766,
			zh = 4.833,
			en = 3.133
		}
		local var_381_1 = manager.audio:GetLocalizationFlag()

		if var_381_0[var_381_1] ~= nil then
			arg_381_1.duration_ = var_381_0[var_381_1]
		end

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play111041092(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			local var_384_0 = 0

			if var_384_0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_0 + arg_384_0 then
				arg_381_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action3_2")
			end

			local var_384_1 = 0

			if var_384_1 < arg_381_1.time_ and arg_381_1.time_ <= var_384_1 + arg_384_0 then
				arg_381_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_384_2 = arg_381_1.actors_["1094ui_story"]
			local var_384_3 = 0

			if var_384_3 < arg_381_1.time_ and arg_381_1.time_ <= var_384_3 + arg_384_0 and not isNil(var_384_2) and arg_381_1.var_.characterEffect1094ui_story == nil then
				arg_381_1.var_.characterEffect1094ui_story = var_384_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_384_4 = 0.2

			if var_384_3 <= arg_381_1.time_ and arg_381_1.time_ < var_384_3 + var_384_4 and not isNil(var_384_2) then
				local var_384_5 = (arg_381_1.time_ - var_384_3) / var_384_4

				if arg_381_1.var_.characterEffect1094ui_story and not isNil(var_384_2) then
					arg_381_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_381_1.time_ >= var_384_3 + var_384_4 and arg_381_1.time_ < var_384_3 + var_384_4 + arg_384_0 and not isNil(var_384_2) and arg_381_1.var_.characterEffect1094ui_story then
				arg_381_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_384_6 = 0
			local var_384_7 = 0.4

			if var_384_6 < arg_381_1.time_ and arg_381_1.time_ <= var_384_6 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				local var_384_8 = arg_381_1:FormatText(StoryNameCfg[181].name)

				arg_381_1.leftNameTxt_.text = var_384_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_9 = arg_381_1:GetWordFromCfg(111041091)
				local var_384_10 = arg_381_1:FormatText(var_384_9.content)

				arg_381_1.text_.text = var_384_10

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_11 = 16
				local var_384_12 = utf8.len(var_384_10)
				local var_384_13 = var_384_11 <= 0 and var_384_7 or var_384_7 * (var_384_12 / var_384_11)

				if var_384_13 > 0 and var_384_7 < var_384_13 then
					arg_381_1.talkMaxDuration = var_384_13

					if var_384_13 + var_384_6 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_13 + var_384_6
					end
				end

				arg_381_1.text_.text = var_384_10
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111041", "111041091", "story_v_out_111041.awb") ~= 0 then
					local var_384_14 = manager.audio:GetVoiceLength("story_v_out_111041", "111041091", "story_v_out_111041.awb") / 1000

					if var_384_14 + var_384_6 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_14 + var_384_6
					end

					if var_384_9.prefab_name ~= "" and arg_381_1.actors_[var_384_9.prefab_name] ~= nil then
						local var_384_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_381_1.actors_[var_384_9.prefab_name].transform, "story_v_out_111041", "111041091", "story_v_out_111041.awb")

						arg_381_1:RecordAudio("111041091", var_384_15)
						arg_381_1:RecordAudio("111041091", var_384_15)
					else
						arg_381_1:AudioAction("play", "voice", "story_v_out_111041", "111041091", "story_v_out_111041.awb")
					end

					arg_381_1:RecordHistoryTalkVoice("story_v_out_111041", "111041091", "story_v_out_111041.awb")
				end

				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_16 = math.max(var_384_7, arg_381_1.talkMaxDuration)

			if var_384_6 <= arg_381_1.time_ and arg_381_1.time_ < var_384_6 + var_384_16 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_6) / var_384_16

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_6 + var_384_16 and arg_381_1.time_ < var_384_6 + var_384_16 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {}

		arg_381_1:InitPlayNodeList()
	end,
	Play111041092 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 111041092
		arg_385_1.duration_ = 5

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play111041093(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			local var_388_0 = arg_385_1.actors_["1094ui_story"]
			local var_388_1 = 0

			if var_388_1 < arg_385_1.time_ and arg_385_1.time_ <= var_388_1 + arg_388_0 and not isNil(var_388_0) and arg_385_1.var_.characterEffect1094ui_story == nil then
				arg_385_1.var_.characterEffect1094ui_story = var_388_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_388_2 = 0.2

			if var_388_1 <= arg_385_1.time_ and arg_385_1.time_ < var_388_1 + var_388_2 and not isNil(var_388_0) then
				local var_388_3 = (arg_385_1.time_ - var_388_1) / var_388_2

				if arg_385_1.var_.characterEffect1094ui_story and not isNil(var_388_0) then
					local var_388_4 = Mathf.Lerp(0, 0.5, var_388_3)

					arg_385_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_385_1.var_.characterEffect1094ui_story.fillRatio = var_388_4
				end
			end

			if arg_385_1.time_ >= var_388_1 + var_388_2 and arg_385_1.time_ < var_388_1 + var_388_2 + arg_388_0 and not isNil(var_388_0) and arg_385_1.var_.characterEffect1094ui_story then
				local var_388_5 = 0.5

				arg_385_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_385_1.var_.characterEffect1094ui_story.fillRatio = var_388_5
			end

			local var_388_6 = 0
			local var_388_7 = 0.175

			if var_388_6 < arg_385_1.time_ and arg_385_1.time_ <= var_388_6 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				local var_388_8 = arg_385_1:FormatText(StoryNameCfg[7].name)

				arg_385_1.leftNameTxt_.text = var_388_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, true)
				arg_385_1.iconController_:SetSelectedState("hero")

				arg_385_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_385_1.callingController_:SetSelectedState("normal")

				arg_385_1.keyicon_.color = Color.New(1, 1, 1)
				arg_385_1.icon_.color = Color.New(1, 1, 1)

				local var_388_9 = arg_385_1:GetWordFromCfg(111041092)
				local var_388_10 = arg_385_1:FormatText(var_388_9.content)

				arg_385_1.text_.text = var_388_10

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_11 = 7
				local var_388_12 = utf8.len(var_388_10)
				local var_388_13 = var_388_11 <= 0 and var_388_7 or var_388_7 * (var_388_12 / var_388_11)

				if var_388_13 > 0 and var_388_7 < var_388_13 then
					arg_385_1.talkMaxDuration = var_388_13

					if var_388_13 + var_388_6 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_13 + var_388_6
					end
				end

				arg_385_1.text_.text = var_388_10
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)
				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_14 = math.max(var_388_7, arg_385_1.talkMaxDuration)

			if var_388_6 <= arg_385_1.time_ and arg_385_1.time_ < var_388_6 + var_388_14 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_6) / var_388_14

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_6 + var_388_14 and arg_385_1.time_ < var_388_6 + var_388_14 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	Play111041093 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 111041093
		arg_389_1.duration_ = 4.1

		local var_389_0 = {
			ja = 4.1,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
		}
		local var_389_1 = manager.audio:GetLocalizationFlag()

		if var_389_0[var_389_1] ~= nil then
			arg_389_1.duration_ = var_389_0[var_389_1]
		end

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play111041094(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			local var_392_0 = 0

			if var_392_0 < arg_389_1.time_ and arg_389_1.time_ <= var_392_0 + arg_392_0 then
				arg_389_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_392_1 = arg_389_1.actors_["1094ui_story"]
			local var_392_2 = 0

			if var_392_2 < arg_389_1.time_ and arg_389_1.time_ <= var_392_2 + arg_392_0 and not isNil(var_392_1) and arg_389_1.var_.characterEffect1094ui_story == nil then
				arg_389_1.var_.characterEffect1094ui_story = var_392_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_392_3 = 0.2

			if var_392_2 <= arg_389_1.time_ and arg_389_1.time_ < var_392_2 + var_392_3 and not isNil(var_392_1) then
				local var_392_4 = (arg_389_1.time_ - var_392_2) / var_392_3

				if arg_389_1.var_.characterEffect1094ui_story and not isNil(var_392_1) then
					arg_389_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_389_1.time_ >= var_392_2 + var_392_3 and arg_389_1.time_ < var_392_2 + var_392_3 + arg_392_0 and not isNil(var_392_1) and arg_389_1.var_.characterEffect1094ui_story then
				arg_389_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_392_5 = 0
			local var_392_6 = 0.175

			if var_392_5 < arg_389_1.time_ and arg_389_1.time_ <= var_392_5 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				local var_392_7 = arg_389_1:FormatText(StoryNameCfg[181].name)

				arg_389_1.leftNameTxt_.text = var_392_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_8 = arg_389_1:GetWordFromCfg(111041093)
				local var_392_9 = arg_389_1:FormatText(var_392_8.content)

				arg_389_1.text_.text = var_392_9

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_10 = 7
				local var_392_11 = utf8.len(var_392_9)
				local var_392_12 = var_392_10 <= 0 and var_392_6 or var_392_6 * (var_392_11 / var_392_10)

				if var_392_12 > 0 and var_392_6 < var_392_12 then
					arg_389_1.talkMaxDuration = var_392_12

					if var_392_12 + var_392_5 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_12 + var_392_5
					end
				end

				arg_389_1.text_.text = var_392_9
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111041", "111041093", "story_v_out_111041.awb") ~= 0 then
					local var_392_13 = manager.audio:GetVoiceLength("story_v_out_111041", "111041093", "story_v_out_111041.awb") / 1000

					if var_392_13 + var_392_5 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_13 + var_392_5
					end

					if var_392_8.prefab_name ~= "" and arg_389_1.actors_[var_392_8.prefab_name] ~= nil then
						local var_392_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_389_1.actors_[var_392_8.prefab_name].transform, "story_v_out_111041", "111041093", "story_v_out_111041.awb")

						arg_389_1:RecordAudio("111041093", var_392_14)
						arg_389_1:RecordAudio("111041093", var_392_14)
					else
						arg_389_1:AudioAction("play", "voice", "story_v_out_111041", "111041093", "story_v_out_111041.awb")
					end

					arg_389_1:RecordHistoryTalkVoice("story_v_out_111041", "111041093", "story_v_out_111041.awb")
				end

				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_15 = math.max(var_392_6, arg_389_1.talkMaxDuration)

			if var_392_5 <= arg_389_1.time_ and arg_389_1.time_ < var_392_5 + var_392_15 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_5) / var_392_15

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_5 + var_392_15 and arg_389_1.time_ < var_392_5 + var_392_15 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {}

		arg_389_1:InitPlayNodeList()
	end,
	Play111041094 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 111041094
		arg_393_1.duration_ = 6.07

		local var_393_0 = {
			ja = 6.066,
			ko = 2.566,
			zh = 1.999999999999,
			en = 1.999999999999
		}
		local var_393_1 = manager.audio:GetLocalizationFlag()

		if var_393_0[var_393_1] ~= nil then
			arg_393_1.duration_ = var_393_0[var_393_1]
		end

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play111041095(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = 0

			if var_396_0 < arg_393_1.time_ and arg_393_1.time_ <= var_396_0 + arg_396_0 then
				arg_393_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action5_1")
			end

			local var_396_1 = 0

			if var_396_1 < arg_393_1.time_ and arg_393_1.time_ <= var_396_1 + arg_396_0 then
				arg_393_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_396_2 = arg_393_1.actors_["1094ui_story"]
			local var_396_3 = 0

			if var_396_3 < arg_393_1.time_ and arg_393_1.time_ <= var_396_3 + arg_396_0 and not isNil(var_396_2) and arg_393_1.var_.characterEffect1094ui_story == nil then
				arg_393_1.var_.characterEffect1094ui_story = var_396_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_396_4 = 0.2

			if var_396_3 <= arg_393_1.time_ and arg_393_1.time_ < var_396_3 + var_396_4 and not isNil(var_396_2) then
				local var_396_5 = (arg_393_1.time_ - var_396_3) / var_396_4

				if arg_393_1.var_.characterEffect1094ui_story and not isNil(var_396_2) then
					arg_393_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_393_1.time_ >= var_396_3 + var_396_4 and arg_393_1.time_ < var_396_3 + var_396_4 + arg_396_0 and not isNil(var_396_2) and arg_393_1.var_.characterEffect1094ui_story then
				arg_393_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_396_6 = 0
			local var_396_7 = 0.225

			if var_396_6 < arg_393_1.time_ and arg_393_1.time_ <= var_396_6 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				local var_396_8 = arg_393_1:FormatText(StoryNameCfg[181].name)

				arg_393_1.leftNameTxt_.text = var_396_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_9 = arg_393_1:GetWordFromCfg(111041094)
				local var_396_10 = arg_393_1:FormatText(var_396_9.content)

				arg_393_1.text_.text = var_396_10

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_11 = 9
				local var_396_12 = utf8.len(var_396_10)
				local var_396_13 = var_396_11 <= 0 and var_396_7 or var_396_7 * (var_396_12 / var_396_11)

				if var_396_13 > 0 and var_396_7 < var_396_13 then
					arg_393_1.talkMaxDuration = var_396_13

					if var_396_13 + var_396_6 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_13 + var_396_6
					end
				end

				arg_393_1.text_.text = var_396_10
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111041", "111041094", "story_v_out_111041.awb") ~= 0 then
					local var_396_14 = manager.audio:GetVoiceLength("story_v_out_111041", "111041094", "story_v_out_111041.awb") / 1000

					if var_396_14 + var_396_6 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_14 + var_396_6
					end

					if var_396_9.prefab_name ~= "" and arg_393_1.actors_[var_396_9.prefab_name] ~= nil then
						local var_396_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_393_1.actors_[var_396_9.prefab_name].transform, "story_v_out_111041", "111041094", "story_v_out_111041.awb")

						arg_393_1:RecordAudio("111041094", var_396_15)
						arg_393_1:RecordAudio("111041094", var_396_15)
					else
						arg_393_1:AudioAction("play", "voice", "story_v_out_111041", "111041094", "story_v_out_111041.awb")
					end

					arg_393_1:RecordHistoryTalkVoice("story_v_out_111041", "111041094", "story_v_out_111041.awb")
				end

				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_16 = math.max(var_396_7, arg_393_1.talkMaxDuration)

			if var_396_6 <= arg_393_1.time_ and arg_393_1.time_ < var_396_6 + var_396_16 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_6) / var_396_16

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_6 + var_396_16 and arg_393_1.time_ < var_396_6 + var_396_16 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play111041095 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 111041095
		arg_397_1.duration_ = 5

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play111041096(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = arg_397_1.actors_["1094ui_story"]
			local var_400_1 = 0

			if var_400_1 < arg_397_1.time_ and arg_397_1.time_ <= var_400_1 + arg_400_0 and not isNil(var_400_0) and arg_397_1.var_.characterEffect1094ui_story == nil then
				arg_397_1.var_.characterEffect1094ui_story = var_400_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_400_2 = 0.2

			if var_400_1 <= arg_397_1.time_ and arg_397_1.time_ < var_400_1 + var_400_2 and not isNil(var_400_0) then
				local var_400_3 = (arg_397_1.time_ - var_400_1) / var_400_2

				if arg_397_1.var_.characterEffect1094ui_story and not isNil(var_400_0) then
					local var_400_4 = Mathf.Lerp(0, 0.5, var_400_3)

					arg_397_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_397_1.var_.characterEffect1094ui_story.fillRatio = var_400_4
				end
			end

			if arg_397_1.time_ >= var_400_1 + var_400_2 and arg_397_1.time_ < var_400_1 + var_400_2 + arg_400_0 and not isNil(var_400_0) and arg_397_1.var_.characterEffect1094ui_story then
				local var_400_5 = 0.5

				arg_397_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_397_1.var_.characterEffect1094ui_story.fillRatio = var_400_5
			end

			local var_400_6 = 0
			local var_400_7 = 1.025

			if var_400_6 < arg_397_1.time_ and arg_397_1.time_ <= var_400_6 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, false)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_8 = arg_397_1:GetWordFromCfg(111041095)
				local var_400_9 = arg_397_1:FormatText(var_400_8.content)

				arg_397_1.text_.text = var_400_9

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_10 = 41
				local var_400_11 = utf8.len(var_400_9)
				local var_400_12 = var_400_10 <= 0 and var_400_7 or var_400_7 * (var_400_11 / var_400_10)

				if var_400_12 > 0 and var_400_7 < var_400_12 then
					arg_397_1.talkMaxDuration = var_400_12

					if var_400_12 + var_400_6 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_12 + var_400_6
					end
				end

				arg_397_1.text_.text = var_400_9
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)
				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_13 = math.max(var_400_7, arg_397_1.talkMaxDuration)

			if var_400_6 <= arg_397_1.time_ and arg_397_1.time_ < var_400_6 + var_400_13 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_6) / var_400_13

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_6 + var_400_13 and arg_397_1.time_ < var_400_6 + var_400_13 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play111041096 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 111041096
		arg_401_1.duration_ = 5

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play111041097(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = 0
			local var_404_1 = 1.025

			if var_404_0 < arg_401_1.time_ and arg_401_1.time_ <= var_404_0 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, false)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_2 = arg_401_1:GetWordFromCfg(111041096)
				local var_404_3 = arg_401_1:FormatText(var_404_2.content)

				arg_401_1.text_.text = var_404_3

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_4 = 41
				local var_404_5 = utf8.len(var_404_3)
				local var_404_6 = var_404_4 <= 0 and var_404_1 or var_404_1 * (var_404_5 / var_404_4)

				if var_404_6 > 0 and var_404_1 < var_404_6 then
					arg_401_1.talkMaxDuration = var_404_6

					if var_404_6 + var_404_0 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_6 + var_404_0
					end
				end

				arg_401_1.text_.text = var_404_3
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)
				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_7 = math.max(var_404_1, arg_401_1.talkMaxDuration)

			if var_404_0 <= arg_401_1.time_ and arg_401_1.time_ < var_404_0 + var_404_7 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_0) / var_404_7

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_0 + var_404_7 and arg_401_1.time_ < var_404_0 + var_404_7 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play111041097 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 111041097
		arg_405_1.duration_ = 5

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play111041098(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = manager.ui.mainCamera.transform
			local var_408_1 = 0

			if var_408_1 < arg_405_1.time_ and arg_405_1.time_ <= var_408_1 + arg_408_0 then
				arg_405_1.var_.shakeOldPos = var_408_0.localPosition
			end

			local var_408_2 = 0.233333333333333

			if var_408_1 <= arg_405_1.time_ and arg_405_1.time_ < var_408_1 + var_408_2 then
				local var_408_3 = (arg_405_1.time_ - var_408_1) / 0.066
				local var_408_4, var_408_5 = math.modf(var_408_3)

				var_408_0.localPosition = Vector3.New(var_408_5 * 0.13, var_408_5 * 0.13, var_408_5 * 0.13) + arg_405_1.var_.shakeOldPos
			end

			if arg_405_1.time_ >= var_408_1 + var_408_2 and arg_405_1.time_ < var_408_1 + var_408_2 + arg_408_0 then
				var_408_0.localPosition = arg_405_1.var_.shakeOldPos
			end

			local var_408_6 = 0
			local var_408_7 = 0.55

			if var_408_6 < arg_405_1.time_ and arg_405_1.time_ <= var_408_6 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, true)

				local var_408_8 = arg_405_1:FormatText(StoryNameCfg[7].name)

				arg_405_1.leftNameTxt_.text = var_408_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, true)
				arg_405_1.iconController_:SetSelectedState("hero")

				arg_405_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_405_1.callingController_:SetSelectedState("normal")

				arg_405_1.keyicon_.color = Color.New(1, 1, 1)
				arg_405_1.icon_.color = Color.New(1, 1, 1)

				local var_408_9 = arg_405_1:GetWordFromCfg(111041097)
				local var_408_10 = arg_405_1:FormatText(var_408_9.content)

				arg_405_1.text_.text = var_408_10

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_11 = 22
				local var_408_12 = utf8.len(var_408_10)
				local var_408_13 = var_408_11 <= 0 and var_408_7 or var_408_7 * (var_408_12 / var_408_11)

				if var_408_13 > 0 and var_408_7 < var_408_13 then
					arg_405_1.talkMaxDuration = var_408_13

					if var_408_13 + var_408_6 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_13 + var_408_6
					end
				end

				arg_405_1.text_.text = var_408_10
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)
				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_14 = math.max(var_408_7, arg_405_1.talkMaxDuration)

			if var_408_6 <= arg_405_1.time_ and arg_405_1.time_ < var_408_6 + var_408_14 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_6) / var_408_14

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_6 + var_408_14 and arg_405_1.time_ < var_408_6 + var_408_14 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	Play111041098 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 111041098
		arg_409_1.duration_ = 2.83

		local var_409_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 2.833,
			en = 2.066
		}
		local var_409_1 = manager.audio:GetLocalizationFlag()

		if var_409_0[var_409_1] ~= nil then
			arg_409_1.duration_ = var_409_0[var_409_1]
		end

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play111041099(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			local var_412_0 = 0

			if var_412_0 < arg_409_1.time_ and arg_409_1.time_ <= var_412_0 + arg_412_0 then
				arg_409_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action5_2")
			end

			local var_412_1 = 0

			if var_412_1 < arg_409_1.time_ and arg_409_1.time_ <= var_412_1 + arg_412_0 then
				arg_409_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_412_2 = arg_409_1.actors_["1094ui_story"]
			local var_412_3 = 0

			if var_412_3 < arg_409_1.time_ and arg_409_1.time_ <= var_412_3 + arg_412_0 and not isNil(var_412_2) and arg_409_1.var_.characterEffect1094ui_story == nil then
				arg_409_1.var_.characterEffect1094ui_story = var_412_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_412_4 = 0.2

			if var_412_3 <= arg_409_1.time_ and arg_409_1.time_ < var_412_3 + var_412_4 and not isNil(var_412_2) then
				local var_412_5 = (arg_409_1.time_ - var_412_3) / var_412_4

				if arg_409_1.var_.characterEffect1094ui_story and not isNil(var_412_2) then
					arg_409_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_409_1.time_ >= var_412_3 + var_412_4 and arg_409_1.time_ < var_412_3 + var_412_4 + arg_412_0 and not isNil(var_412_2) and arg_409_1.var_.characterEffect1094ui_story then
				arg_409_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_412_6 = 0
			local var_412_7 = 0.175

			if var_412_6 < arg_409_1.time_ and arg_409_1.time_ <= var_412_6 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				local var_412_8 = arg_409_1:FormatText(StoryNameCfg[181].name)

				arg_409_1.leftNameTxt_.text = var_412_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_9 = arg_409_1:GetWordFromCfg(111041098)
				local var_412_10 = arg_409_1:FormatText(var_412_9.content)

				arg_409_1.text_.text = var_412_10

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_11 = 7
				local var_412_12 = utf8.len(var_412_10)
				local var_412_13 = var_412_11 <= 0 and var_412_7 or var_412_7 * (var_412_12 / var_412_11)

				if var_412_13 > 0 and var_412_7 < var_412_13 then
					arg_409_1.talkMaxDuration = var_412_13

					if var_412_13 + var_412_6 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_13 + var_412_6
					end
				end

				arg_409_1.text_.text = var_412_10
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111041", "111041098", "story_v_out_111041.awb") ~= 0 then
					local var_412_14 = manager.audio:GetVoiceLength("story_v_out_111041", "111041098", "story_v_out_111041.awb") / 1000

					if var_412_14 + var_412_6 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_14 + var_412_6
					end

					if var_412_9.prefab_name ~= "" and arg_409_1.actors_[var_412_9.prefab_name] ~= nil then
						local var_412_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_409_1.actors_[var_412_9.prefab_name].transform, "story_v_out_111041", "111041098", "story_v_out_111041.awb")

						arg_409_1:RecordAudio("111041098", var_412_15)
						arg_409_1:RecordAudio("111041098", var_412_15)
					else
						arg_409_1:AudioAction("play", "voice", "story_v_out_111041", "111041098", "story_v_out_111041.awb")
					end

					arg_409_1:RecordHistoryTalkVoice("story_v_out_111041", "111041098", "story_v_out_111041.awb")
				end

				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_16 = math.max(var_412_7, arg_409_1.talkMaxDuration)

			if var_412_6 <= arg_409_1.time_ and arg_409_1.time_ < var_412_6 + var_412_16 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_6) / var_412_16

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_6 + var_412_16 and arg_409_1.time_ < var_412_6 + var_412_16 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {}

		arg_409_1:InitPlayNodeList()
	end,
	Play111041099 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 111041099
		arg_413_1.duration_ = 5

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play111041100(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			local var_416_0 = arg_413_1.actors_["1094ui_story"]
			local var_416_1 = 0

			if var_416_1 < arg_413_1.time_ and arg_413_1.time_ <= var_416_1 + arg_416_0 and not isNil(var_416_0) and arg_413_1.var_.characterEffect1094ui_story == nil then
				arg_413_1.var_.characterEffect1094ui_story = var_416_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_416_2 = 0.2

			if var_416_1 <= arg_413_1.time_ and arg_413_1.time_ < var_416_1 + var_416_2 and not isNil(var_416_0) then
				local var_416_3 = (arg_413_1.time_ - var_416_1) / var_416_2

				if arg_413_1.var_.characterEffect1094ui_story and not isNil(var_416_0) then
					local var_416_4 = Mathf.Lerp(0, 0.5, var_416_3)

					arg_413_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_413_1.var_.characterEffect1094ui_story.fillRatio = var_416_4
				end
			end

			if arg_413_1.time_ >= var_416_1 + var_416_2 and arg_413_1.time_ < var_416_1 + var_416_2 + arg_416_0 and not isNil(var_416_0) and arg_413_1.var_.characterEffect1094ui_story then
				local var_416_5 = 0.5

				arg_413_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_413_1.var_.characterEffect1094ui_story.fillRatio = var_416_5
			end

			local var_416_6 = 0
			local var_416_7 = 0.3

			if var_416_6 < arg_413_1.time_ and arg_413_1.time_ <= var_416_6 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, true)

				local var_416_8 = arg_413_1:FormatText(StoryNameCfg[7].name)

				arg_413_1.leftNameTxt_.text = var_416_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, true)
				arg_413_1.iconController_:SetSelectedState("hero")

				arg_413_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_413_1.callingController_:SetSelectedState("normal")

				arg_413_1.keyicon_.color = Color.New(1, 1, 1)
				arg_413_1.icon_.color = Color.New(1, 1, 1)

				local var_416_9 = arg_413_1:GetWordFromCfg(111041099)
				local var_416_10 = arg_413_1:FormatText(var_416_9.content)

				arg_413_1.text_.text = var_416_10

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_11 = 12
				local var_416_12 = utf8.len(var_416_10)
				local var_416_13 = var_416_11 <= 0 and var_416_7 or var_416_7 * (var_416_12 / var_416_11)

				if var_416_13 > 0 and var_416_7 < var_416_13 then
					arg_413_1.talkMaxDuration = var_416_13

					if var_416_13 + var_416_6 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_13 + var_416_6
					end
				end

				arg_413_1.text_.text = var_416_10
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)
				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_14 = math.max(var_416_7, arg_413_1.talkMaxDuration)

			if var_416_6 <= arg_413_1.time_ and arg_413_1.time_ < var_416_6 + var_416_14 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_6) / var_416_14

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_6 + var_416_14 and arg_413_1.time_ < var_416_6 + var_416_14 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {}

		arg_413_1:InitPlayNodeList()
	end,
	Play111041100 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 111041100
		arg_417_1.duration_ = 5

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play111041101(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			local var_420_0 = 0
			local var_420_1 = 0.8

			if var_420_0 < arg_417_1.time_ and arg_417_1.time_ <= var_420_0 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				local var_420_2 = arg_417_1:FormatText(StoryNameCfg[7].name)

				arg_417_1.leftNameTxt_.text = var_420_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, true)
				arg_417_1.iconController_:SetSelectedState("hero")

				arg_417_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_417_1.callingController_:SetSelectedState("normal")

				arg_417_1.keyicon_.color = Color.New(1, 1, 1)
				arg_417_1.icon_.color = Color.New(1, 1, 1)

				local var_420_3 = arg_417_1:GetWordFromCfg(111041100)
				local var_420_4 = arg_417_1:FormatText(var_420_3.content)

				arg_417_1.text_.text = var_420_4

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_5 = 32
				local var_420_6 = utf8.len(var_420_4)
				local var_420_7 = var_420_5 <= 0 and var_420_1 or var_420_1 * (var_420_6 / var_420_5)

				if var_420_7 > 0 and var_420_1 < var_420_7 then
					arg_417_1.talkMaxDuration = var_420_7

					if var_420_7 + var_420_0 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_7 + var_420_0
					end
				end

				arg_417_1.text_.text = var_420_4
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)
				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_8 = math.max(var_420_1, arg_417_1.talkMaxDuration)

			if var_420_0 <= arg_417_1.time_ and arg_417_1.time_ < var_420_0 + var_420_8 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_0) / var_420_8

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_0 + var_420_8 and arg_417_1.time_ < var_420_0 + var_420_8 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {}

		arg_417_1:InitPlayNodeList()
	end,
	Play111041101 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 111041101
		arg_421_1.duration_ = 2

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play111041102(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			local var_424_0 = 0

			if var_424_0 < arg_421_1.time_ and arg_421_1.time_ <= var_424_0 + arg_424_0 then
				arg_421_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_424_1 = arg_421_1.actors_["1094ui_story"]
			local var_424_2 = 0

			if var_424_2 < arg_421_1.time_ and arg_421_1.time_ <= var_424_2 + arg_424_0 and not isNil(var_424_1) and arg_421_1.var_.characterEffect1094ui_story == nil then
				arg_421_1.var_.characterEffect1094ui_story = var_424_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_424_3 = 0.2

			if var_424_2 <= arg_421_1.time_ and arg_421_1.time_ < var_424_2 + var_424_3 and not isNil(var_424_1) then
				local var_424_4 = (arg_421_1.time_ - var_424_2) / var_424_3

				if arg_421_1.var_.characterEffect1094ui_story and not isNil(var_424_1) then
					arg_421_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_421_1.time_ >= var_424_2 + var_424_3 and arg_421_1.time_ < var_424_2 + var_424_3 + arg_424_0 and not isNil(var_424_1) and arg_421_1.var_.characterEffect1094ui_story then
				arg_421_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_424_5 = 0
			local var_424_6 = 0.125

			if var_424_5 < arg_421_1.time_ and arg_421_1.time_ <= var_424_5 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, true)

				local var_424_7 = arg_421_1:FormatText(StoryNameCfg[181].name)

				arg_421_1.leftNameTxt_.text = var_424_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_421_1.leftNameTxt_.transform)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1.leftNameTxt_.text)
				SetActive(arg_421_1.iconTrs_.gameObject, false)
				arg_421_1.callingController_:SetSelectedState("normal")

				local var_424_8 = arg_421_1:GetWordFromCfg(111041101)
				local var_424_9 = arg_421_1:FormatText(var_424_8.content)

				arg_421_1.text_.text = var_424_9

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_10 = 5
				local var_424_11 = utf8.len(var_424_9)
				local var_424_12 = var_424_10 <= 0 and var_424_6 or var_424_6 * (var_424_11 / var_424_10)

				if var_424_12 > 0 and var_424_6 < var_424_12 then
					arg_421_1.talkMaxDuration = var_424_12

					if var_424_12 + var_424_5 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_12 + var_424_5
					end
				end

				arg_421_1.text_.text = var_424_9
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111041", "111041101", "story_v_out_111041.awb") ~= 0 then
					local var_424_13 = manager.audio:GetVoiceLength("story_v_out_111041", "111041101", "story_v_out_111041.awb") / 1000

					if var_424_13 + var_424_5 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_13 + var_424_5
					end

					if var_424_8.prefab_name ~= "" and arg_421_1.actors_[var_424_8.prefab_name] ~= nil then
						local var_424_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_421_1.actors_[var_424_8.prefab_name].transform, "story_v_out_111041", "111041101", "story_v_out_111041.awb")

						arg_421_1:RecordAudio("111041101", var_424_14)
						arg_421_1:RecordAudio("111041101", var_424_14)
					else
						arg_421_1:AudioAction("play", "voice", "story_v_out_111041", "111041101", "story_v_out_111041.awb")
					end

					arg_421_1:RecordHistoryTalkVoice("story_v_out_111041", "111041101", "story_v_out_111041.awb")
				end

				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_15 = math.max(var_424_6, arg_421_1.talkMaxDuration)

			if var_424_5 <= arg_421_1.time_ and arg_421_1.time_ < var_424_5 + var_424_15 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_5) / var_424_15

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_5 + var_424_15 and arg_421_1.time_ < var_424_5 + var_424_15 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {}

		arg_421_1:InitPlayNodeList()
	end,
	Play111041102 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 111041102
		arg_425_1.duration_ = 5

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play111041103(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			local var_428_0 = arg_425_1.actors_["1094ui_story"]
			local var_428_1 = 0

			if var_428_1 < arg_425_1.time_ and arg_425_1.time_ <= var_428_1 + arg_428_0 and not isNil(var_428_0) and arg_425_1.var_.characterEffect1094ui_story == nil then
				arg_425_1.var_.characterEffect1094ui_story = var_428_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_428_2 = 0.2

			if var_428_1 <= arg_425_1.time_ and arg_425_1.time_ < var_428_1 + var_428_2 and not isNil(var_428_0) then
				local var_428_3 = (arg_425_1.time_ - var_428_1) / var_428_2

				if arg_425_1.var_.characterEffect1094ui_story and not isNil(var_428_0) then
					local var_428_4 = Mathf.Lerp(0, 0.5, var_428_3)

					arg_425_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_425_1.var_.characterEffect1094ui_story.fillRatio = var_428_4
				end
			end

			if arg_425_1.time_ >= var_428_1 + var_428_2 and arg_425_1.time_ < var_428_1 + var_428_2 + arg_428_0 and not isNil(var_428_0) and arg_425_1.var_.characterEffect1094ui_story then
				local var_428_5 = 0.5

				arg_425_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_425_1.var_.characterEffect1094ui_story.fillRatio = var_428_5
			end

			local var_428_6 = 0
			local var_428_7 = 0.75

			if var_428_6 < arg_425_1.time_ and arg_425_1.time_ <= var_428_6 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, true)

				local var_428_8 = arg_425_1:FormatText(StoryNameCfg[7].name)

				arg_425_1.leftNameTxt_.text = var_428_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_425_1.leftNameTxt_.transform)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1.leftNameTxt_.text)
				SetActive(arg_425_1.iconTrs_.gameObject, true)
				arg_425_1.iconController_:SetSelectedState("hero")

				arg_425_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_425_1.callingController_:SetSelectedState("normal")

				arg_425_1.keyicon_.color = Color.New(1, 1, 1)
				arg_425_1.icon_.color = Color.New(1, 1, 1)

				local var_428_9 = arg_425_1:GetWordFromCfg(111041102)
				local var_428_10 = arg_425_1:FormatText(var_428_9.content)

				arg_425_1.text_.text = var_428_10

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_11 = 30
				local var_428_12 = utf8.len(var_428_10)
				local var_428_13 = var_428_11 <= 0 and var_428_7 or var_428_7 * (var_428_12 / var_428_11)

				if var_428_13 > 0 and var_428_7 < var_428_13 then
					arg_425_1.talkMaxDuration = var_428_13

					if var_428_13 + var_428_6 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_13 + var_428_6
					end
				end

				arg_425_1.text_.text = var_428_10
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)
				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_14 = math.max(var_428_7, arg_425_1.talkMaxDuration)

			if var_428_6 <= arg_425_1.time_ and arg_425_1.time_ < var_428_6 + var_428_14 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - var_428_6) / var_428_14

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= var_428_6 + var_428_14 and arg_425_1.time_ < var_428_6 + var_428_14 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {}

		arg_425_1:InitPlayNodeList()
	end,
	Play111041103 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 111041103
		arg_429_1.duration_ = 5

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play111041104(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			local var_432_0 = 0

			if var_432_0 < arg_429_1.time_ and arg_429_1.time_ <= var_432_0 + arg_432_0 then
				arg_429_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_432_1 = 0
			local var_432_2 = 0.6

			if var_432_1 < arg_429_1.time_ and arg_429_1.time_ <= var_432_1 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, false)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_429_1.iconTrs_.gameObject, false)
				arg_429_1.callingController_:SetSelectedState("normal")

				local var_432_3 = arg_429_1:GetWordFromCfg(111041103)
				local var_432_4 = arg_429_1:FormatText(var_432_3.content)

				arg_429_1.text_.text = var_432_4

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_5 = 24
				local var_432_6 = utf8.len(var_432_4)
				local var_432_7 = var_432_5 <= 0 and var_432_2 or var_432_2 * (var_432_6 / var_432_5)

				if var_432_7 > 0 and var_432_2 < var_432_7 then
					arg_429_1.talkMaxDuration = var_432_7

					if var_432_7 + var_432_1 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_7 + var_432_1
					end
				end

				arg_429_1.text_.text = var_432_4
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)
				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_8 = math.max(var_432_2, arg_429_1.talkMaxDuration)

			if var_432_1 <= arg_429_1.time_ and arg_429_1.time_ < var_432_1 + var_432_8 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_1) / var_432_8

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_1 + var_432_8 and arg_429_1.time_ < var_432_1 + var_432_8 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {}

		arg_429_1:InitPlayNodeList()
	end,
	Play111041104 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 111041104
		arg_433_1.duration_ = 5.3

		local var_433_0 = {
			ja = 5.3,
			ko = 1.999999999999,
			zh = 2.466,
			en = 2.7
		}
		local var_433_1 = manager.audio:GetLocalizationFlag()

		if var_433_0[var_433_1] ~= nil then
			arg_433_1.duration_ = var_433_0[var_433_1]
		end

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play111041105(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			local var_436_0 = 0

			if var_436_0 < arg_433_1.time_ and arg_433_1.time_ <= var_436_0 + arg_436_0 then
				arg_433_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action2_1")
			end

			local var_436_1 = 0

			if var_436_1 < arg_433_1.time_ and arg_433_1.time_ <= var_436_1 + arg_436_0 then
				arg_433_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_436_2 = arg_433_1.actors_["1094ui_story"]
			local var_436_3 = 0

			if var_436_3 < arg_433_1.time_ and arg_433_1.time_ <= var_436_3 + arg_436_0 and not isNil(var_436_2) and arg_433_1.var_.characterEffect1094ui_story == nil then
				arg_433_1.var_.characterEffect1094ui_story = var_436_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_436_4 = 0.2

			if var_436_3 <= arg_433_1.time_ and arg_433_1.time_ < var_436_3 + var_436_4 and not isNil(var_436_2) then
				local var_436_5 = (arg_433_1.time_ - var_436_3) / var_436_4

				if arg_433_1.var_.characterEffect1094ui_story and not isNil(var_436_2) then
					arg_433_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_433_1.time_ >= var_436_3 + var_436_4 and arg_433_1.time_ < var_436_3 + var_436_4 + arg_436_0 and not isNil(var_436_2) and arg_433_1.var_.characterEffect1094ui_story then
				arg_433_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_436_6 = 0
			local var_436_7 = 0.2

			if var_436_6 < arg_433_1.time_ and arg_433_1.time_ <= var_436_6 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, true)

				local var_436_8 = arg_433_1:FormatText(StoryNameCfg[181].name)

				arg_433_1.leftNameTxt_.text = var_436_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_433_1.leftNameTxt_.transform)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1.leftNameTxt_.text)
				SetActive(arg_433_1.iconTrs_.gameObject, false)
				arg_433_1.callingController_:SetSelectedState("normal")

				local var_436_9 = arg_433_1:GetWordFromCfg(111041104)
				local var_436_10 = arg_433_1:FormatText(var_436_9.content)

				arg_433_1.text_.text = var_436_10

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_11 = 8
				local var_436_12 = utf8.len(var_436_10)
				local var_436_13 = var_436_11 <= 0 and var_436_7 or var_436_7 * (var_436_12 / var_436_11)

				if var_436_13 > 0 and var_436_7 < var_436_13 then
					arg_433_1.talkMaxDuration = var_436_13

					if var_436_13 + var_436_6 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_13 + var_436_6
					end
				end

				arg_433_1.text_.text = var_436_10
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111041", "111041104", "story_v_out_111041.awb") ~= 0 then
					local var_436_14 = manager.audio:GetVoiceLength("story_v_out_111041", "111041104", "story_v_out_111041.awb") / 1000

					if var_436_14 + var_436_6 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_14 + var_436_6
					end

					if var_436_9.prefab_name ~= "" and arg_433_1.actors_[var_436_9.prefab_name] ~= nil then
						local var_436_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_433_1.actors_[var_436_9.prefab_name].transform, "story_v_out_111041", "111041104", "story_v_out_111041.awb")

						arg_433_1:RecordAudio("111041104", var_436_15)
						arg_433_1:RecordAudio("111041104", var_436_15)
					else
						arg_433_1:AudioAction("play", "voice", "story_v_out_111041", "111041104", "story_v_out_111041.awb")
					end

					arg_433_1:RecordHistoryTalkVoice("story_v_out_111041", "111041104", "story_v_out_111041.awb")
				end

				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_16 = math.max(var_436_7, arg_433_1.talkMaxDuration)

			if var_436_6 <= arg_433_1.time_ and arg_433_1.time_ < var_436_6 + var_436_16 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - var_436_6) / var_436_16

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= var_436_6 + var_436_16 and arg_433_1.time_ < var_436_6 + var_436_16 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {}

		arg_433_1:InitPlayNodeList()
	end,
	Play111041105 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 111041105
		arg_437_1.duration_ = 5

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play111041106(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			local var_440_0 = arg_437_1.actors_["1094ui_story"]
			local var_440_1 = 0

			if var_440_1 < arg_437_1.time_ and arg_437_1.time_ <= var_440_1 + arg_440_0 and not isNil(var_440_0) and arg_437_1.var_.characterEffect1094ui_story == nil then
				arg_437_1.var_.characterEffect1094ui_story = var_440_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_440_2 = 0.2

			if var_440_1 <= arg_437_1.time_ and arg_437_1.time_ < var_440_1 + var_440_2 and not isNil(var_440_0) then
				local var_440_3 = (arg_437_1.time_ - var_440_1) / var_440_2

				if arg_437_1.var_.characterEffect1094ui_story and not isNil(var_440_0) then
					local var_440_4 = Mathf.Lerp(0, 0.5, var_440_3)

					arg_437_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_437_1.var_.characterEffect1094ui_story.fillRatio = var_440_4
				end
			end

			if arg_437_1.time_ >= var_440_1 + var_440_2 and arg_437_1.time_ < var_440_1 + var_440_2 + arg_440_0 and not isNil(var_440_0) and arg_437_1.var_.characterEffect1094ui_story then
				local var_440_5 = 0.5

				arg_437_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_437_1.var_.characterEffect1094ui_story.fillRatio = var_440_5
			end

			local var_440_6 = 0
			local var_440_7 = 0.275

			if var_440_6 < arg_437_1.time_ and arg_437_1.time_ <= var_440_6 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, true)

				local var_440_8 = arg_437_1:FormatText(StoryNameCfg[7].name)

				arg_437_1.leftNameTxt_.text = var_440_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_437_1.leftNameTxt_.transform)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1.leftNameTxt_.text)
				SetActive(arg_437_1.iconTrs_.gameObject, true)
				arg_437_1.iconController_:SetSelectedState("hero")

				arg_437_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_437_1.callingController_:SetSelectedState("normal")

				arg_437_1.keyicon_.color = Color.New(1, 1, 1)
				arg_437_1.icon_.color = Color.New(1, 1, 1)

				local var_440_9 = arg_437_1:GetWordFromCfg(111041105)
				local var_440_10 = arg_437_1:FormatText(var_440_9.content)

				arg_437_1.text_.text = var_440_10

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_11 = 11
				local var_440_12 = utf8.len(var_440_10)
				local var_440_13 = var_440_11 <= 0 and var_440_7 or var_440_7 * (var_440_12 / var_440_11)

				if var_440_13 > 0 and var_440_7 < var_440_13 then
					arg_437_1.talkMaxDuration = var_440_13

					if var_440_13 + var_440_6 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_13 + var_440_6
					end
				end

				arg_437_1.text_.text = var_440_10
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)
				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_14 = math.max(var_440_7, arg_437_1.talkMaxDuration)

			if var_440_6 <= arg_437_1.time_ and arg_437_1.time_ < var_440_6 + var_440_14 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_6) / var_440_14

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_6 + var_440_14 and arg_437_1.time_ < var_440_6 + var_440_14 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {}

		arg_437_1:InitPlayNodeList()
	end,
	Play111041106 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 111041106
		arg_441_1.duration_ = 2

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play111041107(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			local var_444_0 = 0

			if var_444_0 < arg_441_1.time_ and arg_441_1.time_ <= var_444_0 + arg_444_0 then
				arg_441_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094actionlink/1094action425")
			end

			local var_444_1 = 0

			if var_444_1 < arg_441_1.time_ and arg_441_1.time_ <= var_444_1 + arg_444_0 then
				arg_441_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_444_2 = arg_441_1.actors_["1094ui_story"]
			local var_444_3 = 0

			if var_444_3 < arg_441_1.time_ and arg_441_1.time_ <= var_444_3 + arg_444_0 and not isNil(var_444_2) and arg_441_1.var_.characterEffect1094ui_story == nil then
				arg_441_1.var_.characterEffect1094ui_story = var_444_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_444_4 = 0.2

			if var_444_3 <= arg_441_1.time_ and arg_441_1.time_ < var_444_3 + var_444_4 and not isNil(var_444_2) then
				local var_444_5 = (arg_441_1.time_ - var_444_3) / var_444_4

				if arg_441_1.var_.characterEffect1094ui_story and not isNil(var_444_2) then
					arg_441_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_441_1.time_ >= var_444_3 + var_444_4 and arg_441_1.time_ < var_444_3 + var_444_4 + arg_444_0 and not isNil(var_444_2) and arg_441_1.var_.characterEffect1094ui_story then
				arg_441_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_444_6 = 0
			local var_444_7 = 0.333333333333333

			if var_444_6 < arg_441_1.time_ and arg_441_1.time_ <= var_444_6 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, true)

				local var_444_8 = arg_441_1:FormatText(StoryNameCfg[181].name)

				arg_441_1.leftNameTxt_.text = var_444_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_441_1.leftNameTxt_.transform)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1.leftNameTxt_.text)
				SetActive(arg_441_1.iconTrs_.gameObject, false)
				arg_441_1.callingController_:SetSelectedState("normal")

				local var_444_9 = arg_441_1:GetWordFromCfg(111041106)
				local var_444_10 = arg_441_1:FormatText(var_444_9.content)

				arg_441_1.text_.text = var_444_10

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_11 = 2
				local var_444_12 = utf8.len(var_444_10)
				local var_444_13 = var_444_11 <= 0 and var_444_7 or var_444_7 * (var_444_12 / var_444_11)

				if var_444_13 > 0 and var_444_7 < var_444_13 then
					arg_441_1.talkMaxDuration = var_444_13

					if var_444_13 + var_444_6 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_13 + var_444_6
					end
				end

				arg_441_1.text_.text = var_444_10
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111041", "111041106", "story_v_out_111041.awb") ~= 0 then
					local var_444_14 = manager.audio:GetVoiceLength("story_v_out_111041", "111041106", "story_v_out_111041.awb") / 1000

					if var_444_14 + var_444_6 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_14 + var_444_6
					end

					if var_444_9.prefab_name ~= "" and arg_441_1.actors_[var_444_9.prefab_name] ~= nil then
						local var_444_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_441_1.actors_[var_444_9.prefab_name].transform, "story_v_out_111041", "111041106", "story_v_out_111041.awb")

						arg_441_1:RecordAudio("111041106", var_444_15)
						arg_441_1:RecordAudio("111041106", var_444_15)
					else
						arg_441_1:AudioAction("play", "voice", "story_v_out_111041", "111041106", "story_v_out_111041.awb")
					end

					arg_441_1:RecordHistoryTalkVoice("story_v_out_111041", "111041106", "story_v_out_111041.awb")
				end

				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_16 = math.max(var_444_7, arg_441_1.talkMaxDuration)

			if var_444_6 <= arg_441_1.time_ and arg_441_1.time_ < var_444_6 + var_444_16 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - var_444_6) / var_444_16

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= var_444_6 + var_444_16 and arg_441_1.time_ < var_444_6 + var_444_16 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {}

		arg_441_1:InitPlayNodeList()
	end,
	Play111041107 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 111041107
		arg_445_1.duration_ = 6.57

		local var_445_0 = {
			ja = 1.999999999999,
			ko = 5.2,
			zh = 6.566,
			en = 5.133
		}
		local var_445_1 = manager.audio:GetLocalizationFlag()

		if var_445_0[var_445_1] ~= nil then
			arg_445_1.duration_ = var_445_0[var_445_1]
		end

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play111041108(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			local var_448_0 = 0

			if var_448_0 < arg_445_1.time_ and arg_445_1.time_ <= var_448_0 + arg_448_0 then
				arg_445_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_448_1 = arg_445_1.actors_["1094ui_story"]
			local var_448_2 = 0

			if var_448_2 < arg_445_1.time_ and arg_445_1.time_ <= var_448_2 + arg_448_0 and not isNil(var_448_1) and arg_445_1.var_.characterEffect1094ui_story == nil then
				arg_445_1.var_.characterEffect1094ui_story = var_448_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_448_3 = 0.2

			if var_448_2 <= arg_445_1.time_ and arg_445_1.time_ < var_448_2 + var_448_3 and not isNil(var_448_1) then
				local var_448_4 = (arg_445_1.time_ - var_448_2) / var_448_3

				if arg_445_1.var_.characterEffect1094ui_story and not isNil(var_448_1) then
					arg_445_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_445_1.time_ >= var_448_2 + var_448_3 and arg_445_1.time_ < var_448_2 + var_448_3 + arg_448_0 and not isNil(var_448_1) and arg_445_1.var_.characterEffect1094ui_story then
				arg_445_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_448_5 = 0
			local var_448_6 = 0.425

			if var_448_5 < arg_445_1.time_ and arg_445_1.time_ <= var_448_5 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, true)

				local var_448_7 = arg_445_1:FormatText(StoryNameCfg[181].name)

				arg_445_1.leftNameTxt_.text = var_448_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_445_1.leftNameTxt_.transform)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1.leftNameTxt_.text)
				SetActive(arg_445_1.iconTrs_.gameObject, false)
				arg_445_1.callingController_:SetSelectedState("normal")

				local var_448_8 = arg_445_1:GetWordFromCfg(111041107)
				local var_448_9 = arg_445_1:FormatText(var_448_8.content)

				arg_445_1.text_.text = var_448_9

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_10 = 17
				local var_448_11 = utf8.len(var_448_9)
				local var_448_12 = var_448_10 <= 0 and var_448_6 or var_448_6 * (var_448_11 / var_448_10)

				if var_448_12 > 0 and var_448_6 < var_448_12 then
					arg_445_1.talkMaxDuration = var_448_12

					if var_448_12 + var_448_5 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_12 + var_448_5
					end
				end

				arg_445_1.text_.text = var_448_9
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111041", "111041107", "story_v_out_111041.awb") ~= 0 then
					local var_448_13 = manager.audio:GetVoiceLength("story_v_out_111041", "111041107", "story_v_out_111041.awb") / 1000

					if var_448_13 + var_448_5 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_13 + var_448_5
					end

					if var_448_8.prefab_name ~= "" and arg_445_1.actors_[var_448_8.prefab_name] ~= nil then
						local var_448_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_445_1.actors_[var_448_8.prefab_name].transform, "story_v_out_111041", "111041107", "story_v_out_111041.awb")

						arg_445_1:RecordAudio("111041107", var_448_14)
						arg_445_1:RecordAudio("111041107", var_448_14)
					else
						arg_445_1:AudioAction("play", "voice", "story_v_out_111041", "111041107", "story_v_out_111041.awb")
					end

					arg_445_1:RecordHistoryTalkVoice("story_v_out_111041", "111041107", "story_v_out_111041.awb")
				end

				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_15 = math.max(var_448_6, arg_445_1.talkMaxDuration)

			if var_448_5 <= arg_445_1.time_ and arg_445_1.time_ < var_448_5 + var_448_15 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - var_448_5) / var_448_15

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= var_448_5 + var_448_15 and arg_445_1.time_ < var_448_5 + var_448_15 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {}

		arg_445_1:InitPlayNodeList()
	end,
	Play111041108 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 111041108
		arg_449_1.duration_ = 5

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play111041109(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			local var_452_0 = arg_449_1.actors_["1094ui_story"]
			local var_452_1 = 0

			if var_452_1 < arg_449_1.time_ and arg_449_1.time_ <= var_452_1 + arg_452_0 and not isNil(var_452_0) and arg_449_1.var_.characterEffect1094ui_story == nil then
				arg_449_1.var_.characterEffect1094ui_story = var_452_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_452_2 = 0.2

			if var_452_1 <= arg_449_1.time_ and arg_449_1.time_ < var_452_1 + var_452_2 and not isNil(var_452_0) then
				local var_452_3 = (arg_449_1.time_ - var_452_1) / var_452_2

				if arg_449_1.var_.characterEffect1094ui_story and not isNil(var_452_0) then
					local var_452_4 = Mathf.Lerp(0, 0.5, var_452_3)

					arg_449_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_449_1.var_.characterEffect1094ui_story.fillRatio = var_452_4
				end
			end

			if arg_449_1.time_ >= var_452_1 + var_452_2 and arg_449_1.time_ < var_452_1 + var_452_2 + arg_452_0 and not isNil(var_452_0) and arg_449_1.var_.characterEffect1094ui_story then
				local var_452_5 = 0.5

				arg_449_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_449_1.var_.characterEffect1094ui_story.fillRatio = var_452_5
			end

			local var_452_6 = 0
			local var_452_7 = 0.175

			if var_452_6 < arg_449_1.time_ and arg_449_1.time_ <= var_452_6 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				local var_452_8 = arg_449_1:FormatText(StoryNameCfg[7].name)

				arg_449_1.leftNameTxt_.text = var_452_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, true)
				arg_449_1.iconController_:SetSelectedState("hero")

				arg_449_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_449_1.callingController_:SetSelectedState("normal")

				arg_449_1.keyicon_.color = Color.New(1, 1, 1)
				arg_449_1.icon_.color = Color.New(1, 1, 1)

				local var_452_9 = arg_449_1:GetWordFromCfg(111041108)
				local var_452_10 = arg_449_1:FormatText(var_452_9.content)

				arg_449_1.text_.text = var_452_10

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_11 = 7
				local var_452_12 = utf8.len(var_452_10)
				local var_452_13 = var_452_11 <= 0 and var_452_7 or var_452_7 * (var_452_12 / var_452_11)

				if var_452_13 > 0 and var_452_7 < var_452_13 then
					arg_449_1.talkMaxDuration = var_452_13

					if var_452_13 + var_452_6 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_13 + var_452_6
					end
				end

				arg_449_1.text_.text = var_452_10
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)
				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_14 = math.max(var_452_7, arg_449_1.talkMaxDuration)

			if var_452_6 <= arg_449_1.time_ and arg_449_1.time_ < var_452_6 + var_452_14 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - var_452_6) / var_452_14

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= var_452_6 + var_452_14 and arg_449_1.time_ < var_452_6 + var_452_14 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {}

		arg_449_1:InitPlayNodeList()
	end,
	Play111041109 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 111041109
		arg_453_1.duration_ = 4

		local var_453_0 = {
			ja = 4,
			ko = 2.366,
			zh = 2.2,
			en = 2.3
		}
		local var_453_1 = manager.audio:GetLocalizationFlag()

		if var_453_0[var_453_1] ~= nil then
			arg_453_1.duration_ = var_453_0[var_453_1]
		end

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play111041110(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			local var_456_0 = 0

			if var_456_0 < arg_453_1.time_ and arg_453_1.time_ <= var_456_0 + arg_456_0 then
				arg_453_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_456_1 = arg_453_1.actors_["1094ui_story"]
			local var_456_2 = 0

			if var_456_2 < arg_453_1.time_ and arg_453_1.time_ <= var_456_2 + arg_456_0 and not isNil(var_456_1) and arg_453_1.var_.characterEffect1094ui_story == nil then
				arg_453_1.var_.characterEffect1094ui_story = var_456_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_456_3 = 0.2

			if var_456_2 <= arg_453_1.time_ and arg_453_1.time_ < var_456_2 + var_456_3 and not isNil(var_456_1) then
				local var_456_4 = (arg_453_1.time_ - var_456_2) / var_456_3

				if arg_453_1.var_.characterEffect1094ui_story and not isNil(var_456_1) then
					arg_453_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_453_1.time_ >= var_456_2 + var_456_3 and arg_453_1.time_ < var_456_2 + var_456_3 + arg_456_0 and not isNil(var_456_1) and arg_453_1.var_.characterEffect1094ui_story then
				arg_453_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_456_5 = 0
			local var_456_6 = 0.275

			if var_456_5 < arg_453_1.time_ and arg_453_1.time_ <= var_456_5 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, true)

				local var_456_7 = arg_453_1:FormatText(StoryNameCfg[181].name)

				arg_453_1.leftNameTxt_.text = var_456_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_453_1.leftNameTxt_.transform)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1.leftNameTxt_.text)
				SetActive(arg_453_1.iconTrs_.gameObject, false)
				arg_453_1.callingController_:SetSelectedState("normal")

				local var_456_8 = arg_453_1:GetWordFromCfg(111041109)
				local var_456_9 = arg_453_1:FormatText(var_456_8.content)

				arg_453_1.text_.text = var_456_9

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_10 = 11
				local var_456_11 = utf8.len(var_456_9)
				local var_456_12 = var_456_10 <= 0 and var_456_6 or var_456_6 * (var_456_11 / var_456_10)

				if var_456_12 > 0 and var_456_6 < var_456_12 then
					arg_453_1.talkMaxDuration = var_456_12

					if var_456_12 + var_456_5 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_12 + var_456_5
					end
				end

				arg_453_1.text_.text = var_456_9
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111041", "111041109", "story_v_out_111041.awb") ~= 0 then
					local var_456_13 = manager.audio:GetVoiceLength("story_v_out_111041", "111041109", "story_v_out_111041.awb") / 1000

					if var_456_13 + var_456_5 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_13 + var_456_5
					end

					if var_456_8.prefab_name ~= "" and arg_453_1.actors_[var_456_8.prefab_name] ~= nil then
						local var_456_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_453_1.actors_[var_456_8.prefab_name].transform, "story_v_out_111041", "111041109", "story_v_out_111041.awb")

						arg_453_1:RecordAudio("111041109", var_456_14)
						arg_453_1:RecordAudio("111041109", var_456_14)
					else
						arg_453_1:AudioAction("play", "voice", "story_v_out_111041", "111041109", "story_v_out_111041.awb")
					end

					arg_453_1:RecordHistoryTalkVoice("story_v_out_111041", "111041109", "story_v_out_111041.awb")
				end

				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_15 = math.max(var_456_6, arg_453_1.talkMaxDuration)

			if var_456_5 <= arg_453_1.time_ and arg_453_1.time_ < var_456_5 + var_456_15 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_5) / var_456_15

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_5 + var_456_15 and arg_453_1.time_ < var_456_5 + var_456_15 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {}

		arg_453_1:InitPlayNodeList()
	end,
	Play111041110 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 111041110
		arg_457_1.duration_ = 5

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play111041111(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			local var_460_0 = arg_457_1.actors_["1094ui_story"]
			local var_460_1 = 0

			if var_460_1 < arg_457_1.time_ and arg_457_1.time_ <= var_460_1 + arg_460_0 and not isNil(var_460_0) and arg_457_1.var_.characterEffect1094ui_story == nil then
				arg_457_1.var_.characterEffect1094ui_story = var_460_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_460_2 = 0.2

			if var_460_1 <= arg_457_1.time_ and arg_457_1.time_ < var_460_1 + var_460_2 and not isNil(var_460_0) then
				local var_460_3 = (arg_457_1.time_ - var_460_1) / var_460_2

				if arg_457_1.var_.characterEffect1094ui_story and not isNil(var_460_0) then
					local var_460_4 = Mathf.Lerp(0, 0.5, var_460_3)

					arg_457_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_457_1.var_.characterEffect1094ui_story.fillRatio = var_460_4
				end
			end

			if arg_457_1.time_ >= var_460_1 + var_460_2 and arg_457_1.time_ < var_460_1 + var_460_2 + arg_460_0 and not isNil(var_460_0) and arg_457_1.var_.characterEffect1094ui_story then
				local var_460_5 = 0.5

				arg_457_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_457_1.var_.characterEffect1094ui_story.fillRatio = var_460_5
			end

			local var_460_6 = 0
			local var_460_7 = 0.325

			if var_460_6 < arg_457_1.time_ and arg_457_1.time_ <= var_460_6 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, true)

				local var_460_8 = arg_457_1:FormatText(StoryNameCfg[7].name)

				arg_457_1.leftNameTxt_.text = var_460_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_457_1.leftNameTxt_.transform)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1.leftNameTxt_.text)
				SetActive(arg_457_1.iconTrs_.gameObject, true)
				arg_457_1.iconController_:SetSelectedState("hero")

				arg_457_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_457_1.callingController_:SetSelectedState("normal")

				arg_457_1.keyicon_.color = Color.New(1, 1, 1)
				arg_457_1.icon_.color = Color.New(1, 1, 1)

				local var_460_9 = arg_457_1:GetWordFromCfg(111041110)
				local var_460_10 = arg_457_1:FormatText(var_460_9.content)

				arg_457_1.text_.text = var_460_10

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_11 = 13
				local var_460_12 = utf8.len(var_460_10)
				local var_460_13 = var_460_11 <= 0 and var_460_7 or var_460_7 * (var_460_12 / var_460_11)

				if var_460_13 > 0 and var_460_7 < var_460_13 then
					arg_457_1.talkMaxDuration = var_460_13

					if var_460_13 + var_460_6 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_13 + var_460_6
					end
				end

				arg_457_1.text_.text = var_460_10
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)
				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_14 = math.max(var_460_7, arg_457_1.talkMaxDuration)

			if var_460_6 <= arg_457_1.time_ and arg_457_1.time_ < var_460_6 + var_460_14 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - var_460_6) / var_460_14

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= var_460_6 + var_460_14 and arg_457_1.time_ < var_460_6 + var_460_14 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {}

		arg_457_1:InitPlayNodeList()
	end,
	Play111041111 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 111041111
		arg_461_1.duration_ = 7.83

		local var_461_0 = {
			ja = 6.533,
			ko = 6.266,
			zh = 7.766,
			en = 7.833
		}
		local var_461_1 = manager.audio:GetLocalizationFlag()

		if var_461_0[var_461_1] ~= nil then
			arg_461_1.duration_ = var_461_0[var_461_1]
		end

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play111041112(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			local var_464_0 = 0

			if var_464_0 < arg_461_1.time_ and arg_461_1.time_ <= var_464_0 + arg_464_0 then
				arg_461_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action5_2")
			end

			local var_464_1 = 0

			if var_464_1 < arg_461_1.time_ and arg_461_1.time_ <= var_464_1 + arg_464_0 then
				arg_461_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1304cva")
			end

			local var_464_2 = arg_461_1.actors_["1094ui_story"]
			local var_464_3 = 0

			if var_464_3 < arg_461_1.time_ and arg_461_1.time_ <= var_464_3 + arg_464_0 and not isNil(var_464_2) and arg_461_1.var_.characterEffect1094ui_story == nil then
				arg_461_1.var_.characterEffect1094ui_story = var_464_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_464_4 = 0.2

			if var_464_3 <= arg_461_1.time_ and arg_461_1.time_ < var_464_3 + var_464_4 and not isNil(var_464_2) then
				local var_464_5 = (arg_461_1.time_ - var_464_3) / var_464_4

				if arg_461_1.var_.characterEffect1094ui_story and not isNil(var_464_2) then
					arg_461_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_461_1.time_ >= var_464_3 + var_464_4 and arg_461_1.time_ < var_464_3 + var_464_4 + arg_464_0 and not isNil(var_464_2) and arg_461_1.var_.characterEffect1094ui_story then
				arg_461_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_464_6 = 0
			local var_464_7 = 0.65

			if var_464_6 < arg_461_1.time_ and arg_461_1.time_ <= var_464_6 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, true)

				local var_464_8 = arg_461_1:FormatText(StoryNameCfg[181].name)

				arg_461_1.leftNameTxt_.text = var_464_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_461_1.leftNameTxt_.transform)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1.leftNameTxt_.text)
				SetActive(arg_461_1.iconTrs_.gameObject, false)
				arg_461_1.callingController_:SetSelectedState("normal")

				local var_464_9 = arg_461_1:GetWordFromCfg(111041111)
				local var_464_10 = arg_461_1:FormatText(var_464_9.content)

				arg_461_1.text_.text = var_464_10

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_11 = 28
				local var_464_12 = utf8.len(var_464_10)
				local var_464_13 = var_464_11 <= 0 and var_464_7 or var_464_7 * (var_464_12 / var_464_11)

				if var_464_13 > 0 and var_464_7 < var_464_13 then
					arg_461_1.talkMaxDuration = var_464_13

					if var_464_13 + var_464_6 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_13 + var_464_6
					end
				end

				arg_461_1.text_.text = var_464_10
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111041", "111041111", "story_v_out_111041.awb") ~= 0 then
					local var_464_14 = manager.audio:GetVoiceLength("story_v_out_111041", "111041111", "story_v_out_111041.awb") / 1000

					if var_464_14 + var_464_6 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_14 + var_464_6
					end

					if var_464_9.prefab_name ~= "" and arg_461_1.actors_[var_464_9.prefab_name] ~= nil then
						local var_464_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_461_1.actors_[var_464_9.prefab_name].transform, "story_v_out_111041", "111041111", "story_v_out_111041.awb")

						arg_461_1:RecordAudio("111041111", var_464_15)
						arg_461_1:RecordAudio("111041111", var_464_15)
					else
						arg_461_1:AudioAction("play", "voice", "story_v_out_111041", "111041111", "story_v_out_111041.awb")
					end

					arg_461_1:RecordHistoryTalkVoice("story_v_out_111041", "111041111", "story_v_out_111041.awb")
				end

				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_16 = math.max(var_464_7, arg_461_1.talkMaxDuration)

			if var_464_6 <= arg_461_1.time_ and arg_461_1.time_ < var_464_6 + var_464_16 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_6) / var_464_16

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_6 + var_464_16 and arg_461_1.time_ < var_464_6 + var_464_16 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {}

		arg_461_1:InitPlayNodeList()
	end,
	Play111041112 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 111041112
		arg_465_1.duration_ = 5

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play111041113(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			local var_468_0 = arg_465_1.actors_["1094ui_story"]
			local var_468_1 = 0

			if var_468_1 < arg_465_1.time_ and arg_465_1.time_ <= var_468_1 + arg_468_0 and not isNil(var_468_0) and arg_465_1.var_.characterEffect1094ui_story == nil then
				arg_465_1.var_.characterEffect1094ui_story = var_468_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_468_2 = 0.2

			if var_468_1 <= arg_465_1.time_ and arg_465_1.time_ < var_468_1 + var_468_2 and not isNil(var_468_0) then
				local var_468_3 = (arg_465_1.time_ - var_468_1) / var_468_2

				if arg_465_1.var_.characterEffect1094ui_story and not isNil(var_468_0) then
					local var_468_4 = Mathf.Lerp(0, 0.5, var_468_3)

					arg_465_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_465_1.var_.characterEffect1094ui_story.fillRatio = var_468_4
				end
			end

			if arg_465_1.time_ >= var_468_1 + var_468_2 and arg_465_1.time_ < var_468_1 + var_468_2 + arg_468_0 and not isNil(var_468_0) and arg_465_1.var_.characterEffect1094ui_story then
				local var_468_5 = 0.5

				arg_465_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_465_1.var_.characterEffect1094ui_story.fillRatio = var_468_5
			end

			local var_468_6 = 0
			local var_468_7 = 1.275

			if var_468_6 < arg_465_1.time_ and arg_465_1.time_ <= var_468_6 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, false)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_465_1.iconTrs_.gameObject, false)
				arg_465_1.callingController_:SetSelectedState("normal")

				local var_468_8 = arg_465_1:GetWordFromCfg(111041112)
				local var_468_9 = arg_465_1:FormatText(var_468_8.content)

				arg_465_1.text_.text = var_468_9

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_10 = 51
				local var_468_11 = utf8.len(var_468_9)
				local var_468_12 = var_468_10 <= 0 and var_468_7 or var_468_7 * (var_468_11 / var_468_10)

				if var_468_12 > 0 and var_468_7 < var_468_12 then
					arg_465_1.talkMaxDuration = var_468_12

					if var_468_12 + var_468_6 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_12 + var_468_6
					end
				end

				arg_465_1.text_.text = var_468_9
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)
				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_13 = math.max(var_468_7, arg_465_1.talkMaxDuration)

			if var_468_6 <= arg_465_1.time_ and arg_465_1.time_ < var_468_6 + var_468_13 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_6) / var_468_13

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_6 + var_468_13 and arg_465_1.time_ < var_468_6 + var_468_13 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {}

		arg_465_1:InitPlayNodeList()
	end,
	Play111041113 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 111041113
		arg_469_1.duration_ = 5

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play111041114(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			local var_472_0 = 0
			local var_472_1 = 0.55

			if var_472_0 < arg_469_1.time_ and arg_469_1.time_ <= var_472_0 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, true)

				local var_472_2 = arg_469_1:FormatText(StoryNameCfg[7].name)

				arg_469_1.leftNameTxt_.text = var_472_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_469_1.leftNameTxt_.transform)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1.leftNameTxt_.text)
				SetActive(arg_469_1.iconTrs_.gameObject, true)
				arg_469_1.iconController_:SetSelectedState("hero")

				arg_469_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_469_1.callingController_:SetSelectedState("normal")

				arg_469_1.keyicon_.color = Color.New(1, 1, 1)
				arg_469_1.icon_.color = Color.New(1, 1, 1)

				local var_472_3 = arg_469_1:GetWordFromCfg(111041113)
				local var_472_4 = arg_469_1:FormatText(var_472_3.content)

				arg_469_1.text_.text = var_472_4

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_5 = 22
				local var_472_6 = utf8.len(var_472_4)
				local var_472_7 = var_472_5 <= 0 and var_472_1 or var_472_1 * (var_472_6 / var_472_5)

				if var_472_7 > 0 and var_472_1 < var_472_7 then
					arg_469_1.talkMaxDuration = var_472_7

					if var_472_7 + var_472_0 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_7 + var_472_0
					end
				end

				arg_469_1.text_.text = var_472_4
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)
				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_8 = math.max(var_472_1, arg_469_1.talkMaxDuration)

			if var_472_0 <= arg_469_1.time_ and arg_469_1.time_ < var_472_0 + var_472_8 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_0) / var_472_8

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_0 + var_472_8 and arg_469_1.time_ < var_472_0 + var_472_8 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {}

		arg_469_1:InitPlayNodeList()
	end,
	Play111041114 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 111041114
		arg_473_1.duration_ = 2.93

		local var_473_0 = {
			ja = 1.133,
			ko = 1.3,
			zh = 2.933,
			en = 1.933
		}
		local var_473_1 = manager.audio:GetLocalizationFlag()

		if var_473_0[var_473_1] ~= nil then
			arg_473_1.duration_ = var_473_0[var_473_1]
		end

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play111041115(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			local var_476_0 = 0

			if var_476_0 < arg_473_1.time_ and arg_473_1.time_ <= var_476_0 + arg_476_0 then
				arg_473_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_476_1 = arg_473_1.actors_["1094ui_story"]
			local var_476_2 = 0

			if var_476_2 < arg_473_1.time_ and arg_473_1.time_ <= var_476_2 + arg_476_0 and not isNil(var_476_1) and arg_473_1.var_.characterEffect1094ui_story == nil then
				arg_473_1.var_.characterEffect1094ui_story = var_476_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_476_3 = 0.2

			if var_476_2 <= arg_473_1.time_ and arg_473_1.time_ < var_476_2 + var_476_3 and not isNil(var_476_1) then
				local var_476_4 = (arg_473_1.time_ - var_476_2) / var_476_3

				if arg_473_1.var_.characterEffect1094ui_story and not isNil(var_476_1) then
					arg_473_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_473_1.time_ >= var_476_2 + var_476_3 and arg_473_1.time_ < var_476_2 + var_476_3 + arg_476_0 and not isNil(var_476_1) and arg_473_1.var_.characterEffect1094ui_story then
				arg_473_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_476_5 = 0
			local var_476_6 = 0.15

			if var_476_5 < arg_473_1.time_ and arg_473_1.time_ <= var_476_5 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				local var_476_7 = arg_473_1:FormatText(StoryNameCfg[181].name)

				arg_473_1.leftNameTxt_.text = var_476_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, false)
				arg_473_1.callingController_:SetSelectedState("normal")

				local var_476_8 = arg_473_1:GetWordFromCfg(111041114)
				local var_476_9 = arg_473_1:FormatText(var_476_8.content)

				arg_473_1.text_.text = var_476_9

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_10 = 6
				local var_476_11 = utf8.len(var_476_9)
				local var_476_12 = var_476_10 <= 0 and var_476_6 or var_476_6 * (var_476_11 / var_476_10)

				if var_476_12 > 0 and var_476_6 < var_476_12 then
					arg_473_1.talkMaxDuration = var_476_12

					if var_476_12 + var_476_5 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_12 + var_476_5
					end
				end

				arg_473_1.text_.text = var_476_9
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111041", "111041114", "story_v_out_111041.awb") ~= 0 then
					local var_476_13 = manager.audio:GetVoiceLength("story_v_out_111041", "111041114", "story_v_out_111041.awb") / 1000

					if var_476_13 + var_476_5 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_13 + var_476_5
					end

					if var_476_8.prefab_name ~= "" and arg_473_1.actors_[var_476_8.prefab_name] ~= nil then
						local var_476_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_473_1.actors_[var_476_8.prefab_name].transform, "story_v_out_111041", "111041114", "story_v_out_111041.awb")

						arg_473_1:RecordAudio("111041114", var_476_14)
						arg_473_1:RecordAudio("111041114", var_476_14)
					else
						arg_473_1:AudioAction("play", "voice", "story_v_out_111041", "111041114", "story_v_out_111041.awb")
					end

					arg_473_1:RecordHistoryTalkVoice("story_v_out_111041", "111041114", "story_v_out_111041.awb")
				end

				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_15 = math.max(var_476_6, arg_473_1.talkMaxDuration)

			if var_476_5 <= arg_473_1.time_ and arg_473_1.time_ < var_476_5 + var_476_15 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_5) / var_476_15

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_5 + var_476_15 and arg_473_1.time_ < var_476_5 + var_476_15 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {}

		arg_473_1:InitPlayNodeList()
	end,
	Play111041115 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 111041115
		arg_477_1.duration_ = 5

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play111041116(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			local var_480_0 = arg_477_1.actors_["1094ui_story"]
			local var_480_1 = 0

			if var_480_1 < arg_477_1.time_ and arg_477_1.time_ <= var_480_1 + arg_480_0 and not isNil(var_480_0) and arg_477_1.var_.characterEffect1094ui_story == nil then
				arg_477_1.var_.characterEffect1094ui_story = var_480_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_480_2 = 0.2

			if var_480_1 <= arg_477_1.time_ and arg_477_1.time_ < var_480_1 + var_480_2 and not isNil(var_480_0) then
				local var_480_3 = (arg_477_1.time_ - var_480_1) / var_480_2

				if arg_477_1.var_.characterEffect1094ui_story and not isNil(var_480_0) then
					local var_480_4 = Mathf.Lerp(0, 0.5, var_480_3)

					arg_477_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_477_1.var_.characterEffect1094ui_story.fillRatio = var_480_4
				end
			end

			if arg_477_1.time_ >= var_480_1 + var_480_2 and arg_477_1.time_ < var_480_1 + var_480_2 + arg_480_0 and not isNil(var_480_0) and arg_477_1.var_.characterEffect1094ui_story then
				local var_480_5 = 0.5

				arg_477_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_477_1.var_.characterEffect1094ui_story.fillRatio = var_480_5
			end

			local var_480_6 = 0
			local var_480_7 = 0.675

			if var_480_6 < arg_477_1.time_ and arg_477_1.time_ <= var_480_6 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, true)

				local var_480_8 = arg_477_1:FormatText(StoryNameCfg[7].name)

				arg_477_1.leftNameTxt_.text = var_480_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, true)
				arg_477_1.iconController_:SetSelectedState("hero")

				arg_477_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_477_1.callingController_:SetSelectedState("normal")

				arg_477_1.keyicon_.color = Color.New(1, 1, 1)
				arg_477_1.icon_.color = Color.New(1, 1, 1)

				local var_480_9 = arg_477_1:GetWordFromCfg(111041115)
				local var_480_10 = arg_477_1:FormatText(var_480_9.content)

				arg_477_1.text_.text = var_480_10

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_11 = 27
				local var_480_12 = utf8.len(var_480_10)
				local var_480_13 = var_480_11 <= 0 and var_480_7 or var_480_7 * (var_480_12 / var_480_11)

				if var_480_13 > 0 and var_480_7 < var_480_13 then
					arg_477_1.talkMaxDuration = var_480_13

					if var_480_13 + var_480_6 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_13 + var_480_6
					end
				end

				arg_477_1.text_.text = var_480_10
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)
				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_14 = math.max(var_480_7, arg_477_1.talkMaxDuration)

			if var_480_6 <= arg_477_1.time_ and arg_477_1.time_ < var_480_6 + var_480_14 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_6) / var_480_14

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_6 + var_480_14 and arg_477_1.time_ < var_480_6 + var_480_14 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {}

		arg_477_1:InitPlayNodeList()
	end,
	Play111041116 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 111041116
		arg_481_1.duration_ = 5

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play111041117(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			local var_484_0 = "1066ui_story"

			if arg_481_1.actors_[var_484_0] == nil then
				local var_484_1 = Asset.Load("Char/" .. "1066ui_story")

				if not isNil(var_484_1) then
					local var_484_2 = Object.Instantiate(Asset.Load("Char/" .. "1066ui_story"), arg_481_1.stage_.transform)

					var_484_2.name = var_484_0
					var_484_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_481_1.actors_[var_484_0] = var_484_2

					local var_484_3 = var_484_2:GetComponentInChildren(typeof(CharacterEffect))

					var_484_3.enabled = true

					local var_484_4 = GameObjectTools.GetOrAddComponent(var_484_2, typeof(DynamicBoneHelper))

					if var_484_4 then
						var_484_4:EnableDynamicBone(false)
					end

					arg_481_1:ShowWeapon(var_484_3.transform, false)

					arg_481_1.var_[var_484_0 .. "Animator"] = var_484_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_481_1.var_[var_484_0 .. "Animator"].applyRootMotion = true
					arg_481_1.var_[var_484_0 .. "LipSync"] = var_484_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_484_5 = arg_481_1.actors_["1066ui_story"].transform
			local var_484_6 = 0

			if var_484_6 < arg_481_1.time_ and arg_481_1.time_ <= var_484_6 + arg_484_0 then
				arg_481_1.var_.moveOldPos1066ui_story = var_484_5.localPosition
			end

			local var_484_7 = 0.001

			if var_484_6 <= arg_481_1.time_ and arg_481_1.time_ < var_484_6 + var_484_7 then
				local var_484_8 = (arg_481_1.time_ - var_484_6) / var_484_7
				local var_484_9 = Vector3.New(0, 100, 0)

				var_484_5.localPosition = Vector3.Lerp(arg_481_1.var_.moveOldPos1066ui_story, var_484_9, var_484_8)

				local var_484_10 = manager.ui.mainCamera.transform.position - var_484_5.position

				var_484_5.forward = Vector3.New(var_484_10.x, var_484_10.y, var_484_10.z)

				local var_484_11 = var_484_5.localEulerAngles

				var_484_11.z = 0
				var_484_11.x = 0
				var_484_5.localEulerAngles = var_484_11
			end

			if arg_481_1.time_ >= var_484_6 + var_484_7 and arg_481_1.time_ < var_484_6 + var_484_7 + arg_484_0 then
				var_484_5.localPosition = Vector3.New(0, 100, 0)

				local var_484_12 = manager.ui.mainCamera.transform.position - var_484_5.position

				var_484_5.forward = Vector3.New(var_484_12.x, var_484_12.y, var_484_12.z)

				local var_484_13 = var_484_5.localEulerAngles

				var_484_13.z = 0
				var_484_13.x = 0
				var_484_5.localEulerAngles = var_484_13
			end

			local var_484_14 = 0

			if var_484_14 < arg_481_1.time_ and arg_481_1.time_ <= var_484_14 + arg_484_0 then
				arg_481_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_484_15 = 0

			if var_484_15 < arg_481_1.time_ and arg_481_1.time_ <= var_484_15 + arg_484_0 then
				arg_481_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action4_1")
			end

			local var_484_16 = 0
			local var_484_17 = 0.525

			if var_484_16 < arg_481_1.time_ and arg_481_1.time_ <= var_484_16 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, true)

				local var_484_18 = arg_481_1:FormatText(StoryNameCfg[7].name)

				arg_481_1.leftNameTxt_.text = var_484_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_481_1.leftNameTxt_.transform)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1.leftNameTxt_.text)
				SetActive(arg_481_1.iconTrs_.gameObject, true)
				arg_481_1.iconController_:SetSelectedState("hero")

				arg_481_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_481_1.callingController_:SetSelectedState("normal")

				arg_481_1.keyicon_.color = Color.New(1, 1, 1)
				arg_481_1.icon_.color = Color.New(1, 1, 1)

				local var_484_19 = arg_481_1:GetWordFromCfg(111041116)
				local var_484_20 = arg_481_1:FormatText(var_484_19.content)

				arg_481_1.text_.text = var_484_20

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_21 = 21
				local var_484_22 = utf8.len(var_484_20)
				local var_484_23 = var_484_21 <= 0 and var_484_17 or var_484_17 * (var_484_22 / var_484_21)

				if var_484_23 > 0 and var_484_17 < var_484_23 then
					arg_481_1.talkMaxDuration = var_484_23

					if var_484_23 + var_484_16 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_23 + var_484_16
					end
				end

				arg_481_1.text_.text = var_484_20
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)
				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_24 = math.max(var_484_17, arg_481_1.talkMaxDuration)

			if var_484_16 <= arg_481_1.time_ and arg_481_1.time_ < var_484_16 + var_484_24 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - var_484_16) / var_484_24

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= var_484_16 + var_484_24 and arg_481_1.time_ < var_484_16 + var_484_24 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {
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

		arg_481_1:InitPlayNodeList()
	end,
	Play111041117 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 111041117
		arg_485_1.duration_ = 14.47

		local var_485_0 = {
			ja = 12.2326666666667,
			ko = 10.4666666666667,
			zh = 9.83266666666667,
			en = 14.4666666666667
		}
		local var_485_1 = manager.audio:GetLocalizationFlag()

		if var_485_0[var_485_1] ~= nil then
			arg_485_1.duration_ = var_485_0[var_485_1]
		end

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play111041118(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			local var_488_0 = "ST07a"

			if arg_485_1.bgs_[var_488_0] == nil then
				local var_488_1 = Object.Instantiate(arg_485_1.paintGo_)

				var_488_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_488_0)
				var_488_1.name = var_488_0
				var_488_1.transform.parent = arg_485_1.stage_.transform
				var_488_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_485_1.bgs_[var_488_0] = var_488_1
			end

			local var_488_2 = 0

			if var_488_2 < arg_485_1.time_ and arg_485_1.time_ <= var_488_2 + arg_488_0 then
				local var_488_3 = manager.ui.mainCamera.transform.localPosition
				local var_488_4 = Vector3.New(0, 0, 10) + Vector3.New(var_488_3.x, var_488_3.y, 0)
				local var_488_5 = arg_485_1.bgs_.ST07a

				var_488_5.transform.localPosition = var_488_4
				var_488_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_488_6 = var_488_5:GetComponent("SpriteRenderer")

				if var_488_6 and var_488_6.sprite then
					local var_488_7 = (var_488_5.transform.localPosition - var_488_3).z
					local var_488_8 = manager.ui.mainCameraCom_
					local var_488_9 = 2 * var_488_7 * Mathf.Tan(var_488_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_488_10 = var_488_9 * var_488_8.aspect
					local var_488_11 = var_488_6.sprite.bounds.size.x
					local var_488_12 = var_488_6.sprite.bounds.size.y
					local var_488_13 = var_488_10 / var_488_11
					local var_488_14 = var_488_9 / var_488_12
					local var_488_15 = var_488_14 < var_488_13 and var_488_13 or var_488_14

					var_488_5.transform.localScale = Vector3.New(var_488_15, var_488_15, 0)
				end

				for iter_488_0, iter_488_1 in pairs(arg_485_1.bgs_) do
					if iter_488_0 ~= "ST07a" then
						iter_488_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_488_16 = 0

			if var_488_16 < arg_485_1.time_ and arg_485_1.time_ <= var_488_16 + arg_488_0 then
				arg_485_1.mask_.enabled = true
				arg_485_1.mask_.raycastTarget = true

				arg_485_1:SetGaussion(false)
			end

			local var_488_17 = 1

			if var_488_16 <= arg_485_1.time_ and arg_485_1.time_ < var_488_16 + var_488_17 then
				local var_488_18 = (arg_485_1.time_ - var_488_16) / var_488_17
				local var_488_19 = Color.New(1, 1, 1)

				var_488_19.a = Mathf.Lerp(1, 0, var_488_18)
				arg_485_1.mask_.color = var_488_19
			end

			if arg_485_1.time_ >= var_488_16 + var_488_17 and arg_485_1.time_ < var_488_16 + var_488_17 + arg_488_0 then
				local var_488_20 = Color.New(1, 1, 1)
				local var_488_21 = 0

				arg_485_1.mask_.enabled = false
				var_488_20.a = var_488_21
				arg_485_1.mask_.color = var_488_20
			end

			local var_488_22 = "1019ui_story"

			if arg_485_1.actors_[var_488_22] == nil then
				local var_488_23 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_488_23) then
					local var_488_24 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_485_1.stage_.transform)

					var_488_24.name = var_488_22
					var_488_24.transform.localPosition = Vector3.New(0, 100, 0)
					arg_485_1.actors_[var_488_22] = var_488_24

					local var_488_25 = var_488_24:GetComponentInChildren(typeof(CharacterEffect))

					var_488_25.enabled = true

					local var_488_26 = GameObjectTools.GetOrAddComponent(var_488_24, typeof(DynamicBoneHelper))

					if var_488_26 then
						var_488_26:EnableDynamicBone(false)
					end

					arg_485_1:ShowWeapon(var_488_25.transform, false)

					arg_485_1.var_[var_488_22 .. "Animator"] = var_488_25.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_485_1.var_[var_488_22 .. "Animator"].applyRootMotion = true
					arg_485_1.var_[var_488_22 .. "LipSync"] = var_488_25.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_488_27 = 1

			if var_488_27 < arg_485_1.time_ and arg_485_1.time_ <= var_488_27 + arg_488_0 then
				arg_485_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			local var_488_28 = 1

			if var_488_28 < arg_485_1.time_ and arg_485_1.time_ <= var_488_28 + arg_488_0 then
				arg_485_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_488_29 = arg_485_1.actors_["1019ui_story"]
			local var_488_30 = 1

			if var_488_30 < arg_485_1.time_ and arg_485_1.time_ <= var_488_30 + arg_488_0 and not isNil(var_488_29) and arg_485_1.var_.characterEffect1019ui_story == nil then
				arg_485_1.var_.characterEffect1019ui_story = var_488_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_488_31 = 0.2

			if var_488_30 <= arg_485_1.time_ and arg_485_1.time_ < var_488_30 + var_488_31 and not isNil(var_488_29) then
				local var_488_32 = (arg_485_1.time_ - var_488_30) / var_488_31

				if arg_485_1.var_.characterEffect1019ui_story and not isNil(var_488_29) then
					arg_485_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_485_1.time_ >= var_488_30 + var_488_31 and arg_485_1.time_ < var_488_30 + var_488_31 + arg_488_0 and not isNil(var_488_29) and arg_485_1.var_.characterEffect1019ui_story then
				arg_485_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_488_33 = arg_485_1.actors_["1066ui_story"]
			local var_488_34 = 1

			if var_488_34 < arg_485_1.time_ and arg_485_1.time_ <= var_488_34 + arg_488_0 and not isNil(var_488_33) and arg_485_1.var_.characterEffect1066ui_story == nil then
				arg_485_1.var_.characterEffect1066ui_story = var_488_33:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_488_35 = 0.2

			if var_488_34 <= arg_485_1.time_ and arg_485_1.time_ < var_488_34 + var_488_35 and not isNil(var_488_33) then
				local var_488_36 = (arg_485_1.time_ - var_488_34) / var_488_35

				if arg_485_1.var_.characterEffect1066ui_story and not isNil(var_488_33) then
					local var_488_37 = Mathf.Lerp(0, 0.5, var_488_36)

					arg_485_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_485_1.var_.characterEffect1066ui_story.fillRatio = var_488_37
				end
			end

			if arg_485_1.time_ >= var_488_34 + var_488_35 and arg_485_1.time_ < var_488_34 + var_488_35 + arg_488_0 and not isNil(var_488_33) and arg_485_1.var_.characterEffect1066ui_story then
				local var_488_38 = 0.5

				arg_485_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_485_1.var_.characterEffect1066ui_story.fillRatio = var_488_38
			end

			local var_488_39 = arg_485_1.actors_["1094ui_story"].transform
			local var_488_40 = 0

			if var_488_40 < arg_485_1.time_ and arg_485_1.time_ <= var_488_40 + arg_488_0 then
				arg_485_1.var_.moveOldPos1094ui_story = var_488_39.localPosition
			end

			local var_488_41 = 0.001

			if var_488_40 <= arg_485_1.time_ and arg_485_1.time_ < var_488_40 + var_488_41 then
				local var_488_42 = (arg_485_1.time_ - var_488_40) / var_488_41
				local var_488_43 = Vector3.New(0, 100, 0)

				var_488_39.localPosition = Vector3.Lerp(arg_485_1.var_.moveOldPos1094ui_story, var_488_43, var_488_42)

				local var_488_44 = manager.ui.mainCamera.transform.position - var_488_39.position

				var_488_39.forward = Vector3.New(var_488_44.x, var_488_44.y, var_488_44.z)

				local var_488_45 = var_488_39.localEulerAngles

				var_488_45.z = 0
				var_488_45.x = 0
				var_488_39.localEulerAngles = var_488_45
			end

			if arg_485_1.time_ >= var_488_40 + var_488_41 and arg_485_1.time_ < var_488_40 + var_488_41 + arg_488_0 then
				var_488_39.localPosition = Vector3.New(0, 100, 0)

				local var_488_46 = manager.ui.mainCamera.transform.position - var_488_39.position

				var_488_39.forward = Vector3.New(var_488_46.x, var_488_46.y, var_488_46.z)

				local var_488_47 = var_488_39.localEulerAngles

				var_488_47.z = 0
				var_488_47.x = 0
				var_488_39.localEulerAngles = var_488_47
			end

			local var_488_48 = arg_485_1.actors_["1019ui_story"].transform
			local var_488_49 = 1

			if var_488_49 < arg_485_1.time_ and arg_485_1.time_ <= var_488_49 + arg_488_0 then
				arg_485_1.var_.moveOldPos1019ui_story = var_488_48.localPosition
			end

			local var_488_50 = 0.001

			if var_488_49 <= arg_485_1.time_ and arg_485_1.time_ < var_488_49 + var_488_50 then
				local var_488_51 = (arg_485_1.time_ - var_488_49) / var_488_50
				local var_488_52 = Vector3.New(0.7, -1.08, -5.9)

				var_488_48.localPosition = Vector3.Lerp(arg_485_1.var_.moveOldPos1019ui_story, var_488_52, var_488_51)

				local var_488_53 = manager.ui.mainCamera.transform.position - var_488_48.position

				var_488_48.forward = Vector3.New(var_488_53.x, var_488_53.y, var_488_53.z)

				local var_488_54 = var_488_48.localEulerAngles

				var_488_54.z = 0
				var_488_54.x = 0
				var_488_48.localEulerAngles = var_488_54
			end

			if arg_485_1.time_ >= var_488_49 + var_488_50 and arg_485_1.time_ < var_488_49 + var_488_50 + arg_488_0 then
				var_488_48.localPosition = Vector3.New(0.7, -1.08, -5.9)

				local var_488_55 = manager.ui.mainCamera.transform.position - var_488_48.position

				var_488_48.forward = Vector3.New(var_488_55.x, var_488_55.y, var_488_55.z)

				local var_488_56 = var_488_48.localEulerAngles

				var_488_56.z = 0
				var_488_56.x = 0
				var_488_48.localEulerAngles = var_488_56
			end

			local var_488_57 = arg_485_1.actors_["1066ui_story"].transform
			local var_488_58 = 1

			if var_488_58 < arg_485_1.time_ and arg_485_1.time_ <= var_488_58 + arg_488_0 then
				arg_485_1.var_.moveOldPos1066ui_story = var_488_57.localPosition
			end

			local var_488_59 = 0.001

			if var_488_58 <= arg_485_1.time_ and arg_485_1.time_ < var_488_58 + var_488_59 then
				local var_488_60 = (arg_485_1.time_ - var_488_58) / var_488_59
				local var_488_61 = Vector3.New(-0.7, -0.77, -6.1)

				var_488_57.localPosition = Vector3.Lerp(arg_485_1.var_.moveOldPos1066ui_story, var_488_61, var_488_60)

				local var_488_62 = manager.ui.mainCamera.transform.position - var_488_57.position

				var_488_57.forward = Vector3.New(var_488_62.x, var_488_62.y, var_488_62.z)

				local var_488_63 = var_488_57.localEulerAngles

				var_488_63.z = 0
				var_488_63.x = 0
				var_488_57.localEulerAngles = var_488_63
			end

			if arg_485_1.time_ >= var_488_58 + var_488_59 and arg_485_1.time_ < var_488_58 + var_488_59 + arg_488_0 then
				var_488_57.localPosition = Vector3.New(-0.7, -0.77, -6.1)

				local var_488_64 = manager.ui.mainCamera.transform.position - var_488_57.position

				var_488_57.forward = Vector3.New(var_488_64.x, var_488_64.y, var_488_64.z)

				local var_488_65 = var_488_57.localEulerAngles

				var_488_65.z = 0
				var_488_65.x = 0
				var_488_57.localEulerAngles = var_488_65
			end

			local var_488_66 = 0

			arg_485_1.isInRecall_ = false

			if var_488_66 < arg_485_1.time_ and arg_485_1.time_ <= var_488_66 + arg_488_0 then
				arg_485_1.screenFilterGo_:SetActive(true)

				arg_485_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_488_2, iter_488_3 in pairs(arg_485_1.actors_) do
					local var_488_67 = iter_488_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_488_4, iter_488_5 in ipairs(var_488_67) do
						if iter_488_5.color.r > 0.51 then
							iter_488_5.color = Color.New(1, 1, 1)
						else
							iter_488_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_488_68 = 0.2

			if var_488_66 <= arg_485_1.time_ and arg_485_1.time_ < var_488_66 + var_488_68 then
				local var_488_69 = (arg_485_1.time_ - var_488_66) / var_488_68

				arg_485_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_488_69)
			end

			if arg_485_1.time_ >= var_488_66 + var_488_68 and arg_485_1.time_ < var_488_66 + var_488_68 + arg_488_0 then
				arg_485_1.screenFilterEffect_.weight = 1
			end

			local var_488_70 = 1.36666666666667
			local var_488_71 = 8.236
			local var_488_72 = manager.audio:GetVoiceLength("story_v_out_111041", "111041117", "story_v_out_111041.awb") / 1000

			if var_488_72 > 0 and var_488_71 < var_488_72 and var_488_72 + var_488_70 > arg_485_1.duration_ then
				local var_488_73 = var_488_72

				arg_485_1.duration_ = var_488_72 + var_488_70
			end

			if var_488_70 < arg_485_1.time_ and arg_485_1.time_ <= var_488_70 + arg_488_0 then
				local var_488_74 = "play"
				local var_488_75 = "voice"

				arg_485_1:AudioAction(var_488_74, var_488_75, "story_v_out_111041", "111041117", "story_v_out_111041.awb")
			end

			if arg_485_1.frameCnt_ <= 1 then
				arg_485_1.dialog_:SetActive(false)
			end

			local var_488_76 = 1.36666666666667
			local var_488_77 = 1.05

			if var_488_76 < arg_485_1.time_ and arg_485_1.time_ <= var_488_76 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0

				arg_485_1.dialog_:SetActive(true)

				arg_485_1.dialogCg_.alpha = 0

				local var_488_78 = LeanTween.value(arg_485_1.dialog_, 0, 1, 0.3)

				var_488_78:setOnUpdate(LuaHelper.FloatAction(function(arg_489_0)
					arg_485_1.dialogCg_.alpha = arg_489_0
				end))
				var_488_78:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_485_1.dialog_)
					var_488_78:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_485_1.duration_ = arg_485_1.duration_ + 0.3

				SetActive(arg_485_1.leftNameGo_, true)

				local var_488_79 = arg_485_1:FormatText(StoryNameCfg[13].name)

				arg_485_1.leftNameTxt_.text = var_488_79

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_485_1.leftNameTxt_.transform)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1.leftNameTxt_.text)
				SetActive(arg_485_1.iconTrs_.gameObject, false)
				arg_485_1.callingController_:SetSelectedState("normal")

				local var_488_80 = arg_485_1:GetWordFromCfg(111041117)
				local var_488_81 = arg_485_1:FormatText(var_488_80.content)

				arg_485_1.text_.text = var_488_81

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_82 = 42
				local var_488_83 = utf8.len(var_488_81)
				local var_488_84 = var_488_82 <= 0 and var_488_77 or var_488_77 * (var_488_83 / var_488_82)

				if var_488_84 > 0 and var_488_77 < var_488_84 then
					arg_485_1.talkMaxDuration = var_488_84
					var_488_76 = var_488_76 + 0.3

					if var_488_84 + var_488_76 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_84 + var_488_76
					end
				end

				arg_485_1.text_.text = var_488_81
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111041", "111041117", "story_v_out_111041.awb") ~= 0 then
					local var_488_85 = manager.audio:GetVoiceLength("story_v_out_111041", "111041117", "story_v_out_111041.awb") / 1000

					if var_488_85 + var_488_76 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_85 + var_488_76
					end

					if var_488_80.prefab_name ~= "" and arg_485_1.actors_[var_488_80.prefab_name] ~= nil then
						local var_488_86 = LuaForUtil.PlayVoiceWithCriLipsync(arg_485_1.actors_[var_488_80.prefab_name].transform, "story_v_out_111041", "111041117", "story_v_out_111041.awb")

						arg_485_1:RecordAudio("111041117", var_488_86)
						arg_485_1:RecordAudio("111041117", var_488_86)
					else
						arg_485_1:AudioAction("play", "voice", "story_v_out_111041", "111041117", "story_v_out_111041.awb")
					end

					arg_485_1:RecordHistoryTalkVoice("story_v_out_111041", "111041117", "story_v_out_111041.awb")
				end

				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_87 = var_488_76 + 0.3
			local var_488_88 = math.max(var_488_77, arg_485_1.talkMaxDuration)

			if var_488_87 <= arg_485_1.time_ and arg_485_1.time_ < var_488_87 + var_488_88 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - var_488_87) / var_488_88

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= var_488_87 + var_488_88 and arg_485_1.time_ < var_488_87 + var_488_88 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {
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
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_485_1:InitPlayNodeList()
	end,
	Play111041118 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 111041118
		arg_491_1.duration_ = 5

		SetActive(arg_491_1.tipsGo_, false)

		function arg_491_1.onSingleLineFinish_()
			arg_491_1.onSingleLineUpdate_ = nil
			arg_491_1.onSingleLineFinish_ = nil
			arg_491_1.state_ = "waiting"
		end

		function arg_491_1.playNext_(arg_493_0)
			if arg_493_0 == 1 then
				arg_491_0:Play111041119(arg_491_1)
			end
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			local var_494_0 = arg_491_1.actors_["1019ui_story"]
			local var_494_1 = 0

			if var_494_1 < arg_491_1.time_ and arg_491_1.time_ <= var_494_1 + arg_494_0 and not isNil(var_494_0) and arg_491_1.var_.characterEffect1019ui_story == nil then
				arg_491_1.var_.characterEffect1019ui_story = var_494_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_494_2 = 0.2

			if var_494_1 <= arg_491_1.time_ and arg_491_1.time_ < var_494_1 + var_494_2 and not isNil(var_494_0) then
				local var_494_3 = (arg_491_1.time_ - var_494_1) / var_494_2

				if arg_491_1.var_.characterEffect1019ui_story and not isNil(var_494_0) then
					local var_494_4 = Mathf.Lerp(0, 0.5, var_494_3)

					arg_491_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_491_1.var_.characterEffect1019ui_story.fillRatio = var_494_4
				end
			end

			if arg_491_1.time_ >= var_494_1 + var_494_2 and arg_491_1.time_ < var_494_1 + var_494_2 + arg_494_0 and not isNil(var_494_0) and arg_491_1.var_.characterEffect1019ui_story then
				local var_494_5 = 0.5

				arg_491_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_491_1.var_.characterEffect1019ui_story.fillRatio = var_494_5
			end

			local var_494_6 = 0
			local var_494_7 = 0.525

			if var_494_6 < arg_491_1.time_ and arg_491_1.time_ <= var_494_6 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0
				arg_491_1.dialogCg_.alpha = 1

				arg_491_1.dialog_:SetActive(true)
				SetActive(arg_491_1.leftNameGo_, true)

				local var_494_8 = arg_491_1:FormatText(StoryNameCfg[7].name)

				arg_491_1.leftNameTxt_.text = var_494_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_491_1.leftNameTxt_.transform)

				arg_491_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_491_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_491_1:RecordName(arg_491_1.leftNameTxt_.text)
				SetActive(arg_491_1.iconTrs_.gameObject, true)
				arg_491_1.iconController_:SetSelectedState("hero")

				arg_491_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_491_1.callingController_:SetSelectedState("normal")

				arg_491_1.keyicon_.color = Color.New(1, 1, 1)
				arg_491_1.icon_.color = Color.New(1, 1, 1)

				local var_494_9 = arg_491_1:GetWordFromCfg(111041118)
				local var_494_10 = arg_491_1:FormatText(var_494_9.content)

				arg_491_1.text_.text = var_494_10

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.text_)

				local var_494_11 = 21
				local var_494_12 = utf8.len(var_494_10)
				local var_494_13 = var_494_11 <= 0 and var_494_7 or var_494_7 * (var_494_12 / var_494_11)

				if var_494_13 > 0 and var_494_7 < var_494_13 then
					arg_491_1.talkMaxDuration = var_494_13

					if var_494_13 + var_494_6 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_13 + var_494_6
					end
				end

				arg_491_1.text_.text = var_494_10
				arg_491_1.typewritter.percent = 0

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(false)
				arg_491_1:RecordContent(arg_491_1.text_.text)
			end

			local var_494_14 = math.max(var_494_7, arg_491_1.talkMaxDuration)

			if var_494_6 <= arg_491_1.time_ and arg_491_1.time_ < var_494_6 + var_494_14 then
				arg_491_1.typewritter.percent = (arg_491_1.time_ - var_494_6) / var_494_14

				arg_491_1.typewritter:SetDirty()
			end

			if arg_491_1.time_ >= var_494_6 + var_494_14 and arg_491_1.time_ < var_494_6 + var_494_14 + arg_494_0 then
				arg_491_1.typewritter.percent = 1

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(true)
			end
		end

		arg_491_1.nodeConfigList_ = {}

		arg_491_1:InitPlayNodeList()
	end,
	Play111041119 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 111041119
		arg_495_1.duration_ = 13.07

		local var_495_0 = {
			ja = 12.6,
			ko = 11.833999999999,
			zh = 12.033,
			en = 13.066
		}
		local var_495_1 = manager.audio:GetLocalizationFlag()

		if var_495_0[var_495_1] ~= nil then
			arg_495_1.duration_ = var_495_0[var_495_1]
		end

		SetActive(arg_495_1.tipsGo_, false)

		function arg_495_1.onSingleLineFinish_()
			arg_495_1.onSingleLineUpdate_ = nil
			arg_495_1.onSingleLineFinish_ = nil
			arg_495_1.state_ = "waiting"
		end

		function arg_495_1.playNext_(arg_497_0)
			if arg_497_0 == 1 then
				arg_495_0:Play111041120(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			local var_498_0 = 0

			if var_498_0 < arg_495_1.time_ and arg_495_1.time_ <= var_498_0 + arg_498_0 then
				arg_495_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_498_1 = arg_495_1.actors_["1019ui_story"]
			local var_498_2 = 0

			if var_498_2 < arg_495_1.time_ and arg_495_1.time_ <= var_498_2 + arg_498_0 and not isNil(var_498_1) and arg_495_1.var_.characterEffect1019ui_story == nil then
				arg_495_1.var_.characterEffect1019ui_story = var_498_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_498_3 = 0.2

			if var_498_2 <= arg_495_1.time_ and arg_495_1.time_ < var_498_2 + var_498_3 and not isNil(var_498_1) then
				local var_498_4 = (arg_495_1.time_ - var_498_2) / var_498_3

				if arg_495_1.var_.characterEffect1019ui_story and not isNil(var_498_1) then
					arg_495_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_495_1.time_ >= var_498_2 + var_498_3 and arg_495_1.time_ < var_498_2 + var_498_3 + arg_498_0 and not isNil(var_498_1) and arg_495_1.var_.characterEffect1019ui_story then
				arg_495_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_498_5 = 0
			local var_498_6 = 11.834
			local var_498_7 = manager.audio:GetVoiceLength("story_v_out_111041", "111041119", "story_v_out_111041.awb") / 1000

			if var_498_7 > 0 and var_498_6 < var_498_7 and var_498_7 + var_498_5 > arg_495_1.duration_ then
				local var_498_8 = var_498_7

				arg_495_1.duration_ = var_498_7 + var_498_5
			end

			if var_498_5 < arg_495_1.time_ and arg_495_1.time_ <= var_498_5 + arg_498_0 then
				local var_498_9 = "play"
				local var_498_10 = "voice"

				arg_495_1:AudioAction(var_498_9, var_498_10, "story_v_out_111041", "111041119", "story_v_out_111041.awb")
			end

			local var_498_11 = 0
			local var_498_12 = 1.15

			if var_498_11 < arg_495_1.time_ and arg_495_1.time_ <= var_498_11 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0
				arg_495_1.dialogCg_.alpha = 1

				arg_495_1.dialog_:SetActive(true)
				SetActive(arg_495_1.leftNameGo_, true)

				local var_498_13 = arg_495_1:FormatText(StoryNameCfg[13].name)

				arg_495_1.leftNameTxt_.text = var_498_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_495_1.leftNameTxt_.transform)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1.leftNameTxt_.text)
				SetActive(arg_495_1.iconTrs_.gameObject, false)
				arg_495_1.callingController_:SetSelectedState("normal")

				local var_498_14 = arg_495_1:GetWordFromCfg(111041119)
				local var_498_15 = arg_495_1:FormatText(var_498_14.content)

				arg_495_1.text_.text = var_498_15

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_16 = 46
				local var_498_17 = utf8.len(var_498_15)
				local var_498_18 = var_498_16 <= 0 and var_498_12 or var_498_12 * (var_498_17 / var_498_16)

				if var_498_18 > 0 and var_498_12 < var_498_18 then
					arg_495_1.talkMaxDuration = var_498_18

					if var_498_18 + var_498_11 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_18 + var_498_11
					end
				end

				arg_495_1.text_.text = var_498_15
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111041", "111041119", "story_v_out_111041.awb") ~= 0 then
					local var_498_19 = manager.audio:GetVoiceLength("story_v_out_111041", "111041119", "story_v_out_111041.awb") / 1000

					if var_498_19 + var_498_11 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_19 + var_498_11
					end

					if var_498_14.prefab_name ~= "" and arg_495_1.actors_[var_498_14.prefab_name] ~= nil then
						local var_498_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_495_1.actors_[var_498_14.prefab_name].transform, "story_v_out_111041", "111041119", "story_v_out_111041.awb")

						arg_495_1:RecordAudio("111041119", var_498_20)
						arg_495_1:RecordAudio("111041119", var_498_20)
					else
						arg_495_1:AudioAction("play", "voice", "story_v_out_111041", "111041119", "story_v_out_111041.awb")
					end

					arg_495_1:RecordHistoryTalkVoice("story_v_out_111041", "111041119", "story_v_out_111041.awb")
				end

				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_21 = math.max(var_498_12, arg_495_1.talkMaxDuration)

			if var_498_11 <= arg_495_1.time_ and arg_495_1.time_ < var_498_11 + var_498_21 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - var_498_11) / var_498_21

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= var_498_11 + var_498_21 and arg_495_1.time_ < var_498_11 + var_498_21 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end

		arg_495_1.nodeConfigList_ = {}

		arg_495_1:InitPlayNodeList()
	end,
	Play111041120 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 111041120
		arg_499_1.duration_ = 5

		SetActive(arg_499_1.tipsGo_, false)

		function arg_499_1.onSingleLineFinish_()
			arg_499_1.onSingleLineUpdate_ = nil
			arg_499_1.onSingleLineFinish_ = nil
			arg_499_1.state_ = "waiting"
		end

		function arg_499_1.playNext_(arg_501_0)
			if arg_501_0 == 1 then
				arg_499_0:Play111041121(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			local var_502_0 = arg_499_1.actors_["1019ui_story"]
			local var_502_1 = 0

			if var_502_1 < arg_499_1.time_ and arg_499_1.time_ <= var_502_1 + arg_502_0 and not isNil(var_502_0) and arg_499_1.var_.characterEffect1019ui_story == nil then
				arg_499_1.var_.characterEffect1019ui_story = var_502_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_502_2 = 0.2

			if var_502_1 <= arg_499_1.time_ and arg_499_1.time_ < var_502_1 + var_502_2 and not isNil(var_502_0) then
				local var_502_3 = (arg_499_1.time_ - var_502_1) / var_502_2

				if arg_499_1.var_.characterEffect1019ui_story and not isNil(var_502_0) then
					local var_502_4 = Mathf.Lerp(0, 0.5, var_502_3)

					arg_499_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_499_1.var_.characterEffect1019ui_story.fillRatio = var_502_4
				end
			end

			if arg_499_1.time_ >= var_502_1 + var_502_2 and arg_499_1.time_ < var_502_1 + var_502_2 + arg_502_0 and not isNil(var_502_0) and arg_499_1.var_.characterEffect1019ui_story then
				local var_502_5 = 0.5

				arg_499_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_499_1.var_.characterEffect1019ui_story.fillRatio = var_502_5
			end

			local var_502_6 = 0
			local var_502_7 = 0.45

			if var_502_6 < arg_499_1.time_ and arg_499_1.time_ <= var_502_6 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, true)

				local var_502_8 = arg_499_1:FormatText(StoryNameCfg[7].name)

				arg_499_1.leftNameTxt_.text = var_502_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_499_1.leftNameTxt_.transform)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1.leftNameTxt_.text)
				SetActive(arg_499_1.iconTrs_.gameObject, true)
				arg_499_1.iconController_:SetSelectedState("hero")

				arg_499_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_499_1.callingController_:SetSelectedState("normal")

				arg_499_1.keyicon_.color = Color.New(1, 1, 1)
				arg_499_1.icon_.color = Color.New(1, 1, 1)

				local var_502_9 = arg_499_1:GetWordFromCfg(111041120)
				local var_502_10 = arg_499_1:FormatText(var_502_9.content)

				arg_499_1.text_.text = var_502_10

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_11 = 18
				local var_502_12 = utf8.len(var_502_10)
				local var_502_13 = var_502_11 <= 0 and var_502_7 or var_502_7 * (var_502_12 / var_502_11)

				if var_502_13 > 0 and var_502_7 < var_502_13 then
					arg_499_1.talkMaxDuration = var_502_13

					if var_502_13 + var_502_6 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_13 + var_502_6
					end
				end

				arg_499_1.text_.text = var_502_10
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)
				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_14 = math.max(var_502_7, arg_499_1.talkMaxDuration)

			if var_502_6 <= arg_499_1.time_ and arg_499_1.time_ < var_502_6 + var_502_14 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - var_502_6) / var_502_14

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= var_502_6 + var_502_14 and arg_499_1.time_ < var_502_6 + var_502_14 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end

		arg_499_1.nodeConfigList_ = {}

		arg_499_1:InitPlayNodeList()
	end,
	Play111041121 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 111041121
		arg_503_1.duration_ = 6.7

		local var_503_0 = {
			ja = 6.7,
			ko = 5.633,
			zh = 5.033,
			en = 6.366
		}
		local var_503_1 = manager.audio:GetLocalizationFlag()

		if var_503_0[var_503_1] ~= nil then
			arg_503_1.duration_ = var_503_0[var_503_1]
		end

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play111041122(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			local var_506_0 = 0

			if var_506_0 < arg_503_1.time_ and arg_503_1.time_ <= var_506_0 + arg_506_0 then
				arg_503_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action4_2")
			end

			local var_506_1 = arg_503_1.actors_["1066ui_story"]
			local var_506_2 = 0

			if var_506_2 < arg_503_1.time_ and arg_503_1.time_ <= var_506_2 + arg_506_0 and not isNil(var_506_1) and arg_503_1.var_.characterEffect1066ui_story == nil then
				arg_503_1.var_.characterEffect1066ui_story = var_506_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_506_3 = 0.2

			if var_506_2 <= arg_503_1.time_ and arg_503_1.time_ < var_506_2 + var_506_3 and not isNil(var_506_1) then
				local var_506_4 = (arg_503_1.time_ - var_506_2) / var_506_3

				if arg_503_1.var_.characterEffect1066ui_story and not isNil(var_506_1) then
					arg_503_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_503_1.time_ >= var_506_2 + var_506_3 and arg_503_1.time_ < var_506_2 + var_506_3 + arg_506_0 and not isNil(var_506_1) and arg_503_1.var_.characterEffect1066ui_story then
				arg_503_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_506_5 = 0

			if var_506_5 < arg_503_1.time_ and arg_503_1.time_ <= var_506_5 + arg_506_0 then
				arg_503_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_506_6 = 0
			local var_506_7 = 4.678
			local var_506_8 = manager.audio:GetVoiceLength("story_v_out_111041", "111041121", "story_v_out_111041.awb") / 1000

			if var_506_8 > 0 and var_506_7 < var_506_8 and var_506_8 + var_506_6 > arg_503_1.duration_ then
				local var_506_9 = var_506_8

				arg_503_1.duration_ = var_506_8 + var_506_6
			end

			if var_506_6 < arg_503_1.time_ and arg_503_1.time_ <= var_506_6 + arg_506_0 then
				local var_506_10 = "play"
				local var_506_11 = "voice"

				arg_503_1:AudioAction(var_506_10, var_506_11, "story_v_out_111041", "111041121", "story_v_out_111041.awb")
			end

			local var_506_12 = 0
			local var_506_13 = 0.625

			if var_506_12 < arg_503_1.time_ and arg_503_1.time_ <= var_506_12 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, true)

				local var_506_14 = arg_503_1:FormatText(StoryNameCfg[32].name)

				arg_503_1.leftNameTxt_.text = var_506_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_503_1.leftNameTxt_.transform)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1.leftNameTxt_.text)
				SetActive(arg_503_1.iconTrs_.gameObject, false)
				arg_503_1.callingController_:SetSelectedState("normal")

				local var_506_15 = arg_503_1:GetWordFromCfg(111041121)
				local var_506_16 = arg_503_1:FormatText(var_506_15.content)

				arg_503_1.text_.text = var_506_16

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_17 = 25
				local var_506_18 = utf8.len(var_506_16)
				local var_506_19 = var_506_17 <= 0 and var_506_13 or var_506_13 * (var_506_18 / var_506_17)

				if var_506_19 > 0 and var_506_13 < var_506_19 then
					arg_503_1.talkMaxDuration = var_506_19

					if var_506_19 + var_506_12 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_19 + var_506_12
					end
				end

				arg_503_1.text_.text = var_506_16
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111041", "111041121", "story_v_out_111041.awb") ~= 0 then
					local var_506_20 = manager.audio:GetVoiceLength("story_v_out_111041", "111041121", "story_v_out_111041.awb") / 1000

					if var_506_20 + var_506_12 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_20 + var_506_12
					end

					if var_506_15.prefab_name ~= "" and arg_503_1.actors_[var_506_15.prefab_name] ~= nil then
						local var_506_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_503_1.actors_[var_506_15.prefab_name].transform, "story_v_out_111041", "111041121", "story_v_out_111041.awb")

						arg_503_1:RecordAudio("111041121", var_506_21)
						arg_503_1:RecordAudio("111041121", var_506_21)
					else
						arg_503_1:AudioAction("play", "voice", "story_v_out_111041", "111041121", "story_v_out_111041.awb")
					end

					arg_503_1:RecordHistoryTalkVoice("story_v_out_111041", "111041121", "story_v_out_111041.awb")
				end

				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_22 = math.max(var_506_13, arg_503_1.talkMaxDuration)

			if var_506_12 <= arg_503_1.time_ and arg_503_1.time_ < var_506_12 + var_506_22 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - var_506_12) / var_506_22

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= var_506_12 + var_506_22 and arg_503_1.time_ < var_506_12 + var_506_22 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {}

		arg_503_1:InitPlayNodeList()
	end,
	Play111041122 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 111041122
		arg_507_1.duration_ = 5

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play111041123(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			local var_510_0 = 0

			if var_510_0 < arg_507_1.time_ and arg_507_1.time_ <= var_510_0 + arg_510_0 then
				local var_510_1 = manager.ui.mainCamera.transform.localPosition
				local var_510_2 = Vector3.New(0, 0, 10) + Vector3.New(var_510_1.x, var_510_1.y, 0)
				local var_510_3 = arg_507_1.bgs_.B13a

				var_510_3.transform.localPosition = var_510_2
				var_510_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_510_4 = var_510_3:GetComponent("SpriteRenderer")

				if var_510_4 and var_510_4.sprite then
					local var_510_5 = (var_510_3.transform.localPosition - var_510_1).z
					local var_510_6 = manager.ui.mainCameraCom_
					local var_510_7 = 2 * var_510_5 * Mathf.Tan(var_510_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_510_8 = var_510_7 * var_510_6.aspect
					local var_510_9 = var_510_4.sprite.bounds.size.x
					local var_510_10 = var_510_4.sprite.bounds.size.y
					local var_510_11 = var_510_8 / var_510_9
					local var_510_12 = var_510_7 / var_510_10
					local var_510_13 = var_510_12 < var_510_11 and var_510_11 or var_510_12

					var_510_3.transform.localScale = Vector3.New(var_510_13, var_510_13, 0)
				end

				for iter_510_0, iter_510_1 in pairs(arg_507_1.bgs_) do
					if iter_510_0 ~= "B13a" then
						iter_510_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_510_14 = 0

			arg_507_1.isInRecall_ = false

			if var_510_14 < arg_507_1.time_ and arg_507_1.time_ <= var_510_14 + arg_510_0 then
				arg_507_1.screenFilterGo_:SetActive(false)

				for iter_510_2, iter_510_3 in pairs(arg_507_1.actors_) do
					local var_510_15 = iter_510_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_510_4, iter_510_5 in ipairs(var_510_15) do
						if iter_510_5.color.r > 0.51 then
							iter_510_5.color = Color.New(1, 1, 1)
						else
							iter_510_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_510_16 = 0.2

			if var_510_14 <= arg_507_1.time_ and arg_507_1.time_ < var_510_14 + var_510_16 then
				local var_510_17 = (arg_507_1.time_ - var_510_14) / var_510_16

				arg_507_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_510_17)
			end

			if arg_507_1.time_ >= var_510_14 + var_510_16 and arg_507_1.time_ < var_510_14 + var_510_16 + arg_510_0 then
				arg_507_1.screenFilterEffect_.weight = 0
			end

			local var_510_18 = 0

			if var_510_18 < arg_507_1.time_ and arg_507_1.time_ <= var_510_18 + arg_510_0 then
				arg_507_1.mask_.enabled = true
				arg_507_1.mask_.raycastTarget = true

				arg_507_1:SetGaussion(false)
			end

			local var_510_19 = 0.766666666666667

			if var_510_18 <= arg_507_1.time_ and arg_507_1.time_ < var_510_18 + var_510_19 then
				local var_510_20 = (arg_507_1.time_ - var_510_18) / var_510_19
				local var_510_21 = Color.New(1, 1, 1)

				var_510_21.a = Mathf.Lerp(1, 0, var_510_20)
				arg_507_1.mask_.color = var_510_21
			end

			if arg_507_1.time_ >= var_510_18 + var_510_19 and arg_507_1.time_ < var_510_18 + var_510_19 + arg_510_0 then
				local var_510_22 = Color.New(1, 1, 1)
				local var_510_23 = 0

				arg_507_1.mask_.enabled = false
				var_510_22.a = var_510_23
				arg_507_1.mask_.color = var_510_22
			end

			local var_510_24 = arg_507_1.actors_["1019ui_story"].transform
			local var_510_25 = 0

			if var_510_25 < arg_507_1.time_ and arg_507_1.time_ <= var_510_25 + arg_510_0 then
				arg_507_1.var_.moveOldPos1019ui_story = var_510_24.localPosition
			end

			local var_510_26 = 0.001

			if var_510_25 <= arg_507_1.time_ and arg_507_1.time_ < var_510_25 + var_510_26 then
				local var_510_27 = (arg_507_1.time_ - var_510_25) / var_510_26
				local var_510_28 = Vector3.New(0, 100, 0)

				var_510_24.localPosition = Vector3.Lerp(arg_507_1.var_.moveOldPos1019ui_story, var_510_28, var_510_27)

				local var_510_29 = manager.ui.mainCamera.transform.position - var_510_24.position

				var_510_24.forward = Vector3.New(var_510_29.x, var_510_29.y, var_510_29.z)

				local var_510_30 = var_510_24.localEulerAngles

				var_510_30.z = 0
				var_510_30.x = 0
				var_510_24.localEulerAngles = var_510_30
			end

			if arg_507_1.time_ >= var_510_25 + var_510_26 and arg_507_1.time_ < var_510_25 + var_510_26 + arg_510_0 then
				var_510_24.localPosition = Vector3.New(0, 100, 0)

				local var_510_31 = manager.ui.mainCamera.transform.position - var_510_24.position

				var_510_24.forward = Vector3.New(var_510_31.x, var_510_31.y, var_510_31.z)

				local var_510_32 = var_510_24.localEulerAngles

				var_510_32.z = 0
				var_510_32.x = 0
				var_510_24.localEulerAngles = var_510_32
			end

			local var_510_33 = arg_507_1.actors_["1094ui_story"].transform
			local var_510_34 = 0

			if var_510_34 < arg_507_1.time_ and arg_507_1.time_ <= var_510_34 + arg_510_0 then
				arg_507_1.var_.moveOldPos1094ui_story = var_510_33.localPosition
			end

			local var_510_35 = 0.001

			if var_510_34 <= arg_507_1.time_ and arg_507_1.time_ < var_510_34 + var_510_35 then
				local var_510_36 = (arg_507_1.time_ - var_510_34) / var_510_35
				local var_510_37 = Vector3.New(0, -0.84, -6.1)

				var_510_33.localPosition = Vector3.Lerp(arg_507_1.var_.moveOldPos1094ui_story, var_510_37, var_510_36)

				local var_510_38 = manager.ui.mainCamera.transform.position - var_510_33.position

				var_510_33.forward = Vector3.New(var_510_38.x, var_510_38.y, var_510_38.z)

				local var_510_39 = var_510_33.localEulerAngles

				var_510_39.z = 0
				var_510_39.x = 0
				var_510_33.localEulerAngles = var_510_39
			end

			if arg_507_1.time_ >= var_510_34 + var_510_35 and arg_507_1.time_ < var_510_34 + var_510_35 + arg_510_0 then
				var_510_33.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_510_40 = manager.ui.mainCamera.transform.position - var_510_33.position

				var_510_33.forward = Vector3.New(var_510_40.x, var_510_40.y, var_510_40.z)

				local var_510_41 = var_510_33.localEulerAngles

				var_510_41.z = 0
				var_510_41.x = 0
				var_510_33.localEulerAngles = var_510_41
			end

			local var_510_42 = 0

			if var_510_42 < arg_507_1.time_ and arg_507_1.time_ <= var_510_42 + arg_510_0 then
				arg_507_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action1_1")
			end

			local var_510_43 = 0

			if var_510_43 < arg_507_1.time_ and arg_507_1.time_ <= var_510_43 + arg_510_0 then
				arg_507_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_510_44 = arg_507_1.actors_["1094ui_story"]
			local var_510_45 = 0

			if var_510_45 < arg_507_1.time_ and arg_507_1.time_ <= var_510_45 + arg_510_0 and not isNil(var_510_44) and arg_507_1.var_.characterEffect1094ui_story == nil then
				arg_507_1.var_.characterEffect1094ui_story = var_510_44:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_510_46 = 0.2

			if var_510_45 <= arg_507_1.time_ and arg_507_1.time_ < var_510_45 + var_510_46 and not isNil(var_510_44) then
				local var_510_47 = (arg_507_1.time_ - var_510_45) / var_510_46

				if arg_507_1.var_.characterEffect1094ui_story and not isNil(var_510_44) then
					local var_510_48 = Mathf.Lerp(0, 0.5, var_510_47)

					arg_507_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_507_1.var_.characterEffect1094ui_story.fillRatio = var_510_48
				end
			end

			if arg_507_1.time_ >= var_510_45 + var_510_46 and arg_507_1.time_ < var_510_45 + var_510_46 + arg_510_0 and not isNil(var_510_44) and arg_507_1.var_.characterEffect1094ui_story then
				local var_510_49 = 0.5

				arg_507_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_507_1.var_.characterEffect1094ui_story.fillRatio = var_510_49
			end

			local var_510_50 = arg_507_1.actors_["1066ui_story"].transform
			local var_510_51 = 0

			if var_510_51 < arg_507_1.time_ and arg_507_1.time_ <= var_510_51 + arg_510_0 then
				arg_507_1.var_.moveOldPos1066ui_story = var_510_50.localPosition
			end

			local var_510_52 = 0.001

			if var_510_51 <= arg_507_1.time_ and arg_507_1.time_ < var_510_51 + var_510_52 then
				local var_510_53 = (arg_507_1.time_ - var_510_51) / var_510_52
				local var_510_54 = Vector3.New(0, 100, 0)

				var_510_50.localPosition = Vector3.Lerp(arg_507_1.var_.moveOldPos1066ui_story, var_510_54, var_510_53)

				local var_510_55 = manager.ui.mainCamera.transform.position - var_510_50.position

				var_510_50.forward = Vector3.New(var_510_55.x, var_510_55.y, var_510_55.z)

				local var_510_56 = var_510_50.localEulerAngles

				var_510_56.z = 0
				var_510_56.x = 0
				var_510_50.localEulerAngles = var_510_56
			end

			if arg_507_1.time_ >= var_510_51 + var_510_52 and arg_507_1.time_ < var_510_51 + var_510_52 + arg_510_0 then
				var_510_50.localPosition = Vector3.New(0, 100, 0)

				local var_510_57 = manager.ui.mainCamera.transform.position - var_510_50.position

				var_510_50.forward = Vector3.New(var_510_57.x, var_510_57.y, var_510_57.z)

				local var_510_58 = var_510_50.localEulerAngles

				var_510_58.z = 0
				var_510_58.x = 0
				var_510_50.localEulerAngles = var_510_58
			end

			local var_510_59 = 0
			local var_510_60 = 1.075

			if var_510_59 < arg_507_1.time_ and arg_507_1.time_ <= var_510_59 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0

				arg_507_1.dialog_:SetActive(true)

				arg_507_1.dialogCg_.alpha = 0

				local var_510_61 = LeanTween.value(arg_507_1.dialog_, 0, 1, 0.3)

				var_510_61:setOnUpdate(LuaHelper.FloatAction(function(arg_511_0)
					arg_507_1.dialogCg_.alpha = arg_511_0
				end))
				var_510_61:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_507_1.dialog_)
					var_510_61:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_507_1.duration_ = arg_507_1.duration_ + 0.3

				SetActive(arg_507_1.leftNameGo_, false)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_507_1.iconTrs_.gameObject, false)
				arg_507_1.callingController_:SetSelectedState("normal")

				local var_510_62 = arg_507_1:GetWordFromCfg(111041122)
				local var_510_63 = arg_507_1:FormatText(var_510_62.content)

				arg_507_1.text_.text = var_510_63

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_64 = 43
				local var_510_65 = utf8.len(var_510_63)
				local var_510_66 = var_510_64 <= 0 and var_510_60 or var_510_60 * (var_510_65 / var_510_64)

				if var_510_66 > 0 and var_510_60 < var_510_66 then
					arg_507_1.talkMaxDuration = var_510_66
					var_510_59 = var_510_59 + 0.3

					if var_510_66 + var_510_59 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_66 + var_510_59
					end
				end

				arg_507_1.text_.text = var_510_63
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)
				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_67 = var_510_59 + 0.3
			local var_510_68 = math.max(var_510_60, arg_507_1.talkMaxDuration)

			if var_510_67 <= arg_507_1.time_ and arg_507_1.time_ < var_510_67 + var_510_68 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - var_510_67) / var_510_68

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= var_510_67 + var_510_68 and arg_507_1.time_ < var_510_67 + var_510_68 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_507_1:InitPlayNodeList()
	end,
	Play111041123 = function(arg_513_0, arg_513_1)
		arg_513_1.time_ = 0
		arg_513_1.frameCnt_ = 0
		arg_513_1.state_ = "playing"
		arg_513_1.curTalkId_ = 111041123
		arg_513_1.duration_ = 5

		SetActive(arg_513_1.tipsGo_, false)

		function arg_513_1.onSingleLineFinish_()
			arg_513_1.onSingleLineUpdate_ = nil
			arg_513_1.onSingleLineFinish_ = nil
			arg_513_1.state_ = "waiting"
		end

		function arg_513_1.playNext_(arg_515_0)
			if arg_515_0 == 1 then
				arg_513_0:Play111041124(arg_513_1)
			end
		end

		function arg_513_1.onSingleLineUpdate_(arg_516_0)
			local var_516_0 = 0
			local var_516_1 = 0.8

			if var_516_0 < arg_513_1.time_ and arg_513_1.time_ <= var_516_0 + arg_516_0 then
				arg_513_1.talkMaxDuration = 0
				arg_513_1.dialogCg_.alpha = 1

				arg_513_1.dialog_:SetActive(true)
				SetActive(arg_513_1.leftNameGo_, true)

				local var_516_2 = arg_513_1:FormatText(StoryNameCfg[7].name)

				arg_513_1.leftNameTxt_.text = var_516_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_513_1.leftNameTxt_.transform)

				arg_513_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_513_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_513_1:RecordName(arg_513_1.leftNameTxt_.text)
				SetActive(arg_513_1.iconTrs_.gameObject, true)
				arg_513_1.iconController_:SetSelectedState("hero")

				arg_513_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_513_1.callingController_:SetSelectedState("normal")

				arg_513_1.keyicon_.color = Color.New(1, 1, 1)
				arg_513_1.icon_.color = Color.New(1, 1, 1)

				local var_516_3 = arg_513_1:GetWordFromCfg(111041123)
				local var_516_4 = arg_513_1:FormatText(var_516_3.content)

				arg_513_1.text_.text = var_516_4

				LuaForUtil.ClearLinePrefixSymbol(arg_513_1.text_)

				local var_516_5 = 32
				local var_516_6 = utf8.len(var_516_4)
				local var_516_7 = var_516_5 <= 0 and var_516_1 or var_516_1 * (var_516_6 / var_516_5)

				if var_516_7 > 0 and var_516_1 < var_516_7 then
					arg_513_1.talkMaxDuration = var_516_7

					if var_516_7 + var_516_0 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_7 + var_516_0
					end
				end

				arg_513_1.text_.text = var_516_4
				arg_513_1.typewritter.percent = 0

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(false)
				arg_513_1:RecordContent(arg_513_1.text_.text)
			end

			local var_516_8 = math.max(var_516_1, arg_513_1.talkMaxDuration)

			if var_516_0 <= arg_513_1.time_ and arg_513_1.time_ < var_516_0 + var_516_8 then
				arg_513_1.typewritter.percent = (arg_513_1.time_ - var_516_0) / var_516_8

				arg_513_1.typewritter:SetDirty()
			end

			if arg_513_1.time_ >= var_516_0 + var_516_8 and arg_513_1.time_ < var_516_0 + var_516_8 + arg_516_0 then
				arg_513_1.typewritter.percent = 1

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(true)
			end
		end

		arg_513_1.nodeConfigList_ = {}

		arg_513_1:InitPlayNodeList()
	end,
	Play111041124 = function(arg_517_0, arg_517_1)
		arg_517_1.time_ = 0
		arg_517_1.frameCnt_ = 0
		arg_517_1.state_ = "playing"
		arg_517_1.curTalkId_ = 111041124
		arg_517_1.duration_ = 4.03

		local var_517_0 = {
			ja = 4.033,
			ko = 1.999999999999,
			zh = 2,
			en = 1.999999999999
		}
		local var_517_1 = manager.audio:GetLocalizationFlag()

		if var_517_0[var_517_1] ~= nil then
			arg_517_1.duration_ = var_517_0[var_517_1]
		end

		SetActive(arg_517_1.tipsGo_, false)

		function arg_517_1.onSingleLineFinish_()
			arg_517_1.onSingleLineUpdate_ = nil
			arg_517_1.onSingleLineFinish_ = nil
			arg_517_1.state_ = "waiting"
		end

		function arg_517_1.playNext_(arg_519_0)
			if arg_519_0 == 1 then
				arg_517_0:Play111041125(arg_517_1)
			end
		end

		function arg_517_1.onSingleLineUpdate_(arg_520_0)
			local var_520_0 = 0

			if var_520_0 < arg_517_1.time_ and arg_517_1.time_ <= var_520_0 + arg_520_0 then
				arg_517_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action5_1")
			end

			local var_520_1 = 0

			if var_520_1 < arg_517_1.time_ and arg_517_1.time_ <= var_520_1 + arg_520_0 then
				arg_517_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1301cva")
			end

			local var_520_2 = arg_517_1.actors_["1094ui_story"]
			local var_520_3 = 0

			if var_520_3 < arg_517_1.time_ and arg_517_1.time_ <= var_520_3 + arg_520_0 and not isNil(var_520_2) and arg_517_1.var_.characterEffect1094ui_story == nil then
				arg_517_1.var_.characterEffect1094ui_story = var_520_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_520_4 = 0.2

			if var_520_3 <= arg_517_1.time_ and arg_517_1.time_ < var_520_3 + var_520_4 and not isNil(var_520_2) then
				local var_520_5 = (arg_517_1.time_ - var_520_3) / var_520_4

				if arg_517_1.var_.characterEffect1094ui_story and not isNil(var_520_2) then
					arg_517_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_517_1.time_ >= var_520_3 + var_520_4 and arg_517_1.time_ < var_520_3 + var_520_4 + arg_520_0 and not isNil(var_520_2) and arg_517_1.var_.characterEffect1094ui_story then
				arg_517_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_520_6 = 0
			local var_520_7 = 0.15

			if var_520_6 < arg_517_1.time_ and arg_517_1.time_ <= var_520_6 + arg_520_0 then
				arg_517_1.talkMaxDuration = 0
				arg_517_1.dialogCg_.alpha = 1

				arg_517_1.dialog_:SetActive(true)
				SetActive(arg_517_1.leftNameGo_, true)

				local var_520_8 = arg_517_1:FormatText(StoryNameCfg[181].name)

				arg_517_1.leftNameTxt_.text = var_520_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_517_1.leftNameTxt_.transform)

				arg_517_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_517_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_517_1:RecordName(arg_517_1.leftNameTxt_.text)
				SetActive(arg_517_1.iconTrs_.gameObject, false)
				arg_517_1.callingController_:SetSelectedState("normal")

				local var_520_9 = arg_517_1:GetWordFromCfg(111041124)
				local var_520_10 = arg_517_1:FormatText(var_520_9.content)

				arg_517_1.text_.text = var_520_10

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.text_)

				local var_520_11 = 6
				local var_520_12 = utf8.len(var_520_10)
				local var_520_13 = var_520_11 <= 0 and var_520_7 or var_520_7 * (var_520_12 / var_520_11)

				if var_520_13 > 0 and var_520_7 < var_520_13 then
					arg_517_1.talkMaxDuration = var_520_13

					if var_520_13 + var_520_6 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_13 + var_520_6
					end
				end

				arg_517_1.text_.text = var_520_10
				arg_517_1.typewritter.percent = 0

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111041", "111041124", "story_v_out_111041.awb") ~= 0 then
					local var_520_14 = manager.audio:GetVoiceLength("story_v_out_111041", "111041124", "story_v_out_111041.awb") / 1000

					if var_520_14 + var_520_6 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_14 + var_520_6
					end

					if var_520_9.prefab_name ~= "" and arg_517_1.actors_[var_520_9.prefab_name] ~= nil then
						local var_520_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_517_1.actors_[var_520_9.prefab_name].transform, "story_v_out_111041", "111041124", "story_v_out_111041.awb")

						arg_517_1:RecordAudio("111041124", var_520_15)
						arg_517_1:RecordAudio("111041124", var_520_15)
					else
						arg_517_1:AudioAction("play", "voice", "story_v_out_111041", "111041124", "story_v_out_111041.awb")
					end

					arg_517_1:RecordHistoryTalkVoice("story_v_out_111041", "111041124", "story_v_out_111041.awb")
				end

				arg_517_1:RecordContent(arg_517_1.text_.text)
			end

			local var_520_16 = math.max(var_520_7, arg_517_1.talkMaxDuration)

			if var_520_6 <= arg_517_1.time_ and arg_517_1.time_ < var_520_6 + var_520_16 then
				arg_517_1.typewritter.percent = (arg_517_1.time_ - var_520_6) / var_520_16

				arg_517_1.typewritter:SetDirty()
			end

			if arg_517_1.time_ >= var_520_6 + var_520_16 and arg_517_1.time_ < var_520_6 + var_520_16 + arg_520_0 then
				arg_517_1.typewritter.percent = 1

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(true)
			end
		end

		arg_517_1.nodeConfigList_ = {}

		arg_517_1:InitPlayNodeList()
	end,
	Play111041125 = function(arg_521_0, arg_521_1)
		arg_521_1.time_ = 0
		arg_521_1.frameCnt_ = 0
		arg_521_1.state_ = "playing"
		arg_521_1.curTalkId_ = 111041125
		arg_521_1.duration_ = 5

		SetActive(arg_521_1.tipsGo_, false)

		function arg_521_1.onSingleLineFinish_()
			arg_521_1.onSingleLineUpdate_ = nil
			arg_521_1.onSingleLineFinish_ = nil
			arg_521_1.state_ = "waiting"
		end

		function arg_521_1.playNext_(arg_523_0)
			if arg_523_0 == 1 then
				arg_521_0:Play111041126(arg_521_1)
			end
		end

		function arg_521_1.onSingleLineUpdate_(arg_524_0)
			local var_524_0 = arg_521_1.actors_["1094ui_story"]
			local var_524_1 = 0

			if var_524_1 < arg_521_1.time_ and arg_521_1.time_ <= var_524_1 + arg_524_0 and not isNil(var_524_0) and arg_521_1.var_.characterEffect1094ui_story == nil then
				arg_521_1.var_.characterEffect1094ui_story = var_524_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_524_2 = 0.2

			if var_524_1 <= arg_521_1.time_ and arg_521_1.time_ < var_524_1 + var_524_2 and not isNil(var_524_0) then
				local var_524_3 = (arg_521_1.time_ - var_524_1) / var_524_2

				if arg_521_1.var_.characterEffect1094ui_story and not isNil(var_524_0) then
					local var_524_4 = Mathf.Lerp(0, 0.5, var_524_3)

					arg_521_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_521_1.var_.characterEffect1094ui_story.fillRatio = var_524_4
				end
			end

			if arg_521_1.time_ >= var_524_1 + var_524_2 and arg_521_1.time_ < var_524_1 + var_524_2 + arg_524_0 and not isNil(var_524_0) and arg_521_1.var_.characterEffect1094ui_story then
				local var_524_5 = 0.5

				arg_521_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_521_1.var_.characterEffect1094ui_story.fillRatio = var_524_5
			end

			local var_524_6 = 0
			local var_524_7 = 0.25

			if var_524_6 < arg_521_1.time_ and arg_521_1.time_ <= var_524_6 + arg_524_0 then
				arg_521_1.talkMaxDuration = 0
				arg_521_1.dialogCg_.alpha = 1

				arg_521_1.dialog_:SetActive(true)
				SetActive(arg_521_1.leftNameGo_, true)

				local var_524_8 = arg_521_1:FormatText(StoryNameCfg[7].name)

				arg_521_1.leftNameTxt_.text = var_524_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_521_1.leftNameTxt_.transform)

				arg_521_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_521_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_521_1:RecordName(arg_521_1.leftNameTxt_.text)
				SetActive(arg_521_1.iconTrs_.gameObject, true)
				arg_521_1.iconController_:SetSelectedState("hero")

				arg_521_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_521_1.callingController_:SetSelectedState("normal")

				arg_521_1.keyicon_.color = Color.New(1, 1, 1)
				arg_521_1.icon_.color = Color.New(1, 1, 1)

				local var_524_9 = arg_521_1:GetWordFromCfg(111041125)
				local var_524_10 = arg_521_1:FormatText(var_524_9.content)

				arg_521_1.text_.text = var_524_10

				LuaForUtil.ClearLinePrefixSymbol(arg_521_1.text_)

				local var_524_11 = 10
				local var_524_12 = utf8.len(var_524_10)
				local var_524_13 = var_524_11 <= 0 and var_524_7 or var_524_7 * (var_524_12 / var_524_11)

				if var_524_13 > 0 and var_524_7 < var_524_13 then
					arg_521_1.talkMaxDuration = var_524_13

					if var_524_13 + var_524_6 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_13 + var_524_6
					end
				end

				arg_521_1.text_.text = var_524_10
				arg_521_1.typewritter.percent = 0

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(false)
				arg_521_1:RecordContent(arg_521_1.text_.text)
			end

			local var_524_14 = math.max(var_524_7, arg_521_1.talkMaxDuration)

			if var_524_6 <= arg_521_1.time_ and arg_521_1.time_ < var_524_6 + var_524_14 then
				arg_521_1.typewritter.percent = (arg_521_1.time_ - var_524_6) / var_524_14

				arg_521_1.typewritter:SetDirty()
			end

			if arg_521_1.time_ >= var_524_6 + var_524_14 and arg_521_1.time_ < var_524_6 + var_524_14 + arg_524_0 then
				arg_521_1.typewritter.percent = 1

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(true)
			end
		end

		arg_521_1.nodeConfigList_ = {}

		arg_521_1:InitPlayNodeList()
	end,
	Play111041126 = function(arg_525_0, arg_525_1)
		arg_525_1.time_ = 0
		arg_525_1.frameCnt_ = 0
		arg_525_1.state_ = "playing"
		arg_525_1.curTalkId_ = 111041126
		arg_525_1.duration_ = 4.03

		local var_525_0 = {
			ja = 4.033,
			ko = 1.999999999999,
			zh = 2.466,
			en = 1.999999999999
		}
		local var_525_1 = manager.audio:GetLocalizationFlag()

		if var_525_0[var_525_1] ~= nil then
			arg_525_1.duration_ = var_525_0[var_525_1]
		end

		SetActive(arg_525_1.tipsGo_, false)

		function arg_525_1.onSingleLineFinish_()
			arg_525_1.onSingleLineUpdate_ = nil
			arg_525_1.onSingleLineFinish_ = nil
			arg_525_1.state_ = "waiting"
		end

		function arg_525_1.playNext_(arg_527_0)
			if arg_527_0 == 1 then
				arg_525_0:Play111041127(arg_525_1)
			end
		end

		function arg_525_1.onSingleLineUpdate_(arg_528_0)
			local var_528_0 = 0

			if var_528_0 < arg_525_1.time_ and arg_525_1.time_ <= var_528_0 + arg_528_0 then
				arg_525_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_528_1 = arg_525_1.actors_["1094ui_story"]
			local var_528_2 = 0

			if var_528_2 < arg_525_1.time_ and arg_525_1.time_ <= var_528_2 + arg_528_0 and not isNil(var_528_1) and arg_525_1.var_.characterEffect1094ui_story == nil then
				arg_525_1.var_.characterEffect1094ui_story = var_528_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_528_3 = 0.2

			if var_528_2 <= arg_525_1.time_ and arg_525_1.time_ < var_528_2 + var_528_3 and not isNil(var_528_1) then
				local var_528_4 = (arg_525_1.time_ - var_528_2) / var_528_3

				if arg_525_1.var_.characterEffect1094ui_story and not isNil(var_528_1) then
					arg_525_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_525_1.time_ >= var_528_2 + var_528_3 and arg_525_1.time_ < var_528_2 + var_528_3 + arg_528_0 and not isNil(var_528_1) and arg_525_1.var_.characterEffect1094ui_story then
				arg_525_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_528_5 = 0
			local var_528_6 = 0.15

			if var_528_5 < arg_525_1.time_ and arg_525_1.time_ <= var_528_5 + arg_528_0 then
				arg_525_1.talkMaxDuration = 0
				arg_525_1.dialogCg_.alpha = 1

				arg_525_1.dialog_:SetActive(true)
				SetActive(arg_525_1.leftNameGo_, true)

				local var_528_7 = arg_525_1:FormatText(StoryNameCfg[181].name)

				arg_525_1.leftNameTxt_.text = var_528_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_525_1.leftNameTxt_.transform)

				arg_525_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_525_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_525_1:RecordName(arg_525_1.leftNameTxt_.text)
				SetActive(arg_525_1.iconTrs_.gameObject, false)
				arg_525_1.callingController_:SetSelectedState("normal")

				local var_528_8 = arg_525_1:GetWordFromCfg(111041126)
				local var_528_9 = arg_525_1:FormatText(var_528_8.content)

				arg_525_1.text_.text = var_528_9

				LuaForUtil.ClearLinePrefixSymbol(arg_525_1.text_)

				local var_528_10 = 6
				local var_528_11 = utf8.len(var_528_9)
				local var_528_12 = var_528_10 <= 0 and var_528_6 or var_528_6 * (var_528_11 / var_528_10)

				if var_528_12 > 0 and var_528_6 < var_528_12 then
					arg_525_1.talkMaxDuration = var_528_12

					if var_528_12 + var_528_5 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_12 + var_528_5
					end
				end

				arg_525_1.text_.text = var_528_9
				arg_525_1.typewritter.percent = 0

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111041", "111041126", "story_v_out_111041.awb") ~= 0 then
					local var_528_13 = manager.audio:GetVoiceLength("story_v_out_111041", "111041126", "story_v_out_111041.awb") / 1000

					if var_528_13 + var_528_5 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_13 + var_528_5
					end

					if var_528_8.prefab_name ~= "" and arg_525_1.actors_[var_528_8.prefab_name] ~= nil then
						local var_528_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_525_1.actors_[var_528_8.prefab_name].transform, "story_v_out_111041", "111041126", "story_v_out_111041.awb")

						arg_525_1:RecordAudio("111041126", var_528_14)
						arg_525_1:RecordAudio("111041126", var_528_14)
					else
						arg_525_1:AudioAction("play", "voice", "story_v_out_111041", "111041126", "story_v_out_111041.awb")
					end

					arg_525_1:RecordHistoryTalkVoice("story_v_out_111041", "111041126", "story_v_out_111041.awb")
				end

				arg_525_1:RecordContent(arg_525_1.text_.text)
			end

			local var_528_15 = math.max(var_528_6, arg_525_1.talkMaxDuration)

			if var_528_5 <= arg_525_1.time_ and arg_525_1.time_ < var_528_5 + var_528_15 then
				arg_525_1.typewritter.percent = (arg_525_1.time_ - var_528_5) / var_528_15

				arg_525_1.typewritter:SetDirty()
			end

			if arg_525_1.time_ >= var_528_5 + var_528_15 and arg_525_1.time_ < var_528_5 + var_528_15 + arg_528_0 then
				arg_525_1.typewritter.percent = 1

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(true)
			end
		end

		arg_525_1.nodeConfigList_ = {}

		arg_525_1:InitPlayNodeList()
	end,
	Play111041127 = function(arg_529_0, arg_529_1)
		arg_529_1.time_ = 0
		arg_529_1.frameCnt_ = 0
		arg_529_1.state_ = "playing"
		arg_529_1.curTalkId_ = 111041127
		arg_529_1.duration_ = 5

		SetActive(arg_529_1.tipsGo_, false)

		function arg_529_1.onSingleLineFinish_()
			arg_529_1.onSingleLineUpdate_ = nil
			arg_529_1.onSingleLineFinish_ = nil
			arg_529_1.state_ = "waiting"
		end

		function arg_529_1.playNext_(arg_531_0)
			if arg_531_0 == 1 then
				arg_529_0:Play111041128(arg_529_1)
			end
		end

		function arg_529_1.onSingleLineUpdate_(arg_532_0)
			local var_532_0 = arg_529_1.actors_["1094ui_story"]
			local var_532_1 = 0

			if var_532_1 < arg_529_1.time_ and arg_529_1.time_ <= var_532_1 + arg_532_0 and not isNil(var_532_0) and arg_529_1.var_.characterEffect1094ui_story == nil then
				arg_529_1.var_.characterEffect1094ui_story = var_532_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_532_2 = 0.2

			if var_532_1 <= arg_529_1.time_ and arg_529_1.time_ < var_532_1 + var_532_2 and not isNil(var_532_0) then
				local var_532_3 = (arg_529_1.time_ - var_532_1) / var_532_2

				if arg_529_1.var_.characterEffect1094ui_story and not isNil(var_532_0) then
					local var_532_4 = Mathf.Lerp(0, 0.5, var_532_3)

					arg_529_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_529_1.var_.characterEffect1094ui_story.fillRatio = var_532_4
				end
			end

			if arg_529_1.time_ >= var_532_1 + var_532_2 and arg_529_1.time_ < var_532_1 + var_532_2 + arg_532_0 and not isNil(var_532_0) and arg_529_1.var_.characterEffect1094ui_story then
				local var_532_5 = 0.5

				arg_529_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_529_1.var_.characterEffect1094ui_story.fillRatio = var_532_5
			end

			local var_532_6 = 0
			local var_532_7 = 0.075

			if var_532_6 < arg_529_1.time_ and arg_529_1.time_ <= var_532_6 + arg_532_0 then
				arg_529_1.talkMaxDuration = 0
				arg_529_1.dialogCg_.alpha = 1

				arg_529_1.dialog_:SetActive(true)
				SetActive(arg_529_1.leftNameGo_, true)

				local var_532_8 = arg_529_1:FormatText(StoryNameCfg[7].name)

				arg_529_1.leftNameTxt_.text = var_532_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_529_1.leftNameTxt_.transform)

				arg_529_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_529_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_529_1:RecordName(arg_529_1.leftNameTxt_.text)
				SetActive(arg_529_1.iconTrs_.gameObject, true)
				arg_529_1.iconController_:SetSelectedState("hero")

				arg_529_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_529_1.callingController_:SetSelectedState("normal")

				arg_529_1.keyicon_.color = Color.New(1, 1, 1)
				arg_529_1.icon_.color = Color.New(1, 1, 1)

				local var_532_9 = arg_529_1:GetWordFromCfg(111041127)
				local var_532_10 = arg_529_1:FormatText(var_532_9.content)

				arg_529_1.text_.text = var_532_10

				LuaForUtil.ClearLinePrefixSymbol(arg_529_1.text_)

				local var_532_11 = 3
				local var_532_12 = utf8.len(var_532_10)
				local var_532_13 = var_532_11 <= 0 and var_532_7 or var_532_7 * (var_532_12 / var_532_11)

				if var_532_13 > 0 and var_532_7 < var_532_13 then
					arg_529_1.talkMaxDuration = var_532_13

					if var_532_13 + var_532_6 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_13 + var_532_6
					end
				end

				arg_529_1.text_.text = var_532_10
				arg_529_1.typewritter.percent = 0

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(false)
				arg_529_1:RecordContent(arg_529_1.text_.text)
			end

			local var_532_14 = math.max(var_532_7, arg_529_1.talkMaxDuration)

			if var_532_6 <= arg_529_1.time_ and arg_529_1.time_ < var_532_6 + var_532_14 then
				arg_529_1.typewritter.percent = (arg_529_1.time_ - var_532_6) / var_532_14

				arg_529_1.typewritter:SetDirty()
			end

			if arg_529_1.time_ >= var_532_6 + var_532_14 and arg_529_1.time_ < var_532_6 + var_532_14 + arg_532_0 then
				arg_529_1.typewritter.percent = 1

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(true)
			end
		end

		arg_529_1.nodeConfigList_ = {}

		arg_529_1:InitPlayNodeList()
	end,
	Play111041128 = function(arg_533_0, arg_533_1)
		arg_533_1.time_ = 0
		arg_533_1.frameCnt_ = 0
		arg_533_1.state_ = "playing"
		arg_533_1.curTalkId_ = 111041128
		arg_533_1.duration_ = 5.77

		local var_533_0 = {
			ja = 5.766,
			ko = 2.233,
			zh = 2.1,
			en = 1.999999999999
		}
		local var_533_1 = manager.audio:GetLocalizationFlag()

		if var_533_0[var_533_1] ~= nil then
			arg_533_1.duration_ = var_533_0[var_533_1]
		end

		SetActive(arg_533_1.tipsGo_, false)

		function arg_533_1.onSingleLineFinish_()
			arg_533_1.onSingleLineUpdate_ = nil
			arg_533_1.onSingleLineFinish_ = nil
			arg_533_1.state_ = "waiting"
		end

		function arg_533_1.playNext_(arg_535_0)
			if arg_535_0 == 1 then
				arg_533_0:Play111041129(arg_533_1)
			end
		end

		function arg_533_1.onSingleLineUpdate_(arg_536_0)
			local var_536_0 = 0

			if var_536_0 < arg_533_1.time_ and arg_533_1.time_ <= var_536_0 + arg_536_0 then
				arg_533_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094actionlink/1094action452")
			end

			local var_536_1 = 0

			if var_536_1 < arg_533_1.time_ and arg_533_1.time_ <= var_536_1 + arg_536_0 then
				arg_533_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_536_2 = arg_533_1.actors_["1094ui_story"]
			local var_536_3 = 0

			if var_536_3 < arg_533_1.time_ and arg_533_1.time_ <= var_536_3 + arg_536_0 and not isNil(var_536_2) and arg_533_1.var_.characterEffect1094ui_story == nil then
				arg_533_1.var_.characterEffect1094ui_story = var_536_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_536_4 = 0.2

			if var_536_3 <= arg_533_1.time_ and arg_533_1.time_ < var_536_3 + var_536_4 and not isNil(var_536_2) then
				local var_536_5 = (arg_533_1.time_ - var_536_3) / var_536_4

				if arg_533_1.var_.characterEffect1094ui_story and not isNil(var_536_2) then
					arg_533_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_533_1.time_ >= var_536_3 + var_536_4 and arg_533_1.time_ < var_536_3 + var_536_4 + arg_536_0 and not isNil(var_536_2) and arg_533_1.var_.characterEffect1094ui_story then
				arg_533_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_536_6 = 0
			local var_536_7 = 0.0666666666666667

			if var_536_6 < arg_533_1.time_ and arg_533_1.time_ <= var_536_6 + arg_536_0 then
				arg_533_1.talkMaxDuration = 0
				arg_533_1.dialogCg_.alpha = 1

				arg_533_1.dialog_:SetActive(true)
				SetActive(arg_533_1.leftNameGo_, true)

				local var_536_8 = arg_533_1:FormatText(StoryNameCfg[181].name)

				arg_533_1.leftNameTxt_.text = var_536_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_533_1.leftNameTxt_.transform)

				arg_533_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_533_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_533_1:RecordName(arg_533_1.leftNameTxt_.text)
				SetActive(arg_533_1.iconTrs_.gameObject, false)
				arg_533_1.callingController_:SetSelectedState("normal")

				local var_536_9 = arg_533_1:GetWordFromCfg(111041128)
				local var_536_10 = arg_533_1:FormatText(var_536_9.content)

				arg_533_1.text_.text = var_536_10

				LuaForUtil.ClearLinePrefixSymbol(arg_533_1.text_)

				local var_536_11 = 10
				local var_536_12 = utf8.len(var_536_10)
				local var_536_13 = var_536_11 <= 0 and var_536_7 or var_536_7 * (var_536_12 / var_536_11)

				if var_536_13 > 0 and var_536_7 < var_536_13 then
					arg_533_1.talkMaxDuration = var_536_13

					if var_536_13 + var_536_6 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_13 + var_536_6
					end
				end

				arg_533_1.text_.text = var_536_10
				arg_533_1.typewritter.percent = 0

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111041", "111041128", "story_v_out_111041.awb") ~= 0 then
					local var_536_14 = manager.audio:GetVoiceLength("story_v_out_111041", "111041128", "story_v_out_111041.awb") / 1000

					if var_536_14 + var_536_6 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_14 + var_536_6
					end

					if var_536_9.prefab_name ~= "" and arg_533_1.actors_[var_536_9.prefab_name] ~= nil then
						local var_536_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_533_1.actors_[var_536_9.prefab_name].transform, "story_v_out_111041", "111041128", "story_v_out_111041.awb")

						arg_533_1:RecordAudio("111041128", var_536_15)
						arg_533_1:RecordAudio("111041128", var_536_15)
					else
						arg_533_1:AudioAction("play", "voice", "story_v_out_111041", "111041128", "story_v_out_111041.awb")
					end

					arg_533_1:RecordHistoryTalkVoice("story_v_out_111041", "111041128", "story_v_out_111041.awb")
				end

				arg_533_1:RecordContent(arg_533_1.text_.text)
			end

			local var_536_16 = math.max(var_536_7, arg_533_1.talkMaxDuration)

			if var_536_6 <= arg_533_1.time_ and arg_533_1.time_ < var_536_6 + var_536_16 then
				arg_533_1.typewritter.percent = (arg_533_1.time_ - var_536_6) / var_536_16

				arg_533_1.typewritter:SetDirty()
			end

			if arg_533_1.time_ >= var_536_6 + var_536_16 and arg_533_1.time_ < var_536_6 + var_536_16 + arg_536_0 then
				arg_533_1.typewritter.percent = 1

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(true)
			end
		end

		arg_533_1.nodeConfigList_ = {}

		arg_533_1:InitPlayNodeList()
	end,
	Play111041129 = function(arg_537_0, arg_537_1)
		arg_537_1.time_ = 0
		arg_537_1.frameCnt_ = 0
		arg_537_1.state_ = "playing"
		arg_537_1.curTalkId_ = 111041129
		arg_537_1.duration_ = 5

		SetActive(arg_537_1.tipsGo_, false)

		function arg_537_1.onSingleLineFinish_()
			arg_537_1.onSingleLineUpdate_ = nil
			arg_537_1.onSingleLineFinish_ = nil
			arg_537_1.state_ = "waiting"
		end

		function arg_537_1.playNext_(arg_539_0)
			if arg_539_0 == 1 then
				arg_537_0:Play111041130(arg_537_1)
			end
		end

		function arg_537_1.onSingleLineUpdate_(arg_540_0)
			local var_540_0 = arg_537_1.actors_["1094ui_story"]
			local var_540_1 = 0

			if var_540_1 < arg_537_1.time_ and arg_537_1.time_ <= var_540_1 + arg_540_0 and not isNil(var_540_0) and arg_537_1.var_.characterEffect1094ui_story == nil then
				arg_537_1.var_.characterEffect1094ui_story = var_540_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_540_2 = 0.2

			if var_540_1 <= arg_537_1.time_ and arg_537_1.time_ < var_540_1 + var_540_2 and not isNil(var_540_0) then
				local var_540_3 = (arg_537_1.time_ - var_540_1) / var_540_2

				if arg_537_1.var_.characterEffect1094ui_story and not isNil(var_540_0) then
					local var_540_4 = Mathf.Lerp(0, 0.5, var_540_3)

					arg_537_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_537_1.var_.characterEffect1094ui_story.fillRatio = var_540_4
				end
			end

			if arg_537_1.time_ >= var_540_1 + var_540_2 and arg_537_1.time_ < var_540_1 + var_540_2 + arg_540_0 and not isNil(var_540_0) and arg_537_1.var_.characterEffect1094ui_story then
				local var_540_5 = 0.5

				arg_537_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_537_1.var_.characterEffect1094ui_story.fillRatio = var_540_5
			end

			local var_540_6 = 0
			local var_540_7 = 0.65

			if var_540_6 < arg_537_1.time_ and arg_537_1.time_ <= var_540_6 + arg_540_0 then
				arg_537_1.talkMaxDuration = 0
				arg_537_1.dialogCg_.alpha = 1

				arg_537_1.dialog_:SetActive(true)
				SetActive(arg_537_1.leftNameGo_, true)

				local var_540_8 = arg_537_1:FormatText(StoryNameCfg[7].name)

				arg_537_1.leftNameTxt_.text = var_540_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_537_1.leftNameTxt_.transform)

				arg_537_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_537_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_537_1:RecordName(arg_537_1.leftNameTxt_.text)
				SetActive(arg_537_1.iconTrs_.gameObject, true)
				arg_537_1.iconController_:SetSelectedState("hero")

				arg_537_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_537_1.callingController_:SetSelectedState("normal")

				arg_537_1.keyicon_.color = Color.New(1, 1, 1)
				arg_537_1.icon_.color = Color.New(1, 1, 1)

				local var_540_9 = arg_537_1:GetWordFromCfg(111041129)
				local var_540_10 = arg_537_1:FormatText(var_540_9.content)

				arg_537_1.text_.text = var_540_10

				LuaForUtil.ClearLinePrefixSymbol(arg_537_1.text_)

				local var_540_11 = 26
				local var_540_12 = utf8.len(var_540_10)
				local var_540_13 = var_540_11 <= 0 and var_540_7 or var_540_7 * (var_540_12 / var_540_11)

				if var_540_13 > 0 and var_540_7 < var_540_13 then
					arg_537_1.talkMaxDuration = var_540_13

					if var_540_13 + var_540_6 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_13 + var_540_6
					end
				end

				arg_537_1.text_.text = var_540_10
				arg_537_1.typewritter.percent = 0

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(false)
				arg_537_1:RecordContent(arg_537_1.text_.text)
			end

			local var_540_14 = math.max(var_540_7, arg_537_1.talkMaxDuration)

			if var_540_6 <= arg_537_1.time_ and arg_537_1.time_ < var_540_6 + var_540_14 then
				arg_537_1.typewritter.percent = (arg_537_1.time_ - var_540_6) / var_540_14

				arg_537_1.typewritter:SetDirty()
			end

			if arg_537_1.time_ >= var_540_6 + var_540_14 and arg_537_1.time_ < var_540_6 + var_540_14 + arg_540_0 then
				arg_537_1.typewritter.percent = 1

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(true)
			end
		end

		arg_537_1.nodeConfigList_ = {}

		arg_537_1:InitPlayNodeList()
	end,
	Play111041130 = function(arg_541_0, arg_541_1)
		arg_541_1.time_ = 0
		arg_541_1.frameCnt_ = 0
		arg_541_1.state_ = "playing"
		arg_541_1.curTalkId_ = 111041130
		arg_541_1.duration_ = 5

		SetActive(arg_541_1.tipsGo_, false)

		function arg_541_1.onSingleLineFinish_()
			arg_541_1.onSingleLineUpdate_ = nil
			arg_541_1.onSingleLineFinish_ = nil
			arg_541_1.state_ = "waiting"
		end

		function arg_541_1.playNext_(arg_543_0)
			if arg_543_0 == 1 then
				arg_541_0:Play111041131(arg_541_1)
			end
		end

		function arg_541_1.onSingleLineUpdate_(arg_544_0)
			local var_544_0 = 0
			local var_544_1 = 0.4

			if var_544_0 < arg_541_1.time_ and arg_541_1.time_ <= var_544_0 + arg_544_0 then
				arg_541_1.talkMaxDuration = 0
				arg_541_1.dialogCg_.alpha = 1

				arg_541_1.dialog_:SetActive(true)
				SetActive(arg_541_1.leftNameGo_, true)

				local var_544_2 = arg_541_1:FormatText(StoryNameCfg[7].name)

				arg_541_1.leftNameTxt_.text = var_544_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_541_1.leftNameTxt_.transform)

				arg_541_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_541_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_541_1:RecordName(arg_541_1.leftNameTxt_.text)
				SetActive(arg_541_1.iconTrs_.gameObject, true)
				arg_541_1.iconController_:SetSelectedState("hero")

				arg_541_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_541_1.callingController_:SetSelectedState("normal")

				arg_541_1.keyicon_.color = Color.New(1, 1, 1)
				arg_541_1.icon_.color = Color.New(1, 1, 1)

				local var_544_3 = arg_541_1:GetWordFromCfg(111041130)
				local var_544_4 = arg_541_1:FormatText(var_544_3.content)

				arg_541_1.text_.text = var_544_4

				LuaForUtil.ClearLinePrefixSymbol(arg_541_1.text_)

				local var_544_5 = 16
				local var_544_6 = utf8.len(var_544_4)
				local var_544_7 = var_544_5 <= 0 and var_544_1 or var_544_1 * (var_544_6 / var_544_5)

				if var_544_7 > 0 and var_544_1 < var_544_7 then
					arg_541_1.talkMaxDuration = var_544_7

					if var_544_7 + var_544_0 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_7 + var_544_0
					end
				end

				arg_541_1.text_.text = var_544_4
				arg_541_1.typewritter.percent = 0

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(false)
				arg_541_1:RecordContent(arg_541_1.text_.text)
			end

			local var_544_8 = math.max(var_544_1, arg_541_1.talkMaxDuration)

			if var_544_0 <= arg_541_1.time_ and arg_541_1.time_ < var_544_0 + var_544_8 then
				arg_541_1.typewritter.percent = (arg_541_1.time_ - var_544_0) / var_544_8

				arg_541_1.typewritter:SetDirty()
			end

			if arg_541_1.time_ >= var_544_0 + var_544_8 and arg_541_1.time_ < var_544_0 + var_544_8 + arg_544_0 then
				arg_541_1.typewritter.percent = 1

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(true)
			end
		end

		arg_541_1.nodeConfigList_ = {}

		arg_541_1:InitPlayNodeList()
	end,
	Play111041131 = function(arg_545_0, arg_545_1)
		arg_545_1.time_ = 0
		arg_545_1.frameCnt_ = 0
		arg_545_1.state_ = "playing"
		arg_545_1.curTalkId_ = 111041131
		arg_545_1.duration_ = 3.2

		local var_545_0 = {
			ja = 3.2,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
		}
		local var_545_1 = manager.audio:GetLocalizationFlag()

		if var_545_0[var_545_1] ~= nil then
			arg_545_1.duration_ = var_545_0[var_545_1]
		end

		SetActive(arg_545_1.tipsGo_, false)

		function arg_545_1.onSingleLineFinish_()
			arg_545_1.onSingleLineUpdate_ = nil
			arg_545_1.onSingleLineFinish_ = nil
			arg_545_1.state_ = "waiting"
		end

		function arg_545_1.playNext_(arg_547_0)
			if arg_547_0 == 1 then
				arg_545_0:Play111041132(arg_545_1)
			end
		end

		function arg_545_1.onSingleLineUpdate_(arg_548_0)
			local var_548_0 = 0

			if var_548_0 < arg_545_1.time_ and arg_545_1.time_ <= var_548_0 + arg_548_0 then
				arg_545_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action2_2")
			end

			local var_548_1 = 0

			if var_548_1 < arg_545_1.time_ and arg_545_1.time_ <= var_548_1 + arg_548_0 then
				arg_545_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1301cva")
			end

			local var_548_2 = arg_545_1.actors_["1094ui_story"]
			local var_548_3 = 0

			if var_548_3 < arg_545_1.time_ and arg_545_1.time_ <= var_548_3 + arg_548_0 and not isNil(var_548_2) and arg_545_1.var_.characterEffect1094ui_story == nil then
				arg_545_1.var_.characterEffect1094ui_story = var_548_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_548_4 = 0.2

			if var_548_3 <= arg_545_1.time_ and arg_545_1.time_ < var_548_3 + var_548_4 and not isNil(var_548_2) then
				local var_548_5 = (arg_545_1.time_ - var_548_3) / var_548_4

				if arg_545_1.var_.characterEffect1094ui_story and not isNil(var_548_2) then
					arg_545_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_545_1.time_ >= var_548_3 + var_548_4 and arg_545_1.time_ < var_548_3 + var_548_4 + arg_548_0 and not isNil(var_548_2) and arg_545_1.var_.characterEffect1094ui_story then
				arg_545_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_548_6 = 0
			local var_548_7 = 0.1

			if var_548_6 < arg_545_1.time_ and arg_545_1.time_ <= var_548_6 + arg_548_0 then
				arg_545_1.talkMaxDuration = 0
				arg_545_1.dialogCg_.alpha = 1

				arg_545_1.dialog_:SetActive(true)
				SetActive(arg_545_1.leftNameGo_, true)

				local var_548_8 = arg_545_1:FormatText(StoryNameCfg[181].name)

				arg_545_1.leftNameTxt_.text = var_548_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_545_1.leftNameTxt_.transform)

				arg_545_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_545_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_545_1:RecordName(arg_545_1.leftNameTxt_.text)
				SetActive(arg_545_1.iconTrs_.gameObject, false)
				arg_545_1.callingController_:SetSelectedState("normal")

				local var_548_9 = arg_545_1:GetWordFromCfg(111041131)
				local var_548_10 = arg_545_1:FormatText(var_548_9.content)

				arg_545_1.text_.text = var_548_10

				LuaForUtil.ClearLinePrefixSymbol(arg_545_1.text_)

				local var_548_11 = 4
				local var_548_12 = utf8.len(var_548_10)
				local var_548_13 = var_548_11 <= 0 and var_548_7 or var_548_7 * (var_548_12 / var_548_11)

				if var_548_13 > 0 and var_548_7 < var_548_13 then
					arg_545_1.talkMaxDuration = var_548_13

					if var_548_13 + var_548_6 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_13 + var_548_6
					end
				end

				arg_545_1.text_.text = var_548_10
				arg_545_1.typewritter.percent = 0

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111041", "111041131", "story_v_out_111041.awb") ~= 0 then
					local var_548_14 = manager.audio:GetVoiceLength("story_v_out_111041", "111041131", "story_v_out_111041.awb") / 1000

					if var_548_14 + var_548_6 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_14 + var_548_6
					end

					if var_548_9.prefab_name ~= "" and arg_545_1.actors_[var_548_9.prefab_name] ~= nil then
						local var_548_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_545_1.actors_[var_548_9.prefab_name].transform, "story_v_out_111041", "111041131", "story_v_out_111041.awb")

						arg_545_1:RecordAudio("111041131", var_548_15)
						arg_545_1:RecordAudio("111041131", var_548_15)
					else
						arg_545_1:AudioAction("play", "voice", "story_v_out_111041", "111041131", "story_v_out_111041.awb")
					end

					arg_545_1:RecordHistoryTalkVoice("story_v_out_111041", "111041131", "story_v_out_111041.awb")
				end

				arg_545_1:RecordContent(arg_545_1.text_.text)
			end

			local var_548_16 = math.max(var_548_7, arg_545_1.talkMaxDuration)

			if var_548_6 <= arg_545_1.time_ and arg_545_1.time_ < var_548_6 + var_548_16 then
				arg_545_1.typewritter.percent = (arg_545_1.time_ - var_548_6) / var_548_16

				arg_545_1.typewritter:SetDirty()
			end

			if arg_545_1.time_ >= var_548_6 + var_548_16 and arg_545_1.time_ < var_548_6 + var_548_16 + arg_548_0 then
				arg_545_1.typewritter.percent = 1

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(true)
			end
		end

		arg_545_1.nodeConfigList_ = {}

		arg_545_1:InitPlayNodeList()
	end,
	Play111041132 = function(arg_549_0, arg_549_1)
		arg_549_1.time_ = 0
		arg_549_1.frameCnt_ = 0
		arg_549_1.state_ = "playing"
		arg_549_1.curTalkId_ = 111041132
		arg_549_1.duration_ = 5

		SetActive(arg_549_1.tipsGo_, false)

		function arg_549_1.onSingleLineFinish_()
			arg_549_1.onSingleLineUpdate_ = nil
			arg_549_1.onSingleLineFinish_ = nil
			arg_549_1.state_ = "waiting"
			arg_549_1.auto_ = false
		end

		function arg_549_1.playNext_(arg_551_0)
			arg_549_1.onStoryFinished_()
		end

		function arg_549_1.onSingleLineUpdate_(arg_552_0)
			local var_552_0 = arg_549_1.actors_["1094ui_story"].transform
			local var_552_1 = 0

			if var_552_1 < arg_549_1.time_ and arg_549_1.time_ <= var_552_1 + arg_552_0 then
				arg_549_1.var_.moveOldPos1094ui_story = var_552_0.localPosition
			end

			local var_552_2 = 0.001

			if var_552_1 <= arg_549_1.time_ and arg_549_1.time_ < var_552_1 + var_552_2 then
				local var_552_3 = (arg_549_1.time_ - var_552_1) / var_552_2
				local var_552_4 = Vector3.New(0, 100, 0)

				var_552_0.localPosition = Vector3.Lerp(arg_549_1.var_.moveOldPos1094ui_story, var_552_4, var_552_3)

				local var_552_5 = manager.ui.mainCamera.transform.position - var_552_0.position

				var_552_0.forward = Vector3.New(var_552_5.x, var_552_5.y, var_552_5.z)

				local var_552_6 = var_552_0.localEulerAngles

				var_552_6.z = 0
				var_552_6.x = 0
				var_552_0.localEulerAngles = var_552_6
			end

			if arg_549_1.time_ >= var_552_1 + var_552_2 and arg_549_1.time_ < var_552_1 + var_552_2 + arg_552_0 then
				var_552_0.localPosition = Vector3.New(0, 100, 0)

				local var_552_7 = manager.ui.mainCamera.transform.position - var_552_0.position

				var_552_0.forward = Vector3.New(var_552_7.x, var_552_7.y, var_552_7.z)

				local var_552_8 = var_552_0.localEulerAngles

				var_552_8.z = 0
				var_552_8.x = 0
				var_552_0.localEulerAngles = var_552_8
			end

			local var_552_9 = 0
			local var_552_10 = 0.85

			if var_552_9 < arg_549_1.time_ and arg_549_1.time_ <= var_552_9 + arg_552_0 then
				arg_549_1.talkMaxDuration = 0
				arg_549_1.dialogCg_.alpha = 1

				arg_549_1.dialog_:SetActive(true)
				SetActive(arg_549_1.leftNameGo_, false)

				arg_549_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_549_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_549_1:RecordName(arg_549_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_549_1.iconTrs_.gameObject, false)
				arg_549_1.callingController_:SetSelectedState("normal")

				local var_552_11 = arg_549_1:GetWordFromCfg(111041132)
				local var_552_12 = arg_549_1:FormatText(var_552_11.content)

				arg_549_1.text_.text = var_552_12

				LuaForUtil.ClearLinePrefixSymbol(arg_549_1.text_)

				local var_552_13 = 34
				local var_552_14 = utf8.len(var_552_12)
				local var_552_15 = var_552_13 <= 0 and var_552_10 or var_552_10 * (var_552_14 / var_552_13)

				if var_552_15 > 0 and var_552_10 < var_552_15 then
					arg_549_1.talkMaxDuration = var_552_15

					if var_552_15 + var_552_9 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_15 + var_552_9
					end
				end

				arg_549_1.text_.text = var_552_12
				arg_549_1.typewritter.percent = 0

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(false)
				arg_549_1:RecordContent(arg_549_1.text_.text)
			end

			local var_552_16 = math.max(var_552_10, arg_549_1.talkMaxDuration)

			if var_552_9 <= arg_549_1.time_ and arg_549_1.time_ < var_552_9 + var_552_16 then
				arg_549_1.typewritter.percent = (arg_549_1.time_ - var_552_9) / var_552_16

				arg_549_1.typewritter:SetDirty()
			end

			if arg_549_1.time_ >= var_552_9 + var_552_16 and arg_549_1.time_ < var_552_9 + var_552_16 + arg_552_0 then
				arg_549_1.typewritter.percent = 1

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(true)
			end
		end

		arg_549_1.nodeConfigList_ = {
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

		arg_549_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/D09",
		"TextureConfig/Background/D06_1",
		"TextureConfig/Background/AS0103",
		"TextureConfig/Background/D999",
		"TextureConfig/Background/ST01a",
		"TextureConfig/Background/B13a",
		"TextureConfig/Background/ST07a"
	},
	voices = {
		"story_v_out_111041.awb"
	}
}
