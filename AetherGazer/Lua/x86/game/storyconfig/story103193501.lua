return {
	Play319351001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 319351001
		arg_1_1.duration_ = 4.9

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play319351002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 1.36666666666667

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				local var_4_1 = arg_1_1.fswbg_.transform:Find("textbox/adapt/content") or arg_1_1.fswbg_.transform:Find("textbox/content")
				local var_4_2 = arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_4_3 = var_4_1:GetComponent("Text")
				local var_4_4 = var_4_1:GetComponent("RectTransform")

				var_4_3.alignment = UnityEngine.TextAnchor.LowerCenter
				var_4_4.offsetMin = Vector2.New(0, 0)
				var_4_4.offsetMax = Vector2.New(0, 0)
			end

			local var_4_5 = 1.36666666666667

			if var_4_5 < arg_1_1.time_ and arg_1_1.time_ <= var_4_5 + arg_4_0 then
				arg_1_1.fswbg_:SetActive(true)
				arg_1_1.dialog_:SetActive(false)

				arg_1_1.fswtw_.percent = 0

				local var_4_6 = arg_1_1:GetWordFromCfg(319351001)
				local var_4_7 = arg_1_1:FormatText(var_4_6.content)

				arg_1_1.fswt_.text = var_4_7

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.fswt_)

				arg_1_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_1_1.fswtw_:SetDirty()

				arg_1_1.typewritterCharCountI18N = 0

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_8 = 1.73333333333333

			if var_4_8 < arg_1_1.time_ and arg_1_1.time_ <= var_4_8 + arg_4_0 then
				arg_1_1.var_.oldValueTypewriter = arg_1_1.fswtw_.percent

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_9 = 6
			local var_4_10 = 0.4
			local var_4_11 = arg_1_1:GetWordFromCfg(319351001)
			local var_4_12 = arg_1_1:FormatText(var_4_11.content)
			local var_4_13, var_4_14 = arg_1_1:GetPercentByPara(var_4_12, 1)

			if var_4_8 < arg_1_1.time_ and arg_1_1.time_ <= var_4_8 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				local var_4_15 = var_4_9 <= 0 and var_4_10 or var_4_10 * ((var_4_14 - arg_1_1.typewritterCharCountI18N) / var_4_9)

				if var_4_15 > 0 and var_4_10 < var_4_15 then
					arg_1_1.talkMaxDuration = var_4_15

					if var_4_15 + var_4_8 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_15 + var_4_8
					end
				end
			end

			local var_4_16 = 0.4
			local var_4_17 = math.max(var_4_16, arg_1_1.talkMaxDuration)

			if var_4_8 <= arg_1_1.time_ and arg_1_1.time_ < var_4_8 + var_4_17 then
				local var_4_18 = (arg_1_1.time_ - var_4_8) / var_4_17

				arg_1_1.fswtw_.percent = Mathf.Lerp(arg_1_1.var_.oldValueTypewriter, var_4_13, var_4_18)
				arg_1_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_1_1.fswtw_:SetDirty()
			end

			if arg_1_1.time_ >= var_4_8 + var_4_17 and arg_1_1.time_ < var_4_8 + var_4_17 + arg_4_0 then
				arg_1_1.fswtw_.percent = var_4_13

				arg_1_1.fswtw_:SetDirty()
				arg_1_1:ShowNextGo(true)

				arg_1_1.typewritterCharCountI18N = var_4_14
			end

			local var_4_19 = 1.36666666666667

			if var_4_19 < arg_1_1.time_ and arg_1_1.time_ <= var_4_19 + arg_4_0 then
				arg_1_1.cswbg_:SetActive(true)

				local var_4_20 = arg_1_1.cswt_:GetComponent("RectTransform")

				arg_1_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_4_20.offsetMin = Vector2.New(410, 330)
				var_4_20.offsetMax = Vector2.New(-400, -175)

				local var_4_21 = arg_1_1:GetWordFromCfg(419013)
				local var_4_22 = arg_1_1:FormatText(var_4_21.content)

				arg_1_1.cswt_.text = var_4_22

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.cswt_)

				arg_1_1.cswt_.fontSize = 180
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

			local var_4_39 = 0

			if var_4_39 < arg_1_1.time_ and arg_1_1.time_ <= var_4_39 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_40 = 2

			if var_4_39 <= arg_1_1.time_ and arg_1_1.time_ < var_4_39 + var_4_40 then
				local var_4_41 = (arg_1_1.time_ - var_4_39) / var_4_40
				local var_4_42 = Color.New(0, 0, 0)

				var_4_42.a = Mathf.Lerp(1, 0, var_4_41)
				arg_1_1.mask_.color = var_4_42
			end

			if arg_1_1.time_ >= var_4_39 + var_4_40 and arg_1_1.time_ < var_4_39 + var_4_40 + arg_4_0 then
				local var_4_43 = Color.New(0, 0, 0)
				local var_4_44 = 0

				arg_1_1.mask_.enabled = false
				var_4_43.a = var_4_44
				arg_1_1.mask_.color = var_4_43
			end

			local var_4_45 = 1.73333333333333
			local var_4_46 = 3.166
			local var_4_47 = manager.audio:GetVoiceLength("story_v_out_319351", "319351001", "story_v_out_319351.awb") / 1000

			if var_4_47 > 0 and var_4_46 < var_4_47 and var_4_47 + var_4_45 > arg_1_1.duration_ then
				local var_4_48 = var_4_47

				arg_1_1.duration_ = var_4_47 + var_4_45
			end

			if var_4_45 < arg_1_1.time_ and arg_1_1.time_ <= var_4_45 + arg_4_0 then
				local var_4_49 = "play"
				local var_4_50 = "voice"

				arg_1_1:AudioAction(var_4_49, var_4_50, "story_v_out_319351", "319351001", "story_v_out_319351.awb")
			end

			local var_4_51 = 0
			local var_4_52 = 0.9

			if var_4_51 < arg_1_1.time_ and arg_1_1.time_ <= var_4_51 + arg_4_0 then
				local var_4_53 = "play"
				local var_4_54 = "music"

				arg_1_1:AudioAction(var_4_53, var_4_54, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_55 = ""
				local var_4_56 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_56 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_56 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_56

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_56
						arg_1_1.bgmTxt2_.text = var_4_56
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
	Play319351002 = function(arg_6_0, arg_6_1)
		arg_6_1.time_ = 0
		arg_6_1.frameCnt_ = 0
		arg_6_1.state_ = "playing"
		arg_6_1.curTalkId_ = 319351002
		arg_6_1.duration_ = 6.63

		SetActive(arg_6_1.tipsGo_, false)

		function arg_6_1.onSingleLineFinish_()
			arg_6_1.onSingleLineUpdate_ = nil
			arg_6_1.onSingleLineFinish_ = nil
			arg_6_1.state_ = "waiting"
		end

		function arg_6_1.playNext_(arg_8_0)
			if arg_8_0 == 1 then
				arg_6_0:Play319351003(arg_6_1)
			end
		end

		function arg_6_1.onSingleLineUpdate_(arg_9_0)
			local var_9_0 = "I11o"

			if arg_6_1.bgs_[var_9_0] == nil then
				local var_9_1 = Object.Instantiate(arg_6_1.paintGo_)

				var_9_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_9_0)
				var_9_1.name = var_9_0
				var_9_1.transform.parent = arg_6_1.stage_.transform
				var_9_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_6_1.bgs_[var_9_0] = var_9_1
			end

			local var_9_2 = 0

			if var_9_2 < arg_6_1.time_ and arg_6_1.time_ <= var_9_2 + arg_9_0 then
				local var_9_3 = manager.ui.mainCamera.transform.localPosition
				local var_9_4 = Vector3.New(0, 0, 10) + Vector3.New(var_9_3.x, var_9_3.y, 0)
				local var_9_5 = arg_6_1.bgs_.I11o

				var_9_5.transform.localPosition = var_9_4
				var_9_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_9_6 = var_9_5:GetComponent("SpriteRenderer")

				if var_9_6 and var_9_6.sprite then
					local var_9_7 = (var_9_5.transform.localPosition - var_9_3).z
					local var_9_8 = manager.ui.mainCameraCom_
					local var_9_9 = 2 * var_9_7 * Mathf.Tan(var_9_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_9_10 = var_9_9 * var_9_8.aspect
					local var_9_11 = var_9_6.sprite.bounds.size.x
					local var_9_12 = var_9_6.sprite.bounds.size.y
					local var_9_13 = var_9_10 / var_9_11
					local var_9_14 = var_9_9 / var_9_12
					local var_9_15 = var_9_14 < var_9_13 and var_9_13 or var_9_14

					var_9_5.transform.localScale = Vector3.New(var_9_15, var_9_15, 0)
				end

				for iter_9_0, iter_9_1 in pairs(arg_6_1.bgs_) do
					if iter_9_0 ~= "I11o" then
						iter_9_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_9_16 = 0

			if var_9_16 < arg_6_1.time_ and arg_6_1.time_ <= var_9_16 + arg_9_0 then
				arg_6_1.mask_.enabled = true
				arg_6_1.mask_.raycastTarget = true

				arg_6_1:SetGaussion(false)
			end

			local var_9_17 = 2

			if var_9_16 <= arg_6_1.time_ and arg_6_1.time_ < var_9_16 + var_9_17 then
				local var_9_18 = (arg_6_1.time_ - var_9_16) / var_9_17
				local var_9_19 = Color.New(0, 0, 0)

				var_9_19.a = Mathf.Lerp(1, 0, var_9_18)
				arg_6_1.mask_.color = var_9_19
			end

			if arg_6_1.time_ >= var_9_16 + var_9_17 and arg_6_1.time_ < var_9_16 + var_9_17 + arg_9_0 then
				local var_9_20 = Color.New(0, 0, 0)
				local var_9_21 = 0

				arg_6_1.mask_.enabled = false
				var_9_20.a = var_9_21
				arg_6_1.mask_.color = var_9_20
			end

			local var_9_22 = 0

			if var_9_22 < arg_6_1.time_ and arg_6_1.time_ <= var_9_22 + arg_9_0 then
				arg_6_1.fswbg_:SetActive(false)
				arg_6_1.dialog_:SetActive(false)
				SetActive(arg_6_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_6_1:ShowNextGo(false)
			end

			local var_9_23 = 0.366666666666666

			if var_9_23 < arg_6_1.time_ and arg_6_1.time_ <= var_9_23 + arg_9_0 then
				arg_6_1.fswbg_:SetActive(false)
				arg_6_1.dialog_:SetActive(false)
				SetActive(arg_6_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_6_1:ShowNextGo(false)
			end

			local var_9_24 = 0

			if var_9_24 < arg_6_1.time_ and arg_6_1.time_ <= var_9_24 + arg_9_0 then
				arg_6_1.cswbg_:SetActive(false)
			end

			if arg_6_1.frameCnt_ <= 1 then
				arg_6_1.dialog_:SetActive(false)
			end

			local var_9_25 = 1.63333333333333
			local var_9_26 = 1.025

			if var_9_25 < arg_6_1.time_ and arg_6_1.time_ <= var_9_25 + arg_9_0 then
				arg_6_1.talkMaxDuration = 0

				arg_6_1.dialog_:SetActive(true)

				arg_6_1.dialogCg_.alpha = 0

				local var_9_27 = LeanTween.value(arg_6_1.dialog_, 0, 1, 0.3)

				var_9_27:setOnUpdate(LuaHelper.FloatAction(function(arg_10_0)
					arg_6_1.dialogCg_.alpha = arg_10_0
				end))
				var_9_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_6_1.dialog_)
					var_9_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_6_1.duration_ = arg_6_1.duration_ + 0.3

				SetActive(arg_6_1.leftNameGo_, false)

				arg_6_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_6_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_6_1:RecordName(arg_6_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_6_1.iconTrs_.gameObject, false)
				arg_6_1.callingController_:SetSelectedState("normal")

				local var_9_28 = arg_6_1:GetWordFromCfg(319351002)
				local var_9_29 = arg_6_1:FormatText(var_9_28.content)

				arg_6_1.text_.text = var_9_29

				LuaForUtil.ClearLinePrefixSymbol(arg_6_1.text_)

				local var_9_30 = 41
				local var_9_31 = utf8.len(var_9_29)
				local var_9_32 = var_9_30 <= 0 and var_9_26 or var_9_26 * (var_9_31 / var_9_30)

				if var_9_32 > 0 and var_9_26 < var_9_32 then
					arg_6_1.talkMaxDuration = var_9_32
					var_9_25 = var_9_25 + 0.3

					if var_9_32 + var_9_25 > arg_6_1.duration_ then
						arg_6_1.duration_ = var_9_32 + var_9_25
					end
				end

				arg_6_1.text_.text = var_9_29
				arg_6_1.typewritter.percent = 0

				arg_6_1.typewritter:SetDirty()
				arg_6_1:ShowNextGo(false)
				arg_6_1:RecordContent(arg_6_1.text_.text)
			end

			local var_9_33 = var_9_25 + 0.3
			local var_9_34 = math.max(var_9_26, arg_6_1.talkMaxDuration)

			if var_9_33 <= arg_6_1.time_ and arg_6_1.time_ < var_9_33 + var_9_34 then
				arg_6_1.typewritter.percent = (arg_6_1.time_ - var_9_33) / var_9_34

				arg_6_1.typewritter:SetDirty()
			end

			if arg_6_1.time_ >= var_9_33 + var_9_34 and arg_6_1.time_ < var_9_33 + var_9_34 + arg_9_0 then
				arg_6_1.typewritter.percent = 1

				arg_6_1.typewritter:SetDirty()
				arg_6_1:ShowNextGo(true)
			end
		end

		arg_6_1.nodeConfigList_ = {}

		arg_6_1:InitPlayNodeList()
	end,
	Play319351003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 319351003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play319351004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 0.8

			if var_15_0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_2 = arg_12_1:GetWordFromCfg(319351003)
				local var_15_3 = arg_12_1:FormatText(var_15_2.content)

				arg_12_1.text_.text = var_15_3

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_4 = 32
				local var_15_5 = utf8.len(var_15_3)
				local var_15_6 = var_15_4 <= 0 and var_15_1 or var_15_1 * (var_15_5 / var_15_4)

				if var_15_6 > 0 and var_15_1 < var_15_6 then
					arg_12_1.talkMaxDuration = var_15_6

					if var_15_6 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_6 + var_15_0
					end
				end

				arg_12_1.text_.text = var_15_3
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_7 = math.max(var_15_1, arg_12_1.talkMaxDuration)

			if var_15_0 <= arg_12_1.time_ and arg_12_1.time_ < var_15_0 + var_15_7 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_0) / var_15_7

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_0 + var_15_7 and arg_12_1.time_ < var_15_0 + var_15_7 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play319351004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 319351004
		arg_16_1.duration_ = 7.53

		local var_16_0 = {
			zh = 3.166,
			ja = 7.533
		}
		local var_16_1 = manager.audio:GetLocalizationFlag()

		if var_16_0[var_16_1] ~= nil then
			arg_16_1.duration_ = var_16_0[var_16_1]
		end

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play319351005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = "1084ui_story"

			if arg_16_1.actors_[var_19_0] == nil then
				local var_19_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_19_1) then
					local var_19_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_16_1.stage_.transform)

					var_19_2.name = var_19_0
					var_19_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_16_1.actors_[var_19_0] = var_19_2

					local var_19_3 = var_19_2:GetComponentInChildren(typeof(CharacterEffect))

					var_19_3.enabled = true

					local var_19_4 = GameObjectTools.GetOrAddComponent(var_19_2, typeof(DynamicBoneHelper))

					if var_19_4 then
						var_19_4:EnableDynamicBone(false)
					end

					arg_16_1:ShowWeapon(var_19_3.transform, false)

					arg_16_1.var_[var_19_0 .. "Animator"] = var_19_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_16_1.var_[var_19_0 .. "Animator"].applyRootMotion = true
					arg_16_1.var_[var_19_0 .. "LipSync"] = var_19_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_19_5 = arg_16_1.actors_["1084ui_story"].transform
			local var_19_6 = 0

			if var_19_6 < arg_16_1.time_ and arg_16_1.time_ <= var_19_6 + arg_19_0 then
				arg_16_1.var_.moveOldPos1084ui_story = var_19_5.localPosition

				local var_19_7 = "1084ui_story"

				arg_16_1:ShowWeapon(arg_16_1.var_[var_19_7 .. "Animator"].transform, false)
			end

			local var_19_8 = 0.001

			if var_19_6 <= arg_16_1.time_ and arg_16_1.time_ < var_19_6 + var_19_8 then
				local var_19_9 = (arg_16_1.time_ - var_19_6) / var_19_8
				local var_19_10 = Vector3.New(0, -0.97, -6)

				var_19_5.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1084ui_story, var_19_10, var_19_9)

				local var_19_11 = manager.ui.mainCamera.transform.position - var_19_5.position

				var_19_5.forward = Vector3.New(var_19_11.x, var_19_11.y, var_19_11.z)

				local var_19_12 = var_19_5.localEulerAngles

				var_19_12.z = 0
				var_19_12.x = 0
				var_19_5.localEulerAngles = var_19_12
			end

			if arg_16_1.time_ >= var_19_6 + var_19_8 and arg_16_1.time_ < var_19_6 + var_19_8 + arg_19_0 then
				var_19_5.localPosition = Vector3.New(0, -0.97, -6)

				local var_19_13 = manager.ui.mainCamera.transform.position - var_19_5.position

				var_19_5.forward = Vector3.New(var_19_13.x, var_19_13.y, var_19_13.z)

				local var_19_14 = var_19_5.localEulerAngles

				var_19_14.z = 0
				var_19_14.x = 0
				var_19_5.localEulerAngles = var_19_14
			end

			local var_19_15 = arg_16_1.actors_["1084ui_story"]
			local var_19_16 = 0

			if var_19_16 < arg_16_1.time_ and arg_16_1.time_ <= var_19_16 + arg_19_0 and not isNil(var_19_15) and arg_16_1.var_.characterEffect1084ui_story == nil then
				arg_16_1.var_.characterEffect1084ui_story = var_19_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_17 = 0.200000002980232

			if var_19_16 <= arg_16_1.time_ and arg_16_1.time_ < var_19_16 + var_19_17 and not isNil(var_19_15) then
				local var_19_18 = (arg_16_1.time_ - var_19_16) / var_19_17

				if arg_16_1.var_.characterEffect1084ui_story and not isNil(var_19_15) then
					arg_16_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_16 + var_19_17 and arg_16_1.time_ < var_19_16 + var_19_17 + arg_19_0 and not isNil(var_19_15) and arg_16_1.var_.characterEffect1084ui_story then
				arg_16_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_19_19 = 0

			if var_19_19 < arg_16_1.time_ and arg_16_1.time_ <= var_19_19 + arg_19_0 then
				arg_16_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			local var_19_20 = 0

			if var_19_20 < arg_16_1.time_ and arg_16_1.time_ <= var_19_20 + arg_19_0 then
				arg_16_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_19_21 = 0
			local var_19_22 = 0.4

			if var_19_21 < arg_16_1.time_ and arg_16_1.time_ <= var_19_21 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_23 = arg_16_1:FormatText(StoryNameCfg[6].name)

				arg_16_1.leftNameTxt_.text = var_19_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_24 = arg_16_1:GetWordFromCfg(319351004)
				local var_19_25 = arg_16_1:FormatText(var_19_24.content)

				arg_16_1.text_.text = var_19_25

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_26 = 16
				local var_19_27 = utf8.len(var_19_25)
				local var_19_28 = var_19_26 <= 0 and var_19_22 or var_19_22 * (var_19_27 / var_19_26)

				if var_19_28 > 0 and var_19_22 < var_19_28 then
					arg_16_1.talkMaxDuration = var_19_28

					if var_19_28 + var_19_21 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_28 + var_19_21
					end
				end

				arg_16_1.text_.text = var_19_25
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319351", "319351004", "story_v_out_319351.awb") ~= 0 then
					local var_19_29 = manager.audio:GetVoiceLength("story_v_out_319351", "319351004", "story_v_out_319351.awb") / 1000

					if var_19_29 + var_19_21 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_29 + var_19_21
					end

					if var_19_24.prefab_name ~= "" and arg_16_1.actors_[var_19_24.prefab_name] ~= nil then
						local var_19_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_24.prefab_name].transform, "story_v_out_319351", "319351004", "story_v_out_319351.awb")

						arg_16_1:RecordAudio("319351004", var_19_30)
						arg_16_1:RecordAudio("319351004", var_19_30)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_319351", "319351004", "story_v_out_319351.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_319351", "319351004", "story_v_out_319351.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_31 = math.max(var_19_22, arg_16_1.talkMaxDuration)

			if var_19_21 <= arg_16_1.time_ and arg_16_1.time_ < var_19_21 + var_19_31 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_21) / var_19_31

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_21 + var_19_31 and arg_16_1.time_ < var_19_21 + var_19_31 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
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

		arg_16_1:InitPlayNodeList()
	end,
	Play319351005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 319351005
		arg_20_1.duration_ = 4.63

		local var_20_0 = {
			zh = 3.066,
			ja = 4.633
		}
		local var_20_1 = manager.audio:GetLocalizationFlag()

		if var_20_0[var_20_1] ~= nil then
			arg_20_1.duration_ = var_20_0[var_20_1]
		end

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play319351006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = "10058ui_story"

			if arg_20_1.actors_[var_23_0] == nil then
				local var_23_1 = Asset.Load("Char/" .. "10058ui_story")

				if not isNil(var_23_1) then
					local var_23_2 = Object.Instantiate(Asset.Load("Char/" .. "10058ui_story"), arg_20_1.stage_.transform)

					var_23_2.name = var_23_0
					var_23_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_20_1.actors_[var_23_0] = var_23_2

					local var_23_3 = var_23_2:GetComponentInChildren(typeof(CharacterEffect))

					var_23_3.enabled = true

					local var_23_4 = GameObjectTools.GetOrAddComponent(var_23_2, typeof(DynamicBoneHelper))

					if var_23_4 then
						var_23_4:EnableDynamicBone(false)
					end

					arg_20_1:ShowWeapon(var_23_3.transform, false)

					arg_20_1.var_[var_23_0 .. "Animator"] = var_23_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_20_1.var_[var_23_0 .. "Animator"].applyRootMotion = true
					arg_20_1.var_[var_23_0 .. "LipSync"] = var_23_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_23_5 = arg_20_1.actors_["10058ui_story"].transform
			local var_23_6 = 0

			if var_23_6 < arg_20_1.time_ and arg_20_1.time_ <= var_23_6 + arg_23_0 then
				arg_20_1.var_.moveOldPos10058ui_story = var_23_5.localPosition
			end

			local var_23_7 = 0.001

			if var_23_6 <= arg_20_1.time_ and arg_20_1.time_ < var_23_6 + var_23_7 then
				local var_23_8 = (arg_20_1.time_ - var_23_6) / var_23_7
				local var_23_9 = Vector3.New(0.7, -0.98, -6.1)

				var_23_5.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos10058ui_story, var_23_9, var_23_8)

				local var_23_10 = manager.ui.mainCamera.transform.position - var_23_5.position

				var_23_5.forward = Vector3.New(var_23_10.x, var_23_10.y, var_23_10.z)

				local var_23_11 = var_23_5.localEulerAngles

				var_23_11.z = 0
				var_23_11.x = 0
				var_23_5.localEulerAngles = var_23_11
			end

			if arg_20_1.time_ >= var_23_6 + var_23_7 and arg_20_1.time_ < var_23_6 + var_23_7 + arg_23_0 then
				var_23_5.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_23_12 = manager.ui.mainCamera.transform.position - var_23_5.position

				var_23_5.forward = Vector3.New(var_23_12.x, var_23_12.y, var_23_12.z)

				local var_23_13 = var_23_5.localEulerAngles

				var_23_13.z = 0
				var_23_13.x = 0
				var_23_5.localEulerAngles = var_23_13
			end

			local var_23_14 = arg_20_1.actors_["10058ui_story"]
			local var_23_15 = 0

			if var_23_15 < arg_20_1.time_ and arg_20_1.time_ <= var_23_15 + arg_23_0 and not isNil(var_23_14) and arg_20_1.var_.characterEffect10058ui_story == nil then
				arg_20_1.var_.characterEffect10058ui_story = var_23_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_16 = 0.200000002980232

			if var_23_15 <= arg_20_1.time_ and arg_20_1.time_ < var_23_15 + var_23_16 and not isNil(var_23_14) then
				local var_23_17 = (arg_20_1.time_ - var_23_15) / var_23_16

				if arg_20_1.var_.characterEffect10058ui_story and not isNil(var_23_14) then
					arg_20_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= var_23_15 + var_23_16 and arg_20_1.time_ < var_23_15 + var_23_16 + arg_23_0 and not isNil(var_23_14) and arg_20_1.var_.characterEffect10058ui_story then
				arg_20_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_23_18 = arg_20_1.actors_["1084ui_story"].transform
			local var_23_19 = 0

			if var_23_19 < arg_20_1.time_ and arg_20_1.time_ <= var_23_19 + arg_23_0 then
				arg_20_1.var_.moveOldPos1084ui_story = var_23_18.localPosition
			end

			local var_23_20 = 0.001

			if var_23_19 <= arg_20_1.time_ and arg_20_1.time_ < var_23_19 + var_23_20 then
				local var_23_21 = (arg_20_1.time_ - var_23_19) / var_23_20
				local var_23_22 = Vector3.New(-0.7, -0.97, -6)

				var_23_18.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1084ui_story, var_23_22, var_23_21)

				local var_23_23 = manager.ui.mainCamera.transform.position - var_23_18.position

				var_23_18.forward = Vector3.New(var_23_23.x, var_23_23.y, var_23_23.z)

				local var_23_24 = var_23_18.localEulerAngles

				var_23_24.z = 0
				var_23_24.x = 0
				var_23_18.localEulerAngles = var_23_24
			end

			if arg_20_1.time_ >= var_23_19 + var_23_20 and arg_20_1.time_ < var_23_19 + var_23_20 + arg_23_0 then
				var_23_18.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_23_25 = manager.ui.mainCamera.transform.position - var_23_18.position

				var_23_18.forward = Vector3.New(var_23_25.x, var_23_25.y, var_23_25.z)

				local var_23_26 = var_23_18.localEulerAngles

				var_23_26.z = 0
				var_23_26.x = 0
				var_23_18.localEulerAngles = var_23_26
			end

			local var_23_27 = arg_20_1.actors_["1084ui_story"]
			local var_23_28 = 0

			if var_23_28 < arg_20_1.time_ and arg_20_1.time_ <= var_23_28 + arg_23_0 and not isNil(var_23_27) and arg_20_1.var_.characterEffect1084ui_story == nil then
				arg_20_1.var_.characterEffect1084ui_story = var_23_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_29 = 0.200000002980232

			if var_23_28 <= arg_20_1.time_ and arg_20_1.time_ < var_23_28 + var_23_29 and not isNil(var_23_27) then
				local var_23_30 = (arg_20_1.time_ - var_23_28) / var_23_29

				if arg_20_1.var_.characterEffect1084ui_story and not isNil(var_23_27) then
					local var_23_31 = Mathf.Lerp(0, 0.5, var_23_30)

					arg_20_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1084ui_story.fillRatio = var_23_31
				end
			end

			if arg_20_1.time_ >= var_23_28 + var_23_29 and arg_20_1.time_ < var_23_28 + var_23_29 + arg_23_0 and not isNil(var_23_27) and arg_20_1.var_.characterEffect1084ui_story then
				local var_23_32 = 0.5

				arg_20_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1084ui_story.fillRatio = var_23_32
			end

			local var_23_33 = 0

			if var_23_33 < arg_20_1.time_ and arg_20_1.time_ <= var_23_33 + arg_23_0 then
				arg_20_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_23_34 = 0
			local var_23_35 = 0.3

			if var_23_34 < arg_20_1.time_ and arg_20_1.time_ <= var_23_34 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_36 = arg_20_1:FormatText(StoryNameCfg[471].name)

				arg_20_1.leftNameTxt_.text = var_23_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_37 = arg_20_1:GetWordFromCfg(319351005)
				local var_23_38 = arg_20_1:FormatText(var_23_37.content)

				arg_20_1.text_.text = var_23_38

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_39 = 12
				local var_23_40 = utf8.len(var_23_38)
				local var_23_41 = var_23_39 <= 0 and var_23_35 or var_23_35 * (var_23_40 / var_23_39)

				if var_23_41 > 0 and var_23_35 < var_23_41 then
					arg_20_1.talkMaxDuration = var_23_41

					if var_23_41 + var_23_34 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_41 + var_23_34
					end
				end

				arg_20_1.text_.text = var_23_38
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319351", "319351005", "story_v_out_319351.awb") ~= 0 then
					local var_23_42 = manager.audio:GetVoiceLength("story_v_out_319351", "319351005", "story_v_out_319351.awb") / 1000

					if var_23_42 + var_23_34 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_42 + var_23_34
					end

					if var_23_37.prefab_name ~= "" and arg_20_1.actors_[var_23_37.prefab_name] ~= nil then
						local var_23_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_37.prefab_name].transform, "story_v_out_319351", "319351005", "story_v_out_319351.awb")

						arg_20_1:RecordAudio("319351005", var_23_43)
						arg_20_1:RecordAudio("319351005", var_23_43)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_319351", "319351005", "story_v_out_319351.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_319351", "319351005", "story_v_out_319351.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_44 = math.max(var_23_35, arg_20_1.talkMaxDuration)

			if var_23_34 <= arg_20_1.time_ and arg_20_1.time_ < var_23_34 + var_23_44 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_34) / var_23_44

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_34 + var_23_44 and arg_20_1.time_ < var_23_34 + var_23_44 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
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
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play319351006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 319351006
		arg_24_1.duration_ = 5.37

		local var_24_0 = {
			zh = 3.866,
			ja = 5.366
		}
		local var_24_1 = manager.audio:GetLocalizationFlag()

		if var_24_0[var_24_1] ~= nil then
			arg_24_1.duration_ = var_24_0[var_24_1]
		end

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play319351007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0

			if var_27_0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				arg_24_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action7_1")
			end

			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 then
				arg_24_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_27_2 = 0
			local var_27_3 = 0.45

			if var_27_2 < arg_24_1.time_ and arg_24_1.time_ <= var_27_2 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_4 = arg_24_1:FormatText(StoryNameCfg[471].name)

				arg_24_1.leftNameTxt_.text = var_27_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_5 = arg_24_1:GetWordFromCfg(319351006)
				local var_27_6 = arg_24_1:FormatText(var_27_5.content)

				arg_24_1.text_.text = var_27_6

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_7 = 18
				local var_27_8 = utf8.len(var_27_6)
				local var_27_9 = var_27_7 <= 0 and var_27_3 or var_27_3 * (var_27_8 / var_27_7)

				if var_27_9 > 0 and var_27_3 < var_27_9 then
					arg_24_1.talkMaxDuration = var_27_9

					if var_27_9 + var_27_2 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_9 + var_27_2
					end
				end

				arg_24_1.text_.text = var_27_6
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319351", "319351006", "story_v_out_319351.awb") ~= 0 then
					local var_27_10 = manager.audio:GetVoiceLength("story_v_out_319351", "319351006", "story_v_out_319351.awb") / 1000

					if var_27_10 + var_27_2 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_10 + var_27_2
					end

					if var_27_5.prefab_name ~= "" and arg_24_1.actors_[var_27_5.prefab_name] ~= nil then
						local var_27_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_5.prefab_name].transform, "story_v_out_319351", "319351006", "story_v_out_319351.awb")

						arg_24_1:RecordAudio("319351006", var_27_11)
						arg_24_1:RecordAudio("319351006", var_27_11)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_319351", "319351006", "story_v_out_319351.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_319351", "319351006", "story_v_out_319351.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_12 = math.max(var_27_3, arg_24_1.talkMaxDuration)

			if var_27_2 <= arg_24_1.time_ and arg_24_1.time_ < var_27_2 + var_27_12 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_2) / var_27_12

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_2 + var_27_12 and arg_24_1.time_ < var_27_2 + var_27_12 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play319351007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 319351007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play319351008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["10058ui_story"]
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect10058ui_story == nil then
				arg_28_1.var_.characterEffect10058ui_story = var_31_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.200000002980232

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 and not isNil(var_31_0) then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2

				if arg_28_1.var_.characterEffect10058ui_story and not isNil(var_31_0) then
					local var_31_4 = Mathf.Lerp(0, 0.5, var_31_3)

					arg_28_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_28_1.var_.characterEffect10058ui_story.fillRatio = var_31_4
				end
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect10058ui_story then
				local var_31_5 = 0.5

				arg_28_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_28_1.var_.characterEffect10058ui_story.fillRatio = var_31_5
			end

			local var_31_6 = 0
			local var_31_7 = 0.75

			if var_31_6 < arg_28_1.time_ and arg_28_1.time_ <= var_31_6 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, false)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_8 = arg_28_1:GetWordFromCfg(319351007)
				local var_31_9 = arg_28_1:FormatText(var_31_8.content)

				arg_28_1.text_.text = var_31_9

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_10 = 30
				local var_31_11 = utf8.len(var_31_9)
				local var_31_12 = var_31_10 <= 0 and var_31_7 or var_31_7 * (var_31_11 / var_31_10)

				if var_31_12 > 0 and var_31_7 < var_31_12 then
					arg_28_1.talkMaxDuration = var_31_12

					if var_31_12 + var_31_6 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_12 + var_31_6
					end
				end

				arg_28_1.text_.text = var_31_9
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_13 = math.max(var_31_7, arg_28_1.talkMaxDuration)

			if var_31_6 <= arg_28_1.time_ and arg_28_1.time_ < var_31_6 + var_31_13 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_6) / var_31_13

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_6 + var_31_13 and arg_28_1.time_ < var_31_6 + var_31_13 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play319351008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 319351008
		arg_32_1.duration_ = 8.8

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play319351009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = "ST74"

			if arg_32_1.bgs_[var_35_0] == nil then
				local var_35_1 = Object.Instantiate(arg_32_1.paintGo_)

				var_35_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_35_0)
				var_35_1.name = var_35_0
				var_35_1.transform.parent = arg_32_1.stage_.transform
				var_35_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_32_1.bgs_[var_35_0] = var_35_1
			end

			local var_35_2 = 2

			if var_35_2 < arg_32_1.time_ and arg_32_1.time_ <= var_35_2 + arg_35_0 then
				local var_35_3 = manager.ui.mainCamera.transform.localPosition
				local var_35_4 = Vector3.New(0, 0, 10) + Vector3.New(var_35_3.x, var_35_3.y, 0)
				local var_35_5 = arg_32_1.bgs_.ST74

				var_35_5.transform.localPosition = var_35_4
				var_35_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_35_6 = var_35_5:GetComponent("SpriteRenderer")

				if var_35_6 and var_35_6.sprite then
					local var_35_7 = (var_35_5.transform.localPosition - var_35_3).z
					local var_35_8 = manager.ui.mainCameraCom_
					local var_35_9 = 2 * var_35_7 * Mathf.Tan(var_35_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_35_10 = var_35_9 * var_35_8.aspect
					local var_35_11 = var_35_6.sprite.bounds.size.x
					local var_35_12 = var_35_6.sprite.bounds.size.y
					local var_35_13 = var_35_10 / var_35_11
					local var_35_14 = var_35_9 / var_35_12
					local var_35_15 = var_35_14 < var_35_13 and var_35_13 or var_35_14

					var_35_5.transform.localScale = Vector3.New(var_35_15, var_35_15, 0)
				end

				for iter_35_0, iter_35_1 in pairs(arg_32_1.bgs_) do
					if iter_35_0 ~= "ST74" then
						iter_35_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_35_16 = 0

			if var_35_16 < arg_32_1.time_ and arg_32_1.time_ <= var_35_16 + arg_35_0 then
				arg_32_1.mask_.enabled = true
				arg_32_1.mask_.raycastTarget = true

				arg_32_1:SetGaussion(false)
			end

			local var_35_17 = 2

			if var_35_16 <= arg_32_1.time_ and arg_32_1.time_ < var_35_16 + var_35_17 then
				local var_35_18 = (arg_32_1.time_ - var_35_16) / var_35_17
				local var_35_19 = Color.New(0, 0, 0)

				var_35_19.a = Mathf.Lerp(0, 1, var_35_18)
				arg_32_1.mask_.color = var_35_19
			end

			if arg_32_1.time_ >= var_35_16 + var_35_17 and arg_32_1.time_ < var_35_16 + var_35_17 + arg_35_0 then
				local var_35_20 = Color.New(0, 0, 0)

				var_35_20.a = 1
				arg_32_1.mask_.color = var_35_20
			end

			local var_35_21 = 2

			if var_35_21 < arg_32_1.time_ and arg_32_1.time_ <= var_35_21 + arg_35_0 then
				arg_32_1.mask_.enabled = true
				arg_32_1.mask_.raycastTarget = true

				arg_32_1:SetGaussion(false)
			end

			local var_35_22 = 2

			if var_35_21 <= arg_32_1.time_ and arg_32_1.time_ < var_35_21 + var_35_22 then
				local var_35_23 = (arg_32_1.time_ - var_35_21) / var_35_22
				local var_35_24 = Color.New(0, 0, 0)

				var_35_24.a = Mathf.Lerp(1, 0, var_35_23)
				arg_32_1.mask_.color = var_35_24
			end

			if arg_32_1.time_ >= var_35_21 + var_35_22 and arg_32_1.time_ < var_35_21 + var_35_22 + arg_35_0 then
				local var_35_25 = Color.New(0, 0, 0)
				local var_35_26 = 0

				arg_32_1.mask_.enabled = false
				var_35_25.a = var_35_26
				arg_32_1.mask_.color = var_35_25
			end

			local var_35_27 = 0
			local var_35_28 = 0.0666666666666667

			if var_35_27 < arg_32_1.time_ and arg_32_1.time_ <= var_35_27 + arg_35_0 then
				local var_35_29 = "play"
				local var_35_30 = "music"

				arg_32_1:AudioAction(var_35_29, var_35_30, "ui_battle", "ui_battle_stopbgm", "")

				local var_35_31 = ""
				local var_35_32 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_35_32 ~= "" then
					if arg_32_1.bgmTxt_.text ~= var_35_32 and arg_32_1.bgmTxt_.text ~= "" then
						if arg_32_1.bgmTxt2_.text ~= "" then
							arg_32_1.bgmTxt_.text = arg_32_1.bgmTxt2_.text
						end

						arg_32_1.bgmTxt2_.text = var_35_32

						arg_32_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_32_1.bgmTxt_.text = var_35_32
						arg_32_1.bgmTxt2_.text = var_35_32
					end

					if arg_32_1.bgmTimer then
						arg_32_1.bgmTimer:Stop()

						arg_32_1.bgmTimer = nil
					end

					if arg_32_1.settingData.show_music_name == 1 then
						arg_32_1.musicController:SetSelectedState("show")
						arg_32_1.musicAnimator_:Play("open", 0, 0)

						if arg_32_1.settingData.music_time ~= 0 then
							arg_32_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_32_1.settingData.music_time), function()
								if arg_32_1 == nil or isNil(arg_32_1.bgmTxt_) then
									return
								end

								arg_32_1.musicController:SetSelectedState("hide")
								arg_32_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_35_33 = 0.1
			local var_35_34 = 1

			if var_35_33 < arg_32_1.time_ and arg_32_1.time_ <= var_35_33 + arg_35_0 then
				local var_35_35 = "play"
				local var_35_36 = "music"

				arg_32_1:AudioAction(var_35_35, var_35_36, "bgm_activity_3_0_story_moon", "bgm_activity_3_0_story_moon", "bgm_activity_3_0_story_moon.awb")

				local var_35_37 = ""
				local var_35_38 = manager.audio:GetAudioName("bgm_activity_3_0_story_moon", "bgm_activity_3_0_story_moon")

				if var_35_38 ~= "" then
					if arg_32_1.bgmTxt_.text ~= var_35_38 and arg_32_1.bgmTxt_.text ~= "" then
						if arg_32_1.bgmTxt2_.text ~= "" then
							arg_32_1.bgmTxt_.text = arg_32_1.bgmTxt2_.text
						end

						arg_32_1.bgmTxt2_.text = var_35_38

						arg_32_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_32_1.bgmTxt_.text = var_35_38
						arg_32_1.bgmTxt2_.text = var_35_38
					end

					if arg_32_1.bgmTimer then
						arg_32_1.bgmTimer:Stop()

						arg_32_1.bgmTimer = nil
					end

					if arg_32_1.settingData.show_music_name == 1 then
						arg_32_1.musicController:SetSelectedState("show")
						arg_32_1.musicAnimator_:Play("open", 0, 0)

						if arg_32_1.settingData.music_time ~= 0 then
							arg_32_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_32_1.settingData.music_time), function()
								if arg_32_1 == nil or isNil(arg_32_1.bgmTxt_) then
									return
								end

								arg_32_1.musicController:SetSelectedState("hide")
								arg_32_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_35_39 = arg_32_1.actors_["10058ui_story"].transform
			local var_35_40 = 2

			if var_35_40 < arg_32_1.time_ and arg_32_1.time_ <= var_35_40 + arg_35_0 then
				arg_32_1.var_.moveOldPos10058ui_story = var_35_39.localPosition
			end

			local var_35_41 = 0.001

			if var_35_40 <= arg_32_1.time_ and arg_32_1.time_ < var_35_40 + var_35_41 then
				local var_35_42 = (arg_32_1.time_ - var_35_40) / var_35_41
				local var_35_43 = Vector3.New(0, 100, 0)

				var_35_39.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos10058ui_story, var_35_43, var_35_42)

				local var_35_44 = manager.ui.mainCamera.transform.position - var_35_39.position

				var_35_39.forward = Vector3.New(var_35_44.x, var_35_44.y, var_35_44.z)

				local var_35_45 = var_35_39.localEulerAngles

				var_35_45.z = 0
				var_35_45.x = 0
				var_35_39.localEulerAngles = var_35_45
			end

			if arg_32_1.time_ >= var_35_40 + var_35_41 and arg_32_1.time_ < var_35_40 + var_35_41 + arg_35_0 then
				var_35_39.localPosition = Vector3.New(0, 100, 0)

				local var_35_46 = manager.ui.mainCamera.transform.position - var_35_39.position

				var_35_39.forward = Vector3.New(var_35_46.x, var_35_46.y, var_35_46.z)

				local var_35_47 = var_35_39.localEulerAngles

				var_35_47.z = 0
				var_35_47.x = 0
				var_35_39.localEulerAngles = var_35_47
			end

			local var_35_48 = arg_32_1.actors_["1084ui_story"].transform
			local var_35_49 = 2

			if var_35_49 < arg_32_1.time_ and arg_32_1.time_ <= var_35_49 + arg_35_0 then
				arg_32_1.var_.moveOldPos1084ui_story = var_35_48.localPosition
			end

			local var_35_50 = 0.001

			if var_35_49 <= arg_32_1.time_ and arg_32_1.time_ < var_35_49 + var_35_50 then
				local var_35_51 = (arg_32_1.time_ - var_35_49) / var_35_50
				local var_35_52 = Vector3.New(0, 100, 0)

				var_35_48.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1084ui_story, var_35_52, var_35_51)

				local var_35_53 = manager.ui.mainCamera.transform.position - var_35_48.position

				var_35_48.forward = Vector3.New(var_35_53.x, var_35_53.y, var_35_53.z)

				local var_35_54 = var_35_48.localEulerAngles

				var_35_54.z = 0
				var_35_54.x = 0
				var_35_48.localEulerAngles = var_35_54
			end

			if arg_32_1.time_ >= var_35_49 + var_35_50 and arg_32_1.time_ < var_35_49 + var_35_50 + arg_35_0 then
				var_35_48.localPosition = Vector3.New(0, 100, 0)

				local var_35_55 = manager.ui.mainCamera.transform.position - var_35_48.position

				var_35_48.forward = Vector3.New(var_35_55.x, var_35_55.y, var_35_55.z)

				local var_35_56 = var_35_48.localEulerAngles

				var_35_56.z = 0
				var_35_56.x = 0
				var_35_48.localEulerAngles = var_35_56
			end

			if arg_32_1.frameCnt_ <= 1 then
				arg_32_1.dialog_:SetActive(false)
			end

			local var_35_57 = 3.8
			local var_35_58 = 1.625

			if var_35_57 < arg_32_1.time_ and arg_32_1.time_ <= var_35_57 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0

				arg_32_1.dialog_:SetActive(true)

				arg_32_1.dialogCg_.alpha = 0

				local var_35_59 = LeanTween.value(arg_32_1.dialog_, 0, 1, 0.3)

				var_35_59:setOnUpdate(LuaHelper.FloatAction(function(arg_38_0)
					arg_32_1.dialogCg_.alpha = arg_38_0
				end))
				var_35_59:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_32_1.dialog_)
					var_35_59:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_32_1.duration_ = arg_32_1.duration_ + 0.3

				SetActive(arg_32_1.leftNameGo_, false)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_60 = arg_32_1:GetWordFromCfg(319351008)
				local var_35_61 = arg_32_1:FormatText(var_35_60.content)

				arg_32_1.text_.text = var_35_61

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_62 = 65
				local var_35_63 = utf8.len(var_35_61)
				local var_35_64 = var_35_62 <= 0 and var_35_58 or var_35_58 * (var_35_63 / var_35_62)

				if var_35_64 > 0 and var_35_58 < var_35_64 then
					arg_32_1.talkMaxDuration = var_35_64
					var_35_57 = var_35_57 + 0.3

					if var_35_64 + var_35_57 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_64 + var_35_57
					end
				end

				arg_32_1.text_.text = var_35_61
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_65 = var_35_57 + 0.3
			local var_35_66 = math.max(var_35_58, arg_32_1.talkMaxDuration)

			if var_35_65 <= arg_32_1.time_ and arg_32_1.time_ < var_35_65 + var_35_66 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_65) / var_35_66

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_65 + var_35_66 and arg_32_1.time_ < var_35_65 + var_35_66 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play319351009 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 319351009
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play319351010(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0
			local var_43_1 = 1.25

			if var_43_0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, false)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_2 = arg_40_1:GetWordFromCfg(319351009)
				local var_43_3 = arg_40_1:FormatText(var_43_2.content)

				arg_40_1.text_.text = var_43_3

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_4 = 50
				local var_43_5 = utf8.len(var_43_3)
				local var_43_6 = var_43_4 <= 0 and var_43_1 or var_43_1 * (var_43_5 / var_43_4)

				if var_43_6 > 0 and var_43_1 < var_43_6 then
					arg_40_1.talkMaxDuration = var_43_6

					if var_43_6 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_6 + var_43_0
					end
				end

				arg_40_1.text_.text = var_43_3
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_7 = math.max(var_43_1, arg_40_1.talkMaxDuration)

			if var_43_0 <= arg_40_1.time_ and arg_40_1.time_ < var_43_0 + var_43_7 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_0) / var_43_7

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_0 + var_43_7 and arg_40_1.time_ < var_43_0 + var_43_7 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play319351010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 319351010
		arg_44_1.duration_ = 5.67

		local var_44_0 = {
			zh = 3.433,
			ja = 5.666
		}
		local var_44_1 = manager.audio:GetLocalizationFlag()

		if var_44_0[var_44_1] ~= nil then
			arg_44_1.duration_ = var_44_0[var_44_1]
		end

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play319351011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["1084ui_story"].transform
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 then
				arg_44_1.var_.moveOldPos1084ui_story = var_47_0.localPosition

				local var_47_2 = "1084ui_story"

				arg_44_1:ShowWeapon(arg_44_1.var_[var_47_2 .. "Animator"].transform, false)
			end

			local var_47_3 = 0.001

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_3 then
				local var_47_4 = (arg_44_1.time_ - var_47_1) / var_47_3
				local var_47_5 = Vector3.New(0, -0.97, -6)

				var_47_0.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1084ui_story, var_47_5, var_47_4)

				local var_47_6 = manager.ui.mainCamera.transform.position - var_47_0.position

				var_47_0.forward = Vector3.New(var_47_6.x, var_47_6.y, var_47_6.z)

				local var_47_7 = var_47_0.localEulerAngles

				var_47_7.z = 0
				var_47_7.x = 0
				var_47_0.localEulerAngles = var_47_7
			end

			if arg_44_1.time_ >= var_47_1 + var_47_3 and arg_44_1.time_ < var_47_1 + var_47_3 + arg_47_0 then
				var_47_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_47_8 = manager.ui.mainCamera.transform.position - var_47_0.position

				var_47_0.forward = Vector3.New(var_47_8.x, var_47_8.y, var_47_8.z)

				local var_47_9 = var_47_0.localEulerAngles

				var_47_9.z = 0
				var_47_9.x = 0
				var_47_0.localEulerAngles = var_47_9
			end

			local var_47_10 = arg_44_1.actors_["1084ui_story"]
			local var_47_11 = 0

			if var_47_11 < arg_44_1.time_ and arg_44_1.time_ <= var_47_11 + arg_47_0 and not isNil(var_47_10) and arg_44_1.var_.characterEffect1084ui_story == nil then
				arg_44_1.var_.characterEffect1084ui_story = var_47_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_12 = 0.200000002980232

			if var_47_11 <= arg_44_1.time_ and arg_44_1.time_ < var_47_11 + var_47_12 and not isNil(var_47_10) then
				local var_47_13 = (arg_44_1.time_ - var_47_11) / var_47_12

				if arg_44_1.var_.characterEffect1084ui_story and not isNil(var_47_10) then
					arg_44_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= var_47_11 + var_47_12 and arg_44_1.time_ < var_47_11 + var_47_12 + arg_47_0 and not isNil(var_47_10) and arg_44_1.var_.characterEffect1084ui_story then
				arg_44_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_47_14 = 0

			if var_47_14 < arg_44_1.time_ and arg_44_1.time_ <= var_47_14 + arg_47_0 then
				arg_44_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_47_15 = 0

			if var_47_15 < arg_44_1.time_ and arg_44_1.time_ <= var_47_15 + arg_47_0 then
				arg_44_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_47_16 = 0
			local var_47_17 = 0.375

			if var_47_16 < arg_44_1.time_ and arg_44_1.time_ <= var_47_16 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_18 = arg_44_1:FormatText(StoryNameCfg[6].name)

				arg_44_1.leftNameTxt_.text = var_47_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_19 = arg_44_1:GetWordFromCfg(319351010)
				local var_47_20 = arg_44_1:FormatText(var_47_19.content)

				arg_44_1.text_.text = var_47_20

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_21 = 15
				local var_47_22 = utf8.len(var_47_20)
				local var_47_23 = var_47_21 <= 0 and var_47_17 or var_47_17 * (var_47_22 / var_47_21)

				if var_47_23 > 0 and var_47_17 < var_47_23 then
					arg_44_1.talkMaxDuration = var_47_23

					if var_47_23 + var_47_16 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_23 + var_47_16
					end
				end

				arg_44_1.text_.text = var_47_20
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319351", "319351010", "story_v_out_319351.awb") ~= 0 then
					local var_47_24 = manager.audio:GetVoiceLength("story_v_out_319351", "319351010", "story_v_out_319351.awb") / 1000

					if var_47_24 + var_47_16 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_24 + var_47_16
					end

					if var_47_19.prefab_name ~= "" and arg_44_1.actors_[var_47_19.prefab_name] ~= nil then
						local var_47_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_19.prefab_name].transform, "story_v_out_319351", "319351010", "story_v_out_319351.awb")

						arg_44_1:RecordAudio("319351010", var_47_25)
						arg_44_1:RecordAudio("319351010", var_47_25)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_319351", "319351010", "story_v_out_319351.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_319351", "319351010", "story_v_out_319351.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_26 = math.max(var_47_17, arg_44_1.talkMaxDuration)

			if var_47_16 <= arg_44_1.time_ and arg_44_1.time_ < var_47_16 + var_47_26 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_16) / var_47_26

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_16 + var_47_26 and arg_44_1.time_ < var_47_16 + var_47_26 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
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

		arg_44_1:InitPlayNodeList()
	end,
	Play319351011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 319351011
		arg_48_1.duration_ = 6.8

		local var_48_0 = {
			zh = 6.266,
			ja = 6.8
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
				arg_48_0:Play319351012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["10058ui_story"]
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect10058ui_story == nil then
				arg_48_1.var_.characterEffect10058ui_story = var_51_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_2 = 0.200000002980232

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 and not isNil(var_51_0) then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2

				if arg_48_1.var_.characterEffect10058ui_story and not isNil(var_51_0) then
					arg_48_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect10058ui_story then
				arg_48_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_51_4 = arg_48_1.actors_["1084ui_story"]
			local var_51_5 = 0

			if var_51_5 < arg_48_1.time_ and arg_48_1.time_ <= var_51_5 + arg_51_0 and not isNil(var_51_4) and arg_48_1.var_.characterEffect1084ui_story == nil then
				arg_48_1.var_.characterEffect1084ui_story = var_51_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_6 = 0.200000002980232

			if var_51_5 <= arg_48_1.time_ and arg_48_1.time_ < var_51_5 + var_51_6 and not isNil(var_51_4) then
				local var_51_7 = (arg_48_1.time_ - var_51_5) / var_51_6

				if arg_48_1.var_.characterEffect1084ui_story and not isNil(var_51_4) then
					local var_51_8 = Mathf.Lerp(0, 0.5, var_51_7)

					arg_48_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1084ui_story.fillRatio = var_51_8
				end
			end

			if arg_48_1.time_ >= var_51_5 + var_51_6 and arg_48_1.time_ < var_51_5 + var_51_6 + arg_51_0 and not isNil(var_51_4) and arg_48_1.var_.characterEffect1084ui_story then
				local var_51_9 = 0.5

				arg_48_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1084ui_story.fillRatio = var_51_9
			end

			local var_51_10 = arg_48_1.actors_["10058ui_story"].transform
			local var_51_11 = 0

			if var_51_11 < arg_48_1.time_ and arg_48_1.time_ <= var_51_11 + arg_51_0 then
				arg_48_1.var_.moveOldPos10058ui_story = var_51_10.localPosition
			end

			local var_51_12 = 0.001

			if var_51_11 <= arg_48_1.time_ and arg_48_1.time_ < var_51_11 + var_51_12 then
				local var_51_13 = (arg_48_1.time_ - var_51_11) / var_51_12
				local var_51_14 = Vector3.New(0.7, -0.98, -6.1)

				var_51_10.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos10058ui_story, var_51_14, var_51_13)

				local var_51_15 = manager.ui.mainCamera.transform.position - var_51_10.position

				var_51_10.forward = Vector3.New(var_51_15.x, var_51_15.y, var_51_15.z)

				local var_51_16 = var_51_10.localEulerAngles

				var_51_16.z = 0
				var_51_16.x = 0
				var_51_10.localEulerAngles = var_51_16
			end

			if arg_48_1.time_ >= var_51_11 + var_51_12 and arg_48_1.time_ < var_51_11 + var_51_12 + arg_51_0 then
				var_51_10.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_51_17 = manager.ui.mainCamera.transform.position - var_51_10.position

				var_51_10.forward = Vector3.New(var_51_17.x, var_51_17.y, var_51_17.z)

				local var_51_18 = var_51_10.localEulerAngles

				var_51_18.z = 0
				var_51_18.x = 0
				var_51_10.localEulerAngles = var_51_18
			end

			local var_51_19 = arg_48_1.actors_["1084ui_story"].transform
			local var_51_20 = 0

			if var_51_20 < arg_48_1.time_ and arg_48_1.time_ <= var_51_20 + arg_51_0 then
				arg_48_1.var_.moveOldPos1084ui_story = var_51_19.localPosition
			end

			local var_51_21 = 0.001

			if var_51_20 <= arg_48_1.time_ and arg_48_1.time_ < var_51_20 + var_51_21 then
				local var_51_22 = (arg_48_1.time_ - var_51_20) / var_51_21
				local var_51_23 = Vector3.New(-0.7, -0.97, -6)

				var_51_19.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1084ui_story, var_51_23, var_51_22)

				local var_51_24 = manager.ui.mainCamera.transform.position - var_51_19.position

				var_51_19.forward = Vector3.New(var_51_24.x, var_51_24.y, var_51_24.z)

				local var_51_25 = var_51_19.localEulerAngles

				var_51_25.z = 0
				var_51_25.x = 0
				var_51_19.localEulerAngles = var_51_25
			end

			if arg_48_1.time_ >= var_51_20 + var_51_21 and arg_48_1.time_ < var_51_20 + var_51_21 + arg_51_0 then
				var_51_19.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_51_26 = manager.ui.mainCamera.transform.position - var_51_19.position

				var_51_19.forward = Vector3.New(var_51_26.x, var_51_26.y, var_51_26.z)

				local var_51_27 = var_51_19.localEulerAngles

				var_51_27.z = 0
				var_51_27.x = 0
				var_51_19.localEulerAngles = var_51_27
			end

			local var_51_28 = 0

			if var_51_28 < arg_48_1.time_ and arg_48_1.time_ <= var_51_28 + arg_51_0 then
				arg_48_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_51_29 = 0
			local var_51_30 = 0.85

			if var_51_29 < arg_48_1.time_ and arg_48_1.time_ <= var_51_29 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_31 = arg_48_1:FormatText(StoryNameCfg[471].name)

				arg_48_1.leftNameTxt_.text = var_51_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_32 = arg_48_1:GetWordFromCfg(319351011)
				local var_51_33 = arg_48_1:FormatText(var_51_32.content)

				arg_48_1.text_.text = var_51_33

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_34 = 34
				local var_51_35 = utf8.len(var_51_33)
				local var_51_36 = var_51_34 <= 0 and var_51_30 or var_51_30 * (var_51_35 / var_51_34)

				if var_51_36 > 0 and var_51_30 < var_51_36 then
					arg_48_1.talkMaxDuration = var_51_36

					if var_51_36 + var_51_29 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_36 + var_51_29
					end
				end

				arg_48_1.text_.text = var_51_33
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319351", "319351011", "story_v_out_319351.awb") ~= 0 then
					local var_51_37 = manager.audio:GetVoiceLength("story_v_out_319351", "319351011", "story_v_out_319351.awb") / 1000

					if var_51_37 + var_51_29 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_37 + var_51_29
					end

					if var_51_32.prefab_name ~= "" and arg_48_1.actors_[var_51_32.prefab_name] ~= nil then
						local var_51_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_32.prefab_name].transform, "story_v_out_319351", "319351011", "story_v_out_319351.awb")

						arg_48_1:RecordAudio("319351011", var_51_38)
						arg_48_1:RecordAudio("319351011", var_51_38)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_319351", "319351011", "story_v_out_319351.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_319351", "319351011", "story_v_out_319351.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_39 = math.max(var_51_30, arg_48_1.talkMaxDuration)

			if var_51_29 <= arg_48_1.time_ and arg_48_1.time_ < var_51_29 + var_51_39 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_29) / var_51_39

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_29 + var_51_39 and arg_48_1.time_ < var_51_29 + var_51_39 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
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
			}
		}

		arg_48_1:InitPlayNodeList()
	end,
	Play319351012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 319351012
		arg_52_1.duration_ = 8

		local var_52_0 = {
			zh = 6,
			ja = 8
		}
		local var_52_1 = manager.audio:GetLocalizationFlag()

		if var_52_0[var_52_1] ~= nil then
			arg_52_1.duration_ = var_52_0[var_52_1]
		end

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play319351013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["10058ui_story"]
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect10058ui_story == nil then
				arg_52_1.var_.characterEffect10058ui_story = var_55_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_2 = 0.200000002980232

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 and not isNil(var_55_0) then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2

				if arg_52_1.var_.characterEffect10058ui_story and not isNil(var_55_0) then
					local var_55_4 = Mathf.Lerp(0, 0.5, var_55_3)

					arg_52_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_52_1.var_.characterEffect10058ui_story.fillRatio = var_55_4
				end
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect10058ui_story then
				local var_55_5 = 0.5

				arg_52_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_52_1.var_.characterEffect10058ui_story.fillRatio = var_55_5
			end

			local var_55_6 = arg_52_1.actors_["1084ui_story"]
			local var_55_7 = 0

			if var_55_7 < arg_52_1.time_ and arg_52_1.time_ <= var_55_7 + arg_55_0 and not isNil(var_55_6) and arg_52_1.var_.characterEffect1084ui_story == nil then
				arg_52_1.var_.characterEffect1084ui_story = var_55_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_8 = 0.200000002980232

			if var_55_7 <= arg_52_1.time_ and arg_52_1.time_ < var_55_7 + var_55_8 and not isNil(var_55_6) then
				local var_55_9 = (arg_52_1.time_ - var_55_7) / var_55_8

				if arg_52_1.var_.characterEffect1084ui_story and not isNil(var_55_6) then
					arg_52_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= var_55_7 + var_55_8 and arg_52_1.time_ < var_55_7 + var_55_8 + arg_55_0 and not isNil(var_55_6) and arg_52_1.var_.characterEffect1084ui_story then
				arg_52_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_55_10 = 0

			if var_55_10 < arg_52_1.time_ and arg_52_1.time_ <= var_55_10 + arg_55_0 then
				arg_52_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2202cva")
			end

			local var_55_11 = 0
			local var_55_12 = 0.6

			if var_55_11 < arg_52_1.time_ and arg_52_1.time_ <= var_55_11 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_13 = arg_52_1:FormatText(StoryNameCfg[6].name)

				arg_52_1.leftNameTxt_.text = var_55_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_14 = arg_52_1:GetWordFromCfg(319351012)
				local var_55_15 = arg_52_1:FormatText(var_55_14.content)

				arg_52_1.text_.text = var_55_15

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_16 = 24
				local var_55_17 = utf8.len(var_55_15)
				local var_55_18 = var_55_16 <= 0 and var_55_12 or var_55_12 * (var_55_17 / var_55_16)

				if var_55_18 > 0 and var_55_12 < var_55_18 then
					arg_52_1.talkMaxDuration = var_55_18

					if var_55_18 + var_55_11 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_18 + var_55_11
					end
				end

				arg_52_1.text_.text = var_55_15
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319351", "319351012", "story_v_out_319351.awb") ~= 0 then
					local var_55_19 = manager.audio:GetVoiceLength("story_v_out_319351", "319351012", "story_v_out_319351.awb") / 1000

					if var_55_19 + var_55_11 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_19 + var_55_11
					end

					if var_55_14.prefab_name ~= "" and arg_52_1.actors_[var_55_14.prefab_name] ~= nil then
						local var_55_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_14.prefab_name].transform, "story_v_out_319351", "319351012", "story_v_out_319351.awb")

						arg_52_1:RecordAudio("319351012", var_55_20)
						arg_52_1:RecordAudio("319351012", var_55_20)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_319351", "319351012", "story_v_out_319351.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_319351", "319351012", "story_v_out_319351.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_21 = math.max(var_55_12, arg_52_1.talkMaxDuration)

			if var_55_11 <= arg_52_1.time_ and arg_52_1.time_ < var_55_11 + var_55_21 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_11) / var_55_21

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_11 + var_55_21 and arg_52_1.time_ < var_55_11 + var_55_21 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play319351013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 319351013
		arg_56_1.duration_ = 13.17

		local var_56_0 = {
			zh = 5.733,
			ja = 13.166
		}
		local var_56_1 = manager.audio:GetLocalizationFlag()

		if var_56_0[var_56_1] ~= nil then
			arg_56_1.duration_ = var_56_0[var_56_1]
		end

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play319351014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["10058ui_story"]
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect10058ui_story == nil then
				arg_56_1.var_.characterEffect10058ui_story = var_59_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_2 = 0.200000002980232

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 and not isNil(var_59_0) then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2

				if arg_56_1.var_.characterEffect10058ui_story and not isNil(var_59_0) then
					arg_56_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect10058ui_story then
				arg_56_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_59_4 = arg_56_1.actors_["1084ui_story"]
			local var_59_5 = 0

			if var_59_5 < arg_56_1.time_ and arg_56_1.time_ <= var_59_5 + arg_59_0 and not isNil(var_59_4) and arg_56_1.var_.characterEffect1084ui_story == nil then
				arg_56_1.var_.characterEffect1084ui_story = var_59_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_6 = 0.200000002980232

			if var_59_5 <= arg_56_1.time_ and arg_56_1.time_ < var_59_5 + var_59_6 and not isNil(var_59_4) then
				local var_59_7 = (arg_56_1.time_ - var_59_5) / var_59_6

				if arg_56_1.var_.characterEffect1084ui_story and not isNil(var_59_4) then
					local var_59_8 = Mathf.Lerp(0, 0.5, var_59_7)

					arg_56_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_56_1.var_.characterEffect1084ui_story.fillRatio = var_59_8
				end
			end

			if arg_56_1.time_ >= var_59_5 + var_59_6 and arg_56_1.time_ < var_59_5 + var_59_6 + arg_59_0 and not isNil(var_59_4) and arg_56_1.var_.characterEffect1084ui_story then
				local var_59_9 = 0.5

				arg_56_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_56_1.var_.characterEffect1084ui_story.fillRatio = var_59_9
			end

			local var_59_10 = 0

			if var_59_10 < arg_56_1.time_ and arg_56_1.time_ <= var_59_10 + arg_59_0 then
				arg_56_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			local var_59_11 = 0

			if var_59_11 < arg_56_1.time_ and arg_56_1.time_ <= var_59_11 + arg_59_0 then
				arg_56_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_59_12 = 0
			local var_59_13 = 0.675

			if var_59_12 < arg_56_1.time_ and arg_56_1.time_ <= var_59_12 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_14 = arg_56_1:FormatText(StoryNameCfg[471].name)

				arg_56_1.leftNameTxt_.text = var_59_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_15 = arg_56_1:GetWordFromCfg(319351013)
				local var_59_16 = arg_56_1:FormatText(var_59_15.content)

				arg_56_1.text_.text = var_59_16

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_17 = 27
				local var_59_18 = utf8.len(var_59_16)
				local var_59_19 = var_59_17 <= 0 and var_59_13 or var_59_13 * (var_59_18 / var_59_17)

				if var_59_19 > 0 and var_59_13 < var_59_19 then
					arg_56_1.talkMaxDuration = var_59_19

					if var_59_19 + var_59_12 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_19 + var_59_12
					end
				end

				arg_56_1.text_.text = var_59_16
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319351", "319351013", "story_v_out_319351.awb") ~= 0 then
					local var_59_20 = manager.audio:GetVoiceLength("story_v_out_319351", "319351013", "story_v_out_319351.awb") / 1000

					if var_59_20 + var_59_12 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_20 + var_59_12
					end

					if var_59_15.prefab_name ~= "" and arg_56_1.actors_[var_59_15.prefab_name] ~= nil then
						local var_59_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_15.prefab_name].transform, "story_v_out_319351", "319351013", "story_v_out_319351.awb")

						arg_56_1:RecordAudio("319351013", var_59_21)
						arg_56_1:RecordAudio("319351013", var_59_21)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_319351", "319351013", "story_v_out_319351.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_319351", "319351013", "story_v_out_319351.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_22 = math.max(var_59_13, arg_56_1.talkMaxDuration)

			if var_59_12 <= arg_56_1.time_ and arg_56_1.time_ < var_59_12 + var_59_22 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_12) / var_59_22

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_12 + var_59_22 and arg_56_1.time_ < var_59_12 + var_59_22 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play319351014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 319351014
		arg_60_1.duration_ = 15.03

		local var_60_0 = {
			zh = 6.333,
			ja = 15.033
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
				arg_60_0:Play319351015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["10058ui_story"].transform
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 then
				arg_60_1.var_.moveOldPos10058ui_story = var_63_0.localPosition
			end

			local var_63_2 = 0.001

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_2 then
				local var_63_3 = (arg_60_1.time_ - var_63_1) / var_63_2
				local var_63_4 = Vector3.New(0.7, -0.98, -6.1)

				var_63_0.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos10058ui_story, var_63_4, var_63_3)

				local var_63_5 = manager.ui.mainCamera.transform.position - var_63_0.position

				var_63_0.forward = Vector3.New(var_63_5.x, var_63_5.y, var_63_5.z)

				local var_63_6 = var_63_0.localEulerAngles

				var_63_6.z = 0
				var_63_6.x = 0
				var_63_0.localEulerAngles = var_63_6
			end

			if arg_60_1.time_ >= var_63_1 + var_63_2 and arg_60_1.time_ < var_63_1 + var_63_2 + arg_63_0 then
				var_63_0.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_63_7 = manager.ui.mainCamera.transform.position - var_63_0.position

				var_63_0.forward = Vector3.New(var_63_7.x, var_63_7.y, var_63_7.z)

				local var_63_8 = var_63_0.localEulerAngles

				var_63_8.z = 0
				var_63_8.x = 0
				var_63_0.localEulerAngles = var_63_8
			end

			local var_63_9 = arg_60_1.actors_["10058ui_story"]
			local var_63_10 = 0

			if var_63_10 < arg_60_1.time_ and arg_60_1.time_ <= var_63_10 + arg_63_0 and not isNil(var_63_9) and arg_60_1.var_.characterEffect10058ui_story == nil then
				arg_60_1.var_.characterEffect10058ui_story = var_63_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_11 = 0.200000002980232

			if var_63_10 <= arg_60_1.time_ and arg_60_1.time_ < var_63_10 + var_63_11 and not isNil(var_63_9) then
				local var_63_12 = (arg_60_1.time_ - var_63_10) / var_63_11

				if arg_60_1.var_.characterEffect10058ui_story and not isNil(var_63_9) then
					arg_60_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= var_63_10 + var_63_11 and arg_60_1.time_ < var_63_10 + var_63_11 + arg_63_0 and not isNil(var_63_9) and arg_60_1.var_.characterEffect10058ui_story then
				arg_60_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_63_13 = 0
			local var_63_14 = 0.7

			if var_63_13 < arg_60_1.time_ and arg_60_1.time_ <= var_63_13 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_15 = arg_60_1:FormatText(StoryNameCfg[471].name)

				arg_60_1.leftNameTxt_.text = var_63_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_16 = arg_60_1:GetWordFromCfg(319351014)
				local var_63_17 = arg_60_1:FormatText(var_63_16.content)

				arg_60_1.text_.text = var_63_17

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_18 = 28
				local var_63_19 = utf8.len(var_63_17)
				local var_63_20 = var_63_18 <= 0 and var_63_14 or var_63_14 * (var_63_19 / var_63_18)

				if var_63_20 > 0 and var_63_14 < var_63_20 then
					arg_60_1.talkMaxDuration = var_63_20

					if var_63_20 + var_63_13 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_20 + var_63_13
					end
				end

				arg_60_1.text_.text = var_63_17
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319351", "319351014", "story_v_out_319351.awb") ~= 0 then
					local var_63_21 = manager.audio:GetVoiceLength("story_v_out_319351", "319351014", "story_v_out_319351.awb") / 1000

					if var_63_21 + var_63_13 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_21 + var_63_13
					end

					if var_63_16.prefab_name ~= "" and arg_60_1.actors_[var_63_16.prefab_name] ~= nil then
						local var_63_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_16.prefab_name].transform, "story_v_out_319351", "319351014", "story_v_out_319351.awb")

						arg_60_1:RecordAudio("319351014", var_63_22)
						arg_60_1:RecordAudio("319351014", var_63_22)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_319351", "319351014", "story_v_out_319351.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_319351", "319351014", "story_v_out_319351.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_23 = math.max(var_63_14, arg_60_1.talkMaxDuration)

			if var_63_13 <= arg_60_1.time_ and arg_60_1.time_ < var_63_13 + var_63_23 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_13) / var_63_23

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_13 + var_63_23 and arg_60_1.time_ < var_63_13 + var_63_23 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
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

		arg_60_1:InitPlayNodeList()
	end,
	Play319351015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 319351015
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play319351016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["10058ui_story"]
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect10058ui_story == nil then
				arg_64_1.var_.characterEffect10058ui_story = var_67_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_2 = 0.200000002980232

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 and not isNil(var_67_0) then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2

				if arg_64_1.var_.characterEffect10058ui_story and not isNil(var_67_0) then
					local var_67_4 = Mathf.Lerp(0, 0.5, var_67_3)

					arg_64_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_64_1.var_.characterEffect10058ui_story.fillRatio = var_67_4
				end
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect10058ui_story then
				local var_67_5 = 0.5

				arg_64_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_64_1.var_.characterEffect10058ui_story.fillRatio = var_67_5
			end

			local var_67_6 = 0
			local var_67_7 = 1

			if var_67_6 < arg_64_1.time_ and arg_64_1.time_ <= var_67_6 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, false)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_8 = arg_64_1:GetWordFromCfg(319351015)
				local var_67_9 = arg_64_1:FormatText(var_67_8.content)

				arg_64_1.text_.text = var_67_9

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_10 = 40
				local var_67_11 = utf8.len(var_67_9)
				local var_67_12 = var_67_10 <= 0 and var_67_7 or var_67_7 * (var_67_11 / var_67_10)

				if var_67_12 > 0 and var_67_7 < var_67_12 then
					arg_64_1.talkMaxDuration = var_67_12

					if var_67_12 + var_67_6 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_12 + var_67_6
					end
				end

				arg_64_1.text_.text = var_67_9
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_13 = math.max(var_67_7, arg_64_1.talkMaxDuration)

			if var_67_6 <= arg_64_1.time_ and arg_64_1.time_ < var_67_6 + var_67_13 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_6) / var_67_13

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_6 + var_67_13 and arg_64_1.time_ < var_67_6 + var_67_13 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play319351016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 319351016
		arg_68_1.duration_ = 5.63

		local var_68_0 = {
			zh = 5.39933333333333,
			ja = 5.63333333333333
		}
		local var_68_1 = manager.audio:GetLocalizationFlag()

		if var_68_0[var_68_1] ~= nil then
			arg_68_1.duration_ = var_68_0[var_68_1]
		end

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play319351017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["10058ui_story"]
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect10058ui_story == nil then
				arg_68_1.var_.characterEffect10058ui_story = var_71_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_2 = 0.200000002980232

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 and not isNil(var_71_0) then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2

				if arg_68_1.var_.characterEffect10058ui_story and not isNil(var_71_0) then
					arg_68_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect10058ui_story then
				arg_68_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_71_4 = 1.36666666666667

			if var_71_4 < arg_68_1.time_ and arg_68_1.time_ <= var_71_4 + arg_71_0 then
				local var_71_5 = manager.ui.mainCamera.transform.localPosition
				local var_71_6 = Vector3.New(0, 0, 10) + Vector3.New(var_71_5.x, var_71_5.y, 0)
				local var_71_7 = arg_68_1.bgs_.STblack

				var_71_7.transform.localPosition = var_71_6
				var_71_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_71_8 = var_71_7:GetComponent("SpriteRenderer")

				if var_71_8 and var_71_8.sprite then
					local var_71_9 = (var_71_7.transform.localPosition - var_71_5).z
					local var_71_10 = manager.ui.mainCameraCom_
					local var_71_11 = 2 * var_71_9 * Mathf.Tan(var_71_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_71_12 = var_71_11 * var_71_10.aspect
					local var_71_13 = var_71_8.sprite.bounds.size.x
					local var_71_14 = var_71_8.sprite.bounds.size.y
					local var_71_15 = var_71_12 / var_71_13
					local var_71_16 = var_71_11 / var_71_14
					local var_71_17 = var_71_16 < var_71_15 and var_71_15 or var_71_16

					var_71_7.transform.localScale = Vector3.New(var_71_17, var_71_17, 0)
				end

				for iter_71_0, iter_71_1 in pairs(arg_68_1.bgs_) do
					if iter_71_0 ~= "STblack" then
						iter_71_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_71_18 = 0

			if var_71_18 < arg_68_1.time_ and arg_68_1.time_ <= var_71_18 + arg_71_0 then
				arg_68_1.mask_.enabled = true
				arg_68_1.mask_.raycastTarget = true

				arg_68_1:SetGaussion(false)
			end

			local var_71_19 = 1.36666666666667

			if var_71_18 <= arg_68_1.time_ and arg_68_1.time_ < var_71_18 + var_71_19 then
				local var_71_20 = (arg_68_1.time_ - var_71_18) / var_71_19
				local var_71_21 = Color.New(0, 0, 0)

				var_71_21.a = Mathf.Lerp(0, 1, var_71_20)
				arg_68_1.mask_.color = var_71_21
			end

			if arg_68_1.time_ >= var_71_18 + var_71_19 and arg_68_1.time_ < var_71_18 + var_71_19 + arg_71_0 then
				local var_71_22 = Color.New(0, 0, 0)

				var_71_22.a = 1
				arg_68_1.mask_.color = var_71_22
			end

			local var_71_23 = 1.36666666666667

			if var_71_23 < arg_68_1.time_ and arg_68_1.time_ <= var_71_23 + arg_71_0 then
				arg_68_1.mask_.enabled = true
				arg_68_1.mask_.raycastTarget = true

				arg_68_1:SetGaussion(false)
			end

			local var_71_24 = 2

			if var_71_23 <= arg_68_1.time_ and arg_68_1.time_ < var_71_23 + var_71_24 then
				local var_71_25 = (arg_68_1.time_ - var_71_23) / var_71_24
				local var_71_26 = Color.New(0, 0, 0)

				var_71_26.a = Mathf.Lerp(1, 0, var_71_25)
				arg_68_1.mask_.color = var_71_26
			end

			if arg_68_1.time_ >= var_71_23 + var_71_24 and arg_68_1.time_ < var_71_23 + var_71_24 + arg_71_0 then
				local var_71_27 = Color.New(0, 0, 0)
				local var_71_28 = 0

				arg_68_1.mask_.enabled = false
				var_71_27.a = var_71_28
				arg_68_1.mask_.color = var_71_27
			end

			local var_71_29 = arg_68_1.actors_["10058ui_story"].transform
			local var_71_30 = 1.36666666666667

			if var_71_30 < arg_68_1.time_ and arg_68_1.time_ <= var_71_30 + arg_71_0 then
				arg_68_1.var_.moveOldPos10058ui_story = var_71_29.localPosition
			end

			local var_71_31 = 0.001

			if var_71_30 <= arg_68_1.time_ and arg_68_1.time_ < var_71_30 + var_71_31 then
				local var_71_32 = (arg_68_1.time_ - var_71_30) / var_71_31
				local var_71_33 = Vector3.New(0, 100, 0)

				var_71_29.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos10058ui_story, var_71_33, var_71_32)

				local var_71_34 = manager.ui.mainCamera.transform.position - var_71_29.position

				var_71_29.forward = Vector3.New(var_71_34.x, var_71_34.y, var_71_34.z)

				local var_71_35 = var_71_29.localEulerAngles

				var_71_35.z = 0
				var_71_35.x = 0
				var_71_29.localEulerAngles = var_71_35
			end

			if arg_68_1.time_ >= var_71_30 + var_71_31 and arg_68_1.time_ < var_71_30 + var_71_31 + arg_71_0 then
				var_71_29.localPosition = Vector3.New(0, 100, 0)

				local var_71_36 = manager.ui.mainCamera.transform.position - var_71_29.position

				var_71_29.forward = Vector3.New(var_71_36.x, var_71_36.y, var_71_36.z)

				local var_71_37 = var_71_29.localEulerAngles

				var_71_37.z = 0
				var_71_37.x = 0
				var_71_29.localEulerAngles = var_71_37
			end

			local var_71_38 = arg_68_1.actors_["1084ui_story"].transform
			local var_71_39 = 1.36666666666667

			if var_71_39 < arg_68_1.time_ and arg_68_1.time_ <= var_71_39 + arg_71_0 then
				arg_68_1.var_.moveOldPos1084ui_story = var_71_38.localPosition
			end

			local var_71_40 = 0.001

			if var_71_39 <= arg_68_1.time_ and arg_68_1.time_ < var_71_39 + var_71_40 then
				local var_71_41 = (arg_68_1.time_ - var_71_39) / var_71_40
				local var_71_42 = Vector3.New(0, 100, 0)

				var_71_38.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1084ui_story, var_71_42, var_71_41)

				local var_71_43 = manager.ui.mainCamera.transform.position - var_71_38.position

				var_71_38.forward = Vector3.New(var_71_43.x, var_71_43.y, var_71_43.z)

				local var_71_44 = var_71_38.localEulerAngles

				var_71_44.z = 0
				var_71_44.x = 0
				var_71_38.localEulerAngles = var_71_44
			end

			if arg_68_1.time_ >= var_71_39 + var_71_40 and arg_68_1.time_ < var_71_39 + var_71_40 + arg_71_0 then
				var_71_38.localPosition = Vector3.New(0, 100, 0)

				local var_71_45 = manager.ui.mainCamera.transform.position - var_71_38.position

				var_71_38.forward = Vector3.New(var_71_45.x, var_71_45.y, var_71_45.z)

				local var_71_46 = var_71_38.localEulerAngles

				var_71_46.z = 0
				var_71_46.x = 0
				var_71_38.localEulerAngles = var_71_46
			end

			if arg_68_1.frameCnt_ <= 1 then
				arg_68_1.dialog_:SetActive(false)
			end

			local var_71_47 = 2.43333333333333
			local var_71_48 = 0.25

			if var_71_47 < arg_68_1.time_ and arg_68_1.time_ <= var_71_47 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0

				arg_68_1.dialog_:SetActive(true)

				arg_68_1.dialogCg_.alpha = 0

				local var_71_49 = LeanTween.value(arg_68_1.dialog_, 0, 1, 0.3)

				var_71_49:setOnUpdate(LuaHelper.FloatAction(function(arg_72_0)
					arg_68_1.dialogCg_.alpha = arg_72_0
				end))
				var_71_49:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_68_1.dialog_)
					var_71_49:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_68_1.duration_ = arg_68_1.duration_ + 0.3

				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_50 = arg_68_1:FormatText(StoryNameCfg[471].name)

				arg_68_1.leftNameTxt_.text = var_71_50

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, true)
				arg_68_1.iconController_:SetSelectedState("hero")

				arg_68_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10058")

				arg_68_1.callingController_:SetSelectedState("normal")

				arg_68_1.keyicon_.color = Color.New(1, 1, 1)
				arg_68_1.icon_.color = Color.New(1, 1, 1)

				local var_71_51 = arg_68_1:GetWordFromCfg(319351016)
				local var_71_52 = arg_68_1:FormatText(var_71_51.content)

				arg_68_1.text_.text = var_71_52

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_53 = 10
				local var_71_54 = utf8.len(var_71_52)
				local var_71_55 = var_71_53 <= 0 and var_71_48 or var_71_48 * (var_71_54 / var_71_53)

				if var_71_55 > 0 and var_71_48 < var_71_55 then
					arg_68_1.talkMaxDuration = var_71_55
					var_71_47 = var_71_47 + 0.3

					if var_71_55 + var_71_47 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_55 + var_71_47
					end
				end

				arg_68_1.text_.text = var_71_52
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319351", "319351016", "story_v_out_319351.awb") ~= 0 then
					local var_71_56 = manager.audio:GetVoiceLength("story_v_out_319351", "319351016", "story_v_out_319351.awb") / 1000

					if var_71_56 + var_71_47 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_56 + var_71_47
					end

					if var_71_51.prefab_name ~= "" and arg_68_1.actors_[var_71_51.prefab_name] ~= nil then
						local var_71_57 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_51.prefab_name].transform, "story_v_out_319351", "319351016", "story_v_out_319351.awb")

						arg_68_1:RecordAudio("319351016", var_71_57)
						arg_68_1:RecordAudio("319351016", var_71_57)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_319351", "319351016", "story_v_out_319351.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_319351", "319351016", "story_v_out_319351.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_58 = var_71_47 + 0.3
			local var_71_59 = math.max(var_71_48, arg_68_1.talkMaxDuration)

			if var_71_58 <= arg_68_1.time_ and arg_68_1.time_ < var_71_58 + var_71_59 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_58) / var_71_59

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_58 + var_71_59 and arg_68_1.time_ < var_71_58 + var_71_59 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.36666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.36666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_68_1:InitPlayNodeList()
	end,
	Play319351017 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 319351017
		arg_74_1.duration_ = 11.1

		local var_74_0 = {
			zh = 8,
			ja = 11.1
		}
		local var_74_1 = manager.audio:GetLocalizationFlag()

		if var_74_0[var_74_1] ~= nil then
			arg_74_1.duration_ = var_74_0[var_74_1]
		end

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play319351018(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0
			local var_77_1 = 0.6

			if var_77_0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_2 = arg_74_1:FormatText(StoryNameCfg[696].name)

				arg_74_1.leftNameTxt_.text = var_77_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, true)
				arg_74_1.iconController_:SetSelectedState("hero")

				arg_74_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_74_1.callingController_:SetSelectedState("normal")

				arg_74_1.keyicon_.color = Color.New(1, 1, 1)
				arg_74_1.icon_.color = Color.New(1, 1, 1)

				local var_77_3 = arg_74_1:GetWordFromCfg(319351017)
				local var_77_4 = arg_74_1:FormatText(var_77_3.content)

				arg_74_1.text_.text = var_77_4

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_5 = 24
				local var_77_6 = utf8.len(var_77_4)
				local var_77_7 = var_77_5 <= 0 and var_77_1 or var_77_1 * (var_77_6 / var_77_5)

				if var_77_7 > 0 and var_77_1 < var_77_7 then
					arg_74_1.talkMaxDuration = var_77_7

					if var_77_7 + var_77_0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_7 + var_77_0
					end
				end

				arg_74_1.text_.text = var_77_4
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319351", "319351017", "story_v_out_319351.awb") ~= 0 then
					local var_77_8 = manager.audio:GetVoiceLength("story_v_out_319351", "319351017", "story_v_out_319351.awb") / 1000

					if var_77_8 + var_77_0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_8 + var_77_0
					end

					if var_77_3.prefab_name ~= "" and arg_74_1.actors_[var_77_3.prefab_name] ~= nil then
						local var_77_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_3.prefab_name].transform, "story_v_out_319351", "319351017", "story_v_out_319351.awb")

						arg_74_1:RecordAudio("319351017", var_77_9)
						arg_74_1:RecordAudio("319351017", var_77_9)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_319351", "319351017", "story_v_out_319351.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_319351", "319351017", "story_v_out_319351.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_10 = math.max(var_77_1, arg_74_1.talkMaxDuration)

			if var_77_0 <= arg_74_1.time_ and arg_74_1.time_ < var_77_0 + var_77_10 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_0) / var_77_10

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_0 + var_77_10 and arg_74_1.time_ < var_77_0 + var_77_10 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play319351018 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 319351018
		arg_78_1.duration_ = 3.13

		local var_78_0 = {
			zh = 3.033,
			ja = 3.133
		}
		local var_78_1 = manager.audio:GetLocalizationFlag()

		if var_78_0[var_78_1] ~= nil then
			arg_78_1.duration_ = var_78_0[var_78_1]
		end

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play319351019(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = arg_78_1.actors_["10058ui_story"]
			local var_81_1 = 0

			if var_81_1 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.characterEffect10058ui_story == nil then
				arg_78_1.var_.characterEffect10058ui_story = var_81_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_2 = 0.200000002980232

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_2 and not isNil(var_81_0) then
				local var_81_3 = (arg_78_1.time_ - var_81_1) / var_81_2

				if arg_78_1.var_.characterEffect10058ui_story and not isNil(var_81_0) then
					arg_78_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_78_1.time_ >= var_81_1 + var_81_2 and arg_78_1.time_ < var_81_1 + var_81_2 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.characterEffect10058ui_story then
				arg_78_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_81_4 = arg_78_1.actors_["1084ui_story"]
			local var_81_5 = 0

			if var_81_5 < arg_78_1.time_ and arg_78_1.time_ <= var_81_5 + arg_81_0 and not isNil(var_81_4) and arg_78_1.var_.characterEffect1084ui_story == nil then
				arg_78_1.var_.characterEffect1084ui_story = var_81_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_6 = 0.200000002980232

			if var_81_5 <= arg_78_1.time_ and arg_78_1.time_ < var_81_5 + var_81_6 and not isNil(var_81_4) then
				local var_81_7 = (arg_78_1.time_ - var_81_5) / var_81_6

				if arg_78_1.var_.characterEffect1084ui_story and not isNil(var_81_4) then
					local var_81_8 = Mathf.Lerp(0, 0.5, var_81_7)

					arg_78_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_78_1.var_.characterEffect1084ui_story.fillRatio = var_81_8
				end
			end

			if arg_78_1.time_ >= var_81_5 + var_81_6 and arg_78_1.time_ < var_81_5 + var_81_6 + arg_81_0 and not isNil(var_81_4) and arg_78_1.var_.characterEffect1084ui_story then
				local var_81_9 = 0.5

				arg_78_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_78_1.var_.characterEffect1084ui_story.fillRatio = var_81_9
			end

			local var_81_10 = 0
			local var_81_11 = 0.25

			if var_81_10 < arg_78_1.time_ and arg_78_1.time_ <= var_81_10 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_12 = arg_78_1:FormatText(StoryNameCfg[471].name)

				arg_78_1.leftNameTxt_.text = var_81_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, true)
				arg_78_1.iconController_:SetSelectedState("hero")

				arg_78_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10058")

				arg_78_1.callingController_:SetSelectedState("normal")

				arg_78_1.keyicon_.color = Color.New(1, 1, 1)
				arg_78_1.icon_.color = Color.New(1, 1, 1)

				local var_81_13 = arg_78_1:GetWordFromCfg(319351018)
				local var_81_14 = arg_78_1:FormatText(var_81_13.content)

				arg_78_1.text_.text = var_81_14

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_15 = 10
				local var_81_16 = utf8.len(var_81_14)
				local var_81_17 = var_81_15 <= 0 and var_81_11 or var_81_11 * (var_81_16 / var_81_15)

				if var_81_17 > 0 and var_81_11 < var_81_17 then
					arg_78_1.talkMaxDuration = var_81_17

					if var_81_17 + var_81_10 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_17 + var_81_10
					end
				end

				arg_78_1.text_.text = var_81_14
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319351", "319351018", "story_v_out_319351.awb") ~= 0 then
					local var_81_18 = manager.audio:GetVoiceLength("story_v_out_319351", "319351018", "story_v_out_319351.awb") / 1000

					if var_81_18 + var_81_10 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_18 + var_81_10
					end

					if var_81_13.prefab_name ~= "" and arg_78_1.actors_[var_81_13.prefab_name] ~= nil then
						local var_81_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_13.prefab_name].transform, "story_v_out_319351", "319351018", "story_v_out_319351.awb")

						arg_78_1:RecordAudio("319351018", var_81_19)
						arg_78_1:RecordAudio("319351018", var_81_19)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_319351", "319351018", "story_v_out_319351.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_319351", "319351018", "story_v_out_319351.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_20 = math.max(var_81_11, arg_78_1.talkMaxDuration)

			if var_81_10 <= arg_78_1.time_ and arg_78_1.time_ < var_81_10 + var_81_20 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_10) / var_81_20

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_10 + var_81_20 and arg_78_1.time_ < var_81_10 + var_81_20 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play319351019 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 319351019
		arg_82_1.duration_ = 9.23

		local var_82_0 = {
			zh = 6.1,
			ja = 9.233
		}
		local var_82_1 = manager.audio:GetLocalizationFlag()

		if var_82_0[var_82_1] ~= nil then
			arg_82_1.duration_ = var_82_0[var_82_1]
		end

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play319351020(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 0
			local var_85_1 = 0.575

			if var_85_0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_0 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_2 = arg_82_1:FormatText(StoryNameCfg[471].name)

				arg_82_1.leftNameTxt_.text = var_85_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, true)
				arg_82_1.iconController_:SetSelectedState("hero")

				arg_82_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10058")

				arg_82_1.callingController_:SetSelectedState("normal")

				arg_82_1.keyicon_.color = Color.New(1, 1, 1)
				arg_82_1.icon_.color = Color.New(1, 1, 1)

				local var_85_3 = arg_82_1:GetWordFromCfg(319351019)
				local var_85_4 = arg_82_1:FormatText(var_85_3.content)

				arg_82_1.text_.text = var_85_4

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_5 = 23
				local var_85_6 = utf8.len(var_85_4)
				local var_85_7 = var_85_5 <= 0 and var_85_1 or var_85_1 * (var_85_6 / var_85_5)

				if var_85_7 > 0 and var_85_1 < var_85_7 then
					arg_82_1.talkMaxDuration = var_85_7

					if var_85_7 + var_85_0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_7 + var_85_0
					end
				end

				arg_82_1.text_.text = var_85_4
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319351", "319351019", "story_v_out_319351.awb") ~= 0 then
					local var_85_8 = manager.audio:GetVoiceLength("story_v_out_319351", "319351019", "story_v_out_319351.awb") / 1000

					if var_85_8 + var_85_0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_8 + var_85_0
					end

					if var_85_3.prefab_name ~= "" and arg_82_1.actors_[var_85_3.prefab_name] ~= nil then
						local var_85_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_3.prefab_name].transform, "story_v_out_319351", "319351019", "story_v_out_319351.awb")

						arg_82_1:RecordAudio("319351019", var_85_9)
						arg_82_1:RecordAudio("319351019", var_85_9)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_319351", "319351019", "story_v_out_319351.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_319351", "319351019", "story_v_out_319351.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_10 = math.max(var_85_1, arg_82_1.talkMaxDuration)

			if var_85_0 <= arg_82_1.time_ and arg_82_1.time_ < var_85_0 + var_85_10 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_0) / var_85_10

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_0 + var_85_10 and arg_82_1.time_ < var_85_0 + var_85_10 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play319351020 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 319351020
		arg_86_1.duration_ = 5

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play319351021(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = 0
			local var_89_1 = 1

			if var_89_0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_0 + arg_89_0 then
				local var_89_2 = "stop"
				local var_89_3 = "effect"

				arg_86_1:AudioAction(var_89_2, var_89_3, "se_story_130", "se_story_130_didi", "")
			end

			local var_89_4 = arg_86_1.actors_["10058ui_story"]
			local var_89_5 = 0

			if var_89_5 < arg_86_1.time_ and arg_86_1.time_ <= var_89_5 + arg_89_0 and not isNil(var_89_4) and arg_86_1.var_.characterEffect10058ui_story == nil then
				arg_86_1.var_.characterEffect10058ui_story = var_89_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_6 = 0.200000002980232

			if var_89_5 <= arg_86_1.time_ and arg_86_1.time_ < var_89_5 + var_89_6 and not isNil(var_89_4) then
				local var_89_7 = (arg_86_1.time_ - var_89_5) / var_89_6

				if arg_86_1.var_.characterEffect10058ui_story and not isNil(var_89_4) then
					local var_89_8 = Mathf.Lerp(0, 0.5, var_89_7)

					arg_86_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_86_1.var_.characterEffect10058ui_story.fillRatio = var_89_8
				end
			end

			if arg_86_1.time_ >= var_89_5 + var_89_6 and arg_86_1.time_ < var_89_5 + var_89_6 + arg_89_0 and not isNil(var_89_4) and arg_86_1.var_.characterEffect10058ui_story then
				local var_89_9 = 0.5

				arg_86_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_86_1.var_.characterEffect10058ui_story.fillRatio = var_89_9
			end

			local var_89_10 = 0
			local var_89_11 = 0.875

			if var_89_10 < arg_86_1.time_ and arg_86_1.time_ <= var_89_10 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, false)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_12 = arg_86_1:GetWordFromCfg(319351020)
				local var_89_13 = arg_86_1:FormatText(var_89_12.content)

				arg_86_1.text_.text = var_89_13

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_14 = 35
				local var_89_15 = utf8.len(var_89_13)
				local var_89_16 = var_89_14 <= 0 and var_89_11 or var_89_11 * (var_89_15 / var_89_14)

				if var_89_16 > 0 and var_89_11 < var_89_16 then
					arg_86_1.talkMaxDuration = var_89_16

					if var_89_16 + var_89_10 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_16 + var_89_10
					end
				end

				arg_86_1.text_.text = var_89_13
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_17 = math.max(var_89_11, arg_86_1.talkMaxDuration)

			if var_89_10 <= arg_86_1.time_ and arg_86_1.time_ < var_89_10 + var_89_17 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_10) / var_89_17

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_10 + var_89_17 and arg_86_1.time_ < var_89_10 + var_89_17 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play319351021 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 319351021
		arg_90_1.duration_ = 13.17

		local var_90_0 = {
			zh = 10.4666666666667,
			ja = 13.1666666666667
		}
		local var_90_1 = manager.audio:GetLocalizationFlag()

		if var_90_0[var_90_1] ~= nil then
			arg_90_1.duration_ = var_90_0[var_90_1]
		end

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play319351022(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = arg_90_1.actors_["10058ui_story"]
			local var_93_1 = 3

			if var_93_1 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.characterEffect10058ui_story == nil then
				arg_90_1.var_.characterEffect10058ui_story = var_93_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_2 = 0.200000002980232

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_2 and not isNil(var_93_0) then
				local var_93_3 = (arg_90_1.time_ - var_93_1) / var_93_2

				if arg_90_1.var_.characterEffect10058ui_story and not isNil(var_93_0) then
					arg_90_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_90_1.time_ >= var_93_1 + var_93_2 and arg_90_1.time_ < var_93_1 + var_93_2 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.characterEffect10058ui_story then
				arg_90_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_93_4 = 3

			if var_93_4 < arg_90_1.time_ and arg_90_1.time_ <= var_93_4 + arg_93_0 then
				arg_90_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_93_5 = 3

			if var_93_5 < arg_90_1.time_ and arg_90_1.time_ <= var_93_5 + arg_93_0 then
				arg_90_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_93_6 = arg_90_1.actors_["10058ui_story"].transform
			local var_93_7 = 3

			if var_93_7 < arg_90_1.time_ and arg_90_1.time_ <= var_93_7 + arg_93_0 then
				arg_90_1.var_.moveOldPos10058ui_story = var_93_6.localPosition
			end

			local var_93_8 = 0.001

			if var_93_7 <= arg_90_1.time_ and arg_90_1.time_ < var_93_7 + var_93_8 then
				local var_93_9 = (arg_90_1.time_ - var_93_7) / var_93_8
				local var_93_10 = Vector3.New(0, -0.98, -6.1)

				var_93_6.localPosition = Vector3.Lerp(arg_90_1.var_.moveOldPos10058ui_story, var_93_10, var_93_9)

				local var_93_11 = manager.ui.mainCamera.transform.position - var_93_6.position

				var_93_6.forward = Vector3.New(var_93_11.x, var_93_11.y, var_93_11.z)

				local var_93_12 = var_93_6.localEulerAngles

				var_93_12.z = 0
				var_93_12.x = 0
				var_93_6.localEulerAngles = var_93_12
			end

			if arg_90_1.time_ >= var_93_7 + var_93_8 and arg_90_1.time_ < var_93_7 + var_93_8 + arg_93_0 then
				var_93_6.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_93_13 = manager.ui.mainCamera.transform.position - var_93_6.position

				var_93_6.forward = Vector3.New(var_93_13.x, var_93_13.y, var_93_13.z)

				local var_93_14 = var_93_6.localEulerAngles

				var_93_14.z = 0
				var_93_14.x = 0
				var_93_6.localEulerAngles = var_93_14
			end

			local var_93_15 = 1

			if var_93_15 < arg_90_1.time_ and arg_90_1.time_ <= var_93_15 + arg_93_0 then
				local var_93_16 = manager.ui.mainCamera.transform.localPosition
				local var_93_17 = Vector3.New(0, 0, 10) + Vector3.New(var_93_16.x, var_93_16.y, 0)
				local var_93_18 = arg_90_1.bgs_.ST74

				var_93_18.transform.localPosition = var_93_17
				var_93_18.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_93_19 = var_93_18:GetComponent("SpriteRenderer")

				if var_93_19 and var_93_19.sprite then
					local var_93_20 = (var_93_18.transform.localPosition - var_93_16).z
					local var_93_21 = manager.ui.mainCameraCom_
					local var_93_22 = 2 * var_93_20 * Mathf.Tan(var_93_21.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_93_23 = var_93_22 * var_93_21.aspect
					local var_93_24 = var_93_19.sprite.bounds.size.x
					local var_93_25 = var_93_19.sprite.bounds.size.y
					local var_93_26 = var_93_23 / var_93_24
					local var_93_27 = var_93_22 / var_93_25
					local var_93_28 = var_93_27 < var_93_26 and var_93_26 or var_93_27

					var_93_18.transform.localScale = Vector3.New(var_93_28, var_93_28, 0)
				end

				for iter_93_0, iter_93_1 in pairs(arg_90_1.bgs_) do
					if iter_93_0 ~= "ST74" then
						iter_93_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_93_29 = 0

			if var_93_29 < arg_90_1.time_ and arg_90_1.time_ <= var_93_29 + arg_93_0 then
				arg_90_1.mask_.enabled = true
				arg_90_1.mask_.raycastTarget = true

				arg_90_1:SetGaussion(false)
			end

			local var_93_30 = 1

			if var_93_29 <= arg_90_1.time_ and arg_90_1.time_ < var_93_29 + var_93_30 then
				local var_93_31 = (arg_90_1.time_ - var_93_29) / var_93_30
				local var_93_32 = Color.New(0, 0, 0)

				var_93_32.a = Mathf.Lerp(0, 1, var_93_31)
				arg_90_1.mask_.color = var_93_32
			end

			if arg_90_1.time_ >= var_93_29 + var_93_30 and arg_90_1.time_ < var_93_29 + var_93_30 + arg_93_0 then
				local var_93_33 = Color.New(0, 0, 0)

				var_93_33.a = 1
				arg_90_1.mask_.color = var_93_33
			end

			local var_93_34 = 1

			if var_93_34 < arg_90_1.time_ and arg_90_1.time_ <= var_93_34 + arg_93_0 then
				arg_90_1.mask_.enabled = true
				arg_90_1.mask_.raycastTarget = true

				arg_90_1:SetGaussion(false)
			end

			local var_93_35 = 2

			if var_93_34 <= arg_90_1.time_ and arg_90_1.time_ < var_93_34 + var_93_35 then
				local var_93_36 = (arg_90_1.time_ - var_93_34) / var_93_35
				local var_93_37 = Color.New(0, 0, 0)

				var_93_37.a = Mathf.Lerp(1, 0, var_93_36)
				arg_90_1.mask_.color = var_93_37
			end

			if arg_90_1.time_ >= var_93_34 + var_93_35 and arg_90_1.time_ < var_93_34 + var_93_35 + arg_93_0 then
				local var_93_38 = Color.New(0, 0, 0)
				local var_93_39 = 0

				arg_90_1.mask_.enabled = false
				var_93_38.a = var_93_39
				arg_90_1.mask_.color = var_93_38
			end

			local var_93_40 = 2.66666666666667
			local var_93_41 = 0.925

			if var_93_40 < arg_90_1.time_ and arg_90_1.time_ <= var_93_40 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_42 = arg_90_1:FormatText(StoryNameCfg[471].name)

				arg_90_1.leftNameTxt_.text = var_93_42

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_43 = arg_90_1:GetWordFromCfg(319351021)
				local var_93_44 = arg_90_1:FormatText(var_93_43.content)

				arg_90_1.text_.text = var_93_44

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_45 = 37
				local var_93_46 = utf8.len(var_93_44)
				local var_93_47 = var_93_45 <= 0 and var_93_41 or var_93_41 * (var_93_46 / var_93_45)

				if var_93_47 > 0 and var_93_41 < var_93_47 then
					arg_90_1.talkMaxDuration = var_93_47

					if var_93_47 + var_93_40 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_47 + var_93_40
					end
				end

				arg_90_1.text_.text = var_93_44
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319351", "319351021", "story_v_out_319351.awb") ~= 0 then
					local var_93_48 = manager.audio:GetVoiceLength("story_v_out_319351", "319351021", "story_v_out_319351.awb") / 1000

					if var_93_48 + var_93_40 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_48 + var_93_40
					end

					if var_93_43.prefab_name ~= "" and arg_90_1.actors_[var_93_43.prefab_name] ~= nil then
						local var_93_49 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_43.prefab_name].transform, "story_v_out_319351", "319351021", "story_v_out_319351.awb")

						arg_90_1:RecordAudio("319351021", var_93_49)
						arg_90_1:RecordAudio("319351021", var_93_49)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_319351", "319351021", "story_v_out_319351.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_319351", "319351021", "story_v_out_319351.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_50 = math.max(var_93_41, arg_90_1.talkMaxDuration)

			if var_93_40 <= arg_90_1.time_ and arg_90_1.time_ < var_93_40 + var_93_50 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_40) / var_93_50

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_40 + var_93_50 and arg_90_1.time_ < var_93_40 + var_93_50 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_90_1:InitPlayNodeList()
	end,
	Play319351022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 319351022
		arg_94_1.duration_ = 13.8

		local var_94_0 = {
			zh = 11.1,
			ja = 13.8
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
				arg_94_0:Play319351023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 0
			local var_97_1 = 1.3

			if var_97_0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_0 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_2 = arg_94_1:FormatText(StoryNameCfg[471].name)

				arg_94_1.leftNameTxt_.text = var_97_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_3 = arg_94_1:GetWordFromCfg(319351022)
				local var_97_4 = arg_94_1:FormatText(var_97_3.content)

				arg_94_1.text_.text = var_97_4

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_5 = 52
				local var_97_6 = utf8.len(var_97_4)
				local var_97_7 = var_97_5 <= 0 and var_97_1 or var_97_1 * (var_97_6 / var_97_5)

				if var_97_7 > 0 and var_97_1 < var_97_7 then
					arg_94_1.talkMaxDuration = var_97_7

					if var_97_7 + var_97_0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_7 + var_97_0
					end
				end

				arg_94_1.text_.text = var_97_4
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319351", "319351022", "story_v_out_319351.awb") ~= 0 then
					local var_97_8 = manager.audio:GetVoiceLength("story_v_out_319351", "319351022", "story_v_out_319351.awb") / 1000

					if var_97_8 + var_97_0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_8 + var_97_0
					end

					if var_97_3.prefab_name ~= "" and arg_94_1.actors_[var_97_3.prefab_name] ~= nil then
						local var_97_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_3.prefab_name].transform, "story_v_out_319351", "319351022", "story_v_out_319351.awb")

						arg_94_1:RecordAudio("319351022", var_97_9)
						arg_94_1:RecordAudio("319351022", var_97_9)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_319351", "319351022", "story_v_out_319351.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_319351", "319351022", "story_v_out_319351.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_10 = math.max(var_97_1, arg_94_1.talkMaxDuration)

			if var_97_0 <= arg_94_1.time_ and arg_94_1.time_ < var_97_0 + var_97_10 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_0) / var_97_10

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_0 + var_97_10 and arg_94_1.time_ < var_97_0 + var_97_10 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play319351023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 319351023
		arg_98_1.duration_ = 9.47

		local var_98_0 = {
			zh = 2.433,
			ja = 9.466
		}
		local var_98_1 = manager.audio:GetLocalizationFlag()

		if var_98_0[var_98_1] ~= nil then
			arg_98_1.duration_ = var_98_0[var_98_1]
		end

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play319351024(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = arg_98_1.actors_["10058ui_story"]
			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect10058ui_story == nil then
				arg_98_1.var_.characterEffect10058ui_story = var_101_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_2 = 0.200000002980232

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_2 and not isNil(var_101_0) then
				local var_101_3 = (arg_98_1.time_ - var_101_1) / var_101_2

				if arg_98_1.var_.characterEffect10058ui_story and not isNil(var_101_0) then
					local var_101_4 = Mathf.Lerp(0, 0.5, var_101_3)

					arg_98_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_98_1.var_.characterEffect10058ui_story.fillRatio = var_101_4
				end
			end

			if arg_98_1.time_ >= var_101_1 + var_101_2 and arg_98_1.time_ < var_101_1 + var_101_2 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect10058ui_story then
				local var_101_5 = 0.5

				arg_98_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_98_1.var_.characterEffect10058ui_story.fillRatio = var_101_5
			end

			local var_101_6 = arg_98_1.actors_["1084ui_story"].transform
			local var_101_7 = 0

			if var_101_7 < arg_98_1.time_ and arg_98_1.time_ <= var_101_7 + arg_101_0 then
				arg_98_1.var_.moveOldPos1084ui_story = var_101_6.localPosition

				local var_101_8 = "1084ui_story"

				arg_98_1:ShowWeapon(arg_98_1.var_[var_101_8 .. "Animator"].transform, false)
			end

			local var_101_9 = 0.001

			if var_101_7 <= arg_98_1.time_ and arg_98_1.time_ < var_101_7 + var_101_9 then
				local var_101_10 = (arg_98_1.time_ - var_101_7) / var_101_9
				local var_101_11 = Vector3.New(-0.7, -0.97, -6)

				var_101_6.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos1084ui_story, var_101_11, var_101_10)

				local var_101_12 = manager.ui.mainCamera.transform.position - var_101_6.position

				var_101_6.forward = Vector3.New(var_101_12.x, var_101_12.y, var_101_12.z)

				local var_101_13 = var_101_6.localEulerAngles

				var_101_13.z = 0
				var_101_13.x = 0
				var_101_6.localEulerAngles = var_101_13
			end

			if arg_98_1.time_ >= var_101_7 + var_101_9 and arg_98_1.time_ < var_101_7 + var_101_9 + arg_101_0 then
				var_101_6.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_101_14 = manager.ui.mainCamera.transform.position - var_101_6.position

				var_101_6.forward = Vector3.New(var_101_14.x, var_101_14.y, var_101_14.z)

				local var_101_15 = var_101_6.localEulerAngles

				var_101_15.z = 0
				var_101_15.x = 0
				var_101_6.localEulerAngles = var_101_15
			end

			local var_101_16 = arg_98_1.actors_["1084ui_story"]
			local var_101_17 = 0

			if var_101_17 < arg_98_1.time_ and arg_98_1.time_ <= var_101_17 + arg_101_0 and not isNil(var_101_16) and arg_98_1.var_.characterEffect1084ui_story == nil then
				arg_98_1.var_.characterEffect1084ui_story = var_101_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_18 = 0.200000002980232

			if var_101_17 <= arg_98_1.time_ and arg_98_1.time_ < var_101_17 + var_101_18 and not isNil(var_101_16) then
				local var_101_19 = (arg_98_1.time_ - var_101_17) / var_101_18

				if arg_98_1.var_.characterEffect1084ui_story and not isNil(var_101_16) then
					arg_98_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_98_1.time_ >= var_101_17 + var_101_18 and arg_98_1.time_ < var_101_17 + var_101_18 + arg_101_0 and not isNil(var_101_16) and arg_98_1.var_.characterEffect1084ui_story then
				arg_98_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_101_20 = 0

			if var_101_20 < arg_98_1.time_ and arg_98_1.time_ <= var_101_20 + arg_101_0 then
				arg_98_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_101_21 = 0

			if var_101_21 < arg_98_1.time_ and arg_98_1.time_ <= var_101_21 + arg_101_0 then
				arg_98_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_101_22 = arg_98_1.actors_["10058ui_story"].transform
			local var_101_23 = 0

			if var_101_23 < arg_98_1.time_ and arg_98_1.time_ <= var_101_23 + arg_101_0 then
				arg_98_1.var_.moveOldPos10058ui_story = var_101_22.localPosition
			end

			local var_101_24 = 0.001

			if var_101_23 <= arg_98_1.time_ and arg_98_1.time_ < var_101_23 + var_101_24 then
				local var_101_25 = (arg_98_1.time_ - var_101_23) / var_101_24
				local var_101_26 = Vector3.New(0.7, -0.98, -6.1)

				var_101_22.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos10058ui_story, var_101_26, var_101_25)

				local var_101_27 = manager.ui.mainCamera.transform.position - var_101_22.position

				var_101_22.forward = Vector3.New(var_101_27.x, var_101_27.y, var_101_27.z)

				local var_101_28 = var_101_22.localEulerAngles

				var_101_28.z = 0
				var_101_28.x = 0
				var_101_22.localEulerAngles = var_101_28
			end

			if arg_98_1.time_ >= var_101_23 + var_101_24 and arg_98_1.time_ < var_101_23 + var_101_24 + arg_101_0 then
				var_101_22.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_101_29 = manager.ui.mainCamera.transform.position - var_101_22.position

				var_101_22.forward = Vector3.New(var_101_29.x, var_101_29.y, var_101_29.z)

				local var_101_30 = var_101_22.localEulerAngles

				var_101_30.z = 0
				var_101_30.x = 0
				var_101_22.localEulerAngles = var_101_30
			end

			local var_101_31 = 0
			local var_101_32 = 0.225

			if var_101_31 < arg_98_1.time_ and arg_98_1.time_ <= var_101_31 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_33 = arg_98_1:FormatText(StoryNameCfg[6].name)

				arg_98_1.leftNameTxt_.text = var_101_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_34 = arg_98_1:GetWordFromCfg(319351023)
				local var_101_35 = arg_98_1:FormatText(var_101_34.content)

				arg_98_1.text_.text = var_101_35

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_36 = 9
				local var_101_37 = utf8.len(var_101_35)
				local var_101_38 = var_101_36 <= 0 and var_101_32 or var_101_32 * (var_101_37 / var_101_36)

				if var_101_38 > 0 and var_101_32 < var_101_38 then
					arg_98_1.talkMaxDuration = var_101_38

					if var_101_38 + var_101_31 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_38 + var_101_31
					end
				end

				arg_98_1.text_.text = var_101_35
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319351", "319351023", "story_v_out_319351.awb") ~= 0 then
					local var_101_39 = manager.audio:GetVoiceLength("story_v_out_319351", "319351023", "story_v_out_319351.awb") / 1000

					if var_101_39 + var_101_31 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_39 + var_101_31
					end

					if var_101_34.prefab_name ~= "" and arg_98_1.actors_[var_101_34.prefab_name] ~= nil then
						local var_101_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_34.prefab_name].transform, "story_v_out_319351", "319351023", "story_v_out_319351.awb")

						arg_98_1:RecordAudio("319351023", var_101_40)
						arg_98_1:RecordAudio("319351023", var_101_40)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_319351", "319351023", "story_v_out_319351.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_319351", "319351023", "story_v_out_319351.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_41 = math.max(var_101_32, arg_98_1.talkMaxDuration)

			if var_101_31 <= arg_98_1.time_ and arg_98_1.time_ < var_101_31 + var_101_41 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_31) / var_101_41

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_31 + var_101_41 and arg_98_1.time_ < var_101_31 + var_101_41 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
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

		arg_98_1:InitPlayNodeList()
	end,
	Play319351024 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 319351024
		arg_102_1.duration_ = 11.73

		local var_102_0 = {
			zh = 8.766,
			ja = 11.733
		}
		local var_102_1 = manager.audio:GetLocalizationFlag()

		if var_102_0[var_102_1] ~= nil then
			arg_102_1.duration_ = var_102_0[var_102_1]
		end

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play319351025(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = arg_102_1.actors_["10058ui_story"]
			local var_105_1 = 0

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect10058ui_story == nil then
				arg_102_1.var_.characterEffect10058ui_story = var_105_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_2 = 0.200000002980232

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_2 and not isNil(var_105_0) then
				local var_105_3 = (arg_102_1.time_ - var_105_1) / var_105_2

				if arg_102_1.var_.characterEffect10058ui_story and not isNil(var_105_0) then
					arg_102_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= var_105_1 + var_105_2 and arg_102_1.time_ < var_105_1 + var_105_2 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect10058ui_story then
				arg_102_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_105_4 = arg_102_1.actors_["1084ui_story"]
			local var_105_5 = 0

			if var_105_5 < arg_102_1.time_ and arg_102_1.time_ <= var_105_5 + arg_105_0 and not isNil(var_105_4) and arg_102_1.var_.characterEffect1084ui_story == nil then
				arg_102_1.var_.characterEffect1084ui_story = var_105_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_6 = 0.200000002980232

			if var_105_5 <= arg_102_1.time_ and arg_102_1.time_ < var_105_5 + var_105_6 and not isNil(var_105_4) then
				local var_105_7 = (arg_102_1.time_ - var_105_5) / var_105_6

				if arg_102_1.var_.characterEffect1084ui_story and not isNil(var_105_4) then
					local var_105_8 = Mathf.Lerp(0, 0.5, var_105_7)

					arg_102_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_102_1.var_.characterEffect1084ui_story.fillRatio = var_105_8
				end
			end

			if arg_102_1.time_ >= var_105_5 + var_105_6 and arg_102_1.time_ < var_105_5 + var_105_6 + arg_105_0 and not isNil(var_105_4) and arg_102_1.var_.characterEffect1084ui_story then
				local var_105_9 = 0.5

				arg_102_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_102_1.var_.characterEffect1084ui_story.fillRatio = var_105_9
			end

			local var_105_10 = 0

			if var_105_10 < arg_102_1.time_ and arg_102_1.time_ <= var_105_10 + arg_105_0 then
				arg_102_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_105_11 = 0

			if var_105_11 < arg_102_1.time_ and arg_102_1.time_ <= var_105_11 + arg_105_0 then
				arg_102_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action6_1")
			end

			local var_105_12 = 0
			local var_105_13 = 0.825

			if var_105_12 < arg_102_1.time_ and arg_102_1.time_ <= var_105_12 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_14 = arg_102_1:FormatText(StoryNameCfg[471].name)

				arg_102_1.leftNameTxt_.text = var_105_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_15 = arg_102_1:GetWordFromCfg(319351024)
				local var_105_16 = arg_102_1:FormatText(var_105_15.content)

				arg_102_1.text_.text = var_105_16

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_17 = 33
				local var_105_18 = utf8.len(var_105_16)
				local var_105_19 = var_105_17 <= 0 and var_105_13 or var_105_13 * (var_105_18 / var_105_17)

				if var_105_19 > 0 and var_105_13 < var_105_19 then
					arg_102_1.talkMaxDuration = var_105_19

					if var_105_19 + var_105_12 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_19 + var_105_12
					end
				end

				arg_102_1.text_.text = var_105_16
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319351", "319351024", "story_v_out_319351.awb") ~= 0 then
					local var_105_20 = manager.audio:GetVoiceLength("story_v_out_319351", "319351024", "story_v_out_319351.awb") / 1000

					if var_105_20 + var_105_12 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_20 + var_105_12
					end

					if var_105_15.prefab_name ~= "" and arg_102_1.actors_[var_105_15.prefab_name] ~= nil then
						local var_105_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_15.prefab_name].transform, "story_v_out_319351", "319351024", "story_v_out_319351.awb")

						arg_102_1:RecordAudio("319351024", var_105_21)
						arg_102_1:RecordAudio("319351024", var_105_21)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_319351", "319351024", "story_v_out_319351.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_319351", "319351024", "story_v_out_319351.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_22 = math.max(var_105_13, arg_102_1.talkMaxDuration)

			if var_105_12 <= arg_102_1.time_ and arg_102_1.time_ < var_105_12 + var_105_22 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_12) / var_105_22

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_12 + var_105_22 and arg_102_1.time_ < var_105_12 + var_105_22 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play319351025 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 319351025
		arg_106_1.duration_ = 7.07

		local var_106_0 = {
			zh = 7,
			ja = 7.066
		}
		local var_106_1 = manager.audio:GetLocalizationFlag()

		if var_106_0[var_106_1] ~= nil then
			arg_106_1.duration_ = var_106_0[var_106_1]
		end

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play319351026(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = arg_106_1.actors_["1084ui_story"].transform
			local var_109_1 = 0

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 then
				arg_106_1.var_.moveOldPos1084ui_story = var_109_0.localPosition
			end

			local var_109_2 = 0.001

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_2 then
				local var_109_3 = (arg_106_1.time_ - var_109_1) / var_109_2
				local var_109_4 = Vector3.New(-0.7, -0.97, -6)

				var_109_0.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos1084ui_story, var_109_4, var_109_3)

				local var_109_5 = manager.ui.mainCamera.transform.position - var_109_0.position

				var_109_0.forward = Vector3.New(var_109_5.x, var_109_5.y, var_109_5.z)

				local var_109_6 = var_109_0.localEulerAngles

				var_109_6.z = 0
				var_109_6.x = 0
				var_109_0.localEulerAngles = var_109_6
			end

			if arg_106_1.time_ >= var_109_1 + var_109_2 and arg_106_1.time_ < var_109_1 + var_109_2 + arg_109_0 then
				var_109_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_109_7 = manager.ui.mainCamera.transform.position - var_109_0.position

				var_109_0.forward = Vector3.New(var_109_7.x, var_109_7.y, var_109_7.z)

				local var_109_8 = var_109_0.localEulerAngles

				var_109_8.z = 0
				var_109_8.x = 0
				var_109_0.localEulerAngles = var_109_8
			end

			local var_109_9 = arg_106_1.actors_["1084ui_story"]
			local var_109_10 = 0

			if var_109_10 < arg_106_1.time_ and arg_106_1.time_ <= var_109_10 + arg_109_0 and not isNil(var_109_9) and arg_106_1.var_.characterEffect1084ui_story == nil then
				arg_106_1.var_.characterEffect1084ui_story = var_109_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_11 = 0.200000002980232

			if var_109_10 <= arg_106_1.time_ and arg_106_1.time_ < var_109_10 + var_109_11 and not isNil(var_109_9) then
				local var_109_12 = (arg_106_1.time_ - var_109_10) / var_109_11

				if arg_106_1.var_.characterEffect1084ui_story and not isNil(var_109_9) then
					arg_106_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_106_1.time_ >= var_109_10 + var_109_11 and arg_106_1.time_ < var_109_10 + var_109_11 + arg_109_0 and not isNil(var_109_9) and arg_106_1.var_.characterEffect1084ui_story then
				arg_106_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_109_13 = arg_106_1.actors_["10058ui_story"]
			local var_109_14 = 0

			if var_109_14 < arg_106_1.time_ and arg_106_1.time_ <= var_109_14 + arg_109_0 and not isNil(var_109_13) and arg_106_1.var_.characterEffect10058ui_story == nil then
				arg_106_1.var_.characterEffect10058ui_story = var_109_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_15 = 0.200000002980232

			if var_109_14 <= arg_106_1.time_ and arg_106_1.time_ < var_109_14 + var_109_15 and not isNil(var_109_13) then
				local var_109_16 = (arg_106_1.time_ - var_109_14) / var_109_15

				if arg_106_1.var_.characterEffect10058ui_story and not isNil(var_109_13) then
					local var_109_17 = Mathf.Lerp(0, 0.5, var_109_16)

					arg_106_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_106_1.var_.characterEffect10058ui_story.fillRatio = var_109_17
				end
			end

			if arg_106_1.time_ >= var_109_14 + var_109_15 and arg_106_1.time_ < var_109_14 + var_109_15 + arg_109_0 and not isNil(var_109_13) and arg_106_1.var_.characterEffect10058ui_story then
				local var_109_18 = 0.5

				arg_106_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_106_1.var_.characterEffect10058ui_story.fillRatio = var_109_18
			end

			local var_109_19 = 0

			if var_109_19 < arg_106_1.time_ and arg_106_1.time_ <= var_109_19 + arg_109_0 then
				arg_106_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action437")
			end

			local var_109_20 = 0

			if var_109_20 < arg_106_1.time_ and arg_106_1.time_ <= var_109_20 + arg_109_0 then
				arg_106_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_109_21 = 0
			local var_109_22 = 0.6

			if var_109_21 < arg_106_1.time_ and arg_106_1.time_ <= var_109_21 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_23 = arg_106_1:FormatText(StoryNameCfg[6].name)

				arg_106_1.leftNameTxt_.text = var_109_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_24 = arg_106_1:GetWordFromCfg(319351025)
				local var_109_25 = arg_106_1:FormatText(var_109_24.content)

				arg_106_1.text_.text = var_109_25

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_26 = 24
				local var_109_27 = utf8.len(var_109_25)
				local var_109_28 = var_109_26 <= 0 and var_109_22 or var_109_22 * (var_109_27 / var_109_26)

				if var_109_28 > 0 and var_109_22 < var_109_28 then
					arg_106_1.talkMaxDuration = var_109_28

					if var_109_28 + var_109_21 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_28 + var_109_21
					end
				end

				arg_106_1.text_.text = var_109_25
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319351", "319351025", "story_v_out_319351.awb") ~= 0 then
					local var_109_29 = manager.audio:GetVoiceLength("story_v_out_319351", "319351025", "story_v_out_319351.awb") / 1000

					if var_109_29 + var_109_21 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_29 + var_109_21
					end

					if var_109_24.prefab_name ~= "" and arg_106_1.actors_[var_109_24.prefab_name] ~= nil then
						local var_109_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_24.prefab_name].transform, "story_v_out_319351", "319351025", "story_v_out_319351.awb")

						arg_106_1:RecordAudio("319351025", var_109_30)
						arg_106_1:RecordAudio("319351025", var_109_30)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_319351", "319351025", "story_v_out_319351.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_319351", "319351025", "story_v_out_319351.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_31 = math.max(var_109_22, arg_106_1.talkMaxDuration)

			if var_109_21 <= arg_106_1.time_ and arg_106_1.time_ < var_109_21 + var_109_31 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_21) / var_109_31

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_21 + var_109_31 and arg_106_1.time_ < var_109_21 + var_109_31 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {
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

		arg_106_1:InitPlayNodeList()
	end,
	Play319351026 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 319351026
		arg_110_1.duration_ = 5.3

		local var_110_0 = {
			zh = 5.3,
			ja = 5.2
		}
		local var_110_1 = manager.audio:GetLocalizationFlag()

		if var_110_0[var_110_1] ~= nil then
			arg_110_1.duration_ = var_110_0[var_110_1]
		end

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play319351027(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = 0
			local var_113_1 = 0.725

			if var_113_0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_0 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_2 = arg_110_1:FormatText(StoryNameCfg[6].name)

				arg_110_1.leftNameTxt_.text = var_113_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_3 = arg_110_1:GetWordFromCfg(319351026)
				local var_113_4 = arg_110_1:FormatText(var_113_3.content)

				arg_110_1.text_.text = var_113_4

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_5 = 29
				local var_113_6 = utf8.len(var_113_4)
				local var_113_7 = var_113_5 <= 0 and var_113_1 or var_113_1 * (var_113_6 / var_113_5)

				if var_113_7 > 0 and var_113_1 < var_113_7 then
					arg_110_1.talkMaxDuration = var_113_7

					if var_113_7 + var_113_0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_7 + var_113_0
					end
				end

				arg_110_1.text_.text = var_113_4
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319351", "319351026", "story_v_out_319351.awb") ~= 0 then
					local var_113_8 = manager.audio:GetVoiceLength("story_v_out_319351", "319351026", "story_v_out_319351.awb") / 1000

					if var_113_8 + var_113_0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_8 + var_113_0
					end

					if var_113_3.prefab_name ~= "" and arg_110_1.actors_[var_113_3.prefab_name] ~= nil then
						local var_113_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_3.prefab_name].transform, "story_v_out_319351", "319351026", "story_v_out_319351.awb")

						arg_110_1:RecordAudio("319351026", var_113_9)
						arg_110_1:RecordAudio("319351026", var_113_9)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_319351", "319351026", "story_v_out_319351.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_319351", "319351026", "story_v_out_319351.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_10 = math.max(var_113_1, arg_110_1.talkMaxDuration)

			if var_113_0 <= arg_110_1.time_ and arg_110_1.time_ < var_113_0 + var_113_10 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_0) / var_113_10

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_0 + var_113_10 and arg_110_1.time_ < var_113_0 + var_113_10 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play319351027 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 319351027
		arg_114_1.duration_ = 5.93

		local var_114_0 = {
			zh = 1.999999999999,
			ja = 5.933
		}
		local var_114_1 = manager.audio:GetLocalizationFlag()

		if var_114_0[var_114_1] ~= nil then
			arg_114_1.duration_ = var_114_0[var_114_1]
		end

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play319351028(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = arg_114_1.actors_["10058ui_story"]
			local var_117_1 = 0

			if var_117_1 < arg_114_1.time_ and arg_114_1.time_ <= var_117_1 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.characterEffect10058ui_story == nil then
				arg_114_1.var_.characterEffect10058ui_story = var_117_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_2 = 0.200000002980232

			if var_117_1 <= arg_114_1.time_ and arg_114_1.time_ < var_117_1 + var_117_2 and not isNil(var_117_0) then
				local var_117_3 = (arg_114_1.time_ - var_117_1) / var_117_2

				if arg_114_1.var_.characterEffect10058ui_story and not isNil(var_117_0) then
					arg_114_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_114_1.time_ >= var_117_1 + var_117_2 and arg_114_1.time_ < var_117_1 + var_117_2 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.characterEffect10058ui_story then
				arg_114_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_117_4 = arg_114_1.actors_["1084ui_story"]
			local var_117_5 = 0

			if var_117_5 < arg_114_1.time_ and arg_114_1.time_ <= var_117_5 + arg_117_0 and not isNil(var_117_4) and arg_114_1.var_.characterEffect1084ui_story == nil then
				arg_114_1.var_.characterEffect1084ui_story = var_117_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_6 = 0.200000002980232

			if var_117_5 <= arg_114_1.time_ and arg_114_1.time_ < var_117_5 + var_117_6 and not isNil(var_117_4) then
				local var_117_7 = (arg_114_1.time_ - var_117_5) / var_117_6

				if arg_114_1.var_.characterEffect1084ui_story and not isNil(var_117_4) then
					local var_117_8 = Mathf.Lerp(0, 0.5, var_117_7)

					arg_114_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_114_1.var_.characterEffect1084ui_story.fillRatio = var_117_8
				end
			end

			if arg_114_1.time_ >= var_117_5 + var_117_6 and arg_114_1.time_ < var_117_5 + var_117_6 + arg_117_0 and not isNil(var_117_4) and arg_114_1.var_.characterEffect1084ui_story then
				local var_117_9 = 0.5

				arg_114_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_114_1.var_.characterEffect1084ui_story.fillRatio = var_117_9
			end

			local var_117_10 = 0

			if var_117_10 < arg_114_1.time_ and arg_114_1.time_ <= var_117_10 + arg_117_0 then
				arg_114_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action6_2")
			end

			local var_117_11 = 0

			if var_117_11 < arg_114_1.time_ and arg_114_1.time_ <= var_117_11 + arg_117_0 then
				arg_114_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_117_12 = 0
			local var_117_13 = 0.075

			if var_117_12 < arg_114_1.time_ and arg_114_1.time_ <= var_117_12 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_14 = arg_114_1:FormatText(StoryNameCfg[471].name)

				arg_114_1.leftNameTxt_.text = var_117_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_15 = arg_114_1:GetWordFromCfg(319351027)
				local var_117_16 = arg_114_1:FormatText(var_117_15.content)

				arg_114_1.text_.text = var_117_16

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_17 = 3
				local var_117_18 = utf8.len(var_117_16)
				local var_117_19 = var_117_17 <= 0 and var_117_13 or var_117_13 * (var_117_18 / var_117_17)

				if var_117_19 > 0 and var_117_13 < var_117_19 then
					arg_114_1.talkMaxDuration = var_117_19

					if var_117_19 + var_117_12 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_19 + var_117_12
					end
				end

				arg_114_1.text_.text = var_117_16
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319351", "319351027", "story_v_out_319351.awb") ~= 0 then
					local var_117_20 = manager.audio:GetVoiceLength("story_v_out_319351", "319351027", "story_v_out_319351.awb") / 1000

					if var_117_20 + var_117_12 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_20 + var_117_12
					end

					if var_117_15.prefab_name ~= "" and arg_114_1.actors_[var_117_15.prefab_name] ~= nil then
						local var_117_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_15.prefab_name].transform, "story_v_out_319351", "319351027", "story_v_out_319351.awb")

						arg_114_1:RecordAudio("319351027", var_117_21)
						arg_114_1:RecordAudio("319351027", var_117_21)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_319351", "319351027", "story_v_out_319351.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_319351", "319351027", "story_v_out_319351.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_22 = math.max(var_117_13, arg_114_1.talkMaxDuration)

			if var_117_12 <= arg_114_1.time_ and arg_114_1.time_ < var_117_12 + var_117_22 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_12) / var_117_22

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_12 + var_117_22 and arg_114_1.time_ < var_117_12 + var_117_22 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play319351028 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 319351028
		arg_118_1.duration_ = 2

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play319351029(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = arg_118_1.actors_["10058ui_story"]
			local var_121_1 = 0

			if var_121_1 < arg_118_1.time_ and arg_118_1.time_ <= var_121_1 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.characterEffect10058ui_story == nil then
				arg_118_1.var_.characterEffect10058ui_story = var_121_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_2 = 0.200000002980232

			if var_121_1 <= arg_118_1.time_ and arg_118_1.time_ < var_121_1 + var_121_2 and not isNil(var_121_0) then
				local var_121_3 = (arg_118_1.time_ - var_121_1) / var_121_2

				if arg_118_1.var_.characterEffect10058ui_story and not isNil(var_121_0) then
					local var_121_4 = Mathf.Lerp(0, 0.5, var_121_3)

					arg_118_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_118_1.var_.characterEffect10058ui_story.fillRatio = var_121_4
				end
			end

			if arg_118_1.time_ >= var_121_1 + var_121_2 and arg_118_1.time_ < var_121_1 + var_121_2 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.characterEffect10058ui_story then
				local var_121_5 = 0.5

				arg_118_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_118_1.var_.characterEffect10058ui_story.fillRatio = var_121_5
			end

			local var_121_6 = arg_118_1.actors_["1084ui_story"]
			local var_121_7 = 0

			if var_121_7 < arg_118_1.time_ and arg_118_1.time_ <= var_121_7 + arg_121_0 and not isNil(var_121_6) and arg_118_1.var_.characterEffect1084ui_story == nil then
				arg_118_1.var_.characterEffect1084ui_story = var_121_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_8 = 0.200000002980232

			if var_121_7 <= arg_118_1.time_ and arg_118_1.time_ < var_121_7 + var_121_8 and not isNil(var_121_6) then
				local var_121_9 = (arg_118_1.time_ - var_121_7) / var_121_8

				if arg_118_1.var_.characterEffect1084ui_story and not isNil(var_121_6) then
					arg_118_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_118_1.time_ >= var_121_7 + var_121_8 and arg_118_1.time_ < var_121_7 + var_121_8 + arg_121_0 and not isNil(var_121_6) and arg_118_1.var_.characterEffect1084ui_story then
				arg_118_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_121_10 = 0

			if var_121_10 < arg_118_1.time_ and arg_118_1.time_ <= var_121_10 + arg_121_0 then
				arg_118_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			local var_121_11 = 0

			if var_121_11 < arg_118_1.time_ and arg_118_1.time_ <= var_121_11 + arg_121_0 then
				arg_118_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_121_12 = 0
			local var_121_13 = 0.075

			if var_121_12 < arg_118_1.time_ and arg_118_1.time_ <= var_121_12 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_14 = arg_118_1:FormatText(StoryNameCfg[6].name)

				arg_118_1.leftNameTxt_.text = var_121_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_15 = arg_118_1:GetWordFromCfg(319351028)
				local var_121_16 = arg_118_1:FormatText(var_121_15.content)

				arg_118_1.text_.text = var_121_16

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_17 = 3
				local var_121_18 = utf8.len(var_121_16)
				local var_121_19 = var_121_17 <= 0 and var_121_13 or var_121_13 * (var_121_18 / var_121_17)

				if var_121_19 > 0 and var_121_13 < var_121_19 then
					arg_118_1.talkMaxDuration = var_121_19

					if var_121_19 + var_121_12 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_19 + var_121_12
					end
				end

				arg_118_1.text_.text = var_121_16
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319351", "319351028", "story_v_out_319351.awb") ~= 0 then
					local var_121_20 = manager.audio:GetVoiceLength("story_v_out_319351", "319351028", "story_v_out_319351.awb") / 1000

					if var_121_20 + var_121_12 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_20 + var_121_12
					end

					if var_121_15.prefab_name ~= "" and arg_118_1.actors_[var_121_15.prefab_name] ~= nil then
						local var_121_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_15.prefab_name].transform, "story_v_out_319351", "319351028", "story_v_out_319351.awb")

						arg_118_1:RecordAudio("319351028", var_121_21)
						arg_118_1:RecordAudio("319351028", var_121_21)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_319351", "319351028", "story_v_out_319351.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_319351", "319351028", "story_v_out_319351.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_22 = math.max(var_121_13, arg_118_1.talkMaxDuration)

			if var_121_12 <= arg_118_1.time_ and arg_118_1.time_ < var_121_12 + var_121_22 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_12) / var_121_22

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_12 + var_121_22 and arg_118_1.time_ < var_121_12 + var_121_22 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play319351029 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 319351029
		arg_122_1.duration_ = 5

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play319351030(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = arg_122_1.actors_["10058ui_story"].transform
			local var_125_1 = 0

			if var_125_1 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 then
				arg_122_1.var_.moveOldPos10058ui_story = var_125_0.localPosition
			end

			local var_125_2 = 0.001

			if var_125_1 <= arg_122_1.time_ and arg_122_1.time_ < var_125_1 + var_125_2 then
				local var_125_3 = (arg_122_1.time_ - var_125_1) / var_125_2
				local var_125_4 = Vector3.New(0, 100, 0)

				var_125_0.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos10058ui_story, var_125_4, var_125_3)

				local var_125_5 = manager.ui.mainCamera.transform.position - var_125_0.position

				var_125_0.forward = Vector3.New(var_125_5.x, var_125_5.y, var_125_5.z)

				local var_125_6 = var_125_0.localEulerAngles

				var_125_6.z = 0
				var_125_6.x = 0
				var_125_0.localEulerAngles = var_125_6
			end

			if arg_122_1.time_ >= var_125_1 + var_125_2 and arg_122_1.time_ < var_125_1 + var_125_2 + arg_125_0 then
				var_125_0.localPosition = Vector3.New(0, 100, 0)

				local var_125_7 = manager.ui.mainCamera.transform.position - var_125_0.position

				var_125_0.forward = Vector3.New(var_125_7.x, var_125_7.y, var_125_7.z)

				local var_125_8 = var_125_0.localEulerAngles

				var_125_8.z = 0
				var_125_8.x = 0
				var_125_0.localEulerAngles = var_125_8
			end

			local var_125_9 = arg_122_1.actors_["10058ui_story"]
			local var_125_10 = 0

			if var_125_10 < arg_122_1.time_ and arg_122_1.time_ <= var_125_10 + arg_125_0 and not isNil(var_125_9) and arg_122_1.var_.characterEffect10058ui_story == nil then
				arg_122_1.var_.characterEffect10058ui_story = var_125_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_11 = 0.200000002980232

			if var_125_10 <= arg_122_1.time_ and arg_122_1.time_ < var_125_10 + var_125_11 and not isNil(var_125_9) then
				local var_125_12 = (arg_122_1.time_ - var_125_10) / var_125_11

				if arg_122_1.var_.characterEffect10058ui_story and not isNil(var_125_9) then
					local var_125_13 = Mathf.Lerp(0, 0.5, var_125_12)

					arg_122_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_122_1.var_.characterEffect10058ui_story.fillRatio = var_125_13
				end
			end

			if arg_122_1.time_ >= var_125_10 + var_125_11 and arg_122_1.time_ < var_125_10 + var_125_11 + arg_125_0 and not isNil(var_125_9) and arg_122_1.var_.characterEffect10058ui_story then
				local var_125_14 = 0.5

				arg_122_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_122_1.var_.characterEffect10058ui_story.fillRatio = var_125_14
			end

			local var_125_15 = arg_122_1.actors_["1084ui_story"].transform
			local var_125_16 = 0

			if var_125_16 < arg_122_1.time_ and arg_122_1.time_ <= var_125_16 + arg_125_0 then
				arg_122_1.var_.moveOldPos1084ui_story = var_125_15.localPosition
			end

			local var_125_17 = 0.001

			if var_125_16 <= arg_122_1.time_ and arg_122_1.time_ < var_125_16 + var_125_17 then
				local var_125_18 = (arg_122_1.time_ - var_125_16) / var_125_17
				local var_125_19 = Vector3.New(0, 100, 0)

				var_125_15.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos1084ui_story, var_125_19, var_125_18)

				local var_125_20 = manager.ui.mainCamera.transform.position - var_125_15.position

				var_125_15.forward = Vector3.New(var_125_20.x, var_125_20.y, var_125_20.z)

				local var_125_21 = var_125_15.localEulerAngles

				var_125_21.z = 0
				var_125_21.x = 0
				var_125_15.localEulerAngles = var_125_21
			end

			if arg_122_1.time_ >= var_125_16 + var_125_17 and arg_122_1.time_ < var_125_16 + var_125_17 + arg_125_0 then
				var_125_15.localPosition = Vector3.New(0, 100, 0)

				local var_125_22 = manager.ui.mainCamera.transform.position - var_125_15.position

				var_125_15.forward = Vector3.New(var_125_22.x, var_125_22.y, var_125_22.z)

				local var_125_23 = var_125_15.localEulerAngles

				var_125_23.z = 0
				var_125_23.x = 0
				var_125_15.localEulerAngles = var_125_23
			end

			local var_125_24 = arg_122_1.actors_["1084ui_story"]
			local var_125_25 = 0

			if var_125_25 < arg_122_1.time_ and arg_122_1.time_ <= var_125_25 + arg_125_0 and not isNil(var_125_24) and arg_122_1.var_.characterEffect1084ui_story == nil then
				arg_122_1.var_.characterEffect1084ui_story = var_125_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_26 = 0.200000002980232

			if var_125_25 <= arg_122_1.time_ and arg_122_1.time_ < var_125_25 + var_125_26 and not isNil(var_125_24) then
				local var_125_27 = (arg_122_1.time_ - var_125_25) / var_125_26

				if arg_122_1.var_.characterEffect1084ui_story and not isNil(var_125_24) then
					local var_125_28 = Mathf.Lerp(0, 0.5, var_125_27)

					arg_122_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_122_1.var_.characterEffect1084ui_story.fillRatio = var_125_28
				end
			end

			if arg_122_1.time_ >= var_125_25 + var_125_26 and arg_122_1.time_ < var_125_25 + var_125_26 + arg_125_0 and not isNil(var_125_24) and arg_122_1.var_.characterEffect1084ui_story then
				local var_125_29 = 0.5

				arg_122_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_122_1.var_.characterEffect1084ui_story.fillRatio = var_125_29
			end

			local var_125_30 = 0
			local var_125_31 = 1.15

			if var_125_30 < arg_122_1.time_ and arg_122_1.time_ <= var_125_30 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, false)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_32 = arg_122_1:GetWordFromCfg(319351029)
				local var_125_33 = arg_122_1:FormatText(var_125_32.content)

				arg_122_1.text_.text = var_125_33

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_34 = 46
				local var_125_35 = utf8.len(var_125_33)
				local var_125_36 = var_125_34 <= 0 and var_125_31 or var_125_31 * (var_125_35 / var_125_34)

				if var_125_36 > 0 and var_125_31 < var_125_36 then
					arg_122_1.talkMaxDuration = var_125_36

					if var_125_36 + var_125_30 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_36 + var_125_30
					end
				end

				arg_122_1.text_.text = var_125_33
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_37 = math.max(var_125_31, arg_122_1.talkMaxDuration)

			if var_125_30 <= arg_122_1.time_ and arg_122_1.time_ < var_125_30 + var_125_37 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_30) / var_125_37

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_30 + var_125_37 and arg_122_1.time_ < var_125_30 + var_125_37 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {
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
			}
		}

		arg_122_1:InitPlayNodeList()
	end,
	Play319351030 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 319351030
		arg_126_1.duration_ = 9.43

		local var_126_0 = {
			zh = 8.99966666666667,
			ja = 9.43266666666667
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
				arg_126_0:Play319351031(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = "1095ui_story"

			if arg_126_1.actors_[var_129_0] == nil then
				local var_129_1 = Asset.Load("Char/" .. "1095ui_story")

				if not isNil(var_129_1) then
					local var_129_2 = Object.Instantiate(Asset.Load("Char/" .. "1095ui_story"), arg_126_1.stage_.transform)

					var_129_2.name = var_129_0
					var_129_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_126_1.actors_[var_129_0] = var_129_2

					local var_129_3 = var_129_2:GetComponentInChildren(typeof(CharacterEffect))

					var_129_3.enabled = true

					local var_129_4 = GameObjectTools.GetOrAddComponent(var_129_2, typeof(DynamicBoneHelper))

					if var_129_4 then
						var_129_4:EnableDynamicBone(false)
					end

					arg_126_1:ShowWeapon(var_129_3.transform, false)

					arg_126_1.var_[var_129_0 .. "Animator"] = var_129_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_126_1.var_[var_129_0 .. "Animator"].applyRootMotion = true
					arg_126_1.var_[var_129_0 .. "LipSync"] = var_129_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_129_5 = arg_126_1.actors_["1095ui_story"].transform
			local var_129_6 = 2.36666666666667

			if var_129_6 < arg_126_1.time_ and arg_126_1.time_ <= var_129_6 + arg_129_0 then
				arg_126_1.var_.moveOldPos1095ui_story = var_129_5.localPosition
			end

			local var_129_7 = 0.001

			if var_129_6 <= arg_126_1.time_ and arg_126_1.time_ < var_129_6 + var_129_7 then
				local var_129_8 = (arg_126_1.time_ - var_129_6) / var_129_7
				local var_129_9 = Vector3.New(0, -0.98, -6.1)

				var_129_5.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos1095ui_story, var_129_9, var_129_8)

				local var_129_10 = manager.ui.mainCamera.transform.position - var_129_5.position

				var_129_5.forward = Vector3.New(var_129_10.x, var_129_10.y, var_129_10.z)

				local var_129_11 = var_129_5.localEulerAngles

				var_129_11.z = 0
				var_129_11.x = 0
				var_129_5.localEulerAngles = var_129_11
			end

			if arg_126_1.time_ >= var_129_6 + var_129_7 and arg_126_1.time_ < var_129_6 + var_129_7 + arg_129_0 then
				var_129_5.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_129_12 = manager.ui.mainCamera.transform.position - var_129_5.position

				var_129_5.forward = Vector3.New(var_129_12.x, var_129_12.y, var_129_12.z)

				local var_129_13 = var_129_5.localEulerAngles

				var_129_13.z = 0
				var_129_13.x = 0
				var_129_5.localEulerAngles = var_129_13
			end

			local var_129_14 = arg_126_1.actors_["1095ui_story"]
			local var_129_15 = 2.36666666666667

			if var_129_15 < arg_126_1.time_ and arg_126_1.time_ <= var_129_15 + arg_129_0 and not isNil(var_129_14) and arg_126_1.var_.characterEffect1095ui_story == nil then
				arg_126_1.var_.characterEffect1095ui_story = var_129_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_16 = 0.200000002980232

			if var_129_15 <= arg_126_1.time_ and arg_126_1.time_ < var_129_15 + var_129_16 and not isNil(var_129_14) then
				local var_129_17 = (arg_126_1.time_ - var_129_15) / var_129_16

				if arg_126_1.var_.characterEffect1095ui_story and not isNil(var_129_14) then
					arg_126_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_126_1.time_ >= var_129_15 + var_129_16 and arg_126_1.time_ < var_129_15 + var_129_16 + arg_129_0 and not isNil(var_129_14) and arg_126_1.var_.characterEffect1095ui_story then
				arg_126_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_129_18 = 2.36666666666667

			if var_129_18 < arg_126_1.time_ and arg_126_1.time_ <= var_129_18 + arg_129_0 then
				arg_126_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_129_19 = 2.36666666666667

			if var_129_19 < arg_126_1.time_ and arg_126_1.time_ <= var_129_19 + arg_129_0 then
				arg_126_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_129_20 = 1.4

			if var_129_20 < arg_126_1.time_ and arg_126_1.time_ <= var_129_20 + arg_129_0 then
				local var_129_21 = manager.ui.mainCamera.transform.localPosition
				local var_129_22 = Vector3.New(0, 0, 10) + Vector3.New(var_129_21.x, var_129_21.y, 0)
				local var_129_23 = arg_126_1.bgs_.ST74

				var_129_23.transform.localPosition = var_129_22
				var_129_23.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_129_24 = var_129_23:GetComponent("SpriteRenderer")

				if var_129_24 and var_129_24.sprite then
					local var_129_25 = (var_129_23.transform.localPosition - var_129_21).z
					local var_129_26 = manager.ui.mainCameraCom_
					local var_129_27 = 2 * var_129_25 * Mathf.Tan(var_129_26.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_129_28 = var_129_27 * var_129_26.aspect
					local var_129_29 = var_129_24.sprite.bounds.size.x
					local var_129_30 = var_129_24.sprite.bounds.size.y
					local var_129_31 = var_129_28 / var_129_29
					local var_129_32 = var_129_27 / var_129_30
					local var_129_33 = var_129_32 < var_129_31 and var_129_31 or var_129_32

					var_129_23.transform.localScale = Vector3.New(var_129_33, var_129_33, 0)
				end

				for iter_129_0, iter_129_1 in pairs(arg_126_1.bgs_) do
					if iter_129_0 ~= "ST74" then
						iter_129_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_129_34 = 0

			if var_129_34 < arg_126_1.time_ and arg_126_1.time_ <= var_129_34 + arg_129_0 then
				arg_126_1.mask_.enabled = true
				arg_126_1.mask_.raycastTarget = true

				arg_126_1:SetGaussion(false)
			end

			local var_129_35 = 1.4

			if var_129_34 <= arg_126_1.time_ and arg_126_1.time_ < var_129_34 + var_129_35 then
				local var_129_36 = (arg_126_1.time_ - var_129_34) / var_129_35
				local var_129_37 = Color.New(0, 0, 0)

				var_129_37.a = Mathf.Lerp(0, 1, var_129_36)
				arg_126_1.mask_.color = var_129_37
			end

			if arg_126_1.time_ >= var_129_34 + var_129_35 and arg_126_1.time_ < var_129_34 + var_129_35 + arg_129_0 then
				local var_129_38 = Color.New(0, 0, 0)

				var_129_38.a = 1
				arg_126_1.mask_.color = var_129_38
			end

			local var_129_39 = 1.4

			if var_129_39 < arg_126_1.time_ and arg_126_1.time_ <= var_129_39 + arg_129_0 then
				arg_126_1.mask_.enabled = true
				arg_126_1.mask_.raycastTarget = true

				arg_126_1:SetGaussion(false)
			end

			local var_129_40 = 1.00066666851441

			if var_129_39 <= arg_126_1.time_ and arg_126_1.time_ < var_129_39 + var_129_40 then
				local var_129_41 = (arg_126_1.time_ - var_129_39) / var_129_40
				local var_129_42 = Color.New(0, 0, 0)

				var_129_42.a = Mathf.Lerp(1, 0, var_129_41)
				arg_126_1.mask_.color = var_129_42
			end

			if arg_126_1.time_ >= var_129_39 + var_129_40 and arg_126_1.time_ < var_129_39 + var_129_40 + arg_129_0 then
				local var_129_43 = Color.New(0, 0, 0)
				local var_129_44 = 0

				arg_126_1.mask_.enabled = false
				var_129_43.a = var_129_44
				arg_126_1.mask_.color = var_129_43
			end

			if arg_126_1.frameCnt_ <= 1 then
				arg_126_1.dialog_:SetActive(false)
			end

			local var_129_45 = 2.36666666666667
			local var_129_46 = 0.75

			if var_129_45 < arg_126_1.time_ and arg_126_1.time_ <= var_129_45 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0

				arg_126_1.dialog_:SetActive(true)

				arg_126_1.dialogCg_.alpha = 0

				local var_129_47 = LeanTween.value(arg_126_1.dialog_, 0, 1, 0.3)

				var_129_47:setOnUpdate(LuaHelper.FloatAction(function(arg_130_0)
					arg_126_1.dialogCg_.alpha = arg_130_0
				end))
				var_129_47:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_126_1.dialog_)
					var_129_47:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_126_1.duration_ = arg_126_1.duration_ + 0.3

				SetActive(arg_126_1.leftNameGo_, true)

				local var_129_48 = arg_126_1:FormatText(StoryNameCfg[471].name)

				arg_126_1.leftNameTxt_.text = var_129_48

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_49 = arg_126_1:GetWordFromCfg(319351030)
				local var_129_50 = arg_126_1:FormatText(var_129_49.content)

				arg_126_1.text_.text = var_129_50

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_51 = 30
				local var_129_52 = utf8.len(var_129_50)
				local var_129_53 = var_129_51 <= 0 and var_129_46 or var_129_46 * (var_129_52 / var_129_51)

				if var_129_53 > 0 and var_129_46 < var_129_53 then
					arg_126_1.talkMaxDuration = var_129_53
					var_129_45 = var_129_45 + 0.3

					if var_129_53 + var_129_45 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_53 + var_129_45
					end
				end

				arg_126_1.text_.text = var_129_50
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319351", "319351030", "story_v_out_319351.awb") ~= 0 then
					local var_129_54 = manager.audio:GetVoiceLength("story_v_out_319351", "319351030", "story_v_out_319351.awb") / 1000

					if var_129_54 + var_129_45 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_54 + var_129_45
					end

					if var_129_49.prefab_name ~= "" and arg_126_1.actors_[var_129_49.prefab_name] ~= nil then
						local var_129_55 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_49.prefab_name].transform, "story_v_out_319351", "319351030", "story_v_out_319351.awb")

						arg_126_1:RecordAudio("319351030", var_129_55)
						arg_126_1:RecordAudio("319351030", var_129_55)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_319351", "319351030", "story_v_out_319351.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_319351", "319351030", "story_v_out_319351.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_56 = var_129_45 + 0.3
			local var_129_57 = math.max(var_129_46, arg_126_1.talkMaxDuration)

			if var_129_56 <= arg_126_1.time_ and arg_126_1.time_ < var_129_56 + var_129_57 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_56) / var_129_57

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_56 + var_129_57 and arg_126_1.time_ < var_129_56 + var_129_57 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.36666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_126_1:InitPlayNodeList()
	end,
	Play319351031 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 319351031
		arg_132_1.duration_ = 4.5

		local var_132_0 = {
			zh = 4.5,
			ja = 4.4
		}
		local var_132_1 = manager.audio:GetLocalizationFlag()

		if var_132_0[var_132_1] ~= nil then
			arg_132_1.duration_ = var_132_0[var_132_1]
		end

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play319351032(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = arg_132_1.actors_["1084ui_story"].transform
			local var_135_1 = 0

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 then
				arg_132_1.var_.moveOldPos1084ui_story = var_135_0.localPosition
			end

			local var_135_2 = 0.001

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_2 then
				local var_135_3 = (arg_132_1.time_ - var_135_1) / var_135_2
				local var_135_4 = Vector3.New(-0.7, -0.97, -6)

				var_135_0.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos1084ui_story, var_135_4, var_135_3)

				local var_135_5 = manager.ui.mainCamera.transform.position - var_135_0.position

				var_135_0.forward = Vector3.New(var_135_5.x, var_135_5.y, var_135_5.z)

				local var_135_6 = var_135_0.localEulerAngles

				var_135_6.z = 0
				var_135_6.x = 0
				var_135_0.localEulerAngles = var_135_6
			end

			if arg_132_1.time_ >= var_135_1 + var_135_2 and arg_132_1.time_ < var_135_1 + var_135_2 + arg_135_0 then
				var_135_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_135_7 = manager.ui.mainCamera.transform.position - var_135_0.position

				var_135_0.forward = Vector3.New(var_135_7.x, var_135_7.y, var_135_7.z)

				local var_135_8 = var_135_0.localEulerAngles

				var_135_8.z = 0
				var_135_8.x = 0
				var_135_0.localEulerAngles = var_135_8
			end

			local var_135_9 = arg_132_1.actors_["1084ui_story"]
			local var_135_10 = 0

			if var_135_10 < arg_132_1.time_ and arg_132_1.time_ <= var_135_10 + arg_135_0 and not isNil(var_135_9) and arg_132_1.var_.characterEffect1084ui_story == nil then
				arg_132_1.var_.characterEffect1084ui_story = var_135_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_11 = 0.200000002980232

			if var_135_10 <= arg_132_1.time_ and arg_132_1.time_ < var_135_10 + var_135_11 and not isNil(var_135_9) then
				local var_135_12 = (arg_132_1.time_ - var_135_10) / var_135_11

				if arg_132_1.var_.characterEffect1084ui_story and not isNil(var_135_9) then
					arg_132_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_132_1.time_ >= var_135_10 + var_135_11 and arg_132_1.time_ < var_135_10 + var_135_11 + arg_135_0 and not isNil(var_135_9) and arg_132_1.var_.characterEffect1084ui_story then
				arg_132_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_135_13 = 0

			if var_135_13 < arg_132_1.time_ and arg_132_1.time_ <= var_135_13 + arg_135_0 then
				arg_132_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			local var_135_14 = 0

			if var_135_14 < arg_132_1.time_ and arg_132_1.time_ <= var_135_14 + arg_135_0 then
				arg_132_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_135_15 = arg_132_1.actors_["1095ui_story"].transform
			local var_135_16 = 0

			if var_135_16 < arg_132_1.time_ and arg_132_1.time_ <= var_135_16 + arg_135_0 then
				arg_132_1.var_.moveOldPos1095ui_story = var_135_15.localPosition
			end

			local var_135_17 = 0.001

			if var_135_16 <= arg_132_1.time_ and arg_132_1.time_ < var_135_16 + var_135_17 then
				local var_135_18 = (arg_132_1.time_ - var_135_16) / var_135_17
				local var_135_19 = Vector3.New(0.7, -0.98, -6.1)

				var_135_15.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos1095ui_story, var_135_19, var_135_18)

				local var_135_20 = manager.ui.mainCamera.transform.position - var_135_15.position

				var_135_15.forward = Vector3.New(var_135_20.x, var_135_20.y, var_135_20.z)

				local var_135_21 = var_135_15.localEulerAngles

				var_135_21.z = 0
				var_135_21.x = 0
				var_135_15.localEulerAngles = var_135_21
			end

			if arg_132_1.time_ >= var_135_16 + var_135_17 and arg_132_1.time_ < var_135_16 + var_135_17 + arg_135_0 then
				var_135_15.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_135_22 = manager.ui.mainCamera.transform.position - var_135_15.position

				var_135_15.forward = Vector3.New(var_135_22.x, var_135_22.y, var_135_22.z)

				local var_135_23 = var_135_15.localEulerAngles

				var_135_23.z = 0
				var_135_23.x = 0
				var_135_15.localEulerAngles = var_135_23
			end

			local var_135_24 = arg_132_1.actors_["1095ui_story"]
			local var_135_25 = 0

			if var_135_25 < arg_132_1.time_ and arg_132_1.time_ <= var_135_25 + arg_135_0 and not isNil(var_135_24) and arg_132_1.var_.characterEffect1095ui_story == nil then
				arg_132_1.var_.characterEffect1095ui_story = var_135_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_26 = 0.200000002980232

			if var_135_25 <= arg_132_1.time_ and arg_132_1.time_ < var_135_25 + var_135_26 and not isNil(var_135_24) then
				local var_135_27 = (arg_132_1.time_ - var_135_25) / var_135_26

				if arg_132_1.var_.characterEffect1095ui_story and not isNil(var_135_24) then
					local var_135_28 = Mathf.Lerp(0, 0.5, var_135_27)

					arg_132_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_132_1.var_.characterEffect1095ui_story.fillRatio = var_135_28
				end
			end

			if arg_132_1.time_ >= var_135_25 + var_135_26 and arg_132_1.time_ < var_135_25 + var_135_26 + arg_135_0 and not isNil(var_135_24) and arg_132_1.var_.characterEffect1095ui_story then
				local var_135_29 = 0.5

				arg_132_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_132_1.var_.characterEffect1095ui_story.fillRatio = var_135_29
			end

			local var_135_30 = 0
			local var_135_31 = 0.3

			if var_135_30 < arg_132_1.time_ and arg_132_1.time_ <= var_135_30 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_32 = arg_132_1:FormatText(StoryNameCfg[6].name)

				arg_132_1.leftNameTxt_.text = var_135_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_33 = arg_132_1:GetWordFromCfg(319351031)
				local var_135_34 = arg_132_1:FormatText(var_135_33.content)

				arg_132_1.text_.text = var_135_34

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_35 = 12
				local var_135_36 = utf8.len(var_135_34)
				local var_135_37 = var_135_35 <= 0 and var_135_31 or var_135_31 * (var_135_36 / var_135_35)

				if var_135_37 > 0 and var_135_31 < var_135_37 then
					arg_132_1.talkMaxDuration = var_135_37

					if var_135_37 + var_135_30 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_37 + var_135_30
					end
				end

				arg_132_1.text_.text = var_135_34
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319351", "319351031", "story_v_out_319351.awb") ~= 0 then
					local var_135_38 = manager.audio:GetVoiceLength("story_v_out_319351", "319351031", "story_v_out_319351.awb") / 1000

					if var_135_38 + var_135_30 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_38 + var_135_30
					end

					if var_135_33.prefab_name ~= "" and arg_132_1.actors_[var_135_33.prefab_name] ~= nil then
						local var_135_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_33.prefab_name].transform, "story_v_out_319351", "319351031", "story_v_out_319351.awb")

						arg_132_1:RecordAudio("319351031", var_135_39)
						arg_132_1:RecordAudio("319351031", var_135_39)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_319351", "319351031", "story_v_out_319351.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_319351", "319351031", "story_v_out_319351.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_40 = math.max(var_135_31, arg_132_1.talkMaxDuration)

			if var_135_30 <= arg_132_1.time_ and arg_132_1.time_ < var_135_30 + var_135_40 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_30) / var_135_40

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_30 + var_135_40 and arg_132_1.time_ < var_135_30 + var_135_40 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
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
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_132_1:InitPlayNodeList()
	end,
	Play319351032 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 319351032
		arg_136_1.duration_ = 2.03

		local var_136_0 = {
			zh = 1.7,
			ja = 2.033
		}
		local var_136_1 = manager.audio:GetLocalizationFlag()

		if var_136_0[var_136_1] ~= nil then
			arg_136_1.duration_ = var_136_0[var_136_1]
		end

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play319351033(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = arg_136_1.actors_["1084ui_story"]
			local var_139_1 = 0

			if var_139_1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect1084ui_story == nil then
				arg_136_1.var_.characterEffect1084ui_story = var_139_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_2 = 0.200000002980232

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_2 and not isNil(var_139_0) then
				local var_139_3 = (arg_136_1.time_ - var_139_1) / var_139_2

				if arg_136_1.var_.characterEffect1084ui_story and not isNil(var_139_0) then
					local var_139_4 = Mathf.Lerp(0, 0.5, var_139_3)

					arg_136_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_136_1.var_.characterEffect1084ui_story.fillRatio = var_139_4
				end
			end

			if arg_136_1.time_ >= var_139_1 + var_139_2 and arg_136_1.time_ < var_139_1 + var_139_2 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect1084ui_story then
				local var_139_5 = 0.5

				arg_136_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_136_1.var_.characterEffect1084ui_story.fillRatio = var_139_5
			end

			local var_139_6 = arg_136_1.actors_["1095ui_story"]
			local var_139_7 = 0

			if var_139_7 < arg_136_1.time_ and arg_136_1.time_ <= var_139_7 + arg_139_0 and not isNil(var_139_6) and arg_136_1.var_.characterEffect1095ui_story == nil then
				arg_136_1.var_.characterEffect1095ui_story = var_139_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_8 = 0.200000002980232

			if var_139_7 <= arg_136_1.time_ and arg_136_1.time_ < var_139_7 + var_139_8 and not isNil(var_139_6) then
				local var_139_9 = (arg_136_1.time_ - var_139_7) / var_139_8

				if arg_136_1.var_.characterEffect1095ui_story and not isNil(var_139_6) then
					arg_136_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= var_139_7 + var_139_8 and arg_136_1.time_ < var_139_7 + var_139_8 + arg_139_0 and not isNil(var_139_6) and arg_136_1.var_.characterEffect1095ui_story then
				arg_136_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_139_10 = 0
			local var_139_11 = 0.125

			if var_139_10 < arg_136_1.time_ and arg_136_1.time_ <= var_139_10 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_12 = arg_136_1:FormatText(StoryNameCfg[471].name)

				arg_136_1.leftNameTxt_.text = var_139_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_13 = arg_136_1:GetWordFromCfg(319351032)
				local var_139_14 = arg_136_1:FormatText(var_139_13.content)

				arg_136_1.text_.text = var_139_14

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_15 = 5
				local var_139_16 = utf8.len(var_139_14)
				local var_139_17 = var_139_15 <= 0 and var_139_11 or var_139_11 * (var_139_16 / var_139_15)

				if var_139_17 > 0 and var_139_11 < var_139_17 then
					arg_136_1.talkMaxDuration = var_139_17

					if var_139_17 + var_139_10 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_17 + var_139_10
					end
				end

				arg_136_1.text_.text = var_139_14
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319351", "319351032", "story_v_out_319351.awb") ~= 0 then
					local var_139_18 = manager.audio:GetVoiceLength("story_v_out_319351", "319351032", "story_v_out_319351.awb") / 1000

					if var_139_18 + var_139_10 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_18 + var_139_10
					end

					if var_139_13.prefab_name ~= "" and arg_136_1.actors_[var_139_13.prefab_name] ~= nil then
						local var_139_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_13.prefab_name].transform, "story_v_out_319351", "319351032", "story_v_out_319351.awb")

						arg_136_1:RecordAudio("319351032", var_139_19)
						arg_136_1:RecordAudio("319351032", var_139_19)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_319351", "319351032", "story_v_out_319351.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_319351", "319351032", "story_v_out_319351.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_20 = math.max(var_139_11, arg_136_1.talkMaxDuration)

			if var_139_10 <= arg_136_1.time_ and arg_136_1.time_ < var_139_10 + var_139_20 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_10) / var_139_20

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_10 + var_139_20 and arg_136_1.time_ < var_139_10 + var_139_20 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play319351033 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 319351033
		arg_140_1.duration_ = 6.4

		local var_140_0 = {
			zh = 1.999999999999,
			ja = 6.4
		}
		local var_140_1 = manager.audio:GetLocalizationFlag()

		if var_140_0[var_140_1] ~= nil then
			arg_140_1.duration_ = var_140_0[var_140_1]
		end

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play319351034(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = arg_140_1.actors_["1084ui_story"]
			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect1084ui_story == nil then
				arg_140_1.var_.characterEffect1084ui_story = var_143_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_2 = 0.200000002980232

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_2 and not isNil(var_143_0) then
				local var_143_3 = (arg_140_1.time_ - var_143_1) / var_143_2

				if arg_140_1.var_.characterEffect1084ui_story and not isNil(var_143_0) then
					arg_140_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_140_1.time_ >= var_143_1 + var_143_2 and arg_140_1.time_ < var_143_1 + var_143_2 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect1084ui_story then
				arg_140_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_143_4 = 0

			if var_143_4 < arg_140_1.time_ and arg_140_1.time_ <= var_143_4 + arg_143_0 then
				arg_140_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action478")
			end

			local var_143_5 = 0

			if var_143_5 < arg_140_1.time_ and arg_140_1.time_ <= var_143_5 + arg_143_0 then
				arg_140_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_143_6 = arg_140_1.actors_["1095ui_story"]
			local var_143_7 = 0

			if var_143_7 < arg_140_1.time_ and arg_140_1.time_ <= var_143_7 + arg_143_0 and not isNil(var_143_6) and arg_140_1.var_.characterEffect1095ui_story == nil then
				arg_140_1.var_.characterEffect1095ui_story = var_143_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_8 = 0.200000002980232

			if var_143_7 <= arg_140_1.time_ and arg_140_1.time_ < var_143_7 + var_143_8 and not isNil(var_143_6) then
				local var_143_9 = (arg_140_1.time_ - var_143_7) / var_143_8

				if arg_140_1.var_.characterEffect1095ui_story and not isNil(var_143_6) then
					local var_143_10 = Mathf.Lerp(0, 0.5, var_143_9)

					arg_140_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_140_1.var_.characterEffect1095ui_story.fillRatio = var_143_10
				end
			end

			if arg_140_1.time_ >= var_143_7 + var_143_8 and arg_140_1.time_ < var_143_7 + var_143_8 + arg_143_0 and not isNil(var_143_6) and arg_140_1.var_.characterEffect1095ui_story then
				local var_143_11 = 0.5

				arg_140_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_140_1.var_.characterEffect1095ui_story.fillRatio = var_143_11
			end

			local var_143_12 = 0
			local var_143_13 = 0.2

			if var_143_12 < arg_140_1.time_ and arg_140_1.time_ <= var_143_12 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_14 = arg_140_1:FormatText(StoryNameCfg[6].name)

				arg_140_1.leftNameTxt_.text = var_143_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_15 = arg_140_1:GetWordFromCfg(319351033)
				local var_143_16 = arg_140_1:FormatText(var_143_15.content)

				arg_140_1.text_.text = var_143_16

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_17 = 8
				local var_143_18 = utf8.len(var_143_16)
				local var_143_19 = var_143_17 <= 0 and var_143_13 or var_143_13 * (var_143_18 / var_143_17)

				if var_143_19 > 0 and var_143_13 < var_143_19 then
					arg_140_1.talkMaxDuration = var_143_19

					if var_143_19 + var_143_12 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_19 + var_143_12
					end
				end

				arg_140_1.text_.text = var_143_16
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319351", "319351033", "story_v_out_319351.awb") ~= 0 then
					local var_143_20 = manager.audio:GetVoiceLength("story_v_out_319351", "319351033", "story_v_out_319351.awb") / 1000

					if var_143_20 + var_143_12 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_20 + var_143_12
					end

					if var_143_15.prefab_name ~= "" and arg_140_1.actors_[var_143_15.prefab_name] ~= nil then
						local var_143_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_15.prefab_name].transform, "story_v_out_319351", "319351033", "story_v_out_319351.awb")

						arg_140_1:RecordAudio("319351033", var_143_21)
						arg_140_1:RecordAudio("319351033", var_143_21)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_319351", "319351033", "story_v_out_319351.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_319351", "319351033", "story_v_out_319351.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_22 = math.max(var_143_13, arg_140_1.talkMaxDuration)

			if var_143_12 <= arg_140_1.time_ and arg_140_1.time_ < var_143_12 + var_143_22 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_12) / var_143_22

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_12 + var_143_22 and arg_140_1.time_ < var_143_12 + var_143_22 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play319351034 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 319351034
		arg_144_1.duration_ = 12.27

		local var_144_0 = {
			zh = 8.833,
			ja = 12.266
		}
		local var_144_1 = manager.audio:GetLocalizationFlag()

		if var_144_0[var_144_1] ~= nil then
			arg_144_1.duration_ = var_144_0[var_144_1]
		end

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play319351035(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = arg_144_1.actors_["1084ui_story"]
			local var_147_1 = 0

			if var_147_1 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.characterEffect1084ui_story == nil then
				arg_144_1.var_.characterEffect1084ui_story = var_147_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_2 = 0.200000002980232

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_2 and not isNil(var_147_0) then
				local var_147_3 = (arg_144_1.time_ - var_147_1) / var_147_2

				if arg_144_1.var_.characterEffect1084ui_story and not isNil(var_147_0) then
					local var_147_4 = Mathf.Lerp(0, 0.5, var_147_3)

					arg_144_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_144_1.var_.characterEffect1084ui_story.fillRatio = var_147_4
				end
			end

			if arg_144_1.time_ >= var_147_1 + var_147_2 and arg_144_1.time_ < var_147_1 + var_147_2 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.characterEffect1084ui_story then
				local var_147_5 = 0.5

				arg_144_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_144_1.var_.characterEffect1084ui_story.fillRatio = var_147_5
			end

			local var_147_6 = arg_144_1.actors_["1095ui_story"]
			local var_147_7 = 0

			if var_147_7 < arg_144_1.time_ and arg_144_1.time_ <= var_147_7 + arg_147_0 and not isNil(var_147_6) and arg_144_1.var_.characterEffect1095ui_story == nil then
				arg_144_1.var_.characterEffect1095ui_story = var_147_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_8 = 0.200000002980232

			if var_147_7 <= arg_144_1.time_ and arg_144_1.time_ < var_147_7 + var_147_8 and not isNil(var_147_6) then
				local var_147_9 = (arg_144_1.time_ - var_147_7) / var_147_8

				if arg_144_1.var_.characterEffect1095ui_story and not isNil(var_147_6) then
					arg_144_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_144_1.time_ >= var_147_7 + var_147_8 and arg_144_1.time_ < var_147_7 + var_147_8 + arg_147_0 and not isNil(var_147_6) and arg_144_1.var_.characterEffect1095ui_story then
				arg_144_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_147_10 = 0
			local var_147_11 = 1.125

			if var_147_10 < arg_144_1.time_ and arg_144_1.time_ <= var_147_10 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_12 = arg_144_1:FormatText(StoryNameCfg[471].name)

				arg_144_1.leftNameTxt_.text = var_147_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_13 = arg_144_1:GetWordFromCfg(319351034)
				local var_147_14 = arg_144_1:FormatText(var_147_13.content)

				arg_144_1.text_.text = var_147_14

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_15 = 45
				local var_147_16 = utf8.len(var_147_14)
				local var_147_17 = var_147_15 <= 0 and var_147_11 or var_147_11 * (var_147_16 / var_147_15)

				if var_147_17 > 0 and var_147_11 < var_147_17 then
					arg_144_1.talkMaxDuration = var_147_17

					if var_147_17 + var_147_10 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_17 + var_147_10
					end
				end

				arg_144_1.text_.text = var_147_14
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319351", "319351034", "story_v_out_319351.awb") ~= 0 then
					local var_147_18 = manager.audio:GetVoiceLength("story_v_out_319351", "319351034", "story_v_out_319351.awb") / 1000

					if var_147_18 + var_147_10 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_18 + var_147_10
					end

					if var_147_13.prefab_name ~= "" and arg_144_1.actors_[var_147_13.prefab_name] ~= nil then
						local var_147_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_13.prefab_name].transform, "story_v_out_319351", "319351034", "story_v_out_319351.awb")

						arg_144_1:RecordAudio("319351034", var_147_19)
						arg_144_1:RecordAudio("319351034", var_147_19)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_319351", "319351034", "story_v_out_319351.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_319351", "319351034", "story_v_out_319351.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_20 = math.max(var_147_11, arg_144_1.talkMaxDuration)

			if var_147_10 <= arg_144_1.time_ and arg_144_1.time_ < var_147_10 + var_147_20 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_10) / var_147_20

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_10 + var_147_20 and arg_144_1.time_ < var_147_10 + var_147_20 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play319351035 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 319351035
		arg_148_1.duration_ = 14.2

		local var_148_0 = {
			zh = 4.666,
			ja = 14.2
		}
		local var_148_1 = manager.audio:GetLocalizationFlag()

		if var_148_0[var_148_1] ~= nil then
			arg_148_1.duration_ = var_148_0[var_148_1]
		end

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play319351036(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = 0

			if var_151_0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_0 + arg_151_0 then
				arg_148_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_1")
			end

			local var_151_1 = 0

			if var_151_1 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 then
				arg_148_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_151_2 = 0
			local var_151_3 = 0.55

			if var_151_2 < arg_148_1.time_ and arg_148_1.time_ <= var_151_2 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				local var_151_4 = arg_148_1:FormatText(StoryNameCfg[471].name)

				arg_148_1.leftNameTxt_.text = var_151_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_5 = arg_148_1:GetWordFromCfg(319351035)
				local var_151_6 = arg_148_1:FormatText(var_151_5.content)

				arg_148_1.text_.text = var_151_6

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_7 = 22
				local var_151_8 = utf8.len(var_151_6)
				local var_151_9 = var_151_7 <= 0 and var_151_3 or var_151_3 * (var_151_8 / var_151_7)

				if var_151_9 > 0 and var_151_3 < var_151_9 then
					arg_148_1.talkMaxDuration = var_151_9

					if var_151_9 + var_151_2 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_9 + var_151_2
					end
				end

				arg_148_1.text_.text = var_151_6
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319351", "319351035", "story_v_out_319351.awb") ~= 0 then
					local var_151_10 = manager.audio:GetVoiceLength("story_v_out_319351", "319351035", "story_v_out_319351.awb") / 1000

					if var_151_10 + var_151_2 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_10 + var_151_2
					end

					if var_151_5.prefab_name ~= "" and arg_148_1.actors_[var_151_5.prefab_name] ~= nil then
						local var_151_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_5.prefab_name].transform, "story_v_out_319351", "319351035", "story_v_out_319351.awb")

						arg_148_1:RecordAudio("319351035", var_151_11)
						arg_148_1:RecordAudio("319351035", var_151_11)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_319351", "319351035", "story_v_out_319351.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_319351", "319351035", "story_v_out_319351.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_12 = math.max(var_151_3, arg_148_1.talkMaxDuration)

			if var_151_2 <= arg_148_1.time_ and arg_148_1.time_ < var_151_2 + var_151_12 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_2) / var_151_12

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_2 + var_151_12 and arg_148_1.time_ < var_151_2 + var_151_12 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play319351036 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 319351036
		arg_152_1.duration_ = 2.03

		local var_152_0 = {
			zh = 1.999999999999,
			ja = 2.033
		}
		local var_152_1 = manager.audio:GetLocalizationFlag()

		if var_152_0[var_152_1] ~= nil then
			arg_152_1.duration_ = var_152_0[var_152_1]
		end

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play319351037(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = arg_152_1.actors_["1084ui_story"]
			local var_155_1 = 0

			if var_155_1 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 and not isNil(var_155_0) and arg_152_1.var_.characterEffect1084ui_story == nil then
				arg_152_1.var_.characterEffect1084ui_story = var_155_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_2 = 0.200000002980232

			if var_155_1 <= arg_152_1.time_ and arg_152_1.time_ < var_155_1 + var_155_2 and not isNil(var_155_0) then
				local var_155_3 = (arg_152_1.time_ - var_155_1) / var_155_2

				if arg_152_1.var_.characterEffect1084ui_story and not isNil(var_155_0) then
					arg_152_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= var_155_1 + var_155_2 and arg_152_1.time_ < var_155_1 + var_155_2 + arg_155_0 and not isNil(var_155_0) and arg_152_1.var_.characterEffect1084ui_story then
				arg_152_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_155_4 = arg_152_1.actors_["1095ui_story"]
			local var_155_5 = 0

			if var_155_5 < arg_152_1.time_ and arg_152_1.time_ <= var_155_5 + arg_155_0 and not isNil(var_155_4) and arg_152_1.var_.characterEffect1095ui_story == nil then
				arg_152_1.var_.characterEffect1095ui_story = var_155_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_6 = 0.200000002980232

			if var_155_5 <= arg_152_1.time_ and arg_152_1.time_ < var_155_5 + var_155_6 and not isNil(var_155_4) then
				local var_155_7 = (arg_152_1.time_ - var_155_5) / var_155_6

				if arg_152_1.var_.characterEffect1095ui_story and not isNil(var_155_4) then
					local var_155_8 = Mathf.Lerp(0, 0.5, var_155_7)

					arg_152_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_152_1.var_.characterEffect1095ui_story.fillRatio = var_155_8
				end
			end

			if arg_152_1.time_ >= var_155_5 + var_155_6 and arg_152_1.time_ < var_155_5 + var_155_6 + arg_155_0 and not isNil(var_155_4) and arg_152_1.var_.characterEffect1095ui_story then
				local var_155_9 = 0.5

				arg_152_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_152_1.var_.characterEffect1095ui_story.fillRatio = var_155_9
			end

			local var_155_10 = 0

			if var_155_10 < arg_152_1.time_ and arg_152_1.time_ <= var_155_10 + arg_155_0 then
				arg_152_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_2")
			end

			local var_155_11 = 0

			if var_155_11 < arg_152_1.time_ and arg_152_1.time_ <= var_155_11 + arg_155_0 then
				arg_152_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_155_12 = 0
			local var_155_13 = 0.075

			if var_155_12 < arg_152_1.time_ and arg_152_1.time_ <= var_155_12 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_14 = arg_152_1:FormatText(StoryNameCfg[6].name)

				arg_152_1.leftNameTxt_.text = var_155_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_15 = arg_152_1:GetWordFromCfg(319351036)
				local var_155_16 = arg_152_1:FormatText(var_155_15.content)

				arg_152_1.text_.text = var_155_16

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_17 = 3
				local var_155_18 = utf8.len(var_155_16)
				local var_155_19 = var_155_17 <= 0 and var_155_13 or var_155_13 * (var_155_18 / var_155_17)

				if var_155_19 > 0 and var_155_13 < var_155_19 then
					arg_152_1.talkMaxDuration = var_155_19

					if var_155_19 + var_155_12 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_19 + var_155_12
					end
				end

				arg_152_1.text_.text = var_155_16
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319351", "319351036", "story_v_out_319351.awb") ~= 0 then
					local var_155_20 = manager.audio:GetVoiceLength("story_v_out_319351", "319351036", "story_v_out_319351.awb") / 1000

					if var_155_20 + var_155_12 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_20 + var_155_12
					end

					if var_155_15.prefab_name ~= "" and arg_152_1.actors_[var_155_15.prefab_name] ~= nil then
						local var_155_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_15.prefab_name].transform, "story_v_out_319351", "319351036", "story_v_out_319351.awb")

						arg_152_1:RecordAudio("319351036", var_155_21)
						arg_152_1:RecordAudio("319351036", var_155_21)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_319351", "319351036", "story_v_out_319351.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_319351", "319351036", "story_v_out_319351.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_22 = math.max(var_155_13, arg_152_1.talkMaxDuration)

			if var_155_12 <= arg_152_1.time_ and arg_152_1.time_ < var_155_12 + var_155_22 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_12) / var_155_22

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_12 + var_155_22 and arg_152_1.time_ < var_155_12 + var_155_22 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play319351037 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 319351037
		arg_156_1.duration_ = 5.9

		local var_156_0 = {
			zh = 5.9,
			ja = 5.666
		}
		local var_156_1 = manager.audio:GetLocalizationFlag()

		if var_156_0[var_156_1] ~= nil then
			arg_156_1.duration_ = var_156_0[var_156_1]
		end

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play319351038(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = arg_156_1.actors_["1095ui_story"]
			local var_159_1 = 0

			if var_159_1 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 and not isNil(var_159_0) and arg_156_1.var_.characterEffect1095ui_story == nil then
				arg_156_1.var_.characterEffect1095ui_story = var_159_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_2 = 0.200000002980232

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_2 and not isNil(var_159_0) then
				local var_159_3 = (arg_156_1.time_ - var_159_1) / var_159_2

				if arg_156_1.var_.characterEffect1095ui_story and not isNil(var_159_0) then
					arg_156_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_156_1.time_ >= var_159_1 + var_159_2 and arg_156_1.time_ < var_159_1 + var_159_2 + arg_159_0 and not isNil(var_159_0) and arg_156_1.var_.characterEffect1095ui_story then
				arg_156_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_159_4 = arg_156_1.actors_["1084ui_story"]
			local var_159_5 = 0

			if var_159_5 < arg_156_1.time_ and arg_156_1.time_ <= var_159_5 + arg_159_0 and not isNil(var_159_4) and arg_156_1.var_.characterEffect1084ui_story == nil then
				arg_156_1.var_.characterEffect1084ui_story = var_159_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_6 = 0.200000002980232

			if var_159_5 <= arg_156_1.time_ and arg_156_1.time_ < var_159_5 + var_159_6 and not isNil(var_159_4) then
				local var_159_7 = (arg_156_1.time_ - var_159_5) / var_159_6

				if arg_156_1.var_.characterEffect1084ui_story and not isNil(var_159_4) then
					local var_159_8 = Mathf.Lerp(0, 0.5, var_159_7)

					arg_156_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_156_1.var_.characterEffect1084ui_story.fillRatio = var_159_8
				end
			end

			if arg_156_1.time_ >= var_159_5 + var_159_6 and arg_156_1.time_ < var_159_5 + var_159_6 + arg_159_0 and not isNil(var_159_4) and arg_156_1.var_.characterEffect1084ui_story then
				local var_159_9 = 0.5

				arg_156_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_156_1.var_.characterEffect1084ui_story.fillRatio = var_159_9
			end

			local var_159_10 = 0
			local var_159_11 = 0.65

			if var_159_10 < arg_156_1.time_ and arg_156_1.time_ <= var_159_10 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_12 = arg_156_1:FormatText(StoryNameCfg[471].name)

				arg_156_1.leftNameTxt_.text = var_159_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_13 = arg_156_1:GetWordFromCfg(319351037)
				local var_159_14 = arg_156_1:FormatText(var_159_13.content)

				arg_156_1.text_.text = var_159_14

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_15 = 26
				local var_159_16 = utf8.len(var_159_14)
				local var_159_17 = var_159_15 <= 0 and var_159_11 or var_159_11 * (var_159_16 / var_159_15)

				if var_159_17 > 0 and var_159_11 < var_159_17 then
					arg_156_1.talkMaxDuration = var_159_17

					if var_159_17 + var_159_10 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_17 + var_159_10
					end
				end

				arg_156_1.text_.text = var_159_14
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319351", "319351037", "story_v_out_319351.awb") ~= 0 then
					local var_159_18 = manager.audio:GetVoiceLength("story_v_out_319351", "319351037", "story_v_out_319351.awb") / 1000

					if var_159_18 + var_159_10 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_18 + var_159_10
					end

					if var_159_13.prefab_name ~= "" and arg_156_1.actors_[var_159_13.prefab_name] ~= nil then
						local var_159_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_13.prefab_name].transform, "story_v_out_319351", "319351037", "story_v_out_319351.awb")

						arg_156_1:RecordAudio("319351037", var_159_19)
						arg_156_1:RecordAudio("319351037", var_159_19)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_319351", "319351037", "story_v_out_319351.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_319351", "319351037", "story_v_out_319351.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_20 = math.max(var_159_11, arg_156_1.talkMaxDuration)

			if var_159_10 <= arg_156_1.time_ and arg_156_1.time_ < var_159_10 + var_159_20 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_10) / var_159_20

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_10 + var_159_20 and arg_156_1.time_ < var_159_10 + var_159_20 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play319351038 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 319351038
		arg_160_1.duration_ = 4.4

		local var_160_0 = {
			zh = 3.933,
			ja = 4.4
		}
		local var_160_1 = manager.audio:GetLocalizationFlag()

		if var_160_0[var_160_1] ~= nil then
			arg_160_1.duration_ = var_160_0[var_160_1]
		end

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play319351039(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = 0
			local var_163_1 = 0.525

			if var_163_0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_0 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				local var_163_2 = arg_160_1:FormatText(StoryNameCfg[471].name)

				arg_160_1.leftNameTxt_.text = var_163_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_3 = arg_160_1:GetWordFromCfg(319351038)
				local var_163_4 = arg_160_1:FormatText(var_163_3.content)

				arg_160_1.text_.text = var_163_4

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_5 = 21
				local var_163_6 = utf8.len(var_163_4)
				local var_163_7 = var_163_5 <= 0 and var_163_1 or var_163_1 * (var_163_6 / var_163_5)

				if var_163_7 > 0 and var_163_1 < var_163_7 then
					arg_160_1.talkMaxDuration = var_163_7

					if var_163_7 + var_163_0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_7 + var_163_0
					end
				end

				arg_160_1.text_.text = var_163_4
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319351", "319351038", "story_v_out_319351.awb") ~= 0 then
					local var_163_8 = manager.audio:GetVoiceLength("story_v_out_319351", "319351038", "story_v_out_319351.awb") / 1000

					if var_163_8 + var_163_0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_8 + var_163_0
					end

					if var_163_3.prefab_name ~= "" and arg_160_1.actors_[var_163_3.prefab_name] ~= nil then
						local var_163_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_3.prefab_name].transform, "story_v_out_319351", "319351038", "story_v_out_319351.awb")

						arg_160_1:RecordAudio("319351038", var_163_9)
						arg_160_1:RecordAudio("319351038", var_163_9)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_319351", "319351038", "story_v_out_319351.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_319351", "319351038", "story_v_out_319351.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_10 = math.max(var_163_1, arg_160_1.talkMaxDuration)

			if var_163_0 <= arg_160_1.time_ and arg_160_1.time_ < var_163_0 + var_163_10 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_0) / var_163_10

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_0 + var_163_10 and arg_160_1.time_ < var_163_0 + var_163_10 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play319351039 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 319351039
		arg_164_1.duration_ = 7.63

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play319351040(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = 1.36666666666667

			if var_167_0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_0 + arg_167_0 then
				local var_167_1 = manager.ui.mainCamera.transform.localPosition
				local var_167_2 = Vector3.New(0, 0, 10) + Vector3.New(var_167_1.x, var_167_1.y, 0)
				local var_167_3 = arg_164_1.bgs_.STblack

				var_167_3.transform.localPosition = var_167_2
				var_167_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_167_4 = var_167_3:GetComponent("SpriteRenderer")

				if var_167_4 and var_167_4.sprite then
					local var_167_5 = (var_167_3.transform.localPosition - var_167_1).z
					local var_167_6 = manager.ui.mainCameraCom_
					local var_167_7 = 2 * var_167_5 * Mathf.Tan(var_167_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_167_8 = var_167_7 * var_167_6.aspect
					local var_167_9 = var_167_4.sprite.bounds.size.x
					local var_167_10 = var_167_4.sprite.bounds.size.y
					local var_167_11 = var_167_8 / var_167_9
					local var_167_12 = var_167_7 / var_167_10
					local var_167_13 = var_167_12 < var_167_11 and var_167_11 or var_167_12

					var_167_3.transform.localScale = Vector3.New(var_167_13, var_167_13, 0)
				end

				for iter_167_0, iter_167_1 in pairs(arg_164_1.bgs_) do
					if iter_167_0 ~= "STblack" then
						iter_167_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_167_14 = 0

			if var_167_14 < arg_164_1.time_ and arg_164_1.time_ <= var_167_14 + arg_167_0 then
				arg_164_1.mask_.enabled = true
				arg_164_1.mask_.raycastTarget = true

				arg_164_1:SetGaussion(false)
			end

			local var_167_15 = 1.36666666666667

			if var_167_14 <= arg_164_1.time_ and arg_164_1.time_ < var_167_14 + var_167_15 then
				local var_167_16 = (arg_164_1.time_ - var_167_14) / var_167_15
				local var_167_17 = Color.New(0, 0, 0)

				var_167_17.a = Mathf.Lerp(0, 1, var_167_16)
				arg_164_1.mask_.color = var_167_17
			end

			if arg_164_1.time_ >= var_167_14 + var_167_15 and arg_164_1.time_ < var_167_14 + var_167_15 + arg_167_0 then
				local var_167_18 = Color.New(0, 0, 0)

				var_167_18.a = 1
				arg_164_1.mask_.color = var_167_18
			end

			local var_167_19 = 1.36666666666667

			if var_167_19 < arg_164_1.time_ and arg_164_1.time_ <= var_167_19 + arg_167_0 then
				arg_164_1.mask_.enabled = true
				arg_164_1.mask_.raycastTarget = true

				arg_164_1:SetGaussion(false)
			end

			local var_167_20 = 1.26666666666667

			if var_167_19 <= arg_164_1.time_ and arg_164_1.time_ < var_167_19 + var_167_20 then
				local var_167_21 = (arg_164_1.time_ - var_167_19) / var_167_20
				local var_167_22 = Color.New(0, 0, 0)

				var_167_22.a = Mathf.Lerp(1, 0, var_167_21)
				arg_164_1.mask_.color = var_167_22
			end

			if arg_164_1.time_ >= var_167_19 + var_167_20 and arg_164_1.time_ < var_167_19 + var_167_20 + arg_167_0 then
				local var_167_23 = Color.New(0, 0, 0)
				local var_167_24 = 0

				arg_164_1.mask_.enabled = false
				var_167_23.a = var_167_24
				arg_164_1.mask_.color = var_167_23
			end

			local var_167_25 = arg_164_1.actors_["1095ui_story"].transform
			local var_167_26 = 1.36666666666667

			if var_167_26 < arg_164_1.time_ and arg_164_1.time_ <= var_167_26 + arg_167_0 then
				arg_164_1.var_.moveOldPos1095ui_story = var_167_25.localPosition
			end

			local var_167_27 = 0.001

			if var_167_26 <= arg_164_1.time_ and arg_164_1.time_ < var_167_26 + var_167_27 then
				local var_167_28 = (arg_164_1.time_ - var_167_26) / var_167_27
				local var_167_29 = Vector3.New(0, 100, 0)

				var_167_25.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos1095ui_story, var_167_29, var_167_28)

				local var_167_30 = manager.ui.mainCamera.transform.position - var_167_25.position

				var_167_25.forward = Vector3.New(var_167_30.x, var_167_30.y, var_167_30.z)

				local var_167_31 = var_167_25.localEulerAngles

				var_167_31.z = 0
				var_167_31.x = 0
				var_167_25.localEulerAngles = var_167_31
			end

			if arg_164_1.time_ >= var_167_26 + var_167_27 and arg_164_1.time_ < var_167_26 + var_167_27 + arg_167_0 then
				var_167_25.localPosition = Vector3.New(0, 100, 0)

				local var_167_32 = manager.ui.mainCamera.transform.position - var_167_25.position

				var_167_25.forward = Vector3.New(var_167_32.x, var_167_32.y, var_167_32.z)

				local var_167_33 = var_167_25.localEulerAngles

				var_167_33.z = 0
				var_167_33.x = 0
				var_167_25.localEulerAngles = var_167_33
			end

			local var_167_34 = arg_164_1.actors_["1084ui_story"].transform
			local var_167_35 = 1.36666666666667

			if var_167_35 < arg_164_1.time_ and arg_164_1.time_ <= var_167_35 + arg_167_0 then
				arg_164_1.var_.moveOldPos1084ui_story = var_167_34.localPosition
			end

			local var_167_36 = 0.001

			if var_167_35 <= arg_164_1.time_ and arg_164_1.time_ < var_167_35 + var_167_36 then
				local var_167_37 = (arg_164_1.time_ - var_167_35) / var_167_36
				local var_167_38 = Vector3.New(0, 100, 0)

				var_167_34.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos1084ui_story, var_167_38, var_167_37)

				local var_167_39 = manager.ui.mainCamera.transform.position - var_167_34.position

				var_167_34.forward = Vector3.New(var_167_39.x, var_167_39.y, var_167_39.z)

				local var_167_40 = var_167_34.localEulerAngles

				var_167_40.z = 0
				var_167_40.x = 0
				var_167_34.localEulerAngles = var_167_40
			end

			if arg_164_1.time_ >= var_167_35 + var_167_36 and arg_164_1.time_ < var_167_35 + var_167_36 + arg_167_0 then
				var_167_34.localPosition = Vector3.New(0, 100, 0)

				local var_167_41 = manager.ui.mainCamera.transform.position - var_167_34.position

				var_167_34.forward = Vector3.New(var_167_41.x, var_167_41.y, var_167_41.z)

				local var_167_42 = var_167_34.localEulerAngles

				var_167_42.z = 0
				var_167_42.x = 0
				var_167_34.localEulerAngles = var_167_42
			end

			if arg_164_1.frameCnt_ <= 1 then
				arg_164_1.dialog_:SetActive(false)
			end

			local var_167_43 = 2.63333333333333
			local var_167_44 = 1.3

			if var_167_43 < arg_164_1.time_ and arg_164_1.time_ <= var_167_43 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0

				arg_164_1.dialog_:SetActive(true)

				arg_164_1.dialogCg_.alpha = 0

				local var_167_45 = LeanTween.value(arg_164_1.dialog_, 0, 1, 0.3)

				var_167_45:setOnUpdate(LuaHelper.FloatAction(function(arg_168_0)
					arg_164_1.dialogCg_.alpha = arg_168_0
				end))
				var_167_45:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_164_1.dialog_)
					var_167_45:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_164_1.duration_ = arg_164_1.duration_ + 0.3

				SetActive(arg_164_1.leftNameGo_, false)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_46 = arg_164_1:GetWordFromCfg(319351039)
				local var_167_47 = arg_164_1:FormatText(var_167_46.content)

				arg_164_1.text_.text = var_167_47

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_48 = 52
				local var_167_49 = utf8.len(var_167_47)
				local var_167_50 = var_167_48 <= 0 and var_167_44 or var_167_44 * (var_167_49 / var_167_48)

				if var_167_50 > 0 and var_167_44 < var_167_50 then
					arg_164_1.talkMaxDuration = var_167_50
					var_167_43 = var_167_43 + 0.3

					if var_167_50 + var_167_43 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_50 + var_167_43
					end
				end

				arg_164_1.text_.text = var_167_47
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)
				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_51 = var_167_43 + 0.3
			local var_167_52 = math.max(var_167_44, arg_164_1.talkMaxDuration)

			if var_167_51 <= arg_164_1.time_ and arg_164_1.time_ < var_167_51 + var_167_52 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_51) / var_167_52

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_51 + var_167_52 and arg_164_1.time_ < var_167_51 + var_167_52 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.36666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.36666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_164_1:InitPlayNodeList()
	end,
	Play319351040 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 319351040
		arg_170_1.duration_ = 5

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play319351041(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = 0
			local var_173_1 = 1.35

			if var_173_0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_0 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, false)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_2 = arg_170_1:GetWordFromCfg(319351040)
				local var_173_3 = arg_170_1:FormatText(var_173_2.content)

				arg_170_1.text_.text = var_173_3

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_4 = 54
				local var_173_5 = utf8.len(var_173_3)
				local var_173_6 = var_173_4 <= 0 and var_173_1 or var_173_1 * (var_173_5 / var_173_4)

				if var_173_6 > 0 and var_173_1 < var_173_6 then
					arg_170_1.talkMaxDuration = var_173_6

					if var_173_6 + var_173_0 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_6 + var_173_0
					end
				end

				arg_170_1.text_.text = var_173_3
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)
				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_7 = math.max(var_173_1, arg_170_1.talkMaxDuration)

			if var_173_0 <= arg_170_1.time_ and arg_170_1.time_ < var_173_0 + var_173_7 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_0) / var_173_7

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_0 + var_173_7 and arg_170_1.time_ < var_173_0 + var_173_7 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play319351041 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 319351041
		arg_174_1.duration_ = 6.83

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play319351042(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = 0

			if var_177_0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_0 + arg_177_0 then
				arg_174_1.mask_.enabled = true
				arg_174_1.mask_.raycastTarget = true

				arg_174_1:SetGaussion(false)
			end

			local var_177_1 = 0.7

			if var_177_0 <= arg_174_1.time_ and arg_174_1.time_ < var_177_0 + var_177_1 then
				local var_177_2 = (arg_174_1.time_ - var_177_0) / var_177_1
				local var_177_3 = Color.New(0.7924528, 0.4269517, 0.1084016)

				var_177_3.a = Mathf.Lerp(1, 0, var_177_2)
				arg_174_1.mask_.color = var_177_3
			end

			if arg_174_1.time_ >= var_177_0 + var_177_1 and arg_174_1.time_ < var_177_0 + var_177_1 + arg_177_0 then
				local var_177_4 = Color.New(0.7924528, 0.4269517, 0.1084016)
				local var_177_5 = 0

				arg_174_1.mask_.enabled = false
				var_177_4.a = var_177_5
				arg_174_1.mask_.color = var_177_4
			end

			local var_177_6 = 0.7

			if var_177_6 < arg_174_1.time_ and arg_174_1.time_ <= var_177_6 + arg_177_0 then
				arg_174_1.mask_.enabled = true
				arg_174_1.mask_.raycastTarget = true

				arg_174_1:SetGaussion(false)
			end

			local var_177_7 = 0.8

			if var_177_6 <= arg_174_1.time_ and arg_174_1.time_ < var_177_6 + var_177_7 then
				local var_177_8 = (arg_174_1.time_ - var_177_6) / var_177_7
				local var_177_9 = Color.New(0.7924528, 0.4269517, 0.1084016)

				var_177_9.a = Mathf.Lerp(1, 0, var_177_8)
				arg_174_1.mask_.color = var_177_9
			end

			if arg_174_1.time_ >= var_177_6 + var_177_7 and arg_174_1.time_ < var_177_6 + var_177_7 + arg_177_0 then
				local var_177_10 = Color.New(0.7924528, 0.4269517, 0.1084016)
				local var_177_11 = 0

				arg_174_1.mask_.enabled = false
				var_177_10.a = var_177_11
				arg_174_1.mask_.color = var_177_10
			end

			local var_177_12 = 1.83333333333333
			local var_177_13 = 0.975

			if var_177_12 < arg_174_1.time_ and arg_174_1.time_ <= var_177_12 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, false)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_14 = arg_174_1:GetWordFromCfg(319351041)
				local var_177_15 = arg_174_1:FormatText(var_177_14.content)

				arg_174_1.text_.text = var_177_15

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_16 = 39
				local var_177_17 = utf8.len(var_177_15)
				local var_177_18 = var_177_16 <= 0 and var_177_13 or var_177_13 * (var_177_17 / var_177_16)

				if var_177_18 > 0 and var_177_13 < var_177_18 then
					arg_174_1.talkMaxDuration = var_177_18

					if var_177_18 + var_177_12 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_18 + var_177_12
					end
				end

				arg_174_1.text_.text = var_177_15
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)
				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_19 = math.max(var_177_13, arg_174_1.talkMaxDuration)

			if var_177_12 <= arg_174_1.time_ and arg_174_1.time_ < var_177_12 + var_177_19 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_12) / var_177_19

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_12 + var_177_19 and arg_174_1.time_ < var_177_12 + var_177_19 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play319351042 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 319351042
		arg_178_1.duration_ = 5.26

		local var_178_0 = {
			zh = 5.258,
			ja = 5.058
		}
		local var_178_1 = manager.audio:GetLocalizationFlag()

		if var_178_0[var_178_1] ~= nil then
			arg_178_1.duration_ = var_178_0[var_178_1]
		end

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play319351043(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = arg_178_1.actors_["1084ui_story"]
			local var_181_1 = 3

			if var_181_1 < arg_178_1.time_ and arg_178_1.time_ <= var_181_1 + arg_181_0 and not isNil(var_181_0) and arg_178_1.var_.characterEffect1084ui_story == nil then
				arg_178_1.var_.characterEffect1084ui_story = var_181_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_2 = 0.200000002980232

			if var_181_1 <= arg_178_1.time_ and arg_178_1.time_ < var_181_1 + var_181_2 and not isNil(var_181_0) then
				local var_181_3 = (arg_178_1.time_ - var_181_1) / var_181_2

				if arg_178_1.var_.characterEffect1084ui_story and not isNil(var_181_0) then
					arg_178_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_178_1.time_ >= var_181_1 + var_181_2 and arg_178_1.time_ < var_181_1 + var_181_2 + arg_181_0 and not isNil(var_181_0) and arg_178_1.var_.characterEffect1084ui_story then
				arg_178_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_181_4 = 1

			if var_181_4 < arg_178_1.time_ and arg_178_1.time_ <= var_181_4 + arg_181_0 then
				local var_181_5 = manager.ui.mainCamera.transform.localPosition
				local var_181_6 = Vector3.New(0, 0, 10) + Vector3.New(var_181_5.x, var_181_5.y, 0)
				local var_181_7 = arg_178_1.bgs_.ST74

				var_181_7.transform.localPosition = var_181_6
				var_181_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_181_8 = var_181_7:GetComponent("SpriteRenderer")

				if var_181_8 and var_181_8.sprite then
					local var_181_9 = (var_181_7.transform.localPosition - var_181_5).z
					local var_181_10 = manager.ui.mainCameraCom_
					local var_181_11 = 2 * var_181_9 * Mathf.Tan(var_181_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_181_12 = var_181_11 * var_181_10.aspect
					local var_181_13 = var_181_8.sprite.bounds.size.x
					local var_181_14 = var_181_8.sprite.bounds.size.y
					local var_181_15 = var_181_12 / var_181_13
					local var_181_16 = var_181_11 / var_181_14
					local var_181_17 = var_181_16 < var_181_15 and var_181_15 or var_181_16

					var_181_7.transform.localScale = Vector3.New(var_181_17, var_181_17, 0)
				end

				for iter_181_0, iter_181_1 in pairs(arg_178_1.bgs_) do
					if iter_181_0 ~= "ST74" then
						iter_181_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_181_18 = 0

			if var_181_18 < arg_178_1.time_ and arg_178_1.time_ <= var_181_18 + arg_181_0 then
				arg_178_1.mask_.enabled = true
				arg_178_1.mask_.raycastTarget = true

				arg_178_1:SetGaussion(false)
			end

			local var_181_19 = 1

			if var_181_18 <= arg_178_1.time_ and arg_178_1.time_ < var_181_18 + var_181_19 then
				local var_181_20 = (arg_178_1.time_ - var_181_18) / var_181_19
				local var_181_21 = Color.New(0, 0, 0)

				var_181_21.a = Mathf.Lerp(0, 1, var_181_20)
				arg_178_1.mask_.color = var_181_21
			end

			if arg_178_1.time_ >= var_181_18 + var_181_19 and arg_178_1.time_ < var_181_18 + var_181_19 + arg_181_0 then
				local var_181_22 = Color.New(0, 0, 0)

				var_181_22.a = 1
				arg_178_1.mask_.color = var_181_22
			end

			local var_181_23 = 1

			if var_181_23 < arg_178_1.time_ and arg_178_1.time_ <= var_181_23 + arg_181_0 then
				arg_178_1.mask_.enabled = true
				arg_178_1.mask_.raycastTarget = true

				arg_178_1:SetGaussion(false)
			end

			local var_181_24 = 2

			if var_181_23 <= arg_178_1.time_ and arg_178_1.time_ < var_181_23 + var_181_24 then
				local var_181_25 = (arg_178_1.time_ - var_181_23) / var_181_24
				local var_181_26 = Color.New(0, 0, 0)

				var_181_26.a = Mathf.Lerp(1, 0, var_181_25)
				arg_178_1.mask_.color = var_181_26
			end

			if arg_178_1.time_ >= var_181_23 + var_181_24 and arg_178_1.time_ < var_181_23 + var_181_24 + arg_181_0 then
				local var_181_27 = Color.New(0, 0, 0)
				local var_181_28 = 0

				arg_178_1.mask_.enabled = false
				var_181_27.a = var_181_28
				arg_178_1.mask_.color = var_181_27
			end

			local var_181_29 = arg_178_1.actors_["1084ui_story"].transform
			local var_181_30 = 3

			if var_181_30 < arg_178_1.time_ and arg_178_1.time_ <= var_181_30 + arg_181_0 then
				arg_178_1.var_.moveOldPos1084ui_story = var_181_29.localPosition
			end

			local var_181_31 = 0.001

			if var_181_30 <= arg_178_1.time_ and arg_178_1.time_ < var_181_30 + var_181_31 then
				local var_181_32 = (arg_178_1.time_ - var_181_30) / var_181_31
				local var_181_33 = Vector3.New(0, -0.97, -6)

				var_181_29.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos1084ui_story, var_181_33, var_181_32)

				local var_181_34 = manager.ui.mainCamera.transform.position - var_181_29.position

				var_181_29.forward = Vector3.New(var_181_34.x, var_181_34.y, var_181_34.z)

				local var_181_35 = var_181_29.localEulerAngles

				var_181_35.z = 0
				var_181_35.x = 0
				var_181_29.localEulerAngles = var_181_35
			end

			if arg_178_1.time_ >= var_181_30 + var_181_31 and arg_178_1.time_ < var_181_30 + var_181_31 + arg_181_0 then
				var_181_29.localPosition = Vector3.New(0, -0.97, -6)

				local var_181_36 = manager.ui.mainCamera.transform.position - var_181_29.position

				var_181_29.forward = Vector3.New(var_181_36.x, var_181_36.y, var_181_36.z)

				local var_181_37 = var_181_29.localEulerAngles

				var_181_37.z = 0
				var_181_37.x = 0
				var_181_29.localEulerAngles = var_181_37
			end

			local var_181_38 = 2.825
			local var_181_39 = 0.175

			if var_181_38 < arg_178_1.time_ and arg_178_1.time_ <= var_181_38 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				local var_181_40 = arg_178_1:FormatText(StoryNameCfg[6].name)

				arg_178_1.leftNameTxt_.text = var_181_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_41 = arg_178_1:GetWordFromCfg(319351042)
				local var_181_42 = arg_178_1:FormatText(var_181_41.content)

				arg_178_1.text_.text = var_181_42

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_43 = 7
				local var_181_44 = utf8.len(var_181_42)
				local var_181_45 = var_181_43 <= 0 and var_181_39 or var_181_39 * (var_181_44 / var_181_43)

				if var_181_45 > 0 and var_181_39 < var_181_45 then
					arg_178_1.talkMaxDuration = var_181_45

					if var_181_45 + var_181_38 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_45 + var_181_38
					end
				end

				arg_178_1.text_.text = var_181_42
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319351", "319351042", "story_v_out_319351.awb") ~= 0 then
					local var_181_46 = manager.audio:GetVoiceLength("story_v_out_319351", "319351042", "story_v_out_319351.awb") / 1000

					if var_181_46 + var_181_38 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_46 + var_181_38
					end

					if var_181_41.prefab_name ~= "" and arg_178_1.actors_[var_181_41.prefab_name] ~= nil then
						local var_181_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_41.prefab_name].transform, "story_v_out_319351", "319351042", "story_v_out_319351.awb")

						arg_178_1:RecordAudio("319351042", var_181_47)
						arg_178_1:RecordAudio("319351042", var_181_47)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_319351", "319351042", "story_v_out_319351.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_319351", "319351042", "story_v_out_319351.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_48 = math.max(var_181_39, arg_178_1.talkMaxDuration)

			if var_181_38 <= arg_178_1.time_ and arg_178_1.time_ < var_181_38 + var_181_48 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_38) / var_181_48

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_38 + var_181_48 and arg_178_1.time_ < var_181_38 + var_181_48 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_178_1:InitPlayNodeList()
	end,
	Play319351043 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 319351043
		arg_182_1.duration_ = 3.83

		local var_182_0 = {
			zh = 3.833,
			ja = 3.666
		}
		local var_182_1 = manager.audio:GetLocalizationFlag()

		if var_182_0[var_182_1] ~= nil then
			arg_182_1.duration_ = var_182_0[var_182_1]
		end

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play319351044(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = arg_182_1.actors_["1084ui_story"]
			local var_185_1 = 0

			if var_185_1 < arg_182_1.time_ and arg_182_1.time_ <= var_185_1 + arg_185_0 and not isNil(var_185_0) and arg_182_1.var_.characterEffect1084ui_story == nil then
				arg_182_1.var_.characterEffect1084ui_story = var_185_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_2 = 0.200000002980232

			if var_185_1 <= arg_182_1.time_ and arg_182_1.time_ < var_185_1 + var_185_2 and not isNil(var_185_0) then
				local var_185_3 = (arg_182_1.time_ - var_185_1) / var_185_2

				if arg_182_1.var_.characterEffect1084ui_story and not isNil(var_185_0) then
					local var_185_4 = Mathf.Lerp(0, 0.5, var_185_3)

					arg_182_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_182_1.var_.characterEffect1084ui_story.fillRatio = var_185_4
				end
			end

			if arg_182_1.time_ >= var_185_1 + var_185_2 and arg_182_1.time_ < var_185_1 + var_185_2 + arg_185_0 and not isNil(var_185_0) and arg_182_1.var_.characterEffect1084ui_story then
				local var_185_5 = 0.5

				arg_182_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_182_1.var_.characterEffect1084ui_story.fillRatio = var_185_5
			end

			local var_185_6 = arg_182_1.actors_["1095ui_story"]
			local var_185_7 = 0

			if var_185_7 < arg_182_1.time_ and arg_182_1.time_ <= var_185_7 + arg_185_0 and not isNil(var_185_6) and arg_182_1.var_.characterEffect1095ui_story == nil then
				arg_182_1.var_.characterEffect1095ui_story = var_185_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_8 = 0.200000002980232

			if var_185_7 <= arg_182_1.time_ and arg_182_1.time_ < var_185_7 + var_185_8 and not isNil(var_185_6) then
				local var_185_9 = (arg_182_1.time_ - var_185_7) / var_185_8

				if arg_182_1.var_.characterEffect1095ui_story and not isNil(var_185_6) then
					arg_182_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_182_1.time_ >= var_185_7 + var_185_8 and arg_182_1.time_ < var_185_7 + var_185_8 + arg_185_0 and not isNil(var_185_6) and arg_182_1.var_.characterEffect1095ui_story then
				arg_182_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_185_10 = 0

			if var_185_10 < arg_182_1.time_ and arg_182_1.time_ <= var_185_10 + arg_185_0 then
				arg_182_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_2")
			end

			local var_185_11 = 0

			if var_185_11 < arg_182_1.time_ and arg_182_1.time_ <= var_185_11 + arg_185_0 then
				arg_182_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_185_12 = arg_182_1.actors_["1095ui_story"].transform
			local var_185_13 = 0

			if var_185_13 < arg_182_1.time_ and arg_182_1.time_ <= var_185_13 + arg_185_0 then
				arg_182_1.var_.moveOldPos1095ui_story = var_185_12.localPosition
			end

			local var_185_14 = 0.001

			if var_185_13 <= arg_182_1.time_ and arg_182_1.time_ < var_185_13 + var_185_14 then
				local var_185_15 = (arg_182_1.time_ - var_185_13) / var_185_14
				local var_185_16 = Vector3.New(0.7, -0.98, -6.1)

				var_185_12.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPos1095ui_story, var_185_16, var_185_15)

				local var_185_17 = manager.ui.mainCamera.transform.position - var_185_12.position

				var_185_12.forward = Vector3.New(var_185_17.x, var_185_17.y, var_185_17.z)

				local var_185_18 = var_185_12.localEulerAngles

				var_185_18.z = 0
				var_185_18.x = 0
				var_185_12.localEulerAngles = var_185_18
			end

			if arg_182_1.time_ >= var_185_13 + var_185_14 and arg_182_1.time_ < var_185_13 + var_185_14 + arg_185_0 then
				var_185_12.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_185_19 = manager.ui.mainCamera.transform.position - var_185_12.position

				var_185_12.forward = Vector3.New(var_185_19.x, var_185_19.y, var_185_19.z)

				local var_185_20 = var_185_12.localEulerAngles

				var_185_20.z = 0
				var_185_20.x = 0
				var_185_12.localEulerAngles = var_185_20
			end

			local var_185_21 = arg_182_1.actors_["1084ui_story"].transform
			local var_185_22 = 0

			if var_185_22 < arg_182_1.time_ and arg_182_1.time_ <= var_185_22 + arg_185_0 then
				arg_182_1.var_.moveOldPos1084ui_story = var_185_21.localPosition
			end

			local var_185_23 = 0.001

			if var_185_22 <= arg_182_1.time_ and arg_182_1.time_ < var_185_22 + var_185_23 then
				local var_185_24 = (arg_182_1.time_ - var_185_22) / var_185_23
				local var_185_25 = Vector3.New(-0.7, -0.97, -6)

				var_185_21.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPos1084ui_story, var_185_25, var_185_24)

				local var_185_26 = manager.ui.mainCamera.transform.position - var_185_21.position

				var_185_21.forward = Vector3.New(var_185_26.x, var_185_26.y, var_185_26.z)

				local var_185_27 = var_185_21.localEulerAngles

				var_185_27.z = 0
				var_185_27.x = 0
				var_185_21.localEulerAngles = var_185_27
			end

			if arg_182_1.time_ >= var_185_22 + var_185_23 and arg_182_1.time_ < var_185_22 + var_185_23 + arg_185_0 then
				var_185_21.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_185_28 = manager.ui.mainCamera.transform.position - var_185_21.position

				var_185_21.forward = Vector3.New(var_185_28.x, var_185_28.y, var_185_28.z)

				local var_185_29 = var_185_21.localEulerAngles

				var_185_29.z = 0
				var_185_29.x = 0
				var_185_21.localEulerAngles = var_185_29
			end

			local var_185_30 = 0
			local var_185_31 = 0.35

			if var_185_30 < arg_182_1.time_ and arg_182_1.time_ <= var_185_30 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				local var_185_32 = arg_182_1:FormatText(StoryNameCfg[471].name)

				arg_182_1.leftNameTxt_.text = var_185_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_33 = arg_182_1:GetWordFromCfg(319351043)
				local var_185_34 = arg_182_1:FormatText(var_185_33.content)

				arg_182_1.text_.text = var_185_34

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_35 = 14
				local var_185_36 = utf8.len(var_185_34)
				local var_185_37 = var_185_35 <= 0 and var_185_31 or var_185_31 * (var_185_36 / var_185_35)

				if var_185_37 > 0 and var_185_31 < var_185_37 then
					arg_182_1.talkMaxDuration = var_185_37

					if var_185_37 + var_185_30 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_37 + var_185_30
					end
				end

				arg_182_1.text_.text = var_185_34
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319351", "319351043", "story_v_out_319351.awb") ~= 0 then
					local var_185_38 = manager.audio:GetVoiceLength("story_v_out_319351", "319351043", "story_v_out_319351.awb") / 1000

					if var_185_38 + var_185_30 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_38 + var_185_30
					end

					if var_185_33.prefab_name ~= "" and arg_182_1.actors_[var_185_33.prefab_name] ~= nil then
						local var_185_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_33.prefab_name].transform, "story_v_out_319351", "319351043", "story_v_out_319351.awb")

						arg_182_1:RecordAudio("319351043", var_185_39)
						arg_182_1:RecordAudio("319351043", var_185_39)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_319351", "319351043", "story_v_out_319351.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_319351", "319351043", "story_v_out_319351.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_40 = math.max(var_185_31, arg_182_1.talkMaxDuration)

			if var_185_30 <= arg_182_1.time_ and arg_182_1.time_ < var_185_30 + var_185_40 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_30) / var_185_40

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_30 + var_185_40 and arg_182_1.time_ < var_185_30 + var_185_40 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
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

		arg_182_1:InitPlayNodeList()
	end,
	Play319351044 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 319351044
		arg_186_1.duration_ = 9

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play319351045(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = "STwhite"

			if arg_186_1.bgs_[var_189_0] == nil then
				local var_189_1 = Object.Instantiate(arg_186_1.paintGo_)

				var_189_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_189_0)
				var_189_1.name = var_189_0
				var_189_1.transform.parent = arg_186_1.stage_.transform
				var_189_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_186_1.bgs_[var_189_0] = var_189_1
			end

			local var_189_2 = 2

			if var_189_2 < arg_186_1.time_ and arg_186_1.time_ <= var_189_2 + arg_189_0 then
				local var_189_3 = manager.ui.mainCamera.transform.localPosition
				local var_189_4 = Vector3.New(0, 0, 10) + Vector3.New(var_189_3.x, var_189_3.y, 0)
				local var_189_5 = arg_186_1.bgs_.STwhite

				var_189_5.transform.localPosition = var_189_4
				var_189_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_189_6 = var_189_5:GetComponent("SpriteRenderer")

				if var_189_6 and var_189_6.sprite then
					local var_189_7 = (var_189_5.transform.localPosition - var_189_3).z
					local var_189_8 = manager.ui.mainCameraCom_
					local var_189_9 = 2 * var_189_7 * Mathf.Tan(var_189_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_189_10 = var_189_9 * var_189_8.aspect
					local var_189_11 = var_189_6.sprite.bounds.size.x
					local var_189_12 = var_189_6.sprite.bounds.size.y
					local var_189_13 = var_189_10 / var_189_11
					local var_189_14 = var_189_9 / var_189_12
					local var_189_15 = var_189_14 < var_189_13 and var_189_13 or var_189_14

					var_189_5.transform.localScale = Vector3.New(var_189_15, var_189_15, 0)
				end

				for iter_189_0, iter_189_1 in pairs(arg_186_1.bgs_) do
					if iter_189_0 ~= "STwhite" then
						iter_189_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_189_16 = 0

			if var_189_16 < arg_186_1.time_ and arg_186_1.time_ <= var_189_16 + arg_189_0 then
				arg_186_1.mask_.enabled = true
				arg_186_1.mask_.raycastTarget = true

				arg_186_1:SetGaussion(false)
			end

			local var_189_17 = 2

			if var_189_16 <= arg_186_1.time_ and arg_186_1.time_ < var_189_16 + var_189_17 then
				local var_189_18 = (arg_186_1.time_ - var_189_16) / var_189_17
				local var_189_19 = Color.New(0, 0, 0)

				var_189_19.a = Mathf.Lerp(0, 1, var_189_18)
				arg_186_1.mask_.color = var_189_19
			end

			if arg_186_1.time_ >= var_189_16 + var_189_17 and arg_186_1.time_ < var_189_16 + var_189_17 + arg_189_0 then
				local var_189_20 = Color.New(0, 0, 0)

				var_189_20.a = 1
				arg_186_1.mask_.color = var_189_20
			end

			local var_189_21 = 2

			if var_189_21 < arg_186_1.time_ and arg_186_1.time_ <= var_189_21 + arg_189_0 then
				arg_186_1.mask_.enabled = true
				arg_186_1.mask_.raycastTarget = true

				arg_186_1:SetGaussion(false)
			end

			local var_189_22 = 2

			if var_189_21 <= arg_186_1.time_ and arg_186_1.time_ < var_189_21 + var_189_22 then
				local var_189_23 = (arg_186_1.time_ - var_189_21) / var_189_22
				local var_189_24 = Color.New(0, 0, 0)

				var_189_24.a = Mathf.Lerp(1, 0, var_189_23)
				arg_186_1.mask_.color = var_189_24
			end

			if arg_186_1.time_ >= var_189_21 + var_189_22 and arg_186_1.time_ < var_189_21 + var_189_22 + arg_189_0 then
				local var_189_25 = Color.New(0, 0, 0)
				local var_189_26 = 0

				arg_186_1.mask_.enabled = false
				var_189_25.a = var_189_26
				arg_186_1.mask_.color = var_189_25
			end

			local var_189_27 = arg_186_1.actors_["1095ui_story"].transform
			local var_189_28 = 2

			if var_189_28 < arg_186_1.time_ and arg_186_1.time_ <= var_189_28 + arg_189_0 then
				arg_186_1.var_.moveOldPos1095ui_story = var_189_27.localPosition
			end

			local var_189_29 = 0.001

			if var_189_28 <= arg_186_1.time_ and arg_186_1.time_ < var_189_28 + var_189_29 then
				local var_189_30 = (arg_186_1.time_ - var_189_28) / var_189_29
				local var_189_31 = Vector3.New(0, 100, 0)

				var_189_27.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos1095ui_story, var_189_31, var_189_30)

				local var_189_32 = manager.ui.mainCamera.transform.position - var_189_27.position

				var_189_27.forward = Vector3.New(var_189_32.x, var_189_32.y, var_189_32.z)

				local var_189_33 = var_189_27.localEulerAngles

				var_189_33.z = 0
				var_189_33.x = 0
				var_189_27.localEulerAngles = var_189_33
			end

			if arg_186_1.time_ >= var_189_28 + var_189_29 and arg_186_1.time_ < var_189_28 + var_189_29 + arg_189_0 then
				var_189_27.localPosition = Vector3.New(0, 100, 0)

				local var_189_34 = manager.ui.mainCamera.transform.position - var_189_27.position

				var_189_27.forward = Vector3.New(var_189_34.x, var_189_34.y, var_189_34.z)

				local var_189_35 = var_189_27.localEulerAngles

				var_189_35.z = 0
				var_189_35.x = 0
				var_189_27.localEulerAngles = var_189_35
			end

			local var_189_36 = arg_186_1.actors_["1095ui_story"]
			local var_189_37 = 2

			if var_189_37 < arg_186_1.time_ and arg_186_1.time_ <= var_189_37 + arg_189_0 and not isNil(var_189_36) and arg_186_1.var_.characterEffect1095ui_story == nil then
				arg_186_1.var_.characterEffect1095ui_story = var_189_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_38 = 0.200000002980232

			if var_189_37 <= arg_186_1.time_ and arg_186_1.time_ < var_189_37 + var_189_38 and not isNil(var_189_36) then
				local var_189_39 = (arg_186_1.time_ - var_189_37) / var_189_38

				if arg_186_1.var_.characterEffect1095ui_story and not isNil(var_189_36) then
					local var_189_40 = Mathf.Lerp(0, 0.5, var_189_39)

					arg_186_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_186_1.var_.characterEffect1095ui_story.fillRatio = var_189_40
				end
			end

			if arg_186_1.time_ >= var_189_37 + var_189_38 and arg_186_1.time_ < var_189_37 + var_189_38 + arg_189_0 and not isNil(var_189_36) and arg_186_1.var_.characterEffect1095ui_story then
				local var_189_41 = 0.5

				arg_186_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_186_1.var_.characterEffect1095ui_story.fillRatio = var_189_41
			end

			local var_189_42 = arg_186_1.actors_["1084ui_story"]
			local var_189_43 = 2

			if var_189_43 < arg_186_1.time_ and arg_186_1.time_ <= var_189_43 + arg_189_0 and not isNil(var_189_42) and arg_186_1.var_.characterEffect1084ui_story == nil then
				arg_186_1.var_.characterEffect1084ui_story = var_189_42:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_44 = 0.200000002980232

			if var_189_43 <= arg_186_1.time_ and arg_186_1.time_ < var_189_43 + var_189_44 and not isNil(var_189_42) then
				local var_189_45 = (arg_186_1.time_ - var_189_43) / var_189_44

				if arg_186_1.var_.characterEffect1084ui_story and not isNil(var_189_42) then
					local var_189_46 = Mathf.Lerp(0, 0.5, var_189_45)

					arg_186_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_186_1.var_.characterEffect1084ui_story.fillRatio = var_189_46
				end
			end

			if arg_186_1.time_ >= var_189_43 + var_189_44 and arg_186_1.time_ < var_189_43 + var_189_44 + arg_189_0 and not isNil(var_189_42) and arg_186_1.var_.characterEffect1084ui_story then
				local var_189_47 = 0.5

				arg_186_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_186_1.var_.characterEffect1084ui_story.fillRatio = var_189_47
			end

			local var_189_48 = arg_186_1.actors_["1084ui_story"].transform
			local var_189_49 = 2

			if var_189_49 < arg_186_1.time_ and arg_186_1.time_ <= var_189_49 + arg_189_0 then
				arg_186_1.var_.moveOldPos1084ui_story = var_189_48.localPosition
			end

			local var_189_50 = 0.001

			if var_189_49 <= arg_186_1.time_ and arg_186_1.time_ < var_189_49 + var_189_50 then
				local var_189_51 = (arg_186_1.time_ - var_189_49) / var_189_50
				local var_189_52 = Vector3.New(0, 100, 0)

				var_189_48.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos1084ui_story, var_189_52, var_189_51)

				local var_189_53 = manager.ui.mainCamera.transform.position - var_189_48.position

				var_189_48.forward = Vector3.New(var_189_53.x, var_189_53.y, var_189_53.z)

				local var_189_54 = var_189_48.localEulerAngles

				var_189_54.z = 0
				var_189_54.x = 0
				var_189_48.localEulerAngles = var_189_54
			end

			if arg_186_1.time_ >= var_189_49 + var_189_50 and arg_186_1.time_ < var_189_49 + var_189_50 + arg_189_0 then
				var_189_48.localPosition = Vector3.New(0, 100, 0)

				local var_189_55 = manager.ui.mainCamera.transform.position - var_189_48.position

				var_189_48.forward = Vector3.New(var_189_55.x, var_189_55.y, var_189_55.z)

				local var_189_56 = var_189_48.localEulerAngles

				var_189_56.z = 0
				var_189_56.x = 0
				var_189_48.localEulerAngles = var_189_56
			end

			local var_189_57 = 0
			local var_189_58 = 0.9

			if var_189_57 < arg_186_1.time_ and arg_186_1.time_ <= var_189_57 + arg_189_0 then
				local var_189_59 = "play"
				local var_189_60 = "music"

				arg_186_1:AudioAction(var_189_59, var_189_60, "ui_battle", "ui_battle_stopbgm", "")

				local var_189_61 = ""
				local var_189_62 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_189_62 ~= "" then
					if arg_186_1.bgmTxt_.text ~= var_189_62 and arg_186_1.bgmTxt_.text ~= "" then
						if arg_186_1.bgmTxt2_.text ~= "" then
							arg_186_1.bgmTxt_.text = arg_186_1.bgmTxt2_.text
						end

						arg_186_1.bgmTxt2_.text = var_189_62

						arg_186_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_186_1.bgmTxt_.text = var_189_62
						arg_186_1.bgmTxt2_.text = var_189_62
					end

					if arg_186_1.bgmTimer then
						arg_186_1.bgmTimer:Stop()

						arg_186_1.bgmTimer = nil
					end

					if arg_186_1.settingData.show_music_name == 1 then
						arg_186_1.musicController:SetSelectedState("show")
						arg_186_1.musicAnimator_:Play("open", 0, 0)

						if arg_186_1.settingData.music_time ~= 0 then
							arg_186_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_186_1.settingData.music_time), function()
								if arg_186_1 == nil or isNil(arg_186_1.bgmTxt_) then
									return
								end

								arg_186_1.musicController:SetSelectedState("hide")
								arg_186_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_186_1.frameCnt_ <= 1 then
				arg_186_1.dialog_:SetActive(false)
			end

			local var_189_63 = 4
			local var_189_64 = 0.35

			if var_189_63 < arg_186_1.time_ and arg_186_1.time_ <= var_189_63 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0

				arg_186_1.dialog_:SetActive(true)

				arg_186_1.dialogCg_.alpha = 0

				local var_189_65 = LeanTween.value(arg_186_1.dialog_, 0, 1, 0.3)

				var_189_65:setOnUpdate(LuaHelper.FloatAction(function(arg_191_0)
					arg_186_1.dialogCg_.alpha = arg_191_0
				end))
				var_189_65:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_186_1.dialog_)
					var_189_65:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_186_1.duration_ = arg_186_1.duration_ + 0.3

				SetActive(arg_186_1.leftNameGo_, false)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_66 = arg_186_1:GetWordFromCfg(319351044)
				local var_189_67 = arg_186_1:FormatText(var_189_66.content)

				arg_186_1.text_.text = var_189_67

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_68 = 14
				local var_189_69 = utf8.len(var_189_67)
				local var_189_70 = var_189_68 <= 0 and var_189_64 or var_189_64 * (var_189_69 / var_189_68)

				if var_189_70 > 0 and var_189_64 < var_189_70 then
					arg_186_1.talkMaxDuration = var_189_70
					var_189_63 = var_189_63 + 0.3

					if var_189_70 + var_189_63 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_70 + var_189_63
					end
				end

				arg_186_1.text_.text = var_189_67
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)
				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_71 = var_189_63 + 0.3
			local var_189_72 = math.max(var_189_64, arg_186_1.talkMaxDuration)

			if var_189_71 <= arg_186_1.time_ and arg_186_1.time_ < var_189_71 + var_189_72 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_71) / var_189_72

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_71 + var_189_72 and arg_186_1.time_ < var_189_71 + var_189_72 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_186_1:InitPlayNodeList()
	end,
	Play319351045 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 319351045
		arg_193_1.duration_ = 7.39

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play319351046(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = "I11q"

			if arg_193_1.bgs_[var_196_0] == nil then
				local var_196_1 = Object.Instantiate(arg_193_1.paintGo_)

				var_196_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_196_0)
				var_196_1.name = var_196_0
				var_196_1.transform.parent = arg_193_1.stage_.transform
				var_196_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_193_1.bgs_[var_196_0] = var_196_1
			end

			local var_196_2 = 0

			if var_196_2 < arg_193_1.time_ and arg_193_1.time_ <= var_196_2 + arg_196_0 then
				local var_196_3 = manager.ui.mainCamera.transform.localPosition
				local var_196_4 = Vector3.New(0, 0, 10) + Vector3.New(var_196_3.x, var_196_3.y, 0)
				local var_196_5 = arg_193_1.bgs_.I11q

				var_196_5.transform.localPosition = var_196_4
				var_196_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_196_6 = var_196_5:GetComponent("SpriteRenderer")

				if var_196_6 and var_196_6.sprite then
					local var_196_7 = (var_196_5.transform.localPosition - var_196_3).z
					local var_196_8 = manager.ui.mainCameraCom_
					local var_196_9 = 2 * var_196_7 * Mathf.Tan(var_196_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_196_10 = var_196_9 * var_196_8.aspect
					local var_196_11 = var_196_6.sprite.bounds.size.x
					local var_196_12 = var_196_6.sprite.bounds.size.y
					local var_196_13 = var_196_10 / var_196_11
					local var_196_14 = var_196_9 / var_196_12
					local var_196_15 = var_196_14 < var_196_13 and var_196_13 or var_196_14

					var_196_5.transform.localScale = Vector3.New(var_196_15, var_196_15, 0)
				end

				for iter_196_0, iter_196_1 in pairs(arg_193_1.bgs_) do
					if iter_196_0 ~= "I11q" then
						iter_196_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_196_16 = 0

			if var_196_16 < arg_193_1.time_ and arg_193_1.time_ <= var_196_16 + arg_196_0 then
				arg_193_1.mask_.enabled = true
				arg_193_1.mask_.raycastTarget = true

				arg_193_1:SetGaussion(false)
			end

			local var_196_17 = 2.3921013015788

			if var_196_16 <= arg_193_1.time_ and arg_193_1.time_ < var_196_16 + var_196_17 then
				local var_196_18 = (arg_193_1.time_ - var_196_16) / var_196_17
				local var_196_19 = Color.New(1, 1, 1)

				var_196_19.a = Mathf.Lerp(1, 0, var_196_18)
				arg_193_1.mask_.color = var_196_19
			end

			if arg_193_1.time_ >= var_196_16 + var_196_17 and arg_193_1.time_ < var_196_16 + var_196_17 + arg_196_0 then
				local var_196_20 = Color.New(1, 1, 1)
				local var_196_21 = 0

				arg_193_1.mask_.enabled = false
				var_196_20.a = var_196_21
				arg_193_1.mask_.color = var_196_20
			end

			if arg_193_1.frameCnt_ <= 1 then
				arg_193_1.dialog_:SetActive(false)
			end

			local var_196_22 = 2.3921013015788
			local var_196_23 = 0.825

			if var_196_22 < arg_193_1.time_ and arg_193_1.time_ <= var_196_22 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0

				arg_193_1.dialog_:SetActive(true)

				arg_193_1.dialogCg_.alpha = 0

				local var_196_24 = LeanTween.value(arg_193_1.dialog_, 0, 1, 0.3)

				var_196_24:setOnUpdate(LuaHelper.FloatAction(function(arg_197_0)
					arg_193_1.dialogCg_.alpha = arg_197_0
				end))
				var_196_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_193_1.dialog_)
					var_196_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_193_1.duration_ = arg_193_1.duration_ + 0.3

				SetActive(arg_193_1.leftNameGo_, false)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_25 = arg_193_1:GetWordFromCfg(319351045)
				local var_196_26 = arg_193_1:FormatText(var_196_25.content)

				arg_193_1.text_.text = var_196_26

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_27 = 33
				local var_196_28 = utf8.len(var_196_26)
				local var_196_29 = var_196_27 <= 0 and var_196_23 or var_196_23 * (var_196_28 / var_196_27)

				if var_196_29 > 0 and var_196_23 < var_196_29 then
					arg_193_1.talkMaxDuration = var_196_29
					var_196_22 = var_196_22 + 0.3

					if var_196_29 + var_196_22 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_29 + var_196_22
					end
				end

				arg_193_1.text_.text = var_196_26
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_30 = var_196_22 + 0.3
			local var_196_31 = math.max(var_196_23, arg_193_1.talkMaxDuration)

			if var_196_30 <= arg_193_1.time_ and arg_193_1.time_ < var_196_30 + var_196_31 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_30) / var_196_31

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_30 + var_196_31 and arg_193_1.time_ < var_196_30 + var_196_31 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play319351046 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 319351046
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play319351047(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0
			local var_202_1 = 0.725

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

				local var_202_2 = arg_199_1:GetWordFromCfg(319351046)
				local var_202_3 = arg_199_1:FormatText(var_202_2.content)

				arg_199_1.text_.text = var_202_3

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_4 = 29
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
	Play319351047 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 319351047
		arg_203_1.duration_ = 5

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
			arg_203_1.auto_ = false
		end

		function arg_203_1.playNext_(arg_205_0)
			arg_203_1.onStoryFinished_()
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 0
			local var_206_1 = 0.5

			if var_206_0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, false)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_2 = arg_203_1:GetWordFromCfg(319351047)
				local var_206_3 = arg_203_1:FormatText(var_206_2.content)

				arg_203_1.text_.text = var_206_3

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_4 = 20
				local var_206_5 = utf8.len(var_206_3)
				local var_206_6 = var_206_4 <= 0 and var_206_1 or var_206_1 * (var_206_5 / var_206_4)

				if var_206_6 > 0 and var_206_1 < var_206_6 then
					arg_203_1.talkMaxDuration = var_206_6

					if var_206_6 + var_206_0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_6 + var_206_0
					end
				end

				arg_203_1.text_.text = var_206_3
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_7 = math.max(var_206_1, arg_203_1.talkMaxDuration)

			if var_206_0 <= arg_203_1.time_ and arg_203_1.time_ < var_206_0 + var_206_7 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_0) / var_206_7

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_0 + var_206_7 and arg_203_1.time_ < var_206_0 + var_206_7 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/I11o",
		"TextureConfig/Background/ST74",
		"TextureConfig/Background/STwhite",
		"TextureConfig/Background/I11q"
	},
	voices = {
		"story_v_out_319351.awb"
	}
}
