return {
	Play420012001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 420012001
		arg_1_1.duration_ = 17.37

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play420012002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 2

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_1 = 2

			if arg_1_1.time_ >= var_4_0 + var_4_1 and arg_1_1.time_ < var_4_0 + var_4_1 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_2 = "STwhite"

			if arg_1_1.bgs_[var_4_2] == nil then
				local var_4_3 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_2)
				var_4_3.name = var_4_2
				var_4_3.transform.parent = arg_1_1.stage_.transform
				var_4_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_2] = var_4_3
			end

			local var_4_4 = 0

			if var_4_4 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				local var_4_5 = manager.ui.mainCamera.transform.localPosition
				local var_4_6 = Vector3.New(0, 0, 10) + Vector3.New(var_4_5.x, var_4_5.y, 0)
				local var_4_7 = arg_1_1.bgs_.STwhite

				var_4_7.transform.localPosition = var_4_6
				var_4_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_8 = var_4_7:GetComponent("SpriteRenderer")

				if var_4_8 and var_4_8.sprite then
					local var_4_9 = (var_4_7.transform.localPosition - var_4_5).z
					local var_4_10 = manager.ui.mainCameraCom_
					local var_4_11 = 2 * var_4_9 * Mathf.Tan(var_4_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_12 = var_4_11 * var_4_10.aspect
					local var_4_13 = var_4_8.sprite.bounds.size.x
					local var_4_14 = var_4_8.sprite.bounds.size.y
					local var_4_15 = var_4_12 / var_4_13
					local var_4_16 = var_4_11 / var_4_14
					local var_4_17 = var_4_16 < var_4_15 and var_4_15 or var_4_16

					var_4_7.transform.localScale = Vector3.New(var_4_17, var_4_17, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "STwhite" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_18 = 0

			if var_4_18 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_19 = 2

			if var_4_18 <= arg_1_1.time_ and arg_1_1.time_ < var_4_18 + var_4_19 then
				local var_4_20 = (arg_1_1.time_ - var_4_18) / var_4_19
				local var_4_21 = Color.New(0, 0, 0)

				var_4_21.a = Mathf.Lerp(1, 0, var_4_20)
				arg_1_1.mask_.color = var_4_21
			end

			if arg_1_1.time_ >= var_4_18 + var_4_19 and arg_1_1.time_ < var_4_18 + var_4_19 + arg_4_0 then
				local var_4_22 = Color.New(0, 0, 0)
				local var_4_23 = 0

				arg_1_1.mask_.enabled = false
				var_4_22.a = var_4_23
				arg_1_1.mask_.color = var_4_22
			end

			local var_4_24 = 0

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				arg_1_1.cswbg_:SetActive(true)

				local var_4_25 = arg_1_1.cswt_:GetComponent("RectTransform")

				arg_1_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_4_25.offsetMin = Vector2.New(0, 0)
				var_4_25.offsetMax = Vector2.New(0, 130)

				local var_4_26 = arg_1_1:GetWordFromCfg(419139)
				local var_4_27 = arg_1_1:FormatText(var_4_26.content)

				arg_1_1.cswt_.text = var_4_27

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.cswt_)

				arg_1_1.cswt_.fontSize = 120
				arg_1_1.cswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_1_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_1_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_4_28 = 0

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_29 = arg_1_1.fswbg_.transform:Find("textbox/adapt/content") or arg_1_1.fswbg_.transform:Find("textbox/content")
				local var_4_30 = arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_4_31 = var_4_29:GetComponent("Text")
				local var_4_32 = var_4_29:GetComponent("RectTransform")

				var_4_31.alignment = UnityEngine.TextAnchor.LowerCenter
				var_4_32.offsetMin = Vector2.New(0, -70)
				var_4_32.offsetMax = Vector2.New(0, 0)
			end

			local var_4_33 = 0

			if var_4_33 < arg_1_1.time_ and arg_1_1.time_ <= var_4_33 + arg_4_0 then
				arg_1_1.fswbg_:SetActive(true)
				arg_1_1.dialog_:SetActive(false)

				arg_1_1.fswtw_.percent = 0

				local var_4_34 = arg_1_1:GetWordFromCfg(420012001)
				local var_4_35 = arg_1_1:FormatText(var_4_34.content)

				arg_1_1.fswt_.text = var_4_35

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.fswt_)

				arg_1_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_1_1.fswtw_:SetDirty()

				arg_1_1.typewritterCharCountI18N = 0

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_36 = 2

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				arg_1_1.var_.oldValueTypewriter = arg_1_1.fswtw_.percent

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_37 = 36
			local var_4_38 = 2.4
			local var_4_39 = arg_1_1:GetWordFromCfg(420012001)
			local var_4_40 = arg_1_1:FormatText(var_4_39.content)
			local var_4_41, var_4_42 = arg_1_1:GetPercentByPara(var_4_40, 1)

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				local var_4_43 = var_4_37 <= 0 and var_4_38 or var_4_38 * ((var_4_42 - arg_1_1.typewritterCharCountI18N) / var_4_37)

				if var_4_43 > 0 and var_4_38 < var_4_43 then
					arg_1_1.talkMaxDuration = var_4_43

					if var_4_43 + var_4_36 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_43 + var_4_36
					end
				end
			end

			local var_4_44 = 2.4
			local var_4_45 = math.max(var_4_44, arg_1_1.talkMaxDuration)

			if var_4_36 <= arg_1_1.time_ and arg_1_1.time_ < var_4_36 + var_4_45 then
				local var_4_46 = (arg_1_1.time_ - var_4_36) / var_4_45

				arg_1_1.fswtw_.percent = Mathf.Lerp(arg_1_1.var_.oldValueTypewriter, var_4_41, var_4_46)
				arg_1_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_1_1.fswtw_:SetDirty()
			end

			if arg_1_1.time_ >= var_4_36 + var_4_45 and arg_1_1.time_ < var_4_36 + var_4_45 + arg_4_0 then
				arg_1_1.fswtw_.percent = var_4_41

				arg_1_1.fswtw_:SetDirty()
				arg_1_1:ShowNextGo(true)

				arg_1_1.typewritterCharCountI18N = var_4_42
			end

			local var_4_47 = 2
			local var_4_48 = 15.366
			local var_4_49 = manager.audio:GetVoiceLength("story_v_out_420012", "420012001", "story_v_out_420012.awb") / 1000

			if var_4_49 > 0 and var_4_48 < var_4_49 and var_4_49 + var_4_47 > arg_1_1.duration_ then
				local var_4_50 = var_4_49

				arg_1_1.duration_ = var_4_49 + var_4_47
			end

			if var_4_47 < arg_1_1.time_ and arg_1_1.time_ <= var_4_47 + arg_4_0 then
				local var_4_51 = "play"
				local var_4_52 = "voice"

				arg_1_1:AudioAction(var_4_51, var_4_52, "story_v_out_420012", "420012001", "story_v_out_420012.awb")
			end

			local var_4_53 = 0
			local var_4_54 = 0.2

			if var_4_53 < arg_1_1.time_ and arg_1_1.time_ <= var_4_53 + arg_4_0 then
				local var_4_55 = "play"
				local var_4_56 = "music"

				arg_1_1:AudioAction(var_4_55, var_4_56, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_57 = ""
				local var_4_58 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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
	Play420012002 = function(arg_6_0, arg_6_1)
		arg_6_1.time_ = 0
		arg_6_1.frameCnt_ = 0
		arg_6_1.state_ = "playing"
		arg_6_1.curTalkId_ = 420012002
		arg_6_1.duration_ = 16.28

		SetActive(arg_6_1.tipsGo_, false)

		function arg_6_1.onSingleLineFinish_()
			arg_6_1.onSingleLineUpdate_ = nil
			arg_6_1.onSingleLineFinish_ = nil
			arg_6_1.state_ = "waiting"
		end

		function arg_6_1.playNext_(arg_8_0)
			if arg_8_0 == 1 then
				arg_6_0:Play420012003(arg_6_1)
			end
		end

		function arg_6_1.onSingleLineUpdate_(arg_9_0)
			local var_9_0 = 0

			if var_9_0 < arg_6_1.time_ and arg_6_1.time_ <= var_9_0 + arg_9_0 then
				arg_6_1.fswbg_:SetActive(true)
				arg_6_1.dialog_:SetActive(false)

				arg_6_1.fswtw_.percent = 0

				local var_9_1 = arg_6_1:GetWordFromCfg(420012002)
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

			local var_9_3 = 0.0166666666666667

			if var_9_3 < arg_6_1.time_ and arg_6_1.time_ <= var_9_3 + arg_9_0 then
				arg_6_1.var_.oldValueTypewriter = arg_6_1.fswtw_.percent

				SetActive(arg_6_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_6_1:ShowNextGo(false)
			end

			local var_9_4 = 40
			local var_9_5 = 2.66666666666667
			local var_9_6 = arg_6_1:GetWordFromCfg(420012002)
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

			local var_9_11 = 2.66666666666667
			local var_9_12 = math.max(var_9_11, arg_6_1.talkMaxDuration)

			if var_9_3 <= arg_6_1.time_ and arg_6_1.time_ < var_9_3 + var_9_12 then
				local var_9_13 = (arg_6_1.time_ - var_9_3) / var_9_12

				arg_6_1.fswtw_.percent = Mathf.Lerp(arg_6_1.var_.oldValueTypewriter, var_9_8, var_9_13)
				arg_6_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_6_1.fswtw_:SetDirty()
			end

			if arg_6_1.time_ >= var_9_3 + var_9_12 and arg_6_1.time_ < var_9_3 + var_9_12 + arg_9_0 then
				arg_6_1.fswtw_.percent = var_9_8

				arg_6_1.fswtw_:SetDirty()
				arg_6_1:ShowNextGo(true)

				arg_6_1.typewritterCharCountI18N = var_9_9
			end

			local var_9_14 = 0.0166666666666667
			local var_9_15 = 16.266
			local var_9_16 = manager.audio:GetVoiceLength("story_v_out_420012", "420012002", "story_v_out_420012.awb") / 1000

			if var_9_16 > 0 and var_9_15 < var_9_16 and var_9_16 + var_9_14 > arg_6_1.duration_ then
				local var_9_17 = var_9_16

				arg_6_1.duration_ = var_9_16 + var_9_14
			end

			if var_9_14 < arg_6_1.time_ and arg_6_1.time_ <= var_9_14 + arg_9_0 then
				local var_9_18 = "play"
				local var_9_19 = "voice"

				arg_6_1:AudioAction(var_9_18, var_9_19, "story_v_out_420012", "420012002", "story_v_out_420012.awb")
			end
		end

		arg_6_1.nodeConfigList_ = {}

		arg_6_1:InitPlayNodeList()
	end,
	Play420012003 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 420012003
		arg_10_1.duration_ = 16.35

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play420012004(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			local var_13_0 = 0

			if var_13_0 < arg_10_1.time_ and arg_10_1.time_ <= var_13_0 + arg_13_0 then
				arg_10_1.fswbg_:SetActive(true)
				arg_10_1.dialog_:SetActive(false)

				arg_10_1.fswtw_.percent = 0

				local var_13_1 = arg_10_1:GetWordFromCfg(420012003)
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

			local var_13_3 = 0.0166666666666667

			if var_13_3 < arg_10_1.time_ and arg_10_1.time_ <= var_13_3 + arg_13_0 then
				arg_10_1.var_.oldValueTypewriter = arg_10_1.fswtw_.percent

				SetActive(arg_10_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_10_1:ShowNextGo(false)
			end

			local var_13_4 = 45
			local var_13_5 = 3
			local var_13_6 = arg_10_1:GetWordFromCfg(420012003)
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

			local var_13_11 = 3
			local var_13_12 = math.max(var_13_11, arg_10_1.talkMaxDuration)

			if var_13_3 <= arg_10_1.time_ and arg_10_1.time_ < var_13_3 + var_13_12 then
				local var_13_13 = (arg_10_1.time_ - var_13_3) / var_13_12

				arg_10_1.fswtw_.percent = Mathf.Lerp(arg_10_1.var_.oldValueTypewriter, var_13_8, var_13_13)
				arg_10_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_10_1.fswtw_:SetDirty()
			end

			if arg_10_1.time_ >= var_13_3 + var_13_12 and arg_10_1.time_ < var_13_3 + var_13_12 + arg_13_0 then
				arg_10_1.fswtw_.percent = var_13_8

				arg_10_1.fswtw_:SetDirty()
				arg_10_1:ShowNextGo(true)

				arg_10_1.typewritterCharCountI18N = var_13_9
			end

			local var_13_14 = 0.0166666666666667
			local var_13_15 = 16.333
			local var_13_16 = manager.audio:GetVoiceLength("story_v_out_420012", "420012003", "story_v_out_420012.awb") / 1000

			if var_13_16 > 0 and var_13_15 < var_13_16 and var_13_16 + var_13_14 > arg_10_1.duration_ then
				local var_13_17 = var_13_16

				arg_10_1.duration_ = var_13_16 + var_13_14
			end

			if var_13_14 < arg_10_1.time_ and arg_10_1.time_ <= var_13_14 + arg_13_0 then
				local var_13_18 = "play"
				local var_13_19 = "voice"

				arg_10_1:AudioAction(var_13_18, var_13_19, "story_v_out_420012", "420012003", "story_v_out_420012.awb")
			end
		end

		arg_10_1.nodeConfigList_ = {}

		arg_10_1:InitPlayNodeList()
	end,
	Play420012004 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 420012004
		arg_14_1.duration_ = 11.25

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play420012005(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = 0

			if var_17_0 < arg_14_1.time_ and arg_14_1.time_ <= var_17_0 + arg_17_0 then
				arg_14_1.cswbg_:SetActive(true)

				local var_17_1 = arg_14_1.cswt_:GetComponent("RectTransform")

				arg_14_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_17_1.offsetMin = Vector2.New(0, 0)
				var_17_1.offsetMax = Vector2.New(0, 130)

				local var_17_2 = arg_14_1:GetWordFromCfg(419140)
				local var_17_3 = arg_14_1:FormatText(var_17_2.content)

				arg_14_1.cswt_.text = var_17_3

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.cswt_)

				arg_14_1.cswt_.fontSize = 120
				arg_14_1.cswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_14_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_14_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_17_4 = 0

			if var_17_4 < arg_14_1.time_ and arg_14_1.time_ <= var_17_4 + arg_17_0 then
				arg_14_1.fswbg_:SetActive(true)
				arg_14_1.dialog_:SetActive(false)

				arg_14_1.fswtw_.percent = 0

				local var_17_5 = arg_14_1:GetWordFromCfg(420012004)
				local var_17_6 = arg_14_1:FormatText(var_17_5.content)

				arg_14_1.fswt_.text = var_17_6

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.fswt_)

				arg_14_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_14_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_14_1.fswtw_:SetDirty()

				arg_14_1.typewritterCharCountI18N = 0

				SetActive(arg_14_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_14_1:ShowNextGo(false)
			end

			local var_17_7 = 0.0166666666666667

			if var_17_7 < arg_14_1.time_ and arg_14_1.time_ <= var_17_7 + arg_17_0 then
				arg_14_1.var_.oldValueTypewriter = arg_14_1.fswtw_.percent

				SetActive(arg_14_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_14_1:ShowNextGo(false)
			end

			local var_17_8 = 23
			local var_17_9 = 1.53333333333333
			local var_17_10 = arg_14_1:GetWordFromCfg(420012004)
			local var_17_11 = arg_14_1:FormatText(var_17_10.content)
			local var_17_12, var_17_13 = arg_14_1:GetPercentByPara(var_17_11, 1)

			if var_17_7 < arg_14_1.time_ and arg_14_1.time_ <= var_17_7 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0

				local var_17_14 = var_17_8 <= 0 and var_17_9 or var_17_9 * ((var_17_13 - arg_14_1.typewritterCharCountI18N) / var_17_8)

				if var_17_14 > 0 and var_17_9 < var_17_14 then
					arg_14_1.talkMaxDuration = var_17_14

					if var_17_14 + var_17_7 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_14 + var_17_7
					end
				end
			end

			local var_17_15 = 1.53333333333333
			local var_17_16 = math.max(var_17_15, arg_14_1.talkMaxDuration)

			if var_17_7 <= arg_14_1.time_ and arg_14_1.time_ < var_17_7 + var_17_16 then
				local var_17_17 = (arg_14_1.time_ - var_17_7) / var_17_16

				arg_14_1.fswtw_.percent = Mathf.Lerp(arg_14_1.var_.oldValueTypewriter, var_17_12, var_17_17)
				arg_14_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_14_1.fswtw_:SetDirty()
			end

			if arg_14_1.time_ >= var_17_7 + var_17_16 and arg_14_1.time_ < var_17_7 + var_17_16 + arg_17_0 then
				arg_14_1.fswtw_.percent = var_17_12

				arg_14_1.fswtw_:SetDirty()
				arg_14_1:ShowNextGo(true)

				arg_14_1.typewritterCharCountI18N = var_17_13
			end

			local var_17_18 = 0.0166666666666667
			local var_17_19 = 11.233
			local var_17_20 = manager.audio:GetVoiceLength("story_v_out_420012", "420012004", "story_v_out_420012.awb") / 1000

			if var_17_20 > 0 and var_17_19 < var_17_20 and var_17_20 + var_17_18 > arg_14_1.duration_ then
				local var_17_21 = var_17_20

				arg_14_1.duration_ = var_17_20 + var_17_18
			end

			if var_17_18 < arg_14_1.time_ and arg_14_1.time_ <= var_17_18 + arg_17_0 then
				local var_17_22 = "play"
				local var_17_23 = "voice"

				arg_14_1:AudioAction(var_17_22, var_17_23, "story_v_out_420012", "420012004", "story_v_out_420012.awb")
			end
		end

		arg_14_1.nodeConfigList_ = {}

		arg_14_1:InitPlayNodeList()
	end,
	Play420012005 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 420012005
		arg_18_1.duration_ = 15.22

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play420012006(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = 0

			if var_21_0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_0 + arg_21_0 then
				arg_18_1.fswbg_:SetActive(true)
				arg_18_1.dialog_:SetActive(false)

				arg_18_1.fswtw_.percent = 0

				local var_21_1 = arg_18_1:GetWordFromCfg(420012005)
				local var_21_2 = arg_18_1:FormatText(var_21_1.content)

				arg_18_1.fswt_.text = var_21_2

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.fswt_)

				arg_18_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_18_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_18_1.fswtw_:SetDirty()

				arg_18_1.typewritterCharCountI18N = 0

				SetActive(arg_18_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_18_1:ShowNextGo(false)
			end

			local var_21_3 = 0.0166666666666667

			if var_21_3 < arg_18_1.time_ and arg_18_1.time_ <= var_21_3 + arg_21_0 then
				arg_18_1.var_.oldValueTypewriter = arg_18_1.fswtw_.percent

				SetActive(arg_18_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_18_1:ShowNextGo(false)
			end

			local var_21_4 = 37
			local var_21_5 = 2.46666666666667
			local var_21_6 = arg_18_1:GetWordFromCfg(420012005)
			local var_21_7 = arg_18_1:FormatText(var_21_6.content)
			local var_21_8, var_21_9 = arg_18_1:GetPercentByPara(var_21_7, 1)

			if var_21_3 < arg_18_1.time_ and arg_18_1.time_ <= var_21_3 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0

				local var_21_10 = var_21_4 <= 0 and var_21_5 or var_21_5 * ((var_21_9 - arg_18_1.typewritterCharCountI18N) / var_21_4)

				if var_21_10 > 0 and var_21_5 < var_21_10 then
					arg_18_1.talkMaxDuration = var_21_10

					if var_21_10 + var_21_3 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_10 + var_21_3
					end
				end
			end

			local var_21_11 = 2.46666666666667
			local var_21_12 = math.max(var_21_11, arg_18_1.talkMaxDuration)

			if var_21_3 <= arg_18_1.time_ and arg_18_1.time_ < var_21_3 + var_21_12 then
				local var_21_13 = (arg_18_1.time_ - var_21_3) / var_21_12

				arg_18_1.fswtw_.percent = Mathf.Lerp(arg_18_1.var_.oldValueTypewriter, var_21_8, var_21_13)
				arg_18_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_18_1.fswtw_:SetDirty()
			end

			if arg_18_1.time_ >= var_21_3 + var_21_12 and arg_18_1.time_ < var_21_3 + var_21_12 + arg_21_0 then
				arg_18_1.fswtw_.percent = var_21_8

				arg_18_1.fswtw_:SetDirty()
				arg_18_1:ShowNextGo(true)

				arg_18_1.typewritterCharCountI18N = var_21_9
			end

			local var_21_14 = 0.0166666666666667
			local var_21_15 = 15.2
			local var_21_16 = manager.audio:GetVoiceLength("story_v_out_420012", "420012005", "story_v_out_420012.awb") / 1000

			if var_21_16 > 0 and var_21_15 < var_21_16 and var_21_16 + var_21_14 > arg_18_1.duration_ then
				local var_21_17 = var_21_16

				arg_18_1.duration_ = var_21_16 + var_21_14
			end

			if var_21_14 < arg_18_1.time_ and arg_18_1.time_ <= var_21_14 + arg_21_0 then
				local var_21_18 = "play"
				local var_21_19 = "voice"

				arg_18_1:AudioAction(var_21_18, var_21_19, "story_v_out_420012", "420012005", "story_v_out_420012.awb")
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play420012006 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 420012006
		arg_22_1.duration_ = 14.83

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play420012007(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = 0

			if var_25_0 < arg_22_1.time_ and arg_22_1.time_ <= var_25_0 + arg_25_0 then
				arg_22_1.cswbg_:SetActive(true)

				local var_25_1 = arg_22_1.cswt_:GetComponent("RectTransform")

				arg_22_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_25_1.offsetMin = Vector2.New(0, 0)
				var_25_1.offsetMax = Vector2.New(0, 130)

				local var_25_2 = arg_22_1:GetWordFromCfg(419141)
				local var_25_3 = arg_22_1:FormatText(var_25_2.content)

				arg_22_1.cswt_.text = var_25_3

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.cswt_)

				arg_22_1.cswt_.fontSize = 120
				arg_22_1.cswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_22_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_22_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_25_4 = 0.0166666666666667
			local var_25_5 = 14.4
			local var_25_6 = manager.audio:GetVoiceLength("story_v_out_420012", "420012006", "story_v_out_420012.awb") / 1000

			if var_25_6 > 0 and var_25_5 < var_25_6 and var_25_6 + var_25_4 > arg_22_1.duration_ then
				local var_25_7 = var_25_6

				arg_22_1.duration_ = var_25_6 + var_25_4
			end

			if var_25_4 < arg_22_1.time_ and arg_22_1.time_ <= var_25_4 + arg_25_0 then
				local var_25_8 = "play"
				local var_25_9 = "voice"

				arg_22_1:AudioAction(var_25_8, var_25_9, "story_v_out_420012", "420012006", "story_v_out_420012.awb")
			end

			local var_25_10 = 0

			if var_25_10 < arg_22_1.time_ and arg_22_1.time_ <= var_25_10 + arg_25_0 then
				arg_22_1.fswbg_:SetActive(true)
				arg_22_1.dialog_:SetActive(false)

				arg_22_1.fswtw_.percent = 0

				local var_25_11 = arg_22_1:GetWordFromCfg(420012006)
				local var_25_12 = arg_22_1:FormatText(var_25_11.content)

				arg_22_1.fswt_.text = var_25_12

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.fswt_)

				arg_22_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_22_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_22_1.fswtw_:SetDirty()

				arg_22_1.typewritterCharCountI18N = 0

				SetActive(arg_22_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_22_1:ShowNextGo(false)
			end

			local var_25_13 = 0.0166666666666667

			if var_25_13 < arg_22_1.time_ and arg_22_1.time_ <= var_25_13 + arg_25_0 then
				arg_22_1.var_.oldValueTypewriter = arg_22_1.fswtw_.percent

				SetActive(arg_22_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_22_1:ShowNextGo(false)
			end

			local var_25_14 = 41
			local var_25_15 = 2.73333333333333
			local var_25_16 = arg_22_1:GetWordFromCfg(420012006)
			local var_25_17 = arg_22_1:FormatText(var_25_16.content)
			local var_25_18, var_25_19 = arg_22_1:GetPercentByPara(var_25_17, 1)

			if var_25_13 < arg_22_1.time_ and arg_22_1.time_ <= var_25_13 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0

				local var_25_20 = var_25_14 <= 0 and var_25_15 or var_25_15 * ((var_25_19 - arg_22_1.typewritterCharCountI18N) / var_25_14)

				if var_25_20 > 0 and var_25_15 < var_25_20 then
					arg_22_1.talkMaxDuration = var_25_20

					if var_25_20 + var_25_13 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_20 + var_25_13
					end
				end
			end

			local var_25_21 = 2.73333333333333
			local var_25_22 = math.max(var_25_21, arg_22_1.talkMaxDuration)

			if var_25_13 <= arg_22_1.time_ and arg_22_1.time_ < var_25_13 + var_25_22 then
				local var_25_23 = (arg_22_1.time_ - var_25_13) / var_25_22

				arg_22_1.fswtw_.percent = Mathf.Lerp(arg_22_1.var_.oldValueTypewriter, var_25_18, var_25_23)
				arg_22_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_22_1.fswtw_:SetDirty()
			end

			if arg_22_1.time_ >= var_25_13 + var_25_22 and arg_22_1.time_ < var_25_13 + var_25_22 + arg_25_0 then
				arg_22_1.fswtw_.percent = var_25_18

				arg_22_1.fswtw_:SetDirty()
				arg_22_1:ShowNextGo(true)

				arg_22_1.typewritterCharCountI18N = var_25_19
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play420012007 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 420012007
		arg_26_1.duration_ = 15.72

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play420012008(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = 0

			if var_29_0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_0 + arg_29_0 then
				arg_26_1.fswbg_:SetActive(true)
				arg_26_1.dialog_:SetActive(false)

				arg_26_1.fswtw_.percent = 0

				local var_29_1 = arg_26_1:GetWordFromCfg(420012007)
				local var_29_2 = arg_26_1:FormatText(var_29_1.content)

				arg_26_1.fswt_.text = var_29_2

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.fswt_)

				arg_26_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_26_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_26_1.fswtw_:SetDirty()

				arg_26_1.typewritterCharCountI18N = 0

				SetActive(arg_26_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_26_1:ShowNextGo(false)
			end

			local var_29_3 = 0.0166666666666667

			if var_29_3 < arg_26_1.time_ and arg_26_1.time_ <= var_29_3 + arg_29_0 then
				arg_26_1.var_.oldValueTypewriter = arg_26_1.fswtw_.percent

				SetActive(arg_26_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_26_1:ShowNextGo(false)
			end

			local var_29_4 = 37
			local var_29_5 = 2.46666666666667
			local var_29_6 = arg_26_1:GetWordFromCfg(420012007)
			local var_29_7 = arg_26_1:FormatText(var_29_6.content)
			local var_29_8, var_29_9 = arg_26_1:GetPercentByPara(var_29_7, 1)

			if var_29_3 < arg_26_1.time_ and arg_26_1.time_ <= var_29_3 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0

				local var_29_10 = var_29_4 <= 0 and var_29_5 or var_29_5 * ((var_29_9 - arg_26_1.typewritterCharCountI18N) / var_29_4)

				if var_29_10 > 0 and var_29_5 < var_29_10 then
					arg_26_1.talkMaxDuration = var_29_10

					if var_29_10 + var_29_3 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_10 + var_29_3
					end
				end
			end

			local var_29_11 = 2.46666666666667
			local var_29_12 = math.max(var_29_11, arg_26_1.talkMaxDuration)

			if var_29_3 <= arg_26_1.time_ and arg_26_1.time_ < var_29_3 + var_29_12 then
				local var_29_13 = (arg_26_1.time_ - var_29_3) / var_29_12

				arg_26_1.fswtw_.percent = Mathf.Lerp(arg_26_1.var_.oldValueTypewriter, var_29_8, var_29_13)
				arg_26_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_26_1.fswtw_:SetDirty()
			end

			if arg_26_1.time_ >= var_29_3 + var_29_12 and arg_26_1.time_ < var_29_3 + var_29_12 + arg_29_0 then
				arg_26_1.fswtw_.percent = var_29_8

				arg_26_1.fswtw_:SetDirty()
				arg_26_1:ShowNextGo(true)

				arg_26_1.typewritterCharCountI18N = var_29_9
			end

			local var_29_14 = 0.0166666666666667
			local var_29_15 = 15.7
			local var_29_16 = manager.audio:GetVoiceLength("story_v_out_420012", "420012007", "story_v_out_420012.awb") / 1000

			if var_29_16 > 0 and var_29_15 < var_29_16 and var_29_16 + var_29_14 > arg_26_1.duration_ then
				local var_29_17 = var_29_16

				arg_26_1.duration_ = var_29_16 + var_29_14
			end

			if var_29_14 < arg_26_1.time_ and arg_26_1.time_ <= var_29_14 + arg_29_0 then
				local var_29_18 = "play"
				local var_29_19 = "voice"

				arg_26_1:AudioAction(var_29_18, var_29_19, "story_v_out_420012", "420012007", "story_v_out_420012.awb")
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play420012008 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 420012008
		arg_30_1.duration_ = 8.28

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play420012009(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = 0.0166666666666667
			local var_33_1 = 8.266
			local var_33_2 = manager.audio:GetVoiceLength("story_v_out_420012", "420012008", "story_v_out_420012.awb") / 1000

			if var_33_2 > 0 and var_33_1 < var_33_2 and var_33_2 + var_33_0 > arg_30_1.duration_ then
				local var_33_3 = var_33_2

				arg_30_1.duration_ = var_33_2 + var_33_0
			end

			if var_33_0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_0 + arg_33_0 then
				local var_33_4 = "play"
				local var_33_5 = "voice"

				arg_30_1:AudioAction(var_33_4, var_33_5, "story_v_out_420012", "420012008", "story_v_out_420012.awb")
			end

			local var_33_6 = 0

			if var_33_6 < arg_30_1.time_ and arg_30_1.time_ <= var_33_6 + arg_33_0 then
				arg_30_1.fswbg_:SetActive(true)
				arg_30_1.dialog_:SetActive(false)

				arg_30_1.fswtw_.percent = 0

				local var_33_7 = arg_30_1:GetWordFromCfg(420012008)
				local var_33_8 = arg_30_1:FormatText(var_33_7.content)

				arg_30_1.fswt_.text = var_33_8

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.fswt_)

				arg_30_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_30_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_30_1.fswtw_:SetDirty()

				arg_30_1.typewritterCharCountI18N = 0

				SetActive(arg_30_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_30_1:ShowNextGo(false)
			end

			local var_33_9 = 0.0166666666666667

			if var_33_9 < arg_30_1.time_ and arg_30_1.time_ <= var_33_9 + arg_33_0 then
				arg_30_1.var_.oldValueTypewriter = arg_30_1.fswtw_.percent

				SetActive(arg_30_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_30_1:ShowNextGo(false)
			end

			local var_33_10 = 21
			local var_33_11 = 1.4
			local var_33_12 = arg_30_1:GetWordFromCfg(420012008)
			local var_33_13 = arg_30_1:FormatText(var_33_12.content)
			local var_33_14, var_33_15 = arg_30_1:GetPercentByPara(var_33_13, 1)

			if var_33_9 < arg_30_1.time_ and arg_30_1.time_ <= var_33_9 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0

				local var_33_16 = var_33_10 <= 0 and var_33_11 or var_33_11 * ((var_33_15 - arg_30_1.typewritterCharCountI18N) / var_33_10)

				if var_33_16 > 0 and var_33_11 < var_33_16 then
					arg_30_1.talkMaxDuration = var_33_16

					if var_33_16 + var_33_9 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_16 + var_33_9
					end
				end
			end

			local var_33_17 = 1.4
			local var_33_18 = math.max(var_33_17, arg_30_1.talkMaxDuration)

			if var_33_9 <= arg_30_1.time_ and arg_30_1.time_ < var_33_9 + var_33_18 then
				local var_33_19 = (arg_30_1.time_ - var_33_9) / var_33_18

				arg_30_1.fswtw_.percent = Mathf.Lerp(arg_30_1.var_.oldValueTypewriter, var_33_14, var_33_19)
				arg_30_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_30_1.fswtw_:SetDirty()
			end

			if arg_30_1.time_ >= var_33_9 + var_33_18 and arg_30_1.time_ < var_33_9 + var_33_18 + arg_33_0 then
				arg_30_1.fswtw_.percent = var_33_14

				arg_30_1.fswtw_:SetDirty()
				arg_30_1:ShowNextGo(true)

				arg_30_1.typewritterCharCountI18N = var_33_15
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play420012009 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 420012009
		arg_34_1.duration_ = 16.03

		local var_34_0 = {
			zh = 13.9333333333333,
			ja = 16.0333333333333
		}
		local var_34_1 = manager.audio:GetLocalizationFlag()

		if var_34_0[var_34_1] ~= nil then
			arg_34_1.duration_ = var_34_0[var_34_1]
		end

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play420012010(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = 6.73333333333333

			if var_37_0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_0 + arg_37_0 then
				arg_34_1.allBtn_.enabled = false
			end

			local var_37_1 = 0.3

			if arg_34_1.time_ >= var_37_0 + var_37_1 and arg_34_1.time_ < var_37_0 + var_37_1 + arg_37_0 then
				arg_34_1.allBtn_.enabled = true
			end

			local var_37_2 = 0
			local var_37_3 = 4.33333333333333
			local var_37_4 = "ST0505"

			if var_37_2 < arg_34_1.time_ and arg_34_1.time_ <= var_37_2 + arg_37_0 then
				arg_34_1.timestampController_:SetSelectedState("show")
				arg_34_1.timestampAni_:Play("in")

				arg_34_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_37_4)

				arg_34_1.timestampColorController_:SetSelectedState("hot")
				arg_34_1.timeColdImg_:SetAlpha(0.031)

				local var_37_5 = arg_34_1:GetWordFromCfg(501079)
				local var_37_6 = arg_34_1:FormatText(var_37_5.content)

				arg_34_1.text_timeText_.text = var_37_6

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_timeText_)

				local var_37_7 = arg_34_1:GetWordFromCfg(501080)
				local var_37_8 = arg_34_1:FormatText(var_37_7.content)

				arg_34_1.text_siteText_.text = var_37_8

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_siteText_)
			end

			if arg_34_1.time_ >= var_37_2 + var_37_3 and arg_34_1.time_ < var_37_2 + var_37_3 + arg_37_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_34_1.timestampAni_, "out", function()
					arg_34_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_37_9 = 4.33333333333333

			if var_37_9 < arg_34_1.time_ and arg_34_1.time_ <= var_37_9 + arg_37_0 then
				arg_34_1.mask_.enabled = true
				arg_34_1.mask_.raycastTarget = true

				arg_34_1:SetGaussion(false)
			end

			local var_37_10 = 1.2

			if var_37_9 <= arg_34_1.time_ and arg_34_1.time_ < var_37_9 + var_37_10 then
				local var_37_11 = (arg_34_1.time_ - var_37_9) / var_37_10
				local var_37_12 = Color.New(0, 0, 0)

				var_37_12.a = Mathf.Lerp(0, 1, var_37_11)
				arg_34_1.mask_.color = var_37_12
			end

			if arg_34_1.time_ >= var_37_9 + var_37_10 and arg_34_1.time_ < var_37_9 + var_37_10 + arg_37_0 then
				local var_37_13 = Color.New(0, 0, 0)

				var_37_13.a = 1
				arg_34_1.mask_.color = var_37_13
			end

			local var_37_14 = 5.53333333333333

			if var_37_14 < arg_34_1.time_ and arg_34_1.time_ <= var_37_14 + arg_37_0 then
				arg_34_1.mask_.enabled = true
				arg_34_1.mask_.raycastTarget = true

				arg_34_1:SetGaussion(false)
			end

			local var_37_15 = 1.2

			if var_37_14 <= arg_34_1.time_ and arg_34_1.time_ < var_37_14 + var_37_15 then
				local var_37_16 = (arg_34_1.time_ - var_37_14) / var_37_15
				local var_37_17 = Color.New(0, 0, 0)

				var_37_17.a = Mathf.Lerp(1, 0, var_37_16)
				arg_34_1.mask_.color = var_37_17
			end

			if arg_34_1.time_ >= var_37_14 + var_37_15 and arg_34_1.time_ < var_37_14 + var_37_15 + arg_37_0 then
				local var_37_18 = Color.New(0, 0, 0)
				local var_37_19 = 0

				arg_34_1.mask_.enabled = false
				var_37_18.a = var_37_19
				arg_34_1.mask_.color = var_37_18
			end

			local var_37_20 = "ST0505"

			if arg_34_1.bgs_[var_37_20] == nil then
				local var_37_21 = Object.Instantiate(arg_34_1.paintGo_)

				var_37_21:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_37_20)
				var_37_21.name = var_37_20
				var_37_21.transform.parent = arg_34_1.stage_.transform
				var_37_21.transform.localPosition = Vector3.New(0, 100, 0)
				arg_34_1.bgs_[var_37_20] = var_37_21
			end

			local var_37_22 = 0

			if var_37_22 < arg_34_1.time_ and arg_34_1.time_ <= var_37_22 + arg_37_0 then
				local var_37_23 = manager.ui.mainCamera.transform.localPosition
				local var_37_24 = Vector3.New(0, 0, 10) + Vector3.New(var_37_23.x, var_37_23.y, 0)
				local var_37_25 = arg_34_1.bgs_.ST0505

				var_37_25.transform.localPosition = var_37_24
				var_37_25.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_37_26 = var_37_25:GetComponent("SpriteRenderer")

				if var_37_26 and var_37_26.sprite then
					local var_37_27 = (var_37_25.transform.localPosition - var_37_23).z
					local var_37_28 = manager.ui.mainCameraCom_
					local var_37_29 = 2 * var_37_27 * Mathf.Tan(var_37_28.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_37_30 = var_37_29 * var_37_28.aspect
					local var_37_31 = var_37_26.sprite.bounds.size.x
					local var_37_32 = var_37_26.sprite.bounds.size.y
					local var_37_33 = var_37_30 / var_37_31
					local var_37_34 = var_37_29 / var_37_32
					local var_37_35 = var_37_34 < var_37_33 and var_37_33 or var_37_34

					var_37_25.transform.localScale = Vector3.New(var_37_35, var_37_35, 0)
				end

				for iter_37_0, iter_37_1 in pairs(arg_34_1.bgs_) do
					if iter_37_0 ~= "ST0505" then
						iter_37_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_37_36 = 0

			if var_37_36 < arg_34_1.time_ and arg_34_1.time_ <= var_37_36 + arg_37_0 then
				arg_34_1.cswbg_:SetActive(false)
			end

			local var_37_37 = 0

			if var_37_37 < arg_34_1.time_ and arg_34_1.time_ <= var_37_37 + arg_37_0 then
				arg_34_1.fswbg_:SetActive(false)
				arg_34_1.dialog_:SetActive(false)
				SetActive(arg_34_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_34_1:ShowNextGo(false)
			end

			local var_37_38 = 0.0333333333333333
			local var_37_39 = 1

			if var_37_38 < arg_34_1.time_ and arg_34_1.time_ <= var_37_38 + arg_37_0 then
				local var_37_40 = "play"
				local var_37_41 = "effect"

				arg_34_1:AudioAction(var_37_40, var_37_41, "se_story_140", "se_story_140_amb_room01", "")
			end

			local var_37_42 = 7.4
			local var_37_43 = 1

			if var_37_42 < arg_34_1.time_ and arg_34_1.time_ <= var_37_42 + arg_37_0 then
				local var_37_44 = "play"
				local var_37_45 = "effect"

				arg_34_1:AudioAction(var_37_44, var_37_45, "se_story_140", "se_story_140_data01", "")
			end

			local var_37_46 = 0
			local var_37_47 = 0.2

			if var_37_46 < arg_34_1.time_ and arg_34_1.time_ <= var_37_46 + arg_37_0 then
				local var_37_48 = "play"
				local var_37_49 = "music"

				arg_34_1:AudioAction(var_37_48, var_37_49, "ui_battle", "ui_battle_stopbgm", "")

				local var_37_50 = ""
				local var_37_51 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_37_51 ~= "" then
					if arg_34_1.bgmTxt_.text ~= var_37_51 and arg_34_1.bgmTxt_.text ~= "" then
						if arg_34_1.bgmTxt2_.text ~= "" then
							arg_34_1.bgmTxt_.text = arg_34_1.bgmTxt2_.text
						end

						arg_34_1.bgmTxt2_.text = var_37_51

						arg_34_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_34_1.bgmTxt_.text = var_37_51
						arg_34_1.bgmTxt2_.text = var_37_51
					end

					if arg_34_1.bgmTimer then
						arg_34_1.bgmTimer:Stop()

						arg_34_1.bgmTimer = nil
					end

					if arg_34_1.settingData.show_music_name == 1 then
						arg_34_1.musicController:SetSelectedState("show")
						arg_34_1.musicAnimator_:Play("open", 0, 0)

						if arg_34_1.settingData.music_time ~= 0 then
							arg_34_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_34_1.settingData.music_time), function()
								if arg_34_1 == nil or isNil(arg_34_1.bgmTxt_) then
									return
								end

								arg_34_1.musicController:SetSelectedState("hide")
								arg_34_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_37_52 = 5.14421350178309
			local var_37_53 = 0.991666666666666

			if var_37_52 < arg_34_1.time_ and arg_34_1.time_ <= var_37_52 + arg_37_0 then
				local var_37_54 = "play"
				local var_37_55 = "music"

				arg_34_1:AudioAction(var_37_54, var_37_55, "bgm_activity_4_0_story_daily", "bgm_activity_4_0_story_daily", "bgm_activity_4_0_story_daily.awb")

				local var_37_56 = ""
				local var_37_57 = manager.audio:GetAudioName("bgm_activity_4_0_story_daily", "bgm_activity_4_0_story_daily")

				if var_37_57 ~= "" then
					if arg_34_1.bgmTxt_.text ~= var_37_57 and arg_34_1.bgmTxt_.text ~= "" then
						if arg_34_1.bgmTxt2_.text ~= "" then
							arg_34_1.bgmTxt_.text = arg_34_1.bgmTxt2_.text
						end

						arg_34_1.bgmTxt2_.text = var_37_57

						arg_34_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_34_1.bgmTxt_.text = var_37_57
						arg_34_1.bgmTxt2_.text = var_37_57
					end

					if arg_34_1.bgmTimer then
						arg_34_1.bgmTimer:Stop()

						arg_34_1.bgmTimer = nil
					end

					if arg_34_1.settingData.show_music_name == 1 then
						arg_34_1.musicController:SetSelectedState("show")
						arg_34_1.musicAnimator_:Play("open", 0, 0)

						if arg_34_1.settingData.music_time ~= 0 then
							arg_34_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_34_1.settingData.music_time), function()
								if arg_34_1 == nil or isNil(arg_34_1.bgmTxt_) then
									return
								end

								arg_34_1.musicController:SetSelectedState("hide")
								arg_34_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_37_58 = "404001ui_story"

			if arg_34_1.actors_[var_37_58] == nil then
				local var_37_59 = Asset.Load("Char/" .. "404001ui_story")

				if not isNil(var_37_59) then
					local var_37_60 = Object.Instantiate(Asset.Load("Char/" .. "404001ui_story"), arg_34_1.stage_.transform)

					var_37_60.name = var_37_58
					var_37_60.transform.localPosition = Vector3.New(0, 100, 0)
					arg_34_1.actors_[var_37_58] = var_37_60

					local var_37_61 = var_37_60:GetComponentInChildren(typeof(CharacterEffect))

					var_37_61.enabled = true

					local var_37_62 = GameObjectTools.GetOrAddComponent(var_37_60, typeof(DynamicBoneHelper))

					if var_37_62 then
						var_37_62:EnableDynamicBone(false)
					end

					arg_34_1:ShowWeapon(var_37_61.transform, false)

					arg_34_1.var_[var_37_58 .. "Animator"] = var_37_61.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_34_1.var_[var_37_58 .. "Animator"].applyRootMotion = true
					arg_34_1.var_[var_37_58 .. "LipSync"] = var_37_61.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_37_63 = arg_34_1.actors_["404001ui_story"].transform
			local var_37_64 = 6.73333333333334

			if var_37_64 < arg_34_1.time_ and arg_34_1.time_ <= var_37_64 + arg_37_0 then
				arg_34_1.var_.moveOldPos404001ui_story = var_37_63.localPosition
			end

			local var_37_65 = 0.001

			if var_37_64 <= arg_34_1.time_ and arg_34_1.time_ < var_37_64 + var_37_65 then
				local var_37_66 = (arg_34_1.time_ - var_37_64) / var_37_65
				local var_37_67 = Vector3.New(0, -1.55, -5.5)

				var_37_63.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPos404001ui_story, var_37_67, var_37_66)

				local var_37_68 = manager.ui.mainCamera.transform.position - var_37_63.position

				var_37_63.forward = Vector3.New(var_37_68.x, var_37_68.y, var_37_68.z)

				local var_37_69 = var_37_63.localEulerAngles

				var_37_69.z = 0
				var_37_69.x = 0
				var_37_63.localEulerAngles = var_37_69
			end

			if arg_34_1.time_ >= var_37_64 + var_37_65 and arg_34_1.time_ < var_37_64 + var_37_65 + arg_37_0 then
				var_37_63.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_37_70 = manager.ui.mainCamera.transform.position - var_37_63.position

				var_37_63.forward = Vector3.New(var_37_70.x, var_37_70.y, var_37_70.z)

				local var_37_71 = var_37_63.localEulerAngles

				var_37_71.z = 0
				var_37_71.x = 0
				var_37_63.localEulerAngles = var_37_71
			end

			local var_37_72 = arg_34_1.actors_["404001ui_story"]
			local var_37_73 = 6.73333333333334

			if var_37_73 < arg_34_1.time_ and arg_34_1.time_ <= var_37_73 + arg_37_0 and not isNil(var_37_72) and arg_34_1.var_.characterEffect404001ui_story == nil then
				arg_34_1.var_.characterEffect404001ui_story = var_37_72:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_74 = 0.200000002980232

			if var_37_73 <= arg_34_1.time_ and arg_34_1.time_ < var_37_73 + var_37_74 and not isNil(var_37_72) then
				local var_37_75 = (arg_34_1.time_ - var_37_73) / var_37_74

				if arg_34_1.var_.characterEffect404001ui_story and not isNil(var_37_72) then
					arg_34_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_34_1.time_ >= var_37_73 + var_37_74 and arg_34_1.time_ < var_37_73 + var_37_74 + arg_37_0 and not isNil(var_37_72) and arg_34_1.var_.characterEffect404001ui_story then
				arg_34_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_37_76 = 6.73333333333334

			if var_37_76 < arg_34_1.time_ and arg_34_1.time_ <= var_37_76 + arg_37_0 then
				arg_34_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_37_77 = 6.73333333333334

			if var_37_77 < arg_34_1.time_ and arg_34_1.time_ <= var_37_77 + arg_37_0 then
				arg_34_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/expr_wuganA", "EmotionTimelineAnimator")
			end

			local var_37_78 = 0.0333333333333333

			if var_37_78 < arg_34_1.time_ and arg_34_1.time_ <= var_37_78 + arg_37_0 then
				arg_34_1.allBtn_.enabled = false
			end

			local var_37_79 = 6.73400000184775

			if arg_34_1.time_ >= var_37_78 + var_37_79 and arg_34_1.time_ < var_37_78 + var_37_79 + arg_37_0 then
				arg_34_1.allBtn_.enabled = true
			end

			if arg_34_1.frameCnt_ <= 1 then
				arg_34_1.dialog_:SetActive(false)
			end

			local var_37_80 = 6.73333333333333
			local var_37_81 = 0.725

			if var_37_80 < arg_34_1.time_ and arg_34_1.time_ <= var_37_80 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0

				arg_34_1.dialog_:SetActive(true)

				arg_34_1.dialogCg_.alpha = 0

				local var_37_82 = LeanTween.value(arg_34_1.dialog_, 0, 1, 0.3)

				var_37_82:setOnUpdate(LuaHelper.FloatAction(function(arg_41_0)
					arg_34_1.dialogCg_.alpha = arg_41_0
				end))
				var_37_82:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_34_1.dialog_)
					var_37_82:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_34_1.duration_ = arg_34_1.duration_ + 0.3

				SetActive(arg_34_1.leftNameGo_, true)

				local var_37_83 = arg_34_1:FormatText(StoryNameCfg[668].name)

				arg_34_1.leftNameTxt_.text = var_37_83

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_84 = arg_34_1:GetWordFromCfg(420012009)
				local var_37_85 = arg_34_1:FormatText(var_37_84.content)

				arg_34_1.text_.text = var_37_85

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_86 = 29
				local var_37_87 = utf8.len(var_37_85)
				local var_37_88 = var_37_86 <= 0 and var_37_81 or var_37_81 * (var_37_87 / var_37_86)

				if var_37_88 > 0 and var_37_81 < var_37_88 then
					arg_34_1.talkMaxDuration = var_37_88
					var_37_80 = var_37_80 + 0.3

					if var_37_88 + var_37_80 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_88 + var_37_80
					end
				end

				arg_34_1.text_.text = var_37_85
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012009", "story_v_out_420012.awb") ~= 0 then
					local var_37_89 = manager.audio:GetVoiceLength("story_v_out_420012", "420012009", "story_v_out_420012.awb") / 1000

					if var_37_89 + var_37_80 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_89 + var_37_80
					end

					if var_37_84.prefab_name ~= "" and arg_34_1.actors_[var_37_84.prefab_name] ~= nil then
						local var_37_90 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_84.prefab_name].transform, "story_v_out_420012", "420012009", "story_v_out_420012.awb")

						arg_34_1:RecordAudio("420012009", var_37_90)
						arg_34_1:RecordAudio("420012009", var_37_90)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_420012", "420012009", "story_v_out_420012.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_420012", "420012009", "story_v_out_420012.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_91 = var_37_80 + 0.3
			local var_37_92 = math.max(var_37_81, arg_34_1.talkMaxDuration)

			if var_37_91 <= arg_34_1.time_ and arg_34_1.time_ < var_37_91 + var_37_92 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_91) / var_37_92

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_91 + var_37_92 and arg_34_1.time_ < var_37_91 + var_37_92 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 6.73333333333334,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_34_1:InitPlayNodeList()
	end,
	Play420012010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 420012010
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play420012011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = arg_43_1.actors_["404001ui_story"].transform
			local var_46_1 = 0

			if var_46_1 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 then
				arg_43_1.var_.moveOldPos404001ui_story = var_46_0.localPosition
			end

			local var_46_2 = 0.001

			if var_46_1 <= arg_43_1.time_ and arg_43_1.time_ < var_46_1 + var_46_2 then
				local var_46_3 = (arg_43_1.time_ - var_46_1) / var_46_2
				local var_46_4 = Vector3.New(0, 100, 0)

				var_46_0.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos404001ui_story, var_46_4, var_46_3)

				local var_46_5 = manager.ui.mainCamera.transform.position - var_46_0.position

				var_46_0.forward = Vector3.New(var_46_5.x, var_46_5.y, var_46_5.z)

				local var_46_6 = var_46_0.localEulerAngles

				var_46_6.z = 0
				var_46_6.x = 0
				var_46_0.localEulerAngles = var_46_6
			end

			if arg_43_1.time_ >= var_46_1 + var_46_2 and arg_43_1.time_ < var_46_1 + var_46_2 + arg_46_0 then
				var_46_0.localPosition = Vector3.New(0, 100, 0)

				local var_46_7 = manager.ui.mainCamera.transform.position - var_46_0.position

				var_46_0.forward = Vector3.New(var_46_7.x, var_46_7.y, var_46_7.z)

				local var_46_8 = var_46_0.localEulerAngles

				var_46_8.z = 0
				var_46_8.x = 0
				var_46_0.localEulerAngles = var_46_8
			end

			local var_46_9 = 0
			local var_46_10 = 1.325

			if var_46_9 < arg_43_1.time_ and arg_43_1.time_ <= var_46_9 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, false)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_11 = arg_43_1:GetWordFromCfg(420012010)
				local var_46_12 = arg_43_1:FormatText(var_46_11.content)

				arg_43_1.text_.text = var_46_12

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_13 = 53
				local var_46_14 = utf8.len(var_46_12)
				local var_46_15 = var_46_13 <= 0 and var_46_10 or var_46_10 * (var_46_14 / var_46_13)

				if var_46_15 > 0 and var_46_10 < var_46_15 then
					arg_43_1.talkMaxDuration = var_46_15

					if var_46_15 + var_46_9 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_15 + var_46_9
					end
				end

				arg_43_1.text_.text = var_46_12
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_16 = math.max(var_46_10, arg_43_1.talkMaxDuration)

			if var_46_9 <= arg_43_1.time_ and arg_43_1.time_ < var_46_9 + var_46_16 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_9) / var_46_16

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_9 + var_46_16 and arg_43_1.time_ < var_46_9 + var_46_16 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_43_1:InitPlayNodeList()
	end,
	Play420012011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 420012011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play420012012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = 0
			local var_50_1 = 1.225

			if var_50_0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_0 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, false)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_2 = arg_47_1:GetWordFromCfg(420012011)
				local var_50_3 = arg_47_1:FormatText(var_50_2.content)

				arg_47_1.text_.text = var_50_3

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_4 = 49
				local var_50_5 = utf8.len(var_50_3)
				local var_50_6 = var_50_4 <= 0 and var_50_1 or var_50_1 * (var_50_5 / var_50_4)

				if var_50_6 > 0 and var_50_1 < var_50_6 then
					arg_47_1.talkMaxDuration = var_50_6

					if var_50_6 + var_50_0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_6 + var_50_0
					end
				end

				arg_47_1.text_.text = var_50_3
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_7 = math.max(var_50_1, arg_47_1.talkMaxDuration)

			if var_50_0 <= arg_47_1.time_ and arg_47_1.time_ < var_50_0 + var_50_7 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_0) / var_50_7

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_0 + var_50_7 and arg_47_1.time_ < var_50_0 + var_50_7 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play420012012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 420012012
		arg_51_1.duration_ = 5.67

		local var_51_0 = {
			zh = 4.5,
			ja = 5.666
		}
		local var_51_1 = manager.audio:GetLocalizationFlag()

		if var_51_0[var_51_1] ~= nil then
			arg_51_1.duration_ = var_51_0[var_51_1]
		end

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play420012013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = arg_51_1.actors_["404001ui_story"].transform
			local var_54_1 = 0

			if var_54_1 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 then
				arg_51_1.var_.moveOldPos404001ui_story = var_54_0.localPosition
			end

			local var_54_2 = 0.001

			if var_54_1 <= arg_51_1.time_ and arg_51_1.time_ < var_54_1 + var_54_2 then
				local var_54_3 = (arg_51_1.time_ - var_54_1) / var_54_2
				local var_54_4 = Vector3.New(0, -1.55, -5.5)

				var_54_0.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos404001ui_story, var_54_4, var_54_3)

				local var_54_5 = manager.ui.mainCamera.transform.position - var_54_0.position

				var_54_0.forward = Vector3.New(var_54_5.x, var_54_5.y, var_54_5.z)

				local var_54_6 = var_54_0.localEulerAngles

				var_54_6.z = 0
				var_54_6.x = 0
				var_54_0.localEulerAngles = var_54_6
			end

			if arg_51_1.time_ >= var_54_1 + var_54_2 and arg_51_1.time_ < var_54_1 + var_54_2 + arg_54_0 then
				var_54_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_54_7 = manager.ui.mainCamera.transform.position - var_54_0.position

				var_54_0.forward = Vector3.New(var_54_7.x, var_54_7.y, var_54_7.z)

				local var_54_8 = var_54_0.localEulerAngles

				var_54_8.z = 0
				var_54_8.x = 0
				var_54_0.localEulerAngles = var_54_8
			end

			local var_54_9 = arg_51_1.actors_["404001ui_story"]
			local var_54_10 = 0

			if var_54_10 < arg_51_1.time_ and arg_51_1.time_ <= var_54_10 + arg_54_0 and not isNil(var_54_9) and arg_51_1.var_.characterEffect404001ui_story == nil then
				arg_51_1.var_.characterEffect404001ui_story = var_54_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_11 = 0.200000002980232

			if var_54_10 <= arg_51_1.time_ and arg_51_1.time_ < var_54_10 + var_54_11 and not isNil(var_54_9) then
				local var_54_12 = (arg_51_1.time_ - var_54_10) / var_54_11

				if arg_51_1.var_.characterEffect404001ui_story and not isNil(var_54_9) then
					arg_51_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_51_1.time_ >= var_54_10 + var_54_11 and arg_51_1.time_ < var_54_10 + var_54_11 + arg_54_0 and not isNil(var_54_9) and arg_51_1.var_.characterEffect404001ui_story then
				arg_51_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_54_13 = 0

			if var_54_13 < arg_51_1.time_ and arg_51_1.time_ <= var_54_13 + arg_54_0 then
				arg_51_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_54_14 = 0

			if var_54_14 < arg_51_1.time_ and arg_51_1.time_ <= var_54_14 + arg_54_0 then
				arg_51_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_54_15 = 0
			local var_54_16 = 0.55

			if var_54_15 < arg_51_1.time_ and arg_51_1.time_ <= var_54_15 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_17 = arg_51_1:FormatText(StoryNameCfg[668].name)

				arg_51_1.leftNameTxt_.text = var_54_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_18 = arg_51_1:GetWordFromCfg(420012012)
				local var_54_19 = arg_51_1:FormatText(var_54_18.content)

				arg_51_1.text_.text = var_54_19

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_20 = 22
				local var_54_21 = utf8.len(var_54_19)
				local var_54_22 = var_54_20 <= 0 and var_54_16 or var_54_16 * (var_54_21 / var_54_20)

				if var_54_22 > 0 and var_54_16 < var_54_22 then
					arg_51_1.talkMaxDuration = var_54_22

					if var_54_22 + var_54_15 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_22 + var_54_15
					end
				end

				arg_51_1.text_.text = var_54_19
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012012", "story_v_out_420012.awb") ~= 0 then
					local var_54_23 = manager.audio:GetVoiceLength("story_v_out_420012", "420012012", "story_v_out_420012.awb") / 1000

					if var_54_23 + var_54_15 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_23 + var_54_15
					end

					if var_54_18.prefab_name ~= "" and arg_51_1.actors_[var_54_18.prefab_name] ~= nil then
						local var_54_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_18.prefab_name].transform, "story_v_out_420012", "420012012", "story_v_out_420012.awb")

						arg_51_1:RecordAudio("420012012", var_54_24)
						arg_51_1:RecordAudio("420012012", var_54_24)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_420012", "420012012", "story_v_out_420012.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_420012", "420012012", "story_v_out_420012.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_25 = math.max(var_54_16, arg_51_1.talkMaxDuration)

			if var_54_15 <= arg_51_1.time_ and arg_51_1.time_ < var_54_15 + var_54_25 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_15) / var_54_25

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_15 + var_54_25 and arg_51_1.time_ < var_54_15 + var_54_25 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_51_1:InitPlayNodeList()
	end,
	Play420012013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 420012013
		arg_55_1.duration_ = 4.27

		local var_55_0 = {
			zh = 3.266,
			ja = 4.266
		}
		local var_55_1 = manager.audio:GetLocalizationFlag()

		if var_55_0[var_55_1] ~= nil then
			arg_55_1.duration_ = var_55_0[var_55_1]
		end

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play420012014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0
			local var_58_1 = 0.45

			if var_58_0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_2 = arg_55_1:FormatText(StoryNameCfg[668].name)

				arg_55_1.leftNameTxt_.text = var_58_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_3 = arg_55_1:GetWordFromCfg(420012013)
				local var_58_4 = arg_55_1:FormatText(var_58_3.content)

				arg_55_1.text_.text = var_58_4

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_5 = 18
				local var_58_6 = utf8.len(var_58_4)
				local var_58_7 = var_58_5 <= 0 and var_58_1 or var_58_1 * (var_58_6 / var_58_5)

				if var_58_7 > 0 and var_58_1 < var_58_7 then
					arg_55_1.talkMaxDuration = var_58_7

					if var_58_7 + var_58_0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_7 + var_58_0
					end
				end

				arg_55_1.text_.text = var_58_4
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012013", "story_v_out_420012.awb") ~= 0 then
					local var_58_8 = manager.audio:GetVoiceLength("story_v_out_420012", "420012013", "story_v_out_420012.awb") / 1000

					if var_58_8 + var_58_0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_8 + var_58_0
					end

					if var_58_3.prefab_name ~= "" and arg_55_1.actors_[var_58_3.prefab_name] ~= nil then
						local var_58_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_3.prefab_name].transform, "story_v_out_420012", "420012013", "story_v_out_420012.awb")

						arg_55_1:RecordAudio("420012013", var_58_9)
						arg_55_1:RecordAudio("420012013", var_58_9)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_420012", "420012013", "story_v_out_420012.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_420012", "420012013", "story_v_out_420012.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_10 = math.max(var_58_1, arg_55_1.talkMaxDuration)

			if var_58_0 <= arg_55_1.time_ and arg_55_1.time_ < var_58_0 + var_58_10 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_0) / var_58_10

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_0 + var_58_10 and arg_55_1.time_ < var_58_0 + var_58_10 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play420012014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 420012014
		arg_59_1.duration_ = 2

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play420012015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = arg_59_1.actors_["404001ui_story"].transform
			local var_62_1 = 0

			if var_62_1 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 then
				arg_59_1.var_.moveOldPos404001ui_story = var_62_0.localPosition
			end

			local var_62_2 = 0.001

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_2 then
				local var_62_3 = (arg_59_1.time_ - var_62_1) / var_62_2
				local var_62_4 = Vector3.New(0, 100, 0)

				var_62_0.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos404001ui_story, var_62_4, var_62_3)

				local var_62_5 = manager.ui.mainCamera.transform.position - var_62_0.position

				var_62_0.forward = Vector3.New(var_62_5.x, var_62_5.y, var_62_5.z)

				local var_62_6 = var_62_0.localEulerAngles

				var_62_6.z = 0
				var_62_6.x = 0
				var_62_0.localEulerAngles = var_62_6
			end

			if arg_59_1.time_ >= var_62_1 + var_62_2 and arg_59_1.time_ < var_62_1 + var_62_2 + arg_62_0 then
				var_62_0.localPosition = Vector3.New(0, 100, 0)

				local var_62_7 = manager.ui.mainCamera.transform.position - var_62_0.position

				var_62_0.forward = Vector3.New(var_62_7.x, var_62_7.y, var_62_7.z)

				local var_62_8 = var_62_0.localEulerAngles

				var_62_8.z = 0
				var_62_8.x = 0
				var_62_0.localEulerAngles = var_62_8
			end

			local var_62_9 = "1085ui_story"

			if arg_59_1.actors_[var_62_9] == nil then
				local var_62_10 = Asset.Load("Char/" .. "1085ui_story")

				if not isNil(var_62_10) then
					local var_62_11 = Object.Instantiate(Asset.Load("Char/" .. "1085ui_story"), arg_59_1.stage_.transform)

					var_62_11.name = var_62_9
					var_62_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_59_1.actors_[var_62_9] = var_62_11

					local var_62_12 = var_62_11:GetComponentInChildren(typeof(CharacterEffect))

					var_62_12.enabled = true

					local var_62_13 = GameObjectTools.GetOrAddComponent(var_62_11, typeof(DynamicBoneHelper))

					if var_62_13 then
						var_62_13:EnableDynamicBone(false)
					end

					arg_59_1:ShowWeapon(var_62_12.transform, false)

					arg_59_1.var_[var_62_9 .. "Animator"] = var_62_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_59_1.var_[var_62_9 .. "Animator"].applyRootMotion = true
					arg_59_1.var_[var_62_9 .. "LipSync"] = var_62_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_62_14 = arg_59_1.actors_["1085ui_story"].transform
			local var_62_15 = 0

			if var_62_15 < arg_59_1.time_ and arg_59_1.time_ <= var_62_15 + arg_62_0 then
				arg_59_1.var_.moveOldPos1085ui_story = var_62_14.localPosition
			end

			local var_62_16 = 0.001

			if var_62_15 <= arg_59_1.time_ and arg_59_1.time_ < var_62_15 + var_62_16 then
				local var_62_17 = (arg_59_1.time_ - var_62_15) / var_62_16
				local var_62_18 = Vector3.New(0, -1.01, -5.83)

				var_62_14.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos1085ui_story, var_62_18, var_62_17)

				local var_62_19 = manager.ui.mainCamera.transform.position - var_62_14.position

				var_62_14.forward = Vector3.New(var_62_19.x, var_62_19.y, var_62_19.z)

				local var_62_20 = var_62_14.localEulerAngles

				var_62_20.z = 0
				var_62_20.x = 0
				var_62_14.localEulerAngles = var_62_20
			end

			if arg_59_1.time_ >= var_62_15 + var_62_16 and arg_59_1.time_ < var_62_15 + var_62_16 + arg_62_0 then
				var_62_14.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_62_21 = manager.ui.mainCamera.transform.position - var_62_14.position

				var_62_14.forward = Vector3.New(var_62_21.x, var_62_21.y, var_62_21.z)

				local var_62_22 = var_62_14.localEulerAngles

				var_62_22.z = 0
				var_62_22.x = 0
				var_62_14.localEulerAngles = var_62_22
			end

			local var_62_23 = arg_59_1.actors_["1085ui_story"]
			local var_62_24 = 0

			if var_62_24 < arg_59_1.time_ and arg_59_1.time_ <= var_62_24 + arg_62_0 and not isNil(var_62_23) and arg_59_1.var_.characterEffect1085ui_story == nil then
				arg_59_1.var_.characterEffect1085ui_story = var_62_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_25 = 0.200000002980232

			if var_62_24 <= arg_59_1.time_ and arg_59_1.time_ < var_62_24 + var_62_25 and not isNil(var_62_23) then
				local var_62_26 = (arg_59_1.time_ - var_62_24) / var_62_25

				if arg_59_1.var_.characterEffect1085ui_story and not isNil(var_62_23) then
					arg_59_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= var_62_24 + var_62_25 and arg_59_1.time_ < var_62_24 + var_62_25 + arg_62_0 and not isNil(var_62_23) and arg_59_1.var_.characterEffect1085ui_story then
				arg_59_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_62_27 = 0

			if var_62_27 < arg_59_1.time_ and arg_59_1.time_ <= var_62_27 + arg_62_0 then
				arg_59_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			local var_62_28 = 0

			if var_62_28 < arg_59_1.time_ and arg_59_1.time_ <= var_62_28 + arg_62_0 then
				arg_59_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_62_29 = 0
			local var_62_30 = 0.05

			if var_62_29 < arg_59_1.time_ and arg_59_1.time_ <= var_62_29 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_31 = arg_59_1:FormatText(StoryNameCfg[328].name)

				arg_59_1.leftNameTxt_.text = var_62_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_32 = arg_59_1:GetWordFromCfg(420012014)
				local var_62_33 = arg_59_1:FormatText(var_62_32.content)

				arg_59_1.text_.text = var_62_33

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_34 = 2
				local var_62_35 = utf8.len(var_62_33)
				local var_62_36 = var_62_34 <= 0 and var_62_30 or var_62_30 * (var_62_35 / var_62_34)

				if var_62_36 > 0 and var_62_30 < var_62_36 then
					arg_59_1.talkMaxDuration = var_62_36

					if var_62_36 + var_62_29 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_36 + var_62_29
					end
				end

				arg_59_1.text_.text = var_62_33
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012014", "story_v_out_420012.awb") ~= 0 then
					local var_62_37 = manager.audio:GetVoiceLength("story_v_out_420012", "420012014", "story_v_out_420012.awb") / 1000

					if var_62_37 + var_62_29 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_37 + var_62_29
					end

					if var_62_32.prefab_name ~= "" and arg_59_1.actors_[var_62_32.prefab_name] ~= nil then
						local var_62_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_32.prefab_name].transform, "story_v_out_420012", "420012014", "story_v_out_420012.awb")

						arg_59_1:RecordAudio("420012014", var_62_38)
						arg_59_1:RecordAudio("420012014", var_62_38)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_420012", "420012014", "story_v_out_420012.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_420012", "420012014", "story_v_out_420012.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_39 = math.max(var_62_30, arg_59_1.talkMaxDuration)

			if var_62_29 <= arg_59_1.time_ and arg_59_1.time_ < var_62_29 + var_62_39 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_29) / var_62_39

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_29 + var_62_39 and arg_59_1.time_ < var_62_29 + var_62_39 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_59_1:InitPlayNodeList()
	end,
	Play420012015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 420012015
		arg_63_1.duration_ = 2.1

		local var_63_0 = {
			zh = 1.5,
			ja = 2.1
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
				arg_63_0:Play420012016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = arg_63_1.actors_["404001ui_story"].transform
			local var_66_1 = 0

			if var_66_1 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 then
				arg_63_1.var_.moveOldPos404001ui_story = var_66_0.localPosition
			end

			local var_66_2 = 0.001

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_2 then
				local var_66_3 = (arg_63_1.time_ - var_66_1) / var_66_2
				local var_66_4 = Vector3.New(0, -1.55, -5.5)

				var_66_0.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos404001ui_story, var_66_4, var_66_3)

				local var_66_5 = manager.ui.mainCamera.transform.position - var_66_0.position

				var_66_0.forward = Vector3.New(var_66_5.x, var_66_5.y, var_66_5.z)

				local var_66_6 = var_66_0.localEulerAngles

				var_66_6.z = 0
				var_66_6.x = 0
				var_66_0.localEulerAngles = var_66_6
			end

			if arg_63_1.time_ >= var_66_1 + var_66_2 and arg_63_1.time_ < var_66_1 + var_66_2 + arg_66_0 then
				var_66_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_66_7 = manager.ui.mainCamera.transform.position - var_66_0.position

				var_66_0.forward = Vector3.New(var_66_7.x, var_66_7.y, var_66_7.z)

				local var_66_8 = var_66_0.localEulerAngles

				var_66_8.z = 0
				var_66_8.x = 0
				var_66_0.localEulerAngles = var_66_8
			end

			local var_66_9 = arg_63_1.actors_["1085ui_story"].transform
			local var_66_10 = 0

			if var_66_10 < arg_63_1.time_ and arg_63_1.time_ <= var_66_10 + arg_66_0 then
				arg_63_1.var_.moveOldPos1085ui_story = var_66_9.localPosition
			end

			local var_66_11 = 0.001

			if var_66_10 <= arg_63_1.time_ and arg_63_1.time_ < var_66_10 + var_66_11 then
				local var_66_12 = (arg_63_1.time_ - var_66_10) / var_66_11
				local var_66_13 = Vector3.New(0, 100, 0)

				var_66_9.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos1085ui_story, var_66_13, var_66_12)

				local var_66_14 = manager.ui.mainCamera.transform.position - var_66_9.position

				var_66_9.forward = Vector3.New(var_66_14.x, var_66_14.y, var_66_14.z)

				local var_66_15 = var_66_9.localEulerAngles

				var_66_15.z = 0
				var_66_15.x = 0
				var_66_9.localEulerAngles = var_66_15
			end

			if arg_63_1.time_ >= var_66_10 + var_66_11 and arg_63_1.time_ < var_66_10 + var_66_11 + arg_66_0 then
				var_66_9.localPosition = Vector3.New(0, 100, 0)

				local var_66_16 = manager.ui.mainCamera.transform.position - var_66_9.position

				var_66_9.forward = Vector3.New(var_66_16.x, var_66_16.y, var_66_16.z)

				local var_66_17 = var_66_9.localEulerAngles

				var_66_17.z = 0
				var_66_17.x = 0
				var_66_9.localEulerAngles = var_66_17
			end

			local var_66_18 = arg_63_1.actors_["404001ui_story"]
			local var_66_19 = 0

			if var_66_19 < arg_63_1.time_ and arg_63_1.time_ <= var_66_19 + arg_66_0 and not isNil(var_66_18) and arg_63_1.var_.characterEffect404001ui_story == nil then
				arg_63_1.var_.characterEffect404001ui_story = var_66_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_20 = 0.200000002980232

			if var_66_19 <= arg_63_1.time_ and arg_63_1.time_ < var_66_19 + var_66_20 and not isNil(var_66_18) then
				local var_66_21 = (arg_63_1.time_ - var_66_19) / var_66_20

				if arg_63_1.var_.characterEffect404001ui_story and not isNil(var_66_18) then
					arg_63_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_63_1.time_ >= var_66_19 + var_66_20 and arg_63_1.time_ < var_66_19 + var_66_20 + arg_66_0 and not isNil(var_66_18) and arg_63_1.var_.characterEffect404001ui_story then
				arg_63_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_66_22 = 0
			local var_66_23 = 0.2

			if var_66_22 < arg_63_1.time_ and arg_63_1.time_ <= var_66_22 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_24 = arg_63_1:FormatText(StoryNameCfg[668].name)

				arg_63_1.leftNameTxt_.text = var_66_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_25 = arg_63_1:GetWordFromCfg(420012015)
				local var_66_26 = arg_63_1:FormatText(var_66_25.content)

				arg_63_1.text_.text = var_66_26

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_27 = 8
				local var_66_28 = utf8.len(var_66_26)
				local var_66_29 = var_66_27 <= 0 and var_66_23 or var_66_23 * (var_66_28 / var_66_27)

				if var_66_29 > 0 and var_66_23 < var_66_29 then
					arg_63_1.talkMaxDuration = var_66_29

					if var_66_29 + var_66_22 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_29 + var_66_22
					end
				end

				arg_63_1.text_.text = var_66_26
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012015", "story_v_out_420012.awb") ~= 0 then
					local var_66_30 = manager.audio:GetVoiceLength("story_v_out_420012", "420012015", "story_v_out_420012.awb") / 1000

					if var_66_30 + var_66_22 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_30 + var_66_22
					end

					if var_66_25.prefab_name ~= "" and arg_63_1.actors_[var_66_25.prefab_name] ~= nil then
						local var_66_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_25.prefab_name].transform, "story_v_out_420012", "420012015", "story_v_out_420012.awb")

						arg_63_1:RecordAudio("420012015", var_66_31)
						arg_63_1:RecordAudio("420012015", var_66_31)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_420012", "420012015", "story_v_out_420012.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_420012", "420012015", "story_v_out_420012.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_32 = math.max(var_66_23, arg_63_1.talkMaxDuration)

			if var_66_22 <= arg_63_1.time_ and arg_63_1.time_ < var_66_22 + var_66_32 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_22) / var_66_32

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_22 + var_66_32 and arg_63_1.time_ < var_66_22 + var_66_32 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_63_1:InitPlayNodeList()
	end,
	Play420012016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 420012016
		arg_67_1.duration_ = 2

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play420012017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = arg_67_1.actors_["404001ui_story"].transform
			local var_70_1 = 0

			if var_70_1 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 then
				arg_67_1.var_.moveOldPos404001ui_story = var_70_0.localPosition
			end

			local var_70_2 = 0.001

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_2 then
				local var_70_3 = (arg_67_1.time_ - var_70_1) / var_70_2
				local var_70_4 = Vector3.New(0, 100, 0)

				var_70_0.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos404001ui_story, var_70_4, var_70_3)

				local var_70_5 = manager.ui.mainCamera.transform.position - var_70_0.position

				var_70_0.forward = Vector3.New(var_70_5.x, var_70_5.y, var_70_5.z)

				local var_70_6 = var_70_0.localEulerAngles

				var_70_6.z = 0
				var_70_6.x = 0
				var_70_0.localEulerAngles = var_70_6
			end

			if arg_67_1.time_ >= var_70_1 + var_70_2 and arg_67_1.time_ < var_70_1 + var_70_2 + arg_70_0 then
				var_70_0.localPosition = Vector3.New(0, 100, 0)

				local var_70_7 = manager.ui.mainCamera.transform.position - var_70_0.position

				var_70_0.forward = Vector3.New(var_70_7.x, var_70_7.y, var_70_7.z)

				local var_70_8 = var_70_0.localEulerAngles

				var_70_8.z = 0
				var_70_8.x = 0
				var_70_0.localEulerAngles = var_70_8
			end

			local var_70_9 = arg_67_1.actors_["1085ui_story"].transform
			local var_70_10 = 0

			if var_70_10 < arg_67_1.time_ and arg_67_1.time_ <= var_70_10 + arg_70_0 then
				arg_67_1.var_.moveOldPos1085ui_story = var_70_9.localPosition
			end

			local var_70_11 = 0.001

			if var_70_10 <= arg_67_1.time_ and arg_67_1.time_ < var_70_10 + var_70_11 then
				local var_70_12 = (arg_67_1.time_ - var_70_10) / var_70_11
				local var_70_13 = Vector3.New(0, -1.01, -5.83)

				var_70_9.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1085ui_story, var_70_13, var_70_12)

				local var_70_14 = manager.ui.mainCamera.transform.position - var_70_9.position

				var_70_9.forward = Vector3.New(var_70_14.x, var_70_14.y, var_70_14.z)

				local var_70_15 = var_70_9.localEulerAngles

				var_70_15.z = 0
				var_70_15.x = 0
				var_70_9.localEulerAngles = var_70_15
			end

			if arg_67_1.time_ >= var_70_10 + var_70_11 and arg_67_1.time_ < var_70_10 + var_70_11 + arg_70_0 then
				var_70_9.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_70_16 = manager.ui.mainCamera.transform.position - var_70_9.position

				var_70_9.forward = Vector3.New(var_70_16.x, var_70_16.y, var_70_16.z)

				local var_70_17 = var_70_9.localEulerAngles

				var_70_17.z = 0
				var_70_17.x = 0
				var_70_9.localEulerAngles = var_70_17
			end

			local var_70_18 = arg_67_1.actors_["1085ui_story"]
			local var_70_19 = 0

			if var_70_19 < arg_67_1.time_ and arg_67_1.time_ <= var_70_19 + arg_70_0 and not isNil(var_70_18) and arg_67_1.var_.characterEffect1085ui_story == nil then
				arg_67_1.var_.characterEffect1085ui_story = var_70_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_20 = 0.200000002980232

			if var_70_19 <= arg_67_1.time_ and arg_67_1.time_ < var_70_19 + var_70_20 and not isNil(var_70_18) then
				local var_70_21 = (arg_67_1.time_ - var_70_19) / var_70_20

				if arg_67_1.var_.characterEffect1085ui_story and not isNil(var_70_18) then
					arg_67_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= var_70_19 + var_70_20 and arg_67_1.time_ < var_70_19 + var_70_20 + arg_70_0 and not isNil(var_70_18) and arg_67_1.var_.characterEffect1085ui_story then
				arg_67_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_70_22 = 0

			if var_70_22 < arg_67_1.time_ and arg_67_1.time_ <= var_70_22 + arg_70_0 then
				arg_67_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action4_1")
			end

			local var_70_23 = 0

			if var_70_23 < arg_67_1.time_ and arg_67_1.time_ <= var_70_23 + arg_70_0 then
				arg_67_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_70_24 = 0
			local var_70_25 = 0.175

			if var_70_24 < arg_67_1.time_ and arg_67_1.time_ <= var_70_24 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_26 = arg_67_1:FormatText(StoryNameCfg[328].name)

				arg_67_1.leftNameTxt_.text = var_70_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_27 = arg_67_1:GetWordFromCfg(420012016)
				local var_70_28 = arg_67_1:FormatText(var_70_27.content)

				arg_67_1.text_.text = var_70_28

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_29 = 7
				local var_70_30 = utf8.len(var_70_28)
				local var_70_31 = var_70_29 <= 0 and var_70_25 or var_70_25 * (var_70_30 / var_70_29)

				if var_70_31 > 0 and var_70_25 < var_70_31 then
					arg_67_1.talkMaxDuration = var_70_31

					if var_70_31 + var_70_24 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_31 + var_70_24
					end
				end

				arg_67_1.text_.text = var_70_28
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012016", "story_v_out_420012.awb") ~= 0 then
					local var_70_32 = manager.audio:GetVoiceLength("story_v_out_420012", "420012016", "story_v_out_420012.awb") / 1000

					if var_70_32 + var_70_24 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_32 + var_70_24
					end

					if var_70_27.prefab_name ~= "" and arg_67_1.actors_[var_70_27.prefab_name] ~= nil then
						local var_70_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_27.prefab_name].transform, "story_v_out_420012", "420012016", "story_v_out_420012.awb")

						arg_67_1:RecordAudio("420012016", var_70_33)
						arg_67_1:RecordAudio("420012016", var_70_33)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_420012", "420012016", "story_v_out_420012.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_420012", "420012016", "story_v_out_420012.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_34 = math.max(var_70_25, arg_67_1.talkMaxDuration)

			if var_70_24 <= arg_67_1.time_ and arg_67_1.time_ < var_70_24 + var_70_34 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_24) / var_70_34

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_24 + var_70_34 and arg_67_1.time_ < var_70_24 + var_70_34 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
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
	Play420012017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 420012017
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play420012018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = arg_71_1.actors_["1085ui_story"].transform
			local var_74_1 = 0

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 then
				arg_71_1.var_.moveOldPos1085ui_story = var_74_0.localPosition
			end

			local var_74_2 = 0.001

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_2 then
				local var_74_3 = (arg_71_1.time_ - var_74_1) / var_74_2
				local var_74_4 = Vector3.New(0, 100, 0)

				var_74_0.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1085ui_story, var_74_4, var_74_3)

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

			local var_74_9 = 0.034000001847744
			local var_74_10 = 1

			if var_74_9 < arg_71_1.time_ and arg_71_1.time_ <= var_74_9 + arg_74_0 then
				local var_74_11 = "play"
				local var_74_12 = "effect"

				arg_71_1:AudioAction(var_74_11, var_74_12, "se_story_3", "se_story_3_data", "")
			end

			local var_74_13 = 0
			local var_74_14 = 0.9

			if var_74_13 < arg_71_1.time_ and arg_71_1.time_ <= var_74_13 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, false)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_15 = arg_71_1:GetWordFromCfg(420012017)
				local var_74_16 = arg_71_1:FormatText(var_74_15.content)

				arg_71_1.text_.text = var_74_16

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_17 = 36
				local var_74_18 = utf8.len(var_74_16)
				local var_74_19 = var_74_17 <= 0 and var_74_14 or var_74_14 * (var_74_18 / var_74_17)

				if var_74_19 > 0 and var_74_14 < var_74_19 then
					arg_71_1.talkMaxDuration = var_74_19

					if var_74_19 + var_74_13 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_19 + var_74_13
					end
				end

				arg_71_1.text_.text = var_74_16
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_20 = math.max(var_74_14, arg_71_1.talkMaxDuration)

			if var_74_13 <= arg_71_1.time_ and arg_71_1.time_ < var_74_13 + var_74_20 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_13) / var_74_20

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_13 + var_74_20 and arg_71_1.time_ < var_74_13 + var_74_20 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_71_1:InitPlayNodeList()
	end,
	Play420012018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 420012018
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play420012019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0.1
			local var_78_1 = 1

			if var_78_0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_0 + arg_78_0 then
				local var_78_2 = "play"
				local var_78_3 = "effect"

				arg_75_1:AudioAction(var_78_2, var_78_3, "se_story_140", "se_story_140_machine", "")
			end

			local var_78_4 = 2.1
			local var_78_5 = 1

			if var_78_4 < arg_75_1.time_ and arg_75_1.time_ <= var_78_4 + arg_78_0 then
				local var_78_6 = "play"
				local var_78_7 = "effect"

				arg_75_1:AudioAction(var_78_6, var_78_7, "se_story_140", "se_story_140_curtain01", "")
			end

			local var_78_8 = 0
			local var_78_9 = 1.6

			if var_78_8 < arg_75_1.time_ and arg_75_1.time_ <= var_78_8 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, false)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_10 = arg_75_1:GetWordFromCfg(420012018)
				local var_78_11 = arg_75_1:FormatText(var_78_10.content)

				arg_75_1.text_.text = var_78_11

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_12 = 64
				local var_78_13 = utf8.len(var_78_11)
				local var_78_14 = var_78_12 <= 0 and var_78_9 or var_78_9 * (var_78_13 / var_78_12)

				if var_78_14 > 0 and var_78_9 < var_78_14 then
					arg_75_1.talkMaxDuration = var_78_14

					if var_78_14 + var_78_8 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_14 + var_78_8
					end
				end

				arg_75_1.text_.text = var_78_11
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_15 = math.max(var_78_9, arg_75_1.talkMaxDuration)

			if var_78_8 <= arg_75_1.time_ and arg_75_1.time_ < var_78_8 + var_78_15 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_8) / var_78_15

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_8 + var_78_15 and arg_75_1.time_ < var_78_8 + var_78_15 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play420012019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 420012019
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play420012020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0
			local var_82_1 = 1.45

			if var_82_0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_2 = arg_79_1:GetWordFromCfg(420012019)
				local var_82_3 = arg_79_1:FormatText(var_82_2.content)

				arg_79_1.text_.text = var_82_3

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_4 = 58
				local var_82_5 = utf8.len(var_82_3)
				local var_82_6 = var_82_4 <= 0 and var_82_1 or var_82_1 * (var_82_5 / var_82_4)

				if var_82_6 > 0 and var_82_1 < var_82_6 then
					arg_79_1.talkMaxDuration = var_82_6

					if var_82_6 + var_82_0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_6 + var_82_0
					end
				end

				arg_79_1.text_.text = var_82_3
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_7 = math.max(var_82_1, arg_79_1.talkMaxDuration)

			if var_82_0 <= arg_79_1.time_ and arg_79_1.time_ < var_82_0 + var_82_7 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_0) / var_82_7

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_0 + var_82_7 and arg_79_1.time_ < var_82_0 + var_82_7 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play420012020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 420012020
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play420012021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 0
			local var_86_1 = 1.475

			if var_86_0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_2 = arg_83_1:GetWordFromCfg(420012020)
				local var_86_3 = arg_83_1:FormatText(var_86_2.content)

				arg_83_1.text_.text = var_86_3

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_4 = 59
				local var_86_5 = utf8.len(var_86_3)
				local var_86_6 = var_86_4 <= 0 and var_86_1 or var_86_1 * (var_86_5 / var_86_4)

				if var_86_6 > 0 and var_86_1 < var_86_6 then
					arg_83_1.talkMaxDuration = var_86_6

					if var_86_6 + var_86_0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_6 + var_86_0
					end
				end

				arg_83_1.text_.text = var_86_3
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_7 = math.max(var_86_1, arg_83_1.talkMaxDuration)

			if var_86_0 <= arg_83_1.time_ and arg_83_1.time_ < var_86_0 + var_86_7 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_0) / var_86_7

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_0 + var_86_7 and arg_83_1.time_ < var_86_0 + var_86_7 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play420012021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 420012021
		arg_87_1.duration_ = 4.53

		local var_87_0 = {
			zh = 4.2,
			ja = 4.533
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
				arg_87_0:Play420012022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = arg_87_1.actors_["404001ui_story"].transform
			local var_90_1 = 0

			if var_90_1 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 then
				arg_87_1.var_.moveOldPos404001ui_story = var_90_0.localPosition
			end

			local var_90_2 = 0.001

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_2 then
				local var_90_3 = (arg_87_1.time_ - var_90_1) / var_90_2
				local var_90_4 = Vector3.New(0, -1.55, -5.5)

				var_90_0.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos404001ui_story, var_90_4, var_90_3)

				local var_90_5 = manager.ui.mainCamera.transform.position - var_90_0.position

				var_90_0.forward = Vector3.New(var_90_5.x, var_90_5.y, var_90_5.z)

				local var_90_6 = var_90_0.localEulerAngles

				var_90_6.z = 0
				var_90_6.x = 0
				var_90_0.localEulerAngles = var_90_6
			end

			if arg_87_1.time_ >= var_90_1 + var_90_2 and arg_87_1.time_ < var_90_1 + var_90_2 + arg_90_0 then
				var_90_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_90_7 = manager.ui.mainCamera.transform.position - var_90_0.position

				var_90_0.forward = Vector3.New(var_90_7.x, var_90_7.y, var_90_7.z)

				local var_90_8 = var_90_0.localEulerAngles

				var_90_8.z = 0
				var_90_8.x = 0
				var_90_0.localEulerAngles = var_90_8
			end

			local var_90_9 = arg_87_1.actors_["404001ui_story"]
			local var_90_10 = 0

			if var_90_10 < arg_87_1.time_ and arg_87_1.time_ <= var_90_10 + arg_90_0 and not isNil(var_90_9) and arg_87_1.var_.characterEffect404001ui_story == nil then
				arg_87_1.var_.characterEffect404001ui_story = var_90_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_11 = 0.200000002980232

			if var_90_10 <= arg_87_1.time_ and arg_87_1.time_ < var_90_10 + var_90_11 and not isNil(var_90_9) then
				local var_90_12 = (arg_87_1.time_ - var_90_10) / var_90_11

				if arg_87_1.var_.characterEffect404001ui_story and not isNil(var_90_9) then
					arg_87_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= var_90_10 + var_90_11 and arg_87_1.time_ < var_90_10 + var_90_11 + arg_90_0 and not isNil(var_90_9) and arg_87_1.var_.characterEffect404001ui_story then
				arg_87_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_90_13 = 0
			local var_90_14 = 0.525

			if var_90_13 < arg_87_1.time_ and arg_87_1.time_ <= var_90_13 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_15 = arg_87_1:FormatText(StoryNameCfg[668].name)

				arg_87_1.leftNameTxt_.text = var_90_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_16 = arg_87_1:GetWordFromCfg(420012021)
				local var_90_17 = arg_87_1:FormatText(var_90_16.content)

				arg_87_1.text_.text = var_90_17

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_18 = 21
				local var_90_19 = utf8.len(var_90_17)
				local var_90_20 = var_90_18 <= 0 and var_90_14 or var_90_14 * (var_90_19 / var_90_18)

				if var_90_20 > 0 and var_90_14 < var_90_20 then
					arg_87_1.talkMaxDuration = var_90_20

					if var_90_20 + var_90_13 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_20 + var_90_13
					end
				end

				arg_87_1.text_.text = var_90_17
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012021", "story_v_out_420012.awb") ~= 0 then
					local var_90_21 = manager.audio:GetVoiceLength("story_v_out_420012", "420012021", "story_v_out_420012.awb") / 1000

					if var_90_21 + var_90_13 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_21 + var_90_13
					end

					if var_90_16.prefab_name ~= "" and arg_87_1.actors_[var_90_16.prefab_name] ~= nil then
						local var_90_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_16.prefab_name].transform, "story_v_out_420012", "420012021", "story_v_out_420012.awb")

						arg_87_1:RecordAudio("420012021", var_90_22)
						arg_87_1:RecordAudio("420012021", var_90_22)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_420012", "420012021", "story_v_out_420012.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_420012", "420012021", "story_v_out_420012.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_23 = math.max(var_90_14, arg_87_1.talkMaxDuration)

			if var_90_13 <= arg_87_1.time_ and arg_87_1.time_ < var_90_13 + var_90_23 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_13) / var_90_23

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_13 + var_90_23 and arg_87_1.time_ < var_90_13 + var_90_23 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_87_1:InitPlayNodeList()
	end,
	Play420012022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 420012022
		arg_91_1.duration_ = 6.07

		local var_91_0 = {
			zh = 3.3,
			ja = 6.066
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
				arg_91_0:Play420012023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 0

			if var_94_0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_0 + arg_94_0 then
				arg_91_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 then
				arg_91_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_1")
			end

			local var_94_2 = 0
			local var_94_3 = 0.45

			if var_94_2 < arg_91_1.time_ and arg_91_1.time_ <= var_94_2 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_4 = arg_91_1:FormatText(StoryNameCfg[668].name)

				arg_91_1.leftNameTxt_.text = var_94_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_5 = arg_91_1:GetWordFromCfg(420012022)
				local var_94_6 = arg_91_1:FormatText(var_94_5.content)

				arg_91_1.text_.text = var_94_6

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_7 = 18
				local var_94_8 = utf8.len(var_94_6)
				local var_94_9 = var_94_7 <= 0 and var_94_3 or var_94_3 * (var_94_8 / var_94_7)

				if var_94_9 > 0 and var_94_3 < var_94_9 then
					arg_91_1.talkMaxDuration = var_94_9

					if var_94_9 + var_94_2 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_9 + var_94_2
					end
				end

				arg_91_1.text_.text = var_94_6
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012022", "story_v_out_420012.awb") ~= 0 then
					local var_94_10 = manager.audio:GetVoiceLength("story_v_out_420012", "420012022", "story_v_out_420012.awb") / 1000

					if var_94_10 + var_94_2 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_10 + var_94_2
					end

					if var_94_5.prefab_name ~= "" and arg_91_1.actors_[var_94_5.prefab_name] ~= nil then
						local var_94_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_5.prefab_name].transform, "story_v_out_420012", "420012022", "story_v_out_420012.awb")

						arg_91_1:RecordAudio("420012022", var_94_11)
						arg_91_1:RecordAudio("420012022", var_94_11)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_420012", "420012022", "story_v_out_420012.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_420012", "420012022", "story_v_out_420012.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_12 = math.max(var_94_3, arg_91_1.talkMaxDuration)

			if var_94_2 <= arg_91_1.time_ and arg_91_1.time_ < var_94_2 + var_94_12 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_2) / var_94_12

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_2 + var_94_12 and arg_91_1.time_ < var_94_2 + var_94_12 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play420012023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 420012023
		arg_95_1.duration_ = 3.6

		local var_95_0 = {
			zh = 3.133,
			ja = 3.6
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
				arg_95_0:Play420012024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = arg_95_1.actors_["404001ui_story"].transform
			local var_98_1 = 0

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 then
				arg_95_1.var_.moveOldPos404001ui_story = var_98_0.localPosition
			end

			local var_98_2 = 0.001

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_2 then
				local var_98_3 = (arg_95_1.time_ - var_98_1) / var_98_2
				local var_98_4 = Vector3.New(-0.8, -1.55, -5.5)

				var_98_0.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos404001ui_story, var_98_4, var_98_3)

				local var_98_5 = manager.ui.mainCamera.transform.position - var_98_0.position

				var_98_0.forward = Vector3.New(var_98_5.x, var_98_5.y, var_98_5.z)

				local var_98_6 = var_98_0.localEulerAngles

				var_98_6.z = 0
				var_98_6.x = 0
				var_98_0.localEulerAngles = var_98_6
			end

			if arg_95_1.time_ >= var_98_1 + var_98_2 and arg_95_1.time_ < var_98_1 + var_98_2 + arg_98_0 then
				var_98_0.localPosition = Vector3.New(-0.8, -1.55, -5.5)

				local var_98_7 = manager.ui.mainCamera.transform.position - var_98_0.position

				var_98_0.forward = Vector3.New(var_98_7.x, var_98_7.y, var_98_7.z)

				local var_98_8 = var_98_0.localEulerAngles

				var_98_8.z = 0
				var_98_8.x = 0
				var_98_0.localEulerAngles = var_98_8
			end

			local var_98_9 = arg_95_1.actors_["1085ui_story"].transform
			local var_98_10 = 0

			if var_98_10 < arg_95_1.time_ and arg_95_1.time_ <= var_98_10 + arg_98_0 then
				arg_95_1.var_.moveOldPos1085ui_story = var_98_9.localPosition
			end

			local var_98_11 = 0.001

			if var_98_10 <= arg_95_1.time_ and arg_95_1.time_ < var_98_10 + var_98_11 then
				local var_98_12 = (arg_95_1.time_ - var_98_10) / var_98_11
				local var_98_13 = Vector3.New(0.75, -1.01, -5.83)

				var_98_9.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1085ui_story, var_98_13, var_98_12)

				local var_98_14 = manager.ui.mainCamera.transform.position - var_98_9.position

				var_98_9.forward = Vector3.New(var_98_14.x, var_98_14.y, var_98_14.z)

				local var_98_15 = var_98_9.localEulerAngles

				var_98_15.z = 0
				var_98_15.x = 0
				var_98_9.localEulerAngles = var_98_15
			end

			if arg_95_1.time_ >= var_98_10 + var_98_11 and arg_95_1.time_ < var_98_10 + var_98_11 + arg_98_0 then
				var_98_9.localPosition = Vector3.New(0.75, -1.01, -5.83)

				local var_98_16 = manager.ui.mainCamera.transform.position - var_98_9.position

				var_98_9.forward = Vector3.New(var_98_16.x, var_98_16.y, var_98_16.z)

				local var_98_17 = var_98_9.localEulerAngles

				var_98_17.z = 0
				var_98_17.x = 0
				var_98_9.localEulerAngles = var_98_17
			end

			local var_98_18 = arg_95_1.actors_["1085ui_story"]
			local var_98_19 = 0

			if var_98_19 < arg_95_1.time_ and arg_95_1.time_ <= var_98_19 + arg_98_0 and not isNil(var_98_18) and arg_95_1.var_.characterEffect1085ui_story == nil then
				arg_95_1.var_.characterEffect1085ui_story = var_98_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_20 = 0.200000002980232

			if var_98_19 <= arg_95_1.time_ and arg_95_1.time_ < var_98_19 + var_98_20 and not isNil(var_98_18) then
				local var_98_21 = (arg_95_1.time_ - var_98_19) / var_98_20

				if arg_95_1.var_.characterEffect1085ui_story and not isNil(var_98_18) then
					arg_95_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= var_98_19 + var_98_20 and arg_95_1.time_ < var_98_19 + var_98_20 + arg_98_0 and not isNil(var_98_18) and arg_95_1.var_.characterEffect1085ui_story then
				arg_95_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_98_22 = arg_95_1.actors_["404001ui_story"]
			local var_98_23 = 0

			if var_98_23 < arg_95_1.time_ and arg_95_1.time_ <= var_98_23 + arg_98_0 and not isNil(var_98_22) and arg_95_1.var_.characterEffect404001ui_story == nil then
				arg_95_1.var_.characterEffect404001ui_story = var_98_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_24 = 0.200000002980232

			if var_98_23 <= arg_95_1.time_ and arg_95_1.time_ < var_98_23 + var_98_24 and not isNil(var_98_22) then
				local var_98_25 = (arg_95_1.time_ - var_98_23) / var_98_24

				if arg_95_1.var_.characterEffect404001ui_story and not isNil(var_98_22) then
					local var_98_26 = Mathf.Lerp(0, 0.5, var_98_25)

					arg_95_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_95_1.var_.characterEffect404001ui_story.fillRatio = var_98_26
				end
			end

			if arg_95_1.time_ >= var_98_23 + var_98_24 and arg_95_1.time_ < var_98_23 + var_98_24 + arg_98_0 and not isNil(var_98_22) and arg_95_1.var_.characterEffect404001ui_story then
				local var_98_27 = 0.5

				arg_95_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_95_1.var_.characterEffect404001ui_story.fillRatio = var_98_27
			end

			local var_98_28 = 0
			local var_98_29 = 0.25

			if var_98_28 < arg_95_1.time_ and arg_95_1.time_ <= var_98_28 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_30 = arg_95_1:FormatText(StoryNameCfg[328].name)

				arg_95_1.leftNameTxt_.text = var_98_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_31 = arg_95_1:GetWordFromCfg(420012023)
				local var_98_32 = arg_95_1:FormatText(var_98_31.content)

				arg_95_1.text_.text = var_98_32

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_33 = 10
				local var_98_34 = utf8.len(var_98_32)
				local var_98_35 = var_98_33 <= 0 and var_98_29 or var_98_29 * (var_98_34 / var_98_33)

				if var_98_35 > 0 and var_98_29 < var_98_35 then
					arg_95_1.talkMaxDuration = var_98_35

					if var_98_35 + var_98_28 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_35 + var_98_28
					end
				end

				arg_95_1.text_.text = var_98_32
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012023", "story_v_out_420012.awb") ~= 0 then
					local var_98_36 = manager.audio:GetVoiceLength("story_v_out_420012", "420012023", "story_v_out_420012.awb") / 1000

					if var_98_36 + var_98_28 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_36 + var_98_28
					end

					if var_98_31.prefab_name ~= "" and arg_95_1.actors_[var_98_31.prefab_name] ~= nil then
						local var_98_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_31.prefab_name].transform, "story_v_out_420012", "420012023", "story_v_out_420012.awb")

						arg_95_1:RecordAudio("420012023", var_98_37)
						arg_95_1:RecordAudio("420012023", var_98_37)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_420012", "420012023", "story_v_out_420012.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_420012", "420012023", "story_v_out_420012.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_38 = math.max(var_98_29, arg_95_1.talkMaxDuration)

			if var_98_28 <= arg_95_1.time_ and arg_95_1.time_ < var_98_28 + var_98_38 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_28) / var_98_38

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_28 + var_98_38 and arg_95_1.time_ < var_98_28 + var_98_38 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_95_1:InitPlayNodeList()
	end,
	Play420012024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 420012024
		arg_99_1.duration_ = 11.13

		local var_99_0 = {
			zh = 8.633,
			ja = 11.133
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
				arg_99_0:Play420012025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0
			local var_102_1 = 0.75

			if var_102_0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_2 = arg_99_1:FormatText(StoryNameCfg[328].name)

				arg_99_1.leftNameTxt_.text = var_102_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_3 = arg_99_1:GetWordFromCfg(420012024)
				local var_102_4 = arg_99_1:FormatText(var_102_3.content)

				arg_99_1.text_.text = var_102_4

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_5 = 30
				local var_102_6 = utf8.len(var_102_4)
				local var_102_7 = var_102_5 <= 0 and var_102_1 or var_102_1 * (var_102_6 / var_102_5)

				if var_102_7 > 0 and var_102_1 < var_102_7 then
					arg_99_1.talkMaxDuration = var_102_7

					if var_102_7 + var_102_0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_7 + var_102_0
					end
				end

				arg_99_1.text_.text = var_102_4
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012024", "story_v_out_420012.awb") ~= 0 then
					local var_102_8 = manager.audio:GetVoiceLength("story_v_out_420012", "420012024", "story_v_out_420012.awb") / 1000

					if var_102_8 + var_102_0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_8 + var_102_0
					end

					if var_102_3.prefab_name ~= "" and arg_99_1.actors_[var_102_3.prefab_name] ~= nil then
						local var_102_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_3.prefab_name].transform, "story_v_out_420012", "420012024", "story_v_out_420012.awb")

						arg_99_1:RecordAudio("420012024", var_102_9)
						arg_99_1:RecordAudio("420012024", var_102_9)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_420012", "420012024", "story_v_out_420012.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_420012", "420012024", "story_v_out_420012.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_10 = math.max(var_102_1, arg_99_1.talkMaxDuration)

			if var_102_0 <= arg_99_1.time_ and arg_99_1.time_ < var_102_0 + var_102_10 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_0) / var_102_10

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_0 + var_102_10 and arg_99_1.time_ < var_102_0 + var_102_10 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play420012025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 420012025
		arg_103_1.duration_ = 6.13

		local var_103_0 = {
			zh = 4.1,
			ja = 6.133
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
				arg_103_0:Play420012026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = arg_103_1.actors_["1085ui_story"]
			local var_106_1 = 0

			if var_106_1 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.characterEffect1085ui_story == nil then
				arg_103_1.var_.characterEffect1085ui_story = var_106_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_2 = 0.200000002980232

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_2 and not isNil(var_106_0) then
				local var_106_3 = (arg_103_1.time_ - var_106_1) / var_106_2

				if arg_103_1.var_.characterEffect1085ui_story and not isNil(var_106_0) then
					local var_106_4 = Mathf.Lerp(0, 0.5, var_106_3)

					arg_103_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_103_1.var_.characterEffect1085ui_story.fillRatio = var_106_4
				end
			end

			if arg_103_1.time_ >= var_106_1 + var_106_2 and arg_103_1.time_ < var_106_1 + var_106_2 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.characterEffect1085ui_story then
				local var_106_5 = 0.5

				arg_103_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_103_1.var_.characterEffect1085ui_story.fillRatio = var_106_5
			end

			local var_106_6 = arg_103_1.actors_["404001ui_story"]
			local var_106_7 = 0

			if var_106_7 < arg_103_1.time_ and arg_103_1.time_ <= var_106_7 + arg_106_0 and not isNil(var_106_6) and arg_103_1.var_.characterEffect404001ui_story == nil then
				arg_103_1.var_.characterEffect404001ui_story = var_106_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_8 = 0.200000002980232

			if var_106_7 <= arg_103_1.time_ and arg_103_1.time_ < var_106_7 + var_106_8 and not isNil(var_106_6) then
				local var_106_9 = (arg_103_1.time_ - var_106_7) / var_106_8

				if arg_103_1.var_.characterEffect404001ui_story and not isNil(var_106_6) then
					arg_103_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= var_106_7 + var_106_8 and arg_103_1.time_ < var_106_7 + var_106_8 + arg_106_0 and not isNil(var_106_6) and arg_103_1.var_.characterEffect404001ui_story then
				arg_103_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_106_10 = 0
			local var_106_11 = 0.375

			if var_106_10 < arg_103_1.time_ and arg_103_1.time_ <= var_106_10 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_12 = arg_103_1:FormatText(StoryNameCfg[668].name)

				arg_103_1.leftNameTxt_.text = var_106_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_13 = arg_103_1:GetWordFromCfg(420012025)
				local var_106_14 = arg_103_1:FormatText(var_106_13.content)

				arg_103_1.text_.text = var_106_14

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_15 = 15
				local var_106_16 = utf8.len(var_106_14)
				local var_106_17 = var_106_15 <= 0 and var_106_11 or var_106_11 * (var_106_16 / var_106_15)

				if var_106_17 > 0 and var_106_11 < var_106_17 then
					arg_103_1.talkMaxDuration = var_106_17

					if var_106_17 + var_106_10 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_17 + var_106_10
					end
				end

				arg_103_1.text_.text = var_106_14
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012025", "story_v_out_420012.awb") ~= 0 then
					local var_106_18 = manager.audio:GetVoiceLength("story_v_out_420012", "420012025", "story_v_out_420012.awb") / 1000

					if var_106_18 + var_106_10 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_18 + var_106_10
					end

					if var_106_13.prefab_name ~= "" and arg_103_1.actors_[var_106_13.prefab_name] ~= nil then
						local var_106_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_13.prefab_name].transform, "story_v_out_420012", "420012025", "story_v_out_420012.awb")

						arg_103_1:RecordAudio("420012025", var_106_19)
						arg_103_1:RecordAudio("420012025", var_106_19)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_420012", "420012025", "story_v_out_420012.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_420012", "420012025", "story_v_out_420012.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_20 = math.max(var_106_11, arg_103_1.talkMaxDuration)

			if var_106_10 <= arg_103_1.time_ and arg_103_1.time_ < var_106_10 + var_106_20 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_10) / var_106_20

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_10 + var_106_20 and arg_103_1.time_ < var_106_10 + var_106_20 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play420012026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 420012026
		arg_107_1.duration_ = 9.2

		local var_107_0 = {
			zh = 7.3,
			ja = 9.2
		}
		local var_107_1 = manager.audio:GetLocalizationFlag()

		if var_107_0[var_107_1] ~= nil then
			arg_107_1.duration_ = var_107_0[var_107_1]
		end

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play420012027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.actors_["1085ui_story"]
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.characterEffect1085ui_story == nil then
				arg_107_1.var_.characterEffect1085ui_story = var_110_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_2 = 0.200000002980232

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_2 and not isNil(var_110_0) then
				local var_110_3 = (arg_107_1.time_ - var_110_1) / var_110_2

				if arg_107_1.var_.characterEffect1085ui_story and not isNil(var_110_0) then
					arg_107_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= var_110_1 + var_110_2 and arg_107_1.time_ < var_110_1 + var_110_2 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.characterEffect1085ui_story then
				arg_107_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_110_4 = arg_107_1.actors_["404001ui_story"]
			local var_110_5 = 0

			if var_110_5 < arg_107_1.time_ and arg_107_1.time_ <= var_110_5 + arg_110_0 and not isNil(var_110_4) and arg_107_1.var_.characterEffect404001ui_story == nil then
				arg_107_1.var_.characterEffect404001ui_story = var_110_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_6 = 0.200000002980232

			if var_110_5 <= arg_107_1.time_ and arg_107_1.time_ < var_110_5 + var_110_6 and not isNil(var_110_4) then
				local var_110_7 = (arg_107_1.time_ - var_110_5) / var_110_6

				if arg_107_1.var_.characterEffect404001ui_story and not isNil(var_110_4) then
					local var_110_8 = Mathf.Lerp(0, 0.5, var_110_7)

					arg_107_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_107_1.var_.characterEffect404001ui_story.fillRatio = var_110_8
				end
			end

			if arg_107_1.time_ >= var_110_5 + var_110_6 and arg_107_1.time_ < var_110_5 + var_110_6 + arg_110_0 and not isNil(var_110_4) and arg_107_1.var_.characterEffect404001ui_story then
				local var_110_9 = 0.5

				arg_107_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_107_1.var_.characterEffect404001ui_story.fillRatio = var_110_9
			end

			local var_110_10 = 0

			if var_110_10 < arg_107_1.time_ and arg_107_1.time_ <= var_110_10 + arg_110_0 then
				arg_107_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action4_2")
			end

			local var_110_11 = 0
			local var_110_12 = 0.525

			if var_110_11 < arg_107_1.time_ and arg_107_1.time_ <= var_110_11 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_13 = arg_107_1:FormatText(StoryNameCfg[328].name)

				arg_107_1.leftNameTxt_.text = var_110_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_14 = arg_107_1:GetWordFromCfg(420012026)
				local var_110_15 = arg_107_1:FormatText(var_110_14.content)

				arg_107_1.text_.text = var_110_15

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_16 = 21
				local var_110_17 = utf8.len(var_110_15)
				local var_110_18 = var_110_16 <= 0 and var_110_12 or var_110_12 * (var_110_17 / var_110_16)

				if var_110_18 > 0 and var_110_12 < var_110_18 then
					arg_107_1.talkMaxDuration = var_110_18

					if var_110_18 + var_110_11 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_18 + var_110_11
					end
				end

				arg_107_1.text_.text = var_110_15
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012026", "story_v_out_420012.awb") ~= 0 then
					local var_110_19 = manager.audio:GetVoiceLength("story_v_out_420012", "420012026", "story_v_out_420012.awb") / 1000

					if var_110_19 + var_110_11 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_19 + var_110_11
					end

					if var_110_14.prefab_name ~= "" and arg_107_1.actors_[var_110_14.prefab_name] ~= nil then
						local var_110_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_14.prefab_name].transform, "story_v_out_420012", "420012026", "story_v_out_420012.awb")

						arg_107_1:RecordAudio("420012026", var_110_20)
						arg_107_1:RecordAudio("420012026", var_110_20)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_420012", "420012026", "story_v_out_420012.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_420012", "420012026", "story_v_out_420012.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_21 = math.max(var_110_12, arg_107_1.talkMaxDuration)

			if var_110_11 <= arg_107_1.time_ and arg_107_1.time_ < var_110_11 + var_110_21 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_11) / var_110_21

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_11 + var_110_21 and arg_107_1.time_ < var_110_11 + var_110_21 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play420012027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 420012027
		arg_111_1.duration_ = 9.8

		local var_111_0 = {
			zh = 9.8,
			ja = 8.7
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
				arg_111_0:Play420012028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0
			local var_114_1 = 0.675

			if var_114_0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_2 = arg_111_1:FormatText(StoryNameCfg[328].name)

				arg_111_1.leftNameTxt_.text = var_114_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_3 = arg_111_1:GetWordFromCfg(420012027)
				local var_114_4 = arg_111_1:FormatText(var_114_3.content)

				arg_111_1.text_.text = var_114_4

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_5 = 27
				local var_114_6 = utf8.len(var_114_4)
				local var_114_7 = var_114_5 <= 0 and var_114_1 or var_114_1 * (var_114_6 / var_114_5)

				if var_114_7 > 0 and var_114_1 < var_114_7 then
					arg_111_1.talkMaxDuration = var_114_7

					if var_114_7 + var_114_0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_7 + var_114_0
					end
				end

				arg_111_1.text_.text = var_114_4
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012027", "story_v_out_420012.awb") ~= 0 then
					local var_114_8 = manager.audio:GetVoiceLength("story_v_out_420012", "420012027", "story_v_out_420012.awb") / 1000

					if var_114_8 + var_114_0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_8 + var_114_0
					end

					if var_114_3.prefab_name ~= "" and arg_111_1.actors_[var_114_3.prefab_name] ~= nil then
						local var_114_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_3.prefab_name].transform, "story_v_out_420012", "420012027", "story_v_out_420012.awb")

						arg_111_1:RecordAudio("420012027", var_114_9)
						arg_111_1:RecordAudio("420012027", var_114_9)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_420012", "420012027", "story_v_out_420012.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_420012", "420012027", "story_v_out_420012.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_10 = math.max(var_114_1, arg_111_1.talkMaxDuration)

			if var_114_0 <= arg_111_1.time_ and arg_111_1.time_ < var_114_0 + var_114_10 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_0) / var_114_10

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_0 + var_114_10 and arg_111_1.time_ < var_114_0 + var_114_10 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play420012028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 420012028
		arg_115_1.duration_ = 7.6

		local var_115_0 = {
			zh = 7.266,
			ja = 7.6
		}
		local var_115_1 = manager.audio:GetLocalizationFlag()

		if var_115_0[var_115_1] ~= nil then
			arg_115_1.duration_ = var_115_0[var_115_1]
		end

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play420012029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["1085ui_story"]
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect1085ui_story == nil then
				arg_115_1.var_.characterEffect1085ui_story = var_118_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_2 = 0.200000002980232

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_2 and not isNil(var_118_0) then
				local var_118_3 = (arg_115_1.time_ - var_118_1) / var_118_2

				if arg_115_1.var_.characterEffect1085ui_story and not isNil(var_118_0) then
					local var_118_4 = Mathf.Lerp(0, 0.5, var_118_3)

					arg_115_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_115_1.var_.characterEffect1085ui_story.fillRatio = var_118_4
				end
			end

			if arg_115_1.time_ >= var_118_1 + var_118_2 and arg_115_1.time_ < var_118_1 + var_118_2 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect1085ui_story then
				local var_118_5 = 0.5

				arg_115_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_115_1.var_.characterEffect1085ui_story.fillRatio = var_118_5
			end

			local var_118_6 = arg_115_1.actors_["404001ui_story"]
			local var_118_7 = 0

			if var_118_7 < arg_115_1.time_ and arg_115_1.time_ <= var_118_7 + arg_118_0 and not isNil(var_118_6) and arg_115_1.var_.characterEffect404001ui_story == nil then
				arg_115_1.var_.characterEffect404001ui_story = var_118_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_8 = 0.200000002980232

			if var_118_7 <= arg_115_1.time_ and arg_115_1.time_ < var_118_7 + var_118_8 and not isNil(var_118_6) then
				local var_118_9 = (arg_115_1.time_ - var_118_7) / var_118_8

				if arg_115_1.var_.characterEffect404001ui_story and not isNil(var_118_6) then
					arg_115_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= var_118_7 + var_118_8 and arg_115_1.time_ < var_118_7 + var_118_8 + arg_118_0 and not isNil(var_118_6) and arg_115_1.var_.characterEffect404001ui_story then
				arg_115_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_118_10 = 0

			if var_118_10 < arg_115_1.time_ and arg_115_1.time_ <= var_118_10 + arg_118_0 then
				arg_115_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_2")
			end

			local var_118_11 = 0

			if var_118_11 < arg_115_1.time_ and arg_115_1.time_ <= var_118_11 + arg_118_0 then
				arg_115_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_118_12 = 0
			local var_118_13 = 0.7

			if var_118_12 < arg_115_1.time_ and arg_115_1.time_ <= var_118_12 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_14 = arg_115_1:FormatText(StoryNameCfg[668].name)

				arg_115_1.leftNameTxt_.text = var_118_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_15 = arg_115_1:GetWordFromCfg(420012028)
				local var_118_16 = arg_115_1:FormatText(var_118_15.content)

				arg_115_1.text_.text = var_118_16

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_17 = 28
				local var_118_18 = utf8.len(var_118_16)
				local var_118_19 = var_118_17 <= 0 and var_118_13 or var_118_13 * (var_118_18 / var_118_17)

				if var_118_19 > 0 and var_118_13 < var_118_19 then
					arg_115_1.talkMaxDuration = var_118_19

					if var_118_19 + var_118_12 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_19 + var_118_12
					end
				end

				arg_115_1.text_.text = var_118_16
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012028", "story_v_out_420012.awb") ~= 0 then
					local var_118_20 = manager.audio:GetVoiceLength("story_v_out_420012", "420012028", "story_v_out_420012.awb") / 1000

					if var_118_20 + var_118_12 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_20 + var_118_12
					end

					if var_118_15.prefab_name ~= "" and arg_115_1.actors_[var_118_15.prefab_name] ~= nil then
						local var_118_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_15.prefab_name].transform, "story_v_out_420012", "420012028", "story_v_out_420012.awb")

						arg_115_1:RecordAudio("420012028", var_118_21)
						arg_115_1:RecordAudio("420012028", var_118_21)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_420012", "420012028", "story_v_out_420012.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_420012", "420012028", "story_v_out_420012.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_22 = math.max(var_118_13, arg_115_1.talkMaxDuration)

			if var_118_12 <= arg_115_1.time_ and arg_115_1.time_ < var_118_12 + var_118_22 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_12) / var_118_22

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_12 + var_118_22 and arg_115_1.time_ < var_118_12 + var_118_22 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play420012029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 420012029
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play420012030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["404001ui_story"].transform
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 then
				arg_119_1.var_.moveOldPos404001ui_story = var_122_0.localPosition
			end

			local var_122_2 = 0.001

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_2 then
				local var_122_3 = (arg_119_1.time_ - var_122_1) / var_122_2
				local var_122_4 = Vector3.New(0, 100, 0)

				var_122_0.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos404001ui_story, var_122_4, var_122_3)

				local var_122_5 = manager.ui.mainCamera.transform.position - var_122_0.position

				var_122_0.forward = Vector3.New(var_122_5.x, var_122_5.y, var_122_5.z)

				local var_122_6 = var_122_0.localEulerAngles

				var_122_6.z = 0
				var_122_6.x = 0
				var_122_0.localEulerAngles = var_122_6
			end

			if arg_119_1.time_ >= var_122_1 + var_122_2 and arg_119_1.time_ < var_122_1 + var_122_2 + arg_122_0 then
				var_122_0.localPosition = Vector3.New(0, 100, 0)

				local var_122_7 = manager.ui.mainCamera.transform.position - var_122_0.position

				var_122_0.forward = Vector3.New(var_122_7.x, var_122_7.y, var_122_7.z)

				local var_122_8 = var_122_0.localEulerAngles

				var_122_8.z = 0
				var_122_8.x = 0
				var_122_0.localEulerAngles = var_122_8
			end

			local var_122_9 = arg_119_1.actors_["1085ui_story"].transform
			local var_122_10 = 0

			if var_122_10 < arg_119_1.time_ and arg_119_1.time_ <= var_122_10 + arg_122_0 then
				arg_119_1.var_.moveOldPos1085ui_story = var_122_9.localPosition
			end

			local var_122_11 = 0.001

			if var_122_10 <= arg_119_1.time_ and arg_119_1.time_ < var_122_10 + var_122_11 then
				local var_122_12 = (arg_119_1.time_ - var_122_10) / var_122_11
				local var_122_13 = Vector3.New(0, 100, 0)

				var_122_9.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1085ui_story, var_122_13, var_122_12)

				local var_122_14 = manager.ui.mainCamera.transform.position - var_122_9.position

				var_122_9.forward = Vector3.New(var_122_14.x, var_122_14.y, var_122_14.z)

				local var_122_15 = var_122_9.localEulerAngles

				var_122_15.z = 0
				var_122_15.x = 0
				var_122_9.localEulerAngles = var_122_15
			end

			if arg_119_1.time_ >= var_122_10 + var_122_11 and arg_119_1.time_ < var_122_10 + var_122_11 + arg_122_0 then
				var_122_9.localPosition = Vector3.New(0, 100, 0)

				local var_122_16 = manager.ui.mainCamera.transform.position - var_122_9.position

				var_122_9.forward = Vector3.New(var_122_16.x, var_122_16.y, var_122_16.z)

				local var_122_17 = var_122_9.localEulerAngles

				var_122_17.z = 0
				var_122_17.x = 0
				var_122_9.localEulerAngles = var_122_17
			end

			local var_122_18 = 1.53333333333333
			local var_122_19 = 1

			if var_122_18 < arg_119_1.time_ and arg_119_1.time_ <= var_122_18 + arg_122_0 then
				local var_122_20 = "play"
				local var_122_21 = "effect"

				arg_119_1:AudioAction(var_122_20, var_122_21, "se_story_1310", "se_story_1310_clap", "")
			end

			local var_122_22 = 2.53333333333333
			local var_122_23 = 1

			if var_122_22 < arg_119_1.time_ and arg_119_1.time_ <= var_122_22 + arg_122_0 then
				local var_122_24 = "play"
				local var_122_25 = "effect"

				arg_119_1:AudioAction(var_122_24, var_122_25, "se_story_side_1042", "se_story_1042_doorbell", "")
			end

			local var_122_26 = 0
			local var_122_27 = 1.65

			if var_122_26 < arg_119_1.time_ and arg_119_1.time_ <= var_122_26 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, false)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_28 = arg_119_1:GetWordFromCfg(420012029)
				local var_122_29 = arg_119_1:FormatText(var_122_28.content)

				arg_119_1.text_.text = var_122_29

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_30 = 66
				local var_122_31 = utf8.len(var_122_29)
				local var_122_32 = var_122_30 <= 0 and var_122_27 or var_122_27 * (var_122_31 / var_122_30)

				if var_122_32 > 0 and var_122_27 < var_122_32 then
					arg_119_1.talkMaxDuration = var_122_32

					if var_122_32 + var_122_26 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_32 + var_122_26
					end
				end

				arg_119_1.text_.text = var_122_29
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_33 = math.max(var_122_27, arg_119_1.talkMaxDuration)

			if var_122_26 <= arg_119_1.time_ and arg_119_1.time_ < var_122_26 + var_122_33 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_26) / var_122_33

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_26 + var_122_33 and arg_119_1.time_ < var_122_26 + var_122_33 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_119_1:InitPlayNodeList()
	end,
	Play420012030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 420012030
		arg_123_1.duration_ = 2.03

		local var_123_0 = {
			zh = 2.033,
			ja = 1.999999999999
		}
		local var_123_1 = manager.audio:GetLocalizationFlag()

		if var_123_0[var_123_1] ~= nil then
			arg_123_1.duration_ = var_123_0[var_123_1]
		end

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play420012031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["1085ui_story"].transform
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 then
				arg_123_1.var_.moveOldPos1085ui_story = var_126_0.localPosition
			end

			local var_126_2 = 0.001

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_2 then
				local var_126_3 = (arg_123_1.time_ - var_126_1) / var_126_2
				local var_126_4 = Vector3.New(0, -1.01, -5.83)

				var_126_0.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos1085ui_story, var_126_4, var_126_3)

				local var_126_5 = manager.ui.mainCamera.transform.position - var_126_0.position

				var_126_0.forward = Vector3.New(var_126_5.x, var_126_5.y, var_126_5.z)

				local var_126_6 = var_126_0.localEulerAngles

				var_126_6.z = 0
				var_126_6.x = 0
				var_126_0.localEulerAngles = var_126_6
			end

			if arg_123_1.time_ >= var_126_1 + var_126_2 and arg_123_1.time_ < var_126_1 + var_126_2 + arg_126_0 then
				var_126_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_126_7 = manager.ui.mainCamera.transform.position - var_126_0.position

				var_126_0.forward = Vector3.New(var_126_7.x, var_126_7.y, var_126_7.z)

				local var_126_8 = var_126_0.localEulerAngles

				var_126_8.z = 0
				var_126_8.x = 0
				var_126_0.localEulerAngles = var_126_8
			end

			local var_126_9 = arg_123_1.actors_["1085ui_story"]
			local var_126_10 = 0

			if var_126_10 < arg_123_1.time_ and arg_123_1.time_ <= var_126_10 + arg_126_0 and not isNil(var_126_9) and arg_123_1.var_.characterEffect1085ui_story == nil then
				arg_123_1.var_.characterEffect1085ui_story = var_126_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_11 = 0.200000002980232

			if var_126_10 <= arg_123_1.time_ and arg_123_1.time_ < var_126_10 + var_126_11 and not isNil(var_126_9) then
				local var_126_12 = (arg_123_1.time_ - var_126_10) / var_126_11

				if arg_123_1.var_.characterEffect1085ui_story and not isNil(var_126_9) then
					arg_123_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= var_126_10 + var_126_11 and arg_123_1.time_ < var_126_10 + var_126_11 + arg_126_0 and not isNil(var_126_9) and arg_123_1.var_.characterEffect1085ui_story then
				arg_123_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_126_13 = 0

			if var_126_13 < arg_123_1.time_ and arg_123_1.time_ <= var_126_13 + arg_126_0 then
				arg_123_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_126_14 = 0
			local var_126_15 = 0.075

			if var_126_14 < arg_123_1.time_ and arg_123_1.time_ <= var_126_14 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_16 = arg_123_1:FormatText(StoryNameCfg[328].name)

				arg_123_1.leftNameTxt_.text = var_126_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_17 = arg_123_1:GetWordFromCfg(420012030)
				local var_126_18 = arg_123_1:FormatText(var_126_17.content)

				arg_123_1.text_.text = var_126_18

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_19 = 3
				local var_126_20 = utf8.len(var_126_18)
				local var_126_21 = var_126_19 <= 0 and var_126_15 or var_126_15 * (var_126_20 / var_126_19)

				if var_126_21 > 0 and var_126_15 < var_126_21 then
					arg_123_1.talkMaxDuration = var_126_21

					if var_126_21 + var_126_14 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_21 + var_126_14
					end
				end

				arg_123_1.text_.text = var_126_18
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012030", "story_v_out_420012.awb") ~= 0 then
					local var_126_22 = manager.audio:GetVoiceLength("story_v_out_420012", "420012030", "story_v_out_420012.awb") / 1000

					if var_126_22 + var_126_14 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_22 + var_126_14
					end

					if var_126_17.prefab_name ~= "" and arg_123_1.actors_[var_126_17.prefab_name] ~= nil then
						local var_126_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_17.prefab_name].transform, "story_v_out_420012", "420012030", "story_v_out_420012.awb")

						arg_123_1:RecordAudio("420012030", var_126_23)
						arg_123_1:RecordAudio("420012030", var_126_23)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_420012", "420012030", "story_v_out_420012.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_420012", "420012030", "story_v_out_420012.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_24 = math.max(var_126_15, arg_123_1.talkMaxDuration)

			if var_126_14 <= arg_123_1.time_ and arg_123_1.time_ < var_126_14 + var_126_24 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_14) / var_126_24

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_14 + var_126_24 and arg_123_1.time_ < var_126_14 + var_126_24 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_123_1:InitPlayNodeList()
	end,
	Play420012031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 420012031
		arg_127_1.duration_ = 2.77

		local var_127_0 = {
			zh = 1.999999999999,
			ja = 2.766
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
				arg_127_0:Play420012032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = arg_127_1.actors_["404001ui_story"].transform
			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 then
				arg_127_1.var_.moveOldPos404001ui_story = var_130_0.localPosition
			end

			local var_130_2 = 0.001

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_2 then
				local var_130_3 = (arg_127_1.time_ - var_130_1) / var_130_2
				local var_130_4 = Vector3.New(0, -1.55, -5.5)

				var_130_0.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos404001ui_story, var_130_4, var_130_3)

				local var_130_5 = manager.ui.mainCamera.transform.position - var_130_0.position

				var_130_0.forward = Vector3.New(var_130_5.x, var_130_5.y, var_130_5.z)

				local var_130_6 = var_130_0.localEulerAngles

				var_130_6.z = 0
				var_130_6.x = 0
				var_130_0.localEulerAngles = var_130_6
			end

			if arg_127_1.time_ >= var_130_1 + var_130_2 and arg_127_1.time_ < var_130_1 + var_130_2 + arg_130_0 then
				var_130_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_130_7 = manager.ui.mainCamera.transform.position - var_130_0.position

				var_130_0.forward = Vector3.New(var_130_7.x, var_130_7.y, var_130_7.z)

				local var_130_8 = var_130_0.localEulerAngles

				var_130_8.z = 0
				var_130_8.x = 0
				var_130_0.localEulerAngles = var_130_8
			end

			local var_130_9 = arg_127_1.actors_["1085ui_story"].transform
			local var_130_10 = 0

			if var_130_10 < arg_127_1.time_ and arg_127_1.time_ <= var_130_10 + arg_130_0 then
				arg_127_1.var_.moveOldPos1085ui_story = var_130_9.localPosition
			end

			local var_130_11 = 0.001

			if var_130_10 <= arg_127_1.time_ and arg_127_1.time_ < var_130_10 + var_130_11 then
				local var_130_12 = (arg_127_1.time_ - var_130_10) / var_130_11
				local var_130_13 = Vector3.New(0, 100, 0)

				var_130_9.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1085ui_story, var_130_13, var_130_12)

				local var_130_14 = manager.ui.mainCamera.transform.position - var_130_9.position

				var_130_9.forward = Vector3.New(var_130_14.x, var_130_14.y, var_130_14.z)

				local var_130_15 = var_130_9.localEulerAngles

				var_130_15.z = 0
				var_130_15.x = 0
				var_130_9.localEulerAngles = var_130_15
			end

			if arg_127_1.time_ >= var_130_10 + var_130_11 and arg_127_1.time_ < var_130_10 + var_130_11 + arg_130_0 then
				var_130_9.localPosition = Vector3.New(0, 100, 0)

				local var_130_16 = manager.ui.mainCamera.transform.position - var_130_9.position

				var_130_9.forward = Vector3.New(var_130_16.x, var_130_16.y, var_130_16.z)

				local var_130_17 = var_130_9.localEulerAngles

				var_130_17.z = 0
				var_130_17.x = 0
				var_130_9.localEulerAngles = var_130_17
			end

			local var_130_18 = arg_127_1.actors_["1085ui_story"]
			local var_130_19 = 0

			if var_130_19 < arg_127_1.time_ and arg_127_1.time_ <= var_130_19 + arg_130_0 and not isNil(var_130_18) and arg_127_1.var_.characterEffect1085ui_story == nil then
				arg_127_1.var_.characterEffect1085ui_story = var_130_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_20 = 0.200000002980232

			if var_130_19 <= arg_127_1.time_ and arg_127_1.time_ < var_130_19 + var_130_20 and not isNil(var_130_18) then
				local var_130_21 = (arg_127_1.time_ - var_130_19) / var_130_20

				if arg_127_1.var_.characterEffect1085ui_story and not isNil(var_130_18) then
					local var_130_22 = Mathf.Lerp(0, 0.5, var_130_21)

					arg_127_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_127_1.var_.characterEffect1085ui_story.fillRatio = var_130_22
				end
			end

			if arg_127_1.time_ >= var_130_19 + var_130_20 and arg_127_1.time_ < var_130_19 + var_130_20 + arg_130_0 and not isNil(var_130_18) and arg_127_1.var_.characterEffect1085ui_story then
				local var_130_23 = 0.5

				arg_127_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_127_1.var_.characterEffect1085ui_story.fillRatio = var_130_23
			end

			local var_130_24 = arg_127_1.actors_["404001ui_story"]
			local var_130_25 = 0

			if var_130_25 < arg_127_1.time_ and arg_127_1.time_ <= var_130_25 + arg_130_0 and not isNil(var_130_24) and arg_127_1.var_.characterEffect404001ui_story == nil then
				arg_127_1.var_.characterEffect404001ui_story = var_130_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_26 = 0.200000002980232

			if var_130_25 <= arg_127_1.time_ and arg_127_1.time_ < var_130_25 + var_130_26 and not isNil(var_130_24) then
				local var_130_27 = (arg_127_1.time_ - var_130_25) / var_130_26

				if arg_127_1.var_.characterEffect404001ui_story and not isNil(var_130_24) then
					arg_127_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= var_130_25 + var_130_26 and arg_127_1.time_ < var_130_25 + var_130_26 + arg_130_0 and not isNil(var_130_24) and arg_127_1.var_.characterEffect404001ui_story then
				arg_127_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_130_28 = 0

			if var_130_28 < arg_127_1.time_ and arg_127_1.time_ <= var_130_28 + arg_130_0 then
				arg_127_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_130_29 = 0

			if var_130_29 < arg_127_1.time_ and arg_127_1.time_ <= var_130_29 + arg_130_0 then
				arg_127_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action5_1")
			end

			local var_130_30 = 0
			local var_130_31 = 0.2

			if var_130_30 < arg_127_1.time_ and arg_127_1.time_ <= var_130_30 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_32 = arg_127_1:FormatText(StoryNameCfg[668].name)

				arg_127_1.leftNameTxt_.text = var_130_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_33 = arg_127_1:GetWordFromCfg(420012031)
				local var_130_34 = arg_127_1:FormatText(var_130_33.content)

				arg_127_1.text_.text = var_130_34

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_35 = 8
				local var_130_36 = utf8.len(var_130_34)
				local var_130_37 = var_130_35 <= 0 and var_130_31 or var_130_31 * (var_130_36 / var_130_35)

				if var_130_37 > 0 and var_130_31 < var_130_37 then
					arg_127_1.talkMaxDuration = var_130_37

					if var_130_37 + var_130_30 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_37 + var_130_30
					end
				end

				arg_127_1.text_.text = var_130_34
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012031", "story_v_out_420012.awb") ~= 0 then
					local var_130_38 = manager.audio:GetVoiceLength("story_v_out_420012", "420012031", "story_v_out_420012.awb") / 1000

					if var_130_38 + var_130_30 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_38 + var_130_30
					end

					if var_130_33.prefab_name ~= "" and arg_127_1.actors_[var_130_33.prefab_name] ~= nil then
						local var_130_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_33.prefab_name].transform, "story_v_out_420012", "420012031", "story_v_out_420012.awb")

						arg_127_1:RecordAudio("420012031", var_130_39)
						arg_127_1:RecordAudio("420012031", var_130_39)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_420012", "420012031", "story_v_out_420012.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_420012", "420012031", "story_v_out_420012.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_40 = math.max(var_130_31, arg_127_1.talkMaxDuration)

			if var_130_30 <= arg_127_1.time_ and arg_127_1.time_ < var_130_30 + var_130_40 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_30) / var_130_40

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_30 + var_130_40 and arg_127_1.time_ < var_130_30 + var_130_40 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_127_1:InitPlayNodeList()
	end,
	Play420012032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 420012032
		arg_131_1.duration_ = 11.3

		local var_131_0 = {
			zh = 9.033,
			ja = 11.3
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
				arg_131_0:Play420012033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = "L01f"

			if arg_131_1.bgs_[var_134_0] == nil then
				local var_134_1 = Object.Instantiate(arg_131_1.paintGo_)

				var_134_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_134_0)
				var_134_1.name = var_134_0
				var_134_1.transform.parent = arg_131_1.stage_.transform
				var_134_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_131_1.bgs_[var_134_0] = var_134_1
			end

			local var_134_2 = 2

			if var_134_2 < arg_131_1.time_ and arg_131_1.time_ <= var_134_2 + arg_134_0 then
				local var_134_3 = manager.ui.mainCamera.transform.localPosition
				local var_134_4 = Vector3.New(0, 0, 10) + Vector3.New(var_134_3.x, var_134_3.y, 0)
				local var_134_5 = arg_131_1.bgs_.L01f

				var_134_5.transform.localPosition = var_134_4
				var_134_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_134_6 = var_134_5:GetComponent("SpriteRenderer")

				if var_134_6 and var_134_6.sprite then
					local var_134_7 = (var_134_5.transform.localPosition - var_134_3).z
					local var_134_8 = manager.ui.mainCameraCom_
					local var_134_9 = 2 * var_134_7 * Mathf.Tan(var_134_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_134_10 = var_134_9 * var_134_8.aspect
					local var_134_11 = var_134_6.sprite.bounds.size.x
					local var_134_12 = var_134_6.sprite.bounds.size.y
					local var_134_13 = var_134_10 / var_134_11
					local var_134_14 = var_134_9 / var_134_12
					local var_134_15 = var_134_14 < var_134_13 and var_134_13 or var_134_14

					var_134_5.transform.localScale = Vector3.New(var_134_15, var_134_15, 0)
				end

				for iter_134_0, iter_134_1 in pairs(arg_131_1.bgs_) do
					if iter_134_0 ~= "L01f" then
						iter_134_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_134_16 = 4

			if var_134_16 < arg_131_1.time_ and arg_131_1.time_ <= var_134_16 + arg_134_0 then
				arg_131_1.allBtn_.enabled = false
			end

			local var_134_17 = 0.3

			if arg_131_1.time_ >= var_134_16 + var_134_17 and arg_131_1.time_ < var_134_16 + var_134_17 + arg_134_0 then
				arg_131_1.allBtn_.enabled = true
			end

			local var_134_18 = 0

			if var_134_18 < arg_131_1.time_ and arg_131_1.time_ <= var_134_18 + arg_134_0 then
				arg_131_1.mask_.enabled = true
				arg_131_1.mask_.raycastTarget = true

				arg_131_1:SetGaussion(false)
			end

			local var_134_19 = 2

			if var_134_18 <= arg_131_1.time_ and arg_131_1.time_ < var_134_18 + var_134_19 then
				local var_134_20 = (arg_131_1.time_ - var_134_18) / var_134_19
				local var_134_21 = Color.New(0, 0, 0)

				var_134_21.a = Mathf.Lerp(0, 1, var_134_20)
				arg_131_1.mask_.color = var_134_21
			end

			if arg_131_1.time_ >= var_134_18 + var_134_19 and arg_131_1.time_ < var_134_18 + var_134_19 + arg_134_0 then
				local var_134_22 = Color.New(0, 0, 0)

				var_134_22.a = 1
				arg_131_1.mask_.color = var_134_22
			end

			local var_134_23 = 2

			if var_134_23 < arg_131_1.time_ and arg_131_1.time_ <= var_134_23 + arg_134_0 then
				arg_131_1.mask_.enabled = true
				arg_131_1.mask_.raycastTarget = true

				arg_131_1:SetGaussion(false)
			end

			local var_134_24 = 2

			if var_134_23 <= arg_131_1.time_ and arg_131_1.time_ < var_134_23 + var_134_24 then
				local var_134_25 = (arg_131_1.time_ - var_134_23) / var_134_24
				local var_134_26 = Color.New(0, 0, 0)

				var_134_26.a = Mathf.Lerp(1, 0, var_134_25)
				arg_131_1.mask_.color = var_134_26
			end

			if arg_131_1.time_ >= var_134_23 + var_134_24 and arg_131_1.time_ < var_134_23 + var_134_24 + arg_134_0 then
				local var_134_27 = Color.New(0, 0, 0)
				local var_134_28 = 0

				arg_131_1.mask_.enabled = false
				var_134_27.a = var_134_28
				arg_131_1.mask_.color = var_134_27
			end

			local var_134_29 = arg_131_1.actors_["404001ui_story"].transform
			local var_134_30 = 1.96599999815226

			if var_134_30 < arg_131_1.time_ and arg_131_1.time_ <= var_134_30 + arg_134_0 then
				arg_131_1.var_.moveOldPos404001ui_story = var_134_29.localPosition
			end

			local var_134_31 = 0.001

			if var_134_30 <= arg_131_1.time_ and arg_131_1.time_ < var_134_30 + var_134_31 then
				local var_134_32 = (arg_131_1.time_ - var_134_30) / var_134_31
				local var_134_33 = Vector3.New(0, 100, 0)

				var_134_29.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos404001ui_story, var_134_33, var_134_32)

				local var_134_34 = manager.ui.mainCamera.transform.position - var_134_29.position

				var_134_29.forward = Vector3.New(var_134_34.x, var_134_34.y, var_134_34.z)

				local var_134_35 = var_134_29.localEulerAngles

				var_134_35.z = 0
				var_134_35.x = 0
				var_134_29.localEulerAngles = var_134_35
			end

			if arg_131_1.time_ >= var_134_30 + var_134_31 and arg_131_1.time_ < var_134_30 + var_134_31 + arg_134_0 then
				var_134_29.localPosition = Vector3.New(0, 100, 0)

				local var_134_36 = manager.ui.mainCamera.transform.position - var_134_29.position

				var_134_29.forward = Vector3.New(var_134_36.x, var_134_36.y, var_134_36.z)

				local var_134_37 = var_134_29.localEulerAngles

				var_134_37.z = 0
				var_134_37.x = 0
				var_134_29.localEulerAngles = var_134_37
			end

			local var_134_38 = arg_131_1.actors_["404001ui_story"].transform
			local var_134_39 = 3.79999999701977

			if var_134_39 < arg_131_1.time_ and arg_131_1.time_ <= var_134_39 + arg_134_0 then
				arg_131_1.var_.moveOldPos404001ui_story = var_134_38.localPosition
			end

			local var_134_40 = 0.001

			if var_134_39 <= arg_131_1.time_ and arg_131_1.time_ < var_134_39 + var_134_40 then
				local var_134_41 = (arg_131_1.time_ - var_134_39) / var_134_40
				local var_134_42 = Vector3.New(0, -1.55, -5.5)

				var_134_38.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos404001ui_story, var_134_42, var_134_41)

				local var_134_43 = manager.ui.mainCamera.transform.position - var_134_38.position

				var_134_38.forward = Vector3.New(var_134_43.x, var_134_43.y, var_134_43.z)

				local var_134_44 = var_134_38.localEulerAngles

				var_134_44.z = 0
				var_134_44.x = 0
				var_134_38.localEulerAngles = var_134_44
			end

			if arg_131_1.time_ >= var_134_39 + var_134_40 and arg_131_1.time_ < var_134_39 + var_134_40 + arg_134_0 then
				var_134_38.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_134_45 = manager.ui.mainCamera.transform.position - var_134_38.position

				var_134_38.forward = Vector3.New(var_134_45.x, var_134_45.y, var_134_45.z)

				local var_134_46 = var_134_38.localEulerAngles

				var_134_46.z = 0
				var_134_46.x = 0
				var_134_38.localEulerAngles = var_134_46
			end

			local var_134_47 = arg_131_1.actors_["404001ui_story"]
			local var_134_48 = 3.79999999701977

			if var_134_48 < arg_131_1.time_ and arg_131_1.time_ <= var_134_48 + arg_134_0 and not isNil(var_134_47) and arg_131_1.var_.characterEffect404001ui_story == nil then
				arg_131_1.var_.characterEffect404001ui_story = var_134_47:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_49 = 0.200000002980232

			if var_134_48 <= arg_131_1.time_ and arg_131_1.time_ < var_134_48 + var_134_49 and not isNil(var_134_47) then
				local var_134_50 = (arg_131_1.time_ - var_134_48) / var_134_49

				if arg_131_1.var_.characterEffect404001ui_story and not isNil(var_134_47) then
					arg_131_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= var_134_48 + var_134_49 and arg_131_1.time_ < var_134_48 + var_134_49 + arg_134_0 and not isNil(var_134_47) and arg_131_1.var_.characterEffect404001ui_story then
				arg_131_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_134_51 = 3.79999999701977

			if var_134_51 < arg_131_1.time_ and arg_131_1.time_ <= var_134_51 + arg_134_0 then
				arg_131_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_134_52 = 3.79999999701977

			if var_134_52 < arg_131_1.time_ and arg_131_1.time_ <= var_134_52 + arg_134_0 then
				arg_131_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_134_53 = 1
			local var_134_54 = 1

			if var_134_53 < arg_131_1.time_ and arg_131_1.time_ <= var_134_53 + arg_134_0 then
				local var_134_55 = "stop"
				local var_134_56 = "effect"

				arg_131_1:AudioAction(var_134_55, var_134_56, "se_story_140", "se_story_140_amb_room01", "")
			end

			local var_134_57 = 1.6
			local var_134_58 = 1

			if var_134_57 < arg_131_1.time_ and arg_131_1.time_ <= var_134_57 + arg_134_0 then
				local var_134_59 = "play"
				local var_134_60 = "effect"

				arg_131_1:AudioAction(var_134_59, var_134_60, "se_story_140", "se_story_140_amb_street01", "")
			end

			if arg_131_1.frameCnt_ <= 1 then
				arg_131_1.dialog_:SetActive(false)
			end

			local var_134_61 = 4
			local var_134_62 = 0.55

			if var_134_61 < arg_131_1.time_ and arg_131_1.time_ <= var_134_61 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0

				arg_131_1.dialog_:SetActive(true)

				arg_131_1.dialogCg_.alpha = 0

				local var_134_63 = LeanTween.value(arg_131_1.dialog_, 0, 1, 0.3)

				var_134_63:setOnUpdate(LuaHelper.FloatAction(function(arg_135_0)
					arg_131_1.dialogCg_.alpha = arg_135_0
				end))
				var_134_63:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_131_1.dialog_)
					var_134_63:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_131_1.duration_ = arg_131_1.duration_ + 0.3

				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_64 = arg_131_1:FormatText(StoryNameCfg[668].name)

				arg_131_1.leftNameTxt_.text = var_134_64

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_65 = arg_131_1:GetWordFromCfg(420012032)
				local var_134_66 = arg_131_1:FormatText(var_134_65.content)

				arg_131_1.text_.text = var_134_66

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_67 = 22
				local var_134_68 = utf8.len(var_134_66)
				local var_134_69 = var_134_67 <= 0 and var_134_62 or var_134_62 * (var_134_68 / var_134_67)

				if var_134_69 > 0 and var_134_62 < var_134_69 then
					arg_131_1.talkMaxDuration = var_134_69
					var_134_61 = var_134_61 + 0.3

					if var_134_69 + var_134_61 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_69 + var_134_61
					end
				end

				arg_131_1.text_.text = var_134_66
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012032", "story_v_out_420012.awb") ~= 0 then
					local var_134_70 = manager.audio:GetVoiceLength("story_v_out_420012", "420012032", "story_v_out_420012.awb") / 1000

					if var_134_70 + var_134_61 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_70 + var_134_61
					end

					if var_134_65.prefab_name ~= "" and arg_131_1.actors_[var_134_65.prefab_name] ~= nil then
						local var_134_71 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_65.prefab_name].transform, "story_v_out_420012", "420012032", "story_v_out_420012.awb")

						arg_131_1:RecordAudio("420012032", var_134_71)
						arg_131_1:RecordAudio("420012032", var_134_71)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_420012", "420012032", "story_v_out_420012.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_420012", "420012032", "story_v_out_420012.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_72 = var_134_61 + 0.3
			local var_134_73 = math.max(var_134_62, arg_131_1.talkMaxDuration)

			if var_134_72 <= arg_131_1.time_ and arg_131_1.time_ < var_134_72 + var_134_73 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_72) / var_134_73

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_72 + var_134_73 and arg_131_1.time_ < var_134_72 + var_134_73 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.79999999701977,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_131_1:InitPlayNodeList()
	end,
	Play420012033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 420012033
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play420012034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["404001ui_story"].transform
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 then
				arg_137_1.var_.moveOldPos404001ui_story = var_140_0.localPosition
			end

			local var_140_2 = 0.001

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2
				local var_140_4 = Vector3.New(0, 100, 0)

				var_140_0.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos404001ui_story, var_140_4, var_140_3)

				local var_140_5 = manager.ui.mainCamera.transform.position - var_140_0.position

				var_140_0.forward = Vector3.New(var_140_5.x, var_140_5.y, var_140_5.z)

				local var_140_6 = var_140_0.localEulerAngles

				var_140_6.z = 0
				var_140_6.x = 0
				var_140_0.localEulerAngles = var_140_6
			end

			if arg_137_1.time_ >= var_140_1 + var_140_2 and arg_137_1.time_ < var_140_1 + var_140_2 + arg_140_0 then
				var_140_0.localPosition = Vector3.New(0, 100, 0)

				local var_140_7 = manager.ui.mainCamera.transform.position - var_140_0.position

				var_140_0.forward = Vector3.New(var_140_7.x, var_140_7.y, var_140_7.z)

				local var_140_8 = var_140_0.localEulerAngles

				var_140_8.z = 0
				var_140_8.x = 0
				var_140_0.localEulerAngles = var_140_8
			end

			local var_140_9 = 0.8
			local var_140_10 = 1

			if var_140_9 < arg_137_1.time_ and arg_137_1.time_ <= var_140_9 + arg_140_0 then
				local var_140_11 = "play"
				local var_140_12 = "effect"

				arg_137_1:AudioAction(var_140_11, var_140_12, "se_story_140", "se_story_140_foley_paperbag01", "")
			end

			local var_140_13 = 0
			local var_140_14 = 1.1

			if var_140_13 < arg_137_1.time_ and arg_137_1.time_ <= var_140_13 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_15 = arg_137_1:GetWordFromCfg(420012033)
				local var_140_16 = arg_137_1:FormatText(var_140_15.content)

				arg_137_1.text_.text = var_140_16

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_17 = 44
				local var_140_18 = utf8.len(var_140_16)
				local var_140_19 = var_140_17 <= 0 and var_140_14 or var_140_14 * (var_140_18 / var_140_17)

				if var_140_19 > 0 and var_140_14 < var_140_19 then
					arg_137_1.talkMaxDuration = var_140_19

					if var_140_19 + var_140_13 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_19 + var_140_13
					end
				end

				arg_137_1.text_.text = var_140_16
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_20 = math.max(var_140_14, arg_137_1.talkMaxDuration)

			if var_140_13 <= arg_137_1.time_ and arg_137_1.time_ < var_140_13 + var_140_20 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_13) / var_140_20

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_13 + var_140_20 and arg_137_1.time_ < var_140_13 + var_140_20 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
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
	Play420012034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 420012034
		arg_141_1.duration_ = 3.1

		local var_141_0 = {
			zh = 2.833,
			ja = 3.1
		}
		local var_141_1 = manager.audio:GetLocalizationFlag()

		if var_141_0[var_141_1] ~= nil then
			arg_141_1.duration_ = var_141_0[var_141_1]
		end

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play420012035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = "1043ui_story"

			if arg_141_1.actors_[var_144_0] == nil then
				local var_144_1 = Asset.Load("Char/" .. "1043ui_story")

				if not isNil(var_144_1) then
					local var_144_2 = Object.Instantiate(Asset.Load("Char/" .. "1043ui_story"), arg_141_1.stage_.transform)

					var_144_2.name = var_144_0
					var_144_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_141_1.actors_[var_144_0] = var_144_2

					local var_144_3 = var_144_2:GetComponentInChildren(typeof(CharacterEffect))

					var_144_3.enabled = true

					local var_144_4 = GameObjectTools.GetOrAddComponent(var_144_2, typeof(DynamicBoneHelper))

					if var_144_4 then
						var_144_4:EnableDynamicBone(false)
					end

					arg_141_1:ShowWeapon(var_144_3.transform, false)

					arg_141_1.var_[var_144_0 .. "Animator"] = var_144_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_141_1.var_[var_144_0 .. "Animator"].applyRootMotion = true
					arg_141_1.var_[var_144_0 .. "LipSync"] = var_144_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_144_5 = arg_141_1.actors_["1043ui_story"].transform
			local var_144_6 = 0

			if var_144_6 < arg_141_1.time_ and arg_141_1.time_ <= var_144_6 + arg_144_0 then
				arg_141_1.var_.moveOldPos1043ui_story = var_144_5.localPosition

				local var_144_7 = "1043ui_story"

				arg_141_1:ShowWeapon(arg_141_1.var_[var_144_7 .. "Animator"].transform, false)
			end

			local var_144_8 = 0.001

			if var_144_6 <= arg_141_1.time_ and arg_141_1.time_ < var_144_6 + var_144_8 then
				local var_144_9 = (arg_141_1.time_ - var_144_6) / var_144_8
				local var_144_10 = Vector3.New(0.01, -1.01, -5.73)

				var_144_5.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1043ui_story, var_144_10, var_144_9)

				local var_144_11 = manager.ui.mainCamera.transform.position - var_144_5.position

				var_144_5.forward = Vector3.New(var_144_11.x, var_144_11.y, var_144_11.z)

				local var_144_12 = var_144_5.localEulerAngles

				var_144_12.z = 0
				var_144_12.x = 0
				var_144_5.localEulerAngles = var_144_12
			end

			if arg_141_1.time_ >= var_144_6 + var_144_8 and arg_141_1.time_ < var_144_6 + var_144_8 + arg_144_0 then
				var_144_5.localPosition = Vector3.New(0.01, -1.01, -5.73)

				local var_144_13 = manager.ui.mainCamera.transform.position - var_144_5.position

				var_144_5.forward = Vector3.New(var_144_13.x, var_144_13.y, var_144_13.z)

				local var_144_14 = var_144_5.localEulerAngles

				var_144_14.z = 0
				var_144_14.x = 0
				var_144_5.localEulerAngles = var_144_14
			end

			local var_144_15 = arg_141_1.actors_["1043ui_story"]
			local var_144_16 = 0

			if var_144_16 < arg_141_1.time_ and arg_141_1.time_ <= var_144_16 + arg_144_0 and not isNil(var_144_15) and arg_141_1.var_.characterEffect1043ui_story == nil then
				arg_141_1.var_.characterEffect1043ui_story = var_144_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_17 = 0.200000002980232

			if var_144_16 <= arg_141_1.time_ and arg_141_1.time_ < var_144_16 + var_144_17 and not isNil(var_144_15) then
				local var_144_18 = (arg_141_1.time_ - var_144_16) / var_144_17

				if arg_141_1.var_.characterEffect1043ui_story and not isNil(var_144_15) then
					arg_141_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= var_144_16 + var_144_17 and arg_141_1.time_ < var_144_16 + var_144_17 + arg_144_0 and not isNil(var_144_15) and arg_141_1.var_.characterEffect1043ui_story then
				arg_141_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_144_19 = 0

			if var_144_19 < arg_141_1.time_ and arg_141_1.time_ <= var_144_19 + arg_144_0 then
				arg_141_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_144_20 = 0

			if var_144_20 < arg_141_1.time_ and arg_141_1.time_ <= var_144_20 + arg_144_0 then
				arg_141_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action1_1")
			end

			local var_144_21 = 0
			local var_144_22 = 0.225

			if var_144_21 < arg_141_1.time_ and arg_141_1.time_ <= var_144_21 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_23 = arg_141_1:FormatText(StoryNameCfg[1156].name)

				arg_141_1.leftNameTxt_.text = var_144_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_24 = arg_141_1:GetWordFromCfg(420012034)
				local var_144_25 = arg_141_1:FormatText(var_144_24.content)

				arg_141_1.text_.text = var_144_25

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_26 = 9
				local var_144_27 = utf8.len(var_144_25)
				local var_144_28 = var_144_26 <= 0 and var_144_22 or var_144_22 * (var_144_27 / var_144_26)

				if var_144_28 > 0 and var_144_22 < var_144_28 then
					arg_141_1.talkMaxDuration = var_144_28

					if var_144_28 + var_144_21 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_28 + var_144_21
					end
				end

				arg_141_1.text_.text = var_144_25
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012034", "story_v_out_420012.awb") ~= 0 then
					local var_144_29 = manager.audio:GetVoiceLength("story_v_out_420012", "420012034", "story_v_out_420012.awb") / 1000

					if var_144_29 + var_144_21 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_29 + var_144_21
					end

					if var_144_24.prefab_name ~= "" and arg_141_1.actors_[var_144_24.prefab_name] ~= nil then
						local var_144_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_24.prefab_name].transform, "story_v_out_420012", "420012034", "story_v_out_420012.awb")

						arg_141_1:RecordAudio("420012034", var_144_30)
						arg_141_1:RecordAudio("420012034", var_144_30)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_420012", "420012034", "story_v_out_420012.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_420012", "420012034", "story_v_out_420012.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_31 = math.max(var_144_22, arg_141_1.talkMaxDuration)

			if var_144_21 <= arg_141_1.time_ and arg_141_1.time_ < var_144_21 + var_144_31 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_21) / var_144_31

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_21 + var_144_31 and arg_141_1.time_ < var_144_21 + var_144_31 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_141_1:InitPlayNodeList()
	end,
	Play420012035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 420012035
		arg_145_1.duration_ = 5.33

		local var_145_0 = {
			zh = 3.766,
			ja = 5.333
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
				arg_145_0:Play420012036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["404001ui_story"].transform
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 then
				arg_145_1.var_.moveOldPos404001ui_story = var_148_0.localPosition
			end

			local var_148_2 = 0.001

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_2 then
				local var_148_3 = (arg_145_1.time_ - var_148_1) / var_148_2
				local var_148_4 = Vector3.New(0, -1.55, -5.5)

				var_148_0.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos404001ui_story, var_148_4, var_148_3)

				local var_148_5 = manager.ui.mainCamera.transform.position - var_148_0.position

				var_148_0.forward = Vector3.New(var_148_5.x, var_148_5.y, var_148_5.z)

				local var_148_6 = var_148_0.localEulerAngles

				var_148_6.z = 0
				var_148_6.x = 0
				var_148_0.localEulerAngles = var_148_6
			end

			if arg_145_1.time_ >= var_148_1 + var_148_2 and arg_145_1.time_ < var_148_1 + var_148_2 + arg_148_0 then
				var_148_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_148_7 = manager.ui.mainCamera.transform.position - var_148_0.position

				var_148_0.forward = Vector3.New(var_148_7.x, var_148_7.y, var_148_7.z)

				local var_148_8 = var_148_0.localEulerAngles

				var_148_8.z = 0
				var_148_8.x = 0
				var_148_0.localEulerAngles = var_148_8
			end

			local var_148_9 = arg_145_1.actors_["1043ui_story"].transform
			local var_148_10 = 0

			if var_148_10 < arg_145_1.time_ and arg_145_1.time_ <= var_148_10 + arg_148_0 then
				arg_145_1.var_.moveOldPos1043ui_story = var_148_9.localPosition
			end

			local var_148_11 = 0.001

			if var_148_10 <= arg_145_1.time_ and arg_145_1.time_ < var_148_10 + var_148_11 then
				local var_148_12 = (arg_145_1.time_ - var_148_10) / var_148_11
				local var_148_13 = Vector3.New(0, 100, 0)

				var_148_9.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1043ui_story, var_148_13, var_148_12)

				local var_148_14 = manager.ui.mainCamera.transform.position - var_148_9.position

				var_148_9.forward = Vector3.New(var_148_14.x, var_148_14.y, var_148_14.z)

				local var_148_15 = var_148_9.localEulerAngles

				var_148_15.z = 0
				var_148_15.x = 0
				var_148_9.localEulerAngles = var_148_15
			end

			if arg_145_1.time_ >= var_148_10 + var_148_11 and arg_145_1.time_ < var_148_10 + var_148_11 + arg_148_0 then
				var_148_9.localPosition = Vector3.New(0, 100, 0)

				local var_148_16 = manager.ui.mainCamera.transform.position - var_148_9.position

				var_148_9.forward = Vector3.New(var_148_16.x, var_148_16.y, var_148_16.z)

				local var_148_17 = var_148_9.localEulerAngles

				var_148_17.z = 0
				var_148_17.x = 0
				var_148_9.localEulerAngles = var_148_17
			end

			local var_148_18 = arg_145_1.actors_["404001ui_story"]
			local var_148_19 = 0

			if var_148_19 < arg_145_1.time_ and arg_145_1.time_ <= var_148_19 + arg_148_0 and not isNil(var_148_18) and arg_145_1.var_.characterEffect404001ui_story == nil then
				arg_145_1.var_.characterEffect404001ui_story = var_148_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_20 = 0.200000002980232

			if var_148_19 <= arg_145_1.time_ and arg_145_1.time_ < var_148_19 + var_148_20 and not isNil(var_148_18) then
				local var_148_21 = (arg_145_1.time_ - var_148_19) / var_148_20

				if arg_145_1.var_.characterEffect404001ui_story and not isNil(var_148_18) then
					arg_145_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= var_148_19 + var_148_20 and arg_145_1.time_ < var_148_19 + var_148_20 + arg_148_0 and not isNil(var_148_18) and arg_145_1.var_.characterEffect404001ui_story then
				arg_145_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_148_22 = 0

			if var_148_22 < arg_145_1.time_ and arg_145_1.time_ <= var_148_22 + arg_148_0 then
				arg_145_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva", "EmotionTimelineAnimator")
			end

			local var_148_23 = 0
			local var_148_24 = 0.5

			if var_148_23 < arg_145_1.time_ and arg_145_1.time_ <= var_148_23 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_25 = arg_145_1:FormatText(StoryNameCfg[668].name)

				arg_145_1.leftNameTxt_.text = var_148_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_26 = arg_145_1:GetWordFromCfg(420012035)
				local var_148_27 = arg_145_1:FormatText(var_148_26.content)

				arg_145_1.text_.text = var_148_27

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_28 = 20
				local var_148_29 = utf8.len(var_148_27)
				local var_148_30 = var_148_28 <= 0 and var_148_24 or var_148_24 * (var_148_29 / var_148_28)

				if var_148_30 > 0 and var_148_24 < var_148_30 then
					arg_145_1.talkMaxDuration = var_148_30

					if var_148_30 + var_148_23 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_30 + var_148_23
					end
				end

				arg_145_1.text_.text = var_148_27
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012035", "story_v_out_420012.awb") ~= 0 then
					local var_148_31 = manager.audio:GetVoiceLength("story_v_out_420012", "420012035", "story_v_out_420012.awb") / 1000

					if var_148_31 + var_148_23 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_31 + var_148_23
					end

					if var_148_26.prefab_name ~= "" and arg_145_1.actors_[var_148_26.prefab_name] ~= nil then
						local var_148_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_26.prefab_name].transform, "story_v_out_420012", "420012035", "story_v_out_420012.awb")

						arg_145_1:RecordAudio("420012035", var_148_32)
						arg_145_1:RecordAudio("420012035", var_148_32)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_420012", "420012035", "story_v_out_420012.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_420012", "420012035", "story_v_out_420012.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_33 = math.max(var_148_24, arg_145_1.talkMaxDuration)

			if var_148_23 <= arg_145_1.time_ and arg_145_1.time_ < var_148_23 + var_148_33 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_23) / var_148_33

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_23 + var_148_33 and arg_145_1.time_ < var_148_23 + var_148_33 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play420012036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 420012036
		arg_149_1.duration_ = 5.6

		local var_149_0 = {
			zh = 4.466,
			ja = 5.6
		}
		local var_149_1 = manager.audio:GetLocalizationFlag()

		if var_149_0[var_149_1] ~= nil then
			arg_149_1.duration_ = var_149_0[var_149_1]
		end

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play420012037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["404001ui_story"].transform
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 then
				arg_149_1.var_.moveOldPos404001ui_story = var_152_0.localPosition
			end

			local var_152_2 = 0.001

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_2 then
				local var_152_3 = (arg_149_1.time_ - var_152_1) / var_152_2
				local var_152_4 = Vector3.New(-0.8, -1.55, -5.5)

				var_152_0.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos404001ui_story, var_152_4, var_152_3)

				local var_152_5 = manager.ui.mainCamera.transform.position - var_152_0.position

				var_152_0.forward = Vector3.New(var_152_5.x, var_152_5.y, var_152_5.z)

				local var_152_6 = var_152_0.localEulerAngles

				var_152_6.z = 0
				var_152_6.x = 0
				var_152_0.localEulerAngles = var_152_6
			end

			if arg_149_1.time_ >= var_152_1 + var_152_2 and arg_149_1.time_ < var_152_1 + var_152_2 + arg_152_0 then
				var_152_0.localPosition = Vector3.New(-0.8, -1.55, -5.5)

				local var_152_7 = manager.ui.mainCamera.transform.position - var_152_0.position

				var_152_0.forward = Vector3.New(var_152_7.x, var_152_7.y, var_152_7.z)

				local var_152_8 = var_152_0.localEulerAngles

				var_152_8.z = 0
				var_152_8.x = 0
				var_152_0.localEulerAngles = var_152_8
			end

			local var_152_9 = arg_149_1.actors_["404001ui_story"]
			local var_152_10 = 0

			if var_152_10 < arg_149_1.time_ and arg_149_1.time_ <= var_152_10 + arg_152_0 and not isNil(var_152_9) and arg_149_1.var_.characterEffect404001ui_story == nil then
				arg_149_1.var_.characterEffect404001ui_story = var_152_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_11 = 0.200000002980232

			if var_152_10 <= arg_149_1.time_ and arg_149_1.time_ < var_152_10 + var_152_11 and not isNil(var_152_9) then
				local var_152_12 = (arg_149_1.time_ - var_152_10) / var_152_11

				if arg_149_1.var_.characterEffect404001ui_story and not isNil(var_152_9) then
					local var_152_13 = Mathf.Lerp(0, 0.5, var_152_12)

					arg_149_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_149_1.var_.characterEffect404001ui_story.fillRatio = var_152_13
				end
			end

			if arg_149_1.time_ >= var_152_10 + var_152_11 and arg_149_1.time_ < var_152_10 + var_152_11 + arg_152_0 and not isNil(var_152_9) and arg_149_1.var_.characterEffect404001ui_story then
				local var_152_14 = 0.5

				arg_149_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_149_1.var_.characterEffect404001ui_story.fillRatio = var_152_14
			end

			local var_152_15 = arg_149_1.actors_["1043ui_story"].transform
			local var_152_16 = 0

			if var_152_16 < arg_149_1.time_ and arg_149_1.time_ <= var_152_16 + arg_152_0 then
				arg_149_1.var_.moveOldPos1043ui_story = var_152_15.localPosition
			end

			local var_152_17 = 0.001

			if var_152_16 <= arg_149_1.time_ and arg_149_1.time_ < var_152_16 + var_152_17 then
				local var_152_18 = (arg_149_1.time_ - var_152_16) / var_152_17
				local var_152_19 = Vector3.New(0.81, -1.01, -5.73)

				var_152_15.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1043ui_story, var_152_19, var_152_18)

				local var_152_20 = manager.ui.mainCamera.transform.position - var_152_15.position

				var_152_15.forward = Vector3.New(var_152_20.x, var_152_20.y, var_152_20.z)

				local var_152_21 = var_152_15.localEulerAngles

				var_152_21.z = 0
				var_152_21.x = 0
				var_152_15.localEulerAngles = var_152_21
			end

			if arg_149_1.time_ >= var_152_16 + var_152_17 and arg_149_1.time_ < var_152_16 + var_152_17 + arg_152_0 then
				var_152_15.localPosition = Vector3.New(0.81, -1.01, -5.73)

				local var_152_22 = manager.ui.mainCamera.transform.position - var_152_15.position

				var_152_15.forward = Vector3.New(var_152_22.x, var_152_22.y, var_152_22.z)

				local var_152_23 = var_152_15.localEulerAngles

				var_152_23.z = 0
				var_152_23.x = 0
				var_152_15.localEulerAngles = var_152_23
			end

			local var_152_24 = arg_149_1.actors_["1043ui_story"]
			local var_152_25 = 0

			if var_152_25 < arg_149_1.time_ and arg_149_1.time_ <= var_152_25 + arg_152_0 and not isNil(var_152_24) and arg_149_1.var_.characterEffect1043ui_story == nil then
				arg_149_1.var_.characterEffect1043ui_story = var_152_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_26 = 0.200000002980232

			if var_152_25 <= arg_149_1.time_ and arg_149_1.time_ < var_152_25 + var_152_26 and not isNil(var_152_24) then
				local var_152_27 = (arg_149_1.time_ - var_152_25) / var_152_26

				if arg_149_1.var_.characterEffect1043ui_story and not isNil(var_152_24) then
					arg_149_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= var_152_25 + var_152_26 and arg_149_1.time_ < var_152_25 + var_152_26 + arg_152_0 and not isNil(var_152_24) and arg_149_1.var_.characterEffect1043ui_story then
				arg_149_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_152_28 = 0

			if var_152_28 < arg_149_1.time_ and arg_149_1.time_ <= var_152_28 + arg_152_0 then
				arg_149_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_152_29 = 0

			if var_152_29 < arg_149_1.time_ and arg_149_1.time_ <= var_152_29 + arg_152_0 then
				arg_149_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action4_1")
			end

			local var_152_30 = 0
			local var_152_31 = 0.625

			if var_152_30 < arg_149_1.time_ and arg_149_1.time_ <= var_152_30 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_32 = arg_149_1:FormatText(StoryNameCfg[1156].name)

				arg_149_1.leftNameTxt_.text = var_152_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_33 = arg_149_1:GetWordFromCfg(420012036)
				local var_152_34 = arg_149_1:FormatText(var_152_33.content)

				arg_149_1.text_.text = var_152_34

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_35 = 25
				local var_152_36 = utf8.len(var_152_34)
				local var_152_37 = var_152_35 <= 0 and var_152_31 or var_152_31 * (var_152_36 / var_152_35)

				if var_152_37 > 0 and var_152_31 < var_152_37 then
					arg_149_1.talkMaxDuration = var_152_37

					if var_152_37 + var_152_30 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_37 + var_152_30
					end
				end

				arg_149_1.text_.text = var_152_34
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012036", "story_v_out_420012.awb") ~= 0 then
					local var_152_38 = manager.audio:GetVoiceLength("story_v_out_420012", "420012036", "story_v_out_420012.awb") / 1000

					if var_152_38 + var_152_30 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_38 + var_152_30
					end

					if var_152_33.prefab_name ~= "" and arg_149_1.actors_[var_152_33.prefab_name] ~= nil then
						local var_152_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_33.prefab_name].transform, "story_v_out_420012", "420012036", "story_v_out_420012.awb")

						arg_149_1:RecordAudio("420012036", var_152_39)
						arg_149_1:RecordAudio("420012036", var_152_39)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_420012", "420012036", "story_v_out_420012.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_420012", "420012036", "story_v_out_420012.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_40 = math.max(var_152_31, arg_149_1.talkMaxDuration)

			if var_152_30 <= arg_149_1.time_ and arg_149_1.time_ < var_152_30 + var_152_40 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_30) / var_152_40

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_30 + var_152_40 and arg_149_1.time_ < var_152_30 + var_152_40 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_149_1:InitPlayNodeList()
	end,
	Play420012037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 420012037
		arg_153_1.duration_ = 4.17

		local var_153_0 = {
			zh = 1.5,
			ja = 4.166
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
				arg_153_0:Play420012038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0
			local var_156_1 = 0.15

			if var_156_0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_2 = arg_153_1:FormatText(StoryNameCfg[1156].name)

				arg_153_1.leftNameTxt_.text = var_156_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_3 = arg_153_1:GetWordFromCfg(420012037)
				local var_156_4 = arg_153_1:FormatText(var_156_3.content)

				arg_153_1.text_.text = var_156_4

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_5 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012037", "story_v_out_420012.awb") ~= 0 then
					local var_156_8 = manager.audio:GetVoiceLength("story_v_out_420012", "420012037", "story_v_out_420012.awb") / 1000

					if var_156_8 + var_156_0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_8 + var_156_0
					end

					if var_156_3.prefab_name ~= "" and arg_153_1.actors_[var_156_3.prefab_name] ~= nil then
						local var_156_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_3.prefab_name].transform, "story_v_out_420012", "420012037", "story_v_out_420012.awb")

						arg_153_1:RecordAudio("420012037", var_156_9)
						arg_153_1:RecordAudio("420012037", var_156_9)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_420012", "420012037", "story_v_out_420012.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_420012", "420012037", "story_v_out_420012.awb")
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
	Play420012038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 420012038
		arg_157_1.duration_ = 5.97

		local var_157_0 = {
			zh = 4.633,
			ja = 5.966
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
				arg_157_0:Play420012039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["1043ui_story"]
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.characterEffect1043ui_story == nil then
				arg_157_1.var_.characterEffect1043ui_story = var_160_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_2 = 0.200000002980232

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_2 and not isNil(var_160_0) then
				local var_160_3 = (arg_157_1.time_ - var_160_1) / var_160_2

				if arg_157_1.var_.characterEffect1043ui_story and not isNil(var_160_0) then
					local var_160_4 = Mathf.Lerp(0, 0.5, var_160_3)

					arg_157_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_157_1.var_.characterEffect1043ui_story.fillRatio = var_160_4
				end
			end

			if arg_157_1.time_ >= var_160_1 + var_160_2 and arg_157_1.time_ < var_160_1 + var_160_2 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.characterEffect1043ui_story then
				local var_160_5 = 0.5

				arg_157_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_157_1.var_.characterEffect1043ui_story.fillRatio = var_160_5
			end

			local var_160_6 = arg_157_1.actors_["404001ui_story"]
			local var_160_7 = 0

			if var_160_7 < arg_157_1.time_ and arg_157_1.time_ <= var_160_7 + arg_160_0 and not isNil(var_160_6) and arg_157_1.var_.characterEffect404001ui_story == nil then
				arg_157_1.var_.characterEffect404001ui_story = var_160_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_8 = 0.200000002980232

			if var_160_7 <= arg_157_1.time_ and arg_157_1.time_ < var_160_7 + var_160_8 and not isNil(var_160_6) then
				local var_160_9 = (arg_157_1.time_ - var_160_7) / var_160_8

				if arg_157_1.var_.characterEffect404001ui_story and not isNil(var_160_6) then
					arg_157_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= var_160_7 + var_160_8 and arg_157_1.time_ < var_160_7 + var_160_8 + arg_160_0 and not isNil(var_160_6) and arg_157_1.var_.characterEffect404001ui_story then
				arg_157_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_160_10 = 0

			if var_160_10 < arg_157_1.time_ and arg_157_1.time_ <= var_160_10 + arg_160_0 then
				arg_157_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_160_11 = 0
			local var_160_12 = 0.575

			if var_160_11 < arg_157_1.time_ and arg_157_1.time_ <= var_160_11 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_13 = arg_157_1:FormatText(StoryNameCfg[668].name)

				arg_157_1.leftNameTxt_.text = var_160_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_14 = arg_157_1:GetWordFromCfg(420012038)
				local var_160_15 = arg_157_1:FormatText(var_160_14.content)

				arg_157_1.text_.text = var_160_15

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_16 = 23
				local var_160_17 = utf8.len(var_160_15)
				local var_160_18 = var_160_16 <= 0 and var_160_12 or var_160_12 * (var_160_17 / var_160_16)

				if var_160_18 > 0 and var_160_12 < var_160_18 then
					arg_157_1.talkMaxDuration = var_160_18

					if var_160_18 + var_160_11 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_18 + var_160_11
					end
				end

				arg_157_1.text_.text = var_160_15
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012038", "story_v_out_420012.awb") ~= 0 then
					local var_160_19 = manager.audio:GetVoiceLength("story_v_out_420012", "420012038", "story_v_out_420012.awb") / 1000

					if var_160_19 + var_160_11 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_19 + var_160_11
					end

					if var_160_14.prefab_name ~= "" and arg_157_1.actors_[var_160_14.prefab_name] ~= nil then
						local var_160_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_14.prefab_name].transform, "story_v_out_420012", "420012038", "story_v_out_420012.awb")

						arg_157_1:RecordAudio("420012038", var_160_20)
						arg_157_1:RecordAudio("420012038", var_160_20)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_420012", "420012038", "story_v_out_420012.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_420012", "420012038", "story_v_out_420012.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_21 = math.max(var_160_12, arg_157_1.talkMaxDuration)

			if var_160_11 <= arg_157_1.time_ and arg_157_1.time_ < var_160_11 + var_160_21 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_11) / var_160_21

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_11 + var_160_21 and arg_157_1.time_ < var_160_11 + var_160_21 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play420012039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 420012039
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play420012040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = arg_161_1.actors_["404001ui_story"]
			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.characterEffect404001ui_story == nil then
				arg_161_1.var_.characterEffect404001ui_story = var_164_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_2 = 0.200000002980232

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_2 and not isNil(var_164_0) then
				local var_164_3 = (arg_161_1.time_ - var_164_1) / var_164_2

				if arg_161_1.var_.characterEffect404001ui_story and not isNil(var_164_0) then
					local var_164_4 = Mathf.Lerp(0, 0.5, var_164_3)

					arg_161_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_161_1.var_.characterEffect404001ui_story.fillRatio = var_164_4
				end
			end

			if arg_161_1.time_ >= var_164_1 + var_164_2 and arg_161_1.time_ < var_164_1 + var_164_2 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.characterEffect404001ui_story then
				local var_164_5 = 0.5

				arg_161_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_161_1.var_.characterEffect404001ui_story.fillRatio = var_164_5
			end

			local var_164_6 = 0
			local var_164_7 = 1

			if var_164_6 < arg_161_1.time_ and arg_161_1.time_ <= var_164_6 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, false)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_8 = arg_161_1:GetWordFromCfg(420012039)
				local var_164_9 = arg_161_1:FormatText(var_164_8.content)

				arg_161_1.text_.text = var_164_9

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_10 = 40
				local var_164_11 = utf8.len(var_164_9)
				local var_164_12 = var_164_10 <= 0 and var_164_7 or var_164_7 * (var_164_11 / var_164_10)

				if var_164_12 > 0 and var_164_7 < var_164_12 then
					arg_161_1.talkMaxDuration = var_164_12

					if var_164_12 + var_164_6 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_12 + var_164_6
					end
				end

				arg_161_1.text_.text = var_164_9
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_13 = math.max(var_164_7, arg_161_1.talkMaxDuration)

			if var_164_6 <= arg_161_1.time_ and arg_161_1.time_ < var_164_6 + var_164_13 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_6) / var_164_13

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_6 + var_164_13 and arg_161_1.time_ < var_164_6 + var_164_13 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play420012040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 420012040
		arg_165_1.duration_ = 7.7

		local var_165_0 = {
			zh = 5.633,
			ja = 7.7
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
				arg_165_0:Play420012041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = arg_165_1.actors_["1043ui_story"]
			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.characterEffect1043ui_story == nil then
				arg_165_1.var_.characterEffect1043ui_story = var_168_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_2 = 0.200000002980232

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_2 and not isNil(var_168_0) then
				local var_168_3 = (arg_165_1.time_ - var_168_1) / var_168_2

				if arg_165_1.var_.characterEffect1043ui_story and not isNil(var_168_0) then
					arg_165_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= var_168_1 + var_168_2 and arg_165_1.time_ < var_168_1 + var_168_2 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.characterEffect1043ui_story then
				arg_165_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_168_4 = 0

			if var_168_4 < arg_165_1.time_ and arg_165_1.time_ <= var_168_4 + arg_168_0 then
				arg_165_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action4_2")
			end

			local var_168_5 = 0
			local var_168_6 = 0.55

			if var_168_5 < arg_165_1.time_ and arg_165_1.time_ <= var_168_5 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_7 = arg_165_1:FormatText(StoryNameCfg[1156].name)

				arg_165_1.leftNameTxt_.text = var_168_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_8 = arg_165_1:GetWordFromCfg(420012040)
				local var_168_9 = arg_165_1:FormatText(var_168_8.content)

				arg_165_1.text_.text = var_168_9

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_10 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012040", "story_v_out_420012.awb") ~= 0 then
					local var_168_13 = manager.audio:GetVoiceLength("story_v_out_420012", "420012040", "story_v_out_420012.awb") / 1000

					if var_168_13 + var_168_5 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_13 + var_168_5
					end

					if var_168_8.prefab_name ~= "" and arg_165_1.actors_[var_168_8.prefab_name] ~= nil then
						local var_168_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_8.prefab_name].transform, "story_v_out_420012", "420012040", "story_v_out_420012.awb")

						arg_165_1:RecordAudio("420012040", var_168_14)
						arg_165_1:RecordAudio("420012040", var_168_14)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_420012", "420012040", "story_v_out_420012.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_420012", "420012040", "story_v_out_420012.awb")
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
	Play420012041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 420012041
		arg_169_1.duration_ = 3.37

		local var_169_0 = {
			zh = 2.4,
			ja = 3.366
		}
		local var_169_1 = manager.audio:GetLocalizationFlag()

		if var_169_0[var_169_1] ~= nil then
			arg_169_1.duration_ = var_169_0[var_169_1]
		end

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play420012042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.actors_["1043ui_story"]
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.characterEffect1043ui_story == nil then
				arg_169_1.var_.characterEffect1043ui_story = var_172_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_2 = 0.200000002980232

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_2 and not isNil(var_172_0) then
				local var_172_3 = (arg_169_1.time_ - var_172_1) / var_172_2

				if arg_169_1.var_.characterEffect1043ui_story and not isNil(var_172_0) then
					local var_172_4 = Mathf.Lerp(0, 0.5, var_172_3)

					arg_169_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_169_1.var_.characterEffect1043ui_story.fillRatio = var_172_4
				end
			end

			if arg_169_1.time_ >= var_172_1 + var_172_2 and arg_169_1.time_ < var_172_1 + var_172_2 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.characterEffect1043ui_story then
				local var_172_5 = 0.5

				arg_169_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_169_1.var_.characterEffect1043ui_story.fillRatio = var_172_5
			end

			local var_172_6 = arg_169_1.actors_["404001ui_story"]
			local var_172_7 = 0

			if var_172_7 < arg_169_1.time_ and arg_169_1.time_ <= var_172_7 + arg_172_0 and not isNil(var_172_6) and arg_169_1.var_.characterEffect404001ui_story == nil then
				arg_169_1.var_.characterEffect404001ui_story = var_172_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_8 = 0.200000002980232

			if var_172_7 <= arg_169_1.time_ and arg_169_1.time_ < var_172_7 + var_172_8 and not isNil(var_172_6) then
				local var_172_9 = (arg_169_1.time_ - var_172_7) / var_172_8

				if arg_169_1.var_.characterEffect404001ui_story and not isNil(var_172_6) then
					arg_169_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= var_172_7 + var_172_8 and arg_169_1.time_ < var_172_7 + var_172_8 + arg_172_0 and not isNil(var_172_6) and arg_169_1.var_.characterEffect404001ui_story then
				arg_169_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_172_10 = 0
			local var_172_11 = 0.25

			if var_172_10 < arg_169_1.time_ and arg_169_1.time_ <= var_172_10 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_12 = arg_169_1:FormatText(StoryNameCfg[668].name)

				arg_169_1.leftNameTxt_.text = var_172_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_13 = arg_169_1:GetWordFromCfg(420012041)
				local var_172_14 = arg_169_1:FormatText(var_172_13.content)

				arg_169_1.text_.text = var_172_14

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_15 = 10
				local var_172_16 = utf8.len(var_172_14)
				local var_172_17 = var_172_15 <= 0 and var_172_11 or var_172_11 * (var_172_16 / var_172_15)

				if var_172_17 > 0 and var_172_11 < var_172_17 then
					arg_169_1.talkMaxDuration = var_172_17

					if var_172_17 + var_172_10 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_17 + var_172_10
					end
				end

				arg_169_1.text_.text = var_172_14
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012041", "story_v_out_420012.awb") ~= 0 then
					local var_172_18 = manager.audio:GetVoiceLength("story_v_out_420012", "420012041", "story_v_out_420012.awb") / 1000

					if var_172_18 + var_172_10 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_18 + var_172_10
					end

					if var_172_13.prefab_name ~= "" and arg_169_1.actors_[var_172_13.prefab_name] ~= nil then
						local var_172_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_13.prefab_name].transform, "story_v_out_420012", "420012041", "story_v_out_420012.awb")

						arg_169_1:RecordAudio("420012041", var_172_19)
						arg_169_1:RecordAudio("420012041", var_172_19)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_420012", "420012041", "story_v_out_420012.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_420012", "420012041", "story_v_out_420012.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_20 = math.max(var_172_11, arg_169_1.talkMaxDuration)

			if var_172_10 <= arg_169_1.time_ and arg_169_1.time_ < var_172_10 + var_172_20 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_10) / var_172_20

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_10 + var_172_20 and arg_169_1.time_ < var_172_10 + var_172_20 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play420012042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 420012042
		arg_173_1.duration_ = 7.73

		local var_173_0 = {
			zh = 5.633,
			ja = 7.733
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
				arg_173_0:Play420012043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["1043ui_story"]
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.characterEffect1043ui_story == nil then
				arg_173_1.var_.characterEffect1043ui_story = var_176_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_2 = 0.200000002980232

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_2 and not isNil(var_176_0) then
				local var_176_3 = (arg_173_1.time_ - var_176_1) / var_176_2

				if arg_173_1.var_.characterEffect1043ui_story and not isNil(var_176_0) then
					arg_173_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= var_176_1 + var_176_2 and arg_173_1.time_ < var_176_1 + var_176_2 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.characterEffect1043ui_story then
				arg_173_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_176_4 = arg_173_1.actors_["404001ui_story"]
			local var_176_5 = 0

			if var_176_5 < arg_173_1.time_ and arg_173_1.time_ <= var_176_5 + arg_176_0 and not isNil(var_176_4) and arg_173_1.var_.characterEffect404001ui_story == nil then
				arg_173_1.var_.characterEffect404001ui_story = var_176_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_6 = 0.200000002980232

			if var_176_5 <= arg_173_1.time_ and arg_173_1.time_ < var_176_5 + var_176_6 and not isNil(var_176_4) then
				local var_176_7 = (arg_173_1.time_ - var_176_5) / var_176_6

				if arg_173_1.var_.characterEffect404001ui_story and not isNil(var_176_4) then
					local var_176_8 = Mathf.Lerp(0, 0.5, var_176_7)

					arg_173_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_173_1.var_.characterEffect404001ui_story.fillRatio = var_176_8
				end
			end

			if arg_173_1.time_ >= var_176_5 + var_176_6 and arg_173_1.time_ < var_176_5 + var_176_6 + arg_176_0 and not isNil(var_176_4) and arg_173_1.var_.characterEffect404001ui_story then
				local var_176_9 = 0.5

				arg_173_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_173_1.var_.characterEffect404001ui_story.fillRatio = var_176_9
			end

			local var_176_10 = 0
			local var_176_11 = 0.825

			if var_176_10 < arg_173_1.time_ and arg_173_1.time_ <= var_176_10 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_12 = arg_173_1:FormatText(StoryNameCfg[1156].name)

				arg_173_1.leftNameTxt_.text = var_176_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_13 = arg_173_1:GetWordFromCfg(420012042)
				local var_176_14 = arg_173_1:FormatText(var_176_13.content)

				arg_173_1.text_.text = var_176_14

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_15 = 33
				local var_176_16 = utf8.len(var_176_14)
				local var_176_17 = var_176_15 <= 0 and var_176_11 or var_176_11 * (var_176_16 / var_176_15)

				if var_176_17 > 0 and var_176_11 < var_176_17 then
					arg_173_1.talkMaxDuration = var_176_17

					if var_176_17 + var_176_10 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_17 + var_176_10
					end
				end

				arg_173_1.text_.text = var_176_14
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012042", "story_v_out_420012.awb") ~= 0 then
					local var_176_18 = manager.audio:GetVoiceLength("story_v_out_420012", "420012042", "story_v_out_420012.awb") / 1000

					if var_176_18 + var_176_10 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_18 + var_176_10
					end

					if var_176_13.prefab_name ~= "" and arg_173_1.actors_[var_176_13.prefab_name] ~= nil then
						local var_176_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_13.prefab_name].transform, "story_v_out_420012", "420012042", "story_v_out_420012.awb")

						arg_173_1:RecordAudio("420012042", var_176_19)
						arg_173_1:RecordAudio("420012042", var_176_19)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_420012", "420012042", "story_v_out_420012.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_420012", "420012042", "story_v_out_420012.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_20 = math.max(var_176_11, arg_173_1.talkMaxDuration)

			if var_176_10 <= arg_173_1.time_ and arg_173_1.time_ < var_176_10 + var_176_20 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_10) / var_176_20

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_10 + var_176_20 and arg_173_1.time_ < var_176_10 + var_176_20 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play420012043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 420012043
		arg_177_1.duration_ = 2.4

		local var_177_0 = {
			zh = 2.4,
			ja = 1.866
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
				arg_177_0:Play420012044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["1043ui_story"]
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.characterEffect1043ui_story == nil then
				arg_177_1.var_.characterEffect1043ui_story = var_180_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_2 = 0.200000002980232

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_2 and not isNil(var_180_0) then
				local var_180_3 = (arg_177_1.time_ - var_180_1) / var_180_2

				if arg_177_1.var_.characterEffect1043ui_story and not isNil(var_180_0) then
					local var_180_4 = Mathf.Lerp(0, 0.5, var_180_3)

					arg_177_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_177_1.var_.characterEffect1043ui_story.fillRatio = var_180_4
				end
			end

			if arg_177_1.time_ >= var_180_1 + var_180_2 and arg_177_1.time_ < var_180_1 + var_180_2 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.characterEffect1043ui_story then
				local var_180_5 = 0.5

				arg_177_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_177_1.var_.characterEffect1043ui_story.fillRatio = var_180_5
			end

			local var_180_6 = arg_177_1.actors_["404001ui_story"]
			local var_180_7 = 0

			if var_180_7 < arg_177_1.time_ and arg_177_1.time_ <= var_180_7 + arg_180_0 and not isNil(var_180_6) and arg_177_1.var_.characterEffect404001ui_story == nil then
				arg_177_1.var_.characterEffect404001ui_story = var_180_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_8 = 0.200000002980232

			if var_180_7 <= arg_177_1.time_ and arg_177_1.time_ < var_180_7 + var_180_8 and not isNil(var_180_6) then
				local var_180_9 = (arg_177_1.time_ - var_180_7) / var_180_8

				if arg_177_1.var_.characterEffect404001ui_story and not isNil(var_180_6) then
					arg_177_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= var_180_7 + var_180_8 and arg_177_1.time_ < var_180_7 + var_180_8 + arg_180_0 and not isNil(var_180_6) and arg_177_1.var_.characterEffect404001ui_story then
				arg_177_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_180_10 = 0
			local var_180_11 = 0.225

			if var_180_10 < arg_177_1.time_ and arg_177_1.time_ <= var_180_10 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_12 = arg_177_1:FormatText(StoryNameCfg[668].name)

				arg_177_1.leftNameTxt_.text = var_180_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_13 = arg_177_1:GetWordFromCfg(420012043)
				local var_180_14 = arg_177_1:FormatText(var_180_13.content)

				arg_177_1.text_.text = var_180_14

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_15 = 9
				local var_180_16 = utf8.len(var_180_14)
				local var_180_17 = var_180_15 <= 0 and var_180_11 or var_180_11 * (var_180_16 / var_180_15)

				if var_180_17 > 0 and var_180_11 < var_180_17 then
					arg_177_1.talkMaxDuration = var_180_17

					if var_180_17 + var_180_10 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_17 + var_180_10
					end
				end

				arg_177_1.text_.text = var_180_14
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012043", "story_v_out_420012.awb") ~= 0 then
					local var_180_18 = manager.audio:GetVoiceLength("story_v_out_420012", "420012043", "story_v_out_420012.awb") / 1000

					if var_180_18 + var_180_10 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_18 + var_180_10
					end

					if var_180_13.prefab_name ~= "" and arg_177_1.actors_[var_180_13.prefab_name] ~= nil then
						local var_180_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_13.prefab_name].transform, "story_v_out_420012", "420012043", "story_v_out_420012.awb")

						arg_177_1:RecordAudio("420012043", var_180_19)
						arg_177_1:RecordAudio("420012043", var_180_19)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_420012", "420012043", "story_v_out_420012.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_420012", "420012043", "story_v_out_420012.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_20 = math.max(var_180_11, arg_177_1.talkMaxDuration)

			if var_180_10 <= arg_177_1.time_ and arg_177_1.time_ < var_180_10 + var_180_20 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_10) / var_180_20

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_10 + var_180_20 and arg_177_1.time_ < var_180_10 + var_180_20 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play420012044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 420012044
		arg_181_1.duration_ = 1.2

		local var_181_0 = {
			zh = 0.999999999999,
			ja = 1.2
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
				arg_181_0:Play420012045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["1043ui_story"]
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.characterEffect1043ui_story == nil then
				arg_181_1.var_.characterEffect1043ui_story = var_184_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_2 = 0.200000002980232

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_2 and not isNil(var_184_0) then
				local var_184_3 = (arg_181_1.time_ - var_184_1) / var_184_2

				if arg_181_1.var_.characterEffect1043ui_story and not isNil(var_184_0) then
					arg_181_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= var_184_1 + var_184_2 and arg_181_1.time_ < var_184_1 + var_184_2 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.characterEffect1043ui_story then
				arg_181_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_184_4 = arg_181_1.actors_["404001ui_story"]
			local var_184_5 = 0

			if var_184_5 < arg_181_1.time_ and arg_181_1.time_ <= var_184_5 + arg_184_0 and not isNil(var_184_4) and arg_181_1.var_.characterEffect404001ui_story == nil then
				arg_181_1.var_.characterEffect404001ui_story = var_184_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_6 = 0.200000002980232

			if var_184_5 <= arg_181_1.time_ and arg_181_1.time_ < var_184_5 + var_184_6 and not isNil(var_184_4) then
				local var_184_7 = (arg_181_1.time_ - var_184_5) / var_184_6

				if arg_181_1.var_.characterEffect404001ui_story and not isNil(var_184_4) then
					local var_184_8 = Mathf.Lerp(0, 0.5, var_184_7)

					arg_181_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_181_1.var_.characterEffect404001ui_story.fillRatio = var_184_8
				end
			end

			if arg_181_1.time_ >= var_184_5 + var_184_6 and arg_181_1.time_ < var_184_5 + var_184_6 + arg_184_0 and not isNil(var_184_4) and arg_181_1.var_.characterEffect404001ui_story then
				local var_184_9 = 0.5

				arg_181_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_181_1.var_.characterEffect404001ui_story.fillRatio = var_184_9
			end

			local var_184_10 = 0
			local var_184_11 = 0.075

			if var_184_10 < arg_181_1.time_ and arg_181_1.time_ <= var_184_10 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_12 = arg_181_1:FormatText(StoryNameCfg[1156].name)

				arg_181_1.leftNameTxt_.text = var_184_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_13 = arg_181_1:GetWordFromCfg(420012044)
				local var_184_14 = arg_181_1:FormatText(var_184_13.content)

				arg_181_1.text_.text = var_184_14

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_15 = 3
				local var_184_16 = utf8.len(var_184_14)
				local var_184_17 = var_184_15 <= 0 and var_184_11 or var_184_11 * (var_184_16 / var_184_15)

				if var_184_17 > 0 and var_184_11 < var_184_17 then
					arg_181_1.talkMaxDuration = var_184_17

					if var_184_17 + var_184_10 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_17 + var_184_10
					end
				end

				arg_181_1.text_.text = var_184_14
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012044", "story_v_out_420012.awb") ~= 0 then
					local var_184_18 = manager.audio:GetVoiceLength("story_v_out_420012", "420012044", "story_v_out_420012.awb") / 1000

					if var_184_18 + var_184_10 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_18 + var_184_10
					end

					if var_184_13.prefab_name ~= "" and arg_181_1.actors_[var_184_13.prefab_name] ~= nil then
						local var_184_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_13.prefab_name].transform, "story_v_out_420012", "420012044", "story_v_out_420012.awb")

						arg_181_1:RecordAudio("420012044", var_184_19)
						arg_181_1:RecordAudio("420012044", var_184_19)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_420012", "420012044", "story_v_out_420012.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_420012", "420012044", "story_v_out_420012.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_20 = math.max(var_184_11, arg_181_1.talkMaxDuration)

			if var_184_10 <= arg_181_1.time_ and arg_181_1.time_ < var_184_10 + var_184_20 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_10) / var_184_20

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_10 + var_184_20 and arg_181_1.time_ < var_184_10 + var_184_20 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play420012045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 420012045
		arg_185_1.duration_ = 7.07

		local var_185_0 = {
			zh = 6.233,
			ja = 7.066
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
				arg_185_0:Play420012046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 2

			if var_188_0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_0 + arg_188_0 then
				local var_188_1 = manager.ui.mainCamera.transform.localPosition
				local var_188_2 = Vector3.New(0, 0, 10) + Vector3.New(var_188_1.x, var_188_1.y, 0)
				local var_188_3 = arg_185_1.bgs_.ST0505

				var_188_3.transform.localPosition = var_188_2
				var_188_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_188_4 = var_188_3:GetComponent("SpriteRenderer")

				if var_188_4 and var_188_4.sprite then
					local var_188_5 = (var_188_3.transform.localPosition - var_188_1).z
					local var_188_6 = manager.ui.mainCameraCom_
					local var_188_7 = 2 * var_188_5 * Mathf.Tan(var_188_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_188_8 = var_188_7 * var_188_6.aspect
					local var_188_9 = var_188_4.sprite.bounds.size.x
					local var_188_10 = var_188_4.sprite.bounds.size.y
					local var_188_11 = var_188_8 / var_188_9
					local var_188_12 = var_188_7 / var_188_10
					local var_188_13 = var_188_12 < var_188_11 and var_188_11 or var_188_12

					var_188_3.transform.localScale = Vector3.New(var_188_13, var_188_13, 0)
				end

				for iter_188_0, iter_188_1 in pairs(arg_185_1.bgs_) do
					if iter_188_0 ~= "ST0505" then
						iter_188_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_188_14 = 4

			if var_188_14 < arg_185_1.time_ and arg_185_1.time_ <= var_188_14 + arg_188_0 then
				arg_185_1.allBtn_.enabled = false
			end

			local var_188_15 = 0.0999999999999996

			if arg_185_1.time_ >= var_188_14 + var_188_15 and arg_185_1.time_ < var_188_14 + var_188_15 + arg_188_0 then
				arg_185_1.allBtn_.enabled = true
			end

			local var_188_16 = 0

			if var_188_16 < arg_185_1.time_ and arg_185_1.time_ <= var_188_16 + arg_188_0 then
				arg_185_1.mask_.enabled = true
				arg_185_1.mask_.raycastTarget = true

				arg_185_1:SetGaussion(false)
			end

			local var_188_17 = 2

			if var_188_16 <= arg_185_1.time_ and arg_185_1.time_ < var_188_16 + var_188_17 then
				local var_188_18 = (arg_185_1.time_ - var_188_16) / var_188_17
				local var_188_19 = Color.New(0, 0, 0)

				var_188_19.a = Mathf.Lerp(0, 1, var_188_18)
				arg_185_1.mask_.color = var_188_19
			end

			if arg_185_1.time_ >= var_188_16 + var_188_17 and arg_185_1.time_ < var_188_16 + var_188_17 + arg_188_0 then
				local var_188_20 = Color.New(0, 0, 0)

				var_188_20.a = 1
				arg_185_1.mask_.color = var_188_20
			end

			local var_188_21 = 2

			if var_188_21 < arg_185_1.time_ and arg_185_1.time_ <= var_188_21 + arg_188_0 then
				arg_185_1.mask_.enabled = true
				arg_185_1.mask_.raycastTarget = true

				arg_185_1:SetGaussion(false)
			end

			local var_188_22 = 2

			if var_188_21 <= arg_185_1.time_ and arg_185_1.time_ < var_188_21 + var_188_22 then
				local var_188_23 = (arg_185_1.time_ - var_188_21) / var_188_22
				local var_188_24 = Color.New(0, 0, 0)

				var_188_24.a = Mathf.Lerp(1, 0, var_188_23)
				arg_185_1.mask_.color = var_188_24
			end

			if arg_185_1.time_ >= var_188_21 + var_188_22 and arg_185_1.time_ < var_188_21 + var_188_22 + arg_188_0 then
				local var_188_25 = Color.New(0, 0, 0)
				local var_188_26 = 0

				arg_185_1.mask_.enabled = false
				var_188_25.a = var_188_26
				arg_185_1.mask_.color = var_188_25
			end

			local var_188_27 = arg_185_1.actors_["404001ui_story"].transform
			local var_188_28 = 2

			if var_188_28 < arg_185_1.time_ and arg_185_1.time_ <= var_188_28 + arg_188_0 then
				arg_185_1.var_.moveOldPos404001ui_story = var_188_27.localPosition
			end

			local var_188_29 = 0.001

			if var_188_28 <= arg_185_1.time_ and arg_185_1.time_ < var_188_28 + var_188_29 then
				local var_188_30 = (arg_185_1.time_ - var_188_28) / var_188_29
				local var_188_31 = Vector3.New(0, 100, 0)

				var_188_27.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos404001ui_story, var_188_31, var_188_30)

				local var_188_32 = manager.ui.mainCamera.transform.position - var_188_27.position

				var_188_27.forward = Vector3.New(var_188_32.x, var_188_32.y, var_188_32.z)

				local var_188_33 = var_188_27.localEulerAngles

				var_188_33.z = 0
				var_188_33.x = 0
				var_188_27.localEulerAngles = var_188_33
			end

			if arg_185_1.time_ >= var_188_28 + var_188_29 and arg_185_1.time_ < var_188_28 + var_188_29 + arg_188_0 then
				var_188_27.localPosition = Vector3.New(0, 100, 0)

				local var_188_34 = manager.ui.mainCamera.transform.position - var_188_27.position

				var_188_27.forward = Vector3.New(var_188_34.x, var_188_34.y, var_188_34.z)

				local var_188_35 = var_188_27.localEulerAngles

				var_188_35.z = 0
				var_188_35.x = 0
				var_188_27.localEulerAngles = var_188_35
			end

			local var_188_36 = arg_185_1.actors_["1085ui_story"].transform
			local var_188_37 = 2

			if var_188_37 < arg_185_1.time_ and arg_185_1.time_ <= var_188_37 + arg_188_0 then
				arg_185_1.var_.moveOldPos1085ui_story = var_188_36.localPosition
			end

			local var_188_38 = 0.001

			if var_188_37 <= arg_185_1.time_ and arg_185_1.time_ < var_188_37 + var_188_38 then
				local var_188_39 = (arg_185_1.time_ - var_188_37) / var_188_38
				local var_188_40 = Vector3.New(0, 100, 0)

				var_188_36.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1085ui_story, var_188_40, var_188_39)

				local var_188_41 = manager.ui.mainCamera.transform.position - var_188_36.position

				var_188_36.forward = Vector3.New(var_188_41.x, var_188_41.y, var_188_41.z)

				local var_188_42 = var_188_36.localEulerAngles

				var_188_42.z = 0
				var_188_42.x = 0
				var_188_36.localEulerAngles = var_188_42
			end

			if arg_185_1.time_ >= var_188_37 + var_188_38 and arg_185_1.time_ < var_188_37 + var_188_38 + arg_188_0 then
				var_188_36.localPosition = Vector3.New(0, 100, 0)

				local var_188_43 = manager.ui.mainCamera.transform.position - var_188_36.position

				var_188_36.forward = Vector3.New(var_188_43.x, var_188_43.y, var_188_43.z)

				local var_188_44 = var_188_36.localEulerAngles

				var_188_44.z = 0
				var_188_44.x = 0
				var_188_36.localEulerAngles = var_188_44
			end

			local var_188_45 = 1.33333333333333
			local var_188_46 = 1

			if var_188_45 < arg_185_1.time_ and arg_185_1.time_ <= var_188_45 + arg_188_0 then
				local var_188_47 = "stop"
				local var_188_48 = "effect"

				arg_185_1:AudioAction(var_188_47, var_188_48, "se_story_140", "se_story_140_amb_street01", "")
			end

			local var_188_49 = 1.6
			local var_188_50 = 1

			if var_188_49 < arg_185_1.time_ and arg_185_1.time_ <= var_188_49 + arg_188_0 then
				local var_188_51 = "play"
				local var_188_52 = "effect"

				arg_185_1:AudioAction(var_188_51, var_188_52, "se_story_140", "se_story_140_amb_room02", "")
			end

			local var_188_53 = arg_185_1.actors_["1085ui_story"].transform
			local var_188_54 = 3.86666666666667

			if var_188_54 < arg_185_1.time_ and arg_185_1.time_ <= var_188_54 + arg_188_0 then
				arg_185_1.var_.moveOldPos1085ui_story = var_188_53.localPosition
			end

			local var_188_55 = 0.001

			if var_188_54 <= arg_185_1.time_ and arg_185_1.time_ < var_188_54 + var_188_55 then
				local var_188_56 = (arg_185_1.time_ - var_188_54) / var_188_55
				local var_188_57 = Vector3.New(0, -1.01, -5.83)

				var_188_53.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1085ui_story, var_188_57, var_188_56)

				local var_188_58 = manager.ui.mainCamera.transform.position - var_188_53.position

				var_188_53.forward = Vector3.New(var_188_58.x, var_188_58.y, var_188_58.z)

				local var_188_59 = var_188_53.localEulerAngles

				var_188_59.z = 0
				var_188_59.x = 0
				var_188_53.localEulerAngles = var_188_59
			end

			if arg_185_1.time_ >= var_188_54 + var_188_55 and arg_185_1.time_ < var_188_54 + var_188_55 + arg_188_0 then
				var_188_53.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_188_60 = manager.ui.mainCamera.transform.position - var_188_53.position

				var_188_53.forward = Vector3.New(var_188_60.x, var_188_60.y, var_188_60.z)

				local var_188_61 = var_188_53.localEulerAngles

				var_188_61.z = 0
				var_188_61.x = 0
				var_188_53.localEulerAngles = var_188_61
			end

			local var_188_62 = arg_185_1.actors_["1085ui_story"]
			local var_188_63 = 3.86666666666667

			if var_188_63 < arg_185_1.time_ and arg_185_1.time_ <= var_188_63 + arg_188_0 and not isNil(var_188_62) and arg_185_1.var_.characterEffect1085ui_story == nil then
				arg_185_1.var_.characterEffect1085ui_story = var_188_62:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_64 = 0.200000002980232

			if var_188_63 <= arg_185_1.time_ and arg_185_1.time_ < var_188_63 + var_188_64 and not isNil(var_188_62) then
				local var_188_65 = (arg_185_1.time_ - var_188_63) / var_188_64

				if arg_185_1.var_.characterEffect1085ui_story and not isNil(var_188_62) then
					arg_185_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= var_188_63 + var_188_64 and arg_185_1.time_ < var_188_63 + var_188_64 + arg_188_0 and not isNil(var_188_62) and arg_185_1.var_.characterEffect1085ui_story then
				arg_185_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_188_66 = 3.86666666666667

			if var_188_66 < arg_185_1.time_ and arg_185_1.time_ <= var_188_66 + arg_188_0 then
				arg_185_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			local var_188_67 = 3.86666666666667

			if var_188_67 < arg_185_1.time_ and arg_185_1.time_ <= var_188_67 + arg_188_0 then
				arg_185_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_188_68 = arg_185_1.actors_["1043ui_story"].transform
			local var_188_69 = 2

			if var_188_69 < arg_185_1.time_ and arg_185_1.time_ <= var_188_69 + arg_188_0 then
				arg_185_1.var_.moveOldPos1043ui_story = var_188_68.localPosition
			end

			local var_188_70 = 0.001

			if var_188_69 <= arg_185_1.time_ and arg_185_1.time_ < var_188_69 + var_188_70 then
				local var_188_71 = (arg_185_1.time_ - var_188_69) / var_188_70
				local var_188_72 = Vector3.New(0, 100, 0)

				var_188_68.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1043ui_story, var_188_72, var_188_71)

				local var_188_73 = manager.ui.mainCamera.transform.position - var_188_68.position

				var_188_68.forward = Vector3.New(var_188_73.x, var_188_73.y, var_188_73.z)

				local var_188_74 = var_188_68.localEulerAngles

				var_188_74.z = 0
				var_188_74.x = 0
				var_188_68.localEulerAngles = var_188_74
			end

			if arg_185_1.time_ >= var_188_69 + var_188_70 and arg_185_1.time_ < var_188_69 + var_188_70 + arg_188_0 then
				var_188_68.localPosition = Vector3.New(0, 100, 0)

				local var_188_75 = manager.ui.mainCamera.transform.position - var_188_68.position

				var_188_68.forward = Vector3.New(var_188_75.x, var_188_75.y, var_188_75.z)

				local var_188_76 = var_188_68.localEulerAngles

				var_188_76.z = 0
				var_188_76.x = 0
				var_188_68.localEulerAngles = var_188_76
			end

			if arg_185_1.frameCnt_ <= 1 then
				arg_185_1.dialog_:SetActive(false)
			end

			local var_188_77 = 4
			local var_188_78 = 0.225

			if var_188_77 < arg_185_1.time_ and arg_185_1.time_ <= var_188_77 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0

				arg_185_1.dialog_:SetActive(true)

				arg_185_1.dialogCg_.alpha = 0

				local var_188_79 = LeanTween.value(arg_185_1.dialog_, 0, 1, 0.3)

				var_188_79:setOnUpdate(LuaHelper.FloatAction(function(arg_189_0)
					arg_185_1.dialogCg_.alpha = arg_189_0
				end))
				var_188_79:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_185_1.dialog_)
					var_188_79:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_185_1.duration_ = arg_185_1.duration_ + 0.3

				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_80 = arg_185_1:FormatText(StoryNameCfg[328].name)

				arg_185_1.leftNameTxt_.text = var_188_80

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_81 = arg_185_1:GetWordFromCfg(420012045)
				local var_188_82 = arg_185_1:FormatText(var_188_81.content)

				arg_185_1.text_.text = var_188_82

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_83 = 9
				local var_188_84 = utf8.len(var_188_82)
				local var_188_85 = var_188_83 <= 0 and var_188_78 or var_188_78 * (var_188_84 / var_188_83)

				if var_188_85 > 0 and var_188_78 < var_188_85 then
					arg_185_1.talkMaxDuration = var_188_85
					var_188_77 = var_188_77 + 0.3

					if var_188_85 + var_188_77 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_85 + var_188_77
					end
				end

				arg_185_1.text_.text = var_188_82
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012045", "story_v_out_420012.awb") ~= 0 then
					local var_188_86 = manager.audio:GetVoiceLength("story_v_out_420012", "420012045", "story_v_out_420012.awb") / 1000

					if var_188_86 + var_188_77 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_86 + var_188_77
					end

					if var_188_81.prefab_name ~= "" and arg_185_1.actors_[var_188_81.prefab_name] ~= nil then
						local var_188_87 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_81.prefab_name].transform, "story_v_out_420012", "420012045", "story_v_out_420012.awb")

						arg_185_1:RecordAudio("420012045", var_188_87)
						arg_185_1:RecordAudio("420012045", var_188_87)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_420012", "420012045", "story_v_out_420012.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_420012", "420012045", "story_v_out_420012.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_88 = var_188_77 + 0.3
			local var_188_89 = math.max(var_188_78, arg_185_1.talkMaxDuration)

			if var_188_88 <= arg_185_1.time_ and arg_185_1.time_ < var_188_88 + var_188_89 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_88) / var_188_89

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_88 + var_188_89 and arg_185_1.time_ < var_188_88 + var_188_89 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.86666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play420012046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 420012046
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play420012047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0.05
			local var_194_1 = 1

			if var_194_0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_0 + arg_194_0 then
				local var_194_2 = "play"
				local var_194_3 = "effect"

				arg_191_1:AudioAction(var_194_2, var_194_3, "se_story_140", "se_story_140_foley_phone", "")
			end

			local var_194_4 = arg_191_1.actors_["1085ui_story"].transform
			local var_194_5 = 0

			if var_194_5 < arg_191_1.time_ and arg_191_1.time_ <= var_194_5 + arg_194_0 then
				arg_191_1.var_.moveOldPos1085ui_story = var_194_4.localPosition
			end

			local var_194_6 = 0.001

			if var_194_5 <= arg_191_1.time_ and arg_191_1.time_ < var_194_5 + var_194_6 then
				local var_194_7 = (arg_191_1.time_ - var_194_5) / var_194_6
				local var_194_8 = Vector3.New(0, 100, 0)

				var_194_4.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos1085ui_story, var_194_8, var_194_7)

				local var_194_9 = manager.ui.mainCamera.transform.position - var_194_4.position

				var_194_4.forward = Vector3.New(var_194_9.x, var_194_9.y, var_194_9.z)

				local var_194_10 = var_194_4.localEulerAngles

				var_194_10.z = 0
				var_194_10.x = 0
				var_194_4.localEulerAngles = var_194_10
			end

			if arg_191_1.time_ >= var_194_5 + var_194_6 and arg_191_1.time_ < var_194_5 + var_194_6 + arg_194_0 then
				var_194_4.localPosition = Vector3.New(0, 100, 0)

				local var_194_11 = manager.ui.mainCamera.transform.position - var_194_4.position

				var_194_4.forward = Vector3.New(var_194_11.x, var_194_11.y, var_194_11.z)

				local var_194_12 = var_194_4.localEulerAngles

				var_194_12.z = 0
				var_194_12.x = 0
				var_194_4.localEulerAngles = var_194_12
			end

			local var_194_13 = 0
			local var_194_14 = 1.375

			if var_194_13 < arg_191_1.time_ and arg_191_1.time_ <= var_194_13 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, false)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_15 = arg_191_1:GetWordFromCfg(420012046)
				local var_194_16 = arg_191_1:FormatText(var_194_15.content)

				arg_191_1.text_.text = var_194_16

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_17 = 55
				local var_194_18 = utf8.len(var_194_16)
				local var_194_19 = var_194_17 <= 0 and var_194_14 or var_194_14 * (var_194_18 / var_194_17)

				if var_194_19 > 0 and var_194_14 < var_194_19 then
					arg_191_1.talkMaxDuration = var_194_19

					if var_194_19 + var_194_13 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_19 + var_194_13
					end
				end

				arg_191_1.text_.text = var_194_16
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_20 = math.max(var_194_14, arg_191_1.talkMaxDuration)

			if var_194_13 <= arg_191_1.time_ and arg_191_1.time_ < var_194_13 + var_194_20 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_13) / var_194_20

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_13 + var_194_20 and arg_191_1.time_ < var_194_13 + var_194_20 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_191_1:InitPlayNodeList()
	end,
	Play420012047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 420012047
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play420012048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 1.23333333333333
			local var_198_1 = 1

			if var_198_0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_0 + arg_198_0 then
				local var_198_2 = "play"
				local var_198_3 = "effect"

				arg_195_1:AudioAction(var_198_2, var_198_3, "se_story_140", "se_story_140_foley_paperbag02", "")
			end

			local var_198_4 = 0.05
			local var_198_5 = 1

			if var_198_4 < arg_195_1.time_ and arg_195_1.time_ <= var_198_4 + arg_198_0 then
				local var_198_6 = "play"
				local var_198_7 = "effect"

				arg_195_1:AudioAction(var_198_6, var_198_7, "se_story_17", "se_story_17_door_close", "")
			end

			local var_198_8 = 0
			local var_198_9 = 1.425

			if var_198_8 < arg_195_1.time_ and arg_195_1.time_ <= var_198_8 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, false)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_10 = arg_195_1:GetWordFromCfg(420012047)
				local var_198_11 = arg_195_1:FormatText(var_198_10.content)

				arg_195_1.text_.text = var_198_11

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_12 = 57
				local var_198_13 = utf8.len(var_198_11)
				local var_198_14 = var_198_12 <= 0 and var_198_9 or var_198_9 * (var_198_13 / var_198_12)

				if var_198_14 > 0 and var_198_9 < var_198_14 then
					arg_195_1.talkMaxDuration = var_198_14

					if var_198_14 + var_198_8 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_14 + var_198_8
					end
				end

				arg_195_1.text_.text = var_198_11
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_15 = math.max(var_198_9, arg_195_1.talkMaxDuration)

			if var_198_8 <= arg_195_1.time_ and arg_195_1.time_ < var_198_8 + var_198_15 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_8) / var_198_15

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_8 + var_198_15 and arg_195_1.time_ < var_198_8 + var_198_15 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play420012048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 420012048
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play420012049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0
			local var_202_1 = 0.625

			if var_202_0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, false)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_2 = arg_199_1:GetWordFromCfg(420012048)
				local var_202_3 = arg_199_1:FormatText(var_202_2.content)

				arg_199_1.text_.text = var_202_3

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_4 = 25
				local var_202_5 = utf8.len(var_202_3)
				local var_202_6 = var_202_4 <= 0 and var_202_1 or var_202_1 * (var_202_5 / var_202_4)

				if var_202_6 > 0 and var_202_1 < var_202_6 then
					arg_199_1.talkMaxDuration = var_202_6

					if var_202_6 + var_202_0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_6 + var_202_0
					end
				end

				arg_199_1.text_.text = var_202_3
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_7 = math.max(var_202_1, arg_199_1.talkMaxDuration)

			if var_202_0 <= arg_199_1.time_ and arg_199_1.time_ < var_202_0 + var_202_7 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_0) / var_202_7

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_0 + var_202_7 and arg_199_1.time_ < var_202_0 + var_202_7 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play420012049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 420012049
		arg_203_1.duration_ = 2.37

		local var_203_0 = {
			zh = 1.999999999999,
			ja = 2.366
		}
		local var_203_1 = manager.audio:GetLocalizationFlag()

		if var_203_0[var_203_1] ~= nil then
			arg_203_1.duration_ = var_203_0[var_203_1]
		end

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play420012050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = arg_203_1.actors_["404001ui_story"].transform
			local var_206_1 = 0

			if var_206_1 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 then
				arg_203_1.var_.moveOldPos404001ui_story = var_206_0.localPosition
			end

			local var_206_2 = 0.001

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_2 then
				local var_206_3 = (arg_203_1.time_ - var_206_1) / var_206_2
				local var_206_4 = Vector3.New(0, -1.55, -5.5)

				var_206_0.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos404001ui_story, var_206_4, var_206_3)

				local var_206_5 = manager.ui.mainCamera.transform.position - var_206_0.position

				var_206_0.forward = Vector3.New(var_206_5.x, var_206_5.y, var_206_5.z)

				local var_206_6 = var_206_0.localEulerAngles

				var_206_6.z = 0
				var_206_6.x = 0
				var_206_0.localEulerAngles = var_206_6
			end

			if arg_203_1.time_ >= var_206_1 + var_206_2 and arg_203_1.time_ < var_206_1 + var_206_2 + arg_206_0 then
				var_206_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_206_7 = manager.ui.mainCamera.transform.position - var_206_0.position

				var_206_0.forward = Vector3.New(var_206_7.x, var_206_7.y, var_206_7.z)

				local var_206_8 = var_206_0.localEulerAngles

				var_206_8.z = 0
				var_206_8.x = 0
				var_206_0.localEulerAngles = var_206_8
			end

			local var_206_9 = arg_203_1.actors_["404001ui_story"]
			local var_206_10 = 0

			if var_206_10 < arg_203_1.time_ and arg_203_1.time_ <= var_206_10 + arg_206_0 and not isNil(var_206_9) and arg_203_1.var_.characterEffect404001ui_story == nil then
				arg_203_1.var_.characterEffect404001ui_story = var_206_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_11 = 0.200000002980232

			if var_206_10 <= arg_203_1.time_ and arg_203_1.time_ < var_206_10 + var_206_11 and not isNil(var_206_9) then
				local var_206_12 = (arg_203_1.time_ - var_206_10) / var_206_11

				if arg_203_1.var_.characterEffect404001ui_story and not isNil(var_206_9) then
					arg_203_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= var_206_10 + var_206_11 and arg_203_1.time_ < var_206_10 + var_206_11 + arg_206_0 and not isNil(var_206_9) and arg_203_1.var_.characterEffect404001ui_story then
				arg_203_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_206_13 = 0

			if var_206_13 < arg_203_1.time_ and arg_203_1.time_ <= var_206_13 + arg_206_0 then
				arg_203_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_206_14 = 0
			local var_206_15 = 0.2

			if var_206_14 < arg_203_1.time_ and arg_203_1.time_ <= var_206_14 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_16 = arg_203_1:FormatText(StoryNameCfg[668].name)

				arg_203_1.leftNameTxt_.text = var_206_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_17 = arg_203_1:GetWordFromCfg(420012049)
				local var_206_18 = arg_203_1:FormatText(var_206_17.content)

				arg_203_1.text_.text = var_206_18

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_19 = 8
				local var_206_20 = utf8.len(var_206_18)
				local var_206_21 = var_206_19 <= 0 and var_206_15 or var_206_15 * (var_206_20 / var_206_19)

				if var_206_21 > 0 and var_206_15 < var_206_21 then
					arg_203_1.talkMaxDuration = var_206_21

					if var_206_21 + var_206_14 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_21 + var_206_14
					end
				end

				arg_203_1.text_.text = var_206_18
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012049", "story_v_out_420012.awb") ~= 0 then
					local var_206_22 = manager.audio:GetVoiceLength("story_v_out_420012", "420012049", "story_v_out_420012.awb") / 1000

					if var_206_22 + var_206_14 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_22 + var_206_14
					end

					if var_206_17.prefab_name ~= "" and arg_203_1.actors_[var_206_17.prefab_name] ~= nil then
						local var_206_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_17.prefab_name].transform, "story_v_out_420012", "420012049", "story_v_out_420012.awb")

						arg_203_1:RecordAudio("420012049", var_206_23)
						arg_203_1:RecordAudio("420012049", var_206_23)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_420012", "420012049", "story_v_out_420012.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_420012", "420012049", "story_v_out_420012.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_24 = math.max(var_206_15, arg_203_1.talkMaxDuration)

			if var_206_14 <= arg_203_1.time_ and arg_203_1.time_ < var_206_14 + var_206_24 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_14) / var_206_24

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_14 + var_206_24 and arg_203_1.time_ < var_206_14 + var_206_24 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_203_1:InitPlayNodeList()
	end,
	Play420012050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 420012050
		arg_207_1.duration_ = 2

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play420012051(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = arg_207_1.actors_["404001ui_story"].transform
			local var_210_1 = 0

			if var_210_1 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 then
				arg_207_1.var_.moveOldPos404001ui_story = var_210_0.localPosition
			end

			local var_210_2 = 0.001

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_2 then
				local var_210_3 = (arg_207_1.time_ - var_210_1) / var_210_2
				local var_210_4 = Vector3.New(-0.8, -1.55, -5.5)

				var_210_0.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos404001ui_story, var_210_4, var_210_3)

				local var_210_5 = manager.ui.mainCamera.transform.position - var_210_0.position

				var_210_0.forward = Vector3.New(var_210_5.x, var_210_5.y, var_210_5.z)

				local var_210_6 = var_210_0.localEulerAngles

				var_210_6.z = 0
				var_210_6.x = 0
				var_210_0.localEulerAngles = var_210_6
			end

			if arg_207_1.time_ >= var_210_1 + var_210_2 and arg_207_1.time_ < var_210_1 + var_210_2 + arg_210_0 then
				var_210_0.localPosition = Vector3.New(-0.8, -1.55, -5.5)

				local var_210_7 = manager.ui.mainCamera.transform.position - var_210_0.position

				var_210_0.forward = Vector3.New(var_210_7.x, var_210_7.y, var_210_7.z)

				local var_210_8 = var_210_0.localEulerAngles

				var_210_8.z = 0
				var_210_8.x = 0
				var_210_0.localEulerAngles = var_210_8
			end

			local var_210_9 = arg_207_1.actors_["1085ui_story"].transform
			local var_210_10 = 0

			if var_210_10 < arg_207_1.time_ and arg_207_1.time_ <= var_210_10 + arg_210_0 then
				arg_207_1.var_.moveOldPos1085ui_story = var_210_9.localPosition
			end

			local var_210_11 = 0.001

			if var_210_10 <= arg_207_1.time_ and arg_207_1.time_ < var_210_10 + var_210_11 then
				local var_210_12 = (arg_207_1.time_ - var_210_10) / var_210_11
				local var_210_13 = Vector3.New(0.75, -1.01, -5.83)

				var_210_9.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1085ui_story, var_210_13, var_210_12)

				local var_210_14 = manager.ui.mainCamera.transform.position - var_210_9.position

				var_210_9.forward = Vector3.New(var_210_14.x, var_210_14.y, var_210_14.z)

				local var_210_15 = var_210_9.localEulerAngles

				var_210_15.z = 0
				var_210_15.x = 0
				var_210_9.localEulerAngles = var_210_15
			end

			if arg_207_1.time_ >= var_210_10 + var_210_11 and arg_207_1.time_ < var_210_10 + var_210_11 + arg_210_0 then
				var_210_9.localPosition = Vector3.New(0.75, -1.01, -5.83)

				local var_210_16 = manager.ui.mainCamera.transform.position - var_210_9.position

				var_210_9.forward = Vector3.New(var_210_16.x, var_210_16.y, var_210_16.z)

				local var_210_17 = var_210_9.localEulerAngles

				var_210_17.z = 0
				var_210_17.x = 0
				var_210_9.localEulerAngles = var_210_17
			end

			local var_210_18 = arg_207_1.actors_["1085ui_story"]
			local var_210_19 = 0

			if var_210_19 < arg_207_1.time_ and arg_207_1.time_ <= var_210_19 + arg_210_0 and not isNil(var_210_18) and arg_207_1.var_.characterEffect1085ui_story == nil then
				arg_207_1.var_.characterEffect1085ui_story = var_210_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_20 = 0.200000002980232

			if var_210_19 <= arg_207_1.time_ and arg_207_1.time_ < var_210_19 + var_210_20 and not isNil(var_210_18) then
				local var_210_21 = (arg_207_1.time_ - var_210_19) / var_210_20

				if arg_207_1.var_.characterEffect1085ui_story and not isNil(var_210_18) then
					arg_207_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_207_1.time_ >= var_210_19 + var_210_20 and arg_207_1.time_ < var_210_19 + var_210_20 + arg_210_0 and not isNil(var_210_18) and arg_207_1.var_.characterEffect1085ui_story then
				arg_207_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_210_22 = arg_207_1.actors_["404001ui_story"]
			local var_210_23 = 0

			if var_210_23 < arg_207_1.time_ and arg_207_1.time_ <= var_210_23 + arg_210_0 and not isNil(var_210_22) and arg_207_1.var_.characterEffect404001ui_story == nil then
				arg_207_1.var_.characterEffect404001ui_story = var_210_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_24 = 0.200000002980232

			if var_210_23 <= arg_207_1.time_ and arg_207_1.time_ < var_210_23 + var_210_24 and not isNil(var_210_22) then
				local var_210_25 = (arg_207_1.time_ - var_210_23) / var_210_24

				if arg_207_1.var_.characterEffect404001ui_story and not isNil(var_210_22) then
					local var_210_26 = Mathf.Lerp(0, 0.5, var_210_25)

					arg_207_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_207_1.var_.characterEffect404001ui_story.fillRatio = var_210_26
				end
			end

			if arg_207_1.time_ >= var_210_23 + var_210_24 and arg_207_1.time_ < var_210_23 + var_210_24 + arg_210_0 and not isNil(var_210_22) and arg_207_1.var_.characterEffect404001ui_story then
				local var_210_27 = 0.5

				arg_207_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_207_1.var_.characterEffect404001ui_story.fillRatio = var_210_27
			end

			local var_210_28 = 0

			if var_210_28 < arg_207_1.time_ and arg_207_1.time_ <= var_210_28 + arg_210_0 then
				arg_207_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action2_1")
			end

			local var_210_29 = 0

			if var_210_29 < arg_207_1.time_ and arg_207_1.time_ <= var_210_29 + arg_210_0 then
				arg_207_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva", "EmotionTimelineAnimator")
			end

			local var_210_30 = 0
			local var_210_31 = 0.075

			if var_210_30 < arg_207_1.time_ and arg_207_1.time_ <= var_210_30 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_32 = arg_207_1:FormatText(StoryNameCfg[328].name)

				arg_207_1.leftNameTxt_.text = var_210_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_33 = arg_207_1:GetWordFromCfg(420012050)
				local var_210_34 = arg_207_1:FormatText(var_210_33.content)

				arg_207_1.text_.text = var_210_34

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_35 = 3
				local var_210_36 = utf8.len(var_210_34)
				local var_210_37 = var_210_35 <= 0 and var_210_31 or var_210_31 * (var_210_36 / var_210_35)

				if var_210_37 > 0 and var_210_31 < var_210_37 then
					arg_207_1.talkMaxDuration = var_210_37

					if var_210_37 + var_210_30 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_37 + var_210_30
					end
				end

				arg_207_1.text_.text = var_210_34
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012050", "story_v_out_420012.awb") ~= 0 then
					local var_210_38 = manager.audio:GetVoiceLength("story_v_out_420012", "420012050", "story_v_out_420012.awb") / 1000

					if var_210_38 + var_210_30 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_38 + var_210_30
					end

					if var_210_33.prefab_name ~= "" and arg_207_1.actors_[var_210_33.prefab_name] ~= nil then
						local var_210_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_33.prefab_name].transform, "story_v_out_420012", "420012050", "story_v_out_420012.awb")

						arg_207_1:RecordAudio("420012050", var_210_39)
						arg_207_1:RecordAudio("420012050", var_210_39)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_420012", "420012050", "story_v_out_420012.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_420012", "420012050", "story_v_out_420012.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_40 = math.max(var_210_31, arg_207_1.talkMaxDuration)

			if var_210_30 <= arg_207_1.time_ and arg_207_1.time_ < var_210_30 + var_210_40 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_30) / var_210_40

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_30 + var_210_40 and arg_207_1.time_ < var_210_30 + var_210_40 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_207_1:InitPlayNodeList()
	end,
	Play420012051 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 420012051
		arg_211_1.duration_ = 2.47

		local var_211_0 = {
			zh = 1.733,
			ja = 2.466
		}
		local var_211_1 = manager.audio:GetLocalizationFlag()

		if var_211_0[var_211_1] ~= nil then
			arg_211_1.duration_ = var_211_0[var_211_1]
		end

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play420012052(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = arg_211_1.actors_["1085ui_story"]
			local var_214_1 = 0

			if var_214_1 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 and not isNil(var_214_0) and arg_211_1.var_.characterEffect1085ui_story == nil then
				arg_211_1.var_.characterEffect1085ui_story = var_214_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_2 = 0.200000002980232

			if var_214_1 <= arg_211_1.time_ and arg_211_1.time_ < var_214_1 + var_214_2 and not isNil(var_214_0) then
				local var_214_3 = (arg_211_1.time_ - var_214_1) / var_214_2

				if arg_211_1.var_.characterEffect1085ui_story and not isNil(var_214_0) then
					local var_214_4 = Mathf.Lerp(0, 0.5, var_214_3)

					arg_211_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_211_1.var_.characterEffect1085ui_story.fillRatio = var_214_4
				end
			end

			if arg_211_1.time_ >= var_214_1 + var_214_2 and arg_211_1.time_ < var_214_1 + var_214_2 + arg_214_0 and not isNil(var_214_0) and arg_211_1.var_.characterEffect1085ui_story then
				local var_214_5 = 0.5

				arg_211_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_211_1.var_.characterEffect1085ui_story.fillRatio = var_214_5
			end

			local var_214_6 = arg_211_1.actors_["404001ui_story"]
			local var_214_7 = 0

			if var_214_7 < arg_211_1.time_ and arg_211_1.time_ <= var_214_7 + arg_214_0 and not isNil(var_214_6) and arg_211_1.var_.characterEffect404001ui_story == nil then
				arg_211_1.var_.characterEffect404001ui_story = var_214_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_8 = 0.200000002980232

			if var_214_7 <= arg_211_1.time_ and arg_211_1.time_ < var_214_7 + var_214_8 and not isNil(var_214_6) then
				local var_214_9 = (arg_211_1.time_ - var_214_7) / var_214_8

				if arg_211_1.var_.characterEffect404001ui_story and not isNil(var_214_6) then
					arg_211_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_211_1.time_ >= var_214_7 + var_214_8 and arg_211_1.time_ < var_214_7 + var_214_8 + arg_214_0 and not isNil(var_214_6) and arg_211_1.var_.characterEffect404001ui_story then
				arg_211_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_214_10 = 0
			local var_214_11 = 0.15

			if var_214_10 < arg_211_1.time_ and arg_211_1.time_ <= var_214_10 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				local var_214_12 = arg_211_1:FormatText(StoryNameCfg[668].name)

				arg_211_1.leftNameTxt_.text = var_214_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_13 = arg_211_1:GetWordFromCfg(420012051)
				local var_214_14 = arg_211_1:FormatText(var_214_13.content)

				arg_211_1.text_.text = var_214_14

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_15 = 6
				local var_214_16 = utf8.len(var_214_14)
				local var_214_17 = var_214_15 <= 0 and var_214_11 or var_214_11 * (var_214_16 / var_214_15)

				if var_214_17 > 0 and var_214_11 < var_214_17 then
					arg_211_1.talkMaxDuration = var_214_17

					if var_214_17 + var_214_10 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_17 + var_214_10
					end
				end

				arg_211_1.text_.text = var_214_14
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012051", "story_v_out_420012.awb") ~= 0 then
					local var_214_18 = manager.audio:GetVoiceLength("story_v_out_420012", "420012051", "story_v_out_420012.awb") / 1000

					if var_214_18 + var_214_10 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_18 + var_214_10
					end

					if var_214_13.prefab_name ~= "" and arg_211_1.actors_[var_214_13.prefab_name] ~= nil then
						local var_214_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_13.prefab_name].transform, "story_v_out_420012", "420012051", "story_v_out_420012.awb")

						arg_211_1:RecordAudio("420012051", var_214_19)
						arg_211_1:RecordAudio("420012051", var_214_19)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_420012", "420012051", "story_v_out_420012.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_420012", "420012051", "story_v_out_420012.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_20 = math.max(var_214_11, arg_211_1.talkMaxDuration)

			if var_214_10 <= arg_211_1.time_ and arg_211_1.time_ < var_214_10 + var_214_20 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_10) / var_214_20

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_10 + var_214_20 and arg_211_1.time_ < var_214_10 + var_214_20 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play420012052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 420012052
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play420012053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = arg_215_1.actors_["404001ui_story"]
			local var_218_1 = 0

			if var_218_1 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 and not isNil(var_218_0) and arg_215_1.var_.characterEffect404001ui_story == nil then
				arg_215_1.var_.characterEffect404001ui_story = var_218_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_2 = 0.200000002980232

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_2 and not isNil(var_218_0) then
				local var_218_3 = (arg_215_1.time_ - var_218_1) / var_218_2

				if arg_215_1.var_.characterEffect404001ui_story and not isNil(var_218_0) then
					local var_218_4 = Mathf.Lerp(0, 0.5, var_218_3)

					arg_215_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_215_1.var_.characterEffect404001ui_story.fillRatio = var_218_4
				end
			end

			if arg_215_1.time_ >= var_218_1 + var_218_2 and arg_215_1.time_ < var_218_1 + var_218_2 + arg_218_0 and not isNil(var_218_0) and arg_215_1.var_.characterEffect404001ui_story then
				local var_218_5 = 0.5

				arg_215_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_215_1.var_.characterEffect404001ui_story.fillRatio = var_218_5
			end

			local var_218_6 = 0
			local var_218_7 = 1.2

			if var_218_6 < arg_215_1.time_ and arg_215_1.time_ <= var_218_6 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, false)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_8 = arg_215_1:GetWordFromCfg(420012052)
				local var_218_9 = arg_215_1:FormatText(var_218_8.content)

				arg_215_1.text_.text = var_218_9

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_10 = 48
				local var_218_11 = utf8.len(var_218_9)
				local var_218_12 = var_218_10 <= 0 and var_218_7 or var_218_7 * (var_218_11 / var_218_10)

				if var_218_12 > 0 and var_218_7 < var_218_12 then
					arg_215_1.talkMaxDuration = var_218_12

					if var_218_12 + var_218_6 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_12 + var_218_6
					end
				end

				arg_215_1.text_.text = var_218_9
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_13 = math.max(var_218_7, arg_215_1.talkMaxDuration)

			if var_218_6 <= arg_215_1.time_ and arg_215_1.time_ < var_218_6 + var_218_13 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_6) / var_218_13

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_6 + var_218_13 and arg_215_1.time_ < var_218_6 + var_218_13 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play420012053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 420012053
		arg_219_1.duration_ = 3.8

		local var_219_0 = {
			zh = 3.333,
			ja = 3.8
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
				arg_219_0:Play420012054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = arg_219_1.actors_["1085ui_story"]
			local var_222_1 = 0

			if var_222_1 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 and not isNil(var_222_0) and arg_219_1.var_.characterEffect1085ui_story == nil then
				arg_219_1.var_.characterEffect1085ui_story = var_222_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_2 = 0.200000002980232

			if var_222_1 <= arg_219_1.time_ and arg_219_1.time_ < var_222_1 + var_222_2 and not isNil(var_222_0) then
				local var_222_3 = (arg_219_1.time_ - var_222_1) / var_222_2

				if arg_219_1.var_.characterEffect1085ui_story and not isNil(var_222_0) then
					arg_219_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_219_1.time_ >= var_222_1 + var_222_2 and arg_219_1.time_ < var_222_1 + var_222_2 + arg_222_0 and not isNil(var_222_0) and arg_219_1.var_.characterEffect1085ui_story then
				arg_219_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_222_4 = 0

			if var_222_4 < arg_219_1.time_ and arg_219_1.time_ <= var_222_4 + arg_222_0 then
				arg_219_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action2_2")
			end

			local var_222_5 = 0

			if var_222_5 < arg_219_1.time_ and arg_219_1.time_ <= var_222_5 + arg_222_0 then
				arg_219_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_222_6 = 0
			local var_222_7 = 0.275

			if var_222_6 < arg_219_1.time_ and arg_219_1.time_ <= var_222_6 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				local var_222_8 = arg_219_1:FormatText(StoryNameCfg[328].name)

				arg_219_1.leftNameTxt_.text = var_222_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_9 = arg_219_1:GetWordFromCfg(420012053)
				local var_222_10 = arg_219_1:FormatText(var_222_9.content)

				arg_219_1.text_.text = var_222_10

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_11 = 11
				local var_222_12 = utf8.len(var_222_10)
				local var_222_13 = var_222_11 <= 0 and var_222_7 or var_222_7 * (var_222_12 / var_222_11)

				if var_222_13 > 0 and var_222_7 < var_222_13 then
					arg_219_1.talkMaxDuration = var_222_13

					if var_222_13 + var_222_6 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_13 + var_222_6
					end
				end

				arg_219_1.text_.text = var_222_10
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012053", "story_v_out_420012.awb") ~= 0 then
					local var_222_14 = manager.audio:GetVoiceLength("story_v_out_420012", "420012053", "story_v_out_420012.awb") / 1000

					if var_222_14 + var_222_6 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_14 + var_222_6
					end

					if var_222_9.prefab_name ~= "" and arg_219_1.actors_[var_222_9.prefab_name] ~= nil then
						local var_222_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_9.prefab_name].transform, "story_v_out_420012", "420012053", "story_v_out_420012.awb")

						arg_219_1:RecordAudio("420012053", var_222_15)
						arg_219_1:RecordAudio("420012053", var_222_15)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_420012", "420012053", "story_v_out_420012.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_420012", "420012053", "story_v_out_420012.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_16 = math.max(var_222_7, arg_219_1.talkMaxDuration)

			if var_222_6 <= arg_219_1.time_ and arg_219_1.time_ < var_222_6 + var_222_16 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_6) / var_222_16

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_6 + var_222_16 and arg_219_1.time_ < var_222_6 + var_222_16 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play420012054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 420012054
		arg_223_1.duration_ = 9.6

		local var_223_0 = {
			zh = 6.533,
			ja = 9.6
		}
		local var_223_1 = manager.audio:GetLocalizationFlag()

		if var_223_0[var_223_1] ~= nil then
			arg_223_1.duration_ = var_223_0[var_223_1]
		end

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play420012055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = arg_223_1.actors_["1085ui_story"]
			local var_226_1 = 0

			if var_226_1 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 and not isNil(var_226_0) and arg_223_1.var_.characterEffect1085ui_story == nil then
				arg_223_1.var_.characterEffect1085ui_story = var_226_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_2 = 0.200000002980232

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_2 and not isNil(var_226_0) then
				local var_226_3 = (arg_223_1.time_ - var_226_1) / var_226_2

				if arg_223_1.var_.characterEffect1085ui_story and not isNil(var_226_0) then
					local var_226_4 = Mathf.Lerp(0, 0.5, var_226_3)

					arg_223_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_223_1.var_.characterEffect1085ui_story.fillRatio = var_226_4
				end
			end

			if arg_223_1.time_ >= var_226_1 + var_226_2 and arg_223_1.time_ < var_226_1 + var_226_2 + arg_226_0 and not isNil(var_226_0) and arg_223_1.var_.characterEffect1085ui_story then
				local var_226_5 = 0.5

				arg_223_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_223_1.var_.characterEffect1085ui_story.fillRatio = var_226_5
			end

			local var_226_6 = arg_223_1.actors_["404001ui_story"]
			local var_226_7 = 0

			if var_226_7 < arg_223_1.time_ and arg_223_1.time_ <= var_226_7 + arg_226_0 and not isNil(var_226_6) and arg_223_1.var_.characterEffect404001ui_story == nil then
				arg_223_1.var_.characterEffect404001ui_story = var_226_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_8 = 0.200000002980232

			if var_226_7 <= arg_223_1.time_ and arg_223_1.time_ < var_226_7 + var_226_8 and not isNil(var_226_6) then
				local var_226_9 = (arg_223_1.time_ - var_226_7) / var_226_8

				if arg_223_1.var_.characterEffect404001ui_story and not isNil(var_226_6) then
					arg_223_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_223_1.time_ >= var_226_7 + var_226_8 and arg_223_1.time_ < var_226_7 + var_226_8 + arg_226_0 and not isNil(var_226_6) and arg_223_1.var_.characterEffect404001ui_story then
				arg_223_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_226_10 = 0

			if var_226_10 < arg_223_1.time_ and arg_223_1.time_ <= var_226_10 + arg_226_0 then
				arg_223_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_226_11 = 0
			local var_226_12 = 0.675

			if var_226_11 < arg_223_1.time_ and arg_223_1.time_ <= var_226_11 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_13 = arg_223_1:FormatText(StoryNameCfg[668].name)

				arg_223_1.leftNameTxt_.text = var_226_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_14 = arg_223_1:GetWordFromCfg(420012054)
				local var_226_15 = arg_223_1:FormatText(var_226_14.content)

				arg_223_1.text_.text = var_226_15

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_16 = 27
				local var_226_17 = utf8.len(var_226_15)
				local var_226_18 = var_226_16 <= 0 and var_226_12 or var_226_12 * (var_226_17 / var_226_16)

				if var_226_18 > 0 and var_226_12 < var_226_18 then
					arg_223_1.talkMaxDuration = var_226_18

					if var_226_18 + var_226_11 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_18 + var_226_11
					end
				end

				arg_223_1.text_.text = var_226_15
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012054", "story_v_out_420012.awb") ~= 0 then
					local var_226_19 = manager.audio:GetVoiceLength("story_v_out_420012", "420012054", "story_v_out_420012.awb") / 1000

					if var_226_19 + var_226_11 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_19 + var_226_11
					end

					if var_226_14.prefab_name ~= "" and arg_223_1.actors_[var_226_14.prefab_name] ~= nil then
						local var_226_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_14.prefab_name].transform, "story_v_out_420012", "420012054", "story_v_out_420012.awb")

						arg_223_1:RecordAudio("420012054", var_226_20)
						arg_223_1:RecordAudio("420012054", var_226_20)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_420012", "420012054", "story_v_out_420012.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_420012", "420012054", "story_v_out_420012.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_21 = math.max(var_226_12, arg_223_1.talkMaxDuration)

			if var_226_11 <= arg_223_1.time_ and arg_223_1.time_ < var_226_11 + var_226_21 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_11) / var_226_21

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_11 + var_226_21 and arg_223_1.time_ < var_226_11 + var_226_21 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play420012055 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 420012055
		arg_227_1.duration_ = 4.87

		local var_227_0 = {
			zh = 4.566,
			ja = 4.866
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
				arg_227_0:Play420012056(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 0
			local var_230_1 = 0.675

			if var_230_0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_2 = arg_227_1:FormatText(StoryNameCfg[668].name)

				arg_227_1.leftNameTxt_.text = var_230_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_3 = arg_227_1:GetWordFromCfg(420012055)
				local var_230_4 = arg_227_1:FormatText(var_230_3.content)

				arg_227_1.text_.text = var_230_4

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_5 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012055", "story_v_out_420012.awb") ~= 0 then
					local var_230_8 = manager.audio:GetVoiceLength("story_v_out_420012", "420012055", "story_v_out_420012.awb") / 1000

					if var_230_8 + var_230_0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_8 + var_230_0
					end

					if var_230_3.prefab_name ~= "" and arg_227_1.actors_[var_230_3.prefab_name] ~= nil then
						local var_230_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_3.prefab_name].transform, "story_v_out_420012", "420012055", "story_v_out_420012.awb")

						arg_227_1:RecordAudio("420012055", var_230_9)
						arg_227_1:RecordAudio("420012055", var_230_9)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_420012", "420012055", "story_v_out_420012.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_420012", "420012055", "story_v_out_420012.awb")
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
	Play420012056 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 420012056
		arg_231_1.duration_ = 4.27

		local var_231_0 = {
			zh = 4.266,
			ja = 3.966
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
				arg_231_0:Play420012057(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = arg_231_1.actors_["1085ui_story"]
			local var_234_1 = 0

			if var_234_1 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.characterEffect1085ui_story == nil then
				arg_231_1.var_.characterEffect1085ui_story = var_234_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_2 = 0.200000002980232

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_2 and not isNil(var_234_0) then
				local var_234_3 = (arg_231_1.time_ - var_234_1) / var_234_2

				if arg_231_1.var_.characterEffect1085ui_story and not isNil(var_234_0) then
					arg_231_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_231_1.time_ >= var_234_1 + var_234_2 and arg_231_1.time_ < var_234_1 + var_234_2 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.characterEffect1085ui_story then
				arg_231_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_234_4 = arg_231_1.actors_["404001ui_story"]
			local var_234_5 = 0

			if var_234_5 < arg_231_1.time_ and arg_231_1.time_ <= var_234_5 + arg_234_0 and not isNil(var_234_4) and arg_231_1.var_.characterEffect404001ui_story == nil then
				arg_231_1.var_.characterEffect404001ui_story = var_234_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_6 = 0.200000002980232

			if var_234_5 <= arg_231_1.time_ and arg_231_1.time_ < var_234_5 + var_234_6 and not isNil(var_234_4) then
				local var_234_7 = (arg_231_1.time_ - var_234_5) / var_234_6

				if arg_231_1.var_.characterEffect404001ui_story and not isNil(var_234_4) then
					local var_234_8 = Mathf.Lerp(0, 0.5, var_234_7)

					arg_231_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_231_1.var_.characterEffect404001ui_story.fillRatio = var_234_8
				end
			end

			if arg_231_1.time_ >= var_234_5 + var_234_6 and arg_231_1.time_ < var_234_5 + var_234_6 + arg_234_0 and not isNil(var_234_4) and arg_231_1.var_.characterEffect404001ui_story then
				local var_234_9 = 0.5

				arg_231_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_231_1.var_.characterEffect404001ui_story.fillRatio = var_234_9
			end

			local var_234_10 = 0

			if var_234_10 < arg_231_1.time_ and arg_231_1.time_ <= var_234_10 + arg_234_0 then
				arg_231_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action8_1")
			end

			local var_234_11 = 0

			if var_234_11 < arg_231_1.time_ and arg_231_1.time_ <= var_234_11 + arg_234_0 then
				arg_231_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_234_12 = 0
			local var_234_13 = 0.225

			if var_234_12 < arg_231_1.time_ and arg_231_1.time_ <= var_234_12 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_14 = arg_231_1:FormatText(StoryNameCfg[328].name)

				arg_231_1.leftNameTxt_.text = var_234_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_15 = arg_231_1:GetWordFromCfg(420012056)
				local var_234_16 = arg_231_1:FormatText(var_234_15.content)

				arg_231_1.text_.text = var_234_16

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_17 = 9
				local var_234_18 = utf8.len(var_234_16)
				local var_234_19 = var_234_17 <= 0 and var_234_13 or var_234_13 * (var_234_18 / var_234_17)

				if var_234_19 > 0 and var_234_13 < var_234_19 then
					arg_231_1.talkMaxDuration = var_234_19

					if var_234_19 + var_234_12 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_19 + var_234_12
					end
				end

				arg_231_1.text_.text = var_234_16
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012056", "story_v_out_420012.awb") ~= 0 then
					local var_234_20 = manager.audio:GetVoiceLength("story_v_out_420012", "420012056", "story_v_out_420012.awb") / 1000

					if var_234_20 + var_234_12 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_20 + var_234_12
					end

					if var_234_15.prefab_name ~= "" and arg_231_1.actors_[var_234_15.prefab_name] ~= nil then
						local var_234_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_15.prefab_name].transform, "story_v_out_420012", "420012056", "story_v_out_420012.awb")

						arg_231_1:RecordAudio("420012056", var_234_21)
						arg_231_1:RecordAudio("420012056", var_234_21)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_420012", "420012056", "story_v_out_420012.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_420012", "420012056", "story_v_out_420012.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_22 = math.max(var_234_13, arg_231_1.talkMaxDuration)

			if var_234_12 <= arg_231_1.time_ and arg_231_1.time_ < var_234_12 + var_234_22 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_12) / var_234_22

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_12 + var_234_22 and arg_231_1.time_ < var_234_12 + var_234_22 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play420012057 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 420012057
		arg_235_1.duration_ = 4.93

		local var_235_0 = {
			zh = 3.866,
			ja = 4.933
		}
		local var_235_1 = manager.audio:GetLocalizationFlag()

		if var_235_0[var_235_1] ~= nil then
			arg_235_1.duration_ = var_235_0[var_235_1]
		end

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play420012058(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = arg_235_1.actors_["1085ui_story"]
			local var_238_1 = 0

			if var_238_1 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.characterEffect1085ui_story == nil then
				arg_235_1.var_.characterEffect1085ui_story = var_238_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_2 = 0.200000002980232

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_2 and not isNil(var_238_0) then
				local var_238_3 = (arg_235_1.time_ - var_238_1) / var_238_2

				if arg_235_1.var_.characterEffect1085ui_story and not isNil(var_238_0) then
					local var_238_4 = Mathf.Lerp(0, 0.5, var_238_3)

					arg_235_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_235_1.var_.characterEffect1085ui_story.fillRatio = var_238_4
				end
			end

			if arg_235_1.time_ >= var_238_1 + var_238_2 and arg_235_1.time_ < var_238_1 + var_238_2 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.characterEffect1085ui_story then
				local var_238_5 = 0.5

				arg_235_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_235_1.var_.characterEffect1085ui_story.fillRatio = var_238_5
			end

			local var_238_6 = arg_235_1.actors_["404001ui_story"]
			local var_238_7 = 0

			if var_238_7 < arg_235_1.time_ and arg_235_1.time_ <= var_238_7 + arg_238_0 and not isNil(var_238_6) and arg_235_1.var_.characterEffect404001ui_story == nil then
				arg_235_1.var_.characterEffect404001ui_story = var_238_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_8 = 0.200000002980232

			if var_238_7 <= arg_235_1.time_ and arg_235_1.time_ < var_238_7 + var_238_8 and not isNil(var_238_6) then
				local var_238_9 = (arg_235_1.time_ - var_238_7) / var_238_8

				if arg_235_1.var_.characterEffect404001ui_story and not isNil(var_238_6) then
					arg_235_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_235_1.time_ >= var_238_7 + var_238_8 and arg_235_1.time_ < var_238_7 + var_238_8 + arg_238_0 and not isNil(var_238_6) and arg_235_1.var_.characterEffect404001ui_story then
				arg_235_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_238_10 = 0
			local var_238_11 = 0.375

			if var_238_10 < arg_235_1.time_ and arg_235_1.time_ <= var_238_10 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_12 = arg_235_1:FormatText(StoryNameCfg[668].name)

				arg_235_1.leftNameTxt_.text = var_238_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_13 = arg_235_1:GetWordFromCfg(420012057)
				local var_238_14 = arg_235_1:FormatText(var_238_13.content)

				arg_235_1.text_.text = var_238_14

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_15 = 15
				local var_238_16 = utf8.len(var_238_14)
				local var_238_17 = var_238_15 <= 0 and var_238_11 or var_238_11 * (var_238_16 / var_238_15)

				if var_238_17 > 0 and var_238_11 < var_238_17 then
					arg_235_1.talkMaxDuration = var_238_17

					if var_238_17 + var_238_10 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_17 + var_238_10
					end
				end

				arg_235_1.text_.text = var_238_14
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012057", "story_v_out_420012.awb") ~= 0 then
					local var_238_18 = manager.audio:GetVoiceLength("story_v_out_420012", "420012057", "story_v_out_420012.awb") / 1000

					if var_238_18 + var_238_10 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_18 + var_238_10
					end

					if var_238_13.prefab_name ~= "" and arg_235_1.actors_[var_238_13.prefab_name] ~= nil then
						local var_238_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_13.prefab_name].transform, "story_v_out_420012", "420012057", "story_v_out_420012.awb")

						arg_235_1:RecordAudio("420012057", var_238_19)
						arg_235_1:RecordAudio("420012057", var_238_19)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_420012", "420012057", "story_v_out_420012.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_420012", "420012057", "story_v_out_420012.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_20 = math.max(var_238_11, arg_235_1.talkMaxDuration)

			if var_238_10 <= arg_235_1.time_ and arg_235_1.time_ < var_238_10 + var_238_20 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_10) / var_238_20

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_10 + var_238_20 and arg_235_1.time_ < var_238_10 + var_238_20 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play420012058 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 420012058
		arg_239_1.duration_ = 5

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play420012059(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = arg_239_1.actors_["404001ui_story"]
			local var_242_1 = 0

			if var_242_1 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 and not isNil(var_242_0) and arg_239_1.var_.characterEffect404001ui_story == nil then
				arg_239_1.var_.characterEffect404001ui_story = var_242_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_2 = 0.200000002980232

			if var_242_1 <= arg_239_1.time_ and arg_239_1.time_ < var_242_1 + var_242_2 and not isNil(var_242_0) then
				local var_242_3 = (arg_239_1.time_ - var_242_1) / var_242_2

				if arg_239_1.var_.characterEffect404001ui_story and not isNil(var_242_0) then
					local var_242_4 = Mathf.Lerp(0, 0.5, var_242_3)

					arg_239_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_239_1.var_.characterEffect404001ui_story.fillRatio = var_242_4
				end
			end

			if arg_239_1.time_ >= var_242_1 + var_242_2 and arg_239_1.time_ < var_242_1 + var_242_2 + arg_242_0 and not isNil(var_242_0) and arg_239_1.var_.characterEffect404001ui_story then
				local var_242_5 = 0.5

				arg_239_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_239_1.var_.characterEffect404001ui_story.fillRatio = var_242_5
			end

			local var_242_6 = 0

			if var_242_6 < arg_239_1.time_ and arg_239_1.time_ <= var_242_6 + arg_242_0 then
				arg_239_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action8_2")
			end

			local var_242_7 = 0

			if var_242_7 < arg_239_1.time_ and arg_239_1.time_ <= var_242_7 + arg_242_0 then
				arg_239_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_242_8 = 0
			local var_242_9 = 1.1

			if var_242_8 < arg_239_1.time_ and arg_239_1.time_ <= var_242_8 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, false)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_10 = arg_239_1:GetWordFromCfg(420012058)
				local var_242_11 = arg_239_1:FormatText(var_242_10.content)

				arg_239_1.text_.text = var_242_11

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_12 = 44
				local var_242_13 = utf8.len(var_242_11)
				local var_242_14 = var_242_12 <= 0 and var_242_9 or var_242_9 * (var_242_13 / var_242_12)

				if var_242_14 > 0 and var_242_9 < var_242_14 then
					arg_239_1.talkMaxDuration = var_242_14

					if var_242_14 + var_242_8 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_14 + var_242_8
					end
				end

				arg_239_1.text_.text = var_242_11
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_15 = math.max(var_242_9, arg_239_1.talkMaxDuration)

			if var_242_8 <= arg_239_1.time_ and arg_239_1.time_ < var_242_8 + var_242_15 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_8) / var_242_15

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_8 + var_242_15 and arg_239_1.time_ < var_242_8 + var_242_15 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play420012059 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 420012059
		arg_243_1.duration_ = 5.97

		local var_243_0 = {
			zh = 4.833,
			ja = 5.966
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
				arg_243_0:Play420012060(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = arg_243_1.actors_["404001ui_story"]
			local var_246_1 = 0

			if var_246_1 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 and not isNil(var_246_0) and arg_243_1.var_.characterEffect404001ui_story == nil then
				arg_243_1.var_.characterEffect404001ui_story = var_246_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_2 = 0.200000002980232

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_2 and not isNil(var_246_0) then
				local var_246_3 = (arg_243_1.time_ - var_246_1) / var_246_2

				if arg_243_1.var_.characterEffect404001ui_story and not isNil(var_246_0) then
					arg_243_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_243_1.time_ >= var_246_1 + var_246_2 and arg_243_1.time_ < var_246_1 + var_246_2 + arg_246_0 and not isNil(var_246_0) and arg_243_1.var_.characterEffect404001ui_story then
				arg_243_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_246_4 = 0

			if var_246_4 < arg_243_1.time_ and arg_243_1.time_ <= var_246_4 + arg_246_0 then
				arg_243_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_1")
			end

			local var_246_5 = 0
			local var_246_6 = 0.575

			if var_246_5 < arg_243_1.time_ and arg_243_1.time_ <= var_246_5 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_7 = arg_243_1:FormatText(StoryNameCfg[668].name)

				arg_243_1.leftNameTxt_.text = var_246_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_8 = arg_243_1:GetWordFromCfg(420012059)
				local var_246_9 = arg_243_1:FormatText(var_246_8.content)

				arg_243_1.text_.text = var_246_9

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_10 = 23
				local var_246_11 = utf8.len(var_246_9)
				local var_246_12 = var_246_10 <= 0 and var_246_6 or var_246_6 * (var_246_11 / var_246_10)

				if var_246_12 > 0 and var_246_6 < var_246_12 then
					arg_243_1.talkMaxDuration = var_246_12

					if var_246_12 + var_246_5 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_12 + var_246_5
					end
				end

				arg_243_1.text_.text = var_246_9
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012059", "story_v_out_420012.awb") ~= 0 then
					local var_246_13 = manager.audio:GetVoiceLength("story_v_out_420012", "420012059", "story_v_out_420012.awb") / 1000

					if var_246_13 + var_246_5 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_13 + var_246_5
					end

					if var_246_8.prefab_name ~= "" and arg_243_1.actors_[var_246_8.prefab_name] ~= nil then
						local var_246_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_8.prefab_name].transform, "story_v_out_420012", "420012059", "story_v_out_420012.awb")

						arg_243_1:RecordAudio("420012059", var_246_14)
						arg_243_1:RecordAudio("420012059", var_246_14)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_420012", "420012059", "story_v_out_420012.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_420012", "420012059", "story_v_out_420012.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_15 = math.max(var_246_6, arg_243_1.talkMaxDuration)

			if var_246_5 <= arg_243_1.time_ and arg_243_1.time_ < var_246_5 + var_246_15 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_5) / var_246_15

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_5 + var_246_15 and arg_243_1.time_ < var_246_5 + var_246_15 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play420012060 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 420012060
		arg_247_1.duration_ = 1.7

		local var_247_0 = {
			zh = 1.5,
			ja = 1.7
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
				arg_247_0:Play420012061(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = arg_247_1.actors_["1085ui_story"]
			local var_250_1 = 0

			if var_250_1 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 and not isNil(var_250_0) and arg_247_1.var_.characterEffect1085ui_story == nil then
				arg_247_1.var_.characterEffect1085ui_story = var_250_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_2 = 0.200000002980232

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_2 and not isNil(var_250_0) then
				local var_250_3 = (arg_247_1.time_ - var_250_1) / var_250_2

				if arg_247_1.var_.characterEffect1085ui_story and not isNil(var_250_0) then
					arg_247_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_247_1.time_ >= var_250_1 + var_250_2 and arg_247_1.time_ < var_250_1 + var_250_2 + arg_250_0 and not isNil(var_250_0) and arg_247_1.var_.characterEffect1085ui_story then
				arg_247_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_250_4 = arg_247_1.actors_["404001ui_story"]
			local var_250_5 = 0

			if var_250_5 < arg_247_1.time_ and arg_247_1.time_ <= var_250_5 + arg_250_0 and not isNil(var_250_4) and arg_247_1.var_.characterEffect404001ui_story == nil then
				arg_247_1.var_.characterEffect404001ui_story = var_250_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_6 = 0.200000002980232

			if var_250_5 <= arg_247_1.time_ and arg_247_1.time_ < var_250_5 + var_250_6 and not isNil(var_250_4) then
				local var_250_7 = (arg_247_1.time_ - var_250_5) / var_250_6

				if arg_247_1.var_.characterEffect404001ui_story and not isNil(var_250_4) then
					local var_250_8 = Mathf.Lerp(0, 0.5, var_250_7)

					arg_247_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_247_1.var_.characterEffect404001ui_story.fillRatio = var_250_8
				end
			end

			if arg_247_1.time_ >= var_250_5 + var_250_6 and arg_247_1.time_ < var_250_5 + var_250_6 + arg_250_0 and not isNil(var_250_4) and arg_247_1.var_.characterEffect404001ui_story then
				local var_250_9 = 0.5

				arg_247_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_247_1.var_.characterEffect404001ui_story.fillRatio = var_250_9
			end

			local var_250_10 = 0
			local var_250_11 = 0.35

			if var_250_10 < arg_247_1.time_ and arg_247_1.time_ <= var_250_10 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_12 = arg_247_1:FormatText(StoryNameCfg[328].name)

				arg_247_1.leftNameTxt_.text = var_250_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_13 = arg_247_1:GetWordFromCfg(420012060)
				local var_250_14 = arg_247_1:FormatText(var_250_13.content)

				arg_247_1.text_.text = var_250_14

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_15 = 14
				local var_250_16 = utf8.len(var_250_14)
				local var_250_17 = var_250_15 <= 0 and var_250_11 or var_250_11 * (var_250_16 / var_250_15)

				if var_250_17 > 0 and var_250_11 < var_250_17 then
					arg_247_1.talkMaxDuration = var_250_17

					if var_250_17 + var_250_10 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_17 + var_250_10
					end
				end

				arg_247_1.text_.text = var_250_14
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012060", "story_v_out_420012.awb") ~= 0 then
					local var_250_18 = manager.audio:GetVoiceLength("story_v_out_420012", "420012060", "story_v_out_420012.awb") / 1000

					if var_250_18 + var_250_10 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_18 + var_250_10
					end

					if var_250_13.prefab_name ~= "" and arg_247_1.actors_[var_250_13.prefab_name] ~= nil then
						local var_250_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_13.prefab_name].transform, "story_v_out_420012", "420012060", "story_v_out_420012.awb")

						arg_247_1:RecordAudio("420012060", var_250_19)
						arg_247_1:RecordAudio("420012060", var_250_19)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_420012", "420012060", "story_v_out_420012.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_420012", "420012060", "story_v_out_420012.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_20 = math.max(var_250_11, arg_247_1.talkMaxDuration)

			if var_250_10 <= arg_247_1.time_ and arg_247_1.time_ < var_250_10 + var_250_20 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_10) / var_250_20

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_10 + var_250_20 and arg_247_1.time_ < var_250_10 + var_250_20 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play420012061 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 420012061
		arg_251_1.duration_ = 16.43

		local var_251_0 = {
			zh = 11.7,
			ja = 16.433
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
				arg_251_0:Play420012062(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = arg_251_1.actors_["1085ui_story"]
			local var_254_1 = 0

			if var_254_1 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 and not isNil(var_254_0) and arg_251_1.var_.characterEffect1085ui_story == nil then
				arg_251_1.var_.characterEffect1085ui_story = var_254_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_2 = 0.200000002980232

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_2 and not isNil(var_254_0) then
				local var_254_3 = (arg_251_1.time_ - var_254_1) / var_254_2

				if arg_251_1.var_.characterEffect1085ui_story and not isNil(var_254_0) then
					local var_254_4 = Mathf.Lerp(0, 0.5, var_254_3)

					arg_251_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_251_1.var_.characterEffect1085ui_story.fillRatio = var_254_4
				end
			end

			if arg_251_1.time_ >= var_254_1 + var_254_2 and arg_251_1.time_ < var_254_1 + var_254_2 + arg_254_0 and not isNil(var_254_0) and arg_251_1.var_.characterEffect1085ui_story then
				local var_254_5 = 0.5

				arg_251_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_251_1.var_.characterEffect1085ui_story.fillRatio = var_254_5
			end

			local var_254_6 = arg_251_1.actors_["404001ui_story"]
			local var_254_7 = 0

			if var_254_7 < arg_251_1.time_ and arg_251_1.time_ <= var_254_7 + arg_254_0 and not isNil(var_254_6) and arg_251_1.var_.characterEffect404001ui_story == nil then
				arg_251_1.var_.characterEffect404001ui_story = var_254_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_8 = 0.200000002980232

			if var_254_7 <= arg_251_1.time_ and arg_251_1.time_ < var_254_7 + var_254_8 and not isNil(var_254_6) then
				local var_254_9 = (arg_251_1.time_ - var_254_7) / var_254_8

				if arg_251_1.var_.characterEffect404001ui_story and not isNil(var_254_6) then
					arg_251_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_251_1.time_ >= var_254_7 + var_254_8 and arg_251_1.time_ < var_254_7 + var_254_8 + arg_254_0 and not isNil(var_254_6) and arg_251_1.var_.characterEffect404001ui_story then
				arg_251_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_254_10 = 0
			local var_254_11 = 1.525

			if var_254_10 < arg_251_1.time_ and arg_251_1.time_ <= var_254_10 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				local var_254_12 = arg_251_1:FormatText(StoryNameCfg[668].name)

				arg_251_1.leftNameTxt_.text = var_254_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_13 = arg_251_1:GetWordFromCfg(420012061)
				local var_254_14 = arg_251_1:FormatText(var_254_13.content)

				arg_251_1.text_.text = var_254_14

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_15 = 61
				local var_254_16 = utf8.len(var_254_14)
				local var_254_17 = var_254_15 <= 0 and var_254_11 or var_254_11 * (var_254_16 / var_254_15)

				if var_254_17 > 0 and var_254_11 < var_254_17 then
					arg_251_1.talkMaxDuration = var_254_17

					if var_254_17 + var_254_10 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_17 + var_254_10
					end
				end

				arg_251_1.text_.text = var_254_14
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012061", "story_v_out_420012.awb") ~= 0 then
					local var_254_18 = manager.audio:GetVoiceLength("story_v_out_420012", "420012061", "story_v_out_420012.awb") / 1000

					if var_254_18 + var_254_10 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_18 + var_254_10
					end

					if var_254_13.prefab_name ~= "" and arg_251_1.actors_[var_254_13.prefab_name] ~= nil then
						local var_254_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_13.prefab_name].transform, "story_v_out_420012", "420012061", "story_v_out_420012.awb")

						arg_251_1:RecordAudio("420012061", var_254_19)
						arg_251_1:RecordAudio("420012061", var_254_19)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_420012", "420012061", "story_v_out_420012.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_420012", "420012061", "story_v_out_420012.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_20 = math.max(var_254_11, arg_251_1.talkMaxDuration)

			if var_254_10 <= arg_251_1.time_ and arg_251_1.time_ < var_254_10 + var_254_20 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_10) / var_254_20

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_10 + var_254_20 and arg_251_1.time_ < var_254_10 + var_254_20 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play420012062 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 420012062
		arg_255_1.duration_ = 3.63

		local var_255_0 = {
			zh = 3.633,
			ja = 3.066
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
				arg_255_0:Play420012063(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = arg_255_1.actors_["1085ui_story"]
			local var_258_1 = 0

			if var_258_1 < arg_255_1.time_ and arg_255_1.time_ <= var_258_1 + arg_258_0 and not isNil(var_258_0) and arg_255_1.var_.characterEffect1085ui_story == nil then
				arg_255_1.var_.characterEffect1085ui_story = var_258_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_2 = 0.200000002980232

			if var_258_1 <= arg_255_1.time_ and arg_255_1.time_ < var_258_1 + var_258_2 and not isNil(var_258_0) then
				local var_258_3 = (arg_255_1.time_ - var_258_1) / var_258_2

				if arg_255_1.var_.characterEffect1085ui_story and not isNil(var_258_0) then
					arg_255_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_255_1.time_ >= var_258_1 + var_258_2 and arg_255_1.time_ < var_258_1 + var_258_2 + arg_258_0 and not isNil(var_258_0) and arg_255_1.var_.characterEffect1085ui_story then
				arg_255_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_258_4 = arg_255_1.actors_["404001ui_story"]
			local var_258_5 = 0

			if var_258_5 < arg_255_1.time_ and arg_255_1.time_ <= var_258_5 + arg_258_0 and not isNil(var_258_4) and arg_255_1.var_.characterEffect404001ui_story == nil then
				arg_255_1.var_.characterEffect404001ui_story = var_258_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_6 = 0.200000002980232

			if var_258_5 <= arg_255_1.time_ and arg_255_1.time_ < var_258_5 + var_258_6 and not isNil(var_258_4) then
				local var_258_7 = (arg_255_1.time_ - var_258_5) / var_258_6

				if arg_255_1.var_.characterEffect404001ui_story and not isNil(var_258_4) then
					local var_258_8 = Mathf.Lerp(0, 0.5, var_258_7)

					arg_255_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_255_1.var_.characterEffect404001ui_story.fillRatio = var_258_8
				end
			end

			if arg_255_1.time_ >= var_258_5 + var_258_6 and arg_255_1.time_ < var_258_5 + var_258_6 + arg_258_0 and not isNil(var_258_4) and arg_255_1.var_.characterEffect404001ui_story then
				local var_258_9 = 0.5

				arg_255_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_255_1.var_.characterEffect404001ui_story.fillRatio = var_258_9
			end

			local var_258_10 = 0

			if var_258_10 < arg_255_1.time_ and arg_255_1.time_ <= var_258_10 + arg_258_0 then
				arg_255_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action4_1")
			end

			local var_258_11 = 0

			if var_258_11 < arg_255_1.time_ and arg_255_1.time_ <= var_258_11 + arg_258_0 then
				arg_255_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_258_12 = 0
			local var_258_13 = 0.225

			if var_258_12 < arg_255_1.time_ and arg_255_1.time_ <= var_258_12 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				local var_258_14 = arg_255_1:FormatText(StoryNameCfg[328].name)

				arg_255_1.leftNameTxt_.text = var_258_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_15 = arg_255_1:GetWordFromCfg(420012062)
				local var_258_16 = arg_255_1:FormatText(var_258_15.content)

				arg_255_1.text_.text = var_258_16

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_17 = 9
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

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012062", "story_v_out_420012.awb") ~= 0 then
					local var_258_20 = manager.audio:GetVoiceLength("story_v_out_420012", "420012062", "story_v_out_420012.awb") / 1000

					if var_258_20 + var_258_12 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_20 + var_258_12
					end

					if var_258_15.prefab_name ~= "" and arg_255_1.actors_[var_258_15.prefab_name] ~= nil then
						local var_258_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_15.prefab_name].transform, "story_v_out_420012", "420012062", "story_v_out_420012.awb")

						arg_255_1:RecordAudio("420012062", var_258_21)
						arg_255_1:RecordAudio("420012062", var_258_21)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_420012", "420012062", "story_v_out_420012.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_420012", "420012062", "story_v_out_420012.awb")
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
	Play420012063 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 420012063
		arg_259_1.duration_ = 7.37

		local var_259_0 = {
			zh = 5.866,
			ja = 7.366
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
				arg_259_0:Play420012064(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = arg_259_1.actors_["1085ui_story"]
			local var_262_1 = 0

			if var_262_1 < arg_259_1.time_ and arg_259_1.time_ <= var_262_1 + arg_262_0 and not isNil(var_262_0) and arg_259_1.var_.characterEffect1085ui_story == nil then
				arg_259_1.var_.characterEffect1085ui_story = var_262_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_2 = 0.200000002980232

			if var_262_1 <= arg_259_1.time_ and arg_259_1.time_ < var_262_1 + var_262_2 and not isNil(var_262_0) then
				local var_262_3 = (arg_259_1.time_ - var_262_1) / var_262_2

				if arg_259_1.var_.characterEffect1085ui_story and not isNil(var_262_0) then
					local var_262_4 = Mathf.Lerp(0, 0.5, var_262_3)

					arg_259_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_259_1.var_.characterEffect1085ui_story.fillRatio = var_262_4
				end
			end

			if arg_259_1.time_ >= var_262_1 + var_262_2 and arg_259_1.time_ < var_262_1 + var_262_2 + arg_262_0 and not isNil(var_262_0) and arg_259_1.var_.characterEffect1085ui_story then
				local var_262_5 = 0.5

				arg_259_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_259_1.var_.characterEffect1085ui_story.fillRatio = var_262_5
			end

			local var_262_6 = arg_259_1.actors_["404001ui_story"]
			local var_262_7 = 0

			if var_262_7 < arg_259_1.time_ and arg_259_1.time_ <= var_262_7 + arg_262_0 and not isNil(var_262_6) and arg_259_1.var_.characterEffect404001ui_story == nil then
				arg_259_1.var_.characterEffect404001ui_story = var_262_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_8 = 0.200000002980232

			if var_262_7 <= arg_259_1.time_ and arg_259_1.time_ < var_262_7 + var_262_8 and not isNil(var_262_6) then
				local var_262_9 = (arg_259_1.time_ - var_262_7) / var_262_8

				if arg_259_1.var_.characterEffect404001ui_story and not isNil(var_262_6) then
					arg_259_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_259_1.time_ >= var_262_7 + var_262_8 and arg_259_1.time_ < var_262_7 + var_262_8 + arg_262_0 and not isNil(var_262_6) and arg_259_1.var_.characterEffect404001ui_story then
				arg_259_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_262_10 = 0

			if var_262_10 < arg_259_1.time_ and arg_259_1.time_ <= var_262_10 + arg_262_0 then
				arg_259_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_2")
			end

			local var_262_11 = 0

			if var_262_11 < arg_259_1.time_ and arg_259_1.time_ <= var_262_11 + arg_262_0 then
				arg_259_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_262_12 = 0
			local var_262_13 = 0.4

			if var_262_12 < arg_259_1.time_ and arg_259_1.time_ <= var_262_12 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				local var_262_14 = arg_259_1:FormatText(StoryNameCfg[668].name)

				arg_259_1.leftNameTxt_.text = var_262_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_15 = arg_259_1:GetWordFromCfg(420012063)
				local var_262_16 = arg_259_1:FormatText(var_262_15.content)

				arg_259_1.text_.text = var_262_16

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_17 = 16
				local var_262_18 = utf8.len(var_262_16)
				local var_262_19 = var_262_17 <= 0 and var_262_13 or var_262_13 * (var_262_18 / var_262_17)

				if var_262_19 > 0 and var_262_13 < var_262_19 then
					arg_259_1.talkMaxDuration = var_262_19

					if var_262_19 + var_262_12 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_19 + var_262_12
					end
				end

				arg_259_1.text_.text = var_262_16
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012063", "story_v_out_420012.awb") ~= 0 then
					local var_262_20 = manager.audio:GetVoiceLength("story_v_out_420012", "420012063", "story_v_out_420012.awb") / 1000

					if var_262_20 + var_262_12 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_20 + var_262_12
					end

					if var_262_15.prefab_name ~= "" and arg_259_1.actors_[var_262_15.prefab_name] ~= nil then
						local var_262_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_15.prefab_name].transform, "story_v_out_420012", "420012063", "story_v_out_420012.awb")

						arg_259_1:RecordAudio("420012063", var_262_21)
						arg_259_1:RecordAudio("420012063", var_262_21)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_420012", "420012063", "story_v_out_420012.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_420012", "420012063", "story_v_out_420012.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_22 = math.max(var_262_13, arg_259_1.talkMaxDuration)

			if var_262_12 <= arg_259_1.time_ and arg_259_1.time_ < var_262_12 + var_262_22 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_12) / var_262_22

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_12 + var_262_22 and arg_259_1.time_ < var_262_12 + var_262_22 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play420012064 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 420012064
		arg_263_1.duration_ = 5

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play420012065(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = arg_263_1.actors_["404001ui_story"].transform
			local var_266_1 = 0

			if var_266_1 < arg_263_1.time_ and arg_263_1.time_ <= var_266_1 + arg_266_0 then
				arg_263_1.var_.moveOldPos404001ui_story = var_266_0.localPosition
			end

			local var_266_2 = 0.001

			if var_266_1 <= arg_263_1.time_ and arg_263_1.time_ < var_266_1 + var_266_2 then
				local var_266_3 = (arg_263_1.time_ - var_266_1) / var_266_2
				local var_266_4 = Vector3.New(0, 100, 0)

				var_266_0.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos404001ui_story, var_266_4, var_266_3)

				local var_266_5 = manager.ui.mainCamera.transform.position - var_266_0.position

				var_266_0.forward = Vector3.New(var_266_5.x, var_266_5.y, var_266_5.z)

				local var_266_6 = var_266_0.localEulerAngles

				var_266_6.z = 0
				var_266_6.x = 0
				var_266_0.localEulerAngles = var_266_6
			end

			if arg_263_1.time_ >= var_266_1 + var_266_2 and arg_263_1.time_ < var_266_1 + var_266_2 + arg_266_0 then
				var_266_0.localPosition = Vector3.New(0, 100, 0)

				local var_266_7 = manager.ui.mainCamera.transform.position - var_266_0.position

				var_266_0.forward = Vector3.New(var_266_7.x, var_266_7.y, var_266_7.z)

				local var_266_8 = var_266_0.localEulerAngles

				var_266_8.z = 0
				var_266_8.x = 0
				var_266_0.localEulerAngles = var_266_8
			end

			local var_266_9 = arg_263_1.actors_["1085ui_story"].transform
			local var_266_10 = 0

			if var_266_10 < arg_263_1.time_ and arg_263_1.time_ <= var_266_10 + arg_266_0 then
				arg_263_1.var_.moveOldPos1085ui_story = var_266_9.localPosition
			end

			local var_266_11 = 0.001

			if var_266_10 <= arg_263_1.time_ and arg_263_1.time_ < var_266_10 + var_266_11 then
				local var_266_12 = (arg_263_1.time_ - var_266_10) / var_266_11
				local var_266_13 = Vector3.New(0, 100, 0)

				var_266_9.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos1085ui_story, var_266_13, var_266_12)

				local var_266_14 = manager.ui.mainCamera.transform.position - var_266_9.position

				var_266_9.forward = Vector3.New(var_266_14.x, var_266_14.y, var_266_14.z)

				local var_266_15 = var_266_9.localEulerAngles

				var_266_15.z = 0
				var_266_15.x = 0
				var_266_9.localEulerAngles = var_266_15
			end

			if arg_263_1.time_ >= var_266_10 + var_266_11 and arg_263_1.time_ < var_266_10 + var_266_11 + arg_266_0 then
				var_266_9.localPosition = Vector3.New(0, 100, 0)

				local var_266_16 = manager.ui.mainCamera.transform.position - var_266_9.position

				var_266_9.forward = Vector3.New(var_266_16.x, var_266_16.y, var_266_16.z)

				local var_266_17 = var_266_9.localEulerAngles

				var_266_17.z = 0
				var_266_17.x = 0
				var_266_9.localEulerAngles = var_266_17
			end

			local var_266_18 = 1.86666666666667
			local var_266_19 = 1

			if var_266_18 < arg_263_1.time_ and arg_263_1.time_ <= var_266_18 + arg_266_0 then
				local var_266_20 = "play"
				local var_266_21 = "effect"

				arg_263_1:AudioAction(var_266_20, var_266_21, "se_story_120_04", "se_story_120_04_dooropen", "")
			end

			local var_266_22 = 0
			local var_266_23 = 1.5

			if var_266_22 < arg_263_1.time_ and arg_263_1.time_ <= var_266_22 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, false)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_24 = arg_263_1:GetWordFromCfg(420012064)
				local var_266_25 = arg_263_1:FormatText(var_266_24.content)

				arg_263_1.text_.text = var_266_25

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_26 = 60
				local var_266_27 = utf8.len(var_266_25)
				local var_266_28 = var_266_26 <= 0 and var_266_23 or var_266_23 * (var_266_27 / var_266_26)

				if var_266_28 > 0 and var_266_23 < var_266_28 then
					arg_263_1.talkMaxDuration = var_266_28

					if var_266_28 + var_266_22 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_28 + var_266_22
					end
				end

				arg_263_1.text_.text = var_266_25
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_29 = math.max(var_266_23, arg_263_1.talkMaxDuration)

			if var_266_22 <= arg_263_1.time_ and arg_263_1.time_ < var_266_22 + var_266_29 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_22) / var_266_29

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_22 + var_266_29 and arg_263_1.time_ < var_266_22 + var_266_29 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_263_1:InitPlayNodeList()
	end,
	Play420012065 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 420012065
		arg_267_1.duration_ = 7.33

		local var_267_0 = {
			zh = 6.4,
			ja = 7.333
		}
		local var_267_1 = manager.audio:GetLocalizationFlag()

		if var_267_0[var_267_1] ~= nil then
			arg_267_1.duration_ = var_267_0[var_267_1]
		end

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play420012066(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = arg_267_1.actors_["404001ui_story"].transform
			local var_270_1 = 0

			if var_270_1 < arg_267_1.time_ and arg_267_1.time_ <= var_270_1 + arg_270_0 then
				arg_267_1.var_.moveOldPos404001ui_story = var_270_0.localPosition
			end

			local var_270_2 = 0.001

			if var_270_1 <= arg_267_1.time_ and arg_267_1.time_ < var_270_1 + var_270_2 then
				local var_270_3 = (arg_267_1.time_ - var_270_1) / var_270_2
				local var_270_4 = Vector3.New(0, -1.55, -5.5)

				var_270_0.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos404001ui_story, var_270_4, var_270_3)

				local var_270_5 = manager.ui.mainCamera.transform.position - var_270_0.position

				var_270_0.forward = Vector3.New(var_270_5.x, var_270_5.y, var_270_5.z)

				local var_270_6 = var_270_0.localEulerAngles

				var_270_6.z = 0
				var_270_6.x = 0
				var_270_0.localEulerAngles = var_270_6
			end

			if arg_267_1.time_ >= var_270_1 + var_270_2 and arg_267_1.time_ < var_270_1 + var_270_2 + arg_270_0 then
				var_270_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_270_7 = manager.ui.mainCamera.transform.position - var_270_0.position

				var_270_0.forward = Vector3.New(var_270_7.x, var_270_7.y, var_270_7.z)

				local var_270_8 = var_270_0.localEulerAngles

				var_270_8.z = 0
				var_270_8.x = 0
				var_270_0.localEulerAngles = var_270_8
			end

			local var_270_9 = arg_267_1.actors_["404001ui_story"]
			local var_270_10 = 0

			if var_270_10 < arg_267_1.time_ and arg_267_1.time_ <= var_270_10 + arg_270_0 and not isNil(var_270_9) and arg_267_1.var_.characterEffect404001ui_story == nil then
				arg_267_1.var_.characterEffect404001ui_story = var_270_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_11 = 0.200000002980232

			if var_270_10 <= arg_267_1.time_ and arg_267_1.time_ < var_270_10 + var_270_11 and not isNil(var_270_9) then
				local var_270_12 = (arg_267_1.time_ - var_270_10) / var_270_11

				if arg_267_1.var_.characterEffect404001ui_story and not isNil(var_270_9) then
					arg_267_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_267_1.time_ >= var_270_10 + var_270_11 and arg_267_1.time_ < var_270_10 + var_270_11 + arg_270_0 and not isNil(var_270_9) and arg_267_1.var_.characterEffect404001ui_story then
				arg_267_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_270_13 = 0

			if var_270_13 < arg_267_1.time_ and arg_267_1.time_ <= var_270_13 + arg_270_0 then
				arg_267_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_270_14 = 0

			if var_270_14 < arg_267_1.time_ and arg_267_1.time_ <= var_270_14 + arg_270_0 then
				arg_267_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_270_15 = 0
			local var_270_16 = 0.9

			if var_270_15 < arg_267_1.time_ and arg_267_1.time_ <= var_270_15 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				local var_270_17 = arg_267_1:FormatText(StoryNameCfg[668].name)

				arg_267_1.leftNameTxt_.text = var_270_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_18 = arg_267_1:GetWordFromCfg(420012065)
				local var_270_19 = arg_267_1:FormatText(var_270_18.content)

				arg_267_1.text_.text = var_270_19

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_20 = 36
				local var_270_21 = utf8.len(var_270_19)
				local var_270_22 = var_270_20 <= 0 and var_270_16 or var_270_16 * (var_270_21 / var_270_20)

				if var_270_22 > 0 and var_270_16 < var_270_22 then
					arg_267_1.talkMaxDuration = var_270_22

					if var_270_22 + var_270_15 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_22 + var_270_15
					end
				end

				arg_267_1.text_.text = var_270_19
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012065", "story_v_out_420012.awb") ~= 0 then
					local var_270_23 = manager.audio:GetVoiceLength("story_v_out_420012", "420012065", "story_v_out_420012.awb") / 1000

					if var_270_23 + var_270_15 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_23 + var_270_15
					end

					if var_270_18.prefab_name ~= "" and arg_267_1.actors_[var_270_18.prefab_name] ~= nil then
						local var_270_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_18.prefab_name].transform, "story_v_out_420012", "420012065", "story_v_out_420012.awb")

						arg_267_1:RecordAudio("420012065", var_270_24)
						arg_267_1:RecordAudio("420012065", var_270_24)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_420012", "420012065", "story_v_out_420012.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_420012", "420012065", "story_v_out_420012.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_25 = math.max(var_270_16, arg_267_1.talkMaxDuration)

			if var_270_15 <= arg_267_1.time_ and arg_267_1.time_ < var_270_15 + var_270_25 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_15) / var_270_25

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_15 + var_270_25 and arg_267_1.time_ < var_270_15 + var_270_25 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_267_1:InitPlayNodeList()
	end,
	Play420012066 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 420012066
		arg_271_1.duration_ = 9

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play420012067(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = 1.999999999999

			if var_274_0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_0 + arg_274_0 then
				local var_274_1 = manager.ui.mainCamera.transform.localPosition
				local var_274_2 = Vector3.New(0, 0, 10) + Vector3.New(var_274_1.x, var_274_1.y, 0)
				local var_274_3 = arg_271_1.bgs_.L01f

				var_274_3.transform.localPosition = var_274_2
				var_274_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_274_4 = var_274_3:GetComponent("SpriteRenderer")

				if var_274_4 and var_274_4.sprite then
					local var_274_5 = (var_274_3.transform.localPosition - var_274_1).z
					local var_274_6 = manager.ui.mainCameraCom_
					local var_274_7 = 2 * var_274_5 * Mathf.Tan(var_274_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_274_8 = var_274_7 * var_274_6.aspect
					local var_274_9 = var_274_4.sprite.bounds.size.x
					local var_274_10 = var_274_4.sprite.bounds.size.y
					local var_274_11 = var_274_8 / var_274_9
					local var_274_12 = var_274_7 / var_274_10
					local var_274_13 = var_274_12 < var_274_11 and var_274_11 or var_274_12

					var_274_3.transform.localScale = Vector3.New(var_274_13, var_274_13, 0)
				end

				for iter_274_0, iter_274_1 in pairs(arg_271_1.bgs_) do
					if iter_274_0 ~= "L01f" then
						iter_274_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_274_14 = 3.999999999999

			if var_274_14 < arg_271_1.time_ and arg_271_1.time_ <= var_274_14 + arg_274_0 then
				arg_271_1.allBtn_.enabled = false
			end

			local var_274_15 = 0.733333333334333

			if arg_271_1.time_ >= var_274_14 + var_274_15 and arg_271_1.time_ < var_274_14 + var_274_15 + arg_274_0 then
				arg_271_1.allBtn_.enabled = true
			end

			local var_274_16 = 0

			if var_274_16 < arg_271_1.time_ and arg_271_1.time_ <= var_274_16 + arg_274_0 then
				arg_271_1.mask_.enabled = true
				arg_271_1.mask_.raycastTarget = true

				arg_271_1:SetGaussion(false)
			end

			local var_274_17 = 2

			if var_274_16 <= arg_271_1.time_ and arg_271_1.time_ < var_274_16 + var_274_17 then
				local var_274_18 = (arg_271_1.time_ - var_274_16) / var_274_17
				local var_274_19 = Color.New(0, 0, 0)

				var_274_19.a = Mathf.Lerp(0, 1, var_274_18)
				arg_271_1.mask_.color = var_274_19
			end

			if arg_271_1.time_ >= var_274_16 + var_274_17 and arg_271_1.time_ < var_274_16 + var_274_17 + arg_274_0 then
				local var_274_20 = Color.New(0, 0, 0)

				var_274_20.a = 1
				arg_271_1.mask_.color = var_274_20
			end

			local var_274_21 = 2

			if var_274_21 < arg_271_1.time_ and arg_271_1.time_ <= var_274_21 + arg_274_0 then
				arg_271_1.mask_.enabled = true
				arg_271_1.mask_.raycastTarget = true

				arg_271_1:SetGaussion(false)
			end

			local var_274_22 = 2

			if var_274_21 <= arg_271_1.time_ and arg_271_1.time_ < var_274_21 + var_274_22 then
				local var_274_23 = (arg_271_1.time_ - var_274_21) / var_274_22
				local var_274_24 = Color.New(0, 0, 0)

				var_274_24.a = Mathf.Lerp(1, 0, var_274_23)
				arg_271_1.mask_.color = var_274_24
			end

			if arg_271_1.time_ >= var_274_21 + var_274_22 and arg_271_1.time_ < var_274_21 + var_274_22 + arg_274_0 then
				local var_274_25 = Color.New(0, 0, 0)
				local var_274_26 = 0

				arg_271_1.mask_.enabled = false
				var_274_25.a = var_274_26
				arg_271_1.mask_.color = var_274_25
			end

			local var_274_27 = arg_271_1.actors_["404001ui_story"].transform
			local var_274_28 = 1.999999999999

			if var_274_28 < arg_271_1.time_ and arg_271_1.time_ <= var_274_28 + arg_274_0 then
				arg_271_1.var_.moveOldPos404001ui_story = var_274_27.localPosition
			end

			local var_274_29 = 0.001

			if var_274_28 <= arg_271_1.time_ and arg_271_1.time_ < var_274_28 + var_274_29 then
				local var_274_30 = (arg_271_1.time_ - var_274_28) / var_274_29
				local var_274_31 = Vector3.New(0, 100, 0)

				var_274_27.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos404001ui_story, var_274_31, var_274_30)

				local var_274_32 = manager.ui.mainCamera.transform.position - var_274_27.position

				var_274_27.forward = Vector3.New(var_274_32.x, var_274_32.y, var_274_32.z)

				local var_274_33 = var_274_27.localEulerAngles

				var_274_33.z = 0
				var_274_33.x = 0
				var_274_27.localEulerAngles = var_274_33
			end

			if arg_271_1.time_ >= var_274_28 + var_274_29 and arg_271_1.time_ < var_274_28 + var_274_29 + arg_274_0 then
				var_274_27.localPosition = Vector3.New(0, 100, 0)

				local var_274_34 = manager.ui.mainCamera.transform.position - var_274_27.position

				var_274_27.forward = Vector3.New(var_274_34.x, var_274_34.y, var_274_34.z)

				local var_274_35 = var_274_27.localEulerAngles

				var_274_35.z = 0
				var_274_35.x = 0
				var_274_27.localEulerAngles = var_274_35
			end

			local var_274_36 = 3.73333333333333
			local var_274_37 = 1

			if var_274_36 < arg_271_1.time_ and arg_271_1.time_ <= var_274_36 + arg_274_0 then
				local var_274_38 = "play"
				local var_274_39 = "effect"

				arg_271_1:AudioAction(var_274_38, var_274_39, "se_story_1310", "se_story_1310_car02", "")
			end

			local var_274_40 = 1.6
			local var_274_41 = 1

			if var_274_40 < arg_271_1.time_ and arg_271_1.time_ <= var_274_40 + arg_274_0 then
				local var_274_42 = "play"
				local var_274_43 = "effect"

				arg_271_1:AudioAction(var_274_42, var_274_43, "se_story_140", "se_story_140_amb_street02", "")
			end

			local var_274_44 = 1.33333333333333
			local var_274_45 = 1

			if var_274_44 < arg_271_1.time_ and arg_271_1.time_ <= var_274_44 + arg_274_0 then
				local var_274_46 = "stop"
				local var_274_47 = "effect"

				arg_271_1:AudioAction(var_274_46, var_274_47, "se_story_140", "se_story_140_amb_room02", "")
			end

			if arg_271_1.frameCnt_ <= 1 then
				arg_271_1.dialog_:SetActive(false)
			end

			local var_274_48 = 3.999999999999
			local var_274_49 = 1.35

			if var_274_48 < arg_271_1.time_ and arg_271_1.time_ <= var_274_48 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0

				arg_271_1.dialog_:SetActive(true)

				arg_271_1.dialogCg_.alpha = 0

				local var_274_50 = LeanTween.value(arg_271_1.dialog_, 0, 1, 0.3)

				var_274_50:setOnUpdate(LuaHelper.FloatAction(function(arg_275_0)
					arg_271_1.dialogCg_.alpha = arg_275_0
				end))
				var_274_50:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_271_1.dialog_)
					var_274_50:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_271_1.duration_ = arg_271_1.duration_ + 0.3

				SetActive(arg_271_1.leftNameGo_, false)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_51 = arg_271_1:GetWordFromCfg(420012066)
				local var_274_52 = arg_271_1:FormatText(var_274_51.content)

				arg_271_1.text_.text = var_274_52

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_53 = 54
				local var_274_54 = utf8.len(var_274_52)
				local var_274_55 = var_274_53 <= 0 and var_274_49 or var_274_49 * (var_274_54 / var_274_53)

				if var_274_55 > 0 and var_274_49 < var_274_55 then
					arg_271_1.talkMaxDuration = var_274_55
					var_274_48 = var_274_48 + 0.3

					if var_274_55 + var_274_48 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_55 + var_274_48
					end
				end

				arg_271_1.text_.text = var_274_52
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)
				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_56 = var_274_48 + 0.3
			local var_274_57 = math.max(var_274_49, arg_271_1.talkMaxDuration)

			if var_274_56 <= arg_271_1.time_ and arg_271_1.time_ < var_274_56 + var_274_57 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_56) / var_274_57

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_56 + var_274_57 and arg_271_1.time_ < var_274_56 + var_274_57 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.999999999999,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_271_1:InitPlayNodeList()
	end,
	Play420012067 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 420012067
		arg_277_1.duration_ = 12.2

		local var_277_0 = {
			zh = 10.1,
			ja = 12.2
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
				arg_277_0:Play420012068(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = arg_277_1.actors_["404001ui_story"].transform
			local var_280_1 = 0

			if var_280_1 < arg_277_1.time_ and arg_277_1.time_ <= var_280_1 + arg_280_0 then
				arg_277_1.var_.moveOldPos404001ui_story = var_280_0.localPosition
			end

			local var_280_2 = 0.001

			if var_280_1 <= arg_277_1.time_ and arg_277_1.time_ < var_280_1 + var_280_2 then
				local var_280_3 = (arg_277_1.time_ - var_280_1) / var_280_2
				local var_280_4 = Vector3.New(0, -1.55, -5.5)

				var_280_0.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos404001ui_story, var_280_4, var_280_3)

				local var_280_5 = manager.ui.mainCamera.transform.position - var_280_0.position

				var_280_0.forward = Vector3.New(var_280_5.x, var_280_5.y, var_280_5.z)

				local var_280_6 = var_280_0.localEulerAngles

				var_280_6.z = 0
				var_280_6.x = 0
				var_280_0.localEulerAngles = var_280_6
			end

			if arg_277_1.time_ >= var_280_1 + var_280_2 and arg_277_1.time_ < var_280_1 + var_280_2 + arg_280_0 then
				var_280_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_280_7 = manager.ui.mainCamera.transform.position - var_280_0.position

				var_280_0.forward = Vector3.New(var_280_7.x, var_280_7.y, var_280_7.z)

				local var_280_8 = var_280_0.localEulerAngles

				var_280_8.z = 0
				var_280_8.x = 0
				var_280_0.localEulerAngles = var_280_8
			end

			local var_280_9 = arg_277_1.actors_["404001ui_story"]
			local var_280_10 = 0

			if var_280_10 < arg_277_1.time_ and arg_277_1.time_ <= var_280_10 + arg_280_0 and not isNil(var_280_9) and arg_277_1.var_.characterEffect404001ui_story == nil then
				arg_277_1.var_.characterEffect404001ui_story = var_280_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_11 = 0.200000002980232

			if var_280_10 <= arg_277_1.time_ and arg_277_1.time_ < var_280_10 + var_280_11 and not isNil(var_280_9) then
				local var_280_12 = (arg_277_1.time_ - var_280_10) / var_280_11

				if arg_277_1.var_.characterEffect404001ui_story and not isNil(var_280_9) then
					arg_277_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_277_1.time_ >= var_280_10 + var_280_11 and arg_277_1.time_ < var_280_10 + var_280_11 + arg_280_0 and not isNil(var_280_9) and arg_277_1.var_.characterEffect404001ui_story then
				arg_277_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_280_13 = 0

			if var_280_13 < arg_277_1.time_ and arg_277_1.time_ <= var_280_13 + arg_280_0 then
				arg_277_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_280_14 = 0
			local var_280_15 = 1.125

			if var_280_14 < arg_277_1.time_ and arg_277_1.time_ <= var_280_14 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_16 = arg_277_1:FormatText(StoryNameCfg[668].name)

				arg_277_1.leftNameTxt_.text = var_280_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_17 = arg_277_1:GetWordFromCfg(420012067)
				local var_280_18 = arg_277_1:FormatText(var_280_17.content)

				arg_277_1.text_.text = var_280_18

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_19 = 45
				local var_280_20 = utf8.len(var_280_18)
				local var_280_21 = var_280_19 <= 0 and var_280_15 or var_280_15 * (var_280_20 / var_280_19)

				if var_280_21 > 0 and var_280_15 < var_280_21 then
					arg_277_1.talkMaxDuration = var_280_21

					if var_280_21 + var_280_14 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_21 + var_280_14
					end
				end

				arg_277_1.text_.text = var_280_18
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012067", "story_v_out_420012.awb") ~= 0 then
					local var_280_22 = manager.audio:GetVoiceLength("story_v_out_420012", "420012067", "story_v_out_420012.awb") / 1000

					if var_280_22 + var_280_14 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_22 + var_280_14
					end

					if var_280_17.prefab_name ~= "" and arg_277_1.actors_[var_280_17.prefab_name] ~= nil then
						local var_280_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_17.prefab_name].transform, "story_v_out_420012", "420012067", "story_v_out_420012.awb")

						arg_277_1:RecordAudio("420012067", var_280_23)
						arg_277_1:RecordAudio("420012067", var_280_23)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_420012", "420012067", "story_v_out_420012.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_420012", "420012067", "story_v_out_420012.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_24 = math.max(var_280_15, arg_277_1.talkMaxDuration)

			if var_280_14 <= arg_277_1.time_ and arg_277_1.time_ < var_280_14 + var_280_24 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_14) / var_280_24

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_14 + var_280_24 and arg_277_1.time_ < var_280_14 + var_280_24 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
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
	Play420012068 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 420012068
		arg_281_1.duration_ = 3.8

		local var_281_0 = {
			zh = 2.8,
			ja = 3.8
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
				arg_281_0:Play420012069(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 0

			if var_284_0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_0 + arg_284_0 then
				arg_281_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_284_1 = 0

			if var_284_1 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 then
				arg_281_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action3_1")
			end

			local var_284_2 = 0

			if var_284_2 < arg_281_1.time_ and arg_281_1.time_ <= var_284_2 + arg_284_0 then
				arg_281_1.allBtn_.enabled = false
			end

			local var_284_3 = 1

			if arg_281_1.time_ >= var_284_2 + var_284_3 and arg_281_1.time_ < var_284_2 + var_284_3 + arg_284_0 then
				arg_281_1.allBtn_.enabled = true
			end

			local var_284_4 = 0
			local var_284_5 = 0.3

			if var_284_4 < arg_281_1.time_ and arg_281_1.time_ <= var_284_4 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_6 = arg_281_1:FormatText(StoryNameCfg[668].name)

				arg_281_1.leftNameTxt_.text = var_284_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_7 = arg_281_1:GetWordFromCfg(420012068)
				local var_284_8 = arg_281_1:FormatText(var_284_7.content)

				arg_281_1.text_.text = var_284_8

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_9 = 12
				local var_284_10 = utf8.len(var_284_8)
				local var_284_11 = var_284_9 <= 0 and var_284_5 or var_284_5 * (var_284_10 / var_284_9)

				if var_284_11 > 0 and var_284_5 < var_284_11 then
					arg_281_1.talkMaxDuration = var_284_11

					if var_284_11 + var_284_4 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_11 + var_284_4
					end
				end

				arg_281_1.text_.text = var_284_8
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012068", "story_v_out_420012.awb") ~= 0 then
					local var_284_12 = manager.audio:GetVoiceLength("story_v_out_420012", "420012068", "story_v_out_420012.awb") / 1000

					if var_284_12 + var_284_4 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_12 + var_284_4
					end

					if var_284_7.prefab_name ~= "" and arg_281_1.actors_[var_284_7.prefab_name] ~= nil then
						local var_284_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_7.prefab_name].transform, "story_v_out_420012", "420012068", "story_v_out_420012.awb")

						arg_281_1:RecordAudio("420012068", var_284_13)
						arg_281_1:RecordAudio("420012068", var_284_13)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_420012", "420012068", "story_v_out_420012.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_420012", "420012068", "story_v_out_420012.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_14 = math.max(var_284_5, arg_281_1.talkMaxDuration)

			if var_284_4 <= arg_281_1.time_ and arg_281_1.time_ < var_284_4 + var_284_14 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_4) / var_284_14

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_4 + var_284_14 and arg_281_1.time_ < var_284_4 + var_284_14 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play420012069 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 420012069
		arg_285_1.duration_ = 2.07

		local var_285_0 = {
			zh = 1.999999999999,
			ja = 2.066
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
				arg_285_0:Play420012070(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = arg_285_1.actors_["404001ui_story"].transform
			local var_288_1 = 0

			if var_288_1 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 then
				arg_285_1.var_.moveOldPos404001ui_story = var_288_0.localPosition
			end

			local var_288_2 = 0.001

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_2 then
				local var_288_3 = (arg_285_1.time_ - var_288_1) / var_288_2
				local var_288_4 = Vector3.New(-0.8, -1.55, -5.5)

				var_288_0.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos404001ui_story, var_288_4, var_288_3)

				local var_288_5 = manager.ui.mainCamera.transform.position - var_288_0.position

				var_288_0.forward = Vector3.New(var_288_5.x, var_288_5.y, var_288_5.z)

				local var_288_6 = var_288_0.localEulerAngles

				var_288_6.z = 0
				var_288_6.x = 0
				var_288_0.localEulerAngles = var_288_6
			end

			if arg_285_1.time_ >= var_288_1 + var_288_2 and arg_285_1.time_ < var_288_1 + var_288_2 + arg_288_0 then
				var_288_0.localPosition = Vector3.New(-0.8, -1.55, -5.5)

				local var_288_7 = manager.ui.mainCamera.transform.position - var_288_0.position

				var_288_0.forward = Vector3.New(var_288_7.x, var_288_7.y, var_288_7.z)

				local var_288_8 = var_288_0.localEulerAngles

				var_288_8.z = 0
				var_288_8.x = 0
				var_288_0.localEulerAngles = var_288_8
			end

			local var_288_9 = arg_285_1.actors_["1085ui_story"].transform
			local var_288_10 = 0

			if var_288_10 < arg_285_1.time_ and arg_285_1.time_ <= var_288_10 + arg_288_0 then
				arg_285_1.var_.moveOldPos1085ui_story = var_288_9.localPosition
			end

			local var_288_11 = 0.001

			if var_288_10 <= arg_285_1.time_ and arg_285_1.time_ < var_288_10 + var_288_11 then
				local var_288_12 = (arg_285_1.time_ - var_288_10) / var_288_11
				local var_288_13 = Vector3.New(0.75, -1.01, -5.83)

				var_288_9.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos1085ui_story, var_288_13, var_288_12)

				local var_288_14 = manager.ui.mainCamera.transform.position - var_288_9.position

				var_288_9.forward = Vector3.New(var_288_14.x, var_288_14.y, var_288_14.z)

				local var_288_15 = var_288_9.localEulerAngles

				var_288_15.z = 0
				var_288_15.x = 0
				var_288_9.localEulerAngles = var_288_15
			end

			if arg_285_1.time_ >= var_288_10 + var_288_11 and arg_285_1.time_ < var_288_10 + var_288_11 + arg_288_0 then
				var_288_9.localPosition = Vector3.New(0.75, -1.01, -5.83)

				local var_288_16 = manager.ui.mainCamera.transform.position - var_288_9.position

				var_288_9.forward = Vector3.New(var_288_16.x, var_288_16.y, var_288_16.z)

				local var_288_17 = var_288_9.localEulerAngles

				var_288_17.z = 0
				var_288_17.x = 0
				var_288_9.localEulerAngles = var_288_17
			end

			local var_288_18 = arg_285_1.actors_["1085ui_story"]
			local var_288_19 = 0

			if var_288_19 < arg_285_1.time_ and arg_285_1.time_ <= var_288_19 + arg_288_0 and not isNil(var_288_18) and arg_285_1.var_.characterEffect1085ui_story == nil then
				arg_285_1.var_.characterEffect1085ui_story = var_288_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_20 = 0.200000002980232

			if var_288_19 <= arg_285_1.time_ and arg_285_1.time_ < var_288_19 + var_288_20 and not isNil(var_288_18) then
				local var_288_21 = (arg_285_1.time_ - var_288_19) / var_288_20

				if arg_285_1.var_.characterEffect1085ui_story and not isNil(var_288_18) then
					arg_285_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_285_1.time_ >= var_288_19 + var_288_20 and arg_285_1.time_ < var_288_19 + var_288_20 + arg_288_0 and not isNil(var_288_18) and arg_285_1.var_.characterEffect1085ui_story then
				arg_285_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_288_22 = arg_285_1.actors_["404001ui_story"]
			local var_288_23 = 0

			if var_288_23 < arg_285_1.time_ and arg_285_1.time_ <= var_288_23 + arg_288_0 and not isNil(var_288_22) and arg_285_1.var_.characterEffect404001ui_story == nil then
				arg_285_1.var_.characterEffect404001ui_story = var_288_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_24 = 0.200000002980232

			if var_288_23 <= arg_285_1.time_ and arg_285_1.time_ < var_288_23 + var_288_24 and not isNil(var_288_22) then
				local var_288_25 = (arg_285_1.time_ - var_288_23) / var_288_24

				if arg_285_1.var_.characterEffect404001ui_story and not isNil(var_288_22) then
					local var_288_26 = Mathf.Lerp(0, 0.5, var_288_25)

					arg_285_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_285_1.var_.characterEffect404001ui_story.fillRatio = var_288_26
				end
			end

			if arg_285_1.time_ >= var_288_23 + var_288_24 and arg_285_1.time_ < var_288_23 + var_288_24 + arg_288_0 and not isNil(var_288_22) and arg_285_1.var_.characterEffect404001ui_story then
				local var_288_27 = 0.5

				arg_285_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_285_1.var_.characterEffect404001ui_story.fillRatio = var_288_27
			end

			local var_288_28 = 0

			if var_288_28 < arg_285_1.time_ and arg_285_1.time_ <= var_288_28 + arg_288_0 then
				arg_285_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			local var_288_29 = 0

			if var_288_29 < arg_285_1.time_ and arg_285_1.time_ <= var_288_29 + arg_288_0 then
				arg_285_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_288_30 = 0
			local var_288_31 = 0.1

			if var_288_30 < arg_285_1.time_ and arg_285_1.time_ <= var_288_30 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_32 = arg_285_1:FormatText(StoryNameCfg[328].name)

				arg_285_1.leftNameTxt_.text = var_288_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_33 = arg_285_1:GetWordFromCfg(420012069)
				local var_288_34 = arg_285_1:FormatText(var_288_33.content)

				arg_285_1.text_.text = var_288_34

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_35 = 4
				local var_288_36 = utf8.len(var_288_34)
				local var_288_37 = var_288_35 <= 0 and var_288_31 or var_288_31 * (var_288_36 / var_288_35)

				if var_288_37 > 0 and var_288_31 < var_288_37 then
					arg_285_1.talkMaxDuration = var_288_37

					if var_288_37 + var_288_30 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_37 + var_288_30
					end
				end

				arg_285_1.text_.text = var_288_34
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012069", "story_v_out_420012.awb") ~= 0 then
					local var_288_38 = manager.audio:GetVoiceLength("story_v_out_420012", "420012069", "story_v_out_420012.awb") / 1000

					if var_288_38 + var_288_30 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_38 + var_288_30
					end

					if var_288_33.prefab_name ~= "" and arg_285_1.actors_[var_288_33.prefab_name] ~= nil then
						local var_288_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_33.prefab_name].transform, "story_v_out_420012", "420012069", "story_v_out_420012.awb")

						arg_285_1:RecordAudio("420012069", var_288_39)
						arg_285_1:RecordAudio("420012069", var_288_39)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_420012", "420012069", "story_v_out_420012.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_420012", "420012069", "story_v_out_420012.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_40 = math.max(var_288_31, arg_285_1.talkMaxDuration)

			if var_288_30 <= arg_285_1.time_ and arg_285_1.time_ < var_288_30 + var_288_40 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_30) / var_288_40

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_30 + var_288_40 and arg_285_1.time_ < var_288_30 + var_288_40 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_285_1:InitPlayNodeList()
	end,
	Play420012070 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 420012070
		arg_289_1.duration_ = 13.03

		local var_289_0 = {
			zh = 7.633,
			ja = 13.033
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
				arg_289_0:Play420012071(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = arg_289_1.actors_["1085ui_story"]
			local var_292_1 = 0

			if var_292_1 < arg_289_1.time_ and arg_289_1.time_ <= var_292_1 + arg_292_0 and not isNil(var_292_0) and arg_289_1.var_.characterEffect1085ui_story == nil then
				arg_289_1.var_.characterEffect1085ui_story = var_292_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_2 = 0.200000002980232

			if var_292_1 <= arg_289_1.time_ and arg_289_1.time_ < var_292_1 + var_292_2 and not isNil(var_292_0) then
				local var_292_3 = (arg_289_1.time_ - var_292_1) / var_292_2

				if arg_289_1.var_.characterEffect1085ui_story and not isNil(var_292_0) then
					local var_292_4 = Mathf.Lerp(0, 0.5, var_292_3)

					arg_289_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_289_1.var_.characterEffect1085ui_story.fillRatio = var_292_4
				end
			end

			if arg_289_1.time_ >= var_292_1 + var_292_2 and arg_289_1.time_ < var_292_1 + var_292_2 + arg_292_0 and not isNil(var_292_0) and arg_289_1.var_.characterEffect1085ui_story then
				local var_292_5 = 0.5

				arg_289_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_289_1.var_.characterEffect1085ui_story.fillRatio = var_292_5
			end

			local var_292_6 = arg_289_1.actors_["404001ui_story"]
			local var_292_7 = 0

			if var_292_7 < arg_289_1.time_ and arg_289_1.time_ <= var_292_7 + arg_292_0 and not isNil(var_292_6) and arg_289_1.var_.characterEffect404001ui_story == nil then
				arg_289_1.var_.characterEffect404001ui_story = var_292_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_8 = 0.200000002980232

			if var_292_7 <= arg_289_1.time_ and arg_289_1.time_ < var_292_7 + var_292_8 and not isNil(var_292_6) then
				local var_292_9 = (arg_289_1.time_ - var_292_7) / var_292_8

				if arg_289_1.var_.characterEffect404001ui_story and not isNil(var_292_6) then
					arg_289_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_289_1.time_ >= var_292_7 + var_292_8 and arg_289_1.time_ < var_292_7 + var_292_8 + arg_292_0 and not isNil(var_292_6) and arg_289_1.var_.characterEffect404001ui_story then
				arg_289_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_292_10 = 0

			if var_292_10 < arg_289_1.time_ and arg_289_1.time_ <= var_292_10 + arg_292_0 then
				arg_289_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_292_11 = 0

			if var_292_11 < arg_289_1.time_ and arg_289_1.time_ <= var_292_11 + arg_292_0 then
				arg_289_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040actionlink/4040action434")
			end

			local var_292_12 = 0
			local var_292_13 = 0.725

			if var_292_12 < arg_289_1.time_ and arg_289_1.time_ <= var_292_12 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				local var_292_14 = arg_289_1:FormatText(StoryNameCfg[668].name)

				arg_289_1.leftNameTxt_.text = var_292_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_15 = arg_289_1:GetWordFromCfg(420012070)
				local var_292_16 = arg_289_1:FormatText(var_292_15.content)

				arg_289_1.text_.text = var_292_16

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_17 = 29
				local var_292_18 = utf8.len(var_292_16)
				local var_292_19 = var_292_17 <= 0 and var_292_13 or var_292_13 * (var_292_18 / var_292_17)

				if var_292_19 > 0 and var_292_13 < var_292_19 then
					arg_289_1.talkMaxDuration = var_292_19

					if var_292_19 + var_292_12 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_19 + var_292_12
					end
				end

				arg_289_1.text_.text = var_292_16
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012070", "story_v_out_420012.awb") ~= 0 then
					local var_292_20 = manager.audio:GetVoiceLength("story_v_out_420012", "420012070", "story_v_out_420012.awb") / 1000

					if var_292_20 + var_292_12 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_20 + var_292_12
					end

					if var_292_15.prefab_name ~= "" and arg_289_1.actors_[var_292_15.prefab_name] ~= nil then
						local var_292_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_15.prefab_name].transform, "story_v_out_420012", "420012070", "story_v_out_420012.awb")

						arg_289_1:RecordAudio("420012070", var_292_21)
						arg_289_1:RecordAudio("420012070", var_292_21)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_420012", "420012070", "story_v_out_420012.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_420012", "420012070", "story_v_out_420012.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_22 = math.max(var_292_13, arg_289_1.talkMaxDuration)

			if var_292_12 <= arg_289_1.time_ and arg_289_1.time_ < var_292_12 + var_292_22 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_12) / var_292_22

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_12 + var_292_22 and arg_289_1.time_ < var_292_12 + var_292_22 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play420012071 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 420012071
		arg_293_1.duration_ = 5

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play420012072(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = arg_293_1.actors_["404001ui_story"]
			local var_296_1 = 0

			if var_296_1 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 and not isNil(var_296_0) and arg_293_1.var_.characterEffect404001ui_story == nil then
				arg_293_1.var_.characterEffect404001ui_story = var_296_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_2 = 0.200000002980232

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_2 and not isNil(var_296_0) then
				local var_296_3 = (arg_293_1.time_ - var_296_1) / var_296_2

				if arg_293_1.var_.characterEffect404001ui_story and not isNil(var_296_0) then
					local var_296_4 = Mathf.Lerp(0, 0.5, var_296_3)

					arg_293_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_293_1.var_.characterEffect404001ui_story.fillRatio = var_296_4
				end
			end

			if arg_293_1.time_ >= var_296_1 + var_296_2 and arg_293_1.time_ < var_296_1 + var_296_2 + arg_296_0 and not isNil(var_296_0) and arg_293_1.var_.characterEffect404001ui_story then
				local var_296_5 = 0.5

				arg_293_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_293_1.var_.characterEffect404001ui_story.fillRatio = var_296_5
			end

			local var_296_6 = 0
			local var_296_7 = 1.5

			if var_296_6 < arg_293_1.time_ and arg_293_1.time_ <= var_296_6 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, false)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_8 = arg_293_1:GetWordFromCfg(420012071)
				local var_296_9 = arg_293_1:FormatText(var_296_8.content)

				arg_293_1.text_.text = var_296_9

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_10 = 60
				local var_296_11 = utf8.len(var_296_9)
				local var_296_12 = var_296_10 <= 0 and var_296_7 or var_296_7 * (var_296_11 / var_296_10)

				if var_296_12 > 0 and var_296_7 < var_296_12 then
					arg_293_1.talkMaxDuration = var_296_12

					if var_296_12 + var_296_6 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_12 + var_296_6
					end
				end

				arg_293_1.text_.text = var_296_9
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)
				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_13 = math.max(var_296_7, arg_293_1.talkMaxDuration)

			if var_296_6 <= arg_293_1.time_ and arg_293_1.time_ < var_296_6 + var_296_13 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_6) / var_296_13

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_6 + var_296_13 and arg_293_1.time_ < var_296_6 + var_296_13 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play420012072 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 420012072
		arg_297_1.duration_ = 3.6

		local var_297_0 = {
			zh = 3.266,
			ja = 3.6
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
				arg_297_0:Play420012073(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = arg_297_1.actors_["1085ui_story"]
			local var_300_1 = 0

			if var_300_1 < arg_297_1.time_ and arg_297_1.time_ <= var_300_1 + arg_300_0 and not isNil(var_300_0) and arg_297_1.var_.characterEffect1085ui_story == nil then
				arg_297_1.var_.characterEffect1085ui_story = var_300_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_2 = 0.200000002980232

			if var_300_1 <= arg_297_1.time_ and arg_297_1.time_ < var_300_1 + var_300_2 and not isNil(var_300_0) then
				local var_300_3 = (arg_297_1.time_ - var_300_1) / var_300_2

				if arg_297_1.var_.characterEffect1085ui_story and not isNil(var_300_0) then
					arg_297_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_297_1.time_ >= var_300_1 + var_300_2 and arg_297_1.time_ < var_300_1 + var_300_2 + arg_300_0 and not isNil(var_300_0) and arg_297_1.var_.characterEffect1085ui_story then
				arg_297_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_300_4 = 0

			if var_300_4 < arg_297_1.time_ and arg_297_1.time_ <= var_300_4 + arg_300_0 then
				arg_297_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_300_5 = 0
			local var_300_6 = 0.325

			if var_300_5 < arg_297_1.time_ and arg_297_1.time_ <= var_300_5 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				local var_300_7 = arg_297_1:FormatText(StoryNameCfg[328].name)

				arg_297_1.leftNameTxt_.text = var_300_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_8 = arg_297_1:GetWordFromCfg(420012072)
				local var_300_9 = arg_297_1:FormatText(var_300_8.content)

				arg_297_1.text_.text = var_300_9

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_10 = 13
				local var_300_11 = utf8.len(var_300_9)
				local var_300_12 = var_300_10 <= 0 and var_300_6 or var_300_6 * (var_300_11 / var_300_10)

				if var_300_12 > 0 and var_300_6 < var_300_12 then
					arg_297_1.talkMaxDuration = var_300_12

					if var_300_12 + var_300_5 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_12 + var_300_5
					end
				end

				arg_297_1.text_.text = var_300_9
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012072", "story_v_out_420012.awb") ~= 0 then
					local var_300_13 = manager.audio:GetVoiceLength("story_v_out_420012", "420012072", "story_v_out_420012.awb") / 1000

					if var_300_13 + var_300_5 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_13 + var_300_5
					end

					if var_300_8.prefab_name ~= "" and arg_297_1.actors_[var_300_8.prefab_name] ~= nil then
						local var_300_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_8.prefab_name].transform, "story_v_out_420012", "420012072", "story_v_out_420012.awb")

						arg_297_1:RecordAudio("420012072", var_300_14)
						arg_297_1:RecordAudio("420012072", var_300_14)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_420012", "420012072", "story_v_out_420012.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_420012", "420012072", "story_v_out_420012.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_15 = math.max(var_300_6, arg_297_1.talkMaxDuration)

			if var_300_5 <= arg_297_1.time_ and arg_297_1.time_ < var_300_5 + var_300_15 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_5) / var_300_15

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_5 + var_300_15 and arg_297_1.time_ < var_300_5 + var_300_15 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play420012073 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 420012073
		arg_301_1.duration_ = 6.47

		local var_301_0 = {
			zh = 5.2,
			ja = 6.466
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
				arg_301_0:Play420012074(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = arg_301_1.actors_["1085ui_story"]
			local var_304_1 = 0

			if var_304_1 < arg_301_1.time_ and arg_301_1.time_ <= var_304_1 + arg_304_0 and not isNil(var_304_0) and arg_301_1.var_.characterEffect1085ui_story == nil then
				arg_301_1.var_.characterEffect1085ui_story = var_304_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_2 = 0.200000002980232

			if var_304_1 <= arg_301_1.time_ and arg_301_1.time_ < var_304_1 + var_304_2 and not isNil(var_304_0) then
				local var_304_3 = (arg_301_1.time_ - var_304_1) / var_304_2

				if arg_301_1.var_.characterEffect1085ui_story and not isNil(var_304_0) then
					local var_304_4 = Mathf.Lerp(0, 0.5, var_304_3)

					arg_301_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_301_1.var_.characterEffect1085ui_story.fillRatio = var_304_4
				end
			end

			if arg_301_1.time_ >= var_304_1 + var_304_2 and arg_301_1.time_ < var_304_1 + var_304_2 + arg_304_0 and not isNil(var_304_0) and arg_301_1.var_.characterEffect1085ui_story then
				local var_304_5 = 0.5

				arg_301_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_301_1.var_.characterEffect1085ui_story.fillRatio = var_304_5
			end

			local var_304_6 = arg_301_1.actors_["404001ui_story"]
			local var_304_7 = 0

			if var_304_7 < arg_301_1.time_ and arg_301_1.time_ <= var_304_7 + arg_304_0 and not isNil(var_304_6) and arg_301_1.var_.characterEffect404001ui_story == nil then
				arg_301_1.var_.characterEffect404001ui_story = var_304_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_8 = 0.200000002980232

			if var_304_7 <= arg_301_1.time_ and arg_301_1.time_ < var_304_7 + var_304_8 and not isNil(var_304_6) then
				local var_304_9 = (arg_301_1.time_ - var_304_7) / var_304_8

				if arg_301_1.var_.characterEffect404001ui_story and not isNil(var_304_6) then
					arg_301_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_301_1.time_ >= var_304_7 + var_304_8 and arg_301_1.time_ < var_304_7 + var_304_8 + arg_304_0 and not isNil(var_304_6) and arg_301_1.var_.characterEffect404001ui_story then
				arg_301_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_304_10 = 0

			if var_304_10 < arg_301_1.time_ and arg_301_1.time_ <= var_304_10 + arg_304_0 then
				arg_301_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action4_2")
			end

			local var_304_11 = 0

			if var_304_11 < arg_301_1.time_ and arg_301_1.time_ <= var_304_11 + arg_304_0 then
				arg_301_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_304_12 = 0
			local var_304_13 = 0.5

			if var_304_12 < arg_301_1.time_ and arg_301_1.time_ <= var_304_12 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				local var_304_14 = arg_301_1:FormatText(StoryNameCfg[668].name)

				arg_301_1.leftNameTxt_.text = var_304_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_15 = arg_301_1:GetWordFromCfg(420012073)
				local var_304_16 = arg_301_1:FormatText(var_304_15.content)

				arg_301_1.text_.text = var_304_16

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_17 = 20
				local var_304_18 = utf8.len(var_304_16)
				local var_304_19 = var_304_17 <= 0 and var_304_13 or var_304_13 * (var_304_18 / var_304_17)

				if var_304_19 > 0 and var_304_13 < var_304_19 then
					arg_301_1.talkMaxDuration = var_304_19

					if var_304_19 + var_304_12 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_19 + var_304_12
					end
				end

				arg_301_1.text_.text = var_304_16
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012073", "story_v_out_420012.awb") ~= 0 then
					local var_304_20 = manager.audio:GetVoiceLength("story_v_out_420012", "420012073", "story_v_out_420012.awb") / 1000

					if var_304_20 + var_304_12 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_20 + var_304_12
					end

					if var_304_15.prefab_name ~= "" and arg_301_1.actors_[var_304_15.prefab_name] ~= nil then
						local var_304_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_15.prefab_name].transform, "story_v_out_420012", "420012073", "story_v_out_420012.awb")

						arg_301_1:RecordAudio("420012073", var_304_21)
						arg_301_1:RecordAudio("420012073", var_304_21)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_420012", "420012073", "story_v_out_420012.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_420012", "420012073", "story_v_out_420012.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_22 = math.max(var_304_13, arg_301_1.talkMaxDuration)

			if var_304_12 <= arg_301_1.time_ and arg_301_1.time_ < var_304_12 + var_304_22 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_12) / var_304_22

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_12 + var_304_22 and arg_301_1.time_ < var_304_12 + var_304_22 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play420012074 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 420012074
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play420012075(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = arg_305_1.actors_["404001ui_story"].transform
			local var_308_1 = 0

			if var_308_1 < arg_305_1.time_ and arg_305_1.time_ <= var_308_1 + arg_308_0 then
				arg_305_1.var_.moveOldPos404001ui_story = var_308_0.localPosition
			end

			local var_308_2 = 0.001

			if var_308_1 <= arg_305_1.time_ and arg_305_1.time_ < var_308_1 + var_308_2 then
				local var_308_3 = (arg_305_1.time_ - var_308_1) / var_308_2
				local var_308_4 = Vector3.New(0, 100, 0)

				var_308_0.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPos404001ui_story, var_308_4, var_308_3)

				local var_308_5 = manager.ui.mainCamera.transform.position - var_308_0.position

				var_308_0.forward = Vector3.New(var_308_5.x, var_308_5.y, var_308_5.z)

				local var_308_6 = var_308_0.localEulerAngles

				var_308_6.z = 0
				var_308_6.x = 0
				var_308_0.localEulerAngles = var_308_6
			end

			if arg_305_1.time_ >= var_308_1 + var_308_2 and arg_305_1.time_ < var_308_1 + var_308_2 + arg_308_0 then
				var_308_0.localPosition = Vector3.New(0, 100, 0)

				local var_308_7 = manager.ui.mainCamera.transform.position - var_308_0.position

				var_308_0.forward = Vector3.New(var_308_7.x, var_308_7.y, var_308_7.z)

				local var_308_8 = var_308_0.localEulerAngles

				var_308_8.z = 0
				var_308_8.x = 0
				var_308_0.localEulerAngles = var_308_8
			end

			local var_308_9 = arg_305_1.actors_["1085ui_story"].transform
			local var_308_10 = 0

			if var_308_10 < arg_305_1.time_ and arg_305_1.time_ <= var_308_10 + arg_308_0 then
				arg_305_1.var_.moveOldPos1085ui_story = var_308_9.localPosition
			end

			local var_308_11 = 0.001

			if var_308_10 <= arg_305_1.time_ and arg_305_1.time_ < var_308_10 + var_308_11 then
				local var_308_12 = (arg_305_1.time_ - var_308_10) / var_308_11
				local var_308_13 = Vector3.New(0, 100, 0)

				var_308_9.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPos1085ui_story, var_308_13, var_308_12)

				local var_308_14 = manager.ui.mainCamera.transform.position - var_308_9.position

				var_308_9.forward = Vector3.New(var_308_14.x, var_308_14.y, var_308_14.z)

				local var_308_15 = var_308_9.localEulerAngles

				var_308_15.z = 0
				var_308_15.x = 0
				var_308_9.localEulerAngles = var_308_15
			end

			if arg_305_1.time_ >= var_308_10 + var_308_11 and arg_305_1.time_ < var_308_10 + var_308_11 + arg_308_0 then
				var_308_9.localPosition = Vector3.New(0, 100, 0)

				local var_308_16 = manager.ui.mainCamera.transform.position - var_308_9.position

				var_308_9.forward = Vector3.New(var_308_16.x, var_308_16.y, var_308_16.z)

				local var_308_17 = var_308_9.localEulerAngles

				var_308_17.z = 0
				var_308_17.x = 0
				var_308_9.localEulerAngles = var_308_17
			end

			local var_308_18 = 0
			local var_308_19 = 1.3

			if var_308_18 < arg_305_1.time_ and arg_305_1.time_ <= var_308_18 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, false)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_20 = arg_305_1:GetWordFromCfg(420012074)
				local var_308_21 = arg_305_1:FormatText(var_308_20.content)

				arg_305_1.text_.text = var_308_21

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_22 = 52
				local var_308_23 = utf8.len(var_308_21)
				local var_308_24 = var_308_22 <= 0 and var_308_19 or var_308_19 * (var_308_23 / var_308_22)

				if var_308_24 > 0 and var_308_19 < var_308_24 then
					arg_305_1.talkMaxDuration = var_308_24

					if var_308_24 + var_308_18 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_24 + var_308_18
					end
				end

				arg_305_1.text_.text = var_308_21
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_25 = math.max(var_308_19, arg_305_1.talkMaxDuration)

			if var_308_18 <= arg_305_1.time_ and arg_305_1.time_ < var_308_18 + var_308_25 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_18) / var_308_25

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_18 + var_308_25 and arg_305_1.time_ < var_308_18 + var_308_25 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_305_1:InitPlayNodeList()
	end,
	Play420012075 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 420012075
		arg_309_1.duration_ = 3.47

		local var_309_0 = {
			zh = 3.466,
			ja = 3.3
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
				arg_309_0:Play420012076(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = arg_309_1.actors_["1085ui_story"]
			local var_312_1 = 0

			if var_312_1 < arg_309_1.time_ and arg_309_1.time_ <= var_312_1 + arg_312_0 and not isNil(var_312_0) and arg_309_1.var_.characterEffect1085ui_story == nil then
				arg_309_1.var_.characterEffect1085ui_story = var_312_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_2 = 0.200000002980232

			if var_312_1 <= arg_309_1.time_ and arg_309_1.time_ < var_312_1 + var_312_2 and not isNil(var_312_0) then
				local var_312_3 = (arg_309_1.time_ - var_312_1) / var_312_2

				if arg_309_1.var_.characterEffect1085ui_story and not isNil(var_312_0) then
					arg_309_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_309_1.time_ >= var_312_1 + var_312_2 and arg_309_1.time_ < var_312_1 + var_312_2 + arg_312_0 and not isNil(var_312_0) and arg_309_1.var_.characterEffect1085ui_story then
				arg_309_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_312_4 = arg_309_1.actors_["1085ui_story"].transform
			local var_312_5 = 0

			if var_312_5 < arg_309_1.time_ and arg_309_1.time_ <= var_312_5 + arg_312_0 then
				arg_309_1.var_.moveOldPos1085ui_story = var_312_4.localPosition
			end

			local var_312_6 = 0.001

			if var_312_5 <= arg_309_1.time_ and arg_309_1.time_ < var_312_5 + var_312_6 then
				local var_312_7 = (arg_309_1.time_ - var_312_5) / var_312_6
				local var_312_8 = Vector3.New(0, -1.01, -5.83)

				var_312_4.localPosition = Vector3.Lerp(arg_309_1.var_.moveOldPos1085ui_story, var_312_8, var_312_7)

				local var_312_9 = manager.ui.mainCamera.transform.position - var_312_4.position

				var_312_4.forward = Vector3.New(var_312_9.x, var_312_9.y, var_312_9.z)

				local var_312_10 = var_312_4.localEulerAngles

				var_312_10.z = 0
				var_312_10.x = 0
				var_312_4.localEulerAngles = var_312_10
			end

			if arg_309_1.time_ >= var_312_5 + var_312_6 and arg_309_1.time_ < var_312_5 + var_312_6 + arg_312_0 then
				var_312_4.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_312_11 = manager.ui.mainCamera.transform.position - var_312_4.position

				var_312_4.forward = Vector3.New(var_312_11.x, var_312_11.y, var_312_11.z)

				local var_312_12 = var_312_4.localEulerAngles

				var_312_12.z = 0
				var_312_12.x = 0
				var_312_4.localEulerAngles = var_312_12
			end

			local var_312_13 = 0

			if var_312_13 < arg_309_1.time_ and arg_309_1.time_ <= var_312_13 + arg_312_0 then
				arg_309_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action2_1")
			end

			local var_312_14 = 0

			if var_312_14 < arg_309_1.time_ and arg_309_1.time_ <= var_312_14 + arg_312_0 then
				arg_309_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_312_15 = 0

			if var_312_15 < arg_309_1.time_ and arg_309_1.time_ <= var_312_15 + arg_312_0 then
				arg_309_1.allBtn_.enabled = false
			end

			local var_312_16 = 1

			if arg_309_1.time_ >= var_312_15 + var_312_16 and arg_309_1.time_ < var_312_15 + var_312_16 + arg_312_0 then
				arg_309_1.allBtn_.enabled = true
			end

			local var_312_17 = 0
			local var_312_18 = 0.225

			if var_312_17 < arg_309_1.time_ and arg_309_1.time_ <= var_312_17 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				local var_312_19 = arg_309_1:FormatText(StoryNameCfg[328].name)

				arg_309_1.leftNameTxt_.text = var_312_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_20 = arg_309_1:GetWordFromCfg(420012075)
				local var_312_21 = arg_309_1:FormatText(var_312_20.content)

				arg_309_1.text_.text = var_312_21

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_22 = 9
				local var_312_23 = utf8.len(var_312_21)
				local var_312_24 = var_312_22 <= 0 and var_312_18 or var_312_18 * (var_312_23 / var_312_22)

				if var_312_24 > 0 and var_312_18 < var_312_24 then
					arg_309_1.talkMaxDuration = var_312_24

					if var_312_24 + var_312_17 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_24 + var_312_17
					end
				end

				arg_309_1.text_.text = var_312_21
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012075", "story_v_out_420012.awb") ~= 0 then
					local var_312_25 = manager.audio:GetVoiceLength("story_v_out_420012", "420012075", "story_v_out_420012.awb") / 1000

					if var_312_25 + var_312_17 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_25 + var_312_17
					end

					if var_312_20.prefab_name ~= "" and arg_309_1.actors_[var_312_20.prefab_name] ~= nil then
						local var_312_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_20.prefab_name].transform, "story_v_out_420012", "420012075", "story_v_out_420012.awb")

						arg_309_1:RecordAudio("420012075", var_312_26)
						arg_309_1:RecordAudio("420012075", var_312_26)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_420012", "420012075", "story_v_out_420012.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_420012", "420012075", "story_v_out_420012.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_27 = math.max(var_312_18, arg_309_1.talkMaxDuration)

			if var_312_17 <= arg_309_1.time_ and arg_309_1.time_ < var_312_17 + var_312_27 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_17) / var_312_27

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_17 + var_312_27 and arg_309_1.time_ < var_312_17 + var_312_27 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_309_1:InitPlayNodeList()
	end,
	Play420012076 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 420012076
		arg_313_1.duration_ = 2

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play420012077(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = arg_313_1.actors_["404001ui_story"].transform
			local var_316_1 = 0

			if var_316_1 < arg_313_1.time_ and arg_313_1.time_ <= var_316_1 + arg_316_0 then
				arg_313_1.var_.moveOldPos404001ui_story = var_316_0.localPosition
			end

			local var_316_2 = 0.001

			if var_316_1 <= arg_313_1.time_ and arg_313_1.time_ < var_316_1 + var_316_2 then
				local var_316_3 = (arg_313_1.time_ - var_316_1) / var_316_2
				local var_316_4 = Vector3.New(0, -1.55, -5.5)

				var_316_0.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos404001ui_story, var_316_4, var_316_3)

				local var_316_5 = manager.ui.mainCamera.transform.position - var_316_0.position

				var_316_0.forward = Vector3.New(var_316_5.x, var_316_5.y, var_316_5.z)

				local var_316_6 = var_316_0.localEulerAngles

				var_316_6.z = 0
				var_316_6.x = 0
				var_316_0.localEulerAngles = var_316_6
			end

			if arg_313_1.time_ >= var_316_1 + var_316_2 and arg_313_1.time_ < var_316_1 + var_316_2 + arg_316_0 then
				var_316_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_316_7 = manager.ui.mainCamera.transform.position - var_316_0.position

				var_316_0.forward = Vector3.New(var_316_7.x, var_316_7.y, var_316_7.z)

				local var_316_8 = var_316_0.localEulerAngles

				var_316_8.z = 0
				var_316_8.x = 0
				var_316_0.localEulerAngles = var_316_8
			end

			local var_316_9 = arg_313_1.actors_["1085ui_story"]
			local var_316_10 = 0

			if var_316_10 < arg_313_1.time_ and arg_313_1.time_ <= var_316_10 + arg_316_0 and not isNil(var_316_9) and arg_313_1.var_.characterEffect1085ui_story == nil then
				arg_313_1.var_.characterEffect1085ui_story = var_316_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_11 = 0.200000002980232

			if var_316_10 <= arg_313_1.time_ and arg_313_1.time_ < var_316_10 + var_316_11 and not isNil(var_316_9) then
				local var_316_12 = (arg_313_1.time_ - var_316_10) / var_316_11

				if arg_313_1.var_.characterEffect1085ui_story and not isNil(var_316_9) then
					local var_316_13 = Mathf.Lerp(0, 0.5, var_316_12)

					arg_313_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_313_1.var_.characterEffect1085ui_story.fillRatio = var_316_13
				end
			end

			if arg_313_1.time_ >= var_316_10 + var_316_11 and arg_313_1.time_ < var_316_10 + var_316_11 + arg_316_0 and not isNil(var_316_9) and arg_313_1.var_.characterEffect1085ui_story then
				local var_316_14 = 0.5

				arg_313_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_313_1.var_.characterEffect1085ui_story.fillRatio = var_316_14
			end

			local var_316_15 = arg_313_1.actors_["404001ui_story"]
			local var_316_16 = 0

			if var_316_16 < arg_313_1.time_ and arg_313_1.time_ <= var_316_16 + arg_316_0 and not isNil(var_316_15) and arg_313_1.var_.characterEffect404001ui_story == nil then
				arg_313_1.var_.characterEffect404001ui_story = var_316_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_17 = 0.200000002980232

			if var_316_16 <= arg_313_1.time_ and arg_313_1.time_ < var_316_16 + var_316_17 and not isNil(var_316_15) then
				local var_316_18 = (arg_313_1.time_ - var_316_16) / var_316_17

				if arg_313_1.var_.characterEffect404001ui_story and not isNil(var_316_15) then
					arg_313_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_313_1.time_ >= var_316_16 + var_316_17 and arg_313_1.time_ < var_316_16 + var_316_17 + arg_316_0 and not isNil(var_316_15) and arg_313_1.var_.characterEffect404001ui_story then
				arg_313_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_316_19 = 0

			if var_316_19 < arg_313_1.time_ and arg_313_1.time_ <= var_316_19 + arg_316_0 then
				arg_313_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_316_20 = 0

			if var_316_20 < arg_313_1.time_ and arg_313_1.time_ <= var_316_20 + arg_316_0 then
				arg_313_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_316_21 = arg_313_1.actors_["1085ui_story"].transform
			local var_316_22 = 0

			if var_316_22 < arg_313_1.time_ and arg_313_1.time_ <= var_316_22 + arg_316_0 then
				arg_313_1.var_.moveOldPos1085ui_story = var_316_21.localPosition
			end

			local var_316_23 = 0.001

			if var_316_22 <= arg_313_1.time_ and arg_313_1.time_ < var_316_22 + var_316_23 then
				local var_316_24 = (arg_313_1.time_ - var_316_22) / var_316_23
				local var_316_25 = Vector3.New(0, 100, 0)

				var_316_21.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos1085ui_story, var_316_25, var_316_24)

				local var_316_26 = manager.ui.mainCamera.transform.position - var_316_21.position

				var_316_21.forward = Vector3.New(var_316_26.x, var_316_26.y, var_316_26.z)

				local var_316_27 = var_316_21.localEulerAngles

				var_316_27.z = 0
				var_316_27.x = 0
				var_316_21.localEulerAngles = var_316_27
			end

			if arg_313_1.time_ >= var_316_22 + var_316_23 and arg_313_1.time_ < var_316_22 + var_316_23 + arg_316_0 then
				var_316_21.localPosition = Vector3.New(0, 100, 0)

				local var_316_28 = manager.ui.mainCamera.transform.position - var_316_21.position

				var_316_21.forward = Vector3.New(var_316_28.x, var_316_28.y, var_316_28.z)

				local var_316_29 = var_316_21.localEulerAngles

				var_316_29.z = 0
				var_316_29.x = 0
				var_316_21.localEulerAngles = var_316_29
			end

			local var_316_30 = 0
			local var_316_31 = 0.075

			if var_316_30 < arg_313_1.time_ and arg_313_1.time_ <= var_316_30 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				local var_316_32 = arg_313_1:FormatText(StoryNameCfg[668].name)

				arg_313_1.leftNameTxt_.text = var_316_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_33 = arg_313_1:GetWordFromCfg(420012076)
				local var_316_34 = arg_313_1:FormatText(var_316_33.content)

				arg_313_1.text_.text = var_316_34

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_35 = 3
				local var_316_36 = utf8.len(var_316_34)
				local var_316_37 = var_316_35 <= 0 and var_316_31 or var_316_31 * (var_316_36 / var_316_35)

				if var_316_37 > 0 and var_316_31 < var_316_37 then
					arg_313_1.talkMaxDuration = var_316_37

					if var_316_37 + var_316_30 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_37 + var_316_30
					end
				end

				arg_313_1.text_.text = var_316_34
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012076", "story_v_out_420012.awb") ~= 0 then
					local var_316_38 = manager.audio:GetVoiceLength("story_v_out_420012", "420012076", "story_v_out_420012.awb") / 1000

					if var_316_38 + var_316_30 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_38 + var_316_30
					end

					if var_316_33.prefab_name ~= "" and arg_313_1.actors_[var_316_33.prefab_name] ~= nil then
						local var_316_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_33.prefab_name].transform, "story_v_out_420012", "420012076", "story_v_out_420012.awb")

						arg_313_1:RecordAudio("420012076", var_316_39)
						arg_313_1:RecordAudio("420012076", var_316_39)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_420012", "420012076", "story_v_out_420012.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_420012", "420012076", "story_v_out_420012.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_40 = math.max(var_316_31, arg_313_1.talkMaxDuration)

			if var_316_30 <= arg_313_1.time_ and arg_313_1.time_ < var_316_30 + var_316_40 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_30) / var_316_40

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_30 + var_316_40 and arg_313_1.time_ < var_316_30 + var_316_40 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_313_1:InitPlayNodeList()
	end,
	Play420012077 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 420012077
		arg_317_1.duration_ = 7.9

		local var_317_0 = {
			zh = 6.633,
			ja = 7.9
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
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play420012078(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = arg_317_1.actors_["1085ui_story"]
			local var_320_1 = 0

			if var_320_1 < arg_317_1.time_ and arg_317_1.time_ <= var_320_1 + arg_320_0 and not isNil(var_320_0) and arg_317_1.var_.characterEffect1085ui_story == nil then
				arg_317_1.var_.characterEffect1085ui_story = var_320_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_2 = 0.200000002980232

			if var_320_1 <= arg_317_1.time_ and arg_317_1.time_ < var_320_1 + var_320_2 and not isNil(var_320_0) then
				local var_320_3 = (arg_317_1.time_ - var_320_1) / var_320_2

				if arg_317_1.var_.characterEffect1085ui_story and not isNil(var_320_0) then
					arg_317_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_317_1.time_ >= var_320_1 + var_320_2 and arg_317_1.time_ < var_320_1 + var_320_2 + arg_320_0 and not isNil(var_320_0) and arg_317_1.var_.characterEffect1085ui_story then
				arg_317_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_320_4 = arg_317_1.actors_["404001ui_story"]
			local var_320_5 = 0

			if var_320_5 < arg_317_1.time_ and arg_317_1.time_ <= var_320_5 + arg_320_0 and not isNil(var_320_4) and arg_317_1.var_.characterEffect404001ui_story == nil then
				arg_317_1.var_.characterEffect404001ui_story = var_320_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_6 = 0.200000002980232

			if var_320_5 <= arg_317_1.time_ and arg_317_1.time_ < var_320_5 + var_320_6 and not isNil(var_320_4) then
				local var_320_7 = (arg_317_1.time_ - var_320_5) / var_320_6

				if arg_317_1.var_.characterEffect404001ui_story and not isNil(var_320_4) then
					local var_320_8 = Mathf.Lerp(0, 0.5, var_320_7)

					arg_317_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_317_1.var_.characterEffect404001ui_story.fillRatio = var_320_8
				end
			end

			if arg_317_1.time_ >= var_320_5 + var_320_6 and arg_317_1.time_ < var_320_5 + var_320_6 + arg_320_0 and not isNil(var_320_4) and arg_317_1.var_.characterEffect404001ui_story then
				local var_320_9 = 0.5

				arg_317_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_317_1.var_.characterEffect404001ui_story.fillRatio = var_320_9
			end

			local var_320_10 = arg_317_1.actors_["404001ui_story"].transform
			local var_320_11 = 0

			if var_320_11 < arg_317_1.time_ and arg_317_1.time_ <= var_320_11 + arg_320_0 then
				arg_317_1.var_.moveOldPos404001ui_story = var_320_10.localPosition
			end

			local var_320_12 = 0.001

			if var_320_11 <= arg_317_1.time_ and arg_317_1.time_ < var_320_11 + var_320_12 then
				local var_320_13 = (arg_317_1.time_ - var_320_11) / var_320_12
				local var_320_14 = Vector3.New(-0.8, -1.55, -5.5)

				var_320_10.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos404001ui_story, var_320_14, var_320_13)

				local var_320_15 = manager.ui.mainCamera.transform.position - var_320_10.position

				var_320_10.forward = Vector3.New(var_320_15.x, var_320_15.y, var_320_15.z)

				local var_320_16 = var_320_10.localEulerAngles

				var_320_16.z = 0
				var_320_16.x = 0
				var_320_10.localEulerAngles = var_320_16
			end

			if arg_317_1.time_ >= var_320_11 + var_320_12 and arg_317_1.time_ < var_320_11 + var_320_12 + arg_320_0 then
				var_320_10.localPosition = Vector3.New(-0.8, -1.55, -5.5)

				local var_320_17 = manager.ui.mainCamera.transform.position - var_320_10.position

				var_320_10.forward = Vector3.New(var_320_17.x, var_320_17.y, var_320_17.z)

				local var_320_18 = var_320_10.localEulerAngles

				var_320_18.z = 0
				var_320_18.x = 0
				var_320_10.localEulerAngles = var_320_18
			end

			local var_320_19 = arg_317_1.actors_["1085ui_story"].transform
			local var_320_20 = 0

			if var_320_20 < arg_317_1.time_ and arg_317_1.time_ <= var_320_20 + arg_320_0 then
				arg_317_1.var_.moveOldPos1085ui_story = var_320_19.localPosition
			end

			local var_320_21 = 0.001

			if var_320_20 <= arg_317_1.time_ and arg_317_1.time_ < var_320_20 + var_320_21 then
				local var_320_22 = (arg_317_1.time_ - var_320_20) / var_320_21
				local var_320_23 = Vector3.New(0.75, -1.01, -5.83)

				var_320_19.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos1085ui_story, var_320_23, var_320_22)

				local var_320_24 = manager.ui.mainCamera.transform.position - var_320_19.position

				var_320_19.forward = Vector3.New(var_320_24.x, var_320_24.y, var_320_24.z)

				local var_320_25 = var_320_19.localEulerAngles

				var_320_25.z = 0
				var_320_25.x = 0
				var_320_19.localEulerAngles = var_320_25
			end

			if arg_317_1.time_ >= var_320_20 + var_320_21 and arg_317_1.time_ < var_320_20 + var_320_21 + arg_320_0 then
				var_320_19.localPosition = Vector3.New(0.75, -1.01, -5.83)

				local var_320_26 = manager.ui.mainCamera.transform.position - var_320_19.position

				var_320_19.forward = Vector3.New(var_320_26.x, var_320_26.y, var_320_26.z)

				local var_320_27 = var_320_19.localEulerAngles

				var_320_27.z = 0
				var_320_27.x = 0
				var_320_19.localEulerAngles = var_320_27
			end

			local var_320_28 = 0

			if var_320_28 < arg_317_1.time_ and arg_317_1.time_ <= var_320_28 + arg_320_0 then
				arg_317_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085actionlink/1085action423")
			end

			local var_320_29 = 0

			if var_320_29 < arg_317_1.time_ and arg_317_1.time_ <= var_320_29 + arg_320_0 then
				arg_317_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_320_30 = 0
			local var_320_31 = 0.725

			if var_320_30 < arg_317_1.time_ and arg_317_1.time_ <= var_320_30 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				local var_320_32 = arg_317_1:FormatText(StoryNameCfg[328].name)

				arg_317_1.leftNameTxt_.text = var_320_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_33 = arg_317_1:GetWordFromCfg(420012077)
				local var_320_34 = arg_317_1:FormatText(var_320_33.content)

				arg_317_1.text_.text = var_320_34

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_35 = 29
				local var_320_36 = utf8.len(var_320_34)
				local var_320_37 = var_320_35 <= 0 and var_320_31 or var_320_31 * (var_320_36 / var_320_35)

				if var_320_37 > 0 and var_320_31 < var_320_37 then
					arg_317_1.talkMaxDuration = var_320_37

					if var_320_37 + var_320_30 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_37 + var_320_30
					end
				end

				arg_317_1.text_.text = var_320_34
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012077", "story_v_out_420012.awb") ~= 0 then
					local var_320_38 = manager.audio:GetVoiceLength("story_v_out_420012", "420012077", "story_v_out_420012.awb") / 1000

					if var_320_38 + var_320_30 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_38 + var_320_30
					end

					if var_320_33.prefab_name ~= "" and arg_317_1.actors_[var_320_33.prefab_name] ~= nil then
						local var_320_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_33.prefab_name].transform, "story_v_out_420012", "420012077", "story_v_out_420012.awb")

						arg_317_1:RecordAudio("420012077", var_320_39)
						arg_317_1:RecordAudio("420012077", var_320_39)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_420012", "420012077", "story_v_out_420012.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_420012", "420012077", "story_v_out_420012.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_40 = math.max(var_320_31, arg_317_1.talkMaxDuration)

			if var_320_30 <= arg_317_1.time_ and arg_317_1.time_ < var_320_30 + var_320_40 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_30) / var_320_40

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_30 + var_320_40 and arg_317_1.time_ < var_320_30 + var_320_40 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
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
	Play420012078 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 420012078
		arg_321_1.duration_ = 5.2

		local var_321_0 = {
			zh = 4.433,
			ja = 5.2
		}
		local var_321_1 = manager.audio:GetLocalizationFlag()

		if var_321_0[var_321_1] ~= nil then
			arg_321_1.duration_ = var_321_0[var_321_1]
		end

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play420012079(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = arg_321_1.actors_["1085ui_story"]
			local var_324_1 = 0

			if var_324_1 < arg_321_1.time_ and arg_321_1.time_ <= var_324_1 + arg_324_0 and not isNil(var_324_0) and arg_321_1.var_.characterEffect1085ui_story == nil then
				arg_321_1.var_.characterEffect1085ui_story = var_324_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_2 = 0.200000002980232

			if var_324_1 <= arg_321_1.time_ and arg_321_1.time_ < var_324_1 + var_324_2 and not isNil(var_324_0) then
				local var_324_3 = (arg_321_1.time_ - var_324_1) / var_324_2

				if arg_321_1.var_.characterEffect1085ui_story and not isNil(var_324_0) then
					local var_324_4 = Mathf.Lerp(0, 0.5, var_324_3)

					arg_321_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_321_1.var_.characterEffect1085ui_story.fillRatio = var_324_4
				end
			end

			if arg_321_1.time_ >= var_324_1 + var_324_2 and arg_321_1.time_ < var_324_1 + var_324_2 + arg_324_0 and not isNil(var_324_0) and arg_321_1.var_.characterEffect1085ui_story then
				local var_324_5 = 0.5

				arg_321_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_321_1.var_.characterEffect1085ui_story.fillRatio = var_324_5
			end

			local var_324_6 = arg_321_1.actors_["404001ui_story"]
			local var_324_7 = 0

			if var_324_7 < arg_321_1.time_ and arg_321_1.time_ <= var_324_7 + arg_324_0 and not isNil(var_324_6) and arg_321_1.var_.characterEffect404001ui_story == nil then
				arg_321_1.var_.characterEffect404001ui_story = var_324_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_8 = 0.200000002980232

			if var_324_7 <= arg_321_1.time_ and arg_321_1.time_ < var_324_7 + var_324_8 and not isNil(var_324_6) then
				local var_324_9 = (arg_321_1.time_ - var_324_7) / var_324_8

				if arg_321_1.var_.characterEffect404001ui_story and not isNil(var_324_6) then
					arg_321_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_321_1.time_ >= var_324_7 + var_324_8 and arg_321_1.time_ < var_324_7 + var_324_8 + arg_324_0 and not isNil(var_324_6) and arg_321_1.var_.characterEffect404001ui_story then
				arg_321_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_324_10 = 0
			local var_324_11 = 0.55

			if var_324_10 < arg_321_1.time_ and arg_321_1.time_ <= var_324_10 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				local var_324_12 = arg_321_1:FormatText(StoryNameCfg[668].name)

				arg_321_1.leftNameTxt_.text = var_324_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_13 = arg_321_1:GetWordFromCfg(420012078)
				local var_324_14 = arg_321_1:FormatText(var_324_13.content)

				arg_321_1.text_.text = var_324_14

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_15 = 22
				local var_324_16 = utf8.len(var_324_14)
				local var_324_17 = var_324_15 <= 0 and var_324_11 or var_324_11 * (var_324_16 / var_324_15)

				if var_324_17 > 0 and var_324_11 < var_324_17 then
					arg_321_1.talkMaxDuration = var_324_17

					if var_324_17 + var_324_10 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_17 + var_324_10
					end
				end

				arg_321_1.text_.text = var_324_14
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012078", "story_v_out_420012.awb") ~= 0 then
					local var_324_18 = manager.audio:GetVoiceLength("story_v_out_420012", "420012078", "story_v_out_420012.awb") / 1000

					if var_324_18 + var_324_10 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_18 + var_324_10
					end

					if var_324_13.prefab_name ~= "" and arg_321_1.actors_[var_324_13.prefab_name] ~= nil then
						local var_324_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_13.prefab_name].transform, "story_v_out_420012", "420012078", "story_v_out_420012.awb")

						arg_321_1:RecordAudio("420012078", var_324_19)
						arg_321_1:RecordAudio("420012078", var_324_19)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_420012", "420012078", "story_v_out_420012.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_420012", "420012078", "story_v_out_420012.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_20 = math.max(var_324_11, arg_321_1.talkMaxDuration)

			if var_324_10 <= arg_321_1.time_ and arg_321_1.time_ < var_324_10 + var_324_20 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_10) / var_324_20

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_10 + var_324_20 and arg_321_1.time_ < var_324_10 + var_324_20 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play420012079 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 420012079
		arg_325_1.duration_ = 2.9

		local var_325_0 = {
			zh = 1.999999999999,
			ja = 2.9
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
				arg_325_0:Play420012080(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = 0

			if var_328_0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_0 + arg_328_0 then
				arg_325_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_1")
			end

			local var_328_1 = 0
			local var_328_2 = 0.125

			if var_328_1 < arg_325_1.time_ and arg_325_1.time_ <= var_328_1 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				local var_328_3 = arg_325_1:FormatText(StoryNameCfg[668].name)

				arg_325_1.leftNameTxt_.text = var_328_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_4 = arg_325_1:GetWordFromCfg(420012079)
				local var_328_5 = arg_325_1:FormatText(var_328_4.content)

				arg_325_1.text_.text = var_328_5

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_6 = 5
				local var_328_7 = utf8.len(var_328_5)
				local var_328_8 = var_328_6 <= 0 and var_328_2 or var_328_2 * (var_328_7 / var_328_6)

				if var_328_8 > 0 and var_328_2 < var_328_8 then
					arg_325_1.talkMaxDuration = var_328_8

					if var_328_8 + var_328_1 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_8 + var_328_1
					end
				end

				arg_325_1.text_.text = var_328_5
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012079", "story_v_out_420012.awb") ~= 0 then
					local var_328_9 = manager.audio:GetVoiceLength("story_v_out_420012", "420012079", "story_v_out_420012.awb") / 1000

					if var_328_9 + var_328_1 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_9 + var_328_1
					end

					if var_328_4.prefab_name ~= "" and arg_325_1.actors_[var_328_4.prefab_name] ~= nil then
						local var_328_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_4.prefab_name].transform, "story_v_out_420012", "420012079", "story_v_out_420012.awb")

						arg_325_1:RecordAudio("420012079", var_328_10)
						arg_325_1:RecordAudio("420012079", var_328_10)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_420012", "420012079", "story_v_out_420012.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_420012", "420012079", "story_v_out_420012.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_11 = math.max(var_328_2, arg_325_1.talkMaxDuration)

			if var_328_1 <= arg_325_1.time_ and arg_325_1.time_ < var_328_1 + var_328_11 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_1) / var_328_11

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_1 + var_328_11 and arg_325_1.time_ < var_328_1 + var_328_11 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play420012080 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 420012080
		arg_329_1.duration_ = 6.63

		local var_329_0 = {
			zh = 6.633,
			ja = 6.3
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
				arg_329_0:Play420012081(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = arg_329_1.actors_["1085ui_story"]
			local var_332_1 = 0

			if var_332_1 < arg_329_1.time_ and arg_329_1.time_ <= var_332_1 + arg_332_0 and not isNil(var_332_0) and arg_329_1.var_.characterEffect1085ui_story == nil then
				arg_329_1.var_.characterEffect1085ui_story = var_332_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_2 = 0.200000002980232

			if var_332_1 <= arg_329_1.time_ and arg_329_1.time_ < var_332_1 + var_332_2 and not isNil(var_332_0) then
				local var_332_3 = (arg_329_1.time_ - var_332_1) / var_332_2

				if arg_329_1.var_.characterEffect1085ui_story and not isNil(var_332_0) then
					arg_329_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_329_1.time_ >= var_332_1 + var_332_2 and arg_329_1.time_ < var_332_1 + var_332_2 + arg_332_0 and not isNil(var_332_0) and arg_329_1.var_.characterEffect1085ui_story then
				arg_329_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_332_4 = arg_329_1.actors_["404001ui_story"]
			local var_332_5 = 0

			if var_332_5 < arg_329_1.time_ and arg_329_1.time_ <= var_332_5 + arg_332_0 and not isNil(var_332_4) and arg_329_1.var_.characterEffect404001ui_story == nil then
				arg_329_1.var_.characterEffect404001ui_story = var_332_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_6 = 0.200000002980232

			if var_332_5 <= arg_329_1.time_ and arg_329_1.time_ < var_332_5 + var_332_6 and not isNil(var_332_4) then
				local var_332_7 = (arg_329_1.time_ - var_332_5) / var_332_6

				if arg_329_1.var_.characterEffect404001ui_story and not isNil(var_332_4) then
					local var_332_8 = Mathf.Lerp(0, 0.5, var_332_7)

					arg_329_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_329_1.var_.characterEffect404001ui_story.fillRatio = var_332_8
				end
			end

			if arg_329_1.time_ >= var_332_5 + var_332_6 and arg_329_1.time_ < var_332_5 + var_332_6 + arg_332_0 and not isNil(var_332_4) and arg_329_1.var_.characterEffect404001ui_story then
				local var_332_9 = 0.5

				arg_329_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_329_1.var_.characterEffect404001ui_story.fillRatio = var_332_9
			end

			local var_332_10 = 0

			if var_332_10 < arg_329_1.time_ and arg_329_1.time_ <= var_332_10 + arg_332_0 then
				arg_329_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_2")
			end

			local var_332_11 = 0

			if var_332_11 < arg_329_1.time_ and arg_329_1.time_ <= var_332_11 + arg_332_0 then
				arg_329_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_332_12 = 0
			local var_332_13 = 0.475

			if var_332_12 < arg_329_1.time_ and arg_329_1.time_ <= var_332_12 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				local var_332_14 = arg_329_1:FormatText(StoryNameCfg[328].name)

				arg_329_1.leftNameTxt_.text = var_332_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_15 = arg_329_1:GetWordFromCfg(420012080)
				local var_332_16 = arg_329_1:FormatText(var_332_15.content)

				arg_329_1.text_.text = var_332_16

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_17 = 19
				local var_332_18 = utf8.len(var_332_16)
				local var_332_19 = var_332_17 <= 0 and var_332_13 or var_332_13 * (var_332_18 / var_332_17)

				if var_332_19 > 0 and var_332_13 < var_332_19 then
					arg_329_1.talkMaxDuration = var_332_19

					if var_332_19 + var_332_12 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_19 + var_332_12
					end
				end

				arg_329_1.text_.text = var_332_16
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012080", "story_v_out_420012.awb") ~= 0 then
					local var_332_20 = manager.audio:GetVoiceLength("story_v_out_420012", "420012080", "story_v_out_420012.awb") / 1000

					if var_332_20 + var_332_12 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_20 + var_332_12
					end

					if var_332_15.prefab_name ~= "" and arg_329_1.actors_[var_332_15.prefab_name] ~= nil then
						local var_332_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_15.prefab_name].transform, "story_v_out_420012", "420012080", "story_v_out_420012.awb")

						arg_329_1:RecordAudio("420012080", var_332_21)
						arg_329_1:RecordAudio("420012080", var_332_21)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_out_420012", "420012080", "story_v_out_420012.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_out_420012", "420012080", "story_v_out_420012.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_22 = math.max(var_332_13, arg_329_1.talkMaxDuration)

			if var_332_12 <= arg_329_1.time_ and arg_329_1.time_ < var_332_12 + var_332_22 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_12) / var_332_22

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_12 + var_332_22 and arg_329_1.time_ < var_332_12 + var_332_22 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play420012081 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 420012081
		arg_333_1.duration_ = 5

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play420012082(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = arg_333_1.actors_["404001ui_story"].transform
			local var_336_1 = 0

			if var_336_1 < arg_333_1.time_ and arg_333_1.time_ <= var_336_1 + arg_336_0 then
				arg_333_1.var_.moveOldPos404001ui_story = var_336_0.localPosition
			end

			local var_336_2 = 0.001

			if var_336_1 <= arg_333_1.time_ and arg_333_1.time_ < var_336_1 + var_336_2 then
				local var_336_3 = (arg_333_1.time_ - var_336_1) / var_336_2
				local var_336_4 = Vector3.New(0, 100, 0)

				var_336_0.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos404001ui_story, var_336_4, var_336_3)

				local var_336_5 = manager.ui.mainCamera.transform.position - var_336_0.position

				var_336_0.forward = Vector3.New(var_336_5.x, var_336_5.y, var_336_5.z)

				local var_336_6 = var_336_0.localEulerAngles

				var_336_6.z = 0
				var_336_6.x = 0
				var_336_0.localEulerAngles = var_336_6
			end

			if arg_333_1.time_ >= var_336_1 + var_336_2 and arg_333_1.time_ < var_336_1 + var_336_2 + arg_336_0 then
				var_336_0.localPosition = Vector3.New(0, 100, 0)

				local var_336_7 = manager.ui.mainCamera.transform.position - var_336_0.position

				var_336_0.forward = Vector3.New(var_336_7.x, var_336_7.y, var_336_7.z)

				local var_336_8 = var_336_0.localEulerAngles

				var_336_8.z = 0
				var_336_8.x = 0
				var_336_0.localEulerAngles = var_336_8
			end

			local var_336_9 = arg_333_1.actors_["1085ui_story"].transform
			local var_336_10 = 0

			if var_336_10 < arg_333_1.time_ and arg_333_1.time_ <= var_336_10 + arg_336_0 then
				arg_333_1.var_.moveOldPos1085ui_story = var_336_9.localPosition
			end

			local var_336_11 = 0.001

			if var_336_10 <= arg_333_1.time_ and arg_333_1.time_ < var_336_10 + var_336_11 then
				local var_336_12 = (arg_333_1.time_ - var_336_10) / var_336_11
				local var_336_13 = Vector3.New(0, 100, 0)

				var_336_9.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos1085ui_story, var_336_13, var_336_12)

				local var_336_14 = manager.ui.mainCamera.transform.position - var_336_9.position

				var_336_9.forward = Vector3.New(var_336_14.x, var_336_14.y, var_336_14.z)

				local var_336_15 = var_336_9.localEulerAngles

				var_336_15.z = 0
				var_336_15.x = 0
				var_336_9.localEulerAngles = var_336_15
			end

			if arg_333_1.time_ >= var_336_10 + var_336_11 and arg_333_1.time_ < var_336_10 + var_336_11 + arg_336_0 then
				var_336_9.localPosition = Vector3.New(0, 100, 0)

				local var_336_16 = manager.ui.mainCamera.transform.position - var_336_9.position

				var_336_9.forward = Vector3.New(var_336_16.x, var_336_16.y, var_336_16.z)

				local var_336_17 = var_336_9.localEulerAngles

				var_336_17.z = 0
				var_336_17.x = 0
				var_336_9.localEulerAngles = var_336_17
			end

			local var_336_18 = 0.05
			local var_336_19 = 1

			if var_336_18 < arg_333_1.time_ and arg_333_1.time_ <= var_336_18 + arg_336_0 then
				local var_336_20 = "play"
				local var_336_21 = "effect"

				arg_333_1:AudioAction(var_336_20, var_336_21, "se_story_1311", "se_story_1311_car01", "")
			end

			local var_336_22 = 0
			local var_336_23 = 1.175

			if var_336_22 < arg_333_1.time_ and arg_333_1.time_ <= var_336_22 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, false)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_24 = arg_333_1:GetWordFromCfg(420012081)
				local var_336_25 = arg_333_1:FormatText(var_336_24.content)

				arg_333_1.text_.text = var_336_25

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_26 = 47
				local var_336_27 = utf8.len(var_336_25)
				local var_336_28 = var_336_26 <= 0 and var_336_23 or var_336_23 * (var_336_27 / var_336_26)

				if var_336_28 > 0 and var_336_23 < var_336_28 then
					arg_333_1.talkMaxDuration = var_336_28

					if var_336_28 + var_336_22 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_28 + var_336_22
					end
				end

				arg_333_1.text_.text = var_336_25
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)
				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_29 = math.max(var_336_23, arg_333_1.talkMaxDuration)

			if var_336_22 <= arg_333_1.time_ and arg_333_1.time_ < var_336_22 + var_336_29 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_22) / var_336_29

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_22 + var_336_29 and arg_333_1.time_ < var_336_22 + var_336_29 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_333_1:InitPlayNodeList()
	end,
	Play420012082 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 420012082
		arg_337_1.duration_ = 6.07

		local var_337_0 = {
			zh = 5.566,
			ja = 6.066
		}
		local var_337_1 = manager.audio:GetLocalizationFlag()

		if var_337_0[var_337_1] ~= nil then
			arg_337_1.duration_ = var_337_0[var_337_1]
		end

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play420012083(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = arg_337_1.actors_["404001ui_story"].transform
			local var_340_1 = 0

			if var_340_1 < arg_337_1.time_ and arg_337_1.time_ <= var_340_1 + arg_340_0 then
				arg_337_1.var_.moveOldPos404001ui_story = var_340_0.localPosition
			end

			local var_340_2 = 0.001

			if var_340_1 <= arg_337_1.time_ and arg_337_1.time_ < var_340_1 + var_340_2 then
				local var_340_3 = (arg_337_1.time_ - var_340_1) / var_340_2
				local var_340_4 = Vector3.New(0, -1.55, -5.5)

				var_340_0.localPosition = Vector3.Lerp(arg_337_1.var_.moveOldPos404001ui_story, var_340_4, var_340_3)

				local var_340_5 = manager.ui.mainCamera.transform.position - var_340_0.position

				var_340_0.forward = Vector3.New(var_340_5.x, var_340_5.y, var_340_5.z)

				local var_340_6 = var_340_0.localEulerAngles

				var_340_6.z = 0
				var_340_6.x = 0
				var_340_0.localEulerAngles = var_340_6
			end

			if arg_337_1.time_ >= var_340_1 + var_340_2 and arg_337_1.time_ < var_340_1 + var_340_2 + arg_340_0 then
				var_340_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_340_7 = manager.ui.mainCamera.transform.position - var_340_0.position

				var_340_0.forward = Vector3.New(var_340_7.x, var_340_7.y, var_340_7.z)

				local var_340_8 = var_340_0.localEulerAngles

				var_340_8.z = 0
				var_340_8.x = 0
				var_340_0.localEulerAngles = var_340_8
			end

			local var_340_9 = arg_337_1.actors_["404001ui_story"]
			local var_340_10 = 0

			if var_340_10 < arg_337_1.time_ and arg_337_1.time_ <= var_340_10 + arg_340_0 and not isNil(var_340_9) and arg_337_1.var_.characterEffect404001ui_story == nil then
				arg_337_1.var_.characterEffect404001ui_story = var_340_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_11 = 0.200000002980232

			if var_340_10 <= arg_337_1.time_ and arg_337_1.time_ < var_340_10 + var_340_11 and not isNil(var_340_9) then
				local var_340_12 = (arg_337_1.time_ - var_340_10) / var_340_11

				if arg_337_1.var_.characterEffect404001ui_story and not isNil(var_340_9) then
					arg_337_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_337_1.time_ >= var_340_10 + var_340_11 and arg_337_1.time_ < var_340_10 + var_340_11 + arg_340_0 and not isNil(var_340_9) and arg_337_1.var_.characterEffect404001ui_story then
				arg_337_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_340_13 = 0

			if var_340_13 < arg_337_1.time_ and arg_337_1.time_ <= var_340_13 + arg_340_0 then
				arg_337_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_340_14 = 0

			if var_340_14 < arg_337_1.time_ and arg_337_1.time_ <= var_340_14 + arg_340_0 then
				arg_337_1.allBtn_.enabled = false
			end

			local var_340_15 = 1

			if arg_337_1.time_ >= var_340_14 + var_340_15 and arg_337_1.time_ < var_340_14 + var_340_15 + arg_340_0 then
				arg_337_1.allBtn_.enabled = true
			end

			local var_340_16 = 0

			if var_340_16 < arg_337_1.time_ and arg_337_1.time_ <= var_340_16 + arg_340_0 then
				arg_337_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_340_17 = 0
			local var_340_18 = 0.65

			if var_340_17 < arg_337_1.time_ and arg_337_1.time_ <= var_340_17 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				local var_340_19 = arg_337_1:FormatText(StoryNameCfg[668].name)

				arg_337_1.leftNameTxt_.text = var_340_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_20 = arg_337_1:GetWordFromCfg(420012082)
				local var_340_21 = arg_337_1:FormatText(var_340_20.content)

				arg_337_1.text_.text = var_340_21

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_22 = 26
				local var_340_23 = utf8.len(var_340_21)
				local var_340_24 = var_340_22 <= 0 and var_340_18 or var_340_18 * (var_340_23 / var_340_22)

				if var_340_24 > 0 and var_340_18 < var_340_24 then
					arg_337_1.talkMaxDuration = var_340_24

					if var_340_24 + var_340_17 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_24 + var_340_17
					end
				end

				arg_337_1.text_.text = var_340_21
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012082", "story_v_out_420012.awb") ~= 0 then
					local var_340_25 = manager.audio:GetVoiceLength("story_v_out_420012", "420012082", "story_v_out_420012.awb") / 1000

					if var_340_25 + var_340_17 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_25 + var_340_17
					end

					if var_340_20.prefab_name ~= "" and arg_337_1.actors_[var_340_20.prefab_name] ~= nil then
						local var_340_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_20.prefab_name].transform, "story_v_out_420012", "420012082", "story_v_out_420012.awb")

						arg_337_1:RecordAudio("420012082", var_340_26)
						arg_337_1:RecordAudio("420012082", var_340_26)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_out_420012", "420012082", "story_v_out_420012.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_out_420012", "420012082", "story_v_out_420012.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_27 = math.max(var_340_18, arg_337_1.talkMaxDuration)

			if var_340_17 <= arg_337_1.time_ and arg_337_1.time_ < var_340_17 + var_340_27 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_17) / var_340_27

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_17 + var_340_27 and arg_337_1.time_ < var_340_17 + var_340_27 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_337_1:InitPlayNodeList()
	end,
	Play420012083 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 420012083
		arg_341_1.duration_ = 5.23

		local var_341_0 = {
			zh = 4.533,
			ja = 5.233
		}
		local var_341_1 = manager.audio:GetLocalizationFlag()

		if var_341_0[var_341_1] ~= nil then
			arg_341_1.duration_ = var_341_0[var_341_1]
		end

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play420012084(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = 0
			local var_344_1 = 0.55

			if var_344_0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_0 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				local var_344_2 = arg_341_1:FormatText(StoryNameCfg[668].name)

				arg_341_1.leftNameTxt_.text = var_344_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_3 = arg_341_1:GetWordFromCfg(420012083)
				local var_344_4 = arg_341_1:FormatText(var_344_3.content)

				arg_341_1.text_.text = var_344_4

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_5 = 22
				local var_344_6 = utf8.len(var_344_4)
				local var_344_7 = var_344_5 <= 0 and var_344_1 or var_344_1 * (var_344_6 / var_344_5)

				if var_344_7 > 0 and var_344_1 < var_344_7 then
					arg_341_1.talkMaxDuration = var_344_7

					if var_344_7 + var_344_0 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_7 + var_344_0
					end
				end

				arg_341_1.text_.text = var_344_4
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012083", "story_v_out_420012.awb") ~= 0 then
					local var_344_8 = manager.audio:GetVoiceLength("story_v_out_420012", "420012083", "story_v_out_420012.awb") / 1000

					if var_344_8 + var_344_0 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_8 + var_344_0
					end

					if var_344_3.prefab_name ~= "" and arg_341_1.actors_[var_344_3.prefab_name] ~= nil then
						local var_344_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_3.prefab_name].transform, "story_v_out_420012", "420012083", "story_v_out_420012.awb")

						arg_341_1:RecordAudio("420012083", var_344_9)
						arg_341_1:RecordAudio("420012083", var_344_9)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_420012", "420012083", "story_v_out_420012.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_420012", "420012083", "story_v_out_420012.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_10 = math.max(var_344_1, arg_341_1.talkMaxDuration)

			if var_344_0 <= arg_341_1.time_ and arg_341_1.time_ < var_344_0 + var_344_10 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_0) / var_344_10

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_0 + var_344_10 and arg_341_1.time_ < var_344_0 + var_344_10 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play420012084 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 420012084
		arg_345_1.duration_ = 9

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play420012085(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = "ST0503"

			if arg_345_1.bgs_[var_348_0] == nil then
				local var_348_1 = Object.Instantiate(arg_345_1.paintGo_)

				var_348_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_348_0)
				var_348_1.name = var_348_0
				var_348_1.transform.parent = arg_345_1.stage_.transform
				var_348_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_345_1.bgs_[var_348_0] = var_348_1
			end

			local var_348_2 = 2

			if var_348_2 < arg_345_1.time_ and arg_345_1.time_ <= var_348_2 + arg_348_0 then
				local var_348_3 = manager.ui.mainCamera.transform.localPosition
				local var_348_4 = Vector3.New(0, 0, 10) + Vector3.New(var_348_3.x, var_348_3.y, 0)
				local var_348_5 = arg_345_1.bgs_.ST0503

				var_348_5.transform.localPosition = var_348_4
				var_348_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_348_6 = var_348_5:GetComponent("SpriteRenderer")

				if var_348_6 and var_348_6.sprite then
					local var_348_7 = (var_348_5.transform.localPosition - var_348_3).z
					local var_348_8 = manager.ui.mainCameraCom_
					local var_348_9 = 2 * var_348_7 * Mathf.Tan(var_348_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_348_10 = var_348_9 * var_348_8.aspect
					local var_348_11 = var_348_6.sprite.bounds.size.x
					local var_348_12 = var_348_6.sprite.bounds.size.y
					local var_348_13 = var_348_10 / var_348_11
					local var_348_14 = var_348_9 / var_348_12
					local var_348_15 = var_348_14 < var_348_13 and var_348_13 or var_348_14

					var_348_5.transform.localScale = Vector3.New(var_348_15, var_348_15, 0)
				end

				for iter_348_0, iter_348_1 in pairs(arg_345_1.bgs_) do
					if iter_348_0 ~= "ST0503" then
						iter_348_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_348_16 = 4

			if var_348_16 < arg_345_1.time_ and arg_345_1.time_ <= var_348_16 + arg_348_0 then
				arg_345_1.allBtn_.enabled = false
			end

			local var_348_17 = 0.5

			if arg_345_1.time_ >= var_348_16 + var_348_17 and arg_345_1.time_ < var_348_16 + var_348_17 + arg_348_0 then
				arg_345_1.allBtn_.enabled = true
			end

			local var_348_18 = 0

			if var_348_18 < arg_345_1.time_ and arg_345_1.time_ <= var_348_18 + arg_348_0 then
				arg_345_1.mask_.enabled = true
				arg_345_1.mask_.raycastTarget = true

				arg_345_1:SetGaussion(false)
			end

			local var_348_19 = 2

			if var_348_18 <= arg_345_1.time_ and arg_345_1.time_ < var_348_18 + var_348_19 then
				local var_348_20 = (arg_345_1.time_ - var_348_18) / var_348_19
				local var_348_21 = Color.New(0, 0, 0)

				var_348_21.a = Mathf.Lerp(0, 1, var_348_20)
				arg_345_1.mask_.color = var_348_21
			end

			if arg_345_1.time_ >= var_348_18 + var_348_19 and arg_345_1.time_ < var_348_18 + var_348_19 + arg_348_0 then
				local var_348_22 = Color.New(0, 0, 0)

				var_348_22.a = 1
				arg_345_1.mask_.color = var_348_22
			end

			local var_348_23 = 2

			if var_348_23 < arg_345_1.time_ and arg_345_1.time_ <= var_348_23 + arg_348_0 then
				arg_345_1.mask_.enabled = true
				arg_345_1.mask_.raycastTarget = true

				arg_345_1:SetGaussion(false)
			end

			local var_348_24 = 2

			if var_348_23 <= arg_345_1.time_ and arg_345_1.time_ < var_348_23 + var_348_24 then
				local var_348_25 = (arg_345_1.time_ - var_348_23) / var_348_24
				local var_348_26 = Color.New(0, 0, 0)

				var_348_26.a = Mathf.Lerp(1, 0, var_348_25)
				arg_345_1.mask_.color = var_348_26
			end

			if arg_345_1.time_ >= var_348_23 + var_348_24 and arg_345_1.time_ < var_348_23 + var_348_24 + arg_348_0 then
				local var_348_27 = Color.New(0, 0, 0)
				local var_348_28 = 0

				arg_345_1.mask_.enabled = false
				var_348_27.a = var_348_28
				arg_345_1.mask_.color = var_348_27
			end

			local var_348_29 = arg_345_1.actors_["404001ui_story"].transform
			local var_348_30 = 2

			if var_348_30 < arg_345_1.time_ and arg_345_1.time_ <= var_348_30 + arg_348_0 then
				arg_345_1.var_.moveOldPos404001ui_story = var_348_29.localPosition
			end

			local var_348_31 = 0.001

			if var_348_30 <= arg_345_1.time_ and arg_345_1.time_ < var_348_30 + var_348_31 then
				local var_348_32 = (arg_345_1.time_ - var_348_30) / var_348_31
				local var_348_33 = Vector3.New(0, 100, 0)

				var_348_29.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos404001ui_story, var_348_33, var_348_32)

				local var_348_34 = manager.ui.mainCamera.transform.position - var_348_29.position

				var_348_29.forward = Vector3.New(var_348_34.x, var_348_34.y, var_348_34.z)

				local var_348_35 = var_348_29.localEulerAngles

				var_348_35.z = 0
				var_348_35.x = 0
				var_348_29.localEulerAngles = var_348_35
			end

			if arg_345_1.time_ >= var_348_30 + var_348_31 and arg_345_1.time_ < var_348_30 + var_348_31 + arg_348_0 then
				var_348_29.localPosition = Vector3.New(0, 100, 0)

				local var_348_36 = manager.ui.mainCamera.transform.position - var_348_29.position

				var_348_29.forward = Vector3.New(var_348_36.x, var_348_36.y, var_348_36.z)

				local var_348_37 = var_348_29.localEulerAngles

				var_348_37.z = 0
				var_348_37.x = 0
				var_348_29.localEulerAngles = var_348_37
			end

			local var_348_38 = 1.6
			local var_348_39 = 1

			if var_348_38 < arg_345_1.time_ and arg_345_1.time_ <= var_348_38 + arg_348_0 then
				local var_348_40 = "play"
				local var_348_41 = "effect"

				arg_345_1:AudioAction(var_348_40, var_348_41, "se_story_140", "se_story_140_amb_street01", "")
			end

			local var_348_42 = 1.6
			local var_348_43 = 1

			if var_348_42 < arg_345_1.time_ and arg_345_1.time_ <= var_348_42 + arg_348_0 then
				local var_348_44 = "stop"
				local var_348_45 = "effect"

				arg_345_1:AudioAction(var_348_44, var_348_45, "se_story_140", "se_story_140_amb_street02", "")
			end

			local var_348_46 = 4.6
			local var_348_47 = 1

			if var_348_46 < arg_345_1.time_ and arg_345_1.time_ <= var_348_46 + arg_348_0 then
				local var_348_48 = "play"
				local var_348_49 = "effect"

				arg_345_1:AudioAction(var_348_48, var_348_49, "se_story_1310", "se_story_1310_footstep02", "")
			end

			if arg_345_1.frameCnt_ <= 1 then
				arg_345_1.dialog_:SetActive(false)
			end

			local var_348_50 = 4
			local var_348_51 = 0.925

			if var_348_50 < arg_345_1.time_ and arg_345_1.time_ <= var_348_50 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0

				arg_345_1.dialog_:SetActive(true)

				arg_345_1.dialogCg_.alpha = 0

				local var_348_52 = LeanTween.value(arg_345_1.dialog_, 0, 1, 0.3)

				var_348_52:setOnUpdate(LuaHelper.FloatAction(function(arg_349_0)
					arg_345_1.dialogCg_.alpha = arg_349_0
				end))
				var_348_52:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_345_1.dialog_)
					var_348_52:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_345_1.duration_ = arg_345_1.duration_ + 0.3

				SetActive(arg_345_1.leftNameGo_, false)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_53 = arg_345_1:GetWordFromCfg(420012084)
				local var_348_54 = arg_345_1:FormatText(var_348_53.content)

				arg_345_1.text_.text = var_348_54

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_55 = 37
				local var_348_56 = utf8.len(var_348_54)
				local var_348_57 = var_348_55 <= 0 and var_348_51 or var_348_51 * (var_348_56 / var_348_55)

				if var_348_57 > 0 and var_348_51 < var_348_57 then
					arg_345_1.talkMaxDuration = var_348_57
					var_348_50 = var_348_50 + 0.3

					if var_348_57 + var_348_50 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_57 + var_348_50
					end
				end

				arg_345_1.text_.text = var_348_54
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)
				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_58 = var_348_50 + 0.3
			local var_348_59 = math.max(var_348_51, arg_345_1.talkMaxDuration)

			if var_348_58 <= arg_345_1.time_ and arg_345_1.time_ < var_348_58 + var_348_59 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_58) / var_348_59

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_58 + var_348_59 and arg_345_1.time_ < var_348_58 + var_348_59 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_345_1:InitPlayNodeList()
	end,
	Play420012085 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 420012085
		arg_351_1.duration_ = 5

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play420012086(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = 0
			local var_354_1 = 1.3

			if var_354_0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_0 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, false)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_2 = arg_351_1:GetWordFromCfg(420012085)
				local var_354_3 = arg_351_1:FormatText(var_354_2.content)

				arg_351_1.text_.text = var_354_3

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_4 = 52
				local var_354_5 = utf8.len(var_354_3)
				local var_354_6 = var_354_4 <= 0 and var_354_1 or var_354_1 * (var_354_5 / var_354_4)

				if var_354_6 > 0 and var_354_1 < var_354_6 then
					arg_351_1.talkMaxDuration = var_354_6

					if var_354_6 + var_354_0 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_6 + var_354_0
					end
				end

				arg_351_1.text_.text = var_354_3
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)
				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_7 = math.max(var_354_1, arg_351_1.talkMaxDuration)

			if var_354_0 <= arg_351_1.time_ and arg_351_1.time_ < var_354_0 + var_354_7 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_0) / var_354_7

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_0 + var_354_7 and arg_351_1.time_ < var_354_0 + var_354_7 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play420012086 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 420012086
		arg_355_1.duration_ = 2.6

		local var_355_0 = {
			zh = 2.6,
			ja = 2.3
		}
		local var_355_1 = manager.audio:GetLocalizationFlag()

		if var_355_0[var_355_1] ~= nil then
			arg_355_1.duration_ = var_355_0[var_355_1]
		end

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play420012087(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = arg_355_1.actors_["1085ui_story"].transform
			local var_358_1 = 0

			if var_358_1 < arg_355_1.time_ and arg_355_1.time_ <= var_358_1 + arg_358_0 then
				arg_355_1.var_.moveOldPos1085ui_story = var_358_0.localPosition
			end

			local var_358_2 = 0.001

			if var_358_1 <= arg_355_1.time_ and arg_355_1.time_ < var_358_1 + var_358_2 then
				local var_358_3 = (arg_355_1.time_ - var_358_1) / var_358_2
				local var_358_4 = Vector3.New(0, -1.01, -5.83)

				var_358_0.localPosition = Vector3.Lerp(arg_355_1.var_.moveOldPos1085ui_story, var_358_4, var_358_3)

				local var_358_5 = manager.ui.mainCamera.transform.position - var_358_0.position

				var_358_0.forward = Vector3.New(var_358_5.x, var_358_5.y, var_358_5.z)

				local var_358_6 = var_358_0.localEulerAngles

				var_358_6.z = 0
				var_358_6.x = 0
				var_358_0.localEulerAngles = var_358_6
			end

			if arg_355_1.time_ >= var_358_1 + var_358_2 and arg_355_1.time_ < var_358_1 + var_358_2 + arg_358_0 then
				var_358_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_358_7 = manager.ui.mainCamera.transform.position - var_358_0.position

				var_358_0.forward = Vector3.New(var_358_7.x, var_358_7.y, var_358_7.z)

				local var_358_8 = var_358_0.localEulerAngles

				var_358_8.z = 0
				var_358_8.x = 0
				var_358_0.localEulerAngles = var_358_8
			end

			local var_358_9 = arg_355_1.actors_["1085ui_story"]
			local var_358_10 = 0

			if var_358_10 < arg_355_1.time_ and arg_355_1.time_ <= var_358_10 + arg_358_0 and not isNil(var_358_9) and arg_355_1.var_.characterEffect1085ui_story == nil then
				arg_355_1.var_.characterEffect1085ui_story = var_358_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_11 = 0.200000002980232

			if var_358_10 <= arg_355_1.time_ and arg_355_1.time_ < var_358_10 + var_358_11 and not isNil(var_358_9) then
				local var_358_12 = (arg_355_1.time_ - var_358_10) / var_358_11

				if arg_355_1.var_.characterEffect1085ui_story and not isNil(var_358_9) then
					arg_355_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_355_1.time_ >= var_358_10 + var_358_11 and arg_355_1.time_ < var_358_10 + var_358_11 + arg_358_0 and not isNil(var_358_9) and arg_355_1.var_.characterEffect1085ui_story then
				arg_355_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_358_13 = 0

			if var_358_13 < arg_355_1.time_ and arg_355_1.time_ <= var_358_13 + arg_358_0 then
				arg_355_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_358_14 = 0
			local var_358_15 = 0.15

			if var_358_14 < arg_355_1.time_ and arg_355_1.time_ <= var_358_14 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				local var_358_16 = arg_355_1:FormatText(StoryNameCfg[328].name)

				arg_355_1.leftNameTxt_.text = var_358_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_17 = arg_355_1:GetWordFromCfg(420012086)
				local var_358_18 = arg_355_1:FormatText(var_358_17.content)

				arg_355_1.text_.text = var_358_18

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_19 = 6
				local var_358_20 = utf8.len(var_358_18)
				local var_358_21 = var_358_19 <= 0 and var_358_15 or var_358_15 * (var_358_20 / var_358_19)

				if var_358_21 > 0 and var_358_15 < var_358_21 then
					arg_355_1.talkMaxDuration = var_358_21

					if var_358_21 + var_358_14 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_21 + var_358_14
					end
				end

				arg_355_1.text_.text = var_358_18
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012086", "story_v_out_420012.awb") ~= 0 then
					local var_358_22 = manager.audio:GetVoiceLength("story_v_out_420012", "420012086", "story_v_out_420012.awb") / 1000

					if var_358_22 + var_358_14 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_22 + var_358_14
					end

					if var_358_17.prefab_name ~= "" and arg_355_1.actors_[var_358_17.prefab_name] ~= nil then
						local var_358_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_17.prefab_name].transform, "story_v_out_420012", "420012086", "story_v_out_420012.awb")

						arg_355_1:RecordAudio("420012086", var_358_23)
						arg_355_1:RecordAudio("420012086", var_358_23)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_out_420012", "420012086", "story_v_out_420012.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_out_420012", "420012086", "story_v_out_420012.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_24 = math.max(var_358_15, arg_355_1.talkMaxDuration)

			if var_358_14 <= arg_355_1.time_ and arg_355_1.time_ < var_358_14 + var_358_24 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_14) / var_358_24

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_14 + var_358_24 and arg_355_1.time_ < var_358_14 + var_358_24 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_355_1:InitPlayNodeList()
	end,
	Play420012087 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 420012087
		arg_359_1.duration_ = 5

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play420012088(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = arg_359_1.actors_["1085ui_story"].transform
			local var_362_1 = 0

			if var_362_1 < arg_359_1.time_ and arg_359_1.time_ <= var_362_1 + arg_362_0 then
				arg_359_1.var_.moveOldPos1085ui_story = var_362_0.localPosition
			end

			local var_362_2 = 0.001

			if var_362_1 <= arg_359_1.time_ and arg_359_1.time_ < var_362_1 + var_362_2 then
				local var_362_3 = (arg_359_1.time_ - var_362_1) / var_362_2
				local var_362_4 = Vector3.New(0, 100, 0)

				var_362_0.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPos1085ui_story, var_362_4, var_362_3)

				local var_362_5 = manager.ui.mainCamera.transform.position - var_362_0.position

				var_362_0.forward = Vector3.New(var_362_5.x, var_362_5.y, var_362_5.z)

				local var_362_6 = var_362_0.localEulerAngles

				var_362_6.z = 0
				var_362_6.x = 0
				var_362_0.localEulerAngles = var_362_6
			end

			if arg_359_1.time_ >= var_362_1 + var_362_2 and arg_359_1.time_ < var_362_1 + var_362_2 + arg_362_0 then
				var_362_0.localPosition = Vector3.New(0, 100, 0)

				local var_362_7 = manager.ui.mainCamera.transform.position - var_362_0.position

				var_362_0.forward = Vector3.New(var_362_7.x, var_362_7.y, var_362_7.z)

				local var_362_8 = var_362_0.localEulerAngles

				var_362_8.z = 0
				var_362_8.x = 0
				var_362_0.localEulerAngles = var_362_8
			end

			local var_362_9 = 0
			local var_362_10 = 0.975

			if var_362_9 < arg_359_1.time_ and arg_359_1.time_ <= var_362_9 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, false)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_11 = arg_359_1:GetWordFromCfg(420012087)
				local var_362_12 = arg_359_1:FormatText(var_362_11.content)

				arg_359_1.text_.text = var_362_12

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_13 = 39
				local var_362_14 = utf8.len(var_362_12)
				local var_362_15 = var_362_13 <= 0 and var_362_10 or var_362_10 * (var_362_14 / var_362_13)

				if var_362_15 > 0 and var_362_10 < var_362_15 then
					arg_359_1.talkMaxDuration = var_362_15

					if var_362_15 + var_362_9 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_15 + var_362_9
					end
				end

				arg_359_1.text_.text = var_362_12
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)
				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_16 = math.max(var_362_10, arg_359_1.talkMaxDuration)

			if var_362_9 <= arg_359_1.time_ and arg_359_1.time_ < var_362_9 + var_362_16 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_9) / var_362_16

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_9 + var_362_16 and arg_359_1.time_ < var_362_9 + var_362_16 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_359_1:InitPlayNodeList()
	end,
	Play420012088 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 420012088
		arg_363_1.duration_ = 5

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play420012089(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = 0
			local var_366_1 = 0.975

			if var_366_0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_0 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, false)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_2 = arg_363_1:GetWordFromCfg(420012088)
				local var_366_3 = arg_363_1:FormatText(var_366_2.content)

				arg_363_1.text_.text = var_366_3

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_4 = 39
				local var_366_5 = utf8.len(var_366_3)
				local var_366_6 = var_366_4 <= 0 and var_366_1 or var_366_1 * (var_366_5 / var_366_4)

				if var_366_6 > 0 and var_366_1 < var_366_6 then
					arg_363_1.talkMaxDuration = var_366_6

					if var_366_6 + var_366_0 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_6 + var_366_0
					end
				end

				arg_363_1.text_.text = var_366_3
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)
				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_7 = math.max(var_366_1, arg_363_1.talkMaxDuration)

			if var_366_0 <= arg_363_1.time_ and arg_363_1.time_ < var_366_0 + var_366_7 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_0) / var_366_7

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_0 + var_366_7 and arg_363_1.time_ < var_366_0 + var_366_7 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play420012089 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 420012089
		arg_367_1.duration_ = 7.2

		local var_367_0 = {
			zh = 5.666,
			ja = 7.2
		}
		local var_367_1 = manager.audio:GetLocalizationFlag()

		if var_367_0[var_367_1] ~= nil then
			arg_367_1.duration_ = var_367_0[var_367_1]
		end

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play420012090(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = 0
			local var_370_1 = 0.55

			if var_370_0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_0 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				local var_370_2 = arg_367_1:FormatText(StoryNameCfg[1157].name)

				arg_367_1.leftNameTxt_.text = var_370_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, true)
				arg_367_1.iconController_:SetSelectedState("hero")

				arg_367_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzab")

				arg_367_1.callingController_:SetSelectedState("normal")

				arg_367_1.keyicon_.color = Color.New(1, 1, 1)
				arg_367_1.icon_.color = Color.New(1, 1, 1)

				local var_370_3 = arg_367_1:GetWordFromCfg(420012089)
				local var_370_4 = arg_367_1:FormatText(var_370_3.content)

				arg_367_1.text_.text = var_370_4

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_5 = 22
				local var_370_6 = utf8.len(var_370_4)
				local var_370_7 = var_370_5 <= 0 and var_370_1 or var_370_1 * (var_370_6 / var_370_5)

				if var_370_7 > 0 and var_370_1 < var_370_7 then
					arg_367_1.talkMaxDuration = var_370_7

					if var_370_7 + var_370_0 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_7 + var_370_0
					end
				end

				arg_367_1.text_.text = var_370_4
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012089", "story_v_out_420012.awb") ~= 0 then
					local var_370_8 = manager.audio:GetVoiceLength("story_v_out_420012", "420012089", "story_v_out_420012.awb") / 1000

					if var_370_8 + var_370_0 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_8 + var_370_0
					end

					if var_370_3.prefab_name ~= "" and arg_367_1.actors_[var_370_3.prefab_name] ~= nil then
						local var_370_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_3.prefab_name].transform, "story_v_out_420012", "420012089", "story_v_out_420012.awb")

						arg_367_1:RecordAudio("420012089", var_370_9)
						arg_367_1:RecordAudio("420012089", var_370_9)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_out_420012", "420012089", "story_v_out_420012.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_out_420012", "420012089", "story_v_out_420012.awb")
				end

				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_10 = math.max(var_370_1, arg_367_1.talkMaxDuration)

			if var_370_0 <= arg_367_1.time_ and arg_367_1.time_ < var_370_0 + var_370_10 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_0) / var_370_10

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_0 + var_370_10 and arg_367_1.time_ < var_370_0 + var_370_10 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play420012090 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 420012090
		arg_371_1.duration_ = 7.07

		local var_371_0 = {
			zh = 4.5,
			ja = 7.066
		}
		local var_371_1 = manager.audio:GetLocalizationFlag()

		if var_371_0[var_371_1] ~= nil then
			arg_371_1.duration_ = var_371_0[var_371_1]
		end

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play420012091(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = arg_371_1.actors_["1085ui_story"].transform
			local var_374_1 = 0

			if var_374_1 < arg_371_1.time_ and arg_371_1.time_ <= var_374_1 + arg_374_0 then
				arg_371_1.var_.moveOldPos1085ui_story = var_374_0.localPosition
			end

			local var_374_2 = 0.001

			if var_374_1 <= arg_371_1.time_ and arg_371_1.time_ < var_374_1 + var_374_2 then
				local var_374_3 = (arg_371_1.time_ - var_374_1) / var_374_2
				local var_374_4 = Vector3.New(0, -1.01, -5.83)

				var_374_0.localPosition = Vector3.Lerp(arg_371_1.var_.moveOldPos1085ui_story, var_374_4, var_374_3)

				local var_374_5 = manager.ui.mainCamera.transform.position - var_374_0.position

				var_374_0.forward = Vector3.New(var_374_5.x, var_374_5.y, var_374_5.z)

				local var_374_6 = var_374_0.localEulerAngles

				var_374_6.z = 0
				var_374_6.x = 0
				var_374_0.localEulerAngles = var_374_6
			end

			if arg_371_1.time_ >= var_374_1 + var_374_2 and arg_371_1.time_ < var_374_1 + var_374_2 + arg_374_0 then
				var_374_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_374_7 = manager.ui.mainCamera.transform.position - var_374_0.position

				var_374_0.forward = Vector3.New(var_374_7.x, var_374_7.y, var_374_7.z)

				local var_374_8 = var_374_0.localEulerAngles

				var_374_8.z = 0
				var_374_8.x = 0
				var_374_0.localEulerAngles = var_374_8
			end

			local var_374_9 = arg_371_1.actors_["1085ui_story"]
			local var_374_10 = 0

			if var_374_10 < arg_371_1.time_ and arg_371_1.time_ <= var_374_10 + arg_374_0 and not isNil(var_374_9) and arg_371_1.var_.characterEffect1085ui_story == nil then
				arg_371_1.var_.characterEffect1085ui_story = var_374_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_374_11 = 0.200000002980232

			if var_374_10 <= arg_371_1.time_ and arg_371_1.time_ < var_374_10 + var_374_11 and not isNil(var_374_9) then
				local var_374_12 = (arg_371_1.time_ - var_374_10) / var_374_11

				if arg_371_1.var_.characterEffect1085ui_story and not isNil(var_374_9) then
					arg_371_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_371_1.time_ >= var_374_10 + var_374_11 and arg_371_1.time_ < var_374_10 + var_374_11 + arg_374_0 and not isNil(var_374_9) and arg_371_1.var_.characterEffect1085ui_story then
				arg_371_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_374_13 = 0
			local var_374_14 = 0.275

			if var_374_13 < arg_371_1.time_ and arg_371_1.time_ <= var_374_13 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				local var_374_15 = arg_371_1:FormatText(StoryNameCfg[328].name)

				arg_371_1.leftNameTxt_.text = var_374_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_16 = arg_371_1:GetWordFromCfg(420012090)
				local var_374_17 = arg_371_1:FormatText(var_374_16.content)

				arg_371_1.text_.text = var_374_17

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_18 = 11
				local var_374_19 = utf8.len(var_374_17)
				local var_374_20 = var_374_18 <= 0 and var_374_14 or var_374_14 * (var_374_19 / var_374_18)

				if var_374_20 > 0 and var_374_14 < var_374_20 then
					arg_371_1.talkMaxDuration = var_374_20

					if var_374_20 + var_374_13 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_20 + var_374_13
					end
				end

				arg_371_1.text_.text = var_374_17
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012090", "story_v_out_420012.awb") ~= 0 then
					local var_374_21 = manager.audio:GetVoiceLength("story_v_out_420012", "420012090", "story_v_out_420012.awb") / 1000

					if var_374_21 + var_374_13 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_21 + var_374_13
					end

					if var_374_16.prefab_name ~= "" and arg_371_1.actors_[var_374_16.prefab_name] ~= nil then
						local var_374_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_16.prefab_name].transform, "story_v_out_420012", "420012090", "story_v_out_420012.awb")

						arg_371_1:RecordAudio("420012090", var_374_22)
						arg_371_1:RecordAudio("420012090", var_374_22)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_out_420012", "420012090", "story_v_out_420012.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_out_420012", "420012090", "story_v_out_420012.awb")
				end

				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_23 = math.max(var_374_14, arg_371_1.talkMaxDuration)

			if var_374_13 <= arg_371_1.time_ and arg_371_1.time_ < var_374_13 + var_374_23 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_13) / var_374_23

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_13 + var_374_23 and arg_371_1.time_ < var_374_13 + var_374_23 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_371_1:InitPlayNodeList()
	end,
	Play420012091 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 420012091
		arg_375_1.duration_ = 10.9

		local var_375_0 = {
			zh = 10.9,
			ja = 9.9
		}
		local var_375_1 = manager.audio:GetLocalizationFlag()

		if var_375_0[var_375_1] ~= nil then
			arg_375_1.duration_ = var_375_0[var_375_1]
		end

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play420012092(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			local var_378_0 = 0

			if var_378_0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_0 + arg_378_0 then
				arg_375_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action2_1")
			end

			local var_378_1 = 0

			if var_378_1 < arg_375_1.time_ and arg_375_1.time_ <= var_378_1 + arg_378_0 then
				arg_375_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_378_2 = 0

			if var_378_2 < arg_375_1.time_ and arg_375_1.time_ <= var_378_2 + arg_378_0 then
				arg_375_1.allBtn_.enabled = false
			end

			local var_378_3 = 1

			if arg_375_1.time_ >= var_378_2 + var_378_3 and arg_375_1.time_ < var_378_2 + var_378_3 + arg_378_0 then
				arg_375_1.allBtn_.enabled = true
			end

			local var_378_4 = 0
			local var_378_5 = 0.6

			if var_378_4 < arg_375_1.time_ and arg_375_1.time_ <= var_378_4 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				local var_378_6 = arg_375_1:FormatText(StoryNameCfg[328].name)

				arg_375_1.leftNameTxt_.text = var_378_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_7 = arg_375_1:GetWordFromCfg(420012091)
				local var_378_8 = arg_375_1:FormatText(var_378_7.content)

				arg_375_1.text_.text = var_378_8

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_9 = 24
				local var_378_10 = utf8.len(var_378_8)
				local var_378_11 = var_378_9 <= 0 and var_378_5 or var_378_5 * (var_378_10 / var_378_9)

				if var_378_11 > 0 and var_378_5 < var_378_11 then
					arg_375_1.talkMaxDuration = var_378_11

					if var_378_11 + var_378_4 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_11 + var_378_4
					end
				end

				arg_375_1.text_.text = var_378_8
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012091", "story_v_out_420012.awb") ~= 0 then
					local var_378_12 = manager.audio:GetVoiceLength("story_v_out_420012", "420012091", "story_v_out_420012.awb") / 1000

					if var_378_12 + var_378_4 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_12 + var_378_4
					end

					if var_378_7.prefab_name ~= "" and arg_375_1.actors_[var_378_7.prefab_name] ~= nil then
						local var_378_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_7.prefab_name].transform, "story_v_out_420012", "420012091", "story_v_out_420012.awb")

						arg_375_1:RecordAudio("420012091", var_378_13)
						arg_375_1:RecordAudio("420012091", var_378_13)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_out_420012", "420012091", "story_v_out_420012.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_out_420012", "420012091", "story_v_out_420012.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_14 = math.max(var_378_5, arg_375_1.talkMaxDuration)

			if var_378_4 <= arg_375_1.time_ and arg_375_1.time_ < var_378_4 + var_378_14 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_4) / var_378_14

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_4 + var_378_14 and arg_375_1.time_ < var_378_4 + var_378_14 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {}

		arg_375_1:InitPlayNodeList()
	end,
	Play420012092 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 420012092
		arg_379_1.duration_ = 3.33

		local var_379_0 = {
			zh = 3.133,
			ja = 3.333
		}
		local var_379_1 = manager.audio:GetLocalizationFlag()

		if var_379_0[var_379_1] ~= nil then
			arg_379_1.duration_ = var_379_0[var_379_1]
		end

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play420012093(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			local var_382_0 = arg_379_1.actors_["1085ui_story"]
			local var_382_1 = 0

			if var_382_1 < arg_379_1.time_ and arg_379_1.time_ <= var_382_1 + arg_382_0 and not isNil(var_382_0) and arg_379_1.var_.characterEffect1085ui_story == nil then
				arg_379_1.var_.characterEffect1085ui_story = var_382_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_2 = 0.200000002980232

			if var_382_1 <= arg_379_1.time_ and arg_379_1.time_ < var_382_1 + var_382_2 and not isNil(var_382_0) then
				local var_382_3 = (arg_379_1.time_ - var_382_1) / var_382_2

				if arg_379_1.var_.characterEffect1085ui_story and not isNil(var_382_0) then
					local var_382_4 = Mathf.Lerp(0, 0.5, var_382_3)

					arg_379_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_379_1.var_.characterEffect1085ui_story.fillRatio = var_382_4
				end
			end

			if arg_379_1.time_ >= var_382_1 + var_382_2 and arg_379_1.time_ < var_382_1 + var_382_2 + arg_382_0 and not isNil(var_382_0) and arg_379_1.var_.characterEffect1085ui_story then
				local var_382_5 = 0.5

				arg_379_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_379_1.var_.characterEffect1085ui_story.fillRatio = var_382_5
			end

			local var_382_6 = 0
			local var_382_7 = 0.225

			if var_382_6 < arg_379_1.time_ and arg_379_1.time_ <= var_382_6 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				local var_382_8 = arg_379_1:FormatText(StoryNameCfg[1158].name)

				arg_379_1.leftNameTxt_.text = var_382_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, true)
				arg_379_1.iconController_:SetSelectedState("hero")

				arg_379_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_379_1.callingController_:SetSelectedState("normal")

				arg_379_1.keyicon_.color = Color.New(1, 1, 1)
				arg_379_1.icon_.color = Color.New(1, 1, 1)

				local var_382_9 = arg_379_1:GetWordFromCfg(420012092)
				local var_382_10 = arg_379_1:FormatText(var_382_9.content)

				arg_379_1.text_.text = var_382_10

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_11 = 9
				local var_382_12 = utf8.len(var_382_10)
				local var_382_13 = var_382_11 <= 0 and var_382_7 or var_382_7 * (var_382_12 / var_382_11)

				if var_382_13 > 0 and var_382_7 < var_382_13 then
					arg_379_1.talkMaxDuration = var_382_13

					if var_382_13 + var_382_6 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_13 + var_382_6
					end
				end

				arg_379_1.text_.text = var_382_10
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012092", "story_v_out_420012.awb") ~= 0 then
					local var_382_14 = manager.audio:GetVoiceLength("story_v_out_420012", "420012092", "story_v_out_420012.awb") / 1000

					if var_382_14 + var_382_6 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_14 + var_382_6
					end

					if var_382_9.prefab_name ~= "" and arg_379_1.actors_[var_382_9.prefab_name] ~= nil then
						local var_382_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_9.prefab_name].transform, "story_v_out_420012", "420012092", "story_v_out_420012.awb")

						arg_379_1:RecordAudio("420012092", var_382_15)
						arg_379_1:RecordAudio("420012092", var_382_15)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_out_420012", "420012092", "story_v_out_420012.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_out_420012", "420012092", "story_v_out_420012.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_16 = math.max(var_382_7, arg_379_1.talkMaxDuration)

			if var_382_6 <= arg_379_1.time_ and arg_379_1.time_ < var_382_6 + var_382_16 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_6) / var_382_16

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_6 + var_382_16 and arg_379_1.time_ < var_382_6 + var_382_16 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play420012093 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 420012093
		arg_383_1.duration_ = 5

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play420012094(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = arg_383_1.actors_["1085ui_story"].transform
			local var_386_1 = 0

			if var_386_1 < arg_383_1.time_ and arg_383_1.time_ <= var_386_1 + arg_386_0 then
				arg_383_1.var_.moveOldPos1085ui_story = var_386_0.localPosition
			end

			local var_386_2 = 0.001

			if var_386_1 <= arg_383_1.time_ and arg_383_1.time_ < var_386_1 + var_386_2 then
				local var_386_3 = (arg_383_1.time_ - var_386_1) / var_386_2
				local var_386_4 = Vector3.New(0, 100, 0)

				var_386_0.localPosition = Vector3.Lerp(arg_383_1.var_.moveOldPos1085ui_story, var_386_4, var_386_3)

				local var_386_5 = manager.ui.mainCamera.transform.position - var_386_0.position

				var_386_0.forward = Vector3.New(var_386_5.x, var_386_5.y, var_386_5.z)

				local var_386_6 = var_386_0.localEulerAngles

				var_386_6.z = 0
				var_386_6.x = 0
				var_386_0.localEulerAngles = var_386_6
			end

			if arg_383_1.time_ >= var_386_1 + var_386_2 and arg_383_1.time_ < var_386_1 + var_386_2 + arg_386_0 then
				var_386_0.localPosition = Vector3.New(0, 100, 0)

				local var_386_7 = manager.ui.mainCamera.transform.position - var_386_0.position

				var_386_0.forward = Vector3.New(var_386_7.x, var_386_7.y, var_386_7.z)

				local var_386_8 = var_386_0.localEulerAngles

				var_386_8.z = 0
				var_386_8.x = 0
				var_386_0.localEulerAngles = var_386_8
			end

			local var_386_9 = 1
			local var_386_10 = 1

			if var_386_9 < arg_383_1.time_ and arg_383_1.time_ <= var_386_9 + arg_386_0 then
				local var_386_11 = "play"
				local var_386_12 = "effect"

				arg_383_1:AudioAction(var_386_11, var_386_12, "se_story_140", "se_story_140_foley_knock", "")
			end

			local var_386_13 = 0
			local var_386_14 = 1.125

			if var_386_13 < arg_383_1.time_ and arg_383_1.time_ <= var_386_13 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, false)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_15 = arg_383_1:GetWordFromCfg(420012093)
				local var_386_16 = arg_383_1:FormatText(var_386_15.content)

				arg_383_1.text_.text = var_386_16

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_17 = 45
				local var_386_18 = utf8.len(var_386_16)
				local var_386_19 = var_386_17 <= 0 and var_386_14 or var_386_14 * (var_386_18 / var_386_17)

				if var_386_19 > 0 and var_386_14 < var_386_19 then
					arg_383_1.talkMaxDuration = var_386_19

					if var_386_19 + var_386_13 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_19 + var_386_13
					end
				end

				arg_383_1.text_.text = var_386_16
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)
				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_20 = math.max(var_386_14, arg_383_1.talkMaxDuration)

			if var_386_13 <= arg_383_1.time_ and arg_383_1.time_ < var_386_13 + var_386_20 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_13) / var_386_20

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_13 + var_386_20 and arg_383_1.time_ < var_386_13 + var_386_20 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_383_1:InitPlayNodeList()
	end,
	Play420012094 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 420012094
		arg_387_1.duration_ = 4.4

		local var_387_0 = {
			zh = 3.8,
			ja = 4.4
		}
		local var_387_1 = manager.audio:GetLocalizationFlag()

		if var_387_0[var_387_1] ~= nil then
			arg_387_1.duration_ = var_387_0[var_387_1]
		end

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play420012095(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = 0
			local var_390_1 = 0.375

			if var_390_0 < arg_387_1.time_ and arg_387_1.time_ <= var_390_0 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				local var_390_2 = arg_387_1:FormatText(StoryNameCfg[1157].name)

				arg_387_1.leftNameTxt_.text = var_390_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, true)
				arg_387_1.iconController_:SetSelectedState("hero")

				arg_387_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzab")

				arg_387_1.callingController_:SetSelectedState("normal")

				arg_387_1.keyicon_.color = Color.New(1, 1, 1)
				arg_387_1.icon_.color = Color.New(1, 1, 1)

				local var_390_3 = arg_387_1:GetWordFromCfg(420012094)
				local var_390_4 = arg_387_1:FormatText(var_390_3.content)

				arg_387_1.text_.text = var_390_4

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_5 = 15
				local var_390_6 = utf8.len(var_390_4)
				local var_390_7 = var_390_5 <= 0 and var_390_1 or var_390_1 * (var_390_6 / var_390_5)

				if var_390_7 > 0 and var_390_1 < var_390_7 then
					arg_387_1.talkMaxDuration = var_390_7

					if var_390_7 + var_390_0 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_7 + var_390_0
					end
				end

				arg_387_1.text_.text = var_390_4
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012094", "story_v_out_420012.awb") ~= 0 then
					local var_390_8 = manager.audio:GetVoiceLength("story_v_out_420012", "420012094", "story_v_out_420012.awb") / 1000

					if var_390_8 + var_390_0 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_8 + var_390_0
					end

					if var_390_3.prefab_name ~= "" and arg_387_1.actors_[var_390_3.prefab_name] ~= nil then
						local var_390_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_387_1.actors_[var_390_3.prefab_name].transform, "story_v_out_420012", "420012094", "story_v_out_420012.awb")

						arg_387_1:RecordAudio("420012094", var_390_9)
						arg_387_1:RecordAudio("420012094", var_390_9)
					else
						arg_387_1:AudioAction("play", "voice", "story_v_out_420012", "420012094", "story_v_out_420012.awb")
					end

					arg_387_1:RecordHistoryTalkVoice("story_v_out_420012", "420012094", "story_v_out_420012.awb")
				end

				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_10 = math.max(var_390_1, arg_387_1.talkMaxDuration)

			if var_390_0 <= arg_387_1.time_ and arg_387_1.time_ < var_390_0 + var_390_10 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_0) / var_390_10

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_0 + var_390_10 and arg_387_1.time_ < var_390_0 + var_390_10 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play420012095 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 420012095
		arg_391_1.duration_ = 2.87

		local var_391_0 = {
			zh = 2.166,
			ja = 2.866
		}
		local var_391_1 = manager.audio:GetLocalizationFlag()

		if var_391_0[var_391_1] ~= nil then
			arg_391_1.duration_ = var_391_0[var_391_1]
		end

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play420012096(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			local var_394_0 = 0
			local var_394_1 = 0.2

			if var_394_0 < arg_391_1.time_ and arg_391_1.time_ <= var_394_0 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				local var_394_2 = arg_391_1:FormatText(StoryNameCfg[1158].name)

				arg_391_1.leftNameTxt_.text = var_394_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, true)
				arg_391_1.iconController_:SetSelectedState("hero")

				arg_391_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_391_1.callingController_:SetSelectedState("normal")

				arg_391_1.keyicon_.color = Color.New(1, 1, 1)
				arg_391_1.icon_.color = Color.New(1, 1, 1)

				local var_394_3 = arg_391_1:GetWordFromCfg(420012095)
				local var_394_4 = arg_391_1:FormatText(var_394_3.content)

				arg_391_1.text_.text = var_394_4

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_5 = 8
				local var_394_6 = utf8.len(var_394_4)
				local var_394_7 = var_394_5 <= 0 and var_394_1 or var_394_1 * (var_394_6 / var_394_5)

				if var_394_7 > 0 and var_394_1 < var_394_7 then
					arg_391_1.talkMaxDuration = var_394_7

					if var_394_7 + var_394_0 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_7 + var_394_0
					end
				end

				arg_391_1.text_.text = var_394_4
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012095", "story_v_out_420012.awb") ~= 0 then
					local var_394_8 = manager.audio:GetVoiceLength("story_v_out_420012", "420012095", "story_v_out_420012.awb") / 1000

					if var_394_8 + var_394_0 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_8 + var_394_0
					end

					if var_394_3.prefab_name ~= "" and arg_391_1.actors_[var_394_3.prefab_name] ~= nil then
						local var_394_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_391_1.actors_[var_394_3.prefab_name].transform, "story_v_out_420012", "420012095", "story_v_out_420012.awb")

						arg_391_1:RecordAudio("420012095", var_394_9)
						arg_391_1:RecordAudio("420012095", var_394_9)
					else
						arg_391_1:AudioAction("play", "voice", "story_v_out_420012", "420012095", "story_v_out_420012.awb")
					end

					arg_391_1:RecordHistoryTalkVoice("story_v_out_420012", "420012095", "story_v_out_420012.awb")
				end

				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_10 = math.max(var_394_1, arg_391_1.talkMaxDuration)

			if var_394_0 <= arg_391_1.time_ and arg_391_1.time_ < var_394_0 + var_394_10 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_0) / var_394_10

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_0 + var_394_10 and arg_391_1.time_ < var_394_0 + var_394_10 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {}

		arg_391_1:InitPlayNodeList()
	end,
	Play420012096 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 420012096
		arg_395_1.duration_ = 7.53

		local var_395_0 = {
			zh = 5.8,
			ja = 7.533
		}
		local var_395_1 = manager.audio:GetLocalizationFlag()

		if var_395_0[var_395_1] ~= nil then
			arg_395_1.duration_ = var_395_0[var_395_1]
		end

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play420012097(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			local var_398_0 = 0
			local var_398_1 = 0.65

			if var_398_0 < arg_395_1.time_ and arg_395_1.time_ <= var_398_0 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				local var_398_2 = arg_395_1:FormatText(StoryNameCfg[1157].name)

				arg_395_1.leftNameTxt_.text = var_398_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, true)
				arg_395_1.iconController_:SetSelectedState("hero")

				arg_395_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzab")

				arg_395_1.callingController_:SetSelectedState("normal")

				arg_395_1.keyicon_.color = Color.New(1, 1, 1)
				arg_395_1.icon_.color = Color.New(1, 1, 1)

				local var_398_3 = arg_395_1:GetWordFromCfg(420012096)
				local var_398_4 = arg_395_1:FormatText(var_398_3.content)

				arg_395_1.text_.text = var_398_4

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_5 = 26
				local var_398_6 = utf8.len(var_398_4)
				local var_398_7 = var_398_5 <= 0 and var_398_1 or var_398_1 * (var_398_6 / var_398_5)

				if var_398_7 > 0 and var_398_1 < var_398_7 then
					arg_395_1.talkMaxDuration = var_398_7

					if var_398_7 + var_398_0 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_7 + var_398_0
					end
				end

				arg_395_1.text_.text = var_398_4
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012096", "story_v_out_420012.awb") ~= 0 then
					local var_398_8 = manager.audio:GetVoiceLength("story_v_out_420012", "420012096", "story_v_out_420012.awb") / 1000

					if var_398_8 + var_398_0 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_8 + var_398_0
					end

					if var_398_3.prefab_name ~= "" and arg_395_1.actors_[var_398_3.prefab_name] ~= nil then
						local var_398_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_395_1.actors_[var_398_3.prefab_name].transform, "story_v_out_420012", "420012096", "story_v_out_420012.awb")

						arg_395_1:RecordAudio("420012096", var_398_9)
						arg_395_1:RecordAudio("420012096", var_398_9)
					else
						arg_395_1:AudioAction("play", "voice", "story_v_out_420012", "420012096", "story_v_out_420012.awb")
					end

					arg_395_1:RecordHistoryTalkVoice("story_v_out_420012", "420012096", "story_v_out_420012.awb")
				end

				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_10 = math.max(var_398_1, arg_395_1.talkMaxDuration)

			if var_398_0 <= arg_395_1.time_ and arg_395_1.time_ < var_398_0 + var_398_10 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_0) / var_398_10

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_0 + var_398_10 and arg_395_1.time_ < var_398_0 + var_398_10 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {}

		arg_395_1:InitPlayNodeList()
	end,
	Play420012097 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 420012097
		arg_399_1.duration_ = 7.87

		local var_399_0 = {
			zh = 6.333,
			ja = 7.866
		}
		local var_399_1 = manager.audio:GetLocalizationFlag()

		if var_399_0[var_399_1] ~= nil then
			arg_399_1.duration_ = var_399_0[var_399_1]
		end

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play420012098(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			local var_402_0 = 0
			local var_402_1 = 0.8

			if var_402_0 < arg_399_1.time_ and arg_399_1.time_ <= var_402_0 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				local var_402_2 = arg_399_1:FormatText(StoryNameCfg[1157].name)

				arg_399_1.leftNameTxt_.text = var_402_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, true)
				arg_399_1.iconController_:SetSelectedState("hero")

				arg_399_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzab")

				arg_399_1.callingController_:SetSelectedState("normal")

				arg_399_1.keyicon_.color = Color.New(1, 1, 1)
				arg_399_1.icon_.color = Color.New(1, 1, 1)

				local var_402_3 = arg_399_1:GetWordFromCfg(420012097)
				local var_402_4 = arg_399_1:FormatText(var_402_3.content)

				arg_399_1.text_.text = var_402_4

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_5 = 32
				local var_402_6 = utf8.len(var_402_4)
				local var_402_7 = var_402_5 <= 0 and var_402_1 or var_402_1 * (var_402_6 / var_402_5)

				if var_402_7 > 0 and var_402_1 < var_402_7 then
					arg_399_1.talkMaxDuration = var_402_7

					if var_402_7 + var_402_0 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_7 + var_402_0
					end
				end

				arg_399_1.text_.text = var_402_4
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012097", "story_v_out_420012.awb") ~= 0 then
					local var_402_8 = manager.audio:GetVoiceLength("story_v_out_420012", "420012097", "story_v_out_420012.awb") / 1000

					if var_402_8 + var_402_0 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_8 + var_402_0
					end

					if var_402_3.prefab_name ~= "" and arg_399_1.actors_[var_402_3.prefab_name] ~= nil then
						local var_402_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_399_1.actors_[var_402_3.prefab_name].transform, "story_v_out_420012", "420012097", "story_v_out_420012.awb")

						arg_399_1:RecordAudio("420012097", var_402_9)
						arg_399_1:RecordAudio("420012097", var_402_9)
					else
						arg_399_1:AudioAction("play", "voice", "story_v_out_420012", "420012097", "story_v_out_420012.awb")
					end

					arg_399_1:RecordHistoryTalkVoice("story_v_out_420012", "420012097", "story_v_out_420012.awb")
				end

				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_10 = math.max(var_402_1, arg_399_1.talkMaxDuration)

			if var_402_0 <= arg_399_1.time_ and arg_399_1.time_ < var_402_0 + var_402_10 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_0) / var_402_10

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_0 + var_402_10 and arg_399_1.time_ < var_402_0 + var_402_10 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {}

		arg_399_1:InitPlayNodeList()
	end,
	Play420012098 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 420012098
		arg_403_1.duration_ = 7.9

		local var_403_0 = {
			zh = 5.866,
			ja = 7.9
		}
		local var_403_1 = manager.audio:GetLocalizationFlag()

		if var_403_0[var_403_1] ~= nil then
			arg_403_1.duration_ = var_403_0[var_403_1]
		end

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play420012099(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			local var_406_0 = 0
			local var_406_1 = 0.55

			if var_406_0 < arg_403_1.time_ and arg_403_1.time_ <= var_406_0 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				local var_406_2 = arg_403_1:FormatText(StoryNameCfg[1157].name)

				arg_403_1.leftNameTxt_.text = var_406_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, true)
				arg_403_1.iconController_:SetSelectedState("hero")

				arg_403_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzab")

				arg_403_1.callingController_:SetSelectedState("normal")

				arg_403_1.keyicon_.color = Color.New(1, 1, 1)
				arg_403_1.icon_.color = Color.New(1, 1, 1)

				local var_406_3 = arg_403_1:GetWordFromCfg(420012098)
				local var_406_4 = arg_403_1:FormatText(var_406_3.content)

				arg_403_1.text_.text = var_406_4

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_5 = 22
				local var_406_6 = utf8.len(var_406_4)
				local var_406_7 = var_406_5 <= 0 and var_406_1 or var_406_1 * (var_406_6 / var_406_5)

				if var_406_7 > 0 and var_406_1 < var_406_7 then
					arg_403_1.talkMaxDuration = var_406_7

					if var_406_7 + var_406_0 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_7 + var_406_0
					end
				end

				arg_403_1.text_.text = var_406_4
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012098", "story_v_out_420012.awb") ~= 0 then
					local var_406_8 = manager.audio:GetVoiceLength("story_v_out_420012", "420012098", "story_v_out_420012.awb") / 1000

					if var_406_8 + var_406_0 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_8 + var_406_0
					end

					if var_406_3.prefab_name ~= "" and arg_403_1.actors_[var_406_3.prefab_name] ~= nil then
						local var_406_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_403_1.actors_[var_406_3.prefab_name].transform, "story_v_out_420012", "420012098", "story_v_out_420012.awb")

						arg_403_1:RecordAudio("420012098", var_406_9)
						arg_403_1:RecordAudio("420012098", var_406_9)
					else
						arg_403_1:AudioAction("play", "voice", "story_v_out_420012", "420012098", "story_v_out_420012.awb")
					end

					arg_403_1:RecordHistoryTalkVoice("story_v_out_420012", "420012098", "story_v_out_420012.awb")
				end

				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_10 = math.max(var_406_1, arg_403_1.talkMaxDuration)

			if var_406_0 <= arg_403_1.time_ and arg_403_1.time_ < var_406_0 + var_406_10 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_0) / var_406_10

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_0 + var_406_10 and arg_403_1.time_ < var_406_0 + var_406_10 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {}

		arg_403_1:InitPlayNodeList()
	end,
	Play420012099 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 420012099
		arg_407_1.duration_ = 3.37

		local var_407_0 = {
			zh = 3.366,
			ja = 1.999999999999
		}
		local var_407_1 = manager.audio:GetLocalizationFlag()

		if var_407_0[var_407_1] ~= nil then
			arg_407_1.duration_ = var_407_0[var_407_1]
		end

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play420012100(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			local var_410_0 = arg_407_1.actors_["1085ui_story"].transform
			local var_410_1 = 0

			if var_410_1 < arg_407_1.time_ and arg_407_1.time_ <= var_410_1 + arg_410_0 then
				arg_407_1.var_.moveOldPos1085ui_story = var_410_0.localPosition
			end

			local var_410_2 = 0.001

			if var_410_1 <= arg_407_1.time_ and arg_407_1.time_ < var_410_1 + var_410_2 then
				local var_410_3 = (arg_407_1.time_ - var_410_1) / var_410_2
				local var_410_4 = Vector3.New(0, -1.01, -5.83)

				var_410_0.localPosition = Vector3.Lerp(arg_407_1.var_.moveOldPos1085ui_story, var_410_4, var_410_3)

				local var_410_5 = manager.ui.mainCamera.transform.position - var_410_0.position

				var_410_0.forward = Vector3.New(var_410_5.x, var_410_5.y, var_410_5.z)

				local var_410_6 = var_410_0.localEulerAngles

				var_410_6.z = 0
				var_410_6.x = 0
				var_410_0.localEulerAngles = var_410_6
			end

			if arg_407_1.time_ >= var_410_1 + var_410_2 and arg_407_1.time_ < var_410_1 + var_410_2 + arg_410_0 then
				var_410_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_410_7 = manager.ui.mainCamera.transform.position - var_410_0.position

				var_410_0.forward = Vector3.New(var_410_7.x, var_410_7.y, var_410_7.z)

				local var_410_8 = var_410_0.localEulerAngles

				var_410_8.z = 0
				var_410_8.x = 0
				var_410_0.localEulerAngles = var_410_8
			end

			local var_410_9 = arg_407_1.actors_["1085ui_story"]
			local var_410_10 = 0

			if var_410_10 < arg_407_1.time_ and arg_407_1.time_ <= var_410_10 + arg_410_0 and not isNil(var_410_9) and arg_407_1.var_.characterEffect1085ui_story == nil then
				arg_407_1.var_.characterEffect1085ui_story = var_410_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_410_11 = 0.200000002980232

			if var_410_10 <= arg_407_1.time_ and arg_407_1.time_ < var_410_10 + var_410_11 and not isNil(var_410_9) then
				local var_410_12 = (arg_407_1.time_ - var_410_10) / var_410_11

				if arg_407_1.var_.characterEffect1085ui_story and not isNil(var_410_9) then
					arg_407_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_407_1.time_ >= var_410_10 + var_410_11 and arg_407_1.time_ < var_410_10 + var_410_11 + arg_410_0 and not isNil(var_410_9) and arg_407_1.var_.characterEffect1085ui_story then
				arg_407_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_410_13 = 0

			if var_410_13 < arg_407_1.time_ and arg_407_1.time_ <= var_410_13 + arg_410_0 then
				arg_407_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action2_2")
			end

			local var_410_14 = 0

			if var_410_14 < arg_407_1.time_ and arg_407_1.time_ <= var_410_14 + arg_410_0 then
				arg_407_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_410_15 = 0
			local var_410_16 = 0.15

			if var_410_15 < arg_407_1.time_ and arg_407_1.time_ <= var_410_15 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, true)

				local var_410_17 = arg_407_1:FormatText(StoryNameCfg[328].name)

				arg_407_1.leftNameTxt_.text = var_410_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_407_1.leftNameTxt_.transform)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1.leftNameTxt_.text)
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_18 = arg_407_1:GetWordFromCfg(420012099)
				local var_410_19 = arg_407_1:FormatText(var_410_18.content)

				arg_407_1.text_.text = var_410_19

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_20 = 6
				local var_410_21 = utf8.len(var_410_19)
				local var_410_22 = var_410_20 <= 0 and var_410_16 or var_410_16 * (var_410_21 / var_410_20)

				if var_410_22 > 0 and var_410_16 < var_410_22 then
					arg_407_1.talkMaxDuration = var_410_22

					if var_410_22 + var_410_15 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_22 + var_410_15
					end
				end

				arg_407_1.text_.text = var_410_19
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012099", "story_v_out_420012.awb") ~= 0 then
					local var_410_23 = manager.audio:GetVoiceLength("story_v_out_420012", "420012099", "story_v_out_420012.awb") / 1000

					if var_410_23 + var_410_15 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_23 + var_410_15
					end

					if var_410_18.prefab_name ~= "" and arg_407_1.actors_[var_410_18.prefab_name] ~= nil then
						local var_410_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_407_1.actors_[var_410_18.prefab_name].transform, "story_v_out_420012", "420012099", "story_v_out_420012.awb")

						arg_407_1:RecordAudio("420012099", var_410_24)
						arg_407_1:RecordAudio("420012099", var_410_24)
					else
						arg_407_1:AudioAction("play", "voice", "story_v_out_420012", "420012099", "story_v_out_420012.awb")
					end

					arg_407_1:RecordHistoryTalkVoice("story_v_out_420012", "420012099", "story_v_out_420012.awb")
				end

				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_25 = math.max(var_410_16, arg_407_1.talkMaxDuration)

			if var_410_15 <= arg_407_1.time_ and arg_407_1.time_ < var_410_15 + var_410_25 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_15) / var_410_25

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_15 + var_410_25 and arg_407_1.time_ < var_410_15 + var_410_25 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_407_1:InitPlayNodeList()
	end,
	Play420012100 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 420012100
		arg_411_1.duration_ = 5

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play420012101(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			local var_414_0 = arg_411_1.actors_["1085ui_story"].transform
			local var_414_1 = 0

			if var_414_1 < arg_411_1.time_ and arg_411_1.time_ <= var_414_1 + arg_414_0 then
				arg_411_1.var_.moveOldPos1085ui_story = var_414_0.localPosition
			end

			local var_414_2 = 0.001

			if var_414_1 <= arg_411_1.time_ and arg_411_1.time_ < var_414_1 + var_414_2 then
				local var_414_3 = (arg_411_1.time_ - var_414_1) / var_414_2
				local var_414_4 = Vector3.New(0, 100, 0)

				var_414_0.localPosition = Vector3.Lerp(arg_411_1.var_.moveOldPos1085ui_story, var_414_4, var_414_3)

				local var_414_5 = manager.ui.mainCamera.transform.position - var_414_0.position

				var_414_0.forward = Vector3.New(var_414_5.x, var_414_5.y, var_414_5.z)

				local var_414_6 = var_414_0.localEulerAngles

				var_414_6.z = 0
				var_414_6.x = 0
				var_414_0.localEulerAngles = var_414_6
			end

			if arg_411_1.time_ >= var_414_1 + var_414_2 and arg_411_1.time_ < var_414_1 + var_414_2 + arg_414_0 then
				var_414_0.localPosition = Vector3.New(0, 100, 0)

				local var_414_7 = manager.ui.mainCamera.transform.position - var_414_0.position

				var_414_0.forward = Vector3.New(var_414_7.x, var_414_7.y, var_414_7.z)

				local var_414_8 = var_414_0.localEulerAngles

				var_414_8.z = 0
				var_414_8.x = 0
				var_414_0.localEulerAngles = var_414_8
			end

			local var_414_9 = 0.05
			local var_414_10 = 1

			if var_414_9 < arg_411_1.time_ and arg_411_1.time_ <= var_414_9 + arg_414_0 then
				local var_414_11 = "play"
				local var_414_12 = "effect"

				arg_411_1:AudioAction(var_414_11, var_414_12, "se_story_140", "se_story_140_foley_cash01", "")
			end

			local var_414_13 = 0
			local var_414_14 = 1.625

			if var_414_13 < arg_411_1.time_ and arg_411_1.time_ <= var_414_13 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, false)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_411_1.iconTrs_.gameObject, false)
				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_15 = arg_411_1:GetWordFromCfg(420012100)
				local var_414_16 = arg_411_1:FormatText(var_414_15.content)

				arg_411_1.text_.text = var_414_16

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_17 = 65
				local var_414_18 = utf8.len(var_414_16)
				local var_414_19 = var_414_17 <= 0 and var_414_14 or var_414_14 * (var_414_18 / var_414_17)

				if var_414_19 > 0 and var_414_14 < var_414_19 then
					arg_411_1.talkMaxDuration = var_414_19

					if var_414_19 + var_414_13 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_19 + var_414_13
					end
				end

				arg_411_1.text_.text = var_414_16
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)
				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_20 = math.max(var_414_14, arg_411_1.talkMaxDuration)

			if var_414_13 <= arg_411_1.time_ and arg_411_1.time_ < var_414_13 + var_414_20 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_13) / var_414_20

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_13 + var_414_20 and arg_411_1.time_ < var_414_13 + var_414_20 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_411_1:InitPlayNodeList()
	end,
	Play420012101 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 420012101
		arg_415_1.duration_ = 5

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play420012102(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			local var_418_0 = 0
			local var_418_1 = 0.525

			if var_418_0 < arg_415_1.time_ and arg_415_1.time_ <= var_418_0 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, true)

				local var_418_2 = arg_415_1:FormatText(StoryNameCfg[7].name)

				arg_415_1.leftNameTxt_.text = var_418_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, true)
				arg_415_1.iconController_:SetSelectedState("hero")

				arg_415_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_415_1.callingController_:SetSelectedState("normal")

				arg_415_1.keyicon_.color = Color.New(1, 1, 1)
				arg_415_1.icon_.color = Color.New(1, 1, 1)

				local var_418_3 = arg_415_1:GetWordFromCfg(420012101)
				local var_418_4 = arg_415_1:FormatText(var_418_3.content)

				arg_415_1.text_.text = var_418_4

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_5 = 21
				local var_418_6 = utf8.len(var_418_4)
				local var_418_7 = var_418_5 <= 0 and var_418_1 or var_418_1 * (var_418_6 / var_418_5)

				if var_418_7 > 0 and var_418_1 < var_418_7 then
					arg_415_1.talkMaxDuration = var_418_7

					if var_418_7 + var_418_0 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_7 + var_418_0
					end
				end

				arg_415_1.text_.text = var_418_4
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)
				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_8 = math.max(var_418_1, arg_415_1.talkMaxDuration)

			if var_418_0 <= arg_415_1.time_ and arg_415_1.time_ < var_418_0 + var_418_8 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_0) / var_418_8

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_0 + var_418_8 and arg_415_1.time_ < var_418_0 + var_418_8 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {}

		arg_415_1:InitPlayNodeList()
	end,
	Play420012102 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 420012102
		arg_419_1.duration_ = 5

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play420012103(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			local var_422_0 = 0
			local var_422_1 = 0.4

			if var_422_0 < arg_419_1.time_ and arg_419_1.time_ <= var_422_0 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, true)

				local var_422_2 = arg_419_1:FormatText(StoryNameCfg[7].name)

				arg_419_1.leftNameTxt_.text = var_422_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, true)
				arg_419_1.iconController_:SetSelectedState("hero")

				arg_419_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_419_1.callingController_:SetSelectedState("normal")

				arg_419_1.keyicon_.color = Color.New(1, 1, 1)
				arg_419_1.icon_.color = Color.New(1, 1, 1)

				local var_422_3 = arg_419_1:GetWordFromCfg(420012102)
				local var_422_4 = arg_419_1:FormatText(var_422_3.content)

				arg_419_1.text_.text = var_422_4

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_5 = 16
				local var_422_6 = utf8.len(var_422_4)
				local var_422_7 = var_422_5 <= 0 and var_422_1 or var_422_1 * (var_422_6 / var_422_5)

				if var_422_7 > 0 and var_422_1 < var_422_7 then
					arg_419_1.talkMaxDuration = var_422_7

					if var_422_7 + var_422_0 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_7 + var_422_0
					end
				end

				arg_419_1.text_.text = var_422_4
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)
				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_8 = math.max(var_422_1, arg_419_1.talkMaxDuration)

			if var_422_0 <= arg_419_1.time_ and arg_419_1.time_ < var_422_0 + var_422_8 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_0) / var_422_8

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_0 + var_422_8 and arg_419_1.time_ < var_422_0 + var_422_8 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {}

		arg_419_1:InitPlayNodeList()
	end,
	Play420012103 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 420012103
		arg_423_1.duration_ = 5

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play420012104(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			local var_426_0 = 0
			local var_426_1 = 1.125

			if var_426_0 < arg_423_1.time_ and arg_423_1.time_ <= var_426_0 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, false)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_423_1.iconTrs_.gameObject, false)
				arg_423_1.callingController_:SetSelectedState("normal")

				local var_426_2 = arg_423_1:GetWordFromCfg(420012103)
				local var_426_3 = arg_423_1:FormatText(var_426_2.content)

				arg_423_1.text_.text = var_426_3

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_4 = 45
				local var_426_5 = utf8.len(var_426_3)
				local var_426_6 = var_426_4 <= 0 and var_426_1 or var_426_1 * (var_426_5 / var_426_4)

				if var_426_6 > 0 and var_426_1 < var_426_6 then
					arg_423_1.talkMaxDuration = var_426_6

					if var_426_6 + var_426_0 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_6 + var_426_0
					end
				end

				arg_423_1.text_.text = var_426_3
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)
				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_7 = math.max(var_426_1, arg_423_1.talkMaxDuration)

			if var_426_0 <= arg_423_1.time_ and arg_423_1.time_ < var_426_0 + var_426_7 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_0) / var_426_7

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_0 + var_426_7 and arg_423_1.time_ < var_426_0 + var_426_7 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {}

		arg_423_1:InitPlayNodeList()
	end,
	Play420012104 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 420012104
		arg_427_1.duration_ = 7.2

		local var_427_0 = {
			zh = 6.399999999999,
			ja = 7.199999999999
		}
		local var_427_1 = manager.audio:GetLocalizationFlag()

		if var_427_0[var_427_1] ~= nil then
			arg_427_1.duration_ = var_427_0[var_427_1]
		end

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play420012105(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			local var_430_0 = "I05e"

			if arg_427_1.bgs_[var_430_0] == nil then
				local var_430_1 = Object.Instantiate(arg_427_1.paintGo_)

				var_430_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_430_0)
				var_430_1.name = var_430_0
				var_430_1.transform.parent = arg_427_1.stage_.transform
				var_430_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_427_1.bgs_[var_430_0] = var_430_1
			end

			local var_430_2 = 1.999999999999

			if var_430_2 < arg_427_1.time_ and arg_427_1.time_ <= var_430_2 + arg_430_0 then
				local var_430_3 = manager.ui.mainCamera.transform.localPosition
				local var_430_4 = Vector3.New(0, 0, 10) + Vector3.New(var_430_3.x, var_430_3.y, 0)
				local var_430_5 = arg_427_1.bgs_.I05e

				var_430_5.transform.localPosition = var_430_4
				var_430_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_430_6 = var_430_5:GetComponent("SpriteRenderer")

				if var_430_6 and var_430_6.sprite then
					local var_430_7 = (var_430_5.transform.localPosition - var_430_3).z
					local var_430_8 = manager.ui.mainCameraCom_
					local var_430_9 = 2 * var_430_7 * Mathf.Tan(var_430_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_430_10 = var_430_9 * var_430_8.aspect
					local var_430_11 = var_430_6.sprite.bounds.size.x
					local var_430_12 = var_430_6.sprite.bounds.size.y
					local var_430_13 = var_430_10 / var_430_11
					local var_430_14 = var_430_9 / var_430_12
					local var_430_15 = var_430_14 < var_430_13 and var_430_13 or var_430_14

					var_430_5.transform.localScale = Vector3.New(var_430_15, var_430_15, 0)
				end

				for iter_430_0, iter_430_1 in pairs(arg_427_1.bgs_) do
					if iter_430_0 ~= "I05e" then
						iter_430_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_430_16 = 3.999999999999

			if var_430_16 < arg_427_1.time_ and arg_427_1.time_ <= var_430_16 + arg_430_0 then
				arg_427_1.allBtn_.enabled = false
			end

			local var_430_17 = 0.0666666666676665

			if arg_427_1.time_ >= var_430_16 + var_430_17 and arg_427_1.time_ < var_430_16 + var_430_17 + arg_430_0 then
				arg_427_1.allBtn_.enabled = true
			end

			local var_430_18 = 0

			if var_430_18 < arg_427_1.time_ and arg_427_1.time_ <= var_430_18 + arg_430_0 then
				arg_427_1.mask_.enabled = true
				arg_427_1.mask_.raycastTarget = true

				arg_427_1:SetGaussion(false)
			end

			local var_430_19 = 2

			if var_430_18 <= arg_427_1.time_ and arg_427_1.time_ < var_430_18 + var_430_19 then
				local var_430_20 = (arg_427_1.time_ - var_430_18) / var_430_19
				local var_430_21 = Color.New(0, 0, 0)

				var_430_21.a = Mathf.Lerp(0, 1, var_430_20)
				arg_427_1.mask_.color = var_430_21
			end

			if arg_427_1.time_ >= var_430_18 + var_430_19 and arg_427_1.time_ < var_430_18 + var_430_19 + arg_430_0 then
				local var_430_22 = Color.New(0, 0, 0)

				var_430_22.a = 1
				arg_427_1.mask_.color = var_430_22
			end

			local var_430_23 = 2

			if var_430_23 < arg_427_1.time_ and arg_427_1.time_ <= var_430_23 + arg_430_0 then
				arg_427_1.mask_.enabled = true
				arg_427_1.mask_.raycastTarget = true

				arg_427_1:SetGaussion(false)
			end

			local var_430_24 = 2

			if var_430_23 <= arg_427_1.time_ and arg_427_1.time_ < var_430_23 + var_430_24 then
				local var_430_25 = (arg_427_1.time_ - var_430_23) / var_430_24
				local var_430_26 = Color.New(0, 0, 0)

				var_430_26.a = Mathf.Lerp(1, 0, var_430_25)
				arg_427_1.mask_.color = var_430_26
			end

			if arg_427_1.time_ >= var_430_23 + var_430_24 and arg_427_1.time_ < var_430_23 + var_430_24 + arg_430_0 then
				local var_430_27 = Color.New(0, 0, 0)
				local var_430_28 = 0

				arg_427_1.mask_.enabled = false
				var_430_27.a = var_430_28
				arg_427_1.mask_.color = var_430_27
			end

			local var_430_29 = "10025ui_story"

			if arg_427_1.actors_[var_430_29] == nil then
				local var_430_30 = Asset.Load("Char/" .. "10025ui_story")

				if not isNil(var_430_30) then
					local var_430_31 = Object.Instantiate(Asset.Load("Char/" .. "10025ui_story"), arg_427_1.stage_.transform)

					var_430_31.name = var_430_29
					var_430_31.transform.localPosition = Vector3.New(0, 100, 0)
					arg_427_1.actors_[var_430_29] = var_430_31

					local var_430_32 = var_430_31:GetComponentInChildren(typeof(CharacterEffect))

					var_430_32.enabled = true

					local var_430_33 = GameObjectTools.GetOrAddComponent(var_430_31, typeof(DynamicBoneHelper))

					if var_430_33 then
						var_430_33:EnableDynamicBone(false)
					end

					arg_427_1:ShowWeapon(var_430_32.transform, false)

					arg_427_1.var_[var_430_29 .. "Animator"] = var_430_32.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_427_1.var_[var_430_29 .. "Animator"].applyRootMotion = true
					arg_427_1.var_[var_430_29 .. "LipSync"] = var_430_32.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_430_34 = arg_427_1.actors_["10025ui_story"].transform
			local var_430_35 = 2

			if var_430_35 < arg_427_1.time_ and arg_427_1.time_ <= var_430_35 + arg_430_0 then
				arg_427_1.var_.moveOldPos10025ui_story = var_430_34.localPosition
			end

			local var_430_36 = 0.001

			if var_430_35 <= arg_427_1.time_ and arg_427_1.time_ < var_430_35 + var_430_36 then
				local var_430_37 = (arg_427_1.time_ - var_430_35) / var_430_36
				local var_430_38 = Vector3.New(0, -1.1, -5.9)

				var_430_34.localPosition = Vector3.Lerp(arg_427_1.var_.moveOldPos10025ui_story, var_430_38, var_430_37)

				local var_430_39 = manager.ui.mainCamera.transform.position - var_430_34.position

				var_430_34.forward = Vector3.New(var_430_39.x, var_430_39.y, var_430_39.z)

				local var_430_40 = var_430_34.localEulerAngles

				var_430_40.z = 0
				var_430_40.x = 0
				var_430_34.localEulerAngles = var_430_40
			end

			if arg_427_1.time_ >= var_430_35 + var_430_36 and arg_427_1.time_ < var_430_35 + var_430_36 + arg_430_0 then
				var_430_34.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_430_41 = manager.ui.mainCamera.transform.position - var_430_34.position

				var_430_34.forward = Vector3.New(var_430_41.x, var_430_41.y, var_430_41.z)

				local var_430_42 = var_430_34.localEulerAngles

				var_430_42.z = 0
				var_430_42.x = 0
				var_430_34.localEulerAngles = var_430_42
			end

			local var_430_43 = arg_427_1.actors_["10025ui_story"]
			local var_430_44 = 2

			if var_430_44 < arg_427_1.time_ and arg_427_1.time_ <= var_430_44 + arg_430_0 and not isNil(var_430_43) and arg_427_1.var_.characterEffect10025ui_story == nil then
				arg_427_1.var_.characterEffect10025ui_story = var_430_43:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_430_45 = 0.200000002980232

			if var_430_44 <= arg_427_1.time_ and arg_427_1.time_ < var_430_44 + var_430_45 and not isNil(var_430_43) then
				local var_430_46 = (arg_427_1.time_ - var_430_44) / var_430_45

				if arg_427_1.var_.characterEffect10025ui_story and not isNil(var_430_43) then
					arg_427_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_427_1.time_ >= var_430_44 + var_430_45 and arg_427_1.time_ < var_430_44 + var_430_45 + arg_430_0 and not isNil(var_430_43) and arg_427_1.var_.characterEffect10025ui_story then
				arg_427_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_430_47 = 2.03400000184774

			if var_430_47 < arg_427_1.time_ and arg_427_1.time_ <= var_430_47 + arg_430_0 then
				arg_427_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_430_48 = 2.03400000184774

			if var_430_48 < arg_427_1.time_ and arg_427_1.time_ <= var_430_48 + arg_430_0 then
				arg_427_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action8_1")
			end

			local var_430_49 = 0.05
			local var_430_50 = 1

			if var_430_49 < arg_427_1.time_ and arg_427_1.time_ <= var_430_49 + arg_430_0 then
				local var_430_51 = "play"
				local var_430_52 = "effect"

				arg_427_1:AudioAction(var_430_51, var_430_52, "se_story_140", "se_story_140_riser", "")
			end

			local var_430_53 = 1.816
			local var_430_54 = 1

			if var_430_53 < arg_427_1.time_ and arg_427_1.time_ <= var_430_53 + arg_430_0 then
				local var_430_55 = "play"
				local var_430_56 = "effect"

				arg_427_1:AudioAction(var_430_55, var_430_56, "se_story_140", "se_story_140_amb_rainthunder", "")
			end

			local var_430_57 = 0.05
			local var_430_58 = 1

			if var_430_57 < arg_427_1.time_ and arg_427_1.time_ <= var_430_57 + arg_430_0 then
				local var_430_59 = "stop"
				local var_430_60 = "effect"

				arg_427_1:AudioAction(var_430_59, var_430_60, "se_story_140", "se_story_140_amb_street01", "")
			end

			local var_430_61 = 0
			local var_430_62 = 0.2

			if var_430_61 < arg_427_1.time_ and arg_427_1.time_ <= var_430_61 + arg_430_0 then
				local var_430_63 = "play"
				local var_430_64 = "music"

				arg_427_1:AudioAction(var_430_63, var_430_64, "ui_battle", "ui_battle_stopbgm", "")

				local var_430_65 = ""
				local var_430_66 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_430_66 ~= "" then
					if arg_427_1.bgmTxt_.text ~= var_430_66 and arg_427_1.bgmTxt_.text ~= "" then
						if arg_427_1.bgmTxt2_.text ~= "" then
							arg_427_1.bgmTxt_.text = arg_427_1.bgmTxt2_.text
						end

						arg_427_1.bgmTxt2_.text = var_430_66

						arg_427_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_427_1.bgmTxt_.text = var_430_66
						arg_427_1.bgmTxt2_.text = var_430_66
					end

					if arg_427_1.bgmTimer then
						arg_427_1.bgmTimer:Stop()

						arg_427_1.bgmTimer = nil
					end

					if arg_427_1.settingData.show_music_name == 1 then
						arg_427_1.musicController:SetSelectedState("show")
						arg_427_1.musicAnimator_:Play("open", 0, 0)

						if arg_427_1.settingData.music_time ~= 0 then
							arg_427_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_427_1.settingData.music_time), function()
								if arg_427_1 == nil or isNil(arg_427_1.bgmTxt_) then
									return
								end

								arg_427_1.musicController:SetSelectedState("hide")
								arg_427_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_430_67 = 2

			arg_427_1.isInRecall_ = false

			if var_430_67 < arg_427_1.time_ and arg_427_1.time_ <= var_430_67 + arg_430_0 then
				arg_427_1.screenFilterGo_:SetActive(true)

				arg_427_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_430_2, iter_430_3 in pairs(arg_427_1.actors_) do
					local var_430_68 = iter_430_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_430_4, iter_430_5 in ipairs(var_430_68) do
						if iter_430_5.color.r > 0.51 then
							iter_430_5.color = Color.New(1, 1, 1)
						else
							iter_430_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_430_69 = 0.0166666666666667

			if var_430_67 <= arg_427_1.time_ and arg_427_1.time_ < var_430_67 + var_430_69 then
				local var_430_70 = (arg_427_1.time_ - var_430_67) / var_430_69

				arg_427_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_430_70)
			end

			if arg_427_1.time_ >= var_430_67 + var_430_69 and arg_427_1.time_ < var_430_67 + var_430_69 + arg_430_0 then
				arg_427_1.screenFilterEffect_.weight = 1
			end

			local var_430_71 = manager.ui.mainCamera.transform
			local var_430_72 = 1.999999999999

			if var_430_72 < arg_427_1.time_ and arg_427_1.time_ <= var_430_72 + arg_430_0 then
				local var_430_73 = arg_427_1.var_.effect2104
				local var_430_74
				local var_430_75 = var_430_71

				if not var_430_73 then
					var_430_73 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rain_heavy"), var_430_75)
					var_430_73.name = "2104"
					arg_427_1.var_.effect2104 = var_430_73
				else
					var_430_73.transform:SetParent(var_430_75)
				end

				var_430_73.transform.localPosition = Vector3.New(0, 0, 0)
				var_430_73.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_427_1.frameCnt_ <= 1 then
				arg_427_1.dialog_:SetActive(false)
			end

			local var_430_76 = 3.999999999999
			local var_430_77 = 0.125

			if var_430_76 < arg_427_1.time_ and arg_427_1.time_ <= var_430_76 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0

				arg_427_1.dialog_:SetActive(true)

				arg_427_1.dialogCg_.alpha = 0

				local var_430_78 = LeanTween.value(arg_427_1.dialog_, 0, 1, 0.3)

				var_430_78:setOnUpdate(LuaHelper.FloatAction(function(arg_432_0)
					arg_427_1.dialogCg_.alpha = arg_432_0
				end))
				var_430_78:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_427_1.dialog_)
					var_430_78:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_427_1.duration_ = arg_427_1.duration_ + 0.3

				SetActive(arg_427_1.leftNameGo_, true)

				local var_430_79 = arg_427_1:FormatText(StoryNameCfg[36].name)

				arg_427_1.leftNameTxt_.text = var_430_79

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, false)
				arg_427_1.callingController_:SetSelectedState("normal")

				local var_430_80 = arg_427_1:GetWordFromCfg(420012104)
				local var_430_81 = arg_427_1:FormatText(var_430_80.content)

				arg_427_1.text_.text = var_430_81

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_82 = 5
				local var_430_83 = utf8.len(var_430_81)
				local var_430_84 = var_430_82 <= 0 and var_430_77 or var_430_77 * (var_430_83 / var_430_82)

				if var_430_84 > 0 and var_430_77 < var_430_84 then
					arg_427_1.talkMaxDuration = var_430_84
					var_430_76 = var_430_76 + 0.3

					if var_430_84 + var_430_76 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_84 + var_430_76
					end
				end

				arg_427_1.text_.text = var_430_81
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012104", "story_v_out_420012.awb") ~= 0 then
					local var_430_85 = manager.audio:GetVoiceLength("story_v_out_420012", "420012104", "story_v_out_420012.awb") / 1000

					if var_430_85 + var_430_76 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_85 + var_430_76
					end

					if var_430_80.prefab_name ~= "" and arg_427_1.actors_[var_430_80.prefab_name] ~= nil then
						local var_430_86 = LuaForUtil.PlayVoiceWithCriLipsync(arg_427_1.actors_[var_430_80.prefab_name].transform, "story_v_out_420012", "420012104", "story_v_out_420012.awb")

						arg_427_1:RecordAudio("420012104", var_430_86)
						arg_427_1:RecordAudio("420012104", var_430_86)
					else
						arg_427_1:AudioAction("play", "voice", "story_v_out_420012", "420012104", "story_v_out_420012.awb")
					end

					arg_427_1:RecordHistoryTalkVoice("story_v_out_420012", "420012104", "story_v_out_420012.awb")
				end

				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_87 = var_430_76 + 0.3
			local var_430_88 = math.max(var_430_77, arg_427_1.talkMaxDuration)

			if var_430_87 <= arg_427_1.time_ and arg_427_1.time_ < var_430_87 + var_430_88 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_87) / var_430_88

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_87 + var_430_88 and arg_427_1.time_ < var_430_87 + var_430_88 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_427_1:InitPlayNodeList()
	end,
	Play420012105 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 420012105
		arg_434_1.duration_ = 8.2

		local var_434_0 = {
			zh = 6,
			ja = 8.2
		}
		local var_434_1 = manager.audio:GetLocalizationFlag()

		if var_434_0[var_434_1] ~= nil then
			arg_434_1.duration_ = var_434_0[var_434_1]
		end

		SetActive(arg_434_1.tipsGo_, false)

		function arg_434_1.onSingleLineFinish_()
			arg_434_1.onSingleLineUpdate_ = nil
			arg_434_1.onSingleLineFinish_ = nil
			arg_434_1.state_ = "waiting"
		end

		function arg_434_1.playNext_(arg_436_0)
			if arg_436_0 == 1 then
				arg_434_0:Play420012106(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			local var_437_0 = 0
			local var_437_1 = 0.45

			if var_437_0 < arg_434_1.time_ and arg_434_1.time_ <= var_437_0 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, true)

				local var_437_2 = arg_434_1:FormatText(StoryNameCfg[36].name)

				arg_434_1.leftNameTxt_.text = var_437_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_434_1.leftNameTxt_.transform)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1.leftNameTxt_.text)
				SetActive(arg_434_1.iconTrs_.gameObject, false)
				arg_434_1.callingController_:SetSelectedState("normal")

				local var_437_3 = arg_434_1:GetWordFromCfg(420012105)
				local var_437_4 = arg_434_1:FormatText(var_437_3.content)

				arg_434_1.text_.text = var_437_4

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_5 = 18
				local var_437_6 = utf8.len(var_437_4)
				local var_437_7 = var_437_5 <= 0 and var_437_1 or var_437_1 * (var_437_6 / var_437_5)

				if var_437_7 > 0 and var_437_1 < var_437_7 then
					arg_434_1.talkMaxDuration = var_437_7

					if var_437_7 + var_437_0 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_7 + var_437_0
					end
				end

				arg_434_1.text_.text = var_437_4
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012105", "story_v_out_420012.awb") ~= 0 then
					local var_437_8 = manager.audio:GetVoiceLength("story_v_out_420012", "420012105", "story_v_out_420012.awb") / 1000

					if var_437_8 + var_437_0 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_8 + var_437_0
					end

					if var_437_3.prefab_name ~= "" and arg_434_1.actors_[var_437_3.prefab_name] ~= nil then
						local var_437_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_434_1.actors_[var_437_3.prefab_name].transform, "story_v_out_420012", "420012105", "story_v_out_420012.awb")

						arg_434_1:RecordAudio("420012105", var_437_9)
						arg_434_1:RecordAudio("420012105", var_437_9)
					else
						arg_434_1:AudioAction("play", "voice", "story_v_out_420012", "420012105", "story_v_out_420012.awb")
					end

					arg_434_1:RecordHistoryTalkVoice("story_v_out_420012", "420012105", "story_v_out_420012.awb")
				end

				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_10 = math.max(var_437_1, arg_434_1.talkMaxDuration)

			if var_437_0 <= arg_434_1.time_ and arg_434_1.time_ < var_437_0 + var_437_10 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - var_437_0) / var_437_10

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= var_437_0 + var_437_10 and arg_434_1.time_ < var_437_0 + var_437_10 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {}

		arg_434_1:InitPlayNodeList()
	end,
	Play420012106 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 420012106
		arg_438_1.duration_ = 5

		SetActive(arg_438_1.tipsGo_, false)

		function arg_438_1.onSingleLineFinish_()
			arg_438_1.onSingleLineUpdate_ = nil
			arg_438_1.onSingleLineFinish_ = nil
			arg_438_1.state_ = "waiting"
		end

		function arg_438_1.playNext_(arg_440_0)
			if arg_440_0 == 1 then
				arg_438_0:Play420012107(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			local var_441_0 = arg_438_1.actors_["10025ui_story"]
			local var_441_1 = 0

			if var_441_1 < arg_438_1.time_ and arg_438_1.time_ <= var_441_1 + arg_441_0 and not isNil(var_441_0) and arg_438_1.var_.characterEffect10025ui_story == nil then
				arg_438_1.var_.characterEffect10025ui_story = var_441_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_441_2 = 0.200000002980232

			if var_441_1 <= arg_438_1.time_ and arg_438_1.time_ < var_441_1 + var_441_2 and not isNil(var_441_0) then
				local var_441_3 = (arg_438_1.time_ - var_441_1) / var_441_2

				if arg_438_1.var_.characterEffect10025ui_story and not isNil(var_441_0) then
					local var_441_4 = Mathf.Lerp(0, 0.5, var_441_3)

					arg_438_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_438_1.var_.characterEffect10025ui_story.fillRatio = var_441_4
				end
			end

			if arg_438_1.time_ >= var_441_1 + var_441_2 and arg_438_1.time_ < var_441_1 + var_441_2 + arg_441_0 and not isNil(var_441_0) and arg_438_1.var_.characterEffect10025ui_story then
				local var_441_5 = 0.5

				arg_438_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_438_1.var_.characterEffect10025ui_story.fillRatio = var_441_5
			end

			local var_441_6 = 0
			local var_441_7 = 0.05

			if var_441_6 < arg_438_1.time_ and arg_438_1.time_ <= var_441_6 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, true)

				local var_441_8 = arg_438_1:FormatText(StoryNameCfg[7].name)

				arg_438_1.leftNameTxt_.text = var_441_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_438_1.leftNameTxt_.transform)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1.leftNameTxt_.text)
				SetActive(arg_438_1.iconTrs_.gameObject, true)
				arg_438_1.iconController_:SetSelectedState("hero")

				arg_438_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_438_1.callingController_:SetSelectedState("normal")

				arg_438_1.keyicon_.color = Color.New(1, 1, 1)
				arg_438_1.icon_.color = Color.New(1, 1, 1)

				local var_441_9 = arg_438_1:GetWordFromCfg(420012106)
				local var_441_10 = arg_438_1:FormatText(var_441_9.content)

				arg_438_1.text_.text = var_441_10

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_11 = 2
				local var_441_12 = utf8.len(var_441_10)
				local var_441_13 = var_441_11 <= 0 and var_441_7 or var_441_7 * (var_441_12 / var_441_11)

				if var_441_13 > 0 and var_441_7 < var_441_13 then
					arg_438_1.talkMaxDuration = var_441_13

					if var_441_13 + var_441_6 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_13 + var_441_6
					end
				end

				arg_438_1.text_.text = var_441_10
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)
				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_14 = math.max(var_441_7, arg_438_1.talkMaxDuration)

			if var_441_6 <= arg_438_1.time_ and arg_438_1.time_ < var_441_6 + var_441_14 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - var_441_6) / var_441_14

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= var_441_6 + var_441_14 and arg_438_1.time_ < var_441_6 + var_441_14 + arg_441_0 then
				arg_438_1.typewritter.percent = 1

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(true)
			end
		end

		arg_438_1.nodeConfigList_ = {}

		arg_438_1:InitPlayNodeList()
	end,
	Play420012107 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 420012107
		arg_442_1.duration_ = 5

		SetActive(arg_442_1.tipsGo_, false)

		function arg_442_1.onSingleLineFinish_()
			arg_442_1.onSingleLineUpdate_ = nil
			arg_442_1.onSingleLineFinish_ = nil
			arg_442_1.state_ = "waiting"
		end

		function arg_442_1.playNext_(arg_444_0)
			if arg_444_0 == 1 then
				arg_442_0:Play420012108(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			local var_445_0 = 0
			local var_445_1 = 0.1

			if var_445_0 < arg_442_1.time_ and arg_442_1.time_ <= var_445_0 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0
				arg_442_1.dialogCg_.alpha = 1

				arg_442_1.dialog_:SetActive(true)
				SetActive(arg_442_1.leftNameGo_, true)

				local var_445_2 = arg_442_1:FormatText(StoryNameCfg[7].name)

				arg_442_1.leftNameTxt_.text = var_445_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_442_1.leftNameTxt_.transform)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1.leftNameTxt_.text)
				SetActive(arg_442_1.iconTrs_.gameObject, true)
				arg_442_1.iconController_:SetSelectedState("hero")

				arg_442_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_442_1.callingController_:SetSelectedState("normal")

				arg_442_1.keyicon_.color = Color.New(1, 1, 1)
				arg_442_1.icon_.color = Color.New(1, 1, 1)

				local var_445_3 = arg_442_1:GetWordFromCfg(420012107)
				local var_445_4 = arg_442_1:FormatText(var_445_3.content)

				arg_442_1.text_.text = var_445_4

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_5 = 4
				local var_445_6 = utf8.len(var_445_4)
				local var_445_7 = var_445_5 <= 0 and var_445_1 or var_445_1 * (var_445_6 / var_445_5)

				if var_445_7 > 0 and var_445_1 < var_445_7 then
					arg_442_1.talkMaxDuration = var_445_7

					if var_445_7 + var_445_0 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_7 + var_445_0
					end
				end

				arg_442_1.text_.text = var_445_4
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)
				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_8 = math.max(var_445_1, arg_442_1.talkMaxDuration)

			if var_445_0 <= arg_442_1.time_ and arg_442_1.time_ < var_445_0 + var_445_8 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - var_445_0) / var_445_8

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= var_445_0 + var_445_8 and arg_442_1.time_ < var_445_0 + var_445_8 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {}

		arg_442_1:InitPlayNodeList()
	end,
	Play420012108 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 420012108
		arg_446_1.duration_ = 9

		SetActive(arg_446_1.tipsGo_, false)

		function arg_446_1.onSingleLineFinish_()
			arg_446_1.onSingleLineUpdate_ = nil
			arg_446_1.onSingleLineFinish_ = nil
			arg_446_1.state_ = "waiting"
		end

		function arg_446_1.playNext_(arg_448_0)
			if arg_448_0 == 1 then
				arg_446_0:Play420012109(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			local var_449_0 = 2

			if var_449_0 < arg_446_1.time_ and arg_446_1.time_ <= var_449_0 + arg_449_0 then
				local var_449_1 = manager.ui.mainCamera.transform.localPosition
				local var_449_2 = Vector3.New(0, 0, 10) + Vector3.New(var_449_1.x, var_449_1.y, 0)
				local var_449_3 = arg_446_1.bgs_.ST0503

				var_449_3.transform.localPosition = var_449_2
				var_449_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_449_4 = var_449_3:GetComponent("SpriteRenderer")

				if var_449_4 and var_449_4.sprite then
					local var_449_5 = (var_449_3.transform.localPosition - var_449_1).z
					local var_449_6 = manager.ui.mainCameraCom_
					local var_449_7 = 2 * var_449_5 * Mathf.Tan(var_449_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_449_8 = var_449_7 * var_449_6.aspect
					local var_449_9 = var_449_4.sprite.bounds.size.x
					local var_449_10 = var_449_4.sprite.bounds.size.y
					local var_449_11 = var_449_8 / var_449_9
					local var_449_12 = var_449_7 / var_449_10
					local var_449_13 = var_449_12 < var_449_11 and var_449_11 or var_449_12

					var_449_3.transform.localScale = Vector3.New(var_449_13, var_449_13, 0)
				end

				for iter_449_0, iter_449_1 in pairs(arg_446_1.bgs_) do
					if iter_449_0 ~= "ST0503" then
						iter_449_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_449_14 = 4

			if var_449_14 < arg_446_1.time_ and arg_446_1.time_ <= var_449_14 + arg_449_0 then
				arg_446_1.allBtn_.enabled = false
			end

			local var_449_15 = 0.3

			if arg_446_1.time_ >= var_449_14 + var_449_15 and arg_446_1.time_ < var_449_14 + var_449_15 + arg_449_0 then
				arg_446_1.allBtn_.enabled = true
			end

			local var_449_16 = 0

			if var_449_16 < arg_446_1.time_ and arg_446_1.time_ <= var_449_16 + arg_449_0 then
				arg_446_1.mask_.enabled = true
				arg_446_1.mask_.raycastTarget = true

				arg_446_1:SetGaussion(false)
			end

			local var_449_17 = 2

			if var_449_16 <= arg_446_1.time_ and arg_446_1.time_ < var_449_16 + var_449_17 then
				local var_449_18 = (arg_446_1.time_ - var_449_16) / var_449_17
				local var_449_19 = Color.New(0, 0, 0)

				var_449_19.a = Mathf.Lerp(0, 1, var_449_18)
				arg_446_1.mask_.color = var_449_19
			end

			if arg_446_1.time_ >= var_449_16 + var_449_17 and arg_446_1.time_ < var_449_16 + var_449_17 + arg_449_0 then
				local var_449_20 = Color.New(0, 0, 0)

				var_449_20.a = 1
				arg_446_1.mask_.color = var_449_20
			end

			local var_449_21 = 2

			if var_449_21 < arg_446_1.time_ and arg_446_1.time_ <= var_449_21 + arg_449_0 then
				arg_446_1.mask_.enabled = true
				arg_446_1.mask_.raycastTarget = true

				arg_446_1:SetGaussion(false)
			end

			local var_449_22 = 2

			if var_449_21 <= arg_446_1.time_ and arg_446_1.time_ < var_449_21 + var_449_22 then
				local var_449_23 = (arg_446_1.time_ - var_449_21) / var_449_22
				local var_449_24 = Color.New(0, 0, 0)

				var_449_24.a = Mathf.Lerp(1, 0, var_449_23)
				arg_446_1.mask_.color = var_449_24
			end

			if arg_446_1.time_ >= var_449_21 + var_449_22 and arg_446_1.time_ < var_449_21 + var_449_22 + arg_449_0 then
				local var_449_25 = Color.New(0, 0, 0)
				local var_449_26 = 0

				arg_446_1.mask_.enabled = false
				var_449_25.a = var_449_26
				arg_446_1.mask_.color = var_449_25
			end

			local var_449_27 = 0
			local var_449_28 = 0.2

			if var_449_27 < arg_446_1.time_ and arg_446_1.time_ <= var_449_27 + arg_449_0 then
				local var_449_29 = "play"
				local var_449_30 = "music"

				arg_446_1:AudioAction(var_449_29, var_449_30, "ui_battle", "ui_battle_stopbgm", "")

				local var_449_31 = ""
				local var_449_32 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_449_32 ~= "" then
					if arg_446_1.bgmTxt_.text ~= var_449_32 and arg_446_1.bgmTxt_.text ~= "" then
						if arg_446_1.bgmTxt2_.text ~= "" then
							arg_446_1.bgmTxt_.text = arg_446_1.bgmTxt2_.text
						end

						arg_446_1.bgmTxt2_.text = var_449_32

						arg_446_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_446_1.bgmTxt_.text = var_449_32
						arg_446_1.bgmTxt2_.text = var_449_32
					end

					if arg_446_1.bgmTimer then
						arg_446_1.bgmTimer:Stop()

						arg_446_1.bgmTimer = nil
					end

					if arg_446_1.settingData.show_music_name == 1 then
						arg_446_1.musicController:SetSelectedState("show")
						arg_446_1.musicAnimator_:Play("open", 0, 0)

						if arg_446_1.settingData.music_time ~= 0 then
							arg_446_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_446_1.settingData.music_time), function()
								if arg_446_1 == nil or isNil(arg_446_1.bgmTxt_) then
									return
								end

								arg_446_1.musicController:SetSelectedState("hide")
								arg_446_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_449_33 = 2
			local var_449_34 = 1

			if var_449_33 < arg_446_1.time_ and arg_446_1.time_ <= var_449_33 + arg_449_0 then
				local var_449_35 = "play"
				local var_449_36 = "music"

				arg_446_1:AudioAction(var_449_35, var_449_36, "bgm_activity_4_0_story_daily", "bgm_activity_4_0_story_daily", "bgm_activity_4_0_story_daily.awb")

				local var_449_37 = ""
				local var_449_38 = manager.audio:GetAudioName("bgm_activity_4_0_story_daily", "bgm_activity_4_0_story_daily")

				if var_449_38 ~= "" then
					if arg_446_1.bgmTxt_.text ~= var_449_38 and arg_446_1.bgmTxt_.text ~= "" then
						if arg_446_1.bgmTxt2_.text ~= "" then
							arg_446_1.bgmTxt_.text = arg_446_1.bgmTxt2_.text
						end

						arg_446_1.bgmTxt2_.text = var_449_38

						arg_446_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_446_1.bgmTxt_.text = var_449_38
						arg_446_1.bgmTxt2_.text = var_449_38
					end

					if arg_446_1.bgmTimer then
						arg_446_1.bgmTimer:Stop()

						arg_446_1.bgmTimer = nil
					end

					if arg_446_1.settingData.show_music_name == 1 then
						arg_446_1.musicController:SetSelectedState("show")
						arg_446_1.musicAnimator_:Play("open", 0, 0)

						if arg_446_1.settingData.music_time ~= 0 then
							arg_446_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_446_1.settingData.music_time), function()
								if arg_446_1 == nil or isNil(arg_446_1.bgmTxt_) then
									return
								end

								arg_446_1.musicController:SetSelectedState("hide")
								arg_446_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_449_39 = 0.433333333333333
			local var_449_40 = 1

			if var_449_39 < arg_446_1.time_ and arg_446_1.time_ <= var_449_39 + arg_449_0 then
				local var_449_41 = "stop"
				local var_449_42 = "effect"

				arg_446_1:AudioAction(var_449_41, var_449_42, "se_story_140", "se_story_140_amb_rainthunder", "")
			end

			local var_449_43 = 2
			local var_449_44 = 1

			if var_449_43 < arg_446_1.time_ and arg_446_1.time_ <= var_449_43 + arg_449_0 then
				local var_449_45 = "play"
				local var_449_46 = "effect"

				arg_446_1:AudioAction(var_449_45, var_449_46, "se_story_140", "se_story_140_amb_street01", "")
			end

			local var_449_47 = 1.93333333333333

			arg_446_1.isInRecall_ = false

			if var_449_47 < arg_446_1.time_ and arg_446_1.time_ <= var_449_47 + arg_449_0 then
				arg_446_1.screenFilterGo_:SetActive(false)

				for iter_449_2, iter_449_3 in pairs(arg_446_1.actors_) do
					local var_449_48 = iter_449_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_449_4, iter_449_5 in ipairs(var_449_48) do
						if iter_449_5.color.r > 0.51 then
							iter_449_5.color = Color.New(1, 1, 1)
						else
							iter_449_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_449_49 = 0.0666666666666667

			if var_449_47 <= arg_446_1.time_ and arg_446_1.time_ < var_449_47 + var_449_49 then
				local var_449_50 = (arg_446_1.time_ - var_449_47) / var_449_49

				arg_446_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_449_50)
			end

			if arg_446_1.time_ >= var_449_47 + var_449_49 and arg_446_1.time_ < var_449_47 + var_449_49 + arg_449_0 then
				arg_446_1.screenFilterEffect_.weight = 0
			end

			local var_449_51 = "1061ui_story"

			if arg_446_1.actors_[var_449_51] == nil then
				local var_449_52 = Asset.Load("Char/" .. "1061ui_story")

				if not isNil(var_449_52) then
					local var_449_53 = Object.Instantiate(Asset.Load("Char/" .. "1061ui_story"), arg_446_1.stage_.transform)

					var_449_53.name = var_449_51
					var_449_53.transform.localPosition = Vector3.New(0, 100, 0)
					arg_446_1.actors_[var_449_51] = var_449_53

					local var_449_54 = var_449_53:GetComponentInChildren(typeof(CharacterEffect))

					var_449_54.enabled = true

					local var_449_55 = GameObjectTools.GetOrAddComponent(var_449_53, typeof(DynamicBoneHelper))

					if var_449_55 then
						var_449_55:EnableDynamicBone(false)
					end

					arg_446_1:ShowWeapon(var_449_54.transform, false)

					arg_446_1.var_[var_449_51 .. "Animator"] = var_449_54.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_446_1.var_[var_449_51 .. "Animator"].applyRootMotion = true
					arg_446_1.var_[var_449_51 .. "LipSync"] = var_449_54.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_449_56 = 2

			if var_449_56 < arg_446_1.time_ and arg_446_1.time_ <= var_449_56 + arg_449_0 then
				arg_446_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_449_57 = manager.ui.mainCamera.transform
			local var_449_58 = 1.93333333333333

			if var_449_58 < arg_446_1.time_ and arg_446_1.time_ <= var_449_58 + arg_449_0 then
				local var_449_59 = arg_446_1.var_.effect2104

				if var_449_59 then
					Object.Destroy(var_449_59)

					arg_446_1.var_.effect2104 = nil
				end
			end

			local var_449_60 = arg_446_1.actors_["10025ui_story"].transform
			local var_449_61 = 1.96599999815226

			if var_449_61 < arg_446_1.time_ and arg_446_1.time_ <= var_449_61 + arg_449_0 then
				arg_446_1.var_.moveOldPos10025ui_story = var_449_60.localPosition
			end

			local var_449_62 = 0.001

			if var_449_61 <= arg_446_1.time_ and arg_446_1.time_ < var_449_61 + var_449_62 then
				local var_449_63 = (arg_446_1.time_ - var_449_61) / var_449_62
				local var_449_64 = Vector3.New(0, 100, 0)

				var_449_60.localPosition = Vector3.Lerp(arg_446_1.var_.moveOldPos10025ui_story, var_449_64, var_449_63)

				local var_449_65 = manager.ui.mainCamera.transform.position - var_449_60.position

				var_449_60.forward = Vector3.New(var_449_65.x, var_449_65.y, var_449_65.z)

				local var_449_66 = var_449_60.localEulerAngles

				var_449_66.z = 0
				var_449_66.x = 0
				var_449_60.localEulerAngles = var_449_66
			end

			if arg_446_1.time_ >= var_449_61 + var_449_62 and arg_446_1.time_ < var_449_61 + var_449_62 + arg_449_0 then
				var_449_60.localPosition = Vector3.New(0, 100, 0)

				local var_449_67 = manager.ui.mainCamera.transform.position - var_449_60.position

				var_449_60.forward = Vector3.New(var_449_67.x, var_449_67.y, var_449_67.z)

				local var_449_68 = var_449_60.localEulerAngles

				var_449_68.z = 0
				var_449_68.x = 0
				var_449_60.localEulerAngles = var_449_68
			end

			if arg_446_1.frameCnt_ <= 1 then
				arg_446_1.dialog_:SetActive(false)
			end

			local var_449_69 = 4
			local var_449_70 = 0.9

			if var_449_69 < arg_446_1.time_ and arg_446_1.time_ <= var_449_69 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0

				arg_446_1.dialog_:SetActive(true)

				arg_446_1.dialogCg_.alpha = 0

				local var_449_71 = LeanTween.value(arg_446_1.dialog_, 0, 1, 0.3)

				var_449_71:setOnUpdate(LuaHelper.FloatAction(function(arg_452_0)
					arg_446_1.dialogCg_.alpha = arg_452_0
				end))
				var_449_71:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_446_1.dialog_)
					var_449_71:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_446_1.duration_ = arg_446_1.duration_ + 0.3

				SetActive(arg_446_1.leftNameGo_, false)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_446_1.iconTrs_.gameObject, false)
				arg_446_1.callingController_:SetSelectedState("normal")

				local var_449_72 = arg_446_1:GetWordFromCfg(420012108)
				local var_449_73 = arg_446_1:FormatText(var_449_72.content)

				arg_446_1.text_.text = var_449_73

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_74 = 36
				local var_449_75 = utf8.len(var_449_73)
				local var_449_76 = var_449_74 <= 0 and var_449_70 or var_449_70 * (var_449_75 / var_449_74)

				if var_449_76 > 0 and var_449_70 < var_449_76 then
					arg_446_1.talkMaxDuration = var_449_76
					var_449_69 = var_449_69 + 0.3

					if var_449_76 + var_449_69 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_76 + var_449_69
					end
				end

				arg_446_1.text_.text = var_449_73
				arg_446_1.typewritter.percent = 0

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(false)
				arg_446_1:RecordContent(arg_446_1.text_.text)
			end

			local var_449_77 = var_449_69 + 0.3
			local var_449_78 = math.max(var_449_70, arg_446_1.talkMaxDuration)

			if var_449_77 <= arg_446_1.time_ and arg_446_1.time_ < var_449_77 + var_449_78 then
				arg_446_1.typewritter.percent = (arg_446_1.time_ - var_449_77) / var_449_78

				arg_446_1.typewritter:SetDirty()
			end

			if arg_446_1.time_ >= var_449_77 + var_449_78 and arg_446_1.time_ < var_449_77 + var_449_78 + arg_449_0 then
				arg_446_1.typewritter.percent = 1

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(true)
			end
		end

		arg_446_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_446_1:InitPlayNodeList()
	end,
	Play420012109 = function(arg_454_0, arg_454_1)
		arg_454_1.time_ = 0
		arg_454_1.frameCnt_ = 0
		arg_454_1.state_ = "playing"
		arg_454_1.curTalkId_ = 420012109
		arg_454_1.duration_ = 5

		SetActive(arg_454_1.tipsGo_, false)

		function arg_454_1.onSingleLineFinish_()
			arg_454_1.onSingleLineUpdate_ = nil
			arg_454_1.onSingleLineFinish_ = nil
			arg_454_1.state_ = "waiting"
		end

		function arg_454_1.playNext_(arg_456_0)
			if arg_456_0 == 1 then
				arg_454_0:Play420012110(arg_454_1)
			end
		end

		function arg_454_1.onSingleLineUpdate_(arg_457_0)
			local var_457_0 = 0
			local var_457_1 = 1.675

			if var_457_0 < arg_454_1.time_ and arg_454_1.time_ <= var_457_0 + arg_457_0 then
				arg_454_1.talkMaxDuration = 0
				arg_454_1.dialogCg_.alpha = 1

				arg_454_1.dialog_:SetActive(true)
				SetActive(arg_454_1.leftNameGo_, false)

				arg_454_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_454_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_454_1:RecordName(arg_454_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_454_1.iconTrs_.gameObject, false)
				arg_454_1.callingController_:SetSelectedState("normal")

				local var_457_2 = arg_454_1:GetWordFromCfg(420012109)
				local var_457_3 = arg_454_1:FormatText(var_457_2.content)

				arg_454_1.text_.text = var_457_3

				LuaForUtil.ClearLinePrefixSymbol(arg_454_1.text_)

				local var_457_4 = 67
				local var_457_5 = utf8.len(var_457_3)
				local var_457_6 = var_457_4 <= 0 and var_457_1 or var_457_1 * (var_457_5 / var_457_4)

				if var_457_6 > 0 and var_457_1 < var_457_6 then
					arg_454_1.talkMaxDuration = var_457_6

					if var_457_6 + var_457_0 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_6 + var_457_0
					end
				end

				arg_454_1.text_.text = var_457_3
				arg_454_1.typewritter.percent = 0

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(false)
				arg_454_1:RecordContent(arg_454_1.text_.text)
			end

			local var_457_7 = math.max(var_457_1, arg_454_1.talkMaxDuration)

			if var_457_0 <= arg_454_1.time_ and arg_454_1.time_ < var_457_0 + var_457_7 then
				arg_454_1.typewritter.percent = (arg_454_1.time_ - var_457_0) / var_457_7

				arg_454_1.typewritter:SetDirty()
			end

			if arg_454_1.time_ >= var_457_0 + var_457_7 and arg_454_1.time_ < var_457_0 + var_457_7 + arg_457_0 then
				arg_454_1.typewritter.percent = 1

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(true)
			end
		end

		arg_454_1.nodeConfigList_ = {}

		arg_454_1:InitPlayNodeList()
	end,
	Play420012110 = function(arg_458_0, arg_458_1)
		arg_458_1.time_ = 0
		arg_458_1.frameCnt_ = 0
		arg_458_1.state_ = "playing"
		arg_458_1.curTalkId_ = 420012110
		arg_458_1.duration_ = 1

		SetActive(arg_458_1.tipsGo_, false)

		function arg_458_1.onSingleLineFinish_()
			arg_458_1.onSingleLineUpdate_ = nil
			arg_458_1.onSingleLineFinish_ = nil
			arg_458_1.state_ = "waiting"

			SetActive(arg_458_1.choicesGo_, true)

			for iter_459_0, iter_459_1 in ipairs(arg_458_1.choices_) do
				local var_459_0 = iter_459_0 <= 1

				SetActive(iter_459_1.go, var_459_0)
			end

			arg_458_1.choices_[1].txt.text = arg_458_1:FormatText(StoryChoiceCfg[1215].name)
		end

		function arg_458_1.playNext_(arg_460_0)
			if arg_460_0 == 1 then
				arg_458_0:Play420012111(arg_458_1)
			end

			arg_458_1:RecordChoiceLog(420012110, 1215)
		end

		function arg_458_1.onSingleLineUpdate_(arg_461_0)
			return
		end

		arg_458_1.nodeConfigList_ = {}

		arg_458_1:InitPlayNodeList()
	end,
	Play420012111 = function(arg_462_0, arg_462_1)
		arg_462_1.time_ = 0
		arg_462_1.frameCnt_ = 0
		arg_462_1.state_ = "playing"
		arg_462_1.curTalkId_ = 420012111
		arg_462_1.duration_ = 2

		SetActive(arg_462_1.tipsGo_, false)

		function arg_462_1.onSingleLineFinish_()
			arg_462_1.onSingleLineUpdate_ = nil
			arg_462_1.onSingleLineFinish_ = nil
			arg_462_1.state_ = "waiting"
		end

		function arg_462_1.playNext_(arg_464_0)
			if arg_464_0 == 1 then
				arg_462_0:Play420012112(arg_462_1)
			end
		end

		function arg_462_1.onSingleLineUpdate_(arg_465_0)
			local var_465_0 = arg_462_1.actors_["1085ui_story"].transform
			local var_465_1 = 0

			if var_465_1 < arg_462_1.time_ and arg_462_1.time_ <= var_465_1 + arg_465_0 then
				arg_462_1.var_.moveOldPos1085ui_story = var_465_0.localPosition
			end

			local var_465_2 = 0.001

			if var_465_1 <= arg_462_1.time_ and arg_462_1.time_ < var_465_1 + var_465_2 then
				local var_465_3 = (arg_462_1.time_ - var_465_1) / var_465_2
				local var_465_4 = Vector3.New(0, -1.01, -5.83)

				var_465_0.localPosition = Vector3.Lerp(arg_462_1.var_.moveOldPos1085ui_story, var_465_4, var_465_3)

				local var_465_5 = manager.ui.mainCamera.transform.position - var_465_0.position

				var_465_0.forward = Vector3.New(var_465_5.x, var_465_5.y, var_465_5.z)

				local var_465_6 = var_465_0.localEulerAngles

				var_465_6.z = 0
				var_465_6.x = 0
				var_465_0.localEulerAngles = var_465_6
			end

			if arg_462_1.time_ >= var_465_1 + var_465_2 and arg_462_1.time_ < var_465_1 + var_465_2 + arg_465_0 then
				var_465_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_465_7 = manager.ui.mainCamera.transform.position - var_465_0.position

				var_465_0.forward = Vector3.New(var_465_7.x, var_465_7.y, var_465_7.z)

				local var_465_8 = var_465_0.localEulerAngles

				var_465_8.z = 0
				var_465_8.x = 0
				var_465_0.localEulerAngles = var_465_8
			end

			local var_465_9 = arg_462_1.actors_["1085ui_story"]
			local var_465_10 = 0

			if var_465_10 < arg_462_1.time_ and arg_462_1.time_ <= var_465_10 + arg_465_0 and not isNil(var_465_9) and arg_462_1.var_.characterEffect1085ui_story == nil then
				arg_462_1.var_.characterEffect1085ui_story = var_465_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_465_11 = 0.200000002980232

			if var_465_10 <= arg_462_1.time_ and arg_462_1.time_ < var_465_10 + var_465_11 and not isNil(var_465_9) then
				local var_465_12 = (arg_462_1.time_ - var_465_10) / var_465_11

				if arg_462_1.var_.characterEffect1085ui_story and not isNil(var_465_9) then
					arg_462_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_462_1.time_ >= var_465_10 + var_465_11 and arg_462_1.time_ < var_465_10 + var_465_11 + arg_465_0 and not isNil(var_465_9) and arg_462_1.var_.characterEffect1085ui_story then
				arg_462_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_465_13 = 0

			if var_465_13 < arg_462_1.time_ and arg_462_1.time_ <= var_465_13 + arg_465_0 then
				arg_462_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_465_14 = 0
			local var_465_15 = 0.0329999998211861

			if var_465_14 < arg_462_1.time_ and arg_462_1.time_ <= var_465_14 + arg_465_0 then
				arg_462_1.talkMaxDuration = 0
				arg_462_1.dialogCg_.alpha = 1

				arg_462_1.dialog_:SetActive(true)
				SetActive(arg_462_1.leftNameGo_, true)

				local var_465_16 = arg_462_1:FormatText(StoryNameCfg[328].name)

				arg_462_1.leftNameTxt_.text = var_465_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_462_1.leftNameTxt_.transform)

				arg_462_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_462_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_462_1:RecordName(arg_462_1.leftNameTxt_.text)
				SetActive(arg_462_1.iconTrs_.gameObject, false)
				arg_462_1.callingController_:SetSelectedState("normal")

				local var_465_17 = arg_462_1:GetWordFromCfg(420012111)
				local var_465_18 = arg_462_1:FormatText(var_465_17.content)

				arg_462_1.text_.text = var_465_18

				LuaForUtil.ClearLinePrefixSymbol(arg_462_1.text_)

				local var_465_19 = 1
				local var_465_20 = utf8.len(var_465_18)
				local var_465_21 = var_465_19 <= 0 and var_465_15 or var_465_15 * (var_465_20 / var_465_19)

				if var_465_21 > 0 and var_465_15 < var_465_21 then
					arg_462_1.talkMaxDuration = var_465_21

					if var_465_21 + var_465_14 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_21 + var_465_14
					end
				end

				arg_462_1.text_.text = var_465_18
				arg_462_1.typewritter.percent = 0

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012111", "story_v_out_420012.awb") ~= 0 then
					local var_465_22 = manager.audio:GetVoiceLength("story_v_out_420012", "420012111", "story_v_out_420012.awb") / 1000

					if var_465_22 + var_465_14 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_22 + var_465_14
					end

					if var_465_17.prefab_name ~= "" and arg_462_1.actors_[var_465_17.prefab_name] ~= nil then
						local var_465_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_462_1.actors_[var_465_17.prefab_name].transform, "story_v_out_420012", "420012111", "story_v_out_420012.awb")

						arg_462_1:RecordAudio("420012111", var_465_23)
						arg_462_1:RecordAudio("420012111", var_465_23)
					else
						arg_462_1:AudioAction("play", "voice", "story_v_out_420012", "420012111", "story_v_out_420012.awb")
					end

					arg_462_1:RecordHistoryTalkVoice("story_v_out_420012", "420012111", "story_v_out_420012.awb")
				end

				arg_462_1:RecordContent(arg_462_1.text_.text)
			end

			local var_465_24 = math.max(var_465_15, arg_462_1.talkMaxDuration)

			if var_465_14 <= arg_462_1.time_ and arg_462_1.time_ < var_465_14 + var_465_24 then
				arg_462_1.typewritter.percent = (arg_462_1.time_ - var_465_14) / var_465_24

				arg_462_1.typewritter:SetDirty()
			end

			if arg_462_1.time_ >= var_465_14 + var_465_24 and arg_462_1.time_ < var_465_14 + var_465_24 + arg_465_0 then
				arg_462_1.typewritter.percent = 1

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(true)
			end
		end

		arg_462_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_462_1:InitPlayNodeList()
	end,
	Play420012112 = function(arg_466_0, arg_466_1)
		arg_466_1.time_ = 0
		arg_466_1.frameCnt_ = 0
		arg_466_1.state_ = "playing"
		arg_466_1.curTalkId_ = 420012112
		arg_466_1.duration_ = 5

		SetActive(arg_466_1.tipsGo_, false)

		function arg_466_1.onSingleLineFinish_()
			arg_466_1.onSingleLineUpdate_ = nil
			arg_466_1.onSingleLineFinish_ = nil
			arg_466_1.state_ = "waiting"
		end

		function arg_466_1.playNext_(arg_468_0)
			if arg_468_0 == 1 then
				arg_466_0:Play420012113(arg_466_1)
			end
		end

		function arg_466_1.onSingleLineUpdate_(arg_469_0)
			local var_469_0 = arg_466_1.actors_["1085ui_story"].transform
			local var_469_1 = 0

			if var_469_1 < arg_466_1.time_ and arg_466_1.time_ <= var_469_1 + arg_469_0 then
				arg_466_1.var_.moveOldPos1085ui_story = var_469_0.localPosition
			end

			local var_469_2 = 0.001

			if var_469_1 <= arg_466_1.time_ and arg_466_1.time_ < var_469_1 + var_469_2 then
				local var_469_3 = (arg_466_1.time_ - var_469_1) / var_469_2
				local var_469_4 = Vector3.New(0, 100, 0)

				var_469_0.localPosition = Vector3.Lerp(arg_466_1.var_.moveOldPos1085ui_story, var_469_4, var_469_3)

				local var_469_5 = manager.ui.mainCamera.transform.position - var_469_0.position

				var_469_0.forward = Vector3.New(var_469_5.x, var_469_5.y, var_469_5.z)

				local var_469_6 = var_469_0.localEulerAngles

				var_469_6.z = 0
				var_469_6.x = 0
				var_469_0.localEulerAngles = var_469_6
			end

			if arg_466_1.time_ >= var_469_1 + var_469_2 and arg_466_1.time_ < var_469_1 + var_469_2 + arg_469_0 then
				var_469_0.localPosition = Vector3.New(0, 100, 0)

				local var_469_7 = manager.ui.mainCamera.transform.position - var_469_0.position

				var_469_0.forward = Vector3.New(var_469_7.x, var_469_7.y, var_469_7.z)

				local var_469_8 = var_469_0.localEulerAngles

				var_469_8.z = 0
				var_469_8.x = 0
				var_469_0.localEulerAngles = var_469_8
			end

			local var_469_9 = 0
			local var_469_10 = 1.65

			if var_469_9 < arg_466_1.time_ and arg_466_1.time_ <= var_469_9 + arg_469_0 then
				arg_466_1.talkMaxDuration = 0
				arg_466_1.dialogCg_.alpha = 1

				arg_466_1.dialog_:SetActive(true)
				SetActive(arg_466_1.leftNameGo_, false)

				arg_466_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_466_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_466_1:RecordName(arg_466_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_466_1.iconTrs_.gameObject, false)
				arg_466_1.callingController_:SetSelectedState("normal")

				local var_469_11 = arg_466_1:GetWordFromCfg(420012112)
				local var_469_12 = arg_466_1:FormatText(var_469_11.content)

				arg_466_1.text_.text = var_469_12

				LuaForUtil.ClearLinePrefixSymbol(arg_466_1.text_)

				local var_469_13 = 66
				local var_469_14 = utf8.len(var_469_12)
				local var_469_15 = var_469_13 <= 0 and var_469_10 or var_469_10 * (var_469_14 / var_469_13)

				if var_469_15 > 0 and var_469_10 < var_469_15 then
					arg_466_1.talkMaxDuration = var_469_15

					if var_469_15 + var_469_9 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_15 + var_469_9
					end
				end

				arg_466_1.text_.text = var_469_12
				arg_466_1.typewritter.percent = 0

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(false)
				arg_466_1:RecordContent(arg_466_1.text_.text)
			end

			local var_469_16 = math.max(var_469_10, arg_466_1.talkMaxDuration)

			if var_469_9 <= arg_466_1.time_ and arg_466_1.time_ < var_469_9 + var_469_16 then
				arg_466_1.typewritter.percent = (arg_466_1.time_ - var_469_9) / var_469_16

				arg_466_1.typewritter:SetDirty()
			end

			if arg_466_1.time_ >= var_469_9 + var_469_16 and arg_466_1.time_ < var_469_9 + var_469_16 + arg_469_0 then
				arg_466_1.typewritter.percent = 1

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(true)
			end
		end

		arg_466_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_466_1:InitPlayNodeList()
	end,
	Play420012113 = function(arg_470_0, arg_470_1)
		arg_470_1.time_ = 0
		arg_470_1.frameCnt_ = 0
		arg_470_1.state_ = "playing"
		arg_470_1.curTalkId_ = 420012113
		arg_470_1.duration_ = 5

		SetActive(arg_470_1.tipsGo_, false)

		function arg_470_1.onSingleLineFinish_()
			arg_470_1.onSingleLineUpdate_ = nil
			arg_470_1.onSingleLineFinish_ = nil
			arg_470_1.state_ = "waiting"
		end

		function arg_470_1.playNext_(arg_472_0)
			if arg_472_0 == 1 then
				arg_470_0:Play420012114(arg_470_1)
			end
		end

		function arg_470_1.onSingleLineUpdate_(arg_473_0)
			local var_473_0 = 0
			local var_473_1 = 1.7

			if var_473_0 < arg_470_1.time_ and arg_470_1.time_ <= var_473_0 + arg_473_0 then
				arg_470_1.talkMaxDuration = 0
				arg_470_1.dialogCg_.alpha = 1

				arg_470_1.dialog_:SetActive(true)
				SetActive(arg_470_1.leftNameGo_, false)

				arg_470_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_470_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_470_1:RecordName(arg_470_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_470_1.iconTrs_.gameObject, false)
				arg_470_1.callingController_:SetSelectedState("normal")

				local var_473_2 = arg_470_1:GetWordFromCfg(420012113)
				local var_473_3 = arg_470_1:FormatText(var_473_2.content)

				arg_470_1.text_.text = var_473_3

				LuaForUtil.ClearLinePrefixSymbol(arg_470_1.text_)

				local var_473_4 = 68
				local var_473_5 = utf8.len(var_473_3)
				local var_473_6 = var_473_4 <= 0 and var_473_1 or var_473_1 * (var_473_5 / var_473_4)

				if var_473_6 > 0 and var_473_1 < var_473_6 then
					arg_470_1.talkMaxDuration = var_473_6

					if var_473_6 + var_473_0 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_6 + var_473_0
					end
				end

				arg_470_1.text_.text = var_473_3
				arg_470_1.typewritter.percent = 0

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(false)
				arg_470_1:RecordContent(arg_470_1.text_.text)
			end

			local var_473_7 = math.max(var_473_1, arg_470_1.talkMaxDuration)

			if var_473_0 <= arg_470_1.time_ and arg_470_1.time_ < var_473_0 + var_473_7 then
				arg_470_1.typewritter.percent = (arg_470_1.time_ - var_473_0) / var_473_7

				arg_470_1.typewritter:SetDirty()
			end

			if arg_470_1.time_ >= var_473_0 + var_473_7 and arg_470_1.time_ < var_473_0 + var_473_7 + arg_473_0 then
				arg_470_1.typewritter.percent = 1

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(true)
			end
		end

		arg_470_1.nodeConfigList_ = {}

		arg_470_1:InitPlayNodeList()
	end,
	Play420012114 = function(arg_474_0, arg_474_1)
		arg_474_1.time_ = 0
		arg_474_1.frameCnt_ = 0
		arg_474_1.state_ = "playing"
		arg_474_1.curTalkId_ = 420012114
		arg_474_1.duration_ = 5.7

		local var_474_0 = {
			zh = 4.033,
			ja = 5.7
		}
		local var_474_1 = manager.audio:GetLocalizationFlag()

		if var_474_0[var_474_1] ~= nil then
			arg_474_1.duration_ = var_474_0[var_474_1]
		end

		SetActive(arg_474_1.tipsGo_, false)

		function arg_474_1.onSingleLineFinish_()
			arg_474_1.onSingleLineUpdate_ = nil
			arg_474_1.onSingleLineFinish_ = nil
			arg_474_1.state_ = "waiting"
		end

		function arg_474_1.playNext_(arg_476_0)
			if arg_476_0 == 1 then
				arg_474_0:Play420012115(arg_474_1)
			end
		end

		function arg_474_1.onSingleLineUpdate_(arg_477_0)
			local var_477_0 = 0
			local var_477_1 = 0.475

			if var_477_0 < arg_474_1.time_ and arg_474_1.time_ <= var_477_0 + arg_477_0 then
				arg_474_1.talkMaxDuration = 0
				arg_474_1.dialogCg_.alpha = 1

				arg_474_1.dialog_:SetActive(true)
				SetActive(arg_474_1.leftNameGo_, true)

				local var_477_2 = arg_474_1:FormatText(StoryNameCfg[1157].name)

				arg_474_1.leftNameTxt_.text = var_477_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_474_1.leftNameTxt_.transform)

				arg_474_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_474_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_474_1:RecordName(arg_474_1.leftNameTxt_.text)
				SetActive(arg_474_1.iconTrs_.gameObject, true)
				arg_474_1.iconController_:SetSelectedState("hero")

				arg_474_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzab")

				arg_474_1.callingController_:SetSelectedState("normal")

				arg_474_1.keyicon_.color = Color.New(1, 1, 1)
				arg_474_1.icon_.color = Color.New(1, 1, 1)

				local var_477_3 = arg_474_1:GetWordFromCfg(420012114)
				local var_477_4 = arg_474_1:FormatText(var_477_3.content)

				arg_474_1.text_.text = var_477_4

				LuaForUtil.ClearLinePrefixSymbol(arg_474_1.text_)

				local var_477_5 = 19
				local var_477_6 = utf8.len(var_477_4)
				local var_477_7 = var_477_5 <= 0 and var_477_1 or var_477_1 * (var_477_6 / var_477_5)

				if var_477_7 > 0 and var_477_1 < var_477_7 then
					arg_474_1.talkMaxDuration = var_477_7

					if var_477_7 + var_477_0 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_7 + var_477_0
					end
				end

				arg_474_1.text_.text = var_477_4
				arg_474_1.typewritter.percent = 0

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012114", "story_v_out_420012.awb") ~= 0 then
					local var_477_8 = manager.audio:GetVoiceLength("story_v_out_420012", "420012114", "story_v_out_420012.awb") / 1000

					if var_477_8 + var_477_0 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_8 + var_477_0
					end

					if var_477_3.prefab_name ~= "" and arg_474_1.actors_[var_477_3.prefab_name] ~= nil then
						local var_477_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_474_1.actors_[var_477_3.prefab_name].transform, "story_v_out_420012", "420012114", "story_v_out_420012.awb")

						arg_474_1:RecordAudio("420012114", var_477_9)
						arg_474_1:RecordAudio("420012114", var_477_9)
					else
						arg_474_1:AudioAction("play", "voice", "story_v_out_420012", "420012114", "story_v_out_420012.awb")
					end

					arg_474_1:RecordHistoryTalkVoice("story_v_out_420012", "420012114", "story_v_out_420012.awb")
				end

				arg_474_1:RecordContent(arg_474_1.text_.text)
			end

			local var_477_10 = math.max(var_477_1, arg_474_1.talkMaxDuration)

			if var_477_0 <= arg_474_1.time_ and arg_474_1.time_ < var_477_0 + var_477_10 then
				arg_474_1.typewritter.percent = (arg_474_1.time_ - var_477_0) / var_477_10

				arg_474_1.typewritter:SetDirty()
			end

			if arg_474_1.time_ >= var_477_0 + var_477_10 and arg_474_1.time_ < var_477_0 + var_477_10 + arg_477_0 then
				arg_474_1.typewritter.percent = 1

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(true)
			end
		end

		arg_474_1.nodeConfigList_ = {}

		arg_474_1:InitPlayNodeList()
	end,
	Play420012115 = function(arg_478_0, arg_478_1)
		arg_478_1.time_ = 0
		arg_478_1.frameCnt_ = 0
		arg_478_1.state_ = "playing"
		arg_478_1.curTalkId_ = 420012115
		arg_478_1.duration_ = 5

		SetActive(arg_478_1.tipsGo_, false)

		function arg_478_1.onSingleLineFinish_()
			arg_478_1.onSingleLineUpdate_ = nil
			arg_478_1.onSingleLineFinish_ = nil
			arg_478_1.state_ = "waiting"
		end

		function arg_478_1.playNext_(arg_480_0)
			if arg_480_0 == 1 then
				arg_478_0:Play420012116(arg_478_1)
			end
		end

		function arg_478_1.onSingleLineUpdate_(arg_481_0)
			local var_481_0 = 0
			local var_481_1 = 1.2

			if var_481_0 < arg_478_1.time_ and arg_478_1.time_ <= var_481_0 + arg_481_0 then
				arg_478_1.talkMaxDuration = 0
				arg_478_1.dialogCg_.alpha = 1

				arg_478_1.dialog_:SetActive(true)
				SetActive(arg_478_1.leftNameGo_, true)

				local var_481_2 = arg_478_1:FormatText(StoryNameCfg[7].name)

				arg_478_1.leftNameTxt_.text = var_481_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_478_1.leftNameTxt_.transform)

				arg_478_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_478_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_478_1:RecordName(arg_478_1.leftNameTxt_.text)
				SetActive(arg_478_1.iconTrs_.gameObject, true)
				arg_478_1.iconController_:SetSelectedState("hero")

				arg_478_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_478_1.callingController_:SetSelectedState("normal")

				arg_478_1.keyicon_.color = Color.New(1, 1, 1)
				arg_478_1.icon_.color = Color.New(1, 1, 1)

				local var_481_3 = arg_478_1:GetWordFromCfg(420012115)
				local var_481_4 = arg_478_1:FormatText(var_481_3.content)

				arg_478_1.text_.text = var_481_4

				LuaForUtil.ClearLinePrefixSymbol(arg_478_1.text_)

				local var_481_5 = 48
				local var_481_6 = utf8.len(var_481_4)
				local var_481_7 = var_481_5 <= 0 and var_481_1 or var_481_1 * (var_481_6 / var_481_5)

				if var_481_7 > 0 and var_481_1 < var_481_7 then
					arg_478_1.talkMaxDuration = var_481_7

					if var_481_7 + var_481_0 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_7 + var_481_0
					end
				end

				arg_478_1.text_.text = var_481_4
				arg_478_1.typewritter.percent = 0

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(false)
				arg_478_1:RecordContent(arg_478_1.text_.text)
			end

			local var_481_8 = math.max(var_481_1, arg_478_1.talkMaxDuration)

			if var_481_0 <= arg_478_1.time_ and arg_478_1.time_ < var_481_0 + var_481_8 then
				arg_478_1.typewritter.percent = (arg_478_1.time_ - var_481_0) / var_481_8

				arg_478_1.typewritter:SetDirty()
			end

			if arg_478_1.time_ >= var_481_0 + var_481_8 and arg_478_1.time_ < var_481_0 + var_481_8 + arg_481_0 then
				arg_478_1.typewritter.percent = 1

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(true)
			end
		end

		arg_478_1.nodeConfigList_ = {}

		arg_478_1:InitPlayNodeList()
	end,
	Play420012116 = function(arg_482_0, arg_482_1)
		arg_482_1.time_ = 0
		arg_482_1.frameCnt_ = 0
		arg_482_1.state_ = "playing"
		arg_482_1.curTalkId_ = 420012116
		arg_482_1.duration_ = 5

		SetActive(arg_482_1.tipsGo_, false)

		function arg_482_1.onSingleLineFinish_()
			arg_482_1.onSingleLineUpdate_ = nil
			arg_482_1.onSingleLineFinish_ = nil
			arg_482_1.state_ = "waiting"
		end

		function arg_482_1.playNext_(arg_484_0)
			if arg_484_0 == 1 then
				arg_482_0:Play420012117(arg_482_1)
			end
		end

		function arg_482_1.onSingleLineUpdate_(arg_485_0)
			local var_485_0 = 0
			local var_485_1 = 0.725

			if var_485_0 < arg_482_1.time_ and arg_482_1.time_ <= var_485_0 + arg_485_0 then
				arg_482_1.talkMaxDuration = 0
				arg_482_1.dialogCg_.alpha = 1

				arg_482_1.dialog_:SetActive(true)
				SetActive(arg_482_1.leftNameGo_, true)

				local var_485_2 = arg_482_1:FormatText(StoryNameCfg[7].name)

				arg_482_1.leftNameTxt_.text = var_485_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_482_1.leftNameTxt_.transform)

				arg_482_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_482_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_482_1:RecordName(arg_482_1.leftNameTxt_.text)
				SetActive(arg_482_1.iconTrs_.gameObject, true)
				arg_482_1.iconController_:SetSelectedState("hero")

				arg_482_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_482_1.callingController_:SetSelectedState("normal")

				arg_482_1.keyicon_.color = Color.New(1, 1, 1)
				arg_482_1.icon_.color = Color.New(1, 1, 1)

				local var_485_3 = arg_482_1:GetWordFromCfg(420012116)
				local var_485_4 = arg_482_1:FormatText(var_485_3.content)

				arg_482_1.text_.text = var_485_4

				LuaForUtil.ClearLinePrefixSymbol(arg_482_1.text_)

				local var_485_5 = 29
				local var_485_6 = utf8.len(var_485_4)
				local var_485_7 = var_485_5 <= 0 and var_485_1 or var_485_1 * (var_485_6 / var_485_5)

				if var_485_7 > 0 and var_485_1 < var_485_7 then
					arg_482_1.talkMaxDuration = var_485_7

					if var_485_7 + var_485_0 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_7 + var_485_0
					end
				end

				arg_482_1.text_.text = var_485_4
				arg_482_1.typewritter.percent = 0

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(false)
				arg_482_1:RecordContent(arg_482_1.text_.text)
			end

			local var_485_8 = math.max(var_485_1, arg_482_1.talkMaxDuration)

			if var_485_0 <= arg_482_1.time_ and arg_482_1.time_ < var_485_0 + var_485_8 then
				arg_482_1.typewritter.percent = (arg_482_1.time_ - var_485_0) / var_485_8

				arg_482_1.typewritter:SetDirty()
			end

			if arg_482_1.time_ >= var_485_0 + var_485_8 and arg_482_1.time_ < var_485_0 + var_485_8 + arg_485_0 then
				arg_482_1.typewritter.percent = 1

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(true)
			end
		end

		arg_482_1.nodeConfigList_ = {}

		arg_482_1:InitPlayNodeList()
	end,
	Play420012117 = function(arg_486_0, arg_486_1)
		arg_486_1.time_ = 0
		arg_486_1.frameCnt_ = 0
		arg_486_1.state_ = "playing"
		arg_486_1.curTalkId_ = 420012117
		arg_486_1.duration_ = 3.37

		local var_486_0 = {
			zh = 2.666,
			ja = 3.366
		}
		local var_486_1 = manager.audio:GetLocalizationFlag()

		if var_486_0[var_486_1] ~= nil then
			arg_486_1.duration_ = var_486_0[var_486_1]
		end

		SetActive(arg_486_1.tipsGo_, false)

		function arg_486_1.onSingleLineFinish_()
			arg_486_1.onSingleLineUpdate_ = nil
			arg_486_1.onSingleLineFinish_ = nil
			arg_486_1.state_ = "waiting"
		end

		function arg_486_1.playNext_(arg_488_0)
			if arg_488_0 == 1 then
				arg_486_0:Play420012118(arg_486_1)
			end
		end

		function arg_486_1.onSingleLineUpdate_(arg_489_0)
			local var_489_0 = 0
			local var_489_1 = 0.325

			if var_489_0 < arg_486_1.time_ and arg_486_1.time_ <= var_489_0 + arg_489_0 then
				arg_486_1.talkMaxDuration = 0
				arg_486_1.dialogCg_.alpha = 1

				arg_486_1.dialog_:SetActive(true)
				SetActive(arg_486_1.leftNameGo_, true)

				local var_489_2 = arg_486_1:FormatText(StoryNameCfg[1157].name)

				arg_486_1.leftNameTxt_.text = var_489_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_486_1.leftNameTxt_.transform)

				arg_486_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_486_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_486_1:RecordName(arg_486_1.leftNameTxt_.text)
				SetActive(arg_486_1.iconTrs_.gameObject, true)
				arg_486_1.iconController_:SetSelectedState("hero")

				arg_486_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzab")

				arg_486_1.callingController_:SetSelectedState("normal")

				arg_486_1.keyicon_.color = Color.New(1, 1, 1)
				arg_486_1.icon_.color = Color.New(1, 1, 1)

				local var_489_3 = arg_486_1:GetWordFromCfg(420012117)
				local var_489_4 = arg_486_1:FormatText(var_489_3.content)

				arg_486_1.text_.text = var_489_4

				LuaForUtil.ClearLinePrefixSymbol(arg_486_1.text_)

				local var_489_5 = 13
				local var_489_6 = utf8.len(var_489_4)
				local var_489_7 = var_489_5 <= 0 and var_489_1 or var_489_1 * (var_489_6 / var_489_5)

				if var_489_7 > 0 and var_489_1 < var_489_7 then
					arg_486_1.talkMaxDuration = var_489_7

					if var_489_7 + var_489_0 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_7 + var_489_0
					end
				end

				arg_486_1.text_.text = var_489_4
				arg_486_1.typewritter.percent = 0

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012117", "story_v_out_420012.awb") ~= 0 then
					local var_489_8 = manager.audio:GetVoiceLength("story_v_out_420012", "420012117", "story_v_out_420012.awb") / 1000

					if var_489_8 + var_489_0 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_8 + var_489_0
					end

					if var_489_3.prefab_name ~= "" and arg_486_1.actors_[var_489_3.prefab_name] ~= nil then
						local var_489_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_486_1.actors_[var_489_3.prefab_name].transform, "story_v_out_420012", "420012117", "story_v_out_420012.awb")

						arg_486_1:RecordAudio("420012117", var_489_9)
						arg_486_1:RecordAudio("420012117", var_489_9)
					else
						arg_486_1:AudioAction("play", "voice", "story_v_out_420012", "420012117", "story_v_out_420012.awb")
					end

					arg_486_1:RecordHistoryTalkVoice("story_v_out_420012", "420012117", "story_v_out_420012.awb")
				end

				arg_486_1:RecordContent(arg_486_1.text_.text)
			end

			local var_489_10 = math.max(var_489_1, arg_486_1.talkMaxDuration)

			if var_489_0 <= arg_486_1.time_ and arg_486_1.time_ < var_489_0 + var_489_10 then
				arg_486_1.typewritter.percent = (arg_486_1.time_ - var_489_0) / var_489_10

				arg_486_1.typewritter:SetDirty()
			end

			if arg_486_1.time_ >= var_489_0 + var_489_10 and arg_486_1.time_ < var_489_0 + var_489_10 + arg_489_0 then
				arg_486_1.typewritter.percent = 1

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(true)
			end
		end

		arg_486_1.nodeConfigList_ = {}

		arg_486_1:InitPlayNodeList()
	end,
	Play420012118 = function(arg_490_0, arg_490_1)
		arg_490_1.time_ = 0
		arg_490_1.frameCnt_ = 0
		arg_490_1.state_ = "playing"
		arg_490_1.curTalkId_ = 420012118
		arg_490_1.duration_ = 5

		SetActive(arg_490_1.tipsGo_, false)

		function arg_490_1.onSingleLineFinish_()
			arg_490_1.onSingleLineUpdate_ = nil
			arg_490_1.onSingleLineFinish_ = nil
			arg_490_1.state_ = "waiting"
		end

		function arg_490_1.playNext_(arg_492_0)
			if arg_492_0 == 1 then
				arg_490_0:Play420012119(arg_490_1)
			end
		end

		function arg_490_1.onSingleLineUpdate_(arg_493_0)
			local var_493_0 = 0
			local var_493_1 = 0.35

			if var_493_0 < arg_490_1.time_ and arg_490_1.time_ <= var_493_0 + arg_493_0 then
				arg_490_1.talkMaxDuration = 0
				arg_490_1.dialogCg_.alpha = 1

				arg_490_1.dialog_:SetActive(true)
				SetActive(arg_490_1.leftNameGo_, true)

				local var_493_2 = arg_490_1:FormatText(StoryNameCfg[7].name)

				arg_490_1.leftNameTxt_.text = var_493_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_490_1.leftNameTxt_.transform)

				arg_490_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_490_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_490_1:RecordName(arg_490_1.leftNameTxt_.text)
				SetActive(arg_490_1.iconTrs_.gameObject, true)
				arg_490_1.iconController_:SetSelectedState("hero")

				arg_490_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_490_1.callingController_:SetSelectedState("normal")

				arg_490_1.keyicon_.color = Color.New(1, 1, 1)
				arg_490_1.icon_.color = Color.New(1, 1, 1)

				local var_493_3 = arg_490_1:GetWordFromCfg(420012118)
				local var_493_4 = arg_490_1:FormatText(var_493_3.content)

				arg_490_1.text_.text = var_493_4

				LuaForUtil.ClearLinePrefixSymbol(arg_490_1.text_)

				local var_493_5 = 14
				local var_493_6 = utf8.len(var_493_4)
				local var_493_7 = var_493_5 <= 0 and var_493_1 or var_493_1 * (var_493_6 / var_493_5)

				if var_493_7 > 0 and var_493_1 < var_493_7 then
					arg_490_1.talkMaxDuration = var_493_7

					if var_493_7 + var_493_0 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_7 + var_493_0
					end
				end

				arg_490_1.text_.text = var_493_4
				arg_490_1.typewritter.percent = 0

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(false)
				arg_490_1:RecordContent(arg_490_1.text_.text)
			end

			local var_493_8 = math.max(var_493_1, arg_490_1.talkMaxDuration)

			if var_493_0 <= arg_490_1.time_ and arg_490_1.time_ < var_493_0 + var_493_8 then
				arg_490_1.typewritter.percent = (arg_490_1.time_ - var_493_0) / var_493_8

				arg_490_1.typewritter:SetDirty()
			end

			if arg_490_1.time_ >= var_493_0 + var_493_8 and arg_490_1.time_ < var_493_0 + var_493_8 + arg_493_0 then
				arg_490_1.typewritter.percent = 1

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(true)
			end
		end

		arg_490_1.nodeConfigList_ = {}

		arg_490_1:InitPlayNodeList()
	end,
	Play420012119 = function(arg_494_0, arg_494_1)
		arg_494_1.time_ = 0
		arg_494_1.frameCnt_ = 0
		arg_494_1.state_ = "playing"
		arg_494_1.curTalkId_ = 420012119
		arg_494_1.duration_ = 5

		SetActive(arg_494_1.tipsGo_, false)

		function arg_494_1.onSingleLineFinish_()
			arg_494_1.onSingleLineUpdate_ = nil
			arg_494_1.onSingleLineFinish_ = nil
			arg_494_1.state_ = "waiting"
		end

		function arg_494_1.playNext_(arg_496_0)
			if arg_496_0 == 1 then
				arg_494_0:Play420012120(arg_494_1)
			end
		end

		function arg_494_1.onSingleLineUpdate_(arg_497_0)
			local var_497_0 = 0.05
			local var_497_1 = 1

			if var_497_0 < arg_494_1.time_ and arg_494_1.time_ <= var_497_0 + arg_497_0 then
				local var_497_2 = "play"
				local var_497_3 = "effect"

				arg_494_1:AudioAction(var_497_2, var_497_3, "se_story_140", "se_story_140_ui", "")
			end

			local var_497_4 = 0
			local var_497_5 = 1.45

			if var_497_4 < arg_494_1.time_ and arg_494_1.time_ <= var_497_4 + arg_497_0 then
				arg_494_1.talkMaxDuration = 0
				arg_494_1.dialogCg_.alpha = 1

				arg_494_1.dialog_:SetActive(true)
				SetActive(arg_494_1.leftNameGo_, false)

				arg_494_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_494_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_494_1:RecordName(arg_494_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_494_1.iconTrs_.gameObject, false)
				arg_494_1.callingController_:SetSelectedState("normal")

				local var_497_6 = arg_494_1:GetWordFromCfg(420012119)
				local var_497_7 = arg_494_1:FormatText(var_497_6.content)

				arg_494_1.text_.text = var_497_7

				LuaForUtil.ClearLinePrefixSymbol(arg_494_1.text_)

				local var_497_8 = 58
				local var_497_9 = utf8.len(var_497_7)
				local var_497_10 = var_497_8 <= 0 and var_497_5 or var_497_5 * (var_497_9 / var_497_8)

				if var_497_10 > 0 and var_497_5 < var_497_10 then
					arg_494_1.talkMaxDuration = var_497_10

					if var_497_10 + var_497_4 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_10 + var_497_4
					end
				end

				arg_494_1.text_.text = var_497_7
				arg_494_1.typewritter.percent = 0

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(false)
				arg_494_1:RecordContent(arg_494_1.text_.text)
			end

			local var_497_11 = math.max(var_497_5, arg_494_1.talkMaxDuration)

			if var_497_4 <= arg_494_1.time_ and arg_494_1.time_ < var_497_4 + var_497_11 then
				arg_494_1.typewritter.percent = (arg_494_1.time_ - var_497_4) / var_497_11

				arg_494_1.typewritter:SetDirty()
			end

			if arg_494_1.time_ >= var_497_4 + var_497_11 and arg_494_1.time_ < var_497_4 + var_497_11 + arg_497_0 then
				arg_494_1.typewritter.percent = 1

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(true)
			end
		end

		arg_494_1.nodeConfigList_ = {}

		arg_494_1:InitPlayNodeList()
	end,
	Play420012120 = function(arg_498_0, arg_498_1)
		arg_498_1.time_ = 0
		arg_498_1.frameCnt_ = 0
		arg_498_1.state_ = "playing"
		arg_498_1.curTalkId_ = 420012120
		arg_498_1.duration_ = 5

		SetActive(arg_498_1.tipsGo_, false)

		function arg_498_1.onSingleLineFinish_()
			arg_498_1.onSingleLineUpdate_ = nil
			arg_498_1.onSingleLineFinish_ = nil
			arg_498_1.state_ = "waiting"
		end

		function arg_498_1.playNext_(arg_500_0)
			if arg_500_0 == 1 then
				arg_498_0:Play420012121(arg_498_1)
			end
		end

		function arg_498_1.onSingleLineUpdate_(arg_501_0)
			local var_501_0 = 0
			local var_501_1 = 0.15

			if var_501_0 < arg_498_1.time_ and arg_498_1.time_ <= var_501_0 + arg_501_0 then
				arg_498_1.talkMaxDuration = 0
				arg_498_1.dialogCg_.alpha = 1

				arg_498_1.dialog_:SetActive(true)
				SetActive(arg_498_1.leftNameGo_, true)

				local var_501_2 = arg_498_1:FormatText(StoryNameCfg[7].name)

				arg_498_1.leftNameTxt_.text = var_501_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_498_1.leftNameTxt_.transform)

				arg_498_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_498_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_498_1:RecordName(arg_498_1.leftNameTxt_.text)
				SetActive(arg_498_1.iconTrs_.gameObject, true)
				arg_498_1.iconController_:SetSelectedState("hero")

				arg_498_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_498_1.callingController_:SetSelectedState("normal")

				arg_498_1.keyicon_.color = Color.New(1, 1, 1)
				arg_498_1.icon_.color = Color.New(1, 1, 1)

				local var_501_3 = arg_498_1:GetWordFromCfg(420012120)
				local var_501_4 = arg_498_1:FormatText(var_501_3.content)

				arg_498_1.text_.text = var_501_4

				LuaForUtil.ClearLinePrefixSymbol(arg_498_1.text_)

				local var_501_5 = 6
				local var_501_6 = utf8.len(var_501_4)
				local var_501_7 = var_501_5 <= 0 and var_501_1 or var_501_1 * (var_501_6 / var_501_5)

				if var_501_7 > 0 and var_501_1 < var_501_7 then
					arg_498_1.talkMaxDuration = var_501_7

					if var_501_7 + var_501_0 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_7 + var_501_0
					end
				end

				arg_498_1.text_.text = var_501_4
				arg_498_1.typewritter.percent = 0

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(false)
				arg_498_1:RecordContent(arg_498_1.text_.text)
			end

			local var_501_8 = math.max(var_501_1, arg_498_1.talkMaxDuration)

			if var_501_0 <= arg_498_1.time_ and arg_498_1.time_ < var_501_0 + var_501_8 then
				arg_498_1.typewritter.percent = (arg_498_1.time_ - var_501_0) / var_501_8

				arg_498_1.typewritter:SetDirty()
			end

			if arg_498_1.time_ >= var_501_0 + var_501_8 and arg_498_1.time_ < var_501_0 + var_501_8 + arg_501_0 then
				arg_498_1.typewritter.percent = 1

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(true)
			end
		end

		arg_498_1.nodeConfigList_ = {}

		arg_498_1:InitPlayNodeList()
	end,
	Play420012121 = function(arg_502_0, arg_502_1)
		arg_502_1.time_ = 0
		arg_502_1.frameCnt_ = 0
		arg_502_1.state_ = "playing"
		arg_502_1.curTalkId_ = 420012121
		arg_502_1.duration_ = 6.8

		local var_502_0 = {
			zh = 4.733,
			ja = 6.8
		}
		local var_502_1 = manager.audio:GetLocalizationFlag()

		if var_502_0[var_502_1] ~= nil then
			arg_502_1.duration_ = var_502_0[var_502_1]
		end

		SetActive(arg_502_1.tipsGo_, false)

		function arg_502_1.onSingleLineFinish_()
			arg_502_1.onSingleLineUpdate_ = nil
			arg_502_1.onSingleLineFinish_ = nil
			arg_502_1.state_ = "waiting"
		end

		function arg_502_1.playNext_(arg_504_0)
			if arg_504_0 == 1 then
				arg_502_0:Play420012122(arg_502_1)
			end
		end

		function arg_502_1.onSingleLineUpdate_(arg_505_0)
			local var_505_0 = 0
			local var_505_1 = 0.425

			if var_505_0 < arg_502_1.time_ and arg_502_1.time_ <= var_505_0 + arg_505_0 then
				arg_502_1.talkMaxDuration = 0
				arg_502_1.dialogCg_.alpha = 1

				arg_502_1.dialog_:SetActive(true)
				SetActive(arg_502_1.leftNameGo_, true)

				local var_505_2 = arg_502_1:FormatText(StoryNameCfg[1157].name)

				arg_502_1.leftNameTxt_.text = var_505_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_502_1.leftNameTxt_.transform)

				arg_502_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_502_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_502_1:RecordName(arg_502_1.leftNameTxt_.text)
				SetActive(arg_502_1.iconTrs_.gameObject, true)
				arg_502_1.iconController_:SetSelectedState("hero")

				arg_502_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzab")

				arg_502_1.callingController_:SetSelectedState("normal")

				arg_502_1.keyicon_.color = Color.New(1, 1, 1)
				arg_502_1.icon_.color = Color.New(1, 1, 1)

				local var_505_3 = arg_502_1:GetWordFromCfg(420012121)
				local var_505_4 = arg_502_1:FormatText(var_505_3.content)

				arg_502_1.text_.text = var_505_4

				LuaForUtil.ClearLinePrefixSymbol(arg_502_1.text_)

				local var_505_5 = 17
				local var_505_6 = utf8.len(var_505_4)
				local var_505_7 = var_505_5 <= 0 and var_505_1 or var_505_1 * (var_505_6 / var_505_5)

				if var_505_7 > 0 and var_505_1 < var_505_7 then
					arg_502_1.talkMaxDuration = var_505_7

					if var_505_7 + var_505_0 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_7 + var_505_0
					end
				end

				arg_502_1.text_.text = var_505_4
				arg_502_1.typewritter.percent = 0

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012121", "story_v_out_420012.awb") ~= 0 then
					local var_505_8 = manager.audio:GetVoiceLength("story_v_out_420012", "420012121", "story_v_out_420012.awb") / 1000

					if var_505_8 + var_505_0 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_8 + var_505_0
					end

					if var_505_3.prefab_name ~= "" and arg_502_1.actors_[var_505_3.prefab_name] ~= nil then
						local var_505_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_502_1.actors_[var_505_3.prefab_name].transform, "story_v_out_420012", "420012121", "story_v_out_420012.awb")

						arg_502_1:RecordAudio("420012121", var_505_9)
						arg_502_1:RecordAudio("420012121", var_505_9)
					else
						arg_502_1:AudioAction("play", "voice", "story_v_out_420012", "420012121", "story_v_out_420012.awb")
					end

					arg_502_1:RecordHistoryTalkVoice("story_v_out_420012", "420012121", "story_v_out_420012.awb")
				end

				arg_502_1:RecordContent(arg_502_1.text_.text)
			end

			local var_505_10 = math.max(var_505_1, arg_502_1.talkMaxDuration)

			if var_505_0 <= arg_502_1.time_ and arg_502_1.time_ < var_505_0 + var_505_10 then
				arg_502_1.typewritter.percent = (arg_502_1.time_ - var_505_0) / var_505_10

				arg_502_1.typewritter:SetDirty()
			end

			if arg_502_1.time_ >= var_505_0 + var_505_10 and arg_502_1.time_ < var_505_0 + var_505_10 + arg_505_0 then
				arg_502_1.typewritter.percent = 1

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(true)
			end
		end

		arg_502_1.nodeConfigList_ = {}

		arg_502_1:InitPlayNodeList()
	end,
	Play420012122 = function(arg_506_0, arg_506_1)
		arg_506_1.time_ = 0
		arg_506_1.frameCnt_ = 0
		arg_506_1.state_ = "playing"
		arg_506_1.curTalkId_ = 420012122
		arg_506_1.duration_ = 5

		SetActive(arg_506_1.tipsGo_, false)

		function arg_506_1.onSingleLineFinish_()
			arg_506_1.onSingleLineUpdate_ = nil
			arg_506_1.onSingleLineFinish_ = nil
			arg_506_1.state_ = "waiting"
		end

		function arg_506_1.playNext_(arg_508_0)
			if arg_508_0 == 1 then
				arg_506_0:Play420012123(arg_506_1)
			end
		end

		function arg_506_1.onSingleLineUpdate_(arg_509_0)
			local var_509_0 = 0
			local var_509_1 = 0.15

			if var_509_0 < arg_506_1.time_ and arg_506_1.time_ <= var_509_0 + arg_509_0 then
				arg_506_1.talkMaxDuration = 0
				arg_506_1.dialogCg_.alpha = 1

				arg_506_1.dialog_:SetActive(true)
				SetActive(arg_506_1.leftNameGo_, true)

				local var_509_2 = arg_506_1:FormatText(StoryNameCfg[7].name)

				arg_506_1.leftNameTxt_.text = var_509_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_506_1.leftNameTxt_.transform)

				arg_506_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_506_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_506_1:RecordName(arg_506_1.leftNameTxt_.text)
				SetActive(arg_506_1.iconTrs_.gameObject, true)
				arg_506_1.iconController_:SetSelectedState("hero")

				arg_506_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_506_1.callingController_:SetSelectedState("normal")

				arg_506_1.keyicon_.color = Color.New(1, 1, 1)
				arg_506_1.icon_.color = Color.New(1, 1, 1)

				local var_509_3 = arg_506_1:GetWordFromCfg(420012122)
				local var_509_4 = arg_506_1:FormatText(var_509_3.content)

				arg_506_1.text_.text = var_509_4

				LuaForUtil.ClearLinePrefixSymbol(arg_506_1.text_)

				local var_509_5 = 6
				local var_509_6 = utf8.len(var_509_4)
				local var_509_7 = var_509_5 <= 0 and var_509_1 or var_509_1 * (var_509_6 / var_509_5)

				if var_509_7 > 0 and var_509_1 < var_509_7 then
					arg_506_1.talkMaxDuration = var_509_7

					if var_509_7 + var_509_0 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_7 + var_509_0
					end
				end

				arg_506_1.text_.text = var_509_4
				arg_506_1.typewritter.percent = 0

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(false)
				arg_506_1:RecordContent(arg_506_1.text_.text)
			end

			local var_509_8 = math.max(var_509_1, arg_506_1.talkMaxDuration)

			if var_509_0 <= arg_506_1.time_ and arg_506_1.time_ < var_509_0 + var_509_8 then
				arg_506_1.typewritter.percent = (arg_506_1.time_ - var_509_0) / var_509_8

				arg_506_1.typewritter:SetDirty()
			end

			if arg_506_1.time_ >= var_509_0 + var_509_8 and arg_506_1.time_ < var_509_0 + var_509_8 + arg_509_0 then
				arg_506_1.typewritter.percent = 1

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(true)
			end
		end

		arg_506_1.nodeConfigList_ = {}

		arg_506_1:InitPlayNodeList()
	end,
	Play420012123 = function(arg_510_0, arg_510_1)
		arg_510_1.time_ = 0
		arg_510_1.frameCnt_ = 0
		arg_510_1.state_ = "playing"
		arg_510_1.curTalkId_ = 420012123
		arg_510_1.duration_ = 2

		SetActive(arg_510_1.tipsGo_, false)

		function arg_510_1.onSingleLineFinish_()
			arg_510_1.onSingleLineUpdate_ = nil
			arg_510_1.onSingleLineFinish_ = nil
			arg_510_1.state_ = "waiting"
		end

		function arg_510_1.playNext_(arg_512_0)
			if arg_512_0 == 1 then
				arg_510_0:Play420012124(arg_510_1)
			end
		end

		function arg_510_1.onSingleLineUpdate_(arg_513_0)
			local var_513_0 = arg_510_1.actors_["1085ui_story"].transform
			local var_513_1 = 0

			if var_513_1 < arg_510_1.time_ and arg_510_1.time_ <= var_513_1 + arg_513_0 then
				arg_510_1.var_.moveOldPos1085ui_story = var_513_0.localPosition
			end

			local var_513_2 = 0.001

			if var_513_1 <= arg_510_1.time_ and arg_510_1.time_ < var_513_1 + var_513_2 then
				local var_513_3 = (arg_510_1.time_ - var_513_1) / var_513_2
				local var_513_4 = Vector3.New(0, -1.01, -5.83)

				var_513_0.localPosition = Vector3.Lerp(arg_510_1.var_.moveOldPos1085ui_story, var_513_4, var_513_3)

				local var_513_5 = manager.ui.mainCamera.transform.position - var_513_0.position

				var_513_0.forward = Vector3.New(var_513_5.x, var_513_5.y, var_513_5.z)

				local var_513_6 = var_513_0.localEulerAngles

				var_513_6.z = 0
				var_513_6.x = 0
				var_513_0.localEulerAngles = var_513_6
			end

			if arg_510_1.time_ >= var_513_1 + var_513_2 and arg_510_1.time_ < var_513_1 + var_513_2 + arg_513_0 then
				var_513_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_513_7 = manager.ui.mainCamera.transform.position - var_513_0.position

				var_513_0.forward = Vector3.New(var_513_7.x, var_513_7.y, var_513_7.z)

				local var_513_8 = var_513_0.localEulerAngles

				var_513_8.z = 0
				var_513_8.x = 0
				var_513_0.localEulerAngles = var_513_8
			end

			local var_513_9 = arg_510_1.actors_["1085ui_story"]
			local var_513_10 = 0

			if var_513_10 < arg_510_1.time_ and arg_510_1.time_ <= var_513_10 + arg_513_0 and not isNil(var_513_9) and arg_510_1.var_.characterEffect1085ui_story == nil then
				arg_510_1.var_.characterEffect1085ui_story = var_513_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_513_11 = 0.200000002980232

			if var_513_10 <= arg_510_1.time_ and arg_510_1.time_ < var_513_10 + var_513_11 and not isNil(var_513_9) then
				local var_513_12 = (arg_510_1.time_ - var_513_10) / var_513_11

				if arg_510_1.var_.characterEffect1085ui_story and not isNil(var_513_9) then
					arg_510_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_510_1.time_ >= var_513_10 + var_513_11 and arg_510_1.time_ < var_513_10 + var_513_11 + arg_513_0 and not isNil(var_513_9) and arg_510_1.var_.characterEffect1085ui_story then
				arg_510_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_513_13 = 0

			if var_513_13 < arg_510_1.time_ and arg_510_1.time_ <= var_513_13 + arg_513_0 then
				arg_510_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_1")
			end

			local var_513_14 = 0

			if var_513_14 < arg_510_1.time_ and arg_510_1.time_ <= var_513_14 + arg_513_0 then
				arg_510_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_513_15 = 0
			local var_513_16 = 0.05

			if var_513_15 < arg_510_1.time_ and arg_510_1.time_ <= var_513_15 + arg_513_0 then
				arg_510_1.talkMaxDuration = 0
				arg_510_1.dialogCg_.alpha = 1

				arg_510_1.dialog_:SetActive(true)
				SetActive(arg_510_1.leftNameGo_, true)

				local var_513_17 = arg_510_1:FormatText(StoryNameCfg[328].name)

				arg_510_1.leftNameTxt_.text = var_513_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_510_1.leftNameTxt_.transform)

				arg_510_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_510_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_510_1:RecordName(arg_510_1.leftNameTxt_.text)
				SetActive(arg_510_1.iconTrs_.gameObject, false)
				arg_510_1.callingController_:SetSelectedState("normal")

				local var_513_18 = arg_510_1:GetWordFromCfg(420012123)
				local var_513_19 = arg_510_1:FormatText(var_513_18.content)

				arg_510_1.text_.text = var_513_19

				LuaForUtil.ClearLinePrefixSymbol(arg_510_1.text_)

				local var_513_20 = 2
				local var_513_21 = utf8.len(var_513_19)
				local var_513_22 = var_513_20 <= 0 and var_513_16 or var_513_16 * (var_513_21 / var_513_20)

				if var_513_22 > 0 and var_513_16 < var_513_22 then
					arg_510_1.talkMaxDuration = var_513_22

					if var_513_22 + var_513_15 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_22 + var_513_15
					end
				end

				arg_510_1.text_.text = var_513_19
				arg_510_1.typewritter.percent = 0

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012123", "story_v_out_420012.awb") ~= 0 then
					local var_513_23 = manager.audio:GetVoiceLength("story_v_out_420012", "420012123", "story_v_out_420012.awb") / 1000

					if var_513_23 + var_513_15 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_23 + var_513_15
					end

					if var_513_18.prefab_name ~= "" and arg_510_1.actors_[var_513_18.prefab_name] ~= nil then
						local var_513_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_510_1.actors_[var_513_18.prefab_name].transform, "story_v_out_420012", "420012123", "story_v_out_420012.awb")

						arg_510_1:RecordAudio("420012123", var_513_24)
						arg_510_1:RecordAudio("420012123", var_513_24)
					else
						arg_510_1:AudioAction("play", "voice", "story_v_out_420012", "420012123", "story_v_out_420012.awb")
					end

					arg_510_1:RecordHistoryTalkVoice("story_v_out_420012", "420012123", "story_v_out_420012.awb")
				end

				arg_510_1:RecordContent(arg_510_1.text_.text)
			end

			local var_513_25 = math.max(var_513_16, arg_510_1.talkMaxDuration)

			if var_513_15 <= arg_510_1.time_ and arg_510_1.time_ < var_513_15 + var_513_25 then
				arg_510_1.typewritter.percent = (arg_510_1.time_ - var_513_15) / var_513_25

				arg_510_1.typewritter:SetDirty()
			end

			if arg_510_1.time_ >= var_513_15 + var_513_25 and arg_510_1.time_ < var_513_15 + var_513_25 + arg_513_0 then
				arg_510_1.typewritter.percent = 1

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(true)
			end
		end

		arg_510_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_510_1:InitPlayNodeList()
	end,
	Play420012124 = function(arg_514_0, arg_514_1)
		arg_514_1.time_ = 0
		arg_514_1.frameCnt_ = 0
		arg_514_1.state_ = "playing"
		arg_514_1.curTalkId_ = 420012124
		arg_514_1.duration_ = 5

		SetActive(arg_514_1.tipsGo_, false)

		function arg_514_1.onSingleLineFinish_()
			arg_514_1.onSingleLineUpdate_ = nil
			arg_514_1.onSingleLineFinish_ = nil
			arg_514_1.state_ = "waiting"
		end

		function arg_514_1.playNext_(arg_516_0)
			if arg_516_0 == 1 then
				arg_514_0:Play420012125(arg_514_1)
			end
		end

		function arg_514_1.onSingleLineUpdate_(arg_517_0)
			local var_517_0 = 0.05
			local var_517_1 = 1

			if var_517_0 < arg_514_1.time_ and arg_514_1.time_ <= var_517_0 + arg_517_0 then
				local var_517_2 = "play"
				local var_517_3 = "effect"

				arg_514_1:AudioAction(var_517_2, var_517_3, "se_story_140", "se_story_140_foley_cash02", "")
			end

			local var_517_4 = arg_514_1.actors_["1085ui_story"].transform
			local var_517_5 = 0

			if var_517_5 < arg_514_1.time_ and arg_514_1.time_ <= var_517_5 + arg_517_0 then
				arg_514_1.var_.moveOldPos1085ui_story = var_517_4.localPosition
			end

			local var_517_6 = 0.001

			if var_517_5 <= arg_514_1.time_ and arg_514_1.time_ < var_517_5 + var_517_6 then
				local var_517_7 = (arg_514_1.time_ - var_517_5) / var_517_6
				local var_517_8 = Vector3.New(0, 100, 0)

				var_517_4.localPosition = Vector3.Lerp(arg_514_1.var_.moveOldPos1085ui_story, var_517_8, var_517_7)

				local var_517_9 = manager.ui.mainCamera.transform.position - var_517_4.position

				var_517_4.forward = Vector3.New(var_517_9.x, var_517_9.y, var_517_9.z)

				local var_517_10 = var_517_4.localEulerAngles

				var_517_10.z = 0
				var_517_10.x = 0
				var_517_4.localEulerAngles = var_517_10
			end

			if arg_514_1.time_ >= var_517_5 + var_517_6 and arg_514_1.time_ < var_517_5 + var_517_6 + arg_517_0 then
				var_517_4.localPosition = Vector3.New(0, 100, 0)

				local var_517_11 = manager.ui.mainCamera.transform.position - var_517_4.position

				var_517_4.forward = Vector3.New(var_517_11.x, var_517_11.y, var_517_11.z)

				local var_517_12 = var_517_4.localEulerAngles

				var_517_12.z = 0
				var_517_12.x = 0
				var_517_4.localEulerAngles = var_517_12
			end

			local var_517_13 = 0
			local var_517_14 = 1.25

			if var_517_13 < arg_514_1.time_ and arg_514_1.time_ <= var_517_13 + arg_517_0 then
				arg_514_1.talkMaxDuration = 0
				arg_514_1.dialogCg_.alpha = 1

				arg_514_1.dialog_:SetActive(true)
				SetActive(arg_514_1.leftNameGo_, false)

				arg_514_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_514_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_514_1:RecordName(arg_514_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_514_1.iconTrs_.gameObject, false)
				arg_514_1.callingController_:SetSelectedState("normal")

				local var_517_15 = arg_514_1:GetWordFromCfg(420012124)
				local var_517_16 = arg_514_1:FormatText(var_517_15.content)

				arg_514_1.text_.text = var_517_16

				LuaForUtil.ClearLinePrefixSymbol(arg_514_1.text_)

				local var_517_17 = 50
				local var_517_18 = utf8.len(var_517_16)
				local var_517_19 = var_517_17 <= 0 and var_517_14 or var_517_14 * (var_517_18 / var_517_17)

				if var_517_19 > 0 and var_517_14 < var_517_19 then
					arg_514_1.talkMaxDuration = var_517_19

					if var_517_19 + var_517_13 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_19 + var_517_13
					end
				end

				arg_514_1.text_.text = var_517_16
				arg_514_1.typewritter.percent = 0

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(false)
				arg_514_1:RecordContent(arg_514_1.text_.text)
			end

			local var_517_20 = math.max(var_517_14, arg_514_1.talkMaxDuration)

			if var_517_13 <= arg_514_1.time_ and arg_514_1.time_ < var_517_13 + var_517_20 then
				arg_514_1.typewritter.percent = (arg_514_1.time_ - var_517_13) / var_517_20

				arg_514_1.typewritter:SetDirty()
			end

			if arg_514_1.time_ >= var_517_13 + var_517_20 and arg_514_1.time_ < var_517_13 + var_517_20 + arg_517_0 then
				arg_514_1.typewritter.percent = 1

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(true)
			end
		end

		arg_514_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_514_1:InitPlayNodeList()
	end,
	Play420012125 = function(arg_518_0, arg_518_1)
		arg_518_1.time_ = 0
		arg_518_1.frameCnt_ = 0
		arg_518_1.state_ = "playing"
		arg_518_1.curTalkId_ = 420012125
		arg_518_1.duration_ = 5

		SetActive(arg_518_1.tipsGo_, false)

		function arg_518_1.onSingleLineFinish_()
			arg_518_1.onSingleLineUpdate_ = nil
			arg_518_1.onSingleLineFinish_ = nil
			arg_518_1.state_ = "waiting"
		end

		function arg_518_1.playNext_(arg_520_0)
			if arg_520_0 == 1 then
				arg_518_0:Play420012126(arg_518_1)
			end
		end

		function arg_518_1.onSingleLineUpdate_(arg_521_0)
			local var_521_0 = 0
			local var_521_1 = 1.5

			if var_521_0 < arg_518_1.time_ and arg_518_1.time_ <= var_521_0 + arg_521_0 then
				arg_518_1.talkMaxDuration = 0
				arg_518_1.dialogCg_.alpha = 1

				arg_518_1.dialog_:SetActive(true)
				SetActive(arg_518_1.leftNameGo_, false)

				arg_518_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_518_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_518_1:RecordName(arg_518_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_518_1.iconTrs_.gameObject, false)
				arg_518_1.callingController_:SetSelectedState("normal")

				local var_521_2 = arg_518_1:GetWordFromCfg(420012125)
				local var_521_3 = arg_518_1:FormatText(var_521_2.content)

				arg_518_1.text_.text = var_521_3

				LuaForUtil.ClearLinePrefixSymbol(arg_518_1.text_)

				local var_521_4 = 60
				local var_521_5 = utf8.len(var_521_3)
				local var_521_6 = var_521_4 <= 0 and var_521_1 or var_521_1 * (var_521_5 / var_521_4)

				if var_521_6 > 0 and var_521_1 < var_521_6 then
					arg_518_1.talkMaxDuration = var_521_6

					if var_521_6 + var_521_0 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_6 + var_521_0
					end
				end

				arg_518_1.text_.text = var_521_3
				arg_518_1.typewritter.percent = 0

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(false)
				arg_518_1:RecordContent(arg_518_1.text_.text)
			end

			local var_521_7 = math.max(var_521_1, arg_518_1.talkMaxDuration)

			if var_521_0 <= arg_518_1.time_ and arg_518_1.time_ < var_521_0 + var_521_7 then
				arg_518_1.typewritter.percent = (arg_518_1.time_ - var_521_0) / var_521_7

				arg_518_1.typewritter:SetDirty()
			end

			if arg_518_1.time_ >= var_521_0 + var_521_7 and arg_518_1.time_ < var_521_0 + var_521_7 + arg_521_0 then
				arg_518_1.typewritter.percent = 1

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(true)
			end
		end

		arg_518_1.nodeConfigList_ = {}

		arg_518_1:InitPlayNodeList()
	end,
	Play420012126 = function(arg_522_0, arg_522_1)
		arg_522_1.time_ = 0
		arg_522_1.frameCnt_ = 0
		arg_522_1.state_ = "playing"
		arg_522_1.curTalkId_ = 420012126
		arg_522_1.duration_ = 5.3

		local var_522_0 = {
			zh = 5.3,
			ja = 3.766
		}
		local var_522_1 = manager.audio:GetLocalizationFlag()

		if var_522_0[var_522_1] ~= nil then
			arg_522_1.duration_ = var_522_0[var_522_1]
		end

		SetActive(arg_522_1.tipsGo_, false)

		function arg_522_1.onSingleLineFinish_()
			arg_522_1.onSingleLineUpdate_ = nil
			arg_522_1.onSingleLineFinish_ = nil
			arg_522_1.state_ = "waiting"
		end

		function arg_522_1.playNext_(arg_524_0)
			if arg_524_0 == 1 then
				arg_522_0:Play420012127(arg_522_1)
			end
		end

		function arg_522_1.onSingleLineUpdate_(arg_525_0)
			local var_525_0 = arg_522_1.actors_["1085ui_story"]
			local var_525_1 = 0

			if var_525_1 < arg_522_1.time_ and arg_522_1.time_ <= var_525_1 + arg_525_0 and not isNil(var_525_0) and arg_522_1.var_.characterEffect1085ui_story == nil then
				arg_522_1.var_.characterEffect1085ui_story = var_525_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_525_2 = 0.200000002980232

			if var_525_1 <= arg_522_1.time_ and arg_522_1.time_ < var_525_1 + var_525_2 and not isNil(var_525_0) then
				local var_525_3 = (arg_522_1.time_ - var_525_1) / var_525_2

				if arg_522_1.var_.characterEffect1085ui_story and not isNil(var_525_0) then
					arg_522_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_522_1.time_ >= var_525_1 + var_525_2 and arg_522_1.time_ < var_525_1 + var_525_2 + arg_525_0 and not isNil(var_525_0) and arg_522_1.var_.characterEffect1085ui_story then
				arg_522_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_525_4 = arg_522_1.actors_["1085ui_story"].transform
			local var_525_5 = 0

			if var_525_5 < arg_522_1.time_ and arg_522_1.time_ <= var_525_5 + arg_525_0 then
				arg_522_1.var_.moveOldPos1085ui_story = var_525_4.localPosition
			end

			local var_525_6 = 0.001

			if var_525_5 <= arg_522_1.time_ and arg_522_1.time_ < var_525_5 + var_525_6 then
				local var_525_7 = (arg_522_1.time_ - var_525_5) / var_525_6
				local var_525_8 = Vector3.New(0, -1.01, -5.83)

				var_525_4.localPosition = Vector3.Lerp(arg_522_1.var_.moveOldPos1085ui_story, var_525_8, var_525_7)

				local var_525_9 = manager.ui.mainCamera.transform.position - var_525_4.position

				var_525_4.forward = Vector3.New(var_525_9.x, var_525_9.y, var_525_9.z)

				local var_525_10 = var_525_4.localEulerAngles

				var_525_10.z = 0
				var_525_10.x = 0
				var_525_4.localEulerAngles = var_525_10
			end

			if arg_522_1.time_ >= var_525_5 + var_525_6 and arg_522_1.time_ < var_525_5 + var_525_6 + arg_525_0 then
				var_525_4.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_525_11 = manager.ui.mainCamera.transform.position - var_525_4.position

				var_525_4.forward = Vector3.New(var_525_11.x, var_525_11.y, var_525_11.z)

				local var_525_12 = var_525_4.localEulerAngles

				var_525_12.z = 0
				var_525_12.x = 0
				var_525_4.localEulerAngles = var_525_12
			end

			local var_525_13 = 0
			local var_525_14 = 0.275

			if var_525_13 < arg_522_1.time_ and arg_522_1.time_ <= var_525_13 + arg_525_0 then
				arg_522_1.talkMaxDuration = 0
				arg_522_1.dialogCg_.alpha = 1

				arg_522_1.dialog_:SetActive(true)
				SetActive(arg_522_1.leftNameGo_, true)

				local var_525_15 = arg_522_1:FormatText(StoryNameCfg[328].name)

				arg_522_1.leftNameTxt_.text = var_525_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_522_1.leftNameTxt_.transform)

				arg_522_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_522_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_522_1:RecordName(arg_522_1.leftNameTxt_.text)
				SetActive(arg_522_1.iconTrs_.gameObject, false)
				arg_522_1.callingController_:SetSelectedState("normal")

				local var_525_16 = arg_522_1:GetWordFromCfg(420012126)
				local var_525_17 = arg_522_1:FormatText(var_525_16.content)

				arg_522_1.text_.text = var_525_17

				LuaForUtil.ClearLinePrefixSymbol(arg_522_1.text_)

				local var_525_18 = 11
				local var_525_19 = utf8.len(var_525_17)
				local var_525_20 = var_525_18 <= 0 and var_525_14 or var_525_14 * (var_525_19 / var_525_18)

				if var_525_20 > 0 and var_525_14 < var_525_20 then
					arg_522_1.talkMaxDuration = var_525_20

					if var_525_20 + var_525_13 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_20 + var_525_13
					end
				end

				arg_522_1.text_.text = var_525_17
				arg_522_1.typewritter.percent = 0

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012126", "story_v_out_420012.awb") ~= 0 then
					local var_525_21 = manager.audio:GetVoiceLength("story_v_out_420012", "420012126", "story_v_out_420012.awb") / 1000

					if var_525_21 + var_525_13 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_21 + var_525_13
					end

					if var_525_16.prefab_name ~= "" and arg_522_1.actors_[var_525_16.prefab_name] ~= nil then
						local var_525_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_522_1.actors_[var_525_16.prefab_name].transform, "story_v_out_420012", "420012126", "story_v_out_420012.awb")

						arg_522_1:RecordAudio("420012126", var_525_22)
						arg_522_1:RecordAudio("420012126", var_525_22)
					else
						arg_522_1:AudioAction("play", "voice", "story_v_out_420012", "420012126", "story_v_out_420012.awb")
					end

					arg_522_1:RecordHistoryTalkVoice("story_v_out_420012", "420012126", "story_v_out_420012.awb")
				end

				arg_522_1:RecordContent(arg_522_1.text_.text)
			end

			local var_525_23 = math.max(var_525_14, arg_522_1.talkMaxDuration)

			if var_525_13 <= arg_522_1.time_ and arg_522_1.time_ < var_525_13 + var_525_23 then
				arg_522_1.typewritter.percent = (arg_522_1.time_ - var_525_13) / var_525_23

				arg_522_1.typewritter:SetDirty()
			end

			if arg_522_1.time_ >= var_525_13 + var_525_23 and arg_522_1.time_ < var_525_13 + var_525_23 + arg_525_0 then
				arg_522_1.typewritter.percent = 1

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(true)
			end
		end

		arg_522_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_522_1:InitPlayNodeList()
	end,
	Play420012127 = function(arg_526_0, arg_526_1)
		arg_526_1.time_ = 0
		arg_526_1.frameCnt_ = 0
		arg_526_1.state_ = "playing"
		arg_526_1.curTalkId_ = 420012127
		arg_526_1.duration_ = 5

		SetActive(arg_526_1.tipsGo_, false)

		function arg_526_1.onSingleLineFinish_()
			arg_526_1.onSingleLineUpdate_ = nil
			arg_526_1.onSingleLineFinish_ = nil
			arg_526_1.state_ = "waiting"
		end

		function arg_526_1.playNext_(arg_528_0)
			if arg_528_0 == 1 then
				arg_526_0:Play420012128(arg_526_1)
			end
		end

		function arg_526_1.onSingleLineUpdate_(arg_529_0)
			local var_529_0 = arg_526_1.actors_["1085ui_story"].transform
			local var_529_1 = 0

			if var_529_1 < arg_526_1.time_ and arg_526_1.time_ <= var_529_1 + arg_529_0 then
				arg_526_1.var_.moveOldPos1085ui_story = var_529_0.localPosition
			end

			local var_529_2 = 0.001

			if var_529_1 <= arg_526_1.time_ and arg_526_1.time_ < var_529_1 + var_529_2 then
				local var_529_3 = (arg_526_1.time_ - var_529_1) / var_529_2
				local var_529_4 = Vector3.New(0, 100, 0)

				var_529_0.localPosition = Vector3.Lerp(arg_526_1.var_.moveOldPos1085ui_story, var_529_4, var_529_3)

				local var_529_5 = manager.ui.mainCamera.transform.position - var_529_0.position

				var_529_0.forward = Vector3.New(var_529_5.x, var_529_5.y, var_529_5.z)

				local var_529_6 = var_529_0.localEulerAngles

				var_529_6.z = 0
				var_529_6.x = 0
				var_529_0.localEulerAngles = var_529_6
			end

			if arg_526_1.time_ >= var_529_1 + var_529_2 and arg_526_1.time_ < var_529_1 + var_529_2 + arg_529_0 then
				var_529_0.localPosition = Vector3.New(0, 100, 0)

				local var_529_7 = manager.ui.mainCamera.transform.position - var_529_0.position

				var_529_0.forward = Vector3.New(var_529_7.x, var_529_7.y, var_529_7.z)

				local var_529_8 = var_529_0.localEulerAngles

				var_529_8.z = 0
				var_529_8.x = 0
				var_529_0.localEulerAngles = var_529_8
			end

			local var_529_9 = 0
			local var_529_10 = 1.55

			if var_529_9 < arg_526_1.time_ and arg_526_1.time_ <= var_529_9 + arg_529_0 then
				arg_526_1.talkMaxDuration = 0
				arg_526_1.dialogCg_.alpha = 1

				arg_526_1.dialog_:SetActive(true)
				SetActive(arg_526_1.leftNameGo_, false)

				arg_526_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_526_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_526_1:RecordName(arg_526_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_526_1.iconTrs_.gameObject, false)
				arg_526_1.callingController_:SetSelectedState("normal")

				local var_529_11 = arg_526_1:GetWordFromCfg(420012127)
				local var_529_12 = arg_526_1:FormatText(var_529_11.content)

				arg_526_1.text_.text = var_529_12

				LuaForUtil.ClearLinePrefixSymbol(arg_526_1.text_)

				local var_529_13 = 62
				local var_529_14 = utf8.len(var_529_12)
				local var_529_15 = var_529_13 <= 0 and var_529_10 or var_529_10 * (var_529_14 / var_529_13)

				if var_529_15 > 0 and var_529_10 < var_529_15 then
					arg_526_1.talkMaxDuration = var_529_15

					if var_529_15 + var_529_9 > arg_526_1.duration_ then
						arg_526_1.duration_ = var_529_15 + var_529_9
					end
				end

				arg_526_1.text_.text = var_529_12
				arg_526_1.typewritter.percent = 0

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(false)
				arg_526_1:RecordContent(arg_526_1.text_.text)
			end

			local var_529_16 = math.max(var_529_10, arg_526_1.talkMaxDuration)

			if var_529_9 <= arg_526_1.time_ and arg_526_1.time_ < var_529_9 + var_529_16 then
				arg_526_1.typewritter.percent = (arg_526_1.time_ - var_529_9) / var_529_16

				arg_526_1.typewritter:SetDirty()
			end

			if arg_526_1.time_ >= var_529_9 + var_529_16 and arg_526_1.time_ < var_529_9 + var_529_16 + arg_529_0 then
				arg_526_1.typewritter.percent = 1

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(true)
			end
		end

		arg_526_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_526_1:InitPlayNodeList()
	end,
	Play420012128 = function(arg_530_0, arg_530_1)
		arg_530_1.time_ = 0
		arg_530_1.frameCnt_ = 0
		arg_530_1.state_ = "playing"
		arg_530_1.curTalkId_ = 420012128
		arg_530_1.duration_ = 5

		SetActive(arg_530_1.tipsGo_, false)

		function arg_530_1.onSingleLineFinish_()
			arg_530_1.onSingleLineUpdate_ = nil
			arg_530_1.onSingleLineFinish_ = nil
			arg_530_1.state_ = "waiting"
		end

		function arg_530_1.playNext_(arg_532_0)
			if arg_532_0 == 1 then
				arg_530_0:Play420012129(arg_530_1)
			end
		end

		function arg_530_1.onSingleLineUpdate_(arg_533_0)
			local var_533_0 = 0
			local var_533_1 = 1.4

			if var_533_0 < arg_530_1.time_ and arg_530_1.time_ <= var_533_0 + arg_533_0 then
				arg_530_1.talkMaxDuration = 0
				arg_530_1.dialogCg_.alpha = 1

				arg_530_1.dialog_:SetActive(true)
				SetActive(arg_530_1.leftNameGo_, false)

				arg_530_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_530_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_530_1:RecordName(arg_530_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_530_1.iconTrs_.gameObject, false)
				arg_530_1.callingController_:SetSelectedState("normal")

				local var_533_2 = arg_530_1:GetWordFromCfg(420012128)
				local var_533_3 = arg_530_1:FormatText(var_533_2.content)

				arg_530_1.text_.text = var_533_3

				LuaForUtil.ClearLinePrefixSymbol(arg_530_1.text_)

				local var_533_4 = 56
				local var_533_5 = utf8.len(var_533_3)
				local var_533_6 = var_533_4 <= 0 and var_533_1 or var_533_1 * (var_533_5 / var_533_4)

				if var_533_6 > 0 and var_533_1 < var_533_6 then
					arg_530_1.talkMaxDuration = var_533_6

					if var_533_6 + var_533_0 > arg_530_1.duration_ then
						arg_530_1.duration_ = var_533_6 + var_533_0
					end
				end

				arg_530_1.text_.text = var_533_3
				arg_530_1.typewritter.percent = 0

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(false)
				arg_530_1:RecordContent(arg_530_1.text_.text)
			end

			local var_533_7 = math.max(var_533_1, arg_530_1.talkMaxDuration)

			if var_533_0 <= arg_530_1.time_ and arg_530_1.time_ < var_533_0 + var_533_7 then
				arg_530_1.typewritter.percent = (arg_530_1.time_ - var_533_0) / var_533_7

				arg_530_1.typewritter:SetDirty()
			end

			if arg_530_1.time_ >= var_533_0 + var_533_7 and arg_530_1.time_ < var_533_0 + var_533_7 + arg_533_0 then
				arg_530_1.typewritter.percent = 1

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(true)
			end
		end

		arg_530_1.nodeConfigList_ = {}

		arg_530_1:InitPlayNodeList()
	end,
	Play420012129 = function(arg_534_0, arg_534_1)
		arg_534_1.time_ = 0
		arg_534_1.frameCnt_ = 0
		arg_534_1.state_ = "playing"
		arg_534_1.curTalkId_ = 420012129
		arg_534_1.duration_ = 5

		SetActive(arg_534_1.tipsGo_, false)

		function arg_534_1.onSingleLineFinish_()
			arg_534_1.onSingleLineUpdate_ = nil
			arg_534_1.onSingleLineFinish_ = nil
			arg_534_1.state_ = "waiting"
		end

		function arg_534_1.playNext_(arg_536_0)
			if arg_536_0 == 1 then
				arg_534_0:Play420012130(arg_534_1)
			end
		end

		function arg_534_1.onSingleLineUpdate_(arg_537_0)
			local var_537_0 = 0
			local var_537_1 = 0.375

			if var_537_0 < arg_534_1.time_ and arg_534_1.time_ <= var_537_0 + arg_537_0 then
				arg_534_1.talkMaxDuration = 0
				arg_534_1.dialogCg_.alpha = 1

				arg_534_1.dialog_:SetActive(true)
				SetActive(arg_534_1.leftNameGo_, true)

				local var_537_2 = arg_534_1:FormatText(StoryNameCfg[7].name)

				arg_534_1.leftNameTxt_.text = var_537_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_534_1.leftNameTxt_.transform)

				arg_534_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_534_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_534_1:RecordName(arg_534_1.leftNameTxt_.text)
				SetActive(arg_534_1.iconTrs_.gameObject, true)
				arg_534_1.iconController_:SetSelectedState("hero")

				arg_534_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_534_1.callingController_:SetSelectedState("normal")

				arg_534_1.keyicon_.color = Color.New(1, 1, 1)
				arg_534_1.icon_.color = Color.New(1, 1, 1)

				local var_537_3 = arg_534_1:GetWordFromCfg(420012129)
				local var_537_4 = arg_534_1:FormatText(var_537_3.content)

				arg_534_1.text_.text = var_537_4

				LuaForUtil.ClearLinePrefixSymbol(arg_534_1.text_)

				local var_537_5 = 15
				local var_537_6 = utf8.len(var_537_4)
				local var_537_7 = var_537_5 <= 0 and var_537_1 or var_537_1 * (var_537_6 / var_537_5)

				if var_537_7 > 0 and var_537_1 < var_537_7 then
					arg_534_1.talkMaxDuration = var_537_7

					if var_537_7 + var_537_0 > arg_534_1.duration_ then
						arg_534_1.duration_ = var_537_7 + var_537_0
					end
				end

				arg_534_1.text_.text = var_537_4
				arg_534_1.typewritter.percent = 0

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(false)
				arg_534_1:RecordContent(arg_534_1.text_.text)
			end

			local var_537_8 = math.max(var_537_1, arg_534_1.talkMaxDuration)

			if var_537_0 <= arg_534_1.time_ and arg_534_1.time_ < var_537_0 + var_537_8 then
				arg_534_1.typewritter.percent = (arg_534_1.time_ - var_537_0) / var_537_8

				arg_534_1.typewritter:SetDirty()
			end

			if arg_534_1.time_ >= var_537_0 + var_537_8 and arg_534_1.time_ < var_537_0 + var_537_8 + arg_537_0 then
				arg_534_1.typewritter.percent = 1

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(true)
			end
		end

		arg_534_1.nodeConfigList_ = {}

		arg_534_1:InitPlayNodeList()
	end,
	Play420012130 = function(arg_538_0, arg_538_1)
		arg_538_1.time_ = 0
		arg_538_1.frameCnt_ = 0
		arg_538_1.state_ = "playing"
		arg_538_1.curTalkId_ = 420012130
		arg_538_1.duration_ = 5

		SetActive(arg_538_1.tipsGo_, false)

		function arg_538_1.onSingleLineFinish_()
			arg_538_1.onSingleLineUpdate_ = nil
			arg_538_1.onSingleLineFinish_ = nil
			arg_538_1.state_ = "waiting"
		end

		function arg_538_1.playNext_(arg_540_0)
			if arg_540_0 == 1 then
				arg_538_0:Play420012131(arg_538_1)
			end
		end

		function arg_538_1.onSingleLineUpdate_(arg_541_0)
			local var_541_0 = 0
			local var_541_1 = 1.425

			if var_541_0 < arg_538_1.time_ and arg_538_1.time_ <= var_541_0 + arg_541_0 then
				arg_538_1.talkMaxDuration = 0
				arg_538_1.dialogCg_.alpha = 1

				arg_538_1.dialog_:SetActive(true)
				SetActive(arg_538_1.leftNameGo_, false)

				arg_538_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_538_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_538_1:RecordName(arg_538_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_538_1.iconTrs_.gameObject, false)
				arg_538_1.callingController_:SetSelectedState("normal")

				local var_541_2 = arg_538_1:GetWordFromCfg(420012130)
				local var_541_3 = arg_538_1:FormatText(var_541_2.content)

				arg_538_1.text_.text = var_541_3

				LuaForUtil.ClearLinePrefixSymbol(arg_538_1.text_)

				local var_541_4 = 57
				local var_541_5 = utf8.len(var_541_3)
				local var_541_6 = var_541_4 <= 0 and var_541_1 or var_541_1 * (var_541_5 / var_541_4)

				if var_541_6 > 0 and var_541_1 < var_541_6 then
					arg_538_1.talkMaxDuration = var_541_6

					if var_541_6 + var_541_0 > arg_538_1.duration_ then
						arg_538_1.duration_ = var_541_6 + var_541_0
					end
				end

				arg_538_1.text_.text = var_541_3
				arg_538_1.typewritter.percent = 0

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(false)
				arg_538_1:RecordContent(arg_538_1.text_.text)
			end

			local var_541_7 = math.max(var_541_1, arg_538_1.talkMaxDuration)

			if var_541_0 <= arg_538_1.time_ and arg_538_1.time_ < var_541_0 + var_541_7 then
				arg_538_1.typewritter.percent = (arg_538_1.time_ - var_541_0) / var_541_7

				arg_538_1.typewritter:SetDirty()
			end

			if arg_538_1.time_ >= var_541_0 + var_541_7 and arg_538_1.time_ < var_541_0 + var_541_7 + arg_541_0 then
				arg_538_1.typewritter.percent = 1

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(true)
			end
		end

		arg_538_1.nodeConfigList_ = {}

		arg_538_1:InitPlayNodeList()
	end,
	Play420012131 = function(arg_542_0, arg_542_1)
		arg_542_1.time_ = 0
		arg_542_1.frameCnt_ = 0
		arg_542_1.state_ = "playing"
		arg_542_1.curTalkId_ = 420012131
		arg_542_1.duration_ = 7.7

		SetActive(arg_542_1.tipsGo_, false)

		function arg_542_1.onSingleLineFinish_()
			arg_542_1.onSingleLineUpdate_ = nil
			arg_542_1.onSingleLineFinish_ = nil
			arg_542_1.state_ = "waiting"
		end

		function arg_542_1.playNext_(arg_544_0)
			if arg_544_0 == 1 then
				arg_542_0:Play420012132(arg_542_1)
			end
		end

		function arg_542_1.onSingleLineUpdate_(arg_545_0)
			local var_545_0 = 1.2

			if var_545_0 < arg_542_1.time_ and arg_542_1.time_ <= var_545_0 + arg_545_0 then
				local var_545_1 = manager.ui.mainCamera.transform.localPosition
				local var_545_2 = Vector3.New(0, 0, 10) + Vector3.New(var_545_1.x, var_545_1.y, 0)
				local var_545_3 = arg_542_1.bgs_.ST0503

				var_545_3.transform.localPosition = var_545_2
				var_545_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_545_4 = var_545_3:GetComponent("SpriteRenderer")

				if var_545_4 and var_545_4.sprite then
					local var_545_5 = (var_545_3.transform.localPosition - var_545_1).z
					local var_545_6 = manager.ui.mainCameraCom_
					local var_545_7 = 2 * var_545_5 * Mathf.Tan(var_545_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_545_8 = var_545_7 * var_545_6.aspect
					local var_545_9 = var_545_4.sprite.bounds.size.x
					local var_545_10 = var_545_4.sprite.bounds.size.y
					local var_545_11 = var_545_8 / var_545_9
					local var_545_12 = var_545_7 / var_545_10
					local var_545_13 = var_545_12 < var_545_11 and var_545_11 or var_545_12

					var_545_3.transform.localScale = Vector3.New(var_545_13, var_545_13, 0)
				end

				for iter_545_0, iter_545_1 in pairs(arg_542_1.bgs_) do
					if iter_545_0 ~= "ST0503" then
						iter_545_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_545_14 = 2.7

			if var_545_14 < arg_542_1.time_ and arg_542_1.time_ <= var_545_14 + arg_545_0 then
				arg_542_1.allBtn_.enabled = false
			end

			local var_545_15 = 0.3

			if arg_542_1.time_ >= var_545_14 + var_545_15 and arg_542_1.time_ < var_545_14 + var_545_15 + arg_545_0 then
				arg_542_1.allBtn_.enabled = true
			end

			local var_545_16 = 0

			if var_545_16 < arg_542_1.time_ and arg_542_1.time_ <= var_545_16 + arg_545_0 then
				arg_542_1.mask_.enabled = true
				arg_542_1.mask_.raycastTarget = true

				arg_542_1:SetGaussion(false)
			end

			local var_545_17 = 1.2

			if var_545_16 <= arg_542_1.time_ and arg_542_1.time_ < var_545_16 + var_545_17 then
				local var_545_18 = (arg_542_1.time_ - var_545_16) / var_545_17
				local var_545_19 = Color.New(0, 0, 0)

				var_545_19.a = Mathf.Lerp(0, 1, var_545_18)
				arg_542_1.mask_.color = var_545_19
			end

			if arg_542_1.time_ >= var_545_16 + var_545_17 and arg_542_1.time_ < var_545_16 + var_545_17 + arg_545_0 then
				local var_545_20 = Color.New(0, 0, 0)

				var_545_20.a = 1
				arg_542_1.mask_.color = var_545_20
			end

			local var_545_21 = 1.2

			if var_545_21 < arg_542_1.time_ and arg_542_1.time_ <= var_545_21 + arg_545_0 then
				arg_542_1.mask_.enabled = true
				arg_542_1.mask_.raycastTarget = true

				arg_542_1:SetGaussion(false)
			end

			local var_545_22 = 1.5

			if var_545_21 <= arg_542_1.time_ and arg_542_1.time_ < var_545_21 + var_545_22 then
				local var_545_23 = (arg_542_1.time_ - var_545_21) / var_545_22
				local var_545_24 = Color.New(0, 0, 0)

				var_545_24.a = Mathf.Lerp(1, 0, var_545_23)
				arg_542_1.mask_.color = var_545_24
			end

			if arg_542_1.time_ >= var_545_21 + var_545_22 and arg_542_1.time_ < var_545_21 + var_545_22 + arg_545_0 then
				local var_545_25 = Color.New(0, 0, 0)
				local var_545_26 = 0

				arg_542_1.mask_.enabled = false
				var_545_25.a = var_545_26
				arg_542_1.mask_.color = var_545_25
			end

			local var_545_27 = 0.1
			local var_545_28 = 1

			if var_545_27 < arg_542_1.time_ and arg_542_1.time_ <= var_545_27 + arg_545_0 then
				local var_545_29 = "stop"
				local var_545_30 = "effect"

				arg_542_1:AudioAction(var_545_29, var_545_30, "se_story_140", "se_story_140_amb_street01", "")
			end

			local var_545_31 = 1.5
			local var_545_32 = 1

			if var_545_31 < arg_542_1.time_ and arg_542_1.time_ <= var_545_31 + arg_545_0 then
				local var_545_33 = "play"
				local var_545_34 = "effect"

				arg_542_1:AudioAction(var_545_33, var_545_34, "se_story_140", "se_story_140_amb_street02", "")
			end

			if arg_542_1.frameCnt_ <= 1 then
				arg_542_1.dialog_:SetActive(false)
			end

			local var_545_35 = 2.7
			local var_545_36 = 0.525

			if var_545_35 < arg_542_1.time_ and arg_542_1.time_ <= var_545_35 + arg_545_0 then
				arg_542_1.talkMaxDuration = 0

				arg_542_1.dialog_:SetActive(true)

				arg_542_1.dialogCg_.alpha = 0

				local var_545_37 = LeanTween.value(arg_542_1.dialog_, 0, 1, 0.3)

				var_545_37:setOnUpdate(LuaHelper.FloatAction(function(arg_546_0)
					arg_542_1.dialogCg_.alpha = arg_546_0
				end))
				var_545_37:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_542_1.dialog_)
					var_545_37:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_542_1.duration_ = arg_542_1.duration_ + 0.3

				SetActive(arg_542_1.leftNameGo_, false)

				arg_542_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_542_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_542_1:RecordName(arg_542_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_542_1.iconTrs_.gameObject, false)
				arg_542_1.callingController_:SetSelectedState("normal")

				local var_545_38 = arg_542_1:GetWordFromCfg(420012131)
				local var_545_39 = arg_542_1:FormatText(var_545_38.content)

				arg_542_1.text_.text = var_545_39

				LuaForUtil.ClearLinePrefixSymbol(arg_542_1.text_)

				local var_545_40 = 21
				local var_545_41 = utf8.len(var_545_39)
				local var_545_42 = var_545_40 <= 0 and var_545_36 or var_545_36 * (var_545_41 / var_545_40)

				if var_545_42 > 0 and var_545_36 < var_545_42 then
					arg_542_1.talkMaxDuration = var_545_42
					var_545_35 = var_545_35 + 0.3

					if var_545_42 + var_545_35 > arg_542_1.duration_ then
						arg_542_1.duration_ = var_545_42 + var_545_35
					end
				end

				arg_542_1.text_.text = var_545_39
				arg_542_1.typewritter.percent = 0

				arg_542_1.typewritter:SetDirty()
				arg_542_1:ShowNextGo(false)
				arg_542_1:RecordContent(arg_542_1.text_.text)
			end

			local var_545_43 = var_545_35 + 0.3
			local var_545_44 = math.max(var_545_36, arg_542_1.talkMaxDuration)

			if var_545_43 <= arg_542_1.time_ and arg_542_1.time_ < var_545_43 + var_545_44 then
				arg_542_1.typewritter.percent = (arg_542_1.time_ - var_545_43) / var_545_44

				arg_542_1.typewritter:SetDirty()
			end

			if arg_542_1.time_ >= var_545_43 + var_545_44 and arg_542_1.time_ < var_545_43 + var_545_44 + arg_545_0 then
				arg_542_1.typewritter.percent = 1

				arg_542_1.typewritter:SetDirty()
				arg_542_1:ShowNextGo(true)
			end
		end

		arg_542_1.nodeConfigList_ = {}

		arg_542_1:InitPlayNodeList()
	end,
	Play420012132 = function(arg_548_0, arg_548_1)
		arg_548_1.time_ = 0
		arg_548_1.frameCnt_ = 0
		arg_548_1.state_ = "playing"
		arg_548_1.curTalkId_ = 420012132
		arg_548_1.duration_ = 5

		SetActive(arg_548_1.tipsGo_, false)

		function arg_548_1.onSingleLineFinish_()
			arg_548_1.onSingleLineUpdate_ = nil
			arg_548_1.onSingleLineFinish_ = nil
			arg_548_1.state_ = "waiting"
		end

		function arg_548_1.playNext_(arg_550_0)
			if arg_550_0 == 1 then
				arg_548_0:Play420012133(arg_548_1)
			end
		end

		function arg_548_1.onSingleLineUpdate_(arg_551_0)
			local var_551_0 = 1.26666666666667
			local var_551_1 = 1

			if var_551_0 < arg_548_1.time_ and arg_548_1.time_ <= var_551_0 + arg_551_0 then
				local var_551_2 = "play"
				local var_551_3 = "effect"

				arg_548_1:AudioAction(var_551_2, var_551_3, "se_story_140", "se_story_140_footstep_run01", "")
			end

			local var_551_4 = 0
			local var_551_5 = 1.425

			if var_551_4 < arg_548_1.time_ and arg_548_1.time_ <= var_551_4 + arg_551_0 then
				arg_548_1.talkMaxDuration = 0
				arg_548_1.dialogCg_.alpha = 1

				arg_548_1.dialog_:SetActive(true)
				SetActive(arg_548_1.leftNameGo_, false)

				arg_548_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_548_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_548_1:RecordName(arg_548_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_548_1.iconTrs_.gameObject, false)
				arg_548_1.callingController_:SetSelectedState("normal")

				local var_551_6 = arg_548_1:GetWordFromCfg(420012132)
				local var_551_7 = arg_548_1:FormatText(var_551_6.content)

				arg_548_1.text_.text = var_551_7

				LuaForUtil.ClearLinePrefixSymbol(arg_548_1.text_)

				local var_551_8 = 57
				local var_551_9 = utf8.len(var_551_7)
				local var_551_10 = var_551_8 <= 0 and var_551_5 or var_551_5 * (var_551_9 / var_551_8)

				if var_551_10 > 0 and var_551_5 < var_551_10 then
					arg_548_1.talkMaxDuration = var_551_10

					if var_551_10 + var_551_4 > arg_548_1.duration_ then
						arg_548_1.duration_ = var_551_10 + var_551_4
					end
				end

				arg_548_1.text_.text = var_551_7
				arg_548_1.typewritter.percent = 0

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(false)
				arg_548_1:RecordContent(arg_548_1.text_.text)
			end

			local var_551_11 = math.max(var_551_5, arg_548_1.talkMaxDuration)

			if var_551_4 <= arg_548_1.time_ and arg_548_1.time_ < var_551_4 + var_551_11 then
				arg_548_1.typewritter.percent = (arg_548_1.time_ - var_551_4) / var_551_11

				arg_548_1.typewritter:SetDirty()
			end

			if arg_548_1.time_ >= var_551_4 + var_551_11 and arg_548_1.time_ < var_551_4 + var_551_11 + arg_551_0 then
				arg_548_1.typewritter.percent = 1

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(true)
			end
		end

		arg_548_1.nodeConfigList_ = {}

		arg_548_1:InitPlayNodeList()
	end,
	Play420012133 = function(arg_552_0, arg_552_1)
		arg_552_1.time_ = 0
		arg_552_1.frameCnt_ = 0
		arg_552_1.state_ = "playing"
		arg_552_1.curTalkId_ = 420012133
		arg_552_1.duration_ = 2

		SetActive(arg_552_1.tipsGo_, false)

		function arg_552_1.onSingleLineFinish_()
			arg_552_1.onSingleLineUpdate_ = nil
			arg_552_1.onSingleLineFinish_ = nil
			arg_552_1.state_ = "waiting"
		end

		function arg_552_1.playNext_(arg_554_0)
			if arg_554_0 == 1 then
				arg_552_0:Play420012134(arg_552_1)
			end
		end

		function arg_552_1.onSingleLineUpdate_(arg_555_0)
			local var_555_0 = arg_552_1.actors_["1085ui_story"].transform
			local var_555_1 = 0

			if var_555_1 < arg_552_1.time_ and arg_552_1.time_ <= var_555_1 + arg_555_0 then
				arg_552_1.var_.moveOldPos1085ui_story = var_555_0.localPosition
			end

			local var_555_2 = 0.001

			if var_555_1 <= arg_552_1.time_ and arg_552_1.time_ < var_555_1 + var_555_2 then
				local var_555_3 = (arg_552_1.time_ - var_555_1) / var_555_2
				local var_555_4 = Vector3.New(0, -1.01, -5.83)

				var_555_0.localPosition = Vector3.Lerp(arg_552_1.var_.moveOldPos1085ui_story, var_555_4, var_555_3)

				local var_555_5 = manager.ui.mainCamera.transform.position - var_555_0.position

				var_555_0.forward = Vector3.New(var_555_5.x, var_555_5.y, var_555_5.z)

				local var_555_6 = var_555_0.localEulerAngles

				var_555_6.z = 0
				var_555_6.x = 0
				var_555_0.localEulerAngles = var_555_6
			end

			if arg_552_1.time_ >= var_555_1 + var_555_2 and arg_552_1.time_ < var_555_1 + var_555_2 + arg_555_0 then
				var_555_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_555_7 = manager.ui.mainCamera.transform.position - var_555_0.position

				var_555_0.forward = Vector3.New(var_555_7.x, var_555_7.y, var_555_7.z)

				local var_555_8 = var_555_0.localEulerAngles

				var_555_8.z = 0
				var_555_8.x = 0
				var_555_0.localEulerAngles = var_555_8
			end

			local var_555_9 = arg_552_1.actors_["1085ui_story"]
			local var_555_10 = 0

			if var_555_10 < arg_552_1.time_ and arg_552_1.time_ <= var_555_10 + arg_555_0 and not isNil(var_555_9) and arg_552_1.var_.characterEffect1085ui_story == nil then
				arg_552_1.var_.characterEffect1085ui_story = var_555_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_555_11 = 0.200000002980232

			if var_555_10 <= arg_552_1.time_ and arg_552_1.time_ < var_555_10 + var_555_11 and not isNil(var_555_9) then
				local var_555_12 = (arg_552_1.time_ - var_555_10) / var_555_11

				if arg_552_1.var_.characterEffect1085ui_story and not isNil(var_555_9) then
					arg_552_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_552_1.time_ >= var_555_10 + var_555_11 and arg_552_1.time_ < var_555_10 + var_555_11 + arg_555_0 and not isNil(var_555_9) and arg_552_1.var_.characterEffect1085ui_story then
				arg_552_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_555_13 = 0

			if var_555_13 < arg_552_1.time_ and arg_552_1.time_ <= var_555_13 + arg_555_0 then
				arg_552_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action7_1")
			end

			local var_555_14 = 0

			if var_555_14 < arg_552_1.time_ and arg_552_1.time_ <= var_555_14 + arg_555_0 then
				arg_552_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaC", "EmotionTimelineAnimator")
			end

			local var_555_15 = 0
			local var_555_16 = 0.075

			if var_555_15 < arg_552_1.time_ and arg_552_1.time_ <= var_555_15 + arg_555_0 then
				arg_552_1.talkMaxDuration = 0
				arg_552_1.dialogCg_.alpha = 1

				arg_552_1.dialog_:SetActive(true)
				SetActive(arg_552_1.leftNameGo_, true)

				local var_555_17 = arg_552_1:FormatText(StoryNameCfg[328].name)

				arg_552_1.leftNameTxt_.text = var_555_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_552_1.leftNameTxt_.transform)

				arg_552_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_552_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_552_1:RecordName(arg_552_1.leftNameTxt_.text)
				SetActive(arg_552_1.iconTrs_.gameObject, false)
				arg_552_1.callingController_:SetSelectedState("normal")

				local var_555_18 = arg_552_1:GetWordFromCfg(420012133)
				local var_555_19 = arg_552_1:FormatText(var_555_18.content)

				arg_552_1.text_.text = var_555_19

				LuaForUtil.ClearLinePrefixSymbol(arg_552_1.text_)

				local var_555_20 = 3
				local var_555_21 = utf8.len(var_555_19)
				local var_555_22 = var_555_20 <= 0 and var_555_16 or var_555_16 * (var_555_21 / var_555_20)

				if var_555_22 > 0 and var_555_16 < var_555_22 then
					arg_552_1.talkMaxDuration = var_555_22

					if var_555_22 + var_555_15 > arg_552_1.duration_ then
						arg_552_1.duration_ = var_555_22 + var_555_15
					end
				end

				arg_552_1.text_.text = var_555_19
				arg_552_1.typewritter.percent = 0

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012133", "story_v_out_420012.awb") ~= 0 then
					local var_555_23 = manager.audio:GetVoiceLength("story_v_out_420012", "420012133", "story_v_out_420012.awb") / 1000

					if var_555_23 + var_555_15 > arg_552_1.duration_ then
						arg_552_1.duration_ = var_555_23 + var_555_15
					end

					if var_555_18.prefab_name ~= "" and arg_552_1.actors_[var_555_18.prefab_name] ~= nil then
						local var_555_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_552_1.actors_[var_555_18.prefab_name].transform, "story_v_out_420012", "420012133", "story_v_out_420012.awb")

						arg_552_1:RecordAudio("420012133", var_555_24)
						arg_552_1:RecordAudio("420012133", var_555_24)
					else
						arg_552_1:AudioAction("play", "voice", "story_v_out_420012", "420012133", "story_v_out_420012.awb")
					end

					arg_552_1:RecordHistoryTalkVoice("story_v_out_420012", "420012133", "story_v_out_420012.awb")
				end

				arg_552_1:RecordContent(arg_552_1.text_.text)
			end

			local var_555_25 = math.max(var_555_16, arg_552_1.talkMaxDuration)

			if var_555_15 <= arg_552_1.time_ and arg_552_1.time_ < var_555_15 + var_555_25 then
				arg_552_1.typewritter.percent = (arg_552_1.time_ - var_555_15) / var_555_25

				arg_552_1.typewritter:SetDirty()
			end

			if arg_552_1.time_ >= var_555_15 + var_555_25 and arg_552_1.time_ < var_555_15 + var_555_25 + arg_555_0 then
				arg_552_1.typewritter.percent = 1

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(true)
			end
		end

		arg_552_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_552_1:InitPlayNodeList()
	end,
	Play420012134 = function(arg_556_0, arg_556_1)
		arg_556_1.time_ = 0
		arg_556_1.frameCnt_ = 0
		arg_556_1.state_ = "playing"
		arg_556_1.curTalkId_ = 420012134
		arg_556_1.duration_ = 5

		SetActive(arg_556_1.tipsGo_, false)

		function arg_556_1.onSingleLineFinish_()
			arg_556_1.onSingleLineUpdate_ = nil
			arg_556_1.onSingleLineFinish_ = nil
			arg_556_1.state_ = "waiting"
		end

		function arg_556_1.playNext_(arg_558_0)
			if arg_558_0 == 1 then
				arg_556_0:Play420012135(arg_556_1)
			end
		end

		function arg_556_1.onSingleLineUpdate_(arg_559_0)
			local var_559_0 = 0.05
			local var_559_1 = 1

			if var_559_0 < arg_556_1.time_ and arg_556_1.time_ <= var_559_0 + arg_559_0 then
				local var_559_2 = "play"
				local var_559_3 = "effect"

				arg_556_1:AudioAction(var_559_2, var_559_3, "se_story_140", "se_story_140_footstep_run02", "")
			end

			local var_559_4 = arg_556_1.actors_["1085ui_story"]
			local var_559_5 = 0

			if var_559_5 < arg_556_1.time_ and arg_556_1.time_ <= var_559_5 + arg_559_0 and not isNil(var_559_4) and arg_556_1.var_.characterEffect1085ui_story == nil then
				arg_556_1.var_.characterEffect1085ui_story = var_559_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_559_6 = 0.200000002980232

			if var_559_5 <= arg_556_1.time_ and arg_556_1.time_ < var_559_5 + var_559_6 and not isNil(var_559_4) then
				local var_559_7 = (arg_556_1.time_ - var_559_5) / var_559_6

				if arg_556_1.var_.characterEffect1085ui_story and not isNil(var_559_4) then
					local var_559_8 = Mathf.Lerp(0, 0.5, var_559_7)

					arg_556_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_556_1.var_.characterEffect1085ui_story.fillRatio = var_559_8
				end
			end

			if arg_556_1.time_ >= var_559_5 + var_559_6 and arg_556_1.time_ < var_559_5 + var_559_6 + arg_559_0 and not isNil(var_559_4) and arg_556_1.var_.characterEffect1085ui_story then
				local var_559_9 = 0.5

				arg_556_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_556_1.var_.characterEffect1085ui_story.fillRatio = var_559_9
			end

			local var_559_10 = 0
			local var_559_11 = 0.125

			if var_559_10 < arg_556_1.time_ and arg_556_1.time_ <= var_559_10 + arg_559_0 then
				arg_556_1.talkMaxDuration = 0
				arg_556_1.dialogCg_.alpha = 1

				arg_556_1.dialog_:SetActive(true)
				SetActive(arg_556_1.leftNameGo_, true)

				local var_559_12 = arg_556_1:FormatText(StoryNameCfg[7].name)

				arg_556_1.leftNameTxt_.text = var_559_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_556_1.leftNameTxt_.transform)

				arg_556_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_556_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_556_1:RecordName(arg_556_1.leftNameTxt_.text)
				SetActive(arg_556_1.iconTrs_.gameObject, true)
				arg_556_1.iconController_:SetSelectedState("hero")

				arg_556_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_556_1.callingController_:SetSelectedState("normal")

				arg_556_1.keyicon_.color = Color.New(1, 1, 1)
				arg_556_1.icon_.color = Color.New(1, 1, 1)

				local var_559_13 = arg_556_1:GetWordFromCfg(420012134)
				local var_559_14 = arg_556_1:FormatText(var_559_13.content)

				arg_556_1.text_.text = var_559_14

				LuaForUtil.ClearLinePrefixSymbol(arg_556_1.text_)

				local var_559_15 = 5
				local var_559_16 = utf8.len(var_559_14)
				local var_559_17 = var_559_15 <= 0 and var_559_11 or var_559_11 * (var_559_16 / var_559_15)

				if var_559_17 > 0 and var_559_11 < var_559_17 then
					arg_556_1.talkMaxDuration = var_559_17

					if var_559_17 + var_559_10 > arg_556_1.duration_ then
						arg_556_1.duration_ = var_559_17 + var_559_10
					end
				end

				arg_556_1.text_.text = var_559_14
				arg_556_1.typewritter.percent = 0

				arg_556_1.typewritter:SetDirty()
				arg_556_1:ShowNextGo(false)
				arg_556_1:RecordContent(arg_556_1.text_.text)
			end

			local var_559_18 = math.max(var_559_11, arg_556_1.talkMaxDuration)

			if var_559_10 <= arg_556_1.time_ and arg_556_1.time_ < var_559_10 + var_559_18 then
				arg_556_1.typewritter.percent = (arg_556_1.time_ - var_559_10) / var_559_18

				arg_556_1.typewritter:SetDirty()
			end

			if arg_556_1.time_ >= var_559_10 + var_559_18 and arg_556_1.time_ < var_559_10 + var_559_18 + arg_559_0 then
				arg_556_1.typewritter.percent = 1

				arg_556_1.typewritter:SetDirty()
				arg_556_1:ShowNextGo(true)
			end
		end

		arg_556_1.nodeConfigList_ = {}

		arg_556_1:InitPlayNodeList()
	end,
	Play420012135 = function(arg_560_0, arg_560_1)
		arg_560_1.time_ = 0
		arg_560_1.frameCnt_ = 0
		arg_560_1.state_ = "playing"
		arg_560_1.curTalkId_ = 420012135
		arg_560_1.duration_ = 5

		SetActive(arg_560_1.tipsGo_, false)

		function arg_560_1.onSingleLineFinish_()
			arg_560_1.onSingleLineUpdate_ = nil
			arg_560_1.onSingleLineFinish_ = nil
			arg_560_1.state_ = "waiting"
		end

		function arg_560_1.playNext_(arg_562_0)
			if arg_562_0 == 1 then
				arg_560_0:Play420012136(arg_560_1)
			end
		end

		function arg_560_1.onSingleLineUpdate_(arg_563_0)
			local var_563_0 = arg_560_1.actors_["1085ui_story"].transform
			local var_563_1 = 0

			if var_563_1 < arg_560_1.time_ and arg_560_1.time_ <= var_563_1 + arg_563_0 then
				arg_560_1.var_.moveOldPos1085ui_story = var_563_0.localPosition
			end

			local var_563_2 = 0.001

			if var_563_1 <= arg_560_1.time_ and arg_560_1.time_ < var_563_1 + var_563_2 then
				local var_563_3 = (arg_560_1.time_ - var_563_1) / var_563_2
				local var_563_4 = Vector3.New(0, 100, 0)

				var_563_0.localPosition = Vector3.Lerp(arg_560_1.var_.moveOldPos1085ui_story, var_563_4, var_563_3)

				local var_563_5 = manager.ui.mainCamera.transform.position - var_563_0.position

				var_563_0.forward = Vector3.New(var_563_5.x, var_563_5.y, var_563_5.z)

				local var_563_6 = var_563_0.localEulerAngles

				var_563_6.z = 0
				var_563_6.x = 0
				var_563_0.localEulerAngles = var_563_6
			end

			if arg_560_1.time_ >= var_563_1 + var_563_2 and arg_560_1.time_ < var_563_1 + var_563_2 + arg_563_0 then
				var_563_0.localPosition = Vector3.New(0, 100, 0)

				local var_563_7 = manager.ui.mainCamera.transform.position - var_563_0.position

				var_563_0.forward = Vector3.New(var_563_7.x, var_563_7.y, var_563_7.z)

				local var_563_8 = var_563_0.localEulerAngles

				var_563_8.z = 0
				var_563_8.x = 0
				var_563_0.localEulerAngles = var_563_8
			end

			local var_563_9 = 0
			local var_563_10 = 1

			if var_563_9 < arg_560_1.time_ and arg_560_1.time_ <= var_563_9 + arg_563_0 then
				arg_560_1.talkMaxDuration = 0
				arg_560_1.dialogCg_.alpha = 1

				arg_560_1.dialog_:SetActive(true)
				SetActive(arg_560_1.leftNameGo_, false)

				arg_560_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_560_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_560_1:RecordName(arg_560_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_560_1.iconTrs_.gameObject, false)
				arg_560_1.callingController_:SetSelectedState("normal")

				local var_563_11 = arg_560_1:GetWordFromCfg(420012135)
				local var_563_12 = arg_560_1:FormatText(var_563_11.content)

				arg_560_1.text_.text = var_563_12

				LuaForUtil.ClearLinePrefixSymbol(arg_560_1.text_)

				local var_563_13 = 40
				local var_563_14 = utf8.len(var_563_12)
				local var_563_15 = var_563_13 <= 0 and var_563_10 or var_563_10 * (var_563_14 / var_563_13)

				if var_563_15 > 0 and var_563_10 < var_563_15 then
					arg_560_1.talkMaxDuration = var_563_15

					if var_563_15 + var_563_9 > arg_560_1.duration_ then
						arg_560_1.duration_ = var_563_15 + var_563_9
					end
				end

				arg_560_1.text_.text = var_563_12
				arg_560_1.typewritter.percent = 0

				arg_560_1.typewritter:SetDirty()
				arg_560_1:ShowNextGo(false)
				arg_560_1:RecordContent(arg_560_1.text_.text)
			end

			local var_563_16 = math.max(var_563_10, arg_560_1.talkMaxDuration)

			if var_563_9 <= arg_560_1.time_ and arg_560_1.time_ < var_563_9 + var_563_16 then
				arg_560_1.typewritter.percent = (arg_560_1.time_ - var_563_9) / var_563_16

				arg_560_1.typewritter:SetDirty()
			end

			if arg_560_1.time_ >= var_563_9 + var_563_16 and arg_560_1.time_ < var_563_9 + var_563_16 + arg_563_0 then
				arg_560_1.typewritter.percent = 1

				arg_560_1.typewritter:SetDirty()
				arg_560_1:ShowNextGo(true)
			end
		end

		arg_560_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_560_1:InitPlayNodeList()
	end,
	Play420012136 = function(arg_564_0, arg_564_1)
		arg_564_1.time_ = 0
		arg_564_1.frameCnt_ = 0
		arg_564_1.state_ = "playing"
		arg_564_1.curTalkId_ = 420012136
		arg_564_1.duration_ = 5

		SetActive(arg_564_1.tipsGo_, false)

		function arg_564_1.onSingleLineFinish_()
			arg_564_1.onSingleLineUpdate_ = nil
			arg_564_1.onSingleLineFinish_ = nil
			arg_564_1.state_ = "waiting"
		end

		function arg_564_1.playNext_(arg_566_0)
			if arg_566_0 == 1 then
				arg_564_0:Play420012137(arg_564_1)
			end
		end

		function arg_564_1.onSingleLineUpdate_(arg_567_0)
			local var_567_0 = 0
			local var_567_1 = 1.175

			if var_567_0 < arg_564_1.time_ and arg_564_1.time_ <= var_567_0 + arg_567_0 then
				arg_564_1.talkMaxDuration = 0
				arg_564_1.dialogCg_.alpha = 1

				arg_564_1.dialog_:SetActive(true)
				SetActive(arg_564_1.leftNameGo_, false)

				arg_564_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_564_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_564_1:RecordName(arg_564_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_564_1.iconTrs_.gameObject, false)
				arg_564_1.callingController_:SetSelectedState("normal")

				local var_567_2 = arg_564_1:GetWordFromCfg(420012136)
				local var_567_3 = arg_564_1:FormatText(var_567_2.content)

				arg_564_1.text_.text = var_567_3

				LuaForUtil.ClearLinePrefixSymbol(arg_564_1.text_)

				local var_567_4 = 47
				local var_567_5 = utf8.len(var_567_3)
				local var_567_6 = var_567_4 <= 0 and var_567_1 or var_567_1 * (var_567_5 / var_567_4)

				if var_567_6 > 0 and var_567_1 < var_567_6 then
					arg_564_1.talkMaxDuration = var_567_6

					if var_567_6 + var_567_0 > arg_564_1.duration_ then
						arg_564_1.duration_ = var_567_6 + var_567_0
					end
				end

				arg_564_1.text_.text = var_567_3
				arg_564_1.typewritter.percent = 0

				arg_564_1.typewritter:SetDirty()
				arg_564_1:ShowNextGo(false)
				arg_564_1:RecordContent(arg_564_1.text_.text)
			end

			local var_567_7 = math.max(var_567_1, arg_564_1.talkMaxDuration)

			if var_567_0 <= arg_564_1.time_ and arg_564_1.time_ < var_567_0 + var_567_7 then
				arg_564_1.typewritter.percent = (arg_564_1.time_ - var_567_0) / var_567_7

				arg_564_1.typewritter:SetDirty()
			end

			if arg_564_1.time_ >= var_567_0 + var_567_7 and arg_564_1.time_ < var_567_0 + var_567_7 + arg_567_0 then
				arg_564_1.typewritter.percent = 1

				arg_564_1.typewritter:SetDirty()
				arg_564_1:ShowNextGo(true)
			end
		end

		arg_564_1.nodeConfigList_ = {}

		arg_564_1:InitPlayNodeList()
	end,
	Play420012137 = function(arg_568_0, arg_568_1)
		arg_568_1.time_ = 0
		arg_568_1.frameCnt_ = 0
		arg_568_1.state_ = "playing"
		arg_568_1.curTalkId_ = 420012137
		arg_568_1.duration_ = 5

		SetActive(arg_568_1.tipsGo_, false)

		function arg_568_1.onSingleLineFinish_()
			arg_568_1.onSingleLineUpdate_ = nil
			arg_568_1.onSingleLineFinish_ = nil
			arg_568_1.state_ = "waiting"
		end

		function arg_568_1.playNext_(arg_570_0)
			if arg_570_0 == 1 then
				arg_568_0:Play420012138(arg_568_1)
			end
		end

		function arg_568_1.onSingleLineUpdate_(arg_571_0)
			local var_571_0 = 0
			local var_571_1 = 0.4

			if var_571_0 < arg_568_1.time_ and arg_568_1.time_ <= var_571_0 + arg_571_0 then
				arg_568_1.talkMaxDuration = 0
				arg_568_1.dialogCg_.alpha = 1

				arg_568_1.dialog_:SetActive(true)
				SetActive(arg_568_1.leftNameGo_, true)

				local var_571_2 = arg_568_1:FormatText(StoryNameCfg[7].name)

				arg_568_1.leftNameTxt_.text = var_571_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_568_1.leftNameTxt_.transform)

				arg_568_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_568_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_568_1:RecordName(arg_568_1.leftNameTxt_.text)
				SetActive(arg_568_1.iconTrs_.gameObject, true)
				arg_568_1.iconController_:SetSelectedState("hero")

				arg_568_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_568_1.callingController_:SetSelectedState("normal")

				arg_568_1.keyicon_.color = Color.New(1, 1, 1)
				arg_568_1.icon_.color = Color.New(1, 1, 1)

				local var_571_3 = arg_568_1:GetWordFromCfg(420012137)
				local var_571_4 = arg_568_1:FormatText(var_571_3.content)

				arg_568_1.text_.text = var_571_4

				LuaForUtil.ClearLinePrefixSymbol(arg_568_1.text_)

				local var_571_5 = 16
				local var_571_6 = utf8.len(var_571_4)
				local var_571_7 = var_571_5 <= 0 and var_571_1 or var_571_1 * (var_571_6 / var_571_5)

				if var_571_7 > 0 and var_571_1 < var_571_7 then
					arg_568_1.talkMaxDuration = var_571_7

					if var_571_7 + var_571_0 > arg_568_1.duration_ then
						arg_568_1.duration_ = var_571_7 + var_571_0
					end
				end

				arg_568_1.text_.text = var_571_4
				arg_568_1.typewritter.percent = 0

				arg_568_1.typewritter:SetDirty()
				arg_568_1:ShowNextGo(false)
				arg_568_1:RecordContent(arg_568_1.text_.text)
			end

			local var_571_8 = math.max(var_571_1, arg_568_1.talkMaxDuration)

			if var_571_0 <= arg_568_1.time_ and arg_568_1.time_ < var_571_0 + var_571_8 then
				arg_568_1.typewritter.percent = (arg_568_1.time_ - var_571_0) / var_571_8

				arg_568_1.typewritter:SetDirty()
			end

			if arg_568_1.time_ >= var_571_0 + var_571_8 and arg_568_1.time_ < var_571_0 + var_571_8 + arg_571_0 then
				arg_568_1.typewritter.percent = 1

				arg_568_1.typewritter:SetDirty()
				arg_568_1:ShowNextGo(true)
			end
		end

		arg_568_1.nodeConfigList_ = {}

		arg_568_1:InitPlayNodeList()
	end,
	Play420012138 = function(arg_572_0, arg_572_1)
		arg_572_1.time_ = 0
		arg_572_1.frameCnt_ = 0
		arg_572_1.state_ = "playing"
		arg_572_1.curTalkId_ = 420012138
		arg_572_1.duration_ = 6.1

		local var_572_0 = {
			zh = 3.566,
			ja = 6.1
		}
		local var_572_1 = manager.audio:GetLocalizationFlag()

		if var_572_0[var_572_1] ~= nil then
			arg_572_1.duration_ = var_572_0[var_572_1]
		end

		SetActive(arg_572_1.tipsGo_, false)

		function arg_572_1.onSingleLineFinish_()
			arg_572_1.onSingleLineUpdate_ = nil
			arg_572_1.onSingleLineFinish_ = nil
			arg_572_1.state_ = "waiting"
		end

		function arg_572_1.playNext_(arg_574_0)
			if arg_574_0 == 1 then
				arg_572_0:Play420012139(arg_572_1)
			end
		end

		function arg_572_1.onSingleLineUpdate_(arg_575_0)
			local var_575_0 = arg_572_1.actors_["1085ui_story"].transform
			local var_575_1 = 0

			if var_575_1 < arg_572_1.time_ and arg_572_1.time_ <= var_575_1 + arg_575_0 then
				arg_572_1.var_.moveOldPos1085ui_story = var_575_0.localPosition
			end

			local var_575_2 = 0.001

			if var_575_1 <= arg_572_1.time_ and arg_572_1.time_ < var_575_1 + var_575_2 then
				local var_575_3 = (arg_572_1.time_ - var_575_1) / var_575_2
				local var_575_4 = Vector3.New(0, -1.01, -5.83)

				var_575_0.localPosition = Vector3.Lerp(arg_572_1.var_.moveOldPos1085ui_story, var_575_4, var_575_3)

				local var_575_5 = manager.ui.mainCamera.transform.position - var_575_0.position

				var_575_0.forward = Vector3.New(var_575_5.x, var_575_5.y, var_575_5.z)

				local var_575_6 = var_575_0.localEulerAngles

				var_575_6.z = 0
				var_575_6.x = 0
				var_575_0.localEulerAngles = var_575_6
			end

			if arg_572_1.time_ >= var_575_1 + var_575_2 and arg_572_1.time_ < var_575_1 + var_575_2 + arg_575_0 then
				var_575_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_575_7 = manager.ui.mainCamera.transform.position - var_575_0.position

				var_575_0.forward = Vector3.New(var_575_7.x, var_575_7.y, var_575_7.z)

				local var_575_8 = var_575_0.localEulerAngles

				var_575_8.z = 0
				var_575_8.x = 0
				var_575_0.localEulerAngles = var_575_8
			end

			local var_575_9 = arg_572_1.actors_["1085ui_story"]
			local var_575_10 = 0

			if var_575_10 < arg_572_1.time_ and arg_572_1.time_ <= var_575_10 + arg_575_0 and not isNil(var_575_9) and arg_572_1.var_.characterEffect1085ui_story == nil then
				arg_572_1.var_.characterEffect1085ui_story = var_575_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_575_11 = 0.200000002980232

			if var_575_10 <= arg_572_1.time_ and arg_572_1.time_ < var_575_10 + var_575_11 and not isNil(var_575_9) then
				local var_575_12 = (arg_572_1.time_ - var_575_10) / var_575_11

				if arg_572_1.var_.characterEffect1085ui_story and not isNil(var_575_9) then
					arg_572_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_572_1.time_ >= var_575_10 + var_575_11 and arg_572_1.time_ < var_575_10 + var_575_11 + arg_575_0 and not isNil(var_575_9) and arg_572_1.var_.characterEffect1085ui_story then
				arg_572_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_575_13 = 0

			if var_575_13 < arg_572_1.time_ and arg_572_1.time_ <= var_575_13 + arg_575_0 then
				arg_572_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_575_14 = 0

			if var_575_14 < arg_572_1.time_ and arg_572_1.time_ <= var_575_14 + arg_575_0 then
				arg_572_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action7_2")
			end

			local var_575_15 = 0
			local var_575_16 = 0.35

			if var_575_15 < arg_572_1.time_ and arg_572_1.time_ <= var_575_15 + arg_575_0 then
				arg_572_1.talkMaxDuration = 0
				arg_572_1.dialogCg_.alpha = 1

				arg_572_1.dialog_:SetActive(true)
				SetActive(arg_572_1.leftNameGo_, true)

				local var_575_17 = arg_572_1:FormatText(StoryNameCfg[328].name)

				arg_572_1.leftNameTxt_.text = var_575_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_572_1.leftNameTxt_.transform)

				arg_572_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_572_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_572_1:RecordName(arg_572_1.leftNameTxt_.text)
				SetActive(arg_572_1.iconTrs_.gameObject, false)
				arg_572_1.callingController_:SetSelectedState("normal")

				local var_575_18 = arg_572_1:GetWordFromCfg(420012138)
				local var_575_19 = arg_572_1:FormatText(var_575_18.content)

				arg_572_1.text_.text = var_575_19

				LuaForUtil.ClearLinePrefixSymbol(arg_572_1.text_)

				local var_575_20 = 14
				local var_575_21 = utf8.len(var_575_19)
				local var_575_22 = var_575_20 <= 0 and var_575_16 or var_575_16 * (var_575_21 / var_575_20)

				if var_575_22 > 0 and var_575_16 < var_575_22 then
					arg_572_1.talkMaxDuration = var_575_22

					if var_575_22 + var_575_15 > arg_572_1.duration_ then
						arg_572_1.duration_ = var_575_22 + var_575_15
					end
				end

				arg_572_1.text_.text = var_575_19
				arg_572_1.typewritter.percent = 0

				arg_572_1.typewritter:SetDirty()
				arg_572_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012138", "story_v_out_420012.awb") ~= 0 then
					local var_575_23 = manager.audio:GetVoiceLength("story_v_out_420012", "420012138", "story_v_out_420012.awb") / 1000

					if var_575_23 + var_575_15 > arg_572_1.duration_ then
						arg_572_1.duration_ = var_575_23 + var_575_15
					end

					if var_575_18.prefab_name ~= "" and arg_572_1.actors_[var_575_18.prefab_name] ~= nil then
						local var_575_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_572_1.actors_[var_575_18.prefab_name].transform, "story_v_out_420012", "420012138", "story_v_out_420012.awb")

						arg_572_1:RecordAudio("420012138", var_575_24)
						arg_572_1:RecordAudio("420012138", var_575_24)
					else
						arg_572_1:AudioAction("play", "voice", "story_v_out_420012", "420012138", "story_v_out_420012.awb")
					end

					arg_572_1:RecordHistoryTalkVoice("story_v_out_420012", "420012138", "story_v_out_420012.awb")
				end

				arg_572_1:RecordContent(arg_572_1.text_.text)
			end

			local var_575_25 = math.max(var_575_16, arg_572_1.talkMaxDuration)

			if var_575_15 <= arg_572_1.time_ and arg_572_1.time_ < var_575_15 + var_575_25 then
				arg_572_1.typewritter.percent = (arg_572_1.time_ - var_575_15) / var_575_25

				arg_572_1.typewritter:SetDirty()
			end

			if arg_572_1.time_ >= var_575_15 + var_575_25 and arg_572_1.time_ < var_575_15 + var_575_25 + arg_575_0 then
				arg_572_1.typewritter.percent = 1

				arg_572_1.typewritter:SetDirty()
				arg_572_1:ShowNextGo(true)
			end
		end

		arg_572_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_572_1:InitPlayNodeList()
	end,
	Play420012139 = function(arg_576_0, arg_576_1)
		arg_576_1.time_ = 0
		arg_576_1.frameCnt_ = 0
		arg_576_1.state_ = "playing"
		arg_576_1.curTalkId_ = 420012139
		arg_576_1.duration_ = 3.33

		local var_576_0 = {
			zh = 3.333,
			ja = 3.266
		}
		local var_576_1 = manager.audio:GetLocalizationFlag()

		if var_576_0[var_576_1] ~= nil then
			arg_576_1.duration_ = var_576_0[var_576_1]
		end

		SetActive(arg_576_1.tipsGo_, false)

		function arg_576_1.onSingleLineFinish_()
			arg_576_1.onSingleLineUpdate_ = nil
			arg_576_1.onSingleLineFinish_ = nil
			arg_576_1.state_ = "waiting"
		end

		function arg_576_1.playNext_(arg_578_0)
			if arg_578_0 == 1 then
				arg_576_0:Play420012140(arg_576_1)
			end
		end

		function arg_576_1.onSingleLineUpdate_(arg_579_0)
			local var_579_0 = 0
			local var_579_1 = 0.175

			if var_579_0 < arg_576_1.time_ and arg_576_1.time_ <= var_579_0 + arg_579_0 then
				arg_576_1.talkMaxDuration = 0
				arg_576_1.dialogCg_.alpha = 1

				arg_576_1.dialog_:SetActive(true)
				SetActive(arg_576_1.leftNameGo_, true)

				local var_579_2 = arg_576_1:FormatText(StoryNameCfg[328].name)

				arg_576_1.leftNameTxt_.text = var_579_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_576_1.leftNameTxt_.transform)

				arg_576_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_576_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_576_1:RecordName(arg_576_1.leftNameTxt_.text)
				SetActive(arg_576_1.iconTrs_.gameObject, false)
				arg_576_1.callingController_:SetSelectedState("normal")

				local var_579_3 = arg_576_1:GetWordFromCfg(420012139)
				local var_579_4 = arg_576_1:FormatText(var_579_3.content)

				arg_576_1.text_.text = var_579_4

				LuaForUtil.ClearLinePrefixSymbol(arg_576_1.text_)

				local var_579_5 = 7
				local var_579_6 = utf8.len(var_579_4)
				local var_579_7 = var_579_5 <= 0 and var_579_1 or var_579_1 * (var_579_6 / var_579_5)

				if var_579_7 > 0 and var_579_1 < var_579_7 then
					arg_576_1.talkMaxDuration = var_579_7

					if var_579_7 + var_579_0 > arg_576_1.duration_ then
						arg_576_1.duration_ = var_579_7 + var_579_0
					end
				end

				arg_576_1.text_.text = var_579_4
				arg_576_1.typewritter.percent = 0

				arg_576_1.typewritter:SetDirty()
				arg_576_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012139", "story_v_out_420012.awb") ~= 0 then
					local var_579_8 = manager.audio:GetVoiceLength("story_v_out_420012", "420012139", "story_v_out_420012.awb") / 1000

					if var_579_8 + var_579_0 > arg_576_1.duration_ then
						arg_576_1.duration_ = var_579_8 + var_579_0
					end

					if var_579_3.prefab_name ~= "" and arg_576_1.actors_[var_579_3.prefab_name] ~= nil then
						local var_579_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_576_1.actors_[var_579_3.prefab_name].transform, "story_v_out_420012", "420012139", "story_v_out_420012.awb")

						arg_576_1:RecordAudio("420012139", var_579_9)
						arg_576_1:RecordAudio("420012139", var_579_9)
					else
						arg_576_1:AudioAction("play", "voice", "story_v_out_420012", "420012139", "story_v_out_420012.awb")
					end

					arg_576_1:RecordHistoryTalkVoice("story_v_out_420012", "420012139", "story_v_out_420012.awb")
				end

				arg_576_1:RecordContent(arg_576_1.text_.text)
			end

			local var_579_10 = math.max(var_579_1, arg_576_1.talkMaxDuration)

			if var_579_0 <= arg_576_1.time_ and arg_576_1.time_ < var_579_0 + var_579_10 then
				arg_576_1.typewritter.percent = (arg_576_1.time_ - var_579_0) / var_579_10

				arg_576_1.typewritter:SetDirty()
			end

			if arg_576_1.time_ >= var_579_0 + var_579_10 and arg_576_1.time_ < var_579_0 + var_579_10 + arg_579_0 then
				arg_576_1.typewritter.percent = 1

				arg_576_1.typewritter:SetDirty()
				arg_576_1:ShowNextGo(true)
			end
		end

		arg_576_1.nodeConfigList_ = {}

		arg_576_1:InitPlayNodeList()
	end,
	Play420012140 = function(arg_580_0, arg_580_1)
		arg_580_1.time_ = 0
		arg_580_1.frameCnt_ = 0
		arg_580_1.state_ = "playing"
		arg_580_1.curTalkId_ = 420012140
		arg_580_1.duration_ = 5

		SetActive(arg_580_1.tipsGo_, false)

		function arg_580_1.onSingleLineFinish_()
			arg_580_1.onSingleLineUpdate_ = nil
			arg_580_1.onSingleLineFinish_ = nil
			arg_580_1.state_ = "waiting"
		end

		function arg_580_1.playNext_(arg_582_0)
			if arg_582_0 == 1 then
				arg_580_0:Play420012141(arg_580_1)
			end
		end

		function arg_580_1.onSingleLineUpdate_(arg_583_0)
			local var_583_0 = arg_580_1.actors_["1085ui_story"]
			local var_583_1 = 0

			if var_583_1 < arg_580_1.time_ and arg_580_1.time_ <= var_583_1 + arg_583_0 and not isNil(var_583_0) and arg_580_1.var_.characterEffect1085ui_story == nil then
				arg_580_1.var_.characterEffect1085ui_story = var_583_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_583_2 = 0.200000002980232

			if var_583_1 <= arg_580_1.time_ and arg_580_1.time_ < var_583_1 + var_583_2 and not isNil(var_583_0) then
				local var_583_3 = (arg_580_1.time_ - var_583_1) / var_583_2

				if arg_580_1.var_.characterEffect1085ui_story and not isNil(var_583_0) then
					local var_583_4 = Mathf.Lerp(0, 0.5, var_583_3)

					arg_580_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_580_1.var_.characterEffect1085ui_story.fillRatio = var_583_4
				end
			end

			if arg_580_1.time_ >= var_583_1 + var_583_2 and arg_580_1.time_ < var_583_1 + var_583_2 + arg_583_0 and not isNil(var_583_0) and arg_580_1.var_.characterEffect1085ui_story then
				local var_583_5 = 0.5

				arg_580_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_580_1.var_.characterEffect1085ui_story.fillRatio = var_583_5
			end

			local var_583_6 = 0
			local var_583_7 = 0.6

			if var_583_6 < arg_580_1.time_ and arg_580_1.time_ <= var_583_6 + arg_583_0 then
				arg_580_1.talkMaxDuration = 0
				arg_580_1.dialogCg_.alpha = 1

				arg_580_1.dialog_:SetActive(true)
				SetActive(arg_580_1.leftNameGo_, true)

				local var_583_8 = arg_580_1:FormatText(StoryNameCfg[7].name)

				arg_580_1.leftNameTxt_.text = var_583_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_580_1.leftNameTxt_.transform)

				arg_580_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_580_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_580_1:RecordName(arg_580_1.leftNameTxt_.text)
				SetActive(arg_580_1.iconTrs_.gameObject, true)
				arg_580_1.iconController_:SetSelectedState("hero")

				arg_580_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_580_1.callingController_:SetSelectedState("normal")

				arg_580_1.keyicon_.color = Color.New(1, 1, 1)
				arg_580_1.icon_.color = Color.New(1, 1, 1)

				local var_583_9 = arg_580_1:GetWordFromCfg(420012140)
				local var_583_10 = arg_580_1:FormatText(var_583_9.content)

				arg_580_1.text_.text = var_583_10

				LuaForUtil.ClearLinePrefixSymbol(arg_580_1.text_)

				local var_583_11 = 24
				local var_583_12 = utf8.len(var_583_10)
				local var_583_13 = var_583_11 <= 0 and var_583_7 or var_583_7 * (var_583_12 / var_583_11)

				if var_583_13 > 0 and var_583_7 < var_583_13 then
					arg_580_1.talkMaxDuration = var_583_13

					if var_583_13 + var_583_6 > arg_580_1.duration_ then
						arg_580_1.duration_ = var_583_13 + var_583_6
					end
				end

				arg_580_1.text_.text = var_583_10
				arg_580_1.typewritter.percent = 0

				arg_580_1.typewritter:SetDirty()
				arg_580_1:ShowNextGo(false)
				arg_580_1:RecordContent(arg_580_1.text_.text)
			end

			local var_583_14 = math.max(var_583_7, arg_580_1.talkMaxDuration)

			if var_583_6 <= arg_580_1.time_ and arg_580_1.time_ < var_583_6 + var_583_14 then
				arg_580_1.typewritter.percent = (arg_580_1.time_ - var_583_6) / var_583_14

				arg_580_1.typewritter:SetDirty()
			end

			if arg_580_1.time_ >= var_583_6 + var_583_14 and arg_580_1.time_ < var_583_6 + var_583_14 + arg_583_0 then
				arg_580_1.typewritter.percent = 1

				arg_580_1.typewritter:SetDirty()
				arg_580_1:ShowNextGo(true)
			end
		end

		arg_580_1.nodeConfigList_ = {}

		arg_580_1:InitPlayNodeList()
	end,
	Play420012141 = function(arg_584_0, arg_584_1)
		arg_584_1.time_ = 0
		arg_584_1.frameCnt_ = 0
		arg_584_1.state_ = "playing"
		arg_584_1.curTalkId_ = 420012141
		arg_584_1.duration_ = 3.43

		local var_584_0 = {
			zh = 3.433,
			ja = 2.9
		}
		local var_584_1 = manager.audio:GetLocalizationFlag()

		if var_584_0[var_584_1] ~= nil then
			arg_584_1.duration_ = var_584_0[var_584_1]
		end

		SetActive(arg_584_1.tipsGo_, false)

		function arg_584_1.onSingleLineFinish_()
			arg_584_1.onSingleLineUpdate_ = nil
			arg_584_1.onSingleLineFinish_ = nil
			arg_584_1.state_ = "waiting"
		end

		function arg_584_1.playNext_(arg_586_0)
			if arg_586_0 == 1 then
				arg_584_0:Play420012142(arg_584_1)
			end
		end

		function arg_584_1.onSingleLineUpdate_(arg_587_0)
			local var_587_0 = arg_584_1.actors_["1085ui_story"]
			local var_587_1 = 0

			if var_587_1 < arg_584_1.time_ and arg_584_1.time_ <= var_587_1 + arg_587_0 and not isNil(var_587_0) and arg_584_1.var_.characterEffect1085ui_story == nil then
				arg_584_1.var_.characterEffect1085ui_story = var_587_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_587_2 = 0.200000002980232

			if var_587_1 <= arg_584_1.time_ and arg_584_1.time_ < var_587_1 + var_587_2 and not isNil(var_587_0) then
				local var_587_3 = (arg_584_1.time_ - var_587_1) / var_587_2

				if arg_584_1.var_.characterEffect1085ui_story and not isNil(var_587_0) then
					arg_584_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_584_1.time_ >= var_587_1 + var_587_2 and arg_584_1.time_ < var_587_1 + var_587_2 + arg_587_0 and not isNil(var_587_0) and arg_584_1.var_.characterEffect1085ui_story then
				arg_584_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_587_4 = 0
			local var_587_5 = 0.375

			if var_587_4 < arg_584_1.time_ and arg_584_1.time_ <= var_587_4 + arg_587_0 then
				arg_584_1.talkMaxDuration = 0
				arg_584_1.dialogCg_.alpha = 1

				arg_584_1.dialog_:SetActive(true)
				SetActive(arg_584_1.leftNameGo_, true)

				local var_587_6 = arg_584_1:FormatText(StoryNameCfg[328].name)

				arg_584_1.leftNameTxt_.text = var_587_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_584_1.leftNameTxt_.transform)

				arg_584_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_584_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_584_1:RecordName(arg_584_1.leftNameTxt_.text)
				SetActive(arg_584_1.iconTrs_.gameObject, false)
				arg_584_1.callingController_:SetSelectedState("normal")

				local var_587_7 = arg_584_1:GetWordFromCfg(420012141)
				local var_587_8 = arg_584_1:FormatText(var_587_7.content)

				arg_584_1.text_.text = var_587_8

				LuaForUtil.ClearLinePrefixSymbol(arg_584_1.text_)

				local var_587_9 = 15
				local var_587_10 = utf8.len(var_587_8)
				local var_587_11 = var_587_9 <= 0 and var_587_5 or var_587_5 * (var_587_10 / var_587_9)

				if var_587_11 > 0 and var_587_5 < var_587_11 then
					arg_584_1.talkMaxDuration = var_587_11

					if var_587_11 + var_587_4 > arg_584_1.duration_ then
						arg_584_1.duration_ = var_587_11 + var_587_4
					end
				end

				arg_584_1.text_.text = var_587_8
				arg_584_1.typewritter.percent = 0

				arg_584_1.typewritter:SetDirty()
				arg_584_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012141", "story_v_out_420012.awb") ~= 0 then
					local var_587_12 = manager.audio:GetVoiceLength("story_v_out_420012", "420012141", "story_v_out_420012.awb") / 1000

					if var_587_12 + var_587_4 > arg_584_1.duration_ then
						arg_584_1.duration_ = var_587_12 + var_587_4
					end

					if var_587_7.prefab_name ~= "" and arg_584_1.actors_[var_587_7.prefab_name] ~= nil then
						local var_587_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_584_1.actors_[var_587_7.prefab_name].transform, "story_v_out_420012", "420012141", "story_v_out_420012.awb")

						arg_584_1:RecordAudio("420012141", var_587_13)
						arg_584_1:RecordAudio("420012141", var_587_13)
					else
						arg_584_1:AudioAction("play", "voice", "story_v_out_420012", "420012141", "story_v_out_420012.awb")
					end

					arg_584_1:RecordHistoryTalkVoice("story_v_out_420012", "420012141", "story_v_out_420012.awb")
				end

				arg_584_1:RecordContent(arg_584_1.text_.text)
			end

			local var_587_14 = math.max(var_587_5, arg_584_1.talkMaxDuration)

			if var_587_4 <= arg_584_1.time_ and arg_584_1.time_ < var_587_4 + var_587_14 then
				arg_584_1.typewritter.percent = (arg_584_1.time_ - var_587_4) / var_587_14

				arg_584_1.typewritter:SetDirty()
			end

			if arg_584_1.time_ >= var_587_4 + var_587_14 and arg_584_1.time_ < var_587_4 + var_587_14 + arg_587_0 then
				arg_584_1.typewritter.percent = 1

				arg_584_1.typewritter:SetDirty()
				arg_584_1:ShowNextGo(true)
			end
		end

		arg_584_1.nodeConfigList_ = {}

		arg_584_1:InitPlayNodeList()
	end,
	Play420012142 = function(arg_588_0, arg_588_1)
		arg_588_1.time_ = 0
		arg_588_1.frameCnt_ = 0
		arg_588_1.state_ = "playing"
		arg_588_1.curTalkId_ = 420012142
		arg_588_1.duration_ = 5

		SetActive(arg_588_1.tipsGo_, false)

		function arg_588_1.onSingleLineFinish_()
			arg_588_1.onSingleLineUpdate_ = nil
			arg_588_1.onSingleLineFinish_ = nil
			arg_588_1.state_ = "waiting"
		end

		function arg_588_1.playNext_(arg_590_0)
			if arg_590_0 == 1 then
				arg_588_0:Play420012143(arg_588_1)
			end
		end

		function arg_588_1.onSingleLineUpdate_(arg_591_0)
			local var_591_0 = arg_588_1.actors_["1085ui_story"].transform
			local var_591_1 = 0

			if var_591_1 < arg_588_1.time_ and arg_588_1.time_ <= var_591_1 + arg_591_0 then
				arg_588_1.var_.moveOldPos1085ui_story = var_591_0.localPosition
			end

			local var_591_2 = 0.001

			if var_591_1 <= arg_588_1.time_ and arg_588_1.time_ < var_591_1 + var_591_2 then
				local var_591_3 = (arg_588_1.time_ - var_591_1) / var_591_2
				local var_591_4 = Vector3.New(0, 100, 0)

				var_591_0.localPosition = Vector3.Lerp(arg_588_1.var_.moveOldPos1085ui_story, var_591_4, var_591_3)

				local var_591_5 = manager.ui.mainCamera.transform.position - var_591_0.position

				var_591_0.forward = Vector3.New(var_591_5.x, var_591_5.y, var_591_5.z)

				local var_591_6 = var_591_0.localEulerAngles

				var_591_6.z = 0
				var_591_6.x = 0
				var_591_0.localEulerAngles = var_591_6
			end

			if arg_588_1.time_ >= var_591_1 + var_591_2 and arg_588_1.time_ < var_591_1 + var_591_2 + arg_591_0 then
				var_591_0.localPosition = Vector3.New(0, 100, 0)

				local var_591_7 = manager.ui.mainCamera.transform.position - var_591_0.position

				var_591_0.forward = Vector3.New(var_591_7.x, var_591_7.y, var_591_7.z)

				local var_591_8 = var_591_0.localEulerAngles

				var_591_8.z = 0
				var_591_8.x = 0
				var_591_0.localEulerAngles = var_591_8
			end

			local var_591_9 = 0.200000002980232
			local var_591_10 = 1

			if var_591_9 < arg_588_1.time_ and arg_588_1.time_ <= var_591_9 + arg_591_0 then
				local var_591_11 = "play"
				local var_591_12 = "effect"

				arg_588_1:AudioAction(var_591_11, var_591_12, "se_story_140", "se_story_140_foley_hold", "")
			end

			local var_591_13 = 0
			local var_591_14 = 0.775

			if var_591_13 < arg_588_1.time_ and arg_588_1.time_ <= var_591_13 + arg_591_0 then
				arg_588_1.talkMaxDuration = 0
				arg_588_1.dialogCg_.alpha = 1

				arg_588_1.dialog_:SetActive(true)
				SetActive(arg_588_1.leftNameGo_, false)

				arg_588_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_588_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_588_1:RecordName(arg_588_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_588_1.iconTrs_.gameObject, false)
				arg_588_1.callingController_:SetSelectedState("normal")

				local var_591_15 = arg_588_1:GetWordFromCfg(420012142)
				local var_591_16 = arg_588_1:FormatText(var_591_15.content)

				arg_588_1.text_.text = var_591_16

				LuaForUtil.ClearLinePrefixSymbol(arg_588_1.text_)

				local var_591_17 = 31
				local var_591_18 = utf8.len(var_591_16)
				local var_591_19 = var_591_17 <= 0 and var_591_14 or var_591_14 * (var_591_18 / var_591_17)

				if var_591_19 > 0 and var_591_14 < var_591_19 then
					arg_588_1.talkMaxDuration = var_591_19

					if var_591_19 + var_591_13 > arg_588_1.duration_ then
						arg_588_1.duration_ = var_591_19 + var_591_13
					end
				end

				arg_588_1.text_.text = var_591_16
				arg_588_1.typewritter.percent = 0

				arg_588_1.typewritter:SetDirty()
				arg_588_1:ShowNextGo(false)
				arg_588_1:RecordContent(arg_588_1.text_.text)
			end

			local var_591_20 = math.max(var_591_14, arg_588_1.talkMaxDuration)

			if var_591_13 <= arg_588_1.time_ and arg_588_1.time_ < var_591_13 + var_591_20 then
				arg_588_1.typewritter.percent = (arg_588_1.time_ - var_591_13) / var_591_20

				arg_588_1.typewritter:SetDirty()
			end

			if arg_588_1.time_ >= var_591_13 + var_591_20 and arg_588_1.time_ < var_591_13 + var_591_20 + arg_591_0 then
				arg_588_1.typewritter.percent = 1

				arg_588_1.typewritter:SetDirty()
				arg_588_1:ShowNextGo(true)
			end
		end

		arg_588_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_588_1:InitPlayNodeList()
	end,
	Play420012143 = function(arg_592_0, arg_592_1)
		arg_592_1.time_ = 0
		arg_592_1.frameCnt_ = 0
		arg_592_1.state_ = "playing"
		arg_592_1.curTalkId_ = 420012143
		arg_592_1.duration_ = 5

		SetActive(arg_592_1.tipsGo_, false)

		function arg_592_1.onSingleLineFinish_()
			arg_592_1.onSingleLineUpdate_ = nil
			arg_592_1.onSingleLineFinish_ = nil
			arg_592_1.state_ = "waiting"
		end

		function arg_592_1.playNext_(arg_594_0)
			if arg_594_0 == 1 then
				arg_592_0:Play420012144(arg_592_1)
			end
		end

		function arg_592_1.onSingleLineUpdate_(arg_595_0)
			local var_595_0 = 0
			local var_595_1 = 0.1

			if var_595_0 < arg_592_1.time_ and arg_592_1.time_ <= var_595_0 + arg_595_0 then
				arg_592_1.talkMaxDuration = 0
				arg_592_1.dialogCg_.alpha = 1

				arg_592_1.dialog_:SetActive(true)
				SetActive(arg_592_1.leftNameGo_, true)

				local var_595_2 = arg_592_1:FormatText(StoryNameCfg[7].name)

				arg_592_1.leftNameTxt_.text = var_595_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_592_1.leftNameTxt_.transform)

				arg_592_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_592_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_592_1:RecordName(arg_592_1.leftNameTxt_.text)
				SetActive(arg_592_1.iconTrs_.gameObject, true)
				arg_592_1.iconController_:SetSelectedState("hero")

				arg_592_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_592_1.callingController_:SetSelectedState("normal")

				arg_592_1.keyicon_.color = Color.New(1, 1, 1)
				arg_592_1.icon_.color = Color.New(1, 1, 1)

				local var_595_3 = arg_592_1:GetWordFromCfg(420012143)
				local var_595_4 = arg_592_1:FormatText(var_595_3.content)

				arg_592_1.text_.text = var_595_4

				LuaForUtil.ClearLinePrefixSymbol(arg_592_1.text_)

				local var_595_5 = 4
				local var_595_6 = utf8.len(var_595_4)
				local var_595_7 = var_595_5 <= 0 and var_595_1 or var_595_1 * (var_595_6 / var_595_5)

				if var_595_7 > 0 and var_595_1 < var_595_7 then
					arg_592_1.talkMaxDuration = var_595_7

					if var_595_7 + var_595_0 > arg_592_1.duration_ then
						arg_592_1.duration_ = var_595_7 + var_595_0
					end
				end

				arg_592_1.text_.text = var_595_4
				arg_592_1.typewritter.percent = 0

				arg_592_1.typewritter:SetDirty()
				arg_592_1:ShowNextGo(false)
				arg_592_1:RecordContent(arg_592_1.text_.text)
			end

			local var_595_8 = math.max(var_595_1, arg_592_1.talkMaxDuration)

			if var_595_0 <= arg_592_1.time_ and arg_592_1.time_ < var_595_0 + var_595_8 then
				arg_592_1.typewritter.percent = (arg_592_1.time_ - var_595_0) / var_595_8

				arg_592_1.typewritter:SetDirty()
			end

			if arg_592_1.time_ >= var_595_0 + var_595_8 and arg_592_1.time_ < var_595_0 + var_595_8 + arg_595_0 then
				arg_592_1.typewritter.percent = 1

				arg_592_1.typewritter:SetDirty()
				arg_592_1:ShowNextGo(true)
			end
		end

		arg_592_1.nodeConfigList_ = {}

		arg_592_1:InitPlayNodeList()
	end,
	Play420012144 = function(arg_596_0, arg_596_1)
		arg_596_1.time_ = 0
		arg_596_1.frameCnt_ = 0
		arg_596_1.state_ = "playing"
		arg_596_1.curTalkId_ = 420012144
		arg_596_1.duration_ = 3.57

		local var_596_0 = {
			zh = 1.999999999999,
			ja = 3.566
		}
		local var_596_1 = manager.audio:GetLocalizationFlag()

		if var_596_0[var_596_1] ~= nil then
			arg_596_1.duration_ = var_596_0[var_596_1]
		end

		SetActive(arg_596_1.tipsGo_, false)

		function arg_596_1.onSingleLineFinish_()
			arg_596_1.onSingleLineUpdate_ = nil
			arg_596_1.onSingleLineFinish_ = nil
			arg_596_1.state_ = "waiting"
		end

		function arg_596_1.playNext_(arg_598_0)
			if arg_598_0 == 1 then
				arg_596_0:Play420012145(arg_596_1)
			end
		end

		function arg_596_1.onSingleLineUpdate_(arg_599_0)
			local var_599_0 = arg_596_1.actors_["1085ui_story"].transform
			local var_599_1 = 0

			if var_599_1 < arg_596_1.time_ and arg_596_1.time_ <= var_599_1 + arg_599_0 then
				arg_596_1.var_.moveOldPos1085ui_story = var_599_0.localPosition
			end

			local var_599_2 = 0.001

			if var_599_1 <= arg_596_1.time_ and arg_596_1.time_ < var_599_1 + var_599_2 then
				local var_599_3 = (arg_596_1.time_ - var_599_1) / var_599_2
				local var_599_4 = Vector3.New(0, -1.01, -5.83)

				var_599_0.localPosition = Vector3.Lerp(arg_596_1.var_.moveOldPos1085ui_story, var_599_4, var_599_3)

				local var_599_5 = manager.ui.mainCamera.transform.position - var_599_0.position

				var_599_0.forward = Vector3.New(var_599_5.x, var_599_5.y, var_599_5.z)

				local var_599_6 = var_599_0.localEulerAngles

				var_599_6.z = 0
				var_599_6.x = 0
				var_599_0.localEulerAngles = var_599_6
			end

			if arg_596_1.time_ >= var_599_1 + var_599_2 and arg_596_1.time_ < var_599_1 + var_599_2 + arg_599_0 then
				var_599_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_599_7 = manager.ui.mainCamera.transform.position - var_599_0.position

				var_599_0.forward = Vector3.New(var_599_7.x, var_599_7.y, var_599_7.z)

				local var_599_8 = var_599_0.localEulerAngles

				var_599_8.z = 0
				var_599_8.x = 0
				var_599_0.localEulerAngles = var_599_8
			end

			local var_599_9 = arg_596_1.actors_["1085ui_story"]
			local var_599_10 = 0

			if var_599_10 < arg_596_1.time_ and arg_596_1.time_ <= var_599_10 + arg_599_0 and not isNil(var_599_9) and arg_596_1.var_.characterEffect1085ui_story == nil then
				arg_596_1.var_.characterEffect1085ui_story = var_599_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_599_11 = 0.200000002980232

			if var_599_10 <= arg_596_1.time_ and arg_596_1.time_ < var_599_10 + var_599_11 and not isNil(var_599_9) then
				local var_599_12 = (arg_596_1.time_ - var_599_10) / var_599_11

				if arg_596_1.var_.characterEffect1085ui_story and not isNil(var_599_9) then
					arg_596_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_596_1.time_ >= var_599_10 + var_599_11 and arg_596_1.time_ < var_599_10 + var_599_11 + arg_599_0 and not isNil(var_599_9) and arg_596_1.var_.characterEffect1085ui_story then
				arg_596_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_599_13 = 0

			if var_599_13 < arg_596_1.time_ and arg_596_1.time_ <= var_599_13 + arg_599_0 then
				arg_596_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action5_1")
			end

			local var_599_14 = 0

			if var_599_14 < arg_596_1.time_ and arg_596_1.time_ <= var_599_14 + arg_599_0 then
				arg_596_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_599_15 = 0
			local var_599_16 = 0.15

			if var_599_15 < arg_596_1.time_ and arg_596_1.time_ <= var_599_15 + arg_599_0 then
				arg_596_1.talkMaxDuration = 0
				arg_596_1.dialogCg_.alpha = 1

				arg_596_1.dialog_:SetActive(true)
				SetActive(arg_596_1.leftNameGo_, true)

				local var_599_17 = arg_596_1:FormatText(StoryNameCfg[328].name)

				arg_596_1.leftNameTxt_.text = var_599_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_596_1.leftNameTxt_.transform)

				arg_596_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_596_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_596_1:RecordName(arg_596_1.leftNameTxt_.text)
				SetActive(arg_596_1.iconTrs_.gameObject, false)
				arg_596_1.callingController_:SetSelectedState("normal")

				local var_599_18 = arg_596_1:GetWordFromCfg(420012144)
				local var_599_19 = arg_596_1:FormatText(var_599_18.content)

				arg_596_1.text_.text = var_599_19

				LuaForUtil.ClearLinePrefixSymbol(arg_596_1.text_)

				local var_599_20 = 6
				local var_599_21 = utf8.len(var_599_19)
				local var_599_22 = var_599_20 <= 0 and var_599_16 or var_599_16 * (var_599_21 / var_599_20)

				if var_599_22 > 0 and var_599_16 < var_599_22 then
					arg_596_1.talkMaxDuration = var_599_22

					if var_599_22 + var_599_15 > arg_596_1.duration_ then
						arg_596_1.duration_ = var_599_22 + var_599_15
					end
				end

				arg_596_1.text_.text = var_599_19
				arg_596_1.typewritter.percent = 0

				arg_596_1.typewritter:SetDirty()
				arg_596_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012144", "story_v_out_420012.awb") ~= 0 then
					local var_599_23 = manager.audio:GetVoiceLength("story_v_out_420012", "420012144", "story_v_out_420012.awb") / 1000

					if var_599_23 + var_599_15 > arg_596_1.duration_ then
						arg_596_1.duration_ = var_599_23 + var_599_15
					end

					if var_599_18.prefab_name ~= "" and arg_596_1.actors_[var_599_18.prefab_name] ~= nil then
						local var_599_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_596_1.actors_[var_599_18.prefab_name].transform, "story_v_out_420012", "420012144", "story_v_out_420012.awb")

						arg_596_1:RecordAudio("420012144", var_599_24)
						arg_596_1:RecordAudio("420012144", var_599_24)
					else
						arg_596_1:AudioAction("play", "voice", "story_v_out_420012", "420012144", "story_v_out_420012.awb")
					end

					arg_596_1:RecordHistoryTalkVoice("story_v_out_420012", "420012144", "story_v_out_420012.awb")
				end

				arg_596_1:RecordContent(arg_596_1.text_.text)
			end

			local var_599_25 = math.max(var_599_16, arg_596_1.talkMaxDuration)

			if var_599_15 <= arg_596_1.time_ and arg_596_1.time_ < var_599_15 + var_599_25 then
				arg_596_1.typewritter.percent = (arg_596_1.time_ - var_599_15) / var_599_25

				arg_596_1.typewritter:SetDirty()
			end

			if arg_596_1.time_ >= var_599_15 + var_599_25 and arg_596_1.time_ < var_599_15 + var_599_25 + arg_599_0 then
				arg_596_1.typewritter.percent = 1

				arg_596_1.typewritter:SetDirty()
				arg_596_1:ShowNextGo(true)
			end
		end

		arg_596_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_596_1:InitPlayNodeList()
	end,
	Play420012145 = function(arg_600_0, arg_600_1)
		arg_600_1.time_ = 0
		arg_600_1.frameCnt_ = 0
		arg_600_1.state_ = "playing"
		arg_600_1.curTalkId_ = 420012145
		arg_600_1.duration_ = 5

		SetActive(arg_600_1.tipsGo_, false)

		function arg_600_1.onSingleLineFinish_()
			arg_600_1.onSingleLineUpdate_ = nil
			arg_600_1.onSingleLineFinish_ = nil
			arg_600_1.state_ = "waiting"
		end

		function arg_600_1.playNext_(arg_602_0)
			if arg_602_0 == 1 then
				arg_600_0:Play420012146(arg_600_1)
			end
		end

		function arg_600_1.onSingleLineUpdate_(arg_603_0)
			local var_603_0 = arg_600_1.actors_["1085ui_story"]
			local var_603_1 = 0

			if var_603_1 < arg_600_1.time_ and arg_600_1.time_ <= var_603_1 + arg_603_0 and not isNil(var_603_0) and arg_600_1.var_.characterEffect1085ui_story == nil then
				arg_600_1.var_.characterEffect1085ui_story = var_603_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_603_2 = 0.200000002980232

			if var_603_1 <= arg_600_1.time_ and arg_600_1.time_ < var_603_1 + var_603_2 and not isNil(var_603_0) then
				local var_603_3 = (arg_600_1.time_ - var_603_1) / var_603_2

				if arg_600_1.var_.characterEffect1085ui_story and not isNil(var_603_0) then
					local var_603_4 = Mathf.Lerp(0, 0.5, var_603_3)

					arg_600_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_600_1.var_.characterEffect1085ui_story.fillRatio = var_603_4
				end
			end

			if arg_600_1.time_ >= var_603_1 + var_603_2 and arg_600_1.time_ < var_603_1 + var_603_2 + arg_603_0 and not isNil(var_603_0) and arg_600_1.var_.characterEffect1085ui_story then
				local var_603_5 = 0.5

				arg_600_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_600_1.var_.characterEffect1085ui_story.fillRatio = var_603_5
			end

			local var_603_6 = 0
			local var_603_7 = 0.475

			if var_603_6 < arg_600_1.time_ and arg_600_1.time_ <= var_603_6 + arg_603_0 then
				arg_600_1.talkMaxDuration = 0
				arg_600_1.dialogCg_.alpha = 1

				arg_600_1.dialog_:SetActive(true)
				SetActive(arg_600_1.leftNameGo_, true)

				local var_603_8 = arg_600_1:FormatText(StoryNameCfg[7].name)

				arg_600_1.leftNameTxt_.text = var_603_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_600_1.leftNameTxt_.transform)

				arg_600_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_600_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_600_1:RecordName(arg_600_1.leftNameTxt_.text)
				SetActive(arg_600_1.iconTrs_.gameObject, true)
				arg_600_1.iconController_:SetSelectedState("hero")

				arg_600_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_600_1.callingController_:SetSelectedState("normal")

				arg_600_1.keyicon_.color = Color.New(1, 1, 1)
				arg_600_1.icon_.color = Color.New(1, 1, 1)

				local var_603_9 = arg_600_1:GetWordFromCfg(420012145)
				local var_603_10 = arg_600_1:FormatText(var_603_9.content)

				arg_600_1.text_.text = var_603_10

				LuaForUtil.ClearLinePrefixSymbol(arg_600_1.text_)

				local var_603_11 = 19
				local var_603_12 = utf8.len(var_603_10)
				local var_603_13 = var_603_11 <= 0 and var_603_7 or var_603_7 * (var_603_12 / var_603_11)

				if var_603_13 > 0 and var_603_7 < var_603_13 then
					arg_600_1.talkMaxDuration = var_603_13

					if var_603_13 + var_603_6 > arg_600_1.duration_ then
						arg_600_1.duration_ = var_603_13 + var_603_6
					end
				end

				arg_600_1.text_.text = var_603_10
				arg_600_1.typewritter.percent = 0

				arg_600_1.typewritter:SetDirty()
				arg_600_1:ShowNextGo(false)
				arg_600_1:RecordContent(arg_600_1.text_.text)
			end

			local var_603_14 = math.max(var_603_7, arg_600_1.talkMaxDuration)

			if var_603_6 <= arg_600_1.time_ and arg_600_1.time_ < var_603_6 + var_603_14 then
				arg_600_1.typewritter.percent = (arg_600_1.time_ - var_603_6) / var_603_14

				arg_600_1.typewritter:SetDirty()
			end

			if arg_600_1.time_ >= var_603_6 + var_603_14 and arg_600_1.time_ < var_603_6 + var_603_14 + arg_603_0 then
				arg_600_1.typewritter.percent = 1

				arg_600_1.typewritter:SetDirty()
				arg_600_1:ShowNextGo(true)
			end
		end

		arg_600_1.nodeConfigList_ = {}

		arg_600_1:InitPlayNodeList()
	end,
	Play420012146 = function(arg_604_0, arg_604_1)
		arg_604_1.time_ = 0
		arg_604_1.frameCnt_ = 0
		arg_604_1.state_ = "playing"
		arg_604_1.curTalkId_ = 420012146
		arg_604_1.duration_ = 4.87

		local var_604_0 = {
			zh = 3.6,
			ja = 4.866
		}
		local var_604_1 = manager.audio:GetLocalizationFlag()

		if var_604_0[var_604_1] ~= nil then
			arg_604_1.duration_ = var_604_0[var_604_1]
		end

		SetActive(arg_604_1.tipsGo_, false)

		function arg_604_1.onSingleLineFinish_()
			arg_604_1.onSingleLineUpdate_ = nil
			arg_604_1.onSingleLineFinish_ = nil
			arg_604_1.state_ = "waiting"
		end

		function arg_604_1.playNext_(arg_606_0)
			if arg_606_0 == 1 then
				arg_604_0:Play420012147(arg_604_1)
			end
		end

		function arg_604_1.onSingleLineUpdate_(arg_607_0)
			local var_607_0 = arg_604_1.actors_["1085ui_story"]
			local var_607_1 = 0

			if var_607_1 < arg_604_1.time_ and arg_604_1.time_ <= var_607_1 + arg_607_0 and not isNil(var_607_0) and arg_604_1.var_.characterEffect1085ui_story == nil then
				arg_604_1.var_.characterEffect1085ui_story = var_607_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_607_2 = 0.200000002980232

			if var_607_1 <= arg_604_1.time_ and arg_604_1.time_ < var_607_1 + var_607_2 and not isNil(var_607_0) then
				local var_607_3 = (arg_604_1.time_ - var_607_1) / var_607_2

				if arg_604_1.var_.characterEffect1085ui_story and not isNil(var_607_0) then
					arg_604_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_604_1.time_ >= var_607_1 + var_607_2 and arg_604_1.time_ < var_607_1 + var_607_2 + arg_607_0 and not isNil(var_607_0) and arg_604_1.var_.characterEffect1085ui_story then
				arg_604_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_607_4 = 0

			if var_607_4 < arg_604_1.time_ and arg_604_1.time_ <= var_607_4 + arg_607_0 then
				arg_604_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action5_2")
			end

			local var_607_5 = 0

			if var_607_5 < arg_604_1.time_ and arg_604_1.time_ <= var_607_5 + arg_607_0 then
				arg_604_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_607_6 = 0
			local var_607_7 = 0.225

			if var_607_6 < arg_604_1.time_ and arg_604_1.time_ <= var_607_6 + arg_607_0 then
				arg_604_1.talkMaxDuration = 0
				arg_604_1.dialogCg_.alpha = 1

				arg_604_1.dialog_:SetActive(true)
				SetActive(arg_604_1.leftNameGo_, true)

				local var_607_8 = arg_604_1:FormatText(StoryNameCfg[328].name)

				arg_604_1.leftNameTxt_.text = var_607_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_604_1.leftNameTxt_.transform)

				arg_604_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_604_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_604_1:RecordName(arg_604_1.leftNameTxt_.text)
				SetActive(arg_604_1.iconTrs_.gameObject, false)
				arg_604_1.callingController_:SetSelectedState("normal")

				local var_607_9 = arg_604_1:GetWordFromCfg(420012146)
				local var_607_10 = arg_604_1:FormatText(var_607_9.content)

				arg_604_1.text_.text = var_607_10

				LuaForUtil.ClearLinePrefixSymbol(arg_604_1.text_)

				local var_607_11 = 9
				local var_607_12 = utf8.len(var_607_10)
				local var_607_13 = var_607_11 <= 0 and var_607_7 or var_607_7 * (var_607_12 / var_607_11)

				if var_607_13 > 0 and var_607_7 < var_607_13 then
					arg_604_1.talkMaxDuration = var_607_13

					if var_607_13 + var_607_6 > arg_604_1.duration_ then
						arg_604_1.duration_ = var_607_13 + var_607_6
					end
				end

				arg_604_1.text_.text = var_607_10
				arg_604_1.typewritter.percent = 0

				arg_604_1.typewritter:SetDirty()
				arg_604_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012146", "story_v_out_420012.awb") ~= 0 then
					local var_607_14 = manager.audio:GetVoiceLength("story_v_out_420012", "420012146", "story_v_out_420012.awb") / 1000

					if var_607_14 + var_607_6 > arg_604_1.duration_ then
						arg_604_1.duration_ = var_607_14 + var_607_6
					end

					if var_607_9.prefab_name ~= "" and arg_604_1.actors_[var_607_9.prefab_name] ~= nil then
						local var_607_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_604_1.actors_[var_607_9.prefab_name].transform, "story_v_out_420012", "420012146", "story_v_out_420012.awb")

						arg_604_1:RecordAudio("420012146", var_607_15)
						arg_604_1:RecordAudio("420012146", var_607_15)
					else
						arg_604_1:AudioAction("play", "voice", "story_v_out_420012", "420012146", "story_v_out_420012.awb")
					end

					arg_604_1:RecordHistoryTalkVoice("story_v_out_420012", "420012146", "story_v_out_420012.awb")
				end

				arg_604_1:RecordContent(arg_604_1.text_.text)
			end

			local var_607_16 = math.max(var_607_7, arg_604_1.talkMaxDuration)

			if var_607_6 <= arg_604_1.time_ and arg_604_1.time_ < var_607_6 + var_607_16 then
				arg_604_1.typewritter.percent = (arg_604_1.time_ - var_607_6) / var_607_16

				arg_604_1.typewritter:SetDirty()
			end

			if arg_604_1.time_ >= var_607_6 + var_607_16 and arg_604_1.time_ < var_607_6 + var_607_16 + arg_607_0 then
				arg_604_1.typewritter.percent = 1

				arg_604_1.typewritter:SetDirty()
				arg_604_1:ShowNextGo(true)
			end
		end

		arg_604_1.nodeConfigList_ = {}

		arg_604_1:InitPlayNodeList()
	end,
	Play420012147 = function(arg_608_0, arg_608_1)
		arg_608_1.time_ = 0
		arg_608_1.frameCnt_ = 0
		arg_608_1.state_ = "playing"
		arg_608_1.curTalkId_ = 420012147
		arg_608_1.duration_ = 5

		SetActive(arg_608_1.tipsGo_, false)

		function arg_608_1.onSingleLineFinish_()
			arg_608_1.onSingleLineUpdate_ = nil
			arg_608_1.onSingleLineFinish_ = nil
			arg_608_1.state_ = "waiting"
		end

		function arg_608_1.playNext_(arg_610_0)
			if arg_610_0 == 1 then
				arg_608_0:Play420012148(arg_608_1)
			end
		end

		function arg_608_1.onSingleLineUpdate_(arg_611_0)
			local var_611_0 = arg_608_1.actors_["1085ui_story"].transform
			local var_611_1 = 0

			if var_611_1 < arg_608_1.time_ and arg_608_1.time_ <= var_611_1 + arg_611_0 then
				arg_608_1.var_.moveOldPos1085ui_story = var_611_0.localPosition
			end

			local var_611_2 = 0.001

			if var_611_1 <= arg_608_1.time_ and arg_608_1.time_ < var_611_1 + var_611_2 then
				local var_611_3 = (arg_608_1.time_ - var_611_1) / var_611_2
				local var_611_4 = Vector3.New(0, 100, 0)

				var_611_0.localPosition = Vector3.Lerp(arg_608_1.var_.moveOldPos1085ui_story, var_611_4, var_611_3)

				local var_611_5 = manager.ui.mainCamera.transform.position - var_611_0.position

				var_611_0.forward = Vector3.New(var_611_5.x, var_611_5.y, var_611_5.z)

				local var_611_6 = var_611_0.localEulerAngles

				var_611_6.z = 0
				var_611_6.x = 0
				var_611_0.localEulerAngles = var_611_6
			end

			if arg_608_1.time_ >= var_611_1 + var_611_2 and arg_608_1.time_ < var_611_1 + var_611_2 + arg_611_0 then
				var_611_0.localPosition = Vector3.New(0, 100, 0)

				local var_611_7 = manager.ui.mainCamera.transform.position - var_611_0.position

				var_611_0.forward = Vector3.New(var_611_7.x, var_611_7.y, var_611_7.z)

				local var_611_8 = var_611_0.localEulerAngles

				var_611_8.z = 0
				var_611_8.x = 0
				var_611_0.localEulerAngles = var_611_8
			end

			local var_611_9 = 0
			local var_611_10 = 1.25

			if var_611_9 < arg_608_1.time_ and arg_608_1.time_ <= var_611_9 + arg_611_0 then
				arg_608_1.talkMaxDuration = 0
				arg_608_1.dialogCg_.alpha = 1

				arg_608_1.dialog_:SetActive(true)
				SetActive(arg_608_1.leftNameGo_, false)

				arg_608_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_608_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_608_1:RecordName(arg_608_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_608_1.iconTrs_.gameObject, false)
				arg_608_1.callingController_:SetSelectedState("normal")

				local var_611_11 = arg_608_1:GetWordFromCfg(420012147)
				local var_611_12 = arg_608_1:FormatText(var_611_11.content)

				arg_608_1.text_.text = var_611_12

				LuaForUtil.ClearLinePrefixSymbol(arg_608_1.text_)

				local var_611_13 = 50
				local var_611_14 = utf8.len(var_611_12)
				local var_611_15 = var_611_13 <= 0 and var_611_10 or var_611_10 * (var_611_14 / var_611_13)

				if var_611_15 > 0 and var_611_10 < var_611_15 then
					arg_608_1.talkMaxDuration = var_611_15

					if var_611_15 + var_611_9 > arg_608_1.duration_ then
						arg_608_1.duration_ = var_611_15 + var_611_9
					end
				end

				arg_608_1.text_.text = var_611_12
				arg_608_1.typewritter.percent = 0

				arg_608_1.typewritter:SetDirty()
				arg_608_1:ShowNextGo(false)
				arg_608_1:RecordContent(arg_608_1.text_.text)
			end

			local var_611_16 = math.max(var_611_10, arg_608_1.talkMaxDuration)

			if var_611_9 <= arg_608_1.time_ and arg_608_1.time_ < var_611_9 + var_611_16 then
				arg_608_1.typewritter.percent = (arg_608_1.time_ - var_611_9) / var_611_16

				arg_608_1.typewritter:SetDirty()
			end

			if arg_608_1.time_ >= var_611_9 + var_611_16 and arg_608_1.time_ < var_611_9 + var_611_16 + arg_611_0 then
				arg_608_1.typewritter.percent = 1

				arg_608_1.typewritter:SetDirty()
				arg_608_1:ShowNextGo(true)
			end
		end

		arg_608_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_608_1:InitPlayNodeList()
	end,
	Play420012148 = function(arg_612_0, arg_612_1)
		arg_612_1.time_ = 0
		arg_612_1.frameCnt_ = 0
		arg_612_1.state_ = "playing"
		arg_612_1.curTalkId_ = 420012148
		arg_612_1.duration_ = 5

		SetActive(arg_612_1.tipsGo_, false)

		function arg_612_1.onSingleLineFinish_()
			arg_612_1.onSingleLineUpdate_ = nil
			arg_612_1.onSingleLineFinish_ = nil
			arg_612_1.state_ = "waiting"
		end

		function arg_612_1.playNext_(arg_614_0)
			if arg_614_0 == 1 then
				arg_612_0:Play420012149(arg_612_1)
			end
		end

		function arg_612_1.onSingleLineUpdate_(arg_615_0)
			local var_615_0 = 0
			local var_615_1 = 0.125

			if var_615_0 < arg_612_1.time_ and arg_612_1.time_ <= var_615_0 + arg_615_0 then
				arg_612_1.talkMaxDuration = 0
				arg_612_1.dialogCg_.alpha = 1

				arg_612_1.dialog_:SetActive(true)
				SetActive(arg_612_1.leftNameGo_, true)

				local var_615_2 = arg_612_1:FormatText(StoryNameCfg[7].name)

				arg_612_1.leftNameTxt_.text = var_615_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_612_1.leftNameTxt_.transform)

				arg_612_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_612_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_612_1:RecordName(arg_612_1.leftNameTxt_.text)
				SetActive(arg_612_1.iconTrs_.gameObject, true)
				arg_612_1.iconController_:SetSelectedState("hero")

				arg_612_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_612_1.callingController_:SetSelectedState("normal")

				arg_612_1.keyicon_.color = Color.New(1, 1, 1)
				arg_612_1.icon_.color = Color.New(1, 1, 1)

				local var_615_3 = arg_612_1:GetWordFromCfg(420012148)
				local var_615_4 = arg_612_1:FormatText(var_615_3.content)

				arg_612_1.text_.text = var_615_4

				LuaForUtil.ClearLinePrefixSymbol(arg_612_1.text_)

				local var_615_5 = 5
				local var_615_6 = utf8.len(var_615_4)
				local var_615_7 = var_615_5 <= 0 and var_615_1 or var_615_1 * (var_615_6 / var_615_5)

				if var_615_7 > 0 and var_615_1 < var_615_7 then
					arg_612_1.talkMaxDuration = var_615_7

					if var_615_7 + var_615_0 > arg_612_1.duration_ then
						arg_612_1.duration_ = var_615_7 + var_615_0
					end
				end

				arg_612_1.text_.text = var_615_4
				arg_612_1.typewritter.percent = 0

				arg_612_1.typewritter:SetDirty()
				arg_612_1:ShowNextGo(false)
				arg_612_1:RecordContent(arg_612_1.text_.text)
			end

			local var_615_8 = math.max(var_615_1, arg_612_1.talkMaxDuration)

			if var_615_0 <= arg_612_1.time_ and arg_612_1.time_ < var_615_0 + var_615_8 then
				arg_612_1.typewritter.percent = (arg_612_1.time_ - var_615_0) / var_615_8

				arg_612_1.typewritter:SetDirty()
			end

			if arg_612_1.time_ >= var_615_0 + var_615_8 and arg_612_1.time_ < var_615_0 + var_615_8 + arg_615_0 then
				arg_612_1.typewritter.percent = 1

				arg_612_1.typewritter:SetDirty()
				arg_612_1:ShowNextGo(true)
			end
		end

		arg_612_1.nodeConfigList_ = {}

		arg_612_1:InitPlayNodeList()
	end,
	Play420012149 = function(arg_616_0, arg_616_1)
		arg_616_1.time_ = 0
		arg_616_1.frameCnt_ = 0
		arg_616_1.state_ = "playing"
		arg_616_1.curTalkId_ = 420012149
		arg_616_1.duration_ = 5

		SetActive(arg_616_1.tipsGo_, false)

		function arg_616_1.onSingleLineFinish_()
			arg_616_1.onSingleLineUpdate_ = nil
			arg_616_1.onSingleLineFinish_ = nil
			arg_616_1.state_ = "waiting"
		end

		function arg_616_1.playNext_(arg_618_0)
			if arg_618_0 == 1 then
				arg_616_0:Play420012150(arg_616_1)
			end
		end

		function arg_616_1.onSingleLineUpdate_(arg_619_0)
			local var_619_0 = 0
			local var_619_1 = 0.8

			if var_619_0 < arg_616_1.time_ and arg_616_1.time_ <= var_619_0 + arg_619_0 then
				arg_616_1.talkMaxDuration = 0
				arg_616_1.dialogCg_.alpha = 1

				arg_616_1.dialog_:SetActive(true)
				SetActive(arg_616_1.leftNameGo_, false)

				arg_616_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_616_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_616_1:RecordName(arg_616_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_616_1.iconTrs_.gameObject, false)
				arg_616_1.callingController_:SetSelectedState("normal")

				local var_619_2 = arg_616_1:GetWordFromCfg(420012149)
				local var_619_3 = arg_616_1:FormatText(var_619_2.content)

				arg_616_1.text_.text = var_619_3

				LuaForUtil.ClearLinePrefixSymbol(arg_616_1.text_)

				local var_619_4 = 32
				local var_619_5 = utf8.len(var_619_3)
				local var_619_6 = var_619_4 <= 0 and var_619_1 or var_619_1 * (var_619_5 / var_619_4)

				if var_619_6 > 0 and var_619_1 < var_619_6 then
					arg_616_1.talkMaxDuration = var_619_6

					if var_619_6 + var_619_0 > arg_616_1.duration_ then
						arg_616_1.duration_ = var_619_6 + var_619_0
					end
				end

				arg_616_1.text_.text = var_619_3
				arg_616_1.typewritter.percent = 0

				arg_616_1.typewritter:SetDirty()
				arg_616_1:ShowNextGo(false)
				arg_616_1:RecordContent(arg_616_1.text_.text)
			end

			local var_619_7 = math.max(var_619_1, arg_616_1.talkMaxDuration)

			if var_619_0 <= arg_616_1.time_ and arg_616_1.time_ < var_619_0 + var_619_7 then
				arg_616_1.typewritter.percent = (arg_616_1.time_ - var_619_0) / var_619_7

				arg_616_1.typewritter:SetDirty()
			end

			if arg_616_1.time_ >= var_619_0 + var_619_7 and arg_616_1.time_ < var_619_0 + var_619_7 + arg_619_0 then
				arg_616_1.typewritter.percent = 1

				arg_616_1.typewritter:SetDirty()
				arg_616_1:ShowNextGo(true)
			end
		end

		arg_616_1.nodeConfigList_ = {}

		arg_616_1:InitPlayNodeList()
	end,
	Play420012150 = function(arg_620_0, arg_620_1)
		arg_620_1.time_ = 0
		arg_620_1.frameCnt_ = 0
		arg_620_1.state_ = "playing"
		arg_620_1.curTalkId_ = 420012150
		arg_620_1.duration_ = 5

		SetActive(arg_620_1.tipsGo_, false)

		function arg_620_1.onSingleLineFinish_()
			arg_620_1.onSingleLineUpdate_ = nil
			arg_620_1.onSingleLineFinish_ = nil
			arg_620_1.state_ = "waiting"
		end

		function arg_620_1.playNext_(arg_622_0)
			if arg_622_0 == 1 then
				arg_620_0:Play420012151(arg_620_1)
			end
		end

		function arg_620_1.onSingleLineUpdate_(arg_623_0)
			local var_623_0 = 0
			local var_623_1 = 1.425

			if var_623_0 < arg_620_1.time_ and arg_620_1.time_ <= var_623_0 + arg_623_0 then
				arg_620_1.talkMaxDuration = 0
				arg_620_1.dialogCg_.alpha = 1

				arg_620_1.dialog_:SetActive(true)
				SetActive(arg_620_1.leftNameGo_, false)

				arg_620_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_620_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_620_1:RecordName(arg_620_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_620_1.iconTrs_.gameObject, false)
				arg_620_1.callingController_:SetSelectedState("normal")

				local var_623_2 = arg_620_1:GetWordFromCfg(420012150)
				local var_623_3 = arg_620_1:FormatText(var_623_2.content)

				arg_620_1.text_.text = var_623_3

				LuaForUtil.ClearLinePrefixSymbol(arg_620_1.text_)

				local var_623_4 = 57
				local var_623_5 = utf8.len(var_623_3)
				local var_623_6 = var_623_4 <= 0 and var_623_1 or var_623_1 * (var_623_5 / var_623_4)

				if var_623_6 > 0 and var_623_1 < var_623_6 then
					arg_620_1.talkMaxDuration = var_623_6

					if var_623_6 + var_623_0 > arg_620_1.duration_ then
						arg_620_1.duration_ = var_623_6 + var_623_0
					end
				end

				arg_620_1.text_.text = var_623_3
				arg_620_1.typewritter.percent = 0

				arg_620_1.typewritter:SetDirty()
				arg_620_1:ShowNextGo(false)
				arg_620_1:RecordContent(arg_620_1.text_.text)
			end

			local var_623_7 = math.max(var_623_1, arg_620_1.talkMaxDuration)

			if var_623_0 <= arg_620_1.time_ and arg_620_1.time_ < var_623_0 + var_623_7 then
				arg_620_1.typewritter.percent = (arg_620_1.time_ - var_623_0) / var_623_7

				arg_620_1.typewritter:SetDirty()
			end

			if arg_620_1.time_ >= var_623_0 + var_623_7 and arg_620_1.time_ < var_623_0 + var_623_7 + arg_623_0 then
				arg_620_1.typewritter.percent = 1

				arg_620_1.typewritter:SetDirty()
				arg_620_1:ShowNextGo(true)
			end
		end

		arg_620_1.nodeConfigList_ = {}

		arg_620_1:InitPlayNodeList()
	end,
	Play420012151 = function(arg_624_0, arg_624_1)
		arg_624_1.time_ = 0
		arg_624_1.frameCnt_ = 0
		arg_624_1.state_ = "playing"
		arg_624_1.curTalkId_ = 420012151
		arg_624_1.duration_ = 4

		SetActive(arg_624_1.tipsGo_, false)

		function arg_624_1.onSingleLineFinish_()
			arg_624_1.onSingleLineUpdate_ = nil
			arg_624_1.onSingleLineFinish_ = nil
			arg_624_1.state_ = "waiting"
		end

		function arg_624_1.playNext_(arg_626_0)
			if arg_626_0 == 1 then
				arg_624_0:Play420012152(arg_624_1)
			end
		end

		function arg_624_1.onSingleLineUpdate_(arg_627_0)
			local var_627_0 = 0

			if var_627_0 < arg_624_1.time_ and arg_624_1.time_ <= var_627_0 + arg_627_0 then
				local var_627_1 = manager.ui.mainCamera.transform.localPosition
				local var_627_2 = Vector3.New(0, 0, 10) + Vector3.New(var_627_1.x, var_627_1.y, 0)
				local var_627_3 = arg_624_1.bgs_.STwhite

				var_627_3.transform.localPosition = var_627_2
				var_627_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_627_4 = var_627_3:GetComponent("SpriteRenderer")

				if var_627_4 and var_627_4.sprite then
					local var_627_5 = (var_627_3.transform.localPosition - var_627_1).z
					local var_627_6 = manager.ui.mainCameraCom_
					local var_627_7 = 2 * var_627_5 * Mathf.Tan(var_627_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_627_8 = var_627_7 * var_627_6.aspect
					local var_627_9 = var_627_4.sprite.bounds.size.x
					local var_627_10 = var_627_4.sprite.bounds.size.y
					local var_627_11 = var_627_8 / var_627_9
					local var_627_12 = var_627_7 / var_627_10
					local var_627_13 = var_627_12 < var_627_11 and var_627_11 or var_627_12

					var_627_3.transform.localScale = Vector3.New(var_627_13, var_627_13, 0)
				end

				for iter_627_0, iter_627_1 in pairs(arg_624_1.bgs_) do
					if iter_627_0 ~= "STwhite" then
						iter_627_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_627_14 = 0

			if var_627_14 < arg_624_1.time_ and arg_624_1.time_ <= var_627_14 + arg_627_0 then
				arg_624_1.mask_.enabled = true
				arg_624_1.mask_.raycastTarget = true

				arg_624_1:SetGaussion(false)
			end

			local var_627_15 = 1

			if var_627_14 <= arg_624_1.time_ and arg_624_1.time_ < var_627_14 + var_627_15 then
				local var_627_16 = (arg_624_1.time_ - var_627_14) / var_627_15
				local var_627_17 = Color.New(1, 1, 1)

				var_627_17.a = Mathf.Lerp(1, 0, var_627_16)
				arg_624_1.mask_.color = var_627_17
			end

			if arg_624_1.time_ >= var_627_14 + var_627_15 and arg_624_1.time_ < var_627_14 + var_627_15 + arg_627_0 then
				local var_627_18 = Color.New(1, 1, 1)
				local var_627_19 = 0

				arg_624_1.mask_.enabled = false
				var_627_18.a = var_627_19
				arg_624_1.mask_.color = var_627_18
			end

			local var_627_20 = 0

			if var_627_20 < arg_624_1.time_ and arg_624_1.time_ <= var_627_20 + arg_627_0 then
				arg_624_1.cswbg_:SetActive(true)

				local var_627_21 = arg_624_1.cswt_:GetComponent("RectTransform")

				arg_624_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_627_21.offsetMin = Vector2.New(0, 0)
				var_627_21.offsetMax = Vector2.New(0, 130)

				local var_627_22 = arg_624_1:GetWordFromCfg(419142)
				local var_627_23 = arg_624_1:FormatText(var_627_22.content)

				arg_624_1.cswt_.text = var_627_23

				LuaForUtil.ClearLinePrefixSymbol(arg_624_1.cswt_)

				arg_624_1.cswt_.fontSize = 120
				arg_624_1.cswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_624_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_624_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_627_24 = 0

			if var_627_24 < arg_624_1.time_ and arg_624_1.time_ <= var_627_24 + arg_627_0 then
				arg_624_1.fswbg_:SetActive(true)
				arg_624_1.dialog_:SetActive(false)

				arg_624_1.fswtw_.percent = 0

				local var_627_25 = arg_624_1:GetWordFromCfg(420012151)
				local var_627_26 = arg_624_1:FormatText(var_627_25.content)

				arg_624_1.fswt_.text = var_627_26

				LuaForUtil.ClearLinePrefixSymbol(arg_624_1.fswt_)

				arg_624_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_624_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_624_1.fswtw_:SetDirty()

				arg_624_1.typewritterCharCountI18N = 0

				SetActive(arg_624_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_624_1:ShowNextGo(false)
			end

			local var_627_27 = 0.5

			if var_627_27 < arg_624_1.time_ and arg_624_1.time_ <= var_627_27 + arg_627_0 then
				arg_624_1.var_.oldValueTypewriter = arg_624_1.fswtw_.percent

				SetActive(arg_624_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_624_1:ShowNextGo(false)
			end

			local var_627_28 = 7
			local var_627_29 = 0.466666666666667
			local var_627_30 = arg_624_1:GetWordFromCfg(420012151)
			local var_627_31 = arg_624_1:FormatText(var_627_30.content)
			local var_627_32, var_627_33 = arg_624_1:GetPercentByPara(var_627_31, 1)

			if var_627_27 < arg_624_1.time_ and arg_624_1.time_ <= var_627_27 + arg_627_0 then
				arg_624_1.talkMaxDuration = 0

				local var_627_34 = var_627_28 <= 0 and var_627_29 or var_627_29 * ((var_627_33 - arg_624_1.typewritterCharCountI18N) / var_627_28)

				if var_627_34 > 0 and var_627_29 < var_627_34 then
					arg_624_1.talkMaxDuration = var_627_34

					if var_627_34 + var_627_27 > arg_624_1.duration_ then
						arg_624_1.duration_ = var_627_34 + var_627_27
					end
				end
			end

			local var_627_35 = 0.466666666666667
			local var_627_36 = math.max(var_627_35, arg_624_1.talkMaxDuration)

			if var_627_27 <= arg_624_1.time_ and arg_624_1.time_ < var_627_27 + var_627_36 then
				local var_627_37 = (arg_624_1.time_ - var_627_27) / var_627_36

				arg_624_1.fswtw_.percent = Mathf.Lerp(arg_624_1.var_.oldValueTypewriter, var_627_32, var_627_37)
				arg_624_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_624_1.fswtw_:SetDirty()
			end

			if arg_624_1.time_ >= var_627_27 + var_627_36 and arg_624_1.time_ < var_627_27 + var_627_36 + arg_627_0 then
				arg_624_1.fswtw_.percent = var_627_32

				arg_624_1.fswtw_:SetDirty()
				arg_624_1:ShowNextGo(true)

				arg_624_1.typewritterCharCountI18N = var_627_33
			end

			local var_627_38 = 0.5
			local var_627_39 = 2.8
			local var_627_40 = manager.audio:GetVoiceLength("story_v_out_420012", "420012151", "story_v_out_420012.awb") / 1000

			if var_627_40 > 0 and var_627_39 < var_627_40 and var_627_40 + var_627_38 > arg_624_1.duration_ then
				local var_627_41 = var_627_40

				arg_624_1.duration_ = var_627_40 + var_627_38
			end

			if var_627_38 < arg_624_1.time_ and arg_624_1.time_ <= var_627_38 + arg_627_0 then
				local var_627_42 = "play"
				local var_627_43 = "voice"

				arg_624_1:AudioAction(var_627_42, var_627_43, "story_v_out_420012", "420012151", "story_v_out_420012.awb")
			end

			local var_627_44 = 0

			if var_627_44 < arg_624_1.time_ and arg_624_1.time_ <= var_627_44 + arg_627_0 then
				local var_627_45 = arg_624_1.fswbg_.transform:Find("textbox/adapt/content") or arg_624_1.fswbg_.transform:Find("textbox/content")
				local var_627_46 = arg_624_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_627_47 = var_627_45:GetComponent("Text")
				local var_627_48 = var_627_45:GetComponent("RectTransform")

				var_627_47.alignment = UnityEngine.TextAnchor.LowerCenter
				var_627_48.offsetMin = Vector2.New(0, -70)
				var_627_48.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_624_1.nodeConfigList_ = {}

		arg_624_1:InitPlayNodeList()
	end,
	Play420012152 = function(arg_628_0, arg_628_1)
		arg_628_1.time_ = 0
		arg_628_1.frameCnt_ = 0
		arg_628_1.state_ = "playing"
		arg_628_1.curTalkId_ = 420012152
		arg_628_1.duration_ = 3.55

		SetActive(arg_628_1.tipsGo_, false)

		function arg_628_1.onSingleLineFinish_()
			arg_628_1.onSingleLineUpdate_ = nil
			arg_628_1.onSingleLineFinish_ = nil
			arg_628_1.state_ = "waiting"
		end

		function arg_628_1.playNext_(arg_630_0)
			if arg_630_0 == 1 then
				arg_628_0:Play420012153(arg_628_1)
			end
		end

		function arg_628_1.onSingleLineUpdate_(arg_631_0)
			local var_631_0 = 0

			if var_631_0 < arg_628_1.time_ and arg_628_1.time_ <= var_631_0 + arg_631_0 then
				arg_628_1.fswbg_:SetActive(true)
				arg_628_1.dialog_:SetActive(false)

				arg_628_1.fswtw_.percent = 0

				local var_631_1 = arg_628_1:GetWordFromCfg(420012152)
				local var_631_2 = arg_628_1:FormatText(var_631_1.content)

				arg_628_1.fswt_.text = var_631_2

				LuaForUtil.ClearLinePrefixSymbol(arg_628_1.fswt_)

				arg_628_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_628_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_628_1.fswtw_:SetDirty()

				arg_628_1.typewritterCharCountI18N = 0

				SetActive(arg_628_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_628_1:ShowNextGo(false)
			end

			local var_631_3 = 0.0166666666666667

			if var_631_3 < arg_628_1.time_ and arg_628_1.time_ <= var_631_3 + arg_631_0 then
				arg_628_1.var_.oldValueTypewriter = arg_628_1.fswtw_.percent

				SetActive(arg_628_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_628_1:ShowNextGo(false)
			end

			local var_631_4 = 53
			local var_631_5 = 3.53333333333333
			local var_631_6 = arg_628_1:GetWordFromCfg(420012152)
			local var_631_7 = arg_628_1:FormatText(var_631_6.content)
			local var_631_8, var_631_9 = arg_628_1:GetPercentByPara(var_631_7, 1)

			if var_631_3 < arg_628_1.time_ and arg_628_1.time_ <= var_631_3 + arg_631_0 then
				arg_628_1.talkMaxDuration = 0

				local var_631_10 = var_631_4 <= 0 and var_631_5 or var_631_5 * ((var_631_9 - arg_628_1.typewritterCharCountI18N) / var_631_4)

				if var_631_10 > 0 and var_631_5 < var_631_10 then
					arg_628_1.talkMaxDuration = var_631_10

					if var_631_10 + var_631_3 > arg_628_1.duration_ then
						arg_628_1.duration_ = var_631_10 + var_631_3
					end
				end
			end

			local var_631_11 = 3.53333333333333
			local var_631_12 = math.max(var_631_11, arg_628_1.talkMaxDuration)

			if var_631_3 <= arg_628_1.time_ and arg_628_1.time_ < var_631_3 + var_631_12 then
				local var_631_13 = (arg_628_1.time_ - var_631_3) / var_631_12

				arg_628_1.fswtw_.percent = Mathf.Lerp(arg_628_1.var_.oldValueTypewriter, var_631_8, var_631_13)
				arg_628_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_628_1.fswtw_:SetDirty()
			end

			if arg_628_1.time_ >= var_631_3 + var_631_12 and arg_628_1.time_ < var_631_3 + var_631_12 + arg_631_0 then
				arg_628_1.fswtw_.percent = var_631_8

				arg_628_1.fswtw_:SetDirty()
				arg_628_1:ShowNextGo(true)

				arg_628_1.typewritterCharCountI18N = var_631_9
			end
		end

		arg_628_1.nodeConfigList_ = {}

		arg_628_1:InitPlayNodeList()
	end,
	Play420012153 = function(arg_632_0, arg_632_1)
		arg_632_1.time_ = 0
		arg_632_1.frameCnt_ = 0
		arg_632_1.state_ = "playing"
		arg_632_1.curTalkId_ = 420012153
		arg_632_1.duration_ = 1.6

		SetActive(arg_632_1.tipsGo_, false)

		function arg_632_1.onSingleLineFinish_()
			arg_632_1.onSingleLineUpdate_ = nil
			arg_632_1.onSingleLineFinish_ = nil
			arg_632_1.state_ = "waiting"
		end

		function arg_632_1.playNext_(arg_634_0)
			if arg_634_0 == 1 then
				arg_632_0:Play420012154(arg_632_1)
			end
		end

		function arg_632_1.onSingleLineUpdate_(arg_635_0)
			local var_635_0 = 0

			if var_635_0 < arg_632_1.time_ and arg_632_1.time_ <= var_635_0 + arg_635_0 then
				arg_632_1.fswbg_:SetActive(true)
				arg_632_1.dialog_:SetActive(false)

				arg_632_1.fswtw_.percent = 0

				local var_635_1 = arg_632_1:GetWordFromCfg(420012153)
				local var_635_2 = arg_632_1:FormatText(var_635_1.content)

				arg_632_1.fswt_.text = var_635_2

				LuaForUtil.ClearLinePrefixSymbol(arg_632_1.fswt_)

				arg_632_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_632_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_632_1.fswtw_:SetDirty()

				arg_632_1.typewritterCharCountI18N = 0

				SetActive(arg_632_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_632_1:ShowNextGo(false)
			end

			local var_635_3 = 0.0166666666666667

			if var_635_3 < arg_632_1.time_ and arg_632_1.time_ <= var_635_3 + arg_635_0 then
				arg_632_1.var_.oldValueTypewriter = arg_632_1.fswtw_.percent

				SetActive(arg_632_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_632_1:ShowNextGo(false)
			end

			local var_635_4 = 3
			local var_635_5 = 0.2
			local var_635_6 = arg_632_1:GetWordFromCfg(420012153)
			local var_635_7 = arg_632_1:FormatText(var_635_6.content)
			local var_635_8, var_635_9 = arg_632_1:GetPercentByPara(var_635_7, 1)

			if var_635_3 < arg_632_1.time_ and arg_632_1.time_ <= var_635_3 + arg_635_0 then
				arg_632_1.talkMaxDuration = 0

				local var_635_10 = var_635_4 <= 0 and var_635_5 or var_635_5 * ((var_635_9 - arg_632_1.typewritterCharCountI18N) / var_635_4)

				if var_635_10 > 0 and var_635_5 < var_635_10 then
					arg_632_1.talkMaxDuration = var_635_10

					if var_635_10 + var_635_3 > arg_632_1.duration_ then
						arg_632_1.duration_ = var_635_10 + var_635_3
					end
				end
			end

			local var_635_11 = 0.2
			local var_635_12 = math.max(var_635_11, arg_632_1.talkMaxDuration)

			if var_635_3 <= arg_632_1.time_ and arg_632_1.time_ < var_635_3 + var_635_12 then
				local var_635_13 = (arg_632_1.time_ - var_635_3) / var_635_12

				arg_632_1.fswtw_.percent = Mathf.Lerp(arg_632_1.var_.oldValueTypewriter, var_635_8, var_635_13)
				arg_632_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_632_1.fswtw_:SetDirty()
			end

			if arg_632_1.time_ >= var_635_3 + var_635_12 and arg_632_1.time_ < var_635_3 + var_635_12 + arg_635_0 then
				arg_632_1.fswtw_.percent = var_635_8

				arg_632_1.fswtw_:SetDirty()
				arg_632_1:ShowNextGo(true)

				arg_632_1.typewritterCharCountI18N = var_635_9
			end

			local var_635_14 = 0
			local var_635_15 = 1.6
			local var_635_16 = manager.audio:GetVoiceLength("story_v_out_420012", "420012153", "story_v_out_420012.awb") / 1000

			if var_635_16 > 0 and var_635_15 < var_635_16 and var_635_16 + var_635_14 > arg_632_1.duration_ then
				local var_635_17 = var_635_16

				arg_632_1.duration_ = var_635_16 + var_635_14
			end

			if var_635_14 < arg_632_1.time_ and arg_632_1.time_ <= var_635_14 + arg_635_0 then
				local var_635_18 = "play"
				local var_635_19 = "voice"

				arg_632_1:AudioAction(var_635_18, var_635_19, "story_v_out_420012", "420012153", "story_v_out_420012.awb")
			end
		end

		arg_632_1.nodeConfigList_ = {}

		arg_632_1:InitPlayNodeList()
	end,
	Play420012154 = function(arg_636_0, arg_636_1)
		arg_636_1.time_ = 0
		arg_636_1.frameCnt_ = 0
		arg_636_1.state_ = "playing"
		arg_636_1.curTalkId_ = 420012154
		arg_636_1.duration_ = 5

		SetActive(arg_636_1.tipsGo_, false)

		function arg_636_1.onSingleLineFinish_()
			arg_636_1.onSingleLineUpdate_ = nil
			arg_636_1.onSingleLineFinish_ = nil
			arg_636_1.state_ = "waiting"
		end

		function arg_636_1.playNext_(arg_638_0)
			if arg_638_0 == 1 then
				arg_636_0:Play420012155(arg_636_1)
			end
		end

		function arg_636_1.onSingleLineUpdate_(arg_639_0)
			local var_639_0 = 0

			if var_639_0 < arg_636_1.time_ and arg_636_1.time_ <= var_639_0 + arg_639_0 then
				arg_636_1.fswbg_:SetActive(true)
				arg_636_1.dialog_:SetActive(false)

				arg_636_1.fswtw_.percent = 0

				local var_639_1 = arg_636_1:GetWordFromCfg(420012154)
				local var_639_2 = arg_636_1:FormatText(var_639_1.content)

				arg_636_1.fswt_.text = var_639_2

				LuaForUtil.ClearLinePrefixSymbol(arg_636_1.fswt_)

				arg_636_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_636_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_636_1.fswtw_:SetDirty()

				arg_636_1.typewritterCharCountI18N = 0

				SetActive(arg_636_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_636_1:ShowNextGo(false)
			end

			local var_639_3 = 0.0166666666666667

			if var_639_3 < arg_636_1.time_ and arg_636_1.time_ <= var_639_3 + arg_639_0 then
				arg_636_1.var_.oldValueTypewriter = arg_636_1.fswtw_.percent

				SetActive(arg_636_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_636_1:ShowNextGo(false)
			end

			local var_639_4 = 54
			local var_639_5 = 3.6
			local var_639_6 = arg_636_1:GetWordFromCfg(420012154)
			local var_639_7 = arg_636_1:FormatText(var_639_6.content)
			local var_639_8, var_639_9 = arg_636_1:GetPercentByPara(var_639_7, 1)

			if var_639_3 < arg_636_1.time_ and arg_636_1.time_ <= var_639_3 + arg_639_0 then
				arg_636_1.talkMaxDuration = 0

				local var_639_10 = var_639_4 <= 0 and var_639_5 or var_639_5 * ((var_639_9 - arg_636_1.typewritterCharCountI18N) / var_639_4)

				if var_639_10 > 0 and var_639_5 < var_639_10 then
					arg_636_1.talkMaxDuration = var_639_10

					if var_639_10 + var_639_3 > arg_636_1.duration_ then
						arg_636_1.duration_ = var_639_10 + var_639_3
					end
				end
			end

			local var_639_11 = 3.6
			local var_639_12 = math.max(var_639_11, arg_636_1.talkMaxDuration)

			if var_639_3 <= arg_636_1.time_ and arg_636_1.time_ < var_639_3 + var_639_12 then
				local var_639_13 = (arg_636_1.time_ - var_639_3) / var_639_12

				arg_636_1.fswtw_.percent = Mathf.Lerp(arg_636_1.var_.oldValueTypewriter, var_639_8, var_639_13)
				arg_636_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_636_1.fswtw_:SetDirty()
			end

			if arg_636_1.time_ >= var_639_3 + var_639_12 and arg_636_1.time_ < var_639_3 + var_639_12 + arg_639_0 then
				arg_636_1.fswtw_.percent = var_639_8

				arg_636_1.fswtw_:SetDirty()
				arg_636_1:ShowNextGo(true)

				arg_636_1.typewritterCharCountI18N = var_639_9
			end

			local var_639_14 = 0

			if var_639_14 < arg_636_1.time_ and arg_636_1.time_ <= var_639_14 + arg_639_0 then
				arg_636_1.cswbg_:SetActive(false)
			end

			local var_639_15 = 0

			if var_639_15 < arg_636_1.time_ and arg_636_1.time_ <= var_639_15 + arg_639_0 then
				local var_639_16 = arg_636_1.fswbg_.transform:Find("textbox/adapt/content") or arg_636_1.fswbg_.transform:Find("textbox/content")
				local var_639_17 = arg_636_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_639_18 = var_639_16:GetComponent("Text")
				local var_639_19 = var_639_16:GetComponent("RectTransform")

				var_639_18.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_639_19.offsetMin = Vector2.New(0, 0)
				var_639_19.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_636_1.nodeConfigList_ = {}

		arg_636_1:InitPlayNodeList()
	end,
	Play420012155 = function(arg_640_0, arg_640_1)
		arg_640_1.time_ = 0
		arg_640_1.frameCnt_ = 0
		arg_640_1.state_ = "playing"
		arg_640_1.curTalkId_ = 420012155
		arg_640_1.duration_ = 4.93

		local var_640_0 = {
			zh = 4.799999999999,
			ja = 4.933
		}
		local var_640_1 = manager.audio:GetLocalizationFlag()

		if var_640_0[var_640_1] ~= nil then
			arg_640_1.duration_ = var_640_0[var_640_1]
		end

		SetActive(arg_640_1.tipsGo_, false)

		function arg_640_1.onSingleLineFinish_()
			arg_640_1.onSingleLineUpdate_ = nil
			arg_640_1.onSingleLineFinish_ = nil
			arg_640_1.state_ = "waiting"
		end

		function arg_640_1.playNext_(arg_642_0)
			if arg_642_0 == 1 then
				arg_640_0:Play420012156(arg_640_1)
			end
		end

		function arg_640_1.onSingleLineUpdate_(arg_643_0)
			local var_643_0 = 1

			if var_643_0 < arg_640_1.time_ and arg_640_1.time_ <= var_643_0 + arg_643_0 then
				local var_643_1 = manager.ui.mainCamera.transform.localPosition
				local var_643_2 = Vector3.New(0, 0, 10) + Vector3.New(var_643_1.x, var_643_1.y, 0)
				local var_643_3 = arg_640_1.bgs_.ST0503

				var_643_3.transform.localPosition = var_643_2
				var_643_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_643_4 = var_643_3:GetComponent("SpriteRenderer")

				if var_643_4 and var_643_4.sprite then
					local var_643_5 = (var_643_3.transform.localPosition - var_643_1).z
					local var_643_6 = manager.ui.mainCameraCom_
					local var_643_7 = 2 * var_643_5 * Mathf.Tan(var_643_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_643_8 = var_643_7 * var_643_6.aspect
					local var_643_9 = var_643_4.sprite.bounds.size.x
					local var_643_10 = var_643_4.sprite.bounds.size.y
					local var_643_11 = var_643_8 / var_643_9
					local var_643_12 = var_643_7 / var_643_10
					local var_643_13 = var_643_12 < var_643_11 and var_643_11 or var_643_12

					var_643_3.transform.localScale = Vector3.New(var_643_13, var_643_13, 0)
				end

				for iter_643_0, iter_643_1 in pairs(arg_640_1.bgs_) do
					if iter_643_0 ~= "ST0503" then
						iter_643_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_643_14 = 0

			if var_643_14 < arg_640_1.time_ and arg_640_1.time_ <= var_643_14 + arg_643_0 then
				arg_640_1.mask_.enabled = true
				arg_640_1.mask_.raycastTarget = true

				arg_640_1:SetGaussion(false)
			end

			local var_643_15 = 1

			if var_643_14 <= arg_640_1.time_ and arg_640_1.time_ < var_643_14 + var_643_15 then
				local var_643_16 = (arg_640_1.time_ - var_643_14) / var_643_15
				local var_643_17 = Color.New(0, 0, 0)

				var_643_17.a = Mathf.Lerp(0, 1, var_643_16)
				arg_640_1.mask_.color = var_643_17
			end

			if arg_640_1.time_ >= var_643_14 + var_643_15 and arg_640_1.time_ < var_643_14 + var_643_15 + arg_643_0 then
				local var_643_18 = Color.New(0, 0, 0)

				var_643_18.a = 1
				arg_640_1.mask_.color = var_643_18
			end

			local var_643_19 = 1

			if var_643_19 < arg_640_1.time_ and arg_640_1.time_ <= var_643_19 + arg_643_0 then
				arg_640_1.mask_.enabled = true
				arg_640_1.mask_.raycastTarget = true

				arg_640_1:SetGaussion(false)
			end

			local var_643_20 = 2

			if var_643_19 <= arg_640_1.time_ and arg_640_1.time_ < var_643_19 + var_643_20 then
				local var_643_21 = (arg_640_1.time_ - var_643_19) / var_643_20
				local var_643_22 = Color.New(0, 0, 0)

				var_643_22.a = Mathf.Lerp(1, 0, var_643_21)
				arg_640_1.mask_.color = var_643_22
			end

			if arg_640_1.time_ >= var_643_19 + var_643_20 and arg_640_1.time_ < var_643_19 + var_643_20 + arg_643_0 then
				local var_643_23 = Color.New(0, 0, 0)
				local var_643_24 = 0

				arg_640_1.mask_.enabled = false
				var_643_23.a = var_643_24
				arg_640_1.mask_.color = var_643_23
			end

			local var_643_25 = 0.966666666666667

			if var_643_25 < arg_640_1.time_ and arg_640_1.time_ <= var_643_25 + arg_643_0 then
				arg_640_1.fswbg_:SetActive(false)
				arg_640_1.dialog_:SetActive(false)
				SetActive(arg_640_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_640_1:ShowNextGo(false)
			end

			local var_643_26 = arg_640_1.actors_["1085ui_story"].transform
			local var_643_27 = 2.8

			if var_643_27 < arg_640_1.time_ and arg_640_1.time_ <= var_643_27 + arg_643_0 then
				arg_640_1.var_.moveOldPos1085ui_story = var_643_26.localPosition
			end

			local var_643_28 = 0.001

			if var_643_27 <= arg_640_1.time_ and arg_640_1.time_ < var_643_27 + var_643_28 then
				local var_643_29 = (arg_640_1.time_ - var_643_27) / var_643_28
				local var_643_30 = Vector3.New(0, -1.01, -5.83)

				var_643_26.localPosition = Vector3.Lerp(arg_640_1.var_.moveOldPos1085ui_story, var_643_30, var_643_29)

				local var_643_31 = manager.ui.mainCamera.transform.position - var_643_26.position

				var_643_26.forward = Vector3.New(var_643_31.x, var_643_31.y, var_643_31.z)

				local var_643_32 = var_643_26.localEulerAngles

				var_643_32.z = 0
				var_643_32.x = 0
				var_643_26.localEulerAngles = var_643_32
			end

			if arg_640_1.time_ >= var_643_27 + var_643_28 and arg_640_1.time_ < var_643_27 + var_643_28 + arg_643_0 then
				var_643_26.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_643_33 = manager.ui.mainCamera.transform.position - var_643_26.position

				var_643_26.forward = Vector3.New(var_643_33.x, var_643_33.y, var_643_33.z)

				local var_643_34 = var_643_26.localEulerAngles

				var_643_34.z = 0
				var_643_34.x = 0
				var_643_26.localEulerAngles = var_643_34
			end

			local var_643_35 = arg_640_1.actors_["1085ui_story"]
			local var_643_36 = 2.8

			if var_643_36 < arg_640_1.time_ and arg_640_1.time_ <= var_643_36 + arg_643_0 and not isNil(var_643_35) and arg_640_1.var_.characterEffect1085ui_story == nil then
				arg_640_1.var_.characterEffect1085ui_story = var_643_35:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_643_37 = 0.200000002980232

			if var_643_36 <= arg_640_1.time_ and arg_640_1.time_ < var_643_36 + var_643_37 and not isNil(var_643_35) then
				local var_643_38 = (arg_640_1.time_ - var_643_36) / var_643_37

				if arg_640_1.var_.characterEffect1085ui_story and not isNil(var_643_35) then
					arg_640_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_640_1.time_ >= var_643_36 + var_643_37 and arg_640_1.time_ < var_643_36 + var_643_37 + arg_643_0 and not isNil(var_643_35) and arg_640_1.var_.characterEffect1085ui_story then
				arg_640_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_643_39 = 2.8

			if var_643_39 < arg_640_1.time_ and arg_640_1.time_ <= var_643_39 + arg_643_0 then
				arg_640_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action6_1")
			end

			local var_643_40 = 2.8

			if var_643_40 < arg_640_1.time_ and arg_640_1.time_ <= var_643_40 + arg_643_0 then
				arg_640_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_643_41 = 3
			local var_643_42 = 0.125

			if var_643_41 < arg_640_1.time_ and arg_640_1.time_ <= var_643_41 + arg_643_0 then
				arg_640_1.talkMaxDuration = 0
				arg_640_1.dialogCg_.alpha = 1

				arg_640_1.dialog_:SetActive(true)
				SetActive(arg_640_1.leftNameGo_, true)

				local var_643_43 = arg_640_1:FormatText(StoryNameCfg[328].name)

				arg_640_1.leftNameTxt_.text = var_643_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_640_1.leftNameTxt_.transform)

				arg_640_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_640_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_640_1:RecordName(arg_640_1.leftNameTxt_.text)
				SetActive(arg_640_1.iconTrs_.gameObject, false)
				arg_640_1.callingController_:SetSelectedState("normal")

				local var_643_44 = arg_640_1:GetWordFromCfg(420012155)
				local var_643_45 = arg_640_1:FormatText(var_643_44.content)

				arg_640_1.text_.text = var_643_45

				LuaForUtil.ClearLinePrefixSymbol(arg_640_1.text_)

				local var_643_46 = 5
				local var_643_47 = utf8.len(var_643_45)
				local var_643_48 = var_643_46 <= 0 and var_643_42 or var_643_42 * (var_643_47 / var_643_46)

				if var_643_48 > 0 and var_643_42 < var_643_48 then
					arg_640_1.talkMaxDuration = var_643_48

					if var_643_48 + var_643_41 > arg_640_1.duration_ then
						arg_640_1.duration_ = var_643_48 + var_643_41
					end
				end

				arg_640_1.text_.text = var_643_45
				arg_640_1.typewritter.percent = 0

				arg_640_1.typewritter:SetDirty()
				arg_640_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012155", "story_v_out_420012.awb") ~= 0 then
					local var_643_49 = manager.audio:GetVoiceLength("story_v_out_420012", "420012155", "story_v_out_420012.awb") / 1000

					if var_643_49 + var_643_41 > arg_640_1.duration_ then
						arg_640_1.duration_ = var_643_49 + var_643_41
					end

					if var_643_44.prefab_name ~= "" and arg_640_1.actors_[var_643_44.prefab_name] ~= nil then
						local var_643_50 = LuaForUtil.PlayVoiceWithCriLipsync(arg_640_1.actors_[var_643_44.prefab_name].transform, "story_v_out_420012", "420012155", "story_v_out_420012.awb")

						arg_640_1:RecordAudio("420012155", var_643_50)
						arg_640_1:RecordAudio("420012155", var_643_50)
					else
						arg_640_1:AudioAction("play", "voice", "story_v_out_420012", "420012155", "story_v_out_420012.awb")
					end

					arg_640_1:RecordHistoryTalkVoice("story_v_out_420012", "420012155", "story_v_out_420012.awb")
				end

				arg_640_1:RecordContent(arg_640_1.text_.text)
			end

			local var_643_51 = math.max(var_643_42, arg_640_1.talkMaxDuration)

			if var_643_41 <= arg_640_1.time_ and arg_640_1.time_ < var_643_41 + var_643_51 then
				arg_640_1.typewritter.percent = (arg_640_1.time_ - var_643_41) / var_643_51

				arg_640_1.typewritter:SetDirty()
			end

			if arg_640_1.time_ >= var_643_41 + var_643_51 and arg_640_1.time_ < var_643_41 + var_643_51 + arg_643_0 then
				arg_640_1.typewritter.percent = 1

				arg_640_1.typewritter:SetDirty()
				arg_640_1:ShowNextGo(true)
			end
		end

		arg_640_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_640_1:InitPlayNodeList()
	end,
	Play420012156 = function(arg_644_0, arg_644_1)
		arg_644_1.time_ = 0
		arg_644_1.frameCnt_ = 0
		arg_644_1.state_ = "playing"
		arg_644_1.curTalkId_ = 420012156
		arg_644_1.duration_ = 1

		SetActive(arg_644_1.tipsGo_, false)

		function arg_644_1.onSingleLineFinish_()
			arg_644_1.onSingleLineUpdate_ = nil
			arg_644_1.onSingleLineFinish_ = nil
			arg_644_1.state_ = "waiting"

			SetActive(arg_644_1.choicesGo_, true)

			for iter_645_0, iter_645_1 in ipairs(arg_644_1.choices_) do
				local var_645_0 = iter_645_0 <= 2

				SetActive(iter_645_1.go, var_645_0)
			end

			arg_644_1.choices_[1].txt.text = arg_644_1:FormatText(StoryChoiceCfg[1216].name)
			arg_644_1.choices_[2].txt.text = arg_644_1:FormatText(StoryChoiceCfg[1217].name)
		end

		function arg_644_1.playNext_(arg_646_0)
			if arg_646_0 == 1 then
				arg_644_0:Play420012157(arg_644_1)
			end

			if arg_646_0 == 2 then
				arg_644_0:Play420012157(arg_644_1)
			end

			arg_644_1:RecordChoiceLog(420012156, 1216, 1217)
		end

		function arg_644_1.onSingleLineUpdate_(arg_647_0)
			local var_647_0 = arg_644_1.actors_["1085ui_story"]
			local var_647_1 = 0

			if var_647_1 < arg_644_1.time_ and arg_644_1.time_ <= var_647_1 + arg_647_0 and not isNil(var_647_0) and arg_644_1.var_.characterEffect1085ui_story == nil then
				arg_644_1.var_.characterEffect1085ui_story = var_647_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_647_2 = 1

			if var_647_1 <= arg_644_1.time_ and arg_644_1.time_ < var_647_1 + var_647_2 and not isNil(var_647_0) then
				local var_647_3 = (arg_644_1.time_ - var_647_1) / var_647_2

				if arg_644_1.var_.characterEffect1085ui_story and not isNil(var_647_0) then
					local var_647_4 = Mathf.Lerp(0, 0.5, var_647_3)

					arg_644_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_644_1.var_.characterEffect1085ui_story.fillRatio = var_647_4
				end
			end

			if arg_644_1.time_ >= var_647_1 + var_647_2 and arg_644_1.time_ < var_647_1 + var_647_2 + arg_647_0 and not isNil(var_647_0) and arg_644_1.var_.characterEffect1085ui_story then
				local var_647_5 = 0.5

				arg_644_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_644_1.var_.characterEffect1085ui_story.fillRatio = var_647_5
			end
		end

		arg_644_1.nodeConfigList_ = {}

		arg_644_1:InitPlayNodeList()
	end,
	Play420012157 = function(arg_648_0, arg_648_1)
		arg_648_1.time_ = 0
		arg_648_1.frameCnt_ = 0
		arg_648_1.state_ = "playing"
		arg_648_1.curTalkId_ = 420012157
		arg_648_1.duration_ = 5.17

		local var_648_0 = {
			zh = 3.1,
			ja = 5.166
		}
		local var_648_1 = manager.audio:GetLocalizationFlag()

		if var_648_0[var_648_1] ~= nil then
			arg_648_1.duration_ = var_648_0[var_648_1]
		end

		SetActive(arg_648_1.tipsGo_, false)

		function arg_648_1.onSingleLineFinish_()
			arg_648_1.onSingleLineUpdate_ = nil
			arg_648_1.onSingleLineFinish_ = nil
			arg_648_1.state_ = "waiting"
		end

		function arg_648_1.playNext_(arg_650_0)
			if arg_650_0 == 1 then
				arg_648_0:Play420012158(arg_648_1)
			end
		end

		function arg_648_1.onSingleLineUpdate_(arg_651_0)
			local var_651_0 = arg_648_1.actors_["1085ui_story"]
			local var_651_1 = 0

			if var_651_1 < arg_648_1.time_ and arg_648_1.time_ <= var_651_1 + arg_651_0 and not isNil(var_651_0) and arg_648_1.var_.characterEffect1085ui_story == nil then
				arg_648_1.var_.characterEffect1085ui_story = var_651_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_651_2 = 0.200000002980232

			if var_651_1 <= arg_648_1.time_ and arg_648_1.time_ < var_651_1 + var_651_2 and not isNil(var_651_0) then
				local var_651_3 = (arg_648_1.time_ - var_651_1) / var_651_2

				if arg_648_1.var_.characterEffect1085ui_story and not isNil(var_651_0) then
					arg_648_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_648_1.time_ >= var_651_1 + var_651_2 and arg_648_1.time_ < var_651_1 + var_651_2 + arg_651_0 and not isNil(var_651_0) and arg_648_1.var_.characterEffect1085ui_story then
				arg_648_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_651_4 = 0
			local var_651_5 = 0.225

			if var_651_4 < arg_648_1.time_ and arg_648_1.time_ <= var_651_4 + arg_651_0 then
				arg_648_1.talkMaxDuration = 0
				arg_648_1.dialogCg_.alpha = 1

				arg_648_1.dialog_:SetActive(true)
				SetActive(arg_648_1.leftNameGo_, true)

				local var_651_6 = arg_648_1:FormatText(StoryNameCfg[328].name)

				arg_648_1.leftNameTxt_.text = var_651_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_648_1.leftNameTxt_.transform)

				arg_648_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_648_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_648_1:RecordName(arg_648_1.leftNameTxt_.text)
				SetActive(arg_648_1.iconTrs_.gameObject, false)
				arg_648_1.callingController_:SetSelectedState("normal")

				local var_651_7 = arg_648_1:GetWordFromCfg(420012157)
				local var_651_8 = arg_648_1:FormatText(var_651_7.content)

				arg_648_1.text_.text = var_651_8

				LuaForUtil.ClearLinePrefixSymbol(arg_648_1.text_)

				local var_651_9 = 9
				local var_651_10 = utf8.len(var_651_8)
				local var_651_11 = var_651_9 <= 0 and var_651_5 or var_651_5 * (var_651_10 / var_651_9)

				if var_651_11 > 0 and var_651_5 < var_651_11 then
					arg_648_1.talkMaxDuration = var_651_11

					if var_651_11 + var_651_4 > arg_648_1.duration_ then
						arg_648_1.duration_ = var_651_11 + var_651_4
					end
				end

				arg_648_1.text_.text = var_651_8
				arg_648_1.typewritter.percent = 0

				arg_648_1.typewritter:SetDirty()
				arg_648_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012157", "story_v_out_420012.awb") ~= 0 then
					local var_651_12 = manager.audio:GetVoiceLength("story_v_out_420012", "420012157", "story_v_out_420012.awb") / 1000

					if var_651_12 + var_651_4 > arg_648_1.duration_ then
						arg_648_1.duration_ = var_651_12 + var_651_4
					end

					if var_651_7.prefab_name ~= "" and arg_648_1.actors_[var_651_7.prefab_name] ~= nil then
						local var_651_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_648_1.actors_[var_651_7.prefab_name].transform, "story_v_out_420012", "420012157", "story_v_out_420012.awb")

						arg_648_1:RecordAudio("420012157", var_651_13)
						arg_648_1:RecordAudio("420012157", var_651_13)
					else
						arg_648_1:AudioAction("play", "voice", "story_v_out_420012", "420012157", "story_v_out_420012.awb")
					end

					arg_648_1:RecordHistoryTalkVoice("story_v_out_420012", "420012157", "story_v_out_420012.awb")
				end

				arg_648_1:RecordContent(arg_648_1.text_.text)
			end

			local var_651_14 = math.max(var_651_5, arg_648_1.talkMaxDuration)

			if var_651_4 <= arg_648_1.time_ and arg_648_1.time_ < var_651_4 + var_651_14 then
				arg_648_1.typewritter.percent = (arg_648_1.time_ - var_651_4) / var_651_14

				arg_648_1.typewritter:SetDirty()
			end

			if arg_648_1.time_ >= var_651_4 + var_651_14 and arg_648_1.time_ < var_651_4 + var_651_14 + arg_651_0 then
				arg_648_1.typewritter.percent = 1

				arg_648_1.typewritter:SetDirty()
				arg_648_1:ShowNextGo(true)
			end
		end

		arg_648_1.nodeConfigList_ = {}

		arg_648_1:InitPlayNodeList()
	end,
	Play420012158 = function(arg_652_0, arg_652_1)
		arg_652_1.time_ = 0
		arg_652_1.frameCnt_ = 0
		arg_652_1.state_ = "playing"
		arg_652_1.curTalkId_ = 420012158
		arg_652_1.duration_ = 6.83

		local var_652_0 = {
			zh = 5.1,
			ja = 6.833
		}
		local var_652_1 = manager.audio:GetLocalizationFlag()

		if var_652_0[var_652_1] ~= nil then
			arg_652_1.duration_ = var_652_0[var_652_1]
		end

		SetActive(arg_652_1.tipsGo_, false)

		function arg_652_1.onSingleLineFinish_()
			arg_652_1.onSingleLineUpdate_ = nil
			arg_652_1.onSingleLineFinish_ = nil
			arg_652_1.state_ = "waiting"
		end

		function arg_652_1.playNext_(arg_654_0)
			if arg_654_0 == 1 then
				arg_652_0:Play420012159(arg_652_1)
			end
		end

		function arg_652_1.onSingleLineUpdate_(arg_655_0)
			local var_655_0 = 0
			local var_655_1 = 0.55

			if var_655_0 < arg_652_1.time_ and arg_652_1.time_ <= var_655_0 + arg_655_0 then
				arg_652_1.talkMaxDuration = 0
				arg_652_1.dialogCg_.alpha = 1

				arg_652_1.dialog_:SetActive(true)
				SetActive(arg_652_1.leftNameGo_, true)

				local var_655_2 = arg_652_1:FormatText(StoryNameCfg[328].name)

				arg_652_1.leftNameTxt_.text = var_655_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_652_1.leftNameTxt_.transform)

				arg_652_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_652_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_652_1:RecordName(arg_652_1.leftNameTxt_.text)
				SetActive(arg_652_1.iconTrs_.gameObject, false)
				arg_652_1.callingController_:SetSelectedState("normal")

				local var_655_3 = arg_652_1:GetWordFromCfg(420012158)
				local var_655_4 = arg_652_1:FormatText(var_655_3.content)

				arg_652_1.text_.text = var_655_4

				LuaForUtil.ClearLinePrefixSymbol(arg_652_1.text_)

				local var_655_5 = 22
				local var_655_6 = utf8.len(var_655_4)
				local var_655_7 = var_655_5 <= 0 and var_655_1 or var_655_1 * (var_655_6 / var_655_5)

				if var_655_7 > 0 and var_655_1 < var_655_7 then
					arg_652_1.talkMaxDuration = var_655_7

					if var_655_7 + var_655_0 > arg_652_1.duration_ then
						arg_652_1.duration_ = var_655_7 + var_655_0
					end
				end

				arg_652_1.text_.text = var_655_4
				arg_652_1.typewritter.percent = 0

				arg_652_1.typewritter:SetDirty()
				arg_652_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012158", "story_v_out_420012.awb") ~= 0 then
					local var_655_8 = manager.audio:GetVoiceLength("story_v_out_420012", "420012158", "story_v_out_420012.awb") / 1000

					if var_655_8 + var_655_0 > arg_652_1.duration_ then
						arg_652_1.duration_ = var_655_8 + var_655_0
					end

					if var_655_3.prefab_name ~= "" and arg_652_1.actors_[var_655_3.prefab_name] ~= nil then
						local var_655_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_652_1.actors_[var_655_3.prefab_name].transform, "story_v_out_420012", "420012158", "story_v_out_420012.awb")

						arg_652_1:RecordAudio("420012158", var_655_9)
						arg_652_1:RecordAudio("420012158", var_655_9)
					else
						arg_652_1:AudioAction("play", "voice", "story_v_out_420012", "420012158", "story_v_out_420012.awb")
					end

					arg_652_1:RecordHistoryTalkVoice("story_v_out_420012", "420012158", "story_v_out_420012.awb")
				end

				arg_652_1:RecordContent(arg_652_1.text_.text)
			end

			local var_655_10 = math.max(var_655_1, arg_652_1.talkMaxDuration)

			if var_655_0 <= arg_652_1.time_ and arg_652_1.time_ < var_655_0 + var_655_10 then
				arg_652_1.typewritter.percent = (arg_652_1.time_ - var_655_0) / var_655_10

				arg_652_1.typewritter:SetDirty()
			end

			if arg_652_1.time_ >= var_655_0 + var_655_10 and arg_652_1.time_ < var_655_0 + var_655_10 + arg_655_0 then
				arg_652_1.typewritter.percent = 1

				arg_652_1.typewritter:SetDirty()
				arg_652_1:ShowNextGo(true)
			end
		end

		arg_652_1.nodeConfigList_ = {}

		arg_652_1:InitPlayNodeList()
	end,
	Play420012159 = function(arg_656_0, arg_656_1)
		arg_656_1.time_ = 0
		arg_656_1.frameCnt_ = 0
		arg_656_1.state_ = "playing"
		arg_656_1.curTalkId_ = 420012159
		arg_656_1.duration_ = 3.9

		local var_656_0 = {
			zh = 2.5,
			ja = 3.9
		}
		local var_656_1 = manager.audio:GetLocalizationFlag()

		if var_656_0[var_656_1] ~= nil then
			arg_656_1.duration_ = var_656_0[var_656_1]
		end

		SetActive(arg_656_1.tipsGo_, false)

		function arg_656_1.onSingleLineFinish_()
			arg_656_1.onSingleLineUpdate_ = nil
			arg_656_1.onSingleLineFinish_ = nil
			arg_656_1.state_ = "waiting"
		end

		function arg_656_1.playNext_(arg_658_0)
			if arg_658_0 == 1 then
				arg_656_0:Play420012160(arg_656_1)
			end
		end

		function arg_656_1.onSingleLineUpdate_(arg_659_0)
			local var_659_0 = 0

			if var_659_0 < arg_656_1.time_ and arg_656_1.time_ <= var_659_0 + arg_659_0 then
				arg_656_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action6_2")
			end

			local var_659_1 = 0

			if var_659_1 < arg_656_1.time_ and arg_656_1.time_ <= var_659_1 + arg_659_0 then
				arg_656_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_659_2 = 0
			local var_659_3 = 0.2

			if var_659_2 < arg_656_1.time_ and arg_656_1.time_ <= var_659_2 + arg_659_0 then
				arg_656_1.talkMaxDuration = 0
				arg_656_1.dialogCg_.alpha = 1

				arg_656_1.dialog_:SetActive(true)
				SetActive(arg_656_1.leftNameGo_, true)

				local var_659_4 = arg_656_1:FormatText(StoryNameCfg[328].name)

				arg_656_1.leftNameTxt_.text = var_659_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_656_1.leftNameTxt_.transform)

				arg_656_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_656_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_656_1:RecordName(arg_656_1.leftNameTxt_.text)
				SetActive(arg_656_1.iconTrs_.gameObject, false)
				arg_656_1.callingController_:SetSelectedState("normal")

				local var_659_5 = arg_656_1:GetWordFromCfg(420012159)
				local var_659_6 = arg_656_1:FormatText(var_659_5.content)

				arg_656_1.text_.text = var_659_6

				LuaForUtil.ClearLinePrefixSymbol(arg_656_1.text_)

				local var_659_7 = 8
				local var_659_8 = utf8.len(var_659_6)
				local var_659_9 = var_659_7 <= 0 and var_659_3 or var_659_3 * (var_659_8 / var_659_7)

				if var_659_9 > 0 and var_659_3 < var_659_9 then
					arg_656_1.talkMaxDuration = var_659_9

					if var_659_9 + var_659_2 > arg_656_1.duration_ then
						arg_656_1.duration_ = var_659_9 + var_659_2
					end
				end

				arg_656_1.text_.text = var_659_6
				arg_656_1.typewritter.percent = 0

				arg_656_1.typewritter:SetDirty()
				arg_656_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420012", "420012159", "story_v_out_420012.awb") ~= 0 then
					local var_659_10 = manager.audio:GetVoiceLength("story_v_out_420012", "420012159", "story_v_out_420012.awb") / 1000

					if var_659_10 + var_659_2 > arg_656_1.duration_ then
						arg_656_1.duration_ = var_659_10 + var_659_2
					end

					if var_659_5.prefab_name ~= "" and arg_656_1.actors_[var_659_5.prefab_name] ~= nil then
						local var_659_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_656_1.actors_[var_659_5.prefab_name].transform, "story_v_out_420012", "420012159", "story_v_out_420012.awb")

						arg_656_1:RecordAudio("420012159", var_659_11)
						arg_656_1:RecordAudio("420012159", var_659_11)
					else
						arg_656_1:AudioAction("play", "voice", "story_v_out_420012", "420012159", "story_v_out_420012.awb")
					end

					arg_656_1:RecordHistoryTalkVoice("story_v_out_420012", "420012159", "story_v_out_420012.awb")
				end

				arg_656_1:RecordContent(arg_656_1.text_.text)
			end

			local var_659_12 = math.max(var_659_3, arg_656_1.talkMaxDuration)

			if var_659_2 <= arg_656_1.time_ and arg_656_1.time_ < var_659_2 + var_659_12 then
				arg_656_1.typewritter.percent = (arg_656_1.time_ - var_659_2) / var_659_12

				arg_656_1.typewritter:SetDirty()
			end

			if arg_656_1.time_ >= var_659_2 + var_659_12 and arg_656_1.time_ < var_659_2 + var_659_12 + arg_659_0 then
				arg_656_1.typewritter.percent = 1

				arg_656_1.typewritter:SetDirty()
				arg_656_1:ShowNextGo(true)
			end
		end

		arg_656_1.nodeConfigList_ = {}

		arg_656_1:InitPlayNodeList()
	end,
	Play420012160 = function(arg_660_0, arg_660_1)
		arg_660_1.time_ = 0
		arg_660_1.frameCnt_ = 0
		arg_660_1.state_ = "playing"
		arg_660_1.curTalkId_ = 420012160
		arg_660_1.duration_ = 5

		SetActive(arg_660_1.tipsGo_, false)

		function arg_660_1.onSingleLineFinish_()
			arg_660_1.onSingleLineUpdate_ = nil
			arg_660_1.onSingleLineFinish_ = nil
			arg_660_1.state_ = "waiting"
		end

		function arg_660_1.playNext_(arg_662_0)
			if arg_662_0 == 1 then
				arg_660_0:Play420012161(arg_660_1)
			end
		end

		function arg_660_1.onSingleLineUpdate_(arg_663_0)
			local var_663_0 = arg_660_1.actors_["1085ui_story"].transform
			local var_663_1 = 0

			if var_663_1 < arg_660_1.time_ and arg_660_1.time_ <= var_663_1 + arg_663_0 then
				arg_660_1.var_.moveOldPos1085ui_story = var_663_0.localPosition
			end

			local var_663_2 = 0.001

			if var_663_1 <= arg_660_1.time_ and arg_660_1.time_ < var_663_1 + var_663_2 then
				local var_663_3 = (arg_660_1.time_ - var_663_1) / var_663_2
				local var_663_4 = Vector3.New(0, 100, 0)

				var_663_0.localPosition = Vector3.Lerp(arg_660_1.var_.moveOldPos1085ui_story, var_663_4, var_663_3)

				local var_663_5 = manager.ui.mainCamera.transform.position - var_663_0.position

				var_663_0.forward = Vector3.New(var_663_5.x, var_663_5.y, var_663_5.z)

				local var_663_6 = var_663_0.localEulerAngles

				var_663_6.z = 0
				var_663_6.x = 0
				var_663_0.localEulerAngles = var_663_6
			end

			if arg_660_1.time_ >= var_663_1 + var_663_2 and arg_660_1.time_ < var_663_1 + var_663_2 + arg_663_0 then
				var_663_0.localPosition = Vector3.New(0, 100, 0)

				local var_663_7 = manager.ui.mainCamera.transform.position - var_663_0.position

				var_663_0.forward = Vector3.New(var_663_7.x, var_663_7.y, var_663_7.z)

				local var_663_8 = var_663_0.localEulerAngles

				var_663_8.z = 0
				var_663_8.x = 0
				var_663_0.localEulerAngles = var_663_8
			end

			local var_663_9 = 0.233333333333333
			local var_663_10 = 1

			if var_663_9 < arg_660_1.time_ and arg_660_1.time_ <= var_663_9 + arg_663_0 then
				local var_663_11 = "play"
				local var_663_12 = "effect"

				arg_660_1:AudioAction(var_663_11, var_663_12, "se_story_1311", "se_story_1311_bag", "")
			end

			local var_663_13 = 0
			local var_663_14 = 1.125

			if var_663_13 < arg_660_1.time_ and arg_660_1.time_ <= var_663_13 + arg_663_0 then
				arg_660_1.talkMaxDuration = 0
				arg_660_1.dialogCg_.alpha = 1

				arg_660_1.dialog_:SetActive(true)
				SetActive(arg_660_1.leftNameGo_, false)

				arg_660_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_660_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_660_1:RecordName(arg_660_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_660_1.iconTrs_.gameObject, false)
				arg_660_1.callingController_:SetSelectedState("normal")

				local var_663_15 = arg_660_1:GetWordFromCfg(420012160)
				local var_663_16 = arg_660_1:FormatText(var_663_15.content)

				arg_660_1.text_.text = var_663_16

				LuaForUtil.ClearLinePrefixSymbol(arg_660_1.text_)

				local var_663_17 = 45
				local var_663_18 = utf8.len(var_663_16)
				local var_663_19 = var_663_17 <= 0 and var_663_14 or var_663_14 * (var_663_18 / var_663_17)

				if var_663_19 > 0 and var_663_14 < var_663_19 then
					arg_660_1.talkMaxDuration = var_663_19

					if var_663_19 + var_663_13 > arg_660_1.duration_ then
						arg_660_1.duration_ = var_663_19 + var_663_13
					end
				end

				arg_660_1.text_.text = var_663_16
				arg_660_1.typewritter.percent = 0

				arg_660_1.typewritter:SetDirty()
				arg_660_1:ShowNextGo(false)
				arg_660_1:RecordContent(arg_660_1.text_.text)
			end

			local var_663_20 = math.max(var_663_14, arg_660_1.talkMaxDuration)

			if var_663_13 <= arg_660_1.time_ and arg_660_1.time_ < var_663_13 + var_663_20 then
				arg_660_1.typewritter.percent = (arg_660_1.time_ - var_663_13) / var_663_20

				arg_660_1.typewritter:SetDirty()
			end

			if arg_660_1.time_ >= var_663_13 + var_663_20 and arg_660_1.time_ < var_663_13 + var_663_20 + arg_663_0 then
				arg_660_1.typewritter.percent = 1

				arg_660_1.typewritter:SetDirty()
				arg_660_1:ShowNextGo(true)
			end
		end

		arg_660_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_660_1:InitPlayNodeList()
	end,
	Play420012161 = function(arg_664_0, arg_664_1)
		arg_664_1.time_ = 0
		arg_664_1.frameCnt_ = 0
		arg_664_1.state_ = "playing"
		arg_664_1.curTalkId_ = 420012161
		arg_664_1.duration_ = 5

		SetActive(arg_664_1.tipsGo_, false)

		function arg_664_1.onSingleLineFinish_()
			arg_664_1.onSingleLineUpdate_ = nil
			arg_664_1.onSingleLineFinish_ = nil
			arg_664_1.state_ = "waiting"
		end

		function arg_664_1.playNext_(arg_666_0)
			if arg_666_0 == 1 then
				arg_664_0:Play420012162(arg_664_1)
			end
		end

		function arg_664_1.onSingleLineUpdate_(arg_667_0)
			local var_667_0 = 0.05
			local var_667_1 = 1

			if var_667_0 < arg_664_1.time_ and arg_664_1.time_ <= var_667_0 + arg_667_0 then
				local var_667_2 = "play"
				local var_667_3 = "effect"

				arg_664_1:AudioAction(var_667_2, var_667_3, "se_story_140", "se_story_140_baton", "")
			end

			local var_667_4 = 0
			local var_667_5 = 0.35

			if var_667_4 < arg_664_1.time_ and arg_664_1.time_ <= var_667_4 + arg_667_0 then
				arg_664_1.talkMaxDuration = 0
				arg_664_1.dialogCg_.alpha = 1

				arg_664_1.dialog_:SetActive(true)
				SetActive(arg_664_1.leftNameGo_, false)

				arg_664_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_664_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_664_1:RecordName(arg_664_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_664_1.iconTrs_.gameObject, false)
				arg_664_1.callingController_:SetSelectedState("normal")

				local var_667_6 = arg_664_1:GetWordFromCfg(420012161)
				local var_667_7 = arg_664_1:FormatText(var_667_6.content)

				arg_664_1.text_.text = var_667_7

				LuaForUtil.ClearLinePrefixSymbol(arg_664_1.text_)

				local var_667_8 = 14
				local var_667_9 = utf8.len(var_667_7)
				local var_667_10 = var_667_8 <= 0 and var_667_5 or var_667_5 * (var_667_9 / var_667_8)

				if var_667_10 > 0 and var_667_5 < var_667_10 then
					arg_664_1.talkMaxDuration = var_667_10

					if var_667_10 + var_667_4 > arg_664_1.duration_ then
						arg_664_1.duration_ = var_667_10 + var_667_4
					end
				end

				arg_664_1.text_.text = var_667_7
				arg_664_1.typewritter.percent = 0

				arg_664_1.typewritter:SetDirty()
				arg_664_1:ShowNextGo(false)
				arg_664_1:RecordContent(arg_664_1.text_.text)
			end

			local var_667_11 = math.max(var_667_5, arg_664_1.talkMaxDuration)

			if var_667_4 <= arg_664_1.time_ and arg_664_1.time_ < var_667_4 + var_667_11 then
				arg_664_1.typewritter.percent = (arg_664_1.time_ - var_667_4) / var_667_11

				arg_664_1.typewritter:SetDirty()
			end

			if arg_664_1.time_ >= var_667_4 + var_667_11 and arg_664_1.time_ < var_667_4 + var_667_11 + arg_667_0 then
				arg_664_1.typewritter.percent = 1

				arg_664_1.typewritter:SetDirty()
				arg_664_1:ShowNextGo(true)
			end
		end

		arg_664_1.nodeConfigList_ = {}

		arg_664_1:InitPlayNodeList()
	end,
	Play420012162 = function(arg_668_0, arg_668_1)
		arg_668_1.time_ = 0
		arg_668_1.frameCnt_ = 0
		arg_668_1.state_ = "playing"
		arg_668_1.curTalkId_ = 420012162
		arg_668_1.duration_ = 5

		SetActive(arg_668_1.tipsGo_, false)

		function arg_668_1.onSingleLineFinish_()
			arg_668_1.onSingleLineUpdate_ = nil
			arg_668_1.onSingleLineFinish_ = nil
			arg_668_1.state_ = "waiting"
		end

		function arg_668_1.playNext_(arg_670_0)
			if arg_670_0 == 1 then
				arg_668_0:Play420012163(arg_668_1)
			end
		end

		function arg_668_1.onSingleLineUpdate_(arg_671_0)
			local var_671_0 = 0
			local var_671_1 = 0.325

			if var_671_0 < arg_668_1.time_ and arg_668_1.time_ <= var_671_0 + arg_671_0 then
				arg_668_1.talkMaxDuration = 0
				arg_668_1.dialogCg_.alpha = 1

				arg_668_1.dialog_:SetActive(true)
				SetActive(arg_668_1.leftNameGo_, true)

				local var_671_2 = arg_668_1:FormatText(StoryNameCfg[7].name)

				arg_668_1.leftNameTxt_.text = var_671_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_668_1.leftNameTxt_.transform)

				arg_668_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_668_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_668_1:RecordName(arg_668_1.leftNameTxt_.text)
				SetActive(arg_668_1.iconTrs_.gameObject, true)
				arg_668_1.iconController_:SetSelectedState("hero")

				arg_668_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_668_1.callingController_:SetSelectedState("normal")

				arg_668_1.keyicon_.color = Color.New(1, 1, 1)
				arg_668_1.icon_.color = Color.New(1, 1, 1)

				local var_671_3 = arg_668_1:GetWordFromCfg(420012162)
				local var_671_4 = arg_668_1:FormatText(var_671_3.content)

				arg_668_1.text_.text = var_671_4

				LuaForUtil.ClearLinePrefixSymbol(arg_668_1.text_)

				local var_671_5 = 13
				local var_671_6 = utf8.len(var_671_4)
				local var_671_7 = var_671_5 <= 0 and var_671_1 or var_671_1 * (var_671_6 / var_671_5)

				if var_671_7 > 0 and var_671_1 < var_671_7 then
					arg_668_1.talkMaxDuration = var_671_7

					if var_671_7 + var_671_0 > arg_668_1.duration_ then
						arg_668_1.duration_ = var_671_7 + var_671_0
					end
				end

				arg_668_1.text_.text = var_671_4
				arg_668_1.typewritter.percent = 0

				arg_668_1.typewritter:SetDirty()
				arg_668_1:ShowNextGo(false)
				arg_668_1:RecordContent(arg_668_1.text_.text)
			end

			local var_671_8 = math.max(var_671_1, arg_668_1.talkMaxDuration)

			if var_671_0 <= arg_668_1.time_ and arg_668_1.time_ < var_671_0 + var_671_8 then
				arg_668_1.typewritter.percent = (arg_668_1.time_ - var_671_0) / var_671_8

				arg_668_1.typewritter:SetDirty()
			end

			if arg_668_1.time_ >= var_671_0 + var_671_8 and arg_668_1.time_ < var_671_0 + var_671_8 + arg_671_0 then
				arg_668_1.typewritter.percent = 1

				arg_668_1.typewritter:SetDirty()
				arg_668_1:ShowNextGo(true)
			end
		end

		arg_668_1.nodeConfigList_ = {}

		arg_668_1:InitPlayNodeList()
	end,
	Play420012163 = function(arg_672_0, arg_672_1)
		arg_672_1.time_ = 0
		arg_672_1.frameCnt_ = 0
		arg_672_1.state_ = "playing"
		arg_672_1.curTalkId_ = 420012163
		arg_672_1.duration_ = 5

		SetActive(arg_672_1.tipsGo_, false)

		function arg_672_1.onSingleLineFinish_()
			arg_672_1.onSingleLineUpdate_ = nil
			arg_672_1.onSingleLineFinish_ = nil
			arg_672_1.state_ = "waiting"
		end

		function arg_672_1.playNext_(arg_674_0)
			if arg_674_0 == 1 then
				arg_672_0:Play420012164(arg_672_1)
			end
		end

		function arg_672_1.onSingleLineUpdate_(arg_675_0)
			local var_675_0 = 0
			local var_675_1 = 1.425

			if var_675_0 < arg_672_1.time_ and arg_672_1.time_ <= var_675_0 + arg_675_0 then
				arg_672_1.talkMaxDuration = 0
				arg_672_1.dialogCg_.alpha = 1

				arg_672_1.dialog_:SetActive(true)
				SetActive(arg_672_1.leftNameGo_, false)

				arg_672_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_672_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_672_1:RecordName(arg_672_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_672_1.iconTrs_.gameObject, false)
				arg_672_1.callingController_:SetSelectedState("normal")

				local var_675_2 = arg_672_1:GetWordFromCfg(420012163)
				local var_675_3 = arg_672_1:FormatText(var_675_2.content)

				arg_672_1.text_.text = var_675_3

				LuaForUtil.ClearLinePrefixSymbol(arg_672_1.text_)

				local var_675_4 = 57
				local var_675_5 = utf8.len(var_675_3)
				local var_675_6 = var_675_4 <= 0 and var_675_1 or var_675_1 * (var_675_5 / var_675_4)

				if var_675_6 > 0 and var_675_1 < var_675_6 then
					arg_672_1.talkMaxDuration = var_675_6

					if var_675_6 + var_675_0 > arg_672_1.duration_ then
						arg_672_1.duration_ = var_675_6 + var_675_0
					end
				end

				arg_672_1.text_.text = var_675_3
				arg_672_1.typewritter.percent = 0

				arg_672_1.typewritter:SetDirty()
				arg_672_1:ShowNextGo(false)
				arg_672_1:RecordContent(arg_672_1.text_.text)
			end

			local var_675_7 = math.max(var_675_1, arg_672_1.talkMaxDuration)

			if var_675_0 <= arg_672_1.time_ and arg_672_1.time_ < var_675_0 + var_675_7 then
				arg_672_1.typewritter.percent = (arg_672_1.time_ - var_675_0) / var_675_7

				arg_672_1.typewritter:SetDirty()
			end

			if arg_672_1.time_ >= var_675_0 + var_675_7 and arg_672_1.time_ < var_675_0 + var_675_7 + arg_675_0 then
				arg_672_1.typewritter.percent = 1

				arg_672_1.typewritter:SetDirty()
				arg_672_1:ShowNextGo(true)
			end
		end

		arg_672_1.nodeConfigList_ = {}

		arg_672_1:InitPlayNodeList()
	end,
	Play420012164 = function(arg_676_0, arg_676_1)
		arg_676_1.time_ = 0
		arg_676_1.frameCnt_ = 0
		arg_676_1.state_ = "playing"
		arg_676_1.curTalkId_ = 420012164
		arg_676_1.duration_ = 5

		SetActive(arg_676_1.tipsGo_, false)

		function arg_676_1.onSingleLineFinish_()
			arg_676_1.onSingleLineUpdate_ = nil
			arg_676_1.onSingleLineFinish_ = nil
			arg_676_1.state_ = "waiting"
			arg_676_1.auto_ = false
		end

		function arg_676_1.playNext_(arg_678_0)
			arg_676_1.onStoryFinished_()
		end

		function arg_676_1.onSingleLineUpdate_(arg_679_0)
			local var_679_0 = 0
			local var_679_1 = 0.375

			if var_679_0 < arg_676_1.time_ and arg_676_1.time_ <= var_679_0 + arg_679_0 then
				arg_676_1.talkMaxDuration = 0
				arg_676_1.dialogCg_.alpha = 1

				arg_676_1.dialog_:SetActive(true)
				SetActive(arg_676_1.leftNameGo_, true)

				local var_679_2 = arg_676_1:FormatText(StoryNameCfg[7].name)

				arg_676_1.leftNameTxt_.text = var_679_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_676_1.leftNameTxt_.transform)

				arg_676_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_676_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_676_1:RecordName(arg_676_1.leftNameTxt_.text)
				SetActive(arg_676_1.iconTrs_.gameObject, true)
				arg_676_1.iconController_:SetSelectedState("hero")

				arg_676_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_676_1.callingController_:SetSelectedState("normal")

				arg_676_1.keyicon_.color = Color.New(1, 1, 1)
				arg_676_1.icon_.color = Color.New(1, 1, 1)

				local var_679_3 = arg_676_1:GetWordFromCfg(420012164)
				local var_679_4 = arg_676_1:FormatText(var_679_3.content)

				arg_676_1.text_.text = var_679_4

				LuaForUtil.ClearLinePrefixSymbol(arg_676_1.text_)

				local var_679_5 = 15
				local var_679_6 = utf8.len(var_679_4)
				local var_679_7 = var_679_5 <= 0 and var_679_1 or var_679_1 * (var_679_6 / var_679_5)

				if var_679_7 > 0 and var_679_1 < var_679_7 then
					arg_676_1.talkMaxDuration = var_679_7

					if var_679_7 + var_679_0 > arg_676_1.duration_ then
						arg_676_1.duration_ = var_679_7 + var_679_0
					end
				end

				arg_676_1.text_.text = var_679_4
				arg_676_1.typewritter.percent = 0

				arg_676_1.typewritter:SetDirty()
				arg_676_1:ShowNextGo(false)
				arg_676_1:RecordContent(arg_676_1.text_.text)
			end

			local var_679_8 = math.max(var_679_1, arg_676_1.talkMaxDuration)

			if var_679_0 <= arg_676_1.time_ and arg_676_1.time_ < var_679_0 + var_679_8 then
				arg_676_1.typewritter.percent = (arg_676_1.time_ - var_679_0) / var_679_8

				arg_676_1.typewritter:SetDirty()
			end

			if arg_676_1.time_ >= var_679_0 + var_679_8 and arg_676_1.time_ < var_679_0 + var_679_8 + arg_679_0 then
				arg_676_1.typewritter.percent = 1

				arg_676_1.typewritter:SetDirty()
				arg_676_1:ShowNextGo(true)
			end
		end

		arg_676_1.nodeConfigList_ = {}

		arg_676_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STwhite",
		"TextureConfig/Background/ST0505",
		"TextureConfig/Background/L01f",
		"TextureConfig/Background/ST0503",
		"TextureConfig/Background/I05e"
	},
	voices = {
		"story_v_out_420012.awb"
	}
}
