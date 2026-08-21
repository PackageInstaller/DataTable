return {
	Play108021001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 108021001
		arg_1_1.duration_ = 2.02

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play108021003(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "S0807"

			if arg_1_1.bgs_[var_4_0] == nil then
				local var_4_1 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_0)
				var_4_1.name = var_4_0
				var_4_1.transform.parent = arg_1_1.stage_.transform
				var_4_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_0] = var_4_1
			end

			local var_4_2 = 0

			if var_4_2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_2 + arg_4_0 then
				local var_4_3 = manager.ui.mainCamera.transform.localPosition
				local var_4_4 = Vector3.New(0, 0, 10) + Vector3.New(var_4_3.x, var_4_3.y, 0)
				local var_4_5 = arg_1_1.bgs_.S0807

				var_4_5.transform.localPosition = var_4_4
				var_4_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_6 = var_4_5:GetComponent("SpriteRenderer")

				if var_4_6 and var_4_6.sprite then
					local var_4_7 = (var_4_5.transform.localPosition - var_4_3).z
					local var_4_8 = manager.ui.mainCameraCom_
					local var_4_9 = 2 * var_4_7 * Mathf.Tan(var_4_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_10 = var_4_9 * var_4_8.aspect
					local var_4_11 = var_4_6.sprite.bounds.size.x
					local var_4_12 = var_4_6.sprite.bounds.size.y
					local var_4_13 = var_4_10 / var_4_11
					local var_4_14 = var_4_9 / var_4_12
					local var_4_15 = var_4_14 < var_4_13 and var_4_13 or var_4_14

					var_4_5.transform.localScale = Vector3.New(var_4_15, var_4_15, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "S0807" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 0

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.fswbg_:SetActive(true)
				arg_1_1.dialog_:SetActive(false)

				arg_1_1.fswtw_.percent = 0

				local var_4_17 = arg_1_1:GetWordFromCfg(108021001)
				local var_4_18 = arg_1_1:FormatText(var_4_17.content)

				arg_1_1.fswt_.text = var_4_18

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.fswt_)

				arg_1_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_1_1.fswtw_:SetDirty()

				arg_1_1.typewritterCharCountI18N = 0

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_19 = 0.0166666666666666

			if var_4_19 < arg_1_1.time_ and arg_1_1.time_ <= var_4_19 + arg_4_0 then
				arg_1_1.var_.oldValueTypewriter = arg_1_1.fswtw_.percent

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_20 = 30
			local var_4_21 = 2
			local var_4_22 = arg_1_1:GetWordFromCfg(108021001)
			local var_4_23 = arg_1_1:FormatText(var_4_22.content)
			local var_4_24, var_4_25 = arg_1_1:GetPercentByPara(var_4_23, 1)

			if var_4_19 < arg_1_1.time_ and arg_1_1.time_ <= var_4_19 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				local var_4_26 = var_4_20 <= 0 and var_4_21 or var_4_21 * ((var_4_25 - arg_1_1.typewritterCharCountI18N) / var_4_20)

				if var_4_26 > 0 and var_4_21 < var_4_26 then
					arg_1_1.talkMaxDuration = var_4_26

					if var_4_26 + var_4_19 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_26 + var_4_19
					end
				end
			end

			local var_4_27 = 2
			local var_4_28 = math.max(var_4_27, arg_1_1.talkMaxDuration)

			if var_4_19 <= arg_1_1.time_ and arg_1_1.time_ < var_4_19 + var_4_28 then
				local var_4_29 = (arg_1_1.time_ - var_4_19) / var_4_28

				arg_1_1.fswtw_.percent = Mathf.Lerp(arg_1_1.var_.oldValueTypewriter, var_4_24, var_4_29)
				arg_1_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_1_1.fswtw_:SetDirty()
			end

			if arg_1_1.time_ >= var_4_19 + var_4_28 and arg_1_1.time_ < var_4_19 + var_4_28 + arg_4_0 then
				arg_1_1.fswtw_.percent = var_4_24

				arg_1_1.fswtw_:SetDirty()
				arg_1_1:ShowNextGo(true)

				arg_1_1.typewritterCharCountI18N = var_4_25
			end

			local var_4_30 = 0
			local var_4_31 = 1

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_32 = "play"
				local var_4_33 = "music"

				arg_1_1:AudioAction(var_4_32, var_4_33, "bgm_story_scheme", "bgm_story_scheme", "bgm_story_scheme.awb")

				local var_4_34 = ""
				local var_4_35 = manager.audio:GetAudioName("bgm_story_scheme", "bgm_story_scheme")

				if var_4_35 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_35 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_35

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_35
						arg_1_1.bgmTxt2_.text = var_4_35
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

			local var_4_36 = 0

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_37 = 2

			if var_4_36 <= arg_1_1.time_ and arg_1_1.time_ < var_4_36 + var_4_37 then
				local var_4_38 = (arg_1_1.time_ - var_4_36) / var_4_37
				local var_4_39 = Color.New(0, 0, 0)

				var_4_39.a = Mathf.Lerp(1, 0, var_4_38)
				arg_1_1.mask_.color = var_4_39
			end

			if arg_1_1.time_ >= var_4_36 + var_4_37 and arg_1_1.time_ < var_4_36 + var_4_37 + arg_4_0 then
				local var_4_40 = Color.New(0, 0, 0)
				local var_4_41 = 0

				arg_1_1.mask_.enabled = false
				var_4_40.a = var_4_41
				arg_1_1.mask_.color = var_4_40
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play108021003 = function(arg_6_0, arg_6_1)
		arg_6_1.time_ = 0
		arg_6_1.frameCnt_ = 0
		arg_6_1.state_ = "playing"
		arg_6_1.curTalkId_ = 108021003
		arg_6_1.duration_ = 4.32

		SetActive(arg_6_1.tipsGo_, false)

		function arg_6_1.onSingleLineFinish_()
			arg_6_1.onSingleLineUpdate_ = nil
			arg_6_1.onSingleLineFinish_ = nil
			arg_6_1.state_ = "waiting"
		end

		function arg_6_1.playNext_(arg_8_0)
			if arg_8_0 == 1 then
				arg_6_0:Play108021004(arg_6_1)
			end
		end

		function arg_6_1.onSingleLineUpdate_(arg_9_0)
			local var_9_0 = 0

			if var_9_0 < arg_6_1.time_ and arg_6_1.time_ <= var_9_0 + arg_9_0 then
				arg_6_1.var_.oldValueTypewriter = arg_6_1.fswtw_.percent

				SetActive(arg_6_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_6_1:ShowNextGo(false)
			end

			local var_9_1 = 30
			local var_9_2 = 2
			local var_9_3 = arg_6_1:GetWordFromCfg(108021001)
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

			local var_9_8 = 2
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
			local var_9_12 = 4.316
			local var_9_13 = manager.audio:GetVoiceLength("story_v_out_108021", "108021003", "story_v_out_108021.awb") / 1000

			if var_9_13 > 0 and var_9_12 < var_9_13 and var_9_13 + var_9_11 > arg_6_1.duration_ then
				local var_9_14 = var_9_13

				arg_6_1.duration_ = var_9_13 + var_9_11
			end

			if var_9_11 < arg_6_1.time_ and arg_6_1.time_ <= var_9_11 + arg_9_0 then
				local var_9_15 = "play"
				local var_9_16 = "voice"

				arg_6_1:AudioAction(var_9_15, var_9_16, "story_v_out_108021", "108021003", "story_v_out_108021.awb")
			end
		end

		arg_6_1.nodeConfigList_ = {}

		arg_6_1:InitPlayNodeList()
	end,
	Play108021004 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 108021004
		arg_10_1.duration_ = 3.31

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play108021005(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			local var_13_0 = 0

			if var_13_0 < arg_10_1.time_ and arg_10_1.time_ <= var_13_0 + arg_13_0 then
				arg_10_1.var_.oldValueTypewriter = arg_10_1.fswtw_.percent

				SetActive(arg_10_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_10_1:ShowNextGo(false)
			end

			local var_13_1 = 19
			local var_13_2 = 1.26666666666667
			local var_13_3 = arg_10_1:GetWordFromCfg(108021001)
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

			local var_13_8 = 1.26666666666667
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
			local var_13_12 = 3.312
			local var_13_13 = manager.audio:GetVoiceLength("story_v_out_108021", "108021004", "story_v_out_108021.awb") / 1000

			if var_13_13 > 0 and var_13_12 < var_13_13 and var_13_13 + var_13_11 > arg_10_1.duration_ then
				local var_13_14 = var_13_13

				arg_10_1.duration_ = var_13_13 + var_13_11
			end

			if var_13_11 < arg_10_1.time_ and arg_10_1.time_ <= var_13_11 + arg_13_0 then
				local var_13_15 = "play"
				local var_13_16 = "voice"

				arg_10_1:AudioAction(var_13_15, var_13_16, "story_v_out_108021", "108021004", "story_v_out_108021.awb")
			end
		end

		arg_10_1.nodeConfigList_ = {}

		arg_10_1:InitPlayNodeList()
	end,
	Play108021005 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 108021005
		arg_14_1.duration_ = 6.48

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play108021006(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = 0

			if var_17_0 < arg_14_1.time_ and arg_14_1.time_ <= var_17_0 + arg_17_0 then
				arg_14_1.var_.oldValueTypewriter = arg_14_1.fswtw_.percent

				SetActive(arg_14_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_14_1:ShowNextGo(false)
			end

			local var_17_1 = 41
			local var_17_2 = 2.73333333333333
			local var_17_3 = arg_14_1:GetWordFromCfg(108021001)
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

			local var_17_8 = 2.73333333333333
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
			local var_17_12 = 6.477
			local var_17_13 = manager.audio:GetVoiceLength("story_v_out_108021", "108021005", "story_v_out_108021.awb") / 1000

			if var_17_13 > 0 and var_17_12 < var_17_13 and var_17_13 + var_17_11 > arg_14_1.duration_ then
				local var_17_14 = var_17_13

				arg_14_1.duration_ = var_17_13 + var_17_11
			end

			if var_17_11 < arg_14_1.time_ and arg_14_1.time_ <= var_17_11 + arg_17_0 then
				local var_17_15 = "play"
				local var_17_16 = "voice"

				arg_14_1:AudioAction(var_17_15, var_17_16, "story_v_out_108021", "108021005", "story_v_out_108021.awb")
			end
		end

		arg_14_1.nodeConfigList_ = {}

		arg_14_1:InitPlayNodeList()
	end,
	Play108021006 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 108021006
		arg_18_1.duration_ = 11.54

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play108021007(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = 0

			if var_21_0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_0 + arg_21_0 then
				arg_18_1.var_.oldValueTypewriter = arg_18_1.fswtw_.percent

				SetActive(arg_18_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_18_1:ShowNextGo(false)
			end

			local var_21_1 = 58
			local var_21_2 = 3.86666666666667
			local var_21_3 = arg_18_1:GetWordFromCfg(108021001)
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

			local var_21_8 = 3.86666666666667
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
			local var_21_12 = 11.542
			local var_21_13 = manager.audio:GetVoiceLength("story_v_out_108021", "108021006", "story_v_out_108021.awb") / 1000

			if var_21_13 > 0 and var_21_12 < var_21_13 and var_21_13 + var_21_11 > arg_18_1.duration_ then
				local var_21_14 = var_21_13

				arg_18_1.duration_ = var_21_13 + var_21_11
			end

			if var_21_11 < arg_18_1.time_ and arg_18_1.time_ <= var_21_11 + arg_21_0 then
				local var_21_15 = "play"
				local var_21_16 = "voice"

				arg_18_1:AudioAction(var_21_15, var_21_16, "story_v_out_108021", "108021006", "story_v_out_108021.awb")
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play108021007 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 108021007
		arg_22_1.duration_ = 7.01

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play108021008(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = 0

			if var_25_0 < arg_22_1.time_ and arg_22_1.time_ <= var_25_0 + arg_25_0 then
				arg_22_1.var_.oldValueTypewriter = arg_22_1.fswtw_.percent

				SetActive(arg_22_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_22_1:ShowNextGo(false)
			end

			local var_25_1 = 37
			local var_25_2 = 2.46666666666667
			local var_25_3 = arg_22_1:GetWordFromCfg(108021001)
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

			local var_25_8 = 2.46666666666667
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
			local var_25_12 = 7.012
			local var_25_13 = manager.audio:GetVoiceLength("story_v_out_108021", "108021007", "story_v_out_108021.awb") / 1000

			if var_25_13 > 0 and var_25_12 < var_25_13 and var_25_13 + var_25_11 > arg_22_1.duration_ then
				local var_25_14 = var_25_13

				arg_22_1.duration_ = var_25_13 + var_25_11
			end

			if var_25_11 < arg_22_1.time_ and arg_22_1.time_ <= var_25_11 + arg_25_0 then
				local var_25_15 = "play"
				local var_25_16 = "voice"

				arg_22_1:AudioAction(var_25_15, var_25_16, "story_v_out_108021", "108021007", "story_v_out_108021.awb")
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play108021008 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 108021008
		arg_26_1.duration_ = 6.27

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play108021009(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = 0

			if var_29_0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_0 + arg_29_0 then
				arg_26_1.var_.oldValueTypewriter = arg_26_1.fswtw_.percent

				SetActive(arg_26_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_26_1:ShowNextGo(false)
			end

			local var_29_1 = 34
			local var_29_2 = 2.26666666666667
			local var_29_3 = arg_26_1:GetWordFromCfg(108021001)
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

			local var_29_8 = 2.26666666666667
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
			local var_29_12 = 6.266
			local var_29_13 = manager.audio:GetVoiceLength("story_v_out_108021", "108021008", "story_v_out_108021.awb") / 1000

			if var_29_13 > 0 and var_29_12 < var_29_13 and var_29_13 + var_29_11 > arg_26_1.duration_ then
				local var_29_14 = var_29_13

				arg_26_1.duration_ = var_29_13 + var_29_11
			end

			if var_29_11 < arg_26_1.time_ and arg_26_1.time_ <= var_29_11 + arg_29_0 then
				local var_29_15 = "play"
				local var_29_16 = "voice"

				arg_26_1:AudioAction(var_29_15, var_29_16, "story_v_out_108021", "108021008", "story_v_out_108021.awb")
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play108021009 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 108021009
		arg_30_1.duration_ = 5.83

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play108021011(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = 0

			if var_33_0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_0 + arg_33_0 then
				arg_30_1.fswbg_:SetActive(true)
				arg_30_1.dialog_:SetActive(false)

				arg_30_1.fswtw_.percent = 0

				local var_33_1 = arg_30_1:GetWordFromCfg(108021009)
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

			local var_33_4 = 38
			local var_33_5 = 2.53333333333333
			local var_33_6 = arg_30_1:GetWordFromCfg(108021009)
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

			local var_33_11 = 2.53333333333333
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
			local var_33_15 = 5.829
			local var_33_16 = manager.audio:GetVoiceLength("story_v_out_108021", "108021009", "story_v_out_108021.awb") / 1000

			if var_33_16 > 0 and var_33_15 < var_33_16 and var_33_16 + var_33_14 > arg_30_1.duration_ then
				local var_33_17 = var_33_16

				arg_30_1.duration_ = var_33_16 + var_33_14
			end

			if var_33_14 < arg_30_1.time_ and arg_30_1.time_ <= var_33_14 + arg_33_0 then
				local var_33_18 = "play"
				local var_33_19 = "voice"

				arg_30_1:AudioAction(var_33_18, var_33_19, "story_v_out_108021", "108021009", "story_v_out_108021.awb")
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play108021011 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 108021011
		arg_34_1.duration_ = 10.73

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play108021012(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = 0

			if var_37_0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_0 + arg_37_0 then
				arg_34_1.var_.oldValueTypewriter = arg_34_1.fswtw_.percent

				SetActive(arg_34_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_34_1:ShowNextGo(false)
			end

			local var_37_1 = 51
			local var_37_2 = 3.4
			local var_37_3 = arg_34_1:GetWordFromCfg(108021009)
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

			local var_37_8 = 3.4
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
			local var_37_12 = 10.732
			local var_37_13 = manager.audio:GetVoiceLength("story_v_out_108021", "108021011", "story_v_out_108021.awb") / 1000

			if var_37_13 > 0 and var_37_12 < var_37_13 and var_37_13 + var_37_11 > arg_34_1.duration_ then
				local var_37_14 = var_37_13

				arg_34_1.duration_ = var_37_13 + var_37_11
			end

			if var_37_11 < arg_34_1.time_ and arg_34_1.time_ <= var_37_11 + arg_37_0 then
				local var_37_15 = "play"
				local var_37_16 = "voice"

				arg_34_1:AudioAction(var_37_15, var_37_16, "story_v_out_108021", "108021011", "story_v_out_108021.awb")
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play108021012 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 108021012
		arg_38_1.duration_ = 9.13

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play108021013(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = 0

			if var_41_0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_0 + arg_41_0 then
				arg_38_1.var_.oldValueTypewriter = arg_38_1.fswtw_.percent

				SetActive(arg_38_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_38_1:ShowNextGo(false)
			end

			local var_41_1 = 49
			local var_41_2 = 3.26666666666667
			local var_41_3 = arg_38_1:GetWordFromCfg(108021009)
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

			local var_41_8 = 3.26666666666667
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
			local var_41_12 = 9.134
			local var_41_13 = manager.audio:GetVoiceLength("story_v_out_108021", "108021012", "story_v_out_108021.awb") / 1000

			if var_41_13 > 0 and var_41_12 < var_41_13 and var_41_13 + var_41_11 > arg_38_1.duration_ then
				local var_41_14 = var_41_13

				arg_38_1.duration_ = var_41_13 + var_41_11
			end

			if var_41_11 < arg_38_1.time_ and arg_38_1.time_ <= var_41_11 + arg_41_0 then
				local var_41_15 = "play"
				local var_41_16 = "voice"

				arg_38_1:AudioAction(var_41_15, var_41_16, "story_v_out_108021", "108021012", "story_v_out_108021.awb")
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play108021013 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 108021013
		arg_42_1.duration_ = 2.64

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play108021014(arg_42_1)
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
			local var_45_3 = arg_42_1:GetWordFromCfg(108021009)
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
			local var_45_12 = 2.638
			local var_45_13 = manager.audio:GetVoiceLength("story_v_out_108021", "108021013", "story_v_out_108021.awb") / 1000

			if var_45_13 > 0 and var_45_12 < var_45_13 and var_45_13 + var_45_11 > arg_42_1.duration_ then
				local var_45_14 = var_45_13

				arg_42_1.duration_ = var_45_13 + var_45_11
			end

			if var_45_11 < arg_42_1.time_ and arg_42_1.time_ <= var_45_11 + arg_45_0 then
				local var_45_15 = "play"
				local var_45_16 = "voice"

				arg_42_1:AudioAction(var_45_15, var_45_16, "story_v_out_108021", "108021013", "story_v_out_108021.awb")
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play108021014 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 108021014
		arg_46_1.duration_ = 7.22

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play108021015(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = 0

			if var_49_0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_0 + arg_49_0 then
				arg_46_1.var_.oldValueTypewriter = arg_46_1.fswtw_.percent

				SetActive(arg_46_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_46_1:ShowNextGo(false)
			end

			local var_49_1 = 36
			local var_49_2 = 2.4
			local var_49_3 = arg_46_1:GetWordFromCfg(108021009)
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

			local var_49_8 = 2.4
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
			local var_49_12 = 7.216
			local var_49_13 = manager.audio:GetVoiceLength("story_v_out_108021", "108021014", "story_v_out_108021.awb") / 1000

			if var_49_13 > 0 and var_49_12 < var_49_13 and var_49_13 + var_49_11 > arg_46_1.duration_ then
				local var_49_14 = var_49_13

				arg_46_1.duration_ = var_49_13 + var_49_11
			end

			if var_49_11 < arg_46_1.time_ and arg_46_1.time_ <= var_49_11 + arg_49_0 then
				local var_49_15 = "play"
				local var_49_16 = "voice"

				arg_46_1:AudioAction(var_49_15, var_49_16, "story_v_out_108021", "108021014", "story_v_out_108021.awb")
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play108021015 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 108021015
		arg_50_1.duration_ = 3.02

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play108021016(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = 0

			if var_53_0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_0 + arg_53_0 then
				arg_50_1.var_.oldValueTypewriter = arg_50_1.fswtw_.percent

				SetActive(arg_50_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_50_1:ShowNextGo(false)
			end

			local var_53_1 = 18
			local var_53_2 = 1.2
			local var_53_3 = arg_50_1:GetWordFromCfg(108021009)
			local var_53_4 = arg_50_1:FormatText(var_53_3.content)
			local var_53_5, var_53_6 = arg_50_1:GetPercentByPara(var_53_4, 6)

			if var_53_0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_0 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0

				local var_53_7 = var_53_1 <= 0 and var_53_2 or var_53_2 * ((var_53_6 - arg_50_1.typewritterCharCountI18N) / var_53_1)

				if var_53_7 > 0 and var_53_2 < var_53_7 then
					arg_50_1.talkMaxDuration = var_53_7

					if var_53_7 + var_53_0 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_7 + var_53_0
					end
				end
			end

			local var_53_8 = 1.2
			local var_53_9 = math.max(var_53_8, arg_50_1.talkMaxDuration)

			if var_53_0 <= arg_50_1.time_ and arg_50_1.time_ < var_53_0 + var_53_9 then
				local var_53_10 = (arg_50_1.time_ - var_53_0) / var_53_9

				arg_50_1.fswtw_.percent = Mathf.Lerp(arg_50_1.var_.oldValueTypewriter, var_53_5, var_53_10)
				arg_50_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_50_1.fswtw_:SetDirty()
			end

			if arg_50_1.time_ >= var_53_0 + var_53_9 and arg_50_1.time_ < var_53_0 + var_53_9 + arg_53_0 then
				arg_50_1.fswtw_.percent = var_53_5

				arg_50_1.fswtw_:SetDirty()
				arg_50_1:ShowNextGo(true)

				arg_50_1.typewritterCharCountI18N = var_53_6
			end

			local var_53_11 = 0
			local var_53_12 = 3.021
			local var_53_13 = manager.audio:GetVoiceLength("story_v_out_108021", "108021015", "story_v_out_108021.awb") / 1000

			if var_53_13 > 0 and var_53_12 < var_53_13 and var_53_13 + var_53_11 > arg_50_1.duration_ then
				local var_53_14 = var_53_13

				arg_50_1.duration_ = var_53_13 + var_53_11
			end

			if var_53_11 < arg_50_1.time_ and arg_50_1.time_ <= var_53_11 + arg_53_0 then
				local var_53_15 = "play"
				local var_53_16 = "voice"

				arg_50_1:AudioAction(var_53_15, var_53_16, "story_v_out_108021", "108021015", "story_v_out_108021.awb")
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play108021016 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 108021016
		arg_54_1.duration_ = 7

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
			arg_54_1.auto_ = false
		end

		function arg_54_1.playNext_(arg_56_0)
			arg_54_1.onStoryFinished_()
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = "STblack"

			if arg_54_1.bgs_[var_57_0] == nil then
				local var_57_1 = Object.Instantiate(arg_54_1.paintGo_)

				var_57_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_57_0)
				var_57_1.name = var_57_0
				var_57_1.transform.parent = arg_54_1.stage_.transform
				var_57_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_54_1.bgs_[var_57_0] = var_57_1
			end

			local var_57_2 = 0

			if var_57_2 < arg_54_1.time_ and arg_54_1.time_ <= var_57_2 + arg_57_0 then
				local var_57_3 = manager.ui.mainCamera.transform.localPosition
				local var_57_4 = Vector3.New(0, 0, 10) + Vector3.New(var_57_3.x, var_57_3.y, 0)
				local var_57_5 = arg_54_1.bgs_.STblack

				var_57_5.transform.localPosition = var_57_4
				var_57_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_57_6 = var_57_5:GetComponent("SpriteRenderer")

				if var_57_6 and var_57_6.sprite then
					local var_57_7 = (var_57_5.transform.localPosition - var_57_3).z
					local var_57_8 = manager.ui.mainCameraCom_
					local var_57_9 = 2 * var_57_7 * Mathf.Tan(var_57_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_57_10 = var_57_9 * var_57_8.aspect
					local var_57_11 = var_57_6.sprite.bounds.size.x
					local var_57_12 = var_57_6.sprite.bounds.size.y
					local var_57_13 = var_57_10 / var_57_11
					local var_57_14 = var_57_9 / var_57_12
					local var_57_15 = var_57_14 < var_57_13 and var_57_13 or var_57_14

					var_57_5.transform.localScale = Vector3.New(var_57_15, var_57_15, 0)
				end

				for iter_57_0, iter_57_1 in pairs(arg_54_1.bgs_) do
					if iter_57_0 ~= "STblack" then
						iter_57_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_57_16 = 0

			if var_57_16 < arg_54_1.time_ and arg_54_1.time_ <= var_57_16 + arg_57_0 then
				arg_54_1.fswbg_:SetActive(false)
				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_54_1:ShowNextGo(false)
			end

			local var_57_17 = 0

			if var_57_17 < arg_54_1.time_ and arg_54_1.time_ <= var_57_17 + arg_57_0 then
				arg_54_1.mask_.enabled = true
				arg_54_1.mask_.raycastTarget = true

				arg_54_1:SetGaussion(false)
			end

			local var_57_18 = 2

			if var_57_17 <= arg_54_1.time_ and arg_54_1.time_ < var_57_17 + var_57_18 then
				local var_57_19 = (arg_54_1.time_ - var_57_17) / var_57_18
				local var_57_20 = Color.New(0, 0, 0)

				var_57_20.a = Mathf.Lerp(1, 0, var_57_19)
				arg_54_1.mask_.color = var_57_20
			end

			if arg_54_1.time_ >= var_57_17 + var_57_18 and arg_54_1.time_ < var_57_17 + var_57_18 + arg_57_0 then
				local var_57_21 = Color.New(0, 0, 0)
				local var_57_22 = 0

				arg_54_1.mask_.enabled = false
				var_57_21.a = var_57_22
				arg_54_1.mask_.color = var_57_21
			end

			if arg_54_1.frameCnt_ <= 1 then
				arg_54_1.dialog_:SetActive(false)
			end

			local var_57_23 = 2
			local var_57_24 = 0.65

			if var_57_23 < arg_54_1.time_ and arg_54_1.time_ <= var_57_23 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0

				arg_54_1.dialog_:SetActive(true)

				arg_54_1.dialogCg_.alpha = 0

				local var_57_25 = LeanTween.value(arg_54_1.dialog_, 0, 1, 0.3)

				var_57_25:setOnUpdate(LuaHelper.FloatAction(function(arg_58_0)
					arg_54_1.dialogCg_.alpha = arg_58_0
				end))
				var_57_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_54_1.dialog_)
					var_57_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_54_1.duration_ = arg_54_1.duration_ + 0.3

				SetActive(arg_54_1.leftNameGo_, false)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_26 = arg_54_1:GetWordFromCfg(108021016)
				local var_57_27 = arg_54_1:FormatText(var_57_26.content)

				arg_54_1.text_.text = var_57_27

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_28 = 26
				local var_57_29 = utf8.len(var_57_27)
				local var_57_30 = var_57_28 <= 0 and var_57_24 or var_57_24 * (var_57_29 / var_57_28)

				if var_57_30 > 0 and var_57_24 < var_57_30 then
					arg_54_1.talkMaxDuration = var_57_30
					var_57_23 = var_57_23 + 0.3

					if var_57_30 + var_57_23 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_30 + var_57_23
					end
				end

				arg_54_1.text_.text = var_57_27
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)
				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_31 = var_57_23 + 0.3
			local var_57_32 = math.max(var_57_24, arg_54_1.talkMaxDuration)

			if var_57_31 <= arg_54_1.time_ and arg_54_1.time_ < var_57_31 + var_57_32 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_31) / var_57_32

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_31 + var_57_32 and arg_54_1.time_ < var_57_31 + var_57_32 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/S0807",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_108021.awb"
	}
}
