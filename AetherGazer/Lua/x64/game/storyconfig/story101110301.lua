return {
	Play111031001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 111031001
		arg_1_1.duration_ = 2

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play111031002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				arg_1_1.fswbg_:SetActive(true)
				arg_1_1.dialog_:SetActive(false)

				arg_1_1.fswtw_.percent = 0

				local var_4_1 = arg_1_1:GetWordFromCfg(111031001)
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

			local var_4_3 = 0.2

			if var_4_3 < arg_1_1.time_ and arg_1_1.time_ <= var_4_3 + arg_4_0 then
				arg_1_1.var_.oldValueTypewriter = arg_1_1.fswtw_.percent

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_4 = 9
			local var_4_5 = 0.54
			local var_4_6 = arg_1_1:GetWordFromCfg(111031001)
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
			local var_4_21 = 1
			local var_4_22 = manager.audio:GetVoiceLength("story_v_out_111031", "111031001", "story_v_out_111031.awb") / 1000

			if var_4_22 > 0 and var_4_21 < var_4_22 and var_4_22 + var_4_20 > arg_1_1.duration_ then
				local var_4_23 = var_4_22

				arg_1_1.duration_ = var_4_22 + var_4_20
			end

			if var_4_20 < arg_1_1.time_ and arg_1_1.time_ <= var_4_20 + arg_4_0 then
				local var_4_24 = "play"
				local var_4_25 = "voice"

				arg_1_1:AudioAction(var_4_24, var_4_25, "story_v_out_111031", "111031001", "story_v_out_111031.awb")
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play111031002 = function(arg_6_0, arg_6_1)
		arg_6_1.time_ = 0
		arg_6_1.frameCnt_ = 0
		arg_6_1.state_ = "playing"
		arg_6_1.curTalkId_ = 111031002
		arg_6_1.duration_ = 2

		SetActive(arg_6_1.tipsGo_, false)

		function arg_6_1.onSingleLineFinish_()
			arg_6_1.onSingleLineUpdate_ = nil
			arg_6_1.onSingleLineFinish_ = nil
			arg_6_1.state_ = "waiting"
		end

		function arg_6_1.playNext_(arg_8_0)
			if arg_8_0 == 1 then
				arg_6_0:Play111031003(arg_6_1)
			end
		end

		function arg_6_1.onSingleLineUpdate_(arg_9_0)
			local var_9_0 = 0

			if var_9_0 < arg_6_1.time_ and arg_6_1.time_ <= var_9_0 + arg_9_0 then
				arg_6_1.var_.oldValueTypewriter = arg_6_1.fswtw_.percent

				SetActive(arg_6_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_6_1:ShowNextGo(false)
			end

			local var_9_1 = 29
			local var_9_2 = 1.74
			local var_9_3 = arg_6_1:GetWordFromCfg(111031001)
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

			local var_9_8 = 1.74
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
			local var_9_13 = manager.audio:GetVoiceLength("story_v_out_111031", "111031002", "story_v_out_111031.awb") / 1000

			if var_9_13 > 0 and var_9_12 < var_9_13 and var_9_13 + var_9_11 > arg_6_1.duration_ then
				local var_9_14 = var_9_13

				arg_6_1.duration_ = var_9_13 + var_9_11
			end

			if var_9_11 < arg_6_1.time_ and arg_6_1.time_ <= var_9_11 + arg_9_0 then
				local var_9_15 = "play"
				local var_9_16 = "voice"

				arg_6_1:AudioAction(var_9_15, var_9_16, "story_v_out_111031", "111031002", "story_v_out_111031.awb")
			end
		end

		arg_6_1.nodeConfigList_ = {}

		arg_6_1:InitPlayNodeList()
	end,
	Play111031003 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 111031003
		arg_10_1.duration_ = 1.26

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play111031004(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			local var_13_0 = 0

			if var_13_0 < arg_10_1.time_ and arg_10_1.time_ <= var_13_0 + arg_13_0 then
				arg_10_1.var_.oldValueTypewriter = arg_10_1.fswtw_.percent

				SetActive(arg_10_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_10_1:ShowNextGo(false)
			end

			local var_13_1 = 21
			local var_13_2 = 1.26
			local var_13_3 = arg_10_1:GetWordFromCfg(111031001)
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

			local var_13_8 = 1.26
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
			local var_13_13 = manager.audio:GetVoiceLength("story_v_out_111031", "111031003", "story_v_out_111031.awb") / 1000

			if var_13_13 > 0 and var_13_12 < var_13_13 and var_13_13 + var_13_11 > arg_10_1.duration_ then
				local var_13_14 = var_13_13

				arg_10_1.duration_ = var_13_13 + var_13_11
			end

			if var_13_11 < arg_10_1.time_ and arg_10_1.time_ <= var_13_11 + arg_13_0 then
				local var_13_15 = "play"
				local var_13_16 = "voice"

				arg_10_1:AudioAction(var_13_15, var_13_16, "story_v_out_111031", "111031003", "story_v_out_111031.awb")
			end
		end

		arg_10_1.nodeConfigList_ = {}

		arg_10_1:InitPlayNodeList()
	end,
	Play111031004 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 111031004
		arg_14_1.duration_ = 10.24

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play111031005(arg_14_1)
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
			local var_17_3 = arg_14_1:GetWordFromCfg(111031001)
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
			local var_17_12 = 10.244
			local var_17_13 = manager.audio:GetVoiceLength("story_v_out_111031", "111031004", "story_v_out_111031.awb") / 1000

			if var_17_13 > 0 and var_17_12 < var_17_13 and var_17_13 + var_17_11 > arg_14_1.duration_ then
				local var_17_14 = var_17_13

				arg_14_1.duration_ = var_17_13 + var_17_11
			end

			if var_17_11 < arg_14_1.time_ and arg_14_1.time_ <= var_17_11 + arg_17_0 then
				local var_17_15 = "play"
				local var_17_16 = "voice"

				arg_14_1:AudioAction(var_17_15, var_17_16, "story_v_out_111031", "111031004", "story_v_out_111031.awb")
			end
		end

		arg_14_1.nodeConfigList_ = {}

		arg_14_1:InitPlayNodeList()
	end,
	Play111031005 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 111031005
		arg_18_1.duration_ = 4.8

		local var_18_0 = {
			ja = 4.3,
			ko = 4.8,
			zh = 4.466,
			en = 3.566
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
				arg_18_0:Play111031006(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = "D05"

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
				local var_21_5 = arg_18_1.bgs_.D05

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
					if iter_21_0 ~= "D05" then
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

			local var_21_17 = arg_18_1.bgs_.D05
			local var_21_18 = 0

			if var_21_18 < arg_18_1.time_ and arg_18_1.time_ <= var_21_18 + arg_21_0 then
				local var_21_19 = var_21_17:GetComponent("SpriteRenderer")

				if var_21_19 then
					arg_18_1.var_.alphaOldValueD05 = var_21_19.color.a
					arg_18_1.var_.alphaMatValueD05 = var_21_19
				end

				arg_18_1.var_.alphaOldValueD05 = 0
			end

			local var_21_20 = 1.5

			if var_21_18 <= arg_18_1.time_ and arg_18_1.time_ < var_21_18 + var_21_20 then
				local var_21_21 = (arg_18_1.time_ - var_21_18) / var_21_20
				local var_21_22 = Mathf.Lerp(arg_18_1.var_.alphaOldValueD05, 1, var_21_21)

				if arg_18_1.var_.alphaMatValueD05 then
					local var_21_23 = arg_18_1.var_.alphaMatValueD05.color

					var_21_23.a = var_21_22
					arg_18_1.var_.alphaMatValueD05.color = var_21_23
				end
			end

			if arg_18_1.time_ >= var_21_18 + var_21_20 and arg_18_1.time_ < var_21_18 + var_21_20 + arg_21_0 and arg_18_1.var_.alphaMatValueD05 then
				local var_21_24 = arg_18_1.var_.alphaMatValueD05
				local var_21_25 = var_21_24.color

				var_21_25.a = 1
				var_21_24.color = var_21_25
			end

			local var_21_26 = 0

			if var_21_26 < arg_18_1.time_ and arg_18_1.time_ <= var_21_26 + arg_21_0 then
				arg_18_1.allBtn_.enabled = false
			end

			local var_21_27 = 1.5

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

			local var_21_34 = 1.5
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

				local var_21_38 = arg_18_1:GetWordFromCfg(111031005)
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

				if manager.audio:GetVoiceLength("story_v_out_111031", "111031005", "story_v_out_111031.awb") ~= 0 then
					local var_21_43 = manager.audio:GetVoiceLength("story_v_out_111031", "111031005", "story_v_out_111031.awb") / 1000

					if var_21_43 + var_21_34 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_43 + var_21_34
					end

					if var_21_38.prefab_name ~= "" and arg_18_1.actors_[var_21_38.prefab_name] ~= nil then
						local var_21_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_38.prefab_name].transform, "story_v_out_111031", "111031005", "story_v_out_111031.awb")

						arg_18_1:RecordAudio("111031005", var_21_44)
						arg_18_1:RecordAudio("111031005", var_21_44)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_111031", "111031005", "story_v_out_111031.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_111031", "111031005", "story_v_out_111031.awb")
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
	Play111031006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 111031006
		arg_25_1.duration_ = 4.63

		local var_25_0 = {
			ja = 4.166,
			ko = 4.633,
			zh = 4.433,
			en = 4.5
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
				arg_25_0:Play111031007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 0.525

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

				local var_28_3 = arg_25_1:GetWordFromCfg(111031006)
				local var_28_4 = arg_25_1:FormatText(var_28_3.content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_111031", "111031006", "story_v_out_111031.awb") ~= 0 then
					local var_28_8 = manager.audio:GetVoiceLength("story_v_out_111031", "111031006", "story_v_out_111031.awb") / 1000

					if var_28_8 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_8 + var_28_0
					end

					if var_28_3.prefab_name ~= "" and arg_25_1.actors_[var_28_3.prefab_name] ~= nil then
						local var_28_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_3.prefab_name].transform, "story_v_out_111031", "111031006", "story_v_out_111031.awb")

						arg_25_1:RecordAudio("111031006", var_28_9)
						arg_25_1:RecordAudio("111031006", var_28_9)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_111031", "111031006", "story_v_out_111031.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_111031", "111031006", "story_v_out_111031.awb")
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
	Play111031007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 111031007
		arg_29_1.duration_ = 6.6

		local var_29_0 = {
			ja = 3.433,
			ko = 6.6,
			zh = 3.366,
			en = 3.766
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
				arg_29_0:Play111031008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 0.725

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_2 = arg_29_1:FormatText(StoryNameCfg[177].name)

				arg_29_1.leftNameTxt_.text = var_32_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_3 = arg_29_1:GetWordFromCfg(111031007)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 15
				local var_32_6 = utf8.len(var_32_4)
				local var_32_7 = var_32_5 <= 0 and var_32_1 or var_32_1 * (var_32_6 / var_32_5)

				if var_32_7 > 0 and var_32_1 < var_32_7 then
					arg_29_1.talkMaxDuration = var_32_7

					if var_32_7 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_0
					end
				end

				arg_29_1.text_.text = var_32_4
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111031", "111031007", "story_v_out_111031.awb") ~= 0 then
					local var_32_8 = manager.audio:GetVoiceLength("story_v_out_111031", "111031007", "story_v_out_111031.awb") / 1000

					if var_32_8 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_0
					end

					if var_32_3.prefab_name ~= "" and arg_29_1.actors_[var_32_3.prefab_name] ~= nil then
						local var_32_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_3.prefab_name].transform, "story_v_out_111031", "111031007", "story_v_out_111031.awb")

						arg_29_1:RecordAudio("111031007", var_32_9)
						arg_29_1:RecordAudio("111031007", var_32_9)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_111031", "111031007", "story_v_out_111031.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_111031", "111031007", "story_v_out_111031.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_10 = math.max(var_32_1, arg_29_1.talkMaxDuration)

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_10 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_0) / var_32_10

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_0 + var_32_10 and arg_29_1.time_ < var_32_0 + var_32_10 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play111031008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 111031008
		arg_33_1.duration_ = 3.9

		local var_33_0 = {
			ja = 1.999999999999,
			ko = 2.333,
			zh = 3.9,
			en = 1.999999999999
		}
		local var_33_1 = manager.audio:GetLocalizationFlag()

		if var_33_0[var_33_1] ~= nil then
			arg_33_1.duration_ = var_33_0[var_33_1]
		end

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play111031009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = "1094ui_story"

			if arg_33_1.actors_[var_36_0] == nil then
				local var_36_1 = Asset.Load("Char/" .. "1094ui_story")

				if not isNil(var_36_1) then
					local var_36_2 = Object.Instantiate(Asset.Load("Char/" .. "1094ui_story"), arg_33_1.stage_.transform)

					var_36_2.name = var_36_0
					var_36_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_33_1.actors_[var_36_0] = var_36_2

					local var_36_3 = var_36_2:GetComponentInChildren(typeof(CharacterEffect))

					var_36_3.enabled = true

					local var_36_4 = GameObjectTools.GetOrAddComponent(var_36_2, typeof(DynamicBoneHelper))

					if var_36_4 then
						var_36_4:EnableDynamicBone(false)
					end

					arg_33_1:ShowWeapon(var_36_3.transform, false)

					arg_33_1.var_[var_36_0 .. "Animator"] = var_36_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_33_1.var_[var_36_0 .. "Animator"].applyRootMotion = true
					arg_33_1.var_[var_36_0 .. "LipSync"] = var_36_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_36_5 = arg_33_1.actors_["1094ui_story"].transform
			local var_36_6 = 0

			if var_36_6 < arg_33_1.time_ and arg_33_1.time_ <= var_36_6 + arg_36_0 then
				arg_33_1.var_.moveOldPos1094ui_story = var_36_5.localPosition
			end

			local var_36_7 = 0.001

			if var_36_6 <= arg_33_1.time_ and arg_33_1.time_ < var_36_6 + var_36_7 then
				local var_36_8 = (arg_33_1.time_ - var_36_6) / var_36_7
				local var_36_9 = Vector3.New(0, -0.84, -6.1)

				var_36_5.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1094ui_story, var_36_9, var_36_8)

				local var_36_10 = manager.ui.mainCamera.transform.position - var_36_5.position

				var_36_5.forward = Vector3.New(var_36_10.x, var_36_10.y, var_36_10.z)

				local var_36_11 = var_36_5.localEulerAngles

				var_36_11.z = 0
				var_36_11.x = 0
				var_36_5.localEulerAngles = var_36_11
			end

			if arg_33_1.time_ >= var_36_6 + var_36_7 and arg_33_1.time_ < var_36_6 + var_36_7 + arg_36_0 then
				var_36_5.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_36_12 = manager.ui.mainCamera.transform.position - var_36_5.position

				var_36_5.forward = Vector3.New(var_36_12.x, var_36_12.y, var_36_12.z)

				local var_36_13 = var_36_5.localEulerAngles

				var_36_13.z = 0
				var_36_13.x = 0
				var_36_5.localEulerAngles = var_36_13
			end

			local var_36_14 = 0

			if var_36_14 < arg_33_1.time_ and arg_33_1.time_ <= var_36_14 + arg_36_0 then
				arg_33_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action3_1")
			end

			local var_36_15 = 0

			if var_36_15 < arg_33_1.time_ and arg_33_1.time_ <= var_36_15 + arg_36_0 then
				arg_33_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_36_16 = arg_33_1.actors_["1094ui_story"]
			local var_36_17 = 0

			if var_36_17 < arg_33_1.time_ and arg_33_1.time_ <= var_36_17 + arg_36_0 and not isNil(var_36_16) and arg_33_1.var_.characterEffect1094ui_story == nil then
				arg_33_1.var_.characterEffect1094ui_story = var_36_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_18 = 0.2

			if var_36_17 <= arg_33_1.time_ and arg_33_1.time_ < var_36_17 + var_36_18 and not isNil(var_36_16) then
				local var_36_19 = (arg_33_1.time_ - var_36_17) / var_36_18

				if arg_33_1.var_.characterEffect1094ui_story and not isNil(var_36_16) then
					arg_33_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_17 + var_36_18 and arg_33_1.time_ < var_36_17 + var_36_18 + arg_36_0 and not isNil(var_36_16) and arg_33_1.var_.characterEffect1094ui_story then
				arg_33_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_36_20 = 0
			local var_36_21 = 0.275

			if var_36_20 < arg_33_1.time_ and arg_33_1.time_ <= var_36_20 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_22 = arg_33_1:FormatText(StoryNameCfg[181].name)

				arg_33_1.leftNameTxt_.text = var_36_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_23 = arg_33_1:GetWordFromCfg(111031008)
				local var_36_24 = arg_33_1:FormatText(var_36_23.content)

				arg_33_1.text_.text = var_36_24

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_25 = 11
				local var_36_26 = utf8.len(var_36_24)
				local var_36_27 = var_36_25 <= 0 and var_36_21 or var_36_21 * (var_36_26 / var_36_25)

				if var_36_27 > 0 and var_36_21 < var_36_27 then
					arg_33_1.talkMaxDuration = var_36_27

					if var_36_27 + var_36_20 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_27 + var_36_20
					end
				end

				arg_33_1.text_.text = var_36_24
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111031", "111031008", "story_v_out_111031.awb") ~= 0 then
					local var_36_28 = manager.audio:GetVoiceLength("story_v_out_111031", "111031008", "story_v_out_111031.awb") / 1000

					if var_36_28 + var_36_20 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_28 + var_36_20
					end

					if var_36_23.prefab_name ~= "" and arg_33_1.actors_[var_36_23.prefab_name] ~= nil then
						local var_36_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_23.prefab_name].transform, "story_v_out_111031", "111031008", "story_v_out_111031.awb")

						arg_33_1:RecordAudio("111031008", var_36_29)
						arg_33_1:RecordAudio("111031008", var_36_29)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_111031", "111031008", "story_v_out_111031.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_111031", "111031008", "story_v_out_111031.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_30 = math.max(var_36_21, arg_33_1.talkMaxDuration)

			if var_36_20 <= arg_33_1.time_ and arg_33_1.time_ < var_36_20 + var_36_30 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_20) / var_36_30

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_20 + var_36_30 and arg_33_1.time_ < var_36_20 + var_36_30 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
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

		arg_33_1:InitPlayNodeList()
	end,
	Play111031009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 111031009
		arg_37_1.duration_ = 4

		local var_37_0 = {
			ja = 2.033,
			ko = 2,
			zh = 4,
			en = 1.999999999999
		}
		local var_37_1 = manager.audio:GetLocalizationFlag()

		if var_37_0[var_37_1] ~= nil then
			arg_37_1.duration_ = var_37_0[var_37_1]
		end

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play111031010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_40_1 = arg_37_1.actors_["1094ui_story"]
			local var_40_2 = 0

			if var_40_2 < arg_37_1.time_ and arg_37_1.time_ <= var_40_2 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect1094ui_story == nil then
				arg_37_1.var_.characterEffect1094ui_story = var_40_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_3 = 0.2

			if var_40_2 <= arg_37_1.time_ and arg_37_1.time_ < var_40_2 + var_40_3 and not isNil(var_40_1) then
				local var_40_4 = (arg_37_1.time_ - var_40_2) / var_40_3

				if arg_37_1.var_.characterEffect1094ui_story and not isNil(var_40_1) then
					arg_37_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_2 + var_40_3 and arg_37_1.time_ < var_40_2 + var_40_3 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect1094ui_story then
				arg_37_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_40_5 = 0
			local var_40_6 = 0.25

			if var_40_5 < arg_37_1.time_ and arg_37_1.time_ <= var_40_5 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_7 = arg_37_1:FormatText(StoryNameCfg[181].name)

				arg_37_1.leftNameTxt_.text = var_40_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_8 = arg_37_1:GetWordFromCfg(111031009)
				local var_40_9 = arg_37_1:FormatText(var_40_8.content)

				arg_37_1.text_.text = var_40_9

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_10 = 10
				local var_40_11 = utf8.len(var_40_9)
				local var_40_12 = var_40_10 <= 0 and var_40_6 or var_40_6 * (var_40_11 / var_40_10)

				if var_40_12 > 0 and var_40_6 < var_40_12 then
					arg_37_1.talkMaxDuration = var_40_12

					if var_40_12 + var_40_5 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_12 + var_40_5
					end
				end

				arg_37_1.text_.text = var_40_9
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111031", "111031009", "story_v_out_111031.awb") ~= 0 then
					local var_40_13 = manager.audio:GetVoiceLength("story_v_out_111031", "111031009", "story_v_out_111031.awb") / 1000

					if var_40_13 + var_40_5 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_13 + var_40_5
					end

					if var_40_8.prefab_name ~= "" and arg_37_1.actors_[var_40_8.prefab_name] ~= nil then
						local var_40_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_8.prefab_name].transform, "story_v_out_111031", "111031009", "story_v_out_111031.awb")

						arg_37_1:RecordAudio("111031009", var_40_14)
						arg_37_1:RecordAudio("111031009", var_40_14)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_111031", "111031009", "story_v_out_111031.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_111031", "111031009", "story_v_out_111031.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_15 = math.max(var_40_6, arg_37_1.talkMaxDuration)

			if var_40_5 <= arg_37_1.time_ and arg_37_1.time_ < var_40_5 + var_40_15 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_5) / var_40_15

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_5 + var_40_15 and arg_37_1.time_ < var_40_5 + var_40_15 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play111031010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 111031010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play111031011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1094ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1094ui_story == nil then
				arg_41_1.var_.characterEffect1094ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.2

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect1094ui_story and not isNil(var_44_0) then
					local var_44_4 = Mathf.Lerp(0, 0.5, var_44_3)

					arg_41_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1094ui_story.fillRatio = var_44_4
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1094ui_story then
				local var_44_5 = 0.5

				arg_41_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1094ui_story.fillRatio = var_44_5
			end

			local var_44_6 = 0
			local var_44_7 = 0.75

			if var_44_6 < arg_41_1.time_ and arg_41_1.time_ <= var_44_6 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_8 = arg_41_1:GetWordFromCfg(111031010)
				local var_44_9 = arg_41_1:FormatText(var_44_8.content)

				arg_41_1.text_.text = var_44_9

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_10 = 30
				local var_44_11 = utf8.len(var_44_9)
				local var_44_12 = var_44_10 <= 0 and var_44_7 or var_44_7 * (var_44_11 / var_44_10)

				if var_44_12 > 0 and var_44_7 < var_44_12 then
					arg_41_1.talkMaxDuration = var_44_12

					if var_44_12 + var_44_6 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_12 + var_44_6
					end
				end

				arg_41_1.text_.text = var_44_9
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_13 = math.max(var_44_7, arg_41_1.talkMaxDuration)

			if var_44_6 <= arg_41_1.time_ and arg_41_1.time_ < var_44_6 + var_44_13 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_6) / var_44_13

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_6 + var_44_13 and arg_41_1.time_ < var_44_6 + var_44_13 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play111031011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 111031011
		arg_45_1.duration_ = 2

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play111031012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094actionlink/1094action435")
			end

			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
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
			local var_48_7 = 0.15

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

				local var_48_9 = arg_45_1:GetWordFromCfg(111031011)
				local var_48_10 = arg_45_1:FormatText(var_48_9.content)

				arg_45_1.text_.text = var_48_10

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_11 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_111031", "111031011", "story_v_out_111031.awb") ~= 0 then
					local var_48_14 = manager.audio:GetVoiceLength("story_v_out_111031", "111031011", "story_v_out_111031.awb") / 1000

					if var_48_14 + var_48_6 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_14 + var_48_6
					end

					if var_48_9.prefab_name ~= "" and arg_45_1.actors_[var_48_9.prefab_name] ~= nil then
						local var_48_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_9.prefab_name].transform, "story_v_out_111031", "111031011", "story_v_out_111031.awb")

						arg_45_1:RecordAudio("111031011", var_48_15)
						arg_45_1:RecordAudio("111031011", var_48_15)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_111031", "111031011", "story_v_out_111031.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_111031", "111031011", "story_v_out_111031.awb")
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
	Play111031012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 111031012
		arg_49_1.duration_ = 7.27

		local var_49_0 = {
			ja = 7.266,
			ko = 6.366,
			zh = 6.133,
			en = 6.466
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
				arg_49_0:Play111031013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.bgs_.D05
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				local var_52_2 = var_52_0:GetComponent("SpriteRenderer")

				if var_52_2 then
					arg_49_1.var_.alphaOldValueD05 = var_52_2.color.a
					arg_49_1.var_.alphaMatValueD05 = var_52_2
				end

				arg_49_1.var_.alphaOldValueD05 = 1
			end

			local var_52_3 = 1

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_3 then
				local var_52_4 = (arg_49_1.time_ - var_52_1) / var_52_3
				local var_52_5 = Mathf.Lerp(arg_49_1.var_.alphaOldValueD05, 0, var_52_4)

				if arg_49_1.var_.alphaMatValueD05 then
					local var_52_6 = arg_49_1.var_.alphaMatValueD05.color

					var_52_6.a = var_52_5
					arg_49_1.var_.alphaMatValueD05.color = var_52_6
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_3 and arg_49_1.time_ < var_52_1 + var_52_3 + arg_52_0 and arg_49_1.var_.alphaMatValueD05 then
				local var_52_7 = arg_49_1.var_.alphaMatValueD05
				local var_52_8 = var_52_7.color

				var_52_8.a = 0
				var_52_7.color = var_52_8
			end

			local var_52_9 = "D12b"

			if arg_49_1.bgs_[var_52_9] == nil then
				local var_52_10 = Object.Instantiate(arg_49_1.paintGo_)

				var_52_10:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_52_9)
				var_52_10.name = var_52_9
				var_52_10.transform.parent = arg_49_1.stage_.transform
				var_52_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_49_1.bgs_[var_52_9] = var_52_10
			end

			local var_52_11 = 1

			if var_52_11 < arg_49_1.time_ and arg_49_1.time_ <= var_52_11 + arg_52_0 then
				local var_52_12 = manager.ui.mainCamera.transform.localPosition
				local var_52_13 = Vector3.New(0, 0, 10) + Vector3.New(var_52_12.x, var_52_12.y, 0)
				local var_52_14 = arg_49_1.bgs_.D12b

				var_52_14.transform.localPosition = var_52_13
				var_52_14.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_52_15 = var_52_14:GetComponent("SpriteRenderer")

				if var_52_15 and var_52_15.sprite then
					local var_52_16 = (var_52_14.transform.localPosition - var_52_12).z
					local var_52_17 = manager.ui.mainCameraCom_
					local var_52_18 = 2 * var_52_16 * Mathf.Tan(var_52_17.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_52_19 = var_52_18 * var_52_17.aspect
					local var_52_20 = var_52_15.sprite.bounds.size.x
					local var_52_21 = var_52_15.sprite.bounds.size.y
					local var_52_22 = var_52_19 / var_52_20
					local var_52_23 = var_52_18 / var_52_21
					local var_52_24 = var_52_23 < var_52_22 and var_52_22 or var_52_23

					var_52_14.transform.localScale = Vector3.New(var_52_24, var_52_24, 0)
				end

				for iter_52_0, iter_52_1 in pairs(arg_49_1.bgs_) do
					if iter_52_0 ~= "D12b" then
						iter_52_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_52_25 = arg_49_1.bgs_.D12b
			local var_52_26 = 1

			if var_52_26 < arg_49_1.time_ and arg_49_1.time_ <= var_52_26 + arg_52_0 then
				local var_52_27 = var_52_25:GetComponent("SpriteRenderer")

				if var_52_27 then
					arg_49_1.var_.alphaOldValueD12b = var_52_27.color.a
					arg_49_1.var_.alphaMatValueD12b = var_52_27
				end

				arg_49_1.var_.alphaOldValueD12b = 0
			end

			local var_52_28 = 1

			if var_52_26 <= arg_49_1.time_ and arg_49_1.time_ < var_52_26 + var_52_28 then
				local var_52_29 = (arg_49_1.time_ - var_52_26) / var_52_28
				local var_52_30 = Mathf.Lerp(arg_49_1.var_.alphaOldValueD12b, 1, var_52_29)

				if arg_49_1.var_.alphaMatValueD12b then
					local var_52_31 = arg_49_1.var_.alphaMatValueD12b.color

					var_52_31.a = var_52_30
					arg_49_1.var_.alphaMatValueD12b.color = var_52_31
				end
			end

			if arg_49_1.time_ >= var_52_26 + var_52_28 and arg_49_1.time_ < var_52_26 + var_52_28 + arg_52_0 and arg_49_1.var_.alphaMatValueD12b then
				local var_52_32 = arg_49_1.var_.alphaMatValueD12b
				local var_52_33 = var_52_32.color

				var_52_33.a = 1
				var_52_32.color = var_52_33
			end

			local var_52_34 = arg_49_1.actors_["1094ui_story"].transform
			local var_52_35 = 0

			if var_52_35 < arg_49_1.time_ and arg_49_1.time_ <= var_52_35 + arg_52_0 then
				arg_49_1.var_.moveOldPos1094ui_story = var_52_34.localPosition
			end

			local var_52_36 = 0.001

			if var_52_35 <= arg_49_1.time_ and arg_49_1.time_ < var_52_35 + var_52_36 then
				local var_52_37 = (arg_49_1.time_ - var_52_35) / var_52_36
				local var_52_38 = Vector3.New(0, 100, 0)

				var_52_34.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1094ui_story, var_52_38, var_52_37)

				local var_52_39 = manager.ui.mainCamera.transform.position - var_52_34.position

				var_52_34.forward = Vector3.New(var_52_39.x, var_52_39.y, var_52_39.z)

				local var_52_40 = var_52_34.localEulerAngles

				var_52_40.z = 0
				var_52_40.x = 0
				var_52_34.localEulerAngles = var_52_40
			end

			if arg_49_1.time_ >= var_52_35 + var_52_36 and arg_49_1.time_ < var_52_35 + var_52_36 + arg_52_0 then
				var_52_34.localPosition = Vector3.New(0, 100, 0)

				local var_52_41 = manager.ui.mainCamera.transform.position - var_52_34.position

				var_52_34.forward = Vector3.New(var_52_41.x, var_52_41.y, var_52_41.z)

				local var_52_42 = var_52_34.localEulerAngles

				var_52_42.z = 0
				var_52_42.x = 0
				var_52_34.localEulerAngles = var_52_42
			end

			local var_52_43 = "1048ui_story"

			if arg_49_1.actors_[var_52_43] == nil then
				local var_52_44 = Asset.Load("Char/" .. "1048ui_story")

				if not isNil(var_52_44) then
					local var_52_45 = Object.Instantiate(Asset.Load("Char/" .. "1048ui_story"), arg_49_1.stage_.transform)

					var_52_45.name = var_52_43
					var_52_45.transform.localPosition = Vector3.New(0, 100, 0)
					arg_49_1.actors_[var_52_43] = var_52_45

					local var_52_46 = var_52_45:GetComponentInChildren(typeof(CharacterEffect))

					var_52_46.enabled = true

					local var_52_47 = GameObjectTools.GetOrAddComponent(var_52_45, typeof(DynamicBoneHelper))

					if var_52_47 then
						var_52_47:EnableDynamicBone(false)
					end

					arg_49_1:ShowWeapon(var_52_46.transform, false)

					arg_49_1.var_[var_52_43 .. "Animator"] = var_52_46.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_49_1.var_[var_52_43 .. "Animator"].applyRootMotion = true
					arg_49_1.var_[var_52_43 .. "LipSync"] = var_52_46.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_52_48 = arg_49_1.actors_["1048ui_story"].transform
			local var_52_49 = 2.00066666666667

			if var_52_49 < arg_49_1.time_ and arg_49_1.time_ <= var_52_49 + arg_52_0 then
				arg_49_1.var_.moveOldPos1048ui_story = var_52_48.localPosition
			end

			local var_52_50 = 0.001

			if var_52_49 <= arg_49_1.time_ and arg_49_1.time_ < var_52_49 + var_52_50 then
				local var_52_51 = (arg_49_1.time_ - var_52_49) / var_52_50
				local var_52_52 = Vector3.New(-0.7, -0.8, -6.2)

				var_52_48.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1048ui_story, var_52_52, var_52_51)

				local var_52_53 = manager.ui.mainCamera.transform.position - var_52_48.position

				var_52_48.forward = Vector3.New(var_52_53.x, var_52_53.y, var_52_53.z)

				local var_52_54 = var_52_48.localEulerAngles

				var_52_54.z = 0
				var_52_54.x = 0
				var_52_48.localEulerAngles = var_52_54
			end

			if arg_49_1.time_ >= var_52_49 + var_52_50 and arg_49_1.time_ < var_52_49 + var_52_50 + arg_52_0 then
				var_52_48.localPosition = Vector3.New(-0.7, -0.8, -6.2)

				local var_52_55 = manager.ui.mainCamera.transform.position - var_52_48.position

				var_52_48.forward = Vector3.New(var_52_55.x, var_52_55.y, var_52_55.z)

				local var_52_56 = var_52_48.localEulerAngles

				var_52_56.z = 0
				var_52_56.x = 0
				var_52_48.localEulerAngles = var_52_56
			end

			local var_52_57 = 2.00066666666667

			if var_52_57 < arg_49_1.time_ and arg_49_1.time_ <= var_52_57 + arg_52_0 then
				arg_49_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048action/1048action7_1")
			end

			local var_52_58 = 2

			if var_52_58 < arg_49_1.time_ and arg_49_1.time_ <= var_52_58 + arg_52_0 then
				arg_49_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_52_59 = arg_49_1.actors_["1048ui_story"]
			local var_52_60 = 2

			if var_52_60 < arg_49_1.time_ and arg_49_1.time_ <= var_52_60 + arg_52_0 and not isNil(var_52_59) and arg_49_1.var_.characterEffect1048ui_story == nil then
				arg_49_1.var_.characterEffect1048ui_story = var_52_59:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_61 = 0.2

			if var_52_60 <= arg_49_1.time_ and arg_49_1.time_ < var_52_60 + var_52_61 and not isNil(var_52_59) then
				local var_52_62 = (arg_49_1.time_ - var_52_60) / var_52_61

				if arg_49_1.var_.characterEffect1048ui_story and not isNil(var_52_59) then
					arg_49_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_60 + var_52_61 and arg_49_1.time_ < var_52_60 + var_52_61 + arg_52_0 and not isNil(var_52_59) and arg_49_1.var_.characterEffect1048ui_story then
				arg_49_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			local var_52_63 = 0

			if var_52_63 < arg_49_1.time_ and arg_49_1.time_ <= var_52_63 + arg_52_0 then
				arg_49_1.allBtn_.enabled = false
			end

			local var_52_64 = 2

			if arg_49_1.time_ >= var_52_63 + var_52_64 and arg_49_1.time_ < var_52_63 + var_52_64 + arg_52_0 then
				arg_49_1.allBtn_.enabled = true
			end

			if arg_49_1.frameCnt_ <= 1 then
				arg_49_1.dialog_:SetActive(false)
			end

			local var_52_65 = 2
			local var_52_66 = 0.55

			if var_52_65 < arg_49_1.time_ and arg_49_1.time_ <= var_52_65 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0

				arg_49_1.dialog_:SetActive(true)

				arg_49_1.dialogCg_.alpha = 0

				local var_52_67 = LeanTween.value(arg_49_1.dialog_, 0, 1, 0.3)

				var_52_67:setOnUpdate(LuaHelper.FloatAction(function(arg_53_0)
					arg_49_1.dialogCg_.alpha = arg_53_0
				end))
				var_52_67:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_49_1.dialog_)
					var_52_67:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_49_1.duration_ = arg_49_1.duration_ + 0.3

				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_68 = arg_49_1:FormatText(StoryNameCfg[8].name)

				arg_49_1.leftNameTxt_.text = var_52_68

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_69 = arg_49_1:GetWordFromCfg(111031012)
				local var_52_70 = arg_49_1:FormatText(var_52_69.content)

				arg_49_1.text_.text = var_52_70

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_71 = 22
				local var_52_72 = utf8.len(var_52_70)
				local var_52_73 = var_52_71 <= 0 and var_52_66 or var_52_66 * (var_52_72 / var_52_71)

				if var_52_73 > 0 and var_52_66 < var_52_73 then
					arg_49_1.talkMaxDuration = var_52_73
					var_52_65 = var_52_65 + 0.3

					if var_52_73 + var_52_65 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_73 + var_52_65
					end
				end

				arg_49_1.text_.text = var_52_70
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111031", "111031012", "story_v_out_111031.awb") ~= 0 then
					local var_52_74 = manager.audio:GetVoiceLength("story_v_out_111031", "111031012", "story_v_out_111031.awb") / 1000

					if var_52_74 + var_52_65 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_74 + var_52_65
					end

					if var_52_69.prefab_name ~= "" and arg_49_1.actors_[var_52_69.prefab_name] ~= nil then
						local var_52_75 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_69.prefab_name].transform, "story_v_out_111031", "111031012", "story_v_out_111031.awb")

						arg_49_1:RecordAudio("111031012", var_52_75)
						arg_49_1:RecordAudio("111031012", var_52_75)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_111031", "111031012", "story_v_out_111031.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_111031", "111031012", "story_v_out_111031.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_76 = var_52_65 + 0.3
			local var_52_77 = math.max(var_52_66, arg_49_1.talkMaxDuration)

			if var_52_76 <= arg_49_1.time_ and arg_49_1.time_ < var_52_76 + var_52_77 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_76) / var_52_77

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_76 + var_52_77 and arg_49_1.time_ < var_52_76 + var_52_77 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
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
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0333333333333334,
				className = "StoryMoveNode",
				startTime = 2.00066666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play111031013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 111031013
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play111031014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = arg_55_1.actors_["1048ui_story"]
			local var_58_1 = 0

			if var_58_1 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 and not isNil(var_58_0) and arg_55_1.var_.characterEffect1048ui_story == nil then
				arg_55_1.var_.characterEffect1048ui_story = var_58_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_2 = 0.2

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_2 and not isNil(var_58_0) then
				local var_58_3 = (arg_55_1.time_ - var_58_1) / var_58_2

				if arg_55_1.var_.characterEffect1048ui_story and not isNil(var_58_0) then
					local var_58_4 = Mathf.Lerp(0, 0.5, var_58_3)

					arg_55_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_55_1.var_.characterEffect1048ui_story.fillRatio = var_58_4
				end
			end

			if arg_55_1.time_ >= var_58_1 + var_58_2 and arg_55_1.time_ < var_58_1 + var_58_2 + arg_58_0 and not isNil(var_58_0) and arg_55_1.var_.characterEffect1048ui_story then
				local var_58_5 = 0.5

				arg_55_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_55_1.var_.characterEffect1048ui_story.fillRatio = var_58_5
			end

			local var_58_6 = 0
			local var_58_7 = 1

			if var_58_6 < arg_55_1.time_ and arg_55_1.time_ <= var_58_6 + arg_58_0 then
				local var_58_8 = "play"
				local var_58_9 = "effect"

				arg_55_1:AudioAction(var_58_8, var_58_9, "se_story_activity_1_1", "se_story_activity_1_1_stone", "")
			end

			local var_58_10 = 0
			local var_58_11 = 1.025

			if var_58_10 < arg_55_1.time_ and arg_55_1.time_ <= var_58_10 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, false)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_12 = arg_55_1:GetWordFromCfg(111031013)
				local var_58_13 = arg_55_1:FormatText(var_58_12.content)

				arg_55_1.text_.text = var_58_13

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_14 = 41
				local var_58_15 = utf8.len(var_58_13)
				local var_58_16 = var_58_14 <= 0 and var_58_11 or var_58_11 * (var_58_15 / var_58_14)

				if var_58_16 > 0 and var_58_11 < var_58_16 then
					arg_55_1.talkMaxDuration = var_58_16

					if var_58_16 + var_58_10 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_16 + var_58_10
					end
				end

				arg_55_1.text_.text = var_58_13
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_17 = math.max(var_58_11, arg_55_1.talkMaxDuration)

			if var_58_10 <= arg_55_1.time_ and arg_55_1.time_ < var_58_10 + var_58_17 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_10) / var_58_17

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_10 + var_58_17 and arg_55_1.time_ < var_58_10 + var_58_17 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play111031014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 111031014
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play111031015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0
			local var_62_1 = 1.15

			if var_62_0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, false)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_2 = arg_59_1:GetWordFromCfg(111031014)
				local var_62_3 = arg_59_1:FormatText(var_62_2.content)

				arg_59_1.text_.text = var_62_3

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_4 = 46
				local var_62_5 = utf8.len(var_62_3)
				local var_62_6 = var_62_4 <= 0 and var_62_1 or var_62_1 * (var_62_5 / var_62_4)

				if var_62_6 > 0 and var_62_1 < var_62_6 then
					arg_59_1.talkMaxDuration = var_62_6

					if var_62_6 + var_62_0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_6 + var_62_0
					end
				end

				arg_59_1.text_.text = var_62_3
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_7 = math.max(var_62_1, arg_59_1.talkMaxDuration)

			if var_62_0 <= arg_59_1.time_ and arg_59_1.time_ < var_62_0 + var_62_7 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_0) / var_62_7

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_0 + var_62_7 and arg_59_1.time_ < var_62_0 + var_62_7 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play111031015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 111031015
		arg_63_1.duration_ = 11.4

		local var_63_0 = {
			ja = 11.4,
			ko = 7.166,
			zh = 5.2,
			en = 6.7
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
				arg_63_0:Play111031016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = "1039ui_story"

			if arg_63_1.actors_[var_66_0] == nil then
				local var_66_1 = Asset.Load("Char/" .. "1039ui_story")

				if not isNil(var_66_1) then
					local var_66_2 = Object.Instantiate(Asset.Load("Char/" .. "1039ui_story"), arg_63_1.stage_.transform)

					var_66_2.name = var_66_0
					var_66_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_63_1.actors_[var_66_0] = var_66_2

					local var_66_3 = var_66_2:GetComponentInChildren(typeof(CharacterEffect))

					var_66_3.enabled = true

					local var_66_4 = GameObjectTools.GetOrAddComponent(var_66_2, typeof(DynamicBoneHelper))

					if var_66_4 then
						var_66_4:EnableDynamicBone(false)
					end

					arg_63_1:ShowWeapon(var_66_3.transform, false)

					arg_63_1.var_[var_66_0 .. "Animator"] = var_66_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_63_1.var_[var_66_0 .. "Animator"].applyRootMotion = true
					arg_63_1.var_[var_66_0 .. "LipSync"] = var_66_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_66_5 = arg_63_1.actors_["1039ui_story"].transform
			local var_66_6 = 0

			if var_66_6 < arg_63_1.time_ and arg_63_1.time_ <= var_66_6 + arg_66_0 then
				arg_63_1.var_.moveOldPos1039ui_story = var_66_5.localPosition

				local var_66_7 = "1039ui_story"

				arg_63_1:ShowWeapon(arg_63_1.var_[var_66_7 .. "Animator"].transform, false)
			end

			local var_66_8 = 0.001

			if var_66_6 <= arg_63_1.time_ and arg_63_1.time_ < var_66_6 + var_66_8 then
				local var_66_9 = (arg_63_1.time_ - var_66_6) / var_66_8
				local var_66_10 = Vector3.New(0.7, -1.01, -5.9)

				var_66_5.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos1039ui_story, var_66_10, var_66_9)

				local var_66_11 = manager.ui.mainCamera.transform.position - var_66_5.position

				var_66_5.forward = Vector3.New(var_66_11.x, var_66_11.y, var_66_11.z)

				local var_66_12 = var_66_5.localEulerAngles

				var_66_12.z = 0
				var_66_12.x = 0
				var_66_5.localEulerAngles = var_66_12
			end

			if arg_63_1.time_ >= var_66_6 + var_66_8 and arg_63_1.time_ < var_66_6 + var_66_8 + arg_66_0 then
				var_66_5.localPosition = Vector3.New(0.7, -1.01, -5.9)

				local var_66_13 = manager.ui.mainCamera.transform.position - var_66_5.position

				var_66_5.forward = Vector3.New(var_66_13.x, var_66_13.y, var_66_13.z)

				local var_66_14 = var_66_5.localEulerAngles

				var_66_14.z = 0
				var_66_14.x = 0
				var_66_5.localEulerAngles = var_66_14
			end

			local var_66_15 = 0

			if var_66_15 < arg_63_1.time_ and arg_63_1.time_ <= var_66_15 + arg_66_0 then
				arg_63_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action5_1")
			end

			local var_66_16 = 0

			if var_66_16 < arg_63_1.time_ and arg_63_1.time_ <= var_66_16 + arg_66_0 then
				arg_63_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_66_17 = arg_63_1.actors_["1039ui_story"]
			local var_66_18 = 0

			if var_66_18 < arg_63_1.time_ and arg_63_1.time_ <= var_66_18 + arg_66_0 and not isNil(var_66_17) and arg_63_1.var_.characterEffect1039ui_story == nil then
				arg_63_1.var_.characterEffect1039ui_story = var_66_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_19 = 0.2

			if var_66_18 <= arg_63_1.time_ and arg_63_1.time_ < var_66_18 + var_66_19 and not isNil(var_66_17) then
				local var_66_20 = (arg_63_1.time_ - var_66_18) / var_66_19

				if arg_63_1.var_.characterEffect1039ui_story and not isNil(var_66_17) then
					arg_63_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_63_1.time_ >= var_66_18 + var_66_19 and arg_63_1.time_ < var_66_18 + var_66_19 + arg_66_0 and not isNil(var_66_17) and arg_63_1.var_.characterEffect1039ui_story then
				arg_63_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_66_21 = 0
			local var_66_22 = 0.7

			if var_66_21 < arg_63_1.time_ and arg_63_1.time_ <= var_66_21 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_23 = arg_63_1:FormatText(StoryNameCfg[9].name)

				arg_63_1.leftNameTxt_.text = var_66_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_24 = arg_63_1:GetWordFromCfg(111031015)
				local var_66_25 = arg_63_1:FormatText(var_66_24.content)

				arg_63_1.text_.text = var_66_25

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_26 = 28
				local var_66_27 = utf8.len(var_66_25)
				local var_66_28 = var_66_26 <= 0 and var_66_22 or var_66_22 * (var_66_27 / var_66_26)

				if var_66_28 > 0 and var_66_22 < var_66_28 then
					arg_63_1.talkMaxDuration = var_66_28

					if var_66_28 + var_66_21 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_28 + var_66_21
					end
				end

				arg_63_1.text_.text = var_66_25
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111031", "111031015", "story_v_out_111031.awb") ~= 0 then
					local var_66_29 = manager.audio:GetVoiceLength("story_v_out_111031", "111031015", "story_v_out_111031.awb") / 1000

					if var_66_29 + var_66_21 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_29 + var_66_21
					end

					if var_66_24.prefab_name ~= "" and arg_63_1.actors_[var_66_24.prefab_name] ~= nil then
						local var_66_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_24.prefab_name].transform, "story_v_out_111031", "111031015", "story_v_out_111031.awb")

						arg_63_1:RecordAudio("111031015", var_66_30)
						arg_63_1:RecordAudio("111031015", var_66_30)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_111031", "111031015", "story_v_out_111031.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_111031", "111031015", "story_v_out_111031.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_31 = math.max(var_66_22, arg_63_1.talkMaxDuration)

			if var_66_21 <= arg_63_1.time_ and arg_63_1.time_ < var_66_21 + var_66_31 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_21) / var_66_31

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_21 + var_66_31 and arg_63_1.time_ < var_66_21 + var_66_31 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {
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

		arg_63_1:InitPlayNodeList()
	end,
	Play111031016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 111031016
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play111031017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0
			local var_70_1 = 0.875

			if var_70_0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_2 = arg_67_1:FormatText(StoryNameCfg[7].name)

				arg_67_1.leftNameTxt_.text = var_70_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, true)
				arg_67_1.iconController_:SetSelectedState("hero")

				arg_67_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_67_1.callingController_:SetSelectedState("normal")

				arg_67_1.keyicon_.color = Color.New(1, 1, 1)
				arg_67_1.icon_.color = Color.New(1, 1, 1)

				local var_70_3 = arg_67_1:GetWordFromCfg(111031016)
				local var_70_4 = arg_67_1:FormatText(var_70_3.content)

				arg_67_1.text_.text = var_70_4

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_5 = 35
				local var_70_6 = utf8.len(var_70_4)
				local var_70_7 = var_70_5 <= 0 and var_70_1 or var_70_1 * (var_70_6 / var_70_5)

				if var_70_7 > 0 and var_70_1 < var_70_7 then
					arg_67_1.talkMaxDuration = var_70_7

					if var_70_7 + var_70_0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_7 + var_70_0
					end
				end

				arg_67_1.text_.text = var_70_4
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_8 = math.max(var_70_1, arg_67_1.talkMaxDuration)

			if var_70_0 <= arg_67_1.time_ and arg_67_1.time_ < var_70_0 + var_70_8 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_0) / var_70_8

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_0 + var_70_8 and arg_67_1.time_ < var_70_0 + var_70_8 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play111031017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 111031017
		arg_71_1.duration_ = 4.7

		local var_71_0 = {
			ja = 4.7,
			ko = 3.466,
			zh = 3.8,
			en = 4.033
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
				arg_71_0:Play111031018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = arg_71_1.actors_["1048ui_story"].transform
			local var_74_1 = 0

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 then
				arg_71_1.var_.moveOldPos1048ui_story = var_74_0.localPosition
			end

			local var_74_2 = 0.001

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_2 then
				local var_74_3 = (arg_71_1.time_ - var_74_1) / var_74_2
				local var_74_4 = Vector3.New(0, 100, 0)

				var_74_0.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1048ui_story, var_74_4, var_74_3)

				local var_74_5 = manager.ui.mainCamera.transform.position - var_74_0.position

				var_74_0.forward = Vector3.New(var_74_5.x, var_74_5.y, var_74_5.z)

				local var_74_6 = var_74_0.localEulerAngles

				var_74_6.z = 0
				var_74_6.x = 0
				var_74_0.localEulerAngles = var_74_6
			end

			if arg_71_1.time_ >= var_74_1 + var_74_2 and arg_71_1.time_ < var_74_1 + var_74_2 + arg_74_0 then
				var_74_0.localPosition = Vector3.New(0, 100, 0)

				local var_74_7 = manager.ui.mainCamera.transform.position - var_74_0.position

				var_74_0.forward = Vector3.New(var_74_7.x, var_74_7.y, var_74_7.z)

				local var_74_8 = var_74_0.localEulerAngles

				var_74_8.z = 0
				var_74_8.x = 0
				var_74_0.localEulerAngles = var_74_8
			end

			local var_74_9 = "1084ui_story"

			if arg_71_1.actors_[var_74_9] == nil then
				local var_74_10 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_74_10) then
					local var_74_11 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_71_1.stage_.transform)

					var_74_11.name = var_74_9
					var_74_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_71_1.actors_[var_74_9] = var_74_11

					local var_74_12 = var_74_11:GetComponentInChildren(typeof(CharacterEffect))

					var_74_12.enabled = true

					local var_74_13 = GameObjectTools.GetOrAddComponent(var_74_11, typeof(DynamicBoneHelper))

					if var_74_13 then
						var_74_13:EnableDynamicBone(false)
					end

					arg_71_1:ShowWeapon(var_74_12.transform, false)

					arg_71_1.var_[var_74_9 .. "Animator"] = var_74_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_71_1.var_[var_74_9 .. "Animator"].applyRootMotion = true
					arg_71_1.var_[var_74_9 .. "LipSync"] = var_74_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_74_14 = arg_71_1.actors_["1084ui_story"].transform
			local var_74_15 = 0

			if var_74_15 < arg_71_1.time_ and arg_71_1.time_ <= var_74_15 + arg_74_0 then
				arg_71_1.var_.moveOldPos1084ui_story = var_74_14.localPosition
			end

			local var_74_16 = 0.001

			if var_74_15 <= arg_71_1.time_ and arg_71_1.time_ < var_74_15 + var_74_16 then
				local var_74_17 = (arg_71_1.time_ - var_74_15) / var_74_16
				local var_74_18 = Vector3.New(-0.7, -0.97, -6)

				var_74_14.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1084ui_story, var_74_18, var_74_17)

				local var_74_19 = manager.ui.mainCamera.transform.position - var_74_14.position

				var_74_14.forward = Vector3.New(var_74_19.x, var_74_19.y, var_74_19.z)

				local var_74_20 = var_74_14.localEulerAngles

				var_74_20.z = 0
				var_74_20.x = 0
				var_74_14.localEulerAngles = var_74_20
			end

			if arg_71_1.time_ >= var_74_15 + var_74_16 and arg_71_1.time_ < var_74_15 + var_74_16 + arg_74_0 then
				var_74_14.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_74_21 = manager.ui.mainCamera.transform.position - var_74_14.position

				var_74_14.forward = Vector3.New(var_74_21.x, var_74_21.y, var_74_21.z)

				local var_74_22 = var_74_14.localEulerAngles

				var_74_22.z = 0
				var_74_22.x = 0
				var_74_14.localEulerAngles = var_74_22
			end

			local var_74_23 = 0

			if var_74_23 < arg_71_1.time_ and arg_71_1.time_ <= var_74_23 + arg_74_0 then
				arg_71_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_74_24 = 0

			if var_74_24 < arg_71_1.time_ and arg_71_1.time_ <= var_74_24 + arg_74_0 then
				arg_71_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_74_25 = arg_71_1.actors_["1084ui_story"]
			local var_74_26 = 0

			if var_74_26 < arg_71_1.time_ and arg_71_1.time_ <= var_74_26 + arg_74_0 and not isNil(var_74_25) and arg_71_1.var_.characterEffect1084ui_story == nil then
				arg_71_1.var_.characterEffect1084ui_story = var_74_25:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_27 = 0.2

			if var_74_26 <= arg_71_1.time_ and arg_71_1.time_ < var_74_26 + var_74_27 and not isNil(var_74_25) then
				local var_74_28 = (arg_71_1.time_ - var_74_26) / var_74_27

				if arg_71_1.var_.characterEffect1084ui_story and not isNil(var_74_25) then
					arg_71_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= var_74_26 + var_74_27 and arg_71_1.time_ < var_74_26 + var_74_27 + arg_74_0 and not isNil(var_74_25) and arg_71_1.var_.characterEffect1084ui_story then
				arg_71_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_74_29 = arg_71_1.actors_["1039ui_story"]
			local var_74_30 = 0

			if var_74_30 < arg_71_1.time_ and arg_71_1.time_ <= var_74_30 + arg_74_0 and not isNil(var_74_29) and arg_71_1.var_.characterEffect1039ui_story == nil then
				arg_71_1.var_.characterEffect1039ui_story = var_74_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_31 = 0.2

			if var_74_30 <= arg_71_1.time_ and arg_71_1.time_ < var_74_30 + var_74_31 and not isNil(var_74_29) then
				local var_74_32 = (arg_71_1.time_ - var_74_30) / var_74_31

				if arg_71_1.var_.characterEffect1039ui_story and not isNil(var_74_29) then
					local var_74_33 = Mathf.Lerp(0, 0.5, var_74_32)

					arg_71_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_71_1.var_.characterEffect1039ui_story.fillRatio = var_74_33
				end
			end

			if arg_71_1.time_ >= var_74_30 + var_74_31 and arg_71_1.time_ < var_74_30 + var_74_31 + arg_74_0 and not isNil(var_74_29) and arg_71_1.var_.characterEffect1039ui_story then
				local var_74_34 = 0.5

				arg_71_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_71_1.var_.characterEffect1039ui_story.fillRatio = var_74_34
			end

			local var_74_35 = 0
			local var_74_36 = 0.425

			if var_74_35 < arg_71_1.time_ and arg_71_1.time_ <= var_74_35 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_37 = arg_71_1:FormatText(StoryNameCfg[6].name)

				arg_71_1.leftNameTxt_.text = var_74_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_38 = arg_71_1:GetWordFromCfg(111031017)
				local var_74_39 = arg_71_1:FormatText(var_74_38.content)

				arg_71_1.text_.text = var_74_39

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_40 = 17
				local var_74_41 = utf8.len(var_74_39)
				local var_74_42 = var_74_40 <= 0 and var_74_36 or var_74_36 * (var_74_41 / var_74_40)

				if var_74_42 > 0 and var_74_36 < var_74_42 then
					arg_71_1.talkMaxDuration = var_74_42

					if var_74_42 + var_74_35 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_42 + var_74_35
					end
				end

				arg_71_1.text_.text = var_74_39
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111031", "111031017", "story_v_out_111031.awb") ~= 0 then
					local var_74_43 = manager.audio:GetVoiceLength("story_v_out_111031", "111031017", "story_v_out_111031.awb") / 1000

					if var_74_43 + var_74_35 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_43 + var_74_35
					end

					if var_74_38.prefab_name ~= "" and arg_71_1.actors_[var_74_38.prefab_name] ~= nil then
						local var_74_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_38.prefab_name].transform, "story_v_out_111031", "111031017", "story_v_out_111031.awb")

						arg_71_1:RecordAudio("111031017", var_74_44)
						arg_71_1:RecordAudio("111031017", var_74_44)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_111031", "111031017", "story_v_out_111031.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_111031", "111031017", "story_v_out_111031.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_45 = math.max(var_74_36, arg_71_1.talkMaxDuration)

			if var_74_35 <= arg_71_1.time_ and arg_71_1.time_ < var_74_35 + var_74_45 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_35) / var_74_45

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_35 + var_74_45 and arg_71_1.time_ < var_74_35 + var_74_45 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
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
			}
		}

		arg_71_1:InitPlayNodeList()
	end,
	Play111031018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 111031018
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play111031019(arg_75_1)
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
			local var_78_7 = 0.375

			if var_78_6 < arg_75_1.time_ and arg_75_1.time_ <= var_78_6 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, false)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_8 = arg_75_1:GetWordFromCfg(111031018)
				local var_78_9 = arg_75_1:FormatText(var_78_8.content)

				arg_75_1.text_.text = var_78_9

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_10 = 15
				local var_78_11 = utf8.len(var_78_9)
				local var_78_12 = var_78_10 <= 0 and var_78_7 or var_78_7 * (var_78_11 / var_78_10)

				if var_78_12 > 0 and var_78_7 < var_78_12 then
					arg_75_1.talkMaxDuration = var_78_12

					if var_78_12 + var_78_6 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_12 + var_78_6
					end
				end

				arg_75_1.text_.text = var_78_9
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_13 = math.max(var_78_7, arg_75_1.talkMaxDuration)

			if var_78_6 <= arg_75_1.time_ and arg_75_1.time_ < var_78_6 + var_78_13 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_6) / var_78_13

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_6 + var_78_13 and arg_75_1.time_ < var_78_6 + var_78_13 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play111031019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 111031019
		arg_79_1.duration_ = 1.3

		local var_79_0 = {
			ja = 0.999999999999,
			ko = 0.999999999999,
			zh = 1.3,
			en = 1.2
		}
		local var_79_1 = manager.audio:GetLocalizationFlag()

		if var_79_0[var_79_1] ~= nil then
			arg_79_1.duration_ = var_79_0[var_79_1]
		end

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play111031020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0
			local var_82_1 = 0.1

			if var_82_0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_2 = arg_79_1:FormatText(StoryNameCfg[8].name)

				arg_79_1.leftNameTxt_.text = var_82_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, true)
				arg_79_1.iconController_:SetSelectedState("hero")

				arg_79_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1048")

				arg_79_1.callingController_:SetSelectedState("normal")

				arg_79_1.keyicon_.color = Color.New(1, 1, 1)
				arg_79_1.icon_.color = Color.New(1, 1, 1)

				local var_82_3 = arg_79_1:GetWordFromCfg(111031019)
				local var_82_4 = arg_79_1:FormatText(var_82_3.content)

				arg_79_1.text_.text = var_82_4

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_5 = 4
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

				if manager.audio:GetVoiceLength("story_v_out_111031", "111031019", "story_v_out_111031.awb") ~= 0 then
					local var_82_8 = manager.audio:GetVoiceLength("story_v_out_111031", "111031019", "story_v_out_111031.awb") / 1000

					if var_82_8 + var_82_0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_8 + var_82_0
					end

					if var_82_3.prefab_name ~= "" and arg_79_1.actors_[var_82_3.prefab_name] ~= nil then
						local var_82_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_3.prefab_name].transform, "story_v_out_111031", "111031019", "story_v_out_111031.awb")

						arg_79_1:RecordAudio("111031019", var_82_9)
						arg_79_1:RecordAudio("111031019", var_82_9)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_111031", "111031019", "story_v_out_111031.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_111031", "111031019", "story_v_out_111031.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_10 = math.max(var_82_1, arg_79_1.talkMaxDuration)

			if var_82_0 <= arg_79_1.time_ and arg_79_1.time_ < var_82_0 + var_82_10 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_0) / var_82_10

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_0 + var_82_10 and arg_79_1.time_ < var_82_0 + var_82_10 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play111031020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 111031020
		arg_83_1.duration_ = 2.57

		local var_83_0 = {
			ja = 2.233,
			ko = 2.066,
			zh = 2.466,
			en = 2.566
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
				arg_83_0:Play111031021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 0

			if var_86_0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_0 + arg_86_0 then
				arg_83_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action434")
			end

			local var_86_1 = 0

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 then
				arg_83_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_86_2 = arg_83_1.actors_["1084ui_story"]
			local var_86_3 = 0

			if var_86_3 < arg_83_1.time_ and arg_83_1.time_ <= var_86_3 + arg_86_0 and not isNil(var_86_2) and arg_83_1.var_.characterEffect1084ui_story == nil then
				arg_83_1.var_.characterEffect1084ui_story = var_86_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_4 = 0.2

			if var_86_3 <= arg_83_1.time_ and arg_83_1.time_ < var_86_3 + var_86_4 and not isNil(var_86_2) then
				local var_86_5 = (arg_83_1.time_ - var_86_3) / var_86_4

				if arg_83_1.var_.characterEffect1084ui_story and not isNil(var_86_2) then
					arg_83_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_83_1.time_ >= var_86_3 + var_86_4 and arg_83_1.time_ < var_86_3 + var_86_4 + arg_86_0 and not isNil(var_86_2) and arg_83_1.var_.characterEffect1084ui_story then
				arg_83_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_86_6 = 0
			local var_86_7 = 0.2

			if var_86_6 < arg_83_1.time_ and arg_83_1.time_ <= var_86_6 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_8 = arg_83_1:FormatText(StoryNameCfg[6].name)

				arg_83_1.leftNameTxt_.text = var_86_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_9 = arg_83_1:GetWordFromCfg(111031020)
				local var_86_10 = arg_83_1:FormatText(var_86_9.content)

				arg_83_1.text_.text = var_86_10

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_11 = 8
				local var_86_12 = utf8.len(var_86_10)
				local var_86_13 = var_86_11 <= 0 and var_86_7 or var_86_7 * (var_86_12 / var_86_11)

				if var_86_13 > 0 and var_86_7 < var_86_13 then
					arg_83_1.talkMaxDuration = var_86_13

					if var_86_13 + var_86_6 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_13 + var_86_6
					end
				end

				arg_83_1.text_.text = var_86_10
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111031", "111031020", "story_v_out_111031.awb") ~= 0 then
					local var_86_14 = manager.audio:GetVoiceLength("story_v_out_111031", "111031020", "story_v_out_111031.awb") / 1000

					if var_86_14 + var_86_6 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_14 + var_86_6
					end

					if var_86_9.prefab_name ~= "" and arg_83_1.actors_[var_86_9.prefab_name] ~= nil then
						local var_86_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_9.prefab_name].transform, "story_v_out_111031", "111031020", "story_v_out_111031.awb")

						arg_83_1:RecordAudio("111031020", var_86_15)
						arg_83_1:RecordAudio("111031020", var_86_15)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_111031", "111031020", "story_v_out_111031.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_111031", "111031020", "story_v_out_111031.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_16 = math.max(var_86_7, arg_83_1.talkMaxDuration)

			if var_86_6 <= arg_83_1.time_ and arg_83_1.time_ < var_86_6 + var_86_16 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_6) / var_86_16

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_6 + var_86_16 and arg_83_1.time_ < var_86_6 + var_86_16 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play111031021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 111031021
		arg_87_1.duration_ = 2.43

		local var_87_0 = {
			ja = 2.433,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_87_0:Play111031022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0

			if var_90_0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_0 + arg_90_0 then
				arg_87_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action453")
			end

			local var_90_1 = 0

			if var_90_1 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 then
				arg_87_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_90_2 = arg_87_1.actors_["1039ui_story"]
			local var_90_3 = 0

			if var_90_3 < arg_87_1.time_ and arg_87_1.time_ <= var_90_3 + arg_90_0 and not isNil(var_90_2) and arg_87_1.var_.characterEffect1039ui_story == nil then
				arg_87_1.var_.characterEffect1039ui_story = var_90_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_4 = 0.2

			if var_90_3 <= arg_87_1.time_ and arg_87_1.time_ < var_90_3 + var_90_4 and not isNil(var_90_2) then
				local var_90_5 = (arg_87_1.time_ - var_90_3) / var_90_4

				if arg_87_1.var_.characterEffect1039ui_story and not isNil(var_90_2) then
					arg_87_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= var_90_3 + var_90_4 and arg_87_1.time_ < var_90_3 + var_90_4 + arg_90_0 and not isNil(var_90_2) and arg_87_1.var_.characterEffect1039ui_story then
				arg_87_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_90_6 = arg_87_1.actors_["1084ui_story"]
			local var_90_7 = 0

			if var_90_7 < arg_87_1.time_ and arg_87_1.time_ <= var_90_7 + arg_90_0 and not isNil(var_90_6) and arg_87_1.var_.characterEffect1084ui_story == nil then
				arg_87_1.var_.characterEffect1084ui_story = var_90_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_8 = 0.2

			if var_90_7 <= arg_87_1.time_ and arg_87_1.time_ < var_90_7 + var_90_8 and not isNil(var_90_6) then
				local var_90_9 = (arg_87_1.time_ - var_90_7) / var_90_8

				if arg_87_1.var_.characterEffect1084ui_story and not isNil(var_90_6) then
					local var_90_10 = Mathf.Lerp(0, 0.5, var_90_9)

					arg_87_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_87_1.var_.characterEffect1084ui_story.fillRatio = var_90_10
				end
			end

			if arg_87_1.time_ >= var_90_7 + var_90_8 and arg_87_1.time_ < var_90_7 + var_90_8 + arg_90_0 and not isNil(var_90_6) and arg_87_1.var_.characterEffect1084ui_story then
				local var_90_11 = 0.5

				arg_87_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_87_1.var_.characterEffect1084ui_story.fillRatio = var_90_11
			end

			local var_90_12 = 0
			local var_90_13 = 0.075

			if var_90_12 < arg_87_1.time_ and arg_87_1.time_ <= var_90_12 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_14 = arg_87_1:FormatText(StoryNameCfg[9].name)

				arg_87_1.leftNameTxt_.text = var_90_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_15 = arg_87_1:GetWordFromCfg(111031021)
				local var_90_16 = arg_87_1:FormatText(var_90_15.content)

				arg_87_1.text_.text = var_90_16

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_17 = 3
				local var_90_18 = utf8.len(var_90_16)
				local var_90_19 = var_90_17 <= 0 and var_90_13 or var_90_13 * (var_90_18 / var_90_17)

				if var_90_19 > 0 and var_90_13 < var_90_19 then
					arg_87_1.talkMaxDuration = var_90_19

					if var_90_19 + var_90_12 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_19 + var_90_12
					end
				end

				arg_87_1.text_.text = var_90_16
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111031", "111031021", "story_v_out_111031.awb") ~= 0 then
					local var_90_20 = manager.audio:GetVoiceLength("story_v_out_111031", "111031021", "story_v_out_111031.awb") / 1000

					if var_90_20 + var_90_12 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_20 + var_90_12
					end

					if var_90_15.prefab_name ~= "" and arg_87_1.actors_[var_90_15.prefab_name] ~= nil then
						local var_90_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_15.prefab_name].transform, "story_v_out_111031", "111031021", "story_v_out_111031.awb")

						arg_87_1:RecordAudio("111031021", var_90_21)
						arg_87_1:RecordAudio("111031021", var_90_21)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_111031", "111031021", "story_v_out_111031.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_111031", "111031021", "story_v_out_111031.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_22 = math.max(var_90_13, arg_87_1.talkMaxDuration)

			if var_90_12 <= arg_87_1.time_ and arg_87_1.time_ < var_90_12 + var_90_22 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_12) / var_90_22

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_12 + var_90_22 and arg_87_1.time_ < var_90_12 + var_90_22 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play111031022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 111031022
		arg_91_1.duration_ = 6.5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play111031023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = arg_91_1.bgs_.D12b.transform
			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 then
				arg_91_1.var_.moveOldPosD12b = var_94_0.localPosition
				var_94_0.localScale = Vector3.New(1.2, 1.2, 1.2)
			end

			local var_94_2 = 1.5

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_2 then
				local var_94_3 = (arg_91_1.time_ - var_94_1) / var_94_2
				local var_94_4 = Vector3.New(0, 1, 10)

				var_94_0.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPosD12b, var_94_4, var_94_3)
			end

			if arg_91_1.time_ >= var_94_1 + var_94_2 and arg_91_1.time_ < var_94_1 + var_94_2 + arg_94_0 then
				var_94_0.localPosition = Vector3.New(0, 1, 10)
			end

			local var_94_5 = arg_91_1.actors_["1084ui_story"].transform
			local var_94_6 = 0

			if var_94_6 < arg_91_1.time_ and arg_91_1.time_ <= var_94_6 + arg_94_0 then
				arg_91_1.var_.moveOldPos1084ui_story = var_94_5.localPosition
			end

			local var_94_7 = 0.001

			if var_94_6 <= arg_91_1.time_ and arg_91_1.time_ < var_94_6 + var_94_7 then
				local var_94_8 = (arg_91_1.time_ - var_94_6) / var_94_7
				local var_94_9 = Vector3.New(0, 100, 0)

				var_94_5.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1084ui_story, var_94_9, var_94_8)

				local var_94_10 = manager.ui.mainCamera.transform.position - var_94_5.position

				var_94_5.forward = Vector3.New(var_94_10.x, var_94_10.y, var_94_10.z)

				local var_94_11 = var_94_5.localEulerAngles

				var_94_11.z = 0
				var_94_11.x = 0
				var_94_5.localEulerAngles = var_94_11
			end

			if arg_91_1.time_ >= var_94_6 + var_94_7 and arg_91_1.time_ < var_94_6 + var_94_7 + arg_94_0 then
				var_94_5.localPosition = Vector3.New(0, 100, 0)

				local var_94_12 = manager.ui.mainCamera.transform.position - var_94_5.position

				var_94_5.forward = Vector3.New(var_94_12.x, var_94_12.y, var_94_12.z)

				local var_94_13 = var_94_5.localEulerAngles

				var_94_13.z = 0
				var_94_13.x = 0
				var_94_5.localEulerAngles = var_94_13
			end

			local var_94_14 = arg_91_1.actors_["1039ui_story"].transform
			local var_94_15 = 0

			if var_94_15 < arg_91_1.time_ and arg_91_1.time_ <= var_94_15 + arg_94_0 then
				arg_91_1.var_.moveOldPos1039ui_story = var_94_14.localPosition

				local var_94_16 = "1039ui_story"

				arg_91_1:ShowWeapon(arg_91_1.var_[var_94_16 .. "Animator"].transform, false)
			end

			local var_94_17 = 0.001

			if var_94_15 <= arg_91_1.time_ and arg_91_1.time_ < var_94_15 + var_94_17 then
				local var_94_18 = (arg_91_1.time_ - var_94_15) / var_94_17
				local var_94_19 = Vector3.New(0, 100, 0)

				var_94_14.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1039ui_story, var_94_19, var_94_18)

				local var_94_20 = manager.ui.mainCamera.transform.position - var_94_14.position

				var_94_14.forward = Vector3.New(var_94_20.x, var_94_20.y, var_94_20.z)

				local var_94_21 = var_94_14.localEulerAngles

				var_94_21.z = 0
				var_94_21.x = 0
				var_94_14.localEulerAngles = var_94_21
			end

			if arg_91_1.time_ >= var_94_15 + var_94_17 and arg_91_1.time_ < var_94_15 + var_94_17 + arg_94_0 then
				var_94_14.localPosition = Vector3.New(0, 100, 0)

				local var_94_22 = manager.ui.mainCamera.transform.position - var_94_14.position

				var_94_14.forward = Vector3.New(var_94_22.x, var_94_22.y, var_94_22.z)

				local var_94_23 = var_94_14.localEulerAngles

				var_94_23.z = 0
				var_94_23.x = 0
				var_94_14.localEulerAngles = var_94_23
			end

			if arg_91_1.frameCnt_ <= 1 then
				arg_91_1.dialog_:SetActive(false)
			end

			local var_94_24 = 1.5
			local var_94_25 = 0.75

			if var_94_24 < arg_91_1.time_ and arg_91_1.time_ <= var_94_24 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0

				arg_91_1.dialog_:SetActive(true)

				arg_91_1.dialogCg_.alpha = 0

				local var_94_26 = LeanTween.value(arg_91_1.dialog_, 0, 1, 0.3)

				var_94_26:setOnUpdate(LuaHelper.FloatAction(function(arg_95_0)
					arg_91_1.dialogCg_.alpha = arg_95_0
				end))
				var_94_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_91_1.dialog_)
					var_94_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_91_1.duration_ = arg_91_1.duration_ + 0.3

				SetActive(arg_91_1.leftNameGo_, false)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_27 = arg_91_1:GetWordFromCfg(111031022)
				local var_94_28 = arg_91_1:FormatText(var_94_27.content)

				arg_91_1.text_.text = var_94_28

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_29 = 30
				local var_94_30 = utf8.len(var_94_28)
				local var_94_31 = var_94_29 <= 0 and var_94_25 or var_94_25 * (var_94_30 / var_94_29)

				if var_94_31 > 0 and var_94_25 < var_94_31 then
					arg_91_1.talkMaxDuration = var_94_31
					var_94_24 = var_94_24 + 0.3

					if var_94_31 + var_94_24 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_31 + var_94_24
					end
				end

				arg_91_1.text_.text = var_94_28
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_32 = var_94_24 + 0.3
			local var_94_33 = math.max(var_94_25, arg_91_1.talkMaxDuration)

			if var_94_32 <= arg_91_1.time_ and arg_91_1.time_ < var_94_32 + var_94_33 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_32) / var_94_33

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_32 + var_94_33 and arg_91_1.time_ < var_94_32 + var_94_33 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "D12b",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
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

		arg_91_1:InitPlayNodeList()
	end,
	Play111031023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 111031023
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play111031024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0
			local var_100_1 = 1.15

			if var_100_0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_2 = arg_97_1:GetWordFromCfg(111031023)
				local var_100_3 = arg_97_1:FormatText(var_100_2.content)

				arg_97_1.text_.text = var_100_3

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_4 = 46
				local var_100_5 = utf8.len(var_100_3)
				local var_100_6 = var_100_4 <= 0 and var_100_1 or var_100_1 * (var_100_5 / var_100_4)

				if var_100_6 > 0 and var_100_1 < var_100_6 then
					arg_97_1.talkMaxDuration = var_100_6

					if var_100_6 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_6 + var_100_0
					end
				end

				arg_97_1.text_.text = var_100_3
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_7 = math.max(var_100_1, arg_97_1.talkMaxDuration)

			if var_100_0 <= arg_97_1.time_ and arg_97_1.time_ < var_100_0 + var_100_7 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_0) / var_100_7

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_0 + var_100_7 and arg_97_1.time_ < var_100_0 + var_100_7 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play111031024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 111031024
		arg_101_1.duration_ = 4.3

		local var_101_0 = {
			ja = 2.833,
			ko = 3.566,
			zh = 4.3,
			en = 2.733
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
				arg_101_0:Play111031025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0

			if var_104_0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_0 + arg_104_0 then
				arg_101_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_104_1 = arg_101_1.actors_["1084ui_story"]
			local var_104_2 = 0

			if var_104_2 < arg_101_1.time_ and arg_101_1.time_ <= var_104_2 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect1084ui_story == nil then
				arg_101_1.var_.characterEffect1084ui_story = var_104_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_3 = 0.2

			if var_104_2 <= arg_101_1.time_ and arg_101_1.time_ < var_104_2 + var_104_3 and not isNil(var_104_1) then
				local var_104_4 = (arg_101_1.time_ - var_104_2) / var_104_3

				if arg_101_1.var_.characterEffect1084ui_story and not isNil(var_104_1) then
					arg_101_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= var_104_2 + var_104_3 and arg_101_1.time_ < var_104_2 + var_104_3 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect1084ui_story then
				arg_101_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_104_5 = arg_101_1.actors_["1084ui_story"].transform
			local var_104_6 = 0

			if var_104_6 < arg_101_1.time_ and arg_101_1.time_ <= var_104_6 + arg_104_0 then
				arg_101_1.var_.moveOldPos1084ui_story = var_104_5.localPosition
			end

			local var_104_7 = 0.001

			if var_104_6 <= arg_101_1.time_ and arg_101_1.time_ < var_104_6 + var_104_7 then
				local var_104_8 = (arg_101_1.time_ - var_104_6) / var_104_7
				local var_104_9 = Vector3.New(-0.7, -0.97, -6)

				var_104_5.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1084ui_story, var_104_9, var_104_8)

				local var_104_10 = manager.ui.mainCamera.transform.position - var_104_5.position

				var_104_5.forward = Vector3.New(var_104_10.x, var_104_10.y, var_104_10.z)

				local var_104_11 = var_104_5.localEulerAngles

				var_104_11.z = 0
				var_104_11.x = 0
				var_104_5.localEulerAngles = var_104_11
			end

			if arg_101_1.time_ >= var_104_6 + var_104_7 and arg_101_1.time_ < var_104_6 + var_104_7 + arg_104_0 then
				var_104_5.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_104_12 = manager.ui.mainCamera.transform.position - var_104_5.position

				var_104_5.forward = Vector3.New(var_104_12.x, var_104_12.y, var_104_12.z)

				local var_104_13 = var_104_5.localEulerAngles

				var_104_13.z = 0
				var_104_13.x = 0
				var_104_5.localEulerAngles = var_104_13
			end

			local var_104_14 = arg_101_1.actors_["1039ui_story"].transform
			local var_104_15 = 0

			if var_104_15 < arg_101_1.time_ and arg_101_1.time_ <= var_104_15 + arg_104_0 then
				arg_101_1.var_.moveOldPos1039ui_story = var_104_14.localPosition
			end

			local var_104_16 = 0.001

			if var_104_15 <= arg_101_1.time_ and arg_101_1.time_ < var_104_15 + var_104_16 then
				local var_104_17 = (arg_101_1.time_ - var_104_15) / var_104_16
				local var_104_18 = Vector3.New(0.7, -1.01, -5.9)

				var_104_14.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1039ui_story, var_104_18, var_104_17)

				local var_104_19 = manager.ui.mainCamera.transform.position - var_104_14.position

				var_104_14.forward = Vector3.New(var_104_19.x, var_104_19.y, var_104_19.z)

				local var_104_20 = var_104_14.localEulerAngles

				var_104_20.z = 0
				var_104_20.x = 0
				var_104_14.localEulerAngles = var_104_20
			end

			if arg_101_1.time_ >= var_104_15 + var_104_16 and arg_101_1.time_ < var_104_15 + var_104_16 + arg_104_0 then
				var_104_14.localPosition = Vector3.New(0.7, -1.01, -5.9)

				local var_104_21 = manager.ui.mainCamera.transform.position - var_104_14.position

				var_104_14.forward = Vector3.New(var_104_21.x, var_104_21.y, var_104_21.z)

				local var_104_22 = var_104_14.localEulerAngles

				var_104_22.z = 0
				var_104_22.x = 0
				var_104_14.localEulerAngles = var_104_22
			end

			local var_104_23 = 0
			local var_104_24 = 0.3

			if var_104_23 < arg_101_1.time_ and arg_101_1.time_ <= var_104_23 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_25 = arg_101_1:FormatText(StoryNameCfg[6].name)

				arg_101_1.leftNameTxt_.text = var_104_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_26 = arg_101_1:GetWordFromCfg(111031024)
				local var_104_27 = arg_101_1:FormatText(var_104_26.content)

				arg_101_1.text_.text = var_104_27

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_28 = 12
				local var_104_29 = utf8.len(var_104_27)
				local var_104_30 = var_104_28 <= 0 and var_104_24 or var_104_24 * (var_104_29 / var_104_28)

				if var_104_30 > 0 and var_104_24 < var_104_30 then
					arg_101_1.talkMaxDuration = var_104_30

					if var_104_30 + var_104_23 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_30 + var_104_23
					end
				end

				arg_101_1.text_.text = var_104_27
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111031", "111031024", "story_v_out_111031.awb") ~= 0 then
					local var_104_31 = manager.audio:GetVoiceLength("story_v_out_111031", "111031024", "story_v_out_111031.awb") / 1000

					if var_104_31 + var_104_23 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_31 + var_104_23
					end

					if var_104_26.prefab_name ~= "" and arg_101_1.actors_[var_104_26.prefab_name] ~= nil then
						local var_104_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_26.prefab_name].transform, "story_v_out_111031", "111031024", "story_v_out_111031.awb")

						arg_101_1:RecordAudio("111031024", var_104_32)
						arg_101_1:RecordAudio("111031024", var_104_32)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_111031", "111031024", "story_v_out_111031.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_111031", "111031024", "story_v_out_111031.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_33 = math.max(var_104_24, arg_101_1.talkMaxDuration)

			if var_104_23 <= arg_101_1.time_ and arg_101_1.time_ < var_104_23 + var_104_33 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_23) / var_104_33

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_23 + var_104_33 and arg_101_1.time_ < var_104_23 + var_104_33 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
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

		arg_101_1:InitPlayNodeList()
	end,
	Play111031025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 111031025
		arg_105_1.duration_ = 5

		local var_105_0 = {
			ja = 5,
			ko = 4.233,
			zh = 4.166,
			en = 2.733
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
				arg_105_0:Play111031026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0

			if var_108_0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_0 + arg_108_0 then
				arg_105_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action435")
			end

			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2204cva")
			end

			local var_108_2 = arg_105_1.actors_["1039ui_story"]
			local var_108_3 = 0

			if var_108_3 < arg_105_1.time_ and arg_105_1.time_ <= var_108_3 + arg_108_0 and not isNil(var_108_2) and arg_105_1.var_.characterEffect1039ui_story == nil then
				arg_105_1.var_.characterEffect1039ui_story = var_108_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_4 = 0.2

			if var_108_3 <= arg_105_1.time_ and arg_105_1.time_ < var_108_3 + var_108_4 and not isNil(var_108_2) then
				local var_108_5 = (arg_105_1.time_ - var_108_3) / var_108_4

				if arg_105_1.var_.characterEffect1039ui_story and not isNil(var_108_2) then
					arg_105_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= var_108_3 + var_108_4 and arg_105_1.time_ < var_108_3 + var_108_4 + arg_108_0 and not isNil(var_108_2) and arg_105_1.var_.characterEffect1039ui_story then
				arg_105_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_108_6 = arg_105_1.actors_["1084ui_story"]
			local var_108_7 = 0

			if var_108_7 < arg_105_1.time_ and arg_105_1.time_ <= var_108_7 + arg_108_0 and not isNil(var_108_6) and arg_105_1.var_.characterEffect1084ui_story == nil then
				arg_105_1.var_.characterEffect1084ui_story = var_108_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_8 = 0.2

			if var_108_7 <= arg_105_1.time_ and arg_105_1.time_ < var_108_7 + var_108_8 and not isNil(var_108_6) then
				local var_108_9 = (arg_105_1.time_ - var_108_7) / var_108_8

				if arg_105_1.var_.characterEffect1084ui_story and not isNil(var_108_6) then
					local var_108_10 = Mathf.Lerp(0, 0.5, var_108_9)

					arg_105_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1084ui_story.fillRatio = var_108_10
				end
			end

			if arg_105_1.time_ >= var_108_7 + var_108_8 and arg_105_1.time_ < var_108_7 + var_108_8 + arg_108_0 and not isNil(var_108_6) and arg_105_1.var_.characterEffect1084ui_story then
				local var_108_11 = 0.5

				arg_105_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1084ui_story.fillRatio = var_108_11
			end

			local var_108_12 = 0
			local var_108_13 = 0.45

			if var_108_12 < arg_105_1.time_ and arg_105_1.time_ <= var_108_12 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_14 = arg_105_1:FormatText(StoryNameCfg[9].name)

				arg_105_1.leftNameTxt_.text = var_108_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_15 = arg_105_1:GetWordFromCfg(111031025)
				local var_108_16 = arg_105_1:FormatText(var_108_15.content)

				arg_105_1.text_.text = var_108_16

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_17 = 18
				local var_108_18 = utf8.len(var_108_16)
				local var_108_19 = var_108_17 <= 0 and var_108_13 or var_108_13 * (var_108_18 / var_108_17)

				if var_108_19 > 0 and var_108_13 < var_108_19 then
					arg_105_1.talkMaxDuration = var_108_19

					if var_108_19 + var_108_12 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_19 + var_108_12
					end
				end

				arg_105_1.text_.text = var_108_16
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111031", "111031025", "story_v_out_111031.awb") ~= 0 then
					local var_108_20 = manager.audio:GetVoiceLength("story_v_out_111031", "111031025", "story_v_out_111031.awb") / 1000

					if var_108_20 + var_108_12 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_20 + var_108_12
					end

					if var_108_15.prefab_name ~= "" and arg_105_1.actors_[var_108_15.prefab_name] ~= nil then
						local var_108_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_15.prefab_name].transform, "story_v_out_111031", "111031025", "story_v_out_111031.awb")

						arg_105_1:RecordAudio("111031025", var_108_21)
						arg_105_1:RecordAudio("111031025", var_108_21)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_111031", "111031025", "story_v_out_111031.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_111031", "111031025", "story_v_out_111031.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_22 = math.max(var_108_13, arg_105_1.talkMaxDuration)

			if var_108_12 <= arg_105_1.time_ and arg_105_1.time_ < var_108_12 + var_108_22 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_12) / var_108_22

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_12 + var_108_22 and arg_105_1.time_ < var_108_12 + var_108_22 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play111031026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 111031026
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
			arg_109_1.auto_ = false
		end

		function arg_109_1.playNext_(arg_111_0)
			arg_109_1.onStoryFinished_()
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["1039ui_story"]
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect1039ui_story == nil then
				arg_109_1.var_.characterEffect1039ui_story = var_112_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.2

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 and not isNil(var_112_0) then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2

				if arg_109_1.var_.characterEffect1039ui_story and not isNil(var_112_0) then
					local var_112_4 = Mathf.Lerp(0, 0.5, var_112_3)

					arg_109_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_109_1.var_.characterEffect1039ui_story.fillRatio = var_112_4
				end
			end

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect1039ui_story then
				local var_112_5 = 0.5

				arg_109_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_109_1.var_.characterEffect1039ui_story.fillRatio = var_112_5
			end

			local var_112_6 = 0
			local var_112_7 = 0.575

			if var_112_6 < arg_109_1.time_ and arg_109_1.time_ <= var_112_6 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_8 = arg_109_1:FormatText(StoryNameCfg[7].name)

				arg_109_1.leftNameTxt_.text = var_112_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, true)
				arg_109_1.iconController_:SetSelectedState("hero")

				arg_109_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_109_1.callingController_:SetSelectedState("normal")

				arg_109_1.keyicon_.color = Color.New(1, 1, 1)
				arg_109_1.icon_.color = Color.New(1, 1, 1)

				local var_112_9 = arg_109_1:GetWordFromCfg(111031026)
				local var_112_10 = arg_109_1:FormatText(var_112_9.content)

				arg_109_1.text_.text = var_112_10

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_11 = 23
				local var_112_12 = utf8.len(var_112_10)
				local var_112_13 = var_112_11 <= 0 and var_112_7 or var_112_7 * (var_112_12 / var_112_11)

				if var_112_13 > 0 and var_112_7 < var_112_13 then
					arg_109_1.talkMaxDuration = var_112_13

					if var_112_13 + var_112_6 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_13 + var_112_6
					end
				end

				arg_109_1.text_.text = var_112_10
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_14 = math.max(var_112_7, arg_109_1.talkMaxDuration)

			if var_112_6 <= arg_109_1.time_ and arg_109_1.time_ < var_112_6 + var_112_14 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_6) / var_112_14

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_6 + var_112_14 and arg_109_1.time_ < var_112_6 + var_112_14 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/D05",
		"TextureConfig/Background/D12b"
	},
	voices = {
		"story_v_out_111031.awb"
	}
}
