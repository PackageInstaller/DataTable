return {
	Play319651001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 319651001
		arg_1_1.duration_ = 1.23

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play319651002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0
			local var_4_1 = 0.2

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				local var_4_2 = "play"
				local var_4_3 = "music"

				arg_1_1:AudioAction(var_4_2, var_4_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_4 = ""
				local var_4_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_5 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_5 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_5

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_5
						arg_1_1.bgmTxt2_.text = var_4_5
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

			local var_4_6 = 0.233333333333333
			local var_4_7 = 1

			if var_4_6 < arg_1_1.time_ and arg_1_1.time_ <= var_4_6 + arg_4_0 then
				local var_4_8 = "play"
				local var_4_9 = "music"

				arg_1_1:AudioAction(var_4_8, var_4_9, "bgm_activity_3_0_story_moon", "bgm_activity_3_0_story_moon", "bgm_activity_3_0_story_moon.awb")

				local var_4_10 = ""
				local var_4_11 = manager.audio:GetAudioName("bgm_activity_3_0_story_moon", "bgm_activity_3_0_story_moon")

				if var_4_11 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_11 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_11

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_11
						arg_1_1.bgmTxt2_.text = var_4_11
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

			local var_4_12 = 0

			if var_4_12 < arg_1_1.time_ and arg_1_1.time_ <= var_4_12 + arg_4_0 then
				local var_4_13 = arg_1_1.fswbg_.transform:Find("textbox/adapt/content") or arg_1_1.fswbg_.transform:Find("textbox/content")
				local var_4_14 = arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_4_15 = var_4_13:GetComponent("Text")
				local var_4_16 = var_4_13:GetComponent("RectTransform")

				var_4_15.alignment = UnityEngine.TextAnchor.LowerCenter
				var_4_16.offsetMin = Vector2.New(0, 0)
				var_4_16.offsetMax = Vector2.New(0, 0)
			end

			local var_4_17 = 0

			if var_4_17 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 then
				arg_1_1.fswbg_:SetActive(true)
				arg_1_1.dialog_:SetActive(false)

				arg_1_1.fswtw_.percent = 0

				local var_4_18 = arg_1_1:GetWordFromCfg(319651001)
				local var_4_19 = arg_1_1:FormatText(var_4_18.content)

				arg_1_1.fswt_.text = var_4_19

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.fswt_)

				arg_1_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_1_1.fswtw_:SetDirty()

				arg_1_1.typewritterCharCountI18N = 0

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_20 = 0.149999999998999

			if var_4_20 < arg_1_1.time_ and arg_1_1.time_ <= var_4_20 + arg_4_0 then
				arg_1_1.var_.oldValueTypewriter = arg_1_1.fswtw_.percent

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_21 = 0
			local var_4_22 = 0
			local var_4_23 = arg_1_1:GetWordFromCfg(319651001)
			local var_4_24 = arg_1_1:FormatText(var_4_23.content)
			local var_4_25, var_4_26 = arg_1_1:GetPercentByPara(var_4_24, 1)

			if var_4_20 < arg_1_1.time_ and arg_1_1.time_ <= var_4_20 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				local var_4_27 = var_4_21 <= 0 and var_4_22 or var_4_22 * ((var_4_26 - arg_1_1.typewritterCharCountI18N) / var_4_21)

				if var_4_27 > 0 and var_4_22 < var_4_27 then
					arg_1_1.talkMaxDuration = var_4_27

					if var_4_27 + var_4_20 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_27 + var_4_20
					end
				end
			end

			local var_4_28 = 0
			local var_4_29 = math.max(var_4_28, arg_1_1.talkMaxDuration)

			if var_4_20 <= arg_1_1.time_ and arg_1_1.time_ < var_4_20 + var_4_29 then
				local var_4_30 = (arg_1_1.time_ - var_4_20) / var_4_29

				arg_1_1.fswtw_.percent = Mathf.Lerp(arg_1_1.var_.oldValueTypewriter, var_4_25, var_4_30)
				arg_1_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_1_1.fswtw_:SetDirty()
			end

			if arg_1_1.time_ >= var_4_20 + var_4_29 and arg_1_1.time_ < var_4_20 + var_4_29 + arg_4_0 then
				arg_1_1.fswtw_.percent = var_4_25

				arg_1_1.fswtw_:SetDirty()
				arg_1_1:ShowNextGo(true)

				arg_1_1.typewritterCharCountI18N = var_4_26
			end

			local var_4_31 = 0.15

			if var_4_31 < arg_1_1.time_ and arg_1_1.time_ <= var_4_31 + arg_4_0 then
				arg_1_1.var_.oldValueTypewriter = arg_1_1.fswtw_.percent

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_32 = 6
			local var_4_33 = 0.4
			local var_4_34 = arg_1_1:GetWordFromCfg(319651001)
			local var_4_35 = arg_1_1:FormatText(var_4_34.content)
			local var_4_36, var_4_37 = arg_1_1:GetPercentByPara(var_4_35, 1)

			if var_4_31 < arg_1_1.time_ and arg_1_1.time_ <= var_4_31 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				local var_4_38 = var_4_32 <= 0 and var_4_33 or var_4_33 * ((var_4_37 - arg_1_1.typewritterCharCountI18N) / var_4_32)

				if var_4_38 > 0 and var_4_33 < var_4_38 then
					arg_1_1.talkMaxDuration = var_4_38

					if var_4_38 + var_4_31 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_38 + var_4_31
					end
				end
			end

			local var_4_39 = 0.4
			local var_4_40 = math.max(var_4_39, arg_1_1.talkMaxDuration)

			if var_4_31 <= arg_1_1.time_ and arg_1_1.time_ < var_4_31 + var_4_40 then
				local var_4_41 = (arg_1_1.time_ - var_4_31) / var_4_40

				arg_1_1.fswtw_.percent = Mathf.Lerp(arg_1_1.var_.oldValueTypewriter, var_4_36, var_4_41)
				arg_1_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_1_1.fswtw_:SetDirty()
			end

			if arg_1_1.time_ >= var_4_31 + var_4_40 and arg_1_1.time_ < var_4_31 + var_4_40 + arg_4_0 then
				arg_1_1.fswtw_.percent = var_4_36

				arg_1_1.fswtw_:SetDirty()
				arg_1_1:ShowNextGo(true)

				arg_1_1.typewritterCharCountI18N = var_4_37
			end

			local var_4_42 = 0

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				arg_1_1.cswbg_:SetActive(true)

				local var_4_43 = arg_1_1.cswt_:GetComponent("RectTransform")

				arg_1_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_4_43.offsetMin = Vector2.New(410, 330)
				var_4_43.offsetMax = Vector2.New(-400, -180)

				local var_4_44 = arg_1_1:GetWordFromCfg(419036)
				local var_4_45 = arg_1_1:FormatText(var_4_44.content)

				arg_1_1.cswt_.text = var_4_45

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.cswt_)

				arg_1_1.cswt_.fontSize = 174
				arg_1_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_1_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_1_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_4_46 = 0
			local var_4_47 = 1.233
			local var_4_48 = manager.audio:GetVoiceLength("story_v_out_319651", "319651001", "story_v_out_319651.awb") / 1000

			if var_4_48 > 0 and var_4_47 < var_4_48 and var_4_48 + var_4_46 > arg_1_1.duration_ then
				local var_4_49 = var_4_48

				arg_1_1.duration_ = var_4_48 + var_4_46
			end

			if var_4_46 < arg_1_1.time_ and arg_1_1.time_ <= var_4_46 + arg_4_0 then
				local var_4_50 = "play"
				local var_4_51 = "voice"

				arg_1_1:AudioAction(var_4_50, var_4_51, "story_v_out_319651", "319651001", "story_v_out_319651.awb")
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play319651002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 319651002
		arg_7_1.duration_ = 3.13

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play319651003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			local var_10_0 = 0

			if var_10_0 < arg_7_1.time_ and arg_7_1.time_ <= var_10_0 + arg_10_0 then
				arg_7_1.fswbg_:SetActive(true)
				arg_7_1.dialog_:SetActive(false)

				arg_7_1.fswtw_.percent = 0

				local var_10_1 = arg_7_1:GetWordFromCfg(319651002)
				local var_10_2 = arg_7_1:FormatText(var_10_1.content)

				arg_7_1.fswt_.text = var_10_2

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.fswt_)

				arg_7_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_7_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_7_1.fswtw_:SetDirty()

				arg_7_1.typewritterCharCountI18N = 0

				SetActive(arg_7_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_7_1:ShowNextGo(false)
			end

			local var_10_3 = 0.149999999998999

			if var_10_3 < arg_7_1.time_ and arg_7_1.time_ <= var_10_3 + arg_10_0 then
				arg_7_1.var_.oldValueTypewriter = arg_7_1.fswtw_.percent

				SetActive(arg_7_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_7_1:ShowNextGo(false)
			end

			local var_10_4 = 0
			local var_10_5 = 0
			local var_10_6 = arg_7_1:GetWordFromCfg(319651002)
			local var_10_7 = arg_7_1:FormatText(var_10_6.content)
			local var_10_8, var_10_9 = arg_7_1:GetPercentByPara(var_10_7, 1)

			if var_10_3 < arg_7_1.time_ and arg_7_1.time_ <= var_10_3 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0

				local var_10_10 = var_10_4 <= 0 and var_10_5 or var_10_5 * ((var_10_9 - arg_7_1.typewritterCharCountI18N) / var_10_4)

				if var_10_10 > 0 and var_10_5 < var_10_10 then
					arg_7_1.talkMaxDuration = var_10_10

					if var_10_10 + var_10_3 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_10 + var_10_3
					end
				end
			end

			local var_10_11 = 0
			local var_10_12 = math.max(var_10_11, arg_7_1.talkMaxDuration)

			if var_10_3 <= arg_7_1.time_ and arg_7_1.time_ < var_10_3 + var_10_12 then
				local var_10_13 = (arg_7_1.time_ - var_10_3) / var_10_12

				arg_7_1.fswtw_.percent = Mathf.Lerp(arg_7_1.var_.oldValueTypewriter, var_10_8, var_10_13)
				arg_7_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_7_1.fswtw_:SetDirty()
			end

			if arg_7_1.time_ >= var_10_3 + var_10_12 and arg_7_1.time_ < var_10_3 + var_10_12 + arg_10_0 then
				arg_7_1.fswtw_.percent = var_10_8

				arg_7_1.fswtw_:SetDirty()
				arg_7_1:ShowNextGo(true)

				arg_7_1.typewritterCharCountI18N = var_10_9
			end

			local var_10_14 = 0.333333333333333

			if var_10_14 < arg_7_1.time_ and arg_7_1.time_ <= var_10_14 + arg_10_0 then
				arg_7_1.var_.oldValueTypewriter = arg_7_1.fswtw_.percent

				SetActive(arg_7_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_7_1:ShowNextGo(false)
			end

			local var_10_15 = 14
			local var_10_16 = 0.933333333333333
			local var_10_17 = arg_7_1:GetWordFromCfg(319651002)
			local var_10_18 = arg_7_1:FormatText(var_10_17.content)
			local var_10_19, var_10_20 = arg_7_1:GetPercentByPara(var_10_18, 1)

			if var_10_14 < arg_7_1.time_ and arg_7_1.time_ <= var_10_14 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0

				local var_10_21 = var_10_15 <= 0 and var_10_16 or var_10_16 * ((var_10_20 - arg_7_1.typewritterCharCountI18N) / var_10_15)

				if var_10_21 > 0 and var_10_16 < var_10_21 then
					arg_7_1.talkMaxDuration = var_10_21

					if var_10_21 + var_10_14 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_21 + var_10_14
					end
				end
			end

			local var_10_22 = 0.933333333333333
			local var_10_23 = math.max(var_10_22, arg_7_1.talkMaxDuration)

			if var_10_14 <= arg_7_1.time_ and arg_7_1.time_ < var_10_14 + var_10_23 then
				local var_10_24 = (arg_7_1.time_ - var_10_14) / var_10_23

				arg_7_1.fswtw_.percent = Mathf.Lerp(arg_7_1.var_.oldValueTypewriter, var_10_19, var_10_24)
				arg_7_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_7_1.fswtw_:SetDirty()
			end

			if arg_7_1.time_ >= var_10_14 + var_10_23 and arg_7_1.time_ < var_10_14 + var_10_23 + arg_10_0 then
				arg_7_1.fswtw_.percent = var_10_19

				arg_7_1.fswtw_:SetDirty()
				arg_7_1:ShowNextGo(true)

				arg_7_1.typewritterCharCountI18N = var_10_20
			end

			local var_10_25 = 0.333333333333333
			local var_10_26 = 2.8
			local var_10_27 = manager.audio:GetVoiceLength("story_v_out_319651", "319651002", "story_v_out_319651.awb") / 1000

			if var_10_27 > 0 and var_10_26 < var_10_27 and var_10_27 + var_10_25 > arg_7_1.duration_ then
				local var_10_28 = var_10_27

				arg_7_1.duration_ = var_10_27 + var_10_25
			end

			if var_10_25 < arg_7_1.time_ and arg_7_1.time_ <= var_10_25 + arg_10_0 then
				local var_10_29 = "play"
				local var_10_30 = "voice"

				arg_7_1:AudioAction(var_10_29, var_10_30, "story_v_out_319651", "319651002", "story_v_out_319651.awb")
			end
		end

		arg_7_1.nodeConfigList_ = {}

		arg_7_1:InitPlayNodeList()
	end,
	Play319651003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 319651003
		arg_11_1.duration_ = 7.87

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play319651004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			local var_14_0 = "ST74"

			if arg_11_1.bgs_[var_14_0] == nil then
				local var_14_1 = Object.Instantiate(arg_11_1.paintGo_)

				var_14_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_14_0)
				var_14_1.name = var_14_0
				var_14_1.transform.parent = arg_11_1.stage_.transform
				var_14_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_11_1.bgs_[var_14_0] = var_14_1
			end

			local var_14_2 = 1

			if var_14_2 < arg_11_1.time_ and arg_11_1.time_ <= var_14_2 + arg_14_0 then
				local var_14_3 = manager.ui.mainCamera.transform.localPosition
				local var_14_4 = Vector3.New(0, 0, 10) + Vector3.New(var_14_3.x, var_14_3.y, 0)
				local var_14_5 = arg_11_1.bgs_.ST74

				var_14_5.transform.localPosition = var_14_4
				var_14_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_14_6 = var_14_5:GetComponent("SpriteRenderer")

				if var_14_6 and var_14_6.sprite then
					local var_14_7 = (var_14_5.transform.localPosition - var_14_3).z
					local var_14_8 = manager.ui.mainCameraCom_
					local var_14_9 = 2 * var_14_7 * Mathf.Tan(var_14_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_14_10 = var_14_9 * var_14_8.aspect
					local var_14_11 = var_14_6.sprite.bounds.size.x
					local var_14_12 = var_14_6.sprite.bounds.size.y
					local var_14_13 = var_14_10 / var_14_11
					local var_14_14 = var_14_9 / var_14_12
					local var_14_15 = var_14_14 < var_14_13 and var_14_13 or var_14_14

					var_14_5.transform.localScale = Vector3.New(var_14_15, var_14_15, 0)
				end

				for iter_14_0, iter_14_1 in pairs(arg_11_1.bgs_) do
					if iter_14_0 ~= "ST74" then
						iter_14_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_14_16 = 0

			if var_14_16 < arg_11_1.time_ and arg_11_1.time_ <= var_14_16 + arg_14_0 then
				arg_11_1.mask_.enabled = true
				arg_11_1.mask_.raycastTarget = true

				arg_11_1:SetGaussion(false)
			end

			local var_14_17 = 1

			if var_14_16 <= arg_11_1.time_ and arg_11_1.time_ < var_14_16 + var_14_17 then
				local var_14_18 = (arg_11_1.time_ - var_14_16) / var_14_17
				local var_14_19 = Color.New(0, 0, 0)

				var_14_19.a = Mathf.Lerp(0, 1, var_14_18)
				arg_11_1.mask_.color = var_14_19
			end

			if arg_11_1.time_ >= var_14_16 + var_14_17 and arg_11_1.time_ < var_14_16 + var_14_17 + arg_14_0 then
				local var_14_20 = Color.New(0, 0, 0)

				var_14_20.a = 1
				arg_11_1.mask_.color = var_14_20
			end

			local var_14_21 = 1

			if var_14_21 < arg_11_1.time_ and arg_11_1.time_ <= var_14_21 + arg_14_0 then
				arg_11_1.mask_.enabled = true
				arg_11_1.mask_.raycastTarget = true

				arg_11_1:SetGaussion(false)
			end

			local var_14_22 = 2

			if var_14_21 <= arg_11_1.time_ and arg_11_1.time_ < var_14_21 + var_14_22 then
				local var_14_23 = (arg_11_1.time_ - var_14_21) / var_14_22
				local var_14_24 = Color.New(0, 0, 0)

				var_14_24.a = Mathf.Lerp(1, 0, var_14_23)
				arg_11_1.mask_.color = var_14_24
			end

			if arg_11_1.time_ >= var_14_21 + var_14_22 and arg_11_1.time_ < var_14_21 + var_14_22 + arg_14_0 then
				local var_14_25 = Color.New(0, 0, 0)
				local var_14_26 = 0

				arg_11_1.mask_.enabled = false
				var_14_25.a = var_14_26
				arg_11_1.mask_.color = var_14_25
			end

			local var_14_27 = 1

			if var_14_27 < arg_11_1.time_ and arg_11_1.time_ <= var_14_27 + arg_14_0 then
				arg_11_1.cswbg_:SetActive(false)
			end

			local var_14_28 = 1

			if var_14_28 < arg_11_1.time_ and arg_11_1.time_ <= var_14_28 + arg_14_0 then
				arg_11_1.fswbg_:SetActive(false)
				arg_11_1.dialog_:SetActive(false)
				SetActive(arg_11_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_11_1:ShowNextGo(false)
			end

			local var_14_29 = 1.149999999999

			if var_14_29 < arg_11_1.time_ and arg_11_1.time_ <= var_14_29 + arg_14_0 then
				arg_11_1.var_.oldValueTypewriter = arg_11_1.fswtw_.percent

				SetActive(arg_11_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_11_1:ShowNextGo(false)
			end

			local var_14_30 = 0
			local var_14_31 = 0
			local var_14_32 = arg_11_1:GetWordFromCfg(319651002)
			local var_14_33 = arg_11_1:FormatText(var_14_32.content)
			local var_14_34, var_14_35 = arg_11_1:GetPercentByPara(var_14_33, 1)

			if var_14_29 < arg_11_1.time_ and arg_11_1.time_ <= var_14_29 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0

				local var_14_36 = var_14_30 <= 0 and var_14_31 or var_14_31 * ((var_14_35 - arg_11_1.typewritterCharCountI18N) / var_14_30)

				if var_14_36 > 0 and var_14_31 < var_14_36 then
					arg_11_1.talkMaxDuration = var_14_36

					if var_14_36 + var_14_29 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_36 + var_14_29
					end
				end
			end

			local var_14_37 = 0
			local var_14_38 = math.max(var_14_37, arg_11_1.talkMaxDuration)

			if var_14_29 <= arg_11_1.time_ and arg_11_1.time_ < var_14_29 + var_14_38 then
				local var_14_39 = (arg_11_1.time_ - var_14_29) / var_14_38

				arg_11_1.fswtw_.percent = Mathf.Lerp(arg_11_1.var_.oldValueTypewriter, var_14_34, var_14_39)
				arg_11_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_11_1.fswtw_:SetDirty()
			end

			if arg_11_1.time_ >= var_14_29 + var_14_38 and arg_11_1.time_ < var_14_29 + var_14_38 + arg_14_0 then
				arg_11_1.fswtw_.percent = var_14_34

				arg_11_1.fswtw_:SetDirty()
				arg_11_1:ShowNextGo(true)

				arg_11_1.typewritterCharCountI18N = var_14_35
			end

			local var_14_40 = 1.15

			if var_14_40 < arg_11_1.time_ and arg_11_1.time_ <= var_14_40 + arg_14_0 then
				arg_11_1.fswbg_:SetActive(false)
				arg_11_1.dialog_:SetActive(false)
				SetActive(arg_11_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_11_1:ShowNextGo(false)
			end

			if arg_11_1.frameCnt_ <= 1 then
				arg_11_1.dialog_:SetActive(false)
			end

			local var_14_41 = 2.86666666666667
			local var_14_42 = 1

			if var_14_41 < arg_11_1.time_ and arg_11_1.time_ <= var_14_41 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0

				arg_11_1.dialog_:SetActive(true)

				arg_11_1.dialogCg_.alpha = 0

				local var_14_43 = LeanTween.value(arg_11_1.dialog_, 0, 1, 0.3)

				var_14_43:setOnUpdate(LuaHelper.FloatAction(function(arg_15_0)
					arg_11_1.dialogCg_.alpha = arg_15_0
				end))
				var_14_43:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_11_1.dialog_)
					var_14_43:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_11_1.duration_ = arg_11_1.duration_ + 0.3

				SetActive(arg_11_1.leftNameGo_, false)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_44 = arg_11_1:GetWordFromCfg(319651003)
				local var_14_45 = arg_11_1:FormatText(var_14_44.content)

				arg_11_1.text_.text = var_14_45

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_46 = 40
				local var_14_47 = utf8.len(var_14_45)
				local var_14_48 = var_14_46 <= 0 and var_14_42 or var_14_42 * (var_14_47 / var_14_46)

				if var_14_48 > 0 and var_14_42 < var_14_48 then
					arg_11_1.talkMaxDuration = var_14_48
					var_14_41 = var_14_41 + 0.3

					if var_14_48 + var_14_41 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_48 + var_14_41
					end
				end

				arg_11_1.text_.text = var_14_45
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)
				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_49 = var_14_41 + 0.3
			local var_14_50 = math.max(var_14_42, arg_11_1.talkMaxDuration)

			if var_14_49 <= arg_11_1.time_ and arg_11_1.time_ < var_14_49 + var_14_50 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_49) / var_14_50

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_49 + var_14_50 and arg_11_1.time_ < var_14_49 + var_14_50 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end

		arg_11_1.nodeConfigList_ = {}

		arg_11_1:InitPlayNodeList()
	end,
	Play319651004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 319651004
		arg_17_1.duration_ = 14.43

		local var_17_0 = {
			zh = 8.5,
			ja = 14.433
		}
		local var_17_1 = manager.audio:GetLocalizationFlag()

		if var_17_0[var_17_1] ~= nil then
			arg_17_1.duration_ = var_17_0[var_17_1]
		end

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play319651005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = "10058ui_story"

			if arg_17_1.actors_[var_20_0] == nil then
				local var_20_1 = Asset.Load("Char/" .. "10058ui_story")

				if not isNil(var_20_1) then
					local var_20_2 = Object.Instantiate(Asset.Load("Char/" .. "10058ui_story"), arg_17_1.stage_.transform)

					var_20_2.name = var_20_0
					var_20_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_17_1.actors_[var_20_0] = var_20_2

					local var_20_3 = var_20_2:GetComponentInChildren(typeof(CharacterEffect))

					var_20_3.enabled = true

					local var_20_4 = GameObjectTools.GetOrAddComponent(var_20_2, typeof(DynamicBoneHelper))

					if var_20_4 then
						var_20_4:EnableDynamicBone(false)
					end

					arg_17_1:ShowWeapon(var_20_3.transform, false)

					arg_17_1.var_[var_20_0 .. "Animator"] = var_20_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_17_1.var_[var_20_0 .. "Animator"].applyRootMotion = true
					arg_17_1.var_[var_20_0 .. "LipSync"] = var_20_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_20_5 = arg_17_1.actors_["10058ui_story"].transform
			local var_20_6 = 0

			if var_20_6 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
				arg_17_1.var_.moveOldPos10058ui_story = var_20_5.localPosition
			end

			local var_20_7 = 0.001

			if var_20_6 <= arg_17_1.time_ and arg_17_1.time_ < var_20_6 + var_20_7 then
				local var_20_8 = (arg_17_1.time_ - var_20_6) / var_20_7
				local var_20_9 = Vector3.New(0, -0.98, -6.1)

				var_20_5.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10058ui_story, var_20_9, var_20_8)

				local var_20_10 = manager.ui.mainCamera.transform.position - var_20_5.position

				var_20_5.forward = Vector3.New(var_20_10.x, var_20_10.y, var_20_10.z)

				local var_20_11 = var_20_5.localEulerAngles

				var_20_11.z = 0
				var_20_11.x = 0
				var_20_5.localEulerAngles = var_20_11
			end

			if arg_17_1.time_ >= var_20_6 + var_20_7 and arg_17_1.time_ < var_20_6 + var_20_7 + arg_20_0 then
				var_20_5.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_20_12 = manager.ui.mainCamera.transform.position - var_20_5.position

				var_20_5.forward = Vector3.New(var_20_12.x, var_20_12.y, var_20_12.z)

				local var_20_13 = var_20_5.localEulerAngles

				var_20_13.z = 0
				var_20_13.x = 0
				var_20_5.localEulerAngles = var_20_13
			end

			local var_20_14 = arg_17_1.actors_["10058ui_story"]
			local var_20_15 = 0

			if var_20_15 < arg_17_1.time_ and arg_17_1.time_ <= var_20_15 + arg_20_0 and not isNil(var_20_14) and arg_17_1.var_.characterEffect10058ui_story == nil then
				arg_17_1.var_.characterEffect10058ui_story = var_20_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_16 = 0.200000002980232

			if var_20_15 <= arg_17_1.time_ and arg_17_1.time_ < var_20_15 + var_20_16 and not isNil(var_20_14) then
				local var_20_17 = (arg_17_1.time_ - var_20_15) / var_20_16

				if arg_17_1.var_.characterEffect10058ui_story and not isNil(var_20_14) then
					arg_17_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_15 + var_20_16 and arg_17_1.time_ < var_20_15 + var_20_16 + arg_20_0 and not isNil(var_20_14) and arg_17_1.var_.characterEffect10058ui_story then
				arg_17_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_20_18 = 0

			if var_20_18 < arg_17_1.time_ and arg_17_1.time_ <= var_20_18 + arg_20_0 then
				arg_17_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_20_19 = 0

			if var_20_19 < arg_17_1.time_ and arg_17_1.time_ <= var_20_19 + arg_20_0 then
				arg_17_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_20_20 = 0
			local var_20_21 = 1.025

			if var_20_20 < arg_17_1.time_ and arg_17_1.time_ <= var_20_20 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_22 = arg_17_1:FormatText(StoryNameCfg[471].name)

				arg_17_1.leftNameTxt_.text = var_20_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_23 = arg_17_1:GetWordFromCfg(319651004)
				local var_20_24 = arg_17_1:FormatText(var_20_23.content)

				arg_17_1.text_.text = var_20_24

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_25 = 41
				local var_20_26 = utf8.len(var_20_24)
				local var_20_27 = var_20_25 <= 0 and var_20_21 or var_20_21 * (var_20_26 / var_20_25)

				if var_20_27 > 0 and var_20_21 < var_20_27 then
					arg_17_1.talkMaxDuration = var_20_27

					if var_20_27 + var_20_20 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_27 + var_20_20
					end
				end

				arg_17_1.text_.text = var_20_24
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651004", "story_v_out_319651.awb") ~= 0 then
					local var_20_28 = manager.audio:GetVoiceLength("story_v_out_319651", "319651004", "story_v_out_319651.awb") / 1000

					if var_20_28 + var_20_20 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_28 + var_20_20
					end

					if var_20_23.prefab_name ~= "" and arg_17_1.actors_[var_20_23.prefab_name] ~= nil then
						local var_20_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_23.prefab_name].transform, "story_v_out_319651", "319651004", "story_v_out_319651.awb")

						arg_17_1:RecordAudio("319651004", var_20_29)
						arg_17_1:RecordAudio("319651004", var_20_29)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_319651", "319651004", "story_v_out_319651.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_319651", "319651004", "story_v_out_319651.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_30 = math.max(var_20_21, arg_17_1.talkMaxDuration)

			if var_20_20 <= arg_17_1.time_ and arg_17_1.time_ < var_20_20 + var_20_30 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_20) / var_20_30

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_20 + var_20_30 and arg_17_1.time_ < var_20_20 + var_20_30 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play319651005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 319651005
		arg_21_1.duration_ = 7.4

		local var_21_0 = {
			zh = 2.9,
			ja = 7.4
		}
		local var_21_1 = manager.audio:GetLocalizationFlag()

		if var_21_0[var_21_1] ~= nil then
			arg_21_1.duration_ = var_21_0[var_21_1]
		end

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play319651006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = "1084ui_story"

			if arg_21_1.actors_[var_24_0] == nil then
				local var_24_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_24_1) then
					local var_24_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_21_1.stage_.transform)

					var_24_2.name = var_24_0
					var_24_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_21_1.actors_[var_24_0] = var_24_2

					local var_24_3 = var_24_2:GetComponentInChildren(typeof(CharacterEffect))

					var_24_3.enabled = true

					local var_24_4 = GameObjectTools.GetOrAddComponent(var_24_2, typeof(DynamicBoneHelper))

					if var_24_4 then
						var_24_4:EnableDynamicBone(false)
					end

					arg_21_1:ShowWeapon(var_24_3.transform, false)

					arg_21_1.var_[var_24_0 .. "Animator"] = var_24_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_21_1.var_[var_24_0 .. "Animator"].applyRootMotion = true
					arg_21_1.var_[var_24_0 .. "LipSync"] = var_24_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_24_5 = arg_21_1.actors_["1084ui_story"].transform
			local var_24_6 = 0

			if var_24_6 < arg_21_1.time_ and arg_21_1.time_ <= var_24_6 + arg_24_0 then
				arg_21_1.var_.moveOldPos1084ui_story = var_24_5.localPosition
			end

			local var_24_7 = 0.001

			if var_24_6 <= arg_21_1.time_ and arg_21_1.time_ < var_24_6 + var_24_7 then
				local var_24_8 = (arg_21_1.time_ - var_24_6) / var_24_7
				local var_24_9 = Vector3.New(0.7, -0.97, -6)

				var_24_5.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1084ui_story, var_24_9, var_24_8)

				local var_24_10 = manager.ui.mainCamera.transform.position - var_24_5.position

				var_24_5.forward = Vector3.New(var_24_10.x, var_24_10.y, var_24_10.z)

				local var_24_11 = var_24_5.localEulerAngles

				var_24_11.z = 0
				var_24_11.x = 0
				var_24_5.localEulerAngles = var_24_11
			end

			if arg_21_1.time_ >= var_24_6 + var_24_7 and arg_21_1.time_ < var_24_6 + var_24_7 + arg_24_0 then
				var_24_5.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_24_12 = manager.ui.mainCamera.transform.position - var_24_5.position

				var_24_5.forward = Vector3.New(var_24_12.x, var_24_12.y, var_24_12.z)

				local var_24_13 = var_24_5.localEulerAngles

				var_24_13.z = 0
				var_24_13.x = 0
				var_24_5.localEulerAngles = var_24_13
			end

			local var_24_14 = arg_21_1.actors_["1084ui_story"]
			local var_24_15 = 0

			if var_24_15 < arg_21_1.time_ and arg_21_1.time_ <= var_24_15 + arg_24_0 and not isNil(var_24_14) and arg_21_1.var_.characterEffect1084ui_story == nil then
				arg_21_1.var_.characterEffect1084ui_story = var_24_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_16 = 0.200000002980232

			if var_24_15 <= arg_21_1.time_ and arg_21_1.time_ < var_24_15 + var_24_16 and not isNil(var_24_14) then
				local var_24_17 = (arg_21_1.time_ - var_24_15) / var_24_16

				if arg_21_1.var_.characterEffect1084ui_story and not isNil(var_24_14) then
					arg_21_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_15 + var_24_16 and arg_21_1.time_ < var_24_15 + var_24_16 + arg_24_0 and not isNil(var_24_14) and arg_21_1.var_.characterEffect1084ui_story then
				arg_21_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_24_18 = 0

			if var_24_18 < arg_21_1.time_ and arg_21_1.time_ <= var_24_18 + arg_24_0 then
				arg_21_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_24_19 = 0

			if var_24_19 < arg_21_1.time_ and arg_21_1.time_ <= var_24_19 + arg_24_0 then
				arg_21_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_24_20 = arg_21_1.actors_["10058ui_story"].transform
			local var_24_21 = 0

			if var_24_21 < arg_21_1.time_ and arg_21_1.time_ <= var_24_21 + arg_24_0 then
				arg_21_1.var_.moveOldPos10058ui_story = var_24_20.localPosition
			end

			local var_24_22 = 0.001

			if var_24_21 <= arg_21_1.time_ and arg_21_1.time_ < var_24_21 + var_24_22 then
				local var_24_23 = (arg_21_1.time_ - var_24_21) / var_24_22
				local var_24_24 = Vector3.New(-0.7, -0.98, -6.1)

				var_24_20.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10058ui_story, var_24_24, var_24_23)

				local var_24_25 = manager.ui.mainCamera.transform.position - var_24_20.position

				var_24_20.forward = Vector3.New(var_24_25.x, var_24_25.y, var_24_25.z)

				local var_24_26 = var_24_20.localEulerAngles

				var_24_26.z = 0
				var_24_26.x = 0
				var_24_20.localEulerAngles = var_24_26
			end

			if arg_21_1.time_ >= var_24_21 + var_24_22 and arg_21_1.time_ < var_24_21 + var_24_22 + arg_24_0 then
				var_24_20.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_24_27 = manager.ui.mainCamera.transform.position - var_24_20.position

				var_24_20.forward = Vector3.New(var_24_27.x, var_24_27.y, var_24_27.z)

				local var_24_28 = var_24_20.localEulerAngles

				var_24_28.z = 0
				var_24_28.x = 0
				var_24_20.localEulerAngles = var_24_28
			end

			local var_24_29 = arg_21_1.actors_["10058ui_story"]
			local var_24_30 = 0

			if var_24_30 < arg_21_1.time_ and arg_21_1.time_ <= var_24_30 + arg_24_0 and not isNil(var_24_29) and arg_21_1.var_.characterEffect10058ui_story == nil then
				arg_21_1.var_.characterEffect10058ui_story = var_24_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_31 = 0.200000002980232

			if var_24_30 <= arg_21_1.time_ and arg_21_1.time_ < var_24_30 + var_24_31 and not isNil(var_24_29) then
				local var_24_32 = (arg_21_1.time_ - var_24_30) / var_24_31

				if arg_21_1.var_.characterEffect10058ui_story and not isNil(var_24_29) then
					local var_24_33 = Mathf.Lerp(0, 0.5, var_24_32)

					arg_21_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_21_1.var_.characterEffect10058ui_story.fillRatio = var_24_33
				end
			end

			if arg_21_1.time_ >= var_24_30 + var_24_31 and arg_21_1.time_ < var_24_30 + var_24_31 + arg_24_0 and not isNil(var_24_29) and arg_21_1.var_.characterEffect10058ui_story then
				local var_24_34 = 0.5

				arg_21_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_21_1.var_.characterEffect10058ui_story.fillRatio = var_24_34
			end

			local var_24_35 = 0
			local var_24_36 = 0.275

			if var_24_35 < arg_21_1.time_ and arg_21_1.time_ <= var_24_35 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_37 = arg_21_1:FormatText(StoryNameCfg[6].name)

				arg_21_1.leftNameTxt_.text = var_24_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_38 = arg_21_1:GetWordFromCfg(319651005)
				local var_24_39 = arg_21_1:FormatText(var_24_38.content)

				arg_21_1.text_.text = var_24_39

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_40 = 11
				local var_24_41 = utf8.len(var_24_39)
				local var_24_42 = var_24_40 <= 0 and var_24_36 or var_24_36 * (var_24_41 / var_24_40)

				if var_24_42 > 0 and var_24_36 < var_24_42 then
					arg_21_1.talkMaxDuration = var_24_42

					if var_24_42 + var_24_35 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_42 + var_24_35
					end
				end

				arg_21_1.text_.text = var_24_39
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651005", "story_v_out_319651.awb") ~= 0 then
					local var_24_43 = manager.audio:GetVoiceLength("story_v_out_319651", "319651005", "story_v_out_319651.awb") / 1000

					if var_24_43 + var_24_35 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_43 + var_24_35
					end

					if var_24_38.prefab_name ~= "" and arg_21_1.actors_[var_24_38.prefab_name] ~= nil then
						local var_24_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_38.prefab_name].transform, "story_v_out_319651", "319651005", "story_v_out_319651.awb")

						arg_21_1:RecordAudio("319651005", var_24_44)
						arg_21_1:RecordAudio("319651005", var_24_44)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_319651", "319651005", "story_v_out_319651.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_319651", "319651005", "story_v_out_319651.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_45 = math.max(var_24_36, arg_21_1.talkMaxDuration)

			if var_24_35 <= arg_21_1.time_ and arg_21_1.time_ < var_24_35 + var_24_45 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_35) / var_24_45

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_35 + var_24_45 and arg_21_1.time_ < var_24_35 + var_24_45 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play319651006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 319651006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play319651007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1084ui_story"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1084ui_story == nil then
				arg_25_1.var_.characterEffect1084ui_story = var_28_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.characterEffect1084ui_story and not isNil(var_28_0) then
					local var_28_4 = Mathf.Lerp(0, 0.5, var_28_3)

					arg_25_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1084ui_story.fillRatio = var_28_4
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1084ui_story then
				local var_28_5 = 0.5

				arg_25_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1084ui_story.fillRatio = var_28_5
			end

			local var_28_6 = 0
			local var_28_7 = 1.2

			if var_28_6 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_8 = arg_25_1:GetWordFromCfg(319651006)
				local var_28_9 = arg_25_1:FormatText(var_28_8.content)

				arg_25_1.text_.text = var_28_9

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_10 = 48
				local var_28_11 = utf8.len(var_28_9)
				local var_28_12 = var_28_10 <= 0 and var_28_7 or var_28_7 * (var_28_11 / var_28_10)

				if var_28_12 > 0 and var_28_7 < var_28_12 then
					arg_25_1.talkMaxDuration = var_28_12

					if var_28_12 + var_28_6 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_12 + var_28_6
					end
				end

				arg_25_1.text_.text = var_28_9
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_13 = math.max(var_28_7, arg_25_1.talkMaxDuration)

			if var_28_6 <= arg_25_1.time_ and arg_25_1.time_ < var_28_6 + var_28_13 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_6) / var_28_13

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_6 + var_28_13 and arg_25_1.time_ < var_28_6 + var_28_13 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play319651007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 319651007
		arg_29_1.duration_ = 6.23

		local var_29_0 = {
			zh = 6.233,
			ja = 3.833
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
				arg_29_0:Play319651008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["10058ui_story"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect10058ui_story == nil then
				arg_29_1.var_.characterEffect10058ui_story = var_32_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.characterEffect10058ui_story and not isNil(var_32_0) then
					arg_29_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect10058ui_story then
				arg_29_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_32_4 = 0

			if var_32_4 < arg_29_1.time_ and arg_29_1.time_ <= var_32_4 + arg_32_0 then
				arg_29_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_32_5 = 0

			if var_32_5 < arg_29_1.time_ and arg_29_1.time_ <= var_32_5 + arg_32_0 then
				arg_29_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_32_6 = 0
			local var_32_7 = 0.55

			if var_32_6 < arg_29_1.time_ and arg_29_1.time_ <= var_32_6 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_8 = arg_29_1:FormatText(StoryNameCfg[471].name)

				arg_29_1.leftNameTxt_.text = var_32_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_9 = arg_29_1:GetWordFromCfg(319651007)
				local var_32_10 = arg_29_1:FormatText(var_32_9.content)

				arg_29_1.text_.text = var_32_10

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_11 = 22
				local var_32_12 = utf8.len(var_32_10)
				local var_32_13 = var_32_11 <= 0 and var_32_7 or var_32_7 * (var_32_12 / var_32_11)

				if var_32_13 > 0 and var_32_7 < var_32_13 then
					arg_29_1.talkMaxDuration = var_32_13

					if var_32_13 + var_32_6 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_13 + var_32_6
					end
				end

				arg_29_1.text_.text = var_32_10
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651007", "story_v_out_319651.awb") ~= 0 then
					local var_32_14 = manager.audio:GetVoiceLength("story_v_out_319651", "319651007", "story_v_out_319651.awb") / 1000

					if var_32_14 + var_32_6 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_14 + var_32_6
					end

					if var_32_9.prefab_name ~= "" and arg_29_1.actors_[var_32_9.prefab_name] ~= nil then
						local var_32_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_9.prefab_name].transform, "story_v_out_319651", "319651007", "story_v_out_319651.awb")

						arg_29_1:RecordAudio("319651007", var_32_15)
						arg_29_1:RecordAudio("319651007", var_32_15)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_319651", "319651007", "story_v_out_319651.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_319651", "319651007", "story_v_out_319651.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_16 = math.max(var_32_7, arg_29_1.talkMaxDuration)

			if var_32_6 <= arg_29_1.time_ and arg_29_1.time_ < var_32_6 + var_32_16 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_6) / var_32_16

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_6 + var_32_16 and arg_29_1.time_ < var_32_6 + var_32_16 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play319651008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 319651008
		arg_33_1.duration_ = 9.3

		local var_33_0 = {
			zh = 9.3,
			ja = 9.133
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
				arg_33_0:Play319651009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0
			local var_36_1 = 1.125

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_2 = arg_33_1:FormatText(StoryNameCfg[471].name)

				arg_33_1.leftNameTxt_.text = var_36_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_3 = arg_33_1:GetWordFromCfg(319651008)
				local var_36_4 = arg_33_1:FormatText(var_36_3.content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 45
				local var_36_6 = utf8.len(var_36_4)
				local var_36_7 = var_36_5 <= 0 and var_36_1 or var_36_1 * (var_36_6 / var_36_5)

				if var_36_7 > 0 and var_36_1 < var_36_7 then
					arg_33_1.talkMaxDuration = var_36_7

					if var_36_7 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_7 + var_36_0
					end
				end

				arg_33_1.text_.text = var_36_4
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651008", "story_v_out_319651.awb") ~= 0 then
					local var_36_8 = manager.audio:GetVoiceLength("story_v_out_319651", "319651008", "story_v_out_319651.awb") / 1000

					if var_36_8 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_8 + var_36_0
					end

					if var_36_3.prefab_name ~= "" and arg_33_1.actors_[var_36_3.prefab_name] ~= nil then
						local var_36_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_3.prefab_name].transform, "story_v_out_319651", "319651008", "story_v_out_319651.awb")

						arg_33_1:RecordAudio("319651008", var_36_9)
						arg_33_1:RecordAudio("319651008", var_36_9)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_319651", "319651008", "story_v_out_319651.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_319651", "319651008", "story_v_out_319651.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_10 = math.max(var_36_1, arg_33_1.talkMaxDuration)

			if var_36_0 <= arg_33_1.time_ and arg_33_1.time_ < var_36_0 + var_36_10 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_0) / var_36_10

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_0 + var_36_10 and arg_33_1.time_ < var_36_0 + var_36_10 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play319651009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 319651009
		arg_37_1.duration_ = 9.2

		local var_37_0 = {
			zh = 9.2,
			ja = 8.466
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
				arg_37_0:Play319651010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["10058ui_story"].transform
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.var_.moveOldPos10058ui_story = var_40_0.localPosition
			end

			local var_40_2 = 0.001

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2
				local var_40_4 = Vector3.New(-0.7, -0.98, -6.1)

				var_40_0.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10058ui_story, var_40_4, var_40_3)

				local var_40_5 = manager.ui.mainCamera.transform.position - var_40_0.position

				var_40_0.forward = Vector3.New(var_40_5.x, var_40_5.y, var_40_5.z)

				local var_40_6 = var_40_0.localEulerAngles

				var_40_6.z = 0
				var_40_6.x = 0
				var_40_0.localEulerAngles = var_40_6
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 then
				var_40_0.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_40_7 = manager.ui.mainCamera.transform.position - var_40_0.position

				var_40_0.forward = Vector3.New(var_40_7.x, var_40_7.y, var_40_7.z)

				local var_40_8 = var_40_0.localEulerAngles

				var_40_8.z = 0
				var_40_8.x = 0
				var_40_0.localEulerAngles = var_40_8
			end

			local var_40_9 = 0

			if var_40_9 < arg_37_1.time_ and arg_37_1.time_ <= var_40_9 + arg_40_0 then
				arg_37_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action7_1")
			end

			local var_40_10 = 0

			if var_40_10 < arg_37_1.time_ and arg_37_1.time_ <= var_40_10 + arg_40_0 then
				arg_37_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_40_11 = 0
			local var_40_12 = 1.05

			if var_40_11 < arg_37_1.time_ and arg_37_1.time_ <= var_40_11 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_13 = arg_37_1:FormatText(StoryNameCfg[471].name)

				arg_37_1.leftNameTxt_.text = var_40_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_14 = arg_37_1:GetWordFromCfg(319651009)
				local var_40_15 = arg_37_1:FormatText(var_40_14.content)

				arg_37_1.text_.text = var_40_15

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_16 = 42
				local var_40_17 = utf8.len(var_40_15)
				local var_40_18 = var_40_16 <= 0 and var_40_12 or var_40_12 * (var_40_17 / var_40_16)

				if var_40_18 > 0 and var_40_12 < var_40_18 then
					arg_37_1.talkMaxDuration = var_40_18

					if var_40_18 + var_40_11 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_18 + var_40_11
					end
				end

				arg_37_1.text_.text = var_40_15
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651009", "story_v_out_319651.awb") ~= 0 then
					local var_40_19 = manager.audio:GetVoiceLength("story_v_out_319651", "319651009", "story_v_out_319651.awb") / 1000

					if var_40_19 + var_40_11 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_19 + var_40_11
					end

					if var_40_14.prefab_name ~= "" and arg_37_1.actors_[var_40_14.prefab_name] ~= nil then
						local var_40_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_14.prefab_name].transform, "story_v_out_319651", "319651009", "story_v_out_319651.awb")

						arg_37_1:RecordAudio("319651009", var_40_20)
						arg_37_1:RecordAudio("319651009", var_40_20)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_319651", "319651009", "story_v_out_319651.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_319651", "319651009", "story_v_out_319651.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_21 = math.max(var_40_12, arg_37_1.talkMaxDuration)

			if var_40_11 <= arg_37_1.time_ and arg_37_1.time_ < var_40_11 + var_40_21 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_11) / var_40_21

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_11 + var_40_21 and arg_37_1.time_ < var_40_11 + var_40_21 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play319651010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 319651010
		arg_41_1.duration_ = 5.03

		local var_41_0 = {
			zh = 4.333,
			ja = 5.033
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
				arg_41_0:Play319651011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1084ui_story"].transform
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.var_.moveOldPos1084ui_story = var_44_0.localPosition
			end

			local var_44_2 = 0.001

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2
				local var_44_4 = Vector3.New(0.7, -0.97, -6)

				var_44_0.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1084ui_story, var_44_4, var_44_3)

				local var_44_5 = manager.ui.mainCamera.transform.position - var_44_0.position

				var_44_0.forward = Vector3.New(var_44_5.x, var_44_5.y, var_44_5.z)

				local var_44_6 = var_44_0.localEulerAngles

				var_44_6.z = 0
				var_44_6.x = 0
				var_44_0.localEulerAngles = var_44_6
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 then
				var_44_0.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_44_7 = manager.ui.mainCamera.transform.position - var_44_0.position

				var_44_0.forward = Vector3.New(var_44_7.x, var_44_7.y, var_44_7.z)

				local var_44_8 = var_44_0.localEulerAngles

				var_44_8.z = 0
				var_44_8.x = 0
				var_44_0.localEulerAngles = var_44_8
			end

			local var_44_9 = arg_41_1.actors_["1084ui_story"]
			local var_44_10 = 0

			if var_44_10 < arg_41_1.time_ and arg_41_1.time_ <= var_44_10 + arg_44_0 and not isNil(var_44_9) and arg_41_1.var_.characterEffect1084ui_story == nil then
				arg_41_1.var_.characterEffect1084ui_story = var_44_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_11 = 0.200000002980232

			if var_44_10 <= arg_41_1.time_ and arg_41_1.time_ < var_44_10 + var_44_11 and not isNil(var_44_9) then
				local var_44_12 = (arg_41_1.time_ - var_44_10) / var_44_11

				if arg_41_1.var_.characterEffect1084ui_story and not isNil(var_44_9) then
					arg_41_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= var_44_10 + var_44_11 and arg_41_1.time_ < var_44_10 + var_44_11 + arg_44_0 and not isNil(var_44_9) and arg_41_1.var_.characterEffect1084ui_story then
				arg_41_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_44_13 = 0

			if var_44_13 < arg_41_1.time_ and arg_41_1.time_ <= var_44_13 + arg_44_0 then
				arg_41_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			local var_44_14 = 0

			if var_44_14 < arg_41_1.time_ and arg_41_1.time_ <= var_44_14 + arg_44_0 then
				arg_41_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_44_15 = arg_41_1.actors_["10058ui_story"]
			local var_44_16 = 0

			if var_44_16 < arg_41_1.time_ and arg_41_1.time_ <= var_44_16 + arg_44_0 and not isNil(var_44_15) and arg_41_1.var_.characterEffect10058ui_story == nil then
				arg_41_1.var_.characterEffect10058ui_story = var_44_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_17 = 0.200000002980232

			if var_44_16 <= arg_41_1.time_ and arg_41_1.time_ < var_44_16 + var_44_17 and not isNil(var_44_15) then
				local var_44_18 = (arg_41_1.time_ - var_44_16) / var_44_17

				if arg_41_1.var_.characterEffect10058ui_story and not isNil(var_44_15) then
					local var_44_19 = Mathf.Lerp(0, 0.5, var_44_18)

					arg_41_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_41_1.var_.characterEffect10058ui_story.fillRatio = var_44_19
				end
			end

			if arg_41_1.time_ >= var_44_16 + var_44_17 and arg_41_1.time_ < var_44_16 + var_44_17 + arg_44_0 and not isNil(var_44_15) and arg_41_1.var_.characterEffect10058ui_story then
				local var_44_20 = 0.5

				arg_41_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_41_1.var_.characterEffect10058ui_story.fillRatio = var_44_20
			end

			local var_44_21 = 0
			local var_44_22 = 0.45

			if var_44_21 < arg_41_1.time_ and arg_41_1.time_ <= var_44_21 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_23 = arg_41_1:FormatText(StoryNameCfg[6].name)

				arg_41_1.leftNameTxt_.text = var_44_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_24 = arg_41_1:GetWordFromCfg(319651010)
				local var_44_25 = arg_41_1:FormatText(var_44_24.content)

				arg_41_1.text_.text = var_44_25

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_26 = 18
				local var_44_27 = utf8.len(var_44_25)
				local var_44_28 = var_44_26 <= 0 and var_44_22 or var_44_22 * (var_44_27 / var_44_26)

				if var_44_28 > 0 and var_44_22 < var_44_28 then
					arg_41_1.talkMaxDuration = var_44_28

					if var_44_28 + var_44_21 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_28 + var_44_21
					end
				end

				arg_41_1.text_.text = var_44_25
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651010", "story_v_out_319651.awb") ~= 0 then
					local var_44_29 = manager.audio:GetVoiceLength("story_v_out_319651", "319651010", "story_v_out_319651.awb") / 1000

					if var_44_29 + var_44_21 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_29 + var_44_21
					end

					if var_44_24.prefab_name ~= "" and arg_41_1.actors_[var_44_24.prefab_name] ~= nil then
						local var_44_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_24.prefab_name].transform, "story_v_out_319651", "319651010", "story_v_out_319651.awb")

						arg_41_1:RecordAudio("319651010", var_44_30)
						arg_41_1:RecordAudio("319651010", var_44_30)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_319651", "319651010", "story_v_out_319651.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_319651", "319651010", "story_v_out_319651.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_31 = math.max(var_44_22, arg_41_1.talkMaxDuration)

			if var_44_21 <= arg_41_1.time_ and arg_41_1.time_ < var_44_21 + var_44_31 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_21) / var_44_31

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_21 + var_44_31 and arg_41_1.time_ < var_44_21 + var_44_31 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play319651011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 319651011
		arg_45_1.duration_ = 4.5

		local var_45_0 = {
			zh = 4.5,
			ja = 2.933
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
				arg_45_0:Play319651012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_2")
			end

			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_48_2 = 0
			local var_48_3 = 0.6

			if var_48_2 < arg_45_1.time_ and arg_45_1.time_ <= var_48_2 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_4 = arg_45_1:FormatText(StoryNameCfg[6].name)

				arg_45_1.leftNameTxt_.text = var_48_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_5 = arg_45_1:GetWordFromCfg(319651011)
				local var_48_6 = arg_45_1:FormatText(var_48_5.content)

				arg_45_1.text_.text = var_48_6

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_7 = 24
				local var_48_8 = utf8.len(var_48_6)
				local var_48_9 = var_48_7 <= 0 and var_48_3 or var_48_3 * (var_48_8 / var_48_7)

				if var_48_9 > 0 and var_48_3 < var_48_9 then
					arg_45_1.talkMaxDuration = var_48_9

					if var_48_9 + var_48_2 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_9 + var_48_2
					end
				end

				arg_45_1.text_.text = var_48_6
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651011", "story_v_out_319651.awb") ~= 0 then
					local var_48_10 = manager.audio:GetVoiceLength("story_v_out_319651", "319651011", "story_v_out_319651.awb") / 1000

					if var_48_10 + var_48_2 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_10 + var_48_2
					end

					if var_48_5.prefab_name ~= "" and arg_45_1.actors_[var_48_5.prefab_name] ~= nil then
						local var_48_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_5.prefab_name].transform, "story_v_out_319651", "319651011", "story_v_out_319651.awb")

						arg_45_1:RecordAudio("319651011", var_48_11)
						arg_45_1:RecordAudio("319651011", var_48_11)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_319651", "319651011", "story_v_out_319651.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_319651", "319651011", "story_v_out_319651.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_12 = math.max(var_48_3, arg_45_1.talkMaxDuration)

			if var_48_2 <= arg_45_1.time_ and arg_45_1.time_ < var_48_2 + var_48_12 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_2) / var_48_12

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_2 + var_48_12 and arg_45_1.time_ < var_48_2 + var_48_12 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play319651012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 319651012
		arg_49_1.duration_ = 5.47

		local var_49_0 = {
			zh = 3.333,
			ja = 5.466
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
				arg_49_0:Play319651013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["10058ui_story"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect10058ui_story == nil then
				arg_49_1.var_.characterEffect10058ui_story = var_52_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.characterEffect10058ui_story and not isNil(var_52_0) then
					arg_49_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect10058ui_story then
				arg_49_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_52_4 = arg_49_1.actors_["1084ui_story"]
			local var_52_5 = 0

			if var_52_5 < arg_49_1.time_ and arg_49_1.time_ <= var_52_5 + arg_52_0 and not isNil(var_52_4) and arg_49_1.var_.characterEffect1084ui_story == nil then
				arg_49_1.var_.characterEffect1084ui_story = var_52_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_6 = 0.200000002980232

			if var_52_5 <= arg_49_1.time_ and arg_49_1.time_ < var_52_5 + var_52_6 and not isNil(var_52_4) then
				local var_52_7 = (arg_49_1.time_ - var_52_5) / var_52_6

				if arg_49_1.var_.characterEffect1084ui_story and not isNil(var_52_4) then
					local var_52_8 = Mathf.Lerp(0, 0.5, var_52_7)

					arg_49_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1084ui_story.fillRatio = var_52_8
				end
			end

			if arg_49_1.time_ >= var_52_5 + var_52_6 and arg_49_1.time_ < var_52_5 + var_52_6 + arg_52_0 and not isNil(var_52_4) and arg_49_1.var_.characterEffect1084ui_story then
				local var_52_9 = 0.5

				arg_49_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1084ui_story.fillRatio = var_52_9
			end

			local var_52_10 = 0

			if var_52_10 < arg_49_1.time_ and arg_49_1.time_ <= var_52_10 + arg_52_0 then
				arg_49_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action7_2")
			end

			local var_52_11 = 0
			local var_52_12 = 0.425

			if var_52_11 < arg_49_1.time_ and arg_49_1.time_ <= var_52_11 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_13 = arg_49_1:FormatText(StoryNameCfg[471].name)

				arg_49_1.leftNameTxt_.text = var_52_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_14 = arg_49_1:GetWordFromCfg(319651012)
				local var_52_15 = arg_49_1:FormatText(var_52_14.content)

				arg_49_1.text_.text = var_52_15

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_16 = 17
				local var_52_17 = utf8.len(var_52_15)
				local var_52_18 = var_52_16 <= 0 and var_52_12 or var_52_12 * (var_52_17 / var_52_16)

				if var_52_18 > 0 and var_52_12 < var_52_18 then
					arg_49_1.talkMaxDuration = var_52_18

					if var_52_18 + var_52_11 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_18 + var_52_11
					end
				end

				arg_49_1.text_.text = var_52_15
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651012", "story_v_out_319651.awb") ~= 0 then
					local var_52_19 = manager.audio:GetVoiceLength("story_v_out_319651", "319651012", "story_v_out_319651.awb") / 1000

					if var_52_19 + var_52_11 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_19 + var_52_11
					end

					if var_52_14.prefab_name ~= "" and arg_49_1.actors_[var_52_14.prefab_name] ~= nil then
						local var_52_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_14.prefab_name].transform, "story_v_out_319651", "319651012", "story_v_out_319651.awb")

						arg_49_1:RecordAudio("319651012", var_52_20)
						arg_49_1:RecordAudio("319651012", var_52_20)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_319651", "319651012", "story_v_out_319651.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_319651", "319651012", "story_v_out_319651.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_21 = math.max(var_52_12, arg_49_1.talkMaxDuration)

			if var_52_11 <= arg_49_1.time_ and arg_49_1.time_ < var_52_11 + var_52_21 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_11) / var_52_21

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_11 + var_52_21 and arg_49_1.time_ < var_52_11 + var_52_21 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play319651013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 319651013
		arg_53_1.duration_ = 8.37

		local var_53_0 = {
			zh = 3.966,
			ja = 8.366
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
				arg_53_0:Play319651014(arg_53_1)
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

				local var_56_2 = arg_53_1:FormatText(StoryNameCfg[471].name)

				arg_53_1.leftNameTxt_.text = var_56_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_3 = arg_53_1:GetWordFromCfg(319651013)
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

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651013", "story_v_out_319651.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_out_319651", "319651013", "story_v_out_319651.awb") / 1000

					if var_56_8 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_0
					end

					if var_56_3.prefab_name ~= "" and arg_53_1.actors_[var_56_3.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_3.prefab_name].transform, "story_v_out_319651", "319651013", "story_v_out_319651.awb")

						arg_53_1:RecordAudio("319651013", var_56_9)
						arg_53_1:RecordAudio("319651013", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_319651", "319651013", "story_v_out_319651.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_319651", "319651013", "story_v_out_319651.awb")
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
	Play319651014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 319651014
		arg_57_1.duration_ = 5.73

		local var_57_0 = {
			zh = 5.466,
			ja = 5.733
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
				arg_57_0:Play319651015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_60_1 = arg_57_1.actors_["10058ui_story"]
			local var_60_2 = 0

			if var_60_2 < arg_57_1.time_ and arg_57_1.time_ <= var_60_2 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect10058ui_story == nil then
				arg_57_1.var_.characterEffect10058ui_story = var_60_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_3 = 0.200000002980232

			if var_60_2 <= arg_57_1.time_ and arg_57_1.time_ < var_60_2 + var_60_3 and not isNil(var_60_1) then
				local var_60_4 = (arg_57_1.time_ - var_60_2) / var_60_3

				if arg_57_1.var_.characterEffect10058ui_story and not isNil(var_60_1) then
					local var_60_5 = Mathf.Lerp(0, 0.5, var_60_4)

					arg_57_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_57_1.var_.characterEffect10058ui_story.fillRatio = var_60_5
				end
			end

			if arg_57_1.time_ >= var_60_2 + var_60_3 and arg_57_1.time_ < var_60_2 + var_60_3 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect10058ui_story then
				local var_60_6 = 0.5

				arg_57_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_57_1.var_.characterEffect10058ui_story.fillRatio = var_60_6
			end

			local var_60_7 = arg_57_1.actors_["1084ui_story"]
			local var_60_8 = 0

			if var_60_8 < arg_57_1.time_ and arg_57_1.time_ <= var_60_8 + arg_60_0 and not isNil(var_60_7) and arg_57_1.var_.characterEffect1084ui_story == nil then
				arg_57_1.var_.characterEffect1084ui_story = var_60_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_9 = 0.200000002980232

			if var_60_8 <= arg_57_1.time_ and arg_57_1.time_ < var_60_8 + var_60_9 and not isNil(var_60_7) then
				local var_60_10 = (arg_57_1.time_ - var_60_8) / var_60_9

				if arg_57_1.var_.characterEffect1084ui_story and not isNil(var_60_7) then
					arg_57_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= var_60_8 + var_60_9 and arg_57_1.time_ < var_60_8 + var_60_9 + arg_60_0 and not isNil(var_60_7) and arg_57_1.var_.characterEffect1084ui_story then
				arg_57_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_60_11 = 0
			local var_60_12 = 0.55

			if var_60_11 < arg_57_1.time_ and arg_57_1.time_ <= var_60_11 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_13 = arg_57_1:FormatText(StoryNameCfg[6].name)

				arg_57_1.leftNameTxt_.text = var_60_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_14 = arg_57_1:GetWordFromCfg(319651014)
				local var_60_15 = arg_57_1:FormatText(var_60_14.content)

				arg_57_1.text_.text = var_60_15

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_16 = 22
				local var_60_17 = utf8.len(var_60_15)
				local var_60_18 = var_60_16 <= 0 and var_60_12 or var_60_12 * (var_60_17 / var_60_16)

				if var_60_18 > 0 and var_60_12 < var_60_18 then
					arg_57_1.talkMaxDuration = var_60_18

					if var_60_18 + var_60_11 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_18 + var_60_11
					end
				end

				arg_57_1.text_.text = var_60_15
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651014", "story_v_out_319651.awb") ~= 0 then
					local var_60_19 = manager.audio:GetVoiceLength("story_v_out_319651", "319651014", "story_v_out_319651.awb") / 1000

					if var_60_19 + var_60_11 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_19 + var_60_11
					end

					if var_60_14.prefab_name ~= "" and arg_57_1.actors_[var_60_14.prefab_name] ~= nil then
						local var_60_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_14.prefab_name].transform, "story_v_out_319651", "319651014", "story_v_out_319651.awb")

						arg_57_1:RecordAudio("319651014", var_60_20)
						arg_57_1:RecordAudio("319651014", var_60_20)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_319651", "319651014", "story_v_out_319651.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_319651", "319651014", "story_v_out_319651.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_21 = math.max(var_60_12, arg_57_1.talkMaxDuration)

			if var_60_11 <= arg_57_1.time_ and arg_57_1.time_ < var_60_11 + var_60_21 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_11) / var_60_21

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_11 + var_60_21 and arg_57_1.time_ < var_60_11 + var_60_21 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play319651015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 319651015
		arg_61_1.duration_ = 7.37

		local var_61_0 = {
			zh = 7.366,
			ja = 4.033
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
				arg_61_0:Play319651016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["1084ui_story"].transform
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.var_.moveOldPos1084ui_story = var_64_0.localPosition
			end

			local var_64_2 = 0.001

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2
				local var_64_4 = Vector3.New(0.7, -0.97, -6)

				var_64_0.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1084ui_story, var_64_4, var_64_3)

				local var_64_5 = manager.ui.mainCamera.transform.position - var_64_0.position

				var_64_0.forward = Vector3.New(var_64_5.x, var_64_5.y, var_64_5.z)

				local var_64_6 = var_64_0.localEulerAngles

				var_64_6.z = 0
				var_64_6.x = 0
				var_64_0.localEulerAngles = var_64_6
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 then
				var_64_0.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_64_7 = manager.ui.mainCamera.transform.position - var_64_0.position

				var_64_0.forward = Vector3.New(var_64_7.x, var_64_7.y, var_64_7.z)

				local var_64_8 = var_64_0.localEulerAngles

				var_64_8.z = 0
				var_64_8.x = 0
				var_64_0.localEulerAngles = var_64_8
			end

			local var_64_9 = 0

			if var_64_9 < arg_61_1.time_ and arg_61_1.time_ <= var_64_9 + arg_64_0 then
				arg_61_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_64_10 = 0

			if var_64_10 < arg_61_1.time_ and arg_61_1.time_ <= var_64_10 + arg_64_0 then
				arg_61_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_64_11 = 0
			local var_64_12 = 0.875

			if var_64_11 < arg_61_1.time_ and arg_61_1.time_ <= var_64_11 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_13 = arg_61_1:FormatText(StoryNameCfg[6].name)

				arg_61_1.leftNameTxt_.text = var_64_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_14 = arg_61_1:GetWordFromCfg(319651015)
				local var_64_15 = arg_61_1:FormatText(var_64_14.content)

				arg_61_1.text_.text = var_64_15

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_16 = 35
				local var_64_17 = utf8.len(var_64_15)
				local var_64_18 = var_64_16 <= 0 and var_64_12 or var_64_12 * (var_64_17 / var_64_16)

				if var_64_18 > 0 and var_64_12 < var_64_18 then
					arg_61_1.talkMaxDuration = var_64_18

					if var_64_18 + var_64_11 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_18 + var_64_11
					end
				end

				arg_61_1.text_.text = var_64_15
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651015", "story_v_out_319651.awb") ~= 0 then
					local var_64_19 = manager.audio:GetVoiceLength("story_v_out_319651", "319651015", "story_v_out_319651.awb") / 1000

					if var_64_19 + var_64_11 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_19 + var_64_11
					end

					if var_64_14.prefab_name ~= "" and arg_61_1.actors_[var_64_14.prefab_name] ~= nil then
						local var_64_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_14.prefab_name].transform, "story_v_out_319651", "319651015", "story_v_out_319651.awb")

						arg_61_1:RecordAudio("319651015", var_64_20)
						arg_61_1:RecordAudio("319651015", var_64_20)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_319651", "319651015", "story_v_out_319651.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_319651", "319651015", "story_v_out_319651.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_21 = math.max(var_64_12, arg_61_1.talkMaxDuration)

			if var_64_11 <= arg_61_1.time_ and arg_61_1.time_ < var_64_11 + var_64_21 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_11) / var_64_21

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_11 + var_64_21 and arg_61_1.time_ < var_64_11 + var_64_21 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play319651016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 319651016
		arg_65_1.duration_ = 2.23

		local var_65_0 = {
			zh = 1.999999999999,
			ja = 2.233
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
				arg_65_0:Play319651017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["10058ui_story"].transform
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.var_.moveOldPos10058ui_story = var_68_0.localPosition
			end

			local var_68_2 = 0.001

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2
				local var_68_4 = Vector3.New(-0.7, -0.98, -6.1)

				var_68_0.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10058ui_story, var_68_4, var_68_3)

				local var_68_5 = manager.ui.mainCamera.transform.position - var_68_0.position

				var_68_0.forward = Vector3.New(var_68_5.x, var_68_5.y, var_68_5.z)

				local var_68_6 = var_68_0.localEulerAngles

				var_68_6.z = 0
				var_68_6.x = 0
				var_68_0.localEulerAngles = var_68_6
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 then
				var_68_0.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_68_7 = manager.ui.mainCamera.transform.position - var_68_0.position

				var_68_0.forward = Vector3.New(var_68_7.x, var_68_7.y, var_68_7.z)

				local var_68_8 = var_68_0.localEulerAngles

				var_68_8.z = 0
				var_68_8.x = 0
				var_68_0.localEulerAngles = var_68_8
			end

			local var_68_9 = arg_65_1.actors_["10058ui_story"]
			local var_68_10 = 0

			if var_68_10 < arg_65_1.time_ and arg_65_1.time_ <= var_68_10 + arg_68_0 and not isNil(var_68_9) and arg_65_1.var_.characterEffect10058ui_story == nil then
				arg_65_1.var_.characterEffect10058ui_story = var_68_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_11 = 0.200000002980232

			if var_68_10 <= arg_65_1.time_ and arg_65_1.time_ < var_68_10 + var_68_11 and not isNil(var_68_9) then
				local var_68_12 = (arg_65_1.time_ - var_68_10) / var_68_11

				if arg_65_1.var_.characterEffect10058ui_story and not isNil(var_68_9) then
					arg_65_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= var_68_10 + var_68_11 and arg_65_1.time_ < var_68_10 + var_68_11 + arg_68_0 and not isNil(var_68_9) and arg_65_1.var_.characterEffect10058ui_story then
				arg_65_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_68_13 = 0

			if var_68_13 < arg_65_1.time_ and arg_65_1.time_ <= var_68_13 + arg_68_0 then
				arg_65_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_68_14 = 0

			if var_68_14 < arg_65_1.time_ and arg_65_1.time_ <= var_68_14 + arg_68_0 then
				arg_65_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_68_15 = arg_65_1.actors_["1084ui_story"]
			local var_68_16 = 0

			if var_68_16 < arg_65_1.time_ and arg_65_1.time_ <= var_68_16 + arg_68_0 and not isNil(var_68_15) and arg_65_1.var_.characterEffect1084ui_story == nil then
				arg_65_1.var_.characterEffect1084ui_story = var_68_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_17 = 0.200000002980232

			if var_68_16 <= arg_65_1.time_ and arg_65_1.time_ < var_68_16 + var_68_17 and not isNil(var_68_15) then
				local var_68_18 = (arg_65_1.time_ - var_68_16) / var_68_17

				if arg_65_1.var_.characterEffect1084ui_story and not isNil(var_68_15) then
					local var_68_19 = Mathf.Lerp(0, 0.5, var_68_18)

					arg_65_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1084ui_story.fillRatio = var_68_19
				end
			end

			if arg_65_1.time_ >= var_68_16 + var_68_17 and arg_65_1.time_ < var_68_16 + var_68_17 + arg_68_0 and not isNil(var_68_15) and arg_65_1.var_.characterEffect1084ui_story then
				local var_68_20 = 0.5

				arg_65_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1084ui_story.fillRatio = var_68_20
			end

			local var_68_21 = 0
			local var_68_22 = 0.125

			if var_68_21 < arg_65_1.time_ and arg_65_1.time_ <= var_68_21 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_23 = arg_65_1:FormatText(StoryNameCfg[471].name)

				arg_65_1.leftNameTxt_.text = var_68_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_24 = arg_65_1:GetWordFromCfg(319651016)
				local var_68_25 = arg_65_1:FormatText(var_68_24.content)

				arg_65_1.text_.text = var_68_25

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_26 = 5
				local var_68_27 = utf8.len(var_68_25)
				local var_68_28 = var_68_26 <= 0 and var_68_22 or var_68_22 * (var_68_27 / var_68_26)

				if var_68_28 > 0 and var_68_22 < var_68_28 then
					arg_65_1.talkMaxDuration = var_68_28

					if var_68_28 + var_68_21 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_28 + var_68_21
					end
				end

				arg_65_1.text_.text = var_68_25
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651016", "story_v_out_319651.awb") ~= 0 then
					local var_68_29 = manager.audio:GetVoiceLength("story_v_out_319651", "319651016", "story_v_out_319651.awb") / 1000

					if var_68_29 + var_68_21 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_29 + var_68_21
					end

					if var_68_24.prefab_name ~= "" and arg_65_1.actors_[var_68_24.prefab_name] ~= nil then
						local var_68_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_24.prefab_name].transform, "story_v_out_319651", "319651016", "story_v_out_319651.awb")

						arg_65_1:RecordAudio("319651016", var_68_30)
						arg_65_1:RecordAudio("319651016", var_68_30)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_319651", "319651016", "story_v_out_319651.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_319651", "319651016", "story_v_out_319651.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_31 = math.max(var_68_22, arg_65_1.talkMaxDuration)

			if var_68_21 <= arg_65_1.time_ and arg_65_1.time_ < var_68_21 + var_68_31 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_21) / var_68_31

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_21 + var_68_31 and arg_65_1.time_ < var_68_21 + var_68_31 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play319651017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 319651017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play319651018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["10058ui_story"]
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect10058ui_story == nil then
				arg_69_1.var_.characterEffect10058ui_story = var_72_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.200000002980232

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 and not isNil(var_72_0) then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2

				if arg_69_1.var_.characterEffect10058ui_story and not isNil(var_72_0) then
					local var_72_4 = Mathf.Lerp(0, 0.5, var_72_3)

					arg_69_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_69_1.var_.characterEffect10058ui_story.fillRatio = var_72_4
				end
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect10058ui_story then
				local var_72_5 = 0.5

				arg_69_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_69_1.var_.characterEffect10058ui_story.fillRatio = var_72_5
			end

			local var_72_6 = 0
			local var_72_7 = 1.025

			if var_72_6 < arg_69_1.time_ and arg_69_1.time_ <= var_72_6 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_8 = arg_69_1:GetWordFromCfg(319651017)
				local var_72_9 = arg_69_1:FormatText(var_72_8.content)

				arg_69_1.text_.text = var_72_9

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_10 = 41
				local var_72_11 = utf8.len(var_72_9)
				local var_72_12 = var_72_10 <= 0 and var_72_7 or var_72_7 * (var_72_11 / var_72_10)

				if var_72_12 > 0 and var_72_7 < var_72_12 then
					arg_69_1.talkMaxDuration = var_72_12

					if var_72_12 + var_72_6 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_12 + var_72_6
					end
				end

				arg_69_1.text_.text = var_72_9
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_13 = math.max(var_72_7, arg_69_1.talkMaxDuration)

			if var_72_6 <= arg_69_1.time_ and arg_69_1.time_ < var_72_6 + var_72_13 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_6) / var_72_13

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_6 + var_72_13 and arg_69_1.time_ < var_72_6 + var_72_13 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play319651018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 319651018
		arg_73_1.duration_ = 3.53

		local var_73_0 = {
			zh = 1.999999999999,
			ja = 3.533
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
				arg_73_0:Play319651019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0

			if var_76_0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_76_1 = arg_73_1.actors_["10058ui_story"]
			local var_76_2 = 0

			if var_76_2 < arg_73_1.time_ and arg_73_1.time_ <= var_76_2 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect10058ui_story == nil then
				arg_73_1.var_.characterEffect10058ui_story = var_76_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_3 = 0.200000002980232

			if var_76_2 <= arg_73_1.time_ and arg_73_1.time_ < var_76_2 + var_76_3 and not isNil(var_76_1) then
				local var_76_4 = (arg_73_1.time_ - var_76_2) / var_76_3

				if arg_73_1.var_.characterEffect10058ui_story and not isNil(var_76_1) then
					arg_73_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= var_76_2 + var_76_3 and arg_73_1.time_ < var_76_2 + var_76_3 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect10058ui_story then
				arg_73_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_76_5 = 0
			local var_76_6 = 0.25

			if var_76_5 < arg_73_1.time_ and arg_73_1.time_ <= var_76_5 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_7 = arg_73_1:FormatText(StoryNameCfg[471].name)

				arg_73_1.leftNameTxt_.text = var_76_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_8 = arg_73_1:GetWordFromCfg(319651018)
				local var_76_9 = arg_73_1:FormatText(var_76_8.content)

				arg_73_1.text_.text = var_76_9

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_10 = 10
				local var_76_11 = utf8.len(var_76_9)
				local var_76_12 = var_76_10 <= 0 and var_76_6 or var_76_6 * (var_76_11 / var_76_10)

				if var_76_12 > 0 and var_76_6 < var_76_12 then
					arg_73_1.talkMaxDuration = var_76_12

					if var_76_12 + var_76_5 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_12 + var_76_5
					end
				end

				arg_73_1.text_.text = var_76_9
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651018", "story_v_out_319651.awb") ~= 0 then
					local var_76_13 = manager.audio:GetVoiceLength("story_v_out_319651", "319651018", "story_v_out_319651.awb") / 1000

					if var_76_13 + var_76_5 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_13 + var_76_5
					end

					if var_76_8.prefab_name ~= "" and arg_73_1.actors_[var_76_8.prefab_name] ~= nil then
						local var_76_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_8.prefab_name].transform, "story_v_out_319651", "319651018", "story_v_out_319651.awb")

						arg_73_1:RecordAudio("319651018", var_76_14)
						arg_73_1:RecordAudio("319651018", var_76_14)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_319651", "319651018", "story_v_out_319651.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_319651", "319651018", "story_v_out_319651.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_15 = math.max(var_76_6, arg_73_1.talkMaxDuration)

			if var_76_5 <= arg_73_1.time_ and arg_73_1.time_ < var_76_5 + var_76_15 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_5) / var_76_15

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_5 + var_76_15 and arg_73_1.time_ < var_76_5 + var_76_15 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play319651019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 319651019
		arg_77_1.duration_ = 9.87

		local var_77_0 = {
			zh = 8.266,
			ja = 9.866
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
				arg_77_0:Play319651020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0

			if var_80_0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_80_2 = 0
			local var_80_3 = 0.75

			if var_80_2 < arg_77_1.time_ and arg_77_1.time_ <= var_80_2 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_4 = arg_77_1:FormatText(StoryNameCfg[471].name)

				arg_77_1.leftNameTxt_.text = var_80_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_5 = arg_77_1:GetWordFromCfg(319651019)
				local var_80_6 = arg_77_1:FormatText(var_80_5.content)

				arg_77_1.text_.text = var_80_6

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_7 = 30
				local var_80_8 = utf8.len(var_80_6)
				local var_80_9 = var_80_7 <= 0 and var_80_3 or var_80_3 * (var_80_8 / var_80_7)

				if var_80_9 > 0 and var_80_3 < var_80_9 then
					arg_77_1.talkMaxDuration = var_80_9

					if var_80_9 + var_80_2 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_9 + var_80_2
					end
				end

				arg_77_1.text_.text = var_80_6
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651019", "story_v_out_319651.awb") ~= 0 then
					local var_80_10 = manager.audio:GetVoiceLength("story_v_out_319651", "319651019", "story_v_out_319651.awb") / 1000

					if var_80_10 + var_80_2 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_10 + var_80_2
					end

					if var_80_5.prefab_name ~= "" and arg_77_1.actors_[var_80_5.prefab_name] ~= nil then
						local var_80_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_5.prefab_name].transform, "story_v_out_319651", "319651019", "story_v_out_319651.awb")

						arg_77_1:RecordAudio("319651019", var_80_11)
						arg_77_1:RecordAudio("319651019", var_80_11)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_319651", "319651019", "story_v_out_319651.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_319651", "319651019", "story_v_out_319651.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_12 = math.max(var_80_3, arg_77_1.talkMaxDuration)

			if var_80_2 <= arg_77_1.time_ and arg_77_1.time_ < var_80_2 + var_80_12 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_2) / var_80_12

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_2 + var_80_12 and arg_77_1.time_ < var_80_2 + var_80_12 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play319651020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 319651020
		arg_81_1.duration_ = 6.7

		local var_81_0 = {
			zh = 2.7,
			ja = 6.7
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
				arg_81_0:Play319651021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["1084ui_story"].transform
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.var_.moveOldPos1084ui_story = var_84_0.localPosition
			end

			local var_84_2 = 0.001

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2
				local var_84_4 = Vector3.New(0.7, -0.97, -6)

				var_84_0.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1084ui_story, var_84_4, var_84_3)

				local var_84_5 = manager.ui.mainCamera.transform.position - var_84_0.position

				var_84_0.forward = Vector3.New(var_84_5.x, var_84_5.y, var_84_5.z)

				local var_84_6 = var_84_0.localEulerAngles

				var_84_6.z = 0
				var_84_6.x = 0
				var_84_0.localEulerAngles = var_84_6
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 then
				var_84_0.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_84_7 = manager.ui.mainCamera.transform.position - var_84_0.position

				var_84_0.forward = Vector3.New(var_84_7.x, var_84_7.y, var_84_7.z)

				local var_84_8 = var_84_0.localEulerAngles

				var_84_8.z = 0
				var_84_8.x = 0
				var_84_0.localEulerAngles = var_84_8
			end

			local var_84_9 = arg_81_1.actors_["1084ui_story"]
			local var_84_10 = 0

			if var_84_10 < arg_81_1.time_ and arg_81_1.time_ <= var_84_10 + arg_84_0 and not isNil(var_84_9) and arg_81_1.var_.characterEffect1084ui_story == nil then
				arg_81_1.var_.characterEffect1084ui_story = var_84_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_11 = 0.200000002980232

			if var_84_10 <= arg_81_1.time_ and arg_81_1.time_ < var_84_10 + var_84_11 and not isNil(var_84_9) then
				local var_84_12 = (arg_81_1.time_ - var_84_10) / var_84_11

				if arg_81_1.var_.characterEffect1084ui_story and not isNil(var_84_9) then
					arg_81_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= var_84_10 + var_84_11 and arg_81_1.time_ < var_84_10 + var_84_11 + arg_84_0 and not isNil(var_84_9) and arg_81_1.var_.characterEffect1084ui_story then
				arg_81_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_84_13 = 0

			if var_84_13 < arg_81_1.time_ and arg_81_1.time_ <= var_84_13 + arg_84_0 then
				arg_81_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4137")
			end

			local var_84_14 = 0

			if var_84_14 < arg_81_1.time_ and arg_81_1.time_ <= var_84_14 + arg_84_0 then
				arg_81_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_84_15 = arg_81_1.actors_["10058ui_story"]
			local var_84_16 = 0

			if var_84_16 < arg_81_1.time_ and arg_81_1.time_ <= var_84_16 + arg_84_0 and not isNil(var_84_15) and arg_81_1.var_.characterEffect10058ui_story == nil then
				arg_81_1.var_.characterEffect10058ui_story = var_84_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_17 = 0.200000002980232

			if var_84_16 <= arg_81_1.time_ and arg_81_1.time_ < var_84_16 + var_84_17 and not isNil(var_84_15) then
				local var_84_18 = (arg_81_1.time_ - var_84_16) / var_84_17

				if arg_81_1.var_.characterEffect10058ui_story and not isNil(var_84_15) then
					local var_84_19 = Mathf.Lerp(0, 0.5, var_84_18)

					arg_81_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_81_1.var_.characterEffect10058ui_story.fillRatio = var_84_19
				end
			end

			if arg_81_1.time_ >= var_84_16 + var_84_17 and arg_81_1.time_ < var_84_16 + var_84_17 + arg_84_0 and not isNil(var_84_15) and arg_81_1.var_.characterEffect10058ui_story then
				local var_84_20 = 0.5

				arg_81_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_81_1.var_.characterEffect10058ui_story.fillRatio = var_84_20
			end

			local var_84_21 = 0
			local var_84_22 = 0.35

			if var_84_21 < arg_81_1.time_ and arg_81_1.time_ <= var_84_21 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_23 = arg_81_1:FormatText(StoryNameCfg[6].name)

				arg_81_1.leftNameTxt_.text = var_84_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_24 = arg_81_1:GetWordFromCfg(319651020)
				local var_84_25 = arg_81_1:FormatText(var_84_24.content)

				arg_81_1.text_.text = var_84_25

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_26 = 14
				local var_84_27 = utf8.len(var_84_25)
				local var_84_28 = var_84_26 <= 0 and var_84_22 or var_84_22 * (var_84_27 / var_84_26)

				if var_84_28 > 0 and var_84_22 < var_84_28 then
					arg_81_1.talkMaxDuration = var_84_28

					if var_84_28 + var_84_21 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_28 + var_84_21
					end
				end

				arg_81_1.text_.text = var_84_25
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651020", "story_v_out_319651.awb") ~= 0 then
					local var_84_29 = manager.audio:GetVoiceLength("story_v_out_319651", "319651020", "story_v_out_319651.awb") / 1000

					if var_84_29 + var_84_21 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_29 + var_84_21
					end

					if var_84_24.prefab_name ~= "" and arg_81_1.actors_[var_84_24.prefab_name] ~= nil then
						local var_84_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_24.prefab_name].transform, "story_v_out_319651", "319651020", "story_v_out_319651.awb")

						arg_81_1:RecordAudio("319651020", var_84_30)
						arg_81_1:RecordAudio("319651020", var_84_30)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_319651", "319651020", "story_v_out_319651.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_319651", "319651020", "story_v_out_319651.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_31 = math.max(var_84_22, arg_81_1.talkMaxDuration)

			if var_84_21 <= arg_81_1.time_ and arg_81_1.time_ < var_84_21 + var_84_31 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_21) / var_84_31

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_21 + var_84_31 and arg_81_1.time_ < var_84_21 + var_84_31 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play319651021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 319651021
		arg_85_1.duration_ = 4.67

		local var_85_0 = {
			zh = 2.566,
			ja = 4.666
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
				arg_85_0:Play319651022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["10058ui_story"].transform
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.var_.moveOldPos10058ui_story = var_88_0.localPosition
			end

			local var_88_2 = 0.001

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2
				local var_88_4 = Vector3.New(-0.7, -0.98, -6.1)

				var_88_0.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10058ui_story, var_88_4, var_88_3)

				local var_88_5 = manager.ui.mainCamera.transform.position - var_88_0.position

				var_88_0.forward = Vector3.New(var_88_5.x, var_88_5.y, var_88_5.z)

				local var_88_6 = var_88_0.localEulerAngles

				var_88_6.z = 0
				var_88_6.x = 0
				var_88_0.localEulerAngles = var_88_6
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 then
				var_88_0.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_88_7 = manager.ui.mainCamera.transform.position - var_88_0.position

				var_88_0.forward = Vector3.New(var_88_7.x, var_88_7.y, var_88_7.z)

				local var_88_8 = var_88_0.localEulerAngles

				var_88_8.z = 0
				var_88_8.x = 0
				var_88_0.localEulerAngles = var_88_8
			end

			local var_88_9 = arg_85_1.actors_["10058ui_story"]
			local var_88_10 = 0

			if var_88_10 < arg_85_1.time_ and arg_85_1.time_ <= var_88_10 + arg_88_0 and not isNil(var_88_9) and arg_85_1.var_.characterEffect10058ui_story == nil then
				arg_85_1.var_.characterEffect10058ui_story = var_88_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_11 = 0.200000002980232

			if var_88_10 <= arg_85_1.time_ and arg_85_1.time_ < var_88_10 + var_88_11 and not isNil(var_88_9) then
				local var_88_12 = (arg_85_1.time_ - var_88_10) / var_88_11

				if arg_85_1.var_.characterEffect10058ui_story and not isNil(var_88_9) then
					arg_85_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= var_88_10 + var_88_11 and arg_85_1.time_ < var_88_10 + var_88_11 + arg_88_0 and not isNil(var_88_9) and arg_85_1.var_.characterEffect10058ui_story then
				arg_85_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_88_13 = arg_85_1.actors_["1084ui_story"]
			local var_88_14 = 0

			if var_88_14 < arg_85_1.time_ and arg_85_1.time_ <= var_88_14 + arg_88_0 and not isNil(var_88_13) and arg_85_1.var_.characterEffect1084ui_story == nil then
				arg_85_1.var_.characterEffect1084ui_story = var_88_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_15 = 0.200000002980232

			if var_88_14 <= arg_85_1.time_ and arg_85_1.time_ < var_88_14 + var_88_15 and not isNil(var_88_13) then
				local var_88_16 = (arg_85_1.time_ - var_88_14) / var_88_15

				if arg_85_1.var_.characterEffect1084ui_story and not isNil(var_88_13) then
					local var_88_17 = Mathf.Lerp(0, 0.5, var_88_16)

					arg_85_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1084ui_story.fillRatio = var_88_17
				end
			end

			if arg_85_1.time_ >= var_88_14 + var_88_15 and arg_85_1.time_ < var_88_14 + var_88_15 + arg_88_0 and not isNil(var_88_13) and arg_85_1.var_.characterEffect1084ui_story then
				local var_88_18 = 0.5

				arg_85_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1084ui_story.fillRatio = var_88_18
			end

			local var_88_19 = 0
			local var_88_20 = 0.325

			if var_88_19 < arg_85_1.time_ and arg_85_1.time_ <= var_88_19 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_21 = arg_85_1:FormatText(StoryNameCfg[471].name)

				arg_85_1.leftNameTxt_.text = var_88_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_22 = arg_85_1:GetWordFromCfg(319651021)
				local var_88_23 = arg_85_1:FormatText(var_88_22.content)

				arg_85_1.text_.text = var_88_23

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_24 = 13
				local var_88_25 = utf8.len(var_88_23)
				local var_88_26 = var_88_24 <= 0 and var_88_20 or var_88_20 * (var_88_25 / var_88_24)

				if var_88_26 > 0 and var_88_20 < var_88_26 then
					arg_85_1.talkMaxDuration = var_88_26

					if var_88_26 + var_88_19 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_26 + var_88_19
					end
				end

				arg_85_1.text_.text = var_88_23
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651021", "story_v_out_319651.awb") ~= 0 then
					local var_88_27 = manager.audio:GetVoiceLength("story_v_out_319651", "319651021", "story_v_out_319651.awb") / 1000

					if var_88_27 + var_88_19 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_27 + var_88_19
					end

					if var_88_22.prefab_name ~= "" and arg_85_1.actors_[var_88_22.prefab_name] ~= nil then
						local var_88_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_22.prefab_name].transform, "story_v_out_319651", "319651021", "story_v_out_319651.awb")

						arg_85_1:RecordAudio("319651021", var_88_28)
						arg_85_1:RecordAudio("319651021", var_88_28)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_319651", "319651021", "story_v_out_319651.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_319651", "319651021", "story_v_out_319651.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_29 = math.max(var_88_20, arg_85_1.talkMaxDuration)

			if var_88_19 <= arg_85_1.time_ and arg_85_1.time_ < var_88_19 + var_88_29 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_19) / var_88_29

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_19 + var_88_29 and arg_85_1.time_ < var_88_19 + var_88_29 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play319651022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 319651022
		arg_89_1.duration_ = 6.77

		local var_89_0 = {
			zh = 5.733,
			ja = 6.766
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
				arg_89_0:Play319651023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0
			local var_92_1 = 0.6

			if var_92_0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_2 = arg_89_1:FormatText(StoryNameCfg[471].name)

				arg_89_1.leftNameTxt_.text = var_92_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_3 = arg_89_1:GetWordFromCfg(319651022)
				local var_92_4 = arg_89_1:FormatText(var_92_3.content)

				arg_89_1.text_.text = var_92_4

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651022", "story_v_out_319651.awb") ~= 0 then
					local var_92_8 = manager.audio:GetVoiceLength("story_v_out_319651", "319651022", "story_v_out_319651.awb") / 1000

					if var_92_8 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_8 + var_92_0
					end

					if var_92_3.prefab_name ~= "" and arg_89_1.actors_[var_92_3.prefab_name] ~= nil then
						local var_92_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_3.prefab_name].transform, "story_v_out_319651", "319651022", "story_v_out_319651.awb")

						arg_89_1:RecordAudio("319651022", var_92_9)
						arg_89_1:RecordAudio("319651022", var_92_9)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_319651", "319651022", "story_v_out_319651.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_319651", "319651022", "story_v_out_319651.awb")
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
	Play319651023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 319651023
		arg_93_1.duration_ = 1.5

		local var_93_0 = {
			zh = 1,
			ja = 1.5
		}
		local var_93_1 = manager.audio:GetLocalizationFlag()

		if var_93_0[var_93_1] ~= nil then
			arg_93_1.duration_ = var_93_0[var_93_1]
		end

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play319651024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["10058ui_story"]
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.characterEffect10058ui_story == nil then
				arg_93_1.var_.characterEffect10058ui_story = var_96_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_2 = 0.200000002980232

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 and not isNil(var_96_0) then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2

				if arg_93_1.var_.characterEffect10058ui_story and not isNil(var_96_0) then
					local var_96_4 = Mathf.Lerp(0, 0.5, var_96_3)

					arg_93_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_93_1.var_.characterEffect10058ui_story.fillRatio = var_96_4
				end
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.characterEffect10058ui_story then
				local var_96_5 = 0.5

				arg_93_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_93_1.var_.characterEffect10058ui_story.fillRatio = var_96_5
			end

			local var_96_6 = arg_93_1.actors_["1084ui_story"]
			local var_96_7 = 0

			if var_96_7 < arg_93_1.time_ and arg_93_1.time_ <= var_96_7 + arg_96_0 and not isNil(var_96_6) and arg_93_1.var_.characterEffect1084ui_story == nil then
				arg_93_1.var_.characterEffect1084ui_story = var_96_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_8 = 0.200000002980232

			if var_96_7 <= arg_93_1.time_ and arg_93_1.time_ < var_96_7 + var_96_8 and not isNil(var_96_6) then
				local var_96_9 = (arg_93_1.time_ - var_96_7) / var_96_8

				if arg_93_1.var_.characterEffect1084ui_story and not isNil(var_96_6) then
					arg_93_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= var_96_7 + var_96_8 and arg_93_1.time_ < var_96_7 + var_96_8 + arg_96_0 and not isNil(var_96_6) and arg_93_1.var_.characterEffect1084ui_story then
				arg_93_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_96_10 = 0
			local var_96_11 = 0.05

			if var_96_10 < arg_93_1.time_ and arg_93_1.time_ <= var_96_10 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_12 = arg_93_1:FormatText(StoryNameCfg[6].name)

				arg_93_1.leftNameTxt_.text = var_96_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_13 = arg_93_1:GetWordFromCfg(319651023)
				local var_96_14 = arg_93_1:FormatText(var_96_13.content)

				arg_93_1.text_.text = var_96_14

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_15 = 2
				local var_96_16 = utf8.len(var_96_14)
				local var_96_17 = var_96_15 <= 0 and var_96_11 or var_96_11 * (var_96_16 / var_96_15)

				if var_96_17 > 0 and var_96_11 < var_96_17 then
					arg_93_1.talkMaxDuration = var_96_17

					if var_96_17 + var_96_10 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_17 + var_96_10
					end
				end

				arg_93_1.text_.text = var_96_14
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651023", "story_v_out_319651.awb") ~= 0 then
					local var_96_18 = manager.audio:GetVoiceLength("story_v_out_319651", "319651023", "story_v_out_319651.awb") / 1000

					if var_96_18 + var_96_10 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_18 + var_96_10
					end

					if var_96_13.prefab_name ~= "" and arg_93_1.actors_[var_96_13.prefab_name] ~= nil then
						local var_96_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_13.prefab_name].transform, "story_v_out_319651", "319651023", "story_v_out_319651.awb")

						arg_93_1:RecordAudio("319651023", var_96_19)
						arg_93_1:RecordAudio("319651023", var_96_19)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_319651", "319651023", "story_v_out_319651.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_319651", "319651023", "story_v_out_319651.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_20 = math.max(var_96_11, arg_93_1.talkMaxDuration)

			if var_96_10 <= arg_93_1.time_ and arg_93_1.time_ < var_96_10 + var_96_20 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_10) / var_96_20

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_10 + var_96_20 and arg_93_1.time_ < var_96_10 + var_96_20 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play319651024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 319651024
		arg_97_1.duration_ = 16.9

		local var_97_0 = {
			zh = 11.066,
			ja = 16.9
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
				arg_97_0:Play319651025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["10058ui_story"].transform
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.var_.moveOldPos10058ui_story = var_100_0.localPosition
			end

			local var_100_2 = 0.001

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2
				local var_100_4 = Vector3.New(-0.7, -0.98, -6.1)

				var_100_0.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10058ui_story, var_100_4, var_100_3)

				local var_100_5 = manager.ui.mainCamera.transform.position - var_100_0.position

				var_100_0.forward = Vector3.New(var_100_5.x, var_100_5.y, var_100_5.z)

				local var_100_6 = var_100_0.localEulerAngles

				var_100_6.z = 0
				var_100_6.x = 0
				var_100_0.localEulerAngles = var_100_6
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 then
				var_100_0.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_100_7 = manager.ui.mainCamera.transform.position - var_100_0.position

				var_100_0.forward = Vector3.New(var_100_7.x, var_100_7.y, var_100_7.z)

				local var_100_8 = var_100_0.localEulerAngles

				var_100_8.z = 0
				var_100_8.x = 0
				var_100_0.localEulerAngles = var_100_8
			end

			local var_100_9 = arg_97_1.actors_["10058ui_story"]
			local var_100_10 = 0

			if var_100_10 < arg_97_1.time_ and arg_97_1.time_ <= var_100_10 + arg_100_0 and not isNil(var_100_9) and arg_97_1.var_.characterEffect10058ui_story == nil then
				arg_97_1.var_.characterEffect10058ui_story = var_100_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_11 = 0.200000002980232

			if var_100_10 <= arg_97_1.time_ and arg_97_1.time_ < var_100_10 + var_100_11 and not isNil(var_100_9) then
				local var_100_12 = (arg_97_1.time_ - var_100_10) / var_100_11

				if arg_97_1.var_.characterEffect10058ui_story and not isNil(var_100_9) then
					arg_97_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= var_100_10 + var_100_11 and arg_97_1.time_ < var_100_10 + var_100_11 + arg_100_0 and not isNil(var_100_9) and arg_97_1.var_.characterEffect10058ui_story then
				arg_97_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_100_13 = 0

			if var_100_13 < arg_97_1.time_ and arg_97_1.time_ <= var_100_13 + arg_100_0 then
				arg_97_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_2")
			end

			local var_100_14 = 0

			if var_100_14 < arg_97_1.time_ and arg_97_1.time_ <= var_100_14 + arg_100_0 then
				arg_97_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_100_15 = arg_97_1.actors_["1084ui_story"]
			local var_100_16 = 0

			if var_100_16 < arg_97_1.time_ and arg_97_1.time_ <= var_100_16 + arg_100_0 and not isNil(var_100_15) and arg_97_1.var_.characterEffect1084ui_story == nil then
				arg_97_1.var_.characterEffect1084ui_story = var_100_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_17 = 0.200000002980232

			if var_100_16 <= arg_97_1.time_ and arg_97_1.time_ < var_100_16 + var_100_17 and not isNil(var_100_15) then
				local var_100_18 = (arg_97_1.time_ - var_100_16) / var_100_17

				if arg_97_1.var_.characterEffect1084ui_story and not isNil(var_100_15) then
					local var_100_19 = Mathf.Lerp(0, 0.5, var_100_18)

					arg_97_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_97_1.var_.characterEffect1084ui_story.fillRatio = var_100_19
				end
			end

			if arg_97_1.time_ >= var_100_16 + var_100_17 and arg_97_1.time_ < var_100_16 + var_100_17 + arg_100_0 and not isNil(var_100_15) and arg_97_1.var_.characterEffect1084ui_story then
				local var_100_20 = 0.5

				arg_97_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_97_1.var_.characterEffect1084ui_story.fillRatio = var_100_20
			end

			local var_100_21 = 0
			local var_100_22 = 1.175

			if var_100_21 < arg_97_1.time_ and arg_97_1.time_ <= var_100_21 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_23 = arg_97_1:FormatText(StoryNameCfg[471].name)

				arg_97_1.leftNameTxt_.text = var_100_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_24 = arg_97_1:GetWordFromCfg(319651024)
				local var_100_25 = arg_97_1:FormatText(var_100_24.content)

				arg_97_1.text_.text = var_100_25

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_26 = 47
				local var_100_27 = utf8.len(var_100_25)
				local var_100_28 = var_100_26 <= 0 and var_100_22 or var_100_22 * (var_100_27 / var_100_26)

				if var_100_28 > 0 and var_100_22 < var_100_28 then
					arg_97_1.talkMaxDuration = var_100_28

					if var_100_28 + var_100_21 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_28 + var_100_21
					end
				end

				arg_97_1.text_.text = var_100_25
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651024", "story_v_out_319651.awb") ~= 0 then
					local var_100_29 = manager.audio:GetVoiceLength("story_v_out_319651", "319651024", "story_v_out_319651.awb") / 1000

					if var_100_29 + var_100_21 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_29 + var_100_21
					end

					if var_100_24.prefab_name ~= "" and arg_97_1.actors_[var_100_24.prefab_name] ~= nil then
						local var_100_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_24.prefab_name].transform, "story_v_out_319651", "319651024", "story_v_out_319651.awb")

						arg_97_1:RecordAudio("319651024", var_100_30)
						arg_97_1:RecordAudio("319651024", var_100_30)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_319651", "319651024", "story_v_out_319651.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_319651", "319651024", "story_v_out_319651.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_31 = math.max(var_100_22, arg_97_1.talkMaxDuration)

			if var_100_21 <= arg_97_1.time_ and arg_97_1.time_ < var_100_21 + var_100_31 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_21) / var_100_31

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_21 + var_100_31 and arg_97_1.time_ < var_100_21 + var_100_31 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play319651025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 319651025
		arg_101_1.duration_ = 10.63

		local var_101_0 = {
			zh = 10.633,
			ja = 9.566
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
				arg_101_0:Play319651026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0
			local var_104_1 = 1.15

			if var_104_0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_2 = arg_101_1:FormatText(StoryNameCfg[471].name)

				arg_101_1.leftNameTxt_.text = var_104_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_3 = arg_101_1:GetWordFromCfg(319651025)
				local var_104_4 = arg_101_1:FormatText(var_104_3.content)

				arg_101_1.text_.text = var_104_4

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_5 = 46
				local var_104_6 = utf8.len(var_104_4)
				local var_104_7 = var_104_5 <= 0 and var_104_1 or var_104_1 * (var_104_6 / var_104_5)

				if var_104_7 > 0 and var_104_1 < var_104_7 then
					arg_101_1.talkMaxDuration = var_104_7

					if var_104_7 + var_104_0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_7 + var_104_0
					end
				end

				arg_101_1.text_.text = var_104_4
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651025", "story_v_out_319651.awb") ~= 0 then
					local var_104_8 = manager.audio:GetVoiceLength("story_v_out_319651", "319651025", "story_v_out_319651.awb") / 1000

					if var_104_8 + var_104_0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_8 + var_104_0
					end

					if var_104_3.prefab_name ~= "" and arg_101_1.actors_[var_104_3.prefab_name] ~= nil then
						local var_104_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_3.prefab_name].transform, "story_v_out_319651", "319651025", "story_v_out_319651.awb")

						arg_101_1:RecordAudio("319651025", var_104_9)
						arg_101_1:RecordAudio("319651025", var_104_9)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_319651", "319651025", "story_v_out_319651.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_319651", "319651025", "story_v_out_319651.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_10 = math.max(var_104_1, arg_101_1.talkMaxDuration)

			if var_104_0 <= arg_101_1.time_ and arg_101_1.time_ < var_104_0 + var_104_10 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_0) / var_104_10

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_0 + var_104_10 and arg_101_1.time_ < var_104_0 + var_104_10 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play319651026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 319651026
		arg_105_1.duration_ = 10.57

		local var_105_0 = {
			zh = 7.7,
			ja = 10.566
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
				arg_105_0:Play319651027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0
			local var_108_1 = 0.85

			if var_108_0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_2 = arg_105_1:FormatText(StoryNameCfg[471].name)

				arg_105_1.leftNameTxt_.text = var_108_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_3 = arg_105_1:GetWordFromCfg(319651026)
				local var_108_4 = arg_105_1:FormatText(var_108_3.content)

				arg_105_1.text_.text = var_108_4

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_5 = 34
				local var_108_6 = utf8.len(var_108_4)
				local var_108_7 = var_108_5 <= 0 and var_108_1 or var_108_1 * (var_108_6 / var_108_5)

				if var_108_7 > 0 and var_108_1 < var_108_7 then
					arg_105_1.talkMaxDuration = var_108_7

					if var_108_7 + var_108_0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_7 + var_108_0
					end
				end

				arg_105_1.text_.text = var_108_4
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651026", "story_v_out_319651.awb") ~= 0 then
					local var_108_8 = manager.audio:GetVoiceLength("story_v_out_319651", "319651026", "story_v_out_319651.awb") / 1000

					if var_108_8 + var_108_0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_8 + var_108_0
					end

					if var_108_3.prefab_name ~= "" and arg_105_1.actors_[var_108_3.prefab_name] ~= nil then
						local var_108_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_3.prefab_name].transform, "story_v_out_319651", "319651026", "story_v_out_319651.awb")

						arg_105_1:RecordAudio("319651026", var_108_9)
						arg_105_1:RecordAudio("319651026", var_108_9)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_319651", "319651026", "story_v_out_319651.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_319651", "319651026", "story_v_out_319651.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_10 = math.max(var_108_1, arg_105_1.talkMaxDuration)

			if var_108_0 <= arg_105_1.time_ and arg_105_1.time_ < var_108_0 + var_108_10 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_0) / var_108_10

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_0 + var_108_10 and arg_105_1.time_ < var_108_0 + var_108_10 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play319651027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 319651027
		arg_109_1.duration_ = 3.27

		local var_109_0 = {
			zh = 2.3,
			ja = 3.266
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
				arg_109_0:Play319651028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["10058ui_story"]
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect10058ui_story == nil then
				arg_109_1.var_.characterEffect10058ui_story = var_112_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.200000002980232

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 and not isNil(var_112_0) then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2

				if arg_109_1.var_.characterEffect10058ui_story and not isNil(var_112_0) then
					local var_112_4 = Mathf.Lerp(0, 0.5, var_112_3)

					arg_109_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_109_1.var_.characterEffect10058ui_story.fillRatio = var_112_4
				end
			end

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect10058ui_story then
				local var_112_5 = 0.5

				arg_109_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_109_1.var_.characterEffect10058ui_story.fillRatio = var_112_5
			end

			local var_112_6 = arg_109_1.actors_["1084ui_story"]
			local var_112_7 = 0

			if var_112_7 < arg_109_1.time_ and arg_109_1.time_ <= var_112_7 + arg_112_0 and not isNil(var_112_6) and arg_109_1.var_.characterEffect1084ui_story == nil then
				arg_109_1.var_.characterEffect1084ui_story = var_112_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_8 = 0.200000002980232

			if var_112_7 <= arg_109_1.time_ and arg_109_1.time_ < var_112_7 + var_112_8 and not isNil(var_112_6) then
				local var_112_9 = (arg_109_1.time_ - var_112_7) / var_112_8

				if arg_109_1.var_.characterEffect1084ui_story and not isNil(var_112_6) then
					arg_109_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= var_112_7 + var_112_8 and arg_109_1.time_ < var_112_7 + var_112_8 + arg_112_0 and not isNil(var_112_6) and arg_109_1.var_.characterEffect1084ui_story then
				arg_109_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_112_10 = 0

			if var_112_10 < arg_109_1.time_ and arg_109_1.time_ <= var_112_10 + arg_112_0 then
				arg_109_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			local var_112_11 = 0

			if var_112_11 < arg_109_1.time_ and arg_109_1.time_ <= var_112_11 + arg_112_0 then
				arg_109_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_112_12 = 0
			local var_112_13 = 0.225

			if var_112_12 < arg_109_1.time_ and arg_109_1.time_ <= var_112_12 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_14 = arg_109_1:FormatText(StoryNameCfg[6].name)

				arg_109_1.leftNameTxt_.text = var_112_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_15 = arg_109_1:GetWordFromCfg(319651027)
				local var_112_16 = arg_109_1:FormatText(var_112_15.content)

				arg_109_1.text_.text = var_112_16

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_17 = 9
				local var_112_18 = utf8.len(var_112_16)
				local var_112_19 = var_112_17 <= 0 and var_112_13 or var_112_13 * (var_112_18 / var_112_17)

				if var_112_19 > 0 and var_112_13 < var_112_19 then
					arg_109_1.talkMaxDuration = var_112_19

					if var_112_19 + var_112_12 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_19 + var_112_12
					end
				end

				arg_109_1.text_.text = var_112_16
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651027", "story_v_out_319651.awb") ~= 0 then
					local var_112_20 = manager.audio:GetVoiceLength("story_v_out_319651", "319651027", "story_v_out_319651.awb") / 1000

					if var_112_20 + var_112_12 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_20 + var_112_12
					end

					if var_112_15.prefab_name ~= "" and arg_109_1.actors_[var_112_15.prefab_name] ~= nil then
						local var_112_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_15.prefab_name].transform, "story_v_out_319651", "319651027", "story_v_out_319651.awb")

						arg_109_1:RecordAudio("319651027", var_112_21)
						arg_109_1:RecordAudio("319651027", var_112_21)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_319651", "319651027", "story_v_out_319651.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_319651", "319651027", "story_v_out_319651.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_22 = math.max(var_112_13, arg_109_1.talkMaxDuration)

			if var_112_12 <= arg_109_1.time_ and arg_109_1.time_ < var_112_12 + var_112_22 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_12) / var_112_22

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_12 + var_112_22 and arg_109_1.time_ < var_112_12 + var_112_22 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play319651028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 319651028
		arg_113_1.duration_ = 9.37

		local var_113_0 = {
			zh = 7.4,
			ja = 9.366
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
				arg_113_0:Play319651029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["10058ui_story"]
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.characterEffect10058ui_story == nil then
				arg_113_1.var_.characterEffect10058ui_story = var_116_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_2 = 0.200000002980232

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 and not isNil(var_116_0) then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2

				if arg_113_1.var_.characterEffect10058ui_story and not isNil(var_116_0) then
					arg_113_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.characterEffect10058ui_story then
				arg_113_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_116_4 = arg_113_1.actors_["1084ui_story"]
			local var_116_5 = 0

			if var_116_5 < arg_113_1.time_ and arg_113_1.time_ <= var_116_5 + arg_116_0 and not isNil(var_116_4) and arg_113_1.var_.characterEffect1084ui_story == nil then
				arg_113_1.var_.characterEffect1084ui_story = var_116_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_6 = 0.200000002980232

			if var_116_5 <= arg_113_1.time_ and arg_113_1.time_ < var_116_5 + var_116_6 and not isNil(var_116_4) then
				local var_116_7 = (arg_113_1.time_ - var_116_5) / var_116_6

				if arg_113_1.var_.characterEffect1084ui_story and not isNil(var_116_4) then
					local var_116_8 = Mathf.Lerp(0, 0.5, var_116_7)

					arg_113_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1084ui_story.fillRatio = var_116_8
				end
			end

			if arg_113_1.time_ >= var_116_5 + var_116_6 and arg_113_1.time_ < var_116_5 + var_116_6 + arg_116_0 and not isNil(var_116_4) and arg_113_1.var_.characterEffect1084ui_story then
				local var_116_9 = 0.5

				arg_113_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1084ui_story.fillRatio = var_116_9
			end

			local var_116_10 = 0

			if var_116_10 < arg_113_1.time_ and arg_113_1.time_ <= var_116_10 + arg_116_0 then
				arg_113_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action6_1")
			end

			local var_116_11 = 0

			if var_116_11 < arg_113_1.time_ and arg_113_1.time_ <= var_116_11 + arg_116_0 then
				arg_113_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_116_12 = 0
			local var_116_13 = 0.8

			if var_116_12 < arg_113_1.time_ and arg_113_1.time_ <= var_116_12 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_14 = arg_113_1:FormatText(StoryNameCfg[471].name)

				arg_113_1.leftNameTxt_.text = var_116_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_15 = arg_113_1:GetWordFromCfg(319651028)
				local var_116_16 = arg_113_1:FormatText(var_116_15.content)

				arg_113_1.text_.text = var_116_16

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_17 = 32
				local var_116_18 = utf8.len(var_116_16)
				local var_116_19 = var_116_17 <= 0 and var_116_13 or var_116_13 * (var_116_18 / var_116_17)

				if var_116_19 > 0 and var_116_13 < var_116_19 then
					arg_113_1.talkMaxDuration = var_116_19

					if var_116_19 + var_116_12 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_19 + var_116_12
					end
				end

				arg_113_1.text_.text = var_116_16
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651028", "story_v_out_319651.awb") ~= 0 then
					local var_116_20 = manager.audio:GetVoiceLength("story_v_out_319651", "319651028", "story_v_out_319651.awb") / 1000

					if var_116_20 + var_116_12 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_20 + var_116_12
					end

					if var_116_15.prefab_name ~= "" and arg_113_1.actors_[var_116_15.prefab_name] ~= nil then
						local var_116_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_15.prefab_name].transform, "story_v_out_319651", "319651028", "story_v_out_319651.awb")

						arg_113_1:RecordAudio("319651028", var_116_21)
						arg_113_1:RecordAudio("319651028", var_116_21)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_319651", "319651028", "story_v_out_319651.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_319651", "319651028", "story_v_out_319651.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_22 = math.max(var_116_13, arg_113_1.talkMaxDuration)

			if var_116_12 <= arg_113_1.time_ and arg_113_1.time_ < var_116_12 + var_116_22 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_12) / var_116_22

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_12 + var_116_22 and arg_113_1.time_ < var_116_12 + var_116_22 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play319651029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 319651029
		arg_117_1.duration_ = 11.5

		local var_117_0 = {
			zh = 7.166,
			ja = 11.5
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
				arg_117_0:Play319651030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0
			local var_120_1 = 0.95

			if var_120_0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_2 = arg_117_1:FormatText(StoryNameCfg[471].name)

				arg_117_1.leftNameTxt_.text = var_120_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_3 = arg_117_1:GetWordFromCfg(319651029)
				local var_120_4 = arg_117_1:FormatText(var_120_3.content)

				arg_117_1.text_.text = var_120_4

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_5 = 38
				local var_120_6 = utf8.len(var_120_4)
				local var_120_7 = var_120_5 <= 0 and var_120_1 or var_120_1 * (var_120_6 / var_120_5)

				if var_120_7 > 0 and var_120_1 < var_120_7 then
					arg_117_1.talkMaxDuration = var_120_7

					if var_120_7 + var_120_0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_7 + var_120_0
					end
				end

				arg_117_1.text_.text = var_120_4
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651029", "story_v_out_319651.awb") ~= 0 then
					local var_120_8 = manager.audio:GetVoiceLength("story_v_out_319651", "319651029", "story_v_out_319651.awb") / 1000

					if var_120_8 + var_120_0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_8 + var_120_0
					end

					if var_120_3.prefab_name ~= "" and arg_117_1.actors_[var_120_3.prefab_name] ~= nil then
						local var_120_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_3.prefab_name].transform, "story_v_out_319651", "319651029", "story_v_out_319651.awb")

						arg_117_1:RecordAudio("319651029", var_120_9)
						arg_117_1:RecordAudio("319651029", var_120_9)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_319651", "319651029", "story_v_out_319651.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_319651", "319651029", "story_v_out_319651.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_10 = math.max(var_120_1, arg_117_1.talkMaxDuration)

			if var_120_0 <= arg_117_1.time_ and arg_117_1.time_ < var_120_0 + var_120_10 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_0) / var_120_10

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_0 + var_120_10 and arg_117_1.time_ < var_120_0 + var_120_10 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play319651030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 319651030
		arg_121_1.duration_ = 2.23

		local var_121_0 = {
			zh = 1.999999999999,
			ja = 2.233
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
				arg_121_0:Play319651031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["1084ui_story"].transform
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				arg_121_1.var_.moveOldPos1084ui_story = var_124_0.localPosition
			end

			local var_124_2 = 0.001

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_2 then
				local var_124_3 = (arg_121_1.time_ - var_124_1) / var_124_2
				local var_124_4 = Vector3.New(0.7, -0.97, -6)

				var_124_0.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1084ui_story, var_124_4, var_124_3)

				local var_124_5 = manager.ui.mainCamera.transform.position - var_124_0.position

				var_124_0.forward = Vector3.New(var_124_5.x, var_124_5.y, var_124_5.z)

				local var_124_6 = var_124_0.localEulerAngles

				var_124_6.z = 0
				var_124_6.x = 0
				var_124_0.localEulerAngles = var_124_6
			end

			if arg_121_1.time_ >= var_124_1 + var_124_2 and arg_121_1.time_ < var_124_1 + var_124_2 + arg_124_0 then
				var_124_0.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_124_7 = manager.ui.mainCamera.transform.position - var_124_0.position

				var_124_0.forward = Vector3.New(var_124_7.x, var_124_7.y, var_124_7.z)

				local var_124_8 = var_124_0.localEulerAngles

				var_124_8.z = 0
				var_124_8.x = 0
				var_124_0.localEulerAngles = var_124_8
			end

			local var_124_9 = arg_121_1.actors_["1084ui_story"]
			local var_124_10 = 0

			if var_124_10 < arg_121_1.time_ and arg_121_1.time_ <= var_124_10 + arg_124_0 and not isNil(var_124_9) and arg_121_1.var_.characterEffect1084ui_story == nil then
				arg_121_1.var_.characterEffect1084ui_story = var_124_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_11 = 0.200000002980232

			if var_124_10 <= arg_121_1.time_ and arg_121_1.time_ < var_124_10 + var_124_11 and not isNil(var_124_9) then
				local var_124_12 = (arg_121_1.time_ - var_124_10) / var_124_11

				if arg_121_1.var_.characterEffect1084ui_story and not isNil(var_124_9) then
					arg_121_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= var_124_10 + var_124_11 and arg_121_1.time_ < var_124_10 + var_124_11 + arg_124_0 and not isNil(var_124_9) and arg_121_1.var_.characterEffect1084ui_story then
				arg_121_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_124_13 = 0

			if var_124_13 < arg_121_1.time_ and arg_121_1.time_ <= var_124_13 + arg_124_0 then
				arg_121_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			local var_124_14 = 0

			if var_124_14 < arg_121_1.time_ and arg_121_1.time_ <= var_124_14 + arg_124_0 then
				arg_121_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_124_15 = arg_121_1.actors_["10058ui_story"]
			local var_124_16 = 0

			if var_124_16 < arg_121_1.time_ and arg_121_1.time_ <= var_124_16 + arg_124_0 and not isNil(var_124_15) and arg_121_1.var_.characterEffect10058ui_story == nil then
				arg_121_1.var_.characterEffect10058ui_story = var_124_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_17 = 0.200000002980232

			if var_124_16 <= arg_121_1.time_ and arg_121_1.time_ < var_124_16 + var_124_17 and not isNil(var_124_15) then
				local var_124_18 = (arg_121_1.time_ - var_124_16) / var_124_17

				if arg_121_1.var_.characterEffect10058ui_story and not isNil(var_124_15) then
					local var_124_19 = Mathf.Lerp(0, 0.5, var_124_18)

					arg_121_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_121_1.var_.characterEffect10058ui_story.fillRatio = var_124_19
				end
			end

			if arg_121_1.time_ >= var_124_16 + var_124_17 and arg_121_1.time_ < var_124_16 + var_124_17 + arg_124_0 and not isNil(var_124_15) and arg_121_1.var_.characterEffect10058ui_story then
				local var_124_20 = 0.5

				arg_121_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_121_1.var_.characterEffect10058ui_story.fillRatio = var_124_20
			end

			local var_124_21 = 0
			local var_124_22 = 0.125

			if var_124_21 < arg_121_1.time_ and arg_121_1.time_ <= var_124_21 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_23 = arg_121_1:FormatText(StoryNameCfg[6].name)

				arg_121_1.leftNameTxt_.text = var_124_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_24 = arg_121_1:GetWordFromCfg(319651030)
				local var_124_25 = arg_121_1:FormatText(var_124_24.content)

				arg_121_1.text_.text = var_124_25

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_26 = 5
				local var_124_27 = utf8.len(var_124_25)
				local var_124_28 = var_124_26 <= 0 and var_124_22 or var_124_22 * (var_124_27 / var_124_26)

				if var_124_28 > 0 and var_124_22 < var_124_28 then
					arg_121_1.talkMaxDuration = var_124_28

					if var_124_28 + var_124_21 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_28 + var_124_21
					end
				end

				arg_121_1.text_.text = var_124_25
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651030", "story_v_out_319651.awb") ~= 0 then
					local var_124_29 = manager.audio:GetVoiceLength("story_v_out_319651", "319651030", "story_v_out_319651.awb") / 1000

					if var_124_29 + var_124_21 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_29 + var_124_21
					end

					if var_124_24.prefab_name ~= "" and arg_121_1.actors_[var_124_24.prefab_name] ~= nil then
						local var_124_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_24.prefab_name].transform, "story_v_out_319651", "319651030", "story_v_out_319651.awb")

						arg_121_1:RecordAudio("319651030", var_124_30)
						arg_121_1:RecordAudio("319651030", var_124_30)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_319651", "319651030", "story_v_out_319651.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_319651", "319651030", "story_v_out_319651.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_31 = math.max(var_124_22, arg_121_1.talkMaxDuration)

			if var_124_21 <= arg_121_1.time_ and arg_121_1.time_ < var_124_21 + var_124_31 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_21) / var_124_31

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_21 + var_124_31 and arg_121_1.time_ < var_124_21 + var_124_31 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play319651031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 319651031
		arg_125_1.duration_ = 8.2

		local var_125_0 = {
			zh = 7.3,
			ja = 8.2
		}
		local var_125_1 = manager.audio:GetLocalizationFlag()

		if var_125_0[var_125_1] ~= nil then
			arg_125_1.duration_ = var_125_0[var_125_1]
		end

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play319651032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["1084ui_story"].transform
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 then
				arg_125_1.var_.moveOldPos1084ui_story = var_128_0.localPosition
			end

			local var_128_2 = 0.001

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2
				local var_128_4 = Vector3.New(0, 100, 0)

				var_128_0.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1084ui_story, var_128_4, var_128_3)

				local var_128_5 = manager.ui.mainCamera.transform.position - var_128_0.position

				var_128_0.forward = Vector3.New(var_128_5.x, var_128_5.y, var_128_5.z)

				local var_128_6 = var_128_0.localEulerAngles

				var_128_6.z = 0
				var_128_6.x = 0
				var_128_0.localEulerAngles = var_128_6
			end

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 then
				var_128_0.localPosition = Vector3.New(0, 100, 0)

				local var_128_7 = manager.ui.mainCamera.transform.position - var_128_0.position

				var_128_0.forward = Vector3.New(var_128_7.x, var_128_7.y, var_128_7.z)

				local var_128_8 = var_128_0.localEulerAngles

				var_128_8.z = 0
				var_128_8.x = 0
				var_128_0.localEulerAngles = var_128_8
			end

			local var_128_9 = arg_125_1.actors_["10058ui_story"].transform
			local var_128_10 = 0

			if var_128_10 < arg_125_1.time_ and arg_125_1.time_ <= var_128_10 + arg_128_0 then
				arg_125_1.var_.moveOldPos10058ui_story = var_128_9.localPosition
			end

			local var_128_11 = 0.001

			if var_128_10 <= arg_125_1.time_ and arg_125_1.time_ < var_128_10 + var_128_11 then
				local var_128_12 = (arg_125_1.time_ - var_128_10) / var_128_11
				local var_128_13 = Vector3.New(0, 100, 0)

				var_128_9.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos10058ui_story, var_128_13, var_128_12)

				local var_128_14 = manager.ui.mainCamera.transform.position - var_128_9.position

				var_128_9.forward = Vector3.New(var_128_14.x, var_128_14.y, var_128_14.z)

				local var_128_15 = var_128_9.localEulerAngles

				var_128_15.z = 0
				var_128_15.x = 0
				var_128_9.localEulerAngles = var_128_15
			end

			if arg_125_1.time_ >= var_128_10 + var_128_11 and arg_125_1.time_ < var_128_10 + var_128_11 + arg_128_0 then
				var_128_9.localPosition = Vector3.New(0, 100, 0)

				local var_128_16 = manager.ui.mainCamera.transform.position - var_128_9.position

				var_128_9.forward = Vector3.New(var_128_16.x, var_128_16.y, var_128_16.z)

				local var_128_17 = var_128_9.localEulerAngles

				var_128_17.z = 0
				var_128_17.x = 0
				var_128_9.localEulerAngles = var_128_17
			end

			local var_128_18 = 0
			local var_128_19 = 0.475

			if var_128_18 < arg_125_1.time_ and arg_125_1.time_ <= var_128_18 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_20 = arg_125_1:FormatText(StoryNameCfg[36].name)

				arg_125_1.leftNameTxt_.text = var_128_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, true)
				arg_125_1.iconController_:SetSelectedState("hero")

				arg_125_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_125_1.callingController_:SetSelectedState("normal")

				arg_125_1.keyicon_.color = Color.New(1, 1, 1)
				arg_125_1.icon_.color = Color.New(1, 1, 1)

				local var_128_21 = arg_125_1:GetWordFromCfg(319651031)
				local var_128_22 = arg_125_1:FormatText(var_128_21.content)

				arg_125_1.text_.text = var_128_22

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_23 = 19
				local var_128_24 = utf8.len(var_128_22)
				local var_128_25 = var_128_23 <= 0 and var_128_19 or var_128_19 * (var_128_24 / var_128_23)

				if var_128_25 > 0 and var_128_19 < var_128_25 then
					arg_125_1.talkMaxDuration = var_128_25

					if var_128_25 + var_128_18 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_25 + var_128_18
					end
				end

				arg_125_1.text_.text = var_128_22
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651031", "story_v_out_319651.awb") ~= 0 then
					local var_128_26 = manager.audio:GetVoiceLength("story_v_out_319651", "319651031", "story_v_out_319651.awb") / 1000

					if var_128_26 + var_128_18 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_26 + var_128_18
					end

					if var_128_21.prefab_name ~= "" and arg_125_1.actors_[var_128_21.prefab_name] ~= nil then
						local var_128_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_21.prefab_name].transform, "story_v_out_319651", "319651031", "story_v_out_319651.awb")

						arg_125_1:RecordAudio("319651031", var_128_27)
						arg_125_1:RecordAudio("319651031", var_128_27)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_319651", "319651031", "story_v_out_319651.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_319651", "319651031", "story_v_out_319651.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_28 = math.max(var_128_19, arg_125_1.talkMaxDuration)

			if var_128_18 <= arg_125_1.time_ and arg_125_1.time_ < var_128_18 + var_128_28 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_18) / var_128_28

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_18 + var_128_28 and arg_125_1.time_ < var_128_18 + var_128_28 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play319651032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 319651032
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play319651033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0
			local var_132_1 = 1.25

			if var_132_0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, false)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_2 = arg_129_1:GetWordFromCfg(319651032)
				local var_132_3 = arg_129_1:FormatText(var_132_2.content)

				arg_129_1.text_.text = var_132_3

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_4 = 50
				local var_132_5 = utf8.len(var_132_3)
				local var_132_6 = var_132_4 <= 0 and var_132_1 or var_132_1 * (var_132_5 / var_132_4)

				if var_132_6 > 0 and var_132_1 < var_132_6 then
					arg_129_1.talkMaxDuration = var_132_6

					if var_132_6 + var_132_0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_6 + var_132_0
					end
				end

				arg_129_1.text_.text = var_132_3
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_7 = math.max(var_132_1, arg_129_1.talkMaxDuration)

			if var_132_0 <= arg_129_1.time_ and arg_129_1.time_ < var_132_0 + var_132_7 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_0) / var_132_7

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_0 + var_132_7 and arg_129_1.time_ < var_132_0 + var_132_7 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play319651033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 319651033
		arg_133_1.duration_ = 3.37

		local var_133_0 = {
			zh = 2.666,
			ja = 3.366
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
				arg_133_0:Play319651034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["10058ui_story"].transform
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 then
				arg_133_1.var_.moveOldPos10058ui_story = var_136_0.localPosition
			end

			local var_136_2 = 0.001

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_2 then
				local var_136_3 = (arg_133_1.time_ - var_136_1) / var_136_2
				local var_136_4 = Vector3.New(0, -0.98, -6.1)

				var_136_0.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos10058ui_story, var_136_4, var_136_3)

				local var_136_5 = manager.ui.mainCamera.transform.position - var_136_0.position

				var_136_0.forward = Vector3.New(var_136_5.x, var_136_5.y, var_136_5.z)

				local var_136_6 = var_136_0.localEulerAngles

				var_136_6.z = 0
				var_136_6.x = 0
				var_136_0.localEulerAngles = var_136_6
			end

			if arg_133_1.time_ >= var_136_1 + var_136_2 and arg_133_1.time_ < var_136_1 + var_136_2 + arg_136_0 then
				var_136_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_136_7 = manager.ui.mainCamera.transform.position - var_136_0.position

				var_136_0.forward = Vector3.New(var_136_7.x, var_136_7.y, var_136_7.z)

				local var_136_8 = var_136_0.localEulerAngles

				var_136_8.z = 0
				var_136_8.x = 0
				var_136_0.localEulerAngles = var_136_8
			end

			local var_136_9 = arg_133_1.actors_["10058ui_story"]
			local var_136_10 = 0

			if var_136_10 < arg_133_1.time_ and arg_133_1.time_ <= var_136_10 + arg_136_0 and not isNil(var_136_9) and arg_133_1.var_.characterEffect10058ui_story == nil then
				arg_133_1.var_.characterEffect10058ui_story = var_136_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_11 = 0.200000002980232

			if var_136_10 <= arg_133_1.time_ and arg_133_1.time_ < var_136_10 + var_136_11 and not isNil(var_136_9) then
				local var_136_12 = (arg_133_1.time_ - var_136_10) / var_136_11

				if arg_133_1.var_.characterEffect10058ui_story and not isNil(var_136_9) then
					arg_133_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= var_136_10 + var_136_11 and arg_133_1.time_ < var_136_10 + var_136_11 + arg_136_0 and not isNil(var_136_9) and arg_133_1.var_.characterEffect10058ui_story then
				arg_133_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_136_13 = 0

			if var_136_13 < arg_133_1.time_ and arg_133_1.time_ <= var_136_13 + arg_136_0 then
				arg_133_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action6_2")
			end

			local var_136_14 = 0

			if var_136_14 < arg_133_1.time_ and arg_133_1.time_ <= var_136_14 + arg_136_0 then
				arg_133_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_136_15 = 0
			local var_136_16 = 0.25

			if var_136_15 < arg_133_1.time_ and arg_133_1.time_ <= var_136_15 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_17 = arg_133_1:FormatText(StoryNameCfg[471].name)

				arg_133_1.leftNameTxt_.text = var_136_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_18 = arg_133_1:GetWordFromCfg(319651033)
				local var_136_19 = arg_133_1:FormatText(var_136_18.content)

				arg_133_1.text_.text = var_136_19

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_20 = 10
				local var_136_21 = utf8.len(var_136_19)
				local var_136_22 = var_136_20 <= 0 and var_136_16 or var_136_16 * (var_136_21 / var_136_20)

				if var_136_22 > 0 and var_136_16 < var_136_22 then
					arg_133_1.talkMaxDuration = var_136_22

					if var_136_22 + var_136_15 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_22 + var_136_15
					end
				end

				arg_133_1.text_.text = var_136_19
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651033", "story_v_out_319651.awb") ~= 0 then
					local var_136_23 = manager.audio:GetVoiceLength("story_v_out_319651", "319651033", "story_v_out_319651.awb") / 1000

					if var_136_23 + var_136_15 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_23 + var_136_15
					end

					if var_136_18.prefab_name ~= "" and arg_133_1.actors_[var_136_18.prefab_name] ~= nil then
						local var_136_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_18.prefab_name].transform, "story_v_out_319651", "319651033", "story_v_out_319651.awb")

						arg_133_1:RecordAudio("319651033", var_136_24)
						arg_133_1:RecordAudio("319651033", var_136_24)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_319651", "319651033", "story_v_out_319651.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_319651", "319651033", "story_v_out_319651.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_25 = math.max(var_136_16, arg_133_1.talkMaxDuration)

			if var_136_15 <= arg_133_1.time_ and arg_133_1.time_ < var_136_15 + var_136_25 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_15) / var_136_25

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_15 + var_136_25 and arg_133_1.time_ < var_136_15 + var_136_25 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play319651034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 319651034
		arg_137_1.duration_ = 4.2

		local var_137_0 = {
			zh = 1.999999999999,
			ja = 4.2
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
				arg_137_0:Play319651035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = "10066ui_story"

			if arg_137_1.actors_[var_140_0] == nil then
				local var_140_1 = Asset.Load("Char/" .. "10066ui_story")

				if not isNil(var_140_1) then
					local var_140_2 = Object.Instantiate(Asset.Load("Char/" .. "10066ui_story"), arg_137_1.stage_.transform)

					var_140_2.name = var_140_0
					var_140_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_137_1.actors_[var_140_0] = var_140_2

					local var_140_3 = var_140_2:GetComponentInChildren(typeof(CharacterEffect))

					var_140_3.enabled = true

					local var_140_4 = GameObjectTools.GetOrAddComponent(var_140_2, typeof(DynamicBoneHelper))

					if var_140_4 then
						var_140_4:EnableDynamicBone(false)
					end

					arg_137_1:ShowWeapon(var_140_3.transform, false)

					arg_137_1.var_[var_140_0 .. "Animator"] = var_140_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_137_1.var_[var_140_0 .. "Animator"].applyRootMotion = true
					arg_137_1.var_[var_140_0 .. "LipSync"] = var_140_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_140_5 = arg_137_1.actors_["10066ui_story"].transform
			local var_140_6 = 0

			if var_140_6 < arg_137_1.time_ and arg_137_1.time_ <= var_140_6 + arg_140_0 then
				arg_137_1.var_.moveOldPos10066ui_story = var_140_5.localPosition
			end

			local var_140_7 = 0.001

			if var_140_6 <= arg_137_1.time_ and arg_137_1.time_ < var_140_6 + var_140_7 then
				local var_140_8 = (arg_137_1.time_ - var_140_6) / var_140_7
				local var_140_9 = Vector3.New(0, -0.99, -5.83)

				var_140_5.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos10066ui_story, var_140_9, var_140_8)

				local var_140_10 = manager.ui.mainCamera.transform.position - var_140_5.position

				var_140_5.forward = Vector3.New(var_140_10.x, var_140_10.y, var_140_10.z)

				local var_140_11 = var_140_5.localEulerAngles

				var_140_11.z = 0
				var_140_11.x = 0
				var_140_5.localEulerAngles = var_140_11
			end

			if arg_137_1.time_ >= var_140_6 + var_140_7 and arg_137_1.time_ < var_140_6 + var_140_7 + arg_140_0 then
				var_140_5.localPosition = Vector3.New(0, -0.99, -5.83)

				local var_140_12 = manager.ui.mainCamera.transform.position - var_140_5.position

				var_140_5.forward = Vector3.New(var_140_12.x, var_140_12.y, var_140_12.z)

				local var_140_13 = var_140_5.localEulerAngles

				var_140_13.z = 0
				var_140_13.x = 0
				var_140_5.localEulerAngles = var_140_13
			end

			local var_140_14 = arg_137_1.actors_["10066ui_story"]
			local var_140_15 = 0

			if var_140_15 < arg_137_1.time_ and arg_137_1.time_ <= var_140_15 + arg_140_0 and not isNil(var_140_14) and arg_137_1.var_.characterEffect10066ui_story == nil then
				arg_137_1.var_.characterEffect10066ui_story = var_140_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_16 = 0.200000002980232

			if var_140_15 <= arg_137_1.time_ and arg_137_1.time_ < var_140_15 + var_140_16 and not isNil(var_140_14) then
				local var_140_17 = (arg_137_1.time_ - var_140_15) / var_140_16

				if arg_137_1.var_.characterEffect10066ui_story and not isNil(var_140_14) then
					arg_137_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= var_140_15 + var_140_16 and arg_137_1.time_ < var_140_15 + var_140_16 + arg_140_0 and not isNil(var_140_14) and arg_137_1.var_.characterEffect10066ui_story then
				arg_137_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_140_18 = 0

			if var_140_18 < arg_137_1.time_ and arg_137_1.time_ <= var_140_18 + arg_140_0 then
				arg_137_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action4_1")
			end

			local var_140_19 = 0

			if var_140_19 < arg_137_1.time_ and arg_137_1.time_ <= var_140_19 + arg_140_0 then
				arg_137_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_140_20 = arg_137_1.actors_["1084ui_story"].transform
			local var_140_21 = 0

			if var_140_21 < arg_137_1.time_ and arg_137_1.time_ <= var_140_21 + arg_140_0 then
				arg_137_1.var_.moveOldPos1084ui_story = var_140_20.localPosition
			end

			local var_140_22 = 0.001

			if var_140_21 <= arg_137_1.time_ and arg_137_1.time_ < var_140_21 + var_140_22 then
				local var_140_23 = (arg_137_1.time_ - var_140_21) / var_140_22
				local var_140_24 = Vector3.New(0, 100, 0)

				var_140_20.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1084ui_story, var_140_24, var_140_23)

				local var_140_25 = manager.ui.mainCamera.transform.position - var_140_20.position

				var_140_20.forward = Vector3.New(var_140_25.x, var_140_25.y, var_140_25.z)

				local var_140_26 = var_140_20.localEulerAngles

				var_140_26.z = 0
				var_140_26.x = 0
				var_140_20.localEulerAngles = var_140_26
			end

			if arg_137_1.time_ >= var_140_21 + var_140_22 and arg_137_1.time_ < var_140_21 + var_140_22 + arg_140_0 then
				var_140_20.localPosition = Vector3.New(0, 100, 0)

				local var_140_27 = manager.ui.mainCamera.transform.position - var_140_20.position

				var_140_20.forward = Vector3.New(var_140_27.x, var_140_27.y, var_140_27.z)

				local var_140_28 = var_140_20.localEulerAngles

				var_140_28.z = 0
				var_140_28.x = 0
				var_140_20.localEulerAngles = var_140_28
			end

			local var_140_29 = arg_137_1.actors_["10058ui_story"].transform
			local var_140_30 = 0

			if var_140_30 < arg_137_1.time_ and arg_137_1.time_ <= var_140_30 + arg_140_0 then
				arg_137_1.var_.moveOldPos10058ui_story = var_140_29.localPosition
			end

			local var_140_31 = 0.001

			if var_140_30 <= arg_137_1.time_ and arg_137_1.time_ < var_140_30 + var_140_31 then
				local var_140_32 = (arg_137_1.time_ - var_140_30) / var_140_31
				local var_140_33 = Vector3.New(0, 100, 0)

				var_140_29.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos10058ui_story, var_140_33, var_140_32)

				local var_140_34 = manager.ui.mainCamera.transform.position - var_140_29.position

				var_140_29.forward = Vector3.New(var_140_34.x, var_140_34.y, var_140_34.z)

				local var_140_35 = var_140_29.localEulerAngles

				var_140_35.z = 0
				var_140_35.x = 0
				var_140_29.localEulerAngles = var_140_35
			end

			if arg_137_1.time_ >= var_140_30 + var_140_31 and arg_137_1.time_ < var_140_30 + var_140_31 + arg_140_0 then
				var_140_29.localPosition = Vector3.New(0, 100, 0)

				local var_140_36 = manager.ui.mainCamera.transform.position - var_140_29.position

				var_140_29.forward = Vector3.New(var_140_36.x, var_140_36.y, var_140_36.z)

				local var_140_37 = var_140_29.localEulerAngles

				var_140_37.z = 0
				var_140_37.x = 0
				var_140_29.localEulerAngles = var_140_37
			end

			local var_140_38 = arg_137_1.actors_["10058ui_story"]
			local var_140_39 = 0

			if var_140_39 < arg_137_1.time_ and arg_137_1.time_ <= var_140_39 + arg_140_0 and not isNil(var_140_38) and arg_137_1.var_.characterEffect10058ui_story == nil then
				arg_137_1.var_.characterEffect10058ui_story = var_140_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_40 = 0.200000002980232

			if var_140_39 <= arg_137_1.time_ and arg_137_1.time_ < var_140_39 + var_140_40 and not isNil(var_140_38) then
				local var_140_41 = (arg_137_1.time_ - var_140_39) / var_140_40

				if arg_137_1.var_.characterEffect10058ui_story and not isNil(var_140_38) then
					local var_140_42 = Mathf.Lerp(0, 0.5, var_140_41)

					arg_137_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_137_1.var_.characterEffect10058ui_story.fillRatio = var_140_42
				end
			end

			if arg_137_1.time_ >= var_140_39 + var_140_40 and arg_137_1.time_ < var_140_39 + var_140_40 + arg_140_0 and not isNil(var_140_38) and arg_137_1.var_.characterEffect10058ui_story then
				local var_140_43 = 0.5

				arg_137_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_137_1.var_.characterEffect10058ui_story.fillRatio = var_140_43
			end

			local var_140_44 = 0
			local var_140_45 = 0.05

			if var_140_44 < arg_137_1.time_ and arg_137_1.time_ <= var_140_44 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_46 = arg_137_1:FormatText(StoryNameCfg[640].name)

				arg_137_1.leftNameTxt_.text = var_140_46

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_47 = arg_137_1:GetWordFromCfg(319651034)
				local var_140_48 = arg_137_1:FormatText(var_140_47.content)

				arg_137_1.text_.text = var_140_48

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_49 = 2
				local var_140_50 = utf8.len(var_140_48)
				local var_140_51 = var_140_49 <= 0 and var_140_45 or var_140_45 * (var_140_50 / var_140_49)

				if var_140_51 > 0 and var_140_45 < var_140_51 then
					arg_137_1.talkMaxDuration = var_140_51

					if var_140_51 + var_140_44 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_51 + var_140_44
					end
				end

				arg_137_1.text_.text = var_140_48
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651034", "story_v_out_319651.awb") ~= 0 then
					local var_140_52 = manager.audio:GetVoiceLength("story_v_out_319651", "319651034", "story_v_out_319651.awb") / 1000

					if var_140_52 + var_140_44 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_52 + var_140_44
					end

					if var_140_47.prefab_name ~= "" and arg_137_1.actors_[var_140_47.prefab_name] ~= nil then
						local var_140_53 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_47.prefab_name].transform, "story_v_out_319651", "319651034", "story_v_out_319651.awb")

						arg_137_1:RecordAudio("319651034", var_140_53)
						arg_137_1:RecordAudio("319651034", var_140_53)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_319651", "319651034", "story_v_out_319651.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_319651", "319651034", "story_v_out_319651.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_54 = math.max(var_140_45, arg_137_1.talkMaxDuration)

			if var_140_44 <= arg_137_1.time_ and arg_137_1.time_ < var_140_44 + var_140_54 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_44) / var_140_54

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_44 + var_140_54 and arg_137_1.time_ < var_140_44 + var_140_54 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_137_1:InitPlayNodeList()
	end,
	Play319651035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 319651035
		arg_141_1.duration_ = 8.63

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play319651036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = "ML0201"

			if arg_141_1.bgs_[var_144_0] == nil then
				local var_144_1 = Object.Instantiate(arg_141_1.paintGo_)

				var_144_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_144_0)
				var_144_1.name = var_144_0
				var_144_1.transform.parent = arg_141_1.stage_.transform
				var_144_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_141_1.bgs_[var_144_0] = var_144_1
			end

			local var_144_2 = 1.96599999815226

			if var_144_2 < arg_141_1.time_ and arg_141_1.time_ <= var_144_2 + arg_144_0 then
				local var_144_3 = manager.ui.mainCamera.transform.localPosition
				local var_144_4 = Vector3.New(0, 0, 10) + Vector3.New(var_144_3.x, var_144_3.y, 0)
				local var_144_5 = arg_141_1.bgs_.ML0201

				var_144_5.transform.localPosition = var_144_4
				var_144_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_144_6 = var_144_5:GetComponent("SpriteRenderer")

				if var_144_6 and var_144_6.sprite then
					local var_144_7 = (var_144_5.transform.localPosition - var_144_3).z
					local var_144_8 = manager.ui.mainCameraCom_
					local var_144_9 = 2 * var_144_7 * Mathf.Tan(var_144_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_144_10 = var_144_9 * var_144_8.aspect
					local var_144_11 = var_144_6.sprite.bounds.size.x
					local var_144_12 = var_144_6.sprite.bounds.size.y
					local var_144_13 = var_144_10 / var_144_11
					local var_144_14 = var_144_9 / var_144_12
					local var_144_15 = var_144_14 < var_144_13 and var_144_13 or var_144_14

					var_144_5.transform.localScale = Vector3.New(var_144_15, var_144_15, 0)
				end

				for iter_144_0, iter_144_1 in pairs(arg_141_1.bgs_) do
					if iter_144_0 ~= "ML0201" then
						iter_144_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_144_16 = 0

			if var_144_16 < arg_141_1.time_ and arg_141_1.time_ <= var_144_16 + arg_144_0 then
				arg_141_1.allBtn_.enabled = false
			end

			local var_144_17 = 0.3

			if arg_141_1.time_ >= var_144_16 + var_144_17 and arg_141_1.time_ < var_144_16 + var_144_17 + arg_144_0 then
				arg_141_1.allBtn_.enabled = true
			end

			local var_144_18 = 0

			if var_144_18 < arg_141_1.time_ and arg_141_1.time_ <= var_144_18 + arg_144_0 then
				arg_141_1.mask_.enabled = true
				arg_141_1.mask_.raycastTarget = true

				arg_141_1:SetGaussion(false)
			end

			local var_144_19 = 2

			if var_144_18 <= arg_141_1.time_ and arg_141_1.time_ < var_144_18 + var_144_19 then
				local var_144_20 = (arg_141_1.time_ - var_144_18) / var_144_19
				local var_144_21 = Color.New(0, 0, 0)

				var_144_21.a = Mathf.Lerp(0, 1, var_144_20)
				arg_141_1.mask_.color = var_144_21
			end

			if arg_141_1.time_ >= var_144_18 + var_144_19 and arg_141_1.time_ < var_144_18 + var_144_19 + arg_144_0 then
				local var_144_22 = Color.New(0, 0, 0)

				var_144_22.a = 1
				arg_141_1.mask_.color = var_144_22
			end

			local var_144_23 = 2

			if var_144_23 < arg_141_1.time_ and arg_141_1.time_ <= var_144_23 + arg_144_0 then
				arg_141_1.mask_.enabled = true
				arg_141_1.mask_.raycastTarget = true

				arg_141_1:SetGaussion(false)
			end

			local var_144_24 = 2

			if var_144_23 <= arg_141_1.time_ and arg_141_1.time_ < var_144_23 + var_144_24 then
				local var_144_25 = (arg_141_1.time_ - var_144_23) / var_144_24
				local var_144_26 = Color.New(0, 0, 0)

				var_144_26.a = Mathf.Lerp(1, 0, var_144_25)
				arg_141_1.mask_.color = var_144_26
			end

			if arg_141_1.time_ >= var_144_23 + var_144_24 and arg_141_1.time_ < var_144_23 + var_144_24 + arg_144_0 then
				local var_144_27 = Color.New(0, 0, 0)
				local var_144_28 = 0

				arg_141_1.mask_.enabled = false
				var_144_27.a = var_144_28
				arg_141_1.mask_.color = var_144_27
			end

			local var_144_29 = arg_141_1.actors_["10066ui_story"].transform
			local var_144_30 = 1.96666666666667

			if var_144_30 < arg_141_1.time_ and arg_141_1.time_ <= var_144_30 + arg_144_0 then
				arg_141_1.var_.moveOldPos10066ui_story = var_144_29.localPosition
			end

			local var_144_31 = 0.001

			if var_144_30 <= arg_141_1.time_ and arg_141_1.time_ < var_144_30 + var_144_31 then
				local var_144_32 = (arg_141_1.time_ - var_144_30) / var_144_31
				local var_144_33 = Vector3.New(0, 100, 0)

				var_144_29.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos10066ui_story, var_144_33, var_144_32)

				local var_144_34 = manager.ui.mainCamera.transform.position - var_144_29.position

				var_144_29.forward = Vector3.New(var_144_34.x, var_144_34.y, var_144_34.z)

				local var_144_35 = var_144_29.localEulerAngles

				var_144_35.z = 0
				var_144_35.x = 0
				var_144_29.localEulerAngles = var_144_35
			end

			if arg_141_1.time_ >= var_144_30 + var_144_31 and arg_141_1.time_ < var_144_30 + var_144_31 + arg_144_0 then
				var_144_29.localPosition = Vector3.New(0, 100, 0)

				local var_144_36 = manager.ui.mainCamera.transform.position - var_144_29.position

				var_144_29.forward = Vector3.New(var_144_36.x, var_144_36.y, var_144_36.z)

				local var_144_37 = var_144_29.localEulerAngles

				var_144_37.z = 0
				var_144_37.x = 0
				var_144_29.localEulerAngles = var_144_37
			end

			local var_144_38 = arg_141_1.bgs_.ML0201.transform
			local var_144_39 = 2

			if var_144_39 < arg_141_1.time_ and arg_141_1.time_ <= var_144_39 + arg_144_0 then
				arg_141_1.var_.moveOldPosML0201 = var_144_38.localPosition
			end

			local var_144_40 = 0.001

			if var_144_39 <= arg_141_1.time_ and arg_141_1.time_ < var_144_39 + var_144_40 then
				local var_144_41 = (arg_141_1.time_ - var_144_39) / var_144_40
				local var_144_42 = Vector3.New(0, 1, 10)

				var_144_38.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPosML0201, var_144_42, var_144_41)
			end

			if arg_141_1.time_ >= var_144_39 + var_144_40 and arg_141_1.time_ < var_144_39 + var_144_40 + arg_144_0 then
				var_144_38.localPosition = Vector3.New(0, 1, 10)
			end

			local var_144_43 = arg_141_1.bgs_.ML0201.transform
			local var_144_44 = 2.01666666666667

			if var_144_44 < arg_141_1.time_ and arg_141_1.time_ <= var_144_44 + arg_144_0 then
				arg_141_1.var_.moveOldPosML0201 = var_144_43.localPosition
			end

			local var_144_45 = 1.96599999815226

			if var_144_44 <= arg_141_1.time_ and arg_141_1.time_ < var_144_44 + var_144_45 then
				local var_144_46 = (arg_141_1.time_ - var_144_44) / var_144_45
				local var_144_47 = Vector3.New(0, 0.78, 8.15)

				var_144_43.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPosML0201, var_144_47, var_144_46)
			end

			if arg_141_1.time_ >= var_144_44 + var_144_45 and arg_141_1.time_ < var_144_44 + var_144_45 + arg_144_0 then
				var_144_43.localPosition = Vector3.New(0, 0.78, 8.15)
			end

			if arg_141_1.frameCnt_ <= 1 then
				arg_141_1.dialog_:SetActive(false)
			end

			local var_144_48 = 3.63333333333333
			local var_144_49 = 1.375

			if var_144_48 < arg_141_1.time_ and arg_141_1.time_ <= var_144_48 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0

				arg_141_1.dialog_:SetActive(true)

				arg_141_1.dialogCg_.alpha = 0

				local var_144_50 = LeanTween.value(arg_141_1.dialog_, 0, 1, 0.3)

				var_144_50:setOnUpdate(LuaHelper.FloatAction(function(arg_145_0)
					arg_141_1.dialogCg_.alpha = arg_145_0
				end))
				var_144_50:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_141_1.dialog_)
					var_144_50:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_141_1.duration_ = arg_141_1.duration_ + 0.3

				SetActive(arg_141_1.leftNameGo_, false)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_51 = arg_141_1:GetWordFromCfg(319651035)
				local var_144_52 = arg_141_1:FormatText(var_144_51.content)

				arg_141_1.text_.text = var_144_52

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_53 = 55
				local var_144_54 = utf8.len(var_144_52)
				local var_144_55 = var_144_53 <= 0 and var_144_49 or var_144_49 * (var_144_54 / var_144_53)

				if var_144_55 > 0 and var_144_49 < var_144_55 then
					arg_141_1.talkMaxDuration = var_144_55
					var_144_48 = var_144_48 + 0.3

					if var_144_55 + var_144_48 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_55 + var_144_48
					end
				end

				arg_141_1.text_.text = var_144_52
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_56 = var_144_48 + 0.3
			local var_144_57 = math.max(var_144_49, arg_141_1.talkMaxDuration)

			if var_144_56 <= arg_141_1.time_ and arg_141_1.time_ < var_144_56 + var_144_57 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_56) / var_144_57

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_56 + var_144_57 and arg_141_1.time_ < var_144_56 + var_144_57 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "ML0201",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "ML0201",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.96599999815226,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_141_1:InitPlayNodeList()
	end,
	Play319651036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 319651036
		arg_147_1.duration_ = 8.97

		local var_147_0 = {
			zh = 5,
			ja = 8.966
		}
		local var_147_1 = manager.audio:GetLocalizationFlag()

		if var_147_0[var_147_1] ~= nil then
			arg_147_1.duration_ = var_147_0[var_147_1]
		end

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play319651037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0
			local var_150_1 = 0.275

			if var_150_0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_2 = arg_147_1:FormatText(StoryNameCfg[640].name)

				arg_147_1.leftNameTxt_.text = var_150_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_3 = arg_147_1:GetWordFromCfg(319651036)
				local var_150_4 = arg_147_1:FormatText(var_150_3.content)

				arg_147_1.text_.text = var_150_4

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_5 = 11
				local var_150_6 = utf8.len(var_150_4)
				local var_150_7 = var_150_5 <= 0 and var_150_1 or var_150_1 * (var_150_6 / var_150_5)

				if var_150_7 > 0 and var_150_1 < var_150_7 then
					arg_147_1.talkMaxDuration = var_150_7

					if var_150_7 + var_150_0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_7 + var_150_0
					end
				end

				arg_147_1.text_.text = var_150_4
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651036", "story_v_out_319651.awb") ~= 0 then
					local var_150_8 = manager.audio:GetVoiceLength("story_v_out_319651", "319651036", "story_v_out_319651.awb") / 1000

					if var_150_8 + var_150_0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_8 + var_150_0
					end

					if var_150_3.prefab_name ~= "" and arg_147_1.actors_[var_150_3.prefab_name] ~= nil then
						local var_150_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_3.prefab_name].transform, "story_v_out_319651", "319651036", "story_v_out_319651.awb")

						arg_147_1:RecordAudio("319651036", var_150_9)
						arg_147_1:RecordAudio("319651036", var_150_9)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_319651", "319651036", "story_v_out_319651.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_319651", "319651036", "story_v_out_319651.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_10 = math.max(var_150_1, arg_147_1.talkMaxDuration)

			if var_150_0 <= arg_147_1.time_ and arg_147_1.time_ < var_150_0 + var_150_10 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_0) / var_150_10

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_0 + var_150_10 and arg_147_1.time_ < var_150_0 + var_150_10 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play319651037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 319651037
		arg_151_1.duration_ = 4.7

		local var_151_0 = {
			zh = 3.9,
			ja = 4.7
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
				arg_151_0:Play319651038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0
			local var_154_1 = 0.45

			if var_154_0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_2 = arg_151_1:FormatText(StoryNameCfg[6].name)

				arg_151_1.leftNameTxt_.text = var_154_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_3 = arg_151_1:GetWordFromCfg(319651037)
				local var_154_4 = arg_151_1:FormatText(var_154_3.content)

				arg_151_1.text_.text = var_154_4

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_5 = 18
				local var_154_6 = utf8.len(var_154_4)
				local var_154_7 = var_154_5 <= 0 and var_154_1 or var_154_1 * (var_154_6 / var_154_5)

				if var_154_7 > 0 and var_154_1 < var_154_7 then
					arg_151_1.talkMaxDuration = var_154_7

					if var_154_7 + var_154_0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_7 + var_154_0
					end
				end

				arg_151_1.text_.text = var_154_4
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651037", "story_v_out_319651.awb") ~= 0 then
					local var_154_8 = manager.audio:GetVoiceLength("story_v_out_319651", "319651037", "story_v_out_319651.awb") / 1000

					if var_154_8 + var_154_0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_8 + var_154_0
					end

					if var_154_3.prefab_name ~= "" and arg_151_1.actors_[var_154_3.prefab_name] ~= nil then
						local var_154_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_3.prefab_name].transform, "story_v_out_319651", "319651037", "story_v_out_319651.awb")

						arg_151_1:RecordAudio("319651037", var_154_9)
						arg_151_1:RecordAudio("319651037", var_154_9)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_319651", "319651037", "story_v_out_319651.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_319651", "319651037", "story_v_out_319651.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_10 = math.max(var_154_1, arg_151_1.talkMaxDuration)

			if var_154_0 <= arg_151_1.time_ and arg_151_1.time_ < var_154_0 + var_154_10 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_0) / var_154_10

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_0 + var_154_10 and arg_151_1.time_ < var_154_0 + var_154_10 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play319651038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 319651038
		arg_155_1.duration_ = 6.23

		local var_155_0 = {
			zh = 5.4,
			ja = 6.233
		}
		local var_155_1 = manager.audio:GetLocalizationFlag()

		if var_155_0[var_155_1] ~= nil then
			arg_155_1.duration_ = var_155_0[var_155_1]
		end

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play319651039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0
			local var_158_1 = 0.475

			if var_158_0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_2 = arg_155_1:FormatText(StoryNameCfg[640].name)

				arg_155_1.leftNameTxt_.text = var_158_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_3 = arg_155_1:GetWordFromCfg(319651038)
				local var_158_4 = arg_155_1:FormatText(var_158_3.content)

				arg_155_1.text_.text = var_158_4

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_5 = 19
				local var_158_6 = utf8.len(var_158_4)
				local var_158_7 = var_158_5 <= 0 and var_158_1 or var_158_1 * (var_158_6 / var_158_5)

				if var_158_7 > 0 and var_158_1 < var_158_7 then
					arg_155_1.talkMaxDuration = var_158_7

					if var_158_7 + var_158_0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_7 + var_158_0
					end
				end

				arg_155_1.text_.text = var_158_4
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651038", "story_v_out_319651.awb") ~= 0 then
					local var_158_8 = manager.audio:GetVoiceLength("story_v_out_319651", "319651038", "story_v_out_319651.awb") / 1000

					if var_158_8 + var_158_0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_8 + var_158_0
					end

					if var_158_3.prefab_name ~= "" and arg_155_1.actors_[var_158_3.prefab_name] ~= nil then
						local var_158_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_3.prefab_name].transform, "story_v_out_319651", "319651038", "story_v_out_319651.awb")

						arg_155_1:RecordAudio("319651038", var_158_9)
						arg_155_1:RecordAudio("319651038", var_158_9)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_319651", "319651038", "story_v_out_319651.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_319651", "319651038", "story_v_out_319651.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_10 = math.max(var_158_1, arg_155_1.talkMaxDuration)

			if var_158_0 <= arg_155_1.time_ and arg_155_1.time_ < var_158_0 + var_158_10 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_0) / var_158_10

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_0 + var_158_10 and arg_155_1.time_ < var_158_0 + var_158_10 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play319651039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 319651039
		arg_159_1.duration_ = 8.23

		local var_159_0 = {
			zh = 7.266,
			ja = 8.233
		}
		local var_159_1 = manager.audio:GetLocalizationFlag()

		if var_159_0[var_159_1] ~= nil then
			arg_159_1.duration_ = var_159_0[var_159_1]
		end

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play319651040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0
			local var_162_1 = 0.8

			if var_162_0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_2 = arg_159_1:FormatText(StoryNameCfg[640].name)

				arg_159_1.leftNameTxt_.text = var_162_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_3 = arg_159_1:GetWordFromCfg(319651039)
				local var_162_4 = arg_159_1:FormatText(var_162_3.content)

				arg_159_1.text_.text = var_162_4

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_5 = 32
				local var_162_6 = utf8.len(var_162_4)
				local var_162_7 = var_162_5 <= 0 and var_162_1 or var_162_1 * (var_162_6 / var_162_5)

				if var_162_7 > 0 and var_162_1 < var_162_7 then
					arg_159_1.talkMaxDuration = var_162_7

					if var_162_7 + var_162_0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_7 + var_162_0
					end
				end

				arg_159_1.text_.text = var_162_4
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651039", "story_v_out_319651.awb") ~= 0 then
					local var_162_8 = manager.audio:GetVoiceLength("story_v_out_319651", "319651039", "story_v_out_319651.awb") / 1000

					if var_162_8 + var_162_0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_8 + var_162_0
					end

					if var_162_3.prefab_name ~= "" and arg_159_1.actors_[var_162_3.prefab_name] ~= nil then
						local var_162_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_3.prefab_name].transform, "story_v_out_319651", "319651039", "story_v_out_319651.awb")

						arg_159_1:RecordAudio("319651039", var_162_9)
						arg_159_1:RecordAudio("319651039", var_162_9)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_319651", "319651039", "story_v_out_319651.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_319651", "319651039", "story_v_out_319651.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_10 = math.max(var_162_1, arg_159_1.talkMaxDuration)

			if var_162_0 <= arg_159_1.time_ and arg_159_1.time_ < var_162_0 + var_162_10 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_0) / var_162_10

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_0 + var_162_10 and arg_159_1.time_ < var_162_0 + var_162_10 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play319651040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 319651040
		arg_163_1.duration_ = 9.83

		local var_163_0 = {
			zh = 7.2,
			ja = 9.833
		}
		local var_163_1 = manager.audio:GetLocalizationFlag()

		if var_163_0[var_163_1] ~= nil then
			arg_163_1.duration_ = var_163_0[var_163_1]
		end

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play319651041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0
			local var_166_1 = 0.825

			if var_166_0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_2 = arg_163_1:FormatText(StoryNameCfg[6].name)

				arg_163_1.leftNameTxt_.text = var_166_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_3 = arg_163_1:GetWordFromCfg(319651040)
				local var_166_4 = arg_163_1:FormatText(var_166_3.content)

				arg_163_1.text_.text = var_166_4

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_5 = 33
				local var_166_6 = utf8.len(var_166_4)
				local var_166_7 = var_166_5 <= 0 and var_166_1 or var_166_1 * (var_166_6 / var_166_5)

				if var_166_7 > 0 and var_166_1 < var_166_7 then
					arg_163_1.talkMaxDuration = var_166_7

					if var_166_7 + var_166_0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_7 + var_166_0
					end
				end

				arg_163_1.text_.text = var_166_4
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651040", "story_v_out_319651.awb") ~= 0 then
					local var_166_8 = manager.audio:GetVoiceLength("story_v_out_319651", "319651040", "story_v_out_319651.awb") / 1000

					if var_166_8 + var_166_0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_8 + var_166_0
					end

					if var_166_3.prefab_name ~= "" and arg_163_1.actors_[var_166_3.prefab_name] ~= nil then
						local var_166_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_3.prefab_name].transform, "story_v_out_319651", "319651040", "story_v_out_319651.awb")

						arg_163_1:RecordAudio("319651040", var_166_9)
						arg_163_1:RecordAudio("319651040", var_166_9)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_319651", "319651040", "story_v_out_319651.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_319651", "319651040", "story_v_out_319651.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_10 = math.max(var_166_1, arg_163_1.talkMaxDuration)

			if var_166_0 <= arg_163_1.time_ and arg_163_1.time_ < var_166_0 + var_166_10 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_0) / var_166_10

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_0 + var_166_10 and arg_163_1.time_ < var_166_0 + var_166_10 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play319651041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 319651041
		arg_167_1.duration_ = 8.57

		local var_167_0 = {
			zh = 8.3,
			ja = 8.566
		}
		local var_167_1 = manager.audio:GetLocalizationFlag()

		if var_167_0[var_167_1] ~= nil then
			arg_167_1.duration_ = var_167_0[var_167_1]
		end

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play319651042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0
			local var_170_1 = 0.8

			if var_170_0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_2 = arg_167_1:FormatText(StoryNameCfg[640].name)

				arg_167_1.leftNameTxt_.text = var_170_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_3 = arg_167_1:GetWordFromCfg(319651041)
				local var_170_4 = arg_167_1:FormatText(var_170_3.content)

				arg_167_1.text_.text = var_170_4

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_5 = 32
				local var_170_6 = utf8.len(var_170_4)
				local var_170_7 = var_170_5 <= 0 and var_170_1 or var_170_1 * (var_170_6 / var_170_5)

				if var_170_7 > 0 and var_170_1 < var_170_7 then
					arg_167_1.talkMaxDuration = var_170_7

					if var_170_7 + var_170_0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_7 + var_170_0
					end
				end

				arg_167_1.text_.text = var_170_4
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651041", "story_v_out_319651.awb") ~= 0 then
					local var_170_8 = manager.audio:GetVoiceLength("story_v_out_319651", "319651041", "story_v_out_319651.awb") / 1000

					if var_170_8 + var_170_0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_8 + var_170_0
					end

					if var_170_3.prefab_name ~= "" and arg_167_1.actors_[var_170_3.prefab_name] ~= nil then
						local var_170_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_3.prefab_name].transform, "story_v_out_319651", "319651041", "story_v_out_319651.awb")

						arg_167_1:RecordAudio("319651041", var_170_9)
						arg_167_1:RecordAudio("319651041", var_170_9)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_319651", "319651041", "story_v_out_319651.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_319651", "319651041", "story_v_out_319651.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_10 = math.max(var_170_1, arg_167_1.talkMaxDuration)

			if var_170_0 <= arg_167_1.time_ and arg_167_1.time_ < var_170_0 + var_170_10 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_0) / var_170_10

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_0 + var_170_10 and arg_167_1.time_ < var_170_0 + var_170_10 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play319651042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 319651042
		arg_171_1.duration_ = 7.07

		local var_171_0 = {
			zh = 7.066,
			ja = 4.566
		}
		local var_171_1 = manager.audio:GetLocalizationFlag()

		if var_171_0[var_171_1] ~= nil then
			arg_171_1.duration_ = var_171_0[var_171_1]
		end

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play319651043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0
			local var_174_1 = 0.475

			if var_174_0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_2 = arg_171_1:FormatText(StoryNameCfg[640].name)

				arg_171_1.leftNameTxt_.text = var_174_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_3 = arg_171_1:GetWordFromCfg(319651042)
				local var_174_4 = arg_171_1:FormatText(var_174_3.content)

				arg_171_1.text_.text = var_174_4

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_5 = 19
				local var_174_6 = utf8.len(var_174_4)
				local var_174_7 = var_174_5 <= 0 and var_174_1 or var_174_1 * (var_174_6 / var_174_5)

				if var_174_7 > 0 and var_174_1 < var_174_7 then
					arg_171_1.talkMaxDuration = var_174_7

					if var_174_7 + var_174_0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_7 + var_174_0
					end
				end

				arg_171_1.text_.text = var_174_4
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651042", "story_v_out_319651.awb") ~= 0 then
					local var_174_8 = manager.audio:GetVoiceLength("story_v_out_319651", "319651042", "story_v_out_319651.awb") / 1000

					if var_174_8 + var_174_0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_8 + var_174_0
					end

					if var_174_3.prefab_name ~= "" and arg_171_1.actors_[var_174_3.prefab_name] ~= nil then
						local var_174_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_3.prefab_name].transform, "story_v_out_319651", "319651042", "story_v_out_319651.awb")

						arg_171_1:RecordAudio("319651042", var_174_9)
						arg_171_1:RecordAudio("319651042", var_174_9)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_319651", "319651042", "story_v_out_319651.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_319651", "319651042", "story_v_out_319651.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_10 = math.max(var_174_1, arg_171_1.talkMaxDuration)

			if var_174_0 <= arg_171_1.time_ and arg_171_1.time_ < var_174_0 + var_174_10 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_0) / var_174_10

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_0 + var_174_10 and arg_171_1.time_ < var_174_0 + var_174_10 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play319651043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 319651043
		arg_175_1.duration_ = 8.4

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play319651044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 2

			if var_178_0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_0 + arg_178_0 then
				local var_178_1 = manager.ui.mainCamera.transform.localPosition
				local var_178_2 = Vector3.New(0, 0, 10) + Vector3.New(var_178_1.x, var_178_1.y, 0)
				local var_178_3 = arg_175_1.bgs_.ST74

				var_178_3.transform.localPosition = var_178_2
				var_178_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_178_4 = var_178_3:GetComponent("SpriteRenderer")

				if var_178_4 and var_178_4.sprite then
					local var_178_5 = (var_178_3.transform.localPosition - var_178_1).z
					local var_178_6 = manager.ui.mainCameraCom_
					local var_178_7 = 2 * var_178_5 * Mathf.Tan(var_178_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_178_8 = var_178_7 * var_178_6.aspect
					local var_178_9 = var_178_4.sprite.bounds.size.x
					local var_178_10 = var_178_4.sprite.bounds.size.y
					local var_178_11 = var_178_8 / var_178_9
					local var_178_12 = var_178_7 / var_178_10
					local var_178_13 = var_178_12 < var_178_11 and var_178_11 or var_178_12

					var_178_3.transform.localScale = Vector3.New(var_178_13, var_178_13, 0)
				end

				for iter_178_0, iter_178_1 in pairs(arg_175_1.bgs_) do
					if iter_178_0 ~= "ST74" then
						iter_178_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_178_14 = 0

			if var_178_14 < arg_175_1.time_ and arg_175_1.time_ <= var_178_14 + arg_178_0 then
				arg_175_1.allBtn_.enabled = false
			end

			local var_178_15 = 0.3

			if arg_175_1.time_ >= var_178_14 + var_178_15 and arg_175_1.time_ < var_178_14 + var_178_15 + arg_178_0 then
				arg_175_1.allBtn_.enabled = true
			end

			local var_178_16 = 0

			if var_178_16 < arg_175_1.time_ and arg_175_1.time_ <= var_178_16 + arg_178_0 then
				arg_175_1.mask_.enabled = true
				arg_175_1.mask_.raycastTarget = true

				arg_175_1:SetGaussion(false)
			end

			local var_178_17 = 2

			if var_178_16 <= arg_175_1.time_ and arg_175_1.time_ < var_178_16 + var_178_17 then
				local var_178_18 = (arg_175_1.time_ - var_178_16) / var_178_17
				local var_178_19 = Color.New(0, 0, 0)

				var_178_19.a = Mathf.Lerp(0, 1, var_178_18)
				arg_175_1.mask_.color = var_178_19
			end

			if arg_175_1.time_ >= var_178_16 + var_178_17 and arg_175_1.time_ < var_178_16 + var_178_17 + arg_178_0 then
				local var_178_20 = Color.New(0, 0, 0)

				var_178_20.a = 1
				arg_175_1.mask_.color = var_178_20
			end

			local var_178_21 = 2

			if var_178_21 < arg_175_1.time_ and arg_175_1.time_ <= var_178_21 + arg_178_0 then
				arg_175_1.mask_.enabled = true
				arg_175_1.mask_.raycastTarget = true

				arg_175_1:SetGaussion(false)
			end

			local var_178_22 = 1.5

			if var_178_21 <= arg_175_1.time_ and arg_175_1.time_ < var_178_21 + var_178_22 then
				local var_178_23 = (arg_175_1.time_ - var_178_21) / var_178_22
				local var_178_24 = Color.New(0, 0, 0)

				var_178_24.a = Mathf.Lerp(1, 0, var_178_23)
				arg_175_1.mask_.color = var_178_24
			end

			if arg_175_1.time_ >= var_178_21 + var_178_22 and arg_175_1.time_ < var_178_21 + var_178_22 + arg_178_0 then
				local var_178_25 = Color.New(0, 0, 0)
				local var_178_26 = 0

				arg_175_1.mask_.enabled = false
				var_178_25.a = var_178_26
				arg_175_1.mask_.color = var_178_25
			end

			if arg_175_1.frameCnt_ <= 1 then
				arg_175_1.dialog_:SetActive(false)
			end

			local var_178_27 = 3.4
			local var_178_28 = 0.5

			if var_178_27 < arg_175_1.time_ and arg_175_1.time_ <= var_178_27 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0

				arg_175_1.dialog_:SetActive(true)

				arg_175_1.dialogCg_.alpha = 0

				local var_178_29 = LeanTween.value(arg_175_1.dialog_, 0, 1, 0.3)

				var_178_29:setOnUpdate(LuaHelper.FloatAction(function(arg_179_0)
					arg_175_1.dialogCg_.alpha = arg_179_0
				end))
				var_178_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_175_1.dialog_)
					var_178_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_175_1.duration_ = arg_175_1.duration_ + 0.3

				SetActive(arg_175_1.leftNameGo_, false)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_30 = arg_175_1:GetWordFromCfg(319651043)
				local var_178_31 = arg_175_1:FormatText(var_178_30.content)

				arg_175_1.text_.text = var_178_31

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_32 = 20
				local var_178_33 = utf8.len(var_178_31)
				local var_178_34 = var_178_32 <= 0 and var_178_28 or var_178_28 * (var_178_33 / var_178_32)

				if var_178_34 > 0 and var_178_28 < var_178_34 then
					arg_175_1.talkMaxDuration = var_178_34
					var_178_27 = var_178_27 + 0.3

					if var_178_34 + var_178_27 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_34 + var_178_27
					end
				end

				arg_175_1.text_.text = var_178_31
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_35 = var_178_27 + 0.3
			local var_178_36 = math.max(var_178_28, arg_175_1.talkMaxDuration)

			if var_178_35 <= arg_175_1.time_ and arg_175_1.time_ < var_178_35 + var_178_36 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_35) / var_178_36

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_35 + var_178_36 and arg_175_1.time_ < var_178_35 + var_178_36 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play319651044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 319651044
		arg_181_1.duration_ = 3.4

		local var_181_0 = {
			zh = 3.033,
			ja = 3.4
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
				arg_181_0:Play319651045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["10066ui_story"].transform
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 then
				arg_181_1.var_.moveOldPos10066ui_story = var_184_0.localPosition
			end

			local var_184_2 = 0.001

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_2 then
				local var_184_3 = (arg_181_1.time_ - var_184_1) / var_184_2
				local var_184_4 = Vector3.New(0, -0.99, -5.83)

				var_184_0.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos10066ui_story, var_184_4, var_184_3)

				local var_184_5 = manager.ui.mainCamera.transform.position - var_184_0.position

				var_184_0.forward = Vector3.New(var_184_5.x, var_184_5.y, var_184_5.z)

				local var_184_6 = var_184_0.localEulerAngles

				var_184_6.z = 0
				var_184_6.x = 0
				var_184_0.localEulerAngles = var_184_6
			end

			if arg_181_1.time_ >= var_184_1 + var_184_2 and arg_181_1.time_ < var_184_1 + var_184_2 + arg_184_0 then
				var_184_0.localPosition = Vector3.New(0, -0.99, -5.83)

				local var_184_7 = manager.ui.mainCamera.transform.position - var_184_0.position

				var_184_0.forward = Vector3.New(var_184_7.x, var_184_7.y, var_184_7.z)

				local var_184_8 = var_184_0.localEulerAngles

				var_184_8.z = 0
				var_184_8.x = 0
				var_184_0.localEulerAngles = var_184_8
			end

			local var_184_9 = arg_181_1.actors_["10066ui_story"]
			local var_184_10 = 0

			if var_184_10 < arg_181_1.time_ and arg_181_1.time_ <= var_184_10 + arg_184_0 and not isNil(var_184_9) and arg_181_1.var_.characterEffect10066ui_story == nil then
				arg_181_1.var_.characterEffect10066ui_story = var_184_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_11 = 0.200000002980232

			if var_184_10 <= arg_181_1.time_ and arg_181_1.time_ < var_184_10 + var_184_11 and not isNil(var_184_9) then
				local var_184_12 = (arg_181_1.time_ - var_184_10) / var_184_11

				if arg_181_1.var_.characterEffect10066ui_story and not isNil(var_184_9) then
					arg_181_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= var_184_10 + var_184_11 and arg_181_1.time_ < var_184_10 + var_184_11 + arg_184_0 and not isNil(var_184_9) and arg_181_1.var_.characterEffect10066ui_story then
				arg_181_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_184_13 = 0

			if var_184_13 < arg_181_1.time_ and arg_181_1.time_ <= var_184_13 + arg_184_0 then
				arg_181_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action4_2")
			end

			local var_184_14 = 0

			if var_184_14 < arg_181_1.time_ and arg_181_1.time_ <= var_184_14 + arg_184_0 then
				arg_181_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_184_15 = 0
			local var_184_16 = 0.275

			if var_184_15 < arg_181_1.time_ and arg_181_1.time_ <= var_184_15 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_17 = arg_181_1:FormatText(StoryNameCfg[640].name)

				arg_181_1.leftNameTxt_.text = var_184_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_18 = arg_181_1:GetWordFromCfg(319651044)
				local var_184_19 = arg_181_1:FormatText(var_184_18.content)

				arg_181_1.text_.text = var_184_19

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_20 = 11
				local var_184_21 = utf8.len(var_184_19)
				local var_184_22 = var_184_20 <= 0 and var_184_16 or var_184_16 * (var_184_21 / var_184_20)

				if var_184_22 > 0 and var_184_16 < var_184_22 then
					arg_181_1.talkMaxDuration = var_184_22

					if var_184_22 + var_184_15 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_22 + var_184_15
					end
				end

				arg_181_1.text_.text = var_184_19
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651044", "story_v_out_319651.awb") ~= 0 then
					local var_184_23 = manager.audio:GetVoiceLength("story_v_out_319651", "319651044", "story_v_out_319651.awb") / 1000

					if var_184_23 + var_184_15 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_23 + var_184_15
					end

					if var_184_18.prefab_name ~= "" and arg_181_1.actors_[var_184_18.prefab_name] ~= nil then
						local var_184_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_18.prefab_name].transform, "story_v_out_319651", "319651044", "story_v_out_319651.awb")

						arg_181_1:RecordAudio("319651044", var_184_24)
						arg_181_1:RecordAudio("319651044", var_184_24)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_319651", "319651044", "story_v_out_319651.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_319651", "319651044", "story_v_out_319651.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_25 = math.max(var_184_16, arg_181_1.talkMaxDuration)

			if var_184_15 <= arg_181_1.time_ and arg_181_1.time_ < var_184_15 + var_184_25 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_15) / var_184_25

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_15 + var_184_25 and arg_181_1.time_ < var_184_15 + var_184_25 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_181_1:InitPlayNodeList()
	end,
	Play319651045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 319651045
		arg_185_1.duration_ = 4.17

		local var_185_0 = {
			zh = 2.833,
			ja = 4.166
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
				arg_185_0:Play319651046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.actors_["1084ui_story"].transform
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 then
				arg_185_1.var_.moveOldPos1084ui_story = var_188_0.localPosition

				local var_188_2 = "1084ui_story"

				arg_185_1:ShowWeapon(arg_185_1.var_[var_188_2 .. "Animator"].transform, false)
			end

			local var_188_3 = 0.001

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_3 then
				local var_188_4 = (arg_185_1.time_ - var_188_1) / var_188_3
				local var_188_5 = Vector3.New(0, -0.97, -6)

				var_188_0.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1084ui_story, var_188_5, var_188_4)

				local var_188_6 = manager.ui.mainCamera.transform.position - var_188_0.position

				var_188_0.forward = Vector3.New(var_188_6.x, var_188_6.y, var_188_6.z)

				local var_188_7 = var_188_0.localEulerAngles

				var_188_7.z = 0
				var_188_7.x = 0
				var_188_0.localEulerAngles = var_188_7
			end

			if arg_185_1.time_ >= var_188_1 + var_188_3 and arg_185_1.time_ < var_188_1 + var_188_3 + arg_188_0 then
				var_188_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_188_8 = manager.ui.mainCamera.transform.position - var_188_0.position

				var_188_0.forward = Vector3.New(var_188_8.x, var_188_8.y, var_188_8.z)

				local var_188_9 = var_188_0.localEulerAngles

				var_188_9.z = 0
				var_188_9.x = 0
				var_188_0.localEulerAngles = var_188_9
			end

			local var_188_10 = arg_185_1.actors_["1084ui_story"]
			local var_188_11 = 0

			if var_188_11 < arg_185_1.time_ and arg_185_1.time_ <= var_188_11 + arg_188_0 and not isNil(var_188_10) and arg_185_1.var_.characterEffect1084ui_story == nil then
				arg_185_1.var_.characterEffect1084ui_story = var_188_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_12 = 0.200000002980232

			if var_188_11 <= arg_185_1.time_ and arg_185_1.time_ < var_188_11 + var_188_12 and not isNil(var_188_10) then
				local var_188_13 = (arg_185_1.time_ - var_188_11) / var_188_12

				if arg_185_1.var_.characterEffect1084ui_story and not isNil(var_188_10) then
					arg_185_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= var_188_11 + var_188_12 and arg_185_1.time_ < var_188_11 + var_188_12 + arg_188_0 and not isNil(var_188_10) and arg_185_1.var_.characterEffect1084ui_story then
				arg_185_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_188_14 = 0

			if var_188_14 < arg_185_1.time_ and arg_185_1.time_ <= var_188_14 + arg_188_0 then
				arg_185_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_188_15 = arg_185_1.actors_["10066ui_story"].transform
			local var_188_16 = 0

			if var_188_16 < arg_185_1.time_ and arg_185_1.time_ <= var_188_16 + arg_188_0 then
				arg_185_1.var_.moveOldPos10066ui_story = var_188_15.localPosition
			end

			local var_188_17 = 0.001

			if var_188_16 <= arg_185_1.time_ and arg_185_1.time_ < var_188_16 + var_188_17 then
				local var_188_18 = (arg_185_1.time_ - var_188_16) / var_188_17
				local var_188_19 = Vector3.New(0, 100, 0)

				var_188_15.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos10066ui_story, var_188_19, var_188_18)

				local var_188_20 = manager.ui.mainCamera.transform.position - var_188_15.position

				var_188_15.forward = Vector3.New(var_188_20.x, var_188_20.y, var_188_20.z)

				local var_188_21 = var_188_15.localEulerAngles

				var_188_21.z = 0
				var_188_21.x = 0
				var_188_15.localEulerAngles = var_188_21
			end

			if arg_185_1.time_ >= var_188_16 + var_188_17 and arg_185_1.time_ < var_188_16 + var_188_17 + arg_188_0 then
				var_188_15.localPosition = Vector3.New(0, 100, 0)

				local var_188_22 = manager.ui.mainCamera.transform.position - var_188_15.position

				var_188_15.forward = Vector3.New(var_188_22.x, var_188_22.y, var_188_22.z)

				local var_188_23 = var_188_15.localEulerAngles

				var_188_23.z = 0
				var_188_23.x = 0
				var_188_15.localEulerAngles = var_188_23
			end

			local var_188_24 = arg_185_1.actors_["10066ui_story"]
			local var_188_25 = 0

			if var_188_25 < arg_185_1.time_ and arg_185_1.time_ <= var_188_25 + arg_188_0 and not isNil(var_188_24) and arg_185_1.var_.characterEffect10066ui_story == nil then
				arg_185_1.var_.characterEffect10066ui_story = var_188_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_26 = 0.200000002980232

			if var_188_25 <= arg_185_1.time_ and arg_185_1.time_ < var_188_25 + var_188_26 and not isNil(var_188_24) then
				local var_188_27 = (arg_185_1.time_ - var_188_25) / var_188_26

				if arg_185_1.var_.characterEffect10066ui_story and not isNil(var_188_24) then
					local var_188_28 = Mathf.Lerp(0, 0.5, var_188_27)

					arg_185_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_185_1.var_.characterEffect10066ui_story.fillRatio = var_188_28
				end
			end

			if arg_185_1.time_ >= var_188_25 + var_188_26 and arg_185_1.time_ < var_188_25 + var_188_26 + arg_188_0 and not isNil(var_188_24) and arg_185_1.var_.characterEffect10066ui_story then
				local var_188_29 = 0.5

				arg_185_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_185_1.var_.characterEffect10066ui_story.fillRatio = var_188_29
			end

			local var_188_30 = 0

			if var_188_30 < arg_185_1.time_ and arg_185_1.time_ <= var_188_30 + arg_188_0 then
				arg_185_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			local var_188_31 = 0
			local var_188_32 = 0.275

			if var_188_31 < arg_185_1.time_ and arg_185_1.time_ <= var_188_31 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_33 = arg_185_1:FormatText(StoryNameCfg[6].name)

				arg_185_1.leftNameTxt_.text = var_188_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_34 = arg_185_1:GetWordFromCfg(319651045)
				local var_188_35 = arg_185_1:FormatText(var_188_34.content)

				arg_185_1.text_.text = var_188_35

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_36 = 11
				local var_188_37 = utf8.len(var_188_35)
				local var_188_38 = var_188_36 <= 0 and var_188_32 or var_188_32 * (var_188_37 / var_188_36)

				if var_188_38 > 0 and var_188_32 < var_188_38 then
					arg_185_1.talkMaxDuration = var_188_38

					if var_188_38 + var_188_31 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_38 + var_188_31
					end
				end

				arg_185_1.text_.text = var_188_35
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651045", "story_v_out_319651.awb") ~= 0 then
					local var_188_39 = manager.audio:GetVoiceLength("story_v_out_319651", "319651045", "story_v_out_319651.awb") / 1000

					if var_188_39 + var_188_31 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_39 + var_188_31
					end

					if var_188_34.prefab_name ~= "" and arg_185_1.actors_[var_188_34.prefab_name] ~= nil then
						local var_188_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_34.prefab_name].transform, "story_v_out_319651", "319651045", "story_v_out_319651.awb")

						arg_185_1:RecordAudio("319651045", var_188_40)
						arg_185_1:RecordAudio("319651045", var_188_40)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_319651", "319651045", "story_v_out_319651.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_319651", "319651045", "story_v_out_319651.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_41 = math.max(var_188_32, arg_185_1.talkMaxDuration)

			if var_188_31 <= arg_185_1.time_ and arg_185_1.time_ < var_188_31 + var_188_41 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_31) / var_188_41

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_31 + var_188_41 and arg_185_1.time_ < var_188_31 + var_188_41 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play319651046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 319651046
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play319651047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["1084ui_story"].transform
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 then
				arg_189_1.var_.moveOldPos1084ui_story = var_192_0.localPosition
			end

			local var_192_2 = 0.001

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_2 then
				local var_192_3 = (arg_189_1.time_ - var_192_1) / var_192_2
				local var_192_4 = Vector3.New(0, 100, 0)

				var_192_0.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1084ui_story, var_192_4, var_192_3)

				local var_192_5 = manager.ui.mainCamera.transform.position - var_192_0.position

				var_192_0.forward = Vector3.New(var_192_5.x, var_192_5.y, var_192_5.z)

				local var_192_6 = var_192_0.localEulerAngles

				var_192_6.z = 0
				var_192_6.x = 0
				var_192_0.localEulerAngles = var_192_6
			end

			if arg_189_1.time_ >= var_192_1 + var_192_2 and arg_189_1.time_ < var_192_1 + var_192_2 + arg_192_0 then
				var_192_0.localPosition = Vector3.New(0, 100, 0)

				local var_192_7 = manager.ui.mainCamera.transform.position - var_192_0.position

				var_192_0.forward = Vector3.New(var_192_7.x, var_192_7.y, var_192_7.z)

				local var_192_8 = var_192_0.localEulerAngles

				var_192_8.z = 0
				var_192_8.x = 0
				var_192_0.localEulerAngles = var_192_8
			end

			local var_192_9 = arg_189_1.actors_["1084ui_story"]
			local var_192_10 = 0

			if var_192_10 < arg_189_1.time_ and arg_189_1.time_ <= var_192_10 + arg_192_0 and not isNil(var_192_9) and arg_189_1.var_.characterEffect1084ui_story == nil then
				arg_189_1.var_.characterEffect1084ui_story = var_192_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_11 = 0.200000002980232

			if var_192_10 <= arg_189_1.time_ and arg_189_1.time_ < var_192_10 + var_192_11 and not isNil(var_192_9) then
				local var_192_12 = (arg_189_1.time_ - var_192_10) / var_192_11

				if arg_189_1.var_.characterEffect1084ui_story and not isNil(var_192_9) then
					local var_192_13 = Mathf.Lerp(0, 0.5, var_192_12)

					arg_189_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_189_1.var_.characterEffect1084ui_story.fillRatio = var_192_13
				end
			end

			if arg_189_1.time_ >= var_192_10 + var_192_11 and arg_189_1.time_ < var_192_10 + var_192_11 + arg_192_0 and not isNil(var_192_9) and arg_189_1.var_.characterEffect1084ui_story then
				local var_192_14 = 0.5

				arg_189_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_189_1.var_.characterEffect1084ui_story.fillRatio = var_192_14
			end

			local var_192_15 = 0
			local var_192_16 = 0.8

			if var_192_15 < arg_189_1.time_ and arg_189_1.time_ <= var_192_15 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, false)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_17 = arg_189_1:GetWordFromCfg(319651046)
				local var_192_18 = arg_189_1:FormatText(var_192_17.content)

				arg_189_1.text_.text = var_192_18

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_19 = 32
				local var_192_20 = utf8.len(var_192_18)
				local var_192_21 = var_192_19 <= 0 and var_192_16 or var_192_16 * (var_192_20 / var_192_19)

				if var_192_21 > 0 and var_192_16 < var_192_21 then
					arg_189_1.talkMaxDuration = var_192_21

					if var_192_21 + var_192_15 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_21 + var_192_15
					end
				end

				arg_189_1.text_.text = var_192_18
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_22 = math.max(var_192_16, arg_189_1.talkMaxDuration)

			if var_192_15 <= arg_189_1.time_ and arg_189_1.time_ < var_192_15 + var_192_22 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_15) / var_192_22

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_15 + var_192_22 and arg_189_1.time_ < var_192_15 + var_192_22 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_189_1:InitPlayNodeList()
	end,
	Play319651047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 319651047
		arg_193_1.duration_ = 6.37

		local var_193_0 = {
			zh = 3.2,
			ja = 6.366
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
				arg_193_0:Play319651048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["10066ui_story"].transform
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 then
				arg_193_1.var_.moveOldPos10066ui_story = var_196_0.localPosition
			end

			local var_196_2 = 0.001

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_2 then
				local var_196_3 = (arg_193_1.time_ - var_196_1) / var_196_2
				local var_196_4 = Vector3.New(0, -0.99, -5.83)

				var_196_0.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos10066ui_story, var_196_4, var_196_3)

				local var_196_5 = manager.ui.mainCamera.transform.position - var_196_0.position

				var_196_0.forward = Vector3.New(var_196_5.x, var_196_5.y, var_196_5.z)

				local var_196_6 = var_196_0.localEulerAngles

				var_196_6.z = 0
				var_196_6.x = 0
				var_196_0.localEulerAngles = var_196_6
			end

			if arg_193_1.time_ >= var_196_1 + var_196_2 and arg_193_1.time_ < var_196_1 + var_196_2 + arg_196_0 then
				var_196_0.localPosition = Vector3.New(0, -0.99, -5.83)

				local var_196_7 = manager.ui.mainCamera.transform.position - var_196_0.position

				var_196_0.forward = Vector3.New(var_196_7.x, var_196_7.y, var_196_7.z)

				local var_196_8 = var_196_0.localEulerAngles

				var_196_8.z = 0
				var_196_8.x = 0
				var_196_0.localEulerAngles = var_196_8
			end

			local var_196_9 = arg_193_1.actors_["10066ui_story"]
			local var_196_10 = 0

			if var_196_10 < arg_193_1.time_ and arg_193_1.time_ <= var_196_10 + arg_196_0 and not isNil(var_196_9) and arg_193_1.var_.characterEffect10066ui_story == nil then
				arg_193_1.var_.characterEffect10066ui_story = var_196_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_11 = 0.200000002980232

			if var_196_10 <= arg_193_1.time_ and arg_193_1.time_ < var_196_10 + var_196_11 and not isNil(var_196_9) then
				local var_196_12 = (arg_193_1.time_ - var_196_10) / var_196_11

				if arg_193_1.var_.characterEffect10066ui_story and not isNil(var_196_9) then
					arg_193_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= var_196_10 + var_196_11 and arg_193_1.time_ < var_196_10 + var_196_11 + arg_196_0 and not isNil(var_196_9) and arg_193_1.var_.characterEffect10066ui_story then
				arg_193_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_196_13 = 0

			if var_196_13 < arg_193_1.time_ and arg_193_1.time_ <= var_196_13 + arg_196_0 then
				arg_193_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action7_1")
			end

			local var_196_14 = 0

			if var_196_14 < arg_193_1.time_ and arg_193_1.time_ <= var_196_14 + arg_196_0 then
				arg_193_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_196_15 = 0
			local var_196_16 = 0.3

			if var_196_15 < arg_193_1.time_ and arg_193_1.time_ <= var_196_15 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_17 = arg_193_1:FormatText(StoryNameCfg[640].name)

				arg_193_1.leftNameTxt_.text = var_196_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_18 = arg_193_1:GetWordFromCfg(319651047)
				local var_196_19 = arg_193_1:FormatText(var_196_18.content)

				arg_193_1.text_.text = var_196_19

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_20 = 12
				local var_196_21 = utf8.len(var_196_19)
				local var_196_22 = var_196_20 <= 0 and var_196_16 or var_196_16 * (var_196_21 / var_196_20)

				if var_196_22 > 0 and var_196_16 < var_196_22 then
					arg_193_1.talkMaxDuration = var_196_22

					if var_196_22 + var_196_15 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_22 + var_196_15
					end
				end

				arg_193_1.text_.text = var_196_19
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651047", "story_v_out_319651.awb") ~= 0 then
					local var_196_23 = manager.audio:GetVoiceLength("story_v_out_319651", "319651047", "story_v_out_319651.awb") / 1000

					if var_196_23 + var_196_15 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_23 + var_196_15
					end

					if var_196_18.prefab_name ~= "" and arg_193_1.actors_[var_196_18.prefab_name] ~= nil then
						local var_196_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_18.prefab_name].transform, "story_v_out_319651", "319651047", "story_v_out_319651.awb")

						arg_193_1:RecordAudio("319651047", var_196_24)
						arg_193_1:RecordAudio("319651047", var_196_24)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_319651", "319651047", "story_v_out_319651.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_319651", "319651047", "story_v_out_319651.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_25 = math.max(var_196_16, arg_193_1.talkMaxDuration)

			if var_196_15 <= arg_193_1.time_ and arg_193_1.time_ < var_196_15 + var_196_25 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_15) / var_196_25

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_15 + var_196_25 and arg_193_1.time_ < var_196_15 + var_196_25 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_193_1:InitPlayNodeList()
	end,
	Play319651048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 319651048
		arg_197_1.duration_ = 8

		local var_197_0 = {
			zh = 4.6,
			ja = 8
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
				arg_197_0:Play319651049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0
			local var_200_1 = 0.475

			if var_200_0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_2 = arg_197_1:FormatText(StoryNameCfg[640].name)

				arg_197_1.leftNameTxt_.text = var_200_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_3 = arg_197_1:GetWordFromCfg(319651048)
				local var_200_4 = arg_197_1:FormatText(var_200_3.content)

				arg_197_1.text_.text = var_200_4

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_5 = 19
				local var_200_6 = utf8.len(var_200_4)
				local var_200_7 = var_200_5 <= 0 and var_200_1 or var_200_1 * (var_200_6 / var_200_5)

				if var_200_7 > 0 and var_200_1 < var_200_7 then
					arg_197_1.talkMaxDuration = var_200_7

					if var_200_7 + var_200_0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_7 + var_200_0
					end
				end

				arg_197_1.text_.text = var_200_4
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651048", "story_v_out_319651.awb") ~= 0 then
					local var_200_8 = manager.audio:GetVoiceLength("story_v_out_319651", "319651048", "story_v_out_319651.awb") / 1000

					if var_200_8 + var_200_0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_8 + var_200_0
					end

					if var_200_3.prefab_name ~= "" and arg_197_1.actors_[var_200_3.prefab_name] ~= nil then
						local var_200_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_3.prefab_name].transform, "story_v_out_319651", "319651048", "story_v_out_319651.awb")

						arg_197_1:RecordAudio("319651048", var_200_9)
						arg_197_1:RecordAudio("319651048", var_200_9)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_319651", "319651048", "story_v_out_319651.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_319651", "319651048", "story_v_out_319651.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_10 = math.max(var_200_1, arg_197_1.talkMaxDuration)

			if var_200_0 <= arg_197_1.time_ and arg_197_1.time_ < var_200_0 + var_200_10 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_0) / var_200_10

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_0 + var_200_10 and arg_197_1.time_ < var_200_0 + var_200_10 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play319651049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 319651049
		arg_201_1.duration_ = 10.7

		local var_201_0 = {
			zh = 6.866,
			ja = 10.7
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
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play319651050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = arg_201_1.actors_["10058ui_story"].transform
			local var_204_1 = 0

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 then
				arg_201_1.var_.moveOldPos10058ui_story = var_204_0.localPosition
			end

			local var_204_2 = 0.001

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_2 then
				local var_204_3 = (arg_201_1.time_ - var_204_1) / var_204_2
				local var_204_4 = Vector3.New(-0.7, -0.98, -6.1)

				var_204_0.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos10058ui_story, var_204_4, var_204_3)

				local var_204_5 = manager.ui.mainCamera.transform.position - var_204_0.position

				var_204_0.forward = Vector3.New(var_204_5.x, var_204_5.y, var_204_5.z)

				local var_204_6 = var_204_0.localEulerAngles

				var_204_6.z = 0
				var_204_6.x = 0
				var_204_0.localEulerAngles = var_204_6
			end

			if arg_201_1.time_ >= var_204_1 + var_204_2 and arg_201_1.time_ < var_204_1 + var_204_2 + arg_204_0 then
				var_204_0.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_204_7 = manager.ui.mainCamera.transform.position - var_204_0.position

				var_204_0.forward = Vector3.New(var_204_7.x, var_204_7.y, var_204_7.z)

				local var_204_8 = var_204_0.localEulerAngles

				var_204_8.z = 0
				var_204_8.x = 0
				var_204_0.localEulerAngles = var_204_8
			end

			local var_204_9 = arg_201_1.actors_["10058ui_story"]
			local var_204_10 = 0

			if var_204_10 < arg_201_1.time_ and arg_201_1.time_ <= var_204_10 + arg_204_0 and not isNil(var_204_9) and arg_201_1.var_.characterEffect10058ui_story == nil then
				arg_201_1.var_.characterEffect10058ui_story = var_204_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_11 = 0.200000002980232

			if var_204_10 <= arg_201_1.time_ and arg_201_1.time_ < var_204_10 + var_204_11 and not isNil(var_204_9) then
				local var_204_12 = (arg_201_1.time_ - var_204_10) / var_204_11

				if arg_201_1.var_.characterEffect10058ui_story and not isNil(var_204_9) then
					arg_201_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_201_1.time_ >= var_204_10 + var_204_11 and arg_201_1.time_ < var_204_10 + var_204_11 + arg_204_0 and not isNil(var_204_9) and arg_201_1.var_.characterEffect10058ui_story then
				arg_201_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_204_13 = 0

			if var_204_13 < arg_201_1.time_ and arg_201_1.time_ <= var_204_13 + arg_204_0 then
				arg_201_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_204_14 = 0

			if var_204_14 < arg_201_1.time_ and arg_201_1.time_ <= var_204_14 + arg_204_0 then
				arg_201_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_204_15 = arg_201_1.actors_["10066ui_story"].transform
			local var_204_16 = 0

			if var_204_16 < arg_201_1.time_ and arg_201_1.time_ <= var_204_16 + arg_204_0 then
				arg_201_1.var_.moveOldPos10066ui_story = var_204_15.localPosition
			end

			local var_204_17 = 0.001

			if var_204_16 <= arg_201_1.time_ and arg_201_1.time_ < var_204_16 + var_204_17 then
				local var_204_18 = (arg_201_1.time_ - var_204_16) / var_204_17
				local var_204_19 = Vector3.New(0.7, -0.99, -5.83)

				var_204_15.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos10066ui_story, var_204_19, var_204_18)

				local var_204_20 = manager.ui.mainCamera.transform.position - var_204_15.position

				var_204_15.forward = Vector3.New(var_204_20.x, var_204_20.y, var_204_20.z)

				local var_204_21 = var_204_15.localEulerAngles

				var_204_21.z = 0
				var_204_21.x = 0
				var_204_15.localEulerAngles = var_204_21
			end

			if arg_201_1.time_ >= var_204_16 + var_204_17 and arg_201_1.time_ < var_204_16 + var_204_17 + arg_204_0 then
				var_204_15.localPosition = Vector3.New(0.7, -0.99, -5.83)

				local var_204_22 = manager.ui.mainCamera.transform.position - var_204_15.position

				var_204_15.forward = Vector3.New(var_204_22.x, var_204_22.y, var_204_22.z)

				local var_204_23 = var_204_15.localEulerAngles

				var_204_23.z = 0
				var_204_23.x = 0
				var_204_15.localEulerAngles = var_204_23
			end

			local var_204_24 = arg_201_1.actors_["10066ui_story"]
			local var_204_25 = 0

			if var_204_25 < arg_201_1.time_ and arg_201_1.time_ <= var_204_25 + arg_204_0 and not isNil(var_204_24) and arg_201_1.var_.characterEffect10066ui_story == nil then
				arg_201_1.var_.characterEffect10066ui_story = var_204_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_26 = 0.200000002980232

			if var_204_25 <= arg_201_1.time_ and arg_201_1.time_ < var_204_25 + var_204_26 and not isNil(var_204_24) then
				local var_204_27 = (arg_201_1.time_ - var_204_25) / var_204_26

				if arg_201_1.var_.characterEffect10066ui_story and not isNil(var_204_24) then
					local var_204_28 = Mathf.Lerp(0, 0.5, var_204_27)

					arg_201_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_201_1.var_.characterEffect10066ui_story.fillRatio = var_204_28
				end
			end

			if arg_201_1.time_ >= var_204_25 + var_204_26 and arg_201_1.time_ < var_204_25 + var_204_26 + arg_204_0 and not isNil(var_204_24) and arg_201_1.var_.characterEffect10066ui_story then
				local var_204_29 = 0.5

				arg_201_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_201_1.var_.characterEffect10066ui_story.fillRatio = var_204_29
			end

			local var_204_30 = 0
			local var_204_31 = 0.75

			if var_204_30 < arg_201_1.time_ and arg_201_1.time_ <= var_204_30 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_32 = arg_201_1:FormatText(StoryNameCfg[471].name)

				arg_201_1.leftNameTxt_.text = var_204_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_33 = arg_201_1:GetWordFromCfg(319651049)
				local var_204_34 = arg_201_1:FormatText(var_204_33.content)

				arg_201_1.text_.text = var_204_34

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_35 = 30
				local var_204_36 = utf8.len(var_204_34)
				local var_204_37 = var_204_35 <= 0 and var_204_31 or var_204_31 * (var_204_36 / var_204_35)

				if var_204_37 > 0 and var_204_31 < var_204_37 then
					arg_201_1.talkMaxDuration = var_204_37

					if var_204_37 + var_204_30 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_37 + var_204_30
					end
				end

				arg_201_1.text_.text = var_204_34
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651049", "story_v_out_319651.awb") ~= 0 then
					local var_204_38 = manager.audio:GetVoiceLength("story_v_out_319651", "319651049", "story_v_out_319651.awb") / 1000

					if var_204_38 + var_204_30 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_38 + var_204_30
					end

					if var_204_33.prefab_name ~= "" and arg_201_1.actors_[var_204_33.prefab_name] ~= nil then
						local var_204_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_33.prefab_name].transform, "story_v_out_319651", "319651049", "story_v_out_319651.awb")

						arg_201_1:RecordAudio("319651049", var_204_39)
						arg_201_1:RecordAudio("319651049", var_204_39)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_319651", "319651049", "story_v_out_319651.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_319651", "319651049", "story_v_out_319651.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_40 = math.max(var_204_31, arg_201_1.talkMaxDuration)

			if var_204_30 <= arg_201_1.time_ and arg_201_1.time_ < var_204_30 + var_204_40 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_30) / var_204_40

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_30 + var_204_40 and arg_201_1.time_ < var_204_30 + var_204_40 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_201_1:InitPlayNodeList()
	end,
	Play319651050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 319651050
		arg_205_1.duration_ = 13

		local var_205_0 = {
			zh = 6.666,
			ja = 13
		}
		local var_205_1 = manager.audio:GetLocalizationFlag()

		if var_205_0[var_205_1] ~= nil then
			arg_205_1.duration_ = var_205_0[var_205_1]
		end

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play319651051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0
			local var_208_1 = 0.775

			if var_208_0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_2 = arg_205_1:FormatText(StoryNameCfg[471].name)

				arg_205_1.leftNameTxt_.text = var_208_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_3 = arg_205_1:GetWordFromCfg(319651050)
				local var_208_4 = arg_205_1:FormatText(var_208_3.content)

				arg_205_1.text_.text = var_208_4

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_5 = 31
				local var_208_6 = utf8.len(var_208_4)
				local var_208_7 = var_208_5 <= 0 and var_208_1 or var_208_1 * (var_208_6 / var_208_5)

				if var_208_7 > 0 and var_208_1 < var_208_7 then
					arg_205_1.talkMaxDuration = var_208_7

					if var_208_7 + var_208_0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_7 + var_208_0
					end
				end

				arg_205_1.text_.text = var_208_4
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651050", "story_v_out_319651.awb") ~= 0 then
					local var_208_8 = manager.audio:GetVoiceLength("story_v_out_319651", "319651050", "story_v_out_319651.awb") / 1000

					if var_208_8 + var_208_0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_8 + var_208_0
					end

					if var_208_3.prefab_name ~= "" and arg_205_1.actors_[var_208_3.prefab_name] ~= nil then
						local var_208_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_3.prefab_name].transform, "story_v_out_319651", "319651050", "story_v_out_319651.awb")

						arg_205_1:RecordAudio("319651050", var_208_9)
						arg_205_1:RecordAudio("319651050", var_208_9)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_319651", "319651050", "story_v_out_319651.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_319651", "319651050", "story_v_out_319651.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_10 = math.max(var_208_1, arg_205_1.talkMaxDuration)

			if var_208_0 <= arg_205_1.time_ and arg_205_1.time_ < var_208_0 + var_208_10 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_0) / var_208_10

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_0 + var_208_10 and arg_205_1.time_ < var_208_0 + var_208_10 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play319651051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 319651051
		arg_209_1.duration_ = 10.07

		local var_209_0 = {
			zh = 5.466,
			ja = 10.066
		}
		local var_209_1 = manager.audio:GetLocalizationFlag()

		if var_209_0[var_209_1] ~= nil then
			arg_209_1.duration_ = var_209_0[var_209_1]
		end

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play319651052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 0
			local var_212_1 = 0.7

			if var_212_0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_0 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_2 = arg_209_1:FormatText(StoryNameCfg[471].name)

				arg_209_1.leftNameTxt_.text = var_212_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_3 = arg_209_1:GetWordFromCfg(319651051)
				local var_212_4 = arg_209_1:FormatText(var_212_3.content)

				arg_209_1.text_.text = var_212_4

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_5 = 28
				local var_212_6 = utf8.len(var_212_4)
				local var_212_7 = var_212_5 <= 0 and var_212_1 or var_212_1 * (var_212_6 / var_212_5)

				if var_212_7 > 0 and var_212_1 < var_212_7 then
					arg_209_1.talkMaxDuration = var_212_7

					if var_212_7 + var_212_0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_7 + var_212_0
					end
				end

				arg_209_1.text_.text = var_212_4
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651051", "story_v_out_319651.awb") ~= 0 then
					local var_212_8 = manager.audio:GetVoiceLength("story_v_out_319651", "319651051", "story_v_out_319651.awb") / 1000

					if var_212_8 + var_212_0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_8 + var_212_0
					end

					if var_212_3.prefab_name ~= "" and arg_209_1.actors_[var_212_3.prefab_name] ~= nil then
						local var_212_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_3.prefab_name].transform, "story_v_out_319651", "319651051", "story_v_out_319651.awb")

						arg_209_1:RecordAudio("319651051", var_212_9)
						arg_209_1:RecordAudio("319651051", var_212_9)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_319651", "319651051", "story_v_out_319651.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_319651", "319651051", "story_v_out_319651.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_10 = math.max(var_212_1, arg_209_1.talkMaxDuration)

			if var_212_0 <= arg_209_1.time_ and arg_209_1.time_ < var_212_0 + var_212_10 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_0) / var_212_10

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_0 + var_212_10 and arg_209_1.time_ < var_212_0 + var_212_10 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play319651052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 319651052
		arg_213_1.duration_ = 5.47

		local var_213_0 = {
			zh = 3.533,
			ja = 5.466
		}
		local var_213_1 = manager.audio:GetLocalizationFlag()

		if var_213_0[var_213_1] ~= nil then
			arg_213_1.duration_ = var_213_0[var_213_1]
		end

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play319651053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0

			if var_216_0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_0 + arg_216_0 then
				arg_213_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action7_2")
			end

			local var_216_1 = 0

			if var_216_1 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 then
				arg_213_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_216_2 = arg_213_1.actors_["10066ui_story"]
			local var_216_3 = 0

			if var_216_3 < arg_213_1.time_ and arg_213_1.time_ <= var_216_3 + arg_216_0 and not isNil(var_216_2) and arg_213_1.var_.characterEffect10066ui_story == nil then
				arg_213_1.var_.characterEffect10066ui_story = var_216_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_4 = 0.200000002980232

			if var_216_3 <= arg_213_1.time_ and arg_213_1.time_ < var_216_3 + var_216_4 and not isNil(var_216_2) then
				local var_216_5 = (arg_213_1.time_ - var_216_3) / var_216_4

				if arg_213_1.var_.characterEffect10066ui_story and not isNil(var_216_2) then
					arg_213_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= var_216_3 + var_216_4 and arg_213_1.time_ < var_216_3 + var_216_4 + arg_216_0 and not isNil(var_216_2) and arg_213_1.var_.characterEffect10066ui_story then
				arg_213_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_216_6 = arg_213_1.actors_["10058ui_story"]
			local var_216_7 = 0

			if var_216_7 < arg_213_1.time_ and arg_213_1.time_ <= var_216_7 + arg_216_0 and not isNil(var_216_6) and arg_213_1.var_.characterEffect10058ui_story == nil then
				arg_213_1.var_.characterEffect10058ui_story = var_216_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_8 = 0.200000002980232

			if var_216_7 <= arg_213_1.time_ and arg_213_1.time_ < var_216_7 + var_216_8 and not isNil(var_216_6) then
				local var_216_9 = (arg_213_1.time_ - var_216_7) / var_216_8

				if arg_213_1.var_.characterEffect10058ui_story and not isNil(var_216_6) then
					local var_216_10 = Mathf.Lerp(0, 0.5, var_216_9)

					arg_213_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_213_1.var_.characterEffect10058ui_story.fillRatio = var_216_10
				end
			end

			if arg_213_1.time_ >= var_216_7 + var_216_8 and arg_213_1.time_ < var_216_7 + var_216_8 + arg_216_0 and not isNil(var_216_6) and arg_213_1.var_.characterEffect10058ui_story then
				local var_216_11 = 0.5

				arg_213_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_213_1.var_.characterEffect10058ui_story.fillRatio = var_216_11
			end

			local var_216_12 = 0
			local var_216_13 = 0.3

			if var_216_12 < arg_213_1.time_ and arg_213_1.time_ <= var_216_12 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_14 = arg_213_1:FormatText(StoryNameCfg[640].name)

				arg_213_1.leftNameTxt_.text = var_216_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_15 = arg_213_1:GetWordFromCfg(319651052)
				local var_216_16 = arg_213_1:FormatText(var_216_15.content)

				arg_213_1.text_.text = var_216_16

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_17 = 12
				local var_216_18 = utf8.len(var_216_16)
				local var_216_19 = var_216_17 <= 0 and var_216_13 or var_216_13 * (var_216_18 / var_216_17)

				if var_216_19 > 0 and var_216_13 < var_216_19 then
					arg_213_1.talkMaxDuration = var_216_19

					if var_216_19 + var_216_12 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_19 + var_216_12
					end
				end

				arg_213_1.text_.text = var_216_16
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651052", "story_v_out_319651.awb") ~= 0 then
					local var_216_20 = manager.audio:GetVoiceLength("story_v_out_319651", "319651052", "story_v_out_319651.awb") / 1000

					if var_216_20 + var_216_12 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_20 + var_216_12
					end

					if var_216_15.prefab_name ~= "" and arg_213_1.actors_[var_216_15.prefab_name] ~= nil then
						local var_216_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_15.prefab_name].transform, "story_v_out_319651", "319651052", "story_v_out_319651.awb")

						arg_213_1:RecordAudio("319651052", var_216_21)
						arg_213_1:RecordAudio("319651052", var_216_21)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_319651", "319651052", "story_v_out_319651.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_319651", "319651052", "story_v_out_319651.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_22 = math.max(var_216_13, arg_213_1.talkMaxDuration)

			if var_216_12 <= arg_213_1.time_ and arg_213_1.time_ < var_216_12 + var_216_22 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_12) / var_216_22

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_12 + var_216_22 and arg_213_1.time_ < var_216_12 + var_216_22 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play319651053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 319651053
		arg_217_1.duration_ = 7.6

		local var_217_0 = {
			zh = 2.433,
			ja = 7.6
		}
		local var_217_1 = manager.audio:GetLocalizationFlag()

		if var_217_0[var_217_1] ~= nil then
			arg_217_1.duration_ = var_217_0[var_217_1]
		end

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play319651054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0

			if var_220_0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_0 + arg_220_0 then
				arg_217_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_1")
			end

			local var_220_1 = 0

			if var_220_1 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 then
				arg_217_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_220_2 = arg_217_1.actors_["10058ui_story"]
			local var_220_3 = 0

			if var_220_3 < arg_217_1.time_ and arg_217_1.time_ <= var_220_3 + arg_220_0 and not isNil(var_220_2) and arg_217_1.var_.characterEffect10058ui_story == nil then
				arg_217_1.var_.characterEffect10058ui_story = var_220_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_4 = 0.200000002980232

			if var_220_3 <= arg_217_1.time_ and arg_217_1.time_ < var_220_3 + var_220_4 and not isNil(var_220_2) then
				local var_220_5 = (arg_217_1.time_ - var_220_3) / var_220_4

				if arg_217_1.var_.characterEffect10058ui_story and not isNil(var_220_2) then
					arg_217_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_217_1.time_ >= var_220_3 + var_220_4 and arg_217_1.time_ < var_220_3 + var_220_4 + arg_220_0 and not isNil(var_220_2) and arg_217_1.var_.characterEffect10058ui_story then
				arg_217_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_220_6 = arg_217_1.actors_["10066ui_story"]
			local var_220_7 = 0

			if var_220_7 < arg_217_1.time_ and arg_217_1.time_ <= var_220_7 + arg_220_0 and not isNil(var_220_6) and arg_217_1.var_.characterEffect10066ui_story == nil then
				arg_217_1.var_.characterEffect10066ui_story = var_220_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_8 = 0.200000002980232

			if var_220_7 <= arg_217_1.time_ and arg_217_1.time_ < var_220_7 + var_220_8 and not isNil(var_220_6) then
				local var_220_9 = (arg_217_1.time_ - var_220_7) / var_220_8

				if arg_217_1.var_.characterEffect10066ui_story and not isNil(var_220_6) then
					local var_220_10 = Mathf.Lerp(0, 0.5, var_220_9)

					arg_217_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_217_1.var_.characterEffect10066ui_story.fillRatio = var_220_10
				end
			end

			if arg_217_1.time_ >= var_220_7 + var_220_8 and arg_217_1.time_ < var_220_7 + var_220_8 + arg_220_0 and not isNil(var_220_6) and arg_217_1.var_.characterEffect10066ui_story then
				local var_220_11 = 0.5

				arg_217_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_217_1.var_.characterEffect10066ui_story.fillRatio = var_220_11
			end

			local var_220_12 = 0
			local var_220_13 = 0.275

			if var_220_12 < arg_217_1.time_ and arg_217_1.time_ <= var_220_12 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_14 = arg_217_1:FormatText(StoryNameCfg[471].name)

				arg_217_1.leftNameTxt_.text = var_220_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_15 = arg_217_1:GetWordFromCfg(319651053)
				local var_220_16 = arg_217_1:FormatText(var_220_15.content)

				arg_217_1.text_.text = var_220_16

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_17 = 11
				local var_220_18 = utf8.len(var_220_16)
				local var_220_19 = var_220_17 <= 0 and var_220_13 or var_220_13 * (var_220_18 / var_220_17)

				if var_220_19 > 0 and var_220_13 < var_220_19 then
					arg_217_1.talkMaxDuration = var_220_19

					if var_220_19 + var_220_12 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_19 + var_220_12
					end
				end

				arg_217_1.text_.text = var_220_16
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651053", "story_v_out_319651.awb") ~= 0 then
					local var_220_20 = manager.audio:GetVoiceLength("story_v_out_319651", "319651053", "story_v_out_319651.awb") / 1000

					if var_220_20 + var_220_12 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_20 + var_220_12
					end

					if var_220_15.prefab_name ~= "" and arg_217_1.actors_[var_220_15.prefab_name] ~= nil then
						local var_220_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_15.prefab_name].transform, "story_v_out_319651", "319651053", "story_v_out_319651.awb")

						arg_217_1:RecordAudio("319651053", var_220_21)
						arg_217_1:RecordAudio("319651053", var_220_21)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_319651", "319651053", "story_v_out_319651.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_319651", "319651053", "story_v_out_319651.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_22 = math.max(var_220_13, arg_217_1.talkMaxDuration)

			if var_220_12 <= arg_217_1.time_ and arg_217_1.time_ < var_220_12 + var_220_22 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_12) / var_220_22

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_12 + var_220_22 and arg_217_1.time_ < var_220_12 + var_220_22 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play319651054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 319651054
		arg_221_1.duration_ = 3.63

		local var_221_0 = {
			zh = 2.933,
			ja = 3.633
		}
		local var_221_1 = manager.audio:GetLocalizationFlag()

		if var_221_0[var_221_1] ~= nil then
			arg_221_1.duration_ = var_221_0[var_221_1]
		end

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play319651055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["10066ui_story"].transform
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 then
				arg_221_1.var_.moveOldPos10066ui_story = var_224_0.localPosition
			end

			local var_224_2 = 0.001

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_2 then
				local var_224_3 = (arg_221_1.time_ - var_224_1) / var_224_2
				local var_224_4 = Vector3.New(0.7, -0.99, -5.83)

				var_224_0.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos10066ui_story, var_224_4, var_224_3)

				local var_224_5 = manager.ui.mainCamera.transform.position - var_224_0.position

				var_224_0.forward = Vector3.New(var_224_5.x, var_224_5.y, var_224_5.z)

				local var_224_6 = var_224_0.localEulerAngles

				var_224_6.z = 0
				var_224_6.x = 0
				var_224_0.localEulerAngles = var_224_6
			end

			if arg_221_1.time_ >= var_224_1 + var_224_2 and arg_221_1.time_ < var_224_1 + var_224_2 + arg_224_0 then
				var_224_0.localPosition = Vector3.New(0.7, -0.99, -5.83)

				local var_224_7 = manager.ui.mainCamera.transform.position - var_224_0.position

				var_224_0.forward = Vector3.New(var_224_7.x, var_224_7.y, var_224_7.z)

				local var_224_8 = var_224_0.localEulerAngles

				var_224_8.z = 0
				var_224_8.x = 0
				var_224_0.localEulerAngles = var_224_8
			end

			local var_224_9 = arg_221_1.actors_["10066ui_story"]
			local var_224_10 = 0

			if var_224_10 < arg_221_1.time_ and arg_221_1.time_ <= var_224_10 + arg_224_0 and not isNil(var_224_9) and arg_221_1.var_.characterEffect10066ui_story == nil then
				arg_221_1.var_.characterEffect10066ui_story = var_224_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_11 = 0.200000002980232

			if var_224_10 <= arg_221_1.time_ and arg_221_1.time_ < var_224_10 + var_224_11 and not isNil(var_224_9) then
				local var_224_12 = (arg_221_1.time_ - var_224_10) / var_224_11

				if arg_221_1.var_.characterEffect10066ui_story and not isNil(var_224_9) then
					arg_221_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= var_224_10 + var_224_11 and arg_221_1.time_ < var_224_10 + var_224_11 + arg_224_0 and not isNil(var_224_9) and arg_221_1.var_.characterEffect10066ui_story then
				arg_221_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_224_13 = 0

			if var_224_13 < arg_221_1.time_ and arg_221_1.time_ <= var_224_13 + arg_224_0 then
				arg_221_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action3_1")
			end

			local var_224_14 = 0

			if var_224_14 < arg_221_1.time_ and arg_221_1.time_ <= var_224_14 + arg_224_0 then
				arg_221_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_224_15 = arg_221_1.actors_["10058ui_story"]
			local var_224_16 = 0

			if var_224_16 < arg_221_1.time_ and arg_221_1.time_ <= var_224_16 + arg_224_0 and not isNil(var_224_15) and arg_221_1.var_.characterEffect10058ui_story == nil then
				arg_221_1.var_.characterEffect10058ui_story = var_224_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_17 = 0.200000002980232

			if var_224_16 <= arg_221_1.time_ and arg_221_1.time_ < var_224_16 + var_224_17 and not isNil(var_224_15) then
				local var_224_18 = (arg_221_1.time_ - var_224_16) / var_224_17

				if arg_221_1.var_.characterEffect10058ui_story and not isNil(var_224_15) then
					local var_224_19 = Mathf.Lerp(0, 0.5, var_224_18)

					arg_221_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_221_1.var_.characterEffect10058ui_story.fillRatio = var_224_19
				end
			end

			if arg_221_1.time_ >= var_224_16 + var_224_17 and arg_221_1.time_ < var_224_16 + var_224_17 + arg_224_0 and not isNil(var_224_15) and arg_221_1.var_.characterEffect10058ui_story then
				local var_224_20 = 0.5

				arg_221_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_221_1.var_.characterEffect10058ui_story.fillRatio = var_224_20
			end

			local var_224_21 = 0
			local var_224_22 = 0.25

			if var_224_21 < arg_221_1.time_ and arg_221_1.time_ <= var_224_21 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_23 = arg_221_1:FormatText(StoryNameCfg[640].name)

				arg_221_1.leftNameTxt_.text = var_224_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_24 = arg_221_1:GetWordFromCfg(319651054)
				local var_224_25 = arg_221_1:FormatText(var_224_24.content)

				arg_221_1.text_.text = var_224_25

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_26 = 10
				local var_224_27 = utf8.len(var_224_25)
				local var_224_28 = var_224_26 <= 0 and var_224_22 or var_224_22 * (var_224_27 / var_224_26)

				if var_224_28 > 0 and var_224_22 < var_224_28 then
					arg_221_1.talkMaxDuration = var_224_28

					if var_224_28 + var_224_21 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_28 + var_224_21
					end
				end

				arg_221_1.text_.text = var_224_25
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651054", "story_v_out_319651.awb") ~= 0 then
					local var_224_29 = manager.audio:GetVoiceLength("story_v_out_319651", "319651054", "story_v_out_319651.awb") / 1000

					if var_224_29 + var_224_21 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_29 + var_224_21
					end

					if var_224_24.prefab_name ~= "" and arg_221_1.actors_[var_224_24.prefab_name] ~= nil then
						local var_224_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_24.prefab_name].transform, "story_v_out_319651", "319651054", "story_v_out_319651.awb")

						arg_221_1:RecordAudio("319651054", var_224_30)
						arg_221_1:RecordAudio("319651054", var_224_30)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_319651", "319651054", "story_v_out_319651.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_319651", "319651054", "story_v_out_319651.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_31 = math.max(var_224_22, arg_221_1.talkMaxDuration)

			if var_224_21 <= arg_221_1.time_ and arg_221_1.time_ < var_224_21 + var_224_31 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_21) / var_224_31

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_21 + var_224_31 and arg_221_1.time_ < var_224_21 + var_224_31 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_221_1:InitPlayNodeList()
	end,
	Play319651055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 319651055
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play319651056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = arg_225_1.actors_["10058ui_story"].transform
			local var_228_1 = 0

			if var_228_1 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 then
				arg_225_1.var_.moveOldPos10058ui_story = var_228_0.localPosition
			end

			local var_228_2 = 0.001

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_2 then
				local var_228_3 = (arg_225_1.time_ - var_228_1) / var_228_2
				local var_228_4 = Vector3.New(0, 100, 0)

				var_228_0.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos10058ui_story, var_228_4, var_228_3)

				local var_228_5 = manager.ui.mainCamera.transform.position - var_228_0.position

				var_228_0.forward = Vector3.New(var_228_5.x, var_228_5.y, var_228_5.z)

				local var_228_6 = var_228_0.localEulerAngles

				var_228_6.z = 0
				var_228_6.x = 0
				var_228_0.localEulerAngles = var_228_6
			end

			if arg_225_1.time_ >= var_228_1 + var_228_2 and arg_225_1.time_ < var_228_1 + var_228_2 + arg_228_0 then
				var_228_0.localPosition = Vector3.New(0, 100, 0)

				local var_228_7 = manager.ui.mainCamera.transform.position - var_228_0.position

				var_228_0.forward = Vector3.New(var_228_7.x, var_228_7.y, var_228_7.z)

				local var_228_8 = var_228_0.localEulerAngles

				var_228_8.z = 0
				var_228_8.x = 0
				var_228_0.localEulerAngles = var_228_8
			end

			local var_228_9 = arg_225_1.actors_["10058ui_story"]
			local var_228_10 = 0

			if var_228_10 < arg_225_1.time_ and arg_225_1.time_ <= var_228_10 + arg_228_0 and not isNil(var_228_9) and arg_225_1.var_.characterEffect10058ui_story == nil then
				arg_225_1.var_.characterEffect10058ui_story = var_228_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_11 = 0.200000002980232

			if var_228_10 <= arg_225_1.time_ and arg_225_1.time_ < var_228_10 + var_228_11 and not isNil(var_228_9) then
				local var_228_12 = (arg_225_1.time_ - var_228_10) / var_228_11

				if arg_225_1.var_.characterEffect10058ui_story and not isNil(var_228_9) then
					local var_228_13 = Mathf.Lerp(0, 0.5, var_228_12)

					arg_225_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_225_1.var_.characterEffect10058ui_story.fillRatio = var_228_13
				end
			end

			if arg_225_1.time_ >= var_228_10 + var_228_11 and arg_225_1.time_ < var_228_10 + var_228_11 + arg_228_0 and not isNil(var_228_9) and arg_225_1.var_.characterEffect10058ui_story then
				local var_228_14 = 0.5

				arg_225_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_225_1.var_.characterEffect10058ui_story.fillRatio = var_228_14
			end

			local var_228_15 = arg_225_1.actors_["10066ui_story"].transform
			local var_228_16 = 0

			if var_228_16 < arg_225_1.time_ and arg_225_1.time_ <= var_228_16 + arg_228_0 then
				arg_225_1.var_.moveOldPos10066ui_story = var_228_15.localPosition
			end

			local var_228_17 = 0.001

			if var_228_16 <= arg_225_1.time_ and arg_225_1.time_ < var_228_16 + var_228_17 then
				local var_228_18 = (arg_225_1.time_ - var_228_16) / var_228_17
				local var_228_19 = Vector3.New(0, 100, 0)

				var_228_15.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos10066ui_story, var_228_19, var_228_18)

				local var_228_20 = manager.ui.mainCamera.transform.position - var_228_15.position

				var_228_15.forward = Vector3.New(var_228_20.x, var_228_20.y, var_228_20.z)

				local var_228_21 = var_228_15.localEulerAngles

				var_228_21.z = 0
				var_228_21.x = 0
				var_228_15.localEulerAngles = var_228_21
			end

			if arg_225_1.time_ >= var_228_16 + var_228_17 and arg_225_1.time_ < var_228_16 + var_228_17 + arg_228_0 then
				var_228_15.localPosition = Vector3.New(0, 100, 0)

				local var_228_22 = manager.ui.mainCamera.transform.position - var_228_15.position

				var_228_15.forward = Vector3.New(var_228_22.x, var_228_22.y, var_228_22.z)

				local var_228_23 = var_228_15.localEulerAngles

				var_228_23.z = 0
				var_228_23.x = 0
				var_228_15.localEulerAngles = var_228_23
			end

			local var_228_24 = arg_225_1.actors_["10066ui_story"]
			local var_228_25 = 0

			if var_228_25 < arg_225_1.time_ and arg_225_1.time_ <= var_228_25 + arg_228_0 and not isNil(var_228_24) and arg_225_1.var_.characterEffect10066ui_story == nil then
				arg_225_1.var_.characterEffect10066ui_story = var_228_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_26 = 0.200000002980232

			if var_228_25 <= arg_225_1.time_ and arg_225_1.time_ < var_228_25 + var_228_26 and not isNil(var_228_24) then
				local var_228_27 = (arg_225_1.time_ - var_228_25) / var_228_26

				if arg_225_1.var_.characterEffect10066ui_story and not isNil(var_228_24) then
					local var_228_28 = Mathf.Lerp(0, 0.5, var_228_27)

					arg_225_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_225_1.var_.characterEffect10066ui_story.fillRatio = var_228_28
				end
			end

			if arg_225_1.time_ >= var_228_25 + var_228_26 and arg_225_1.time_ < var_228_25 + var_228_26 + arg_228_0 and not isNil(var_228_24) and arg_225_1.var_.characterEffect10066ui_story then
				local var_228_29 = 0.5

				arg_225_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_225_1.var_.characterEffect10066ui_story.fillRatio = var_228_29
			end

			local var_228_30 = 0
			local var_228_31 = 0.7

			if var_228_30 < arg_225_1.time_ and arg_225_1.time_ <= var_228_30 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, false)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_32 = arg_225_1:GetWordFromCfg(319651055)
				local var_228_33 = arg_225_1:FormatText(var_228_32.content)

				arg_225_1.text_.text = var_228_33

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_34 = 28
				local var_228_35 = utf8.len(var_228_33)
				local var_228_36 = var_228_34 <= 0 and var_228_31 or var_228_31 * (var_228_35 / var_228_34)

				if var_228_36 > 0 and var_228_31 < var_228_36 then
					arg_225_1.talkMaxDuration = var_228_36

					if var_228_36 + var_228_30 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_36 + var_228_30
					end
				end

				arg_225_1.text_.text = var_228_33
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_37 = math.max(var_228_31, arg_225_1.talkMaxDuration)

			if var_228_30 <= arg_225_1.time_ and arg_225_1.time_ < var_228_30 + var_228_37 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_30) / var_228_37

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_30 + var_228_37 and arg_225_1.time_ < var_228_30 + var_228_37 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_225_1:InitPlayNodeList()
	end,
	Play319651056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 319651056
		arg_229_1.duration_ = 5.63

		local var_229_0 = {
			zh = 3.7,
			ja = 5.633
		}
		local var_229_1 = manager.audio:GetLocalizationFlag()

		if var_229_0[var_229_1] ~= nil then
			arg_229_1.duration_ = var_229_0[var_229_1]
		end

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play319651057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = arg_229_1.actors_["10066ui_story"].transform
			local var_232_1 = 0

			if var_232_1 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 then
				arg_229_1.var_.moveOldPos10066ui_story = var_232_0.localPosition
			end

			local var_232_2 = 0.001

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_2 then
				local var_232_3 = (arg_229_1.time_ - var_232_1) / var_232_2
				local var_232_4 = Vector3.New(0, -0.99, -5.83)

				var_232_0.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos10066ui_story, var_232_4, var_232_3)

				local var_232_5 = manager.ui.mainCamera.transform.position - var_232_0.position

				var_232_0.forward = Vector3.New(var_232_5.x, var_232_5.y, var_232_5.z)

				local var_232_6 = var_232_0.localEulerAngles

				var_232_6.z = 0
				var_232_6.x = 0
				var_232_0.localEulerAngles = var_232_6
			end

			if arg_229_1.time_ >= var_232_1 + var_232_2 and arg_229_1.time_ < var_232_1 + var_232_2 + arg_232_0 then
				var_232_0.localPosition = Vector3.New(0, -0.99, -5.83)

				local var_232_7 = manager.ui.mainCamera.transform.position - var_232_0.position

				var_232_0.forward = Vector3.New(var_232_7.x, var_232_7.y, var_232_7.z)

				local var_232_8 = var_232_0.localEulerAngles

				var_232_8.z = 0
				var_232_8.x = 0
				var_232_0.localEulerAngles = var_232_8
			end

			local var_232_9 = arg_229_1.actors_["10066ui_story"]
			local var_232_10 = 0

			if var_232_10 < arg_229_1.time_ and arg_229_1.time_ <= var_232_10 + arg_232_0 and not isNil(var_232_9) and arg_229_1.var_.characterEffect10066ui_story == nil then
				arg_229_1.var_.characterEffect10066ui_story = var_232_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_11 = 0.200000002980232

			if var_232_10 <= arg_229_1.time_ and arg_229_1.time_ < var_232_10 + var_232_11 and not isNil(var_232_9) then
				local var_232_12 = (arg_229_1.time_ - var_232_10) / var_232_11

				if arg_229_1.var_.characterEffect10066ui_story and not isNil(var_232_9) then
					arg_229_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= var_232_10 + var_232_11 and arg_229_1.time_ < var_232_10 + var_232_11 + arg_232_0 and not isNil(var_232_9) and arg_229_1.var_.characterEffect10066ui_story then
				arg_229_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_232_13 = 0

			if var_232_13 < arg_229_1.time_ and arg_229_1.time_ <= var_232_13 + arg_232_0 then
				arg_229_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_232_14 = 0

			if var_232_14 < arg_229_1.time_ and arg_229_1.time_ <= var_232_14 + arg_232_0 then
				arg_229_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action3_2")
			end

			local var_232_15 = 0
			local var_232_16 = 0.45

			if var_232_15 < arg_229_1.time_ and arg_229_1.time_ <= var_232_15 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_17 = arg_229_1:FormatText(StoryNameCfg[640].name)

				arg_229_1.leftNameTxt_.text = var_232_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_18 = arg_229_1:GetWordFromCfg(319651056)
				local var_232_19 = arg_229_1:FormatText(var_232_18.content)

				arg_229_1.text_.text = var_232_19

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_20 = 18
				local var_232_21 = utf8.len(var_232_19)
				local var_232_22 = var_232_20 <= 0 and var_232_16 or var_232_16 * (var_232_21 / var_232_20)

				if var_232_22 > 0 and var_232_16 < var_232_22 then
					arg_229_1.talkMaxDuration = var_232_22

					if var_232_22 + var_232_15 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_22 + var_232_15
					end
				end

				arg_229_1.text_.text = var_232_19
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651056", "story_v_out_319651.awb") ~= 0 then
					local var_232_23 = manager.audio:GetVoiceLength("story_v_out_319651", "319651056", "story_v_out_319651.awb") / 1000

					if var_232_23 + var_232_15 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_23 + var_232_15
					end

					if var_232_18.prefab_name ~= "" and arg_229_1.actors_[var_232_18.prefab_name] ~= nil then
						local var_232_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_18.prefab_name].transform, "story_v_out_319651", "319651056", "story_v_out_319651.awb")

						arg_229_1:RecordAudio("319651056", var_232_24)
						arg_229_1:RecordAudio("319651056", var_232_24)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_319651", "319651056", "story_v_out_319651.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_319651", "319651056", "story_v_out_319651.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_25 = math.max(var_232_16, arg_229_1.talkMaxDuration)

			if var_232_15 <= arg_229_1.time_ and arg_229_1.time_ < var_232_15 + var_232_25 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_15) / var_232_25

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_15 + var_232_25 and arg_229_1.time_ < var_232_15 + var_232_25 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_229_1:InitPlayNodeList()
	end,
	Play319651057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 319651057
		arg_233_1.duration_ = 2.5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play319651058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = arg_233_1.actors_["1084ui_story"].transform
			local var_236_1 = 0

			if var_236_1 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 then
				arg_233_1.var_.moveOldPos1084ui_story = var_236_0.localPosition
			end

			local var_236_2 = 0.001

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_2 then
				local var_236_3 = (arg_233_1.time_ - var_236_1) / var_236_2
				local var_236_4 = Vector3.New(0, 100, 0)

				var_236_0.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1084ui_story, var_236_4, var_236_3)

				local var_236_5 = manager.ui.mainCamera.transform.position - var_236_0.position

				var_236_0.forward = Vector3.New(var_236_5.x, var_236_5.y, var_236_5.z)

				local var_236_6 = var_236_0.localEulerAngles

				var_236_6.z = 0
				var_236_6.x = 0
				var_236_0.localEulerAngles = var_236_6
			end

			if arg_233_1.time_ >= var_236_1 + var_236_2 and arg_233_1.time_ < var_236_1 + var_236_2 + arg_236_0 then
				var_236_0.localPosition = Vector3.New(0, 100, 0)

				local var_236_7 = manager.ui.mainCamera.transform.position - var_236_0.position

				var_236_0.forward = Vector3.New(var_236_7.x, var_236_7.y, var_236_7.z)

				local var_236_8 = var_236_0.localEulerAngles

				var_236_8.z = 0
				var_236_8.x = 0
				var_236_0.localEulerAngles = var_236_8
			end

			local var_236_9 = arg_233_1.actors_["10066ui_story"].transform
			local var_236_10 = 0

			if var_236_10 < arg_233_1.time_ and arg_233_1.time_ <= var_236_10 + arg_236_0 then
				arg_233_1.var_.moveOldPos10066ui_story = var_236_9.localPosition
			end

			local var_236_11 = 0.001

			if var_236_10 <= arg_233_1.time_ and arg_233_1.time_ < var_236_10 + var_236_11 then
				local var_236_12 = (arg_233_1.time_ - var_236_10) / var_236_11
				local var_236_13 = Vector3.New(0, 100, 0)

				var_236_9.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos10066ui_story, var_236_13, var_236_12)

				local var_236_14 = manager.ui.mainCamera.transform.position - var_236_9.position

				var_236_9.forward = Vector3.New(var_236_14.x, var_236_14.y, var_236_14.z)

				local var_236_15 = var_236_9.localEulerAngles

				var_236_15.z = 0
				var_236_15.x = 0
				var_236_9.localEulerAngles = var_236_15
			end

			if arg_233_1.time_ >= var_236_10 + var_236_11 and arg_233_1.time_ < var_236_10 + var_236_11 + arg_236_0 then
				var_236_9.localPosition = Vector3.New(0, 100, 0)

				local var_236_16 = manager.ui.mainCamera.transform.position - var_236_9.position

				var_236_9.forward = Vector3.New(var_236_16.x, var_236_16.y, var_236_16.z)

				local var_236_17 = var_236_9.localEulerAngles

				var_236_17.z = 0
				var_236_17.x = 0
				var_236_9.localEulerAngles = var_236_17
			end

			local var_236_18 = 0

			if var_236_18 < arg_233_1.time_ and arg_233_1.time_ <= var_236_18 + arg_236_0 then
				local var_236_19 = arg_233_1.fswbg_.transform:Find("textbox/adapt/content") or arg_233_1.fswbg_.transform:Find("textbox/content")
				local var_236_20 = arg_233_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_236_21 = var_236_19:GetComponent("Text")
				local var_236_22 = var_236_19:GetComponent("RectTransform")

				var_236_21.alignment = UnityEngine.TextAnchor.LowerCenter
				var_236_22.offsetMin = Vector2.New(0, 0)
				var_236_22.offsetMax = Vector2.New(0, 0)
			end

			local var_236_23 = 0

			if var_236_23 < arg_233_1.time_ and arg_233_1.time_ <= var_236_23 + arg_236_0 then
				arg_233_1.fswbg_:SetActive(true)
				arg_233_1.dialog_:SetActive(false)

				arg_233_1.fswtw_.percent = 0

				local var_236_24 = arg_233_1:GetWordFromCfg(319651057)
				local var_236_25 = arg_233_1:FormatText(var_236_24.content)

				arg_233_1.fswt_.text = var_236_25

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.fswt_)

				arg_233_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_233_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_233_1.fswtw_:SetDirty()

				arg_233_1.typewritterCharCountI18N = 0

				SetActive(arg_233_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_233_1:ShowNextGo(false)
			end

			local var_236_26 = 0.149999999998999

			if var_236_26 < arg_233_1.time_ and arg_233_1.time_ <= var_236_26 + arg_236_0 then
				arg_233_1.var_.oldValueTypewriter = arg_233_1.fswtw_.percent

				SetActive(arg_233_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_233_1:ShowNextGo(false)
			end

			local var_236_27 = 0
			local var_236_28 = 0
			local var_236_29 = arg_233_1:GetWordFromCfg(319651057)
			local var_236_30 = arg_233_1:FormatText(var_236_29.content)
			local var_236_31, var_236_32 = arg_233_1:GetPercentByPara(var_236_30, 1)

			if var_236_26 < arg_233_1.time_ and arg_233_1.time_ <= var_236_26 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0

				local var_236_33 = var_236_27 <= 0 and var_236_28 or var_236_28 * ((var_236_32 - arg_233_1.typewritterCharCountI18N) / var_236_27)

				if var_236_33 > 0 and var_236_28 < var_236_33 then
					arg_233_1.talkMaxDuration = var_236_33

					if var_236_33 + var_236_26 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_33 + var_236_26
					end
				end
			end

			local var_236_34 = 0
			local var_236_35 = math.max(var_236_34, arg_233_1.talkMaxDuration)

			if var_236_26 <= arg_233_1.time_ and arg_233_1.time_ < var_236_26 + var_236_35 then
				local var_236_36 = (arg_233_1.time_ - var_236_26) / var_236_35

				arg_233_1.fswtw_.percent = Mathf.Lerp(arg_233_1.var_.oldValueTypewriter, var_236_31, var_236_36)
				arg_233_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_233_1.fswtw_:SetDirty()
			end

			if arg_233_1.time_ >= var_236_26 + var_236_35 and arg_233_1.time_ < var_236_26 + var_236_35 + arg_236_0 then
				arg_233_1.fswtw_.percent = var_236_31

				arg_233_1.fswtw_:SetDirty()
				arg_233_1:ShowNextGo(true)

				arg_233_1.typewritterCharCountI18N = var_236_32
			end

			local var_236_37 = 0.366666666666667

			if var_236_37 < arg_233_1.time_ and arg_233_1.time_ <= var_236_37 + arg_236_0 then
				arg_233_1.var_.oldValueTypewriter = arg_233_1.fswtw_.percent

				SetActive(arg_233_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_233_1:ShowNextGo(false)
			end

			local var_236_38 = 8
			local var_236_39 = 0.533333333333333
			local var_236_40 = arg_233_1:GetWordFromCfg(319651057)
			local var_236_41 = arg_233_1:FormatText(var_236_40.content)
			local var_236_42, var_236_43 = arg_233_1:GetPercentByPara(var_236_41, 1)

			if var_236_37 < arg_233_1.time_ and arg_233_1.time_ <= var_236_37 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0

				local var_236_44 = var_236_38 <= 0 and var_236_39 or var_236_39 * ((var_236_43 - arg_233_1.typewritterCharCountI18N) / var_236_38)

				if var_236_44 > 0 and var_236_39 < var_236_44 then
					arg_233_1.talkMaxDuration = var_236_44

					if var_236_44 + var_236_37 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_44 + var_236_37
					end
				end
			end

			local var_236_45 = 0.533333333333333
			local var_236_46 = math.max(var_236_45, arg_233_1.talkMaxDuration)

			if var_236_37 <= arg_233_1.time_ and arg_233_1.time_ < var_236_37 + var_236_46 then
				local var_236_47 = (arg_233_1.time_ - var_236_37) / var_236_46

				arg_233_1.fswtw_.percent = Mathf.Lerp(arg_233_1.var_.oldValueTypewriter, var_236_42, var_236_47)
				arg_233_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_233_1.fswtw_:SetDirty()
			end

			if arg_233_1.time_ >= var_236_37 + var_236_46 and arg_233_1.time_ < var_236_37 + var_236_46 + arg_236_0 then
				arg_233_1.fswtw_.percent = var_236_42

				arg_233_1.fswtw_:SetDirty()
				arg_233_1:ShowNextGo(true)

				arg_233_1.typewritterCharCountI18N = var_236_43
			end

			local var_236_48 = "STblack"

			if arg_233_1.bgs_[var_236_48] == nil then
				local var_236_49 = Object.Instantiate(arg_233_1.paintGo_)

				var_236_49:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_236_48)
				var_236_49.name = var_236_48
				var_236_49.transform.parent = arg_233_1.stage_.transform
				var_236_49.transform.localPosition = Vector3.New(0, 100, 0)
				arg_233_1.bgs_[var_236_48] = var_236_49
			end

			local var_236_50 = 0

			if var_236_50 < arg_233_1.time_ and arg_233_1.time_ <= var_236_50 + arg_236_0 then
				local var_236_51 = manager.ui.mainCamera.transform.localPosition
				local var_236_52 = Vector3.New(0, 0, 10) + Vector3.New(var_236_51.x, var_236_51.y, 0)
				local var_236_53 = arg_233_1.bgs_.STblack

				var_236_53.transform.localPosition = var_236_52
				var_236_53.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_236_54 = var_236_53:GetComponent("SpriteRenderer")

				if var_236_54 and var_236_54.sprite then
					local var_236_55 = (var_236_53.transform.localPosition - var_236_51).z
					local var_236_56 = manager.ui.mainCameraCom_
					local var_236_57 = 2 * var_236_55 * Mathf.Tan(var_236_56.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_236_58 = var_236_57 * var_236_56.aspect
					local var_236_59 = var_236_54.sprite.bounds.size.x
					local var_236_60 = var_236_54.sprite.bounds.size.y
					local var_236_61 = var_236_58 / var_236_59
					local var_236_62 = var_236_57 / var_236_60
					local var_236_63 = var_236_62 < var_236_61 and var_236_61 or var_236_62

					var_236_53.transform.localScale = Vector3.New(var_236_63, var_236_63, 0)
				end

				for iter_236_0, iter_236_1 in pairs(arg_233_1.bgs_) do
					if iter_236_0 ~= "STblack" then
						iter_236_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_236_64 = 0.366666666666667
			local var_236_65 = 2.133
			local var_236_66 = manager.audio:GetVoiceLength("story_v_out_319651", "319651057", "story_v_out_319651.awb") / 1000

			if var_236_66 > 0 and var_236_65 < var_236_66 and var_236_66 + var_236_64 > arg_233_1.duration_ then
				local var_236_67 = var_236_66

				arg_233_1.duration_ = var_236_66 + var_236_64
			end

			if var_236_64 < arg_233_1.time_ and arg_233_1.time_ <= var_236_64 + arg_236_0 then
				local var_236_68 = "play"
				local var_236_69 = "voice"

				arg_233_1:AudioAction(var_236_68, var_236_69, "story_v_out_319651", "319651057", "story_v_out_319651.awb")
			end

			local var_236_70 = 0

			if var_236_70 < arg_233_1.time_ and arg_233_1.time_ <= var_236_70 + arg_236_0 then
				arg_233_1.cswbg_:SetActive(true)

				local var_236_71 = arg_233_1.cswt_:GetComponent("RectTransform")

				arg_233_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_236_71.offsetMin = Vector2.New(410, 330)
				var_236_71.offsetMax = Vector2.New(-400, -175)

				local var_236_72 = arg_233_1:GetWordFromCfg(419037)
				local var_236_73 = arg_233_1:FormatText(var_236_72.content)

				arg_233_1.cswt_.text = var_236_73

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.cswt_)

				arg_233_1.cswt_.fontSize = 180
				arg_233_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_233_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_233_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end
		end

		arg_233_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_233_1:InitPlayNodeList()
	end,
	Play319651058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 319651058
		arg_237_1.duration_ = 1

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play319651059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = 0

			if var_240_0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_0 + arg_240_0 then
				arg_237_1.fswbg_:SetActive(true)
				arg_237_1.dialog_:SetActive(false)

				arg_237_1.fswtw_.percent = 0

				local var_240_1 = arg_237_1:GetWordFromCfg(319651058)
				local var_240_2 = arg_237_1:FormatText(var_240_1.content)

				arg_237_1.fswt_.text = var_240_2

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.fswt_)

				arg_237_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_237_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_237_1.fswtw_:SetDirty()

				arg_237_1.typewritterCharCountI18N = 0

				SetActive(arg_237_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_237_1:ShowNextGo(false)
			end

			local var_240_3 = 0.149999999998999

			if var_240_3 < arg_237_1.time_ and arg_237_1.time_ <= var_240_3 + arg_240_0 then
				arg_237_1.var_.oldValueTypewriter = arg_237_1.fswtw_.percent

				SetActive(arg_237_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_237_1:ShowNextGo(false)
			end

			local var_240_4 = 0
			local var_240_5 = 0
			local var_240_6 = arg_237_1:GetWordFromCfg(319651058)
			local var_240_7 = arg_237_1:FormatText(var_240_6.content)
			local var_240_8, var_240_9 = arg_237_1:GetPercentByPara(var_240_7, 1)

			if var_240_3 < arg_237_1.time_ and arg_237_1.time_ <= var_240_3 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0

				local var_240_10 = var_240_4 <= 0 and var_240_5 or var_240_5 * ((var_240_9 - arg_237_1.typewritterCharCountI18N) / var_240_4)

				if var_240_10 > 0 and var_240_5 < var_240_10 then
					arg_237_1.talkMaxDuration = var_240_10

					if var_240_10 + var_240_3 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_10 + var_240_3
					end
				end
			end

			local var_240_11 = 0
			local var_240_12 = math.max(var_240_11, arg_237_1.talkMaxDuration)

			if var_240_3 <= arg_237_1.time_ and arg_237_1.time_ < var_240_3 + var_240_12 then
				local var_240_13 = (arg_237_1.time_ - var_240_3) / var_240_12

				arg_237_1.fswtw_.percent = Mathf.Lerp(arg_237_1.var_.oldValueTypewriter, var_240_8, var_240_13)
				arg_237_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_237_1.fswtw_:SetDirty()
			end

			if arg_237_1.time_ >= var_240_3 + var_240_12 and arg_237_1.time_ < var_240_3 + var_240_12 + arg_240_0 then
				arg_237_1.fswtw_.percent = var_240_8

				arg_237_1.fswtw_:SetDirty()
				arg_237_1:ShowNextGo(true)

				arg_237_1.typewritterCharCountI18N = var_240_9
			end

			local var_240_14 = 0.15

			if var_240_14 < arg_237_1.time_ and arg_237_1.time_ <= var_240_14 + arg_240_0 then
				arg_237_1.var_.oldValueTypewriter = arg_237_1.fswtw_.percent

				SetActive(arg_237_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_237_1:ShowNextGo(false)
			end

			local var_240_15 = 14
			local var_240_16 = 0.533333333333333
			local var_240_17 = arg_237_1:GetWordFromCfg(319651058)
			local var_240_18 = arg_237_1:FormatText(var_240_17.content)
			local var_240_19, var_240_20 = arg_237_1:GetPercentByPara(var_240_18, 1)

			if var_240_14 < arg_237_1.time_ and arg_237_1.time_ <= var_240_14 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0

				local var_240_21 = var_240_15 <= 0 and var_240_16 or var_240_16 * ((var_240_20 - arg_237_1.typewritterCharCountI18N) / var_240_15)

				if var_240_21 > 0 and var_240_16 < var_240_21 then
					arg_237_1.talkMaxDuration = var_240_21

					if var_240_21 + var_240_14 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_21 + var_240_14
					end
				end
			end

			local var_240_22 = 0.533333333333333
			local var_240_23 = math.max(var_240_22, arg_237_1.talkMaxDuration)

			if var_240_14 <= arg_237_1.time_ and arg_237_1.time_ < var_240_14 + var_240_23 then
				local var_240_24 = (arg_237_1.time_ - var_240_14) / var_240_23

				arg_237_1.fswtw_.percent = Mathf.Lerp(arg_237_1.var_.oldValueTypewriter, var_240_19, var_240_24)
				arg_237_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_237_1.fswtw_:SetDirty()
			end

			if arg_237_1.time_ >= var_240_14 + var_240_23 and arg_237_1.time_ < var_240_14 + var_240_23 + arg_240_0 then
				arg_237_1.fswtw_.percent = var_240_19

				arg_237_1.fswtw_:SetDirty()
				arg_237_1:ShowNextGo(true)

				arg_237_1.typewritterCharCountI18N = var_240_20
			end

			local var_240_25 = 0
			local var_240_26 = 1
			local var_240_27 = manager.audio:GetVoiceLength("story_v_out_319651", "319651058", "story_v_out_319651.awb") / 1000

			if var_240_27 > 0 and var_240_26 < var_240_27 and var_240_27 + var_240_25 > arg_237_1.duration_ then
				local var_240_28 = var_240_27

				arg_237_1.duration_ = var_240_27 + var_240_25
			end

			if var_240_25 < arg_237_1.time_ and arg_237_1.time_ <= var_240_25 + arg_240_0 then
				local var_240_29 = "play"
				local var_240_30 = "voice"

				arg_237_1:AudioAction(var_240_29, var_240_30, "story_v_out_319651", "319651058", "story_v_out_319651.awb")
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play319651059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 319651059
		arg_241_1.duration_ = 1.07

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play319651060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = 0

			if var_244_0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_0 + arg_244_0 then
				arg_241_1.fswbg_:SetActive(true)
				arg_241_1.dialog_:SetActive(false)

				arg_241_1.fswtw_.percent = 0

				local var_244_1 = arg_241_1:GetWordFromCfg(319651059)
				local var_244_2 = arg_241_1:FormatText(var_244_1.content)

				arg_241_1.fswt_.text = var_244_2

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.fswt_)

				arg_241_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_241_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_241_1.fswtw_:SetDirty()

				arg_241_1.typewritterCharCountI18N = 0

				SetActive(arg_241_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_241_1:ShowNextGo(false)
			end

			local var_244_3 = 0.0666666666666667

			if var_244_3 < arg_241_1.time_ and arg_241_1.time_ <= var_244_3 + arg_244_0 then
				arg_241_1.var_.oldValueTypewriter = arg_241_1.fswtw_.percent

				SetActive(arg_241_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_241_1:ShowNextGo(false)
			end

			local var_244_4 = 13
			local var_244_5 = 0.866666666666667
			local var_244_6 = arg_241_1:GetWordFromCfg(319651059)
			local var_244_7 = arg_241_1:FormatText(var_244_6.content)
			local var_244_8, var_244_9 = arg_241_1:GetPercentByPara(var_244_7, 1)

			if var_244_3 < arg_241_1.time_ and arg_241_1.time_ <= var_244_3 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0

				local var_244_10 = var_244_4 <= 0 and var_244_5 or var_244_5 * ((var_244_9 - arg_241_1.typewritterCharCountI18N) / var_244_4)

				if var_244_10 > 0 and var_244_5 < var_244_10 then
					arg_241_1.talkMaxDuration = var_244_10

					if var_244_10 + var_244_3 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_10 + var_244_3
					end
				end
			end

			local var_244_11 = 0.866666666666667
			local var_244_12 = math.max(var_244_11, arg_241_1.talkMaxDuration)

			if var_244_3 <= arg_241_1.time_ and arg_241_1.time_ < var_244_3 + var_244_12 then
				local var_244_13 = (arg_241_1.time_ - var_244_3) / var_244_12

				arg_241_1.fswtw_.percent = Mathf.Lerp(arg_241_1.var_.oldValueTypewriter, var_244_8, var_244_13)
				arg_241_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_241_1.fswtw_:SetDirty()
			end

			if arg_241_1.time_ >= var_244_3 + var_244_12 and arg_241_1.time_ < var_244_3 + var_244_12 + arg_244_0 then
				arg_241_1.fswtw_.percent = var_244_8

				arg_241_1.fswtw_:SetDirty()
				arg_241_1:ShowNextGo(true)

				arg_241_1.typewritterCharCountI18N = var_244_9
			end

			local var_244_14 = 0.149999999998999

			if var_244_14 < arg_241_1.time_ and arg_241_1.time_ <= var_244_14 + arg_244_0 then
				arg_241_1.var_.oldValueTypewriter = arg_241_1.fswtw_.percent

				SetActive(arg_241_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_241_1:ShowNextGo(false)
			end

			local var_244_15 = 0
			local var_244_16 = 0
			local var_244_17 = arg_241_1:GetWordFromCfg(319651059)
			local var_244_18 = arg_241_1:FormatText(var_244_17.content)
			local var_244_19, var_244_20 = arg_241_1:GetPercentByPara(var_244_18, 1)

			if var_244_14 < arg_241_1.time_ and arg_241_1.time_ <= var_244_14 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0

				local var_244_21 = var_244_15 <= 0 and var_244_16 or var_244_16 * ((var_244_20 - arg_241_1.typewritterCharCountI18N) / var_244_15)

				if var_244_21 > 0 and var_244_16 < var_244_21 then
					arg_241_1.talkMaxDuration = var_244_21

					if var_244_21 + var_244_14 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_21 + var_244_14
					end
				end
			end

			local var_244_22 = 0
			local var_244_23 = math.max(var_244_22, arg_241_1.talkMaxDuration)

			if var_244_14 <= arg_241_1.time_ and arg_241_1.time_ < var_244_14 + var_244_23 then
				local var_244_24 = (arg_241_1.time_ - var_244_14) / var_244_23

				arg_241_1.fswtw_.percent = Mathf.Lerp(arg_241_1.var_.oldValueTypewriter, var_244_19, var_244_24)
				arg_241_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_241_1.fswtw_:SetDirty()
			end

			if arg_241_1.time_ >= var_244_14 + var_244_23 and arg_241_1.time_ < var_244_14 + var_244_23 + arg_244_0 then
				arg_241_1.fswtw_.percent = var_244_19

				arg_241_1.fswtw_:SetDirty()
				arg_241_1:ShowNextGo(true)

				arg_241_1.typewritterCharCountI18N = var_244_20
			end

			local var_244_25 = 0.0666666666666667
			local var_244_26 = 1
			local var_244_27 = manager.audio:GetVoiceLength("story_v_out_319651", "319651059", "story_v_out_319651.awb") / 1000

			if var_244_27 > 0 and var_244_26 < var_244_27 and var_244_27 + var_244_25 > arg_241_1.duration_ then
				local var_244_28 = var_244_27

				arg_241_1.duration_ = var_244_27 + var_244_25
			end

			if var_244_25 < arg_241_1.time_ and arg_241_1.time_ <= var_244_25 + arg_244_0 then
				local var_244_29 = "play"
				local var_244_30 = "voice"

				arg_241_1:AudioAction(var_244_29, var_244_30, "story_v_out_319651", "319651059", "story_v_out_319651.awb")
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play319651060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 319651060
		arg_245_1.duration_ = 11.3

		local var_245_0 = {
			zh = 4.73300000298023,
			ja = 11.3000000029802
		}
		local var_245_1 = manager.audio:GetLocalizationFlag()

		if var_245_0[var_245_1] ~= nil then
			arg_245_1.duration_ = var_245_0[var_245_1]
		end

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play319651061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 0

			if var_248_0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_0 + arg_248_0 then
				local var_248_1 = manager.ui.mainCamera.transform.localPosition
				local var_248_2 = Vector3.New(0, 0, 10) + Vector3.New(var_248_1.x, var_248_1.y, 0)
				local var_248_3 = arg_245_1.bgs_.ST74

				var_248_3.transform.localPosition = var_248_2
				var_248_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_248_4 = var_248_3:GetComponent("SpriteRenderer")

				if var_248_4 and var_248_4.sprite then
					local var_248_5 = (var_248_3.transform.localPosition - var_248_1).z
					local var_248_6 = manager.ui.mainCameraCom_
					local var_248_7 = 2 * var_248_5 * Mathf.Tan(var_248_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_248_8 = var_248_7 * var_248_6.aspect
					local var_248_9 = var_248_4.sprite.bounds.size.x
					local var_248_10 = var_248_4.sprite.bounds.size.y
					local var_248_11 = var_248_8 / var_248_9
					local var_248_12 = var_248_7 / var_248_10
					local var_248_13 = var_248_12 < var_248_11 and var_248_11 or var_248_12

					var_248_3.transform.localScale = Vector3.New(var_248_13, var_248_13, 0)
				end

				for iter_248_0, iter_248_1 in pairs(arg_245_1.bgs_) do
					if iter_248_0 ~= "ST74" then
						iter_248_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_248_14 = 0

			if var_248_14 < arg_245_1.time_ and arg_245_1.time_ <= var_248_14 + arg_248_0 then
				arg_245_1.allBtn_.enabled = false
			end

			local var_248_15 = 0.3

			if arg_245_1.time_ >= var_248_14 + var_248_15 and arg_245_1.time_ < var_248_14 + var_248_15 + arg_248_0 then
				arg_245_1.allBtn_.enabled = true
			end

			local var_248_16 = 0

			if var_248_16 < arg_245_1.time_ and arg_245_1.time_ <= var_248_16 + arg_248_0 then
				arg_245_1.mask_.enabled = true
				arg_245_1.mask_.raycastTarget = true

				arg_245_1:SetGaussion(false)
			end

			local var_248_17 = 1.3

			if var_248_16 <= arg_245_1.time_ and arg_245_1.time_ < var_248_16 + var_248_17 then
				local var_248_18 = (arg_245_1.time_ - var_248_16) / var_248_17
				local var_248_19 = Color.New(0, 0, 0)

				var_248_19.a = Mathf.Lerp(1, 0, var_248_18)
				arg_245_1.mask_.color = var_248_19
			end

			if arg_245_1.time_ >= var_248_16 + var_248_17 and arg_245_1.time_ < var_248_16 + var_248_17 + arg_248_0 then
				local var_248_20 = Color.New(0, 0, 0)
				local var_248_21 = 0

				arg_245_1.mask_.enabled = false
				var_248_20.a = var_248_21
				arg_245_1.mask_.color = var_248_20
			end

			local var_248_22 = arg_245_1.actors_["1084ui_story"].transform
			local var_248_23 = 1.3

			if var_248_23 < arg_245_1.time_ and arg_245_1.time_ <= var_248_23 + arg_248_0 then
				arg_245_1.var_.moveOldPos1084ui_story = var_248_22.localPosition

				local var_248_24 = "1084ui_story"

				arg_245_1:ShowWeapon(arg_245_1.var_[var_248_24 .. "Animator"].transform, false)
			end

			local var_248_25 = 0.001

			if var_248_23 <= arg_245_1.time_ and arg_245_1.time_ < var_248_23 + var_248_25 then
				local var_248_26 = (arg_245_1.time_ - var_248_23) / var_248_25
				local var_248_27 = Vector3.New(0, -0.97, -6)

				var_248_22.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos1084ui_story, var_248_27, var_248_26)

				local var_248_28 = manager.ui.mainCamera.transform.position - var_248_22.position

				var_248_22.forward = Vector3.New(var_248_28.x, var_248_28.y, var_248_28.z)

				local var_248_29 = var_248_22.localEulerAngles

				var_248_29.z = 0
				var_248_29.x = 0
				var_248_22.localEulerAngles = var_248_29
			end

			if arg_245_1.time_ >= var_248_23 + var_248_25 and arg_245_1.time_ < var_248_23 + var_248_25 + arg_248_0 then
				var_248_22.localPosition = Vector3.New(0, -0.97, -6)

				local var_248_30 = manager.ui.mainCamera.transform.position - var_248_22.position

				var_248_22.forward = Vector3.New(var_248_30.x, var_248_30.y, var_248_30.z)

				local var_248_31 = var_248_22.localEulerAngles

				var_248_31.z = 0
				var_248_31.x = 0
				var_248_22.localEulerAngles = var_248_31
			end

			local var_248_32 = arg_245_1.actors_["1084ui_story"]
			local var_248_33 = 1.3

			if var_248_33 < arg_245_1.time_ and arg_245_1.time_ <= var_248_33 + arg_248_0 and not isNil(var_248_32) and arg_245_1.var_.characterEffect1084ui_story == nil then
				arg_245_1.var_.characterEffect1084ui_story = var_248_32:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_34 = 0.200000002980232

			if var_248_33 <= arg_245_1.time_ and arg_245_1.time_ < var_248_33 + var_248_34 and not isNil(var_248_32) then
				local var_248_35 = (arg_245_1.time_ - var_248_33) / var_248_34

				if arg_245_1.var_.characterEffect1084ui_story and not isNil(var_248_32) then
					arg_245_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_245_1.time_ >= var_248_33 + var_248_34 and arg_245_1.time_ < var_248_33 + var_248_34 + arg_248_0 and not isNil(var_248_32) and arg_245_1.var_.characterEffect1084ui_story then
				arg_245_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_248_36 = 1.3

			if var_248_36 < arg_245_1.time_ and arg_245_1.time_ <= var_248_36 + arg_248_0 then
				arg_245_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_1")
			end

			local var_248_37 = 1.3

			if var_248_37 < arg_245_1.time_ and arg_245_1.time_ <= var_248_37 + arg_248_0 then
				arg_245_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_248_38 = 0

			if var_248_38 < arg_245_1.time_ and arg_245_1.time_ <= var_248_38 + arg_248_0 then
				arg_245_1.fswbg_:SetActive(false)
				arg_245_1.dialog_:SetActive(false)
				SetActive(arg_245_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_245_1:ShowNextGo(false)
			end

			local var_248_39 = 0.149999999998999

			if var_248_39 < arg_245_1.time_ and arg_245_1.time_ <= var_248_39 + arg_248_0 then
				arg_245_1.var_.oldValueTypewriter = arg_245_1.fswtw_.percent

				SetActive(arg_245_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_245_1:ShowNextGo(false)
			end

			local var_248_40 = 0
			local var_248_41 = 0
			local var_248_42 = arg_245_1:GetWordFromCfg(319651059)
			local var_248_43 = arg_245_1:FormatText(var_248_42.content)
			local var_248_44, var_248_45 = arg_245_1:GetPercentByPara(var_248_43, 1)

			if var_248_39 < arg_245_1.time_ and arg_245_1.time_ <= var_248_39 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0

				local var_248_46 = var_248_40 <= 0 and var_248_41 or var_248_41 * ((var_248_45 - arg_245_1.typewritterCharCountI18N) / var_248_40)

				if var_248_46 > 0 and var_248_41 < var_248_46 then
					arg_245_1.talkMaxDuration = var_248_46

					if var_248_46 + var_248_39 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_46 + var_248_39
					end
				end
			end

			local var_248_47 = 0
			local var_248_48 = math.max(var_248_47, arg_245_1.talkMaxDuration)

			if var_248_39 <= arg_245_1.time_ and arg_245_1.time_ < var_248_39 + var_248_48 then
				local var_248_49 = (arg_245_1.time_ - var_248_39) / var_248_48

				arg_245_1.fswtw_.percent = Mathf.Lerp(arg_245_1.var_.oldValueTypewriter, var_248_44, var_248_49)
				arg_245_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_245_1.fswtw_:SetDirty()
			end

			if arg_245_1.time_ >= var_248_39 + var_248_48 and arg_245_1.time_ < var_248_39 + var_248_48 + arg_248_0 then
				arg_245_1.fswtw_.percent = var_248_44

				arg_245_1.fswtw_:SetDirty()
				arg_245_1:ShowNextGo(true)

				arg_245_1.typewritterCharCountI18N = var_248_45
			end

			local var_248_50 = 0.15

			if var_248_50 < arg_245_1.time_ and arg_245_1.time_ <= var_248_50 + arg_248_0 then
				arg_245_1.fswbg_:SetActive(false)
				arg_245_1.dialog_:SetActive(false)
				SetActive(arg_245_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_245_1:ShowNextGo(false)
			end

			local var_248_51 = 0

			if var_248_51 < arg_245_1.time_ and arg_245_1.time_ <= var_248_51 + arg_248_0 then
				arg_245_1.cswbg_:SetActive(false)
			end

			if arg_245_1.frameCnt_ <= 1 then
				arg_245_1.dialog_:SetActive(false)
			end

			local var_248_52 = 1.50000000298023
			local var_248_53 = 0.4

			if var_248_52 < arg_245_1.time_ and arg_245_1.time_ <= var_248_52 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0

				arg_245_1.dialog_:SetActive(true)

				arg_245_1.dialogCg_.alpha = 0

				local var_248_54 = LeanTween.value(arg_245_1.dialog_, 0, 1, 0.3)

				var_248_54:setOnUpdate(LuaHelper.FloatAction(function(arg_249_0)
					arg_245_1.dialogCg_.alpha = arg_249_0
				end))
				var_248_54:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_245_1.dialog_)
					var_248_54:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_245_1.duration_ = arg_245_1.duration_ + 0.3

				SetActive(arg_245_1.leftNameGo_, true)

				local var_248_55 = arg_245_1:FormatText(StoryNameCfg[6].name)

				arg_245_1.leftNameTxt_.text = var_248_55

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_56 = arg_245_1:GetWordFromCfg(319651060)
				local var_248_57 = arg_245_1:FormatText(var_248_56.content)

				arg_245_1.text_.text = var_248_57

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_58 = 16
				local var_248_59 = utf8.len(var_248_57)
				local var_248_60 = var_248_58 <= 0 and var_248_53 or var_248_53 * (var_248_59 / var_248_58)

				if var_248_60 > 0 and var_248_53 < var_248_60 then
					arg_245_1.talkMaxDuration = var_248_60
					var_248_52 = var_248_52 + 0.3

					if var_248_60 + var_248_52 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_60 + var_248_52
					end
				end

				arg_245_1.text_.text = var_248_57
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651060", "story_v_out_319651.awb") ~= 0 then
					local var_248_61 = manager.audio:GetVoiceLength("story_v_out_319651", "319651060", "story_v_out_319651.awb") / 1000

					if var_248_61 + var_248_52 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_61 + var_248_52
					end

					if var_248_56.prefab_name ~= "" and arg_245_1.actors_[var_248_56.prefab_name] ~= nil then
						local var_248_62 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_56.prefab_name].transform, "story_v_out_319651", "319651060", "story_v_out_319651.awb")

						arg_245_1:RecordAudio("319651060", var_248_62)
						arg_245_1:RecordAudio("319651060", var_248_62)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_319651", "319651060", "story_v_out_319651.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_319651", "319651060", "story_v_out_319651.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_63 = var_248_52 + 0.3
			local var_248_64 = math.max(var_248_53, arg_245_1.talkMaxDuration)

			if var_248_63 <= arg_245_1.time_ and arg_245_1.time_ < var_248_63 + var_248_64 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_63) / var_248_64

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_63 + var_248_64 and arg_245_1.time_ < var_248_63 + var_248_64 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.3,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_245_1:InitPlayNodeList()
	end,
	Play319651061 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 319651061
		arg_251_1.duration_ = 10.13

		local var_251_0 = {
			zh = 7.533,
			ja = 10.133
		}
		local var_251_1 = manager.audio:GetLocalizationFlag()

		if var_251_0[var_251_1] ~= nil then
			arg_251_1.duration_ = var_251_0[var_251_1]
		end

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play319651062(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = arg_251_1.actors_["10066ui_story"].transform
			local var_254_1 = 0

			if var_254_1 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 then
				arg_251_1.var_.moveOldPos10066ui_story = var_254_0.localPosition
			end

			local var_254_2 = 0.001

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_2 then
				local var_254_3 = (arg_251_1.time_ - var_254_1) / var_254_2
				local var_254_4 = Vector3.New(-0.7, -0.99, -5.83)

				var_254_0.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos10066ui_story, var_254_4, var_254_3)

				local var_254_5 = manager.ui.mainCamera.transform.position - var_254_0.position

				var_254_0.forward = Vector3.New(var_254_5.x, var_254_5.y, var_254_5.z)

				local var_254_6 = var_254_0.localEulerAngles

				var_254_6.z = 0
				var_254_6.x = 0
				var_254_0.localEulerAngles = var_254_6
			end

			if arg_251_1.time_ >= var_254_1 + var_254_2 and arg_251_1.time_ < var_254_1 + var_254_2 + arg_254_0 then
				var_254_0.localPosition = Vector3.New(-0.7, -0.99, -5.83)

				local var_254_7 = manager.ui.mainCamera.transform.position - var_254_0.position

				var_254_0.forward = Vector3.New(var_254_7.x, var_254_7.y, var_254_7.z)

				local var_254_8 = var_254_0.localEulerAngles

				var_254_8.z = 0
				var_254_8.x = 0
				var_254_0.localEulerAngles = var_254_8
			end

			local var_254_9 = arg_251_1.actors_["10066ui_story"]
			local var_254_10 = 0

			if var_254_10 < arg_251_1.time_ and arg_251_1.time_ <= var_254_10 + arg_254_0 and not isNil(var_254_9) and arg_251_1.var_.characterEffect10066ui_story == nil then
				arg_251_1.var_.characterEffect10066ui_story = var_254_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_11 = 0.200000002980232

			if var_254_10 <= arg_251_1.time_ and arg_251_1.time_ < var_254_10 + var_254_11 and not isNil(var_254_9) then
				local var_254_12 = (arg_251_1.time_ - var_254_10) / var_254_11

				if arg_251_1.var_.characterEffect10066ui_story and not isNil(var_254_9) then
					arg_251_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_251_1.time_ >= var_254_10 + var_254_11 and arg_251_1.time_ < var_254_10 + var_254_11 + arg_254_0 and not isNil(var_254_9) and arg_251_1.var_.characterEffect10066ui_story then
				arg_251_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_254_13 = 0

			if var_254_13 < arg_251_1.time_ and arg_251_1.time_ <= var_254_13 + arg_254_0 then
				arg_251_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_254_14 = arg_251_1.actors_["1084ui_story"]
			local var_254_15 = 0

			if var_254_15 < arg_251_1.time_ and arg_251_1.time_ <= var_254_15 + arg_254_0 and not isNil(var_254_14) and arg_251_1.var_.characterEffect1084ui_story == nil then
				arg_251_1.var_.characterEffect1084ui_story = var_254_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_16 = 0.200000002980232

			if var_254_15 <= arg_251_1.time_ and arg_251_1.time_ < var_254_15 + var_254_16 and not isNil(var_254_14) then
				local var_254_17 = (arg_251_1.time_ - var_254_15) / var_254_16

				if arg_251_1.var_.characterEffect1084ui_story and not isNil(var_254_14) then
					local var_254_18 = Mathf.Lerp(0, 0.5, var_254_17)

					arg_251_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_251_1.var_.characterEffect1084ui_story.fillRatio = var_254_18
				end
			end

			if arg_251_1.time_ >= var_254_15 + var_254_16 and arg_251_1.time_ < var_254_15 + var_254_16 + arg_254_0 and not isNil(var_254_14) and arg_251_1.var_.characterEffect1084ui_story then
				local var_254_19 = 0.5

				arg_251_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_251_1.var_.characterEffect1084ui_story.fillRatio = var_254_19
			end

			local var_254_20 = arg_251_1.actors_["1084ui_story"].transform
			local var_254_21 = 0

			if var_254_21 < arg_251_1.time_ and arg_251_1.time_ <= var_254_21 + arg_254_0 then
				arg_251_1.var_.moveOldPos1084ui_story = var_254_20.localPosition
			end

			local var_254_22 = 0.001

			if var_254_21 <= arg_251_1.time_ and arg_251_1.time_ < var_254_21 + var_254_22 then
				local var_254_23 = (arg_251_1.time_ - var_254_21) / var_254_22
				local var_254_24 = Vector3.New(0.7, -0.97, -6)

				var_254_20.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos1084ui_story, var_254_24, var_254_23)

				local var_254_25 = manager.ui.mainCamera.transform.position - var_254_20.position

				var_254_20.forward = Vector3.New(var_254_25.x, var_254_25.y, var_254_25.z)

				local var_254_26 = var_254_20.localEulerAngles

				var_254_26.z = 0
				var_254_26.x = 0
				var_254_20.localEulerAngles = var_254_26
			end

			if arg_251_1.time_ >= var_254_21 + var_254_22 and arg_251_1.time_ < var_254_21 + var_254_22 + arg_254_0 then
				var_254_20.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_254_27 = manager.ui.mainCamera.transform.position - var_254_20.position

				var_254_20.forward = Vector3.New(var_254_27.x, var_254_27.y, var_254_27.z)

				local var_254_28 = var_254_20.localEulerAngles

				var_254_28.z = 0
				var_254_28.x = 0
				var_254_20.localEulerAngles = var_254_28
			end

			local var_254_29 = 0
			local var_254_30 = 0.7

			if var_254_29 < arg_251_1.time_ and arg_251_1.time_ <= var_254_29 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				local var_254_31 = arg_251_1:FormatText(StoryNameCfg[640].name)

				arg_251_1.leftNameTxt_.text = var_254_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_32 = arg_251_1:GetWordFromCfg(319651061)
				local var_254_33 = arg_251_1:FormatText(var_254_32.content)

				arg_251_1.text_.text = var_254_33

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_34 = 28
				local var_254_35 = utf8.len(var_254_33)
				local var_254_36 = var_254_34 <= 0 and var_254_30 or var_254_30 * (var_254_35 / var_254_34)

				if var_254_36 > 0 and var_254_30 < var_254_36 then
					arg_251_1.talkMaxDuration = var_254_36

					if var_254_36 + var_254_29 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_36 + var_254_29
					end
				end

				arg_251_1.text_.text = var_254_33
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651061", "story_v_out_319651.awb") ~= 0 then
					local var_254_37 = manager.audio:GetVoiceLength("story_v_out_319651", "319651061", "story_v_out_319651.awb") / 1000

					if var_254_37 + var_254_29 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_37 + var_254_29
					end

					if var_254_32.prefab_name ~= "" and arg_251_1.actors_[var_254_32.prefab_name] ~= nil then
						local var_254_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_32.prefab_name].transform, "story_v_out_319651", "319651061", "story_v_out_319651.awb")

						arg_251_1:RecordAudio("319651061", var_254_38)
						arg_251_1:RecordAudio("319651061", var_254_38)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_319651", "319651061", "story_v_out_319651.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_319651", "319651061", "story_v_out_319651.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_39 = math.max(var_254_30, arg_251_1.talkMaxDuration)

			if var_254_29 <= arg_251_1.time_ and arg_251_1.time_ < var_254_29 + var_254_39 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_29) / var_254_39

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_29 + var_254_39 and arg_251_1.time_ < var_254_29 + var_254_39 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_251_1:InitPlayNodeList()
	end,
	Play319651062 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 319651062
		arg_255_1.duration_ = 6.67

		local var_255_0 = {
			zh = 6.066,
			ja = 6.666
		}
		local var_255_1 = manager.audio:GetLocalizationFlag()

		if var_255_0[var_255_1] ~= nil then
			arg_255_1.duration_ = var_255_0[var_255_1]
		end

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play319651063(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = arg_255_1.actors_["10066ui_story"]
			local var_258_1 = 0

			if var_258_1 < arg_255_1.time_ and arg_255_1.time_ <= var_258_1 + arg_258_0 and not isNil(var_258_0) and arg_255_1.var_.characterEffect10066ui_story == nil then
				arg_255_1.var_.characterEffect10066ui_story = var_258_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_2 = 0.200000002980232

			if var_258_1 <= arg_255_1.time_ and arg_255_1.time_ < var_258_1 + var_258_2 and not isNil(var_258_0) then
				local var_258_3 = (arg_255_1.time_ - var_258_1) / var_258_2

				if arg_255_1.var_.characterEffect10066ui_story and not isNil(var_258_0) then
					local var_258_4 = Mathf.Lerp(0, 0.5, var_258_3)

					arg_255_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_255_1.var_.characterEffect10066ui_story.fillRatio = var_258_4
				end
			end

			if arg_255_1.time_ >= var_258_1 + var_258_2 and arg_255_1.time_ < var_258_1 + var_258_2 + arg_258_0 and not isNil(var_258_0) and arg_255_1.var_.characterEffect10066ui_story then
				local var_258_5 = 0.5

				arg_255_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_255_1.var_.characterEffect10066ui_story.fillRatio = var_258_5
			end

			local var_258_6 = 0

			if var_258_6 < arg_255_1.time_ and arg_255_1.time_ <= var_258_6 + arg_258_0 then
				arg_255_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_2")
			end

			local var_258_7 = 0

			if var_258_7 < arg_255_1.time_ and arg_255_1.time_ <= var_258_7 + arg_258_0 then
				arg_255_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_258_8 = arg_255_1.actors_["1084ui_story"]
			local var_258_9 = 0

			if var_258_9 < arg_255_1.time_ and arg_255_1.time_ <= var_258_9 + arg_258_0 and not isNil(var_258_8) and arg_255_1.var_.characterEffect1084ui_story == nil then
				arg_255_1.var_.characterEffect1084ui_story = var_258_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_10 = 0.200000002980232

			if var_258_9 <= arg_255_1.time_ and arg_255_1.time_ < var_258_9 + var_258_10 and not isNil(var_258_8) then
				local var_258_11 = (arg_255_1.time_ - var_258_9) / var_258_10

				if arg_255_1.var_.characterEffect1084ui_story and not isNil(var_258_8) then
					arg_255_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_255_1.time_ >= var_258_9 + var_258_10 and arg_255_1.time_ < var_258_9 + var_258_10 + arg_258_0 and not isNil(var_258_8) and arg_255_1.var_.characterEffect1084ui_story then
				arg_255_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_258_12 = 0
			local var_258_13 = 0.575

			if var_258_12 < arg_255_1.time_ and arg_255_1.time_ <= var_258_12 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				local var_258_14 = arg_255_1:FormatText(StoryNameCfg[6].name)

				arg_255_1.leftNameTxt_.text = var_258_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_15 = arg_255_1:GetWordFromCfg(319651062)
				local var_258_16 = arg_255_1:FormatText(var_258_15.content)

				arg_255_1.text_.text = var_258_16

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_17 = 23
				local var_258_18 = utf8.len(var_258_16)
				local var_258_19 = var_258_17 <= 0 and var_258_13 or var_258_13 * (var_258_18 / var_258_17)

				if var_258_19 > 0 and var_258_13 < var_258_19 then
					arg_255_1.talkMaxDuration = var_258_19

					if var_258_19 + var_258_12 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_19 + var_258_12
					end
				end

				arg_255_1.text_.text = var_258_16
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651062", "story_v_out_319651.awb") ~= 0 then
					local var_258_20 = manager.audio:GetVoiceLength("story_v_out_319651", "319651062", "story_v_out_319651.awb") / 1000

					if var_258_20 + var_258_12 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_20 + var_258_12
					end

					if var_258_15.prefab_name ~= "" and arg_255_1.actors_[var_258_15.prefab_name] ~= nil then
						local var_258_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_15.prefab_name].transform, "story_v_out_319651", "319651062", "story_v_out_319651.awb")

						arg_255_1:RecordAudio("319651062", var_258_21)
						arg_255_1:RecordAudio("319651062", var_258_21)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_319651", "319651062", "story_v_out_319651.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_319651", "319651062", "story_v_out_319651.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_22 = math.max(var_258_13, arg_255_1.talkMaxDuration)

			if var_258_12 <= arg_255_1.time_ and arg_255_1.time_ < var_258_12 + var_258_22 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_12) / var_258_22

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_12 + var_258_22 and arg_255_1.time_ < var_258_12 + var_258_22 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play319651063 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 319651063
		arg_259_1.duration_ = 3.83

		local var_259_0 = {
			zh = 2.933,
			ja = 3.833
		}
		local var_259_1 = manager.audio:GetLocalizationFlag()

		if var_259_0[var_259_1] ~= nil then
			arg_259_1.duration_ = var_259_0[var_259_1]
		end

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play319651064(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = arg_259_1.actors_["10058ui_story"].transform
			local var_262_1 = 0

			if var_262_1 < arg_259_1.time_ and arg_259_1.time_ <= var_262_1 + arg_262_0 then
				arg_259_1.var_.moveOldPos10058ui_story = var_262_0.localPosition
			end

			local var_262_2 = 0.001

			if var_262_1 <= arg_259_1.time_ and arg_259_1.time_ < var_262_1 + var_262_2 then
				local var_262_3 = (arg_259_1.time_ - var_262_1) / var_262_2
				local var_262_4 = Vector3.New(0, -0.98, -6.1)

				var_262_0.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos10058ui_story, var_262_4, var_262_3)

				local var_262_5 = manager.ui.mainCamera.transform.position - var_262_0.position

				var_262_0.forward = Vector3.New(var_262_5.x, var_262_5.y, var_262_5.z)

				local var_262_6 = var_262_0.localEulerAngles

				var_262_6.z = 0
				var_262_6.x = 0
				var_262_0.localEulerAngles = var_262_6
			end

			if arg_259_1.time_ >= var_262_1 + var_262_2 and arg_259_1.time_ < var_262_1 + var_262_2 + arg_262_0 then
				var_262_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_262_7 = manager.ui.mainCamera.transform.position - var_262_0.position

				var_262_0.forward = Vector3.New(var_262_7.x, var_262_7.y, var_262_7.z)

				local var_262_8 = var_262_0.localEulerAngles

				var_262_8.z = 0
				var_262_8.x = 0
				var_262_0.localEulerAngles = var_262_8
			end

			local var_262_9 = arg_259_1.actors_["10058ui_story"]
			local var_262_10 = 0

			if var_262_10 < arg_259_1.time_ and arg_259_1.time_ <= var_262_10 + arg_262_0 and not isNil(var_262_9) and arg_259_1.var_.characterEffect10058ui_story == nil then
				arg_259_1.var_.characterEffect10058ui_story = var_262_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_11 = 0.200000002980232

			if var_262_10 <= arg_259_1.time_ and arg_259_1.time_ < var_262_10 + var_262_11 and not isNil(var_262_9) then
				local var_262_12 = (arg_259_1.time_ - var_262_10) / var_262_11

				if arg_259_1.var_.characterEffect10058ui_story and not isNil(var_262_9) then
					arg_259_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_259_1.time_ >= var_262_10 + var_262_11 and arg_259_1.time_ < var_262_10 + var_262_11 + arg_262_0 and not isNil(var_262_9) and arg_259_1.var_.characterEffect10058ui_story then
				arg_259_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_262_13 = 0

			if var_262_13 < arg_259_1.time_ and arg_259_1.time_ <= var_262_13 + arg_262_0 then
				arg_259_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_262_14 = 0

			if var_262_14 < arg_259_1.time_ and arg_259_1.time_ <= var_262_14 + arg_262_0 then
				arg_259_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_262_15 = arg_259_1.actors_["1084ui_story"].transform
			local var_262_16 = 0

			if var_262_16 < arg_259_1.time_ and arg_259_1.time_ <= var_262_16 + arg_262_0 then
				arg_259_1.var_.moveOldPos1084ui_story = var_262_15.localPosition
			end

			local var_262_17 = 0.001

			if var_262_16 <= arg_259_1.time_ and arg_259_1.time_ < var_262_16 + var_262_17 then
				local var_262_18 = (arg_259_1.time_ - var_262_16) / var_262_17
				local var_262_19 = Vector3.New(0, 100, 0)

				var_262_15.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos1084ui_story, var_262_19, var_262_18)

				local var_262_20 = manager.ui.mainCamera.transform.position - var_262_15.position

				var_262_15.forward = Vector3.New(var_262_20.x, var_262_20.y, var_262_20.z)

				local var_262_21 = var_262_15.localEulerAngles

				var_262_21.z = 0
				var_262_21.x = 0
				var_262_15.localEulerAngles = var_262_21
			end

			if arg_259_1.time_ >= var_262_16 + var_262_17 and arg_259_1.time_ < var_262_16 + var_262_17 + arg_262_0 then
				var_262_15.localPosition = Vector3.New(0, 100, 0)

				local var_262_22 = manager.ui.mainCamera.transform.position - var_262_15.position

				var_262_15.forward = Vector3.New(var_262_22.x, var_262_22.y, var_262_22.z)

				local var_262_23 = var_262_15.localEulerAngles

				var_262_23.z = 0
				var_262_23.x = 0
				var_262_15.localEulerAngles = var_262_23
			end

			local var_262_24 = arg_259_1.actors_["1084ui_story"]
			local var_262_25 = 0

			if var_262_25 < arg_259_1.time_ and arg_259_1.time_ <= var_262_25 + arg_262_0 and not isNil(var_262_24) and arg_259_1.var_.characterEffect1084ui_story == nil then
				arg_259_1.var_.characterEffect1084ui_story = var_262_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_26 = 0.200000002980232

			if var_262_25 <= arg_259_1.time_ and arg_259_1.time_ < var_262_25 + var_262_26 and not isNil(var_262_24) then
				local var_262_27 = (arg_259_1.time_ - var_262_25) / var_262_26

				if arg_259_1.var_.characterEffect1084ui_story and not isNil(var_262_24) then
					local var_262_28 = Mathf.Lerp(0, 0.5, var_262_27)

					arg_259_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_259_1.var_.characterEffect1084ui_story.fillRatio = var_262_28
				end
			end

			if arg_259_1.time_ >= var_262_25 + var_262_26 and arg_259_1.time_ < var_262_25 + var_262_26 + arg_262_0 and not isNil(var_262_24) and arg_259_1.var_.characterEffect1084ui_story then
				local var_262_29 = 0.5

				arg_259_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_259_1.var_.characterEffect1084ui_story.fillRatio = var_262_29
			end

			local var_262_30 = arg_259_1.actors_["10066ui_story"].transform
			local var_262_31 = 0

			if var_262_31 < arg_259_1.time_ and arg_259_1.time_ <= var_262_31 + arg_262_0 then
				arg_259_1.var_.moveOldPos10066ui_story = var_262_30.localPosition
			end

			local var_262_32 = 0.001

			if var_262_31 <= arg_259_1.time_ and arg_259_1.time_ < var_262_31 + var_262_32 then
				local var_262_33 = (arg_259_1.time_ - var_262_31) / var_262_32
				local var_262_34 = Vector3.New(0, 100, 0)

				var_262_30.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos10066ui_story, var_262_34, var_262_33)

				local var_262_35 = manager.ui.mainCamera.transform.position - var_262_30.position

				var_262_30.forward = Vector3.New(var_262_35.x, var_262_35.y, var_262_35.z)

				local var_262_36 = var_262_30.localEulerAngles

				var_262_36.z = 0
				var_262_36.x = 0
				var_262_30.localEulerAngles = var_262_36
			end

			if arg_259_1.time_ >= var_262_31 + var_262_32 and arg_259_1.time_ < var_262_31 + var_262_32 + arg_262_0 then
				var_262_30.localPosition = Vector3.New(0, 100, 0)

				local var_262_37 = manager.ui.mainCamera.transform.position - var_262_30.position

				var_262_30.forward = Vector3.New(var_262_37.x, var_262_37.y, var_262_37.z)

				local var_262_38 = var_262_30.localEulerAngles

				var_262_38.z = 0
				var_262_38.x = 0
				var_262_30.localEulerAngles = var_262_38
			end

			local var_262_39 = arg_259_1.actors_["10066ui_story"]
			local var_262_40 = 0

			if var_262_40 < arg_259_1.time_ and arg_259_1.time_ <= var_262_40 + arg_262_0 and not isNil(var_262_39) and arg_259_1.var_.characterEffect10066ui_story == nil then
				arg_259_1.var_.characterEffect10066ui_story = var_262_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_41 = 0.200000002980232

			if var_262_40 <= arg_259_1.time_ and arg_259_1.time_ < var_262_40 + var_262_41 and not isNil(var_262_39) then
				local var_262_42 = (arg_259_1.time_ - var_262_40) / var_262_41

				if arg_259_1.var_.characterEffect10066ui_story and not isNil(var_262_39) then
					local var_262_43 = Mathf.Lerp(0, 0.5, var_262_42)

					arg_259_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_259_1.var_.characterEffect10066ui_story.fillRatio = var_262_43
				end
			end

			if arg_259_1.time_ >= var_262_40 + var_262_41 and arg_259_1.time_ < var_262_40 + var_262_41 + arg_262_0 and not isNil(var_262_39) and arg_259_1.var_.characterEffect10066ui_story then
				local var_262_44 = 0.5

				arg_259_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_259_1.var_.characterEffect10066ui_story.fillRatio = var_262_44
			end

			if arg_259_1.frameCnt_ <= 1 then
				arg_259_1.dialog_:SetActive(false)
			end

			local var_262_45 = 0.5
			local var_262_46 = 0.3

			if var_262_45 < arg_259_1.time_ and arg_259_1.time_ <= var_262_45 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0

				arg_259_1.dialog_:SetActive(true)

				arg_259_1.dialogCg_.alpha = 0

				local var_262_47 = LeanTween.value(arg_259_1.dialog_, 0, 1, 0.3)

				var_262_47:setOnUpdate(LuaHelper.FloatAction(function(arg_263_0)
					arg_259_1.dialogCg_.alpha = arg_263_0
				end))
				var_262_47:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_259_1.dialog_)
					var_262_47:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_259_1.duration_ = arg_259_1.duration_ + 0.3

				SetActive(arg_259_1.leftNameGo_, true)

				local var_262_48 = arg_259_1:FormatText(StoryNameCfg[471].name)

				arg_259_1.leftNameTxt_.text = var_262_48

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_49 = arg_259_1:GetWordFromCfg(319651063)
				local var_262_50 = arg_259_1:FormatText(var_262_49.content)

				arg_259_1.text_.text = var_262_50

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_51 = 12
				local var_262_52 = utf8.len(var_262_50)
				local var_262_53 = var_262_51 <= 0 and var_262_46 or var_262_46 * (var_262_52 / var_262_51)

				if var_262_53 > 0 and var_262_46 < var_262_53 then
					arg_259_1.talkMaxDuration = var_262_53
					var_262_45 = var_262_45 + 0.3

					if var_262_53 + var_262_45 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_53 + var_262_45
					end
				end

				arg_259_1.text_.text = var_262_50
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651063", "story_v_out_319651.awb") ~= 0 then
					local var_262_54 = manager.audio:GetVoiceLength("story_v_out_319651", "319651063", "story_v_out_319651.awb") / 1000

					if var_262_54 + var_262_45 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_54 + var_262_45
					end

					if var_262_49.prefab_name ~= "" and arg_259_1.actors_[var_262_49.prefab_name] ~= nil then
						local var_262_55 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_49.prefab_name].transform, "story_v_out_319651", "319651063", "story_v_out_319651.awb")

						arg_259_1:RecordAudio("319651063", var_262_55)
						arg_259_1:RecordAudio("319651063", var_262_55)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_319651", "319651063", "story_v_out_319651.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_319651", "319651063", "story_v_out_319651.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_56 = var_262_45 + 0.3
			local var_262_57 = math.max(var_262_46, arg_259_1.talkMaxDuration)

			if var_262_56 <= arg_259_1.time_ and arg_259_1.time_ < var_262_56 + var_262_57 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_56) / var_262_57

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_56 + var_262_57 and arg_259_1.time_ < var_262_56 + var_262_57 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_259_1:InitPlayNodeList()
	end,
	Play319651064 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 319651064
		arg_265_1.duration_ = 7.1

		local var_265_0 = {
			zh = 7.1,
			ja = 6.433
		}
		local var_265_1 = manager.audio:GetLocalizationFlag()

		if var_265_0[var_265_1] ~= nil then
			arg_265_1.duration_ = var_265_0[var_265_1]
		end

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play319651065(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = arg_265_1.actors_["10066ui_story"].transform
			local var_268_1 = 0

			if var_268_1 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 then
				arg_265_1.var_.moveOldPos10066ui_story = var_268_0.localPosition
			end

			local var_268_2 = 0.001

			if var_268_1 <= arg_265_1.time_ and arg_265_1.time_ < var_268_1 + var_268_2 then
				local var_268_3 = (arg_265_1.time_ - var_268_1) / var_268_2
				local var_268_4 = Vector3.New(0, -0.99, -5.83)

				var_268_0.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos10066ui_story, var_268_4, var_268_3)

				local var_268_5 = manager.ui.mainCamera.transform.position - var_268_0.position

				var_268_0.forward = Vector3.New(var_268_5.x, var_268_5.y, var_268_5.z)

				local var_268_6 = var_268_0.localEulerAngles

				var_268_6.z = 0
				var_268_6.x = 0
				var_268_0.localEulerAngles = var_268_6
			end

			if arg_265_1.time_ >= var_268_1 + var_268_2 and arg_265_1.time_ < var_268_1 + var_268_2 + arg_268_0 then
				var_268_0.localPosition = Vector3.New(0, -0.99, -5.83)

				local var_268_7 = manager.ui.mainCamera.transform.position - var_268_0.position

				var_268_0.forward = Vector3.New(var_268_7.x, var_268_7.y, var_268_7.z)

				local var_268_8 = var_268_0.localEulerAngles

				var_268_8.z = 0
				var_268_8.x = 0
				var_268_0.localEulerAngles = var_268_8
			end

			local var_268_9 = arg_265_1.actors_["10066ui_story"]
			local var_268_10 = 0

			if var_268_10 < arg_265_1.time_ and arg_265_1.time_ <= var_268_10 + arg_268_0 and not isNil(var_268_9) and arg_265_1.var_.characterEffect10066ui_story == nil then
				arg_265_1.var_.characterEffect10066ui_story = var_268_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_11 = 0.200000002980232

			if var_268_10 <= arg_265_1.time_ and arg_265_1.time_ < var_268_10 + var_268_11 and not isNil(var_268_9) then
				local var_268_12 = (arg_265_1.time_ - var_268_10) / var_268_11

				if arg_265_1.var_.characterEffect10066ui_story and not isNil(var_268_9) then
					arg_265_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_265_1.time_ >= var_268_10 + var_268_11 and arg_265_1.time_ < var_268_10 + var_268_11 + arg_268_0 and not isNil(var_268_9) and arg_265_1.var_.characterEffect10066ui_story then
				arg_265_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_268_13 = 0

			if var_268_13 < arg_265_1.time_ and arg_265_1.time_ <= var_268_13 + arg_268_0 then
				arg_265_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action6_1")
			end

			local var_268_14 = 0

			if var_268_14 < arg_265_1.time_ and arg_265_1.time_ <= var_268_14 + arg_268_0 then
				arg_265_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_268_15 = arg_265_1.actors_["10058ui_story"].transform
			local var_268_16 = 0

			if var_268_16 < arg_265_1.time_ and arg_265_1.time_ <= var_268_16 + arg_268_0 then
				arg_265_1.var_.moveOldPos10058ui_story = var_268_15.localPosition
			end

			local var_268_17 = 0.001

			if var_268_16 <= arg_265_1.time_ and arg_265_1.time_ < var_268_16 + var_268_17 then
				local var_268_18 = (arg_265_1.time_ - var_268_16) / var_268_17
				local var_268_19 = Vector3.New(0, 100, 0)

				var_268_15.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos10058ui_story, var_268_19, var_268_18)

				local var_268_20 = manager.ui.mainCamera.transform.position - var_268_15.position

				var_268_15.forward = Vector3.New(var_268_20.x, var_268_20.y, var_268_20.z)

				local var_268_21 = var_268_15.localEulerAngles

				var_268_21.z = 0
				var_268_21.x = 0
				var_268_15.localEulerAngles = var_268_21
			end

			if arg_265_1.time_ >= var_268_16 + var_268_17 and arg_265_1.time_ < var_268_16 + var_268_17 + arg_268_0 then
				var_268_15.localPosition = Vector3.New(0, 100, 0)

				local var_268_22 = manager.ui.mainCamera.transform.position - var_268_15.position

				var_268_15.forward = Vector3.New(var_268_22.x, var_268_22.y, var_268_22.z)

				local var_268_23 = var_268_15.localEulerAngles

				var_268_23.z = 0
				var_268_23.x = 0
				var_268_15.localEulerAngles = var_268_23
			end

			local var_268_24 = arg_265_1.actors_["10058ui_story"]
			local var_268_25 = 0

			if var_268_25 < arg_265_1.time_ and arg_265_1.time_ <= var_268_25 + arg_268_0 and not isNil(var_268_24) and arg_265_1.var_.characterEffect10058ui_story == nil then
				arg_265_1.var_.characterEffect10058ui_story = var_268_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_26 = 0.200000002980232

			if var_268_25 <= arg_265_1.time_ and arg_265_1.time_ < var_268_25 + var_268_26 and not isNil(var_268_24) then
				local var_268_27 = (arg_265_1.time_ - var_268_25) / var_268_26

				if arg_265_1.var_.characterEffect10058ui_story and not isNil(var_268_24) then
					local var_268_28 = Mathf.Lerp(0, 0.5, var_268_27)

					arg_265_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_265_1.var_.characterEffect10058ui_story.fillRatio = var_268_28
				end
			end

			if arg_265_1.time_ >= var_268_25 + var_268_26 and arg_265_1.time_ < var_268_25 + var_268_26 + arg_268_0 and not isNil(var_268_24) and arg_265_1.var_.characterEffect10058ui_story then
				local var_268_29 = 0.5

				arg_265_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_265_1.var_.characterEffect10058ui_story.fillRatio = var_268_29
			end

			local var_268_30 = 0
			local var_268_31 = 0.8

			if var_268_30 < arg_265_1.time_ and arg_265_1.time_ <= var_268_30 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_32 = arg_265_1:FormatText(StoryNameCfg[640].name)

				arg_265_1.leftNameTxt_.text = var_268_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_33 = arg_265_1:GetWordFromCfg(319651064)
				local var_268_34 = arg_265_1:FormatText(var_268_33.content)

				arg_265_1.text_.text = var_268_34

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_35 = 32
				local var_268_36 = utf8.len(var_268_34)
				local var_268_37 = var_268_35 <= 0 and var_268_31 or var_268_31 * (var_268_36 / var_268_35)

				if var_268_37 > 0 and var_268_31 < var_268_37 then
					arg_265_1.talkMaxDuration = var_268_37

					if var_268_37 + var_268_30 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_37 + var_268_30
					end
				end

				arg_265_1.text_.text = var_268_34
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651064", "story_v_out_319651.awb") ~= 0 then
					local var_268_38 = manager.audio:GetVoiceLength("story_v_out_319651", "319651064", "story_v_out_319651.awb") / 1000

					if var_268_38 + var_268_30 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_38 + var_268_30
					end

					if var_268_33.prefab_name ~= "" and arg_265_1.actors_[var_268_33.prefab_name] ~= nil then
						local var_268_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_33.prefab_name].transform, "story_v_out_319651", "319651064", "story_v_out_319651.awb")

						arg_265_1:RecordAudio("319651064", var_268_39)
						arg_265_1:RecordAudio("319651064", var_268_39)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_319651", "319651064", "story_v_out_319651.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_319651", "319651064", "story_v_out_319651.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_40 = math.max(var_268_31, arg_265_1.talkMaxDuration)

			if var_268_30 <= arg_265_1.time_ and arg_265_1.time_ < var_268_30 + var_268_40 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_30) / var_268_40

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_30 + var_268_40 and arg_265_1.time_ < var_268_30 + var_268_40 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_265_1:InitPlayNodeList()
	end,
	Play319651065 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 319651065
		arg_269_1.duration_ = 4.53

		local var_269_0 = {
			zh = 3.2,
			ja = 4.533
		}
		local var_269_1 = manager.audio:GetLocalizationFlag()

		if var_269_0[var_269_1] ~= nil then
			arg_269_1.duration_ = var_269_0[var_269_1]
		end

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play319651066(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = 0
			local var_272_1 = 0.425

			if var_272_0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_0 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_2 = arg_269_1:FormatText(StoryNameCfg[640].name)

				arg_269_1.leftNameTxt_.text = var_272_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_3 = arg_269_1:GetWordFromCfg(319651065)
				local var_272_4 = arg_269_1:FormatText(var_272_3.content)

				arg_269_1.text_.text = var_272_4

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_5 = 17
				local var_272_6 = utf8.len(var_272_4)
				local var_272_7 = var_272_5 <= 0 and var_272_1 or var_272_1 * (var_272_6 / var_272_5)

				if var_272_7 > 0 and var_272_1 < var_272_7 then
					arg_269_1.talkMaxDuration = var_272_7

					if var_272_7 + var_272_0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_7 + var_272_0
					end
				end

				arg_269_1.text_.text = var_272_4
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651065", "story_v_out_319651.awb") ~= 0 then
					local var_272_8 = manager.audio:GetVoiceLength("story_v_out_319651", "319651065", "story_v_out_319651.awb") / 1000

					if var_272_8 + var_272_0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_8 + var_272_0
					end

					if var_272_3.prefab_name ~= "" and arg_269_1.actors_[var_272_3.prefab_name] ~= nil then
						local var_272_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_3.prefab_name].transform, "story_v_out_319651", "319651065", "story_v_out_319651.awb")

						arg_269_1:RecordAudio("319651065", var_272_9)
						arg_269_1:RecordAudio("319651065", var_272_9)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_319651", "319651065", "story_v_out_319651.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_319651", "319651065", "story_v_out_319651.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_10 = math.max(var_272_1, arg_269_1.talkMaxDuration)

			if var_272_0 <= arg_269_1.time_ and arg_269_1.time_ < var_272_0 + var_272_10 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_0) / var_272_10

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_0 + var_272_10 and arg_269_1.time_ < var_272_0 + var_272_10 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play319651066 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 319651066
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play319651067(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = arg_273_1.actors_["10066ui_story"].transform
			local var_276_1 = 0

			if var_276_1 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 then
				arg_273_1.var_.moveOldPos10066ui_story = var_276_0.localPosition
			end

			local var_276_2 = 0.001

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_2 then
				local var_276_3 = (arg_273_1.time_ - var_276_1) / var_276_2
				local var_276_4 = Vector3.New(0, 100, 0)

				var_276_0.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos10066ui_story, var_276_4, var_276_3)

				local var_276_5 = manager.ui.mainCamera.transform.position - var_276_0.position

				var_276_0.forward = Vector3.New(var_276_5.x, var_276_5.y, var_276_5.z)

				local var_276_6 = var_276_0.localEulerAngles

				var_276_6.z = 0
				var_276_6.x = 0
				var_276_0.localEulerAngles = var_276_6
			end

			if arg_273_1.time_ >= var_276_1 + var_276_2 and arg_273_1.time_ < var_276_1 + var_276_2 + arg_276_0 then
				var_276_0.localPosition = Vector3.New(0, 100, 0)

				local var_276_7 = manager.ui.mainCamera.transform.position - var_276_0.position

				var_276_0.forward = Vector3.New(var_276_7.x, var_276_7.y, var_276_7.z)

				local var_276_8 = var_276_0.localEulerAngles

				var_276_8.z = 0
				var_276_8.x = 0
				var_276_0.localEulerAngles = var_276_8
			end

			local var_276_9 = 0
			local var_276_10 = 0.525

			if var_276_9 < arg_273_1.time_ and arg_273_1.time_ <= var_276_9 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, false)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_11 = arg_273_1:GetWordFromCfg(319651066)
				local var_276_12 = arg_273_1:FormatText(var_276_11.content)

				arg_273_1.text_.text = var_276_12

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_13 = 21
				local var_276_14 = utf8.len(var_276_12)
				local var_276_15 = var_276_13 <= 0 and var_276_10 or var_276_10 * (var_276_14 / var_276_13)

				if var_276_15 > 0 and var_276_10 < var_276_15 then
					arg_273_1.talkMaxDuration = var_276_15

					if var_276_15 + var_276_9 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_15 + var_276_9
					end
				end

				arg_273_1.text_.text = var_276_12
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_16 = math.max(var_276_10, arg_273_1.talkMaxDuration)

			if var_276_9 <= arg_273_1.time_ and arg_273_1.time_ < var_276_9 + var_276_16 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_9) / var_276_16

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_9 + var_276_16 and arg_273_1.time_ < var_276_9 + var_276_16 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_273_1:InitPlayNodeList()
	end,
	Play319651067 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 319651067
		arg_277_1.duration_ = 5.73

		local var_277_0 = {
			zh = 3.033,
			ja = 5.733
		}
		local var_277_1 = manager.audio:GetLocalizationFlag()

		if var_277_0[var_277_1] ~= nil then
			arg_277_1.duration_ = var_277_0[var_277_1]
		end

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play319651068(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = arg_277_1.actors_["10058ui_story"].transform
			local var_280_1 = 0

			if var_280_1 < arg_277_1.time_ and arg_277_1.time_ <= var_280_1 + arg_280_0 then
				arg_277_1.var_.moveOldPos10058ui_story = var_280_0.localPosition
			end

			local var_280_2 = 0.001

			if var_280_1 <= arg_277_1.time_ and arg_277_1.time_ < var_280_1 + var_280_2 then
				local var_280_3 = (arg_277_1.time_ - var_280_1) / var_280_2
				local var_280_4 = Vector3.New(0, -0.98, -6.1)

				var_280_0.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos10058ui_story, var_280_4, var_280_3)

				local var_280_5 = manager.ui.mainCamera.transform.position - var_280_0.position

				var_280_0.forward = Vector3.New(var_280_5.x, var_280_5.y, var_280_5.z)

				local var_280_6 = var_280_0.localEulerAngles

				var_280_6.z = 0
				var_280_6.x = 0
				var_280_0.localEulerAngles = var_280_6
			end

			if arg_277_1.time_ >= var_280_1 + var_280_2 and arg_277_1.time_ < var_280_1 + var_280_2 + arg_280_0 then
				var_280_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_280_7 = manager.ui.mainCamera.transform.position - var_280_0.position

				var_280_0.forward = Vector3.New(var_280_7.x, var_280_7.y, var_280_7.z)

				local var_280_8 = var_280_0.localEulerAngles

				var_280_8.z = 0
				var_280_8.x = 0
				var_280_0.localEulerAngles = var_280_8
			end

			local var_280_9 = arg_277_1.actors_["10058ui_story"]
			local var_280_10 = 0

			if var_280_10 < arg_277_1.time_ and arg_277_1.time_ <= var_280_10 + arg_280_0 and not isNil(var_280_9) and arg_277_1.var_.characterEffect10058ui_story == nil then
				arg_277_1.var_.characterEffect10058ui_story = var_280_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_11 = 0.200000002980232

			if var_280_10 <= arg_277_1.time_ and arg_277_1.time_ < var_280_10 + var_280_11 and not isNil(var_280_9) then
				local var_280_12 = (arg_277_1.time_ - var_280_10) / var_280_11

				if arg_277_1.var_.characterEffect10058ui_story and not isNil(var_280_9) then
					arg_277_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_277_1.time_ >= var_280_10 + var_280_11 and arg_277_1.time_ < var_280_10 + var_280_11 + arg_280_0 and not isNil(var_280_9) and arg_277_1.var_.characterEffect10058ui_story then
				arg_277_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_280_13 = 0

			if var_280_13 < arg_277_1.time_ and arg_277_1.time_ <= var_280_13 + arg_280_0 then
				arg_277_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_280_14 = 0

			if var_280_14 < arg_277_1.time_ and arg_277_1.time_ <= var_280_14 + arg_280_0 then
				arg_277_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_280_15 = 0
			local var_280_16 = 0.35

			if var_280_15 < arg_277_1.time_ and arg_277_1.time_ <= var_280_15 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_17 = arg_277_1:FormatText(StoryNameCfg[471].name)

				arg_277_1.leftNameTxt_.text = var_280_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_18 = arg_277_1:GetWordFromCfg(319651067)
				local var_280_19 = arg_277_1:FormatText(var_280_18.content)

				arg_277_1.text_.text = var_280_19

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_20 = 14
				local var_280_21 = utf8.len(var_280_19)
				local var_280_22 = var_280_20 <= 0 and var_280_16 or var_280_16 * (var_280_21 / var_280_20)

				if var_280_22 > 0 and var_280_16 < var_280_22 then
					arg_277_1.talkMaxDuration = var_280_22

					if var_280_22 + var_280_15 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_22 + var_280_15
					end
				end

				arg_277_1.text_.text = var_280_19
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651067", "story_v_out_319651.awb") ~= 0 then
					local var_280_23 = manager.audio:GetVoiceLength("story_v_out_319651", "319651067", "story_v_out_319651.awb") / 1000

					if var_280_23 + var_280_15 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_23 + var_280_15
					end

					if var_280_18.prefab_name ~= "" and arg_277_1.actors_[var_280_18.prefab_name] ~= nil then
						local var_280_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_18.prefab_name].transform, "story_v_out_319651", "319651067", "story_v_out_319651.awb")

						arg_277_1:RecordAudio("319651067", var_280_24)
						arg_277_1:RecordAudio("319651067", var_280_24)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_319651", "319651067", "story_v_out_319651.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_319651", "319651067", "story_v_out_319651.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_25 = math.max(var_280_16, arg_277_1.talkMaxDuration)

			if var_280_15 <= arg_277_1.time_ and arg_277_1.time_ < var_280_15 + var_280_25 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_15) / var_280_25

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_15 + var_280_25 and arg_277_1.time_ < var_280_15 + var_280_25 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_277_1:InitPlayNodeList()
	end,
	Play319651068 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 319651068
		arg_281_1.duration_ = 2.2

		local var_281_0 = {
			zh = 1.866,
			ja = 2.2
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
				arg_281_0:Play319651069(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = arg_281_1.actors_["1084ui_story"].transform
			local var_284_1 = 0

			if var_284_1 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 then
				arg_281_1.var_.moveOldPos1084ui_story = var_284_0.localPosition
			end

			local var_284_2 = 0.001

			if var_284_1 <= arg_281_1.time_ and arg_281_1.time_ < var_284_1 + var_284_2 then
				local var_284_3 = (arg_281_1.time_ - var_284_1) / var_284_2
				local var_284_4 = Vector3.New(0.7, -0.97, -6)

				var_284_0.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos1084ui_story, var_284_4, var_284_3)

				local var_284_5 = manager.ui.mainCamera.transform.position - var_284_0.position

				var_284_0.forward = Vector3.New(var_284_5.x, var_284_5.y, var_284_5.z)

				local var_284_6 = var_284_0.localEulerAngles

				var_284_6.z = 0
				var_284_6.x = 0
				var_284_0.localEulerAngles = var_284_6
			end

			if arg_281_1.time_ >= var_284_1 + var_284_2 and arg_281_1.time_ < var_284_1 + var_284_2 + arg_284_0 then
				var_284_0.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_284_7 = manager.ui.mainCamera.transform.position - var_284_0.position

				var_284_0.forward = Vector3.New(var_284_7.x, var_284_7.y, var_284_7.z)

				local var_284_8 = var_284_0.localEulerAngles

				var_284_8.z = 0
				var_284_8.x = 0
				var_284_0.localEulerAngles = var_284_8
			end

			local var_284_9 = arg_281_1.actors_["1084ui_story"]
			local var_284_10 = 0

			if var_284_10 < arg_281_1.time_ and arg_281_1.time_ <= var_284_10 + arg_284_0 and not isNil(var_284_9) and arg_281_1.var_.characterEffect1084ui_story == nil then
				arg_281_1.var_.characterEffect1084ui_story = var_284_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_11 = 0.200000002980232

			if var_284_10 <= arg_281_1.time_ and arg_281_1.time_ < var_284_10 + var_284_11 and not isNil(var_284_9) then
				local var_284_12 = (arg_281_1.time_ - var_284_10) / var_284_11

				if arg_281_1.var_.characterEffect1084ui_story and not isNil(var_284_9) then
					arg_281_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_281_1.time_ >= var_284_10 + var_284_11 and arg_281_1.time_ < var_284_10 + var_284_11 + arg_284_0 and not isNil(var_284_9) and arg_281_1.var_.characterEffect1084ui_story then
				arg_281_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_284_13 = 0

			if var_284_13 < arg_281_1.time_ and arg_281_1.time_ <= var_284_13 + arg_284_0 then
				arg_281_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_284_14 = 0

			if var_284_14 < arg_281_1.time_ and arg_281_1.time_ <= var_284_14 + arg_284_0 then
				arg_281_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_284_15 = arg_281_1.actors_["10058ui_story"].transform
			local var_284_16 = 0

			if var_284_16 < arg_281_1.time_ and arg_281_1.time_ <= var_284_16 + arg_284_0 then
				arg_281_1.var_.moveOldPos10058ui_story = var_284_15.localPosition
			end

			local var_284_17 = 0.001

			if var_284_16 <= arg_281_1.time_ and arg_281_1.time_ < var_284_16 + var_284_17 then
				local var_284_18 = (arg_281_1.time_ - var_284_16) / var_284_17
				local var_284_19 = Vector3.New(-0.7, -0.98, -6.1)

				var_284_15.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos10058ui_story, var_284_19, var_284_18)

				local var_284_20 = manager.ui.mainCamera.transform.position - var_284_15.position

				var_284_15.forward = Vector3.New(var_284_20.x, var_284_20.y, var_284_20.z)

				local var_284_21 = var_284_15.localEulerAngles

				var_284_21.z = 0
				var_284_21.x = 0
				var_284_15.localEulerAngles = var_284_21
			end

			if arg_281_1.time_ >= var_284_16 + var_284_17 and arg_281_1.time_ < var_284_16 + var_284_17 + arg_284_0 then
				var_284_15.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_284_22 = manager.ui.mainCamera.transform.position - var_284_15.position

				var_284_15.forward = Vector3.New(var_284_22.x, var_284_22.y, var_284_22.z)

				local var_284_23 = var_284_15.localEulerAngles

				var_284_23.z = 0
				var_284_23.x = 0
				var_284_15.localEulerAngles = var_284_23
			end

			local var_284_24 = arg_281_1.actors_["10058ui_story"]
			local var_284_25 = 0

			if var_284_25 < arg_281_1.time_ and arg_281_1.time_ <= var_284_25 + arg_284_0 and not isNil(var_284_24) and arg_281_1.var_.characterEffect10058ui_story == nil then
				arg_281_1.var_.characterEffect10058ui_story = var_284_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_26 = 0.200000002980232

			if var_284_25 <= arg_281_1.time_ and arg_281_1.time_ < var_284_25 + var_284_26 and not isNil(var_284_24) then
				local var_284_27 = (arg_281_1.time_ - var_284_25) / var_284_26

				if arg_281_1.var_.characterEffect10058ui_story and not isNil(var_284_24) then
					local var_284_28 = Mathf.Lerp(0, 0.5, var_284_27)

					arg_281_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_281_1.var_.characterEffect10058ui_story.fillRatio = var_284_28
				end
			end

			if arg_281_1.time_ >= var_284_25 + var_284_26 and arg_281_1.time_ < var_284_25 + var_284_26 + arg_284_0 and not isNil(var_284_24) and arg_281_1.var_.characterEffect10058ui_story then
				local var_284_29 = 0.5

				arg_281_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_281_1.var_.characterEffect10058ui_story.fillRatio = var_284_29
			end

			local var_284_30 = 0
			local var_284_31 = 0.15

			if var_284_30 < arg_281_1.time_ and arg_281_1.time_ <= var_284_30 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_32 = arg_281_1:FormatText(StoryNameCfg[6].name)

				arg_281_1.leftNameTxt_.text = var_284_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_33 = arg_281_1:GetWordFromCfg(319651068)
				local var_284_34 = arg_281_1:FormatText(var_284_33.content)

				arg_281_1.text_.text = var_284_34

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_35 = 6
				local var_284_36 = utf8.len(var_284_34)
				local var_284_37 = var_284_35 <= 0 and var_284_31 or var_284_31 * (var_284_36 / var_284_35)

				if var_284_37 > 0 and var_284_31 < var_284_37 then
					arg_281_1.talkMaxDuration = var_284_37

					if var_284_37 + var_284_30 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_37 + var_284_30
					end
				end

				arg_281_1.text_.text = var_284_34
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651068", "story_v_out_319651.awb") ~= 0 then
					local var_284_38 = manager.audio:GetVoiceLength("story_v_out_319651", "319651068", "story_v_out_319651.awb") / 1000

					if var_284_38 + var_284_30 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_38 + var_284_30
					end

					if var_284_33.prefab_name ~= "" and arg_281_1.actors_[var_284_33.prefab_name] ~= nil then
						local var_284_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_33.prefab_name].transform, "story_v_out_319651", "319651068", "story_v_out_319651.awb")

						arg_281_1:RecordAudio("319651068", var_284_39)
						arg_281_1:RecordAudio("319651068", var_284_39)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_319651", "319651068", "story_v_out_319651.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_319651", "319651068", "story_v_out_319651.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_40 = math.max(var_284_31, arg_281_1.talkMaxDuration)

			if var_284_30 <= arg_281_1.time_ and arg_281_1.time_ < var_284_30 + var_284_40 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_30) / var_284_40

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_30 + var_284_40 and arg_281_1.time_ < var_284_30 + var_284_40 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_281_1:InitPlayNodeList()
	end,
	Play319651069 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 319651069
		arg_285_1.duration_ = 4.17

		local var_285_0 = {
			zh = 4.166,
			ja = 2.9
		}
		local var_285_1 = manager.audio:GetLocalizationFlag()

		if var_285_0[var_285_1] ~= nil then
			arg_285_1.duration_ = var_285_0[var_285_1]
		end

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play319651070(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = arg_285_1.actors_["1084ui_story"]
			local var_288_1 = 0

			if var_288_1 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 and not isNil(var_288_0) and arg_285_1.var_.characterEffect1084ui_story == nil then
				arg_285_1.var_.characterEffect1084ui_story = var_288_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_2 = 0.200000002980232

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_2 and not isNil(var_288_0) then
				local var_288_3 = (arg_285_1.time_ - var_288_1) / var_288_2

				if arg_285_1.var_.characterEffect1084ui_story and not isNil(var_288_0) then
					local var_288_4 = Mathf.Lerp(0, 0.5, var_288_3)

					arg_285_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_285_1.var_.characterEffect1084ui_story.fillRatio = var_288_4
				end
			end

			if arg_285_1.time_ >= var_288_1 + var_288_2 and arg_285_1.time_ < var_288_1 + var_288_2 + arg_288_0 and not isNil(var_288_0) and arg_285_1.var_.characterEffect1084ui_story then
				local var_288_5 = 0.5

				arg_285_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_285_1.var_.characterEffect1084ui_story.fillRatio = var_288_5
			end

			local var_288_6 = arg_285_1.actors_["10058ui_story"]
			local var_288_7 = 0

			if var_288_7 < arg_285_1.time_ and arg_285_1.time_ <= var_288_7 + arg_288_0 and not isNil(var_288_6) and arg_285_1.var_.characterEffect10058ui_story == nil then
				arg_285_1.var_.characterEffect10058ui_story = var_288_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_8 = 0.200000002980232

			if var_288_7 <= arg_285_1.time_ and arg_285_1.time_ < var_288_7 + var_288_8 and not isNil(var_288_6) then
				local var_288_9 = (arg_285_1.time_ - var_288_7) / var_288_8

				if arg_285_1.var_.characterEffect10058ui_story and not isNil(var_288_6) then
					arg_285_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_285_1.time_ >= var_288_7 + var_288_8 and arg_285_1.time_ < var_288_7 + var_288_8 + arg_288_0 and not isNil(var_288_6) and arg_285_1.var_.characterEffect10058ui_story then
				arg_285_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_288_10 = 0
			local var_288_11 = 0.425

			if var_288_10 < arg_285_1.time_ and arg_285_1.time_ <= var_288_10 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_12 = arg_285_1:FormatText(StoryNameCfg[471].name)

				arg_285_1.leftNameTxt_.text = var_288_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_13 = arg_285_1:GetWordFromCfg(319651069)
				local var_288_14 = arg_285_1:FormatText(var_288_13.content)

				arg_285_1.text_.text = var_288_14

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_15 = 17
				local var_288_16 = utf8.len(var_288_14)
				local var_288_17 = var_288_15 <= 0 and var_288_11 or var_288_11 * (var_288_16 / var_288_15)

				if var_288_17 > 0 and var_288_11 < var_288_17 then
					arg_285_1.talkMaxDuration = var_288_17

					if var_288_17 + var_288_10 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_17 + var_288_10
					end
				end

				arg_285_1.text_.text = var_288_14
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651069", "story_v_out_319651.awb") ~= 0 then
					local var_288_18 = manager.audio:GetVoiceLength("story_v_out_319651", "319651069", "story_v_out_319651.awb") / 1000

					if var_288_18 + var_288_10 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_18 + var_288_10
					end

					if var_288_13.prefab_name ~= "" and arg_285_1.actors_[var_288_13.prefab_name] ~= nil then
						local var_288_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_13.prefab_name].transform, "story_v_out_319651", "319651069", "story_v_out_319651.awb")

						arg_285_1:RecordAudio("319651069", var_288_19)
						arg_285_1:RecordAudio("319651069", var_288_19)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_319651", "319651069", "story_v_out_319651.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_319651", "319651069", "story_v_out_319651.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_20 = math.max(var_288_11, arg_285_1.talkMaxDuration)

			if var_288_10 <= arg_285_1.time_ and arg_285_1.time_ < var_288_10 + var_288_20 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_10) / var_288_20

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_10 + var_288_20 and arg_285_1.time_ < var_288_10 + var_288_20 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play319651070 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 319651070
		arg_289_1.duration_ = 4.23

		local var_289_0 = {
			zh = 1.999999999999,
			ja = 4.233
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
				arg_289_0:Play319651071(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = arg_289_1.actors_["1084ui_story"].transform
			local var_292_1 = 0

			if var_292_1 < arg_289_1.time_ and arg_289_1.time_ <= var_292_1 + arg_292_0 then
				arg_289_1.var_.moveOldPos1084ui_story = var_292_0.localPosition
			end

			local var_292_2 = 0.001

			if var_292_1 <= arg_289_1.time_ and arg_289_1.time_ < var_292_1 + var_292_2 then
				local var_292_3 = (arg_289_1.time_ - var_292_1) / var_292_2
				local var_292_4 = Vector3.New(0.7, -0.97, -6)

				var_292_0.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos1084ui_story, var_292_4, var_292_3)

				local var_292_5 = manager.ui.mainCamera.transform.position - var_292_0.position

				var_292_0.forward = Vector3.New(var_292_5.x, var_292_5.y, var_292_5.z)

				local var_292_6 = var_292_0.localEulerAngles

				var_292_6.z = 0
				var_292_6.x = 0
				var_292_0.localEulerAngles = var_292_6
			end

			if arg_289_1.time_ >= var_292_1 + var_292_2 and arg_289_1.time_ < var_292_1 + var_292_2 + arg_292_0 then
				var_292_0.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_292_7 = manager.ui.mainCamera.transform.position - var_292_0.position

				var_292_0.forward = Vector3.New(var_292_7.x, var_292_7.y, var_292_7.z)

				local var_292_8 = var_292_0.localEulerAngles

				var_292_8.z = 0
				var_292_8.x = 0
				var_292_0.localEulerAngles = var_292_8
			end

			local var_292_9 = arg_289_1.actors_["1084ui_story"]
			local var_292_10 = 0

			if var_292_10 < arg_289_1.time_ and arg_289_1.time_ <= var_292_10 + arg_292_0 and not isNil(var_292_9) and arg_289_1.var_.characterEffect1084ui_story == nil then
				arg_289_1.var_.characterEffect1084ui_story = var_292_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_11 = 0.200000002980232

			if var_292_10 <= arg_289_1.time_ and arg_289_1.time_ < var_292_10 + var_292_11 and not isNil(var_292_9) then
				local var_292_12 = (arg_289_1.time_ - var_292_10) / var_292_11

				if arg_289_1.var_.characterEffect1084ui_story and not isNil(var_292_9) then
					arg_289_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_289_1.time_ >= var_292_10 + var_292_11 and arg_289_1.time_ < var_292_10 + var_292_11 + arg_292_0 and not isNil(var_292_9) and arg_289_1.var_.characterEffect1084ui_story then
				arg_289_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_292_13 = 0

			if var_292_13 < arg_289_1.time_ and arg_289_1.time_ <= var_292_13 + arg_292_0 then
				arg_289_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_1")
			end

			local var_292_14 = 0

			if var_292_14 < arg_289_1.time_ and arg_289_1.time_ <= var_292_14 + arg_292_0 then
				arg_289_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_292_15 = arg_289_1.actors_["10058ui_story"]
			local var_292_16 = 0

			if var_292_16 < arg_289_1.time_ and arg_289_1.time_ <= var_292_16 + arg_292_0 and not isNil(var_292_15) and arg_289_1.var_.characterEffect10058ui_story == nil then
				arg_289_1.var_.characterEffect10058ui_story = var_292_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_17 = 0.200000002980232

			if var_292_16 <= arg_289_1.time_ and arg_289_1.time_ < var_292_16 + var_292_17 and not isNil(var_292_15) then
				local var_292_18 = (arg_289_1.time_ - var_292_16) / var_292_17

				if arg_289_1.var_.characterEffect10058ui_story and not isNil(var_292_15) then
					local var_292_19 = Mathf.Lerp(0, 0.5, var_292_18)

					arg_289_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_289_1.var_.characterEffect10058ui_story.fillRatio = var_292_19
				end
			end

			if arg_289_1.time_ >= var_292_16 + var_292_17 and arg_289_1.time_ < var_292_16 + var_292_17 + arg_292_0 and not isNil(var_292_15) and arg_289_1.var_.characterEffect10058ui_story then
				local var_292_20 = 0.5

				arg_289_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_289_1.var_.characterEffect10058ui_story.fillRatio = var_292_20
			end

			local var_292_21 = 0
			local var_292_22 = 0.175

			if var_292_21 < arg_289_1.time_ and arg_289_1.time_ <= var_292_21 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				local var_292_23 = arg_289_1:FormatText(StoryNameCfg[6].name)

				arg_289_1.leftNameTxt_.text = var_292_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_24 = arg_289_1:GetWordFromCfg(319651070)
				local var_292_25 = arg_289_1:FormatText(var_292_24.content)

				arg_289_1.text_.text = var_292_25

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_26 = 7
				local var_292_27 = utf8.len(var_292_25)
				local var_292_28 = var_292_26 <= 0 and var_292_22 or var_292_22 * (var_292_27 / var_292_26)

				if var_292_28 > 0 and var_292_22 < var_292_28 then
					arg_289_1.talkMaxDuration = var_292_28

					if var_292_28 + var_292_21 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_28 + var_292_21
					end
				end

				arg_289_1.text_.text = var_292_25
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651070", "story_v_out_319651.awb") ~= 0 then
					local var_292_29 = manager.audio:GetVoiceLength("story_v_out_319651", "319651070", "story_v_out_319651.awb") / 1000

					if var_292_29 + var_292_21 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_29 + var_292_21
					end

					if var_292_24.prefab_name ~= "" and arg_289_1.actors_[var_292_24.prefab_name] ~= nil then
						local var_292_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_24.prefab_name].transform, "story_v_out_319651", "319651070", "story_v_out_319651.awb")

						arg_289_1:RecordAudio("319651070", var_292_30)
						arg_289_1:RecordAudio("319651070", var_292_30)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_319651", "319651070", "story_v_out_319651.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_319651", "319651070", "story_v_out_319651.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_31 = math.max(var_292_22, arg_289_1.talkMaxDuration)

			if var_292_21 <= arg_289_1.time_ and arg_289_1.time_ < var_292_21 + var_292_31 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_21) / var_292_31

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_21 + var_292_31 and arg_289_1.time_ < var_292_21 + var_292_31 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_289_1:InitPlayNodeList()
	end,
	Play319651071 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 319651071
		arg_293_1.duration_ = 6.8

		local var_293_0 = {
			zh = 6.8,
			ja = 3.7
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
				arg_293_0:Play319651072(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = arg_293_1.actors_["10058ui_story"].transform
			local var_296_1 = 0

			if var_296_1 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 then
				arg_293_1.var_.moveOldPos10058ui_story = var_296_0.localPosition
			end

			local var_296_2 = 0.001

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_2 then
				local var_296_3 = (arg_293_1.time_ - var_296_1) / var_296_2
				local var_296_4 = Vector3.New(-0.7, -0.98, -6.1)

				var_296_0.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos10058ui_story, var_296_4, var_296_3)

				local var_296_5 = manager.ui.mainCamera.transform.position - var_296_0.position

				var_296_0.forward = Vector3.New(var_296_5.x, var_296_5.y, var_296_5.z)

				local var_296_6 = var_296_0.localEulerAngles

				var_296_6.z = 0
				var_296_6.x = 0
				var_296_0.localEulerAngles = var_296_6
			end

			if arg_293_1.time_ >= var_296_1 + var_296_2 and arg_293_1.time_ < var_296_1 + var_296_2 + arg_296_0 then
				var_296_0.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_296_7 = manager.ui.mainCamera.transform.position - var_296_0.position

				var_296_0.forward = Vector3.New(var_296_7.x, var_296_7.y, var_296_7.z)

				local var_296_8 = var_296_0.localEulerAngles

				var_296_8.z = 0
				var_296_8.x = 0
				var_296_0.localEulerAngles = var_296_8
			end

			local var_296_9 = arg_293_1.actors_["10058ui_story"]
			local var_296_10 = 0

			if var_296_10 < arg_293_1.time_ and arg_293_1.time_ <= var_296_10 + arg_296_0 and not isNil(var_296_9) and arg_293_1.var_.characterEffect10058ui_story == nil then
				arg_293_1.var_.characterEffect10058ui_story = var_296_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_11 = 0.200000002980232

			if var_296_10 <= arg_293_1.time_ and arg_293_1.time_ < var_296_10 + var_296_11 and not isNil(var_296_9) then
				local var_296_12 = (arg_293_1.time_ - var_296_10) / var_296_11

				if arg_293_1.var_.characterEffect10058ui_story and not isNil(var_296_9) then
					arg_293_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_293_1.time_ >= var_296_10 + var_296_11 and arg_293_1.time_ < var_296_10 + var_296_11 + arg_296_0 and not isNil(var_296_9) and arg_293_1.var_.characterEffect10058ui_story then
				arg_293_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_296_13 = 0

			if var_296_13 < arg_293_1.time_ and arg_293_1.time_ <= var_296_13 + arg_296_0 then
				arg_293_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action7_1")
			end

			local var_296_14 = 0

			if var_296_14 < arg_293_1.time_ and arg_293_1.time_ <= var_296_14 + arg_296_0 then
				arg_293_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_296_15 = arg_293_1.actors_["1084ui_story"]
			local var_296_16 = 0

			if var_296_16 < arg_293_1.time_ and arg_293_1.time_ <= var_296_16 + arg_296_0 and not isNil(var_296_15) and arg_293_1.var_.characterEffect1084ui_story == nil then
				arg_293_1.var_.characterEffect1084ui_story = var_296_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_17 = 0.200000002980232

			if var_296_16 <= arg_293_1.time_ and arg_293_1.time_ < var_296_16 + var_296_17 and not isNil(var_296_15) then
				local var_296_18 = (arg_293_1.time_ - var_296_16) / var_296_17

				if arg_293_1.var_.characterEffect1084ui_story and not isNil(var_296_15) then
					local var_296_19 = Mathf.Lerp(0, 0.5, var_296_18)

					arg_293_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_293_1.var_.characterEffect1084ui_story.fillRatio = var_296_19
				end
			end

			if arg_293_1.time_ >= var_296_16 + var_296_17 and arg_293_1.time_ < var_296_16 + var_296_17 + arg_296_0 and not isNil(var_296_15) and arg_293_1.var_.characterEffect1084ui_story then
				local var_296_20 = 0.5

				arg_293_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_293_1.var_.characterEffect1084ui_story.fillRatio = var_296_20
			end

			local var_296_21 = 0
			local var_296_22 = 0.825

			if var_296_21 < arg_293_1.time_ and arg_293_1.time_ <= var_296_21 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				local var_296_23 = arg_293_1:FormatText(StoryNameCfg[471].name)

				arg_293_1.leftNameTxt_.text = var_296_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_24 = arg_293_1:GetWordFromCfg(319651071)
				local var_296_25 = arg_293_1:FormatText(var_296_24.content)

				arg_293_1.text_.text = var_296_25

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_26 = 33
				local var_296_27 = utf8.len(var_296_25)
				local var_296_28 = var_296_26 <= 0 and var_296_22 or var_296_22 * (var_296_27 / var_296_26)

				if var_296_28 > 0 and var_296_22 < var_296_28 then
					arg_293_1.talkMaxDuration = var_296_28

					if var_296_28 + var_296_21 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_28 + var_296_21
					end
				end

				arg_293_1.text_.text = var_296_25
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651071", "story_v_out_319651.awb") ~= 0 then
					local var_296_29 = manager.audio:GetVoiceLength("story_v_out_319651", "319651071", "story_v_out_319651.awb") / 1000

					if var_296_29 + var_296_21 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_29 + var_296_21
					end

					if var_296_24.prefab_name ~= "" and arg_293_1.actors_[var_296_24.prefab_name] ~= nil then
						local var_296_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_24.prefab_name].transform, "story_v_out_319651", "319651071", "story_v_out_319651.awb")

						arg_293_1:RecordAudio("319651071", var_296_30)
						arg_293_1:RecordAudio("319651071", var_296_30)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_319651", "319651071", "story_v_out_319651.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_319651", "319651071", "story_v_out_319651.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_31 = math.max(var_296_22, arg_293_1.talkMaxDuration)

			if var_296_21 <= arg_293_1.time_ and arg_293_1.time_ < var_296_21 + var_296_31 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_21) / var_296_31

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_21 + var_296_31 and arg_293_1.time_ < var_296_21 + var_296_31 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_293_1:InitPlayNodeList()
	end,
	Play319651072 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 319651072
		arg_297_1.duration_ = 10.77

		local var_297_0 = {
			zh = 7.333,
			ja = 10.766
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
				arg_297_0:Play319651073(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = 0
			local var_300_1 = 0.925

			if var_300_0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_0 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				local var_300_2 = arg_297_1:FormatText(StoryNameCfg[471].name)

				arg_297_1.leftNameTxt_.text = var_300_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_3 = arg_297_1:GetWordFromCfg(319651072)
				local var_300_4 = arg_297_1:FormatText(var_300_3.content)

				arg_297_1.text_.text = var_300_4

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_5 = 37
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

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651072", "story_v_out_319651.awb") ~= 0 then
					local var_300_8 = manager.audio:GetVoiceLength("story_v_out_319651", "319651072", "story_v_out_319651.awb") / 1000

					if var_300_8 + var_300_0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_8 + var_300_0
					end

					if var_300_3.prefab_name ~= "" and arg_297_1.actors_[var_300_3.prefab_name] ~= nil then
						local var_300_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_3.prefab_name].transform, "story_v_out_319651", "319651072", "story_v_out_319651.awb")

						arg_297_1:RecordAudio("319651072", var_300_9)
						arg_297_1:RecordAudio("319651072", var_300_9)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_319651", "319651072", "story_v_out_319651.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_319651", "319651072", "story_v_out_319651.awb")
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
	Play319651073 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 319651073
		arg_301_1.duration_ = 2

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play319651074(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = arg_301_1.actors_["1084ui_story"].transform
			local var_304_1 = 0

			if var_304_1 < arg_301_1.time_ and arg_301_1.time_ <= var_304_1 + arg_304_0 then
				arg_301_1.var_.moveOldPos1084ui_story = var_304_0.localPosition
			end

			local var_304_2 = 0.001

			if var_304_1 <= arg_301_1.time_ and arg_301_1.time_ < var_304_1 + var_304_2 then
				local var_304_3 = (arg_301_1.time_ - var_304_1) / var_304_2
				local var_304_4 = Vector3.New(0.7, -0.97, -6)

				var_304_0.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos1084ui_story, var_304_4, var_304_3)

				local var_304_5 = manager.ui.mainCamera.transform.position - var_304_0.position

				var_304_0.forward = Vector3.New(var_304_5.x, var_304_5.y, var_304_5.z)

				local var_304_6 = var_304_0.localEulerAngles

				var_304_6.z = 0
				var_304_6.x = 0
				var_304_0.localEulerAngles = var_304_6
			end

			if arg_301_1.time_ >= var_304_1 + var_304_2 and arg_301_1.time_ < var_304_1 + var_304_2 + arg_304_0 then
				var_304_0.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_304_7 = manager.ui.mainCamera.transform.position - var_304_0.position

				var_304_0.forward = Vector3.New(var_304_7.x, var_304_7.y, var_304_7.z)

				local var_304_8 = var_304_0.localEulerAngles

				var_304_8.z = 0
				var_304_8.x = 0
				var_304_0.localEulerAngles = var_304_8
			end

			local var_304_9 = arg_301_1.actors_["1084ui_story"]
			local var_304_10 = 0

			if var_304_10 < arg_301_1.time_ and arg_301_1.time_ <= var_304_10 + arg_304_0 and not isNil(var_304_9) and arg_301_1.var_.characterEffect1084ui_story == nil then
				arg_301_1.var_.characterEffect1084ui_story = var_304_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_11 = 0.200000002980232

			if var_304_10 <= arg_301_1.time_ and arg_301_1.time_ < var_304_10 + var_304_11 and not isNil(var_304_9) then
				local var_304_12 = (arg_301_1.time_ - var_304_10) / var_304_11

				if arg_301_1.var_.characterEffect1084ui_story and not isNil(var_304_9) then
					arg_301_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_301_1.time_ >= var_304_10 + var_304_11 and arg_301_1.time_ < var_304_10 + var_304_11 + arg_304_0 and not isNil(var_304_9) and arg_301_1.var_.characterEffect1084ui_story then
				arg_301_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_304_13 = 0

			if var_304_13 < arg_301_1.time_ and arg_301_1.time_ <= var_304_13 + arg_304_0 then
				arg_301_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_2")
			end

			local var_304_14 = 0

			if var_304_14 < arg_301_1.time_ and arg_301_1.time_ <= var_304_14 + arg_304_0 then
				arg_301_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_304_15 = arg_301_1.actors_["10058ui_story"]
			local var_304_16 = 0

			if var_304_16 < arg_301_1.time_ and arg_301_1.time_ <= var_304_16 + arg_304_0 and not isNil(var_304_15) and arg_301_1.var_.characterEffect10058ui_story == nil then
				arg_301_1.var_.characterEffect10058ui_story = var_304_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_17 = 0.200000002980232

			if var_304_16 <= arg_301_1.time_ and arg_301_1.time_ < var_304_16 + var_304_17 and not isNil(var_304_15) then
				local var_304_18 = (arg_301_1.time_ - var_304_16) / var_304_17

				if arg_301_1.var_.characterEffect10058ui_story and not isNil(var_304_15) then
					local var_304_19 = Mathf.Lerp(0, 0.5, var_304_18)

					arg_301_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_301_1.var_.characterEffect10058ui_story.fillRatio = var_304_19
				end
			end

			if arg_301_1.time_ >= var_304_16 + var_304_17 and arg_301_1.time_ < var_304_16 + var_304_17 + arg_304_0 and not isNil(var_304_15) and arg_301_1.var_.characterEffect10058ui_story then
				local var_304_20 = 0.5

				arg_301_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_301_1.var_.characterEffect10058ui_story.fillRatio = var_304_20
			end

			local var_304_21 = 0
			local var_304_22 = 0.075

			if var_304_21 < arg_301_1.time_ and arg_301_1.time_ <= var_304_21 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				local var_304_23 = arg_301_1:FormatText(StoryNameCfg[6].name)

				arg_301_1.leftNameTxt_.text = var_304_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_24 = arg_301_1:GetWordFromCfg(319651073)
				local var_304_25 = arg_301_1:FormatText(var_304_24.content)

				arg_301_1.text_.text = var_304_25

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_26 = 3
				local var_304_27 = utf8.len(var_304_25)
				local var_304_28 = var_304_26 <= 0 and var_304_22 or var_304_22 * (var_304_27 / var_304_26)

				if var_304_28 > 0 and var_304_22 < var_304_28 then
					arg_301_1.talkMaxDuration = var_304_28

					if var_304_28 + var_304_21 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_28 + var_304_21
					end
				end

				arg_301_1.text_.text = var_304_25
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651073", "story_v_out_319651.awb") ~= 0 then
					local var_304_29 = manager.audio:GetVoiceLength("story_v_out_319651", "319651073", "story_v_out_319651.awb") / 1000

					if var_304_29 + var_304_21 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_29 + var_304_21
					end

					if var_304_24.prefab_name ~= "" and arg_301_1.actors_[var_304_24.prefab_name] ~= nil then
						local var_304_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_24.prefab_name].transform, "story_v_out_319651", "319651073", "story_v_out_319651.awb")

						arg_301_1:RecordAudio("319651073", var_304_30)
						arg_301_1:RecordAudio("319651073", var_304_30)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_319651", "319651073", "story_v_out_319651.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_319651", "319651073", "story_v_out_319651.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_31 = math.max(var_304_22, arg_301_1.talkMaxDuration)

			if var_304_21 <= arg_301_1.time_ and arg_301_1.time_ < var_304_21 + var_304_31 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_21) / var_304_31

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_21 + var_304_31 and arg_301_1.time_ < var_304_21 + var_304_31 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_301_1:InitPlayNodeList()
	end,
	Play319651074 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 319651074
		arg_305_1.duration_ = 2.2

		local var_305_0 = {
			zh = 2.2,
			ja = 1.999999999999
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
				arg_305_0:Play319651075(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = arg_305_1.actors_["1084ui_story"]
			local var_308_1 = 0

			if var_308_1 < arg_305_1.time_ and arg_305_1.time_ <= var_308_1 + arg_308_0 and not isNil(var_308_0) and arg_305_1.var_.characterEffect1084ui_story == nil then
				arg_305_1.var_.characterEffect1084ui_story = var_308_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_2 = 0.200000002980232

			if var_308_1 <= arg_305_1.time_ and arg_305_1.time_ < var_308_1 + var_308_2 and not isNil(var_308_0) then
				local var_308_3 = (arg_305_1.time_ - var_308_1) / var_308_2

				if arg_305_1.var_.characterEffect1084ui_story and not isNil(var_308_0) then
					local var_308_4 = Mathf.Lerp(0, 0.5, var_308_3)

					arg_305_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_305_1.var_.characterEffect1084ui_story.fillRatio = var_308_4
				end
			end

			if arg_305_1.time_ >= var_308_1 + var_308_2 and arg_305_1.time_ < var_308_1 + var_308_2 + arg_308_0 and not isNil(var_308_0) and arg_305_1.var_.characterEffect1084ui_story then
				local var_308_5 = 0.5

				arg_305_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_305_1.var_.characterEffect1084ui_story.fillRatio = var_308_5
			end

			local var_308_6 = arg_305_1.actors_["10058ui_story"]
			local var_308_7 = 0

			if var_308_7 < arg_305_1.time_ and arg_305_1.time_ <= var_308_7 + arg_308_0 and not isNil(var_308_6) and arg_305_1.var_.characterEffect10058ui_story == nil then
				arg_305_1.var_.characterEffect10058ui_story = var_308_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_8 = 0.200000002980232

			if var_308_7 <= arg_305_1.time_ and arg_305_1.time_ < var_308_7 + var_308_8 and not isNil(var_308_6) then
				local var_308_9 = (arg_305_1.time_ - var_308_7) / var_308_8

				if arg_305_1.var_.characterEffect10058ui_story and not isNil(var_308_6) then
					arg_305_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_305_1.time_ >= var_308_7 + var_308_8 and arg_305_1.time_ < var_308_7 + var_308_8 + arg_308_0 and not isNil(var_308_6) and arg_305_1.var_.characterEffect10058ui_story then
				arg_305_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_308_10 = 0

			if var_308_10 < arg_305_1.time_ and arg_305_1.time_ <= var_308_10 + arg_308_0 then
				arg_305_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action7_2")
			end

			local var_308_11 = 0

			if var_308_11 < arg_305_1.time_ and arg_305_1.time_ <= var_308_11 + arg_308_0 then
				arg_305_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_308_12 = 0
			local var_308_13 = 0.2

			if var_308_12 < arg_305_1.time_ and arg_305_1.time_ <= var_308_12 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				local var_308_14 = arg_305_1:FormatText(StoryNameCfg[471].name)

				arg_305_1.leftNameTxt_.text = var_308_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_15 = arg_305_1:GetWordFromCfg(319651074)
				local var_308_16 = arg_305_1:FormatText(var_308_15.content)

				arg_305_1.text_.text = var_308_16

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_17 = 8
				local var_308_18 = utf8.len(var_308_16)
				local var_308_19 = var_308_17 <= 0 and var_308_13 or var_308_13 * (var_308_18 / var_308_17)

				if var_308_19 > 0 and var_308_13 < var_308_19 then
					arg_305_1.talkMaxDuration = var_308_19

					if var_308_19 + var_308_12 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_19 + var_308_12
					end
				end

				arg_305_1.text_.text = var_308_16
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651074", "story_v_out_319651.awb") ~= 0 then
					local var_308_20 = manager.audio:GetVoiceLength("story_v_out_319651", "319651074", "story_v_out_319651.awb") / 1000

					if var_308_20 + var_308_12 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_20 + var_308_12
					end

					if var_308_15.prefab_name ~= "" and arg_305_1.actors_[var_308_15.prefab_name] ~= nil then
						local var_308_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_15.prefab_name].transform, "story_v_out_319651", "319651074", "story_v_out_319651.awb")

						arg_305_1:RecordAudio("319651074", var_308_21)
						arg_305_1:RecordAudio("319651074", var_308_21)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_319651", "319651074", "story_v_out_319651.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_319651", "319651074", "story_v_out_319651.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_22 = math.max(var_308_13, arg_305_1.talkMaxDuration)

			if var_308_12 <= arg_305_1.time_ and arg_305_1.time_ < var_308_12 + var_308_22 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_12) / var_308_22

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_12 + var_308_22 and arg_305_1.time_ < var_308_12 + var_308_22 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play319651075 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 319651075
		arg_309_1.duration_ = 8.97

		local var_309_0 = {
			zh = 6.333,
			ja = 8.966
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
				arg_309_0:Play319651076(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = arg_309_1.actors_["10058ui_story"]
			local var_312_1 = 0

			if var_312_1 < arg_309_1.time_ and arg_309_1.time_ <= var_312_1 + arg_312_0 and not isNil(var_312_0) and arg_309_1.var_.characterEffect10058ui_story == nil then
				arg_309_1.var_.characterEffect10058ui_story = var_312_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_2 = 0.200000002980232

			if var_312_1 <= arg_309_1.time_ and arg_309_1.time_ < var_312_1 + var_312_2 and not isNil(var_312_0) then
				local var_312_3 = (arg_309_1.time_ - var_312_1) / var_312_2

				if arg_309_1.var_.characterEffect10058ui_story and not isNil(var_312_0) then
					local var_312_4 = Mathf.Lerp(0, 0.5, var_312_3)

					arg_309_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_309_1.var_.characterEffect10058ui_story.fillRatio = var_312_4
				end
			end

			if arg_309_1.time_ >= var_312_1 + var_312_2 and arg_309_1.time_ < var_312_1 + var_312_2 + arg_312_0 and not isNil(var_312_0) and arg_309_1.var_.characterEffect10058ui_story then
				local var_312_5 = 0.5

				arg_309_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_309_1.var_.characterEffect10058ui_story.fillRatio = var_312_5
			end

			local var_312_6 = arg_309_1.actors_["1084ui_story"]
			local var_312_7 = 0

			if var_312_7 < arg_309_1.time_ and arg_309_1.time_ <= var_312_7 + arg_312_0 and not isNil(var_312_6) and arg_309_1.var_.characterEffect1084ui_story == nil then
				arg_309_1.var_.characterEffect1084ui_story = var_312_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_8 = 0.200000002980232

			if var_312_7 <= arg_309_1.time_ and arg_309_1.time_ < var_312_7 + var_312_8 and not isNil(var_312_6) then
				local var_312_9 = (arg_309_1.time_ - var_312_7) / var_312_8

				if arg_309_1.var_.characterEffect1084ui_story and not isNil(var_312_6) then
					arg_309_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_309_1.time_ >= var_312_7 + var_312_8 and arg_309_1.time_ < var_312_7 + var_312_8 + arg_312_0 and not isNil(var_312_6) and arg_309_1.var_.characterEffect1084ui_story then
				arg_309_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_312_10 = 0

			if var_312_10 < arg_309_1.time_ and arg_309_1.time_ <= var_312_10 + arg_312_0 then
				arg_309_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			local var_312_11 = 0

			if var_312_11 < arg_309_1.time_ and arg_309_1.time_ <= var_312_11 + arg_312_0 then
				arg_309_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_312_12 = 0
			local var_312_13 = 0.75

			if var_312_12 < arg_309_1.time_ and arg_309_1.time_ <= var_312_12 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				local var_312_14 = arg_309_1:FormatText(StoryNameCfg[6].name)

				arg_309_1.leftNameTxt_.text = var_312_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_15 = arg_309_1:GetWordFromCfg(319651075)
				local var_312_16 = arg_309_1:FormatText(var_312_15.content)

				arg_309_1.text_.text = var_312_16

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_17 = 30
				local var_312_18 = utf8.len(var_312_16)
				local var_312_19 = var_312_17 <= 0 and var_312_13 or var_312_13 * (var_312_18 / var_312_17)

				if var_312_19 > 0 and var_312_13 < var_312_19 then
					arg_309_1.talkMaxDuration = var_312_19

					if var_312_19 + var_312_12 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_19 + var_312_12
					end
				end

				arg_309_1.text_.text = var_312_16
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651075", "story_v_out_319651.awb") ~= 0 then
					local var_312_20 = manager.audio:GetVoiceLength("story_v_out_319651", "319651075", "story_v_out_319651.awb") / 1000

					if var_312_20 + var_312_12 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_20 + var_312_12
					end

					if var_312_15.prefab_name ~= "" and arg_309_1.actors_[var_312_15.prefab_name] ~= nil then
						local var_312_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_15.prefab_name].transform, "story_v_out_319651", "319651075", "story_v_out_319651.awb")

						arg_309_1:RecordAudio("319651075", var_312_21)
						arg_309_1:RecordAudio("319651075", var_312_21)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_319651", "319651075", "story_v_out_319651.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_319651", "319651075", "story_v_out_319651.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_22 = math.max(var_312_13, arg_309_1.talkMaxDuration)

			if var_312_12 <= arg_309_1.time_ and arg_309_1.time_ < var_312_12 + var_312_22 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_12) / var_312_22

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_12 + var_312_22 and arg_309_1.time_ < var_312_12 + var_312_22 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play319651076 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 319651076
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play319651077(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = arg_313_1.actors_["1084ui_story"]
			local var_316_1 = 0

			if var_316_1 < arg_313_1.time_ and arg_313_1.time_ <= var_316_1 + arg_316_0 and not isNil(var_316_0) and arg_313_1.var_.characterEffect1084ui_story == nil then
				arg_313_1.var_.characterEffect1084ui_story = var_316_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_2 = 0.200000002980232

			if var_316_1 <= arg_313_1.time_ and arg_313_1.time_ < var_316_1 + var_316_2 and not isNil(var_316_0) then
				local var_316_3 = (arg_313_1.time_ - var_316_1) / var_316_2

				if arg_313_1.var_.characterEffect1084ui_story and not isNil(var_316_0) then
					local var_316_4 = Mathf.Lerp(0, 0.5, var_316_3)

					arg_313_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_313_1.var_.characterEffect1084ui_story.fillRatio = var_316_4
				end
			end

			if arg_313_1.time_ >= var_316_1 + var_316_2 and arg_313_1.time_ < var_316_1 + var_316_2 + arg_316_0 and not isNil(var_316_0) and arg_313_1.var_.characterEffect1084ui_story then
				local var_316_5 = 0.5

				arg_313_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_313_1.var_.characterEffect1084ui_story.fillRatio = var_316_5
			end

			local var_316_6 = 0
			local var_316_7 = 0.8

			if var_316_6 < arg_313_1.time_ and arg_313_1.time_ <= var_316_6 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, false)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_8 = arg_313_1:GetWordFromCfg(319651076)
				local var_316_9 = arg_313_1:FormatText(var_316_8.content)

				arg_313_1.text_.text = var_316_9

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_10 = 32
				local var_316_11 = utf8.len(var_316_9)
				local var_316_12 = var_316_10 <= 0 and var_316_7 or var_316_7 * (var_316_11 / var_316_10)

				if var_316_12 > 0 and var_316_7 < var_316_12 then
					arg_313_1.talkMaxDuration = var_316_12

					if var_316_12 + var_316_6 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_12 + var_316_6
					end
				end

				arg_313_1.text_.text = var_316_9
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_13 = math.max(var_316_7, arg_313_1.talkMaxDuration)

			if var_316_6 <= arg_313_1.time_ and arg_313_1.time_ < var_316_6 + var_316_13 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_6) / var_316_13

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_6 + var_316_13 and arg_313_1.time_ < var_316_6 + var_316_13 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play319651077 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 319651077
		arg_317_1.duration_ = 8.17

		local var_317_0 = {
			zh = 8.16666666666667,
			ja = 6.76666666666667
		}
		local var_317_1 = manager.audio:GetLocalizationFlag()

		if var_317_0[var_317_1] ~= nil then
			arg_317_1.duration_ = var_317_0[var_317_1]
		end

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
			arg_317_1.auto_ = false
		end

		function arg_317_1.playNext_(arg_319_0)
			arg_317_1.onStoryFinished_()
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = arg_317_1.actors_["10058ui_story"].transform
			local var_320_1 = 0

			if var_320_1 < arg_317_1.time_ and arg_317_1.time_ <= var_320_1 + arg_320_0 then
				arg_317_1.var_.moveOldPos10058ui_story = var_320_0.localPosition
			end

			local var_320_2 = 0.001

			if var_320_1 <= arg_317_1.time_ and arg_317_1.time_ < var_320_1 + var_320_2 then
				local var_320_3 = (arg_317_1.time_ - var_320_1) / var_320_2
				local var_320_4 = Vector3.New(-0.7, -0.98, -6.1)

				var_320_0.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos10058ui_story, var_320_4, var_320_3)

				local var_320_5 = manager.ui.mainCamera.transform.position - var_320_0.position

				var_320_0.forward = Vector3.New(var_320_5.x, var_320_5.y, var_320_5.z)

				local var_320_6 = var_320_0.localEulerAngles

				var_320_6.z = 0
				var_320_6.x = 0
				var_320_0.localEulerAngles = var_320_6
			end

			if arg_317_1.time_ >= var_320_1 + var_320_2 and arg_317_1.time_ < var_320_1 + var_320_2 + arg_320_0 then
				var_320_0.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_320_7 = manager.ui.mainCamera.transform.position - var_320_0.position

				var_320_0.forward = Vector3.New(var_320_7.x, var_320_7.y, var_320_7.z)

				local var_320_8 = var_320_0.localEulerAngles

				var_320_8.z = 0
				var_320_8.x = 0
				var_320_0.localEulerAngles = var_320_8
			end

			local var_320_9 = arg_317_1.actors_["10058ui_story"]
			local var_320_10 = 0

			if var_320_10 < arg_317_1.time_ and arg_317_1.time_ <= var_320_10 + arg_320_0 and not isNil(var_320_9) and arg_317_1.var_.characterEffect10058ui_story == nil then
				arg_317_1.var_.characterEffect10058ui_story = var_320_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_11 = 0.200000002980232

			if var_320_10 <= arg_317_1.time_ and arg_317_1.time_ < var_320_10 + var_320_11 and not isNil(var_320_9) then
				local var_320_12 = (arg_317_1.time_ - var_320_10) / var_320_11

				if arg_317_1.var_.characterEffect10058ui_story and not isNil(var_320_9) then
					arg_317_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_317_1.time_ >= var_320_10 + var_320_11 and arg_317_1.time_ < var_320_10 + var_320_11 + arg_320_0 and not isNil(var_320_9) and arg_317_1.var_.characterEffect10058ui_story then
				arg_317_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_320_13 = 0

			if var_320_13 < arg_317_1.time_ and arg_317_1.time_ <= var_320_13 + arg_320_0 then
				arg_317_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action5_1")
			end

			local var_320_14 = 0

			if var_320_14 < arg_317_1.time_ and arg_317_1.time_ <= var_320_14 + arg_320_0 then
				arg_317_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			if arg_317_1.frameCnt_ <= 1 then
				arg_317_1.dialog_:SetActive(false)
			end

			local var_320_15 = 1.16666666666667
			local var_320_16 = 0.7

			if var_320_15 < arg_317_1.time_ and arg_317_1.time_ <= var_320_15 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0

				arg_317_1.dialog_:SetActive(true)

				arg_317_1.dialogCg_.alpha = 0

				local var_320_17 = LeanTween.value(arg_317_1.dialog_, 0, 1, 0.3)

				var_320_17:setOnUpdate(LuaHelper.FloatAction(function(arg_321_0)
					arg_317_1.dialogCg_.alpha = arg_321_0
				end))
				var_320_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_317_1.dialog_)
					var_320_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_317_1.duration_ = arg_317_1.duration_ + 0.3

				SetActive(arg_317_1.leftNameGo_, true)

				local var_320_18 = arg_317_1:FormatText(StoryNameCfg[471].name)

				arg_317_1.leftNameTxt_.text = var_320_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_19 = arg_317_1:GetWordFromCfg(319651077)
				local var_320_20 = arg_317_1:FormatText(var_320_19.content)

				arg_317_1.text_.text = var_320_20

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_21 = 28
				local var_320_22 = utf8.len(var_320_20)
				local var_320_23 = var_320_21 <= 0 and var_320_16 or var_320_16 * (var_320_22 / var_320_21)

				if var_320_23 > 0 and var_320_16 < var_320_23 then
					arg_317_1.talkMaxDuration = var_320_23
					var_320_15 = var_320_15 + 0.3

					if var_320_23 + var_320_15 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_23 + var_320_15
					end
				end

				arg_317_1.text_.text = var_320_20
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651077", "story_v_out_319651.awb") ~= 0 then
					local var_320_24 = manager.audio:GetVoiceLength("story_v_out_319651", "319651077", "story_v_out_319651.awb") / 1000

					if var_320_24 + var_320_15 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_24 + var_320_15
					end

					if var_320_19.prefab_name ~= "" and arg_317_1.actors_[var_320_19.prefab_name] ~= nil then
						local var_320_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_19.prefab_name].transform, "story_v_out_319651", "319651077", "story_v_out_319651.awb")

						arg_317_1:RecordAudio("319651077", var_320_25)
						arg_317_1:RecordAudio("319651077", var_320_25)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_319651", "319651077", "story_v_out_319651.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_319651", "319651077", "story_v_out_319651.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_26 = var_320_15 + 0.3
			local var_320_27 = math.max(var_320_16, arg_317_1.talkMaxDuration)

			if var_320_26 <= arg_317_1.time_ and arg_317_1.time_ < var_320_26 + var_320_27 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_26) / var_320_27

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_26 + var_320_27 and arg_317_1.time_ < var_320_26 + var_320_27 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_317_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST74",
		"TextureConfig/Background/ML0201",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_319651.awb"
	}
}
