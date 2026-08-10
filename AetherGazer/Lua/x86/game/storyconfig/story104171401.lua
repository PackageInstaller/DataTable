return {
	Play417141001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 417141001
		arg_1_1.duration_ = 2.87

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play417141002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 1

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				arg_1_1.fswbg_:SetActive(true)
				arg_1_1.dialog_:SetActive(false)

				arg_1_1.fswtw_.percent = 0

				local var_4_1 = arg_1_1:GetWordFromCfg(417141001)
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

			local var_4_3 = 1.1

			if var_4_3 < arg_1_1.time_ and arg_1_1.time_ <= var_4_3 + arg_4_0 then
				arg_1_1.var_.oldValueTypewriter = arg_1_1.fswtw_.percent

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_4 = 8
			local var_4_5 = 0.533333333333333
			local var_4_6 = arg_1_1:GetWordFromCfg(417141001)
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

			local var_4_11 = 0.533333333333333
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

			local var_4_14 = 1

			if var_4_14 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				local var_4_15 = arg_1_1.fswbg_.transform:Find("textbox/adapt/content") or arg_1_1.fswbg_.transform:Find("textbox/content")
				local var_4_16 = arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_4_17 = var_4_15:GetComponent("Text")
				local var_4_18 = var_4_15:GetComponent("RectTransform")

				var_4_17.alignment = UnityEngine.TextAnchor.LowerCenter
				var_4_18.offsetMin = Vector2.New(0, 0)
				var_4_18.offsetMax = Vector2.New(0, 0)
			end

			local var_4_19 = 0

			if var_4_19 < arg_1_1.time_ and arg_1_1.time_ <= var_4_19 + arg_4_0 then
				arg_1_1.cswbg_:SetActive(true)

				local var_4_20 = arg_1_1.cswt_:GetComponent("RectTransform")

				arg_1_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_4_20.offsetMin = Vector2.New(0, 0)
				var_4_20.offsetMax = Vector2.New(0, 0)

				local var_4_21 = arg_1_1:GetWordFromCfg(419128)
				local var_4_22 = arg_1_1:FormatText(var_4_21.content)

				arg_1_1.cswt_.text = var_4_22

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.cswt_)

				arg_1_1.cswt_.fontSize = 120
				arg_1_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_1_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_1_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_4_23 = "STblack"

			if arg_1_1.bgs_[var_4_23] == nil then
				local var_4_24 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_24:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_23)
				var_4_24.name = var_4_23
				var_4_24.transform.parent = arg_1_1.stage_.transform
				var_4_24.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_23] = var_4_24
			end

			local var_4_25 = 0

			if var_4_25 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				local var_4_26 = manager.ui.mainCamera.transform.localPosition
				local var_4_27 = Vector3.New(0, 0, 10) + Vector3.New(var_4_26.x, var_4_26.y, 0)
				local var_4_28 = arg_1_1.bgs_.STblack

				var_4_28.transform.localPosition = var_4_27
				var_4_28.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_29 = var_4_28:GetComponent("SpriteRenderer")

				if var_4_29 and var_4_29.sprite then
					local var_4_30 = (var_4_28.transform.localPosition - var_4_26).z
					local var_4_31 = manager.ui.mainCameraCom_
					local var_4_32 = 2 * var_4_30 * Mathf.Tan(var_4_31.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_33 = var_4_32 * var_4_31.aspect
					local var_4_34 = var_4_29.sprite.bounds.size.x
					local var_4_35 = var_4_29.sprite.bounds.size.y
					local var_4_36 = var_4_33 / var_4_34
					local var_4_37 = var_4_32 / var_4_35
					local var_4_38 = var_4_37 < var_4_36 and var_4_36 or var_4_37

					var_4_28.transform.localScale = Vector3.New(var_4_38, var_4_38, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "STblack" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_39 = 1.1
			local var_4_40 = 1.766
			local var_4_41 = manager.audio:GetVoiceLength("story_v_out_417141", "417141001", "story_v_out_417141awb") / 1000

			if var_4_41 > 0 and var_4_40 < var_4_41 and var_4_41 + var_4_39 > arg_1_1.duration_ then
				local var_4_42 = var_4_41

				arg_1_1.duration_ = var_4_41 + var_4_39
			end

			if var_4_39 < arg_1_1.time_ and arg_1_1.time_ <= var_4_39 + arg_4_0 then
				local var_4_43 = "play"
				local var_4_44 = "voice"

				arg_1_1:AudioAction(var_4_43, var_4_44, "story_v_out_417141", "417141001", "story_v_out_417141awb")
			end

			local var_4_45 = 0.1
			local var_4_46 = 1

			if var_4_45 < arg_1_1.time_ and arg_1_1.time_ <= var_4_45 + arg_4_0 then
				local var_4_47 = "play"
				local var_4_48 = "effect"

				arg_1_1:AudioAction(var_4_47, var_4_48, "se_story_1311", "se_story_1311_toy_loop", "")
			end

			local var_4_49 = 0
			local var_4_50 = 0.2

			if var_4_49 < arg_1_1.time_ and arg_1_1.time_ <= var_4_49 + arg_4_0 then
				local var_4_51 = "play"
				local var_4_52 = "music"

				arg_1_1:AudioAction(var_4_51, var_4_52, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_53 = ""
				local var_4_54 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_54 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_54 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_54

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_54
						arg_1_1.bgmTxt2_.text = var_4_54
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
	Play417141002 = function(arg_6_0, arg_6_1)
		arg_6_1.time_ = 0
		arg_6_1.frameCnt_ = 0
		arg_6_1.state_ = "playing"
		arg_6_1.curTalkId_ = 417141002
		arg_6_1.duration_ = 6.97

		SetActive(arg_6_1.tipsGo_, false)

		function arg_6_1.onSingleLineFinish_()
			arg_6_1.onSingleLineUpdate_ = nil
			arg_6_1.onSingleLineFinish_ = nil
			arg_6_1.state_ = "waiting"
		end

		function arg_6_1.playNext_(arg_8_0)
			if arg_8_0 == 1 then
				arg_6_0:Play417141003(arg_6_1)
			end
		end

		function arg_6_1.onSingleLineUpdate_(arg_9_0)
			local var_9_0 = 0

			if var_9_0 < arg_6_1.time_ and arg_6_1.time_ <= var_9_0 + arg_9_0 then
				arg_6_1.fswbg_:SetActive(true)
				arg_6_1.dialog_:SetActive(false)

				arg_6_1.fswtw_.percent = 0

				local var_9_1 = arg_6_1:GetWordFromCfg(417141002)
				local var_9_2 = arg_6_1:FormatText(var_9_1.content)

				arg_6_1.fswt_.text = var_9_2

				LuaForUtil.ClearLinePrefixSymbol(arg_6_1.fswt_)

				arg_6_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_6_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_6_1.fswtw_:SetDirty()

				arg_6_1.typewritterCharCountI18N = 0

				SetActive(arg_6_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_6_1:ShowNextGo(false)
			end

			local var_9_3 = 0.0999999999999999

			if var_9_3 < arg_6_1.time_ and arg_6_1.time_ <= var_9_3 + arg_9_0 then
				arg_6_1.var_.oldValueTypewriter = arg_6_1.fswtw_.percent

				SetActive(arg_6_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_6_1:ShowNextGo(false)
			end

			local var_9_4 = 35
			local var_9_5 = 2.33333333333333
			local var_9_6 = arg_6_1:GetWordFromCfg(417141002)
			local var_9_7 = arg_6_1:FormatText(var_9_6.content)
			local var_9_8, var_9_9 = arg_6_1:GetPercentByPara(var_9_7, 1)

			if var_9_3 < arg_6_1.time_ and arg_6_1.time_ <= var_9_3 + arg_9_0 then
				arg_6_1.talkMaxDuration = 0

				local var_9_10 = var_9_4 <= 0 and var_9_5 or var_9_5 * ((var_9_9 - arg_6_1.typewritterCharCountI18N) / var_9_4)

				if var_9_10 > 0 and var_9_5 < var_9_10 then
					arg_6_1.talkMaxDuration = var_9_10

					if var_9_10 + var_9_3 > arg_6_1.duration_ then
						arg_6_1.duration_ = var_9_10 + var_9_3
					end
				end
			end

			local var_9_11 = 2.33333333333333
			local var_9_12 = math.max(var_9_11, arg_6_1.talkMaxDuration)

			if var_9_3 <= arg_6_1.time_ and arg_6_1.time_ < var_9_3 + var_9_12 then
				local var_9_13 = (arg_6_1.time_ - var_9_3) / var_9_12

				arg_6_1.fswtw_.percent = Mathf.Lerp(arg_6_1.var_.oldValueTypewriter, var_9_8, var_9_13)
				arg_6_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_6_1.fswtw_:SetDirty()
			end

			if arg_6_1.time_ >= var_9_3 + var_9_12 and arg_6_1.time_ < var_9_3 + var_9_12 + arg_9_0 then
				arg_6_1.fswtw_.percent = var_9_8

				arg_6_1.fswtw_:SetDirty()
				arg_6_1:ShowNextGo(true)

				arg_6_1.typewritterCharCountI18N = var_9_9
			end

			local var_9_14 = 0.1
			local var_9_15 = 6.866
			local var_9_16 = manager.audio:GetVoiceLength("story_v_out_417141", "417141002", "") / 1000

			if var_9_16 > 0 and var_9_15 < var_9_16 and var_9_16 + var_9_14 > arg_6_1.duration_ then
				local var_9_17 = var_9_16

				arg_6_1.duration_ = var_9_16 + var_9_14
			end

			if var_9_14 < arg_6_1.time_ and arg_6_1.time_ <= var_9_14 + arg_9_0 then
				local var_9_18 = "play"
				local var_9_19 = "voice"

				arg_6_1:AudioAction(var_9_18, var_9_19, "story_v_out_417141", "417141002", "")
			end
		end

		arg_6_1.nodeConfigList_ = {}

		arg_6_1:InitPlayNodeList()
	end,
	Play417141003 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 417141003
		arg_10_1.duration_ = 7.3

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play417141004(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			local var_13_0 = 0

			if var_13_0 < arg_10_1.time_ and arg_10_1.time_ <= var_13_0 + arg_13_0 then
				arg_10_1.fswbg_:SetActive(true)
				arg_10_1.dialog_:SetActive(false)

				arg_10_1.fswtw_.percent = 0

				local var_13_1 = arg_10_1:GetWordFromCfg(417141003)
				local var_13_2 = arg_10_1:FormatText(var_13_1.content)

				arg_10_1.fswt_.text = var_13_2

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.fswt_)

				arg_10_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_10_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_10_1.fswtw_:SetDirty()

				arg_10_1.typewritterCharCountI18N = 0

				SetActive(arg_10_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_10_1:ShowNextGo(false)
			end

			local var_13_3 = 0.0999999999999996

			if var_13_3 < arg_10_1.time_ and arg_10_1.time_ <= var_13_3 + arg_13_0 then
				arg_10_1.var_.oldValueTypewriter = arg_10_1.fswtw_.percent

				SetActive(arg_10_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_10_1:ShowNextGo(false)
			end

			local var_13_4 = 27
			local var_13_5 = 1.8
			local var_13_6 = arg_10_1:GetWordFromCfg(417141003)
			local var_13_7 = arg_10_1:FormatText(var_13_6.content)
			local var_13_8, var_13_9 = arg_10_1:GetPercentByPara(var_13_7, 1)

			if var_13_3 < arg_10_1.time_ and arg_10_1.time_ <= var_13_3 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0

				local var_13_10 = var_13_4 <= 0 and var_13_5 or var_13_5 * ((var_13_9 - arg_10_1.typewritterCharCountI18N) / var_13_4)

				if var_13_10 > 0 and var_13_5 < var_13_10 then
					arg_10_1.talkMaxDuration = var_13_10

					if var_13_10 + var_13_3 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_10 + var_13_3
					end
				end
			end

			local var_13_11 = 1.8
			local var_13_12 = math.max(var_13_11, arg_10_1.talkMaxDuration)

			if var_13_3 <= arg_10_1.time_ and arg_10_1.time_ < var_13_3 + var_13_12 then
				local var_13_13 = (arg_10_1.time_ - var_13_3) / var_13_12

				arg_10_1.fswtw_.percent = Mathf.Lerp(arg_10_1.var_.oldValueTypewriter, var_13_8, var_13_13)
				arg_10_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_10_1.fswtw_:SetDirty()
			end

			if arg_10_1.time_ >= var_13_3 + var_13_12 and arg_10_1.time_ < var_13_3 + var_13_12 + arg_13_0 then
				arg_10_1.fswtw_.percent = var_13_8

				arg_10_1.fswtw_:SetDirty()
				arg_10_1:ShowNextGo(true)

				arg_10_1.typewritterCharCountI18N = var_13_9
			end

			local var_13_14 = 0.1
			local var_13_15 = 7.2
			local var_13_16 = manager.audio:GetVoiceLength("story_v_out_417141", "417141003", "") / 1000

			if var_13_16 > 0 and var_13_15 < var_13_16 and var_13_16 + var_13_14 > arg_10_1.duration_ then
				local var_13_17 = var_13_16

				arg_10_1.duration_ = var_13_16 + var_13_14
			end

			if var_13_14 < arg_10_1.time_ and arg_10_1.time_ <= var_13_14 + arg_13_0 then
				local var_13_18 = "play"
				local var_13_19 = "voice"

				arg_10_1:AudioAction(var_13_18, var_13_19, "story_v_out_417141", "417141003", "")
			end
		end

		arg_10_1.nodeConfigList_ = {}

		arg_10_1:InitPlayNodeList()
	end,
	Play417141004 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 417141004
		arg_14_1.duration_ = 12.4

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play417141005(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = 1

			if var_17_0 < arg_14_1.time_ and arg_14_1.time_ <= var_17_0 + arg_17_0 then
				arg_14_1.fswbg_:SetActive(true)
				arg_14_1.dialog_:SetActive(false)

				arg_14_1.fswtw_.percent = 0

				local var_17_1 = arg_14_1:GetWordFromCfg(417141004)
				local var_17_2 = arg_14_1:FormatText(var_17_1.content)

				arg_14_1.fswt_.text = var_17_2

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.fswt_)

				arg_14_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_14_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_14_1.fswtw_:SetDirty()

				arg_14_1.typewritterCharCountI18N = 0

				SetActive(arg_14_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_14_1:ShowNextGo(false)
			end

			local var_17_3 = 1.1

			if var_17_3 < arg_14_1.time_ and arg_14_1.time_ <= var_17_3 + arg_17_0 then
				arg_14_1.var_.oldValueTypewriter = arg_14_1.fswtw_.percent

				SetActive(arg_14_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_14_1:ShowNextGo(false)
			end

			local var_17_4 = 46
			local var_17_5 = 3.06666666666667
			local var_17_6 = arg_14_1:GetWordFromCfg(417141004)
			local var_17_7 = arg_14_1:FormatText(var_17_6.content)
			local var_17_8, var_17_9 = arg_14_1:GetPercentByPara(var_17_7, 1)

			if var_17_3 < arg_14_1.time_ and arg_14_1.time_ <= var_17_3 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0

				local var_17_10 = var_17_4 <= 0 and var_17_5 or var_17_5 * ((var_17_9 - arg_14_1.typewritterCharCountI18N) / var_17_4)

				if var_17_10 > 0 and var_17_5 < var_17_10 then
					arg_14_1.talkMaxDuration = var_17_10

					if var_17_10 + var_17_3 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_10 + var_17_3
					end
				end
			end

			local var_17_11 = 3.06666666666667
			local var_17_12 = math.max(var_17_11, arg_14_1.talkMaxDuration)

			if var_17_3 <= arg_14_1.time_ and arg_14_1.time_ < var_17_3 + var_17_12 then
				local var_17_13 = (arg_14_1.time_ - var_17_3) / var_17_12

				arg_14_1.fswtw_.percent = Mathf.Lerp(arg_14_1.var_.oldValueTypewriter, var_17_8, var_17_13)
				arg_14_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_14_1.fswtw_:SetDirty()
			end

			if arg_14_1.time_ >= var_17_3 + var_17_12 and arg_14_1.time_ < var_17_3 + var_17_12 + arg_17_0 then
				arg_14_1.fswtw_.percent = var_17_8

				arg_14_1.fswtw_:SetDirty()
				arg_14_1:ShowNextGo(true)

				arg_14_1.typewritterCharCountI18N = var_17_9
			end

			local var_17_14 = 1.1
			local var_17_15 = 11.3
			local var_17_16 = manager.audio:GetVoiceLength("story_v_out_417141", "417141004", "") / 1000

			if var_17_16 > 0 and var_17_15 < var_17_16 and var_17_16 + var_17_14 > arg_14_1.duration_ then
				local var_17_17 = var_17_16

				arg_14_1.duration_ = var_17_16 + var_17_14
			end

			if var_17_14 < arg_14_1.time_ and arg_14_1.time_ <= var_17_14 + arg_17_0 then
				local var_17_18 = "play"
				local var_17_19 = "voice"

				arg_14_1:AudioAction(var_17_18, var_17_19, "story_v_out_417141", "417141004", "")
			end

			local var_17_20 = 1

			if var_17_20 < arg_14_1.time_ and arg_14_1.time_ <= var_17_20 + arg_17_0 then
				arg_14_1.cswbg_:SetActive(false)
			end

			local var_17_21 = 1

			if var_17_21 < arg_14_1.time_ and arg_14_1.time_ <= var_17_21 + arg_17_0 then
				local var_17_22 = arg_14_1.fswbg_.transform:Find("textbox/adapt/content") or arg_14_1.fswbg_.transform:Find("textbox/content")
				local var_17_23 = arg_14_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_17_24 = var_17_22:GetComponent("Text")
				local var_17_25 = var_17_22:GetComponent("RectTransform")

				var_17_24.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_17_25.offsetMin = Vector2.New(0, 0)
				var_17_25.offsetMax = Vector2.New(0, 0)
			end

			local var_17_26 = 0

			if var_17_26 < arg_14_1.time_ and arg_14_1.time_ <= var_17_26 + arg_17_0 then
				arg_14_1.mask_.enabled = true
				arg_14_1.mask_.raycastTarget = false

				arg_14_1:SetGaussion(false)
			end

			local var_17_27 = 1

			if var_17_26 <= arg_14_1.time_ and arg_14_1.time_ < var_17_26 + var_17_27 then
				local var_17_28 = (arg_14_1.time_ - var_17_26) / var_17_27
				local var_17_29 = Color.New(0, 0, 0)

				var_17_29.a = Mathf.Lerp(0, 1, var_17_28)
				arg_14_1.mask_.color = var_17_29
			end

			if arg_14_1.time_ >= var_17_26 + var_17_27 and arg_14_1.time_ < var_17_26 + var_17_27 + arg_17_0 then
				local var_17_30 = Color.New(0, 0, 0)

				var_17_30.a = 1
				arg_14_1.mask_.color = var_17_30
			end

			local var_17_31 = 1

			if var_17_31 < arg_14_1.time_ and arg_14_1.time_ <= var_17_31 + arg_17_0 then
				arg_14_1.mask_.enabled = true
				arg_14_1.mask_.raycastTarget = false

				arg_14_1:SetGaussion(false)
			end

			local var_17_32 = 1

			if var_17_31 <= arg_14_1.time_ and arg_14_1.time_ < var_17_31 + var_17_32 then
				local var_17_33 = (arg_14_1.time_ - var_17_31) / var_17_32
				local var_17_34 = Color.New(0, 0, 0)

				var_17_34.a = Mathf.Lerp(1, 0, var_17_33)
				arg_14_1.mask_.color = var_17_34
			end

			if arg_14_1.time_ >= var_17_31 + var_17_32 and arg_14_1.time_ < var_17_31 + var_17_32 + arg_17_0 then
				local var_17_35 = Color.New(0, 0, 0)
				local var_17_36 = 0

				arg_14_1.mask_.enabled = false
				var_17_35.a = var_17_36
				arg_14_1.mask_.color = var_17_35
			end
		end

		arg_14_1.nodeConfigList_ = {}

		arg_14_1:InitPlayNodeList()
	end,
	Play417141005 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 417141005
		arg_18_1.duration_ = 32.67

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play417141009(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = 0

			if var_21_0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_0 + arg_21_0 then
				SetActive(arg_18_1.dialog_, false)
				SetActive(arg_18_1.allBtn_.gameObject, false)
				arg_18_1.hideBtnsController_:SetSelectedIndex(1)
				arg_18_1:StopAllVoice()
				manager.video:Play("SofdecAsset/story/story_1041714.usm", function(arg_22_0)
					if arg_18_1.state_ == "playing" then
						arg_18_1:JumpToEnd()
					end

					if arg_18_1.playNext_ and not arg_18_1.auto_ then
						arg_18_1.playNext_(1)
					end

					manager.video:Dispose()
				end, nil, nil, function(arg_23_0)
					if arg_23_0 then
						arg_18_1.state_ = "pause"
					else
						arg_18_1.state_ = "playing"
					end
				end, 1041714)
				manager.video.transform_:SetSiblingIndex(1)
			end

			local var_21_1 = 32

			if var_21_0 <= arg_18_1.time_ and arg_18_1.time_ < var_21_0 + var_21_1 then
				-- block empty
			end

			if arg_18_1.time_ >= var_21_0 + var_21_1 and arg_18_1.time_ < var_21_0 + var_21_1 + arg_21_0 then
				-- block empty
			end

			local var_21_2 = 32.4666666666667

			if var_21_2 < arg_18_1.time_ and arg_18_1.time_ <= var_21_2 + arg_21_0 then
				SetActive(arg_18_1.dialog_, true)
				SetActive(arg_18_1.allBtn_.gameObject, true)
				arg_18_1.hideBtnsController_:SetSelectedIndex(0)
				manager.video:Dispose()

				arg_18_1.isInLoopVideo = false
			end

			local var_21_3 = 0.199999999999996

			if var_21_2 <= arg_18_1.time_ and arg_18_1.time_ < var_21_2 + var_21_3 then
				-- block empty
			end

			if arg_18_1.time_ >= var_21_2 + var_21_3 and arg_18_1.time_ < var_21_2 + var_21_3 + arg_21_0 then
				-- block empty
			end

			local var_21_4 = 0

			if var_21_4 < arg_18_1.time_ and arg_18_1.time_ <= var_21_4 + arg_21_0 then
				arg_18_1.fswbg_:SetActive(false)
				arg_18_1.dialog_:SetActive(false)
				SetActive(arg_18_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_18_1:ShowNextGo(false)
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play417141009 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 417141009
		arg_24_1.duration_ = 5.9

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play417141010(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0.9

			if var_27_0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				arg_24_1.fswbg_:SetActive(false)
				arg_24_1.dialog_:SetActive(false)
				SetActive(arg_24_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_24_1:ShowNextGo(false)
			end

			local var_27_1 = 0.9

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 then
				arg_24_1.cswbg_:SetActive(false)
			end

			local var_27_2 = 0

			if var_27_2 < arg_24_1.time_ and arg_24_1.time_ <= var_27_2 + arg_27_0 then
				arg_24_1.mask_.enabled = true
				arg_24_1.mask_.raycastTarget = true

				arg_24_1:SetGaussion(false)
			end

			local var_27_3 = 1

			if var_27_2 <= arg_24_1.time_ and arg_24_1.time_ < var_27_2 + var_27_3 then
				local var_27_4 = (arg_24_1.time_ - var_27_2) / var_27_3
				local var_27_5 = Color.New(0, 0, 0)

				var_27_5.a = Mathf.Lerp(0, 1, var_27_4)
				arg_24_1.mask_.color = var_27_5
			end

			if arg_24_1.time_ >= var_27_2 + var_27_3 and arg_24_1.time_ < var_27_2 + var_27_3 + arg_27_0 then
				local var_27_6 = Color.New(0, 0, 0)

				var_27_6.a = 1
				arg_24_1.mask_.color = var_27_6
			end

			local var_27_7 = 1

			if var_27_7 < arg_24_1.time_ and arg_24_1.time_ <= var_27_7 + arg_27_0 then
				arg_24_1.mask_.enabled = true
				arg_24_1.mask_.raycastTarget = true

				arg_24_1:SetGaussion(false)
			end

			local var_27_8 = 1

			if var_27_7 <= arg_24_1.time_ and arg_24_1.time_ < var_27_7 + var_27_8 then
				local var_27_9 = (arg_24_1.time_ - var_27_7) / var_27_8
				local var_27_10 = Color.New(0, 0, 0)

				var_27_10.a = Mathf.Lerp(1, 0, var_27_9)
				arg_24_1.mask_.color = var_27_10
			end

			if arg_24_1.time_ >= var_27_7 + var_27_8 and arg_24_1.time_ < var_27_7 + var_27_8 + arg_27_0 then
				local var_27_11 = Color.New(0, 0, 0)
				local var_27_12 = 0

				arg_24_1.mask_.enabled = false
				var_27_11.a = var_27_12
				arg_24_1.mask_.color = var_27_11
			end

			local var_27_13 = 1

			if var_27_13 < arg_24_1.time_ and arg_24_1.time_ <= var_27_13 + arg_27_0 then
				local var_27_14 = manager.ui.mainCamera.transform.localPosition
				local var_27_15 = Vector3.New(0, 0, 10) + Vector3.New(var_27_14.x, var_27_14.y, 0)
				local var_27_16 = arg_24_1.bgs_.STblack

				var_27_16.transform.localPosition = var_27_15
				var_27_16.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_27_17 = var_27_16:GetComponent("SpriteRenderer")

				if var_27_17 and var_27_17.sprite then
					local var_27_18 = (var_27_16.transform.localPosition - var_27_14).z
					local var_27_19 = manager.ui.mainCameraCom_
					local var_27_20 = 2 * var_27_18 * Mathf.Tan(var_27_19.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_27_21 = var_27_20 * var_27_19.aspect
					local var_27_22 = var_27_17.sprite.bounds.size.x
					local var_27_23 = var_27_17.sprite.bounds.size.y
					local var_27_24 = var_27_21 / var_27_22
					local var_27_25 = var_27_20 / var_27_23
					local var_27_26 = var_27_25 < var_27_24 and var_27_24 or var_27_25

					var_27_16.transform.localScale = Vector3.New(var_27_26, var_27_26, 0)
				end

				for iter_27_0, iter_27_1 in pairs(arg_24_1.bgs_) do
					if iter_27_0 ~= "STblack" then
						iter_27_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_27_27 = 1.26666666666667

			if var_27_27 < arg_24_1.time_ and arg_24_1.time_ <= var_27_27 + arg_27_0 then
				local var_27_28 = arg_24_1.fswbg_.transform:Find("textbox/adapt/content") or arg_24_1.fswbg_.transform:Find("textbox/content")
				local var_27_29 = arg_24_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_27_30 = var_27_28:GetComponent("Text")
				local var_27_31 = var_27_28:GetComponent("RectTransform")

				var_27_30.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_27_31.offsetMin = Vector2.New(0, 0)
				var_27_31.offsetMax = Vector2.New(0, 0)
			end

			local var_27_32 = 1.16666666666667

			if var_27_32 < arg_24_1.time_ and arg_24_1.time_ <= var_27_32 + arg_27_0 then
				arg_24_1.fswbg_:SetActive(true)
				arg_24_1.dialog_:SetActive(false)

				arg_24_1.fswtw_.percent = 0

				local var_27_33 = arg_24_1:GetWordFromCfg(417141009)
				local var_27_34 = arg_24_1:FormatText(var_27_33.content)

				arg_24_1.fswt_.text = var_27_34

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.fswt_)

				arg_24_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_24_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_24_1.fswtw_:SetDirty()

				arg_24_1.typewritterCharCountI18N = 0

				SetActive(arg_24_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_24_1:ShowNextGo(false)
			end

			local var_27_35 = 1.26666666666667

			if var_27_35 < arg_24_1.time_ and arg_24_1.time_ <= var_27_35 + arg_27_0 then
				arg_24_1.var_.oldValueTypewriter = arg_24_1.fswtw_.percent

				SetActive(arg_24_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_24_1:ShowNextGo(false)
			end

			local var_27_36 = 16
			local var_27_37 = 1.06666666666667
			local var_27_38 = arg_24_1:GetWordFromCfg(417141009)
			local var_27_39 = arg_24_1:FormatText(var_27_38.content)
			local var_27_40, var_27_41 = arg_24_1:GetPercentByPara(var_27_39, 1)

			if var_27_35 < arg_24_1.time_ and arg_24_1.time_ <= var_27_35 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0

				local var_27_42 = var_27_36 <= 0 and var_27_37 or var_27_37 * ((var_27_41 - arg_24_1.typewritterCharCountI18N) / var_27_36)

				if var_27_42 > 0 and var_27_37 < var_27_42 then
					arg_24_1.talkMaxDuration = var_27_42

					if var_27_42 + var_27_35 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_42 + var_27_35
					end
				end
			end

			local var_27_43 = 1.06666666666667
			local var_27_44 = math.max(var_27_43, arg_24_1.talkMaxDuration)

			if var_27_35 <= arg_24_1.time_ and arg_24_1.time_ < var_27_35 + var_27_44 then
				local var_27_45 = (arg_24_1.time_ - var_27_35) / var_27_44

				arg_24_1.fswtw_.percent = Mathf.Lerp(arg_24_1.var_.oldValueTypewriter, var_27_40, var_27_45)
				arg_24_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_24_1.fswtw_:SetDirty()
			end

			if arg_24_1.time_ >= var_27_35 + var_27_44 and arg_24_1.time_ < var_27_35 + var_27_44 + arg_27_0 then
				arg_24_1.fswtw_.percent = var_27_40

				arg_24_1.fswtw_:SetDirty()
				arg_24_1:ShowNextGo(true)

				arg_24_1.typewritterCharCountI18N = var_27_41
			end

			local var_27_46 = 1.26666666666667
			local var_27_47 = 4.633
			local var_27_48 = manager.audio:GetVoiceLength("story_v_out_417141", "417141009", "") / 1000

			if var_27_48 > 0 and var_27_47 < var_27_48 and var_27_48 + var_27_46 > arg_24_1.duration_ then
				local var_27_49 = var_27_48

				arg_24_1.duration_ = var_27_48 + var_27_46
			end

			if var_27_46 < arg_24_1.time_ and arg_24_1.time_ <= var_27_46 + arg_27_0 then
				local var_27_50 = "play"
				local var_27_51 = "voice"

				arg_24_1:AudioAction(var_27_50, var_27_51, "story_v_out_417141", "417141009", "")
			end

			local var_27_52 = 0.9

			if var_27_52 < arg_24_1.time_ and arg_24_1.time_ <= var_27_52 + arg_27_0 then
				SetActive(arg_24_1.dialog_, true)
				SetActive(arg_24_1.allBtn_.gameObject, true)
				arg_24_1.hideBtnsController_:SetSelectedIndex(0)
				manager.video:Dispose()

				arg_24_1.isInLoopVideo = false
			end

			local var_27_53 = 0.1

			if var_27_52 <= arg_24_1.time_ and arg_24_1.time_ < var_27_52 + var_27_53 then
				-- block empty
			end

			if arg_24_1.time_ >= var_27_52 + var_27_53 and arg_24_1.time_ < var_27_52 + var_27_53 + arg_27_0 then
				arg_24_1.marker = ""
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play417141010 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 417141010
		arg_28_1.duration_ = 12.07

		local var_28_0 = {
			zh = 10.5666666666667,
			ja = 12.0666666666667
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
				arg_28_0:Play417141011(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 7.36666666666667

			if var_31_0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_0 + arg_31_0 then
				arg_28_1.allBtn_.enabled = false
			end

			local var_31_1 = 0.2

			if arg_28_1.time_ >= var_31_0 + var_31_1 and arg_28_1.time_ < var_31_0 + var_31_1 + arg_31_0 then
				arg_28_1.allBtn_.enabled = true
			end

			local var_31_2 = 0

			if var_31_2 < arg_28_1.time_ and arg_28_1.time_ <= var_31_2 + arg_31_0 then
				arg_28_1.fswbg_:SetActive(false)
				arg_28_1.dialog_:SetActive(false)
				SetActive(arg_28_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_28_1:ShowNextGo(false)
			end

			local var_31_3 = 0
			local var_31_4 = 5
			local var_31_5 = "STwhite"

			if var_31_3 < arg_28_1.time_ and arg_28_1.time_ <= var_31_3 + arg_31_0 then
				arg_28_1.timestampController_:SetSelectedState("show")
				arg_28_1.timestampAni_:Play("in")

				arg_28_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_31_5)

				arg_28_1.timestampColorController_:SetSelectedState("cold")
				arg_28_1.timeColdImg_:SetAlpha(0.031)

				local var_31_6 = arg_28_1:GetWordFromCfg(501045)
				local var_31_7 = arg_28_1:FormatText(var_31_6.content)

				arg_28_1.text_timeText_.text = var_31_7

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_timeText_)

				local var_31_8 = arg_28_1:GetWordFromCfg(501046)
				local var_31_9 = arg_28_1:FormatText(var_31_8.content)

				arg_28_1.text_siteText_.text = var_31_9

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_siteText_)
			end

			if arg_28_1.time_ >= var_31_3 + var_31_4 and arg_28_1.time_ < var_31_3 + var_31_4 + arg_31_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_28_1.timestampAni_, "out", function()
					arg_28_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_31_10 = 5

			if var_31_10 < arg_28_1.time_ and arg_28_1.time_ <= var_31_10 + arg_31_0 then
				arg_28_1.mask_.enabled = true
				arg_28_1.mask_.raycastTarget = false

				arg_28_1:SetGaussion(false)
			end

			local var_31_11 = 1.2

			if var_31_10 <= arg_28_1.time_ and arg_28_1.time_ < var_31_10 + var_31_11 then
				local var_31_12 = (arg_28_1.time_ - var_31_10) / var_31_11
				local var_31_13 = Color.New(0, 0, 0)

				var_31_13.a = Mathf.Lerp(0, 1, var_31_12)
				arg_28_1.mask_.color = var_31_13
			end

			if arg_28_1.time_ >= var_31_10 + var_31_11 and arg_28_1.time_ < var_31_10 + var_31_11 + arg_31_0 then
				local var_31_14 = Color.New(0, 0, 0)

				var_31_14.a = 1
				arg_28_1.mask_.color = var_31_14
			end

			local var_31_15 = 6.2

			if var_31_15 < arg_28_1.time_ and arg_28_1.time_ <= var_31_15 + arg_31_0 then
				arg_28_1.mask_.enabled = true
				arg_28_1.mask_.raycastTarget = false

				arg_28_1:SetGaussion(false)
			end

			local var_31_16 = 1.2

			if var_31_15 <= arg_28_1.time_ and arg_28_1.time_ < var_31_15 + var_31_16 then
				local var_31_17 = (arg_28_1.time_ - var_31_15) / var_31_16
				local var_31_18 = Color.New(0, 0, 0)

				var_31_18.a = Mathf.Lerp(1, 0, var_31_17)
				arg_28_1.mask_.color = var_31_18
			end

			if arg_28_1.time_ >= var_31_15 + var_31_16 and arg_28_1.time_ < var_31_15 + var_31_16 + arg_31_0 then
				local var_31_19 = Color.New(0, 0, 0)
				local var_31_20 = 0

				arg_28_1.mask_.enabled = false
				var_31_19.a = var_31_20
				arg_28_1.mask_.color = var_31_19
			end

			local var_31_21 = "I07a"

			if arg_28_1.bgs_[var_31_21] == nil then
				local var_31_22 = Object.Instantiate(arg_28_1.paintGo_)

				var_31_22:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_31_21)
				var_31_22.name = var_31_21
				var_31_22.transform.parent = arg_28_1.stage_.transform
				var_31_22.transform.localPosition = Vector3.New(0, 100, 0)
				arg_28_1.bgs_[var_31_21] = var_31_22
			end

			local var_31_23 = 0

			if var_31_23 < arg_28_1.time_ and arg_28_1.time_ <= var_31_23 + arg_31_0 then
				local var_31_24 = manager.ui.mainCamera.transform.localPosition
				local var_31_25 = Vector3.New(0, 0, 10) + Vector3.New(var_31_24.x, var_31_24.y, 0)
				local var_31_26 = arg_28_1.bgs_.I07a

				var_31_26.transform.localPosition = var_31_25
				var_31_26.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_31_27 = var_31_26:GetComponent("SpriteRenderer")

				if var_31_27 and var_31_27.sprite then
					local var_31_28 = (var_31_26.transform.localPosition - var_31_24).z
					local var_31_29 = manager.ui.mainCameraCom_
					local var_31_30 = 2 * var_31_28 * Mathf.Tan(var_31_29.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_31_31 = var_31_30 * var_31_29.aspect
					local var_31_32 = var_31_27.sprite.bounds.size.x
					local var_31_33 = var_31_27.sprite.bounds.size.y
					local var_31_34 = var_31_31 / var_31_32
					local var_31_35 = var_31_30 / var_31_33
					local var_31_36 = var_31_35 < var_31_34 and var_31_34 or var_31_35

					var_31_26.transform.localScale = Vector3.New(var_31_36, var_31_36, 0)
				end

				for iter_31_0, iter_31_1 in pairs(arg_28_1.bgs_) do
					if iter_31_0 ~= "I07a" then
						iter_31_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_31_37 = 0

			if var_31_37 < arg_28_1.time_ and arg_28_1.time_ <= var_31_37 + arg_31_0 then
				arg_28_1.allBtn_.enabled = false
			end

			local var_31_38 = 6.2

			if arg_28_1.time_ >= var_31_37 + var_31_38 and arg_28_1.time_ < var_31_37 + var_31_38 + arg_31_0 then
				arg_28_1.allBtn_.enabled = true
			end

			local var_31_39 = 6.2

			arg_28_1.isInRecall_ = true

			if var_31_39 < arg_28_1.time_ and arg_28_1.time_ <= var_31_39 + arg_31_0 then
				arg_28_1.screenFilterGo_:SetActive(true)

				arg_28_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_grey.asset")
				arg_28_1.hightColor1 = Color.New(0.8980392, 0.8980392, 0.8980392)
				arg_28_1.hightColor2 = Color.New(0.3411765, 0.3411765, 0.3411765)

				for iter_31_2, iter_31_3 in pairs(arg_28_1.actors_) do
					local var_31_40 = iter_31_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_31_4, iter_31_5 in ipairs(var_31_40) do
						if iter_31_5.color.r > 0.51 then
							iter_31_5.color = Color.New(0.8980392, 0.8980392, 0.8980392)
						else
							iter_31_5.color = Color.New(0.3411765, 0.3411765, 0.3411765)
						end
					end
				end
			end

			local var_31_41 = 0.0166666666666667

			if var_31_39 <= arg_28_1.time_ and arg_28_1.time_ < var_31_39 + var_31_41 then
				local var_31_42 = (arg_28_1.time_ - var_31_39) / var_31_41

				arg_28_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_31_42)
			end

			if arg_28_1.time_ >= var_31_39 + var_31_41 and arg_28_1.time_ < var_31_39 + var_31_41 + arg_31_0 then
				arg_28_1.screenFilterEffect_.weight = 1
			end

			local var_31_43 = "10113"

			if arg_28_1.actors_[var_31_43] == nil then
				local var_31_44 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10113")

				if not isNil(var_31_44) then
					local var_31_45 = Object.Instantiate(var_31_44, arg_28_1.canvasGo_.transform)

					var_31_45.transform:SetSiblingIndex(1)

					var_31_45.name = var_31_43
					var_31_45.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_28_1.actors_[var_31_43] = var_31_45

					local var_31_46 = var_31_45:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_28_1.isInRecall_ then
						for iter_31_6, iter_31_7 in ipairs(var_31_46) do
							iter_31_7.color = arg_28_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_31_47 = arg_28_1.actors_["10113"]
			local var_31_48 = 7.03333333333333

			if var_31_48 < arg_28_1.time_ and arg_28_1.time_ <= var_31_48 + arg_31_0 and not isNil(var_31_47) and arg_28_1.var_.actorSpriteComps10113 == nil then
				arg_28_1.var_.actorSpriteComps10113 = var_31_47:GetComponentsInChildren(typeof(Image), true)
			end

			local var_31_49 = 0.0339999999999998

			if var_31_48 <= arg_28_1.time_ and arg_28_1.time_ < var_31_48 + var_31_49 and not isNil(var_31_47) then
				local var_31_50 = (arg_28_1.time_ - var_31_48) / var_31_49

				if arg_28_1.var_.actorSpriteComps10113 then
					for iter_31_8, iter_31_9 in pairs(arg_28_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_31_9 then
							if arg_28_1.isInRecall_ then
								local var_31_51 = Mathf.Lerp(iter_31_9.color.r, arg_28_1.hightColor1.r, var_31_50)
								local var_31_52 = Mathf.Lerp(iter_31_9.color.g, arg_28_1.hightColor1.g, var_31_50)
								local var_31_53 = Mathf.Lerp(iter_31_9.color.b, arg_28_1.hightColor1.b, var_31_50)

								iter_31_9.color = Color.New(var_31_51, var_31_52, var_31_53)
							else
								local var_31_54 = Mathf.Lerp(iter_31_9.color.r, 1, var_31_50)

								iter_31_9.color = Color.New(var_31_54, var_31_54, var_31_54)
							end
						end
					end
				end
			end

			if arg_28_1.time_ >= var_31_48 + var_31_49 and arg_28_1.time_ < var_31_48 + var_31_49 + arg_31_0 and not isNil(var_31_47) and arg_28_1.var_.actorSpriteComps10113 then
				for iter_31_10, iter_31_11 in pairs(arg_28_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_31_11 then
						if arg_28_1.isInRecall_ then
							iter_31_11.color = arg_28_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_31_11.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_28_1.var_.actorSpriteComps10113 = nil
			end

			local var_31_55 = arg_28_1.actors_["10113"].transform
			local var_31_56 = 7.03333333333333

			if var_31_56 < arg_28_1.time_ and arg_28_1.time_ <= var_31_56 + arg_31_0 then
				arg_28_1.var_.moveOldPos10113 = var_31_55.localPosition
				var_31_55.localScale = Vector3.New(1, 1, 1)

				arg_28_1:CheckSpriteTmpPos("10113", 3)

				local var_31_57 = var_31_55.childCount

				for iter_31_12 = 0, var_31_57 - 1 do
					local var_31_58 = var_31_55:GetChild(iter_31_12)

					if var_31_58.name == "split_1" or not string.find(var_31_58.name, "split") then
						var_31_58.gameObject:SetActive(true)
					else
						var_31_58.gameObject:SetActive(false)
					end
				end
			end

			local var_31_59 = 0.001

			if var_31_56 <= arg_28_1.time_ and arg_28_1.time_ < var_31_56 + var_31_59 then
				local var_31_60 = (arg_28_1.time_ - var_31_56) / var_31_59
				local var_31_61 = Vector3.New(-30.38, -328.4, -517.4)

				var_31_55.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos10113, var_31_61, var_31_60)
			end

			if arg_28_1.time_ >= var_31_56 + var_31_59 and arg_28_1.time_ < var_31_56 + var_31_59 + arg_31_0 then
				var_31_55.localPosition = Vector3.New(-30.38, -328.4, -517.4)
			end

			local var_31_62 = arg_28_1.actors_["10113"]
			local var_31_63 = 7.03333333333333

			if var_31_63 < arg_28_1.time_ and arg_28_1.time_ <= var_31_63 + arg_31_0 then
				local var_31_64 = var_31_62:GetComponentInChildren(typeof(CanvasGroup))

				if var_31_64 then
					arg_28_1.var_.alphaOldValue10113 = var_31_64.alpha
					arg_28_1.var_.characterEffect10113 = var_31_64
				end

				arg_28_1.var_.alphaOldValue10113 = 0
			end

			local var_31_65 = 0.366666666666666

			if var_31_63 <= arg_28_1.time_ and arg_28_1.time_ < var_31_63 + var_31_65 then
				local var_31_66 = (arg_28_1.time_ - var_31_63) / var_31_65
				local var_31_67 = Mathf.Lerp(arg_28_1.var_.alphaOldValue10113, 1, var_31_66)

				if arg_28_1.var_.characterEffect10113 then
					arg_28_1.var_.characterEffect10113.alpha = var_31_67
				end
			end

			if arg_28_1.time_ >= var_31_63 + var_31_65 and arg_28_1.time_ < var_31_63 + var_31_65 + arg_31_0 and arg_28_1.var_.characterEffect10113 then
				arg_28_1.var_.characterEffect10113.alpha = 1
			end

			local var_31_68 = 0

			if var_31_68 < arg_28_1.time_ and arg_28_1.time_ <= var_31_68 + arg_31_0 then
				arg_28_1.mask_.enabled = true
				arg_28_1.mask_.raycastTarget = false

				arg_28_1:SetGaussion(false)
			end

			local var_31_69 = 1

			if var_31_68 <= arg_28_1.time_ and arg_28_1.time_ < var_31_68 + var_31_69 then
				local var_31_70 = (arg_28_1.time_ - var_31_68) / var_31_69
				local var_31_71 = Color.New(0, 0, 0)

				var_31_71.a = Mathf.Lerp(1, 0, var_31_70)
				arg_28_1.mask_.color = var_31_71
			end

			if arg_28_1.time_ >= var_31_68 + var_31_69 and arg_28_1.time_ < var_31_68 + var_31_69 + arg_31_0 then
				local var_31_72 = Color.New(0, 0, 0)
				local var_31_73 = 0

				arg_28_1.mask_.enabled = false
				var_31_72.a = var_31_73
				arg_28_1.mask_.color = var_31_72
			end

			local var_31_74 = 6.56666666666667
			local var_31_75 = 1

			if var_31_74 < arg_28_1.time_ and arg_28_1.time_ <= var_31_74 + arg_31_0 then
				local var_31_76 = "play"
				local var_31_77 = "effect"

				arg_28_1:AudioAction(var_31_76, var_31_77, "se_story_1311", "se_story_1311_toy_hit", "")
			end

			local var_31_78 = 0
			local var_31_79 = 0.2

			if var_31_78 < arg_28_1.time_ and arg_28_1.time_ <= var_31_78 + arg_31_0 then
				local var_31_80 = "play"
				local var_31_81 = "music"

				arg_28_1:AudioAction(var_31_80, var_31_81, "ui_battle", "ui_battle_stopbgm", "")

				local var_31_82 = ""
				local var_31_83 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_31_83 ~= "" then
					if arg_28_1.bgmTxt_.text ~= var_31_83 and arg_28_1.bgmTxt_.text ~= "" then
						if arg_28_1.bgmTxt2_.text ~= "" then
							arg_28_1.bgmTxt_.text = arg_28_1.bgmTxt2_.text
						end

						arg_28_1.bgmTxt2_.text = var_31_83

						arg_28_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_28_1.bgmTxt_.text = var_31_83
						arg_28_1.bgmTxt2_.text = var_31_83
					end

					if arg_28_1.bgmTimer then
						arg_28_1.bgmTimer:Stop()

						arg_28_1.bgmTimer = nil
					end

					if arg_28_1.settingData.show_music_name == 1 then
						arg_28_1.musicController:SetSelectedState("show")
						arg_28_1.musicAnimator_:Play("open", 0, 0)

						if arg_28_1.settingData.music_time ~= 0 then
							arg_28_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_28_1.settingData.music_time), function()
								if arg_28_1 == nil or isNil(arg_28_1.bgmTxt_) then
									return
								end

								arg_28_1.musicController:SetSelectedState("hide")
								arg_28_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_31_84 = 5.56666666666667
			local var_31_85 = 1

			if var_31_84 < arg_28_1.time_ and arg_28_1.time_ <= var_31_84 + arg_31_0 then
				local var_31_86 = "play"
				local var_31_87 = "music"

				arg_28_1:AudioAction(var_31_86, var_31_87, "bgm_activity_3_10_story_prison", "bgm_activity_3_10_story_prison", "bgm_activity_3_10_story_prison.awb")

				local var_31_88 = ""
				local var_31_89 = manager.audio:GetAudioName("bgm_activity_3_10_story_prison", "bgm_activity_3_10_story_prison")

				if var_31_89 ~= "" then
					if arg_28_1.bgmTxt_.text ~= var_31_89 and arg_28_1.bgmTxt_.text ~= "" then
						if arg_28_1.bgmTxt2_.text ~= "" then
							arg_28_1.bgmTxt_.text = arg_28_1.bgmTxt2_.text
						end

						arg_28_1.bgmTxt2_.text = var_31_89

						arg_28_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_28_1.bgmTxt_.text = var_31_89
						arg_28_1.bgmTxt2_.text = var_31_89
					end

					if arg_28_1.bgmTimer then
						arg_28_1.bgmTimer:Stop()

						arg_28_1.bgmTimer = nil
					end

					if arg_28_1.settingData.show_music_name == 1 then
						arg_28_1.musicController:SetSelectedState("show")
						arg_28_1.musicAnimator_:Play("open", 0, 0)

						if arg_28_1.settingData.music_time ~= 0 then
							arg_28_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_28_1.settingData.music_time), function()
								if arg_28_1 == nil or isNil(arg_28_1.bgmTxt_) then
									return
								end

								arg_28_1.musicController:SetSelectedState("hide")
								arg_28_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_31_90 = 5.36666666666667
			local var_31_91 = 1

			if var_31_90 < arg_28_1.time_ and arg_28_1.time_ <= var_31_90 + arg_31_0 then
				local var_31_92 = "stop"
				local var_31_93 = "effect"

				arg_28_1:AudioAction(var_31_92, var_31_93, "se_story_1311", "se_story_1311_toy_loop", "")
			end

			if arg_28_1.frameCnt_ <= 1 then
				arg_28_1.dialog_:SetActive(false)
			end

			local var_31_94 = 7.36666666666667
			local var_31_95 = 0.35

			if var_31_94 < arg_28_1.time_ and arg_28_1.time_ <= var_31_94 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0

				arg_28_1.dialog_:SetActive(true)

				arg_28_1.dialogCg_.alpha = 0

				local var_31_96 = LeanTween.value(arg_28_1.dialog_, 0, 1, 0.3)

				var_31_96:setOnUpdate(LuaHelper.FloatAction(function(arg_35_0)
					arg_28_1.dialogCg_.alpha = arg_35_0
				end))
				var_31_96:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_28_1.dialog_)
					var_31_96:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_28_1.duration_ = arg_28_1.duration_ + 0.3

				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_97 = arg_28_1:FormatText(StoryNameCfg[1117].name)

				arg_28_1.leftNameTxt_.text = var_31_97

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_98 = arg_28_1:GetWordFromCfg(417141010)
				local var_31_99 = arg_28_1:FormatText(var_31_98.content)

				arg_28_1.text_.text = var_31_99

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_100 = 14
				local var_31_101 = utf8.len(var_31_99)
				local var_31_102 = var_31_100 <= 0 and var_31_95 or var_31_95 * (var_31_101 / var_31_100)

				if var_31_102 > 0 and var_31_95 < var_31_102 then
					arg_28_1.talkMaxDuration = var_31_102
					var_31_94 = var_31_94 + 0.3

					if var_31_102 + var_31_94 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_102 + var_31_94
					end
				end

				arg_28_1.text_.text = var_31_99
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417141", "417141010", "story_v_out_417141.awb") ~= 0 then
					local var_31_103 = manager.audio:GetVoiceLength("story_v_out_417141", "417141010", "story_v_out_417141.awb") / 1000

					if var_31_103 + var_31_94 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_103 + var_31_94
					end

					if var_31_98.prefab_name ~= "" and arg_28_1.actors_[var_31_98.prefab_name] ~= nil then
						local var_31_104 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_98.prefab_name].transform, "story_v_out_417141", "417141010", "story_v_out_417141.awb")

						arg_28_1:RecordAudio("417141010", var_31_104)
						arg_28_1:RecordAudio("417141010", var_31_104)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_417141", "417141010", "story_v_out_417141.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_417141", "417141010", "story_v_out_417141.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_105 = var_31_94 + 0.3
			local var_31_106 = math.max(var_31_95, arg_28_1.talkMaxDuration)

			if var_31_105 <= arg_28_1.time_ and arg_28_1.time_ < var_31_105 + var_31_106 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_105) / var_31_106

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_105 + var_31_106 and arg_28_1.time_ < var_31_105 + var_31_106 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 7.03333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play417141011 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 417141011
		arg_37_1.duration_ = 8.9

		local var_37_0 = {
			zh = 6.6,
			ja = 8.9
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
				arg_37_0:Play417141012(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0
			local var_40_1 = 0.8

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_2 = arg_37_1:FormatText(StoryNameCfg[1117].name)

				arg_37_1.leftNameTxt_.text = var_40_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_3 = arg_37_1:GetWordFromCfg(417141011)
				local var_40_4 = arg_37_1:FormatText(var_40_3.content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 32
				local var_40_6 = utf8.len(var_40_4)
				local var_40_7 = var_40_5 <= 0 and var_40_1 or var_40_1 * (var_40_6 / var_40_5)

				if var_40_7 > 0 and var_40_1 < var_40_7 then
					arg_37_1.talkMaxDuration = var_40_7

					if var_40_7 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_7 + var_40_0
					end
				end

				arg_37_1.text_.text = var_40_4
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417141", "417141011", "story_v_out_417141.awb") ~= 0 then
					local var_40_8 = manager.audio:GetVoiceLength("story_v_out_417141", "417141011", "story_v_out_417141.awb") / 1000

					if var_40_8 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_8 + var_40_0
					end

					if var_40_3.prefab_name ~= "" and arg_37_1.actors_[var_40_3.prefab_name] ~= nil then
						local var_40_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_3.prefab_name].transform, "story_v_out_417141", "417141011", "story_v_out_417141.awb")

						arg_37_1:RecordAudio("417141011", var_40_9)
						arg_37_1:RecordAudio("417141011", var_40_9)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_417141", "417141011", "story_v_out_417141.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_417141", "417141011", "story_v_out_417141.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_10 = math.max(var_40_1, arg_37_1.talkMaxDuration)

			if var_40_0 <= arg_37_1.time_ and arg_37_1.time_ < var_40_0 + var_40_10 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_0) / var_40_10

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_0 + var_40_10 and arg_37_1.time_ < var_40_0 + var_40_10 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play417141012 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 417141012
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play417141013(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["10113"].transform
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.var_.moveOldPos10113 = var_44_0.localPosition
				var_44_0.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("10113", 7)

				local var_44_2 = var_44_0.childCount

				for iter_44_0 = 0, var_44_2 - 1 do
					local var_44_3 = var_44_0:GetChild(iter_44_0)

					if var_44_3.name == "" or not string.find(var_44_3.name, "split") then
						var_44_3.gameObject:SetActive(true)
					else
						var_44_3.gameObject:SetActive(false)
					end
				end
			end

			local var_44_4 = 0.001

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_4 then
				local var_44_5 = (arg_41_1.time_ - var_44_1) / var_44_4
				local var_44_6 = Vector3.New(0, -2000, 0)

				var_44_0.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10113, var_44_6, var_44_5)
			end

			if arg_41_1.time_ >= var_44_1 + var_44_4 and arg_41_1.time_ < var_44_1 + var_44_4 + arg_44_0 then
				var_44_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_44_7 = 0
			local var_44_8 = 1.2

			if var_44_7 < arg_41_1.time_ and arg_41_1.time_ <= var_44_7 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_9 = arg_41_1:GetWordFromCfg(417141012)
				local var_44_10 = arg_41_1:FormatText(var_44_9.content)

				arg_41_1.text_.text = var_44_10

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_11 = 48
				local var_44_12 = utf8.len(var_44_10)
				local var_44_13 = var_44_11 <= 0 and var_44_8 or var_44_8 * (var_44_12 / var_44_11)

				if var_44_13 > 0 and var_44_8 < var_44_13 then
					arg_41_1.talkMaxDuration = var_44_13

					if var_44_13 + var_44_7 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_13 + var_44_7
					end
				end

				arg_41_1.text_.text = var_44_10
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_14 = math.max(var_44_8, arg_41_1.talkMaxDuration)

			if var_44_7 <= arg_41_1.time_ and arg_41_1.time_ < var_44_7 + var_44_14 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_7) / var_44_14

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_7 + var_44_14 and arg_41_1.time_ < var_44_7 + var_44_14 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play417141013 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 417141013
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play417141014(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0.7
			local var_48_1 = 1

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				local var_48_2 = "play"
				local var_48_3 = "effect"

				arg_45_1:AudioAction(var_48_2, var_48_3, "se_story_1310", "se_story_1310_medication", "")
			end

			local var_48_4 = 0
			local var_48_5 = 1.7

			if var_48_4 < arg_45_1.time_ and arg_45_1.time_ <= var_48_4 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_6 = arg_45_1:GetWordFromCfg(417141013)
				local var_48_7 = arg_45_1:FormatText(var_48_6.content)

				arg_45_1.text_.text = var_48_7

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_8 = 68
				local var_48_9 = utf8.len(var_48_7)
				local var_48_10 = var_48_8 <= 0 and var_48_5 or var_48_5 * (var_48_9 / var_48_8)

				if var_48_10 > 0 and var_48_5 < var_48_10 then
					arg_45_1.talkMaxDuration = var_48_10

					if var_48_10 + var_48_4 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_10 + var_48_4
					end
				end

				arg_45_1.text_.text = var_48_7
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_11 = math.max(var_48_5, arg_45_1.talkMaxDuration)

			if var_48_4 <= arg_45_1.time_ and arg_45_1.time_ < var_48_4 + var_48_11 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_4) / var_48_11

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_4 + var_48_11 and arg_45_1.time_ < var_48_4 + var_48_11 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play417141014 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 417141014
		arg_49_1.duration_ = 4.23

		local var_49_0 = {
			zh = 3,
			ja = 4.233
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
				arg_49_0:Play417141015(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = "10128"

			if arg_49_1.actors_[var_52_0] == nil then
				local var_52_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10128")

				if not isNil(var_52_1) then
					local var_52_2 = Object.Instantiate(var_52_1, arg_49_1.canvasGo_.transform)

					var_52_2.transform:SetSiblingIndex(1)

					var_52_2.name = var_52_0
					var_52_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_49_1.actors_[var_52_0] = var_52_2

					local var_52_3 = var_52_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_49_1.isInRecall_ then
						for iter_52_0, iter_52_1 in ipairs(var_52_3) do
							iter_52_1.color = arg_49_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_52_4 = arg_49_1.actors_["10128"]
			local var_52_5 = 0

			if var_52_5 < arg_49_1.time_ and arg_49_1.time_ <= var_52_5 + arg_52_0 and not isNil(var_52_4) and arg_49_1.var_.actorSpriteComps10128 == nil then
				arg_49_1.var_.actorSpriteComps10128 = var_52_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_6 = 0.2

			if var_52_5 <= arg_49_1.time_ and arg_49_1.time_ < var_52_5 + var_52_6 and not isNil(var_52_4) then
				local var_52_7 = (arg_49_1.time_ - var_52_5) / var_52_6

				if arg_49_1.var_.actorSpriteComps10128 then
					for iter_52_2, iter_52_3 in pairs(arg_49_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_52_3 then
							if arg_49_1.isInRecall_ then
								local var_52_8 = Mathf.Lerp(iter_52_3.color.r, arg_49_1.hightColor1.r, var_52_7)
								local var_52_9 = Mathf.Lerp(iter_52_3.color.g, arg_49_1.hightColor1.g, var_52_7)
								local var_52_10 = Mathf.Lerp(iter_52_3.color.b, arg_49_1.hightColor1.b, var_52_7)

								iter_52_3.color = Color.New(var_52_8, var_52_9, var_52_10)
							else
								local var_52_11 = Mathf.Lerp(iter_52_3.color.r, 1, var_52_7)

								iter_52_3.color = Color.New(var_52_11, var_52_11, var_52_11)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= var_52_5 + var_52_6 and arg_49_1.time_ < var_52_5 + var_52_6 + arg_52_0 and not isNil(var_52_4) and arg_49_1.var_.actorSpriteComps10128 then
				for iter_52_4, iter_52_5 in pairs(arg_49_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_52_5 then
						if arg_49_1.isInRecall_ then
							iter_52_5.color = arg_49_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_52_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_49_1.var_.actorSpriteComps10128 = nil
			end

			local var_52_12 = arg_49_1.actors_["10128"].transform
			local var_52_13 = 0

			if var_52_13 < arg_49_1.time_ and arg_49_1.time_ <= var_52_13 + arg_52_0 then
				arg_49_1.var_.moveOldPos10128 = var_52_12.localPosition
				var_52_12.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("10128", 3)

				local var_52_14 = var_52_12.childCount

				for iter_52_6 = 0, var_52_14 - 1 do
					local var_52_15 = var_52_12:GetChild(iter_52_6)

					if var_52_15.name == "split_4" or not string.find(var_52_15.name, "split") then
						var_52_15.gameObject:SetActive(true)
					else
						var_52_15.gameObject:SetActive(false)
					end
				end
			end

			local var_52_16 = 0.001

			if var_52_13 <= arg_49_1.time_ and arg_49_1.time_ < var_52_13 + var_52_16 then
				local var_52_17 = (arg_49_1.time_ - var_52_13) / var_52_16
				local var_52_18 = Vector3.New(0, -347, -300)

				var_52_12.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10128, var_52_18, var_52_17)
			end

			if arg_49_1.time_ >= var_52_13 + var_52_16 and arg_49_1.time_ < var_52_13 + var_52_16 + arg_52_0 then
				var_52_12.localPosition = Vector3.New(0, -347, -300)
			end

			local var_52_19 = 0
			local var_52_20 = 0.3

			if var_52_19 < arg_49_1.time_ and arg_49_1.time_ <= var_52_19 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_21 = arg_49_1:FormatText(StoryNameCfg[595].name)

				arg_49_1.leftNameTxt_.text = var_52_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_22 = arg_49_1:GetWordFromCfg(417141014)
				local var_52_23 = arg_49_1:FormatText(var_52_22.content)

				arg_49_1.text_.text = var_52_23

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_24 = 12
				local var_52_25 = utf8.len(var_52_23)
				local var_52_26 = var_52_24 <= 0 and var_52_20 or var_52_20 * (var_52_25 / var_52_24)

				if var_52_26 > 0 and var_52_20 < var_52_26 then
					arg_49_1.talkMaxDuration = var_52_26

					if var_52_26 + var_52_19 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_26 + var_52_19
					end
				end

				arg_49_1.text_.text = var_52_23
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417141", "417141014", "story_v_out_417141.awb") ~= 0 then
					local var_52_27 = manager.audio:GetVoiceLength("story_v_out_417141", "417141014", "story_v_out_417141.awb") / 1000

					if var_52_27 + var_52_19 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_27 + var_52_19
					end

					if var_52_22.prefab_name ~= "" and arg_49_1.actors_[var_52_22.prefab_name] ~= nil then
						local var_52_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_22.prefab_name].transform, "story_v_out_417141", "417141014", "story_v_out_417141.awb")

						arg_49_1:RecordAudio("417141014", var_52_28)
						arg_49_1:RecordAudio("417141014", var_52_28)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_417141", "417141014", "story_v_out_417141.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_417141", "417141014", "story_v_out_417141.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_29 = math.max(var_52_20, arg_49_1.talkMaxDuration)

			if var_52_19 <= arg_49_1.time_ and arg_49_1.time_ < var_52_19 + var_52_29 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_19) / var_52_29

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_19 + var_52_29 and arg_49_1.time_ < var_52_19 + var_52_29 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play417141015 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 417141015
		arg_53_1.duration_ = 2.93

		local var_53_0 = {
			zh = 1.833,
			ja = 2.933
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
				arg_53_0:Play417141016(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["10113"].transform
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.var_.moveOldPos10113 = var_56_0.localPosition
				var_56_0.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("10113", 4)

				local var_56_2 = var_56_0.childCount

				for iter_56_0 = 0, var_56_2 - 1 do
					local var_56_3 = var_56_0:GetChild(iter_56_0)

					if var_56_3.name == "split_2" or not string.find(var_56_3.name, "split") then
						var_56_3.gameObject:SetActive(true)
					else
						var_56_3.gameObject:SetActive(false)
					end
				end
			end

			local var_56_4 = 0.001

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_4 then
				local var_56_5 = (arg_53_1.time_ - var_56_1) / var_56_4
				local var_56_6 = Vector3.New(377.3, -328.4, -517.4)

				var_56_0.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10113, var_56_6, var_56_5)
			end

			if arg_53_1.time_ >= var_56_1 + var_56_4 and arg_53_1.time_ < var_56_1 + var_56_4 + arg_56_0 then
				var_56_0.localPosition = Vector3.New(377.3, -328.4, -517.4)
			end

			local var_56_7 = arg_53_1.actors_["10128"].transform
			local var_56_8 = 0

			if var_56_8 < arg_53_1.time_ and arg_53_1.time_ <= var_56_8 + arg_56_0 then
				arg_53_1.var_.moveOldPos10128 = var_56_7.localPosition
				var_56_7.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("10128", 2)

				local var_56_9 = var_56_7.childCount

				for iter_56_1 = 0, var_56_9 - 1 do
					local var_56_10 = var_56_7:GetChild(iter_56_1)

					if var_56_10.name == "" or not string.find(var_56_10.name, "split") then
						var_56_10.gameObject:SetActive(true)
					else
						var_56_10.gameObject:SetActive(false)
					end
				end
			end

			local var_56_11 = 0.001

			if var_56_8 <= arg_53_1.time_ and arg_53_1.time_ < var_56_8 + var_56_11 then
				local var_56_12 = (arg_53_1.time_ - var_56_8) / var_56_11
				local var_56_13 = Vector3.New(-390, -347, -300)

				var_56_7.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10128, var_56_13, var_56_12)
			end

			if arg_53_1.time_ >= var_56_8 + var_56_11 and arg_53_1.time_ < var_56_8 + var_56_11 + arg_56_0 then
				var_56_7.localPosition = Vector3.New(-390, -347, -300)
			end

			local var_56_14 = arg_53_1.actors_["10128"]
			local var_56_15 = 0

			if var_56_15 < arg_53_1.time_ and arg_53_1.time_ <= var_56_15 + arg_56_0 and not isNil(var_56_14) and arg_53_1.var_.actorSpriteComps10128 == nil then
				arg_53_1.var_.actorSpriteComps10128 = var_56_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_16 = 0.2

			if var_56_15 <= arg_53_1.time_ and arg_53_1.time_ < var_56_15 + var_56_16 and not isNil(var_56_14) then
				local var_56_17 = (arg_53_1.time_ - var_56_15) / var_56_16

				if arg_53_1.var_.actorSpriteComps10128 then
					for iter_56_2, iter_56_3 in pairs(arg_53_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_56_3 then
							if arg_53_1.isInRecall_ then
								local var_56_18 = Mathf.Lerp(iter_56_3.color.r, arg_53_1.hightColor2.r, var_56_17)
								local var_56_19 = Mathf.Lerp(iter_56_3.color.g, arg_53_1.hightColor2.g, var_56_17)
								local var_56_20 = Mathf.Lerp(iter_56_3.color.b, arg_53_1.hightColor2.b, var_56_17)

								iter_56_3.color = Color.New(var_56_18, var_56_19, var_56_20)
							else
								local var_56_21 = Mathf.Lerp(iter_56_3.color.r, 0.5, var_56_17)

								iter_56_3.color = Color.New(var_56_21, var_56_21, var_56_21)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= var_56_15 + var_56_16 and arg_53_1.time_ < var_56_15 + var_56_16 + arg_56_0 and not isNil(var_56_14) and arg_53_1.var_.actorSpriteComps10128 then
				for iter_56_4, iter_56_5 in pairs(arg_53_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_56_5 then
						if arg_53_1.isInRecall_ then
							iter_56_5.color = arg_53_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_56_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_53_1.var_.actorSpriteComps10128 = nil
			end

			local var_56_22 = 0
			local var_56_23 = 0.2

			if var_56_22 < arg_53_1.time_ and arg_53_1.time_ <= var_56_22 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_24 = arg_53_1:FormatText(StoryNameCfg[1117].name)

				arg_53_1.leftNameTxt_.text = var_56_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_25 = arg_53_1:GetWordFromCfg(417141015)
				local var_56_26 = arg_53_1:FormatText(var_56_25.content)

				arg_53_1.text_.text = var_56_26

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_27 = 8
				local var_56_28 = utf8.len(var_56_26)
				local var_56_29 = var_56_27 <= 0 and var_56_23 or var_56_23 * (var_56_28 / var_56_27)

				if var_56_29 > 0 and var_56_23 < var_56_29 then
					arg_53_1.talkMaxDuration = var_56_29

					if var_56_29 + var_56_22 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_29 + var_56_22
					end
				end

				arg_53_1.text_.text = var_56_26
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417141", "417141015", "story_v_out_417141.awb") ~= 0 then
					local var_56_30 = manager.audio:GetVoiceLength("story_v_out_417141", "417141015", "story_v_out_417141.awb") / 1000

					if var_56_30 + var_56_22 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_30 + var_56_22
					end

					if var_56_25.prefab_name ~= "" and arg_53_1.actors_[var_56_25.prefab_name] ~= nil then
						local var_56_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_25.prefab_name].transform, "story_v_out_417141", "417141015", "story_v_out_417141.awb")

						arg_53_1:RecordAudio("417141015", var_56_31)
						arg_53_1:RecordAudio("417141015", var_56_31)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_417141", "417141015", "story_v_out_417141.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_417141", "417141015", "story_v_out_417141.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_32 = math.max(var_56_23, arg_53_1.talkMaxDuration)

			if var_56_22 <= arg_53_1.time_ and arg_53_1.time_ < var_56_22 + var_56_32 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_22) / var_56_32

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_22 + var_56_32 and arg_53_1.time_ < var_56_22 + var_56_32 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play417141016 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 417141016
		arg_57_1.duration_ = 3.7

		local var_57_0 = {
			zh = 3.7,
			ja = 2.833
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
				arg_57_0:Play417141017(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["10128"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.actorSpriteComps10128 == nil then
				arg_57_1.var_.actorSpriteComps10128 = var_60_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_2 = 0.2

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 and not isNil(var_60_0) then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.actorSpriteComps10128 then
					for iter_60_0, iter_60_1 in pairs(arg_57_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_60_1 then
							if arg_57_1.isInRecall_ then
								local var_60_4 = Mathf.Lerp(iter_60_1.color.r, arg_57_1.hightColor1.r, var_60_3)
								local var_60_5 = Mathf.Lerp(iter_60_1.color.g, arg_57_1.hightColor1.g, var_60_3)
								local var_60_6 = Mathf.Lerp(iter_60_1.color.b, arg_57_1.hightColor1.b, var_60_3)

								iter_60_1.color = Color.New(var_60_4, var_60_5, var_60_6)
							else
								local var_60_7 = Mathf.Lerp(iter_60_1.color.r, 1, var_60_3)

								iter_60_1.color = Color.New(var_60_7, var_60_7, var_60_7)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.actorSpriteComps10128 then
				for iter_60_2, iter_60_3 in pairs(arg_57_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_60_3 then
						if arg_57_1.isInRecall_ then
							iter_60_3.color = arg_57_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_60_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_57_1.var_.actorSpriteComps10128 = nil
			end

			local var_60_8 = arg_57_1.actors_["10113"]
			local var_60_9 = 0

			if var_60_9 < arg_57_1.time_ and arg_57_1.time_ <= var_60_9 + arg_60_0 and not isNil(var_60_8) and arg_57_1.var_.actorSpriteComps10113 == nil then
				arg_57_1.var_.actorSpriteComps10113 = var_60_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_10 = 0.2

			if var_60_9 <= arg_57_1.time_ and arg_57_1.time_ < var_60_9 + var_60_10 and not isNil(var_60_8) then
				local var_60_11 = (arg_57_1.time_ - var_60_9) / var_60_10

				if arg_57_1.var_.actorSpriteComps10113 then
					for iter_60_4, iter_60_5 in pairs(arg_57_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_60_5 then
							if arg_57_1.isInRecall_ then
								local var_60_12 = Mathf.Lerp(iter_60_5.color.r, arg_57_1.hightColor2.r, var_60_11)
								local var_60_13 = Mathf.Lerp(iter_60_5.color.g, arg_57_1.hightColor2.g, var_60_11)
								local var_60_14 = Mathf.Lerp(iter_60_5.color.b, arg_57_1.hightColor2.b, var_60_11)

								iter_60_5.color = Color.New(var_60_12, var_60_13, var_60_14)
							else
								local var_60_15 = Mathf.Lerp(iter_60_5.color.r, 0.5, var_60_11)

								iter_60_5.color = Color.New(var_60_15, var_60_15, var_60_15)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= var_60_9 + var_60_10 and arg_57_1.time_ < var_60_9 + var_60_10 + arg_60_0 and not isNil(var_60_8) and arg_57_1.var_.actorSpriteComps10113 then
				for iter_60_6, iter_60_7 in pairs(arg_57_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_60_7 then
						if arg_57_1.isInRecall_ then
							iter_60_7.color = arg_57_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_60_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_57_1.var_.actorSpriteComps10113 = nil
			end

			local var_60_16 = 0
			local var_60_17 = 0.35

			if var_60_16 < arg_57_1.time_ and arg_57_1.time_ <= var_60_16 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_18 = arg_57_1:FormatText(StoryNameCfg[595].name)

				arg_57_1.leftNameTxt_.text = var_60_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_19 = arg_57_1:GetWordFromCfg(417141016)
				local var_60_20 = arg_57_1:FormatText(var_60_19.content)

				arg_57_1.text_.text = var_60_20

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_21 = 14
				local var_60_22 = utf8.len(var_60_20)
				local var_60_23 = var_60_21 <= 0 and var_60_17 or var_60_17 * (var_60_22 / var_60_21)

				if var_60_23 > 0 and var_60_17 < var_60_23 then
					arg_57_1.talkMaxDuration = var_60_23

					if var_60_23 + var_60_16 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_23 + var_60_16
					end
				end

				arg_57_1.text_.text = var_60_20
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417141", "417141016", "story_v_out_417141.awb") ~= 0 then
					local var_60_24 = manager.audio:GetVoiceLength("story_v_out_417141", "417141016", "story_v_out_417141.awb") / 1000

					if var_60_24 + var_60_16 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_24 + var_60_16
					end

					if var_60_19.prefab_name ~= "" and arg_57_1.actors_[var_60_19.prefab_name] ~= nil then
						local var_60_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_19.prefab_name].transform, "story_v_out_417141", "417141016", "story_v_out_417141.awb")

						arg_57_1:RecordAudio("417141016", var_60_25)
						arg_57_1:RecordAudio("417141016", var_60_25)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_417141", "417141016", "story_v_out_417141.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_417141", "417141016", "story_v_out_417141.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_26 = math.max(var_60_17, arg_57_1.talkMaxDuration)

			if var_60_16 <= arg_57_1.time_ and arg_57_1.time_ < var_60_16 + var_60_26 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_16) / var_60_26

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_16 + var_60_26 and arg_57_1.time_ < var_60_16 + var_60_26 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play417141017 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 417141017
		arg_61_1.duration_ = 4.03

		local var_61_0 = {
			zh = 2.2,
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
				arg_61_0:Play417141018(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["10113"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.actorSpriteComps10113 == nil then
				arg_61_1.var_.actorSpriteComps10113 = var_64_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_2 = 0.2

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 and not isNil(var_64_0) then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2

				if arg_61_1.var_.actorSpriteComps10113 then
					for iter_64_0, iter_64_1 in pairs(arg_61_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_64_1 then
							if arg_61_1.isInRecall_ then
								local var_64_4 = Mathf.Lerp(iter_64_1.color.r, arg_61_1.hightColor1.r, var_64_3)
								local var_64_5 = Mathf.Lerp(iter_64_1.color.g, arg_61_1.hightColor1.g, var_64_3)
								local var_64_6 = Mathf.Lerp(iter_64_1.color.b, arg_61_1.hightColor1.b, var_64_3)

								iter_64_1.color = Color.New(var_64_4, var_64_5, var_64_6)
							else
								local var_64_7 = Mathf.Lerp(iter_64_1.color.r, 1, var_64_3)

								iter_64_1.color = Color.New(var_64_7, var_64_7, var_64_7)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.actorSpriteComps10113 then
				for iter_64_2, iter_64_3 in pairs(arg_61_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_64_3 then
						if arg_61_1.isInRecall_ then
							iter_64_3.color = arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_64_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_61_1.var_.actorSpriteComps10113 = nil
			end

			local var_64_8 = arg_61_1.actors_["10128"]
			local var_64_9 = 0

			if var_64_9 < arg_61_1.time_ and arg_61_1.time_ <= var_64_9 + arg_64_0 and not isNil(var_64_8) and arg_61_1.var_.actorSpriteComps10128 == nil then
				arg_61_1.var_.actorSpriteComps10128 = var_64_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_10 = 0.2

			if var_64_9 <= arg_61_1.time_ and arg_61_1.time_ < var_64_9 + var_64_10 and not isNil(var_64_8) then
				local var_64_11 = (arg_61_1.time_ - var_64_9) / var_64_10

				if arg_61_1.var_.actorSpriteComps10128 then
					for iter_64_4, iter_64_5 in pairs(arg_61_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_64_5 then
							if arg_61_1.isInRecall_ then
								local var_64_12 = Mathf.Lerp(iter_64_5.color.r, arg_61_1.hightColor2.r, var_64_11)
								local var_64_13 = Mathf.Lerp(iter_64_5.color.g, arg_61_1.hightColor2.g, var_64_11)
								local var_64_14 = Mathf.Lerp(iter_64_5.color.b, arg_61_1.hightColor2.b, var_64_11)

								iter_64_5.color = Color.New(var_64_12, var_64_13, var_64_14)
							else
								local var_64_15 = Mathf.Lerp(iter_64_5.color.r, 0.5, var_64_11)

								iter_64_5.color = Color.New(var_64_15, var_64_15, var_64_15)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= var_64_9 + var_64_10 and arg_61_1.time_ < var_64_9 + var_64_10 + arg_64_0 and not isNil(var_64_8) and arg_61_1.var_.actorSpriteComps10128 then
				for iter_64_6, iter_64_7 in pairs(arg_61_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_64_7 then
						if arg_61_1.isInRecall_ then
							iter_64_7.color = arg_61_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_64_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_61_1.var_.actorSpriteComps10128 = nil
			end

			local var_64_16 = 0
			local var_64_17 = 0.225

			if var_64_16 < arg_61_1.time_ and arg_61_1.time_ <= var_64_16 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_18 = arg_61_1:FormatText(StoryNameCfg[1117].name)

				arg_61_1.leftNameTxt_.text = var_64_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_19 = arg_61_1:GetWordFromCfg(417141017)
				local var_64_20 = arg_61_1:FormatText(var_64_19.content)

				arg_61_1.text_.text = var_64_20

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_21 = 9
				local var_64_22 = utf8.len(var_64_20)
				local var_64_23 = var_64_21 <= 0 and var_64_17 or var_64_17 * (var_64_22 / var_64_21)

				if var_64_23 > 0 and var_64_17 < var_64_23 then
					arg_61_1.talkMaxDuration = var_64_23

					if var_64_23 + var_64_16 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_23 + var_64_16
					end
				end

				arg_61_1.text_.text = var_64_20
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417141", "417141017", "story_v_out_417141.awb") ~= 0 then
					local var_64_24 = manager.audio:GetVoiceLength("story_v_out_417141", "417141017", "story_v_out_417141.awb") / 1000

					if var_64_24 + var_64_16 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_24 + var_64_16
					end

					if var_64_19.prefab_name ~= "" and arg_61_1.actors_[var_64_19.prefab_name] ~= nil then
						local var_64_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_19.prefab_name].transform, "story_v_out_417141", "417141017", "story_v_out_417141.awb")

						arg_61_1:RecordAudio("417141017", var_64_25)
						arg_61_1:RecordAudio("417141017", var_64_25)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_417141", "417141017", "story_v_out_417141.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_417141", "417141017", "story_v_out_417141.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_26 = math.max(var_64_17, arg_61_1.talkMaxDuration)

			if var_64_16 <= arg_61_1.time_ and arg_61_1.time_ < var_64_16 + var_64_26 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_16) / var_64_26

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_16 + var_64_26 and arg_61_1.time_ < var_64_16 + var_64_26 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play417141018 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 417141018
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play417141019(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["10113"].transform
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.var_.moveOldPos10113 = var_68_0.localPosition
				var_68_0.localScale = Vector3.New(1, 1, 1)

				arg_65_1:CheckSpriteTmpPos("10113", 7)

				local var_68_2 = var_68_0.childCount

				for iter_68_0 = 0, var_68_2 - 1 do
					local var_68_3 = var_68_0:GetChild(iter_68_0)

					if var_68_3.name == "" or not string.find(var_68_3.name, "split") then
						var_68_3.gameObject:SetActive(true)
					else
						var_68_3.gameObject:SetActive(false)
					end
				end
			end

			local var_68_4 = 0.001

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_4 then
				local var_68_5 = (arg_65_1.time_ - var_68_1) / var_68_4
				local var_68_6 = Vector3.New(0, -2000, 0)

				var_68_0.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10113, var_68_6, var_68_5)
			end

			if arg_65_1.time_ >= var_68_1 + var_68_4 and arg_65_1.time_ < var_68_1 + var_68_4 + arg_68_0 then
				var_68_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_68_7 = arg_65_1.actors_["10128"].transform
			local var_68_8 = 0

			if var_68_8 < arg_65_1.time_ and arg_65_1.time_ <= var_68_8 + arg_68_0 then
				arg_65_1.var_.moveOldPos10128 = var_68_7.localPosition
				var_68_7.localScale = Vector3.New(1, 1, 1)

				arg_65_1:CheckSpriteTmpPos("10128", 7)

				local var_68_9 = var_68_7.childCount

				for iter_68_1 = 0, var_68_9 - 1 do
					local var_68_10 = var_68_7:GetChild(iter_68_1)

					if var_68_10.name == "" or not string.find(var_68_10.name, "split") then
						var_68_10.gameObject:SetActive(true)
					else
						var_68_10.gameObject:SetActive(false)
					end
				end
			end

			local var_68_11 = 0.001

			if var_68_8 <= arg_65_1.time_ and arg_65_1.time_ < var_68_8 + var_68_11 then
				local var_68_12 = (arg_65_1.time_ - var_68_8) / var_68_11
				local var_68_13 = Vector3.New(0, -2000, -300)

				var_68_7.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10128, var_68_13, var_68_12)
			end

			if arg_65_1.time_ >= var_68_8 + var_68_11 and arg_65_1.time_ < var_68_8 + var_68_11 + arg_68_0 then
				var_68_7.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_68_14 = 0
			local var_68_15 = 1.225

			if var_68_14 < arg_65_1.time_ and arg_65_1.time_ <= var_68_14 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_16 = arg_65_1:GetWordFromCfg(417141018)
				local var_68_17 = arg_65_1:FormatText(var_68_16.content)

				arg_65_1.text_.text = var_68_17

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_18 = 49
				local var_68_19 = utf8.len(var_68_17)
				local var_68_20 = var_68_18 <= 0 and var_68_15 or var_68_15 * (var_68_19 / var_68_18)

				if var_68_20 > 0 and var_68_15 < var_68_20 then
					arg_65_1.talkMaxDuration = var_68_20

					if var_68_20 + var_68_14 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_20 + var_68_14
					end
				end

				arg_65_1.text_.text = var_68_17
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_21 = math.max(var_68_15, arg_65_1.talkMaxDuration)

			if var_68_14 <= arg_65_1.time_ and arg_65_1.time_ < var_68_14 + var_68_21 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_14) / var_68_21

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_14 + var_68_21 and arg_65_1.time_ < var_68_14 + var_68_21 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play417141019 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 417141019
		arg_69_1.duration_ = 6.8

		local var_69_0 = {
			zh = 3.8,
			ja = 6.8
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
				arg_69_0:Play417141020(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["10113"]
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.actorSpriteComps10113 == nil then
				arg_69_1.var_.actorSpriteComps10113 = var_72_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_2 = 0.2

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 and not isNil(var_72_0) then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2

				if arg_69_1.var_.actorSpriteComps10113 then
					for iter_72_0, iter_72_1 in pairs(arg_69_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_72_1 then
							if arg_69_1.isInRecall_ then
								local var_72_4 = Mathf.Lerp(iter_72_1.color.r, arg_69_1.hightColor1.r, var_72_3)
								local var_72_5 = Mathf.Lerp(iter_72_1.color.g, arg_69_1.hightColor1.g, var_72_3)
								local var_72_6 = Mathf.Lerp(iter_72_1.color.b, arg_69_1.hightColor1.b, var_72_3)

								iter_72_1.color = Color.New(var_72_4, var_72_5, var_72_6)
							else
								local var_72_7 = Mathf.Lerp(iter_72_1.color.r, 1, var_72_3)

								iter_72_1.color = Color.New(var_72_7, var_72_7, var_72_7)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.actorSpriteComps10113 then
				for iter_72_2, iter_72_3 in pairs(arg_69_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_72_3 then
						if arg_69_1.isInRecall_ then
							iter_72_3.color = arg_69_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_72_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_69_1.var_.actorSpriteComps10113 = nil
			end

			local var_72_8 = arg_69_1.actors_["10113"].transform
			local var_72_9 = 0

			if var_72_9 < arg_69_1.time_ and arg_69_1.time_ <= var_72_9 + arg_72_0 then
				arg_69_1.var_.moveOldPos10113 = var_72_8.localPosition
				var_72_8.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("10113", 3)

				local var_72_10 = var_72_8.childCount

				for iter_72_4 = 0, var_72_10 - 1 do
					local var_72_11 = var_72_8:GetChild(iter_72_4)

					if var_72_11.name == "split_1" or not string.find(var_72_11.name, "split") then
						var_72_11.gameObject:SetActive(true)
					else
						var_72_11.gameObject:SetActive(false)
					end
				end
			end

			local var_72_12 = 0.001

			if var_72_9 <= arg_69_1.time_ and arg_69_1.time_ < var_72_9 + var_72_12 then
				local var_72_13 = (arg_69_1.time_ - var_72_9) / var_72_12
				local var_72_14 = Vector3.New(-30.38, -328.4, -517.4)

				var_72_8.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10113, var_72_14, var_72_13)
			end

			if arg_69_1.time_ >= var_72_9 + var_72_12 and arg_69_1.time_ < var_72_9 + var_72_12 + arg_72_0 then
				var_72_8.localPosition = Vector3.New(-30.38, -328.4, -517.4)
			end

			local var_72_15 = 0
			local var_72_16 = 0.4

			if var_72_15 < arg_69_1.time_ and arg_69_1.time_ <= var_72_15 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_17 = arg_69_1:FormatText(StoryNameCfg[1117].name)

				arg_69_1.leftNameTxt_.text = var_72_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_18 = arg_69_1:GetWordFromCfg(417141019)
				local var_72_19 = arg_69_1:FormatText(var_72_18.content)

				arg_69_1.text_.text = var_72_19

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_20 = 17
				local var_72_21 = utf8.len(var_72_19)
				local var_72_22 = var_72_20 <= 0 and var_72_16 or var_72_16 * (var_72_21 / var_72_20)

				if var_72_22 > 0 and var_72_16 < var_72_22 then
					arg_69_1.talkMaxDuration = var_72_22

					if var_72_22 + var_72_15 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_22 + var_72_15
					end
				end

				arg_69_1.text_.text = var_72_19
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417141", "417141019", "story_v_out_417141.awb") ~= 0 then
					local var_72_23 = manager.audio:GetVoiceLength("story_v_out_417141", "417141019", "story_v_out_417141.awb") / 1000

					if var_72_23 + var_72_15 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_23 + var_72_15
					end

					if var_72_18.prefab_name ~= "" and arg_69_1.actors_[var_72_18.prefab_name] ~= nil then
						local var_72_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_18.prefab_name].transform, "story_v_out_417141", "417141019", "story_v_out_417141.awb")

						arg_69_1:RecordAudio("417141019", var_72_24)
						arg_69_1:RecordAudio("417141019", var_72_24)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_417141", "417141019", "story_v_out_417141.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_417141", "417141019", "story_v_out_417141.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_25 = math.max(var_72_16, arg_69_1.talkMaxDuration)

			if var_72_15 <= arg_69_1.time_ and arg_69_1.time_ < var_72_15 + var_72_25 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_15) / var_72_25

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_15 + var_72_25 and arg_69_1.time_ < var_72_15 + var_72_25 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play417141020 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 417141020
		arg_73_1.duration_ = 3.97

		local var_73_0 = {
			zh = 3.1,
			ja = 3.966
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
				arg_73_0:Play417141021(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["10128"]
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.actorSpriteComps10128 == nil then
				arg_73_1.var_.actorSpriteComps10128 = var_76_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_2 = 0.1

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 and not isNil(var_76_0) then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2

				if arg_73_1.var_.actorSpriteComps10128 then
					for iter_76_0, iter_76_1 in pairs(arg_73_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_76_1 then
							if arg_73_1.isInRecall_ then
								local var_76_4 = Mathf.Lerp(iter_76_1.color.r, arg_73_1.hightColor1.r, var_76_3)
								local var_76_5 = Mathf.Lerp(iter_76_1.color.g, arg_73_1.hightColor1.g, var_76_3)
								local var_76_6 = Mathf.Lerp(iter_76_1.color.b, arg_73_1.hightColor1.b, var_76_3)

								iter_76_1.color = Color.New(var_76_4, var_76_5, var_76_6)
							else
								local var_76_7 = Mathf.Lerp(iter_76_1.color.r, 1, var_76_3)

								iter_76_1.color = Color.New(var_76_7, var_76_7, var_76_7)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.actorSpriteComps10128 then
				for iter_76_2, iter_76_3 in pairs(arg_73_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_76_3 then
						if arg_73_1.isInRecall_ then
							iter_76_3.color = arg_73_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_76_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_73_1.var_.actorSpriteComps10128 = nil
			end

			local var_76_8 = arg_73_1.actors_["10113"].transform
			local var_76_9 = 0

			if var_76_9 < arg_73_1.time_ and arg_73_1.time_ <= var_76_9 + arg_76_0 then
				arg_73_1.var_.moveOldPos10113 = var_76_8.localPosition
				var_76_8.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("10113", 7)

				local var_76_10 = var_76_8.childCount

				for iter_76_4 = 0, var_76_10 - 1 do
					local var_76_11 = var_76_8:GetChild(iter_76_4)

					if var_76_11.name == "" or not string.find(var_76_11.name, "split") then
						var_76_11.gameObject:SetActive(true)
					else
						var_76_11.gameObject:SetActive(false)
					end
				end
			end

			local var_76_12 = 0.001

			if var_76_9 <= arg_73_1.time_ and arg_73_1.time_ < var_76_9 + var_76_12 then
				local var_76_13 = (arg_73_1.time_ - var_76_9) / var_76_12
				local var_76_14 = Vector3.New(0, -2000, 0)

				var_76_8.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10113, var_76_14, var_76_13)
			end

			if arg_73_1.time_ >= var_76_9 + var_76_12 and arg_73_1.time_ < var_76_9 + var_76_12 + arg_76_0 then
				var_76_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_76_15 = arg_73_1.actors_["10128"].transform
			local var_76_16 = 0

			if var_76_16 < arg_73_1.time_ and arg_73_1.time_ <= var_76_16 + arg_76_0 then
				arg_73_1.var_.moveOldPos10128 = var_76_15.localPosition
				var_76_15.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("10128", 3)

				local var_76_17 = var_76_15.childCount

				for iter_76_5 = 0, var_76_17 - 1 do
					local var_76_18 = var_76_15:GetChild(iter_76_5)

					if var_76_18.name == "split_4" or not string.find(var_76_18.name, "split") then
						var_76_18.gameObject:SetActive(true)
					else
						var_76_18.gameObject:SetActive(false)
					end
				end
			end

			local var_76_19 = 0.001

			if var_76_16 <= arg_73_1.time_ and arg_73_1.time_ < var_76_16 + var_76_19 then
				local var_76_20 = (arg_73_1.time_ - var_76_16) / var_76_19
				local var_76_21 = Vector3.New(0, -347, -300)

				var_76_15.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10128, var_76_21, var_76_20)
			end

			if arg_73_1.time_ >= var_76_16 + var_76_19 and arg_73_1.time_ < var_76_16 + var_76_19 + arg_76_0 then
				var_76_15.localPosition = Vector3.New(0, -347, -300)
			end

			local var_76_22 = 0
			local var_76_23 = 0.375

			if var_76_22 < arg_73_1.time_ and arg_73_1.time_ <= var_76_22 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_24 = arg_73_1:FormatText(StoryNameCfg[595].name)

				arg_73_1.leftNameTxt_.text = var_76_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_25 = arg_73_1:GetWordFromCfg(417141020)
				local var_76_26 = arg_73_1:FormatText(var_76_25.content)

				arg_73_1.text_.text = var_76_26

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_27 = 15
				local var_76_28 = utf8.len(var_76_26)
				local var_76_29 = var_76_27 <= 0 and var_76_23 or var_76_23 * (var_76_28 / var_76_27)

				if var_76_29 > 0 and var_76_23 < var_76_29 then
					arg_73_1.talkMaxDuration = var_76_29

					if var_76_29 + var_76_22 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_29 + var_76_22
					end
				end

				arg_73_1.text_.text = var_76_26
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417141", "417141020", "story_v_out_417141.awb") ~= 0 then
					local var_76_30 = manager.audio:GetVoiceLength("story_v_out_417141", "417141020", "story_v_out_417141.awb") / 1000

					if var_76_30 + var_76_22 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_30 + var_76_22
					end

					if var_76_25.prefab_name ~= "" and arg_73_1.actors_[var_76_25.prefab_name] ~= nil then
						local var_76_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_25.prefab_name].transform, "story_v_out_417141", "417141020", "story_v_out_417141.awb")

						arg_73_1:RecordAudio("417141020", var_76_31)
						arg_73_1:RecordAudio("417141020", var_76_31)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_417141", "417141020", "story_v_out_417141.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_417141", "417141020", "story_v_out_417141.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_32 = math.max(var_76_23, arg_73_1.talkMaxDuration)

			if var_76_22 <= arg_73_1.time_ and arg_73_1.time_ < var_76_22 + var_76_32 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_22) / var_76_32

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_22 + var_76_32 and arg_73_1.time_ < var_76_22 + var_76_32 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play417141021 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 417141021
		arg_77_1.duration_ = 5.7

		local var_77_0 = {
			zh = 4.4,
			ja = 5.7
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
				arg_77_0:Play417141022(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["10113"]
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.actorSpriteComps10113 == nil then
				arg_77_1.var_.actorSpriteComps10113 = var_80_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_2 = 0.034

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 and not isNil(var_80_0) then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2

				if arg_77_1.var_.actorSpriteComps10113 then
					for iter_80_0, iter_80_1 in pairs(arg_77_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_80_1 then
							if arg_77_1.isInRecall_ then
								local var_80_4 = Mathf.Lerp(iter_80_1.color.r, arg_77_1.hightColor1.r, var_80_3)
								local var_80_5 = Mathf.Lerp(iter_80_1.color.g, arg_77_1.hightColor1.g, var_80_3)
								local var_80_6 = Mathf.Lerp(iter_80_1.color.b, arg_77_1.hightColor1.b, var_80_3)

								iter_80_1.color = Color.New(var_80_4, var_80_5, var_80_6)
							else
								local var_80_7 = Mathf.Lerp(iter_80_1.color.r, 1, var_80_3)

								iter_80_1.color = Color.New(var_80_7, var_80_7, var_80_7)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.actorSpriteComps10113 then
				for iter_80_2, iter_80_3 in pairs(arg_77_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_80_3 then
						if arg_77_1.isInRecall_ then
							iter_80_3.color = arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_80_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_77_1.var_.actorSpriteComps10113 = nil
			end

			local var_80_8 = arg_77_1.actors_["10128"]
			local var_80_9 = 0

			if var_80_9 < arg_77_1.time_ and arg_77_1.time_ <= var_80_9 + arg_80_0 and not isNil(var_80_8) and arg_77_1.var_.actorSpriteComps10128 == nil then
				arg_77_1.var_.actorSpriteComps10128 = var_80_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_10 = 0.2

			if var_80_9 <= arg_77_1.time_ and arg_77_1.time_ < var_80_9 + var_80_10 and not isNil(var_80_8) then
				local var_80_11 = (arg_77_1.time_ - var_80_9) / var_80_10

				if arg_77_1.var_.actorSpriteComps10128 then
					for iter_80_4, iter_80_5 in pairs(arg_77_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_80_5 then
							if arg_77_1.isInRecall_ then
								local var_80_12 = Mathf.Lerp(iter_80_5.color.r, arg_77_1.hightColor2.r, var_80_11)
								local var_80_13 = Mathf.Lerp(iter_80_5.color.g, arg_77_1.hightColor2.g, var_80_11)
								local var_80_14 = Mathf.Lerp(iter_80_5.color.b, arg_77_1.hightColor2.b, var_80_11)

								iter_80_5.color = Color.New(var_80_12, var_80_13, var_80_14)
							else
								local var_80_15 = Mathf.Lerp(iter_80_5.color.r, 0.5, var_80_11)

								iter_80_5.color = Color.New(var_80_15, var_80_15, var_80_15)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= var_80_9 + var_80_10 and arg_77_1.time_ < var_80_9 + var_80_10 + arg_80_0 and not isNil(var_80_8) and arg_77_1.var_.actorSpriteComps10128 then
				for iter_80_6, iter_80_7 in pairs(arg_77_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_80_7 then
						if arg_77_1.isInRecall_ then
							iter_80_7.color = arg_77_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_80_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_77_1.var_.actorSpriteComps10128 = nil
			end

			local var_80_16 = arg_77_1.actors_["10128"].transform
			local var_80_17 = 0

			if var_80_17 < arg_77_1.time_ and arg_77_1.time_ <= var_80_17 + arg_80_0 then
				arg_77_1.var_.moveOldPos10128 = var_80_16.localPosition
				var_80_16.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("10128", 2)

				local var_80_18 = var_80_16.childCount

				for iter_80_8 = 0, var_80_18 - 1 do
					local var_80_19 = var_80_16:GetChild(iter_80_8)

					if var_80_19.name == "split_4" or not string.find(var_80_19.name, "split") then
						var_80_19.gameObject:SetActive(true)
					else
						var_80_19.gameObject:SetActive(false)
					end
				end
			end

			local var_80_20 = 0.001

			if var_80_17 <= arg_77_1.time_ and arg_77_1.time_ < var_80_17 + var_80_20 then
				local var_80_21 = (arg_77_1.time_ - var_80_17) / var_80_20
				local var_80_22 = Vector3.New(-390, -347, -300)

				var_80_16.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10128, var_80_22, var_80_21)
			end

			if arg_77_1.time_ >= var_80_17 + var_80_20 and arg_77_1.time_ < var_80_17 + var_80_20 + arg_80_0 then
				var_80_16.localPosition = Vector3.New(-390, -347, -300)
			end

			local var_80_23 = arg_77_1.actors_["10113"].transform
			local var_80_24 = 0

			if var_80_24 < arg_77_1.time_ and arg_77_1.time_ <= var_80_24 + arg_80_0 then
				arg_77_1.var_.moveOldPos10113 = var_80_23.localPosition
				var_80_23.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("10113", 4)

				local var_80_25 = var_80_23.childCount

				for iter_80_9 = 0, var_80_25 - 1 do
					local var_80_26 = var_80_23:GetChild(iter_80_9)

					if var_80_26.name == "split_6" or not string.find(var_80_26.name, "split") then
						var_80_26.gameObject:SetActive(true)
					else
						var_80_26.gameObject:SetActive(false)
					end
				end
			end

			local var_80_27 = 0.001

			if var_80_24 <= arg_77_1.time_ and arg_77_1.time_ < var_80_24 + var_80_27 then
				local var_80_28 = (arg_77_1.time_ - var_80_24) / var_80_27
				local var_80_29 = Vector3.New(377.3, -328.4, -517.4)

				var_80_23.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10113, var_80_29, var_80_28)
			end

			if arg_77_1.time_ >= var_80_24 + var_80_27 and arg_77_1.time_ < var_80_24 + var_80_27 + arg_80_0 then
				var_80_23.localPosition = Vector3.New(377.3, -328.4, -517.4)
			end

			local var_80_30 = 0
			local var_80_31 = 0.45

			if var_80_30 < arg_77_1.time_ and arg_77_1.time_ <= var_80_30 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_32 = arg_77_1:FormatText(StoryNameCfg[1117].name)

				arg_77_1.leftNameTxt_.text = var_80_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_33 = arg_77_1:GetWordFromCfg(417141021)
				local var_80_34 = arg_77_1:FormatText(var_80_33.content)

				arg_77_1.text_.text = var_80_34

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_35 = 18
				local var_80_36 = utf8.len(var_80_34)
				local var_80_37 = var_80_35 <= 0 and var_80_31 or var_80_31 * (var_80_36 / var_80_35)

				if var_80_37 > 0 and var_80_31 < var_80_37 then
					arg_77_1.talkMaxDuration = var_80_37

					if var_80_37 + var_80_30 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_37 + var_80_30
					end
				end

				arg_77_1.text_.text = var_80_34
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417141", "417141021", "story_v_out_417141.awb") ~= 0 then
					local var_80_38 = manager.audio:GetVoiceLength("story_v_out_417141", "417141021", "story_v_out_417141.awb") / 1000

					if var_80_38 + var_80_30 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_38 + var_80_30
					end

					if var_80_33.prefab_name ~= "" and arg_77_1.actors_[var_80_33.prefab_name] ~= nil then
						local var_80_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_33.prefab_name].transform, "story_v_out_417141", "417141021", "story_v_out_417141.awb")

						arg_77_1:RecordAudio("417141021", var_80_39)
						arg_77_1:RecordAudio("417141021", var_80_39)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_417141", "417141021", "story_v_out_417141.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_417141", "417141021", "story_v_out_417141.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_40 = math.max(var_80_31, arg_77_1.talkMaxDuration)

			if var_80_30 <= arg_77_1.time_ and arg_77_1.time_ < var_80_30 + var_80_40 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_30) / var_80_40

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_30 + var_80_40 and arg_77_1.time_ < var_80_30 + var_80_40 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10113",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play417141022 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 417141022
		arg_81_1.duration_ = 10

		local var_81_0 = {
			zh = 6.433,
			ja = 10
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
				arg_81_0:Play417141023(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0
			local var_84_1 = 0.8

			if var_84_0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_2 = arg_81_1:FormatText(StoryNameCfg[1117].name)

				arg_81_1.leftNameTxt_.text = var_84_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_3 = arg_81_1:GetWordFromCfg(417141022)
				local var_84_4 = arg_81_1:FormatText(var_84_3.content)

				arg_81_1.text_.text = var_84_4

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_5 = 32
				local var_84_6 = utf8.len(var_84_4)
				local var_84_7 = var_84_5 <= 0 and var_84_1 or var_84_1 * (var_84_6 / var_84_5)

				if var_84_7 > 0 and var_84_1 < var_84_7 then
					arg_81_1.talkMaxDuration = var_84_7

					if var_84_7 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_7 + var_84_0
					end
				end

				arg_81_1.text_.text = var_84_4
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417141", "417141022", "story_v_out_417141.awb") ~= 0 then
					local var_84_8 = manager.audio:GetVoiceLength("story_v_out_417141", "417141022", "story_v_out_417141.awb") / 1000

					if var_84_8 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_8 + var_84_0
					end

					if var_84_3.prefab_name ~= "" and arg_81_1.actors_[var_84_3.prefab_name] ~= nil then
						local var_84_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_3.prefab_name].transform, "story_v_out_417141", "417141022", "story_v_out_417141.awb")

						arg_81_1:RecordAudio("417141022", var_84_9)
						arg_81_1:RecordAudio("417141022", var_84_9)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_417141", "417141022", "story_v_out_417141.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_417141", "417141022", "story_v_out_417141.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_10 = math.max(var_84_1, arg_81_1.talkMaxDuration)

			if var_84_0 <= arg_81_1.time_ and arg_81_1.time_ < var_84_0 + var_84_10 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_0) / var_84_10

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_0 + var_84_10 and arg_81_1.time_ < var_84_0 + var_84_10 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play417141023 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 417141023
		arg_85_1.duration_ = 5.8

		local var_85_0 = {
			zh = 2.066,
			ja = 5.8
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
				arg_85_0:Play417141024(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["10128"]
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.actorSpriteComps10128 == nil then
				arg_85_1.var_.actorSpriteComps10128 = var_88_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_2 = 0.2

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 and not isNil(var_88_0) then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2

				if arg_85_1.var_.actorSpriteComps10128 then
					for iter_88_0, iter_88_1 in pairs(arg_85_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_88_1 then
							if arg_85_1.isInRecall_ then
								local var_88_4 = Mathf.Lerp(iter_88_1.color.r, arg_85_1.hightColor1.r, var_88_3)
								local var_88_5 = Mathf.Lerp(iter_88_1.color.g, arg_85_1.hightColor1.g, var_88_3)
								local var_88_6 = Mathf.Lerp(iter_88_1.color.b, arg_85_1.hightColor1.b, var_88_3)

								iter_88_1.color = Color.New(var_88_4, var_88_5, var_88_6)
							else
								local var_88_7 = Mathf.Lerp(iter_88_1.color.r, 1, var_88_3)

								iter_88_1.color = Color.New(var_88_7, var_88_7, var_88_7)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.actorSpriteComps10128 then
				for iter_88_2, iter_88_3 in pairs(arg_85_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_88_3 then
						if arg_85_1.isInRecall_ then
							iter_88_3.color = arg_85_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_88_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_85_1.var_.actorSpriteComps10128 = nil
			end

			local var_88_8 = arg_85_1.actors_["10113"]
			local var_88_9 = 0

			if var_88_9 < arg_85_1.time_ and arg_85_1.time_ <= var_88_9 + arg_88_0 and not isNil(var_88_8) and arg_85_1.var_.actorSpriteComps10113 == nil then
				arg_85_1.var_.actorSpriteComps10113 = var_88_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_10 = 0.2

			if var_88_9 <= arg_85_1.time_ and arg_85_1.time_ < var_88_9 + var_88_10 and not isNil(var_88_8) then
				local var_88_11 = (arg_85_1.time_ - var_88_9) / var_88_10

				if arg_85_1.var_.actorSpriteComps10113 then
					for iter_88_4, iter_88_5 in pairs(arg_85_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_88_5 then
							if arg_85_1.isInRecall_ then
								local var_88_12 = Mathf.Lerp(iter_88_5.color.r, arg_85_1.hightColor2.r, var_88_11)
								local var_88_13 = Mathf.Lerp(iter_88_5.color.g, arg_85_1.hightColor2.g, var_88_11)
								local var_88_14 = Mathf.Lerp(iter_88_5.color.b, arg_85_1.hightColor2.b, var_88_11)

								iter_88_5.color = Color.New(var_88_12, var_88_13, var_88_14)
							else
								local var_88_15 = Mathf.Lerp(iter_88_5.color.r, 0.5, var_88_11)

								iter_88_5.color = Color.New(var_88_15, var_88_15, var_88_15)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= var_88_9 + var_88_10 and arg_85_1.time_ < var_88_9 + var_88_10 + arg_88_0 and not isNil(var_88_8) and arg_85_1.var_.actorSpriteComps10113 then
				for iter_88_6, iter_88_7 in pairs(arg_85_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_88_7 then
						if arg_85_1.isInRecall_ then
							iter_88_7.color = arg_85_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_88_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_85_1.var_.actorSpriteComps10113 = nil
			end

			local var_88_16 = arg_85_1.actors_["10128"].transform
			local var_88_17 = 0

			if var_88_17 < arg_85_1.time_ and arg_85_1.time_ <= var_88_17 + arg_88_0 then
				arg_85_1.var_.moveOldPos10128 = var_88_16.localPosition
				var_88_16.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("10128", 2)

				local var_88_18 = var_88_16.childCount

				for iter_88_8 = 0, var_88_18 - 1 do
					local var_88_19 = var_88_16:GetChild(iter_88_8)

					if var_88_19.name == "split_6" or not string.find(var_88_19.name, "split") then
						var_88_19.gameObject:SetActive(true)
					else
						var_88_19.gameObject:SetActive(false)
					end
				end
			end

			local var_88_20 = 0.001

			if var_88_17 <= arg_85_1.time_ and arg_85_1.time_ < var_88_17 + var_88_20 then
				local var_88_21 = (arg_85_1.time_ - var_88_17) / var_88_20
				local var_88_22 = Vector3.New(-390, -347, -300)

				var_88_16.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10128, var_88_22, var_88_21)
			end

			if arg_85_1.time_ >= var_88_17 + var_88_20 and arg_85_1.time_ < var_88_17 + var_88_20 + arg_88_0 then
				var_88_16.localPosition = Vector3.New(-390, -347, -300)
			end

			local var_88_23 = 0
			local var_88_24 = 0.25

			if var_88_23 < arg_85_1.time_ and arg_85_1.time_ <= var_88_23 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_25 = arg_85_1:FormatText(StoryNameCfg[595].name)

				arg_85_1.leftNameTxt_.text = var_88_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_26 = arg_85_1:GetWordFromCfg(417141023)
				local var_88_27 = arg_85_1:FormatText(var_88_26.content)

				arg_85_1.text_.text = var_88_27

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_28 = 10
				local var_88_29 = utf8.len(var_88_27)
				local var_88_30 = var_88_28 <= 0 and var_88_24 or var_88_24 * (var_88_29 / var_88_28)

				if var_88_30 > 0 and var_88_24 < var_88_30 then
					arg_85_1.talkMaxDuration = var_88_30

					if var_88_30 + var_88_23 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_30 + var_88_23
					end
				end

				arg_85_1.text_.text = var_88_27
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417141", "417141023", "story_v_out_417141.awb") ~= 0 then
					local var_88_31 = manager.audio:GetVoiceLength("story_v_out_417141", "417141023", "story_v_out_417141.awb") / 1000

					if var_88_31 + var_88_23 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_31 + var_88_23
					end

					if var_88_26.prefab_name ~= "" and arg_85_1.actors_[var_88_26.prefab_name] ~= nil then
						local var_88_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_26.prefab_name].transform, "story_v_out_417141", "417141023", "story_v_out_417141.awb")

						arg_85_1:RecordAudio("417141023", var_88_32)
						arg_85_1:RecordAudio("417141023", var_88_32)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_417141", "417141023", "story_v_out_417141.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_417141", "417141023", "story_v_out_417141.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_33 = math.max(var_88_24, arg_85_1.talkMaxDuration)

			if var_88_23 <= arg_85_1.time_ and arg_85_1.time_ < var_88_23 + var_88_33 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_23) / var_88_33

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_23 + var_88_33 and arg_85_1.time_ < var_88_23 + var_88_33 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play417141024 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 417141024
		arg_89_1.duration_ = 7.9

		local var_89_0 = {
			zh = 7.9,
			ja = 7.3
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
				arg_89_0:Play417141025(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["10113"]
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.actorSpriteComps10113 == nil then
				arg_89_1.var_.actorSpriteComps10113 = var_92_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_2 = 0.2

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 and not isNil(var_92_0) then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2

				if arg_89_1.var_.actorSpriteComps10113 then
					for iter_92_0, iter_92_1 in pairs(arg_89_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_92_1 then
							if arg_89_1.isInRecall_ then
								local var_92_4 = Mathf.Lerp(iter_92_1.color.r, arg_89_1.hightColor1.r, var_92_3)
								local var_92_5 = Mathf.Lerp(iter_92_1.color.g, arg_89_1.hightColor1.g, var_92_3)
								local var_92_6 = Mathf.Lerp(iter_92_1.color.b, arg_89_1.hightColor1.b, var_92_3)

								iter_92_1.color = Color.New(var_92_4, var_92_5, var_92_6)
							else
								local var_92_7 = Mathf.Lerp(iter_92_1.color.r, 1, var_92_3)

								iter_92_1.color = Color.New(var_92_7, var_92_7, var_92_7)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.actorSpriteComps10113 then
				for iter_92_2, iter_92_3 in pairs(arg_89_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_92_3 then
						if arg_89_1.isInRecall_ then
							iter_92_3.color = arg_89_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_92_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_89_1.var_.actorSpriteComps10113 = nil
			end

			local var_92_8 = arg_89_1.actors_["10128"]
			local var_92_9 = 0

			if var_92_9 < arg_89_1.time_ and arg_89_1.time_ <= var_92_9 + arg_92_0 and not isNil(var_92_8) and arg_89_1.var_.actorSpriteComps10128 == nil then
				arg_89_1.var_.actorSpriteComps10128 = var_92_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_10 = 0.2

			if var_92_9 <= arg_89_1.time_ and arg_89_1.time_ < var_92_9 + var_92_10 and not isNil(var_92_8) then
				local var_92_11 = (arg_89_1.time_ - var_92_9) / var_92_10

				if arg_89_1.var_.actorSpriteComps10128 then
					for iter_92_4, iter_92_5 in pairs(arg_89_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_92_5 then
							if arg_89_1.isInRecall_ then
								local var_92_12 = Mathf.Lerp(iter_92_5.color.r, arg_89_1.hightColor2.r, var_92_11)
								local var_92_13 = Mathf.Lerp(iter_92_5.color.g, arg_89_1.hightColor2.g, var_92_11)
								local var_92_14 = Mathf.Lerp(iter_92_5.color.b, arg_89_1.hightColor2.b, var_92_11)

								iter_92_5.color = Color.New(var_92_12, var_92_13, var_92_14)
							else
								local var_92_15 = Mathf.Lerp(iter_92_5.color.r, 0.5, var_92_11)

								iter_92_5.color = Color.New(var_92_15, var_92_15, var_92_15)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= var_92_9 + var_92_10 and arg_89_1.time_ < var_92_9 + var_92_10 + arg_92_0 and not isNil(var_92_8) and arg_89_1.var_.actorSpriteComps10128 then
				for iter_92_6, iter_92_7 in pairs(arg_89_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_92_7 then
						if arg_89_1.isInRecall_ then
							iter_92_7.color = arg_89_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_92_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_89_1.var_.actorSpriteComps10128 = nil
			end

			local var_92_16 = arg_89_1.actors_["10113"].transform
			local var_92_17 = 0

			if var_92_17 < arg_89_1.time_ and arg_89_1.time_ <= var_92_17 + arg_92_0 then
				arg_89_1.var_.moveOldPos10113 = var_92_16.localPosition
				var_92_16.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("10113", 4)

				local var_92_18 = var_92_16.childCount

				for iter_92_8 = 0, var_92_18 - 1 do
					local var_92_19 = var_92_16:GetChild(iter_92_8)

					if var_92_19.name == "split_6" or not string.find(var_92_19.name, "split") then
						var_92_19.gameObject:SetActive(true)
					else
						var_92_19.gameObject:SetActive(false)
					end
				end
			end

			local var_92_20 = 0.001

			if var_92_17 <= arg_89_1.time_ and arg_89_1.time_ < var_92_17 + var_92_20 then
				local var_92_21 = (arg_89_1.time_ - var_92_17) / var_92_20
				local var_92_22 = Vector3.New(377.3, -328.4, -517.4)

				var_92_16.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos10113, var_92_22, var_92_21)
			end

			if arg_89_1.time_ >= var_92_17 + var_92_20 and arg_89_1.time_ < var_92_17 + var_92_20 + arg_92_0 then
				var_92_16.localPosition = Vector3.New(377.3, -328.4, -517.4)
			end

			local var_92_23 = 0
			local var_92_24 = 0.775

			if var_92_23 < arg_89_1.time_ and arg_89_1.time_ <= var_92_23 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_25 = arg_89_1:FormatText(StoryNameCfg[1117].name)

				arg_89_1.leftNameTxt_.text = var_92_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_26 = arg_89_1:GetWordFromCfg(417141024)
				local var_92_27 = arg_89_1:FormatText(var_92_26.content)

				arg_89_1.text_.text = var_92_27

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_28 = 31
				local var_92_29 = utf8.len(var_92_27)
				local var_92_30 = var_92_28 <= 0 and var_92_24 or var_92_24 * (var_92_29 / var_92_28)

				if var_92_30 > 0 and var_92_24 < var_92_30 then
					arg_89_1.talkMaxDuration = var_92_30

					if var_92_30 + var_92_23 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_30 + var_92_23
					end
				end

				arg_89_1.text_.text = var_92_27
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417141", "417141024", "story_v_out_417141.awb") ~= 0 then
					local var_92_31 = manager.audio:GetVoiceLength("story_v_out_417141", "417141024", "story_v_out_417141.awb") / 1000

					if var_92_31 + var_92_23 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_31 + var_92_23
					end

					if var_92_26.prefab_name ~= "" and arg_89_1.actors_[var_92_26.prefab_name] ~= nil then
						local var_92_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_26.prefab_name].transform, "story_v_out_417141", "417141024", "story_v_out_417141.awb")

						arg_89_1:RecordAudio("417141024", var_92_32)
						arg_89_1:RecordAudio("417141024", var_92_32)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_417141", "417141024", "story_v_out_417141.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_417141", "417141024", "story_v_out_417141.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_33 = math.max(var_92_24, arg_89_1.talkMaxDuration)

			if var_92_23 <= arg_89_1.time_ and arg_89_1.time_ < var_92_23 + var_92_33 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_23) / var_92_33

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_23 + var_92_33 and arg_89_1.time_ < var_92_23 + var_92_33 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play417141025 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 417141025
		arg_93_1.duration_ = 8.83

		local var_93_0 = {
			zh = 7.533,
			ja = 8.833
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
				arg_93_0:Play417141026(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0
			local var_96_1 = 0.8

			if var_96_0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_2 = arg_93_1:FormatText(StoryNameCfg[1117].name)

				arg_93_1.leftNameTxt_.text = var_96_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_3 = arg_93_1:GetWordFromCfg(417141025)
				local var_96_4 = arg_93_1:FormatText(var_96_3.content)

				arg_93_1.text_.text = var_96_4

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_5 = 32
				local var_96_6 = utf8.len(var_96_4)
				local var_96_7 = var_96_5 <= 0 and var_96_1 or var_96_1 * (var_96_6 / var_96_5)

				if var_96_7 > 0 and var_96_1 < var_96_7 then
					arg_93_1.talkMaxDuration = var_96_7

					if var_96_7 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_7 + var_96_0
					end
				end

				arg_93_1.text_.text = var_96_4
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417141", "417141025", "story_v_out_417141.awb") ~= 0 then
					local var_96_8 = manager.audio:GetVoiceLength("story_v_out_417141", "417141025", "story_v_out_417141.awb") / 1000

					if var_96_8 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_8 + var_96_0
					end

					if var_96_3.prefab_name ~= "" and arg_93_1.actors_[var_96_3.prefab_name] ~= nil then
						local var_96_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_3.prefab_name].transform, "story_v_out_417141", "417141025", "story_v_out_417141.awb")

						arg_93_1:RecordAudio("417141025", var_96_9)
						arg_93_1:RecordAudio("417141025", var_96_9)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_417141", "417141025", "story_v_out_417141.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_417141", "417141025", "story_v_out_417141.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_10 = math.max(var_96_1, arg_93_1.talkMaxDuration)

			if var_96_0 <= arg_93_1.time_ and arg_93_1.time_ < var_96_0 + var_96_10 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_0) / var_96_10

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_0 + var_96_10 and arg_93_1.time_ < var_96_0 + var_96_10 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play417141026 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 417141026
		arg_97_1.duration_ = 7.4

		local var_97_0 = {
			zh = 5.9,
			ja = 7.4
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
				arg_97_0:Play417141027(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["10128"]
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.actorSpriteComps10128 == nil then
				arg_97_1.var_.actorSpriteComps10128 = var_100_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_2 = 0.2

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 and not isNil(var_100_0) then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2

				if arg_97_1.var_.actorSpriteComps10128 then
					for iter_100_0, iter_100_1 in pairs(arg_97_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_100_1 then
							if arg_97_1.isInRecall_ then
								local var_100_4 = Mathf.Lerp(iter_100_1.color.r, arg_97_1.hightColor1.r, var_100_3)
								local var_100_5 = Mathf.Lerp(iter_100_1.color.g, arg_97_1.hightColor1.g, var_100_3)
								local var_100_6 = Mathf.Lerp(iter_100_1.color.b, arg_97_1.hightColor1.b, var_100_3)

								iter_100_1.color = Color.New(var_100_4, var_100_5, var_100_6)
							else
								local var_100_7 = Mathf.Lerp(iter_100_1.color.r, 1, var_100_3)

								iter_100_1.color = Color.New(var_100_7, var_100_7, var_100_7)
							end
						end
					end
				end
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.actorSpriteComps10128 then
				for iter_100_2, iter_100_3 in pairs(arg_97_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_100_3 then
						if arg_97_1.isInRecall_ then
							iter_100_3.color = arg_97_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_100_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_97_1.var_.actorSpriteComps10128 = nil
			end

			local var_100_8 = arg_97_1.actors_["10113"]
			local var_100_9 = 0

			if var_100_9 < arg_97_1.time_ and arg_97_1.time_ <= var_100_9 + arg_100_0 and not isNil(var_100_8) and arg_97_1.var_.actorSpriteComps10113 == nil then
				arg_97_1.var_.actorSpriteComps10113 = var_100_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_10 = 0.2

			if var_100_9 <= arg_97_1.time_ and arg_97_1.time_ < var_100_9 + var_100_10 and not isNil(var_100_8) then
				local var_100_11 = (arg_97_1.time_ - var_100_9) / var_100_10

				if arg_97_1.var_.actorSpriteComps10113 then
					for iter_100_4, iter_100_5 in pairs(arg_97_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_100_5 then
							if arg_97_1.isInRecall_ then
								local var_100_12 = Mathf.Lerp(iter_100_5.color.r, arg_97_1.hightColor2.r, var_100_11)
								local var_100_13 = Mathf.Lerp(iter_100_5.color.g, arg_97_1.hightColor2.g, var_100_11)
								local var_100_14 = Mathf.Lerp(iter_100_5.color.b, arg_97_1.hightColor2.b, var_100_11)

								iter_100_5.color = Color.New(var_100_12, var_100_13, var_100_14)
							else
								local var_100_15 = Mathf.Lerp(iter_100_5.color.r, 0.5, var_100_11)

								iter_100_5.color = Color.New(var_100_15, var_100_15, var_100_15)
							end
						end
					end
				end
			end

			if arg_97_1.time_ >= var_100_9 + var_100_10 and arg_97_1.time_ < var_100_9 + var_100_10 + arg_100_0 and not isNil(var_100_8) and arg_97_1.var_.actorSpriteComps10113 then
				for iter_100_6, iter_100_7 in pairs(arg_97_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_100_7 then
						if arg_97_1.isInRecall_ then
							iter_100_7.color = arg_97_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_100_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_97_1.var_.actorSpriteComps10113 = nil
			end

			local var_100_16 = 0
			local var_100_17 = 0.65

			if var_100_16 < arg_97_1.time_ and arg_97_1.time_ <= var_100_16 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_18 = arg_97_1:FormatText(StoryNameCfg[595].name)

				arg_97_1.leftNameTxt_.text = var_100_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_19 = arg_97_1:GetWordFromCfg(417141026)
				local var_100_20 = arg_97_1:FormatText(var_100_19.content)

				arg_97_1.text_.text = var_100_20

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_21 = 26
				local var_100_22 = utf8.len(var_100_20)
				local var_100_23 = var_100_21 <= 0 and var_100_17 or var_100_17 * (var_100_22 / var_100_21)

				if var_100_23 > 0 and var_100_17 < var_100_23 then
					arg_97_1.talkMaxDuration = var_100_23

					if var_100_23 + var_100_16 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_23 + var_100_16
					end
				end

				arg_97_1.text_.text = var_100_20
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417141", "417141026", "story_v_out_417141.awb") ~= 0 then
					local var_100_24 = manager.audio:GetVoiceLength("story_v_out_417141", "417141026", "story_v_out_417141.awb") / 1000

					if var_100_24 + var_100_16 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_24 + var_100_16
					end

					if var_100_19.prefab_name ~= "" and arg_97_1.actors_[var_100_19.prefab_name] ~= nil then
						local var_100_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_19.prefab_name].transform, "story_v_out_417141", "417141026", "story_v_out_417141.awb")

						arg_97_1:RecordAudio("417141026", var_100_25)
						arg_97_1:RecordAudio("417141026", var_100_25)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_417141", "417141026", "story_v_out_417141.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_417141", "417141026", "story_v_out_417141.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_26 = math.max(var_100_17, arg_97_1.talkMaxDuration)

			if var_100_16 <= arg_97_1.time_ and arg_97_1.time_ < var_100_16 + var_100_26 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_16) / var_100_26

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_16 + var_100_26 and arg_97_1.time_ < var_100_16 + var_100_26 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play417141027 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 417141027
		arg_101_1.duration_ = 4.43

		local var_101_0 = {
			zh = 4.166,
			ja = 4.433
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
				arg_101_0:Play417141028(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["10113"]
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.actorSpriteComps10113 == nil then
				arg_101_1.var_.actorSpriteComps10113 = var_104_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_2 = 0.2

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 and not isNil(var_104_0) then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2

				if arg_101_1.var_.actorSpriteComps10113 then
					for iter_104_0, iter_104_1 in pairs(arg_101_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_104_1 then
							if arg_101_1.isInRecall_ then
								local var_104_4 = Mathf.Lerp(iter_104_1.color.r, arg_101_1.hightColor1.r, var_104_3)
								local var_104_5 = Mathf.Lerp(iter_104_1.color.g, arg_101_1.hightColor1.g, var_104_3)
								local var_104_6 = Mathf.Lerp(iter_104_1.color.b, arg_101_1.hightColor1.b, var_104_3)

								iter_104_1.color = Color.New(var_104_4, var_104_5, var_104_6)
							else
								local var_104_7 = Mathf.Lerp(iter_104_1.color.r, 1, var_104_3)

								iter_104_1.color = Color.New(var_104_7, var_104_7, var_104_7)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.actorSpriteComps10113 then
				for iter_104_2, iter_104_3 in pairs(arg_101_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_104_3 then
						if arg_101_1.isInRecall_ then
							iter_104_3.color = arg_101_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_104_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_101_1.var_.actorSpriteComps10113 = nil
			end

			local var_104_8 = arg_101_1.actors_["10128"]
			local var_104_9 = 0

			if var_104_9 < arg_101_1.time_ and arg_101_1.time_ <= var_104_9 + arg_104_0 and not isNil(var_104_8) and arg_101_1.var_.actorSpriteComps10128 == nil then
				arg_101_1.var_.actorSpriteComps10128 = var_104_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_10 = 0.2

			if var_104_9 <= arg_101_1.time_ and arg_101_1.time_ < var_104_9 + var_104_10 and not isNil(var_104_8) then
				local var_104_11 = (arg_101_1.time_ - var_104_9) / var_104_10

				if arg_101_1.var_.actorSpriteComps10128 then
					for iter_104_4, iter_104_5 in pairs(arg_101_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_104_5 then
							if arg_101_1.isInRecall_ then
								local var_104_12 = Mathf.Lerp(iter_104_5.color.r, arg_101_1.hightColor2.r, var_104_11)
								local var_104_13 = Mathf.Lerp(iter_104_5.color.g, arg_101_1.hightColor2.g, var_104_11)
								local var_104_14 = Mathf.Lerp(iter_104_5.color.b, arg_101_1.hightColor2.b, var_104_11)

								iter_104_5.color = Color.New(var_104_12, var_104_13, var_104_14)
							else
								local var_104_15 = Mathf.Lerp(iter_104_5.color.r, 0.5, var_104_11)

								iter_104_5.color = Color.New(var_104_15, var_104_15, var_104_15)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= var_104_9 + var_104_10 and arg_101_1.time_ < var_104_9 + var_104_10 + arg_104_0 and not isNil(var_104_8) and arg_101_1.var_.actorSpriteComps10128 then
				for iter_104_6, iter_104_7 in pairs(arg_101_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_104_7 then
						if arg_101_1.isInRecall_ then
							iter_104_7.color = arg_101_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_104_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_101_1.var_.actorSpriteComps10128 = nil
			end

			local var_104_16 = 0
			local var_104_17 = 0.425

			if var_104_16 < arg_101_1.time_ and arg_101_1.time_ <= var_104_16 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_18 = arg_101_1:FormatText(StoryNameCfg[1117].name)

				arg_101_1.leftNameTxt_.text = var_104_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_19 = arg_101_1:GetWordFromCfg(417141027)
				local var_104_20 = arg_101_1:FormatText(var_104_19.content)

				arg_101_1.text_.text = var_104_20

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_21 = 17
				local var_104_22 = utf8.len(var_104_20)
				local var_104_23 = var_104_21 <= 0 and var_104_17 or var_104_17 * (var_104_22 / var_104_21)

				if var_104_23 > 0 and var_104_17 < var_104_23 then
					arg_101_1.talkMaxDuration = var_104_23

					if var_104_23 + var_104_16 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_23 + var_104_16
					end
				end

				arg_101_1.text_.text = var_104_20
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417141", "417141027", "story_v_out_417141.awb") ~= 0 then
					local var_104_24 = manager.audio:GetVoiceLength("story_v_out_417141", "417141027", "story_v_out_417141.awb") / 1000

					if var_104_24 + var_104_16 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_24 + var_104_16
					end

					if var_104_19.prefab_name ~= "" and arg_101_1.actors_[var_104_19.prefab_name] ~= nil then
						local var_104_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_19.prefab_name].transform, "story_v_out_417141", "417141027", "story_v_out_417141.awb")

						arg_101_1:RecordAudio("417141027", var_104_25)
						arg_101_1:RecordAudio("417141027", var_104_25)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_417141", "417141027", "story_v_out_417141.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_417141", "417141027", "story_v_out_417141.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_26 = math.max(var_104_17, arg_101_1.talkMaxDuration)

			if var_104_16 <= arg_101_1.time_ and arg_101_1.time_ < var_104_16 + var_104_26 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_16) / var_104_26

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_16 + var_104_26 and arg_101_1.time_ < var_104_16 + var_104_26 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play417141028 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 417141028
		arg_105_1.duration_ = 6.37

		local var_105_0 = {
			zh = 5.266,
			ja = 6.366
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
				arg_105_0:Play417141029(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["10128"]
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.actorSpriteComps10128 == nil then
				arg_105_1.var_.actorSpriteComps10128 = var_108_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_2 = 0.2

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 and not isNil(var_108_0) then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2

				if arg_105_1.var_.actorSpriteComps10128 then
					for iter_108_0, iter_108_1 in pairs(arg_105_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_108_1 then
							if arg_105_1.isInRecall_ then
								local var_108_4 = Mathf.Lerp(iter_108_1.color.r, arg_105_1.hightColor1.r, var_108_3)
								local var_108_5 = Mathf.Lerp(iter_108_1.color.g, arg_105_1.hightColor1.g, var_108_3)
								local var_108_6 = Mathf.Lerp(iter_108_1.color.b, arg_105_1.hightColor1.b, var_108_3)

								iter_108_1.color = Color.New(var_108_4, var_108_5, var_108_6)
							else
								local var_108_7 = Mathf.Lerp(iter_108_1.color.r, 1, var_108_3)

								iter_108_1.color = Color.New(var_108_7, var_108_7, var_108_7)
							end
						end
					end
				end
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.actorSpriteComps10128 then
				for iter_108_2, iter_108_3 in pairs(arg_105_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_108_3 then
						if arg_105_1.isInRecall_ then
							iter_108_3.color = arg_105_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_108_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_105_1.var_.actorSpriteComps10128 = nil
			end

			local var_108_8 = arg_105_1.actors_["10113"]
			local var_108_9 = 0

			if var_108_9 < arg_105_1.time_ and arg_105_1.time_ <= var_108_9 + arg_108_0 and not isNil(var_108_8) and arg_105_1.var_.actorSpriteComps10113 == nil then
				arg_105_1.var_.actorSpriteComps10113 = var_108_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_10 = 0.2

			if var_108_9 <= arg_105_1.time_ and arg_105_1.time_ < var_108_9 + var_108_10 and not isNil(var_108_8) then
				local var_108_11 = (arg_105_1.time_ - var_108_9) / var_108_10

				if arg_105_1.var_.actorSpriteComps10113 then
					for iter_108_4, iter_108_5 in pairs(arg_105_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_108_5 then
							if arg_105_1.isInRecall_ then
								local var_108_12 = Mathf.Lerp(iter_108_5.color.r, arg_105_1.hightColor2.r, var_108_11)
								local var_108_13 = Mathf.Lerp(iter_108_5.color.g, arg_105_1.hightColor2.g, var_108_11)
								local var_108_14 = Mathf.Lerp(iter_108_5.color.b, arg_105_1.hightColor2.b, var_108_11)

								iter_108_5.color = Color.New(var_108_12, var_108_13, var_108_14)
							else
								local var_108_15 = Mathf.Lerp(iter_108_5.color.r, 0.5, var_108_11)

								iter_108_5.color = Color.New(var_108_15, var_108_15, var_108_15)
							end
						end
					end
				end
			end

			if arg_105_1.time_ >= var_108_9 + var_108_10 and arg_105_1.time_ < var_108_9 + var_108_10 + arg_108_0 and not isNil(var_108_8) and arg_105_1.var_.actorSpriteComps10113 then
				for iter_108_6, iter_108_7 in pairs(arg_105_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_108_7 then
						if arg_105_1.isInRecall_ then
							iter_108_7.color = arg_105_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_108_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_105_1.var_.actorSpriteComps10113 = nil
			end

			local var_108_16 = 0
			local var_108_17 = 0.6

			if var_108_16 < arg_105_1.time_ and arg_105_1.time_ <= var_108_16 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_18 = arg_105_1:FormatText(StoryNameCfg[595].name)

				arg_105_1.leftNameTxt_.text = var_108_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_19 = arg_105_1:GetWordFromCfg(417141028)
				local var_108_20 = arg_105_1:FormatText(var_108_19.content)

				arg_105_1.text_.text = var_108_20

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_21 = 24
				local var_108_22 = utf8.len(var_108_20)
				local var_108_23 = var_108_21 <= 0 and var_108_17 or var_108_17 * (var_108_22 / var_108_21)

				if var_108_23 > 0 and var_108_17 < var_108_23 then
					arg_105_1.talkMaxDuration = var_108_23

					if var_108_23 + var_108_16 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_23 + var_108_16
					end
				end

				arg_105_1.text_.text = var_108_20
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417141", "417141028", "story_v_out_417141.awb") ~= 0 then
					local var_108_24 = manager.audio:GetVoiceLength("story_v_out_417141", "417141028", "story_v_out_417141.awb") / 1000

					if var_108_24 + var_108_16 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_24 + var_108_16
					end

					if var_108_19.prefab_name ~= "" and arg_105_1.actors_[var_108_19.prefab_name] ~= nil then
						local var_108_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_19.prefab_name].transform, "story_v_out_417141", "417141028", "story_v_out_417141.awb")

						arg_105_1:RecordAudio("417141028", var_108_25)
						arg_105_1:RecordAudio("417141028", var_108_25)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_417141", "417141028", "story_v_out_417141.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_417141", "417141028", "story_v_out_417141.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_26 = math.max(var_108_17, arg_105_1.talkMaxDuration)

			if var_108_16 <= arg_105_1.time_ and arg_105_1.time_ < var_108_16 + var_108_26 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_16) / var_108_26

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_16 + var_108_26 and arg_105_1.time_ < var_108_16 + var_108_26 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play417141029 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 417141029
		arg_109_1.duration_ = 9.77

		local var_109_0 = {
			zh = 9.766,
			ja = 8.833
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
				arg_109_0:Play417141030(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0
			local var_112_1 = 1.075

			if var_112_0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_2 = arg_109_1:FormatText(StoryNameCfg[595].name)

				arg_109_1.leftNameTxt_.text = var_112_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_3 = arg_109_1:GetWordFromCfg(417141029)
				local var_112_4 = arg_109_1:FormatText(var_112_3.content)

				arg_109_1.text_.text = var_112_4

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_5 = 43
				local var_112_6 = utf8.len(var_112_4)
				local var_112_7 = var_112_5 <= 0 and var_112_1 or var_112_1 * (var_112_6 / var_112_5)

				if var_112_7 > 0 and var_112_1 < var_112_7 then
					arg_109_1.talkMaxDuration = var_112_7

					if var_112_7 + var_112_0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_7 + var_112_0
					end
				end

				arg_109_1.text_.text = var_112_4
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417141", "417141029", "story_v_out_417141.awb") ~= 0 then
					local var_112_8 = manager.audio:GetVoiceLength("story_v_out_417141", "417141029", "story_v_out_417141.awb") / 1000

					if var_112_8 + var_112_0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_8 + var_112_0
					end

					if var_112_3.prefab_name ~= "" and arg_109_1.actors_[var_112_3.prefab_name] ~= nil then
						local var_112_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_3.prefab_name].transform, "story_v_out_417141", "417141029", "story_v_out_417141.awb")

						arg_109_1:RecordAudio("417141029", var_112_9)
						arg_109_1:RecordAudio("417141029", var_112_9)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_417141", "417141029", "story_v_out_417141.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_417141", "417141029", "story_v_out_417141.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_10 = math.max(var_112_1, arg_109_1.talkMaxDuration)

			if var_112_0 <= arg_109_1.time_ and arg_109_1.time_ < var_112_0 + var_112_10 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_0) / var_112_10

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_0 + var_112_10 and arg_109_1.time_ < var_112_0 + var_112_10 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play417141030 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 417141030
		arg_113_1.duration_ = 4.6

		local var_113_0 = {
			zh = 3.866,
			ja = 4.6
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
				arg_113_0:Play417141031(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["10113"]
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.actorSpriteComps10113 == nil then
				arg_113_1.var_.actorSpriteComps10113 = var_116_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_2 = 0.2

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 and not isNil(var_116_0) then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2

				if arg_113_1.var_.actorSpriteComps10113 then
					for iter_116_0, iter_116_1 in pairs(arg_113_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_116_1 then
							if arg_113_1.isInRecall_ then
								local var_116_4 = Mathf.Lerp(iter_116_1.color.r, arg_113_1.hightColor1.r, var_116_3)
								local var_116_5 = Mathf.Lerp(iter_116_1.color.g, arg_113_1.hightColor1.g, var_116_3)
								local var_116_6 = Mathf.Lerp(iter_116_1.color.b, arg_113_1.hightColor1.b, var_116_3)

								iter_116_1.color = Color.New(var_116_4, var_116_5, var_116_6)
							else
								local var_116_7 = Mathf.Lerp(iter_116_1.color.r, 1, var_116_3)

								iter_116_1.color = Color.New(var_116_7, var_116_7, var_116_7)
							end
						end
					end
				end
			end

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.actorSpriteComps10113 then
				for iter_116_2, iter_116_3 in pairs(arg_113_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_116_3 then
						if arg_113_1.isInRecall_ then
							iter_116_3.color = arg_113_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_116_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_113_1.var_.actorSpriteComps10113 = nil
			end

			local var_116_8 = arg_113_1.actors_["10128"]
			local var_116_9 = 0

			if var_116_9 < arg_113_1.time_ and arg_113_1.time_ <= var_116_9 + arg_116_0 and not isNil(var_116_8) and arg_113_1.var_.actorSpriteComps10128 == nil then
				arg_113_1.var_.actorSpriteComps10128 = var_116_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_10 = 0.2

			if var_116_9 <= arg_113_1.time_ and arg_113_1.time_ < var_116_9 + var_116_10 and not isNil(var_116_8) then
				local var_116_11 = (arg_113_1.time_ - var_116_9) / var_116_10

				if arg_113_1.var_.actorSpriteComps10128 then
					for iter_116_4, iter_116_5 in pairs(arg_113_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_116_5 then
							if arg_113_1.isInRecall_ then
								local var_116_12 = Mathf.Lerp(iter_116_5.color.r, arg_113_1.hightColor2.r, var_116_11)
								local var_116_13 = Mathf.Lerp(iter_116_5.color.g, arg_113_1.hightColor2.g, var_116_11)
								local var_116_14 = Mathf.Lerp(iter_116_5.color.b, arg_113_1.hightColor2.b, var_116_11)

								iter_116_5.color = Color.New(var_116_12, var_116_13, var_116_14)
							else
								local var_116_15 = Mathf.Lerp(iter_116_5.color.r, 0.5, var_116_11)

								iter_116_5.color = Color.New(var_116_15, var_116_15, var_116_15)
							end
						end
					end
				end
			end

			if arg_113_1.time_ >= var_116_9 + var_116_10 and arg_113_1.time_ < var_116_9 + var_116_10 + arg_116_0 and not isNil(var_116_8) and arg_113_1.var_.actorSpriteComps10128 then
				for iter_116_6, iter_116_7 in pairs(arg_113_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_116_7 then
						if arg_113_1.isInRecall_ then
							iter_116_7.color = arg_113_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_116_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_113_1.var_.actorSpriteComps10128 = nil
			end

			local var_116_16 = arg_113_1.actors_["10113"].transform
			local var_116_17 = 0

			if var_116_17 < arg_113_1.time_ and arg_113_1.time_ <= var_116_17 + arg_116_0 then
				arg_113_1.var_.moveOldPos10113 = var_116_16.localPosition
				var_116_16.localScale = Vector3.New(1, 1, 1)

				arg_113_1:CheckSpriteTmpPos("10113", 4)

				local var_116_18 = var_116_16.childCount

				for iter_116_8 = 0, var_116_18 - 1 do
					local var_116_19 = var_116_16:GetChild(iter_116_8)

					if var_116_19.name == "split_2" or not string.find(var_116_19.name, "split") then
						var_116_19.gameObject:SetActive(true)
					else
						var_116_19.gameObject:SetActive(false)
					end
				end
			end

			local var_116_20 = 0.001

			if var_116_17 <= arg_113_1.time_ and arg_113_1.time_ < var_116_17 + var_116_20 then
				local var_116_21 = (arg_113_1.time_ - var_116_17) / var_116_20
				local var_116_22 = Vector3.New(377.3, -328.4, -517.4)

				var_116_16.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10113, var_116_22, var_116_21)
			end

			if arg_113_1.time_ >= var_116_17 + var_116_20 and arg_113_1.time_ < var_116_17 + var_116_20 + arg_116_0 then
				var_116_16.localPosition = Vector3.New(377.3, -328.4, -517.4)
			end

			local var_116_23 = 0
			local var_116_24 = 0.3

			if var_116_23 < arg_113_1.time_ and arg_113_1.time_ <= var_116_23 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_25 = arg_113_1:FormatText(StoryNameCfg[1117].name)

				arg_113_1.leftNameTxt_.text = var_116_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_26 = arg_113_1:GetWordFromCfg(417141030)
				local var_116_27 = arg_113_1:FormatText(var_116_26.content)

				arg_113_1.text_.text = var_116_27

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_28 = 12
				local var_116_29 = utf8.len(var_116_27)
				local var_116_30 = var_116_28 <= 0 and var_116_24 or var_116_24 * (var_116_29 / var_116_28)

				if var_116_30 > 0 and var_116_24 < var_116_30 then
					arg_113_1.talkMaxDuration = var_116_30

					if var_116_30 + var_116_23 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_30 + var_116_23
					end
				end

				arg_113_1.text_.text = var_116_27
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417141", "417141030", "story_v_out_417141.awb") ~= 0 then
					local var_116_31 = manager.audio:GetVoiceLength("story_v_out_417141", "417141030", "story_v_out_417141.awb") / 1000

					if var_116_31 + var_116_23 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_31 + var_116_23
					end

					if var_116_26.prefab_name ~= "" and arg_113_1.actors_[var_116_26.prefab_name] ~= nil then
						local var_116_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_26.prefab_name].transform, "story_v_out_417141", "417141030", "story_v_out_417141.awb")

						arg_113_1:RecordAudio("417141030", var_116_32)
						arg_113_1:RecordAudio("417141030", var_116_32)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_417141", "417141030", "story_v_out_417141.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_417141", "417141030", "story_v_out_417141.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_33 = math.max(var_116_24, arg_113_1.talkMaxDuration)

			if var_116_23 <= arg_113_1.time_ and arg_113_1.time_ < var_116_23 + var_116_33 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_23) / var_116_33

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_23 + var_116_33 and arg_113_1.time_ < var_116_23 + var_116_33 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play417141031 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 417141031
		arg_117_1.duration_ = 6.57

		local var_117_0 = {
			zh = 6.4,
			ja = 6.566
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
				arg_117_0:Play417141032(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0
			local var_120_1 = 0.725

			if var_120_0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_2 = arg_117_1:FormatText(StoryNameCfg[1117].name)

				arg_117_1.leftNameTxt_.text = var_120_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_3 = arg_117_1:GetWordFromCfg(417141031)
				local var_120_4 = arg_117_1:FormatText(var_120_3.content)

				arg_117_1.text_.text = var_120_4

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_5 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_417141", "417141031", "story_v_out_417141.awb") ~= 0 then
					local var_120_8 = manager.audio:GetVoiceLength("story_v_out_417141", "417141031", "story_v_out_417141.awb") / 1000

					if var_120_8 + var_120_0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_8 + var_120_0
					end

					if var_120_3.prefab_name ~= "" and arg_117_1.actors_[var_120_3.prefab_name] ~= nil then
						local var_120_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_3.prefab_name].transform, "story_v_out_417141", "417141031", "story_v_out_417141.awb")

						arg_117_1:RecordAudio("417141031", var_120_9)
						arg_117_1:RecordAudio("417141031", var_120_9)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_417141", "417141031", "story_v_out_417141.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_417141", "417141031", "story_v_out_417141.awb")
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
	Play417141032 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 417141032
		arg_121_1.duration_ = 11.9

		local var_121_0 = {
			zh = 11.9,
			ja = 7.5
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
				arg_121_0:Play417141033(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0
			local var_124_1 = 1.05

			if var_124_0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_2 = arg_121_1:FormatText(StoryNameCfg[1117].name)

				arg_121_1.leftNameTxt_.text = var_124_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_3 = arg_121_1:GetWordFromCfg(417141032)
				local var_124_4 = arg_121_1:FormatText(var_124_3.content)

				arg_121_1.text_.text = var_124_4

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_5 = 42
				local var_124_6 = utf8.len(var_124_4)
				local var_124_7 = var_124_5 <= 0 and var_124_1 or var_124_1 * (var_124_6 / var_124_5)

				if var_124_7 > 0 and var_124_1 < var_124_7 then
					arg_121_1.talkMaxDuration = var_124_7

					if var_124_7 + var_124_0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_7 + var_124_0
					end
				end

				arg_121_1.text_.text = var_124_4
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417141", "417141032", "story_v_out_417141.awb") ~= 0 then
					local var_124_8 = manager.audio:GetVoiceLength("story_v_out_417141", "417141032", "story_v_out_417141.awb") / 1000

					if var_124_8 + var_124_0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_8 + var_124_0
					end

					if var_124_3.prefab_name ~= "" and arg_121_1.actors_[var_124_3.prefab_name] ~= nil then
						local var_124_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_3.prefab_name].transform, "story_v_out_417141", "417141032", "story_v_out_417141.awb")

						arg_121_1:RecordAudio("417141032", var_124_9)
						arg_121_1:RecordAudio("417141032", var_124_9)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_417141", "417141032", "story_v_out_417141.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_417141", "417141032", "story_v_out_417141.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_10 = math.max(var_124_1, arg_121_1.talkMaxDuration)

			if var_124_0 <= arg_121_1.time_ and arg_121_1.time_ < var_124_0 + var_124_10 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_0) / var_124_10

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_0 + var_124_10 and arg_121_1.time_ < var_124_0 + var_124_10 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play417141033 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 417141033
		arg_125_1.duration_ = 3.5

		local var_125_0 = {
			zh = 3.5,
			ja = 3.433
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
				arg_125_0:Play417141034(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["10128"]
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.actorSpriteComps10128 == nil then
				arg_125_1.var_.actorSpriteComps10128 = var_128_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_128_2 = 0.2

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 and not isNil(var_128_0) then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2

				if arg_125_1.var_.actorSpriteComps10128 then
					for iter_128_0, iter_128_1 in pairs(arg_125_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_128_1 then
							if arg_125_1.isInRecall_ then
								local var_128_4 = Mathf.Lerp(iter_128_1.color.r, arg_125_1.hightColor1.r, var_128_3)
								local var_128_5 = Mathf.Lerp(iter_128_1.color.g, arg_125_1.hightColor1.g, var_128_3)
								local var_128_6 = Mathf.Lerp(iter_128_1.color.b, arg_125_1.hightColor1.b, var_128_3)

								iter_128_1.color = Color.New(var_128_4, var_128_5, var_128_6)
							else
								local var_128_7 = Mathf.Lerp(iter_128_1.color.r, 1, var_128_3)

								iter_128_1.color = Color.New(var_128_7, var_128_7, var_128_7)
							end
						end
					end
				end
			end

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.actorSpriteComps10128 then
				for iter_128_2, iter_128_3 in pairs(arg_125_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_128_3 then
						if arg_125_1.isInRecall_ then
							iter_128_3.color = arg_125_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_128_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_125_1.var_.actorSpriteComps10128 = nil
			end

			local var_128_8 = arg_125_1.actors_["10113"]
			local var_128_9 = 0

			if var_128_9 < arg_125_1.time_ and arg_125_1.time_ <= var_128_9 + arg_128_0 and not isNil(var_128_8) and arg_125_1.var_.actorSpriteComps10113 == nil then
				arg_125_1.var_.actorSpriteComps10113 = var_128_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_128_10 = 0.2

			if var_128_9 <= arg_125_1.time_ and arg_125_1.time_ < var_128_9 + var_128_10 and not isNil(var_128_8) then
				local var_128_11 = (arg_125_1.time_ - var_128_9) / var_128_10

				if arg_125_1.var_.actorSpriteComps10113 then
					for iter_128_4, iter_128_5 in pairs(arg_125_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_128_5 then
							if arg_125_1.isInRecall_ then
								local var_128_12 = Mathf.Lerp(iter_128_5.color.r, arg_125_1.hightColor2.r, var_128_11)
								local var_128_13 = Mathf.Lerp(iter_128_5.color.g, arg_125_1.hightColor2.g, var_128_11)
								local var_128_14 = Mathf.Lerp(iter_128_5.color.b, arg_125_1.hightColor2.b, var_128_11)

								iter_128_5.color = Color.New(var_128_12, var_128_13, var_128_14)
							else
								local var_128_15 = Mathf.Lerp(iter_128_5.color.r, 0.5, var_128_11)

								iter_128_5.color = Color.New(var_128_15, var_128_15, var_128_15)
							end
						end
					end
				end
			end

			if arg_125_1.time_ >= var_128_9 + var_128_10 and arg_125_1.time_ < var_128_9 + var_128_10 + arg_128_0 and not isNil(var_128_8) and arg_125_1.var_.actorSpriteComps10113 then
				for iter_128_6, iter_128_7 in pairs(arg_125_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_128_7 then
						if arg_125_1.isInRecall_ then
							iter_128_7.color = arg_125_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_128_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_125_1.var_.actorSpriteComps10113 = nil
			end

			local var_128_16 = 0
			local var_128_17 = 0.4

			if var_128_16 < arg_125_1.time_ and arg_125_1.time_ <= var_128_16 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_18 = arg_125_1:FormatText(StoryNameCfg[595].name)

				arg_125_1.leftNameTxt_.text = var_128_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_19 = arg_125_1:GetWordFromCfg(417141033)
				local var_128_20 = arg_125_1:FormatText(var_128_19.content)

				arg_125_1.text_.text = var_128_20

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_21 = 16
				local var_128_22 = utf8.len(var_128_20)
				local var_128_23 = var_128_21 <= 0 and var_128_17 or var_128_17 * (var_128_22 / var_128_21)

				if var_128_23 > 0 and var_128_17 < var_128_23 then
					arg_125_1.talkMaxDuration = var_128_23

					if var_128_23 + var_128_16 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_23 + var_128_16
					end
				end

				arg_125_1.text_.text = var_128_20
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417141", "417141033", "story_v_out_417141.awb") ~= 0 then
					local var_128_24 = manager.audio:GetVoiceLength("story_v_out_417141", "417141033", "story_v_out_417141.awb") / 1000

					if var_128_24 + var_128_16 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_24 + var_128_16
					end

					if var_128_19.prefab_name ~= "" and arg_125_1.actors_[var_128_19.prefab_name] ~= nil then
						local var_128_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_19.prefab_name].transform, "story_v_out_417141", "417141033", "story_v_out_417141.awb")

						arg_125_1:RecordAudio("417141033", var_128_25)
						arg_125_1:RecordAudio("417141033", var_128_25)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_417141", "417141033", "story_v_out_417141.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_417141", "417141033", "story_v_out_417141.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_26 = math.max(var_128_17, arg_125_1.talkMaxDuration)

			if var_128_16 <= arg_125_1.time_ and arg_125_1.time_ < var_128_16 + var_128_26 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_16) / var_128_26

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_16 + var_128_26 and arg_125_1.time_ < var_128_16 + var_128_26 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play417141034 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 417141034
		arg_129_1.duration_ = 7.13

		local var_129_0 = {
			zh = 7.133,
			ja = 6.833
		}
		local var_129_1 = manager.audio:GetLocalizationFlag()

		if var_129_0[var_129_1] ~= nil then
			arg_129_1.duration_ = var_129_0[var_129_1]
		end

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play417141035(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["10113"]
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.actorSpriteComps10113 == nil then
				arg_129_1.var_.actorSpriteComps10113 = var_132_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_132_2 = 0.2

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_2 and not isNil(var_132_0) then
				local var_132_3 = (arg_129_1.time_ - var_132_1) / var_132_2

				if arg_129_1.var_.actorSpriteComps10113 then
					for iter_132_0, iter_132_1 in pairs(arg_129_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_132_1 then
							if arg_129_1.isInRecall_ then
								local var_132_4 = Mathf.Lerp(iter_132_1.color.r, arg_129_1.hightColor1.r, var_132_3)
								local var_132_5 = Mathf.Lerp(iter_132_1.color.g, arg_129_1.hightColor1.g, var_132_3)
								local var_132_6 = Mathf.Lerp(iter_132_1.color.b, arg_129_1.hightColor1.b, var_132_3)

								iter_132_1.color = Color.New(var_132_4, var_132_5, var_132_6)
							else
								local var_132_7 = Mathf.Lerp(iter_132_1.color.r, 1, var_132_3)

								iter_132_1.color = Color.New(var_132_7, var_132_7, var_132_7)
							end
						end
					end
				end
			end

			if arg_129_1.time_ >= var_132_1 + var_132_2 and arg_129_1.time_ < var_132_1 + var_132_2 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.actorSpriteComps10113 then
				for iter_132_2, iter_132_3 in pairs(arg_129_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_132_3 then
						if arg_129_1.isInRecall_ then
							iter_132_3.color = arg_129_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_132_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_129_1.var_.actorSpriteComps10113 = nil
			end

			local var_132_8 = arg_129_1.actors_["10128"]
			local var_132_9 = 0

			if var_132_9 < arg_129_1.time_ and arg_129_1.time_ <= var_132_9 + arg_132_0 and not isNil(var_132_8) and arg_129_1.var_.actorSpriteComps10128 == nil then
				arg_129_1.var_.actorSpriteComps10128 = var_132_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_132_10 = 0.2

			if var_132_9 <= arg_129_1.time_ and arg_129_1.time_ < var_132_9 + var_132_10 and not isNil(var_132_8) then
				local var_132_11 = (arg_129_1.time_ - var_132_9) / var_132_10

				if arg_129_1.var_.actorSpriteComps10128 then
					for iter_132_4, iter_132_5 in pairs(arg_129_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_132_5 then
							if arg_129_1.isInRecall_ then
								local var_132_12 = Mathf.Lerp(iter_132_5.color.r, arg_129_1.hightColor2.r, var_132_11)
								local var_132_13 = Mathf.Lerp(iter_132_5.color.g, arg_129_1.hightColor2.g, var_132_11)
								local var_132_14 = Mathf.Lerp(iter_132_5.color.b, arg_129_1.hightColor2.b, var_132_11)

								iter_132_5.color = Color.New(var_132_12, var_132_13, var_132_14)
							else
								local var_132_15 = Mathf.Lerp(iter_132_5.color.r, 0.5, var_132_11)

								iter_132_5.color = Color.New(var_132_15, var_132_15, var_132_15)
							end
						end
					end
				end
			end

			if arg_129_1.time_ >= var_132_9 + var_132_10 and arg_129_1.time_ < var_132_9 + var_132_10 + arg_132_0 and not isNil(var_132_8) and arg_129_1.var_.actorSpriteComps10128 then
				for iter_132_6, iter_132_7 in pairs(arg_129_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_132_7 then
						if arg_129_1.isInRecall_ then
							iter_132_7.color = arg_129_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_132_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_129_1.var_.actorSpriteComps10128 = nil
			end

			local var_132_16 = 0
			local var_132_17 = 0.75

			if var_132_16 < arg_129_1.time_ and arg_129_1.time_ <= var_132_16 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_18 = arg_129_1:FormatText(StoryNameCfg[1117].name)

				arg_129_1.leftNameTxt_.text = var_132_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_19 = arg_129_1:GetWordFromCfg(417141034)
				local var_132_20 = arg_129_1:FormatText(var_132_19.content)

				arg_129_1.text_.text = var_132_20

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_21 = 30
				local var_132_22 = utf8.len(var_132_20)
				local var_132_23 = var_132_21 <= 0 and var_132_17 or var_132_17 * (var_132_22 / var_132_21)

				if var_132_23 > 0 and var_132_17 < var_132_23 then
					arg_129_1.talkMaxDuration = var_132_23

					if var_132_23 + var_132_16 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_23 + var_132_16
					end
				end

				arg_129_1.text_.text = var_132_20
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417141", "417141034", "story_v_out_417141.awb") ~= 0 then
					local var_132_24 = manager.audio:GetVoiceLength("story_v_out_417141", "417141034", "story_v_out_417141.awb") / 1000

					if var_132_24 + var_132_16 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_24 + var_132_16
					end

					if var_132_19.prefab_name ~= "" and arg_129_1.actors_[var_132_19.prefab_name] ~= nil then
						local var_132_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_19.prefab_name].transform, "story_v_out_417141", "417141034", "story_v_out_417141.awb")

						arg_129_1:RecordAudio("417141034", var_132_25)
						arg_129_1:RecordAudio("417141034", var_132_25)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_417141", "417141034", "story_v_out_417141.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_417141", "417141034", "story_v_out_417141.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_26 = math.max(var_132_17, arg_129_1.talkMaxDuration)

			if var_132_16 <= arg_129_1.time_ and arg_129_1.time_ < var_132_16 + var_132_26 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_16) / var_132_26

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_16 + var_132_26 and arg_129_1.time_ < var_132_16 + var_132_26 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play417141035 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 417141035
		arg_133_1.duration_ = 3.43

		local var_133_0 = {
			zh = 3.433,
			ja = 2.266
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
				arg_133_0:Play417141036(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["10113"].transform
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 then
				arg_133_1.var_.moveOldPos10113 = var_136_0.localPosition
				var_136_0.localScale = Vector3.New(1, 1, 1)

				arg_133_1:CheckSpriteTmpPos("10113", 3)

				local var_136_2 = var_136_0.childCount

				for iter_136_0 = 0, var_136_2 - 1 do
					local var_136_3 = var_136_0:GetChild(iter_136_0)

					if var_136_3.name == "split_6" or not string.find(var_136_3.name, "split") then
						var_136_3.gameObject:SetActive(true)
					else
						var_136_3.gameObject:SetActive(false)
					end
				end
			end

			local var_136_4 = 0.001

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_4 then
				local var_136_5 = (arg_133_1.time_ - var_136_1) / var_136_4
				local var_136_6 = Vector3.New(-30.38, -328.4, -517.4)

				var_136_0.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos10113, var_136_6, var_136_5)
			end

			if arg_133_1.time_ >= var_136_1 + var_136_4 and arg_133_1.time_ < var_136_1 + var_136_4 + arg_136_0 then
				var_136_0.localPosition = Vector3.New(-30.38, -328.4, -517.4)
			end

			local var_136_7 = arg_133_1.actors_["10128"].transform
			local var_136_8 = 0

			if var_136_8 < arg_133_1.time_ and arg_133_1.time_ <= var_136_8 + arg_136_0 then
				arg_133_1.var_.moveOldPos10128 = var_136_7.localPosition
				var_136_7.localScale = Vector3.New(1, 1, 1)

				arg_133_1:CheckSpriteTmpPos("10128", 7)

				local var_136_9 = var_136_7.childCount

				for iter_136_1 = 0, var_136_9 - 1 do
					local var_136_10 = var_136_7:GetChild(iter_136_1)

					if var_136_10.name == "" or not string.find(var_136_10.name, "split") then
						var_136_10.gameObject:SetActive(true)
					else
						var_136_10.gameObject:SetActive(false)
					end
				end
			end

			local var_136_11 = 0.001

			if var_136_8 <= arg_133_1.time_ and arg_133_1.time_ < var_136_8 + var_136_11 then
				local var_136_12 = (arg_133_1.time_ - var_136_8) / var_136_11
				local var_136_13 = Vector3.New(0, -2000, -300)

				var_136_7.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos10128, var_136_13, var_136_12)
			end

			if arg_133_1.time_ >= var_136_8 + var_136_11 and arg_133_1.time_ < var_136_8 + var_136_11 + arg_136_0 then
				var_136_7.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_136_14 = 0
			local var_136_15 = 0.225

			if var_136_14 < arg_133_1.time_ and arg_133_1.time_ <= var_136_14 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_16 = arg_133_1:FormatText(StoryNameCfg[1117].name)

				arg_133_1.leftNameTxt_.text = var_136_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_17 = arg_133_1:GetWordFromCfg(417141035)
				local var_136_18 = arg_133_1:FormatText(var_136_17.content)

				arg_133_1.text_.text = var_136_18

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_19 = 9
				local var_136_20 = utf8.len(var_136_18)
				local var_136_21 = var_136_19 <= 0 and var_136_15 or var_136_15 * (var_136_20 / var_136_19)

				if var_136_21 > 0 and var_136_15 < var_136_21 then
					arg_133_1.talkMaxDuration = var_136_21

					if var_136_21 + var_136_14 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_21 + var_136_14
					end
				end

				arg_133_1.text_.text = var_136_18
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417141", "417141035", "story_v_out_417141.awb") ~= 0 then
					local var_136_22 = manager.audio:GetVoiceLength("story_v_out_417141", "417141035", "story_v_out_417141.awb") / 1000

					if var_136_22 + var_136_14 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_22 + var_136_14
					end

					if var_136_17.prefab_name ~= "" and arg_133_1.actors_[var_136_17.prefab_name] ~= nil then
						local var_136_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_17.prefab_name].transform, "story_v_out_417141", "417141035", "story_v_out_417141.awb")

						arg_133_1:RecordAudio("417141035", var_136_23)
						arg_133_1:RecordAudio("417141035", var_136_23)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_417141", "417141035", "story_v_out_417141.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_417141", "417141035", "story_v_out_417141.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_24 = math.max(var_136_15, arg_133_1.talkMaxDuration)

			if var_136_14 <= arg_133_1.time_ and arg_133_1.time_ < var_136_14 + var_136_24 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_14) / var_136_24

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_14 + var_136_24 and arg_133_1.time_ < var_136_14 + var_136_24 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play417141036 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 417141036
		arg_137_1.duration_ = 14.8

		local var_137_0 = {
			zh = 14.7993333333333,
			ja = 14.1333333333333
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
				arg_137_0:Play417141037(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 7.03333333333333

			if var_140_0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_0 + arg_140_0 then
				arg_137_1.allBtn_.enabled = false
			end

			local var_140_1 = 0.3

			if arg_137_1.time_ >= var_140_0 + var_140_1 and arg_137_1.time_ < var_140_0 + var_140_1 + arg_140_0 then
				arg_137_1.allBtn_.enabled = true
			end

			local var_140_2 = 0

			if var_140_2 < arg_137_1.time_ and arg_137_1.time_ <= var_140_2 + arg_140_0 then
				arg_137_1.mask_.enabled = true
				arg_137_1.mask_.raycastTarget = false

				arg_137_1:SetGaussion(false)
			end

			local var_140_3 = 1

			if var_140_2 <= arg_137_1.time_ and arg_137_1.time_ < var_140_2 + var_140_3 then
				local var_140_4 = (arg_137_1.time_ - var_140_2) / var_140_3
				local var_140_5 = Color.New(0, 0, 0)

				var_140_5.a = Mathf.Lerp(1, 0, var_140_4)
				arg_137_1.mask_.color = var_140_5
			end

			if arg_137_1.time_ >= var_140_2 + var_140_3 and arg_137_1.time_ < var_140_2 + var_140_3 + arg_140_0 then
				local var_140_6 = Color.New(0, 0, 0)
				local var_140_7 = 0

				arg_137_1.mask_.enabled = false
				var_140_6.a = var_140_7
				arg_137_1.mask_.color = var_140_6
			end

			local var_140_8 = 0
			local var_140_9 = 5
			local var_140_10 = "B10"

			if var_140_8 < arg_137_1.time_ and arg_137_1.time_ <= var_140_8 + arg_140_0 then
				arg_137_1.timestampController_:SetSelectedState("show")
				arg_137_1.timestampAni_:Play("in")

				arg_137_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_140_10)

				arg_137_1.timestampColorController_:SetSelectedState("cold")
				arg_137_1.timeColdImg_:SetAlpha(0.031)

				local var_140_11 = arg_137_1:GetWordFromCfg(501047)
				local var_140_12 = arg_137_1:FormatText(var_140_11.content)

				arg_137_1.text_timeText_.text = var_140_12

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_timeText_)

				local var_140_13 = arg_137_1:GetWordFromCfg(501048)
				local var_140_14 = arg_137_1:FormatText(var_140_13.content)

				arg_137_1.text_siteText_.text = var_140_14

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_siteText_)
			end

			if arg_137_1.time_ >= var_140_8 + var_140_9 and arg_137_1.time_ < var_140_8 + var_140_9 + arg_140_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_137_1.timestampAni_, "out", function()
					arg_137_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_140_15 = 5

			if var_140_15 < arg_137_1.time_ and arg_137_1.time_ <= var_140_15 + arg_140_0 then
				arg_137_1.mask_.enabled = true
				arg_137_1.mask_.raycastTarget = true

				arg_137_1:SetGaussion(false)
			end

			local var_140_16 = 1.2

			if var_140_15 <= arg_137_1.time_ and arg_137_1.time_ < var_140_15 + var_140_16 then
				local var_140_17 = (arg_137_1.time_ - var_140_15) / var_140_16
				local var_140_18 = Color.New(0, 0, 0)

				var_140_18.a = Mathf.Lerp(0, 1, var_140_17)
				arg_137_1.mask_.color = var_140_18
			end

			if arg_137_1.time_ >= var_140_15 + var_140_16 and arg_137_1.time_ < var_140_15 + var_140_16 + arg_140_0 then
				local var_140_19 = Color.New(0, 0, 0)

				var_140_19.a = 1
				arg_137_1.mask_.color = var_140_19
			end

			local var_140_20 = 6.2

			if var_140_20 < arg_137_1.time_ and arg_137_1.time_ <= var_140_20 + arg_140_0 then
				arg_137_1.mask_.enabled = true
				arg_137_1.mask_.raycastTarget = true

				arg_137_1:SetGaussion(false)
			end

			local var_140_21 = 1.2

			if var_140_20 <= arg_137_1.time_ and arg_137_1.time_ < var_140_20 + var_140_21 then
				local var_140_22 = (arg_137_1.time_ - var_140_20) / var_140_21
				local var_140_23 = Color.New(0, 0, 0)

				var_140_23.a = Mathf.Lerp(1, 0, var_140_22)
				arg_137_1.mask_.color = var_140_23
			end

			if arg_137_1.time_ >= var_140_20 + var_140_21 and arg_137_1.time_ < var_140_20 + var_140_21 + arg_140_0 then
				local var_140_24 = Color.New(0, 0, 0)
				local var_140_25 = 0

				arg_137_1.mask_.enabled = false
				var_140_24.a = var_140_25
				arg_137_1.mask_.color = var_140_24
			end

			local var_140_26 = "I07"

			if arg_137_1.bgs_[var_140_26] == nil then
				local var_140_27 = Object.Instantiate(arg_137_1.paintGo_)

				var_140_27:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_140_26)
				var_140_27.name = var_140_26
				var_140_27.transform.parent = arg_137_1.stage_.transform
				var_140_27.transform.localPosition = Vector3.New(0, 100, 0)
				arg_137_1.bgs_[var_140_26] = var_140_27
			end

			local var_140_28 = 0

			if var_140_28 < arg_137_1.time_ and arg_137_1.time_ <= var_140_28 + arg_140_0 then
				local var_140_29 = manager.ui.mainCamera.transform.localPosition
				local var_140_30 = Vector3.New(0, 0, 10) + Vector3.New(var_140_29.x, var_140_29.y, 0)
				local var_140_31 = arg_137_1.bgs_.I07

				var_140_31.transform.localPosition = var_140_30
				var_140_31.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_140_32 = var_140_31:GetComponent("SpriteRenderer")

				if var_140_32 and var_140_32.sprite then
					local var_140_33 = (var_140_31.transform.localPosition - var_140_29).z
					local var_140_34 = manager.ui.mainCameraCom_
					local var_140_35 = 2 * var_140_33 * Mathf.Tan(var_140_34.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_140_36 = var_140_35 * var_140_34.aspect
					local var_140_37 = var_140_32.sprite.bounds.size.x
					local var_140_38 = var_140_32.sprite.bounds.size.y
					local var_140_39 = var_140_36 / var_140_37
					local var_140_40 = var_140_35 / var_140_38
					local var_140_41 = var_140_40 < var_140_39 and var_140_39 or var_140_40

					var_140_31.transform.localScale = Vector3.New(var_140_41, var_140_41, 0)
				end

				for iter_140_0, iter_140_1 in pairs(arg_137_1.bgs_) do
					if iter_140_0 ~= "I07" then
						iter_140_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_140_42 = manager.ui.mainCamera.transform
			local var_140_43 = 6.2

			if var_140_43 < arg_137_1.time_ and arg_137_1.time_ <= var_140_43 + arg_140_0 then
				local var_140_44 = arg_137_1.var_.effect1036
				local var_140_45
				local var_140_46 = var_140_42

				if not var_140_44 then
					var_140_44 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_jingbao_in_keep"), var_140_46)
					var_140_44.name = "1036"
					arg_137_1.var_.effect1036 = var_140_44
				else
					var_140_44.transform:SetParent(var_140_46)
				end

				var_140_44.transform.localPosition = Vector3.New(0, 0, -0.6)
				var_140_44.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_140_47 = manager.ui.mainCameraCom_
				local var_140_48 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_140_47.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_140_49 = var_140_44.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_140_50 = 15
				local var_140_51 = 2 * var_140_50 * Mathf.Tan(var_140_47.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_140_47.aspect
				local var_140_52 = 1
				local var_140_53 = 1.7777777777777777

				if var_140_53 < var_140_47.aspect then
					var_140_52 = var_140_51 / (2 * var_140_50 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_140_53)
				end

				for iter_140_2, iter_140_3 in ipairs(var_140_49) do
					local var_140_54 = iter_140_3.transform.localScale

					iter_140_3.transform.localScale = Vector3.New(var_140_54.x / var_140_48 * var_140_52, var_140_54.y / var_140_48, var_140_54.z)
				end
			end

			local var_140_55 = arg_137_1.actors_["10113"].transform
			local var_140_56 = 0

			if var_140_56 < arg_137_1.time_ and arg_137_1.time_ <= var_140_56 + arg_140_0 then
				arg_137_1.var_.moveOldPos10113 = var_140_55.localPosition
				var_140_55.localScale = Vector3.New(1, 1, 1)

				arg_137_1:CheckSpriteTmpPos("10113", 7)

				local var_140_57 = var_140_55.childCount

				for iter_140_4 = 0, var_140_57 - 1 do
					local var_140_58 = var_140_55:GetChild(iter_140_4)

					if var_140_58.name == "" or not string.find(var_140_58.name, "split") then
						var_140_58.gameObject:SetActive(true)
					else
						var_140_58.gameObject:SetActive(false)
					end
				end
			end

			local var_140_59 = 0.001

			if var_140_56 <= arg_137_1.time_ and arg_137_1.time_ < var_140_56 + var_140_59 then
				local var_140_60 = (arg_137_1.time_ - var_140_56) / var_140_59
				local var_140_61 = Vector3.New(0, -2000, 0)

				var_140_55.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos10113, var_140_61, var_140_60)
			end

			if arg_137_1.time_ >= var_140_56 + var_140_59 and arg_137_1.time_ < var_140_56 + var_140_59 + arg_140_0 then
				var_140_55.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_140_62 = 0

			arg_137_1.isInRecall_ = false

			if var_140_62 < arg_137_1.time_ and arg_137_1.time_ <= var_140_62 + arg_140_0 then
				arg_137_1.screenFilterGo_:SetActive(false)

				for iter_140_5, iter_140_6 in pairs(arg_137_1.actors_) do
					local var_140_63 = iter_140_6:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_140_7, iter_140_8 in ipairs(var_140_63) do
						if iter_140_8.color.r > 0.51 then
							iter_140_8.color = Color.New(1, 1, 1)
						else
							iter_140_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_140_64 = 0.1

			if var_140_62 <= arg_137_1.time_ and arg_137_1.time_ < var_140_62 + var_140_64 then
				local var_140_65 = (arg_137_1.time_ - var_140_62) / var_140_64

				arg_137_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_140_65)
			end

			if arg_137_1.time_ >= var_140_62 + var_140_64 and arg_137_1.time_ < var_140_62 + var_140_64 + arg_140_0 then
				arg_137_1.screenFilterEffect_.weight = 0
			end

			local var_140_66 = 6.2
			local var_140_67 = 1

			if var_140_66 < arg_137_1.time_ and arg_137_1.time_ <= var_140_66 + arg_140_0 then
				local var_140_68 = "play"
				local var_140_69 = "effect"

				arg_137_1:AudioAction(var_140_68, var_140_69, "se_story_1311", "se_story_1311_alarm", "")
			end

			local var_140_70 = 0
			local var_140_71 = 0.2

			if var_140_70 < arg_137_1.time_ and arg_137_1.time_ <= var_140_70 + arg_140_0 then
				local var_140_72 = "play"
				local var_140_73 = "music"

				arg_137_1:AudioAction(var_140_72, var_140_73, "ui_battle", "ui_battle_stopbgm", "")

				local var_140_74 = ""
				local var_140_75 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_140_75 ~= "" then
					if arg_137_1.bgmTxt_.text ~= var_140_75 and arg_137_1.bgmTxt_.text ~= "" then
						if arg_137_1.bgmTxt2_.text ~= "" then
							arg_137_1.bgmTxt_.text = arg_137_1.bgmTxt2_.text
						end

						arg_137_1.bgmTxt2_.text = var_140_75

						arg_137_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_137_1.bgmTxt_.text = var_140_75
						arg_137_1.bgmTxt2_.text = var_140_75
					end

					if arg_137_1.bgmTimer then
						arg_137_1.bgmTimer:Stop()

						arg_137_1.bgmTimer = nil
					end

					if arg_137_1.settingData.show_music_name == 1 then
						arg_137_1.musicController:SetSelectedState("show")
						arg_137_1.musicAnimator_:Play("open", 0, 0)

						if arg_137_1.settingData.music_time ~= 0 then
							arg_137_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_137_1.settingData.music_time), function()
								if arg_137_1 == nil or isNil(arg_137_1.bgmTxt_) then
									return
								end

								arg_137_1.musicController:SetSelectedState("hide")
								arg_137_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_140_76 = 0.2
			local var_140_77 = 1

			if var_140_76 < arg_137_1.time_ and arg_137_1.time_ <= var_140_76 + arg_140_0 then
				local var_140_78 = "play"
				local var_140_79 = "music"

				arg_137_1:AudioAction(var_140_78, var_140_79, "bgm_activity_3_8_story_corg", "bgm_activity_3_8_story_corg", "bgm_activity_3_8_story_corg.awb")

				local var_140_80 = ""
				local var_140_81 = manager.audio:GetAudioName("bgm_activity_3_8_story_corg", "bgm_activity_3_8_story_corg")

				if var_140_81 ~= "" then
					if arg_137_1.bgmTxt_.text ~= var_140_81 and arg_137_1.bgmTxt_.text ~= "" then
						if arg_137_1.bgmTxt2_.text ~= "" then
							arg_137_1.bgmTxt_.text = arg_137_1.bgmTxt2_.text
						end

						arg_137_1.bgmTxt2_.text = var_140_81

						arg_137_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_137_1.bgmTxt_.text = var_140_81
						arg_137_1.bgmTxt2_.text = var_140_81
					end

					if arg_137_1.bgmTimer then
						arg_137_1.bgmTimer:Stop()

						arg_137_1.bgmTimer = nil
					end

					if arg_137_1.settingData.show_music_name == 1 then
						arg_137_1.musicController:SetSelectedState("show")
						arg_137_1.musicAnimator_:Play("open", 0, 0)

						if arg_137_1.settingData.music_time ~= 0 then
							arg_137_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_137_1.settingData.music_time), function()
								if arg_137_1 == nil or isNil(arg_137_1.bgmTxt_) then
									return
								end

								arg_137_1.musicController:SetSelectedState("hide")
								arg_137_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_137_1.frameCnt_ <= 1 then
				arg_137_1.dialog_:SetActive(false)
			end

			local var_140_82 = 7.03333333333333
			local var_140_83 = 0.825

			if var_140_82 < arg_137_1.time_ and arg_137_1.time_ <= var_140_82 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0

				arg_137_1.dialog_:SetActive(true)

				arg_137_1.dialogCg_.alpha = 0

				local var_140_84 = LeanTween.value(arg_137_1.dialog_, 0, 1, 0.3)

				var_140_84:setOnUpdate(LuaHelper.FloatAction(function(arg_144_0)
					arg_137_1.dialogCg_.alpha = arg_144_0
				end))
				var_140_84:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_137_1.dialog_)
					var_140_84:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_137_1.duration_ = arg_137_1.duration_ + 0.3

				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_85 = arg_137_1:FormatText(StoryNameCfg[672].name)

				arg_137_1.leftNameTxt_.text = var_140_85

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, true)
				arg_137_1.iconController_:SetSelectedState("hero")

				arg_137_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_137_1.callingController_:SetSelectedState("normal")

				arg_137_1.keyicon_.color = Color.New(1, 1, 1)
				arg_137_1.icon_.color = Color.New(1, 1, 1)

				local var_140_86 = arg_137_1:GetWordFromCfg(417141036)
				local var_140_87 = arg_137_1:FormatText(var_140_86.content)

				arg_137_1.text_.text = var_140_87

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_88 = 33
				local var_140_89 = utf8.len(var_140_87)
				local var_140_90 = var_140_88 <= 0 and var_140_83 or var_140_83 * (var_140_89 / var_140_88)

				if var_140_90 > 0 and var_140_83 < var_140_90 then
					arg_137_1.talkMaxDuration = var_140_90
					var_140_82 = var_140_82 + 0.3

					if var_140_90 + var_140_82 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_90 + var_140_82
					end
				end

				arg_137_1.text_.text = var_140_87
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417141", "417141036", "story_v_out_417141.awb") ~= 0 then
					local var_140_91 = manager.audio:GetVoiceLength("story_v_out_417141", "417141036", "story_v_out_417141.awb") / 1000

					if var_140_91 + var_140_82 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_91 + var_140_82
					end

					if var_140_86.prefab_name ~= "" and arg_137_1.actors_[var_140_86.prefab_name] ~= nil then
						local var_140_92 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_86.prefab_name].transform, "story_v_out_417141", "417141036", "story_v_out_417141.awb")

						arg_137_1:RecordAudio("417141036", var_140_92)
						arg_137_1:RecordAudio("417141036", var_140_92)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_417141", "417141036", "story_v_out_417141.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_417141", "417141036", "story_v_out_417141.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_93 = var_140_82 + 0.3
			local var_140_94 = math.max(var_140_83, arg_137_1.talkMaxDuration)

			if var_140_93 <= arg_137_1.time_ and arg_137_1.time_ < var_140_93 + var_140_94 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_93) / var_140_94

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_93 + var_140_94 and arg_137_1.time_ < var_140_93 + var_140_94 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_137_1:InitPlayNodeList()
	end,
	Play417141037 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 417141037
		arg_146_1.duration_ = 2.13

		local var_146_0 = {
			zh = 1.43333333333333,
			ja = 2.13333333333333
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
				arg_146_0:Play417141038(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = manager.ui.mainCamera.transform
			local var_149_1 = 0.0333333333333333

			if var_149_1 < arg_146_1.time_ and arg_146_1.time_ <= var_149_1 + arg_149_0 then
				arg_146_1.var_.shakeOldPos = var_149_0.localPosition
			end

			local var_149_2 = 0.133333333333333

			if var_149_1 <= arg_146_1.time_ and arg_146_1.time_ < var_149_1 + var_149_2 then
				local var_149_3 = (arg_146_1.time_ - var_149_1) / 0.099
				local var_149_4, var_149_5 = math.modf(var_149_3)

				var_149_0.localPosition = Vector3.New(var_149_5 * 0.13, var_149_5 * 0.13, var_149_5 * 0.13) + arg_146_1.var_.shakeOldPos
			end

			if arg_146_1.time_ >= var_149_1 + var_149_2 and arg_146_1.time_ < var_149_1 + var_149_2 + arg_149_0 then
				var_149_0.localPosition = arg_146_1.var_.shakeOldPos
			end

			local var_149_6 = manager.ui.mainCamera.transform
			local var_149_7 = 0

			if var_149_7 < arg_146_1.time_ and arg_146_1.time_ <= var_149_7 + arg_149_0 then
				local var_149_8 = arg_146_1.var_.effect41037
				local var_149_9
				local var_149_10 = var_149_6

				if not var_149_8 then
					var_149_8 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_heibaishan"), var_149_10)
					var_149_8.name = "41037"
					arg_146_1.var_.effect41037 = var_149_8
				else
					var_149_8.transform:SetParent(var_149_10)
				end

				var_149_8.transform.localPosition = Vector3.New(0, 0, -1.09)
				var_149_8.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_149_11 = 0

			if var_149_11 < arg_146_1.time_ and arg_146_1.time_ <= var_149_11 + arg_149_0 then
				arg_146_1.allBtn_.enabled = false
			end

			local var_149_12 = 0.642333333333333

			if arg_146_1.time_ >= var_149_11 + var_149_12 and arg_146_1.time_ < var_149_11 + var_149_12 + arg_149_0 then
				arg_146_1.allBtn_.enabled = true
			end

			local var_149_13 = 0
			local var_149_14 = 1

			if var_149_13 < arg_146_1.time_ and arg_146_1.time_ <= var_149_13 + arg_149_0 then
				local var_149_15 = "play"
				local var_149_16 = "effect"

				arg_146_1:AudioAction(var_149_15, var_149_16, "se_story_1311", "se_story_1311_throw02", "")
			end

			if arg_146_1.frameCnt_ <= 1 then
				arg_146_1.dialog_:SetActive(false)
			end

			local var_149_17 = 0.567333333333333
			local var_149_18 = 0.075

			if var_149_17 < arg_146_1.time_ and arg_146_1.time_ <= var_149_17 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0

				arg_146_1.dialog_:SetActive(true)

				arg_146_1.dialogCg_.alpha = 0

				local var_149_19 = LeanTween.value(arg_146_1.dialog_, 0, 1, 0.3)

				var_149_19:setOnUpdate(LuaHelper.FloatAction(function(arg_150_0)
					arg_146_1.dialogCg_.alpha = arg_150_0
				end))
				var_149_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_146_1.dialog_)
					var_149_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_146_1.duration_ = arg_146_1.duration_ + 0.3

				SetActive(arg_146_1.leftNameGo_, true)

				local var_149_20 = arg_146_1:FormatText(StoryNameCfg[595].name)

				arg_146_1.leftNameTxt_.text = var_149_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, true)
				arg_146_1.iconController_:SetSelectedState("hero")

				arg_146_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10128_split_3")

				arg_146_1.callingController_:SetSelectedState("normal")

				arg_146_1.keyicon_.color = Color.New(1, 1, 1)
				arg_146_1.icon_.color = Color.New(1, 1, 1)

				local var_149_21 = arg_146_1:GetWordFromCfg(417141037)
				local var_149_22 = arg_146_1:FormatText(var_149_21.content)

				arg_146_1.text_.text = var_149_22

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_23 = 3
				local var_149_24 = utf8.len(var_149_22)
				local var_149_25 = var_149_23 <= 0 and var_149_18 or var_149_18 * (var_149_24 / var_149_23)

				if var_149_25 > 0 and var_149_18 < var_149_25 then
					arg_146_1.talkMaxDuration = var_149_25
					var_149_17 = var_149_17 + 0.3

					if var_149_25 + var_149_17 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_25 + var_149_17
					end
				end

				arg_146_1.text_.text = var_149_22
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417141", "417141037", "story_v_out_417141.awb") ~= 0 then
					local var_149_26 = manager.audio:GetVoiceLength("story_v_out_417141", "417141037", "story_v_out_417141.awb") / 1000

					if var_149_26 + var_149_17 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_26 + var_149_17
					end

					if var_149_21.prefab_name ~= "" and arg_146_1.actors_[var_149_21.prefab_name] ~= nil then
						local var_149_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_21.prefab_name].transform, "story_v_out_417141", "417141037", "story_v_out_417141.awb")

						arg_146_1:RecordAudio("417141037", var_149_27)
						arg_146_1:RecordAudio("417141037", var_149_27)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_417141", "417141037", "story_v_out_417141.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_417141", "417141037", "story_v_out_417141.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_28 = var_149_17 + 0.3
			local var_149_29 = math.max(var_149_18, arg_146_1.talkMaxDuration)

			if var_149_28 <= arg_146_1.time_ and arg_146_1.time_ < var_149_28 + var_149_29 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_28) / var_149_29

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_28 + var_149_29 and arg_146_1.time_ < var_149_28 + var_149_29 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play417141038 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 417141038
		arg_152_1.duration_ = 5

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play417141039(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = 0.1
			local var_155_1 = 1

			if var_155_0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_0 + arg_155_0 then
				local var_155_2 = "play"
				local var_155_3 = "effect"

				arg_152_1:AudioAction(var_155_2, var_155_3, "se_story_1311", "se_story_1311_stone", "")
			end

			local var_155_4 = 0
			local var_155_5 = 1.45

			if var_155_4 < arg_152_1.time_ and arg_152_1.time_ <= var_155_4 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, false)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_6 = arg_152_1:GetWordFromCfg(417141038)
				local var_155_7 = arg_152_1:FormatText(var_155_6.content)

				arg_152_1.text_.text = var_155_7

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_8 = 58
				local var_155_9 = utf8.len(var_155_7)
				local var_155_10 = var_155_8 <= 0 and var_155_5 or var_155_5 * (var_155_9 / var_155_8)

				if var_155_10 > 0 and var_155_5 < var_155_10 then
					arg_152_1.talkMaxDuration = var_155_10

					if var_155_10 + var_155_4 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_10 + var_155_4
					end
				end

				arg_152_1.text_.text = var_155_7
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)
				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_11 = math.max(var_155_5, arg_152_1.talkMaxDuration)

			if var_155_4 <= arg_152_1.time_ and arg_152_1.time_ < var_155_4 + var_155_11 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_4) / var_155_11

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_4 + var_155_11 and arg_152_1.time_ < var_155_4 + var_155_11 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play417141039 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 417141039
		arg_156_1.duration_ = 7

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play417141040(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = 2

			if var_159_0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_0 + arg_159_0 then
				arg_156_1.allBtn_.enabled = false
			end

			local var_159_1 = 0.666666666666667

			if arg_156_1.time_ >= var_159_0 + var_159_1 and arg_156_1.time_ < var_159_0 + var_159_1 + arg_159_0 then
				arg_156_1.allBtn_.enabled = true
			end

			local var_159_2 = "D10"

			if arg_156_1.bgs_[var_159_2] == nil then
				local var_159_3 = Object.Instantiate(arg_156_1.paintGo_)

				var_159_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_159_2)
				var_159_3.name = var_159_2
				var_159_3.transform.parent = arg_156_1.stage_.transform
				var_159_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_156_1.bgs_[var_159_2] = var_159_3
			end

			local var_159_4 = 1

			if var_159_4 < arg_156_1.time_ and arg_156_1.time_ <= var_159_4 + arg_159_0 then
				local var_159_5 = manager.ui.mainCamera.transform.localPosition
				local var_159_6 = Vector3.New(0, 0, 10) + Vector3.New(var_159_5.x, var_159_5.y, 0)
				local var_159_7 = arg_156_1.bgs_.D10

				var_159_7.transform.localPosition = var_159_6
				var_159_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_159_8 = var_159_7:GetComponent("SpriteRenderer")

				if var_159_8 and var_159_8.sprite then
					local var_159_9 = (var_159_7.transform.localPosition - var_159_5).z
					local var_159_10 = manager.ui.mainCameraCom_
					local var_159_11 = 2 * var_159_9 * Mathf.Tan(var_159_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_159_12 = var_159_11 * var_159_10.aspect
					local var_159_13 = var_159_8.sprite.bounds.size.x
					local var_159_14 = var_159_8.sprite.bounds.size.y
					local var_159_15 = var_159_12 / var_159_13
					local var_159_16 = var_159_11 / var_159_14
					local var_159_17 = var_159_16 < var_159_15 and var_159_15 or var_159_16

					var_159_7.transform.localScale = Vector3.New(var_159_17, var_159_17, 0)
				end

				for iter_159_0, iter_159_1 in pairs(arg_156_1.bgs_) do
					if iter_159_0 ~= "D10" then
						iter_159_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_159_18 = 0

			if var_159_18 < arg_156_1.time_ and arg_156_1.time_ <= var_159_18 + arg_159_0 then
				arg_156_1.mask_.enabled = true
				arg_156_1.mask_.raycastTarget = true

				arg_156_1:SetGaussion(false)
			end

			local var_159_19 = 1

			if var_159_18 <= arg_156_1.time_ and arg_156_1.time_ < var_159_18 + var_159_19 then
				local var_159_20 = (arg_156_1.time_ - var_159_18) / var_159_19
				local var_159_21 = Color.New(0, 0, 0)

				var_159_21.a = Mathf.Lerp(0, 1, var_159_20)
				arg_156_1.mask_.color = var_159_21
			end

			if arg_156_1.time_ >= var_159_18 + var_159_19 and arg_156_1.time_ < var_159_18 + var_159_19 + arg_159_0 then
				local var_159_22 = Color.New(0, 0, 0)

				var_159_22.a = 1
				arg_156_1.mask_.color = var_159_22
			end

			local var_159_23 = 1

			if var_159_23 < arg_156_1.time_ and arg_156_1.time_ <= var_159_23 + arg_159_0 then
				arg_156_1.mask_.enabled = true
				arg_156_1.mask_.raycastTarget = true

				arg_156_1:SetGaussion(false)
			end

			local var_159_24 = 1

			if var_159_23 <= arg_156_1.time_ and arg_156_1.time_ < var_159_23 + var_159_24 then
				local var_159_25 = (arg_156_1.time_ - var_159_23) / var_159_24
				local var_159_26 = Color.New(0, 0, 0)

				var_159_26.a = Mathf.Lerp(1, 0, var_159_25)
				arg_156_1.mask_.color = var_159_26
			end

			if arg_156_1.time_ >= var_159_23 + var_159_24 and arg_156_1.time_ < var_159_23 + var_159_24 + arg_159_0 then
				local var_159_27 = Color.New(0, 0, 0)
				local var_159_28 = 0

				arg_156_1.mask_.enabled = false
				var_159_27.a = var_159_28
				arg_156_1.mask_.color = var_159_27
			end

			if arg_156_1.frameCnt_ <= 1 then
				arg_156_1.dialog_:SetActive(false)
			end

			local var_159_29 = 2
			local var_159_30 = 1.375

			if var_159_29 < arg_156_1.time_ and arg_156_1.time_ <= var_159_29 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0

				arg_156_1.dialog_:SetActive(true)

				arg_156_1.dialogCg_.alpha = 0

				local var_159_31 = LeanTween.value(arg_156_1.dialog_, 0, 1, 0.3)

				var_159_31:setOnUpdate(LuaHelper.FloatAction(function(arg_160_0)
					arg_156_1.dialogCg_.alpha = arg_160_0
				end))
				var_159_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_156_1.dialog_)
					var_159_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_156_1.duration_ = arg_156_1.duration_ + 0.3

				SetActive(arg_156_1.leftNameGo_, false)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_32 = arg_156_1:GetWordFromCfg(417141039)
				local var_159_33 = arg_156_1:FormatText(var_159_32.content)

				arg_156_1.text_.text = var_159_33

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_34 = 55
				local var_159_35 = utf8.len(var_159_33)
				local var_159_36 = var_159_34 <= 0 and var_159_30 or var_159_30 * (var_159_35 / var_159_34)

				if var_159_36 > 0 and var_159_30 < var_159_36 then
					arg_156_1.talkMaxDuration = var_159_36
					var_159_29 = var_159_29 + 0.3

					if var_159_36 + var_159_29 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_36 + var_159_29
					end
				end

				arg_156_1.text_.text = var_159_33
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)
				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_37 = var_159_29 + 0.3
			local var_159_38 = math.max(var_159_30, arg_156_1.talkMaxDuration)

			if var_159_37 <= arg_156_1.time_ and arg_156_1.time_ < var_159_37 + var_159_38 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_37) / var_159_38

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_37 + var_159_38 and arg_156_1.time_ < var_159_37 + var_159_38 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play417141040 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 417141040
		arg_162_1.duration_ = 5

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play417141041(arg_162_1)
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

				local var_165_2 = arg_162_1:GetWordFromCfg(417141040)
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
	Play417141041 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 417141041
		arg_166_1.duration_ = 5

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play417141042(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = 0.2
			local var_169_1 = 1

			if var_169_0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_0 + arg_169_0 then
				local var_169_2 = "play"
				local var_169_3 = "effect"

				arg_166_1:AudioAction(var_169_2, var_169_3, "se_story_1310", "se_story_1310_surround02", "")
			end

			local var_169_4 = 0
			local var_169_5 = 1.6

			if var_169_4 < arg_166_1.time_ and arg_166_1.time_ <= var_169_4 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, false)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_6 = arg_166_1:GetWordFromCfg(417141041)
				local var_169_7 = arg_166_1:FormatText(var_169_6.content)

				arg_166_1.text_.text = var_169_7

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_8 = 64
				local var_169_9 = utf8.len(var_169_7)
				local var_169_10 = var_169_8 <= 0 and var_169_5 or var_169_5 * (var_169_9 / var_169_8)

				if var_169_10 > 0 and var_169_5 < var_169_10 then
					arg_166_1.talkMaxDuration = var_169_10

					if var_169_10 + var_169_4 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_10 + var_169_4
					end
				end

				arg_166_1.text_.text = var_169_7
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)
				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_11 = math.max(var_169_5, arg_166_1.talkMaxDuration)

			if var_169_4 <= arg_166_1.time_ and arg_166_1.time_ < var_169_4 + var_169_11 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_4) / var_169_11

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_4 + var_169_11 and arg_166_1.time_ < var_169_4 + var_169_11 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play417141042 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 417141042
		arg_170_1.duration_ = 2.47

		local var_170_0 = {
			zh = 1.234,
			ja = 2.467
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
				arg_170_0:Play417141043(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = "1034"

			if arg_170_1.actors_[var_173_0] == nil then
				local var_173_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1034")

				if not isNil(var_173_1) then
					local var_173_2 = Object.Instantiate(var_173_1, arg_170_1.canvasGo_.transform)

					var_173_2.transform:SetSiblingIndex(1)

					var_173_2.name = var_173_0
					var_173_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_170_1.actors_[var_173_0] = var_173_2

					local var_173_3 = var_173_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_170_1.isInRecall_ then
						for iter_173_0, iter_173_1 in ipairs(var_173_3) do
							iter_173_1.color = arg_170_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_173_4 = arg_170_1.actors_["1034"]
			local var_173_5 = 0

			if var_173_5 < arg_170_1.time_ and arg_170_1.time_ <= var_173_5 + arg_173_0 and not isNil(var_173_4) and arg_170_1.var_.actorSpriteComps1034 == nil then
				arg_170_1.var_.actorSpriteComps1034 = var_173_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_173_6 = 0.133333333333333

			if var_173_5 <= arg_170_1.time_ and arg_170_1.time_ < var_173_5 + var_173_6 and not isNil(var_173_4) then
				local var_173_7 = (arg_170_1.time_ - var_173_5) / var_173_6

				if arg_170_1.var_.actorSpriteComps1034 then
					for iter_173_2, iter_173_3 in pairs(arg_170_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_173_3 then
							if arg_170_1.isInRecall_ then
								local var_173_8 = Mathf.Lerp(iter_173_3.color.r, arg_170_1.hightColor1.r, var_173_7)
								local var_173_9 = Mathf.Lerp(iter_173_3.color.g, arg_170_1.hightColor1.g, var_173_7)
								local var_173_10 = Mathf.Lerp(iter_173_3.color.b, arg_170_1.hightColor1.b, var_173_7)

								iter_173_3.color = Color.New(var_173_8, var_173_9, var_173_10)
							else
								local var_173_11 = Mathf.Lerp(iter_173_3.color.r, 1, var_173_7)

								iter_173_3.color = Color.New(var_173_11, var_173_11, var_173_11)
							end
						end
					end
				end
			end

			if arg_170_1.time_ >= var_173_5 + var_173_6 and arg_170_1.time_ < var_173_5 + var_173_6 + arg_173_0 and not isNil(var_173_4) and arg_170_1.var_.actorSpriteComps1034 then
				for iter_173_4, iter_173_5 in pairs(arg_170_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_173_5 then
						if arg_170_1.isInRecall_ then
							iter_173_5.color = arg_170_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_173_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_170_1.var_.actorSpriteComps1034 = nil
			end

			local var_173_12 = arg_170_1.actors_["1034"].transform
			local var_173_13 = 0

			if var_173_13 < arg_170_1.time_ and arg_170_1.time_ <= var_173_13 + arg_173_0 then
				arg_170_1.var_.moveOldPos1034 = var_173_12.localPosition
				var_173_12.localScale = Vector3.New(1, 1, 1)

				arg_170_1:CheckSpriteTmpPos("1034", 3)

				local var_173_14 = var_173_12.childCount

				for iter_173_6 = 0, var_173_14 - 1 do
					local var_173_15 = var_173_12:GetChild(iter_173_6)

					if var_173_15.name == "split_5" or not string.find(var_173_15.name, "split") then
						var_173_15.gameObject:SetActive(true)
					else
						var_173_15.gameObject:SetActive(false)
					end
				end
			end

			local var_173_16 = 0.001

			if var_173_13 <= arg_170_1.time_ and arg_170_1.time_ < var_173_13 + var_173_16 then
				local var_173_17 = (arg_170_1.time_ - var_173_13) / var_173_16
				local var_173_18 = Vector3.New(0, -331.9, -324)

				var_173_12.localPosition = Vector3.Lerp(arg_170_1.var_.moveOldPos1034, var_173_18, var_173_17)
			end

			if arg_170_1.time_ >= var_173_13 + var_173_16 and arg_170_1.time_ < var_173_13 + var_173_16 + arg_173_0 then
				var_173_12.localPosition = Vector3.New(0, -331.9, -324)
			end

			if arg_170_1.frameCnt_ <= 1 then
				arg_170_1.dialog_:SetActive(false)
			end

			local var_173_19 = 0.034
			local var_173_20 = 0.2

			if var_173_19 < arg_170_1.time_ and arg_170_1.time_ <= var_173_19 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0

				arg_170_1.dialog_:SetActive(true)

				arg_170_1.dialogCg_.alpha = 0

				local var_173_21 = LeanTween.value(arg_170_1.dialog_, 0, 1, 0.3)

				var_173_21:setOnUpdate(LuaHelper.FloatAction(function(arg_174_0)
					arg_170_1.dialogCg_.alpha = arg_174_0
				end))
				var_173_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_170_1.dialog_)
					var_173_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_170_1.duration_ = arg_170_1.duration_ + 0.3

				SetActive(arg_170_1.leftNameGo_, true)

				local var_173_22 = arg_170_1:FormatText(StoryNameCfg[1109].name)

				arg_170_1.leftNameTxt_.text = var_173_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_23 = arg_170_1:GetWordFromCfg(417141042)
				local var_173_24 = arg_170_1:FormatText(var_173_23.content)

				arg_170_1.text_.text = var_173_24

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_25 = 3
				local var_173_26 = utf8.len(var_173_24)
				local var_173_27 = var_173_25 <= 0 and var_173_20 or var_173_20 * (var_173_26 / var_173_25)

				if var_173_27 > 0 and var_173_20 < var_173_27 then
					arg_170_1.talkMaxDuration = var_173_27
					var_173_19 = var_173_19 + 0.3

					if var_173_27 + var_173_19 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_27 + var_173_19
					end
				end

				arg_170_1.text_.text = var_173_24
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417141", "417141042", "story_v_out_417141.awb") ~= 0 then
					local var_173_28 = manager.audio:GetVoiceLength("story_v_out_417141", "417141042", "story_v_out_417141.awb") / 1000

					if var_173_28 + var_173_19 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_28 + var_173_19
					end

					if var_173_23.prefab_name ~= "" and arg_170_1.actors_[var_173_23.prefab_name] ~= nil then
						local var_173_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_23.prefab_name].transform, "story_v_out_417141", "417141042", "story_v_out_417141.awb")

						arg_170_1:RecordAudio("417141042", var_173_29)
						arg_170_1:RecordAudio("417141042", var_173_29)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_417141", "417141042", "story_v_out_417141.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_417141", "417141042", "story_v_out_417141.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_30 = var_173_19 + 0.3
			local var_173_31 = math.max(var_173_20, arg_170_1.talkMaxDuration)

			if var_173_30 <= arg_170_1.time_ and arg_170_1.time_ < var_173_30 + var_173_31 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_30) / var_173_31

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_30 + var_173_31 and arg_170_1.time_ < var_173_30 + var_173_31 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_170_1:InitPlayNodeList()
	end,
	Play417141043 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 417141043
		arg_176_1.duration_ = 6.53

		local var_176_0 = {
			zh = 6.533,
			ja = 6.4
		}
		local var_176_1 = manager.audio:GetLocalizationFlag()

		if var_176_0[var_176_1] ~= nil then
			arg_176_1.duration_ = var_176_0[var_176_1]
		end

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play417141044(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = arg_176_1.actors_["1034"]
			local var_179_1 = 0

			if var_179_1 < arg_176_1.time_ and arg_176_1.time_ <= var_179_1 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.actorSpriteComps1034 == nil then
				arg_176_1.var_.actorSpriteComps1034 = var_179_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_179_2 = 0.2

			if var_179_1 <= arg_176_1.time_ and arg_176_1.time_ < var_179_1 + var_179_2 and not isNil(var_179_0) then
				local var_179_3 = (arg_176_1.time_ - var_179_1) / var_179_2

				if arg_176_1.var_.actorSpriteComps1034 then
					for iter_179_0, iter_179_1 in pairs(arg_176_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_179_1 then
							if arg_176_1.isInRecall_ then
								local var_179_4 = Mathf.Lerp(iter_179_1.color.r, arg_176_1.hightColor2.r, var_179_3)
								local var_179_5 = Mathf.Lerp(iter_179_1.color.g, arg_176_1.hightColor2.g, var_179_3)
								local var_179_6 = Mathf.Lerp(iter_179_1.color.b, arg_176_1.hightColor2.b, var_179_3)

								iter_179_1.color = Color.New(var_179_4, var_179_5, var_179_6)
							else
								local var_179_7 = Mathf.Lerp(iter_179_1.color.r, 0.5, var_179_3)

								iter_179_1.color = Color.New(var_179_7, var_179_7, var_179_7)
							end
						end
					end
				end
			end

			if arg_176_1.time_ >= var_179_1 + var_179_2 and arg_176_1.time_ < var_179_1 + var_179_2 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.actorSpriteComps1034 then
				for iter_179_2, iter_179_3 in pairs(arg_176_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_179_3 then
						if arg_176_1.isInRecall_ then
							iter_179_3.color = arg_176_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_179_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_176_1.var_.actorSpriteComps1034 = nil
			end

			local var_179_8 = arg_176_1.actors_["10128"].transform
			local var_179_9 = 0

			if var_179_9 < arg_176_1.time_ and arg_176_1.time_ <= var_179_9 + arg_179_0 then
				arg_176_1.var_.moveOldPos10128 = var_179_8.localPosition
				var_179_8.localScale = Vector3.New(1, 1, 1)

				arg_176_1:CheckSpriteTmpPos("10128", 3)

				local var_179_10 = var_179_8.childCount

				for iter_179_4 = 0, var_179_10 - 1 do
					local var_179_11 = var_179_8:GetChild(iter_179_4)

					if var_179_11.name == "split_6" or not string.find(var_179_11.name, "split") then
						var_179_11.gameObject:SetActive(true)
					else
						var_179_11.gameObject:SetActive(false)
					end
				end
			end

			local var_179_12 = 0.001

			if var_179_9 <= arg_176_1.time_ and arg_176_1.time_ < var_179_9 + var_179_12 then
				local var_179_13 = (arg_176_1.time_ - var_179_9) / var_179_12
				local var_179_14 = Vector3.New(0, -347, -300)

				var_179_8.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos10128, var_179_14, var_179_13)
			end

			if arg_176_1.time_ >= var_179_9 + var_179_12 and arg_176_1.time_ < var_179_9 + var_179_12 + arg_179_0 then
				var_179_8.localPosition = Vector3.New(0, -347, -300)
			end

			local var_179_15 = arg_176_1.actors_["10128"]
			local var_179_16 = 0

			if var_179_16 < arg_176_1.time_ and arg_176_1.time_ <= var_179_16 + arg_179_0 and not isNil(var_179_15) and arg_176_1.var_.actorSpriteComps10128 == nil then
				arg_176_1.var_.actorSpriteComps10128 = var_179_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_179_17 = 0.2

			if var_179_16 <= arg_176_1.time_ and arg_176_1.time_ < var_179_16 + var_179_17 and not isNil(var_179_15) then
				local var_179_18 = (arg_176_1.time_ - var_179_16) / var_179_17

				if arg_176_1.var_.actorSpriteComps10128 then
					for iter_179_5, iter_179_6 in pairs(arg_176_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_179_6 then
							if arg_176_1.isInRecall_ then
								local var_179_19 = Mathf.Lerp(iter_179_6.color.r, arg_176_1.hightColor1.r, var_179_18)
								local var_179_20 = Mathf.Lerp(iter_179_6.color.g, arg_176_1.hightColor1.g, var_179_18)
								local var_179_21 = Mathf.Lerp(iter_179_6.color.b, arg_176_1.hightColor1.b, var_179_18)

								iter_179_6.color = Color.New(var_179_19, var_179_20, var_179_21)
							else
								local var_179_22 = Mathf.Lerp(iter_179_6.color.r, 1, var_179_18)

								iter_179_6.color = Color.New(var_179_22, var_179_22, var_179_22)
							end
						end
					end
				end
			end

			if arg_176_1.time_ >= var_179_16 + var_179_17 and arg_176_1.time_ < var_179_16 + var_179_17 + arg_179_0 and not isNil(var_179_15) and arg_176_1.var_.actorSpriteComps10128 then
				for iter_179_7, iter_179_8 in pairs(arg_176_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_179_8 then
						if arg_176_1.isInRecall_ then
							iter_179_8.color = arg_176_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_179_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_176_1.var_.actorSpriteComps10128 = nil
			end

			local var_179_23 = 0
			local var_179_24 = 1.05

			if var_179_23 < arg_176_1.time_ and arg_176_1.time_ <= var_179_23 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				local var_179_25 = arg_176_1:FormatText(StoryNameCfg[595].name)

				arg_176_1.leftNameTxt_.text = var_179_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_26 = arg_176_1:GetWordFromCfg(417141043)
				local var_179_27 = arg_176_1:FormatText(var_179_26.content)

				arg_176_1.text_.text = var_179_27

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_28 = 42
				local var_179_29 = utf8.len(var_179_27)
				local var_179_30 = var_179_28 <= 0 and var_179_24 or var_179_24 * (var_179_29 / var_179_28)

				if var_179_30 > 0 and var_179_24 < var_179_30 then
					arg_176_1.talkMaxDuration = var_179_30

					if var_179_30 + var_179_23 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_30 + var_179_23
					end
				end

				arg_176_1.text_.text = var_179_27
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417141", "417141043", "story_v_out_417141.awb") ~= 0 then
					local var_179_31 = manager.audio:GetVoiceLength("story_v_out_417141", "417141043", "story_v_out_417141.awb") / 1000

					if var_179_31 + var_179_23 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_31 + var_179_23
					end

					if var_179_26.prefab_name ~= "" and arg_176_1.actors_[var_179_26.prefab_name] ~= nil then
						local var_179_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_26.prefab_name].transform, "story_v_out_417141", "417141043", "story_v_out_417141.awb")

						arg_176_1:RecordAudio("417141043", var_179_32)
						arg_176_1:RecordAudio("417141043", var_179_32)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_417141", "417141043", "story_v_out_417141.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_417141", "417141043", "story_v_out_417141.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_33 = math.max(var_179_24, arg_176_1.talkMaxDuration)

			if var_179_23 <= arg_176_1.time_ and arg_176_1.time_ < var_179_23 + var_179_33 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_23) / var_179_33

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_23 + var_179_33 and arg_176_1.time_ < var_179_23 + var_179_33 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_176_1:InitPlayNodeList()
	end,
	Play417141044 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 417141044
		arg_180_1.duration_ = 10.7

		local var_180_0 = {
			zh = 4.1,
			ja = 10.7
		}
		local var_180_1 = manager.audio:GetLocalizationFlag()

		if var_180_0[var_180_1] ~= nil then
			arg_180_1.duration_ = var_180_0[var_180_1]
		end

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play417141045(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = arg_180_1.actors_["1034"]
			local var_183_1 = 0

			if var_183_1 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.actorSpriteComps1034 == nil then
				arg_180_1.var_.actorSpriteComps1034 = var_183_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_183_2 = 0.2

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_2 and not isNil(var_183_0) then
				local var_183_3 = (arg_180_1.time_ - var_183_1) / var_183_2

				if arg_180_1.var_.actorSpriteComps1034 then
					for iter_183_0, iter_183_1 in pairs(arg_180_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_183_1 then
							if arg_180_1.isInRecall_ then
								local var_183_4 = Mathf.Lerp(iter_183_1.color.r, arg_180_1.hightColor1.r, var_183_3)
								local var_183_5 = Mathf.Lerp(iter_183_1.color.g, arg_180_1.hightColor1.g, var_183_3)
								local var_183_6 = Mathf.Lerp(iter_183_1.color.b, arg_180_1.hightColor1.b, var_183_3)

								iter_183_1.color = Color.New(var_183_4, var_183_5, var_183_6)
							else
								local var_183_7 = Mathf.Lerp(iter_183_1.color.r, 1, var_183_3)

								iter_183_1.color = Color.New(var_183_7, var_183_7, var_183_7)
							end
						end
					end
				end
			end

			if arg_180_1.time_ >= var_183_1 + var_183_2 and arg_180_1.time_ < var_183_1 + var_183_2 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.actorSpriteComps1034 then
				for iter_183_2, iter_183_3 in pairs(arg_180_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_183_3 then
						if arg_180_1.isInRecall_ then
							iter_183_3.color = arg_180_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_183_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_180_1.var_.actorSpriteComps1034 = nil
			end

			local var_183_8 = arg_180_1.actors_["10128"]
			local var_183_9 = 0

			if var_183_9 < arg_180_1.time_ and arg_180_1.time_ <= var_183_9 + arg_183_0 and not isNil(var_183_8) and arg_180_1.var_.actorSpriteComps10128 == nil then
				arg_180_1.var_.actorSpriteComps10128 = var_183_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_183_10 = 0.2

			if var_183_9 <= arg_180_1.time_ and arg_180_1.time_ < var_183_9 + var_183_10 and not isNil(var_183_8) then
				local var_183_11 = (arg_180_1.time_ - var_183_9) / var_183_10

				if arg_180_1.var_.actorSpriteComps10128 then
					for iter_183_4, iter_183_5 in pairs(arg_180_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_183_5 then
							if arg_180_1.isInRecall_ then
								local var_183_12 = Mathf.Lerp(iter_183_5.color.r, arg_180_1.hightColor2.r, var_183_11)
								local var_183_13 = Mathf.Lerp(iter_183_5.color.g, arg_180_1.hightColor2.g, var_183_11)
								local var_183_14 = Mathf.Lerp(iter_183_5.color.b, arg_180_1.hightColor2.b, var_183_11)

								iter_183_5.color = Color.New(var_183_12, var_183_13, var_183_14)
							else
								local var_183_15 = Mathf.Lerp(iter_183_5.color.r, 0.5, var_183_11)

								iter_183_5.color = Color.New(var_183_15, var_183_15, var_183_15)
							end
						end
					end
				end
			end

			if arg_180_1.time_ >= var_183_9 + var_183_10 and arg_180_1.time_ < var_183_9 + var_183_10 + arg_183_0 and not isNil(var_183_8) and arg_180_1.var_.actorSpriteComps10128 then
				for iter_183_6, iter_183_7 in pairs(arg_180_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_183_7 then
						if arg_180_1.isInRecall_ then
							iter_183_7.color = arg_180_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_183_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_180_1.var_.actorSpriteComps10128 = nil
			end

			local var_183_16 = arg_180_1.actors_["1034"].transform
			local var_183_17 = 0

			if var_183_17 < arg_180_1.time_ and arg_180_1.time_ <= var_183_17 + arg_183_0 then
				arg_180_1.var_.moveOldPos1034 = var_183_16.localPosition
				var_183_16.localScale = Vector3.New(1, 1, 1)

				arg_180_1:CheckSpriteTmpPos("1034", 4)

				local var_183_18 = var_183_16.childCount

				for iter_183_8 = 0, var_183_18 - 1 do
					local var_183_19 = var_183_16:GetChild(iter_183_8)

					if var_183_19.name == "split_6" or not string.find(var_183_19.name, "split") then
						var_183_19.gameObject:SetActive(true)
					else
						var_183_19.gameObject:SetActive(false)
					end
				end
			end

			local var_183_20 = 0.001

			if var_183_17 <= arg_180_1.time_ and arg_180_1.time_ < var_183_17 + var_183_20 then
				local var_183_21 = (arg_180_1.time_ - var_183_17) / var_183_20
				local var_183_22 = Vector3.New(373.7, -331.9, -324)

				var_183_16.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos1034, var_183_22, var_183_21)
			end

			if arg_180_1.time_ >= var_183_17 + var_183_20 and arg_180_1.time_ < var_183_17 + var_183_20 + arg_183_0 then
				var_183_16.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_183_23 = arg_180_1.actors_["10128"].transform
			local var_183_24 = 0

			if var_183_24 < arg_180_1.time_ and arg_180_1.time_ <= var_183_24 + arg_183_0 then
				arg_180_1.var_.moveOldPos10128 = var_183_23.localPosition
				var_183_23.localScale = Vector3.New(1, 1, 1)

				arg_180_1:CheckSpriteTmpPos("10128", 2)

				local var_183_25 = var_183_23.childCount

				for iter_183_9 = 0, var_183_25 - 1 do
					local var_183_26 = var_183_23:GetChild(iter_183_9)

					if var_183_26.name == "split_6" or not string.find(var_183_26.name, "split") then
						var_183_26.gameObject:SetActive(true)
					else
						var_183_26.gameObject:SetActive(false)
					end
				end
			end

			local var_183_27 = 0.001

			if var_183_24 <= arg_180_1.time_ and arg_180_1.time_ < var_183_24 + var_183_27 then
				local var_183_28 = (arg_180_1.time_ - var_183_24) / var_183_27
				local var_183_29 = Vector3.New(-390, -347, -300)

				var_183_23.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos10128, var_183_29, var_183_28)
			end

			if arg_180_1.time_ >= var_183_24 + var_183_27 and arg_180_1.time_ < var_183_24 + var_183_27 + arg_183_0 then
				var_183_23.localPosition = Vector3.New(-390, -347, -300)
			end

			local var_183_30 = 0
			local var_183_31 = 0.6

			if var_183_30 < arg_180_1.time_ and arg_180_1.time_ <= var_183_30 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				local var_183_32 = arg_180_1:FormatText(StoryNameCfg[1109].name)

				arg_180_1.leftNameTxt_.text = var_183_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_33 = arg_180_1:GetWordFromCfg(417141044)
				local var_183_34 = arg_180_1:FormatText(var_183_33.content)

				arg_180_1.text_.text = var_183_34

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_35 = 24
				local var_183_36 = utf8.len(var_183_34)
				local var_183_37 = var_183_35 <= 0 and var_183_31 or var_183_31 * (var_183_36 / var_183_35)

				if var_183_37 > 0 and var_183_31 < var_183_37 then
					arg_180_1.talkMaxDuration = var_183_37

					if var_183_37 + var_183_30 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_37 + var_183_30
					end
				end

				arg_180_1.text_.text = var_183_34
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417141", "417141044", "story_v_out_417141.awb") ~= 0 then
					local var_183_38 = manager.audio:GetVoiceLength("story_v_out_417141", "417141044", "story_v_out_417141.awb") / 1000

					if var_183_38 + var_183_30 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_38 + var_183_30
					end

					if var_183_33.prefab_name ~= "" and arg_180_1.actors_[var_183_33.prefab_name] ~= nil then
						local var_183_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_33.prefab_name].transform, "story_v_out_417141", "417141044", "story_v_out_417141.awb")

						arg_180_1:RecordAudio("417141044", var_183_39)
						arg_180_1:RecordAudio("417141044", var_183_39)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_417141", "417141044", "story_v_out_417141.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_417141", "417141044", "story_v_out_417141.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_40 = math.max(var_183_31, arg_180_1.talkMaxDuration)

			if var_183_30 <= arg_180_1.time_ and arg_180_1.time_ < var_183_30 + var_183_40 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_30) / var_183_40

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_30 + var_183_40 and arg_180_1.time_ < var_183_30 + var_183_40 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_180_1:InitPlayNodeList()
	end,
	Play417141045 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 417141045
		arg_184_1.duration_ = 4.67

		local var_184_0 = {
			zh = 3.433,
			ja = 4.666
		}
		local var_184_1 = manager.audio:GetLocalizationFlag()

		if var_184_0[var_184_1] ~= nil then
			arg_184_1.duration_ = var_184_0[var_184_1]
		end

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play417141046(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = 0
			local var_187_1 = 0.375

			if var_187_0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_0 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				local var_187_2 = arg_184_1:FormatText(StoryNameCfg[1109].name)

				arg_184_1.leftNameTxt_.text = var_187_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_3 = arg_184_1:GetWordFromCfg(417141045)
				local var_187_4 = arg_184_1:FormatText(var_187_3.content)

				arg_184_1.text_.text = var_187_4

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_5 = 15
				local var_187_6 = utf8.len(var_187_4)
				local var_187_7 = var_187_5 <= 0 and var_187_1 or var_187_1 * (var_187_6 / var_187_5)

				if var_187_7 > 0 and var_187_1 < var_187_7 then
					arg_184_1.talkMaxDuration = var_187_7

					if var_187_7 + var_187_0 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_7 + var_187_0
					end
				end

				arg_184_1.text_.text = var_187_4
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417141", "417141045", "story_v_out_417141.awb") ~= 0 then
					local var_187_8 = manager.audio:GetVoiceLength("story_v_out_417141", "417141045", "story_v_out_417141.awb") / 1000

					if var_187_8 + var_187_0 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_8 + var_187_0
					end

					if var_187_3.prefab_name ~= "" and arg_184_1.actors_[var_187_3.prefab_name] ~= nil then
						local var_187_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_3.prefab_name].transform, "story_v_out_417141", "417141045", "story_v_out_417141.awb")

						arg_184_1:RecordAudio("417141045", var_187_9)
						arg_184_1:RecordAudio("417141045", var_187_9)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_417141", "417141045", "story_v_out_417141.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_417141", "417141045", "story_v_out_417141.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_10 = math.max(var_187_1, arg_184_1.talkMaxDuration)

			if var_187_0 <= arg_184_1.time_ and arg_184_1.time_ < var_187_0 + var_187_10 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_0) / var_187_10

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_0 + var_187_10 and arg_184_1.time_ < var_187_0 + var_187_10 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play417141046 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 417141046
		arg_188_1.duration_ = 6.73

		local var_188_0 = {
			zh = 4.566,
			ja = 6.733
		}
		local var_188_1 = manager.audio:GetLocalizationFlag()

		if var_188_0[var_188_1] ~= nil then
			arg_188_1.duration_ = var_188_0[var_188_1]
		end

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play417141047(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = arg_188_1.actors_["10128"]
			local var_191_1 = 0

			if var_191_1 < arg_188_1.time_ and arg_188_1.time_ <= var_191_1 + arg_191_0 and not isNil(var_191_0) and arg_188_1.var_.actorSpriteComps10128 == nil then
				arg_188_1.var_.actorSpriteComps10128 = var_191_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_191_2 = 0.2

			if var_191_1 <= arg_188_1.time_ and arg_188_1.time_ < var_191_1 + var_191_2 and not isNil(var_191_0) then
				local var_191_3 = (arg_188_1.time_ - var_191_1) / var_191_2

				if arg_188_1.var_.actorSpriteComps10128 then
					for iter_191_0, iter_191_1 in pairs(arg_188_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_191_1 then
							if arg_188_1.isInRecall_ then
								local var_191_4 = Mathf.Lerp(iter_191_1.color.r, arg_188_1.hightColor1.r, var_191_3)
								local var_191_5 = Mathf.Lerp(iter_191_1.color.g, arg_188_1.hightColor1.g, var_191_3)
								local var_191_6 = Mathf.Lerp(iter_191_1.color.b, arg_188_1.hightColor1.b, var_191_3)

								iter_191_1.color = Color.New(var_191_4, var_191_5, var_191_6)
							else
								local var_191_7 = Mathf.Lerp(iter_191_1.color.r, 1, var_191_3)

								iter_191_1.color = Color.New(var_191_7, var_191_7, var_191_7)
							end
						end
					end
				end
			end

			if arg_188_1.time_ >= var_191_1 + var_191_2 and arg_188_1.time_ < var_191_1 + var_191_2 + arg_191_0 and not isNil(var_191_0) and arg_188_1.var_.actorSpriteComps10128 then
				for iter_191_2, iter_191_3 in pairs(arg_188_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_191_3 then
						if arg_188_1.isInRecall_ then
							iter_191_3.color = arg_188_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_191_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_188_1.var_.actorSpriteComps10128 = nil
			end

			local var_191_8 = arg_188_1.actors_["1034"]
			local var_191_9 = 0

			if var_191_9 < arg_188_1.time_ and arg_188_1.time_ <= var_191_9 + arg_191_0 and not isNil(var_191_8) and arg_188_1.var_.actorSpriteComps1034 == nil then
				arg_188_1.var_.actorSpriteComps1034 = var_191_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_191_10 = 0.2

			if var_191_9 <= arg_188_1.time_ and arg_188_1.time_ < var_191_9 + var_191_10 and not isNil(var_191_8) then
				local var_191_11 = (arg_188_1.time_ - var_191_9) / var_191_10

				if arg_188_1.var_.actorSpriteComps1034 then
					for iter_191_4, iter_191_5 in pairs(arg_188_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_191_5 then
							if arg_188_1.isInRecall_ then
								local var_191_12 = Mathf.Lerp(iter_191_5.color.r, arg_188_1.hightColor2.r, var_191_11)
								local var_191_13 = Mathf.Lerp(iter_191_5.color.g, arg_188_1.hightColor2.g, var_191_11)
								local var_191_14 = Mathf.Lerp(iter_191_5.color.b, arg_188_1.hightColor2.b, var_191_11)

								iter_191_5.color = Color.New(var_191_12, var_191_13, var_191_14)
							else
								local var_191_15 = Mathf.Lerp(iter_191_5.color.r, 0.5, var_191_11)

								iter_191_5.color = Color.New(var_191_15, var_191_15, var_191_15)
							end
						end
					end
				end
			end

			if arg_188_1.time_ >= var_191_9 + var_191_10 and arg_188_1.time_ < var_191_9 + var_191_10 + arg_191_0 and not isNil(var_191_8) and arg_188_1.var_.actorSpriteComps1034 then
				for iter_191_6, iter_191_7 in pairs(arg_188_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_191_7 then
						if arg_188_1.isInRecall_ then
							iter_191_7.color = arg_188_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_191_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_188_1.var_.actorSpriteComps1034 = nil
			end

			local var_191_16 = 0
			local var_191_17 = 0.625

			if var_191_16 < arg_188_1.time_ and arg_188_1.time_ <= var_191_16 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				local var_191_18 = arg_188_1:FormatText(StoryNameCfg[595].name)

				arg_188_1.leftNameTxt_.text = var_191_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_19 = arg_188_1:GetWordFromCfg(417141046)
				local var_191_20 = arg_188_1:FormatText(var_191_19.content)

				arg_188_1.text_.text = var_191_20

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_21 = 25
				local var_191_22 = utf8.len(var_191_20)
				local var_191_23 = var_191_21 <= 0 and var_191_17 or var_191_17 * (var_191_22 / var_191_21)

				if var_191_23 > 0 and var_191_17 < var_191_23 then
					arg_188_1.talkMaxDuration = var_191_23

					if var_191_23 + var_191_16 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_23 + var_191_16
					end
				end

				arg_188_1.text_.text = var_191_20
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417141", "417141046", "story_v_out_417141.awb") ~= 0 then
					local var_191_24 = manager.audio:GetVoiceLength("story_v_out_417141", "417141046", "story_v_out_417141.awb") / 1000

					if var_191_24 + var_191_16 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_24 + var_191_16
					end

					if var_191_19.prefab_name ~= "" and arg_188_1.actors_[var_191_19.prefab_name] ~= nil then
						local var_191_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_19.prefab_name].transform, "story_v_out_417141", "417141046", "story_v_out_417141.awb")

						arg_188_1:RecordAudio("417141046", var_191_25)
						arg_188_1:RecordAudio("417141046", var_191_25)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_417141", "417141046", "story_v_out_417141.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_417141", "417141046", "story_v_out_417141.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_26 = math.max(var_191_17, arg_188_1.talkMaxDuration)

			if var_191_16 <= arg_188_1.time_ and arg_188_1.time_ < var_191_16 + var_191_26 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_16) / var_191_26

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_16 + var_191_26 and arg_188_1.time_ < var_191_16 + var_191_26 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play417141047 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 417141047
		arg_192_1.duration_ = 10.87

		local var_192_0 = {
			zh = 8.2,
			ja = 10.866
		}
		local var_192_1 = manager.audio:GetLocalizationFlag()

		if var_192_0[var_192_1] ~= nil then
			arg_192_1.duration_ = var_192_0[var_192_1]
		end

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play417141048(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = arg_192_1.actors_["1034"]
			local var_195_1 = 0

			if var_195_1 < arg_192_1.time_ and arg_192_1.time_ <= var_195_1 + arg_195_0 and not isNil(var_195_0) and arg_192_1.var_.actorSpriteComps1034 == nil then
				arg_192_1.var_.actorSpriteComps1034 = var_195_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_195_2 = 0.2

			if var_195_1 <= arg_192_1.time_ and arg_192_1.time_ < var_195_1 + var_195_2 and not isNil(var_195_0) then
				local var_195_3 = (arg_192_1.time_ - var_195_1) / var_195_2

				if arg_192_1.var_.actorSpriteComps1034 then
					for iter_195_0, iter_195_1 in pairs(arg_192_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_195_1 then
							if arg_192_1.isInRecall_ then
								local var_195_4 = Mathf.Lerp(iter_195_1.color.r, arg_192_1.hightColor1.r, var_195_3)
								local var_195_5 = Mathf.Lerp(iter_195_1.color.g, arg_192_1.hightColor1.g, var_195_3)
								local var_195_6 = Mathf.Lerp(iter_195_1.color.b, arg_192_1.hightColor1.b, var_195_3)

								iter_195_1.color = Color.New(var_195_4, var_195_5, var_195_6)
							else
								local var_195_7 = Mathf.Lerp(iter_195_1.color.r, 1, var_195_3)

								iter_195_1.color = Color.New(var_195_7, var_195_7, var_195_7)
							end
						end
					end
				end
			end

			if arg_192_1.time_ >= var_195_1 + var_195_2 and arg_192_1.time_ < var_195_1 + var_195_2 + arg_195_0 and not isNil(var_195_0) and arg_192_1.var_.actorSpriteComps1034 then
				for iter_195_2, iter_195_3 in pairs(arg_192_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_195_3 then
						if arg_192_1.isInRecall_ then
							iter_195_3.color = arg_192_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_195_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_192_1.var_.actorSpriteComps1034 = nil
			end

			local var_195_8 = arg_192_1.actors_["10128"]
			local var_195_9 = 0

			if var_195_9 < arg_192_1.time_ and arg_192_1.time_ <= var_195_9 + arg_195_0 and not isNil(var_195_8) and arg_192_1.var_.actorSpriteComps10128 == nil then
				arg_192_1.var_.actorSpriteComps10128 = var_195_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_195_10 = 0.2

			if var_195_9 <= arg_192_1.time_ and arg_192_1.time_ < var_195_9 + var_195_10 and not isNil(var_195_8) then
				local var_195_11 = (arg_192_1.time_ - var_195_9) / var_195_10

				if arg_192_1.var_.actorSpriteComps10128 then
					for iter_195_4, iter_195_5 in pairs(arg_192_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_195_5 then
							if arg_192_1.isInRecall_ then
								local var_195_12 = Mathf.Lerp(iter_195_5.color.r, arg_192_1.hightColor2.r, var_195_11)
								local var_195_13 = Mathf.Lerp(iter_195_5.color.g, arg_192_1.hightColor2.g, var_195_11)
								local var_195_14 = Mathf.Lerp(iter_195_5.color.b, arg_192_1.hightColor2.b, var_195_11)

								iter_195_5.color = Color.New(var_195_12, var_195_13, var_195_14)
							else
								local var_195_15 = Mathf.Lerp(iter_195_5.color.r, 0.5, var_195_11)

								iter_195_5.color = Color.New(var_195_15, var_195_15, var_195_15)
							end
						end
					end
				end
			end

			if arg_192_1.time_ >= var_195_9 + var_195_10 and arg_192_1.time_ < var_195_9 + var_195_10 + arg_195_0 and not isNil(var_195_8) and arg_192_1.var_.actorSpriteComps10128 then
				for iter_195_6, iter_195_7 in pairs(arg_192_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_195_7 then
						if arg_192_1.isInRecall_ then
							iter_195_7.color = arg_192_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_195_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_192_1.var_.actorSpriteComps10128 = nil
			end

			local var_195_16 = arg_192_1.actors_["1034"].transform
			local var_195_17 = 0

			if var_195_17 < arg_192_1.time_ and arg_192_1.time_ <= var_195_17 + arg_195_0 then
				arg_192_1.var_.moveOldPos1034 = var_195_16.localPosition
				var_195_16.localScale = Vector3.New(1, 1, 1)

				arg_192_1:CheckSpriteTmpPos("1034", 4)

				local var_195_18 = var_195_16.childCount

				for iter_195_8 = 0, var_195_18 - 1 do
					local var_195_19 = var_195_16:GetChild(iter_195_8)

					if var_195_19.name == "split_4" or not string.find(var_195_19.name, "split") then
						var_195_19.gameObject:SetActive(true)
					else
						var_195_19.gameObject:SetActive(false)
					end
				end
			end

			local var_195_20 = 0.001

			if var_195_17 <= arg_192_1.time_ and arg_192_1.time_ < var_195_17 + var_195_20 then
				local var_195_21 = (arg_192_1.time_ - var_195_17) / var_195_20
				local var_195_22 = Vector3.New(373.7, -331.9, -324)

				var_195_16.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos1034, var_195_22, var_195_21)
			end

			if arg_192_1.time_ >= var_195_17 + var_195_20 and arg_192_1.time_ < var_195_17 + var_195_20 + arg_195_0 then
				var_195_16.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_195_23 = arg_192_1.actors_["10128"].transform
			local var_195_24 = 0

			if var_195_24 < arg_192_1.time_ and arg_192_1.time_ <= var_195_24 + arg_195_0 then
				arg_192_1.var_.moveOldPos10128 = var_195_23.localPosition
				var_195_23.localScale = Vector3.New(1, 1, 1)

				arg_192_1:CheckSpriteTmpPos("10128", 2)

				local var_195_25 = var_195_23.childCount

				for iter_195_9 = 0, var_195_25 - 1 do
					local var_195_26 = var_195_23:GetChild(iter_195_9)

					if var_195_26.name == "split_6" or not string.find(var_195_26.name, "split") then
						var_195_26.gameObject:SetActive(true)
					else
						var_195_26.gameObject:SetActive(false)
					end
				end
			end

			local var_195_27 = 0.001

			if var_195_24 <= arg_192_1.time_ and arg_192_1.time_ < var_195_24 + var_195_27 then
				local var_195_28 = (arg_192_1.time_ - var_195_24) / var_195_27
				local var_195_29 = Vector3.New(-390, -347, -300)

				var_195_23.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos10128, var_195_29, var_195_28)
			end

			if arg_192_1.time_ >= var_195_24 + var_195_27 and arg_192_1.time_ < var_195_24 + var_195_27 + arg_195_0 then
				var_195_23.localPosition = Vector3.New(-390, -347, -300)
			end

			local var_195_30 = 0
			local var_195_31 = 0.725

			if var_195_30 < arg_192_1.time_ and arg_192_1.time_ <= var_195_30 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				local var_195_32 = arg_192_1:FormatText(StoryNameCfg[1109].name)

				arg_192_1.leftNameTxt_.text = var_195_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_33 = arg_192_1:GetWordFromCfg(417141047)
				local var_195_34 = arg_192_1:FormatText(var_195_33.content)

				arg_192_1.text_.text = var_195_34

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_35 = 29
				local var_195_36 = utf8.len(var_195_34)
				local var_195_37 = var_195_35 <= 0 and var_195_31 or var_195_31 * (var_195_36 / var_195_35)

				if var_195_37 > 0 and var_195_31 < var_195_37 then
					arg_192_1.talkMaxDuration = var_195_37

					if var_195_37 + var_195_30 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_37 + var_195_30
					end
				end

				arg_192_1.text_.text = var_195_34
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417141", "417141047", "story_v_out_417141.awb") ~= 0 then
					local var_195_38 = manager.audio:GetVoiceLength("story_v_out_417141", "417141047", "story_v_out_417141.awb") / 1000

					if var_195_38 + var_195_30 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_38 + var_195_30
					end

					if var_195_33.prefab_name ~= "" and arg_192_1.actors_[var_195_33.prefab_name] ~= nil then
						local var_195_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_33.prefab_name].transform, "story_v_out_417141", "417141047", "story_v_out_417141.awb")

						arg_192_1:RecordAudio("417141047", var_195_39)
						arg_192_1:RecordAudio("417141047", var_195_39)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_417141", "417141047", "story_v_out_417141.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_417141", "417141047", "story_v_out_417141.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_40 = math.max(var_195_31, arg_192_1.talkMaxDuration)

			if var_195_30 <= arg_192_1.time_ and arg_192_1.time_ < var_195_30 + var_195_40 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_30) / var_195_40

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_30 + var_195_40 and arg_192_1.time_ < var_195_30 + var_195_40 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_192_1:InitPlayNodeList()
	end,
	Play417141048 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 417141048
		arg_196_1.duration_ = 1.33

		local var_196_0 = {
			zh = 1.133,
			ja = 1.333
		}
		local var_196_1 = manager.audio:GetLocalizationFlag()

		if var_196_0[var_196_1] ~= nil then
			arg_196_1.duration_ = var_196_0[var_196_1]
		end

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play417141049(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = arg_196_1.actors_["10128"]
			local var_199_1 = 0

			if var_199_1 < arg_196_1.time_ and arg_196_1.time_ <= var_199_1 + arg_199_0 and not isNil(var_199_0) and arg_196_1.var_.actorSpriteComps10128 == nil then
				arg_196_1.var_.actorSpriteComps10128 = var_199_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_199_2 = 0.2

			if var_199_1 <= arg_196_1.time_ and arg_196_1.time_ < var_199_1 + var_199_2 and not isNil(var_199_0) then
				local var_199_3 = (arg_196_1.time_ - var_199_1) / var_199_2

				if arg_196_1.var_.actorSpriteComps10128 then
					for iter_199_0, iter_199_1 in pairs(arg_196_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_199_1 then
							if arg_196_1.isInRecall_ then
								local var_199_4 = Mathf.Lerp(iter_199_1.color.r, arg_196_1.hightColor1.r, var_199_3)
								local var_199_5 = Mathf.Lerp(iter_199_1.color.g, arg_196_1.hightColor1.g, var_199_3)
								local var_199_6 = Mathf.Lerp(iter_199_1.color.b, arg_196_1.hightColor1.b, var_199_3)

								iter_199_1.color = Color.New(var_199_4, var_199_5, var_199_6)
							else
								local var_199_7 = Mathf.Lerp(iter_199_1.color.r, 1, var_199_3)

								iter_199_1.color = Color.New(var_199_7, var_199_7, var_199_7)
							end
						end
					end
				end
			end

			if arg_196_1.time_ >= var_199_1 + var_199_2 and arg_196_1.time_ < var_199_1 + var_199_2 + arg_199_0 and not isNil(var_199_0) and arg_196_1.var_.actorSpriteComps10128 then
				for iter_199_2, iter_199_3 in pairs(arg_196_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_199_3 then
						if arg_196_1.isInRecall_ then
							iter_199_3.color = arg_196_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_199_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_196_1.var_.actorSpriteComps10128 = nil
			end

			local var_199_8 = arg_196_1.actors_["1034"]
			local var_199_9 = 0

			if var_199_9 < arg_196_1.time_ and arg_196_1.time_ <= var_199_9 + arg_199_0 and not isNil(var_199_8) and arg_196_1.var_.actorSpriteComps1034 == nil then
				arg_196_1.var_.actorSpriteComps1034 = var_199_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_199_10 = 0.2

			if var_199_9 <= arg_196_1.time_ and arg_196_1.time_ < var_199_9 + var_199_10 and not isNil(var_199_8) then
				local var_199_11 = (arg_196_1.time_ - var_199_9) / var_199_10

				if arg_196_1.var_.actorSpriteComps1034 then
					for iter_199_4, iter_199_5 in pairs(arg_196_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_199_5 then
							if arg_196_1.isInRecall_ then
								local var_199_12 = Mathf.Lerp(iter_199_5.color.r, arg_196_1.hightColor2.r, var_199_11)
								local var_199_13 = Mathf.Lerp(iter_199_5.color.g, arg_196_1.hightColor2.g, var_199_11)
								local var_199_14 = Mathf.Lerp(iter_199_5.color.b, arg_196_1.hightColor2.b, var_199_11)

								iter_199_5.color = Color.New(var_199_12, var_199_13, var_199_14)
							else
								local var_199_15 = Mathf.Lerp(iter_199_5.color.r, 0.5, var_199_11)

								iter_199_5.color = Color.New(var_199_15, var_199_15, var_199_15)
							end
						end
					end
				end
			end

			if arg_196_1.time_ >= var_199_9 + var_199_10 and arg_196_1.time_ < var_199_9 + var_199_10 + arg_199_0 and not isNil(var_199_8) and arg_196_1.var_.actorSpriteComps1034 then
				for iter_199_6, iter_199_7 in pairs(arg_196_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_199_7 then
						if arg_196_1.isInRecall_ then
							iter_199_7.color = arg_196_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_199_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_196_1.var_.actorSpriteComps1034 = nil
			end

			local var_199_16 = 0
			local var_199_17 = 0.1

			if var_199_16 < arg_196_1.time_ and arg_196_1.time_ <= var_199_16 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				local var_199_18 = arg_196_1:FormatText(StoryNameCfg[595].name)

				arg_196_1.leftNameTxt_.text = var_199_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_19 = arg_196_1:GetWordFromCfg(417141048)
				local var_199_20 = arg_196_1:FormatText(var_199_19.content)

				arg_196_1.text_.text = var_199_20

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_21 = 4
				local var_199_22 = utf8.len(var_199_20)
				local var_199_23 = var_199_21 <= 0 and var_199_17 or var_199_17 * (var_199_22 / var_199_21)

				if var_199_23 > 0 and var_199_17 < var_199_23 then
					arg_196_1.talkMaxDuration = var_199_23

					if var_199_23 + var_199_16 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_23 + var_199_16
					end
				end

				arg_196_1.text_.text = var_199_20
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417141", "417141048", "story_v_out_417141.awb") ~= 0 then
					local var_199_24 = manager.audio:GetVoiceLength("story_v_out_417141", "417141048", "story_v_out_417141.awb") / 1000

					if var_199_24 + var_199_16 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_24 + var_199_16
					end

					if var_199_19.prefab_name ~= "" and arg_196_1.actors_[var_199_19.prefab_name] ~= nil then
						local var_199_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_19.prefab_name].transform, "story_v_out_417141", "417141048", "story_v_out_417141.awb")

						arg_196_1:RecordAudio("417141048", var_199_25)
						arg_196_1:RecordAudio("417141048", var_199_25)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_417141", "417141048", "story_v_out_417141.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_417141", "417141048", "story_v_out_417141.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_26 = math.max(var_199_17, arg_196_1.talkMaxDuration)

			if var_199_16 <= arg_196_1.time_ and arg_196_1.time_ < var_199_16 + var_199_26 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_16) / var_199_26

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_16 + var_199_26 and arg_196_1.time_ < var_199_16 + var_199_26 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play417141049 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 417141049
		arg_200_1.duration_ = 3.2

		local var_200_0 = {
			zh = 1.166,
			ja = 3.2
		}
		local var_200_1 = manager.audio:GetLocalizationFlag()

		if var_200_0[var_200_1] ~= nil then
			arg_200_1.duration_ = var_200_0[var_200_1]
		end

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play417141050(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = arg_200_1.actors_["1034"]
			local var_203_1 = 0

			if var_203_1 < arg_200_1.time_ and arg_200_1.time_ <= var_203_1 + arg_203_0 and not isNil(var_203_0) and arg_200_1.var_.actorSpriteComps1034 == nil then
				arg_200_1.var_.actorSpriteComps1034 = var_203_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_203_2 = 0.2

			if var_203_1 <= arg_200_1.time_ and arg_200_1.time_ < var_203_1 + var_203_2 and not isNil(var_203_0) then
				local var_203_3 = (arg_200_1.time_ - var_203_1) / var_203_2

				if arg_200_1.var_.actorSpriteComps1034 then
					for iter_203_0, iter_203_1 in pairs(arg_200_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_203_1 then
							if arg_200_1.isInRecall_ then
								local var_203_4 = Mathf.Lerp(iter_203_1.color.r, arg_200_1.hightColor1.r, var_203_3)
								local var_203_5 = Mathf.Lerp(iter_203_1.color.g, arg_200_1.hightColor1.g, var_203_3)
								local var_203_6 = Mathf.Lerp(iter_203_1.color.b, arg_200_1.hightColor1.b, var_203_3)

								iter_203_1.color = Color.New(var_203_4, var_203_5, var_203_6)
							else
								local var_203_7 = Mathf.Lerp(iter_203_1.color.r, 1, var_203_3)

								iter_203_1.color = Color.New(var_203_7, var_203_7, var_203_7)
							end
						end
					end
				end
			end

			if arg_200_1.time_ >= var_203_1 + var_203_2 and arg_200_1.time_ < var_203_1 + var_203_2 + arg_203_0 and not isNil(var_203_0) and arg_200_1.var_.actorSpriteComps1034 then
				for iter_203_2, iter_203_3 in pairs(arg_200_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_203_3 then
						if arg_200_1.isInRecall_ then
							iter_203_3.color = arg_200_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_203_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_200_1.var_.actorSpriteComps1034 = nil
			end

			local var_203_8 = arg_200_1.actors_["10128"]
			local var_203_9 = 0

			if var_203_9 < arg_200_1.time_ and arg_200_1.time_ <= var_203_9 + arg_203_0 and not isNil(var_203_8) and arg_200_1.var_.actorSpriteComps10128 == nil then
				arg_200_1.var_.actorSpriteComps10128 = var_203_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_203_10 = 0.2

			if var_203_9 <= arg_200_1.time_ and arg_200_1.time_ < var_203_9 + var_203_10 and not isNil(var_203_8) then
				local var_203_11 = (arg_200_1.time_ - var_203_9) / var_203_10

				if arg_200_1.var_.actorSpriteComps10128 then
					for iter_203_4, iter_203_5 in pairs(arg_200_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_203_5 then
							if arg_200_1.isInRecall_ then
								local var_203_12 = Mathf.Lerp(iter_203_5.color.r, arg_200_1.hightColor2.r, var_203_11)
								local var_203_13 = Mathf.Lerp(iter_203_5.color.g, arg_200_1.hightColor2.g, var_203_11)
								local var_203_14 = Mathf.Lerp(iter_203_5.color.b, arg_200_1.hightColor2.b, var_203_11)

								iter_203_5.color = Color.New(var_203_12, var_203_13, var_203_14)
							else
								local var_203_15 = Mathf.Lerp(iter_203_5.color.r, 0.5, var_203_11)

								iter_203_5.color = Color.New(var_203_15, var_203_15, var_203_15)
							end
						end
					end
				end
			end

			if arg_200_1.time_ >= var_203_9 + var_203_10 and arg_200_1.time_ < var_203_9 + var_203_10 + arg_203_0 and not isNil(var_203_8) and arg_200_1.var_.actorSpriteComps10128 then
				for iter_203_6, iter_203_7 in pairs(arg_200_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_203_7 then
						if arg_200_1.isInRecall_ then
							iter_203_7.color = arg_200_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_203_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_200_1.var_.actorSpriteComps10128 = nil
			end

			local var_203_16 = arg_200_1.actors_["1034"].transform
			local var_203_17 = 0

			if var_203_17 < arg_200_1.time_ and arg_200_1.time_ <= var_203_17 + arg_203_0 then
				arg_200_1.var_.moveOldPos1034 = var_203_16.localPosition
				var_203_16.localScale = Vector3.New(1, 1, 1)

				arg_200_1:CheckSpriteTmpPos("1034", 4)

				local var_203_18 = var_203_16.childCount

				for iter_203_8 = 0, var_203_18 - 1 do
					local var_203_19 = var_203_16:GetChild(iter_203_8)

					if var_203_19.name == "split_5" or not string.find(var_203_19.name, "split") then
						var_203_19.gameObject:SetActive(true)
					else
						var_203_19.gameObject:SetActive(false)
					end
				end
			end

			local var_203_20 = 0.001

			if var_203_17 <= arg_200_1.time_ and arg_200_1.time_ < var_203_17 + var_203_20 then
				local var_203_21 = (arg_200_1.time_ - var_203_17) / var_203_20
				local var_203_22 = Vector3.New(373.7, -331.9, -324)

				var_203_16.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos1034, var_203_22, var_203_21)
			end

			if arg_200_1.time_ >= var_203_17 + var_203_20 and arg_200_1.time_ < var_203_17 + var_203_20 + arg_203_0 then
				var_203_16.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_203_23 = 0
			local var_203_24 = 0.1

			if var_203_23 < arg_200_1.time_ and arg_200_1.time_ <= var_203_23 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				local var_203_25 = arg_200_1:FormatText(StoryNameCfg[1109].name)

				arg_200_1.leftNameTxt_.text = var_203_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_26 = arg_200_1:GetWordFromCfg(417141049)
				local var_203_27 = arg_200_1:FormatText(var_203_26.content)

				arg_200_1.text_.text = var_203_27

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_28 = 4
				local var_203_29 = utf8.len(var_203_27)
				local var_203_30 = var_203_28 <= 0 and var_203_24 or var_203_24 * (var_203_29 / var_203_28)

				if var_203_30 > 0 and var_203_24 < var_203_30 then
					arg_200_1.talkMaxDuration = var_203_30

					if var_203_30 + var_203_23 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_30 + var_203_23
					end
				end

				arg_200_1.text_.text = var_203_27
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417141", "417141049", "story_v_out_417141.awb") ~= 0 then
					local var_203_31 = manager.audio:GetVoiceLength("story_v_out_417141", "417141049", "story_v_out_417141.awb") / 1000

					if var_203_31 + var_203_23 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_31 + var_203_23
					end

					if var_203_26.prefab_name ~= "" and arg_200_1.actors_[var_203_26.prefab_name] ~= nil then
						local var_203_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_26.prefab_name].transform, "story_v_out_417141", "417141049", "story_v_out_417141.awb")

						arg_200_1:RecordAudio("417141049", var_203_32)
						arg_200_1:RecordAudio("417141049", var_203_32)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_417141", "417141049", "story_v_out_417141.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_417141", "417141049", "story_v_out_417141.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_33 = math.max(var_203_24, arg_200_1.talkMaxDuration)

			if var_203_23 <= arg_200_1.time_ and arg_200_1.time_ < var_203_23 + var_203_33 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_23) / var_203_33

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_23 + var_203_33 and arg_200_1.time_ < var_203_23 + var_203_33 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_200_1:InitPlayNodeList()
	end,
	Play417141050 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 417141050
		arg_204_1.duration_ = 10.37

		local var_204_0 = {
			zh = 3.433,
			ja = 10.366
		}
		local var_204_1 = manager.audio:GetLocalizationFlag()

		if var_204_0[var_204_1] ~= nil then
			arg_204_1.duration_ = var_204_0[var_204_1]
		end

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play417141051(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = arg_204_1.actors_["10128"]
			local var_207_1 = 0

			if var_207_1 < arg_204_1.time_ and arg_204_1.time_ <= var_207_1 + arg_207_0 and not isNil(var_207_0) and arg_204_1.var_.actorSpriteComps10128 == nil then
				arg_204_1.var_.actorSpriteComps10128 = var_207_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_207_2 = 0.2

			if var_207_1 <= arg_204_1.time_ and arg_204_1.time_ < var_207_1 + var_207_2 and not isNil(var_207_0) then
				local var_207_3 = (arg_204_1.time_ - var_207_1) / var_207_2

				if arg_204_1.var_.actorSpriteComps10128 then
					for iter_207_0, iter_207_1 in pairs(arg_204_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_207_1 then
							if arg_204_1.isInRecall_ then
								local var_207_4 = Mathf.Lerp(iter_207_1.color.r, arg_204_1.hightColor1.r, var_207_3)
								local var_207_5 = Mathf.Lerp(iter_207_1.color.g, arg_204_1.hightColor1.g, var_207_3)
								local var_207_6 = Mathf.Lerp(iter_207_1.color.b, arg_204_1.hightColor1.b, var_207_3)

								iter_207_1.color = Color.New(var_207_4, var_207_5, var_207_6)
							else
								local var_207_7 = Mathf.Lerp(iter_207_1.color.r, 1, var_207_3)

								iter_207_1.color = Color.New(var_207_7, var_207_7, var_207_7)
							end
						end
					end
				end
			end

			if arg_204_1.time_ >= var_207_1 + var_207_2 and arg_204_1.time_ < var_207_1 + var_207_2 + arg_207_0 and not isNil(var_207_0) and arg_204_1.var_.actorSpriteComps10128 then
				for iter_207_2, iter_207_3 in pairs(arg_204_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_207_3 then
						if arg_204_1.isInRecall_ then
							iter_207_3.color = arg_204_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_207_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_204_1.var_.actorSpriteComps10128 = nil
			end

			local var_207_8 = arg_204_1.actors_["1034"]
			local var_207_9 = 0

			if var_207_9 < arg_204_1.time_ and arg_204_1.time_ <= var_207_9 + arg_207_0 and not isNil(var_207_8) and arg_204_1.var_.actorSpriteComps1034 == nil then
				arg_204_1.var_.actorSpriteComps1034 = var_207_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_207_10 = 0.2

			if var_207_9 <= arg_204_1.time_ and arg_204_1.time_ < var_207_9 + var_207_10 and not isNil(var_207_8) then
				local var_207_11 = (arg_204_1.time_ - var_207_9) / var_207_10

				if arg_204_1.var_.actorSpriteComps1034 then
					for iter_207_4, iter_207_5 in pairs(arg_204_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_207_5 then
							if arg_204_1.isInRecall_ then
								local var_207_12 = Mathf.Lerp(iter_207_5.color.r, arg_204_1.hightColor2.r, var_207_11)
								local var_207_13 = Mathf.Lerp(iter_207_5.color.g, arg_204_1.hightColor2.g, var_207_11)
								local var_207_14 = Mathf.Lerp(iter_207_5.color.b, arg_204_1.hightColor2.b, var_207_11)

								iter_207_5.color = Color.New(var_207_12, var_207_13, var_207_14)
							else
								local var_207_15 = Mathf.Lerp(iter_207_5.color.r, 0.5, var_207_11)

								iter_207_5.color = Color.New(var_207_15, var_207_15, var_207_15)
							end
						end
					end
				end
			end

			if arg_204_1.time_ >= var_207_9 + var_207_10 and arg_204_1.time_ < var_207_9 + var_207_10 + arg_207_0 and not isNil(var_207_8) and arg_204_1.var_.actorSpriteComps1034 then
				for iter_207_6, iter_207_7 in pairs(arg_204_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_207_7 then
						if arg_204_1.isInRecall_ then
							iter_207_7.color = arg_204_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_207_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_204_1.var_.actorSpriteComps1034 = nil
			end

			local var_207_16 = 0
			local var_207_17 = 0.5

			if var_207_16 < arg_204_1.time_ and arg_204_1.time_ <= var_207_16 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				local var_207_18 = arg_204_1:FormatText(StoryNameCfg[595].name)

				arg_204_1.leftNameTxt_.text = var_207_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_19 = arg_204_1:GetWordFromCfg(417141050)
				local var_207_20 = arg_204_1:FormatText(var_207_19.content)

				arg_204_1.text_.text = var_207_20

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_21 = 20
				local var_207_22 = utf8.len(var_207_20)
				local var_207_23 = var_207_21 <= 0 and var_207_17 or var_207_17 * (var_207_22 / var_207_21)

				if var_207_23 > 0 and var_207_17 < var_207_23 then
					arg_204_1.talkMaxDuration = var_207_23

					if var_207_23 + var_207_16 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_23 + var_207_16
					end
				end

				arg_204_1.text_.text = var_207_20
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417141", "417141050", "story_v_out_417141.awb") ~= 0 then
					local var_207_24 = manager.audio:GetVoiceLength("story_v_out_417141", "417141050", "story_v_out_417141.awb") / 1000

					if var_207_24 + var_207_16 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_24 + var_207_16
					end

					if var_207_19.prefab_name ~= "" and arg_204_1.actors_[var_207_19.prefab_name] ~= nil then
						local var_207_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_19.prefab_name].transform, "story_v_out_417141", "417141050", "story_v_out_417141.awb")

						arg_204_1:RecordAudio("417141050", var_207_25)
						arg_204_1:RecordAudio("417141050", var_207_25)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_417141", "417141050", "story_v_out_417141.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_417141", "417141050", "story_v_out_417141.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_26 = math.max(var_207_17, arg_204_1.talkMaxDuration)

			if var_207_16 <= arg_204_1.time_ and arg_204_1.time_ < var_207_16 + var_207_26 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_16) / var_207_26

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_16 + var_207_26 and arg_204_1.time_ < var_207_16 + var_207_26 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play417141051 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 417141051
		arg_208_1.duration_ = 7.63

		local var_208_0 = {
			zh = 4.033,
			ja = 7.633
		}
		local var_208_1 = manager.audio:GetLocalizationFlag()

		if var_208_0[var_208_1] ~= nil then
			arg_208_1.duration_ = var_208_0[var_208_1]
		end

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play417141052(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = 0
			local var_211_1 = 0.425

			if var_211_0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_0 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				local var_211_2 = arg_208_1:FormatText(StoryNameCfg[595].name)

				arg_208_1.leftNameTxt_.text = var_211_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_3 = arg_208_1:GetWordFromCfg(417141051)
				local var_211_4 = arg_208_1:FormatText(var_211_3.content)

				arg_208_1.text_.text = var_211_4

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_5 = 17
				local var_211_6 = utf8.len(var_211_4)
				local var_211_7 = var_211_5 <= 0 and var_211_1 or var_211_1 * (var_211_6 / var_211_5)

				if var_211_7 > 0 and var_211_1 < var_211_7 then
					arg_208_1.talkMaxDuration = var_211_7

					if var_211_7 + var_211_0 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_7 + var_211_0
					end
				end

				arg_208_1.text_.text = var_211_4
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417141", "417141051", "story_v_out_417141.awb") ~= 0 then
					local var_211_8 = manager.audio:GetVoiceLength("story_v_out_417141", "417141051", "story_v_out_417141.awb") / 1000

					if var_211_8 + var_211_0 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_8 + var_211_0
					end

					if var_211_3.prefab_name ~= "" and arg_208_1.actors_[var_211_3.prefab_name] ~= nil then
						local var_211_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_3.prefab_name].transform, "story_v_out_417141", "417141051", "story_v_out_417141.awb")

						arg_208_1:RecordAudio("417141051", var_211_9)
						arg_208_1:RecordAudio("417141051", var_211_9)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_417141", "417141051", "story_v_out_417141.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_417141", "417141051", "story_v_out_417141.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_10 = math.max(var_211_1, arg_208_1.talkMaxDuration)

			if var_211_0 <= arg_208_1.time_ and arg_208_1.time_ < var_211_0 + var_211_10 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_0) / var_211_10

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_0 + var_211_10 and arg_208_1.time_ < var_211_0 + var_211_10 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play417141052 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 417141052
		arg_212_1.duration_ = 9.3

		local var_212_0 = {
			zh = 5.3,
			ja = 9.3
		}
		local var_212_1 = manager.audio:GetLocalizationFlag()

		if var_212_0[var_212_1] ~= nil then
			arg_212_1.duration_ = var_212_0[var_212_1]
		end

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play417141053(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = arg_212_1.actors_["1034"]
			local var_215_1 = 0

			if var_215_1 < arg_212_1.time_ and arg_212_1.time_ <= var_215_1 + arg_215_0 and not isNil(var_215_0) and arg_212_1.var_.actorSpriteComps1034 == nil then
				arg_212_1.var_.actorSpriteComps1034 = var_215_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_215_2 = 0.2

			if var_215_1 <= arg_212_1.time_ and arg_212_1.time_ < var_215_1 + var_215_2 and not isNil(var_215_0) then
				local var_215_3 = (arg_212_1.time_ - var_215_1) / var_215_2

				if arg_212_1.var_.actorSpriteComps1034 then
					for iter_215_0, iter_215_1 in pairs(arg_212_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_215_1 then
							if arg_212_1.isInRecall_ then
								local var_215_4 = Mathf.Lerp(iter_215_1.color.r, arg_212_1.hightColor1.r, var_215_3)
								local var_215_5 = Mathf.Lerp(iter_215_1.color.g, arg_212_1.hightColor1.g, var_215_3)
								local var_215_6 = Mathf.Lerp(iter_215_1.color.b, arg_212_1.hightColor1.b, var_215_3)

								iter_215_1.color = Color.New(var_215_4, var_215_5, var_215_6)
							else
								local var_215_7 = Mathf.Lerp(iter_215_1.color.r, 1, var_215_3)

								iter_215_1.color = Color.New(var_215_7, var_215_7, var_215_7)
							end
						end
					end
				end
			end

			if arg_212_1.time_ >= var_215_1 + var_215_2 and arg_212_1.time_ < var_215_1 + var_215_2 + arg_215_0 and not isNil(var_215_0) and arg_212_1.var_.actorSpriteComps1034 then
				for iter_215_2, iter_215_3 in pairs(arg_212_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_215_3 then
						if arg_212_1.isInRecall_ then
							iter_215_3.color = arg_212_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_215_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_212_1.var_.actorSpriteComps1034 = nil
			end

			local var_215_8 = arg_212_1.actors_["1034"].transform
			local var_215_9 = 0

			if var_215_9 < arg_212_1.time_ and arg_212_1.time_ <= var_215_9 + arg_215_0 then
				arg_212_1.var_.moveOldPos1034 = var_215_8.localPosition
				var_215_8.localScale = Vector3.New(1, 1, 1)

				arg_212_1:CheckSpriteTmpPos("1034", 3)

				local var_215_10 = var_215_8.childCount

				for iter_215_4 = 0, var_215_10 - 1 do
					local var_215_11 = var_215_8:GetChild(iter_215_4)

					if var_215_11.name == "split_6" or not string.find(var_215_11.name, "split") then
						var_215_11.gameObject:SetActive(true)
					else
						var_215_11.gameObject:SetActive(false)
					end
				end
			end

			local var_215_12 = 0.001

			if var_215_9 <= arg_212_1.time_ and arg_212_1.time_ < var_215_9 + var_215_12 then
				local var_215_13 = (arg_212_1.time_ - var_215_9) / var_215_12
				local var_215_14 = Vector3.New(0, -331.9, -324)

				var_215_8.localPosition = Vector3.Lerp(arg_212_1.var_.moveOldPos1034, var_215_14, var_215_13)
			end

			if arg_212_1.time_ >= var_215_9 + var_215_12 and arg_212_1.time_ < var_215_9 + var_215_12 + arg_215_0 then
				var_215_8.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_215_15 = arg_212_1.actors_["10128"].transform
			local var_215_16 = 0

			if var_215_16 < arg_212_1.time_ and arg_212_1.time_ <= var_215_16 + arg_215_0 then
				arg_212_1.var_.moveOldPos10128 = var_215_15.localPosition
				var_215_15.localScale = Vector3.New(1, 1, 1)

				arg_212_1:CheckSpriteTmpPos("10128", 7)

				local var_215_17 = var_215_15.childCount

				for iter_215_5 = 0, var_215_17 - 1 do
					local var_215_18 = var_215_15:GetChild(iter_215_5)

					if var_215_18.name == "" or not string.find(var_215_18.name, "split") then
						var_215_18.gameObject:SetActive(true)
					else
						var_215_18.gameObject:SetActive(false)
					end
				end
			end

			local var_215_19 = 0.001

			if var_215_16 <= arg_212_1.time_ and arg_212_1.time_ < var_215_16 + var_215_19 then
				local var_215_20 = (arg_212_1.time_ - var_215_16) / var_215_19
				local var_215_21 = Vector3.New(0, -2000, -300)

				var_215_15.localPosition = Vector3.Lerp(arg_212_1.var_.moveOldPos10128, var_215_21, var_215_20)
			end

			if arg_212_1.time_ >= var_215_16 + var_215_19 and arg_212_1.time_ < var_215_16 + var_215_19 + arg_215_0 then
				var_215_15.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_215_22 = 0
			local var_215_23 = 0.725

			if var_215_22 < arg_212_1.time_ and arg_212_1.time_ <= var_215_22 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				local var_215_24 = arg_212_1:FormatText(StoryNameCfg[1109].name)

				arg_212_1.leftNameTxt_.text = var_215_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_25 = arg_212_1:GetWordFromCfg(417141052)
				local var_215_26 = arg_212_1:FormatText(var_215_25.content)

				arg_212_1.text_.text = var_215_26

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_27 = 29
				local var_215_28 = utf8.len(var_215_26)
				local var_215_29 = var_215_27 <= 0 and var_215_23 or var_215_23 * (var_215_28 / var_215_27)

				if var_215_29 > 0 and var_215_23 < var_215_29 then
					arg_212_1.talkMaxDuration = var_215_29

					if var_215_29 + var_215_22 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_29 + var_215_22
					end
				end

				arg_212_1.text_.text = var_215_26
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417141", "417141052", "story_v_out_417141.awb") ~= 0 then
					local var_215_30 = manager.audio:GetVoiceLength("story_v_out_417141", "417141052", "story_v_out_417141.awb") / 1000

					if var_215_30 + var_215_22 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_30 + var_215_22
					end

					if var_215_25.prefab_name ~= "" and arg_212_1.actors_[var_215_25.prefab_name] ~= nil then
						local var_215_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_25.prefab_name].transform, "story_v_out_417141", "417141052", "story_v_out_417141.awb")

						arg_212_1:RecordAudio("417141052", var_215_31)
						arg_212_1:RecordAudio("417141052", var_215_31)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_417141", "417141052", "story_v_out_417141.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_417141", "417141052", "story_v_out_417141.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_32 = math.max(var_215_23, arg_212_1.talkMaxDuration)

			if var_215_22 <= arg_212_1.time_ and arg_212_1.time_ < var_215_22 + var_215_32 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_22) / var_215_32

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_22 + var_215_32 and arg_212_1.time_ < var_215_22 + var_215_32 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_212_1:InitPlayNodeList()
	end,
	Play417141053 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 417141053
		arg_216_1.duration_ = 5.13

		local var_216_0 = {
			zh = 3.633,
			ja = 5.133
		}
		local var_216_1 = manager.audio:GetLocalizationFlag()

		if var_216_0[var_216_1] ~= nil then
			arg_216_1.duration_ = var_216_0[var_216_1]
		end

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play417141054(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = 0
			local var_219_1 = 0.6

			if var_219_0 < arg_216_1.time_ and arg_216_1.time_ <= var_219_0 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				local var_219_2 = arg_216_1:FormatText(StoryNameCfg[1109].name)

				arg_216_1.leftNameTxt_.text = var_219_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_3 = arg_216_1:GetWordFromCfg(417141053)
				local var_219_4 = arg_216_1:FormatText(var_219_3.content)

				arg_216_1.text_.text = var_219_4

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_5 = 13
				local var_219_6 = utf8.len(var_219_4)
				local var_219_7 = var_219_5 <= 0 and var_219_1 or var_219_1 * (var_219_6 / var_219_5)

				if var_219_7 > 0 and var_219_1 < var_219_7 then
					arg_216_1.talkMaxDuration = var_219_7

					if var_219_7 + var_219_0 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_7 + var_219_0
					end
				end

				arg_216_1.text_.text = var_219_4
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417141", "417141053", "story_v_out_417141.awb") ~= 0 then
					local var_219_8 = manager.audio:GetVoiceLength("story_v_out_417141", "417141053", "story_v_out_417141.awb") / 1000

					if var_219_8 + var_219_0 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_8 + var_219_0
					end

					if var_219_3.prefab_name ~= "" and arg_216_1.actors_[var_219_3.prefab_name] ~= nil then
						local var_219_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_3.prefab_name].transform, "story_v_out_417141", "417141053", "story_v_out_417141.awb")

						arg_216_1:RecordAudio("417141053", var_219_9)
						arg_216_1:RecordAudio("417141053", var_219_9)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_417141", "417141053", "story_v_out_417141.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_417141", "417141053", "story_v_out_417141.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_10 = math.max(var_219_1, arg_216_1.talkMaxDuration)

			if var_219_0 <= arg_216_1.time_ and arg_216_1.time_ < var_219_0 + var_219_10 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_0) / var_219_10

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_0 + var_219_10 and arg_216_1.time_ < var_219_0 + var_219_10 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {}

		arg_216_1:InitPlayNodeList()
	end,
	Play417141054 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 417141054
		arg_220_1.duration_ = 5

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play417141055(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			local var_223_0 = arg_220_1.actors_["1034"]
			local var_223_1 = 0

			if var_223_1 < arg_220_1.time_ and arg_220_1.time_ <= var_223_1 + arg_223_0 and not isNil(var_223_0) and arg_220_1.var_.actorSpriteComps1034 == nil then
				arg_220_1.var_.actorSpriteComps1034 = var_223_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_223_2 = 0.2

			if var_223_1 <= arg_220_1.time_ and arg_220_1.time_ < var_223_1 + var_223_2 and not isNil(var_223_0) then
				local var_223_3 = (arg_220_1.time_ - var_223_1) / var_223_2

				if arg_220_1.var_.actorSpriteComps1034 then
					for iter_223_0, iter_223_1 in pairs(arg_220_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_223_1 then
							if arg_220_1.isInRecall_ then
								local var_223_4 = Mathf.Lerp(iter_223_1.color.r, arg_220_1.hightColor2.r, var_223_3)
								local var_223_5 = Mathf.Lerp(iter_223_1.color.g, arg_220_1.hightColor2.g, var_223_3)
								local var_223_6 = Mathf.Lerp(iter_223_1.color.b, arg_220_1.hightColor2.b, var_223_3)

								iter_223_1.color = Color.New(var_223_4, var_223_5, var_223_6)
							else
								local var_223_7 = Mathf.Lerp(iter_223_1.color.r, 0.5, var_223_3)

								iter_223_1.color = Color.New(var_223_7, var_223_7, var_223_7)
							end
						end
					end
				end
			end

			if arg_220_1.time_ >= var_223_1 + var_223_2 and arg_220_1.time_ < var_223_1 + var_223_2 + arg_223_0 and not isNil(var_223_0) and arg_220_1.var_.actorSpriteComps1034 then
				for iter_223_2, iter_223_3 in pairs(arg_220_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_223_3 then
						if arg_220_1.isInRecall_ then
							iter_223_3.color = arg_220_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_223_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_220_1.var_.actorSpriteComps1034 = nil
			end

			local var_223_8 = 0
			local var_223_9 = 0.9

			if var_223_8 < arg_220_1.time_ and arg_220_1.time_ <= var_223_8 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, false)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_10 = arg_220_1:GetWordFromCfg(417141054)
				local var_223_11 = arg_220_1:FormatText(var_223_10.content)

				arg_220_1.text_.text = var_223_11

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_12 = 36
				local var_223_13 = utf8.len(var_223_11)
				local var_223_14 = var_223_12 <= 0 and var_223_9 or var_223_9 * (var_223_13 / var_223_12)

				if var_223_14 > 0 and var_223_9 < var_223_14 then
					arg_220_1.talkMaxDuration = var_223_14

					if var_223_14 + var_223_8 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_14 + var_223_8
					end
				end

				arg_220_1.text_.text = var_223_11
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)
				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_15 = math.max(var_223_9, arg_220_1.talkMaxDuration)

			if var_223_8 <= arg_220_1.time_ and arg_220_1.time_ < var_223_8 + var_223_15 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_8) / var_223_15

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_8 + var_223_15 and arg_220_1.time_ < var_223_8 + var_223_15 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {}

		arg_220_1:InitPlayNodeList()
	end,
	Play417141055 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 417141055
		arg_224_1.duration_ = 6.07

		local var_224_0 = {
			zh = 2.8,
			ja = 6.066
		}
		local var_224_1 = manager.audio:GetLocalizationFlag()

		if var_224_0[var_224_1] ~= nil then
			arg_224_1.duration_ = var_224_0[var_224_1]
		end

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play417141056(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			local var_227_0 = arg_224_1.actors_["1034"]
			local var_227_1 = 0

			if var_227_1 < arg_224_1.time_ and arg_224_1.time_ <= var_227_1 + arg_227_0 and not isNil(var_227_0) and arg_224_1.var_.actorSpriteComps1034 == nil then
				arg_224_1.var_.actorSpriteComps1034 = var_227_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_227_2 = 0.2

			if var_227_1 <= arg_224_1.time_ and arg_224_1.time_ < var_227_1 + var_227_2 and not isNil(var_227_0) then
				local var_227_3 = (arg_224_1.time_ - var_227_1) / var_227_2

				if arg_224_1.var_.actorSpriteComps1034 then
					for iter_227_0, iter_227_1 in pairs(arg_224_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_227_1 then
							if arg_224_1.isInRecall_ then
								local var_227_4 = Mathf.Lerp(iter_227_1.color.r, arg_224_1.hightColor1.r, var_227_3)
								local var_227_5 = Mathf.Lerp(iter_227_1.color.g, arg_224_1.hightColor1.g, var_227_3)
								local var_227_6 = Mathf.Lerp(iter_227_1.color.b, arg_224_1.hightColor1.b, var_227_3)

								iter_227_1.color = Color.New(var_227_4, var_227_5, var_227_6)
							else
								local var_227_7 = Mathf.Lerp(iter_227_1.color.r, 1, var_227_3)

								iter_227_1.color = Color.New(var_227_7, var_227_7, var_227_7)
							end
						end
					end
				end
			end

			if arg_224_1.time_ >= var_227_1 + var_227_2 and arg_224_1.time_ < var_227_1 + var_227_2 + arg_227_0 and not isNil(var_227_0) and arg_224_1.var_.actorSpriteComps1034 then
				for iter_227_2, iter_227_3 in pairs(arg_224_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_227_3 then
						if arg_224_1.isInRecall_ then
							iter_227_3.color = arg_224_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_227_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_224_1.var_.actorSpriteComps1034 = nil
			end

			local var_227_8 = 0
			local var_227_9 = 0.325

			if var_227_8 < arg_224_1.time_ and arg_224_1.time_ <= var_227_8 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				local var_227_10 = arg_224_1:FormatText(StoryNameCfg[1109].name)

				arg_224_1.leftNameTxt_.text = var_227_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_11 = arg_224_1:GetWordFromCfg(417141055)
				local var_227_12 = arg_224_1:FormatText(var_227_11.content)

				arg_224_1.text_.text = var_227_12

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_13 = 13
				local var_227_14 = utf8.len(var_227_12)
				local var_227_15 = var_227_13 <= 0 and var_227_9 or var_227_9 * (var_227_14 / var_227_13)

				if var_227_15 > 0 and var_227_9 < var_227_15 then
					arg_224_1.talkMaxDuration = var_227_15

					if var_227_15 + var_227_8 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_15 + var_227_8
					end
				end

				arg_224_1.text_.text = var_227_12
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417141", "417141055", "story_v_out_417141.awb") ~= 0 then
					local var_227_16 = manager.audio:GetVoiceLength("story_v_out_417141", "417141055", "story_v_out_417141.awb") / 1000

					if var_227_16 + var_227_8 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_16 + var_227_8
					end

					if var_227_11.prefab_name ~= "" and arg_224_1.actors_[var_227_11.prefab_name] ~= nil then
						local var_227_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_11.prefab_name].transform, "story_v_out_417141", "417141055", "story_v_out_417141.awb")

						arg_224_1:RecordAudio("417141055", var_227_17)
						arg_224_1:RecordAudio("417141055", var_227_17)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_417141", "417141055", "story_v_out_417141.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_417141", "417141055", "story_v_out_417141.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_18 = math.max(var_227_9, arg_224_1.talkMaxDuration)

			if var_227_8 <= arg_224_1.time_ and arg_224_1.time_ < var_227_8 + var_227_18 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_8) / var_227_18

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_8 + var_227_18 and arg_224_1.time_ < var_227_8 + var_227_18 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play417141056 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 417141056
		arg_228_1.duration_ = 9.77

		local var_228_0 = {
			zh = 5,
			ja = 9.766
		}
		local var_228_1 = manager.audio:GetLocalizationFlag()

		if var_228_0[var_228_1] ~= nil then
			arg_228_1.duration_ = var_228_0[var_228_1]
		end

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play417141057(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = arg_228_1.actors_["10128"]
			local var_231_1 = 0

			if var_231_1 < arg_228_1.time_ and arg_228_1.time_ <= var_231_1 + arg_231_0 and not isNil(var_231_0) and arg_228_1.var_.actorSpriteComps10128 == nil then
				arg_228_1.var_.actorSpriteComps10128 = var_231_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_231_2 = 0.2

			if var_231_1 <= arg_228_1.time_ and arg_228_1.time_ < var_231_1 + var_231_2 and not isNil(var_231_0) then
				local var_231_3 = (arg_228_1.time_ - var_231_1) / var_231_2

				if arg_228_1.var_.actorSpriteComps10128 then
					for iter_231_0, iter_231_1 in pairs(arg_228_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_231_1 then
							if arg_228_1.isInRecall_ then
								local var_231_4 = Mathf.Lerp(iter_231_1.color.r, arg_228_1.hightColor1.r, var_231_3)
								local var_231_5 = Mathf.Lerp(iter_231_1.color.g, arg_228_1.hightColor1.g, var_231_3)
								local var_231_6 = Mathf.Lerp(iter_231_1.color.b, arg_228_1.hightColor1.b, var_231_3)

								iter_231_1.color = Color.New(var_231_4, var_231_5, var_231_6)
							else
								local var_231_7 = Mathf.Lerp(iter_231_1.color.r, 1, var_231_3)

								iter_231_1.color = Color.New(var_231_7, var_231_7, var_231_7)
							end
						end
					end
				end
			end

			if arg_228_1.time_ >= var_231_1 + var_231_2 and arg_228_1.time_ < var_231_1 + var_231_2 + arg_231_0 and not isNil(var_231_0) and arg_228_1.var_.actorSpriteComps10128 then
				for iter_231_2, iter_231_3 in pairs(arg_228_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_231_3 then
						if arg_228_1.isInRecall_ then
							iter_231_3.color = arg_228_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_231_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_228_1.var_.actorSpriteComps10128 = nil
			end

			local var_231_8 = arg_228_1.actors_["10128"].transform
			local var_231_9 = 0

			if var_231_9 < arg_228_1.time_ and arg_228_1.time_ <= var_231_9 + arg_231_0 then
				arg_228_1.var_.moveOldPos10128 = var_231_8.localPosition
				var_231_8.localScale = Vector3.New(1, 1, 1)

				arg_228_1:CheckSpriteTmpPos("10128", 3)

				local var_231_10 = var_231_8.childCount

				for iter_231_4 = 0, var_231_10 - 1 do
					local var_231_11 = var_231_8:GetChild(iter_231_4)

					if var_231_11.name == "split_1" or not string.find(var_231_11.name, "split") then
						var_231_11.gameObject:SetActive(true)
					else
						var_231_11.gameObject:SetActive(false)
					end
				end
			end

			local var_231_12 = 0.001

			if var_231_9 <= arg_228_1.time_ and arg_228_1.time_ < var_231_9 + var_231_12 then
				local var_231_13 = (arg_228_1.time_ - var_231_9) / var_231_12
				local var_231_14 = Vector3.New(0, -347, -300)

				var_231_8.localPosition = Vector3.Lerp(arg_228_1.var_.moveOldPos10128, var_231_14, var_231_13)
			end

			if arg_228_1.time_ >= var_231_9 + var_231_12 and arg_228_1.time_ < var_231_9 + var_231_12 + arg_231_0 then
				var_231_8.localPosition = Vector3.New(0, -347, -300)
			end

			local var_231_15 = arg_228_1.actors_["1034"].transform
			local var_231_16 = 0

			if var_231_16 < arg_228_1.time_ and arg_228_1.time_ <= var_231_16 + arg_231_0 then
				arg_228_1.var_.moveOldPos1034 = var_231_15.localPosition
				var_231_15.localScale = Vector3.New(1, 1, 1)

				arg_228_1:CheckSpriteTmpPos("1034", 7)

				local var_231_17 = var_231_15.childCount

				for iter_231_5 = 0, var_231_17 - 1 do
					local var_231_18 = var_231_15:GetChild(iter_231_5)

					if var_231_18.name == "" or not string.find(var_231_18.name, "split") then
						var_231_18.gameObject:SetActive(true)
					else
						var_231_18.gameObject:SetActive(false)
					end
				end
			end

			local var_231_19 = 0.001

			if var_231_16 <= arg_228_1.time_ and arg_228_1.time_ < var_231_16 + var_231_19 then
				local var_231_20 = (arg_228_1.time_ - var_231_16) / var_231_19
				local var_231_21 = Vector3.New(0, -2000, 0)

				var_231_15.localPosition = Vector3.Lerp(arg_228_1.var_.moveOldPos1034, var_231_21, var_231_20)
			end

			if arg_228_1.time_ >= var_231_16 + var_231_19 and arg_228_1.time_ < var_231_16 + var_231_19 + arg_231_0 then
				var_231_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_231_22 = 0
			local var_231_23 = 0.625

			if var_231_22 < arg_228_1.time_ and arg_228_1.time_ <= var_231_22 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				local var_231_24 = arg_228_1:FormatText(StoryNameCfg[595].name)

				arg_228_1.leftNameTxt_.text = var_231_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_25 = arg_228_1:GetWordFromCfg(417141056)
				local var_231_26 = arg_228_1:FormatText(var_231_25.content)

				arg_228_1.text_.text = var_231_26

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_27 = 25
				local var_231_28 = utf8.len(var_231_26)
				local var_231_29 = var_231_27 <= 0 and var_231_23 or var_231_23 * (var_231_28 / var_231_27)

				if var_231_29 > 0 and var_231_23 < var_231_29 then
					arg_228_1.talkMaxDuration = var_231_29

					if var_231_29 + var_231_22 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_29 + var_231_22
					end
				end

				arg_228_1.text_.text = var_231_26
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417141", "417141056", "story_v_out_417141.awb") ~= 0 then
					local var_231_30 = manager.audio:GetVoiceLength("story_v_out_417141", "417141056", "story_v_out_417141.awb") / 1000

					if var_231_30 + var_231_22 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_30 + var_231_22
					end

					if var_231_25.prefab_name ~= "" and arg_228_1.actors_[var_231_25.prefab_name] ~= nil then
						local var_231_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_25.prefab_name].transform, "story_v_out_417141", "417141056", "story_v_out_417141.awb")

						arg_228_1:RecordAudio("417141056", var_231_31)
						arg_228_1:RecordAudio("417141056", var_231_31)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_out_417141", "417141056", "story_v_out_417141.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_out_417141", "417141056", "story_v_out_417141.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_32 = math.max(var_231_23, arg_228_1.talkMaxDuration)

			if var_231_22 <= arg_228_1.time_ and arg_228_1.time_ < var_231_22 + var_231_32 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_22) / var_231_32

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_22 + var_231_32 and arg_228_1.time_ < var_231_22 + var_231_32 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_228_1:InitPlayNodeList()
	end,
	Play417141057 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 417141057
		arg_232_1.duration_ = 3.1

		local var_232_0 = {
			zh = 2.3,
			ja = 3.1
		}
		local var_232_1 = manager.audio:GetLocalizationFlag()

		if var_232_0[var_232_1] ~= nil then
			arg_232_1.duration_ = var_232_0[var_232_1]
		end

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play417141058(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = arg_232_1.actors_["1034"]
			local var_235_1 = 0

			if var_235_1 < arg_232_1.time_ and arg_232_1.time_ <= var_235_1 + arg_235_0 and not isNil(var_235_0) and arg_232_1.var_.actorSpriteComps1034 == nil then
				arg_232_1.var_.actorSpriteComps1034 = var_235_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_235_2 = 0.2

			if var_235_1 <= arg_232_1.time_ and arg_232_1.time_ < var_235_1 + var_235_2 and not isNil(var_235_0) then
				local var_235_3 = (arg_232_1.time_ - var_235_1) / var_235_2

				if arg_232_1.var_.actorSpriteComps1034 then
					for iter_235_0, iter_235_1 in pairs(arg_232_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_235_1 then
							if arg_232_1.isInRecall_ then
								local var_235_4 = Mathf.Lerp(iter_235_1.color.r, arg_232_1.hightColor1.r, var_235_3)
								local var_235_5 = Mathf.Lerp(iter_235_1.color.g, arg_232_1.hightColor1.g, var_235_3)
								local var_235_6 = Mathf.Lerp(iter_235_1.color.b, arg_232_1.hightColor1.b, var_235_3)

								iter_235_1.color = Color.New(var_235_4, var_235_5, var_235_6)
							else
								local var_235_7 = Mathf.Lerp(iter_235_1.color.r, 1, var_235_3)

								iter_235_1.color = Color.New(var_235_7, var_235_7, var_235_7)
							end
						end
					end
				end
			end

			if arg_232_1.time_ >= var_235_1 + var_235_2 and arg_232_1.time_ < var_235_1 + var_235_2 + arg_235_0 and not isNil(var_235_0) and arg_232_1.var_.actorSpriteComps1034 then
				for iter_235_2, iter_235_3 in pairs(arg_232_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_235_3 then
						if arg_232_1.isInRecall_ then
							iter_235_3.color = arg_232_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_235_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_232_1.var_.actorSpriteComps1034 = nil
			end

			local var_235_8 = arg_232_1.actors_["10128"]
			local var_235_9 = 0

			if var_235_9 < arg_232_1.time_ and arg_232_1.time_ <= var_235_9 + arg_235_0 and not isNil(var_235_8) and arg_232_1.var_.actorSpriteComps10128 == nil then
				arg_232_1.var_.actorSpriteComps10128 = var_235_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_235_10 = 0.2

			if var_235_9 <= arg_232_1.time_ and arg_232_1.time_ < var_235_9 + var_235_10 and not isNil(var_235_8) then
				local var_235_11 = (arg_232_1.time_ - var_235_9) / var_235_10

				if arg_232_1.var_.actorSpriteComps10128 then
					for iter_235_4, iter_235_5 in pairs(arg_232_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_235_5 then
							if arg_232_1.isInRecall_ then
								local var_235_12 = Mathf.Lerp(iter_235_5.color.r, arg_232_1.hightColor2.r, var_235_11)
								local var_235_13 = Mathf.Lerp(iter_235_5.color.g, arg_232_1.hightColor2.g, var_235_11)
								local var_235_14 = Mathf.Lerp(iter_235_5.color.b, arg_232_1.hightColor2.b, var_235_11)

								iter_235_5.color = Color.New(var_235_12, var_235_13, var_235_14)
							else
								local var_235_15 = Mathf.Lerp(iter_235_5.color.r, 0.5, var_235_11)

								iter_235_5.color = Color.New(var_235_15, var_235_15, var_235_15)
							end
						end
					end
				end
			end

			if arg_232_1.time_ >= var_235_9 + var_235_10 and arg_232_1.time_ < var_235_9 + var_235_10 + arg_235_0 and not isNil(var_235_8) and arg_232_1.var_.actorSpriteComps10128 then
				for iter_235_6, iter_235_7 in pairs(arg_232_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_235_7 then
						if arg_232_1.isInRecall_ then
							iter_235_7.color = arg_232_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_235_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_232_1.var_.actorSpriteComps10128 = nil
			end

			local var_235_16 = arg_232_1.actors_["10128"].transform
			local var_235_17 = 0

			if var_235_17 < arg_232_1.time_ and arg_232_1.time_ <= var_235_17 + arg_235_0 then
				arg_232_1.var_.moveOldPos10128 = var_235_16.localPosition
				var_235_16.localScale = Vector3.New(1, 1, 1)

				arg_232_1:CheckSpriteTmpPos("10128", 2)

				local var_235_18 = var_235_16.childCount

				for iter_235_8 = 0, var_235_18 - 1 do
					local var_235_19 = var_235_16:GetChild(iter_235_8)

					if var_235_19.name == "" or not string.find(var_235_19.name, "split") then
						var_235_19.gameObject:SetActive(true)
					else
						var_235_19.gameObject:SetActive(false)
					end
				end
			end

			local var_235_20 = 0.001

			if var_235_17 <= arg_232_1.time_ and arg_232_1.time_ < var_235_17 + var_235_20 then
				local var_235_21 = (arg_232_1.time_ - var_235_17) / var_235_20
				local var_235_22 = Vector3.New(-390, -347, -300)

				var_235_16.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos10128, var_235_22, var_235_21)
			end

			if arg_232_1.time_ >= var_235_17 + var_235_20 and arg_232_1.time_ < var_235_17 + var_235_20 + arg_235_0 then
				var_235_16.localPosition = Vector3.New(-390, -347, -300)
			end

			local var_235_23 = arg_232_1.actors_["1034"].transform
			local var_235_24 = 0

			if var_235_24 < arg_232_1.time_ and arg_232_1.time_ <= var_235_24 + arg_235_0 then
				arg_232_1.var_.moveOldPos1034 = var_235_23.localPosition
				var_235_23.localScale = Vector3.New(1, 1, 1)

				arg_232_1:CheckSpriteTmpPos("1034", 4)

				local var_235_25 = var_235_23.childCount

				for iter_235_9 = 0, var_235_25 - 1 do
					local var_235_26 = var_235_23:GetChild(iter_235_9)

					if var_235_26.name == "split_6" or not string.find(var_235_26.name, "split") then
						var_235_26.gameObject:SetActive(true)
					else
						var_235_26.gameObject:SetActive(false)
					end
				end
			end

			local var_235_27 = 0.001

			if var_235_24 <= arg_232_1.time_ and arg_232_1.time_ < var_235_24 + var_235_27 then
				local var_235_28 = (arg_232_1.time_ - var_235_24) / var_235_27
				local var_235_29 = Vector3.New(373.7, -331.9, -324)

				var_235_23.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos1034, var_235_29, var_235_28)
			end

			if arg_232_1.time_ >= var_235_24 + var_235_27 and arg_232_1.time_ < var_235_24 + var_235_27 + arg_235_0 then
				var_235_23.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_235_30 = 0
			local var_235_31 = 0.275

			if var_235_30 < arg_232_1.time_ and arg_232_1.time_ <= var_235_30 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				local var_235_32 = arg_232_1:FormatText(StoryNameCfg[1109].name)

				arg_232_1.leftNameTxt_.text = var_235_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_33 = arg_232_1:GetWordFromCfg(417141057)
				local var_235_34 = arg_232_1:FormatText(var_235_33.content)

				arg_232_1.text_.text = var_235_34

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_35 = 11
				local var_235_36 = utf8.len(var_235_34)
				local var_235_37 = var_235_35 <= 0 and var_235_31 or var_235_31 * (var_235_36 / var_235_35)

				if var_235_37 > 0 and var_235_31 < var_235_37 then
					arg_232_1.talkMaxDuration = var_235_37

					if var_235_37 + var_235_30 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_37 + var_235_30
					end
				end

				arg_232_1.text_.text = var_235_34
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417141", "417141057", "story_v_out_417141.awb") ~= 0 then
					local var_235_38 = manager.audio:GetVoiceLength("story_v_out_417141", "417141057", "story_v_out_417141.awb") / 1000

					if var_235_38 + var_235_30 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_38 + var_235_30
					end

					if var_235_33.prefab_name ~= "" and arg_232_1.actors_[var_235_33.prefab_name] ~= nil then
						local var_235_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_33.prefab_name].transform, "story_v_out_417141", "417141057", "story_v_out_417141.awb")

						arg_232_1:RecordAudio("417141057", var_235_39)
						arg_232_1:RecordAudio("417141057", var_235_39)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_out_417141", "417141057", "story_v_out_417141.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_out_417141", "417141057", "story_v_out_417141.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_40 = math.max(var_235_31, arg_232_1.talkMaxDuration)

			if var_235_30 <= arg_232_1.time_ and arg_232_1.time_ < var_235_30 + var_235_40 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_30) / var_235_40

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_30 + var_235_40 and arg_232_1.time_ < var_235_30 + var_235_40 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_232_1:InitPlayNodeList()
	end,
	Play417141058 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 417141058
		arg_236_1.duration_ = 9.4

		local var_236_0 = {
			zh = 4.033,
			ja = 9.4
		}
		local var_236_1 = manager.audio:GetLocalizationFlag()

		if var_236_0[var_236_1] ~= nil then
			arg_236_1.duration_ = var_236_0[var_236_1]
		end

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play417141059(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = arg_236_1.actors_["10128"]
			local var_239_1 = 0

			if var_239_1 < arg_236_1.time_ and arg_236_1.time_ <= var_239_1 + arg_239_0 and not isNil(var_239_0) and arg_236_1.var_.actorSpriteComps10128 == nil then
				arg_236_1.var_.actorSpriteComps10128 = var_239_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_239_2 = 0.2

			if var_239_1 <= arg_236_1.time_ and arg_236_1.time_ < var_239_1 + var_239_2 and not isNil(var_239_0) then
				local var_239_3 = (arg_236_1.time_ - var_239_1) / var_239_2

				if arg_236_1.var_.actorSpriteComps10128 then
					for iter_239_0, iter_239_1 in pairs(arg_236_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_239_1 then
							if arg_236_1.isInRecall_ then
								local var_239_4 = Mathf.Lerp(iter_239_1.color.r, arg_236_1.hightColor1.r, var_239_3)
								local var_239_5 = Mathf.Lerp(iter_239_1.color.g, arg_236_1.hightColor1.g, var_239_3)
								local var_239_6 = Mathf.Lerp(iter_239_1.color.b, arg_236_1.hightColor1.b, var_239_3)

								iter_239_1.color = Color.New(var_239_4, var_239_5, var_239_6)
							else
								local var_239_7 = Mathf.Lerp(iter_239_1.color.r, 1, var_239_3)

								iter_239_1.color = Color.New(var_239_7, var_239_7, var_239_7)
							end
						end
					end
				end
			end

			if arg_236_1.time_ >= var_239_1 + var_239_2 and arg_236_1.time_ < var_239_1 + var_239_2 + arg_239_0 and not isNil(var_239_0) and arg_236_1.var_.actorSpriteComps10128 then
				for iter_239_2, iter_239_3 in pairs(arg_236_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_239_3 then
						if arg_236_1.isInRecall_ then
							iter_239_3.color = arg_236_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_239_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_236_1.var_.actorSpriteComps10128 = nil
			end

			local var_239_8 = arg_236_1.actors_["1034"]
			local var_239_9 = 0

			if var_239_9 < arg_236_1.time_ and arg_236_1.time_ <= var_239_9 + arg_239_0 and not isNil(var_239_8) and arg_236_1.var_.actorSpriteComps1034 == nil then
				arg_236_1.var_.actorSpriteComps1034 = var_239_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_239_10 = 0.2

			if var_239_9 <= arg_236_1.time_ and arg_236_1.time_ < var_239_9 + var_239_10 and not isNil(var_239_8) then
				local var_239_11 = (arg_236_1.time_ - var_239_9) / var_239_10

				if arg_236_1.var_.actorSpriteComps1034 then
					for iter_239_4, iter_239_5 in pairs(arg_236_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_239_5 then
							if arg_236_1.isInRecall_ then
								local var_239_12 = Mathf.Lerp(iter_239_5.color.r, arg_236_1.hightColor2.r, var_239_11)
								local var_239_13 = Mathf.Lerp(iter_239_5.color.g, arg_236_1.hightColor2.g, var_239_11)
								local var_239_14 = Mathf.Lerp(iter_239_5.color.b, arg_236_1.hightColor2.b, var_239_11)

								iter_239_5.color = Color.New(var_239_12, var_239_13, var_239_14)
							else
								local var_239_15 = Mathf.Lerp(iter_239_5.color.r, 0.5, var_239_11)

								iter_239_5.color = Color.New(var_239_15, var_239_15, var_239_15)
							end
						end
					end
				end
			end

			if arg_236_1.time_ >= var_239_9 + var_239_10 and arg_236_1.time_ < var_239_9 + var_239_10 + arg_239_0 and not isNil(var_239_8) and arg_236_1.var_.actorSpriteComps1034 then
				for iter_239_6, iter_239_7 in pairs(arg_236_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_239_7 then
						if arg_236_1.isInRecall_ then
							iter_239_7.color = arg_236_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_239_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_236_1.var_.actorSpriteComps1034 = nil
			end

			local var_239_16 = arg_236_1.actors_["1034"].transform
			local var_239_17 = 0

			if var_239_17 < arg_236_1.time_ and arg_236_1.time_ <= var_239_17 + arg_239_0 then
				arg_236_1.var_.moveOldPos1034 = var_239_16.localPosition
				var_239_16.localScale = Vector3.New(1, 1, 1)

				arg_236_1:CheckSpriteTmpPos("1034", 4)

				local var_239_18 = var_239_16.childCount

				for iter_239_8 = 0, var_239_18 - 1 do
					local var_239_19 = var_239_16:GetChild(iter_239_8)

					if var_239_19.name == "split_6" or not string.find(var_239_19.name, "split") then
						var_239_19.gameObject:SetActive(true)
					else
						var_239_19.gameObject:SetActive(false)
					end
				end
			end

			local var_239_20 = 0.001

			if var_239_17 <= arg_236_1.time_ and arg_236_1.time_ < var_239_17 + var_239_20 then
				local var_239_21 = (arg_236_1.time_ - var_239_17) / var_239_20
				local var_239_22 = Vector3.New(373.7, -331.9, -324)

				var_239_16.localPosition = Vector3.Lerp(arg_236_1.var_.moveOldPos1034, var_239_22, var_239_21)
			end

			if arg_236_1.time_ >= var_239_17 + var_239_20 and arg_236_1.time_ < var_239_17 + var_239_20 + arg_239_0 then
				var_239_16.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_239_23 = arg_236_1.actors_["10128"].transform
			local var_239_24 = 0

			if var_239_24 < arg_236_1.time_ and arg_236_1.time_ <= var_239_24 + arg_239_0 then
				arg_236_1.var_.moveOldPos10128 = var_239_23.localPosition
				var_239_23.localScale = Vector3.New(1, 1, 1)

				arg_236_1:CheckSpriteTmpPos("10128", 2)

				local var_239_25 = var_239_23.childCount

				for iter_239_9 = 0, var_239_25 - 1 do
					local var_239_26 = var_239_23:GetChild(iter_239_9)

					if var_239_26.name == "split_6" or not string.find(var_239_26.name, "split") then
						var_239_26.gameObject:SetActive(true)
					else
						var_239_26.gameObject:SetActive(false)
					end
				end
			end

			local var_239_27 = 0.001

			if var_239_24 <= arg_236_1.time_ and arg_236_1.time_ < var_239_24 + var_239_27 then
				local var_239_28 = (arg_236_1.time_ - var_239_24) / var_239_27
				local var_239_29 = Vector3.New(-390, -347, -300)

				var_239_23.localPosition = Vector3.Lerp(arg_236_1.var_.moveOldPos10128, var_239_29, var_239_28)
			end

			if arg_236_1.time_ >= var_239_24 + var_239_27 and arg_236_1.time_ < var_239_24 + var_239_27 + arg_239_0 then
				var_239_23.localPosition = Vector3.New(-390, -347, -300)
			end

			local var_239_30 = 0
			local var_239_31 = 0.525

			if var_239_30 < arg_236_1.time_ and arg_236_1.time_ <= var_239_30 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				local var_239_32 = arg_236_1:FormatText(StoryNameCfg[595].name)

				arg_236_1.leftNameTxt_.text = var_239_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_33 = arg_236_1:GetWordFromCfg(417141058)
				local var_239_34 = arg_236_1:FormatText(var_239_33.content)

				arg_236_1.text_.text = var_239_34

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_35 = 21
				local var_239_36 = utf8.len(var_239_34)
				local var_239_37 = var_239_35 <= 0 and var_239_31 or var_239_31 * (var_239_36 / var_239_35)

				if var_239_37 > 0 and var_239_31 < var_239_37 then
					arg_236_1.talkMaxDuration = var_239_37

					if var_239_37 + var_239_30 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_37 + var_239_30
					end
				end

				arg_236_1.text_.text = var_239_34
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417141", "417141058", "story_v_out_417141.awb") ~= 0 then
					local var_239_38 = manager.audio:GetVoiceLength("story_v_out_417141", "417141058", "story_v_out_417141.awb") / 1000

					if var_239_38 + var_239_30 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_38 + var_239_30
					end

					if var_239_33.prefab_name ~= "" and arg_236_1.actors_[var_239_33.prefab_name] ~= nil then
						local var_239_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_33.prefab_name].transform, "story_v_out_417141", "417141058", "story_v_out_417141.awb")

						arg_236_1:RecordAudio("417141058", var_239_39)
						arg_236_1:RecordAudio("417141058", var_239_39)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_out_417141", "417141058", "story_v_out_417141.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_out_417141", "417141058", "story_v_out_417141.awb")
				end

				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_40 = math.max(var_239_31, arg_236_1.talkMaxDuration)

			if var_239_30 <= arg_236_1.time_ and arg_236_1.time_ < var_239_30 + var_239_40 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_30) / var_239_40

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_30 + var_239_40 and arg_236_1.time_ < var_239_30 + var_239_40 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_236_1:InitPlayNodeList()
	end,
	Play417141059 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 417141059
		arg_240_1.duration_ = 8.07

		local var_240_0 = {
			zh = 6.366,
			ja = 8.066
		}
		local var_240_1 = manager.audio:GetLocalizationFlag()

		if var_240_0[var_240_1] ~= nil then
			arg_240_1.duration_ = var_240_0[var_240_1]
		end

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play417141060(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = arg_240_1.actors_["1034"]
			local var_243_1 = 0

			if var_243_1 < arg_240_1.time_ and arg_240_1.time_ <= var_243_1 + arg_243_0 and not isNil(var_243_0) and arg_240_1.var_.actorSpriteComps1034 == nil then
				arg_240_1.var_.actorSpriteComps1034 = var_243_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_243_2 = 0.2

			if var_243_1 <= arg_240_1.time_ and arg_240_1.time_ < var_243_1 + var_243_2 and not isNil(var_243_0) then
				local var_243_3 = (arg_240_1.time_ - var_243_1) / var_243_2

				if arg_240_1.var_.actorSpriteComps1034 then
					for iter_243_0, iter_243_1 in pairs(arg_240_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_243_1 then
							if arg_240_1.isInRecall_ then
								local var_243_4 = Mathf.Lerp(iter_243_1.color.r, arg_240_1.hightColor1.r, var_243_3)
								local var_243_5 = Mathf.Lerp(iter_243_1.color.g, arg_240_1.hightColor1.g, var_243_3)
								local var_243_6 = Mathf.Lerp(iter_243_1.color.b, arg_240_1.hightColor1.b, var_243_3)

								iter_243_1.color = Color.New(var_243_4, var_243_5, var_243_6)
							else
								local var_243_7 = Mathf.Lerp(iter_243_1.color.r, 1, var_243_3)

								iter_243_1.color = Color.New(var_243_7, var_243_7, var_243_7)
							end
						end
					end
				end
			end

			if arg_240_1.time_ >= var_243_1 + var_243_2 and arg_240_1.time_ < var_243_1 + var_243_2 + arg_243_0 and not isNil(var_243_0) and arg_240_1.var_.actorSpriteComps1034 then
				for iter_243_2, iter_243_3 in pairs(arg_240_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_243_3 then
						if arg_240_1.isInRecall_ then
							iter_243_3.color = arg_240_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_243_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_240_1.var_.actorSpriteComps1034 = nil
			end

			local var_243_8 = arg_240_1.actors_["10128"]
			local var_243_9 = 0

			if var_243_9 < arg_240_1.time_ and arg_240_1.time_ <= var_243_9 + arg_243_0 and not isNil(var_243_8) and arg_240_1.var_.actorSpriteComps10128 == nil then
				arg_240_1.var_.actorSpriteComps10128 = var_243_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_243_10 = 0.2

			if var_243_9 <= arg_240_1.time_ and arg_240_1.time_ < var_243_9 + var_243_10 and not isNil(var_243_8) then
				local var_243_11 = (arg_240_1.time_ - var_243_9) / var_243_10

				if arg_240_1.var_.actorSpriteComps10128 then
					for iter_243_4, iter_243_5 in pairs(arg_240_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_243_5 then
							if arg_240_1.isInRecall_ then
								local var_243_12 = Mathf.Lerp(iter_243_5.color.r, arg_240_1.hightColor2.r, var_243_11)
								local var_243_13 = Mathf.Lerp(iter_243_5.color.g, arg_240_1.hightColor2.g, var_243_11)
								local var_243_14 = Mathf.Lerp(iter_243_5.color.b, arg_240_1.hightColor2.b, var_243_11)

								iter_243_5.color = Color.New(var_243_12, var_243_13, var_243_14)
							else
								local var_243_15 = Mathf.Lerp(iter_243_5.color.r, 0.5, var_243_11)

								iter_243_5.color = Color.New(var_243_15, var_243_15, var_243_15)
							end
						end
					end
				end
			end

			if arg_240_1.time_ >= var_243_9 + var_243_10 and arg_240_1.time_ < var_243_9 + var_243_10 + arg_243_0 and not isNil(var_243_8) and arg_240_1.var_.actorSpriteComps10128 then
				for iter_243_6, iter_243_7 in pairs(arg_240_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_243_7 then
						if arg_240_1.isInRecall_ then
							iter_243_7.color = arg_240_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_243_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_240_1.var_.actorSpriteComps10128 = nil
			end

			local var_243_16 = 0
			local var_243_17 = 0.775

			if var_243_16 < arg_240_1.time_ and arg_240_1.time_ <= var_243_16 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				local var_243_18 = arg_240_1:FormatText(StoryNameCfg[1109].name)

				arg_240_1.leftNameTxt_.text = var_243_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_19 = arg_240_1:GetWordFromCfg(417141059)
				local var_243_20 = arg_240_1:FormatText(var_243_19.content)

				arg_240_1.text_.text = var_243_20

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_21 = 31
				local var_243_22 = utf8.len(var_243_20)
				local var_243_23 = var_243_21 <= 0 and var_243_17 or var_243_17 * (var_243_22 / var_243_21)

				if var_243_23 > 0 and var_243_17 < var_243_23 then
					arg_240_1.talkMaxDuration = var_243_23

					if var_243_23 + var_243_16 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_23 + var_243_16
					end
				end

				arg_240_1.text_.text = var_243_20
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417141", "417141059", "story_v_out_417141.awb") ~= 0 then
					local var_243_24 = manager.audio:GetVoiceLength("story_v_out_417141", "417141059", "story_v_out_417141.awb") / 1000

					if var_243_24 + var_243_16 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_24 + var_243_16
					end

					if var_243_19.prefab_name ~= "" and arg_240_1.actors_[var_243_19.prefab_name] ~= nil then
						local var_243_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_19.prefab_name].transform, "story_v_out_417141", "417141059", "story_v_out_417141.awb")

						arg_240_1:RecordAudio("417141059", var_243_25)
						arg_240_1:RecordAudio("417141059", var_243_25)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_417141", "417141059", "story_v_out_417141.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_417141", "417141059", "story_v_out_417141.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_26 = math.max(var_243_17, arg_240_1.talkMaxDuration)

			if var_243_16 <= arg_240_1.time_ and arg_240_1.time_ < var_243_16 + var_243_26 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_16) / var_243_26

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_16 + var_243_26 and arg_240_1.time_ < var_243_16 + var_243_26 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play417141060 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 417141060
		arg_244_1.duration_ = 12.77

		local var_244_0 = {
			zh = 8.1,
			ja = 12.766
		}
		local var_244_1 = manager.audio:GetLocalizationFlag()

		if var_244_0[var_244_1] ~= nil then
			arg_244_1.duration_ = var_244_0[var_244_1]
		end

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play417141061(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = arg_244_1.actors_["10128"]
			local var_247_1 = 0

			if var_247_1 < arg_244_1.time_ and arg_244_1.time_ <= var_247_1 + arg_247_0 and not isNil(var_247_0) and arg_244_1.var_.actorSpriteComps10128 == nil then
				arg_244_1.var_.actorSpriteComps10128 = var_247_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_247_2 = 0.2

			if var_247_1 <= arg_244_1.time_ and arg_244_1.time_ < var_247_1 + var_247_2 and not isNil(var_247_0) then
				local var_247_3 = (arg_244_1.time_ - var_247_1) / var_247_2

				if arg_244_1.var_.actorSpriteComps10128 then
					for iter_247_0, iter_247_1 in pairs(arg_244_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_247_1 then
							if arg_244_1.isInRecall_ then
								local var_247_4 = Mathf.Lerp(iter_247_1.color.r, arg_244_1.hightColor1.r, var_247_3)
								local var_247_5 = Mathf.Lerp(iter_247_1.color.g, arg_244_1.hightColor1.g, var_247_3)
								local var_247_6 = Mathf.Lerp(iter_247_1.color.b, arg_244_1.hightColor1.b, var_247_3)

								iter_247_1.color = Color.New(var_247_4, var_247_5, var_247_6)
							else
								local var_247_7 = Mathf.Lerp(iter_247_1.color.r, 1, var_247_3)

								iter_247_1.color = Color.New(var_247_7, var_247_7, var_247_7)
							end
						end
					end
				end
			end

			if arg_244_1.time_ >= var_247_1 + var_247_2 and arg_244_1.time_ < var_247_1 + var_247_2 + arg_247_0 and not isNil(var_247_0) and arg_244_1.var_.actorSpriteComps10128 then
				for iter_247_2, iter_247_3 in pairs(arg_244_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_247_3 then
						if arg_244_1.isInRecall_ then
							iter_247_3.color = arg_244_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_247_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_244_1.var_.actorSpriteComps10128 = nil
			end

			local var_247_8 = arg_244_1.actors_["1034"]
			local var_247_9 = 0

			if var_247_9 < arg_244_1.time_ and arg_244_1.time_ <= var_247_9 + arg_247_0 and not isNil(var_247_8) and arg_244_1.var_.actorSpriteComps1034 == nil then
				arg_244_1.var_.actorSpriteComps1034 = var_247_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_247_10 = 0.2

			if var_247_9 <= arg_244_1.time_ and arg_244_1.time_ < var_247_9 + var_247_10 and not isNil(var_247_8) then
				local var_247_11 = (arg_244_1.time_ - var_247_9) / var_247_10

				if arg_244_1.var_.actorSpriteComps1034 then
					for iter_247_4, iter_247_5 in pairs(arg_244_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_247_5 then
							if arg_244_1.isInRecall_ then
								local var_247_12 = Mathf.Lerp(iter_247_5.color.r, arg_244_1.hightColor2.r, var_247_11)
								local var_247_13 = Mathf.Lerp(iter_247_5.color.g, arg_244_1.hightColor2.g, var_247_11)
								local var_247_14 = Mathf.Lerp(iter_247_5.color.b, arg_244_1.hightColor2.b, var_247_11)

								iter_247_5.color = Color.New(var_247_12, var_247_13, var_247_14)
							else
								local var_247_15 = Mathf.Lerp(iter_247_5.color.r, 0.5, var_247_11)

								iter_247_5.color = Color.New(var_247_15, var_247_15, var_247_15)
							end
						end
					end
				end
			end

			if arg_244_1.time_ >= var_247_9 + var_247_10 and arg_244_1.time_ < var_247_9 + var_247_10 + arg_247_0 and not isNil(var_247_8) and arg_244_1.var_.actorSpriteComps1034 then
				for iter_247_6, iter_247_7 in pairs(arg_244_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_247_7 then
						if arg_244_1.isInRecall_ then
							iter_247_7.color = arg_244_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_247_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_244_1.var_.actorSpriteComps1034 = nil
			end

			local var_247_16 = arg_244_1.actors_["10128"].transform
			local var_247_17 = 0

			if var_247_17 < arg_244_1.time_ and arg_244_1.time_ <= var_247_17 + arg_247_0 then
				arg_244_1.var_.moveOldPos10128 = var_247_16.localPosition
				var_247_16.localScale = Vector3.New(1, 1, 1)

				arg_244_1:CheckSpriteTmpPos("10128", 2)

				local var_247_18 = var_247_16.childCount

				for iter_247_8 = 0, var_247_18 - 1 do
					local var_247_19 = var_247_16:GetChild(iter_247_8)

					if var_247_19.name == "" or not string.find(var_247_19.name, "split") then
						var_247_19.gameObject:SetActive(true)
					else
						var_247_19.gameObject:SetActive(false)
					end
				end
			end

			local var_247_20 = 0.001

			if var_247_17 <= arg_244_1.time_ and arg_244_1.time_ < var_247_17 + var_247_20 then
				local var_247_21 = (arg_244_1.time_ - var_247_17) / var_247_20
				local var_247_22 = Vector3.New(-390, -347, -300)

				var_247_16.localPosition = Vector3.Lerp(arg_244_1.var_.moveOldPos10128, var_247_22, var_247_21)
			end

			if arg_244_1.time_ >= var_247_17 + var_247_20 and arg_244_1.time_ < var_247_17 + var_247_20 + arg_247_0 then
				var_247_16.localPosition = Vector3.New(-390, -347, -300)
			end

			local var_247_23 = 0
			local var_247_24 = 1.1

			if var_247_23 < arg_244_1.time_ and arg_244_1.time_ <= var_247_23 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				local var_247_25 = arg_244_1:FormatText(StoryNameCfg[595].name)

				arg_244_1.leftNameTxt_.text = var_247_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_26 = arg_244_1:GetWordFromCfg(417141060)
				local var_247_27 = arg_244_1:FormatText(var_247_26.content)

				arg_244_1.text_.text = var_247_27

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_28 = 44
				local var_247_29 = utf8.len(var_247_27)
				local var_247_30 = var_247_28 <= 0 and var_247_24 or var_247_24 * (var_247_29 / var_247_28)

				if var_247_30 > 0 and var_247_24 < var_247_30 then
					arg_244_1.talkMaxDuration = var_247_30

					if var_247_30 + var_247_23 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_30 + var_247_23
					end
				end

				arg_244_1.text_.text = var_247_27
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417141", "417141060", "story_v_out_417141.awb") ~= 0 then
					local var_247_31 = manager.audio:GetVoiceLength("story_v_out_417141", "417141060", "story_v_out_417141.awb") / 1000

					if var_247_31 + var_247_23 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_31 + var_247_23
					end

					if var_247_26.prefab_name ~= "" and arg_244_1.actors_[var_247_26.prefab_name] ~= nil then
						local var_247_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_26.prefab_name].transform, "story_v_out_417141", "417141060", "story_v_out_417141.awb")

						arg_244_1:RecordAudio("417141060", var_247_32)
						arg_244_1:RecordAudio("417141060", var_247_32)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_417141", "417141060", "story_v_out_417141.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_417141", "417141060", "story_v_out_417141.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_33 = math.max(var_247_24, arg_244_1.talkMaxDuration)

			if var_247_23 <= arg_244_1.time_ and arg_244_1.time_ < var_247_23 + var_247_33 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_23) / var_247_33

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_23 + var_247_33 and arg_244_1.time_ < var_247_23 + var_247_33 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_244_1:InitPlayNodeList()
	end,
	Play417141061 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 417141061
		arg_248_1.duration_ = 11.13

		local var_248_0 = {
			zh = 6.3,
			ja = 11.133
		}
		local var_248_1 = manager.audio:GetLocalizationFlag()

		if var_248_0[var_248_1] ~= nil then
			arg_248_1.duration_ = var_248_0[var_248_1]
		end

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play417141062(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = 0
			local var_251_1 = 0.85

			if var_251_0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_0 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				local var_251_2 = arg_248_1:FormatText(StoryNameCfg[595].name)

				arg_248_1.leftNameTxt_.text = var_251_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_3 = arg_248_1:GetWordFromCfg(417141061)
				local var_251_4 = arg_248_1:FormatText(var_251_3.content)

				arg_248_1.text_.text = var_251_4

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_5 = 34
				local var_251_6 = utf8.len(var_251_4)
				local var_251_7 = var_251_5 <= 0 and var_251_1 or var_251_1 * (var_251_6 / var_251_5)

				if var_251_7 > 0 and var_251_1 < var_251_7 then
					arg_248_1.talkMaxDuration = var_251_7

					if var_251_7 + var_251_0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_7 + var_251_0
					end
				end

				arg_248_1.text_.text = var_251_4
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417141", "417141061", "story_v_out_417141.awb") ~= 0 then
					local var_251_8 = manager.audio:GetVoiceLength("story_v_out_417141", "417141061", "story_v_out_417141.awb") / 1000

					if var_251_8 + var_251_0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_8 + var_251_0
					end

					if var_251_3.prefab_name ~= "" and arg_248_1.actors_[var_251_3.prefab_name] ~= nil then
						local var_251_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_3.prefab_name].transform, "story_v_out_417141", "417141061", "story_v_out_417141.awb")

						arg_248_1:RecordAudio("417141061", var_251_9)
						arg_248_1:RecordAudio("417141061", var_251_9)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_out_417141", "417141061", "story_v_out_417141.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_out_417141", "417141061", "story_v_out_417141.awb")
				end

				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_10 = math.max(var_251_1, arg_248_1.talkMaxDuration)

			if var_251_0 <= arg_248_1.time_ and arg_248_1.time_ < var_251_0 + var_251_10 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_0) / var_251_10

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_0 + var_251_10 and arg_248_1.time_ < var_251_0 + var_251_10 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play417141062 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 417141062
		arg_252_1.duration_ = 4

		local var_252_0 = {
			zh = 2.4,
			ja = 4
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
				arg_252_0:Play417141063(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = arg_252_1.actors_["1034"]
			local var_255_1 = 0

			if var_255_1 < arg_252_1.time_ and arg_252_1.time_ <= var_255_1 + arg_255_0 and not isNil(var_255_0) and arg_252_1.var_.actorSpriteComps1034 == nil then
				arg_252_1.var_.actorSpriteComps1034 = var_255_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_255_2 = 0.2

			if var_255_1 <= arg_252_1.time_ and arg_252_1.time_ < var_255_1 + var_255_2 and not isNil(var_255_0) then
				local var_255_3 = (arg_252_1.time_ - var_255_1) / var_255_2

				if arg_252_1.var_.actorSpriteComps1034 then
					for iter_255_0, iter_255_1 in pairs(arg_252_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_255_1 then
							if arg_252_1.isInRecall_ then
								local var_255_4 = Mathf.Lerp(iter_255_1.color.r, arg_252_1.hightColor1.r, var_255_3)
								local var_255_5 = Mathf.Lerp(iter_255_1.color.g, arg_252_1.hightColor1.g, var_255_3)
								local var_255_6 = Mathf.Lerp(iter_255_1.color.b, arg_252_1.hightColor1.b, var_255_3)

								iter_255_1.color = Color.New(var_255_4, var_255_5, var_255_6)
							else
								local var_255_7 = Mathf.Lerp(iter_255_1.color.r, 1, var_255_3)

								iter_255_1.color = Color.New(var_255_7, var_255_7, var_255_7)
							end
						end
					end
				end
			end

			if arg_252_1.time_ >= var_255_1 + var_255_2 and arg_252_1.time_ < var_255_1 + var_255_2 + arg_255_0 and not isNil(var_255_0) and arg_252_1.var_.actorSpriteComps1034 then
				for iter_255_2, iter_255_3 in pairs(arg_252_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_255_3 then
						if arg_252_1.isInRecall_ then
							iter_255_3.color = arg_252_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_255_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_252_1.var_.actorSpriteComps1034 = nil
			end

			local var_255_8 = arg_252_1.actors_["10128"]
			local var_255_9 = 0

			if var_255_9 < arg_252_1.time_ and arg_252_1.time_ <= var_255_9 + arg_255_0 and not isNil(var_255_8) and arg_252_1.var_.actorSpriteComps10128 == nil then
				arg_252_1.var_.actorSpriteComps10128 = var_255_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_255_10 = 0.2

			if var_255_9 <= arg_252_1.time_ and arg_252_1.time_ < var_255_9 + var_255_10 and not isNil(var_255_8) then
				local var_255_11 = (arg_252_1.time_ - var_255_9) / var_255_10

				if arg_252_1.var_.actorSpriteComps10128 then
					for iter_255_4, iter_255_5 in pairs(arg_252_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_255_5 then
							if arg_252_1.isInRecall_ then
								local var_255_12 = Mathf.Lerp(iter_255_5.color.r, arg_252_1.hightColor2.r, var_255_11)
								local var_255_13 = Mathf.Lerp(iter_255_5.color.g, arg_252_1.hightColor2.g, var_255_11)
								local var_255_14 = Mathf.Lerp(iter_255_5.color.b, arg_252_1.hightColor2.b, var_255_11)

								iter_255_5.color = Color.New(var_255_12, var_255_13, var_255_14)
							else
								local var_255_15 = Mathf.Lerp(iter_255_5.color.r, 0.5, var_255_11)

								iter_255_5.color = Color.New(var_255_15, var_255_15, var_255_15)
							end
						end
					end
				end
			end

			if arg_252_1.time_ >= var_255_9 + var_255_10 and arg_252_1.time_ < var_255_9 + var_255_10 + arg_255_0 and not isNil(var_255_8) and arg_252_1.var_.actorSpriteComps10128 then
				for iter_255_6, iter_255_7 in pairs(arg_252_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_255_7 then
						if arg_252_1.isInRecall_ then
							iter_255_7.color = arg_252_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_255_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_252_1.var_.actorSpriteComps10128 = nil
			end

			local var_255_16 = 0
			local var_255_17 = 0.25

			if var_255_16 < arg_252_1.time_ and arg_252_1.time_ <= var_255_16 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				local var_255_18 = arg_252_1:FormatText(StoryNameCfg[1109].name)

				arg_252_1.leftNameTxt_.text = var_255_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_19 = arg_252_1:GetWordFromCfg(417141062)
				local var_255_20 = arg_252_1:FormatText(var_255_19.content)

				arg_252_1.text_.text = var_255_20

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_21 = 10
				local var_255_22 = utf8.len(var_255_20)
				local var_255_23 = var_255_21 <= 0 and var_255_17 or var_255_17 * (var_255_22 / var_255_21)

				if var_255_23 > 0 and var_255_17 < var_255_23 then
					arg_252_1.talkMaxDuration = var_255_23

					if var_255_23 + var_255_16 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_23 + var_255_16
					end
				end

				arg_252_1.text_.text = var_255_20
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417141", "417141062", "story_v_out_417141.awb") ~= 0 then
					local var_255_24 = manager.audio:GetVoiceLength("story_v_out_417141", "417141062", "story_v_out_417141.awb") / 1000

					if var_255_24 + var_255_16 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_24 + var_255_16
					end

					if var_255_19.prefab_name ~= "" and arg_252_1.actors_[var_255_19.prefab_name] ~= nil then
						local var_255_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_19.prefab_name].transform, "story_v_out_417141", "417141062", "story_v_out_417141.awb")

						arg_252_1:RecordAudio("417141062", var_255_25)
						arg_252_1:RecordAudio("417141062", var_255_25)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_417141", "417141062", "story_v_out_417141.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_417141", "417141062", "story_v_out_417141.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_26 = math.max(var_255_17, arg_252_1.talkMaxDuration)

			if var_255_16 <= arg_252_1.time_ and arg_252_1.time_ < var_255_16 + var_255_26 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_16) / var_255_26

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_16 + var_255_26 and arg_252_1.time_ < var_255_16 + var_255_26 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play417141063 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 417141063
		arg_256_1.duration_ = 8.5

		local var_256_0 = {
			zh = 6.566,
			ja = 8.5
		}
		local var_256_1 = manager.audio:GetLocalizationFlag()

		if var_256_0[var_256_1] ~= nil then
			arg_256_1.duration_ = var_256_0[var_256_1]
		end

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play417141064(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = arg_256_1.actors_["10128"]
			local var_259_1 = 0

			if var_259_1 < arg_256_1.time_ and arg_256_1.time_ <= var_259_1 + arg_259_0 and not isNil(var_259_0) and arg_256_1.var_.actorSpriteComps10128 == nil then
				arg_256_1.var_.actorSpriteComps10128 = var_259_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_259_2 = 0.2

			if var_259_1 <= arg_256_1.time_ and arg_256_1.time_ < var_259_1 + var_259_2 and not isNil(var_259_0) then
				local var_259_3 = (arg_256_1.time_ - var_259_1) / var_259_2

				if arg_256_1.var_.actorSpriteComps10128 then
					for iter_259_0, iter_259_1 in pairs(arg_256_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_259_1 then
							if arg_256_1.isInRecall_ then
								local var_259_4 = Mathf.Lerp(iter_259_1.color.r, arg_256_1.hightColor1.r, var_259_3)
								local var_259_5 = Mathf.Lerp(iter_259_1.color.g, arg_256_1.hightColor1.g, var_259_3)
								local var_259_6 = Mathf.Lerp(iter_259_1.color.b, arg_256_1.hightColor1.b, var_259_3)

								iter_259_1.color = Color.New(var_259_4, var_259_5, var_259_6)
							else
								local var_259_7 = Mathf.Lerp(iter_259_1.color.r, 1, var_259_3)

								iter_259_1.color = Color.New(var_259_7, var_259_7, var_259_7)
							end
						end
					end
				end
			end

			if arg_256_1.time_ >= var_259_1 + var_259_2 and arg_256_1.time_ < var_259_1 + var_259_2 + arg_259_0 and not isNil(var_259_0) and arg_256_1.var_.actorSpriteComps10128 then
				for iter_259_2, iter_259_3 in pairs(arg_256_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_259_3 then
						if arg_256_1.isInRecall_ then
							iter_259_3.color = arg_256_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_259_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_256_1.var_.actorSpriteComps10128 = nil
			end

			local var_259_8 = arg_256_1.actors_["1034"]
			local var_259_9 = 0

			if var_259_9 < arg_256_1.time_ and arg_256_1.time_ <= var_259_9 + arg_259_0 and not isNil(var_259_8) and arg_256_1.var_.actorSpriteComps1034 == nil then
				arg_256_1.var_.actorSpriteComps1034 = var_259_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_259_10 = 0.2

			if var_259_9 <= arg_256_1.time_ and arg_256_1.time_ < var_259_9 + var_259_10 and not isNil(var_259_8) then
				local var_259_11 = (arg_256_1.time_ - var_259_9) / var_259_10

				if arg_256_1.var_.actorSpriteComps1034 then
					for iter_259_4, iter_259_5 in pairs(arg_256_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_259_5 then
							if arg_256_1.isInRecall_ then
								local var_259_12 = Mathf.Lerp(iter_259_5.color.r, arg_256_1.hightColor2.r, var_259_11)
								local var_259_13 = Mathf.Lerp(iter_259_5.color.g, arg_256_1.hightColor2.g, var_259_11)
								local var_259_14 = Mathf.Lerp(iter_259_5.color.b, arg_256_1.hightColor2.b, var_259_11)

								iter_259_5.color = Color.New(var_259_12, var_259_13, var_259_14)
							else
								local var_259_15 = Mathf.Lerp(iter_259_5.color.r, 0.5, var_259_11)

								iter_259_5.color = Color.New(var_259_15, var_259_15, var_259_15)
							end
						end
					end
				end
			end

			if arg_256_1.time_ >= var_259_9 + var_259_10 and arg_256_1.time_ < var_259_9 + var_259_10 + arg_259_0 and not isNil(var_259_8) and arg_256_1.var_.actorSpriteComps1034 then
				for iter_259_6, iter_259_7 in pairs(arg_256_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_259_7 then
						if arg_256_1.isInRecall_ then
							iter_259_7.color = arg_256_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_259_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_256_1.var_.actorSpriteComps1034 = nil
			end

			local var_259_16 = arg_256_1.actors_["1034"].transform
			local var_259_17 = 0

			if var_259_17 < arg_256_1.time_ and arg_256_1.time_ <= var_259_17 + arg_259_0 then
				arg_256_1.var_.moveOldPos1034 = var_259_16.localPosition
				var_259_16.localScale = Vector3.New(1, 1, 1)

				arg_256_1:CheckSpriteTmpPos("1034", 4)

				local var_259_18 = var_259_16.childCount

				for iter_259_8 = 0, var_259_18 - 1 do
					local var_259_19 = var_259_16:GetChild(iter_259_8)

					if var_259_19.name == "" or not string.find(var_259_19.name, "split") then
						var_259_19.gameObject:SetActive(true)
					else
						var_259_19.gameObject:SetActive(false)
					end
				end
			end

			local var_259_20 = 0.001

			if var_259_17 <= arg_256_1.time_ and arg_256_1.time_ < var_259_17 + var_259_20 then
				local var_259_21 = (arg_256_1.time_ - var_259_17) / var_259_20
				local var_259_22 = Vector3.New(373.7, -331.9, -324)

				var_259_16.localPosition = Vector3.Lerp(arg_256_1.var_.moveOldPos1034, var_259_22, var_259_21)
			end

			if arg_256_1.time_ >= var_259_17 + var_259_20 and arg_256_1.time_ < var_259_17 + var_259_20 + arg_259_0 then
				var_259_16.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_259_23 = arg_256_1.actors_["10128"].transform
			local var_259_24 = 0

			if var_259_24 < arg_256_1.time_ and arg_256_1.time_ <= var_259_24 + arg_259_0 then
				arg_256_1.var_.moveOldPos10128 = var_259_23.localPosition
				var_259_23.localScale = Vector3.New(1, 1, 1)

				arg_256_1:CheckSpriteTmpPos("10128", 2)

				local var_259_25 = var_259_23.childCount

				for iter_259_9 = 0, var_259_25 - 1 do
					local var_259_26 = var_259_23:GetChild(iter_259_9)

					if var_259_26.name == "" or not string.find(var_259_26.name, "split") then
						var_259_26.gameObject:SetActive(true)
					else
						var_259_26.gameObject:SetActive(false)
					end
				end
			end

			local var_259_27 = 0.001

			if var_259_24 <= arg_256_1.time_ and arg_256_1.time_ < var_259_24 + var_259_27 then
				local var_259_28 = (arg_256_1.time_ - var_259_24) / var_259_27
				local var_259_29 = Vector3.New(-390, -347, -300)

				var_259_23.localPosition = Vector3.Lerp(arg_256_1.var_.moveOldPos10128, var_259_29, var_259_28)
			end

			if arg_256_1.time_ >= var_259_24 + var_259_27 and arg_256_1.time_ < var_259_24 + var_259_27 + arg_259_0 then
				var_259_23.localPosition = Vector3.New(-390, -347, -300)
			end

			local var_259_30 = 0
			local var_259_31 = 0.9

			if var_259_30 < arg_256_1.time_ and arg_256_1.time_ <= var_259_30 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				local var_259_32 = arg_256_1:FormatText(StoryNameCfg[595].name)

				arg_256_1.leftNameTxt_.text = var_259_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_33 = arg_256_1:GetWordFromCfg(417141063)
				local var_259_34 = arg_256_1:FormatText(var_259_33.content)

				arg_256_1.text_.text = var_259_34

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_35 = 36
				local var_259_36 = utf8.len(var_259_34)
				local var_259_37 = var_259_35 <= 0 and var_259_31 or var_259_31 * (var_259_36 / var_259_35)

				if var_259_37 > 0 and var_259_31 < var_259_37 then
					arg_256_1.talkMaxDuration = var_259_37

					if var_259_37 + var_259_30 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_37 + var_259_30
					end
				end

				arg_256_1.text_.text = var_259_34
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417141", "417141063", "story_v_out_417141.awb") ~= 0 then
					local var_259_38 = manager.audio:GetVoiceLength("story_v_out_417141", "417141063", "story_v_out_417141.awb") / 1000

					if var_259_38 + var_259_30 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_38 + var_259_30
					end

					if var_259_33.prefab_name ~= "" and arg_256_1.actors_[var_259_33.prefab_name] ~= nil then
						local var_259_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_33.prefab_name].transform, "story_v_out_417141", "417141063", "story_v_out_417141.awb")

						arg_256_1:RecordAudio("417141063", var_259_39)
						arg_256_1:RecordAudio("417141063", var_259_39)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_out_417141", "417141063", "story_v_out_417141.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_out_417141", "417141063", "story_v_out_417141.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_40 = math.max(var_259_31, arg_256_1.talkMaxDuration)

			if var_259_30 <= arg_256_1.time_ and arg_256_1.time_ < var_259_30 + var_259_40 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_30) / var_259_40

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_30 + var_259_40 and arg_256_1.time_ < var_259_30 + var_259_40 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_256_1:InitPlayNodeList()
	end,
	Play417141064 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 417141064
		arg_260_1.duration_ = 7.97

		local var_260_0 = {
			zh = 5.7,
			ja = 7.966
		}
		local var_260_1 = manager.audio:GetLocalizationFlag()

		if var_260_0[var_260_1] ~= nil then
			arg_260_1.duration_ = var_260_0[var_260_1]
		end

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play417141065(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = arg_260_1.actors_["1034"]
			local var_263_1 = 0

			if var_263_1 < arg_260_1.time_ and arg_260_1.time_ <= var_263_1 + arg_263_0 and not isNil(var_263_0) and arg_260_1.var_.actorSpriteComps1034 == nil then
				arg_260_1.var_.actorSpriteComps1034 = var_263_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_263_2 = 0.2

			if var_263_1 <= arg_260_1.time_ and arg_260_1.time_ < var_263_1 + var_263_2 and not isNil(var_263_0) then
				local var_263_3 = (arg_260_1.time_ - var_263_1) / var_263_2

				if arg_260_1.var_.actorSpriteComps1034 then
					for iter_263_0, iter_263_1 in pairs(arg_260_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_263_1 then
							if arg_260_1.isInRecall_ then
								local var_263_4 = Mathf.Lerp(iter_263_1.color.r, arg_260_1.hightColor1.r, var_263_3)
								local var_263_5 = Mathf.Lerp(iter_263_1.color.g, arg_260_1.hightColor1.g, var_263_3)
								local var_263_6 = Mathf.Lerp(iter_263_1.color.b, arg_260_1.hightColor1.b, var_263_3)

								iter_263_1.color = Color.New(var_263_4, var_263_5, var_263_6)
							else
								local var_263_7 = Mathf.Lerp(iter_263_1.color.r, 1, var_263_3)

								iter_263_1.color = Color.New(var_263_7, var_263_7, var_263_7)
							end
						end
					end
				end
			end

			if arg_260_1.time_ >= var_263_1 + var_263_2 and arg_260_1.time_ < var_263_1 + var_263_2 + arg_263_0 and not isNil(var_263_0) and arg_260_1.var_.actorSpriteComps1034 then
				for iter_263_2, iter_263_3 in pairs(arg_260_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_263_3 then
						if arg_260_1.isInRecall_ then
							iter_263_3.color = arg_260_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_263_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_260_1.var_.actorSpriteComps1034 = nil
			end

			local var_263_8 = arg_260_1.actors_["1034"].transform
			local var_263_9 = 0

			if var_263_9 < arg_260_1.time_ and arg_260_1.time_ <= var_263_9 + arg_263_0 then
				arg_260_1.var_.moveOldPos1034 = var_263_8.localPosition
				var_263_8.localScale = Vector3.New(1, 1, 1)

				arg_260_1:CheckSpriteTmpPos("1034", 3)

				local var_263_10 = var_263_8.childCount

				for iter_263_4 = 0, var_263_10 - 1 do
					local var_263_11 = var_263_8:GetChild(iter_263_4)

					if var_263_11.name == "split_1" or not string.find(var_263_11.name, "split") then
						var_263_11.gameObject:SetActive(true)
					else
						var_263_11.gameObject:SetActive(false)
					end
				end
			end

			local var_263_12 = 0.001

			if var_263_9 <= arg_260_1.time_ and arg_260_1.time_ < var_263_9 + var_263_12 then
				local var_263_13 = (arg_260_1.time_ - var_263_9) / var_263_12
				local var_263_14 = Vector3.New(0, -331.9, -324)

				var_263_8.localPosition = Vector3.Lerp(arg_260_1.var_.moveOldPos1034, var_263_14, var_263_13)
			end

			if arg_260_1.time_ >= var_263_9 + var_263_12 and arg_260_1.time_ < var_263_9 + var_263_12 + arg_263_0 then
				var_263_8.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_263_15 = arg_260_1.actors_["10128"].transform
			local var_263_16 = 0

			if var_263_16 < arg_260_1.time_ and arg_260_1.time_ <= var_263_16 + arg_263_0 then
				arg_260_1.var_.moveOldPos10128 = var_263_15.localPosition
				var_263_15.localScale = Vector3.New(1, 1, 1)

				arg_260_1:CheckSpriteTmpPos("10128", 7)

				local var_263_17 = var_263_15.childCount

				for iter_263_5 = 0, var_263_17 - 1 do
					local var_263_18 = var_263_15:GetChild(iter_263_5)

					if var_263_18.name == "" or not string.find(var_263_18.name, "split") then
						var_263_18.gameObject:SetActive(true)
					else
						var_263_18.gameObject:SetActive(false)
					end
				end
			end

			local var_263_19 = 0.001

			if var_263_16 <= arg_260_1.time_ and arg_260_1.time_ < var_263_16 + var_263_19 then
				local var_263_20 = (arg_260_1.time_ - var_263_16) / var_263_19
				local var_263_21 = Vector3.New(0, -2000, -300)

				var_263_15.localPosition = Vector3.Lerp(arg_260_1.var_.moveOldPos10128, var_263_21, var_263_20)
			end

			if arg_260_1.time_ >= var_263_16 + var_263_19 and arg_260_1.time_ < var_263_16 + var_263_19 + arg_263_0 then
				var_263_15.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_263_22 = 0
			local var_263_23 = 0.6

			if var_263_22 < arg_260_1.time_ and arg_260_1.time_ <= var_263_22 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				local var_263_24 = arg_260_1:FormatText(StoryNameCfg[1109].name)

				arg_260_1.leftNameTxt_.text = var_263_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_25 = arg_260_1:GetWordFromCfg(417141064)
				local var_263_26 = arg_260_1:FormatText(var_263_25.content)

				arg_260_1.text_.text = var_263_26

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_27 = 24
				local var_263_28 = utf8.len(var_263_26)
				local var_263_29 = var_263_27 <= 0 and var_263_23 or var_263_23 * (var_263_28 / var_263_27)

				if var_263_29 > 0 and var_263_23 < var_263_29 then
					arg_260_1.talkMaxDuration = var_263_29

					if var_263_29 + var_263_22 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_29 + var_263_22
					end
				end

				arg_260_1.text_.text = var_263_26
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417141", "417141064", "story_v_out_417141.awb") ~= 0 then
					local var_263_30 = manager.audio:GetVoiceLength("story_v_out_417141", "417141064", "story_v_out_417141.awb") / 1000

					if var_263_30 + var_263_22 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_30 + var_263_22
					end

					if var_263_25.prefab_name ~= "" and arg_260_1.actors_[var_263_25.prefab_name] ~= nil then
						local var_263_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_260_1.actors_[var_263_25.prefab_name].transform, "story_v_out_417141", "417141064", "story_v_out_417141.awb")

						arg_260_1:RecordAudio("417141064", var_263_31)
						arg_260_1:RecordAudio("417141064", var_263_31)
					else
						arg_260_1:AudioAction("play", "voice", "story_v_out_417141", "417141064", "story_v_out_417141.awb")
					end

					arg_260_1:RecordHistoryTalkVoice("story_v_out_417141", "417141064", "story_v_out_417141.awb")
				end

				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_32 = math.max(var_263_23, arg_260_1.talkMaxDuration)

			if var_263_22 <= arg_260_1.time_ and arg_260_1.time_ < var_263_22 + var_263_32 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_22) / var_263_32

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_22 + var_263_32 and arg_260_1.time_ < var_263_22 + var_263_32 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_260_1:InitPlayNodeList()
	end,
	Play417141065 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 417141065
		arg_264_1.duration_ = 5.75

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play417141066(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			local var_267_0 = arg_264_1.actors_["1034"].transform
			local var_267_1 = 0

			if var_267_1 < arg_264_1.time_ and arg_264_1.time_ <= var_267_1 + arg_267_0 then
				arg_264_1.var_.moveOldPos1034 = var_267_0.localPosition
				var_267_0.localScale = Vector3.New(1, 1, 1)

				arg_264_1:CheckSpriteTmpPos("1034", 7)

				local var_267_2 = var_267_0.childCount

				for iter_267_0 = 0, var_267_2 - 1 do
					local var_267_3 = var_267_0:GetChild(iter_267_0)

					if var_267_3.name == "" or not string.find(var_267_3.name, "split") then
						var_267_3.gameObject:SetActive(true)
					else
						var_267_3.gameObject:SetActive(false)
					end
				end
			end

			local var_267_4 = 0.001

			if var_267_1 <= arg_264_1.time_ and arg_264_1.time_ < var_267_1 + var_267_4 then
				local var_267_5 = (arg_264_1.time_ - var_267_1) / var_267_4
				local var_267_6 = Vector3.New(0, -2000, 0)

				var_267_0.localPosition = Vector3.Lerp(arg_264_1.var_.moveOldPos1034, var_267_6, var_267_5)
			end

			if arg_264_1.time_ >= var_267_1 + var_267_4 and arg_264_1.time_ < var_267_1 + var_267_4 + arg_267_0 then
				var_267_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_267_7 = arg_264_1.actors_["10128"].transform
			local var_267_8 = 0

			if var_267_8 < arg_264_1.time_ and arg_264_1.time_ <= var_267_8 + arg_267_0 then
				arg_264_1.var_.moveOldPos10128 = var_267_7.localPosition
				var_267_7.localScale = Vector3.New(1, 1, 1)

				arg_264_1:CheckSpriteTmpPos("10128", 7)

				local var_267_9 = var_267_7.childCount

				for iter_267_1 = 0, var_267_9 - 1 do
					local var_267_10 = var_267_7:GetChild(iter_267_1)

					if var_267_10.name == "" or not string.find(var_267_10.name, "split") then
						var_267_10.gameObject:SetActive(true)
					else
						var_267_10.gameObject:SetActive(false)
					end
				end
			end

			local var_267_11 = 0.001

			if var_267_8 <= arg_264_1.time_ and arg_264_1.time_ < var_267_8 + var_267_11 then
				local var_267_12 = (arg_264_1.time_ - var_267_8) / var_267_11
				local var_267_13 = Vector3.New(0, -2000, -300)

				var_267_7.localPosition = Vector3.Lerp(arg_264_1.var_.moveOldPos10128, var_267_13, var_267_12)
			end

			if arg_264_1.time_ >= var_267_8 + var_267_11 and arg_264_1.time_ < var_267_8 + var_267_11 + arg_267_0 then
				var_267_7.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_267_14 = manager.ui.mainCamera.transform
			local var_267_15 = 0

			if var_267_15 < arg_264_1.time_ and arg_264_1.time_ <= var_267_15 + arg_267_0 then
				local var_267_16 = arg_264_1.var_.effect1065
				local var_267_17
				local var_267_18 = var_267_14

				if not var_267_16 then
					var_267_16 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang01"), var_267_18)
					var_267_16.name = "1065"
					arg_264_1.var_.effect1065 = var_267_16
				else
					var_267_16.transform:SetParent(var_267_18)
				end

				var_267_16.transform.localPosition = Vector3.New(0, 0, 0)
				var_267_16.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_267_19 = manager.ui.mainCamera.transform
			local var_267_20 = 0.133333333333333

			if var_267_20 < arg_264_1.time_ and arg_264_1.time_ <= var_267_20 + arg_267_0 then
				arg_264_1.var_.shakeOldPos = var_267_19.localPosition
			end

			local var_267_21 = 0.4

			if var_267_20 <= arg_264_1.time_ and arg_264_1.time_ < var_267_20 + var_267_21 then
				local var_267_22 = (arg_264_1.time_ - var_267_20) / 0.066
				local var_267_23, var_267_24 = math.modf(var_267_22)

				var_267_19.localPosition = Vector3.New(var_267_24 * 0.13, var_267_24 * 0.13, var_267_24 * 0.13) + arg_264_1.var_.shakeOldPos
			end

			if arg_264_1.time_ >= var_267_20 + var_267_21 and arg_264_1.time_ < var_267_20 + var_267_21 + arg_267_0 then
				var_267_19.localPosition = arg_264_1.var_.shakeOldPos
			end

			local var_267_25 = 0
			local var_267_26 = 1

			if var_267_25 < arg_264_1.time_ and arg_264_1.time_ <= var_267_25 + arg_267_0 then
				local var_267_27 = "play"
				local var_267_28 = "effect"

				arg_264_1:AudioAction(var_267_27, var_267_28, "se_story_1311", "se_story_1311_attack", "")
			end

			if arg_264_1.frameCnt_ <= 1 then
				arg_264_1.dialog_:SetActive(false)
			end

			local var_267_29 = 0.752036600839347
			local var_267_30 = 1

			if var_267_29 < arg_264_1.time_ and arg_264_1.time_ <= var_267_29 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0

				arg_264_1.dialog_:SetActive(true)

				arg_264_1.dialogCg_.alpha = 0

				local var_267_31 = LeanTween.value(arg_264_1.dialog_, 0, 1, 0.3)

				var_267_31:setOnUpdate(LuaHelper.FloatAction(function(arg_268_0)
					arg_264_1.dialogCg_.alpha = arg_268_0
				end))
				var_267_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_264_1.dialog_)
					var_267_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_264_1.duration_ = arg_264_1.duration_ + 0.3

				SetActive(arg_264_1.leftNameGo_, false)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_32 = arg_264_1:GetWordFromCfg(417141065)
				local var_267_33 = arg_264_1:FormatText(var_267_32.content)

				arg_264_1.text_.text = var_267_33

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_34 = 36
				local var_267_35 = utf8.len(var_267_33)
				local var_267_36 = var_267_34 <= 0 and var_267_30 or var_267_30 * (var_267_35 / var_267_34)

				if var_267_36 > 0 and var_267_30 < var_267_36 then
					arg_264_1.talkMaxDuration = var_267_36
					var_267_29 = var_267_29 + 0.3

					if var_267_36 + var_267_29 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_36 + var_267_29
					end
				end

				arg_264_1.text_.text = var_267_33
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)
				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_37 = var_267_29 + 0.3
			local var_267_38 = math.max(var_267_30, arg_264_1.talkMaxDuration)

			if var_267_37 <= arg_264_1.time_ and arg_264_1.time_ < var_267_37 + var_267_38 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_37) / var_267_38

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_37 + var_267_38 and arg_264_1.time_ < var_267_37 + var_267_38 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_264_1:InitPlayNodeList()
	end,
	Play417141066 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 417141066
		arg_270_1.duration_ = 5

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
			arg_270_1.auto_ = false
		end

		function arg_270_1.playNext_(arg_272_0)
			arg_270_1.onStoryFinished_()
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = 0.01
			local var_273_1 = 1

			if var_273_0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_0 + arg_273_0 then
				local var_273_2 = "play"
				local var_273_3 = "effect"

				arg_270_1:AudioAction(var_273_2, var_273_3, "se_story_1310", "se_story_1310_explosion", "")
			end

			local var_273_4 = 0
			local var_273_5 = 0.8

			if var_273_4 < arg_270_1.time_ and arg_270_1.time_ <= var_273_4 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, false)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_6 = arg_270_1:GetWordFromCfg(417141066)
				local var_273_7 = arg_270_1:FormatText(var_273_6.content)

				arg_270_1.text_.text = var_273_7

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_8 = 32
				local var_273_9 = utf8.len(var_273_7)
				local var_273_10 = var_273_8 <= 0 and var_273_5 or var_273_5 * (var_273_9 / var_273_8)

				if var_273_10 > 0 and var_273_5 < var_273_10 then
					arg_270_1.talkMaxDuration = var_273_10

					if var_273_10 + var_273_4 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_10 + var_273_4
					end
				end

				arg_270_1.text_.text = var_273_7
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)
				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_11 = math.max(var_273_5, arg_270_1.talkMaxDuration)

			if var_273_4 <= arg_270_1.time_ and arg_270_1.time_ < var_273_4 + var_273_11 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_4) / var_273_11

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_4 + var_273_11 and arg_270_1.time_ < var_273_4 + var_273_11 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STblack",
		"SofdecAsset/story/story_1041714.usm",
		"TextureConfig/Background/STwhite",
		"TextureConfig/Background/I07a",
		"TextureConfig/Background/B10",
		"TextureConfig/Background/I07",
		"TextureConfig/Background/D10"
	},
	voices = {
		"story_v_out_417141.awb"
	}
}
