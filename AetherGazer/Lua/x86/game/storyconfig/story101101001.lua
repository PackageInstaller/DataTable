return {
	Play110101001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 110101001
		arg_1_1.duration_ = 5.86

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play110101002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 2

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				arg_1_1.fswbg_:SetActive(true)
				arg_1_1.dialog_:SetActive(false)

				arg_1_1.fswtw_.percent = 0

				local var_4_1 = arg_1_1:GetWordFromCfg(110101001)
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

			local var_4_3 = 2.01666666666667

			if var_4_3 < arg_1_1.time_ and arg_1_1.time_ <= var_4_3 + arg_4_0 then
				arg_1_1.var_.oldValueTypewriter = arg_1_1.fswtw_.percent

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_4 = 17
			local var_4_5 = 1.13333333333333
			local var_4_6 = arg_1_1:GetWordFromCfg(110101001)
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

			local var_4_11 = 1.13333333333333
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

			local var_4_14 = "OS0107"

			if arg_1_1.bgs_[var_4_14] == nil then
				local var_4_15 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_15:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_14)
				var_4_15.name = var_4_14
				var_4_15.transform.parent = arg_1_1.stage_.transform
				var_4_15.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_14] = var_4_15
			end

			local var_4_16 = 0

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				local var_4_17 = manager.ui.mainCamera.transform.localPosition
				local var_4_18 = Vector3.New(0, 0, 10) + Vector3.New(var_4_17.x, var_4_17.y, 0)
				local var_4_19 = arg_1_1.bgs_.OS0107

				var_4_19.transform.localPosition = var_4_18
				var_4_19.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_20 = var_4_19:GetComponent("SpriteRenderer")

				if var_4_20 and var_4_20.sprite then
					local var_4_21 = (var_4_19.transform.localPosition - var_4_17).z
					local var_4_22 = manager.ui.mainCameraCom_
					local var_4_23 = 2 * var_4_21 * Mathf.Tan(var_4_22.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_24 = var_4_23 * var_4_22.aspect
					local var_4_25 = var_4_20.sprite.bounds.size.x
					local var_4_26 = var_4_20.sprite.bounds.size.y
					local var_4_27 = var_4_24 / var_4_25
					local var_4_28 = var_4_23 / var_4_26
					local var_4_29 = var_4_28 < var_4_27 and var_4_27 or var_4_28

					var_4_19.transform.localScale = Vector3.New(var_4_29, var_4_29, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "OS0107" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_30 = arg_1_1.bgs_.OS0107
			local var_4_31 = 0

			if var_4_31 < arg_1_1.time_ and arg_1_1.time_ <= var_4_31 + arg_4_0 then
				local var_4_32 = var_4_30:GetComponent("SpriteRenderer")

				if var_4_32 then
					arg_1_1.var_.alphaOldValueOS0107 = var_4_32.color.a
					arg_1_1.var_.alphaMatValueOS0107 = var_4_32
				end

				arg_1_1.var_.alphaOldValueOS0107 = 0
			end

			local var_4_33 = 1.5

			if var_4_31 <= arg_1_1.time_ and arg_1_1.time_ < var_4_31 + var_4_33 then
				local var_4_34 = (arg_1_1.time_ - var_4_31) / var_4_33
				local var_4_35 = Mathf.Lerp(arg_1_1.var_.alphaOldValueOS0107, 1, var_4_34)

				if arg_1_1.var_.alphaMatValueOS0107 then
					local var_4_36 = arg_1_1.var_.alphaMatValueOS0107.color

					var_4_36.a = var_4_35
					arg_1_1.var_.alphaMatValueOS0107.color = var_4_36
				end
			end

			if arg_1_1.time_ >= var_4_31 + var_4_33 and arg_1_1.time_ < var_4_31 + var_4_33 + arg_4_0 and arg_1_1.var_.alphaMatValueOS0107 then
				local var_4_37 = arg_1_1.var_.alphaMatValueOS0107
				local var_4_38 = var_4_37.color

				var_4_38.a = 1
				var_4_37.color = var_4_38
			end

			local var_4_39 = 0

			if var_4_39 < arg_1_1.time_ and arg_1_1.time_ <= var_4_39 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_40 = 2

			if arg_1_1.time_ >= var_4_39 + var_4_40 and arg_1_1.time_ < var_4_39 + var_4_40 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_41 = 2
			local var_4_42 = 3.856
			local var_4_43 = manager.audio:GetVoiceLength("story_v_out_110101", "110101001", "story_v_out_110101.awb") / 1000

			if var_4_43 > 0 and var_4_42 < var_4_43 and var_4_43 + var_4_41 > arg_1_1.duration_ then
				local var_4_44 = var_4_43

				arg_1_1.duration_ = var_4_43 + var_4_41
			end

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 then
				local var_4_45 = "play"
				local var_4_46 = "voice"

				arg_1_1:AudioAction(var_4_45, var_4_46, "story_v_out_110101", "110101001", "story_v_out_110101.awb")
			end

			local var_4_47 = 0
			local var_4_48 = 0.6

			if var_4_47 < arg_1_1.time_ and arg_1_1.time_ <= var_4_47 + arg_4_0 then
				local var_4_49 = "play"
				local var_4_50 = "music"

				arg_1_1:AudioAction(var_4_49, var_4_50, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_51 = ""
				local var_4_52 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_52 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_52 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_52

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_52
						arg_1_1.bgmTxt2_.text = var_4_52
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

			local var_4_53 = 0.738461699336767
			local var_4_54 = 1

			if var_4_53 < arg_1_1.time_ and arg_1_1.time_ <= var_4_53 + arg_4_0 then
				local var_4_55 = "play"
				local var_4_56 = "music"

				arg_1_1:AudioAction(var_4_55, var_4_56, "bgm_activity_1_0_1_osiris_ui", "bgm_activity_1_0_1_osiris_ui", "bgm_activity_1_0_1_osiris_ui.awb")

				local var_4_57 = ""
				local var_4_58 = manager.audio:GetAudioName("bgm_activity_1_0_1_osiris_ui", "bgm_activity_1_0_1_osiris_ui")

				if var_4_58 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_58 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_58

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_58
						arg_1_1.bgmTxt2_.text = var_4_58
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
	Play110101002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 110101002
		arg_7_1.duration_ = 4.44

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play110101003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			local var_10_0 = 0

			if var_10_0 < arg_7_1.time_ and arg_7_1.time_ <= var_10_0 + arg_10_0 then
				arg_7_1.var_.oldValueTypewriter = arg_7_1.fswtw_.percent

				SetActive(arg_7_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_7_1:ShowNextGo(false)
			end

			local var_10_1 = 28
			local var_10_2 = 1.86666666666667
			local var_10_3 = arg_7_1:GetWordFromCfg(110101001)
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

			local var_10_8 = 1.86666666666667
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
			local var_10_12 = 4.437
			local var_10_13 = manager.audio:GetVoiceLength("story_v_out_110101", "110101002", "story_v_out_110101.awb") / 1000

			if var_10_13 > 0 and var_10_12 < var_10_13 and var_10_13 + var_10_11 > arg_7_1.duration_ then
				local var_10_14 = var_10_13

				arg_7_1.duration_ = var_10_13 + var_10_11
			end

			if var_10_11 < arg_7_1.time_ and arg_7_1.time_ <= var_10_11 + arg_10_0 then
				local var_10_15 = "play"
				local var_10_16 = "voice"

				arg_7_1:AudioAction(var_10_15, var_10_16, "story_v_out_110101", "110101002", "story_v_out_110101.awb")
			end
		end

		arg_7_1.nodeConfigList_ = {}

		arg_7_1:InitPlayNodeList()
	end,
	Play110101003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 110101003
		arg_11_1.duration_ = 4.43

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play110101004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			local var_14_0 = 0

			if var_14_0 < arg_11_1.time_ and arg_11_1.time_ <= var_14_0 + arg_14_0 then
				arg_11_1.var_.oldValueTypewriter = arg_11_1.fswtw_.percent

				SetActive(arg_11_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_11_1:ShowNextGo(false)
			end

			local var_14_1 = 30
			local var_14_2 = 2
			local var_14_3 = arg_11_1:GetWordFromCfg(110101001)
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

			local var_14_8 = 2
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
			local var_14_12 = 4.432
			local var_14_13 = manager.audio:GetVoiceLength("story_v_out_110101", "110101003", "story_v_out_110101.awb") / 1000

			if var_14_13 > 0 and var_14_12 < var_14_13 and var_14_13 + var_14_11 > arg_11_1.duration_ then
				local var_14_14 = var_14_13

				arg_11_1.duration_ = var_14_13 + var_14_11
			end

			if var_14_11 < arg_11_1.time_ and arg_11_1.time_ <= var_14_11 + arg_14_0 then
				local var_14_15 = "play"
				local var_14_16 = "voice"

				arg_11_1:AudioAction(var_14_15, var_14_16, "story_v_out_110101", "110101003", "story_v_out_110101.awb")
			end
		end

		arg_11_1.nodeConfigList_ = {}

		arg_11_1:InitPlayNodeList()
	end,
	Play110101004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 110101004
		arg_15_1.duration_ = 4.72

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play110101005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = 0

			if var_18_0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_0 + arg_18_0 then
				arg_15_1.var_.oldValueTypewriter = arg_15_1.fswtw_.percent

				SetActive(arg_15_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_15_1:ShowNextGo(false)
			end

			local var_18_1 = 26
			local var_18_2 = 1.73333333333333
			local var_18_3 = arg_15_1:GetWordFromCfg(110101001)
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

			local var_18_8 = 1.73333333333333
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
			local var_18_12 = 4.718
			local var_18_13 = manager.audio:GetVoiceLength("story_v_out_110101", "110101004", "story_v_out_110101.awb") / 1000

			if var_18_13 > 0 and var_18_12 < var_18_13 and var_18_13 + var_18_11 > arg_15_1.duration_ then
				local var_18_14 = var_18_13

				arg_15_1.duration_ = var_18_13 + var_18_11
			end

			if var_18_11 < arg_15_1.time_ and arg_15_1.time_ <= var_18_11 + arg_18_0 then
				local var_18_15 = "play"
				local var_18_16 = "voice"

				arg_15_1:AudioAction(var_18_15, var_18_16, "story_v_out_110101", "110101004", "story_v_out_110101.awb")
			end
		end

		arg_15_1.nodeConfigList_ = {}

		arg_15_1:InitPlayNodeList()
	end,
	Play110101005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 110101005
		arg_19_1.duration_ = 9.42

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play110101006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = 0

			if var_22_0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_0 + arg_22_0 then
				arg_19_1.var_.oldValueTypewriter = arg_19_1.fswtw_.percent

				SetActive(arg_19_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_19_1:ShowNextGo(false)
			end

			local var_22_1 = 41
			local var_22_2 = 2.73333333333333
			local var_22_3 = arg_19_1:GetWordFromCfg(110101001)
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

			local var_22_8 = 2.73333333333333
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
			local var_22_12 = 9.418
			local var_22_13 = manager.audio:GetVoiceLength("story_v_out_110101", "110101005", "story_v_out_110101.awb") / 1000

			if var_22_13 > 0 and var_22_12 < var_22_13 and var_22_13 + var_22_11 > arg_19_1.duration_ then
				local var_22_14 = var_22_13

				arg_19_1.duration_ = var_22_13 + var_22_11
			end

			if var_22_11 < arg_19_1.time_ and arg_19_1.time_ <= var_22_11 + arg_22_0 then
				local var_22_15 = "play"
				local var_22_16 = "voice"

				arg_19_1:AudioAction(var_22_15, var_22_16, "story_v_out_110101", "110101005", "story_v_out_110101.awb")
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play110101006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 110101006
		arg_23_1.duration_ = 6.86

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play110101007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = 0

			if var_26_0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_0 + arg_26_0 then
				arg_23_1.var_.oldValueTypewriter = arg_23_1.fswtw_.percent

				SetActive(arg_23_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_23_1:ShowNextGo(false)
			end

			local var_26_1 = 26
			local var_26_2 = 1.73333333333333
			local var_26_3 = arg_23_1:GetWordFromCfg(110101001)
			local var_26_4 = arg_23_1:FormatText(var_26_3.content)
			local var_26_5, var_26_6 = arg_23_1:GetPercentByPara(var_26_4, 6)

			if var_26_0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_0 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0

				local var_26_7 = var_26_1 <= 0 and var_26_2 or var_26_2 * ((var_26_6 - arg_23_1.typewritterCharCountI18N) / var_26_1)

				if var_26_7 > 0 and var_26_2 < var_26_7 then
					arg_23_1.talkMaxDuration = var_26_7

					if var_26_7 + var_26_0 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_7 + var_26_0
					end
				end
			end

			local var_26_8 = 1.73333333333333
			local var_26_9 = math.max(var_26_8, arg_23_1.talkMaxDuration)

			if var_26_0 <= arg_23_1.time_ and arg_23_1.time_ < var_26_0 + var_26_9 then
				local var_26_10 = (arg_23_1.time_ - var_26_0) / var_26_9

				arg_23_1.fswtw_.percent = Mathf.Lerp(arg_23_1.var_.oldValueTypewriter, var_26_5, var_26_10)
				arg_23_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_23_1.fswtw_:SetDirty()
			end

			if arg_23_1.time_ >= var_26_0 + var_26_9 and arg_23_1.time_ < var_26_0 + var_26_9 + arg_26_0 then
				arg_23_1.fswtw_.percent = var_26_5

				arg_23_1.fswtw_:SetDirty()
				arg_23_1:ShowNextGo(true)

				arg_23_1.typewritterCharCountI18N = var_26_6
			end

			local var_26_11 = 0
			local var_26_12 = 6.856
			local var_26_13 = manager.audio:GetVoiceLength("story_v_out_110101", "110101006", "story_v_out_110101.awb") / 1000

			if var_26_13 > 0 and var_26_12 < var_26_13 and var_26_13 + var_26_11 > arg_23_1.duration_ then
				local var_26_14 = var_26_13

				arg_23_1.duration_ = var_26_13 + var_26_11
			end

			if var_26_11 < arg_23_1.time_ and arg_23_1.time_ <= var_26_11 + arg_26_0 then
				local var_26_15 = "play"
				local var_26_16 = "voice"

				arg_23_1:AudioAction(var_26_15, var_26_16, "story_v_out_110101", "110101006", "story_v_out_110101.awb")
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play110101007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 110101007
		arg_27_1.duration_ = 6.45

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play110101008(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = 0

			if var_30_0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_0 + arg_30_0 then
				arg_27_1.var_.oldValueTypewriter = arg_27_1.fswtw_.percent

				SetActive(arg_27_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_27_1:ShowNextGo(false)
			end

			local var_30_1 = 30
			local var_30_2 = 2
			local var_30_3 = arg_27_1:GetWordFromCfg(110101001)
			local var_30_4 = arg_27_1:FormatText(var_30_3.content)
			local var_30_5, var_30_6 = arg_27_1:GetPercentByPara(var_30_4, 7)

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

			local var_30_8 = 2
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
			local var_30_12 = 6.453
			local var_30_13 = manager.audio:GetVoiceLength("story_v_out_110101", "110101007", "story_v_out_110101.awb") / 1000

			if var_30_13 > 0 and var_30_12 < var_30_13 and var_30_13 + var_30_11 > arg_27_1.duration_ then
				local var_30_14 = var_30_13

				arg_27_1.duration_ = var_30_13 + var_30_11
			end

			if var_30_11 < arg_27_1.time_ and arg_27_1.time_ <= var_30_11 + arg_30_0 then
				local var_30_15 = "play"
				local var_30_16 = "voice"

				arg_27_1:AudioAction(var_30_15, var_30_16, "story_v_out_110101", "110101007", "story_v_out_110101.awb")
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play110101008 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 110101008
		arg_31_1.duration_ = 4.99

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play110101009(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = 0

			if var_34_0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_0 + arg_34_0 then
				arg_31_1.fswbg_:SetActive(true)
				arg_31_1.dialog_:SetActive(false)

				arg_31_1.fswtw_.percent = 0

				local var_34_1 = arg_31_1:GetWordFromCfg(110101008)
				local var_34_2 = arg_31_1:FormatText(var_34_1.content)

				arg_31_1.fswt_.text = var_34_2

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.fswt_)

				arg_31_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_31_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_31_1.fswtw_:SetDirty()

				arg_31_1.typewritterCharCountI18N = 0

				SetActive(arg_31_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_31_1:ShowNextGo(false)
			end

			local var_34_3 = 0.0166666666666667

			if var_34_3 < arg_31_1.time_ and arg_31_1.time_ <= var_34_3 + arg_34_0 then
				arg_31_1.var_.oldValueTypewriter = arg_31_1.fswtw_.percent

				SetActive(arg_31_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_31_1:ShowNextGo(false)
			end

			local var_34_4 = 25
			local var_34_5 = 1.66666666666667
			local var_34_6 = arg_31_1:GetWordFromCfg(110101008)
			local var_34_7 = arg_31_1:FormatText(var_34_6.content)
			local var_34_8, var_34_9 = arg_31_1:GetPercentByPara(var_34_7, 1)

			if var_34_3 < arg_31_1.time_ and arg_31_1.time_ <= var_34_3 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0

				local var_34_10 = var_34_4 <= 0 and var_34_5 or var_34_5 * ((var_34_9 - arg_31_1.typewritterCharCountI18N) / var_34_4)

				if var_34_10 > 0 and var_34_5 < var_34_10 then
					arg_31_1.talkMaxDuration = var_34_10

					if var_34_10 + var_34_3 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_10 + var_34_3
					end
				end
			end

			local var_34_11 = 1.66666666666667
			local var_34_12 = math.max(var_34_11, arg_31_1.talkMaxDuration)

			if var_34_3 <= arg_31_1.time_ and arg_31_1.time_ < var_34_3 + var_34_12 then
				local var_34_13 = (arg_31_1.time_ - var_34_3) / var_34_12

				arg_31_1.fswtw_.percent = Mathf.Lerp(arg_31_1.var_.oldValueTypewriter, var_34_8, var_34_13)
				arg_31_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_31_1.fswtw_:SetDirty()
			end

			if arg_31_1.time_ >= var_34_3 + var_34_12 and arg_31_1.time_ < var_34_3 + var_34_12 + arg_34_0 then
				arg_31_1.fswtw_.percent = var_34_8

				arg_31_1.fswtw_:SetDirty()
				arg_31_1:ShowNextGo(true)

				arg_31_1.typewritterCharCountI18N = var_34_9
			end

			local var_34_14 = 0
			local var_34_15 = 4.992
			local var_34_16 = manager.audio:GetVoiceLength("story_v_out_110101", "110101008", "story_v_out_110101.awb") / 1000

			if var_34_16 > 0 and var_34_15 < var_34_16 and var_34_16 + var_34_14 > arg_31_1.duration_ then
				local var_34_17 = var_34_16

				arg_31_1.duration_ = var_34_16 + var_34_14
			end

			if var_34_14 < arg_31_1.time_ and arg_31_1.time_ <= var_34_14 + arg_34_0 then
				local var_34_18 = "play"
				local var_34_19 = "voice"

				arg_31_1:AudioAction(var_34_18, var_34_19, "story_v_out_110101", "110101008", "story_v_out_110101.awb")
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play110101009 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 110101009
		arg_35_1.duration_ = 5.4

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play110101010(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 0

			if var_38_0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_0 + arg_38_0 then
				arg_35_1.var_.oldValueTypewriter = arg_35_1.fswtw_.percent

				SetActive(arg_35_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_35_1:ShowNextGo(false)
			end

			local var_38_1 = 26
			local var_38_2 = 1.73333333333333
			local var_38_3 = arg_35_1:GetWordFromCfg(110101008)
			local var_38_4 = arg_35_1:FormatText(var_38_3.content)
			local var_38_5, var_38_6 = arg_35_1:GetPercentByPara(var_38_4, 2)

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

			local var_38_8 = 1.73333333333333
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
			local var_38_12 = 5.402
			local var_38_13 = manager.audio:GetVoiceLength("story_v_out_110101", "110101009", "story_v_out_110101.awb") / 1000

			if var_38_13 > 0 and var_38_12 < var_38_13 and var_38_13 + var_38_11 > arg_35_1.duration_ then
				local var_38_14 = var_38_13

				arg_35_1.duration_ = var_38_13 + var_38_11
			end

			if var_38_11 < arg_35_1.time_ and arg_35_1.time_ <= var_38_11 + arg_38_0 then
				local var_38_15 = "play"
				local var_38_16 = "voice"

				arg_35_1:AudioAction(var_38_15, var_38_16, "story_v_out_110101", "110101009", "story_v_out_110101.awb")
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play110101010 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 110101010
		arg_39_1.duration_ = 5.41

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play110101011(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0

			if var_42_0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_0 + arg_42_0 then
				arg_39_1.var_.oldValueTypewriter = arg_39_1.fswtw_.percent

				SetActive(arg_39_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_39_1:ShowNextGo(false)
			end

			local var_42_1 = 28
			local var_42_2 = 1.86666666666667
			local var_42_3 = arg_39_1:GetWordFromCfg(110101008)
			local var_42_4 = arg_39_1:FormatText(var_42_3.content)
			local var_42_5, var_42_6 = arg_39_1:GetPercentByPara(var_42_4, 3)

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

			local var_42_8 = 1.86666666666667
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
			local var_42_12 = 5.413
			local var_42_13 = manager.audio:GetVoiceLength("story_v_out_110101", "110101010", "story_v_out_110101.awb") / 1000

			if var_42_13 > 0 and var_42_12 < var_42_13 and var_42_13 + var_42_11 > arg_39_1.duration_ then
				local var_42_14 = var_42_13

				arg_39_1.duration_ = var_42_13 + var_42_11
			end

			if var_42_11 < arg_39_1.time_ and arg_39_1.time_ <= var_42_11 + arg_42_0 then
				local var_42_15 = "play"
				local var_42_16 = "voice"

				arg_39_1:AudioAction(var_42_15, var_42_16, "story_v_out_110101", "110101010", "story_v_out_110101.awb")
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play110101011 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 110101011
		arg_43_1.duration_ = 4.31

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play110101012(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 0

			if var_46_0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_0 + arg_46_0 then
				arg_43_1.var_.oldValueTypewriter = arg_43_1.fswtw_.percent

				SetActive(arg_43_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_43_1:ShowNextGo(false)
			end

			local var_46_1 = 21
			local var_46_2 = 1.4
			local var_46_3 = arg_43_1:GetWordFromCfg(110101008)
			local var_46_4 = arg_43_1:FormatText(var_46_3.content)
			local var_46_5, var_46_6 = arg_43_1:GetPercentByPara(var_46_4, 4)

			if var_46_0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_0 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0

				local var_46_7 = var_46_1 <= 0 and var_46_2 or var_46_2 * ((var_46_6 - arg_43_1.typewritterCharCountI18N) / var_46_1)

				if var_46_7 > 0 and var_46_2 < var_46_7 then
					arg_43_1.talkMaxDuration = var_46_7

					if var_46_7 + var_46_0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_7 + var_46_0
					end
				end
			end

			local var_46_8 = 1.4
			local var_46_9 = math.max(var_46_8, arg_43_1.talkMaxDuration)

			if var_46_0 <= arg_43_1.time_ and arg_43_1.time_ < var_46_0 + var_46_9 then
				local var_46_10 = (arg_43_1.time_ - var_46_0) / var_46_9

				arg_43_1.fswtw_.percent = Mathf.Lerp(arg_43_1.var_.oldValueTypewriter, var_46_5, var_46_10)
				arg_43_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_43_1.fswtw_:SetDirty()
			end

			if arg_43_1.time_ >= var_46_0 + var_46_9 and arg_43_1.time_ < var_46_0 + var_46_9 + arg_46_0 then
				arg_43_1.fswtw_.percent = var_46_5

				arg_43_1.fswtw_:SetDirty()
				arg_43_1:ShowNextGo(true)

				arg_43_1.typewritterCharCountI18N = var_46_6
			end

			local var_46_11 = 0
			local var_46_12 = 4.312
			local var_46_13 = manager.audio:GetVoiceLength("story_v_out_110101", "110101011", "story_v_out_110101.awb") / 1000

			if var_46_13 > 0 and var_46_12 < var_46_13 and var_46_13 + var_46_11 > arg_43_1.duration_ then
				local var_46_14 = var_46_13

				arg_43_1.duration_ = var_46_13 + var_46_11
			end

			if var_46_11 < arg_43_1.time_ and arg_43_1.time_ <= var_46_11 + arg_46_0 then
				local var_46_15 = "play"
				local var_46_16 = "voice"

				arg_43_1:AudioAction(var_46_15, var_46_16, "story_v_out_110101", "110101011", "story_v_out_110101.awb")
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play110101012 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 110101012
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play110101013(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = 0

			if var_50_0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_0 + arg_50_0 then
				arg_47_1.var_.oldValueTypewriter = arg_47_1.fswtw_.percent

				SetActive(arg_47_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_47_1:ShowNextGo(false)
			end

			local var_50_1 = 32
			local var_50_2 = 2.13333333333333
			local var_50_3 = arg_47_1:GetWordFromCfg(110101008)
			local var_50_4 = arg_47_1:FormatText(var_50_3.content)
			local var_50_5, var_50_6 = arg_47_1:GetPercentByPara(var_50_4, 5)

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

			local var_50_8 = 2.13333333333333
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
			local var_50_12 = 5.002
			local var_50_13 = manager.audio:GetVoiceLength("story_v_out_110101", "110101012", "story_v_out_110101.awb") / 1000

			if var_50_13 > 0 and var_50_12 < var_50_13 and var_50_13 + var_50_11 > arg_47_1.duration_ then
				local var_50_14 = var_50_13

				arg_47_1.duration_ = var_50_13 + var_50_11
			end

			if var_50_11 < arg_47_1.time_ and arg_47_1.time_ <= var_50_11 + arg_50_0 then
				local var_50_15 = "play"
				local var_50_16 = "voice"

				arg_47_1:AudioAction(var_50_15, var_50_16, "story_v_out_110101", "110101012", "story_v_out_110101.awb")
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play110101013 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 110101013
		arg_51_1.duration_ = 8.69

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play110101014(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 0

			if var_54_0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_0 + arg_54_0 then
				arg_51_1.var_.oldValueTypewriter = arg_51_1.fswtw_.percent

				SetActive(arg_51_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_51_1:ShowNextGo(false)
			end

			local var_54_1 = 35
			local var_54_2 = 2.33333333333333
			local var_54_3 = arg_51_1:GetWordFromCfg(110101008)
			local var_54_4 = arg_51_1:FormatText(var_54_3.content)
			local var_54_5, var_54_6 = arg_51_1:GetPercentByPara(var_54_4, 6)

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

			local var_54_8 = 2.33333333333333
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
			local var_54_12 = 8.688
			local var_54_13 = manager.audio:GetVoiceLength("story_v_out_110101", "110101013", "story_v_out_110101.awb") / 1000

			if var_54_13 > 0 and var_54_12 < var_54_13 and var_54_13 + var_54_11 > arg_51_1.duration_ then
				local var_54_14 = var_54_13

				arg_51_1.duration_ = var_54_13 + var_54_11
			end

			if var_54_11 < arg_51_1.time_ and arg_51_1.time_ <= var_54_11 + arg_54_0 then
				local var_54_15 = "play"
				local var_54_16 = "voice"

				arg_51_1:AudioAction(var_54_15, var_54_16, "story_v_out_110101", "110101013", "story_v_out_110101.awb")
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play110101014 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 110101014
		arg_55_1.duration_ = 7.93

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play110101015(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0

			if var_58_0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_0 + arg_58_0 then
				arg_55_1.var_.oldValueTypewriter = arg_55_1.fswtw_.percent

				SetActive(arg_55_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_55_1:ShowNextGo(false)
			end

			local var_58_1 = 27
			local var_58_2 = 1.8
			local var_58_3 = arg_55_1:GetWordFromCfg(110101008)
			local var_58_4 = arg_55_1:FormatText(var_58_3.content)
			local var_58_5, var_58_6 = arg_55_1:GetPercentByPara(var_58_4, 7)

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

			local var_58_8 = 1.8
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
			local var_58_12 = 7.933
			local var_58_13 = manager.audio:GetVoiceLength("story_v_out_110101", "110101014", "story_v_out_110101.awb") / 1000

			if var_58_13 > 0 and var_58_12 < var_58_13 and var_58_13 + var_58_11 > arg_55_1.duration_ then
				local var_58_14 = var_58_13

				arg_55_1.duration_ = var_58_13 + var_58_11
			end

			if var_58_11 < arg_55_1.time_ and arg_55_1.time_ <= var_58_11 + arg_58_0 then
				local var_58_15 = "play"
				local var_58_16 = "voice"

				arg_55_1:AudioAction(var_58_15, var_58_16, "story_v_out_110101", "110101014", "story_v_out_110101.awb")
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play110101015 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 110101015
		arg_59_1.duration_ = 5.95

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play110101016(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0

			if var_62_0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_0 + arg_62_0 then
				arg_59_1.fswbg_:SetActive(true)
				arg_59_1.dialog_:SetActive(false)

				arg_59_1.fswtw_.percent = 0

				local var_62_1 = arg_59_1:GetWordFromCfg(110101015)
				local var_62_2 = arg_59_1:FormatText(var_62_1.content)

				arg_59_1.fswt_.text = var_62_2

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.fswt_)

				arg_59_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_59_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_59_1.fswtw_:SetDirty()

				arg_59_1.typewritterCharCountI18N = 0

				SetActive(arg_59_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_59_1:ShowNextGo(false)
			end

			local var_62_3 = 0.0166666666666667

			if var_62_3 < arg_59_1.time_ and arg_59_1.time_ <= var_62_3 + arg_62_0 then
				arg_59_1.var_.oldValueTypewriter = arg_59_1.fswtw_.percent

				SetActive(arg_59_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_59_1:ShowNextGo(false)
			end

			local var_62_4 = 27
			local var_62_5 = 1.8
			local var_62_6 = arg_59_1:GetWordFromCfg(110101015)
			local var_62_7 = arg_59_1:FormatText(var_62_6.content)
			local var_62_8, var_62_9 = arg_59_1:GetPercentByPara(var_62_7, 1)

			if var_62_3 < arg_59_1.time_ and arg_59_1.time_ <= var_62_3 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0

				local var_62_10 = var_62_4 <= 0 and var_62_5 or var_62_5 * ((var_62_9 - arg_59_1.typewritterCharCountI18N) / var_62_4)

				if var_62_10 > 0 and var_62_5 < var_62_10 then
					arg_59_1.talkMaxDuration = var_62_10

					if var_62_10 + var_62_3 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_10 + var_62_3
					end
				end
			end

			local var_62_11 = 1.8
			local var_62_12 = math.max(var_62_11, arg_59_1.talkMaxDuration)

			if var_62_3 <= arg_59_1.time_ and arg_59_1.time_ < var_62_3 + var_62_12 then
				local var_62_13 = (arg_59_1.time_ - var_62_3) / var_62_12

				arg_59_1.fswtw_.percent = Mathf.Lerp(arg_59_1.var_.oldValueTypewriter, var_62_8, var_62_13)
				arg_59_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_59_1.fswtw_:SetDirty()
			end

			if arg_59_1.time_ >= var_62_3 + var_62_12 and arg_59_1.time_ < var_62_3 + var_62_12 + arg_62_0 then
				arg_59_1.fswtw_.percent = var_62_8

				arg_59_1.fswtw_:SetDirty()
				arg_59_1:ShowNextGo(true)

				arg_59_1.typewritterCharCountI18N = var_62_9
			end

			local var_62_14 = arg_59_1.bgs_.OS0107
			local var_62_15 = 0

			if var_62_15 < arg_59_1.time_ and arg_59_1.time_ <= var_62_15 + arg_62_0 then
				local var_62_16 = var_62_14:GetComponent("SpriteRenderer")

				if var_62_16 then
					arg_59_1.var_.alphaOldValueOS0107 = var_62_16.color.a
					arg_59_1.var_.alphaMatValueOS0107 = var_62_16
				end

				arg_59_1.var_.alphaOldValueOS0107 = 1
			end

			local var_62_17 = 0.75

			if var_62_15 <= arg_59_1.time_ and arg_59_1.time_ < var_62_15 + var_62_17 then
				local var_62_18 = (arg_59_1.time_ - var_62_15) / var_62_17
				local var_62_19 = Mathf.Lerp(arg_59_1.var_.alphaOldValueOS0107, 0, var_62_18)

				if arg_59_1.var_.alphaMatValueOS0107 then
					local var_62_20 = arg_59_1.var_.alphaMatValueOS0107.color

					var_62_20.a = var_62_19
					arg_59_1.var_.alphaMatValueOS0107.color = var_62_20
				end
			end

			if arg_59_1.time_ >= var_62_15 + var_62_17 and arg_59_1.time_ < var_62_15 + var_62_17 + arg_62_0 and arg_59_1.var_.alphaMatValueOS0107 then
				local var_62_21 = arg_59_1.var_.alphaMatValueOS0107
				local var_62_22 = var_62_21.color

				var_62_22.a = 0
				var_62_21.color = var_62_22
			end

			local var_62_23 = arg_59_1.bgs_.OS0107
			local var_62_24 = 1

			if var_62_24 < arg_59_1.time_ and arg_59_1.time_ <= var_62_24 + arg_62_0 then
				local var_62_25 = var_62_23:GetComponent("SpriteRenderer")

				if var_62_25 then
					arg_59_1.var_.alphaOldValueOS0107 = var_62_25.color.a
					arg_59_1.var_.alphaMatValueOS0107 = var_62_25
				end

				arg_59_1.var_.alphaOldValueOS0107 = 0
			end

			local var_62_26 = 0.75

			if var_62_24 <= arg_59_1.time_ and arg_59_1.time_ < var_62_24 + var_62_26 then
				local var_62_27 = (arg_59_1.time_ - var_62_24) / var_62_26
				local var_62_28 = Mathf.Lerp(arg_59_1.var_.alphaOldValueOS0107, 1, var_62_27)

				if arg_59_1.var_.alphaMatValueOS0107 then
					local var_62_29 = arg_59_1.var_.alphaMatValueOS0107.color

					var_62_29.a = var_62_28
					arg_59_1.var_.alphaMatValueOS0107.color = var_62_29
				end
			end

			if arg_59_1.time_ >= var_62_24 + var_62_26 and arg_59_1.time_ < var_62_24 + var_62_26 + arg_62_0 and arg_59_1.var_.alphaMatValueOS0107 then
				local var_62_30 = arg_59_1.var_.alphaMatValueOS0107
				local var_62_31 = var_62_30.color

				var_62_31.a = 1
				var_62_30.color = var_62_31
			end

			local var_62_32 = 0
			local var_62_33 = 5.952
			local var_62_34 = manager.audio:GetVoiceLength("story_v_out_110101", "110101015", "story_v_out_110101.awb") / 1000

			if var_62_34 > 0 and var_62_33 < var_62_34 and var_62_34 + var_62_32 > arg_59_1.duration_ then
				local var_62_35 = var_62_34

				arg_59_1.duration_ = var_62_34 + var_62_32
			end

			if var_62_32 < arg_59_1.time_ and arg_59_1.time_ <= var_62_32 + arg_62_0 then
				local var_62_36 = "play"
				local var_62_37 = "voice"

				arg_59_1:AudioAction(var_62_36, var_62_37, "story_v_out_110101", "110101015", "story_v_out_110101.awb")
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play110101016 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 110101016
		arg_63_1.duration_ = 9.56

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play110101017(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0

			if var_66_0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_0 + arg_66_0 then
				arg_63_1.var_.oldValueTypewriter = arg_63_1.fswtw_.percent

				SetActive(arg_63_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_63_1:ShowNextGo(false)
			end

			local var_66_1 = 38
			local var_66_2 = 2.53333333333333
			local var_66_3 = arg_63_1:GetWordFromCfg(110101015)
			local var_66_4 = arg_63_1:FormatText(var_66_3.content)
			local var_66_5, var_66_6 = arg_63_1:GetPercentByPara(var_66_4, 2)

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

			local var_66_8 = 2.53333333333333
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
			local var_66_12 = 9.562
			local var_66_13 = manager.audio:GetVoiceLength("story_v_out_110101", "110101016", "story_v_out_110101.awb") / 1000

			if var_66_13 > 0 and var_66_12 < var_66_13 and var_66_13 + var_66_11 > arg_63_1.duration_ then
				local var_66_14 = var_66_13

				arg_63_1.duration_ = var_66_13 + var_66_11
			end

			if var_66_11 < arg_63_1.time_ and arg_63_1.time_ <= var_66_11 + arg_66_0 then
				local var_66_15 = "play"
				local var_66_16 = "voice"

				arg_63_1:AudioAction(var_66_15, var_66_16, "story_v_out_110101", "110101016", "story_v_out_110101.awb")
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play110101017 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 110101017
		arg_67_1.duration_ = 2.5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play110101018(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0

			if var_70_0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_0 + arg_70_0 then
				arg_67_1.var_.oldValueTypewriter = arg_67_1.fswtw_.percent

				SetActive(arg_67_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_67_1:ShowNextGo(false)
			end

			local var_70_1 = 11
			local var_70_2 = 0.733333333333333
			local var_70_3 = arg_67_1:GetWordFromCfg(110101015)
			local var_70_4 = arg_67_1:FormatText(var_70_3.content)
			local var_70_5, var_70_6 = arg_67_1:GetPercentByPara(var_70_4, 3)

			if var_70_0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0

				local var_70_7 = var_70_1 <= 0 and var_70_2 or var_70_2 * ((var_70_6 - arg_67_1.typewritterCharCountI18N) / var_70_1)

				if var_70_7 > 0 and var_70_2 < var_70_7 then
					arg_67_1.talkMaxDuration = var_70_7

					if var_70_7 + var_70_0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_7 + var_70_0
					end
				end
			end

			local var_70_8 = 0.733333333333333
			local var_70_9 = math.max(var_70_8, arg_67_1.talkMaxDuration)

			if var_70_0 <= arg_67_1.time_ and arg_67_1.time_ < var_70_0 + var_70_9 then
				local var_70_10 = (arg_67_1.time_ - var_70_0) / var_70_9

				arg_67_1.fswtw_.percent = Mathf.Lerp(arg_67_1.var_.oldValueTypewriter, var_70_5, var_70_10)
				arg_67_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_67_1.fswtw_:SetDirty()
			end

			if arg_67_1.time_ >= var_70_0 + var_70_9 and arg_67_1.time_ < var_70_0 + var_70_9 + arg_70_0 then
				arg_67_1.fswtw_.percent = var_70_5

				arg_67_1.fswtw_:SetDirty()
				arg_67_1:ShowNextGo(true)

				arg_67_1.typewritterCharCountI18N = var_70_6
			end

			local var_70_11 = arg_67_1.bgs_.OS0107
			local var_70_12 = 0

			if var_70_12 < arg_67_1.time_ and arg_67_1.time_ <= var_70_12 + arg_70_0 then
				local var_70_13 = var_70_11:GetComponent("SpriteRenderer")

				if var_70_13 then
					arg_67_1.var_.alphaOldValueOS0107 = var_70_13.color.a
					arg_67_1.var_.alphaMatValueOS0107 = var_70_13
				end

				arg_67_1.var_.alphaOldValueOS0107 = 1
			end

			local var_70_14 = 1

			if var_70_12 <= arg_67_1.time_ and arg_67_1.time_ < var_70_12 + var_70_14 then
				local var_70_15 = (arg_67_1.time_ - var_70_12) / var_70_14
				local var_70_16 = Mathf.Lerp(arg_67_1.var_.alphaOldValueOS0107, 0, var_70_15)

				if arg_67_1.var_.alphaMatValueOS0107 then
					local var_70_17 = arg_67_1.var_.alphaMatValueOS0107.color

					var_70_17.a = var_70_16
					arg_67_1.var_.alphaMatValueOS0107.color = var_70_17
				end
			end

			if arg_67_1.time_ >= var_70_12 + var_70_14 and arg_67_1.time_ < var_70_12 + var_70_14 + arg_70_0 and arg_67_1.var_.alphaMatValueOS0107 then
				local var_70_18 = arg_67_1.var_.alphaMatValueOS0107
				local var_70_19 = var_70_18.color

				var_70_19.a = 0
				var_70_18.color = var_70_19
			end

			local var_70_20 = arg_67_1.bgs_.OS0107
			local var_70_21 = 1.5

			if var_70_21 < arg_67_1.time_ and arg_67_1.time_ <= var_70_21 + arg_70_0 then
				local var_70_22 = var_70_20:GetComponent("SpriteRenderer")

				if var_70_22 then
					arg_67_1.var_.alphaOldValueOS0107 = var_70_22.color.a
					arg_67_1.var_.alphaMatValueOS0107 = var_70_22
				end

				arg_67_1.var_.alphaOldValueOS0107 = 0
			end

			local var_70_23 = 1

			if var_70_21 <= arg_67_1.time_ and arg_67_1.time_ < var_70_21 + var_70_23 then
				local var_70_24 = (arg_67_1.time_ - var_70_21) / var_70_23
				local var_70_25 = Mathf.Lerp(arg_67_1.var_.alphaOldValueOS0107, 1, var_70_24)

				if arg_67_1.var_.alphaMatValueOS0107 then
					local var_70_26 = arg_67_1.var_.alphaMatValueOS0107.color

					var_70_26.a = var_70_25
					arg_67_1.var_.alphaMatValueOS0107.color = var_70_26
				end
			end

			if arg_67_1.time_ >= var_70_21 + var_70_23 and arg_67_1.time_ < var_70_21 + var_70_23 + arg_70_0 and arg_67_1.var_.alphaMatValueOS0107 then
				local var_70_27 = arg_67_1.var_.alphaMatValueOS0107
				local var_70_28 = var_70_27.color

				var_70_28.a = 1
				var_70_27.color = var_70_28
			end

			local var_70_29 = 0
			local var_70_30 = 1.491
			local var_70_31 = manager.audio:GetVoiceLength("story_v_out_110101", "110101017", "story_v_out_110101.awb") / 1000

			if var_70_31 > 0 and var_70_30 < var_70_31 and var_70_31 + var_70_29 > arg_67_1.duration_ then
				local var_70_32 = var_70_31

				arg_67_1.duration_ = var_70_31 + var_70_29
			end

			if var_70_29 < arg_67_1.time_ and arg_67_1.time_ <= var_70_29 + arg_70_0 then
				local var_70_33 = "play"
				local var_70_34 = "voice"

				arg_67_1:AudioAction(var_70_33, var_70_34, "story_v_out_110101", "110101017", "story_v_out_110101.awb")
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play110101018 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 110101018
		arg_71_1.duration_ = 3.01

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play110101019(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 0

			if var_74_0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_0 + arg_74_0 then
				arg_71_1.var_.oldValueTypewriter = arg_71_1.fswtw_.percent

				SetActive(arg_71_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_71_1:ShowNextGo(false)
			end

			local var_74_1 = 15
			local var_74_2 = 1
			local var_74_3 = arg_71_1:GetWordFromCfg(110101015)
			local var_74_4 = arg_71_1:FormatText(var_74_3.content)
			local var_74_5, var_74_6 = arg_71_1:GetPercentByPara(var_74_4, 4)

			if var_74_0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0

				local var_74_7 = var_74_1 <= 0 and var_74_2 or var_74_2 * ((var_74_6 - arg_71_1.typewritterCharCountI18N) / var_74_1)

				if var_74_7 > 0 and var_74_2 < var_74_7 then
					arg_71_1.talkMaxDuration = var_74_7

					if var_74_7 + var_74_0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_7 + var_74_0
					end
				end
			end

			local var_74_8 = 1
			local var_74_9 = math.max(var_74_8, arg_71_1.talkMaxDuration)

			if var_74_0 <= arg_71_1.time_ and arg_71_1.time_ < var_74_0 + var_74_9 then
				local var_74_10 = (arg_71_1.time_ - var_74_0) / var_74_9

				arg_71_1.fswtw_.percent = Mathf.Lerp(arg_71_1.var_.oldValueTypewriter, var_74_5, var_74_10)
				arg_71_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_71_1.fswtw_:SetDirty()
			end

			if arg_71_1.time_ >= var_74_0 + var_74_9 and arg_71_1.time_ < var_74_0 + var_74_9 + arg_74_0 then
				arg_71_1.fswtw_.percent = var_74_5

				arg_71_1.fswtw_:SetDirty()
				arg_71_1:ShowNextGo(true)

				arg_71_1.typewritterCharCountI18N = var_74_6
			end

			local var_74_11 = 0
			local var_74_12 = 3.008
			local var_74_13 = manager.audio:GetVoiceLength("story_v_out_110101", "110101018", "story_v_out_110101.awb") / 1000

			if var_74_13 > 0 and var_74_12 < var_74_13 and var_74_13 + var_74_11 > arg_71_1.duration_ then
				local var_74_14 = var_74_13

				arg_71_1.duration_ = var_74_13 + var_74_11
			end

			if var_74_11 < arg_71_1.time_ and arg_71_1.time_ <= var_74_11 + arg_74_0 then
				local var_74_15 = "play"
				local var_74_16 = "voice"

				arg_71_1:AudioAction(var_74_15, var_74_16, "story_v_out_110101", "110101018", "story_v_out_110101.awb")
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play110101019 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 110101019
		arg_75_1.duration_ = 5.98

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play110101020(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0

			if var_78_0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_0 + arg_78_0 then
				arg_75_1.var_.oldValueTypewriter = arg_75_1.fswtw_.percent

				SetActive(arg_75_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_75_1:ShowNextGo(false)
			end

			local var_78_1 = 22
			local var_78_2 = 1.46666666666667
			local var_78_3 = arg_75_1:GetWordFromCfg(110101015)
			local var_78_4 = arg_75_1:FormatText(var_78_3.content)
			local var_78_5, var_78_6 = arg_75_1:GetPercentByPara(var_78_4, 5)

			if var_78_0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0

				local var_78_7 = var_78_1 <= 0 and var_78_2 or var_78_2 * ((var_78_6 - arg_75_1.typewritterCharCountI18N) / var_78_1)

				if var_78_7 > 0 and var_78_2 < var_78_7 then
					arg_75_1.talkMaxDuration = var_78_7

					if var_78_7 + var_78_0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_7 + var_78_0
					end
				end
			end

			local var_78_8 = 1.46666666666667
			local var_78_9 = math.max(var_78_8, arg_75_1.talkMaxDuration)

			if var_78_0 <= arg_75_1.time_ and arg_75_1.time_ < var_78_0 + var_78_9 then
				local var_78_10 = (arg_75_1.time_ - var_78_0) / var_78_9

				arg_75_1.fswtw_.percent = Mathf.Lerp(arg_75_1.var_.oldValueTypewriter, var_78_5, var_78_10)
				arg_75_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_75_1.fswtw_:SetDirty()
			end

			if arg_75_1.time_ >= var_78_0 + var_78_9 and arg_75_1.time_ < var_78_0 + var_78_9 + arg_78_0 then
				arg_75_1.fswtw_.percent = var_78_5

				arg_75_1.fswtw_:SetDirty()
				arg_75_1:ShowNextGo(true)

				arg_75_1.typewritterCharCountI18N = var_78_6
			end

			local var_78_11 = arg_75_1.bgs_.OS0107
			local var_78_12 = 0

			if var_78_12 < arg_75_1.time_ and arg_75_1.time_ <= var_78_12 + arg_78_0 then
				local var_78_13 = var_78_11:GetComponent("SpriteRenderer")

				if var_78_13 then
					arg_75_1.var_.alphaOldValueOS0107 = var_78_13.color.a
					arg_75_1.var_.alphaMatValueOS0107 = var_78_13
				end

				arg_75_1.var_.alphaOldValueOS0107 = 1
			end

			local var_78_14 = 2.5

			if var_78_12 <= arg_75_1.time_ and arg_75_1.time_ < var_78_12 + var_78_14 then
				local var_78_15 = (arg_75_1.time_ - var_78_12) / var_78_14
				local var_78_16 = Mathf.Lerp(arg_75_1.var_.alphaOldValueOS0107, 0, var_78_15)

				if arg_75_1.var_.alphaMatValueOS0107 then
					local var_78_17 = arg_75_1.var_.alphaMatValueOS0107.color

					var_78_17.a = var_78_16
					arg_75_1.var_.alphaMatValueOS0107.color = var_78_17
				end
			end

			if arg_75_1.time_ >= var_78_12 + var_78_14 and arg_75_1.time_ < var_78_12 + var_78_14 + arg_78_0 and arg_75_1.var_.alphaMatValueOS0107 then
				local var_78_18 = arg_75_1.var_.alphaMatValueOS0107
				local var_78_19 = var_78_18.color

				var_78_19.a = 0
				var_78_18.color = var_78_19
			end

			local var_78_20 = 0
			local var_78_21 = 5.984
			local var_78_22 = manager.audio:GetVoiceLength("story_v_out_110101", "110101019", "story_v_out_110101.awb") / 1000

			if var_78_22 > 0 and var_78_21 < var_78_22 and var_78_22 + var_78_20 > arg_75_1.duration_ then
				local var_78_23 = var_78_22

				arg_75_1.duration_ = var_78_22 + var_78_20
			end

			if var_78_20 < arg_75_1.time_ and arg_75_1.time_ <= var_78_20 + arg_78_0 then
				local var_78_24 = "play"
				local var_78_25 = "voice"

				arg_75_1:AudioAction(var_78_24, var_78_25, "story_v_out_110101", "110101019", "story_v_out_110101.awb")
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play110101020 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 110101020
		arg_79_1.duration_ = 5.66

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
			arg_79_1.auto_ = false
		end

		function arg_79_1.playNext_(arg_81_0)
			arg_79_1.onStoryFinished_()
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0

			if var_82_0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_0 + arg_82_0 then
				arg_79_1.var_.oldValueTypewriter = arg_79_1.fswtw_.percent

				SetActive(arg_79_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_79_1:ShowNextGo(false)
			end

			local var_82_1 = 27
			local var_82_2 = 1.8
			local var_82_3 = arg_79_1:GetWordFromCfg(110101015)
			local var_82_4 = arg_79_1:FormatText(var_82_3.content)
			local var_82_5, var_82_6 = arg_79_1:GetPercentByPara(var_82_4, 6)

			if var_82_0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0

				local var_82_7 = var_82_1 <= 0 and var_82_2 or var_82_2 * ((var_82_6 - arg_79_1.typewritterCharCountI18N) / var_82_1)

				if var_82_7 > 0 and var_82_2 < var_82_7 then
					arg_79_1.talkMaxDuration = var_82_7

					if var_82_7 + var_82_0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_7 + var_82_0
					end
				end
			end

			local var_82_8 = 1.8
			local var_82_9 = math.max(var_82_8, arg_79_1.talkMaxDuration)

			if var_82_0 <= arg_79_1.time_ and arg_79_1.time_ < var_82_0 + var_82_9 then
				local var_82_10 = (arg_79_1.time_ - var_82_0) / var_82_9

				arg_79_1.fswtw_.percent = Mathf.Lerp(arg_79_1.var_.oldValueTypewriter, var_82_5, var_82_10)
				arg_79_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_79_1.fswtw_:SetDirty()
			end

			if arg_79_1.time_ >= var_82_0 + var_82_9 and arg_79_1.time_ < var_82_0 + var_82_9 + arg_82_0 then
				arg_79_1.fswtw_.percent = var_82_5

				arg_79_1.fswtw_:SetDirty()
				arg_79_1:ShowNextGo(true)

				arg_79_1.typewritterCharCountI18N = var_82_6
			end

			local var_82_11 = 0
			local var_82_12 = 5.663
			local var_82_13 = manager.audio:GetVoiceLength("story_v_out_110101", "110101020", "story_v_out_110101.awb") / 1000

			if var_82_13 > 0 and var_82_12 < var_82_13 and var_82_13 + var_82_11 > arg_79_1.duration_ then
				local var_82_14 = var_82_13

				arg_79_1.duration_ = var_82_13 + var_82_11
			end

			if var_82_11 < arg_79_1.time_ and arg_79_1.time_ <= var_82_11 + arg_82_0 then
				local var_82_15 = "play"
				local var_82_16 = "voice"

				arg_79_1:AudioAction(var_82_15, var_82_16, "story_v_out_110101", "110101020", "story_v_out_110101.awb")
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/OS0107"
	},
	voices = {
		"story_v_out_110101.awb"
	}
}
