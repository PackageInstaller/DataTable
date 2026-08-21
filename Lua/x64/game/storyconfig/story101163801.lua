return {
	Play116381001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 116381001
		arg_1_1.duration_ = 10.45

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play116381002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "STblack"

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
				local var_4_5 = arg_1_1.bgs_.STblack

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
					if iter_4_0 ~= "STblack" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 2

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.fswbg_:SetActive(true)
				arg_1_1.dialog_:SetActive(false)

				arg_1_1.fswtw_.percent = 0

				local var_4_17 = arg_1_1:GetWordFromCfg(116381001)
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

			local var_4_19 = 2.01666666666667

			if var_4_19 < arg_1_1.time_ and arg_1_1.time_ <= var_4_19 + arg_4_0 then
				arg_1_1.var_.oldValueTypewriter = arg_1_1.fswtw_.percent

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_20 = 37
			local var_4_21 = 2.46666666666667
			local var_4_22 = arg_1_1:GetWordFromCfg(116381001)
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

			local var_4_27 = 2.46666666666667
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

			local var_4_30 = 2
			local var_4_31 = 8.451
			local var_4_32 = manager.audio:GetVoiceLength("story_v_out_116381", "116381001", "story_v_out_116381.awb") / 1000

			if var_4_32 > 0 and var_4_31 < var_4_32 and var_4_32 + var_4_30 > arg_1_1.duration_ then
				local var_4_33 = var_4_32

				arg_1_1.duration_ = var_4_32 + var_4_30
			end

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_34 = "play"
				local var_4_35 = "voice"

				arg_1_1:AudioAction(var_4_34, var_4_35, "story_v_out_116381", "116381001", "story_v_out_116381.awb")
			end

			local var_4_36 = 0
			local var_4_37 = 0.266666666666667

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				local var_4_38 = "play"
				local var_4_39 = "music"

				arg_1_1:AudioAction(var_4_38, var_4_39, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_40 = ""
				local var_4_41 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_41 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_41 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_41

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_41
						arg_1_1.bgmTxt2_.text = var_4_41
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

			local var_4_42 = 2.2
			local var_4_43 = 0.6

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				local var_4_44 = "play"
				local var_4_45 = "music"

				arg_1_1:AudioAction(var_4_44, var_4_45, "bgm_activity_1_6_story_story", "bgm_activity_1_6_story_story", "bgm_activity_1_6_story_story.awb")

				local var_4_46 = ""

				if var_4_46 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_46 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_46

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_46
						arg_1_1.bgmTxt2_.text = var_4_46
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

			local var_4_47 = 2.375
			local var_4_48 = 0.425

			if var_4_47 < arg_1_1.time_ and arg_1_1.time_ <= var_4_47 + arg_4_0 then
				local var_4_49 = "play"
				local var_4_50 = "music"

				arg_1_1:AudioAction(var_4_49, var_4_50, "bgm_activity_1_6_story_story", "story", "bgm_activity_1_6_story_story.awb")

				local var_4_51 = ""
				local var_4_52 = MusicRecordCfg[97].musicName

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

			local var_4_53 = 0

			if var_4_53 < arg_1_1.time_ and arg_1_1.time_ <= var_4_53 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_54 = 2

			if var_4_53 <= arg_1_1.time_ and arg_1_1.time_ < var_4_53 + var_4_54 then
				local var_4_55 = (arg_1_1.time_ - var_4_53) / var_4_54
				local var_4_56 = Color.New(0, 0, 0)

				var_4_56.a = Mathf.Lerp(1, 0, var_4_55)
				arg_1_1.mask_.color = var_4_56
			end

			if arg_1_1.time_ >= var_4_53 + var_4_54 and arg_1_1.time_ < var_4_53 + var_4_54 + arg_4_0 then
				local var_4_57 = Color.New(0, 0, 0)
				local var_4_58 = 0

				arg_1_1.mask_.enabled = false
				var_4_57.a = var_4_58
				arg_1_1.mask_.color = var_4_57
			end

			local var_4_59 = 2

			if var_4_59 < arg_1_1.time_ and arg_1_1.time_ <= var_4_59 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_60 = 2.48333333333333

			if arg_1_1.time_ >= var_4_59 + var_4_60 and arg_1_1.time_ < var_4_59 + var_4_60 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play116381002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 116381002
		arg_8_1.duration_ = 10.27

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play116381003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				arg_8_1.var_.oldValueTypewriter = arg_8_1.fswtw_.percent

				SetActive(arg_8_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_8_1:ShowNextGo(false)
			end

			local var_11_1 = 44
			local var_11_2 = 2.93333333333333
			local var_11_3 = arg_8_1:GetWordFromCfg(116381001)
			local var_11_4 = arg_8_1:FormatText(var_11_3.content)
			local var_11_5, var_11_6 = arg_8_1:GetPercentByPara(var_11_4, 2)

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0

				local var_11_7 = var_11_1 <= 0 and var_11_2 or var_11_2 * ((var_11_6 - arg_8_1.typewritterCharCountI18N) / var_11_1)

				if var_11_7 > 0 and var_11_2 < var_11_7 then
					arg_8_1.talkMaxDuration = var_11_7

					if var_11_7 + var_11_0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_7 + var_11_0
					end
				end
			end

			local var_11_8 = 2.93333333333333
			local var_11_9 = math.max(var_11_8, arg_8_1.talkMaxDuration)

			if var_11_0 <= arg_8_1.time_ and arg_8_1.time_ < var_11_0 + var_11_9 then
				local var_11_10 = (arg_8_1.time_ - var_11_0) / var_11_9

				arg_8_1.fswtw_.percent = Mathf.Lerp(arg_8_1.var_.oldValueTypewriter, var_11_5, var_11_10)
				arg_8_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_8_1.fswtw_:SetDirty()
			end

			if arg_8_1.time_ >= var_11_0 + var_11_9 and arg_8_1.time_ < var_11_0 + var_11_9 + arg_11_0 then
				arg_8_1.fswtw_.percent = var_11_5

				arg_8_1.fswtw_:SetDirty()
				arg_8_1:ShowNextGo(true)

				arg_8_1.typewritterCharCountI18N = var_11_6
			end

			local var_11_11 = 0
			local var_11_12 = 10.275
			local var_11_13 = manager.audio:GetVoiceLength("story_v_out_116381", "116381002", "story_v_out_116381.awb") / 1000

			if var_11_13 > 0 and var_11_12 < var_11_13 and var_11_13 + var_11_11 > arg_8_1.duration_ then
				local var_11_14 = var_11_13

				arg_8_1.duration_ = var_11_13 + var_11_11
			end

			if var_11_11 < arg_8_1.time_ and arg_8_1.time_ <= var_11_11 + arg_11_0 then
				local var_11_15 = "play"
				local var_11_16 = "voice"

				arg_8_1:AudioAction(var_11_15, var_11_16, "story_v_out_116381", "116381002", "story_v_out_116381.awb")
			end

			local var_11_17 = 0

			if var_11_17 < arg_8_1.time_ and arg_8_1.time_ <= var_11_17 + arg_11_0 then
				arg_8_1.allBtn_.enabled = false
			end

			local var_11_18 = 2.93333333333333

			if arg_8_1.time_ >= var_11_17 + var_11_18 and arg_8_1.time_ < var_11_17 + var_11_18 + arg_11_0 then
				arg_8_1.allBtn_.enabled = true
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play116381003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 116381003
		arg_12_1.duration_ = 13.78

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play116381004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0

			if var_15_0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_0 + arg_15_0 then
				arg_12_1.var_.oldValueTypewriter = arg_12_1.fswtw_.percent

				SetActive(arg_12_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_12_1:ShowNextGo(false)
			end

			local var_15_1 = 61
			local var_15_2 = 4.13333333333333
			local var_15_3 = arg_12_1:GetWordFromCfg(116381001)
			local var_15_4 = arg_12_1:FormatText(var_15_3.content)
			local var_15_5, var_15_6 = arg_12_1:GetPercentByPara(var_15_4, 3)

			if var_15_0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0

				local var_15_7 = var_15_1 <= 0 and var_15_2 or var_15_2 * ((var_15_6 - arg_12_1.typewritterCharCountI18N) / var_15_1)

				if var_15_7 > 0 and var_15_2 < var_15_7 then
					arg_12_1.talkMaxDuration = var_15_7

					if var_15_7 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_7 + var_15_0
					end
				end
			end

			local var_15_8 = 4.13333333333333
			local var_15_9 = math.max(var_15_8, arg_12_1.talkMaxDuration)

			if var_15_0 <= arg_12_1.time_ and arg_12_1.time_ < var_15_0 + var_15_9 then
				local var_15_10 = (arg_12_1.time_ - var_15_0) / var_15_9

				arg_12_1.fswtw_.percent = Mathf.Lerp(arg_12_1.var_.oldValueTypewriter, var_15_5, var_15_10)
				arg_12_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_12_1.fswtw_:SetDirty()
			end

			if arg_12_1.time_ >= var_15_0 + var_15_9 and arg_12_1.time_ < var_15_0 + var_15_9 + arg_15_0 then
				arg_12_1.fswtw_.percent = var_15_5

				arg_12_1.fswtw_:SetDirty()
				arg_12_1:ShowNextGo(true)

				arg_12_1.typewritterCharCountI18N = var_15_6
			end

			local var_15_11 = 0
			local var_15_12 = 13.78
			local var_15_13 = manager.audio:GetVoiceLength("story_v_out_116381", "116381003", "story_v_out_116381.awb") / 1000

			if var_15_13 > 0 and var_15_12 < var_15_13 and var_15_13 + var_15_11 > arg_12_1.duration_ then
				local var_15_14 = var_15_13

				arg_12_1.duration_ = var_15_13 + var_15_11
			end

			if var_15_11 < arg_12_1.time_ and arg_12_1.time_ <= var_15_11 + arg_15_0 then
				local var_15_15 = "play"
				local var_15_16 = "voice"

				arg_12_1:AudioAction(var_15_15, var_15_16, "story_v_out_116381", "116381003", "story_v_out_116381.awb")
			end

			local var_15_17 = 0

			if var_15_17 < arg_12_1.time_ and arg_12_1.time_ <= var_15_17 + arg_15_0 then
				arg_12_1.allBtn_.enabled = false
			end

			local var_15_18 = 4.13333333333333

			if arg_12_1.time_ >= var_15_17 + var_15_18 and arg_12_1.time_ < var_15_17 + var_15_18 + arg_15_0 then
				arg_12_1.allBtn_.enabled = true
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play116381004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 116381004
		arg_16_1.duration_ = 1.35

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play116381005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0

			if var_19_0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				arg_16_1.var_.oldValueTypewriter = arg_16_1.fswtw_.percent

				SetActive(arg_16_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_16_1:ShowNextGo(false)
			end

			local var_19_1 = 11
			local var_19_2 = 0.733333333333333
			local var_19_3 = arg_16_1:GetWordFromCfg(116381001)
			local var_19_4 = arg_16_1:FormatText(var_19_3.content)
			local var_19_5, var_19_6 = arg_16_1:GetPercentByPara(var_19_4, 4)

			if var_19_0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0

				local var_19_7 = var_19_1 <= 0 and var_19_2 or var_19_2 * ((var_19_6 - arg_16_1.typewritterCharCountI18N) / var_19_1)

				if var_19_7 > 0 and var_19_2 < var_19_7 then
					arg_16_1.talkMaxDuration = var_19_7

					if var_19_7 + var_19_0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_7 + var_19_0
					end
				end
			end

			local var_19_8 = 0.733333333333333
			local var_19_9 = math.max(var_19_8, arg_16_1.talkMaxDuration)

			if var_19_0 <= arg_16_1.time_ and arg_16_1.time_ < var_19_0 + var_19_9 then
				local var_19_10 = (arg_16_1.time_ - var_19_0) / var_19_9

				arg_16_1.fswtw_.percent = Mathf.Lerp(arg_16_1.var_.oldValueTypewriter, var_19_5, var_19_10)
				arg_16_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_16_1.fswtw_:SetDirty()
			end

			if arg_16_1.time_ >= var_19_0 + var_19_9 and arg_16_1.time_ < var_19_0 + var_19_9 + arg_19_0 then
				arg_16_1.fswtw_.percent = var_19_5

				arg_16_1.fswtw_:SetDirty()
				arg_16_1:ShowNextGo(true)

				arg_16_1.typewritterCharCountI18N = var_19_6
			end

			local var_19_11 = 0
			local var_19_12 = 1.349
			local var_19_13 = manager.audio:GetVoiceLength("story_v_out_116381", "116381004", "story_v_out_116381.awb") / 1000

			if var_19_13 > 0 and var_19_12 < var_19_13 and var_19_13 + var_19_11 > arg_16_1.duration_ then
				local var_19_14 = var_19_13

				arg_16_1.duration_ = var_19_13 + var_19_11
			end

			if var_19_11 < arg_16_1.time_ and arg_16_1.time_ <= var_19_11 + arg_19_0 then
				local var_19_15 = "play"
				local var_19_16 = "voice"

				arg_16_1:AudioAction(var_19_15, var_19_16, "story_v_out_116381", "116381004", "story_v_out_116381.awb")
			end

			local var_19_17 = 0

			if var_19_17 < arg_16_1.time_ and arg_16_1.time_ <= var_19_17 + arg_19_0 then
				arg_16_1.allBtn_.enabled = false
			end

			local var_19_18 = 0.733333333333333

			if arg_16_1.time_ >= var_19_17 + var_19_18 and arg_16_1.time_ < var_19_17 + var_19_18 + arg_19_0 then
				arg_16_1.allBtn_.enabled = true
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play116381005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 116381005
		arg_20_1.duration_ = 4.22

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play116381006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0

			if var_23_0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1.var_.oldValueTypewriter = arg_20_1.fswtw_.percent

				SetActive(arg_20_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_20_1:ShowNextGo(false)
			end

			local var_23_1 = 23
			local var_23_2 = 1.53333333333333
			local var_23_3 = arg_20_1:GetWordFromCfg(116381001)
			local var_23_4 = arg_20_1:FormatText(var_23_3.content)
			local var_23_5, var_23_6 = arg_20_1:GetPercentByPara(var_23_4, 5)

			if var_23_0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0

				local var_23_7 = var_23_1 <= 0 and var_23_2 or var_23_2 * ((var_23_6 - arg_20_1.typewritterCharCountI18N) / var_23_1)

				if var_23_7 > 0 and var_23_2 < var_23_7 then
					arg_20_1.talkMaxDuration = var_23_7

					if var_23_7 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_7 + var_23_0
					end
				end
			end

			local var_23_8 = 1.53333333333333
			local var_23_9 = math.max(var_23_8, arg_20_1.talkMaxDuration)

			if var_23_0 <= arg_20_1.time_ and arg_20_1.time_ < var_23_0 + var_23_9 then
				local var_23_10 = (arg_20_1.time_ - var_23_0) / var_23_9

				arg_20_1.fswtw_.percent = Mathf.Lerp(arg_20_1.var_.oldValueTypewriter, var_23_5, var_23_10)
				arg_20_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_20_1.fswtw_:SetDirty()
			end

			if arg_20_1.time_ >= var_23_0 + var_23_9 and arg_20_1.time_ < var_23_0 + var_23_9 + arg_23_0 then
				arg_20_1.fswtw_.percent = var_23_5

				arg_20_1.fswtw_:SetDirty()
				arg_20_1:ShowNextGo(true)

				arg_20_1.typewritterCharCountI18N = var_23_6
			end

			local var_23_11 = 0
			local var_23_12 = 4.217
			local var_23_13 = manager.audio:GetVoiceLength("story_v_out_116381", "116381005", "story_v_out_116381.awb") / 1000

			if var_23_13 > 0 and var_23_12 < var_23_13 and var_23_13 + var_23_11 > arg_20_1.duration_ then
				local var_23_14 = var_23_13

				arg_20_1.duration_ = var_23_13 + var_23_11
			end

			if var_23_11 < arg_20_1.time_ and arg_20_1.time_ <= var_23_11 + arg_23_0 then
				local var_23_15 = "play"
				local var_23_16 = "voice"

				arg_20_1:AudioAction(var_23_15, var_23_16, "story_v_out_116381", "116381005", "story_v_out_116381.awb")
			end

			local var_23_17 = 0

			if var_23_17 < arg_20_1.time_ and arg_20_1.time_ <= var_23_17 + arg_23_0 then
				arg_20_1.allBtn_.enabled = false
			end

			local var_23_18 = 1.53333333333333

			if arg_20_1.time_ >= var_23_17 + var_23_18 and arg_20_1.time_ < var_23_17 + var_23_18 + arg_23_0 then
				arg_20_1.allBtn_.enabled = true
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play116381006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 116381006
		arg_24_1.duration_ = 7.03

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play116381007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0

			if var_27_0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				arg_24_1.var_.oldValueTypewriter = arg_24_1.fswtw_.percent

				SetActive(arg_24_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_24_1:ShowNextGo(false)
			end

			local var_27_1 = 42
			local var_27_2 = 2.8
			local var_27_3 = arg_24_1:GetWordFromCfg(116381001)
			local var_27_4 = arg_24_1:FormatText(var_27_3.content)
			local var_27_5, var_27_6 = arg_24_1:GetPercentByPara(var_27_4, 6)

			if var_27_0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0

				local var_27_7 = var_27_1 <= 0 and var_27_2 or var_27_2 * ((var_27_6 - arg_24_1.typewritterCharCountI18N) / var_27_1)

				if var_27_7 > 0 and var_27_2 < var_27_7 then
					arg_24_1.talkMaxDuration = var_27_7

					if var_27_7 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_7 + var_27_0
					end
				end
			end

			local var_27_8 = 2.8
			local var_27_9 = math.max(var_27_8, arg_24_1.talkMaxDuration)

			if var_27_0 <= arg_24_1.time_ and arg_24_1.time_ < var_27_0 + var_27_9 then
				local var_27_10 = (arg_24_1.time_ - var_27_0) / var_27_9

				arg_24_1.fswtw_.percent = Mathf.Lerp(arg_24_1.var_.oldValueTypewriter, var_27_5, var_27_10)
				arg_24_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_24_1.fswtw_:SetDirty()
			end

			if arg_24_1.time_ >= var_27_0 + var_27_9 and arg_24_1.time_ < var_27_0 + var_27_9 + arg_27_0 then
				arg_24_1.fswtw_.percent = var_27_5

				arg_24_1.fswtw_:SetDirty()
				arg_24_1:ShowNextGo(true)

				arg_24_1.typewritterCharCountI18N = var_27_6
			end

			local var_27_11 = 0
			local var_27_12 = 7.027
			local var_27_13 = manager.audio:GetVoiceLength("story_v_out_116381", "116381006", "story_v_out_116381.awb") / 1000

			if var_27_13 > 0 and var_27_12 < var_27_13 and var_27_13 + var_27_11 > arg_24_1.duration_ then
				local var_27_14 = var_27_13

				arg_24_1.duration_ = var_27_13 + var_27_11
			end

			if var_27_11 < arg_24_1.time_ and arg_24_1.time_ <= var_27_11 + arg_27_0 then
				local var_27_15 = "play"
				local var_27_16 = "voice"

				arg_24_1:AudioAction(var_27_15, var_27_16, "story_v_out_116381", "116381006", "story_v_out_116381.awb")
			end

			local var_27_17 = 0

			if var_27_17 < arg_24_1.time_ and arg_24_1.time_ <= var_27_17 + arg_27_0 then
				arg_24_1.allBtn_.enabled = false
			end

			local var_27_18 = 2.8

			if arg_24_1.time_ >= var_27_17 + var_27_18 and arg_24_1.time_ < var_27_17 + var_27_18 + arg_27_0 then
				arg_24_1.allBtn_.enabled = true
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play116381007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 116381007
		arg_28_1.duration_ = 10.29

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play116381008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0

			if var_31_0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_0 + arg_31_0 then
				arg_28_1.fswbg_:SetActive(true)
				arg_28_1.dialog_:SetActive(false)

				arg_28_1.fswtw_.percent = 0

				local var_31_1 = arg_28_1:GetWordFromCfg(116381007)
				local var_31_2 = arg_28_1:FormatText(var_31_1.content)

				arg_28_1.fswt_.text = var_31_2

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.fswt_)

				arg_28_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_28_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_28_1.fswtw_:SetDirty()

				arg_28_1.typewritterCharCountI18N = 0

				SetActive(arg_28_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_28_1:ShowNextGo(false)
			end

			local var_31_3 = 0.0166666666666667

			if var_31_3 < arg_28_1.time_ and arg_28_1.time_ <= var_31_3 + arg_31_0 then
				arg_28_1.var_.oldValueTypewriter = arg_28_1.fswtw_.percent

				SetActive(arg_28_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_28_1:ShowNextGo(false)
			end

			local var_31_4 = 48
			local var_31_5 = 3.2
			local var_31_6 = arg_28_1:GetWordFromCfg(116381007)
			local var_31_7 = arg_28_1:FormatText(var_31_6.content)
			local var_31_8, var_31_9 = arg_28_1:GetPercentByPara(var_31_7, 1)

			if var_31_3 < arg_28_1.time_ and arg_28_1.time_ <= var_31_3 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0

				local var_31_10 = var_31_4 <= 0 and var_31_5 or var_31_5 * ((var_31_9 - arg_28_1.typewritterCharCountI18N) / var_31_4)

				if var_31_10 > 0 and var_31_5 < var_31_10 then
					arg_28_1.talkMaxDuration = var_31_10

					if var_31_10 + var_31_3 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_10 + var_31_3
					end
				end
			end

			local var_31_11 = 3.2
			local var_31_12 = math.max(var_31_11, arg_28_1.talkMaxDuration)

			if var_31_3 <= arg_28_1.time_ and arg_28_1.time_ < var_31_3 + var_31_12 then
				local var_31_13 = (arg_28_1.time_ - var_31_3) / var_31_12

				arg_28_1.fswtw_.percent = Mathf.Lerp(arg_28_1.var_.oldValueTypewriter, var_31_8, var_31_13)
				arg_28_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_28_1.fswtw_:SetDirty()
			end

			if arg_28_1.time_ >= var_31_3 + var_31_12 and arg_28_1.time_ < var_31_3 + var_31_12 + arg_31_0 then
				arg_28_1.fswtw_.percent = var_31_8

				arg_28_1.fswtw_:SetDirty()
				arg_28_1:ShowNextGo(true)

				arg_28_1.typewritterCharCountI18N = var_31_9
			end

			local var_31_14 = 0
			local var_31_15 = 10.287
			local var_31_16 = manager.audio:GetVoiceLength("story_v_out_116381", "116381007", "story_v_out_116381.awb") / 1000

			if var_31_16 > 0 and var_31_15 < var_31_16 and var_31_16 + var_31_14 > arg_28_1.duration_ then
				local var_31_17 = var_31_16

				arg_28_1.duration_ = var_31_16 + var_31_14
			end

			if var_31_14 < arg_28_1.time_ and arg_28_1.time_ <= var_31_14 + arg_31_0 then
				local var_31_18 = "play"
				local var_31_19 = "voice"

				arg_28_1:AudioAction(var_31_18, var_31_19, "story_v_out_116381", "116381007", "story_v_out_116381.awb")
			end

			local var_31_20 = 0

			if var_31_20 < arg_28_1.time_ and arg_28_1.time_ <= var_31_20 + arg_31_0 then
				arg_28_1.allBtn_.enabled = false
			end

			local var_31_21 = 3.21666666666667

			if arg_28_1.time_ >= var_31_20 + var_31_21 and arg_28_1.time_ < var_31_20 + var_31_21 + arg_31_0 then
				arg_28_1.allBtn_.enabled = true
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play116381008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 116381008
		arg_32_1.duration_ = 7.65

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play116381009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0

			if var_35_0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_0 + arg_35_0 then
				arg_32_1.var_.oldValueTypewriter = arg_32_1.fswtw_.percent

				SetActive(arg_32_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_32_1:ShowNextGo(false)
			end

			local var_35_1 = 27
			local var_35_2 = 1.8
			local var_35_3 = arg_32_1:GetWordFromCfg(116381007)
			local var_35_4 = arg_32_1:FormatText(var_35_3.content)
			local var_35_5, var_35_6 = arg_32_1:GetPercentByPara(var_35_4, 2)

			if var_35_0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0

				local var_35_7 = var_35_1 <= 0 and var_35_2 or var_35_2 * ((var_35_6 - arg_32_1.typewritterCharCountI18N) / var_35_1)

				if var_35_7 > 0 and var_35_2 < var_35_7 then
					arg_32_1.talkMaxDuration = var_35_7

					if var_35_7 + var_35_0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_7 + var_35_0
					end
				end
			end

			local var_35_8 = 1.8
			local var_35_9 = math.max(var_35_8, arg_32_1.talkMaxDuration)

			if var_35_0 <= arg_32_1.time_ and arg_32_1.time_ < var_35_0 + var_35_9 then
				local var_35_10 = (arg_32_1.time_ - var_35_0) / var_35_9

				arg_32_1.fswtw_.percent = Mathf.Lerp(arg_32_1.var_.oldValueTypewriter, var_35_5, var_35_10)
				arg_32_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_32_1.fswtw_:SetDirty()
			end

			if arg_32_1.time_ >= var_35_0 + var_35_9 and arg_32_1.time_ < var_35_0 + var_35_9 + arg_35_0 then
				arg_32_1.fswtw_.percent = var_35_5

				arg_32_1.fswtw_:SetDirty()
				arg_32_1:ShowNextGo(true)

				arg_32_1.typewritterCharCountI18N = var_35_6
			end

			local var_35_11 = 0
			local var_35_12 = 7.654
			local var_35_13 = manager.audio:GetVoiceLength("story_v_out_116381", "116381008", "story_v_out_116381.awb") / 1000

			if var_35_13 > 0 and var_35_12 < var_35_13 and var_35_13 + var_35_11 > arg_32_1.duration_ then
				local var_35_14 = var_35_13

				arg_32_1.duration_ = var_35_13 + var_35_11
			end

			if var_35_11 < arg_32_1.time_ and arg_32_1.time_ <= var_35_11 + arg_35_0 then
				local var_35_15 = "play"
				local var_35_16 = "voice"

				arg_32_1:AudioAction(var_35_15, var_35_16, "story_v_out_116381", "116381008", "story_v_out_116381.awb")
			end

			local var_35_17 = 0

			if var_35_17 < arg_32_1.time_ and arg_32_1.time_ <= var_35_17 + arg_35_0 then
				arg_32_1.allBtn_.enabled = false
			end

			local var_35_18 = 1.8

			if arg_32_1.time_ >= var_35_17 + var_35_18 and arg_32_1.time_ < var_35_17 + var_35_18 + arg_35_0 then
				arg_32_1.allBtn_.enabled = true
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play116381009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 116381009
		arg_36_1.duration_ = 12.17

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play116381010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0

			if var_39_0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_0 + arg_39_0 then
				arg_36_1.var_.oldValueTypewriter = arg_36_1.fswtw_.percent

				SetActive(arg_36_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_36_1:ShowNextGo(false)
			end

			local var_39_1 = 61
			local var_39_2 = 4.06666666666667
			local var_39_3 = arg_36_1:GetWordFromCfg(116381007)
			local var_39_4 = arg_36_1:FormatText(var_39_3.content)
			local var_39_5, var_39_6 = arg_36_1:GetPercentByPara(var_39_4, 3)

			if var_39_0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0

				local var_39_7 = var_39_1 <= 0 and var_39_2 or var_39_2 * ((var_39_6 - arg_36_1.typewritterCharCountI18N) / var_39_1)

				if var_39_7 > 0 and var_39_2 < var_39_7 then
					arg_36_1.talkMaxDuration = var_39_7

					if var_39_7 + var_39_0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_7 + var_39_0
					end
				end
			end

			local var_39_8 = 4.06666666666667
			local var_39_9 = math.max(var_39_8, arg_36_1.talkMaxDuration)

			if var_39_0 <= arg_36_1.time_ and arg_36_1.time_ < var_39_0 + var_39_9 then
				local var_39_10 = (arg_36_1.time_ - var_39_0) / var_39_9

				arg_36_1.fswtw_.percent = Mathf.Lerp(arg_36_1.var_.oldValueTypewriter, var_39_5, var_39_10)
				arg_36_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_36_1.fswtw_:SetDirty()
			end

			if arg_36_1.time_ >= var_39_0 + var_39_9 and arg_36_1.time_ < var_39_0 + var_39_9 + arg_39_0 then
				arg_36_1.fswtw_.percent = var_39_5

				arg_36_1.fswtw_:SetDirty()
				arg_36_1:ShowNextGo(true)

				arg_36_1.typewritterCharCountI18N = var_39_6
			end

			local var_39_11 = 0
			local var_39_12 = 12.169
			local var_39_13 = manager.audio:GetVoiceLength("story_v_out_116381", "116381009", "story_v_out_116381.awb") / 1000

			if var_39_13 > 0 and var_39_12 < var_39_13 and var_39_13 + var_39_11 > arg_36_1.duration_ then
				local var_39_14 = var_39_13

				arg_36_1.duration_ = var_39_13 + var_39_11
			end

			if var_39_11 < arg_36_1.time_ and arg_36_1.time_ <= var_39_11 + arg_39_0 then
				local var_39_15 = "play"
				local var_39_16 = "voice"

				arg_36_1:AudioAction(var_39_15, var_39_16, "story_v_out_116381", "116381009", "story_v_out_116381.awb")
			end

			local var_39_17 = 0

			if var_39_17 < arg_36_1.time_ and arg_36_1.time_ <= var_39_17 + arg_39_0 then
				arg_36_1.allBtn_.enabled = false
			end

			local var_39_18 = 4.06666666666667

			if arg_36_1.time_ >= var_39_17 + var_39_18 and arg_36_1.time_ < var_39_17 + var_39_18 + arg_39_0 then
				arg_36_1.allBtn_.enabled = true
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play116381010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 116381010
		arg_40_1.duration_ = 9.97

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play116381011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0

			if var_43_0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_0 + arg_43_0 then
				arg_40_1.var_.oldValueTypewriter = arg_40_1.fswtw_.percent

				SetActive(arg_40_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_40_1:ShowNextGo(false)
			end

			local var_43_1 = 31
			local var_43_2 = 2.06666666666667
			local var_43_3 = arg_40_1:GetWordFromCfg(116381007)
			local var_43_4 = arg_40_1:FormatText(var_43_3.content)
			local var_43_5, var_43_6 = arg_40_1:GetPercentByPara(var_43_4, 4)

			if var_43_0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0

				local var_43_7 = var_43_1 <= 0 and var_43_2 or var_43_2 * ((var_43_6 - arg_40_1.typewritterCharCountI18N) / var_43_1)

				if var_43_7 > 0 and var_43_2 < var_43_7 then
					arg_40_1.talkMaxDuration = var_43_7

					if var_43_7 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_7 + var_43_0
					end
				end
			end

			local var_43_8 = 2.06666666666667
			local var_43_9 = math.max(var_43_8, arg_40_1.talkMaxDuration)

			if var_43_0 <= arg_40_1.time_ and arg_40_1.time_ < var_43_0 + var_43_9 then
				local var_43_10 = (arg_40_1.time_ - var_43_0) / var_43_9

				arg_40_1.fswtw_.percent = Mathf.Lerp(arg_40_1.var_.oldValueTypewriter, var_43_5, var_43_10)
				arg_40_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_40_1.fswtw_:SetDirty()
			end

			if arg_40_1.time_ >= var_43_0 + var_43_9 and arg_40_1.time_ < var_43_0 + var_43_9 + arg_43_0 then
				arg_40_1.fswtw_.percent = var_43_5

				arg_40_1.fswtw_:SetDirty()
				arg_40_1:ShowNextGo(true)

				arg_40_1.typewritterCharCountI18N = var_43_6
			end

			local var_43_11 = 0
			local var_43_12 = 9.974
			local var_43_13 = manager.audio:GetVoiceLength("story_v_out_116381", "116381010", "story_v_out_116381.awb") / 1000

			if var_43_13 > 0 and var_43_12 < var_43_13 and var_43_13 + var_43_11 > arg_40_1.duration_ then
				local var_43_14 = var_43_13

				arg_40_1.duration_ = var_43_13 + var_43_11
			end

			if var_43_11 < arg_40_1.time_ and arg_40_1.time_ <= var_43_11 + arg_43_0 then
				local var_43_15 = "play"
				local var_43_16 = "voice"

				arg_40_1:AudioAction(var_43_15, var_43_16, "story_v_out_116381", "116381010", "story_v_out_116381.awb")
			end

			local var_43_17 = 0

			if var_43_17 < arg_40_1.time_ and arg_40_1.time_ <= var_43_17 + arg_43_0 then
				arg_40_1.allBtn_.enabled = false
			end

			local var_43_18 = 2.06666666666667

			if arg_40_1.time_ >= var_43_17 + var_43_18 and arg_40_1.time_ < var_43_17 + var_43_18 + arg_43_0 then
				arg_40_1.allBtn_.enabled = true
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play116381011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 116381011
		arg_44_1.duration_ = 0.96

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play116381012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0

			if var_47_0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_0 + arg_47_0 then
				arg_44_1.var_.oldValueTypewriter = arg_44_1.fswtw_.percent

				SetActive(arg_44_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_44_1:ShowNextGo(false)
			end

			local var_47_1 = 10
			local var_47_2 = 0.666666666666667
			local var_47_3 = arg_44_1:GetWordFromCfg(116381007)
			local var_47_4 = arg_44_1:FormatText(var_47_3.content)
			local var_47_5, var_47_6 = arg_44_1:GetPercentByPara(var_47_4, 5)

			if var_47_0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0

				local var_47_7 = var_47_1 <= 0 and var_47_2 or var_47_2 * ((var_47_6 - arg_44_1.typewritterCharCountI18N) / var_47_1)

				if var_47_7 > 0 and var_47_2 < var_47_7 then
					arg_44_1.talkMaxDuration = var_47_7

					if var_47_7 + var_47_0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_7 + var_47_0
					end
				end
			end

			local var_47_8 = 0.666666666666667
			local var_47_9 = math.max(var_47_8, arg_44_1.talkMaxDuration)

			if var_47_0 <= arg_44_1.time_ and arg_44_1.time_ < var_47_0 + var_47_9 then
				local var_47_10 = (arg_44_1.time_ - var_47_0) / var_47_9

				arg_44_1.fswtw_.percent = Mathf.Lerp(arg_44_1.var_.oldValueTypewriter, var_47_5, var_47_10)
				arg_44_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_44_1.fswtw_:SetDirty()
			end

			if arg_44_1.time_ >= var_47_0 + var_47_9 and arg_44_1.time_ < var_47_0 + var_47_9 + arg_47_0 then
				arg_44_1.fswtw_.percent = var_47_5

				arg_44_1.fswtw_:SetDirty()
				arg_44_1:ShowNextGo(true)

				arg_44_1.typewritterCharCountI18N = var_47_6
			end

			local var_47_11 = 0
			local var_47_12 = 0.965
			local var_47_13 = manager.audio:GetVoiceLength("story_v_out_116381", "116381011", "story_v_out_116381.awb") / 1000

			if var_47_13 > 0 and var_47_12 < var_47_13 and var_47_13 + var_47_11 > arg_44_1.duration_ then
				local var_47_14 = var_47_13

				arg_44_1.duration_ = var_47_13 + var_47_11
			end

			if var_47_11 < arg_44_1.time_ and arg_44_1.time_ <= var_47_11 + arg_47_0 then
				local var_47_15 = "play"
				local var_47_16 = "voice"

				arg_44_1:AudioAction(var_47_15, var_47_16, "story_v_out_116381", "116381011", "story_v_out_116381.awb")
			end

			local var_47_17 = 0

			if var_47_17 < arg_44_1.time_ and arg_44_1.time_ <= var_47_17 + arg_47_0 then
				arg_44_1.allBtn_.enabled = false
			end

			local var_47_18 = 0.666666666666667

			if arg_44_1.time_ >= var_47_17 + var_47_18 and arg_44_1.time_ < var_47_17 + var_47_18 + arg_47_0 then
				arg_44_1.allBtn_.enabled = true
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play116381012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 116381012
		arg_48_1.duration_ = 9.53

		local var_48_0 = {
			zh = 8.2,
			ja = 9.533
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
				arg_48_0:Play116381013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = "SK0107"

			if arg_48_1.bgs_[var_51_0] == nil then
				local var_51_1 = Object.Instantiate(arg_48_1.paintGo_)

				var_51_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_51_0)
				var_51_1.name = var_51_0
				var_51_1.transform.parent = arg_48_1.stage_.transform
				var_51_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_48_1.bgs_[var_51_0] = var_51_1
			end

			local var_51_2 = 2

			if var_51_2 < arg_48_1.time_ and arg_48_1.time_ <= var_51_2 + arg_51_0 then
				local var_51_3 = manager.ui.mainCamera.transform.localPosition
				local var_51_4 = Vector3.New(0, 0, 10) + Vector3.New(var_51_3.x, var_51_3.y, 0)
				local var_51_5 = arg_48_1.bgs_.SK0107

				var_51_5.transform.localPosition = var_51_4
				var_51_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_51_6 = var_51_5:GetComponent("SpriteRenderer")

				if var_51_6 and var_51_6.sprite then
					local var_51_7 = (var_51_5.transform.localPosition - var_51_3).z
					local var_51_8 = manager.ui.mainCameraCom_
					local var_51_9 = 2 * var_51_7 * Mathf.Tan(var_51_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_51_10 = var_51_9 * var_51_8.aspect
					local var_51_11 = var_51_6.sprite.bounds.size.x
					local var_51_12 = var_51_6.sprite.bounds.size.y
					local var_51_13 = var_51_10 / var_51_11
					local var_51_14 = var_51_9 / var_51_12
					local var_51_15 = var_51_14 < var_51_13 and var_51_13 or var_51_14

					var_51_5.transform.localScale = Vector3.New(var_51_15, var_51_15, 0)
				end

				for iter_51_0, iter_51_1 in pairs(arg_48_1.bgs_) do
					if iter_51_0 ~= "SK0107" then
						iter_51_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_51_16 = 0

			if var_51_16 < arg_48_1.time_ and arg_48_1.time_ <= var_51_16 + arg_51_0 then
				arg_48_1.mask_.enabled = true
				arg_48_1.mask_.raycastTarget = true

				arg_48_1:SetGaussion(false)
			end

			local var_51_17 = 2

			if var_51_16 <= arg_48_1.time_ and arg_48_1.time_ < var_51_16 + var_51_17 then
				local var_51_18 = (arg_48_1.time_ - var_51_16) / var_51_17
				local var_51_19 = Color.New(0, 0, 0)

				var_51_19.a = Mathf.Lerp(0, 1, var_51_18)
				arg_48_1.mask_.color = var_51_19
			end

			if arg_48_1.time_ >= var_51_16 + var_51_17 and arg_48_1.time_ < var_51_16 + var_51_17 + arg_51_0 then
				local var_51_20 = Color.New(0, 0, 0)

				var_51_20.a = 1
				arg_48_1.mask_.color = var_51_20
			end

			local var_51_21 = 2

			if var_51_21 < arg_48_1.time_ and arg_48_1.time_ <= var_51_21 + arg_51_0 then
				arg_48_1.mask_.enabled = true
				arg_48_1.mask_.raycastTarget = true

				arg_48_1:SetGaussion(false)
			end

			local var_51_22 = 2

			if var_51_21 <= arg_48_1.time_ and arg_48_1.time_ < var_51_21 + var_51_22 then
				local var_51_23 = (arg_48_1.time_ - var_51_21) / var_51_22
				local var_51_24 = Color.New(0, 0, 0)

				var_51_24.a = Mathf.Lerp(1, 0, var_51_23)
				arg_48_1.mask_.color = var_51_24
			end

			if arg_48_1.time_ >= var_51_21 + var_51_22 and arg_48_1.time_ < var_51_21 + var_51_22 + arg_51_0 then
				local var_51_25 = Color.New(0, 0, 0)
				local var_51_26 = 0

				arg_48_1.mask_.enabled = false
				var_51_25.a = var_51_26
				arg_48_1.mask_.color = var_51_25
			end

			local var_51_27 = 1.98333333333333

			if var_51_27 < arg_48_1.time_ and arg_48_1.time_ <= var_51_27 + arg_51_0 then
				arg_48_1.fswbg_:SetActive(false)
				arg_48_1.dialog_:SetActive(false)
				SetActive(arg_48_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_48_1:ShowNextGo(false)
			end

			if arg_48_1.frameCnt_ <= 1 then
				arg_48_1.dialog_:SetActive(false)
			end

			local var_51_28 = 4
			local var_51_29 = 0.4

			if var_51_28 < arg_48_1.time_ and arg_48_1.time_ <= var_51_28 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0

				arg_48_1.dialog_:SetActive(true)

				arg_48_1.dialogCg_.alpha = 0

				local var_51_30 = LeanTween.value(arg_48_1.dialog_, 0, 1, 0.3)

				var_51_30:setOnUpdate(LuaHelper.FloatAction(function(arg_52_0)
					arg_48_1.dialogCg_.alpha = arg_52_0
				end))
				var_51_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_48_1.dialog_)
					var_51_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_48_1.duration_ = arg_48_1.duration_ + 0.3

				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_31 = arg_48_1:FormatText(StoryNameCfg[328].name)

				arg_48_1.leftNameTxt_.text = var_51_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, true)
				arg_48_1.iconController_:SetSelectedState("hero")

				arg_48_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10032")

				arg_48_1.callingController_:SetSelectedState("normal")

				arg_48_1.keyicon_.color = Color.New(1, 1, 1)
				arg_48_1.icon_.color = Color.New(1, 1, 1)

				local var_51_32 = arg_48_1:GetWordFromCfg(116381012)
				local var_51_33 = arg_48_1:FormatText(var_51_32.content)

				arg_48_1.text_.text = var_51_33

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_34 = 15
				local var_51_35 = utf8.len(var_51_33)
				local var_51_36 = var_51_34 <= 0 and var_51_29 or var_51_29 * (var_51_35 / var_51_34)

				if var_51_36 > 0 and var_51_29 < var_51_36 then
					arg_48_1.talkMaxDuration = var_51_36
					var_51_28 = var_51_28 + 0.3

					if var_51_36 + var_51_28 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_36 + var_51_28
					end
				end

				arg_48_1.text_.text = var_51_33
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381012", "story_v_out_116381.awb") ~= 0 then
					local var_51_37 = manager.audio:GetVoiceLength("story_v_out_116381", "116381012", "story_v_out_116381.awb") / 1000

					if var_51_37 + var_51_28 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_37 + var_51_28
					end

					if var_51_32.prefab_name ~= "" and arg_48_1.actors_[var_51_32.prefab_name] ~= nil then
						local var_51_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_32.prefab_name].transform, "story_v_out_116381", "116381012", "story_v_out_116381.awb")

						arg_48_1:RecordAudio("116381012", var_51_38)
						arg_48_1:RecordAudio("116381012", var_51_38)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_116381", "116381012", "story_v_out_116381.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_116381", "116381012", "story_v_out_116381.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_39 = var_51_28 + 0.3
			local var_51_40 = math.max(var_51_29, arg_48_1.talkMaxDuration)

			if var_51_39 <= arg_48_1.time_ and arg_48_1.time_ < var_51_39 + var_51_40 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_39) / var_51_40

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_39 + var_51_40 and arg_48_1.time_ < var_51_39 + var_51_40 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play116381013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 116381013
		arg_54_1.duration_ = 15.2

		local var_54_0 = {
			zh = 11.366,
			ja = 15.2
		}
		local var_54_1 = manager.audio:GetLocalizationFlag()

		if var_54_0[var_54_1] ~= nil then
			arg_54_1.duration_ = var_54_0[var_54_1]
		end

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play116381014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = "SK0112"

			if arg_54_1.bgs_[var_57_0] == nil then
				local var_57_1 = Object.Instantiate(arg_54_1.paintGo_)

				var_57_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_57_0)
				var_57_1.name = var_57_0
				var_57_1.transform.parent = arg_54_1.stage_.transform
				var_57_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_54_1.bgs_[var_57_0] = var_57_1
			end

			local var_57_2 = 2

			if var_57_2 < arg_54_1.time_ and arg_54_1.time_ <= var_57_2 + arg_57_0 then
				local var_57_3 = manager.ui.mainCamera.transform.localPosition
				local var_57_4 = Vector3.New(0, 0, 10) + Vector3.New(var_57_3.x, var_57_3.y, 0)
				local var_57_5 = arg_54_1.bgs_.SK0112

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
					if iter_57_0 ~= "SK0112" then
						iter_57_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_57_16 = 0

			if var_57_16 < arg_54_1.time_ and arg_54_1.time_ <= var_57_16 + arg_57_0 then
				arg_54_1.mask_.enabled = true
				arg_54_1.mask_.raycastTarget = true

				arg_54_1:SetGaussion(false)
			end

			local var_57_17 = 2

			if var_57_16 <= arg_54_1.time_ and arg_54_1.time_ < var_57_16 + var_57_17 then
				local var_57_18 = (arg_54_1.time_ - var_57_16) / var_57_17
				local var_57_19 = Color.New(0, 0, 0)

				var_57_19.a = Mathf.Lerp(0, 1, var_57_18)
				arg_54_1.mask_.color = var_57_19
			end

			if arg_54_1.time_ >= var_57_16 + var_57_17 and arg_54_1.time_ < var_57_16 + var_57_17 + arg_57_0 then
				local var_57_20 = Color.New(0, 0, 0)

				var_57_20.a = 1
				arg_54_1.mask_.color = var_57_20
			end

			local var_57_21 = 2

			if var_57_21 < arg_54_1.time_ and arg_54_1.time_ <= var_57_21 + arg_57_0 then
				arg_54_1.mask_.enabled = true
				arg_54_1.mask_.raycastTarget = true

				arg_54_1:SetGaussion(false)
			end

			local var_57_22 = 2

			if var_57_21 <= arg_54_1.time_ and arg_54_1.time_ < var_57_21 + var_57_22 then
				local var_57_23 = (arg_54_1.time_ - var_57_21) / var_57_22
				local var_57_24 = Color.New(0, 0, 0)

				var_57_24.a = Mathf.Lerp(1, 0, var_57_23)
				arg_54_1.mask_.color = var_57_24
			end

			if arg_54_1.time_ >= var_57_21 + var_57_22 and arg_54_1.time_ < var_57_21 + var_57_22 + arg_57_0 then
				local var_57_25 = Color.New(0, 0, 0)
				local var_57_26 = 0

				arg_54_1.mask_.enabled = false
				var_57_25.a = var_57_26
				arg_54_1.mask_.color = var_57_25
			end

			if arg_54_1.frameCnt_ <= 1 then
				arg_54_1.dialog_:SetActive(false)
			end

			local var_57_27 = 4
			local var_57_28 = 0.7

			if var_57_27 < arg_54_1.time_ and arg_54_1.time_ <= var_57_27 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0

				arg_54_1.dialog_:SetActive(true)

				arg_54_1.dialogCg_.alpha = 0

				local var_57_29 = LeanTween.value(arg_54_1.dialog_, 0, 1, 0.3)

				var_57_29:setOnUpdate(LuaHelper.FloatAction(function(arg_58_0)
					arg_54_1.dialogCg_.alpha = arg_58_0
				end))
				var_57_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_54_1.dialog_)
					var_57_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_54_1.duration_ = arg_54_1.duration_ + 0.3

				SetActive(arg_54_1.leftNameGo_, true)

				local var_57_30 = arg_54_1:FormatText(StoryNameCfg[328].name)

				arg_54_1.leftNameTxt_.text = var_57_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, true)
				arg_54_1.iconController_:SetSelectedState("hero")

				arg_54_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10032")

				arg_54_1.callingController_:SetSelectedState("normal")

				arg_54_1.keyicon_.color = Color.New(1, 1, 1)
				arg_54_1.icon_.color = Color.New(1, 1, 1)

				local var_57_31 = arg_54_1:GetWordFromCfg(116381013)
				local var_57_32 = arg_54_1:FormatText(var_57_31.content)

				arg_54_1.text_.text = var_57_32

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_33 = 26
				local var_57_34 = utf8.len(var_57_32)
				local var_57_35 = var_57_33 <= 0 and var_57_28 or var_57_28 * (var_57_34 / var_57_33)

				if var_57_35 > 0 and var_57_28 < var_57_35 then
					arg_54_1.talkMaxDuration = var_57_35
					var_57_27 = var_57_27 + 0.3

					if var_57_35 + var_57_27 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_35 + var_57_27
					end
				end

				arg_54_1.text_.text = var_57_32
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381013", "story_v_out_116381.awb") ~= 0 then
					local var_57_36 = manager.audio:GetVoiceLength("story_v_out_116381", "116381013", "story_v_out_116381.awb") / 1000

					if var_57_36 + var_57_27 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_36 + var_57_27
					end

					if var_57_31.prefab_name ~= "" and arg_54_1.actors_[var_57_31.prefab_name] ~= nil then
						local var_57_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_31.prefab_name].transform, "story_v_out_116381", "116381013", "story_v_out_116381.awb")

						arg_54_1:RecordAudio("116381013", var_57_37)
						arg_54_1:RecordAudio("116381013", var_57_37)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_116381", "116381013", "story_v_out_116381.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_116381", "116381013", "story_v_out_116381.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_38 = var_57_27 + 0.3
			local var_57_39 = math.max(var_57_28, arg_54_1.talkMaxDuration)

			if var_57_38 <= arg_54_1.time_ and arg_54_1.time_ < var_57_38 + var_57_39 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_38) / var_57_39

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_38 + var_57_39 and arg_54_1.time_ < var_57_38 + var_57_39 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play116381014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 116381014
		arg_60_1.duration_ = 8.83

		local var_60_0 = {
			zh = 8.833,
			ja = 7.933
		}
		local var_60_1 = manager.audio:GetLocalizationFlag()

		if var_60_0[var_60_1] ~= nil then
			arg_60_1.duration_ = var_60_0[var_60_1]
		end

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play116381015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = "SK0201"

			if arg_60_1.bgs_[var_63_0] == nil then
				local var_63_1 = Object.Instantiate(arg_60_1.paintGo_)

				var_63_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_63_0)
				var_63_1.name = var_63_0
				var_63_1.transform.parent = arg_60_1.stage_.transform
				var_63_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_60_1.bgs_[var_63_0] = var_63_1
			end

			local var_63_2 = 2

			if var_63_2 < arg_60_1.time_ and arg_60_1.time_ <= var_63_2 + arg_63_0 then
				local var_63_3 = manager.ui.mainCamera.transform.localPosition
				local var_63_4 = Vector3.New(0, 0, 10) + Vector3.New(var_63_3.x, var_63_3.y, 0)
				local var_63_5 = arg_60_1.bgs_.SK0201

				var_63_5.transform.localPosition = var_63_4
				var_63_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_63_6 = var_63_5:GetComponent("SpriteRenderer")

				if var_63_6 and var_63_6.sprite then
					local var_63_7 = (var_63_5.transform.localPosition - var_63_3).z
					local var_63_8 = manager.ui.mainCameraCom_
					local var_63_9 = 2 * var_63_7 * Mathf.Tan(var_63_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_63_10 = var_63_9 * var_63_8.aspect
					local var_63_11 = var_63_6.sprite.bounds.size.x
					local var_63_12 = var_63_6.sprite.bounds.size.y
					local var_63_13 = var_63_10 / var_63_11
					local var_63_14 = var_63_9 / var_63_12
					local var_63_15 = var_63_14 < var_63_13 and var_63_13 or var_63_14

					var_63_5.transform.localScale = Vector3.New(var_63_15, var_63_15, 0)
				end

				for iter_63_0, iter_63_1 in pairs(arg_60_1.bgs_) do
					if iter_63_0 ~= "SK0201" then
						iter_63_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_63_16 = 0

			if var_63_16 < arg_60_1.time_ and arg_60_1.time_ <= var_63_16 + arg_63_0 then
				arg_60_1.mask_.enabled = true
				arg_60_1.mask_.raycastTarget = true

				arg_60_1:SetGaussion(false)
			end

			local var_63_17 = 2

			if var_63_16 <= arg_60_1.time_ and arg_60_1.time_ < var_63_16 + var_63_17 then
				local var_63_18 = (arg_60_1.time_ - var_63_16) / var_63_17
				local var_63_19 = Color.New(0, 0, 0)

				var_63_19.a = Mathf.Lerp(0, 1, var_63_18)
				arg_60_1.mask_.color = var_63_19
			end

			if arg_60_1.time_ >= var_63_16 + var_63_17 and arg_60_1.time_ < var_63_16 + var_63_17 + arg_63_0 then
				local var_63_20 = Color.New(0, 0, 0)

				var_63_20.a = 1
				arg_60_1.mask_.color = var_63_20
			end

			local var_63_21 = 2

			if var_63_21 < arg_60_1.time_ and arg_60_1.time_ <= var_63_21 + arg_63_0 then
				arg_60_1.mask_.enabled = true
				arg_60_1.mask_.raycastTarget = true

				arg_60_1:SetGaussion(false)
			end

			local var_63_22 = 2

			if var_63_21 <= arg_60_1.time_ and arg_60_1.time_ < var_63_21 + var_63_22 then
				local var_63_23 = (arg_60_1.time_ - var_63_21) / var_63_22
				local var_63_24 = Color.New(0, 0, 0)

				var_63_24.a = Mathf.Lerp(1, 0, var_63_23)
				arg_60_1.mask_.color = var_63_24
			end

			if arg_60_1.time_ >= var_63_21 + var_63_22 and arg_60_1.time_ < var_63_21 + var_63_22 + arg_63_0 then
				local var_63_25 = Color.New(0, 0, 0)
				local var_63_26 = 0

				arg_60_1.mask_.enabled = false
				var_63_25.a = var_63_26
				arg_60_1.mask_.color = var_63_25
			end

			if arg_60_1.frameCnt_ <= 1 then
				arg_60_1.dialog_:SetActive(false)
			end

			local var_63_27 = 4
			local var_63_28 = 0.4

			if var_63_27 < arg_60_1.time_ and arg_60_1.time_ <= var_63_27 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0

				arg_60_1.dialog_:SetActive(true)

				arg_60_1.dialogCg_.alpha = 0

				local var_63_29 = LeanTween.value(arg_60_1.dialog_, 0, 1, 0.3)

				var_63_29:setOnUpdate(LuaHelper.FloatAction(function(arg_64_0)
					arg_60_1.dialogCg_.alpha = arg_64_0
				end))
				var_63_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_60_1.dialog_)
					var_63_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_60_1.duration_ = arg_60_1.duration_ + 0.3

				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_30 = arg_60_1:FormatText(StoryNameCfg[328].name)

				arg_60_1.leftNameTxt_.text = var_63_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, true)
				arg_60_1.iconController_:SetSelectedState("hero")

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10032")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_31 = arg_60_1:GetWordFromCfg(116381014)
				local var_63_32 = arg_60_1:FormatText(var_63_31.content)

				arg_60_1.text_.text = var_63_32

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_33 = 16
				local var_63_34 = utf8.len(var_63_32)
				local var_63_35 = var_63_33 <= 0 and var_63_28 or var_63_28 * (var_63_34 / var_63_33)

				if var_63_35 > 0 and var_63_28 < var_63_35 then
					arg_60_1.talkMaxDuration = var_63_35
					var_63_27 = var_63_27 + 0.3

					if var_63_35 + var_63_27 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_35 + var_63_27
					end
				end

				arg_60_1.text_.text = var_63_32
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381014", "story_v_out_116381.awb") ~= 0 then
					local var_63_36 = manager.audio:GetVoiceLength("story_v_out_116381", "116381014", "story_v_out_116381.awb") / 1000

					if var_63_36 + var_63_27 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_36 + var_63_27
					end

					if var_63_31.prefab_name ~= "" and arg_60_1.actors_[var_63_31.prefab_name] ~= nil then
						local var_63_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_31.prefab_name].transform, "story_v_out_116381", "116381014", "story_v_out_116381.awb")

						arg_60_1:RecordAudio("116381014", var_63_37)
						arg_60_1:RecordAudio("116381014", var_63_37)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_116381", "116381014", "story_v_out_116381.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_116381", "116381014", "story_v_out_116381.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_38 = var_63_27 + 0.3
			local var_63_39 = math.max(var_63_28, arg_60_1.talkMaxDuration)

			if var_63_38 <= arg_60_1.time_ and arg_60_1.time_ < var_63_38 + var_63_39 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_38) / var_63_39

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_38 + var_63_39 and arg_60_1.time_ < var_63_38 + var_63_39 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play116381015 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 116381015
		arg_66_1.duration_ = 17.77

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play116381016(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = 2

			if var_69_0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_0 + arg_69_0 then
				local var_69_1 = manager.ui.mainCamera.transform.localPosition
				local var_69_2 = Vector3.New(0, 0, 10) + Vector3.New(var_69_1.x, var_69_1.y, 0)
				local var_69_3 = arg_66_1.bgs_.STblack

				var_69_3.transform.localPosition = var_69_2
				var_69_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_69_4 = var_69_3:GetComponent("SpriteRenderer")

				if var_69_4 and var_69_4.sprite then
					local var_69_5 = (var_69_3.transform.localPosition - var_69_1).z
					local var_69_6 = manager.ui.mainCameraCom_
					local var_69_7 = 2 * var_69_5 * Mathf.Tan(var_69_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_69_8 = var_69_7 * var_69_6.aspect
					local var_69_9 = var_69_4.sprite.bounds.size.x
					local var_69_10 = var_69_4.sprite.bounds.size.y
					local var_69_11 = var_69_8 / var_69_9
					local var_69_12 = var_69_7 / var_69_10
					local var_69_13 = var_69_12 < var_69_11 and var_69_11 or var_69_12

					var_69_3.transform.localScale = Vector3.New(var_69_13, var_69_13, 0)
				end

				for iter_69_0, iter_69_1 in pairs(arg_66_1.bgs_) do
					if iter_69_0 ~= "STblack" then
						iter_69_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_69_14 = 0

			if var_69_14 < arg_66_1.time_ and arg_66_1.time_ <= var_69_14 + arg_69_0 then
				arg_66_1.mask_.enabled = true
				arg_66_1.mask_.raycastTarget = true

				arg_66_1:SetGaussion(false)
			end

			local var_69_15 = 2

			if var_69_14 <= arg_66_1.time_ and arg_66_1.time_ < var_69_14 + var_69_15 then
				local var_69_16 = (arg_66_1.time_ - var_69_14) / var_69_15
				local var_69_17 = Color.New(0, 0, 0)

				var_69_17.a = Mathf.Lerp(0, 1, var_69_16)
				arg_66_1.mask_.color = var_69_17
			end

			if arg_66_1.time_ >= var_69_14 + var_69_15 and arg_66_1.time_ < var_69_14 + var_69_15 + arg_69_0 then
				local var_69_18 = Color.New(0, 0, 0)

				var_69_18.a = 1
				arg_66_1.mask_.color = var_69_18
			end

			local var_69_19 = 2

			if var_69_19 < arg_66_1.time_ and arg_66_1.time_ <= var_69_19 + arg_69_0 then
				arg_66_1.mask_.enabled = true
				arg_66_1.mask_.raycastTarget = true

				arg_66_1:SetGaussion(false)
			end

			local var_69_20 = 2

			if var_69_19 <= arg_66_1.time_ and arg_66_1.time_ < var_69_19 + var_69_20 then
				local var_69_21 = (arg_66_1.time_ - var_69_19) / var_69_20
				local var_69_22 = Color.New(0, 0, 0)

				var_69_22.a = Mathf.Lerp(1, 0, var_69_21)
				arg_66_1.mask_.color = var_69_22
			end

			if arg_66_1.time_ >= var_69_19 + var_69_20 and arg_66_1.time_ < var_69_19 + var_69_20 + arg_69_0 then
				local var_69_23 = Color.New(0, 0, 0)
				local var_69_24 = 0

				arg_66_1.mask_.enabled = false
				var_69_23.a = var_69_24
				arg_66_1.mask_.color = var_69_23
			end

			local var_69_25 = 4
			local var_69_26 = 12.868
			local var_69_27 = manager.audio:GetVoiceLength("story_v_out_116381", "116381015", "story_v_out_116381.awb") / 1000

			if var_69_27 > 0 and var_69_26 < var_69_27 and var_69_27 + var_69_25 > arg_66_1.duration_ then
				local var_69_28 = var_69_27

				arg_66_1.duration_ = var_69_27 + var_69_25
			end

			if var_69_25 < arg_66_1.time_ and arg_66_1.time_ <= var_69_25 + arg_69_0 then
				local var_69_29 = "play"
				local var_69_30 = "voice"

				arg_66_1:AudioAction(var_69_29, var_69_30, "story_v_out_116381", "116381015", "story_v_out_116381.awb")
			end

			local var_69_31 = 2

			if var_69_31 < arg_66_1.time_ and arg_66_1.time_ <= var_69_31 + arg_69_0 then
				arg_66_1.fswbg_:SetActive(true)
				arg_66_1.dialog_:SetActive(false)

				arg_66_1.fswtw_.percent = 0

				local var_69_32 = arg_66_1:GetWordFromCfg(116381015)
				local var_69_33 = arg_66_1:FormatText(var_69_32.content)

				arg_66_1.fswt_.text = var_69_33

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.fswt_)

				arg_66_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_66_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_66_1.fswtw_:SetDirty()

				arg_66_1.typewritterCharCountI18N = 0

				SetActive(arg_66_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_66_1:ShowNextGo(false)
			end

			local var_69_34 = 4

			if var_69_34 < arg_66_1.time_ and arg_66_1.time_ <= var_69_34 + arg_69_0 then
				arg_66_1.var_.oldValueTypewriter = arg_66_1.fswtw_.percent

				SetActive(arg_66_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_66_1:ShowNextGo(false)
			end

			local var_69_35 = 53
			local var_69_36 = 3.53333333333333
			local var_69_37 = arg_66_1:GetWordFromCfg(116381015)
			local var_69_38 = arg_66_1:FormatText(var_69_37.content)
			local var_69_39, var_69_40 = arg_66_1:GetPercentByPara(var_69_38, 1)

			if var_69_34 < arg_66_1.time_ and arg_66_1.time_ <= var_69_34 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0

				local var_69_41 = var_69_35 <= 0 and var_69_36 or var_69_36 * ((var_69_40 - arg_66_1.typewritterCharCountI18N) / var_69_35)

				if var_69_41 > 0 and var_69_36 < var_69_41 then
					arg_66_1.talkMaxDuration = var_69_41

					if var_69_41 + var_69_34 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_41 + var_69_34
					end
				end
			end

			local var_69_42 = 3.53333333333333
			local var_69_43 = math.max(var_69_42, arg_66_1.talkMaxDuration)

			if var_69_34 <= arg_66_1.time_ and arg_66_1.time_ < var_69_34 + var_69_43 then
				local var_69_44 = (arg_66_1.time_ - var_69_34) / var_69_43

				arg_66_1.fswtw_.percent = Mathf.Lerp(arg_66_1.var_.oldValueTypewriter, var_69_39, var_69_44)
				arg_66_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_66_1.fswtw_:SetDirty()
			end

			if arg_66_1.time_ >= var_69_34 + var_69_43 and arg_66_1.time_ < var_69_34 + var_69_43 + arg_69_0 then
				arg_66_1.fswtw_.percent = var_69_39

				arg_66_1.fswtw_:SetDirty()
				arg_66_1:ShowNextGo(true)

				arg_66_1.typewritterCharCountI18N = var_69_40
			end

			local var_69_45 = 4

			if var_69_45 < arg_66_1.time_ and arg_66_1.time_ <= var_69_45 + arg_69_0 then
				arg_66_1.allBtn_.enabled = false
			end

			local var_69_46 = 3.53333333333333

			if arg_66_1.time_ >= var_69_45 + var_69_46 and arg_66_1.time_ < var_69_45 + var_69_46 + arg_69_0 then
				arg_66_1.allBtn_.enabled = true
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play116381016 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 116381016
		arg_70_1.duration_ = 7.7

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play116381017(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = 0

			if var_73_0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_0 + arg_73_0 then
				arg_70_1.var_.oldValueTypewriter = arg_70_1.fswtw_.percent

				SetActive(arg_70_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_70_1:ShowNextGo(false)
			end

			local var_73_1 = 93
			local var_73_2 = 2.66666666666667
			local var_73_3 = arg_70_1:GetWordFromCfg(116381015)
			local var_73_4 = arg_70_1:FormatText(var_73_3.content)
			local var_73_5, var_73_6 = arg_70_1:GetPercentByPara(var_73_4, 2)

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

			local var_73_8 = 2.66666666666667
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
			local var_73_12 = 7.697
			local var_73_13 = manager.audio:GetVoiceLength("story_v_out_116381", "116381016", "story_v_out_116381.awb") / 1000

			if var_73_13 > 0 and var_73_12 < var_73_13 and var_73_13 + var_73_11 > arg_70_1.duration_ then
				local var_73_14 = var_73_13

				arg_70_1.duration_ = var_73_13 + var_73_11
			end

			if var_73_11 < arg_70_1.time_ and arg_70_1.time_ <= var_73_11 + arg_73_0 then
				local var_73_15 = "play"
				local var_73_16 = "voice"

				arg_70_1:AudioAction(var_73_15, var_73_16, "story_v_out_116381", "116381016", "story_v_out_116381.awb")
			end

			local var_73_17 = 0

			if var_73_17 < arg_70_1.time_ and arg_70_1.time_ <= var_73_17 + arg_73_0 then
				arg_70_1.allBtn_.enabled = false
			end

			local var_73_18 = 2.66666666666667

			if arg_70_1.time_ >= var_73_17 + var_73_18 and arg_70_1.time_ < var_73_17 + var_73_18 + arg_73_0 then
				arg_70_1.allBtn_.enabled = true
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play116381017 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 116381017
		arg_74_1.duration_ = 3.49

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play116381018(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0

			if var_77_0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_0 + arg_77_0 then
				arg_74_1.var_.oldValueTypewriter = arg_74_1.fswtw_.percent

				SetActive(arg_74_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_74_1:ShowNextGo(false)
			end

			local var_77_1 = 12
			local var_77_2 = 0.8
			local var_77_3 = arg_74_1:GetWordFromCfg(116381015)
			local var_77_4 = arg_74_1:FormatText(var_77_3.content)
			local var_77_5, var_77_6 = arg_74_1:GetPercentByPara(var_77_4, 3)

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

			local var_77_8 = 0.8
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
			local var_77_12 = 3.495
			local var_77_13 = manager.audio:GetVoiceLength("story_v_out_116381", "116381017", "story_v_out_116381.awb") / 1000

			if var_77_13 > 0 and var_77_12 < var_77_13 and var_77_13 + var_77_11 > arg_74_1.duration_ then
				local var_77_14 = var_77_13

				arg_74_1.duration_ = var_77_13 + var_77_11
			end

			if var_77_11 < arg_74_1.time_ and arg_74_1.time_ <= var_77_11 + arg_77_0 then
				local var_77_15 = "play"
				local var_77_16 = "voice"

				arg_74_1:AudioAction(var_77_15, var_77_16, "story_v_out_116381", "116381017", "story_v_out_116381.awb")
			end

			local var_77_17 = 0

			if var_77_17 < arg_74_1.time_ and arg_74_1.time_ <= var_77_17 + arg_77_0 then
				arg_74_1.allBtn_.enabled = false
			end

			local var_77_18 = 0.8

			if arg_74_1.time_ >= var_77_17 + var_77_18 and arg_74_1.time_ < var_77_17 + var_77_18 + arg_77_0 then
				arg_74_1.allBtn_.enabled = true
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play116381018 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 116381018
		arg_78_1.duration_ = 13.85

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play116381019(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = 0

			if var_81_0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_0 + arg_81_0 then
				arg_78_1.var_.oldValueTypewriter = arg_78_1.fswtw_.percent

				SetActive(arg_78_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_78_1:ShowNextGo(false)
			end

			local var_81_1 = 64
			local var_81_2 = 4.26666666666667
			local var_81_3 = arg_78_1:GetWordFromCfg(116381015)
			local var_81_4 = arg_78_1:FormatText(var_81_3.content)
			local var_81_5, var_81_6 = arg_78_1:GetPercentByPara(var_81_4, 4)

			if var_81_0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_0 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0

				local var_81_7 = var_81_1 <= 0 and var_81_2 or var_81_2 * ((var_81_6 - arg_78_1.typewritterCharCountI18N) / var_81_1)

				if var_81_7 > 0 and var_81_2 < var_81_7 then
					arg_78_1.talkMaxDuration = var_81_7

					if var_81_7 + var_81_0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_7 + var_81_0
					end
				end
			end

			local var_81_8 = 4.26666666666667
			local var_81_9 = math.max(var_81_8, arg_78_1.talkMaxDuration)

			if var_81_0 <= arg_78_1.time_ and arg_78_1.time_ < var_81_0 + var_81_9 then
				local var_81_10 = (arg_78_1.time_ - var_81_0) / var_81_9

				arg_78_1.fswtw_.percent = Mathf.Lerp(arg_78_1.var_.oldValueTypewriter, var_81_5, var_81_10)
				arg_78_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_78_1.fswtw_:SetDirty()
			end

			if arg_78_1.time_ >= var_81_0 + var_81_9 and arg_78_1.time_ < var_81_0 + var_81_9 + arg_81_0 then
				arg_78_1.fswtw_.percent = var_81_5

				arg_78_1.fswtw_:SetDirty()
				arg_78_1:ShowNextGo(true)

				arg_78_1.typewritterCharCountI18N = var_81_6
			end

			local var_81_11 = 0
			local var_81_12 = 13.849
			local var_81_13 = manager.audio:GetVoiceLength("story_v_out_116381", "116381018", "story_v_out_116381.awb") / 1000

			if var_81_13 > 0 and var_81_12 < var_81_13 and var_81_13 + var_81_11 > arg_78_1.duration_ then
				local var_81_14 = var_81_13

				arg_78_1.duration_ = var_81_13 + var_81_11
			end

			if var_81_11 < arg_78_1.time_ and arg_78_1.time_ <= var_81_11 + arg_81_0 then
				local var_81_15 = "play"
				local var_81_16 = "voice"

				arg_78_1:AudioAction(var_81_15, var_81_16, "story_v_out_116381", "116381018", "story_v_out_116381.awb")
			end

			local var_81_17 = 0

			if var_81_17 < arg_78_1.time_ and arg_78_1.time_ <= var_81_17 + arg_81_0 then
				arg_78_1.allBtn_.enabled = false
			end

			local var_81_18 = 4.26666666666667

			if arg_78_1.time_ >= var_81_17 + var_81_18 and arg_78_1.time_ < var_81_17 + var_81_18 + arg_81_0 then
				arg_78_1.allBtn_.enabled = true
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play116381019 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 116381019
		arg_82_1.duration_ = 4.21

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play116381020(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 0

			if var_85_0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_0 + arg_85_0 then
				arg_82_1.var_.oldValueTypewriter = arg_82_1.fswtw_.percent

				SetActive(arg_82_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_82_1:ShowNextGo(false)
			end

			local var_85_1 = 15
			local var_85_2 = 1
			local var_85_3 = arg_82_1:GetWordFromCfg(116381015)
			local var_85_4 = arg_82_1:FormatText(var_85_3.content)
			local var_85_5, var_85_6 = arg_82_1:GetPercentByPara(var_85_4, 5)

			if var_85_0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_0 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0

				local var_85_7 = var_85_1 <= 0 and var_85_2 or var_85_2 * ((var_85_6 - arg_82_1.typewritterCharCountI18N) / var_85_1)

				if var_85_7 > 0 and var_85_2 < var_85_7 then
					arg_82_1.talkMaxDuration = var_85_7

					if var_85_7 + var_85_0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_7 + var_85_0
					end
				end
			end

			local var_85_8 = 1
			local var_85_9 = math.max(var_85_8, arg_82_1.talkMaxDuration)

			if var_85_0 <= arg_82_1.time_ and arg_82_1.time_ < var_85_0 + var_85_9 then
				local var_85_10 = (arg_82_1.time_ - var_85_0) / var_85_9

				arg_82_1.fswtw_.percent = Mathf.Lerp(arg_82_1.var_.oldValueTypewriter, var_85_5, var_85_10)
				arg_82_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_82_1.fswtw_:SetDirty()
			end

			if arg_82_1.time_ >= var_85_0 + var_85_9 and arg_82_1.time_ < var_85_0 + var_85_9 + arg_85_0 then
				arg_82_1.fswtw_.percent = var_85_5

				arg_82_1.fswtw_:SetDirty()
				arg_82_1:ShowNextGo(true)

				arg_82_1.typewritterCharCountI18N = var_85_6
			end

			local var_85_11 = 0
			local var_85_12 = 4.215
			local var_85_13 = manager.audio:GetVoiceLength("story_v_out_116381", "116381019", "story_v_out_116381.awb") / 1000

			if var_85_13 > 0 and var_85_12 < var_85_13 and var_85_13 + var_85_11 > arg_82_1.duration_ then
				local var_85_14 = var_85_13

				arg_82_1.duration_ = var_85_13 + var_85_11
			end

			if var_85_11 < arg_82_1.time_ and arg_82_1.time_ <= var_85_11 + arg_85_0 then
				local var_85_15 = "play"
				local var_85_16 = "voice"

				arg_82_1:AudioAction(var_85_15, var_85_16, "story_v_out_116381", "116381019", "story_v_out_116381.awb")
			end

			local var_85_17 = 0

			if var_85_17 < arg_82_1.time_ and arg_82_1.time_ <= var_85_17 + arg_85_0 then
				arg_82_1.allBtn_.enabled = false
			end

			local var_85_18 = 1

			if arg_82_1.time_ >= var_85_17 + var_85_18 and arg_82_1.time_ < var_85_17 + var_85_18 + arg_85_0 then
				arg_82_1.allBtn_.enabled = true
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play116381020 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 116381020
		arg_86_1.duration_ = 10.61

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play116381021(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = 0

			if var_89_0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_0 + arg_89_0 then
				arg_86_1.var_.oldValueTypewriter = arg_86_1.fswtw_.percent

				SetActive(arg_86_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_86_1:ShowNextGo(false)
			end

			local var_89_1 = 49
			local var_89_2 = 3.26666666666667
			local var_89_3 = arg_86_1:GetWordFromCfg(116381015)
			local var_89_4 = arg_86_1:FormatText(var_89_3.content)
			local var_89_5, var_89_6 = arg_86_1:GetPercentByPara(var_89_4, 6)

			if var_89_0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_0 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0

				local var_89_7 = var_89_1 <= 0 and var_89_2 or var_89_2 * ((var_89_6 - arg_86_1.typewritterCharCountI18N) / var_89_1)

				if var_89_7 > 0 and var_89_2 < var_89_7 then
					arg_86_1.talkMaxDuration = var_89_7

					if var_89_7 + var_89_0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_7 + var_89_0
					end
				end
			end

			local var_89_8 = 3.26666666666667
			local var_89_9 = math.max(var_89_8, arg_86_1.talkMaxDuration)

			if var_89_0 <= arg_86_1.time_ and arg_86_1.time_ < var_89_0 + var_89_9 then
				local var_89_10 = (arg_86_1.time_ - var_89_0) / var_89_9

				arg_86_1.fswtw_.percent = Mathf.Lerp(arg_86_1.var_.oldValueTypewriter, var_89_5, var_89_10)
				arg_86_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_86_1.fswtw_:SetDirty()
			end

			if arg_86_1.time_ >= var_89_0 + var_89_9 and arg_86_1.time_ < var_89_0 + var_89_9 + arg_89_0 then
				arg_86_1.fswtw_.percent = var_89_5

				arg_86_1.fswtw_:SetDirty()
				arg_86_1:ShowNextGo(true)

				arg_86_1.typewritterCharCountI18N = var_89_6
			end

			local var_89_11 = 0
			local var_89_12 = 10.607
			local var_89_13 = manager.audio:GetVoiceLength("story_v_out_116381", "116381020", "story_v_out_116381.awb") / 1000

			if var_89_13 > 0 and var_89_12 < var_89_13 and var_89_13 + var_89_11 > arg_86_1.duration_ then
				local var_89_14 = var_89_13

				arg_86_1.duration_ = var_89_13 + var_89_11
			end

			if var_89_11 < arg_86_1.time_ and arg_86_1.time_ <= var_89_11 + arg_89_0 then
				local var_89_15 = "play"
				local var_89_16 = "voice"

				arg_86_1:AudioAction(var_89_15, var_89_16, "story_v_out_116381", "116381020", "story_v_out_116381.awb")
			end

			local var_89_17 = 0

			if var_89_17 < arg_86_1.time_ and arg_86_1.time_ <= var_89_17 + arg_89_0 then
				arg_86_1.allBtn_.enabled = false
			end

			local var_89_18 = 3.26666666666667

			if arg_86_1.time_ >= var_89_17 + var_89_18 and arg_86_1.time_ < var_89_17 + var_89_18 + arg_89_0 then
				arg_86_1.allBtn_.enabled = true
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play116381021 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 116381021
		arg_90_1.duration_ = 7.81

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play116381022(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 0

			if var_93_0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_0 + arg_93_0 then
				arg_90_1.var_.oldValueTypewriter = arg_90_1.fswtw_.percent

				SetActive(arg_90_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_90_1:ShowNextGo(false)
			end

			local var_93_1 = 43
			local var_93_2 = 2.86666666666667
			local var_93_3 = arg_90_1:GetWordFromCfg(116381015)
			local var_93_4 = arg_90_1:FormatText(var_93_3.content)
			local var_93_5, var_93_6 = arg_90_1:GetPercentByPara(var_93_4, 7)

			if var_93_0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_0 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0

				local var_93_7 = var_93_1 <= 0 and var_93_2 or var_93_2 * ((var_93_6 - arg_90_1.typewritterCharCountI18N) / var_93_1)

				if var_93_7 > 0 and var_93_2 < var_93_7 then
					arg_90_1.talkMaxDuration = var_93_7

					if var_93_7 + var_93_0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_7 + var_93_0
					end
				end
			end

			local var_93_8 = 2.86666666666667
			local var_93_9 = math.max(var_93_8, arg_90_1.talkMaxDuration)

			if var_93_0 <= arg_90_1.time_ and arg_90_1.time_ < var_93_0 + var_93_9 then
				local var_93_10 = (arg_90_1.time_ - var_93_0) / var_93_9

				arg_90_1.fswtw_.percent = Mathf.Lerp(arg_90_1.var_.oldValueTypewriter, var_93_5, var_93_10)
				arg_90_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_90_1.fswtw_:SetDirty()
			end

			if arg_90_1.time_ >= var_93_0 + var_93_9 and arg_90_1.time_ < var_93_0 + var_93_9 + arg_93_0 then
				arg_90_1.fswtw_.percent = var_93_5

				arg_90_1.fswtw_:SetDirty()
				arg_90_1:ShowNextGo(true)

				arg_90_1.typewritterCharCountI18N = var_93_6
			end

			local var_93_11 = 0
			local var_93_12 = 7.807
			local var_93_13 = manager.audio:GetVoiceLength("story_v_out_116381", "116381021", "story_v_out_116381.awb") / 1000

			if var_93_13 > 0 and var_93_12 < var_93_13 and var_93_13 + var_93_11 > arg_90_1.duration_ then
				local var_93_14 = var_93_13

				arg_90_1.duration_ = var_93_13 + var_93_11
			end

			if var_93_11 < arg_90_1.time_ and arg_90_1.time_ <= var_93_11 + arg_93_0 then
				local var_93_15 = "play"
				local var_93_16 = "voice"

				arg_90_1:AudioAction(var_93_15, var_93_16, "story_v_out_116381", "116381021", "story_v_out_116381.awb")
			end

			local var_93_17 = 0

			if var_93_17 < arg_90_1.time_ and arg_90_1.time_ <= var_93_17 + arg_93_0 then
				arg_90_1.allBtn_.enabled = false
			end

			local var_93_18 = 2.86666666666667

			if arg_90_1.time_ >= var_93_17 + var_93_18 and arg_90_1.time_ < var_93_17 + var_93_18 + arg_93_0 then
				arg_90_1.allBtn_.enabled = true
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play116381022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 116381022
		arg_94_1.duration_ = 20.4

		local var_94_0 = {
			zh = 15.7,
			ja = 20.4
		}
		local var_94_1 = manager.audio:GetLocalizationFlag()

		if var_94_0[var_94_1] ~= nil then
			arg_94_1.duration_ = var_94_0[var_94_1]
		end

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play116381023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = "SK0106"

			if arg_94_1.bgs_[var_97_0] == nil then
				local var_97_1 = Object.Instantiate(arg_94_1.paintGo_)

				var_97_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_97_0)
				var_97_1.name = var_97_0
				var_97_1.transform.parent = arg_94_1.stage_.transform
				var_97_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_94_1.bgs_[var_97_0] = var_97_1
			end

			local var_97_2 = 2

			if var_97_2 < arg_94_1.time_ and arg_94_1.time_ <= var_97_2 + arg_97_0 then
				local var_97_3 = manager.ui.mainCamera.transform.localPosition
				local var_97_4 = Vector3.New(0, 0, 10) + Vector3.New(var_97_3.x, var_97_3.y, 0)
				local var_97_5 = arg_94_1.bgs_.SK0106

				var_97_5.transform.localPosition = var_97_4
				var_97_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_97_6 = var_97_5:GetComponent("SpriteRenderer")

				if var_97_6 and var_97_6.sprite then
					local var_97_7 = (var_97_5.transform.localPosition - var_97_3).z
					local var_97_8 = manager.ui.mainCameraCom_
					local var_97_9 = 2 * var_97_7 * Mathf.Tan(var_97_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_97_10 = var_97_9 * var_97_8.aspect
					local var_97_11 = var_97_6.sprite.bounds.size.x
					local var_97_12 = var_97_6.sprite.bounds.size.y
					local var_97_13 = var_97_10 / var_97_11
					local var_97_14 = var_97_9 / var_97_12
					local var_97_15 = var_97_14 < var_97_13 and var_97_13 or var_97_14

					var_97_5.transform.localScale = Vector3.New(var_97_15, var_97_15, 0)
				end

				for iter_97_0, iter_97_1 in pairs(arg_94_1.bgs_) do
					if iter_97_0 ~= "SK0106" then
						iter_97_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_97_16 = 0

			if var_97_16 < arg_94_1.time_ and arg_94_1.time_ <= var_97_16 + arg_97_0 then
				arg_94_1.mask_.enabled = true
				arg_94_1.mask_.raycastTarget = true

				arg_94_1:SetGaussion(false)
			end

			local var_97_17 = 2

			if var_97_16 <= arg_94_1.time_ and arg_94_1.time_ < var_97_16 + var_97_17 then
				local var_97_18 = (arg_94_1.time_ - var_97_16) / var_97_17
				local var_97_19 = Color.New(0, 0, 0)

				var_97_19.a = Mathf.Lerp(0, 1, var_97_18)
				arg_94_1.mask_.color = var_97_19
			end

			if arg_94_1.time_ >= var_97_16 + var_97_17 and arg_94_1.time_ < var_97_16 + var_97_17 + arg_97_0 then
				local var_97_20 = Color.New(0, 0, 0)

				var_97_20.a = 1
				arg_94_1.mask_.color = var_97_20
			end

			local var_97_21 = 2

			if var_97_21 < arg_94_1.time_ and arg_94_1.time_ <= var_97_21 + arg_97_0 then
				arg_94_1.mask_.enabled = true
				arg_94_1.mask_.raycastTarget = true

				arg_94_1:SetGaussion(false)
			end

			local var_97_22 = 2

			if var_97_21 <= arg_94_1.time_ and arg_94_1.time_ < var_97_21 + var_97_22 then
				local var_97_23 = (arg_94_1.time_ - var_97_21) / var_97_22
				local var_97_24 = Color.New(0, 0, 0)

				var_97_24.a = Mathf.Lerp(1, 0, var_97_23)
				arg_94_1.mask_.color = var_97_24
			end

			if arg_94_1.time_ >= var_97_21 + var_97_22 and arg_94_1.time_ < var_97_21 + var_97_22 + arg_97_0 then
				local var_97_25 = Color.New(0, 0, 0)
				local var_97_26 = 0

				arg_94_1.mask_.enabled = false
				var_97_25.a = var_97_26
				arg_94_1.mask_.color = var_97_25
			end

			local var_97_27 = 2

			if var_97_27 < arg_94_1.time_ and arg_94_1.time_ <= var_97_27 + arg_97_0 then
				arg_94_1.fswbg_:SetActive(false)
				arg_94_1.dialog_:SetActive(false)
				SetActive(arg_94_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_94_1:ShowNextGo(false)
			end

			local var_97_28 = 2

			arg_94_1.isInRecall_ = false

			if var_97_28 < arg_94_1.time_ and arg_94_1.time_ <= var_97_28 + arg_97_0 then
				arg_94_1.screenFilterGo_:SetActive(true)

				arg_94_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_97_2, iter_97_3 in pairs(arg_94_1.actors_) do
					local var_97_29 = iter_97_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_97_4, iter_97_5 in ipairs(var_97_29) do
						if iter_97_5.color.r > 0.51 then
							iter_97_5.color = Color.New(1, 1, 1)
						else
							iter_97_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_97_30 = 0.1

			if var_97_28 <= arg_94_1.time_ and arg_94_1.time_ < var_97_28 + var_97_30 then
				local var_97_31 = (arg_94_1.time_ - var_97_28) / var_97_30

				arg_94_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_97_31)
			end

			if arg_94_1.time_ >= var_97_28 + var_97_30 and arg_94_1.time_ < var_97_28 + var_97_30 + arg_97_0 then
				arg_94_1.screenFilterEffect_.weight = 1
			end

			if arg_94_1.frameCnt_ <= 1 then
				arg_94_1.dialog_:SetActive(false)
			end

			local var_97_32 = 4
			local var_97_33 = 0.875

			if var_97_32 < arg_94_1.time_ and arg_94_1.time_ <= var_97_32 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0

				arg_94_1.dialog_:SetActive(true)

				arg_94_1.dialogCg_.alpha = 0

				local var_97_34 = LeanTween.value(arg_94_1.dialog_, 0, 1, 0.3)

				var_97_34:setOnUpdate(LuaHelper.FloatAction(function(arg_98_0)
					arg_94_1.dialogCg_.alpha = arg_98_0
				end))
				var_97_34:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_94_1.dialog_)
					var_97_34:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_94_1.duration_ = arg_94_1.duration_ + 0.3

				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_35 = arg_94_1:FormatText(StoryNameCfg[328].name)

				arg_94_1.leftNameTxt_.text = var_97_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, true)
				arg_94_1.iconController_:SetSelectedState("hero")

				arg_94_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10032")

				arg_94_1.callingController_:SetSelectedState("normal")

				arg_94_1.keyicon_.color = Color.New(1, 1, 1)
				arg_94_1.icon_.color = Color.New(1, 1, 1)

				local var_97_36 = arg_94_1:GetWordFromCfg(116381022)
				local var_97_37 = arg_94_1:FormatText(var_97_36.content)

				arg_94_1.text_.text = var_97_37

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_38 = 34
				local var_97_39 = utf8.len(var_97_37)
				local var_97_40 = var_97_38 <= 0 and var_97_33 or var_97_33 * (var_97_39 / var_97_38)

				if var_97_40 > 0 and var_97_33 < var_97_40 then
					arg_94_1.talkMaxDuration = var_97_40
					var_97_32 = var_97_32 + 0.3

					if var_97_40 + var_97_32 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_40 + var_97_32
					end
				end

				arg_94_1.text_.text = var_97_37
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381022", "story_v_out_116381.awb") ~= 0 then
					local var_97_41 = manager.audio:GetVoiceLength("story_v_out_116381", "116381022", "story_v_out_116381.awb") / 1000

					if var_97_41 + var_97_32 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_41 + var_97_32
					end

					if var_97_36.prefab_name ~= "" and arg_94_1.actors_[var_97_36.prefab_name] ~= nil then
						local var_97_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_36.prefab_name].transform, "story_v_out_116381", "116381022", "story_v_out_116381.awb")

						arg_94_1:RecordAudio("116381022", var_97_42)
						arg_94_1:RecordAudio("116381022", var_97_42)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_116381", "116381022", "story_v_out_116381.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_116381", "116381022", "story_v_out_116381.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_43 = var_97_32 + 0.3
			local var_97_44 = math.max(var_97_33, arg_94_1.talkMaxDuration)

			if var_97_43 <= arg_94_1.time_ and arg_94_1.time_ < var_97_43 + var_97_44 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_43) / var_97_44

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_43 + var_97_44 and arg_94_1.time_ < var_97_43 + var_97_44 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play116381023 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 116381023
		arg_100_1.duration_ = 15.73

		local var_100_0 = {
			zh = 12.1,
			ja = 15.733
		}
		local var_100_1 = manager.audio:GetLocalizationFlag()

		if var_100_0[var_100_1] ~= nil then
			arg_100_1.duration_ = var_100_0[var_100_1]
		end

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play116381024(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = 0
			local var_103_1 = 1.15

			if var_103_0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_0 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_2 = arg_100_1:FormatText(StoryNameCfg[328].name)

				arg_100_1.leftNameTxt_.text = var_103_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, true)
				arg_100_1.iconController_:SetSelectedState("hero")

				arg_100_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10032")

				arg_100_1.callingController_:SetSelectedState("normal")

				arg_100_1.keyicon_.color = Color.New(1, 1, 1)
				arg_100_1.icon_.color = Color.New(1, 1, 1)

				local var_103_3 = arg_100_1:GetWordFromCfg(116381023)
				local var_103_4 = arg_100_1:FormatText(var_103_3.content)

				arg_100_1.text_.text = var_103_4

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_5 = 46
				local var_103_6 = utf8.len(var_103_4)
				local var_103_7 = var_103_5 <= 0 and var_103_1 or var_103_1 * (var_103_6 / var_103_5)

				if var_103_7 > 0 and var_103_1 < var_103_7 then
					arg_100_1.talkMaxDuration = var_103_7

					if var_103_7 + var_103_0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_7 + var_103_0
					end
				end

				arg_100_1.text_.text = var_103_4
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381023", "story_v_out_116381.awb") ~= 0 then
					local var_103_8 = manager.audio:GetVoiceLength("story_v_out_116381", "116381023", "story_v_out_116381.awb") / 1000

					if var_103_8 + var_103_0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_8 + var_103_0
					end

					if var_103_3.prefab_name ~= "" and arg_100_1.actors_[var_103_3.prefab_name] ~= nil then
						local var_103_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_3.prefab_name].transform, "story_v_out_116381", "116381023", "story_v_out_116381.awb")

						arg_100_1:RecordAudio("116381023", var_103_9)
						arg_100_1:RecordAudio("116381023", var_103_9)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_116381", "116381023", "story_v_out_116381.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_116381", "116381023", "story_v_out_116381.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_10 = math.max(var_103_1, arg_100_1.talkMaxDuration)

			if var_103_0 <= arg_100_1.time_ and arg_100_1.time_ < var_103_0 + var_103_10 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_0) / var_103_10

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_0 + var_103_10 and arg_100_1.time_ < var_103_0 + var_103_10 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play116381024 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 116381024
		arg_104_1.duration_ = 8.8

		local var_104_0 = {
			zh = 4.066,
			ja = 8.8
		}
		local var_104_1 = manager.audio:GetLocalizationFlag()

		if var_104_0[var_104_1] ~= nil then
			arg_104_1.duration_ = var_104_0[var_104_1]
		end

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play116381025(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = 0
			local var_107_1 = 0.375

			if var_107_0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_0 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_2 = arg_104_1:FormatText(StoryNameCfg[328].name)

				arg_104_1.leftNameTxt_.text = var_107_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, true)
				arg_104_1.iconController_:SetSelectedState("hero")

				arg_104_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10032")

				arg_104_1.callingController_:SetSelectedState("normal")

				arg_104_1.keyicon_.color = Color.New(1, 1, 1)
				arg_104_1.icon_.color = Color.New(1, 1, 1)

				local var_107_3 = arg_104_1:GetWordFromCfg(116381024)
				local var_107_4 = arg_104_1:FormatText(var_107_3.content)

				arg_104_1.text_.text = var_107_4

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_5 = 15
				local var_107_6 = utf8.len(var_107_4)
				local var_107_7 = var_107_5 <= 0 and var_107_1 or var_107_1 * (var_107_6 / var_107_5)

				if var_107_7 > 0 and var_107_1 < var_107_7 then
					arg_104_1.talkMaxDuration = var_107_7

					if var_107_7 + var_107_0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_7 + var_107_0
					end
				end

				arg_104_1.text_.text = var_107_4
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381024", "story_v_out_116381.awb") ~= 0 then
					local var_107_8 = manager.audio:GetVoiceLength("story_v_out_116381", "116381024", "story_v_out_116381.awb") / 1000

					if var_107_8 + var_107_0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_8 + var_107_0
					end

					if var_107_3.prefab_name ~= "" and arg_104_1.actors_[var_107_3.prefab_name] ~= nil then
						local var_107_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_3.prefab_name].transform, "story_v_out_116381", "116381024", "story_v_out_116381.awb")

						arg_104_1:RecordAudio("116381024", var_107_9)
						arg_104_1:RecordAudio("116381024", var_107_9)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_116381", "116381024", "story_v_out_116381.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_116381", "116381024", "story_v_out_116381.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_10 = math.max(var_107_1, arg_104_1.talkMaxDuration)

			if var_107_0 <= arg_104_1.time_ and arg_104_1.time_ < var_107_0 + var_107_10 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_0) / var_107_10

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_0 + var_107_10 and arg_104_1.time_ < var_107_0 + var_107_10 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play116381025 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 116381025
		arg_108_1.duration_ = 3.83

		local var_108_0 = {
			zh = 3.2,
			ja = 3.833
		}
		local var_108_1 = manager.audio:GetLocalizationFlag()

		if var_108_0[var_108_1] ~= nil then
			arg_108_1.duration_ = var_108_0[var_108_1]
		end

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play116381026(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 0
			local var_111_1 = 0.35

			if var_111_0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_0 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_2 = arg_108_1:FormatText(StoryNameCfg[337].name)

				arg_108_1.leftNameTxt_.text = var_111_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, true)
				arg_108_1.iconController_:SetSelectedState("hero")

				arg_108_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10046")

				arg_108_1.callingController_:SetSelectedState("normal")

				arg_108_1.keyicon_.color = Color.New(1, 1, 1)
				arg_108_1.icon_.color = Color.New(1, 1, 1)

				local var_111_3 = arg_108_1:GetWordFromCfg(116381025)
				local var_111_4 = arg_108_1:FormatText(var_111_3.content)

				arg_108_1.text_.text = var_111_4

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_5 = 13
				local var_111_6 = utf8.len(var_111_4)
				local var_111_7 = var_111_5 <= 0 and var_111_1 or var_111_1 * (var_111_6 / var_111_5)

				if var_111_7 > 0 and var_111_1 < var_111_7 then
					arg_108_1.talkMaxDuration = var_111_7

					if var_111_7 + var_111_0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_7 + var_111_0
					end
				end

				arg_108_1.text_.text = var_111_4
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381025", "story_v_out_116381.awb") ~= 0 then
					local var_111_8 = manager.audio:GetVoiceLength("story_v_out_116381", "116381025", "story_v_out_116381.awb") / 1000

					if var_111_8 + var_111_0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_8 + var_111_0
					end

					if var_111_3.prefab_name ~= "" and arg_108_1.actors_[var_111_3.prefab_name] ~= nil then
						local var_111_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_3.prefab_name].transform, "story_v_out_116381", "116381025", "story_v_out_116381.awb")

						arg_108_1:RecordAudio("116381025", var_111_9)
						arg_108_1:RecordAudio("116381025", var_111_9)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_116381", "116381025", "story_v_out_116381.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_116381", "116381025", "story_v_out_116381.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_10 = math.max(var_111_1, arg_108_1.talkMaxDuration)

			if var_111_0 <= arg_108_1.time_ and arg_108_1.time_ < var_111_0 + var_111_10 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_0) / var_111_10

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_0 + var_111_10 and arg_108_1.time_ < var_111_0 + var_111_10 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play116381026 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 116381026
		arg_112_1.duration_ = 12.73

		local var_112_0 = {
			zh = 12.733,
			ja = 9.8
		}
		local var_112_1 = manager.audio:GetLocalizationFlag()

		if var_112_0[var_112_1] ~= nil then
			arg_112_1.duration_ = var_112_0[var_112_1]
		end

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play116381027(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = "SK0102"

			if arg_112_1.bgs_[var_115_0] == nil then
				local var_115_1 = Object.Instantiate(arg_112_1.paintGo_)

				var_115_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_115_0)
				var_115_1.name = var_115_0
				var_115_1.transform.parent = arg_112_1.stage_.transform
				var_115_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_112_1.bgs_[var_115_0] = var_115_1
			end

			local var_115_2 = 2

			if var_115_2 < arg_112_1.time_ and arg_112_1.time_ <= var_115_2 + arg_115_0 then
				local var_115_3 = manager.ui.mainCamera.transform.localPosition
				local var_115_4 = Vector3.New(0, 0, 10) + Vector3.New(var_115_3.x, var_115_3.y, 0)
				local var_115_5 = arg_112_1.bgs_.SK0102

				var_115_5.transform.localPosition = var_115_4
				var_115_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_115_6 = var_115_5:GetComponent("SpriteRenderer")

				if var_115_6 and var_115_6.sprite then
					local var_115_7 = (var_115_5.transform.localPosition - var_115_3).z
					local var_115_8 = manager.ui.mainCameraCom_
					local var_115_9 = 2 * var_115_7 * Mathf.Tan(var_115_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_115_10 = var_115_9 * var_115_8.aspect
					local var_115_11 = var_115_6.sprite.bounds.size.x
					local var_115_12 = var_115_6.sprite.bounds.size.y
					local var_115_13 = var_115_10 / var_115_11
					local var_115_14 = var_115_9 / var_115_12
					local var_115_15 = var_115_14 < var_115_13 and var_115_13 or var_115_14

					var_115_5.transform.localScale = Vector3.New(var_115_15, var_115_15, 0)
				end

				for iter_115_0, iter_115_1 in pairs(arg_112_1.bgs_) do
					if iter_115_0 ~= "SK0102" then
						iter_115_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_115_16 = 0

			if var_115_16 < arg_112_1.time_ and arg_112_1.time_ <= var_115_16 + arg_115_0 then
				arg_112_1.mask_.enabled = true
				arg_112_1.mask_.raycastTarget = true

				arg_112_1:SetGaussion(false)
			end

			local var_115_17 = 2

			if var_115_16 <= arg_112_1.time_ and arg_112_1.time_ < var_115_16 + var_115_17 then
				local var_115_18 = (arg_112_1.time_ - var_115_16) / var_115_17
				local var_115_19 = Color.New(0, 0, 0)

				var_115_19.a = Mathf.Lerp(0, 1, var_115_18)
				arg_112_1.mask_.color = var_115_19
			end

			if arg_112_1.time_ >= var_115_16 + var_115_17 and arg_112_1.time_ < var_115_16 + var_115_17 + arg_115_0 then
				local var_115_20 = Color.New(0, 0, 0)

				var_115_20.a = 1
				arg_112_1.mask_.color = var_115_20
			end

			local var_115_21 = 2

			if var_115_21 < arg_112_1.time_ and arg_112_1.time_ <= var_115_21 + arg_115_0 then
				arg_112_1.mask_.enabled = true
				arg_112_1.mask_.raycastTarget = true

				arg_112_1:SetGaussion(false)
			end

			local var_115_22 = 2

			if var_115_21 <= arg_112_1.time_ and arg_112_1.time_ < var_115_21 + var_115_22 then
				local var_115_23 = (arg_112_1.time_ - var_115_21) / var_115_22
				local var_115_24 = Color.New(0, 0, 0)

				var_115_24.a = Mathf.Lerp(1, 0, var_115_23)
				arg_112_1.mask_.color = var_115_24
			end

			if arg_112_1.time_ >= var_115_21 + var_115_22 and arg_112_1.time_ < var_115_21 + var_115_22 + arg_115_0 then
				local var_115_25 = Color.New(0, 0, 0)
				local var_115_26 = 0

				arg_112_1.mask_.enabled = false
				var_115_25.a = var_115_26
				arg_112_1.mask_.color = var_115_25
			end

			if arg_112_1.frameCnt_ <= 1 then
				arg_112_1.dialog_:SetActive(false)
			end

			local var_115_27 = 4
			local var_115_28 = 0.45

			if var_115_27 < arg_112_1.time_ and arg_112_1.time_ <= var_115_27 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0

				arg_112_1.dialog_:SetActive(true)

				arg_112_1.dialogCg_.alpha = 0

				local var_115_29 = LeanTween.value(arg_112_1.dialog_, 0, 1, 0.3)

				var_115_29:setOnUpdate(LuaHelper.FloatAction(function(arg_116_0)
					arg_112_1.dialogCg_.alpha = arg_116_0
				end))
				var_115_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_112_1.dialog_)
					var_115_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_112_1.duration_ = arg_112_1.duration_ + 0.3

				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_30 = arg_112_1:FormatText(StoryNameCfg[328].name)

				arg_112_1.leftNameTxt_.text = var_115_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, true)
				arg_112_1.iconController_:SetSelectedState("hero")

				arg_112_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10032")

				arg_112_1.callingController_:SetSelectedState("normal")

				arg_112_1.keyicon_.color = Color.New(1, 1, 1)
				arg_112_1.icon_.color = Color.New(1, 1, 1)

				local var_115_31 = arg_112_1:GetWordFromCfg(116381026)
				local var_115_32 = arg_112_1:FormatText(var_115_31.content)

				arg_112_1.text_.text = var_115_32

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_33 = 19
				local var_115_34 = utf8.len(var_115_32)
				local var_115_35 = var_115_33 <= 0 and var_115_28 or var_115_28 * (var_115_34 / var_115_33)

				if var_115_35 > 0 and var_115_28 < var_115_35 then
					arg_112_1.talkMaxDuration = var_115_35
					var_115_27 = var_115_27 + 0.3

					if var_115_35 + var_115_27 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_35 + var_115_27
					end
				end

				arg_112_1.text_.text = var_115_32
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381026", "story_v_out_116381.awb") ~= 0 then
					local var_115_36 = manager.audio:GetVoiceLength("story_v_out_116381", "116381026", "story_v_out_116381.awb") / 1000

					if var_115_36 + var_115_27 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_36 + var_115_27
					end

					if var_115_31.prefab_name ~= "" and arg_112_1.actors_[var_115_31.prefab_name] ~= nil then
						local var_115_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_31.prefab_name].transform, "story_v_out_116381", "116381026", "story_v_out_116381.awb")

						arg_112_1:RecordAudio("116381026", var_115_37)
						arg_112_1:RecordAudio("116381026", var_115_37)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_116381", "116381026", "story_v_out_116381.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_116381", "116381026", "story_v_out_116381.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_38 = var_115_27 + 0.3
			local var_115_39 = math.max(var_115_28, arg_112_1.talkMaxDuration)

			if var_115_38 <= arg_112_1.time_ and arg_112_1.time_ < var_115_38 + var_115_39 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_38) / var_115_39

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_38 + var_115_39 and arg_112_1.time_ < var_115_38 + var_115_39 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play116381027 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 116381027
		arg_118_1.duration_ = 2.67

		local var_118_0 = {
			zh = 2.666,
			ja = 1.966
		}
		local var_118_1 = manager.audio:GetLocalizationFlag()

		if var_118_0[var_118_1] ~= nil then
			arg_118_1.duration_ = var_118_0[var_118_1]
		end

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play116381028(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = 0
			local var_121_1 = 0.2

			if var_121_0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_0 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_2 = arg_118_1:FormatText(StoryNameCfg[337].name)

				arg_118_1.leftNameTxt_.text = var_121_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, true)
				arg_118_1.iconController_:SetSelectedState("hero")

				arg_118_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10046")

				arg_118_1.callingController_:SetSelectedState("normal")

				arg_118_1.keyicon_.color = Color.New(1, 1, 1)
				arg_118_1.icon_.color = Color.New(1, 1, 1)

				local var_121_3 = arg_118_1:GetWordFromCfg(116381027)
				local var_121_4 = arg_118_1:FormatText(var_121_3.content)

				arg_118_1.text_.text = var_121_4

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_5 = 9
				local var_121_6 = utf8.len(var_121_4)
				local var_121_7 = var_121_5 <= 0 and var_121_1 or var_121_1 * (var_121_6 / var_121_5)

				if var_121_7 > 0 and var_121_1 < var_121_7 then
					arg_118_1.talkMaxDuration = var_121_7

					if var_121_7 + var_121_0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_7 + var_121_0
					end
				end

				arg_118_1.text_.text = var_121_4
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381027", "story_v_out_116381.awb") ~= 0 then
					local var_121_8 = manager.audio:GetVoiceLength("story_v_out_116381", "116381027", "story_v_out_116381.awb") / 1000

					if var_121_8 + var_121_0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_8 + var_121_0
					end

					if var_121_3.prefab_name ~= "" and arg_118_1.actors_[var_121_3.prefab_name] ~= nil then
						local var_121_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_3.prefab_name].transform, "story_v_out_116381", "116381027", "story_v_out_116381.awb")

						arg_118_1:RecordAudio("116381027", var_121_9)
						arg_118_1:RecordAudio("116381027", var_121_9)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_116381", "116381027", "story_v_out_116381.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_116381", "116381027", "story_v_out_116381.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_10 = math.max(var_121_1, arg_118_1.talkMaxDuration)

			if var_121_0 <= arg_118_1.time_ and arg_118_1.time_ < var_121_0 + var_121_10 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_0) / var_121_10

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_0 + var_121_10 and arg_118_1.time_ < var_121_0 + var_121_10 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play116381028 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 116381028
		arg_122_1.duration_ = 4.57

		local var_122_0 = {
			zh = 4.566,
			ja = 4.233
		}
		local var_122_1 = manager.audio:GetLocalizationFlag()

		if var_122_0[var_122_1] ~= nil then
			arg_122_1.duration_ = var_122_0[var_122_1]
		end

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play116381029(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = 0
			local var_125_1 = 0.175

			if var_125_0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_0 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_2 = arg_122_1:FormatText(StoryNameCfg[328].name)

				arg_122_1.leftNameTxt_.text = var_125_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, true)
				arg_122_1.iconController_:SetSelectedState("hero")

				arg_122_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10032")

				arg_122_1.callingController_:SetSelectedState("normal")

				arg_122_1.keyicon_.color = Color.New(1, 1, 1)
				arg_122_1.icon_.color = Color.New(1, 1, 1)

				local var_125_3 = arg_122_1:GetWordFromCfg(116381028)
				local var_125_4 = arg_122_1:FormatText(var_125_3.content)

				arg_122_1.text_.text = var_125_4

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_5 = 7
				local var_125_6 = utf8.len(var_125_4)
				local var_125_7 = var_125_5 <= 0 and var_125_1 or var_125_1 * (var_125_6 / var_125_5)

				if var_125_7 > 0 and var_125_1 < var_125_7 then
					arg_122_1.talkMaxDuration = var_125_7

					if var_125_7 + var_125_0 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_7 + var_125_0
					end
				end

				arg_122_1.text_.text = var_125_4
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381028", "story_v_out_116381.awb") ~= 0 then
					local var_125_8 = manager.audio:GetVoiceLength("story_v_out_116381", "116381028", "story_v_out_116381.awb") / 1000

					if var_125_8 + var_125_0 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_8 + var_125_0
					end

					if var_125_3.prefab_name ~= "" and arg_122_1.actors_[var_125_3.prefab_name] ~= nil then
						local var_125_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_3.prefab_name].transform, "story_v_out_116381", "116381028", "story_v_out_116381.awb")

						arg_122_1:RecordAudio("116381028", var_125_9)
						arg_122_1:RecordAudio("116381028", var_125_9)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_116381", "116381028", "story_v_out_116381.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_116381", "116381028", "story_v_out_116381.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_10 = math.max(var_125_1, arg_122_1.talkMaxDuration)

			if var_125_0 <= arg_122_1.time_ and arg_122_1.time_ < var_125_0 + var_125_10 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_0) / var_125_10

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_0 + var_125_10 and arg_122_1.time_ < var_125_0 + var_125_10 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play116381029 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 116381029
		arg_126_1.duration_ = 11.1

		local var_126_0 = {
			zh = 9.733,
			ja = 11.1
		}
		local var_126_1 = manager.audio:GetLocalizationFlag()

		if var_126_0[var_126_1] ~= nil then
			arg_126_1.duration_ = var_126_0[var_126_1]
		end

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play116381030(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = "I05f"

			if arg_126_1.bgs_[var_129_0] == nil then
				local var_129_1 = Object.Instantiate(arg_126_1.paintGo_)

				var_129_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_129_0)
				var_129_1.name = var_129_0
				var_129_1.transform.parent = arg_126_1.stage_.transform
				var_129_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_126_1.bgs_[var_129_0] = var_129_1
			end

			local var_129_2 = 2

			if var_129_2 < arg_126_1.time_ and arg_126_1.time_ <= var_129_2 + arg_129_0 then
				local var_129_3 = manager.ui.mainCamera.transform.localPosition
				local var_129_4 = Vector3.New(0, 0, 10) + Vector3.New(var_129_3.x, var_129_3.y, 0)
				local var_129_5 = arg_126_1.bgs_.I05f

				var_129_5.transform.localPosition = var_129_4
				var_129_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_129_6 = var_129_5:GetComponent("SpriteRenderer")

				if var_129_6 and var_129_6.sprite then
					local var_129_7 = (var_129_5.transform.localPosition - var_129_3).z
					local var_129_8 = manager.ui.mainCameraCom_
					local var_129_9 = 2 * var_129_7 * Mathf.Tan(var_129_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_129_10 = var_129_9 * var_129_8.aspect
					local var_129_11 = var_129_6.sprite.bounds.size.x
					local var_129_12 = var_129_6.sprite.bounds.size.y
					local var_129_13 = var_129_10 / var_129_11
					local var_129_14 = var_129_9 / var_129_12
					local var_129_15 = var_129_14 < var_129_13 and var_129_13 or var_129_14

					var_129_5.transform.localScale = Vector3.New(var_129_15, var_129_15, 0)
				end

				for iter_129_0, iter_129_1 in pairs(arg_126_1.bgs_) do
					if iter_129_0 ~= "I05f" then
						iter_129_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_129_16 = 0

			if var_129_16 < arg_126_1.time_ and arg_126_1.time_ <= var_129_16 + arg_129_0 then
				arg_126_1.mask_.enabled = true
				arg_126_1.mask_.raycastTarget = true

				arg_126_1:SetGaussion(false)
			end

			local var_129_17 = 2

			if var_129_16 <= arg_126_1.time_ and arg_126_1.time_ < var_129_16 + var_129_17 then
				local var_129_18 = (arg_126_1.time_ - var_129_16) / var_129_17
				local var_129_19 = Color.New(0, 0, 0)

				var_129_19.a = Mathf.Lerp(0, 1, var_129_18)
				arg_126_1.mask_.color = var_129_19
			end

			if arg_126_1.time_ >= var_129_16 + var_129_17 and arg_126_1.time_ < var_129_16 + var_129_17 + arg_129_0 then
				local var_129_20 = Color.New(0, 0, 0)

				var_129_20.a = 1
				arg_126_1.mask_.color = var_129_20
			end

			local var_129_21 = 2

			if var_129_21 < arg_126_1.time_ and arg_126_1.time_ <= var_129_21 + arg_129_0 then
				arg_126_1.mask_.enabled = true
				arg_126_1.mask_.raycastTarget = true

				arg_126_1:SetGaussion(false)
			end

			local var_129_22 = 2

			if var_129_21 <= arg_126_1.time_ and arg_126_1.time_ < var_129_21 + var_129_22 then
				local var_129_23 = (arg_126_1.time_ - var_129_21) / var_129_22
				local var_129_24 = Color.New(0, 0, 0)

				var_129_24.a = Mathf.Lerp(1, 0, var_129_23)
				arg_126_1.mask_.color = var_129_24
			end

			if arg_126_1.time_ >= var_129_21 + var_129_22 and arg_126_1.time_ < var_129_21 + var_129_22 + arg_129_0 then
				local var_129_25 = Color.New(0, 0, 0)
				local var_129_26 = 0

				arg_126_1.mask_.enabled = false
				var_129_25.a = var_129_26
				arg_126_1.mask_.color = var_129_25
			end

			local var_129_27 = "10024ui_story"

			if arg_126_1.actors_[var_129_27] == nil then
				local var_129_28 = Asset.Load("Char/" .. "10024ui_story")

				if not isNil(var_129_28) then
					local var_129_29 = Object.Instantiate(Asset.Load("Char/" .. "10024ui_story"), arg_126_1.stage_.transform)

					var_129_29.name = var_129_27
					var_129_29.transform.localPosition = Vector3.New(0, 100, 0)
					arg_126_1.actors_[var_129_27] = var_129_29

					local var_129_30 = var_129_29:GetComponentInChildren(typeof(CharacterEffect))

					var_129_30.enabled = true

					local var_129_31 = GameObjectTools.GetOrAddComponent(var_129_29, typeof(DynamicBoneHelper))

					if var_129_31 then
						var_129_31:EnableDynamicBone(false)
					end

					arg_126_1:ShowWeapon(var_129_30.transform, false)

					arg_126_1.var_[var_129_27 .. "Animator"] = var_129_30.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_126_1.var_[var_129_27 .. "Animator"].applyRootMotion = true
					arg_126_1.var_[var_129_27 .. "LipSync"] = var_129_30.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_129_32 = 4

			if var_129_32 < arg_126_1.time_ and arg_126_1.time_ <= var_129_32 + arg_129_0 then
				arg_126_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/story10024/story10024action/10024action1_1")
			end

			local var_129_33 = 4

			if var_129_33 < arg_126_1.time_ and arg_126_1.time_ <= var_129_33 + arg_129_0 then
				arg_126_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_129_34 = arg_126_1.actors_["10024ui_story"]
			local var_129_35 = 4

			if var_129_35 < arg_126_1.time_ and arg_126_1.time_ <= var_129_35 + arg_129_0 and not isNil(var_129_34) and arg_126_1.var_.characterEffect10024ui_story == nil then
				arg_126_1.var_.characterEffect10024ui_story = var_129_34:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_36 = 0.2

			if var_129_35 <= arg_126_1.time_ and arg_126_1.time_ < var_129_35 + var_129_36 and not isNil(var_129_34) then
				local var_129_37 = (arg_126_1.time_ - var_129_35) / var_129_36

				if arg_126_1.var_.characterEffect10024ui_story and not isNil(var_129_34) then
					arg_126_1.var_.characterEffect10024ui_story.fillFlat = false
				end
			end

			if arg_126_1.time_ >= var_129_35 + var_129_36 and arg_126_1.time_ < var_129_35 + var_129_36 + arg_129_0 and not isNil(var_129_34) and arg_126_1.var_.characterEffect10024ui_story then
				arg_126_1.var_.characterEffect10024ui_story.fillFlat = false
			end

			local var_129_38 = "10025ui_story"

			if arg_126_1.actors_[var_129_38] == nil then
				local var_129_39 = Asset.Load("Char/" .. "10025ui_story")

				if not isNil(var_129_39) then
					local var_129_40 = Object.Instantiate(Asset.Load("Char/" .. "10025ui_story"), arg_126_1.stage_.transform)

					var_129_40.name = var_129_38
					var_129_40.transform.localPosition = Vector3.New(0, 100, 0)
					arg_126_1.actors_[var_129_38] = var_129_40

					local var_129_41 = var_129_40:GetComponentInChildren(typeof(CharacterEffect))

					var_129_41.enabled = true

					local var_129_42 = GameObjectTools.GetOrAddComponent(var_129_40, typeof(DynamicBoneHelper))

					if var_129_42 then
						var_129_42:EnableDynamicBone(false)
					end

					arg_126_1:ShowWeapon(var_129_41.transform, false)

					arg_126_1.var_[var_129_38 .. "Animator"] = var_129_41.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_126_1.var_[var_129_38 .. "Animator"].applyRootMotion = true
					arg_126_1.var_[var_129_38 .. "LipSync"] = var_129_41.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_129_43 = arg_126_1.actors_["10025ui_story"]
			local var_129_44 = 2

			if var_129_44 < arg_126_1.time_ and arg_126_1.time_ <= var_129_44 + arg_129_0 and not isNil(var_129_43) and arg_126_1.var_.characterEffect10025ui_story == nil then
				arg_126_1.var_.characterEffect10025ui_story = var_129_43:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_45 = 0.2

			if var_129_44 <= arg_126_1.time_ and arg_126_1.time_ < var_129_44 + var_129_45 and not isNil(var_129_43) then
				local var_129_46 = (arg_126_1.time_ - var_129_44) / var_129_45

				if arg_126_1.var_.characterEffect10025ui_story and not isNil(var_129_43) then
					local var_129_47 = Mathf.Lerp(0, 0.5, var_129_46)

					arg_126_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_126_1.var_.characterEffect10025ui_story.fillRatio = var_129_47
				end
			end

			if arg_126_1.time_ >= var_129_44 + var_129_45 and arg_126_1.time_ < var_129_44 + var_129_45 + arg_129_0 and not isNil(var_129_43) and arg_126_1.var_.characterEffect10025ui_story then
				local var_129_48 = 0.5

				arg_126_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_126_1.var_.characterEffect10025ui_story.fillRatio = var_129_48
			end

			local var_129_49 = arg_126_1.actors_["10024ui_story"].transform
			local var_129_50 = 4

			if var_129_50 < arg_126_1.time_ and arg_126_1.time_ <= var_129_50 + arg_129_0 then
				arg_126_1.var_.moveOldPos10024ui_story = var_129_49.localPosition
			end

			local var_129_51 = 0.001

			if var_129_50 <= arg_126_1.time_ and arg_126_1.time_ < var_129_50 + var_129_51 then
				local var_129_52 = (arg_126_1.time_ - var_129_50) / var_129_51
				local var_129_53 = Vector3.New(-0.7, -1, -6)

				var_129_49.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos10024ui_story, var_129_53, var_129_52)

				local var_129_54 = manager.ui.mainCamera.transform.position - var_129_49.position

				var_129_49.forward = Vector3.New(var_129_54.x, var_129_54.y, var_129_54.z)

				local var_129_55 = var_129_49.localEulerAngles

				var_129_55.z = 0
				var_129_55.x = 0
				var_129_49.localEulerAngles = var_129_55
			end

			if arg_126_1.time_ >= var_129_50 + var_129_51 and arg_126_1.time_ < var_129_50 + var_129_51 + arg_129_0 then
				var_129_49.localPosition = Vector3.New(-0.7, -1, -6)

				local var_129_56 = manager.ui.mainCamera.transform.position - var_129_49.position

				var_129_49.forward = Vector3.New(var_129_56.x, var_129_56.y, var_129_56.z)

				local var_129_57 = var_129_49.localEulerAngles

				var_129_57.z = 0
				var_129_57.x = 0
				var_129_49.localEulerAngles = var_129_57
			end

			local var_129_58 = arg_126_1.actors_["10025ui_story"].transform
			local var_129_59 = 4

			if var_129_59 < arg_126_1.time_ and arg_126_1.time_ <= var_129_59 + arg_129_0 then
				arg_126_1.var_.moveOldPos10025ui_story = var_129_58.localPosition
			end

			local var_129_60 = 0.001

			if var_129_59 <= arg_126_1.time_ and arg_126_1.time_ < var_129_59 + var_129_60 then
				local var_129_61 = (arg_126_1.time_ - var_129_59) / var_129_60
				local var_129_62 = Vector3.New(0.7, -1.1, -5.9)

				var_129_58.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos10025ui_story, var_129_62, var_129_61)

				local var_129_63 = manager.ui.mainCamera.transform.position - var_129_58.position

				var_129_58.forward = Vector3.New(var_129_63.x, var_129_63.y, var_129_63.z)

				local var_129_64 = var_129_58.localEulerAngles

				var_129_64.z = 0
				var_129_64.x = 0
				var_129_58.localEulerAngles = var_129_64
			end

			if arg_126_1.time_ >= var_129_59 + var_129_60 and arg_126_1.time_ < var_129_59 + var_129_60 + arg_129_0 then
				var_129_58.localPosition = Vector3.New(0.7, -1.1, -5.9)

				local var_129_65 = manager.ui.mainCamera.transform.position - var_129_58.position

				var_129_58.forward = Vector3.New(var_129_65.x, var_129_65.y, var_129_65.z)

				local var_129_66 = var_129_58.localEulerAngles

				var_129_66.z = 0
				var_129_66.x = 0
				var_129_58.localEulerAngles = var_129_66
			end

			local var_129_67 = 0
			local var_129_68 = 0.266666666666667

			if var_129_67 < arg_126_1.time_ and arg_126_1.time_ <= var_129_67 + arg_129_0 then
				local var_129_69 = "play"
				local var_129_70 = "music"

				arg_126_1:AudioAction(var_129_69, var_129_70, "ui_battle", "ui_battle_stopbgm", "")

				local var_129_71 = ""
				local var_129_72 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_129_72 ~= "" then
					if arg_126_1.bgmTxt_.text ~= var_129_72 and arg_126_1.bgmTxt_.text ~= "" then
						if arg_126_1.bgmTxt2_.text ~= "" then
							arg_126_1.bgmTxt_.text = arg_126_1.bgmTxt2_.text
						end

						arg_126_1.bgmTxt2_.text = var_129_72

						arg_126_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_126_1.bgmTxt_.text = var_129_72
						arg_126_1.bgmTxt2_.text = var_129_72
					end

					if arg_126_1.bgmTimer then
						arg_126_1.bgmTimer:Stop()

						arg_126_1.bgmTimer = nil
					end

					if arg_126_1.settingData.show_music_name == 1 then
						arg_126_1.musicController:SetSelectedState("show")
						arg_126_1.musicAnimator_:Play("open", 0, 0)

						if arg_126_1.settingData.music_time ~= 0 then
							arg_126_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_126_1.settingData.music_time), function()
								if arg_126_1 == nil or isNil(arg_126_1.bgmTxt_) then
									return
								end

								arg_126_1.musicController:SetSelectedState("hide")
								arg_126_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_129_73 = 0.4
			local var_129_74 = 0.6

			if var_129_73 < arg_126_1.time_ and arg_126_1.time_ <= var_129_73 + arg_129_0 then
				local var_129_75 = "play"
				local var_129_76 = "music"

				arg_126_1:AudioAction(var_129_75, var_129_76, "bgm_story_scheme", "bgm_story_scheme", "bgm_story_scheme.awb")

				local var_129_77 = ""
				local var_129_78 = manager.audio:GetAudioName("bgm_story_scheme", "bgm_story_scheme")

				if var_129_78 ~= "" then
					if arg_126_1.bgmTxt_.text ~= var_129_78 and arg_126_1.bgmTxt_.text ~= "" then
						if arg_126_1.bgmTxt2_.text ~= "" then
							arg_126_1.bgmTxt_.text = arg_126_1.bgmTxt2_.text
						end

						arg_126_1.bgmTxt2_.text = var_129_78

						arg_126_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_126_1.bgmTxt_.text = var_129_78
						arg_126_1.bgmTxt2_.text = var_129_78
					end

					if arg_126_1.bgmTimer then
						arg_126_1.bgmTimer:Stop()

						arg_126_1.bgmTimer = nil
					end

					if arg_126_1.settingData.show_music_name == 1 then
						arg_126_1.musicController:SetSelectedState("show")
						arg_126_1.musicAnimator_:Play("open", 0, 0)

						if arg_126_1.settingData.music_time ~= 0 then
							arg_126_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_126_1.settingData.music_time), function()
								if arg_126_1 == nil or isNil(arg_126_1.bgmTxt_) then
									return
								end

								arg_126_1.musicController:SetSelectedState("hide")
								arg_126_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_126_1.frameCnt_ <= 1 then
				arg_126_1.dialog_:SetActive(false)
			end

			local var_129_79 = 4
			local var_129_80 = 0.55

			if var_129_79 < arg_126_1.time_ and arg_126_1.time_ <= var_129_79 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0

				arg_126_1.dialog_:SetActive(true)

				arg_126_1.dialogCg_.alpha = 0

				local var_129_81 = LeanTween.value(arg_126_1.dialog_, 0, 1, 0.3)

				var_129_81:setOnUpdate(LuaHelper.FloatAction(function(arg_132_0)
					arg_126_1.dialogCg_.alpha = arg_132_0
				end))
				var_129_81:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_126_1.dialog_)
					var_129_81:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_126_1.duration_ = arg_126_1.duration_ + 0.3

				SetActive(arg_126_1.leftNameGo_, true)

				local var_129_82 = arg_126_1:FormatText(StoryNameCfg[332].name)

				arg_126_1.leftNameTxt_.text = var_129_82

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_83 = arg_126_1:GetWordFromCfg(116381029)
				local var_129_84 = arg_126_1:FormatText(var_129_83.content)

				arg_126_1.text_.text = var_129_84

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_85 = 22
				local var_129_86 = utf8.len(var_129_84)
				local var_129_87 = var_129_85 <= 0 and var_129_80 or var_129_80 * (var_129_86 / var_129_85)

				if var_129_87 > 0 and var_129_80 < var_129_87 then
					arg_126_1.talkMaxDuration = var_129_87
					var_129_79 = var_129_79 + 0.3

					if var_129_87 + var_129_79 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_87 + var_129_79
					end
				end

				arg_126_1.text_.text = var_129_84
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381029", "story_v_out_116381.awb") ~= 0 then
					local var_129_88 = manager.audio:GetVoiceLength("story_v_out_116381", "116381029", "story_v_out_116381.awb") / 1000

					if var_129_88 + var_129_79 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_88 + var_129_79
					end

					if var_129_83.prefab_name ~= "" and arg_126_1.actors_[var_129_83.prefab_name] ~= nil then
						local var_129_89 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_83.prefab_name].transform, "story_v_out_116381", "116381029", "story_v_out_116381.awb")

						arg_126_1:RecordAudio("116381029", var_129_89)
						arg_126_1:RecordAudio("116381029", var_129_89)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_116381", "116381029", "story_v_out_116381.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_116381", "116381029", "story_v_out_116381.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_90 = var_129_79 + 0.3
			local var_129_91 = math.max(var_129_80, arg_126_1.talkMaxDuration)

			if var_129_90 <= arg_126_1.time_ and arg_126_1.time_ < var_129_90 + var_129_91 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_90) / var_129_91

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_90 + var_129_91 and arg_126_1.time_ < var_129_90 + var_129_91 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_126_1:InitPlayNodeList()
	end,
	Play116381030 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 116381030
		arg_134_1.duration_ = 4.07

		local var_134_0 = {
			zh = 4.066,
			ja = 3.433
		}
		local var_134_1 = manager.audio:GetLocalizationFlag()

		if var_134_0[var_134_1] ~= nil then
			arg_134_1.duration_ = var_134_0[var_134_1]
		end

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play116381031(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = 0

			if var_137_0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_0 + arg_137_0 then
				arg_134_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/story10024/story10024action/10024action1_1")
			end

			local var_137_1 = 0

			if var_137_1 < arg_134_1.time_ and arg_134_1.time_ <= var_137_1 + arg_137_0 then
				arg_134_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_137_2 = arg_134_1.actors_["10024ui_story"].transform
			local var_137_3 = 0

			if var_137_3 < arg_134_1.time_ and arg_134_1.time_ <= var_137_3 + arg_137_0 then
				arg_134_1.var_.moveOldPos10024ui_story = var_137_2.localPosition
			end

			local var_137_4 = 0.001

			if var_137_3 <= arg_134_1.time_ and arg_134_1.time_ < var_137_3 + var_137_4 then
				local var_137_5 = (arg_134_1.time_ - var_137_3) / var_137_4
				local var_137_6 = Vector3.New(-0.7, -1, -6)

				var_137_2.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos10024ui_story, var_137_6, var_137_5)

				local var_137_7 = manager.ui.mainCamera.transform.position - var_137_2.position

				var_137_2.forward = Vector3.New(var_137_7.x, var_137_7.y, var_137_7.z)

				local var_137_8 = var_137_2.localEulerAngles

				var_137_8.z = 0
				var_137_8.x = 0
				var_137_2.localEulerAngles = var_137_8
			end

			if arg_134_1.time_ >= var_137_3 + var_137_4 and arg_134_1.time_ < var_137_3 + var_137_4 + arg_137_0 then
				var_137_2.localPosition = Vector3.New(-0.7, -1, -6)

				local var_137_9 = manager.ui.mainCamera.transform.position - var_137_2.position

				var_137_2.forward = Vector3.New(var_137_9.x, var_137_9.y, var_137_9.z)

				local var_137_10 = var_137_2.localEulerAngles

				var_137_10.z = 0
				var_137_10.x = 0
				var_137_2.localEulerAngles = var_137_10
			end

			local var_137_11 = arg_134_1.actors_["10025ui_story"].transform
			local var_137_12 = 0

			if var_137_12 < arg_134_1.time_ and arg_134_1.time_ <= var_137_12 + arg_137_0 then
				arg_134_1.var_.moveOldPos10025ui_story = var_137_11.localPosition
			end

			local var_137_13 = 0.001

			if var_137_12 <= arg_134_1.time_ and arg_134_1.time_ < var_137_12 + var_137_13 then
				local var_137_14 = (arg_134_1.time_ - var_137_12) / var_137_13
				local var_137_15 = Vector3.New(0.7, -1.1, -5.9)

				var_137_11.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos10025ui_story, var_137_15, var_137_14)

				local var_137_16 = manager.ui.mainCamera.transform.position - var_137_11.position

				var_137_11.forward = Vector3.New(var_137_16.x, var_137_16.y, var_137_16.z)

				local var_137_17 = var_137_11.localEulerAngles

				var_137_17.z = 0
				var_137_17.x = 0
				var_137_11.localEulerAngles = var_137_17
			end

			if arg_134_1.time_ >= var_137_12 + var_137_13 and arg_134_1.time_ < var_137_12 + var_137_13 + arg_137_0 then
				var_137_11.localPosition = Vector3.New(0.7, -1.1, -5.9)

				local var_137_18 = manager.ui.mainCamera.transform.position - var_137_11.position

				var_137_11.forward = Vector3.New(var_137_18.x, var_137_18.y, var_137_18.z)

				local var_137_19 = var_137_11.localEulerAngles

				var_137_19.z = 0
				var_137_19.x = 0
				var_137_11.localEulerAngles = var_137_19
			end

			local var_137_20 = 0
			local var_137_21 = 0.45

			if var_137_20 < arg_134_1.time_ and arg_134_1.time_ <= var_137_20 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				local var_137_22 = arg_134_1:FormatText(StoryNameCfg[332].name)

				arg_134_1.leftNameTxt_.text = var_137_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_23 = arg_134_1:GetWordFromCfg(116381030)
				local var_137_24 = arg_134_1:FormatText(var_137_23.content)

				arg_134_1.text_.text = var_137_24

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_25 = 18
				local var_137_26 = utf8.len(var_137_24)
				local var_137_27 = var_137_25 <= 0 and var_137_21 or var_137_21 * (var_137_26 / var_137_25)

				if var_137_27 > 0 and var_137_21 < var_137_27 then
					arg_134_1.talkMaxDuration = var_137_27

					if var_137_27 + var_137_20 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_27 + var_137_20
					end
				end

				arg_134_1.text_.text = var_137_24
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381030", "story_v_out_116381.awb") ~= 0 then
					local var_137_28 = manager.audio:GetVoiceLength("story_v_out_116381", "116381030", "story_v_out_116381.awb") / 1000

					if var_137_28 + var_137_20 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_28 + var_137_20
					end

					if var_137_23.prefab_name ~= "" and arg_134_1.actors_[var_137_23.prefab_name] ~= nil then
						local var_137_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_23.prefab_name].transform, "story_v_out_116381", "116381030", "story_v_out_116381.awb")

						arg_134_1:RecordAudio("116381030", var_137_29)
						arg_134_1:RecordAudio("116381030", var_137_29)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_116381", "116381030", "story_v_out_116381.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_116381", "116381030", "story_v_out_116381.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_30 = math.max(var_137_21, arg_134_1.talkMaxDuration)

			if var_137_20 <= arg_134_1.time_ and arg_134_1.time_ < var_137_20 + var_137_30 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_20) / var_137_30

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_20 + var_137_30 and arg_134_1.time_ < var_137_20 + var_137_30 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_134_1:InitPlayNodeList()
	end,
	Play116381031 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 116381031
		arg_138_1.duration_ = 4.33

		local var_138_0 = {
			zh = 4.333,
			ja = 2.866
		}
		local var_138_1 = manager.audio:GetLocalizationFlag()

		if var_138_0[var_138_1] ~= nil then
			arg_138_1.duration_ = var_138_0[var_138_1]
		end

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play116381032(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = 0

			if var_141_0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_0 + arg_141_0 then
				arg_138_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action4_1")
			end

			local var_141_1 = 0

			if var_141_1 < arg_138_1.time_ and arg_138_1.time_ <= var_141_1 + arg_141_0 then
				arg_138_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_141_2 = arg_138_1.actors_["10025ui_story"]
			local var_141_3 = 0

			if var_141_3 < arg_138_1.time_ and arg_138_1.time_ <= var_141_3 + arg_141_0 and not isNil(var_141_2) and arg_138_1.var_.characterEffect10025ui_story == nil then
				arg_138_1.var_.characterEffect10025ui_story = var_141_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_4 = 0.2

			if var_141_3 <= arg_138_1.time_ and arg_138_1.time_ < var_141_3 + var_141_4 and not isNil(var_141_2) then
				local var_141_5 = (arg_138_1.time_ - var_141_3) / var_141_4

				if arg_138_1.var_.characterEffect10025ui_story and not isNil(var_141_2) then
					arg_138_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_138_1.time_ >= var_141_3 + var_141_4 and arg_138_1.time_ < var_141_3 + var_141_4 + arg_141_0 and not isNil(var_141_2) and arg_138_1.var_.characterEffect10025ui_story then
				arg_138_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_141_6 = arg_138_1.actors_["10024ui_story"]
			local var_141_7 = 0

			if var_141_7 < arg_138_1.time_ and arg_138_1.time_ <= var_141_7 + arg_141_0 and not isNil(var_141_6) and arg_138_1.var_.characterEffect10024ui_story == nil then
				arg_138_1.var_.characterEffect10024ui_story = var_141_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_8 = 0.2

			if var_141_7 <= arg_138_1.time_ and arg_138_1.time_ < var_141_7 + var_141_8 and not isNil(var_141_6) then
				local var_141_9 = (arg_138_1.time_ - var_141_7) / var_141_8

				if arg_138_1.var_.characterEffect10024ui_story and not isNil(var_141_6) then
					local var_141_10 = Mathf.Lerp(0, 0.5, var_141_9)

					arg_138_1.var_.characterEffect10024ui_story.fillFlat = true
					arg_138_1.var_.characterEffect10024ui_story.fillRatio = var_141_10
				end
			end

			if arg_138_1.time_ >= var_141_7 + var_141_8 and arg_138_1.time_ < var_141_7 + var_141_8 + arg_141_0 and not isNil(var_141_6) and arg_138_1.var_.characterEffect10024ui_story then
				local var_141_11 = 0.5

				arg_138_1.var_.characterEffect10024ui_story.fillFlat = true
				arg_138_1.var_.characterEffect10024ui_story.fillRatio = var_141_11
			end

			local var_141_12 = 0
			local var_141_13 = 0.25

			if var_141_12 < arg_138_1.time_ and arg_138_1.time_ <= var_141_12 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				local var_141_14 = arg_138_1:FormatText(StoryNameCfg[328].name)

				arg_138_1.leftNameTxt_.text = var_141_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_15 = arg_138_1:GetWordFromCfg(116381031)
				local var_141_16 = arg_138_1:FormatText(var_141_15.content)

				arg_138_1.text_.text = var_141_16

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_17 = 11
				local var_141_18 = utf8.len(var_141_16)
				local var_141_19 = var_141_17 <= 0 and var_141_13 or var_141_13 * (var_141_18 / var_141_17)

				if var_141_19 > 0 and var_141_13 < var_141_19 then
					arg_138_1.talkMaxDuration = var_141_19

					if var_141_19 + var_141_12 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_19 + var_141_12
					end
				end

				arg_138_1.text_.text = var_141_16
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381031", "story_v_out_116381.awb") ~= 0 then
					local var_141_20 = manager.audio:GetVoiceLength("story_v_out_116381", "116381031", "story_v_out_116381.awb") / 1000

					if var_141_20 + var_141_12 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_20 + var_141_12
					end

					if var_141_15.prefab_name ~= "" and arg_138_1.actors_[var_141_15.prefab_name] ~= nil then
						local var_141_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_15.prefab_name].transform, "story_v_out_116381", "116381031", "story_v_out_116381.awb")

						arg_138_1:RecordAudio("116381031", var_141_21)
						arg_138_1:RecordAudio("116381031", var_141_21)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_116381", "116381031", "story_v_out_116381.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_116381", "116381031", "story_v_out_116381.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_22 = math.max(var_141_13, arg_138_1.talkMaxDuration)

			if var_141_12 <= arg_138_1.time_ and arg_138_1.time_ < var_141_12 + var_141_22 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_12) / var_141_22

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_12 + var_141_22 and arg_138_1.time_ < var_141_12 + var_141_22 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play116381032 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 116381032
		arg_142_1.duration_ = 6.77

		local var_142_0 = {
			zh = 6.766,
			ja = 4.033
		}
		local var_142_1 = manager.audio:GetLocalizationFlag()

		if var_142_0[var_142_1] ~= nil then
			arg_142_1.duration_ = var_142_0[var_142_1]
		end

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play116381033(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = 0

			if var_145_0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_0 + arg_145_0 then
				arg_142_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/story10024/story10024action/10024action1_1")
			end

			local var_145_1 = 0

			if var_145_1 < arg_142_1.time_ and arg_142_1.time_ <= var_145_1 + arg_145_0 then
				arg_142_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_145_2 = arg_142_1.actors_["10024ui_story"]
			local var_145_3 = 0

			if var_145_3 < arg_142_1.time_ and arg_142_1.time_ <= var_145_3 + arg_145_0 and not isNil(var_145_2) and arg_142_1.var_.characterEffect10024ui_story == nil then
				arg_142_1.var_.characterEffect10024ui_story = var_145_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_4 = 0.2

			if var_145_3 <= arg_142_1.time_ and arg_142_1.time_ < var_145_3 + var_145_4 and not isNil(var_145_2) then
				local var_145_5 = (arg_142_1.time_ - var_145_3) / var_145_4

				if arg_142_1.var_.characterEffect10024ui_story and not isNil(var_145_2) then
					arg_142_1.var_.characterEffect10024ui_story.fillFlat = false
				end
			end

			if arg_142_1.time_ >= var_145_3 + var_145_4 and arg_142_1.time_ < var_145_3 + var_145_4 + arg_145_0 and not isNil(var_145_2) and arg_142_1.var_.characterEffect10024ui_story then
				arg_142_1.var_.characterEffect10024ui_story.fillFlat = false
			end

			local var_145_6 = arg_142_1.actors_["10025ui_story"]
			local var_145_7 = 0

			if var_145_7 < arg_142_1.time_ and arg_142_1.time_ <= var_145_7 + arg_145_0 and not isNil(var_145_6) and arg_142_1.var_.characterEffect10025ui_story == nil then
				arg_142_1.var_.characterEffect10025ui_story = var_145_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_8 = 0.2

			if var_145_7 <= arg_142_1.time_ and arg_142_1.time_ < var_145_7 + var_145_8 and not isNil(var_145_6) then
				local var_145_9 = (arg_142_1.time_ - var_145_7) / var_145_8

				if arg_142_1.var_.characterEffect10025ui_story and not isNil(var_145_6) then
					local var_145_10 = Mathf.Lerp(0, 0.5, var_145_9)

					arg_142_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_142_1.var_.characterEffect10025ui_story.fillRatio = var_145_10
				end
			end

			if arg_142_1.time_ >= var_145_7 + var_145_8 and arg_142_1.time_ < var_145_7 + var_145_8 + arg_145_0 and not isNil(var_145_6) and arg_142_1.var_.characterEffect10025ui_story then
				local var_145_11 = 0.5

				arg_142_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_142_1.var_.characterEffect10025ui_story.fillRatio = var_145_11
			end

			local var_145_12 = 0
			local var_145_13 = 0.525

			if var_145_12 < arg_142_1.time_ and arg_142_1.time_ <= var_145_12 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				local var_145_14 = arg_142_1:FormatText(StoryNameCfg[332].name)

				arg_142_1.leftNameTxt_.text = var_145_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_15 = arg_142_1:GetWordFromCfg(116381032)
				local var_145_16 = arg_142_1:FormatText(var_145_15.content)

				arg_142_1.text_.text = var_145_16

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_17 = 21
				local var_145_18 = utf8.len(var_145_16)
				local var_145_19 = var_145_17 <= 0 and var_145_13 or var_145_13 * (var_145_18 / var_145_17)

				if var_145_19 > 0 and var_145_13 < var_145_19 then
					arg_142_1.talkMaxDuration = var_145_19

					if var_145_19 + var_145_12 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_19 + var_145_12
					end
				end

				arg_142_1.text_.text = var_145_16
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381032", "story_v_out_116381.awb") ~= 0 then
					local var_145_20 = manager.audio:GetVoiceLength("story_v_out_116381", "116381032", "story_v_out_116381.awb") / 1000

					if var_145_20 + var_145_12 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_20 + var_145_12
					end

					if var_145_15.prefab_name ~= "" and arg_142_1.actors_[var_145_15.prefab_name] ~= nil then
						local var_145_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_15.prefab_name].transform, "story_v_out_116381", "116381032", "story_v_out_116381.awb")

						arg_142_1:RecordAudio("116381032", var_145_21)
						arg_142_1:RecordAudio("116381032", var_145_21)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_116381", "116381032", "story_v_out_116381.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_116381", "116381032", "story_v_out_116381.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_22 = math.max(var_145_13, arg_142_1.talkMaxDuration)

			if var_145_12 <= arg_142_1.time_ and arg_142_1.time_ < var_145_12 + var_145_22 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_12) / var_145_22

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_12 + var_145_22 and arg_142_1.time_ < var_145_12 + var_145_22 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play116381033 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 116381033
		arg_146_1.duration_ = 2.27

		local var_146_0 = {
			zh = 2.266,
			ja = 1.999999999999
		}
		local var_146_1 = manager.audio:GetLocalizationFlag()

		if var_146_0[var_146_1] ~= nil then
			arg_146_1.duration_ = var_146_0[var_146_1]
		end

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play116381034(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = 0

			if var_149_0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_0 + arg_149_0 then
				arg_146_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action4_2")
			end

			local var_149_1 = 0

			if var_149_1 < arg_146_1.time_ and arg_146_1.time_ <= var_149_1 + arg_149_0 then
				arg_146_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_149_2 = arg_146_1.actors_["10024ui_story"]
			local var_149_3 = 0

			if var_149_3 < arg_146_1.time_ and arg_146_1.time_ <= var_149_3 + arg_149_0 and not isNil(var_149_2) and arg_146_1.var_.characterEffect10024ui_story == nil then
				arg_146_1.var_.characterEffect10024ui_story = var_149_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_4 = 0.2

			if var_149_3 <= arg_146_1.time_ and arg_146_1.time_ < var_149_3 + var_149_4 and not isNil(var_149_2) then
				local var_149_5 = (arg_146_1.time_ - var_149_3) / var_149_4

				if arg_146_1.var_.characterEffect10024ui_story and not isNil(var_149_2) then
					local var_149_6 = Mathf.Lerp(0, 0.5, var_149_5)

					arg_146_1.var_.characterEffect10024ui_story.fillFlat = true
					arg_146_1.var_.characterEffect10024ui_story.fillRatio = var_149_6
				end
			end

			if arg_146_1.time_ >= var_149_3 + var_149_4 and arg_146_1.time_ < var_149_3 + var_149_4 + arg_149_0 and not isNil(var_149_2) and arg_146_1.var_.characterEffect10024ui_story then
				local var_149_7 = 0.5

				arg_146_1.var_.characterEffect10024ui_story.fillFlat = true
				arg_146_1.var_.characterEffect10024ui_story.fillRatio = var_149_7
			end

			local var_149_8 = arg_146_1.actors_["10025ui_story"]
			local var_149_9 = 0

			if var_149_9 < arg_146_1.time_ and arg_146_1.time_ <= var_149_9 + arg_149_0 and not isNil(var_149_8) and arg_146_1.var_.characterEffect10025ui_story == nil then
				arg_146_1.var_.characterEffect10025ui_story = var_149_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_10 = 0.2

			if var_149_9 <= arg_146_1.time_ and arg_146_1.time_ < var_149_9 + var_149_10 and not isNil(var_149_8) then
				local var_149_11 = (arg_146_1.time_ - var_149_9) / var_149_10

				if arg_146_1.var_.characterEffect10025ui_story and not isNil(var_149_8) then
					arg_146_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_146_1.time_ >= var_149_9 + var_149_10 and arg_146_1.time_ < var_149_9 + var_149_10 + arg_149_0 and not isNil(var_149_8) and arg_146_1.var_.characterEffect10025ui_story then
				arg_146_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_149_12 = 0
			local var_149_13 = 0.125

			if var_149_12 < arg_146_1.time_ and arg_146_1.time_ <= var_149_12 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				local var_149_14 = arg_146_1:FormatText(StoryNameCfg[328].name)

				arg_146_1.leftNameTxt_.text = var_149_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_15 = arg_146_1:GetWordFromCfg(116381033)
				local var_149_16 = arg_146_1:FormatText(var_149_15.content)

				arg_146_1.text_.text = var_149_16

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_17 = 5
				local var_149_18 = utf8.len(var_149_16)
				local var_149_19 = var_149_17 <= 0 and var_149_13 or var_149_13 * (var_149_18 / var_149_17)

				if var_149_19 > 0 and var_149_13 < var_149_19 then
					arg_146_1.talkMaxDuration = var_149_19

					if var_149_19 + var_149_12 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_19 + var_149_12
					end
				end

				arg_146_1.text_.text = var_149_16
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381033", "story_v_out_116381.awb") ~= 0 then
					local var_149_20 = manager.audio:GetVoiceLength("story_v_out_116381", "116381033", "story_v_out_116381.awb") / 1000

					if var_149_20 + var_149_12 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_20 + var_149_12
					end

					if var_149_15.prefab_name ~= "" and arg_146_1.actors_[var_149_15.prefab_name] ~= nil then
						local var_149_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_15.prefab_name].transform, "story_v_out_116381", "116381033", "story_v_out_116381.awb")

						arg_146_1:RecordAudio("116381033", var_149_21)
						arg_146_1:RecordAudio("116381033", var_149_21)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_116381", "116381033", "story_v_out_116381.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_116381", "116381033", "story_v_out_116381.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_22 = math.max(var_149_13, arg_146_1.talkMaxDuration)

			if var_149_12 <= arg_146_1.time_ and arg_146_1.time_ < var_149_12 + var_149_22 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_12) / var_149_22

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_12 + var_149_22 and arg_146_1.time_ < var_149_12 + var_149_22 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play116381034 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 116381034
		arg_150_1.duration_ = 5

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play116381035(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = arg_150_1.actors_["10024ui_story"].transform
			local var_153_1 = 0

			if var_153_1 < arg_150_1.time_ and arg_150_1.time_ <= var_153_1 + arg_153_0 then
				arg_150_1.var_.moveOldPos10024ui_story = var_153_0.localPosition
			end

			local var_153_2 = 0.001

			if var_153_1 <= arg_150_1.time_ and arg_150_1.time_ < var_153_1 + var_153_2 then
				local var_153_3 = (arg_150_1.time_ - var_153_1) / var_153_2
				local var_153_4 = Vector3.New(0, 100, 0)

				var_153_0.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos10024ui_story, var_153_4, var_153_3)

				local var_153_5 = manager.ui.mainCamera.transform.position - var_153_0.position

				var_153_0.forward = Vector3.New(var_153_5.x, var_153_5.y, var_153_5.z)

				local var_153_6 = var_153_0.localEulerAngles

				var_153_6.z = 0
				var_153_6.x = 0
				var_153_0.localEulerAngles = var_153_6
			end

			if arg_150_1.time_ >= var_153_1 + var_153_2 and arg_150_1.time_ < var_153_1 + var_153_2 + arg_153_0 then
				var_153_0.localPosition = Vector3.New(0, 100, 0)

				local var_153_7 = manager.ui.mainCamera.transform.position - var_153_0.position

				var_153_0.forward = Vector3.New(var_153_7.x, var_153_7.y, var_153_7.z)

				local var_153_8 = var_153_0.localEulerAngles

				var_153_8.z = 0
				var_153_8.x = 0
				var_153_0.localEulerAngles = var_153_8
			end

			local var_153_9 = arg_150_1.actors_["10025ui_story"].transform
			local var_153_10 = 0

			if var_153_10 < arg_150_1.time_ and arg_150_1.time_ <= var_153_10 + arg_153_0 then
				arg_150_1.var_.moveOldPos10025ui_story = var_153_9.localPosition
			end

			local var_153_11 = 0.001

			if var_153_10 <= arg_150_1.time_ and arg_150_1.time_ < var_153_10 + var_153_11 then
				local var_153_12 = (arg_150_1.time_ - var_153_10) / var_153_11
				local var_153_13 = Vector3.New(0, 100, 0)

				var_153_9.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos10025ui_story, var_153_13, var_153_12)

				local var_153_14 = manager.ui.mainCamera.transform.position - var_153_9.position

				var_153_9.forward = Vector3.New(var_153_14.x, var_153_14.y, var_153_14.z)

				local var_153_15 = var_153_9.localEulerAngles

				var_153_15.z = 0
				var_153_15.x = 0
				var_153_9.localEulerAngles = var_153_15
			end

			if arg_150_1.time_ >= var_153_10 + var_153_11 and arg_150_1.time_ < var_153_10 + var_153_11 + arg_153_0 then
				var_153_9.localPosition = Vector3.New(0, 100, 0)

				local var_153_16 = manager.ui.mainCamera.transform.position - var_153_9.position

				var_153_9.forward = Vector3.New(var_153_16.x, var_153_16.y, var_153_16.z)

				local var_153_17 = var_153_9.localEulerAngles

				var_153_17.z = 0
				var_153_17.x = 0
				var_153_9.localEulerAngles = var_153_17
			end

			local var_153_18 = 0
			local var_153_19 = 1.3

			if var_153_18 < arg_150_1.time_ and arg_150_1.time_ <= var_153_18 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, false)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_20 = arg_150_1:GetWordFromCfg(116381034)
				local var_153_21 = arg_150_1:FormatText(var_153_20.content)

				arg_150_1.text_.text = var_153_21

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_22 = 52
				local var_153_23 = utf8.len(var_153_21)
				local var_153_24 = var_153_22 <= 0 and var_153_19 or var_153_19 * (var_153_23 / var_153_22)

				if var_153_24 > 0 and var_153_19 < var_153_24 then
					arg_150_1.talkMaxDuration = var_153_24

					if var_153_24 + var_153_18 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_24 + var_153_18
					end
				end

				arg_150_1.text_.text = var_153_21
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)
				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_25 = math.max(var_153_19, arg_150_1.talkMaxDuration)

			if var_153_18 <= arg_150_1.time_ and arg_150_1.time_ < var_153_18 + var_153_25 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_18) / var_153_25

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_18 + var_153_25 and arg_150_1.time_ < var_153_18 + var_153_25 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_150_1:InitPlayNodeList()
	end,
	Play116381035 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 116381035
		arg_154_1.duration_ = 10.6

		local var_154_0 = {
			zh = 10.6,
			ja = 9.933
		}
		local var_154_1 = manager.audio:GetLocalizationFlag()

		if var_154_0[var_154_1] ~= nil then
			arg_154_1.duration_ = var_154_0[var_154_1]
		end

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play116381036(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = 0
			local var_157_1 = 1.15

			if var_157_0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_0 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				local var_157_2 = arg_154_1:FormatText(StoryNameCfg[332].name)

				arg_154_1.leftNameTxt_.text = var_157_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, true)
				arg_154_1.iconController_:SetSelectedState("hero")

				arg_154_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10024")

				arg_154_1.callingController_:SetSelectedState("normal")

				arg_154_1.keyicon_.color = Color.New(1, 1, 1)
				arg_154_1.icon_.color = Color.New(1, 1, 1)

				local var_157_3 = arg_154_1:GetWordFromCfg(116381035)
				local var_157_4 = arg_154_1:FormatText(var_157_3.content)

				arg_154_1.text_.text = var_157_4

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_5 = 46
				local var_157_6 = utf8.len(var_157_4)
				local var_157_7 = var_157_5 <= 0 and var_157_1 or var_157_1 * (var_157_6 / var_157_5)

				if var_157_7 > 0 and var_157_1 < var_157_7 then
					arg_154_1.talkMaxDuration = var_157_7

					if var_157_7 + var_157_0 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_7 + var_157_0
					end
				end

				arg_154_1.text_.text = var_157_4
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381035", "story_v_out_116381.awb") ~= 0 then
					local var_157_8 = manager.audio:GetVoiceLength("story_v_out_116381", "116381035", "story_v_out_116381.awb") / 1000

					if var_157_8 + var_157_0 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_8 + var_157_0
					end

					if var_157_3.prefab_name ~= "" and arg_154_1.actors_[var_157_3.prefab_name] ~= nil then
						local var_157_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_3.prefab_name].transform, "story_v_out_116381", "116381035", "story_v_out_116381.awb")

						arg_154_1:RecordAudio("116381035", var_157_9)
						arg_154_1:RecordAudio("116381035", var_157_9)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_116381", "116381035", "story_v_out_116381.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_116381", "116381035", "story_v_out_116381.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_10 = math.max(var_157_1, arg_154_1.talkMaxDuration)

			if var_157_0 <= arg_154_1.time_ and arg_154_1.time_ < var_157_0 + var_157_10 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_0) / var_157_10

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_0 + var_157_10 and arg_154_1.time_ < var_157_0 + var_157_10 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play116381036 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 116381036
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play116381037(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = 0
			local var_161_1 = 0.5

			if var_161_0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_0 + arg_161_0 then
				local var_161_2 = "play"
				local var_161_3 = "effect"

				arg_158_1:AudioAction(var_161_2, var_161_3, "se_story_16", "se_story_16_gun", "")
			end

			local var_161_4 = 0.333333333333333
			local var_161_5 = 0.5

			if var_161_4 < arg_158_1.time_ and arg_158_1.time_ <= var_161_4 + arg_161_0 then
				local var_161_6 = "play"
				local var_161_7 = "effect"

				arg_158_1:AudioAction(var_161_6, var_161_7, "se_story_16", "se_story_16_gun", "")
			end

			local var_161_8 = manager.ui.mainCamera.transform
			local var_161_9 = 0

			if var_161_9 < arg_158_1.time_ and arg_158_1.time_ <= var_161_9 + arg_161_0 then
				arg_158_1.var_.shakeOldPos = var_161_8.localPosition
			end

			local var_161_10 = 0.6

			if var_161_9 <= arg_158_1.time_ and arg_158_1.time_ < var_161_9 + var_161_10 then
				local var_161_11 = (arg_158_1.time_ - var_161_9) / 0.066
				local var_161_12, var_161_13 = math.modf(var_161_11)

				var_161_8.localPosition = Vector3.New(var_161_13 * 0.13, var_161_13 * 0.13, var_161_13 * 0.13) + arg_158_1.var_.shakeOldPos
			end

			if arg_158_1.time_ >= var_161_9 + var_161_10 and arg_158_1.time_ < var_161_9 + var_161_10 + arg_161_0 then
				var_161_8.localPosition = arg_158_1.var_.shakeOldPos
			end

			local var_161_14 = manager.ui.mainCamera.transform
			local var_161_15 = 0.7

			if var_161_15 < arg_158_1.time_ and arg_158_1.time_ <= var_161_15 + arg_161_0 then
				arg_158_1.var_.shakeOldPos = var_161_14.localPosition
			end

			local var_161_16 = 0.6

			if var_161_15 <= arg_158_1.time_ and arg_158_1.time_ < var_161_15 + var_161_16 then
				local var_161_17 = (arg_158_1.time_ - var_161_15) / 0.066
				local var_161_18, var_161_19 = math.modf(var_161_17)

				var_161_14.localPosition = Vector3.New(var_161_19 * 0.13, var_161_19 * 0.13, var_161_19 * 0.13) + arg_158_1.var_.shakeOldPos
			end

			if arg_158_1.time_ >= var_161_15 + var_161_16 and arg_158_1.time_ < var_161_15 + var_161_16 + arg_161_0 then
				var_161_14.localPosition = arg_158_1.var_.shakeOldPos
			end

			local var_161_20 = 0

			if var_161_20 < arg_158_1.time_ and arg_158_1.time_ <= var_161_20 + arg_161_0 then
				arg_158_1.allBtn_.enabled = false
			end

			local var_161_21 = 1.3

			if arg_158_1.time_ >= var_161_20 + var_161_21 and arg_158_1.time_ < var_161_20 + var_161_21 + arg_161_0 then
				arg_158_1.allBtn_.enabled = true
			end

			local var_161_22 = 0
			local var_161_23 = 0.1

			if var_161_22 < arg_158_1.time_ and arg_158_1.time_ <= var_161_22 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, false)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_24 = arg_158_1:GetWordFromCfg(116381036)
				local var_161_25 = arg_158_1:FormatText(var_161_24.content)

				arg_158_1.text_.text = var_161_25

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_26 = 4
				local var_161_27 = utf8.len(var_161_25)
				local var_161_28 = var_161_26 <= 0 and var_161_23 or var_161_23 * (var_161_27 / var_161_26)

				if var_161_28 > 0 and var_161_23 < var_161_28 then
					arg_158_1.talkMaxDuration = var_161_28

					if var_161_28 + var_161_22 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_28 + var_161_22
					end
				end

				arg_158_1.text_.text = var_161_25
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_29 = math.max(var_161_23, arg_158_1.talkMaxDuration)

			if var_161_22 <= arg_158_1.time_ and arg_158_1.time_ < var_161_22 + var_161_29 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_22) / var_161_29

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_22 + var_161_29 and arg_158_1.time_ < var_161_22 + var_161_29 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play116381037 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 116381037
		arg_162_1.duration_ = 5

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play116381038(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = 0
			local var_165_1 = 1

			if var_165_0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_0 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, false)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_2 = arg_162_1:GetWordFromCfg(116381037)
				local var_165_3 = arg_162_1:FormatText(var_165_2.content)

				arg_162_1.text_.text = var_165_3

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_4 = 40
				local var_165_5 = utf8.len(var_165_3)
				local var_165_6 = var_165_4 <= 0 and var_165_1 or var_165_1 * (var_165_5 / var_165_4)

				if var_165_6 > 0 and var_165_1 < var_165_6 then
					arg_162_1.talkMaxDuration = var_165_6

					if var_165_6 + var_165_0 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_6 + var_165_0
					end
				end

				arg_162_1.text_.text = var_165_3
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)
				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_7 = math.max(var_165_1, arg_162_1.talkMaxDuration)

			if var_165_0 <= arg_162_1.time_ and arg_162_1.time_ < var_165_0 + var_165_7 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_0) / var_165_7

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_0 + var_165_7 and arg_162_1.time_ < var_165_0 + var_165_7 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play116381038 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 116381038
		arg_166_1.duration_ = 8.33

		local var_166_0 = {
			zh = 8.2,
			ja = 8.333
		}
		local var_166_1 = manager.audio:GetLocalizationFlag()

		if var_166_0[var_166_1] ~= nil then
			arg_166_1.duration_ = var_166_0[var_166_1]
		end

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play116381039(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = arg_166_1.actors_["10024ui_story"].transform
			local var_169_1 = 0

			if var_169_1 < arg_166_1.time_ and arg_166_1.time_ <= var_169_1 + arg_169_0 then
				arg_166_1.var_.moveOldPos10024ui_story = var_169_0.localPosition
			end

			local var_169_2 = 0.001

			if var_169_1 <= arg_166_1.time_ and arg_166_1.time_ < var_169_1 + var_169_2 then
				local var_169_3 = (arg_166_1.time_ - var_169_1) / var_169_2
				local var_169_4 = Vector3.New(0, -1, -6)

				var_169_0.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos10024ui_story, var_169_4, var_169_3)

				local var_169_5 = manager.ui.mainCamera.transform.position - var_169_0.position

				var_169_0.forward = Vector3.New(var_169_5.x, var_169_5.y, var_169_5.z)

				local var_169_6 = var_169_0.localEulerAngles

				var_169_6.z = 0
				var_169_6.x = 0
				var_169_0.localEulerAngles = var_169_6
			end

			if arg_166_1.time_ >= var_169_1 + var_169_2 and arg_166_1.time_ < var_169_1 + var_169_2 + arg_169_0 then
				var_169_0.localPosition = Vector3.New(0, -1, -6)

				local var_169_7 = manager.ui.mainCamera.transform.position - var_169_0.position

				var_169_0.forward = Vector3.New(var_169_7.x, var_169_7.y, var_169_7.z)

				local var_169_8 = var_169_0.localEulerAngles

				var_169_8.z = 0
				var_169_8.x = 0
				var_169_0.localEulerAngles = var_169_8
			end

			local var_169_9 = 0

			if var_169_9 < arg_166_1.time_ and arg_166_1.time_ <= var_169_9 + arg_169_0 then
				arg_166_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/story10024/story10024action/10024action6_1")
			end

			local var_169_10 = 0

			if var_169_10 < arg_166_1.time_ and arg_166_1.time_ <= var_169_10 + arg_169_0 then
				arg_166_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_169_11 = arg_166_1.actors_["10024ui_story"]
			local var_169_12 = 0

			if var_169_12 < arg_166_1.time_ and arg_166_1.time_ <= var_169_12 + arg_169_0 and not isNil(var_169_11) and arg_166_1.var_.characterEffect10024ui_story == nil then
				arg_166_1.var_.characterEffect10024ui_story = var_169_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_13 = 0.2

			if var_169_12 <= arg_166_1.time_ and arg_166_1.time_ < var_169_12 + var_169_13 and not isNil(var_169_11) then
				local var_169_14 = (arg_166_1.time_ - var_169_12) / var_169_13

				if arg_166_1.var_.characterEffect10024ui_story and not isNil(var_169_11) then
					arg_166_1.var_.characterEffect10024ui_story.fillFlat = false
				end
			end

			if arg_166_1.time_ >= var_169_12 + var_169_13 and arg_166_1.time_ < var_169_12 + var_169_13 + arg_169_0 and not isNil(var_169_11) and arg_166_1.var_.characterEffect10024ui_story then
				arg_166_1.var_.characterEffect10024ui_story.fillFlat = false
			end

			local var_169_15 = 0
			local var_169_16 = 0.7

			if var_169_15 < arg_166_1.time_ and arg_166_1.time_ <= var_169_15 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				local var_169_17 = arg_166_1:FormatText(StoryNameCfg[332].name)

				arg_166_1.leftNameTxt_.text = var_169_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_18 = arg_166_1:GetWordFromCfg(116381038)
				local var_169_19 = arg_166_1:FormatText(var_169_18.content)

				arg_166_1.text_.text = var_169_19

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_20 = 28
				local var_169_21 = utf8.len(var_169_19)
				local var_169_22 = var_169_20 <= 0 and var_169_16 or var_169_16 * (var_169_21 / var_169_20)

				if var_169_22 > 0 and var_169_16 < var_169_22 then
					arg_166_1.talkMaxDuration = var_169_22

					if var_169_22 + var_169_15 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_22 + var_169_15
					end
				end

				arg_166_1.text_.text = var_169_19
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381038", "story_v_out_116381.awb") ~= 0 then
					local var_169_23 = manager.audio:GetVoiceLength("story_v_out_116381", "116381038", "story_v_out_116381.awb") / 1000

					if var_169_23 + var_169_15 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_23 + var_169_15
					end

					if var_169_18.prefab_name ~= "" and arg_166_1.actors_[var_169_18.prefab_name] ~= nil then
						local var_169_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_18.prefab_name].transform, "story_v_out_116381", "116381038", "story_v_out_116381.awb")

						arg_166_1:RecordAudio("116381038", var_169_24)
						arg_166_1:RecordAudio("116381038", var_169_24)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_116381", "116381038", "story_v_out_116381.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_116381", "116381038", "story_v_out_116381.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_25 = math.max(var_169_16, arg_166_1.talkMaxDuration)

			if var_169_15 <= arg_166_1.time_ and arg_166_1.time_ < var_169_15 + var_169_25 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_15) / var_169_25

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_15 + var_169_25 and arg_166_1.time_ < var_169_15 + var_169_25 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_166_1:InitPlayNodeList()
	end,
	Play116381039 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 116381039
		arg_170_1.duration_ = 5.07

		local var_170_0 = {
			zh = 4.866,
			ja = 5.066
		}
		local var_170_1 = manager.audio:GetLocalizationFlag()

		if var_170_0[var_170_1] ~= nil then
			arg_170_1.duration_ = var_170_0[var_170_1]
		end

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play116381040(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = 0

			if var_173_0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_0 + arg_173_0 then
				arg_170_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/story10024/story10024actionlink/10024action462")
			end

			local var_173_1 = 0

			if var_173_1 < arg_170_1.time_ and arg_170_1.time_ <= var_173_1 + arg_173_0 then
				arg_170_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_173_2 = 0
			local var_173_3 = 0.375

			if var_173_2 < arg_170_1.time_ and arg_170_1.time_ <= var_173_2 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				local var_173_4 = arg_170_1:FormatText(StoryNameCfg[332].name)

				arg_170_1.leftNameTxt_.text = var_173_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_5 = arg_170_1:GetWordFromCfg(116381039)
				local var_173_6 = arg_170_1:FormatText(var_173_5.content)

				arg_170_1.text_.text = var_173_6

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_7 = 15
				local var_173_8 = utf8.len(var_173_6)
				local var_173_9 = var_173_7 <= 0 and var_173_3 or var_173_3 * (var_173_8 / var_173_7)

				if var_173_9 > 0 and var_173_3 < var_173_9 then
					arg_170_1.talkMaxDuration = var_173_9

					if var_173_9 + var_173_2 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_9 + var_173_2
					end
				end

				arg_170_1.text_.text = var_173_6
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381039", "story_v_out_116381.awb") ~= 0 then
					local var_173_10 = manager.audio:GetVoiceLength("story_v_out_116381", "116381039", "story_v_out_116381.awb") / 1000

					if var_173_10 + var_173_2 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_10 + var_173_2
					end

					if var_173_5.prefab_name ~= "" and arg_170_1.actors_[var_173_5.prefab_name] ~= nil then
						local var_173_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_5.prefab_name].transform, "story_v_out_116381", "116381039", "story_v_out_116381.awb")

						arg_170_1:RecordAudio("116381039", var_173_11)
						arg_170_1:RecordAudio("116381039", var_173_11)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_116381", "116381039", "story_v_out_116381.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_116381", "116381039", "story_v_out_116381.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_12 = math.max(var_173_3, arg_170_1.talkMaxDuration)

			if var_173_2 <= arg_170_1.time_ and arg_170_1.time_ < var_173_2 + var_173_12 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_2) / var_173_12

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_2 + var_173_12 and arg_170_1.time_ < var_173_2 + var_173_12 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play116381040 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 116381040
		arg_174_1.duration_ = 5

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play116381041(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = arg_174_1.actors_["10024ui_story"].transform
			local var_177_1 = 0

			if var_177_1 < arg_174_1.time_ and arg_174_1.time_ <= var_177_1 + arg_177_0 then
				arg_174_1.var_.moveOldPos10024ui_story = var_177_0.localPosition
			end

			local var_177_2 = 0.001

			if var_177_1 <= arg_174_1.time_ and arg_174_1.time_ < var_177_1 + var_177_2 then
				local var_177_3 = (arg_174_1.time_ - var_177_1) / var_177_2
				local var_177_4 = Vector3.New(0, 100, 0)

				var_177_0.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos10024ui_story, var_177_4, var_177_3)

				local var_177_5 = manager.ui.mainCamera.transform.position - var_177_0.position

				var_177_0.forward = Vector3.New(var_177_5.x, var_177_5.y, var_177_5.z)

				local var_177_6 = var_177_0.localEulerAngles

				var_177_6.z = 0
				var_177_6.x = 0
				var_177_0.localEulerAngles = var_177_6
			end

			if arg_174_1.time_ >= var_177_1 + var_177_2 and arg_174_1.time_ < var_177_1 + var_177_2 + arg_177_0 then
				var_177_0.localPosition = Vector3.New(0, 100, 0)

				local var_177_7 = manager.ui.mainCamera.transform.position - var_177_0.position

				var_177_0.forward = Vector3.New(var_177_7.x, var_177_7.y, var_177_7.z)

				local var_177_8 = var_177_0.localEulerAngles

				var_177_8.z = 0
				var_177_8.x = 0
				var_177_0.localEulerAngles = var_177_8
			end

			local var_177_9 = 0
			local var_177_10 = 0.675

			if var_177_9 < arg_174_1.time_ and arg_174_1.time_ <= var_177_9 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, false)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_11 = arg_174_1:GetWordFromCfg(116381040)
				local var_177_12 = arg_174_1:FormatText(var_177_11.content)

				arg_174_1.text_.text = var_177_12

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_13 = 27
				local var_177_14 = utf8.len(var_177_12)
				local var_177_15 = var_177_13 <= 0 and var_177_10 or var_177_10 * (var_177_14 / var_177_13)

				if var_177_15 > 0 and var_177_10 < var_177_15 then
					arg_174_1.talkMaxDuration = var_177_15

					if var_177_15 + var_177_9 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_15 + var_177_9
					end
				end

				arg_174_1.text_.text = var_177_12
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)
				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_16 = math.max(var_177_10, arg_174_1.talkMaxDuration)

			if var_177_9 <= arg_174_1.time_ and arg_174_1.time_ < var_177_9 + var_177_16 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_9) / var_177_16

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_9 + var_177_16 and arg_174_1.time_ < var_177_9 + var_177_16 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_174_1:InitPlayNodeList()
	end,
	Play116381041 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 116381041
		arg_178_1.duration_ = 5

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play116381042(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = 0
			local var_181_1 = 0.825

			if var_181_0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_0 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, false)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_2 = arg_178_1:GetWordFromCfg(116381041)
				local var_181_3 = arg_178_1:FormatText(var_181_2.content)

				arg_178_1.text_.text = var_181_3

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_4 = 32
				local var_181_5 = utf8.len(var_181_3)
				local var_181_6 = var_181_4 <= 0 and var_181_1 or var_181_1 * (var_181_5 / var_181_4)

				if var_181_6 > 0 and var_181_1 < var_181_6 then
					arg_178_1.talkMaxDuration = var_181_6

					if var_181_6 + var_181_0 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_6 + var_181_0
					end
				end

				arg_178_1.text_.text = var_181_3
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)
				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_7 = math.max(var_181_1, arg_178_1.talkMaxDuration)

			if var_181_0 <= arg_178_1.time_ and arg_178_1.time_ < var_181_0 + var_181_7 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_0) / var_181_7

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_0 + var_181_7 and arg_178_1.time_ < var_181_0 + var_181_7 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play116381042 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 116381042
		arg_182_1.duration_ = 5

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play116381043(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = 0
			local var_185_1 = 0.3

			if var_185_0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_0 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, false)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_2 = arg_182_1:GetWordFromCfg(116381042)
				local var_185_3 = arg_182_1:FormatText(var_185_2.content)

				arg_182_1.text_.text = var_185_3

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_4 = 12
				local var_185_5 = utf8.len(var_185_3)
				local var_185_6 = var_185_4 <= 0 and var_185_1 or var_185_1 * (var_185_5 / var_185_4)

				if var_185_6 > 0 and var_185_1 < var_185_6 then
					arg_182_1.talkMaxDuration = var_185_6

					if var_185_6 + var_185_0 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_6 + var_185_0
					end
				end

				arg_182_1.text_.text = var_185_3
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)
				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_7 = math.max(var_185_1, arg_182_1.talkMaxDuration)

			if var_185_0 <= arg_182_1.time_ and arg_182_1.time_ < var_185_0 + var_185_7 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_0) / var_185_7

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_0 + var_185_7 and arg_182_1.time_ < var_185_0 + var_185_7 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play116381043 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 116381043
		arg_186_1.duration_ = 5

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play116381044(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = 0
			local var_189_1 = 0.675

			if var_189_0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_0 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, false)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_2 = arg_186_1:GetWordFromCfg(116381043)
				local var_189_3 = arg_186_1:FormatText(var_189_2.content)

				arg_186_1.text_.text = var_189_3

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_4 = 27
				local var_189_5 = utf8.len(var_189_3)
				local var_189_6 = var_189_4 <= 0 and var_189_1 or var_189_1 * (var_189_5 / var_189_4)

				if var_189_6 > 0 and var_189_1 < var_189_6 then
					arg_186_1.talkMaxDuration = var_189_6

					if var_189_6 + var_189_0 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_6 + var_189_0
					end
				end

				arg_186_1.text_.text = var_189_3
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)
				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_7 = math.max(var_189_1, arg_186_1.talkMaxDuration)

			if var_189_0 <= arg_186_1.time_ and arg_186_1.time_ < var_189_0 + var_189_7 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_0) / var_189_7

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_0 + var_189_7 and arg_186_1.time_ < var_189_0 + var_189_7 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play116381044 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 116381044
		arg_190_1.duration_ = 5

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play116381045(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = 0
			local var_193_1 = 0.8

			if var_193_0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_0 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, false)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_2 = arg_190_1:GetWordFromCfg(116381044)
				local var_193_3 = arg_190_1:FormatText(var_193_2.content)

				arg_190_1.text_.text = var_193_3

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_4 = 32
				local var_193_5 = utf8.len(var_193_3)
				local var_193_6 = var_193_4 <= 0 and var_193_1 or var_193_1 * (var_193_5 / var_193_4)

				if var_193_6 > 0 and var_193_1 < var_193_6 then
					arg_190_1.talkMaxDuration = var_193_6

					if var_193_6 + var_193_0 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_6 + var_193_0
					end
				end

				arg_190_1.text_.text = var_193_3
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)
				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_7 = math.max(var_193_1, arg_190_1.talkMaxDuration)

			if var_193_0 <= arg_190_1.time_ and arg_190_1.time_ < var_193_0 + var_193_7 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_0) / var_193_7

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_0 + var_193_7 and arg_190_1.time_ < var_193_0 + var_193_7 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play116381045 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 116381045
		arg_194_1.duration_ = 12.3

		local var_194_0 = {
			zh = 7.966,
			ja = 12.3
		}
		local var_194_1 = manager.audio:GetLocalizationFlag()

		if var_194_0[var_194_1] ~= nil then
			arg_194_1.duration_ = var_194_0[var_194_1]
		end

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play116381046(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = 0
			local var_197_1 = 0.775

			if var_197_0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_0 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				local var_197_2 = arg_194_1:FormatText(StoryNameCfg[332].name)

				arg_194_1.leftNameTxt_.text = var_197_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, true)
				arg_194_1.iconController_:SetSelectedState("hero")

				arg_194_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10024")

				arg_194_1.callingController_:SetSelectedState("normal")

				arg_194_1.keyicon_.color = Color.New(1, 1, 1)
				arg_194_1.icon_.color = Color.New(1, 1, 1)

				local var_197_3 = arg_194_1:GetWordFromCfg(116381045)
				local var_197_4 = arg_194_1:FormatText(var_197_3.content)

				arg_194_1.text_.text = var_197_4

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_5 = 30
				local var_197_6 = utf8.len(var_197_4)
				local var_197_7 = var_197_5 <= 0 and var_197_1 or var_197_1 * (var_197_6 / var_197_5)

				if var_197_7 > 0 and var_197_1 < var_197_7 then
					arg_194_1.talkMaxDuration = var_197_7

					if var_197_7 + var_197_0 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_7 + var_197_0
					end
				end

				arg_194_1.text_.text = var_197_4
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381045", "story_v_out_116381.awb") ~= 0 then
					local var_197_8 = manager.audio:GetVoiceLength("story_v_out_116381", "116381045", "story_v_out_116381.awb") / 1000

					if var_197_8 + var_197_0 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_8 + var_197_0
					end

					if var_197_3.prefab_name ~= "" and arg_194_1.actors_[var_197_3.prefab_name] ~= nil then
						local var_197_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_3.prefab_name].transform, "story_v_out_116381", "116381045", "story_v_out_116381.awb")

						arg_194_1:RecordAudio("116381045", var_197_9)
						arg_194_1:RecordAudio("116381045", var_197_9)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_116381", "116381045", "story_v_out_116381.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_116381", "116381045", "story_v_out_116381.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_10 = math.max(var_197_1, arg_194_1.talkMaxDuration)

			if var_197_0 <= arg_194_1.time_ and arg_194_1.time_ < var_197_0 + var_197_10 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_0) / var_197_10

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_0 + var_197_10 and arg_194_1.time_ < var_197_0 + var_197_10 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play116381046 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 116381046
		arg_198_1.duration_ = 5

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play116381047(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = 0
			local var_201_1 = 0.675

			if var_201_0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_0 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, false)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_2 = arg_198_1:GetWordFromCfg(116381046)
				local var_201_3 = arg_198_1:FormatText(var_201_2.content)

				arg_198_1.text_.text = var_201_3

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_4 = 27
				local var_201_5 = utf8.len(var_201_3)
				local var_201_6 = var_201_4 <= 0 and var_201_1 or var_201_1 * (var_201_5 / var_201_4)

				if var_201_6 > 0 and var_201_1 < var_201_6 then
					arg_198_1.talkMaxDuration = var_201_6

					if var_201_6 + var_201_0 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_6 + var_201_0
					end
				end

				arg_198_1.text_.text = var_201_3
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)
				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_7 = math.max(var_201_1, arg_198_1.talkMaxDuration)

			if var_201_0 <= arg_198_1.time_ and arg_198_1.time_ < var_201_0 + var_201_7 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_0) / var_201_7

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_0 + var_201_7 and arg_198_1.time_ < var_201_0 + var_201_7 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play116381047 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 116381047
		arg_202_1.duration_ = 7.1

		local var_202_0 = {
			zh = 4.166,
			ja = 7.1
		}
		local var_202_1 = manager.audio:GetLocalizationFlag()

		if var_202_0[var_202_1] ~= nil then
			arg_202_1.duration_ = var_202_0[var_202_1]
		end

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play116381048(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = manager.ui.mainCamera.transform
			local var_205_1 = 0

			if var_205_1 < arg_202_1.time_ and arg_202_1.time_ <= var_205_1 + arg_205_0 then
				arg_202_1.var_.shakeOldPos = var_205_0.localPosition
			end

			local var_205_2 = 0.6

			if var_205_1 <= arg_202_1.time_ and arg_202_1.time_ < var_205_1 + var_205_2 then
				local var_205_3 = (arg_202_1.time_ - var_205_1) / 0.066
				local var_205_4, var_205_5 = math.modf(var_205_3)

				var_205_0.localPosition = Vector3.New(var_205_5 * 0.13, var_205_5 * 0.13, var_205_5 * 0.13) + arg_202_1.var_.shakeOldPos
			end

			if arg_202_1.time_ >= var_205_1 + var_205_2 and arg_202_1.time_ < var_205_1 + var_205_2 + arg_205_0 then
				var_205_0.localPosition = arg_202_1.var_.shakeOldPos
			end

			local var_205_6 = 0

			if var_205_6 < arg_202_1.time_ and arg_202_1.time_ <= var_205_6 + arg_205_0 then
				arg_202_1.allBtn_.enabled = false
			end

			local var_205_7 = 0.6

			if arg_202_1.time_ >= var_205_6 + var_205_7 and arg_202_1.time_ < var_205_6 + var_205_7 + arg_205_0 then
				arg_202_1.allBtn_.enabled = true
			end

			local var_205_8 = 0
			local var_205_9 = 0.475

			if var_205_8 < arg_202_1.time_ and arg_202_1.time_ <= var_205_8 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				local var_205_10 = arg_202_1:FormatText(StoryNameCfg[327].name)

				arg_202_1.leftNameTxt_.text = var_205_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, true)
				arg_202_1.iconController_:SetSelectedState("hero")

				arg_202_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1028")

				arg_202_1.callingController_:SetSelectedState("normal")

				arg_202_1.keyicon_.color = Color.New(1, 1, 1)
				arg_202_1.icon_.color = Color.New(1, 1, 1)

				local var_205_11 = arg_202_1:GetWordFromCfg(116381047)
				local var_205_12 = arg_202_1:FormatText(var_205_11.content)

				arg_202_1.text_.text = var_205_12

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_13 = 19
				local var_205_14 = utf8.len(var_205_12)
				local var_205_15 = var_205_13 <= 0 and var_205_9 or var_205_9 * (var_205_14 / var_205_13)

				if var_205_15 > 0 and var_205_9 < var_205_15 then
					arg_202_1.talkMaxDuration = var_205_15

					if var_205_15 + var_205_8 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_15 + var_205_8
					end
				end

				arg_202_1.text_.text = var_205_12
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381047", "story_v_out_116381.awb") ~= 0 then
					local var_205_16 = manager.audio:GetVoiceLength("story_v_out_116381", "116381047", "story_v_out_116381.awb") / 1000

					if var_205_16 + var_205_8 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_16 + var_205_8
					end

					if var_205_11.prefab_name ~= "" and arg_202_1.actors_[var_205_11.prefab_name] ~= nil then
						local var_205_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_11.prefab_name].transform, "story_v_out_116381", "116381047", "story_v_out_116381.awb")

						arg_202_1:RecordAudio("116381047", var_205_17)
						arg_202_1:RecordAudio("116381047", var_205_17)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_116381", "116381047", "story_v_out_116381.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_116381", "116381047", "story_v_out_116381.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_18 = math.max(var_205_9, arg_202_1.talkMaxDuration)

			if var_205_8 <= arg_202_1.time_ and arg_202_1.time_ < var_205_8 + var_205_18 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_8) / var_205_18

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_8 + var_205_18 and arg_202_1.time_ < var_205_8 + var_205_18 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play116381048 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 116381048
		arg_206_1.duration_ = 3.23

		local var_206_0 = {
			zh = 3.2,
			ja = 3.233
		}
		local var_206_1 = manager.audio:GetLocalizationFlag()

		if var_206_0[var_206_1] ~= nil then
			arg_206_1.duration_ = var_206_0[var_206_1]
		end

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play116381049(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = arg_206_1.actors_["10024ui_story"].transform
			local var_209_1 = 0

			if var_209_1 < arg_206_1.time_ and arg_206_1.time_ <= var_209_1 + arg_209_0 then
				arg_206_1.var_.moveOldPos10024ui_story = var_209_0.localPosition
			end

			local var_209_2 = 0.001

			if var_209_1 <= arg_206_1.time_ and arg_206_1.time_ < var_209_1 + var_209_2 then
				local var_209_3 = (arg_206_1.time_ - var_209_1) / var_209_2
				local var_209_4 = Vector3.New(0, -1, -6)

				var_209_0.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos10024ui_story, var_209_4, var_209_3)

				local var_209_5 = manager.ui.mainCamera.transform.position - var_209_0.position

				var_209_0.forward = Vector3.New(var_209_5.x, var_209_5.y, var_209_5.z)

				local var_209_6 = var_209_0.localEulerAngles

				var_209_6.z = 0
				var_209_6.x = 0
				var_209_0.localEulerAngles = var_209_6
			end

			if arg_206_1.time_ >= var_209_1 + var_209_2 and arg_206_1.time_ < var_209_1 + var_209_2 + arg_209_0 then
				var_209_0.localPosition = Vector3.New(0, -1, -6)

				local var_209_7 = manager.ui.mainCamera.transform.position - var_209_0.position

				var_209_0.forward = Vector3.New(var_209_7.x, var_209_7.y, var_209_7.z)

				local var_209_8 = var_209_0.localEulerAngles

				var_209_8.z = 0
				var_209_8.x = 0
				var_209_0.localEulerAngles = var_209_8
			end

			local var_209_9 = 0

			if var_209_9 < arg_206_1.time_ and arg_206_1.time_ <= var_209_9 + arg_209_0 then
				arg_206_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/story10024/story10024action/10024action6_1")
			end

			local var_209_10 = 0

			if var_209_10 < arg_206_1.time_ and arg_206_1.time_ <= var_209_10 + arg_209_0 then
				arg_206_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_209_11 = arg_206_1.actors_["10024ui_story"]
			local var_209_12 = 0

			if var_209_12 < arg_206_1.time_ and arg_206_1.time_ <= var_209_12 + arg_209_0 and not isNil(var_209_11) and arg_206_1.var_.characterEffect10024ui_story == nil then
				arg_206_1.var_.characterEffect10024ui_story = var_209_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_209_13 = 0.2

			if var_209_12 <= arg_206_1.time_ and arg_206_1.time_ < var_209_12 + var_209_13 and not isNil(var_209_11) then
				local var_209_14 = (arg_206_1.time_ - var_209_12) / var_209_13

				if arg_206_1.var_.characterEffect10024ui_story and not isNil(var_209_11) then
					arg_206_1.var_.characterEffect10024ui_story.fillFlat = false
				end
			end

			if arg_206_1.time_ >= var_209_12 + var_209_13 and arg_206_1.time_ < var_209_12 + var_209_13 + arg_209_0 and not isNil(var_209_11) and arg_206_1.var_.characterEffect10024ui_story then
				arg_206_1.var_.characterEffect10024ui_story.fillFlat = false
			end

			local var_209_15 = 0
			local var_209_16 = 0.25

			if var_209_15 < arg_206_1.time_ and arg_206_1.time_ <= var_209_15 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				local var_209_17 = arg_206_1:FormatText(StoryNameCfg[332].name)

				arg_206_1.leftNameTxt_.text = var_209_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_18 = arg_206_1:GetWordFromCfg(116381048)
				local var_209_19 = arg_206_1:FormatText(var_209_18.content)

				arg_206_1.text_.text = var_209_19

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_20 = 10
				local var_209_21 = utf8.len(var_209_19)
				local var_209_22 = var_209_20 <= 0 and var_209_16 or var_209_16 * (var_209_21 / var_209_20)

				if var_209_22 > 0 and var_209_16 < var_209_22 then
					arg_206_1.talkMaxDuration = var_209_22

					if var_209_22 + var_209_15 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_22 + var_209_15
					end
				end

				arg_206_1.text_.text = var_209_19
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381048", "story_v_out_116381.awb") ~= 0 then
					local var_209_23 = manager.audio:GetVoiceLength("story_v_out_116381", "116381048", "story_v_out_116381.awb") / 1000

					if var_209_23 + var_209_15 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_23 + var_209_15
					end

					if var_209_18.prefab_name ~= "" and arg_206_1.actors_[var_209_18.prefab_name] ~= nil then
						local var_209_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_18.prefab_name].transform, "story_v_out_116381", "116381048", "story_v_out_116381.awb")

						arg_206_1:RecordAudio("116381048", var_209_24)
						arg_206_1:RecordAudio("116381048", var_209_24)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_116381", "116381048", "story_v_out_116381.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_116381", "116381048", "story_v_out_116381.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_25 = math.max(var_209_16, arg_206_1.talkMaxDuration)

			if var_209_15 <= arg_206_1.time_ and arg_206_1.time_ < var_209_15 + var_209_25 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_15) / var_209_25

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_15 + var_209_25 and arg_206_1.time_ < var_209_15 + var_209_25 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_206_1:InitPlayNodeList()
	end,
	Play116381049 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 116381049
		arg_210_1.duration_ = 2.8

		local var_210_0 = {
			zh = 2.2,
			ja = 2.8
		}
		local var_210_1 = manager.audio:GetLocalizationFlag()

		if var_210_0[var_210_1] ~= nil then
			arg_210_1.duration_ = var_210_0[var_210_1]
		end

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play116381050(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = arg_210_1.actors_["10024ui_story"].transform
			local var_213_1 = 0

			if var_213_1 < arg_210_1.time_ and arg_210_1.time_ <= var_213_1 + arg_213_0 then
				arg_210_1.var_.moveOldPos10024ui_story = var_213_0.localPosition
			end

			local var_213_2 = 0.001

			if var_213_1 <= arg_210_1.time_ and arg_210_1.time_ < var_213_1 + var_213_2 then
				local var_213_3 = (arg_210_1.time_ - var_213_1) / var_213_2
				local var_213_4 = Vector3.New(0, -1, -6)

				var_213_0.localPosition = Vector3.Lerp(arg_210_1.var_.moveOldPos10024ui_story, var_213_4, var_213_3)

				local var_213_5 = manager.ui.mainCamera.transform.position - var_213_0.position

				var_213_0.forward = Vector3.New(var_213_5.x, var_213_5.y, var_213_5.z)

				local var_213_6 = var_213_0.localEulerAngles

				var_213_6.z = 0
				var_213_6.x = 0
				var_213_0.localEulerAngles = var_213_6
			end

			if arg_210_1.time_ >= var_213_1 + var_213_2 and arg_210_1.time_ < var_213_1 + var_213_2 + arg_213_0 then
				var_213_0.localPosition = Vector3.New(0, -1, -6)

				local var_213_7 = manager.ui.mainCamera.transform.position - var_213_0.position

				var_213_0.forward = Vector3.New(var_213_7.x, var_213_7.y, var_213_7.z)

				local var_213_8 = var_213_0.localEulerAngles

				var_213_8.z = 0
				var_213_8.x = 0
				var_213_0.localEulerAngles = var_213_8
			end

			local var_213_9 = 0

			if var_213_9 < arg_210_1.time_ and arg_210_1.time_ <= var_213_9 + arg_213_0 then
				arg_210_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/story10024/story10024action/10024action6_2")
			end

			local var_213_10 = 0

			if var_213_10 < arg_210_1.time_ and arg_210_1.time_ <= var_213_10 + arg_213_0 then
				arg_210_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_213_11 = 0
			local var_213_12 = 0.15

			if var_213_11 < arg_210_1.time_ and arg_210_1.time_ <= var_213_11 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				local var_213_13 = arg_210_1:FormatText(StoryNameCfg[332].name)

				arg_210_1.leftNameTxt_.text = var_213_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_14 = arg_210_1:GetWordFromCfg(116381049)
				local var_213_15 = arg_210_1:FormatText(var_213_14.content)

				arg_210_1.text_.text = var_213_15

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_16 = 6
				local var_213_17 = utf8.len(var_213_15)
				local var_213_18 = var_213_16 <= 0 and var_213_12 or var_213_12 * (var_213_17 / var_213_16)

				if var_213_18 > 0 and var_213_12 < var_213_18 then
					arg_210_1.talkMaxDuration = var_213_18

					if var_213_18 + var_213_11 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_18 + var_213_11
					end
				end

				arg_210_1.text_.text = var_213_15
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381049", "story_v_out_116381.awb") ~= 0 then
					local var_213_19 = manager.audio:GetVoiceLength("story_v_out_116381", "116381049", "story_v_out_116381.awb") / 1000

					if var_213_19 + var_213_11 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_19 + var_213_11
					end

					if var_213_14.prefab_name ~= "" and arg_210_1.actors_[var_213_14.prefab_name] ~= nil then
						local var_213_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_14.prefab_name].transform, "story_v_out_116381", "116381049", "story_v_out_116381.awb")

						arg_210_1:RecordAudio("116381049", var_213_20)
						arg_210_1:RecordAudio("116381049", var_213_20)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_116381", "116381049", "story_v_out_116381.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_116381", "116381049", "story_v_out_116381.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_21 = math.max(var_213_12, arg_210_1.talkMaxDuration)

			if var_213_11 <= arg_210_1.time_ and arg_210_1.time_ < var_213_11 + var_213_21 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_11) / var_213_21

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_11 + var_213_21 and arg_210_1.time_ < var_213_11 + var_213_21 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_210_1:InitPlayNodeList()
	end,
	Play116381050 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 116381050
		arg_214_1.duration_ = 9.1

		local var_214_0 = {
			zh = 9.1,
			ja = 7.233
		}
		local var_214_1 = manager.audio:GetLocalizationFlag()

		if var_214_0[var_214_1] ~= nil then
			arg_214_1.duration_ = var_214_0[var_214_1]
		end

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play116381051(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = arg_214_1.actors_["10024ui_story"].transform
			local var_217_1 = 0

			if var_217_1 < arg_214_1.time_ and arg_214_1.time_ <= var_217_1 + arg_217_0 then
				arg_214_1.var_.moveOldPos10024ui_story = var_217_0.localPosition
			end

			local var_217_2 = 0.001

			if var_217_1 <= arg_214_1.time_ and arg_214_1.time_ < var_217_1 + var_217_2 then
				local var_217_3 = (arg_214_1.time_ - var_217_1) / var_217_2
				local var_217_4 = Vector3.New(0, -1, -6)

				var_217_0.localPosition = Vector3.Lerp(arg_214_1.var_.moveOldPos10024ui_story, var_217_4, var_217_3)

				local var_217_5 = manager.ui.mainCamera.transform.position - var_217_0.position

				var_217_0.forward = Vector3.New(var_217_5.x, var_217_5.y, var_217_5.z)

				local var_217_6 = var_217_0.localEulerAngles

				var_217_6.z = 0
				var_217_6.x = 0
				var_217_0.localEulerAngles = var_217_6
			end

			if arg_214_1.time_ >= var_217_1 + var_217_2 and arg_214_1.time_ < var_217_1 + var_217_2 + arg_217_0 then
				var_217_0.localPosition = Vector3.New(0, -1, -6)

				local var_217_7 = manager.ui.mainCamera.transform.position - var_217_0.position

				var_217_0.forward = Vector3.New(var_217_7.x, var_217_7.y, var_217_7.z)

				local var_217_8 = var_217_0.localEulerAngles

				var_217_8.z = 0
				var_217_8.x = 0
				var_217_0.localEulerAngles = var_217_8
			end

			local var_217_9 = 0

			if var_217_9 < arg_214_1.time_ and arg_214_1.time_ <= var_217_9 + arg_217_0 then
				arg_214_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/story10024/story10024action/10024action1_1")
			end

			local var_217_10 = 0

			if var_217_10 < arg_214_1.time_ and arg_214_1.time_ <= var_217_10 + arg_217_0 then
				arg_214_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_217_11 = 0
			local var_217_12 = 1.025

			if var_217_11 < arg_214_1.time_ and arg_214_1.time_ <= var_217_11 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				local var_217_13 = arg_214_1:FormatText(StoryNameCfg[332].name)

				arg_214_1.leftNameTxt_.text = var_217_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_14 = arg_214_1:GetWordFromCfg(116381050)
				local var_217_15 = arg_214_1:FormatText(var_217_14.content)

				arg_214_1.text_.text = var_217_15

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_16 = 41
				local var_217_17 = utf8.len(var_217_15)
				local var_217_18 = var_217_16 <= 0 and var_217_12 or var_217_12 * (var_217_17 / var_217_16)

				if var_217_18 > 0 and var_217_12 < var_217_18 then
					arg_214_1.talkMaxDuration = var_217_18

					if var_217_18 + var_217_11 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_18 + var_217_11
					end
				end

				arg_214_1.text_.text = var_217_15
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381050", "story_v_out_116381.awb") ~= 0 then
					local var_217_19 = manager.audio:GetVoiceLength("story_v_out_116381", "116381050", "story_v_out_116381.awb") / 1000

					if var_217_19 + var_217_11 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_19 + var_217_11
					end

					if var_217_14.prefab_name ~= "" and arg_214_1.actors_[var_217_14.prefab_name] ~= nil then
						local var_217_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_14.prefab_name].transform, "story_v_out_116381", "116381050", "story_v_out_116381.awb")

						arg_214_1:RecordAudio("116381050", var_217_20)
						arg_214_1:RecordAudio("116381050", var_217_20)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_116381", "116381050", "story_v_out_116381.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_116381", "116381050", "story_v_out_116381.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_21 = math.max(var_217_12, arg_214_1.talkMaxDuration)

			if var_217_11 <= arg_214_1.time_ and arg_214_1.time_ < var_217_11 + var_217_21 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_11) / var_217_21

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_11 + var_217_21 and arg_214_1.time_ < var_217_11 + var_217_21 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_214_1:InitPlayNodeList()
	end,
	Play116381051 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 116381051
		arg_218_1.duration_ = 6.33

		local var_218_0 = {
			zh = 5.1,
			ja = 6.333
		}
		local var_218_1 = manager.audio:GetLocalizationFlag()

		if var_218_0[var_218_1] ~= nil then
			arg_218_1.duration_ = var_218_0[var_218_1]
		end

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play116381052(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = arg_218_1.actors_["10024ui_story"].transform
			local var_221_1 = 0

			if var_221_1 < arg_218_1.time_ and arg_218_1.time_ <= var_221_1 + arg_221_0 then
				arg_218_1.var_.moveOldPos10024ui_story = var_221_0.localPosition
			end

			local var_221_2 = 0.001

			if var_221_1 <= arg_218_1.time_ and arg_218_1.time_ < var_221_1 + var_221_2 then
				local var_221_3 = (arg_218_1.time_ - var_221_1) / var_221_2
				local var_221_4 = Vector3.New(0, 100, 0)

				var_221_0.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos10024ui_story, var_221_4, var_221_3)

				local var_221_5 = manager.ui.mainCamera.transform.position - var_221_0.position

				var_221_0.forward = Vector3.New(var_221_5.x, var_221_5.y, var_221_5.z)

				local var_221_6 = var_221_0.localEulerAngles

				var_221_6.z = 0
				var_221_6.x = 0
				var_221_0.localEulerAngles = var_221_6
			end

			if arg_218_1.time_ >= var_221_1 + var_221_2 and arg_218_1.time_ < var_221_1 + var_221_2 + arg_221_0 then
				var_221_0.localPosition = Vector3.New(0, 100, 0)

				local var_221_7 = manager.ui.mainCamera.transform.position - var_221_0.position

				var_221_0.forward = Vector3.New(var_221_7.x, var_221_7.y, var_221_7.z)

				local var_221_8 = var_221_0.localEulerAngles

				var_221_8.z = 0
				var_221_8.x = 0
				var_221_0.localEulerAngles = var_221_8
			end

			local var_221_9 = 0
			local var_221_10 = 0.35

			if var_221_9 < arg_218_1.time_ and arg_218_1.time_ <= var_221_9 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, false)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_11 = arg_218_1:GetWordFromCfg(116381051)
				local var_221_12 = arg_218_1:FormatText(var_221_11.content)

				arg_218_1.text_.text = var_221_12

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_13 = 14
				local var_221_14 = utf8.len(var_221_12)
				local var_221_15 = var_221_13 <= 0 and var_221_10 or var_221_10 * (var_221_14 / var_221_13)

				if var_221_15 > 0 and var_221_10 < var_221_15 then
					arg_218_1.talkMaxDuration = var_221_15

					if var_221_15 + var_221_9 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_15 + var_221_9
					end
				end

				arg_218_1.text_.text = var_221_12
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381051", "story_v_out_116381.awb") ~= 0 then
					local var_221_16 = manager.audio:GetVoiceLength("story_v_out_116381", "116381051", "story_v_out_116381.awb") / 1000

					if var_221_16 + var_221_9 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_16 + var_221_9
					end

					if var_221_11.prefab_name ~= "" and arg_218_1.actors_[var_221_11.prefab_name] ~= nil then
						local var_221_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_11.prefab_name].transform, "story_v_out_116381", "116381051", "story_v_out_116381.awb")

						arg_218_1:RecordAudio("116381051", var_221_17)
						arg_218_1:RecordAudio("116381051", var_221_17)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_116381", "116381051", "story_v_out_116381.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_116381", "116381051", "story_v_out_116381.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_18 = math.max(var_221_10, arg_218_1.talkMaxDuration)

			if var_221_9 <= arg_218_1.time_ and arg_218_1.time_ < var_221_9 + var_221_18 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_9) / var_221_18

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_9 + var_221_18 and arg_218_1.time_ < var_221_9 + var_221_18 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_218_1:InitPlayNodeList()
	end,
	Play116381052 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 116381052
		arg_222_1.duration_ = 9.83

		local var_222_0 = {
			zh = 9.833,
			ja = 5
		}
		local var_222_1 = manager.audio:GetLocalizationFlag()

		if var_222_0[var_222_1] ~= nil then
			arg_222_1.duration_ = var_222_0[var_222_1]
		end

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play116381053(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = 0
			local var_225_1 = 0.725

			if var_225_0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_0 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, false)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_2 = arg_222_1:GetWordFromCfg(116381052)
				local var_225_3 = arg_222_1:FormatText(var_225_2.content)

				arg_222_1.text_.text = var_225_3

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_4 = 29
				local var_225_5 = utf8.len(var_225_3)
				local var_225_6 = var_225_4 <= 0 and var_225_1 or var_225_1 * (var_225_5 / var_225_4)

				if var_225_6 > 0 and var_225_1 < var_225_6 then
					arg_222_1.talkMaxDuration = var_225_6

					if var_225_6 + var_225_0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_6 + var_225_0
					end
				end

				arg_222_1.text_.text = var_225_3
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381052", "story_v_out_116381.awb") ~= 0 then
					local var_225_7 = manager.audio:GetVoiceLength("story_v_out_116381", "116381052", "story_v_out_116381.awb") / 1000

					if var_225_7 + var_225_0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_7 + var_225_0
					end

					if var_225_2.prefab_name ~= "" and arg_222_1.actors_[var_225_2.prefab_name] ~= nil then
						local var_225_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_2.prefab_name].transform, "story_v_out_116381", "116381052", "story_v_out_116381.awb")

						arg_222_1:RecordAudio("116381052", var_225_8)
						arg_222_1:RecordAudio("116381052", var_225_8)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_116381", "116381052", "story_v_out_116381.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_116381", "116381052", "story_v_out_116381.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_9 = math.max(var_225_1, arg_222_1.talkMaxDuration)

			if var_225_0 <= arg_222_1.time_ and arg_222_1.time_ < var_225_0 + var_225_9 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_0) / var_225_9

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_0 + var_225_9 and arg_222_1.time_ < var_225_0 + var_225_9 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play116381053 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 116381053
		arg_226_1.duration_ = 5

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play116381054(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = 0
			local var_229_1 = 1.025

			if var_229_0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_0 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, false)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_2 = arg_226_1:GetWordFromCfg(116381053)
				local var_229_3 = arg_226_1:FormatText(var_229_2.content)

				arg_226_1.text_.text = var_229_3

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_4 = 41
				local var_229_5 = utf8.len(var_229_3)
				local var_229_6 = var_229_4 <= 0 and var_229_1 or var_229_1 * (var_229_5 / var_229_4)

				if var_229_6 > 0 and var_229_1 < var_229_6 then
					arg_226_1.talkMaxDuration = var_229_6

					if var_229_6 + var_229_0 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_6 + var_229_0
					end
				end

				arg_226_1.text_.text = var_229_3
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)
				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_7 = math.max(var_229_1, arg_226_1.talkMaxDuration)

			if var_229_0 <= arg_226_1.time_ and arg_226_1.time_ < var_229_0 + var_229_7 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_0) / var_229_7

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_0 + var_229_7 and arg_226_1.time_ < var_229_0 + var_229_7 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play116381054 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 116381054
		arg_230_1.duration_ = 5

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play116381055(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = 0
			local var_233_1 = 0.275

			if var_233_0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_0 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, false)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_2 = arg_230_1:GetWordFromCfg(116381054)
				local var_233_3 = arg_230_1:FormatText(var_233_2.content)

				arg_230_1.text_.text = var_233_3

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_4 = 11
				local var_233_5 = utf8.len(var_233_3)
				local var_233_6 = var_233_4 <= 0 and var_233_1 or var_233_1 * (var_233_5 / var_233_4)

				if var_233_6 > 0 and var_233_1 < var_233_6 then
					arg_230_1.talkMaxDuration = var_233_6

					if var_233_6 + var_233_0 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_6 + var_233_0
					end
				end

				arg_230_1.text_.text = var_233_3
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)
				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_7 = math.max(var_233_1, arg_230_1.talkMaxDuration)

			if var_233_0 <= arg_230_1.time_ and arg_230_1.time_ < var_233_0 + var_233_7 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_0) / var_233_7

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_0 + var_233_7 and arg_230_1.time_ < var_233_0 + var_233_7 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play116381055 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 116381055
		arg_234_1.duration_ = 5

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play116381056(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = 0
			local var_237_1 = 0.1

			if var_237_0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_0 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, false)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_2 = arg_234_1:GetWordFromCfg(116381055)
				local var_237_3 = arg_234_1:FormatText(var_237_2.content)

				arg_234_1.text_.text = var_237_3

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_4 = 4
				local var_237_5 = utf8.len(var_237_3)
				local var_237_6 = var_237_4 <= 0 and var_237_1 or var_237_1 * (var_237_5 / var_237_4)

				if var_237_6 > 0 and var_237_1 < var_237_6 then
					arg_234_1.talkMaxDuration = var_237_6

					if var_237_6 + var_237_0 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_6 + var_237_0
					end
				end

				arg_234_1.text_.text = var_237_3
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)
				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_7 = math.max(var_237_1, arg_234_1.talkMaxDuration)

			if var_237_0 <= arg_234_1.time_ and arg_234_1.time_ < var_237_0 + var_237_7 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_0) / var_237_7

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_0 + var_237_7 and arg_234_1.time_ < var_237_0 + var_237_7 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play116381056 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 116381056
		arg_238_1.duration_ = 5

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play116381057(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = 0
			local var_241_1 = 0.175

			if var_241_0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_0 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				local var_241_2 = arg_238_1:FormatText(StoryNameCfg[344].name)

				arg_238_1.leftNameTxt_.text = var_241_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_3 = arg_238_1:GetWordFromCfg(116381056)
				local var_241_4 = arg_238_1:FormatText(var_241_3.content)

				arg_238_1.text_.text = var_241_4

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_5 = 7
				local var_241_6 = utf8.len(var_241_4)
				local var_241_7 = var_241_5 <= 0 and var_241_1 or var_241_1 * (var_241_6 / var_241_5)

				if var_241_7 > 0 and var_241_1 < var_241_7 then
					arg_238_1.talkMaxDuration = var_241_7

					if var_241_7 + var_241_0 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_7 + var_241_0
					end
				end

				arg_238_1.text_.text = var_241_4
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)
				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_8 = math.max(var_241_1, arg_238_1.talkMaxDuration)

			if var_241_0 <= arg_238_1.time_ and arg_238_1.time_ < var_241_0 + var_241_8 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_0) / var_241_8

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_0 + var_241_8 and arg_238_1.time_ < var_241_0 + var_241_8 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play116381057 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 116381057
		arg_242_1.duration_ = 5

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play116381058(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			local var_245_0 = 0
			local var_245_1 = 1.05

			if var_245_0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_0 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, false)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_2 = arg_242_1:GetWordFromCfg(116381057)
				local var_245_3 = arg_242_1:FormatText(var_245_2.content)

				arg_242_1.text_.text = var_245_3

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_4 = 42
				local var_245_5 = utf8.len(var_245_3)
				local var_245_6 = var_245_4 <= 0 and var_245_1 or var_245_1 * (var_245_5 / var_245_4)

				if var_245_6 > 0 and var_245_1 < var_245_6 then
					arg_242_1.talkMaxDuration = var_245_6

					if var_245_6 + var_245_0 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_6 + var_245_0
					end
				end

				arg_242_1.text_.text = var_245_3
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)
				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_7 = math.max(var_245_1, arg_242_1.talkMaxDuration)

			if var_245_0 <= arg_242_1.time_ and arg_242_1.time_ < var_245_0 + var_245_7 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_0) / var_245_7

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_0 + var_245_7 and arg_242_1.time_ < var_245_0 + var_245_7 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {}

		arg_242_1:InitPlayNodeList()
	end,
	Play116381058 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 116381058
		arg_246_1.duration_ = 5

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play116381059(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = 0
			local var_249_1 = 1.05

			if var_249_0 < arg_246_1.time_ and arg_246_1.time_ <= var_249_0 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, false)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_2 = arg_246_1:GetWordFromCfg(116381058)
				local var_249_3 = arg_246_1:FormatText(var_249_2.content)

				arg_246_1.text_.text = var_249_3

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_4 = 42
				local var_249_5 = utf8.len(var_249_3)
				local var_249_6 = var_249_4 <= 0 and var_249_1 or var_249_1 * (var_249_5 / var_249_4)

				if var_249_6 > 0 and var_249_1 < var_249_6 then
					arg_246_1.talkMaxDuration = var_249_6

					if var_249_6 + var_249_0 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_6 + var_249_0
					end
				end

				arg_246_1.text_.text = var_249_3
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)
				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_7 = math.max(var_249_1, arg_246_1.talkMaxDuration)

			if var_249_0 <= arg_246_1.time_ and arg_246_1.time_ < var_249_0 + var_249_7 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_0) / var_249_7

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_0 + var_249_7 and arg_246_1.time_ < var_249_0 + var_249_7 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play116381059 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 116381059
		arg_250_1.duration_ = 8.87

		local var_250_0 = {
			zh = 8.3,
			ja = 8.866
		}
		local var_250_1 = manager.audio:GetLocalizationFlag()

		if var_250_0[var_250_1] ~= nil then
			arg_250_1.duration_ = var_250_0[var_250_1]
		end

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play116381060(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = 0
			local var_253_1 = 0.625

			if var_253_0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_0 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				local var_253_2 = arg_250_1:FormatText(StoryNameCfg[328].name)

				arg_250_1.leftNameTxt_.text = var_253_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, true)
				arg_250_1.iconController_:SetSelectedState("hero")

				arg_250_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10025")

				arg_250_1.callingController_:SetSelectedState("normal")

				arg_250_1.keyicon_.color = Color.New(1, 1, 1)
				arg_250_1.icon_.color = Color.New(1, 1, 1)

				local var_253_3 = arg_250_1:GetWordFromCfg(116381059)
				local var_253_4 = arg_250_1:FormatText(var_253_3.content)

				arg_250_1.text_.text = var_253_4

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_5 = 20
				local var_253_6 = utf8.len(var_253_4)
				local var_253_7 = var_253_5 <= 0 and var_253_1 or var_253_1 * (var_253_6 / var_253_5)

				if var_253_7 > 0 and var_253_1 < var_253_7 then
					arg_250_1.talkMaxDuration = var_253_7

					if var_253_7 + var_253_0 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_7 + var_253_0
					end
				end

				arg_250_1.text_.text = var_253_4
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381059", "story_v_out_116381.awb") ~= 0 then
					local var_253_8 = manager.audio:GetVoiceLength("story_v_out_116381", "116381059", "story_v_out_116381.awb") / 1000

					if var_253_8 + var_253_0 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_8 + var_253_0
					end

					if var_253_3.prefab_name ~= "" and arg_250_1.actors_[var_253_3.prefab_name] ~= nil then
						local var_253_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_3.prefab_name].transform, "story_v_out_116381", "116381059", "story_v_out_116381.awb")

						arg_250_1:RecordAudio("116381059", var_253_9)
						arg_250_1:RecordAudio("116381059", var_253_9)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_out_116381", "116381059", "story_v_out_116381.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_out_116381", "116381059", "story_v_out_116381.awb")
				end

				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_10 = math.max(var_253_1, arg_250_1.talkMaxDuration)

			if var_253_0 <= arg_250_1.time_ and arg_250_1.time_ < var_253_0 + var_253_10 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_0) / var_253_10

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_0 + var_253_10 and arg_250_1.time_ < var_253_0 + var_253_10 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play116381060 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 116381060
		arg_254_1.duration_ = 5

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play116381061(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = 0
			local var_257_1 = 0.2

			if var_257_0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_0 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				local var_257_2 = arg_254_1:FormatText(StoryNameCfg[344].name)

				arg_254_1.leftNameTxt_.text = var_257_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_3 = arg_254_1:GetWordFromCfg(116381060)
				local var_257_4 = arg_254_1:FormatText(var_257_3.content)

				arg_254_1.text_.text = var_257_4

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_5 = 8
				local var_257_6 = utf8.len(var_257_4)
				local var_257_7 = var_257_5 <= 0 and var_257_1 or var_257_1 * (var_257_6 / var_257_5)

				if var_257_7 > 0 and var_257_1 < var_257_7 then
					arg_254_1.talkMaxDuration = var_257_7

					if var_257_7 + var_257_0 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_7 + var_257_0
					end
				end

				arg_254_1.text_.text = var_257_4
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)
				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_8 = math.max(var_257_1, arg_254_1.talkMaxDuration)

			if var_257_0 <= arg_254_1.time_ and arg_254_1.time_ < var_257_0 + var_257_8 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_0) / var_257_8

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_0 + var_257_8 and arg_254_1.time_ < var_257_0 + var_257_8 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play116381061 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 116381061
		arg_258_1.duration_ = 7.33

		local var_258_0 = {
			zh = 3.866,
			ja = 7.333
		}
		local var_258_1 = manager.audio:GetLocalizationFlag()

		if var_258_0[var_258_1] ~= nil then
			arg_258_1.duration_ = var_258_0[var_258_1]
		end

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play116381062(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = 0
			local var_261_1 = 0.325

			if var_261_0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_0 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				local var_261_2 = arg_258_1:FormatText(StoryNameCfg[328].name)

				arg_258_1.leftNameTxt_.text = var_261_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, true)
				arg_258_1.iconController_:SetSelectedState("hero")

				arg_258_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10025")

				arg_258_1.callingController_:SetSelectedState("normal")

				arg_258_1.keyicon_.color = Color.New(1, 1, 1)
				arg_258_1.icon_.color = Color.New(1, 1, 1)

				local var_261_3 = arg_258_1:GetWordFromCfg(116381061)
				local var_261_4 = arg_258_1:FormatText(var_261_3.content)

				arg_258_1.text_.text = var_261_4

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_5 = 13
				local var_261_6 = utf8.len(var_261_4)
				local var_261_7 = var_261_5 <= 0 and var_261_1 or var_261_1 * (var_261_6 / var_261_5)

				if var_261_7 > 0 and var_261_1 < var_261_7 then
					arg_258_1.talkMaxDuration = var_261_7

					if var_261_7 + var_261_0 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_7 + var_261_0
					end
				end

				arg_258_1.text_.text = var_261_4
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381061", "story_v_out_116381.awb") ~= 0 then
					local var_261_8 = manager.audio:GetVoiceLength("story_v_out_116381", "116381061", "story_v_out_116381.awb") / 1000

					if var_261_8 + var_261_0 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_8 + var_261_0
					end

					if var_261_3.prefab_name ~= "" and arg_258_1.actors_[var_261_3.prefab_name] ~= nil then
						local var_261_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_3.prefab_name].transform, "story_v_out_116381", "116381061", "story_v_out_116381.awb")

						arg_258_1:RecordAudio("116381061", var_261_9)
						arg_258_1:RecordAudio("116381061", var_261_9)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_out_116381", "116381061", "story_v_out_116381.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_out_116381", "116381061", "story_v_out_116381.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_10 = math.max(var_261_1, arg_258_1.talkMaxDuration)

			if var_261_0 <= arg_258_1.time_ and arg_258_1.time_ < var_261_0 + var_261_10 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_0) / var_261_10

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_0 + var_261_10 and arg_258_1.time_ < var_261_0 + var_261_10 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play116381062 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 116381062
		arg_262_1.duration_ = 10.54

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play116381063(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = 2

			if var_265_0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_0 + arg_265_0 then
				local var_265_1 = manager.ui.mainCamera.transform.localPosition
				local var_265_2 = Vector3.New(0, 0, 10) + Vector3.New(var_265_1.x, var_265_1.y, 0)
				local var_265_3 = arg_262_1.bgs_.STblack

				var_265_3.transform.localPosition = var_265_2
				var_265_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_265_4 = var_265_3:GetComponent("SpriteRenderer")

				if var_265_4 and var_265_4.sprite then
					local var_265_5 = (var_265_3.transform.localPosition - var_265_1).z
					local var_265_6 = manager.ui.mainCameraCom_
					local var_265_7 = 2 * var_265_5 * Mathf.Tan(var_265_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_265_8 = var_265_7 * var_265_6.aspect
					local var_265_9 = var_265_4.sprite.bounds.size.x
					local var_265_10 = var_265_4.sprite.bounds.size.y
					local var_265_11 = var_265_8 / var_265_9
					local var_265_12 = var_265_7 / var_265_10
					local var_265_13 = var_265_12 < var_265_11 and var_265_11 or var_265_12

					var_265_3.transform.localScale = Vector3.New(var_265_13, var_265_13, 0)
				end

				for iter_265_0, iter_265_1 in pairs(arg_262_1.bgs_) do
					if iter_265_0 ~= "STblack" then
						iter_265_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_265_14 = 2

			if var_265_14 < arg_262_1.time_ and arg_262_1.time_ <= var_265_14 + arg_265_0 then
				arg_262_1.fswbg_:SetActive(true)
				arg_262_1.dialog_:SetActive(false)

				arg_262_1.fswtw_.percent = 0

				local var_265_15 = arg_262_1:GetWordFromCfg(116381062)
				local var_265_16 = arg_262_1:FormatText(var_265_15.content)

				arg_262_1.fswt_.text = var_265_16

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.fswt_)

				arg_262_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_262_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_262_1.fswtw_:SetDirty()

				arg_262_1.typewritterCharCountI18N = 0

				SetActive(arg_262_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_262_1:ShowNextGo(false)
			end

			local var_265_17 = 2.01666666666667

			if var_265_17 < arg_262_1.time_ and arg_262_1.time_ <= var_265_17 + arg_265_0 then
				arg_262_1.var_.oldValueTypewriter = arg_262_1.fswtw_.percent

				SetActive(arg_262_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_262_1:ShowNextGo(false)
			end

			local var_265_18 = 44
			local var_265_19 = 2.93333333333333
			local var_265_20 = arg_262_1:GetWordFromCfg(116381062)
			local var_265_21 = arg_262_1:FormatText(var_265_20.content)
			local var_265_22, var_265_23 = arg_262_1:GetPercentByPara(var_265_21, 1)

			if var_265_17 < arg_262_1.time_ and arg_262_1.time_ <= var_265_17 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0

				local var_265_24 = var_265_18 <= 0 and var_265_19 or var_265_19 * ((var_265_23 - arg_262_1.typewritterCharCountI18N) / var_265_18)

				if var_265_24 > 0 and var_265_19 < var_265_24 then
					arg_262_1.talkMaxDuration = var_265_24

					if var_265_24 + var_265_17 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_24 + var_265_17
					end
				end
			end

			local var_265_25 = 2.93333333333333
			local var_265_26 = math.max(var_265_25, arg_262_1.talkMaxDuration)

			if var_265_17 <= arg_262_1.time_ and arg_262_1.time_ < var_265_17 + var_265_26 then
				local var_265_27 = (arg_262_1.time_ - var_265_17) / var_265_26

				arg_262_1.fswtw_.percent = Mathf.Lerp(arg_262_1.var_.oldValueTypewriter, var_265_22, var_265_27)
				arg_262_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_262_1.fswtw_:SetDirty()
			end

			if arg_262_1.time_ >= var_265_17 + var_265_26 and arg_262_1.time_ < var_265_17 + var_265_26 + arg_265_0 then
				arg_262_1.fswtw_.percent = var_265_22

				arg_262_1.fswtw_:SetDirty()
				arg_262_1:ShowNextGo(true)

				arg_262_1.typewritterCharCountI18N = var_265_23
			end

			local var_265_28 = 2
			local var_265_29 = 8.543
			local var_265_30 = manager.audio:GetVoiceLength("story_v_out_116381", "116381062", "story_v_out_116381.awb") / 1000

			if var_265_30 > 0 and var_265_29 < var_265_30 and var_265_30 + var_265_28 > arg_262_1.duration_ then
				local var_265_31 = var_265_30

				arg_262_1.duration_ = var_265_30 + var_265_28
			end

			if var_265_28 < arg_262_1.time_ and arg_262_1.time_ <= var_265_28 + arg_265_0 then
				local var_265_32 = "play"
				local var_265_33 = "voice"

				arg_262_1:AudioAction(var_265_32, var_265_33, "story_v_out_116381", "116381062", "story_v_out_116381.awb")
			end

			local var_265_34 = 2
			local var_265_35 = 0.266666666666667

			if var_265_34 < arg_262_1.time_ and arg_262_1.time_ <= var_265_34 + arg_265_0 then
				local var_265_36 = "play"
				local var_265_37 = "music"

				arg_262_1:AudioAction(var_265_36, var_265_37, "ui_battle", "ui_battle_stopbgm", "")

				local var_265_38 = ""
				local var_265_39 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_265_39 ~= "" then
					if arg_262_1.bgmTxt_.text ~= var_265_39 and arg_262_1.bgmTxt_.text ~= "" then
						if arg_262_1.bgmTxt2_.text ~= "" then
							arg_262_1.bgmTxt_.text = arg_262_1.bgmTxt2_.text
						end

						arg_262_1.bgmTxt2_.text = var_265_39

						arg_262_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_262_1.bgmTxt_.text = var_265_39
						arg_262_1.bgmTxt2_.text = var_265_39
					end

					if arg_262_1.bgmTimer then
						arg_262_1.bgmTimer:Stop()

						arg_262_1.bgmTimer = nil
					end

					if arg_262_1.settingData.show_music_name == 1 then
						arg_262_1.musicController:SetSelectedState("show")
						arg_262_1.musicAnimator_:Play("open", 0, 0)

						if arg_262_1.settingData.music_time ~= 0 then
							arg_262_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_262_1.settingData.music_time), function()
								if arg_262_1 == nil or isNil(arg_262_1.bgmTxt_) then
									return
								end

								arg_262_1.musicController:SetSelectedState("hide")
								arg_262_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_265_40 = 2.4
			local var_265_41 = 0.6

			if var_265_40 < arg_262_1.time_ and arg_262_1.time_ <= var_265_40 + arg_265_0 then
				local var_265_42 = "play"
				local var_265_43 = "music"

				arg_262_1:AudioAction(var_265_42, var_265_43, "bgm_activity_1_6_story_story", "bgm_activity_1_6_story_story", "bgm_activity_1_6_story_story.awb")

				local var_265_44 = ""

				if var_265_44 ~= "" then
					if arg_262_1.bgmTxt_.text ~= var_265_44 and arg_262_1.bgmTxt_.text ~= "" then
						if arg_262_1.bgmTxt2_.text ~= "" then
							arg_262_1.bgmTxt_.text = arg_262_1.bgmTxt2_.text
						end

						arg_262_1.bgmTxt2_.text = var_265_44

						arg_262_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_262_1.bgmTxt_.text = var_265_44
						arg_262_1.bgmTxt2_.text = var_265_44
					end

					if arg_262_1.bgmTimer then
						arg_262_1.bgmTimer:Stop()

						arg_262_1.bgmTimer = nil
					end

					if arg_262_1.settingData.show_music_name == 1 then
						arg_262_1.musicController:SetSelectedState("show")
						arg_262_1.musicAnimator_:Play("open", 0, 0)

						if arg_262_1.settingData.music_time ~= 0 then
							arg_262_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_262_1.settingData.music_time), function()
								if arg_262_1 == nil or isNil(arg_262_1.bgmTxt_) then
									return
								end

								arg_262_1.musicController:SetSelectedState("hide")
								arg_262_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_265_45 = 2.575
			local var_265_46 = 0.425

			if var_265_45 < arg_262_1.time_ and arg_262_1.time_ <= var_265_45 + arg_265_0 then
				local var_265_47 = "play"
				local var_265_48 = "music"

				arg_262_1:AudioAction(var_265_47, var_265_48, "bgm_activity_1_6_story_story", "corg", "bgm_activity_1_6_story_story.awb")

				local var_265_49 = ""
				local var_265_50 = MusicRecordCfg[96].musicName

				if var_265_50 ~= "" then
					if arg_262_1.bgmTxt_.text ~= var_265_50 and arg_262_1.bgmTxt_.text ~= "" then
						if arg_262_1.bgmTxt2_.text ~= "" then
							arg_262_1.bgmTxt_.text = arg_262_1.bgmTxt2_.text
						end

						arg_262_1.bgmTxt2_.text = var_265_50

						arg_262_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_262_1.bgmTxt_.text = var_265_50
						arg_262_1.bgmTxt2_.text = var_265_50
					end

					if arg_262_1.bgmTimer then
						arg_262_1.bgmTimer:Stop()

						arg_262_1.bgmTimer = nil
					end

					if arg_262_1.settingData.show_music_name == 1 then
						arg_262_1.musicController:SetSelectedState("show")
						arg_262_1.musicAnimator_:Play("open", 0, 0)

						if arg_262_1.settingData.music_time ~= 0 then
							arg_262_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_262_1.settingData.music_time), function()
								if arg_262_1 == nil or isNil(arg_262_1.bgmTxt_) then
									return
								end

								arg_262_1.musicController:SetSelectedState("hide")
								arg_262_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_265_51 = 0

			if var_265_51 < arg_262_1.time_ and arg_262_1.time_ <= var_265_51 + arg_265_0 then
				arg_262_1.mask_.enabled = true
				arg_262_1.mask_.raycastTarget = true

				arg_262_1:SetGaussion(false)
			end

			local var_265_52 = 2

			if var_265_51 <= arg_262_1.time_ and arg_262_1.time_ < var_265_51 + var_265_52 then
				local var_265_53 = (arg_262_1.time_ - var_265_51) / var_265_52
				local var_265_54 = Color.New(0, 0, 0)

				var_265_54.a = Mathf.Lerp(0, 1, var_265_53)
				arg_262_1.mask_.color = var_265_54
			end

			if arg_262_1.time_ >= var_265_51 + var_265_52 and arg_262_1.time_ < var_265_51 + var_265_52 + arg_265_0 then
				local var_265_55 = Color.New(0, 0, 0)

				var_265_55.a = 1
				arg_262_1.mask_.color = var_265_55
			end

			local var_265_56 = 2

			if var_265_56 < arg_262_1.time_ and arg_262_1.time_ <= var_265_56 + arg_265_0 then
				arg_262_1.mask_.enabled = true
				arg_262_1.mask_.raycastTarget = true

				arg_262_1:SetGaussion(false)
			end

			local var_265_57 = 2

			if var_265_56 <= arg_262_1.time_ and arg_262_1.time_ < var_265_56 + var_265_57 then
				local var_265_58 = (arg_262_1.time_ - var_265_56) / var_265_57
				local var_265_59 = Color.New(0, 0, 0)

				var_265_59.a = Mathf.Lerp(1, 0, var_265_58)
				arg_262_1.mask_.color = var_265_59
			end

			if arg_262_1.time_ >= var_265_56 + var_265_57 and arg_262_1.time_ < var_265_56 + var_265_57 + arg_265_0 then
				local var_265_60 = Color.New(0, 0, 0)
				local var_265_61 = 0

				arg_262_1.mask_.enabled = false
				var_265_60.a = var_265_61
				arg_262_1.mask_.color = var_265_60
			end

			local var_265_62 = 2

			if var_265_62 < arg_262_1.time_ and arg_262_1.time_ <= var_265_62 + arg_265_0 then
				arg_262_1.allBtn_.enabled = false
			end

			local var_265_63 = 2.95

			if arg_262_1.time_ >= var_265_62 + var_265_63 and arg_262_1.time_ < var_265_62 + var_265_63 + arg_265_0 then
				arg_262_1.allBtn_.enabled = true
			end

			local var_265_64 = 1.96666666666667

			arg_262_1.isInRecall_ = false

			if var_265_64 < arg_262_1.time_ and arg_262_1.time_ <= var_265_64 + arg_265_0 then
				arg_262_1.screenFilterGo_:SetActive(false)

				for iter_265_2, iter_265_3 in pairs(arg_262_1.actors_) do
					local var_265_65 = iter_265_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_265_4, iter_265_5 in ipairs(var_265_65) do
						if iter_265_5.color.r > 0.51 then
							iter_265_5.color = Color.New(1, 1, 1)
						else
							iter_265_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_265_66 = 0.0333333333333332

			if var_265_64 <= arg_262_1.time_ and arg_262_1.time_ < var_265_64 + var_265_66 then
				local var_265_67 = (arg_262_1.time_ - var_265_64) / var_265_66

				arg_262_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_265_67)
			end

			if arg_262_1.time_ >= var_265_64 + var_265_66 and arg_262_1.time_ < var_265_64 + var_265_66 + arg_265_0 then
				arg_262_1.screenFilterEffect_.weight = 0
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play116381063 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 116381063
		arg_269_1.duration_ = 8.08

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play116381064(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = 0

			if var_272_0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_0 + arg_272_0 then
				arg_269_1.var_.oldValueTypewriter = arg_269_1.fswtw_.percent

				SetActive(arg_269_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_269_1:ShowNextGo(false)
			end

			local var_272_1 = 26
			local var_272_2 = 1.73333333333333
			local var_272_3 = arg_269_1:GetWordFromCfg(116381062)
			local var_272_4 = arg_269_1:FormatText(var_272_3.content)
			local var_272_5, var_272_6 = arg_269_1:GetPercentByPara(var_272_4, 2)

			if var_272_0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_0 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0

				local var_272_7 = var_272_1 <= 0 and var_272_2 or var_272_2 * ((var_272_6 - arg_269_1.typewritterCharCountI18N) / var_272_1)

				if var_272_7 > 0 and var_272_2 < var_272_7 then
					arg_269_1.talkMaxDuration = var_272_7

					if var_272_7 + var_272_0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_7 + var_272_0
					end
				end
			end

			local var_272_8 = 1.73333333333333
			local var_272_9 = math.max(var_272_8, arg_269_1.talkMaxDuration)

			if var_272_0 <= arg_269_1.time_ and arg_269_1.time_ < var_272_0 + var_272_9 then
				local var_272_10 = (arg_269_1.time_ - var_272_0) / var_272_9

				arg_269_1.fswtw_.percent = Mathf.Lerp(arg_269_1.var_.oldValueTypewriter, var_272_5, var_272_10)
				arg_269_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_269_1.fswtw_:SetDirty()
			end

			if arg_269_1.time_ >= var_272_0 + var_272_9 and arg_269_1.time_ < var_272_0 + var_272_9 + arg_272_0 then
				arg_269_1.fswtw_.percent = var_272_5

				arg_269_1.fswtw_:SetDirty()
				arg_269_1:ShowNextGo(true)

				arg_269_1.typewritterCharCountI18N = var_272_6
			end

			local var_272_11 = 0
			local var_272_12 = 8.082
			local var_272_13 = manager.audio:GetVoiceLength("story_v_out_116381", "116381063", "story_v_out_116381.awb") / 1000

			if var_272_13 > 0 and var_272_12 < var_272_13 and var_272_13 + var_272_11 > arg_269_1.duration_ then
				local var_272_14 = var_272_13

				arg_269_1.duration_ = var_272_13 + var_272_11
			end

			if var_272_11 < arg_269_1.time_ and arg_269_1.time_ <= var_272_11 + arg_272_0 then
				local var_272_15 = "play"
				local var_272_16 = "voice"

				arg_269_1:AudioAction(var_272_15, var_272_16, "story_v_out_116381", "116381063", "story_v_out_116381.awb")
			end

			local var_272_17 = 0

			if var_272_17 < arg_269_1.time_ and arg_269_1.time_ <= var_272_17 + arg_272_0 then
				arg_269_1.allBtn_.enabled = false
			end

			local var_272_18 = 1.73333333333333

			if arg_269_1.time_ >= var_272_17 + var_272_18 and arg_269_1.time_ < var_272_17 + var_272_18 + arg_272_0 then
				arg_269_1.allBtn_.enabled = true
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play116381064 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 116381064
		arg_273_1.duration_ = 7.44

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play116381065(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = 0

			if var_276_0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_0 + arg_276_0 then
				arg_273_1.var_.oldValueTypewriter = arg_273_1.fswtw_.percent

				SetActive(arg_273_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_273_1:ShowNextGo(false)
			end

			local var_276_1 = 34
			local var_276_2 = 2.26666666666667
			local var_276_3 = arg_273_1:GetWordFromCfg(116381062)
			local var_276_4 = arg_273_1:FormatText(var_276_3.content)
			local var_276_5, var_276_6 = arg_273_1:GetPercentByPara(var_276_4, 3)

			if var_276_0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_0 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0

				local var_276_7 = var_276_1 <= 0 and var_276_2 or var_276_2 * ((var_276_6 - arg_273_1.typewritterCharCountI18N) / var_276_1)

				if var_276_7 > 0 and var_276_2 < var_276_7 then
					arg_273_1.talkMaxDuration = var_276_7

					if var_276_7 + var_276_0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_7 + var_276_0
					end
				end
			end

			local var_276_8 = 2.26666666666667
			local var_276_9 = math.max(var_276_8, arg_273_1.talkMaxDuration)

			if var_276_0 <= arg_273_1.time_ and arg_273_1.time_ < var_276_0 + var_276_9 then
				local var_276_10 = (arg_273_1.time_ - var_276_0) / var_276_9

				arg_273_1.fswtw_.percent = Mathf.Lerp(arg_273_1.var_.oldValueTypewriter, var_276_5, var_276_10)
				arg_273_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_273_1.fswtw_:SetDirty()
			end

			if arg_273_1.time_ >= var_276_0 + var_276_9 and arg_273_1.time_ < var_276_0 + var_276_9 + arg_276_0 then
				arg_273_1.fswtw_.percent = var_276_5

				arg_273_1.fswtw_:SetDirty()
				arg_273_1:ShowNextGo(true)

				arg_273_1.typewritterCharCountI18N = var_276_6
			end

			local var_276_11 = 0
			local var_276_12 = 7.438
			local var_276_13 = manager.audio:GetVoiceLength("story_v_out_116381", "116381064", "story_v_out_116381.awb") / 1000

			if var_276_13 > 0 and var_276_12 < var_276_13 and var_276_13 + var_276_11 > arg_273_1.duration_ then
				local var_276_14 = var_276_13

				arg_273_1.duration_ = var_276_13 + var_276_11
			end

			if var_276_11 < arg_273_1.time_ and arg_273_1.time_ <= var_276_11 + arg_276_0 then
				local var_276_15 = "play"
				local var_276_16 = "voice"

				arg_273_1:AudioAction(var_276_15, var_276_16, "story_v_out_116381", "116381064", "story_v_out_116381.awb")
			end

			local var_276_17 = 0

			if var_276_17 < arg_273_1.time_ and arg_273_1.time_ <= var_276_17 + arg_276_0 then
				arg_273_1.allBtn_.enabled = false
			end

			local var_276_18 = 2.26666666666667

			if arg_273_1.time_ >= var_276_17 + var_276_18 and arg_273_1.time_ < var_276_17 + var_276_18 + arg_276_0 then
				arg_273_1.allBtn_.enabled = true
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play116381065 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 116381065
		arg_277_1.duration_ = 5.85

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play116381066(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 0

			if var_280_0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_0 + arg_280_0 then
				arg_277_1.var_.oldValueTypewriter = arg_277_1.fswtw_.percent

				SetActive(arg_277_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_277_1:ShowNextGo(false)
			end

			local var_280_1 = 26
			local var_280_2 = 1.73333333333333
			local var_280_3 = arg_277_1:GetWordFromCfg(116381062)
			local var_280_4 = arg_277_1:FormatText(var_280_3.content)
			local var_280_5, var_280_6 = arg_277_1:GetPercentByPara(var_280_4, 4)

			if var_280_0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0

				local var_280_7 = var_280_1 <= 0 and var_280_2 or var_280_2 * ((var_280_6 - arg_277_1.typewritterCharCountI18N) / var_280_1)

				if var_280_7 > 0 and var_280_2 < var_280_7 then
					arg_277_1.talkMaxDuration = var_280_7

					if var_280_7 + var_280_0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_7 + var_280_0
					end
				end
			end

			local var_280_8 = 1.73333333333333
			local var_280_9 = math.max(var_280_8, arg_277_1.talkMaxDuration)

			if var_280_0 <= arg_277_1.time_ and arg_277_1.time_ < var_280_0 + var_280_9 then
				local var_280_10 = (arg_277_1.time_ - var_280_0) / var_280_9

				arg_277_1.fswtw_.percent = Mathf.Lerp(arg_277_1.var_.oldValueTypewriter, var_280_5, var_280_10)
				arg_277_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_277_1.fswtw_:SetDirty()
			end

			if arg_277_1.time_ >= var_280_0 + var_280_9 and arg_277_1.time_ < var_280_0 + var_280_9 + arg_280_0 then
				arg_277_1.fswtw_.percent = var_280_5

				arg_277_1.fswtw_:SetDirty()
				arg_277_1:ShowNextGo(true)

				arg_277_1.typewritterCharCountI18N = var_280_6
			end

			local var_280_11 = 0
			local var_280_12 = 5.847
			local var_280_13 = manager.audio:GetVoiceLength("story_v_out_116381", "116381065", "story_v_out_116381.awb") / 1000

			if var_280_13 > 0 and var_280_12 < var_280_13 and var_280_13 + var_280_11 > arg_277_1.duration_ then
				local var_280_14 = var_280_13

				arg_277_1.duration_ = var_280_13 + var_280_11
			end

			if var_280_11 < arg_277_1.time_ and arg_277_1.time_ <= var_280_11 + arg_280_0 then
				local var_280_15 = "play"
				local var_280_16 = "voice"

				arg_277_1:AudioAction(var_280_15, var_280_16, "story_v_out_116381", "116381065", "story_v_out_116381.awb")
			end

			local var_280_17 = 0

			if var_280_17 < arg_277_1.time_ and arg_277_1.time_ <= var_280_17 + arg_280_0 then
				arg_277_1.allBtn_.enabled = false
			end

			local var_280_18 = 1.73333333333333

			if arg_277_1.time_ >= var_280_17 + var_280_18 and arg_277_1.time_ < var_280_17 + var_280_18 + arg_280_0 then
				arg_277_1.allBtn_.enabled = true
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play116381066 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 116381066
		arg_281_1.duration_ = 1.44

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play116381067(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 0

			if var_284_0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_0 + arg_284_0 then
				arg_281_1.var_.oldValueTypewriter = arg_281_1.fswtw_.percent

				SetActive(arg_281_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_281_1:ShowNextGo(false)
			end

			local var_284_1 = 12
			local var_284_2 = 0.8
			local var_284_3 = arg_281_1:GetWordFromCfg(116381062)
			local var_284_4 = arg_281_1:FormatText(var_284_3.content)
			local var_284_5, var_284_6 = arg_281_1:GetPercentByPara(var_284_4, 5)

			if var_284_0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_0 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0

				local var_284_7 = var_284_1 <= 0 and var_284_2 or var_284_2 * ((var_284_6 - arg_281_1.typewritterCharCountI18N) / var_284_1)

				if var_284_7 > 0 and var_284_2 < var_284_7 then
					arg_281_1.talkMaxDuration = var_284_7

					if var_284_7 + var_284_0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_7 + var_284_0
					end
				end
			end

			local var_284_8 = 0.8
			local var_284_9 = math.max(var_284_8, arg_281_1.talkMaxDuration)

			if var_284_0 <= arg_281_1.time_ and arg_281_1.time_ < var_284_0 + var_284_9 then
				local var_284_10 = (arg_281_1.time_ - var_284_0) / var_284_9

				arg_281_1.fswtw_.percent = Mathf.Lerp(arg_281_1.var_.oldValueTypewriter, var_284_5, var_284_10)
				arg_281_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_281_1.fswtw_:SetDirty()
			end

			if arg_281_1.time_ >= var_284_0 + var_284_9 and arg_281_1.time_ < var_284_0 + var_284_9 + arg_284_0 then
				arg_281_1.fswtw_.percent = var_284_5

				arg_281_1.fswtw_:SetDirty()
				arg_281_1:ShowNextGo(true)

				arg_281_1.typewritterCharCountI18N = var_284_6
			end

			local var_284_11 = 0
			local var_284_12 = 1.438
			local var_284_13 = manager.audio:GetVoiceLength("story_v_out_116381", "116381066", "story_v_out_116381.awb") / 1000

			if var_284_13 > 0 and var_284_12 < var_284_13 and var_284_13 + var_284_11 > arg_281_1.duration_ then
				local var_284_14 = var_284_13

				arg_281_1.duration_ = var_284_13 + var_284_11
			end

			if var_284_11 < arg_281_1.time_ and arg_281_1.time_ <= var_284_11 + arg_284_0 then
				local var_284_15 = "play"
				local var_284_16 = "voice"

				arg_281_1:AudioAction(var_284_15, var_284_16, "story_v_out_116381", "116381066", "story_v_out_116381.awb")
			end

			local var_284_17 = 0

			if var_284_17 < arg_281_1.time_ and arg_281_1.time_ <= var_284_17 + arg_284_0 then
				arg_281_1.allBtn_.enabled = false
			end

			local var_284_18 = 0.8

			if arg_281_1.time_ >= var_284_17 + var_284_18 and arg_281_1.time_ < var_284_17 + var_284_18 + arg_284_0 then
				arg_281_1.allBtn_.enabled = true
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play116381067 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 116381067
		arg_285_1.duration_ = 7.73

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play116381068(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = 0

			if var_288_0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_0 + arg_288_0 then
				arg_285_1.var_.oldValueTypewriter = arg_285_1.fswtw_.percent

				SetActive(arg_285_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_285_1:ShowNextGo(false)
			end

			local var_288_1 = 36
			local var_288_2 = 2.4
			local var_288_3 = arg_285_1:GetWordFromCfg(116381062)
			local var_288_4 = arg_285_1:FormatText(var_288_3.content)
			local var_288_5, var_288_6 = arg_285_1:GetPercentByPara(var_288_4, 6)

			if var_288_0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_0 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0

				local var_288_7 = var_288_1 <= 0 and var_288_2 or var_288_2 * ((var_288_6 - arg_285_1.typewritterCharCountI18N) / var_288_1)

				if var_288_7 > 0 and var_288_2 < var_288_7 then
					arg_285_1.talkMaxDuration = var_288_7

					if var_288_7 + var_288_0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_7 + var_288_0
					end
				end
			end

			local var_288_8 = 2.4
			local var_288_9 = math.max(var_288_8, arg_285_1.talkMaxDuration)

			if var_288_0 <= arg_285_1.time_ and arg_285_1.time_ < var_288_0 + var_288_9 then
				local var_288_10 = (arg_285_1.time_ - var_288_0) / var_288_9

				arg_285_1.fswtw_.percent = Mathf.Lerp(arg_285_1.var_.oldValueTypewriter, var_288_5, var_288_10)
				arg_285_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_285_1.fswtw_:SetDirty()
			end

			if arg_285_1.time_ >= var_288_0 + var_288_9 and arg_285_1.time_ < var_288_0 + var_288_9 + arg_288_0 then
				arg_285_1.fswtw_.percent = var_288_5

				arg_285_1.fswtw_:SetDirty()
				arg_285_1:ShowNextGo(true)

				arg_285_1.typewritterCharCountI18N = var_288_6
			end

			local var_288_11 = 0
			local var_288_12 = 7.735
			local var_288_13 = manager.audio:GetVoiceLength("story_v_out_116381", "116381067", "story_v_out_116381.awb") / 1000

			if var_288_13 > 0 and var_288_12 < var_288_13 and var_288_13 + var_288_11 > arg_285_1.duration_ then
				local var_288_14 = var_288_13

				arg_285_1.duration_ = var_288_13 + var_288_11
			end

			if var_288_11 < arg_285_1.time_ and arg_285_1.time_ <= var_288_11 + arg_288_0 then
				local var_288_15 = "play"
				local var_288_16 = "voice"

				arg_285_1:AudioAction(var_288_15, var_288_16, "story_v_out_116381", "116381067", "story_v_out_116381.awb")
			end

			local var_288_17 = 0

			if var_288_17 < arg_285_1.time_ and arg_285_1.time_ <= var_288_17 + arg_288_0 then
				arg_285_1.allBtn_.enabled = false
			end

			local var_288_18 = 2.4

			if arg_285_1.time_ >= var_288_17 + var_288_18 and arg_285_1.time_ < var_288_17 + var_288_18 + arg_288_0 then
				arg_285_1.allBtn_.enabled = true
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play116381068 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 116381068
		arg_289_1.duration_ = 5.26

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play116381069(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = 0

			if var_292_0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_0 + arg_292_0 then
				arg_289_1.fswbg_:SetActive(true)
				arg_289_1.dialog_:SetActive(false)

				arg_289_1.fswtw_.percent = 0

				local var_292_1 = arg_289_1:GetWordFromCfg(116381068)
				local var_292_2 = arg_289_1:FormatText(var_292_1.content)

				arg_289_1.fswt_.text = var_292_2

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.fswt_)

				arg_289_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_289_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_289_1.fswtw_:SetDirty()

				arg_289_1.typewritterCharCountI18N = 0

				SetActive(arg_289_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_289_1:ShowNextGo(false)
			end

			local var_292_3 = 0.0166666666666667

			if var_292_3 < arg_289_1.time_ and arg_289_1.time_ <= var_292_3 + arg_292_0 then
				arg_289_1.var_.oldValueTypewriter = arg_289_1.fswtw_.percent

				SetActive(arg_289_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_289_1:ShowNextGo(false)
			end

			local var_292_4 = 16
			local var_292_5 = 1.06666666666667
			local var_292_6 = arg_289_1:GetWordFromCfg(116381068)
			local var_292_7 = arg_289_1:FormatText(var_292_6.content)
			local var_292_8, var_292_9 = arg_289_1:GetPercentByPara(var_292_7, 1)

			if var_292_3 < arg_289_1.time_ and arg_289_1.time_ <= var_292_3 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0

				local var_292_10 = var_292_4 <= 0 and var_292_5 or var_292_5 * ((var_292_9 - arg_289_1.typewritterCharCountI18N) / var_292_4)

				if var_292_10 > 0 and var_292_5 < var_292_10 then
					arg_289_1.talkMaxDuration = var_292_10

					if var_292_10 + var_292_3 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_10 + var_292_3
					end
				end
			end

			local var_292_11 = 1.06666666666667
			local var_292_12 = math.max(var_292_11, arg_289_1.talkMaxDuration)

			if var_292_3 <= arg_289_1.time_ and arg_289_1.time_ < var_292_3 + var_292_12 then
				local var_292_13 = (arg_289_1.time_ - var_292_3) / var_292_12

				arg_289_1.fswtw_.percent = Mathf.Lerp(arg_289_1.var_.oldValueTypewriter, var_292_8, var_292_13)
				arg_289_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_289_1.fswtw_:SetDirty()
			end

			if arg_289_1.time_ >= var_292_3 + var_292_12 and arg_289_1.time_ < var_292_3 + var_292_12 + arg_292_0 then
				arg_289_1.fswtw_.percent = var_292_8

				arg_289_1.fswtw_:SetDirty()
				arg_289_1:ShowNextGo(true)

				arg_289_1.typewritterCharCountI18N = var_292_9
			end

			local var_292_14 = 0
			local var_292_15 = 5.257
			local var_292_16 = manager.audio:GetVoiceLength("story_v_out_116381", "116381068", "story_v_out_116381.awb") / 1000

			if var_292_16 > 0 and var_292_15 < var_292_16 and var_292_16 + var_292_14 > arg_289_1.duration_ then
				local var_292_17 = var_292_16

				arg_289_1.duration_ = var_292_16 + var_292_14
			end

			if var_292_14 < arg_289_1.time_ and arg_289_1.time_ <= var_292_14 + arg_292_0 then
				local var_292_18 = "play"
				local var_292_19 = "voice"

				arg_289_1:AudioAction(var_292_18, var_292_19, "story_v_out_116381", "116381068", "story_v_out_116381.awb")
			end

			local var_292_20 = 0

			if var_292_20 < arg_289_1.time_ and arg_289_1.time_ <= var_292_20 + arg_292_0 then
				arg_289_1.allBtn_.enabled = false
			end

			local var_292_21 = 1.08333333333333

			if arg_289_1.time_ >= var_292_20 + var_292_21 and arg_289_1.time_ < var_292_20 + var_292_21 + arg_292_0 then
				arg_289_1.allBtn_.enabled = true
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play116381069 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 116381069
		arg_293_1.duration_ = 0.75

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play116381070(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = 0

			if var_296_0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_0 + arg_296_0 then
				arg_293_1.var_.oldValueTypewriter = arg_293_1.fswtw_.percent

				SetActive(arg_293_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_293_1:ShowNextGo(false)
			end

			local var_296_1 = 7
			local var_296_2 = 0.466666666666667
			local var_296_3 = arg_293_1:GetWordFromCfg(116381068)
			local var_296_4 = arg_293_1:FormatText(var_296_3.content)
			local var_296_5, var_296_6 = arg_293_1:GetPercentByPara(var_296_4, 2)

			if var_296_0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_0 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0

				local var_296_7 = var_296_1 <= 0 and var_296_2 or var_296_2 * ((var_296_6 - arg_293_1.typewritterCharCountI18N) / var_296_1)

				if var_296_7 > 0 and var_296_2 < var_296_7 then
					arg_293_1.talkMaxDuration = var_296_7

					if var_296_7 + var_296_0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_7 + var_296_0
					end
				end
			end

			local var_296_8 = 0.466666666666667
			local var_296_9 = math.max(var_296_8, arg_293_1.talkMaxDuration)

			if var_296_0 <= arg_293_1.time_ and arg_293_1.time_ < var_296_0 + var_296_9 then
				local var_296_10 = (arg_293_1.time_ - var_296_0) / var_296_9

				arg_293_1.fswtw_.percent = Mathf.Lerp(arg_293_1.var_.oldValueTypewriter, var_296_5, var_296_10)
				arg_293_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_293_1.fswtw_:SetDirty()
			end

			if arg_293_1.time_ >= var_296_0 + var_296_9 and arg_293_1.time_ < var_296_0 + var_296_9 + arg_296_0 then
				arg_293_1.fswtw_.percent = var_296_5

				arg_293_1.fswtw_:SetDirty()
				arg_293_1:ShowNextGo(true)

				arg_293_1.typewritterCharCountI18N = var_296_6
			end

			local var_296_11 = 0
			local var_296_12 = 0.75
			local var_296_13 = manager.audio:GetVoiceLength("story_v_out_116381", "116381069", "story_v_out_116381.awb") / 1000

			if var_296_13 > 0 and var_296_12 < var_296_13 and var_296_13 + var_296_11 > arg_293_1.duration_ then
				local var_296_14 = var_296_13

				arg_293_1.duration_ = var_296_13 + var_296_11
			end

			if var_296_11 < arg_293_1.time_ and arg_293_1.time_ <= var_296_11 + arg_296_0 then
				local var_296_15 = "play"
				local var_296_16 = "voice"

				arg_293_1:AudioAction(var_296_15, var_296_16, "story_v_out_116381", "116381069", "story_v_out_116381.awb")
			end

			local var_296_17 = 0

			if var_296_17 < arg_293_1.time_ and arg_293_1.time_ <= var_296_17 + arg_296_0 then
				arg_293_1.allBtn_.enabled = false
			end

			local var_296_18 = 0.466666666666667

			if arg_293_1.time_ >= var_296_17 + var_296_18 and arg_293_1.time_ < var_296_17 + var_296_18 + arg_296_0 then
				arg_293_1.allBtn_.enabled = true
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play116381070 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 116381070
		arg_297_1.duration_ = 3.3

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play116381071(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = 0

			if var_300_0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_0 + arg_300_0 then
				arg_297_1.var_.oldValueTypewriter = arg_297_1.fswtw_.percent

				SetActive(arg_297_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_297_1:ShowNextGo(false)
			end

			local var_300_1 = 19
			local var_300_2 = 1.26666666666667
			local var_300_3 = arg_297_1:GetWordFromCfg(116381068)
			local var_300_4 = arg_297_1:FormatText(var_300_3.content)
			local var_300_5, var_300_6 = arg_297_1:GetPercentByPara(var_300_4, 3)

			if var_300_0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_0 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0

				local var_300_7 = var_300_1 <= 0 and var_300_2 or var_300_2 * ((var_300_6 - arg_297_1.typewritterCharCountI18N) / var_300_1)

				if var_300_7 > 0 and var_300_2 < var_300_7 then
					arg_297_1.talkMaxDuration = var_300_7

					if var_300_7 + var_300_0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_7 + var_300_0
					end
				end
			end

			local var_300_8 = 1.26666666666667
			local var_300_9 = math.max(var_300_8, arg_297_1.talkMaxDuration)

			if var_300_0 <= arg_297_1.time_ and arg_297_1.time_ < var_300_0 + var_300_9 then
				local var_300_10 = (arg_297_1.time_ - var_300_0) / var_300_9

				arg_297_1.fswtw_.percent = Mathf.Lerp(arg_297_1.var_.oldValueTypewriter, var_300_5, var_300_10)
				arg_297_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_297_1.fswtw_:SetDirty()
			end

			if arg_297_1.time_ >= var_300_0 + var_300_9 and arg_297_1.time_ < var_300_0 + var_300_9 + arg_300_0 then
				arg_297_1.fswtw_.percent = var_300_5

				arg_297_1.fswtw_:SetDirty()
				arg_297_1:ShowNextGo(true)

				arg_297_1.typewritterCharCountI18N = var_300_6
			end

			local var_300_11 = 0
			local var_300_12 = 3.304
			local var_300_13 = manager.audio:GetVoiceLength("story_v_out_116381", "116381070", "story_v_out_116381.awb") / 1000

			if var_300_13 > 0 and var_300_12 < var_300_13 and var_300_13 + var_300_11 > arg_297_1.duration_ then
				local var_300_14 = var_300_13

				arg_297_1.duration_ = var_300_13 + var_300_11
			end

			if var_300_11 < arg_297_1.time_ and arg_297_1.time_ <= var_300_11 + arg_300_0 then
				local var_300_15 = "play"
				local var_300_16 = "voice"

				arg_297_1:AudioAction(var_300_15, var_300_16, "story_v_out_116381", "116381070", "story_v_out_116381.awb")
			end

			local var_300_17 = 0

			if var_300_17 < arg_297_1.time_ and arg_297_1.time_ <= var_300_17 + arg_300_0 then
				arg_297_1.allBtn_.enabled = false
			end

			local var_300_18 = 1.26666666666667

			if arg_297_1.time_ >= var_300_17 + var_300_18 and arg_297_1.time_ < var_300_17 + var_300_18 + arg_300_0 then
				arg_297_1.allBtn_.enabled = true
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play116381071 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 116381071
		arg_301_1.duration_ = 10.21

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play116381072(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = 0

			if var_304_0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_0 + arg_304_0 then
				arg_301_1.var_.oldValueTypewriter = arg_301_1.fswtw_.percent

				SetActive(arg_301_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_301_1:ShowNextGo(false)
			end

			local var_304_1 = 48
			local var_304_2 = 3.2
			local var_304_3 = arg_301_1:GetWordFromCfg(116381068)
			local var_304_4 = arg_301_1:FormatText(var_304_3.content)
			local var_304_5, var_304_6 = arg_301_1:GetPercentByPara(var_304_4, 4)

			if var_304_0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_0 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0

				local var_304_7 = var_304_1 <= 0 and var_304_2 or var_304_2 * ((var_304_6 - arg_301_1.typewritterCharCountI18N) / var_304_1)

				if var_304_7 > 0 and var_304_2 < var_304_7 then
					arg_301_1.talkMaxDuration = var_304_7

					if var_304_7 + var_304_0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_7 + var_304_0
					end
				end
			end

			local var_304_8 = 3.2
			local var_304_9 = math.max(var_304_8, arg_301_1.talkMaxDuration)

			if var_304_0 <= arg_301_1.time_ and arg_301_1.time_ < var_304_0 + var_304_9 then
				local var_304_10 = (arg_301_1.time_ - var_304_0) / var_304_9

				arg_301_1.fswtw_.percent = Mathf.Lerp(arg_301_1.var_.oldValueTypewriter, var_304_5, var_304_10)
				arg_301_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_301_1.fswtw_:SetDirty()
			end

			if arg_301_1.time_ >= var_304_0 + var_304_9 and arg_301_1.time_ < var_304_0 + var_304_9 + arg_304_0 then
				arg_301_1.fswtw_.percent = var_304_5

				arg_301_1.fswtw_:SetDirty()
				arg_301_1:ShowNextGo(true)

				arg_301_1.typewritterCharCountI18N = var_304_6
			end

			local var_304_11 = 0
			local var_304_12 = 10.214
			local var_304_13 = manager.audio:GetVoiceLength("story_v_out_116381", "116381071", "story_v_out_116381.awb") / 1000

			if var_304_13 > 0 and var_304_12 < var_304_13 and var_304_13 + var_304_11 > arg_301_1.duration_ then
				local var_304_14 = var_304_13

				arg_301_1.duration_ = var_304_13 + var_304_11
			end

			if var_304_11 < arg_301_1.time_ and arg_301_1.time_ <= var_304_11 + arg_304_0 then
				local var_304_15 = "play"
				local var_304_16 = "voice"

				arg_301_1:AudioAction(var_304_15, var_304_16, "story_v_out_116381", "116381071", "story_v_out_116381.awb")
			end

			local var_304_17 = 0

			if var_304_17 < arg_301_1.time_ and arg_301_1.time_ <= var_304_17 + arg_304_0 then
				arg_301_1.allBtn_.enabled = false
			end

			local var_304_18 = 3.2

			if arg_301_1.time_ >= var_304_17 + var_304_18 and arg_301_1.time_ < var_304_17 + var_304_18 + arg_304_0 then
				arg_301_1.allBtn_.enabled = true
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play116381072 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 116381072
		arg_305_1.duration_ = 13.12

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play116381073(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 0

			if var_308_0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_0 + arg_308_0 then
				arg_305_1.var_.oldValueTypewriter = arg_305_1.fswtw_.percent

				SetActive(arg_305_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_305_1:ShowNextGo(false)
			end

			local var_308_1 = 54
			local var_308_2 = 3.6
			local var_308_3 = arg_305_1:GetWordFromCfg(116381068)
			local var_308_4 = arg_305_1:FormatText(var_308_3.content)
			local var_308_5, var_308_6 = arg_305_1:GetPercentByPara(var_308_4, 5)

			if var_308_0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_0 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0

				local var_308_7 = var_308_1 <= 0 and var_308_2 or var_308_2 * ((var_308_6 - arg_305_1.typewritterCharCountI18N) / var_308_1)

				if var_308_7 > 0 and var_308_2 < var_308_7 then
					arg_305_1.talkMaxDuration = var_308_7

					if var_308_7 + var_308_0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_7 + var_308_0
					end
				end
			end

			local var_308_8 = 3.6
			local var_308_9 = math.max(var_308_8, arg_305_1.talkMaxDuration)

			if var_308_0 <= arg_305_1.time_ and arg_305_1.time_ < var_308_0 + var_308_9 then
				local var_308_10 = (arg_305_1.time_ - var_308_0) / var_308_9

				arg_305_1.fswtw_.percent = Mathf.Lerp(arg_305_1.var_.oldValueTypewriter, var_308_5, var_308_10)
				arg_305_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_305_1.fswtw_:SetDirty()
			end

			if arg_305_1.time_ >= var_308_0 + var_308_9 and arg_305_1.time_ < var_308_0 + var_308_9 + arg_308_0 then
				arg_305_1.fswtw_.percent = var_308_5

				arg_305_1.fswtw_:SetDirty()
				arg_305_1:ShowNextGo(true)

				arg_305_1.typewritterCharCountI18N = var_308_6
			end

			local var_308_11 = 0
			local var_308_12 = 13.122
			local var_308_13 = manager.audio:GetVoiceLength("story_v_out_116381", "116381072", "story_v_out_116381.awb") / 1000

			if var_308_13 > 0 and var_308_12 < var_308_13 and var_308_13 + var_308_11 > arg_305_1.duration_ then
				local var_308_14 = var_308_13

				arg_305_1.duration_ = var_308_13 + var_308_11
			end

			if var_308_11 < arg_305_1.time_ and arg_305_1.time_ <= var_308_11 + arg_308_0 then
				local var_308_15 = "play"
				local var_308_16 = "voice"

				arg_305_1:AudioAction(var_308_15, var_308_16, "story_v_out_116381", "116381072", "story_v_out_116381.awb")
			end

			local var_308_17 = 0

			if var_308_17 < arg_305_1.time_ and arg_305_1.time_ <= var_308_17 + arg_308_0 then
				arg_305_1.allBtn_.enabled = false
			end

			local var_308_18 = 3.6

			if arg_305_1.time_ >= var_308_17 + var_308_18 and arg_305_1.time_ < var_308_17 + var_308_18 + arg_308_0 then
				arg_305_1.allBtn_.enabled = true
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play116381073 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 116381073
		arg_309_1.duration_ = 11.52

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play116381074(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 0

			if var_312_0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_0 + arg_312_0 then
				arg_309_1.var_.oldValueTypewriter = arg_309_1.fswtw_.percent

				SetActive(arg_309_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_309_1:ShowNextGo(false)
			end

			local var_312_1 = 54
			local var_312_2 = 3.6
			local var_312_3 = arg_309_1:GetWordFromCfg(116381068)
			local var_312_4 = arg_309_1:FormatText(var_312_3.content)
			local var_312_5, var_312_6 = arg_309_1:GetPercentByPara(var_312_4, 6)

			if var_312_0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_0 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0

				local var_312_7 = var_312_1 <= 0 and var_312_2 or var_312_2 * ((var_312_6 - arg_309_1.typewritterCharCountI18N) / var_312_1)

				if var_312_7 > 0 and var_312_2 < var_312_7 then
					arg_309_1.talkMaxDuration = var_312_7

					if var_312_7 + var_312_0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_7 + var_312_0
					end
				end
			end

			local var_312_8 = 3.6
			local var_312_9 = math.max(var_312_8, arg_309_1.talkMaxDuration)

			if var_312_0 <= arg_309_1.time_ and arg_309_1.time_ < var_312_0 + var_312_9 then
				local var_312_10 = (arg_309_1.time_ - var_312_0) / var_312_9

				arg_309_1.fswtw_.percent = Mathf.Lerp(arg_309_1.var_.oldValueTypewriter, var_312_5, var_312_10)
				arg_309_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_309_1.fswtw_:SetDirty()
			end

			if arg_309_1.time_ >= var_312_0 + var_312_9 and arg_309_1.time_ < var_312_0 + var_312_9 + arg_312_0 then
				arg_309_1.fswtw_.percent = var_312_5

				arg_309_1.fswtw_:SetDirty()
				arg_309_1:ShowNextGo(true)

				arg_309_1.typewritterCharCountI18N = var_312_6
			end

			local var_312_11 = 0
			local var_312_12 = 11.523
			local var_312_13 = manager.audio:GetVoiceLength("story_v_out_116381", "116381073", "story_v_out_116381.awb") / 1000

			if var_312_13 > 0 and var_312_12 < var_312_13 and var_312_13 + var_312_11 > arg_309_1.duration_ then
				local var_312_14 = var_312_13

				arg_309_1.duration_ = var_312_13 + var_312_11
			end

			if var_312_11 < arg_309_1.time_ and arg_309_1.time_ <= var_312_11 + arg_312_0 then
				local var_312_15 = "play"
				local var_312_16 = "voice"

				arg_309_1:AudioAction(var_312_15, var_312_16, "story_v_out_116381", "116381073", "story_v_out_116381.awb")
			end

			local var_312_17 = 0

			if var_312_17 < arg_309_1.time_ and arg_309_1.time_ <= var_312_17 + arg_312_0 then
				arg_309_1.allBtn_.enabled = false
			end

			local var_312_18 = 3.6

			if arg_309_1.time_ >= var_312_17 + var_312_18 and arg_309_1.time_ < var_312_17 + var_312_18 + arg_312_0 then
				arg_309_1.allBtn_.enabled = true
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play116381074 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 116381074
		arg_313_1.duration_ = 11.03

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play116381075(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = 0

			if var_316_0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_0 + arg_316_0 then
				arg_313_1.fswbg_:SetActive(true)
				arg_313_1.dialog_:SetActive(false)

				arg_313_1.fswtw_.percent = 0

				local var_316_1 = arg_313_1:GetWordFromCfg(116381074)
				local var_316_2 = arg_313_1:FormatText(var_316_1.content)

				arg_313_1.fswt_.text = var_316_2

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.fswt_)

				arg_313_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_313_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_313_1.fswtw_:SetDirty()

				arg_313_1.typewritterCharCountI18N = 0

				SetActive(arg_313_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_313_1:ShowNextGo(false)
			end

			local var_316_3 = 0.0166666666666667

			if var_316_3 < arg_313_1.time_ and arg_313_1.time_ <= var_316_3 + arg_316_0 then
				arg_313_1.var_.oldValueTypewriter = arg_313_1.fswtw_.percent

				SetActive(arg_313_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_313_1:ShowNextGo(false)
			end

			local var_316_4 = 43
			local var_316_5 = 2.86666666666667
			local var_316_6 = arg_313_1:GetWordFromCfg(116381074)
			local var_316_7 = arg_313_1:FormatText(var_316_6.content)
			local var_316_8, var_316_9 = arg_313_1:GetPercentByPara(var_316_7, 1)

			if var_316_3 < arg_313_1.time_ and arg_313_1.time_ <= var_316_3 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0

				local var_316_10 = var_316_4 <= 0 and var_316_5 or var_316_5 * ((var_316_9 - arg_313_1.typewritterCharCountI18N) / var_316_4)

				if var_316_10 > 0 and var_316_5 < var_316_10 then
					arg_313_1.talkMaxDuration = var_316_10

					if var_316_10 + var_316_3 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_10 + var_316_3
					end
				end
			end

			local var_316_11 = 2.86666666666667
			local var_316_12 = math.max(var_316_11, arg_313_1.talkMaxDuration)

			if var_316_3 <= arg_313_1.time_ and arg_313_1.time_ < var_316_3 + var_316_12 then
				local var_316_13 = (arg_313_1.time_ - var_316_3) / var_316_12

				arg_313_1.fswtw_.percent = Mathf.Lerp(arg_313_1.var_.oldValueTypewriter, var_316_8, var_316_13)
				arg_313_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_313_1.fswtw_:SetDirty()
			end

			if arg_313_1.time_ >= var_316_3 + var_316_12 and arg_313_1.time_ < var_316_3 + var_316_12 + arg_316_0 then
				arg_313_1.fswtw_.percent = var_316_8

				arg_313_1.fswtw_:SetDirty()
				arg_313_1:ShowNextGo(true)

				arg_313_1.typewritterCharCountI18N = var_316_9
			end

			local var_316_14 = 0
			local var_316_15 = 11.026
			local var_316_16 = manager.audio:GetVoiceLength("story_v_out_116381", "116381074", "story_v_out_116381.awb") / 1000

			if var_316_16 > 0 and var_316_15 < var_316_16 and var_316_16 + var_316_14 > arg_313_1.duration_ then
				local var_316_17 = var_316_16

				arg_313_1.duration_ = var_316_16 + var_316_14
			end

			if var_316_14 < arg_313_1.time_ and arg_313_1.time_ <= var_316_14 + arg_316_0 then
				local var_316_18 = "play"
				local var_316_19 = "voice"

				arg_313_1:AudioAction(var_316_18, var_316_19, "story_v_out_116381", "116381074", "story_v_out_116381.awb")
			end

			local var_316_20 = 0

			if var_316_20 < arg_313_1.time_ and arg_313_1.time_ <= var_316_20 + arg_316_0 then
				arg_313_1.allBtn_.enabled = false
			end

			local var_316_21 = 2.88333333333333

			if arg_313_1.time_ >= var_316_20 + var_316_21 and arg_313_1.time_ < var_316_20 + var_316_21 + arg_316_0 then
				arg_313_1.allBtn_.enabled = true
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play116381075 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 116381075
		arg_317_1.duration_ = 11.27

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play116381076(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = 0

			if var_320_0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_0 + arg_320_0 then
				arg_317_1.var_.oldValueTypewriter = arg_317_1.fswtw_.percent

				SetActive(arg_317_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_317_1:ShowNextGo(false)
			end

			local var_320_1 = 57
			local var_320_2 = 3.8
			local var_320_3 = arg_317_1:GetWordFromCfg(116381074)
			local var_320_4 = arg_317_1:FormatText(var_320_3.content)
			local var_320_5, var_320_6 = arg_317_1:GetPercentByPara(var_320_4, 2)

			if var_320_0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_0 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0

				local var_320_7 = var_320_1 <= 0 and var_320_2 or var_320_2 * ((var_320_6 - arg_317_1.typewritterCharCountI18N) / var_320_1)

				if var_320_7 > 0 and var_320_2 < var_320_7 then
					arg_317_1.talkMaxDuration = var_320_7

					if var_320_7 + var_320_0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_7 + var_320_0
					end
				end
			end

			local var_320_8 = 3.8
			local var_320_9 = math.max(var_320_8, arg_317_1.talkMaxDuration)

			if var_320_0 <= arg_317_1.time_ and arg_317_1.time_ < var_320_0 + var_320_9 then
				local var_320_10 = (arg_317_1.time_ - var_320_0) / var_320_9

				arg_317_1.fswtw_.percent = Mathf.Lerp(arg_317_1.var_.oldValueTypewriter, var_320_5, var_320_10)
				arg_317_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_317_1.fswtw_:SetDirty()
			end

			if arg_317_1.time_ >= var_320_0 + var_320_9 and arg_317_1.time_ < var_320_0 + var_320_9 + arg_320_0 then
				arg_317_1.fswtw_.percent = var_320_5

				arg_317_1.fswtw_:SetDirty()
				arg_317_1:ShowNextGo(true)

				arg_317_1.typewritterCharCountI18N = var_320_6
			end

			local var_320_11 = 0
			local var_320_12 = 11.274
			local var_320_13 = manager.audio:GetVoiceLength("story_v_out_116381", "116381075", "story_v_out_116381.awb") / 1000

			if var_320_13 > 0 and var_320_12 < var_320_13 and var_320_13 + var_320_11 > arg_317_1.duration_ then
				local var_320_14 = var_320_13

				arg_317_1.duration_ = var_320_13 + var_320_11
			end

			if var_320_11 < arg_317_1.time_ and arg_317_1.time_ <= var_320_11 + arg_320_0 then
				local var_320_15 = "play"
				local var_320_16 = "voice"

				arg_317_1:AudioAction(var_320_15, var_320_16, "story_v_out_116381", "116381075", "story_v_out_116381.awb")
			end

			local var_320_17 = 0

			if var_320_17 < arg_317_1.time_ and arg_317_1.time_ <= var_320_17 + arg_320_0 then
				arg_317_1.allBtn_.enabled = false
			end

			local var_320_18 = 3.86666666666667

			if arg_317_1.time_ >= var_320_17 + var_320_18 and arg_317_1.time_ < var_320_17 + var_320_18 + arg_320_0 then
				arg_317_1.allBtn_.enabled = true
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play116381076 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 116381076
		arg_321_1.duration_ = 3.4

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play116381077(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = 0

			if var_324_0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_0 + arg_324_0 then
				arg_321_1.var_.oldValueTypewriter = arg_321_1.fswtw_.percent

				SetActive(arg_321_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_321_1:ShowNextGo(false)
			end

			local var_324_1 = 12
			local var_324_2 = 0.8
			local var_324_3 = arg_321_1:GetWordFromCfg(116381074)
			local var_324_4 = arg_321_1:FormatText(var_324_3.content)
			local var_324_5, var_324_6 = arg_321_1:GetPercentByPara(var_324_4, 3)

			if var_324_0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_0 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0

				local var_324_7 = var_324_1 <= 0 and var_324_2 or var_324_2 * ((var_324_6 - arg_321_1.typewritterCharCountI18N) / var_324_1)

				if var_324_7 > 0 and var_324_2 < var_324_7 then
					arg_321_1.talkMaxDuration = var_324_7

					if var_324_7 + var_324_0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_7 + var_324_0
					end
				end
			end

			local var_324_8 = 0.8
			local var_324_9 = math.max(var_324_8, arg_321_1.talkMaxDuration)

			if var_324_0 <= arg_321_1.time_ and arg_321_1.time_ < var_324_0 + var_324_9 then
				local var_324_10 = (arg_321_1.time_ - var_324_0) / var_324_9

				arg_321_1.fswtw_.percent = Mathf.Lerp(arg_321_1.var_.oldValueTypewriter, var_324_5, var_324_10)
				arg_321_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_321_1.fswtw_:SetDirty()
			end

			if arg_321_1.time_ >= var_324_0 + var_324_9 and arg_321_1.time_ < var_324_0 + var_324_9 + arg_324_0 then
				arg_321_1.fswtw_.percent = var_324_5

				arg_321_1.fswtw_:SetDirty()
				arg_321_1:ShowNextGo(true)

				arg_321_1.typewritterCharCountI18N = var_324_6
			end

			local var_324_11 = 0
			local var_324_12 = 3.404
			local var_324_13 = manager.audio:GetVoiceLength("story_v_out_116381", "116381076", "story_v_out_116381.awb") / 1000

			if var_324_13 > 0 and var_324_12 < var_324_13 and var_324_13 + var_324_11 > arg_321_1.duration_ then
				local var_324_14 = var_324_13

				arg_321_1.duration_ = var_324_13 + var_324_11
			end

			if var_324_11 < arg_321_1.time_ and arg_321_1.time_ <= var_324_11 + arg_324_0 then
				local var_324_15 = "play"
				local var_324_16 = "voice"

				arg_321_1:AudioAction(var_324_15, var_324_16, "story_v_out_116381", "116381076", "story_v_out_116381.awb")
			end

			local var_324_17 = 0

			if var_324_17 < arg_321_1.time_ and arg_321_1.time_ <= var_324_17 + arg_324_0 then
				arg_321_1.allBtn_.enabled = false
			end

			local var_324_18 = 0.8

			if arg_321_1.time_ >= var_324_17 + var_324_18 and arg_321_1.time_ < var_324_17 + var_324_18 + arg_324_0 then
				arg_321_1.allBtn_.enabled = true
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play116381077 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 116381077
		arg_325_1.duration_ = 8.78

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play116381078(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = 0

			if var_328_0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_0 + arg_328_0 then
				arg_325_1.var_.oldValueTypewriter = arg_325_1.fswtw_.percent

				SetActive(arg_325_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_325_1:ShowNextGo(false)
			end

			local var_328_1 = 45
			local var_328_2 = 3
			local var_328_3 = arg_325_1:GetWordFromCfg(116381074)
			local var_328_4 = arg_325_1:FormatText(var_328_3.content)
			local var_328_5, var_328_6 = arg_325_1:GetPercentByPara(var_328_4, 4)

			if var_328_0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_0 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0

				local var_328_7 = var_328_1 <= 0 and var_328_2 or var_328_2 * ((var_328_6 - arg_325_1.typewritterCharCountI18N) / var_328_1)

				if var_328_7 > 0 and var_328_2 < var_328_7 then
					arg_325_1.talkMaxDuration = var_328_7

					if var_328_7 + var_328_0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_7 + var_328_0
					end
				end
			end

			local var_328_8 = 3
			local var_328_9 = math.max(var_328_8, arg_325_1.talkMaxDuration)

			if var_328_0 <= arg_325_1.time_ and arg_325_1.time_ < var_328_0 + var_328_9 then
				local var_328_10 = (arg_325_1.time_ - var_328_0) / var_328_9

				arg_325_1.fswtw_.percent = Mathf.Lerp(arg_325_1.var_.oldValueTypewriter, var_328_5, var_328_10)
				arg_325_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_325_1.fswtw_:SetDirty()
			end

			if arg_325_1.time_ >= var_328_0 + var_328_9 and arg_325_1.time_ < var_328_0 + var_328_9 + arg_328_0 then
				arg_325_1.fswtw_.percent = var_328_5

				arg_325_1.fswtw_:SetDirty()
				arg_325_1:ShowNextGo(true)

				arg_325_1.typewritterCharCountI18N = var_328_6
			end

			local var_328_11 = 0
			local var_328_12 = 8.782
			local var_328_13 = manager.audio:GetVoiceLength("story_v_out_116381", "116381077", "story_v_out_116381.awb") / 1000

			if var_328_13 > 0 and var_328_12 < var_328_13 and var_328_13 + var_328_11 > arg_325_1.duration_ then
				local var_328_14 = var_328_13

				arg_325_1.duration_ = var_328_13 + var_328_11
			end

			if var_328_11 < arg_325_1.time_ and arg_325_1.time_ <= var_328_11 + arg_328_0 then
				local var_328_15 = "play"
				local var_328_16 = "voice"

				arg_325_1:AudioAction(var_328_15, var_328_16, "story_v_out_116381", "116381077", "story_v_out_116381.awb")
			end

			local var_328_17 = 0

			if var_328_17 < arg_325_1.time_ and arg_325_1.time_ <= var_328_17 + arg_328_0 then
				arg_325_1.allBtn_.enabled = false
			end

			local var_328_18 = 3

			if arg_325_1.time_ >= var_328_17 + var_328_18 and arg_325_1.time_ < var_328_17 + var_328_18 + arg_328_0 then
				arg_325_1.allBtn_.enabled = true
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play116381078 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 116381078
		arg_329_1.duration_ = 5.99

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play116381079(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = 0

			if var_332_0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_0 + arg_332_0 then
				arg_329_1.var_.oldValueTypewriter = arg_329_1.fswtw_.percent

				SetActive(arg_329_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_329_1:ShowNextGo(false)
			end

			local var_332_1 = 24
			local var_332_2 = 1.6
			local var_332_3 = arg_329_1:GetWordFromCfg(116381074)
			local var_332_4 = arg_329_1:FormatText(var_332_3.content)
			local var_332_5, var_332_6 = arg_329_1:GetPercentByPara(var_332_4, 5)

			if var_332_0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_0 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0

				local var_332_7 = var_332_1 <= 0 and var_332_2 or var_332_2 * ((var_332_6 - arg_329_1.typewritterCharCountI18N) / var_332_1)

				if var_332_7 > 0 and var_332_2 < var_332_7 then
					arg_329_1.talkMaxDuration = var_332_7

					if var_332_7 + var_332_0 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_7 + var_332_0
					end
				end
			end

			local var_332_8 = 1.6
			local var_332_9 = math.max(var_332_8, arg_329_1.talkMaxDuration)

			if var_332_0 <= arg_329_1.time_ and arg_329_1.time_ < var_332_0 + var_332_9 then
				local var_332_10 = (arg_329_1.time_ - var_332_0) / var_332_9

				arg_329_1.fswtw_.percent = Mathf.Lerp(arg_329_1.var_.oldValueTypewriter, var_332_5, var_332_10)
				arg_329_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_329_1.fswtw_:SetDirty()
			end

			if arg_329_1.time_ >= var_332_0 + var_332_9 and arg_329_1.time_ < var_332_0 + var_332_9 + arg_332_0 then
				arg_329_1.fswtw_.percent = var_332_5

				arg_329_1.fswtw_:SetDirty()
				arg_329_1:ShowNextGo(true)

				arg_329_1.typewritterCharCountI18N = var_332_6
			end

			local var_332_11 = 0
			local var_332_12 = 5.986
			local var_332_13 = manager.audio:GetVoiceLength("story_v_out_116381", "116381078", "story_v_out_116381.awb") / 1000

			if var_332_13 > 0 and var_332_12 < var_332_13 and var_332_13 + var_332_11 > arg_329_1.duration_ then
				local var_332_14 = var_332_13

				arg_329_1.duration_ = var_332_13 + var_332_11
			end

			if var_332_11 < arg_329_1.time_ and arg_329_1.time_ <= var_332_11 + arg_332_0 then
				local var_332_15 = "play"
				local var_332_16 = "voice"

				arg_329_1:AudioAction(var_332_15, var_332_16, "story_v_out_116381", "116381078", "story_v_out_116381.awb")
			end

			local var_332_17 = 0

			if var_332_17 < arg_329_1.time_ and arg_329_1.time_ <= var_332_17 + arg_332_0 then
				arg_329_1.allBtn_.enabled = false
			end

			local var_332_18 = 1.6

			if arg_329_1.time_ >= var_332_17 + var_332_18 and arg_329_1.time_ < var_332_17 + var_332_18 + arg_332_0 then
				arg_329_1.allBtn_.enabled = true
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play116381079 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 116381079
		arg_333_1.duration_ = 13.09

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play116381080(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = 0

			if var_336_0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_0 + arg_336_0 then
				arg_333_1.var_.oldValueTypewriter = arg_333_1.fswtw_.percent

				SetActive(arg_333_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_333_1:ShowNextGo(false)
			end

			local var_336_1 = 56
			local var_336_2 = 3.73333333333333
			local var_336_3 = arg_333_1:GetWordFromCfg(116381074)
			local var_336_4 = arg_333_1:FormatText(var_336_3.content)
			local var_336_5, var_336_6 = arg_333_1:GetPercentByPara(var_336_4, 6)

			if var_336_0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_0 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0

				local var_336_7 = var_336_1 <= 0 and var_336_2 or var_336_2 * ((var_336_6 - arg_333_1.typewritterCharCountI18N) / var_336_1)

				if var_336_7 > 0 and var_336_2 < var_336_7 then
					arg_333_1.talkMaxDuration = var_336_7

					if var_336_7 + var_336_0 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_7 + var_336_0
					end
				end
			end

			local var_336_8 = 3.73333333333333
			local var_336_9 = math.max(var_336_8, arg_333_1.talkMaxDuration)

			if var_336_0 <= arg_333_1.time_ and arg_333_1.time_ < var_336_0 + var_336_9 then
				local var_336_10 = (arg_333_1.time_ - var_336_0) / var_336_9

				arg_333_1.fswtw_.percent = Mathf.Lerp(arg_333_1.var_.oldValueTypewriter, var_336_5, var_336_10)
				arg_333_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_333_1.fswtw_:SetDirty()
			end

			if arg_333_1.time_ >= var_336_0 + var_336_9 and arg_333_1.time_ < var_336_0 + var_336_9 + arg_336_0 then
				arg_333_1.fswtw_.percent = var_336_5

				arg_333_1.fswtw_:SetDirty()
				arg_333_1:ShowNextGo(true)

				arg_333_1.typewritterCharCountI18N = var_336_6
			end

			local var_336_11 = 0
			local var_336_12 = 13.093
			local var_336_13 = manager.audio:GetVoiceLength("story_v_out_116381", "116381079", "story_v_out_116381.awb") / 1000

			if var_336_13 > 0 and var_336_12 < var_336_13 and var_336_13 + var_336_11 > arg_333_1.duration_ then
				local var_336_14 = var_336_13

				arg_333_1.duration_ = var_336_13 + var_336_11
			end

			if var_336_11 < arg_333_1.time_ and arg_333_1.time_ <= var_336_11 + arg_336_0 then
				local var_336_15 = "play"
				local var_336_16 = "voice"

				arg_333_1:AudioAction(var_336_15, var_336_16, "story_v_out_116381", "116381079", "story_v_out_116381.awb")
			end

			local var_336_17 = 0

			if var_336_17 < arg_333_1.time_ and arg_333_1.time_ <= var_336_17 + arg_336_0 then
				arg_333_1.allBtn_.enabled = false
			end

			local var_336_18 = 3.8

			if arg_333_1.time_ >= var_336_17 + var_336_18 and arg_333_1.time_ < var_336_17 + var_336_18 + arg_336_0 then
				arg_333_1.allBtn_.enabled = true
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play116381080 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 116381080
		arg_337_1.duration_ = 5.22

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play116381081(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = 0

			if var_340_0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_0 + arg_340_0 then
				arg_337_1.fswbg_:SetActive(true)
				arg_337_1.dialog_:SetActive(false)

				arg_337_1.fswtw_.percent = 0

				local var_340_1 = arg_337_1:GetWordFromCfg(116381080)
				local var_340_2 = arg_337_1:FormatText(var_340_1.content)

				arg_337_1.fswt_.text = var_340_2

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.fswt_)

				arg_337_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_337_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_337_1.fswtw_:SetDirty()

				arg_337_1.typewritterCharCountI18N = 0

				SetActive(arg_337_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_337_1:ShowNextGo(false)
			end

			local var_340_3 = 0.0166666666666667

			if var_340_3 < arg_337_1.time_ and arg_337_1.time_ <= var_340_3 + arg_340_0 then
				arg_337_1.var_.oldValueTypewriter = arg_337_1.fswtw_.percent

				SetActive(arg_337_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_337_1:ShowNextGo(false)
			end

			local var_340_4 = 27
			local var_340_5 = 1.8
			local var_340_6 = arg_337_1:GetWordFromCfg(116381080)
			local var_340_7 = arg_337_1:FormatText(var_340_6.content)
			local var_340_8, var_340_9 = arg_337_1:GetPercentByPara(var_340_7, 1)

			if var_340_3 < arg_337_1.time_ and arg_337_1.time_ <= var_340_3 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0

				local var_340_10 = var_340_4 <= 0 and var_340_5 or var_340_5 * ((var_340_9 - arg_337_1.typewritterCharCountI18N) / var_340_4)

				if var_340_10 > 0 and var_340_5 < var_340_10 then
					arg_337_1.talkMaxDuration = var_340_10

					if var_340_10 + var_340_3 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_10 + var_340_3
					end
				end
			end

			local var_340_11 = 1.8
			local var_340_12 = math.max(var_340_11, arg_337_1.talkMaxDuration)

			if var_340_3 <= arg_337_1.time_ and arg_337_1.time_ < var_340_3 + var_340_12 then
				local var_340_13 = (arg_337_1.time_ - var_340_3) / var_340_12

				arg_337_1.fswtw_.percent = Mathf.Lerp(arg_337_1.var_.oldValueTypewriter, var_340_8, var_340_13)
				arg_337_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_337_1.fswtw_:SetDirty()
			end

			if arg_337_1.time_ >= var_340_3 + var_340_12 and arg_337_1.time_ < var_340_3 + var_340_12 + arg_340_0 then
				arg_337_1.fswtw_.percent = var_340_8

				arg_337_1.fswtw_:SetDirty()
				arg_337_1:ShowNextGo(true)

				arg_337_1.typewritterCharCountI18N = var_340_9
			end

			local var_340_14 = 0
			local var_340_15 = 5.216
			local var_340_16 = manager.audio:GetVoiceLength("story_v_out_116381", "116381080", "story_v_out_116381.awb") / 1000

			if var_340_16 > 0 and var_340_15 < var_340_16 and var_340_16 + var_340_14 > arg_337_1.duration_ then
				local var_340_17 = var_340_16

				arg_337_1.duration_ = var_340_16 + var_340_14
			end

			if var_340_14 < arg_337_1.time_ and arg_337_1.time_ <= var_340_14 + arg_340_0 then
				local var_340_18 = "play"
				local var_340_19 = "voice"

				arg_337_1:AudioAction(var_340_18, var_340_19, "story_v_out_116381", "116381080", "story_v_out_116381.awb")
			end

			local var_340_20 = 0

			if var_340_20 < arg_337_1.time_ and arg_337_1.time_ <= var_340_20 + arg_340_0 then
				arg_337_1.allBtn_.enabled = false
			end

			local var_340_21 = 1.81666666666667

			if arg_337_1.time_ >= var_340_20 + var_340_21 and arg_337_1.time_ < var_340_20 + var_340_21 + arg_340_0 then
				arg_337_1.allBtn_.enabled = true
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play116381081 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 116381081
		arg_341_1.duration_ = 5.71

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play116381082(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = 0

			if var_344_0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_0 + arg_344_0 then
				arg_341_1.var_.oldValueTypewriter = arg_341_1.fswtw_.percent

				SetActive(arg_341_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_341_1:ShowNextGo(false)
			end

			local var_344_1 = 25
			local var_344_2 = 1.66666666666667
			local var_344_3 = arg_341_1:GetWordFromCfg(116381080)
			local var_344_4 = arg_341_1:FormatText(var_344_3.content)
			local var_344_5, var_344_6 = arg_341_1:GetPercentByPara(var_344_4, 2)

			if var_344_0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_0 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0

				local var_344_7 = var_344_1 <= 0 and var_344_2 or var_344_2 * ((var_344_6 - arg_341_1.typewritterCharCountI18N) / var_344_1)

				if var_344_7 > 0 and var_344_2 < var_344_7 then
					arg_341_1.talkMaxDuration = var_344_7

					if var_344_7 + var_344_0 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_7 + var_344_0
					end
				end
			end

			local var_344_8 = 1.66666666666667
			local var_344_9 = math.max(var_344_8, arg_341_1.talkMaxDuration)

			if var_344_0 <= arg_341_1.time_ and arg_341_1.time_ < var_344_0 + var_344_9 then
				local var_344_10 = (arg_341_1.time_ - var_344_0) / var_344_9

				arg_341_1.fswtw_.percent = Mathf.Lerp(arg_341_1.var_.oldValueTypewriter, var_344_5, var_344_10)
				arg_341_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_341_1.fswtw_:SetDirty()
			end

			if arg_341_1.time_ >= var_344_0 + var_344_9 and arg_341_1.time_ < var_344_0 + var_344_9 + arg_344_0 then
				arg_341_1.fswtw_.percent = var_344_5

				arg_341_1.fswtw_:SetDirty()
				arg_341_1:ShowNextGo(true)

				arg_341_1.typewritterCharCountI18N = var_344_6
			end

			local var_344_11 = 0
			local var_344_12 = 5.711
			local var_344_13 = manager.audio:GetVoiceLength("story_v_out_116381", "116381081", "story_v_out_116381.awb") / 1000

			if var_344_13 > 0 and var_344_12 < var_344_13 and var_344_13 + var_344_11 > arg_341_1.duration_ then
				local var_344_14 = var_344_13

				arg_341_1.duration_ = var_344_13 + var_344_11
			end

			if var_344_11 < arg_341_1.time_ and arg_341_1.time_ <= var_344_11 + arg_344_0 then
				local var_344_15 = "play"
				local var_344_16 = "voice"

				arg_341_1:AudioAction(var_344_15, var_344_16, "story_v_out_116381", "116381081", "story_v_out_116381.awb")
			end

			local var_344_17 = 0

			if var_344_17 < arg_341_1.time_ and arg_341_1.time_ <= var_344_17 + arg_344_0 then
				arg_341_1.allBtn_.enabled = false
			end

			local var_344_18 = 1.66666666666667

			if arg_341_1.time_ >= var_344_17 + var_344_18 and arg_341_1.time_ < var_344_17 + var_344_18 + arg_344_0 then
				arg_341_1.allBtn_.enabled = true
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play116381082 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 116381082
		arg_345_1.duration_ = 6.7

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play116381083(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = 0

			if var_348_0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_0 + arg_348_0 then
				arg_345_1.var_.oldValueTypewriter = arg_345_1.fswtw_.percent

				SetActive(arg_345_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_345_1:ShowNextGo(false)
			end

			local var_348_1 = 34
			local var_348_2 = 2.26666666666667
			local var_348_3 = arg_345_1:GetWordFromCfg(116381080)
			local var_348_4 = arg_345_1:FormatText(var_348_3.content)
			local var_348_5, var_348_6 = arg_345_1:GetPercentByPara(var_348_4, 3)

			if var_348_0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_0 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0

				local var_348_7 = var_348_1 <= 0 and var_348_2 or var_348_2 * ((var_348_6 - arg_345_1.typewritterCharCountI18N) / var_348_1)

				if var_348_7 > 0 and var_348_2 < var_348_7 then
					arg_345_1.talkMaxDuration = var_348_7

					if var_348_7 + var_348_0 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_7 + var_348_0
					end
				end
			end

			local var_348_8 = 2.26666666666667
			local var_348_9 = math.max(var_348_8, arg_345_1.talkMaxDuration)

			if var_348_0 <= arg_345_1.time_ and arg_345_1.time_ < var_348_0 + var_348_9 then
				local var_348_10 = (arg_345_1.time_ - var_348_0) / var_348_9

				arg_345_1.fswtw_.percent = Mathf.Lerp(arg_345_1.var_.oldValueTypewriter, var_348_5, var_348_10)
				arg_345_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_345_1.fswtw_:SetDirty()
			end

			if arg_345_1.time_ >= var_348_0 + var_348_9 and arg_345_1.time_ < var_348_0 + var_348_9 + arg_348_0 then
				arg_345_1.fswtw_.percent = var_348_5

				arg_345_1.fswtw_:SetDirty()
				arg_345_1:ShowNextGo(true)

				arg_345_1.typewritterCharCountI18N = var_348_6
			end

			local var_348_11 = 0
			local var_348_12 = 6.696
			local var_348_13 = manager.audio:GetVoiceLength("story_v_out_116381", "116381082", "story_v_out_116381.awb") / 1000

			if var_348_13 > 0 and var_348_12 < var_348_13 and var_348_13 + var_348_11 > arg_345_1.duration_ then
				local var_348_14 = var_348_13

				arg_345_1.duration_ = var_348_13 + var_348_11
			end

			if var_348_11 < arg_345_1.time_ and arg_345_1.time_ <= var_348_11 + arg_348_0 then
				local var_348_15 = "play"
				local var_348_16 = "voice"

				arg_345_1:AudioAction(var_348_15, var_348_16, "story_v_out_116381", "116381082", "story_v_out_116381.awb")
			end

			local var_348_17 = 0

			if var_348_17 < arg_345_1.time_ and arg_345_1.time_ <= var_348_17 + arg_348_0 then
				arg_345_1.allBtn_.enabled = false
			end

			local var_348_18 = 2.26666666666667

			if arg_345_1.time_ >= var_348_17 + var_348_18 and arg_345_1.time_ < var_348_17 + var_348_18 + arg_348_0 then
				arg_345_1.allBtn_.enabled = true
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play116381083 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 116381083
		arg_349_1.duration_ = 8.8

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play116381084(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = 0

			if var_352_0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_0 + arg_352_0 then
				arg_349_1.var_.oldValueTypewriter = arg_349_1.fswtw_.percent

				SetActive(arg_349_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_349_1:ShowNextGo(false)
			end

			local var_352_1 = 43
			local var_352_2 = 2.86666666666667
			local var_352_3 = arg_349_1:GetWordFromCfg(116381080)
			local var_352_4 = arg_349_1:FormatText(var_352_3.content)
			local var_352_5, var_352_6 = arg_349_1:GetPercentByPara(var_352_4, 4)

			if var_352_0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_0 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0

				local var_352_7 = var_352_1 <= 0 and var_352_2 or var_352_2 * ((var_352_6 - arg_349_1.typewritterCharCountI18N) / var_352_1)

				if var_352_7 > 0 and var_352_2 < var_352_7 then
					arg_349_1.talkMaxDuration = var_352_7

					if var_352_7 + var_352_0 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_7 + var_352_0
					end
				end
			end

			local var_352_8 = 2.86666666666667
			local var_352_9 = math.max(var_352_8, arg_349_1.talkMaxDuration)

			if var_352_0 <= arg_349_1.time_ and arg_349_1.time_ < var_352_0 + var_352_9 then
				local var_352_10 = (arg_349_1.time_ - var_352_0) / var_352_9

				arg_349_1.fswtw_.percent = Mathf.Lerp(arg_349_1.var_.oldValueTypewriter, var_352_5, var_352_10)
				arg_349_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_349_1.fswtw_:SetDirty()
			end

			if arg_349_1.time_ >= var_352_0 + var_352_9 and arg_349_1.time_ < var_352_0 + var_352_9 + arg_352_0 then
				arg_349_1.fswtw_.percent = var_352_5

				arg_349_1.fswtw_:SetDirty()
				arg_349_1:ShowNextGo(true)

				arg_349_1.typewritterCharCountI18N = var_352_6
			end

			local var_352_11 = 0
			local var_352_12 = 8.798
			local var_352_13 = manager.audio:GetVoiceLength("story_v_out_116381", "116381083", "story_v_out_116381.awb") / 1000

			if var_352_13 > 0 and var_352_12 < var_352_13 and var_352_13 + var_352_11 > arg_349_1.duration_ then
				local var_352_14 = var_352_13

				arg_349_1.duration_ = var_352_13 + var_352_11
			end

			if var_352_11 < arg_349_1.time_ and arg_349_1.time_ <= var_352_11 + arg_352_0 then
				local var_352_15 = "play"
				local var_352_16 = "voice"

				arg_349_1:AudioAction(var_352_15, var_352_16, "story_v_out_116381", "116381083", "story_v_out_116381.awb")
			end

			local var_352_17 = 0

			if var_352_17 < arg_349_1.time_ and arg_349_1.time_ <= var_352_17 + arg_352_0 then
				arg_349_1.allBtn_.enabled = false
			end

			local var_352_18 = 2.86666666666667

			if arg_349_1.time_ >= var_352_17 + var_352_18 and arg_349_1.time_ < var_352_17 + var_352_18 + arg_352_0 then
				arg_349_1.allBtn_.enabled = true
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play116381084 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 116381084
		arg_353_1.duration_ = 5.75

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play116381085(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = 0

			if var_356_0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_0 + arg_356_0 then
				arg_353_1.var_.oldValueTypewriter = arg_353_1.fswtw_.percent

				SetActive(arg_353_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_353_1:ShowNextGo(false)
			end

			local var_356_1 = 19
			local var_356_2 = 1.26666666666667
			local var_356_3 = arg_353_1:GetWordFromCfg(116381080)
			local var_356_4 = arg_353_1:FormatText(var_356_3.content)
			local var_356_5, var_356_6 = arg_353_1:GetPercentByPara(var_356_4, 5)

			if var_356_0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_0 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0

				local var_356_7 = var_356_1 <= 0 and var_356_2 or var_356_2 * ((var_356_6 - arg_353_1.typewritterCharCountI18N) / var_356_1)

				if var_356_7 > 0 and var_356_2 < var_356_7 then
					arg_353_1.talkMaxDuration = var_356_7

					if var_356_7 + var_356_0 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_7 + var_356_0
					end
				end
			end

			local var_356_8 = 1.26666666666667
			local var_356_9 = math.max(var_356_8, arg_353_1.talkMaxDuration)

			if var_356_0 <= arg_353_1.time_ and arg_353_1.time_ < var_356_0 + var_356_9 then
				local var_356_10 = (arg_353_1.time_ - var_356_0) / var_356_9

				arg_353_1.fswtw_.percent = Mathf.Lerp(arg_353_1.var_.oldValueTypewriter, var_356_5, var_356_10)
				arg_353_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_353_1.fswtw_:SetDirty()
			end

			if arg_353_1.time_ >= var_356_0 + var_356_9 and arg_353_1.time_ < var_356_0 + var_356_9 + arg_356_0 then
				arg_353_1.fswtw_.percent = var_356_5

				arg_353_1.fswtw_:SetDirty()
				arg_353_1:ShowNextGo(true)

				arg_353_1.typewritterCharCountI18N = var_356_6
			end

			local var_356_11 = 0
			local var_356_12 = 5.75
			local var_356_13 = manager.audio:GetVoiceLength("story_v_out_116381", "116381084", "story_v_out_116381.awb") / 1000

			if var_356_13 > 0 and var_356_12 < var_356_13 and var_356_13 + var_356_11 > arg_353_1.duration_ then
				local var_356_14 = var_356_13

				arg_353_1.duration_ = var_356_13 + var_356_11
			end

			if var_356_11 < arg_353_1.time_ and arg_353_1.time_ <= var_356_11 + arg_356_0 then
				local var_356_15 = "play"
				local var_356_16 = "voice"

				arg_353_1:AudioAction(var_356_15, var_356_16, "story_v_out_116381", "116381084", "story_v_out_116381.awb")
			end

			local var_356_17 = 0

			if var_356_17 < arg_353_1.time_ and arg_353_1.time_ <= var_356_17 + arg_356_0 then
				arg_353_1.allBtn_.enabled = false
			end

			local var_356_18 = 1.33333333333333

			if arg_353_1.time_ >= var_356_17 + var_356_18 and arg_353_1.time_ < var_356_17 + var_356_18 + arg_356_0 then
				arg_353_1.allBtn_.enabled = true
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play116381085 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 116381085
		arg_357_1.duration_ = 10.58

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play116381086(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			local var_360_0 = 0

			if var_360_0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_0 + arg_360_0 then
				arg_357_1.var_.oldValueTypewriter = arg_357_1.fswtw_.percent

				SetActive(arg_357_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_357_1:ShowNextGo(false)
			end

			local var_360_1 = 51
			local var_360_2 = 3.26666666666667
			local var_360_3 = arg_357_1:GetWordFromCfg(116381080)
			local var_360_4 = arg_357_1:FormatText(var_360_3.content)
			local var_360_5, var_360_6 = arg_357_1:GetPercentByPara(var_360_4, 6)

			if var_360_0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_0 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0

				local var_360_7 = var_360_1 <= 0 and var_360_2 or var_360_2 * ((var_360_6 - arg_357_1.typewritterCharCountI18N) / var_360_1)

				if var_360_7 > 0 and var_360_2 < var_360_7 then
					arg_357_1.talkMaxDuration = var_360_7

					if var_360_7 + var_360_0 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_7 + var_360_0
					end
				end
			end

			local var_360_8 = 3.26666666666667
			local var_360_9 = math.max(var_360_8, arg_357_1.talkMaxDuration)

			if var_360_0 <= arg_357_1.time_ and arg_357_1.time_ < var_360_0 + var_360_9 then
				local var_360_10 = (arg_357_1.time_ - var_360_0) / var_360_9

				arg_357_1.fswtw_.percent = Mathf.Lerp(arg_357_1.var_.oldValueTypewriter, var_360_5, var_360_10)
				arg_357_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_357_1.fswtw_:SetDirty()
			end

			if arg_357_1.time_ >= var_360_0 + var_360_9 and arg_357_1.time_ < var_360_0 + var_360_9 + arg_360_0 then
				arg_357_1.fswtw_.percent = var_360_5

				arg_357_1.fswtw_:SetDirty()
				arg_357_1:ShowNextGo(true)

				arg_357_1.typewritterCharCountI18N = var_360_6
			end

			local var_360_11 = 0
			local var_360_12 = 10.582
			local var_360_13 = manager.audio:GetVoiceLength("story_v_out_116381", "116381085", "story_v_out_116381.awb") / 1000

			if var_360_13 > 0 and var_360_12 < var_360_13 and var_360_13 + var_360_11 > arg_357_1.duration_ then
				local var_360_14 = var_360_13

				arg_357_1.duration_ = var_360_13 + var_360_11
			end

			if var_360_11 < arg_357_1.time_ and arg_357_1.time_ <= var_360_11 + arg_360_0 then
				local var_360_15 = "play"
				local var_360_16 = "voice"

				arg_357_1:AudioAction(var_360_15, var_360_16, "story_v_out_116381", "116381085", "story_v_out_116381.awb")
			end

			local var_360_17 = 0

			if var_360_17 < arg_357_1.time_ and arg_357_1.time_ <= var_360_17 + arg_360_0 then
				arg_357_1.allBtn_.enabled = false
			end

			local var_360_18 = 3.26666666666667

			if arg_357_1.time_ >= var_360_17 + var_360_18 and arg_357_1.time_ < var_360_17 + var_360_18 + arg_360_0 then
				arg_357_1.allBtn_.enabled = true
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play116381086 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 116381086
		arg_361_1.duration_ = 3.71

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play116381087(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = 0

			if var_364_0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_0 + arg_364_0 then
				arg_361_1.fswbg_:SetActive(true)
				arg_361_1.dialog_:SetActive(false)

				arg_361_1.fswtw_.percent = 0

				local var_364_1 = arg_361_1:GetWordFromCfg(116381086)
				local var_364_2 = arg_361_1:FormatText(var_364_1.content)

				arg_361_1.fswt_.text = var_364_2

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.fswt_)

				arg_361_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_361_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_361_1.fswtw_:SetDirty()

				arg_361_1.typewritterCharCountI18N = 0

				SetActive(arg_361_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_361_1:ShowNextGo(false)
			end

			local var_364_3 = 0.0166666666666667

			if var_364_3 < arg_361_1.time_ and arg_361_1.time_ <= var_364_3 + arg_364_0 then
				arg_361_1.var_.oldValueTypewriter = arg_361_1.fswtw_.percent

				SetActive(arg_361_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_361_1:ShowNextGo(false)
			end

			local var_364_4 = 18
			local var_364_5 = 1.2
			local var_364_6 = arg_361_1:GetWordFromCfg(116381086)
			local var_364_7 = arg_361_1:FormatText(var_364_6.content)
			local var_364_8, var_364_9 = arg_361_1:GetPercentByPara(var_364_7, 1)

			if var_364_3 < arg_361_1.time_ and arg_361_1.time_ <= var_364_3 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0

				local var_364_10 = var_364_4 <= 0 and var_364_5 or var_364_5 * ((var_364_9 - arg_361_1.typewritterCharCountI18N) / var_364_4)

				if var_364_10 > 0 and var_364_5 < var_364_10 then
					arg_361_1.talkMaxDuration = var_364_10

					if var_364_10 + var_364_3 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_10 + var_364_3
					end
				end
			end

			local var_364_11 = 1.2
			local var_364_12 = math.max(var_364_11, arg_361_1.talkMaxDuration)

			if var_364_3 <= arg_361_1.time_ and arg_361_1.time_ < var_364_3 + var_364_12 then
				local var_364_13 = (arg_361_1.time_ - var_364_3) / var_364_12

				arg_361_1.fswtw_.percent = Mathf.Lerp(arg_361_1.var_.oldValueTypewriter, var_364_8, var_364_13)
				arg_361_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_361_1.fswtw_:SetDirty()
			end

			if arg_361_1.time_ >= var_364_3 + var_364_12 and arg_361_1.time_ < var_364_3 + var_364_12 + arg_364_0 then
				arg_361_1.fswtw_.percent = var_364_8

				arg_361_1.fswtw_:SetDirty()
				arg_361_1:ShowNextGo(true)

				arg_361_1.typewritterCharCountI18N = var_364_9
			end

			local var_364_14 = 0
			local var_364_15 = 3.714
			local var_364_16 = manager.audio:GetVoiceLength("story_v_out_116381", "116381086", "story_v_out_116381.awb") / 1000

			if var_364_16 > 0 and var_364_15 < var_364_16 and var_364_16 + var_364_14 > arg_361_1.duration_ then
				local var_364_17 = var_364_16

				arg_361_1.duration_ = var_364_16 + var_364_14
			end

			if var_364_14 < arg_361_1.time_ and arg_361_1.time_ <= var_364_14 + arg_364_0 then
				local var_364_18 = "play"
				local var_364_19 = "voice"

				arg_361_1:AudioAction(var_364_18, var_364_19, "story_v_out_116381", "116381086", "story_v_out_116381.awb")
			end

			local var_364_20 = 0

			if var_364_20 < arg_361_1.time_ and arg_361_1.time_ <= var_364_20 + arg_364_0 then
				arg_361_1.allBtn_.enabled = false
			end

			local var_364_21 = 1.21666666666667

			if arg_361_1.time_ >= var_364_20 + var_364_21 and arg_361_1.time_ < var_364_20 + var_364_21 + arg_364_0 then
				arg_361_1.allBtn_.enabled = true
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play116381087 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 116381087
		arg_365_1.duration_ = 6.92

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play116381088(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = 0

			if var_368_0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_0 + arg_368_0 then
				arg_365_1.var_.oldValueTypewriter = arg_365_1.fswtw_.percent

				SetActive(arg_365_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_365_1:ShowNextGo(false)
			end

			local var_368_1 = 36
			local var_368_2 = 2.4
			local var_368_3 = arg_365_1:GetWordFromCfg(116381086)
			local var_368_4 = arg_365_1:FormatText(var_368_3.content)
			local var_368_5, var_368_6 = arg_365_1:GetPercentByPara(var_368_4, 2)

			if var_368_0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_0 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0

				local var_368_7 = var_368_1 <= 0 and var_368_2 or var_368_2 * ((var_368_6 - arg_365_1.typewritterCharCountI18N) / var_368_1)

				if var_368_7 > 0 and var_368_2 < var_368_7 then
					arg_365_1.talkMaxDuration = var_368_7

					if var_368_7 + var_368_0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_7 + var_368_0
					end
				end
			end

			local var_368_8 = 2.4
			local var_368_9 = math.max(var_368_8, arg_365_1.talkMaxDuration)

			if var_368_0 <= arg_365_1.time_ and arg_365_1.time_ < var_368_0 + var_368_9 then
				local var_368_10 = (arg_365_1.time_ - var_368_0) / var_368_9

				arg_365_1.fswtw_.percent = Mathf.Lerp(arg_365_1.var_.oldValueTypewriter, var_368_5, var_368_10)
				arg_365_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_365_1.fswtw_:SetDirty()
			end

			if arg_365_1.time_ >= var_368_0 + var_368_9 and arg_365_1.time_ < var_368_0 + var_368_9 + arg_368_0 then
				arg_365_1.fswtw_.percent = var_368_5

				arg_365_1.fswtw_:SetDirty()
				arg_365_1:ShowNextGo(true)

				arg_365_1.typewritterCharCountI18N = var_368_6
			end

			local var_368_11 = 0
			local var_368_12 = 6.923
			local var_368_13 = manager.audio:GetVoiceLength("story_v_out_116381", "116381087", "story_v_out_116381.awb") / 1000

			if var_368_13 > 0 and var_368_12 < var_368_13 and var_368_13 + var_368_11 > arg_365_1.duration_ then
				local var_368_14 = var_368_13

				arg_365_1.duration_ = var_368_13 + var_368_11
			end

			if var_368_11 < arg_365_1.time_ and arg_365_1.time_ <= var_368_11 + arg_368_0 then
				local var_368_15 = "play"
				local var_368_16 = "voice"

				arg_365_1:AudioAction(var_368_15, var_368_16, "story_v_out_116381", "116381087", "story_v_out_116381.awb")
			end

			local var_368_17 = 0

			if var_368_17 < arg_365_1.time_ and arg_365_1.time_ <= var_368_17 + arg_368_0 then
				arg_365_1.allBtn_.enabled = false
			end

			local var_368_18 = 2.4

			if arg_365_1.time_ >= var_368_17 + var_368_18 and arg_365_1.time_ < var_368_17 + var_368_18 + arg_368_0 then
				arg_365_1.allBtn_.enabled = true
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play116381088 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 116381088
		arg_369_1.duration_ = 3.37

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play116381089(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = 0

			if var_372_0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_0 + arg_372_0 then
				arg_369_1.var_.oldValueTypewriter = arg_369_1.fswtw_.percent

				SetActive(arg_369_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_369_1:ShowNextGo(false)
			end

			local var_372_1 = 16
			local var_372_2 = 1.06666666666667
			local var_372_3 = arg_369_1:GetWordFromCfg(116381086)
			local var_372_4 = arg_369_1:FormatText(var_372_3.content)
			local var_372_5, var_372_6 = arg_369_1:GetPercentByPara(var_372_4, 3)

			if var_372_0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_0 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0

				local var_372_7 = var_372_1 <= 0 and var_372_2 or var_372_2 * ((var_372_6 - arg_369_1.typewritterCharCountI18N) / var_372_1)

				if var_372_7 > 0 and var_372_2 < var_372_7 then
					arg_369_1.talkMaxDuration = var_372_7

					if var_372_7 + var_372_0 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_7 + var_372_0
					end
				end
			end

			local var_372_8 = 1.06666666666667
			local var_372_9 = math.max(var_372_8, arg_369_1.talkMaxDuration)

			if var_372_0 <= arg_369_1.time_ and arg_369_1.time_ < var_372_0 + var_372_9 then
				local var_372_10 = (arg_369_1.time_ - var_372_0) / var_372_9

				arg_369_1.fswtw_.percent = Mathf.Lerp(arg_369_1.var_.oldValueTypewriter, var_372_5, var_372_10)
				arg_369_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_369_1.fswtw_:SetDirty()
			end

			if arg_369_1.time_ >= var_372_0 + var_372_9 and arg_369_1.time_ < var_372_0 + var_372_9 + arg_372_0 then
				arg_369_1.fswtw_.percent = var_372_5

				arg_369_1.fswtw_:SetDirty()
				arg_369_1:ShowNextGo(true)

				arg_369_1.typewritterCharCountI18N = var_372_6
			end

			local var_372_11 = 0
			local var_372_12 = 3.098
			local var_372_13 = manager.audio:GetVoiceLength("story_v_out_116381", "116381088", "story_v_out_116381.awb") / 1000

			if var_372_13 > 0 and var_372_12 < var_372_13 and var_372_13 + var_372_11 > arg_369_1.duration_ then
				local var_372_14 = var_372_13

				arg_369_1.duration_ = var_372_13 + var_372_11
			end

			if var_372_11 < arg_369_1.time_ and arg_369_1.time_ <= var_372_11 + arg_372_0 then
				local var_372_15 = "play"
				local var_372_16 = "voice"

				arg_369_1:AudioAction(var_372_15, var_372_16, "story_v_out_116381", "116381088", "story_v_out_116381.awb")
			end

			local var_372_17 = 0

			if var_372_17 < arg_369_1.time_ and arg_369_1.time_ <= var_372_17 + arg_372_0 then
				arg_369_1.allBtn_.enabled = false
			end

			local var_372_18 = 1.06666666666667

			if arg_369_1.time_ >= var_372_17 + var_372_18 and arg_369_1.time_ < var_372_17 + var_372_18 + arg_372_0 then
				arg_369_1.allBtn_.enabled = true
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play116381089 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 116381089
		arg_373_1.duration_ = 4.83

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play116381090(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			local var_376_0 = 0

			if var_376_0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_0 + arg_376_0 then
				arg_373_1.var_.oldValueTypewriter = arg_373_1.fswtw_.percent

				SetActive(arg_373_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_373_1:ShowNextGo(false)
			end

			local var_376_1 = 17
			local var_376_2 = 1.13333333333333
			local var_376_3 = arg_373_1:GetWordFromCfg(116381086)
			local var_376_4 = arg_373_1:FormatText(var_376_3.content)
			local var_376_5, var_376_6 = arg_373_1:GetPercentByPara(var_376_4, 4)

			if var_376_0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_0 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0

				local var_376_7 = var_376_1 <= 0 and var_376_2 or var_376_2 * ((var_376_6 - arg_373_1.typewritterCharCountI18N) / var_376_1)

				if var_376_7 > 0 and var_376_2 < var_376_7 then
					arg_373_1.talkMaxDuration = var_376_7

					if var_376_7 + var_376_0 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_7 + var_376_0
					end
				end
			end

			local var_376_8 = 1.13333333333333
			local var_376_9 = math.max(var_376_8, arg_373_1.talkMaxDuration)

			if var_376_0 <= arg_373_1.time_ and arg_373_1.time_ < var_376_0 + var_376_9 then
				local var_376_10 = (arg_373_1.time_ - var_376_0) / var_376_9

				arg_373_1.fswtw_.percent = Mathf.Lerp(arg_373_1.var_.oldValueTypewriter, var_376_5, var_376_10)
				arg_373_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_373_1.fswtw_:SetDirty()
			end

			if arg_373_1.time_ >= var_376_0 + var_376_9 and arg_373_1.time_ < var_376_0 + var_376_9 + arg_376_0 then
				arg_373_1.fswtw_.percent = var_376_5

				arg_373_1.fswtw_:SetDirty()
				arg_373_1:ShowNextGo(true)

				arg_373_1.typewritterCharCountI18N = var_376_6
			end

			local var_376_11 = 0
			local var_376_12 = 4.835
			local var_376_13 = manager.audio:GetVoiceLength("story_v_out_116381", "116381089", "story_v_out_116381.awb") / 1000

			if var_376_13 > 0 and var_376_12 < var_376_13 and var_376_13 + var_376_11 > arg_373_1.duration_ then
				local var_376_14 = var_376_13

				arg_373_1.duration_ = var_376_13 + var_376_11
			end

			if var_376_11 < arg_373_1.time_ and arg_373_1.time_ <= var_376_11 + arg_376_0 then
				local var_376_15 = "play"
				local var_376_16 = "voice"

				arg_373_1:AudioAction(var_376_15, var_376_16, "story_v_out_116381", "116381089", "story_v_out_116381.awb")
			end

			local var_376_17 = 0

			if var_376_17 < arg_373_1.time_ and arg_373_1.time_ <= var_376_17 + arg_376_0 then
				arg_373_1.allBtn_.enabled = false
			end

			local var_376_18 = 1.13333333333333

			if arg_373_1.time_ >= var_376_17 + var_376_18 and arg_373_1.time_ < var_376_17 + var_376_18 + arg_376_0 then
				arg_373_1.allBtn_.enabled = true
			end
		end

		arg_373_1.nodeConfigList_ = {}

		arg_373_1:InitPlayNodeList()
	end,
	Play116381090 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 116381090
		arg_377_1.duration_ = 6.23

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play116381091(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = 0

			if var_380_0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_0 + arg_380_0 then
				arg_377_1.var_.oldValueTypewriter = arg_377_1.fswtw_.percent

				SetActive(arg_377_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_377_1:ShowNextGo(false)
			end

			local var_380_1 = 22
			local var_380_2 = 1.46666666666667
			local var_380_3 = arg_377_1:GetWordFromCfg(116381086)
			local var_380_4 = arg_377_1:FormatText(var_380_3.content)
			local var_380_5, var_380_6 = arg_377_1:GetPercentByPara(var_380_4, 5)

			if var_380_0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_0 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0

				local var_380_7 = var_380_1 <= 0 and var_380_2 or var_380_2 * ((var_380_6 - arg_377_1.typewritterCharCountI18N) / var_380_1)

				if var_380_7 > 0 and var_380_2 < var_380_7 then
					arg_377_1.talkMaxDuration = var_380_7

					if var_380_7 + var_380_0 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_7 + var_380_0
					end
				end
			end

			local var_380_8 = 1.46666666666667
			local var_380_9 = math.max(var_380_8, arg_377_1.talkMaxDuration)

			if var_380_0 <= arg_377_1.time_ and arg_377_1.time_ < var_380_0 + var_380_9 then
				local var_380_10 = (arg_377_1.time_ - var_380_0) / var_380_9

				arg_377_1.fswtw_.percent = Mathf.Lerp(arg_377_1.var_.oldValueTypewriter, var_380_5, var_380_10)
				arg_377_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_377_1.fswtw_:SetDirty()
			end

			if arg_377_1.time_ >= var_380_0 + var_380_9 and arg_377_1.time_ < var_380_0 + var_380_9 + arg_380_0 then
				arg_377_1.fswtw_.percent = var_380_5

				arg_377_1.fswtw_:SetDirty()
				arg_377_1:ShowNextGo(true)

				arg_377_1.typewritterCharCountI18N = var_380_6
			end

			local var_380_11 = 0
			local var_380_12 = 6.234
			local var_380_13 = manager.audio:GetVoiceLength("story_v_out_116381", "116381090", "story_v_out_116381.awb") / 1000

			if var_380_13 > 0 and var_380_12 < var_380_13 and var_380_13 + var_380_11 > arg_377_1.duration_ then
				local var_380_14 = var_380_13

				arg_377_1.duration_ = var_380_13 + var_380_11
			end

			if var_380_11 < arg_377_1.time_ and arg_377_1.time_ <= var_380_11 + arg_380_0 then
				local var_380_15 = "play"
				local var_380_16 = "voice"

				arg_377_1:AudioAction(var_380_15, var_380_16, "story_v_out_116381", "116381090", "story_v_out_116381.awb")
			end

			local var_380_17 = 0

			if var_380_17 < arg_377_1.time_ and arg_377_1.time_ <= var_380_17 + arg_380_0 then
				arg_377_1.allBtn_.enabled = false
			end

			local var_380_18 = 1.46666666666667

			if arg_377_1.time_ >= var_380_17 + var_380_18 and arg_377_1.time_ < var_380_17 + var_380_18 + arg_380_0 then
				arg_377_1.allBtn_.enabled = true
			end
		end

		arg_377_1.nodeConfigList_ = {}

		arg_377_1:InitPlayNodeList()
	end,
	Play116381091 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 116381091
		arg_381_1.duration_ = 3.03

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
			arg_381_1.auto_ = false
		end

		function arg_381_1.playNext_(arg_383_0)
			arg_381_1.onStoryFinished_()
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			local var_384_0 = 0

			if var_384_0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_0 + arg_384_0 then
				arg_381_1.var_.oldValueTypewriter = arg_381_1.fswtw_.percent

				SetActive(arg_381_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_381_1:ShowNextGo(false)
			end

			local var_384_1 = 11
			local var_384_2 = 0.733333333333333
			local var_384_3 = arg_381_1:GetWordFromCfg(116381086)
			local var_384_4 = arg_381_1:FormatText(var_384_3.content)
			local var_384_5, var_384_6 = arg_381_1:GetPercentByPara(var_384_4, 6)

			if var_384_0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_0 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0

				local var_384_7 = var_384_1 <= 0 and var_384_2 or var_384_2 * ((var_384_6 - arg_381_1.typewritterCharCountI18N) / var_384_1)

				if var_384_7 > 0 and var_384_2 < var_384_7 then
					arg_381_1.talkMaxDuration = var_384_7

					if var_384_7 + var_384_0 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_7 + var_384_0
					end
				end
			end

			local var_384_8 = 0.733333333333333
			local var_384_9 = math.max(var_384_8, arg_381_1.talkMaxDuration)

			if var_384_0 <= arg_381_1.time_ and arg_381_1.time_ < var_384_0 + var_384_9 then
				local var_384_10 = (arg_381_1.time_ - var_384_0) / var_384_9

				arg_381_1.fswtw_.percent = Mathf.Lerp(arg_381_1.var_.oldValueTypewriter, var_384_5, var_384_10)
				arg_381_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_381_1.fswtw_:SetDirty()
			end

			if arg_381_1.time_ >= var_384_0 + var_384_9 and arg_381_1.time_ < var_384_0 + var_384_9 + arg_384_0 then
				arg_381_1.fswtw_.percent = var_384_5

				arg_381_1.fswtw_:SetDirty()
				arg_381_1:ShowNextGo(true)

				arg_381_1.typewritterCharCountI18N = var_384_6
			end

			local var_384_11 = 0
			local var_384_12 = 2.753
			local var_384_13 = manager.audio:GetVoiceLength("story_v_out_116381", "116381091", "story_v_out_116381.awb") / 1000

			if var_384_13 > 0 and var_384_12 < var_384_13 and var_384_13 + var_384_11 > arg_381_1.duration_ then
				local var_384_14 = var_384_13

				arg_381_1.duration_ = var_384_13 + var_384_11
			end

			if var_384_11 < arg_381_1.time_ and arg_381_1.time_ <= var_384_11 + arg_384_0 then
				local var_384_15 = "play"
				local var_384_16 = "voice"

				arg_381_1:AudioAction(var_384_15, var_384_16, "story_v_out_116381", "116381091", "story_v_out_116381.awb")
			end

			local var_384_17 = 0

			if var_384_17 < arg_381_1.time_ and arg_381_1.time_ <= var_384_17 + arg_384_0 then
				arg_381_1.allBtn_.enabled = false
			end

			local var_384_18 = 0.733333333333333

			if arg_381_1.time_ >= var_384_17 + var_384_18 and arg_381_1.time_ < var_384_17 + var_384_18 + arg_384_0 then
				arg_381_1.allBtn_.enabled = true
			end
		end

		arg_381_1.nodeConfigList_ = {}

		arg_381_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/SK0107",
		"TextureConfig/Background/SK0112",
		"TextureConfig/Background/SK0201",
		"TextureConfig/Background/SK0106",
		"TextureConfig/Background/SK0102",
		"TextureConfig/Background/I05f"
	},
	voices = {
		"story_v_out_116381.awb"
	}
}
