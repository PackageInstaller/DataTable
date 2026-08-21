return {
	Play1109302001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1109302001
		arg_1_1.duration_ = 3.93

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1109302002(arg_1_1)
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

			local var_4_16 = 1.98333333333333

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.fswbg_:SetActive(true)
				arg_1_1.dialog_:SetActive(false)

				arg_1_1.fswtw_.percent = 0

				local var_4_17 = arg_1_1:GetWordFromCfg(1109302001)
				local var_4_18 = arg_1_1:FormatText(var_4_17.content)

				arg_1_1.fswt_.text = var_4_18

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.fswt_)

				arg_1_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_1_1.fswtw_:SetDirty()

				arg_1_1.typewritterCharCountI18N = 0

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_19 = 2

			if var_4_19 < arg_1_1.time_ and arg_1_1.time_ <= var_4_19 + arg_4_0 then
				arg_1_1.var_.oldValueTypewriter = arg_1_1.fswtw_.percent

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_20 = 29
			local var_4_21 = 1.93333333333333
			local var_4_22 = arg_1_1:GetWordFromCfg(1109302001)
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

			local var_4_27 = 1.93333333333333
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

			local var_4_30 = 1.98333333333333

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_31 = arg_1_1.fswbg_.transform:Find("textbox/adapt/content") or arg_1_1.fswbg_.transform:Find("textbox/content")
				local var_4_32 = arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_4_33 = var_4_31:GetComponent("Text")
				local var_4_34 = var_4_31:GetComponent("RectTransform")

				var_4_33.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_4_34.offsetMin = Vector2.New(0, 0)
				var_4_34.offsetMax = Vector2.New(0, 0)
			end

			local var_4_35 = 0
			local var_4_36 = 0.366666666666667

			if var_4_35 < arg_1_1.time_ and arg_1_1.time_ <= var_4_35 + arg_4_0 then
				local var_4_37 = "play"
				local var_4_38 = "music"

				arg_1_1:AudioAction(var_4_37, var_4_38, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_39 = ""
				local var_4_40 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_40 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_40 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_40

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_40
						arg_1_1.bgmTxt2_.text = var_4_40
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

			local var_4_41 = 1.98333333333333
			local var_4_42 = 1.95

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 then
				local var_4_43 = "play"
				local var_4_44 = "music"

				arg_1_1:AudioAction(var_4_43, var_4_44, "bgm_side_daily04", "bgm_side_daily04", "bgm_side_daily04.awb")

				local var_4_45 = ""
				local var_4_46 = manager.audio:GetAudioName("bgm_side_daily04", "bgm_side_daily04")

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

			local var_4_47 = 0

			if var_4_47 < arg_1_1.time_ and arg_1_1.time_ <= var_4_47 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_48 = 2

			if var_4_47 <= arg_1_1.time_ and arg_1_1.time_ < var_4_47 + var_4_48 then
				local var_4_49 = (arg_1_1.time_ - var_4_47) / var_4_48
				local var_4_50 = Color.New(0, 0, 0)

				var_4_50.a = Mathf.Lerp(1, 0, var_4_49)
				arg_1_1.mask_.color = var_4_50
			end

			if arg_1_1.time_ >= var_4_47 + var_4_48 and arg_1_1.time_ < var_4_47 + var_4_48 + arg_4_0 then
				local var_4_51 = Color.New(0, 0, 0)
				local var_4_52 = 0

				arg_1_1.mask_.enabled = false
				var_4_51.a = var_4_52
				arg_1_1.mask_.color = var_4_51
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play1109302002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 1109302002
		arg_7_1.duration_ = 3.2

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play1109302003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			local var_10_0 = 0

			if var_10_0 < arg_7_1.time_ and arg_7_1.time_ <= var_10_0 + arg_10_0 then
				arg_7_1.var_.oldValueTypewriter = arg_7_1.fswtw_.percent

				SetActive(arg_7_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_7_1:ShowNextGo(false)
			end

			local var_10_1 = 77
			local var_10_2 = 3.2
			local var_10_3 = arg_7_1:GetWordFromCfg(1109302001)
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

			local var_10_8 = 3.2
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
			local var_10_12 = 0x0.0000000000001p-1022

			if var_10_11 < arg_7_1.time_ and arg_7_1.time_ <= var_10_11 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, false)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_13 = arg_7_1:GetWordFromCfg(1109302002)
				local var_10_14 = arg_7_1:FormatText(var_10_13.content)

				arg_7_1.text_.text = var_10_14

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_15 = 0
				local var_10_16 = utf8.len(var_10_14)
				local var_10_17 = var_10_15 <= 0 and var_10_12 or var_10_12 * (var_10_16 / var_10_15)

				if var_10_17 > 0 and var_10_12 < var_10_17 then
					arg_7_1.talkMaxDuration = var_10_17

					if var_10_17 + var_10_11 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_17 + var_10_11
					end
				end

				arg_7_1.text_.text = var_10_14
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)
				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_18 = math.max(var_10_12, arg_7_1.talkMaxDuration)

			if var_10_11 <= arg_7_1.time_ and arg_7_1.time_ < var_10_11 + var_10_18 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_11) / var_10_18

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_11 + var_10_18 and arg_7_1.time_ < var_10_11 + var_10_18 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end

		arg_7_1.nodeConfigList_ = {}

		arg_7_1:InitPlayNodeList()
	end,
	Play1109302003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 1109302003
		arg_11_1.duration_ = 3.4

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play1109302004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			local var_14_0 = 0

			if var_14_0 < arg_11_1.time_ and arg_11_1.time_ <= var_14_0 + arg_14_0 then
				arg_11_1.var_.oldValueTypewriter = arg_11_1.fswtw_.percent

				SetActive(arg_11_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_11_1:ShowNextGo(false)
			end

			local var_14_1 = 51
			local var_14_2 = 3.4
			local var_14_3 = arg_11_1:GetWordFromCfg(1109302001)
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

			local var_14_8 = 3.4
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
			local var_14_12 = 0x0.0000000000001p-1022

			if var_14_11 < arg_11_1.time_ and arg_11_1.time_ <= var_14_11 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, false)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_13 = arg_11_1:GetWordFromCfg(1109302003)
				local var_14_14 = arg_11_1:FormatText(var_14_13.content)

				arg_11_1.text_.text = var_14_14

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_15 = 0
				local var_14_16 = utf8.len(var_14_14)
				local var_14_17 = var_14_15 <= 0 and var_14_12 or var_14_12 * (var_14_16 / var_14_15)

				if var_14_17 > 0 and var_14_12 < var_14_17 then
					arg_11_1.talkMaxDuration = var_14_17

					if var_14_17 + var_14_11 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_17 + var_14_11
					end
				end

				arg_11_1.text_.text = var_14_14
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)
				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_18 = math.max(var_14_12, arg_11_1.talkMaxDuration)

			if var_14_11 <= arg_11_1.time_ and arg_11_1.time_ < var_14_11 + var_14_18 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_11) / var_14_18

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_11 + var_14_18 and arg_11_1.time_ < var_14_11 + var_14_18 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end

		arg_11_1.nodeConfigList_ = {}

		arg_11_1:InitPlayNodeList()
	end,
	Play1109302004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 1109302004
		arg_15_1.duration_ = 3

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play1109302005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = 0

			if var_18_0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_0 + arg_18_0 then
				arg_15_1.var_.oldValueTypewriter = arg_15_1.fswtw_.percent

				SetActive(arg_15_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_15_1:ShowNextGo(false)
			end

			local var_18_1 = 45
			local var_18_2 = 3
			local var_18_3 = arg_15_1:GetWordFromCfg(1109302001)
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

			local var_18_8 = 3
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
			local var_18_12 = 0x0.0000000000001p-1022

			if var_18_11 < arg_15_1.time_ and arg_15_1.time_ <= var_18_11 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, false)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_13 = arg_15_1:GetWordFromCfg(1109302004)
				local var_18_14 = arg_15_1:FormatText(var_18_13.content)

				arg_15_1.text_.text = var_18_14

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_15 = 0
				local var_18_16 = utf8.len(var_18_14)
				local var_18_17 = var_18_15 <= 0 and var_18_12 or var_18_12 * (var_18_16 / var_18_15)

				if var_18_17 > 0 and var_18_12 < var_18_17 then
					arg_15_1.talkMaxDuration = var_18_17

					if var_18_17 + var_18_11 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_17 + var_18_11
					end
				end

				arg_15_1.text_.text = var_18_14
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)
				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_18 = math.max(var_18_12, arg_15_1.talkMaxDuration)

			if var_18_11 <= arg_15_1.time_ and arg_15_1.time_ < var_18_11 + var_18_18 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_11) / var_18_18

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_11 + var_18_18 and arg_15_1.time_ < var_18_11 + var_18_18 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {}

		arg_15_1:InitPlayNodeList()
	end,
	Play1109302005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 1109302005
		arg_19_1.duration_ = 2.27

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play1109302006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = 0

			if var_22_0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_0 + arg_22_0 then
				arg_19_1.var_.oldValueTypewriter = arg_19_1.fswtw_.percent

				SetActive(arg_19_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_19_1:ShowNextGo(false)
			end

			local var_22_1 = 34
			local var_22_2 = 2.26666666666667
			local var_22_3 = arg_19_1:GetWordFromCfg(1109302001)
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

			local var_22_8 = 2.26666666666667
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
			local var_22_12 = 0x0.0000000000001p-1022

			if var_22_11 < arg_19_1.time_ and arg_19_1.time_ <= var_22_11 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, false)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_13 = arg_19_1:GetWordFromCfg(1109302005)
				local var_22_14 = arg_19_1:FormatText(var_22_13.content)

				arg_19_1.text_.text = var_22_14

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_15 = 0
				local var_22_16 = utf8.len(var_22_14)
				local var_22_17 = var_22_15 <= 0 and var_22_12 or var_22_12 * (var_22_16 / var_22_15)

				if var_22_17 > 0 and var_22_12 < var_22_17 then
					arg_19_1.talkMaxDuration = var_22_17

					if var_22_17 + var_22_11 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_17 + var_22_11
					end
				end

				arg_19_1.text_.text = var_22_14
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)
				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_18 = math.max(var_22_12, arg_19_1.talkMaxDuration)

			if var_22_11 <= arg_19_1.time_ and arg_19_1.time_ < var_22_11 + var_22_18 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_11) / var_22_18

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_11 + var_22_18 and arg_19_1.time_ < var_22_11 + var_22_18 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play1109302006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 1109302006
		arg_23_1.duration_ = 1

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play1109302007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = 0

			if var_26_0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_0 + arg_26_0 then
				arg_23_1.var_.oldValueTypewriter = arg_23_1.fswtw_.percent

				SetActive(arg_23_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_23_1:ShowNextGo(false)
			end

			local var_26_1 = 2
			local var_26_2 = 0.133333333333333
			local var_26_3 = arg_23_1:GetWordFromCfg(1109302001)
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

			local var_26_8 = 0.133333333333333
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
			local var_26_12 = 0x0.0000000000001p-1022

			if var_26_11 < arg_23_1.time_ and arg_23_1.time_ <= var_26_11 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, false)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_13 = arg_23_1:GetWordFromCfg(1109302006)
				local var_26_14 = arg_23_1:FormatText(var_26_13.content)

				arg_23_1.text_.text = var_26_14

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_15 = 0
				local var_26_16 = utf8.len(var_26_14)
				local var_26_17 = var_26_15 <= 0 and var_26_12 or var_26_12 * (var_26_16 / var_26_15)

				if var_26_17 > 0 and var_26_12 < var_26_17 then
					arg_23_1.talkMaxDuration = var_26_17

					if var_26_17 + var_26_11 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_17 + var_26_11
					end
				end

				arg_23_1.text_.text = var_26_14
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_18 = math.max(var_26_12, arg_23_1.talkMaxDuration)

			if var_26_11 <= arg_23_1.time_ and arg_23_1.time_ < var_26_11 + var_26_18 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_11) / var_26_18

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_11 + var_26_18 and arg_23_1.time_ < var_26_11 + var_26_18 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play1109302007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 1109302007
		arg_27_1.duration_ = 9

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play1109302008(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = "ST06a"

			if arg_27_1.bgs_[var_30_0] == nil then
				local var_30_1 = Object.Instantiate(arg_27_1.paintGo_)

				var_30_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_30_0)
				var_30_1.name = var_30_0
				var_30_1.transform.parent = arg_27_1.stage_.transform
				var_30_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_27_1.bgs_[var_30_0] = var_30_1
			end

			local var_30_2 = 2

			if var_30_2 < arg_27_1.time_ and arg_27_1.time_ <= var_30_2 + arg_30_0 then
				if arg_27_0.sceneSettingEffect_ then
					arg_27_1.sceneSettingEffect_.enabled = false
				end

				arg_27_1.sceneSettingGo_:SetActive(true)

				local var_30_3 = manager.ui.mainCamera.transform.localPosition
				local var_30_4 = Vector3.New(0, 0, 10) + Vector3.New(var_30_3.x, var_30_3.y, 0)
				local var_30_5 = arg_27_1.bgs_.ST06a

				var_30_5.transform.localPosition = var_30_4
				var_30_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_30_6 = var_30_5:GetComponent("SpriteRenderer")

				if var_30_6 and var_30_6.sprite then
					local var_30_7 = (var_30_5.transform.localPosition - var_30_3).z
					local var_30_8 = manager.ui.mainCameraCom_
					local var_30_9 = 2 * var_30_7 * Mathf.Tan(var_30_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_30_10 = var_30_9 * var_30_8.aspect
					local var_30_11 = var_30_6.sprite.bounds.size.x
					local var_30_12 = var_30_6.sprite.bounds.size.y
					local var_30_13 = var_30_10 / var_30_11
					local var_30_14 = var_30_9 / var_30_12
					local var_30_15 = var_30_14 < var_30_13 and var_30_13 or var_30_14

					var_30_5.transform.localScale = Vector3.New(var_30_15, var_30_15, 0)
				end

				for iter_30_0, iter_30_1 in pairs(arg_27_1.bgs_) do
					if iter_30_0 ~= "ST06a" then
						iter_30_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_30_16 = 0

			if var_30_16 < arg_27_1.time_ and arg_27_1.time_ <= var_30_16 + arg_30_0 then
				arg_27_1.mask_.enabled = true
				arg_27_1.mask_.raycastTarget = true

				arg_27_1:SetGaussion(false)
			end

			local var_30_17 = 2

			if var_30_16 <= arg_27_1.time_ and arg_27_1.time_ < var_30_16 + var_30_17 then
				local var_30_18 = (arg_27_1.time_ - var_30_16) / var_30_17
				local var_30_19 = Color.New(0, 0, 0)

				var_30_19.a = Mathf.Lerp(0, 1, var_30_18)
				arg_27_1.mask_.color = var_30_19
			end

			if arg_27_1.time_ >= var_30_16 + var_30_17 and arg_27_1.time_ < var_30_16 + var_30_17 + arg_30_0 then
				local var_30_20 = Color.New(0, 0, 0)

				var_30_20.a = 1
				arg_27_1.mask_.color = var_30_20
			end

			local var_30_21 = 2

			if var_30_21 < arg_27_1.time_ and arg_27_1.time_ <= var_30_21 + arg_30_0 then
				arg_27_1.mask_.enabled = true
				arg_27_1.mask_.raycastTarget = true

				arg_27_1:SetGaussion(false)
			end

			local var_30_22 = 2

			if var_30_21 <= arg_27_1.time_ and arg_27_1.time_ < var_30_21 + var_30_22 then
				local var_30_23 = (arg_27_1.time_ - var_30_21) / var_30_22
				local var_30_24 = Color.New(0, 0, 0)

				var_30_24.a = Mathf.Lerp(1, 0, var_30_23)
				arg_27_1.mask_.color = var_30_24
			end

			if arg_27_1.time_ >= var_30_21 + var_30_22 and arg_27_1.time_ < var_30_21 + var_30_22 + arg_30_0 then
				local var_30_25 = Color.New(0, 0, 0)
				local var_30_26 = 0

				arg_27_1.mask_.enabled = false
				var_30_25.a = var_30_26
				arg_27_1.mask_.color = var_30_25
			end

			local var_30_27 = 1.98333333333333

			if var_30_27 < arg_27_1.time_ and arg_27_1.time_ <= var_30_27 + arg_30_0 then
				arg_27_1.fswbg_:SetActive(false)
				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_27_1:ShowNextGo(false)
			end

			local var_30_28 = arg_27_1.bgs_.ST06a.transform
			local var_30_29 = 2

			if var_30_29 < arg_27_1.time_ and arg_27_1.time_ <= var_30_29 + arg_30_0 then
				arg_27_1.var_.moveOldPosST06a = var_30_28.localPosition
			end

			local var_30_30 = 0.001

			if var_30_29 <= arg_27_1.time_ and arg_27_1.time_ < var_30_29 + var_30_30 then
				local var_30_31 = (arg_27_1.time_ - var_30_29) / var_30_30
				local var_30_32 = Vector3.New(0, 2.5, 2)

				var_30_28.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPosST06a, var_30_32, var_30_31)
			end

			if arg_27_1.time_ >= var_30_29 + var_30_30 and arg_27_1.time_ < var_30_29 + var_30_30 + arg_30_0 then
				var_30_28.localPosition = Vector3.New(0, 2.5, 2)
			end

			if arg_27_1.frameCnt_ <= 1 then
				arg_27_1.dialog_:SetActive(false)
			end

			local var_30_33 = 4
			local var_30_34 = 0.6

			if var_30_33 < arg_27_1.time_ and arg_27_1.time_ <= var_30_33 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0

				arg_27_1.dialog_:SetActive(true)

				arg_27_1.dialogCg_.alpha = 0

				local var_30_35 = LeanTween.value(arg_27_1.dialog_, 0, 1, 0.3)

				var_30_35:setOnUpdate(LuaHelper.FloatAction(function(arg_31_0)
					arg_27_1.dialogCg_.alpha = arg_31_0
				end))
				var_30_35:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_27_1.dialog_)
					var_30_35:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_27_1.duration_ = arg_27_1.duration_ + 0.3

				SetActive(arg_27_1.leftNameGo_, true)

				local var_30_36 = arg_27_1:FormatText(StoryNameCfg[7].name)

				arg_27_1.leftNameTxt_.text = var_30_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, true)
				arg_27_1.iconController_:SetSelectedState("hero")

				arg_27_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_27_1.callingController_:SetSelectedState("normal")

				arg_27_1.keyicon_.color = Color.New(1, 1, 1)
				arg_27_1.icon_.color = Color.New(1, 1, 1)

				local var_30_37 = arg_27_1:GetWordFromCfg(1109302007)
				local var_30_38 = arg_27_1:FormatText(var_30_37.content)

				arg_27_1.text_.text = var_30_38

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_39 = 24
				local var_30_40 = utf8.len(var_30_38)
				local var_30_41 = var_30_39 <= 0 and var_30_34 or var_30_34 * (var_30_40 / var_30_39)

				if var_30_41 > 0 and var_30_34 < var_30_41 then
					arg_27_1.talkMaxDuration = var_30_41
					var_30_33 = var_30_33 + 0.3

					if var_30_41 + var_30_33 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_41 + var_30_33
					end
				end

				arg_27_1.text_.text = var_30_38
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)
				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_42 = var_30_33 + 0.3
			local var_30_43 = math.max(var_30_34, arg_27_1.talkMaxDuration)

			if var_30_42 <= arg_27_1.time_ and arg_27_1.time_ < var_30_42 + var_30_43 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_42) / var_30_43

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_42 + var_30_43 and arg_27_1.time_ < var_30_42 + var_30_43 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ST06a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_27_1:InitPlayNodeList()
	end,
	Play1109302008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 1109302008
		arg_33_1.duration_ = 2.6

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play1109302009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = "1093ui_story"

			if arg_33_1.actors_[var_36_0] == nil then
				local var_36_1 = Asset.Load("Char/" .. "1093ui_story")

				if not isNil(var_36_1) then
					local var_36_2 = Object.Instantiate(Asset.Load("Char/" .. "1093ui_story"), arg_33_1.stage_.transform)

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

			local var_36_5 = arg_33_1.actors_["1093ui_story"].transform
			local var_36_6 = 0

			if var_36_6 < arg_33_1.time_ and arg_33_1.time_ <= var_36_6 + arg_36_0 then
				arg_33_1.var_.moveOldPos1093ui_story = var_36_5.localPosition
			end

			local var_36_7 = 0.001

			if var_36_6 <= arg_33_1.time_ and arg_33_1.time_ < var_36_6 + var_36_7 then
				local var_36_8 = (arg_33_1.time_ - var_36_6) / var_36_7
				local var_36_9 = Vector3.New(0, -1.11, -5.88)

				var_36_5.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1093ui_story, var_36_9, var_36_8)

				local var_36_10 = manager.ui.mainCamera.transform.position - var_36_5.position

				var_36_5.forward = Vector3.New(var_36_10.x, var_36_10.y, var_36_10.z)

				local var_36_11 = var_36_5.localEulerAngles

				var_36_11.z = 0
				var_36_11.x = 0
				var_36_5.localEulerAngles = var_36_11
			end

			if arg_33_1.time_ >= var_36_6 + var_36_7 and arg_33_1.time_ < var_36_6 + var_36_7 + arg_36_0 then
				var_36_5.localPosition = Vector3.New(0, -1.11, -5.88)

				local var_36_12 = manager.ui.mainCamera.transform.position - var_36_5.position

				var_36_5.forward = Vector3.New(var_36_12.x, var_36_12.y, var_36_12.z)

				local var_36_13 = var_36_5.localEulerAngles

				var_36_13.z = 0
				var_36_13.x = 0
				var_36_5.localEulerAngles = var_36_13
			end

			local var_36_14 = 0

			if var_36_14 < arg_33_1.time_ and arg_33_1.time_ <= var_36_14 + arg_36_0 then
				arg_33_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action7_1")
			end

			local var_36_15 = arg_33_1.actors_["1093ui_story"]
			local var_36_16 = 0

			if var_36_16 < arg_33_1.time_ and arg_33_1.time_ <= var_36_16 + arg_36_0 and not isNil(var_36_15) and arg_33_1.var_.characterEffect1093ui_story == nil then
				arg_33_1.var_.characterEffect1093ui_story = var_36_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_17 = 0.2

			if var_36_16 <= arg_33_1.time_ and arg_33_1.time_ < var_36_16 + var_36_17 and not isNil(var_36_15) then
				local var_36_18 = (arg_33_1.time_ - var_36_16) / var_36_17

				if arg_33_1.var_.characterEffect1093ui_story and not isNil(var_36_15) then
					arg_33_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_16 + var_36_17 and arg_33_1.time_ < var_36_16 + var_36_17 + arg_36_0 and not isNil(var_36_15) and arg_33_1.var_.characterEffect1093ui_story then
				arg_33_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_36_19 = 0
			local var_36_20 = 0.075

			if var_36_19 < arg_33_1.time_ and arg_33_1.time_ <= var_36_19 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_21 = arg_33_1:FormatText(StoryNameCfg[73].name)

				arg_33_1.leftNameTxt_.text = var_36_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_22 = arg_33_1:GetWordFromCfg(1109302008)
				local var_36_23 = arg_33_1:FormatText(var_36_22.content)

				arg_33_1.text_.text = var_36_23

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_24 = 3
				local var_36_25 = utf8.len(var_36_23)
				local var_36_26 = var_36_24 <= 0 and var_36_20 or var_36_20 * (var_36_25 / var_36_24)

				if var_36_26 > 0 and var_36_20 < var_36_26 then
					arg_33_1.talkMaxDuration = var_36_26

					if var_36_26 + var_36_19 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_26 + var_36_19
					end
				end

				arg_33_1.text_.text = var_36_23
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302008", "story_v_side_new_1109302.awb") ~= 0 then
					local var_36_27 = manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302008", "story_v_side_new_1109302.awb") / 1000

					if var_36_27 + var_36_19 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_27 + var_36_19
					end

					if var_36_22.prefab_name ~= "" and arg_33_1.actors_[var_36_22.prefab_name] ~= nil then
						local var_36_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_22.prefab_name].transform, "story_v_side_new_1109302", "1109302008", "story_v_side_new_1109302.awb")

						arg_33_1:RecordAudio("1109302008", var_36_28)
						arg_33_1:RecordAudio("1109302008", var_36_28)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_side_new_1109302", "1109302008", "story_v_side_new_1109302.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_side_new_1109302", "1109302008", "story_v_side_new_1109302.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_29 = math.max(var_36_20, arg_33_1.talkMaxDuration)

			if var_36_19 <= arg_33_1.time_ and arg_33_1.time_ < var_36_19 + var_36_29 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_19) / var_36_29

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_19 + var_36_29 and arg_33_1.time_ < var_36_19 + var_36_29 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
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
	Play1109302009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 1109302009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play1109302010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1093ui_story"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1093ui_story == nil then
				arg_37_1.var_.characterEffect1093ui_story = var_40_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.2

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.characterEffect1093ui_story and not isNil(var_40_0) then
					local var_40_4 = Mathf.Lerp(0, 0.5, var_40_3)

					arg_37_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1093ui_story.fillRatio = var_40_4
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1093ui_story then
				local var_40_5 = 0.5

				arg_37_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1093ui_story.fillRatio = var_40_5
			end

			local var_40_6 = 0
			local var_40_7 = 1.275

			if var_40_6 < arg_37_1.time_ and arg_37_1.time_ <= var_40_6 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_8 = arg_37_1:GetWordFromCfg(1109302009)
				local var_40_9 = arg_37_1:FormatText(var_40_8.content)

				arg_37_1.text_.text = var_40_9

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_10 = 51
				local var_40_11 = utf8.len(var_40_9)
				local var_40_12 = var_40_10 <= 0 and var_40_7 or var_40_7 * (var_40_11 / var_40_10)

				if var_40_12 > 0 and var_40_7 < var_40_12 then
					arg_37_1.talkMaxDuration = var_40_12

					if var_40_12 + var_40_6 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_12 + var_40_6
					end
				end

				arg_37_1.text_.text = var_40_9
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_13 = math.max(var_40_7, arg_37_1.talkMaxDuration)

			if var_40_6 <= arg_37_1.time_ and arg_37_1.time_ < var_40_6 + var_40_13 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_6) / var_40_13

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_6 + var_40_13 and arg_37_1.time_ < var_40_6 + var_40_13 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play1109302010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 1109302010
		arg_41_1.duration_ = 10.7

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play1109302011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1093ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1093ui_story == nil then
				arg_41_1.var_.characterEffect1093ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.2

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect1093ui_story and not isNil(var_44_0) then
					arg_41_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1093ui_story then
				arg_41_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_44_4 = 0

			if var_44_4 < arg_41_1.time_ and arg_41_1.time_ <= var_44_4 + arg_44_0 then
				arg_41_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action476")
			end

			local var_44_5 = 0

			if var_44_5 < arg_41_1.time_ and arg_41_1.time_ <= var_44_5 + arg_44_0 then
				arg_41_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_44_6 = 0
			local var_44_7 = 0.75

			if var_44_6 < arg_41_1.time_ and arg_41_1.time_ <= var_44_6 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_8 = arg_41_1:FormatText(StoryNameCfg[73].name)

				arg_41_1.leftNameTxt_.text = var_44_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_9 = arg_41_1:GetWordFromCfg(1109302010)
				local var_44_10 = arg_41_1:FormatText(var_44_9.content)

				arg_41_1.text_.text = var_44_10

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_11 = 30
				local var_44_12 = utf8.len(var_44_10)
				local var_44_13 = var_44_11 <= 0 and var_44_7 or var_44_7 * (var_44_12 / var_44_11)

				if var_44_13 > 0 and var_44_7 < var_44_13 then
					arg_41_1.talkMaxDuration = var_44_13

					if var_44_13 + var_44_6 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_13 + var_44_6
					end
				end

				arg_41_1.text_.text = var_44_10
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302010", "story_v_side_new_1109302.awb") ~= 0 then
					local var_44_14 = manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302010", "story_v_side_new_1109302.awb") / 1000

					if var_44_14 + var_44_6 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_14 + var_44_6
					end

					if var_44_9.prefab_name ~= "" and arg_41_1.actors_[var_44_9.prefab_name] ~= nil then
						local var_44_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_9.prefab_name].transform, "story_v_side_new_1109302", "1109302010", "story_v_side_new_1109302.awb")

						arg_41_1:RecordAudio("1109302010", var_44_15)
						arg_41_1:RecordAudio("1109302010", var_44_15)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_side_new_1109302", "1109302010", "story_v_side_new_1109302.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_side_new_1109302", "1109302010", "story_v_side_new_1109302.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_16 = math.max(var_44_7, arg_41_1.talkMaxDuration)

			if var_44_6 <= arg_41_1.time_ and arg_41_1.time_ < var_44_6 + var_44_16 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_6) / var_44_16

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_6 + var_44_16 and arg_41_1.time_ < var_44_6 + var_44_16 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play1109302011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 1109302011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play1109302012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1093ui_story"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1093ui_story == nil then
				arg_45_1.var_.characterEffect1093ui_story = var_48_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.2

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.characterEffect1093ui_story and not isNil(var_48_0) then
					local var_48_4 = Mathf.Lerp(0, 0.5, var_48_3)

					arg_45_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1093ui_story.fillRatio = var_48_4
				end
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1093ui_story then
				local var_48_5 = 0.5

				arg_45_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1093ui_story.fillRatio = var_48_5
			end

			local var_48_6 = 0
			local var_48_7 = 0.175

			if var_48_6 < arg_45_1.time_ and arg_45_1.time_ <= var_48_6 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_8 = arg_45_1:FormatText(StoryNameCfg[7].name)

				arg_45_1.leftNameTxt_.text = var_48_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_9 = arg_45_1:GetWordFromCfg(1109302011)
				local var_48_10 = arg_45_1:FormatText(var_48_9.content)

				arg_45_1.text_.text = var_48_10

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_11 = 7
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
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_14 = math.max(var_48_7, arg_45_1.talkMaxDuration)

			if var_48_6 <= arg_45_1.time_ and arg_45_1.time_ < var_48_6 + var_48_14 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_6) / var_48_14

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_6 + var_48_14 and arg_45_1.time_ < var_48_6 + var_48_14 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play1109302012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 1109302012
		arg_49_1.duration_ = 7.83

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play1109302013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1093ui_story"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1093ui_story == nil then
				arg_49_1.var_.characterEffect1093ui_story = var_52_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.2

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.characterEffect1093ui_story and not isNil(var_52_0) then
					arg_49_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1093ui_story then
				arg_49_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_52_4 = 0

			if var_52_4 < arg_49_1.time_ and arg_49_1.time_ <= var_52_4 + arg_52_0 then
				arg_49_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action468")
			end

			local var_52_5 = 0

			if var_52_5 < arg_49_1.time_ and arg_49_1.time_ <= var_52_5 + arg_52_0 then
				arg_49_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_52_6 = 0
			local var_52_7 = 1.1

			if var_52_6 < arg_49_1.time_ and arg_49_1.time_ <= var_52_6 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_8 = arg_49_1:FormatText(StoryNameCfg[73].name)

				arg_49_1.leftNameTxt_.text = var_52_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_9 = arg_49_1:GetWordFromCfg(1109302012)
				local var_52_10 = arg_49_1:FormatText(var_52_9.content)

				arg_49_1.text_.text = var_52_10

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_11 = 44
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

				if manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302012", "story_v_side_new_1109302.awb") ~= 0 then
					local var_52_14 = manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302012", "story_v_side_new_1109302.awb") / 1000

					if var_52_14 + var_52_6 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_14 + var_52_6
					end

					if var_52_9.prefab_name ~= "" and arg_49_1.actors_[var_52_9.prefab_name] ~= nil then
						local var_52_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_9.prefab_name].transform, "story_v_side_new_1109302", "1109302012", "story_v_side_new_1109302.awb")

						arg_49_1:RecordAudio("1109302012", var_52_15)
						arg_49_1:RecordAudio("1109302012", var_52_15)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_side_new_1109302", "1109302012", "story_v_side_new_1109302.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_side_new_1109302", "1109302012", "story_v_side_new_1109302.awb")
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
	Play1109302013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 1109302013
		arg_53_1.duration_ = 18.63

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play1109302014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_56_1 = 0
			local var_56_2 = 1.1

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_3 = arg_53_1:FormatText(StoryNameCfg[73].name)

				arg_53_1.leftNameTxt_.text = var_56_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_4 = arg_53_1:GetWordFromCfg(1109302013)
				local var_56_5 = arg_53_1:FormatText(var_56_4.content)

				arg_53_1.text_.text = var_56_5

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_6 = 44
				local var_56_7 = utf8.len(var_56_5)
				local var_56_8 = var_56_6 <= 0 and var_56_2 or var_56_2 * (var_56_7 / var_56_6)

				if var_56_8 > 0 and var_56_2 < var_56_8 then
					arg_53_1.talkMaxDuration = var_56_8

					if var_56_8 + var_56_1 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_1
					end
				end

				arg_53_1.text_.text = var_56_5
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302013", "story_v_side_new_1109302.awb") ~= 0 then
					local var_56_9 = manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302013", "story_v_side_new_1109302.awb") / 1000

					if var_56_9 + var_56_1 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_9 + var_56_1
					end

					if var_56_4.prefab_name ~= "" and arg_53_1.actors_[var_56_4.prefab_name] ~= nil then
						local var_56_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_4.prefab_name].transform, "story_v_side_new_1109302", "1109302013", "story_v_side_new_1109302.awb")

						arg_53_1:RecordAudio("1109302013", var_56_10)
						arg_53_1:RecordAudio("1109302013", var_56_10)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_side_new_1109302", "1109302013", "story_v_side_new_1109302.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_side_new_1109302", "1109302013", "story_v_side_new_1109302.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_11 = math.max(var_56_2, arg_53_1.talkMaxDuration)

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_11 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_1) / var_56_11

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_1 + var_56_11 and arg_53_1.time_ < var_56_1 + var_56_11 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play1109302014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 1109302014
		arg_57_1.duration_ = 9.93

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play1109302015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action486")
			end

			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_60_2 = 0
			local var_60_3 = 0.6

			if var_60_2 < arg_57_1.time_ and arg_57_1.time_ <= var_60_2 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_4 = arg_57_1:FormatText(StoryNameCfg[73].name)

				arg_57_1.leftNameTxt_.text = var_60_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_5 = arg_57_1:GetWordFromCfg(1109302014)
				local var_60_6 = arg_57_1:FormatText(var_60_5.content)

				arg_57_1.text_.text = var_60_6

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_7 = 24
				local var_60_8 = utf8.len(var_60_6)
				local var_60_9 = var_60_7 <= 0 and var_60_3 or var_60_3 * (var_60_8 / var_60_7)

				if var_60_9 > 0 and var_60_3 < var_60_9 then
					arg_57_1.talkMaxDuration = var_60_9

					if var_60_9 + var_60_2 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_9 + var_60_2
					end
				end

				arg_57_1.text_.text = var_60_6
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302014", "story_v_side_new_1109302.awb") ~= 0 then
					local var_60_10 = manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302014", "story_v_side_new_1109302.awb") / 1000

					if var_60_10 + var_60_2 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_10 + var_60_2
					end

					if var_60_5.prefab_name ~= "" and arg_57_1.actors_[var_60_5.prefab_name] ~= nil then
						local var_60_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_5.prefab_name].transform, "story_v_side_new_1109302", "1109302014", "story_v_side_new_1109302.awb")

						arg_57_1:RecordAudio("1109302014", var_60_11)
						arg_57_1:RecordAudio("1109302014", var_60_11)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_side_new_1109302", "1109302014", "story_v_side_new_1109302.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_side_new_1109302", "1109302014", "story_v_side_new_1109302.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_12 = math.max(var_60_3, arg_57_1.talkMaxDuration)

			if var_60_2 <= arg_57_1.time_ and arg_57_1.time_ < var_60_2 + var_60_12 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_2) / var_60_12

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_2 + var_60_12 and arg_57_1.time_ < var_60_2 + var_60_12 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play1109302015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 1109302015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play1109302016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["1093ui_story"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect1093ui_story == nil then
				arg_61_1.var_.characterEffect1093ui_story = var_64_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.2

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 and not isNil(var_64_0) then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2

				if arg_61_1.var_.characterEffect1093ui_story and not isNil(var_64_0) then
					local var_64_4 = Mathf.Lerp(0, 0.5, var_64_3)

					arg_61_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1093ui_story.fillRatio = var_64_4
				end
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect1093ui_story then
				local var_64_5 = 0.5

				arg_61_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1093ui_story.fillRatio = var_64_5
			end

			local var_64_6 = 0
			local var_64_7 = 0.65

			if var_64_6 < arg_61_1.time_ and arg_61_1.time_ <= var_64_6 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_8 = arg_61_1:GetWordFromCfg(1109302015)
				local var_64_9 = arg_61_1:FormatText(var_64_8.content)

				arg_61_1.text_.text = var_64_9

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_10 = 26
				local var_64_11 = utf8.len(var_64_9)
				local var_64_12 = var_64_10 <= 0 and var_64_7 or var_64_7 * (var_64_11 / var_64_10)

				if var_64_12 > 0 and var_64_7 < var_64_12 then
					arg_61_1.talkMaxDuration = var_64_12

					if var_64_12 + var_64_6 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_12 + var_64_6
					end
				end

				arg_61_1.text_.text = var_64_9
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_13 = math.max(var_64_7, arg_61_1.talkMaxDuration)

			if var_64_6 <= arg_61_1.time_ and arg_61_1.time_ < var_64_6 + var_64_13 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_6) / var_64_13

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_6 + var_64_13 and arg_61_1.time_ < var_64_6 + var_64_13 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play1109302016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 1109302016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play1109302017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0
			local var_68_1 = 1.075

			if var_68_0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_2 = arg_65_1:GetWordFromCfg(1109302016)
				local var_68_3 = arg_65_1:FormatText(var_68_2.content)

				arg_65_1.text_.text = var_68_3

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_4 = 43
				local var_68_5 = utf8.len(var_68_3)
				local var_68_6 = var_68_4 <= 0 and var_68_1 or var_68_1 * (var_68_5 / var_68_4)

				if var_68_6 > 0 and var_68_1 < var_68_6 then
					arg_65_1.talkMaxDuration = var_68_6

					if var_68_6 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_6 + var_68_0
					end
				end

				arg_65_1.text_.text = var_68_3
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_7 = math.max(var_68_1, arg_65_1.talkMaxDuration)

			if var_68_0 <= arg_65_1.time_ and arg_65_1.time_ < var_68_0 + var_68_7 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_0) / var_68_7

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_0 + var_68_7 and arg_65_1.time_ < var_68_0 + var_68_7 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play1109302017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 1109302017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play1109302018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0
			local var_72_1 = 0.7

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_2 = arg_69_1:GetWordFromCfg(1109302017)
				local var_72_3 = arg_69_1:FormatText(var_72_2.content)

				arg_69_1.text_.text = var_72_3

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_4 = 28
				local var_72_5 = utf8.len(var_72_3)
				local var_72_6 = var_72_4 <= 0 and var_72_1 or var_72_1 * (var_72_5 / var_72_4)

				if var_72_6 > 0 and var_72_1 < var_72_6 then
					arg_69_1.talkMaxDuration = var_72_6

					if var_72_6 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_6 + var_72_0
					end
				end

				arg_69_1.text_.text = var_72_3
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_7 = math.max(var_72_1, arg_69_1.talkMaxDuration)

			if var_72_0 <= arg_69_1.time_ and arg_69_1.time_ < var_72_0 + var_72_7 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_0) / var_72_7

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_0 + var_72_7 and arg_69_1.time_ < var_72_0 + var_72_7 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play1109302018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 1109302018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play1109302019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0
			local var_76_1 = 1.25

			if var_76_0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_2 = arg_73_1:FormatText(StoryNameCfg[7].name)

				arg_73_1.leftNameTxt_.text = var_76_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_3 = arg_73_1:GetWordFromCfg(1109302018)
				local var_76_4 = arg_73_1:FormatText(var_76_3.content)

				arg_73_1.text_.text = var_76_4

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_5 = 50
				local var_76_6 = utf8.len(var_76_4)
				local var_76_7 = var_76_5 <= 0 and var_76_1 or var_76_1 * (var_76_6 / var_76_5)

				if var_76_7 > 0 and var_76_1 < var_76_7 then
					arg_73_1.talkMaxDuration = var_76_7

					if var_76_7 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_7 + var_76_0
					end
				end

				arg_73_1.text_.text = var_76_4
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_8 = math.max(var_76_1, arg_73_1.talkMaxDuration)

			if var_76_0 <= arg_73_1.time_ and arg_73_1.time_ < var_76_0 + var_76_8 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_0) / var_76_8

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_0 + var_76_8 and arg_73_1.time_ < var_76_0 + var_76_8 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play1109302019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 1109302019
		arg_77_1.duration_ = 2.67

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play1109302020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["1093ui_story"]
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect1093ui_story == nil then
				arg_77_1.var_.characterEffect1093ui_story = var_80_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.2

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 and not isNil(var_80_0) then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2

				if arg_77_1.var_.characterEffect1093ui_story and not isNil(var_80_0) then
					arg_77_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect1093ui_story then
				arg_77_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_80_4 = 0

			if var_80_4 < arg_77_1.time_ and arg_77_1.time_ <= var_80_4 + arg_80_0 then
				arg_77_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action467")
			end

			local var_80_5 = 0

			if var_80_5 < arg_77_1.time_ and arg_77_1.time_ <= var_80_5 + arg_80_0 then
				arg_77_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_80_6 = 0
			local var_80_7 = 0.25

			if var_80_6 < arg_77_1.time_ and arg_77_1.time_ <= var_80_6 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_8 = arg_77_1:FormatText(StoryNameCfg[73].name)

				arg_77_1.leftNameTxt_.text = var_80_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_9 = arg_77_1:GetWordFromCfg(1109302019)
				local var_80_10 = arg_77_1:FormatText(var_80_9.content)

				arg_77_1.text_.text = var_80_10

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_11 = 10
				local var_80_12 = utf8.len(var_80_10)
				local var_80_13 = var_80_11 <= 0 and var_80_7 or var_80_7 * (var_80_12 / var_80_11)

				if var_80_13 > 0 and var_80_7 < var_80_13 then
					arg_77_1.talkMaxDuration = var_80_13

					if var_80_13 + var_80_6 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_13 + var_80_6
					end
				end

				arg_77_1.text_.text = var_80_10
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302019", "story_v_side_new_1109302.awb") ~= 0 then
					local var_80_14 = manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302019", "story_v_side_new_1109302.awb") / 1000

					if var_80_14 + var_80_6 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_14 + var_80_6
					end

					if var_80_9.prefab_name ~= "" and arg_77_1.actors_[var_80_9.prefab_name] ~= nil then
						local var_80_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_9.prefab_name].transform, "story_v_side_new_1109302", "1109302019", "story_v_side_new_1109302.awb")

						arg_77_1:RecordAudio("1109302019", var_80_15)
						arg_77_1:RecordAudio("1109302019", var_80_15)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_side_new_1109302", "1109302019", "story_v_side_new_1109302.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_side_new_1109302", "1109302019", "story_v_side_new_1109302.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_16 = math.max(var_80_7, arg_77_1.talkMaxDuration)

			if var_80_6 <= arg_77_1.time_ and arg_77_1.time_ < var_80_6 + var_80_16 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_6) / var_80_16

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_6 + var_80_16 and arg_77_1.time_ < var_80_6 + var_80_16 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play1109302020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 1109302020
		arg_81_1.duration_ = 16.93

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play1109302021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0

			if var_84_0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				arg_81_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action479")
			end

			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1304cva")
			end

			local var_84_2 = 0
			local var_84_3 = 0.975

			if var_84_2 < arg_81_1.time_ and arg_81_1.time_ <= var_84_2 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_4 = arg_81_1:FormatText(StoryNameCfg[73].name)

				arg_81_1.leftNameTxt_.text = var_84_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_5 = arg_81_1:GetWordFromCfg(1109302020)
				local var_84_6 = arg_81_1:FormatText(var_84_5.content)

				arg_81_1.text_.text = var_84_6

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_7 = 39
				local var_84_8 = utf8.len(var_84_6)
				local var_84_9 = var_84_7 <= 0 and var_84_3 or var_84_3 * (var_84_8 / var_84_7)

				if var_84_9 > 0 and var_84_3 < var_84_9 then
					arg_81_1.talkMaxDuration = var_84_9

					if var_84_9 + var_84_2 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_9 + var_84_2
					end
				end

				arg_81_1.text_.text = var_84_6
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302020", "story_v_side_new_1109302.awb") ~= 0 then
					local var_84_10 = manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302020", "story_v_side_new_1109302.awb") / 1000

					if var_84_10 + var_84_2 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_10 + var_84_2
					end

					if var_84_5.prefab_name ~= "" and arg_81_1.actors_[var_84_5.prefab_name] ~= nil then
						local var_84_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_5.prefab_name].transform, "story_v_side_new_1109302", "1109302020", "story_v_side_new_1109302.awb")

						arg_81_1:RecordAudio("1109302020", var_84_11)
						arg_81_1:RecordAudio("1109302020", var_84_11)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_side_new_1109302", "1109302020", "story_v_side_new_1109302.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_side_new_1109302", "1109302020", "story_v_side_new_1109302.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_12 = math.max(var_84_3, arg_81_1.talkMaxDuration)

			if var_84_2 <= arg_81_1.time_ and arg_81_1.time_ < var_84_2 + var_84_12 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_2) / var_84_12

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_2 + var_84_12 and arg_81_1.time_ < var_84_2 + var_84_12 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play1109302021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 1109302021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play1109302022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["1093ui_story"]
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect1093ui_story == nil then
				arg_85_1.var_.characterEffect1093ui_story = var_88_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.2

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 and not isNil(var_88_0) then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2

				if arg_85_1.var_.characterEffect1093ui_story and not isNil(var_88_0) then
					local var_88_4 = Mathf.Lerp(0, 0.5, var_88_3)

					arg_85_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1093ui_story.fillRatio = var_88_4
				end
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect1093ui_story then
				local var_88_5 = 0.5

				arg_85_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1093ui_story.fillRatio = var_88_5
			end

			local var_88_6 = 0
			local var_88_7 = 0.55

			if var_88_6 < arg_85_1.time_ and arg_85_1.time_ <= var_88_6 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, false)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_8 = arg_85_1:GetWordFromCfg(1109302021)
				local var_88_9 = arg_85_1:FormatText(var_88_8.content)

				arg_85_1.text_.text = var_88_9

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_10 = 22
				local var_88_11 = utf8.len(var_88_9)
				local var_88_12 = var_88_10 <= 0 and var_88_7 or var_88_7 * (var_88_11 / var_88_10)

				if var_88_12 > 0 and var_88_7 < var_88_12 then
					arg_85_1.talkMaxDuration = var_88_12

					if var_88_12 + var_88_6 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_12 + var_88_6
					end
				end

				arg_85_1.text_.text = var_88_9
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_13 = math.max(var_88_7, arg_85_1.talkMaxDuration)

			if var_88_6 <= arg_85_1.time_ and arg_85_1.time_ < var_88_6 + var_88_13 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_6) / var_88_13

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_6 + var_88_13 and arg_85_1.time_ < var_88_6 + var_88_13 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play1109302022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 1109302022
		arg_89_1.duration_ = 19.9

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play1109302023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["1093ui_story"]
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect1093ui_story == nil then
				arg_89_1.var_.characterEffect1093ui_story = var_92_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.2

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 and not isNil(var_92_0) then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2

				if arg_89_1.var_.characterEffect1093ui_story and not isNil(var_92_0) then
					arg_89_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect1093ui_story then
				arg_89_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_92_4 = 0

			if var_92_4 < arg_89_1.time_ and arg_89_1.time_ <= var_92_4 + arg_92_0 then
				arg_89_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action494")
			end

			local var_92_5 = 0

			if var_92_5 < arg_89_1.time_ and arg_89_1.time_ <= var_92_5 + arg_92_0 then
				arg_89_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_92_6 = 0
			local var_92_7 = 1.2

			if var_92_6 < arg_89_1.time_ and arg_89_1.time_ <= var_92_6 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_8 = arg_89_1:FormatText(StoryNameCfg[73].name)

				arg_89_1.leftNameTxt_.text = var_92_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_9 = arg_89_1:GetWordFromCfg(1109302022)
				local var_92_10 = arg_89_1:FormatText(var_92_9.content)

				arg_89_1.text_.text = var_92_10

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_11 = 48
				local var_92_12 = utf8.len(var_92_10)
				local var_92_13 = var_92_11 <= 0 and var_92_7 or var_92_7 * (var_92_12 / var_92_11)

				if var_92_13 > 0 and var_92_7 < var_92_13 then
					arg_89_1.talkMaxDuration = var_92_13

					if var_92_13 + var_92_6 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_13 + var_92_6
					end
				end

				arg_89_1.text_.text = var_92_10
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302022", "story_v_side_new_1109302.awb") ~= 0 then
					local var_92_14 = manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302022", "story_v_side_new_1109302.awb") / 1000

					if var_92_14 + var_92_6 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_14 + var_92_6
					end

					if var_92_9.prefab_name ~= "" and arg_89_1.actors_[var_92_9.prefab_name] ~= nil then
						local var_92_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_9.prefab_name].transform, "story_v_side_new_1109302", "1109302022", "story_v_side_new_1109302.awb")

						arg_89_1:RecordAudio("1109302022", var_92_15)
						arg_89_1:RecordAudio("1109302022", var_92_15)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_side_new_1109302", "1109302022", "story_v_side_new_1109302.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_side_new_1109302", "1109302022", "story_v_side_new_1109302.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_16 = math.max(var_92_7, arg_89_1.talkMaxDuration)

			if var_92_6 <= arg_89_1.time_ and arg_89_1.time_ < var_92_6 + var_92_16 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_6) / var_92_16

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_6 + var_92_16 and arg_89_1.time_ < var_92_6 + var_92_16 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play1109302023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 1109302023
		arg_93_1.duration_ = 15.27

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play1109302024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0

			if var_96_0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				arg_93_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_96_1 = 0
			local var_96_2 = 1.05

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_3 = arg_93_1:FormatText(StoryNameCfg[73].name)

				arg_93_1.leftNameTxt_.text = var_96_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_4 = arg_93_1:GetWordFromCfg(1109302023)
				local var_96_5 = arg_93_1:FormatText(var_96_4.content)

				arg_93_1.text_.text = var_96_5

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_6 = 42
				local var_96_7 = utf8.len(var_96_5)
				local var_96_8 = var_96_6 <= 0 and var_96_2 or var_96_2 * (var_96_7 / var_96_6)

				if var_96_8 > 0 and var_96_2 < var_96_8 then
					arg_93_1.talkMaxDuration = var_96_8

					if var_96_8 + var_96_1 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_8 + var_96_1
					end
				end

				arg_93_1.text_.text = var_96_5
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302023", "story_v_side_new_1109302.awb") ~= 0 then
					local var_96_9 = manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302023", "story_v_side_new_1109302.awb") / 1000

					if var_96_9 + var_96_1 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_9 + var_96_1
					end

					if var_96_4.prefab_name ~= "" and arg_93_1.actors_[var_96_4.prefab_name] ~= nil then
						local var_96_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_4.prefab_name].transform, "story_v_side_new_1109302", "1109302023", "story_v_side_new_1109302.awb")

						arg_93_1:RecordAudio("1109302023", var_96_10)
						arg_93_1:RecordAudio("1109302023", var_96_10)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_side_new_1109302", "1109302023", "story_v_side_new_1109302.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_side_new_1109302", "1109302023", "story_v_side_new_1109302.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_11 = math.max(var_96_2, arg_93_1.talkMaxDuration)

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_11 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_1) / var_96_11

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_1 + var_96_11 and arg_93_1.time_ < var_96_1 + var_96_11 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play1109302024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 1109302024
		arg_97_1.duration_ = 13.83

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play1109302025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0

			if var_100_0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_100_1 = 0
			local var_100_2 = 1.5

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_3 = arg_97_1:FormatText(StoryNameCfg[73].name)

				arg_97_1.leftNameTxt_.text = var_100_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_4 = arg_97_1:GetWordFromCfg(1109302024)
				local var_100_5 = arg_97_1:FormatText(var_100_4.content)

				arg_97_1.text_.text = var_100_5

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_6 = 60
				local var_100_7 = utf8.len(var_100_5)
				local var_100_8 = var_100_6 <= 0 and var_100_2 or var_100_2 * (var_100_7 / var_100_6)

				if var_100_8 > 0 and var_100_2 < var_100_8 then
					arg_97_1.talkMaxDuration = var_100_8

					if var_100_8 + var_100_1 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_8 + var_100_1
					end
				end

				arg_97_1.text_.text = var_100_5
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302024", "story_v_side_new_1109302.awb") ~= 0 then
					local var_100_9 = manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302024", "story_v_side_new_1109302.awb") / 1000

					if var_100_9 + var_100_1 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_9 + var_100_1
					end

					if var_100_4.prefab_name ~= "" and arg_97_1.actors_[var_100_4.prefab_name] ~= nil then
						local var_100_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_4.prefab_name].transform, "story_v_side_new_1109302", "1109302024", "story_v_side_new_1109302.awb")

						arg_97_1:RecordAudio("1109302024", var_100_10)
						arg_97_1:RecordAudio("1109302024", var_100_10)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_side_new_1109302", "1109302024", "story_v_side_new_1109302.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_side_new_1109302", "1109302024", "story_v_side_new_1109302.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_11 = math.max(var_100_2, arg_97_1.talkMaxDuration)

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_11 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_1) / var_100_11

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_1 + var_100_11 and arg_97_1.time_ < var_100_1 + var_100_11 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play1109302025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 1109302025
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play1109302026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["1093ui_story"]
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect1093ui_story == nil then
				arg_101_1.var_.characterEffect1093ui_story = var_104_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.2

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 and not isNil(var_104_0) then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2

				if arg_101_1.var_.characterEffect1093ui_story and not isNil(var_104_0) then
					local var_104_4 = Mathf.Lerp(0, 0.5, var_104_3)

					arg_101_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1093ui_story.fillRatio = var_104_4
				end
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect1093ui_story then
				local var_104_5 = 0.5

				arg_101_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1093ui_story.fillRatio = var_104_5
			end

			local var_104_6 = 0
			local var_104_7 = 0.4

			if var_104_6 < arg_101_1.time_ and arg_101_1.time_ <= var_104_6 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_8 = arg_101_1:FormatText(StoryNameCfg[7].name)

				arg_101_1.leftNameTxt_.text = var_104_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_9 = arg_101_1:GetWordFromCfg(1109302025)
				local var_104_10 = arg_101_1:FormatText(var_104_9.content)

				arg_101_1.text_.text = var_104_10

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_11 = 16
				local var_104_12 = utf8.len(var_104_10)
				local var_104_13 = var_104_11 <= 0 and var_104_7 or var_104_7 * (var_104_12 / var_104_11)

				if var_104_13 > 0 and var_104_7 < var_104_13 then
					arg_101_1.talkMaxDuration = var_104_13

					if var_104_13 + var_104_6 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_13 + var_104_6
					end
				end

				arg_101_1.text_.text = var_104_10
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_14 = math.max(var_104_7, arg_101_1.talkMaxDuration)

			if var_104_6 <= arg_101_1.time_ and arg_101_1.time_ < var_104_6 + var_104_14 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_6) / var_104_14

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_6 + var_104_14 and arg_101_1.time_ < var_104_6 + var_104_14 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play1109302026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 1109302026
		arg_105_1.duration_ = 7.6

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play1109302027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["1093ui_story"]
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect1093ui_story == nil then
				arg_105_1.var_.characterEffect1093ui_story = var_108_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_2 = 0.2

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 and not isNil(var_108_0) then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2

				if arg_105_1.var_.characterEffect1093ui_story and not isNil(var_108_0) then
					arg_105_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect1093ui_story then
				arg_105_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_108_4 = 0
			local var_108_5 = 0.05

			if var_108_4 < arg_105_1.time_ and arg_105_1.time_ <= var_108_4 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_6 = arg_105_1:FormatText(StoryNameCfg[73].name)

				arg_105_1.leftNameTxt_.text = var_108_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_7 = arg_105_1:GetWordFromCfg(1109302026)
				local var_108_8 = arg_105_1:FormatText(var_108_7.content)

				arg_105_1.text_.text = var_108_8

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_9 = 2
				local var_108_10 = utf8.len(var_108_8)
				local var_108_11 = var_108_9 <= 0 and var_108_5 or var_108_5 * (var_108_10 / var_108_9)

				if var_108_11 > 0 and var_108_5 < var_108_11 then
					arg_105_1.talkMaxDuration = var_108_11

					if var_108_11 + var_108_4 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_11 + var_108_4
					end
				end

				arg_105_1.text_.text = var_108_8
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302026", "story_v_side_new_1109302.awb") ~= 0 then
					local var_108_12 = manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302026", "story_v_side_new_1109302.awb") / 1000

					if var_108_12 + var_108_4 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_12 + var_108_4
					end

					if var_108_7.prefab_name ~= "" and arg_105_1.actors_[var_108_7.prefab_name] ~= nil then
						local var_108_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_7.prefab_name].transform, "story_v_side_new_1109302", "1109302026", "story_v_side_new_1109302.awb")

						arg_105_1:RecordAudio("1109302026", var_108_13)
						arg_105_1:RecordAudio("1109302026", var_108_13)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_side_new_1109302", "1109302026", "story_v_side_new_1109302.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_side_new_1109302", "1109302026", "story_v_side_new_1109302.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_14 = math.max(var_108_5, arg_105_1.talkMaxDuration)

			if var_108_4 <= arg_105_1.time_ and arg_105_1.time_ < var_108_4 + var_108_14 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_4) / var_108_14

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_4 + var_108_14 and arg_105_1.time_ < var_108_4 + var_108_14 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play1109302027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 1109302027
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play1109302028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["1093ui_story"]
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect1093ui_story == nil then
				arg_109_1.var_.characterEffect1093ui_story = var_112_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.2

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 and not isNil(var_112_0) then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2

				if arg_109_1.var_.characterEffect1093ui_story and not isNil(var_112_0) then
					local var_112_4 = Mathf.Lerp(0, 0.5, var_112_3)

					arg_109_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_109_1.var_.characterEffect1093ui_story.fillRatio = var_112_4
				end
			end

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect1093ui_story then
				local var_112_5 = 0.5

				arg_109_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_109_1.var_.characterEffect1093ui_story.fillRatio = var_112_5
			end

			local var_112_6 = 0
			local var_112_7 = 0.65

			if var_112_6 < arg_109_1.time_ and arg_109_1.time_ <= var_112_6 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_8 = arg_109_1:GetWordFromCfg(1109302027)
				local var_112_9 = arg_109_1:FormatText(var_112_8.content)

				arg_109_1.text_.text = var_112_9

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_10 = 26
				local var_112_11 = utf8.len(var_112_9)
				local var_112_12 = var_112_10 <= 0 and var_112_7 or var_112_7 * (var_112_11 / var_112_10)

				if var_112_12 > 0 and var_112_7 < var_112_12 then
					arg_109_1.talkMaxDuration = var_112_12

					if var_112_12 + var_112_6 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_12 + var_112_6
					end
				end

				arg_109_1.text_.text = var_112_9
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_13 = math.max(var_112_7, arg_109_1.talkMaxDuration)

			if var_112_6 <= arg_109_1.time_ and arg_109_1.time_ < var_112_6 + var_112_13 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_6) / var_112_13

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_6 + var_112_13 and arg_109_1.time_ < var_112_6 + var_112_13 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play1109302028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 1109302028
		arg_113_1.duration_ = 11.4

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play1109302029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0

			if var_116_0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_0 + arg_116_0 then
				arg_113_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action447")
			end

			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_116_2 = arg_113_1.actors_["1093ui_story"]
			local var_116_3 = 0

			if var_116_3 < arg_113_1.time_ and arg_113_1.time_ <= var_116_3 + arg_116_0 and not isNil(var_116_2) and arg_113_1.var_.characterEffect1093ui_story == nil then
				arg_113_1.var_.characterEffect1093ui_story = var_116_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_4 = 0.2

			if var_116_3 <= arg_113_1.time_ and arg_113_1.time_ < var_116_3 + var_116_4 and not isNil(var_116_2) then
				local var_116_5 = (arg_113_1.time_ - var_116_3) / var_116_4

				if arg_113_1.var_.characterEffect1093ui_story and not isNil(var_116_2) then
					arg_113_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= var_116_3 + var_116_4 and arg_113_1.time_ < var_116_3 + var_116_4 + arg_116_0 and not isNil(var_116_2) and arg_113_1.var_.characterEffect1093ui_story then
				arg_113_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_116_6 = 0
			local var_116_7 = 0.65

			if var_116_6 < arg_113_1.time_ and arg_113_1.time_ <= var_116_6 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_8 = arg_113_1:FormatText(StoryNameCfg[73].name)

				arg_113_1.leftNameTxt_.text = var_116_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_9 = arg_113_1:GetWordFromCfg(1109302028)
				local var_116_10 = arg_113_1:FormatText(var_116_9.content)

				arg_113_1.text_.text = var_116_10

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_11 = 26
				local var_116_12 = utf8.len(var_116_10)
				local var_116_13 = var_116_11 <= 0 and var_116_7 or var_116_7 * (var_116_12 / var_116_11)

				if var_116_13 > 0 and var_116_7 < var_116_13 then
					arg_113_1.talkMaxDuration = var_116_13

					if var_116_13 + var_116_6 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_13 + var_116_6
					end
				end

				arg_113_1.text_.text = var_116_10
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302028", "story_v_side_new_1109302.awb") ~= 0 then
					local var_116_14 = manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302028", "story_v_side_new_1109302.awb") / 1000

					if var_116_14 + var_116_6 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_14 + var_116_6
					end

					if var_116_9.prefab_name ~= "" and arg_113_1.actors_[var_116_9.prefab_name] ~= nil then
						local var_116_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_9.prefab_name].transform, "story_v_side_new_1109302", "1109302028", "story_v_side_new_1109302.awb")

						arg_113_1:RecordAudio("1109302028", var_116_15)
						arg_113_1:RecordAudio("1109302028", var_116_15)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_side_new_1109302", "1109302028", "story_v_side_new_1109302.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_side_new_1109302", "1109302028", "story_v_side_new_1109302.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_16 = math.max(var_116_7, arg_113_1.talkMaxDuration)

			if var_116_6 <= arg_113_1.time_ and arg_113_1.time_ < var_116_6 + var_116_16 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_6) / var_116_16

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_6 + var_116_16 and arg_113_1.time_ < var_116_6 + var_116_16 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play1109302029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 1109302029
		arg_117_1.duration_ = 15.77

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play1109302030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0

			if var_120_0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_0 + arg_120_0 then
				arg_117_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_120_1 = 0
			local var_120_2 = 1.25

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_3 = arg_117_1:FormatText(StoryNameCfg[73].name)

				arg_117_1.leftNameTxt_.text = var_120_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_4 = arg_117_1:GetWordFromCfg(1109302029)
				local var_120_5 = arg_117_1:FormatText(var_120_4.content)

				arg_117_1.text_.text = var_120_5

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_6 = 50
				local var_120_7 = utf8.len(var_120_5)
				local var_120_8 = var_120_6 <= 0 and var_120_2 or var_120_2 * (var_120_7 / var_120_6)

				if var_120_8 > 0 and var_120_2 < var_120_8 then
					arg_117_1.talkMaxDuration = var_120_8

					if var_120_8 + var_120_1 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_8 + var_120_1
					end
				end

				arg_117_1.text_.text = var_120_5
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302029", "story_v_side_new_1109302.awb") ~= 0 then
					local var_120_9 = manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302029", "story_v_side_new_1109302.awb") / 1000

					if var_120_9 + var_120_1 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_9 + var_120_1
					end

					if var_120_4.prefab_name ~= "" and arg_117_1.actors_[var_120_4.prefab_name] ~= nil then
						local var_120_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_4.prefab_name].transform, "story_v_side_new_1109302", "1109302029", "story_v_side_new_1109302.awb")

						arg_117_1:RecordAudio("1109302029", var_120_10)
						arg_117_1:RecordAudio("1109302029", var_120_10)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_side_new_1109302", "1109302029", "story_v_side_new_1109302.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_side_new_1109302", "1109302029", "story_v_side_new_1109302.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_11 = math.max(var_120_2, arg_117_1.talkMaxDuration)

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_11 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_1) / var_120_11

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_1 + var_120_11 and arg_117_1.time_ < var_120_1 + var_120_11 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play1109302030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 1109302030
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play1109302031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["1093ui_story"]
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.characterEffect1093ui_story == nil then
				arg_121_1.var_.characterEffect1093ui_story = var_124_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_2 = 0.2

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_2 and not isNil(var_124_0) then
				local var_124_3 = (arg_121_1.time_ - var_124_1) / var_124_2

				if arg_121_1.var_.characterEffect1093ui_story and not isNil(var_124_0) then
					local var_124_4 = Mathf.Lerp(0, 0.5, var_124_3)

					arg_121_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1093ui_story.fillRatio = var_124_4
				end
			end

			if arg_121_1.time_ >= var_124_1 + var_124_2 and arg_121_1.time_ < var_124_1 + var_124_2 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.characterEffect1093ui_story then
				local var_124_5 = 0.5

				arg_121_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1093ui_story.fillRatio = var_124_5
			end

			local var_124_6 = 0
			local var_124_7 = 0.45

			if var_124_6 < arg_121_1.time_ and arg_121_1.time_ <= var_124_6 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_8 = arg_121_1:FormatText(StoryNameCfg[7].name)

				arg_121_1.leftNameTxt_.text = var_124_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, true)
				arg_121_1.iconController_:SetSelectedState("hero")

				arg_121_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_121_1.callingController_:SetSelectedState("normal")

				arg_121_1.keyicon_.color = Color.New(1, 1, 1)
				arg_121_1.icon_.color = Color.New(1, 1, 1)

				local var_124_9 = arg_121_1:GetWordFromCfg(1109302030)
				local var_124_10 = arg_121_1:FormatText(var_124_9.content)

				arg_121_1.text_.text = var_124_10

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_11 = 18
				local var_124_12 = utf8.len(var_124_10)
				local var_124_13 = var_124_11 <= 0 and var_124_7 or var_124_7 * (var_124_12 / var_124_11)

				if var_124_13 > 0 and var_124_7 < var_124_13 then
					arg_121_1.talkMaxDuration = var_124_13

					if var_124_13 + var_124_6 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_13 + var_124_6
					end
				end

				arg_121_1.text_.text = var_124_10
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_14 = math.max(var_124_7, arg_121_1.talkMaxDuration)

			if var_124_6 <= arg_121_1.time_ and arg_121_1.time_ < var_124_6 + var_124_14 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_6) / var_124_14

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_6 + var_124_14 and arg_121_1.time_ < var_124_6 + var_124_14 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play1109302031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 1109302031
		arg_125_1.duration_ = 16.3

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play1109302032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0

			if var_128_0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_0 + arg_128_0 then
				arg_125_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_128_1 = arg_125_1.actors_["1093ui_story"]
			local var_128_2 = 0

			if var_128_2 < arg_125_1.time_ and arg_125_1.time_ <= var_128_2 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect1093ui_story == nil then
				arg_125_1.var_.characterEffect1093ui_story = var_128_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_3 = 0.2

			if var_128_2 <= arg_125_1.time_ and arg_125_1.time_ < var_128_2 + var_128_3 and not isNil(var_128_1) then
				local var_128_4 = (arg_125_1.time_ - var_128_2) / var_128_3

				if arg_125_1.var_.characterEffect1093ui_story and not isNil(var_128_1) then
					arg_125_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= var_128_2 + var_128_3 and arg_125_1.time_ < var_128_2 + var_128_3 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect1093ui_story then
				arg_125_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_128_5 = 0
			local var_128_6 = 0.975

			if var_128_5 < arg_125_1.time_ and arg_125_1.time_ <= var_128_5 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_7 = arg_125_1:FormatText(StoryNameCfg[73].name)

				arg_125_1.leftNameTxt_.text = var_128_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_8 = arg_125_1:GetWordFromCfg(1109302031)
				local var_128_9 = arg_125_1:FormatText(var_128_8.content)

				arg_125_1.text_.text = var_128_9

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_10 = 39
				local var_128_11 = utf8.len(var_128_9)
				local var_128_12 = var_128_10 <= 0 and var_128_6 or var_128_6 * (var_128_11 / var_128_10)

				if var_128_12 > 0 and var_128_6 < var_128_12 then
					arg_125_1.talkMaxDuration = var_128_12

					if var_128_12 + var_128_5 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_12 + var_128_5
					end
				end

				arg_125_1.text_.text = var_128_9
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302031", "story_v_side_new_1109302.awb") ~= 0 then
					local var_128_13 = manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302031", "story_v_side_new_1109302.awb") / 1000

					if var_128_13 + var_128_5 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_13 + var_128_5
					end

					if var_128_8.prefab_name ~= "" and arg_125_1.actors_[var_128_8.prefab_name] ~= nil then
						local var_128_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_8.prefab_name].transform, "story_v_side_new_1109302", "1109302031", "story_v_side_new_1109302.awb")

						arg_125_1:RecordAudio("1109302031", var_128_14)
						arg_125_1:RecordAudio("1109302031", var_128_14)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_side_new_1109302", "1109302031", "story_v_side_new_1109302.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_side_new_1109302", "1109302031", "story_v_side_new_1109302.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_15 = math.max(var_128_6, arg_125_1.talkMaxDuration)

			if var_128_5 <= arg_125_1.time_ and arg_125_1.time_ < var_128_5 + var_128_15 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_5) / var_128_15

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_5 + var_128_15 and arg_125_1.time_ < var_128_5 + var_128_15 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play1109302032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 1109302032
		arg_129_1.duration_ = 7.07

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play1109302033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0

			if var_132_0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_0 + arg_132_0 then
				arg_129_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_132_1 = 0
			local var_132_2 = 0.55

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_3 = arg_129_1:FormatText(StoryNameCfg[73].name)

				arg_129_1.leftNameTxt_.text = var_132_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_4 = arg_129_1:GetWordFromCfg(1109302032)
				local var_132_5 = arg_129_1:FormatText(var_132_4.content)

				arg_129_1.text_.text = var_132_5

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_6 = 22
				local var_132_7 = utf8.len(var_132_5)
				local var_132_8 = var_132_6 <= 0 and var_132_2 or var_132_2 * (var_132_7 / var_132_6)

				if var_132_8 > 0 and var_132_2 < var_132_8 then
					arg_129_1.talkMaxDuration = var_132_8

					if var_132_8 + var_132_1 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_8 + var_132_1
					end
				end

				arg_129_1.text_.text = var_132_5
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302032", "story_v_side_new_1109302.awb") ~= 0 then
					local var_132_9 = manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302032", "story_v_side_new_1109302.awb") / 1000

					if var_132_9 + var_132_1 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_9 + var_132_1
					end

					if var_132_4.prefab_name ~= "" and arg_129_1.actors_[var_132_4.prefab_name] ~= nil then
						local var_132_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_4.prefab_name].transform, "story_v_side_new_1109302", "1109302032", "story_v_side_new_1109302.awb")

						arg_129_1:RecordAudio("1109302032", var_132_10)
						arg_129_1:RecordAudio("1109302032", var_132_10)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_side_new_1109302", "1109302032", "story_v_side_new_1109302.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_side_new_1109302", "1109302032", "story_v_side_new_1109302.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_11 = math.max(var_132_2, arg_129_1.talkMaxDuration)

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_11 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_1) / var_132_11

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_1 + var_132_11 and arg_129_1.time_ < var_132_1 + var_132_11 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play1109302033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 1109302033
		arg_133_1.duration_ = 7.83

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play1109302034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0

			if var_136_0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_0 + arg_136_0 then
				arg_133_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_136_1 = 0
			local var_136_2 = 0.7

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_3 = arg_133_1:FormatText(StoryNameCfg[73].name)

				arg_133_1.leftNameTxt_.text = var_136_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_4 = arg_133_1:GetWordFromCfg(1109302033)
				local var_136_5 = arg_133_1:FormatText(var_136_4.content)

				arg_133_1.text_.text = var_136_5

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_6 = 28
				local var_136_7 = utf8.len(var_136_5)
				local var_136_8 = var_136_6 <= 0 and var_136_2 or var_136_2 * (var_136_7 / var_136_6)

				if var_136_8 > 0 and var_136_2 < var_136_8 then
					arg_133_1.talkMaxDuration = var_136_8

					if var_136_8 + var_136_1 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_8 + var_136_1
					end
				end

				arg_133_1.text_.text = var_136_5
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302033", "story_v_side_new_1109302.awb") ~= 0 then
					local var_136_9 = manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302033", "story_v_side_new_1109302.awb") / 1000

					if var_136_9 + var_136_1 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_9 + var_136_1
					end

					if var_136_4.prefab_name ~= "" and arg_133_1.actors_[var_136_4.prefab_name] ~= nil then
						local var_136_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_4.prefab_name].transform, "story_v_side_new_1109302", "1109302033", "story_v_side_new_1109302.awb")

						arg_133_1:RecordAudio("1109302033", var_136_10)
						arg_133_1:RecordAudio("1109302033", var_136_10)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_side_new_1109302", "1109302033", "story_v_side_new_1109302.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_side_new_1109302", "1109302033", "story_v_side_new_1109302.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_11 = math.max(var_136_2, arg_133_1.talkMaxDuration)

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_11 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_1) / var_136_11

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_1 + var_136_11 and arg_133_1.time_ < var_136_1 + var_136_11 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play1109302034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 1109302034
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play1109302035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["1093ui_story"]
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect1093ui_story == nil then
				arg_137_1.var_.characterEffect1093ui_story = var_140_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_2 = 0.2

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 and not isNil(var_140_0) then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2

				if arg_137_1.var_.characterEffect1093ui_story and not isNil(var_140_0) then
					local var_140_4 = Mathf.Lerp(0, 0.5, var_140_3)

					arg_137_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_137_1.var_.characterEffect1093ui_story.fillRatio = var_140_4
				end
			end

			if arg_137_1.time_ >= var_140_1 + var_140_2 and arg_137_1.time_ < var_140_1 + var_140_2 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect1093ui_story then
				local var_140_5 = 0.5

				arg_137_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_137_1.var_.characterEffect1093ui_story.fillRatio = var_140_5
			end

			local var_140_6 = 0
			local var_140_7 = 0.05

			if var_140_6 < arg_137_1.time_ and arg_137_1.time_ <= var_140_6 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_8 = arg_137_1:FormatText(StoryNameCfg[7].name)

				arg_137_1.leftNameTxt_.text = var_140_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, true)
				arg_137_1.iconController_:SetSelectedState("hero")

				arg_137_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_137_1.callingController_:SetSelectedState("normal")

				arg_137_1.keyicon_.color = Color.New(1, 1, 1)
				arg_137_1.icon_.color = Color.New(1, 1, 1)

				local var_140_9 = arg_137_1:GetWordFromCfg(1109302034)
				local var_140_10 = arg_137_1:FormatText(var_140_9.content)

				arg_137_1.text_.text = var_140_10

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_11 = 2
				local var_140_12 = utf8.len(var_140_10)
				local var_140_13 = var_140_11 <= 0 and var_140_7 or var_140_7 * (var_140_12 / var_140_11)

				if var_140_13 > 0 and var_140_7 < var_140_13 then
					arg_137_1.talkMaxDuration = var_140_13

					if var_140_13 + var_140_6 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_13 + var_140_6
					end
				end

				arg_137_1.text_.text = var_140_10
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_14 = math.max(var_140_7, arg_137_1.talkMaxDuration)

			if var_140_6 <= arg_137_1.time_ and arg_137_1.time_ < var_140_6 + var_140_14 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_6) / var_140_14

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_6 + var_140_14 and arg_137_1.time_ < var_140_6 + var_140_14 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play1109302035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 1109302035
		arg_141_1.duration_ = 4.67

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play1109302036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["1093ui_story"]
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect1093ui_story == nil then
				arg_141_1.var_.characterEffect1093ui_story = var_144_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_2 = 0.2

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 and not isNil(var_144_0) then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / var_144_2

				if arg_141_1.var_.characterEffect1093ui_story and not isNil(var_144_0) then
					arg_141_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect1093ui_story then
				arg_141_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_144_4 = 0

			if var_144_4 < arg_141_1.time_ and arg_141_1.time_ <= var_144_4 + arg_144_0 then
				arg_141_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_144_5 = 0
			local var_144_6 = 0.575

			if var_144_5 < arg_141_1.time_ and arg_141_1.time_ <= var_144_5 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_7 = arg_141_1:FormatText(StoryNameCfg[73].name)

				arg_141_1.leftNameTxt_.text = var_144_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_8 = arg_141_1:GetWordFromCfg(1109302035)
				local var_144_9 = arg_141_1:FormatText(var_144_8.content)

				arg_141_1.text_.text = var_144_9

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_10 = 23
				local var_144_11 = utf8.len(var_144_9)
				local var_144_12 = var_144_10 <= 0 and var_144_6 or var_144_6 * (var_144_11 / var_144_10)

				if var_144_12 > 0 and var_144_6 < var_144_12 then
					arg_141_1.talkMaxDuration = var_144_12

					if var_144_12 + var_144_5 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_12 + var_144_5
					end
				end

				arg_141_1.text_.text = var_144_9
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302035", "story_v_side_new_1109302.awb") ~= 0 then
					local var_144_13 = manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302035", "story_v_side_new_1109302.awb") / 1000

					if var_144_13 + var_144_5 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_13 + var_144_5
					end

					if var_144_8.prefab_name ~= "" and arg_141_1.actors_[var_144_8.prefab_name] ~= nil then
						local var_144_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_8.prefab_name].transform, "story_v_side_new_1109302", "1109302035", "story_v_side_new_1109302.awb")

						arg_141_1:RecordAudio("1109302035", var_144_14)
						arg_141_1:RecordAudio("1109302035", var_144_14)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_side_new_1109302", "1109302035", "story_v_side_new_1109302.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_side_new_1109302", "1109302035", "story_v_side_new_1109302.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_15 = math.max(var_144_6, arg_141_1.talkMaxDuration)

			if var_144_5 <= arg_141_1.time_ and arg_141_1.time_ < var_144_5 + var_144_15 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_5) / var_144_15

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_5 + var_144_15 and arg_141_1.time_ < var_144_5 + var_144_15 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play1109302036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 1109302036
		arg_145_1.duration_ = 14.93

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play1109302037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0

			if var_148_0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_0 + arg_148_0 then
				arg_145_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action478")
			end

			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 then
				arg_145_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_148_2 = 0
			local var_148_3 = 1.275

			if var_148_2 < arg_145_1.time_ and arg_145_1.time_ <= var_148_2 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_4 = arg_145_1:FormatText(StoryNameCfg[73].name)

				arg_145_1.leftNameTxt_.text = var_148_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_5 = arg_145_1:GetWordFromCfg(1109302036)
				local var_148_6 = arg_145_1:FormatText(var_148_5.content)

				arg_145_1.text_.text = var_148_6

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_7 = 50
				local var_148_8 = utf8.len(var_148_6)
				local var_148_9 = var_148_7 <= 0 and var_148_3 or var_148_3 * (var_148_8 / var_148_7)

				if var_148_9 > 0 and var_148_3 < var_148_9 then
					arg_145_1.talkMaxDuration = var_148_9

					if var_148_9 + var_148_2 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_9 + var_148_2
					end
				end

				arg_145_1.text_.text = var_148_6
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302036", "story_v_side_new_1109302.awb") ~= 0 then
					local var_148_10 = manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302036", "story_v_side_new_1109302.awb") / 1000

					if var_148_10 + var_148_2 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_10 + var_148_2
					end

					if var_148_5.prefab_name ~= "" and arg_145_1.actors_[var_148_5.prefab_name] ~= nil then
						local var_148_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_5.prefab_name].transform, "story_v_side_new_1109302", "1109302036", "story_v_side_new_1109302.awb")

						arg_145_1:RecordAudio("1109302036", var_148_11)
						arg_145_1:RecordAudio("1109302036", var_148_11)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_side_new_1109302", "1109302036", "story_v_side_new_1109302.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_side_new_1109302", "1109302036", "story_v_side_new_1109302.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_12 = math.max(var_148_3, arg_145_1.talkMaxDuration)

			if var_148_2 <= arg_145_1.time_ and arg_145_1.time_ < var_148_2 + var_148_12 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_2) / var_148_12

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_2 + var_148_12 and arg_145_1.time_ < var_148_2 + var_148_12 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play1109302037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 1109302037
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play1109302038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["1093ui_story"]
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.characterEffect1093ui_story == nil then
				arg_149_1.var_.characterEffect1093ui_story = var_152_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_2 = 0.2

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_2 and not isNil(var_152_0) then
				local var_152_3 = (arg_149_1.time_ - var_152_1) / var_152_2

				if arg_149_1.var_.characterEffect1093ui_story and not isNil(var_152_0) then
					local var_152_4 = Mathf.Lerp(0, 0.5, var_152_3)

					arg_149_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_149_1.var_.characterEffect1093ui_story.fillRatio = var_152_4
				end
			end

			if arg_149_1.time_ >= var_152_1 + var_152_2 and arg_149_1.time_ < var_152_1 + var_152_2 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.characterEffect1093ui_story then
				local var_152_5 = 0.5

				arg_149_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_149_1.var_.characterEffect1093ui_story.fillRatio = var_152_5
			end

			local var_152_6 = 0
			local var_152_7 = 0.675

			if var_152_6 < arg_149_1.time_ and arg_149_1.time_ <= var_152_6 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, false)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_8 = arg_149_1:GetWordFromCfg(1109302037)
				local var_152_9 = arg_149_1:FormatText(var_152_8.content)

				arg_149_1.text_.text = var_152_9

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_10 = 27
				local var_152_11 = utf8.len(var_152_9)
				local var_152_12 = var_152_10 <= 0 and var_152_7 or var_152_7 * (var_152_11 / var_152_10)

				if var_152_12 > 0 and var_152_7 < var_152_12 then
					arg_149_1.talkMaxDuration = var_152_12

					if var_152_12 + var_152_6 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_12 + var_152_6
					end
				end

				arg_149_1.text_.text = var_152_9
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_13 = math.max(var_152_7, arg_149_1.talkMaxDuration)

			if var_152_6 <= arg_149_1.time_ and arg_149_1.time_ < var_152_6 + var_152_13 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_6) / var_152_13

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_6 + var_152_13 and arg_149_1.time_ < var_152_6 + var_152_13 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play1109302038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 1109302038
		arg_153_1.duration_ = 13.57

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play1109302039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["1093ui_story"]
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.characterEffect1093ui_story == nil then
				arg_153_1.var_.characterEffect1093ui_story = var_156_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_2 = 0.2

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_2 and not isNil(var_156_0) then
				local var_156_3 = (arg_153_1.time_ - var_156_1) / var_156_2

				if arg_153_1.var_.characterEffect1093ui_story and not isNil(var_156_0) then
					arg_153_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= var_156_1 + var_156_2 and arg_153_1.time_ < var_156_1 + var_156_2 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.characterEffect1093ui_story then
				arg_153_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_156_4 = 0

			if var_156_4 < arg_153_1.time_ and arg_153_1.time_ <= var_156_4 + arg_156_0 then
				arg_153_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action486")
			end

			local var_156_5 = 0

			if var_156_5 < arg_153_1.time_ and arg_153_1.time_ <= var_156_5 + arg_156_0 then
				arg_153_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_156_6 = 0
			local var_156_7 = 1

			if var_156_6 < arg_153_1.time_ and arg_153_1.time_ <= var_156_6 + arg_156_0 then
				local var_156_8 = "play"
				local var_156_9 = "music"

				arg_153_1:AudioAction(var_156_8, var_156_9, "ui_battle", "ui_battle_stopbgm", "")

				local var_156_10 = ""
				local var_156_11 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_156_11 ~= "" then
					if arg_153_1.bgmTxt_.text ~= var_156_11 and arg_153_1.bgmTxt_.text ~= "" then
						if arg_153_1.bgmTxt2_.text ~= "" then
							arg_153_1.bgmTxt_.text = arg_153_1.bgmTxt2_.text
						end

						arg_153_1.bgmTxt2_.text = var_156_11

						arg_153_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_153_1.bgmTxt_.text = var_156_11
						arg_153_1.bgmTxt2_.text = var_156_11
					end

					if arg_153_1.bgmTimer then
						arg_153_1.bgmTimer:Stop()

						arg_153_1.bgmTimer = nil
					end

					if arg_153_1.settingData.show_music_name == 1 then
						arg_153_1.musicController:SetSelectedState("show")
						arg_153_1.musicAnimator_:Play("open", 0, 0)

						if arg_153_1.settingData.music_time ~= 0 then
							arg_153_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_153_1.settingData.music_time), function()
								if arg_153_1 == nil or isNil(arg_153_1.bgmTxt_) then
									return
								end

								arg_153_1.musicController:SetSelectedState("hide")
								arg_153_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_156_12 = 0
			local var_156_13 = 1.65

			if var_156_12 < arg_153_1.time_ and arg_153_1.time_ <= var_156_12 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_14 = arg_153_1:FormatText(StoryNameCfg[73].name)

				arg_153_1.leftNameTxt_.text = var_156_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_15 = arg_153_1:GetWordFromCfg(1109302038)
				local var_156_16 = arg_153_1:FormatText(var_156_15.content)

				arg_153_1.text_.text = var_156_16

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_17 = 65
				local var_156_18 = utf8.len(var_156_16)
				local var_156_19 = var_156_17 <= 0 and var_156_13 or var_156_13 * (var_156_18 / var_156_17)

				if var_156_19 > 0 and var_156_13 < var_156_19 then
					arg_153_1.talkMaxDuration = var_156_19

					if var_156_19 + var_156_12 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_19 + var_156_12
					end
				end

				arg_153_1.text_.text = var_156_16
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302038", "story_v_side_new_1109302.awb") ~= 0 then
					local var_156_20 = manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302038", "story_v_side_new_1109302.awb") / 1000

					if var_156_20 + var_156_12 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_20 + var_156_12
					end

					if var_156_15.prefab_name ~= "" and arg_153_1.actors_[var_156_15.prefab_name] ~= nil then
						local var_156_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_15.prefab_name].transform, "story_v_side_new_1109302", "1109302038", "story_v_side_new_1109302.awb")

						arg_153_1:RecordAudio("1109302038", var_156_21)
						arg_153_1:RecordAudio("1109302038", var_156_21)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_side_new_1109302", "1109302038", "story_v_side_new_1109302.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_side_new_1109302", "1109302038", "story_v_side_new_1109302.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_22 = math.max(var_156_13, arg_153_1.talkMaxDuration)

			if var_156_12 <= arg_153_1.time_ and arg_153_1.time_ < var_156_12 + var_156_22 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_12) / var_156_22

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_12 + var_156_22 and arg_153_1.time_ < var_156_12 + var_156_22 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play1109302039 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 1109302039
		arg_158_1.duration_ = 10.2

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play1109302040(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = 0

			if var_161_0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_0 + arg_161_0 then
				arg_158_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_161_1 = 0
			local var_161_2 = 0.8

			if var_161_1 < arg_158_1.time_ and arg_158_1.time_ <= var_161_1 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				local var_161_3 = arg_158_1:FormatText(StoryNameCfg[73].name)

				arg_158_1.leftNameTxt_.text = var_161_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_4 = arg_158_1:GetWordFromCfg(1109302039)
				local var_161_5 = arg_158_1:FormatText(var_161_4.content)

				arg_158_1.text_.text = var_161_5

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_6 = 32
				local var_161_7 = utf8.len(var_161_5)
				local var_161_8 = var_161_6 <= 0 and var_161_2 or var_161_2 * (var_161_7 / var_161_6)

				if var_161_8 > 0 and var_161_2 < var_161_8 then
					arg_158_1.talkMaxDuration = var_161_8

					if var_161_8 + var_161_1 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_8 + var_161_1
					end
				end

				arg_158_1.text_.text = var_161_5
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302039", "story_v_side_new_1109302.awb") ~= 0 then
					local var_161_9 = manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302039", "story_v_side_new_1109302.awb") / 1000

					if var_161_9 + var_161_1 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_9 + var_161_1
					end

					if var_161_4.prefab_name ~= "" and arg_158_1.actors_[var_161_4.prefab_name] ~= nil then
						local var_161_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_4.prefab_name].transform, "story_v_side_new_1109302", "1109302039", "story_v_side_new_1109302.awb")

						arg_158_1:RecordAudio("1109302039", var_161_10)
						arg_158_1:RecordAudio("1109302039", var_161_10)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_side_new_1109302", "1109302039", "story_v_side_new_1109302.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_side_new_1109302", "1109302039", "story_v_side_new_1109302.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_11 = math.max(var_161_2, arg_158_1.talkMaxDuration)

			if var_161_1 <= arg_158_1.time_ and arg_158_1.time_ < var_161_1 + var_161_11 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_1) / var_161_11

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_1 + var_161_11 and arg_158_1.time_ < var_161_1 + var_161_11 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play1109302040 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 1109302040
		arg_162_1.duration_ = 16.97

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play1109302041(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = 0

			if var_165_0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_0 + arg_165_0 then
				arg_162_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_165_1 = 0
			local var_165_2 = 0.975

			if var_165_1 < arg_162_1.time_ and arg_162_1.time_ <= var_165_1 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				local var_165_3 = arg_162_1:FormatText(StoryNameCfg[73].name)

				arg_162_1.leftNameTxt_.text = var_165_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_4 = arg_162_1:GetWordFromCfg(1109302040)
				local var_165_5 = arg_162_1:FormatText(var_165_4.content)

				arg_162_1.text_.text = var_165_5

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_6 = 39
				local var_165_7 = utf8.len(var_165_5)
				local var_165_8 = var_165_6 <= 0 and var_165_2 or var_165_2 * (var_165_7 / var_165_6)

				if var_165_8 > 0 and var_165_2 < var_165_8 then
					arg_162_1.talkMaxDuration = var_165_8

					if var_165_8 + var_165_1 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_8 + var_165_1
					end
				end

				arg_162_1.text_.text = var_165_5
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302040", "story_v_side_new_1109302.awb") ~= 0 then
					local var_165_9 = manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302040", "story_v_side_new_1109302.awb") / 1000

					if var_165_9 + var_165_1 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_9 + var_165_1
					end

					if var_165_4.prefab_name ~= "" and arg_162_1.actors_[var_165_4.prefab_name] ~= nil then
						local var_165_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_4.prefab_name].transform, "story_v_side_new_1109302", "1109302040", "story_v_side_new_1109302.awb")

						arg_162_1:RecordAudio("1109302040", var_165_10)
						arg_162_1:RecordAudio("1109302040", var_165_10)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_side_new_1109302", "1109302040", "story_v_side_new_1109302.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_side_new_1109302", "1109302040", "story_v_side_new_1109302.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_11 = math.max(var_165_2, arg_162_1.talkMaxDuration)

			if var_165_1 <= arg_162_1.time_ and arg_162_1.time_ < var_165_1 + var_165_11 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_1) / var_165_11

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_1 + var_165_11 and arg_162_1.time_ < var_165_1 + var_165_11 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play1109302041 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 1109302041
		arg_166_1.duration_ = 5

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play1109302042(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = arg_166_1.actors_["1093ui_story"]
			local var_169_1 = 0

			if var_169_1 < arg_166_1.time_ and arg_166_1.time_ <= var_169_1 + arg_169_0 and not isNil(var_169_0) and arg_166_1.var_.characterEffect1093ui_story == nil then
				arg_166_1.var_.characterEffect1093ui_story = var_169_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_2 = 0.2

			if var_169_1 <= arg_166_1.time_ and arg_166_1.time_ < var_169_1 + var_169_2 and not isNil(var_169_0) then
				local var_169_3 = (arg_166_1.time_ - var_169_1) / var_169_2

				if arg_166_1.var_.characterEffect1093ui_story and not isNil(var_169_0) then
					local var_169_4 = Mathf.Lerp(0, 0.5, var_169_3)

					arg_166_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_166_1.var_.characterEffect1093ui_story.fillRatio = var_169_4
				end
			end

			if arg_166_1.time_ >= var_169_1 + var_169_2 and arg_166_1.time_ < var_169_1 + var_169_2 + arg_169_0 and not isNil(var_169_0) and arg_166_1.var_.characterEffect1093ui_story then
				local var_169_5 = 0.5

				arg_166_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_166_1.var_.characterEffect1093ui_story.fillRatio = var_169_5
			end

			local var_169_6 = 0
			local var_169_7 = 1.125

			if var_169_6 < arg_166_1.time_ and arg_166_1.time_ <= var_169_6 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, false)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_8 = arg_166_1:GetWordFromCfg(1109302041)
				local var_169_9 = arg_166_1:FormatText(var_169_8.content)

				arg_166_1.text_.text = var_169_9

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_10 = 44
				local var_169_11 = utf8.len(var_169_9)
				local var_169_12 = var_169_10 <= 0 and var_169_7 or var_169_7 * (var_169_11 / var_169_10)

				if var_169_12 > 0 and var_169_7 < var_169_12 then
					arg_166_1.talkMaxDuration = var_169_12

					if var_169_12 + var_169_6 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_12 + var_169_6
					end
				end

				arg_166_1.text_.text = var_169_9
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)
				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_13 = math.max(var_169_7, arg_166_1.talkMaxDuration)

			if var_169_6 <= arg_166_1.time_ and arg_166_1.time_ < var_169_6 + var_169_13 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_6) / var_169_13

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_6 + var_169_13 and arg_166_1.time_ < var_169_6 + var_169_13 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play1109302042 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 1109302042
		arg_170_1.duration_ = 5

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play1109302043(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = 0
			local var_173_1 = 0.925

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

				local var_173_2 = arg_170_1:GetWordFromCfg(1109302042)
				local var_173_3 = arg_170_1:FormatText(var_173_2.content)

				arg_170_1.text_.text = var_173_3

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_4 = 37
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
	Play1109302043 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 1109302043
		arg_174_1.duration_ = 5

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play1109302044(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = 0
			local var_177_1 = 1.225

			if var_177_0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_0 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, false)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_2 = arg_174_1:GetWordFromCfg(1109302043)
				local var_177_3 = arg_174_1:FormatText(var_177_2.content)

				arg_174_1.text_.text = var_177_3

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_4 = 49
				local var_177_5 = utf8.len(var_177_3)
				local var_177_6 = var_177_4 <= 0 and var_177_1 or var_177_1 * (var_177_5 / var_177_4)

				if var_177_6 > 0 and var_177_1 < var_177_6 then
					arg_174_1.talkMaxDuration = var_177_6

					if var_177_6 + var_177_0 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_6 + var_177_0
					end
				end

				arg_174_1.text_.text = var_177_3
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)
				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_7 = math.max(var_177_1, arg_174_1.talkMaxDuration)

			if var_177_0 <= arg_174_1.time_ and arg_174_1.time_ < var_177_0 + var_177_7 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_0) / var_177_7

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_0 + var_177_7 and arg_174_1.time_ < var_177_0 + var_177_7 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play1109302044 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 1109302044
		arg_178_1.duration_ = 5

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play1109302045(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = 0
			local var_181_1 = 0.35

			if var_181_0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_0 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				local var_181_2 = arg_178_1:FormatText(StoryNameCfg[7].name)

				arg_178_1.leftNameTxt_.text = var_181_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, true)
				arg_178_1.iconController_:SetSelectedState("hero")

				arg_178_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_178_1.callingController_:SetSelectedState("normal")

				arg_178_1.keyicon_.color = Color.New(1, 1, 1)
				arg_178_1.icon_.color = Color.New(1, 1, 1)

				local var_181_3 = arg_178_1:GetWordFromCfg(1109302044)
				local var_181_4 = arg_178_1:FormatText(var_181_3.content)

				arg_178_1.text_.text = var_181_4

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_5 = 14
				local var_181_6 = utf8.len(var_181_4)
				local var_181_7 = var_181_5 <= 0 and var_181_1 or var_181_1 * (var_181_6 / var_181_5)

				if var_181_7 > 0 and var_181_1 < var_181_7 then
					arg_178_1.talkMaxDuration = var_181_7

					if var_181_7 + var_181_0 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_7 + var_181_0
					end
				end

				arg_178_1.text_.text = var_181_4
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)
				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_8 = math.max(var_181_1, arg_178_1.talkMaxDuration)

			if var_181_0 <= arg_178_1.time_ and arg_178_1.time_ < var_181_0 + var_181_8 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_0) / var_181_8

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_0 + var_181_8 and arg_178_1.time_ < var_181_0 + var_181_8 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play1109302045 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 1109302045
		arg_182_1.duration_ = 14.67

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play1109302046(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = arg_182_1.actors_["1093ui_story"]
			local var_185_1 = 0

			if var_185_1 < arg_182_1.time_ and arg_182_1.time_ <= var_185_1 + arg_185_0 and not isNil(var_185_0) and arg_182_1.var_.characterEffect1093ui_story == nil then
				arg_182_1.var_.characterEffect1093ui_story = var_185_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_2 = 0.2

			if var_185_1 <= arg_182_1.time_ and arg_182_1.time_ < var_185_1 + var_185_2 and not isNil(var_185_0) then
				local var_185_3 = (arg_182_1.time_ - var_185_1) / var_185_2

				if arg_182_1.var_.characterEffect1093ui_story and not isNil(var_185_0) then
					arg_182_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_182_1.time_ >= var_185_1 + var_185_2 and arg_182_1.time_ < var_185_1 + var_185_2 + arg_185_0 and not isNil(var_185_0) and arg_182_1.var_.characterEffect1093ui_story then
				arg_182_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_185_4 = 0

			if var_185_4 < arg_182_1.time_ and arg_182_1.time_ <= var_185_4 + arg_185_0 then
				arg_182_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action464")
			end

			local var_185_5 = 0

			if var_185_5 < arg_182_1.time_ and arg_182_1.time_ <= var_185_5 + arg_185_0 then
				arg_182_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_185_6 = 0
			local var_185_7 = 1.1

			if var_185_6 < arg_182_1.time_ and arg_182_1.time_ <= var_185_6 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				local var_185_8 = arg_182_1:FormatText(StoryNameCfg[73].name)

				arg_182_1.leftNameTxt_.text = var_185_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_9 = arg_182_1:GetWordFromCfg(1109302045)
				local var_185_10 = arg_182_1:FormatText(var_185_9.content)

				arg_182_1.text_.text = var_185_10

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_11 = 42
				local var_185_12 = utf8.len(var_185_10)
				local var_185_13 = var_185_11 <= 0 and var_185_7 or var_185_7 * (var_185_12 / var_185_11)

				if var_185_13 > 0 and var_185_7 < var_185_13 then
					arg_182_1.talkMaxDuration = var_185_13

					if var_185_13 + var_185_6 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_13 + var_185_6
					end
				end

				arg_182_1.text_.text = var_185_10
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302045", "story_v_side_new_1109302.awb") ~= 0 then
					local var_185_14 = manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302045", "story_v_side_new_1109302.awb") / 1000

					if var_185_14 + var_185_6 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_14 + var_185_6
					end

					if var_185_9.prefab_name ~= "" and arg_182_1.actors_[var_185_9.prefab_name] ~= nil then
						local var_185_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_9.prefab_name].transform, "story_v_side_new_1109302", "1109302045", "story_v_side_new_1109302.awb")

						arg_182_1:RecordAudio("1109302045", var_185_15)
						arg_182_1:RecordAudio("1109302045", var_185_15)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_side_new_1109302", "1109302045", "story_v_side_new_1109302.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_side_new_1109302", "1109302045", "story_v_side_new_1109302.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_16 = math.max(var_185_7, arg_182_1.talkMaxDuration)

			if var_185_6 <= arg_182_1.time_ and arg_182_1.time_ < var_185_6 + var_185_16 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_6) / var_185_16

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_6 + var_185_16 and arg_182_1.time_ < var_185_6 + var_185_16 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play1109302046 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 1109302046
		arg_186_1.duration_ = 0.2

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"

			SetActive(arg_186_1.choicesGo_, true)

			for iter_187_0, iter_187_1 in ipairs(arg_186_1.choices_) do
				local var_187_0 = iter_187_0 <= 2

				SetActive(iter_187_1.go, var_187_0)
			end

			arg_186_1.choices_[1].txt.text = arg_186_1:FormatText(StoryChoiceCfg[342].name)
			arg_186_1.choices_[2].txt.text = arg_186_1:FormatText(StoryChoiceCfg[343].name)
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play1109302047(arg_186_1)
			end

			if arg_188_0 == 2 then
				arg_186_0:Play1109302047(arg_186_1)
			end

			arg_186_1:RecordChoiceLog(1109302046, 342, 343)
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = arg_186_1.actors_["1093ui_story"]
			local var_189_1 = 0

			if var_189_1 < arg_186_1.time_ and arg_186_1.time_ <= var_189_1 + arg_189_0 and not isNil(var_189_0) and arg_186_1.var_.characterEffect1093ui_story == nil then
				arg_186_1.var_.characterEffect1093ui_story = var_189_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_2 = 0.2

			if var_189_1 <= arg_186_1.time_ and arg_186_1.time_ < var_189_1 + var_189_2 and not isNil(var_189_0) then
				local var_189_3 = (arg_186_1.time_ - var_189_1) / var_189_2

				if arg_186_1.var_.characterEffect1093ui_story and not isNil(var_189_0) then
					local var_189_4 = Mathf.Lerp(0, 0.5, var_189_3)

					arg_186_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_186_1.var_.characterEffect1093ui_story.fillRatio = var_189_4
				end
			end

			if arg_186_1.time_ >= var_189_1 + var_189_2 and arg_186_1.time_ < var_189_1 + var_189_2 + arg_189_0 and not isNil(var_189_0) and arg_186_1.var_.characterEffect1093ui_story then
				local var_189_5 = 0.5

				arg_186_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_186_1.var_.characterEffect1093ui_story.fillRatio = var_189_5
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play1109302047 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 1109302047
		arg_190_1.duration_ = 5

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play1109302048(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = 0
			local var_193_1 = 0.875

			if var_193_0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_0 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				local var_193_2 = arg_190_1:FormatText(StoryNameCfg[7].name)

				arg_190_1.leftNameTxt_.text = var_193_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, true)
				arg_190_1.iconController_:SetSelectedState("hero")

				arg_190_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_190_1.callingController_:SetSelectedState("normal")

				arg_190_1.keyicon_.color = Color.New(1, 1, 1)
				arg_190_1.icon_.color = Color.New(1, 1, 1)

				local var_193_3 = arg_190_1:GetWordFromCfg(1109302047)
				local var_193_4 = arg_190_1:FormatText(var_193_3.content)

				arg_190_1.text_.text = var_193_4

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_5 = 35
				local var_193_6 = utf8.len(var_193_4)
				local var_193_7 = var_193_5 <= 0 and var_193_1 or var_193_1 * (var_193_6 / var_193_5)

				if var_193_7 > 0 and var_193_1 < var_193_7 then
					arg_190_1.talkMaxDuration = var_193_7

					if var_193_7 + var_193_0 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_7 + var_193_0
					end
				end

				arg_190_1.text_.text = var_193_4
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)
				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_8 = math.max(var_193_1, arg_190_1.talkMaxDuration)

			if var_193_0 <= arg_190_1.time_ and arg_190_1.time_ < var_193_0 + var_193_8 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_0) / var_193_8

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_0 + var_193_8 and arg_190_1.time_ < var_193_0 + var_193_8 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play1109302048 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 1109302048
		arg_194_1.duration_ = 5

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play1109302049(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = 0
			local var_197_1 = 0.7

			if var_197_0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_0 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				local var_197_2 = arg_194_1:FormatText(StoryNameCfg[7].name)

				arg_194_1.leftNameTxt_.text = var_197_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, true)
				arg_194_1.iconController_:SetSelectedState("hero")

				arg_194_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_194_1.callingController_:SetSelectedState("normal")

				arg_194_1.keyicon_.color = Color.New(1, 1, 1)
				arg_194_1.icon_.color = Color.New(1, 1, 1)

				local var_197_3 = arg_194_1:GetWordFromCfg(1109302048)
				local var_197_4 = arg_194_1:FormatText(var_197_3.content)

				arg_194_1.text_.text = var_197_4

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_5 = 28
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
				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_8 = math.max(var_197_1, arg_194_1.talkMaxDuration)

			if var_197_0 <= arg_194_1.time_ and arg_194_1.time_ < var_197_0 + var_197_8 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_0) / var_197_8

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_0 + var_197_8 and arg_194_1.time_ < var_197_0 + var_197_8 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play1109302049 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 1109302049
		arg_198_1.duration_ = 2

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play1109302050(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = arg_198_1.actors_["1093ui_story"]
			local var_201_1 = 0

			if var_201_1 < arg_198_1.time_ and arg_198_1.time_ <= var_201_1 + arg_201_0 and not isNil(var_201_0) and arg_198_1.var_.characterEffect1093ui_story == nil then
				arg_198_1.var_.characterEffect1093ui_story = var_201_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_2 = 0.2

			if var_201_1 <= arg_198_1.time_ and arg_198_1.time_ < var_201_1 + var_201_2 and not isNil(var_201_0) then
				local var_201_3 = (arg_198_1.time_ - var_201_1) / var_201_2

				if arg_198_1.var_.characterEffect1093ui_story and not isNil(var_201_0) then
					arg_198_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_198_1.time_ >= var_201_1 + var_201_2 and arg_198_1.time_ < var_201_1 + var_201_2 + arg_201_0 and not isNil(var_201_0) and arg_198_1.var_.characterEffect1093ui_story then
				arg_198_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_201_4 = 0

			if var_201_4 < arg_198_1.time_ and arg_198_1.time_ <= var_201_4 + arg_201_0 then
				arg_198_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface9901cva")
			end

			local var_201_5 = 0
			local var_201_6 = 0.05

			if var_201_5 < arg_198_1.time_ and arg_198_1.time_ <= var_201_5 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				local var_201_7 = arg_198_1:FormatText(StoryNameCfg[73].name)

				arg_198_1.leftNameTxt_.text = var_201_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_8 = arg_198_1:GetWordFromCfg(1109302049)
				local var_201_9 = arg_198_1:FormatText(var_201_8.content)

				arg_198_1.text_.text = var_201_9

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_10 = 2
				local var_201_11 = utf8.len(var_201_9)
				local var_201_12 = var_201_10 <= 0 and var_201_6 or var_201_6 * (var_201_11 / var_201_10)

				if var_201_12 > 0 and var_201_6 < var_201_12 then
					arg_198_1.talkMaxDuration = var_201_12

					if var_201_12 + var_201_5 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_12 + var_201_5
					end
				end

				arg_198_1.text_.text = var_201_9
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302049", "story_v_side_new_1109302.awb") ~= 0 then
					local var_201_13 = manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302049", "story_v_side_new_1109302.awb") / 1000

					if var_201_13 + var_201_5 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_13 + var_201_5
					end

					if var_201_8.prefab_name ~= "" and arg_198_1.actors_[var_201_8.prefab_name] ~= nil then
						local var_201_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_8.prefab_name].transform, "story_v_side_new_1109302", "1109302049", "story_v_side_new_1109302.awb")

						arg_198_1:RecordAudio("1109302049", var_201_14)
						arg_198_1:RecordAudio("1109302049", var_201_14)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_side_new_1109302", "1109302049", "story_v_side_new_1109302.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_side_new_1109302", "1109302049", "story_v_side_new_1109302.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_15 = math.max(var_201_6, arg_198_1.talkMaxDuration)

			if var_201_5 <= arg_198_1.time_ and arg_198_1.time_ < var_201_5 + var_201_15 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_5) / var_201_15

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_5 + var_201_15 and arg_198_1.time_ < var_201_5 + var_201_15 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play1109302050 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 1109302050
		arg_202_1.duration_ = 5

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play1109302051(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = arg_202_1.actors_["1093ui_story"]
			local var_205_1 = 0

			if var_205_1 < arg_202_1.time_ and arg_202_1.time_ <= var_205_1 + arg_205_0 and not isNil(var_205_0) and arg_202_1.var_.characterEffect1093ui_story == nil then
				arg_202_1.var_.characterEffect1093ui_story = var_205_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_2 = 0.2

			if var_205_1 <= arg_202_1.time_ and arg_202_1.time_ < var_205_1 + var_205_2 and not isNil(var_205_0) then
				local var_205_3 = (arg_202_1.time_ - var_205_1) / var_205_2

				if arg_202_1.var_.characterEffect1093ui_story and not isNil(var_205_0) then
					local var_205_4 = Mathf.Lerp(0, 0.5, var_205_3)

					arg_202_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_202_1.var_.characterEffect1093ui_story.fillRatio = var_205_4
				end
			end

			if arg_202_1.time_ >= var_205_1 + var_205_2 and arg_202_1.time_ < var_205_1 + var_205_2 + arg_205_0 and not isNil(var_205_0) and arg_202_1.var_.characterEffect1093ui_story then
				local var_205_5 = 0.5

				arg_202_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_202_1.var_.characterEffect1093ui_story.fillRatio = var_205_5
			end

			local var_205_6 = 0
			local var_205_7 = 1

			if var_205_6 < arg_202_1.time_ and arg_202_1.time_ <= var_205_6 + arg_205_0 then
				local var_205_8 = "play"
				local var_205_9 = "music"

				arg_202_1:AudioAction(var_205_8, var_205_9, "bgm_side_daily02", "bgm_side_daily02", "bgm_side_daily02.awb")

				local var_205_10 = ""
				local var_205_11 = manager.audio:GetAudioName("bgm_side_daily02", "bgm_side_daily02")

				if var_205_11 ~= "" then
					if arg_202_1.bgmTxt_.text ~= var_205_11 and arg_202_1.bgmTxt_.text ~= "" then
						if arg_202_1.bgmTxt2_.text ~= "" then
							arg_202_1.bgmTxt_.text = arg_202_1.bgmTxt2_.text
						end

						arg_202_1.bgmTxt2_.text = var_205_11

						arg_202_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_202_1.bgmTxt_.text = var_205_11
						arg_202_1.bgmTxt2_.text = var_205_11
					end

					if arg_202_1.bgmTimer then
						arg_202_1.bgmTimer:Stop()

						arg_202_1.bgmTimer = nil
					end

					if arg_202_1.settingData.show_music_name == 1 then
						arg_202_1.musicController:SetSelectedState("show")
						arg_202_1.musicAnimator_:Play("open", 0, 0)

						if arg_202_1.settingData.music_time ~= 0 then
							arg_202_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_202_1.settingData.music_time), function()
								if arg_202_1 == nil or isNil(arg_202_1.bgmTxt_) then
									return
								end

								arg_202_1.musicController:SetSelectedState("hide")
								arg_202_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_205_12 = 0
			local var_205_13 = 0.8

			if var_205_12 < arg_202_1.time_ and arg_202_1.time_ <= var_205_12 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, false)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_14 = arg_202_1:GetWordFromCfg(1109302050)
				local var_205_15 = arg_202_1:FormatText(var_205_14.content)

				arg_202_1.text_.text = var_205_15

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_16 = 32
				local var_205_17 = utf8.len(var_205_15)
				local var_205_18 = var_205_16 <= 0 and var_205_13 or var_205_13 * (var_205_17 / var_205_16)

				if var_205_18 > 0 and var_205_13 < var_205_18 then
					arg_202_1.talkMaxDuration = var_205_18

					if var_205_18 + var_205_12 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_18 + var_205_12
					end
				end

				arg_202_1.text_.text = var_205_15
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)
				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_19 = math.max(var_205_13, arg_202_1.talkMaxDuration)

			if var_205_12 <= arg_202_1.time_ and arg_202_1.time_ < var_205_12 + var_205_19 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_12) / var_205_19

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_12 + var_205_19 and arg_202_1.time_ < var_205_12 + var_205_19 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play1109302051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 1109302051
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play1109302052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 0
			local var_210_1 = 0.7

			if var_210_0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, false)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_2 = arg_207_1:GetWordFromCfg(1109302051)
				local var_210_3 = arg_207_1:FormatText(var_210_2.content)

				arg_207_1.text_.text = var_210_3

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_4 = 28
				local var_210_5 = utf8.len(var_210_3)
				local var_210_6 = var_210_4 <= 0 and var_210_1 or var_210_1 * (var_210_5 / var_210_4)

				if var_210_6 > 0 and var_210_1 < var_210_6 then
					arg_207_1.talkMaxDuration = var_210_6

					if var_210_6 + var_210_0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_6 + var_210_0
					end
				end

				arg_207_1.text_.text = var_210_3
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_7 = math.max(var_210_1, arg_207_1.talkMaxDuration)

			if var_210_0 <= arg_207_1.time_ and arg_207_1.time_ < var_210_0 + var_210_7 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_0) / var_210_7

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_0 + var_210_7 and arg_207_1.time_ < var_210_0 + var_210_7 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play1109302052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 1109302052
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play1109302053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 0
			local var_214_1 = 1

			if var_214_0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_0 + arg_214_0 then
				local var_214_2 = "play"
				local var_214_3 = "effect"

				arg_211_1:AudioAction(var_214_2, var_214_3, "se_story_side_1093", "se_story_1093_offlight", "")
			end

			local var_214_4 = 0
			local var_214_5 = 0.1

			if var_214_4 < arg_211_1.time_ and arg_211_1.time_ <= var_214_4 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_6 = arg_211_1:GetWordFromCfg(1109302052)
				local var_214_7 = arg_211_1:FormatText(var_214_6.content)

				arg_211_1.text_.text = var_214_7

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_8 = 4
				local var_214_9 = utf8.len(var_214_7)
				local var_214_10 = var_214_8 <= 0 and var_214_5 or var_214_5 * (var_214_9 / var_214_8)

				if var_214_10 > 0 and var_214_5 < var_214_10 then
					arg_211_1.talkMaxDuration = var_214_10

					if var_214_10 + var_214_4 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_10 + var_214_4
					end
				end

				arg_211_1.text_.text = var_214_7
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_11 = math.max(var_214_5, arg_211_1.talkMaxDuration)

			if var_214_4 <= arg_211_1.time_ and arg_211_1.time_ < var_214_4 + var_214_11 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_4) / var_214_11

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_4 + var_214_11 and arg_211_1.time_ < var_214_4 + var_214_11 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play1109302053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 1109302053
		arg_215_1.duration_ = 9

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play1109302054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 2

			if var_218_0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_0 + arg_218_0 then
				local var_218_1 = manager.ui.mainCamera.transform.localPosition
				local var_218_2 = Vector3.New(0, 0, 10) + Vector3.New(var_218_1.x, var_218_1.y, 0)
				local var_218_3 = arg_215_1.bgs_.STblack

				var_218_3.transform.localPosition = var_218_2
				var_218_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_218_4 = var_218_3:GetComponent("SpriteRenderer")

				if var_218_4 and var_218_4.sprite then
					local var_218_5 = (var_218_3.transform.localPosition - var_218_1).z
					local var_218_6 = manager.ui.mainCameraCom_
					local var_218_7 = 2 * var_218_5 * Mathf.Tan(var_218_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_218_8 = var_218_7 * var_218_6.aspect
					local var_218_9 = var_218_4.sprite.bounds.size.x
					local var_218_10 = var_218_4.sprite.bounds.size.y
					local var_218_11 = var_218_8 / var_218_9
					local var_218_12 = var_218_7 / var_218_10
					local var_218_13 = var_218_12 < var_218_11 and var_218_11 or var_218_12

					var_218_3.transform.localScale = Vector3.New(var_218_13, var_218_13, 0)
				end

				for iter_218_0, iter_218_1 in pairs(arg_215_1.bgs_) do
					if iter_218_0 ~= "STblack" then
						iter_218_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_218_14 = 0

			if var_218_14 < arg_215_1.time_ and arg_215_1.time_ <= var_218_14 + arg_218_0 then
				arg_215_1.mask_.enabled = true
				arg_215_1.mask_.raycastTarget = true

				arg_215_1:SetGaussion(false)
			end

			local var_218_15 = 2

			if var_218_14 <= arg_215_1.time_ and arg_215_1.time_ < var_218_14 + var_218_15 then
				local var_218_16 = (arg_215_1.time_ - var_218_14) / var_218_15
				local var_218_17 = Color.New(0, 0, 0)

				var_218_17.a = Mathf.Lerp(0, 1, var_218_16)
				arg_215_1.mask_.color = var_218_17
			end

			if arg_215_1.time_ >= var_218_14 + var_218_15 and arg_215_1.time_ < var_218_14 + var_218_15 + arg_218_0 then
				local var_218_18 = Color.New(0, 0, 0)

				var_218_18.a = 1
				arg_215_1.mask_.color = var_218_18
			end

			local var_218_19 = 2

			if var_218_19 < arg_215_1.time_ and arg_215_1.time_ <= var_218_19 + arg_218_0 then
				arg_215_1.mask_.enabled = true
				arg_215_1.mask_.raycastTarget = true

				arg_215_1:SetGaussion(false)
			end

			local var_218_20 = 2

			if var_218_19 <= arg_215_1.time_ and arg_215_1.time_ < var_218_19 + var_218_20 then
				local var_218_21 = (arg_215_1.time_ - var_218_19) / var_218_20
				local var_218_22 = Color.New(0, 0, 0)

				var_218_22.a = Mathf.Lerp(1, 0, var_218_21)
				arg_215_1.mask_.color = var_218_22
			end

			if arg_215_1.time_ >= var_218_19 + var_218_20 and arg_215_1.time_ < var_218_19 + var_218_20 + arg_218_0 then
				local var_218_23 = Color.New(0, 0, 0)
				local var_218_24 = 0

				arg_215_1.mask_.enabled = false
				var_218_23.a = var_218_24
				arg_215_1.mask_.color = var_218_23
			end

			local var_218_25 = arg_215_1.actors_["1093ui_story"].transform
			local var_218_26 = 1.966

			if var_218_26 < arg_215_1.time_ and arg_215_1.time_ <= var_218_26 + arg_218_0 then
				arg_215_1.var_.moveOldPos1093ui_story = var_218_25.localPosition
			end

			local var_218_27 = 0.001

			if var_218_26 <= arg_215_1.time_ and arg_215_1.time_ < var_218_26 + var_218_27 then
				local var_218_28 = (arg_215_1.time_ - var_218_26) / var_218_27
				local var_218_29 = Vector3.New(0, 100, 0)

				var_218_25.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos1093ui_story, var_218_29, var_218_28)

				local var_218_30 = manager.ui.mainCamera.transform.position - var_218_25.position

				var_218_25.forward = Vector3.New(var_218_30.x, var_218_30.y, var_218_30.z)

				local var_218_31 = var_218_25.localEulerAngles

				var_218_31.z = 0
				var_218_31.x = 0
				var_218_25.localEulerAngles = var_218_31
			end

			if arg_215_1.time_ >= var_218_26 + var_218_27 and arg_215_1.time_ < var_218_26 + var_218_27 + arg_218_0 then
				var_218_25.localPosition = Vector3.New(0, 100, 0)

				local var_218_32 = manager.ui.mainCamera.transform.position - var_218_25.position

				var_218_25.forward = Vector3.New(var_218_32.x, var_218_32.y, var_218_32.z)

				local var_218_33 = var_218_25.localEulerAngles

				var_218_33.z = 0
				var_218_33.x = 0
				var_218_25.localEulerAngles = var_218_33
			end

			if arg_215_1.frameCnt_ <= 1 then
				arg_215_1.dialog_:SetActive(false)
			end

			local var_218_34 = 4
			local var_218_35 = 0.3

			if var_218_34 < arg_215_1.time_ and arg_215_1.time_ <= var_218_34 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0

				arg_215_1.dialog_:SetActive(true)

				arg_215_1.dialogCg_.alpha = 0

				local var_218_36 = LeanTween.value(arg_215_1.dialog_, 0, 1, 0.3)

				var_218_36:setOnUpdate(LuaHelper.FloatAction(function(arg_219_0)
					arg_215_1.dialogCg_.alpha = arg_219_0
				end))
				var_218_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_215_1.dialog_)
					var_218_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_215_1.duration_ = arg_215_1.duration_ + 0.3

				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_37 = arg_215_1:FormatText(StoryNameCfg[7].name)

				arg_215_1.leftNameTxt_.text = var_218_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, true)
				arg_215_1.iconController_:SetSelectedState("hero")

				arg_215_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_215_1.callingController_:SetSelectedState("normal")

				arg_215_1.keyicon_.color = Color.New(1, 1, 1)
				arg_215_1.icon_.color = Color.New(1, 1, 1)

				local var_218_38 = arg_215_1:GetWordFromCfg(1109302053)
				local var_218_39 = arg_215_1:FormatText(var_218_38.content)

				arg_215_1.text_.text = var_218_39

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_40 = 12
				local var_218_41 = utf8.len(var_218_39)
				local var_218_42 = var_218_40 <= 0 and var_218_35 or var_218_35 * (var_218_41 / var_218_40)

				if var_218_42 > 0 and var_218_35 < var_218_42 then
					arg_215_1.talkMaxDuration = var_218_42
					var_218_34 = var_218_34 + 0.3

					if var_218_42 + var_218_34 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_42 + var_218_34
					end
				end

				arg_215_1.text_.text = var_218_39
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_43 = var_218_34 + 0.3
			local var_218_44 = math.max(var_218_35, arg_215_1.talkMaxDuration)

			if var_218_43 <= arg_215_1.time_ and arg_215_1.time_ < var_218_43 + var_218_44 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_43) / var_218_44

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_43 + var_218_44 and arg_215_1.time_ < var_218_43 + var_218_44 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_215_1:InitPlayNodeList()
	end,
	Play1109302054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 1109302054
		arg_221_1.duration_ = 12.1

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play1109302055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 0
			local var_224_1 = 1

			if var_224_0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_2 = arg_221_1:FormatText(StoryNameCfg[73].name)

				arg_221_1.leftNameTxt_.text = var_224_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, true)
				arg_221_1.iconController_:SetSelectedState("hero")

				arg_221_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1093")

				arg_221_1.callingController_:SetSelectedState("normal")

				arg_221_1.keyicon_.color = Color.New(1, 1, 1)
				arg_221_1.icon_.color = Color.New(1, 1, 1)

				local var_224_3 = arg_221_1:GetWordFromCfg(1109302054)
				local var_224_4 = arg_221_1:FormatText(var_224_3.content)

				arg_221_1.text_.text = var_224_4

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_5 = 39
				local var_224_6 = utf8.len(var_224_4)
				local var_224_7 = var_224_5 <= 0 and var_224_1 or var_224_1 * (var_224_6 / var_224_5)

				if var_224_7 > 0 and var_224_1 < var_224_7 then
					arg_221_1.talkMaxDuration = var_224_7

					if var_224_7 + var_224_0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_7 + var_224_0
					end
				end

				arg_221_1.text_.text = var_224_4
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302054", "story_v_side_new_1109302.awb") ~= 0 then
					local var_224_8 = manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302054", "story_v_side_new_1109302.awb") / 1000

					if var_224_8 + var_224_0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_8 + var_224_0
					end

					if var_224_3.prefab_name ~= "" and arg_221_1.actors_[var_224_3.prefab_name] ~= nil then
						local var_224_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_3.prefab_name].transform, "story_v_side_new_1109302", "1109302054", "story_v_side_new_1109302.awb")

						arg_221_1:RecordAudio("1109302054", var_224_9)
						arg_221_1:RecordAudio("1109302054", var_224_9)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_side_new_1109302", "1109302054", "story_v_side_new_1109302.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_side_new_1109302", "1109302054", "story_v_side_new_1109302.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_10 = math.max(var_224_1, arg_221_1.talkMaxDuration)

			if var_224_0 <= arg_221_1.time_ and arg_221_1.time_ < var_224_0 + var_224_10 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_0) / var_224_10

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_0 + var_224_10 and arg_221_1.time_ < var_224_0 + var_224_10 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play1109302055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 1109302055
		arg_225_1.duration_ = 5.2

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play1109302056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0
			local var_228_1 = 0.3

			if var_228_0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_2 = arg_225_1:FormatText(StoryNameCfg[73].name)

				arg_225_1.leftNameTxt_.text = var_228_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, true)
				arg_225_1.iconController_:SetSelectedState("hero")

				arg_225_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1093")

				arg_225_1.callingController_:SetSelectedState("normal")

				arg_225_1.keyicon_.color = Color.New(1, 1, 1)
				arg_225_1.icon_.color = Color.New(1, 1, 1)

				local var_228_3 = arg_225_1:GetWordFromCfg(1109302055)
				local var_228_4 = arg_225_1:FormatText(var_228_3.content)

				arg_225_1.text_.text = var_228_4

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_5 = 12
				local var_228_6 = utf8.len(var_228_4)
				local var_228_7 = var_228_5 <= 0 and var_228_1 or var_228_1 * (var_228_6 / var_228_5)

				if var_228_7 > 0 and var_228_1 < var_228_7 then
					arg_225_1.talkMaxDuration = var_228_7

					if var_228_7 + var_228_0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_7 + var_228_0
					end
				end

				arg_225_1.text_.text = var_228_4
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302055", "story_v_side_new_1109302.awb") ~= 0 then
					local var_228_8 = manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302055", "story_v_side_new_1109302.awb") / 1000

					if var_228_8 + var_228_0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_8 + var_228_0
					end

					if var_228_3.prefab_name ~= "" and arg_225_1.actors_[var_228_3.prefab_name] ~= nil then
						local var_228_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_3.prefab_name].transform, "story_v_side_new_1109302", "1109302055", "story_v_side_new_1109302.awb")

						arg_225_1:RecordAudio("1109302055", var_228_9)
						arg_225_1:RecordAudio("1109302055", var_228_9)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_side_new_1109302", "1109302055", "story_v_side_new_1109302.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_side_new_1109302", "1109302055", "story_v_side_new_1109302.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_10 = math.max(var_228_1, arg_225_1.talkMaxDuration)

			if var_228_0 <= arg_225_1.time_ and arg_225_1.time_ < var_228_0 + var_228_10 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_0) / var_228_10

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_0 + var_228_10 and arg_225_1.time_ < var_228_0 + var_228_10 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play1109302056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 1109302056
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play1109302057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0
			local var_232_1 = 0.05

			if var_232_0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, false)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_2 = arg_229_1:GetWordFromCfg(1109302056)
				local var_232_3 = arg_229_1:FormatText(var_232_2.content)

				arg_229_1.text_.text = var_232_3

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_4 = 2
				local var_232_5 = utf8.len(var_232_3)
				local var_232_6 = var_232_4 <= 0 and var_232_1 or var_232_1 * (var_232_5 / var_232_4)

				if var_232_6 > 0 and var_232_1 < var_232_6 then
					arg_229_1.talkMaxDuration = var_232_6

					if var_232_6 + var_232_0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_6 + var_232_0
					end
				end

				arg_229_1.text_.text = var_232_3
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_7 = math.max(var_232_1, arg_229_1.talkMaxDuration)

			if var_232_0 <= arg_229_1.time_ and arg_229_1.time_ < var_232_0 + var_232_7 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_0) / var_232_7

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_0 + var_232_7 and arg_229_1.time_ < var_232_0 + var_232_7 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play1109302057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 1109302057
		arg_233_1.duration_ = 9

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play1109302058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = "ST17"

			if arg_233_1.bgs_[var_236_0] == nil then
				local var_236_1 = Object.Instantiate(arg_233_1.paintGo_)

				var_236_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_236_0)
				var_236_1.name = var_236_0
				var_236_1.transform.parent = arg_233_1.stage_.transform
				var_236_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_233_1.bgs_[var_236_0] = var_236_1
			end

			local var_236_2 = 2

			if var_236_2 < arg_233_1.time_ and arg_233_1.time_ <= var_236_2 + arg_236_0 then
				local var_236_3 = manager.ui.mainCamera.transform.localPosition
				local var_236_4 = Vector3.New(0, 0, 10) + Vector3.New(var_236_3.x, var_236_3.y, 0)
				local var_236_5 = arg_233_1.bgs_.ST17

				var_236_5.transform.localPosition = var_236_4
				var_236_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_236_6 = var_236_5:GetComponent("SpriteRenderer")

				if var_236_6 and var_236_6.sprite then
					local var_236_7 = (var_236_5.transform.localPosition - var_236_3).z
					local var_236_8 = manager.ui.mainCameraCom_
					local var_236_9 = 2 * var_236_7 * Mathf.Tan(var_236_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_236_10 = var_236_9 * var_236_8.aspect
					local var_236_11 = var_236_6.sprite.bounds.size.x
					local var_236_12 = var_236_6.sprite.bounds.size.y
					local var_236_13 = var_236_10 / var_236_11
					local var_236_14 = var_236_9 / var_236_12
					local var_236_15 = var_236_14 < var_236_13 and var_236_13 or var_236_14

					var_236_5.transform.localScale = Vector3.New(var_236_15, var_236_15, 0)
				end

				for iter_236_0, iter_236_1 in pairs(arg_233_1.bgs_) do
					if iter_236_0 ~= "ST17" then
						iter_236_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_236_16 = 0

			if var_236_16 < arg_233_1.time_ and arg_233_1.time_ <= var_236_16 + arg_236_0 then
				arg_233_1.mask_.enabled = true
				arg_233_1.mask_.raycastTarget = true

				arg_233_1:SetGaussion(false)
			end

			local var_236_17 = 2

			if var_236_16 <= arg_233_1.time_ and arg_233_1.time_ < var_236_16 + var_236_17 then
				local var_236_18 = (arg_233_1.time_ - var_236_16) / var_236_17
				local var_236_19 = Color.New(0, 0, 0)

				var_236_19.a = Mathf.Lerp(0, 1, var_236_18)
				arg_233_1.mask_.color = var_236_19
			end

			if arg_233_1.time_ >= var_236_16 + var_236_17 and arg_233_1.time_ < var_236_16 + var_236_17 + arg_236_0 then
				local var_236_20 = Color.New(0, 0, 0)

				var_236_20.a = 1
				arg_233_1.mask_.color = var_236_20
			end

			local var_236_21 = 2

			if var_236_21 < arg_233_1.time_ and arg_233_1.time_ <= var_236_21 + arg_236_0 then
				arg_233_1.mask_.enabled = true
				arg_233_1.mask_.raycastTarget = true

				arg_233_1:SetGaussion(false)
			end

			local var_236_22 = 2

			if var_236_21 <= arg_233_1.time_ and arg_233_1.time_ < var_236_21 + var_236_22 then
				local var_236_23 = (arg_233_1.time_ - var_236_21) / var_236_22
				local var_236_24 = Color.New(0, 0, 0)

				var_236_24.a = Mathf.Lerp(1, 0, var_236_23)
				arg_233_1.mask_.color = var_236_24
			end

			if arg_233_1.time_ >= var_236_21 + var_236_22 and arg_233_1.time_ < var_236_21 + var_236_22 + arg_236_0 then
				local var_236_25 = Color.New(0, 0, 0)
				local var_236_26 = 0

				arg_233_1.mask_.enabled = false
				var_236_25.a = var_236_26
				arg_233_1.mask_.color = var_236_25
			end

			local var_236_27 = 2
			local var_236_28 = 1

			if var_236_27 < arg_233_1.time_ and arg_233_1.time_ <= var_236_27 + arg_236_0 then
				local var_236_29 = "play"
				local var_236_30 = "effect"

				arg_233_1:AudioAction(var_236_29, var_236_30, "se_story_side_1096", "se_story_1096_crowd_loop", "")
			end

			if arg_233_1.frameCnt_ <= 1 then
				arg_233_1.dialog_:SetActive(false)
			end

			local var_236_31 = 4
			local var_236_32 = 0.4

			if var_236_31 < arg_233_1.time_ and arg_233_1.time_ <= var_236_31 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0

				arg_233_1.dialog_:SetActive(true)

				arg_233_1.dialogCg_.alpha = 0

				local var_236_33 = LeanTween.value(arg_233_1.dialog_, 0, 1, 0.3)

				var_236_33:setOnUpdate(LuaHelper.FloatAction(function(arg_237_0)
					arg_233_1.dialogCg_.alpha = arg_237_0
				end))
				var_236_33:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_233_1.dialog_)
					var_236_33:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_233_1.duration_ = arg_233_1.duration_ + 0.3

				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_34 = arg_233_1:FormatText(StoryNameCfg[7].name)

				arg_233_1.leftNameTxt_.text = var_236_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, true)
				arg_233_1.iconController_:SetSelectedState("hero")

				arg_233_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_233_1.callingController_:SetSelectedState("normal")

				arg_233_1.keyicon_.color = Color.New(1, 1, 1)
				arg_233_1.icon_.color = Color.New(1, 1, 1)

				local var_236_35 = arg_233_1:GetWordFromCfg(1109302057)
				local var_236_36 = arg_233_1:FormatText(var_236_35.content)

				arg_233_1.text_.text = var_236_36

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_37 = 16
				local var_236_38 = utf8.len(var_236_36)
				local var_236_39 = var_236_37 <= 0 and var_236_32 or var_236_32 * (var_236_38 / var_236_37)

				if var_236_39 > 0 and var_236_32 < var_236_39 then
					arg_233_1.talkMaxDuration = var_236_39
					var_236_31 = var_236_31 + 0.3

					if var_236_39 + var_236_31 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_39 + var_236_31
					end
				end

				arg_233_1.text_.text = var_236_36
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_40 = var_236_31 + 0.3
			local var_236_41 = math.max(var_236_32, arg_233_1.talkMaxDuration)

			if var_236_40 <= arg_233_1.time_ and arg_233_1.time_ < var_236_40 + var_236_41 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_40) / var_236_41

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_40 + var_236_41 and arg_233_1.time_ < var_236_40 + var_236_41 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play1109302058 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 1109302058
		arg_239_1.duration_ = 5

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play1109302059(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0
			local var_242_1 = 0.85

			if var_242_0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_2 = arg_239_1:FormatText(StoryNameCfg[7].name)

				arg_239_1.leftNameTxt_.text = var_242_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, true)
				arg_239_1.iconController_:SetSelectedState("hero")

				arg_239_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_239_1.callingController_:SetSelectedState("normal")

				arg_239_1.keyicon_.color = Color.New(1, 1, 1)
				arg_239_1.icon_.color = Color.New(1, 1, 1)

				local var_242_3 = arg_239_1:GetWordFromCfg(1109302058)
				local var_242_4 = arg_239_1:FormatText(var_242_3.content)

				arg_239_1.text_.text = var_242_4

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_5 = 34
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
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_8 = math.max(var_242_1, arg_239_1.talkMaxDuration)

			if var_242_0 <= arg_239_1.time_ and arg_239_1.time_ < var_242_0 + var_242_8 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_0) / var_242_8

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_0 + var_242_8 and arg_239_1.time_ < var_242_0 + var_242_8 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play1109302059 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 1109302059
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play1109302060(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 0
			local var_246_1 = 0.85

			if var_246_0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_0 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_2 = arg_243_1:FormatText(StoryNameCfg[7].name)

				arg_243_1.leftNameTxt_.text = var_246_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, true)
				arg_243_1.iconController_:SetSelectedState("hero")

				arg_243_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_243_1.callingController_:SetSelectedState("normal")

				arg_243_1.keyicon_.color = Color.New(1, 1, 1)
				arg_243_1.icon_.color = Color.New(1, 1, 1)

				local var_246_3 = arg_243_1:GetWordFromCfg(1109302059)
				local var_246_4 = arg_243_1:FormatText(var_246_3.content)

				arg_243_1.text_.text = var_246_4

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_5 = 34
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
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_8 = math.max(var_246_1, arg_243_1.talkMaxDuration)

			if var_246_0 <= arg_243_1.time_ and arg_243_1.time_ < var_246_0 + var_246_8 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_0) / var_246_8

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_0 + var_246_8 and arg_243_1.time_ < var_246_0 + var_246_8 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play1109302060 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 1109302060
		arg_247_1.duration_ = 5

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play1109302061(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = 0
			local var_250_1 = 0.9

			if var_250_0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_0 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, false)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_2 = arg_247_1:GetWordFromCfg(1109302060)
				local var_250_3 = arg_247_1:FormatText(var_250_2.content)

				arg_247_1.text_.text = var_250_3

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_4 = 36
				local var_250_5 = utf8.len(var_250_3)
				local var_250_6 = var_250_4 <= 0 and var_250_1 or var_250_1 * (var_250_5 / var_250_4)

				if var_250_6 > 0 and var_250_1 < var_250_6 then
					arg_247_1.talkMaxDuration = var_250_6

					if var_250_6 + var_250_0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_6 + var_250_0
					end
				end

				arg_247_1.text_.text = var_250_3
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)
				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_7 = math.max(var_250_1, arg_247_1.talkMaxDuration)

			if var_250_0 <= arg_247_1.time_ and arg_247_1.time_ < var_250_0 + var_250_7 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_0) / var_250_7

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_0 + var_250_7 and arg_247_1.time_ < var_250_0 + var_250_7 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play1109302061 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 1109302061
		arg_251_1.duration_ = 8.83

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play1109302062(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = 0
			local var_254_1 = 0.7

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

				local var_254_2 = arg_251_1:GetWordFromCfg(1109302061)
				local var_254_3 = arg_251_1:FormatText(var_254_2.content)

				arg_251_1.text_.text = var_254_3

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_4 = 28
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

				if manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302061", "story_v_side_new_1109302.awb") ~= 0 then
					local var_254_7 = manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302061", "story_v_side_new_1109302.awb") / 1000

					if var_254_7 + var_254_0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_7 + var_254_0
					end

					if var_254_2.prefab_name ~= "" and arg_251_1.actors_[var_254_2.prefab_name] ~= nil then
						local var_254_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_2.prefab_name].transform, "story_v_side_new_1109302", "1109302061", "story_v_side_new_1109302.awb")

						arg_251_1:RecordAudio("1109302061", var_254_8)
						arg_251_1:RecordAudio("1109302061", var_254_8)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_side_new_1109302", "1109302061", "story_v_side_new_1109302.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_side_new_1109302", "1109302061", "story_v_side_new_1109302.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_9 = math.max(var_254_1, arg_251_1.talkMaxDuration)

			if var_254_0 <= arg_251_1.time_ and arg_251_1.time_ < var_254_0 + var_254_9 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_0) / var_254_9

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_0 + var_254_9 and arg_251_1.time_ < var_254_0 + var_254_9 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play1109302062 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 1109302062
		arg_255_1.duration_ = 5

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play1109302063(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = 0
			local var_258_1 = 0.25

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

				local var_258_2 = arg_255_1:GetWordFromCfg(1109302062)
				local var_258_3 = arg_255_1:FormatText(var_258_2.content)

				arg_255_1.text_.text = var_258_3

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_4 = 10
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
	Play1109302063 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 1109302063
		arg_259_1.duration_ = 3.5

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play1109302064(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = "1050ui_story"

			if arg_259_1.actors_[var_262_0] == nil then
				local var_262_1 = Asset.Load("Char/" .. "1050ui_story")

				if not isNil(var_262_1) then
					local var_262_2 = Object.Instantiate(Asset.Load("Char/" .. "1050ui_story"), arg_259_1.stage_.transform)

					var_262_2.name = var_262_0
					var_262_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_259_1.actors_[var_262_0] = var_262_2

					local var_262_3 = var_262_2:GetComponentInChildren(typeof(CharacterEffect))

					var_262_3.enabled = true

					local var_262_4 = GameObjectTools.GetOrAddComponent(var_262_2, typeof(DynamicBoneHelper))

					if var_262_4 then
						var_262_4:EnableDynamicBone(false)
					end

					arg_259_1:ShowWeapon(var_262_3.transform, false)

					arg_259_1.var_[var_262_0 .. "Animator"] = var_262_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_259_1.var_[var_262_0 .. "Animator"].applyRootMotion = true
					arg_259_1.var_[var_262_0 .. "LipSync"] = var_262_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_262_5 = arg_259_1.actors_["1050ui_story"].transform
			local var_262_6 = 0

			if var_262_6 < arg_259_1.time_ and arg_259_1.time_ <= var_262_6 + arg_262_0 then
				arg_259_1.var_.moveOldPos1050ui_story = var_262_5.localPosition
			end

			local var_262_7 = 0.001

			if var_262_6 <= arg_259_1.time_ and arg_259_1.time_ < var_262_6 + var_262_7 then
				local var_262_8 = (arg_259_1.time_ - var_262_6) / var_262_7
				local var_262_9 = Vector3.New(0, -1, -6.1)

				var_262_5.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos1050ui_story, var_262_9, var_262_8)

				local var_262_10 = manager.ui.mainCamera.transform.position - var_262_5.position

				var_262_5.forward = Vector3.New(var_262_10.x, var_262_10.y, var_262_10.z)

				local var_262_11 = var_262_5.localEulerAngles

				var_262_11.z = 0
				var_262_11.x = 0
				var_262_5.localEulerAngles = var_262_11
			end

			if arg_259_1.time_ >= var_262_6 + var_262_7 and arg_259_1.time_ < var_262_6 + var_262_7 + arg_262_0 then
				var_262_5.localPosition = Vector3.New(0, -1, -6.1)

				local var_262_12 = manager.ui.mainCamera.transform.position - var_262_5.position

				var_262_5.forward = Vector3.New(var_262_12.x, var_262_12.y, var_262_12.z)

				local var_262_13 = var_262_5.localEulerAngles

				var_262_13.z = 0
				var_262_13.x = 0
				var_262_5.localEulerAngles = var_262_13
			end

			local var_262_14 = 0

			if var_262_14 < arg_259_1.time_ and arg_259_1.time_ <= var_262_14 + arg_262_0 then
				arg_259_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action5_1")
			end

			local var_262_15 = 0

			if var_262_15 < arg_259_1.time_ and arg_259_1.time_ <= var_262_15 + arg_262_0 then
				arg_259_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_262_16 = arg_259_1.actors_["1050ui_story"]
			local var_262_17 = 0

			if var_262_17 < arg_259_1.time_ and arg_259_1.time_ <= var_262_17 + arg_262_0 and not isNil(var_262_16) and arg_259_1.var_.characterEffect1050ui_story == nil then
				arg_259_1.var_.characterEffect1050ui_story = var_262_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_18 = 0.2

			if var_262_17 <= arg_259_1.time_ and arg_259_1.time_ < var_262_17 + var_262_18 and not isNil(var_262_16) then
				local var_262_19 = (arg_259_1.time_ - var_262_17) / var_262_18

				if arg_259_1.var_.characterEffect1050ui_story and not isNil(var_262_16) then
					arg_259_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_259_1.time_ >= var_262_17 + var_262_18 and arg_259_1.time_ < var_262_17 + var_262_18 + arg_262_0 and not isNil(var_262_16) and arg_259_1.var_.characterEffect1050ui_story then
				arg_259_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_262_20 = 0
			local var_262_21 = 0.325

			if var_262_20 < arg_259_1.time_ and arg_259_1.time_ <= var_262_20 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				local var_262_22 = arg_259_1:FormatText(StoryNameCfg[74].name)

				arg_259_1.leftNameTxt_.text = var_262_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_23 = arg_259_1:GetWordFromCfg(1109302063)
				local var_262_24 = arg_259_1:FormatText(var_262_23.content)

				arg_259_1.text_.text = var_262_24

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_25 = 13
				local var_262_26 = utf8.len(var_262_24)
				local var_262_27 = var_262_25 <= 0 and var_262_21 or var_262_21 * (var_262_26 / var_262_25)

				if var_262_27 > 0 and var_262_21 < var_262_27 then
					arg_259_1.talkMaxDuration = var_262_27

					if var_262_27 + var_262_20 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_27 + var_262_20
					end
				end

				arg_259_1.text_.text = var_262_24
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302063", "story_v_side_new_1109302.awb") ~= 0 then
					local var_262_28 = manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302063", "story_v_side_new_1109302.awb") / 1000

					if var_262_28 + var_262_20 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_28 + var_262_20
					end

					if var_262_23.prefab_name ~= "" and arg_259_1.actors_[var_262_23.prefab_name] ~= nil then
						local var_262_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_23.prefab_name].transform, "story_v_side_new_1109302", "1109302063", "story_v_side_new_1109302.awb")

						arg_259_1:RecordAudio("1109302063", var_262_29)
						arg_259_1:RecordAudio("1109302063", var_262_29)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_side_new_1109302", "1109302063", "story_v_side_new_1109302.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_side_new_1109302", "1109302063", "story_v_side_new_1109302.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_30 = math.max(var_262_21, arg_259_1.talkMaxDuration)

			if var_262_20 <= arg_259_1.time_ and arg_259_1.time_ < var_262_20 + var_262_30 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_20) / var_262_30

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_20 + var_262_30 and arg_259_1.time_ < var_262_20 + var_262_30 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_259_1:InitPlayNodeList()
	end,
	Play1109302064 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 1109302064
		arg_263_1.duration_ = 5

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play1109302065(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = arg_263_1.actors_["1050ui_story"]
			local var_266_1 = 0

			if var_266_1 < arg_263_1.time_ and arg_263_1.time_ <= var_266_1 + arg_266_0 and not isNil(var_266_0) and arg_263_1.var_.characterEffect1050ui_story == nil then
				arg_263_1.var_.characterEffect1050ui_story = var_266_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_2 = 0.2

			if var_266_1 <= arg_263_1.time_ and arg_263_1.time_ < var_266_1 + var_266_2 and not isNil(var_266_0) then
				local var_266_3 = (arg_263_1.time_ - var_266_1) / var_266_2

				if arg_263_1.var_.characterEffect1050ui_story and not isNil(var_266_0) then
					local var_266_4 = Mathf.Lerp(0, 0.5, var_266_3)

					arg_263_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_263_1.var_.characterEffect1050ui_story.fillRatio = var_266_4
				end
			end

			if arg_263_1.time_ >= var_266_1 + var_266_2 and arg_263_1.time_ < var_266_1 + var_266_2 + arg_266_0 and not isNil(var_266_0) and arg_263_1.var_.characterEffect1050ui_story then
				local var_266_5 = 0.5

				arg_263_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_263_1.var_.characterEffect1050ui_story.fillRatio = var_266_5
			end

			local var_266_6 = 0
			local var_266_7 = 0.375

			if var_266_6 < arg_263_1.time_ and arg_263_1.time_ <= var_266_6 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				local var_266_8 = arg_263_1:FormatText(StoryNameCfg[7].name)

				arg_263_1.leftNameTxt_.text = var_266_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, true)
				arg_263_1.iconController_:SetSelectedState("hero")

				arg_263_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_263_1.callingController_:SetSelectedState("normal")

				arg_263_1.keyicon_.color = Color.New(1, 1, 1)
				arg_263_1.icon_.color = Color.New(1, 1, 1)

				local var_266_9 = arg_263_1:GetWordFromCfg(1109302064)
				local var_266_10 = arg_263_1:FormatText(var_266_9.content)

				arg_263_1.text_.text = var_266_10

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_11 = 15
				local var_266_12 = utf8.len(var_266_10)
				local var_266_13 = var_266_11 <= 0 and var_266_7 or var_266_7 * (var_266_12 / var_266_11)

				if var_266_13 > 0 and var_266_7 < var_266_13 then
					arg_263_1.talkMaxDuration = var_266_13

					if var_266_13 + var_266_6 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_13 + var_266_6
					end
				end

				arg_263_1.text_.text = var_266_10
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_14 = math.max(var_266_7, arg_263_1.talkMaxDuration)

			if var_266_6 <= arg_263_1.time_ and arg_263_1.time_ < var_266_6 + var_266_14 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_6) / var_266_14

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_6 + var_266_14 and arg_263_1.time_ < var_266_6 + var_266_14 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play1109302065 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 1109302065
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play1109302066(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = 0
			local var_270_1 = 0.475

			if var_270_0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_0 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				local var_270_2 = arg_267_1:FormatText(StoryNameCfg[7].name)

				arg_267_1.leftNameTxt_.text = var_270_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, true)
				arg_267_1.iconController_:SetSelectedState("hero")

				arg_267_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_267_1.callingController_:SetSelectedState("normal")

				arg_267_1.keyicon_.color = Color.New(1, 1, 1)
				arg_267_1.icon_.color = Color.New(1, 1, 1)

				local var_270_3 = arg_267_1:GetWordFromCfg(1109302065)
				local var_270_4 = arg_267_1:FormatText(var_270_3.content)

				arg_267_1.text_.text = var_270_4

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_5 = 19
				local var_270_6 = utf8.len(var_270_4)
				local var_270_7 = var_270_5 <= 0 and var_270_1 or var_270_1 * (var_270_6 / var_270_5)

				if var_270_7 > 0 and var_270_1 < var_270_7 then
					arg_267_1.talkMaxDuration = var_270_7

					if var_270_7 + var_270_0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_7 + var_270_0
					end
				end

				arg_267_1.text_.text = var_270_4
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)
				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_8 = math.max(var_270_1, arg_267_1.talkMaxDuration)

			if var_270_0 <= arg_267_1.time_ and arg_267_1.time_ < var_270_0 + var_270_8 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_0) / var_270_8

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_0 + var_270_8 and arg_267_1.time_ < var_270_0 + var_270_8 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play1109302066 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 1109302066
		arg_271_1.duration_ = 2

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play1109302067(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = arg_271_1.actors_["1050ui_story"]
			local var_274_1 = 0

			if var_274_1 < arg_271_1.time_ and arg_271_1.time_ <= var_274_1 + arg_274_0 and not isNil(var_274_0) and arg_271_1.var_.characterEffect1050ui_story == nil then
				arg_271_1.var_.characterEffect1050ui_story = var_274_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_2 = 0.2

			if var_274_1 <= arg_271_1.time_ and arg_271_1.time_ < var_274_1 + var_274_2 and not isNil(var_274_0) then
				local var_274_3 = (arg_271_1.time_ - var_274_1) / var_274_2

				if arg_271_1.var_.characterEffect1050ui_story and not isNil(var_274_0) then
					arg_271_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_271_1.time_ >= var_274_1 + var_274_2 and arg_271_1.time_ < var_274_1 + var_274_2 + arg_274_0 and not isNil(var_274_0) and arg_271_1.var_.characterEffect1050ui_story then
				arg_271_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_274_4 = 0

			if var_274_4 < arg_271_1.time_ and arg_271_1.time_ <= var_274_4 + arg_274_0 then
				arg_271_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_274_5 = 0
			local var_274_6 = 0.075

			if var_274_5 < arg_271_1.time_ and arg_271_1.time_ <= var_274_5 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				local var_274_7 = arg_271_1:FormatText(StoryNameCfg[74].name)

				arg_271_1.leftNameTxt_.text = var_274_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_8 = arg_271_1:GetWordFromCfg(1109302066)
				local var_274_9 = arg_271_1:FormatText(var_274_8.content)

				arg_271_1.text_.text = var_274_9

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_10 = 3
				local var_274_11 = utf8.len(var_274_9)
				local var_274_12 = var_274_10 <= 0 and var_274_6 or var_274_6 * (var_274_11 / var_274_10)

				if var_274_12 > 0 and var_274_6 < var_274_12 then
					arg_271_1.talkMaxDuration = var_274_12

					if var_274_12 + var_274_5 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_12 + var_274_5
					end
				end

				arg_271_1.text_.text = var_274_9
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302066", "story_v_side_new_1109302.awb") ~= 0 then
					local var_274_13 = manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302066", "story_v_side_new_1109302.awb") / 1000

					if var_274_13 + var_274_5 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_13 + var_274_5
					end

					if var_274_8.prefab_name ~= "" and arg_271_1.actors_[var_274_8.prefab_name] ~= nil then
						local var_274_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_8.prefab_name].transform, "story_v_side_new_1109302", "1109302066", "story_v_side_new_1109302.awb")

						arg_271_1:RecordAudio("1109302066", var_274_14)
						arg_271_1:RecordAudio("1109302066", var_274_14)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_side_new_1109302", "1109302066", "story_v_side_new_1109302.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_side_new_1109302", "1109302066", "story_v_side_new_1109302.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_15 = math.max(var_274_6, arg_271_1.talkMaxDuration)

			if var_274_5 <= arg_271_1.time_ and arg_271_1.time_ < var_274_5 + var_274_15 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_5) / var_274_15

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_5 + var_274_15 and arg_271_1.time_ < var_274_5 + var_274_15 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play1109302067 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 1109302067
		arg_275_1.duration_ = 7.4

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play1109302068(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = 0

			if var_278_0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_0 + arg_278_0 then
				arg_275_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050actionlink/1050action452")
			end

			local var_278_1 = 0

			if var_278_1 < arg_275_1.time_ and arg_275_1.time_ <= var_278_1 + arg_278_0 then
				arg_275_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_278_2 = 0
			local var_278_3 = 0.85

			if var_278_2 < arg_275_1.time_ and arg_275_1.time_ <= var_278_2 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				local var_278_4 = arg_275_1:FormatText(StoryNameCfg[74].name)

				arg_275_1.leftNameTxt_.text = var_278_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_5 = arg_275_1:GetWordFromCfg(1109302067)
				local var_278_6 = arg_275_1:FormatText(var_278_5.content)

				arg_275_1.text_.text = var_278_6

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_7 = 34
				local var_278_8 = utf8.len(var_278_6)
				local var_278_9 = var_278_7 <= 0 and var_278_3 or var_278_3 * (var_278_8 / var_278_7)

				if var_278_9 > 0 and var_278_3 < var_278_9 then
					arg_275_1.talkMaxDuration = var_278_9

					if var_278_9 + var_278_2 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_9 + var_278_2
					end
				end

				arg_275_1.text_.text = var_278_6
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302067", "story_v_side_new_1109302.awb") ~= 0 then
					local var_278_10 = manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302067", "story_v_side_new_1109302.awb") / 1000

					if var_278_10 + var_278_2 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_10 + var_278_2
					end

					if var_278_5.prefab_name ~= "" and arg_275_1.actors_[var_278_5.prefab_name] ~= nil then
						local var_278_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_5.prefab_name].transform, "story_v_side_new_1109302", "1109302067", "story_v_side_new_1109302.awb")

						arg_275_1:RecordAudio("1109302067", var_278_11)
						arg_275_1:RecordAudio("1109302067", var_278_11)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_side_new_1109302", "1109302067", "story_v_side_new_1109302.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_side_new_1109302", "1109302067", "story_v_side_new_1109302.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_12 = math.max(var_278_3, arg_275_1.talkMaxDuration)

			if var_278_2 <= arg_275_1.time_ and arg_275_1.time_ < var_278_2 + var_278_12 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_2) / var_278_12

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_2 + var_278_12 and arg_275_1.time_ < var_278_2 + var_278_12 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play1109302068 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 1109302068
		arg_279_1.duration_ = 5

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play1109302069(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = arg_279_1.actors_["1050ui_story"]
			local var_282_1 = 0

			if var_282_1 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 and not isNil(var_282_0) and arg_279_1.var_.characterEffect1050ui_story == nil then
				arg_279_1.var_.characterEffect1050ui_story = var_282_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_2 = 0.2

			if var_282_1 <= arg_279_1.time_ and arg_279_1.time_ < var_282_1 + var_282_2 and not isNil(var_282_0) then
				local var_282_3 = (arg_279_1.time_ - var_282_1) / var_282_2

				if arg_279_1.var_.characterEffect1050ui_story and not isNil(var_282_0) then
					local var_282_4 = Mathf.Lerp(0, 0.5, var_282_3)

					arg_279_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_279_1.var_.characterEffect1050ui_story.fillRatio = var_282_4
				end
			end

			if arg_279_1.time_ >= var_282_1 + var_282_2 and arg_279_1.time_ < var_282_1 + var_282_2 + arg_282_0 and not isNil(var_282_0) and arg_279_1.var_.characterEffect1050ui_story then
				local var_282_5 = 0.5

				arg_279_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_279_1.var_.characterEffect1050ui_story.fillRatio = var_282_5
			end

			local var_282_6 = 0
			local var_282_7 = 0.55

			if var_282_6 < arg_279_1.time_ and arg_279_1.time_ <= var_282_6 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				local var_282_8 = arg_279_1:FormatText(StoryNameCfg[7].name)

				arg_279_1.leftNameTxt_.text = var_282_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, true)
				arg_279_1.iconController_:SetSelectedState("hero")

				arg_279_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_279_1.callingController_:SetSelectedState("normal")

				arg_279_1.keyicon_.color = Color.New(1, 1, 1)
				arg_279_1.icon_.color = Color.New(1, 1, 1)

				local var_282_9 = arg_279_1:GetWordFromCfg(1109302068)
				local var_282_10 = arg_279_1:FormatText(var_282_9.content)

				arg_279_1.text_.text = var_282_10

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_11 = 22
				local var_282_12 = utf8.len(var_282_10)
				local var_282_13 = var_282_11 <= 0 and var_282_7 or var_282_7 * (var_282_12 / var_282_11)

				if var_282_13 > 0 and var_282_7 < var_282_13 then
					arg_279_1.talkMaxDuration = var_282_13

					if var_282_13 + var_282_6 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_13 + var_282_6
					end
				end

				arg_279_1.text_.text = var_282_10
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)
				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_14 = math.max(var_282_7, arg_279_1.talkMaxDuration)

			if var_282_6 <= arg_279_1.time_ and arg_279_1.time_ < var_282_6 + var_282_14 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_6) / var_282_14

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_6 + var_282_14 and arg_279_1.time_ < var_282_6 + var_282_14 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play1109302069 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 1109302069
		arg_283_1.duration_ = 4.3

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play1109302070(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = arg_283_1.actors_["1050ui_story"]
			local var_286_1 = 0

			if var_286_1 < arg_283_1.time_ and arg_283_1.time_ <= var_286_1 + arg_286_0 and not isNil(var_286_0) and arg_283_1.var_.characterEffect1050ui_story == nil then
				arg_283_1.var_.characterEffect1050ui_story = var_286_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_2 = 0.2

			if var_286_1 <= arg_283_1.time_ and arg_283_1.time_ < var_286_1 + var_286_2 and not isNil(var_286_0) then
				local var_286_3 = (arg_283_1.time_ - var_286_1) / var_286_2

				if arg_283_1.var_.characterEffect1050ui_story and not isNil(var_286_0) then
					arg_283_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_283_1.time_ >= var_286_1 + var_286_2 and arg_283_1.time_ < var_286_1 + var_286_2 + arg_286_0 and not isNil(var_286_0) and arg_283_1.var_.characterEffect1050ui_story then
				arg_283_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_286_4 = 0

			if var_286_4 < arg_283_1.time_ and arg_283_1.time_ <= var_286_4 + arg_286_0 then
				arg_283_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_286_5 = 0
			local var_286_6 = 0.475

			if var_286_5 < arg_283_1.time_ and arg_283_1.time_ <= var_286_5 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				local var_286_7 = arg_283_1:FormatText(StoryNameCfg[74].name)

				arg_283_1.leftNameTxt_.text = var_286_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_8 = arg_283_1:GetWordFromCfg(1109302069)
				local var_286_9 = arg_283_1:FormatText(var_286_8.content)

				arg_283_1.text_.text = var_286_9

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_10 = 19
				local var_286_11 = utf8.len(var_286_9)
				local var_286_12 = var_286_10 <= 0 and var_286_6 or var_286_6 * (var_286_11 / var_286_10)

				if var_286_12 > 0 and var_286_6 < var_286_12 then
					arg_283_1.talkMaxDuration = var_286_12

					if var_286_12 + var_286_5 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_12 + var_286_5
					end
				end

				arg_283_1.text_.text = var_286_9
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302069", "story_v_side_new_1109302.awb") ~= 0 then
					local var_286_13 = manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302069", "story_v_side_new_1109302.awb") / 1000

					if var_286_13 + var_286_5 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_13 + var_286_5
					end

					if var_286_8.prefab_name ~= "" and arg_283_1.actors_[var_286_8.prefab_name] ~= nil then
						local var_286_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_8.prefab_name].transform, "story_v_side_new_1109302", "1109302069", "story_v_side_new_1109302.awb")

						arg_283_1:RecordAudio("1109302069", var_286_14)
						arg_283_1:RecordAudio("1109302069", var_286_14)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_side_new_1109302", "1109302069", "story_v_side_new_1109302.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_side_new_1109302", "1109302069", "story_v_side_new_1109302.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_15 = math.max(var_286_6, arg_283_1.talkMaxDuration)

			if var_286_5 <= arg_283_1.time_ and arg_283_1.time_ < var_286_5 + var_286_15 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_5) / var_286_15

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_5 + var_286_15 and arg_283_1.time_ < var_286_5 + var_286_15 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play1109302070 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 1109302070
		arg_287_1.duration_ = 11.57

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play1109302071(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = 0

			if var_290_0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_0 + arg_290_0 then
				arg_287_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050actionlink/1050action425")
			end

			local var_290_1 = 0

			if var_290_1 < arg_287_1.time_ and arg_287_1.time_ <= var_290_1 + arg_290_0 then
				arg_287_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_290_2 = 0
			local var_290_3 = 0.775

			if var_290_2 < arg_287_1.time_ and arg_287_1.time_ <= var_290_2 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				local var_290_4 = arg_287_1:FormatText(StoryNameCfg[74].name)

				arg_287_1.leftNameTxt_.text = var_290_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_5 = arg_287_1:GetWordFromCfg(1109302070)
				local var_290_6 = arg_287_1:FormatText(var_290_5.content)

				arg_287_1.text_.text = var_290_6

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_7 = 31
				local var_290_8 = utf8.len(var_290_6)
				local var_290_9 = var_290_7 <= 0 and var_290_3 or var_290_3 * (var_290_8 / var_290_7)

				if var_290_9 > 0 and var_290_3 < var_290_9 then
					arg_287_1.talkMaxDuration = var_290_9

					if var_290_9 + var_290_2 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_9 + var_290_2
					end
				end

				arg_287_1.text_.text = var_290_6
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302070", "story_v_side_new_1109302.awb") ~= 0 then
					local var_290_10 = manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302070", "story_v_side_new_1109302.awb") / 1000

					if var_290_10 + var_290_2 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_10 + var_290_2
					end

					if var_290_5.prefab_name ~= "" and arg_287_1.actors_[var_290_5.prefab_name] ~= nil then
						local var_290_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_5.prefab_name].transform, "story_v_side_new_1109302", "1109302070", "story_v_side_new_1109302.awb")

						arg_287_1:RecordAudio("1109302070", var_290_11)
						arg_287_1:RecordAudio("1109302070", var_290_11)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_side_new_1109302", "1109302070", "story_v_side_new_1109302.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_side_new_1109302", "1109302070", "story_v_side_new_1109302.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_12 = math.max(var_290_3, arg_287_1.talkMaxDuration)

			if var_290_2 <= arg_287_1.time_ and arg_287_1.time_ < var_290_2 + var_290_12 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_2) / var_290_12

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_2 + var_290_12 and arg_287_1.time_ < var_290_2 + var_290_12 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play1109302071 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 1109302071
		arg_291_1.duration_ = 0.2

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"

			SetActive(arg_291_1.choicesGo_, true)

			for iter_292_0, iter_292_1 in ipairs(arg_291_1.choices_) do
				local var_292_0 = iter_292_0 <= 2

				SetActive(iter_292_1.go, var_292_0)
			end

			arg_291_1.choices_[1].txt.text = arg_291_1:FormatText(StoryChoiceCfg[344].name)
			arg_291_1.choices_[2].txt.text = arg_291_1:FormatText(StoryChoiceCfg[345].name)
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play1109302072(arg_291_1)
			end

			if arg_293_0 == 2 then
				arg_291_0:Play1109302072(arg_291_1)
			end

			arg_291_1:RecordChoiceLog(1109302071, 344, 345)
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = arg_291_1.actors_["1050ui_story"]
			local var_294_1 = 0

			if var_294_1 < arg_291_1.time_ and arg_291_1.time_ <= var_294_1 + arg_294_0 and not isNil(var_294_0) and arg_291_1.var_.characterEffect1050ui_story == nil then
				arg_291_1.var_.characterEffect1050ui_story = var_294_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_2 = 0.2

			if var_294_1 <= arg_291_1.time_ and arg_291_1.time_ < var_294_1 + var_294_2 and not isNil(var_294_0) then
				local var_294_3 = (arg_291_1.time_ - var_294_1) / var_294_2

				if arg_291_1.var_.characterEffect1050ui_story and not isNil(var_294_0) then
					local var_294_4 = Mathf.Lerp(0, 0.5, var_294_3)

					arg_291_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_291_1.var_.characterEffect1050ui_story.fillRatio = var_294_4
				end
			end

			if arg_291_1.time_ >= var_294_1 + var_294_2 and arg_291_1.time_ < var_294_1 + var_294_2 + arg_294_0 and not isNil(var_294_0) and arg_291_1.var_.characterEffect1050ui_story then
				local var_294_5 = 0.5

				arg_291_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_291_1.var_.characterEffect1050ui_story.fillRatio = var_294_5
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play1109302072 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 1109302072
		arg_295_1.duration_ = 5.27

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play1109302073(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = arg_295_1.actors_["1050ui_story"]
			local var_298_1 = 0

			if var_298_1 < arg_295_1.time_ and arg_295_1.time_ <= var_298_1 + arg_298_0 and not isNil(var_298_0) and arg_295_1.var_.characterEffect1050ui_story == nil then
				arg_295_1.var_.characterEffect1050ui_story = var_298_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_2 = 0.2

			if var_298_1 <= arg_295_1.time_ and arg_295_1.time_ < var_298_1 + var_298_2 and not isNil(var_298_0) then
				local var_298_3 = (arg_295_1.time_ - var_298_1) / var_298_2

				if arg_295_1.var_.characterEffect1050ui_story and not isNil(var_298_0) then
					arg_295_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_295_1.time_ >= var_298_1 + var_298_2 and arg_295_1.time_ < var_298_1 + var_298_2 + arg_298_0 and not isNil(var_298_0) and arg_295_1.var_.characterEffect1050ui_story then
				arg_295_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_298_4 = "1050ui_story"

			if arg_295_1.actors_[var_298_4] == nil then
				local var_298_5 = Asset.Load("Char/" .. "1050ui_story")

				if not isNil(var_298_5) then
					local var_298_6 = Object.Instantiate(Asset.Load("Char/" .. "1050ui_story"), arg_295_1.stage_.transform)

					var_298_6.name = var_298_4
					var_298_6.transform.localPosition = Vector3.New(0, 100, 0)
					arg_295_1.actors_[var_298_4] = var_298_6

					local var_298_7 = var_298_6:GetComponentInChildren(typeof(CharacterEffect))

					var_298_7.enabled = true

					local var_298_8 = GameObjectTools.GetOrAddComponent(var_298_6, typeof(DynamicBoneHelper))

					if var_298_8 then
						var_298_8:EnableDynamicBone(false)
					end

					arg_295_1:ShowWeapon(var_298_7.transform, false)

					arg_295_1.var_[var_298_4 .. "Animator"] = var_298_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_295_1.var_[var_298_4 .. "Animator"].applyRootMotion = true
					arg_295_1.var_[var_298_4 .. "LipSync"] = var_298_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_298_9 = 0

			if var_298_9 < arg_295_1.time_ and arg_295_1.time_ <= var_298_9 + arg_298_0 then
				arg_295_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050actionlink/1050action452")
			end

			local var_298_10 = "1050ui_story"

			if arg_295_1.actors_[var_298_10] == nil then
				local var_298_11 = Asset.Load("Char/" .. "1050ui_story")

				if not isNil(var_298_11) then
					local var_298_12 = Object.Instantiate(Asset.Load("Char/" .. "1050ui_story"), arg_295_1.stage_.transform)

					var_298_12.name = var_298_10
					var_298_12.transform.localPosition = Vector3.New(0, 100, 0)
					arg_295_1.actors_[var_298_10] = var_298_12

					local var_298_13 = var_298_12:GetComponentInChildren(typeof(CharacterEffect))

					var_298_13.enabled = true

					local var_298_14 = GameObjectTools.GetOrAddComponent(var_298_12, typeof(DynamicBoneHelper))

					if var_298_14 then
						var_298_14:EnableDynamicBone(false)
					end

					arg_295_1:ShowWeapon(var_298_13.transform, false)

					arg_295_1.var_[var_298_10 .. "Animator"] = var_298_13.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_295_1.var_[var_298_10 .. "Animator"].applyRootMotion = true
					arg_295_1.var_[var_298_10 .. "LipSync"] = var_298_13.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_298_15 = 0

			if var_298_15 < arg_295_1.time_ and arg_295_1.time_ <= var_298_15 + arg_298_0 then
				arg_295_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_298_16 = 0
			local var_298_17 = 0.6

			if var_298_16 < arg_295_1.time_ and arg_295_1.time_ <= var_298_16 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				local var_298_18 = arg_295_1:FormatText(StoryNameCfg[74].name)

				arg_295_1.leftNameTxt_.text = var_298_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_19 = arg_295_1:GetWordFromCfg(1109302072)
				local var_298_20 = arg_295_1:FormatText(var_298_19.content)

				arg_295_1.text_.text = var_298_20

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_21 = 24
				local var_298_22 = utf8.len(var_298_20)
				local var_298_23 = var_298_21 <= 0 and var_298_17 or var_298_17 * (var_298_22 / var_298_21)

				if var_298_23 > 0 and var_298_17 < var_298_23 then
					arg_295_1.talkMaxDuration = var_298_23

					if var_298_23 + var_298_16 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_23 + var_298_16
					end
				end

				arg_295_1.text_.text = var_298_20
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302072", "story_v_side_new_1109302.awb") ~= 0 then
					local var_298_24 = manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302072", "story_v_side_new_1109302.awb") / 1000

					if var_298_24 + var_298_16 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_24 + var_298_16
					end

					if var_298_19.prefab_name ~= "" and arg_295_1.actors_[var_298_19.prefab_name] ~= nil then
						local var_298_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_19.prefab_name].transform, "story_v_side_new_1109302", "1109302072", "story_v_side_new_1109302.awb")

						arg_295_1:RecordAudio("1109302072", var_298_25)
						arg_295_1:RecordAudio("1109302072", var_298_25)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_side_new_1109302", "1109302072", "story_v_side_new_1109302.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_side_new_1109302", "1109302072", "story_v_side_new_1109302.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_26 = math.max(var_298_17, arg_295_1.talkMaxDuration)

			if var_298_16 <= arg_295_1.time_ and arg_295_1.time_ < var_298_16 + var_298_26 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_16) / var_298_26

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_16 + var_298_26 and arg_295_1.time_ < var_298_16 + var_298_26 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play1109302073 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 1109302073
		arg_299_1.duration_ = 5

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play1109302074(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = arg_299_1.actors_["1050ui_story"]
			local var_302_1 = 0

			if var_302_1 < arg_299_1.time_ and arg_299_1.time_ <= var_302_1 + arg_302_0 and not isNil(var_302_0) and arg_299_1.var_.characterEffect1050ui_story == nil then
				arg_299_1.var_.characterEffect1050ui_story = var_302_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_2 = 0.2

			if var_302_1 <= arg_299_1.time_ and arg_299_1.time_ < var_302_1 + var_302_2 and not isNil(var_302_0) then
				local var_302_3 = (arg_299_1.time_ - var_302_1) / var_302_2

				if arg_299_1.var_.characterEffect1050ui_story and not isNil(var_302_0) then
					local var_302_4 = Mathf.Lerp(0, 0.5, var_302_3)

					arg_299_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_299_1.var_.characterEffect1050ui_story.fillRatio = var_302_4
				end
			end

			if arg_299_1.time_ >= var_302_1 + var_302_2 and arg_299_1.time_ < var_302_1 + var_302_2 + arg_302_0 and not isNil(var_302_0) and arg_299_1.var_.characterEffect1050ui_story then
				local var_302_5 = 0.5

				arg_299_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_299_1.var_.characterEffect1050ui_story.fillRatio = var_302_5
			end

			local var_302_6 = 0
			local var_302_7 = 0.25

			if var_302_6 < arg_299_1.time_ and arg_299_1.time_ <= var_302_6 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				local var_302_8 = arg_299_1:FormatText(StoryNameCfg[7].name)

				arg_299_1.leftNameTxt_.text = var_302_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, true)
				arg_299_1.iconController_:SetSelectedState("hero")

				arg_299_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_299_1.callingController_:SetSelectedState("normal")

				arg_299_1.keyicon_.color = Color.New(1, 1, 1)
				arg_299_1.icon_.color = Color.New(1, 1, 1)

				local var_302_9 = arg_299_1:GetWordFromCfg(1109302073)
				local var_302_10 = arg_299_1:FormatText(var_302_9.content)

				arg_299_1.text_.text = var_302_10

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_11 = 10
				local var_302_12 = utf8.len(var_302_10)
				local var_302_13 = var_302_11 <= 0 and var_302_7 or var_302_7 * (var_302_12 / var_302_11)

				if var_302_13 > 0 and var_302_7 < var_302_13 then
					arg_299_1.talkMaxDuration = var_302_13

					if var_302_13 + var_302_6 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_13 + var_302_6
					end
				end

				arg_299_1.text_.text = var_302_10
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)
				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_14 = math.max(var_302_7, arg_299_1.talkMaxDuration)

			if var_302_6 <= arg_299_1.time_ and arg_299_1.time_ < var_302_6 + var_302_14 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_6) / var_302_14

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_6 + var_302_14 and arg_299_1.time_ < var_302_6 + var_302_14 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play1109302074 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 1109302074
		arg_303_1.duration_ = 9

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play1109302075(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = "ST11"

			if arg_303_1.bgs_[var_306_0] == nil then
				local var_306_1 = Object.Instantiate(arg_303_1.paintGo_)

				var_306_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_306_0)
				var_306_1.name = var_306_0
				var_306_1.transform.parent = arg_303_1.stage_.transform
				var_306_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_303_1.bgs_[var_306_0] = var_306_1
			end

			local var_306_2 = 2

			if var_306_2 < arg_303_1.time_ and arg_303_1.time_ <= var_306_2 + arg_306_0 then
				local var_306_3 = manager.ui.mainCamera.transform.localPosition
				local var_306_4 = Vector3.New(0, 0, 10) + Vector3.New(var_306_3.x, var_306_3.y, 0)
				local var_306_5 = arg_303_1.bgs_.ST11

				var_306_5.transform.localPosition = var_306_4
				var_306_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_306_6 = var_306_5:GetComponent("SpriteRenderer")

				if var_306_6 and var_306_6.sprite then
					local var_306_7 = (var_306_5.transform.localPosition - var_306_3).z
					local var_306_8 = manager.ui.mainCameraCom_
					local var_306_9 = 2 * var_306_7 * Mathf.Tan(var_306_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_306_10 = var_306_9 * var_306_8.aspect
					local var_306_11 = var_306_6.sprite.bounds.size.x
					local var_306_12 = var_306_6.sprite.bounds.size.y
					local var_306_13 = var_306_10 / var_306_11
					local var_306_14 = var_306_9 / var_306_12
					local var_306_15 = var_306_14 < var_306_13 and var_306_13 or var_306_14

					var_306_5.transform.localScale = Vector3.New(var_306_15, var_306_15, 0)
				end

				for iter_306_0, iter_306_1 in pairs(arg_303_1.bgs_) do
					if iter_306_0 ~= "ST11" then
						iter_306_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_306_16 = 0

			if var_306_16 < arg_303_1.time_ and arg_303_1.time_ <= var_306_16 + arg_306_0 then
				arg_303_1.mask_.enabled = true
				arg_303_1.mask_.raycastTarget = true

				arg_303_1:SetGaussion(false)
			end

			local var_306_17 = 2

			if var_306_16 <= arg_303_1.time_ and arg_303_1.time_ < var_306_16 + var_306_17 then
				local var_306_18 = (arg_303_1.time_ - var_306_16) / var_306_17
				local var_306_19 = Color.New(0, 0, 0)

				var_306_19.a = Mathf.Lerp(0, 1, var_306_18)
				arg_303_1.mask_.color = var_306_19
			end

			if arg_303_1.time_ >= var_306_16 + var_306_17 and arg_303_1.time_ < var_306_16 + var_306_17 + arg_306_0 then
				local var_306_20 = Color.New(0, 0, 0)

				var_306_20.a = 1
				arg_303_1.mask_.color = var_306_20
			end

			local var_306_21 = 2

			if var_306_21 < arg_303_1.time_ and arg_303_1.time_ <= var_306_21 + arg_306_0 then
				arg_303_1.mask_.enabled = true
				arg_303_1.mask_.raycastTarget = true

				arg_303_1:SetGaussion(false)
			end

			local var_306_22 = 2

			if var_306_21 <= arg_303_1.time_ and arg_303_1.time_ < var_306_21 + var_306_22 then
				local var_306_23 = (arg_303_1.time_ - var_306_21) / var_306_22
				local var_306_24 = Color.New(0, 0, 0)

				var_306_24.a = Mathf.Lerp(1, 0, var_306_23)
				arg_303_1.mask_.color = var_306_24
			end

			if arg_303_1.time_ >= var_306_21 + var_306_22 and arg_303_1.time_ < var_306_21 + var_306_22 + arg_306_0 then
				local var_306_25 = Color.New(0, 0, 0)
				local var_306_26 = 0

				arg_303_1.mask_.enabled = false
				var_306_25.a = var_306_26
				arg_303_1.mask_.color = var_306_25
			end

			local var_306_27 = arg_303_1.actors_["1050ui_story"].transform
			local var_306_28 = 1.966

			if var_306_28 < arg_303_1.time_ and arg_303_1.time_ <= var_306_28 + arg_306_0 then
				arg_303_1.var_.moveOldPos1050ui_story = var_306_27.localPosition
			end

			local var_306_29 = 0.001

			if var_306_28 <= arg_303_1.time_ and arg_303_1.time_ < var_306_28 + var_306_29 then
				local var_306_30 = (arg_303_1.time_ - var_306_28) / var_306_29
				local var_306_31 = Vector3.New(0, 100, 0)

				var_306_27.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos1050ui_story, var_306_31, var_306_30)

				local var_306_32 = manager.ui.mainCamera.transform.position - var_306_27.position

				var_306_27.forward = Vector3.New(var_306_32.x, var_306_32.y, var_306_32.z)

				local var_306_33 = var_306_27.localEulerAngles

				var_306_33.z = 0
				var_306_33.x = 0
				var_306_27.localEulerAngles = var_306_33
			end

			if arg_303_1.time_ >= var_306_28 + var_306_29 and arg_303_1.time_ < var_306_28 + var_306_29 + arg_306_0 then
				var_306_27.localPosition = Vector3.New(0, 100, 0)

				local var_306_34 = manager.ui.mainCamera.transform.position - var_306_27.position

				var_306_27.forward = Vector3.New(var_306_34.x, var_306_34.y, var_306_34.z)

				local var_306_35 = var_306_27.localEulerAngles

				var_306_35.z = 0
				var_306_35.x = 0
				var_306_27.localEulerAngles = var_306_35
			end

			local var_306_36 = 0
			local var_306_37 = 1

			if var_306_36 < arg_303_1.time_ and arg_303_1.time_ <= var_306_36 + arg_306_0 then
				local var_306_38 = "stop"
				local var_306_39 = "effect"

				arg_303_1:AudioAction(var_306_38, var_306_39, "se_story_side_1096", "se_story_1096_crowd_loop", "")
			end

			if arg_303_1.frameCnt_ <= 1 then
				arg_303_1.dialog_:SetActive(false)
			end

			local var_306_40 = 4
			local var_306_41 = 0.4

			if var_306_40 < arg_303_1.time_ and arg_303_1.time_ <= var_306_40 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0

				arg_303_1.dialog_:SetActive(true)

				arg_303_1.dialogCg_.alpha = 0

				local var_306_42 = LeanTween.value(arg_303_1.dialog_, 0, 1, 0.3)

				var_306_42:setOnUpdate(LuaHelper.FloatAction(function(arg_307_0)
					arg_303_1.dialogCg_.alpha = arg_307_0
				end))
				var_306_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_303_1.dialog_)
					var_306_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_303_1.duration_ = arg_303_1.duration_ + 0.3

				SetActive(arg_303_1.leftNameGo_, false)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_43 = arg_303_1:GetWordFromCfg(1109302074)
				local var_306_44 = arg_303_1:FormatText(var_306_43.content)

				arg_303_1.text_.text = var_306_44

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_45 = 16
				local var_306_46 = utf8.len(var_306_44)
				local var_306_47 = var_306_45 <= 0 and var_306_41 or var_306_41 * (var_306_46 / var_306_45)

				if var_306_47 > 0 and var_306_41 < var_306_47 then
					arg_303_1.talkMaxDuration = var_306_47
					var_306_40 = var_306_40 + 0.3

					if var_306_47 + var_306_40 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_47 + var_306_40
					end
				end

				arg_303_1.text_.text = var_306_44
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)
				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_48 = var_306_40 + 0.3
			local var_306_49 = math.max(var_306_41, arg_303_1.talkMaxDuration)

			if var_306_48 <= arg_303_1.time_ and arg_303_1.time_ < var_306_48 + var_306_49 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_48) / var_306_49

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_48 + var_306_49 and arg_303_1.time_ < var_306_48 + var_306_49 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_303_1:InitPlayNodeList()
	end,
	Play1109302075 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 1109302075
		arg_309_1.duration_ = 5

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play1109302076(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 0
			local var_312_1 = 0.925

			if var_312_0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_0 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				local var_312_2 = arg_309_1:FormatText(StoryNameCfg[7].name)

				arg_309_1.leftNameTxt_.text = var_312_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, true)
				arg_309_1.iconController_:SetSelectedState("hero")

				arg_309_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_309_1.callingController_:SetSelectedState("normal")

				arg_309_1.keyicon_.color = Color.New(1, 1, 1)
				arg_309_1.icon_.color = Color.New(1, 1, 1)

				local var_312_3 = arg_309_1:GetWordFromCfg(1109302075)
				local var_312_4 = arg_309_1:FormatText(var_312_3.content)

				arg_309_1.text_.text = var_312_4

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_5 = 36
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
				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_8 = math.max(var_312_1, arg_309_1.talkMaxDuration)

			if var_312_0 <= arg_309_1.time_ and arg_309_1.time_ < var_312_0 + var_312_8 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_0) / var_312_8

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_0 + var_312_8 and arg_309_1.time_ < var_312_0 + var_312_8 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play1109302076 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 1109302076
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play1109302077(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = 0
			local var_316_1 = 0.55

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

				local var_316_2 = arg_313_1:GetWordFromCfg(1109302076)
				local var_316_3 = arg_313_1:FormatText(var_316_2.content)

				arg_313_1.text_.text = var_316_3

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_4 = 22
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
	Play1109302077 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 1109302077
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play1109302078(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = 0
			local var_320_1 = 0.25

			if var_320_0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_0 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				local var_320_2 = arg_317_1:FormatText(StoryNameCfg[7].name)

				arg_317_1.leftNameTxt_.text = var_320_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, true)
				arg_317_1.iconController_:SetSelectedState("hero")

				arg_317_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_317_1.callingController_:SetSelectedState("normal")

				arg_317_1.keyicon_.color = Color.New(1, 1, 1)
				arg_317_1.icon_.color = Color.New(1, 1, 1)

				local var_320_3 = arg_317_1:GetWordFromCfg(1109302077)
				local var_320_4 = arg_317_1:FormatText(var_320_3.content)

				arg_317_1.text_.text = var_320_4

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_5 = 10
				local var_320_6 = utf8.len(var_320_4)
				local var_320_7 = var_320_5 <= 0 and var_320_1 or var_320_1 * (var_320_6 / var_320_5)

				if var_320_7 > 0 and var_320_1 < var_320_7 then
					arg_317_1.talkMaxDuration = var_320_7

					if var_320_7 + var_320_0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_7 + var_320_0
					end
				end

				arg_317_1.text_.text = var_320_4
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_8 = math.max(var_320_1, arg_317_1.talkMaxDuration)

			if var_320_0 <= arg_317_1.time_ and arg_317_1.time_ < var_320_0 + var_320_8 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_0) / var_320_8

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_0 + var_320_8 and arg_317_1.time_ < var_320_0 + var_320_8 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play1109302078 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 1109302078
		arg_321_1.duration_ = 5

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play1109302079(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = 0
			local var_324_1 = 1

			if var_324_0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_0 + arg_324_0 then
				local var_324_2 = "play"
				local var_324_3 = "effect"

				arg_321_1:AudioAction(var_324_2, var_324_3, "se_story_side_1093", "se_story_1093_message_calling", "")
			end

			local var_324_4 = 0
			local var_324_5 = 0.475

			if var_324_4 < arg_321_1.time_ and arg_321_1.time_ <= var_324_4 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, false)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_6 = arg_321_1:GetWordFromCfg(1109302078)
				local var_324_7 = arg_321_1:FormatText(var_324_6.content)

				arg_321_1.text_.text = var_324_7

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_8 = 18
				local var_324_9 = utf8.len(var_324_7)
				local var_324_10 = var_324_8 <= 0 and var_324_5 or var_324_5 * (var_324_9 / var_324_8)

				if var_324_10 > 0 and var_324_5 < var_324_10 then
					arg_321_1.talkMaxDuration = var_324_10

					if var_324_10 + var_324_4 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_10 + var_324_4
					end
				end

				arg_321_1.text_.text = var_324_7
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)
				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_11 = math.max(var_324_5, arg_321_1.talkMaxDuration)

			if var_324_4 <= arg_321_1.time_ and arg_321_1.time_ < var_324_4 + var_324_11 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_4) / var_324_11

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_4 + var_324_11 and arg_321_1.time_ < var_324_4 + var_324_11 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play1109302079 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 1109302079
		arg_325_1.duration_ = 5

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play1109302080(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = 0
			local var_328_1 = 0.225

			if var_328_0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_0 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				local var_328_2 = arg_325_1:FormatText(StoryNameCfg[7].name)

				arg_325_1.leftNameTxt_.text = var_328_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, true)
				arg_325_1.iconController_:SetSelectedState("hero")

				arg_325_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_325_1.callingController_:SetSelectedState("normal")

				arg_325_1.keyicon_.color = Color.New(1, 1, 1)
				arg_325_1.icon_.color = Color.New(1, 1, 1)

				local var_328_3 = arg_325_1:GetWordFromCfg(1109302079)
				local var_328_4 = arg_325_1:FormatText(var_328_3.content)

				arg_325_1.text_.text = var_328_4

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_5 = 9
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
				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_8 = math.max(var_328_1, arg_325_1.talkMaxDuration)

			if var_328_0 <= arg_325_1.time_ and arg_325_1.time_ < var_328_0 + var_328_8 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_0) / var_328_8

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_0 + var_328_8 and arg_325_1.time_ < var_328_0 + var_328_8 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play1109302080 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 1109302080
		arg_329_1.duration_ = 6.8

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play1109302081(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = 0
			local var_332_1 = 0.45

			if var_332_0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_0 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				local var_332_2 = arg_329_1:FormatText(StoryNameCfg[73].name)

				arg_329_1.leftNameTxt_.text = var_332_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, true)
				arg_329_1.iconController_:SetSelectedState("hero")

				arg_329_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1093")

				arg_329_1.callingController_:SetSelectedState("normal")

				arg_329_1.keyicon_.color = Color.New(1, 1, 1)
				arg_329_1.icon_.color = Color.New(1, 1, 1)

				local var_332_3 = arg_329_1:GetWordFromCfg(1109302080)
				local var_332_4 = arg_329_1:FormatText(var_332_3.content)

				arg_329_1.text_.text = var_332_4

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_5 = 18
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

				if manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302080", "story_v_side_new_1109302.awb") ~= 0 then
					local var_332_8 = manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302080", "story_v_side_new_1109302.awb") / 1000

					if var_332_8 + var_332_0 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_8 + var_332_0
					end

					if var_332_3.prefab_name ~= "" and arg_329_1.actors_[var_332_3.prefab_name] ~= nil then
						local var_332_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_3.prefab_name].transform, "story_v_side_new_1109302", "1109302080", "story_v_side_new_1109302.awb")

						arg_329_1:RecordAudio("1109302080", var_332_9)
						arg_329_1:RecordAudio("1109302080", var_332_9)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_side_new_1109302", "1109302080", "story_v_side_new_1109302.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_side_new_1109302", "1109302080", "story_v_side_new_1109302.awb")
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
	Play1109302081 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 1109302081
		arg_333_1.duration_ = 5

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play1109302082(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = 0
			local var_336_1 = 0.4

			if var_336_0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_0 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				local var_336_2 = arg_333_1:FormatText(StoryNameCfg[7].name)

				arg_333_1.leftNameTxt_.text = var_336_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, true)
				arg_333_1.iconController_:SetSelectedState("hero")

				arg_333_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_333_1.callingController_:SetSelectedState("normal")

				arg_333_1.keyicon_.color = Color.New(1, 1, 1)
				arg_333_1.icon_.color = Color.New(1, 1, 1)

				local var_336_3 = arg_333_1:GetWordFromCfg(1109302081)
				local var_336_4 = arg_333_1:FormatText(var_336_3.content)

				arg_333_1.text_.text = var_336_4

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_5 = 16
				local var_336_6 = utf8.len(var_336_4)
				local var_336_7 = var_336_5 <= 0 and var_336_1 or var_336_1 * (var_336_6 / var_336_5)

				if var_336_7 > 0 and var_336_1 < var_336_7 then
					arg_333_1.talkMaxDuration = var_336_7

					if var_336_7 + var_336_0 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_7 + var_336_0
					end
				end

				arg_333_1.text_.text = var_336_4
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)
				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_8 = math.max(var_336_1, arg_333_1.talkMaxDuration)

			if var_336_0 <= arg_333_1.time_ and arg_333_1.time_ < var_336_0 + var_336_8 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_0) / var_336_8

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_0 + var_336_8 and arg_333_1.time_ < var_336_0 + var_336_8 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play1109302082 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 1109302082
		arg_337_1.duration_ = 8.13

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play1109302083(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = 0
			local var_340_1 = 0.8

			if var_340_0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_0 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				local var_340_2 = arg_337_1:FormatText(StoryNameCfg[73].name)

				arg_337_1.leftNameTxt_.text = var_340_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, true)
				arg_337_1.iconController_:SetSelectedState("hero")

				arg_337_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1093")

				arg_337_1.callingController_:SetSelectedState("normal")

				arg_337_1.keyicon_.color = Color.New(1, 1, 1)
				arg_337_1.icon_.color = Color.New(1, 1, 1)

				local var_340_3 = arg_337_1:GetWordFromCfg(1109302082)
				local var_340_4 = arg_337_1:FormatText(var_340_3.content)

				arg_337_1.text_.text = var_340_4

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_5 = 32
				local var_340_6 = utf8.len(var_340_4)
				local var_340_7 = var_340_5 <= 0 and var_340_1 or var_340_1 * (var_340_6 / var_340_5)

				if var_340_7 > 0 and var_340_1 < var_340_7 then
					arg_337_1.talkMaxDuration = var_340_7

					if var_340_7 + var_340_0 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_7 + var_340_0
					end
				end

				arg_337_1.text_.text = var_340_4
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302082", "story_v_side_new_1109302.awb") ~= 0 then
					local var_340_8 = manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302082", "story_v_side_new_1109302.awb") / 1000

					if var_340_8 + var_340_0 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_8 + var_340_0
					end

					if var_340_3.prefab_name ~= "" and arg_337_1.actors_[var_340_3.prefab_name] ~= nil then
						local var_340_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_3.prefab_name].transform, "story_v_side_new_1109302", "1109302082", "story_v_side_new_1109302.awb")

						arg_337_1:RecordAudio("1109302082", var_340_9)
						arg_337_1:RecordAudio("1109302082", var_340_9)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_side_new_1109302", "1109302082", "story_v_side_new_1109302.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_side_new_1109302", "1109302082", "story_v_side_new_1109302.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_10 = math.max(var_340_1, arg_337_1.talkMaxDuration)

			if var_340_0 <= arg_337_1.time_ and arg_337_1.time_ < var_340_0 + var_340_10 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_0) / var_340_10

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_0 + var_340_10 and arg_337_1.time_ < var_340_0 + var_340_10 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play1109302083 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 1109302083
		arg_341_1.duration_ = 5

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play1109302084(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = 0
			local var_344_1 = 0.05

			if var_344_0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_0 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				local var_344_2 = arg_341_1:FormatText(StoryNameCfg[7].name)

				arg_341_1.leftNameTxt_.text = var_344_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, true)
				arg_341_1.iconController_:SetSelectedState("hero")

				arg_341_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_341_1.callingController_:SetSelectedState("normal")

				arg_341_1.keyicon_.color = Color.New(1, 1, 1)
				arg_341_1.icon_.color = Color.New(1, 1, 1)

				local var_344_3 = arg_341_1:GetWordFromCfg(1109302083)
				local var_344_4 = arg_341_1:FormatText(var_344_3.content)

				arg_341_1.text_.text = var_344_4

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_5 = 2
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
				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_8 = math.max(var_344_1, arg_341_1.talkMaxDuration)

			if var_344_0 <= arg_341_1.time_ and arg_341_1.time_ < var_344_0 + var_344_8 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_0) / var_344_8

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_0 + var_344_8 and arg_341_1.time_ < var_344_0 + var_344_8 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play1109302084 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 1109302084
		arg_345_1.duration_ = 0.02

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"

			SetActive(arg_345_1.choicesGo_, true)

			for iter_346_0, iter_346_1 in ipairs(arg_345_1.choices_) do
				local var_346_0 = iter_346_0 <= 2

				SetActive(iter_346_1.go, var_346_0)
			end

			arg_345_1.choices_[1].txt.text = arg_345_1:FormatText(StoryChoiceCfg[346].name)
			arg_345_1.choices_[2].txt.text = arg_345_1:FormatText(StoryChoiceCfg[347].name)
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play1109302085(arg_345_1)
			end

			if arg_347_0 == 2 then
				arg_345_0:Play1109302088(arg_345_1)
			end

			arg_345_1:RecordChoiceLog(1109302084, 346, 347)
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			return
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play1109302085 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 1109302085
		arg_349_1.duration_ = 5.7

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play1109302086(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = 0
			local var_352_1 = 0.375

			if var_352_0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_0 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				local var_352_2 = arg_349_1:FormatText(StoryNameCfg[73].name)

				arg_349_1.leftNameTxt_.text = var_352_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, true)
				arg_349_1.iconController_:SetSelectedState("hero")

				arg_349_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1093")

				arg_349_1.callingController_:SetSelectedState("normal")

				arg_349_1.keyicon_.color = Color.New(1, 1, 1)
				arg_349_1.icon_.color = Color.New(1, 1, 1)

				local var_352_3 = arg_349_1:GetWordFromCfg(1109302085)
				local var_352_4 = arg_349_1:FormatText(var_352_3.content)

				arg_349_1.text_.text = var_352_4

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_5 = 15
				local var_352_6 = utf8.len(var_352_4)
				local var_352_7 = var_352_5 <= 0 and var_352_1 or var_352_1 * (var_352_6 / var_352_5)

				if var_352_7 > 0 and var_352_1 < var_352_7 then
					arg_349_1.talkMaxDuration = var_352_7

					if var_352_7 + var_352_0 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_7 + var_352_0
					end
				end

				arg_349_1.text_.text = var_352_4
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302085", "story_v_side_new_1109302.awb") ~= 0 then
					local var_352_8 = manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302085", "story_v_side_new_1109302.awb") / 1000

					if var_352_8 + var_352_0 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_8 + var_352_0
					end

					if var_352_3.prefab_name ~= "" and arg_349_1.actors_[var_352_3.prefab_name] ~= nil then
						local var_352_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_3.prefab_name].transform, "story_v_side_new_1109302", "1109302085", "story_v_side_new_1109302.awb")

						arg_349_1:RecordAudio("1109302085", var_352_9)
						arg_349_1:RecordAudio("1109302085", var_352_9)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_side_new_1109302", "1109302085", "story_v_side_new_1109302.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_side_new_1109302", "1109302085", "story_v_side_new_1109302.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_10 = math.max(var_352_1, arg_349_1.talkMaxDuration)

			if var_352_0 <= arg_349_1.time_ and arg_349_1.time_ < var_352_0 + var_352_10 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_0) / var_352_10

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_0 + var_352_10 and arg_349_1.time_ < var_352_0 + var_352_10 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play1109302086 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 1109302086
		arg_353_1.duration_ = 5

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play1109302087(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = 0
			local var_356_1 = 0.425

			if var_356_0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_0 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				local var_356_2 = arg_353_1:FormatText(StoryNameCfg[7].name)

				arg_353_1.leftNameTxt_.text = var_356_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, true)
				arg_353_1.iconController_:SetSelectedState("hero")

				arg_353_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_353_1.callingController_:SetSelectedState("normal")

				arg_353_1.keyicon_.color = Color.New(1, 1, 1)
				arg_353_1.icon_.color = Color.New(1, 1, 1)

				local var_356_3 = arg_353_1:GetWordFromCfg(1109302086)
				local var_356_4 = arg_353_1:FormatText(var_356_3.content)

				arg_353_1.text_.text = var_356_4

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_5 = 17
				local var_356_6 = utf8.len(var_356_4)
				local var_356_7 = var_356_5 <= 0 and var_356_1 or var_356_1 * (var_356_6 / var_356_5)

				if var_356_7 > 0 and var_356_1 < var_356_7 then
					arg_353_1.talkMaxDuration = var_356_7

					if var_356_7 + var_356_0 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_7 + var_356_0
					end
				end

				arg_353_1.text_.text = var_356_4
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)
				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_8 = math.max(var_356_1, arg_353_1.talkMaxDuration)

			if var_356_0 <= arg_353_1.time_ and arg_353_1.time_ < var_356_0 + var_356_8 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_0) / var_356_8

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_0 + var_356_8 and arg_353_1.time_ < var_356_0 + var_356_8 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play1109302087 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 1109302087
		arg_357_1.duration_ = 8.17

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play1109302091(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			local var_360_0 = 0
			local var_360_1 = 0.65

			if var_360_0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_0 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				local var_360_2 = arg_357_1:FormatText(StoryNameCfg[73].name)

				arg_357_1.leftNameTxt_.text = var_360_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, true)
				arg_357_1.iconController_:SetSelectedState("hero")

				arg_357_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1093")

				arg_357_1.callingController_:SetSelectedState("normal")

				arg_357_1.keyicon_.color = Color.New(1, 1, 1)
				arg_357_1.icon_.color = Color.New(1, 1, 1)

				local var_360_3 = arg_357_1:GetWordFromCfg(1109302087)
				local var_360_4 = arg_357_1:FormatText(var_360_3.content)

				arg_357_1.text_.text = var_360_4

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_5 = 26
				local var_360_6 = utf8.len(var_360_4)
				local var_360_7 = var_360_5 <= 0 and var_360_1 or var_360_1 * (var_360_6 / var_360_5)

				if var_360_7 > 0 and var_360_1 < var_360_7 then
					arg_357_1.talkMaxDuration = var_360_7

					if var_360_7 + var_360_0 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_7 + var_360_0
					end
				end

				arg_357_1.text_.text = var_360_4
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302087", "story_v_side_new_1109302.awb") ~= 0 then
					local var_360_8 = manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302087", "story_v_side_new_1109302.awb") / 1000

					if var_360_8 + var_360_0 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_8 + var_360_0
					end

					if var_360_3.prefab_name ~= "" and arg_357_1.actors_[var_360_3.prefab_name] ~= nil then
						local var_360_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_357_1.actors_[var_360_3.prefab_name].transform, "story_v_side_new_1109302", "1109302087", "story_v_side_new_1109302.awb")

						arg_357_1:RecordAudio("1109302087", var_360_9)
						arg_357_1:RecordAudio("1109302087", var_360_9)
					else
						arg_357_1:AudioAction("play", "voice", "story_v_side_new_1109302", "1109302087", "story_v_side_new_1109302.awb")
					end

					arg_357_1:RecordHistoryTalkVoice("story_v_side_new_1109302", "1109302087", "story_v_side_new_1109302.awb")
				end

				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_10 = math.max(var_360_1, arg_357_1.talkMaxDuration)

			if var_360_0 <= arg_357_1.time_ and arg_357_1.time_ < var_360_0 + var_360_10 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_0) / var_360_10

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_0 + var_360_10 and arg_357_1.time_ < var_360_0 + var_360_10 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play1109302091 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 1109302091
		arg_361_1.duration_ = 6.03

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play1109302092(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = 0
			local var_364_1 = 0.3

			if var_364_0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_0 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				local var_364_2 = arg_361_1:FormatText(StoryNameCfg[73].name)

				arg_361_1.leftNameTxt_.text = var_364_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, true)
				arg_361_1.iconController_:SetSelectedState("hero")

				arg_361_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1093")

				arg_361_1.callingController_:SetSelectedState("normal")

				arg_361_1.keyicon_.color = Color.New(1, 1, 1)
				arg_361_1.icon_.color = Color.New(1, 1, 1)

				local var_364_3 = arg_361_1:GetWordFromCfg(1109302091)
				local var_364_4 = arg_361_1:FormatText(var_364_3.content)

				arg_361_1.text_.text = var_364_4

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_5 = 12
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

				if manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302091", "story_v_side_new_1109302.awb") ~= 0 then
					local var_364_8 = manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302091", "story_v_side_new_1109302.awb") / 1000

					if var_364_8 + var_364_0 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_8 + var_364_0
					end

					if var_364_3.prefab_name ~= "" and arg_361_1.actors_[var_364_3.prefab_name] ~= nil then
						local var_364_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_361_1.actors_[var_364_3.prefab_name].transform, "story_v_side_new_1109302", "1109302091", "story_v_side_new_1109302.awb")

						arg_361_1:RecordAudio("1109302091", var_364_9)
						arg_361_1:RecordAudio("1109302091", var_364_9)
					else
						arg_361_1:AudioAction("play", "voice", "story_v_side_new_1109302", "1109302091", "story_v_side_new_1109302.awb")
					end

					arg_361_1:RecordHistoryTalkVoice("story_v_side_new_1109302", "1109302091", "story_v_side_new_1109302.awb")
				end

				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_10 = math.max(var_364_1, arg_361_1.talkMaxDuration)

			if var_364_0 <= arg_361_1.time_ and arg_361_1.time_ < var_364_0 + var_364_10 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_0) / var_364_10

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_0 + var_364_10 and arg_361_1.time_ < var_364_0 + var_364_10 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play1109302092 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 1109302092
		arg_365_1.duration_ = 5.6

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play1109302093(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = 0
			local var_368_1 = 0.725

			if var_368_0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_0 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				local var_368_2 = arg_365_1:FormatText(StoryNameCfg[73].name)

				arg_365_1.leftNameTxt_.text = var_368_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, true)
				arg_365_1.iconController_:SetSelectedState("hero")

				arg_365_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1093")

				arg_365_1.callingController_:SetSelectedState("normal")

				arg_365_1.keyicon_.color = Color.New(1, 1, 1)
				arg_365_1.icon_.color = Color.New(1, 1, 1)

				local var_368_3 = arg_365_1:GetWordFromCfg(1109302092)
				local var_368_4 = arg_365_1:FormatText(var_368_3.content)

				arg_365_1.text_.text = var_368_4

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_5 = 29
				local var_368_6 = utf8.len(var_368_4)
				local var_368_7 = var_368_5 <= 0 and var_368_1 or var_368_1 * (var_368_6 / var_368_5)

				if var_368_7 > 0 and var_368_1 < var_368_7 then
					arg_365_1.talkMaxDuration = var_368_7

					if var_368_7 + var_368_0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_7 + var_368_0
					end
				end

				arg_365_1.text_.text = var_368_4
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302092", "story_v_side_new_1109302.awb") ~= 0 then
					local var_368_8 = manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302092", "story_v_side_new_1109302.awb") / 1000

					if var_368_8 + var_368_0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_8 + var_368_0
					end

					if var_368_3.prefab_name ~= "" and arg_365_1.actors_[var_368_3.prefab_name] ~= nil then
						local var_368_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_3.prefab_name].transform, "story_v_side_new_1109302", "1109302092", "story_v_side_new_1109302.awb")

						arg_365_1:RecordAudio("1109302092", var_368_9)
						arg_365_1:RecordAudio("1109302092", var_368_9)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_side_new_1109302", "1109302092", "story_v_side_new_1109302.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_side_new_1109302", "1109302092", "story_v_side_new_1109302.awb")
				end

				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_10 = math.max(var_368_1, arg_365_1.talkMaxDuration)

			if var_368_0 <= arg_365_1.time_ and arg_365_1.time_ < var_368_0 + var_368_10 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_0) / var_368_10

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_0 + var_368_10 and arg_365_1.time_ < var_368_0 + var_368_10 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play1109302093 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 1109302093
		arg_369_1.duration_ = 5

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play1109302094(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = 0
			local var_372_1 = 0.15

			if var_372_0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_0 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				local var_372_2 = arg_369_1:FormatText(StoryNameCfg[7].name)

				arg_369_1.leftNameTxt_.text = var_372_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, true)
				arg_369_1.iconController_:SetSelectedState("hero")

				arg_369_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_369_1.callingController_:SetSelectedState("normal")

				arg_369_1.keyicon_.color = Color.New(1, 1, 1)
				arg_369_1.icon_.color = Color.New(1, 1, 1)

				local var_372_3 = arg_369_1:GetWordFromCfg(1109302093)
				local var_372_4 = arg_369_1:FormatText(var_372_3.content)

				arg_369_1.text_.text = var_372_4

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_5 = 6
				local var_372_6 = utf8.len(var_372_4)
				local var_372_7 = var_372_5 <= 0 and var_372_1 or var_372_1 * (var_372_6 / var_372_5)

				if var_372_7 > 0 and var_372_1 < var_372_7 then
					arg_369_1.talkMaxDuration = var_372_7

					if var_372_7 + var_372_0 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_7 + var_372_0
					end
				end

				arg_369_1.text_.text = var_372_4
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)
				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_8 = math.max(var_372_1, arg_369_1.talkMaxDuration)

			if var_372_0 <= arg_369_1.time_ and arg_369_1.time_ < var_372_0 + var_372_8 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_0) / var_372_8

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_0 + var_372_8 and arg_369_1.time_ < var_372_0 + var_372_8 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play1109302094 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 1109302094
		arg_373_1.duration_ = 7.87

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play1109302095(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			local var_376_0 = 0
			local var_376_1 = 0.65

			if var_376_0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_0 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				local var_376_2 = arg_373_1:FormatText(StoryNameCfg[73].name)

				arg_373_1.leftNameTxt_.text = var_376_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, true)
				arg_373_1.iconController_:SetSelectedState("hero")

				arg_373_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1093")

				arg_373_1.callingController_:SetSelectedState("normal")

				arg_373_1.keyicon_.color = Color.New(1, 1, 1)
				arg_373_1.icon_.color = Color.New(1, 1, 1)

				local var_376_3 = arg_373_1:GetWordFromCfg(1109302094)
				local var_376_4 = arg_373_1:FormatText(var_376_3.content)

				arg_373_1.text_.text = var_376_4

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_5 = 26
				local var_376_6 = utf8.len(var_376_4)
				local var_376_7 = var_376_5 <= 0 and var_376_1 or var_376_1 * (var_376_6 / var_376_5)

				if var_376_7 > 0 and var_376_1 < var_376_7 then
					arg_373_1.talkMaxDuration = var_376_7

					if var_376_7 + var_376_0 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_7 + var_376_0
					end
				end

				arg_373_1.text_.text = var_376_4
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302094", "story_v_side_new_1109302.awb") ~= 0 then
					local var_376_8 = manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302094", "story_v_side_new_1109302.awb") / 1000

					if var_376_8 + var_376_0 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_8 + var_376_0
					end

					if var_376_3.prefab_name ~= "" and arg_373_1.actors_[var_376_3.prefab_name] ~= nil then
						local var_376_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_373_1.actors_[var_376_3.prefab_name].transform, "story_v_side_new_1109302", "1109302094", "story_v_side_new_1109302.awb")

						arg_373_1:RecordAudio("1109302094", var_376_9)
						arg_373_1:RecordAudio("1109302094", var_376_9)
					else
						arg_373_1:AudioAction("play", "voice", "story_v_side_new_1109302", "1109302094", "story_v_side_new_1109302.awb")
					end

					arg_373_1:RecordHistoryTalkVoice("story_v_side_new_1109302", "1109302094", "story_v_side_new_1109302.awb")
				end

				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_10 = math.max(var_376_1, arg_373_1.talkMaxDuration)

			if var_376_0 <= arg_373_1.time_ and arg_373_1.time_ < var_376_0 + var_376_10 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_0) / var_376_10

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_0 + var_376_10 and arg_373_1.time_ < var_376_0 + var_376_10 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {}

		arg_373_1:InitPlayNodeList()
	end,
	Play1109302095 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 1109302095
		arg_377_1.duration_ = 2.3

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play1109302096(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = 0
			local var_380_1 = 0.2

			if var_380_0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_0 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				local var_380_2 = arg_377_1:FormatText(StoryNameCfg[73].name)

				arg_377_1.leftNameTxt_.text = var_380_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, true)
				arg_377_1.iconController_:SetSelectedState("hero")

				arg_377_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1093")

				arg_377_1.callingController_:SetSelectedState("normal")

				arg_377_1.keyicon_.color = Color.New(1, 1, 1)
				arg_377_1.icon_.color = Color.New(1, 1, 1)

				local var_380_3 = arg_377_1:GetWordFromCfg(1109302095)
				local var_380_4 = arg_377_1:FormatText(var_380_3.content)

				arg_377_1.text_.text = var_380_4

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_5 = 8
				local var_380_6 = utf8.len(var_380_4)
				local var_380_7 = var_380_5 <= 0 and var_380_1 or var_380_1 * (var_380_6 / var_380_5)

				if var_380_7 > 0 and var_380_1 < var_380_7 then
					arg_377_1.talkMaxDuration = var_380_7

					if var_380_7 + var_380_0 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_7 + var_380_0
					end
				end

				arg_377_1.text_.text = var_380_4
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302095", "story_v_side_new_1109302.awb") ~= 0 then
					local var_380_8 = manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302095", "story_v_side_new_1109302.awb") / 1000

					if var_380_8 + var_380_0 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_8 + var_380_0
					end

					if var_380_3.prefab_name ~= "" and arg_377_1.actors_[var_380_3.prefab_name] ~= nil then
						local var_380_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_3.prefab_name].transform, "story_v_side_new_1109302", "1109302095", "story_v_side_new_1109302.awb")

						arg_377_1:RecordAudio("1109302095", var_380_9)
						arg_377_1:RecordAudio("1109302095", var_380_9)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_side_new_1109302", "1109302095", "story_v_side_new_1109302.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_side_new_1109302", "1109302095", "story_v_side_new_1109302.awb")
				end

				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_10 = math.max(var_380_1, arg_377_1.talkMaxDuration)

			if var_380_0 <= arg_377_1.time_ and arg_377_1.time_ < var_380_0 + var_380_10 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_0) / var_380_10

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_0 + var_380_10 and arg_377_1.time_ < var_380_0 + var_380_10 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {}

		arg_377_1:InitPlayNodeList()
	end,
	Play1109302096 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 1109302096
		arg_381_1.duration_ = 5

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play1109302097(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			local var_384_0 = 0
			local var_384_1 = 0.05

			if var_384_0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_0 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, false)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_2 = arg_381_1:GetWordFromCfg(1109302096)
				local var_384_3 = arg_381_1:FormatText(var_384_2.content)

				arg_381_1.text_.text = var_384_3

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_4 = 2
				local var_384_5 = utf8.len(var_384_3)
				local var_384_6 = var_384_4 <= 0 and var_384_1 or var_384_1 * (var_384_5 / var_384_4)

				if var_384_6 > 0 and var_384_1 < var_384_6 then
					arg_381_1.talkMaxDuration = var_384_6

					if var_384_6 + var_384_0 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_6 + var_384_0
					end
				end

				arg_381_1.text_.text = var_384_3
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)
				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_7 = math.max(var_384_1, arg_381_1.talkMaxDuration)

			if var_384_0 <= arg_381_1.time_ and arg_381_1.time_ < var_384_0 + var_384_7 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_0) / var_384_7

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_0 + var_384_7 and arg_381_1.time_ < var_384_0 + var_384_7 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {}

		arg_381_1:InitPlayNodeList()
	end,
	Play1109302097 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 1109302097
		arg_385_1.duration_ = 5

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play1109302098(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			local var_388_0 = 0
			local var_388_1 = 1.45

			if var_388_0 < arg_385_1.time_ and arg_385_1.time_ <= var_388_0 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, false)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_2 = arg_385_1:GetWordFromCfg(1109302097)
				local var_388_3 = arg_385_1:FormatText(var_388_2.content)

				arg_385_1.text_.text = var_388_3

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_4 = 57
				local var_388_5 = utf8.len(var_388_3)
				local var_388_6 = var_388_4 <= 0 and var_388_1 or var_388_1 * (var_388_5 / var_388_4)

				if var_388_6 > 0 and var_388_1 < var_388_6 then
					arg_385_1.talkMaxDuration = var_388_6

					if var_388_6 + var_388_0 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_6 + var_388_0
					end
				end

				arg_385_1.text_.text = var_388_3
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)
				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_7 = math.max(var_388_1, arg_385_1.talkMaxDuration)

			if var_388_0 <= arg_385_1.time_ and arg_385_1.time_ < var_388_0 + var_388_7 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_0) / var_388_7

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_0 + var_388_7 and arg_385_1.time_ < var_388_0 + var_388_7 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	Play1109302098 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 1109302098
		arg_389_1.duration_ = 5

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play1109302099(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			local var_392_0 = 0
			local var_392_1 = 0.525

			if var_392_0 < arg_389_1.time_ and arg_389_1.time_ <= var_392_0 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				local var_392_2 = arg_389_1:FormatText(StoryNameCfg[7].name)

				arg_389_1.leftNameTxt_.text = var_392_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, true)
				arg_389_1.iconController_:SetSelectedState("hero")

				arg_389_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_389_1.callingController_:SetSelectedState("normal")

				arg_389_1.keyicon_.color = Color.New(1, 1, 1)
				arg_389_1.icon_.color = Color.New(1, 1, 1)

				local var_392_3 = arg_389_1:GetWordFromCfg(1109302098)
				local var_392_4 = arg_389_1:FormatText(var_392_3.content)

				arg_389_1.text_.text = var_392_4

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_5 = 21
				local var_392_6 = utf8.len(var_392_4)
				local var_392_7 = var_392_5 <= 0 and var_392_1 or var_392_1 * (var_392_6 / var_392_5)

				if var_392_7 > 0 and var_392_1 < var_392_7 then
					arg_389_1.talkMaxDuration = var_392_7

					if var_392_7 + var_392_0 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_7 + var_392_0
					end
				end

				arg_389_1.text_.text = var_392_4
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)
				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_8 = math.max(var_392_1, arg_389_1.talkMaxDuration)

			if var_392_0 <= arg_389_1.time_ and arg_389_1.time_ < var_392_0 + var_392_8 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_0) / var_392_8

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_0 + var_392_8 and arg_389_1.time_ < var_392_0 + var_392_8 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {}

		arg_389_1:InitPlayNodeList()
	end,
	Play1109302099 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 1109302099
		arg_393_1.duration_ = 6.07

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play1109302100(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = arg_393_1.actors_["1050ui_story"].transform
			local var_396_1 = 0

			if var_396_1 < arg_393_1.time_ and arg_393_1.time_ <= var_396_1 + arg_396_0 then
				arg_393_1.var_.moveOldPos1050ui_story = var_396_0.localPosition
			end

			local var_396_2 = 0.001

			if var_396_1 <= arg_393_1.time_ and arg_393_1.time_ < var_396_1 + var_396_2 then
				local var_396_3 = (arg_393_1.time_ - var_396_1) / var_396_2
				local var_396_4 = Vector3.New(0, -1, -6.1)

				var_396_0.localPosition = Vector3.Lerp(arg_393_1.var_.moveOldPos1050ui_story, var_396_4, var_396_3)

				local var_396_5 = manager.ui.mainCamera.transform.position - var_396_0.position

				var_396_0.forward = Vector3.New(var_396_5.x, var_396_5.y, var_396_5.z)

				local var_396_6 = var_396_0.localEulerAngles

				var_396_6.z = 0
				var_396_6.x = 0
				var_396_0.localEulerAngles = var_396_6
			end

			if arg_393_1.time_ >= var_396_1 + var_396_2 and arg_393_1.time_ < var_396_1 + var_396_2 + arg_396_0 then
				var_396_0.localPosition = Vector3.New(0, -1, -6.1)

				local var_396_7 = manager.ui.mainCamera.transform.position - var_396_0.position

				var_396_0.forward = Vector3.New(var_396_7.x, var_396_7.y, var_396_7.z)

				local var_396_8 = var_396_0.localEulerAngles

				var_396_8.z = 0
				var_396_8.x = 0
				var_396_0.localEulerAngles = var_396_8
			end

			local var_396_9 = 0

			if var_396_9 < arg_393_1.time_ and arg_393_1.time_ <= var_396_9 + arg_396_0 then
				arg_393_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action2_1")
			end

			local var_396_10 = 0

			if var_396_10 < arg_393_1.time_ and arg_393_1.time_ <= var_396_10 + arg_396_0 then
				arg_393_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_396_11 = arg_393_1.actors_["1050ui_story"]
			local var_396_12 = 0

			if var_396_12 < arg_393_1.time_ and arg_393_1.time_ <= var_396_12 + arg_396_0 and not isNil(var_396_11) and arg_393_1.var_.characterEffect1050ui_story == nil then
				arg_393_1.var_.characterEffect1050ui_story = var_396_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_396_13 = 0.2

			if var_396_12 <= arg_393_1.time_ and arg_393_1.time_ < var_396_12 + var_396_13 and not isNil(var_396_11) then
				local var_396_14 = (arg_393_1.time_ - var_396_12) / var_396_13

				if arg_393_1.var_.characterEffect1050ui_story and not isNil(var_396_11) then
					arg_393_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_393_1.time_ >= var_396_12 + var_396_13 and arg_393_1.time_ < var_396_12 + var_396_13 + arg_396_0 and not isNil(var_396_11) and arg_393_1.var_.characterEffect1050ui_story then
				arg_393_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_396_15 = 0
			local var_396_16 = 0.5

			if var_396_15 < arg_393_1.time_ and arg_393_1.time_ <= var_396_15 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				local var_396_17 = arg_393_1:FormatText(StoryNameCfg[74].name)

				arg_393_1.leftNameTxt_.text = var_396_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_18 = arg_393_1:GetWordFromCfg(1109302099)
				local var_396_19 = arg_393_1:FormatText(var_396_18.content)

				arg_393_1.text_.text = var_396_19

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_20 = 20
				local var_396_21 = utf8.len(var_396_19)
				local var_396_22 = var_396_20 <= 0 and var_396_16 or var_396_16 * (var_396_21 / var_396_20)

				if var_396_22 > 0 and var_396_16 < var_396_22 then
					arg_393_1.talkMaxDuration = var_396_22

					if var_396_22 + var_396_15 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_22 + var_396_15
					end
				end

				arg_393_1.text_.text = var_396_19
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302099", "story_v_side_new_1109302.awb") ~= 0 then
					local var_396_23 = manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302099", "story_v_side_new_1109302.awb") / 1000

					if var_396_23 + var_396_15 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_23 + var_396_15
					end

					if var_396_18.prefab_name ~= "" and arg_393_1.actors_[var_396_18.prefab_name] ~= nil then
						local var_396_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_393_1.actors_[var_396_18.prefab_name].transform, "story_v_side_new_1109302", "1109302099", "story_v_side_new_1109302.awb")

						arg_393_1:RecordAudio("1109302099", var_396_24)
						arg_393_1:RecordAudio("1109302099", var_396_24)
					else
						arg_393_1:AudioAction("play", "voice", "story_v_side_new_1109302", "1109302099", "story_v_side_new_1109302.awb")
					end

					arg_393_1:RecordHistoryTalkVoice("story_v_side_new_1109302", "1109302099", "story_v_side_new_1109302.awb")
				end

				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_25 = math.max(var_396_16, arg_393_1.talkMaxDuration)

			if var_396_15 <= arg_393_1.time_ and arg_393_1.time_ < var_396_15 + var_396_25 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_15) / var_396_25

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_15 + var_396_25 and arg_393_1.time_ < var_396_15 + var_396_25 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_393_1:InitPlayNodeList()
	end,
	Play1109302100 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 1109302100
		arg_397_1.duration_ = 5

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play1109302101(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = arg_397_1.actors_["1050ui_story"]
			local var_400_1 = 0

			if var_400_1 < arg_397_1.time_ and arg_397_1.time_ <= var_400_1 + arg_400_0 and not isNil(var_400_0) and arg_397_1.var_.characterEffect1050ui_story == nil then
				arg_397_1.var_.characterEffect1050ui_story = var_400_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_400_2 = 0.2

			if var_400_1 <= arg_397_1.time_ and arg_397_1.time_ < var_400_1 + var_400_2 and not isNil(var_400_0) then
				local var_400_3 = (arg_397_1.time_ - var_400_1) / var_400_2

				if arg_397_1.var_.characterEffect1050ui_story and not isNil(var_400_0) then
					local var_400_4 = Mathf.Lerp(0, 0.5, var_400_3)

					arg_397_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_397_1.var_.characterEffect1050ui_story.fillRatio = var_400_4
				end
			end

			if arg_397_1.time_ >= var_400_1 + var_400_2 and arg_397_1.time_ < var_400_1 + var_400_2 + arg_400_0 and not isNil(var_400_0) and arg_397_1.var_.characterEffect1050ui_story then
				local var_400_5 = 0.5

				arg_397_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_397_1.var_.characterEffect1050ui_story.fillRatio = var_400_5
			end

			local var_400_6 = 0
			local var_400_7 = 0.425

			if var_400_6 < arg_397_1.time_ and arg_397_1.time_ <= var_400_6 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				local var_400_8 = arg_397_1:FormatText(StoryNameCfg[7].name)

				arg_397_1.leftNameTxt_.text = var_400_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, true)
				arg_397_1.iconController_:SetSelectedState("hero")

				arg_397_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_397_1.callingController_:SetSelectedState("normal")

				arg_397_1.keyicon_.color = Color.New(1, 1, 1)
				arg_397_1.icon_.color = Color.New(1, 1, 1)

				local var_400_9 = arg_397_1:GetWordFromCfg(1109302100)
				local var_400_10 = arg_397_1:FormatText(var_400_9.content)

				arg_397_1.text_.text = var_400_10

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_11 = 17
				local var_400_12 = utf8.len(var_400_10)
				local var_400_13 = var_400_11 <= 0 and var_400_7 or var_400_7 * (var_400_12 / var_400_11)

				if var_400_13 > 0 and var_400_7 < var_400_13 then
					arg_397_1.talkMaxDuration = var_400_13

					if var_400_13 + var_400_6 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_13 + var_400_6
					end
				end

				arg_397_1.text_.text = var_400_10
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)
				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_14 = math.max(var_400_7, arg_397_1.talkMaxDuration)

			if var_400_6 <= arg_397_1.time_ and arg_397_1.time_ < var_400_6 + var_400_14 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_6) / var_400_14

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_6 + var_400_14 and arg_397_1.time_ < var_400_6 + var_400_14 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play1109302101 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 1109302101
		arg_401_1.duration_ = 7

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play1109302102(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = 2

			if var_404_0 < arg_401_1.time_ and arg_401_1.time_ <= var_404_0 + arg_404_0 then
				local var_404_1 = manager.ui.mainCamera.transform.localPosition
				local var_404_2 = Vector3.New(0, 0, 10) + Vector3.New(var_404_1.x, var_404_1.y, 0)
				local var_404_3 = arg_401_1.bgs_.STblack

				var_404_3.transform.localPosition = var_404_2
				var_404_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_404_4 = var_404_3:GetComponent("SpriteRenderer")

				if var_404_4 and var_404_4.sprite then
					local var_404_5 = (var_404_3.transform.localPosition - var_404_1).z
					local var_404_6 = manager.ui.mainCameraCom_
					local var_404_7 = 2 * var_404_5 * Mathf.Tan(var_404_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_404_8 = var_404_7 * var_404_6.aspect
					local var_404_9 = var_404_4.sprite.bounds.size.x
					local var_404_10 = var_404_4.sprite.bounds.size.y
					local var_404_11 = var_404_8 / var_404_9
					local var_404_12 = var_404_7 / var_404_10
					local var_404_13 = var_404_12 < var_404_11 and var_404_11 or var_404_12

					var_404_3.transform.localScale = Vector3.New(var_404_13, var_404_13, 0)
				end

				for iter_404_0, iter_404_1 in pairs(arg_401_1.bgs_) do
					if iter_404_0 ~= "STblack" then
						iter_404_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_404_14 = 0

			if var_404_14 < arg_401_1.time_ and arg_401_1.time_ <= var_404_14 + arg_404_0 then
				arg_401_1.mask_.enabled = true
				arg_401_1.mask_.raycastTarget = true

				arg_401_1:SetGaussion(false)
			end

			local var_404_15 = 2

			if var_404_14 <= arg_401_1.time_ and arg_401_1.time_ < var_404_14 + var_404_15 then
				local var_404_16 = (arg_401_1.time_ - var_404_14) / var_404_15
				local var_404_17 = Color.New(0, 0, 0)

				var_404_17.a = Mathf.Lerp(0, 1, var_404_16)
				arg_401_1.mask_.color = var_404_17
			end

			if arg_401_1.time_ >= var_404_14 + var_404_15 and arg_401_1.time_ < var_404_14 + var_404_15 + arg_404_0 then
				local var_404_18 = Color.New(0, 0, 0)

				var_404_18.a = 1
				arg_401_1.mask_.color = var_404_18
			end

			local var_404_19 = 2

			if var_404_19 < arg_401_1.time_ and arg_401_1.time_ <= var_404_19 + arg_404_0 then
				arg_401_1.mask_.enabled = true
				arg_401_1.mask_.raycastTarget = true

				arg_401_1:SetGaussion(false)
			end

			local var_404_20 = 2

			if var_404_19 <= arg_401_1.time_ and arg_401_1.time_ < var_404_19 + var_404_20 then
				local var_404_21 = (arg_401_1.time_ - var_404_19) / var_404_20
				local var_404_22 = Color.New(0, 0, 0)

				var_404_22.a = Mathf.Lerp(1, 0, var_404_21)
				arg_401_1.mask_.color = var_404_22
			end

			if arg_401_1.time_ >= var_404_19 + var_404_20 and arg_401_1.time_ < var_404_19 + var_404_20 + arg_404_0 then
				local var_404_23 = Color.New(0, 0, 0)
				local var_404_24 = 0

				arg_401_1.mask_.enabled = false
				var_404_23.a = var_404_24
				arg_401_1.mask_.color = var_404_23
			end

			local var_404_25 = 2

			if var_404_25 < arg_401_1.time_ and arg_401_1.time_ <= var_404_25 + arg_404_0 then
				arg_401_1.fswbg_:SetActive(true)
				arg_401_1.dialog_:SetActive(false)

				arg_401_1.fswtw_.percent = 0

				local var_404_26 = arg_401_1:GetWordFromCfg(1109302101)
				local var_404_27 = arg_401_1:FormatText(var_404_26.content)

				arg_401_1.fswt_.text = var_404_27

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.fswt_)

				arg_401_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_401_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_401_1.fswtw_:SetDirty()

				arg_401_1.typewritterCharCountI18N = 0

				SetActive(arg_401_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_401_1:ShowNextGo(false)
			end

			local var_404_28 = 2.01666666666667

			if var_404_28 < arg_401_1.time_ and arg_401_1.time_ <= var_404_28 + arg_404_0 then
				arg_401_1.var_.oldValueTypewriter = arg_401_1.fswtw_.percent

				SetActive(arg_401_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_401_1:ShowNextGo(false)
			end

			local var_404_29 = 37
			local var_404_30 = 2.46666666666667
			local var_404_31 = arg_401_1:GetWordFromCfg(1109302101)
			local var_404_32 = arg_401_1:FormatText(var_404_31.content)
			local var_404_33, var_404_34 = arg_401_1:GetPercentByPara(var_404_32, 1)

			if var_404_28 < arg_401_1.time_ and arg_401_1.time_ <= var_404_28 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0

				local var_404_35 = var_404_29 <= 0 and var_404_30 or var_404_30 * ((var_404_34 - arg_401_1.typewritterCharCountI18N) / var_404_29)

				if var_404_35 > 0 and var_404_30 < var_404_35 then
					arg_401_1.talkMaxDuration = var_404_35

					if var_404_35 + var_404_28 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_35 + var_404_28
					end
				end
			end

			local var_404_36 = 2.46666666666667
			local var_404_37 = math.max(var_404_36, arg_401_1.talkMaxDuration)

			if var_404_28 <= arg_401_1.time_ and arg_401_1.time_ < var_404_28 + var_404_37 then
				local var_404_38 = (arg_401_1.time_ - var_404_28) / var_404_37

				arg_401_1.fswtw_.percent = Mathf.Lerp(arg_401_1.var_.oldValueTypewriter, var_404_33, var_404_38)
				arg_401_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_401_1.fswtw_:SetDirty()
			end

			if arg_401_1.time_ >= var_404_28 + var_404_37 and arg_401_1.time_ < var_404_28 + var_404_37 + arg_404_0 then
				arg_401_1.fswtw_.percent = var_404_33

				arg_401_1.fswtw_:SetDirty()
				arg_401_1:ShowNextGo(true)

				arg_401_1.typewritterCharCountI18N = var_404_34
			end

			local var_404_39 = 2

			if var_404_39 < arg_401_1.time_ and arg_401_1.time_ <= var_404_39 + arg_404_0 then
				local var_404_40 = arg_401_1.fswbg_.transform:Find("textbox/adapt/content") or arg_401_1.fswbg_.transform:Find("textbox/content")
				local var_404_41 = arg_401_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_404_42 = var_404_40:GetComponent("Text")
				local var_404_43 = var_404_40:GetComponent("RectTransform")

				var_404_42.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_404_43.offsetMin = Vector2.New(0, 0)
				var_404_43.offsetMax = Vector2.New(0, 0)
			end

			local var_404_44 = arg_401_1.actors_["1050ui_story"].transform
			local var_404_45 = 1.966

			if var_404_45 < arg_401_1.time_ and arg_401_1.time_ <= var_404_45 + arg_404_0 then
				arg_401_1.var_.moveOldPos1050ui_story = var_404_44.localPosition
			end

			local var_404_46 = 0.001

			if var_404_45 <= arg_401_1.time_ and arg_401_1.time_ < var_404_45 + var_404_46 then
				local var_404_47 = (arg_401_1.time_ - var_404_45) / var_404_46
				local var_404_48 = Vector3.New(0, 100, 0)

				var_404_44.localPosition = Vector3.Lerp(arg_401_1.var_.moveOldPos1050ui_story, var_404_48, var_404_47)

				local var_404_49 = manager.ui.mainCamera.transform.position - var_404_44.position

				var_404_44.forward = Vector3.New(var_404_49.x, var_404_49.y, var_404_49.z)

				local var_404_50 = var_404_44.localEulerAngles

				var_404_50.z = 0
				var_404_50.x = 0
				var_404_44.localEulerAngles = var_404_50
			end

			if arg_401_1.time_ >= var_404_45 + var_404_46 and arg_401_1.time_ < var_404_45 + var_404_46 + arg_404_0 then
				var_404_44.localPosition = Vector3.New(0, 100, 0)

				local var_404_51 = manager.ui.mainCamera.transform.position - var_404_44.position

				var_404_44.forward = Vector3.New(var_404_51.x, var_404_51.y, var_404_51.z)

				local var_404_52 = var_404_44.localEulerAngles

				var_404_52.z = 0
				var_404_52.x = 0
				var_404_44.localEulerAngles = var_404_52
			end
		end

		arg_401_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_401_1:InitPlayNodeList()
	end,
	Play1109302102 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 1109302102
		arg_405_1.duration_ = 2.6

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play1109302103(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = 0

			if var_408_0 < arg_405_1.time_ and arg_405_1.time_ <= var_408_0 + arg_408_0 then
				arg_405_1.var_.oldValueTypewriter = arg_405_1.fswtw_.percent

				SetActive(arg_405_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_405_1:ShowNextGo(false)
			end

			local var_408_1 = 39
			local var_408_2 = 2.6
			local var_408_3 = arg_405_1:GetWordFromCfg(1109302101)
			local var_408_4 = arg_405_1:FormatText(var_408_3.content)
			local var_408_5, var_408_6 = arg_405_1:GetPercentByPara(var_408_4, 2)

			if var_408_0 < arg_405_1.time_ and arg_405_1.time_ <= var_408_0 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0

				local var_408_7 = var_408_1 <= 0 and var_408_2 or var_408_2 * ((var_408_6 - arg_405_1.typewritterCharCountI18N) / var_408_1)

				if var_408_7 > 0 and var_408_2 < var_408_7 then
					arg_405_1.talkMaxDuration = var_408_7

					if var_408_7 + var_408_0 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_7 + var_408_0
					end
				end
			end

			local var_408_8 = 2.6
			local var_408_9 = math.max(var_408_8, arg_405_1.talkMaxDuration)

			if var_408_0 <= arg_405_1.time_ and arg_405_1.time_ < var_408_0 + var_408_9 then
				local var_408_10 = (arg_405_1.time_ - var_408_0) / var_408_9

				arg_405_1.fswtw_.percent = Mathf.Lerp(arg_405_1.var_.oldValueTypewriter, var_408_5, var_408_10)
				arg_405_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_405_1.fswtw_:SetDirty()
			end

			if arg_405_1.time_ >= var_408_0 + var_408_9 and arg_405_1.time_ < var_408_0 + var_408_9 + arg_408_0 then
				arg_405_1.fswtw_.percent = var_408_5

				arg_405_1.fswtw_:SetDirty()
				arg_405_1:ShowNextGo(true)

				arg_405_1.typewritterCharCountI18N = var_408_6
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	Play1109302103 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 1109302103
		arg_409_1.duration_ = 1.4

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play1109302104(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			local var_412_0 = 0

			if var_412_0 < arg_409_1.time_ and arg_409_1.time_ <= var_412_0 + arg_412_0 then
				arg_409_1.var_.oldValueTypewriter = arg_409_1.fswtw_.percent

				SetActive(arg_409_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_409_1:ShowNextGo(false)
			end

			local var_412_1 = 21
			local var_412_2 = 1.4
			local var_412_3 = arg_409_1:GetWordFromCfg(1109302101)
			local var_412_4 = arg_409_1:FormatText(var_412_3.content)
			local var_412_5, var_412_6 = arg_409_1:GetPercentByPara(var_412_4, 3)

			if var_412_0 < arg_409_1.time_ and arg_409_1.time_ <= var_412_0 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0

				local var_412_7 = var_412_1 <= 0 and var_412_2 or var_412_2 * ((var_412_6 - arg_409_1.typewritterCharCountI18N) / var_412_1)

				if var_412_7 > 0 and var_412_2 < var_412_7 then
					arg_409_1.talkMaxDuration = var_412_7

					if var_412_7 + var_412_0 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_7 + var_412_0
					end
				end
			end

			local var_412_8 = 1.4
			local var_412_9 = math.max(var_412_8, arg_409_1.talkMaxDuration)

			if var_412_0 <= arg_409_1.time_ and arg_409_1.time_ < var_412_0 + var_412_9 then
				local var_412_10 = (arg_409_1.time_ - var_412_0) / var_412_9

				arg_409_1.fswtw_.percent = Mathf.Lerp(arg_409_1.var_.oldValueTypewriter, var_412_5, var_412_10)
				arg_409_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_409_1.fswtw_:SetDirty()
			end

			if arg_409_1.time_ >= var_412_0 + var_412_9 and arg_409_1.time_ < var_412_0 + var_412_9 + arg_412_0 then
				arg_409_1.fswtw_.percent = var_412_5

				arg_409_1.fswtw_:SetDirty()
				arg_409_1:ShowNextGo(true)

				arg_409_1.typewritterCharCountI18N = var_412_6
			end
		end

		arg_409_1.nodeConfigList_ = {}

		arg_409_1:InitPlayNodeList()
	end,
	Play1109302104 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 1109302104
		arg_413_1.duration_ = 1

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play1109302105(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			local var_416_0 = 0

			if var_416_0 < arg_413_1.time_ and arg_413_1.time_ <= var_416_0 + arg_416_0 then
				arg_413_1.var_.oldValueTypewriter = arg_413_1.fswtw_.percent

				SetActive(arg_413_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_413_1:ShowNextGo(false)
			end

			local var_416_1 = 2
			local var_416_2 = 0.133333333333333
			local var_416_3 = arg_413_1:GetWordFromCfg(1109302101)
			local var_416_4 = arg_413_1:FormatText(var_416_3.content)
			local var_416_5, var_416_6 = arg_413_1:GetPercentByPara(var_416_4, 4)

			if var_416_0 < arg_413_1.time_ and arg_413_1.time_ <= var_416_0 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0

				local var_416_7 = var_416_1 <= 0 and var_416_2 or var_416_2 * ((var_416_6 - arg_413_1.typewritterCharCountI18N) / var_416_1)

				if var_416_7 > 0 and var_416_2 < var_416_7 then
					arg_413_1.talkMaxDuration = var_416_7

					if var_416_7 + var_416_0 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_7 + var_416_0
					end
				end
			end

			local var_416_8 = 0.133333333333333
			local var_416_9 = math.max(var_416_8, arg_413_1.talkMaxDuration)

			if var_416_0 <= arg_413_1.time_ and arg_413_1.time_ < var_416_0 + var_416_9 then
				local var_416_10 = (arg_413_1.time_ - var_416_0) / var_416_9

				arg_413_1.fswtw_.percent = Mathf.Lerp(arg_413_1.var_.oldValueTypewriter, var_416_5, var_416_10)
				arg_413_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_413_1.fswtw_:SetDirty()
			end

			if arg_413_1.time_ >= var_416_0 + var_416_9 and arg_413_1.time_ < var_416_0 + var_416_9 + arg_416_0 then
				arg_413_1.fswtw_.percent = var_416_5

				arg_413_1.fswtw_:SetDirty()
				arg_413_1:ShowNextGo(true)

				arg_413_1.typewritterCharCountI18N = var_416_6
			end
		end

		arg_413_1.nodeConfigList_ = {}

		arg_413_1:InitPlayNodeList()
	end,
	Play1109302105 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 1109302105
		arg_417_1.duration_ = 9

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play1109302106(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			local var_420_0 = "ST11a"

			if arg_417_1.bgs_[var_420_0] == nil then
				local var_420_1 = Object.Instantiate(arg_417_1.paintGo_)

				var_420_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_420_0)
				var_420_1.name = var_420_0
				var_420_1.transform.parent = arg_417_1.stage_.transform
				var_420_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_417_1.bgs_[var_420_0] = var_420_1
			end

			local var_420_2 = 2

			if var_420_2 < arg_417_1.time_ and arg_417_1.time_ <= var_420_2 + arg_420_0 then
				local var_420_3 = manager.ui.mainCamera.transform.localPosition
				local var_420_4 = Vector3.New(0, 0, 10) + Vector3.New(var_420_3.x, var_420_3.y, 0)
				local var_420_5 = arg_417_1.bgs_.ST11a

				var_420_5.transform.localPosition = var_420_4
				var_420_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_420_6 = var_420_5:GetComponent("SpriteRenderer")

				if var_420_6 and var_420_6.sprite then
					local var_420_7 = (var_420_5.transform.localPosition - var_420_3).z
					local var_420_8 = manager.ui.mainCameraCom_
					local var_420_9 = 2 * var_420_7 * Mathf.Tan(var_420_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_420_10 = var_420_9 * var_420_8.aspect
					local var_420_11 = var_420_6.sprite.bounds.size.x
					local var_420_12 = var_420_6.sprite.bounds.size.y
					local var_420_13 = var_420_10 / var_420_11
					local var_420_14 = var_420_9 / var_420_12
					local var_420_15 = var_420_14 < var_420_13 and var_420_13 or var_420_14

					var_420_5.transform.localScale = Vector3.New(var_420_15, var_420_15, 0)
				end

				for iter_420_0, iter_420_1 in pairs(arg_417_1.bgs_) do
					if iter_420_0 ~= "ST11a" then
						iter_420_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_420_16 = 0

			if var_420_16 < arg_417_1.time_ and arg_417_1.time_ <= var_420_16 + arg_420_0 then
				arg_417_1.mask_.enabled = true
				arg_417_1.mask_.raycastTarget = true

				arg_417_1:SetGaussion(false)
			end

			local var_420_17 = 2

			if var_420_16 <= arg_417_1.time_ and arg_417_1.time_ < var_420_16 + var_420_17 then
				local var_420_18 = (arg_417_1.time_ - var_420_16) / var_420_17
				local var_420_19 = Color.New(0, 0, 0)

				var_420_19.a = Mathf.Lerp(0, 1, var_420_18)
				arg_417_1.mask_.color = var_420_19
			end

			if arg_417_1.time_ >= var_420_16 + var_420_17 and arg_417_1.time_ < var_420_16 + var_420_17 + arg_420_0 then
				local var_420_20 = Color.New(0, 0, 0)

				var_420_20.a = 1
				arg_417_1.mask_.color = var_420_20
			end

			local var_420_21 = 2

			if var_420_21 < arg_417_1.time_ and arg_417_1.time_ <= var_420_21 + arg_420_0 then
				arg_417_1.mask_.enabled = true
				arg_417_1.mask_.raycastTarget = true

				arg_417_1:SetGaussion(false)
			end

			local var_420_22 = 2

			if var_420_21 <= arg_417_1.time_ and arg_417_1.time_ < var_420_21 + var_420_22 then
				local var_420_23 = (arg_417_1.time_ - var_420_21) / var_420_22
				local var_420_24 = Color.New(0, 0, 0)

				var_420_24.a = Mathf.Lerp(1, 0, var_420_23)
				arg_417_1.mask_.color = var_420_24
			end

			if arg_417_1.time_ >= var_420_21 + var_420_22 and arg_417_1.time_ < var_420_21 + var_420_22 + arg_420_0 then
				local var_420_25 = Color.New(0, 0, 0)
				local var_420_26 = 0

				arg_417_1.mask_.enabled = false
				var_420_25.a = var_420_26
				arg_417_1.mask_.color = var_420_25
			end

			local var_420_27 = manager.ui.mainCamera.transform
			local var_420_28 = 0

			if var_420_28 < arg_417_1.time_ and arg_417_1.time_ <= var_420_28 + arg_420_0 then
				local var_420_29 = arg_417_1.var_.effectyutianluhua1
				local var_420_30
				local var_420_31 = var_420_27

				if not var_420_29 then
					var_420_29 = Object.Instantiate(Asset.Load("Effect/Scene/fx_raindrop"), var_420_31)
					var_420_29.name = "yutianluhua1"
					arg_417_1.var_.effectyutianluhua1 = var_420_29
				else
					var_420_29.transform:SetParent(var_420_31)
				end

				var_420_29.transform.localPosition = Vector3.New(0, 0, 0)
				var_420_29.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_420_32 = 1.98333333333333

			if var_420_32 < arg_417_1.time_ and arg_417_1.time_ <= var_420_32 + arg_420_0 then
				arg_417_1.fswbg_:SetActive(false)
				arg_417_1.dialog_:SetActive(false)
				SetActive(arg_417_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_417_1:ShowNextGo(false)
			end

			local var_420_33 = 2
			local var_420_34 = 1

			if var_420_33 < arg_417_1.time_ and arg_417_1.time_ <= var_420_33 + arg_420_0 then
				local var_420_35 = "play"
				local var_420_36 = "effect"

				arg_417_1:AudioAction(var_420_35, var_420_36, "se_story_activity_1_5_3", "se_story_activity_1_5_3_rain_loop", "")
			end

			if arg_417_1.frameCnt_ <= 1 then
				arg_417_1.dialog_:SetActive(false)
			end

			local var_420_37 = 4
			local var_420_38 = 0.425

			if var_420_37 < arg_417_1.time_ and arg_417_1.time_ <= var_420_37 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0

				arg_417_1.dialog_:SetActive(true)

				arg_417_1.dialogCg_.alpha = 0

				local var_420_39 = LeanTween.value(arg_417_1.dialog_, 0, 1, 0.3)

				var_420_39:setOnUpdate(LuaHelper.FloatAction(function(arg_421_0)
					arg_417_1.dialogCg_.alpha = arg_421_0
				end))
				var_420_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_417_1.dialog_)
					var_420_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_417_1.duration_ = arg_417_1.duration_ + 0.3

				SetActive(arg_417_1.leftNameGo_, false)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_417_1.iconTrs_.gameObject, false)
				arg_417_1.callingController_:SetSelectedState("normal")

				local var_420_40 = arg_417_1:GetWordFromCfg(1109302105)
				local var_420_41 = arg_417_1:FormatText(var_420_40.content)

				arg_417_1.text_.text = var_420_41

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_42 = 17
				local var_420_43 = utf8.len(var_420_41)
				local var_420_44 = var_420_42 <= 0 and var_420_38 or var_420_38 * (var_420_43 / var_420_42)

				if var_420_44 > 0 and var_420_38 < var_420_44 then
					arg_417_1.talkMaxDuration = var_420_44
					var_420_37 = var_420_37 + 0.3

					if var_420_44 + var_420_37 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_44 + var_420_37
					end
				end

				arg_417_1.text_.text = var_420_41
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)
				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_45 = var_420_37 + 0.3
			local var_420_46 = math.max(var_420_38, arg_417_1.talkMaxDuration)

			if var_420_45 <= arg_417_1.time_ and arg_417_1.time_ < var_420_45 + var_420_46 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_45) / var_420_46

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_45 + var_420_46 and arg_417_1.time_ < var_420_45 + var_420_46 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {}

		arg_417_1:InitPlayNodeList()
	end,
	Play1109302106 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 1109302106
		arg_423_1.duration_ = 3.1

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play1109302107(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			local var_426_0 = arg_423_1.actors_["1050ui_story"].transform
			local var_426_1 = 0

			if var_426_1 < arg_423_1.time_ and arg_423_1.time_ <= var_426_1 + arg_426_0 then
				arg_423_1.var_.moveOldPos1050ui_story = var_426_0.localPosition
			end

			local var_426_2 = 0.001

			if var_426_1 <= arg_423_1.time_ and arg_423_1.time_ < var_426_1 + var_426_2 then
				local var_426_3 = (arg_423_1.time_ - var_426_1) / var_426_2
				local var_426_4 = Vector3.New(0, -1, -6.1)

				var_426_0.localPosition = Vector3.Lerp(arg_423_1.var_.moveOldPos1050ui_story, var_426_4, var_426_3)

				local var_426_5 = manager.ui.mainCamera.transform.position - var_426_0.position

				var_426_0.forward = Vector3.New(var_426_5.x, var_426_5.y, var_426_5.z)

				local var_426_6 = var_426_0.localEulerAngles

				var_426_6.z = 0
				var_426_6.x = 0
				var_426_0.localEulerAngles = var_426_6
			end

			if arg_423_1.time_ >= var_426_1 + var_426_2 and arg_423_1.time_ < var_426_1 + var_426_2 + arg_426_0 then
				var_426_0.localPosition = Vector3.New(0, -1, -6.1)

				local var_426_7 = manager.ui.mainCamera.transform.position - var_426_0.position

				var_426_0.forward = Vector3.New(var_426_7.x, var_426_7.y, var_426_7.z)

				local var_426_8 = var_426_0.localEulerAngles

				var_426_8.z = 0
				var_426_8.x = 0
				var_426_0.localEulerAngles = var_426_8
			end

			local var_426_9 = arg_423_1.actors_["1050ui_story"]
			local var_426_10 = 0

			if var_426_10 < arg_423_1.time_ and arg_423_1.time_ <= var_426_10 + arg_426_0 and not isNil(var_426_9) and arg_423_1.var_.characterEffect1050ui_story == nil then
				arg_423_1.var_.characterEffect1050ui_story = var_426_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_426_11 = 0.2

			if var_426_10 <= arg_423_1.time_ and arg_423_1.time_ < var_426_10 + var_426_11 and not isNil(var_426_9) then
				local var_426_12 = (arg_423_1.time_ - var_426_10) / var_426_11

				if arg_423_1.var_.characterEffect1050ui_story and not isNil(var_426_9) then
					arg_423_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_423_1.time_ >= var_426_10 + var_426_11 and arg_423_1.time_ < var_426_10 + var_426_11 + arg_426_0 and not isNil(var_426_9) and arg_423_1.var_.characterEffect1050ui_story then
				arg_423_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_426_13 = 0

			if var_426_13 < arg_423_1.time_ and arg_423_1.time_ <= var_426_13 + arg_426_0 then
				arg_423_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action5_1")
			end

			local var_426_14 = 0

			if var_426_14 < arg_423_1.time_ and arg_423_1.time_ <= var_426_14 + arg_426_0 then
				arg_423_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_426_15 = 0
			local var_426_16 = 0.2

			if var_426_15 < arg_423_1.time_ and arg_423_1.time_ <= var_426_15 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				local var_426_17 = arg_423_1:FormatText(StoryNameCfg[74].name)

				arg_423_1.leftNameTxt_.text = var_426_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, false)
				arg_423_1.callingController_:SetSelectedState("normal")

				local var_426_18 = arg_423_1:GetWordFromCfg(1109302106)
				local var_426_19 = arg_423_1:FormatText(var_426_18.content)

				arg_423_1.text_.text = var_426_19

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_20 = 8
				local var_426_21 = utf8.len(var_426_19)
				local var_426_22 = var_426_20 <= 0 and var_426_16 or var_426_16 * (var_426_21 / var_426_20)

				if var_426_22 > 0 and var_426_16 < var_426_22 then
					arg_423_1.talkMaxDuration = var_426_22

					if var_426_22 + var_426_15 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_22 + var_426_15
					end
				end

				arg_423_1.text_.text = var_426_19
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302106", "story_v_side_new_1109302.awb") ~= 0 then
					local var_426_23 = manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302106", "story_v_side_new_1109302.awb") / 1000

					if var_426_23 + var_426_15 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_23 + var_426_15
					end

					if var_426_18.prefab_name ~= "" and arg_423_1.actors_[var_426_18.prefab_name] ~= nil then
						local var_426_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_423_1.actors_[var_426_18.prefab_name].transform, "story_v_side_new_1109302", "1109302106", "story_v_side_new_1109302.awb")

						arg_423_1:RecordAudio("1109302106", var_426_24)
						arg_423_1:RecordAudio("1109302106", var_426_24)
					else
						arg_423_1:AudioAction("play", "voice", "story_v_side_new_1109302", "1109302106", "story_v_side_new_1109302.awb")
					end

					arg_423_1:RecordHistoryTalkVoice("story_v_side_new_1109302", "1109302106", "story_v_side_new_1109302.awb")
				end

				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_25 = math.max(var_426_16, arg_423_1.talkMaxDuration)

			if var_426_15 <= arg_423_1.time_ and arg_423_1.time_ < var_426_15 + var_426_25 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_15) / var_426_25

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_15 + var_426_25 and arg_423_1.time_ < var_426_15 + var_426_25 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_423_1:InitPlayNodeList()
	end,
	Play1109302107 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 1109302107
		arg_427_1.duration_ = 5

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play1109302108(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			local var_430_0 = arg_427_1.actors_["1050ui_story"]
			local var_430_1 = 0

			if var_430_1 < arg_427_1.time_ and arg_427_1.time_ <= var_430_1 + arg_430_0 and not isNil(var_430_0) and arg_427_1.var_.characterEffect1050ui_story == nil then
				arg_427_1.var_.characterEffect1050ui_story = var_430_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_430_2 = 0.2

			if var_430_1 <= arg_427_1.time_ and arg_427_1.time_ < var_430_1 + var_430_2 and not isNil(var_430_0) then
				local var_430_3 = (arg_427_1.time_ - var_430_1) / var_430_2

				if arg_427_1.var_.characterEffect1050ui_story and not isNil(var_430_0) then
					local var_430_4 = Mathf.Lerp(0, 0.5, var_430_3)

					arg_427_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_427_1.var_.characterEffect1050ui_story.fillRatio = var_430_4
				end
			end

			if arg_427_1.time_ >= var_430_1 + var_430_2 and arg_427_1.time_ < var_430_1 + var_430_2 + arg_430_0 and not isNil(var_430_0) and arg_427_1.var_.characterEffect1050ui_story then
				local var_430_5 = 0.5

				arg_427_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_427_1.var_.characterEffect1050ui_story.fillRatio = var_430_5
			end

			local var_430_6 = 0
			local var_430_7 = 0.15

			if var_430_6 < arg_427_1.time_ and arg_427_1.time_ <= var_430_6 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				local var_430_8 = arg_427_1:FormatText(StoryNameCfg[7].name)

				arg_427_1.leftNameTxt_.text = var_430_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, true)
				arg_427_1.iconController_:SetSelectedState("hero")

				arg_427_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_427_1.callingController_:SetSelectedState("normal")

				arg_427_1.keyicon_.color = Color.New(1, 1, 1)
				arg_427_1.icon_.color = Color.New(1, 1, 1)

				local var_430_9 = arg_427_1:GetWordFromCfg(1109302107)
				local var_430_10 = arg_427_1:FormatText(var_430_9.content)

				arg_427_1.text_.text = var_430_10

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_11 = 6
				local var_430_12 = utf8.len(var_430_10)
				local var_430_13 = var_430_11 <= 0 and var_430_7 or var_430_7 * (var_430_12 / var_430_11)

				if var_430_13 > 0 and var_430_7 < var_430_13 then
					arg_427_1.talkMaxDuration = var_430_13

					if var_430_13 + var_430_6 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_13 + var_430_6
					end
				end

				arg_427_1.text_.text = var_430_10
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)
				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_14 = math.max(var_430_7, arg_427_1.talkMaxDuration)

			if var_430_6 <= arg_427_1.time_ and arg_427_1.time_ < var_430_6 + var_430_14 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_6) / var_430_14

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_6 + var_430_14 and arg_427_1.time_ < var_430_6 + var_430_14 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {}

		arg_427_1:InitPlayNodeList()
	end,
	Play1109302108 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 1109302108
		arg_431_1.duration_ = 5

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play1109302109(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			local var_434_0 = 0
			local var_434_1 = 0.6

			if var_434_0 < arg_431_1.time_ and arg_431_1.time_ <= var_434_0 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, true)

				local var_434_2 = arg_431_1:FormatText(StoryNameCfg[7].name)

				arg_431_1.leftNameTxt_.text = var_434_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_431_1.leftNameTxt_.transform)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1.leftNameTxt_.text)
				SetActive(arg_431_1.iconTrs_.gameObject, true)
				arg_431_1.iconController_:SetSelectedState("hero")

				arg_431_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_431_1.callingController_:SetSelectedState("normal")

				arg_431_1.keyicon_.color = Color.New(1, 1, 1)
				arg_431_1.icon_.color = Color.New(1, 1, 1)

				local var_434_3 = arg_431_1:GetWordFromCfg(1109302108)
				local var_434_4 = arg_431_1:FormatText(var_434_3.content)

				arg_431_1.text_.text = var_434_4

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_5 = 24
				local var_434_6 = utf8.len(var_434_4)
				local var_434_7 = var_434_5 <= 0 and var_434_1 or var_434_1 * (var_434_6 / var_434_5)

				if var_434_7 > 0 and var_434_1 < var_434_7 then
					arg_431_1.talkMaxDuration = var_434_7

					if var_434_7 + var_434_0 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_7 + var_434_0
					end
				end

				arg_431_1.text_.text = var_434_4
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)
				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_8 = math.max(var_434_1, arg_431_1.talkMaxDuration)

			if var_434_0 <= arg_431_1.time_ and arg_431_1.time_ < var_434_0 + var_434_8 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_0) / var_434_8

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_0 + var_434_8 and arg_431_1.time_ < var_434_0 + var_434_8 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play1109302109 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 1109302109
		arg_435_1.duration_ = 5

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play1109302110(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			local var_438_0 = 0
			local var_438_1 = 0.875

			if var_438_0 < arg_435_1.time_ and arg_435_1.time_ <= var_438_0 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, false)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_435_1.iconTrs_.gameObject, false)
				arg_435_1.callingController_:SetSelectedState("normal")

				local var_438_2 = arg_435_1:GetWordFromCfg(1109302109)
				local var_438_3 = arg_435_1:FormatText(var_438_2.content)

				arg_435_1.text_.text = var_438_3

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_4 = 35
				local var_438_5 = utf8.len(var_438_3)
				local var_438_6 = var_438_4 <= 0 and var_438_1 or var_438_1 * (var_438_5 / var_438_4)

				if var_438_6 > 0 and var_438_1 < var_438_6 then
					arg_435_1.talkMaxDuration = var_438_6

					if var_438_6 + var_438_0 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_6 + var_438_0
					end
				end

				arg_435_1.text_.text = var_438_3
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)
				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_7 = math.max(var_438_1, arg_435_1.talkMaxDuration)

			if var_438_0 <= arg_435_1.time_ and arg_435_1.time_ < var_438_0 + var_438_7 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_0) / var_438_7

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_0 + var_438_7 and arg_435_1.time_ < var_438_0 + var_438_7 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {}

		arg_435_1:InitPlayNodeList()
	end,
	Play1109302110 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 1109302110
		arg_439_1.duration_ = 5

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play1109302111(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			local var_442_0 = 0
			local var_442_1 = 0.725

			if var_442_0 < arg_439_1.time_ and arg_439_1.time_ <= var_442_0 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, false)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_439_1.iconTrs_.gameObject, false)
				arg_439_1.callingController_:SetSelectedState("normal")

				local var_442_2 = arg_439_1:GetWordFromCfg(1109302110)
				local var_442_3 = arg_439_1:FormatText(var_442_2.content)

				arg_439_1.text_.text = var_442_3

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_4 = 29
				local var_442_5 = utf8.len(var_442_3)
				local var_442_6 = var_442_4 <= 0 and var_442_1 or var_442_1 * (var_442_5 / var_442_4)

				if var_442_6 > 0 and var_442_1 < var_442_6 then
					arg_439_1.talkMaxDuration = var_442_6

					if var_442_6 + var_442_0 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_6 + var_442_0
					end
				end

				arg_439_1.text_.text = var_442_3
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)
				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_7 = math.max(var_442_1, arg_439_1.talkMaxDuration)

			if var_442_0 <= arg_439_1.time_ and arg_439_1.time_ < var_442_0 + var_442_7 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_0) / var_442_7

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_0 + var_442_7 and arg_439_1.time_ < var_442_0 + var_442_7 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {}

		arg_439_1:InitPlayNodeList()
	end,
	Play1109302111 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 1109302111
		arg_443_1.duration_ = 2

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play1109302112(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			local var_446_0 = arg_443_1.actors_["1050ui_story"]
			local var_446_1 = 0

			if var_446_1 < arg_443_1.time_ and arg_443_1.time_ <= var_446_1 + arg_446_0 and not isNil(var_446_0) and arg_443_1.var_.characterEffect1050ui_story == nil then
				arg_443_1.var_.characterEffect1050ui_story = var_446_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_446_2 = 0.2

			if var_446_1 <= arg_443_1.time_ and arg_443_1.time_ < var_446_1 + var_446_2 and not isNil(var_446_0) then
				local var_446_3 = (arg_443_1.time_ - var_446_1) / var_446_2

				if arg_443_1.var_.characterEffect1050ui_story and not isNil(var_446_0) then
					arg_443_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_443_1.time_ >= var_446_1 + var_446_2 and arg_443_1.time_ < var_446_1 + var_446_2 + arg_446_0 and not isNil(var_446_0) and arg_443_1.var_.characterEffect1050ui_story then
				arg_443_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_446_4 = 0

			if var_446_4 < arg_443_1.time_ and arg_443_1.time_ <= var_446_4 + arg_446_0 then
				arg_443_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050actionlink/1050action452")
			end

			local var_446_5 = 0

			if var_446_5 < arg_443_1.time_ and arg_443_1.time_ <= var_446_5 + arg_446_0 then
				arg_443_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_446_6 = 0
			local var_446_7 = 0.25

			if var_446_6 < arg_443_1.time_ and arg_443_1.time_ <= var_446_6 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, true)

				local var_446_8 = arg_443_1:FormatText(StoryNameCfg[74].name)

				arg_443_1.leftNameTxt_.text = var_446_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_443_1.leftNameTxt_.transform)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1.leftNameTxt_.text)
				SetActive(arg_443_1.iconTrs_.gameObject, false)
				arg_443_1.callingController_:SetSelectedState("normal")

				local var_446_9 = arg_443_1:GetWordFromCfg(1109302111)
				local var_446_10 = arg_443_1:FormatText(var_446_9.content)

				arg_443_1.text_.text = var_446_10

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_11 = 10
				local var_446_12 = utf8.len(var_446_10)
				local var_446_13 = var_446_11 <= 0 and var_446_7 or var_446_7 * (var_446_12 / var_446_11)

				if var_446_13 > 0 and var_446_7 < var_446_13 then
					arg_443_1.talkMaxDuration = var_446_13

					if var_446_13 + var_446_6 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_13 + var_446_6
					end
				end

				arg_443_1.text_.text = var_446_10
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302111", "story_v_side_new_1109302.awb") ~= 0 then
					local var_446_14 = manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302111", "story_v_side_new_1109302.awb") / 1000

					if var_446_14 + var_446_6 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_14 + var_446_6
					end

					if var_446_9.prefab_name ~= "" and arg_443_1.actors_[var_446_9.prefab_name] ~= nil then
						local var_446_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_443_1.actors_[var_446_9.prefab_name].transform, "story_v_side_new_1109302", "1109302111", "story_v_side_new_1109302.awb")

						arg_443_1:RecordAudio("1109302111", var_446_15)
						arg_443_1:RecordAudio("1109302111", var_446_15)
					else
						arg_443_1:AudioAction("play", "voice", "story_v_side_new_1109302", "1109302111", "story_v_side_new_1109302.awb")
					end

					arg_443_1:RecordHistoryTalkVoice("story_v_side_new_1109302", "1109302111", "story_v_side_new_1109302.awb")
				end

				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_16 = math.max(var_446_7, arg_443_1.talkMaxDuration)

			if var_446_6 <= arg_443_1.time_ and arg_443_1.time_ < var_446_6 + var_446_16 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - var_446_6) / var_446_16

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= var_446_6 + var_446_16 and arg_443_1.time_ < var_446_6 + var_446_16 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {}

		arg_443_1:InitPlayNodeList()
	end,
	Play1109302112 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 1109302112
		arg_447_1.duration_ = 5

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play1109302113(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			local var_450_0 = arg_447_1.actors_["1050ui_story"]
			local var_450_1 = 0

			if var_450_1 < arg_447_1.time_ and arg_447_1.time_ <= var_450_1 + arg_450_0 and not isNil(var_450_0) and arg_447_1.var_.characterEffect1050ui_story == nil then
				arg_447_1.var_.characterEffect1050ui_story = var_450_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_450_2 = 0.2

			if var_450_1 <= arg_447_1.time_ and arg_447_1.time_ < var_450_1 + var_450_2 and not isNil(var_450_0) then
				local var_450_3 = (arg_447_1.time_ - var_450_1) / var_450_2

				if arg_447_1.var_.characterEffect1050ui_story and not isNil(var_450_0) then
					local var_450_4 = Mathf.Lerp(0, 0.5, var_450_3)

					arg_447_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_447_1.var_.characterEffect1050ui_story.fillRatio = var_450_4
				end
			end

			if arg_447_1.time_ >= var_450_1 + var_450_2 and arg_447_1.time_ < var_450_1 + var_450_2 + arg_450_0 and not isNil(var_450_0) and arg_447_1.var_.characterEffect1050ui_story then
				local var_450_5 = 0.5

				arg_447_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_447_1.var_.characterEffect1050ui_story.fillRatio = var_450_5
			end

			local var_450_6 = 0
			local var_450_7 = 0.475

			if var_450_6 < arg_447_1.time_ and arg_447_1.time_ <= var_450_6 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, true)

				local var_450_8 = arg_447_1:FormatText(StoryNameCfg[7].name)

				arg_447_1.leftNameTxt_.text = var_450_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_447_1.leftNameTxt_.transform)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1.leftNameTxt_.text)
				SetActive(arg_447_1.iconTrs_.gameObject, true)
				arg_447_1.iconController_:SetSelectedState("hero")

				arg_447_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_447_1.callingController_:SetSelectedState("normal")

				arg_447_1.keyicon_.color = Color.New(1, 1, 1)
				arg_447_1.icon_.color = Color.New(1, 1, 1)

				local var_450_9 = arg_447_1:GetWordFromCfg(1109302112)
				local var_450_10 = arg_447_1:FormatText(var_450_9.content)

				arg_447_1.text_.text = var_450_10

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_11 = 18
				local var_450_12 = utf8.len(var_450_10)
				local var_450_13 = var_450_11 <= 0 and var_450_7 or var_450_7 * (var_450_12 / var_450_11)

				if var_450_13 > 0 and var_450_7 < var_450_13 then
					arg_447_1.talkMaxDuration = var_450_13

					if var_450_13 + var_450_6 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_13 + var_450_6
					end
				end

				arg_447_1.text_.text = var_450_10
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)
				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_14 = math.max(var_450_7, arg_447_1.talkMaxDuration)

			if var_450_6 <= arg_447_1.time_ and arg_447_1.time_ < var_450_6 + var_450_14 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - var_450_6) / var_450_14

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= var_450_6 + var_450_14 and arg_447_1.time_ < var_450_6 + var_450_14 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {}

		arg_447_1:InitPlayNodeList()
	end,
	Play1109302113 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 1109302113
		arg_451_1.duration_ = 2.67

		SetActive(arg_451_1.tipsGo_, false)

		function arg_451_1.onSingleLineFinish_()
			arg_451_1.onSingleLineUpdate_ = nil
			arg_451_1.onSingleLineFinish_ = nil
			arg_451_1.state_ = "waiting"
		end

		function arg_451_1.playNext_(arg_453_0)
			if arg_453_0 == 1 then
				arg_451_0:Play1109302114(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			local var_454_0 = arg_451_1.actors_["1050ui_story"]
			local var_454_1 = 0

			if var_454_1 < arg_451_1.time_ and arg_451_1.time_ <= var_454_1 + arg_454_0 and not isNil(var_454_0) and arg_451_1.var_.characterEffect1050ui_story == nil then
				arg_451_1.var_.characterEffect1050ui_story = var_454_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_454_2 = 0.2

			if var_454_1 <= arg_451_1.time_ and arg_451_1.time_ < var_454_1 + var_454_2 and not isNil(var_454_0) then
				local var_454_3 = (arg_451_1.time_ - var_454_1) / var_454_2

				if arg_451_1.var_.characterEffect1050ui_story and not isNil(var_454_0) then
					arg_451_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_451_1.time_ >= var_454_1 + var_454_2 and arg_451_1.time_ < var_454_1 + var_454_2 + arg_454_0 and not isNil(var_454_0) and arg_451_1.var_.characterEffect1050ui_story then
				arg_451_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_454_4 = 0

			if var_454_4 < arg_451_1.time_ and arg_451_1.time_ <= var_454_4 + arg_454_0 then
				arg_451_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_454_5 = 0
			local var_454_6 = 0.375

			if var_454_5 < arg_451_1.time_ and arg_451_1.time_ <= var_454_5 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, true)

				local var_454_7 = arg_451_1:FormatText(StoryNameCfg[74].name)

				arg_451_1.leftNameTxt_.text = var_454_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_451_1.leftNameTxt_.transform)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1.leftNameTxt_.text)
				SetActive(arg_451_1.iconTrs_.gameObject, false)
				arg_451_1.callingController_:SetSelectedState("normal")

				local var_454_8 = arg_451_1:GetWordFromCfg(1109302113)
				local var_454_9 = arg_451_1:FormatText(var_454_8.content)

				arg_451_1.text_.text = var_454_9

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_10 = 15
				local var_454_11 = utf8.len(var_454_9)
				local var_454_12 = var_454_10 <= 0 and var_454_6 or var_454_6 * (var_454_11 / var_454_10)

				if var_454_12 > 0 and var_454_6 < var_454_12 then
					arg_451_1.talkMaxDuration = var_454_12

					if var_454_12 + var_454_5 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_12 + var_454_5
					end
				end

				arg_451_1.text_.text = var_454_9
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302113", "story_v_side_new_1109302.awb") ~= 0 then
					local var_454_13 = manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302113", "story_v_side_new_1109302.awb") / 1000

					if var_454_13 + var_454_5 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_13 + var_454_5
					end

					if var_454_8.prefab_name ~= "" and arg_451_1.actors_[var_454_8.prefab_name] ~= nil then
						local var_454_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_451_1.actors_[var_454_8.prefab_name].transform, "story_v_side_new_1109302", "1109302113", "story_v_side_new_1109302.awb")

						arg_451_1:RecordAudio("1109302113", var_454_14)
						arg_451_1:RecordAudio("1109302113", var_454_14)
					else
						arg_451_1:AudioAction("play", "voice", "story_v_side_new_1109302", "1109302113", "story_v_side_new_1109302.awb")
					end

					arg_451_1:RecordHistoryTalkVoice("story_v_side_new_1109302", "1109302113", "story_v_side_new_1109302.awb")
				end

				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_15 = math.max(var_454_6, arg_451_1.talkMaxDuration)

			if var_454_5 <= arg_451_1.time_ and arg_451_1.time_ < var_454_5 + var_454_15 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - var_454_5) / var_454_15

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= var_454_5 + var_454_15 and arg_451_1.time_ < var_454_5 + var_454_15 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {}

		arg_451_1:InitPlayNodeList()
	end,
	Play1109302114 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 1109302114
		arg_455_1.duration_ = 5.13

		SetActive(arg_455_1.tipsGo_, false)

		function arg_455_1.onSingleLineFinish_()
			arg_455_1.onSingleLineUpdate_ = nil
			arg_455_1.onSingleLineFinish_ = nil
			arg_455_1.state_ = "waiting"
		end

		function arg_455_1.playNext_(arg_457_0)
			if arg_457_0 == 1 then
				arg_455_0:Play1109302115(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			local var_458_0 = 0

			if var_458_0 < arg_455_1.time_ and arg_455_1.time_ <= var_458_0 + arg_458_0 then
				arg_455_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050actionlink/1050action425")
			end

			local var_458_1 = 0

			if var_458_1 < arg_455_1.time_ and arg_455_1.time_ <= var_458_1 + arg_458_0 then
				arg_455_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_458_2 = 0
			local var_458_3 = 0.6

			if var_458_2 < arg_455_1.time_ and arg_455_1.time_ <= var_458_2 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, true)

				local var_458_4 = arg_455_1:FormatText(StoryNameCfg[74].name)

				arg_455_1.leftNameTxt_.text = var_458_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_455_1.leftNameTxt_.transform)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1.leftNameTxt_.text)
				SetActive(arg_455_1.iconTrs_.gameObject, false)
				arg_455_1.callingController_:SetSelectedState("normal")

				local var_458_5 = arg_455_1:GetWordFromCfg(1109302114)
				local var_458_6 = arg_455_1:FormatText(var_458_5.content)

				arg_455_1.text_.text = var_458_6

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_7 = 24
				local var_458_8 = utf8.len(var_458_6)
				local var_458_9 = var_458_7 <= 0 and var_458_3 or var_458_3 * (var_458_8 / var_458_7)

				if var_458_9 > 0 and var_458_3 < var_458_9 then
					arg_455_1.talkMaxDuration = var_458_9

					if var_458_9 + var_458_2 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_9 + var_458_2
					end
				end

				arg_455_1.text_.text = var_458_6
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302114", "story_v_side_new_1109302.awb") ~= 0 then
					local var_458_10 = manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302114", "story_v_side_new_1109302.awb") / 1000

					if var_458_10 + var_458_2 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_10 + var_458_2
					end

					if var_458_5.prefab_name ~= "" and arg_455_1.actors_[var_458_5.prefab_name] ~= nil then
						local var_458_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_455_1.actors_[var_458_5.prefab_name].transform, "story_v_side_new_1109302", "1109302114", "story_v_side_new_1109302.awb")

						arg_455_1:RecordAudio("1109302114", var_458_11)
						arg_455_1:RecordAudio("1109302114", var_458_11)
					else
						arg_455_1:AudioAction("play", "voice", "story_v_side_new_1109302", "1109302114", "story_v_side_new_1109302.awb")
					end

					arg_455_1:RecordHistoryTalkVoice("story_v_side_new_1109302", "1109302114", "story_v_side_new_1109302.awb")
				end

				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_12 = math.max(var_458_3, arg_455_1.talkMaxDuration)

			if var_458_2 <= arg_455_1.time_ and arg_455_1.time_ < var_458_2 + var_458_12 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - var_458_2) / var_458_12

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= var_458_2 + var_458_12 and arg_455_1.time_ < var_458_2 + var_458_12 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {}

		arg_455_1:InitPlayNodeList()
	end,
	Play1109302115 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 1109302115
		arg_459_1.duration_ = 5

		SetActive(arg_459_1.tipsGo_, false)

		function arg_459_1.onSingleLineFinish_()
			arg_459_1.onSingleLineUpdate_ = nil
			arg_459_1.onSingleLineFinish_ = nil
			arg_459_1.state_ = "waiting"
		end

		function arg_459_1.playNext_(arg_461_0)
			if arg_461_0 == 1 then
				arg_459_0:Play1109302116(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			local var_462_0 = arg_459_1.actors_["1050ui_story"]
			local var_462_1 = 0

			if var_462_1 < arg_459_1.time_ and arg_459_1.time_ <= var_462_1 + arg_462_0 and not isNil(var_462_0) and arg_459_1.var_.characterEffect1050ui_story == nil then
				arg_459_1.var_.characterEffect1050ui_story = var_462_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_462_2 = 0.2

			if var_462_1 <= arg_459_1.time_ and arg_459_1.time_ < var_462_1 + var_462_2 and not isNil(var_462_0) then
				local var_462_3 = (arg_459_1.time_ - var_462_1) / var_462_2

				if arg_459_1.var_.characterEffect1050ui_story and not isNil(var_462_0) then
					local var_462_4 = Mathf.Lerp(0, 0.5, var_462_3)

					arg_459_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_459_1.var_.characterEffect1050ui_story.fillRatio = var_462_4
				end
			end

			if arg_459_1.time_ >= var_462_1 + var_462_2 and arg_459_1.time_ < var_462_1 + var_462_2 + arg_462_0 and not isNil(var_462_0) and arg_459_1.var_.characterEffect1050ui_story then
				local var_462_5 = 0.5

				arg_459_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_459_1.var_.characterEffect1050ui_story.fillRatio = var_462_5
			end

			local var_462_6 = 0
			local var_462_7 = 0.125

			if var_462_6 < arg_459_1.time_ and arg_459_1.time_ <= var_462_6 + arg_462_0 then
				arg_459_1.talkMaxDuration = 0
				arg_459_1.dialogCg_.alpha = 1

				arg_459_1.dialog_:SetActive(true)
				SetActive(arg_459_1.leftNameGo_, true)

				local var_462_8 = arg_459_1:FormatText(StoryNameCfg[7].name)

				arg_459_1.leftNameTxt_.text = var_462_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_459_1.leftNameTxt_.transform)

				arg_459_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_459_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_459_1:RecordName(arg_459_1.leftNameTxt_.text)
				SetActive(arg_459_1.iconTrs_.gameObject, true)
				arg_459_1.iconController_:SetSelectedState("hero")

				arg_459_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_459_1.callingController_:SetSelectedState("normal")

				arg_459_1.keyicon_.color = Color.New(1, 1, 1)
				arg_459_1.icon_.color = Color.New(1, 1, 1)

				local var_462_9 = arg_459_1:GetWordFromCfg(1109302115)
				local var_462_10 = arg_459_1:FormatText(var_462_9.content)

				arg_459_1.text_.text = var_462_10

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.text_)

				local var_462_11 = 5
				local var_462_12 = utf8.len(var_462_10)
				local var_462_13 = var_462_11 <= 0 and var_462_7 or var_462_7 * (var_462_12 / var_462_11)

				if var_462_13 > 0 and var_462_7 < var_462_13 then
					arg_459_1.talkMaxDuration = var_462_13

					if var_462_13 + var_462_6 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_13 + var_462_6
					end
				end

				arg_459_1.text_.text = var_462_10
				arg_459_1.typewritter.percent = 0

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(false)
				arg_459_1:RecordContent(arg_459_1.text_.text)
			end

			local var_462_14 = math.max(var_462_7, arg_459_1.talkMaxDuration)

			if var_462_6 <= arg_459_1.time_ and arg_459_1.time_ < var_462_6 + var_462_14 then
				arg_459_1.typewritter.percent = (arg_459_1.time_ - var_462_6) / var_462_14

				arg_459_1.typewritter:SetDirty()
			end

			if arg_459_1.time_ >= var_462_6 + var_462_14 and arg_459_1.time_ < var_462_6 + var_462_14 + arg_462_0 then
				arg_459_1.typewritter.percent = 1

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(true)
			end
		end

		arg_459_1.nodeConfigList_ = {}

		arg_459_1:InitPlayNodeList()
	end,
	Play1109302116 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 1109302116
		arg_463_1.duration_ = 5

		SetActive(arg_463_1.tipsGo_, false)

		function arg_463_1.onSingleLineFinish_()
			arg_463_1.onSingleLineUpdate_ = nil
			arg_463_1.onSingleLineFinish_ = nil
			arg_463_1.state_ = "waiting"
		end

		function arg_463_1.playNext_(arg_465_0)
			if arg_465_0 == 1 then
				arg_463_0:Play1109302117(arg_463_1)
			end
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			local var_466_0 = arg_463_1.actors_["1050ui_story"].transform
			local var_466_1 = 0

			if var_466_1 < arg_463_1.time_ and arg_463_1.time_ <= var_466_1 + arg_466_0 then
				arg_463_1.var_.moveOldPos1050ui_story = var_466_0.localPosition
			end

			local var_466_2 = 0.001

			if var_466_1 <= arg_463_1.time_ and arg_463_1.time_ < var_466_1 + var_466_2 then
				local var_466_3 = (arg_463_1.time_ - var_466_1) / var_466_2
				local var_466_4 = Vector3.New(0, 100, 0)

				var_466_0.localPosition = Vector3.Lerp(arg_463_1.var_.moveOldPos1050ui_story, var_466_4, var_466_3)

				local var_466_5 = manager.ui.mainCamera.transform.position - var_466_0.position

				var_466_0.forward = Vector3.New(var_466_5.x, var_466_5.y, var_466_5.z)

				local var_466_6 = var_466_0.localEulerAngles

				var_466_6.z = 0
				var_466_6.x = 0
				var_466_0.localEulerAngles = var_466_6
			end

			if arg_463_1.time_ >= var_466_1 + var_466_2 and arg_463_1.time_ < var_466_1 + var_466_2 + arg_466_0 then
				var_466_0.localPosition = Vector3.New(0, 100, 0)

				local var_466_7 = manager.ui.mainCamera.transform.position - var_466_0.position

				var_466_0.forward = Vector3.New(var_466_7.x, var_466_7.y, var_466_7.z)

				local var_466_8 = var_466_0.localEulerAngles

				var_466_8.z = 0
				var_466_8.x = 0
				var_466_0.localEulerAngles = var_466_8
			end

			local var_466_9 = 0
			local var_466_10 = 1

			if var_466_9 < arg_463_1.time_ and arg_463_1.time_ <= var_466_9 + arg_466_0 then
				local var_466_11 = "play"
				local var_466_12 = "effect"

				arg_463_1:AudioAction(var_466_11, var_466_12, "se_story_side_1093", "se_story_1093_message_calling", "")
			end

			local var_466_13 = 0
			local var_466_14 = 0.525

			if var_466_13 < arg_463_1.time_ and arg_463_1.time_ <= var_466_13 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0
				arg_463_1.dialogCg_.alpha = 1

				arg_463_1.dialog_:SetActive(true)
				SetActive(arg_463_1.leftNameGo_, false)

				arg_463_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_463_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_463_1:RecordName(arg_463_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_463_1.iconTrs_.gameObject, false)
				arg_463_1.callingController_:SetSelectedState("normal")

				local var_466_15 = arg_463_1:GetWordFromCfg(1109302116)
				local var_466_16 = arg_463_1:FormatText(var_466_15.content)

				arg_463_1.text_.text = var_466_16

				LuaForUtil.ClearLinePrefixSymbol(arg_463_1.text_)

				local var_466_17 = 20
				local var_466_18 = utf8.len(var_466_16)
				local var_466_19 = var_466_17 <= 0 and var_466_14 or var_466_14 * (var_466_18 / var_466_17)

				if var_466_19 > 0 and var_466_14 < var_466_19 then
					arg_463_1.talkMaxDuration = var_466_19

					if var_466_19 + var_466_13 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_19 + var_466_13
					end
				end

				arg_463_1.text_.text = var_466_16
				arg_463_1.typewritter.percent = 0

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(false)
				arg_463_1:RecordContent(arg_463_1.text_.text)
			end

			local var_466_20 = math.max(var_466_14, arg_463_1.talkMaxDuration)

			if var_466_13 <= arg_463_1.time_ and arg_463_1.time_ < var_466_13 + var_466_20 then
				arg_463_1.typewritter.percent = (arg_463_1.time_ - var_466_13) / var_466_20

				arg_463_1.typewritter:SetDirty()
			end

			if arg_463_1.time_ >= var_466_13 + var_466_20 and arg_463_1.time_ < var_466_13 + var_466_20 + arg_466_0 then
				arg_463_1.typewritter.percent = 1

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(true)
			end
		end

		arg_463_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_463_1:InitPlayNodeList()
	end,
	Play1109302117 = function(arg_467_0, arg_467_1)
		arg_467_1.time_ = 0
		arg_467_1.frameCnt_ = 0
		arg_467_1.state_ = "playing"
		arg_467_1.curTalkId_ = 1109302117
		arg_467_1.duration_ = 5

		SetActive(arg_467_1.tipsGo_, false)

		function arg_467_1.onSingleLineFinish_()
			arg_467_1.onSingleLineUpdate_ = nil
			arg_467_1.onSingleLineFinish_ = nil
			arg_467_1.state_ = "waiting"
		end

		function arg_467_1.playNext_(arg_469_0)
			if arg_469_0 == 1 then
				arg_467_0:Play1109302118(arg_467_1)
			end
		end

		function arg_467_1.onSingleLineUpdate_(arg_470_0)
			local var_470_0 = 0
			local var_470_1 = 1

			if var_470_0 < arg_467_1.time_ and arg_467_1.time_ <= var_470_0 + arg_470_0 then
				local var_470_2 = "play"
				local var_470_3 = "music"

				arg_467_1:AudioAction(var_470_2, var_470_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_470_4 = ""
				local var_470_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_470_5 ~= "" then
					if arg_467_1.bgmTxt_.text ~= var_470_5 and arg_467_1.bgmTxt_.text ~= "" then
						if arg_467_1.bgmTxt2_.text ~= "" then
							arg_467_1.bgmTxt_.text = arg_467_1.bgmTxt2_.text
						end

						arg_467_1.bgmTxt2_.text = var_470_5

						arg_467_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_467_1.bgmTxt_.text = var_470_5
						arg_467_1.bgmTxt2_.text = var_470_5
					end

					if arg_467_1.bgmTimer then
						arg_467_1.bgmTimer:Stop()

						arg_467_1.bgmTimer = nil
					end

					if arg_467_1.settingData.show_music_name == 1 then
						arg_467_1.musicController:SetSelectedState("show")
						arg_467_1.musicAnimator_:Play("open", 0, 0)

						if arg_467_1.settingData.music_time ~= 0 then
							arg_467_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_467_1.settingData.music_time), function()
								if arg_467_1 == nil or isNil(arg_467_1.bgmTxt_) then
									return
								end

								arg_467_1.musicController:SetSelectedState("hide")
								arg_467_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_470_6 = 0
			local var_470_7 = 0.725

			if var_470_6 < arg_467_1.time_ and arg_467_1.time_ <= var_470_6 + arg_470_0 then
				arg_467_1.talkMaxDuration = 0
				arg_467_1.dialogCg_.alpha = 1

				arg_467_1.dialog_:SetActive(true)
				SetActive(arg_467_1.leftNameGo_, false)

				arg_467_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_467_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_467_1:RecordName(arg_467_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_467_1.iconTrs_.gameObject, false)
				arg_467_1.callingController_:SetSelectedState("normal")

				local var_470_8 = arg_467_1:GetWordFromCfg(1109302117)
				local var_470_9 = arg_467_1:FormatText(var_470_8.content)

				arg_467_1.text_.text = var_470_9

				LuaForUtil.ClearLinePrefixSymbol(arg_467_1.text_)

				local var_470_10 = 29
				local var_470_11 = utf8.len(var_470_9)
				local var_470_12 = var_470_10 <= 0 and var_470_7 or var_470_7 * (var_470_11 / var_470_10)

				if var_470_12 > 0 and var_470_7 < var_470_12 then
					arg_467_1.talkMaxDuration = var_470_12

					if var_470_12 + var_470_6 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_12 + var_470_6
					end
				end

				arg_467_1.text_.text = var_470_9
				arg_467_1.typewritter.percent = 0

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(false)
				arg_467_1:RecordContent(arg_467_1.text_.text)
			end

			local var_470_13 = math.max(var_470_7, arg_467_1.talkMaxDuration)

			if var_470_6 <= arg_467_1.time_ and arg_467_1.time_ < var_470_6 + var_470_13 then
				arg_467_1.typewritter.percent = (arg_467_1.time_ - var_470_6) / var_470_13

				arg_467_1.typewritter:SetDirty()
			end

			if arg_467_1.time_ >= var_470_6 + var_470_13 and arg_467_1.time_ < var_470_6 + var_470_13 + arg_470_0 then
				arg_467_1.typewritter.percent = 1

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(true)
			end
		end

		arg_467_1.nodeConfigList_ = {}

		arg_467_1:InitPlayNodeList()
	end,
	Play1109302118 = function(arg_472_0, arg_472_1)
		arg_472_1.time_ = 0
		arg_472_1.frameCnt_ = 0
		arg_472_1.state_ = "playing"
		arg_472_1.curTalkId_ = 1109302118
		arg_472_1.duration_ = 5

		SetActive(arg_472_1.tipsGo_, false)

		function arg_472_1.onSingleLineFinish_()
			arg_472_1.onSingleLineUpdate_ = nil
			arg_472_1.onSingleLineFinish_ = nil
			arg_472_1.state_ = "waiting"
		end

		function arg_472_1.playNext_(arg_474_0)
			if arg_474_0 == 1 then
				arg_472_0:Play1109302119(arg_472_1)
			end
		end

		function arg_472_1.onSingleLineUpdate_(arg_475_0)
			local var_475_0 = 0
			local var_475_1 = 0.125

			if var_475_0 < arg_472_1.time_ and arg_472_1.time_ <= var_475_0 + arg_475_0 then
				arg_472_1.talkMaxDuration = 0
				arg_472_1.dialogCg_.alpha = 1

				arg_472_1.dialog_:SetActive(true)
				SetActive(arg_472_1.leftNameGo_, true)

				local var_475_2 = arg_472_1:FormatText(StoryNameCfg[7].name)

				arg_472_1.leftNameTxt_.text = var_475_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_472_1.leftNameTxt_.transform)

				arg_472_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_472_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_472_1:RecordName(arg_472_1.leftNameTxt_.text)
				SetActive(arg_472_1.iconTrs_.gameObject, true)
				arg_472_1.iconController_:SetSelectedState("hero")

				arg_472_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_472_1.callingController_:SetSelectedState("normal")

				arg_472_1.keyicon_.color = Color.New(1, 1, 1)
				arg_472_1.icon_.color = Color.New(1, 1, 1)

				local var_475_3 = arg_472_1:GetWordFromCfg(1109302118)
				local var_475_4 = arg_472_1:FormatText(var_475_3.content)

				arg_472_1.text_.text = var_475_4

				LuaForUtil.ClearLinePrefixSymbol(arg_472_1.text_)

				local var_475_5 = 5
				local var_475_6 = utf8.len(var_475_4)
				local var_475_7 = var_475_5 <= 0 and var_475_1 or var_475_1 * (var_475_6 / var_475_5)

				if var_475_7 > 0 and var_475_1 < var_475_7 then
					arg_472_1.talkMaxDuration = var_475_7

					if var_475_7 + var_475_0 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_7 + var_475_0
					end
				end

				arg_472_1.text_.text = var_475_4
				arg_472_1.typewritter.percent = 0

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(false)
				arg_472_1:RecordContent(arg_472_1.text_.text)
			end

			local var_475_8 = math.max(var_475_1, arg_472_1.talkMaxDuration)

			if var_475_0 <= arg_472_1.time_ and arg_472_1.time_ < var_475_0 + var_475_8 then
				arg_472_1.typewritter.percent = (arg_472_1.time_ - var_475_0) / var_475_8

				arg_472_1.typewritter:SetDirty()
			end

			if arg_472_1.time_ >= var_475_0 + var_475_8 and arg_472_1.time_ < var_475_0 + var_475_8 + arg_475_0 then
				arg_472_1.typewritter.percent = 1

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(true)
			end
		end

		arg_472_1.nodeConfigList_ = {}

		arg_472_1:InitPlayNodeList()
	end,
	Play1109302119 = function(arg_476_0, arg_476_1)
		arg_476_1.time_ = 0
		arg_476_1.frameCnt_ = 0
		arg_476_1.state_ = "playing"
		arg_476_1.curTalkId_ = 1109302119
		arg_476_1.duration_ = 2.57

		SetActive(arg_476_1.tipsGo_, false)

		function arg_476_1.onSingleLineFinish_()
			arg_476_1.onSingleLineUpdate_ = nil
			arg_476_1.onSingleLineFinish_ = nil
			arg_476_1.state_ = "waiting"
		end

		function arg_476_1.playNext_(arg_478_0)
			if arg_478_0 == 1 then
				arg_476_0:Play1109302120(arg_476_1)
			end
		end

		function arg_476_1.onSingleLineUpdate_(arg_479_0)
			local var_479_0 = 0
			local var_479_1 = 0.275

			if var_479_0 < arg_476_1.time_ and arg_476_1.time_ <= var_479_0 + arg_479_0 then
				arg_476_1.talkMaxDuration = 0
				arg_476_1.dialogCg_.alpha = 1

				arg_476_1.dialog_:SetActive(true)
				SetActive(arg_476_1.leftNameGo_, true)

				local var_479_2 = arg_476_1:FormatText(StoryNameCfg[84].name)

				arg_476_1.leftNameTxt_.text = var_479_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_476_1.leftNameTxt_.transform)

				arg_476_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_476_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_476_1:RecordName(arg_476_1.leftNameTxt_.text)
				SetActive(arg_476_1.iconTrs_.gameObject, true)
				arg_476_1.iconController_:SetSelectedState("hero")

				arg_476_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1199")

				arg_476_1.callingController_:SetSelectedState("normal")

				arg_476_1.keyicon_.color = Color.New(1, 1, 1)
				arg_476_1.icon_.color = Color.New(1, 1, 1)

				local var_479_3 = arg_476_1:GetWordFromCfg(1109302119)
				local var_479_4 = arg_476_1:FormatText(var_479_3.content)

				arg_476_1.text_.text = var_479_4

				LuaForUtil.ClearLinePrefixSymbol(arg_476_1.text_)

				local var_479_5 = 11
				local var_479_6 = utf8.len(var_479_4)
				local var_479_7 = var_479_5 <= 0 and var_479_1 or var_479_1 * (var_479_6 / var_479_5)

				if var_479_7 > 0 and var_479_1 < var_479_7 then
					arg_476_1.talkMaxDuration = var_479_7

					if var_479_7 + var_479_0 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_7 + var_479_0
					end
				end

				arg_476_1.text_.text = var_479_4
				arg_476_1.typewritter.percent = 0

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302119", "story_v_side_new_1109302.awb") ~= 0 then
					local var_479_8 = manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302119", "story_v_side_new_1109302.awb") / 1000

					if var_479_8 + var_479_0 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_8 + var_479_0
					end

					if var_479_3.prefab_name ~= "" and arg_476_1.actors_[var_479_3.prefab_name] ~= nil then
						local var_479_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_476_1.actors_[var_479_3.prefab_name].transform, "story_v_side_new_1109302", "1109302119", "story_v_side_new_1109302.awb")

						arg_476_1:RecordAudio("1109302119", var_479_9)
						arg_476_1:RecordAudio("1109302119", var_479_9)
					else
						arg_476_1:AudioAction("play", "voice", "story_v_side_new_1109302", "1109302119", "story_v_side_new_1109302.awb")
					end

					arg_476_1:RecordHistoryTalkVoice("story_v_side_new_1109302", "1109302119", "story_v_side_new_1109302.awb")
				end

				arg_476_1:RecordContent(arg_476_1.text_.text)
			end

			local var_479_10 = math.max(var_479_1, arg_476_1.talkMaxDuration)

			if var_479_0 <= arg_476_1.time_ and arg_476_1.time_ < var_479_0 + var_479_10 then
				arg_476_1.typewritter.percent = (arg_476_1.time_ - var_479_0) / var_479_10

				arg_476_1.typewritter:SetDirty()
			end

			if arg_476_1.time_ >= var_479_0 + var_479_10 and arg_476_1.time_ < var_479_0 + var_479_10 + arg_479_0 then
				arg_476_1.typewritter.percent = 1

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(true)
			end
		end

		arg_476_1.nodeConfigList_ = {}

		arg_476_1:InitPlayNodeList()
	end,
	Play1109302120 = function(arg_480_0, arg_480_1)
		arg_480_1.time_ = 0
		arg_480_1.frameCnt_ = 0
		arg_480_1.state_ = "playing"
		arg_480_1.curTalkId_ = 1109302120
		arg_480_1.duration_ = 5

		SetActive(arg_480_1.tipsGo_, false)

		function arg_480_1.onSingleLineFinish_()
			arg_480_1.onSingleLineUpdate_ = nil
			arg_480_1.onSingleLineFinish_ = nil
			arg_480_1.state_ = "waiting"
		end

		function arg_480_1.playNext_(arg_482_0)
			if arg_482_0 == 1 then
				arg_480_0:Play1109302121(arg_480_1)
			end
		end

		function arg_480_1.onSingleLineUpdate_(arg_483_0)
			local var_483_0 = 0
			local var_483_1 = 0.275

			if var_483_0 < arg_480_1.time_ and arg_480_1.time_ <= var_483_0 + arg_483_0 then
				arg_480_1.talkMaxDuration = 0
				arg_480_1.dialogCg_.alpha = 1

				arg_480_1.dialog_:SetActive(true)
				SetActive(arg_480_1.leftNameGo_, true)

				local var_483_2 = arg_480_1:FormatText(StoryNameCfg[7].name)

				arg_480_1.leftNameTxt_.text = var_483_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_480_1.leftNameTxt_.transform)

				arg_480_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_480_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_480_1:RecordName(arg_480_1.leftNameTxt_.text)
				SetActive(arg_480_1.iconTrs_.gameObject, true)
				arg_480_1.iconController_:SetSelectedState("hero")

				arg_480_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_480_1.callingController_:SetSelectedState("normal")

				arg_480_1.keyicon_.color = Color.New(1, 1, 1)
				arg_480_1.icon_.color = Color.New(1, 1, 1)

				local var_483_3 = arg_480_1:GetWordFromCfg(1109302120)
				local var_483_4 = arg_480_1:FormatText(var_483_3.content)

				arg_480_1.text_.text = var_483_4

				LuaForUtil.ClearLinePrefixSymbol(arg_480_1.text_)

				local var_483_5 = 11
				local var_483_6 = utf8.len(var_483_4)
				local var_483_7 = var_483_5 <= 0 and var_483_1 or var_483_1 * (var_483_6 / var_483_5)

				if var_483_7 > 0 and var_483_1 < var_483_7 then
					arg_480_1.talkMaxDuration = var_483_7

					if var_483_7 + var_483_0 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_7 + var_483_0
					end
				end

				arg_480_1.text_.text = var_483_4
				arg_480_1.typewritter.percent = 0

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(false)
				arg_480_1:RecordContent(arg_480_1.text_.text)
			end

			local var_483_8 = math.max(var_483_1, arg_480_1.talkMaxDuration)

			if var_483_0 <= arg_480_1.time_ and arg_480_1.time_ < var_483_0 + var_483_8 then
				arg_480_1.typewritter.percent = (arg_480_1.time_ - var_483_0) / var_483_8

				arg_480_1.typewritter:SetDirty()
			end

			if arg_480_1.time_ >= var_483_0 + var_483_8 and arg_480_1.time_ < var_483_0 + var_483_8 + arg_483_0 then
				arg_480_1.typewritter.percent = 1

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(true)
			end
		end

		arg_480_1.nodeConfigList_ = {}

		arg_480_1:InitPlayNodeList()
	end,
	Play1109302121 = function(arg_484_0, arg_484_1)
		arg_484_1.time_ = 0
		arg_484_1.frameCnt_ = 0
		arg_484_1.state_ = "playing"
		arg_484_1.curTalkId_ = 1109302121
		arg_484_1.duration_ = 4.27

		SetActive(arg_484_1.tipsGo_, false)

		function arg_484_1.onSingleLineFinish_()
			arg_484_1.onSingleLineUpdate_ = nil
			arg_484_1.onSingleLineFinish_ = nil
			arg_484_1.state_ = "waiting"
		end

		function arg_484_1.playNext_(arg_486_0)
			if arg_486_0 == 1 then
				arg_484_0:Play1109302122(arg_484_1)
			end
		end

		function arg_484_1.onSingleLineUpdate_(arg_487_0)
			local var_487_0 = 0
			local var_487_1 = 0.1

			if var_487_0 < arg_484_1.time_ and arg_484_1.time_ <= var_487_0 + arg_487_0 then
				arg_484_1.talkMaxDuration = 0
				arg_484_1.dialogCg_.alpha = 1

				arg_484_1.dialog_:SetActive(true)
				SetActive(arg_484_1.leftNameGo_, true)

				local var_487_2 = arg_484_1:FormatText(StoryNameCfg[84].name)

				arg_484_1.leftNameTxt_.text = var_487_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_484_1.leftNameTxt_.transform)

				arg_484_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_484_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_484_1:RecordName(arg_484_1.leftNameTxt_.text)
				SetActive(arg_484_1.iconTrs_.gameObject, true)
				arg_484_1.iconController_:SetSelectedState("hero")

				arg_484_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1199")

				arg_484_1.callingController_:SetSelectedState("normal")

				arg_484_1.keyicon_.color = Color.New(1, 1, 1)
				arg_484_1.icon_.color = Color.New(1, 1, 1)

				local var_487_3 = arg_484_1:GetWordFromCfg(1109302121)
				local var_487_4 = arg_484_1:FormatText(var_487_3.content)

				arg_484_1.text_.text = var_487_4

				LuaForUtil.ClearLinePrefixSymbol(arg_484_1.text_)

				local var_487_5 = 4
				local var_487_6 = utf8.len(var_487_4)
				local var_487_7 = var_487_5 <= 0 and var_487_1 or var_487_1 * (var_487_6 / var_487_5)

				if var_487_7 > 0 and var_487_1 < var_487_7 then
					arg_484_1.talkMaxDuration = var_487_7

					if var_487_7 + var_487_0 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_7 + var_487_0
					end
				end

				arg_484_1.text_.text = var_487_4
				arg_484_1.typewritter.percent = 0

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302121", "story_v_side_new_1109302.awb") ~= 0 then
					local var_487_8 = manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302121", "story_v_side_new_1109302.awb") / 1000

					if var_487_8 + var_487_0 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_8 + var_487_0
					end

					if var_487_3.prefab_name ~= "" and arg_484_1.actors_[var_487_3.prefab_name] ~= nil then
						local var_487_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_484_1.actors_[var_487_3.prefab_name].transform, "story_v_side_new_1109302", "1109302121", "story_v_side_new_1109302.awb")

						arg_484_1:RecordAudio("1109302121", var_487_9)
						arg_484_1:RecordAudio("1109302121", var_487_9)
					else
						arg_484_1:AudioAction("play", "voice", "story_v_side_new_1109302", "1109302121", "story_v_side_new_1109302.awb")
					end

					arg_484_1:RecordHistoryTalkVoice("story_v_side_new_1109302", "1109302121", "story_v_side_new_1109302.awb")
				end

				arg_484_1:RecordContent(arg_484_1.text_.text)
			end

			local var_487_10 = math.max(var_487_1, arg_484_1.talkMaxDuration)

			if var_487_0 <= arg_484_1.time_ and arg_484_1.time_ < var_487_0 + var_487_10 then
				arg_484_1.typewritter.percent = (arg_484_1.time_ - var_487_0) / var_487_10

				arg_484_1.typewritter:SetDirty()
			end

			if arg_484_1.time_ >= var_487_0 + var_487_10 and arg_484_1.time_ < var_487_0 + var_487_10 + arg_487_0 then
				arg_484_1.typewritter.percent = 1

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(true)
			end
		end

		arg_484_1.nodeConfigList_ = {}

		arg_484_1:InitPlayNodeList()
	end,
	Play1109302122 = function(arg_488_0, arg_488_1)
		arg_488_1.time_ = 0
		arg_488_1.frameCnt_ = 0
		arg_488_1.state_ = "playing"
		arg_488_1.curTalkId_ = 1109302122
		arg_488_1.duration_ = 5.2

		SetActive(arg_488_1.tipsGo_, false)

		function arg_488_1.onSingleLineFinish_()
			arg_488_1.onSingleLineUpdate_ = nil
			arg_488_1.onSingleLineFinish_ = nil
			arg_488_1.state_ = "waiting"
		end

		function arg_488_1.playNext_(arg_490_0)
			if arg_490_0 == 1 then
				arg_488_0:Play1109302123(arg_488_1)
			end
		end

		function arg_488_1.onSingleLineUpdate_(arg_491_0)
			local var_491_0 = 0
			local var_491_1 = 0.525

			if var_491_0 < arg_488_1.time_ and arg_488_1.time_ <= var_491_0 + arg_491_0 then
				arg_488_1.talkMaxDuration = 0
				arg_488_1.dialogCg_.alpha = 1

				arg_488_1.dialog_:SetActive(true)
				SetActive(arg_488_1.leftNameGo_, true)

				local var_491_2 = arg_488_1:FormatText(StoryNameCfg[84].name)

				arg_488_1.leftNameTxt_.text = var_491_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_488_1.leftNameTxt_.transform)

				arg_488_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_488_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_488_1:RecordName(arg_488_1.leftNameTxt_.text)
				SetActive(arg_488_1.iconTrs_.gameObject, true)
				arg_488_1.iconController_:SetSelectedState("hero")

				arg_488_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1199")

				arg_488_1.callingController_:SetSelectedState("normal")

				arg_488_1.keyicon_.color = Color.New(1, 1, 1)
				arg_488_1.icon_.color = Color.New(1, 1, 1)

				local var_491_3 = arg_488_1:GetWordFromCfg(1109302122)
				local var_491_4 = arg_488_1:FormatText(var_491_3.content)

				arg_488_1.text_.text = var_491_4

				LuaForUtil.ClearLinePrefixSymbol(arg_488_1.text_)

				local var_491_5 = 21
				local var_491_6 = utf8.len(var_491_4)
				local var_491_7 = var_491_5 <= 0 and var_491_1 or var_491_1 * (var_491_6 / var_491_5)

				if var_491_7 > 0 and var_491_1 < var_491_7 then
					arg_488_1.talkMaxDuration = var_491_7

					if var_491_7 + var_491_0 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_7 + var_491_0
					end
				end

				arg_488_1.text_.text = var_491_4
				arg_488_1.typewritter.percent = 0

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302122", "story_v_side_new_1109302.awb") ~= 0 then
					local var_491_8 = manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302122", "story_v_side_new_1109302.awb") / 1000

					if var_491_8 + var_491_0 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_8 + var_491_0
					end

					if var_491_3.prefab_name ~= "" and arg_488_1.actors_[var_491_3.prefab_name] ~= nil then
						local var_491_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_488_1.actors_[var_491_3.prefab_name].transform, "story_v_side_new_1109302", "1109302122", "story_v_side_new_1109302.awb")

						arg_488_1:RecordAudio("1109302122", var_491_9)
						arg_488_1:RecordAudio("1109302122", var_491_9)
					else
						arg_488_1:AudioAction("play", "voice", "story_v_side_new_1109302", "1109302122", "story_v_side_new_1109302.awb")
					end

					arg_488_1:RecordHistoryTalkVoice("story_v_side_new_1109302", "1109302122", "story_v_side_new_1109302.awb")
				end

				arg_488_1:RecordContent(arg_488_1.text_.text)
			end

			local var_491_10 = math.max(var_491_1, arg_488_1.talkMaxDuration)

			if var_491_0 <= arg_488_1.time_ and arg_488_1.time_ < var_491_0 + var_491_10 then
				arg_488_1.typewritter.percent = (arg_488_1.time_ - var_491_0) / var_491_10

				arg_488_1.typewritter:SetDirty()
			end

			if arg_488_1.time_ >= var_491_0 + var_491_10 and arg_488_1.time_ < var_491_0 + var_491_10 + arg_491_0 then
				arg_488_1.typewritter.percent = 1

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(true)
			end
		end

		arg_488_1.nodeConfigList_ = {}

		arg_488_1:InitPlayNodeList()
	end,
	Play1109302123 = function(arg_492_0, arg_492_1)
		arg_492_1.time_ = 0
		arg_492_1.frameCnt_ = 0
		arg_492_1.state_ = "playing"
		arg_492_1.curTalkId_ = 1109302123
		arg_492_1.duration_ = 2.37

		SetActive(arg_492_1.tipsGo_, false)

		function arg_492_1.onSingleLineFinish_()
			arg_492_1.onSingleLineUpdate_ = nil
			arg_492_1.onSingleLineFinish_ = nil
			arg_492_1.state_ = "waiting"
		end

		function arg_492_1.playNext_(arg_494_0)
			if arg_494_0 == 1 then
				arg_492_0:Play1109302124(arg_492_1)
			end
		end

		function arg_492_1.onSingleLineUpdate_(arg_495_0)
			local var_495_0 = arg_492_1.actors_["1050ui_story"].transform
			local var_495_1 = 0

			if var_495_1 < arg_492_1.time_ and arg_492_1.time_ <= var_495_1 + arg_495_0 then
				arg_492_1.var_.moveOldPos1050ui_story = var_495_0.localPosition
			end

			local var_495_2 = 0.001

			if var_495_1 <= arg_492_1.time_ and arg_492_1.time_ < var_495_1 + var_495_2 then
				local var_495_3 = (arg_492_1.time_ - var_495_1) / var_495_2
				local var_495_4 = Vector3.New(0, -1, -6.1)

				var_495_0.localPosition = Vector3.Lerp(arg_492_1.var_.moveOldPos1050ui_story, var_495_4, var_495_3)

				local var_495_5 = manager.ui.mainCamera.transform.position - var_495_0.position

				var_495_0.forward = Vector3.New(var_495_5.x, var_495_5.y, var_495_5.z)

				local var_495_6 = var_495_0.localEulerAngles

				var_495_6.z = 0
				var_495_6.x = 0
				var_495_0.localEulerAngles = var_495_6
			end

			if arg_492_1.time_ >= var_495_1 + var_495_2 and arg_492_1.time_ < var_495_1 + var_495_2 + arg_495_0 then
				var_495_0.localPosition = Vector3.New(0, -1, -6.1)

				local var_495_7 = manager.ui.mainCamera.transform.position - var_495_0.position

				var_495_0.forward = Vector3.New(var_495_7.x, var_495_7.y, var_495_7.z)

				local var_495_8 = var_495_0.localEulerAngles

				var_495_8.z = 0
				var_495_8.x = 0
				var_495_0.localEulerAngles = var_495_8
			end

			local var_495_9 = arg_492_1.actors_["1050ui_story"]
			local var_495_10 = 0

			if var_495_10 < arg_492_1.time_ and arg_492_1.time_ <= var_495_10 + arg_495_0 and not isNil(var_495_9) and arg_492_1.var_.characterEffect1050ui_story == nil then
				arg_492_1.var_.characterEffect1050ui_story = var_495_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_495_11 = 0.2

			if var_495_10 <= arg_492_1.time_ and arg_492_1.time_ < var_495_10 + var_495_11 and not isNil(var_495_9) then
				local var_495_12 = (arg_492_1.time_ - var_495_10) / var_495_11

				if arg_492_1.var_.characterEffect1050ui_story and not isNil(var_495_9) then
					arg_492_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_492_1.time_ >= var_495_10 + var_495_11 and arg_492_1.time_ < var_495_10 + var_495_11 + arg_495_0 and not isNil(var_495_9) and arg_492_1.var_.characterEffect1050ui_story then
				arg_492_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_495_13 = 0

			if var_495_13 < arg_492_1.time_ and arg_492_1.time_ <= var_495_13 + arg_495_0 then
				arg_492_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action3_1")
			end

			local var_495_14 = 0

			if var_495_14 < arg_492_1.time_ and arg_492_1.time_ <= var_495_14 + arg_495_0 then
				arg_492_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_495_15 = 0
			local var_495_16 = 0.325

			if var_495_15 < arg_492_1.time_ and arg_492_1.time_ <= var_495_15 + arg_495_0 then
				arg_492_1.talkMaxDuration = 0
				arg_492_1.dialogCg_.alpha = 1

				arg_492_1.dialog_:SetActive(true)
				SetActive(arg_492_1.leftNameGo_, true)

				local var_495_17 = arg_492_1:FormatText(StoryNameCfg[374].name)

				arg_492_1.leftNameTxt_.text = var_495_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_492_1.leftNameTxt_.transform)

				arg_492_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_492_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_492_1:RecordName(arg_492_1.leftNameTxt_.text)
				SetActive(arg_492_1.iconTrs_.gameObject, false)
				arg_492_1.callingController_:SetSelectedState("normal")

				local var_495_18 = arg_492_1:GetWordFromCfg(1109302123)
				local var_495_19 = arg_492_1:FormatText(var_495_18.content)

				arg_492_1.text_.text = var_495_19

				LuaForUtil.ClearLinePrefixSymbol(arg_492_1.text_)

				local var_495_20 = 12
				local var_495_21 = utf8.len(var_495_19)
				local var_495_22 = var_495_20 <= 0 and var_495_16 or var_495_16 * (var_495_21 / var_495_20)

				if var_495_22 > 0 and var_495_16 < var_495_22 then
					arg_492_1.talkMaxDuration = var_495_22

					if var_495_22 + var_495_15 > arg_492_1.duration_ then
						arg_492_1.duration_ = var_495_22 + var_495_15
					end
				end

				arg_492_1.text_.text = var_495_19
				arg_492_1.typewritter.percent = 0

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302123", "story_v_side_new_1109302.awb") ~= 0 then
					local var_495_23 = manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302123", "story_v_side_new_1109302.awb") / 1000

					if var_495_23 + var_495_15 > arg_492_1.duration_ then
						arg_492_1.duration_ = var_495_23 + var_495_15
					end

					if var_495_18.prefab_name ~= "" and arg_492_1.actors_[var_495_18.prefab_name] ~= nil then
						local var_495_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_492_1.actors_[var_495_18.prefab_name].transform, "story_v_side_new_1109302", "1109302123", "story_v_side_new_1109302.awb")

						arg_492_1:RecordAudio("1109302123", var_495_24)
						arg_492_1:RecordAudio("1109302123", var_495_24)
					else
						arg_492_1:AudioAction("play", "voice", "story_v_side_new_1109302", "1109302123", "story_v_side_new_1109302.awb")
					end

					arg_492_1:RecordHistoryTalkVoice("story_v_side_new_1109302", "1109302123", "story_v_side_new_1109302.awb")
				end

				arg_492_1:RecordContent(arg_492_1.text_.text)
			end

			local var_495_25 = math.max(var_495_16, arg_492_1.talkMaxDuration)

			if var_495_15 <= arg_492_1.time_ and arg_492_1.time_ < var_495_15 + var_495_25 then
				arg_492_1.typewritter.percent = (arg_492_1.time_ - var_495_15) / var_495_25

				arg_492_1.typewritter:SetDirty()
			end

			if arg_492_1.time_ >= var_495_15 + var_495_25 and arg_492_1.time_ < var_495_15 + var_495_25 + arg_495_0 then
				arg_492_1.typewritter.percent = 1

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(true)
			end
		end

		arg_492_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_492_1:InitPlayNodeList()
	end,
	Play1109302124 = function(arg_496_0, arg_496_1)
		arg_496_1.time_ = 0
		arg_496_1.frameCnt_ = 0
		arg_496_1.state_ = "playing"
		arg_496_1.curTalkId_ = 1109302124
		arg_496_1.duration_ = 4.87

		SetActive(arg_496_1.tipsGo_, false)

		function arg_496_1.onSingleLineFinish_()
			arg_496_1.onSingleLineUpdate_ = nil
			arg_496_1.onSingleLineFinish_ = nil
			arg_496_1.state_ = "waiting"
		end

		function arg_496_1.playNext_(arg_498_0)
			if arg_498_0 == 1 then
				arg_496_0:Play1109302125(arg_496_1)
			end
		end

		function arg_496_1.onSingleLineUpdate_(arg_499_0)
			local var_499_0 = 0
			local var_499_1 = 0.3

			if var_499_0 < arg_496_1.time_ and arg_496_1.time_ <= var_499_0 + arg_499_0 then
				arg_496_1.talkMaxDuration = 0
				arg_496_1.dialogCg_.alpha = 1

				arg_496_1.dialog_:SetActive(true)
				SetActive(arg_496_1.leftNameGo_, true)

				local var_499_2 = arg_496_1:FormatText(StoryNameCfg[74].name)

				arg_496_1.leftNameTxt_.text = var_499_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_496_1.leftNameTxt_.transform)

				arg_496_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_496_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_496_1:RecordName(arg_496_1.leftNameTxt_.text)
				SetActive(arg_496_1.iconTrs_.gameObject, false)
				arg_496_1.callingController_:SetSelectedState("normal")

				local var_499_3 = arg_496_1:GetWordFromCfg(1109302124)
				local var_499_4 = arg_496_1:FormatText(var_499_3.content)

				arg_496_1.text_.text = var_499_4

				LuaForUtil.ClearLinePrefixSymbol(arg_496_1.text_)

				local var_499_5 = 12
				local var_499_6 = utf8.len(var_499_4)
				local var_499_7 = var_499_5 <= 0 and var_499_1 or var_499_1 * (var_499_6 / var_499_5)

				if var_499_7 > 0 and var_499_1 < var_499_7 then
					arg_496_1.talkMaxDuration = var_499_7

					if var_499_7 + var_499_0 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_7 + var_499_0
					end
				end

				arg_496_1.text_.text = var_499_4
				arg_496_1.typewritter.percent = 0

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302124", "story_v_side_new_1109302.awb") ~= 0 then
					local var_499_8 = manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302124", "story_v_side_new_1109302.awb") / 1000

					if var_499_8 + var_499_0 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_8 + var_499_0
					end

					if var_499_3.prefab_name ~= "" and arg_496_1.actors_[var_499_3.prefab_name] ~= nil then
						local var_499_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_496_1.actors_[var_499_3.prefab_name].transform, "story_v_side_new_1109302", "1109302124", "story_v_side_new_1109302.awb")

						arg_496_1:RecordAudio("1109302124", var_499_9)
						arg_496_1:RecordAudio("1109302124", var_499_9)
					else
						arg_496_1:AudioAction("play", "voice", "story_v_side_new_1109302", "1109302124", "story_v_side_new_1109302.awb")
					end

					arg_496_1:RecordHistoryTalkVoice("story_v_side_new_1109302", "1109302124", "story_v_side_new_1109302.awb")
				end

				arg_496_1:RecordContent(arg_496_1.text_.text)
			end

			local var_499_10 = math.max(var_499_1, arg_496_1.talkMaxDuration)

			if var_499_0 <= arg_496_1.time_ and arg_496_1.time_ < var_499_0 + var_499_10 then
				arg_496_1.typewritter.percent = (arg_496_1.time_ - var_499_0) / var_499_10

				arg_496_1.typewritter:SetDirty()
			end

			if arg_496_1.time_ >= var_499_0 + var_499_10 and arg_496_1.time_ < var_499_0 + var_499_10 + arg_499_0 then
				arg_496_1.typewritter.percent = 1

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(true)
			end
		end

		arg_496_1.nodeConfigList_ = {}

		arg_496_1:InitPlayNodeList()
	end,
	Play1109302125 = function(arg_500_0, arg_500_1)
		arg_500_1.time_ = 0
		arg_500_1.frameCnt_ = 0
		arg_500_1.state_ = "playing"
		arg_500_1.curTalkId_ = 1109302125
		arg_500_1.duration_ = 6.83

		SetActive(arg_500_1.tipsGo_, false)

		function arg_500_1.onSingleLineFinish_()
			arg_500_1.onSingleLineUpdate_ = nil
			arg_500_1.onSingleLineFinish_ = nil
			arg_500_1.state_ = "waiting"
		end

		function arg_500_1.playNext_(arg_502_0)
			if arg_502_0 == 1 then
				arg_500_0:Play1109302126(arg_500_1)
			end
		end

		function arg_500_1.onSingleLineUpdate_(arg_503_0)
			local var_503_0 = arg_500_1.actors_["1050ui_story"]
			local var_503_1 = 0

			if var_503_1 < arg_500_1.time_ and arg_500_1.time_ <= var_503_1 + arg_503_0 and not isNil(var_503_0) and arg_500_1.var_.characterEffect1050ui_story == nil then
				arg_500_1.var_.characterEffect1050ui_story = var_503_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_503_2 = 0.2

			if var_503_1 <= arg_500_1.time_ and arg_500_1.time_ < var_503_1 + var_503_2 and not isNil(var_503_0) then
				local var_503_3 = (arg_500_1.time_ - var_503_1) / var_503_2

				if arg_500_1.var_.characterEffect1050ui_story and not isNil(var_503_0) then
					local var_503_4 = Mathf.Lerp(0, 0.5, var_503_3)

					arg_500_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_500_1.var_.characterEffect1050ui_story.fillRatio = var_503_4
				end
			end

			if arg_500_1.time_ >= var_503_1 + var_503_2 and arg_500_1.time_ < var_503_1 + var_503_2 + arg_503_0 and not isNil(var_503_0) and arg_500_1.var_.characterEffect1050ui_story then
				local var_503_5 = 0.5

				arg_500_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_500_1.var_.characterEffect1050ui_story.fillRatio = var_503_5
			end

			local var_503_6 = 0
			local var_503_7 = 0.8

			if var_503_6 < arg_500_1.time_ and arg_500_1.time_ <= var_503_6 + arg_503_0 then
				arg_500_1.talkMaxDuration = 0
				arg_500_1.dialogCg_.alpha = 1

				arg_500_1.dialog_:SetActive(true)
				SetActive(arg_500_1.leftNameGo_, true)

				local var_503_8 = arg_500_1:FormatText(StoryNameCfg[84].name)

				arg_500_1.leftNameTxt_.text = var_503_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_500_1.leftNameTxt_.transform)

				arg_500_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_500_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_500_1:RecordName(arg_500_1.leftNameTxt_.text)
				SetActive(arg_500_1.iconTrs_.gameObject, true)
				arg_500_1.iconController_:SetSelectedState("hero")

				arg_500_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1199")

				arg_500_1.callingController_:SetSelectedState("normal")

				arg_500_1.keyicon_.color = Color.New(1, 1, 1)
				arg_500_1.icon_.color = Color.New(1, 1, 1)

				local var_503_9 = arg_500_1:GetWordFromCfg(1109302125)
				local var_503_10 = arg_500_1:FormatText(var_503_9.content)

				arg_500_1.text_.text = var_503_10

				LuaForUtil.ClearLinePrefixSymbol(arg_500_1.text_)

				local var_503_11 = 32
				local var_503_12 = utf8.len(var_503_10)
				local var_503_13 = var_503_11 <= 0 and var_503_7 or var_503_7 * (var_503_12 / var_503_11)

				if var_503_13 > 0 and var_503_7 < var_503_13 then
					arg_500_1.talkMaxDuration = var_503_13

					if var_503_13 + var_503_6 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_13 + var_503_6
					end
				end

				arg_500_1.text_.text = var_503_10
				arg_500_1.typewritter.percent = 0

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302125", "story_v_side_new_1109302.awb") ~= 0 then
					local var_503_14 = manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302125", "story_v_side_new_1109302.awb") / 1000

					if var_503_14 + var_503_6 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_14 + var_503_6
					end

					if var_503_9.prefab_name ~= "" and arg_500_1.actors_[var_503_9.prefab_name] ~= nil then
						local var_503_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_500_1.actors_[var_503_9.prefab_name].transform, "story_v_side_new_1109302", "1109302125", "story_v_side_new_1109302.awb")

						arg_500_1:RecordAudio("1109302125", var_503_15)
						arg_500_1:RecordAudio("1109302125", var_503_15)
					else
						arg_500_1:AudioAction("play", "voice", "story_v_side_new_1109302", "1109302125", "story_v_side_new_1109302.awb")
					end

					arg_500_1:RecordHistoryTalkVoice("story_v_side_new_1109302", "1109302125", "story_v_side_new_1109302.awb")
				end

				arg_500_1:RecordContent(arg_500_1.text_.text)
			end

			local var_503_16 = math.max(var_503_7, arg_500_1.talkMaxDuration)

			if var_503_6 <= arg_500_1.time_ and arg_500_1.time_ < var_503_6 + var_503_16 then
				arg_500_1.typewritter.percent = (arg_500_1.time_ - var_503_6) / var_503_16

				arg_500_1.typewritter:SetDirty()
			end

			if arg_500_1.time_ >= var_503_6 + var_503_16 and arg_500_1.time_ < var_503_6 + var_503_16 + arg_503_0 then
				arg_500_1.typewritter.percent = 1

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(true)
			end
		end

		arg_500_1.nodeConfigList_ = {}

		arg_500_1:InitPlayNodeList()
	end,
	Play1109302126 = function(arg_504_0, arg_504_1)
		arg_504_1.time_ = 0
		arg_504_1.frameCnt_ = 0
		arg_504_1.state_ = "playing"
		arg_504_1.curTalkId_ = 1109302126
		arg_504_1.duration_ = 5

		SetActive(arg_504_1.tipsGo_, false)

		function arg_504_1.onSingleLineFinish_()
			arg_504_1.onSingleLineUpdate_ = nil
			arg_504_1.onSingleLineFinish_ = nil
			arg_504_1.state_ = "waiting"
		end

		function arg_504_1.playNext_(arg_506_0)
			if arg_506_0 == 1 then
				arg_504_0:Play1109302127(arg_504_1)
			end
		end

		function arg_504_1.onSingleLineUpdate_(arg_507_0)
			local var_507_0 = 0
			local var_507_1 = 0.525

			if var_507_0 < arg_504_1.time_ and arg_504_1.time_ <= var_507_0 + arg_507_0 then
				arg_504_1.talkMaxDuration = 0
				arg_504_1.dialogCg_.alpha = 1

				arg_504_1.dialog_:SetActive(true)
				SetActive(arg_504_1.leftNameGo_, false)

				arg_504_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_504_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_504_1:RecordName(arg_504_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_504_1.iconTrs_.gameObject, false)
				arg_504_1.callingController_:SetSelectedState("normal")

				local var_507_2 = arg_504_1:GetWordFromCfg(1109302126)
				local var_507_3 = arg_504_1:FormatText(var_507_2.content)

				arg_504_1.text_.text = var_507_3

				LuaForUtil.ClearLinePrefixSymbol(arg_504_1.text_)

				local var_507_4 = 21
				local var_507_5 = utf8.len(var_507_3)
				local var_507_6 = var_507_4 <= 0 and var_507_1 or var_507_1 * (var_507_5 / var_507_4)

				if var_507_6 > 0 and var_507_1 < var_507_6 then
					arg_504_1.talkMaxDuration = var_507_6

					if var_507_6 + var_507_0 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_6 + var_507_0
					end
				end

				arg_504_1.text_.text = var_507_3
				arg_504_1.typewritter.percent = 0

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(false)
				arg_504_1:RecordContent(arg_504_1.text_.text)
			end

			local var_507_7 = math.max(var_507_1, arg_504_1.talkMaxDuration)

			if var_507_0 <= arg_504_1.time_ and arg_504_1.time_ < var_507_0 + var_507_7 then
				arg_504_1.typewritter.percent = (arg_504_1.time_ - var_507_0) / var_507_7

				arg_504_1.typewritter:SetDirty()
			end

			if arg_504_1.time_ >= var_507_0 + var_507_7 and arg_504_1.time_ < var_507_0 + var_507_7 + arg_507_0 then
				arg_504_1.typewritter.percent = 1

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(true)
			end
		end

		arg_504_1.nodeConfigList_ = {}

		arg_504_1:InitPlayNodeList()
	end,
	Play1109302127 = function(arg_508_0, arg_508_1)
		arg_508_1.time_ = 0
		arg_508_1.frameCnt_ = 0
		arg_508_1.state_ = "playing"
		arg_508_1.curTalkId_ = 1109302127
		arg_508_1.duration_ = 5

		SetActive(arg_508_1.tipsGo_, false)

		function arg_508_1.onSingleLineFinish_()
			arg_508_1.onSingleLineUpdate_ = nil
			arg_508_1.onSingleLineFinish_ = nil
			arg_508_1.state_ = "waiting"
		end

		function arg_508_1.playNext_(arg_510_0)
			if arg_510_0 == 1 then
				arg_508_0:Play1109302128(arg_508_1)
			end
		end

		function arg_508_1.onSingleLineUpdate_(arg_511_0)
			local var_511_0 = 0
			local var_511_1 = 0.25

			if var_511_0 < arg_508_1.time_ and arg_508_1.time_ <= var_511_0 + arg_511_0 then
				arg_508_1.talkMaxDuration = 0
				arg_508_1.dialogCg_.alpha = 1

				arg_508_1.dialog_:SetActive(true)
				SetActive(arg_508_1.leftNameGo_, true)

				local var_511_2 = arg_508_1:FormatText(StoryNameCfg[7].name)

				arg_508_1.leftNameTxt_.text = var_511_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_508_1.leftNameTxt_.transform)

				arg_508_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_508_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_508_1:RecordName(arg_508_1.leftNameTxt_.text)
				SetActive(arg_508_1.iconTrs_.gameObject, true)
				arg_508_1.iconController_:SetSelectedState("hero")

				arg_508_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_508_1.callingController_:SetSelectedState("normal")

				arg_508_1.keyicon_.color = Color.New(1, 1, 1)
				arg_508_1.icon_.color = Color.New(1, 1, 1)

				local var_511_3 = arg_508_1:GetWordFromCfg(1109302127)
				local var_511_4 = arg_508_1:FormatText(var_511_3.content)

				arg_508_1.text_.text = var_511_4

				LuaForUtil.ClearLinePrefixSymbol(arg_508_1.text_)

				local var_511_5 = 10
				local var_511_6 = utf8.len(var_511_4)
				local var_511_7 = var_511_5 <= 0 and var_511_1 or var_511_1 * (var_511_6 / var_511_5)

				if var_511_7 > 0 and var_511_1 < var_511_7 then
					arg_508_1.talkMaxDuration = var_511_7

					if var_511_7 + var_511_0 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_7 + var_511_0
					end
				end

				arg_508_1.text_.text = var_511_4
				arg_508_1.typewritter.percent = 0

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(false)
				arg_508_1:RecordContent(arg_508_1.text_.text)
			end

			local var_511_8 = math.max(var_511_1, arg_508_1.talkMaxDuration)

			if var_511_0 <= arg_508_1.time_ and arg_508_1.time_ < var_511_0 + var_511_8 then
				arg_508_1.typewritter.percent = (arg_508_1.time_ - var_511_0) / var_511_8

				arg_508_1.typewritter:SetDirty()
			end

			if arg_508_1.time_ >= var_511_0 + var_511_8 and arg_508_1.time_ < var_511_0 + var_511_8 + arg_511_0 then
				arg_508_1.typewritter.percent = 1

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(true)
			end
		end

		arg_508_1.nodeConfigList_ = {}

		arg_508_1:InitPlayNodeList()
	end,
	Play1109302128 = function(arg_512_0, arg_512_1)
		arg_512_1.time_ = 0
		arg_512_1.frameCnt_ = 0
		arg_512_1.state_ = "playing"
		arg_512_1.curTalkId_ = 1109302128
		arg_512_1.duration_ = 5

		SetActive(arg_512_1.tipsGo_, false)

		function arg_512_1.onSingleLineFinish_()
			arg_512_1.onSingleLineUpdate_ = nil
			arg_512_1.onSingleLineFinish_ = nil
			arg_512_1.state_ = "waiting"
		end

		function arg_512_1.playNext_(arg_514_0)
			if arg_514_0 == 1 then
				arg_512_0:Play1109302129(arg_512_1)
			end
		end

		function arg_512_1.onSingleLineUpdate_(arg_515_0)
			local var_515_0 = 0
			local var_515_1 = 0.775

			if var_515_0 < arg_512_1.time_ and arg_512_1.time_ <= var_515_0 + arg_515_0 then
				arg_512_1.talkMaxDuration = 0
				arg_512_1.dialogCg_.alpha = 1

				arg_512_1.dialog_:SetActive(true)
				SetActive(arg_512_1.leftNameGo_, false)

				arg_512_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_512_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_512_1:RecordName(arg_512_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_512_1.iconTrs_.gameObject, false)
				arg_512_1.callingController_:SetSelectedState("normal")

				local var_515_2 = arg_512_1:GetWordFromCfg(1109302128)
				local var_515_3 = arg_512_1:FormatText(var_515_2.content)

				arg_512_1.text_.text = var_515_3

				LuaForUtil.ClearLinePrefixSymbol(arg_512_1.text_)

				local var_515_4 = 31
				local var_515_5 = utf8.len(var_515_3)
				local var_515_6 = var_515_4 <= 0 and var_515_1 or var_515_1 * (var_515_5 / var_515_4)

				if var_515_6 > 0 and var_515_1 < var_515_6 then
					arg_512_1.talkMaxDuration = var_515_6

					if var_515_6 + var_515_0 > arg_512_1.duration_ then
						arg_512_1.duration_ = var_515_6 + var_515_0
					end
				end

				arg_512_1.text_.text = var_515_3
				arg_512_1.typewritter.percent = 0

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(false)
				arg_512_1:RecordContent(arg_512_1.text_.text)
			end

			local var_515_7 = math.max(var_515_1, arg_512_1.talkMaxDuration)

			if var_515_0 <= arg_512_1.time_ and arg_512_1.time_ < var_515_0 + var_515_7 then
				arg_512_1.typewritter.percent = (arg_512_1.time_ - var_515_0) / var_515_7

				arg_512_1.typewritter:SetDirty()
			end

			if arg_512_1.time_ >= var_515_0 + var_515_7 and arg_512_1.time_ < var_515_0 + var_515_7 + arg_515_0 then
				arg_512_1.typewritter.percent = 1

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(true)
			end
		end

		arg_512_1.nodeConfigList_ = {}

		arg_512_1:InitPlayNodeList()
	end,
	Play1109302129 = function(arg_516_0, arg_516_1)
		arg_516_1.time_ = 0
		arg_516_1.frameCnt_ = 0
		arg_516_1.state_ = "playing"
		arg_516_1.curTalkId_ = 1109302129
		arg_516_1.duration_ = 5

		SetActive(arg_516_1.tipsGo_, false)

		function arg_516_1.onSingleLineFinish_()
			arg_516_1.onSingleLineUpdate_ = nil
			arg_516_1.onSingleLineFinish_ = nil
			arg_516_1.state_ = "waiting"
		end

		function arg_516_1.playNext_(arg_518_0)
			if arg_518_0 == 1 then
				arg_516_0:Play1109302130(arg_516_1)
			end
		end

		function arg_516_1.onSingleLineUpdate_(arg_519_0)
			local var_519_0 = 0
			local var_519_1 = 0.775

			if var_519_0 < arg_516_1.time_ and arg_516_1.time_ <= var_519_0 + arg_519_0 then
				arg_516_1.talkMaxDuration = 0
				arg_516_1.dialogCg_.alpha = 1

				arg_516_1.dialog_:SetActive(true)
				SetActive(arg_516_1.leftNameGo_, false)

				arg_516_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_516_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_516_1:RecordName(arg_516_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_516_1.iconTrs_.gameObject, false)
				arg_516_1.callingController_:SetSelectedState("normal")

				local var_519_2 = arg_516_1:GetWordFromCfg(1109302129)
				local var_519_3 = arg_516_1:FormatText(var_519_2.content)

				arg_516_1.text_.text = var_519_3

				LuaForUtil.ClearLinePrefixSymbol(arg_516_1.text_)

				local var_519_4 = 31
				local var_519_5 = utf8.len(var_519_3)
				local var_519_6 = var_519_4 <= 0 and var_519_1 or var_519_1 * (var_519_5 / var_519_4)

				if var_519_6 > 0 and var_519_1 < var_519_6 then
					arg_516_1.talkMaxDuration = var_519_6

					if var_519_6 + var_519_0 > arg_516_1.duration_ then
						arg_516_1.duration_ = var_519_6 + var_519_0
					end
				end

				arg_516_1.text_.text = var_519_3
				arg_516_1.typewritter.percent = 0

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(false)
				arg_516_1:RecordContent(arg_516_1.text_.text)
			end

			local var_519_7 = math.max(var_519_1, arg_516_1.talkMaxDuration)

			if var_519_0 <= arg_516_1.time_ and arg_516_1.time_ < var_519_0 + var_519_7 then
				arg_516_1.typewritter.percent = (arg_516_1.time_ - var_519_0) / var_519_7

				arg_516_1.typewritter:SetDirty()
			end

			if arg_516_1.time_ >= var_519_0 + var_519_7 and arg_516_1.time_ < var_519_0 + var_519_7 + arg_519_0 then
				arg_516_1.typewritter.percent = 1

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(true)
			end
		end

		arg_516_1.nodeConfigList_ = {}

		arg_516_1:InitPlayNodeList()
	end,
	Play1109302130 = function(arg_520_0, arg_520_1)
		arg_520_1.time_ = 0
		arg_520_1.frameCnt_ = 0
		arg_520_1.state_ = "playing"
		arg_520_1.curTalkId_ = 1109302130
		arg_520_1.duration_ = 5

		SetActive(arg_520_1.tipsGo_, false)

		function arg_520_1.onSingleLineFinish_()
			arg_520_1.onSingleLineUpdate_ = nil
			arg_520_1.onSingleLineFinish_ = nil
			arg_520_1.state_ = "waiting"
		end

		function arg_520_1.playNext_(arg_522_0)
			if arg_522_0 == 1 then
				arg_520_0:Play1109302131(arg_520_1)
			end
		end

		function arg_520_1.onSingleLineUpdate_(arg_523_0)
			local var_523_0 = 0
			local var_523_1 = 0.075

			if var_523_0 < arg_520_1.time_ and arg_520_1.time_ <= var_523_0 + arg_523_0 then
				arg_520_1.talkMaxDuration = 0
				arg_520_1.dialogCg_.alpha = 1

				arg_520_1.dialog_:SetActive(true)
				SetActive(arg_520_1.leftNameGo_, true)

				local var_523_2 = arg_520_1:FormatText(StoryNameCfg[7].name)

				arg_520_1.leftNameTxt_.text = var_523_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_520_1.leftNameTxt_.transform)

				arg_520_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_520_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_520_1:RecordName(arg_520_1.leftNameTxt_.text)
				SetActive(arg_520_1.iconTrs_.gameObject, true)
				arg_520_1.iconController_:SetSelectedState("hero")

				arg_520_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_520_1.callingController_:SetSelectedState("normal")

				arg_520_1.keyicon_.color = Color.New(1, 1, 1)
				arg_520_1.icon_.color = Color.New(1, 1, 1)

				local var_523_3 = arg_520_1:GetWordFromCfg(1109302130)
				local var_523_4 = arg_520_1:FormatText(var_523_3.content)

				arg_520_1.text_.text = var_523_4

				LuaForUtil.ClearLinePrefixSymbol(arg_520_1.text_)

				local var_523_5 = 3
				local var_523_6 = utf8.len(var_523_4)
				local var_523_7 = var_523_5 <= 0 and var_523_1 or var_523_1 * (var_523_6 / var_523_5)

				if var_523_7 > 0 and var_523_1 < var_523_7 then
					arg_520_1.talkMaxDuration = var_523_7

					if var_523_7 + var_523_0 > arg_520_1.duration_ then
						arg_520_1.duration_ = var_523_7 + var_523_0
					end
				end

				arg_520_1.text_.text = var_523_4
				arg_520_1.typewritter.percent = 0

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(false)
				arg_520_1:RecordContent(arg_520_1.text_.text)
			end

			local var_523_8 = math.max(var_523_1, arg_520_1.talkMaxDuration)

			if var_523_0 <= arg_520_1.time_ and arg_520_1.time_ < var_523_0 + var_523_8 then
				arg_520_1.typewritter.percent = (arg_520_1.time_ - var_523_0) / var_523_8

				arg_520_1.typewritter:SetDirty()
			end

			if arg_520_1.time_ >= var_523_0 + var_523_8 and arg_520_1.time_ < var_523_0 + var_523_8 + arg_523_0 then
				arg_520_1.typewritter.percent = 1

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(true)
			end
		end

		arg_520_1.nodeConfigList_ = {}

		arg_520_1:InitPlayNodeList()
	end,
	Play1109302131 = function(arg_524_0, arg_524_1)
		arg_524_1.time_ = 0
		arg_524_1.frameCnt_ = 0
		arg_524_1.state_ = "playing"
		arg_524_1.curTalkId_ = 1109302131
		arg_524_1.duration_ = 3.8

		SetActive(arg_524_1.tipsGo_, false)

		function arg_524_1.onSingleLineFinish_()
			arg_524_1.onSingleLineUpdate_ = nil
			arg_524_1.onSingleLineFinish_ = nil
			arg_524_1.state_ = "waiting"
		end

		function arg_524_1.playNext_(arg_526_0)
			if arg_526_0 == 1 then
				arg_524_0:Play1109302132(arg_524_1)
			end
		end

		function arg_524_1.onSingleLineUpdate_(arg_527_0)
			local var_527_0 = arg_524_1.actors_["1050ui_story"]
			local var_527_1 = 0

			if var_527_1 < arg_524_1.time_ and arg_524_1.time_ <= var_527_1 + arg_527_0 and not isNil(var_527_0) and arg_524_1.var_.characterEffect1050ui_story == nil then
				arg_524_1.var_.characterEffect1050ui_story = var_527_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_527_2 = 0.2

			if var_527_1 <= arg_524_1.time_ and arg_524_1.time_ < var_527_1 + var_527_2 and not isNil(var_527_0) then
				local var_527_3 = (arg_524_1.time_ - var_527_1) / var_527_2

				if arg_524_1.var_.characterEffect1050ui_story and not isNil(var_527_0) then
					arg_524_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_524_1.time_ >= var_527_1 + var_527_2 and arg_524_1.time_ < var_527_1 + var_527_2 + arg_527_0 and not isNil(var_527_0) and arg_524_1.var_.characterEffect1050ui_story then
				arg_524_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_527_4 = 0

			if var_527_4 < arg_524_1.time_ and arg_524_1.time_ <= var_527_4 + arg_527_0 then
				arg_524_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050actionlink/1050action435")
			end

			local var_527_5 = 0

			if var_527_5 < arg_524_1.time_ and arg_524_1.time_ <= var_527_5 + arg_527_0 then
				arg_524_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_527_6 = 0
			local var_527_7 = 0.25

			if var_527_6 < arg_524_1.time_ and arg_524_1.time_ <= var_527_6 + arg_527_0 then
				arg_524_1.talkMaxDuration = 0
				arg_524_1.dialogCg_.alpha = 1

				arg_524_1.dialog_:SetActive(true)
				SetActive(arg_524_1.leftNameGo_, true)

				local var_527_8 = arg_524_1:FormatText(StoryNameCfg[74].name)

				arg_524_1.leftNameTxt_.text = var_527_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_524_1.leftNameTxt_.transform)

				arg_524_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_524_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_524_1:RecordName(arg_524_1.leftNameTxt_.text)
				SetActive(arg_524_1.iconTrs_.gameObject, false)
				arg_524_1.callingController_:SetSelectedState("normal")

				local var_527_9 = arg_524_1:GetWordFromCfg(1109302131)
				local var_527_10 = arg_524_1:FormatText(var_527_9.content)

				arg_524_1.text_.text = var_527_10

				LuaForUtil.ClearLinePrefixSymbol(arg_524_1.text_)

				local var_527_11 = 10
				local var_527_12 = utf8.len(var_527_10)
				local var_527_13 = var_527_11 <= 0 and var_527_7 or var_527_7 * (var_527_12 / var_527_11)

				if var_527_13 > 0 and var_527_7 < var_527_13 then
					arg_524_1.talkMaxDuration = var_527_13

					if var_527_13 + var_527_6 > arg_524_1.duration_ then
						arg_524_1.duration_ = var_527_13 + var_527_6
					end
				end

				arg_524_1.text_.text = var_527_10
				arg_524_1.typewritter.percent = 0

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302131", "story_v_side_new_1109302.awb") ~= 0 then
					local var_527_14 = manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302131", "story_v_side_new_1109302.awb") / 1000

					if var_527_14 + var_527_6 > arg_524_1.duration_ then
						arg_524_1.duration_ = var_527_14 + var_527_6
					end

					if var_527_9.prefab_name ~= "" and arg_524_1.actors_[var_527_9.prefab_name] ~= nil then
						local var_527_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_524_1.actors_[var_527_9.prefab_name].transform, "story_v_side_new_1109302", "1109302131", "story_v_side_new_1109302.awb")

						arg_524_1:RecordAudio("1109302131", var_527_15)
						arg_524_1:RecordAudio("1109302131", var_527_15)
					else
						arg_524_1:AudioAction("play", "voice", "story_v_side_new_1109302", "1109302131", "story_v_side_new_1109302.awb")
					end

					arg_524_1:RecordHistoryTalkVoice("story_v_side_new_1109302", "1109302131", "story_v_side_new_1109302.awb")
				end

				arg_524_1:RecordContent(arg_524_1.text_.text)
			end

			local var_527_16 = math.max(var_527_7, arg_524_1.talkMaxDuration)

			if var_527_6 <= arg_524_1.time_ and arg_524_1.time_ < var_527_6 + var_527_16 then
				arg_524_1.typewritter.percent = (arg_524_1.time_ - var_527_6) / var_527_16

				arg_524_1.typewritter:SetDirty()
			end

			if arg_524_1.time_ >= var_527_6 + var_527_16 and arg_524_1.time_ < var_527_6 + var_527_16 + arg_527_0 then
				arg_524_1.typewritter.percent = 1

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(true)
			end
		end

		arg_524_1.nodeConfigList_ = {}

		arg_524_1:InitPlayNodeList()
	end,
	Play1109302132 = function(arg_528_0, arg_528_1)
		arg_528_1.time_ = 0
		arg_528_1.frameCnt_ = 0
		arg_528_1.state_ = "playing"
		arg_528_1.curTalkId_ = 1109302132
		arg_528_1.duration_ = 5

		SetActive(arg_528_1.tipsGo_, false)

		function arg_528_1.onSingleLineFinish_()
			arg_528_1.onSingleLineUpdate_ = nil
			arg_528_1.onSingleLineFinish_ = nil
			arg_528_1.state_ = "waiting"
			arg_528_1.auto_ = false
		end

		function arg_528_1.playNext_(arg_530_0)
			arg_528_1.onStoryFinished_()
		end

		function arg_528_1.onSingleLineUpdate_(arg_531_0)
			local var_531_0 = arg_528_1.actors_["1050ui_story"]
			local var_531_1 = 0

			if var_531_1 < arg_528_1.time_ and arg_528_1.time_ <= var_531_1 + arg_531_0 and not isNil(var_531_0) and arg_528_1.var_.characterEffect1050ui_story == nil then
				arg_528_1.var_.characterEffect1050ui_story = var_531_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_531_2 = 0.2

			if var_531_1 <= arg_528_1.time_ and arg_528_1.time_ < var_531_1 + var_531_2 and not isNil(var_531_0) then
				local var_531_3 = (arg_528_1.time_ - var_531_1) / var_531_2

				if arg_528_1.var_.characterEffect1050ui_story and not isNil(var_531_0) then
					local var_531_4 = Mathf.Lerp(0, 0.5, var_531_3)

					arg_528_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_528_1.var_.characterEffect1050ui_story.fillRatio = var_531_4
				end
			end

			if arg_528_1.time_ >= var_531_1 + var_531_2 and arg_528_1.time_ < var_531_1 + var_531_2 + arg_531_0 and not isNil(var_531_0) and arg_528_1.var_.characterEffect1050ui_story then
				local var_531_5 = 0.5

				arg_528_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_528_1.var_.characterEffect1050ui_story.fillRatio = var_531_5
			end

			local var_531_6 = manager.ui.mainCamera.transform
			local var_531_7 = 0

			if var_531_7 < arg_528_1.time_ and arg_528_1.time_ <= var_531_7 + arg_531_0 then
				local var_531_8 = arg_528_1.var_.effectyutianluhua1

				if var_531_8 then
					Object.Destroy(var_531_8)

					arg_528_1.var_.effectyutianluhua1 = nil
				end
			end

			local var_531_9 = 0
			local var_531_10 = 0.05

			if var_531_9 < arg_528_1.time_ and arg_528_1.time_ <= var_531_9 + arg_531_0 then
				arg_528_1.talkMaxDuration = 0
				arg_528_1.dialogCg_.alpha = 1

				arg_528_1.dialog_:SetActive(true)
				SetActive(arg_528_1.leftNameGo_, false)

				arg_528_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_528_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_528_1:RecordName(arg_528_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_528_1.iconTrs_.gameObject, false)
				arg_528_1.callingController_:SetSelectedState("normal")

				local var_531_11 = arg_528_1:GetWordFromCfg(1109302132)
				local var_531_12 = arg_528_1:FormatText(var_531_11.content)

				arg_528_1.text_.text = var_531_12

				LuaForUtil.ClearLinePrefixSymbol(arg_528_1.text_)

				local var_531_13 = 2
				local var_531_14 = utf8.len(var_531_12)
				local var_531_15 = var_531_13 <= 0 and var_531_10 or var_531_10 * (var_531_14 / var_531_13)

				if var_531_15 > 0 and var_531_10 < var_531_15 then
					arg_528_1.talkMaxDuration = var_531_15

					if var_531_15 + var_531_9 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_15 + var_531_9
					end
				end

				arg_528_1.text_.text = var_531_12
				arg_528_1.typewritter.percent = 0

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(false)
				arg_528_1:RecordContent(arg_528_1.text_.text)
			end

			local var_531_16 = math.max(var_531_10, arg_528_1.talkMaxDuration)

			if var_531_9 <= arg_528_1.time_ and arg_528_1.time_ < var_531_9 + var_531_16 then
				arg_528_1.typewritter.percent = (arg_528_1.time_ - var_531_9) / var_531_16

				arg_528_1.typewritter:SetDirty()
			end

			if arg_528_1.time_ >= var_531_9 + var_531_16 and arg_528_1.time_ < var_531_9 + var_531_16 + arg_531_0 then
				arg_528_1.typewritter.percent = 1

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(true)
			end
		end

		arg_528_1.nodeConfigList_ = {}

		arg_528_1:InitPlayNodeList()
	end,
	Play1109302088 = function(arg_532_0, arg_532_1)
		arg_532_1.time_ = 0
		arg_532_1.frameCnt_ = 0
		arg_532_1.state_ = "playing"
		arg_532_1.curTalkId_ = 1109302088
		arg_532_1.duration_ = 2.73

		SetActive(arg_532_1.tipsGo_, false)

		function arg_532_1.onSingleLineFinish_()
			arg_532_1.onSingleLineUpdate_ = nil
			arg_532_1.onSingleLineFinish_ = nil
			arg_532_1.state_ = "waiting"
		end

		function arg_532_1.playNext_(arg_534_0)
			if arg_534_0 == 1 then
				arg_532_0:Play1109302089(arg_532_1)
			end
		end

		function arg_532_1.onSingleLineUpdate_(arg_535_0)
			local var_535_0 = 0
			local var_535_1 = 0.25

			if var_535_0 < arg_532_1.time_ and arg_532_1.time_ <= var_535_0 + arg_535_0 then
				arg_532_1.talkMaxDuration = 0
				arg_532_1.dialogCg_.alpha = 1

				arg_532_1.dialog_:SetActive(true)
				SetActive(arg_532_1.leftNameGo_, true)

				local var_535_2 = arg_532_1:FormatText(StoryNameCfg[73].name)

				arg_532_1.leftNameTxt_.text = var_535_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_532_1.leftNameTxt_.transform)

				arg_532_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_532_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_532_1:RecordName(arg_532_1.leftNameTxt_.text)
				SetActive(arg_532_1.iconTrs_.gameObject, true)
				arg_532_1.iconController_:SetSelectedState("hero")

				arg_532_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1093")

				arg_532_1.callingController_:SetSelectedState("normal")

				arg_532_1.keyicon_.color = Color.New(1, 1, 1)
				arg_532_1.icon_.color = Color.New(1, 1, 1)

				local var_535_3 = arg_532_1:GetWordFromCfg(1109302088)
				local var_535_4 = arg_532_1:FormatText(var_535_3.content)

				arg_532_1.text_.text = var_535_4

				LuaForUtil.ClearLinePrefixSymbol(arg_532_1.text_)

				local var_535_5 = 10
				local var_535_6 = utf8.len(var_535_4)
				local var_535_7 = var_535_5 <= 0 and var_535_1 or var_535_1 * (var_535_6 / var_535_5)

				if var_535_7 > 0 and var_535_1 < var_535_7 then
					arg_532_1.talkMaxDuration = var_535_7

					if var_535_7 + var_535_0 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_7 + var_535_0
					end
				end

				arg_532_1.text_.text = var_535_4
				arg_532_1.typewritter.percent = 0

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302088", "story_v_side_new_1109302.awb") ~= 0 then
					local var_535_8 = manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302088", "story_v_side_new_1109302.awb") / 1000

					if var_535_8 + var_535_0 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_8 + var_535_0
					end

					if var_535_3.prefab_name ~= "" and arg_532_1.actors_[var_535_3.prefab_name] ~= nil then
						local var_535_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_532_1.actors_[var_535_3.prefab_name].transform, "story_v_side_new_1109302", "1109302088", "story_v_side_new_1109302.awb")

						arg_532_1:RecordAudio("1109302088", var_535_9)
						arg_532_1:RecordAudio("1109302088", var_535_9)
					else
						arg_532_1:AudioAction("play", "voice", "story_v_side_new_1109302", "1109302088", "story_v_side_new_1109302.awb")
					end

					arg_532_1:RecordHistoryTalkVoice("story_v_side_new_1109302", "1109302088", "story_v_side_new_1109302.awb")
				end

				arg_532_1:RecordContent(arg_532_1.text_.text)
			end

			local var_535_10 = math.max(var_535_1, arg_532_1.talkMaxDuration)

			if var_535_0 <= arg_532_1.time_ and arg_532_1.time_ < var_535_0 + var_535_10 then
				arg_532_1.typewritter.percent = (arg_532_1.time_ - var_535_0) / var_535_10

				arg_532_1.typewritter:SetDirty()
			end

			if arg_532_1.time_ >= var_535_0 + var_535_10 and arg_532_1.time_ < var_535_0 + var_535_10 + arg_535_0 then
				arg_532_1.typewritter.percent = 1

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(true)
			end
		end

		arg_532_1.nodeConfigList_ = {}

		arg_532_1:InitPlayNodeList()
	end,
	Play1109302089 = function(arg_536_0, arg_536_1)
		arg_536_1.time_ = 0
		arg_536_1.frameCnt_ = 0
		arg_536_1.state_ = "playing"
		arg_536_1.curTalkId_ = 1109302089
		arg_536_1.duration_ = 5

		SetActive(arg_536_1.tipsGo_, false)

		function arg_536_1.onSingleLineFinish_()
			arg_536_1.onSingleLineUpdate_ = nil
			arg_536_1.onSingleLineFinish_ = nil
			arg_536_1.state_ = "waiting"
		end

		function arg_536_1.playNext_(arg_538_0)
			if arg_538_0 == 1 then
				arg_536_0:Play1109302090(arg_536_1)
			end
		end

		function arg_536_1.onSingleLineUpdate_(arg_539_0)
			local var_539_0 = 0
			local var_539_1 = 0.4

			if var_539_0 < arg_536_1.time_ and arg_536_1.time_ <= var_539_0 + arg_539_0 then
				arg_536_1.talkMaxDuration = 0
				arg_536_1.dialogCg_.alpha = 1

				arg_536_1.dialog_:SetActive(true)
				SetActive(arg_536_1.leftNameGo_, true)

				local var_539_2 = arg_536_1:FormatText(StoryNameCfg[7].name)

				arg_536_1.leftNameTxt_.text = var_539_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_536_1.leftNameTxt_.transform)

				arg_536_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_536_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_536_1:RecordName(arg_536_1.leftNameTxt_.text)
				SetActive(arg_536_1.iconTrs_.gameObject, true)
				arg_536_1.iconController_:SetSelectedState("hero")

				arg_536_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_536_1.callingController_:SetSelectedState("normal")

				arg_536_1.keyicon_.color = Color.New(1, 1, 1)
				arg_536_1.icon_.color = Color.New(1, 1, 1)

				local var_539_3 = arg_536_1:GetWordFromCfg(1109302089)
				local var_539_4 = arg_536_1:FormatText(var_539_3.content)

				arg_536_1.text_.text = var_539_4

				LuaForUtil.ClearLinePrefixSymbol(arg_536_1.text_)

				local var_539_5 = 16
				local var_539_6 = utf8.len(var_539_4)
				local var_539_7 = var_539_5 <= 0 and var_539_1 or var_539_1 * (var_539_6 / var_539_5)

				if var_539_7 > 0 and var_539_1 < var_539_7 then
					arg_536_1.talkMaxDuration = var_539_7

					if var_539_7 + var_539_0 > arg_536_1.duration_ then
						arg_536_1.duration_ = var_539_7 + var_539_0
					end
				end

				arg_536_1.text_.text = var_539_4
				arg_536_1.typewritter.percent = 0

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(false)
				arg_536_1:RecordContent(arg_536_1.text_.text)
			end

			local var_539_8 = math.max(var_539_1, arg_536_1.talkMaxDuration)

			if var_539_0 <= arg_536_1.time_ and arg_536_1.time_ < var_539_0 + var_539_8 then
				arg_536_1.typewritter.percent = (arg_536_1.time_ - var_539_0) / var_539_8

				arg_536_1.typewritter:SetDirty()
			end

			if arg_536_1.time_ >= var_539_0 + var_539_8 and arg_536_1.time_ < var_539_0 + var_539_8 + arg_539_0 then
				arg_536_1.typewritter.percent = 1

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(true)
			end
		end

		arg_536_1.nodeConfigList_ = {}

		arg_536_1:InitPlayNodeList()
	end,
	Play1109302090 = function(arg_540_0, arg_540_1)
		arg_540_1.time_ = 0
		arg_540_1.frameCnt_ = 0
		arg_540_1.state_ = "playing"
		arg_540_1.curTalkId_ = 1109302090
		arg_540_1.duration_ = 3.6

		SetActive(arg_540_1.tipsGo_, false)

		function arg_540_1.onSingleLineFinish_()
			arg_540_1.onSingleLineUpdate_ = nil
			arg_540_1.onSingleLineFinish_ = nil
			arg_540_1.state_ = "waiting"
		end

		function arg_540_1.playNext_(arg_542_0)
			if arg_542_0 == 1 then
				arg_540_0:Play1109302091(arg_540_1)
			end
		end

		function arg_540_1.onSingleLineUpdate_(arg_543_0)
			local var_543_0 = 0
			local var_543_1 = 0.25

			if var_543_0 < arg_540_1.time_ and arg_540_1.time_ <= var_543_0 + arg_543_0 then
				arg_540_1.talkMaxDuration = 0
				arg_540_1.dialogCg_.alpha = 1

				arg_540_1.dialog_:SetActive(true)
				SetActive(arg_540_1.leftNameGo_, true)

				local var_543_2 = arg_540_1:FormatText(StoryNameCfg[73].name)

				arg_540_1.leftNameTxt_.text = var_543_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_540_1.leftNameTxt_.transform)

				arg_540_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_540_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_540_1:RecordName(arg_540_1.leftNameTxt_.text)
				SetActive(arg_540_1.iconTrs_.gameObject, true)
				arg_540_1.iconController_:SetSelectedState("hero")

				arg_540_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1093")

				arg_540_1.callingController_:SetSelectedState("normal")

				arg_540_1.keyicon_.color = Color.New(1, 1, 1)
				arg_540_1.icon_.color = Color.New(1, 1, 1)

				local var_543_3 = arg_540_1:GetWordFromCfg(1109302090)
				local var_543_4 = arg_540_1:FormatText(var_543_3.content)

				arg_540_1.text_.text = var_543_4

				LuaForUtil.ClearLinePrefixSymbol(arg_540_1.text_)

				local var_543_5 = 10
				local var_543_6 = utf8.len(var_543_4)
				local var_543_7 = var_543_5 <= 0 and var_543_1 or var_543_1 * (var_543_6 / var_543_5)

				if var_543_7 > 0 and var_543_1 < var_543_7 then
					arg_540_1.talkMaxDuration = var_543_7

					if var_543_7 + var_543_0 > arg_540_1.duration_ then
						arg_540_1.duration_ = var_543_7 + var_543_0
					end
				end

				arg_540_1.text_.text = var_543_4
				arg_540_1.typewritter.percent = 0

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302090", "story_v_side_new_1109302.awb") ~= 0 then
					local var_543_8 = manager.audio:GetVoiceLength("story_v_side_new_1109302", "1109302090", "story_v_side_new_1109302.awb") / 1000

					if var_543_8 + var_543_0 > arg_540_1.duration_ then
						arg_540_1.duration_ = var_543_8 + var_543_0
					end

					if var_543_3.prefab_name ~= "" and arg_540_1.actors_[var_543_3.prefab_name] ~= nil then
						local var_543_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_540_1.actors_[var_543_3.prefab_name].transform, "story_v_side_new_1109302", "1109302090", "story_v_side_new_1109302.awb")

						arg_540_1:RecordAudio("1109302090", var_543_9)
						arg_540_1:RecordAudio("1109302090", var_543_9)
					else
						arg_540_1:AudioAction("play", "voice", "story_v_side_new_1109302", "1109302090", "story_v_side_new_1109302.awb")
					end

					arg_540_1:RecordHistoryTalkVoice("story_v_side_new_1109302", "1109302090", "story_v_side_new_1109302.awb")
				end

				arg_540_1:RecordContent(arg_540_1.text_.text)
			end

			local var_543_10 = math.max(var_543_1, arg_540_1.talkMaxDuration)

			if var_543_0 <= arg_540_1.time_ and arg_540_1.time_ < var_543_0 + var_543_10 then
				arg_540_1.typewritter.percent = (arg_540_1.time_ - var_543_0) / var_543_10

				arg_540_1.typewritter:SetDirty()
			end

			if arg_540_1.time_ >= var_543_0 + var_543_10 and arg_540_1.time_ < var_543_0 + var_543_10 + arg_543_0 then
				arg_540_1.typewritter.percent = 1

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(true)
			end
		end

		arg_540_1.nodeConfigList_ = {}

		arg_540_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST06a",
		"TextureConfig/Background/ST17",
		"TextureConfig/Background/ST11",
		"TextureConfig/Background/ST11a"
	},
	voices = {
		"story_v_side_new_1109302.awb"
	}
}
