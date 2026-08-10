return {
	Play924011001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 924011001
		arg_1_1.duration_ = 3.47

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play924011002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "STblack "

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
				local var_4_5 = arg_1_1.bgs_["STblack "]

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
					if iter_4_0 ~= "STblack " then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 2

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_17 = 0.3

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
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
				arg_1_1.fswbg_:SetActive(true)
				arg_1_1.dialog_:SetActive(false)

				arg_1_1.fswtw_.percent = 0

				local var_4_25 = arg_1_1:GetWordFromCfg(924011001)
				local var_4_26 = arg_1_1:FormatText(var_4_25.content)

				arg_1_1.fswt_.text = var_4_26

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.fswt_)

				arg_1_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_1_1.fswtw_:SetDirty()

				arg_1_1.typewritterCharCountI18N = 0

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_27 = 2

			if var_4_27 < arg_1_1.time_ and arg_1_1.time_ <= var_4_27 + arg_4_0 then
				arg_1_1.var_.oldValueTypewriter = arg_1_1.fswtw_.percent

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_28 = 22
			local var_4_29 = 1.46666666666667
			local var_4_30 = arg_1_1:GetWordFromCfg(924011001)
			local var_4_31 = arg_1_1:FormatText(var_4_30.content)
			local var_4_32, var_4_33 = arg_1_1:GetPercentByPara(var_4_31, 1)

			if var_4_27 < arg_1_1.time_ and arg_1_1.time_ <= var_4_27 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				local var_4_34 = var_4_28 <= 0 and var_4_29 or var_4_29 * ((var_4_33 - arg_1_1.typewritterCharCountI18N) / var_4_28)

				if var_4_34 > 0 and var_4_29 < var_4_34 then
					arg_1_1.talkMaxDuration = var_4_34

					if var_4_34 + var_4_27 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_34 + var_4_27
					end
				end
			end

			local var_4_35 = 1.46666666666667
			local var_4_36 = math.max(var_4_35, arg_1_1.talkMaxDuration)

			if var_4_27 <= arg_1_1.time_ and arg_1_1.time_ < var_4_27 + var_4_36 then
				local var_4_37 = (arg_1_1.time_ - var_4_27) / var_4_36

				arg_1_1.fswtw_.percent = Mathf.Lerp(arg_1_1.var_.oldValueTypewriter, var_4_32, var_4_37)
				arg_1_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_1_1.fswtw_:SetDirty()
			end

			if arg_1_1.time_ >= var_4_27 + var_4_36 and arg_1_1.time_ < var_4_27 + var_4_36 + arg_4_0 then
				arg_1_1.fswtw_.percent = var_4_32

				arg_1_1.fswtw_:SetDirty()
				arg_1_1:ShowNextGo(true)

				arg_1_1.typewritterCharCountI18N = var_4_33
			end

			local var_4_38 = 2

			if var_4_38 < arg_1_1.time_ and arg_1_1.time_ <= var_4_38 + arg_4_0 then
				local var_4_39 = arg_1_1.fswbg_.transform:Find("textbox/adapt/content") or arg_1_1.fswbg_.transform:Find("textbox/content")
				local var_4_40 = arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_4_41 = var_4_39:GetComponent("Text")
				local var_4_42 = var_4_39:GetComponent("RectTransform")

				var_4_41.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_4_42.offsetMin = Vector2.New(0, 0)
				var_4_42.offsetMax = Vector2.New(0, 0)
			end

			local var_4_43 = 0
			local var_4_44 = 0.2

			if var_4_43 < arg_1_1.time_ and arg_1_1.time_ <= var_4_43 + arg_4_0 then
				local var_4_45 = "play"
				local var_4_46 = "music"

				arg_1_1:AudioAction(var_4_45, var_4_46, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_47 = ""
				local var_4_48 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_48 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_48 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_48

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_48
						arg_1_1.bgmTxt2_.text = var_4_48
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
	Play924011002 = function(arg_6_0, arg_6_1)
		arg_6_1.time_ = 0
		arg_6_1.frameCnt_ = 0
		arg_6_1.state_ = "playing"
		arg_6_1.curTalkId_ = 924011002
		arg_6_1.duration_ = 3.93

		SetActive(arg_6_1.tipsGo_, false)

		function arg_6_1.onSingleLineFinish_()
			arg_6_1.onSingleLineUpdate_ = nil
			arg_6_1.onSingleLineFinish_ = nil
			arg_6_1.state_ = "waiting"
		end

		function arg_6_1.playNext_(arg_8_0)
			if arg_8_0 == 1 then
				arg_6_0:Play924011003(arg_6_1)
			end
		end

		function arg_6_1.onSingleLineUpdate_(arg_9_0)
			local var_9_0 = 1

			if var_9_0 < arg_6_1.time_ and arg_6_1.time_ <= var_9_0 + arg_9_0 then
				arg_6_1.var_.oldValueTypewriter = arg_6_1.fswtw_.percent

				SetActive(arg_6_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_6_1:ShowNextGo(false)
			end

			local var_9_1 = 44
			local var_9_2 = 2.93333333333333
			local var_9_3 = arg_6_1:GetWordFromCfg(924011001)
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

			local var_9_8 = 2.93333333333333
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
		end

		arg_6_1.nodeConfigList_ = {}

		arg_6_1:InitPlayNodeList()
	end,
	Play924011003 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 924011003
		arg_10_1.duration_ = 3.73

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play924011004(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			local var_13_0 = 1

			if var_13_0 < arg_10_1.time_ and arg_10_1.time_ <= var_13_0 + arg_13_0 then
				arg_10_1.var_.oldValueTypewriter = arg_10_1.fswtw_.percent

				SetActive(arg_10_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_10_1:ShowNextGo(false)
			end

			local var_13_1 = 41
			local var_13_2 = 2.73333333333333
			local var_13_3 = arg_10_1:GetWordFromCfg(924011001)
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

			local var_13_8 = 2.73333333333333
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
		end

		arg_10_1.nodeConfigList_ = {}

		arg_10_1:InitPlayNodeList()
	end,
	Play924011004 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 924011004
		arg_14_1.duration_ = 1.6

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play924011005(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = 1

			if var_17_0 < arg_14_1.time_ and arg_14_1.time_ <= var_17_0 + arg_17_0 then
				arg_14_1.var_.oldValueTypewriter = arg_14_1.fswtw_.percent

				SetActive(arg_14_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_14_1:ShowNextGo(false)
			end

			local var_17_1 = 9
			local var_17_2 = 0.6
			local var_17_3 = arg_14_1:GetWordFromCfg(924011001)
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

			local var_17_8 = 0.6
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
		end

		arg_14_1.nodeConfigList_ = {}

		arg_14_1:InitPlayNodeList()
	end,
	Play924011005 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 924011005
		arg_18_1.duration_ = 2.8

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play924011006(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = 1

			if var_21_0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_0 + arg_21_0 then
				arg_18_1.var_.oldValueTypewriter = arg_18_1.fswtw_.percent

				SetActive(arg_18_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_18_1:ShowNextGo(false)
			end

			local var_21_1 = 27
			local var_21_2 = 1.8
			local var_21_3 = arg_18_1:GetWordFromCfg(924011001)
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

			local var_21_8 = 1.8
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
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play924011006 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 924011006
		arg_22_1.duration_ = 3.67

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play924011007(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = 1

			if var_25_0 < arg_22_1.time_ and arg_22_1.time_ <= var_25_0 + arg_25_0 then
				arg_22_1.var_.oldValueTypewriter = arg_22_1.fswtw_.percent

				SetActive(arg_22_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_22_1:ShowNextGo(false)
			end

			local var_25_1 = 40
			local var_25_2 = 2.66666666666667
			local var_25_3 = arg_22_1:GetWordFromCfg(924011001)
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

			local var_25_8 = 2.66666666666667
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
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play924011007 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 924011007
		arg_26_1.duration_ = 1

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play924011008(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = 0.866666666666667

			if var_29_0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_0 + arg_29_0 then
				arg_26_1.var_.oldValueTypewriter = arg_26_1.fswtw_.percent

				SetActive(arg_26_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_26_1:ShowNextGo(false)
			end

			local var_29_1 = 2
			local var_29_2 = 0.133333333333333
			local var_29_3 = arg_26_1:GetWordFromCfg(924011001)
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

			local var_29_8 = 0.133333333333333
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

			if var_29_11 < arg_26_1.time_ and arg_26_1.time_ <= var_29_11 + arg_29_0 then
				arg_26_1.allBtn_.enabled = false
			end

			local var_29_12 = 0.9

			if arg_26_1.time_ >= var_29_11 + var_29_12 and arg_26_1.time_ < var_29_11 + var_29_12 + arg_29_0 then
				arg_26_1.allBtn_.enabled = true
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play924011008 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 924011008
		arg_30_1.duration_ = 8.7

		local var_30_0 = {
			zh = 7.566,
			ja = 8.7
		}
		local var_30_1 = manager.audio:GetLocalizationFlag()

		if var_30_0[var_30_1] ~= nil then
			arg_30_1.duration_ = var_30_0[var_30_1]
		end

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play924011009(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = "ST60"

			if arg_30_1.bgs_[var_33_0] == nil then
				local var_33_1 = Object.Instantiate(arg_30_1.paintGo_)

				var_33_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_33_0)
				var_33_1.name = var_33_0
				var_33_1.transform.parent = arg_30_1.stage_.transform
				var_33_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_30_1.bgs_[var_33_0] = var_33_1
			end

			local var_33_2 = 2

			if var_33_2 < arg_30_1.time_ and arg_30_1.time_ <= var_33_2 + arg_33_0 then
				local var_33_3 = manager.ui.mainCamera.transform.localPosition
				local var_33_4 = Vector3.New(0, 0, 10) + Vector3.New(var_33_3.x, var_33_3.y, 0)
				local var_33_5 = arg_30_1.bgs_.ST60

				var_33_5.transform.localPosition = var_33_4
				var_33_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_33_6 = var_33_5:GetComponent("SpriteRenderer")

				if var_33_6 and var_33_6.sprite then
					local var_33_7 = (var_33_5.transform.localPosition - var_33_3).z
					local var_33_8 = manager.ui.mainCameraCom_
					local var_33_9 = 2 * var_33_7 * Mathf.Tan(var_33_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_33_10 = var_33_9 * var_33_8.aspect
					local var_33_11 = var_33_6.sprite.bounds.size.x
					local var_33_12 = var_33_6.sprite.bounds.size.y
					local var_33_13 = var_33_10 / var_33_11
					local var_33_14 = var_33_9 / var_33_12
					local var_33_15 = var_33_14 < var_33_13 and var_33_13 or var_33_14

					var_33_5.transform.localScale = Vector3.New(var_33_15, var_33_15, 0)
				end

				for iter_33_0, iter_33_1 in pairs(arg_30_1.bgs_) do
					if iter_33_0 ~= "ST60" then
						iter_33_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_33_16 = 4

			if var_33_16 < arg_30_1.time_ and arg_30_1.time_ <= var_33_16 + arg_33_0 then
				arg_30_1.allBtn_.enabled = false
			end

			local var_33_17 = 0.3

			if arg_30_1.time_ >= var_33_16 + var_33_17 and arg_30_1.time_ < var_33_16 + var_33_17 + arg_33_0 then
				arg_30_1.allBtn_.enabled = true
			end

			local var_33_18 = 0

			if var_33_18 < arg_30_1.time_ and arg_30_1.time_ <= var_33_18 + arg_33_0 then
				arg_30_1.mask_.enabled = true
				arg_30_1.mask_.raycastTarget = true

				arg_30_1:SetGaussion(false)
			end

			local var_33_19 = 2

			if var_33_18 <= arg_30_1.time_ and arg_30_1.time_ < var_33_18 + var_33_19 then
				local var_33_20 = (arg_30_1.time_ - var_33_18) / var_33_19
				local var_33_21 = Color.New(0, 0, 0)

				var_33_21.a = Mathf.Lerp(0, 1, var_33_20)
				arg_30_1.mask_.color = var_33_21
			end

			if arg_30_1.time_ >= var_33_18 + var_33_19 and arg_30_1.time_ < var_33_18 + var_33_19 + arg_33_0 then
				local var_33_22 = Color.New(0, 0, 0)

				var_33_22.a = 1
				arg_30_1.mask_.color = var_33_22
			end

			local var_33_23 = 2

			if var_33_23 < arg_30_1.time_ and arg_30_1.time_ <= var_33_23 + arg_33_0 then
				arg_30_1.mask_.enabled = true
				arg_30_1.mask_.raycastTarget = true

				arg_30_1:SetGaussion(false)
			end

			local var_33_24 = 2

			if var_33_23 <= arg_30_1.time_ and arg_30_1.time_ < var_33_23 + var_33_24 then
				local var_33_25 = (arg_30_1.time_ - var_33_23) / var_33_24
				local var_33_26 = Color.New(0, 0, 0)

				var_33_26.a = Mathf.Lerp(1, 0, var_33_25)
				arg_30_1.mask_.color = var_33_26
			end

			if arg_30_1.time_ >= var_33_23 + var_33_24 and arg_30_1.time_ < var_33_23 + var_33_24 + arg_33_0 then
				local var_33_27 = Color.New(0, 0, 0)
				local var_33_28 = 0

				arg_30_1.mask_.enabled = false
				var_33_27.a = var_33_28
				arg_30_1.mask_.color = var_33_27
			end

			local var_33_29 = "1066ui_story"

			if arg_30_1.actors_[var_33_29] == nil then
				local var_33_30 = Asset.Load("Char/" .. "1066ui_story")

				if not isNil(var_33_30) then
					local var_33_31 = Object.Instantiate(Asset.Load("Char/" .. "1066ui_story"), arg_30_1.stage_.transform)

					var_33_31.name = var_33_29
					var_33_31.transform.localPosition = Vector3.New(0, 100, 0)
					arg_30_1.actors_[var_33_29] = var_33_31

					local var_33_32 = var_33_31:GetComponentInChildren(typeof(CharacterEffect))

					var_33_32.enabled = true

					local var_33_33 = GameObjectTools.GetOrAddComponent(var_33_31, typeof(DynamicBoneHelper))

					if var_33_33 then
						var_33_33:EnableDynamicBone(false)
					end

					arg_30_1:ShowWeapon(var_33_32.transform, false)

					arg_30_1.var_[var_33_29 .. "Animator"] = var_33_32.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_30_1.var_[var_33_29 .. "Animator"].applyRootMotion = true
					arg_30_1.var_[var_33_29 .. "LipSync"] = var_33_32.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_33_34 = arg_30_1.actors_["1066ui_story"].transform
			local var_33_35 = 3.8

			if var_33_35 < arg_30_1.time_ and arg_30_1.time_ <= var_33_35 + arg_33_0 then
				arg_30_1.var_.moveOldPos1066ui_story = var_33_34.localPosition
			end

			local var_33_36 = 0.001

			if var_33_35 <= arg_30_1.time_ and arg_30_1.time_ < var_33_35 + var_33_36 then
				local var_33_37 = (arg_30_1.time_ - var_33_35) / var_33_36
				local var_33_38 = Vector3.New(0, -0.77, -6.1)

				var_33_34.localPosition = Vector3.Lerp(arg_30_1.var_.moveOldPos1066ui_story, var_33_38, var_33_37)

				local var_33_39 = manager.ui.mainCamera.transform.position - var_33_34.position

				var_33_34.forward = Vector3.New(var_33_39.x, var_33_39.y, var_33_39.z)

				local var_33_40 = var_33_34.localEulerAngles

				var_33_40.z = 0
				var_33_40.x = 0
				var_33_34.localEulerAngles = var_33_40
			end

			if arg_30_1.time_ >= var_33_35 + var_33_36 and arg_30_1.time_ < var_33_35 + var_33_36 + arg_33_0 then
				var_33_34.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_33_41 = manager.ui.mainCamera.transform.position - var_33_34.position

				var_33_34.forward = Vector3.New(var_33_41.x, var_33_41.y, var_33_41.z)

				local var_33_42 = var_33_34.localEulerAngles

				var_33_42.z = 0
				var_33_42.x = 0
				var_33_34.localEulerAngles = var_33_42
			end

			local var_33_43 = arg_30_1.actors_["1066ui_story"]
			local var_33_44 = 3.8

			if var_33_44 < arg_30_1.time_ and arg_30_1.time_ <= var_33_44 + arg_33_0 and not isNil(var_33_43) and arg_30_1.var_.characterEffect1066ui_story == nil then
				arg_30_1.var_.characterEffect1066ui_story = var_33_43:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_33_45 = 0.200000002980232

			if var_33_44 <= arg_30_1.time_ and arg_30_1.time_ < var_33_44 + var_33_45 and not isNil(var_33_43) then
				local var_33_46 = (arg_30_1.time_ - var_33_44) / var_33_45

				if arg_30_1.var_.characterEffect1066ui_story and not isNil(var_33_43) then
					arg_30_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_30_1.time_ >= var_33_44 + var_33_45 and arg_30_1.time_ < var_33_44 + var_33_45 + arg_33_0 and not isNil(var_33_43) and arg_30_1.var_.characterEffect1066ui_story then
				arg_30_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_33_47 = 3.8

			if var_33_47 < arg_30_1.time_ and arg_30_1.time_ <= var_33_47 + arg_33_0 then
				arg_30_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action5_1")
			end

			local var_33_48 = 1.95

			if var_33_48 < arg_30_1.time_ and arg_30_1.time_ <= var_33_48 + arg_33_0 then
				arg_30_1.fswbg_:SetActive(false)
				arg_30_1.dialog_:SetActive(false)
				SetActive(arg_30_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_30_1:ShowNextGo(false)
			end

			local var_33_49 = 3.8

			if var_33_49 < arg_30_1.time_ and arg_30_1.time_ <= var_33_49 + arg_33_0 then
				arg_30_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_33_50 = 1.7
			local var_33_51 = 1

			if var_33_50 < arg_30_1.time_ and arg_30_1.time_ <= var_33_50 + arg_33_0 then
				local var_33_52 = "play"
				local var_33_53 = "effect"

				arg_30_1:AudioAction(var_33_52, var_33_53, "se_story_141", "se_story_141_amb_rooftop", "")
			end

			local var_33_54 = 0
			local var_33_55 = 0.2

			if var_33_54 < arg_30_1.time_ and arg_30_1.time_ <= var_33_54 + arg_33_0 then
				local var_33_56 = "play"
				local var_33_57 = "music"

				arg_30_1:AudioAction(var_33_56, var_33_57, "ui_battle", "ui_battle_stopbgm", "")

				local var_33_58 = ""
				local var_33_59 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_33_59 ~= "" then
					if arg_30_1.bgmTxt_.text ~= var_33_59 and arg_30_1.bgmTxt_.text ~= "" then
						if arg_30_1.bgmTxt2_.text ~= "" then
							arg_30_1.bgmTxt_.text = arg_30_1.bgmTxt2_.text
						end

						arg_30_1.bgmTxt2_.text = var_33_59

						arg_30_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_30_1.bgmTxt_.text = var_33_59
						arg_30_1.bgmTxt2_.text = var_33_59
					end

					if arg_30_1.bgmTimer then
						arg_30_1.bgmTimer:Stop()

						arg_30_1.bgmTimer = nil
					end

					if arg_30_1.settingData.show_music_name == 1 then
						arg_30_1.musicController:SetSelectedState("show")
						arg_30_1.musicAnimator_:Play("open", 0, 0)

						if arg_30_1.settingData.music_time ~= 0 then
							arg_30_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_30_1.settingData.music_time), function()
								if arg_30_1 == nil or isNil(arg_30_1.bgmTxt_) then
									return
								end

								arg_30_1.musicController:SetSelectedState("hide")
								arg_30_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_33_60 = 1.4
			local var_33_61 = 1

			if var_33_60 < arg_30_1.time_ and arg_30_1.time_ <= var_33_60 + arg_33_0 then
				local var_33_62 = "play"
				local var_33_63 = "music"

				arg_30_1:AudioAction(var_33_62, var_33_63, "bgm_side_daily08", "bgm_side_daily08", "bgm_side_daily08.awb")

				local var_33_64 = ""
				local var_33_65 = manager.audio:GetAudioName("bgm_side_daily08", "bgm_side_daily08")

				if var_33_65 ~= "" then
					if arg_30_1.bgmTxt_.text ~= var_33_65 and arg_30_1.bgmTxt_.text ~= "" then
						if arg_30_1.bgmTxt2_.text ~= "" then
							arg_30_1.bgmTxt_.text = arg_30_1.bgmTxt2_.text
						end

						arg_30_1.bgmTxt2_.text = var_33_65

						arg_30_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_30_1.bgmTxt_.text = var_33_65
						arg_30_1.bgmTxt2_.text = var_33_65
					end

					if arg_30_1.bgmTimer then
						arg_30_1.bgmTimer:Stop()

						arg_30_1.bgmTimer = nil
					end

					if arg_30_1.settingData.show_music_name == 1 then
						arg_30_1.musicController:SetSelectedState("show")
						arg_30_1.musicAnimator_:Play("open", 0, 0)

						if arg_30_1.settingData.music_time ~= 0 then
							arg_30_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_30_1.settingData.music_time), function()
								if arg_30_1 == nil or isNil(arg_30_1.bgmTxt_) then
									return
								end

								arg_30_1.musicController:SetSelectedState("hide")
								arg_30_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_30_1.frameCnt_ <= 1 then
				arg_30_1.dialog_:SetActive(false)
			end

			local var_33_66 = 4
			local var_33_67 = 0.375

			if var_33_66 < arg_30_1.time_ and arg_30_1.time_ <= var_33_66 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0

				arg_30_1.dialog_:SetActive(true)

				arg_30_1.dialogCg_.alpha = 0

				local var_33_68 = LeanTween.value(arg_30_1.dialog_, 0, 1, 0.3)

				var_33_68:setOnUpdate(LuaHelper.FloatAction(function(arg_36_0)
					arg_30_1.dialogCg_.alpha = arg_36_0
				end))
				var_33_68:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_30_1.dialog_)
					var_33_68:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_30_1.duration_ = arg_30_1.duration_ + 0.3

				SetActive(arg_30_1.leftNameGo_, true)

				local var_33_69 = arg_30_1:FormatText(StoryNameCfg[32].name)

				arg_30_1.leftNameTxt_.text = var_33_69

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_70 = arg_30_1:GetWordFromCfg(924011008)
				local var_33_71 = arg_30_1:FormatText(var_33_70.content)

				arg_30_1.text_.text = var_33_71

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_72 = 15
				local var_33_73 = utf8.len(var_33_71)
				local var_33_74 = var_33_72 <= 0 and var_33_67 or var_33_67 * (var_33_73 / var_33_72)

				if var_33_74 > 0 and var_33_67 < var_33_74 then
					arg_30_1.talkMaxDuration = var_33_74
					var_33_66 = var_33_66 + 0.3

					if var_33_74 + var_33_66 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_74 + var_33_66
					end
				end

				arg_30_1.text_.text = var_33_71
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011008", "story_v_side_old_924011.awb") ~= 0 then
					local var_33_75 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011008", "story_v_side_old_924011.awb") / 1000

					if var_33_75 + var_33_66 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_75 + var_33_66
					end

					if var_33_70.prefab_name ~= "" and arg_30_1.actors_[var_33_70.prefab_name] ~= nil then
						local var_33_76 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_70.prefab_name].transform, "story_v_side_old_924011", "924011008", "story_v_side_old_924011.awb")

						arg_30_1:RecordAudio("924011008", var_33_76)
						arg_30_1:RecordAudio("924011008", var_33_76)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011008", "story_v_side_old_924011.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011008", "story_v_side_old_924011.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_77 = var_33_66 + 0.3
			local var_33_78 = math.max(var_33_67, arg_30_1.talkMaxDuration)

			if var_33_77 <= arg_30_1.time_ and arg_30_1.time_ < var_33_77 + var_33_78 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_77) / var_33_78

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_77 + var_33_78 and arg_30_1.time_ < var_33_77 + var_33_78 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_30_1:InitPlayNodeList()
	end,
	Play924011009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 924011009
		arg_38_1.duration_ = 5

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play924011010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = arg_38_1.actors_["1066ui_story"]
			local var_41_1 = 0

			if var_41_1 < arg_38_1.time_ and arg_38_1.time_ <= var_41_1 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.characterEffect1066ui_story == nil then
				arg_38_1.var_.characterEffect1066ui_story = var_41_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_2 = 0.200000002980232

			if var_41_1 <= arg_38_1.time_ and arg_38_1.time_ < var_41_1 + var_41_2 and not isNil(var_41_0) then
				local var_41_3 = (arg_38_1.time_ - var_41_1) / var_41_2

				if arg_38_1.var_.characterEffect1066ui_story and not isNil(var_41_0) then
					local var_41_4 = Mathf.Lerp(0, 0.5, var_41_3)

					arg_38_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_38_1.var_.characterEffect1066ui_story.fillRatio = var_41_4
				end
			end

			if arg_38_1.time_ >= var_41_1 + var_41_2 and arg_38_1.time_ < var_41_1 + var_41_2 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.characterEffect1066ui_story then
				local var_41_5 = 0.5

				arg_38_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_38_1.var_.characterEffect1066ui_story.fillRatio = var_41_5
			end

			local var_41_6 = 0
			local var_41_7 = 0.25

			if var_41_6 < arg_38_1.time_ and arg_38_1.time_ <= var_41_6 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				local var_41_8 = arg_38_1:FormatText(StoryNameCfg[7].name)

				arg_38_1.leftNameTxt_.text = var_41_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, true)
				arg_38_1.iconController_:SetSelectedState("hero")

				arg_38_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_38_1.callingController_:SetSelectedState("normal")

				arg_38_1.keyicon_.color = Color.New(1, 1, 1)
				arg_38_1.icon_.color = Color.New(1, 1, 1)

				local var_41_9 = arg_38_1:GetWordFromCfg(924011009)
				local var_41_10 = arg_38_1:FormatText(var_41_9.content)

				arg_38_1.text_.text = var_41_10

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_11 = 10
				local var_41_12 = utf8.len(var_41_10)
				local var_41_13 = var_41_11 <= 0 and var_41_7 or var_41_7 * (var_41_12 / var_41_11)

				if var_41_13 > 0 and var_41_7 < var_41_13 then
					arg_38_1.talkMaxDuration = var_41_13

					if var_41_13 + var_41_6 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_13 + var_41_6
					end
				end

				arg_38_1.text_.text = var_41_10
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)
				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_14 = math.max(var_41_7, arg_38_1.talkMaxDuration)

			if var_41_6 <= arg_38_1.time_ and arg_38_1.time_ < var_41_6 + var_41_14 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_6) / var_41_14

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_6 + var_41_14 and arg_38_1.time_ < var_41_6 + var_41_14 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play924011010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 924011010
		arg_42_1.duration_ = 3.73

		local var_42_0 = {
			zh = 3.733,
			ja = 3.566
		}
		local var_42_1 = manager.audio:GetLocalizationFlag()

		if var_42_0[var_42_1] ~= nil then
			arg_42_1.duration_ = var_42_0[var_42_1]
		end

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play924011011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = arg_42_1.actors_["1066ui_story"]
			local var_45_1 = 0

			if var_45_1 < arg_42_1.time_ and arg_42_1.time_ <= var_45_1 + arg_45_0 and not isNil(var_45_0) and arg_42_1.var_.characterEffect1066ui_story == nil then
				arg_42_1.var_.characterEffect1066ui_story = var_45_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_2 = 0.200000002980232

			if var_45_1 <= arg_42_1.time_ and arg_42_1.time_ < var_45_1 + var_45_2 and not isNil(var_45_0) then
				local var_45_3 = (arg_42_1.time_ - var_45_1) / var_45_2

				if arg_42_1.var_.characterEffect1066ui_story and not isNil(var_45_0) then
					arg_42_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_42_1.time_ >= var_45_1 + var_45_2 and arg_42_1.time_ < var_45_1 + var_45_2 + arg_45_0 and not isNil(var_45_0) and arg_42_1.var_.characterEffect1066ui_story then
				arg_42_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_45_4 = 0

			if var_45_4 < arg_42_1.time_ and arg_42_1.time_ <= var_45_4 + arg_45_0 then
				arg_42_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action453")
			end

			local var_45_5 = 0

			if var_45_5 < arg_42_1.time_ and arg_42_1.time_ <= var_45_5 + arg_45_0 then
				arg_42_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_45_6 = 0
			local var_45_7 = 0.425

			if var_45_6 < arg_42_1.time_ and arg_42_1.time_ <= var_45_6 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				local var_45_8 = arg_42_1:FormatText(StoryNameCfg[32].name)

				arg_42_1.leftNameTxt_.text = var_45_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_9 = arg_42_1:GetWordFromCfg(924011010)
				local var_45_10 = arg_42_1:FormatText(var_45_9.content)

				arg_42_1.text_.text = var_45_10

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_11 = 17
				local var_45_12 = utf8.len(var_45_10)
				local var_45_13 = var_45_11 <= 0 and var_45_7 or var_45_7 * (var_45_12 / var_45_11)

				if var_45_13 > 0 and var_45_7 < var_45_13 then
					arg_42_1.talkMaxDuration = var_45_13

					if var_45_13 + var_45_6 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_13 + var_45_6
					end
				end

				arg_42_1.text_.text = var_45_10
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011010", "story_v_side_old_924011.awb") ~= 0 then
					local var_45_14 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011010", "story_v_side_old_924011.awb") / 1000

					if var_45_14 + var_45_6 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_14 + var_45_6
					end

					if var_45_9.prefab_name ~= "" and arg_42_1.actors_[var_45_9.prefab_name] ~= nil then
						local var_45_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_9.prefab_name].transform, "story_v_side_old_924011", "924011010", "story_v_side_old_924011.awb")

						arg_42_1:RecordAudio("924011010", var_45_15)
						arg_42_1:RecordAudio("924011010", var_45_15)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011010", "story_v_side_old_924011.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011010", "story_v_side_old_924011.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_16 = math.max(var_45_7, arg_42_1.talkMaxDuration)

			if var_45_6 <= arg_42_1.time_ and arg_42_1.time_ < var_45_6 + var_45_16 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_6) / var_45_16

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_6 + var_45_16 and arg_42_1.time_ < var_45_6 + var_45_16 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play924011011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 924011011
		arg_46_1.duration_ = 5

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play924011012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = arg_46_1.actors_["1066ui_story"]
			local var_49_1 = 0

			if var_49_1 < arg_46_1.time_ and arg_46_1.time_ <= var_49_1 + arg_49_0 and not isNil(var_49_0) and arg_46_1.var_.characterEffect1066ui_story == nil then
				arg_46_1.var_.characterEffect1066ui_story = var_49_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_2 = 0.200000002980232

			if var_49_1 <= arg_46_1.time_ and arg_46_1.time_ < var_49_1 + var_49_2 and not isNil(var_49_0) then
				local var_49_3 = (arg_46_1.time_ - var_49_1) / var_49_2

				if arg_46_1.var_.characterEffect1066ui_story and not isNil(var_49_0) then
					local var_49_4 = Mathf.Lerp(0, 0.5, var_49_3)

					arg_46_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_46_1.var_.characterEffect1066ui_story.fillRatio = var_49_4
				end
			end

			if arg_46_1.time_ >= var_49_1 + var_49_2 and arg_46_1.time_ < var_49_1 + var_49_2 + arg_49_0 and not isNil(var_49_0) and arg_46_1.var_.characterEffect1066ui_story then
				local var_49_5 = 0.5

				arg_46_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_46_1.var_.characterEffect1066ui_story.fillRatio = var_49_5
			end

			local var_49_6 = 0
			local var_49_7 = 0.65

			if var_49_6 < arg_46_1.time_ and arg_46_1.time_ <= var_49_6 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				local var_49_8 = arg_46_1:FormatText(StoryNameCfg[7].name)

				arg_46_1.leftNameTxt_.text = var_49_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, true)
				arg_46_1.iconController_:SetSelectedState("hero")

				arg_46_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_46_1.callingController_:SetSelectedState("normal")

				arg_46_1.keyicon_.color = Color.New(1, 1, 1)
				arg_46_1.icon_.color = Color.New(1, 1, 1)

				local var_49_9 = arg_46_1:GetWordFromCfg(924011011)
				local var_49_10 = arg_46_1:FormatText(var_49_9.content)

				arg_46_1.text_.text = var_49_10

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_11 = 26
				local var_49_12 = utf8.len(var_49_10)
				local var_49_13 = var_49_11 <= 0 and var_49_7 or var_49_7 * (var_49_12 / var_49_11)

				if var_49_13 > 0 and var_49_7 < var_49_13 then
					arg_46_1.talkMaxDuration = var_49_13

					if var_49_13 + var_49_6 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_13 + var_49_6
					end
				end

				arg_46_1.text_.text = var_49_10
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)
				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_14 = math.max(var_49_7, arg_46_1.talkMaxDuration)

			if var_49_6 <= arg_46_1.time_ and arg_46_1.time_ < var_49_6 + var_49_14 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_6) / var_49_14

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_6 + var_49_14 and arg_46_1.time_ < var_49_6 + var_49_14 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play924011012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 924011012
		arg_50_1.duration_ = 6.27

		local var_50_0 = {
			zh = 4.533,
			ja = 6.266
		}
		local var_50_1 = manager.audio:GetLocalizationFlag()

		if var_50_0[var_50_1] ~= nil then
			arg_50_1.duration_ = var_50_0[var_50_1]
		end

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play924011013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = arg_50_1.actors_["1066ui_story"]
			local var_53_1 = 0

			if var_53_1 < arg_50_1.time_ and arg_50_1.time_ <= var_53_1 + arg_53_0 and not isNil(var_53_0) and arg_50_1.var_.characterEffect1066ui_story == nil then
				arg_50_1.var_.characterEffect1066ui_story = var_53_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_2 = 0.200000002980232

			if var_53_1 <= arg_50_1.time_ and arg_50_1.time_ < var_53_1 + var_53_2 and not isNil(var_53_0) then
				local var_53_3 = (arg_50_1.time_ - var_53_1) / var_53_2

				if arg_50_1.var_.characterEffect1066ui_story and not isNil(var_53_0) then
					arg_50_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_50_1.time_ >= var_53_1 + var_53_2 and arg_50_1.time_ < var_53_1 + var_53_2 + arg_53_0 and not isNil(var_53_0) and arg_50_1.var_.characterEffect1066ui_story then
				arg_50_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_53_4 = 0

			if var_53_4 < arg_50_1.time_ and arg_50_1.time_ <= var_53_4 + arg_53_0 then
				arg_50_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action3_2")
			end

			local var_53_5 = 0

			if var_53_5 < arg_50_1.time_ and arg_50_1.time_ <= var_53_5 + arg_53_0 then
				arg_50_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_53_6 = 0
			local var_53_7 = 0.525

			if var_53_6 < arg_50_1.time_ and arg_50_1.time_ <= var_53_6 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				local var_53_8 = arg_50_1:FormatText(StoryNameCfg[32].name)

				arg_50_1.leftNameTxt_.text = var_53_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_9 = arg_50_1:GetWordFromCfg(924011012)
				local var_53_10 = arg_50_1:FormatText(var_53_9.content)

				arg_50_1.text_.text = var_53_10

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_11 = 21
				local var_53_12 = utf8.len(var_53_10)
				local var_53_13 = var_53_11 <= 0 and var_53_7 or var_53_7 * (var_53_12 / var_53_11)

				if var_53_13 > 0 and var_53_7 < var_53_13 then
					arg_50_1.talkMaxDuration = var_53_13

					if var_53_13 + var_53_6 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_13 + var_53_6
					end
				end

				arg_50_1.text_.text = var_53_10
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011012", "story_v_side_old_924011.awb") ~= 0 then
					local var_53_14 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011012", "story_v_side_old_924011.awb") / 1000

					if var_53_14 + var_53_6 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_14 + var_53_6
					end

					if var_53_9.prefab_name ~= "" and arg_50_1.actors_[var_53_9.prefab_name] ~= nil then
						local var_53_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_9.prefab_name].transform, "story_v_side_old_924011", "924011012", "story_v_side_old_924011.awb")

						arg_50_1:RecordAudio("924011012", var_53_15)
						arg_50_1:RecordAudio("924011012", var_53_15)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011012", "story_v_side_old_924011.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011012", "story_v_side_old_924011.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_16 = math.max(var_53_7, arg_50_1.talkMaxDuration)

			if var_53_6 <= arg_50_1.time_ and arg_50_1.time_ < var_53_6 + var_53_16 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_6) / var_53_16

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_6 + var_53_16 and arg_50_1.time_ < var_53_6 + var_53_16 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play924011013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 924011013
		arg_54_1.duration_ = 5

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play924011014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = arg_54_1.actors_["1066ui_story"]
			local var_57_1 = 0

			if var_57_1 < arg_54_1.time_ and arg_54_1.time_ <= var_57_1 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.characterEffect1066ui_story == nil then
				arg_54_1.var_.characterEffect1066ui_story = var_57_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_2 = 0.200000002980232

			if var_57_1 <= arg_54_1.time_ and arg_54_1.time_ < var_57_1 + var_57_2 and not isNil(var_57_0) then
				local var_57_3 = (arg_54_1.time_ - var_57_1) / var_57_2

				if arg_54_1.var_.characterEffect1066ui_story and not isNil(var_57_0) then
					local var_57_4 = Mathf.Lerp(0, 0.5, var_57_3)

					arg_54_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_54_1.var_.characterEffect1066ui_story.fillRatio = var_57_4
				end
			end

			if arg_54_1.time_ >= var_57_1 + var_57_2 and arg_54_1.time_ < var_57_1 + var_57_2 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.characterEffect1066ui_story then
				local var_57_5 = 0.5

				arg_54_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_54_1.var_.characterEffect1066ui_story.fillRatio = var_57_5
			end

			local var_57_6 = 0
			local var_57_7 = 1.625

			if var_57_6 < arg_54_1.time_ and arg_54_1.time_ <= var_57_6 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				local var_57_8 = arg_54_1:FormatText(StoryNameCfg[7].name)

				arg_54_1.leftNameTxt_.text = var_57_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, true)
				arg_54_1.iconController_:SetSelectedState("hero")

				arg_54_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_54_1.callingController_:SetSelectedState("normal")

				arg_54_1.keyicon_.color = Color.New(1, 1, 1)
				arg_54_1.icon_.color = Color.New(1, 1, 1)

				local var_57_9 = arg_54_1:GetWordFromCfg(924011013)
				local var_57_10 = arg_54_1:FormatText(var_57_9.content)

				arg_54_1.text_.text = var_57_10

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_11 = 65
				local var_57_12 = utf8.len(var_57_10)
				local var_57_13 = var_57_11 <= 0 and var_57_7 or var_57_7 * (var_57_12 / var_57_11)

				if var_57_13 > 0 and var_57_7 < var_57_13 then
					arg_54_1.talkMaxDuration = var_57_13

					if var_57_13 + var_57_6 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_13 + var_57_6
					end
				end

				arg_54_1.text_.text = var_57_10
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)
				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_14 = math.max(var_57_7, arg_54_1.talkMaxDuration)

			if var_57_6 <= arg_54_1.time_ and arg_54_1.time_ < var_57_6 + var_57_14 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_6) / var_57_14

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_6 + var_57_14 and arg_54_1.time_ < var_57_6 + var_57_14 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play924011014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 924011014
		arg_58_1.duration_ = 3.83

		local var_58_0 = {
			zh = 3.833,
			ja = 3.266
		}
		local var_58_1 = manager.audio:GetLocalizationFlag()

		if var_58_0[var_58_1] ~= nil then
			arg_58_1.duration_ = var_58_0[var_58_1]
		end

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play924011015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = arg_58_1.actors_["1066ui_story"]
			local var_61_1 = 0

			if var_61_1 < arg_58_1.time_ and arg_58_1.time_ <= var_61_1 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.characterEffect1066ui_story == nil then
				arg_58_1.var_.characterEffect1066ui_story = var_61_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_2 = 0.200000002980232

			if var_61_1 <= arg_58_1.time_ and arg_58_1.time_ < var_61_1 + var_61_2 and not isNil(var_61_0) then
				local var_61_3 = (arg_58_1.time_ - var_61_1) / var_61_2

				if arg_58_1.var_.characterEffect1066ui_story and not isNil(var_61_0) then
					arg_58_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_58_1.time_ >= var_61_1 + var_61_2 and arg_58_1.time_ < var_61_1 + var_61_2 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.characterEffect1066ui_story then
				arg_58_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_61_4 = 0
			local var_61_5 = 0.45

			if var_61_4 < arg_58_1.time_ and arg_58_1.time_ <= var_61_4 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_6 = arg_58_1:FormatText(StoryNameCfg[32].name)

				arg_58_1.leftNameTxt_.text = var_61_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_7 = arg_58_1:GetWordFromCfg(924011014)
				local var_61_8 = arg_58_1:FormatText(var_61_7.content)

				arg_58_1.text_.text = var_61_8

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_9 = 18
				local var_61_10 = utf8.len(var_61_8)
				local var_61_11 = var_61_9 <= 0 and var_61_5 or var_61_5 * (var_61_10 / var_61_9)

				if var_61_11 > 0 and var_61_5 < var_61_11 then
					arg_58_1.talkMaxDuration = var_61_11

					if var_61_11 + var_61_4 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_11 + var_61_4
					end
				end

				arg_58_1.text_.text = var_61_8
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011014", "story_v_side_old_924011.awb") ~= 0 then
					local var_61_12 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011014", "story_v_side_old_924011.awb") / 1000

					if var_61_12 + var_61_4 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_12 + var_61_4
					end

					if var_61_7.prefab_name ~= "" and arg_58_1.actors_[var_61_7.prefab_name] ~= nil then
						local var_61_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_7.prefab_name].transform, "story_v_side_old_924011", "924011014", "story_v_side_old_924011.awb")

						arg_58_1:RecordAudio("924011014", var_61_13)
						arg_58_1:RecordAudio("924011014", var_61_13)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011014", "story_v_side_old_924011.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011014", "story_v_side_old_924011.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_14 = math.max(var_61_5, arg_58_1.talkMaxDuration)

			if var_61_4 <= arg_58_1.time_ and arg_58_1.time_ < var_61_4 + var_61_14 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_4) / var_61_14

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_4 + var_61_14 and arg_58_1.time_ < var_61_4 + var_61_14 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play924011015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 924011015
		arg_62_1.duration_ = 5

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play924011016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = arg_62_1.actors_["1066ui_story"]
			local var_65_1 = 0

			if var_65_1 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.characterEffect1066ui_story == nil then
				arg_62_1.var_.characterEffect1066ui_story = var_65_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_2 = 0.200000002980232

			if var_65_1 <= arg_62_1.time_ and arg_62_1.time_ < var_65_1 + var_65_2 and not isNil(var_65_0) then
				local var_65_3 = (arg_62_1.time_ - var_65_1) / var_65_2

				if arg_62_1.var_.characterEffect1066ui_story and not isNil(var_65_0) then
					local var_65_4 = Mathf.Lerp(0, 0.5, var_65_3)

					arg_62_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_62_1.var_.characterEffect1066ui_story.fillRatio = var_65_4
				end
			end

			if arg_62_1.time_ >= var_65_1 + var_65_2 and arg_62_1.time_ < var_65_1 + var_65_2 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.characterEffect1066ui_story then
				local var_65_5 = 0.5

				arg_62_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_62_1.var_.characterEffect1066ui_story.fillRatio = var_65_5
			end

			local var_65_6 = 0
			local var_65_7 = 1.275

			if var_65_6 < arg_62_1.time_ and arg_62_1.time_ <= var_65_6 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_8 = arg_62_1:FormatText(StoryNameCfg[7].name)

				arg_62_1.leftNameTxt_.text = var_65_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, true)
				arg_62_1.iconController_:SetSelectedState("hero")

				arg_62_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_62_1.callingController_:SetSelectedState("normal")

				arg_62_1.keyicon_.color = Color.New(1, 1, 1)
				arg_62_1.icon_.color = Color.New(1, 1, 1)

				local var_65_9 = arg_62_1:GetWordFromCfg(924011015)
				local var_65_10 = arg_62_1:FormatText(var_65_9.content)

				arg_62_1.text_.text = var_65_10

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_11 = 51
				local var_65_12 = utf8.len(var_65_10)
				local var_65_13 = var_65_11 <= 0 and var_65_7 or var_65_7 * (var_65_12 / var_65_11)

				if var_65_13 > 0 and var_65_7 < var_65_13 then
					arg_62_1.talkMaxDuration = var_65_13

					if var_65_13 + var_65_6 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_13 + var_65_6
					end
				end

				arg_62_1.text_.text = var_65_10
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)
				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_14 = math.max(var_65_7, arg_62_1.talkMaxDuration)

			if var_65_6 <= arg_62_1.time_ and arg_62_1.time_ < var_65_6 + var_65_14 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_6) / var_65_14

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_6 + var_65_14 and arg_62_1.time_ < var_65_6 + var_65_14 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play924011016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 924011016
		arg_66_1.duration_ = 5.07

		local var_66_0 = {
			zh = 4.3,
			ja = 5.066
		}
		local var_66_1 = manager.audio:GetLocalizationFlag()

		if var_66_0[var_66_1] ~= nil then
			arg_66_1.duration_ = var_66_0[var_66_1]
		end

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play924011017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = arg_66_1.actors_["1066ui_story"]
			local var_69_1 = 0

			if var_69_1 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect1066ui_story == nil then
				arg_66_1.var_.characterEffect1066ui_story = var_69_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_2 = 0.200000002980232

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_2 and not isNil(var_69_0) then
				local var_69_3 = (arg_66_1.time_ - var_69_1) / var_69_2

				if arg_66_1.var_.characterEffect1066ui_story and not isNil(var_69_0) then
					arg_66_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= var_69_1 + var_69_2 and arg_66_1.time_ < var_69_1 + var_69_2 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect1066ui_story then
				arg_66_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_69_4 = 0

			if var_69_4 < arg_66_1.time_ and arg_66_1.time_ <= var_69_4 + arg_69_0 then
				arg_66_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action4_1")
			end

			local var_69_5 = 0

			if var_69_5 < arg_66_1.time_ and arg_66_1.time_ <= var_69_5 + arg_69_0 then
				arg_66_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_69_6 = 0
			local var_69_7 = 0.55

			if var_69_6 < arg_66_1.time_ and arg_66_1.time_ <= var_69_6 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_8 = arg_66_1:FormatText(StoryNameCfg[32].name)

				arg_66_1.leftNameTxt_.text = var_69_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_9 = arg_66_1:GetWordFromCfg(924011016)
				local var_69_10 = arg_66_1:FormatText(var_69_9.content)

				arg_66_1.text_.text = var_69_10

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_11 = 22
				local var_69_12 = utf8.len(var_69_10)
				local var_69_13 = var_69_11 <= 0 and var_69_7 or var_69_7 * (var_69_12 / var_69_11)

				if var_69_13 > 0 and var_69_7 < var_69_13 then
					arg_66_1.talkMaxDuration = var_69_13

					if var_69_13 + var_69_6 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_13 + var_69_6
					end
				end

				arg_66_1.text_.text = var_69_10
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011016", "story_v_side_old_924011.awb") ~= 0 then
					local var_69_14 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011016", "story_v_side_old_924011.awb") / 1000

					if var_69_14 + var_69_6 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_14 + var_69_6
					end

					if var_69_9.prefab_name ~= "" and arg_66_1.actors_[var_69_9.prefab_name] ~= nil then
						local var_69_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_9.prefab_name].transform, "story_v_side_old_924011", "924011016", "story_v_side_old_924011.awb")

						arg_66_1:RecordAudio("924011016", var_69_15)
						arg_66_1:RecordAudio("924011016", var_69_15)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011016", "story_v_side_old_924011.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011016", "story_v_side_old_924011.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_16 = math.max(var_69_7, arg_66_1.talkMaxDuration)

			if var_69_6 <= arg_66_1.time_ and arg_66_1.time_ < var_69_6 + var_69_16 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_6) / var_69_16

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_6 + var_69_16 and arg_66_1.time_ < var_69_6 + var_69_16 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play924011017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 924011017
		arg_70_1.duration_ = 5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play924011018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = arg_70_1.actors_["1066ui_story"]
			local var_73_1 = 0

			if var_73_1 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.characterEffect1066ui_story == nil then
				arg_70_1.var_.characterEffect1066ui_story = var_73_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_2 = 0.200000002980232

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_2 and not isNil(var_73_0) then
				local var_73_3 = (arg_70_1.time_ - var_73_1) / var_73_2

				if arg_70_1.var_.characterEffect1066ui_story and not isNil(var_73_0) then
					local var_73_4 = Mathf.Lerp(0, 0.5, var_73_3)

					arg_70_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_70_1.var_.characterEffect1066ui_story.fillRatio = var_73_4
				end
			end

			if arg_70_1.time_ >= var_73_1 + var_73_2 and arg_70_1.time_ < var_73_1 + var_73_2 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.characterEffect1066ui_story then
				local var_73_5 = 0.5

				arg_70_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_70_1.var_.characterEffect1066ui_story.fillRatio = var_73_5
			end

			local var_73_6 = 0
			local var_73_7 = 0.625

			if var_73_6 < arg_70_1.time_ and arg_70_1.time_ <= var_73_6 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_8 = arg_70_1:FormatText(StoryNameCfg[7].name)

				arg_70_1.leftNameTxt_.text = var_73_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, true)
				arg_70_1.iconController_:SetSelectedState("hero")

				arg_70_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_70_1.callingController_:SetSelectedState("normal")

				arg_70_1.keyicon_.color = Color.New(1, 1, 1)
				arg_70_1.icon_.color = Color.New(1, 1, 1)

				local var_73_9 = arg_70_1:GetWordFromCfg(924011017)
				local var_73_10 = arg_70_1:FormatText(var_73_9.content)

				arg_70_1.text_.text = var_73_10

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_11 = 25
				local var_73_12 = utf8.len(var_73_10)
				local var_73_13 = var_73_11 <= 0 and var_73_7 or var_73_7 * (var_73_12 / var_73_11)

				if var_73_13 > 0 and var_73_7 < var_73_13 then
					arg_70_1.talkMaxDuration = var_73_13

					if var_73_13 + var_73_6 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_13 + var_73_6
					end
				end

				arg_70_1.text_.text = var_73_10
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_14 = math.max(var_73_7, arg_70_1.talkMaxDuration)

			if var_73_6 <= arg_70_1.time_ and arg_70_1.time_ < var_73_6 + var_73_14 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_6) / var_73_14

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_6 + var_73_14 and arg_70_1.time_ < var_73_6 + var_73_14 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play924011018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 924011018
		arg_74_1.duration_ = 5

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play924011019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0
			local var_77_1 = 0.775

			if var_77_0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_2 = arg_74_1:FormatText(StoryNameCfg[7].name)

				arg_74_1.leftNameTxt_.text = var_77_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, true)
				arg_74_1.iconController_:SetSelectedState("hero")

				arg_74_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_74_1.callingController_:SetSelectedState("normal")

				arg_74_1.keyicon_.color = Color.New(1, 1, 1)
				arg_74_1.icon_.color = Color.New(1, 1, 1)

				local var_77_3 = arg_74_1:GetWordFromCfg(924011018)
				local var_77_4 = arg_74_1:FormatText(var_77_3.content)

				arg_74_1.text_.text = var_77_4

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_5 = 31
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
				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_8 = math.max(var_77_1, arg_74_1.talkMaxDuration)

			if var_77_0 <= arg_74_1.time_ and arg_74_1.time_ < var_77_0 + var_77_8 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_0) / var_77_8

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_0 + var_77_8 and arg_74_1.time_ < var_77_0 + var_77_8 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play924011019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 924011019
		arg_78_1.duration_ = 2

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play924011020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = arg_78_1.actors_["1066ui_story"]
			local var_81_1 = 0

			if var_81_1 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.characterEffect1066ui_story == nil then
				arg_78_1.var_.characterEffect1066ui_story = var_81_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_2 = 0.200000002980232

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_2 and not isNil(var_81_0) then
				local var_81_3 = (arg_78_1.time_ - var_81_1) / var_81_2

				if arg_78_1.var_.characterEffect1066ui_story and not isNil(var_81_0) then
					arg_78_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_78_1.time_ >= var_81_1 + var_81_2 and arg_78_1.time_ < var_81_1 + var_81_2 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.characterEffect1066ui_story then
				arg_78_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_81_4 = 0

			if var_81_4 < arg_78_1.time_ and arg_78_1.time_ <= var_81_4 + arg_81_0 then
				arg_78_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_81_5 = 0
			local var_81_6 = 0.1

			if var_81_5 < arg_78_1.time_ and arg_78_1.time_ <= var_81_5 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_7 = arg_78_1:FormatText(StoryNameCfg[32].name)

				arg_78_1.leftNameTxt_.text = var_81_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_8 = arg_78_1:GetWordFromCfg(924011019)
				local var_81_9 = arg_78_1:FormatText(var_81_8.content)

				arg_78_1.text_.text = var_81_9

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_10 = 4
				local var_81_11 = utf8.len(var_81_9)
				local var_81_12 = var_81_10 <= 0 and var_81_6 or var_81_6 * (var_81_11 / var_81_10)

				if var_81_12 > 0 and var_81_6 < var_81_12 then
					arg_78_1.talkMaxDuration = var_81_12

					if var_81_12 + var_81_5 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_12 + var_81_5
					end
				end

				arg_78_1.text_.text = var_81_9
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011019", "story_v_side_old_924011.awb") ~= 0 then
					local var_81_13 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011019", "story_v_side_old_924011.awb") / 1000

					if var_81_13 + var_81_5 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_13 + var_81_5
					end

					if var_81_8.prefab_name ~= "" and arg_78_1.actors_[var_81_8.prefab_name] ~= nil then
						local var_81_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_8.prefab_name].transform, "story_v_side_old_924011", "924011019", "story_v_side_old_924011.awb")

						arg_78_1:RecordAudio("924011019", var_81_14)
						arg_78_1:RecordAudio("924011019", var_81_14)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011019", "story_v_side_old_924011.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011019", "story_v_side_old_924011.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_15 = math.max(var_81_6, arg_78_1.talkMaxDuration)

			if var_81_5 <= arg_78_1.time_ and arg_78_1.time_ < var_81_5 + var_81_15 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_5) / var_81_15

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_5 + var_81_15 and arg_78_1.time_ < var_81_5 + var_81_15 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play924011020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 924011020
		arg_82_1.duration_ = 5

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play924011021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = arg_82_1.actors_["1066ui_story"]
			local var_85_1 = 0

			if var_85_1 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.characterEffect1066ui_story == nil then
				arg_82_1.var_.characterEffect1066ui_story = var_85_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_2 = 0.200000002980232

			if var_85_1 <= arg_82_1.time_ and arg_82_1.time_ < var_85_1 + var_85_2 and not isNil(var_85_0) then
				local var_85_3 = (arg_82_1.time_ - var_85_1) / var_85_2

				if arg_82_1.var_.characterEffect1066ui_story and not isNil(var_85_0) then
					local var_85_4 = Mathf.Lerp(0, 0.5, var_85_3)

					arg_82_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_82_1.var_.characterEffect1066ui_story.fillRatio = var_85_4
				end
			end

			if arg_82_1.time_ >= var_85_1 + var_85_2 and arg_82_1.time_ < var_85_1 + var_85_2 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.characterEffect1066ui_story then
				local var_85_5 = 0.5

				arg_82_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_82_1.var_.characterEffect1066ui_story.fillRatio = var_85_5
			end

			local var_85_6 = 0
			local var_85_7 = 1.2

			if var_85_6 < arg_82_1.time_ and arg_82_1.time_ <= var_85_6 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_8 = arg_82_1:FormatText(StoryNameCfg[7].name)

				arg_82_1.leftNameTxt_.text = var_85_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, true)
				arg_82_1.iconController_:SetSelectedState("hero")

				arg_82_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_82_1.callingController_:SetSelectedState("normal")

				arg_82_1.keyicon_.color = Color.New(1, 1, 1)
				arg_82_1.icon_.color = Color.New(1, 1, 1)

				local var_85_9 = arg_82_1:GetWordFromCfg(924011020)
				local var_85_10 = arg_82_1:FormatText(var_85_9.content)

				arg_82_1.text_.text = var_85_10

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_11 = 48
				local var_85_12 = utf8.len(var_85_10)
				local var_85_13 = var_85_11 <= 0 and var_85_7 or var_85_7 * (var_85_12 / var_85_11)

				if var_85_13 > 0 and var_85_7 < var_85_13 then
					arg_82_1.talkMaxDuration = var_85_13

					if var_85_13 + var_85_6 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_13 + var_85_6
					end
				end

				arg_82_1.text_.text = var_85_10
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)
				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_14 = math.max(var_85_7, arg_82_1.talkMaxDuration)

			if var_85_6 <= arg_82_1.time_ and arg_82_1.time_ < var_85_6 + var_85_14 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_6) / var_85_14

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_6 + var_85_14 and arg_82_1.time_ < var_85_6 + var_85_14 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play924011021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 924011021
		arg_86_1.duration_ = 2

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play924011022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = arg_86_1.actors_["1066ui_story"]
			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.characterEffect1066ui_story == nil then
				arg_86_1.var_.characterEffect1066ui_story = var_89_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_2 = 0.200000002980232

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_2 and not isNil(var_89_0) then
				local var_89_3 = (arg_86_1.time_ - var_89_1) / var_89_2

				if arg_86_1.var_.characterEffect1066ui_story and not isNil(var_89_0) then
					arg_86_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_86_1.time_ >= var_89_1 + var_89_2 and arg_86_1.time_ < var_89_1 + var_89_2 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.characterEffect1066ui_story then
				arg_86_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_89_4 = 0

			if var_89_4 < arg_86_1.time_ and arg_86_1.time_ <= var_89_4 + arg_89_0 then
				arg_86_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action442")
			end

			local var_89_5 = 0

			if var_89_5 < arg_86_1.time_ and arg_86_1.time_ <= var_89_5 + arg_89_0 then
				arg_86_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_89_6 = 0
			local var_89_7 = 0.05

			if var_89_6 < arg_86_1.time_ and arg_86_1.time_ <= var_89_6 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_8 = arg_86_1:FormatText(StoryNameCfg[32].name)

				arg_86_1.leftNameTxt_.text = var_89_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_9 = arg_86_1:GetWordFromCfg(924011021)
				local var_89_10 = arg_86_1:FormatText(var_89_9.content)

				arg_86_1.text_.text = var_89_10

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_11 = 2
				local var_89_12 = utf8.len(var_89_10)
				local var_89_13 = var_89_11 <= 0 and var_89_7 or var_89_7 * (var_89_12 / var_89_11)

				if var_89_13 > 0 and var_89_7 < var_89_13 then
					arg_86_1.talkMaxDuration = var_89_13

					if var_89_13 + var_89_6 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_13 + var_89_6
					end
				end

				arg_86_1.text_.text = var_89_10
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011021", "story_v_side_old_924011.awb") ~= 0 then
					local var_89_14 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011021", "story_v_side_old_924011.awb") / 1000

					if var_89_14 + var_89_6 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_14 + var_89_6
					end

					if var_89_9.prefab_name ~= "" and arg_86_1.actors_[var_89_9.prefab_name] ~= nil then
						local var_89_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_9.prefab_name].transform, "story_v_side_old_924011", "924011021", "story_v_side_old_924011.awb")

						arg_86_1:RecordAudio("924011021", var_89_15)
						arg_86_1:RecordAudio("924011021", var_89_15)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011021", "story_v_side_old_924011.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011021", "story_v_side_old_924011.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_16 = math.max(var_89_7, arg_86_1.talkMaxDuration)

			if var_89_6 <= arg_86_1.time_ and arg_86_1.time_ < var_89_6 + var_89_16 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_6) / var_89_16

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_6 + var_89_16 and arg_86_1.time_ < var_89_6 + var_89_16 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play924011022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 924011022
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play924011023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = arg_90_1.actors_["1066ui_story"]
			local var_93_1 = 0

			if var_93_1 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.characterEffect1066ui_story == nil then
				arg_90_1.var_.characterEffect1066ui_story = var_93_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_2 = 0.200000002980232

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_2 and not isNil(var_93_0) then
				local var_93_3 = (arg_90_1.time_ - var_93_1) / var_93_2

				if arg_90_1.var_.characterEffect1066ui_story and not isNil(var_93_0) then
					local var_93_4 = Mathf.Lerp(0, 0.5, var_93_3)

					arg_90_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_90_1.var_.characterEffect1066ui_story.fillRatio = var_93_4
				end
			end

			if arg_90_1.time_ >= var_93_1 + var_93_2 and arg_90_1.time_ < var_93_1 + var_93_2 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.characterEffect1066ui_story then
				local var_93_5 = 0.5

				arg_90_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_90_1.var_.characterEffect1066ui_story.fillRatio = var_93_5
			end

			local var_93_6 = 0
			local var_93_7 = 0.3

			if var_93_6 < arg_90_1.time_ and arg_90_1.time_ <= var_93_6 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_8 = arg_90_1:FormatText(StoryNameCfg[7].name)

				arg_90_1.leftNameTxt_.text = var_93_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, true)
				arg_90_1.iconController_:SetSelectedState("hero")

				arg_90_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_90_1.callingController_:SetSelectedState("normal")

				arg_90_1.keyicon_.color = Color.New(1, 1, 1)
				arg_90_1.icon_.color = Color.New(1, 1, 1)

				local var_93_9 = arg_90_1:GetWordFromCfg(924011022)
				local var_93_10 = arg_90_1:FormatText(var_93_9.content)

				arg_90_1.text_.text = var_93_10

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_11 = 12
				local var_93_12 = utf8.len(var_93_10)
				local var_93_13 = var_93_11 <= 0 and var_93_7 or var_93_7 * (var_93_12 / var_93_11)

				if var_93_13 > 0 and var_93_7 < var_93_13 then
					arg_90_1.talkMaxDuration = var_93_13

					if var_93_13 + var_93_6 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_13 + var_93_6
					end
				end

				arg_90_1.text_.text = var_93_10
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_14 = math.max(var_93_7, arg_90_1.talkMaxDuration)

			if var_93_6 <= arg_90_1.time_ and arg_90_1.time_ < var_93_6 + var_93_14 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_6) / var_93_14

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_6 + var_93_14 and arg_90_1.time_ < var_93_6 + var_93_14 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play924011023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 924011023
		arg_94_1.duration_ = 5.33

		local var_94_0 = {
			zh = 5.066,
			ja = 5.333
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
				arg_94_0:Play924011024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = arg_94_1.actors_["1066ui_story"]
			local var_97_1 = 0

			if var_97_1 < arg_94_1.time_ and arg_94_1.time_ <= var_97_1 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect1066ui_story == nil then
				arg_94_1.var_.characterEffect1066ui_story = var_97_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_2 = 0.200000002980232

			if var_97_1 <= arg_94_1.time_ and arg_94_1.time_ < var_97_1 + var_97_2 and not isNil(var_97_0) then
				local var_97_3 = (arg_94_1.time_ - var_97_1) / var_97_2

				if arg_94_1.var_.characterEffect1066ui_story and not isNil(var_97_0) then
					arg_94_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_94_1.time_ >= var_97_1 + var_97_2 and arg_94_1.time_ < var_97_1 + var_97_2 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect1066ui_story then
				arg_94_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_97_4 = 0

			if var_97_4 < arg_94_1.time_ and arg_94_1.time_ <= var_97_4 + arg_97_0 then
				arg_94_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_97_5 = 0
			local var_97_6 = 0.55

			if var_97_5 < arg_94_1.time_ and arg_94_1.time_ <= var_97_5 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_7 = arg_94_1:FormatText(StoryNameCfg[32].name)

				arg_94_1.leftNameTxt_.text = var_97_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_8 = arg_94_1:GetWordFromCfg(924011023)
				local var_97_9 = arg_94_1:FormatText(var_97_8.content)

				arg_94_1.text_.text = var_97_9

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_10 = 22
				local var_97_11 = utf8.len(var_97_9)
				local var_97_12 = var_97_10 <= 0 and var_97_6 or var_97_6 * (var_97_11 / var_97_10)

				if var_97_12 > 0 and var_97_6 < var_97_12 then
					arg_94_1.talkMaxDuration = var_97_12

					if var_97_12 + var_97_5 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_12 + var_97_5
					end
				end

				arg_94_1.text_.text = var_97_9
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011023", "story_v_side_old_924011.awb") ~= 0 then
					local var_97_13 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011023", "story_v_side_old_924011.awb") / 1000

					if var_97_13 + var_97_5 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_13 + var_97_5
					end

					if var_97_8.prefab_name ~= "" and arg_94_1.actors_[var_97_8.prefab_name] ~= nil then
						local var_97_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_8.prefab_name].transform, "story_v_side_old_924011", "924011023", "story_v_side_old_924011.awb")

						arg_94_1:RecordAudio("924011023", var_97_14)
						arg_94_1:RecordAudio("924011023", var_97_14)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011023", "story_v_side_old_924011.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011023", "story_v_side_old_924011.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_15 = math.max(var_97_6, arg_94_1.talkMaxDuration)

			if var_97_5 <= arg_94_1.time_ and arg_94_1.time_ < var_97_5 + var_97_15 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_5) / var_97_15

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_5 + var_97_15 and arg_94_1.time_ < var_97_5 + var_97_15 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play924011024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 924011024
		arg_98_1.duration_ = 5

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play924011025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = arg_98_1.actors_["1066ui_story"]
			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect1066ui_story == nil then
				arg_98_1.var_.characterEffect1066ui_story = var_101_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_2 = 0.200000002980232

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_2 and not isNil(var_101_0) then
				local var_101_3 = (arg_98_1.time_ - var_101_1) / var_101_2

				if arg_98_1.var_.characterEffect1066ui_story and not isNil(var_101_0) then
					local var_101_4 = Mathf.Lerp(0, 0.5, var_101_3)

					arg_98_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_98_1.var_.characterEffect1066ui_story.fillRatio = var_101_4
				end
			end

			if arg_98_1.time_ >= var_101_1 + var_101_2 and arg_98_1.time_ < var_101_1 + var_101_2 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect1066ui_story then
				local var_101_5 = 0.5

				arg_98_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_98_1.var_.characterEffect1066ui_story.fillRatio = var_101_5
			end

			local var_101_6 = 0
			local var_101_7 = 0.1

			if var_101_6 < arg_98_1.time_ and arg_98_1.time_ <= var_101_6 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_8 = arg_98_1:FormatText(StoryNameCfg[7].name)

				arg_98_1.leftNameTxt_.text = var_101_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, true)
				arg_98_1.iconController_:SetSelectedState("hero")

				arg_98_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_98_1.callingController_:SetSelectedState("normal")

				arg_98_1.keyicon_.color = Color.New(1, 1, 1)
				arg_98_1.icon_.color = Color.New(1, 1, 1)

				local var_101_9 = arg_98_1:GetWordFromCfg(924011024)
				local var_101_10 = arg_98_1:FormatText(var_101_9.content)

				arg_98_1.text_.text = var_101_10

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_11 = 4
				local var_101_12 = utf8.len(var_101_10)
				local var_101_13 = var_101_11 <= 0 and var_101_7 or var_101_7 * (var_101_12 / var_101_11)

				if var_101_13 > 0 and var_101_7 < var_101_13 then
					arg_98_1.talkMaxDuration = var_101_13

					if var_101_13 + var_101_6 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_13 + var_101_6
					end
				end

				arg_98_1.text_.text = var_101_10
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_14 = math.max(var_101_7, arg_98_1.talkMaxDuration)

			if var_101_6 <= arg_98_1.time_ and arg_98_1.time_ < var_101_6 + var_101_14 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_6) / var_101_14

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_6 + var_101_14 and arg_98_1.time_ < var_101_6 + var_101_14 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play924011025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 924011025
		arg_102_1.duration_ = 7.17

		local var_102_0 = {
			zh = 4.7,
			ja = 7.166
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
				arg_102_0:Play924011026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = arg_102_1.actors_["1066ui_story"]
			local var_105_1 = 0

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect1066ui_story == nil then
				arg_102_1.var_.characterEffect1066ui_story = var_105_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_2 = 0.200000002980232

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_2 and not isNil(var_105_0) then
				local var_105_3 = (arg_102_1.time_ - var_105_1) / var_105_2

				if arg_102_1.var_.characterEffect1066ui_story and not isNil(var_105_0) then
					arg_102_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= var_105_1 + var_105_2 and arg_102_1.time_ < var_105_1 + var_105_2 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect1066ui_story then
				arg_102_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_105_4 = 0

			if var_105_4 < arg_102_1.time_ and arg_102_1.time_ <= var_105_4 + arg_105_0 then
				arg_102_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action423")
			end

			local var_105_5 = 0

			if var_105_5 < arg_102_1.time_ and arg_102_1.time_ <= var_105_5 + arg_105_0 then
				arg_102_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_105_6 = 0
			local var_105_7 = 0.525

			if var_105_6 < arg_102_1.time_ and arg_102_1.time_ <= var_105_6 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_8 = arg_102_1:FormatText(StoryNameCfg[32].name)

				arg_102_1.leftNameTxt_.text = var_105_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_9 = arg_102_1:GetWordFromCfg(924011025)
				local var_105_10 = arg_102_1:FormatText(var_105_9.content)

				arg_102_1.text_.text = var_105_10

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_11 = 21
				local var_105_12 = utf8.len(var_105_10)
				local var_105_13 = var_105_11 <= 0 and var_105_7 or var_105_7 * (var_105_12 / var_105_11)

				if var_105_13 > 0 and var_105_7 < var_105_13 then
					arg_102_1.talkMaxDuration = var_105_13

					if var_105_13 + var_105_6 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_13 + var_105_6
					end
				end

				arg_102_1.text_.text = var_105_10
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011025", "story_v_side_old_924011.awb") ~= 0 then
					local var_105_14 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011025", "story_v_side_old_924011.awb") / 1000

					if var_105_14 + var_105_6 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_14 + var_105_6
					end

					if var_105_9.prefab_name ~= "" and arg_102_1.actors_[var_105_9.prefab_name] ~= nil then
						local var_105_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_9.prefab_name].transform, "story_v_side_old_924011", "924011025", "story_v_side_old_924011.awb")

						arg_102_1:RecordAudio("924011025", var_105_15)
						arg_102_1:RecordAudio("924011025", var_105_15)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011025", "story_v_side_old_924011.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011025", "story_v_side_old_924011.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_16 = math.max(var_105_7, arg_102_1.talkMaxDuration)

			if var_105_6 <= arg_102_1.time_ and arg_102_1.time_ < var_105_6 + var_105_16 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_6) / var_105_16

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_6 + var_105_16 and arg_102_1.time_ < var_105_6 + var_105_16 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play924011026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 924011026
		arg_106_1.duration_ = 5

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play924011027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = arg_106_1.actors_["1066ui_story"]
			local var_109_1 = 0

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.characterEffect1066ui_story == nil then
				arg_106_1.var_.characterEffect1066ui_story = var_109_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_2 = 0.200000002980232

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_2 and not isNil(var_109_0) then
				local var_109_3 = (arg_106_1.time_ - var_109_1) / var_109_2

				if arg_106_1.var_.characterEffect1066ui_story and not isNil(var_109_0) then
					local var_109_4 = Mathf.Lerp(0, 0.5, var_109_3)

					arg_106_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_106_1.var_.characterEffect1066ui_story.fillRatio = var_109_4
				end
			end

			if arg_106_1.time_ >= var_109_1 + var_109_2 and arg_106_1.time_ < var_109_1 + var_109_2 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.characterEffect1066ui_story then
				local var_109_5 = 0.5

				arg_106_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_106_1.var_.characterEffect1066ui_story.fillRatio = var_109_5
			end

			local var_109_6 = 0
			local var_109_7 = 0.35

			if var_109_6 < arg_106_1.time_ and arg_106_1.time_ <= var_109_6 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_8 = arg_106_1:FormatText(StoryNameCfg[7].name)

				arg_106_1.leftNameTxt_.text = var_109_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, true)
				arg_106_1.iconController_:SetSelectedState("hero")

				arg_106_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_106_1.callingController_:SetSelectedState("normal")

				arg_106_1.keyicon_.color = Color.New(1, 1, 1)
				arg_106_1.icon_.color = Color.New(1, 1, 1)

				local var_109_9 = arg_106_1:GetWordFromCfg(924011026)
				local var_109_10 = arg_106_1:FormatText(var_109_9.content)

				arg_106_1.text_.text = var_109_10

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_11 = 14
				local var_109_12 = utf8.len(var_109_10)
				local var_109_13 = var_109_11 <= 0 and var_109_7 or var_109_7 * (var_109_12 / var_109_11)

				if var_109_13 > 0 and var_109_7 < var_109_13 then
					arg_106_1.talkMaxDuration = var_109_13

					if var_109_13 + var_109_6 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_13 + var_109_6
					end
				end

				arg_106_1.text_.text = var_109_10
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)
				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_14 = math.max(var_109_7, arg_106_1.talkMaxDuration)

			if var_109_6 <= arg_106_1.time_ and arg_106_1.time_ < var_109_6 + var_109_14 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_6) / var_109_14

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_6 + var_109_14 and arg_106_1.time_ < var_109_6 + var_109_14 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play924011027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 924011027
		arg_110_1.duration_ = 5

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play924011028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = 0
			local var_113_1 = 0.9

			if var_113_0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_0 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_2 = arg_110_1:FormatText(StoryNameCfg[7].name)

				arg_110_1.leftNameTxt_.text = var_113_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, true)
				arg_110_1.iconController_:SetSelectedState("hero")

				arg_110_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_110_1.callingController_:SetSelectedState("normal")

				arg_110_1.keyicon_.color = Color.New(1, 1, 1)
				arg_110_1.icon_.color = Color.New(1, 1, 1)

				local var_113_3 = arg_110_1:GetWordFromCfg(924011027)
				local var_113_4 = arg_110_1:FormatText(var_113_3.content)

				arg_110_1.text_.text = var_113_4

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_5 = 34
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
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_8 = math.max(var_113_1, arg_110_1.talkMaxDuration)

			if var_113_0 <= arg_110_1.time_ and arg_110_1.time_ < var_113_0 + var_113_8 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_0) / var_113_8

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_0 + var_113_8 and arg_110_1.time_ < var_113_0 + var_113_8 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play924011028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 924011028
		arg_114_1.duration_ = 5.1

		local var_114_0 = {
			zh = 4.433,
			ja = 5.1
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
				arg_114_0:Play924011029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = arg_114_1.actors_["1066ui_story"]
			local var_117_1 = 0

			if var_117_1 < arg_114_1.time_ and arg_114_1.time_ <= var_117_1 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.characterEffect1066ui_story == nil then
				arg_114_1.var_.characterEffect1066ui_story = var_117_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_2 = 0.200000002980232

			if var_117_1 <= arg_114_1.time_ and arg_114_1.time_ < var_117_1 + var_117_2 and not isNil(var_117_0) then
				local var_117_3 = (arg_114_1.time_ - var_117_1) / var_117_2

				if arg_114_1.var_.characterEffect1066ui_story and not isNil(var_117_0) then
					arg_114_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_114_1.time_ >= var_117_1 + var_117_2 and arg_114_1.time_ < var_117_1 + var_117_2 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.characterEffect1066ui_story then
				arg_114_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_117_4 = 0

			if var_117_4 < arg_114_1.time_ and arg_114_1.time_ <= var_117_4 + arg_117_0 then
				arg_114_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva", "EmotionTimelineAnimator")
			end

			local var_117_5 = 0
			local var_117_6 = 0.5

			if var_117_5 < arg_114_1.time_ and arg_114_1.time_ <= var_117_5 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_7 = arg_114_1:FormatText(StoryNameCfg[32].name)

				arg_114_1.leftNameTxt_.text = var_117_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_8 = arg_114_1:GetWordFromCfg(924011028)
				local var_117_9 = arg_114_1:FormatText(var_117_8.content)

				arg_114_1.text_.text = var_117_9

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_10 = 20
				local var_117_11 = utf8.len(var_117_9)
				local var_117_12 = var_117_10 <= 0 and var_117_6 or var_117_6 * (var_117_11 / var_117_10)

				if var_117_12 > 0 and var_117_6 < var_117_12 then
					arg_114_1.talkMaxDuration = var_117_12

					if var_117_12 + var_117_5 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_12 + var_117_5
					end
				end

				arg_114_1.text_.text = var_117_9
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011028", "story_v_side_old_924011.awb") ~= 0 then
					local var_117_13 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011028", "story_v_side_old_924011.awb") / 1000

					if var_117_13 + var_117_5 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_13 + var_117_5
					end

					if var_117_8.prefab_name ~= "" and arg_114_1.actors_[var_117_8.prefab_name] ~= nil then
						local var_117_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_8.prefab_name].transform, "story_v_side_old_924011", "924011028", "story_v_side_old_924011.awb")

						arg_114_1:RecordAudio("924011028", var_117_14)
						arg_114_1:RecordAudio("924011028", var_117_14)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011028", "story_v_side_old_924011.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011028", "story_v_side_old_924011.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_15 = math.max(var_117_6, arg_114_1.talkMaxDuration)

			if var_117_5 <= arg_114_1.time_ and arg_114_1.time_ < var_117_5 + var_117_15 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_5) / var_117_15

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_5 + var_117_15 and arg_114_1.time_ < var_117_5 + var_117_15 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play924011029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 924011029
		arg_118_1.duration_ = 5

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play924011030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = arg_118_1.actors_["1066ui_story"]
			local var_121_1 = 0

			if var_121_1 < arg_118_1.time_ and arg_118_1.time_ <= var_121_1 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.characterEffect1066ui_story == nil then
				arg_118_1.var_.characterEffect1066ui_story = var_121_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_2 = 0.200000002980232

			if var_121_1 <= arg_118_1.time_ and arg_118_1.time_ < var_121_1 + var_121_2 and not isNil(var_121_0) then
				local var_121_3 = (arg_118_1.time_ - var_121_1) / var_121_2

				if arg_118_1.var_.characterEffect1066ui_story and not isNil(var_121_0) then
					local var_121_4 = Mathf.Lerp(0, 0.5, var_121_3)

					arg_118_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_118_1.var_.characterEffect1066ui_story.fillRatio = var_121_4
				end
			end

			if arg_118_1.time_ >= var_121_1 + var_121_2 and arg_118_1.time_ < var_121_1 + var_121_2 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.characterEffect1066ui_story then
				local var_121_5 = 0.5

				arg_118_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_118_1.var_.characterEffect1066ui_story.fillRatio = var_121_5
			end

			local var_121_6 = 0
			local var_121_7 = 0.725

			if var_121_6 < arg_118_1.time_ and arg_118_1.time_ <= var_121_6 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_8 = arg_118_1:FormatText(StoryNameCfg[7].name)

				arg_118_1.leftNameTxt_.text = var_121_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, true)
				arg_118_1.iconController_:SetSelectedState("hero")

				arg_118_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_118_1.callingController_:SetSelectedState("normal")

				arg_118_1.keyicon_.color = Color.New(1, 1, 1)
				arg_118_1.icon_.color = Color.New(1, 1, 1)

				local var_121_9 = arg_118_1:GetWordFromCfg(924011029)
				local var_121_10 = arg_118_1:FormatText(var_121_9.content)

				arg_118_1.text_.text = var_121_10

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_11 = 29
				local var_121_12 = utf8.len(var_121_10)
				local var_121_13 = var_121_11 <= 0 and var_121_7 or var_121_7 * (var_121_12 / var_121_11)

				if var_121_13 > 0 and var_121_7 < var_121_13 then
					arg_118_1.talkMaxDuration = var_121_13

					if var_121_13 + var_121_6 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_13 + var_121_6
					end
				end

				arg_118_1.text_.text = var_121_10
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)
				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_14 = math.max(var_121_7, arg_118_1.talkMaxDuration)

			if var_121_6 <= arg_118_1.time_ and arg_118_1.time_ < var_121_6 + var_121_14 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_6) / var_121_14

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_6 + var_121_14 and arg_118_1.time_ < var_121_6 + var_121_14 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play924011030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 924011030
		arg_122_1.duration_ = 5

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play924011031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = 0.125
			local var_125_1 = 1

			if var_125_0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_0 + arg_125_0 then
				local var_125_2 = "play"
				local var_125_3 = "effect"

				arg_122_1:AudioAction(var_125_2, var_125_3, "se_story_side_1067", "se_story_1067_ring", "")
			end

			local var_125_4 = 0
			local var_125_5 = 0.7

			if var_125_4 < arg_122_1.time_ and arg_122_1.time_ <= var_125_4 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, false)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_6 = arg_122_1:GetWordFromCfg(924011030)
				local var_125_7 = arg_122_1:FormatText(var_125_6.content)

				arg_122_1.text_.text = var_125_7

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_8 = 28
				local var_125_9 = utf8.len(var_125_7)
				local var_125_10 = var_125_8 <= 0 and var_125_5 or var_125_5 * (var_125_9 / var_125_8)

				if var_125_10 > 0 and var_125_5 < var_125_10 then
					arg_122_1.talkMaxDuration = var_125_10

					if var_125_10 + var_125_4 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_10 + var_125_4
					end
				end

				arg_122_1.text_.text = var_125_7
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_11 = math.max(var_125_5, arg_122_1.talkMaxDuration)

			if var_125_4 <= arg_122_1.time_ and arg_122_1.time_ < var_125_4 + var_125_11 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_4) / var_125_11

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_4 + var_125_11 and arg_122_1.time_ < var_125_4 + var_125_11 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play924011031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 924011031
		arg_126_1.duration_ = 10.4

		local var_126_0 = {
			zh = 7.133,
			ja = 10.4
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
				arg_126_0:Play924011032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = arg_126_1.actors_["1066ui_story"]
			local var_129_1 = 0

			if var_129_1 < arg_126_1.time_ and arg_126_1.time_ <= var_129_1 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.characterEffect1066ui_story == nil then
				arg_126_1.var_.characterEffect1066ui_story = var_129_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_2 = 0.200000002980232

			if var_129_1 <= arg_126_1.time_ and arg_126_1.time_ < var_129_1 + var_129_2 and not isNil(var_129_0) then
				local var_129_3 = (arg_126_1.time_ - var_129_1) / var_129_2

				if arg_126_1.var_.characterEffect1066ui_story and not isNil(var_129_0) then
					arg_126_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_126_1.time_ >= var_129_1 + var_129_2 and arg_126_1.time_ < var_129_1 + var_129_2 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.characterEffect1066ui_story then
				arg_126_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_129_4 = 0

			if var_129_4 < arg_126_1.time_ and arg_126_1.time_ <= var_129_4 + arg_129_0 then
				arg_126_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action3_2")
			end

			local var_129_5 = 0

			if var_129_5 < arg_126_1.time_ and arg_126_1.time_ <= var_129_5 + arg_129_0 then
				arg_126_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_129_6 = 0
			local var_129_7 = 0.75

			if var_129_6 < arg_126_1.time_ and arg_126_1.time_ <= var_129_6 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				local var_129_8 = arg_126_1:FormatText(StoryNameCfg[32].name)

				arg_126_1.leftNameTxt_.text = var_129_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_9 = arg_126_1:GetWordFromCfg(924011031)
				local var_129_10 = arg_126_1:FormatText(var_129_9.content)

				arg_126_1.text_.text = var_129_10

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_11 = 30
				local var_129_12 = utf8.len(var_129_10)
				local var_129_13 = var_129_11 <= 0 and var_129_7 or var_129_7 * (var_129_12 / var_129_11)

				if var_129_13 > 0 and var_129_7 < var_129_13 then
					arg_126_1.talkMaxDuration = var_129_13

					if var_129_13 + var_129_6 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_13 + var_129_6
					end
				end

				arg_126_1.text_.text = var_129_10
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011031", "story_v_side_old_924011.awb") ~= 0 then
					local var_129_14 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011031", "story_v_side_old_924011.awb") / 1000

					if var_129_14 + var_129_6 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_14 + var_129_6
					end

					if var_129_9.prefab_name ~= "" and arg_126_1.actors_[var_129_9.prefab_name] ~= nil then
						local var_129_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_9.prefab_name].transform, "story_v_side_old_924011", "924011031", "story_v_side_old_924011.awb")

						arg_126_1:RecordAudio("924011031", var_129_15)
						arg_126_1:RecordAudio("924011031", var_129_15)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011031", "story_v_side_old_924011.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011031", "story_v_side_old_924011.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_16 = math.max(var_129_7, arg_126_1.talkMaxDuration)

			if var_129_6 <= arg_126_1.time_ and arg_126_1.time_ < var_129_6 + var_129_16 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_6) / var_129_16

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_6 + var_129_16 and arg_126_1.time_ < var_129_6 + var_129_16 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play924011032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 924011032
		arg_130_1.duration_ = 9

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play924011033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = "ST2201"

			if arg_130_1.bgs_[var_133_0] == nil then
				local var_133_1 = Object.Instantiate(arg_130_1.paintGo_)

				var_133_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_133_0)
				var_133_1.name = var_133_0
				var_133_1.transform.parent = arg_130_1.stage_.transform
				var_133_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_130_1.bgs_[var_133_0] = var_133_1
			end

			local var_133_2 = 2

			if var_133_2 < arg_130_1.time_ and arg_130_1.time_ <= var_133_2 + arg_133_0 then
				local var_133_3 = manager.ui.mainCamera.transform.localPosition
				local var_133_4 = Vector3.New(0, 0, 10) + Vector3.New(var_133_3.x, var_133_3.y, 0)
				local var_133_5 = arg_130_1.bgs_.ST2201

				var_133_5.transform.localPosition = var_133_4
				var_133_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_133_6 = var_133_5:GetComponent("SpriteRenderer")

				if var_133_6 and var_133_6.sprite then
					local var_133_7 = (var_133_5.transform.localPosition - var_133_3).z
					local var_133_8 = manager.ui.mainCameraCom_
					local var_133_9 = 2 * var_133_7 * Mathf.Tan(var_133_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_133_10 = var_133_9 * var_133_8.aspect
					local var_133_11 = var_133_6.sprite.bounds.size.x
					local var_133_12 = var_133_6.sprite.bounds.size.y
					local var_133_13 = var_133_10 / var_133_11
					local var_133_14 = var_133_9 / var_133_12
					local var_133_15 = var_133_14 < var_133_13 and var_133_13 or var_133_14

					var_133_5.transform.localScale = Vector3.New(var_133_15, var_133_15, 0)
				end

				for iter_133_0, iter_133_1 in pairs(arg_130_1.bgs_) do
					if iter_133_0 ~= "ST2201" then
						iter_133_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_133_16 = 4

			if var_133_16 < arg_130_1.time_ and arg_130_1.time_ <= var_133_16 + arg_133_0 then
				arg_130_1.allBtn_.enabled = false
			end

			local var_133_17 = 0.3

			if arg_130_1.time_ >= var_133_16 + var_133_17 and arg_130_1.time_ < var_133_16 + var_133_17 + arg_133_0 then
				arg_130_1.allBtn_.enabled = true
			end

			local var_133_18 = 0

			if var_133_18 < arg_130_1.time_ and arg_130_1.time_ <= var_133_18 + arg_133_0 then
				arg_130_1.mask_.enabled = true
				arg_130_1.mask_.raycastTarget = true

				arg_130_1:SetGaussion(false)
			end

			local var_133_19 = 2

			if var_133_18 <= arg_130_1.time_ and arg_130_1.time_ < var_133_18 + var_133_19 then
				local var_133_20 = (arg_130_1.time_ - var_133_18) / var_133_19
				local var_133_21 = Color.New(0, 0, 0)

				var_133_21.a = Mathf.Lerp(0, 1, var_133_20)
				arg_130_1.mask_.color = var_133_21
			end

			if arg_130_1.time_ >= var_133_18 + var_133_19 and arg_130_1.time_ < var_133_18 + var_133_19 + arg_133_0 then
				local var_133_22 = Color.New(0, 0, 0)

				var_133_22.a = 1
				arg_130_1.mask_.color = var_133_22
			end

			local var_133_23 = 2

			if var_133_23 < arg_130_1.time_ and arg_130_1.time_ <= var_133_23 + arg_133_0 then
				arg_130_1.mask_.enabled = true
				arg_130_1.mask_.raycastTarget = true

				arg_130_1:SetGaussion(false)
			end

			local var_133_24 = 2

			if var_133_23 <= arg_130_1.time_ and arg_130_1.time_ < var_133_23 + var_133_24 then
				local var_133_25 = (arg_130_1.time_ - var_133_23) / var_133_24
				local var_133_26 = Color.New(0, 0, 0)

				var_133_26.a = Mathf.Lerp(1, 0, var_133_25)
				arg_130_1.mask_.color = var_133_26
			end

			if arg_130_1.time_ >= var_133_23 + var_133_24 and arg_130_1.time_ < var_133_23 + var_133_24 + arg_133_0 then
				local var_133_27 = Color.New(0, 0, 0)
				local var_133_28 = 0

				arg_130_1.mask_.enabled = false
				var_133_27.a = var_133_28
				arg_130_1.mask_.color = var_133_27
			end

			local var_133_29 = arg_130_1.actors_["1066ui_story"].transform
			local var_133_30 = 1.96599999815226

			if var_133_30 < arg_130_1.time_ and arg_130_1.time_ <= var_133_30 + arg_133_0 then
				arg_130_1.var_.moveOldPos1066ui_story = var_133_29.localPosition
			end

			local var_133_31 = 0.001

			if var_133_30 <= arg_130_1.time_ and arg_130_1.time_ < var_133_30 + var_133_31 then
				local var_133_32 = (arg_130_1.time_ - var_133_30) / var_133_31
				local var_133_33 = Vector3.New(0, 100, 0)

				var_133_29.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos1066ui_story, var_133_33, var_133_32)

				local var_133_34 = manager.ui.mainCamera.transform.position - var_133_29.position

				var_133_29.forward = Vector3.New(var_133_34.x, var_133_34.y, var_133_34.z)

				local var_133_35 = var_133_29.localEulerAngles

				var_133_35.z = 0
				var_133_35.x = 0
				var_133_29.localEulerAngles = var_133_35
			end

			if arg_130_1.time_ >= var_133_30 + var_133_31 and arg_130_1.time_ < var_133_30 + var_133_31 + arg_133_0 then
				var_133_29.localPosition = Vector3.New(0, 100, 0)

				local var_133_36 = manager.ui.mainCamera.transform.position - var_133_29.position

				var_133_29.forward = Vector3.New(var_133_36.x, var_133_36.y, var_133_36.z)

				local var_133_37 = var_133_29.localEulerAngles

				var_133_37.z = 0
				var_133_37.x = 0
				var_133_29.localEulerAngles = var_133_37
			end

			local var_133_38 = arg_130_1.actors_["1066ui_story"]
			local var_133_39 = 1.96599999815226

			if var_133_39 < arg_130_1.time_ and arg_130_1.time_ <= var_133_39 + arg_133_0 and not isNil(var_133_38) and arg_130_1.var_.characterEffect1066ui_story == nil then
				arg_130_1.var_.characterEffect1066ui_story = var_133_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_40 = 0.034000001847744

			if var_133_39 <= arg_130_1.time_ and arg_130_1.time_ < var_133_39 + var_133_40 and not isNil(var_133_38) then
				local var_133_41 = (arg_130_1.time_ - var_133_39) / var_133_40

				if arg_130_1.var_.characterEffect1066ui_story and not isNil(var_133_38) then
					local var_133_42 = Mathf.Lerp(0, 0.5, var_133_41)

					arg_130_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_130_1.var_.characterEffect1066ui_story.fillRatio = var_133_42
				end
			end

			if arg_130_1.time_ >= var_133_39 + var_133_40 and arg_130_1.time_ < var_133_39 + var_133_40 + arg_133_0 and not isNil(var_133_38) and arg_130_1.var_.characterEffect1066ui_story then
				local var_133_43 = 0.5

				arg_130_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_130_1.var_.characterEffect1066ui_story.fillRatio = var_133_43
			end

			local var_133_44 = 0.4
			local var_133_45 = 1

			if var_133_44 < arg_130_1.time_ and arg_130_1.time_ <= var_133_44 + arg_133_0 then
				local var_133_46 = "stop"
				local var_133_47 = "effect"

				arg_130_1:AudioAction(var_133_46, var_133_47, "se_story_141", "se_story_141_amb_rooftop", "")
			end

			local var_133_48 = 1.6
			local var_133_49 = 1

			if var_133_48 < arg_130_1.time_ and arg_130_1.time_ <= var_133_48 + arg_133_0 then
				local var_133_50 = "play"
				local var_133_51 = "effect"

				arg_130_1:AudioAction(var_133_50, var_133_51, "se_story_140", "se_story_140_amb_lab", "")
			end

			local var_133_52 = 0
			local var_133_53 = 0.2

			if var_133_52 < arg_130_1.time_ and arg_130_1.time_ <= var_133_52 + arg_133_0 then
				local var_133_54 = "play"
				local var_133_55 = "music"

				arg_130_1:AudioAction(var_133_54, var_133_55, "ui_battle", "ui_battle_stopbgm", "")

				local var_133_56 = ""
				local var_133_57 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_133_57 ~= "" then
					if arg_130_1.bgmTxt_.text ~= var_133_57 and arg_130_1.bgmTxt_.text ~= "" then
						if arg_130_1.bgmTxt2_.text ~= "" then
							arg_130_1.bgmTxt_.text = arg_130_1.bgmTxt2_.text
						end

						arg_130_1.bgmTxt2_.text = var_133_57

						arg_130_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_130_1.bgmTxt_.text = var_133_57
						arg_130_1.bgmTxt2_.text = var_133_57
					end

					if arg_130_1.bgmTimer then
						arg_130_1.bgmTimer:Stop()

						arg_130_1.bgmTimer = nil
					end

					if arg_130_1.settingData.show_music_name == 1 then
						arg_130_1.musicController:SetSelectedState("show")
						arg_130_1.musicAnimator_:Play("open", 0, 0)

						if arg_130_1.settingData.music_time ~= 0 then
							arg_130_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_130_1.settingData.music_time), function()
								if arg_130_1 == nil or isNil(arg_130_1.bgmTxt_) then
									return
								end

								arg_130_1.musicController:SetSelectedState("hide")
								arg_130_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_133_58 = 0.4
			local var_133_59 = 1

			if var_133_58 < arg_130_1.time_ and arg_130_1.time_ <= var_133_58 + arg_133_0 then
				local var_133_60 = "play"
				local var_133_61 = "music"

				arg_130_1:AudioAction(var_133_60, var_133_61, "bgm_side_daily02", "bgm_side_daily02", "bgm_side_daily02.awb")

				local var_133_62 = ""
				local var_133_63 = manager.audio:GetAudioName("bgm_side_daily02", "bgm_side_daily02")

				if var_133_63 ~= "" then
					if arg_130_1.bgmTxt_.text ~= var_133_63 and arg_130_1.bgmTxt_.text ~= "" then
						if arg_130_1.bgmTxt2_.text ~= "" then
							arg_130_1.bgmTxt_.text = arg_130_1.bgmTxt2_.text
						end

						arg_130_1.bgmTxt2_.text = var_133_63

						arg_130_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_130_1.bgmTxt_.text = var_133_63
						arg_130_1.bgmTxt2_.text = var_133_63
					end

					if arg_130_1.bgmTimer then
						arg_130_1.bgmTimer:Stop()

						arg_130_1.bgmTimer = nil
					end

					if arg_130_1.settingData.show_music_name == 1 then
						arg_130_1.musicController:SetSelectedState("show")
						arg_130_1.musicAnimator_:Play("open", 0, 0)

						if arg_130_1.settingData.music_time ~= 0 then
							arg_130_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_130_1.settingData.music_time), function()
								if arg_130_1 == nil or isNil(arg_130_1.bgmTxt_) then
									return
								end

								arg_130_1.musicController:SetSelectedState("hide")
								arg_130_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_133_64 = 0.833333333333333
			local var_133_65 = 1

			if var_133_64 < arg_130_1.time_ and arg_130_1.time_ <= var_133_64 + arg_133_0 then
				local var_133_66 = "stop"
				local var_133_67 = "effect"

				arg_130_1:AudioAction(var_133_66, var_133_67, "se_story_141", "se_story_141_amb_rooftop", "")
			end

			if arg_130_1.frameCnt_ <= 1 then
				arg_130_1.dialog_:SetActive(false)
			end

			local var_133_68 = 4
			local var_133_69 = 0.2

			if var_133_68 < arg_130_1.time_ and arg_130_1.time_ <= var_133_68 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0

				arg_130_1.dialog_:SetActive(true)

				arg_130_1.dialogCg_.alpha = 0

				local var_133_70 = LeanTween.value(arg_130_1.dialog_, 0, 1, 0.3)

				var_133_70:setOnUpdate(LuaHelper.FloatAction(function(arg_136_0)
					arg_130_1.dialogCg_.alpha = arg_136_0
				end))
				var_133_70:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_130_1.dialog_)
					var_133_70:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_130_1.duration_ = arg_130_1.duration_ + 0.3

				SetActive(arg_130_1.leftNameGo_, true)

				local var_133_71 = arg_130_1:FormatText(StoryNameCfg[7].name)

				arg_130_1.leftNameTxt_.text = var_133_71

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, true)
				arg_130_1.iconController_:SetSelectedState("hero")

				arg_130_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_130_1.callingController_:SetSelectedState("normal")

				arg_130_1.keyicon_.color = Color.New(1, 1, 1)
				arg_130_1.icon_.color = Color.New(1, 1, 1)

				local var_133_72 = arg_130_1:GetWordFromCfg(924011032)
				local var_133_73 = arg_130_1:FormatText(var_133_72.content)

				arg_130_1.text_.text = var_133_73

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_74 = 8
				local var_133_75 = utf8.len(var_133_73)
				local var_133_76 = var_133_74 <= 0 and var_133_69 or var_133_69 * (var_133_75 / var_133_74)

				if var_133_76 > 0 and var_133_69 < var_133_76 then
					arg_130_1.talkMaxDuration = var_133_76
					var_133_68 = var_133_68 + 0.3

					if var_133_76 + var_133_68 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_76 + var_133_68
					end
				end

				arg_130_1.text_.text = var_133_73
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_77 = var_133_68 + 0.3
			local var_133_78 = math.max(var_133_69, arg_130_1.talkMaxDuration)

			if var_133_77 <= arg_130_1.time_ and arg_130_1.time_ < var_133_77 + var_133_78 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_77) / var_133_78

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_77 + var_133_78 and arg_130_1.time_ < var_133_77 + var_133_78 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_130_1:InitPlayNodeList()
	end,
	Play924011033 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 924011033
		arg_138_1.duration_ = 12.27

		local var_138_0 = {
			zh = 7.2,
			ja = 12.266
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
				arg_138_0:Play924011034(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = "1033ui_story"

			if arg_138_1.actors_[var_141_0] == nil then
				local var_141_1 = Asset.Load("Char/" .. "1033ui_story")

				if not isNil(var_141_1) then
					local var_141_2 = Object.Instantiate(Asset.Load("Char/" .. "1033ui_story"), arg_138_1.stage_.transform)

					var_141_2.name = var_141_0
					var_141_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_138_1.actors_[var_141_0] = var_141_2

					local var_141_3 = var_141_2:GetComponentInChildren(typeof(CharacterEffect))

					var_141_3.enabled = true

					local var_141_4 = GameObjectTools.GetOrAddComponent(var_141_2, typeof(DynamicBoneHelper))

					if var_141_4 then
						var_141_4:EnableDynamicBone(false)
					end

					arg_138_1:ShowWeapon(var_141_3.transform, false)

					arg_138_1.var_[var_141_0 .. "Animator"] = var_141_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_138_1.var_[var_141_0 .. "Animator"].applyRootMotion = true
					arg_138_1.var_[var_141_0 .. "LipSync"] = var_141_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_141_5 = arg_138_1.actors_["1033ui_story"].transform
			local var_141_6 = 0

			if var_141_6 < arg_138_1.time_ and arg_138_1.time_ <= var_141_6 + arg_141_0 then
				arg_138_1.var_.moveOldPos1033ui_story = var_141_5.localPosition
			end

			local var_141_7 = 0.001

			if var_141_6 <= arg_138_1.time_ and arg_138_1.time_ < var_141_6 + var_141_7 then
				local var_141_8 = (arg_138_1.time_ - var_141_6) / var_141_7
				local var_141_9 = Vector3.New(0, -1.01, -6.13)

				var_141_5.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos1033ui_story, var_141_9, var_141_8)

				local var_141_10 = manager.ui.mainCamera.transform.position - var_141_5.position

				var_141_5.forward = Vector3.New(var_141_10.x, var_141_10.y, var_141_10.z)

				local var_141_11 = var_141_5.localEulerAngles

				var_141_11.z = 0
				var_141_11.x = 0
				var_141_5.localEulerAngles = var_141_11
			end

			if arg_138_1.time_ >= var_141_6 + var_141_7 and arg_138_1.time_ < var_141_6 + var_141_7 + arg_141_0 then
				var_141_5.localPosition = Vector3.New(0, -1.01, -6.13)

				local var_141_12 = manager.ui.mainCamera.transform.position - var_141_5.position

				var_141_5.forward = Vector3.New(var_141_12.x, var_141_12.y, var_141_12.z)

				local var_141_13 = var_141_5.localEulerAngles

				var_141_13.z = 0
				var_141_13.x = 0
				var_141_5.localEulerAngles = var_141_13
			end

			local var_141_14 = arg_138_1.actors_["1033ui_story"]
			local var_141_15 = 0

			if var_141_15 < arg_138_1.time_ and arg_138_1.time_ <= var_141_15 + arg_141_0 and not isNil(var_141_14) and arg_138_1.var_.characterEffect1033ui_story == nil then
				arg_138_1.var_.characterEffect1033ui_story = var_141_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_16 = 0.200000002980232

			if var_141_15 <= arg_138_1.time_ and arg_138_1.time_ < var_141_15 + var_141_16 and not isNil(var_141_14) then
				local var_141_17 = (arg_138_1.time_ - var_141_15) / var_141_16

				if arg_138_1.var_.characterEffect1033ui_story and not isNil(var_141_14) then
					arg_138_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_138_1.time_ >= var_141_15 + var_141_16 and arg_138_1.time_ < var_141_15 + var_141_16 + arg_141_0 and not isNil(var_141_14) and arg_138_1.var_.characterEffect1033ui_story then
				arg_138_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_141_18 = 0

			if var_141_18 < arg_138_1.time_ and arg_138_1.time_ <= var_141_18 + arg_141_0 then
				arg_138_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action1_1")
			end

			local var_141_19 = 0

			if var_141_19 < arg_138_1.time_ and arg_138_1.time_ <= var_141_19 + arg_141_0 then
				arg_138_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_141_20 = 0
			local var_141_21 = 0.925

			if var_141_20 < arg_138_1.time_ and arg_138_1.time_ <= var_141_20 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				local var_141_22 = arg_138_1:FormatText(StoryNameCfg[236].name)

				arg_138_1.leftNameTxt_.text = var_141_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_23 = arg_138_1:GetWordFromCfg(924011033)
				local var_141_24 = arg_138_1:FormatText(var_141_23.content)

				arg_138_1.text_.text = var_141_24

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_25 = 37
				local var_141_26 = utf8.len(var_141_24)
				local var_141_27 = var_141_25 <= 0 and var_141_21 or var_141_21 * (var_141_26 / var_141_25)

				if var_141_27 > 0 and var_141_21 < var_141_27 then
					arg_138_1.talkMaxDuration = var_141_27

					if var_141_27 + var_141_20 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_27 + var_141_20
					end
				end

				arg_138_1.text_.text = var_141_24
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011033", "story_v_side_old_924011.awb") ~= 0 then
					local var_141_28 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011033", "story_v_side_old_924011.awb") / 1000

					if var_141_28 + var_141_20 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_28 + var_141_20
					end

					if var_141_23.prefab_name ~= "" and arg_138_1.actors_[var_141_23.prefab_name] ~= nil then
						local var_141_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_23.prefab_name].transform, "story_v_side_old_924011", "924011033", "story_v_side_old_924011.awb")

						arg_138_1:RecordAudio("924011033", var_141_29)
						arg_138_1:RecordAudio("924011033", var_141_29)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011033", "story_v_side_old_924011.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011033", "story_v_side_old_924011.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_30 = math.max(var_141_21, arg_138_1.talkMaxDuration)

			if var_141_20 <= arg_138_1.time_ and arg_138_1.time_ < var_141_20 + var_141_30 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_20) / var_141_30

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_20 + var_141_30 and arg_138_1.time_ < var_141_20 + var_141_30 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_138_1:InitPlayNodeList()
	end,
	Play924011034 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 924011034
		arg_142_1.duration_ = 5

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play924011035(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = arg_142_1.actors_["1033ui_story"]
			local var_145_1 = 0

			if var_145_1 < arg_142_1.time_ and arg_142_1.time_ <= var_145_1 + arg_145_0 and not isNil(var_145_0) and arg_142_1.var_.characterEffect1033ui_story == nil then
				arg_142_1.var_.characterEffect1033ui_story = var_145_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_2 = 0.200000002980232

			if var_145_1 <= arg_142_1.time_ and arg_142_1.time_ < var_145_1 + var_145_2 and not isNil(var_145_0) then
				local var_145_3 = (arg_142_1.time_ - var_145_1) / var_145_2

				if arg_142_1.var_.characterEffect1033ui_story and not isNil(var_145_0) then
					local var_145_4 = Mathf.Lerp(0, 0.5, var_145_3)

					arg_142_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_142_1.var_.characterEffect1033ui_story.fillRatio = var_145_4
				end
			end

			if arg_142_1.time_ >= var_145_1 + var_145_2 and arg_142_1.time_ < var_145_1 + var_145_2 + arg_145_0 and not isNil(var_145_0) and arg_142_1.var_.characterEffect1033ui_story then
				local var_145_5 = 0.5

				arg_142_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_142_1.var_.characterEffect1033ui_story.fillRatio = var_145_5
			end

			local var_145_6 = 0
			local var_145_7 = 1.1

			if var_145_6 < arg_142_1.time_ and arg_142_1.time_ <= var_145_6 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, false)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_8 = arg_142_1:GetWordFromCfg(924011034)
				local var_145_9 = arg_142_1:FormatText(var_145_8.content)

				arg_142_1.text_.text = var_145_9

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_10 = 44
				local var_145_11 = utf8.len(var_145_9)
				local var_145_12 = var_145_10 <= 0 and var_145_7 or var_145_7 * (var_145_11 / var_145_10)

				if var_145_12 > 0 and var_145_7 < var_145_12 then
					arg_142_1.talkMaxDuration = var_145_12

					if var_145_12 + var_145_6 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_12 + var_145_6
					end
				end

				arg_142_1.text_.text = var_145_9
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)
				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_13 = math.max(var_145_7, arg_142_1.talkMaxDuration)

			if var_145_6 <= arg_142_1.time_ and arg_142_1.time_ < var_145_6 + var_145_13 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_6) / var_145_13

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_6 + var_145_13 and arg_142_1.time_ < var_145_6 + var_145_13 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play924011035 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 924011035
		arg_146_1.duration_ = 5

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play924011036(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = 0
			local var_149_1 = 0.2

			if var_149_0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_0 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				local var_149_2 = arg_146_1:FormatText(StoryNameCfg[7].name)

				arg_146_1.leftNameTxt_.text = var_149_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, true)
				arg_146_1.iconController_:SetSelectedState("hero")

				arg_146_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_146_1.callingController_:SetSelectedState("normal")

				arg_146_1.keyicon_.color = Color.New(1, 1, 1)
				arg_146_1.icon_.color = Color.New(1, 1, 1)

				local var_149_3 = arg_146_1:GetWordFromCfg(924011035)
				local var_149_4 = arg_146_1:FormatText(var_149_3.content)

				arg_146_1.text_.text = var_149_4

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_5 = 8
				local var_149_6 = utf8.len(var_149_4)
				local var_149_7 = var_149_5 <= 0 and var_149_1 or var_149_1 * (var_149_6 / var_149_5)

				if var_149_7 > 0 and var_149_1 < var_149_7 then
					arg_146_1.talkMaxDuration = var_149_7

					if var_149_7 + var_149_0 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_7 + var_149_0
					end
				end

				arg_146_1.text_.text = var_149_4
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)
				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_8 = math.max(var_149_1, arg_146_1.talkMaxDuration)

			if var_149_0 <= arg_146_1.time_ and arg_146_1.time_ < var_149_0 + var_149_8 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_0) / var_149_8

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_0 + var_149_8 and arg_146_1.time_ < var_149_0 + var_149_8 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play924011036 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 924011036
		arg_150_1.duration_ = 4.1

		local var_150_0 = {
			zh = 3.6,
			ja = 4.1
		}
		local var_150_1 = manager.audio:GetLocalizationFlag()

		if var_150_0[var_150_1] ~= nil then
			arg_150_1.duration_ = var_150_0[var_150_1]
		end

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play924011037(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = arg_150_1.actors_["1066ui_story"].transform
			local var_153_1 = 0

			if var_153_1 < arg_150_1.time_ and arg_150_1.time_ <= var_153_1 + arg_153_0 then
				arg_150_1.var_.moveOldPos1066ui_story = var_153_0.localPosition
			end

			local var_153_2 = 0.001

			if var_153_1 <= arg_150_1.time_ and arg_150_1.time_ < var_153_1 + var_153_2 then
				local var_153_3 = (arg_150_1.time_ - var_153_1) / var_153_2
				local var_153_4 = Vector3.New(0, -0.77, -6.1)

				var_153_0.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos1066ui_story, var_153_4, var_153_3)

				local var_153_5 = manager.ui.mainCamera.transform.position - var_153_0.position

				var_153_0.forward = Vector3.New(var_153_5.x, var_153_5.y, var_153_5.z)

				local var_153_6 = var_153_0.localEulerAngles

				var_153_6.z = 0
				var_153_6.x = 0
				var_153_0.localEulerAngles = var_153_6
			end

			if arg_150_1.time_ >= var_153_1 + var_153_2 and arg_150_1.time_ < var_153_1 + var_153_2 + arg_153_0 then
				var_153_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_153_7 = manager.ui.mainCamera.transform.position - var_153_0.position

				var_153_0.forward = Vector3.New(var_153_7.x, var_153_7.y, var_153_7.z)

				local var_153_8 = var_153_0.localEulerAngles

				var_153_8.z = 0
				var_153_8.x = 0
				var_153_0.localEulerAngles = var_153_8
			end

			local var_153_9 = arg_150_1.actors_["1033ui_story"].transform
			local var_153_10 = 0

			if var_153_10 < arg_150_1.time_ and arg_150_1.time_ <= var_153_10 + arg_153_0 then
				arg_150_1.var_.moveOldPos1033ui_story = var_153_9.localPosition
			end

			local var_153_11 = 0.001

			if var_153_10 <= arg_150_1.time_ and arg_150_1.time_ < var_153_10 + var_153_11 then
				local var_153_12 = (arg_150_1.time_ - var_153_10) / var_153_11
				local var_153_13 = Vector3.New(0, 100, 0)

				var_153_9.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos1033ui_story, var_153_13, var_153_12)

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

			local var_153_18 = arg_150_1.actors_["1066ui_story"]
			local var_153_19 = 0

			if var_153_19 < arg_150_1.time_ and arg_150_1.time_ <= var_153_19 + arg_153_0 and not isNil(var_153_18) and arg_150_1.var_.characterEffect1066ui_story == nil then
				arg_150_1.var_.characterEffect1066ui_story = var_153_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_20 = 0.200000002980232

			if var_153_19 <= arg_150_1.time_ and arg_150_1.time_ < var_153_19 + var_153_20 and not isNil(var_153_18) then
				local var_153_21 = (arg_150_1.time_ - var_153_19) / var_153_20

				if arg_150_1.var_.characterEffect1066ui_story and not isNil(var_153_18) then
					arg_150_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_150_1.time_ >= var_153_19 + var_153_20 and arg_150_1.time_ < var_153_19 + var_153_20 + arg_153_0 and not isNil(var_153_18) and arg_150_1.var_.characterEffect1066ui_story then
				arg_150_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_153_22 = 0

			if var_153_22 < arg_150_1.time_ and arg_150_1.time_ <= var_153_22 + arg_153_0 then
				arg_150_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action1_1")
			end

			local var_153_23 = 0

			if var_153_23 < arg_150_1.time_ and arg_150_1.time_ <= var_153_23 + arg_153_0 then
				arg_150_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_153_24 = 0
			local var_153_25 = 0.4

			if var_153_24 < arg_150_1.time_ and arg_150_1.time_ <= var_153_24 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				local var_153_26 = arg_150_1:FormatText(StoryNameCfg[32].name)

				arg_150_1.leftNameTxt_.text = var_153_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_27 = arg_150_1:GetWordFromCfg(924011036)
				local var_153_28 = arg_150_1:FormatText(var_153_27.content)

				arg_150_1.text_.text = var_153_28

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_29 = 16
				local var_153_30 = utf8.len(var_153_28)
				local var_153_31 = var_153_29 <= 0 and var_153_25 or var_153_25 * (var_153_30 / var_153_29)

				if var_153_31 > 0 and var_153_25 < var_153_31 then
					arg_150_1.talkMaxDuration = var_153_31

					if var_153_31 + var_153_24 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_31 + var_153_24
					end
				end

				arg_150_1.text_.text = var_153_28
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011036", "story_v_side_old_924011.awb") ~= 0 then
					local var_153_32 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011036", "story_v_side_old_924011.awb") / 1000

					if var_153_32 + var_153_24 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_32 + var_153_24
					end

					if var_153_27.prefab_name ~= "" and arg_150_1.actors_[var_153_27.prefab_name] ~= nil then
						local var_153_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_27.prefab_name].transform, "story_v_side_old_924011", "924011036", "story_v_side_old_924011.awb")

						arg_150_1:RecordAudio("924011036", var_153_33)
						arg_150_1:RecordAudio("924011036", var_153_33)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011036", "story_v_side_old_924011.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011036", "story_v_side_old_924011.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_34 = math.max(var_153_25, arg_150_1.talkMaxDuration)

			if var_153_24 <= arg_150_1.time_ and arg_150_1.time_ < var_153_24 + var_153_34 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_24) / var_153_34

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_24 + var_153_34 and arg_150_1.time_ < var_153_24 + var_153_34 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_150_1:InitPlayNodeList()
	end,
	Play924011037 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 924011037
		arg_154_1.duration_ = 5

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play924011038(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = arg_154_1.actors_["1066ui_story"]
			local var_157_1 = 0

			if var_157_1 < arg_154_1.time_ and arg_154_1.time_ <= var_157_1 + arg_157_0 and not isNil(var_157_0) and arg_154_1.var_.characterEffect1066ui_story == nil then
				arg_154_1.var_.characterEffect1066ui_story = var_157_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_2 = 0.200000002980232

			if var_157_1 <= arg_154_1.time_ and arg_154_1.time_ < var_157_1 + var_157_2 and not isNil(var_157_0) then
				local var_157_3 = (arg_154_1.time_ - var_157_1) / var_157_2

				if arg_154_1.var_.characterEffect1066ui_story and not isNil(var_157_0) then
					local var_157_4 = Mathf.Lerp(0, 0.5, var_157_3)

					arg_154_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_154_1.var_.characterEffect1066ui_story.fillRatio = var_157_4
				end
			end

			if arg_154_1.time_ >= var_157_1 + var_157_2 and arg_154_1.time_ < var_157_1 + var_157_2 + arg_157_0 and not isNil(var_157_0) and arg_154_1.var_.characterEffect1066ui_story then
				local var_157_5 = 0.5

				arg_154_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_154_1.var_.characterEffect1066ui_story.fillRatio = var_157_5
			end

			local var_157_6 = 0
			local var_157_7 = 0.65

			if var_157_6 < arg_154_1.time_ and arg_154_1.time_ <= var_157_6 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				local var_157_8 = arg_154_1:FormatText(StoryNameCfg[7].name)

				arg_154_1.leftNameTxt_.text = var_157_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, true)
				arg_154_1.iconController_:SetSelectedState("hero")

				arg_154_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_154_1.callingController_:SetSelectedState("normal")

				arg_154_1.keyicon_.color = Color.New(1, 1, 1)
				arg_154_1.icon_.color = Color.New(1, 1, 1)

				local var_157_9 = arg_154_1:GetWordFromCfg(924011037)
				local var_157_10 = arg_154_1:FormatText(var_157_9.content)

				arg_154_1.text_.text = var_157_10

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_11 = 26
				local var_157_12 = utf8.len(var_157_10)
				local var_157_13 = var_157_11 <= 0 and var_157_7 or var_157_7 * (var_157_12 / var_157_11)

				if var_157_13 > 0 and var_157_7 < var_157_13 then
					arg_154_1.talkMaxDuration = var_157_13

					if var_157_13 + var_157_6 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_13 + var_157_6
					end
				end

				arg_154_1.text_.text = var_157_10
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)
				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_14 = math.max(var_157_7, arg_154_1.talkMaxDuration)

			if var_157_6 <= arg_154_1.time_ and arg_154_1.time_ < var_157_6 + var_157_14 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_6) / var_157_14

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_6 + var_157_14 and arg_154_1.time_ < var_157_6 + var_157_14 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play924011038 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 924011038
		arg_158_1.duration_ = 9.17

		local var_158_0 = {
			zh = 7.5,
			ja = 9.166
		}
		local var_158_1 = manager.audio:GetLocalizationFlag()

		if var_158_0[var_158_1] ~= nil then
			arg_158_1.duration_ = var_158_0[var_158_1]
		end

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play924011039(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = arg_158_1.actors_["1066ui_story"]
			local var_161_1 = 0

			if var_161_1 < arg_158_1.time_ and arg_158_1.time_ <= var_161_1 + arg_161_0 and not isNil(var_161_0) and arg_158_1.var_.characterEffect1066ui_story == nil then
				arg_158_1.var_.characterEffect1066ui_story = var_161_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_2 = 0.200000002980232

			if var_161_1 <= arg_158_1.time_ and arg_158_1.time_ < var_161_1 + var_161_2 and not isNil(var_161_0) then
				local var_161_3 = (arg_158_1.time_ - var_161_1) / var_161_2

				if arg_158_1.var_.characterEffect1066ui_story and not isNil(var_161_0) then
					arg_158_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_158_1.time_ >= var_161_1 + var_161_2 and arg_158_1.time_ < var_161_1 + var_161_2 + arg_161_0 and not isNil(var_161_0) and arg_158_1.var_.characterEffect1066ui_story then
				arg_158_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_161_4 = 0

			if var_161_4 < arg_158_1.time_ and arg_158_1.time_ <= var_161_4 + arg_161_0 then
				arg_158_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action1_1")
			end

			local var_161_5 = 0

			if var_161_5 < arg_158_1.time_ and arg_158_1.time_ <= var_161_5 + arg_161_0 then
				arg_158_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_161_6 = 0
			local var_161_7 = 0.875

			if var_161_6 < arg_158_1.time_ and arg_158_1.time_ <= var_161_6 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				local var_161_8 = arg_158_1:FormatText(StoryNameCfg[32].name)

				arg_158_1.leftNameTxt_.text = var_161_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_9 = arg_158_1:GetWordFromCfg(924011038)
				local var_161_10 = arg_158_1:FormatText(var_161_9.content)

				arg_158_1.text_.text = var_161_10

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_11 = 35
				local var_161_12 = utf8.len(var_161_10)
				local var_161_13 = var_161_11 <= 0 and var_161_7 or var_161_7 * (var_161_12 / var_161_11)

				if var_161_13 > 0 and var_161_7 < var_161_13 then
					arg_158_1.talkMaxDuration = var_161_13

					if var_161_13 + var_161_6 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_13 + var_161_6
					end
				end

				arg_158_1.text_.text = var_161_10
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011038", "story_v_side_old_924011.awb") ~= 0 then
					local var_161_14 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011038", "story_v_side_old_924011.awb") / 1000

					if var_161_14 + var_161_6 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_14 + var_161_6
					end

					if var_161_9.prefab_name ~= "" and arg_158_1.actors_[var_161_9.prefab_name] ~= nil then
						local var_161_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_9.prefab_name].transform, "story_v_side_old_924011", "924011038", "story_v_side_old_924011.awb")

						arg_158_1:RecordAudio("924011038", var_161_15)
						arg_158_1:RecordAudio("924011038", var_161_15)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011038", "story_v_side_old_924011.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011038", "story_v_side_old_924011.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_16 = math.max(var_161_7, arg_158_1.talkMaxDuration)

			if var_161_6 <= arg_158_1.time_ and arg_158_1.time_ < var_161_6 + var_161_16 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_6) / var_161_16

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_6 + var_161_16 and arg_158_1.time_ < var_161_6 + var_161_16 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play924011039 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 924011039
		arg_162_1.duration_ = 5

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play924011040(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = arg_162_1.actors_["1066ui_story"]
			local var_165_1 = 0

			if var_165_1 < arg_162_1.time_ and arg_162_1.time_ <= var_165_1 + arg_165_0 and not isNil(var_165_0) and arg_162_1.var_.characterEffect1066ui_story == nil then
				arg_162_1.var_.characterEffect1066ui_story = var_165_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_2 = 0.200000002980232

			if var_165_1 <= arg_162_1.time_ and arg_162_1.time_ < var_165_1 + var_165_2 and not isNil(var_165_0) then
				local var_165_3 = (arg_162_1.time_ - var_165_1) / var_165_2

				if arg_162_1.var_.characterEffect1066ui_story and not isNil(var_165_0) then
					local var_165_4 = Mathf.Lerp(0, 0.5, var_165_3)

					arg_162_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_162_1.var_.characterEffect1066ui_story.fillRatio = var_165_4
				end
			end

			if arg_162_1.time_ >= var_165_1 + var_165_2 and arg_162_1.time_ < var_165_1 + var_165_2 + arg_165_0 and not isNil(var_165_0) and arg_162_1.var_.characterEffect1066ui_story then
				local var_165_5 = 0.5

				arg_162_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_162_1.var_.characterEffect1066ui_story.fillRatio = var_165_5
			end

			local var_165_6 = 0
			local var_165_7 = 0.15

			if var_165_6 < arg_162_1.time_ and arg_162_1.time_ <= var_165_6 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				local var_165_8 = arg_162_1:FormatText(StoryNameCfg[7].name)

				arg_162_1.leftNameTxt_.text = var_165_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, true)
				arg_162_1.iconController_:SetSelectedState("hero")

				arg_162_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_162_1.callingController_:SetSelectedState("normal")

				arg_162_1.keyicon_.color = Color.New(1, 1, 1)
				arg_162_1.icon_.color = Color.New(1, 1, 1)

				local var_165_9 = arg_162_1:GetWordFromCfg(924011039)
				local var_165_10 = arg_162_1:FormatText(var_165_9.content)

				arg_162_1.text_.text = var_165_10

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_11 = 6
				local var_165_12 = utf8.len(var_165_10)
				local var_165_13 = var_165_11 <= 0 and var_165_7 or var_165_7 * (var_165_12 / var_165_11)

				if var_165_13 > 0 and var_165_7 < var_165_13 then
					arg_162_1.talkMaxDuration = var_165_13

					if var_165_13 + var_165_6 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_13 + var_165_6
					end
				end

				arg_162_1.text_.text = var_165_10
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)
				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_14 = math.max(var_165_7, arg_162_1.talkMaxDuration)

			if var_165_6 <= arg_162_1.time_ and arg_162_1.time_ < var_165_6 + var_165_14 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_6) / var_165_14

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_6 + var_165_14 and arg_162_1.time_ < var_165_6 + var_165_14 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play924011040 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 924011040
		arg_166_1.duration_ = 9.9

		local var_166_0 = {
			zh = 7.3,
			ja = 9.9
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
				arg_166_0:Play924011041(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = arg_166_1.actors_["1066ui_story"]
			local var_169_1 = 0

			if var_169_1 < arg_166_1.time_ and arg_166_1.time_ <= var_169_1 + arg_169_0 and not isNil(var_169_0) and arg_166_1.var_.characterEffect1066ui_story == nil then
				arg_166_1.var_.characterEffect1066ui_story = var_169_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_2 = 0.200000002980232

			if var_169_1 <= arg_166_1.time_ and arg_166_1.time_ < var_169_1 + var_169_2 and not isNil(var_169_0) then
				local var_169_3 = (arg_166_1.time_ - var_169_1) / var_169_2

				if arg_166_1.var_.characterEffect1066ui_story and not isNil(var_169_0) then
					arg_166_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_166_1.time_ >= var_169_1 + var_169_2 and arg_166_1.time_ < var_169_1 + var_169_2 + arg_169_0 and not isNil(var_169_0) and arg_166_1.var_.characterEffect1066ui_story then
				arg_166_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_169_4 = 0

			if var_169_4 < arg_166_1.time_ and arg_166_1.time_ <= var_169_4 + arg_169_0 then
				arg_166_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action3_1")
			end

			local var_169_5 = 0

			if var_169_5 < arg_166_1.time_ and arg_166_1.time_ <= var_169_5 + arg_169_0 then
				arg_166_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_169_6 = 0
			local var_169_7 = 0.925

			if var_169_6 < arg_166_1.time_ and arg_166_1.time_ <= var_169_6 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				local var_169_8 = arg_166_1:FormatText(StoryNameCfg[32].name)

				arg_166_1.leftNameTxt_.text = var_169_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_9 = arg_166_1:GetWordFromCfg(924011040)
				local var_169_10 = arg_166_1:FormatText(var_169_9.content)

				arg_166_1.text_.text = var_169_10

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_11 = 37
				local var_169_12 = utf8.len(var_169_10)
				local var_169_13 = var_169_11 <= 0 and var_169_7 or var_169_7 * (var_169_12 / var_169_11)

				if var_169_13 > 0 and var_169_7 < var_169_13 then
					arg_166_1.talkMaxDuration = var_169_13

					if var_169_13 + var_169_6 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_13 + var_169_6
					end
				end

				arg_166_1.text_.text = var_169_10
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011040", "story_v_side_old_924011.awb") ~= 0 then
					local var_169_14 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011040", "story_v_side_old_924011.awb") / 1000

					if var_169_14 + var_169_6 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_14 + var_169_6
					end

					if var_169_9.prefab_name ~= "" and arg_166_1.actors_[var_169_9.prefab_name] ~= nil then
						local var_169_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_9.prefab_name].transform, "story_v_side_old_924011", "924011040", "story_v_side_old_924011.awb")

						arg_166_1:RecordAudio("924011040", var_169_15)
						arg_166_1:RecordAudio("924011040", var_169_15)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011040", "story_v_side_old_924011.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011040", "story_v_side_old_924011.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_16 = math.max(var_169_7, arg_166_1.talkMaxDuration)

			if var_169_6 <= arg_166_1.time_ and arg_166_1.time_ < var_169_6 + var_169_16 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_6) / var_169_16

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_6 + var_169_16 and arg_166_1.time_ < var_169_6 + var_169_16 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play924011041 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 924011041
		arg_170_1.duration_ = 11

		local var_170_0 = {
			zh = 8.1,
			ja = 11
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
				arg_170_0:Play924011042(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = 0
			local var_173_1 = 1.075

			if var_173_0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_0 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				local var_173_2 = arg_170_1:FormatText(StoryNameCfg[32].name)

				arg_170_1.leftNameTxt_.text = var_173_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_3 = arg_170_1:GetWordFromCfg(924011041)
				local var_173_4 = arg_170_1:FormatText(var_173_3.content)

				arg_170_1.text_.text = var_173_4

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_5 = 43
				local var_173_6 = utf8.len(var_173_4)
				local var_173_7 = var_173_5 <= 0 and var_173_1 or var_173_1 * (var_173_6 / var_173_5)

				if var_173_7 > 0 and var_173_1 < var_173_7 then
					arg_170_1.talkMaxDuration = var_173_7

					if var_173_7 + var_173_0 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_7 + var_173_0
					end
				end

				arg_170_1.text_.text = var_173_4
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011041", "story_v_side_old_924011.awb") ~= 0 then
					local var_173_8 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011041", "story_v_side_old_924011.awb") / 1000

					if var_173_8 + var_173_0 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_8 + var_173_0
					end

					if var_173_3.prefab_name ~= "" and arg_170_1.actors_[var_173_3.prefab_name] ~= nil then
						local var_173_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_3.prefab_name].transform, "story_v_side_old_924011", "924011041", "story_v_side_old_924011.awb")

						arg_170_1:RecordAudio("924011041", var_173_9)
						arg_170_1:RecordAudio("924011041", var_173_9)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011041", "story_v_side_old_924011.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011041", "story_v_side_old_924011.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_10 = math.max(var_173_1, arg_170_1.talkMaxDuration)

			if var_173_0 <= arg_170_1.time_ and arg_170_1.time_ < var_173_0 + var_173_10 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_0) / var_173_10

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_0 + var_173_10 and arg_170_1.time_ < var_173_0 + var_173_10 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play924011042 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 924011042
		arg_174_1.duration_ = 5

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play924011043(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = arg_174_1.actors_["1066ui_story"]
			local var_177_1 = 0

			if var_177_1 < arg_174_1.time_ and arg_174_1.time_ <= var_177_1 + arg_177_0 and not isNil(var_177_0) and arg_174_1.var_.characterEffect1066ui_story == nil then
				arg_174_1.var_.characterEffect1066ui_story = var_177_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_2 = 0.200000002980232

			if var_177_1 <= arg_174_1.time_ and arg_174_1.time_ < var_177_1 + var_177_2 and not isNil(var_177_0) then
				local var_177_3 = (arg_174_1.time_ - var_177_1) / var_177_2

				if arg_174_1.var_.characterEffect1066ui_story and not isNil(var_177_0) then
					local var_177_4 = Mathf.Lerp(0, 0.5, var_177_3)

					arg_174_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_174_1.var_.characterEffect1066ui_story.fillRatio = var_177_4
				end
			end

			if arg_174_1.time_ >= var_177_1 + var_177_2 and arg_174_1.time_ < var_177_1 + var_177_2 + arg_177_0 and not isNil(var_177_0) and arg_174_1.var_.characterEffect1066ui_story then
				local var_177_5 = 0.5

				arg_174_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_174_1.var_.characterEffect1066ui_story.fillRatio = var_177_5
			end

			local var_177_6 = 0
			local var_177_7 = 0.6

			if var_177_6 < arg_174_1.time_ and arg_174_1.time_ <= var_177_6 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				local var_177_8 = arg_174_1:FormatText(StoryNameCfg[7].name)

				arg_174_1.leftNameTxt_.text = var_177_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, true)
				arg_174_1.iconController_:SetSelectedState("hero")

				arg_174_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_174_1.callingController_:SetSelectedState("normal")

				arg_174_1.keyicon_.color = Color.New(1, 1, 1)
				arg_174_1.icon_.color = Color.New(1, 1, 1)

				local var_177_9 = arg_174_1:GetWordFromCfg(924011042)
				local var_177_10 = arg_174_1:FormatText(var_177_9.content)

				arg_174_1.text_.text = var_177_10

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_11 = 24
				local var_177_12 = utf8.len(var_177_10)
				local var_177_13 = var_177_11 <= 0 and var_177_7 or var_177_7 * (var_177_12 / var_177_11)

				if var_177_13 > 0 and var_177_7 < var_177_13 then
					arg_174_1.talkMaxDuration = var_177_13

					if var_177_13 + var_177_6 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_13 + var_177_6
					end
				end

				arg_174_1.text_.text = var_177_10
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)
				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_14 = math.max(var_177_7, arg_174_1.talkMaxDuration)

			if var_177_6 <= arg_174_1.time_ and arg_174_1.time_ < var_177_6 + var_177_14 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_6) / var_177_14

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_6 + var_177_14 and arg_174_1.time_ < var_177_6 + var_177_14 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play924011043 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 924011043
		arg_178_1.duration_ = 18.6

		local var_178_0 = {
			zh = 11.9,
			ja = 18.6
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
				arg_178_0:Play924011044(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = arg_178_1.actors_["1033ui_story"].transform
			local var_181_1 = 0

			if var_181_1 < arg_178_1.time_ and arg_178_1.time_ <= var_181_1 + arg_181_0 then
				arg_178_1.var_.moveOldPos1033ui_story = var_181_0.localPosition
			end

			local var_181_2 = 0.001

			if var_181_1 <= arg_178_1.time_ and arg_178_1.time_ < var_181_1 + var_181_2 then
				local var_181_3 = (arg_178_1.time_ - var_181_1) / var_181_2
				local var_181_4 = Vector3.New(0, -1.01, -6.13)

				var_181_0.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos1033ui_story, var_181_4, var_181_3)

				local var_181_5 = manager.ui.mainCamera.transform.position - var_181_0.position

				var_181_0.forward = Vector3.New(var_181_5.x, var_181_5.y, var_181_5.z)

				local var_181_6 = var_181_0.localEulerAngles

				var_181_6.z = 0
				var_181_6.x = 0
				var_181_0.localEulerAngles = var_181_6
			end

			if arg_178_1.time_ >= var_181_1 + var_181_2 and arg_178_1.time_ < var_181_1 + var_181_2 + arg_181_0 then
				var_181_0.localPosition = Vector3.New(0, -1.01, -6.13)

				local var_181_7 = manager.ui.mainCamera.transform.position - var_181_0.position

				var_181_0.forward = Vector3.New(var_181_7.x, var_181_7.y, var_181_7.z)

				local var_181_8 = var_181_0.localEulerAngles

				var_181_8.z = 0
				var_181_8.x = 0
				var_181_0.localEulerAngles = var_181_8
			end

			local var_181_9 = arg_178_1.actors_["1066ui_story"].transform
			local var_181_10 = 0

			if var_181_10 < arg_178_1.time_ and arg_178_1.time_ <= var_181_10 + arg_181_0 then
				arg_178_1.var_.moveOldPos1066ui_story = var_181_9.localPosition
			end

			local var_181_11 = 0.001

			if var_181_10 <= arg_178_1.time_ and arg_178_1.time_ < var_181_10 + var_181_11 then
				local var_181_12 = (arg_178_1.time_ - var_181_10) / var_181_11
				local var_181_13 = Vector3.New(0, 100, 0)

				var_181_9.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos1066ui_story, var_181_13, var_181_12)

				local var_181_14 = manager.ui.mainCamera.transform.position - var_181_9.position

				var_181_9.forward = Vector3.New(var_181_14.x, var_181_14.y, var_181_14.z)

				local var_181_15 = var_181_9.localEulerAngles

				var_181_15.z = 0
				var_181_15.x = 0
				var_181_9.localEulerAngles = var_181_15
			end

			if arg_178_1.time_ >= var_181_10 + var_181_11 and arg_178_1.time_ < var_181_10 + var_181_11 + arg_181_0 then
				var_181_9.localPosition = Vector3.New(0, 100, 0)

				local var_181_16 = manager.ui.mainCamera.transform.position - var_181_9.position

				var_181_9.forward = Vector3.New(var_181_16.x, var_181_16.y, var_181_16.z)

				local var_181_17 = var_181_9.localEulerAngles

				var_181_17.z = 0
				var_181_17.x = 0
				var_181_9.localEulerAngles = var_181_17
			end

			local var_181_18 = arg_178_1.actors_["1033ui_story"]
			local var_181_19 = 0

			if var_181_19 < arg_178_1.time_ and arg_178_1.time_ <= var_181_19 + arg_181_0 and not isNil(var_181_18) and arg_178_1.var_.characterEffect1033ui_story == nil then
				arg_178_1.var_.characterEffect1033ui_story = var_181_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_20 = 0.200000002980232

			if var_181_19 <= arg_178_1.time_ and arg_178_1.time_ < var_181_19 + var_181_20 and not isNil(var_181_18) then
				local var_181_21 = (arg_178_1.time_ - var_181_19) / var_181_20

				if arg_178_1.var_.characterEffect1033ui_story and not isNil(var_181_18) then
					arg_178_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_178_1.time_ >= var_181_19 + var_181_20 and arg_178_1.time_ < var_181_19 + var_181_20 + arg_181_0 and not isNil(var_181_18) and arg_178_1.var_.characterEffect1033ui_story then
				arg_178_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_181_22 = 0

			if var_181_22 < arg_178_1.time_ and arg_178_1.time_ <= var_181_22 + arg_181_0 then
				arg_178_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action1_1")
			end

			local var_181_23 = 0

			if var_181_23 < arg_178_1.time_ and arg_178_1.time_ <= var_181_23 + arg_181_0 then
				arg_178_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_181_24 = 0
			local var_181_25 = 1.475

			if var_181_24 < arg_178_1.time_ and arg_178_1.time_ <= var_181_24 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				local var_181_26 = arg_178_1:FormatText(StoryNameCfg[236].name)

				arg_178_1.leftNameTxt_.text = var_181_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_27 = arg_178_1:GetWordFromCfg(924011043)
				local var_181_28 = arg_178_1:FormatText(var_181_27.content)

				arg_178_1.text_.text = var_181_28

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_29 = 59
				local var_181_30 = utf8.len(var_181_28)
				local var_181_31 = var_181_29 <= 0 and var_181_25 or var_181_25 * (var_181_30 / var_181_29)

				if var_181_31 > 0 and var_181_25 < var_181_31 then
					arg_178_1.talkMaxDuration = var_181_31

					if var_181_31 + var_181_24 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_31 + var_181_24
					end
				end

				arg_178_1.text_.text = var_181_28
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011043", "story_v_side_old_924011.awb") ~= 0 then
					local var_181_32 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011043", "story_v_side_old_924011.awb") / 1000

					if var_181_32 + var_181_24 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_32 + var_181_24
					end

					if var_181_27.prefab_name ~= "" and arg_178_1.actors_[var_181_27.prefab_name] ~= nil then
						local var_181_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_27.prefab_name].transform, "story_v_side_old_924011", "924011043", "story_v_side_old_924011.awb")

						arg_178_1:RecordAudio("924011043", var_181_33)
						arg_178_1:RecordAudio("924011043", var_181_33)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011043", "story_v_side_old_924011.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011043", "story_v_side_old_924011.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_34 = math.max(var_181_25, arg_178_1.talkMaxDuration)

			if var_181_24 <= arg_178_1.time_ and arg_178_1.time_ < var_181_24 + var_181_34 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_24) / var_181_34

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_24 + var_181_34 and arg_178_1.time_ < var_181_24 + var_181_34 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_178_1:InitPlayNodeList()
	end,
	Play924011044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 924011044
		arg_182_1.duration_ = 17

		local var_182_0 = {
			zh = 10.266,
			ja = 17
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
				arg_182_0:Play924011045(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = 0
			local var_185_1 = 1.375

			if var_185_0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_0 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				local var_185_2 = arg_182_1:FormatText(StoryNameCfg[236].name)

				arg_182_1.leftNameTxt_.text = var_185_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_3 = arg_182_1:GetWordFromCfg(924011044)
				local var_185_4 = arg_182_1:FormatText(var_185_3.content)

				arg_182_1.text_.text = var_185_4

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_5 = 55
				local var_185_6 = utf8.len(var_185_4)
				local var_185_7 = var_185_5 <= 0 and var_185_1 or var_185_1 * (var_185_6 / var_185_5)

				if var_185_7 > 0 and var_185_1 < var_185_7 then
					arg_182_1.talkMaxDuration = var_185_7

					if var_185_7 + var_185_0 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_7 + var_185_0
					end
				end

				arg_182_1.text_.text = var_185_4
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011044", "story_v_side_old_924011.awb") ~= 0 then
					local var_185_8 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011044", "story_v_side_old_924011.awb") / 1000

					if var_185_8 + var_185_0 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_8 + var_185_0
					end

					if var_185_3.prefab_name ~= "" and arg_182_1.actors_[var_185_3.prefab_name] ~= nil then
						local var_185_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_3.prefab_name].transform, "story_v_side_old_924011", "924011044", "story_v_side_old_924011.awb")

						arg_182_1:RecordAudio("924011044", var_185_9)
						arg_182_1:RecordAudio("924011044", var_185_9)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011044", "story_v_side_old_924011.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011044", "story_v_side_old_924011.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_10 = math.max(var_185_1, arg_182_1.talkMaxDuration)

			if var_185_0 <= arg_182_1.time_ and arg_182_1.time_ < var_185_0 + var_185_10 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_0) / var_185_10

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_0 + var_185_10 and arg_182_1.time_ < var_185_0 + var_185_10 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play924011045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 924011045
		arg_186_1.duration_ = 5

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play924011046(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = arg_186_1.actors_["1033ui_story"]
			local var_189_1 = 0

			if var_189_1 < arg_186_1.time_ and arg_186_1.time_ <= var_189_1 + arg_189_0 and not isNil(var_189_0) and arg_186_1.var_.characterEffect1033ui_story == nil then
				arg_186_1.var_.characterEffect1033ui_story = var_189_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_2 = 0.200000002980232

			if var_189_1 <= arg_186_1.time_ and arg_186_1.time_ < var_189_1 + var_189_2 and not isNil(var_189_0) then
				local var_189_3 = (arg_186_1.time_ - var_189_1) / var_189_2

				if arg_186_1.var_.characterEffect1033ui_story and not isNil(var_189_0) then
					local var_189_4 = Mathf.Lerp(0, 0.5, var_189_3)

					arg_186_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_186_1.var_.characterEffect1033ui_story.fillRatio = var_189_4
				end
			end

			if arg_186_1.time_ >= var_189_1 + var_189_2 and arg_186_1.time_ < var_189_1 + var_189_2 + arg_189_0 and not isNil(var_189_0) and arg_186_1.var_.characterEffect1033ui_story then
				local var_189_5 = 0.5

				arg_186_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_186_1.var_.characterEffect1033ui_story.fillRatio = var_189_5
			end

			local var_189_6 = 0
			local var_189_7 = 0.675

			if var_189_6 < arg_186_1.time_ and arg_186_1.time_ <= var_189_6 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, false)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_8 = arg_186_1:GetWordFromCfg(924011045)
				local var_189_9 = arg_186_1:FormatText(var_189_8.content)

				arg_186_1.text_.text = var_189_9

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_10 = 27
				local var_189_11 = utf8.len(var_189_9)
				local var_189_12 = var_189_10 <= 0 and var_189_7 or var_189_7 * (var_189_11 / var_189_10)

				if var_189_12 > 0 and var_189_7 < var_189_12 then
					arg_186_1.talkMaxDuration = var_189_12

					if var_189_12 + var_189_6 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_12 + var_189_6
					end
				end

				arg_186_1.text_.text = var_189_9
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)
				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_13 = math.max(var_189_7, arg_186_1.talkMaxDuration)

			if var_189_6 <= arg_186_1.time_ and arg_186_1.time_ < var_189_6 + var_189_13 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_6) / var_189_13

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_6 + var_189_13 and arg_186_1.time_ < var_189_6 + var_189_13 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play924011046 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 924011046
		arg_190_1.duration_ = 19.5

		local var_190_0 = {
			zh = 11.2,
			ja = 19.5
		}
		local var_190_1 = manager.audio:GetLocalizationFlag()

		if var_190_0[var_190_1] ~= nil then
			arg_190_1.duration_ = var_190_0[var_190_1]
		end

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play924011047(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = arg_190_1.actors_["1033ui_story"].transform
			local var_193_1 = 0

			if var_193_1 < arg_190_1.time_ and arg_190_1.time_ <= var_193_1 + arg_193_0 then
				arg_190_1.var_.moveOldPos1033ui_story = var_193_0.localPosition
			end

			local var_193_2 = 0.001

			if var_193_1 <= arg_190_1.time_ and arg_190_1.time_ < var_193_1 + var_193_2 then
				local var_193_3 = (arg_190_1.time_ - var_193_1) / var_193_2
				local var_193_4 = Vector3.New(0, -1.01, -6.13)

				var_193_0.localPosition = Vector3.Lerp(arg_190_1.var_.moveOldPos1033ui_story, var_193_4, var_193_3)

				local var_193_5 = manager.ui.mainCamera.transform.position - var_193_0.position

				var_193_0.forward = Vector3.New(var_193_5.x, var_193_5.y, var_193_5.z)

				local var_193_6 = var_193_0.localEulerAngles

				var_193_6.z = 0
				var_193_6.x = 0
				var_193_0.localEulerAngles = var_193_6
			end

			if arg_190_1.time_ >= var_193_1 + var_193_2 and arg_190_1.time_ < var_193_1 + var_193_2 + arg_193_0 then
				var_193_0.localPosition = Vector3.New(0, -1.01, -6.13)

				local var_193_7 = manager.ui.mainCamera.transform.position - var_193_0.position

				var_193_0.forward = Vector3.New(var_193_7.x, var_193_7.y, var_193_7.z)

				local var_193_8 = var_193_0.localEulerAngles

				var_193_8.z = 0
				var_193_8.x = 0
				var_193_0.localEulerAngles = var_193_8
			end

			local var_193_9 = arg_190_1.actors_["1033ui_story"]
			local var_193_10 = 0

			if var_193_10 < arg_190_1.time_ and arg_190_1.time_ <= var_193_10 + arg_193_0 and not isNil(var_193_9) and arg_190_1.var_.characterEffect1033ui_story == nil then
				arg_190_1.var_.characterEffect1033ui_story = var_193_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_11 = 0.200000002980232

			if var_193_10 <= arg_190_1.time_ and arg_190_1.time_ < var_193_10 + var_193_11 and not isNil(var_193_9) then
				local var_193_12 = (arg_190_1.time_ - var_193_10) / var_193_11

				if arg_190_1.var_.characterEffect1033ui_story and not isNil(var_193_9) then
					arg_190_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_190_1.time_ >= var_193_10 + var_193_11 and arg_190_1.time_ < var_193_10 + var_193_11 + arg_193_0 and not isNil(var_193_9) and arg_190_1.var_.characterEffect1033ui_story then
				arg_190_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_193_13 = 0

			if var_193_13 < arg_190_1.time_ and arg_190_1.time_ <= var_193_13 + arg_193_0 then
				arg_190_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action3_1")
			end

			local var_193_14 = 0

			if var_193_14 < arg_190_1.time_ and arg_190_1.time_ <= var_193_14 + arg_193_0 then
				arg_190_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_193_15 = 0
			local var_193_16 = 1.45

			if var_193_15 < arg_190_1.time_ and arg_190_1.time_ <= var_193_15 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				local var_193_17 = arg_190_1:FormatText(StoryNameCfg[236].name)

				arg_190_1.leftNameTxt_.text = var_193_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_18 = arg_190_1:GetWordFromCfg(924011046)
				local var_193_19 = arg_190_1:FormatText(var_193_18.content)

				arg_190_1.text_.text = var_193_19

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_20 = 58
				local var_193_21 = utf8.len(var_193_19)
				local var_193_22 = var_193_20 <= 0 and var_193_16 or var_193_16 * (var_193_21 / var_193_20)

				if var_193_22 > 0 and var_193_16 < var_193_22 then
					arg_190_1.talkMaxDuration = var_193_22

					if var_193_22 + var_193_15 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_22 + var_193_15
					end
				end

				arg_190_1.text_.text = var_193_19
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011046", "story_v_side_old_924011.awb") ~= 0 then
					local var_193_23 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011046", "story_v_side_old_924011.awb") / 1000

					if var_193_23 + var_193_15 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_23 + var_193_15
					end

					if var_193_18.prefab_name ~= "" and arg_190_1.actors_[var_193_18.prefab_name] ~= nil then
						local var_193_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_18.prefab_name].transform, "story_v_side_old_924011", "924011046", "story_v_side_old_924011.awb")

						arg_190_1:RecordAudio("924011046", var_193_24)
						arg_190_1:RecordAudio("924011046", var_193_24)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011046", "story_v_side_old_924011.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011046", "story_v_side_old_924011.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_25 = math.max(var_193_16, arg_190_1.talkMaxDuration)

			if var_193_15 <= arg_190_1.time_ and arg_190_1.time_ < var_193_15 + var_193_25 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_15) / var_193_25

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_15 + var_193_25 and arg_190_1.time_ < var_193_15 + var_193_25 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_190_1:InitPlayNodeList()
	end,
	Play924011047 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 924011047
		arg_194_1.duration_ = 5

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play924011048(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = arg_194_1.actors_["1033ui_story"]
			local var_197_1 = 0

			if var_197_1 < arg_194_1.time_ and arg_194_1.time_ <= var_197_1 + arg_197_0 and not isNil(var_197_0) and arg_194_1.var_.characterEffect1033ui_story == nil then
				arg_194_1.var_.characterEffect1033ui_story = var_197_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_2 = 0.200000002980232

			if var_197_1 <= arg_194_1.time_ and arg_194_1.time_ < var_197_1 + var_197_2 and not isNil(var_197_0) then
				local var_197_3 = (arg_194_1.time_ - var_197_1) / var_197_2

				if arg_194_1.var_.characterEffect1033ui_story and not isNil(var_197_0) then
					local var_197_4 = Mathf.Lerp(0, 0.5, var_197_3)

					arg_194_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_194_1.var_.characterEffect1033ui_story.fillRatio = var_197_4
				end
			end

			if arg_194_1.time_ >= var_197_1 + var_197_2 and arg_194_1.time_ < var_197_1 + var_197_2 + arg_197_0 and not isNil(var_197_0) and arg_194_1.var_.characterEffect1033ui_story then
				local var_197_5 = 0.5

				arg_194_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_194_1.var_.characterEffect1033ui_story.fillRatio = var_197_5
			end

			local var_197_6 = 0
			local var_197_7 = 0.25

			if var_197_6 < arg_194_1.time_ and arg_194_1.time_ <= var_197_6 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				local var_197_8 = arg_194_1:FormatText(StoryNameCfg[7].name)

				arg_194_1.leftNameTxt_.text = var_197_8

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

				local var_197_9 = arg_194_1:GetWordFromCfg(924011047)
				local var_197_10 = arg_194_1:FormatText(var_197_9.content)

				arg_194_1.text_.text = var_197_10

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_11 = 10
				local var_197_12 = utf8.len(var_197_10)
				local var_197_13 = var_197_11 <= 0 and var_197_7 or var_197_7 * (var_197_12 / var_197_11)

				if var_197_13 > 0 and var_197_7 < var_197_13 then
					arg_194_1.talkMaxDuration = var_197_13

					if var_197_13 + var_197_6 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_13 + var_197_6
					end
				end

				arg_194_1.text_.text = var_197_10
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)
				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_14 = math.max(var_197_7, arg_194_1.talkMaxDuration)

			if var_197_6 <= arg_194_1.time_ and arg_194_1.time_ < var_197_6 + var_197_14 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_6) / var_197_14

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_6 + var_197_14 and arg_194_1.time_ < var_197_6 + var_197_14 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play924011048 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 924011048
		arg_198_1.duration_ = 9

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play924011049(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = arg_198_1.actors_["1033ui_story"].transform
			local var_201_1 = 0.965999998152256

			if var_201_1 < arg_198_1.time_ and arg_198_1.time_ <= var_201_1 + arg_201_0 then
				arg_198_1.var_.moveOldPos1033ui_story = var_201_0.localPosition
			end

			local var_201_2 = 0.001

			if var_201_1 <= arg_198_1.time_ and arg_198_1.time_ < var_201_1 + var_201_2 then
				local var_201_3 = (arg_198_1.time_ - var_201_1) / var_201_2
				local var_201_4 = Vector3.New(0, 100, 0)

				var_201_0.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPos1033ui_story, var_201_4, var_201_3)

				local var_201_5 = manager.ui.mainCamera.transform.position - var_201_0.position

				var_201_0.forward = Vector3.New(var_201_5.x, var_201_5.y, var_201_5.z)

				local var_201_6 = var_201_0.localEulerAngles

				var_201_6.z = 0
				var_201_6.x = 0
				var_201_0.localEulerAngles = var_201_6
			end

			if arg_198_1.time_ >= var_201_1 + var_201_2 and arg_198_1.time_ < var_201_1 + var_201_2 + arg_201_0 then
				var_201_0.localPosition = Vector3.New(0, 100, 0)

				local var_201_7 = manager.ui.mainCamera.transform.position - var_201_0.position

				var_201_0.forward = Vector3.New(var_201_7.x, var_201_7.y, var_201_7.z)

				local var_201_8 = var_201_0.localEulerAngles

				var_201_8.z = 0
				var_201_8.x = 0
				var_201_0.localEulerAngles = var_201_8
			end

			local var_201_9 = 0

			if var_201_9 < arg_198_1.time_ and arg_198_1.time_ <= var_201_9 + arg_201_0 then
				arg_198_1.mask_.enabled = true
				arg_198_1.mask_.raycastTarget = true

				arg_198_1:SetGaussion(false)
			end

			local var_201_10 = 1

			if var_201_9 <= arg_198_1.time_ and arg_198_1.time_ < var_201_9 + var_201_10 then
				local var_201_11 = (arg_198_1.time_ - var_201_9) / var_201_10
				local var_201_12 = Color.New(0, 0, 0)

				var_201_12.a = Mathf.Lerp(0, 1, var_201_11)
				arg_198_1.mask_.color = var_201_12
			end

			if arg_198_1.time_ >= var_201_9 + var_201_10 and arg_198_1.time_ < var_201_9 + var_201_10 + arg_201_0 then
				local var_201_13 = Color.New(0, 0, 0)

				var_201_13.a = 1
				arg_198_1.mask_.color = var_201_13
			end

			local var_201_14 = 1

			if var_201_14 < arg_198_1.time_ and arg_198_1.time_ <= var_201_14 + arg_201_0 then
				arg_198_1.mask_.enabled = true
				arg_198_1.mask_.raycastTarget = true

				arg_198_1:SetGaussion(false)
			end

			local var_201_15 = 1.55

			if var_201_14 <= arg_198_1.time_ and arg_198_1.time_ < var_201_14 + var_201_15 then
				local var_201_16 = (arg_198_1.time_ - var_201_14) / var_201_15
				local var_201_17 = Color.New(0, 0, 0)

				var_201_17.a = Mathf.Lerp(1, 0, var_201_16)
				arg_198_1.mask_.color = var_201_17
			end

			if arg_198_1.time_ >= var_201_14 + var_201_15 and arg_198_1.time_ < var_201_14 + var_201_15 + arg_201_0 then
				local var_201_18 = Color.New(0, 0, 0)
				local var_201_19 = 0

				arg_198_1.mask_.enabled = false
				var_201_18.a = var_201_19
				arg_198_1.mask_.color = var_201_18
			end

			local var_201_20 = manager.ui.mainCamera.transform
			local var_201_21 = 1

			if var_201_21 < arg_198_1.time_ and arg_198_1.time_ <= var_201_21 + arg_201_0 then
				local var_201_22 = arg_198_1.var_.effectjingbao1
				local var_201_23
				local var_201_24 = var_201_20

				if not var_201_22 then
					var_201_22 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_jingbao_in_keep"), var_201_24)
					var_201_22.name = "jingbao1"
					arg_198_1.var_.effectjingbao1 = var_201_22
				else
					var_201_22.transform:SetParent(var_201_24)
				end

				var_201_22.transform.localPosition = Vector3.New(0, 0, 0)
				var_201_22.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_201_25 = manager.ui.mainCameraCom_
				local var_201_26 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_201_25.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_201_27 = var_201_22.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_201_28 = 15
				local var_201_29 = 2 * var_201_28 * Mathf.Tan(var_201_25.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_201_25.aspect
				local var_201_30 = 1
				local var_201_31 = 1.7777777777777777

				if var_201_31 < var_201_25.aspect then
					var_201_30 = var_201_29 / (2 * var_201_28 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_201_31)
				end

				for iter_201_0, iter_201_1 in ipairs(var_201_27) do
					local var_201_32 = iter_201_1.transform.localScale

					iter_201_1.transform.localScale = Vector3.New(var_201_32.x / var_201_26 * var_201_30, var_201_32.y / var_201_26, var_201_32.z)
				end
			end

			local var_201_33 = manager.ui.mainCamera.transform
			local var_201_34 = 5.499999999999

			if var_201_34 < arg_198_1.time_ and arg_198_1.time_ <= var_201_34 + arg_201_0 then
				local var_201_35 = arg_198_1.var_.effectjingbao2
				local var_201_36
				local var_201_37 = var_201_33

				if not var_201_35 then
					var_201_35 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_jingbao_out"), var_201_37)
					var_201_35.name = "jingbao2"
					arg_198_1.var_.effectjingbao2 = var_201_35
				else
					var_201_35.transform:SetParent(var_201_37)
				end

				var_201_35.transform.localPosition = Vector3.New(0, 0, 0)
				var_201_35.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_201_38 = manager.ui.mainCameraCom_
				local var_201_39 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_201_38.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_201_40 = var_201_35.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_201_41 = 15
				local var_201_42 = 2 * var_201_41 * Mathf.Tan(var_201_38.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_201_38.aspect
				local var_201_43 = 1
				local var_201_44 = 1.7777777777777777

				if var_201_44 < var_201_38.aspect then
					var_201_43 = var_201_42 / (2 * var_201_41 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_201_44)
				end

				for iter_201_2, iter_201_3 in ipairs(var_201_40) do
					local var_201_45 = iter_201_3.transform.localScale

					iter_201_3.transform.localScale = Vector3.New(var_201_45.x / var_201_39 * var_201_43, var_201_45.y / var_201_39, var_201_45.z)
				end
			end

			local var_201_46 = manager.ui.mainCamera.transform
			local var_201_47 = 6.499999999999

			if var_201_47 < arg_198_1.time_ and arg_198_1.time_ <= var_201_47 + arg_201_0 then
				local var_201_48 = arg_198_1.var_.effectjingbao2

				if var_201_48 then
					Object.Destroy(var_201_48)

					arg_198_1.var_.effectjingbao2 = nil
				end
			end

			local var_201_49 = manager.ui.mainCamera.transform
			local var_201_50 = 5.499999999999

			if var_201_50 < arg_198_1.time_ and arg_198_1.time_ <= var_201_50 + arg_201_0 then
				local var_201_51 = arg_198_1.var_.effectjingbao1

				if var_201_51 then
					Object.Destroy(var_201_51)

					arg_198_1.var_.effectjingbao1 = nil
				end
			end

			local var_201_52 = manager.ui.mainCamera.transform
			local var_201_53 = 1

			if var_201_53 < arg_198_1.time_ and arg_198_1.time_ <= var_201_53 + arg_201_0 then
				local var_201_54 = arg_198_1.var_.effectjingbao3jingbao3
				local var_201_55
				local var_201_56 = var_201_52

				if not var_201_54 then
					var_201_54 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_mist_out"), var_201_56)
					var_201_54.name = "jingbao3"
					arg_198_1.var_.effectjingbao3jingbao3 = var_201_54
				else
					var_201_54.transform:SetParent(var_201_56)
				end

				var_201_54.transform.localPosition = Vector3.New(0, 0, 0)
				var_201_54.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_201_57 = 2.55

			if var_201_57 < arg_198_1.time_ and arg_198_1.time_ <= var_201_57 + arg_201_0 then
				arg_198_1.allBtn_.enabled = false
			end

			local var_201_58 = 2.949999999999

			if arg_198_1.time_ >= var_201_57 + var_201_58 and arg_198_1.time_ < var_201_57 + var_201_58 + arg_201_0 then
				arg_198_1.allBtn_.enabled = true
			end

			local var_201_59 = 1
			local var_201_60 = 1

			if var_201_59 < arg_198_1.time_ and arg_198_1.time_ <= var_201_59 + arg_201_0 then
				local var_201_61 = "play"
				local var_201_62 = "effect"

				arg_198_1:AudioAction(var_201_61, var_201_62, "se_story_129", "se_story_129_alarm", "")
			end

			if arg_198_1.frameCnt_ <= 1 then
				arg_198_1.dialog_:SetActive(false)
			end

			local var_201_63 = 4
			local var_201_64 = 0.125

			if var_201_63 < arg_198_1.time_ and arg_198_1.time_ <= var_201_63 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0

				arg_198_1.dialog_:SetActive(true)

				arg_198_1.dialogCg_.alpha = 0

				local var_201_65 = LeanTween.value(arg_198_1.dialog_, 0, 1, 0.3)

				var_201_65:setOnUpdate(LuaHelper.FloatAction(function(arg_202_0)
					arg_198_1.dialogCg_.alpha = arg_202_0
				end))
				var_201_65:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_198_1.dialog_)
					var_201_65:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_198_1.duration_ = arg_198_1.duration_ + 0.3

				SetActive(arg_198_1.leftNameGo_, false)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_66 = arg_198_1:GetWordFromCfg(924011048)
				local var_201_67 = arg_198_1:FormatText(var_201_66.content)

				arg_198_1.text_.text = var_201_67

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_68 = 5
				local var_201_69 = utf8.len(var_201_67)
				local var_201_70 = var_201_68 <= 0 and var_201_64 or var_201_64 * (var_201_69 / var_201_68)

				if var_201_70 > 0 and var_201_64 < var_201_70 then
					arg_198_1.talkMaxDuration = var_201_70
					var_201_63 = var_201_63 + 0.3

					if var_201_70 + var_201_63 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_70 + var_201_63
					end
				end

				arg_198_1.text_.text = var_201_67
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)
				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_71 = var_201_63 + 0.3
			local var_201_72 = math.max(var_201_64, arg_198_1.talkMaxDuration)

			if var_201_71 <= arg_198_1.time_ and arg_198_1.time_ < var_201_71 + var_201_72 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_71) / var_201_72

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_71 + var_201_72 and arg_198_1.time_ < var_201_71 + var_201_72 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0.965999998152256,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_198_1:InitPlayNodeList()
	end,
	Play924011049 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 924011049
		arg_204_1.duration_ = 5

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play924011050(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = 0
			local var_207_1 = 0.925

			if var_207_0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_0 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, false)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_2 = arg_204_1:GetWordFromCfg(924011049)
				local var_207_3 = arg_204_1:FormatText(var_207_2.content)

				arg_204_1.text_.text = var_207_3

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_4 = 37
				local var_207_5 = utf8.len(var_207_3)
				local var_207_6 = var_207_4 <= 0 and var_207_1 or var_207_1 * (var_207_5 / var_207_4)

				if var_207_6 > 0 and var_207_1 < var_207_6 then
					arg_204_1.talkMaxDuration = var_207_6

					if var_207_6 + var_207_0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_6 + var_207_0
					end
				end

				arg_204_1.text_.text = var_207_3
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)
				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_7 = math.max(var_207_1, arg_204_1.talkMaxDuration)

			if var_207_0 <= arg_204_1.time_ and arg_204_1.time_ < var_207_0 + var_207_7 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_0) / var_207_7

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_0 + var_207_7 and arg_204_1.time_ < var_207_0 + var_207_7 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play924011050 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 924011050
		arg_208_1.duration_ = 5

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play924011051(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = 0
			local var_211_1 = 0.275

			if var_211_0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_0 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				local var_211_2 = arg_208_1:FormatText(StoryNameCfg[7].name)

				arg_208_1.leftNameTxt_.text = var_211_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, true)
				arg_208_1.iconController_:SetSelectedState("hero")

				arg_208_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_208_1.callingController_:SetSelectedState("normal")

				arg_208_1.keyicon_.color = Color.New(1, 1, 1)
				arg_208_1.icon_.color = Color.New(1, 1, 1)

				local var_211_3 = arg_208_1:GetWordFromCfg(924011050)
				local var_211_4 = arg_208_1:FormatText(var_211_3.content)

				arg_208_1.text_.text = var_211_4

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_5 = 11
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
				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_8 = math.max(var_211_1, arg_208_1.talkMaxDuration)

			if var_211_0 <= arg_208_1.time_ and arg_208_1.time_ < var_211_0 + var_211_8 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_0) / var_211_8

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_0 + var_211_8 and arg_208_1.time_ < var_211_0 + var_211_8 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play924011051 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 924011051
		arg_212_1.duration_ = 8.17

		local var_212_0 = {
			zh = 5.533,
			ja = 8.166
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
				arg_212_0:Play924011052(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = arg_212_1.actors_["1033ui_story"].transform
			local var_215_1 = 0

			if var_215_1 < arg_212_1.time_ and arg_212_1.time_ <= var_215_1 + arg_215_0 then
				arg_212_1.var_.moveOldPos1033ui_story = var_215_0.localPosition
			end

			local var_215_2 = 0.001

			if var_215_1 <= arg_212_1.time_ and arg_212_1.time_ < var_215_1 + var_215_2 then
				local var_215_3 = (arg_212_1.time_ - var_215_1) / var_215_2
				local var_215_4 = Vector3.New(0, -1.01, -6.13)

				var_215_0.localPosition = Vector3.Lerp(arg_212_1.var_.moveOldPos1033ui_story, var_215_4, var_215_3)

				local var_215_5 = manager.ui.mainCamera.transform.position - var_215_0.position

				var_215_0.forward = Vector3.New(var_215_5.x, var_215_5.y, var_215_5.z)

				local var_215_6 = var_215_0.localEulerAngles

				var_215_6.z = 0
				var_215_6.x = 0
				var_215_0.localEulerAngles = var_215_6
			end

			if arg_212_1.time_ >= var_215_1 + var_215_2 and arg_212_1.time_ < var_215_1 + var_215_2 + arg_215_0 then
				var_215_0.localPosition = Vector3.New(0, -1.01, -6.13)

				local var_215_7 = manager.ui.mainCamera.transform.position - var_215_0.position

				var_215_0.forward = Vector3.New(var_215_7.x, var_215_7.y, var_215_7.z)

				local var_215_8 = var_215_0.localEulerAngles

				var_215_8.z = 0
				var_215_8.x = 0
				var_215_0.localEulerAngles = var_215_8
			end

			local var_215_9 = arg_212_1.actors_["1033ui_story"]
			local var_215_10 = 0

			if var_215_10 < arg_212_1.time_ and arg_212_1.time_ <= var_215_10 + arg_215_0 and not isNil(var_215_9) and arg_212_1.var_.characterEffect1033ui_story == nil then
				arg_212_1.var_.characterEffect1033ui_story = var_215_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_11 = 0.200000002980232

			if var_215_10 <= arg_212_1.time_ and arg_212_1.time_ < var_215_10 + var_215_11 and not isNil(var_215_9) then
				local var_215_12 = (arg_212_1.time_ - var_215_10) / var_215_11

				if arg_212_1.var_.characterEffect1033ui_story and not isNil(var_215_9) then
					arg_212_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_212_1.time_ >= var_215_10 + var_215_11 and arg_212_1.time_ < var_215_10 + var_215_11 + arg_215_0 and not isNil(var_215_9) and arg_212_1.var_.characterEffect1033ui_story then
				arg_212_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_215_13 = 0

			if var_215_13 < arg_212_1.time_ and arg_212_1.time_ <= var_215_13 + arg_215_0 then
				arg_212_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action1_1")
			end

			local var_215_14 = 0

			if var_215_14 < arg_212_1.time_ and arg_212_1.time_ <= var_215_14 + arg_215_0 then
				arg_212_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_215_15 = 0
			local var_215_16 = 0.675

			if var_215_15 < arg_212_1.time_ and arg_212_1.time_ <= var_215_15 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				local var_215_17 = arg_212_1:FormatText(StoryNameCfg[236].name)

				arg_212_1.leftNameTxt_.text = var_215_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_18 = arg_212_1:GetWordFromCfg(924011051)
				local var_215_19 = arg_212_1:FormatText(var_215_18.content)

				arg_212_1.text_.text = var_215_19

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_20 = 27
				local var_215_21 = utf8.len(var_215_19)
				local var_215_22 = var_215_20 <= 0 and var_215_16 or var_215_16 * (var_215_21 / var_215_20)

				if var_215_22 > 0 and var_215_16 < var_215_22 then
					arg_212_1.talkMaxDuration = var_215_22

					if var_215_22 + var_215_15 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_22 + var_215_15
					end
				end

				arg_212_1.text_.text = var_215_19
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011051", "story_v_side_old_924011.awb") ~= 0 then
					local var_215_23 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011051", "story_v_side_old_924011.awb") / 1000

					if var_215_23 + var_215_15 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_23 + var_215_15
					end

					if var_215_18.prefab_name ~= "" and arg_212_1.actors_[var_215_18.prefab_name] ~= nil then
						local var_215_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_18.prefab_name].transform, "story_v_side_old_924011", "924011051", "story_v_side_old_924011.awb")

						arg_212_1:RecordAudio("924011051", var_215_24)
						arg_212_1:RecordAudio("924011051", var_215_24)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011051", "story_v_side_old_924011.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011051", "story_v_side_old_924011.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_25 = math.max(var_215_16, arg_212_1.talkMaxDuration)

			if var_215_15 <= arg_212_1.time_ and arg_212_1.time_ < var_215_15 + var_215_25 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_15) / var_215_25

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_15 + var_215_25 and arg_212_1.time_ < var_215_15 + var_215_25 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_212_1:InitPlayNodeList()
	end,
	Play924011052 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 924011052
		arg_216_1.duration_ = 5

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play924011053(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = arg_216_1.actors_["1033ui_story"]
			local var_219_1 = 0

			if var_219_1 < arg_216_1.time_ and arg_216_1.time_ <= var_219_1 + arg_219_0 and not isNil(var_219_0) and arg_216_1.var_.characterEffect1033ui_story == nil then
				arg_216_1.var_.characterEffect1033ui_story = var_219_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_2 = 0.200000002980232

			if var_219_1 <= arg_216_1.time_ and arg_216_1.time_ < var_219_1 + var_219_2 and not isNil(var_219_0) then
				local var_219_3 = (arg_216_1.time_ - var_219_1) / var_219_2

				if arg_216_1.var_.characterEffect1033ui_story and not isNil(var_219_0) then
					local var_219_4 = Mathf.Lerp(0, 0.5, var_219_3)

					arg_216_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_216_1.var_.characterEffect1033ui_story.fillRatio = var_219_4
				end
			end

			if arg_216_1.time_ >= var_219_1 + var_219_2 and arg_216_1.time_ < var_219_1 + var_219_2 + arg_219_0 and not isNil(var_219_0) and arg_216_1.var_.characterEffect1033ui_story then
				local var_219_5 = 0.5

				arg_216_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_216_1.var_.characterEffect1033ui_story.fillRatio = var_219_5
			end

			local var_219_6 = 0
			local var_219_7 = 0.375

			if var_219_6 < arg_216_1.time_ and arg_216_1.time_ <= var_219_6 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				local var_219_8 = arg_216_1:FormatText(StoryNameCfg[7].name)

				arg_216_1.leftNameTxt_.text = var_219_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, true)
				arg_216_1.iconController_:SetSelectedState("hero")

				arg_216_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_216_1.callingController_:SetSelectedState("normal")

				arg_216_1.keyicon_.color = Color.New(1, 1, 1)
				arg_216_1.icon_.color = Color.New(1, 1, 1)

				local var_219_9 = arg_216_1:GetWordFromCfg(924011052)
				local var_219_10 = arg_216_1:FormatText(var_219_9.content)

				arg_216_1.text_.text = var_219_10

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_11 = 15
				local var_219_12 = utf8.len(var_219_10)
				local var_219_13 = var_219_11 <= 0 and var_219_7 or var_219_7 * (var_219_12 / var_219_11)

				if var_219_13 > 0 and var_219_7 < var_219_13 then
					arg_216_1.talkMaxDuration = var_219_13

					if var_219_13 + var_219_6 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_13 + var_219_6
					end
				end

				arg_216_1.text_.text = var_219_10
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)
				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_14 = math.max(var_219_7, arg_216_1.talkMaxDuration)

			if var_219_6 <= arg_216_1.time_ and arg_216_1.time_ < var_219_6 + var_219_14 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_6) / var_219_14

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_6 + var_219_14 and arg_216_1.time_ < var_219_6 + var_219_14 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {}

		arg_216_1:InitPlayNodeList()
	end,
	Play924011053 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 924011053
		arg_220_1.duration_ = 2.73

		local var_220_0 = {
			zh = 2.733,
			ja = 1.7
		}
		local var_220_1 = manager.audio:GetLocalizationFlag()

		if var_220_0[var_220_1] ~= nil then
			arg_220_1.duration_ = var_220_0[var_220_1]
		end

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play924011054(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			local var_223_0 = 0
			local var_223_1 = 0.1

			if var_223_0 < arg_220_1.time_ and arg_220_1.time_ <= var_223_0 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				local var_223_2 = arg_220_1:FormatText(StoryNameCfg[32].name)

				arg_220_1.leftNameTxt_.text = var_223_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, true)
				arg_220_1.iconController_:SetSelectedState("hero")

				arg_220_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_220_1.callingController_:SetSelectedState("normal")

				arg_220_1.keyicon_.color = Color.New(1, 1, 1)
				arg_220_1.icon_.color = Color.New(1, 1, 1)

				local var_223_3 = arg_220_1:GetWordFromCfg(924011053)
				local var_223_4 = arg_220_1:FormatText(var_223_3.content)

				arg_220_1.text_.text = var_223_4

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_5 = 4
				local var_223_6 = utf8.len(var_223_4)
				local var_223_7 = var_223_5 <= 0 and var_223_1 or var_223_1 * (var_223_6 / var_223_5)

				if var_223_7 > 0 and var_223_1 < var_223_7 then
					arg_220_1.talkMaxDuration = var_223_7

					if var_223_7 + var_223_0 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_7 + var_223_0
					end
				end

				arg_220_1.text_.text = var_223_4
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011053", "story_v_side_old_924011.awb") ~= 0 then
					local var_223_8 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011053", "story_v_side_old_924011.awb") / 1000

					if var_223_8 + var_223_0 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_8 + var_223_0
					end

					if var_223_3.prefab_name ~= "" and arg_220_1.actors_[var_223_3.prefab_name] ~= nil then
						local var_223_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_3.prefab_name].transform, "story_v_side_old_924011", "924011053", "story_v_side_old_924011.awb")

						arg_220_1:RecordAudio("924011053", var_223_9)
						arg_220_1:RecordAudio("924011053", var_223_9)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011053", "story_v_side_old_924011.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011053", "story_v_side_old_924011.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_10 = math.max(var_223_1, arg_220_1.talkMaxDuration)

			if var_223_0 <= arg_220_1.time_ and arg_220_1.time_ < var_223_0 + var_223_10 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_0) / var_223_10

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_0 + var_223_10 and arg_220_1.time_ < var_223_0 + var_223_10 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {}

		arg_220_1:InitPlayNodeList()
	end,
	Play924011054 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 924011054
		arg_224_1.duration_ = 5

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play924011055(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			local var_227_0 = 0
			local var_227_1 = 0.65

			if var_227_0 < arg_224_1.time_ and arg_224_1.time_ <= var_227_0 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				local var_227_2 = arg_224_1:FormatText(StoryNameCfg[7].name)

				arg_224_1.leftNameTxt_.text = var_227_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, true)
				arg_224_1.iconController_:SetSelectedState("hero")

				arg_224_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_224_1.callingController_:SetSelectedState("normal")

				arg_224_1.keyicon_.color = Color.New(1, 1, 1)
				arg_224_1.icon_.color = Color.New(1, 1, 1)

				local var_227_3 = arg_224_1:GetWordFromCfg(924011054)
				local var_227_4 = arg_224_1:FormatText(var_227_3.content)

				arg_224_1.text_.text = var_227_4

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_5 = 26
				local var_227_6 = utf8.len(var_227_4)
				local var_227_7 = var_227_5 <= 0 and var_227_1 or var_227_1 * (var_227_6 / var_227_5)

				if var_227_7 > 0 and var_227_1 < var_227_7 then
					arg_224_1.talkMaxDuration = var_227_7

					if var_227_7 + var_227_0 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_7 + var_227_0
					end
				end

				arg_224_1.text_.text = var_227_4
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)
				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_8 = math.max(var_227_1, arg_224_1.talkMaxDuration)

			if var_227_0 <= arg_224_1.time_ and arg_224_1.time_ < var_227_0 + var_227_8 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_0) / var_227_8

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_0 + var_227_8 and arg_224_1.time_ < var_227_0 + var_227_8 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play924011055 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 924011055
		arg_228_1.duration_ = 6.2

		local var_228_0 = {
			zh = 3.9,
			ja = 6.2
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
				arg_228_0:Play924011056(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = arg_228_1.actors_["1033ui_story"]
			local var_231_1 = 0

			if var_231_1 < arg_228_1.time_ and arg_228_1.time_ <= var_231_1 + arg_231_0 and not isNil(var_231_0) and arg_228_1.var_.characterEffect1033ui_story == nil then
				arg_228_1.var_.characterEffect1033ui_story = var_231_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_2 = 0.200000002980232

			if var_231_1 <= arg_228_1.time_ and arg_228_1.time_ < var_231_1 + var_231_2 and not isNil(var_231_0) then
				local var_231_3 = (arg_228_1.time_ - var_231_1) / var_231_2

				if arg_228_1.var_.characterEffect1033ui_story and not isNil(var_231_0) then
					arg_228_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_228_1.time_ >= var_231_1 + var_231_2 and arg_228_1.time_ < var_231_1 + var_231_2 + arg_231_0 and not isNil(var_231_0) and arg_228_1.var_.characterEffect1033ui_story then
				arg_228_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_231_4 = 0

			if var_231_4 < arg_228_1.time_ and arg_228_1.time_ <= var_231_4 + arg_231_0 then
				arg_228_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action8_1")
			end

			local var_231_5 = 0

			if var_231_5 < arg_228_1.time_ and arg_228_1.time_ <= var_231_5 + arg_231_0 then
				arg_228_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_231_6 = 0
			local var_231_7 = 0.475

			if var_231_6 < arg_228_1.time_ and arg_228_1.time_ <= var_231_6 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				local var_231_8 = arg_228_1:FormatText(StoryNameCfg[236].name)

				arg_228_1.leftNameTxt_.text = var_231_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_9 = arg_228_1:GetWordFromCfg(924011055)
				local var_231_10 = arg_228_1:FormatText(var_231_9.content)

				arg_228_1.text_.text = var_231_10

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_11 = 19
				local var_231_12 = utf8.len(var_231_10)
				local var_231_13 = var_231_11 <= 0 and var_231_7 or var_231_7 * (var_231_12 / var_231_11)

				if var_231_13 > 0 and var_231_7 < var_231_13 then
					arg_228_1.talkMaxDuration = var_231_13

					if var_231_13 + var_231_6 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_13 + var_231_6
					end
				end

				arg_228_1.text_.text = var_231_10
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011055", "story_v_side_old_924011.awb") ~= 0 then
					local var_231_14 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011055", "story_v_side_old_924011.awb") / 1000

					if var_231_14 + var_231_6 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_14 + var_231_6
					end

					if var_231_9.prefab_name ~= "" and arg_228_1.actors_[var_231_9.prefab_name] ~= nil then
						local var_231_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_9.prefab_name].transform, "story_v_side_old_924011", "924011055", "story_v_side_old_924011.awb")

						arg_228_1:RecordAudio("924011055", var_231_15)
						arg_228_1:RecordAudio("924011055", var_231_15)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011055", "story_v_side_old_924011.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011055", "story_v_side_old_924011.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_16 = math.max(var_231_7, arg_228_1.talkMaxDuration)

			if var_231_6 <= arg_228_1.time_ and arg_228_1.time_ < var_231_6 + var_231_16 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_6) / var_231_16

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_6 + var_231_16 and arg_228_1.time_ < var_231_6 + var_231_16 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play924011056 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 924011056
		arg_232_1.duration_ = 6.73

		local var_232_0 = {
			zh = 4.333,
			ja = 6.733
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
				arg_232_0:Play924011057(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = 0

			if var_235_0 < arg_232_1.time_ and arg_232_1.time_ <= var_235_0 + arg_235_0 then
				arg_232_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_235_1 = 0
			local var_235_2 = 0.675

			if var_235_1 < arg_232_1.time_ and arg_232_1.time_ <= var_235_1 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				local var_235_3 = arg_232_1:FormatText(StoryNameCfg[236].name)

				arg_232_1.leftNameTxt_.text = var_235_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_4 = arg_232_1:GetWordFromCfg(924011056)
				local var_235_5 = arg_232_1:FormatText(var_235_4.content)

				arg_232_1.text_.text = var_235_5

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_6 = 27
				local var_235_7 = utf8.len(var_235_5)
				local var_235_8 = var_235_6 <= 0 and var_235_2 or var_235_2 * (var_235_7 / var_235_6)

				if var_235_8 > 0 and var_235_2 < var_235_8 then
					arg_232_1.talkMaxDuration = var_235_8

					if var_235_8 + var_235_1 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_8 + var_235_1
					end
				end

				arg_232_1.text_.text = var_235_5
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011056", "story_v_side_old_924011.awb") ~= 0 then
					local var_235_9 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011056", "story_v_side_old_924011.awb") / 1000

					if var_235_9 + var_235_1 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_9 + var_235_1
					end

					if var_235_4.prefab_name ~= "" and arg_232_1.actors_[var_235_4.prefab_name] ~= nil then
						local var_235_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_4.prefab_name].transform, "story_v_side_old_924011", "924011056", "story_v_side_old_924011.awb")

						arg_232_1:RecordAudio("924011056", var_235_10)
						arg_232_1:RecordAudio("924011056", var_235_10)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011056", "story_v_side_old_924011.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011056", "story_v_side_old_924011.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_11 = math.max(var_235_2, arg_232_1.talkMaxDuration)

			if var_235_1 <= arg_232_1.time_ and arg_232_1.time_ < var_235_1 + var_235_11 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_1) / var_235_11

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_1 + var_235_11 and arg_232_1.time_ < var_235_1 + var_235_11 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {}

		arg_232_1:InitPlayNodeList()
	end,
	Play924011057 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 924011057
		arg_236_1.duration_ = 5

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play924011058(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = arg_236_1.actors_["1033ui_story"].transform
			local var_239_1 = 0

			if var_239_1 < arg_236_1.time_ and arg_236_1.time_ <= var_239_1 + arg_239_0 then
				arg_236_1.var_.moveOldPos1033ui_story = var_239_0.localPosition
			end

			local var_239_2 = 0.001

			if var_239_1 <= arg_236_1.time_ and arg_236_1.time_ < var_239_1 + var_239_2 then
				local var_239_3 = (arg_236_1.time_ - var_239_1) / var_239_2
				local var_239_4 = Vector3.New(0, 100, 0)

				var_239_0.localPosition = Vector3.Lerp(arg_236_1.var_.moveOldPos1033ui_story, var_239_4, var_239_3)

				local var_239_5 = manager.ui.mainCamera.transform.position - var_239_0.position

				var_239_0.forward = Vector3.New(var_239_5.x, var_239_5.y, var_239_5.z)

				local var_239_6 = var_239_0.localEulerAngles

				var_239_6.z = 0
				var_239_6.x = 0
				var_239_0.localEulerAngles = var_239_6
			end

			if arg_236_1.time_ >= var_239_1 + var_239_2 and arg_236_1.time_ < var_239_1 + var_239_2 + arg_239_0 then
				var_239_0.localPosition = Vector3.New(0, 100, 0)

				local var_239_7 = manager.ui.mainCamera.transform.position - var_239_0.position

				var_239_0.forward = Vector3.New(var_239_7.x, var_239_7.y, var_239_7.z)

				local var_239_8 = var_239_0.localEulerAngles

				var_239_8.z = 0
				var_239_8.x = 0
				var_239_0.localEulerAngles = var_239_8
			end

			local var_239_9 = arg_236_1.actors_["1033ui_story"]
			local var_239_10 = 0

			if var_239_10 < arg_236_1.time_ and arg_236_1.time_ <= var_239_10 + arg_239_0 and not isNil(var_239_9) and arg_236_1.var_.characterEffect1033ui_story == nil then
				arg_236_1.var_.characterEffect1033ui_story = var_239_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_239_11 = 0.200000002980232

			if var_239_10 <= arg_236_1.time_ and arg_236_1.time_ < var_239_10 + var_239_11 and not isNil(var_239_9) then
				local var_239_12 = (arg_236_1.time_ - var_239_10) / var_239_11

				if arg_236_1.var_.characterEffect1033ui_story and not isNil(var_239_9) then
					local var_239_13 = Mathf.Lerp(0, 0.5, var_239_12)

					arg_236_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_236_1.var_.characterEffect1033ui_story.fillRatio = var_239_13
				end
			end

			if arg_236_1.time_ >= var_239_10 + var_239_11 and arg_236_1.time_ < var_239_10 + var_239_11 + arg_239_0 and not isNil(var_239_9) and arg_236_1.var_.characterEffect1033ui_story then
				local var_239_14 = 0.5

				arg_236_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_236_1.var_.characterEffect1033ui_story.fillRatio = var_239_14
			end

			local var_239_15 = 0
			local var_239_16 = 0.2

			if var_239_15 < arg_236_1.time_ and arg_236_1.time_ <= var_239_15 + arg_239_0 then
				local var_239_17 = "play"
				local var_239_18 = "music"

				arg_236_1:AudioAction(var_239_17, var_239_18, "ui_battle", "ui_battle_stopbgm", "")

				local var_239_19 = ""
				local var_239_20 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_239_20 ~= "" then
					if arg_236_1.bgmTxt_.text ~= var_239_20 and arg_236_1.bgmTxt_.text ~= "" then
						if arg_236_1.bgmTxt2_.text ~= "" then
							arg_236_1.bgmTxt_.text = arg_236_1.bgmTxt2_.text
						end

						arg_236_1.bgmTxt2_.text = var_239_20

						arg_236_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_236_1.bgmTxt_.text = var_239_20
						arg_236_1.bgmTxt2_.text = var_239_20
					end

					if arg_236_1.bgmTimer then
						arg_236_1.bgmTimer:Stop()

						arg_236_1.bgmTimer = nil
					end

					if arg_236_1.settingData.show_music_name == 1 then
						arg_236_1.musicController:SetSelectedState("show")
						arg_236_1.musicAnimator_:Play("open", 0, 0)

						if arg_236_1.settingData.music_time ~= 0 then
							arg_236_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_236_1.settingData.music_time), function()
								if arg_236_1 == nil or isNil(arg_236_1.bgmTxt_) then
									return
								end

								arg_236_1.musicController:SetSelectedState("hide")
								arg_236_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_239_21 = 0
			local var_239_22 = 1.325

			if var_239_21 < arg_236_1.time_ and arg_236_1.time_ <= var_239_21 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, false)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_23 = arg_236_1:GetWordFromCfg(924011057)
				local var_239_24 = arg_236_1:FormatText(var_239_23.content)

				arg_236_1.text_.text = var_239_24

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_25 = 53
				local var_239_26 = utf8.len(var_239_24)
				local var_239_27 = var_239_25 <= 0 and var_239_22 or var_239_22 * (var_239_26 / var_239_25)

				if var_239_27 > 0 and var_239_22 < var_239_27 then
					arg_236_1.talkMaxDuration = var_239_27

					if var_239_27 + var_239_21 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_27 + var_239_21
					end
				end

				arg_236_1.text_.text = var_239_24
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)
				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_28 = math.max(var_239_22, arg_236_1.talkMaxDuration)

			if var_239_21 <= arg_236_1.time_ and arg_236_1.time_ < var_239_21 + var_239_28 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_21) / var_239_28

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_21 + var_239_28 and arg_236_1.time_ < var_239_21 + var_239_28 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_236_1:InitPlayNodeList()
	end,
	Play924011058 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 924011058
		arg_241_1.duration_ = 9

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play924011059(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = "ST12"

			if arg_241_1.bgs_[var_244_0] == nil then
				local var_244_1 = Object.Instantiate(arg_241_1.paintGo_)

				var_244_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_244_0)
				var_244_1.name = var_244_0
				var_244_1.transform.parent = arg_241_1.stage_.transform
				var_244_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_241_1.bgs_[var_244_0] = var_244_1
			end

			local var_244_2 = 2

			if var_244_2 < arg_241_1.time_ and arg_241_1.time_ <= var_244_2 + arg_244_0 then
				local var_244_3 = manager.ui.mainCamera.transform.localPosition
				local var_244_4 = Vector3.New(0, 0, 10) + Vector3.New(var_244_3.x, var_244_3.y, 0)
				local var_244_5 = arg_241_1.bgs_.ST12

				var_244_5.transform.localPosition = var_244_4
				var_244_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_244_6 = var_244_5:GetComponent("SpriteRenderer")

				if var_244_6 and var_244_6.sprite then
					local var_244_7 = (var_244_5.transform.localPosition - var_244_3).z
					local var_244_8 = manager.ui.mainCameraCom_
					local var_244_9 = 2 * var_244_7 * Mathf.Tan(var_244_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_244_10 = var_244_9 * var_244_8.aspect
					local var_244_11 = var_244_6.sprite.bounds.size.x
					local var_244_12 = var_244_6.sprite.bounds.size.y
					local var_244_13 = var_244_10 / var_244_11
					local var_244_14 = var_244_9 / var_244_12
					local var_244_15 = var_244_14 < var_244_13 and var_244_13 or var_244_14

					var_244_5.transform.localScale = Vector3.New(var_244_15, var_244_15, 0)
				end

				for iter_244_0, iter_244_1 in pairs(arg_241_1.bgs_) do
					if iter_244_0 ~= "ST12" then
						iter_244_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_244_16 = 4

			if var_244_16 < arg_241_1.time_ and arg_241_1.time_ <= var_244_16 + arg_244_0 then
				arg_241_1.allBtn_.enabled = false
			end

			local var_244_17 = 0.3

			if arg_241_1.time_ >= var_244_16 + var_244_17 and arg_241_1.time_ < var_244_16 + var_244_17 + arg_244_0 then
				arg_241_1.allBtn_.enabled = true
			end

			local var_244_18 = 0

			if var_244_18 < arg_241_1.time_ and arg_241_1.time_ <= var_244_18 + arg_244_0 then
				arg_241_1.mask_.enabled = true
				arg_241_1.mask_.raycastTarget = true

				arg_241_1:SetGaussion(false)
			end

			local var_244_19 = 2

			if var_244_18 <= arg_241_1.time_ and arg_241_1.time_ < var_244_18 + var_244_19 then
				local var_244_20 = (arg_241_1.time_ - var_244_18) / var_244_19
				local var_244_21 = Color.New(0, 0, 0)

				var_244_21.a = Mathf.Lerp(0, 1, var_244_20)
				arg_241_1.mask_.color = var_244_21
			end

			if arg_241_1.time_ >= var_244_18 + var_244_19 and arg_241_1.time_ < var_244_18 + var_244_19 + arg_244_0 then
				local var_244_22 = Color.New(0, 0, 0)

				var_244_22.a = 1
				arg_241_1.mask_.color = var_244_22
			end

			local var_244_23 = 2

			if var_244_23 < arg_241_1.time_ and arg_241_1.time_ <= var_244_23 + arg_244_0 then
				arg_241_1.mask_.enabled = true
				arg_241_1.mask_.raycastTarget = true

				arg_241_1:SetGaussion(false)
			end

			local var_244_24 = 2

			if var_244_23 <= arg_241_1.time_ and arg_241_1.time_ < var_244_23 + var_244_24 then
				local var_244_25 = (arg_241_1.time_ - var_244_23) / var_244_24
				local var_244_26 = Color.New(0, 0, 0)

				var_244_26.a = Mathf.Lerp(1, 0, var_244_25)
				arg_241_1.mask_.color = var_244_26
			end

			if arg_241_1.time_ >= var_244_23 + var_244_24 and arg_241_1.time_ < var_244_23 + var_244_24 + arg_244_0 then
				local var_244_27 = Color.New(0, 0, 0)
				local var_244_28 = 0

				arg_241_1.mask_.enabled = false
				var_244_27.a = var_244_28
				arg_241_1.mask_.color = var_244_27
			end

			local var_244_29 = 0.125
			local var_244_30 = 1

			if var_244_29 < arg_241_1.time_ and arg_241_1.time_ <= var_244_29 + arg_244_0 then
				local var_244_31 = "stop"
				local var_244_32 = "effect"

				arg_241_1:AudioAction(var_244_31, var_244_32, "se_story_140", "se_story_140_amb_lab", "")
			end

			local var_244_33 = 1.6
			local var_244_34 = 1

			if var_244_33 < arg_241_1.time_ and arg_241_1.time_ <= var_244_33 + arg_244_0 then
				local var_244_35 = "play"
				local var_244_36 = "effect"

				arg_241_1:AudioAction(var_244_35, var_244_36, "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			local var_244_37 = 4
			local var_244_38 = 1

			if var_244_37 < arg_241_1.time_ and arg_241_1.time_ <= var_244_37 + arg_244_0 then
				local var_244_39 = "play"
				local var_244_40 = "effect"

				arg_241_1:AudioAction(var_244_39, var_244_40, "se_story_side_1075", "se_story_side_1075_door", "")
			end

			if arg_241_1.frameCnt_ <= 1 then
				arg_241_1.dialog_:SetActive(false)
			end

			local var_244_41 = 4
			local var_244_42 = 0.7

			if var_244_41 < arg_241_1.time_ and arg_241_1.time_ <= var_244_41 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0

				arg_241_1.dialog_:SetActive(true)

				arg_241_1.dialogCg_.alpha = 0

				local var_244_43 = LeanTween.value(arg_241_1.dialog_, 0, 1, 0.3)

				var_244_43:setOnUpdate(LuaHelper.FloatAction(function(arg_245_0)
					arg_241_1.dialogCg_.alpha = arg_245_0
				end))
				var_244_43:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_241_1.dialog_)
					var_244_43:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_241_1.duration_ = arg_241_1.duration_ + 0.3

				SetActive(arg_241_1.leftNameGo_, false)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_44 = arg_241_1:GetWordFromCfg(924011058)
				local var_244_45 = arg_241_1:FormatText(var_244_44.content)

				arg_241_1.text_.text = var_244_45

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_46 = 28
				local var_244_47 = utf8.len(var_244_45)
				local var_244_48 = var_244_46 <= 0 and var_244_42 or var_244_42 * (var_244_47 / var_244_46)

				if var_244_48 > 0 and var_244_42 < var_244_48 then
					arg_241_1.talkMaxDuration = var_244_48
					var_244_41 = var_244_41 + 0.3

					if var_244_48 + var_244_41 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_48 + var_244_41
					end
				end

				arg_241_1.text_.text = var_244_45
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_49 = var_244_41 + 0.3
			local var_244_50 = math.max(var_244_42, arg_241_1.talkMaxDuration)

			if var_244_49 <= arg_241_1.time_ and arg_241_1.time_ < var_244_49 + var_244_50 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_49) / var_244_50

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_49 + var_244_50 and arg_241_1.time_ < var_244_49 + var_244_50 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play924011059 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 924011059
		arg_247_1.duration_ = 1.47

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play924011060(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = manager.ui.mainCamera.transform
			local var_250_1 = 0

			if var_250_1 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 then
				arg_247_1.var_.shakeOldPos = var_250_0.localPosition
			end

			local var_250_2 = 0.6

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_2 then
				local var_250_3 = (arg_247_1.time_ - var_250_1) / 0.066
				local var_250_4, var_250_5 = math.modf(var_250_3)

				var_250_0.localPosition = Vector3.New(var_250_5 * 0.13, var_250_5 * 0.13, var_250_5 * 0.13) + arg_247_1.var_.shakeOldPos
			end

			if arg_247_1.time_ >= var_250_1 + var_250_2 and arg_247_1.time_ < var_250_1 + var_250_2 + arg_250_0 then
				var_250_0.localPosition = arg_247_1.var_.shakeOldPos
			end

			local var_250_6 = 0

			if var_250_6 < arg_247_1.time_ and arg_247_1.time_ <= var_250_6 + arg_250_0 then
				arg_247_1.allBtn_.enabled = false
			end

			local var_250_7 = 0.6

			if arg_247_1.time_ >= var_250_6 + var_250_7 and arg_247_1.time_ < var_250_6 + var_250_7 + arg_250_0 then
				arg_247_1.allBtn_.enabled = true
			end

			local var_250_8 = 0
			local var_250_9 = 0.2

			if var_250_8 < arg_247_1.time_ and arg_247_1.time_ <= var_250_8 + arg_250_0 then
				local var_250_10 = "play"
				local var_250_11 = "music"

				arg_247_1:AudioAction(var_250_10, var_250_11, "ui_battle", "ui_battle_stopbgm", "")

				local var_250_12 = ""
				local var_250_13 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_250_13 ~= "" then
					if arg_247_1.bgmTxt_.text ~= var_250_13 and arg_247_1.bgmTxt_.text ~= "" then
						if arg_247_1.bgmTxt2_.text ~= "" then
							arg_247_1.bgmTxt_.text = arg_247_1.bgmTxt2_.text
						end

						arg_247_1.bgmTxt2_.text = var_250_13

						arg_247_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_247_1.bgmTxt_.text = var_250_13
						arg_247_1.bgmTxt2_.text = var_250_13
					end

					if arg_247_1.bgmTimer then
						arg_247_1.bgmTimer:Stop()

						arg_247_1.bgmTimer = nil
					end

					if arg_247_1.settingData.show_music_name == 1 then
						arg_247_1.musicController:SetSelectedState("show")
						arg_247_1.musicAnimator_:Play("open", 0, 0)

						if arg_247_1.settingData.music_time ~= 0 then
							arg_247_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_247_1.settingData.music_time), function()
								if arg_247_1 == nil or isNil(arg_247_1.bgmTxt_) then
									return
								end

								arg_247_1.musicController:SetSelectedState("hide")
								arg_247_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_250_14 = 0.4
			local var_250_15 = 1

			if var_250_14 < arg_247_1.time_ and arg_247_1.time_ <= var_250_14 + arg_250_0 then
				local var_250_16 = "play"
				local var_250_17 = "music"

				arg_247_1:AudioAction(var_250_16, var_250_17, "bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet.awb")

				local var_250_18 = ""
				local var_250_19 = manager.audio:GetAudioName("bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet")

				if var_250_19 ~= "" then
					if arg_247_1.bgmTxt_.text ~= var_250_19 and arg_247_1.bgmTxt_.text ~= "" then
						if arg_247_1.bgmTxt2_.text ~= "" then
							arg_247_1.bgmTxt_.text = arg_247_1.bgmTxt2_.text
						end

						arg_247_1.bgmTxt2_.text = var_250_19

						arg_247_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_247_1.bgmTxt_.text = var_250_19
						arg_247_1.bgmTxt2_.text = var_250_19
					end

					if arg_247_1.bgmTimer then
						arg_247_1.bgmTimer:Stop()

						arg_247_1.bgmTimer = nil
					end

					if arg_247_1.settingData.show_music_name == 1 then
						arg_247_1.musicController:SetSelectedState("show")
						arg_247_1.musicAnimator_:Play("open", 0, 0)

						if arg_247_1.settingData.music_time ~= 0 then
							arg_247_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_247_1.settingData.music_time), function()
								if arg_247_1 == nil or isNil(arg_247_1.bgmTxt_) then
									return
								end

								arg_247_1.musicController:SetSelectedState("hide")
								arg_247_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_250_20 = 0
			local var_250_21 = 0.075

			if var_250_20 < arg_247_1.time_ and arg_247_1.time_ <= var_250_20 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_22 = arg_247_1:FormatText(StoryNameCfg[36].name)

				arg_247_1.leftNameTxt_.text = var_250_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_23 = arg_247_1:GetWordFromCfg(924011059)
				local var_250_24 = arg_247_1:FormatText(var_250_23.content)

				arg_247_1.text_.text = var_250_24

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_25 = 3
				local var_250_26 = utf8.len(var_250_24)
				local var_250_27 = var_250_25 <= 0 and var_250_21 or var_250_21 * (var_250_26 / var_250_25)

				if var_250_27 > 0 and var_250_21 < var_250_27 then
					arg_247_1.talkMaxDuration = var_250_27

					if var_250_27 + var_250_20 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_27 + var_250_20
					end
				end

				arg_247_1.text_.text = var_250_24
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011059", "story_v_side_old_924011.awb") ~= 0 then
					local var_250_28 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011059", "story_v_side_old_924011.awb") / 1000

					if var_250_28 + var_250_20 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_28 + var_250_20
					end

					if var_250_23.prefab_name ~= "" and arg_247_1.actors_[var_250_23.prefab_name] ~= nil then
						local var_250_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_23.prefab_name].transform, "story_v_side_old_924011", "924011059", "story_v_side_old_924011.awb")

						arg_247_1:RecordAudio("924011059", var_250_29)
						arg_247_1:RecordAudio("924011059", var_250_29)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011059", "story_v_side_old_924011.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011059", "story_v_side_old_924011.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_30 = math.max(var_250_21, arg_247_1.talkMaxDuration)

			if var_250_20 <= arg_247_1.time_ and arg_247_1.time_ < var_250_20 + var_250_30 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_20) / var_250_30

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_20 + var_250_30 and arg_247_1.time_ < var_250_20 + var_250_30 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play924011060 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 924011060
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play924011061(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 0
			local var_256_1 = 0.075

			if var_256_0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_2 = arg_253_1:FormatText(StoryNameCfg[7].name)

				arg_253_1.leftNameTxt_.text = var_256_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, true)
				arg_253_1.iconController_:SetSelectedState("hero")

				arg_253_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_253_1.callingController_:SetSelectedState("normal")

				arg_253_1.keyicon_.color = Color.New(1, 1, 1)
				arg_253_1.icon_.color = Color.New(1, 1, 1)

				local var_256_3 = arg_253_1:GetWordFromCfg(924011060)
				local var_256_4 = arg_253_1:FormatText(var_256_3.content)

				arg_253_1.text_.text = var_256_4

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_5 = 3
				local var_256_6 = utf8.len(var_256_4)
				local var_256_7 = var_256_5 <= 0 and var_256_1 or var_256_1 * (var_256_6 / var_256_5)

				if var_256_7 > 0 and var_256_1 < var_256_7 then
					arg_253_1.talkMaxDuration = var_256_7

					if var_256_7 + var_256_0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_7 + var_256_0
					end
				end

				arg_253_1.text_.text = var_256_4
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_8 = math.max(var_256_1, arg_253_1.talkMaxDuration)

			if var_256_0 <= arg_253_1.time_ and arg_253_1.time_ < var_256_0 + var_256_8 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_0) / var_256_8

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_0 + var_256_8 and arg_253_1.time_ < var_256_0 + var_256_8 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play924011061 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 924011061
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play924011062(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0.2
			local var_260_1 = 1

			if var_260_0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_0 + arg_260_0 then
				local var_260_2 = "play"
				local var_260_3 = "effect"

				arg_257_1:AudioAction(var_260_2, var_260_3, "se_story_141", "se_story_141_foley_hug", "")
			end

			local var_260_4 = 0
			local var_260_5 = 1

			if var_260_4 < arg_257_1.time_ and arg_257_1.time_ <= var_260_4 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, false)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_6 = arg_257_1:GetWordFromCfg(924011061)
				local var_260_7 = arg_257_1:FormatText(var_260_6.content)

				arg_257_1.text_.text = var_260_7

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_8 = 40
				local var_260_9 = utf8.len(var_260_7)
				local var_260_10 = var_260_8 <= 0 and var_260_5 or var_260_5 * (var_260_9 / var_260_8)

				if var_260_10 > 0 and var_260_5 < var_260_10 then
					arg_257_1.talkMaxDuration = var_260_10

					if var_260_10 + var_260_4 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_10 + var_260_4
					end
				end

				arg_257_1.text_.text = var_260_7
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_11 = math.max(var_260_5, arg_257_1.talkMaxDuration)

			if var_260_4 <= arg_257_1.time_ and arg_257_1.time_ < var_260_4 + var_260_11 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_4) / var_260_11

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_4 + var_260_11 and arg_257_1.time_ < var_260_4 + var_260_11 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play924011062 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 924011062
		arg_261_1.duration_ = 6

		local var_261_0 = {
			zh = 4.8,
			ja = 6
		}
		local var_261_1 = manager.audio:GetLocalizationFlag()

		if var_261_0[var_261_1] ~= nil then
			arg_261_1.duration_ = var_261_0[var_261_1]
		end

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play924011063(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = "1020ui_story"

			if arg_261_1.actors_[var_264_0] == nil then
				local var_264_1 = Asset.Load("Char/" .. "1020ui_story")

				if not isNil(var_264_1) then
					local var_264_2 = Object.Instantiate(Asset.Load("Char/" .. "1020ui_story"), arg_261_1.stage_.transform)

					var_264_2.name = var_264_0
					var_264_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_261_1.actors_[var_264_0] = var_264_2

					local var_264_3 = var_264_2:GetComponentInChildren(typeof(CharacterEffect))

					var_264_3.enabled = true

					local var_264_4 = GameObjectTools.GetOrAddComponent(var_264_2, typeof(DynamicBoneHelper))

					if var_264_4 then
						var_264_4:EnableDynamicBone(false)
					end

					arg_261_1:ShowWeapon(var_264_3.transform, false)

					arg_261_1.var_[var_264_0 .. "Animator"] = var_264_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_261_1.var_[var_264_0 .. "Animator"].applyRootMotion = true
					arg_261_1.var_[var_264_0 .. "LipSync"] = var_264_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_264_5 = arg_261_1.actors_["1020ui_story"].transform
			local var_264_6 = 0

			if var_264_6 < arg_261_1.time_ and arg_261_1.time_ <= var_264_6 + arg_264_0 then
				arg_261_1.var_.moveOldPos1020ui_story = var_264_5.localPosition
			end

			local var_264_7 = 0.001

			if var_264_6 <= arg_261_1.time_ and arg_261_1.time_ < var_264_6 + var_264_7 then
				local var_264_8 = (arg_261_1.time_ - var_264_6) / var_264_7
				local var_264_9 = Vector3.New(0, -0.85, -6.25)

				var_264_5.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1020ui_story, var_264_9, var_264_8)

				local var_264_10 = manager.ui.mainCamera.transform.position - var_264_5.position

				var_264_5.forward = Vector3.New(var_264_10.x, var_264_10.y, var_264_10.z)

				local var_264_11 = var_264_5.localEulerAngles

				var_264_11.z = 0
				var_264_11.x = 0
				var_264_5.localEulerAngles = var_264_11
			end

			if arg_261_1.time_ >= var_264_6 + var_264_7 and arg_261_1.time_ < var_264_6 + var_264_7 + arg_264_0 then
				var_264_5.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_264_12 = manager.ui.mainCamera.transform.position - var_264_5.position

				var_264_5.forward = Vector3.New(var_264_12.x, var_264_12.y, var_264_12.z)

				local var_264_13 = var_264_5.localEulerAngles

				var_264_13.z = 0
				var_264_13.x = 0
				var_264_5.localEulerAngles = var_264_13
			end

			local var_264_14 = arg_261_1.actors_["1020ui_story"]
			local var_264_15 = 0

			if var_264_15 < arg_261_1.time_ and arg_261_1.time_ <= var_264_15 + arg_264_0 and not isNil(var_264_14) and arg_261_1.var_.characterEffect1020ui_story == nil then
				arg_261_1.var_.characterEffect1020ui_story = var_264_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_16 = 0.200000002980232

			if var_264_15 <= arg_261_1.time_ and arg_261_1.time_ < var_264_15 + var_264_16 and not isNil(var_264_14) then
				local var_264_17 = (arg_261_1.time_ - var_264_15) / var_264_16

				if arg_261_1.var_.characterEffect1020ui_story and not isNil(var_264_14) then
					arg_261_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_261_1.time_ >= var_264_15 + var_264_16 and arg_261_1.time_ < var_264_15 + var_264_16 + arg_264_0 and not isNil(var_264_14) and arg_261_1.var_.characterEffect1020ui_story then
				arg_261_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_264_18 = 0

			if var_264_18 < arg_261_1.time_ and arg_261_1.time_ <= var_264_18 + arg_264_0 then
				arg_261_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action3_1")
			end

			local var_264_19 = 0

			if var_264_19 < arg_261_1.time_ and arg_261_1.time_ <= var_264_19 + arg_264_0 then
				arg_261_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_264_20 = 0
			local var_264_21 = 0.45

			if var_264_20 < arg_261_1.time_ and arg_261_1.time_ <= var_264_20 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_22 = arg_261_1:FormatText(StoryNameCfg[613].name)

				arg_261_1.leftNameTxt_.text = var_264_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_23 = arg_261_1:GetWordFromCfg(924011062)
				local var_264_24 = arg_261_1:FormatText(var_264_23.content)

				arg_261_1.text_.text = var_264_24

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_25 = 18
				local var_264_26 = utf8.len(var_264_24)
				local var_264_27 = var_264_25 <= 0 and var_264_21 or var_264_21 * (var_264_26 / var_264_25)

				if var_264_27 > 0 and var_264_21 < var_264_27 then
					arg_261_1.talkMaxDuration = var_264_27

					if var_264_27 + var_264_20 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_27 + var_264_20
					end
				end

				arg_261_1.text_.text = var_264_24
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011062", "story_v_side_old_924011.awb") ~= 0 then
					local var_264_28 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011062", "story_v_side_old_924011.awb") / 1000

					if var_264_28 + var_264_20 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_28 + var_264_20
					end

					if var_264_23.prefab_name ~= "" and arg_261_1.actors_[var_264_23.prefab_name] ~= nil then
						local var_264_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_23.prefab_name].transform, "story_v_side_old_924011", "924011062", "story_v_side_old_924011.awb")

						arg_261_1:RecordAudio("924011062", var_264_29)
						arg_261_1:RecordAudio("924011062", var_264_29)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011062", "story_v_side_old_924011.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011062", "story_v_side_old_924011.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_30 = math.max(var_264_21, arg_261_1.talkMaxDuration)

			if var_264_20 <= arg_261_1.time_ and arg_261_1.time_ < var_264_20 + var_264_30 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_20) / var_264_30

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_20 + var_264_30 and arg_261_1.time_ < var_264_20 + var_264_30 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_261_1:InitPlayNodeList()
	end,
	Play924011063 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 924011063
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play924011064(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = arg_265_1.actors_["1020ui_story"]
			local var_268_1 = 0

			if var_268_1 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 and not isNil(var_268_0) and arg_265_1.var_.characterEffect1020ui_story == nil then
				arg_265_1.var_.characterEffect1020ui_story = var_268_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_2 = 0.200000002980232

			if var_268_1 <= arg_265_1.time_ and arg_265_1.time_ < var_268_1 + var_268_2 and not isNil(var_268_0) then
				local var_268_3 = (arg_265_1.time_ - var_268_1) / var_268_2

				if arg_265_1.var_.characterEffect1020ui_story and not isNil(var_268_0) then
					local var_268_4 = Mathf.Lerp(0, 0.5, var_268_3)

					arg_265_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_265_1.var_.characterEffect1020ui_story.fillRatio = var_268_4
				end
			end

			if arg_265_1.time_ >= var_268_1 + var_268_2 and arg_265_1.time_ < var_268_1 + var_268_2 + arg_268_0 and not isNil(var_268_0) and arg_265_1.var_.characterEffect1020ui_story then
				local var_268_5 = 0.5

				arg_265_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_265_1.var_.characterEffect1020ui_story.fillRatio = var_268_5
			end

			local var_268_6 = 0
			local var_268_7 = 0.2

			if var_268_6 < arg_265_1.time_ and arg_265_1.time_ <= var_268_6 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_8 = arg_265_1:FormatText(StoryNameCfg[7].name)

				arg_265_1.leftNameTxt_.text = var_268_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, true)
				arg_265_1.iconController_:SetSelectedState("hero")

				arg_265_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_265_1.callingController_:SetSelectedState("normal")

				arg_265_1.keyicon_.color = Color.New(1, 1, 1)
				arg_265_1.icon_.color = Color.New(1, 1, 1)

				local var_268_9 = arg_265_1:GetWordFromCfg(924011063)
				local var_268_10 = arg_265_1:FormatText(var_268_9.content)

				arg_265_1.text_.text = var_268_10

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_11 = 8
				local var_268_12 = utf8.len(var_268_10)
				local var_268_13 = var_268_11 <= 0 and var_268_7 or var_268_7 * (var_268_12 / var_268_11)

				if var_268_13 > 0 and var_268_7 < var_268_13 then
					arg_265_1.talkMaxDuration = var_268_13

					if var_268_13 + var_268_6 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_13 + var_268_6
					end
				end

				arg_265_1.text_.text = var_268_10
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_14 = math.max(var_268_7, arg_265_1.talkMaxDuration)

			if var_268_6 <= arg_265_1.time_ and arg_265_1.time_ < var_268_6 + var_268_14 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_6) / var_268_14

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_6 + var_268_14 and arg_265_1.time_ < var_268_6 + var_268_14 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play924011064 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 924011064
		arg_269_1.duration_ = 2

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play924011065(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = arg_269_1.actors_["1020ui_story"]
			local var_272_1 = 0

			if var_272_1 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 and not isNil(var_272_0) and arg_269_1.var_.characterEffect1020ui_story == nil then
				arg_269_1.var_.characterEffect1020ui_story = var_272_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_2 = 0.200000002980232

			if var_272_1 <= arg_269_1.time_ and arg_269_1.time_ < var_272_1 + var_272_2 and not isNil(var_272_0) then
				local var_272_3 = (arg_269_1.time_ - var_272_1) / var_272_2

				if arg_269_1.var_.characterEffect1020ui_story and not isNil(var_272_0) then
					arg_269_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= var_272_1 + var_272_2 and arg_269_1.time_ < var_272_1 + var_272_2 + arg_272_0 and not isNil(var_272_0) and arg_269_1.var_.characterEffect1020ui_story then
				arg_269_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_272_4 = 0

			if var_272_4 < arg_269_1.time_ and arg_269_1.time_ <= var_272_4 + arg_272_0 then
				arg_269_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action3_2")
			end

			local var_272_5 = 0
			local var_272_6 = 0.1

			if var_272_5 < arg_269_1.time_ and arg_269_1.time_ <= var_272_5 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_7 = arg_269_1:FormatText(StoryNameCfg[613].name)

				arg_269_1.leftNameTxt_.text = var_272_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_8 = arg_269_1:GetWordFromCfg(924011064)
				local var_272_9 = arg_269_1:FormatText(var_272_8.content)

				arg_269_1.text_.text = var_272_9

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_10 = 4
				local var_272_11 = utf8.len(var_272_9)
				local var_272_12 = var_272_10 <= 0 and var_272_6 or var_272_6 * (var_272_11 / var_272_10)

				if var_272_12 > 0 and var_272_6 < var_272_12 then
					arg_269_1.talkMaxDuration = var_272_12

					if var_272_12 + var_272_5 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_12 + var_272_5
					end
				end

				arg_269_1.text_.text = var_272_9
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011064", "story_v_side_old_924011.awb") ~= 0 then
					local var_272_13 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011064", "story_v_side_old_924011.awb") / 1000

					if var_272_13 + var_272_5 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_13 + var_272_5
					end

					if var_272_8.prefab_name ~= "" and arg_269_1.actors_[var_272_8.prefab_name] ~= nil then
						local var_272_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_8.prefab_name].transform, "story_v_side_old_924011", "924011064", "story_v_side_old_924011.awb")

						arg_269_1:RecordAudio("924011064", var_272_14)
						arg_269_1:RecordAudio("924011064", var_272_14)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011064", "story_v_side_old_924011.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011064", "story_v_side_old_924011.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_15 = math.max(var_272_6, arg_269_1.talkMaxDuration)

			if var_272_5 <= arg_269_1.time_ and arg_269_1.time_ < var_272_5 + var_272_15 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_5) / var_272_15

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_5 + var_272_15 and arg_269_1.time_ < var_272_5 + var_272_15 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play924011065 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 924011065
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play924011066(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = arg_273_1.actors_["1020ui_story"].transform
			local var_276_1 = 0

			if var_276_1 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 then
				arg_273_1.var_.moveOldPos1020ui_story = var_276_0.localPosition
			end

			local var_276_2 = 0.001

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_2 then
				local var_276_3 = (arg_273_1.time_ - var_276_1) / var_276_2
				local var_276_4 = Vector3.New(0, 100, 0)

				var_276_0.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1020ui_story, var_276_4, var_276_3)

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
			local var_276_10 = 1.4

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

				local var_276_11 = arg_273_1:GetWordFromCfg(924011065)
				local var_276_12 = arg_273_1:FormatText(var_276_11.content)

				arg_273_1.text_.text = var_276_12

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_13 = 56
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
				actorName = "1020ui_story",
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
	Play924011066 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 924011066
		arg_277_1.duration_ = 6.3

		local var_277_0 = {
			zh = 4.333,
			ja = 6.3
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
				arg_277_0:Play924011067(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = arg_277_1.actors_["1020ui_story"].transform
			local var_280_1 = 0

			if var_280_1 < arg_277_1.time_ and arg_277_1.time_ <= var_280_1 + arg_280_0 then
				arg_277_1.var_.moveOldPos1020ui_story = var_280_0.localPosition
			end

			local var_280_2 = 0.001

			if var_280_1 <= arg_277_1.time_ and arg_277_1.time_ < var_280_1 + var_280_2 then
				local var_280_3 = (arg_277_1.time_ - var_280_1) / var_280_2
				local var_280_4 = Vector3.New(0, -0.85, -6.25)

				var_280_0.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos1020ui_story, var_280_4, var_280_3)

				local var_280_5 = manager.ui.mainCamera.transform.position - var_280_0.position

				var_280_0.forward = Vector3.New(var_280_5.x, var_280_5.y, var_280_5.z)

				local var_280_6 = var_280_0.localEulerAngles

				var_280_6.z = 0
				var_280_6.x = 0
				var_280_0.localEulerAngles = var_280_6
			end

			if arg_277_1.time_ >= var_280_1 + var_280_2 and arg_277_1.time_ < var_280_1 + var_280_2 + arg_280_0 then
				var_280_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_280_7 = manager.ui.mainCamera.transform.position - var_280_0.position

				var_280_0.forward = Vector3.New(var_280_7.x, var_280_7.y, var_280_7.z)

				local var_280_8 = var_280_0.localEulerAngles

				var_280_8.z = 0
				var_280_8.x = 0
				var_280_0.localEulerAngles = var_280_8
			end

			local var_280_9 = arg_277_1.actors_["1020ui_story"]
			local var_280_10 = 0

			if var_280_10 < arg_277_1.time_ and arg_277_1.time_ <= var_280_10 + arg_280_0 and not isNil(var_280_9) and arg_277_1.var_.characterEffect1020ui_story == nil then
				arg_277_1.var_.characterEffect1020ui_story = var_280_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_11 = 0.200000002980232

			if var_280_10 <= arg_277_1.time_ and arg_277_1.time_ < var_280_10 + var_280_11 and not isNil(var_280_9) then
				local var_280_12 = (arg_277_1.time_ - var_280_10) / var_280_11

				if arg_277_1.var_.characterEffect1020ui_story and not isNil(var_280_9) then
					arg_277_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_277_1.time_ >= var_280_10 + var_280_11 and arg_277_1.time_ < var_280_10 + var_280_11 + arg_280_0 and not isNil(var_280_9) and arg_277_1.var_.characterEffect1020ui_story then
				arg_277_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_280_13 = 0

			if var_280_13 < arg_277_1.time_ and arg_277_1.time_ <= var_280_13 + arg_280_0 then
				arg_277_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_280_14 = 0

			if var_280_14 < arg_277_1.time_ and arg_277_1.time_ <= var_280_14 + arg_280_0 then
				arg_277_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action8_1")
			end

			local var_280_15 = 0
			local var_280_16 = 0.5

			if var_280_15 < arg_277_1.time_ and arg_277_1.time_ <= var_280_15 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_17 = arg_277_1:FormatText(StoryNameCfg[613].name)

				arg_277_1.leftNameTxt_.text = var_280_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_18 = arg_277_1:GetWordFromCfg(924011066)
				local var_280_19 = arg_277_1:FormatText(var_280_18.content)

				arg_277_1.text_.text = var_280_19

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_20 = 20
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

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011066", "story_v_side_old_924011.awb") ~= 0 then
					local var_280_23 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011066", "story_v_side_old_924011.awb") / 1000

					if var_280_23 + var_280_15 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_23 + var_280_15
					end

					if var_280_18.prefab_name ~= "" and arg_277_1.actors_[var_280_18.prefab_name] ~= nil then
						local var_280_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_18.prefab_name].transform, "story_v_side_old_924011", "924011066", "story_v_side_old_924011.awb")

						arg_277_1:RecordAudio("924011066", var_280_24)
						arg_277_1:RecordAudio("924011066", var_280_24)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011066", "story_v_side_old_924011.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011066", "story_v_side_old_924011.awb")
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
				actorName = "1020ui_story",
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
	Play924011067 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 924011067
		arg_281_1.duration_ = 5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play924011068(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = arg_281_1.actors_["1020ui_story"]
			local var_284_1 = 0

			if var_284_1 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 and not isNil(var_284_0) and arg_281_1.var_.characterEffect1020ui_story == nil then
				arg_281_1.var_.characterEffect1020ui_story = var_284_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_2 = 0.200000002980232

			if var_284_1 <= arg_281_1.time_ and arg_281_1.time_ < var_284_1 + var_284_2 and not isNil(var_284_0) then
				local var_284_3 = (arg_281_1.time_ - var_284_1) / var_284_2

				if arg_281_1.var_.characterEffect1020ui_story and not isNil(var_284_0) then
					local var_284_4 = Mathf.Lerp(0, 0.5, var_284_3)

					arg_281_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_281_1.var_.characterEffect1020ui_story.fillRatio = var_284_4
				end
			end

			if arg_281_1.time_ >= var_284_1 + var_284_2 and arg_281_1.time_ < var_284_1 + var_284_2 + arg_284_0 and not isNil(var_284_0) and arg_281_1.var_.characterEffect1020ui_story then
				local var_284_5 = 0.5

				arg_281_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_281_1.var_.characterEffect1020ui_story.fillRatio = var_284_5
			end

			local var_284_6 = 0
			local var_284_7 = 0.4

			if var_284_6 < arg_281_1.time_ and arg_281_1.time_ <= var_284_6 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_8 = arg_281_1:FormatText(StoryNameCfg[7].name)

				arg_281_1.leftNameTxt_.text = var_284_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, true)
				arg_281_1.iconController_:SetSelectedState("hero")

				arg_281_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_281_1.callingController_:SetSelectedState("normal")

				arg_281_1.keyicon_.color = Color.New(1, 1, 1)
				arg_281_1.icon_.color = Color.New(1, 1, 1)

				local var_284_9 = arg_281_1:GetWordFromCfg(924011067)
				local var_284_10 = arg_281_1:FormatText(var_284_9.content)

				arg_281_1.text_.text = var_284_10

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_11 = 16
				local var_284_12 = utf8.len(var_284_10)
				local var_284_13 = var_284_11 <= 0 and var_284_7 or var_284_7 * (var_284_12 / var_284_11)

				if var_284_13 > 0 and var_284_7 < var_284_13 then
					arg_281_1.talkMaxDuration = var_284_13

					if var_284_13 + var_284_6 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_13 + var_284_6
					end
				end

				arg_281_1.text_.text = var_284_10
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_14 = math.max(var_284_7, arg_281_1.talkMaxDuration)

			if var_284_6 <= arg_281_1.time_ and arg_281_1.time_ < var_284_6 + var_284_14 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_6) / var_284_14

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_6 + var_284_14 and arg_281_1.time_ < var_284_6 + var_284_14 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play924011068 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 924011068
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play924011069(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = 0
			local var_288_1 = 0.3

			if var_288_0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_0 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_2 = arg_285_1:FormatText(StoryNameCfg[7].name)

				arg_285_1.leftNameTxt_.text = var_288_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, true)
				arg_285_1.iconController_:SetSelectedState("hero")

				arg_285_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_285_1.callingController_:SetSelectedState("normal")

				arg_285_1.keyicon_.color = Color.New(1, 1, 1)
				arg_285_1.icon_.color = Color.New(1, 1, 1)

				local var_288_3 = arg_285_1:GetWordFromCfg(924011068)
				local var_288_4 = arg_285_1:FormatText(var_288_3.content)

				arg_285_1.text_.text = var_288_4

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_5 = 12
				local var_288_6 = utf8.len(var_288_4)
				local var_288_7 = var_288_5 <= 0 and var_288_1 or var_288_1 * (var_288_6 / var_288_5)

				if var_288_7 > 0 and var_288_1 < var_288_7 then
					arg_285_1.talkMaxDuration = var_288_7

					if var_288_7 + var_288_0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_7 + var_288_0
					end
				end

				arg_285_1.text_.text = var_288_4
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_8 = math.max(var_288_1, arg_285_1.talkMaxDuration)

			if var_288_0 <= arg_285_1.time_ and arg_285_1.time_ < var_288_0 + var_288_8 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_0) / var_288_8

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_0 + var_288_8 and arg_285_1.time_ < var_288_0 + var_288_8 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play924011069 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 924011069
		arg_289_1.duration_ = 6.53

		local var_289_0 = {
			zh = 3.066,
			ja = 6.533
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
				arg_289_0:Play924011070(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = arg_289_1.actors_["1020ui_story"].transform
			local var_292_1 = 0

			if var_292_1 < arg_289_1.time_ and arg_289_1.time_ <= var_292_1 + arg_292_0 then
				arg_289_1.var_.moveOldPos1020ui_story = var_292_0.localPosition
			end

			local var_292_2 = 0.001

			if var_292_1 <= arg_289_1.time_ and arg_289_1.time_ < var_292_1 + var_292_2 then
				local var_292_3 = (arg_289_1.time_ - var_292_1) / var_292_2
				local var_292_4 = Vector3.New(0, -0.85, -6.25)

				var_292_0.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos1020ui_story, var_292_4, var_292_3)

				local var_292_5 = manager.ui.mainCamera.transform.position - var_292_0.position

				var_292_0.forward = Vector3.New(var_292_5.x, var_292_5.y, var_292_5.z)

				local var_292_6 = var_292_0.localEulerAngles

				var_292_6.z = 0
				var_292_6.x = 0
				var_292_0.localEulerAngles = var_292_6
			end

			if arg_289_1.time_ >= var_292_1 + var_292_2 and arg_289_1.time_ < var_292_1 + var_292_2 + arg_292_0 then
				var_292_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_292_7 = manager.ui.mainCamera.transform.position - var_292_0.position

				var_292_0.forward = Vector3.New(var_292_7.x, var_292_7.y, var_292_7.z)

				local var_292_8 = var_292_0.localEulerAngles

				var_292_8.z = 0
				var_292_8.x = 0
				var_292_0.localEulerAngles = var_292_8
			end

			local var_292_9 = arg_289_1.actors_["1020ui_story"]
			local var_292_10 = 0

			if var_292_10 < arg_289_1.time_ and arg_289_1.time_ <= var_292_10 + arg_292_0 and not isNil(var_292_9) and arg_289_1.var_.characterEffect1020ui_story == nil then
				arg_289_1.var_.characterEffect1020ui_story = var_292_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_11 = 0.200000002980232

			if var_292_10 <= arg_289_1.time_ and arg_289_1.time_ < var_292_10 + var_292_11 and not isNil(var_292_9) then
				local var_292_12 = (arg_289_1.time_ - var_292_10) / var_292_11

				if arg_289_1.var_.characterEffect1020ui_story and not isNil(var_292_9) then
					arg_289_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_289_1.time_ >= var_292_10 + var_292_11 and arg_289_1.time_ < var_292_10 + var_292_11 + arg_292_0 and not isNil(var_292_9) and arg_289_1.var_.characterEffect1020ui_story then
				arg_289_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_292_13 = 0

			if var_292_13 < arg_289_1.time_ and arg_289_1.time_ <= var_292_13 + arg_292_0 then
				arg_289_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_292_14 = 0

			if var_292_14 < arg_289_1.time_ and arg_289_1.time_ <= var_292_14 + arg_292_0 then
				arg_289_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action8_2")
			end

			local var_292_15 = 0
			local var_292_16 = 0.35

			if var_292_15 < arg_289_1.time_ and arg_289_1.time_ <= var_292_15 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				local var_292_17 = arg_289_1:FormatText(StoryNameCfg[613].name)

				arg_289_1.leftNameTxt_.text = var_292_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_18 = arg_289_1:GetWordFromCfg(924011069)
				local var_292_19 = arg_289_1:FormatText(var_292_18.content)

				arg_289_1.text_.text = var_292_19

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_20 = 14
				local var_292_21 = utf8.len(var_292_19)
				local var_292_22 = var_292_20 <= 0 and var_292_16 or var_292_16 * (var_292_21 / var_292_20)

				if var_292_22 > 0 and var_292_16 < var_292_22 then
					arg_289_1.talkMaxDuration = var_292_22

					if var_292_22 + var_292_15 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_22 + var_292_15
					end
				end

				arg_289_1.text_.text = var_292_19
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011069", "story_v_side_old_924011.awb") ~= 0 then
					local var_292_23 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011069", "story_v_side_old_924011.awb") / 1000

					if var_292_23 + var_292_15 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_23 + var_292_15
					end

					if var_292_18.prefab_name ~= "" and arg_289_1.actors_[var_292_18.prefab_name] ~= nil then
						local var_292_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_18.prefab_name].transform, "story_v_side_old_924011", "924011069", "story_v_side_old_924011.awb")

						arg_289_1:RecordAudio("924011069", var_292_24)
						arg_289_1:RecordAudio("924011069", var_292_24)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011069", "story_v_side_old_924011.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011069", "story_v_side_old_924011.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_25 = math.max(var_292_16, arg_289_1.talkMaxDuration)

			if var_292_15 <= arg_289_1.time_ and arg_289_1.time_ < var_292_15 + var_292_25 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_15) / var_292_25

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_15 + var_292_25 and arg_289_1.time_ < var_292_15 + var_292_25 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
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
	Play924011070 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 924011070
		arg_293_1.duration_ = 5

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play924011071(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = arg_293_1.actors_["1020ui_story"]
			local var_296_1 = 0

			if var_296_1 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 and not isNil(var_296_0) and arg_293_1.var_.characterEffect1020ui_story == nil then
				arg_293_1.var_.characterEffect1020ui_story = var_296_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_2 = 0.200000002980232

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_2 and not isNil(var_296_0) then
				local var_296_3 = (arg_293_1.time_ - var_296_1) / var_296_2

				if arg_293_1.var_.characterEffect1020ui_story and not isNil(var_296_0) then
					local var_296_4 = Mathf.Lerp(0, 0.5, var_296_3)

					arg_293_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_293_1.var_.characterEffect1020ui_story.fillRatio = var_296_4
				end
			end

			if arg_293_1.time_ >= var_296_1 + var_296_2 and arg_293_1.time_ < var_296_1 + var_296_2 + arg_296_0 and not isNil(var_296_0) and arg_293_1.var_.characterEffect1020ui_story then
				local var_296_5 = 0.5

				arg_293_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_293_1.var_.characterEffect1020ui_story.fillRatio = var_296_5
			end

			local var_296_6 = 0
			local var_296_7 = 0.775

			if var_296_6 < arg_293_1.time_ and arg_293_1.time_ <= var_296_6 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				local var_296_8 = arg_293_1:FormatText(StoryNameCfg[7].name)

				arg_293_1.leftNameTxt_.text = var_296_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, true)
				arg_293_1.iconController_:SetSelectedState("hero")

				arg_293_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_293_1.callingController_:SetSelectedState("normal")

				arg_293_1.keyicon_.color = Color.New(1, 1, 1)
				arg_293_1.icon_.color = Color.New(1, 1, 1)

				local var_296_9 = arg_293_1:GetWordFromCfg(924011070)
				local var_296_10 = arg_293_1:FormatText(var_296_9.content)

				arg_293_1.text_.text = var_296_10

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_11 = 31
				local var_296_12 = utf8.len(var_296_10)
				local var_296_13 = var_296_11 <= 0 and var_296_7 or var_296_7 * (var_296_12 / var_296_11)

				if var_296_13 > 0 and var_296_7 < var_296_13 then
					arg_293_1.talkMaxDuration = var_296_13

					if var_296_13 + var_296_6 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_13 + var_296_6
					end
				end

				arg_293_1.text_.text = var_296_10
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)
				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_14 = math.max(var_296_7, arg_293_1.talkMaxDuration)

			if var_296_6 <= arg_293_1.time_ and arg_293_1.time_ < var_296_6 + var_296_14 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_6) / var_296_14

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_6 + var_296_14 and arg_293_1.time_ < var_296_6 + var_296_14 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play924011071 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 924011071
		arg_297_1.duration_ = 6.47

		local var_297_0 = {
			zh = 4.8,
			ja = 6.466
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
				arg_297_0:Play924011072(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = arg_297_1.actors_["1020ui_story"].transform
			local var_300_1 = 0

			if var_300_1 < arg_297_1.time_ and arg_297_1.time_ <= var_300_1 + arg_300_0 then
				arg_297_1.var_.moveOldPos1020ui_story = var_300_0.localPosition
			end

			local var_300_2 = 0.001

			if var_300_1 <= arg_297_1.time_ and arg_297_1.time_ < var_300_1 + var_300_2 then
				local var_300_3 = (arg_297_1.time_ - var_300_1) / var_300_2
				local var_300_4 = Vector3.New(0, -0.85, -6.25)

				var_300_0.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos1020ui_story, var_300_4, var_300_3)

				local var_300_5 = manager.ui.mainCamera.transform.position - var_300_0.position

				var_300_0.forward = Vector3.New(var_300_5.x, var_300_5.y, var_300_5.z)

				local var_300_6 = var_300_0.localEulerAngles

				var_300_6.z = 0
				var_300_6.x = 0
				var_300_0.localEulerAngles = var_300_6
			end

			if arg_297_1.time_ >= var_300_1 + var_300_2 and arg_297_1.time_ < var_300_1 + var_300_2 + arg_300_0 then
				var_300_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_300_7 = manager.ui.mainCamera.transform.position - var_300_0.position

				var_300_0.forward = Vector3.New(var_300_7.x, var_300_7.y, var_300_7.z)

				local var_300_8 = var_300_0.localEulerAngles

				var_300_8.z = 0
				var_300_8.x = 0
				var_300_0.localEulerAngles = var_300_8
			end

			local var_300_9 = arg_297_1.actors_["1020ui_story"]
			local var_300_10 = 0

			if var_300_10 < arg_297_1.time_ and arg_297_1.time_ <= var_300_10 + arg_300_0 and not isNil(var_300_9) and arg_297_1.var_.characterEffect1020ui_story == nil then
				arg_297_1.var_.characterEffect1020ui_story = var_300_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_11 = 0.200000002980232

			if var_300_10 <= arg_297_1.time_ and arg_297_1.time_ < var_300_10 + var_300_11 and not isNil(var_300_9) then
				local var_300_12 = (arg_297_1.time_ - var_300_10) / var_300_11

				if arg_297_1.var_.characterEffect1020ui_story and not isNil(var_300_9) then
					arg_297_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_297_1.time_ >= var_300_10 + var_300_11 and arg_297_1.time_ < var_300_10 + var_300_11 + arg_300_0 and not isNil(var_300_9) and arg_297_1.var_.characterEffect1020ui_story then
				arg_297_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_300_13 = 0

			if var_300_13 < arg_297_1.time_ and arg_297_1.time_ <= var_300_13 + arg_300_0 then
				arg_297_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_300_14 = 0

			if var_300_14 < arg_297_1.time_ and arg_297_1.time_ <= var_300_14 + arg_300_0 then
				arg_297_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action10_1")
			end

			local var_300_15 = 0
			local var_300_16 = 0.325

			if var_300_15 < arg_297_1.time_ and arg_297_1.time_ <= var_300_15 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				local var_300_17 = arg_297_1:FormatText(StoryNameCfg[613].name)

				arg_297_1.leftNameTxt_.text = var_300_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_18 = arg_297_1:GetWordFromCfg(924011071)
				local var_300_19 = arg_297_1:FormatText(var_300_18.content)

				arg_297_1.text_.text = var_300_19

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_20 = 13
				local var_300_21 = utf8.len(var_300_19)
				local var_300_22 = var_300_20 <= 0 and var_300_16 or var_300_16 * (var_300_21 / var_300_20)

				if var_300_22 > 0 and var_300_16 < var_300_22 then
					arg_297_1.talkMaxDuration = var_300_22

					if var_300_22 + var_300_15 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_22 + var_300_15
					end
				end

				arg_297_1.text_.text = var_300_19
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011071", "story_v_side_old_924011.awb") ~= 0 then
					local var_300_23 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011071", "story_v_side_old_924011.awb") / 1000

					if var_300_23 + var_300_15 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_23 + var_300_15
					end

					if var_300_18.prefab_name ~= "" and arg_297_1.actors_[var_300_18.prefab_name] ~= nil then
						local var_300_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_18.prefab_name].transform, "story_v_side_old_924011", "924011071", "story_v_side_old_924011.awb")

						arg_297_1:RecordAudio("924011071", var_300_24)
						arg_297_1:RecordAudio("924011071", var_300_24)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011071", "story_v_side_old_924011.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011071", "story_v_side_old_924011.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_25 = math.max(var_300_16, arg_297_1.talkMaxDuration)

			if var_300_15 <= arg_297_1.time_ and arg_297_1.time_ < var_300_15 + var_300_25 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_15) / var_300_25

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_15 + var_300_25 and arg_297_1.time_ < var_300_15 + var_300_25 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_297_1:InitPlayNodeList()
	end,
	Play924011072 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 924011072
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play924011073(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = arg_301_1.actors_["1020ui_story"].transform
			local var_304_1 = 0

			if var_304_1 < arg_301_1.time_ and arg_301_1.time_ <= var_304_1 + arg_304_0 then
				arg_301_1.var_.moveOldPos1020ui_story = var_304_0.localPosition
			end

			local var_304_2 = 0.001

			if var_304_1 <= arg_301_1.time_ and arg_301_1.time_ < var_304_1 + var_304_2 then
				local var_304_3 = (arg_301_1.time_ - var_304_1) / var_304_2
				local var_304_4 = Vector3.New(0, 100, 0)

				var_304_0.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos1020ui_story, var_304_4, var_304_3)

				local var_304_5 = manager.ui.mainCamera.transform.position - var_304_0.position

				var_304_0.forward = Vector3.New(var_304_5.x, var_304_5.y, var_304_5.z)

				local var_304_6 = var_304_0.localEulerAngles

				var_304_6.z = 0
				var_304_6.x = 0
				var_304_0.localEulerAngles = var_304_6
			end

			if arg_301_1.time_ >= var_304_1 + var_304_2 and arg_301_1.time_ < var_304_1 + var_304_2 + arg_304_0 then
				var_304_0.localPosition = Vector3.New(0, 100, 0)

				local var_304_7 = manager.ui.mainCamera.transform.position - var_304_0.position

				var_304_0.forward = Vector3.New(var_304_7.x, var_304_7.y, var_304_7.z)

				local var_304_8 = var_304_0.localEulerAngles

				var_304_8.z = 0
				var_304_8.x = 0
				var_304_0.localEulerAngles = var_304_8
			end

			local var_304_9 = arg_301_1.actors_["1020ui_story"]
			local var_304_10 = 0

			if var_304_10 < arg_301_1.time_ and arg_301_1.time_ <= var_304_10 + arg_304_0 and not isNil(var_304_9) and arg_301_1.var_.characterEffect1020ui_story == nil then
				arg_301_1.var_.characterEffect1020ui_story = var_304_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_11 = 0.200000002980232

			if var_304_10 <= arg_301_1.time_ and arg_301_1.time_ < var_304_10 + var_304_11 and not isNil(var_304_9) then
				local var_304_12 = (arg_301_1.time_ - var_304_10) / var_304_11

				if arg_301_1.var_.characterEffect1020ui_story and not isNil(var_304_9) then
					local var_304_13 = Mathf.Lerp(0, 0.5, var_304_12)

					arg_301_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_301_1.var_.characterEffect1020ui_story.fillRatio = var_304_13
				end
			end

			if arg_301_1.time_ >= var_304_10 + var_304_11 and arg_301_1.time_ < var_304_10 + var_304_11 + arg_304_0 and not isNil(var_304_9) and arg_301_1.var_.characterEffect1020ui_story then
				local var_304_14 = 0.5

				arg_301_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_301_1.var_.characterEffect1020ui_story.fillRatio = var_304_14
			end

			local var_304_15 = 0
			local var_304_16 = 0.85

			if var_304_15 < arg_301_1.time_ and arg_301_1.time_ <= var_304_15 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, false)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_17 = arg_301_1:GetWordFromCfg(924011072)
				local var_304_18 = arg_301_1:FormatText(var_304_17.content)

				arg_301_1.text_.text = var_304_18

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_19 = 34
				local var_304_20 = utf8.len(var_304_18)
				local var_304_21 = var_304_19 <= 0 and var_304_16 or var_304_16 * (var_304_20 / var_304_19)

				if var_304_21 > 0 and var_304_16 < var_304_21 then
					arg_301_1.talkMaxDuration = var_304_21

					if var_304_21 + var_304_15 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_21 + var_304_15
					end
				end

				arg_301_1.text_.text = var_304_18
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_22 = math.max(var_304_16, arg_301_1.talkMaxDuration)

			if var_304_15 <= arg_301_1.time_ and arg_301_1.time_ < var_304_15 + var_304_22 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_15) / var_304_22

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_15 + var_304_22 and arg_301_1.time_ < var_304_15 + var_304_22 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
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
	Play924011073 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 924011073
		arg_305_1.duration_ = 7.8

		local var_305_0 = {
			zh = 4.833,
			ja = 7.8
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
				arg_305_0:Play924011074(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = arg_305_1.actors_["1020ui_story"].transform
			local var_308_1 = 0

			if var_308_1 < arg_305_1.time_ and arg_305_1.time_ <= var_308_1 + arg_308_0 then
				arg_305_1.var_.moveOldPos1020ui_story = var_308_0.localPosition
			end

			local var_308_2 = 0.001

			if var_308_1 <= arg_305_1.time_ and arg_305_1.time_ < var_308_1 + var_308_2 then
				local var_308_3 = (arg_305_1.time_ - var_308_1) / var_308_2
				local var_308_4 = Vector3.New(0, -0.85, -6.25)

				var_308_0.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPos1020ui_story, var_308_4, var_308_3)

				local var_308_5 = manager.ui.mainCamera.transform.position - var_308_0.position

				var_308_0.forward = Vector3.New(var_308_5.x, var_308_5.y, var_308_5.z)

				local var_308_6 = var_308_0.localEulerAngles

				var_308_6.z = 0
				var_308_6.x = 0
				var_308_0.localEulerAngles = var_308_6
			end

			if arg_305_1.time_ >= var_308_1 + var_308_2 and arg_305_1.time_ < var_308_1 + var_308_2 + arg_308_0 then
				var_308_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_308_7 = manager.ui.mainCamera.transform.position - var_308_0.position

				var_308_0.forward = Vector3.New(var_308_7.x, var_308_7.y, var_308_7.z)

				local var_308_8 = var_308_0.localEulerAngles

				var_308_8.z = 0
				var_308_8.x = 0
				var_308_0.localEulerAngles = var_308_8
			end

			local var_308_9 = arg_305_1.actors_["1020ui_story"]
			local var_308_10 = 0

			if var_308_10 < arg_305_1.time_ and arg_305_1.time_ <= var_308_10 + arg_308_0 and not isNil(var_308_9) and arg_305_1.var_.characterEffect1020ui_story == nil then
				arg_305_1.var_.characterEffect1020ui_story = var_308_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_11 = 0.200000002980232

			if var_308_10 <= arg_305_1.time_ and arg_305_1.time_ < var_308_10 + var_308_11 and not isNil(var_308_9) then
				local var_308_12 = (arg_305_1.time_ - var_308_10) / var_308_11

				if arg_305_1.var_.characterEffect1020ui_story and not isNil(var_308_9) then
					arg_305_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_305_1.time_ >= var_308_10 + var_308_11 and arg_305_1.time_ < var_308_10 + var_308_11 + arg_308_0 and not isNil(var_308_9) and arg_305_1.var_.characterEffect1020ui_story then
				arg_305_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_308_13 = 0

			if var_308_13 < arg_305_1.time_ and arg_305_1.time_ <= var_308_13 + arg_308_0 then
				arg_305_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kunraoA_sikao", "EmotionTimelineAnimator")
			end

			local var_308_14 = 0

			if var_308_14 < arg_305_1.time_ and arg_305_1.time_ <= var_308_14 + arg_308_0 then
				arg_305_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020actionlink/1020action4104")
			end

			local var_308_15 = 0
			local var_308_16 = 0.45

			if var_308_15 < arg_305_1.time_ and arg_305_1.time_ <= var_308_15 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				local var_308_17 = arg_305_1:FormatText(StoryNameCfg[613].name)

				arg_305_1.leftNameTxt_.text = var_308_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_18 = arg_305_1:GetWordFromCfg(924011073)
				local var_308_19 = arg_305_1:FormatText(var_308_18.content)

				arg_305_1.text_.text = var_308_19

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_20 = 18
				local var_308_21 = utf8.len(var_308_19)
				local var_308_22 = var_308_20 <= 0 and var_308_16 or var_308_16 * (var_308_21 / var_308_20)

				if var_308_22 > 0 and var_308_16 < var_308_22 then
					arg_305_1.talkMaxDuration = var_308_22

					if var_308_22 + var_308_15 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_22 + var_308_15
					end
				end

				arg_305_1.text_.text = var_308_19
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011073", "story_v_side_old_924011.awb") ~= 0 then
					local var_308_23 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011073", "story_v_side_old_924011.awb") / 1000

					if var_308_23 + var_308_15 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_23 + var_308_15
					end

					if var_308_18.prefab_name ~= "" and arg_305_1.actors_[var_308_18.prefab_name] ~= nil then
						local var_308_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_18.prefab_name].transform, "story_v_side_old_924011", "924011073", "story_v_side_old_924011.awb")

						arg_305_1:RecordAudio("924011073", var_308_24)
						arg_305_1:RecordAudio("924011073", var_308_24)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011073", "story_v_side_old_924011.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011073", "story_v_side_old_924011.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_25 = math.max(var_308_16, arg_305_1.talkMaxDuration)

			if var_308_15 <= arg_305_1.time_ and arg_305_1.time_ < var_308_15 + var_308_25 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_15) / var_308_25

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_15 + var_308_25 and arg_305_1.time_ < var_308_15 + var_308_25 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
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
	Play924011074 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 924011074
		arg_309_1.duration_ = 5

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play924011075(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = arg_309_1.actors_["1020ui_story"]
			local var_312_1 = 0

			if var_312_1 < arg_309_1.time_ and arg_309_1.time_ <= var_312_1 + arg_312_0 and not isNil(var_312_0) and arg_309_1.var_.characterEffect1020ui_story == nil then
				arg_309_1.var_.characterEffect1020ui_story = var_312_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_2 = 0.200000002980232

			if var_312_1 <= arg_309_1.time_ and arg_309_1.time_ < var_312_1 + var_312_2 and not isNil(var_312_0) then
				local var_312_3 = (arg_309_1.time_ - var_312_1) / var_312_2

				if arg_309_1.var_.characterEffect1020ui_story and not isNil(var_312_0) then
					local var_312_4 = Mathf.Lerp(0, 0.5, var_312_3)

					arg_309_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_309_1.var_.characterEffect1020ui_story.fillRatio = var_312_4
				end
			end

			if arg_309_1.time_ >= var_312_1 + var_312_2 and arg_309_1.time_ < var_312_1 + var_312_2 + arg_312_0 and not isNil(var_312_0) and arg_309_1.var_.characterEffect1020ui_story then
				local var_312_5 = 0.5

				arg_309_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_309_1.var_.characterEffect1020ui_story.fillRatio = var_312_5
			end

			local var_312_6 = 0
			local var_312_7 = 0.075

			if var_312_6 < arg_309_1.time_ and arg_309_1.time_ <= var_312_6 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				local var_312_8 = arg_309_1:FormatText(StoryNameCfg[7].name)

				arg_309_1.leftNameTxt_.text = var_312_8

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

				local var_312_9 = arg_309_1:GetWordFromCfg(924011074)
				local var_312_10 = arg_309_1:FormatText(var_312_9.content)

				arg_309_1.text_.text = var_312_10

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_11 = 3
				local var_312_12 = utf8.len(var_312_10)
				local var_312_13 = var_312_11 <= 0 and var_312_7 or var_312_7 * (var_312_12 / var_312_11)

				if var_312_13 > 0 and var_312_7 < var_312_13 then
					arg_309_1.talkMaxDuration = var_312_13

					if var_312_13 + var_312_6 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_13 + var_312_6
					end
				end

				arg_309_1.text_.text = var_312_10
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)
				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_14 = math.max(var_312_7, arg_309_1.talkMaxDuration)

			if var_312_6 <= arg_309_1.time_ and arg_309_1.time_ < var_312_6 + var_312_14 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_6) / var_312_14

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_6 + var_312_14 and arg_309_1.time_ < var_312_6 + var_312_14 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play924011075 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 924011075
		arg_313_1.duration_ = 8

		local var_313_0 = {
			zh = 5.3,
			ja = 8
		}
		local var_313_1 = manager.audio:GetLocalizationFlag()

		if var_313_0[var_313_1] ~= nil then
			arg_313_1.duration_ = var_313_0[var_313_1]
		end

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play924011076(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = arg_313_1.actors_["1020ui_story"].transform
			local var_316_1 = 0

			if var_316_1 < arg_313_1.time_ and arg_313_1.time_ <= var_316_1 + arg_316_0 then
				arg_313_1.var_.moveOldPos1020ui_story = var_316_0.localPosition
			end

			local var_316_2 = 0.001

			if var_316_1 <= arg_313_1.time_ and arg_313_1.time_ < var_316_1 + var_316_2 then
				local var_316_3 = (arg_313_1.time_ - var_316_1) / var_316_2
				local var_316_4 = Vector3.New(0, -0.85, -6.25)

				var_316_0.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos1020ui_story, var_316_4, var_316_3)

				local var_316_5 = manager.ui.mainCamera.transform.position - var_316_0.position

				var_316_0.forward = Vector3.New(var_316_5.x, var_316_5.y, var_316_5.z)

				local var_316_6 = var_316_0.localEulerAngles

				var_316_6.z = 0
				var_316_6.x = 0
				var_316_0.localEulerAngles = var_316_6
			end

			if arg_313_1.time_ >= var_316_1 + var_316_2 and arg_313_1.time_ < var_316_1 + var_316_2 + arg_316_0 then
				var_316_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_316_7 = manager.ui.mainCamera.transform.position - var_316_0.position

				var_316_0.forward = Vector3.New(var_316_7.x, var_316_7.y, var_316_7.z)

				local var_316_8 = var_316_0.localEulerAngles

				var_316_8.z = 0
				var_316_8.x = 0
				var_316_0.localEulerAngles = var_316_8
			end

			local var_316_9 = arg_313_1.actors_["1020ui_story"]
			local var_316_10 = 0

			if var_316_10 < arg_313_1.time_ and arg_313_1.time_ <= var_316_10 + arg_316_0 and not isNil(var_316_9) and arg_313_1.var_.characterEffect1020ui_story == nil then
				arg_313_1.var_.characterEffect1020ui_story = var_316_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_11 = 0.200000002980232

			if var_316_10 <= arg_313_1.time_ and arg_313_1.time_ < var_316_10 + var_316_11 and not isNil(var_316_9) then
				local var_316_12 = (arg_313_1.time_ - var_316_10) / var_316_11

				if arg_313_1.var_.characterEffect1020ui_story and not isNil(var_316_9) then
					arg_313_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_313_1.time_ >= var_316_10 + var_316_11 and arg_313_1.time_ < var_316_10 + var_316_11 + arg_316_0 and not isNil(var_316_9) and arg_313_1.var_.characterEffect1020ui_story then
				arg_313_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_316_13 = 0

			if var_316_13 < arg_313_1.time_ and arg_313_1.time_ <= var_316_13 + arg_316_0 then
				arg_313_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_biyanbiaozhun", "EmotionTimelineAnimator")
			end

			local var_316_14 = 0

			if var_316_14 < arg_313_1.time_ and arg_313_1.time_ <= var_316_14 + arg_316_0 then
				arg_313_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020actionlink/1020action4411")
			end

			local var_316_15 = 0
			local var_316_16 = 0.5

			if var_316_15 < arg_313_1.time_ and arg_313_1.time_ <= var_316_15 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				local var_316_17 = arg_313_1:FormatText(StoryNameCfg[613].name)

				arg_313_1.leftNameTxt_.text = var_316_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_18 = arg_313_1:GetWordFromCfg(924011075)
				local var_316_19 = arg_313_1:FormatText(var_316_18.content)

				arg_313_1.text_.text = var_316_19

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_20 = 20
				local var_316_21 = utf8.len(var_316_19)
				local var_316_22 = var_316_20 <= 0 and var_316_16 or var_316_16 * (var_316_21 / var_316_20)

				if var_316_22 > 0 and var_316_16 < var_316_22 then
					arg_313_1.talkMaxDuration = var_316_22

					if var_316_22 + var_316_15 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_22 + var_316_15
					end
				end

				arg_313_1.text_.text = var_316_19
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011075", "story_v_side_old_924011.awb") ~= 0 then
					local var_316_23 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011075", "story_v_side_old_924011.awb") / 1000

					if var_316_23 + var_316_15 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_23 + var_316_15
					end

					if var_316_18.prefab_name ~= "" and arg_313_1.actors_[var_316_18.prefab_name] ~= nil then
						local var_316_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_18.prefab_name].transform, "story_v_side_old_924011", "924011075", "story_v_side_old_924011.awb")

						arg_313_1:RecordAudio("924011075", var_316_24)
						arg_313_1:RecordAudio("924011075", var_316_24)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011075", "story_v_side_old_924011.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011075", "story_v_side_old_924011.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_25 = math.max(var_316_16, arg_313_1.talkMaxDuration)

			if var_316_15 <= arg_313_1.time_ and arg_313_1.time_ < var_316_15 + var_316_25 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_15) / var_316_25

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_15 + var_316_25 and arg_313_1.time_ < var_316_15 + var_316_25 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
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
	Play924011076 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 924011076
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play924011077(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = arg_317_1.actors_["1020ui_story"]
			local var_320_1 = 0

			if var_320_1 < arg_317_1.time_ and arg_317_1.time_ <= var_320_1 + arg_320_0 and not isNil(var_320_0) and arg_317_1.var_.characterEffect1020ui_story == nil then
				arg_317_1.var_.characterEffect1020ui_story = var_320_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_2 = 0.200000002980232

			if var_320_1 <= arg_317_1.time_ and arg_317_1.time_ < var_320_1 + var_320_2 and not isNil(var_320_0) then
				local var_320_3 = (arg_317_1.time_ - var_320_1) / var_320_2

				if arg_317_1.var_.characterEffect1020ui_story and not isNil(var_320_0) then
					local var_320_4 = Mathf.Lerp(0, 0.5, var_320_3)

					arg_317_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_317_1.var_.characterEffect1020ui_story.fillRatio = var_320_4
				end
			end

			if arg_317_1.time_ >= var_320_1 + var_320_2 and arg_317_1.time_ < var_320_1 + var_320_2 + arg_320_0 and not isNil(var_320_0) and arg_317_1.var_.characterEffect1020ui_story then
				local var_320_5 = 0.5

				arg_317_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_317_1.var_.characterEffect1020ui_story.fillRatio = var_320_5
			end

			local var_320_6 = 0
			local var_320_7 = 0.05

			if var_320_6 < arg_317_1.time_ and arg_317_1.time_ <= var_320_6 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				local var_320_8 = arg_317_1:FormatText(StoryNameCfg[7].name)

				arg_317_1.leftNameTxt_.text = var_320_8

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

				local var_320_9 = arg_317_1:GetWordFromCfg(924011076)
				local var_320_10 = arg_317_1:FormatText(var_320_9.content)

				arg_317_1.text_.text = var_320_10

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_11 = 2
				local var_320_12 = utf8.len(var_320_10)
				local var_320_13 = var_320_11 <= 0 and var_320_7 or var_320_7 * (var_320_12 / var_320_11)

				if var_320_13 > 0 and var_320_7 < var_320_13 then
					arg_317_1.talkMaxDuration = var_320_13

					if var_320_13 + var_320_6 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_13 + var_320_6
					end
				end

				arg_317_1.text_.text = var_320_10
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_14 = math.max(var_320_7, arg_317_1.talkMaxDuration)

			if var_320_6 <= arg_317_1.time_ and arg_317_1.time_ < var_320_6 + var_320_14 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_6) / var_320_14

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_6 + var_320_14 and arg_317_1.time_ < var_320_6 + var_320_14 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play924011077 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 924011077
		arg_321_1.duration_ = 9.5

		local var_321_0 = {
			zh = 7.166,
			ja = 9.5
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
				arg_321_0:Play924011078(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = arg_321_1.actors_["1020ui_story"].transform
			local var_324_1 = 0

			if var_324_1 < arg_321_1.time_ and arg_321_1.time_ <= var_324_1 + arg_324_0 then
				arg_321_1.var_.moveOldPos1020ui_story = var_324_0.localPosition
			end

			local var_324_2 = 0.001

			if var_324_1 <= arg_321_1.time_ and arg_321_1.time_ < var_324_1 + var_324_2 then
				local var_324_3 = (arg_321_1.time_ - var_324_1) / var_324_2
				local var_324_4 = Vector3.New(0, -0.85, -6.25)

				var_324_0.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos1020ui_story, var_324_4, var_324_3)

				local var_324_5 = manager.ui.mainCamera.transform.position - var_324_0.position

				var_324_0.forward = Vector3.New(var_324_5.x, var_324_5.y, var_324_5.z)

				local var_324_6 = var_324_0.localEulerAngles

				var_324_6.z = 0
				var_324_6.x = 0
				var_324_0.localEulerAngles = var_324_6
			end

			if arg_321_1.time_ >= var_324_1 + var_324_2 and arg_321_1.time_ < var_324_1 + var_324_2 + arg_324_0 then
				var_324_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_324_7 = manager.ui.mainCamera.transform.position - var_324_0.position

				var_324_0.forward = Vector3.New(var_324_7.x, var_324_7.y, var_324_7.z)

				local var_324_8 = var_324_0.localEulerAngles

				var_324_8.z = 0
				var_324_8.x = 0
				var_324_0.localEulerAngles = var_324_8
			end

			local var_324_9 = arg_321_1.actors_["1020ui_story"]
			local var_324_10 = 0

			if var_324_10 < arg_321_1.time_ and arg_321_1.time_ <= var_324_10 + arg_324_0 and not isNil(var_324_9) and arg_321_1.var_.characterEffect1020ui_story == nil then
				arg_321_1.var_.characterEffect1020ui_story = var_324_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_11 = 0.200000002980232

			if var_324_10 <= arg_321_1.time_ and arg_321_1.time_ < var_324_10 + var_324_11 and not isNil(var_324_9) then
				local var_324_12 = (arg_321_1.time_ - var_324_10) / var_324_11

				if arg_321_1.var_.characterEffect1020ui_story and not isNil(var_324_9) then
					arg_321_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_321_1.time_ >= var_324_10 + var_324_11 and arg_321_1.time_ < var_324_10 + var_324_11 + arg_324_0 and not isNil(var_324_9) and arg_321_1.var_.characterEffect1020ui_story then
				arg_321_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_324_13 = 0

			if var_324_13 < arg_321_1.time_ and arg_321_1.time_ <= var_324_13 + arg_324_0 then
				arg_321_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_324_14 = 0

			if var_324_14 < arg_321_1.time_ and arg_321_1.time_ <= var_324_14 + arg_324_0 then
				arg_321_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action11_2")
			end

			local var_324_15 = 0
			local var_324_16 = 0.725

			if var_324_15 < arg_321_1.time_ and arg_321_1.time_ <= var_324_15 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				local var_324_17 = arg_321_1:FormatText(StoryNameCfg[613].name)

				arg_321_1.leftNameTxt_.text = var_324_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_18 = arg_321_1:GetWordFromCfg(924011077)
				local var_324_19 = arg_321_1:FormatText(var_324_18.content)

				arg_321_1.text_.text = var_324_19

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_20 = 29
				local var_324_21 = utf8.len(var_324_19)
				local var_324_22 = var_324_20 <= 0 and var_324_16 or var_324_16 * (var_324_21 / var_324_20)

				if var_324_22 > 0 and var_324_16 < var_324_22 then
					arg_321_1.talkMaxDuration = var_324_22

					if var_324_22 + var_324_15 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_22 + var_324_15
					end
				end

				arg_321_1.text_.text = var_324_19
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011077", "story_v_side_old_924011.awb") ~= 0 then
					local var_324_23 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011077", "story_v_side_old_924011.awb") / 1000

					if var_324_23 + var_324_15 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_23 + var_324_15
					end

					if var_324_18.prefab_name ~= "" and arg_321_1.actors_[var_324_18.prefab_name] ~= nil then
						local var_324_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_18.prefab_name].transform, "story_v_side_old_924011", "924011077", "story_v_side_old_924011.awb")

						arg_321_1:RecordAudio("924011077", var_324_24)
						arg_321_1:RecordAudio("924011077", var_324_24)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011077", "story_v_side_old_924011.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011077", "story_v_side_old_924011.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_25 = math.max(var_324_16, arg_321_1.talkMaxDuration)

			if var_324_15 <= arg_321_1.time_ and arg_321_1.time_ < var_324_15 + var_324_25 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_15) / var_324_25

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_15 + var_324_25 and arg_321_1.time_ < var_324_15 + var_324_25 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_321_1:InitPlayNodeList()
	end,
	Play924011078 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 924011078
		arg_325_1.duration_ = 5

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play924011079(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = arg_325_1.actors_["1020ui_story"]
			local var_328_1 = 0

			if var_328_1 < arg_325_1.time_ and arg_325_1.time_ <= var_328_1 + arg_328_0 and not isNil(var_328_0) and arg_325_1.var_.characterEffect1020ui_story == nil then
				arg_325_1.var_.characterEffect1020ui_story = var_328_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_2 = 0.200000002980232

			if var_328_1 <= arg_325_1.time_ and arg_325_1.time_ < var_328_1 + var_328_2 and not isNil(var_328_0) then
				local var_328_3 = (arg_325_1.time_ - var_328_1) / var_328_2

				if arg_325_1.var_.characterEffect1020ui_story and not isNil(var_328_0) then
					local var_328_4 = Mathf.Lerp(0, 0.5, var_328_3)

					arg_325_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_325_1.var_.characterEffect1020ui_story.fillRatio = var_328_4
				end
			end

			if arg_325_1.time_ >= var_328_1 + var_328_2 and arg_325_1.time_ < var_328_1 + var_328_2 + arg_328_0 and not isNil(var_328_0) and arg_325_1.var_.characterEffect1020ui_story then
				local var_328_5 = 0.5

				arg_325_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_325_1.var_.characterEffect1020ui_story.fillRatio = var_328_5
			end

			local var_328_6 = 0
			local var_328_7 = 0.425

			if var_328_6 < arg_325_1.time_ and arg_325_1.time_ <= var_328_6 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				local var_328_8 = arg_325_1:FormatText(StoryNameCfg[7].name)

				arg_325_1.leftNameTxt_.text = var_328_8

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

				local var_328_9 = arg_325_1:GetWordFromCfg(924011078)
				local var_328_10 = arg_325_1:FormatText(var_328_9.content)

				arg_325_1.text_.text = var_328_10

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_11 = 17
				local var_328_12 = utf8.len(var_328_10)
				local var_328_13 = var_328_11 <= 0 and var_328_7 or var_328_7 * (var_328_12 / var_328_11)

				if var_328_13 > 0 and var_328_7 < var_328_13 then
					arg_325_1.talkMaxDuration = var_328_13

					if var_328_13 + var_328_6 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_13 + var_328_6
					end
				end

				arg_325_1.text_.text = var_328_10
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)
				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_14 = math.max(var_328_7, arg_325_1.talkMaxDuration)

			if var_328_6 <= arg_325_1.time_ and arg_325_1.time_ < var_328_6 + var_328_14 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_6) / var_328_14

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_6 + var_328_14 and arg_325_1.time_ < var_328_6 + var_328_14 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play924011079 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 924011079
		arg_329_1.duration_ = 7.83

		local var_329_0 = {
			zh = 5.1,
			ja = 7.833
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
				arg_329_0:Play924011080(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = arg_329_1.actors_["1020ui_story"].transform
			local var_332_1 = 0

			if var_332_1 < arg_329_1.time_ and arg_329_1.time_ <= var_332_1 + arg_332_0 then
				arg_329_1.var_.moveOldPos1020ui_story = var_332_0.localPosition
			end

			local var_332_2 = 0.001

			if var_332_1 <= arg_329_1.time_ and arg_329_1.time_ < var_332_1 + var_332_2 then
				local var_332_3 = (arg_329_1.time_ - var_332_1) / var_332_2
				local var_332_4 = Vector3.New(0, -0.85, -6.25)

				var_332_0.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1020ui_story, var_332_4, var_332_3)

				local var_332_5 = manager.ui.mainCamera.transform.position - var_332_0.position

				var_332_0.forward = Vector3.New(var_332_5.x, var_332_5.y, var_332_5.z)

				local var_332_6 = var_332_0.localEulerAngles

				var_332_6.z = 0
				var_332_6.x = 0
				var_332_0.localEulerAngles = var_332_6
			end

			if arg_329_1.time_ >= var_332_1 + var_332_2 and arg_329_1.time_ < var_332_1 + var_332_2 + arg_332_0 then
				var_332_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_332_7 = manager.ui.mainCamera.transform.position - var_332_0.position

				var_332_0.forward = Vector3.New(var_332_7.x, var_332_7.y, var_332_7.z)

				local var_332_8 = var_332_0.localEulerAngles

				var_332_8.z = 0
				var_332_8.x = 0
				var_332_0.localEulerAngles = var_332_8
			end

			local var_332_9 = arg_329_1.actors_["1020ui_story"]
			local var_332_10 = 0

			if var_332_10 < arg_329_1.time_ and arg_329_1.time_ <= var_332_10 + arg_332_0 and not isNil(var_332_9) and arg_329_1.var_.characterEffect1020ui_story == nil then
				arg_329_1.var_.characterEffect1020ui_story = var_332_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_11 = 0.200000002980232

			if var_332_10 <= arg_329_1.time_ and arg_329_1.time_ < var_332_10 + var_332_11 and not isNil(var_332_9) then
				local var_332_12 = (arg_329_1.time_ - var_332_10) / var_332_11

				if arg_329_1.var_.characterEffect1020ui_story and not isNil(var_332_9) then
					arg_329_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_329_1.time_ >= var_332_10 + var_332_11 and arg_329_1.time_ < var_332_10 + var_332_11 + arg_332_0 and not isNil(var_332_9) and arg_329_1.var_.characterEffect1020ui_story then
				arg_329_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_332_13 = 0

			if var_332_13 < arg_329_1.time_ and arg_329_1.time_ <= var_332_13 + arg_332_0 then
				arg_329_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action1_1")
			end

			local var_332_14 = 0

			if var_332_14 < arg_329_1.time_ and arg_329_1.time_ <= var_332_14 + arg_332_0 then
				arg_329_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_332_15 = 0
			local var_332_16 = 0.725

			if var_332_15 < arg_329_1.time_ and arg_329_1.time_ <= var_332_15 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				local var_332_17 = arg_329_1:FormatText(StoryNameCfg[613].name)

				arg_329_1.leftNameTxt_.text = var_332_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_18 = arg_329_1:GetWordFromCfg(924011079)
				local var_332_19 = arg_329_1:FormatText(var_332_18.content)

				arg_329_1.text_.text = var_332_19

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_20 = 29
				local var_332_21 = utf8.len(var_332_19)
				local var_332_22 = var_332_20 <= 0 and var_332_16 or var_332_16 * (var_332_21 / var_332_20)

				if var_332_22 > 0 and var_332_16 < var_332_22 then
					arg_329_1.talkMaxDuration = var_332_22

					if var_332_22 + var_332_15 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_22 + var_332_15
					end
				end

				arg_329_1.text_.text = var_332_19
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011079", "story_v_side_old_924011.awb") ~= 0 then
					local var_332_23 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011079", "story_v_side_old_924011.awb") / 1000

					if var_332_23 + var_332_15 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_23 + var_332_15
					end

					if var_332_18.prefab_name ~= "" and arg_329_1.actors_[var_332_18.prefab_name] ~= nil then
						local var_332_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_18.prefab_name].transform, "story_v_side_old_924011", "924011079", "story_v_side_old_924011.awb")

						arg_329_1:RecordAudio("924011079", var_332_24)
						arg_329_1:RecordAudio("924011079", var_332_24)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011079", "story_v_side_old_924011.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011079", "story_v_side_old_924011.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_25 = math.max(var_332_16, arg_329_1.talkMaxDuration)

			if var_332_15 <= arg_329_1.time_ and arg_329_1.time_ < var_332_15 + var_332_25 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_15) / var_332_25

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_15 + var_332_25 and arg_329_1.time_ < var_332_15 + var_332_25 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_329_1:InitPlayNodeList()
	end,
	Play924011080 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 924011080
		arg_333_1.duration_ = 7.03

		local var_333_0 = {
			zh = 4.166,
			ja = 7.033
		}
		local var_333_1 = manager.audio:GetLocalizationFlag()

		if var_333_0[var_333_1] ~= nil then
			arg_333_1.duration_ = var_333_0[var_333_1]
		end

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play924011081(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = 0

			if var_336_0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_0 + arg_336_0 then
				arg_333_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_zhayanL", "EmotionTimelineAnimator")
			end

			local var_336_1 = 0

			if var_336_1 < arg_333_1.time_ and arg_333_1.time_ <= var_336_1 + arg_336_0 then
				arg_333_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action7_1")
			end

			local var_336_2 = 0
			local var_336_3 = 0.55

			if var_336_2 < arg_333_1.time_ and arg_333_1.time_ <= var_336_2 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				local var_336_4 = arg_333_1:FormatText(StoryNameCfg[613].name)

				arg_333_1.leftNameTxt_.text = var_336_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_5 = arg_333_1:GetWordFromCfg(924011080)
				local var_336_6 = arg_333_1:FormatText(var_336_5.content)

				arg_333_1.text_.text = var_336_6

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_7 = 22
				local var_336_8 = utf8.len(var_336_6)
				local var_336_9 = var_336_7 <= 0 and var_336_3 or var_336_3 * (var_336_8 / var_336_7)

				if var_336_9 > 0 and var_336_3 < var_336_9 then
					arg_333_1.talkMaxDuration = var_336_9

					if var_336_9 + var_336_2 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_9 + var_336_2
					end
				end

				arg_333_1.text_.text = var_336_6
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011080", "story_v_side_old_924011.awb") ~= 0 then
					local var_336_10 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011080", "story_v_side_old_924011.awb") / 1000

					if var_336_10 + var_336_2 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_10 + var_336_2
					end

					if var_336_5.prefab_name ~= "" and arg_333_1.actors_[var_336_5.prefab_name] ~= nil then
						local var_336_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_5.prefab_name].transform, "story_v_side_old_924011", "924011080", "story_v_side_old_924011.awb")

						arg_333_1:RecordAudio("924011080", var_336_11)
						arg_333_1:RecordAudio("924011080", var_336_11)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011080", "story_v_side_old_924011.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011080", "story_v_side_old_924011.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_12 = math.max(var_336_3, arg_333_1.talkMaxDuration)

			if var_336_2 <= arg_333_1.time_ and arg_333_1.time_ < var_336_2 + var_336_12 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_2) / var_336_12

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_2 + var_336_12 and arg_333_1.time_ < var_336_2 + var_336_12 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play924011081 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 924011081
		arg_337_1.duration_ = 5

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play924011082(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = arg_337_1.actors_["1020ui_story"]
			local var_340_1 = 0

			if var_340_1 < arg_337_1.time_ and arg_337_1.time_ <= var_340_1 + arg_340_0 and not isNil(var_340_0) and arg_337_1.var_.characterEffect1020ui_story == nil then
				arg_337_1.var_.characterEffect1020ui_story = var_340_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_2 = 0.200000002980232

			if var_340_1 <= arg_337_1.time_ and arg_337_1.time_ < var_340_1 + var_340_2 and not isNil(var_340_0) then
				local var_340_3 = (arg_337_1.time_ - var_340_1) / var_340_2

				if arg_337_1.var_.characterEffect1020ui_story and not isNil(var_340_0) then
					local var_340_4 = Mathf.Lerp(0, 0.5, var_340_3)

					arg_337_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_337_1.var_.characterEffect1020ui_story.fillRatio = var_340_4
				end
			end

			if arg_337_1.time_ >= var_340_1 + var_340_2 and arg_337_1.time_ < var_340_1 + var_340_2 + arg_340_0 and not isNil(var_340_0) and arg_337_1.var_.characterEffect1020ui_story then
				local var_340_5 = 0.5

				arg_337_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_337_1.var_.characterEffect1020ui_story.fillRatio = var_340_5
			end

			local var_340_6 = 0
			local var_340_7 = 0.325

			if var_340_6 < arg_337_1.time_ and arg_337_1.time_ <= var_340_6 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				local var_340_8 = arg_337_1:FormatText(StoryNameCfg[7].name)

				arg_337_1.leftNameTxt_.text = var_340_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, true)
				arg_337_1.iconController_:SetSelectedState("hero")

				arg_337_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_337_1.callingController_:SetSelectedState("normal")

				arg_337_1.keyicon_.color = Color.New(1, 1, 1)
				arg_337_1.icon_.color = Color.New(1, 1, 1)

				local var_340_9 = arg_337_1:GetWordFromCfg(924011081)
				local var_340_10 = arg_337_1:FormatText(var_340_9.content)

				arg_337_1.text_.text = var_340_10

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_11 = 13
				local var_340_12 = utf8.len(var_340_10)
				local var_340_13 = var_340_11 <= 0 and var_340_7 or var_340_7 * (var_340_12 / var_340_11)

				if var_340_13 > 0 and var_340_7 < var_340_13 then
					arg_337_1.talkMaxDuration = var_340_13

					if var_340_13 + var_340_6 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_13 + var_340_6
					end
				end

				arg_337_1.text_.text = var_340_10
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)
				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_14 = math.max(var_340_7, arg_337_1.talkMaxDuration)

			if var_340_6 <= arg_337_1.time_ and arg_337_1.time_ < var_340_6 + var_340_14 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_6) / var_340_14

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_6 + var_340_14 and arg_337_1.time_ < var_340_6 + var_340_14 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play924011082 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 924011082
		arg_341_1.duration_ = 2.23

		local var_341_0 = {
			zh = 1.999999999999,
			ja = 2.233
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
				arg_341_0:Play924011083(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = arg_341_1.actors_["1020ui_story"].transform
			local var_344_1 = 0

			if var_344_1 < arg_341_1.time_ and arg_341_1.time_ <= var_344_1 + arg_344_0 then
				arg_341_1.var_.moveOldPos1020ui_story = var_344_0.localPosition
			end

			local var_344_2 = 0.001

			if var_344_1 <= arg_341_1.time_ and arg_341_1.time_ < var_344_1 + var_344_2 then
				local var_344_3 = (arg_341_1.time_ - var_344_1) / var_344_2
				local var_344_4 = Vector3.New(0, -0.85, -6.25)

				var_344_0.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPos1020ui_story, var_344_4, var_344_3)

				local var_344_5 = manager.ui.mainCamera.transform.position - var_344_0.position

				var_344_0.forward = Vector3.New(var_344_5.x, var_344_5.y, var_344_5.z)

				local var_344_6 = var_344_0.localEulerAngles

				var_344_6.z = 0
				var_344_6.x = 0
				var_344_0.localEulerAngles = var_344_6
			end

			if arg_341_1.time_ >= var_344_1 + var_344_2 and arg_341_1.time_ < var_344_1 + var_344_2 + arg_344_0 then
				var_344_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_344_7 = manager.ui.mainCamera.transform.position - var_344_0.position

				var_344_0.forward = Vector3.New(var_344_7.x, var_344_7.y, var_344_7.z)

				local var_344_8 = var_344_0.localEulerAngles

				var_344_8.z = 0
				var_344_8.x = 0
				var_344_0.localEulerAngles = var_344_8
			end

			local var_344_9 = arg_341_1.actors_["1020ui_story"]
			local var_344_10 = 0

			if var_344_10 < arg_341_1.time_ and arg_341_1.time_ <= var_344_10 + arg_344_0 and not isNil(var_344_9) and arg_341_1.var_.characterEffect1020ui_story == nil then
				arg_341_1.var_.characterEffect1020ui_story = var_344_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_11 = 0.200000002980232

			if var_344_10 <= arg_341_1.time_ and arg_341_1.time_ < var_344_10 + var_344_11 and not isNil(var_344_9) then
				local var_344_12 = (arg_341_1.time_ - var_344_10) / var_344_11

				if arg_341_1.var_.characterEffect1020ui_story and not isNil(var_344_9) then
					arg_341_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_341_1.time_ >= var_344_10 + var_344_11 and arg_341_1.time_ < var_344_10 + var_344_11 + arg_344_0 and not isNil(var_344_9) and arg_341_1.var_.characterEffect1020ui_story then
				arg_341_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_344_13 = 0

			if var_344_13 < arg_341_1.time_ and arg_341_1.time_ <= var_344_13 + arg_344_0 then
				arg_341_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_344_14 = 0

			if var_344_14 < arg_341_1.time_ and arg_341_1.time_ <= var_344_14 + arg_344_0 then
				arg_341_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action7_2")
			end

			local var_344_15 = 0
			local var_344_16 = 0.125

			if var_344_15 < arg_341_1.time_ and arg_341_1.time_ <= var_344_15 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				local var_344_17 = arg_341_1:FormatText(StoryNameCfg[613].name)

				arg_341_1.leftNameTxt_.text = var_344_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_18 = arg_341_1:GetWordFromCfg(924011082)
				local var_344_19 = arg_341_1:FormatText(var_344_18.content)

				arg_341_1.text_.text = var_344_19

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_20 = 5
				local var_344_21 = utf8.len(var_344_19)
				local var_344_22 = var_344_20 <= 0 and var_344_16 or var_344_16 * (var_344_21 / var_344_20)

				if var_344_22 > 0 and var_344_16 < var_344_22 then
					arg_341_1.talkMaxDuration = var_344_22

					if var_344_22 + var_344_15 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_22 + var_344_15
					end
				end

				arg_341_1.text_.text = var_344_19
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011082", "story_v_side_old_924011.awb") ~= 0 then
					local var_344_23 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011082", "story_v_side_old_924011.awb") / 1000

					if var_344_23 + var_344_15 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_23 + var_344_15
					end

					if var_344_18.prefab_name ~= "" and arg_341_1.actors_[var_344_18.prefab_name] ~= nil then
						local var_344_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_18.prefab_name].transform, "story_v_side_old_924011", "924011082", "story_v_side_old_924011.awb")

						arg_341_1:RecordAudio("924011082", var_344_24)
						arg_341_1:RecordAudio("924011082", var_344_24)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011082", "story_v_side_old_924011.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011082", "story_v_side_old_924011.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_25 = math.max(var_344_16, arg_341_1.talkMaxDuration)

			if var_344_15 <= arg_341_1.time_ and arg_341_1.time_ < var_344_15 + var_344_25 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_15) / var_344_25

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_15 + var_344_25 and arg_341_1.time_ < var_344_15 + var_344_25 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_341_1:InitPlayNodeList()
	end,
	Play924011083 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 924011083
		arg_345_1.duration_ = 5

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play924011084(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = arg_345_1.actors_["1020ui_story"]
			local var_348_1 = 0

			if var_348_1 < arg_345_1.time_ and arg_345_1.time_ <= var_348_1 + arg_348_0 and not isNil(var_348_0) and arg_345_1.var_.characterEffect1020ui_story == nil then
				arg_345_1.var_.characterEffect1020ui_story = var_348_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_2 = 0.200000002980232

			if var_348_1 <= arg_345_1.time_ and arg_345_1.time_ < var_348_1 + var_348_2 and not isNil(var_348_0) then
				local var_348_3 = (arg_345_1.time_ - var_348_1) / var_348_2

				if arg_345_1.var_.characterEffect1020ui_story and not isNil(var_348_0) then
					local var_348_4 = Mathf.Lerp(0, 0.5, var_348_3)

					arg_345_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_345_1.var_.characterEffect1020ui_story.fillRatio = var_348_4
				end
			end

			if arg_345_1.time_ >= var_348_1 + var_348_2 and arg_345_1.time_ < var_348_1 + var_348_2 + arg_348_0 and not isNil(var_348_0) and arg_345_1.var_.characterEffect1020ui_story then
				local var_348_5 = 0.5

				arg_345_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_345_1.var_.characterEffect1020ui_story.fillRatio = var_348_5
			end

			local var_348_6 = 0
			local var_348_7 = 0.95

			if var_348_6 < arg_345_1.time_ and arg_345_1.time_ <= var_348_6 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				local var_348_8 = arg_345_1:FormatText(StoryNameCfg[7].name)

				arg_345_1.leftNameTxt_.text = var_348_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, true)
				arg_345_1.iconController_:SetSelectedState("hero")

				arg_345_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_345_1.callingController_:SetSelectedState("normal")

				arg_345_1.keyicon_.color = Color.New(1, 1, 1)
				arg_345_1.icon_.color = Color.New(1, 1, 1)

				local var_348_9 = arg_345_1:GetWordFromCfg(924011083)
				local var_348_10 = arg_345_1:FormatText(var_348_9.content)

				arg_345_1.text_.text = var_348_10

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_11 = 38
				local var_348_12 = utf8.len(var_348_10)
				local var_348_13 = var_348_11 <= 0 and var_348_7 or var_348_7 * (var_348_12 / var_348_11)

				if var_348_13 > 0 and var_348_7 < var_348_13 then
					arg_345_1.talkMaxDuration = var_348_13

					if var_348_13 + var_348_6 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_13 + var_348_6
					end
				end

				arg_345_1.text_.text = var_348_10
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)
				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_14 = math.max(var_348_7, arg_345_1.talkMaxDuration)

			if var_348_6 <= arg_345_1.time_ and arg_345_1.time_ < var_348_6 + var_348_14 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_6) / var_348_14

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_6 + var_348_14 and arg_345_1.time_ < var_348_6 + var_348_14 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play924011084 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 924011084
		arg_349_1.duration_ = 5

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play924011085(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = 0
			local var_352_1 = 0.5

			if var_352_0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_0 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				local var_352_2 = arg_349_1:FormatText(StoryNameCfg[7].name)

				arg_349_1.leftNameTxt_.text = var_352_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, true)
				arg_349_1.iconController_:SetSelectedState("hero")

				arg_349_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_349_1.callingController_:SetSelectedState("normal")

				arg_349_1.keyicon_.color = Color.New(1, 1, 1)
				arg_349_1.icon_.color = Color.New(1, 1, 1)

				local var_352_3 = arg_349_1:GetWordFromCfg(924011084)
				local var_352_4 = arg_349_1:FormatText(var_352_3.content)

				arg_349_1.text_.text = var_352_4

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_5 = 20
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
				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_8 = math.max(var_352_1, arg_349_1.talkMaxDuration)

			if var_352_0 <= arg_349_1.time_ and arg_349_1.time_ < var_352_0 + var_352_8 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_0) / var_352_8

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_0 + var_352_8 and arg_349_1.time_ < var_352_0 + var_352_8 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play924011085 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 924011085
		arg_353_1.duration_ = 5

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play924011086(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = arg_353_1.actors_["1020ui_story"].transform
			local var_356_1 = 0

			if var_356_1 < arg_353_1.time_ and arg_353_1.time_ <= var_356_1 + arg_356_0 then
				arg_353_1.var_.moveOldPos1020ui_story = var_356_0.localPosition
			end

			local var_356_2 = 0.001

			if var_356_1 <= arg_353_1.time_ and arg_353_1.time_ < var_356_1 + var_356_2 then
				local var_356_3 = (arg_353_1.time_ - var_356_1) / var_356_2
				local var_356_4 = Vector3.New(0, 100, 0)

				var_356_0.localPosition = Vector3.Lerp(arg_353_1.var_.moveOldPos1020ui_story, var_356_4, var_356_3)

				local var_356_5 = manager.ui.mainCamera.transform.position - var_356_0.position

				var_356_0.forward = Vector3.New(var_356_5.x, var_356_5.y, var_356_5.z)

				local var_356_6 = var_356_0.localEulerAngles

				var_356_6.z = 0
				var_356_6.x = 0
				var_356_0.localEulerAngles = var_356_6
			end

			if arg_353_1.time_ >= var_356_1 + var_356_2 and arg_353_1.time_ < var_356_1 + var_356_2 + arg_356_0 then
				var_356_0.localPosition = Vector3.New(0, 100, 0)

				local var_356_7 = manager.ui.mainCamera.transform.position - var_356_0.position

				var_356_0.forward = Vector3.New(var_356_7.x, var_356_7.y, var_356_7.z)

				local var_356_8 = var_356_0.localEulerAngles

				var_356_8.z = 0
				var_356_8.x = 0
				var_356_0.localEulerAngles = var_356_8
			end

			local var_356_9 = 0.633333333333333
			local var_356_10 = 1

			if var_356_9 < arg_353_1.time_ and arg_353_1.time_ <= var_356_9 + arg_356_0 then
				local var_356_11 = "play"
				local var_356_12 = "effect"

				arg_353_1:AudioAction(var_356_11, var_356_12, "se_story_140", "se_story_140_foley_phone", "")
			end

			local var_356_13 = 0
			local var_356_14 = 1

			if var_356_13 < arg_353_1.time_ and arg_353_1.time_ <= var_356_13 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, false)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_15 = arg_353_1:GetWordFromCfg(924011085)
				local var_356_16 = arg_353_1:FormatText(var_356_15.content)

				arg_353_1.text_.text = var_356_16

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_17 = 40
				local var_356_18 = utf8.len(var_356_16)
				local var_356_19 = var_356_17 <= 0 and var_356_14 or var_356_14 * (var_356_18 / var_356_17)

				if var_356_19 > 0 and var_356_14 < var_356_19 then
					arg_353_1.talkMaxDuration = var_356_19

					if var_356_19 + var_356_13 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_19 + var_356_13
					end
				end

				arg_353_1.text_.text = var_356_16
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)
				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_20 = math.max(var_356_14, arg_353_1.talkMaxDuration)

			if var_356_13 <= arg_353_1.time_ and arg_353_1.time_ < var_356_13 + var_356_20 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_13) / var_356_20

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_13 + var_356_20 and arg_353_1.time_ < var_356_13 + var_356_20 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_353_1:InitPlayNodeList()
	end,
	Play924011086 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 924011086
		arg_357_1.duration_ = 5

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play924011087(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			local var_360_0 = 0.125
			local var_360_1 = 1

			if var_360_0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_0 + arg_360_0 then
				local var_360_2 = "play"
				local var_360_3 = "effect"

				arg_357_1:AudioAction(var_360_2, var_360_3, "se_story_141", "se_story_141_footstep_run", "")
			end

			local var_360_4 = 0
			local var_360_5 = 0.9

			if var_360_4 < arg_357_1.time_ and arg_357_1.time_ <= var_360_4 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, false)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_6 = arg_357_1:GetWordFromCfg(924011086)
				local var_360_7 = arg_357_1:FormatText(var_360_6.content)

				arg_357_1.text_.text = var_360_7

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_8 = 36
				local var_360_9 = utf8.len(var_360_7)
				local var_360_10 = var_360_8 <= 0 and var_360_5 or var_360_5 * (var_360_9 / var_360_8)

				if var_360_10 > 0 and var_360_5 < var_360_10 then
					arg_357_1.talkMaxDuration = var_360_10

					if var_360_10 + var_360_4 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_10 + var_360_4
					end
				end

				arg_357_1.text_.text = var_360_7
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)
				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_11 = math.max(var_360_5, arg_357_1.talkMaxDuration)

			if var_360_4 <= arg_357_1.time_ and arg_357_1.time_ < var_360_4 + var_360_11 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_4) / var_360_11

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_4 + var_360_11 and arg_357_1.time_ < var_360_4 + var_360_11 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play924011087 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 924011087
		arg_361_1.duration_ = 4.97

		local var_361_0 = {
			zh = 2.866,
			ja = 4.966
		}
		local var_361_1 = manager.audio:GetLocalizationFlag()

		if var_361_0[var_361_1] ~= nil then
			arg_361_1.duration_ = var_361_0[var_361_1]
		end

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play924011088(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = arg_361_1.actors_["1020ui_story"].transform
			local var_364_1 = 0

			if var_364_1 < arg_361_1.time_ and arg_361_1.time_ <= var_364_1 + arg_364_0 then
				arg_361_1.var_.moveOldPos1020ui_story = var_364_0.localPosition
			end

			local var_364_2 = 0.001

			if var_364_1 <= arg_361_1.time_ and arg_361_1.time_ < var_364_1 + var_364_2 then
				local var_364_3 = (arg_361_1.time_ - var_364_1) / var_364_2
				local var_364_4 = Vector3.New(0, -0.85, -6.25)

				var_364_0.localPosition = Vector3.Lerp(arg_361_1.var_.moveOldPos1020ui_story, var_364_4, var_364_3)

				local var_364_5 = manager.ui.mainCamera.transform.position - var_364_0.position

				var_364_0.forward = Vector3.New(var_364_5.x, var_364_5.y, var_364_5.z)

				local var_364_6 = var_364_0.localEulerAngles

				var_364_6.z = 0
				var_364_6.x = 0
				var_364_0.localEulerAngles = var_364_6
			end

			if arg_361_1.time_ >= var_364_1 + var_364_2 and arg_361_1.time_ < var_364_1 + var_364_2 + arg_364_0 then
				var_364_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_364_7 = manager.ui.mainCamera.transform.position - var_364_0.position

				var_364_0.forward = Vector3.New(var_364_7.x, var_364_7.y, var_364_7.z)

				local var_364_8 = var_364_0.localEulerAngles

				var_364_8.z = 0
				var_364_8.x = 0
				var_364_0.localEulerAngles = var_364_8
			end

			local var_364_9 = arg_361_1.actors_["1020ui_story"]
			local var_364_10 = 0

			if var_364_10 < arg_361_1.time_ and arg_361_1.time_ <= var_364_10 + arg_364_0 and not isNil(var_364_9) and arg_361_1.var_.characterEffect1020ui_story == nil then
				arg_361_1.var_.characterEffect1020ui_story = var_364_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_364_11 = 0.200000002980232

			if var_364_10 <= arg_361_1.time_ and arg_361_1.time_ < var_364_10 + var_364_11 and not isNil(var_364_9) then
				local var_364_12 = (arg_361_1.time_ - var_364_10) / var_364_11

				if arg_361_1.var_.characterEffect1020ui_story and not isNil(var_364_9) then
					arg_361_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_361_1.time_ >= var_364_10 + var_364_11 and arg_361_1.time_ < var_364_10 + var_364_11 + arg_364_0 and not isNil(var_364_9) and arg_361_1.var_.characterEffect1020ui_story then
				arg_361_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_364_13 = 0

			if var_364_13 < arg_361_1.time_ and arg_361_1.time_ <= var_364_13 + arg_364_0 then
				arg_361_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_364_14 = 0

			if var_364_14 < arg_361_1.time_ and arg_361_1.time_ <= var_364_14 + arg_364_0 then
				arg_361_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action8_1")
			end

			local var_364_15 = 0
			local var_364_16 = 0.275

			if var_364_15 < arg_361_1.time_ and arg_361_1.time_ <= var_364_15 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				local var_364_17 = arg_361_1:FormatText(StoryNameCfg[613].name)

				arg_361_1.leftNameTxt_.text = var_364_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_18 = arg_361_1:GetWordFromCfg(924011087)
				local var_364_19 = arg_361_1:FormatText(var_364_18.content)

				arg_361_1.text_.text = var_364_19

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_20 = 11
				local var_364_21 = utf8.len(var_364_19)
				local var_364_22 = var_364_20 <= 0 and var_364_16 or var_364_16 * (var_364_21 / var_364_20)

				if var_364_22 > 0 and var_364_16 < var_364_22 then
					arg_361_1.talkMaxDuration = var_364_22

					if var_364_22 + var_364_15 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_22 + var_364_15
					end
				end

				arg_361_1.text_.text = var_364_19
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011087", "story_v_side_old_924011.awb") ~= 0 then
					local var_364_23 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011087", "story_v_side_old_924011.awb") / 1000

					if var_364_23 + var_364_15 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_23 + var_364_15
					end

					if var_364_18.prefab_name ~= "" and arg_361_1.actors_[var_364_18.prefab_name] ~= nil then
						local var_364_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_361_1.actors_[var_364_18.prefab_name].transform, "story_v_side_old_924011", "924011087", "story_v_side_old_924011.awb")

						arg_361_1:RecordAudio("924011087", var_364_24)
						arg_361_1:RecordAudio("924011087", var_364_24)
					else
						arg_361_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011087", "story_v_side_old_924011.awb")
					end

					arg_361_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011087", "story_v_side_old_924011.awb")
				end

				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_25 = math.max(var_364_16, arg_361_1.talkMaxDuration)

			if var_364_15 <= arg_361_1.time_ and arg_361_1.time_ < var_364_15 + var_364_25 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_15) / var_364_25

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_15 + var_364_25 and arg_361_1.time_ < var_364_15 + var_364_25 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_361_1:InitPlayNodeList()
	end,
	Play924011088 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 924011088
		arg_365_1.duration_ = 9.1

		local var_365_0 = {
			zh = 6.766,
			ja = 9.1
		}
		local var_365_1 = manager.audio:GetLocalizationFlag()

		if var_365_0[var_365_1] ~= nil then
			arg_365_1.duration_ = var_365_0[var_365_1]
		end

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play924011089(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = 0
			local var_368_1 = 0.6

			if var_368_0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_0 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				local var_368_2 = arg_365_1:FormatText(StoryNameCfg[613].name)

				arg_365_1.leftNameTxt_.text = var_368_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_3 = arg_365_1:GetWordFromCfg(924011088)
				local var_368_4 = arg_365_1:FormatText(var_368_3.content)

				arg_365_1.text_.text = var_368_4

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_5 = 24
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

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011088", "story_v_side_old_924011.awb") ~= 0 then
					local var_368_8 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011088", "story_v_side_old_924011.awb") / 1000

					if var_368_8 + var_368_0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_8 + var_368_0
					end

					if var_368_3.prefab_name ~= "" and arg_365_1.actors_[var_368_3.prefab_name] ~= nil then
						local var_368_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_3.prefab_name].transform, "story_v_side_old_924011", "924011088", "story_v_side_old_924011.awb")

						arg_365_1:RecordAudio("924011088", var_368_9)
						arg_365_1:RecordAudio("924011088", var_368_9)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011088", "story_v_side_old_924011.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011088", "story_v_side_old_924011.awb")
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
	Play924011089 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 924011089
		arg_369_1.duration_ = 5

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play924011090(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = arg_369_1.actors_["1020ui_story"]
			local var_372_1 = 0

			if var_372_1 < arg_369_1.time_ and arg_369_1.time_ <= var_372_1 + arg_372_0 and not isNil(var_372_0) and arg_369_1.var_.characterEffect1020ui_story == nil then
				arg_369_1.var_.characterEffect1020ui_story = var_372_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_372_2 = 0.200000002980232

			if var_372_1 <= arg_369_1.time_ and arg_369_1.time_ < var_372_1 + var_372_2 and not isNil(var_372_0) then
				local var_372_3 = (arg_369_1.time_ - var_372_1) / var_372_2

				if arg_369_1.var_.characterEffect1020ui_story and not isNil(var_372_0) then
					local var_372_4 = Mathf.Lerp(0, 0.5, var_372_3)

					arg_369_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_369_1.var_.characterEffect1020ui_story.fillRatio = var_372_4
				end
			end

			if arg_369_1.time_ >= var_372_1 + var_372_2 and arg_369_1.time_ < var_372_1 + var_372_2 + arg_372_0 and not isNil(var_372_0) and arg_369_1.var_.characterEffect1020ui_story then
				local var_372_5 = 0.5

				arg_369_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_369_1.var_.characterEffect1020ui_story.fillRatio = var_372_5
			end

			local var_372_6 = 0
			local var_372_7 = 0.75

			if var_372_6 < arg_369_1.time_ and arg_369_1.time_ <= var_372_6 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				local var_372_8 = arg_369_1:FormatText(StoryNameCfg[7].name)

				arg_369_1.leftNameTxt_.text = var_372_8

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

				local var_372_9 = arg_369_1:GetWordFromCfg(924011089)
				local var_372_10 = arg_369_1:FormatText(var_372_9.content)

				arg_369_1.text_.text = var_372_10

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_11 = 30
				local var_372_12 = utf8.len(var_372_10)
				local var_372_13 = var_372_11 <= 0 and var_372_7 or var_372_7 * (var_372_12 / var_372_11)

				if var_372_13 > 0 and var_372_7 < var_372_13 then
					arg_369_1.talkMaxDuration = var_372_13

					if var_372_13 + var_372_6 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_13 + var_372_6
					end
				end

				arg_369_1.text_.text = var_372_10
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)
				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_14 = math.max(var_372_7, arg_369_1.talkMaxDuration)

			if var_372_6 <= arg_369_1.time_ and arg_369_1.time_ < var_372_6 + var_372_14 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_6) / var_372_14

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_6 + var_372_14 and arg_369_1.time_ < var_372_6 + var_372_14 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play924011090 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 924011090
		arg_373_1.duration_ = 6.9

		local var_373_0 = {
			zh = 6.9,
			ja = 6.533
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
				arg_373_0:Play924011091(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			local var_376_0 = arg_373_1.actors_["1020ui_story"]
			local var_376_1 = 0

			if var_376_1 < arg_373_1.time_ and arg_373_1.time_ <= var_376_1 + arg_376_0 and not isNil(var_376_0) and arg_373_1.var_.characterEffect1020ui_story == nil then
				arg_373_1.var_.characterEffect1020ui_story = var_376_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_376_2 = 0.200000002980232

			if var_376_1 <= arg_373_1.time_ and arg_373_1.time_ < var_376_1 + var_376_2 and not isNil(var_376_0) then
				local var_376_3 = (arg_373_1.time_ - var_376_1) / var_376_2

				if arg_373_1.var_.characterEffect1020ui_story and not isNil(var_376_0) then
					arg_373_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_373_1.time_ >= var_376_1 + var_376_2 and arg_373_1.time_ < var_376_1 + var_376_2 + arg_376_0 and not isNil(var_376_0) and arg_373_1.var_.characterEffect1020ui_story then
				arg_373_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_376_4 = 0

			if var_376_4 < arg_373_1.time_ and arg_373_1.time_ <= var_376_4 + arg_376_0 then
				arg_373_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_deyiA", "EmotionTimelineAnimator")
			end

			local var_376_5 = 0

			if var_376_5 < arg_373_1.time_ and arg_373_1.time_ <= var_376_5 + arg_376_0 then
				arg_373_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020actionlink/1020action484")
			end

			local var_376_6 = 0
			local var_376_7 = 0.8

			if var_376_6 < arg_373_1.time_ and arg_373_1.time_ <= var_376_6 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				local var_376_8 = arg_373_1:FormatText(StoryNameCfg[613].name)

				arg_373_1.leftNameTxt_.text = var_376_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_9 = arg_373_1:GetWordFromCfg(924011090)
				local var_376_10 = arg_373_1:FormatText(var_376_9.content)

				arg_373_1.text_.text = var_376_10

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_11 = 32
				local var_376_12 = utf8.len(var_376_10)
				local var_376_13 = var_376_11 <= 0 and var_376_7 or var_376_7 * (var_376_12 / var_376_11)

				if var_376_13 > 0 and var_376_7 < var_376_13 then
					arg_373_1.talkMaxDuration = var_376_13

					if var_376_13 + var_376_6 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_13 + var_376_6
					end
				end

				arg_373_1.text_.text = var_376_10
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011090", "story_v_side_old_924011.awb") ~= 0 then
					local var_376_14 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011090", "story_v_side_old_924011.awb") / 1000

					if var_376_14 + var_376_6 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_14 + var_376_6
					end

					if var_376_9.prefab_name ~= "" and arg_373_1.actors_[var_376_9.prefab_name] ~= nil then
						local var_376_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_373_1.actors_[var_376_9.prefab_name].transform, "story_v_side_old_924011", "924011090", "story_v_side_old_924011.awb")

						arg_373_1:RecordAudio("924011090", var_376_15)
						arg_373_1:RecordAudio("924011090", var_376_15)
					else
						arg_373_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011090", "story_v_side_old_924011.awb")
					end

					arg_373_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011090", "story_v_side_old_924011.awb")
				end

				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_16 = math.max(var_376_7, arg_373_1.talkMaxDuration)

			if var_376_6 <= arg_373_1.time_ and arg_373_1.time_ < var_376_6 + var_376_16 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_6) / var_376_16

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_6 + var_376_16 and arg_373_1.time_ < var_376_6 + var_376_16 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {}

		arg_373_1:InitPlayNodeList()
	end,
	Play924011091 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 924011091
		arg_377_1.duration_ = 5

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play924011092(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = arg_377_1.actors_["1020ui_story"]
			local var_380_1 = 0

			if var_380_1 < arg_377_1.time_ and arg_377_1.time_ <= var_380_1 + arg_380_0 and not isNil(var_380_0) and arg_377_1.var_.characterEffect1020ui_story == nil then
				arg_377_1.var_.characterEffect1020ui_story = var_380_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_380_2 = 0.200000002980232

			if var_380_1 <= arg_377_1.time_ and arg_377_1.time_ < var_380_1 + var_380_2 and not isNil(var_380_0) then
				local var_380_3 = (arg_377_1.time_ - var_380_1) / var_380_2

				if arg_377_1.var_.characterEffect1020ui_story and not isNil(var_380_0) then
					local var_380_4 = Mathf.Lerp(0, 0.5, var_380_3)

					arg_377_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_377_1.var_.characterEffect1020ui_story.fillRatio = var_380_4
				end
			end

			if arg_377_1.time_ >= var_380_1 + var_380_2 and arg_377_1.time_ < var_380_1 + var_380_2 + arg_380_0 and not isNil(var_380_0) and arg_377_1.var_.characterEffect1020ui_story then
				local var_380_5 = 0.5

				arg_377_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_377_1.var_.characterEffect1020ui_story.fillRatio = var_380_5
			end

			local var_380_6 = 0
			local var_380_7 = 1.175

			if var_380_6 < arg_377_1.time_ and arg_377_1.time_ <= var_380_6 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				local var_380_8 = arg_377_1:FormatText(StoryNameCfg[7].name)

				arg_377_1.leftNameTxt_.text = var_380_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, true)
				arg_377_1.iconController_:SetSelectedState("hero")

				arg_377_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_377_1.callingController_:SetSelectedState("normal")

				arg_377_1.keyicon_.color = Color.New(1, 1, 1)
				arg_377_1.icon_.color = Color.New(1, 1, 1)

				local var_380_9 = arg_377_1:GetWordFromCfg(924011091)
				local var_380_10 = arg_377_1:FormatText(var_380_9.content)

				arg_377_1.text_.text = var_380_10

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_11 = 47
				local var_380_12 = utf8.len(var_380_10)
				local var_380_13 = var_380_11 <= 0 and var_380_7 or var_380_7 * (var_380_12 / var_380_11)

				if var_380_13 > 0 and var_380_7 < var_380_13 then
					arg_377_1.talkMaxDuration = var_380_13

					if var_380_13 + var_380_6 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_13 + var_380_6
					end
				end

				arg_377_1.text_.text = var_380_10
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)
				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_14 = math.max(var_380_7, arg_377_1.talkMaxDuration)

			if var_380_6 <= arg_377_1.time_ and arg_377_1.time_ < var_380_6 + var_380_14 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_6) / var_380_14

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_6 + var_380_14 and arg_377_1.time_ < var_380_6 + var_380_14 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {}

		arg_377_1:InitPlayNodeList()
	end,
	Play924011092 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 924011092
		arg_381_1.duration_ = 3.27

		local var_381_0 = {
			zh = 2.466,
			ja = 3.266
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
				arg_381_0:Play924011093(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			local var_384_0 = arg_381_1.actors_["1020ui_story"]
			local var_384_1 = 0

			if var_384_1 < arg_381_1.time_ and arg_381_1.time_ <= var_384_1 + arg_384_0 and not isNil(var_384_0) and arg_381_1.var_.characterEffect1020ui_story == nil then
				arg_381_1.var_.characterEffect1020ui_story = var_384_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_384_2 = 0.200000002980232

			if var_384_1 <= arg_381_1.time_ and arg_381_1.time_ < var_384_1 + var_384_2 and not isNil(var_384_0) then
				local var_384_3 = (arg_381_1.time_ - var_384_1) / var_384_2

				if arg_381_1.var_.characterEffect1020ui_story and not isNil(var_384_0) then
					arg_381_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_381_1.time_ >= var_384_1 + var_384_2 and arg_381_1.time_ < var_384_1 + var_384_2 + arg_384_0 and not isNil(var_384_0) and arg_381_1.var_.characterEffect1020ui_story then
				arg_381_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_384_4 = 0

			if var_384_4 < arg_381_1.time_ and arg_381_1.time_ <= var_384_4 + arg_384_0 then
				arg_381_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_384_5 = 0

			if var_384_5 < arg_381_1.time_ and arg_381_1.time_ <= var_384_5 + arg_384_0 then
				arg_381_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action4_2")
			end

			local var_384_6 = 0
			local var_384_7 = 0.175

			if var_384_6 < arg_381_1.time_ and arg_381_1.time_ <= var_384_6 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				local var_384_8 = arg_381_1:FormatText(StoryNameCfg[613].name)

				arg_381_1.leftNameTxt_.text = var_384_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_9 = arg_381_1:GetWordFromCfg(924011092)
				local var_384_10 = arg_381_1:FormatText(var_384_9.content)

				arg_381_1.text_.text = var_384_10

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_11 = 7
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

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011092", "story_v_side_old_924011.awb") ~= 0 then
					local var_384_14 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011092", "story_v_side_old_924011.awb") / 1000

					if var_384_14 + var_384_6 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_14 + var_384_6
					end

					if var_384_9.prefab_name ~= "" and arg_381_1.actors_[var_384_9.prefab_name] ~= nil then
						local var_384_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_381_1.actors_[var_384_9.prefab_name].transform, "story_v_side_old_924011", "924011092", "story_v_side_old_924011.awb")

						arg_381_1:RecordAudio("924011092", var_384_15)
						arg_381_1:RecordAudio("924011092", var_384_15)
					else
						arg_381_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011092", "story_v_side_old_924011.awb")
					end

					arg_381_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011092", "story_v_side_old_924011.awb")
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
	Play924011093 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 924011093
		arg_385_1.duration_ = 5

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play924011094(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			local var_388_0 = arg_385_1.actors_["1020ui_story"]
			local var_388_1 = 0

			if var_388_1 < arg_385_1.time_ and arg_385_1.time_ <= var_388_1 + arg_388_0 and not isNil(var_388_0) and arg_385_1.var_.characterEffect1020ui_story == nil then
				arg_385_1.var_.characterEffect1020ui_story = var_388_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_388_2 = 0.200000002980232

			if var_388_1 <= arg_385_1.time_ and arg_385_1.time_ < var_388_1 + var_388_2 and not isNil(var_388_0) then
				local var_388_3 = (arg_385_1.time_ - var_388_1) / var_388_2

				if arg_385_1.var_.characterEffect1020ui_story and not isNil(var_388_0) then
					local var_388_4 = Mathf.Lerp(0, 0.5, var_388_3)

					arg_385_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_385_1.var_.characterEffect1020ui_story.fillRatio = var_388_4
				end
			end

			if arg_385_1.time_ >= var_388_1 + var_388_2 and arg_385_1.time_ < var_388_1 + var_388_2 + arg_388_0 and not isNil(var_388_0) and arg_385_1.var_.characterEffect1020ui_story then
				local var_388_5 = 0.5

				arg_385_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_385_1.var_.characterEffect1020ui_story.fillRatio = var_388_5
			end

			local var_388_6 = 0
			local var_388_7 = 0.325

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

				local var_388_9 = arg_385_1:GetWordFromCfg(924011093)
				local var_388_10 = arg_385_1:FormatText(var_388_9.content)

				arg_385_1.text_.text = var_388_10

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_11 = 13
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
	Play924011094 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 924011094
		arg_389_1.duration_ = 7

		local var_389_0 = {
			zh = 5,
			ja = 7
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
				arg_389_0:Play924011095(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			local var_392_0 = arg_389_1.actors_["1020ui_story"]
			local var_392_1 = 0

			if var_392_1 < arg_389_1.time_ and arg_389_1.time_ <= var_392_1 + arg_392_0 and not isNil(var_392_0) and arg_389_1.var_.characterEffect1020ui_story == nil then
				arg_389_1.var_.characterEffect1020ui_story = var_392_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_392_2 = 0.200000002980232

			if var_392_1 <= arg_389_1.time_ and arg_389_1.time_ < var_392_1 + var_392_2 and not isNil(var_392_0) then
				local var_392_3 = (arg_389_1.time_ - var_392_1) / var_392_2

				if arg_389_1.var_.characterEffect1020ui_story and not isNil(var_392_0) then
					arg_389_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_389_1.time_ >= var_392_1 + var_392_2 and arg_389_1.time_ < var_392_1 + var_392_2 + arg_392_0 and not isNil(var_392_0) and arg_389_1.var_.characterEffect1020ui_story then
				arg_389_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_392_4 = 0

			if var_392_4 < arg_389_1.time_ and arg_389_1.time_ <= var_392_4 + arg_392_0 then
				arg_389_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action1_1")
			end

			local var_392_5 = 0
			local var_392_6 = 0.5

			if var_392_5 < arg_389_1.time_ and arg_389_1.time_ <= var_392_5 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				local var_392_7 = arg_389_1:FormatText(StoryNameCfg[613].name)

				arg_389_1.leftNameTxt_.text = var_392_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_8 = arg_389_1:GetWordFromCfg(924011094)
				local var_392_9 = arg_389_1:FormatText(var_392_8.content)

				arg_389_1.text_.text = var_392_9

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_10 = 20
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

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011094", "story_v_side_old_924011.awb") ~= 0 then
					local var_392_13 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011094", "story_v_side_old_924011.awb") / 1000

					if var_392_13 + var_392_5 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_13 + var_392_5
					end

					if var_392_8.prefab_name ~= "" and arg_389_1.actors_[var_392_8.prefab_name] ~= nil then
						local var_392_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_389_1.actors_[var_392_8.prefab_name].transform, "story_v_side_old_924011", "924011094", "story_v_side_old_924011.awb")

						arg_389_1:RecordAudio("924011094", var_392_14)
						arg_389_1:RecordAudio("924011094", var_392_14)
					else
						arg_389_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011094", "story_v_side_old_924011.awb")
					end

					arg_389_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011094", "story_v_side_old_924011.awb")
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
	Play924011095 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 924011095
		arg_393_1.duration_ = 5

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play924011096(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = arg_393_1.actors_["1020ui_story"]
			local var_396_1 = 0

			if var_396_1 < arg_393_1.time_ and arg_393_1.time_ <= var_396_1 + arg_396_0 and not isNil(var_396_0) and arg_393_1.var_.characterEffect1020ui_story == nil then
				arg_393_1.var_.characterEffect1020ui_story = var_396_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_396_2 = 0.200000002980232

			if var_396_1 <= arg_393_1.time_ and arg_393_1.time_ < var_396_1 + var_396_2 and not isNil(var_396_0) then
				local var_396_3 = (arg_393_1.time_ - var_396_1) / var_396_2

				if arg_393_1.var_.characterEffect1020ui_story and not isNil(var_396_0) then
					local var_396_4 = Mathf.Lerp(0, 0.5, var_396_3)

					arg_393_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_393_1.var_.characterEffect1020ui_story.fillRatio = var_396_4
				end
			end

			if arg_393_1.time_ >= var_396_1 + var_396_2 and arg_393_1.time_ < var_396_1 + var_396_2 + arg_396_0 and not isNil(var_396_0) and arg_393_1.var_.characterEffect1020ui_story then
				local var_396_5 = 0.5

				arg_393_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_393_1.var_.characterEffect1020ui_story.fillRatio = var_396_5
			end

			local var_396_6 = 0
			local var_396_7 = 0.2

			if var_396_6 < arg_393_1.time_ and arg_393_1.time_ <= var_396_6 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				local var_396_8 = arg_393_1:FormatText(StoryNameCfg[7].name)

				arg_393_1.leftNameTxt_.text = var_396_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, true)
				arg_393_1.iconController_:SetSelectedState("hero")

				arg_393_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_393_1.callingController_:SetSelectedState("normal")

				arg_393_1.keyicon_.color = Color.New(1, 1, 1)
				arg_393_1.icon_.color = Color.New(1, 1, 1)

				local var_396_9 = arg_393_1:GetWordFromCfg(924011095)
				local var_396_10 = arg_393_1:FormatText(var_396_9.content)

				arg_393_1.text_.text = var_396_10

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_11 = 8
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
				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_14 = math.max(var_396_7, arg_393_1.talkMaxDuration)

			if var_396_6 <= arg_393_1.time_ and arg_393_1.time_ < var_396_6 + var_396_14 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_6) / var_396_14

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_6 + var_396_14 and arg_393_1.time_ < var_396_6 + var_396_14 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play924011096 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 924011096
		arg_397_1.duration_ = 10.07

		local var_397_0 = {
			zh = 5.6,
			ja = 10.066
		}
		local var_397_1 = manager.audio:GetLocalizationFlag()

		if var_397_0[var_397_1] ~= nil then
			arg_397_1.duration_ = var_397_0[var_397_1]
		end

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play924011097(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = arg_397_1.actors_["1020ui_story"]
			local var_400_1 = 0

			if var_400_1 < arg_397_1.time_ and arg_397_1.time_ <= var_400_1 + arg_400_0 and not isNil(var_400_0) and arg_397_1.var_.characterEffect1020ui_story == nil then
				arg_397_1.var_.characterEffect1020ui_story = var_400_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_400_2 = 0.200000002980232

			if var_400_1 <= arg_397_1.time_ and arg_397_1.time_ < var_400_1 + var_400_2 and not isNil(var_400_0) then
				local var_400_3 = (arg_397_1.time_ - var_400_1) / var_400_2

				if arg_397_1.var_.characterEffect1020ui_story and not isNil(var_400_0) then
					arg_397_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_397_1.time_ >= var_400_1 + var_400_2 and arg_397_1.time_ < var_400_1 + var_400_2 + arg_400_0 and not isNil(var_400_0) and arg_397_1.var_.characterEffect1020ui_story then
				arg_397_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_400_4 = 0

			if var_400_4 < arg_397_1.time_ and arg_397_1.time_ <= var_400_4 + arg_400_0 then
				arg_397_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action3_1")
			end

			local var_400_5 = 0
			local var_400_6 = 0.7

			if var_400_5 < arg_397_1.time_ and arg_397_1.time_ <= var_400_5 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				local var_400_7 = arg_397_1:FormatText(StoryNameCfg[613].name)

				arg_397_1.leftNameTxt_.text = var_400_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_8 = arg_397_1:GetWordFromCfg(924011096)
				local var_400_9 = arg_397_1:FormatText(var_400_8.content)

				arg_397_1.text_.text = var_400_9

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_10 = 28
				local var_400_11 = utf8.len(var_400_9)
				local var_400_12 = var_400_10 <= 0 and var_400_6 or var_400_6 * (var_400_11 / var_400_10)

				if var_400_12 > 0 and var_400_6 < var_400_12 then
					arg_397_1.talkMaxDuration = var_400_12

					if var_400_12 + var_400_5 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_12 + var_400_5
					end
				end

				arg_397_1.text_.text = var_400_9
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011096", "story_v_side_old_924011.awb") ~= 0 then
					local var_400_13 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011096", "story_v_side_old_924011.awb") / 1000

					if var_400_13 + var_400_5 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_13 + var_400_5
					end

					if var_400_8.prefab_name ~= "" and arg_397_1.actors_[var_400_8.prefab_name] ~= nil then
						local var_400_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_397_1.actors_[var_400_8.prefab_name].transform, "story_v_side_old_924011", "924011096", "story_v_side_old_924011.awb")

						arg_397_1:RecordAudio("924011096", var_400_14)
						arg_397_1:RecordAudio("924011096", var_400_14)
					else
						arg_397_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011096", "story_v_side_old_924011.awb")
					end

					arg_397_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011096", "story_v_side_old_924011.awb")
				end

				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_15 = math.max(var_400_6, arg_397_1.talkMaxDuration)

			if var_400_5 <= arg_397_1.time_ and arg_397_1.time_ < var_400_5 + var_400_15 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_5) / var_400_15

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_5 + var_400_15 and arg_397_1.time_ < var_400_5 + var_400_15 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play924011097 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 924011097
		arg_401_1.duration_ = 5

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play924011098(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = arg_401_1.actors_["1020ui_story"]
			local var_404_1 = 0

			if var_404_1 < arg_401_1.time_ and arg_401_1.time_ <= var_404_1 + arg_404_0 and not isNil(var_404_0) and arg_401_1.var_.characterEffect1020ui_story == nil then
				arg_401_1.var_.characterEffect1020ui_story = var_404_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_404_2 = 0.200000002980232

			if var_404_1 <= arg_401_1.time_ and arg_401_1.time_ < var_404_1 + var_404_2 and not isNil(var_404_0) then
				local var_404_3 = (arg_401_1.time_ - var_404_1) / var_404_2

				if arg_401_1.var_.characterEffect1020ui_story and not isNil(var_404_0) then
					local var_404_4 = Mathf.Lerp(0, 0.5, var_404_3)

					arg_401_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_401_1.var_.characterEffect1020ui_story.fillRatio = var_404_4
				end
			end

			if arg_401_1.time_ >= var_404_1 + var_404_2 and arg_401_1.time_ < var_404_1 + var_404_2 + arg_404_0 and not isNil(var_404_0) and arg_401_1.var_.characterEffect1020ui_story then
				local var_404_5 = 0.5

				arg_401_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_401_1.var_.characterEffect1020ui_story.fillRatio = var_404_5
			end

			local var_404_6 = 0
			local var_404_7 = 0.45

			if var_404_6 < arg_401_1.time_ and arg_401_1.time_ <= var_404_6 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				local var_404_8 = arg_401_1:FormatText(StoryNameCfg[7].name)

				arg_401_1.leftNameTxt_.text = var_404_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, true)
				arg_401_1.iconController_:SetSelectedState("hero")

				arg_401_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_401_1.callingController_:SetSelectedState("normal")

				arg_401_1.keyicon_.color = Color.New(1, 1, 1)
				arg_401_1.icon_.color = Color.New(1, 1, 1)

				local var_404_9 = arg_401_1:GetWordFromCfg(924011097)
				local var_404_10 = arg_401_1:FormatText(var_404_9.content)

				arg_401_1.text_.text = var_404_10

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_11 = 18
				local var_404_12 = utf8.len(var_404_10)
				local var_404_13 = var_404_11 <= 0 and var_404_7 or var_404_7 * (var_404_12 / var_404_11)

				if var_404_13 > 0 and var_404_7 < var_404_13 then
					arg_401_1.talkMaxDuration = var_404_13

					if var_404_13 + var_404_6 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_13 + var_404_6
					end
				end

				arg_401_1.text_.text = var_404_10
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)
				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_14 = math.max(var_404_7, arg_401_1.talkMaxDuration)

			if var_404_6 <= arg_401_1.time_ and arg_401_1.time_ < var_404_6 + var_404_14 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_6) / var_404_14

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_6 + var_404_14 and arg_401_1.time_ < var_404_6 + var_404_14 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play924011098 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 924011098
		arg_405_1.duration_ = 12.3

		local var_405_0 = {
			zh = 8.8,
			ja = 12.3
		}
		local var_405_1 = manager.audio:GetLocalizationFlag()

		if var_405_0[var_405_1] ~= nil then
			arg_405_1.duration_ = var_405_0[var_405_1]
		end

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play924011099(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = arg_405_1.actors_["1020ui_story"].transform
			local var_408_1 = 0

			if var_408_1 < arg_405_1.time_ and arg_405_1.time_ <= var_408_1 + arg_408_0 then
				arg_405_1.var_.moveOldPos1020ui_story = var_408_0.localPosition
			end

			local var_408_2 = 0.001

			if var_408_1 <= arg_405_1.time_ and arg_405_1.time_ < var_408_1 + var_408_2 then
				local var_408_3 = (arg_405_1.time_ - var_408_1) / var_408_2
				local var_408_4 = Vector3.New(0, -0.85, -6.25)

				var_408_0.localPosition = Vector3.Lerp(arg_405_1.var_.moveOldPos1020ui_story, var_408_4, var_408_3)

				local var_408_5 = manager.ui.mainCamera.transform.position - var_408_0.position

				var_408_0.forward = Vector3.New(var_408_5.x, var_408_5.y, var_408_5.z)

				local var_408_6 = var_408_0.localEulerAngles

				var_408_6.z = 0
				var_408_6.x = 0
				var_408_0.localEulerAngles = var_408_6
			end

			if arg_405_1.time_ >= var_408_1 + var_408_2 and arg_405_1.time_ < var_408_1 + var_408_2 + arg_408_0 then
				var_408_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_408_7 = manager.ui.mainCamera.transform.position - var_408_0.position

				var_408_0.forward = Vector3.New(var_408_7.x, var_408_7.y, var_408_7.z)

				local var_408_8 = var_408_0.localEulerAngles

				var_408_8.z = 0
				var_408_8.x = 0
				var_408_0.localEulerAngles = var_408_8
			end

			local var_408_9 = arg_405_1.actors_["1020ui_story"]
			local var_408_10 = 0

			if var_408_10 < arg_405_1.time_ and arg_405_1.time_ <= var_408_10 + arg_408_0 and not isNil(var_408_9) and arg_405_1.var_.characterEffect1020ui_story == nil then
				arg_405_1.var_.characterEffect1020ui_story = var_408_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_408_11 = 0.200000002980232

			if var_408_10 <= arg_405_1.time_ and arg_405_1.time_ < var_408_10 + var_408_11 and not isNil(var_408_9) then
				local var_408_12 = (arg_405_1.time_ - var_408_10) / var_408_11

				if arg_405_1.var_.characterEffect1020ui_story and not isNil(var_408_9) then
					arg_405_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_405_1.time_ >= var_408_10 + var_408_11 and arg_405_1.time_ < var_408_10 + var_408_11 + arg_408_0 and not isNil(var_408_9) and arg_405_1.var_.characterEffect1020ui_story then
				arg_405_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_408_13 = 0

			if var_408_13 < arg_405_1.time_ and arg_405_1.time_ <= var_408_13 + arg_408_0 then
				arg_405_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_408_14 = 0

			if var_408_14 < arg_405_1.time_ and arg_405_1.time_ <= var_408_14 + arg_408_0 then
				arg_405_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020actionlink/1020action436")
			end

			local var_408_15 = 0
			local var_408_16 = 0.725

			if var_408_15 < arg_405_1.time_ and arg_405_1.time_ <= var_408_15 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, true)

				local var_408_17 = arg_405_1:FormatText(StoryNameCfg[613].name)

				arg_405_1.leftNameTxt_.text = var_408_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_18 = arg_405_1:GetWordFromCfg(924011098)
				local var_408_19 = arg_405_1:FormatText(var_408_18.content)

				arg_405_1.text_.text = var_408_19

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_20 = 29
				local var_408_21 = utf8.len(var_408_19)
				local var_408_22 = var_408_20 <= 0 and var_408_16 or var_408_16 * (var_408_21 / var_408_20)

				if var_408_22 > 0 and var_408_16 < var_408_22 then
					arg_405_1.talkMaxDuration = var_408_22

					if var_408_22 + var_408_15 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_22 + var_408_15
					end
				end

				arg_405_1.text_.text = var_408_19
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011098", "story_v_side_old_924011.awb") ~= 0 then
					local var_408_23 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011098", "story_v_side_old_924011.awb") / 1000

					if var_408_23 + var_408_15 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_23 + var_408_15
					end

					if var_408_18.prefab_name ~= "" and arg_405_1.actors_[var_408_18.prefab_name] ~= nil then
						local var_408_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_405_1.actors_[var_408_18.prefab_name].transform, "story_v_side_old_924011", "924011098", "story_v_side_old_924011.awb")

						arg_405_1:RecordAudio("924011098", var_408_24)
						arg_405_1:RecordAudio("924011098", var_408_24)
					else
						arg_405_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011098", "story_v_side_old_924011.awb")
					end

					arg_405_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011098", "story_v_side_old_924011.awb")
				end

				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_25 = math.max(var_408_16, arg_405_1.talkMaxDuration)

			if var_408_15 <= arg_405_1.time_ and arg_405_1.time_ < var_408_15 + var_408_25 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_15) / var_408_25

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_15 + var_408_25 and arg_405_1.time_ < var_408_15 + var_408_25 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_405_1:InitPlayNodeList()
	end,
	Play924011099 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 924011099
		arg_409_1.duration_ = 5

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play924011100(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			local var_412_0 = arg_409_1.actors_["1020ui_story"]
			local var_412_1 = 0

			if var_412_1 < arg_409_1.time_ and arg_409_1.time_ <= var_412_1 + arg_412_0 and not isNil(var_412_0) and arg_409_1.var_.characterEffect1020ui_story == nil then
				arg_409_1.var_.characterEffect1020ui_story = var_412_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_412_2 = 0.200000002980232

			if var_412_1 <= arg_409_1.time_ and arg_409_1.time_ < var_412_1 + var_412_2 and not isNil(var_412_0) then
				local var_412_3 = (arg_409_1.time_ - var_412_1) / var_412_2

				if arg_409_1.var_.characterEffect1020ui_story and not isNil(var_412_0) then
					local var_412_4 = Mathf.Lerp(0, 0.5, var_412_3)

					arg_409_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_409_1.var_.characterEffect1020ui_story.fillRatio = var_412_4
				end
			end

			if arg_409_1.time_ >= var_412_1 + var_412_2 and arg_409_1.time_ < var_412_1 + var_412_2 + arg_412_0 and not isNil(var_412_0) and arg_409_1.var_.characterEffect1020ui_story then
				local var_412_5 = 0.5

				arg_409_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_409_1.var_.characterEffect1020ui_story.fillRatio = var_412_5
			end

			local var_412_6 = 0
			local var_412_7 = 0.2

			if var_412_6 < arg_409_1.time_ and arg_409_1.time_ <= var_412_6 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				local var_412_8 = arg_409_1:FormatText(StoryNameCfg[7].name)

				arg_409_1.leftNameTxt_.text = var_412_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, true)
				arg_409_1.iconController_:SetSelectedState("hero")

				arg_409_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_409_1.callingController_:SetSelectedState("normal")

				arg_409_1.keyicon_.color = Color.New(1, 1, 1)
				arg_409_1.icon_.color = Color.New(1, 1, 1)

				local var_412_9 = arg_409_1:GetWordFromCfg(924011099)
				local var_412_10 = arg_409_1:FormatText(var_412_9.content)

				arg_409_1.text_.text = var_412_10

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_11 = 8
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
				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_14 = math.max(var_412_7, arg_409_1.talkMaxDuration)

			if var_412_6 <= arg_409_1.time_ and arg_409_1.time_ < var_412_6 + var_412_14 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_6) / var_412_14

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_6 + var_412_14 and arg_409_1.time_ < var_412_6 + var_412_14 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {}

		arg_409_1:InitPlayNodeList()
	end,
	Play924011100 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 924011100
		arg_413_1.duration_ = 5.2

		local var_413_0 = {
			zh = 3.733,
			ja = 5.2
		}
		local var_413_1 = manager.audio:GetLocalizationFlag()

		if var_413_0[var_413_1] ~= nil then
			arg_413_1.duration_ = var_413_0[var_413_1]
		end

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play924011101(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			local var_416_0 = arg_413_1.actors_["1020ui_story"]
			local var_416_1 = 0

			if var_416_1 < arg_413_1.time_ and arg_413_1.time_ <= var_416_1 + arg_416_0 and not isNil(var_416_0) and arg_413_1.var_.characterEffect1020ui_story == nil then
				arg_413_1.var_.characterEffect1020ui_story = var_416_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_416_2 = 0.200000002980232

			if var_416_1 <= arg_413_1.time_ and arg_413_1.time_ < var_416_1 + var_416_2 and not isNil(var_416_0) then
				local var_416_3 = (arg_413_1.time_ - var_416_1) / var_416_2

				if arg_413_1.var_.characterEffect1020ui_story and not isNil(var_416_0) then
					arg_413_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_413_1.time_ >= var_416_1 + var_416_2 and arg_413_1.time_ < var_416_1 + var_416_2 + arg_416_0 and not isNil(var_416_0) and arg_413_1.var_.characterEffect1020ui_story then
				arg_413_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_416_4 = 0

			if var_416_4 < arg_413_1.time_ and arg_413_1.time_ <= var_416_4 + arg_416_0 then
				arg_413_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020actionlink/1020action463")
			end

			local var_416_5 = 0
			local var_416_6 = 0.35

			if var_416_5 < arg_413_1.time_ and arg_413_1.time_ <= var_416_5 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, true)

				local var_416_7 = arg_413_1:FormatText(StoryNameCfg[613].name)

				arg_413_1.leftNameTxt_.text = var_416_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_8 = arg_413_1:GetWordFromCfg(924011100)
				local var_416_9 = arg_413_1:FormatText(var_416_8.content)

				arg_413_1.text_.text = var_416_9

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_10 = 14
				local var_416_11 = utf8.len(var_416_9)
				local var_416_12 = var_416_10 <= 0 and var_416_6 or var_416_6 * (var_416_11 / var_416_10)

				if var_416_12 > 0 and var_416_6 < var_416_12 then
					arg_413_1.talkMaxDuration = var_416_12

					if var_416_12 + var_416_5 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_12 + var_416_5
					end
				end

				arg_413_1.text_.text = var_416_9
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011100", "story_v_side_old_924011.awb") ~= 0 then
					local var_416_13 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011100", "story_v_side_old_924011.awb") / 1000

					if var_416_13 + var_416_5 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_13 + var_416_5
					end

					if var_416_8.prefab_name ~= "" and arg_413_1.actors_[var_416_8.prefab_name] ~= nil then
						local var_416_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_413_1.actors_[var_416_8.prefab_name].transform, "story_v_side_old_924011", "924011100", "story_v_side_old_924011.awb")

						arg_413_1:RecordAudio("924011100", var_416_14)
						arg_413_1:RecordAudio("924011100", var_416_14)
					else
						arg_413_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011100", "story_v_side_old_924011.awb")
					end

					arg_413_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011100", "story_v_side_old_924011.awb")
				end

				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_15 = math.max(var_416_6, arg_413_1.talkMaxDuration)

			if var_416_5 <= arg_413_1.time_ and arg_413_1.time_ < var_416_5 + var_416_15 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_5) / var_416_15

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_5 + var_416_15 and arg_413_1.time_ < var_416_5 + var_416_15 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {}

		arg_413_1:InitPlayNodeList()
	end,
	Play924011101 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 924011101
		arg_417_1.duration_ = 1

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"

			SetActive(arg_417_1.choicesGo_, true)

			for iter_418_0, iter_418_1 in ipairs(arg_417_1.choices_) do
				local var_418_0 = iter_418_0 <= 1

				SetActive(iter_418_1.go, var_418_0)
			end

			arg_417_1.choices_[1].txt.text = arg_417_1:FormatText(StoryChoiceCfg[1199].name)
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play924011102(arg_417_1)
			end

			arg_417_1:RecordChoiceLog(924011101, 1199)
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			local var_420_0 = arg_417_1.actors_["1020ui_story"]
			local var_420_1 = 0

			if var_420_1 < arg_417_1.time_ and arg_417_1.time_ <= var_420_1 + arg_420_0 and not isNil(var_420_0) and arg_417_1.var_.characterEffect1020ui_story == nil then
				arg_417_1.var_.characterEffect1020ui_story = var_420_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_420_2 = 0.200000002980232

			if var_420_1 <= arg_417_1.time_ and arg_417_1.time_ < var_420_1 + var_420_2 and not isNil(var_420_0) then
				local var_420_3 = (arg_417_1.time_ - var_420_1) / var_420_2

				if arg_417_1.var_.characterEffect1020ui_story and not isNil(var_420_0) then
					local var_420_4 = Mathf.Lerp(0, 0.5, var_420_3)

					arg_417_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_417_1.var_.characterEffect1020ui_story.fillRatio = var_420_4
				end
			end

			if arg_417_1.time_ >= var_420_1 + var_420_2 and arg_417_1.time_ < var_420_1 + var_420_2 + arg_420_0 and not isNil(var_420_0) and arg_417_1.var_.characterEffect1020ui_story then
				local var_420_5 = 0.5

				arg_417_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_417_1.var_.characterEffect1020ui_story.fillRatio = var_420_5
			end

			local var_420_6 = 0

			if var_420_6 < arg_417_1.time_ and arg_417_1.time_ <= var_420_6 + arg_420_0 then
				arg_417_1.allBtn_.enabled = false
			end

			local var_420_7 = 0.6

			if arg_417_1.time_ >= var_420_6 + var_420_7 and arg_417_1.time_ < var_420_6 + var_420_7 + arg_420_0 then
				arg_417_1.allBtn_.enabled = true
			end
		end

		arg_417_1.nodeConfigList_ = {}

		arg_417_1:InitPlayNodeList()
	end,
	Play924011102 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 924011102
		arg_421_1.duration_ = 7.3

		local var_421_0 = {
			zh = 4.533,
			ja = 7.3
		}
		local var_421_1 = manager.audio:GetLocalizationFlag()

		if var_421_0[var_421_1] ~= nil then
			arg_421_1.duration_ = var_421_0[var_421_1]
		end

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play924011103(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			local var_424_0 = arg_421_1.actors_["1020ui_story"].transform
			local var_424_1 = 0

			if var_424_1 < arg_421_1.time_ and arg_421_1.time_ <= var_424_1 + arg_424_0 then
				arg_421_1.var_.moveOldPos1020ui_story = var_424_0.localPosition
			end

			local var_424_2 = 0.001

			if var_424_1 <= arg_421_1.time_ and arg_421_1.time_ < var_424_1 + var_424_2 then
				local var_424_3 = (arg_421_1.time_ - var_424_1) / var_424_2
				local var_424_4 = Vector3.New(0, -0.85, -6.25)

				var_424_0.localPosition = Vector3.Lerp(arg_421_1.var_.moveOldPos1020ui_story, var_424_4, var_424_3)

				local var_424_5 = manager.ui.mainCamera.transform.position - var_424_0.position

				var_424_0.forward = Vector3.New(var_424_5.x, var_424_5.y, var_424_5.z)

				local var_424_6 = var_424_0.localEulerAngles

				var_424_6.z = 0
				var_424_6.x = 0
				var_424_0.localEulerAngles = var_424_6
			end

			if arg_421_1.time_ >= var_424_1 + var_424_2 and arg_421_1.time_ < var_424_1 + var_424_2 + arg_424_0 then
				var_424_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_424_7 = manager.ui.mainCamera.transform.position - var_424_0.position

				var_424_0.forward = Vector3.New(var_424_7.x, var_424_7.y, var_424_7.z)

				local var_424_8 = var_424_0.localEulerAngles

				var_424_8.z = 0
				var_424_8.x = 0
				var_424_0.localEulerAngles = var_424_8
			end

			local var_424_9 = arg_421_1.actors_["1020ui_story"]
			local var_424_10 = 0

			if var_424_10 < arg_421_1.time_ and arg_421_1.time_ <= var_424_10 + arg_424_0 and not isNil(var_424_9) and arg_421_1.var_.characterEffect1020ui_story == nil then
				arg_421_1.var_.characterEffect1020ui_story = var_424_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_424_11 = 0.200000002980232

			if var_424_10 <= arg_421_1.time_ and arg_421_1.time_ < var_424_10 + var_424_11 and not isNil(var_424_9) then
				local var_424_12 = (arg_421_1.time_ - var_424_10) / var_424_11

				if arg_421_1.var_.characterEffect1020ui_story and not isNil(var_424_9) then
					arg_421_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_421_1.time_ >= var_424_10 + var_424_11 and arg_421_1.time_ < var_424_10 + var_424_11 + arg_424_0 and not isNil(var_424_9) and arg_421_1.var_.characterEffect1020ui_story then
				arg_421_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_424_13 = 0

			if var_424_13 < arg_421_1.time_ and arg_421_1.time_ <= var_424_13 + arg_424_0 then
				arg_421_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_424_14 = 0

			if var_424_14 < arg_421_1.time_ and arg_421_1.time_ <= var_424_14 + arg_424_0 then
				arg_421_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020actionlink/1020action438")
			end

			local var_424_15 = 0
			local var_424_16 = 0.375

			if var_424_15 < arg_421_1.time_ and arg_421_1.time_ <= var_424_15 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, true)

				local var_424_17 = arg_421_1:FormatText(StoryNameCfg[613].name)

				arg_421_1.leftNameTxt_.text = var_424_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_421_1.leftNameTxt_.transform)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1.leftNameTxt_.text)
				SetActive(arg_421_1.iconTrs_.gameObject, false)
				arg_421_1.callingController_:SetSelectedState("normal")

				local var_424_18 = arg_421_1:GetWordFromCfg(924011102)
				local var_424_19 = arg_421_1:FormatText(var_424_18.content)

				arg_421_1.text_.text = var_424_19

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_20 = 15
				local var_424_21 = utf8.len(var_424_19)
				local var_424_22 = var_424_20 <= 0 and var_424_16 or var_424_16 * (var_424_21 / var_424_20)

				if var_424_22 > 0 and var_424_16 < var_424_22 then
					arg_421_1.talkMaxDuration = var_424_22

					if var_424_22 + var_424_15 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_22 + var_424_15
					end
				end

				arg_421_1.text_.text = var_424_19
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011102", "story_v_side_old_924011.awb") ~= 0 then
					local var_424_23 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011102", "story_v_side_old_924011.awb") / 1000

					if var_424_23 + var_424_15 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_23 + var_424_15
					end

					if var_424_18.prefab_name ~= "" and arg_421_1.actors_[var_424_18.prefab_name] ~= nil then
						local var_424_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_421_1.actors_[var_424_18.prefab_name].transform, "story_v_side_old_924011", "924011102", "story_v_side_old_924011.awb")

						arg_421_1:RecordAudio("924011102", var_424_24)
						arg_421_1:RecordAudio("924011102", var_424_24)
					else
						arg_421_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011102", "story_v_side_old_924011.awb")
					end

					arg_421_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011102", "story_v_side_old_924011.awb")
				end

				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_25 = math.max(var_424_16, arg_421_1.talkMaxDuration)

			if var_424_15 <= arg_421_1.time_ and arg_421_1.time_ < var_424_15 + var_424_25 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_15) / var_424_25

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_15 + var_424_25 and arg_421_1.time_ < var_424_15 + var_424_25 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_421_1:InitPlayNodeList()
	end,
	Play924011103 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 924011103
		arg_425_1.duration_ = 1

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"

			SetActive(arg_425_1.choicesGo_, true)

			for iter_426_0, iter_426_1 in ipairs(arg_425_1.choices_) do
				local var_426_0 = iter_426_0 <= 2

				SetActive(iter_426_1.go, var_426_0)
			end

			arg_425_1.choices_[1].txt.text = arg_425_1:FormatText(StoryChoiceCfg[1200].name)
			arg_425_1.choices_[2].txt.text = arg_425_1:FormatText(StoryChoiceCfg[1201].name)
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play924011104(arg_425_1)
			end

			if arg_427_0 == 2 then
				arg_425_0:Play924011104(arg_425_1)
			end

			arg_425_1:RecordChoiceLog(924011103, 1200, 1201)
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			local var_428_0 = arg_425_1.actors_["1020ui_story"]
			local var_428_1 = 0

			if var_428_1 < arg_425_1.time_ and arg_425_1.time_ <= var_428_1 + arg_428_0 and not isNil(var_428_0) and arg_425_1.var_.characterEffect1020ui_story == nil then
				arg_425_1.var_.characterEffect1020ui_story = var_428_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_428_2 = 0.200000002980232

			if var_428_1 <= arg_425_1.time_ and arg_425_1.time_ < var_428_1 + var_428_2 and not isNil(var_428_0) then
				local var_428_3 = (arg_425_1.time_ - var_428_1) / var_428_2

				if arg_425_1.var_.characterEffect1020ui_story and not isNil(var_428_0) then
					local var_428_4 = Mathf.Lerp(0, 0.5, var_428_3)

					arg_425_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_425_1.var_.characterEffect1020ui_story.fillRatio = var_428_4
				end
			end

			if arg_425_1.time_ >= var_428_1 + var_428_2 and arg_425_1.time_ < var_428_1 + var_428_2 + arg_428_0 and not isNil(var_428_0) and arg_425_1.var_.characterEffect1020ui_story then
				local var_428_5 = 0.5

				arg_425_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_425_1.var_.characterEffect1020ui_story.fillRatio = var_428_5
			end

			local var_428_6 = 0

			if var_428_6 < arg_425_1.time_ and arg_425_1.time_ <= var_428_6 + arg_428_0 then
				arg_425_1.allBtn_.enabled = false
			end

			local var_428_7 = 0.6

			if arg_425_1.time_ >= var_428_6 + var_428_7 and arg_425_1.time_ < var_428_6 + var_428_7 + arg_428_0 then
				arg_425_1.allBtn_.enabled = true
			end
		end

		arg_425_1.nodeConfigList_ = {}

		arg_425_1:InitPlayNodeList()
	end,
	Play924011104 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 924011104
		arg_429_1.duration_ = 2

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play924011105(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			local var_432_0 = arg_429_1.actors_["1020ui_story"]
			local var_432_1 = 0

			if var_432_1 < arg_429_1.time_ and arg_429_1.time_ <= var_432_1 + arg_432_0 and not isNil(var_432_0) and arg_429_1.var_.characterEffect1020ui_story == nil then
				arg_429_1.var_.characterEffect1020ui_story = var_432_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_432_2 = 0.200000002980232

			if var_432_1 <= arg_429_1.time_ and arg_429_1.time_ < var_432_1 + var_432_2 and not isNil(var_432_0) then
				local var_432_3 = (arg_429_1.time_ - var_432_1) / var_432_2

				if arg_429_1.var_.characterEffect1020ui_story and not isNil(var_432_0) then
					arg_429_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_429_1.time_ >= var_432_1 + var_432_2 and arg_429_1.time_ < var_432_1 + var_432_2 + arg_432_0 and not isNil(var_432_0) and arg_429_1.var_.characterEffect1020ui_story then
				arg_429_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_432_4 = "1020ui_story"

			if arg_429_1.actors_[var_432_4] == nil then
				local var_432_5 = Asset.Load("Char/" .. "1020ui_story")

				if not isNil(var_432_5) then
					local var_432_6 = Object.Instantiate(Asset.Load("Char/" .. "1020ui_story"), arg_429_1.stage_.transform)

					var_432_6.name = var_432_4
					var_432_6.transform.localPosition = Vector3.New(0, 100, 0)
					arg_429_1.actors_[var_432_4] = var_432_6

					local var_432_7 = var_432_6:GetComponentInChildren(typeof(CharacterEffect))

					var_432_7.enabled = true

					local var_432_8 = GameObjectTools.GetOrAddComponent(var_432_6, typeof(DynamicBoneHelper))

					if var_432_8 then
						var_432_8:EnableDynamicBone(false)
					end

					arg_429_1:ShowWeapon(var_432_7.transform, false)

					arg_429_1.var_[var_432_4 .. "Animator"] = var_432_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_429_1.var_[var_432_4 .. "Animator"].applyRootMotion = true
					arg_429_1.var_[var_432_4 .. "LipSync"] = var_432_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_432_9 = 0

			if var_432_9 < arg_429_1.time_ and arg_429_1.time_ <= var_432_9 + arg_432_0 then
				arg_429_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_432_10 = "1020ui_story"

			if arg_429_1.actors_[var_432_10] == nil then
				local var_432_11 = Asset.Load("Char/" .. "1020ui_story")

				if not isNil(var_432_11) then
					local var_432_12 = Object.Instantiate(Asset.Load("Char/" .. "1020ui_story"), arg_429_1.stage_.transform)

					var_432_12.name = var_432_10
					var_432_12.transform.localPosition = Vector3.New(0, 100, 0)
					arg_429_1.actors_[var_432_10] = var_432_12

					local var_432_13 = var_432_12:GetComponentInChildren(typeof(CharacterEffect))

					var_432_13.enabled = true

					local var_432_14 = GameObjectTools.GetOrAddComponent(var_432_12, typeof(DynamicBoneHelper))

					if var_432_14 then
						var_432_14:EnableDynamicBone(false)
					end

					arg_429_1:ShowWeapon(var_432_13.transform, false)

					arg_429_1.var_[var_432_10 .. "Animator"] = var_432_13.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_429_1.var_[var_432_10 .. "Animator"].applyRootMotion = true
					arg_429_1.var_[var_432_10 .. "LipSync"] = var_432_13.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_432_15 = 0

			if var_432_15 < arg_429_1.time_ and arg_429_1.time_ <= var_432_15 + arg_432_0 then
				arg_429_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action8_2")
			end

			local var_432_16 = 0
			local var_432_17 = 0.125

			if var_432_16 < arg_429_1.time_ and arg_429_1.time_ <= var_432_16 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, true)

				local var_432_18 = arg_429_1:FormatText(StoryNameCfg[613].name)

				arg_429_1.leftNameTxt_.text = var_432_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_429_1.leftNameTxt_.transform)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1.leftNameTxt_.text)
				SetActive(arg_429_1.iconTrs_.gameObject, false)
				arg_429_1.callingController_:SetSelectedState("normal")

				local var_432_19 = arg_429_1:GetWordFromCfg(924011104)
				local var_432_20 = arg_429_1:FormatText(var_432_19.content)

				arg_429_1.text_.text = var_432_20

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_21 = 5
				local var_432_22 = utf8.len(var_432_20)
				local var_432_23 = var_432_21 <= 0 and var_432_17 or var_432_17 * (var_432_22 / var_432_21)

				if var_432_23 > 0 and var_432_17 < var_432_23 then
					arg_429_1.talkMaxDuration = var_432_23

					if var_432_23 + var_432_16 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_23 + var_432_16
					end
				end

				arg_429_1.text_.text = var_432_20
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011104", "story_v_side_old_924011.awb") ~= 0 then
					local var_432_24 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011104", "story_v_side_old_924011.awb") / 1000

					if var_432_24 + var_432_16 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_24 + var_432_16
					end

					if var_432_19.prefab_name ~= "" and arg_429_1.actors_[var_432_19.prefab_name] ~= nil then
						local var_432_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_429_1.actors_[var_432_19.prefab_name].transform, "story_v_side_old_924011", "924011104", "story_v_side_old_924011.awb")

						arg_429_1:RecordAudio("924011104", var_432_25)
						arg_429_1:RecordAudio("924011104", var_432_25)
					else
						arg_429_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011104", "story_v_side_old_924011.awb")
					end

					arg_429_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011104", "story_v_side_old_924011.awb")
				end

				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_26 = math.max(var_432_17, arg_429_1.talkMaxDuration)

			if var_432_16 <= arg_429_1.time_ and arg_429_1.time_ < var_432_16 + var_432_26 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_16) / var_432_26

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_16 + var_432_26 and arg_429_1.time_ < var_432_16 + var_432_26 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {}

		arg_429_1:InitPlayNodeList()
	end,
	Play924011105 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 924011105
		arg_433_1.duration_ = 5

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play924011106(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			local var_436_0 = arg_433_1.actors_["1020ui_story"].transform
			local var_436_1 = 0

			if var_436_1 < arg_433_1.time_ and arg_433_1.time_ <= var_436_1 + arg_436_0 then
				arg_433_1.var_.moveOldPos1020ui_story = var_436_0.localPosition
			end

			local var_436_2 = 0.001

			if var_436_1 <= arg_433_1.time_ and arg_433_1.time_ < var_436_1 + var_436_2 then
				local var_436_3 = (arg_433_1.time_ - var_436_1) / var_436_2
				local var_436_4 = Vector3.New(0, 100, 0)

				var_436_0.localPosition = Vector3.Lerp(arg_433_1.var_.moveOldPos1020ui_story, var_436_4, var_436_3)

				local var_436_5 = manager.ui.mainCamera.transform.position - var_436_0.position

				var_436_0.forward = Vector3.New(var_436_5.x, var_436_5.y, var_436_5.z)

				local var_436_6 = var_436_0.localEulerAngles

				var_436_6.z = 0
				var_436_6.x = 0
				var_436_0.localEulerAngles = var_436_6
			end

			if arg_433_1.time_ >= var_436_1 + var_436_2 and arg_433_1.time_ < var_436_1 + var_436_2 + arg_436_0 then
				var_436_0.localPosition = Vector3.New(0, 100, 0)

				local var_436_7 = manager.ui.mainCamera.transform.position - var_436_0.position

				var_436_0.forward = Vector3.New(var_436_7.x, var_436_7.y, var_436_7.z)

				local var_436_8 = var_436_0.localEulerAngles

				var_436_8.z = 0
				var_436_8.x = 0
				var_436_0.localEulerAngles = var_436_8
			end

			local var_436_9 = arg_433_1.actors_["1020ui_story"]
			local var_436_10 = 0

			if var_436_10 < arg_433_1.time_ and arg_433_1.time_ <= var_436_10 + arg_436_0 and not isNil(var_436_9) and arg_433_1.var_.characterEffect1020ui_story == nil then
				arg_433_1.var_.characterEffect1020ui_story = var_436_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_436_11 = 0.200000002980232

			if var_436_10 <= arg_433_1.time_ and arg_433_1.time_ < var_436_10 + var_436_11 and not isNil(var_436_9) then
				local var_436_12 = (arg_433_1.time_ - var_436_10) / var_436_11

				if arg_433_1.var_.characterEffect1020ui_story and not isNil(var_436_9) then
					local var_436_13 = Mathf.Lerp(0, 0.5, var_436_12)

					arg_433_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_433_1.var_.characterEffect1020ui_story.fillRatio = var_436_13
				end
			end

			if arg_433_1.time_ >= var_436_10 + var_436_11 and arg_433_1.time_ < var_436_10 + var_436_11 + arg_436_0 and not isNil(var_436_9) and arg_433_1.var_.characterEffect1020ui_story then
				local var_436_14 = 0.5

				arg_433_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_433_1.var_.characterEffect1020ui_story.fillRatio = var_436_14
			end

			local var_436_15 = 0
			local var_436_16 = 0.275

			if var_436_15 < arg_433_1.time_ and arg_433_1.time_ <= var_436_15 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, true)

				local var_436_17 = arg_433_1:FormatText(StoryNameCfg[7].name)

				arg_433_1.leftNameTxt_.text = var_436_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_433_1.leftNameTxt_.transform)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1.leftNameTxt_.text)
				SetActive(arg_433_1.iconTrs_.gameObject, true)
				arg_433_1.iconController_:SetSelectedState("hero")

				arg_433_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_433_1.callingController_:SetSelectedState("normal")

				arg_433_1.keyicon_.color = Color.New(1, 1, 1)
				arg_433_1.icon_.color = Color.New(1, 1, 1)

				local var_436_18 = arg_433_1:GetWordFromCfg(924011105)
				local var_436_19 = arg_433_1:FormatText(var_436_18.content)

				arg_433_1.text_.text = var_436_19

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_20 = 11
				local var_436_21 = utf8.len(var_436_19)
				local var_436_22 = var_436_20 <= 0 and var_436_16 or var_436_16 * (var_436_21 / var_436_20)

				if var_436_22 > 0 and var_436_16 < var_436_22 then
					arg_433_1.talkMaxDuration = var_436_22

					if var_436_22 + var_436_15 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_22 + var_436_15
					end
				end

				arg_433_1.text_.text = var_436_19
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)
				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_23 = math.max(var_436_16, arg_433_1.talkMaxDuration)

			if var_436_15 <= arg_433_1.time_ and arg_433_1.time_ < var_436_15 + var_436_23 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - var_436_15) / var_436_23

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= var_436_15 + var_436_23 and arg_433_1.time_ < var_436_15 + var_436_23 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_433_1:InitPlayNodeList()
	end,
	Play924011106 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 924011106
		arg_437_1.duration_ = 5

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play924011107(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			local var_440_0 = manager.ui.mainCamera.transform
			local var_440_1 = 0.9

			if var_440_1 < arg_437_1.time_ and arg_437_1.time_ <= var_440_1 + arg_440_0 then
				arg_437_1.var_.shakeOldPos = var_440_0.localPosition
			end

			local var_440_2 = 0.6

			if var_440_1 <= arg_437_1.time_ and arg_437_1.time_ < var_440_1 + var_440_2 then
				local var_440_3 = (arg_437_1.time_ - var_440_1) / 0.066
				local var_440_4, var_440_5 = math.modf(var_440_3)

				var_440_0.localPosition = Vector3.New(var_440_5 * 0.13, var_440_5 * 0.13, var_440_5 * 0.13) + arg_437_1.var_.shakeOldPos
			end

			if arg_437_1.time_ >= var_440_1 + var_440_2 and arg_437_1.time_ < var_440_1 + var_440_2 + arg_440_0 then
				var_440_0.localPosition = arg_437_1.var_.shakeOldPos
			end

			local var_440_6 = manager.ui.mainCamera.transform
			local var_440_7 = 2

			if var_440_7 < arg_437_1.time_ and arg_437_1.time_ <= var_440_7 + arg_440_0 then
				arg_437_1.var_.shakeOldPos = var_440_6.localPosition
			end

			local var_440_8 = 0.6

			if var_440_7 <= arg_437_1.time_ and arg_437_1.time_ < var_440_7 + var_440_8 then
				local var_440_9 = (arg_437_1.time_ - var_440_7) / 0.066
				local var_440_10, var_440_11 = math.modf(var_440_9)

				var_440_6.localPosition = Vector3.New(var_440_11 * 0.13, var_440_11 * 0.13, var_440_11 * 0.13) + arg_437_1.var_.shakeOldPos
			end

			if arg_437_1.time_ >= var_440_7 + var_440_8 and arg_437_1.time_ < var_440_7 + var_440_8 + arg_440_0 then
				var_440_6.localPosition = arg_437_1.var_.shakeOldPos
			end

			local var_440_12 = 0

			if var_440_12 < arg_437_1.time_ and arg_437_1.time_ <= var_440_12 + arg_440_0 then
				arg_437_1.allBtn_.enabled = false
			end

			local var_440_13 = 2.6

			if arg_437_1.time_ >= var_440_12 + var_440_13 and arg_437_1.time_ < var_440_12 + var_440_13 + arg_440_0 then
				arg_437_1.allBtn_.enabled = true
			end

			local var_440_14 = 0
			local var_440_15 = 0.375

			if var_440_14 < arg_437_1.time_ and arg_437_1.time_ <= var_440_14 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, true)

				local var_440_16 = arg_437_1:FormatText(StoryNameCfg[7].name)

				arg_437_1.leftNameTxt_.text = var_440_16

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

				local var_440_17 = arg_437_1:GetWordFromCfg(924011106)
				local var_440_18 = arg_437_1:FormatText(var_440_17.content)

				arg_437_1.text_.text = var_440_18

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_19 = 15
				local var_440_20 = utf8.len(var_440_18)
				local var_440_21 = var_440_19 <= 0 and var_440_15 or var_440_15 * (var_440_20 / var_440_19)

				if var_440_21 > 0 and var_440_15 < var_440_21 then
					arg_437_1.talkMaxDuration = var_440_21

					if var_440_21 + var_440_14 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_21 + var_440_14
					end
				end

				arg_437_1.text_.text = var_440_18
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)
				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_22 = math.max(var_440_15, arg_437_1.talkMaxDuration)

			if var_440_14 <= arg_437_1.time_ and arg_437_1.time_ < var_440_14 + var_440_22 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_14) / var_440_22

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_14 + var_440_22 and arg_437_1.time_ < var_440_14 + var_440_22 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {}

		arg_437_1:InitPlayNodeList()
	end,
	Play924011107 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 924011107
		arg_441_1.duration_ = 5

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play924011108(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			local var_444_0 = 0
			local var_444_1 = 0.525

			if var_444_0 < arg_441_1.time_ and arg_441_1.time_ <= var_444_0 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, true)

				local var_444_2 = arg_441_1:FormatText(StoryNameCfg[7].name)

				arg_441_1.leftNameTxt_.text = var_444_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_441_1.leftNameTxt_.transform)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1.leftNameTxt_.text)
				SetActive(arg_441_1.iconTrs_.gameObject, true)
				arg_441_1.iconController_:SetSelectedState("hero")

				arg_441_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_441_1.callingController_:SetSelectedState("normal")

				arg_441_1.keyicon_.color = Color.New(1, 1, 1)
				arg_441_1.icon_.color = Color.New(1, 1, 1)

				local var_444_3 = arg_441_1:GetWordFromCfg(924011107)
				local var_444_4 = arg_441_1:FormatText(var_444_3.content)

				arg_441_1.text_.text = var_444_4

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_5 = 21
				local var_444_6 = utf8.len(var_444_4)
				local var_444_7 = var_444_5 <= 0 and var_444_1 or var_444_1 * (var_444_6 / var_444_5)

				if var_444_7 > 0 and var_444_1 < var_444_7 then
					arg_441_1.talkMaxDuration = var_444_7

					if var_444_7 + var_444_0 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_7 + var_444_0
					end
				end

				arg_441_1.text_.text = var_444_4
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)
				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_8 = math.max(var_444_1, arg_441_1.talkMaxDuration)

			if var_444_0 <= arg_441_1.time_ and arg_441_1.time_ < var_444_0 + var_444_8 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - var_444_0) / var_444_8

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= var_444_0 + var_444_8 and arg_441_1.time_ < var_444_0 + var_444_8 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {}

		arg_441_1:InitPlayNodeList()
	end,
	Play924011108 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 924011108
		arg_445_1.duration_ = 5

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play924011109(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			local var_448_0 = 0
			local var_448_1 = 0.975

			if var_448_0 < arg_445_1.time_ and arg_445_1.time_ <= var_448_0 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, false)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_445_1.iconTrs_.gameObject, false)
				arg_445_1.callingController_:SetSelectedState("normal")

				local var_448_2 = arg_445_1:GetWordFromCfg(924011108)
				local var_448_3 = arg_445_1:FormatText(var_448_2.content)

				arg_445_1.text_.text = var_448_3

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_4 = 39
				local var_448_5 = utf8.len(var_448_3)
				local var_448_6 = var_448_4 <= 0 and var_448_1 or var_448_1 * (var_448_5 / var_448_4)

				if var_448_6 > 0 and var_448_1 < var_448_6 then
					arg_445_1.talkMaxDuration = var_448_6

					if var_448_6 + var_448_0 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_6 + var_448_0
					end
				end

				arg_445_1.text_.text = var_448_3
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)
				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_7 = math.max(var_448_1, arg_445_1.talkMaxDuration)

			if var_448_0 <= arg_445_1.time_ and arg_445_1.time_ < var_448_0 + var_448_7 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - var_448_0) / var_448_7

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= var_448_0 + var_448_7 and arg_445_1.time_ < var_448_0 + var_448_7 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {}

		arg_445_1:InitPlayNodeList()
	end,
	Play924011109 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 924011109
		arg_449_1.duration_ = 5

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play924011110(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			local var_452_0 = 0
			local var_452_1 = 0.625

			if var_452_0 < arg_449_1.time_ and arg_449_1.time_ <= var_452_0 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				local var_452_2 = arg_449_1:FormatText(StoryNameCfg[7].name)

				arg_449_1.leftNameTxt_.text = var_452_2

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

				local var_452_3 = arg_449_1:GetWordFromCfg(924011109)
				local var_452_4 = arg_449_1:FormatText(var_452_3.content)

				arg_449_1.text_.text = var_452_4

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_5 = 25
				local var_452_6 = utf8.len(var_452_4)
				local var_452_7 = var_452_5 <= 0 and var_452_1 or var_452_1 * (var_452_6 / var_452_5)

				if var_452_7 > 0 and var_452_1 < var_452_7 then
					arg_449_1.talkMaxDuration = var_452_7

					if var_452_7 + var_452_0 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_7 + var_452_0
					end
				end

				arg_449_1.text_.text = var_452_4
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)
				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_8 = math.max(var_452_1, arg_449_1.talkMaxDuration)

			if var_452_0 <= arg_449_1.time_ and arg_449_1.time_ < var_452_0 + var_452_8 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - var_452_0) / var_452_8

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= var_452_0 + var_452_8 and arg_449_1.time_ < var_452_0 + var_452_8 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {}

		arg_449_1:InitPlayNodeList()
	end,
	Play924011110 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 924011110
		arg_453_1.duration_ = 3.3

		local var_453_0 = {
			zh = 2.533,
			ja = 3.3
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
				arg_453_0:Play924011111(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			local var_456_0 = arg_453_1.actors_["1020ui_story"].transform
			local var_456_1 = 0

			if var_456_1 < arg_453_1.time_ and arg_453_1.time_ <= var_456_1 + arg_456_0 then
				arg_453_1.var_.moveOldPos1020ui_story = var_456_0.localPosition
			end

			local var_456_2 = 0.001

			if var_456_1 <= arg_453_1.time_ and arg_453_1.time_ < var_456_1 + var_456_2 then
				local var_456_3 = (arg_453_1.time_ - var_456_1) / var_456_2
				local var_456_4 = Vector3.New(0, -0.85, -6.25)

				var_456_0.localPosition = Vector3.Lerp(arg_453_1.var_.moveOldPos1020ui_story, var_456_4, var_456_3)

				local var_456_5 = manager.ui.mainCamera.transform.position - var_456_0.position

				var_456_0.forward = Vector3.New(var_456_5.x, var_456_5.y, var_456_5.z)

				local var_456_6 = var_456_0.localEulerAngles

				var_456_6.z = 0
				var_456_6.x = 0
				var_456_0.localEulerAngles = var_456_6
			end

			if arg_453_1.time_ >= var_456_1 + var_456_2 and arg_453_1.time_ < var_456_1 + var_456_2 + arg_456_0 then
				var_456_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_456_7 = manager.ui.mainCamera.transform.position - var_456_0.position

				var_456_0.forward = Vector3.New(var_456_7.x, var_456_7.y, var_456_7.z)

				local var_456_8 = var_456_0.localEulerAngles

				var_456_8.z = 0
				var_456_8.x = 0
				var_456_0.localEulerAngles = var_456_8
			end

			local var_456_9 = arg_453_1.actors_["1020ui_story"]
			local var_456_10 = 0

			if var_456_10 < arg_453_1.time_ and arg_453_1.time_ <= var_456_10 + arg_456_0 and not isNil(var_456_9) and arg_453_1.var_.characterEffect1020ui_story == nil then
				arg_453_1.var_.characterEffect1020ui_story = var_456_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_456_11 = 0.200000002980232

			if var_456_10 <= arg_453_1.time_ and arg_453_1.time_ < var_456_10 + var_456_11 and not isNil(var_456_9) then
				local var_456_12 = (arg_453_1.time_ - var_456_10) / var_456_11

				if arg_453_1.var_.characterEffect1020ui_story and not isNil(var_456_9) then
					arg_453_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_453_1.time_ >= var_456_10 + var_456_11 and arg_453_1.time_ < var_456_10 + var_456_11 + arg_456_0 and not isNil(var_456_9) and arg_453_1.var_.characterEffect1020ui_story then
				arg_453_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_456_13 = 0

			if var_456_13 < arg_453_1.time_ and arg_453_1.time_ <= var_456_13 + arg_456_0 then
				arg_453_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_456_14 = 0

			if var_456_14 < arg_453_1.time_ and arg_453_1.time_ <= var_456_14 + arg_456_0 then
				arg_453_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action3_1")
			end

			local var_456_15 = 0
			local var_456_16 = 0.225

			if var_456_15 < arg_453_1.time_ and arg_453_1.time_ <= var_456_15 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, true)

				local var_456_17 = arg_453_1:FormatText(StoryNameCfg[613].name)

				arg_453_1.leftNameTxt_.text = var_456_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_453_1.leftNameTxt_.transform)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1.leftNameTxt_.text)
				SetActive(arg_453_1.iconTrs_.gameObject, false)
				arg_453_1.callingController_:SetSelectedState("normal")

				local var_456_18 = arg_453_1:GetWordFromCfg(924011110)
				local var_456_19 = arg_453_1:FormatText(var_456_18.content)

				arg_453_1.text_.text = var_456_19

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_20 = 9
				local var_456_21 = utf8.len(var_456_19)
				local var_456_22 = var_456_20 <= 0 and var_456_16 or var_456_16 * (var_456_21 / var_456_20)

				if var_456_22 > 0 and var_456_16 < var_456_22 then
					arg_453_1.talkMaxDuration = var_456_22

					if var_456_22 + var_456_15 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_22 + var_456_15
					end
				end

				arg_453_1.text_.text = var_456_19
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011110", "story_v_side_old_924011.awb") ~= 0 then
					local var_456_23 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011110", "story_v_side_old_924011.awb") / 1000

					if var_456_23 + var_456_15 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_23 + var_456_15
					end

					if var_456_18.prefab_name ~= "" and arg_453_1.actors_[var_456_18.prefab_name] ~= nil then
						local var_456_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_453_1.actors_[var_456_18.prefab_name].transform, "story_v_side_old_924011", "924011110", "story_v_side_old_924011.awb")

						arg_453_1:RecordAudio("924011110", var_456_24)
						arg_453_1:RecordAudio("924011110", var_456_24)
					else
						arg_453_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011110", "story_v_side_old_924011.awb")
					end

					arg_453_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011110", "story_v_side_old_924011.awb")
				end

				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_25 = math.max(var_456_16, arg_453_1.talkMaxDuration)

			if var_456_15 <= arg_453_1.time_ and arg_453_1.time_ < var_456_15 + var_456_25 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_15) / var_456_25

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_15 + var_456_25 and arg_453_1.time_ < var_456_15 + var_456_25 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_453_1:InitPlayNodeList()
	end,
	Play924011111 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 924011111
		arg_457_1.duration_ = 4.03

		local var_457_0 = {
			zh = 1.999999999999,
			ja = 4.033
		}
		local var_457_1 = manager.audio:GetLocalizationFlag()

		if var_457_0[var_457_1] ~= nil then
			arg_457_1.duration_ = var_457_0[var_457_1]
		end

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play924011112(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			local var_460_0 = 0

			if var_460_0 < arg_457_1.time_ and arg_457_1.time_ <= var_460_0 + arg_460_0 then
				arg_457_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_460_1 = 0
			local var_460_2 = 0.2

			if var_460_1 < arg_457_1.time_ and arg_457_1.time_ <= var_460_1 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, true)

				local var_460_3 = arg_457_1:FormatText(StoryNameCfg[613].name)

				arg_457_1.leftNameTxt_.text = var_460_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_457_1.leftNameTxt_.transform)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1.leftNameTxt_.text)
				SetActive(arg_457_1.iconTrs_.gameObject, false)
				arg_457_1.callingController_:SetSelectedState("normal")

				local var_460_4 = arg_457_1:GetWordFromCfg(924011111)
				local var_460_5 = arg_457_1:FormatText(var_460_4.content)

				arg_457_1.text_.text = var_460_5

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_6 = 8
				local var_460_7 = utf8.len(var_460_5)
				local var_460_8 = var_460_6 <= 0 and var_460_2 or var_460_2 * (var_460_7 / var_460_6)

				if var_460_8 > 0 and var_460_2 < var_460_8 then
					arg_457_1.talkMaxDuration = var_460_8

					if var_460_8 + var_460_1 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_8 + var_460_1
					end
				end

				arg_457_1.text_.text = var_460_5
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011111", "story_v_side_old_924011.awb") ~= 0 then
					local var_460_9 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011111", "story_v_side_old_924011.awb") / 1000

					if var_460_9 + var_460_1 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_9 + var_460_1
					end

					if var_460_4.prefab_name ~= "" and arg_457_1.actors_[var_460_4.prefab_name] ~= nil then
						local var_460_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_457_1.actors_[var_460_4.prefab_name].transform, "story_v_side_old_924011", "924011111", "story_v_side_old_924011.awb")

						arg_457_1:RecordAudio("924011111", var_460_10)
						arg_457_1:RecordAudio("924011111", var_460_10)
					else
						arg_457_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011111", "story_v_side_old_924011.awb")
					end

					arg_457_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011111", "story_v_side_old_924011.awb")
				end

				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_11 = math.max(var_460_2, arg_457_1.talkMaxDuration)

			if var_460_1 <= arg_457_1.time_ and arg_457_1.time_ < var_460_1 + var_460_11 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - var_460_1) / var_460_11

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= var_460_1 + var_460_11 and arg_457_1.time_ < var_460_1 + var_460_11 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {}

		arg_457_1:InitPlayNodeList()
	end,
	Play924011112 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 924011112
		arg_461_1.duration_ = 5

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play924011113(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			local var_464_0 = arg_461_1.actors_["1020ui_story"]
			local var_464_1 = 0

			if var_464_1 < arg_461_1.time_ and arg_461_1.time_ <= var_464_1 + arg_464_0 and not isNil(var_464_0) and arg_461_1.var_.characterEffect1020ui_story == nil then
				arg_461_1.var_.characterEffect1020ui_story = var_464_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_464_2 = 0.200000002980232

			if var_464_1 <= arg_461_1.time_ and arg_461_1.time_ < var_464_1 + var_464_2 and not isNil(var_464_0) then
				local var_464_3 = (arg_461_1.time_ - var_464_1) / var_464_2

				if arg_461_1.var_.characterEffect1020ui_story and not isNil(var_464_0) then
					local var_464_4 = Mathf.Lerp(0, 0.5, var_464_3)

					arg_461_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_461_1.var_.characterEffect1020ui_story.fillRatio = var_464_4
				end
			end

			if arg_461_1.time_ >= var_464_1 + var_464_2 and arg_461_1.time_ < var_464_1 + var_464_2 + arg_464_0 and not isNil(var_464_0) and arg_461_1.var_.characterEffect1020ui_story then
				local var_464_5 = 0.5

				arg_461_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_461_1.var_.characterEffect1020ui_story.fillRatio = var_464_5
			end

			local var_464_6 = 0
			local var_464_7 = 0.6

			if var_464_6 < arg_461_1.time_ and arg_461_1.time_ <= var_464_6 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, true)

				local var_464_8 = arg_461_1:FormatText(StoryNameCfg[7].name)

				arg_461_1.leftNameTxt_.text = var_464_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_461_1.leftNameTxt_.transform)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1.leftNameTxt_.text)
				SetActive(arg_461_1.iconTrs_.gameObject, true)
				arg_461_1.iconController_:SetSelectedState("hero")

				arg_461_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_461_1.callingController_:SetSelectedState("normal")

				arg_461_1.keyicon_.color = Color.New(1, 1, 1)
				arg_461_1.icon_.color = Color.New(1, 1, 1)

				local var_464_9 = arg_461_1:GetWordFromCfg(924011112)
				local var_464_10 = arg_461_1:FormatText(var_464_9.content)

				arg_461_1.text_.text = var_464_10

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_11 = 24
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
				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_14 = math.max(var_464_7, arg_461_1.talkMaxDuration)

			if var_464_6 <= arg_461_1.time_ and arg_461_1.time_ < var_464_6 + var_464_14 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_6) / var_464_14

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_6 + var_464_14 and arg_461_1.time_ < var_464_6 + var_464_14 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {}

		arg_461_1:InitPlayNodeList()
	end,
	Play924011113 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 924011113
		arg_465_1.duration_ = 7.83

		local var_465_0 = {
			zh = 5.5,
			ja = 7.833
		}
		local var_465_1 = manager.audio:GetLocalizationFlag()

		if var_465_0[var_465_1] ~= nil then
			arg_465_1.duration_ = var_465_0[var_465_1]
		end

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play924011114(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			local var_468_0 = arg_465_1.actors_["1020ui_story"].transform
			local var_468_1 = 0

			if var_468_1 < arg_465_1.time_ and arg_465_1.time_ <= var_468_1 + arg_468_0 then
				arg_465_1.var_.moveOldPos1020ui_story = var_468_0.localPosition
			end

			local var_468_2 = 0.001

			if var_468_1 <= arg_465_1.time_ and arg_465_1.time_ < var_468_1 + var_468_2 then
				local var_468_3 = (arg_465_1.time_ - var_468_1) / var_468_2
				local var_468_4 = Vector3.New(0, -0.85, -6.25)

				var_468_0.localPosition = Vector3.Lerp(arg_465_1.var_.moveOldPos1020ui_story, var_468_4, var_468_3)

				local var_468_5 = manager.ui.mainCamera.transform.position - var_468_0.position

				var_468_0.forward = Vector3.New(var_468_5.x, var_468_5.y, var_468_5.z)

				local var_468_6 = var_468_0.localEulerAngles

				var_468_6.z = 0
				var_468_6.x = 0
				var_468_0.localEulerAngles = var_468_6
			end

			if arg_465_1.time_ >= var_468_1 + var_468_2 and arg_465_1.time_ < var_468_1 + var_468_2 + arg_468_0 then
				var_468_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_468_7 = manager.ui.mainCamera.transform.position - var_468_0.position

				var_468_0.forward = Vector3.New(var_468_7.x, var_468_7.y, var_468_7.z)

				local var_468_8 = var_468_0.localEulerAngles

				var_468_8.z = 0
				var_468_8.x = 0
				var_468_0.localEulerAngles = var_468_8
			end

			local var_468_9 = arg_465_1.actors_["1020ui_story"]
			local var_468_10 = 0

			if var_468_10 < arg_465_1.time_ and arg_465_1.time_ <= var_468_10 + arg_468_0 and not isNil(var_468_9) and arg_465_1.var_.characterEffect1020ui_story == nil then
				arg_465_1.var_.characterEffect1020ui_story = var_468_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_468_11 = 0.200000002980232

			if var_468_10 <= arg_465_1.time_ and arg_465_1.time_ < var_468_10 + var_468_11 and not isNil(var_468_9) then
				local var_468_12 = (arg_465_1.time_ - var_468_10) / var_468_11

				if arg_465_1.var_.characterEffect1020ui_story and not isNil(var_468_9) then
					arg_465_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_465_1.time_ >= var_468_10 + var_468_11 and arg_465_1.time_ < var_468_10 + var_468_11 + arg_468_0 and not isNil(var_468_9) and arg_465_1.var_.characterEffect1020ui_story then
				arg_465_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_468_13 = 0

			if var_468_13 < arg_465_1.time_ and arg_465_1.time_ <= var_468_13 + arg_468_0 then
				arg_465_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_wuganC", "EmotionTimelineAnimator")
			end

			local var_468_14 = 0

			if var_468_14 < arg_465_1.time_ and arg_465_1.time_ <= var_468_14 + arg_468_0 then
				arg_465_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020actionlink/1020action438")
			end

			local var_468_15 = 0
			local var_468_16 = 0.575

			if var_468_15 < arg_465_1.time_ and arg_465_1.time_ <= var_468_15 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, true)

				local var_468_17 = arg_465_1:FormatText(StoryNameCfg[613].name)

				arg_465_1.leftNameTxt_.text = var_468_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_465_1.leftNameTxt_.transform)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1.leftNameTxt_.text)
				SetActive(arg_465_1.iconTrs_.gameObject, false)
				arg_465_1.callingController_:SetSelectedState("normal")

				local var_468_18 = arg_465_1:GetWordFromCfg(924011113)
				local var_468_19 = arg_465_1:FormatText(var_468_18.content)

				arg_465_1.text_.text = var_468_19

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_20 = 23
				local var_468_21 = utf8.len(var_468_19)
				local var_468_22 = var_468_20 <= 0 and var_468_16 or var_468_16 * (var_468_21 / var_468_20)

				if var_468_22 > 0 and var_468_16 < var_468_22 then
					arg_465_1.talkMaxDuration = var_468_22

					if var_468_22 + var_468_15 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_22 + var_468_15
					end
				end

				arg_465_1.text_.text = var_468_19
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011113", "story_v_side_old_924011.awb") ~= 0 then
					local var_468_23 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011113", "story_v_side_old_924011.awb") / 1000

					if var_468_23 + var_468_15 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_23 + var_468_15
					end

					if var_468_18.prefab_name ~= "" and arg_465_1.actors_[var_468_18.prefab_name] ~= nil then
						local var_468_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_465_1.actors_[var_468_18.prefab_name].transform, "story_v_side_old_924011", "924011113", "story_v_side_old_924011.awb")

						arg_465_1:RecordAudio("924011113", var_468_24)
						arg_465_1:RecordAudio("924011113", var_468_24)
					else
						arg_465_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011113", "story_v_side_old_924011.awb")
					end

					arg_465_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011113", "story_v_side_old_924011.awb")
				end

				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_25 = math.max(var_468_16, arg_465_1.talkMaxDuration)

			if var_468_15 <= arg_465_1.time_ and arg_465_1.time_ < var_468_15 + var_468_25 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_15) / var_468_25

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_15 + var_468_25 and arg_465_1.time_ < var_468_15 + var_468_25 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_465_1:InitPlayNodeList()
	end,
	Play924011114 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 924011114
		arg_469_1.duration_ = 5

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play924011115(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			local var_472_0 = arg_469_1.actors_["1020ui_story"]
			local var_472_1 = 0

			if var_472_1 < arg_469_1.time_ and arg_469_1.time_ <= var_472_1 + arg_472_0 and not isNil(var_472_0) and arg_469_1.var_.characterEffect1020ui_story == nil then
				arg_469_1.var_.characterEffect1020ui_story = var_472_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_472_2 = 0.200000002980232

			if var_472_1 <= arg_469_1.time_ and arg_469_1.time_ < var_472_1 + var_472_2 and not isNil(var_472_0) then
				local var_472_3 = (arg_469_1.time_ - var_472_1) / var_472_2

				if arg_469_1.var_.characterEffect1020ui_story and not isNil(var_472_0) then
					local var_472_4 = Mathf.Lerp(0, 0.5, var_472_3)

					arg_469_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_469_1.var_.characterEffect1020ui_story.fillRatio = var_472_4
				end
			end

			if arg_469_1.time_ >= var_472_1 + var_472_2 and arg_469_1.time_ < var_472_1 + var_472_2 + arg_472_0 and not isNil(var_472_0) and arg_469_1.var_.characterEffect1020ui_story then
				local var_472_5 = 0.5

				arg_469_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_469_1.var_.characterEffect1020ui_story.fillRatio = var_472_5
			end

			local var_472_6 = 0
			local var_472_7 = 0.65

			if var_472_6 < arg_469_1.time_ and arg_469_1.time_ <= var_472_6 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, true)

				local var_472_8 = arg_469_1:FormatText(StoryNameCfg[7].name)

				arg_469_1.leftNameTxt_.text = var_472_8

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

				local var_472_9 = arg_469_1:GetWordFromCfg(924011114)
				local var_472_10 = arg_469_1:FormatText(var_472_9.content)

				arg_469_1.text_.text = var_472_10

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_11 = 26
				local var_472_12 = utf8.len(var_472_10)
				local var_472_13 = var_472_11 <= 0 and var_472_7 or var_472_7 * (var_472_12 / var_472_11)

				if var_472_13 > 0 and var_472_7 < var_472_13 then
					arg_469_1.talkMaxDuration = var_472_13

					if var_472_13 + var_472_6 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_13 + var_472_6
					end
				end

				arg_469_1.text_.text = var_472_10
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)
				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_14 = math.max(var_472_7, arg_469_1.talkMaxDuration)

			if var_472_6 <= arg_469_1.time_ and arg_469_1.time_ < var_472_6 + var_472_14 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_6) / var_472_14

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_6 + var_472_14 and arg_469_1.time_ < var_472_6 + var_472_14 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {}

		arg_469_1:InitPlayNodeList()
	end,
	Play924011115 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 924011115
		arg_473_1.duration_ = 5.27

		local var_473_0 = {
			zh = 3.033,
			ja = 5.266
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
				arg_473_0:Play924011116(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			local var_476_0 = arg_473_1.actors_["1020ui_story"].transform
			local var_476_1 = 0

			if var_476_1 < arg_473_1.time_ and arg_473_1.time_ <= var_476_1 + arg_476_0 then
				arg_473_1.var_.moveOldPos1020ui_story = var_476_0.localPosition
			end

			local var_476_2 = 0.001

			if var_476_1 <= arg_473_1.time_ and arg_473_1.time_ < var_476_1 + var_476_2 then
				local var_476_3 = (arg_473_1.time_ - var_476_1) / var_476_2
				local var_476_4 = Vector3.New(0, -0.85, -6.25)

				var_476_0.localPosition = Vector3.Lerp(arg_473_1.var_.moveOldPos1020ui_story, var_476_4, var_476_3)

				local var_476_5 = manager.ui.mainCamera.transform.position - var_476_0.position

				var_476_0.forward = Vector3.New(var_476_5.x, var_476_5.y, var_476_5.z)

				local var_476_6 = var_476_0.localEulerAngles

				var_476_6.z = 0
				var_476_6.x = 0
				var_476_0.localEulerAngles = var_476_6
			end

			if arg_473_1.time_ >= var_476_1 + var_476_2 and arg_473_1.time_ < var_476_1 + var_476_2 + arg_476_0 then
				var_476_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_476_7 = manager.ui.mainCamera.transform.position - var_476_0.position

				var_476_0.forward = Vector3.New(var_476_7.x, var_476_7.y, var_476_7.z)

				local var_476_8 = var_476_0.localEulerAngles

				var_476_8.z = 0
				var_476_8.x = 0
				var_476_0.localEulerAngles = var_476_8
			end

			local var_476_9 = arg_473_1.actors_["1020ui_story"]
			local var_476_10 = 0

			if var_476_10 < arg_473_1.time_ and arg_473_1.time_ <= var_476_10 + arg_476_0 and not isNil(var_476_9) and arg_473_1.var_.characterEffect1020ui_story == nil then
				arg_473_1.var_.characterEffect1020ui_story = var_476_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_476_11 = 0.200000002980232

			if var_476_10 <= arg_473_1.time_ and arg_473_1.time_ < var_476_10 + var_476_11 and not isNil(var_476_9) then
				local var_476_12 = (arg_473_1.time_ - var_476_10) / var_476_11

				if arg_473_1.var_.characterEffect1020ui_story and not isNil(var_476_9) then
					arg_473_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_473_1.time_ >= var_476_10 + var_476_11 and arg_473_1.time_ < var_476_10 + var_476_11 + arg_476_0 and not isNil(var_476_9) and arg_473_1.var_.characterEffect1020ui_story then
				arg_473_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_476_13 = 0

			if var_476_13 < arg_473_1.time_ and arg_473_1.time_ <= var_476_13 + arg_476_0 then
				arg_473_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_gandong", "EmotionTimelineAnimator")
			end

			local var_476_14 = 0

			if var_476_14 < arg_473_1.time_ and arg_473_1.time_ <= var_476_14 + arg_476_0 then
				arg_473_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020actionlink/1020action486")
			end

			local var_476_15 = 0
			local var_476_16 = 0.3

			if var_476_15 < arg_473_1.time_ and arg_473_1.time_ <= var_476_15 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				local var_476_17 = arg_473_1:FormatText(StoryNameCfg[613].name)

				arg_473_1.leftNameTxt_.text = var_476_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, false)
				arg_473_1.callingController_:SetSelectedState("normal")

				local var_476_18 = arg_473_1:GetWordFromCfg(924011115)
				local var_476_19 = arg_473_1:FormatText(var_476_18.content)

				arg_473_1.text_.text = var_476_19

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_20 = 12
				local var_476_21 = utf8.len(var_476_19)
				local var_476_22 = var_476_20 <= 0 and var_476_16 or var_476_16 * (var_476_21 / var_476_20)

				if var_476_22 > 0 and var_476_16 < var_476_22 then
					arg_473_1.talkMaxDuration = var_476_22

					if var_476_22 + var_476_15 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_22 + var_476_15
					end
				end

				arg_473_1.text_.text = var_476_19
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011115", "story_v_side_old_924011.awb") ~= 0 then
					local var_476_23 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011115", "story_v_side_old_924011.awb") / 1000

					if var_476_23 + var_476_15 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_23 + var_476_15
					end

					if var_476_18.prefab_name ~= "" and arg_473_1.actors_[var_476_18.prefab_name] ~= nil then
						local var_476_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_473_1.actors_[var_476_18.prefab_name].transform, "story_v_side_old_924011", "924011115", "story_v_side_old_924011.awb")

						arg_473_1:RecordAudio("924011115", var_476_24)
						arg_473_1:RecordAudio("924011115", var_476_24)
					else
						arg_473_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011115", "story_v_side_old_924011.awb")
					end

					arg_473_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011115", "story_v_side_old_924011.awb")
				end

				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_25 = math.max(var_476_16, arg_473_1.talkMaxDuration)

			if var_476_15 <= arg_473_1.time_ and arg_473_1.time_ < var_476_15 + var_476_25 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_15) / var_476_25

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_15 + var_476_25 and arg_473_1.time_ < var_476_15 + var_476_25 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_473_1:InitPlayNodeList()
	end,
	Play924011116 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 924011116
		arg_477_1.duration_ = 5

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play924011117(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			local var_480_0 = arg_477_1.actors_["1020ui_story"].transform
			local var_480_1 = 0

			if var_480_1 < arg_477_1.time_ and arg_477_1.time_ <= var_480_1 + arg_480_0 then
				arg_477_1.var_.moveOldPos1020ui_story = var_480_0.localPosition
			end

			local var_480_2 = 0.001

			if var_480_1 <= arg_477_1.time_ and arg_477_1.time_ < var_480_1 + var_480_2 then
				local var_480_3 = (arg_477_1.time_ - var_480_1) / var_480_2
				local var_480_4 = Vector3.New(0, 100, 0)

				var_480_0.localPosition = Vector3.Lerp(arg_477_1.var_.moveOldPos1020ui_story, var_480_4, var_480_3)

				local var_480_5 = manager.ui.mainCamera.transform.position - var_480_0.position

				var_480_0.forward = Vector3.New(var_480_5.x, var_480_5.y, var_480_5.z)

				local var_480_6 = var_480_0.localEulerAngles

				var_480_6.z = 0
				var_480_6.x = 0
				var_480_0.localEulerAngles = var_480_6
			end

			if arg_477_1.time_ >= var_480_1 + var_480_2 and arg_477_1.time_ < var_480_1 + var_480_2 + arg_480_0 then
				var_480_0.localPosition = Vector3.New(0, 100, 0)

				local var_480_7 = manager.ui.mainCamera.transform.position - var_480_0.position

				var_480_0.forward = Vector3.New(var_480_7.x, var_480_7.y, var_480_7.z)

				local var_480_8 = var_480_0.localEulerAngles

				var_480_8.z = 0
				var_480_8.x = 0
				var_480_0.localEulerAngles = var_480_8
			end

			local var_480_9 = arg_477_1.actors_["1020ui_story"]
			local var_480_10 = 0

			if var_480_10 < arg_477_1.time_ and arg_477_1.time_ <= var_480_10 + arg_480_0 and not isNil(var_480_9) and arg_477_1.var_.characterEffect1020ui_story == nil then
				arg_477_1.var_.characterEffect1020ui_story = var_480_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_480_11 = 0.200000002980232

			if var_480_10 <= arg_477_1.time_ and arg_477_1.time_ < var_480_10 + var_480_11 and not isNil(var_480_9) then
				local var_480_12 = (arg_477_1.time_ - var_480_10) / var_480_11

				if arg_477_1.var_.characterEffect1020ui_story and not isNil(var_480_9) then
					local var_480_13 = Mathf.Lerp(0, 0.5, var_480_12)

					arg_477_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_477_1.var_.characterEffect1020ui_story.fillRatio = var_480_13
				end
			end

			if arg_477_1.time_ >= var_480_10 + var_480_11 and arg_477_1.time_ < var_480_10 + var_480_11 + arg_480_0 and not isNil(var_480_9) and arg_477_1.var_.characterEffect1020ui_story then
				local var_480_14 = 0.5

				arg_477_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_477_1.var_.characterEffect1020ui_story.fillRatio = var_480_14
			end

			local var_480_15 = 0
			local var_480_16 = 0.8

			if var_480_15 < arg_477_1.time_ and arg_477_1.time_ <= var_480_15 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, false)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_477_1.iconTrs_.gameObject, false)
				arg_477_1.callingController_:SetSelectedState("normal")

				local var_480_17 = arg_477_1:GetWordFromCfg(924011116)
				local var_480_18 = arg_477_1:FormatText(var_480_17.content)

				arg_477_1.text_.text = var_480_18

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_19 = 32
				local var_480_20 = utf8.len(var_480_18)
				local var_480_21 = var_480_19 <= 0 and var_480_16 or var_480_16 * (var_480_20 / var_480_19)

				if var_480_21 > 0 and var_480_16 < var_480_21 then
					arg_477_1.talkMaxDuration = var_480_21

					if var_480_21 + var_480_15 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_21 + var_480_15
					end
				end

				arg_477_1.text_.text = var_480_18
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)
				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_22 = math.max(var_480_16, arg_477_1.talkMaxDuration)

			if var_480_15 <= arg_477_1.time_ and arg_477_1.time_ < var_480_15 + var_480_22 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_15) / var_480_22

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_15 + var_480_22 and arg_477_1.time_ < var_480_15 + var_480_22 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_477_1:InitPlayNodeList()
	end,
	Play924011117 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 924011117
		arg_481_1.duration_ = 5

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play924011118(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			local var_484_0 = 0
			local var_484_1 = 0.375

			if var_484_0 < arg_481_1.time_ and arg_481_1.time_ <= var_484_0 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, true)

				local var_484_2 = arg_481_1:FormatText(StoryNameCfg[7].name)

				arg_481_1.leftNameTxt_.text = var_484_2

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

				local var_484_3 = arg_481_1:GetWordFromCfg(924011117)
				local var_484_4 = arg_481_1:FormatText(var_484_3.content)

				arg_481_1.text_.text = var_484_4

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_5 = 15
				local var_484_6 = utf8.len(var_484_4)
				local var_484_7 = var_484_5 <= 0 and var_484_1 or var_484_1 * (var_484_6 / var_484_5)

				if var_484_7 > 0 and var_484_1 < var_484_7 then
					arg_481_1.talkMaxDuration = var_484_7

					if var_484_7 + var_484_0 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_7 + var_484_0
					end
				end

				arg_481_1.text_.text = var_484_4
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)
				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_8 = math.max(var_484_1, arg_481_1.talkMaxDuration)

			if var_484_0 <= arg_481_1.time_ and arg_481_1.time_ < var_484_0 + var_484_8 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - var_484_0) / var_484_8

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= var_484_0 + var_484_8 and arg_481_1.time_ < var_484_0 + var_484_8 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {}

		arg_481_1:InitPlayNodeList()
	end,
	Play924011118 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 924011118
		arg_485_1.duration_ = 6.5

		local var_485_0 = {
			zh = 3.033,
			ja = 6.5
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
				arg_485_0:Play924011119(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			local var_488_0 = arg_485_1.actors_["1020ui_story"].transform
			local var_488_1 = 0

			if var_488_1 < arg_485_1.time_ and arg_485_1.time_ <= var_488_1 + arg_488_0 then
				arg_485_1.var_.moveOldPos1020ui_story = var_488_0.localPosition
			end

			local var_488_2 = 0.001

			if var_488_1 <= arg_485_1.time_ and arg_485_1.time_ < var_488_1 + var_488_2 then
				local var_488_3 = (arg_485_1.time_ - var_488_1) / var_488_2
				local var_488_4 = Vector3.New(0, -0.85, -6.25)

				var_488_0.localPosition = Vector3.Lerp(arg_485_1.var_.moveOldPos1020ui_story, var_488_4, var_488_3)

				local var_488_5 = manager.ui.mainCamera.transform.position - var_488_0.position

				var_488_0.forward = Vector3.New(var_488_5.x, var_488_5.y, var_488_5.z)

				local var_488_6 = var_488_0.localEulerAngles

				var_488_6.z = 0
				var_488_6.x = 0
				var_488_0.localEulerAngles = var_488_6
			end

			if arg_485_1.time_ >= var_488_1 + var_488_2 and arg_485_1.time_ < var_488_1 + var_488_2 + arg_488_0 then
				var_488_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_488_7 = manager.ui.mainCamera.transform.position - var_488_0.position

				var_488_0.forward = Vector3.New(var_488_7.x, var_488_7.y, var_488_7.z)

				local var_488_8 = var_488_0.localEulerAngles

				var_488_8.z = 0
				var_488_8.x = 0
				var_488_0.localEulerAngles = var_488_8
			end

			local var_488_9 = arg_485_1.actors_["1020ui_story"]
			local var_488_10 = 0

			if var_488_10 < arg_485_1.time_ and arg_485_1.time_ <= var_488_10 + arg_488_0 and not isNil(var_488_9) and arg_485_1.var_.characterEffect1020ui_story == nil then
				arg_485_1.var_.characterEffect1020ui_story = var_488_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_488_11 = 0.200000002980232

			if var_488_10 <= arg_485_1.time_ and arg_485_1.time_ < var_488_10 + var_488_11 and not isNil(var_488_9) then
				local var_488_12 = (arg_485_1.time_ - var_488_10) / var_488_11

				if arg_485_1.var_.characterEffect1020ui_story and not isNil(var_488_9) then
					arg_485_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_485_1.time_ >= var_488_10 + var_488_11 and arg_485_1.time_ < var_488_10 + var_488_11 + arg_488_0 and not isNil(var_488_9) and arg_485_1.var_.characterEffect1020ui_story then
				arg_485_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_488_13 = 0

			if var_488_13 < arg_485_1.time_ and arg_485_1.time_ <= var_488_13 + arg_488_0 then
				arg_485_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_488_14 = 0

			if var_488_14 < arg_485_1.time_ and arg_485_1.time_ <= var_488_14 + arg_488_0 then
				arg_485_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action3_1")
			end

			local var_488_15 = 0
			local var_488_16 = 0.375

			if var_488_15 < arg_485_1.time_ and arg_485_1.time_ <= var_488_15 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, true)

				local var_488_17 = arg_485_1:FormatText(StoryNameCfg[613].name)

				arg_485_1.leftNameTxt_.text = var_488_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_485_1.leftNameTxt_.transform)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1.leftNameTxt_.text)
				SetActive(arg_485_1.iconTrs_.gameObject, false)
				arg_485_1.callingController_:SetSelectedState("normal")

				local var_488_18 = arg_485_1:GetWordFromCfg(924011118)
				local var_488_19 = arg_485_1:FormatText(var_488_18.content)

				arg_485_1.text_.text = var_488_19

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_20 = 15
				local var_488_21 = utf8.len(var_488_19)
				local var_488_22 = var_488_20 <= 0 and var_488_16 or var_488_16 * (var_488_21 / var_488_20)

				if var_488_22 > 0 and var_488_16 < var_488_22 then
					arg_485_1.talkMaxDuration = var_488_22

					if var_488_22 + var_488_15 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_22 + var_488_15
					end
				end

				arg_485_1.text_.text = var_488_19
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011118", "story_v_side_old_924011.awb") ~= 0 then
					local var_488_23 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011118", "story_v_side_old_924011.awb") / 1000

					if var_488_23 + var_488_15 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_23 + var_488_15
					end

					if var_488_18.prefab_name ~= "" and arg_485_1.actors_[var_488_18.prefab_name] ~= nil then
						local var_488_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_485_1.actors_[var_488_18.prefab_name].transform, "story_v_side_old_924011", "924011118", "story_v_side_old_924011.awb")

						arg_485_1:RecordAudio("924011118", var_488_24)
						arg_485_1:RecordAudio("924011118", var_488_24)
					else
						arg_485_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011118", "story_v_side_old_924011.awb")
					end

					arg_485_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011118", "story_v_side_old_924011.awb")
				end

				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_25 = math.max(var_488_16, arg_485_1.talkMaxDuration)

			if var_488_15 <= arg_485_1.time_ and arg_485_1.time_ < var_488_15 + var_488_25 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - var_488_15) / var_488_25

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= var_488_15 + var_488_25 and arg_485_1.time_ < var_488_15 + var_488_25 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_485_1:InitPlayNodeList()
	end,
	Play924011119 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 924011119
		arg_489_1.duration_ = 9

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play924011120(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			local var_492_0 = "ST01"

			if arg_489_1.bgs_[var_492_0] == nil then
				local var_492_1 = Object.Instantiate(arg_489_1.paintGo_)

				var_492_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_492_0)
				var_492_1.name = var_492_0
				var_492_1.transform.parent = arg_489_1.stage_.transform
				var_492_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_489_1.bgs_[var_492_0] = var_492_1
			end

			local var_492_2 = 1.999999999999

			if var_492_2 < arg_489_1.time_ and arg_489_1.time_ <= var_492_2 + arg_492_0 then
				local var_492_3 = manager.ui.mainCamera.transform.localPosition
				local var_492_4 = Vector3.New(0, 0, 10) + Vector3.New(var_492_3.x, var_492_3.y, 0)
				local var_492_5 = arg_489_1.bgs_.ST01

				var_492_5.transform.localPosition = var_492_4
				var_492_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_492_6 = var_492_5:GetComponent("SpriteRenderer")

				if var_492_6 and var_492_6.sprite then
					local var_492_7 = (var_492_5.transform.localPosition - var_492_3).z
					local var_492_8 = manager.ui.mainCameraCom_
					local var_492_9 = 2 * var_492_7 * Mathf.Tan(var_492_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_492_10 = var_492_9 * var_492_8.aspect
					local var_492_11 = var_492_6.sprite.bounds.size.x
					local var_492_12 = var_492_6.sprite.bounds.size.y
					local var_492_13 = var_492_10 / var_492_11
					local var_492_14 = var_492_9 / var_492_12
					local var_492_15 = var_492_14 < var_492_13 and var_492_13 or var_492_14

					var_492_5.transform.localScale = Vector3.New(var_492_15, var_492_15, 0)
				end

				for iter_492_0, iter_492_1 in pairs(arg_489_1.bgs_) do
					if iter_492_0 ~= "ST01" then
						iter_492_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_492_16 = 3.999999999999

			if var_492_16 < arg_489_1.time_ and arg_489_1.time_ <= var_492_16 + arg_492_0 then
				arg_489_1.allBtn_.enabled = false
			end

			local var_492_17 = 0.3

			if arg_489_1.time_ >= var_492_16 + var_492_17 and arg_489_1.time_ < var_492_16 + var_492_17 + arg_492_0 then
				arg_489_1.allBtn_.enabled = true
			end

			local var_492_18 = 0

			if var_492_18 < arg_489_1.time_ and arg_489_1.time_ <= var_492_18 + arg_492_0 then
				arg_489_1.mask_.enabled = true
				arg_489_1.mask_.raycastTarget = true

				arg_489_1:SetGaussion(false)
			end

			local var_492_19 = 2

			if var_492_18 <= arg_489_1.time_ and arg_489_1.time_ < var_492_18 + var_492_19 then
				local var_492_20 = (arg_489_1.time_ - var_492_18) / var_492_19
				local var_492_21 = Color.New(0, 0, 0)

				var_492_21.a = Mathf.Lerp(0, 1, var_492_20)
				arg_489_1.mask_.color = var_492_21
			end

			if arg_489_1.time_ >= var_492_18 + var_492_19 and arg_489_1.time_ < var_492_18 + var_492_19 + arg_492_0 then
				local var_492_22 = Color.New(0, 0, 0)

				var_492_22.a = 1
				arg_489_1.mask_.color = var_492_22
			end

			local var_492_23 = 2

			if var_492_23 < arg_489_1.time_ and arg_489_1.time_ <= var_492_23 + arg_492_0 then
				arg_489_1.mask_.enabled = true
				arg_489_1.mask_.raycastTarget = true

				arg_489_1:SetGaussion(false)
			end

			local var_492_24 = 2

			if var_492_23 <= arg_489_1.time_ and arg_489_1.time_ < var_492_23 + var_492_24 then
				local var_492_25 = (arg_489_1.time_ - var_492_23) / var_492_24
				local var_492_26 = Color.New(0, 0, 0)

				var_492_26.a = Mathf.Lerp(1, 0, var_492_25)
				arg_489_1.mask_.color = var_492_26
			end

			if arg_489_1.time_ >= var_492_23 + var_492_24 and arg_489_1.time_ < var_492_23 + var_492_24 + arg_492_0 then
				local var_492_27 = Color.New(0, 0, 0)
				local var_492_28 = 0

				arg_489_1.mask_.enabled = false
				var_492_27.a = var_492_28
				arg_489_1.mask_.color = var_492_27
			end

			local var_492_29 = arg_489_1.actors_["1020ui_story"].transform
			local var_492_30 = 1.96599999815226

			if var_492_30 < arg_489_1.time_ and arg_489_1.time_ <= var_492_30 + arg_492_0 then
				arg_489_1.var_.moveOldPos1020ui_story = var_492_29.localPosition
			end

			local var_492_31 = 0.001

			if var_492_30 <= arg_489_1.time_ and arg_489_1.time_ < var_492_30 + var_492_31 then
				local var_492_32 = (arg_489_1.time_ - var_492_30) / var_492_31
				local var_492_33 = Vector3.New(0, 100, 0)

				var_492_29.localPosition = Vector3.Lerp(arg_489_1.var_.moveOldPos1020ui_story, var_492_33, var_492_32)

				local var_492_34 = manager.ui.mainCamera.transform.position - var_492_29.position

				var_492_29.forward = Vector3.New(var_492_34.x, var_492_34.y, var_492_34.z)

				local var_492_35 = var_492_29.localEulerAngles

				var_492_35.z = 0
				var_492_35.x = 0
				var_492_29.localEulerAngles = var_492_35
			end

			if arg_489_1.time_ >= var_492_30 + var_492_31 and arg_489_1.time_ < var_492_30 + var_492_31 + arg_492_0 then
				var_492_29.localPosition = Vector3.New(0, 100, 0)

				local var_492_36 = manager.ui.mainCamera.transform.position - var_492_29.position

				var_492_29.forward = Vector3.New(var_492_36.x, var_492_36.y, var_492_36.z)

				local var_492_37 = var_492_29.localEulerAngles

				var_492_37.z = 0
				var_492_37.x = 0
				var_492_29.localEulerAngles = var_492_37
			end

			local var_492_38 = arg_489_1.actors_["1020ui_story"]
			local var_492_39 = 1.96599999815226

			if var_492_39 < arg_489_1.time_ and arg_489_1.time_ <= var_492_39 + arg_492_0 and not isNil(var_492_38) and arg_489_1.var_.characterEffect1020ui_story == nil then
				arg_489_1.var_.characterEffect1020ui_story = var_492_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_492_40 = 0.034000001847744

			if var_492_39 <= arg_489_1.time_ and arg_489_1.time_ < var_492_39 + var_492_40 and not isNil(var_492_38) then
				local var_492_41 = (arg_489_1.time_ - var_492_39) / var_492_40

				if arg_489_1.var_.characterEffect1020ui_story and not isNil(var_492_38) then
					local var_492_42 = Mathf.Lerp(0, 0.5, var_492_41)

					arg_489_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_489_1.var_.characterEffect1020ui_story.fillRatio = var_492_42
				end
			end

			if arg_489_1.time_ >= var_492_39 + var_492_40 and arg_489_1.time_ < var_492_39 + var_492_40 + arg_492_0 and not isNil(var_492_38) and arg_489_1.var_.characterEffect1020ui_story then
				local var_492_43 = 0.5

				arg_489_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_489_1.var_.characterEffect1020ui_story.fillRatio = var_492_43
			end

			if arg_489_1.frameCnt_ <= 1 then
				arg_489_1.dialog_:SetActive(false)
			end

			local var_492_44 = 3.999999999999
			local var_492_45 = 1.25

			if var_492_44 < arg_489_1.time_ and arg_489_1.time_ <= var_492_44 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0

				arg_489_1.dialog_:SetActive(true)

				arg_489_1.dialogCg_.alpha = 0

				local var_492_46 = LeanTween.value(arg_489_1.dialog_, 0, 1, 0.3)

				var_492_46:setOnUpdate(LuaHelper.FloatAction(function(arg_493_0)
					arg_489_1.dialogCg_.alpha = arg_493_0
				end))
				var_492_46:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_489_1.dialog_)
					var_492_46:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_489_1.duration_ = arg_489_1.duration_ + 0.3

				SetActive(arg_489_1.leftNameGo_, false)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_489_1.iconTrs_.gameObject, false)
				arg_489_1.callingController_:SetSelectedState("normal")

				local var_492_47 = arg_489_1:GetWordFromCfg(924011119)
				local var_492_48 = arg_489_1:FormatText(var_492_47.content)

				arg_489_1.text_.text = var_492_48

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_49 = 50
				local var_492_50 = utf8.len(var_492_48)
				local var_492_51 = var_492_49 <= 0 and var_492_45 or var_492_45 * (var_492_50 / var_492_49)

				if var_492_51 > 0 and var_492_45 < var_492_51 then
					arg_489_1.talkMaxDuration = var_492_51
					var_492_44 = var_492_44 + 0.3

					if var_492_51 + var_492_44 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_51 + var_492_44
					end
				end

				arg_489_1.text_.text = var_492_48
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)
				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_52 = var_492_44 + 0.3
			local var_492_53 = math.max(var_492_45, arg_489_1.talkMaxDuration)

			if var_492_52 <= arg_489_1.time_ and arg_489_1.time_ < var_492_52 + var_492_53 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - var_492_52) / var_492_53

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= var_492_52 + var_492_53 and arg_489_1.time_ < var_492_52 + var_492_53 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_489_1:InitPlayNodeList()
	end,
	Play924011120 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 924011120
		arg_495_1.duration_ = 5

		SetActive(arg_495_1.tipsGo_, false)

		function arg_495_1.onSingleLineFinish_()
			arg_495_1.onSingleLineUpdate_ = nil
			arg_495_1.onSingleLineFinish_ = nil
			arg_495_1.state_ = "waiting"
		end

		function arg_495_1.playNext_(arg_497_0)
			if arg_497_0 == 1 then
				arg_495_0:Play924011121(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			local var_498_0 = 0
			local var_498_1 = 0.95

			if var_498_0 < arg_495_1.time_ and arg_495_1.time_ <= var_498_0 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0
				arg_495_1.dialogCg_.alpha = 1

				arg_495_1.dialog_:SetActive(true)
				SetActive(arg_495_1.leftNameGo_, false)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_495_1.iconTrs_.gameObject, false)
				arg_495_1.callingController_:SetSelectedState("normal")

				local var_498_2 = arg_495_1:GetWordFromCfg(924011120)
				local var_498_3 = arg_495_1:FormatText(var_498_2.content)

				arg_495_1.text_.text = var_498_3

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_4 = 38
				local var_498_5 = utf8.len(var_498_3)
				local var_498_6 = var_498_4 <= 0 and var_498_1 or var_498_1 * (var_498_5 / var_498_4)

				if var_498_6 > 0 and var_498_1 < var_498_6 then
					arg_495_1.talkMaxDuration = var_498_6

					if var_498_6 + var_498_0 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_6 + var_498_0
					end
				end

				arg_495_1.text_.text = var_498_3
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)
				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_7 = math.max(var_498_1, arg_495_1.talkMaxDuration)

			if var_498_0 <= arg_495_1.time_ and arg_495_1.time_ < var_498_0 + var_498_7 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - var_498_0) / var_498_7

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= var_498_0 + var_498_7 and arg_495_1.time_ < var_498_0 + var_498_7 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end

		arg_495_1.nodeConfigList_ = {}

		arg_495_1:InitPlayNodeList()
	end,
	Play924011121 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 924011121
		arg_499_1.duration_ = 5.7

		local var_499_0 = {
			zh = 3.5,
			ja = 5.7
		}
		local var_499_1 = manager.audio:GetLocalizationFlag()

		if var_499_0[var_499_1] ~= nil then
			arg_499_1.duration_ = var_499_0[var_499_1]
		end

		SetActive(arg_499_1.tipsGo_, false)

		function arg_499_1.onSingleLineFinish_()
			arg_499_1.onSingleLineUpdate_ = nil
			arg_499_1.onSingleLineFinish_ = nil
			arg_499_1.state_ = "waiting"
		end

		function arg_499_1.playNext_(arg_501_0)
			if arg_501_0 == 1 then
				arg_499_0:Play924011122(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			local var_502_0 = arg_499_1.actors_["1020ui_story"].transform
			local var_502_1 = 0

			if var_502_1 < arg_499_1.time_ and arg_499_1.time_ <= var_502_1 + arg_502_0 then
				arg_499_1.var_.moveOldPos1020ui_story = var_502_0.localPosition
			end

			local var_502_2 = 0.001

			if var_502_1 <= arg_499_1.time_ and arg_499_1.time_ < var_502_1 + var_502_2 then
				local var_502_3 = (arg_499_1.time_ - var_502_1) / var_502_2
				local var_502_4 = Vector3.New(0, -0.85, -6.25)

				var_502_0.localPosition = Vector3.Lerp(arg_499_1.var_.moveOldPos1020ui_story, var_502_4, var_502_3)

				local var_502_5 = manager.ui.mainCamera.transform.position - var_502_0.position

				var_502_0.forward = Vector3.New(var_502_5.x, var_502_5.y, var_502_5.z)

				local var_502_6 = var_502_0.localEulerAngles

				var_502_6.z = 0
				var_502_6.x = 0
				var_502_0.localEulerAngles = var_502_6
			end

			if arg_499_1.time_ >= var_502_1 + var_502_2 and arg_499_1.time_ < var_502_1 + var_502_2 + arg_502_0 then
				var_502_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_502_7 = manager.ui.mainCamera.transform.position - var_502_0.position

				var_502_0.forward = Vector3.New(var_502_7.x, var_502_7.y, var_502_7.z)

				local var_502_8 = var_502_0.localEulerAngles

				var_502_8.z = 0
				var_502_8.x = 0
				var_502_0.localEulerAngles = var_502_8
			end

			local var_502_9 = arg_499_1.actors_["1020ui_story"]
			local var_502_10 = 0

			if var_502_10 < arg_499_1.time_ and arg_499_1.time_ <= var_502_10 + arg_502_0 and not isNil(var_502_9) and arg_499_1.var_.characterEffect1020ui_story == nil then
				arg_499_1.var_.characterEffect1020ui_story = var_502_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_502_11 = 0.200000002980232

			if var_502_10 <= arg_499_1.time_ and arg_499_1.time_ < var_502_10 + var_502_11 and not isNil(var_502_9) then
				local var_502_12 = (arg_499_1.time_ - var_502_10) / var_502_11

				if arg_499_1.var_.characterEffect1020ui_story and not isNil(var_502_9) then
					arg_499_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_499_1.time_ >= var_502_10 + var_502_11 and arg_499_1.time_ < var_502_10 + var_502_11 + arg_502_0 and not isNil(var_502_9) and arg_499_1.var_.characterEffect1020ui_story then
				arg_499_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_502_13 = 0

			if var_502_13 < arg_499_1.time_ and arg_499_1.time_ <= var_502_13 + arg_502_0 then
				arg_499_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_502_14 = 0

			if var_502_14 < arg_499_1.time_ and arg_499_1.time_ <= var_502_14 + arg_502_0 then
				arg_499_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action3_1")
			end

			local var_502_15 = 0
			local var_502_16 = 0.35

			if var_502_15 < arg_499_1.time_ and arg_499_1.time_ <= var_502_15 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, true)

				local var_502_17 = arg_499_1:FormatText(StoryNameCfg[613].name)

				arg_499_1.leftNameTxt_.text = var_502_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_499_1.leftNameTxt_.transform)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1.leftNameTxt_.text)
				SetActive(arg_499_1.iconTrs_.gameObject, false)
				arg_499_1.callingController_:SetSelectedState("normal")

				local var_502_18 = arg_499_1:GetWordFromCfg(924011121)
				local var_502_19 = arg_499_1:FormatText(var_502_18.content)

				arg_499_1.text_.text = var_502_19

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_20 = 14
				local var_502_21 = utf8.len(var_502_19)
				local var_502_22 = var_502_20 <= 0 and var_502_16 or var_502_16 * (var_502_21 / var_502_20)

				if var_502_22 > 0 and var_502_16 < var_502_22 then
					arg_499_1.talkMaxDuration = var_502_22

					if var_502_22 + var_502_15 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_22 + var_502_15
					end
				end

				arg_499_1.text_.text = var_502_19
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011121", "story_v_side_old_924011.awb") ~= 0 then
					local var_502_23 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011121", "story_v_side_old_924011.awb") / 1000

					if var_502_23 + var_502_15 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_23 + var_502_15
					end

					if var_502_18.prefab_name ~= "" and arg_499_1.actors_[var_502_18.prefab_name] ~= nil then
						local var_502_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_499_1.actors_[var_502_18.prefab_name].transform, "story_v_side_old_924011", "924011121", "story_v_side_old_924011.awb")

						arg_499_1:RecordAudio("924011121", var_502_24)
						arg_499_1:RecordAudio("924011121", var_502_24)
					else
						arg_499_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011121", "story_v_side_old_924011.awb")
					end

					arg_499_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011121", "story_v_side_old_924011.awb")
				end

				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_25 = math.max(var_502_16, arg_499_1.talkMaxDuration)

			if var_502_15 <= arg_499_1.time_ and arg_499_1.time_ < var_502_15 + var_502_25 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - var_502_15) / var_502_25

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= var_502_15 + var_502_25 and arg_499_1.time_ < var_502_15 + var_502_25 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end

		arg_499_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_499_1:InitPlayNodeList()
	end,
	Play924011122 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 924011122
		arg_503_1.duration_ = 5

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play924011123(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			local var_506_0 = arg_503_1.actors_["1020ui_story"]
			local var_506_1 = 0

			if var_506_1 < arg_503_1.time_ and arg_503_1.time_ <= var_506_1 + arg_506_0 and not isNil(var_506_0) and arg_503_1.var_.characterEffect1020ui_story == nil then
				arg_503_1.var_.characterEffect1020ui_story = var_506_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_506_2 = 0.200000002980232

			if var_506_1 <= arg_503_1.time_ and arg_503_1.time_ < var_506_1 + var_506_2 and not isNil(var_506_0) then
				local var_506_3 = (arg_503_1.time_ - var_506_1) / var_506_2

				if arg_503_1.var_.characterEffect1020ui_story and not isNil(var_506_0) then
					local var_506_4 = Mathf.Lerp(0, 0.5, var_506_3)

					arg_503_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_503_1.var_.characterEffect1020ui_story.fillRatio = var_506_4
				end
			end

			if arg_503_1.time_ >= var_506_1 + var_506_2 and arg_503_1.time_ < var_506_1 + var_506_2 + arg_506_0 and not isNil(var_506_0) and arg_503_1.var_.characterEffect1020ui_story then
				local var_506_5 = 0.5

				arg_503_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_503_1.var_.characterEffect1020ui_story.fillRatio = var_506_5
			end

			local var_506_6 = 0
			local var_506_7 = 0.225

			if var_506_6 < arg_503_1.time_ and arg_503_1.time_ <= var_506_6 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, true)

				local var_506_8 = arg_503_1:FormatText(StoryNameCfg[7].name)

				arg_503_1.leftNameTxt_.text = var_506_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_503_1.leftNameTxt_.transform)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1.leftNameTxt_.text)
				SetActive(arg_503_1.iconTrs_.gameObject, true)
				arg_503_1.iconController_:SetSelectedState("hero")

				arg_503_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_503_1.callingController_:SetSelectedState("normal")

				arg_503_1.keyicon_.color = Color.New(1, 1, 1)
				arg_503_1.icon_.color = Color.New(1, 1, 1)

				local var_506_9 = arg_503_1:GetWordFromCfg(924011122)
				local var_506_10 = arg_503_1:FormatText(var_506_9.content)

				arg_503_1.text_.text = var_506_10

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_11 = 9
				local var_506_12 = utf8.len(var_506_10)
				local var_506_13 = var_506_11 <= 0 and var_506_7 or var_506_7 * (var_506_12 / var_506_11)

				if var_506_13 > 0 and var_506_7 < var_506_13 then
					arg_503_1.talkMaxDuration = var_506_13

					if var_506_13 + var_506_6 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_13 + var_506_6
					end
				end

				arg_503_1.text_.text = var_506_10
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)
				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_14 = math.max(var_506_7, arg_503_1.talkMaxDuration)

			if var_506_6 <= arg_503_1.time_ and arg_503_1.time_ < var_506_6 + var_506_14 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - var_506_6) / var_506_14

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= var_506_6 + var_506_14 and arg_503_1.time_ < var_506_6 + var_506_14 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {}

		arg_503_1:InitPlayNodeList()
	end,
	Play924011123 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 924011123
		arg_507_1.duration_ = 5

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play924011124(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			local var_510_0 = arg_507_1.actors_["1020ui_story"].transform
			local var_510_1 = 0

			if var_510_1 < arg_507_1.time_ and arg_507_1.time_ <= var_510_1 + arg_510_0 then
				arg_507_1.var_.moveOldPos1020ui_story = var_510_0.localPosition
			end

			local var_510_2 = 0.001

			if var_510_1 <= arg_507_1.time_ and arg_507_1.time_ < var_510_1 + var_510_2 then
				local var_510_3 = (arg_507_1.time_ - var_510_1) / var_510_2
				local var_510_4 = Vector3.New(0, 100, 0)

				var_510_0.localPosition = Vector3.Lerp(arg_507_1.var_.moveOldPos1020ui_story, var_510_4, var_510_3)

				local var_510_5 = manager.ui.mainCamera.transform.position - var_510_0.position

				var_510_0.forward = Vector3.New(var_510_5.x, var_510_5.y, var_510_5.z)

				local var_510_6 = var_510_0.localEulerAngles

				var_510_6.z = 0
				var_510_6.x = 0
				var_510_0.localEulerAngles = var_510_6
			end

			if arg_507_1.time_ >= var_510_1 + var_510_2 and arg_507_1.time_ < var_510_1 + var_510_2 + arg_510_0 then
				var_510_0.localPosition = Vector3.New(0, 100, 0)

				local var_510_7 = manager.ui.mainCamera.transform.position - var_510_0.position

				var_510_0.forward = Vector3.New(var_510_7.x, var_510_7.y, var_510_7.z)

				local var_510_8 = var_510_0.localEulerAngles

				var_510_8.z = 0
				var_510_8.x = 0
				var_510_0.localEulerAngles = var_510_8
			end

			local var_510_9 = 0
			local var_510_10 = 1.05

			if var_510_9 < arg_507_1.time_ and arg_507_1.time_ <= var_510_9 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, false)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_507_1.iconTrs_.gameObject, false)
				arg_507_1.callingController_:SetSelectedState("normal")

				local var_510_11 = arg_507_1:GetWordFromCfg(924011123)
				local var_510_12 = arg_507_1:FormatText(var_510_11.content)

				arg_507_1.text_.text = var_510_12

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_13 = 42
				local var_510_14 = utf8.len(var_510_12)
				local var_510_15 = var_510_13 <= 0 and var_510_10 or var_510_10 * (var_510_14 / var_510_13)

				if var_510_15 > 0 and var_510_10 < var_510_15 then
					arg_507_1.talkMaxDuration = var_510_15

					if var_510_15 + var_510_9 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_15 + var_510_9
					end
				end

				arg_507_1.text_.text = var_510_12
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)
				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_16 = math.max(var_510_10, arg_507_1.talkMaxDuration)

			if var_510_9 <= arg_507_1.time_ and arg_507_1.time_ < var_510_9 + var_510_16 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - var_510_9) / var_510_16

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= var_510_9 + var_510_16 and arg_507_1.time_ < var_510_9 + var_510_16 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_507_1:InitPlayNodeList()
	end,
	Play924011124 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 924011124
		arg_511_1.duration_ = 5

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play924011125(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			local var_514_0 = 0
			local var_514_1 = 0.2

			if var_514_0 < arg_511_1.time_ and arg_511_1.time_ <= var_514_0 + arg_514_0 then
				local var_514_2 = "play"
				local var_514_3 = "music"

				arg_511_1:AudioAction(var_514_2, var_514_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_514_4 = ""
				local var_514_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_514_5 ~= "" then
					if arg_511_1.bgmTxt_.text ~= var_514_5 and arg_511_1.bgmTxt_.text ~= "" then
						if arg_511_1.bgmTxt2_.text ~= "" then
							arg_511_1.bgmTxt_.text = arg_511_1.bgmTxt2_.text
						end

						arg_511_1.bgmTxt2_.text = var_514_5

						arg_511_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_511_1.bgmTxt_.text = var_514_5
						arg_511_1.bgmTxt2_.text = var_514_5
					end

					if arg_511_1.bgmTimer then
						arg_511_1.bgmTimer:Stop()

						arg_511_1.bgmTimer = nil
					end

					if arg_511_1.settingData.show_music_name == 1 then
						arg_511_1.musicController:SetSelectedState("show")
						arg_511_1.musicAnimator_:Play("open", 0, 0)

						if arg_511_1.settingData.music_time ~= 0 then
							arg_511_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_511_1.settingData.music_time), function()
								if arg_511_1 == nil or isNil(arg_511_1.bgmTxt_) then
									return
								end

								arg_511_1.musicController:SetSelectedState("hide")
								arg_511_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_514_6 = 0
			local var_514_7 = 1.05

			if var_514_6 < arg_511_1.time_ and arg_511_1.time_ <= var_514_6 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, false)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_511_1.iconTrs_.gameObject, false)
				arg_511_1.callingController_:SetSelectedState("normal")

				local var_514_8 = arg_511_1:GetWordFromCfg(924011124)
				local var_514_9 = arg_511_1:FormatText(var_514_8.content)

				arg_511_1.text_.text = var_514_9

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_10 = 42
				local var_514_11 = utf8.len(var_514_9)
				local var_514_12 = var_514_10 <= 0 and var_514_7 or var_514_7 * (var_514_11 / var_514_10)

				if var_514_12 > 0 and var_514_7 < var_514_12 then
					arg_511_1.talkMaxDuration = var_514_12

					if var_514_12 + var_514_6 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_12 + var_514_6
					end
				end

				arg_511_1.text_.text = var_514_9
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)
				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_13 = math.max(var_514_7, arg_511_1.talkMaxDuration)

			if var_514_6 <= arg_511_1.time_ and arg_511_1.time_ < var_514_6 + var_514_13 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - var_514_6) / var_514_13

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= var_514_6 + var_514_13 and arg_511_1.time_ < var_514_6 + var_514_13 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {}

		arg_511_1:InitPlayNodeList()
	end,
	Play924011125 = function(arg_516_0, arg_516_1)
		arg_516_1.time_ = 0
		arg_516_1.frameCnt_ = 0
		arg_516_1.state_ = "playing"
		arg_516_1.curTalkId_ = 924011125
		arg_516_1.duration_ = 6.93

		local var_516_0 = {
			zh = 6.10000000298023,
			ja = 6.93300000298023
		}
		local var_516_1 = manager.audio:GetLocalizationFlag()

		if var_516_0[var_516_1] ~= nil then
			arg_516_1.duration_ = var_516_0[var_516_1]
		end

		SetActive(arg_516_1.tipsGo_, false)

		function arg_516_1.onSingleLineFinish_()
			arg_516_1.onSingleLineUpdate_ = nil
			arg_516_1.onSingleLineFinish_ = nil
			arg_516_1.state_ = "waiting"
		end

		function arg_516_1.playNext_(arg_518_0)
			if arg_518_0 == 1 then
				arg_516_0:Play924011126(arg_516_1)
			end
		end

		function arg_516_1.onSingleLineUpdate_(arg_519_0)
			local var_519_0 = 2

			if var_519_0 < arg_516_1.time_ and arg_516_1.time_ <= var_519_0 + arg_519_0 then
				local var_519_1 = manager.ui.mainCamera.transform.localPosition
				local var_519_2 = Vector3.New(0, 0, 10) + Vector3.New(var_519_1.x, var_519_1.y, 0)
				local var_519_3 = arg_516_1.bgs_.ST01

				var_519_3.transform.localPosition = var_519_2
				var_519_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_519_4 = var_519_3:GetComponent("SpriteRenderer")

				if var_519_4 and var_519_4.sprite then
					local var_519_5 = (var_519_3.transform.localPosition - var_519_1).z
					local var_519_6 = manager.ui.mainCameraCom_
					local var_519_7 = 2 * var_519_5 * Mathf.Tan(var_519_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_519_8 = var_519_7 * var_519_6.aspect
					local var_519_9 = var_519_4.sprite.bounds.size.x
					local var_519_10 = var_519_4.sprite.bounds.size.y
					local var_519_11 = var_519_8 / var_519_9
					local var_519_12 = var_519_7 / var_519_10
					local var_519_13 = var_519_12 < var_519_11 and var_519_11 or var_519_12

					var_519_3.transform.localScale = Vector3.New(var_519_13, var_519_13, 0)
				end

				for iter_519_0, iter_519_1 in pairs(arg_516_1.bgs_) do
					if iter_519_0 ~= "ST01" then
						iter_519_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_519_14 = 3.999999999999

			if var_519_14 < arg_516_1.time_ and arg_516_1.time_ <= var_519_14 + arg_519_0 then
				arg_516_1.allBtn_.enabled = false
			end

			local var_519_15 = 0.3

			if arg_516_1.time_ >= var_519_14 + var_519_15 and arg_516_1.time_ < var_519_14 + var_519_15 + arg_519_0 then
				arg_516_1.allBtn_.enabled = true
			end

			local var_519_16 = 0

			if var_519_16 < arg_516_1.time_ and arg_516_1.time_ <= var_519_16 + arg_519_0 then
				arg_516_1.mask_.enabled = true
				arg_516_1.mask_.raycastTarget = true

				arg_516_1:SetGaussion(false)
			end

			local var_519_17 = 2

			if var_519_16 <= arg_516_1.time_ and arg_516_1.time_ < var_519_16 + var_519_17 then
				local var_519_18 = (arg_516_1.time_ - var_519_16) / var_519_17
				local var_519_19 = Color.New(0, 0, 0)

				var_519_19.a = Mathf.Lerp(0, 1, var_519_18)
				arg_516_1.mask_.color = var_519_19
			end

			if arg_516_1.time_ >= var_519_16 + var_519_17 and arg_516_1.time_ < var_519_16 + var_519_17 + arg_519_0 then
				local var_519_20 = Color.New(0, 0, 0)

				var_519_20.a = 1
				arg_516_1.mask_.color = var_519_20
			end

			local var_519_21 = 2

			if var_519_21 < arg_516_1.time_ and arg_516_1.time_ <= var_519_21 + arg_519_0 then
				arg_516_1.mask_.enabled = true
				arg_516_1.mask_.raycastTarget = true

				arg_516_1:SetGaussion(false)
			end

			local var_519_22 = 2

			if var_519_21 <= arg_516_1.time_ and arg_516_1.time_ < var_519_21 + var_519_22 then
				local var_519_23 = (arg_516_1.time_ - var_519_21) / var_519_22
				local var_519_24 = Color.New(0, 0, 0)

				var_519_24.a = Mathf.Lerp(1, 0, var_519_23)
				arg_516_1.mask_.color = var_519_24
			end

			if arg_516_1.time_ >= var_519_21 + var_519_22 and arg_516_1.time_ < var_519_21 + var_519_22 + arg_519_0 then
				local var_519_25 = Color.New(0, 0, 0)
				local var_519_26 = 0

				arg_516_1.mask_.enabled = false
				var_519_25.a = var_519_26
				arg_516_1.mask_.color = var_519_25
			end

			local var_519_27 = arg_516_1.actors_["1020ui_story"].transform
			local var_519_28 = 1.96599999815226

			if var_519_28 < arg_516_1.time_ and arg_516_1.time_ <= var_519_28 + arg_519_0 then
				arg_516_1.var_.moveOldPos1020ui_story = var_519_27.localPosition
			end

			local var_519_29 = 0.001

			if var_519_28 <= arg_516_1.time_ and arg_516_1.time_ < var_519_28 + var_519_29 then
				local var_519_30 = (arg_516_1.time_ - var_519_28) / var_519_29
				local var_519_31 = Vector3.New(0, 100, 0)

				var_519_27.localPosition = Vector3.Lerp(arg_516_1.var_.moveOldPos1020ui_story, var_519_31, var_519_30)

				local var_519_32 = manager.ui.mainCamera.transform.position - var_519_27.position

				var_519_27.forward = Vector3.New(var_519_32.x, var_519_32.y, var_519_32.z)

				local var_519_33 = var_519_27.localEulerAngles

				var_519_33.z = 0
				var_519_33.x = 0
				var_519_27.localEulerAngles = var_519_33
			end

			if arg_516_1.time_ >= var_519_28 + var_519_29 and arg_516_1.time_ < var_519_28 + var_519_29 + arg_519_0 then
				var_519_27.localPosition = Vector3.New(0, 100, 0)

				local var_519_34 = manager.ui.mainCamera.transform.position - var_519_27.position

				var_519_27.forward = Vector3.New(var_519_34.x, var_519_34.y, var_519_34.z)

				local var_519_35 = var_519_27.localEulerAngles

				var_519_35.z = 0
				var_519_35.x = 0
				var_519_27.localEulerAngles = var_519_35
			end

			local var_519_36 = arg_516_1.actors_["1020ui_story"].transform
			local var_519_37 = 3.8

			if var_519_37 < arg_516_1.time_ and arg_516_1.time_ <= var_519_37 + arg_519_0 then
				arg_516_1.var_.moveOldPos1020ui_story = var_519_36.localPosition
			end

			local var_519_38 = 0.001

			if var_519_37 <= arg_516_1.time_ and arg_516_1.time_ < var_519_37 + var_519_38 then
				local var_519_39 = (arg_516_1.time_ - var_519_37) / var_519_38
				local var_519_40 = Vector3.New(0, -0.85, -6.25)

				var_519_36.localPosition = Vector3.Lerp(arg_516_1.var_.moveOldPos1020ui_story, var_519_40, var_519_39)

				local var_519_41 = manager.ui.mainCamera.transform.position - var_519_36.position

				var_519_36.forward = Vector3.New(var_519_41.x, var_519_41.y, var_519_41.z)

				local var_519_42 = var_519_36.localEulerAngles

				var_519_42.z = 0
				var_519_42.x = 0
				var_519_36.localEulerAngles = var_519_42
			end

			if arg_516_1.time_ >= var_519_37 + var_519_38 and arg_516_1.time_ < var_519_37 + var_519_38 + arg_519_0 then
				var_519_36.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_519_43 = manager.ui.mainCamera.transform.position - var_519_36.position

				var_519_36.forward = Vector3.New(var_519_43.x, var_519_43.y, var_519_43.z)

				local var_519_44 = var_519_36.localEulerAngles

				var_519_44.z = 0
				var_519_44.x = 0
				var_519_36.localEulerAngles = var_519_44
			end

			local var_519_45 = arg_516_1.actors_["1020ui_story"]
			local var_519_46 = 3.8

			if var_519_46 < arg_516_1.time_ and arg_516_1.time_ <= var_519_46 + arg_519_0 and not isNil(var_519_45) and arg_516_1.var_.characterEffect1020ui_story == nil then
				arg_516_1.var_.characterEffect1020ui_story = var_519_45:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_519_47 = 0.200000002980232

			if var_519_46 <= arg_516_1.time_ and arg_516_1.time_ < var_519_46 + var_519_47 and not isNil(var_519_45) then
				local var_519_48 = (arg_516_1.time_ - var_519_46) / var_519_47

				if arg_516_1.var_.characterEffect1020ui_story and not isNil(var_519_45) then
					arg_516_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_516_1.time_ >= var_519_46 + var_519_47 and arg_516_1.time_ < var_519_46 + var_519_47 + arg_519_0 and not isNil(var_519_45) and arg_516_1.var_.characterEffect1020ui_story then
				arg_516_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_519_49 = 3.8

			if var_519_49 < arg_516_1.time_ and arg_516_1.time_ <= var_519_49 + arg_519_0 then
				arg_516_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_519_50 = 0
			local var_519_51 = 0.2

			if var_519_50 < arg_516_1.time_ and arg_516_1.time_ <= var_519_50 + arg_519_0 then
				local var_519_52 = "play"
				local var_519_53 = "music"

				arg_516_1:AudioAction(var_519_52, var_519_53, "ui_battle", "ui_battle_stopbgm", "")

				local var_519_54 = ""
				local var_519_55 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_519_55 ~= "" then
					if arg_516_1.bgmTxt_.text ~= var_519_55 and arg_516_1.bgmTxt_.text ~= "" then
						if arg_516_1.bgmTxt2_.text ~= "" then
							arg_516_1.bgmTxt_.text = arg_516_1.bgmTxt2_.text
						end

						arg_516_1.bgmTxt2_.text = var_519_55

						arg_516_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_516_1.bgmTxt_.text = var_519_55
						arg_516_1.bgmTxt2_.text = var_519_55
					end

					if arg_516_1.bgmTimer then
						arg_516_1.bgmTimer:Stop()

						arg_516_1.bgmTimer = nil
					end

					if arg_516_1.settingData.show_music_name == 1 then
						arg_516_1.musicController:SetSelectedState("show")
						arg_516_1.musicAnimator_:Play("open", 0, 0)

						if arg_516_1.settingData.music_time ~= 0 then
							arg_516_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_516_1.settingData.music_time), function()
								if arg_516_1 == nil or isNil(arg_516_1.bgmTxt_) then
									return
								end

								arg_516_1.musicController:SetSelectedState("hide")
								arg_516_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_519_56 = 0.466666666666667
			local var_519_57 = 1

			if var_519_56 < arg_516_1.time_ and arg_516_1.time_ <= var_519_56 + arg_519_0 then
				local var_519_58 = "play"
				local var_519_59 = "music"

				arg_516_1:AudioAction(var_519_58, var_519_59, "bgm_activity_3_6_story_shashvat_quiet", "bgm_activity_3_6_story_shashvat_quiet", "bgm_activity_3_6_story_shashvat_quiet.awb")

				local var_519_60 = ""
				local var_519_61 = manager.audio:GetAudioName("bgm_activity_3_6_story_shashvat_quiet", "bgm_activity_3_6_story_shashvat_quiet")

				if var_519_61 ~= "" then
					if arg_516_1.bgmTxt_.text ~= var_519_61 and arg_516_1.bgmTxt_.text ~= "" then
						if arg_516_1.bgmTxt2_.text ~= "" then
							arg_516_1.bgmTxt_.text = arg_516_1.bgmTxt2_.text
						end

						arg_516_1.bgmTxt2_.text = var_519_61

						arg_516_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_516_1.bgmTxt_.text = var_519_61
						arg_516_1.bgmTxt2_.text = var_519_61
					end

					if arg_516_1.bgmTimer then
						arg_516_1.bgmTimer:Stop()

						arg_516_1.bgmTimer = nil
					end

					if arg_516_1.settingData.show_music_name == 1 then
						arg_516_1.musicController:SetSelectedState("show")
						arg_516_1.musicAnimator_:Play("open", 0, 0)

						if arg_516_1.settingData.music_time ~= 0 then
							arg_516_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_516_1.settingData.music_time), function()
								if arg_516_1 == nil or isNil(arg_516_1.bgmTxt_) then
									return
								end

								arg_516_1.musicController:SetSelectedState("hide")
								arg_516_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_519_62 = 3.8

			if var_519_62 < arg_516_1.time_ and arg_516_1.time_ <= var_519_62 + arg_519_0 then
				arg_516_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action10_1")
			end

			if arg_516_1.frameCnt_ <= 1 then
				arg_516_1.dialog_:SetActive(false)
			end

			local var_519_63 = 4.00000000298023
			local var_519_64 = 0.175

			if var_519_63 < arg_516_1.time_ and arg_516_1.time_ <= var_519_63 + arg_519_0 then
				arg_516_1.talkMaxDuration = 0

				arg_516_1.dialog_:SetActive(true)

				arg_516_1.dialogCg_.alpha = 0

				local var_519_65 = LeanTween.value(arg_516_1.dialog_, 0, 1, 0.3)

				var_519_65:setOnUpdate(LuaHelper.FloatAction(function(arg_522_0)
					arg_516_1.dialogCg_.alpha = arg_522_0
				end))
				var_519_65:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_516_1.dialog_)
					var_519_65:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_516_1.duration_ = arg_516_1.duration_ + 0.3

				SetActive(arg_516_1.leftNameGo_, true)

				local var_519_66 = arg_516_1:FormatText(StoryNameCfg[613].name)

				arg_516_1.leftNameTxt_.text = var_519_66

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_516_1.leftNameTxt_.transform)

				arg_516_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_516_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_516_1:RecordName(arg_516_1.leftNameTxt_.text)
				SetActive(arg_516_1.iconTrs_.gameObject, false)
				arg_516_1.callingController_:SetSelectedState("normal")

				local var_519_67 = arg_516_1:GetWordFromCfg(924011125)
				local var_519_68 = arg_516_1:FormatText(var_519_67.content)

				arg_516_1.text_.text = var_519_68

				LuaForUtil.ClearLinePrefixSymbol(arg_516_1.text_)

				local var_519_69 = 7
				local var_519_70 = utf8.len(var_519_68)
				local var_519_71 = var_519_69 <= 0 and var_519_64 or var_519_64 * (var_519_70 / var_519_69)

				if var_519_71 > 0 and var_519_64 < var_519_71 then
					arg_516_1.talkMaxDuration = var_519_71
					var_519_63 = var_519_63 + 0.3

					if var_519_71 + var_519_63 > arg_516_1.duration_ then
						arg_516_1.duration_ = var_519_71 + var_519_63
					end
				end

				arg_516_1.text_.text = var_519_68
				arg_516_1.typewritter.percent = 0

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011125", "story_v_side_old_924011.awb") ~= 0 then
					local var_519_72 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011125", "story_v_side_old_924011.awb") / 1000

					if var_519_72 + var_519_63 > arg_516_1.duration_ then
						arg_516_1.duration_ = var_519_72 + var_519_63
					end

					if var_519_67.prefab_name ~= "" and arg_516_1.actors_[var_519_67.prefab_name] ~= nil then
						local var_519_73 = LuaForUtil.PlayVoiceWithCriLipsync(arg_516_1.actors_[var_519_67.prefab_name].transform, "story_v_side_old_924011", "924011125", "story_v_side_old_924011.awb")

						arg_516_1:RecordAudio("924011125", var_519_73)
						arg_516_1:RecordAudio("924011125", var_519_73)
					else
						arg_516_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011125", "story_v_side_old_924011.awb")
					end

					arg_516_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011125", "story_v_side_old_924011.awb")
				end

				arg_516_1:RecordContent(arg_516_1.text_.text)
			end

			local var_519_74 = var_519_63 + 0.3
			local var_519_75 = math.max(var_519_64, arg_516_1.talkMaxDuration)

			if var_519_74 <= arg_516_1.time_ and arg_516_1.time_ < var_519_74 + var_519_75 then
				arg_516_1.typewritter.percent = (arg_516_1.time_ - var_519_74) / var_519_75

				arg_516_1.typewritter:SetDirty()
			end

			if arg_516_1.time_ >= var_519_74 + var_519_75 and arg_516_1.time_ < var_519_74 + var_519_75 + arg_519_0 then
				arg_516_1.typewritter.percent = 1

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(true)
			end
		end

		arg_516_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_516_1:InitPlayNodeList()
	end,
	Play924011126 = function(arg_524_0, arg_524_1)
		arg_524_1.time_ = 0
		arg_524_1.frameCnt_ = 0
		arg_524_1.state_ = "playing"
		arg_524_1.curTalkId_ = 924011126
		arg_524_1.duration_ = 5

		SetActive(arg_524_1.tipsGo_, false)

		function arg_524_1.onSingleLineFinish_()
			arg_524_1.onSingleLineUpdate_ = nil
			arg_524_1.onSingleLineFinish_ = nil
			arg_524_1.state_ = "waiting"
		end

		function arg_524_1.playNext_(arg_526_0)
			if arg_526_0 == 1 then
				arg_524_0:Play924011127(arg_524_1)
			end
		end

		function arg_524_1.onSingleLineUpdate_(arg_527_0)
			local var_527_0 = arg_524_1.actors_["1020ui_story"].transform
			local var_527_1 = 0

			if var_527_1 < arg_524_1.time_ and arg_524_1.time_ <= var_527_1 + arg_527_0 then
				arg_524_1.var_.moveOldPos1020ui_story = var_527_0.localPosition
			end

			local var_527_2 = 0.001

			if var_527_1 <= arg_524_1.time_ and arg_524_1.time_ < var_527_1 + var_527_2 then
				local var_527_3 = (arg_524_1.time_ - var_527_1) / var_527_2
				local var_527_4 = Vector3.New(0, 100, 0)

				var_527_0.localPosition = Vector3.Lerp(arg_524_1.var_.moveOldPos1020ui_story, var_527_4, var_527_3)

				local var_527_5 = manager.ui.mainCamera.transform.position - var_527_0.position

				var_527_0.forward = Vector3.New(var_527_5.x, var_527_5.y, var_527_5.z)

				local var_527_6 = var_527_0.localEulerAngles

				var_527_6.z = 0
				var_527_6.x = 0
				var_527_0.localEulerAngles = var_527_6
			end

			if arg_524_1.time_ >= var_527_1 + var_527_2 and arg_524_1.time_ < var_527_1 + var_527_2 + arg_527_0 then
				var_527_0.localPosition = Vector3.New(0, 100, 0)

				local var_527_7 = manager.ui.mainCamera.transform.position - var_527_0.position

				var_527_0.forward = Vector3.New(var_527_7.x, var_527_7.y, var_527_7.z)

				local var_527_8 = var_527_0.localEulerAngles

				var_527_8.z = 0
				var_527_8.x = 0
				var_527_0.localEulerAngles = var_527_8
			end

			local var_527_9 = arg_524_1.actors_["1020ui_story"]
			local var_527_10 = 0

			if var_527_10 < arg_524_1.time_ and arg_524_1.time_ <= var_527_10 + arg_527_0 and not isNil(var_527_9) and arg_524_1.var_.characterEffect1020ui_story == nil then
				arg_524_1.var_.characterEffect1020ui_story = var_527_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_527_11 = 0.200000002980232

			if var_527_10 <= arg_524_1.time_ and arg_524_1.time_ < var_527_10 + var_527_11 and not isNil(var_527_9) then
				local var_527_12 = (arg_524_1.time_ - var_527_10) / var_527_11

				if arg_524_1.var_.characterEffect1020ui_story and not isNil(var_527_9) then
					local var_527_13 = Mathf.Lerp(0, 0.5, var_527_12)

					arg_524_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_524_1.var_.characterEffect1020ui_story.fillRatio = var_527_13
				end
			end

			if arg_524_1.time_ >= var_527_10 + var_527_11 and arg_524_1.time_ < var_527_10 + var_527_11 + arg_527_0 and not isNil(var_527_9) and arg_524_1.var_.characterEffect1020ui_story then
				local var_527_14 = 0.5

				arg_524_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_524_1.var_.characterEffect1020ui_story.fillRatio = var_527_14
			end

			local var_527_15 = 0.125
			local var_527_16 = 1

			if var_527_15 < arg_524_1.time_ and arg_524_1.time_ <= var_527_15 + arg_527_0 then
				local var_527_17 = "play"
				local var_527_18 = "effect"

				arg_524_1:AudioAction(var_527_17, var_527_18, "se_story_139", "se_story_139_bed", "")
			end

			local var_527_19 = 0
			local var_527_20 = 0.65

			if var_527_19 < arg_524_1.time_ and arg_524_1.time_ <= var_527_19 + arg_527_0 then
				arg_524_1.talkMaxDuration = 0
				arg_524_1.dialogCg_.alpha = 1

				arg_524_1.dialog_:SetActive(true)
				SetActive(arg_524_1.leftNameGo_, false)

				arg_524_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_524_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_524_1:RecordName(arg_524_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_524_1.iconTrs_.gameObject, false)
				arg_524_1.callingController_:SetSelectedState("normal")

				local var_527_21 = arg_524_1:GetWordFromCfg(924011126)
				local var_527_22 = arg_524_1:FormatText(var_527_21.content)

				arg_524_1.text_.text = var_527_22

				LuaForUtil.ClearLinePrefixSymbol(arg_524_1.text_)

				local var_527_23 = 26
				local var_527_24 = utf8.len(var_527_22)
				local var_527_25 = var_527_23 <= 0 and var_527_20 or var_527_20 * (var_527_24 / var_527_23)

				if var_527_25 > 0 and var_527_20 < var_527_25 then
					arg_524_1.talkMaxDuration = var_527_25

					if var_527_25 + var_527_19 > arg_524_1.duration_ then
						arg_524_1.duration_ = var_527_25 + var_527_19
					end
				end

				arg_524_1.text_.text = var_527_22
				arg_524_1.typewritter.percent = 0

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(false)
				arg_524_1:RecordContent(arg_524_1.text_.text)
			end

			local var_527_26 = math.max(var_527_20, arg_524_1.talkMaxDuration)

			if var_527_19 <= arg_524_1.time_ and arg_524_1.time_ < var_527_19 + var_527_26 then
				arg_524_1.typewritter.percent = (arg_524_1.time_ - var_527_19) / var_527_26

				arg_524_1.typewritter:SetDirty()
			end

			if arg_524_1.time_ >= var_527_19 + var_527_26 and arg_524_1.time_ < var_527_19 + var_527_26 + arg_527_0 then
				arg_524_1.typewritter.percent = 1

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(true)
			end
		end

		arg_524_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_524_1:InitPlayNodeList()
	end,
	Play924011127 = function(arg_528_0, arg_528_1)
		arg_528_1.time_ = 0
		arg_528_1.frameCnt_ = 0
		arg_528_1.state_ = "playing"
		arg_528_1.curTalkId_ = 924011127
		arg_528_1.duration_ = 5

		SetActive(arg_528_1.tipsGo_, false)

		function arg_528_1.onSingleLineFinish_()
			arg_528_1.onSingleLineUpdate_ = nil
			arg_528_1.onSingleLineFinish_ = nil
			arg_528_1.state_ = "waiting"
		end

		function arg_528_1.playNext_(arg_530_0)
			if arg_530_0 == 1 then
				arg_528_0:Play924011128(arg_528_1)
			end
		end

		function arg_528_1.onSingleLineUpdate_(arg_531_0)
			local var_531_0 = 0
			local var_531_1 = 0.25

			if var_531_0 < arg_528_1.time_ and arg_528_1.time_ <= var_531_0 + arg_531_0 then
				arg_528_1.talkMaxDuration = 0
				arg_528_1.dialogCg_.alpha = 1

				arg_528_1.dialog_:SetActive(true)
				SetActive(arg_528_1.leftNameGo_, true)

				local var_531_2 = arg_528_1:FormatText(StoryNameCfg[7].name)

				arg_528_1.leftNameTxt_.text = var_531_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_528_1.leftNameTxt_.transform)

				arg_528_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_528_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_528_1:RecordName(arg_528_1.leftNameTxt_.text)
				SetActive(arg_528_1.iconTrs_.gameObject, true)
				arg_528_1.iconController_:SetSelectedState("hero")

				arg_528_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_528_1.callingController_:SetSelectedState("normal")

				arg_528_1.keyicon_.color = Color.New(1, 1, 1)
				arg_528_1.icon_.color = Color.New(1, 1, 1)

				local var_531_3 = arg_528_1:GetWordFromCfg(924011127)
				local var_531_4 = arg_528_1:FormatText(var_531_3.content)

				arg_528_1.text_.text = var_531_4

				LuaForUtil.ClearLinePrefixSymbol(arg_528_1.text_)

				local var_531_5 = 10
				local var_531_6 = utf8.len(var_531_4)
				local var_531_7 = var_531_5 <= 0 and var_531_1 or var_531_1 * (var_531_6 / var_531_5)

				if var_531_7 > 0 and var_531_1 < var_531_7 then
					arg_528_1.talkMaxDuration = var_531_7

					if var_531_7 + var_531_0 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_7 + var_531_0
					end
				end

				arg_528_1.text_.text = var_531_4
				arg_528_1.typewritter.percent = 0

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(false)
				arg_528_1:RecordContent(arg_528_1.text_.text)
			end

			local var_531_8 = math.max(var_531_1, arg_528_1.talkMaxDuration)

			if var_531_0 <= arg_528_1.time_ and arg_528_1.time_ < var_531_0 + var_531_8 then
				arg_528_1.typewritter.percent = (arg_528_1.time_ - var_531_0) / var_531_8

				arg_528_1.typewritter:SetDirty()
			end

			if arg_528_1.time_ >= var_531_0 + var_531_8 and arg_528_1.time_ < var_531_0 + var_531_8 + arg_531_0 then
				arg_528_1.typewritter.percent = 1

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(true)
			end
		end

		arg_528_1.nodeConfigList_ = {}

		arg_528_1:InitPlayNodeList()
	end,
	Play924011128 = function(arg_532_0, arg_532_1)
		arg_532_1.time_ = 0
		arg_532_1.frameCnt_ = 0
		arg_532_1.state_ = "playing"
		arg_532_1.curTalkId_ = 924011128
		arg_532_1.duration_ = 9.8

		local var_532_0 = {
			zh = 5.666,
			ja = 9.8
		}
		local var_532_1 = manager.audio:GetLocalizationFlag()

		if var_532_0[var_532_1] ~= nil then
			arg_532_1.duration_ = var_532_0[var_532_1]
		end

		SetActive(arg_532_1.tipsGo_, false)

		function arg_532_1.onSingleLineFinish_()
			arg_532_1.onSingleLineUpdate_ = nil
			arg_532_1.onSingleLineFinish_ = nil
			arg_532_1.state_ = "waiting"
		end

		function arg_532_1.playNext_(arg_534_0)
			if arg_534_0 == 1 then
				arg_532_0:Play924011129(arg_532_1)
			end
		end

		function arg_532_1.onSingleLineUpdate_(arg_535_0)
			local var_535_0 = arg_532_1.actors_["1020ui_story"].transform
			local var_535_1 = 0

			if var_535_1 < arg_532_1.time_ and arg_532_1.time_ <= var_535_1 + arg_535_0 then
				arg_532_1.var_.moveOldPos1020ui_story = var_535_0.localPosition
			end

			local var_535_2 = 0.001

			if var_535_1 <= arg_532_1.time_ and arg_532_1.time_ < var_535_1 + var_535_2 then
				local var_535_3 = (arg_532_1.time_ - var_535_1) / var_535_2
				local var_535_4 = Vector3.New(0, -0.85, -6.25)

				var_535_0.localPosition = Vector3.Lerp(arg_532_1.var_.moveOldPos1020ui_story, var_535_4, var_535_3)

				local var_535_5 = manager.ui.mainCamera.transform.position - var_535_0.position

				var_535_0.forward = Vector3.New(var_535_5.x, var_535_5.y, var_535_5.z)

				local var_535_6 = var_535_0.localEulerAngles

				var_535_6.z = 0
				var_535_6.x = 0
				var_535_0.localEulerAngles = var_535_6
			end

			if arg_532_1.time_ >= var_535_1 + var_535_2 and arg_532_1.time_ < var_535_1 + var_535_2 + arg_535_0 then
				var_535_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_535_7 = manager.ui.mainCamera.transform.position - var_535_0.position

				var_535_0.forward = Vector3.New(var_535_7.x, var_535_7.y, var_535_7.z)

				local var_535_8 = var_535_0.localEulerAngles

				var_535_8.z = 0
				var_535_8.x = 0
				var_535_0.localEulerAngles = var_535_8
			end

			local var_535_9 = arg_532_1.actors_["1020ui_story"]
			local var_535_10 = 0

			if var_535_10 < arg_532_1.time_ and arg_532_1.time_ <= var_535_10 + arg_535_0 and not isNil(var_535_9) and arg_532_1.var_.characterEffect1020ui_story == nil then
				arg_532_1.var_.characterEffect1020ui_story = var_535_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_535_11 = 0.200000002980232

			if var_535_10 <= arg_532_1.time_ and arg_532_1.time_ < var_535_10 + var_535_11 and not isNil(var_535_9) then
				local var_535_12 = (arg_532_1.time_ - var_535_10) / var_535_11

				if arg_532_1.var_.characterEffect1020ui_story and not isNil(var_535_9) then
					arg_532_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_532_1.time_ >= var_535_10 + var_535_11 and arg_532_1.time_ < var_535_10 + var_535_11 + arg_535_0 and not isNil(var_535_9) and arg_532_1.var_.characterEffect1020ui_story then
				arg_532_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_535_13 = 0
			local var_535_14 = 0.575

			if var_535_13 < arg_532_1.time_ and arg_532_1.time_ <= var_535_13 + arg_535_0 then
				arg_532_1.talkMaxDuration = 0
				arg_532_1.dialogCg_.alpha = 1

				arg_532_1.dialog_:SetActive(true)
				SetActive(arg_532_1.leftNameGo_, true)

				local var_535_15 = arg_532_1:FormatText(StoryNameCfg[613].name)

				arg_532_1.leftNameTxt_.text = var_535_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_532_1.leftNameTxt_.transform)

				arg_532_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_532_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_532_1:RecordName(arg_532_1.leftNameTxt_.text)
				SetActive(arg_532_1.iconTrs_.gameObject, false)
				arg_532_1.callingController_:SetSelectedState("normal")

				local var_535_16 = arg_532_1:GetWordFromCfg(924011128)
				local var_535_17 = arg_532_1:FormatText(var_535_16.content)

				arg_532_1.text_.text = var_535_17

				LuaForUtil.ClearLinePrefixSymbol(arg_532_1.text_)

				local var_535_18 = 23
				local var_535_19 = utf8.len(var_535_17)
				local var_535_20 = var_535_18 <= 0 and var_535_14 or var_535_14 * (var_535_19 / var_535_18)

				if var_535_20 > 0 and var_535_14 < var_535_20 then
					arg_532_1.talkMaxDuration = var_535_20

					if var_535_20 + var_535_13 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_20 + var_535_13
					end
				end

				arg_532_1.text_.text = var_535_17
				arg_532_1.typewritter.percent = 0

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011128", "story_v_side_old_924011.awb") ~= 0 then
					local var_535_21 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011128", "story_v_side_old_924011.awb") / 1000

					if var_535_21 + var_535_13 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_21 + var_535_13
					end

					if var_535_16.prefab_name ~= "" and arg_532_1.actors_[var_535_16.prefab_name] ~= nil then
						local var_535_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_532_1.actors_[var_535_16.prefab_name].transform, "story_v_side_old_924011", "924011128", "story_v_side_old_924011.awb")

						arg_532_1:RecordAudio("924011128", var_535_22)
						arg_532_1:RecordAudio("924011128", var_535_22)
					else
						arg_532_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011128", "story_v_side_old_924011.awb")
					end

					arg_532_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011128", "story_v_side_old_924011.awb")
				end

				arg_532_1:RecordContent(arg_532_1.text_.text)
			end

			local var_535_23 = math.max(var_535_14, arg_532_1.talkMaxDuration)

			if var_535_13 <= arg_532_1.time_ and arg_532_1.time_ < var_535_13 + var_535_23 then
				arg_532_1.typewritter.percent = (arg_532_1.time_ - var_535_13) / var_535_23

				arg_532_1.typewritter:SetDirty()
			end

			if arg_532_1.time_ >= var_535_13 + var_535_23 and arg_532_1.time_ < var_535_13 + var_535_23 + arg_535_0 then
				arg_532_1.typewritter.percent = 1

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(true)
			end
		end

		arg_532_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_532_1:InitPlayNodeList()
	end,
	Play924011129 = function(arg_536_0, arg_536_1)
		arg_536_1.time_ = 0
		arg_536_1.frameCnt_ = 0
		arg_536_1.state_ = "playing"
		arg_536_1.curTalkId_ = 924011129
		arg_536_1.duration_ = 5

		SetActive(arg_536_1.tipsGo_, false)

		function arg_536_1.onSingleLineFinish_()
			arg_536_1.onSingleLineUpdate_ = nil
			arg_536_1.onSingleLineFinish_ = nil
			arg_536_1.state_ = "waiting"
		end

		function arg_536_1.playNext_(arg_538_0)
			if arg_538_0 == 1 then
				arg_536_0:Play924011130(arg_536_1)
			end
		end

		function arg_536_1.onSingleLineUpdate_(arg_539_0)
			local var_539_0 = arg_536_1.actors_["1020ui_story"].transform
			local var_539_1 = 0

			if var_539_1 < arg_536_1.time_ and arg_536_1.time_ <= var_539_1 + arg_539_0 then
				arg_536_1.var_.moveOldPos1020ui_story = var_539_0.localPosition
			end

			local var_539_2 = 0.001

			if var_539_1 <= arg_536_1.time_ and arg_536_1.time_ < var_539_1 + var_539_2 then
				local var_539_3 = (arg_536_1.time_ - var_539_1) / var_539_2
				local var_539_4 = Vector3.New(0, 100, 0)

				var_539_0.localPosition = Vector3.Lerp(arg_536_1.var_.moveOldPos1020ui_story, var_539_4, var_539_3)

				local var_539_5 = manager.ui.mainCamera.transform.position - var_539_0.position

				var_539_0.forward = Vector3.New(var_539_5.x, var_539_5.y, var_539_5.z)

				local var_539_6 = var_539_0.localEulerAngles

				var_539_6.z = 0
				var_539_6.x = 0
				var_539_0.localEulerAngles = var_539_6
			end

			if arg_536_1.time_ >= var_539_1 + var_539_2 and arg_536_1.time_ < var_539_1 + var_539_2 + arg_539_0 then
				var_539_0.localPosition = Vector3.New(0, 100, 0)

				local var_539_7 = manager.ui.mainCamera.transform.position - var_539_0.position

				var_539_0.forward = Vector3.New(var_539_7.x, var_539_7.y, var_539_7.z)

				local var_539_8 = var_539_0.localEulerAngles

				var_539_8.z = 0
				var_539_8.x = 0
				var_539_0.localEulerAngles = var_539_8
			end

			local var_539_9 = arg_536_1.actors_["1020ui_story"]
			local var_539_10 = 0

			if var_539_10 < arg_536_1.time_ and arg_536_1.time_ <= var_539_10 + arg_539_0 and not isNil(var_539_9) and arg_536_1.var_.characterEffect1020ui_story == nil then
				arg_536_1.var_.characterEffect1020ui_story = var_539_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_539_11 = 0.200000002980232

			if var_539_10 <= arg_536_1.time_ and arg_536_1.time_ < var_539_10 + var_539_11 and not isNil(var_539_9) then
				local var_539_12 = (arg_536_1.time_ - var_539_10) / var_539_11

				if arg_536_1.var_.characterEffect1020ui_story and not isNil(var_539_9) then
					local var_539_13 = Mathf.Lerp(0, 0.5, var_539_12)

					arg_536_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_536_1.var_.characterEffect1020ui_story.fillRatio = var_539_13
				end
			end

			if arg_536_1.time_ >= var_539_10 + var_539_11 and arg_536_1.time_ < var_539_10 + var_539_11 + arg_539_0 and not isNil(var_539_9) and arg_536_1.var_.characterEffect1020ui_story then
				local var_539_14 = 0.5

				arg_536_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_536_1.var_.characterEffect1020ui_story.fillRatio = var_539_14
			end

			local var_539_15 = 0.125
			local var_539_16 = 1

			if var_539_15 < arg_536_1.time_ and arg_536_1.time_ <= var_539_15 + arg_539_0 then
				local var_539_17 = "play"
				local var_539_18 = "effect"

				arg_536_1:AudioAction(var_539_17, var_539_18, "se_story_139", "se_story_139_bed", "")
			end

			local var_539_19 = 0
			local var_539_20 = 0.8

			if var_539_19 < arg_536_1.time_ and arg_536_1.time_ <= var_539_19 + arg_539_0 then
				arg_536_1.talkMaxDuration = 0
				arg_536_1.dialogCg_.alpha = 1

				arg_536_1.dialog_:SetActive(true)
				SetActive(arg_536_1.leftNameGo_, false)

				arg_536_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_536_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_536_1:RecordName(arg_536_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_536_1.iconTrs_.gameObject, false)
				arg_536_1.callingController_:SetSelectedState("normal")

				local var_539_21 = arg_536_1:GetWordFromCfg(924011129)
				local var_539_22 = arg_536_1:FormatText(var_539_21.content)

				arg_536_1.text_.text = var_539_22

				LuaForUtil.ClearLinePrefixSymbol(arg_536_1.text_)

				local var_539_23 = 32
				local var_539_24 = utf8.len(var_539_22)
				local var_539_25 = var_539_23 <= 0 and var_539_20 or var_539_20 * (var_539_24 / var_539_23)

				if var_539_25 > 0 and var_539_20 < var_539_25 then
					arg_536_1.talkMaxDuration = var_539_25

					if var_539_25 + var_539_19 > arg_536_1.duration_ then
						arg_536_1.duration_ = var_539_25 + var_539_19
					end
				end

				arg_536_1.text_.text = var_539_22
				arg_536_1.typewritter.percent = 0

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(false)
				arg_536_1:RecordContent(arg_536_1.text_.text)
			end

			local var_539_26 = math.max(var_539_20, arg_536_1.talkMaxDuration)

			if var_539_19 <= arg_536_1.time_ and arg_536_1.time_ < var_539_19 + var_539_26 then
				arg_536_1.typewritter.percent = (arg_536_1.time_ - var_539_19) / var_539_26

				arg_536_1.typewritter:SetDirty()
			end

			if arg_536_1.time_ >= var_539_19 + var_539_26 and arg_536_1.time_ < var_539_19 + var_539_26 + arg_539_0 then
				arg_536_1.typewritter.percent = 1

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(true)
			end
		end

		arg_536_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_536_1:InitPlayNodeList()
	end,
	Play924011130 = function(arg_540_0, arg_540_1)
		arg_540_1.time_ = 0
		arg_540_1.frameCnt_ = 0
		arg_540_1.state_ = "playing"
		arg_540_1.curTalkId_ = 924011130
		arg_540_1.duration_ = 5

		SetActive(arg_540_1.tipsGo_, false)

		function arg_540_1.onSingleLineFinish_()
			arg_540_1.onSingleLineUpdate_ = nil
			arg_540_1.onSingleLineFinish_ = nil
			arg_540_1.state_ = "waiting"
		end

		function arg_540_1.playNext_(arg_542_0)
			if arg_542_0 == 1 then
				arg_540_0:Play924011131(arg_540_1)
			end
		end

		function arg_540_1.onSingleLineUpdate_(arg_543_0)
			local var_543_0 = 0
			local var_543_1 = 0.525

			if var_543_0 < arg_540_1.time_ and arg_540_1.time_ <= var_543_0 + arg_543_0 then
				arg_540_1.talkMaxDuration = 0
				arg_540_1.dialogCg_.alpha = 1

				arg_540_1.dialog_:SetActive(true)
				SetActive(arg_540_1.leftNameGo_, true)

				local var_543_2 = arg_540_1:FormatText(StoryNameCfg[7].name)

				arg_540_1.leftNameTxt_.text = var_543_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_540_1.leftNameTxt_.transform)

				arg_540_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_540_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_540_1:RecordName(arg_540_1.leftNameTxt_.text)
				SetActive(arg_540_1.iconTrs_.gameObject, true)
				arg_540_1.iconController_:SetSelectedState("hero")

				arg_540_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_540_1.callingController_:SetSelectedState("normal")

				arg_540_1.keyicon_.color = Color.New(1, 1, 1)
				arg_540_1.icon_.color = Color.New(1, 1, 1)

				local var_543_3 = arg_540_1:GetWordFromCfg(924011130)
				local var_543_4 = arg_540_1:FormatText(var_543_3.content)

				arg_540_1.text_.text = var_543_4

				LuaForUtil.ClearLinePrefixSymbol(arg_540_1.text_)

				local var_543_5 = 21
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
				arg_540_1:RecordContent(arg_540_1.text_.text)
			end

			local var_543_8 = math.max(var_543_1, arg_540_1.talkMaxDuration)

			if var_543_0 <= arg_540_1.time_ and arg_540_1.time_ < var_543_0 + var_543_8 then
				arg_540_1.typewritter.percent = (arg_540_1.time_ - var_543_0) / var_543_8

				arg_540_1.typewritter:SetDirty()
			end

			if arg_540_1.time_ >= var_543_0 + var_543_8 and arg_540_1.time_ < var_543_0 + var_543_8 + arg_543_0 then
				arg_540_1.typewritter.percent = 1

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(true)
			end
		end

		arg_540_1.nodeConfigList_ = {}

		arg_540_1:InitPlayNodeList()
	end,
	Play924011131 = function(arg_544_0, arg_544_1)
		arg_544_1.time_ = 0
		arg_544_1.frameCnt_ = 0
		arg_544_1.state_ = "playing"
		arg_544_1.curTalkId_ = 924011131
		arg_544_1.duration_ = 5

		SetActive(arg_544_1.tipsGo_, false)

		function arg_544_1.onSingleLineFinish_()
			arg_544_1.onSingleLineUpdate_ = nil
			arg_544_1.onSingleLineFinish_ = nil
			arg_544_1.state_ = "waiting"
		end

		function arg_544_1.playNext_(arg_546_0)
			if arg_546_0 == 1 then
				arg_544_0:Play924011132(arg_544_1)
			end
		end

		function arg_544_1.onSingleLineUpdate_(arg_547_0)
			local var_547_0 = 0
			local var_547_1 = 0.25

			if var_547_0 < arg_544_1.time_ and arg_544_1.time_ <= var_547_0 + arg_547_0 then
				arg_544_1.talkMaxDuration = 0
				arg_544_1.dialogCg_.alpha = 1

				arg_544_1.dialog_:SetActive(true)
				SetActive(arg_544_1.leftNameGo_, true)

				local var_547_2 = arg_544_1:FormatText(StoryNameCfg[7].name)

				arg_544_1.leftNameTxt_.text = var_547_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_544_1.leftNameTxt_.transform)

				arg_544_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_544_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_544_1:RecordName(arg_544_1.leftNameTxt_.text)
				SetActive(arg_544_1.iconTrs_.gameObject, true)
				arg_544_1.iconController_:SetSelectedState("hero")

				arg_544_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_544_1.callingController_:SetSelectedState("normal")

				arg_544_1.keyicon_.color = Color.New(1, 1, 1)
				arg_544_1.icon_.color = Color.New(1, 1, 1)

				local var_547_3 = arg_544_1:GetWordFromCfg(924011131)
				local var_547_4 = arg_544_1:FormatText(var_547_3.content)

				arg_544_1.text_.text = var_547_4

				LuaForUtil.ClearLinePrefixSymbol(arg_544_1.text_)

				local var_547_5 = 10
				local var_547_6 = utf8.len(var_547_4)
				local var_547_7 = var_547_5 <= 0 and var_547_1 or var_547_1 * (var_547_6 / var_547_5)

				if var_547_7 > 0 and var_547_1 < var_547_7 then
					arg_544_1.talkMaxDuration = var_547_7

					if var_547_7 + var_547_0 > arg_544_1.duration_ then
						arg_544_1.duration_ = var_547_7 + var_547_0
					end
				end

				arg_544_1.text_.text = var_547_4
				arg_544_1.typewritter.percent = 0

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(false)
				arg_544_1:RecordContent(arg_544_1.text_.text)
			end

			local var_547_8 = math.max(var_547_1, arg_544_1.talkMaxDuration)

			if var_547_0 <= arg_544_1.time_ and arg_544_1.time_ < var_547_0 + var_547_8 then
				arg_544_1.typewritter.percent = (arg_544_1.time_ - var_547_0) / var_547_8

				arg_544_1.typewritter:SetDirty()
			end

			if arg_544_1.time_ >= var_547_0 + var_547_8 and arg_544_1.time_ < var_547_0 + var_547_8 + arg_547_0 then
				arg_544_1.typewritter.percent = 1

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(true)
			end
		end

		arg_544_1.nodeConfigList_ = {}

		arg_544_1:InitPlayNodeList()
	end,
	Play924011132 = function(arg_548_0, arg_548_1)
		arg_548_1.time_ = 0
		arg_548_1.frameCnt_ = 0
		arg_548_1.state_ = "playing"
		arg_548_1.curTalkId_ = 924011132
		arg_548_1.duration_ = 5.53

		local var_548_0 = {
			zh = 4.433,
			ja = 5.533
		}
		local var_548_1 = manager.audio:GetLocalizationFlag()

		if var_548_0[var_548_1] ~= nil then
			arg_548_1.duration_ = var_548_0[var_548_1]
		end

		SetActive(arg_548_1.tipsGo_, false)

		function arg_548_1.onSingleLineFinish_()
			arg_548_1.onSingleLineUpdate_ = nil
			arg_548_1.onSingleLineFinish_ = nil
			arg_548_1.state_ = "waiting"
		end

		function arg_548_1.playNext_(arg_550_0)
			if arg_550_0 == 1 then
				arg_548_0:Play924011133(arg_548_1)
			end
		end

		function arg_548_1.onSingleLineUpdate_(arg_551_0)
			local var_551_0 = arg_548_1.actors_["1020ui_story"].transform
			local var_551_1 = 0

			if var_551_1 < arg_548_1.time_ and arg_548_1.time_ <= var_551_1 + arg_551_0 then
				arg_548_1.var_.moveOldPos1020ui_story = var_551_0.localPosition
			end

			local var_551_2 = 0.001

			if var_551_1 <= arg_548_1.time_ and arg_548_1.time_ < var_551_1 + var_551_2 then
				local var_551_3 = (arg_548_1.time_ - var_551_1) / var_551_2
				local var_551_4 = Vector3.New(0, -0.85, -6.25)

				var_551_0.localPosition = Vector3.Lerp(arg_548_1.var_.moveOldPos1020ui_story, var_551_4, var_551_3)

				local var_551_5 = manager.ui.mainCamera.transform.position - var_551_0.position

				var_551_0.forward = Vector3.New(var_551_5.x, var_551_5.y, var_551_5.z)

				local var_551_6 = var_551_0.localEulerAngles

				var_551_6.z = 0
				var_551_6.x = 0
				var_551_0.localEulerAngles = var_551_6
			end

			if arg_548_1.time_ >= var_551_1 + var_551_2 and arg_548_1.time_ < var_551_1 + var_551_2 + arg_551_0 then
				var_551_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_551_7 = manager.ui.mainCamera.transform.position - var_551_0.position

				var_551_0.forward = Vector3.New(var_551_7.x, var_551_7.y, var_551_7.z)

				local var_551_8 = var_551_0.localEulerAngles

				var_551_8.z = 0
				var_551_8.x = 0
				var_551_0.localEulerAngles = var_551_8
			end

			local var_551_9 = arg_548_1.actors_["1020ui_story"]
			local var_551_10 = 0

			if var_551_10 < arg_548_1.time_ and arg_548_1.time_ <= var_551_10 + arg_551_0 and not isNil(var_551_9) and arg_548_1.var_.characterEffect1020ui_story == nil then
				arg_548_1.var_.characterEffect1020ui_story = var_551_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_551_11 = 0.200000002980232

			if var_551_10 <= arg_548_1.time_ and arg_548_1.time_ < var_551_10 + var_551_11 and not isNil(var_551_9) then
				local var_551_12 = (arg_548_1.time_ - var_551_10) / var_551_11

				if arg_548_1.var_.characterEffect1020ui_story and not isNil(var_551_9) then
					arg_548_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_548_1.time_ >= var_551_10 + var_551_11 and arg_548_1.time_ < var_551_10 + var_551_11 + arg_551_0 and not isNil(var_551_9) and arg_548_1.var_.characterEffect1020ui_story then
				arg_548_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_551_13 = 0

			if var_551_13 < arg_548_1.time_ and arg_548_1.time_ <= var_551_13 + arg_551_0 then
				arg_548_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_551_14 = 0

			if var_551_14 < arg_548_1.time_ and arg_548_1.time_ <= var_551_14 + arg_551_0 then
				arg_548_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action7_1")
			end

			local var_551_15 = 0
			local var_551_16 = 0.475

			if var_551_15 < arg_548_1.time_ and arg_548_1.time_ <= var_551_15 + arg_551_0 then
				arg_548_1.talkMaxDuration = 0
				arg_548_1.dialogCg_.alpha = 1

				arg_548_1.dialog_:SetActive(true)
				SetActive(arg_548_1.leftNameGo_, true)

				local var_551_17 = arg_548_1:FormatText(StoryNameCfg[613].name)

				arg_548_1.leftNameTxt_.text = var_551_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_548_1.leftNameTxt_.transform)

				arg_548_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_548_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_548_1:RecordName(arg_548_1.leftNameTxt_.text)
				SetActive(arg_548_1.iconTrs_.gameObject, false)
				arg_548_1.callingController_:SetSelectedState("normal")

				local var_551_18 = arg_548_1:GetWordFromCfg(924011132)
				local var_551_19 = arg_548_1:FormatText(var_551_18.content)

				arg_548_1.text_.text = var_551_19

				LuaForUtil.ClearLinePrefixSymbol(arg_548_1.text_)

				local var_551_20 = 19
				local var_551_21 = utf8.len(var_551_19)
				local var_551_22 = var_551_20 <= 0 and var_551_16 or var_551_16 * (var_551_21 / var_551_20)

				if var_551_22 > 0 and var_551_16 < var_551_22 then
					arg_548_1.talkMaxDuration = var_551_22

					if var_551_22 + var_551_15 > arg_548_1.duration_ then
						arg_548_1.duration_ = var_551_22 + var_551_15
					end
				end

				arg_548_1.text_.text = var_551_19
				arg_548_1.typewritter.percent = 0

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011132", "story_v_side_old_924011.awb") ~= 0 then
					local var_551_23 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011132", "story_v_side_old_924011.awb") / 1000

					if var_551_23 + var_551_15 > arg_548_1.duration_ then
						arg_548_1.duration_ = var_551_23 + var_551_15
					end

					if var_551_18.prefab_name ~= "" and arg_548_1.actors_[var_551_18.prefab_name] ~= nil then
						local var_551_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_548_1.actors_[var_551_18.prefab_name].transform, "story_v_side_old_924011", "924011132", "story_v_side_old_924011.awb")

						arg_548_1:RecordAudio("924011132", var_551_24)
						arg_548_1:RecordAudio("924011132", var_551_24)
					else
						arg_548_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011132", "story_v_side_old_924011.awb")
					end

					arg_548_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011132", "story_v_side_old_924011.awb")
				end

				arg_548_1:RecordContent(arg_548_1.text_.text)
			end

			local var_551_25 = math.max(var_551_16, arg_548_1.talkMaxDuration)

			if var_551_15 <= arg_548_1.time_ and arg_548_1.time_ < var_551_15 + var_551_25 then
				arg_548_1.typewritter.percent = (arg_548_1.time_ - var_551_15) / var_551_25

				arg_548_1.typewritter:SetDirty()
			end

			if arg_548_1.time_ >= var_551_15 + var_551_25 and arg_548_1.time_ < var_551_15 + var_551_25 + arg_551_0 then
				arg_548_1.typewritter.percent = 1

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(true)
			end
		end

		arg_548_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_548_1:InitPlayNodeList()
	end,
	Play924011133 = function(arg_552_0, arg_552_1)
		arg_552_1.time_ = 0
		arg_552_1.frameCnt_ = 0
		arg_552_1.state_ = "playing"
		arg_552_1.curTalkId_ = 924011133
		arg_552_1.duration_ = 5

		SetActive(arg_552_1.tipsGo_, false)

		function arg_552_1.onSingleLineFinish_()
			arg_552_1.onSingleLineUpdate_ = nil
			arg_552_1.onSingleLineFinish_ = nil
			arg_552_1.state_ = "waiting"
		end

		function arg_552_1.playNext_(arg_554_0)
			if arg_554_0 == 1 then
				arg_552_0:Play924011134(arg_552_1)
			end
		end

		function arg_552_1.onSingleLineUpdate_(arg_555_0)
			local var_555_0 = arg_552_1.actors_["1020ui_story"]
			local var_555_1 = 0

			if var_555_1 < arg_552_1.time_ and arg_552_1.time_ <= var_555_1 + arg_555_0 and not isNil(var_555_0) and arg_552_1.var_.characterEffect1020ui_story == nil then
				arg_552_1.var_.characterEffect1020ui_story = var_555_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_555_2 = 0.200000002980232

			if var_555_1 <= arg_552_1.time_ and arg_552_1.time_ < var_555_1 + var_555_2 and not isNil(var_555_0) then
				local var_555_3 = (arg_552_1.time_ - var_555_1) / var_555_2

				if arg_552_1.var_.characterEffect1020ui_story and not isNil(var_555_0) then
					local var_555_4 = Mathf.Lerp(0, 0.5, var_555_3)

					arg_552_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_552_1.var_.characterEffect1020ui_story.fillRatio = var_555_4
				end
			end

			if arg_552_1.time_ >= var_555_1 + var_555_2 and arg_552_1.time_ < var_555_1 + var_555_2 + arg_555_0 and not isNil(var_555_0) and arg_552_1.var_.characterEffect1020ui_story then
				local var_555_5 = 0.5

				arg_552_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_552_1.var_.characterEffect1020ui_story.fillRatio = var_555_5
			end

			local var_555_6 = 0
			local var_555_7 = 0.35

			if var_555_6 < arg_552_1.time_ and arg_552_1.time_ <= var_555_6 + arg_555_0 then
				arg_552_1.talkMaxDuration = 0
				arg_552_1.dialogCg_.alpha = 1

				arg_552_1.dialog_:SetActive(true)
				SetActive(arg_552_1.leftNameGo_, true)

				local var_555_8 = arg_552_1:FormatText(StoryNameCfg[7].name)

				arg_552_1.leftNameTxt_.text = var_555_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_552_1.leftNameTxt_.transform)

				arg_552_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_552_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_552_1:RecordName(arg_552_1.leftNameTxt_.text)
				SetActive(arg_552_1.iconTrs_.gameObject, true)
				arg_552_1.iconController_:SetSelectedState("hero")

				arg_552_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_552_1.callingController_:SetSelectedState("normal")

				arg_552_1.keyicon_.color = Color.New(1, 1, 1)
				arg_552_1.icon_.color = Color.New(1, 1, 1)

				local var_555_9 = arg_552_1:GetWordFromCfg(924011133)
				local var_555_10 = arg_552_1:FormatText(var_555_9.content)

				arg_552_1.text_.text = var_555_10

				LuaForUtil.ClearLinePrefixSymbol(arg_552_1.text_)

				local var_555_11 = 14
				local var_555_12 = utf8.len(var_555_10)
				local var_555_13 = var_555_11 <= 0 and var_555_7 or var_555_7 * (var_555_12 / var_555_11)

				if var_555_13 > 0 and var_555_7 < var_555_13 then
					arg_552_1.talkMaxDuration = var_555_13

					if var_555_13 + var_555_6 > arg_552_1.duration_ then
						arg_552_1.duration_ = var_555_13 + var_555_6
					end
				end

				arg_552_1.text_.text = var_555_10
				arg_552_1.typewritter.percent = 0

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(false)
				arg_552_1:RecordContent(arg_552_1.text_.text)
			end

			local var_555_14 = math.max(var_555_7, arg_552_1.talkMaxDuration)

			if var_555_6 <= arg_552_1.time_ and arg_552_1.time_ < var_555_6 + var_555_14 then
				arg_552_1.typewritter.percent = (arg_552_1.time_ - var_555_6) / var_555_14

				arg_552_1.typewritter:SetDirty()
			end

			if arg_552_1.time_ >= var_555_6 + var_555_14 and arg_552_1.time_ < var_555_6 + var_555_14 + arg_555_0 then
				arg_552_1.typewritter.percent = 1

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(true)
			end
		end

		arg_552_1.nodeConfigList_ = {}

		arg_552_1:InitPlayNodeList()
	end,
	Play924011134 = function(arg_556_0, arg_556_1)
		arg_556_1.time_ = 0
		arg_556_1.frameCnt_ = 0
		arg_556_1.state_ = "playing"
		arg_556_1.curTalkId_ = 924011134
		arg_556_1.duration_ = 4.8

		local var_556_0 = {
			zh = 3.133,
			ja = 4.8
		}
		local var_556_1 = manager.audio:GetLocalizationFlag()

		if var_556_0[var_556_1] ~= nil then
			arg_556_1.duration_ = var_556_0[var_556_1]
		end

		SetActive(arg_556_1.tipsGo_, false)

		function arg_556_1.onSingleLineFinish_()
			arg_556_1.onSingleLineUpdate_ = nil
			arg_556_1.onSingleLineFinish_ = nil
			arg_556_1.state_ = "waiting"
		end

		function arg_556_1.playNext_(arg_558_0)
			if arg_558_0 == 1 then
				arg_556_0:Play924011135(arg_556_1)
			end
		end

		function arg_556_1.onSingleLineUpdate_(arg_559_0)
			local var_559_0 = arg_556_1.actors_["1020ui_story"].transform
			local var_559_1 = 0

			if var_559_1 < arg_556_1.time_ and arg_556_1.time_ <= var_559_1 + arg_559_0 then
				arg_556_1.var_.moveOldPos1020ui_story = var_559_0.localPosition
			end

			local var_559_2 = 0.001

			if var_559_1 <= arg_556_1.time_ and arg_556_1.time_ < var_559_1 + var_559_2 then
				local var_559_3 = (arg_556_1.time_ - var_559_1) / var_559_2
				local var_559_4 = Vector3.New(0, -0.85, -6.25)

				var_559_0.localPosition = Vector3.Lerp(arg_556_1.var_.moveOldPos1020ui_story, var_559_4, var_559_3)

				local var_559_5 = manager.ui.mainCamera.transform.position - var_559_0.position

				var_559_0.forward = Vector3.New(var_559_5.x, var_559_5.y, var_559_5.z)

				local var_559_6 = var_559_0.localEulerAngles

				var_559_6.z = 0
				var_559_6.x = 0
				var_559_0.localEulerAngles = var_559_6
			end

			if arg_556_1.time_ >= var_559_1 + var_559_2 and arg_556_1.time_ < var_559_1 + var_559_2 + arg_559_0 then
				var_559_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_559_7 = manager.ui.mainCamera.transform.position - var_559_0.position

				var_559_0.forward = Vector3.New(var_559_7.x, var_559_7.y, var_559_7.z)

				local var_559_8 = var_559_0.localEulerAngles

				var_559_8.z = 0
				var_559_8.x = 0
				var_559_0.localEulerAngles = var_559_8
			end

			local var_559_9 = arg_556_1.actors_["1020ui_story"]
			local var_559_10 = 0

			if var_559_10 < arg_556_1.time_ and arg_556_1.time_ <= var_559_10 + arg_559_0 and not isNil(var_559_9) and arg_556_1.var_.characterEffect1020ui_story == nil then
				arg_556_1.var_.characterEffect1020ui_story = var_559_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_559_11 = 0.200000002980232

			if var_559_10 <= arg_556_1.time_ and arg_556_1.time_ < var_559_10 + var_559_11 and not isNil(var_559_9) then
				local var_559_12 = (arg_556_1.time_ - var_559_10) / var_559_11

				if arg_556_1.var_.characterEffect1020ui_story and not isNil(var_559_9) then
					arg_556_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_556_1.time_ >= var_559_10 + var_559_11 and arg_556_1.time_ < var_559_10 + var_559_11 + arg_559_0 and not isNil(var_559_9) and arg_556_1.var_.characterEffect1020ui_story then
				arg_556_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_559_13 = 0

			if var_559_13 < arg_556_1.time_ and arg_556_1.time_ <= var_559_13 + arg_559_0 then
				arg_556_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaC", "EmotionTimelineAnimator")
			end

			local var_559_14 = 0

			if var_559_14 < arg_556_1.time_ and arg_556_1.time_ <= var_559_14 + arg_559_0 then
				arg_556_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action7_2")
			end

			local var_559_15 = 0
			local var_559_16 = 0.375

			if var_559_15 < arg_556_1.time_ and arg_556_1.time_ <= var_559_15 + arg_559_0 then
				arg_556_1.talkMaxDuration = 0
				arg_556_1.dialogCg_.alpha = 1

				arg_556_1.dialog_:SetActive(true)
				SetActive(arg_556_1.leftNameGo_, true)

				local var_559_17 = arg_556_1:FormatText(StoryNameCfg[613].name)

				arg_556_1.leftNameTxt_.text = var_559_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_556_1.leftNameTxt_.transform)

				arg_556_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_556_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_556_1:RecordName(arg_556_1.leftNameTxt_.text)
				SetActive(arg_556_1.iconTrs_.gameObject, false)
				arg_556_1.callingController_:SetSelectedState("normal")

				local var_559_18 = arg_556_1:GetWordFromCfg(924011134)
				local var_559_19 = arg_556_1:FormatText(var_559_18.content)

				arg_556_1.text_.text = var_559_19

				LuaForUtil.ClearLinePrefixSymbol(arg_556_1.text_)

				local var_559_20 = 15
				local var_559_21 = utf8.len(var_559_19)
				local var_559_22 = var_559_20 <= 0 and var_559_16 or var_559_16 * (var_559_21 / var_559_20)

				if var_559_22 > 0 and var_559_16 < var_559_22 then
					arg_556_1.talkMaxDuration = var_559_22

					if var_559_22 + var_559_15 > arg_556_1.duration_ then
						arg_556_1.duration_ = var_559_22 + var_559_15
					end
				end

				arg_556_1.text_.text = var_559_19
				arg_556_1.typewritter.percent = 0

				arg_556_1.typewritter:SetDirty()
				arg_556_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011134", "story_v_side_old_924011.awb") ~= 0 then
					local var_559_23 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011134", "story_v_side_old_924011.awb") / 1000

					if var_559_23 + var_559_15 > arg_556_1.duration_ then
						arg_556_1.duration_ = var_559_23 + var_559_15
					end

					if var_559_18.prefab_name ~= "" and arg_556_1.actors_[var_559_18.prefab_name] ~= nil then
						local var_559_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_556_1.actors_[var_559_18.prefab_name].transform, "story_v_side_old_924011", "924011134", "story_v_side_old_924011.awb")

						arg_556_1:RecordAudio("924011134", var_559_24)
						arg_556_1:RecordAudio("924011134", var_559_24)
					else
						arg_556_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011134", "story_v_side_old_924011.awb")
					end

					arg_556_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011134", "story_v_side_old_924011.awb")
				end

				arg_556_1:RecordContent(arg_556_1.text_.text)
			end

			local var_559_25 = math.max(var_559_16, arg_556_1.talkMaxDuration)

			if var_559_15 <= arg_556_1.time_ and arg_556_1.time_ < var_559_15 + var_559_25 then
				arg_556_1.typewritter.percent = (arg_556_1.time_ - var_559_15) / var_559_25

				arg_556_1.typewritter:SetDirty()
			end

			if arg_556_1.time_ >= var_559_15 + var_559_25 and arg_556_1.time_ < var_559_15 + var_559_25 + arg_559_0 then
				arg_556_1.typewritter.percent = 1

				arg_556_1.typewritter:SetDirty()
				arg_556_1:ShowNextGo(true)
			end
		end

		arg_556_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_556_1:InitPlayNodeList()
	end,
	Play924011135 = function(arg_560_0, arg_560_1)
		arg_560_1.time_ = 0
		arg_560_1.frameCnt_ = 0
		arg_560_1.state_ = "playing"
		arg_560_1.curTalkId_ = 924011135
		arg_560_1.duration_ = 5

		SetActive(arg_560_1.tipsGo_, false)

		function arg_560_1.onSingleLineFinish_()
			arg_560_1.onSingleLineUpdate_ = nil
			arg_560_1.onSingleLineFinish_ = nil
			arg_560_1.state_ = "waiting"
		end

		function arg_560_1.playNext_(arg_562_0)
			if arg_562_0 == 1 then
				arg_560_0:Play924011136(arg_560_1)
			end
		end

		function arg_560_1.onSingleLineUpdate_(arg_563_0)
			local var_563_0 = arg_560_1.actors_["1020ui_story"]
			local var_563_1 = 0

			if var_563_1 < arg_560_1.time_ and arg_560_1.time_ <= var_563_1 + arg_563_0 and not isNil(var_563_0) and arg_560_1.var_.characterEffect1020ui_story == nil then
				arg_560_1.var_.characterEffect1020ui_story = var_563_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_563_2 = 0.200000002980232

			if var_563_1 <= arg_560_1.time_ and arg_560_1.time_ < var_563_1 + var_563_2 and not isNil(var_563_0) then
				local var_563_3 = (arg_560_1.time_ - var_563_1) / var_563_2

				if arg_560_1.var_.characterEffect1020ui_story and not isNil(var_563_0) then
					local var_563_4 = Mathf.Lerp(0, 0.5, var_563_3)

					arg_560_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_560_1.var_.characterEffect1020ui_story.fillRatio = var_563_4
				end
			end

			if arg_560_1.time_ >= var_563_1 + var_563_2 and arg_560_1.time_ < var_563_1 + var_563_2 + arg_563_0 and not isNil(var_563_0) and arg_560_1.var_.characterEffect1020ui_story then
				local var_563_5 = 0.5

				arg_560_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_560_1.var_.characterEffect1020ui_story.fillRatio = var_563_5
			end

			local var_563_6 = 0
			local var_563_7 = 1.125

			if var_563_6 < arg_560_1.time_ and arg_560_1.time_ <= var_563_6 + arg_563_0 then
				arg_560_1.talkMaxDuration = 0
				arg_560_1.dialogCg_.alpha = 1

				arg_560_1.dialog_:SetActive(true)
				SetActive(arg_560_1.leftNameGo_, true)

				local var_563_8 = arg_560_1:FormatText(StoryNameCfg[7].name)

				arg_560_1.leftNameTxt_.text = var_563_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_560_1.leftNameTxt_.transform)

				arg_560_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_560_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_560_1:RecordName(arg_560_1.leftNameTxt_.text)
				SetActive(arg_560_1.iconTrs_.gameObject, true)
				arg_560_1.iconController_:SetSelectedState("hero")

				arg_560_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_560_1.callingController_:SetSelectedState("normal")

				arg_560_1.keyicon_.color = Color.New(1, 1, 1)
				arg_560_1.icon_.color = Color.New(1, 1, 1)

				local var_563_9 = arg_560_1:GetWordFromCfg(924011135)
				local var_563_10 = arg_560_1:FormatText(var_563_9.content)

				arg_560_1.text_.text = var_563_10

				LuaForUtil.ClearLinePrefixSymbol(arg_560_1.text_)

				local var_563_11 = 45
				local var_563_12 = utf8.len(var_563_10)
				local var_563_13 = var_563_11 <= 0 and var_563_7 or var_563_7 * (var_563_12 / var_563_11)

				if var_563_13 > 0 and var_563_7 < var_563_13 then
					arg_560_1.talkMaxDuration = var_563_13

					if var_563_13 + var_563_6 > arg_560_1.duration_ then
						arg_560_1.duration_ = var_563_13 + var_563_6
					end
				end

				arg_560_1.text_.text = var_563_10
				arg_560_1.typewritter.percent = 0

				arg_560_1.typewritter:SetDirty()
				arg_560_1:ShowNextGo(false)
				arg_560_1:RecordContent(arg_560_1.text_.text)
			end

			local var_563_14 = math.max(var_563_7, arg_560_1.talkMaxDuration)

			if var_563_6 <= arg_560_1.time_ and arg_560_1.time_ < var_563_6 + var_563_14 then
				arg_560_1.typewritter.percent = (arg_560_1.time_ - var_563_6) / var_563_14

				arg_560_1.typewritter:SetDirty()
			end

			if arg_560_1.time_ >= var_563_6 + var_563_14 and arg_560_1.time_ < var_563_6 + var_563_14 + arg_563_0 then
				arg_560_1.typewritter.percent = 1

				arg_560_1.typewritter:SetDirty()
				arg_560_1:ShowNextGo(true)
			end
		end

		arg_560_1.nodeConfigList_ = {}

		arg_560_1:InitPlayNodeList()
	end,
	Play924011136 = function(arg_564_0, arg_564_1)
		arg_564_1.time_ = 0
		arg_564_1.frameCnt_ = 0
		arg_564_1.state_ = "playing"
		arg_564_1.curTalkId_ = 924011136
		arg_564_1.duration_ = 5

		SetActive(arg_564_1.tipsGo_, false)

		function arg_564_1.onSingleLineFinish_()
			arg_564_1.onSingleLineUpdate_ = nil
			arg_564_1.onSingleLineFinish_ = nil
			arg_564_1.state_ = "waiting"
		end

		function arg_564_1.playNext_(arg_566_0)
			if arg_566_0 == 1 then
				arg_564_0:Play924011137(arg_564_1)
			end
		end

		function arg_564_1.onSingleLineUpdate_(arg_567_0)
			local var_567_0 = 0
			local var_567_1 = 0.45

			if var_567_0 < arg_564_1.time_ and arg_564_1.time_ <= var_567_0 + arg_567_0 then
				arg_564_1.talkMaxDuration = 0
				arg_564_1.dialogCg_.alpha = 1

				arg_564_1.dialog_:SetActive(true)
				SetActive(arg_564_1.leftNameGo_, true)

				local var_567_2 = arg_564_1:FormatText(StoryNameCfg[7].name)

				arg_564_1.leftNameTxt_.text = var_567_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_564_1.leftNameTxt_.transform)

				arg_564_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_564_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_564_1:RecordName(arg_564_1.leftNameTxt_.text)
				SetActive(arg_564_1.iconTrs_.gameObject, true)
				arg_564_1.iconController_:SetSelectedState("hero")

				arg_564_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_564_1.callingController_:SetSelectedState("normal")

				arg_564_1.keyicon_.color = Color.New(1, 1, 1)
				arg_564_1.icon_.color = Color.New(1, 1, 1)

				local var_567_3 = arg_564_1:GetWordFromCfg(924011136)
				local var_567_4 = arg_564_1:FormatText(var_567_3.content)

				arg_564_1.text_.text = var_567_4

				LuaForUtil.ClearLinePrefixSymbol(arg_564_1.text_)

				local var_567_5 = 18
				local var_567_6 = utf8.len(var_567_4)
				local var_567_7 = var_567_5 <= 0 and var_567_1 or var_567_1 * (var_567_6 / var_567_5)

				if var_567_7 > 0 and var_567_1 < var_567_7 then
					arg_564_1.talkMaxDuration = var_567_7

					if var_567_7 + var_567_0 > arg_564_1.duration_ then
						arg_564_1.duration_ = var_567_7 + var_567_0
					end
				end

				arg_564_1.text_.text = var_567_4
				arg_564_1.typewritter.percent = 0

				arg_564_1.typewritter:SetDirty()
				arg_564_1:ShowNextGo(false)
				arg_564_1:RecordContent(arg_564_1.text_.text)
			end

			local var_567_8 = math.max(var_567_1, arg_564_1.talkMaxDuration)

			if var_567_0 <= arg_564_1.time_ and arg_564_1.time_ < var_567_0 + var_567_8 then
				arg_564_1.typewritter.percent = (arg_564_1.time_ - var_567_0) / var_567_8

				arg_564_1.typewritter:SetDirty()
			end

			if arg_564_1.time_ >= var_567_0 + var_567_8 and arg_564_1.time_ < var_567_0 + var_567_8 + arg_567_0 then
				arg_564_1.typewritter.percent = 1

				arg_564_1.typewritter:SetDirty()
				arg_564_1:ShowNextGo(true)
			end
		end

		arg_564_1.nodeConfigList_ = {}

		arg_564_1:InitPlayNodeList()
	end,
	Play924011137 = function(arg_568_0, arg_568_1)
		arg_568_1.time_ = 0
		arg_568_1.frameCnt_ = 0
		arg_568_1.state_ = "playing"
		arg_568_1.curTalkId_ = 924011137
		arg_568_1.duration_ = 5

		SetActive(arg_568_1.tipsGo_, false)

		function arg_568_1.onSingleLineFinish_()
			arg_568_1.onSingleLineUpdate_ = nil
			arg_568_1.onSingleLineFinish_ = nil
			arg_568_1.state_ = "waiting"
		end

		function arg_568_1.playNext_(arg_570_0)
			if arg_570_0 == 1 then
				arg_568_0:Play924011138(arg_568_1)
			end
		end

		function arg_568_1.onSingleLineUpdate_(arg_571_0)
			local var_571_0 = arg_568_1.actors_["1020ui_story"].transform
			local var_571_1 = 0

			if var_571_1 < arg_568_1.time_ and arg_568_1.time_ <= var_571_1 + arg_571_0 then
				arg_568_1.var_.moveOldPos1020ui_story = var_571_0.localPosition
			end

			local var_571_2 = 0.001

			if var_571_1 <= arg_568_1.time_ and arg_568_1.time_ < var_571_1 + var_571_2 then
				local var_571_3 = (arg_568_1.time_ - var_571_1) / var_571_2
				local var_571_4 = Vector3.New(0, 100, 0)

				var_571_0.localPosition = Vector3.Lerp(arg_568_1.var_.moveOldPos1020ui_story, var_571_4, var_571_3)

				local var_571_5 = manager.ui.mainCamera.transform.position - var_571_0.position

				var_571_0.forward = Vector3.New(var_571_5.x, var_571_5.y, var_571_5.z)

				local var_571_6 = var_571_0.localEulerAngles

				var_571_6.z = 0
				var_571_6.x = 0
				var_571_0.localEulerAngles = var_571_6
			end

			if arg_568_1.time_ >= var_571_1 + var_571_2 and arg_568_1.time_ < var_571_1 + var_571_2 + arg_571_0 then
				var_571_0.localPosition = Vector3.New(0, 100, 0)

				local var_571_7 = manager.ui.mainCamera.transform.position - var_571_0.position

				var_571_0.forward = Vector3.New(var_571_7.x, var_571_7.y, var_571_7.z)

				local var_571_8 = var_571_0.localEulerAngles

				var_571_8.z = 0
				var_571_8.x = 0
				var_571_0.localEulerAngles = var_571_8
			end

			local var_571_9 = 0
			local var_571_10 = 0.825

			if var_571_9 < arg_568_1.time_ and arg_568_1.time_ <= var_571_9 + arg_571_0 then
				arg_568_1.talkMaxDuration = 0
				arg_568_1.dialogCg_.alpha = 1

				arg_568_1.dialog_:SetActive(true)
				SetActive(arg_568_1.leftNameGo_, false)

				arg_568_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_568_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_568_1:RecordName(arg_568_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_568_1.iconTrs_.gameObject, false)
				arg_568_1.callingController_:SetSelectedState("normal")

				local var_571_11 = arg_568_1:GetWordFromCfg(924011137)
				local var_571_12 = arg_568_1:FormatText(var_571_11.content)

				arg_568_1.text_.text = var_571_12

				LuaForUtil.ClearLinePrefixSymbol(arg_568_1.text_)

				local var_571_13 = 33
				local var_571_14 = utf8.len(var_571_12)
				local var_571_15 = var_571_13 <= 0 and var_571_10 or var_571_10 * (var_571_14 / var_571_13)

				if var_571_15 > 0 and var_571_10 < var_571_15 then
					arg_568_1.talkMaxDuration = var_571_15

					if var_571_15 + var_571_9 > arg_568_1.duration_ then
						arg_568_1.duration_ = var_571_15 + var_571_9
					end
				end

				arg_568_1.text_.text = var_571_12
				arg_568_1.typewritter.percent = 0

				arg_568_1.typewritter:SetDirty()
				arg_568_1:ShowNextGo(false)
				arg_568_1:RecordContent(arg_568_1.text_.text)
			end

			local var_571_16 = math.max(var_571_10, arg_568_1.talkMaxDuration)

			if var_571_9 <= arg_568_1.time_ and arg_568_1.time_ < var_571_9 + var_571_16 then
				arg_568_1.typewritter.percent = (arg_568_1.time_ - var_571_9) / var_571_16

				arg_568_1.typewritter:SetDirty()
			end

			if arg_568_1.time_ >= var_571_9 + var_571_16 and arg_568_1.time_ < var_571_9 + var_571_16 + arg_571_0 then
				arg_568_1.typewritter.percent = 1

				arg_568_1.typewritter:SetDirty()
				arg_568_1:ShowNextGo(true)
			end
		end

		arg_568_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_568_1:InitPlayNodeList()
	end,
	Play924011138 = function(arg_572_0, arg_572_1)
		arg_572_1.time_ = 0
		arg_572_1.frameCnt_ = 0
		arg_572_1.state_ = "playing"
		arg_572_1.curTalkId_ = 924011138
		arg_572_1.duration_ = 4.53

		local var_572_0 = {
			zh = 2.033,
			ja = 4.533
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
				arg_572_0:Play924011139(arg_572_1)
			end
		end

		function arg_572_1.onSingleLineUpdate_(arg_575_0)
			local var_575_0 = arg_572_1.actors_["1020ui_story"].transform
			local var_575_1 = 0

			if var_575_1 < arg_572_1.time_ and arg_572_1.time_ <= var_575_1 + arg_575_0 then
				arg_572_1.var_.moveOldPos1020ui_story = var_575_0.localPosition
			end

			local var_575_2 = 0.001

			if var_575_1 <= arg_572_1.time_ and arg_572_1.time_ < var_575_1 + var_575_2 then
				local var_575_3 = (arg_572_1.time_ - var_575_1) / var_575_2
				local var_575_4 = Vector3.New(0, -0.85, -6.25)

				var_575_0.localPosition = Vector3.Lerp(arg_572_1.var_.moveOldPos1020ui_story, var_575_4, var_575_3)

				local var_575_5 = manager.ui.mainCamera.transform.position - var_575_0.position

				var_575_0.forward = Vector3.New(var_575_5.x, var_575_5.y, var_575_5.z)

				local var_575_6 = var_575_0.localEulerAngles

				var_575_6.z = 0
				var_575_6.x = 0
				var_575_0.localEulerAngles = var_575_6
			end

			if arg_572_1.time_ >= var_575_1 + var_575_2 and arg_572_1.time_ < var_575_1 + var_575_2 + arg_575_0 then
				var_575_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_575_7 = manager.ui.mainCamera.transform.position - var_575_0.position

				var_575_0.forward = Vector3.New(var_575_7.x, var_575_7.y, var_575_7.z)

				local var_575_8 = var_575_0.localEulerAngles

				var_575_8.z = 0
				var_575_8.x = 0
				var_575_0.localEulerAngles = var_575_8
			end

			local var_575_9 = arg_572_1.actors_["1020ui_story"]
			local var_575_10 = 0

			if var_575_10 < arg_572_1.time_ and arg_572_1.time_ <= var_575_10 + arg_575_0 and not isNil(var_575_9) and arg_572_1.var_.characterEffect1020ui_story == nil then
				arg_572_1.var_.characterEffect1020ui_story = var_575_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_575_11 = 0.200000002980232

			if var_575_10 <= arg_572_1.time_ and arg_572_1.time_ < var_575_10 + var_575_11 and not isNil(var_575_9) then
				local var_575_12 = (arg_572_1.time_ - var_575_10) / var_575_11

				if arg_572_1.var_.characterEffect1020ui_story and not isNil(var_575_9) then
					arg_572_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_572_1.time_ >= var_575_10 + var_575_11 and arg_572_1.time_ < var_575_10 + var_575_11 + arg_575_0 and not isNil(var_575_9) and arg_572_1.var_.characterEffect1020ui_story then
				arg_572_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_575_13 = 0

			if var_575_13 < arg_572_1.time_ and arg_572_1.time_ <= var_575_13 + arg_575_0 then
				arg_572_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_wuyuC", "EmotionTimelineAnimator")
			end

			local var_575_14 = 0

			if var_575_14 < arg_572_1.time_ and arg_572_1.time_ <= var_575_14 + arg_575_0 then
				arg_572_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action6_1")
			end

			local var_575_15 = 0
			local var_575_16 = 0.2

			if var_575_15 < arg_572_1.time_ and arg_572_1.time_ <= var_575_15 + arg_575_0 then
				arg_572_1.talkMaxDuration = 0
				arg_572_1.dialogCg_.alpha = 1

				arg_572_1.dialog_:SetActive(true)
				SetActive(arg_572_1.leftNameGo_, true)

				local var_575_17 = arg_572_1:FormatText(StoryNameCfg[613].name)

				arg_572_1.leftNameTxt_.text = var_575_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_572_1.leftNameTxt_.transform)

				arg_572_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_572_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_572_1:RecordName(arg_572_1.leftNameTxt_.text)
				SetActive(arg_572_1.iconTrs_.gameObject, false)
				arg_572_1.callingController_:SetSelectedState("normal")

				local var_575_18 = arg_572_1:GetWordFromCfg(924011138)
				local var_575_19 = arg_572_1:FormatText(var_575_18.content)

				arg_572_1.text_.text = var_575_19

				LuaForUtil.ClearLinePrefixSymbol(arg_572_1.text_)

				local var_575_20 = 8
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

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011138", "story_v_side_old_924011.awb") ~= 0 then
					local var_575_23 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011138", "story_v_side_old_924011.awb") / 1000

					if var_575_23 + var_575_15 > arg_572_1.duration_ then
						arg_572_1.duration_ = var_575_23 + var_575_15
					end

					if var_575_18.prefab_name ~= "" and arg_572_1.actors_[var_575_18.prefab_name] ~= nil then
						local var_575_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_572_1.actors_[var_575_18.prefab_name].transform, "story_v_side_old_924011", "924011138", "story_v_side_old_924011.awb")

						arg_572_1:RecordAudio("924011138", var_575_24)
						arg_572_1:RecordAudio("924011138", var_575_24)
					else
						arg_572_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011138", "story_v_side_old_924011.awb")
					end

					arg_572_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011138", "story_v_side_old_924011.awb")
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
				actorName = "1020ui_story",
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
	Play924011139 = function(arg_576_0, arg_576_1)
		arg_576_1.time_ = 0
		arg_576_1.frameCnt_ = 0
		arg_576_1.state_ = "playing"
		arg_576_1.curTalkId_ = 924011139
		arg_576_1.duration_ = 5

		SetActive(arg_576_1.tipsGo_, false)

		function arg_576_1.onSingleLineFinish_()
			arg_576_1.onSingleLineUpdate_ = nil
			arg_576_1.onSingleLineFinish_ = nil
			arg_576_1.state_ = "waiting"
		end

		function arg_576_1.playNext_(arg_578_0)
			if arg_578_0 == 1 then
				arg_576_0:Play924011140(arg_576_1)
			end
		end

		function arg_576_1.onSingleLineUpdate_(arg_579_0)
			local var_579_0 = arg_576_1.actors_["1020ui_story"]
			local var_579_1 = 0

			if var_579_1 < arg_576_1.time_ and arg_576_1.time_ <= var_579_1 + arg_579_0 and not isNil(var_579_0) and arg_576_1.var_.characterEffect1020ui_story == nil then
				arg_576_1.var_.characterEffect1020ui_story = var_579_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_579_2 = 0.200000002980232

			if var_579_1 <= arg_576_1.time_ and arg_576_1.time_ < var_579_1 + var_579_2 and not isNil(var_579_0) then
				local var_579_3 = (arg_576_1.time_ - var_579_1) / var_579_2

				if arg_576_1.var_.characterEffect1020ui_story and not isNil(var_579_0) then
					local var_579_4 = Mathf.Lerp(0, 0.5, var_579_3)

					arg_576_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_576_1.var_.characterEffect1020ui_story.fillRatio = var_579_4
				end
			end

			if arg_576_1.time_ >= var_579_1 + var_579_2 and arg_576_1.time_ < var_579_1 + var_579_2 + arg_579_0 and not isNil(var_579_0) and arg_576_1.var_.characterEffect1020ui_story then
				local var_579_5 = 0.5

				arg_576_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_576_1.var_.characterEffect1020ui_story.fillRatio = var_579_5
			end

			local var_579_6 = 0
			local var_579_7 = 0.35

			if var_579_6 < arg_576_1.time_ and arg_576_1.time_ <= var_579_6 + arg_579_0 then
				arg_576_1.talkMaxDuration = 0
				arg_576_1.dialogCg_.alpha = 1

				arg_576_1.dialog_:SetActive(true)
				SetActive(arg_576_1.leftNameGo_, true)

				local var_579_8 = arg_576_1:FormatText(StoryNameCfg[7].name)

				arg_576_1.leftNameTxt_.text = var_579_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_576_1.leftNameTxt_.transform)

				arg_576_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_576_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_576_1:RecordName(arg_576_1.leftNameTxt_.text)
				SetActive(arg_576_1.iconTrs_.gameObject, true)
				arg_576_1.iconController_:SetSelectedState("hero")

				arg_576_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_576_1.callingController_:SetSelectedState("normal")

				arg_576_1.keyicon_.color = Color.New(1, 1, 1)
				arg_576_1.icon_.color = Color.New(1, 1, 1)

				local var_579_9 = arg_576_1:GetWordFromCfg(924011139)
				local var_579_10 = arg_576_1:FormatText(var_579_9.content)

				arg_576_1.text_.text = var_579_10

				LuaForUtil.ClearLinePrefixSymbol(arg_576_1.text_)

				local var_579_11 = 14
				local var_579_12 = utf8.len(var_579_10)
				local var_579_13 = var_579_11 <= 0 and var_579_7 or var_579_7 * (var_579_12 / var_579_11)

				if var_579_13 > 0 and var_579_7 < var_579_13 then
					arg_576_1.talkMaxDuration = var_579_13

					if var_579_13 + var_579_6 > arg_576_1.duration_ then
						arg_576_1.duration_ = var_579_13 + var_579_6
					end
				end

				arg_576_1.text_.text = var_579_10
				arg_576_1.typewritter.percent = 0

				arg_576_1.typewritter:SetDirty()
				arg_576_1:ShowNextGo(false)
				arg_576_1:RecordContent(arg_576_1.text_.text)
			end

			local var_579_14 = math.max(var_579_7, arg_576_1.talkMaxDuration)

			if var_579_6 <= arg_576_1.time_ and arg_576_1.time_ < var_579_6 + var_579_14 then
				arg_576_1.typewritter.percent = (arg_576_1.time_ - var_579_6) / var_579_14

				arg_576_1.typewritter:SetDirty()
			end

			if arg_576_1.time_ >= var_579_6 + var_579_14 and arg_576_1.time_ < var_579_6 + var_579_14 + arg_579_0 then
				arg_576_1.typewritter.percent = 1

				arg_576_1.typewritter:SetDirty()
				arg_576_1:ShowNextGo(true)
			end
		end

		arg_576_1.nodeConfigList_ = {}

		arg_576_1:InitPlayNodeList()
	end,
	Play924011140 = function(arg_580_0, arg_580_1)
		arg_580_1.time_ = 0
		arg_580_1.frameCnt_ = 0
		arg_580_1.state_ = "playing"
		arg_580_1.curTalkId_ = 924011140
		arg_580_1.duration_ = 9.4

		local var_580_0 = {
			zh = 7.866,
			ja = 9.4
		}
		local var_580_1 = manager.audio:GetLocalizationFlag()

		if var_580_0[var_580_1] ~= nil then
			arg_580_1.duration_ = var_580_0[var_580_1]
		end

		SetActive(arg_580_1.tipsGo_, false)

		function arg_580_1.onSingleLineFinish_()
			arg_580_1.onSingleLineUpdate_ = nil
			arg_580_1.onSingleLineFinish_ = nil
			arg_580_1.state_ = "waiting"
		end

		function arg_580_1.playNext_(arg_582_0)
			if arg_582_0 == 1 then
				arg_580_0:Play924011141(arg_580_1)
			end
		end

		function arg_580_1.onSingleLineUpdate_(arg_583_0)
			local var_583_0 = arg_580_1.actors_["1020ui_story"].transform
			local var_583_1 = 0

			if var_583_1 < arg_580_1.time_ and arg_580_1.time_ <= var_583_1 + arg_583_0 then
				arg_580_1.var_.moveOldPos1020ui_story = var_583_0.localPosition
			end

			local var_583_2 = 0.001

			if var_583_1 <= arg_580_1.time_ and arg_580_1.time_ < var_583_1 + var_583_2 then
				local var_583_3 = (arg_580_1.time_ - var_583_1) / var_583_2
				local var_583_4 = Vector3.New(0, -0.85, -6.25)

				var_583_0.localPosition = Vector3.Lerp(arg_580_1.var_.moveOldPos1020ui_story, var_583_4, var_583_3)

				local var_583_5 = manager.ui.mainCamera.transform.position - var_583_0.position

				var_583_0.forward = Vector3.New(var_583_5.x, var_583_5.y, var_583_5.z)

				local var_583_6 = var_583_0.localEulerAngles

				var_583_6.z = 0
				var_583_6.x = 0
				var_583_0.localEulerAngles = var_583_6
			end

			if arg_580_1.time_ >= var_583_1 + var_583_2 and arg_580_1.time_ < var_583_1 + var_583_2 + arg_583_0 then
				var_583_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_583_7 = manager.ui.mainCamera.transform.position - var_583_0.position

				var_583_0.forward = Vector3.New(var_583_7.x, var_583_7.y, var_583_7.z)

				local var_583_8 = var_583_0.localEulerAngles

				var_583_8.z = 0
				var_583_8.x = 0
				var_583_0.localEulerAngles = var_583_8
			end

			local var_583_9 = arg_580_1.actors_["1020ui_story"]
			local var_583_10 = 0

			if var_583_10 < arg_580_1.time_ and arg_580_1.time_ <= var_583_10 + arg_583_0 and not isNil(var_583_9) and arg_580_1.var_.characterEffect1020ui_story == nil then
				arg_580_1.var_.characterEffect1020ui_story = var_583_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_583_11 = 0.200000002980232

			if var_583_10 <= arg_580_1.time_ and arg_580_1.time_ < var_583_10 + var_583_11 and not isNil(var_583_9) then
				local var_583_12 = (arg_580_1.time_ - var_583_10) / var_583_11

				if arg_580_1.var_.characterEffect1020ui_story and not isNil(var_583_9) then
					arg_580_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_580_1.time_ >= var_583_10 + var_583_11 and arg_580_1.time_ < var_583_10 + var_583_11 + arg_583_0 and not isNil(var_583_9) and arg_580_1.var_.characterEffect1020ui_story then
				arg_580_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_583_13 = 0

			if var_583_13 < arg_580_1.time_ and arg_580_1.time_ <= var_583_13 + arg_583_0 then
				arg_580_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_583_14 = 0

			if var_583_14 < arg_580_1.time_ and arg_580_1.time_ <= var_583_14 + arg_583_0 then
				arg_580_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020actionlink/1020action468")
			end

			local var_583_15 = 0
			local var_583_16 = 0.675

			if var_583_15 < arg_580_1.time_ and arg_580_1.time_ <= var_583_15 + arg_583_0 then
				arg_580_1.talkMaxDuration = 0
				arg_580_1.dialogCg_.alpha = 1

				arg_580_1.dialog_:SetActive(true)
				SetActive(arg_580_1.leftNameGo_, true)

				local var_583_17 = arg_580_1:FormatText(StoryNameCfg[613].name)

				arg_580_1.leftNameTxt_.text = var_583_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_580_1.leftNameTxt_.transform)

				arg_580_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_580_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_580_1:RecordName(arg_580_1.leftNameTxt_.text)
				SetActive(arg_580_1.iconTrs_.gameObject, false)
				arg_580_1.callingController_:SetSelectedState("normal")

				local var_583_18 = arg_580_1:GetWordFromCfg(924011140)
				local var_583_19 = arg_580_1:FormatText(var_583_18.content)

				arg_580_1.text_.text = var_583_19

				LuaForUtil.ClearLinePrefixSymbol(arg_580_1.text_)

				local var_583_20 = 27
				local var_583_21 = utf8.len(var_583_19)
				local var_583_22 = var_583_20 <= 0 and var_583_16 or var_583_16 * (var_583_21 / var_583_20)

				if var_583_22 > 0 and var_583_16 < var_583_22 then
					arg_580_1.talkMaxDuration = var_583_22

					if var_583_22 + var_583_15 > arg_580_1.duration_ then
						arg_580_1.duration_ = var_583_22 + var_583_15
					end
				end

				arg_580_1.text_.text = var_583_19
				arg_580_1.typewritter.percent = 0

				arg_580_1.typewritter:SetDirty()
				arg_580_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011140", "story_v_side_old_924011.awb") ~= 0 then
					local var_583_23 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011140", "story_v_side_old_924011.awb") / 1000

					if var_583_23 + var_583_15 > arg_580_1.duration_ then
						arg_580_1.duration_ = var_583_23 + var_583_15
					end

					if var_583_18.prefab_name ~= "" and arg_580_1.actors_[var_583_18.prefab_name] ~= nil then
						local var_583_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_580_1.actors_[var_583_18.prefab_name].transform, "story_v_side_old_924011", "924011140", "story_v_side_old_924011.awb")

						arg_580_1:RecordAudio("924011140", var_583_24)
						arg_580_1:RecordAudio("924011140", var_583_24)
					else
						arg_580_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011140", "story_v_side_old_924011.awb")
					end

					arg_580_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011140", "story_v_side_old_924011.awb")
				end

				arg_580_1:RecordContent(arg_580_1.text_.text)
			end

			local var_583_25 = math.max(var_583_16, arg_580_1.talkMaxDuration)

			if var_583_15 <= arg_580_1.time_ and arg_580_1.time_ < var_583_15 + var_583_25 then
				arg_580_1.typewritter.percent = (arg_580_1.time_ - var_583_15) / var_583_25

				arg_580_1.typewritter:SetDirty()
			end

			if arg_580_1.time_ >= var_583_15 + var_583_25 and arg_580_1.time_ < var_583_15 + var_583_25 + arg_583_0 then
				arg_580_1.typewritter.percent = 1

				arg_580_1.typewritter:SetDirty()
				arg_580_1:ShowNextGo(true)
			end
		end

		arg_580_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_580_1:InitPlayNodeList()
	end,
	Play924011141 = function(arg_584_0, arg_584_1)
		arg_584_1.time_ = 0
		arg_584_1.frameCnt_ = 0
		arg_584_1.state_ = "playing"
		arg_584_1.curTalkId_ = 924011141
		arg_584_1.duration_ = 12.73

		local var_584_0 = {
			zh = 7.2,
			ja = 12.733
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
				arg_584_0:Play924011142(arg_584_1)
			end
		end

		function arg_584_1.onSingleLineUpdate_(arg_587_0)
			local var_587_0 = 0
			local var_587_1 = 0.875

			if var_587_0 < arg_584_1.time_ and arg_584_1.time_ <= var_587_0 + arg_587_0 then
				arg_584_1.talkMaxDuration = 0
				arg_584_1.dialogCg_.alpha = 1

				arg_584_1.dialog_:SetActive(true)
				SetActive(arg_584_1.leftNameGo_, true)

				local var_587_2 = arg_584_1:FormatText(StoryNameCfg[613].name)

				arg_584_1.leftNameTxt_.text = var_587_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_584_1.leftNameTxt_.transform)

				arg_584_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_584_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_584_1:RecordName(arg_584_1.leftNameTxt_.text)
				SetActive(arg_584_1.iconTrs_.gameObject, false)
				arg_584_1.callingController_:SetSelectedState("normal")

				local var_587_3 = arg_584_1:GetWordFromCfg(924011141)
				local var_587_4 = arg_584_1:FormatText(var_587_3.content)

				arg_584_1.text_.text = var_587_4

				LuaForUtil.ClearLinePrefixSymbol(arg_584_1.text_)

				local var_587_5 = 35
				local var_587_6 = utf8.len(var_587_4)
				local var_587_7 = var_587_5 <= 0 and var_587_1 or var_587_1 * (var_587_6 / var_587_5)

				if var_587_7 > 0 and var_587_1 < var_587_7 then
					arg_584_1.talkMaxDuration = var_587_7

					if var_587_7 + var_587_0 > arg_584_1.duration_ then
						arg_584_1.duration_ = var_587_7 + var_587_0
					end
				end

				arg_584_1.text_.text = var_587_4
				arg_584_1.typewritter.percent = 0

				arg_584_1.typewritter:SetDirty()
				arg_584_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011141", "story_v_side_old_924011.awb") ~= 0 then
					local var_587_8 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011141", "story_v_side_old_924011.awb") / 1000

					if var_587_8 + var_587_0 > arg_584_1.duration_ then
						arg_584_1.duration_ = var_587_8 + var_587_0
					end

					if var_587_3.prefab_name ~= "" and arg_584_1.actors_[var_587_3.prefab_name] ~= nil then
						local var_587_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_584_1.actors_[var_587_3.prefab_name].transform, "story_v_side_old_924011", "924011141", "story_v_side_old_924011.awb")

						arg_584_1:RecordAudio("924011141", var_587_9)
						arg_584_1:RecordAudio("924011141", var_587_9)
					else
						arg_584_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011141", "story_v_side_old_924011.awb")
					end

					arg_584_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011141", "story_v_side_old_924011.awb")
				end

				arg_584_1:RecordContent(arg_584_1.text_.text)
			end

			local var_587_10 = math.max(var_587_1, arg_584_1.talkMaxDuration)

			if var_587_0 <= arg_584_1.time_ and arg_584_1.time_ < var_587_0 + var_587_10 then
				arg_584_1.typewritter.percent = (arg_584_1.time_ - var_587_0) / var_587_10

				arg_584_1.typewritter:SetDirty()
			end

			if arg_584_1.time_ >= var_587_0 + var_587_10 and arg_584_1.time_ < var_587_0 + var_587_10 + arg_587_0 then
				arg_584_1.typewritter.percent = 1

				arg_584_1.typewritter:SetDirty()
				arg_584_1:ShowNextGo(true)
			end
		end

		arg_584_1.nodeConfigList_ = {}

		arg_584_1:InitPlayNodeList()
	end,
	Play924011142 = function(arg_588_0, arg_588_1)
		arg_588_1.time_ = 0
		arg_588_1.frameCnt_ = 0
		arg_588_1.state_ = "playing"
		arg_588_1.curTalkId_ = 924011142
		arg_588_1.duration_ = 3.7

		local var_588_0 = {
			zh = 3.5,
			ja = 3.7
		}
		local var_588_1 = manager.audio:GetLocalizationFlag()

		if var_588_0[var_588_1] ~= nil then
			arg_588_1.duration_ = var_588_0[var_588_1]
		end

		SetActive(arg_588_1.tipsGo_, false)

		function arg_588_1.onSingleLineFinish_()
			arg_588_1.onSingleLineUpdate_ = nil
			arg_588_1.onSingleLineFinish_ = nil
			arg_588_1.state_ = "waiting"
		end

		function arg_588_1.playNext_(arg_590_0)
			if arg_590_0 == 1 then
				arg_588_0:Play924011143(arg_588_1)
			end
		end

		function arg_588_1.onSingleLineUpdate_(arg_591_0)
			local var_591_0 = 0

			if var_591_0 < arg_588_1.time_ and arg_588_1.time_ <= var_591_0 + arg_591_0 then
				arg_588_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_biyanbiaozhun", "EmotionTimelineAnimator")
			end

			local var_591_1 = 0
			local var_591_2 = 0.225

			if var_591_1 < arg_588_1.time_ and arg_588_1.time_ <= var_591_1 + arg_591_0 then
				arg_588_1.talkMaxDuration = 0
				arg_588_1.dialogCg_.alpha = 1

				arg_588_1.dialog_:SetActive(true)
				SetActive(arg_588_1.leftNameGo_, true)

				local var_591_3 = arg_588_1:FormatText(StoryNameCfg[613].name)

				arg_588_1.leftNameTxt_.text = var_591_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_588_1.leftNameTxt_.transform)

				arg_588_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_588_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_588_1:RecordName(arg_588_1.leftNameTxt_.text)
				SetActive(arg_588_1.iconTrs_.gameObject, false)
				arg_588_1.callingController_:SetSelectedState("normal")

				local var_591_4 = arg_588_1:GetWordFromCfg(924011142)
				local var_591_5 = arg_588_1:FormatText(var_591_4.content)

				arg_588_1.text_.text = var_591_5

				LuaForUtil.ClearLinePrefixSymbol(arg_588_1.text_)

				local var_591_6 = 9
				local var_591_7 = utf8.len(var_591_5)
				local var_591_8 = var_591_6 <= 0 and var_591_2 or var_591_2 * (var_591_7 / var_591_6)

				if var_591_8 > 0 and var_591_2 < var_591_8 then
					arg_588_1.talkMaxDuration = var_591_8

					if var_591_8 + var_591_1 > arg_588_1.duration_ then
						arg_588_1.duration_ = var_591_8 + var_591_1
					end
				end

				arg_588_1.text_.text = var_591_5
				arg_588_1.typewritter.percent = 0

				arg_588_1.typewritter:SetDirty()
				arg_588_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011142", "story_v_side_old_924011.awb") ~= 0 then
					local var_591_9 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011142", "story_v_side_old_924011.awb") / 1000

					if var_591_9 + var_591_1 > arg_588_1.duration_ then
						arg_588_1.duration_ = var_591_9 + var_591_1
					end

					if var_591_4.prefab_name ~= "" and arg_588_1.actors_[var_591_4.prefab_name] ~= nil then
						local var_591_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_588_1.actors_[var_591_4.prefab_name].transform, "story_v_side_old_924011", "924011142", "story_v_side_old_924011.awb")

						arg_588_1:RecordAudio("924011142", var_591_10)
						arg_588_1:RecordAudio("924011142", var_591_10)
					else
						arg_588_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011142", "story_v_side_old_924011.awb")
					end

					arg_588_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011142", "story_v_side_old_924011.awb")
				end

				arg_588_1:RecordContent(arg_588_1.text_.text)
			end

			local var_591_11 = math.max(var_591_2, arg_588_1.talkMaxDuration)

			if var_591_1 <= arg_588_1.time_ and arg_588_1.time_ < var_591_1 + var_591_11 then
				arg_588_1.typewritter.percent = (arg_588_1.time_ - var_591_1) / var_591_11

				arg_588_1.typewritter:SetDirty()
			end

			if arg_588_1.time_ >= var_591_1 + var_591_11 and arg_588_1.time_ < var_591_1 + var_591_11 + arg_591_0 then
				arg_588_1.typewritter.percent = 1

				arg_588_1.typewritter:SetDirty()
				arg_588_1:ShowNextGo(true)
			end
		end

		arg_588_1.nodeConfigList_ = {}

		arg_588_1:InitPlayNodeList()
	end,
	Play924011143 = function(arg_592_0, arg_592_1)
		arg_592_1.time_ = 0
		arg_592_1.frameCnt_ = 0
		arg_592_1.state_ = "playing"
		arg_592_1.curTalkId_ = 924011143
		arg_592_1.duration_ = 5

		SetActive(arg_592_1.tipsGo_, false)

		function arg_592_1.onSingleLineFinish_()
			arg_592_1.onSingleLineUpdate_ = nil
			arg_592_1.onSingleLineFinish_ = nil
			arg_592_1.state_ = "waiting"
		end

		function arg_592_1.playNext_(arg_594_0)
			if arg_594_0 == 1 then
				arg_592_0:Play924011144(arg_592_1)
			end
		end

		function arg_592_1.onSingleLineUpdate_(arg_595_0)
			local var_595_0 = arg_592_1.actors_["1020ui_story"]
			local var_595_1 = 0

			if var_595_1 < arg_592_1.time_ and arg_592_1.time_ <= var_595_1 + arg_595_0 and not isNil(var_595_0) and arg_592_1.var_.characterEffect1020ui_story == nil then
				arg_592_1.var_.characterEffect1020ui_story = var_595_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_595_2 = 0.200000002980232

			if var_595_1 <= arg_592_1.time_ and arg_592_1.time_ < var_595_1 + var_595_2 and not isNil(var_595_0) then
				local var_595_3 = (arg_592_1.time_ - var_595_1) / var_595_2

				if arg_592_1.var_.characterEffect1020ui_story and not isNil(var_595_0) then
					local var_595_4 = Mathf.Lerp(0, 0.5, var_595_3)

					arg_592_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_592_1.var_.characterEffect1020ui_story.fillRatio = var_595_4
				end
			end

			if arg_592_1.time_ >= var_595_1 + var_595_2 and arg_592_1.time_ < var_595_1 + var_595_2 + arg_595_0 and not isNil(var_595_0) and arg_592_1.var_.characterEffect1020ui_story then
				local var_595_5 = 0.5

				arg_592_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_592_1.var_.characterEffect1020ui_story.fillRatio = var_595_5
			end

			local var_595_6 = 0
			local var_595_7 = 0.9

			if var_595_6 < arg_592_1.time_ and arg_592_1.time_ <= var_595_6 + arg_595_0 then
				arg_592_1.talkMaxDuration = 0
				arg_592_1.dialogCg_.alpha = 1

				arg_592_1.dialog_:SetActive(true)
				SetActive(arg_592_1.leftNameGo_, true)

				local var_595_8 = arg_592_1:FormatText(StoryNameCfg[7].name)

				arg_592_1.leftNameTxt_.text = var_595_8

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

				local var_595_9 = arg_592_1:GetWordFromCfg(924011143)
				local var_595_10 = arg_592_1:FormatText(var_595_9.content)

				arg_592_1.text_.text = var_595_10

				LuaForUtil.ClearLinePrefixSymbol(arg_592_1.text_)

				local var_595_11 = 36
				local var_595_12 = utf8.len(var_595_10)
				local var_595_13 = var_595_11 <= 0 and var_595_7 or var_595_7 * (var_595_12 / var_595_11)

				if var_595_13 > 0 and var_595_7 < var_595_13 then
					arg_592_1.talkMaxDuration = var_595_13

					if var_595_13 + var_595_6 > arg_592_1.duration_ then
						arg_592_1.duration_ = var_595_13 + var_595_6
					end
				end

				arg_592_1.text_.text = var_595_10
				arg_592_1.typewritter.percent = 0

				arg_592_1.typewritter:SetDirty()
				arg_592_1:ShowNextGo(false)
				arg_592_1:RecordContent(arg_592_1.text_.text)
			end

			local var_595_14 = math.max(var_595_7, arg_592_1.talkMaxDuration)

			if var_595_6 <= arg_592_1.time_ and arg_592_1.time_ < var_595_6 + var_595_14 then
				arg_592_1.typewritter.percent = (arg_592_1.time_ - var_595_6) / var_595_14

				arg_592_1.typewritter:SetDirty()
			end

			if arg_592_1.time_ >= var_595_6 + var_595_14 and arg_592_1.time_ < var_595_6 + var_595_14 + arg_595_0 then
				arg_592_1.typewritter.percent = 1

				arg_592_1.typewritter:SetDirty()
				arg_592_1:ShowNextGo(true)
			end
		end

		arg_592_1.nodeConfigList_ = {}

		arg_592_1:InitPlayNodeList()
	end,
	Play924011144 = function(arg_596_0, arg_596_1)
		arg_596_1.time_ = 0
		arg_596_1.frameCnt_ = 0
		arg_596_1.state_ = "playing"
		arg_596_1.curTalkId_ = 924011144
		arg_596_1.duration_ = 2

		SetActive(arg_596_1.tipsGo_, false)

		function arg_596_1.onSingleLineFinish_()
			arg_596_1.onSingleLineUpdate_ = nil
			arg_596_1.onSingleLineFinish_ = nil
			arg_596_1.state_ = "waiting"
		end

		function arg_596_1.playNext_(arg_598_0)
			if arg_598_0 == 1 then
				arg_596_0:Play924011145(arg_596_1)
			end
		end

		function arg_596_1.onSingleLineUpdate_(arg_599_0)
			local var_599_0 = arg_596_1.actors_["1020ui_story"]
			local var_599_1 = 0

			if var_599_1 < arg_596_1.time_ and arg_596_1.time_ <= var_599_1 + arg_599_0 and not isNil(var_599_0) and arg_596_1.var_.characterEffect1020ui_story == nil then
				arg_596_1.var_.characterEffect1020ui_story = var_599_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_599_2 = 0.200000002980232

			if var_599_1 <= arg_596_1.time_ and arg_596_1.time_ < var_599_1 + var_599_2 and not isNil(var_599_0) then
				local var_599_3 = (arg_596_1.time_ - var_599_1) / var_599_2

				if arg_596_1.var_.characterEffect1020ui_story and not isNil(var_599_0) then
					arg_596_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_596_1.time_ >= var_599_1 + var_599_2 and arg_596_1.time_ < var_599_1 + var_599_2 + arg_599_0 and not isNil(var_599_0) and arg_596_1.var_.characterEffect1020ui_story then
				arg_596_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_599_4 = 0

			if var_599_4 < arg_596_1.time_ and arg_596_1.time_ <= var_599_4 + arg_599_0 then
				arg_596_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_599_5 = 0
			local var_599_6 = 0.05

			if var_599_5 < arg_596_1.time_ and arg_596_1.time_ <= var_599_5 + arg_599_0 then
				arg_596_1.talkMaxDuration = 0
				arg_596_1.dialogCg_.alpha = 1

				arg_596_1.dialog_:SetActive(true)
				SetActive(arg_596_1.leftNameGo_, true)

				local var_599_7 = arg_596_1:FormatText(StoryNameCfg[613].name)

				arg_596_1.leftNameTxt_.text = var_599_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_596_1.leftNameTxt_.transform)

				arg_596_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_596_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_596_1:RecordName(arg_596_1.leftNameTxt_.text)
				SetActive(arg_596_1.iconTrs_.gameObject, false)
				arg_596_1.callingController_:SetSelectedState("normal")

				local var_599_8 = arg_596_1:GetWordFromCfg(924011144)
				local var_599_9 = arg_596_1:FormatText(var_599_8.content)

				arg_596_1.text_.text = var_599_9

				LuaForUtil.ClearLinePrefixSymbol(arg_596_1.text_)

				local var_599_10 = 2
				local var_599_11 = utf8.len(var_599_9)
				local var_599_12 = var_599_10 <= 0 and var_599_6 or var_599_6 * (var_599_11 / var_599_10)

				if var_599_12 > 0 and var_599_6 < var_599_12 then
					arg_596_1.talkMaxDuration = var_599_12

					if var_599_12 + var_599_5 > arg_596_1.duration_ then
						arg_596_1.duration_ = var_599_12 + var_599_5
					end
				end

				arg_596_1.text_.text = var_599_9
				arg_596_1.typewritter.percent = 0

				arg_596_1.typewritter:SetDirty()
				arg_596_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011144", "story_v_side_old_924011.awb") ~= 0 then
					local var_599_13 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011144", "story_v_side_old_924011.awb") / 1000

					if var_599_13 + var_599_5 > arg_596_1.duration_ then
						arg_596_1.duration_ = var_599_13 + var_599_5
					end

					if var_599_8.prefab_name ~= "" and arg_596_1.actors_[var_599_8.prefab_name] ~= nil then
						local var_599_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_596_1.actors_[var_599_8.prefab_name].transform, "story_v_side_old_924011", "924011144", "story_v_side_old_924011.awb")

						arg_596_1:RecordAudio("924011144", var_599_14)
						arg_596_1:RecordAudio("924011144", var_599_14)
					else
						arg_596_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011144", "story_v_side_old_924011.awb")
					end

					arg_596_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011144", "story_v_side_old_924011.awb")
				end

				arg_596_1:RecordContent(arg_596_1.text_.text)
			end

			local var_599_15 = math.max(var_599_6, arg_596_1.talkMaxDuration)

			if var_599_5 <= arg_596_1.time_ and arg_596_1.time_ < var_599_5 + var_599_15 then
				arg_596_1.typewritter.percent = (arg_596_1.time_ - var_599_5) / var_599_15

				arg_596_1.typewritter:SetDirty()
			end

			if arg_596_1.time_ >= var_599_5 + var_599_15 and arg_596_1.time_ < var_599_5 + var_599_15 + arg_599_0 then
				arg_596_1.typewritter.percent = 1

				arg_596_1.typewritter:SetDirty()
				arg_596_1:ShowNextGo(true)
			end
		end

		arg_596_1.nodeConfigList_ = {}

		arg_596_1:InitPlayNodeList()
	end,
	Play924011145 = function(arg_600_0, arg_600_1)
		arg_600_1.time_ = 0
		arg_600_1.frameCnt_ = 0
		arg_600_1.state_ = "playing"
		arg_600_1.curTalkId_ = 924011145
		arg_600_1.duration_ = 5

		SetActive(arg_600_1.tipsGo_, false)

		function arg_600_1.onSingleLineFinish_()
			arg_600_1.onSingleLineUpdate_ = nil
			arg_600_1.onSingleLineFinish_ = nil
			arg_600_1.state_ = "waiting"
		end

		function arg_600_1.playNext_(arg_602_0)
			if arg_602_0 == 1 then
				arg_600_0:Play924011146(arg_600_1)
			end
		end

		function arg_600_1.onSingleLineUpdate_(arg_603_0)
			local var_603_0 = arg_600_1.actors_["1020ui_story"]
			local var_603_1 = 0

			if var_603_1 < arg_600_1.time_ and arg_600_1.time_ <= var_603_1 + arg_603_0 and not isNil(var_603_0) and arg_600_1.var_.characterEffect1020ui_story == nil then
				arg_600_1.var_.characterEffect1020ui_story = var_603_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_603_2 = 0.200000002980232

			if var_603_1 <= arg_600_1.time_ and arg_600_1.time_ < var_603_1 + var_603_2 and not isNil(var_603_0) then
				local var_603_3 = (arg_600_1.time_ - var_603_1) / var_603_2

				if arg_600_1.var_.characterEffect1020ui_story and not isNil(var_603_0) then
					local var_603_4 = Mathf.Lerp(0, 0.5, var_603_3)

					arg_600_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_600_1.var_.characterEffect1020ui_story.fillRatio = var_603_4
				end
			end

			if arg_600_1.time_ >= var_603_1 + var_603_2 and arg_600_1.time_ < var_603_1 + var_603_2 + arg_603_0 and not isNil(var_603_0) and arg_600_1.var_.characterEffect1020ui_story then
				local var_603_5 = 0.5

				arg_600_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_600_1.var_.characterEffect1020ui_story.fillRatio = var_603_5
			end

			local var_603_6 = 0
			local var_603_7 = 1.25

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

				local var_603_9 = arg_600_1:GetWordFromCfg(924011145)
				local var_603_10 = arg_600_1:FormatText(var_603_9.content)

				arg_600_1.text_.text = var_603_10

				LuaForUtil.ClearLinePrefixSymbol(arg_600_1.text_)

				local var_603_11 = 50
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
	Play924011146 = function(arg_604_0, arg_604_1)
		arg_604_1.time_ = 0
		arg_604_1.frameCnt_ = 0
		arg_604_1.state_ = "playing"
		arg_604_1.curTalkId_ = 924011146
		arg_604_1.duration_ = 1.47

		local var_604_0 = {
			zh = 1.1,
			ja = 1.466
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
				arg_604_0:Play924011147(arg_604_1)
			end
		end

		function arg_604_1.onSingleLineUpdate_(arg_607_0)
			local var_607_0 = arg_604_1.actors_["1020ui_story"]
			local var_607_1 = 0

			if var_607_1 < arg_604_1.time_ and arg_604_1.time_ <= var_607_1 + arg_607_0 and not isNil(var_607_0) and arg_604_1.var_.characterEffect1020ui_story == nil then
				arg_604_1.var_.characterEffect1020ui_story = var_607_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_607_2 = 0.200000002980232

			if var_607_1 <= arg_604_1.time_ and arg_604_1.time_ < var_607_1 + var_607_2 and not isNil(var_607_0) then
				local var_607_3 = (arg_604_1.time_ - var_607_1) / var_607_2

				if arg_604_1.var_.characterEffect1020ui_story and not isNil(var_607_0) then
					arg_604_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_604_1.time_ >= var_607_1 + var_607_2 and arg_604_1.time_ < var_607_1 + var_607_2 + arg_607_0 and not isNil(var_607_0) and arg_604_1.var_.characterEffect1020ui_story then
				arg_604_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_607_4 = 0
			local var_607_5 = 0.05

			if var_607_4 < arg_604_1.time_ and arg_604_1.time_ <= var_607_4 + arg_607_0 then
				arg_604_1.talkMaxDuration = 0
				arg_604_1.dialogCg_.alpha = 1

				arg_604_1.dialog_:SetActive(true)
				SetActive(arg_604_1.leftNameGo_, true)

				local var_607_6 = arg_604_1:FormatText(StoryNameCfg[613].name)

				arg_604_1.leftNameTxt_.text = var_607_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_604_1.leftNameTxt_.transform)

				arg_604_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_604_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_604_1:RecordName(arg_604_1.leftNameTxt_.text)
				SetActive(arg_604_1.iconTrs_.gameObject, false)
				arg_604_1.callingController_:SetSelectedState("normal")

				local var_607_7 = arg_604_1:GetWordFromCfg(924011146)
				local var_607_8 = arg_604_1:FormatText(var_607_7.content)

				arg_604_1.text_.text = var_607_8

				LuaForUtil.ClearLinePrefixSymbol(arg_604_1.text_)

				local var_607_9 = 2
				local var_607_10 = utf8.len(var_607_8)
				local var_607_11 = var_607_9 <= 0 and var_607_5 or var_607_5 * (var_607_10 / var_607_9)

				if var_607_11 > 0 and var_607_5 < var_607_11 then
					arg_604_1.talkMaxDuration = var_607_11

					if var_607_11 + var_607_4 > arg_604_1.duration_ then
						arg_604_1.duration_ = var_607_11 + var_607_4
					end
				end

				arg_604_1.text_.text = var_607_8
				arg_604_1.typewritter.percent = 0

				arg_604_1.typewritter:SetDirty()
				arg_604_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011146", "story_v_side_old_924011.awb") ~= 0 then
					local var_607_12 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011146", "story_v_side_old_924011.awb") / 1000

					if var_607_12 + var_607_4 > arg_604_1.duration_ then
						arg_604_1.duration_ = var_607_12 + var_607_4
					end

					if var_607_7.prefab_name ~= "" and arg_604_1.actors_[var_607_7.prefab_name] ~= nil then
						local var_607_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_604_1.actors_[var_607_7.prefab_name].transform, "story_v_side_old_924011", "924011146", "story_v_side_old_924011.awb")

						arg_604_1:RecordAudio("924011146", var_607_13)
						arg_604_1:RecordAudio("924011146", var_607_13)
					else
						arg_604_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011146", "story_v_side_old_924011.awb")
					end

					arg_604_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011146", "story_v_side_old_924011.awb")
				end

				arg_604_1:RecordContent(arg_604_1.text_.text)
			end

			local var_607_14 = math.max(var_607_5, arg_604_1.talkMaxDuration)

			if var_607_4 <= arg_604_1.time_ and arg_604_1.time_ < var_607_4 + var_607_14 then
				arg_604_1.typewritter.percent = (arg_604_1.time_ - var_607_4) / var_607_14

				arg_604_1.typewritter:SetDirty()
			end

			if arg_604_1.time_ >= var_607_4 + var_607_14 and arg_604_1.time_ < var_607_4 + var_607_14 + arg_607_0 then
				arg_604_1.typewritter.percent = 1

				arg_604_1.typewritter:SetDirty()
				arg_604_1:ShowNextGo(true)
			end
		end

		arg_604_1.nodeConfigList_ = {}

		arg_604_1:InitPlayNodeList()
	end,
	Play924011147 = function(arg_608_0, arg_608_1)
		arg_608_1.time_ = 0
		arg_608_1.frameCnt_ = 0
		arg_608_1.state_ = "playing"
		arg_608_1.curTalkId_ = 924011147
		arg_608_1.duration_ = 5

		SetActive(arg_608_1.tipsGo_, false)

		function arg_608_1.onSingleLineFinish_()
			arg_608_1.onSingleLineUpdate_ = nil
			arg_608_1.onSingleLineFinish_ = nil
			arg_608_1.state_ = "waiting"
		end

		function arg_608_1.playNext_(arg_610_0)
			if arg_610_0 == 1 then
				arg_608_0:Play924011148(arg_608_1)
			end
		end

		function arg_608_1.onSingleLineUpdate_(arg_611_0)
			local var_611_0 = arg_608_1.actors_["1020ui_story"].transform
			local var_611_1 = 0

			if var_611_1 < arg_608_1.time_ and arg_608_1.time_ <= var_611_1 + arg_611_0 then
				arg_608_1.var_.moveOldPos1020ui_story = var_611_0.localPosition
			end

			local var_611_2 = 0.001

			if var_611_1 <= arg_608_1.time_ and arg_608_1.time_ < var_611_1 + var_611_2 then
				local var_611_3 = (arg_608_1.time_ - var_611_1) / var_611_2
				local var_611_4 = Vector3.New(0, 100, 0)

				var_611_0.localPosition = Vector3.Lerp(arg_608_1.var_.moveOldPos1020ui_story, var_611_4, var_611_3)

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

			local var_611_9 = arg_608_1.actors_["1020ui_story"]
			local var_611_10 = 0

			if var_611_10 < arg_608_1.time_ and arg_608_1.time_ <= var_611_10 + arg_611_0 and not isNil(var_611_9) and arg_608_1.var_.characterEffect1020ui_story == nil then
				arg_608_1.var_.characterEffect1020ui_story = var_611_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_611_11 = 0.200000002980232

			if var_611_10 <= arg_608_1.time_ and arg_608_1.time_ < var_611_10 + var_611_11 and not isNil(var_611_9) then
				local var_611_12 = (arg_608_1.time_ - var_611_10) / var_611_11

				if arg_608_1.var_.characterEffect1020ui_story and not isNil(var_611_9) then
					local var_611_13 = Mathf.Lerp(0, 0.5, var_611_12)

					arg_608_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_608_1.var_.characterEffect1020ui_story.fillRatio = var_611_13
				end
			end

			if arg_608_1.time_ >= var_611_10 + var_611_11 and arg_608_1.time_ < var_611_10 + var_611_11 + arg_611_0 and not isNil(var_611_9) and arg_608_1.var_.characterEffect1020ui_story then
				local var_611_14 = 0.5

				arg_608_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_608_1.var_.characterEffect1020ui_story.fillRatio = var_611_14
			end

			local var_611_15 = 0.125
			local var_611_16 = 1

			if var_611_15 < arg_608_1.time_ and arg_608_1.time_ <= var_611_15 + arg_611_0 then
				local var_611_17 = "play"
				local var_611_18 = "effect"

				arg_608_1:AudioAction(var_611_17, var_611_18, "se_story_141", "se_story_141_foley_roll", "")
			end

			local var_611_19 = 0
			local var_611_20 = 0.45

			if var_611_19 < arg_608_1.time_ and arg_608_1.time_ <= var_611_19 + arg_611_0 then
				arg_608_1.talkMaxDuration = 0
				arg_608_1.dialogCg_.alpha = 1

				arg_608_1.dialog_:SetActive(true)
				SetActive(arg_608_1.leftNameGo_, false)

				arg_608_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_608_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_608_1:RecordName(arg_608_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_608_1.iconTrs_.gameObject, false)
				arg_608_1.callingController_:SetSelectedState("normal")

				local var_611_21 = arg_608_1:GetWordFromCfg(924011147)
				local var_611_22 = arg_608_1:FormatText(var_611_21.content)

				arg_608_1.text_.text = var_611_22

				LuaForUtil.ClearLinePrefixSymbol(arg_608_1.text_)

				local var_611_23 = 18
				local var_611_24 = utf8.len(var_611_22)
				local var_611_25 = var_611_23 <= 0 and var_611_20 or var_611_20 * (var_611_24 / var_611_23)

				if var_611_25 > 0 and var_611_20 < var_611_25 then
					arg_608_1.talkMaxDuration = var_611_25

					if var_611_25 + var_611_19 > arg_608_1.duration_ then
						arg_608_1.duration_ = var_611_25 + var_611_19
					end
				end

				arg_608_1.text_.text = var_611_22
				arg_608_1.typewritter.percent = 0

				arg_608_1.typewritter:SetDirty()
				arg_608_1:ShowNextGo(false)
				arg_608_1:RecordContent(arg_608_1.text_.text)
			end

			local var_611_26 = math.max(var_611_20, arg_608_1.talkMaxDuration)

			if var_611_19 <= arg_608_1.time_ and arg_608_1.time_ < var_611_19 + var_611_26 then
				arg_608_1.typewritter.percent = (arg_608_1.time_ - var_611_19) / var_611_26

				arg_608_1.typewritter:SetDirty()
			end

			if arg_608_1.time_ >= var_611_19 + var_611_26 and arg_608_1.time_ < var_611_19 + var_611_26 + arg_611_0 then
				arg_608_1.typewritter.percent = 1

				arg_608_1.typewritter:SetDirty()
				arg_608_1:ShowNextGo(true)
			end
		end

		arg_608_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
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
	Play924011148 = function(arg_612_0, arg_612_1)
		arg_612_1.time_ = 0
		arg_612_1.frameCnt_ = 0
		arg_612_1.state_ = "playing"
		arg_612_1.curTalkId_ = 924011148
		arg_612_1.duration_ = 5

		SetActive(arg_612_1.tipsGo_, false)

		function arg_612_1.onSingleLineFinish_()
			arg_612_1.onSingleLineUpdate_ = nil
			arg_612_1.onSingleLineFinish_ = nil
			arg_612_1.state_ = "waiting"
		end

		function arg_612_1.playNext_(arg_614_0)
			if arg_614_0 == 1 then
				arg_612_0:Play924011149(arg_612_1)
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

				local var_615_3 = arg_612_1:GetWordFromCfg(924011148)
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
	Play924011149 = function(arg_616_0, arg_616_1)
		arg_616_1.time_ = 0
		arg_616_1.frameCnt_ = 0
		arg_616_1.state_ = "playing"
		arg_616_1.curTalkId_ = 924011149
		arg_616_1.duration_ = 1.1

		SetActive(arg_616_1.tipsGo_, false)

		function arg_616_1.onSingleLineFinish_()
			arg_616_1.onSingleLineUpdate_ = nil
			arg_616_1.onSingleLineFinish_ = nil
			arg_616_1.state_ = "waiting"
		end

		function arg_616_1.playNext_(arg_618_0)
			if arg_618_0 == 1 then
				arg_616_0:Play924011150(arg_616_1)
			end
		end

		function arg_616_1.onSingleLineUpdate_(arg_619_0)
			local var_619_0 = 0
			local var_619_1 = 0.05

			if var_619_0 < arg_616_1.time_ and arg_616_1.time_ <= var_619_0 + arg_619_0 then
				arg_616_1.talkMaxDuration = 0
				arg_616_1.dialogCg_.alpha = 1

				arg_616_1.dialog_:SetActive(true)
				SetActive(arg_616_1.leftNameGo_, true)

				local var_619_2 = arg_616_1:FormatText(StoryNameCfg[613].name)

				arg_616_1.leftNameTxt_.text = var_619_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_616_1.leftNameTxt_.transform)

				arg_616_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_616_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_616_1:RecordName(arg_616_1.leftNameTxt_.text)
				SetActive(arg_616_1.iconTrs_.gameObject, true)
				arg_616_1.iconController_:SetSelectedState("hero")

				arg_616_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1020")

				arg_616_1.callingController_:SetSelectedState("normal")

				arg_616_1.keyicon_.color = Color.New(1, 1, 1)
				arg_616_1.icon_.color = Color.New(1, 1, 1)

				local var_619_3 = arg_616_1:GetWordFromCfg(924011149)
				local var_619_4 = arg_616_1:FormatText(var_619_3.content)

				arg_616_1.text_.text = var_619_4

				LuaForUtil.ClearLinePrefixSymbol(arg_616_1.text_)

				local var_619_5 = 2
				local var_619_6 = utf8.len(var_619_4)
				local var_619_7 = var_619_5 <= 0 and var_619_1 or var_619_1 * (var_619_6 / var_619_5)

				if var_619_7 > 0 and var_619_1 < var_619_7 then
					arg_616_1.talkMaxDuration = var_619_7

					if var_619_7 + var_619_0 > arg_616_1.duration_ then
						arg_616_1.duration_ = var_619_7 + var_619_0
					end
				end

				arg_616_1.text_.text = var_619_4
				arg_616_1.typewritter.percent = 0

				arg_616_1.typewritter:SetDirty()
				arg_616_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011149", "story_v_side_old_924011.awb") ~= 0 then
					local var_619_8 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011149", "story_v_side_old_924011.awb") / 1000

					if var_619_8 + var_619_0 > arg_616_1.duration_ then
						arg_616_1.duration_ = var_619_8 + var_619_0
					end

					if var_619_3.prefab_name ~= "" and arg_616_1.actors_[var_619_3.prefab_name] ~= nil then
						local var_619_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_616_1.actors_[var_619_3.prefab_name].transform, "story_v_side_old_924011", "924011149", "story_v_side_old_924011.awb")

						arg_616_1:RecordAudio("924011149", var_619_9)
						arg_616_1:RecordAudio("924011149", var_619_9)
					else
						arg_616_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011149", "story_v_side_old_924011.awb")
					end

					arg_616_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011149", "story_v_side_old_924011.awb")
				end

				arg_616_1:RecordContent(arg_616_1.text_.text)
			end

			local var_619_10 = math.max(var_619_1, arg_616_1.talkMaxDuration)

			if var_619_0 <= arg_616_1.time_ and arg_616_1.time_ < var_619_0 + var_619_10 then
				arg_616_1.typewritter.percent = (arg_616_1.time_ - var_619_0) / var_619_10

				arg_616_1.typewritter:SetDirty()
			end

			if arg_616_1.time_ >= var_619_0 + var_619_10 and arg_616_1.time_ < var_619_0 + var_619_10 + arg_619_0 then
				arg_616_1.typewritter.percent = 1

				arg_616_1.typewritter:SetDirty()
				arg_616_1:ShowNextGo(true)
			end
		end

		arg_616_1.nodeConfigList_ = {}

		arg_616_1:InitPlayNodeList()
	end,
	Play924011150 = function(arg_620_0, arg_620_1)
		arg_620_1.time_ = 0
		arg_620_1.frameCnt_ = 0
		arg_620_1.state_ = "playing"
		arg_620_1.curTalkId_ = 924011150
		arg_620_1.duration_ = 5

		SetActive(arg_620_1.tipsGo_, false)

		function arg_620_1.onSingleLineFinish_()
			arg_620_1.onSingleLineUpdate_ = nil
			arg_620_1.onSingleLineFinish_ = nil
			arg_620_1.state_ = "waiting"
		end

		function arg_620_1.playNext_(arg_622_0)
			if arg_622_0 == 1 then
				arg_620_0:Play924011151(arg_620_1)
			end
		end

		function arg_620_1.onSingleLineUpdate_(arg_623_0)
			local var_623_0 = 0
			local var_623_1 = 0.825

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

				local var_623_2 = arg_620_1:GetWordFromCfg(924011150)
				local var_623_3 = arg_620_1:FormatText(var_623_2.content)

				arg_620_1.text_.text = var_623_3

				LuaForUtil.ClearLinePrefixSymbol(arg_620_1.text_)

				local var_623_4 = 33
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
	Play924011151 = function(arg_624_0, arg_624_1)
		arg_624_1.time_ = 0
		arg_624_1.frameCnt_ = 0
		arg_624_1.state_ = "playing"
		arg_624_1.curTalkId_ = 924011151
		arg_624_1.duration_ = 6.93

		local var_624_0 = {
			zh = 5.6,
			ja = 6.933
		}
		local var_624_1 = manager.audio:GetLocalizationFlag()

		if var_624_0[var_624_1] ~= nil then
			arg_624_1.duration_ = var_624_0[var_624_1]
		end

		SetActive(arg_624_1.tipsGo_, false)

		function arg_624_1.onSingleLineFinish_()
			arg_624_1.onSingleLineUpdate_ = nil
			arg_624_1.onSingleLineFinish_ = nil
			arg_624_1.state_ = "waiting"
		end

		function arg_624_1.playNext_(arg_626_0)
			if arg_626_0 == 1 then
				arg_624_0:Play924011152(arg_624_1)
			end
		end

		function arg_624_1.onSingleLineUpdate_(arg_627_0)
			local var_627_0 = arg_624_1.actors_["1020ui_story"].transform
			local var_627_1 = 0

			if var_627_1 < arg_624_1.time_ and arg_624_1.time_ <= var_627_1 + arg_627_0 then
				arg_624_1.var_.moveOldPos1020ui_story = var_627_0.localPosition
			end

			local var_627_2 = 0.001

			if var_627_1 <= arg_624_1.time_ and arg_624_1.time_ < var_627_1 + var_627_2 then
				local var_627_3 = (arg_624_1.time_ - var_627_1) / var_627_2
				local var_627_4 = Vector3.New(0, 100, 0)

				var_627_0.localPosition = Vector3.Lerp(arg_624_1.var_.moveOldPos1020ui_story, var_627_4, var_627_3)

				local var_627_5 = manager.ui.mainCamera.transform.position - var_627_0.position

				var_627_0.forward = Vector3.New(var_627_5.x, var_627_5.y, var_627_5.z)

				local var_627_6 = var_627_0.localEulerAngles

				var_627_6.z = 0
				var_627_6.x = 0
				var_627_0.localEulerAngles = var_627_6
			end

			if arg_624_1.time_ >= var_627_1 + var_627_2 and arg_624_1.time_ < var_627_1 + var_627_2 + arg_627_0 then
				var_627_0.localPosition = Vector3.New(0, 100, 0)

				local var_627_7 = manager.ui.mainCamera.transform.position - var_627_0.position

				var_627_0.forward = Vector3.New(var_627_7.x, var_627_7.y, var_627_7.z)

				local var_627_8 = var_627_0.localEulerAngles

				var_627_8.z = 0
				var_627_8.x = 0
				var_627_0.localEulerAngles = var_627_8
			end

			local var_627_9 = 0
			local var_627_10 = 0.475

			if var_627_9 < arg_624_1.time_ and arg_624_1.time_ <= var_627_9 + arg_627_0 then
				arg_624_1.talkMaxDuration = 0
				arg_624_1.dialogCg_.alpha = 1

				arg_624_1.dialog_:SetActive(true)
				SetActive(arg_624_1.leftNameGo_, true)

				local var_627_11 = arg_624_1:FormatText(StoryNameCfg[613].name)

				arg_624_1.leftNameTxt_.text = var_627_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_624_1.leftNameTxt_.transform)

				arg_624_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_624_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_624_1:RecordName(arg_624_1.leftNameTxt_.text)
				SetActive(arg_624_1.iconTrs_.gameObject, true)
				arg_624_1.iconController_:SetSelectedState("hero")

				arg_624_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1020")

				arg_624_1.callingController_:SetSelectedState("normal")

				arg_624_1.keyicon_.color = Color.New(1, 1, 1)
				arg_624_1.icon_.color = Color.New(1, 1, 1)

				local var_627_12 = arg_624_1:GetWordFromCfg(924011151)
				local var_627_13 = arg_624_1:FormatText(var_627_12.content)

				arg_624_1.text_.text = var_627_13

				LuaForUtil.ClearLinePrefixSymbol(arg_624_1.text_)

				local var_627_14 = 19
				local var_627_15 = utf8.len(var_627_13)
				local var_627_16 = var_627_14 <= 0 and var_627_10 or var_627_10 * (var_627_15 / var_627_14)

				if var_627_16 > 0 and var_627_10 < var_627_16 then
					arg_624_1.talkMaxDuration = var_627_16

					if var_627_16 + var_627_9 > arg_624_1.duration_ then
						arg_624_1.duration_ = var_627_16 + var_627_9
					end
				end

				arg_624_1.text_.text = var_627_13
				arg_624_1.typewritter.percent = 0

				arg_624_1.typewritter:SetDirty()
				arg_624_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011151", "story_v_side_old_924011.awb") ~= 0 then
					local var_627_17 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011151", "story_v_side_old_924011.awb") / 1000

					if var_627_17 + var_627_9 > arg_624_1.duration_ then
						arg_624_1.duration_ = var_627_17 + var_627_9
					end

					if var_627_12.prefab_name ~= "" and arg_624_1.actors_[var_627_12.prefab_name] ~= nil then
						local var_627_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_624_1.actors_[var_627_12.prefab_name].transform, "story_v_side_old_924011", "924011151", "story_v_side_old_924011.awb")

						arg_624_1:RecordAudio("924011151", var_627_18)
						arg_624_1:RecordAudio("924011151", var_627_18)
					else
						arg_624_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011151", "story_v_side_old_924011.awb")
					end

					arg_624_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011151", "story_v_side_old_924011.awb")
				end

				arg_624_1:RecordContent(arg_624_1.text_.text)
			end

			local var_627_19 = math.max(var_627_10, arg_624_1.talkMaxDuration)

			if var_627_9 <= arg_624_1.time_ and arg_624_1.time_ < var_627_9 + var_627_19 then
				arg_624_1.typewritter.percent = (arg_624_1.time_ - var_627_9) / var_627_19

				arg_624_1.typewritter:SetDirty()
			end

			if arg_624_1.time_ >= var_627_9 + var_627_19 and arg_624_1.time_ < var_627_9 + var_627_19 + arg_627_0 then
				arg_624_1.typewritter.percent = 1

				arg_624_1.typewritter:SetDirty()
				arg_624_1:ShowNextGo(true)
			end
		end

		arg_624_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_624_1:InitPlayNodeList()
	end,
	Play924011152 = function(arg_628_0, arg_628_1)
		arg_628_1.time_ = 0
		arg_628_1.frameCnt_ = 0
		arg_628_1.state_ = "playing"
		arg_628_1.curTalkId_ = 924011152
		arg_628_1.duration_ = 5

		SetActive(arg_628_1.tipsGo_, false)

		function arg_628_1.onSingleLineFinish_()
			arg_628_1.onSingleLineUpdate_ = nil
			arg_628_1.onSingleLineFinish_ = nil
			arg_628_1.state_ = "waiting"
		end

		function arg_628_1.playNext_(arg_630_0)
			if arg_630_0 == 1 then
				arg_628_0:Play924011153(arg_628_1)
			end
		end

		function arg_628_1.onSingleLineUpdate_(arg_631_0)
			local var_631_0 = arg_628_1.actors_["1020ui_story"]
			local var_631_1 = 0

			if var_631_1 < arg_628_1.time_ and arg_628_1.time_ <= var_631_1 + arg_631_0 and not isNil(var_631_0) and arg_628_1.var_.characterEffect1020ui_story == nil then
				arg_628_1.var_.characterEffect1020ui_story = var_631_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_631_2 = 0.200000002980232

			if var_631_1 <= arg_628_1.time_ and arg_628_1.time_ < var_631_1 + var_631_2 and not isNil(var_631_0) then
				local var_631_3 = (arg_628_1.time_ - var_631_1) / var_631_2

				if arg_628_1.var_.characterEffect1020ui_story and not isNil(var_631_0) then
					local var_631_4 = Mathf.Lerp(0, 0.5, var_631_3)

					arg_628_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_628_1.var_.characterEffect1020ui_story.fillRatio = var_631_4
				end
			end

			if arg_628_1.time_ >= var_631_1 + var_631_2 and arg_628_1.time_ < var_631_1 + var_631_2 + arg_631_0 and not isNil(var_631_0) and arg_628_1.var_.characterEffect1020ui_story then
				local var_631_5 = 0.5

				arg_628_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_628_1.var_.characterEffect1020ui_story.fillRatio = var_631_5
			end

			local var_631_6 = 0
			local var_631_7 = 0.45

			if var_631_6 < arg_628_1.time_ and arg_628_1.time_ <= var_631_6 + arg_631_0 then
				arg_628_1.talkMaxDuration = 0
				arg_628_1.dialogCg_.alpha = 1

				arg_628_1.dialog_:SetActive(true)
				SetActive(arg_628_1.leftNameGo_, true)

				local var_631_8 = arg_628_1:FormatText(StoryNameCfg[7].name)

				arg_628_1.leftNameTxt_.text = var_631_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_628_1.leftNameTxt_.transform)

				arg_628_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_628_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_628_1:RecordName(arg_628_1.leftNameTxt_.text)
				SetActive(arg_628_1.iconTrs_.gameObject, true)
				arg_628_1.iconController_:SetSelectedState("hero")

				arg_628_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_628_1.callingController_:SetSelectedState("normal")

				arg_628_1.keyicon_.color = Color.New(1, 1, 1)
				arg_628_1.icon_.color = Color.New(1, 1, 1)

				local var_631_9 = arg_628_1:GetWordFromCfg(924011152)
				local var_631_10 = arg_628_1:FormatText(var_631_9.content)

				arg_628_1.text_.text = var_631_10

				LuaForUtil.ClearLinePrefixSymbol(arg_628_1.text_)

				local var_631_11 = 18
				local var_631_12 = utf8.len(var_631_10)
				local var_631_13 = var_631_11 <= 0 and var_631_7 or var_631_7 * (var_631_12 / var_631_11)

				if var_631_13 > 0 and var_631_7 < var_631_13 then
					arg_628_1.talkMaxDuration = var_631_13

					if var_631_13 + var_631_6 > arg_628_1.duration_ then
						arg_628_1.duration_ = var_631_13 + var_631_6
					end
				end

				arg_628_1.text_.text = var_631_10
				arg_628_1.typewritter.percent = 0

				arg_628_1.typewritter:SetDirty()
				arg_628_1:ShowNextGo(false)
				arg_628_1:RecordContent(arg_628_1.text_.text)
			end

			local var_631_14 = math.max(var_631_7, arg_628_1.talkMaxDuration)

			if var_631_6 <= arg_628_1.time_ and arg_628_1.time_ < var_631_6 + var_631_14 then
				arg_628_1.typewritter.percent = (arg_628_1.time_ - var_631_6) / var_631_14

				arg_628_1.typewritter:SetDirty()
			end

			if arg_628_1.time_ >= var_631_6 + var_631_14 and arg_628_1.time_ < var_631_6 + var_631_14 + arg_631_0 then
				arg_628_1.typewritter.percent = 1

				arg_628_1.typewritter:SetDirty()
				arg_628_1:ShowNextGo(true)
			end
		end

		arg_628_1.nodeConfigList_ = {}

		arg_628_1:InitPlayNodeList()
	end,
	Play924011153 = function(arg_632_0, arg_632_1)
		arg_632_1.time_ = 0
		arg_632_1.frameCnt_ = 0
		arg_632_1.state_ = "playing"
		arg_632_1.curTalkId_ = 924011153
		arg_632_1.duration_ = 2.7

		local var_632_0 = {
			zh = 1.999999999999,
			ja = 2.7
		}
		local var_632_1 = manager.audio:GetLocalizationFlag()

		if var_632_0[var_632_1] ~= nil then
			arg_632_1.duration_ = var_632_0[var_632_1]
		end

		SetActive(arg_632_1.tipsGo_, false)

		function arg_632_1.onSingleLineFinish_()
			arg_632_1.onSingleLineUpdate_ = nil
			arg_632_1.onSingleLineFinish_ = nil
			arg_632_1.state_ = "waiting"
		end

		function arg_632_1.playNext_(arg_634_0)
			if arg_634_0 == 1 then
				arg_632_0:Play924011154(arg_632_1)
			end
		end

		function arg_632_1.onSingleLineUpdate_(arg_635_0)
			local var_635_0 = arg_632_1.actors_["1020ui_story"].transform
			local var_635_1 = 0

			if var_635_1 < arg_632_1.time_ and arg_632_1.time_ <= var_635_1 + arg_635_0 then
				arg_632_1.var_.moveOldPos1020ui_story = var_635_0.localPosition
			end

			local var_635_2 = 0.001

			if var_635_1 <= arg_632_1.time_ and arg_632_1.time_ < var_635_1 + var_635_2 then
				local var_635_3 = (arg_632_1.time_ - var_635_1) / var_635_2
				local var_635_4 = Vector3.New(0, -0.85, -6.25)

				var_635_0.localPosition = Vector3.Lerp(arg_632_1.var_.moveOldPos1020ui_story, var_635_4, var_635_3)

				local var_635_5 = manager.ui.mainCamera.transform.position - var_635_0.position

				var_635_0.forward = Vector3.New(var_635_5.x, var_635_5.y, var_635_5.z)

				local var_635_6 = var_635_0.localEulerAngles

				var_635_6.z = 0
				var_635_6.x = 0
				var_635_0.localEulerAngles = var_635_6
			end

			if arg_632_1.time_ >= var_635_1 + var_635_2 and arg_632_1.time_ < var_635_1 + var_635_2 + arg_635_0 then
				var_635_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_635_7 = manager.ui.mainCamera.transform.position - var_635_0.position

				var_635_0.forward = Vector3.New(var_635_7.x, var_635_7.y, var_635_7.z)

				local var_635_8 = var_635_0.localEulerAngles

				var_635_8.z = 0
				var_635_8.x = 0
				var_635_0.localEulerAngles = var_635_8
			end

			local var_635_9 = arg_632_1.actors_["1020ui_story"]
			local var_635_10 = 0

			if var_635_10 < arg_632_1.time_ and arg_632_1.time_ <= var_635_10 + arg_635_0 and not isNil(var_635_9) and arg_632_1.var_.characterEffect1020ui_story == nil then
				arg_632_1.var_.characterEffect1020ui_story = var_635_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_635_11 = 0.200000002980232

			if var_635_10 <= arg_632_1.time_ and arg_632_1.time_ < var_635_10 + var_635_11 and not isNil(var_635_9) then
				local var_635_12 = (arg_632_1.time_ - var_635_10) / var_635_11

				if arg_632_1.var_.characterEffect1020ui_story and not isNil(var_635_9) then
					arg_632_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_632_1.time_ >= var_635_10 + var_635_11 and arg_632_1.time_ < var_635_10 + var_635_11 + arg_635_0 and not isNil(var_635_9) and arg_632_1.var_.characterEffect1020ui_story then
				arg_632_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_635_13 = 0

			if var_635_13 < arg_632_1.time_ and arg_632_1.time_ <= var_635_13 + arg_635_0 then
				arg_632_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_635_14 = 0

			if var_635_14 < arg_632_1.time_ and arg_632_1.time_ <= var_635_14 + arg_635_0 then
				arg_632_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action8_2")
			end

			local var_635_15 = 0
			local var_635_16 = 0.125

			if var_635_15 < arg_632_1.time_ and arg_632_1.time_ <= var_635_15 + arg_635_0 then
				arg_632_1.talkMaxDuration = 0
				arg_632_1.dialogCg_.alpha = 1

				arg_632_1.dialog_:SetActive(true)
				SetActive(arg_632_1.leftNameGo_, true)

				local var_635_17 = arg_632_1:FormatText(StoryNameCfg[613].name)

				arg_632_1.leftNameTxt_.text = var_635_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_632_1.leftNameTxt_.transform)

				arg_632_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_632_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_632_1:RecordName(arg_632_1.leftNameTxt_.text)
				SetActive(arg_632_1.iconTrs_.gameObject, false)
				arg_632_1.callingController_:SetSelectedState("normal")

				local var_635_18 = arg_632_1:GetWordFromCfg(924011153)
				local var_635_19 = arg_632_1:FormatText(var_635_18.content)

				arg_632_1.text_.text = var_635_19

				LuaForUtil.ClearLinePrefixSymbol(arg_632_1.text_)

				local var_635_20 = 5
				local var_635_21 = utf8.len(var_635_19)
				local var_635_22 = var_635_20 <= 0 and var_635_16 or var_635_16 * (var_635_21 / var_635_20)

				if var_635_22 > 0 and var_635_16 < var_635_22 then
					arg_632_1.talkMaxDuration = var_635_22

					if var_635_22 + var_635_15 > arg_632_1.duration_ then
						arg_632_1.duration_ = var_635_22 + var_635_15
					end
				end

				arg_632_1.text_.text = var_635_19
				arg_632_1.typewritter.percent = 0

				arg_632_1.typewritter:SetDirty()
				arg_632_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011153", "story_v_side_old_924011.awb") ~= 0 then
					local var_635_23 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011153", "story_v_side_old_924011.awb") / 1000

					if var_635_23 + var_635_15 > arg_632_1.duration_ then
						arg_632_1.duration_ = var_635_23 + var_635_15
					end

					if var_635_18.prefab_name ~= "" and arg_632_1.actors_[var_635_18.prefab_name] ~= nil then
						local var_635_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_632_1.actors_[var_635_18.prefab_name].transform, "story_v_side_old_924011", "924011153", "story_v_side_old_924011.awb")

						arg_632_1:RecordAudio("924011153", var_635_24)
						arg_632_1:RecordAudio("924011153", var_635_24)
					else
						arg_632_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011153", "story_v_side_old_924011.awb")
					end

					arg_632_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011153", "story_v_side_old_924011.awb")
				end

				arg_632_1:RecordContent(arg_632_1.text_.text)
			end

			local var_635_25 = math.max(var_635_16, arg_632_1.talkMaxDuration)

			if var_635_15 <= arg_632_1.time_ and arg_632_1.time_ < var_635_15 + var_635_25 then
				arg_632_1.typewritter.percent = (arg_632_1.time_ - var_635_15) / var_635_25

				arg_632_1.typewritter:SetDirty()
			end

			if arg_632_1.time_ >= var_635_15 + var_635_25 and arg_632_1.time_ < var_635_15 + var_635_25 + arg_635_0 then
				arg_632_1.typewritter.percent = 1

				arg_632_1.typewritter:SetDirty()
				arg_632_1:ShowNextGo(true)
			end
		end

		arg_632_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_632_1:InitPlayNodeList()
	end,
	Play924011154 = function(arg_636_0, arg_636_1)
		arg_636_1.time_ = 0
		arg_636_1.frameCnt_ = 0
		arg_636_1.state_ = "playing"
		arg_636_1.curTalkId_ = 924011154
		arg_636_1.duration_ = 5

		SetActive(arg_636_1.tipsGo_, false)

		function arg_636_1.onSingleLineFinish_()
			arg_636_1.onSingleLineUpdate_ = nil
			arg_636_1.onSingleLineFinish_ = nil
			arg_636_1.state_ = "waiting"
		end

		function arg_636_1.playNext_(arg_638_0)
			if arg_638_0 == 1 then
				arg_636_0:Play924011155(arg_636_1)
			end
		end

		function arg_636_1.onSingleLineUpdate_(arg_639_0)
			local var_639_0 = arg_636_1.actors_["1020ui_story"].transform
			local var_639_1 = 0

			if var_639_1 < arg_636_1.time_ and arg_636_1.time_ <= var_639_1 + arg_639_0 then
				arg_636_1.var_.moveOldPos1020ui_story = var_639_0.localPosition
			end

			local var_639_2 = 0.001

			if var_639_1 <= arg_636_1.time_ and arg_636_1.time_ < var_639_1 + var_639_2 then
				local var_639_3 = (arg_636_1.time_ - var_639_1) / var_639_2
				local var_639_4 = Vector3.New(0, 100, 0)

				var_639_0.localPosition = Vector3.Lerp(arg_636_1.var_.moveOldPos1020ui_story, var_639_4, var_639_3)

				local var_639_5 = manager.ui.mainCamera.transform.position - var_639_0.position

				var_639_0.forward = Vector3.New(var_639_5.x, var_639_5.y, var_639_5.z)

				local var_639_6 = var_639_0.localEulerAngles

				var_639_6.z = 0
				var_639_6.x = 0
				var_639_0.localEulerAngles = var_639_6
			end

			if arg_636_1.time_ >= var_639_1 + var_639_2 and arg_636_1.time_ < var_639_1 + var_639_2 + arg_639_0 then
				var_639_0.localPosition = Vector3.New(0, 100, 0)

				local var_639_7 = manager.ui.mainCamera.transform.position - var_639_0.position

				var_639_0.forward = Vector3.New(var_639_7.x, var_639_7.y, var_639_7.z)

				local var_639_8 = var_639_0.localEulerAngles

				var_639_8.z = 0
				var_639_8.x = 0
				var_639_0.localEulerAngles = var_639_8
			end

			local var_639_9 = arg_636_1.actors_["1020ui_story"]
			local var_639_10 = 0

			if var_639_10 < arg_636_1.time_ and arg_636_1.time_ <= var_639_10 + arg_639_0 and not isNil(var_639_9) and arg_636_1.var_.characterEffect1020ui_story == nil then
				arg_636_1.var_.characterEffect1020ui_story = var_639_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_639_11 = 0.200000002980232

			if var_639_10 <= arg_636_1.time_ and arg_636_1.time_ < var_639_10 + var_639_11 and not isNil(var_639_9) then
				local var_639_12 = (arg_636_1.time_ - var_639_10) / var_639_11

				if arg_636_1.var_.characterEffect1020ui_story and not isNil(var_639_9) then
					local var_639_13 = Mathf.Lerp(0, 0.5, var_639_12)

					arg_636_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_636_1.var_.characterEffect1020ui_story.fillRatio = var_639_13
				end
			end

			if arg_636_1.time_ >= var_639_10 + var_639_11 and arg_636_1.time_ < var_639_10 + var_639_11 + arg_639_0 and not isNil(var_639_9) and arg_636_1.var_.characterEffect1020ui_story then
				local var_639_14 = 0.5

				arg_636_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_636_1.var_.characterEffect1020ui_story.fillRatio = var_639_14
			end

			local var_639_15 = 0
			local var_639_16 = 0.2

			if var_639_15 < arg_636_1.time_ and arg_636_1.time_ <= var_639_15 + arg_639_0 then
				local var_639_17 = "play"
				local var_639_18 = "music"

				arg_636_1:AudioAction(var_639_17, var_639_18, "ui_battle", "ui_battle_stopbgm", "")

				local var_639_19 = ""
				local var_639_20 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_639_20 ~= "" then
					if arg_636_1.bgmTxt_.text ~= var_639_20 and arg_636_1.bgmTxt_.text ~= "" then
						if arg_636_1.bgmTxt2_.text ~= "" then
							arg_636_1.bgmTxt_.text = arg_636_1.bgmTxt2_.text
						end

						arg_636_1.bgmTxt2_.text = var_639_20

						arg_636_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_636_1.bgmTxt_.text = var_639_20
						arg_636_1.bgmTxt2_.text = var_639_20
					end

					if arg_636_1.bgmTimer then
						arg_636_1.bgmTimer:Stop()

						arg_636_1.bgmTimer = nil
					end

					if arg_636_1.settingData.show_music_name == 1 then
						arg_636_1.musicController:SetSelectedState("show")
						arg_636_1.musicAnimator_:Play("open", 0, 0)

						if arg_636_1.settingData.music_time ~= 0 then
							arg_636_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_636_1.settingData.music_time), function()
								if arg_636_1 == nil or isNil(arg_636_1.bgmTxt_) then
									return
								end

								arg_636_1.musicController:SetSelectedState("hide")
								arg_636_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_639_21 = 0
			local var_639_22 = 0.925

			if var_639_21 < arg_636_1.time_ and arg_636_1.time_ <= var_639_21 + arg_639_0 then
				arg_636_1.talkMaxDuration = 0
				arg_636_1.dialogCg_.alpha = 1

				arg_636_1.dialog_:SetActive(true)
				SetActive(arg_636_1.leftNameGo_, false)

				arg_636_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_636_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_636_1:RecordName(arg_636_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_636_1.iconTrs_.gameObject, false)
				arg_636_1.callingController_:SetSelectedState("normal")

				local var_639_23 = arg_636_1:GetWordFromCfg(924011154)
				local var_639_24 = arg_636_1:FormatText(var_639_23.content)

				arg_636_1.text_.text = var_639_24

				LuaForUtil.ClearLinePrefixSymbol(arg_636_1.text_)

				local var_639_25 = 37
				local var_639_26 = utf8.len(var_639_24)
				local var_639_27 = var_639_25 <= 0 and var_639_22 or var_639_22 * (var_639_26 / var_639_25)

				if var_639_27 > 0 and var_639_22 < var_639_27 then
					arg_636_1.talkMaxDuration = var_639_27

					if var_639_27 + var_639_21 > arg_636_1.duration_ then
						arg_636_1.duration_ = var_639_27 + var_639_21
					end
				end

				arg_636_1.text_.text = var_639_24
				arg_636_1.typewritter.percent = 0

				arg_636_1.typewritter:SetDirty()
				arg_636_1:ShowNextGo(false)
				arg_636_1:RecordContent(arg_636_1.text_.text)
			end

			local var_639_28 = math.max(var_639_22, arg_636_1.talkMaxDuration)

			if var_639_21 <= arg_636_1.time_ and arg_636_1.time_ < var_639_21 + var_639_28 then
				arg_636_1.typewritter.percent = (arg_636_1.time_ - var_639_21) / var_639_28

				arg_636_1.typewritter:SetDirty()
			end

			if arg_636_1.time_ >= var_639_21 + var_639_28 and arg_636_1.time_ < var_639_21 + var_639_28 + arg_639_0 then
				arg_636_1.typewritter.percent = 1

				arg_636_1.typewritter:SetDirty()
				arg_636_1:ShowNextGo(true)
			end
		end

		arg_636_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_636_1:InitPlayNodeList()
	end,
	Play924011155 = function(arg_641_0, arg_641_1)
		arg_641_1.time_ = 0
		arg_641_1.frameCnt_ = 0
		arg_641_1.state_ = "playing"
		arg_641_1.curTalkId_ = 924011155
		arg_641_1.duration_ = 12.2

		local var_641_0 = {
			zh = 9.83300000298023,
			ja = 12.2000000029802
		}
		local var_641_1 = manager.audio:GetLocalizationFlag()

		if var_641_0[var_641_1] ~= nil then
			arg_641_1.duration_ = var_641_0[var_641_1]
		end

		SetActive(arg_641_1.tipsGo_, false)

		function arg_641_1.onSingleLineFinish_()
			arg_641_1.onSingleLineUpdate_ = nil
			arg_641_1.onSingleLineFinish_ = nil
			arg_641_1.state_ = "waiting"
		end

		function arg_641_1.playNext_(arg_643_0)
			if arg_643_0 == 1 then
				arg_641_0:Play924011156(arg_641_1)
			end
		end

		function arg_641_1.onSingleLineUpdate_(arg_644_0)
			local var_644_0 = 2.00000000298023

			if var_644_0 < arg_641_1.time_ and arg_641_1.time_ <= var_644_0 + arg_644_0 then
				local var_644_1 = manager.ui.mainCamera.transform.localPosition
				local var_644_2 = Vector3.New(0, 0, 10) + Vector3.New(var_644_1.x, var_644_1.y, 0)
				local var_644_3 = arg_641_1.bgs_.ST01

				var_644_3.transform.localPosition = var_644_2
				var_644_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_644_4 = var_644_3:GetComponent("SpriteRenderer")

				if var_644_4 and var_644_4.sprite then
					local var_644_5 = (var_644_3.transform.localPosition - var_644_1).z
					local var_644_6 = manager.ui.mainCameraCom_
					local var_644_7 = 2 * var_644_5 * Mathf.Tan(var_644_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_644_8 = var_644_7 * var_644_6.aspect
					local var_644_9 = var_644_4.sprite.bounds.size.x
					local var_644_10 = var_644_4.sprite.bounds.size.y
					local var_644_11 = var_644_8 / var_644_9
					local var_644_12 = var_644_7 / var_644_10
					local var_644_13 = var_644_12 < var_644_11 and var_644_11 or var_644_12

					var_644_3.transform.localScale = Vector3.New(var_644_13, var_644_13, 0)
				end

				for iter_644_0, iter_644_1 in pairs(arg_641_1.bgs_) do
					if iter_644_0 ~= "ST01" then
						iter_644_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_644_14 = 4

			if var_644_14 < arg_641_1.time_ and arg_641_1.time_ <= var_644_14 + arg_644_0 then
				arg_641_1.allBtn_.enabled = false
			end

			local var_644_15 = 0.3

			if arg_641_1.time_ >= var_644_14 + var_644_15 and arg_641_1.time_ < var_644_14 + var_644_15 + arg_644_0 then
				arg_641_1.allBtn_.enabled = true
			end

			local var_644_16 = 0

			if var_644_16 < arg_641_1.time_ and arg_641_1.time_ <= var_644_16 + arg_644_0 then
				arg_641_1.mask_.enabled = true
				arg_641_1.mask_.raycastTarget = true

				arg_641_1:SetGaussion(false)
			end

			local var_644_17 = 2

			if var_644_16 <= arg_641_1.time_ and arg_641_1.time_ < var_644_16 + var_644_17 then
				local var_644_18 = (arg_641_1.time_ - var_644_16) / var_644_17
				local var_644_19 = Color.New(0, 0, 0)

				var_644_19.a = Mathf.Lerp(0, 1, var_644_18)
				arg_641_1.mask_.color = var_644_19
			end

			if arg_641_1.time_ >= var_644_16 + var_644_17 and arg_641_1.time_ < var_644_16 + var_644_17 + arg_644_0 then
				local var_644_20 = Color.New(0, 0, 0)

				var_644_20.a = 1
				arg_641_1.mask_.color = var_644_20
			end

			local var_644_21 = 2

			if var_644_21 < arg_641_1.time_ and arg_641_1.time_ <= var_644_21 + arg_644_0 then
				arg_641_1.mask_.enabled = true
				arg_641_1.mask_.raycastTarget = true

				arg_641_1:SetGaussion(false)
			end

			local var_644_22 = 2

			if var_644_21 <= arg_641_1.time_ and arg_641_1.time_ < var_644_21 + var_644_22 then
				local var_644_23 = (arg_641_1.time_ - var_644_21) / var_644_22
				local var_644_24 = Color.New(0, 0, 0)

				var_644_24.a = Mathf.Lerp(1, 0, var_644_23)
				arg_641_1.mask_.color = var_644_24
			end

			if arg_641_1.time_ >= var_644_21 + var_644_22 and arg_641_1.time_ < var_644_21 + var_644_22 + arg_644_0 then
				local var_644_25 = Color.New(0, 0, 0)
				local var_644_26 = 0

				arg_641_1.mask_.enabled = false
				var_644_25.a = var_644_26
				arg_641_1.mask_.color = var_644_25
			end

			local var_644_27 = arg_641_1.actors_["1033ui_story"].transform
			local var_644_28 = 3.8

			if var_644_28 < arg_641_1.time_ and arg_641_1.time_ <= var_644_28 + arg_644_0 then
				arg_641_1.var_.moveOldPos1033ui_story = var_644_27.localPosition
			end

			local var_644_29 = 0.001

			if var_644_28 <= arg_641_1.time_ and arg_641_1.time_ < var_644_28 + var_644_29 then
				local var_644_30 = (arg_641_1.time_ - var_644_28) / var_644_29
				local var_644_31 = Vector3.New(0, -1.01, -6.13)

				var_644_27.localPosition = Vector3.Lerp(arg_641_1.var_.moveOldPos1033ui_story, var_644_31, var_644_30)

				local var_644_32 = manager.ui.mainCamera.transform.position - var_644_27.position

				var_644_27.forward = Vector3.New(var_644_32.x, var_644_32.y, var_644_32.z)

				local var_644_33 = var_644_27.localEulerAngles

				var_644_33.z = 0
				var_644_33.x = 0
				var_644_27.localEulerAngles = var_644_33
			end

			if arg_641_1.time_ >= var_644_28 + var_644_29 and arg_641_1.time_ < var_644_28 + var_644_29 + arg_644_0 then
				var_644_27.localPosition = Vector3.New(0, -1.01, -6.13)

				local var_644_34 = manager.ui.mainCamera.transform.position - var_644_27.position

				var_644_27.forward = Vector3.New(var_644_34.x, var_644_34.y, var_644_34.z)

				local var_644_35 = var_644_27.localEulerAngles

				var_644_35.z = 0
				var_644_35.x = 0
				var_644_27.localEulerAngles = var_644_35
			end

			local var_644_36 = arg_641_1.actors_["1033ui_story"]
			local var_644_37 = 3.8

			if var_644_37 < arg_641_1.time_ and arg_641_1.time_ <= var_644_37 + arg_644_0 and not isNil(var_644_36) and arg_641_1.var_.characterEffect1033ui_story == nil then
				arg_641_1.var_.characterEffect1033ui_story = var_644_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_644_38 = 0.200000002980232

			if var_644_37 <= arg_641_1.time_ and arg_641_1.time_ < var_644_37 + var_644_38 and not isNil(var_644_36) then
				local var_644_39 = (arg_641_1.time_ - var_644_37) / var_644_38

				if arg_641_1.var_.characterEffect1033ui_story and not isNil(var_644_36) then
					arg_641_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_641_1.time_ >= var_644_37 + var_644_38 and arg_641_1.time_ < var_644_37 + var_644_38 + arg_644_0 and not isNil(var_644_36) and arg_641_1.var_.characterEffect1033ui_story then
				arg_641_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_644_40 = 3.8

			if var_644_40 < arg_641_1.time_ and arg_641_1.time_ <= var_644_40 + arg_644_0 then
				arg_641_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action1_1")
			end

			local var_644_41 = 3.8

			if var_644_41 < arg_641_1.time_ and arg_641_1.time_ <= var_644_41 + arg_644_0 then
				arg_641_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_644_42 = arg_641_1.actors_["1033ui_story"]
			local var_644_43 = 3.8

			if var_644_43 < arg_641_1.time_ and arg_641_1.time_ <= var_644_43 + arg_644_0 then
				if arg_641_1.var_.characterEffect1033ui_story == nil then
					arg_641_1.var_.characterEffect1033ui_story = var_644_42:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_644_44 = arg_641_1.var_.characterEffect1033ui_story

				var_644_44.imageEffect:turnOff()

				var_644_44.interferenceEffect.enabled = true
				var_644_44.interferenceEffect.noise = 0.001
				var_644_44.interferenceEffect.simTimeScale = 1
				var_644_44.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_644_45 = arg_641_1.actors_["1033ui_story"]
			local var_644_46 = 3.8
			local var_644_47 = 0.2

			if var_644_46 < arg_641_1.time_ and arg_641_1.time_ <= var_644_46 + arg_644_0 then
				if arg_641_1.var_.characterEffect1033ui_story == nil then
					arg_641_1.var_.characterEffect1033ui_story = var_644_45:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_641_1.var_.characterEffect1033ui_story.imageEffect:turnOn(false)
			end

			local var_644_48 = 0
			local var_644_49 = 0.2

			if var_644_48 < arg_641_1.time_ and arg_641_1.time_ <= var_644_48 + arg_644_0 then
				local var_644_50 = "play"
				local var_644_51 = "music"

				arg_641_1:AudioAction(var_644_50, var_644_51, "ui_battle", "ui_battle_stopbgm", "")

				local var_644_52 = ""
				local var_644_53 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_644_53 ~= "" then
					if arg_641_1.bgmTxt_.text ~= var_644_53 and arg_641_1.bgmTxt_.text ~= "" then
						if arg_641_1.bgmTxt2_.text ~= "" then
							arg_641_1.bgmTxt_.text = arg_641_1.bgmTxt2_.text
						end

						arg_641_1.bgmTxt2_.text = var_644_53

						arg_641_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_641_1.bgmTxt_.text = var_644_53
						arg_641_1.bgmTxt2_.text = var_644_53
					end

					if arg_641_1.bgmTimer then
						arg_641_1.bgmTimer:Stop()

						arg_641_1.bgmTimer = nil
					end

					if arg_641_1.settingData.show_music_name == 1 then
						arg_641_1.musicController:SetSelectedState("show")
						arg_641_1.musicAnimator_:Play("open", 0, 0)

						if arg_641_1.settingData.music_time ~= 0 then
							arg_641_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_641_1.settingData.music_time), function()
								if arg_641_1 == nil or isNil(arg_641_1.bgmTxt_) then
									return
								end

								arg_641_1.musicController:SetSelectedState("hide")
								arg_641_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_644_54 = 1
			local var_644_55 = 1

			if var_644_54 < arg_641_1.time_ and arg_641_1.time_ <= var_644_54 + arg_644_0 then
				local var_644_56 = "play"
				local var_644_57 = "music"

				arg_641_1:AudioAction(var_644_56, var_644_57, "bgm_side_daily04", "bgm_side_daily04", "bgm_side_daily04.awb")

				local var_644_58 = ""
				local var_644_59 = manager.audio:GetAudioName("bgm_side_daily04", "bgm_side_daily04")

				if var_644_59 ~= "" then
					if arg_641_1.bgmTxt_.text ~= var_644_59 and arg_641_1.bgmTxt_.text ~= "" then
						if arg_641_1.bgmTxt2_.text ~= "" then
							arg_641_1.bgmTxt_.text = arg_641_1.bgmTxt2_.text
						end

						arg_641_1.bgmTxt2_.text = var_644_59

						arg_641_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_641_1.bgmTxt_.text = var_644_59
						arg_641_1.bgmTxt2_.text = var_644_59
					end

					if arg_641_1.bgmTimer then
						arg_641_1.bgmTimer:Stop()

						arg_641_1.bgmTimer = nil
					end

					if arg_641_1.settingData.show_music_name == 1 then
						arg_641_1.musicController:SetSelectedState("show")
						arg_641_1.musicAnimator_:Play("open", 0, 0)

						if arg_641_1.settingData.music_time ~= 0 then
							arg_641_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_641_1.settingData.music_time), function()
								if arg_641_1 == nil or isNil(arg_641_1.bgmTxt_) then
									return
								end

								arg_641_1.musicController:SetSelectedState("hide")
								arg_641_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_641_1.frameCnt_ <= 1 then
				arg_641_1.dialog_:SetActive(false)
			end

			local var_644_60 = 4.00000000298023
			local var_644_61 = 0.75

			if var_644_60 < arg_641_1.time_ and arg_641_1.time_ <= var_644_60 + arg_644_0 then
				arg_641_1.talkMaxDuration = 0

				arg_641_1.dialog_:SetActive(true)

				arg_641_1.dialogCg_.alpha = 0

				local var_644_62 = LeanTween.value(arg_641_1.dialog_, 0, 1, 0.3)

				var_644_62:setOnUpdate(LuaHelper.FloatAction(function(arg_647_0)
					arg_641_1.dialogCg_.alpha = arg_647_0
				end))
				var_644_62:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_641_1.dialog_)
					var_644_62:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_641_1.duration_ = arg_641_1.duration_ + 0.3

				SetActive(arg_641_1.leftNameGo_, true)

				local var_644_63 = arg_641_1:FormatText(StoryNameCfg[236].name)

				arg_641_1.leftNameTxt_.text = var_644_63

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_641_1.leftNameTxt_.transform)

				arg_641_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_641_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_641_1:RecordName(arg_641_1.leftNameTxt_.text)
				SetActive(arg_641_1.iconTrs_.gameObject, false)
				arg_641_1.callingController_:SetSelectedState("normal")

				local var_644_64 = arg_641_1:GetWordFromCfg(924011155)
				local var_644_65 = arg_641_1:FormatText(var_644_64.content)

				arg_641_1.text_.text = var_644_65

				LuaForUtil.ClearLinePrefixSymbol(arg_641_1.text_)

				local var_644_66 = 30
				local var_644_67 = utf8.len(var_644_65)
				local var_644_68 = var_644_66 <= 0 and var_644_61 or var_644_61 * (var_644_67 / var_644_66)

				if var_644_68 > 0 and var_644_61 < var_644_68 then
					arg_641_1.talkMaxDuration = var_644_68
					var_644_60 = var_644_60 + 0.3

					if var_644_68 + var_644_60 > arg_641_1.duration_ then
						arg_641_1.duration_ = var_644_68 + var_644_60
					end
				end

				arg_641_1.text_.text = var_644_65
				arg_641_1.typewritter.percent = 0

				arg_641_1.typewritter:SetDirty()
				arg_641_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011155", "story_v_side_old_924011.awb") ~= 0 then
					local var_644_69 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011155", "story_v_side_old_924011.awb") / 1000

					if var_644_69 + var_644_60 > arg_641_1.duration_ then
						arg_641_1.duration_ = var_644_69 + var_644_60
					end

					if var_644_64.prefab_name ~= "" and arg_641_1.actors_[var_644_64.prefab_name] ~= nil then
						local var_644_70 = LuaForUtil.PlayVoiceWithCriLipsync(arg_641_1.actors_[var_644_64.prefab_name].transform, "story_v_side_old_924011", "924011155", "story_v_side_old_924011.awb")

						arg_641_1:RecordAudio("924011155", var_644_70)
						arg_641_1:RecordAudio("924011155", var_644_70)
					else
						arg_641_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011155", "story_v_side_old_924011.awb")
					end

					arg_641_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011155", "story_v_side_old_924011.awb")
				end

				arg_641_1:RecordContent(arg_641_1.text_.text)
			end

			local var_644_71 = var_644_60 + 0.3
			local var_644_72 = math.max(var_644_61, arg_641_1.talkMaxDuration)

			if var_644_71 <= arg_641_1.time_ and arg_641_1.time_ < var_644_71 + var_644_72 then
				arg_641_1.typewritter.percent = (arg_641_1.time_ - var_644_71) / var_644_72

				arg_641_1.typewritter:SetDirty()
			end

			if arg_641_1.time_ >= var_644_71 + var_644_72 and arg_641_1.time_ < var_644_71 + var_644_72 + arg_644_0 then
				arg_641_1.typewritter.percent = 1

				arg_641_1.typewritter:SetDirty()
				arg_641_1:ShowNextGo(true)
			end
		end

		arg_641_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_641_1:InitPlayNodeList()
	end,
	Play924011156 = function(arg_649_0, arg_649_1)
		arg_649_1.time_ = 0
		arg_649_1.frameCnt_ = 0
		arg_649_1.state_ = "playing"
		arg_649_1.curTalkId_ = 924011156
		arg_649_1.duration_ = 15.63

		local var_649_0 = {
			zh = 10.433,
			ja = 15.633
		}
		local var_649_1 = manager.audio:GetLocalizationFlag()

		if var_649_0[var_649_1] ~= nil then
			arg_649_1.duration_ = var_649_0[var_649_1]
		end

		SetActive(arg_649_1.tipsGo_, false)

		function arg_649_1.onSingleLineFinish_()
			arg_649_1.onSingleLineUpdate_ = nil
			arg_649_1.onSingleLineFinish_ = nil
			arg_649_1.state_ = "waiting"
		end

		function arg_649_1.playNext_(arg_651_0)
			if arg_651_0 == 1 then
				arg_649_0:Play924011157(arg_649_1)
			end
		end

		function arg_649_1.onSingleLineUpdate_(arg_652_0)
			local var_652_0 = 0

			if var_652_0 < arg_649_1.time_ and arg_649_1.time_ <= var_652_0 + arg_652_0 then
				arg_649_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action3_1")
			end

			local var_652_1 = 0

			if var_652_1 < arg_649_1.time_ and arg_649_1.time_ <= var_652_1 + arg_652_0 then
				arg_649_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_652_2 = 0
			local var_652_3 = 1.325

			if var_652_2 < arg_649_1.time_ and arg_649_1.time_ <= var_652_2 + arg_652_0 then
				arg_649_1.talkMaxDuration = 0
				arg_649_1.dialogCg_.alpha = 1

				arg_649_1.dialog_:SetActive(true)
				SetActive(arg_649_1.leftNameGo_, true)

				local var_652_4 = arg_649_1:FormatText(StoryNameCfg[236].name)

				arg_649_1.leftNameTxt_.text = var_652_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_649_1.leftNameTxt_.transform)

				arg_649_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_649_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_649_1:RecordName(arg_649_1.leftNameTxt_.text)
				SetActive(arg_649_1.iconTrs_.gameObject, false)
				arg_649_1.callingController_:SetSelectedState("normal")

				local var_652_5 = arg_649_1:GetWordFromCfg(924011156)
				local var_652_6 = arg_649_1:FormatText(var_652_5.content)

				arg_649_1.text_.text = var_652_6

				LuaForUtil.ClearLinePrefixSymbol(arg_649_1.text_)

				local var_652_7 = 53
				local var_652_8 = utf8.len(var_652_6)
				local var_652_9 = var_652_7 <= 0 and var_652_3 or var_652_3 * (var_652_8 / var_652_7)

				if var_652_9 > 0 and var_652_3 < var_652_9 then
					arg_649_1.talkMaxDuration = var_652_9

					if var_652_9 + var_652_2 > arg_649_1.duration_ then
						arg_649_1.duration_ = var_652_9 + var_652_2
					end
				end

				arg_649_1.text_.text = var_652_6
				arg_649_1.typewritter.percent = 0

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011156", "story_v_side_old_924011.awb") ~= 0 then
					local var_652_10 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011156", "story_v_side_old_924011.awb") / 1000

					if var_652_10 + var_652_2 > arg_649_1.duration_ then
						arg_649_1.duration_ = var_652_10 + var_652_2
					end

					if var_652_5.prefab_name ~= "" and arg_649_1.actors_[var_652_5.prefab_name] ~= nil then
						local var_652_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_649_1.actors_[var_652_5.prefab_name].transform, "story_v_side_old_924011", "924011156", "story_v_side_old_924011.awb")

						arg_649_1:RecordAudio("924011156", var_652_11)
						arg_649_1:RecordAudio("924011156", var_652_11)
					else
						arg_649_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011156", "story_v_side_old_924011.awb")
					end

					arg_649_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011156", "story_v_side_old_924011.awb")
				end

				arg_649_1:RecordContent(arg_649_1.text_.text)
			end

			local var_652_12 = math.max(var_652_3, arg_649_1.talkMaxDuration)

			if var_652_2 <= arg_649_1.time_ and arg_649_1.time_ < var_652_2 + var_652_12 then
				arg_649_1.typewritter.percent = (arg_649_1.time_ - var_652_2) / var_652_12

				arg_649_1.typewritter:SetDirty()
			end

			if arg_649_1.time_ >= var_652_2 + var_652_12 and arg_649_1.time_ < var_652_2 + var_652_12 + arg_652_0 then
				arg_649_1.typewritter.percent = 1

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(true)
			end
		end

		arg_649_1.nodeConfigList_ = {}

		arg_649_1:InitPlayNodeList()
	end,
	Play924011157 = function(arg_653_0, arg_653_1)
		arg_653_1.time_ = 0
		arg_653_1.frameCnt_ = 0
		arg_653_1.state_ = "playing"
		arg_653_1.curTalkId_ = 924011157
		arg_653_1.duration_ = 2.3

		local var_653_0 = {
			zh = 2,
			ja = 2.3
		}
		local var_653_1 = manager.audio:GetLocalizationFlag()

		if var_653_0[var_653_1] ~= nil then
			arg_653_1.duration_ = var_653_0[var_653_1]
		end

		SetActive(arg_653_1.tipsGo_, false)

		function arg_653_1.onSingleLineFinish_()
			arg_653_1.onSingleLineUpdate_ = nil
			arg_653_1.onSingleLineFinish_ = nil
			arg_653_1.state_ = "waiting"
		end

		function arg_653_1.playNext_(arg_655_0)
			if arg_655_0 == 1 then
				arg_653_0:Play924011158(arg_653_1)
			end
		end

		function arg_653_1.onSingleLineUpdate_(arg_656_0)
			local var_656_0 = arg_653_1.actors_["1020ui_story"].transform
			local var_656_1 = 0

			if var_656_1 < arg_653_1.time_ and arg_653_1.time_ <= var_656_1 + arg_656_0 then
				arg_653_1.var_.moveOldPos1020ui_story = var_656_0.localPosition
			end

			local var_656_2 = 0.001

			if var_656_1 <= arg_653_1.time_ and arg_653_1.time_ < var_656_1 + var_656_2 then
				local var_656_3 = (arg_653_1.time_ - var_656_1) / var_656_2
				local var_656_4 = Vector3.New(0.7, -0.85, -6.25)

				var_656_0.localPosition = Vector3.Lerp(arg_653_1.var_.moveOldPos1020ui_story, var_656_4, var_656_3)

				local var_656_5 = manager.ui.mainCamera.transform.position - var_656_0.position

				var_656_0.forward = Vector3.New(var_656_5.x, var_656_5.y, var_656_5.z)

				local var_656_6 = var_656_0.localEulerAngles

				var_656_6.z = 0
				var_656_6.x = 0
				var_656_0.localEulerAngles = var_656_6
			end

			if arg_653_1.time_ >= var_656_1 + var_656_2 and arg_653_1.time_ < var_656_1 + var_656_2 + arg_656_0 then
				var_656_0.localPosition = Vector3.New(0.7, -0.85, -6.25)

				local var_656_7 = manager.ui.mainCamera.transform.position - var_656_0.position

				var_656_0.forward = Vector3.New(var_656_7.x, var_656_7.y, var_656_7.z)

				local var_656_8 = var_656_0.localEulerAngles

				var_656_8.z = 0
				var_656_8.x = 0
				var_656_0.localEulerAngles = var_656_8
			end

			local var_656_9 = arg_653_1.actors_["1033ui_story"].transform
			local var_656_10 = 0

			if var_656_10 < arg_653_1.time_ and arg_653_1.time_ <= var_656_10 + arg_656_0 then
				arg_653_1.var_.moveOldPos1033ui_story = var_656_9.localPosition
			end

			local var_656_11 = 0.001

			if var_656_10 <= arg_653_1.time_ and arg_653_1.time_ < var_656_10 + var_656_11 then
				local var_656_12 = (arg_653_1.time_ - var_656_10) / var_656_11
				local var_656_13 = Vector3.New(-0.7, -1.01, -6.13)

				var_656_9.localPosition = Vector3.Lerp(arg_653_1.var_.moveOldPos1033ui_story, var_656_13, var_656_12)

				local var_656_14 = manager.ui.mainCamera.transform.position - var_656_9.position

				var_656_9.forward = Vector3.New(var_656_14.x, var_656_14.y, var_656_14.z)

				local var_656_15 = var_656_9.localEulerAngles

				var_656_15.z = 0
				var_656_15.x = 0
				var_656_9.localEulerAngles = var_656_15
			end

			if arg_653_1.time_ >= var_656_10 + var_656_11 and arg_653_1.time_ < var_656_10 + var_656_11 + arg_656_0 then
				var_656_9.localPosition = Vector3.New(-0.7, -1.01, -6.13)

				local var_656_16 = manager.ui.mainCamera.transform.position - var_656_9.position

				var_656_9.forward = Vector3.New(var_656_16.x, var_656_16.y, var_656_16.z)

				local var_656_17 = var_656_9.localEulerAngles

				var_656_17.z = 0
				var_656_17.x = 0
				var_656_9.localEulerAngles = var_656_17
			end

			local var_656_18 = arg_653_1.actors_["1020ui_story"]
			local var_656_19 = 0

			if var_656_19 < arg_653_1.time_ and arg_653_1.time_ <= var_656_19 + arg_656_0 and not isNil(var_656_18) and arg_653_1.var_.characterEffect1020ui_story == nil then
				arg_653_1.var_.characterEffect1020ui_story = var_656_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_656_20 = 0.200000002980232

			if var_656_19 <= arg_653_1.time_ and arg_653_1.time_ < var_656_19 + var_656_20 and not isNil(var_656_18) then
				local var_656_21 = (arg_653_1.time_ - var_656_19) / var_656_20

				if arg_653_1.var_.characterEffect1020ui_story and not isNil(var_656_18) then
					arg_653_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_653_1.time_ >= var_656_19 + var_656_20 and arg_653_1.time_ < var_656_19 + var_656_20 + arg_656_0 and not isNil(var_656_18) and arg_653_1.var_.characterEffect1020ui_story then
				arg_653_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_656_22 = arg_653_1.actors_["1033ui_story"]
			local var_656_23 = 0

			if var_656_23 < arg_653_1.time_ and arg_653_1.time_ <= var_656_23 + arg_656_0 and not isNil(var_656_22) and arg_653_1.var_.characterEffect1033ui_story == nil then
				arg_653_1.var_.characterEffect1033ui_story = var_656_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_656_24 = 0.200000002980232

			if var_656_23 <= arg_653_1.time_ and arg_653_1.time_ < var_656_23 + var_656_24 and not isNil(var_656_22) then
				local var_656_25 = (arg_653_1.time_ - var_656_23) / var_656_24

				if arg_653_1.var_.characterEffect1033ui_story and not isNil(var_656_22) then
					local var_656_26 = Mathf.Lerp(0, 0.5, var_656_25)

					arg_653_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_653_1.var_.characterEffect1033ui_story.fillRatio = var_656_26
				end
			end

			if arg_653_1.time_ >= var_656_23 + var_656_24 and arg_653_1.time_ < var_656_23 + var_656_24 + arg_656_0 and not isNil(var_656_22) and arg_653_1.var_.characterEffect1033ui_story then
				local var_656_27 = 0.5

				arg_653_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_653_1.var_.characterEffect1033ui_story.fillRatio = var_656_27
			end

			local var_656_28 = 0

			if var_656_28 < arg_653_1.time_ and arg_653_1.time_ <= var_656_28 + arg_656_0 then
				arg_653_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action1_1")
			end

			local var_656_29 = 0

			if var_656_29 < arg_653_1.time_ and arg_653_1.time_ <= var_656_29 + arg_656_0 then
				arg_653_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_656_30 = 0
			local var_656_31 = 0.3

			if var_656_30 < arg_653_1.time_ and arg_653_1.time_ <= var_656_30 + arg_656_0 then
				arg_653_1.talkMaxDuration = 0
				arg_653_1.dialogCg_.alpha = 1

				arg_653_1.dialog_:SetActive(true)
				SetActive(arg_653_1.leftNameGo_, true)

				local var_656_32 = arg_653_1:FormatText(StoryNameCfg[613].name)

				arg_653_1.leftNameTxt_.text = var_656_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_653_1.leftNameTxt_.transform)

				arg_653_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_653_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_653_1:RecordName(arg_653_1.leftNameTxt_.text)
				SetActive(arg_653_1.iconTrs_.gameObject, false)
				arg_653_1.callingController_:SetSelectedState("normal")

				local var_656_33 = arg_653_1:GetWordFromCfg(924011157)
				local var_656_34 = arg_653_1:FormatText(var_656_33.content)

				arg_653_1.text_.text = var_656_34

				LuaForUtil.ClearLinePrefixSymbol(arg_653_1.text_)

				local var_656_35 = 12
				local var_656_36 = utf8.len(var_656_34)
				local var_656_37 = var_656_35 <= 0 and var_656_31 or var_656_31 * (var_656_36 / var_656_35)

				if var_656_37 > 0 and var_656_31 < var_656_37 then
					arg_653_1.talkMaxDuration = var_656_37

					if var_656_37 + var_656_30 > arg_653_1.duration_ then
						arg_653_1.duration_ = var_656_37 + var_656_30
					end
				end

				arg_653_1.text_.text = var_656_34
				arg_653_1.typewritter.percent = 0

				arg_653_1.typewritter:SetDirty()
				arg_653_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011157", "story_v_side_old_924011.awb") ~= 0 then
					local var_656_38 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011157", "story_v_side_old_924011.awb") / 1000

					if var_656_38 + var_656_30 > arg_653_1.duration_ then
						arg_653_1.duration_ = var_656_38 + var_656_30
					end

					if var_656_33.prefab_name ~= "" and arg_653_1.actors_[var_656_33.prefab_name] ~= nil then
						local var_656_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_653_1.actors_[var_656_33.prefab_name].transform, "story_v_side_old_924011", "924011157", "story_v_side_old_924011.awb")

						arg_653_1:RecordAudio("924011157", var_656_39)
						arg_653_1:RecordAudio("924011157", var_656_39)
					else
						arg_653_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011157", "story_v_side_old_924011.awb")
					end

					arg_653_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011157", "story_v_side_old_924011.awb")
				end

				arg_653_1:RecordContent(arg_653_1.text_.text)
			end

			local var_656_40 = math.max(var_656_31, arg_653_1.talkMaxDuration)

			if var_656_30 <= arg_653_1.time_ and arg_653_1.time_ < var_656_30 + var_656_40 then
				arg_653_1.typewritter.percent = (arg_653_1.time_ - var_656_30) / var_656_40

				arg_653_1.typewritter:SetDirty()
			end

			if arg_653_1.time_ >= var_656_30 + var_656_40 and arg_653_1.time_ < var_656_30 + var_656_40 + arg_656_0 then
				arg_653_1.typewritter.percent = 1

				arg_653_1.typewritter:SetDirty()
				arg_653_1:ShowNextGo(true)
			end
		end

		arg_653_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_653_1:InitPlayNodeList()
	end,
	Play924011158 = function(arg_657_0, arg_657_1)
		arg_657_1.time_ = 0
		arg_657_1.frameCnt_ = 0
		arg_657_1.state_ = "playing"
		arg_657_1.curTalkId_ = 924011158
		arg_657_1.duration_ = 5.4

		local var_657_0 = {
			zh = 2.733,
			ja = 5.4
		}
		local var_657_1 = manager.audio:GetLocalizationFlag()

		if var_657_0[var_657_1] ~= nil then
			arg_657_1.duration_ = var_657_0[var_657_1]
		end

		SetActive(arg_657_1.tipsGo_, false)

		function arg_657_1.onSingleLineFinish_()
			arg_657_1.onSingleLineUpdate_ = nil
			arg_657_1.onSingleLineFinish_ = nil
			arg_657_1.state_ = "waiting"
		end

		function arg_657_1.playNext_(arg_659_0)
			if arg_659_0 == 1 then
				arg_657_0:Play924011159(arg_657_1)
			end
		end

		function arg_657_1.onSingleLineUpdate_(arg_660_0)
			local var_660_0 = arg_657_1.actors_["1033ui_story"].transform
			local var_660_1 = 0

			if var_660_1 < arg_657_1.time_ and arg_657_1.time_ <= var_660_1 + arg_660_0 then
				arg_657_1.var_.moveOldPos1033ui_story = var_660_0.localPosition
			end

			local var_660_2 = 0.001

			if var_660_1 <= arg_657_1.time_ and arg_657_1.time_ < var_660_1 + var_660_2 then
				local var_660_3 = (arg_657_1.time_ - var_660_1) / var_660_2
				local var_660_4 = Vector3.New(-0.7, -1.01, -6.13)

				var_660_0.localPosition = Vector3.Lerp(arg_657_1.var_.moveOldPos1033ui_story, var_660_4, var_660_3)

				local var_660_5 = manager.ui.mainCamera.transform.position - var_660_0.position

				var_660_0.forward = Vector3.New(var_660_5.x, var_660_5.y, var_660_5.z)

				local var_660_6 = var_660_0.localEulerAngles

				var_660_6.z = 0
				var_660_6.x = 0
				var_660_0.localEulerAngles = var_660_6
			end

			if arg_657_1.time_ >= var_660_1 + var_660_2 and arg_657_1.time_ < var_660_1 + var_660_2 + arg_660_0 then
				var_660_0.localPosition = Vector3.New(-0.7, -1.01, -6.13)

				local var_660_7 = manager.ui.mainCamera.transform.position - var_660_0.position

				var_660_0.forward = Vector3.New(var_660_7.x, var_660_7.y, var_660_7.z)

				local var_660_8 = var_660_0.localEulerAngles

				var_660_8.z = 0
				var_660_8.x = 0
				var_660_0.localEulerAngles = var_660_8
			end

			local var_660_9 = arg_657_1.actors_["1033ui_story"]
			local var_660_10 = 0

			if var_660_10 < arg_657_1.time_ and arg_657_1.time_ <= var_660_10 + arg_660_0 and not isNil(var_660_9) and arg_657_1.var_.characterEffect1033ui_story == nil then
				arg_657_1.var_.characterEffect1033ui_story = var_660_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_660_11 = 0.200000002980232

			if var_660_10 <= arg_657_1.time_ and arg_657_1.time_ < var_660_10 + var_660_11 and not isNil(var_660_9) then
				local var_660_12 = (arg_657_1.time_ - var_660_10) / var_660_11

				if arg_657_1.var_.characterEffect1033ui_story and not isNil(var_660_9) then
					arg_657_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_657_1.time_ >= var_660_10 + var_660_11 and arg_657_1.time_ < var_660_10 + var_660_11 + arg_660_0 and not isNil(var_660_9) and arg_657_1.var_.characterEffect1033ui_story then
				arg_657_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_660_13 = arg_657_1.actors_["1020ui_story"]
			local var_660_14 = 0

			if var_660_14 < arg_657_1.time_ and arg_657_1.time_ <= var_660_14 + arg_660_0 and not isNil(var_660_13) and arg_657_1.var_.characterEffect1020ui_story == nil then
				arg_657_1.var_.characterEffect1020ui_story = var_660_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_660_15 = 0.200000002980232

			if var_660_14 <= arg_657_1.time_ and arg_657_1.time_ < var_660_14 + var_660_15 and not isNil(var_660_13) then
				local var_660_16 = (arg_657_1.time_ - var_660_14) / var_660_15

				if arg_657_1.var_.characterEffect1020ui_story and not isNil(var_660_13) then
					local var_660_17 = Mathf.Lerp(0, 0.5, var_660_16)

					arg_657_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_657_1.var_.characterEffect1020ui_story.fillRatio = var_660_17
				end
			end

			if arg_657_1.time_ >= var_660_14 + var_660_15 and arg_657_1.time_ < var_660_14 + var_660_15 + arg_660_0 and not isNil(var_660_13) and arg_657_1.var_.characterEffect1020ui_story then
				local var_660_18 = 0.5

				arg_657_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_657_1.var_.characterEffect1020ui_story.fillRatio = var_660_18
			end

			local var_660_19 = 0

			if var_660_19 < arg_657_1.time_ and arg_657_1.time_ <= var_660_19 + arg_660_0 then
				arg_657_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033actionlink/1033action434")
			end

			local var_660_20 = 0

			if var_660_20 < arg_657_1.time_ and arg_657_1.time_ <= var_660_20 + arg_660_0 then
				arg_657_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_660_21 = 0
			local var_660_22 = 0.225

			if var_660_21 < arg_657_1.time_ and arg_657_1.time_ <= var_660_21 + arg_660_0 then
				arg_657_1.talkMaxDuration = 0
				arg_657_1.dialogCg_.alpha = 1

				arg_657_1.dialog_:SetActive(true)
				SetActive(arg_657_1.leftNameGo_, true)

				local var_660_23 = arg_657_1:FormatText(StoryNameCfg[236].name)

				arg_657_1.leftNameTxt_.text = var_660_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_657_1.leftNameTxt_.transform)

				arg_657_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_657_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_657_1:RecordName(arg_657_1.leftNameTxt_.text)
				SetActive(arg_657_1.iconTrs_.gameObject, false)
				arg_657_1.callingController_:SetSelectedState("normal")

				local var_660_24 = arg_657_1:GetWordFromCfg(924011158)
				local var_660_25 = arg_657_1:FormatText(var_660_24.content)

				arg_657_1.text_.text = var_660_25

				LuaForUtil.ClearLinePrefixSymbol(arg_657_1.text_)

				local var_660_26 = 9
				local var_660_27 = utf8.len(var_660_25)
				local var_660_28 = var_660_26 <= 0 and var_660_22 or var_660_22 * (var_660_27 / var_660_26)

				if var_660_28 > 0 and var_660_22 < var_660_28 then
					arg_657_1.talkMaxDuration = var_660_28

					if var_660_28 + var_660_21 > arg_657_1.duration_ then
						arg_657_1.duration_ = var_660_28 + var_660_21
					end
				end

				arg_657_1.text_.text = var_660_25
				arg_657_1.typewritter.percent = 0

				arg_657_1.typewritter:SetDirty()
				arg_657_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011158", "story_v_side_old_924011.awb") ~= 0 then
					local var_660_29 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011158", "story_v_side_old_924011.awb") / 1000

					if var_660_29 + var_660_21 > arg_657_1.duration_ then
						arg_657_1.duration_ = var_660_29 + var_660_21
					end

					if var_660_24.prefab_name ~= "" and arg_657_1.actors_[var_660_24.prefab_name] ~= nil then
						local var_660_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_657_1.actors_[var_660_24.prefab_name].transform, "story_v_side_old_924011", "924011158", "story_v_side_old_924011.awb")

						arg_657_1:RecordAudio("924011158", var_660_30)
						arg_657_1:RecordAudio("924011158", var_660_30)
					else
						arg_657_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011158", "story_v_side_old_924011.awb")
					end

					arg_657_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011158", "story_v_side_old_924011.awb")
				end

				arg_657_1:RecordContent(arg_657_1.text_.text)
			end

			local var_660_31 = math.max(var_660_22, arg_657_1.talkMaxDuration)

			if var_660_21 <= arg_657_1.time_ and arg_657_1.time_ < var_660_21 + var_660_31 then
				arg_657_1.typewritter.percent = (arg_657_1.time_ - var_660_21) / var_660_31

				arg_657_1.typewritter:SetDirty()
			end

			if arg_657_1.time_ >= var_660_21 + var_660_31 and arg_657_1.time_ < var_660_21 + var_660_31 + arg_660_0 then
				arg_657_1.typewritter.percent = 1

				arg_657_1.typewritter:SetDirty()
				arg_657_1:ShowNextGo(true)
			end
		end

		arg_657_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_657_1:InitPlayNodeList()
	end,
	Play924011159 = function(arg_661_0, arg_661_1)
		arg_661_1.time_ = 0
		arg_661_1.frameCnt_ = 0
		arg_661_1.state_ = "playing"
		arg_661_1.curTalkId_ = 924011159
		arg_661_1.duration_ = 9

		SetActive(arg_661_1.tipsGo_, false)

		function arg_661_1.onSingleLineFinish_()
			arg_661_1.onSingleLineUpdate_ = nil
			arg_661_1.onSingleLineFinish_ = nil
			arg_661_1.state_ = "waiting"
		end

		function arg_661_1.playNext_(arg_663_0)
			if arg_663_0 == 1 then
				arg_661_0:Play924011160(arg_661_1)
			end
		end

		function arg_661_1.onSingleLineUpdate_(arg_664_0)
			local var_664_0 = 2

			if var_664_0 < arg_661_1.time_ and arg_661_1.time_ <= var_664_0 + arg_664_0 then
				local var_664_1 = manager.ui.mainCamera.transform.localPosition
				local var_664_2 = Vector3.New(0, 0, 10) + Vector3.New(var_664_1.x, var_664_1.y, 0)
				local var_664_3 = arg_661_1.bgs_.ST2201

				var_664_3.transform.localPosition = var_664_2
				var_664_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_664_4 = var_664_3:GetComponent("SpriteRenderer")

				if var_664_4 and var_664_4.sprite then
					local var_664_5 = (var_664_3.transform.localPosition - var_664_1).z
					local var_664_6 = manager.ui.mainCameraCom_
					local var_664_7 = 2 * var_664_5 * Mathf.Tan(var_664_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_664_8 = var_664_7 * var_664_6.aspect
					local var_664_9 = var_664_4.sprite.bounds.size.x
					local var_664_10 = var_664_4.sprite.bounds.size.y
					local var_664_11 = var_664_8 / var_664_9
					local var_664_12 = var_664_7 / var_664_10
					local var_664_13 = var_664_12 < var_664_11 and var_664_11 or var_664_12

					var_664_3.transform.localScale = Vector3.New(var_664_13, var_664_13, 0)
				end

				for iter_664_0, iter_664_1 in pairs(arg_661_1.bgs_) do
					if iter_664_0 ~= "ST2201" then
						iter_664_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_664_14 = 3.999999999999

			if var_664_14 < arg_661_1.time_ and arg_661_1.time_ <= var_664_14 + arg_664_0 then
				arg_661_1.allBtn_.enabled = false
			end

			local var_664_15 = 0.3

			if arg_661_1.time_ >= var_664_14 + var_664_15 and arg_661_1.time_ < var_664_14 + var_664_15 + arg_664_0 then
				arg_661_1.allBtn_.enabled = true
			end

			local var_664_16 = 0

			if var_664_16 < arg_661_1.time_ and arg_661_1.time_ <= var_664_16 + arg_664_0 then
				arg_661_1.mask_.enabled = true
				arg_661_1.mask_.raycastTarget = true

				arg_661_1:SetGaussion(false)
			end

			local var_664_17 = 2

			if var_664_16 <= arg_661_1.time_ and arg_661_1.time_ < var_664_16 + var_664_17 then
				local var_664_18 = (arg_661_1.time_ - var_664_16) / var_664_17
				local var_664_19 = Color.New(0, 0, 0)

				var_664_19.a = Mathf.Lerp(0, 1, var_664_18)
				arg_661_1.mask_.color = var_664_19
			end

			if arg_661_1.time_ >= var_664_16 + var_664_17 and arg_661_1.time_ < var_664_16 + var_664_17 + arg_664_0 then
				local var_664_20 = Color.New(0, 0, 0)

				var_664_20.a = 1
				arg_661_1.mask_.color = var_664_20
			end

			local var_664_21 = 2

			if var_664_21 < arg_661_1.time_ and arg_661_1.time_ <= var_664_21 + arg_664_0 then
				arg_661_1.mask_.enabled = true
				arg_661_1.mask_.raycastTarget = true

				arg_661_1:SetGaussion(false)
			end

			local var_664_22 = 2

			if var_664_21 <= arg_661_1.time_ and arg_661_1.time_ < var_664_21 + var_664_22 then
				local var_664_23 = (arg_661_1.time_ - var_664_21) / var_664_22
				local var_664_24 = Color.New(0, 0, 0)

				var_664_24.a = Mathf.Lerp(1, 0, var_664_23)
				arg_661_1.mask_.color = var_664_24
			end

			if arg_661_1.time_ >= var_664_21 + var_664_22 and arg_661_1.time_ < var_664_21 + var_664_22 + arg_664_0 then
				local var_664_25 = Color.New(0, 0, 0)
				local var_664_26 = 0

				arg_661_1.mask_.enabled = false
				var_664_25.a = var_664_26
				arg_661_1.mask_.color = var_664_25
			end

			local var_664_27 = arg_661_1.actors_["1033ui_story"].transform
			local var_664_28 = 1.96599999815226

			if var_664_28 < arg_661_1.time_ and arg_661_1.time_ <= var_664_28 + arg_664_0 then
				arg_661_1.var_.moveOldPos1033ui_story = var_664_27.localPosition
			end

			local var_664_29 = 0.001

			if var_664_28 <= arg_661_1.time_ and arg_661_1.time_ < var_664_28 + var_664_29 then
				local var_664_30 = (arg_661_1.time_ - var_664_28) / var_664_29
				local var_664_31 = Vector3.New(0, 100, 0)

				var_664_27.localPosition = Vector3.Lerp(arg_661_1.var_.moveOldPos1033ui_story, var_664_31, var_664_30)

				local var_664_32 = manager.ui.mainCamera.transform.position - var_664_27.position

				var_664_27.forward = Vector3.New(var_664_32.x, var_664_32.y, var_664_32.z)

				local var_664_33 = var_664_27.localEulerAngles

				var_664_33.z = 0
				var_664_33.x = 0
				var_664_27.localEulerAngles = var_664_33
			end

			if arg_661_1.time_ >= var_664_28 + var_664_29 and arg_661_1.time_ < var_664_28 + var_664_29 + arg_664_0 then
				var_664_27.localPosition = Vector3.New(0, 100, 0)

				local var_664_34 = manager.ui.mainCamera.transform.position - var_664_27.position

				var_664_27.forward = Vector3.New(var_664_34.x, var_664_34.y, var_664_34.z)

				local var_664_35 = var_664_27.localEulerAngles

				var_664_35.z = 0
				var_664_35.x = 0
				var_664_27.localEulerAngles = var_664_35
			end

			local var_664_36 = arg_661_1.actors_["1020ui_story"].transform
			local var_664_37 = 1.96599999815226

			if var_664_37 < arg_661_1.time_ and arg_661_1.time_ <= var_664_37 + arg_664_0 then
				arg_661_1.var_.moveOldPos1020ui_story = var_664_36.localPosition
			end

			local var_664_38 = 0.001

			if var_664_37 <= arg_661_1.time_ and arg_661_1.time_ < var_664_37 + var_664_38 then
				local var_664_39 = (arg_661_1.time_ - var_664_37) / var_664_38
				local var_664_40 = Vector3.New(0, 100, 0)

				var_664_36.localPosition = Vector3.Lerp(arg_661_1.var_.moveOldPos1020ui_story, var_664_40, var_664_39)

				local var_664_41 = manager.ui.mainCamera.transform.position - var_664_36.position

				var_664_36.forward = Vector3.New(var_664_41.x, var_664_41.y, var_664_41.z)

				local var_664_42 = var_664_36.localEulerAngles

				var_664_42.z = 0
				var_664_42.x = 0
				var_664_36.localEulerAngles = var_664_42
			end

			if arg_661_1.time_ >= var_664_37 + var_664_38 and arg_661_1.time_ < var_664_37 + var_664_38 + arg_664_0 then
				var_664_36.localPosition = Vector3.New(0, 100, 0)

				local var_664_43 = manager.ui.mainCamera.transform.position - var_664_36.position

				var_664_36.forward = Vector3.New(var_664_43.x, var_664_43.y, var_664_43.z)

				local var_664_44 = var_664_36.localEulerAngles

				var_664_44.z = 0
				var_664_44.x = 0
				var_664_36.localEulerAngles = var_664_44
			end

			local var_664_45 = arg_661_1.actors_["1033ui_story"]
			local var_664_46 = 1.96599999815226

			if var_664_46 < arg_661_1.time_ and arg_661_1.time_ <= var_664_46 + arg_664_0 and not isNil(var_664_45) and arg_661_1.var_.characterEffect1033ui_story == nil then
				arg_661_1.var_.characterEffect1033ui_story = var_664_45:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_664_47 = 0.034000001847744

			if var_664_46 <= arg_661_1.time_ and arg_661_1.time_ < var_664_46 + var_664_47 and not isNil(var_664_45) then
				local var_664_48 = (arg_661_1.time_ - var_664_46) / var_664_47

				if arg_661_1.var_.characterEffect1033ui_story and not isNil(var_664_45) then
					local var_664_49 = Mathf.Lerp(0, 0.5, var_664_48)

					arg_661_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_661_1.var_.characterEffect1033ui_story.fillRatio = var_664_49
				end
			end

			if arg_661_1.time_ >= var_664_46 + var_664_47 and arg_661_1.time_ < var_664_46 + var_664_47 + arg_664_0 and not isNil(var_664_45) and arg_661_1.var_.characterEffect1033ui_story then
				local var_664_50 = 0.5

				arg_661_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_661_1.var_.characterEffect1033ui_story.fillRatio = var_664_50
			end

			local var_664_51 = arg_661_1.actors_["1033ui_story"]
			local var_664_52 = 1.96599999815226

			if var_664_52 < arg_661_1.time_ and arg_661_1.time_ <= var_664_52 + arg_664_0 then
				if arg_661_1.var_.characterEffect1033ui_story == nil then
					arg_661_1.var_.characterEffect1033ui_story = var_664_51:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_664_53 = arg_661_1.var_.characterEffect1033ui_story

				var_664_53.imageEffect:turnOff()

				var_664_53.interferenceEffect.enabled = false
				var_664_53.interferenceEffect.noise = 0.001
				var_664_53.interferenceEffect.simTimeScale = 1
				var_664_53.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_664_54 = arg_661_1.actors_["1033ui_story"]
			local var_664_55 = 1.96599999815226
			local var_664_56 = 0.034000001847744

			if var_664_55 < arg_661_1.time_ and arg_661_1.time_ <= var_664_55 + arg_664_0 then
				if arg_661_1.var_.characterEffect1033ui_story == nil then
					arg_661_1.var_.characterEffect1033ui_story = var_664_54:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_661_1.var_.characterEffect1033ui_story.imageEffect:turnOff()
			end

			local var_664_57 = 1.63333333333333
			local var_664_58 = 1

			if var_664_57 < arg_661_1.time_ and arg_661_1.time_ <= var_664_57 + arg_664_0 then
				local var_664_59 = "play"
				local var_664_60 = "effect"

				arg_661_1:AudioAction(var_664_59, var_664_60, "se_story_140", "se_story_140_amb_lab", "")
			end

			local var_664_61 = 0.125
			local var_664_62 = 1

			if var_664_61 < arg_661_1.time_ and arg_661_1.time_ <= var_664_61 + arg_664_0 then
				local var_664_63 = "stop"
				local var_664_64 = "effect"

				arg_661_1:AudioAction(var_664_63, var_664_64, "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			if arg_661_1.frameCnt_ <= 1 then
				arg_661_1.dialog_:SetActive(false)
			end

			local var_664_65 = 3.999999999999
			local var_664_66 = 0.875

			if var_664_65 < arg_661_1.time_ and arg_661_1.time_ <= var_664_65 + arg_664_0 then
				arg_661_1.talkMaxDuration = 0

				arg_661_1.dialog_:SetActive(true)

				arg_661_1.dialogCg_.alpha = 0

				local var_664_67 = LeanTween.value(arg_661_1.dialog_, 0, 1, 0.3)

				var_664_67:setOnUpdate(LuaHelper.FloatAction(function(arg_665_0)
					arg_661_1.dialogCg_.alpha = arg_665_0
				end))
				var_664_67:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_661_1.dialog_)
					var_664_67:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_661_1.duration_ = arg_661_1.duration_ + 0.3

				SetActive(arg_661_1.leftNameGo_, false)

				arg_661_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_661_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_661_1:RecordName(arg_661_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_661_1.iconTrs_.gameObject, false)
				arg_661_1.callingController_:SetSelectedState("normal")

				local var_664_68 = arg_661_1:GetWordFromCfg(924011159)
				local var_664_69 = arg_661_1:FormatText(var_664_68.content)

				arg_661_1.text_.text = var_664_69

				LuaForUtil.ClearLinePrefixSymbol(arg_661_1.text_)

				local var_664_70 = 35
				local var_664_71 = utf8.len(var_664_69)
				local var_664_72 = var_664_70 <= 0 and var_664_66 or var_664_66 * (var_664_71 / var_664_70)

				if var_664_72 > 0 and var_664_66 < var_664_72 then
					arg_661_1.talkMaxDuration = var_664_72
					var_664_65 = var_664_65 + 0.3

					if var_664_72 + var_664_65 > arg_661_1.duration_ then
						arg_661_1.duration_ = var_664_72 + var_664_65
					end
				end

				arg_661_1.text_.text = var_664_69
				arg_661_1.typewritter.percent = 0

				arg_661_1.typewritter:SetDirty()
				arg_661_1:ShowNextGo(false)
				arg_661_1:RecordContent(arg_661_1.text_.text)
			end

			local var_664_73 = var_664_65 + 0.3
			local var_664_74 = math.max(var_664_66, arg_661_1.talkMaxDuration)

			if var_664_73 <= arg_661_1.time_ and arg_661_1.time_ < var_664_73 + var_664_74 then
				arg_661_1.typewritter.percent = (arg_661_1.time_ - var_664_73) / var_664_74

				arg_661_1.typewritter:SetDirty()
			end

			if arg_661_1.time_ >= var_664_73 + var_664_74 and arg_661_1.time_ < var_664_73 + var_664_74 + arg_664_0 then
				arg_661_1.typewritter.percent = 1

				arg_661_1.typewritter:SetDirty()
				arg_661_1:ShowNextGo(true)
			end
		end

		arg_661_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_661_1:InitPlayNodeList()
	end,
	Play924011160 = function(arg_667_0, arg_667_1)
		arg_667_1.time_ = 0
		arg_667_1.frameCnt_ = 0
		arg_667_1.state_ = "playing"
		arg_667_1.curTalkId_ = 924011160
		arg_667_1.duration_ = 5

		SetActive(arg_667_1.tipsGo_, false)

		function arg_667_1.onSingleLineFinish_()
			arg_667_1.onSingleLineUpdate_ = nil
			arg_667_1.onSingleLineFinish_ = nil
			arg_667_1.state_ = "waiting"
		end

		function arg_667_1.playNext_(arg_669_0)
			if arg_669_0 == 1 then
				arg_667_0:Play924011161(arg_667_1)
			end
		end

		function arg_667_1.onSingleLineUpdate_(arg_670_0)
			local var_670_0 = 0
			local var_670_1 = 0.4

			if var_670_0 < arg_667_1.time_ and arg_667_1.time_ <= var_670_0 + arg_670_0 then
				arg_667_1.talkMaxDuration = 0
				arg_667_1.dialogCg_.alpha = 1

				arg_667_1.dialog_:SetActive(true)
				SetActive(arg_667_1.leftNameGo_, true)

				local var_670_2 = arg_667_1:FormatText(StoryNameCfg[7].name)

				arg_667_1.leftNameTxt_.text = var_670_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_667_1.leftNameTxt_.transform)

				arg_667_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_667_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_667_1:RecordName(arg_667_1.leftNameTxt_.text)
				SetActive(arg_667_1.iconTrs_.gameObject, true)
				arg_667_1.iconController_:SetSelectedState("hero")

				arg_667_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_667_1.callingController_:SetSelectedState("normal")

				arg_667_1.keyicon_.color = Color.New(1, 1, 1)
				arg_667_1.icon_.color = Color.New(1, 1, 1)

				local var_670_3 = arg_667_1:GetWordFromCfg(924011160)
				local var_670_4 = arg_667_1:FormatText(var_670_3.content)

				arg_667_1.text_.text = var_670_4

				LuaForUtil.ClearLinePrefixSymbol(arg_667_1.text_)

				local var_670_5 = 16
				local var_670_6 = utf8.len(var_670_4)
				local var_670_7 = var_670_5 <= 0 and var_670_1 or var_670_1 * (var_670_6 / var_670_5)

				if var_670_7 > 0 and var_670_1 < var_670_7 then
					arg_667_1.talkMaxDuration = var_670_7

					if var_670_7 + var_670_0 > arg_667_1.duration_ then
						arg_667_1.duration_ = var_670_7 + var_670_0
					end
				end

				arg_667_1.text_.text = var_670_4
				arg_667_1.typewritter.percent = 0

				arg_667_1.typewritter:SetDirty()
				arg_667_1:ShowNextGo(false)
				arg_667_1:RecordContent(arg_667_1.text_.text)
			end

			local var_670_8 = math.max(var_670_1, arg_667_1.talkMaxDuration)

			if var_670_0 <= arg_667_1.time_ and arg_667_1.time_ < var_670_0 + var_670_8 then
				arg_667_1.typewritter.percent = (arg_667_1.time_ - var_670_0) / var_670_8

				arg_667_1.typewritter:SetDirty()
			end

			if arg_667_1.time_ >= var_670_0 + var_670_8 and arg_667_1.time_ < var_670_0 + var_670_8 + arg_670_0 then
				arg_667_1.typewritter.percent = 1

				arg_667_1.typewritter:SetDirty()
				arg_667_1:ShowNextGo(true)
			end
		end

		arg_667_1.nodeConfigList_ = {}

		arg_667_1:InitPlayNodeList()
	end,
	Play924011161 = function(arg_671_0, arg_671_1)
		arg_671_1.time_ = 0
		arg_671_1.frameCnt_ = 0
		arg_671_1.state_ = "playing"
		arg_671_1.curTalkId_ = 924011161
		arg_671_1.duration_ = 7.67

		local var_671_0 = {
			zh = 3.2,
			ja = 7.666
		}
		local var_671_1 = manager.audio:GetLocalizationFlag()

		if var_671_0[var_671_1] ~= nil then
			arg_671_1.duration_ = var_671_0[var_671_1]
		end

		SetActive(arg_671_1.tipsGo_, false)

		function arg_671_1.onSingleLineFinish_()
			arg_671_1.onSingleLineUpdate_ = nil
			arg_671_1.onSingleLineFinish_ = nil
			arg_671_1.state_ = "waiting"
		end

		function arg_671_1.playNext_(arg_673_0)
			if arg_673_0 == 1 then
				arg_671_0:Play924011162(arg_671_1)
			end
		end

		function arg_671_1.onSingleLineUpdate_(arg_674_0)
			local var_674_0 = arg_671_1.actors_["1033ui_story"].transform
			local var_674_1 = 0

			if var_674_1 < arg_671_1.time_ and arg_671_1.time_ <= var_674_1 + arg_674_0 then
				arg_671_1.var_.moveOldPos1033ui_story = var_674_0.localPosition
			end

			local var_674_2 = 0.001

			if var_674_1 <= arg_671_1.time_ and arg_671_1.time_ < var_674_1 + var_674_2 then
				local var_674_3 = (arg_671_1.time_ - var_674_1) / var_674_2
				local var_674_4 = Vector3.New(0, -1.01, -6.13)

				var_674_0.localPosition = Vector3.Lerp(arg_671_1.var_.moveOldPos1033ui_story, var_674_4, var_674_3)

				local var_674_5 = manager.ui.mainCamera.transform.position - var_674_0.position

				var_674_0.forward = Vector3.New(var_674_5.x, var_674_5.y, var_674_5.z)

				local var_674_6 = var_674_0.localEulerAngles

				var_674_6.z = 0
				var_674_6.x = 0
				var_674_0.localEulerAngles = var_674_6
			end

			if arg_671_1.time_ >= var_674_1 + var_674_2 and arg_671_1.time_ < var_674_1 + var_674_2 + arg_674_0 then
				var_674_0.localPosition = Vector3.New(0, -1.01, -6.13)

				local var_674_7 = manager.ui.mainCamera.transform.position - var_674_0.position

				var_674_0.forward = Vector3.New(var_674_7.x, var_674_7.y, var_674_7.z)

				local var_674_8 = var_674_0.localEulerAngles

				var_674_8.z = 0
				var_674_8.x = 0
				var_674_0.localEulerAngles = var_674_8
			end

			local var_674_9 = arg_671_1.actors_["1033ui_story"]
			local var_674_10 = 0

			if var_674_10 < arg_671_1.time_ and arg_671_1.time_ <= var_674_10 + arg_674_0 and not isNil(var_674_9) and arg_671_1.var_.characterEffect1033ui_story == nil then
				arg_671_1.var_.characterEffect1033ui_story = var_674_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_674_11 = 0.200000002980232

			if var_674_10 <= arg_671_1.time_ and arg_671_1.time_ < var_674_10 + var_674_11 and not isNil(var_674_9) then
				local var_674_12 = (arg_671_1.time_ - var_674_10) / var_674_11

				if arg_671_1.var_.characterEffect1033ui_story and not isNil(var_674_9) then
					arg_671_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_671_1.time_ >= var_674_10 + var_674_11 and arg_671_1.time_ < var_674_10 + var_674_11 + arg_674_0 and not isNil(var_674_9) and arg_671_1.var_.characterEffect1033ui_story then
				arg_671_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_674_13 = 0

			if var_674_13 < arg_671_1.time_ and arg_671_1.time_ <= var_674_13 + arg_674_0 then
				arg_671_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action2_1")
			end

			local var_674_14 = 0

			if var_674_14 < arg_671_1.time_ and arg_671_1.time_ <= var_674_14 + arg_674_0 then
				arg_671_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_674_15 = 0
			local var_674_16 = 0.35

			if var_674_15 < arg_671_1.time_ and arg_671_1.time_ <= var_674_15 + arg_674_0 then
				arg_671_1.talkMaxDuration = 0
				arg_671_1.dialogCg_.alpha = 1

				arg_671_1.dialog_:SetActive(true)
				SetActive(arg_671_1.leftNameGo_, true)

				local var_674_17 = arg_671_1:FormatText(StoryNameCfg[236].name)

				arg_671_1.leftNameTxt_.text = var_674_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_671_1.leftNameTxt_.transform)

				arg_671_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_671_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_671_1:RecordName(arg_671_1.leftNameTxt_.text)
				SetActive(arg_671_1.iconTrs_.gameObject, false)
				arg_671_1.callingController_:SetSelectedState("normal")

				local var_674_18 = arg_671_1:GetWordFromCfg(924011161)
				local var_674_19 = arg_671_1:FormatText(var_674_18.content)

				arg_671_1.text_.text = var_674_19

				LuaForUtil.ClearLinePrefixSymbol(arg_671_1.text_)

				local var_674_20 = 14
				local var_674_21 = utf8.len(var_674_19)
				local var_674_22 = var_674_20 <= 0 and var_674_16 or var_674_16 * (var_674_21 / var_674_20)

				if var_674_22 > 0 and var_674_16 < var_674_22 then
					arg_671_1.talkMaxDuration = var_674_22

					if var_674_22 + var_674_15 > arg_671_1.duration_ then
						arg_671_1.duration_ = var_674_22 + var_674_15
					end
				end

				arg_671_1.text_.text = var_674_19
				arg_671_1.typewritter.percent = 0

				arg_671_1.typewritter:SetDirty()
				arg_671_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011161", "story_v_side_old_924011.awb") ~= 0 then
					local var_674_23 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011161", "story_v_side_old_924011.awb") / 1000

					if var_674_23 + var_674_15 > arg_671_1.duration_ then
						arg_671_1.duration_ = var_674_23 + var_674_15
					end

					if var_674_18.prefab_name ~= "" and arg_671_1.actors_[var_674_18.prefab_name] ~= nil then
						local var_674_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_671_1.actors_[var_674_18.prefab_name].transform, "story_v_side_old_924011", "924011161", "story_v_side_old_924011.awb")

						arg_671_1:RecordAudio("924011161", var_674_24)
						arg_671_1:RecordAudio("924011161", var_674_24)
					else
						arg_671_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011161", "story_v_side_old_924011.awb")
					end

					arg_671_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011161", "story_v_side_old_924011.awb")
				end

				arg_671_1:RecordContent(arg_671_1.text_.text)
			end

			local var_674_25 = math.max(var_674_16, arg_671_1.talkMaxDuration)

			if var_674_15 <= arg_671_1.time_ and arg_671_1.time_ < var_674_15 + var_674_25 then
				arg_671_1.typewritter.percent = (arg_671_1.time_ - var_674_15) / var_674_25

				arg_671_1.typewritter:SetDirty()
			end

			if arg_671_1.time_ >= var_674_15 + var_674_25 and arg_671_1.time_ < var_674_15 + var_674_25 + arg_674_0 then
				arg_671_1.typewritter.percent = 1

				arg_671_1.typewritter:SetDirty()
				arg_671_1:ShowNextGo(true)
			end
		end

		arg_671_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_671_1:InitPlayNodeList()
	end,
	Play924011162 = function(arg_675_0, arg_675_1)
		arg_675_1.time_ = 0
		arg_675_1.frameCnt_ = 0
		arg_675_1.state_ = "playing"
		arg_675_1.curTalkId_ = 924011162
		arg_675_1.duration_ = 5

		SetActive(arg_675_1.tipsGo_, false)

		function arg_675_1.onSingleLineFinish_()
			arg_675_1.onSingleLineUpdate_ = nil
			arg_675_1.onSingleLineFinish_ = nil
			arg_675_1.state_ = "waiting"
		end

		function arg_675_1.playNext_(arg_677_0)
			if arg_677_0 == 1 then
				arg_675_0:Play924011163(arg_675_1)
			end
		end

		function arg_675_1.onSingleLineUpdate_(arg_678_0)
			local var_678_0 = arg_675_1.actors_["1033ui_story"]
			local var_678_1 = 0

			if var_678_1 < arg_675_1.time_ and arg_675_1.time_ <= var_678_1 + arg_678_0 and not isNil(var_678_0) and arg_675_1.var_.characterEffect1033ui_story == nil then
				arg_675_1.var_.characterEffect1033ui_story = var_678_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_678_2 = 0.200000002980232

			if var_678_1 <= arg_675_1.time_ and arg_675_1.time_ < var_678_1 + var_678_2 and not isNil(var_678_0) then
				local var_678_3 = (arg_675_1.time_ - var_678_1) / var_678_2

				if arg_675_1.var_.characterEffect1033ui_story and not isNil(var_678_0) then
					local var_678_4 = Mathf.Lerp(0, 0.5, var_678_3)

					arg_675_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_675_1.var_.characterEffect1033ui_story.fillRatio = var_678_4
				end
			end

			if arg_675_1.time_ >= var_678_1 + var_678_2 and arg_675_1.time_ < var_678_1 + var_678_2 + arg_678_0 and not isNil(var_678_0) and arg_675_1.var_.characterEffect1033ui_story then
				local var_678_5 = 0.5

				arg_675_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_675_1.var_.characterEffect1033ui_story.fillRatio = var_678_5
			end

			local var_678_6 = 0
			local var_678_7 = 0.125

			if var_678_6 < arg_675_1.time_ and arg_675_1.time_ <= var_678_6 + arg_678_0 then
				arg_675_1.talkMaxDuration = 0
				arg_675_1.dialogCg_.alpha = 1

				arg_675_1.dialog_:SetActive(true)
				SetActive(arg_675_1.leftNameGo_, true)

				local var_678_8 = arg_675_1:FormatText(StoryNameCfg[7].name)

				arg_675_1.leftNameTxt_.text = var_678_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_675_1.leftNameTxt_.transform)

				arg_675_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_675_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_675_1:RecordName(arg_675_1.leftNameTxt_.text)
				SetActive(arg_675_1.iconTrs_.gameObject, true)
				arg_675_1.iconController_:SetSelectedState("hero")

				arg_675_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_675_1.callingController_:SetSelectedState("normal")

				arg_675_1.keyicon_.color = Color.New(1, 1, 1)
				arg_675_1.icon_.color = Color.New(1, 1, 1)

				local var_678_9 = arg_675_1:GetWordFromCfg(924011162)
				local var_678_10 = arg_675_1:FormatText(var_678_9.content)

				arg_675_1.text_.text = var_678_10

				LuaForUtil.ClearLinePrefixSymbol(arg_675_1.text_)

				local var_678_11 = 5
				local var_678_12 = utf8.len(var_678_10)
				local var_678_13 = var_678_11 <= 0 and var_678_7 or var_678_7 * (var_678_12 / var_678_11)

				if var_678_13 > 0 and var_678_7 < var_678_13 then
					arg_675_1.talkMaxDuration = var_678_13

					if var_678_13 + var_678_6 > arg_675_1.duration_ then
						arg_675_1.duration_ = var_678_13 + var_678_6
					end
				end

				arg_675_1.text_.text = var_678_10
				arg_675_1.typewritter.percent = 0

				arg_675_1.typewritter:SetDirty()
				arg_675_1:ShowNextGo(false)
				arg_675_1:RecordContent(arg_675_1.text_.text)
			end

			local var_678_14 = math.max(var_678_7, arg_675_1.talkMaxDuration)

			if var_678_6 <= arg_675_1.time_ and arg_675_1.time_ < var_678_6 + var_678_14 then
				arg_675_1.typewritter.percent = (arg_675_1.time_ - var_678_6) / var_678_14

				arg_675_1.typewritter:SetDirty()
			end

			if arg_675_1.time_ >= var_678_6 + var_678_14 and arg_675_1.time_ < var_678_6 + var_678_14 + arg_678_0 then
				arg_675_1.typewritter.percent = 1

				arg_675_1.typewritter:SetDirty()
				arg_675_1:ShowNextGo(true)
			end
		end

		arg_675_1.nodeConfigList_ = {}

		arg_675_1:InitPlayNodeList()
	end,
	Play924011163 = function(arg_679_0, arg_679_1)
		arg_679_1.time_ = 0
		arg_679_1.frameCnt_ = 0
		arg_679_1.state_ = "playing"
		arg_679_1.curTalkId_ = 924011163
		arg_679_1.duration_ = 4.97

		local var_679_0 = {
			zh = 3.066,
			ja = 4.966
		}
		local var_679_1 = manager.audio:GetLocalizationFlag()

		if var_679_0[var_679_1] ~= nil then
			arg_679_1.duration_ = var_679_0[var_679_1]
		end

		SetActive(arg_679_1.tipsGo_, false)

		function arg_679_1.onSingleLineFinish_()
			arg_679_1.onSingleLineUpdate_ = nil
			arg_679_1.onSingleLineFinish_ = nil
			arg_679_1.state_ = "waiting"
		end

		function arg_679_1.playNext_(arg_681_0)
			if arg_681_0 == 1 then
				arg_679_0:Play924011164(arg_679_1)
			end
		end

		function arg_679_1.onSingleLineUpdate_(arg_682_0)
			local var_682_0 = arg_679_1.actors_["1033ui_story"]
			local var_682_1 = 0

			if var_682_1 < arg_679_1.time_ and arg_679_1.time_ <= var_682_1 + arg_682_0 and not isNil(var_682_0) and arg_679_1.var_.characterEffect1033ui_story == nil then
				arg_679_1.var_.characterEffect1033ui_story = var_682_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_682_2 = 0.200000002980232

			if var_682_1 <= arg_679_1.time_ and arg_679_1.time_ < var_682_1 + var_682_2 and not isNil(var_682_0) then
				local var_682_3 = (arg_679_1.time_ - var_682_1) / var_682_2

				if arg_679_1.var_.characterEffect1033ui_story and not isNil(var_682_0) then
					arg_679_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_679_1.time_ >= var_682_1 + var_682_2 and arg_679_1.time_ < var_682_1 + var_682_2 + arg_682_0 and not isNil(var_682_0) and arg_679_1.var_.characterEffect1033ui_story then
				arg_679_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_682_4 = 0

			if var_682_4 < arg_679_1.time_ and arg_679_1.time_ <= var_682_4 + arg_682_0 then
				arg_679_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_682_5 = 0
			local var_682_6 = 0.375

			if var_682_5 < arg_679_1.time_ and arg_679_1.time_ <= var_682_5 + arg_682_0 then
				arg_679_1.talkMaxDuration = 0
				arg_679_1.dialogCg_.alpha = 1

				arg_679_1.dialog_:SetActive(true)
				SetActive(arg_679_1.leftNameGo_, true)

				local var_682_7 = arg_679_1:FormatText(StoryNameCfg[236].name)

				arg_679_1.leftNameTxt_.text = var_682_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_679_1.leftNameTxt_.transform)

				arg_679_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_679_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_679_1:RecordName(arg_679_1.leftNameTxt_.text)
				SetActive(arg_679_1.iconTrs_.gameObject, false)
				arg_679_1.callingController_:SetSelectedState("normal")

				local var_682_8 = arg_679_1:GetWordFromCfg(924011163)
				local var_682_9 = arg_679_1:FormatText(var_682_8.content)

				arg_679_1.text_.text = var_682_9

				LuaForUtil.ClearLinePrefixSymbol(arg_679_1.text_)

				local var_682_10 = 15
				local var_682_11 = utf8.len(var_682_9)
				local var_682_12 = var_682_10 <= 0 and var_682_6 or var_682_6 * (var_682_11 / var_682_10)

				if var_682_12 > 0 and var_682_6 < var_682_12 then
					arg_679_1.talkMaxDuration = var_682_12

					if var_682_12 + var_682_5 > arg_679_1.duration_ then
						arg_679_1.duration_ = var_682_12 + var_682_5
					end
				end

				arg_679_1.text_.text = var_682_9
				arg_679_1.typewritter.percent = 0

				arg_679_1.typewritter:SetDirty()
				arg_679_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011163", "story_v_side_old_924011.awb") ~= 0 then
					local var_682_13 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011163", "story_v_side_old_924011.awb") / 1000

					if var_682_13 + var_682_5 > arg_679_1.duration_ then
						arg_679_1.duration_ = var_682_13 + var_682_5
					end

					if var_682_8.prefab_name ~= "" and arg_679_1.actors_[var_682_8.prefab_name] ~= nil then
						local var_682_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_679_1.actors_[var_682_8.prefab_name].transform, "story_v_side_old_924011", "924011163", "story_v_side_old_924011.awb")

						arg_679_1:RecordAudio("924011163", var_682_14)
						arg_679_1:RecordAudio("924011163", var_682_14)
					else
						arg_679_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011163", "story_v_side_old_924011.awb")
					end

					arg_679_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011163", "story_v_side_old_924011.awb")
				end

				arg_679_1:RecordContent(arg_679_1.text_.text)
			end

			local var_682_15 = math.max(var_682_6, arg_679_1.talkMaxDuration)

			if var_682_5 <= arg_679_1.time_ and arg_679_1.time_ < var_682_5 + var_682_15 then
				arg_679_1.typewritter.percent = (arg_679_1.time_ - var_682_5) / var_682_15

				arg_679_1.typewritter:SetDirty()
			end

			if arg_679_1.time_ >= var_682_5 + var_682_15 and arg_679_1.time_ < var_682_5 + var_682_15 + arg_682_0 then
				arg_679_1.typewritter.percent = 1

				arg_679_1.typewritter:SetDirty()
				arg_679_1:ShowNextGo(true)
			end
		end

		arg_679_1.nodeConfigList_ = {}

		arg_679_1:InitPlayNodeList()
	end,
	Play924011164 = function(arg_683_0, arg_683_1)
		arg_683_1.time_ = 0
		arg_683_1.frameCnt_ = 0
		arg_683_1.state_ = "playing"
		arg_683_1.curTalkId_ = 924011164
		arg_683_1.duration_ = 5

		SetActive(arg_683_1.tipsGo_, false)

		function arg_683_1.onSingleLineFinish_()
			arg_683_1.onSingleLineUpdate_ = nil
			arg_683_1.onSingleLineFinish_ = nil
			arg_683_1.state_ = "waiting"
		end

		function arg_683_1.playNext_(arg_685_0)
			if arg_685_0 == 1 then
				arg_683_0:Play924011165(arg_683_1)
			end
		end

		function arg_683_1.onSingleLineUpdate_(arg_686_0)
			local var_686_0 = arg_683_1.actors_["1033ui_story"]
			local var_686_1 = 0

			if var_686_1 < arg_683_1.time_ and arg_683_1.time_ <= var_686_1 + arg_686_0 and not isNil(var_686_0) and arg_683_1.var_.characterEffect1033ui_story == nil then
				arg_683_1.var_.characterEffect1033ui_story = var_686_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_686_2 = 0.200000002980232

			if var_686_1 <= arg_683_1.time_ and arg_683_1.time_ < var_686_1 + var_686_2 and not isNil(var_686_0) then
				local var_686_3 = (arg_683_1.time_ - var_686_1) / var_686_2

				if arg_683_1.var_.characterEffect1033ui_story and not isNil(var_686_0) then
					local var_686_4 = Mathf.Lerp(0, 0.5, var_686_3)

					arg_683_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_683_1.var_.characterEffect1033ui_story.fillRatio = var_686_4
				end
			end

			if arg_683_1.time_ >= var_686_1 + var_686_2 and arg_683_1.time_ < var_686_1 + var_686_2 + arg_686_0 and not isNil(var_686_0) and arg_683_1.var_.characterEffect1033ui_story then
				local var_686_5 = 0.5

				arg_683_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_683_1.var_.characterEffect1033ui_story.fillRatio = var_686_5
			end

			local var_686_6 = 0
			local var_686_7 = 0.25

			if var_686_6 < arg_683_1.time_ and arg_683_1.time_ <= var_686_6 + arg_686_0 then
				arg_683_1.talkMaxDuration = 0
				arg_683_1.dialogCg_.alpha = 1

				arg_683_1.dialog_:SetActive(true)
				SetActive(arg_683_1.leftNameGo_, true)

				local var_686_8 = arg_683_1:FormatText(StoryNameCfg[7].name)

				arg_683_1.leftNameTxt_.text = var_686_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_683_1.leftNameTxt_.transform)

				arg_683_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_683_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_683_1:RecordName(arg_683_1.leftNameTxt_.text)
				SetActive(arg_683_1.iconTrs_.gameObject, true)
				arg_683_1.iconController_:SetSelectedState("hero")

				arg_683_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_683_1.callingController_:SetSelectedState("normal")

				arg_683_1.keyicon_.color = Color.New(1, 1, 1)
				arg_683_1.icon_.color = Color.New(1, 1, 1)

				local var_686_9 = arg_683_1:GetWordFromCfg(924011164)
				local var_686_10 = arg_683_1:FormatText(var_686_9.content)

				arg_683_1.text_.text = var_686_10

				LuaForUtil.ClearLinePrefixSymbol(arg_683_1.text_)

				local var_686_11 = 10
				local var_686_12 = utf8.len(var_686_10)
				local var_686_13 = var_686_11 <= 0 and var_686_7 or var_686_7 * (var_686_12 / var_686_11)

				if var_686_13 > 0 and var_686_7 < var_686_13 then
					arg_683_1.talkMaxDuration = var_686_13

					if var_686_13 + var_686_6 > arg_683_1.duration_ then
						arg_683_1.duration_ = var_686_13 + var_686_6
					end
				end

				arg_683_1.text_.text = var_686_10
				arg_683_1.typewritter.percent = 0

				arg_683_1.typewritter:SetDirty()
				arg_683_1:ShowNextGo(false)
				arg_683_1:RecordContent(arg_683_1.text_.text)
			end

			local var_686_14 = math.max(var_686_7, arg_683_1.talkMaxDuration)

			if var_686_6 <= arg_683_1.time_ and arg_683_1.time_ < var_686_6 + var_686_14 then
				arg_683_1.typewritter.percent = (arg_683_1.time_ - var_686_6) / var_686_14

				arg_683_1.typewritter:SetDirty()
			end

			if arg_683_1.time_ >= var_686_6 + var_686_14 and arg_683_1.time_ < var_686_6 + var_686_14 + arg_686_0 then
				arg_683_1.typewritter.percent = 1

				arg_683_1.typewritter:SetDirty()
				arg_683_1:ShowNextGo(true)
			end
		end

		arg_683_1.nodeConfigList_ = {}

		arg_683_1:InitPlayNodeList()
	end,
	Play924011165 = function(arg_687_0, arg_687_1)
		arg_687_1.time_ = 0
		arg_687_1.frameCnt_ = 0
		arg_687_1.state_ = "playing"
		arg_687_1.curTalkId_ = 924011165
		arg_687_1.duration_ = 17.17

		local var_687_0 = {
			zh = 8.966,
			ja = 17.166
		}
		local var_687_1 = manager.audio:GetLocalizationFlag()

		if var_687_0[var_687_1] ~= nil then
			arg_687_1.duration_ = var_687_0[var_687_1]
		end

		SetActive(arg_687_1.tipsGo_, false)

		function arg_687_1.onSingleLineFinish_()
			arg_687_1.onSingleLineUpdate_ = nil
			arg_687_1.onSingleLineFinish_ = nil
			arg_687_1.state_ = "waiting"
		end

		function arg_687_1.playNext_(arg_689_0)
			if arg_689_0 == 1 then
				arg_687_0:Play924011166(arg_687_1)
			end
		end

		function arg_687_1.onSingleLineUpdate_(arg_690_0)
			local var_690_0 = arg_687_1.actors_["1033ui_story"]
			local var_690_1 = 0

			if var_690_1 < arg_687_1.time_ and arg_687_1.time_ <= var_690_1 + arg_690_0 and not isNil(var_690_0) and arg_687_1.var_.characterEffect1033ui_story == nil then
				arg_687_1.var_.characterEffect1033ui_story = var_690_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_690_2 = 0.200000002980232

			if var_690_1 <= arg_687_1.time_ and arg_687_1.time_ < var_690_1 + var_690_2 and not isNil(var_690_0) then
				local var_690_3 = (arg_687_1.time_ - var_690_1) / var_690_2

				if arg_687_1.var_.characterEffect1033ui_story and not isNil(var_690_0) then
					arg_687_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_687_1.time_ >= var_690_1 + var_690_2 and arg_687_1.time_ < var_690_1 + var_690_2 + arg_690_0 and not isNil(var_690_0) and arg_687_1.var_.characterEffect1033ui_story then
				arg_687_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_690_4 = 0
			local var_690_5 = 1.1

			if var_690_4 < arg_687_1.time_ and arg_687_1.time_ <= var_690_4 + arg_690_0 then
				arg_687_1.talkMaxDuration = 0
				arg_687_1.dialogCg_.alpha = 1

				arg_687_1.dialog_:SetActive(true)
				SetActive(arg_687_1.leftNameGo_, true)

				local var_690_6 = arg_687_1:FormatText(StoryNameCfg[236].name)

				arg_687_1.leftNameTxt_.text = var_690_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_687_1.leftNameTxt_.transform)

				arg_687_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_687_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_687_1:RecordName(arg_687_1.leftNameTxt_.text)
				SetActive(arg_687_1.iconTrs_.gameObject, false)
				arg_687_1.callingController_:SetSelectedState("normal")

				local var_690_7 = arg_687_1:GetWordFromCfg(924011165)
				local var_690_8 = arg_687_1:FormatText(var_690_7.content)

				arg_687_1.text_.text = var_690_8

				LuaForUtil.ClearLinePrefixSymbol(arg_687_1.text_)

				local var_690_9 = 44
				local var_690_10 = utf8.len(var_690_8)
				local var_690_11 = var_690_9 <= 0 and var_690_5 or var_690_5 * (var_690_10 / var_690_9)

				if var_690_11 > 0 and var_690_5 < var_690_11 then
					arg_687_1.talkMaxDuration = var_690_11

					if var_690_11 + var_690_4 > arg_687_1.duration_ then
						arg_687_1.duration_ = var_690_11 + var_690_4
					end
				end

				arg_687_1.text_.text = var_690_8
				arg_687_1.typewritter.percent = 0

				arg_687_1.typewritter:SetDirty()
				arg_687_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011165", "story_v_side_old_924011.awb") ~= 0 then
					local var_690_12 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011165", "story_v_side_old_924011.awb") / 1000

					if var_690_12 + var_690_4 > arg_687_1.duration_ then
						arg_687_1.duration_ = var_690_12 + var_690_4
					end

					if var_690_7.prefab_name ~= "" and arg_687_1.actors_[var_690_7.prefab_name] ~= nil then
						local var_690_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_687_1.actors_[var_690_7.prefab_name].transform, "story_v_side_old_924011", "924011165", "story_v_side_old_924011.awb")

						arg_687_1:RecordAudio("924011165", var_690_13)
						arg_687_1:RecordAudio("924011165", var_690_13)
					else
						arg_687_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011165", "story_v_side_old_924011.awb")
					end

					arg_687_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011165", "story_v_side_old_924011.awb")
				end

				arg_687_1:RecordContent(arg_687_1.text_.text)
			end

			local var_690_14 = math.max(var_690_5, arg_687_1.talkMaxDuration)

			if var_690_4 <= arg_687_1.time_ and arg_687_1.time_ < var_690_4 + var_690_14 then
				arg_687_1.typewritter.percent = (arg_687_1.time_ - var_690_4) / var_690_14

				arg_687_1.typewritter:SetDirty()
			end

			if arg_687_1.time_ >= var_690_4 + var_690_14 and arg_687_1.time_ < var_690_4 + var_690_14 + arg_690_0 then
				arg_687_1.typewritter.percent = 1

				arg_687_1.typewritter:SetDirty()
				arg_687_1:ShowNextGo(true)
			end
		end

		arg_687_1.nodeConfigList_ = {}

		arg_687_1:InitPlayNodeList()
	end,
	Play924011166 = function(arg_691_0, arg_691_1)
		arg_691_1.time_ = 0
		arg_691_1.frameCnt_ = 0
		arg_691_1.state_ = "playing"
		arg_691_1.curTalkId_ = 924011166
		arg_691_1.duration_ = 12.07

		local var_691_0 = {
			zh = 9.7,
			ja = 12.066
		}
		local var_691_1 = manager.audio:GetLocalizationFlag()

		if var_691_0[var_691_1] ~= nil then
			arg_691_1.duration_ = var_691_0[var_691_1]
		end

		SetActive(arg_691_1.tipsGo_, false)

		function arg_691_1.onSingleLineFinish_()
			arg_691_1.onSingleLineUpdate_ = nil
			arg_691_1.onSingleLineFinish_ = nil
			arg_691_1.state_ = "waiting"
		end

		function arg_691_1.playNext_(arg_693_0)
			if arg_693_0 == 1 then
				arg_691_0:Play924011167(arg_691_1)
			end
		end

		function arg_691_1.onSingleLineUpdate_(arg_694_0)
			local var_694_0 = 0

			if var_694_0 < arg_691_1.time_ and arg_691_1.time_ <= var_694_0 + arg_694_0 then
				arg_691_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033actionlink/1033action423")
			end

			local var_694_1 = 0

			if var_694_1 < arg_691_1.time_ and arg_691_1.time_ <= var_694_1 + arg_694_0 then
				arg_691_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_694_2 = 0
			local var_694_3 = 1.175

			if var_694_2 < arg_691_1.time_ and arg_691_1.time_ <= var_694_2 + arg_694_0 then
				arg_691_1.talkMaxDuration = 0
				arg_691_1.dialogCg_.alpha = 1

				arg_691_1.dialog_:SetActive(true)
				SetActive(arg_691_1.leftNameGo_, true)

				local var_694_4 = arg_691_1:FormatText(StoryNameCfg[236].name)

				arg_691_1.leftNameTxt_.text = var_694_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_691_1.leftNameTxt_.transform)

				arg_691_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_691_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_691_1:RecordName(arg_691_1.leftNameTxt_.text)
				SetActive(arg_691_1.iconTrs_.gameObject, false)
				arg_691_1.callingController_:SetSelectedState("normal")

				local var_694_5 = arg_691_1:GetWordFromCfg(924011166)
				local var_694_6 = arg_691_1:FormatText(var_694_5.content)

				arg_691_1.text_.text = var_694_6

				LuaForUtil.ClearLinePrefixSymbol(arg_691_1.text_)

				local var_694_7 = 47
				local var_694_8 = utf8.len(var_694_6)
				local var_694_9 = var_694_7 <= 0 and var_694_3 or var_694_3 * (var_694_8 / var_694_7)

				if var_694_9 > 0 and var_694_3 < var_694_9 then
					arg_691_1.talkMaxDuration = var_694_9

					if var_694_9 + var_694_2 > arg_691_1.duration_ then
						arg_691_1.duration_ = var_694_9 + var_694_2
					end
				end

				arg_691_1.text_.text = var_694_6
				arg_691_1.typewritter.percent = 0

				arg_691_1.typewritter:SetDirty()
				arg_691_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011166", "story_v_side_old_924011.awb") ~= 0 then
					local var_694_10 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011166", "story_v_side_old_924011.awb") / 1000

					if var_694_10 + var_694_2 > arg_691_1.duration_ then
						arg_691_1.duration_ = var_694_10 + var_694_2
					end

					if var_694_5.prefab_name ~= "" and arg_691_1.actors_[var_694_5.prefab_name] ~= nil then
						local var_694_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_691_1.actors_[var_694_5.prefab_name].transform, "story_v_side_old_924011", "924011166", "story_v_side_old_924011.awb")

						arg_691_1:RecordAudio("924011166", var_694_11)
						arg_691_1:RecordAudio("924011166", var_694_11)
					else
						arg_691_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011166", "story_v_side_old_924011.awb")
					end

					arg_691_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011166", "story_v_side_old_924011.awb")
				end

				arg_691_1:RecordContent(arg_691_1.text_.text)
			end

			local var_694_12 = math.max(var_694_3, arg_691_1.talkMaxDuration)

			if var_694_2 <= arg_691_1.time_ and arg_691_1.time_ < var_694_2 + var_694_12 then
				arg_691_1.typewritter.percent = (arg_691_1.time_ - var_694_2) / var_694_12

				arg_691_1.typewritter:SetDirty()
			end

			if arg_691_1.time_ >= var_694_2 + var_694_12 and arg_691_1.time_ < var_694_2 + var_694_12 + arg_694_0 then
				arg_691_1.typewritter.percent = 1

				arg_691_1.typewritter:SetDirty()
				arg_691_1:ShowNextGo(true)
			end
		end

		arg_691_1.nodeConfigList_ = {}

		arg_691_1:InitPlayNodeList()
	end,
	Play924011167 = function(arg_695_0, arg_695_1)
		arg_695_1.time_ = 0
		arg_695_1.frameCnt_ = 0
		arg_695_1.state_ = "playing"
		arg_695_1.curTalkId_ = 924011167
		arg_695_1.duration_ = 8.7

		local var_695_0 = {
			zh = 7.033,
			ja = 8.7
		}
		local var_695_1 = manager.audio:GetLocalizationFlag()

		if var_695_0[var_695_1] ~= nil then
			arg_695_1.duration_ = var_695_0[var_695_1]
		end

		SetActive(arg_695_1.tipsGo_, false)

		function arg_695_1.onSingleLineFinish_()
			arg_695_1.onSingleLineUpdate_ = nil
			arg_695_1.onSingleLineFinish_ = nil
			arg_695_1.state_ = "waiting"
		end

		function arg_695_1.playNext_(arg_697_0)
			if arg_697_0 == 1 then
				arg_695_0:Play924011168(arg_695_1)
			end
		end

		function arg_695_1.onSingleLineUpdate_(arg_698_0)
			local var_698_0 = arg_695_1.actors_["1020ui_story"].transform
			local var_698_1 = 0

			if var_698_1 < arg_695_1.time_ and arg_695_1.time_ <= var_698_1 + arg_698_0 then
				arg_695_1.var_.moveOldPos1020ui_story = var_698_0.localPosition
			end

			local var_698_2 = 0.001

			if var_698_1 <= arg_695_1.time_ and arg_695_1.time_ < var_698_1 + var_698_2 then
				local var_698_3 = (arg_695_1.time_ - var_698_1) / var_698_2
				local var_698_4 = Vector3.New(0.7, -0.85, -6.25)

				var_698_0.localPosition = Vector3.Lerp(arg_695_1.var_.moveOldPos1020ui_story, var_698_4, var_698_3)

				local var_698_5 = manager.ui.mainCamera.transform.position - var_698_0.position

				var_698_0.forward = Vector3.New(var_698_5.x, var_698_5.y, var_698_5.z)

				local var_698_6 = var_698_0.localEulerAngles

				var_698_6.z = 0
				var_698_6.x = 0
				var_698_0.localEulerAngles = var_698_6
			end

			if arg_695_1.time_ >= var_698_1 + var_698_2 and arg_695_1.time_ < var_698_1 + var_698_2 + arg_698_0 then
				var_698_0.localPosition = Vector3.New(0.7, -0.85, -6.25)

				local var_698_7 = manager.ui.mainCamera.transform.position - var_698_0.position

				var_698_0.forward = Vector3.New(var_698_7.x, var_698_7.y, var_698_7.z)

				local var_698_8 = var_698_0.localEulerAngles

				var_698_8.z = 0
				var_698_8.x = 0
				var_698_0.localEulerAngles = var_698_8
			end

			local var_698_9 = arg_695_1.actors_["1033ui_story"].transform
			local var_698_10 = 0

			if var_698_10 < arg_695_1.time_ and arg_695_1.time_ <= var_698_10 + arg_698_0 then
				arg_695_1.var_.moveOldPos1033ui_story = var_698_9.localPosition
			end

			local var_698_11 = 0.001

			if var_698_10 <= arg_695_1.time_ and arg_695_1.time_ < var_698_10 + var_698_11 then
				local var_698_12 = (arg_695_1.time_ - var_698_10) / var_698_11
				local var_698_13 = Vector3.New(-0.7, -1.01, -6.13)

				var_698_9.localPosition = Vector3.Lerp(arg_695_1.var_.moveOldPos1033ui_story, var_698_13, var_698_12)

				local var_698_14 = manager.ui.mainCamera.transform.position - var_698_9.position

				var_698_9.forward = Vector3.New(var_698_14.x, var_698_14.y, var_698_14.z)

				local var_698_15 = var_698_9.localEulerAngles

				var_698_15.z = 0
				var_698_15.x = 0
				var_698_9.localEulerAngles = var_698_15
			end

			if arg_695_1.time_ >= var_698_10 + var_698_11 and arg_695_1.time_ < var_698_10 + var_698_11 + arg_698_0 then
				var_698_9.localPosition = Vector3.New(-0.7, -1.01, -6.13)

				local var_698_16 = manager.ui.mainCamera.transform.position - var_698_9.position

				var_698_9.forward = Vector3.New(var_698_16.x, var_698_16.y, var_698_16.z)

				local var_698_17 = var_698_9.localEulerAngles

				var_698_17.z = 0
				var_698_17.x = 0
				var_698_9.localEulerAngles = var_698_17
			end

			local var_698_18 = arg_695_1.actors_["1020ui_story"]
			local var_698_19 = 0

			if var_698_19 < arg_695_1.time_ and arg_695_1.time_ <= var_698_19 + arg_698_0 and not isNil(var_698_18) and arg_695_1.var_.characterEffect1020ui_story == nil then
				arg_695_1.var_.characterEffect1020ui_story = var_698_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_698_20 = 0.200000002980232

			if var_698_19 <= arg_695_1.time_ and arg_695_1.time_ < var_698_19 + var_698_20 and not isNil(var_698_18) then
				local var_698_21 = (arg_695_1.time_ - var_698_19) / var_698_20

				if arg_695_1.var_.characterEffect1020ui_story and not isNil(var_698_18) then
					arg_695_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_695_1.time_ >= var_698_19 + var_698_20 and arg_695_1.time_ < var_698_19 + var_698_20 + arg_698_0 and not isNil(var_698_18) and arg_695_1.var_.characterEffect1020ui_story then
				arg_695_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_698_22 = arg_695_1.actors_["1033ui_story"]
			local var_698_23 = 0

			if var_698_23 < arg_695_1.time_ and arg_695_1.time_ <= var_698_23 + arg_698_0 and not isNil(var_698_22) and arg_695_1.var_.characterEffect1033ui_story == nil then
				arg_695_1.var_.characterEffect1033ui_story = var_698_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_698_24 = 0.200000002980232

			if var_698_23 <= arg_695_1.time_ and arg_695_1.time_ < var_698_23 + var_698_24 and not isNil(var_698_22) then
				local var_698_25 = (arg_695_1.time_ - var_698_23) / var_698_24

				if arg_695_1.var_.characterEffect1033ui_story and not isNil(var_698_22) then
					local var_698_26 = Mathf.Lerp(0, 0.5, var_698_25)

					arg_695_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_695_1.var_.characterEffect1033ui_story.fillRatio = var_698_26
				end
			end

			if arg_695_1.time_ >= var_698_23 + var_698_24 and arg_695_1.time_ < var_698_23 + var_698_24 + arg_698_0 and not isNil(var_698_22) and arg_695_1.var_.characterEffect1033ui_story then
				local var_698_27 = 0.5

				arg_695_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_695_1.var_.characterEffect1033ui_story.fillRatio = var_698_27
			end

			local var_698_28 = 0

			if var_698_28 < arg_695_1.time_ and arg_695_1.time_ <= var_698_28 + arg_698_0 then
				arg_695_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action1_1")
			end

			local var_698_29 = 0

			if var_698_29 < arg_695_1.time_ and arg_695_1.time_ <= var_698_29 + arg_698_0 then
				arg_695_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_698_30 = 0
			local var_698_31 = 0.9

			if var_698_30 < arg_695_1.time_ and arg_695_1.time_ <= var_698_30 + arg_698_0 then
				arg_695_1.talkMaxDuration = 0
				arg_695_1.dialogCg_.alpha = 1

				arg_695_1.dialog_:SetActive(true)
				SetActive(arg_695_1.leftNameGo_, true)

				local var_698_32 = arg_695_1:FormatText(StoryNameCfg[613].name)

				arg_695_1.leftNameTxt_.text = var_698_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_695_1.leftNameTxt_.transform)

				arg_695_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_695_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_695_1:RecordName(arg_695_1.leftNameTxt_.text)
				SetActive(arg_695_1.iconTrs_.gameObject, false)
				arg_695_1.callingController_:SetSelectedState("normal")

				local var_698_33 = arg_695_1:GetWordFromCfg(924011167)
				local var_698_34 = arg_695_1:FormatText(var_698_33.content)

				arg_695_1.text_.text = var_698_34

				LuaForUtil.ClearLinePrefixSymbol(arg_695_1.text_)

				local var_698_35 = 36
				local var_698_36 = utf8.len(var_698_34)
				local var_698_37 = var_698_35 <= 0 and var_698_31 or var_698_31 * (var_698_36 / var_698_35)

				if var_698_37 > 0 and var_698_31 < var_698_37 then
					arg_695_1.talkMaxDuration = var_698_37

					if var_698_37 + var_698_30 > arg_695_1.duration_ then
						arg_695_1.duration_ = var_698_37 + var_698_30
					end
				end

				arg_695_1.text_.text = var_698_34
				arg_695_1.typewritter.percent = 0

				arg_695_1.typewritter:SetDirty()
				arg_695_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011167", "story_v_side_old_924011.awb") ~= 0 then
					local var_698_38 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011167", "story_v_side_old_924011.awb") / 1000

					if var_698_38 + var_698_30 > arg_695_1.duration_ then
						arg_695_1.duration_ = var_698_38 + var_698_30
					end

					if var_698_33.prefab_name ~= "" and arg_695_1.actors_[var_698_33.prefab_name] ~= nil then
						local var_698_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_695_1.actors_[var_698_33.prefab_name].transform, "story_v_side_old_924011", "924011167", "story_v_side_old_924011.awb")

						arg_695_1:RecordAudio("924011167", var_698_39)
						arg_695_1:RecordAudio("924011167", var_698_39)
					else
						arg_695_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011167", "story_v_side_old_924011.awb")
					end

					arg_695_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011167", "story_v_side_old_924011.awb")
				end

				arg_695_1:RecordContent(arg_695_1.text_.text)
			end

			local var_698_40 = math.max(var_698_31, arg_695_1.talkMaxDuration)

			if var_698_30 <= arg_695_1.time_ and arg_695_1.time_ < var_698_30 + var_698_40 then
				arg_695_1.typewritter.percent = (arg_695_1.time_ - var_698_30) / var_698_40

				arg_695_1.typewritter:SetDirty()
			end

			if arg_695_1.time_ >= var_698_30 + var_698_40 and arg_695_1.time_ < var_698_30 + var_698_40 + arg_698_0 then
				arg_695_1.typewritter.percent = 1

				arg_695_1.typewritter:SetDirty()
				arg_695_1:ShowNextGo(true)
			end
		end

		arg_695_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_695_1:InitPlayNodeList()
	end,
	Play924011168 = function(arg_699_0, arg_699_1)
		arg_699_1.time_ = 0
		arg_699_1.frameCnt_ = 0
		arg_699_1.state_ = "playing"
		arg_699_1.curTalkId_ = 924011168
		arg_699_1.duration_ = 3.7

		local var_699_0 = {
			zh = 2.633,
			ja = 3.7
		}
		local var_699_1 = manager.audio:GetLocalizationFlag()

		if var_699_0[var_699_1] ~= nil then
			arg_699_1.duration_ = var_699_0[var_699_1]
		end

		SetActive(arg_699_1.tipsGo_, false)

		function arg_699_1.onSingleLineFinish_()
			arg_699_1.onSingleLineUpdate_ = nil
			arg_699_1.onSingleLineFinish_ = nil
			arg_699_1.state_ = "waiting"
		end

		function arg_699_1.playNext_(arg_701_0)
			if arg_701_0 == 1 then
				arg_699_0:Play924011169(arg_699_1)
			end
		end

		function arg_699_1.onSingleLineUpdate_(arg_702_0)
			local var_702_0 = 0

			if var_702_0 < arg_699_1.time_ and arg_699_1.time_ <= var_702_0 + arg_702_0 then
				arg_699_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action8_1")
			end

			local var_702_1 = 0
			local var_702_2 = 0.25

			if var_702_1 < arg_699_1.time_ and arg_699_1.time_ <= var_702_1 + arg_702_0 then
				arg_699_1.talkMaxDuration = 0
				arg_699_1.dialogCg_.alpha = 1

				arg_699_1.dialog_:SetActive(true)
				SetActive(arg_699_1.leftNameGo_, true)

				local var_702_3 = arg_699_1:FormatText(StoryNameCfg[613].name)

				arg_699_1.leftNameTxt_.text = var_702_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_699_1.leftNameTxt_.transform)

				arg_699_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_699_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_699_1:RecordName(arg_699_1.leftNameTxt_.text)
				SetActive(arg_699_1.iconTrs_.gameObject, false)
				arg_699_1.callingController_:SetSelectedState("normal")

				local var_702_4 = arg_699_1:GetWordFromCfg(924011168)
				local var_702_5 = arg_699_1:FormatText(var_702_4.content)

				arg_699_1.text_.text = var_702_5

				LuaForUtil.ClearLinePrefixSymbol(arg_699_1.text_)

				local var_702_6 = 10
				local var_702_7 = utf8.len(var_702_5)
				local var_702_8 = var_702_6 <= 0 and var_702_2 or var_702_2 * (var_702_7 / var_702_6)

				if var_702_8 > 0 and var_702_2 < var_702_8 then
					arg_699_1.talkMaxDuration = var_702_8

					if var_702_8 + var_702_1 > arg_699_1.duration_ then
						arg_699_1.duration_ = var_702_8 + var_702_1
					end
				end

				arg_699_1.text_.text = var_702_5
				arg_699_1.typewritter.percent = 0

				arg_699_1.typewritter:SetDirty()
				arg_699_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011168", "story_v_side_old_924011.awb") ~= 0 then
					local var_702_9 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011168", "story_v_side_old_924011.awb") / 1000

					if var_702_9 + var_702_1 > arg_699_1.duration_ then
						arg_699_1.duration_ = var_702_9 + var_702_1
					end

					if var_702_4.prefab_name ~= "" and arg_699_1.actors_[var_702_4.prefab_name] ~= nil then
						local var_702_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_699_1.actors_[var_702_4.prefab_name].transform, "story_v_side_old_924011", "924011168", "story_v_side_old_924011.awb")

						arg_699_1:RecordAudio("924011168", var_702_10)
						arg_699_1:RecordAudio("924011168", var_702_10)
					else
						arg_699_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011168", "story_v_side_old_924011.awb")
					end

					arg_699_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011168", "story_v_side_old_924011.awb")
				end

				arg_699_1:RecordContent(arg_699_1.text_.text)
			end

			local var_702_11 = math.max(var_702_2, arg_699_1.talkMaxDuration)

			if var_702_1 <= arg_699_1.time_ and arg_699_1.time_ < var_702_1 + var_702_11 then
				arg_699_1.typewritter.percent = (arg_699_1.time_ - var_702_1) / var_702_11

				arg_699_1.typewritter:SetDirty()
			end

			if arg_699_1.time_ >= var_702_1 + var_702_11 and arg_699_1.time_ < var_702_1 + var_702_11 + arg_702_0 then
				arg_699_1.typewritter.percent = 1

				arg_699_1.typewritter:SetDirty()
				arg_699_1:ShowNextGo(true)
			end
		end

		arg_699_1.nodeConfigList_ = {}

		arg_699_1:InitPlayNodeList()
	end,
	Play924011169 = function(arg_703_0, arg_703_1)
		arg_703_1.time_ = 0
		arg_703_1.frameCnt_ = 0
		arg_703_1.state_ = "playing"
		arg_703_1.curTalkId_ = 924011169
		arg_703_1.duration_ = 5

		SetActive(arg_703_1.tipsGo_, false)

		function arg_703_1.onSingleLineFinish_()
			arg_703_1.onSingleLineUpdate_ = nil
			arg_703_1.onSingleLineFinish_ = nil
			arg_703_1.state_ = "waiting"
		end

		function arg_703_1.playNext_(arg_705_0)
			if arg_705_0 == 1 then
				arg_703_0:Play924011170(arg_703_1)
			end
		end

		function arg_703_1.onSingleLineUpdate_(arg_706_0)
			local var_706_0 = arg_703_1.actors_["1020ui_story"]
			local var_706_1 = 0

			if var_706_1 < arg_703_1.time_ and arg_703_1.time_ <= var_706_1 + arg_706_0 and not isNil(var_706_0) and arg_703_1.var_.characterEffect1020ui_story == nil then
				arg_703_1.var_.characterEffect1020ui_story = var_706_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_706_2 = 0.200000002980232

			if var_706_1 <= arg_703_1.time_ and arg_703_1.time_ < var_706_1 + var_706_2 and not isNil(var_706_0) then
				local var_706_3 = (arg_703_1.time_ - var_706_1) / var_706_2

				if arg_703_1.var_.characterEffect1020ui_story and not isNil(var_706_0) then
					local var_706_4 = Mathf.Lerp(0, 0.5, var_706_3)

					arg_703_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_703_1.var_.characterEffect1020ui_story.fillRatio = var_706_4
				end
			end

			if arg_703_1.time_ >= var_706_1 + var_706_2 and arg_703_1.time_ < var_706_1 + var_706_2 + arg_706_0 and not isNil(var_706_0) and arg_703_1.var_.characterEffect1020ui_story then
				local var_706_5 = 0.5

				arg_703_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_703_1.var_.characterEffect1020ui_story.fillRatio = var_706_5
			end

			local var_706_6 = 0
			local var_706_7 = 0.375

			if var_706_6 < arg_703_1.time_ and arg_703_1.time_ <= var_706_6 + arg_706_0 then
				arg_703_1.talkMaxDuration = 0
				arg_703_1.dialogCg_.alpha = 1

				arg_703_1.dialog_:SetActive(true)
				SetActive(arg_703_1.leftNameGo_, true)

				local var_706_8 = arg_703_1:FormatText(StoryNameCfg[7].name)

				arg_703_1.leftNameTxt_.text = var_706_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_703_1.leftNameTxt_.transform)

				arg_703_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_703_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_703_1:RecordName(arg_703_1.leftNameTxt_.text)
				SetActive(arg_703_1.iconTrs_.gameObject, true)
				arg_703_1.iconController_:SetSelectedState("hero")

				arg_703_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_703_1.callingController_:SetSelectedState("normal")

				arg_703_1.keyicon_.color = Color.New(1, 1, 1)
				arg_703_1.icon_.color = Color.New(1, 1, 1)

				local var_706_9 = arg_703_1:GetWordFromCfg(924011169)
				local var_706_10 = arg_703_1:FormatText(var_706_9.content)

				arg_703_1.text_.text = var_706_10

				LuaForUtil.ClearLinePrefixSymbol(arg_703_1.text_)

				local var_706_11 = 15
				local var_706_12 = utf8.len(var_706_10)
				local var_706_13 = var_706_11 <= 0 and var_706_7 or var_706_7 * (var_706_12 / var_706_11)

				if var_706_13 > 0 and var_706_7 < var_706_13 then
					arg_703_1.talkMaxDuration = var_706_13

					if var_706_13 + var_706_6 > arg_703_1.duration_ then
						arg_703_1.duration_ = var_706_13 + var_706_6
					end
				end

				arg_703_1.text_.text = var_706_10
				arg_703_1.typewritter.percent = 0

				arg_703_1.typewritter:SetDirty()
				arg_703_1:ShowNextGo(false)
				arg_703_1:RecordContent(arg_703_1.text_.text)
			end

			local var_706_14 = math.max(var_706_7, arg_703_1.talkMaxDuration)

			if var_706_6 <= arg_703_1.time_ and arg_703_1.time_ < var_706_6 + var_706_14 then
				arg_703_1.typewritter.percent = (arg_703_1.time_ - var_706_6) / var_706_14

				arg_703_1.typewritter:SetDirty()
			end

			if arg_703_1.time_ >= var_706_6 + var_706_14 and arg_703_1.time_ < var_706_6 + var_706_14 + arg_706_0 then
				arg_703_1.typewritter.percent = 1

				arg_703_1.typewritter:SetDirty()
				arg_703_1:ShowNextGo(true)
			end
		end

		arg_703_1.nodeConfigList_ = {}

		arg_703_1:InitPlayNodeList()
	end,
	Play924011170 = function(arg_707_0, arg_707_1)
		arg_707_1.time_ = 0
		arg_707_1.frameCnt_ = 0
		arg_707_1.state_ = "playing"
		arg_707_1.curTalkId_ = 924011170
		arg_707_1.duration_ = 14.5

		local var_707_0 = {
			zh = 10.7,
			ja = 14.5
		}
		local var_707_1 = manager.audio:GetLocalizationFlag()

		if var_707_0[var_707_1] ~= nil then
			arg_707_1.duration_ = var_707_0[var_707_1]
		end

		SetActive(arg_707_1.tipsGo_, false)

		function arg_707_1.onSingleLineFinish_()
			arg_707_1.onSingleLineUpdate_ = nil
			arg_707_1.onSingleLineFinish_ = nil
			arg_707_1.state_ = "waiting"
		end

		function arg_707_1.playNext_(arg_709_0)
			if arg_709_0 == 1 then
				arg_707_0:Play924011171(arg_707_1)
			end
		end

		function arg_707_1.onSingleLineUpdate_(arg_710_0)
			local var_710_0 = arg_707_1.actors_["1033ui_story"]
			local var_710_1 = 0

			if var_710_1 < arg_707_1.time_ and arg_707_1.time_ <= var_710_1 + arg_710_0 and not isNil(var_710_0) and arg_707_1.var_.characterEffect1033ui_story == nil then
				arg_707_1.var_.characterEffect1033ui_story = var_710_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_710_2 = 0.200000002980232

			if var_710_1 <= arg_707_1.time_ and arg_707_1.time_ < var_710_1 + var_710_2 and not isNil(var_710_0) then
				local var_710_3 = (arg_707_1.time_ - var_710_1) / var_710_2

				if arg_707_1.var_.characterEffect1033ui_story and not isNil(var_710_0) then
					arg_707_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_707_1.time_ >= var_710_1 + var_710_2 and arg_707_1.time_ < var_710_1 + var_710_2 + arg_710_0 and not isNil(var_710_0) and arg_707_1.var_.characterEffect1033ui_story then
				arg_707_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_710_4 = 0

			if var_710_4 < arg_707_1.time_ and arg_707_1.time_ <= var_710_4 + arg_710_0 then
				arg_707_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action3_2")
			end

			local var_710_5 = 0

			if var_710_5 < arg_707_1.time_ and arg_707_1.time_ <= var_710_5 + arg_710_0 then
				arg_707_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_710_6 = 0
			local var_710_7 = 1.375

			if var_710_6 < arg_707_1.time_ and arg_707_1.time_ <= var_710_6 + arg_710_0 then
				arg_707_1.talkMaxDuration = 0
				arg_707_1.dialogCg_.alpha = 1

				arg_707_1.dialog_:SetActive(true)
				SetActive(arg_707_1.leftNameGo_, true)

				local var_710_8 = arg_707_1:FormatText(StoryNameCfg[236].name)

				arg_707_1.leftNameTxt_.text = var_710_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_707_1.leftNameTxt_.transform)

				arg_707_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_707_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_707_1:RecordName(arg_707_1.leftNameTxt_.text)
				SetActive(arg_707_1.iconTrs_.gameObject, false)
				arg_707_1.callingController_:SetSelectedState("normal")

				local var_710_9 = arg_707_1:GetWordFromCfg(924011170)
				local var_710_10 = arg_707_1:FormatText(var_710_9.content)

				arg_707_1.text_.text = var_710_10

				LuaForUtil.ClearLinePrefixSymbol(arg_707_1.text_)

				local var_710_11 = 55
				local var_710_12 = utf8.len(var_710_10)
				local var_710_13 = var_710_11 <= 0 and var_710_7 or var_710_7 * (var_710_12 / var_710_11)

				if var_710_13 > 0 and var_710_7 < var_710_13 then
					arg_707_1.talkMaxDuration = var_710_13

					if var_710_13 + var_710_6 > arg_707_1.duration_ then
						arg_707_1.duration_ = var_710_13 + var_710_6
					end
				end

				arg_707_1.text_.text = var_710_10
				arg_707_1.typewritter.percent = 0

				arg_707_1.typewritter:SetDirty()
				arg_707_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011170", "story_v_side_old_924011.awb") ~= 0 then
					local var_710_14 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011170", "story_v_side_old_924011.awb") / 1000

					if var_710_14 + var_710_6 > arg_707_1.duration_ then
						arg_707_1.duration_ = var_710_14 + var_710_6
					end

					if var_710_9.prefab_name ~= "" and arg_707_1.actors_[var_710_9.prefab_name] ~= nil then
						local var_710_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_707_1.actors_[var_710_9.prefab_name].transform, "story_v_side_old_924011", "924011170", "story_v_side_old_924011.awb")

						arg_707_1:RecordAudio("924011170", var_710_15)
						arg_707_1:RecordAudio("924011170", var_710_15)
					else
						arg_707_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011170", "story_v_side_old_924011.awb")
					end

					arg_707_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011170", "story_v_side_old_924011.awb")
				end

				arg_707_1:RecordContent(arg_707_1.text_.text)
			end

			local var_710_16 = math.max(var_710_7, arg_707_1.talkMaxDuration)

			if var_710_6 <= arg_707_1.time_ and arg_707_1.time_ < var_710_6 + var_710_16 then
				arg_707_1.typewritter.percent = (arg_707_1.time_ - var_710_6) / var_710_16

				arg_707_1.typewritter:SetDirty()
			end

			if arg_707_1.time_ >= var_710_6 + var_710_16 and arg_707_1.time_ < var_710_6 + var_710_16 + arg_710_0 then
				arg_707_1.typewritter.percent = 1

				arg_707_1.typewritter:SetDirty()
				arg_707_1:ShowNextGo(true)
			end
		end

		arg_707_1.nodeConfigList_ = {}

		arg_707_1:InitPlayNodeList()
	end,
	Play924011171 = function(arg_711_0, arg_711_1)
		arg_711_1.time_ = 0
		arg_711_1.frameCnt_ = 0
		arg_711_1.state_ = "playing"
		arg_711_1.curTalkId_ = 924011171
		arg_711_1.duration_ = 18.53

		local var_711_0 = {
			zh = 10.9,
			ja = 18.533
		}
		local var_711_1 = manager.audio:GetLocalizationFlag()

		if var_711_0[var_711_1] ~= nil then
			arg_711_1.duration_ = var_711_0[var_711_1]
		end

		SetActive(arg_711_1.tipsGo_, false)

		function arg_711_1.onSingleLineFinish_()
			arg_711_1.onSingleLineUpdate_ = nil
			arg_711_1.onSingleLineFinish_ = nil
			arg_711_1.state_ = "waiting"
		end

		function arg_711_1.playNext_(arg_713_0)
			if arg_713_0 == 1 then
				arg_711_0:Play924011172(arg_711_1)
			end
		end

		function arg_711_1.onSingleLineUpdate_(arg_714_0)
			local var_714_0 = 0
			local var_714_1 = 1.45

			if var_714_0 < arg_711_1.time_ and arg_711_1.time_ <= var_714_0 + arg_714_0 then
				arg_711_1.talkMaxDuration = 0
				arg_711_1.dialogCg_.alpha = 1

				arg_711_1.dialog_:SetActive(true)
				SetActive(arg_711_1.leftNameGo_, true)

				local var_714_2 = arg_711_1:FormatText(StoryNameCfg[236].name)

				arg_711_1.leftNameTxt_.text = var_714_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_711_1.leftNameTxt_.transform)

				arg_711_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_711_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_711_1:RecordName(arg_711_1.leftNameTxt_.text)
				SetActive(arg_711_1.iconTrs_.gameObject, false)
				arg_711_1.callingController_:SetSelectedState("normal")

				local var_714_3 = arg_711_1:GetWordFromCfg(924011171)
				local var_714_4 = arg_711_1:FormatText(var_714_3.content)

				arg_711_1.text_.text = var_714_4

				LuaForUtil.ClearLinePrefixSymbol(arg_711_1.text_)

				local var_714_5 = 58
				local var_714_6 = utf8.len(var_714_4)
				local var_714_7 = var_714_5 <= 0 and var_714_1 or var_714_1 * (var_714_6 / var_714_5)

				if var_714_7 > 0 and var_714_1 < var_714_7 then
					arg_711_1.talkMaxDuration = var_714_7

					if var_714_7 + var_714_0 > arg_711_1.duration_ then
						arg_711_1.duration_ = var_714_7 + var_714_0
					end
				end

				arg_711_1.text_.text = var_714_4
				arg_711_1.typewritter.percent = 0

				arg_711_1.typewritter:SetDirty()
				arg_711_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011171", "story_v_side_old_924011.awb") ~= 0 then
					local var_714_8 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011171", "story_v_side_old_924011.awb") / 1000

					if var_714_8 + var_714_0 > arg_711_1.duration_ then
						arg_711_1.duration_ = var_714_8 + var_714_0
					end

					if var_714_3.prefab_name ~= "" and arg_711_1.actors_[var_714_3.prefab_name] ~= nil then
						local var_714_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_711_1.actors_[var_714_3.prefab_name].transform, "story_v_side_old_924011", "924011171", "story_v_side_old_924011.awb")

						arg_711_1:RecordAudio("924011171", var_714_9)
						arg_711_1:RecordAudio("924011171", var_714_9)
					else
						arg_711_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011171", "story_v_side_old_924011.awb")
					end

					arg_711_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011171", "story_v_side_old_924011.awb")
				end

				arg_711_1:RecordContent(arg_711_1.text_.text)
			end

			local var_714_10 = math.max(var_714_1, arg_711_1.talkMaxDuration)

			if var_714_0 <= arg_711_1.time_ and arg_711_1.time_ < var_714_0 + var_714_10 then
				arg_711_1.typewritter.percent = (arg_711_1.time_ - var_714_0) / var_714_10

				arg_711_1.typewritter:SetDirty()
			end

			if arg_711_1.time_ >= var_714_0 + var_714_10 and arg_711_1.time_ < var_714_0 + var_714_10 + arg_714_0 then
				arg_711_1.typewritter.percent = 1

				arg_711_1.typewritter:SetDirty()
				arg_711_1:ShowNextGo(true)
			end
		end

		arg_711_1.nodeConfigList_ = {}

		arg_711_1:InitPlayNodeList()
	end,
	Play924011172 = function(arg_715_0, arg_715_1)
		arg_715_1.time_ = 0
		arg_715_1.frameCnt_ = 0
		arg_715_1.state_ = "playing"
		arg_715_1.curTalkId_ = 924011172
		arg_715_1.duration_ = 5.27

		local var_715_0 = {
			zh = 4.4,
			ja = 5.266
		}
		local var_715_1 = manager.audio:GetLocalizationFlag()

		if var_715_0[var_715_1] ~= nil then
			arg_715_1.duration_ = var_715_0[var_715_1]
		end

		SetActive(arg_715_1.tipsGo_, false)

		function arg_715_1.onSingleLineFinish_()
			arg_715_1.onSingleLineUpdate_ = nil
			arg_715_1.onSingleLineFinish_ = nil
			arg_715_1.state_ = "waiting"
		end

		function arg_715_1.playNext_(arg_717_0)
			if arg_717_0 == 1 then
				arg_715_0:Play924011173(arg_715_1)
			end
		end

		function arg_715_1.onSingleLineUpdate_(arg_718_0)
			local var_718_0 = arg_715_1.actors_["1020ui_story"].transform
			local var_718_1 = 0

			if var_718_1 < arg_715_1.time_ and arg_715_1.time_ <= var_718_1 + arg_718_0 then
				arg_715_1.var_.moveOldPos1020ui_story = var_718_0.localPosition
			end

			local var_718_2 = 0.001

			if var_718_1 <= arg_715_1.time_ and arg_715_1.time_ < var_718_1 + var_718_2 then
				local var_718_3 = (arg_715_1.time_ - var_718_1) / var_718_2
				local var_718_4 = Vector3.New(0.7, -0.85, -6.25)

				var_718_0.localPosition = Vector3.Lerp(arg_715_1.var_.moveOldPos1020ui_story, var_718_4, var_718_3)

				local var_718_5 = manager.ui.mainCamera.transform.position - var_718_0.position

				var_718_0.forward = Vector3.New(var_718_5.x, var_718_5.y, var_718_5.z)

				local var_718_6 = var_718_0.localEulerAngles

				var_718_6.z = 0
				var_718_6.x = 0
				var_718_0.localEulerAngles = var_718_6
			end

			if arg_715_1.time_ >= var_718_1 + var_718_2 and arg_715_1.time_ < var_718_1 + var_718_2 + arg_718_0 then
				var_718_0.localPosition = Vector3.New(0.7, -0.85, -6.25)

				local var_718_7 = manager.ui.mainCamera.transform.position - var_718_0.position

				var_718_0.forward = Vector3.New(var_718_7.x, var_718_7.y, var_718_7.z)

				local var_718_8 = var_718_0.localEulerAngles

				var_718_8.z = 0
				var_718_8.x = 0
				var_718_0.localEulerAngles = var_718_8
			end

			local var_718_9 = arg_715_1.actors_["1020ui_story"]
			local var_718_10 = 0

			if var_718_10 < arg_715_1.time_ and arg_715_1.time_ <= var_718_10 + arg_718_0 and not isNil(var_718_9) and arg_715_1.var_.characterEffect1020ui_story == nil then
				arg_715_1.var_.characterEffect1020ui_story = var_718_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_718_11 = 0.200000002980232

			if var_718_10 <= arg_715_1.time_ and arg_715_1.time_ < var_718_10 + var_718_11 and not isNil(var_718_9) then
				local var_718_12 = (arg_715_1.time_ - var_718_10) / var_718_11

				if arg_715_1.var_.characterEffect1020ui_story and not isNil(var_718_9) then
					arg_715_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_715_1.time_ >= var_718_10 + var_718_11 and arg_715_1.time_ < var_718_10 + var_718_11 + arg_718_0 and not isNil(var_718_9) and arg_715_1.var_.characterEffect1020ui_story then
				arg_715_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_718_13 = arg_715_1.actors_["1033ui_story"]
			local var_718_14 = 0

			if var_718_14 < arg_715_1.time_ and arg_715_1.time_ <= var_718_14 + arg_718_0 and not isNil(var_718_13) and arg_715_1.var_.characterEffect1033ui_story == nil then
				arg_715_1.var_.characterEffect1033ui_story = var_718_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_718_15 = 0.200000002980232

			if var_718_14 <= arg_715_1.time_ and arg_715_1.time_ < var_718_14 + var_718_15 and not isNil(var_718_13) then
				local var_718_16 = (arg_715_1.time_ - var_718_14) / var_718_15

				if arg_715_1.var_.characterEffect1033ui_story and not isNil(var_718_13) then
					local var_718_17 = Mathf.Lerp(0, 0.5, var_718_16)

					arg_715_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_715_1.var_.characterEffect1033ui_story.fillRatio = var_718_17
				end
			end

			if arg_715_1.time_ >= var_718_14 + var_718_15 and arg_715_1.time_ < var_718_14 + var_718_15 + arg_718_0 and not isNil(var_718_13) and arg_715_1.var_.characterEffect1033ui_story then
				local var_718_18 = 0.5

				arg_715_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_715_1.var_.characterEffect1033ui_story.fillRatio = var_718_18
			end

			local var_718_19 = 0

			if var_718_19 < arg_715_1.time_ and arg_715_1.time_ <= var_718_19 + arg_718_0 then
				arg_715_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_718_20 = 0

			if var_718_20 < arg_715_1.time_ and arg_715_1.time_ <= var_718_20 + arg_718_0 then
				arg_715_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020actionlink/1020action483")
			end

			local var_718_21 = 0
			local var_718_22 = 0.325

			if var_718_21 < arg_715_1.time_ and arg_715_1.time_ <= var_718_21 + arg_718_0 then
				arg_715_1.talkMaxDuration = 0
				arg_715_1.dialogCg_.alpha = 1

				arg_715_1.dialog_:SetActive(true)
				SetActive(arg_715_1.leftNameGo_, true)

				local var_718_23 = arg_715_1:FormatText(StoryNameCfg[613].name)

				arg_715_1.leftNameTxt_.text = var_718_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_715_1.leftNameTxt_.transform)

				arg_715_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_715_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_715_1:RecordName(arg_715_1.leftNameTxt_.text)
				SetActive(arg_715_1.iconTrs_.gameObject, false)
				arg_715_1.callingController_:SetSelectedState("normal")

				local var_718_24 = arg_715_1:GetWordFromCfg(924011172)
				local var_718_25 = arg_715_1:FormatText(var_718_24.content)

				arg_715_1.text_.text = var_718_25

				LuaForUtil.ClearLinePrefixSymbol(arg_715_1.text_)

				local var_718_26 = 13
				local var_718_27 = utf8.len(var_718_25)
				local var_718_28 = var_718_26 <= 0 and var_718_22 or var_718_22 * (var_718_27 / var_718_26)

				if var_718_28 > 0 and var_718_22 < var_718_28 then
					arg_715_1.talkMaxDuration = var_718_28

					if var_718_28 + var_718_21 > arg_715_1.duration_ then
						arg_715_1.duration_ = var_718_28 + var_718_21
					end
				end

				arg_715_1.text_.text = var_718_25
				arg_715_1.typewritter.percent = 0

				arg_715_1.typewritter:SetDirty()
				arg_715_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011172", "story_v_side_old_924011.awb") ~= 0 then
					local var_718_29 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011172", "story_v_side_old_924011.awb") / 1000

					if var_718_29 + var_718_21 > arg_715_1.duration_ then
						arg_715_1.duration_ = var_718_29 + var_718_21
					end

					if var_718_24.prefab_name ~= "" and arg_715_1.actors_[var_718_24.prefab_name] ~= nil then
						local var_718_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_715_1.actors_[var_718_24.prefab_name].transform, "story_v_side_old_924011", "924011172", "story_v_side_old_924011.awb")

						arg_715_1:RecordAudio("924011172", var_718_30)
						arg_715_1:RecordAudio("924011172", var_718_30)
					else
						arg_715_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011172", "story_v_side_old_924011.awb")
					end

					arg_715_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011172", "story_v_side_old_924011.awb")
				end

				arg_715_1:RecordContent(arg_715_1.text_.text)
			end

			local var_718_31 = math.max(var_718_22, arg_715_1.talkMaxDuration)

			if var_718_21 <= arg_715_1.time_ and arg_715_1.time_ < var_718_21 + var_718_31 then
				arg_715_1.typewritter.percent = (arg_715_1.time_ - var_718_21) / var_718_31

				arg_715_1.typewritter:SetDirty()
			end

			if arg_715_1.time_ >= var_718_21 + var_718_31 and arg_715_1.time_ < var_718_21 + var_718_31 + arg_718_0 then
				arg_715_1.typewritter.percent = 1

				arg_715_1.typewritter:SetDirty()
				arg_715_1:ShowNextGo(true)
			end
		end

		arg_715_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_715_1:InitPlayNodeList()
	end,
	Play924011173 = function(arg_719_0, arg_719_1)
		arg_719_1.time_ = 0
		arg_719_1.frameCnt_ = 0
		arg_719_1.state_ = "playing"
		arg_719_1.curTalkId_ = 924011173
		arg_719_1.duration_ = 5

		SetActive(arg_719_1.tipsGo_, false)

		function arg_719_1.onSingleLineFinish_()
			arg_719_1.onSingleLineUpdate_ = nil
			arg_719_1.onSingleLineFinish_ = nil
			arg_719_1.state_ = "waiting"
		end

		function arg_719_1.playNext_(arg_721_0)
			if arg_721_0 == 1 then
				arg_719_0:Play924011174(arg_719_1)
			end
		end

		function arg_719_1.onSingleLineUpdate_(arg_722_0)
			local var_722_0 = arg_719_1.actors_["1020ui_story"]
			local var_722_1 = 0

			if var_722_1 < arg_719_1.time_ and arg_719_1.time_ <= var_722_1 + arg_722_0 and not isNil(var_722_0) and arg_719_1.var_.characterEffect1020ui_story == nil then
				arg_719_1.var_.characterEffect1020ui_story = var_722_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_722_2 = 0.200000002980232

			if var_722_1 <= arg_719_1.time_ and arg_719_1.time_ < var_722_1 + var_722_2 and not isNil(var_722_0) then
				local var_722_3 = (arg_719_1.time_ - var_722_1) / var_722_2

				if arg_719_1.var_.characterEffect1020ui_story and not isNil(var_722_0) then
					local var_722_4 = Mathf.Lerp(0, 0.5, var_722_3)

					arg_719_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_719_1.var_.characterEffect1020ui_story.fillRatio = var_722_4
				end
			end

			if arg_719_1.time_ >= var_722_1 + var_722_2 and arg_719_1.time_ < var_722_1 + var_722_2 + arg_722_0 and not isNil(var_722_0) and arg_719_1.var_.characterEffect1020ui_story then
				local var_722_5 = 0.5

				arg_719_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_719_1.var_.characterEffect1020ui_story.fillRatio = var_722_5
			end

			local var_722_6 = 0
			local var_722_7 = 0.1

			if var_722_6 < arg_719_1.time_ and arg_719_1.time_ <= var_722_6 + arg_722_0 then
				arg_719_1.talkMaxDuration = 0
				arg_719_1.dialogCg_.alpha = 1

				arg_719_1.dialog_:SetActive(true)
				SetActive(arg_719_1.leftNameGo_, true)

				local var_722_8 = arg_719_1:FormatText(StoryNameCfg[7].name)

				arg_719_1.leftNameTxt_.text = var_722_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_719_1.leftNameTxt_.transform)

				arg_719_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_719_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_719_1:RecordName(arg_719_1.leftNameTxt_.text)
				SetActive(arg_719_1.iconTrs_.gameObject, true)
				arg_719_1.iconController_:SetSelectedState("hero")

				arg_719_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_719_1.callingController_:SetSelectedState("normal")

				arg_719_1.keyicon_.color = Color.New(1, 1, 1)
				arg_719_1.icon_.color = Color.New(1, 1, 1)

				local var_722_9 = arg_719_1:GetWordFromCfg(924011173)
				local var_722_10 = arg_719_1:FormatText(var_722_9.content)

				arg_719_1.text_.text = var_722_10

				LuaForUtil.ClearLinePrefixSymbol(arg_719_1.text_)

				local var_722_11 = 4
				local var_722_12 = utf8.len(var_722_10)
				local var_722_13 = var_722_11 <= 0 and var_722_7 or var_722_7 * (var_722_12 / var_722_11)

				if var_722_13 > 0 and var_722_7 < var_722_13 then
					arg_719_1.talkMaxDuration = var_722_13

					if var_722_13 + var_722_6 > arg_719_1.duration_ then
						arg_719_1.duration_ = var_722_13 + var_722_6
					end
				end

				arg_719_1.text_.text = var_722_10
				arg_719_1.typewritter.percent = 0

				arg_719_1.typewritter:SetDirty()
				arg_719_1:ShowNextGo(false)
				arg_719_1:RecordContent(arg_719_1.text_.text)
			end

			local var_722_14 = math.max(var_722_7, arg_719_1.talkMaxDuration)

			if var_722_6 <= arg_719_1.time_ and arg_719_1.time_ < var_722_6 + var_722_14 then
				arg_719_1.typewritter.percent = (arg_719_1.time_ - var_722_6) / var_722_14

				arg_719_1.typewritter:SetDirty()
			end

			if arg_719_1.time_ >= var_722_6 + var_722_14 and arg_719_1.time_ < var_722_6 + var_722_14 + arg_722_0 then
				arg_719_1.typewritter.percent = 1

				arg_719_1.typewritter:SetDirty()
				arg_719_1:ShowNextGo(true)
			end
		end

		arg_719_1.nodeConfigList_ = {}

		arg_719_1:InitPlayNodeList()
	end,
	Play924011174 = function(arg_723_0, arg_723_1)
		arg_723_1.time_ = 0
		arg_723_1.frameCnt_ = 0
		arg_723_1.state_ = "playing"
		arg_723_1.curTalkId_ = 924011174
		arg_723_1.duration_ = 6.67

		local var_723_0 = {
			zh = 4.2,
			ja = 6.666
		}
		local var_723_1 = manager.audio:GetLocalizationFlag()

		if var_723_0[var_723_1] ~= nil then
			arg_723_1.duration_ = var_723_0[var_723_1]
		end

		SetActive(arg_723_1.tipsGo_, false)

		function arg_723_1.onSingleLineFinish_()
			arg_723_1.onSingleLineUpdate_ = nil
			arg_723_1.onSingleLineFinish_ = nil
			arg_723_1.state_ = "waiting"
		end

		function arg_723_1.playNext_(arg_725_0)
			if arg_725_0 == 1 then
				arg_723_0:Play924011175(arg_723_1)
			end
		end

		function arg_723_1.onSingleLineUpdate_(arg_726_0)
			local var_726_0 = arg_723_1.actors_["1020ui_story"].transform
			local var_726_1 = 0

			if var_726_1 < arg_723_1.time_ and arg_723_1.time_ <= var_726_1 + arg_726_0 then
				arg_723_1.var_.moveOldPos1020ui_story = var_726_0.localPosition
			end

			local var_726_2 = 0.001

			if var_726_1 <= arg_723_1.time_ and arg_723_1.time_ < var_726_1 + var_726_2 then
				local var_726_3 = (arg_723_1.time_ - var_726_1) / var_726_2
				local var_726_4 = Vector3.New(0.7, -0.85, -6.25)

				var_726_0.localPosition = Vector3.Lerp(arg_723_1.var_.moveOldPos1020ui_story, var_726_4, var_726_3)

				local var_726_5 = manager.ui.mainCamera.transform.position - var_726_0.position

				var_726_0.forward = Vector3.New(var_726_5.x, var_726_5.y, var_726_5.z)

				local var_726_6 = var_726_0.localEulerAngles

				var_726_6.z = 0
				var_726_6.x = 0
				var_726_0.localEulerAngles = var_726_6
			end

			if arg_723_1.time_ >= var_726_1 + var_726_2 and arg_723_1.time_ < var_726_1 + var_726_2 + arg_726_0 then
				var_726_0.localPosition = Vector3.New(0.7, -0.85, -6.25)

				local var_726_7 = manager.ui.mainCamera.transform.position - var_726_0.position

				var_726_0.forward = Vector3.New(var_726_7.x, var_726_7.y, var_726_7.z)

				local var_726_8 = var_726_0.localEulerAngles

				var_726_8.z = 0
				var_726_8.x = 0
				var_726_0.localEulerAngles = var_726_8
			end

			local var_726_9 = arg_723_1.actors_["1020ui_story"]
			local var_726_10 = 0

			if var_726_10 < arg_723_1.time_ and arg_723_1.time_ <= var_726_10 + arg_726_0 and not isNil(var_726_9) and arg_723_1.var_.characterEffect1020ui_story == nil then
				arg_723_1.var_.characterEffect1020ui_story = var_726_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_726_11 = 0.200000002980232

			if var_726_10 <= arg_723_1.time_ and arg_723_1.time_ < var_726_10 + var_726_11 and not isNil(var_726_9) then
				local var_726_12 = (arg_723_1.time_ - var_726_10) / var_726_11

				if arg_723_1.var_.characterEffect1020ui_story and not isNil(var_726_9) then
					arg_723_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_723_1.time_ >= var_726_10 + var_726_11 and arg_723_1.time_ < var_726_10 + var_726_11 + arg_726_0 and not isNil(var_726_9) and arg_723_1.var_.characterEffect1020ui_story then
				arg_723_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_726_13 = 0

			if var_726_13 < arg_723_1.time_ and arg_723_1.time_ <= var_726_13 + arg_726_0 then
				arg_723_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_726_14 = 0

			if var_726_14 < arg_723_1.time_ and arg_723_1.time_ <= var_726_14 + arg_726_0 then
				arg_723_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action3_2")
			end

			local var_726_15 = 0
			local var_726_16 = 0.4

			if var_726_15 < arg_723_1.time_ and arg_723_1.time_ <= var_726_15 + arg_726_0 then
				arg_723_1.talkMaxDuration = 0
				arg_723_1.dialogCg_.alpha = 1

				arg_723_1.dialog_:SetActive(true)
				SetActive(arg_723_1.leftNameGo_, true)

				local var_726_17 = arg_723_1:FormatText(StoryNameCfg[613].name)

				arg_723_1.leftNameTxt_.text = var_726_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_723_1.leftNameTxt_.transform)

				arg_723_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_723_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_723_1:RecordName(arg_723_1.leftNameTxt_.text)
				SetActive(arg_723_1.iconTrs_.gameObject, false)
				arg_723_1.callingController_:SetSelectedState("normal")

				local var_726_18 = arg_723_1:GetWordFromCfg(924011174)
				local var_726_19 = arg_723_1:FormatText(var_726_18.content)

				arg_723_1.text_.text = var_726_19

				LuaForUtil.ClearLinePrefixSymbol(arg_723_1.text_)

				local var_726_20 = 16
				local var_726_21 = utf8.len(var_726_19)
				local var_726_22 = var_726_20 <= 0 and var_726_16 or var_726_16 * (var_726_21 / var_726_20)

				if var_726_22 > 0 and var_726_16 < var_726_22 then
					arg_723_1.talkMaxDuration = var_726_22

					if var_726_22 + var_726_15 > arg_723_1.duration_ then
						arg_723_1.duration_ = var_726_22 + var_726_15
					end
				end

				arg_723_1.text_.text = var_726_19
				arg_723_1.typewritter.percent = 0

				arg_723_1.typewritter:SetDirty()
				arg_723_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011174", "story_v_side_old_924011.awb") ~= 0 then
					local var_726_23 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011174", "story_v_side_old_924011.awb") / 1000

					if var_726_23 + var_726_15 > arg_723_1.duration_ then
						arg_723_1.duration_ = var_726_23 + var_726_15
					end

					if var_726_18.prefab_name ~= "" and arg_723_1.actors_[var_726_18.prefab_name] ~= nil then
						local var_726_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_723_1.actors_[var_726_18.prefab_name].transform, "story_v_side_old_924011", "924011174", "story_v_side_old_924011.awb")

						arg_723_1:RecordAudio("924011174", var_726_24)
						arg_723_1:RecordAudio("924011174", var_726_24)
					else
						arg_723_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011174", "story_v_side_old_924011.awb")
					end

					arg_723_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011174", "story_v_side_old_924011.awb")
				end

				arg_723_1:RecordContent(arg_723_1.text_.text)
			end

			local var_726_25 = math.max(var_726_16, arg_723_1.talkMaxDuration)

			if var_726_15 <= arg_723_1.time_ and arg_723_1.time_ < var_726_15 + var_726_25 then
				arg_723_1.typewritter.percent = (arg_723_1.time_ - var_726_15) / var_726_25

				arg_723_1.typewritter:SetDirty()
			end

			if arg_723_1.time_ >= var_726_15 + var_726_25 and arg_723_1.time_ < var_726_15 + var_726_25 + arg_726_0 then
				arg_723_1.typewritter.percent = 1

				arg_723_1.typewritter:SetDirty()
				arg_723_1:ShowNextGo(true)
			end
		end

		arg_723_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_723_1:InitPlayNodeList()
	end,
	Play924011175 = function(arg_727_0, arg_727_1)
		arg_727_1.time_ = 0
		arg_727_1.frameCnt_ = 0
		arg_727_1.state_ = "playing"
		arg_727_1.curTalkId_ = 924011175
		arg_727_1.duration_ = 10.8

		SetActive(arg_727_1.tipsGo_, false)

		function arg_727_1.onSingleLineFinish_()
			arg_727_1.onSingleLineUpdate_ = nil
			arg_727_1.onSingleLineFinish_ = nil
			arg_727_1.state_ = "waiting"
		end

		function arg_727_1.playNext_(arg_729_0)
			if arg_729_0 == 1 then
				arg_727_0:Play924011176(arg_727_1)
			end
		end

		function arg_727_1.onSingleLineUpdate_(arg_730_0)
			local var_730_0 = "STblack"

			if arg_727_1.bgs_[var_730_0] == nil then
				local var_730_1 = Object.Instantiate(arg_727_1.paintGo_)

				var_730_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_730_0)
				var_730_1.name = var_730_0
				var_730_1.transform.parent = arg_727_1.stage_.transform
				var_730_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_727_1.bgs_[var_730_0] = var_730_1
			end

			local var_730_2 = 3

			if var_730_2 < arg_727_1.time_ and arg_727_1.time_ <= var_730_2 + arg_730_0 then
				local var_730_3 = manager.ui.mainCamera.transform.localPosition
				local var_730_4 = Vector3.New(0, 0, 10) + Vector3.New(var_730_3.x, var_730_3.y, 0)
				local var_730_5 = arg_727_1.bgs_.STblack

				var_730_5.transform.localPosition = var_730_4
				var_730_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_730_6 = var_730_5:GetComponent("SpriteRenderer")

				if var_730_6 and var_730_6.sprite then
					local var_730_7 = (var_730_5.transform.localPosition - var_730_3).z
					local var_730_8 = manager.ui.mainCameraCom_
					local var_730_9 = 2 * var_730_7 * Mathf.Tan(var_730_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_730_10 = var_730_9 * var_730_8.aspect
					local var_730_11 = var_730_6.sprite.bounds.size.x
					local var_730_12 = var_730_6.sprite.bounds.size.y
					local var_730_13 = var_730_10 / var_730_11
					local var_730_14 = var_730_9 / var_730_12
					local var_730_15 = var_730_14 < var_730_13 and var_730_13 or var_730_14

					var_730_5.transform.localScale = Vector3.New(var_730_15, var_730_15, 0)
				end

				for iter_730_0, iter_730_1 in pairs(arg_727_1.bgs_) do
					if iter_730_0 ~= "STblack" then
						iter_730_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_730_16 = 5.999999999999

			if var_730_16 < arg_727_1.time_ and arg_727_1.time_ <= var_730_16 + arg_730_0 then
				arg_727_1.allBtn_.enabled = false
			end

			local var_730_17 = 0.3

			if arg_727_1.time_ >= var_730_16 + var_730_17 and arg_727_1.time_ < var_730_16 + var_730_17 + arg_730_0 then
				arg_727_1.allBtn_.enabled = true
			end

			local var_730_18 = 0

			if var_730_18 < arg_727_1.time_ and arg_727_1.time_ <= var_730_18 + arg_730_0 then
				arg_727_1.mask_.enabled = true
				arg_727_1.mask_.raycastTarget = true

				arg_727_1:SetGaussion(false)
			end

			local var_730_19 = 3

			if var_730_18 <= arg_727_1.time_ and arg_727_1.time_ < var_730_18 + var_730_19 then
				local var_730_20 = (arg_727_1.time_ - var_730_18) / var_730_19
				local var_730_21 = Color.New(0, 0, 0)

				var_730_21.a = Mathf.Lerp(0, 1, var_730_20)
				arg_727_1.mask_.color = var_730_21
			end

			if arg_727_1.time_ >= var_730_18 + var_730_19 and arg_727_1.time_ < var_730_18 + var_730_19 + arg_730_0 then
				local var_730_22 = Color.New(0, 0, 0)

				var_730_22.a = 1
				arg_727_1.mask_.color = var_730_22
			end

			local var_730_23 = 3

			if var_730_23 < arg_727_1.time_ and arg_727_1.time_ <= var_730_23 + arg_730_0 then
				arg_727_1.mask_.enabled = true
				arg_727_1.mask_.raycastTarget = true

				arg_727_1:SetGaussion(false)
			end

			local var_730_24 = 3

			if var_730_23 <= arg_727_1.time_ and arg_727_1.time_ < var_730_23 + var_730_24 then
				local var_730_25 = (arg_727_1.time_ - var_730_23) / var_730_24
				local var_730_26 = Color.New(0, 0, 0)

				var_730_26.a = Mathf.Lerp(1, 0, var_730_25)
				arg_727_1.mask_.color = var_730_26
			end

			if arg_727_1.time_ >= var_730_23 + var_730_24 and arg_727_1.time_ < var_730_23 + var_730_24 + arg_730_0 then
				local var_730_27 = Color.New(0, 0, 0)
				local var_730_28 = 0

				arg_727_1.mask_.enabled = false
				var_730_27.a = var_730_28
				arg_727_1.mask_.color = var_730_27
			end

			local var_730_29 = arg_727_1.actors_["1020ui_story"].transform
			local var_730_30 = 2.96599999815226

			if var_730_30 < arg_727_1.time_ and arg_727_1.time_ <= var_730_30 + arg_730_0 then
				arg_727_1.var_.moveOldPos1020ui_story = var_730_29.localPosition
			end

			local var_730_31 = 0.001

			if var_730_30 <= arg_727_1.time_ and arg_727_1.time_ < var_730_30 + var_730_31 then
				local var_730_32 = (arg_727_1.time_ - var_730_30) / var_730_31
				local var_730_33 = Vector3.New(0, 100, 0)

				var_730_29.localPosition = Vector3.Lerp(arg_727_1.var_.moveOldPos1020ui_story, var_730_33, var_730_32)

				local var_730_34 = manager.ui.mainCamera.transform.position - var_730_29.position

				var_730_29.forward = Vector3.New(var_730_34.x, var_730_34.y, var_730_34.z)

				local var_730_35 = var_730_29.localEulerAngles

				var_730_35.z = 0
				var_730_35.x = 0
				var_730_29.localEulerAngles = var_730_35
			end

			if arg_727_1.time_ >= var_730_30 + var_730_31 and arg_727_1.time_ < var_730_30 + var_730_31 + arg_730_0 then
				var_730_29.localPosition = Vector3.New(0, 100, 0)

				local var_730_36 = manager.ui.mainCamera.transform.position - var_730_29.position

				var_730_29.forward = Vector3.New(var_730_36.x, var_730_36.y, var_730_36.z)

				local var_730_37 = var_730_29.localEulerAngles

				var_730_37.z = 0
				var_730_37.x = 0
				var_730_29.localEulerAngles = var_730_37
			end

			local var_730_38 = arg_727_1.actors_["1033ui_story"].transform
			local var_730_39 = 2.96599999815226

			if var_730_39 < arg_727_1.time_ and arg_727_1.time_ <= var_730_39 + arg_730_0 then
				arg_727_1.var_.moveOldPos1033ui_story = var_730_38.localPosition
			end

			local var_730_40 = 0.001

			if var_730_39 <= arg_727_1.time_ and arg_727_1.time_ < var_730_39 + var_730_40 then
				local var_730_41 = (arg_727_1.time_ - var_730_39) / var_730_40
				local var_730_42 = Vector3.New(0, 100, 0)

				var_730_38.localPosition = Vector3.Lerp(arg_727_1.var_.moveOldPos1033ui_story, var_730_42, var_730_41)

				local var_730_43 = manager.ui.mainCamera.transform.position - var_730_38.position

				var_730_38.forward = Vector3.New(var_730_43.x, var_730_43.y, var_730_43.z)

				local var_730_44 = var_730_38.localEulerAngles

				var_730_44.z = 0
				var_730_44.x = 0
				var_730_38.localEulerAngles = var_730_44
			end

			if arg_727_1.time_ >= var_730_39 + var_730_40 and arg_727_1.time_ < var_730_39 + var_730_40 + arg_730_0 then
				var_730_38.localPosition = Vector3.New(0, 100, 0)

				local var_730_45 = manager.ui.mainCamera.transform.position - var_730_38.position

				var_730_38.forward = Vector3.New(var_730_45.x, var_730_45.y, var_730_45.z)

				local var_730_46 = var_730_38.localEulerAngles

				var_730_46.z = 0
				var_730_46.x = 0
				var_730_38.localEulerAngles = var_730_46
			end

			local var_730_47 = arg_727_1.actors_["1020ui_story"]
			local var_730_48 = 2.96599999815226

			if var_730_48 < arg_727_1.time_ and arg_727_1.time_ <= var_730_48 + arg_730_0 and not isNil(var_730_47) and arg_727_1.var_.characterEffect1020ui_story == nil then
				arg_727_1.var_.characterEffect1020ui_story = var_730_47:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_730_49 = 0.034000001847744

			if var_730_48 <= arg_727_1.time_ and arg_727_1.time_ < var_730_48 + var_730_49 and not isNil(var_730_47) then
				local var_730_50 = (arg_727_1.time_ - var_730_48) / var_730_49

				if arg_727_1.var_.characterEffect1020ui_story and not isNil(var_730_47) then
					local var_730_51 = Mathf.Lerp(0, 0.5, var_730_50)

					arg_727_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_727_1.var_.characterEffect1020ui_story.fillRatio = var_730_51
				end
			end

			if arg_727_1.time_ >= var_730_48 + var_730_49 and arg_727_1.time_ < var_730_48 + var_730_49 + arg_730_0 and not isNil(var_730_47) and arg_727_1.var_.characterEffect1020ui_story then
				local var_730_52 = 0.5

				arg_727_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_727_1.var_.characterEffect1020ui_story.fillRatio = var_730_52
			end

			if arg_727_1.frameCnt_ <= 1 then
				arg_727_1.dialog_:SetActive(false)
			end

			local var_730_53 = 5.8
			local var_730_54 = 1.075

			if var_730_53 < arg_727_1.time_ and arg_727_1.time_ <= var_730_53 + arg_730_0 then
				arg_727_1.talkMaxDuration = 0

				arg_727_1.dialog_:SetActive(true)

				arg_727_1.dialogCg_.alpha = 0

				local var_730_55 = LeanTween.value(arg_727_1.dialog_, 0, 1, 0.3)

				var_730_55:setOnUpdate(LuaHelper.FloatAction(function(arg_731_0)
					arg_727_1.dialogCg_.alpha = arg_731_0
				end))
				var_730_55:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_727_1.dialog_)
					var_730_55:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_727_1.duration_ = arg_727_1.duration_ + 0.3

				SetActive(arg_727_1.leftNameGo_, false)

				arg_727_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_727_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_727_1:RecordName(arg_727_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_727_1.iconTrs_.gameObject, false)
				arg_727_1.callingController_:SetSelectedState("normal")

				local var_730_56 = arg_727_1:GetWordFromCfg(924011175)
				local var_730_57 = arg_727_1:FormatText(var_730_56.content)

				arg_727_1.text_.text = var_730_57

				LuaForUtil.ClearLinePrefixSymbol(arg_727_1.text_)

				local var_730_58 = 43
				local var_730_59 = utf8.len(var_730_57)
				local var_730_60 = var_730_58 <= 0 and var_730_54 or var_730_54 * (var_730_59 / var_730_58)

				if var_730_60 > 0 and var_730_54 < var_730_60 then
					arg_727_1.talkMaxDuration = var_730_60
					var_730_53 = var_730_53 + 0.3

					if var_730_60 + var_730_53 > arg_727_1.duration_ then
						arg_727_1.duration_ = var_730_60 + var_730_53
					end
				end

				arg_727_1.text_.text = var_730_57
				arg_727_1.typewritter.percent = 0

				arg_727_1.typewritter:SetDirty()
				arg_727_1:ShowNextGo(false)
				arg_727_1:RecordContent(arg_727_1.text_.text)
			end

			local var_730_61 = var_730_53 + 0.3
			local var_730_62 = math.max(var_730_54, arg_727_1.talkMaxDuration)

			if var_730_61 <= arg_727_1.time_ and arg_727_1.time_ < var_730_61 + var_730_62 then
				arg_727_1.typewritter.percent = (arg_727_1.time_ - var_730_61) / var_730_62

				arg_727_1.typewritter:SetDirty()
			end

			if arg_727_1.time_ >= var_730_61 + var_730_62 and arg_727_1.time_ < var_730_61 + var_730_62 + arg_730_0 then
				arg_727_1.typewritter.percent = 1

				arg_727_1.typewritter:SetDirty()
				arg_727_1:ShowNextGo(true)
			end
		end

		arg_727_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_727_1:InitPlayNodeList()
	end,
	Play924011176 = function(arg_733_0, arg_733_1)
		arg_733_1.time_ = 0
		arg_733_1.frameCnt_ = 0
		arg_733_1.state_ = "playing"
		arg_733_1.curTalkId_ = 924011176
		arg_733_1.duration_ = 5

		SetActive(arg_733_1.tipsGo_, false)

		function arg_733_1.onSingleLineFinish_()
			arg_733_1.onSingleLineUpdate_ = nil
			arg_733_1.onSingleLineFinish_ = nil
			arg_733_1.state_ = "waiting"
			arg_733_1.auto_ = false
		end

		function arg_733_1.playNext_(arg_735_0)
			arg_733_1.onStoryFinished_()
		end

		function arg_733_1.onSingleLineUpdate_(arg_736_0)
			local var_736_0 = 5.55111512312578e-17
			local var_736_1 = 1

			if var_736_0 < arg_733_1.time_ and arg_733_1.time_ <= var_736_0 + arg_736_0 then
				local var_736_2 = "play"
				local var_736_3 = "effect"

				arg_733_1:AudioAction(var_736_2, var_736_3, "se_story_140", "se_story_140_tinnitus", "")
			end

			local var_736_4 = 5.55111512312578e-17
			local var_736_5 = 1

			if var_736_4 < arg_733_1.time_ and arg_733_1.time_ <= var_736_4 + arg_736_0 then
				local var_736_6 = "play"
				local var_736_7 = "effect"

				arg_733_1:AudioAction(var_736_6, var_736_7, "se_story_141", "se_story_141_boxing_drum03", "")
			end

			local var_736_8 = 0
			local var_736_9 = 0.675

			if var_736_8 < arg_733_1.time_ and arg_733_1.time_ <= var_736_8 + arg_736_0 then
				arg_733_1.talkMaxDuration = 0
				arg_733_1.dialogCg_.alpha = 1

				arg_733_1.dialog_:SetActive(true)
				SetActive(arg_733_1.leftNameGo_, false)

				arg_733_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_733_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_733_1:RecordName(arg_733_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_733_1.iconTrs_.gameObject, false)
				arg_733_1.callingController_:SetSelectedState("normal")

				local var_736_10 = arg_733_1:GetWordFromCfg(924011176)
				local var_736_11 = arg_733_1:FormatText(var_736_10.content)

				arg_733_1.text_.text = var_736_11

				LuaForUtil.ClearLinePrefixSymbol(arg_733_1.text_)

				local var_736_12 = 27
				local var_736_13 = utf8.len(var_736_11)
				local var_736_14 = var_736_12 <= 0 and var_736_9 or var_736_9 * (var_736_13 / var_736_12)

				if var_736_14 > 0 and var_736_9 < var_736_14 then
					arg_733_1.talkMaxDuration = var_736_14

					if var_736_14 + var_736_8 > arg_733_1.duration_ then
						arg_733_1.duration_ = var_736_14 + var_736_8
					end
				end

				arg_733_1.text_.text = var_736_11
				arg_733_1.typewritter.percent = 0

				arg_733_1.typewritter:SetDirty()
				arg_733_1:ShowNextGo(false)
				arg_733_1:RecordContent(arg_733_1.text_.text)
			end

			local var_736_15 = math.max(var_736_9, arg_733_1.talkMaxDuration)

			if var_736_8 <= arg_733_1.time_ and arg_733_1.time_ < var_736_8 + var_736_15 then
				arg_733_1.typewritter.percent = (arg_733_1.time_ - var_736_8) / var_736_15

				arg_733_1.typewritter:SetDirty()
			end

			if arg_733_1.time_ >= var_736_8 + var_736_15 and arg_733_1.time_ < var_736_8 + var_736_15 + arg_736_0 then
				arg_733_1.typewritter.percent = 1

				arg_733_1.typewritter:SetDirty()
				arg_733_1:ShowNextGo(true)
			end
		end

		arg_733_1.nodeConfigList_ = {}

		arg_733_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST60",
		"TextureConfig/Background/ST2201",
		"TextureConfig/Background/ST12",
		"TextureConfig/Background/ST01",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_side_old_924011.awb"
	}
}
