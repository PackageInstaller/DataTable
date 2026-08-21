return {
	Play416191001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 416191001
		arg_1_1.duration_ = 9.1

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play416191002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "STwhite"

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
				local var_4_5 = arg_1_1.bgs_.STwhite

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
					if iter_4_0 ~= "STwhite" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 0

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

				local var_4_25 = arg_1_1:GetWordFromCfg(416191001)
				local var_4_26 = arg_1_1:FormatText(var_4_25.content)

				arg_1_1.fswt_.text = var_4_26

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.fswt_)

				arg_1_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)
				arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_1_1.fswtw_:SetDirty()

				arg_1_1.typewritterCharCountI18N = 0

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_27 = 1.1

			if var_4_27 < arg_1_1.time_ and arg_1_1.time_ <= var_4_27 + arg_4_0 then
				arg_1_1.var_.oldValueTypewriter = arg_1_1.fswtw_.percent

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_28 = 28
			local var_4_29 = 1.86666666666667
			local var_4_30 = arg_1_1:GetWordFromCfg(416191001)
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

			local var_4_35 = 1.86666666666667
			local var_4_36 = math.max(var_4_35, arg_1_1.talkMaxDuration)

			if var_4_27 <= arg_1_1.time_ and arg_1_1.time_ < var_4_27 + var_4_36 then
				local var_4_37 = (arg_1_1.time_ - var_4_27) / var_4_36

				arg_1_1.fswtw_.percent = Mathf.Lerp(arg_1_1.var_.oldValueTypewriter, var_4_32, var_4_37)
				arg_1_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_1_1.fswtw_:SetDirty()
			end

			if arg_1_1.time_ >= var_4_27 + var_4_36 and arg_1_1.time_ < var_4_27 + var_4_36 + arg_4_0 then
				arg_1_1.fswtw_.percent = var_4_32

				arg_1_1.fswtw_:SetDirty()
				arg_1_1:ShowNextGo(true)

				arg_1_1.typewritterCharCountI18N = var_4_33
			end

			local var_4_38 = 0

			if var_4_38 < arg_1_1.time_ and arg_1_1.time_ <= var_4_38 + arg_4_0 then
				local var_4_39 = arg_1_1.fswbg_.transform:Find("textbox/adapt/content") or arg_1_1.fswbg_.transform:Find("textbox/content")
				local var_4_40 = arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_4_41 = var_4_39:GetComponent("Text")
				local var_4_42 = var_4_39:GetComponent("RectTransform")

				var_4_41.alignment = UnityEngine.TextAnchor.MiddleLeft
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

			local var_4_49 = 0.5
			local var_4_50 = 8.6
			local var_4_51 = manager.audio:GetVoiceLength("story_v_out_416191", "416191001", "story_v_out_416191.awb") / 1000

			if var_4_51 > 0 and var_4_50 < var_4_51 and var_4_51 + var_4_49 > arg_1_1.duration_ then
				local var_4_52 = var_4_51

				arg_1_1.duration_ = var_4_51 + var_4_49
			end

			if var_4_49 < arg_1_1.time_ and arg_1_1.time_ <= var_4_49 + arg_4_0 then
				local var_4_53 = "play"
				local var_4_54 = "voice"

				arg_1_1:AudioAction(var_4_53, var_4_54, "story_v_out_416191", "416191001", "story_v_out_416191.awb")
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play416191002 = function(arg_6_0, arg_6_1)
		arg_6_1.time_ = 0
		arg_6_1.frameCnt_ = 0
		arg_6_1.state_ = "playing"
		arg_6_1.curTalkId_ = 416191002
		arg_6_1.duration_ = 10.5

		SetActive(arg_6_1.tipsGo_, false)

		function arg_6_1.onSingleLineFinish_()
			arg_6_1.onSingleLineUpdate_ = nil
			arg_6_1.onSingleLineFinish_ = nil
			arg_6_1.state_ = "waiting"
		end

		function arg_6_1.playNext_(arg_8_0)
			if arg_8_0 == 1 then
				arg_6_0:Play416191003(arg_6_1)
			end
		end

		function arg_6_1.onSingleLineUpdate_(arg_9_0)
			local var_9_0 = 0

			if var_9_0 < arg_6_1.time_ and arg_6_1.time_ <= var_9_0 + arg_9_0 then
				arg_6_1.fswbg_:SetActive(true)
				arg_6_1.dialog_:SetActive(false)

				arg_6_1.fswtw_.percent = 0

				local var_9_1 = arg_6_1:GetWordFromCfg(416191002)
				local var_9_2 = arg_6_1:FormatText(var_9_1.content)

				arg_6_1.fswt_.text = var_9_2

				LuaForUtil.ClearLinePrefixSymbol(arg_6_1.fswt_)

				arg_6_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)
				arg_6_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_6_1.fswtw_:SetDirty()

				arg_6_1.typewritterCharCountI18N = 0

				SetActive(arg_6_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_6_1:ShowNextGo(false)
			end

			local var_9_3 = 0.533333333333333

			if var_9_3 < arg_6_1.time_ and arg_6_1.time_ <= var_9_3 + arg_9_0 then
				arg_6_1.var_.oldValueTypewriter = arg_6_1.fswtw_.percent

				SetActive(arg_6_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_6_1:ShowNextGo(false)
			end

			local var_9_4 = 36
			local var_9_5 = 2.4
			local var_9_6 = arg_6_1:GetWordFromCfg(416191002)
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

			local var_9_11 = 2.4
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

			local var_9_14 = 0.333333333333333
			local var_9_15 = 10.166
			local var_9_16 = manager.audio:GetVoiceLength("story_v_out_416191", "416191002", "story_v_out_416191.awb") / 1000

			if var_9_16 > 0 and var_9_15 < var_9_16 and var_9_16 + var_9_14 > arg_6_1.duration_ then
				local var_9_17 = var_9_16

				arg_6_1.duration_ = var_9_16 + var_9_14
			end

			if var_9_14 < arg_6_1.time_ and arg_6_1.time_ <= var_9_14 + arg_9_0 then
				local var_9_18 = "play"
				local var_9_19 = "voice"

				arg_6_1:AudioAction(var_9_18, var_9_19, "story_v_out_416191", "416191002", "story_v_out_416191.awb")
			end
		end

		arg_6_1.nodeConfigList_ = {}

		arg_6_1:InitPlayNodeList()
	end,
	Play416191003 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 416191003
		arg_10_1.duration_ = 12.03

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play416191004(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			local var_13_0 = 0

			if var_13_0 < arg_10_1.time_ and arg_10_1.time_ <= var_13_0 + arg_13_0 then
				arg_10_1.fswbg_:SetActive(true)
				arg_10_1.dialog_:SetActive(false)

				arg_10_1.fswtw_.percent = 0

				local var_13_1 = arg_10_1:GetWordFromCfg(416191003)
				local var_13_2 = arg_10_1:FormatText(var_13_1.content)

				arg_10_1.fswt_.text = var_13_2

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.fswt_)

				arg_10_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)
				arg_10_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_10_1.fswtw_:SetDirty()

				arg_10_1.typewritterCharCountI18N = 0

				SetActive(arg_10_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_10_1:ShowNextGo(false)
			end

			local var_13_3 = 0.633333333333333

			if var_13_3 < arg_10_1.time_ and arg_10_1.time_ <= var_13_3 + arg_13_0 then
				arg_10_1.var_.oldValueTypewriter = arg_10_1.fswtw_.percent

				SetActive(arg_10_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_10_1:ShowNextGo(false)
			end

			local var_13_4 = 32
			local var_13_5 = 2.4
			local var_13_6 = arg_10_1:GetWordFromCfg(416191003)
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

			local var_13_11 = 2.4
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

			local var_13_14 = 0.333333333333333
			local var_13_15 = 11.7
			local var_13_16 = manager.audio:GetVoiceLength("story_v_out_416191", "416191003", "story_v_out_416191.awb") / 1000

			if var_13_16 > 0 and var_13_15 < var_13_16 and var_13_16 + var_13_14 > arg_10_1.duration_ then
				local var_13_17 = var_13_16

				arg_10_1.duration_ = var_13_16 + var_13_14
			end

			if var_13_14 < arg_10_1.time_ and arg_10_1.time_ <= var_13_14 + arg_13_0 then
				local var_13_18 = "play"
				local var_13_19 = "voice"

				arg_10_1:AudioAction(var_13_18, var_13_19, "story_v_out_416191", "416191003", "story_v_out_416191.awb")
			end
		end

		arg_10_1.nodeConfigList_ = {}

		arg_10_1:InitPlayNodeList()
	end,
	Play416191004 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 416191004
		arg_14_1.duration_ = 8.57

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play416191005(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = 0

			if var_17_0 < arg_14_1.time_ and arg_14_1.time_ <= var_17_0 + arg_17_0 then
				arg_14_1.fswbg_:SetActive(true)
				arg_14_1.dialog_:SetActive(false)

				arg_14_1.fswtw_.percent = 0

				local var_17_1 = arg_14_1:GetWordFromCfg(416191004)
				local var_17_2 = arg_14_1:FormatText(var_17_1.content)

				arg_14_1.fswt_.text = var_17_2

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.fswt_)

				arg_14_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)
				arg_14_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_14_1.fswtw_:SetDirty()

				arg_14_1.typewritterCharCountI18N = 0

				SetActive(arg_14_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_14_1:ShowNextGo(false)
			end

			local var_17_3 = 0.633333333333333

			if var_17_3 < arg_14_1.time_ and arg_14_1.time_ <= var_17_3 + arg_17_0 then
				arg_14_1.var_.oldValueTypewriter = arg_14_1.fswtw_.percent

				SetActive(arg_14_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_14_1:ShowNextGo(false)
			end

			local var_17_4 = 29
			local var_17_5 = 1.93333333333333
			local var_17_6 = arg_14_1:GetWordFromCfg(416191004)
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

			local var_17_11 = 1.93333333333333
			local var_17_12 = math.max(var_17_11, arg_14_1.talkMaxDuration)

			if var_17_3 <= arg_14_1.time_ and arg_14_1.time_ < var_17_3 + var_17_12 then
				local var_17_13 = (arg_14_1.time_ - var_17_3) / var_17_12

				arg_14_1.fswtw_.percent = Mathf.Lerp(arg_14_1.var_.oldValueTypewriter, var_17_8, var_17_13)
				arg_14_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_14_1.fswtw_:SetDirty()
			end

			if arg_14_1.time_ >= var_17_3 + var_17_12 and arg_14_1.time_ < var_17_3 + var_17_12 + arg_17_0 then
				arg_14_1.fswtw_.percent = var_17_8

				arg_14_1.fswtw_:SetDirty()
				arg_14_1:ShowNextGo(true)

				arg_14_1.typewritterCharCountI18N = var_17_9
			end

			local var_17_14 = 0.366666666666667
			local var_17_15 = 8.2
			local var_17_16 = manager.audio:GetVoiceLength("story_v_out_416191", "416191004", "story_v_out_416191.awb") / 1000

			if var_17_16 > 0 and var_17_15 < var_17_16 and var_17_16 + var_17_14 > arg_14_1.duration_ then
				local var_17_17 = var_17_16

				arg_14_1.duration_ = var_17_16 + var_17_14
			end

			if var_17_14 < arg_14_1.time_ and arg_14_1.time_ <= var_17_14 + arg_17_0 then
				local var_17_18 = "play"
				local var_17_19 = "voice"

				arg_14_1:AudioAction(var_17_18, var_17_19, "story_v_out_416191", "416191004", "story_v_out_416191.awb")
			end

			local var_17_20 = 0.633333333333333

			if var_17_20 < arg_14_1.time_ and arg_14_1.time_ <= var_17_20 + arg_17_0 then
				arg_14_1.allBtn_.enabled = false
			end

			local var_17_21 = 3.53333333333333

			if arg_14_1.time_ >= var_17_20 + var_17_21 and arg_14_1.time_ < var_17_20 + var_17_21 + arg_17_0 then
				arg_14_1.allBtn_.enabled = true
			end
		end

		arg_14_1.nodeConfigList_ = {}

		arg_14_1:InitPlayNodeList()
	end,
	Play416191005 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 416191005
		arg_18_1.duration_ = 6.9

		local var_18_0 = {
			zh = 6.9,
			ja = 5.766
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
				arg_18_0:Play416191006(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = 0

			if var_21_0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_0 + arg_21_0 then
				arg_18_1.mask_.enabled = true
				arg_18_1.mask_.raycastTarget = true

				arg_18_1:SetGaussion(false)
			end

			local var_21_1 = 0.466666666666667

			if var_21_0 <= arg_18_1.time_ and arg_18_1.time_ < var_21_0 + var_21_1 then
				local var_21_2 = (arg_18_1.time_ - var_21_0) / var_21_1
				local var_21_3 = Color.New(0, 0, 0)

				var_21_3.a = Mathf.Lerp(0, 1, var_21_2)
				arg_18_1.mask_.color = var_21_3
			end

			if arg_18_1.time_ >= var_21_0 + var_21_1 and arg_18_1.time_ < var_21_0 + var_21_1 + arg_21_0 then
				local var_21_4 = Color.New(0, 0, 0)

				var_21_4.a = 1
				arg_18_1.mask_.color = var_21_4
			end

			local var_21_5 = 0.466666666666667

			if var_21_5 < arg_18_1.time_ and arg_18_1.time_ <= var_21_5 + arg_21_0 then
				arg_18_1.mask_.enabled = true
				arg_18_1.mask_.raycastTarget = true

				arg_18_1:SetGaussion(false)
			end

			local var_21_6 = 1.53333333333333

			if var_21_5 <= arg_18_1.time_ and arg_18_1.time_ < var_21_5 + var_21_6 then
				local var_21_7 = (arg_18_1.time_ - var_21_5) / var_21_6
				local var_21_8 = Color.New(0, 0, 0)

				var_21_8.a = Mathf.Lerp(1, 0, var_21_7)
				arg_18_1.mask_.color = var_21_8
			end

			if arg_18_1.time_ >= var_21_5 + var_21_6 and arg_18_1.time_ < var_21_5 + var_21_6 + arg_21_0 then
				local var_21_9 = Color.New(0, 0, 0)
				local var_21_10 = 0

				arg_18_1.mask_.enabled = false
				var_21_9.a = var_21_10
				arg_18_1.mask_.color = var_21_9
			end

			local var_21_11 = 0.466666666666667

			if var_21_11 < arg_18_1.time_ and arg_18_1.time_ <= var_21_11 + arg_21_0 then
				arg_18_1.fswbg_:SetActive(false)
				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_18_1:ShowNextGo(false)
			end

			local var_21_12 = 0.483333333333333

			if var_21_12 < arg_18_1.time_ and arg_18_1.time_ <= var_21_12 + arg_21_0 then
				arg_18_1.fswbg_:SetActive(false)
				arg_18_1.dialog_:SetActive(false)
				SetActive(arg_18_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_18_1:ShowNextGo(false)
			end

			if arg_18_1.frameCnt_ <= 1 then
				arg_18_1.dialog_:SetActive(false)
			end

			local var_21_13 = 1.7
			local var_21_14 = 0.375

			if var_21_13 < arg_18_1.time_ and arg_18_1.time_ <= var_21_13 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0

				arg_18_1.dialog_:SetActive(true)

				arg_18_1.dialogCg_.alpha = 0

				local var_21_15 = LeanTween.value(arg_18_1.dialog_, 0, 1, 0.3)

				var_21_15:setOnUpdate(LuaHelper.FloatAction(function(arg_22_0)
					arg_18_1.dialogCg_.alpha = arg_22_0
				end))
				var_21_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_18_1.dialog_)
					var_21_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_18_1.duration_ = arg_18_1.duration_ + 0.3

				SetActive(arg_18_1.leftNameGo_, true)

				local var_21_16 = arg_18_1:FormatText(StoryNameCfg[1080].name)

				arg_18_1.leftNameTxt_.text = var_21_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, true)
				arg_18_1.iconController_:SetSelectedState("hero")

				arg_18_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1086_split_6")

				arg_18_1.callingController_:SetSelectedState("normal")

				arg_18_1.keyicon_.color = Color.New(1, 1, 1)
				arg_18_1.icon_.color = Color.New(1, 1, 1)

				local var_21_17 = arg_18_1:GetWordFromCfg(416191005)
				local var_21_18 = arg_18_1:FormatText(var_21_17.content)

				arg_18_1.text_.text = var_21_18

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_19 = 15
				local var_21_20 = utf8.len(var_21_18)
				local var_21_21 = var_21_19 <= 0 and var_21_14 or var_21_14 * (var_21_20 / var_21_19)

				if var_21_21 > 0 and var_21_14 < var_21_21 then
					arg_18_1.talkMaxDuration = var_21_21
					var_21_13 = var_21_13 + 0.3

					if var_21_21 + var_21_13 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_21 + var_21_13
					end
				end

				arg_18_1.text_.text = var_21_18
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191005", "story_v_out_416191.awb") ~= 0 then
					local var_21_22 = manager.audio:GetVoiceLength("story_v_out_416191", "416191005", "story_v_out_416191.awb") / 1000

					if var_21_22 + var_21_13 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_22 + var_21_13
					end

					if var_21_17.prefab_name ~= "" and arg_18_1.actors_[var_21_17.prefab_name] ~= nil then
						local var_21_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_17.prefab_name].transform, "story_v_out_416191", "416191005", "story_v_out_416191.awb")

						arg_18_1:RecordAudio("416191005", var_21_23)
						arg_18_1:RecordAudio("416191005", var_21_23)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_416191", "416191005", "story_v_out_416191.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_416191", "416191005", "story_v_out_416191.awb")
				end

				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_24 = var_21_13 + 0.3
			local var_21_25 = math.max(var_21_14, arg_18_1.talkMaxDuration)

			if var_21_24 <= arg_18_1.time_ and arg_18_1.time_ < var_21_24 + var_21_25 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_24) / var_21_25

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_24 + var_21_25 and arg_18_1.time_ < var_21_24 + var_21_25 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play416191006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 416191006
		arg_24_1.duration_ = 2.37

		local var_24_0 = {
			zh = 1.5,
			ja = 2.366
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
				arg_24_0:Play416191007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0
			local var_27_1 = 0.125

			if var_27_0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_2 = arg_24_1:FormatText(StoryNameCfg[1080].name)

				arg_24_1.leftNameTxt_.text = var_27_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1086_split_3")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_3 = arg_24_1:GetWordFromCfg(416191006)
				local var_27_4 = arg_24_1:FormatText(var_27_3.content)

				arg_24_1.text_.text = var_27_4

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_5 = 5
				local var_27_6 = utf8.len(var_27_4)
				local var_27_7 = var_27_5 <= 0 and var_27_1 or var_27_1 * (var_27_6 / var_27_5)

				if var_27_7 > 0 and var_27_1 < var_27_7 then
					arg_24_1.talkMaxDuration = var_27_7

					if var_27_7 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_7 + var_27_0
					end
				end

				arg_24_1.text_.text = var_27_4
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191006", "story_v_out_416191.awb") ~= 0 then
					local var_27_8 = manager.audio:GetVoiceLength("story_v_out_416191", "416191006", "story_v_out_416191.awb") / 1000

					if var_27_8 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_8 + var_27_0
					end

					if var_27_3.prefab_name ~= "" and arg_24_1.actors_[var_27_3.prefab_name] ~= nil then
						local var_27_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_3.prefab_name].transform, "story_v_out_416191", "416191006", "story_v_out_416191.awb")

						arg_24_1:RecordAudio("416191006", var_27_9)
						arg_24_1:RecordAudio("416191006", var_27_9)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_416191", "416191006", "story_v_out_416191.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_416191", "416191006", "story_v_out_416191.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_10 = math.max(var_27_1, arg_24_1.talkMaxDuration)

			if var_27_0 <= arg_24_1.time_ and arg_24_1.time_ < var_27_0 + var_27_10 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_0) / var_27_10

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_0 + var_27_10 and arg_24_1.time_ < var_27_0 + var_27_10 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play416191007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 416191007
		arg_28_1.duration_ = 7.8

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play416191008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = "SS1608"

			if arg_28_1.bgs_[var_31_0] == nil then
				local var_31_1 = Object.Instantiate(arg_28_1.paintGo_)

				var_31_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_31_0)
				var_31_1.name = var_31_0
				var_31_1.transform.parent = arg_28_1.stage_.transform
				var_31_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_28_1.bgs_[var_31_0] = var_31_1
			end

			local var_31_2 = 1

			if var_31_2 < arg_28_1.time_ and arg_28_1.time_ <= var_31_2 + arg_31_0 then
				local var_31_3 = manager.ui.mainCamera.transform.localPosition
				local var_31_4 = Vector3.New(0, 0, 10) + Vector3.New(var_31_3.x, var_31_3.y, 0)
				local var_31_5 = arg_28_1.bgs_.SS1608

				var_31_5.transform.localPosition = var_31_4
				var_31_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_31_6 = var_31_5:GetComponent("SpriteRenderer")

				if var_31_6 and var_31_6.sprite then
					local var_31_7 = (var_31_5.transform.localPosition - var_31_3).z
					local var_31_8 = manager.ui.mainCameraCom_
					local var_31_9 = 2 * var_31_7 * Mathf.Tan(var_31_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_31_10 = var_31_9 * var_31_8.aspect
					local var_31_11 = var_31_6.sprite.bounds.size.x
					local var_31_12 = var_31_6.sprite.bounds.size.y
					local var_31_13 = var_31_10 / var_31_11
					local var_31_14 = var_31_9 / var_31_12
					local var_31_15 = var_31_14 < var_31_13 and var_31_13 or var_31_14

					var_31_5.transform.localScale = Vector3.New(var_31_15, var_31_15, 0)
				end

				for iter_31_0, iter_31_1 in pairs(arg_28_1.bgs_) do
					if iter_31_0 ~= "SS1608" then
						iter_31_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_31_16 = 1

			if var_31_16 < arg_28_1.time_ and arg_28_1.time_ <= var_31_16 + arg_31_0 then
				arg_28_1.allBtn_.enabled = false
			end

			local var_31_17 = 0.3

			if arg_28_1.time_ >= var_31_16 + var_31_17 and arg_28_1.time_ < var_31_16 + var_31_17 + arg_31_0 then
				arg_28_1.allBtn_.enabled = true
			end

			local var_31_18 = 0

			if var_31_18 < arg_28_1.time_ and arg_28_1.time_ <= var_31_18 + arg_31_0 then
				arg_28_1.mask_.enabled = true
				arg_28_1.mask_.raycastTarget = true

				arg_28_1:SetGaussion(false)
			end

			local var_31_19 = 1.03333333333333

			if var_31_18 <= arg_28_1.time_ and arg_28_1.time_ < var_31_18 + var_31_19 then
				local var_31_20 = (arg_28_1.time_ - var_31_18) / var_31_19
				local var_31_21 = Color.New(0, 0, 0)

				var_31_21.a = Mathf.Lerp(0, 1, var_31_20)
				arg_28_1.mask_.color = var_31_21
			end

			if arg_28_1.time_ >= var_31_18 + var_31_19 and arg_28_1.time_ < var_31_18 + var_31_19 + arg_31_0 then
				local var_31_22 = Color.New(0, 0, 0)

				var_31_22.a = 1
				arg_28_1.mask_.color = var_31_22
			end

			local var_31_23 = 1.03333333333333

			if var_31_23 < arg_28_1.time_ and arg_28_1.time_ <= var_31_23 + arg_31_0 then
				arg_28_1.mask_.enabled = true
				arg_28_1.mask_.raycastTarget = true

				arg_28_1:SetGaussion(false)
			end

			local var_31_24 = 2.13333333333333

			if var_31_23 <= arg_28_1.time_ and arg_28_1.time_ < var_31_23 + var_31_24 then
				local var_31_25 = (arg_28_1.time_ - var_31_23) / var_31_24
				local var_31_26 = Color.New(0, 0, 0)

				var_31_26.a = Mathf.Lerp(1, 0, var_31_25)
				arg_28_1.mask_.color = var_31_26
			end

			if arg_28_1.time_ >= var_31_23 + var_31_24 and arg_28_1.time_ < var_31_23 + var_31_24 + arg_31_0 then
				local var_31_27 = Color.New(0, 0, 0)
				local var_31_28 = 0

				arg_28_1.mask_.enabled = false
				var_31_27.a = var_31_28
				arg_28_1.mask_.color = var_31_27
			end

			local var_31_29 = arg_28_1.bgs_.SS1608.transform
			local var_31_30 = 1.03333333333333

			if var_31_30 < arg_28_1.time_ and arg_28_1.time_ <= var_31_30 + arg_31_0 then
				arg_28_1.var_.moveOldPosSS1608 = var_31_29.localPosition
			end

			local var_31_31 = 0.001

			if var_31_30 <= arg_28_1.time_ and arg_28_1.time_ < var_31_30 + var_31_31 then
				local var_31_32 = (arg_28_1.time_ - var_31_30) / var_31_31
				local var_31_33 = Vector3.New(0, 0.78, 8)

				var_31_29.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPosSS1608, var_31_33, var_31_32)
			end

			if arg_28_1.time_ >= var_31_30 + var_31_31 and arg_28_1.time_ < var_31_30 + var_31_31 + arg_31_0 then
				var_31_29.localPosition = Vector3.New(0, 0.78, 8)
			end

			local var_31_34 = arg_28_1.bgs_.SS1608.transform
			local var_31_35 = 1.06733333333333

			if var_31_35 < arg_28_1.time_ and arg_28_1.time_ <= var_31_35 + arg_31_0 then
				arg_28_1.var_.moveOldPosSS1608 = var_31_34.localPosition
			end

			local var_31_36 = 2.49933333333333

			if var_31_35 <= arg_28_1.time_ and arg_28_1.time_ < var_31_35 + var_31_36 then
				local var_31_37 = (arg_28_1.time_ - var_31_35) / var_31_36
				local var_31_38 = Vector3.New(0, 0.4, 6)

				var_31_34.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPosSS1608, var_31_38, var_31_37)
			end

			if arg_28_1.time_ >= var_31_35 + var_31_36 and arg_28_1.time_ < var_31_35 + var_31_36 + arg_31_0 then
				var_31_34.localPosition = Vector3.New(0, 0.4, 6)
			end

			local var_31_39 = manager.ui.mainCamera.transform
			local var_31_40 = 1.03333333333333

			if var_31_40 < arg_28_1.time_ and arg_28_1.time_ <= var_31_40 + arg_31_0 then
				arg_28_1.var_.shakeOldPos = var_31_39.localPosition
			end

			local var_31_41 = 0.411224965255799

			if var_31_40 <= arg_28_1.time_ and arg_28_1.time_ < var_31_40 + var_31_41 then
				local var_31_42 = (arg_28_1.time_ - var_31_40) / 0.066
				local var_31_43, var_31_44 = math.modf(var_31_42)

				var_31_39.localPosition = Vector3.New(var_31_44 * 0.13, var_31_44 * 0.13, var_31_44 * 0.13) + arg_28_1.var_.shakeOldPos
			end

			if arg_28_1.time_ >= var_31_40 + var_31_41 and arg_28_1.time_ < var_31_40 + var_31_41 + arg_31_0 then
				var_31_39.localPosition = arg_28_1.var_.shakeOldPos
			end

			local var_31_45 = 1.03333333333333
			local var_31_46 = 1

			if var_31_45 < arg_28_1.time_ and arg_28_1.time_ <= var_31_45 + arg_31_0 then
				local var_31_47 = "play"
				local var_31_48 = "effect"

				arg_28_1:AudioAction(var_31_47, var_31_48, "se_story_5", "se_story_5_heartbeat", "")
			end

			local var_31_49 = 0
			local var_31_50 = 0.2

			if var_31_49 < arg_28_1.time_ and arg_28_1.time_ <= var_31_49 + arg_31_0 then
				local var_31_51 = "play"
				local var_31_52 = "music"

				arg_28_1:AudioAction(var_31_51, var_31_52, "ui_battle", "ui_battle_stopbgm", "")

				local var_31_53 = ""
				local var_31_54 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_31_54 ~= "" then
					if arg_28_1.bgmTxt_.text ~= var_31_54 and arg_28_1.bgmTxt_.text ~= "" then
						if arg_28_1.bgmTxt2_.text ~= "" then
							arg_28_1.bgmTxt_.text = arg_28_1.bgmTxt2_.text
						end

						arg_28_1.bgmTxt2_.text = var_31_54

						arg_28_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_28_1.bgmTxt_.text = var_31_54
						arg_28_1.bgmTxt2_.text = var_31_54
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

			local var_31_55 = 0.833333333333333
			local var_31_56 = 1

			if var_31_55 < arg_28_1.time_ and arg_28_1.time_ <= var_31_55 + arg_31_0 then
				local var_31_57 = "play"
				local var_31_58 = "music"

				arg_28_1:AudioAction(var_31_57, var_31_58, "bgm_activity_3_4_story_seabed", "bgm_activity_3_4_story_seabed", "bgm_activity_3_4_story_seabed.awb")

				local var_31_59 = ""
				local var_31_60 = manager.audio:GetAudioName("bgm_activity_3_4_story_seabed", "bgm_activity_3_4_story_seabed")

				if var_31_60 ~= "" then
					if arg_28_1.bgmTxt_.text ~= var_31_60 and arg_28_1.bgmTxt_.text ~= "" then
						if arg_28_1.bgmTxt2_.text ~= "" then
							arg_28_1.bgmTxt_.text = arg_28_1.bgmTxt2_.text
						end

						arg_28_1.bgmTxt2_.text = var_31_60

						arg_28_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_28_1.bgmTxt_.text = var_31_60
						arg_28_1.bgmTxt2_.text = var_31_60
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

			if arg_28_1.frameCnt_ <= 1 then
				arg_28_1.dialog_:SetActive(false)
			end

			local var_31_61 = 2.8
			local var_31_62 = 1.45

			if var_31_61 < arg_28_1.time_ and arg_28_1.time_ <= var_31_61 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0

				arg_28_1.dialog_:SetActive(true)

				arg_28_1.dialogCg_.alpha = 0

				local var_31_63 = LeanTween.value(arg_28_1.dialog_, 0, 1, 0.3)

				var_31_63:setOnUpdate(LuaHelper.FloatAction(function(arg_34_0)
					arg_28_1.dialogCg_.alpha = arg_34_0
				end))
				var_31_63:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_28_1.dialog_)
					var_31_63:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_28_1.duration_ = arg_28_1.duration_ + 0.3

				SetActive(arg_28_1.leftNameGo_, false)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_64 = arg_28_1:GetWordFromCfg(416191007)
				local var_31_65 = arg_28_1:FormatText(var_31_64.content)

				arg_28_1.text_.text = var_31_65

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_66 = 58
				local var_31_67 = utf8.len(var_31_65)
				local var_31_68 = var_31_66 <= 0 and var_31_62 or var_31_62 * (var_31_67 / var_31_66)

				if var_31_68 > 0 and var_31_62 < var_31_68 then
					arg_28_1.talkMaxDuration = var_31_68
					var_31_61 = var_31_61 + 0.3

					if var_31_68 + var_31_61 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_68 + var_31_61
					end
				end

				arg_28_1.text_.text = var_31_65
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_69 = var_31_61 + 0.3
			local var_31_70 = math.max(var_31_62, arg_28_1.talkMaxDuration)

			if var_31_69 <= arg_28_1.time_ and arg_28_1.time_ < var_31_69 + var_31_70 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_69) / var_31_70

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_69 + var_31_70 and arg_28_1.time_ < var_31_69 + var_31_70 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS1608",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.03333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1608",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.49933333333333,
				className = "StoryMoveNode",
				startTime = 1.06733333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play416191008 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 416191008
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play416191009(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0.05
			local var_39_1 = 1

			if var_39_0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_0 + arg_39_0 then
				local var_39_2 = "play"
				local var_39_3 = "effect"

				arg_36_1:AudioAction(var_39_2, var_39_3, "se_story_127", "se_story_127_thunder", "")
			end

			local var_39_4 = 0.1
			local var_39_5 = 1

			if var_39_4 < arg_36_1.time_ and arg_36_1.time_ <= var_39_4 + arg_39_0 then
				local var_39_6 = "stop"
				local var_39_7 = "effect"

				arg_36_1:AudioAction(var_39_6, var_39_7, "se_story_5", "se_story_5_heartbeat", "")
			end

			local var_39_8 = 0
			local var_39_9 = 1.275

			if var_39_8 < arg_36_1.time_ and arg_36_1.time_ <= var_39_8 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, false)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_10 = arg_36_1:GetWordFromCfg(416191008)
				local var_39_11 = arg_36_1:FormatText(var_39_10.content)

				arg_36_1.text_.text = var_39_11

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_12 = 51
				local var_39_13 = utf8.len(var_39_11)
				local var_39_14 = var_39_12 <= 0 and var_39_9 or var_39_9 * (var_39_13 / var_39_12)

				if var_39_14 > 0 and var_39_9 < var_39_14 then
					arg_36_1.talkMaxDuration = var_39_14

					if var_39_14 + var_39_8 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_14 + var_39_8
					end
				end

				arg_36_1.text_.text = var_39_11
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_15 = math.max(var_39_9, arg_36_1.talkMaxDuration)

			if var_39_8 <= arg_36_1.time_ and arg_36_1.time_ < var_39_8 + var_39_15 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_8) / var_39_15

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_8 + var_39_15 and arg_36_1.time_ < var_39_8 + var_39_15 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play416191009 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 416191009
		arg_40_1.duration_ = 6.9

		local var_40_0 = {
			zh = 4.133,
			ja = 6.9
		}
		local var_40_1 = manager.audio:GetLocalizationFlag()

		if var_40_0[var_40_1] ~= nil then
			arg_40_1.duration_ = var_40_0[var_40_1]
		end

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play416191010(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0
			local var_43_1 = 0.475

			if var_43_0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_2 = arg_40_1:FormatText(StoryNameCfg[1080].name)

				arg_40_1.leftNameTxt_.text = var_43_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_3 = arg_40_1:GetWordFromCfg(416191009)
				local var_43_4 = arg_40_1:FormatText(var_43_3.content)

				arg_40_1.text_.text = var_43_4

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_5 = 19
				local var_43_6 = utf8.len(var_43_4)
				local var_43_7 = var_43_5 <= 0 and var_43_1 or var_43_1 * (var_43_6 / var_43_5)

				if var_43_7 > 0 and var_43_1 < var_43_7 then
					arg_40_1.talkMaxDuration = var_43_7

					if var_43_7 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_7 + var_43_0
					end
				end

				arg_40_1.text_.text = var_43_4
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191009", "story_v_out_416191.awb") ~= 0 then
					local var_43_8 = manager.audio:GetVoiceLength("story_v_out_416191", "416191009", "story_v_out_416191.awb") / 1000

					if var_43_8 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_8 + var_43_0
					end

					if var_43_3.prefab_name ~= "" and arg_40_1.actors_[var_43_3.prefab_name] ~= nil then
						local var_43_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_3.prefab_name].transform, "story_v_out_416191", "416191009", "story_v_out_416191.awb")

						arg_40_1:RecordAudio("416191009", var_43_9)
						arg_40_1:RecordAudio("416191009", var_43_9)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_416191", "416191009", "story_v_out_416191.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_416191", "416191009", "story_v_out_416191.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_10 = math.max(var_43_1, arg_40_1.talkMaxDuration)

			if var_43_0 <= arg_40_1.time_ and arg_40_1.time_ < var_43_0 + var_43_10 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_0) / var_43_10

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_0 + var_43_10 and arg_40_1.time_ < var_43_0 + var_43_10 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play416191010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 416191010
		arg_44_1.duration_ = 11.5

		local var_44_0 = {
			zh = 5.6,
			ja = 11.5
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
				arg_44_0:Play416191011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0
			local var_47_1 = 0.7

			if var_47_0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_2 = arg_44_1:FormatText(StoryNameCfg[1080].name)

				arg_44_1.leftNameTxt_.text = var_47_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_3 = arg_44_1:GetWordFromCfg(416191010)
				local var_47_4 = arg_44_1:FormatText(var_47_3.content)

				arg_44_1.text_.text = var_47_4

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_5 = 28
				local var_47_6 = utf8.len(var_47_4)
				local var_47_7 = var_47_5 <= 0 and var_47_1 or var_47_1 * (var_47_6 / var_47_5)

				if var_47_7 > 0 and var_47_1 < var_47_7 then
					arg_44_1.talkMaxDuration = var_47_7

					if var_47_7 + var_47_0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_7 + var_47_0
					end
				end

				arg_44_1.text_.text = var_47_4
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191010", "story_v_out_416191.awb") ~= 0 then
					local var_47_8 = manager.audio:GetVoiceLength("story_v_out_416191", "416191010", "story_v_out_416191.awb") / 1000

					if var_47_8 + var_47_0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_8 + var_47_0
					end

					if var_47_3.prefab_name ~= "" and arg_44_1.actors_[var_47_3.prefab_name] ~= nil then
						local var_47_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_3.prefab_name].transform, "story_v_out_416191", "416191010", "story_v_out_416191.awb")

						arg_44_1:RecordAudio("416191010", var_47_9)
						arg_44_1:RecordAudio("416191010", var_47_9)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_416191", "416191010", "story_v_out_416191.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_416191", "416191010", "story_v_out_416191.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_10 = math.max(var_47_1, arg_44_1.talkMaxDuration)

			if var_47_0 <= arg_44_1.time_ and arg_44_1.time_ < var_47_0 + var_47_10 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_0) / var_47_10

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_0 + var_47_10 and arg_44_1.time_ < var_47_0 + var_47_10 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play416191011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 416191011
		arg_48_1.duration_ = 10.13

		local var_48_0 = {
			zh = 6,
			ja = 10.133
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
				arg_48_0:Play416191012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0
			local var_51_1 = 0.525

			if var_51_0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_2 = arg_48_1:FormatText(StoryNameCfg[36].name)

				arg_48_1.leftNameTxt_.text = var_51_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_3 = arg_48_1:GetWordFromCfg(416191011)
				local var_51_4 = arg_48_1:FormatText(var_51_3.content)

				arg_48_1.text_.text = var_51_4

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_5 = 21
				local var_51_6 = utf8.len(var_51_4)
				local var_51_7 = var_51_5 <= 0 and var_51_1 or var_51_1 * (var_51_6 / var_51_5)

				if var_51_7 > 0 and var_51_1 < var_51_7 then
					arg_48_1.talkMaxDuration = var_51_7

					if var_51_7 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_7 + var_51_0
					end
				end

				arg_48_1.text_.text = var_51_4
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191011", "story_v_out_416191.awb") ~= 0 then
					local var_51_8 = manager.audio:GetVoiceLength("story_v_out_416191", "416191011", "story_v_out_416191.awb") / 1000

					if var_51_8 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_8 + var_51_0
					end

					if var_51_3.prefab_name ~= "" and arg_48_1.actors_[var_51_3.prefab_name] ~= nil then
						local var_51_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_3.prefab_name].transform, "story_v_out_416191", "416191011", "story_v_out_416191.awb")

						arg_48_1:RecordAudio("416191011", var_51_9)
						arg_48_1:RecordAudio("416191011", var_51_9)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_416191", "416191011", "story_v_out_416191.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_416191", "416191011", "story_v_out_416191.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_10 = math.max(var_51_1, arg_48_1.talkMaxDuration)

			if var_51_0 <= arg_48_1.time_ and arg_48_1.time_ < var_51_0 + var_51_10 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_0) / var_51_10

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_0 + var_51_10 and arg_48_1.time_ < var_51_0 + var_51_10 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play416191012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 416191012
		arg_52_1.duration_ = 8.1

		local var_52_0 = {
			zh = 5.566,
			ja = 8.1
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
				arg_52_0:Play416191013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0
			local var_55_1 = 0.575

			if var_55_0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_2 = arg_52_1:FormatText(StoryNameCfg[36].name)

				arg_52_1.leftNameTxt_.text = var_55_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_3 = arg_52_1:GetWordFromCfg(416191012)
				local var_55_4 = arg_52_1:FormatText(var_55_3.content)

				arg_52_1.text_.text = var_55_4

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_5 = 23
				local var_55_6 = utf8.len(var_55_4)
				local var_55_7 = var_55_5 <= 0 and var_55_1 or var_55_1 * (var_55_6 / var_55_5)

				if var_55_7 > 0 and var_55_1 < var_55_7 then
					arg_52_1.talkMaxDuration = var_55_7

					if var_55_7 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_7 + var_55_0
					end
				end

				arg_52_1.text_.text = var_55_4
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191012", "story_v_out_416191.awb") ~= 0 then
					local var_55_8 = manager.audio:GetVoiceLength("story_v_out_416191", "416191012", "story_v_out_416191.awb") / 1000

					if var_55_8 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_8 + var_55_0
					end

					if var_55_3.prefab_name ~= "" and arg_52_1.actors_[var_55_3.prefab_name] ~= nil then
						local var_55_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_3.prefab_name].transform, "story_v_out_416191", "416191012", "story_v_out_416191.awb")

						arg_52_1:RecordAudio("416191012", var_55_9)
						arg_52_1:RecordAudio("416191012", var_55_9)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_416191", "416191012", "story_v_out_416191.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_416191", "416191012", "story_v_out_416191.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_10 = math.max(var_55_1, arg_52_1.talkMaxDuration)

			if var_55_0 <= arg_52_1.time_ and arg_52_1.time_ < var_55_0 + var_55_10 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_0) / var_55_10

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_0 + var_55_10 and arg_52_1.time_ < var_55_0 + var_55_10 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play416191013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 416191013
		arg_56_1.duration_ = 6.1

		local var_56_0 = {
			zh = 6.1,
			ja = 5.866
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
				arg_56_0:Play416191014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0
			local var_59_1 = 0.575

			if var_59_0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_2 = arg_56_1:FormatText(StoryNameCfg[1080].name)

				arg_56_1.leftNameTxt_.text = var_59_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_3 = arg_56_1:GetWordFromCfg(416191013)
				local var_59_4 = arg_56_1:FormatText(var_59_3.content)

				arg_56_1.text_.text = var_59_4

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_5 = 23
				local var_59_6 = utf8.len(var_59_4)
				local var_59_7 = var_59_5 <= 0 and var_59_1 or var_59_1 * (var_59_6 / var_59_5)

				if var_59_7 > 0 and var_59_1 < var_59_7 then
					arg_56_1.talkMaxDuration = var_59_7

					if var_59_7 + var_59_0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_7 + var_59_0
					end
				end

				arg_56_1.text_.text = var_59_4
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191013", "story_v_out_416191.awb") ~= 0 then
					local var_59_8 = manager.audio:GetVoiceLength("story_v_out_416191", "416191013", "story_v_out_416191.awb") / 1000

					if var_59_8 + var_59_0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_8 + var_59_0
					end

					if var_59_3.prefab_name ~= "" and arg_56_1.actors_[var_59_3.prefab_name] ~= nil then
						local var_59_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_3.prefab_name].transform, "story_v_out_416191", "416191013", "story_v_out_416191.awb")

						arg_56_1:RecordAudio("416191013", var_59_9)
						arg_56_1:RecordAudio("416191013", var_59_9)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_416191", "416191013", "story_v_out_416191.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_416191", "416191013", "story_v_out_416191.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_10 = math.max(var_59_1, arg_56_1.talkMaxDuration)

			if var_59_0 <= arg_56_1.time_ and arg_56_1.time_ < var_59_0 + var_59_10 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_0) / var_59_10

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_0 + var_59_10 and arg_56_1.time_ < var_59_0 + var_59_10 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play416191014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 416191014
		arg_60_1.duration_ = 4.9

		local var_60_0 = {
			zh = 3.366,
			ja = 4.9
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
				arg_60_0:Play416191015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0
			local var_63_1 = 0.45

			if var_63_0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_2 = arg_60_1:FormatText(StoryNameCfg[1080].name)

				arg_60_1.leftNameTxt_.text = var_63_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_3 = arg_60_1:GetWordFromCfg(416191014)
				local var_63_4 = arg_60_1:FormatText(var_63_3.content)

				arg_60_1.text_.text = var_63_4

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_5 = 18
				local var_63_6 = utf8.len(var_63_4)
				local var_63_7 = var_63_5 <= 0 and var_63_1 or var_63_1 * (var_63_6 / var_63_5)

				if var_63_7 > 0 and var_63_1 < var_63_7 then
					arg_60_1.talkMaxDuration = var_63_7

					if var_63_7 + var_63_0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_7 + var_63_0
					end
				end

				arg_60_1.text_.text = var_63_4
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191014", "story_v_out_416191.awb") ~= 0 then
					local var_63_8 = manager.audio:GetVoiceLength("story_v_out_416191", "416191014", "story_v_out_416191.awb") / 1000

					if var_63_8 + var_63_0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_8 + var_63_0
					end

					if var_63_3.prefab_name ~= "" and arg_60_1.actors_[var_63_3.prefab_name] ~= nil then
						local var_63_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_3.prefab_name].transform, "story_v_out_416191", "416191014", "story_v_out_416191.awb")

						arg_60_1:RecordAudio("416191014", var_63_9)
						arg_60_1:RecordAudio("416191014", var_63_9)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_416191", "416191014", "story_v_out_416191.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_416191", "416191014", "story_v_out_416191.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_10 = math.max(var_63_1, arg_60_1.talkMaxDuration)

			if var_63_0 <= arg_60_1.time_ and arg_60_1.time_ < var_63_0 + var_63_10 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_0) / var_63_10

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_0 + var_63_10 and arg_60_1.time_ < var_63_0 + var_63_10 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play416191015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 416191015
		arg_64_1.duration_ = 9.6

		local var_64_0 = {
			zh = 6.333,
			ja = 9.6
		}
		local var_64_1 = manager.audio:GetLocalizationFlag()

		if var_64_0[var_64_1] ~= nil then
			arg_64_1.duration_ = var_64_0[var_64_1]
		end

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play416191016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = 0
			local var_67_1 = 0.475

			if var_67_0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_0 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_2 = arg_64_1:FormatText(StoryNameCfg[36].name)

				arg_64_1.leftNameTxt_.text = var_67_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_3 = arg_64_1:GetWordFromCfg(416191015)
				local var_67_4 = arg_64_1:FormatText(var_67_3.content)

				arg_64_1.text_.text = var_67_4

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_5 = 19
				local var_67_6 = utf8.len(var_67_4)
				local var_67_7 = var_67_5 <= 0 and var_67_1 or var_67_1 * (var_67_6 / var_67_5)

				if var_67_7 > 0 and var_67_1 < var_67_7 then
					arg_64_1.talkMaxDuration = var_67_7

					if var_67_7 + var_67_0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_7 + var_67_0
					end
				end

				arg_64_1.text_.text = var_67_4
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191015", "story_v_out_416191.awb") ~= 0 then
					local var_67_8 = manager.audio:GetVoiceLength("story_v_out_416191", "416191015", "story_v_out_416191.awb") / 1000

					if var_67_8 + var_67_0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_8 + var_67_0
					end

					if var_67_3.prefab_name ~= "" and arg_64_1.actors_[var_67_3.prefab_name] ~= nil then
						local var_67_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_3.prefab_name].transform, "story_v_out_416191", "416191015", "story_v_out_416191.awb")

						arg_64_1:RecordAudio("416191015", var_67_9)
						arg_64_1:RecordAudio("416191015", var_67_9)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_416191", "416191015", "story_v_out_416191.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_416191", "416191015", "story_v_out_416191.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_10 = math.max(var_67_1, arg_64_1.talkMaxDuration)

			if var_67_0 <= arg_64_1.time_ and arg_64_1.time_ < var_67_0 + var_67_10 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_0) / var_67_10

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_0 + var_67_10 and arg_64_1.time_ < var_67_0 + var_67_10 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play416191016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 416191016
		arg_68_1.duration_ = 6.4

		local var_68_0 = {
			zh = 5.2,
			ja = 6.4
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
				arg_68_0:Play416191017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 0
			local var_71_1 = 0.625

			if var_71_0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_2 = arg_68_1:FormatText(StoryNameCfg[1080].name)

				arg_68_1.leftNameTxt_.text = var_71_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_3 = arg_68_1:GetWordFromCfg(416191016)
				local var_71_4 = arg_68_1:FormatText(var_71_3.content)

				arg_68_1.text_.text = var_71_4

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_5 = 25
				local var_71_6 = utf8.len(var_71_4)
				local var_71_7 = var_71_5 <= 0 and var_71_1 or var_71_1 * (var_71_6 / var_71_5)

				if var_71_7 > 0 and var_71_1 < var_71_7 then
					arg_68_1.talkMaxDuration = var_71_7

					if var_71_7 + var_71_0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_7 + var_71_0
					end
				end

				arg_68_1.text_.text = var_71_4
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191016", "story_v_out_416191.awb") ~= 0 then
					local var_71_8 = manager.audio:GetVoiceLength("story_v_out_416191", "416191016", "story_v_out_416191.awb") / 1000

					if var_71_8 + var_71_0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_8 + var_71_0
					end

					if var_71_3.prefab_name ~= "" and arg_68_1.actors_[var_71_3.prefab_name] ~= nil then
						local var_71_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_3.prefab_name].transform, "story_v_out_416191", "416191016", "story_v_out_416191.awb")

						arg_68_1:RecordAudio("416191016", var_71_9)
						arg_68_1:RecordAudio("416191016", var_71_9)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_416191", "416191016", "story_v_out_416191.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_416191", "416191016", "story_v_out_416191.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_10 = math.max(var_71_1, arg_68_1.talkMaxDuration)

			if var_71_0 <= arg_68_1.time_ and arg_68_1.time_ < var_71_0 + var_71_10 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_0) / var_71_10

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_0 + var_71_10 and arg_68_1.time_ < var_71_0 + var_71_10 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play416191017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 416191017
		arg_72_1.duration_ = 6.57

		local var_72_0 = {
			zh = 5.566,
			ja = 6.566
		}
		local var_72_1 = manager.audio:GetLocalizationFlag()

		if var_72_0[var_72_1] ~= nil then
			arg_72_1.duration_ = var_72_0[var_72_1]
		end

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play416191018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0
			local var_75_1 = 0.5

			if var_75_0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_0 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_2 = arg_72_1:FormatText(StoryNameCfg[36].name)

				arg_72_1.leftNameTxt_.text = var_75_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_3 = arg_72_1:GetWordFromCfg(416191017)
				local var_75_4 = arg_72_1:FormatText(var_75_3.content)

				arg_72_1.text_.text = var_75_4

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_5 = 20
				local var_75_6 = utf8.len(var_75_4)
				local var_75_7 = var_75_5 <= 0 and var_75_1 or var_75_1 * (var_75_6 / var_75_5)

				if var_75_7 > 0 and var_75_1 < var_75_7 then
					arg_72_1.talkMaxDuration = var_75_7

					if var_75_7 + var_75_0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_7 + var_75_0
					end
				end

				arg_72_1.text_.text = var_75_4
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191017", "story_v_out_416191.awb") ~= 0 then
					local var_75_8 = manager.audio:GetVoiceLength("story_v_out_416191", "416191017", "story_v_out_416191.awb") / 1000

					if var_75_8 + var_75_0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_8 + var_75_0
					end

					if var_75_3.prefab_name ~= "" and arg_72_1.actors_[var_75_3.prefab_name] ~= nil then
						local var_75_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_3.prefab_name].transform, "story_v_out_416191", "416191017", "story_v_out_416191.awb")

						arg_72_1:RecordAudio("416191017", var_75_9)
						arg_72_1:RecordAudio("416191017", var_75_9)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_416191", "416191017", "story_v_out_416191.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_416191", "416191017", "story_v_out_416191.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_10 = math.max(var_75_1, arg_72_1.talkMaxDuration)

			if var_75_0 <= arg_72_1.time_ and arg_72_1.time_ < var_75_0 + var_75_10 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_0) / var_75_10

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_0 + var_75_10 and arg_72_1.time_ < var_75_0 + var_75_10 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play416191018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 416191018
		arg_76_1.duration_ = 7.8

		local var_76_0 = {
			zh = 5.366,
			ja = 7.8
		}
		local var_76_1 = manager.audio:GetLocalizationFlag()

		if var_76_0[var_76_1] ~= nil then
			arg_76_1.duration_ = var_76_0[var_76_1]
		end

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play416191019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 0
			local var_79_1 = 0.5

			if var_79_0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_0 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_2 = arg_76_1:FormatText(StoryNameCfg[1080].name)

				arg_76_1.leftNameTxt_.text = var_79_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_3 = arg_76_1:GetWordFromCfg(416191018)
				local var_79_4 = arg_76_1:FormatText(var_79_3.content)

				arg_76_1.text_.text = var_79_4

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_5 = 20
				local var_79_6 = utf8.len(var_79_4)
				local var_79_7 = var_79_5 <= 0 and var_79_1 or var_79_1 * (var_79_6 / var_79_5)

				if var_79_7 > 0 and var_79_1 < var_79_7 then
					arg_76_1.talkMaxDuration = var_79_7

					if var_79_7 + var_79_0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_7 + var_79_0
					end
				end

				arg_76_1.text_.text = var_79_4
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191018", "story_v_out_416191.awb") ~= 0 then
					local var_79_8 = manager.audio:GetVoiceLength("story_v_out_416191", "416191018", "story_v_out_416191.awb") / 1000

					if var_79_8 + var_79_0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_8 + var_79_0
					end

					if var_79_3.prefab_name ~= "" and arg_76_1.actors_[var_79_3.prefab_name] ~= nil then
						local var_79_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_3.prefab_name].transform, "story_v_out_416191", "416191018", "story_v_out_416191.awb")

						arg_76_1:RecordAudio("416191018", var_79_9)
						arg_76_1:RecordAudio("416191018", var_79_9)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_416191", "416191018", "story_v_out_416191.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_416191", "416191018", "story_v_out_416191.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_10 = math.max(var_79_1, arg_76_1.talkMaxDuration)

			if var_79_0 <= arg_76_1.time_ and arg_76_1.time_ < var_79_0 + var_79_10 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_0) / var_79_10

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_0 + var_79_10 and arg_76_1.time_ < var_79_0 + var_79_10 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play416191019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 416191019
		arg_80_1.duration_ = 8.73

		local var_80_0 = {
			zh = 4.666,
			ja = 8.733
		}
		local var_80_1 = manager.audio:GetLocalizationFlag()

		if var_80_0[var_80_1] ~= nil then
			arg_80_1.duration_ = var_80_0[var_80_1]
		end

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play416191020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0
			local var_83_1 = 0.55

			if var_83_0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_0 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_2 = arg_80_1:FormatText(StoryNameCfg[1080].name)

				arg_80_1.leftNameTxt_.text = var_83_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_3 = arg_80_1:GetWordFromCfg(416191019)
				local var_83_4 = arg_80_1:FormatText(var_83_3.content)

				arg_80_1.text_.text = var_83_4

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_5 = 22
				local var_83_6 = utf8.len(var_83_4)
				local var_83_7 = var_83_5 <= 0 and var_83_1 or var_83_1 * (var_83_6 / var_83_5)

				if var_83_7 > 0 and var_83_1 < var_83_7 then
					arg_80_1.talkMaxDuration = var_83_7

					if var_83_7 + var_83_0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_7 + var_83_0
					end
				end

				arg_80_1.text_.text = var_83_4
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191019", "story_v_out_416191.awb") ~= 0 then
					local var_83_8 = manager.audio:GetVoiceLength("story_v_out_416191", "416191019", "story_v_out_416191.awb") / 1000

					if var_83_8 + var_83_0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_8 + var_83_0
					end

					if var_83_3.prefab_name ~= "" and arg_80_1.actors_[var_83_3.prefab_name] ~= nil then
						local var_83_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_3.prefab_name].transform, "story_v_out_416191", "416191019", "story_v_out_416191.awb")

						arg_80_1:RecordAudio("416191019", var_83_9)
						arg_80_1:RecordAudio("416191019", var_83_9)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_416191", "416191019", "story_v_out_416191.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_416191", "416191019", "story_v_out_416191.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_10 = math.max(var_83_1, arg_80_1.talkMaxDuration)

			if var_83_0 <= arg_80_1.time_ and arg_80_1.time_ < var_83_0 + var_83_10 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_0) / var_83_10

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_0 + var_83_10 and arg_80_1.time_ < var_83_0 + var_83_10 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play416191020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 416191020
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play416191021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0.1
			local var_87_1 = 1

			if var_87_0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_0 + arg_87_0 then
				local var_87_2 = "play"
				local var_87_3 = "effect"

				arg_84_1:AudioAction(var_87_2, var_87_3, "se_story_139", "se_story_139_metalhit01", "")
			end

			local var_87_4 = 0
			local var_87_5 = 1.7

			if var_87_4 < arg_84_1.time_ and arg_84_1.time_ <= var_87_4 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, false)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_6 = arg_84_1:GetWordFromCfg(416191020)
				local var_87_7 = arg_84_1:FormatText(var_87_6.content)

				arg_84_1.text_.text = var_87_7

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_8 = 68
				local var_87_9 = utf8.len(var_87_7)
				local var_87_10 = var_87_8 <= 0 and var_87_5 or var_87_5 * (var_87_9 / var_87_8)

				if var_87_10 > 0 and var_87_5 < var_87_10 then
					arg_84_1.talkMaxDuration = var_87_10

					if var_87_10 + var_87_4 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_10 + var_87_4
					end
				end

				arg_84_1.text_.text = var_87_7
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_11 = math.max(var_87_5, arg_84_1.talkMaxDuration)

			if var_87_4 <= arg_84_1.time_ and arg_84_1.time_ < var_87_4 + var_87_11 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_4) / var_87_11

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_4 + var_87_11 and arg_84_1.time_ < var_87_4 + var_87_11 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play416191021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 416191021
		arg_88_1.duration_ = 6.07

		local var_88_0 = {
			zh = 4.4,
			ja = 6.066
		}
		local var_88_1 = manager.audio:GetLocalizationFlag()

		if var_88_0[var_88_1] ~= nil then
			arg_88_1.duration_ = var_88_0[var_88_1]
		end

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play416191022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 0
			local var_91_1 = 0.45

			if var_91_0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_0 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_2 = arg_88_1:FormatText(StoryNameCfg[36].name)

				arg_88_1.leftNameTxt_.text = var_91_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_3 = arg_88_1:GetWordFromCfg(416191021)
				local var_91_4 = arg_88_1:FormatText(var_91_3.content)

				arg_88_1.text_.text = var_91_4

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_5 = 18
				local var_91_6 = utf8.len(var_91_4)
				local var_91_7 = var_91_5 <= 0 and var_91_1 or var_91_1 * (var_91_6 / var_91_5)

				if var_91_7 > 0 and var_91_1 < var_91_7 then
					arg_88_1.talkMaxDuration = var_91_7

					if var_91_7 + var_91_0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_7 + var_91_0
					end
				end

				arg_88_1.text_.text = var_91_4
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191021", "story_v_out_416191.awb") ~= 0 then
					local var_91_8 = manager.audio:GetVoiceLength("story_v_out_416191", "416191021", "story_v_out_416191.awb") / 1000

					if var_91_8 + var_91_0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_8 + var_91_0
					end

					if var_91_3.prefab_name ~= "" and arg_88_1.actors_[var_91_3.prefab_name] ~= nil then
						local var_91_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_3.prefab_name].transform, "story_v_out_416191", "416191021", "story_v_out_416191.awb")

						arg_88_1:RecordAudio("416191021", var_91_9)
						arg_88_1:RecordAudio("416191021", var_91_9)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_416191", "416191021", "story_v_out_416191.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_416191", "416191021", "story_v_out_416191.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_10 = math.max(var_91_1, arg_88_1.talkMaxDuration)

			if var_91_0 <= arg_88_1.time_ and arg_88_1.time_ < var_91_0 + var_91_10 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_0) / var_91_10

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_0 + var_91_10 and arg_88_1.time_ < var_91_0 + var_91_10 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play416191022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 416191022
		arg_92_1.duration_ = 7.47

		local var_92_0 = {
			zh = 4.2,
			ja = 7.466
		}
		local var_92_1 = manager.audio:GetLocalizationFlag()

		if var_92_0[var_92_1] ~= nil then
			arg_92_1.duration_ = var_92_0[var_92_1]
		end

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play416191023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = 0
			local var_95_1 = 0.5

			if var_95_0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_0 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_2 = arg_92_1:FormatText(StoryNameCfg[1080].name)

				arg_92_1.leftNameTxt_.text = var_95_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_3 = arg_92_1:GetWordFromCfg(416191022)
				local var_95_4 = arg_92_1:FormatText(var_95_3.content)

				arg_92_1.text_.text = var_95_4

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_5 = 20
				local var_95_6 = utf8.len(var_95_4)
				local var_95_7 = var_95_5 <= 0 and var_95_1 or var_95_1 * (var_95_6 / var_95_5)

				if var_95_7 > 0 and var_95_1 < var_95_7 then
					arg_92_1.talkMaxDuration = var_95_7

					if var_95_7 + var_95_0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_7 + var_95_0
					end
				end

				arg_92_1.text_.text = var_95_4
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191022", "story_v_out_416191.awb") ~= 0 then
					local var_95_8 = manager.audio:GetVoiceLength("story_v_out_416191", "416191022", "story_v_out_416191.awb") / 1000

					if var_95_8 + var_95_0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_8 + var_95_0
					end

					if var_95_3.prefab_name ~= "" and arg_92_1.actors_[var_95_3.prefab_name] ~= nil then
						local var_95_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_3.prefab_name].transform, "story_v_out_416191", "416191022", "story_v_out_416191.awb")

						arg_92_1:RecordAudio("416191022", var_95_9)
						arg_92_1:RecordAudio("416191022", var_95_9)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_416191", "416191022", "story_v_out_416191.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_416191", "416191022", "story_v_out_416191.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_10 = math.max(var_95_1, arg_92_1.talkMaxDuration)

			if var_95_0 <= arg_92_1.time_ and arg_92_1.time_ < var_95_0 + var_95_10 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_0) / var_95_10

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_0 + var_95_10 and arg_92_1.time_ < var_95_0 + var_95_10 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play416191023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 416191023
		arg_96_1.duration_ = 5.5

		local var_96_0 = {
			zh = 3.966,
			ja = 5.5
		}
		local var_96_1 = manager.audio:GetLocalizationFlag()

		if var_96_0[var_96_1] ~= nil then
			arg_96_1.duration_ = var_96_0[var_96_1]
		end

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play416191024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = 0
			local var_99_1 = 0.425

			if var_99_0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_0 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_2 = arg_96_1:FormatText(StoryNameCfg[1080].name)

				arg_96_1.leftNameTxt_.text = var_99_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_3 = arg_96_1:GetWordFromCfg(416191023)
				local var_99_4 = arg_96_1:FormatText(var_99_3.content)

				arg_96_1.text_.text = var_99_4

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_5 = 18
				local var_99_6 = utf8.len(var_99_4)
				local var_99_7 = var_99_5 <= 0 and var_99_1 or var_99_1 * (var_99_6 / var_99_5)

				if var_99_7 > 0 and var_99_1 < var_99_7 then
					arg_96_1.talkMaxDuration = var_99_7

					if var_99_7 + var_99_0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_7 + var_99_0
					end
				end

				arg_96_1.text_.text = var_99_4
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191023", "story_v_out_416191.awb") ~= 0 then
					local var_99_8 = manager.audio:GetVoiceLength("story_v_out_416191", "416191023", "story_v_out_416191.awb") / 1000

					if var_99_8 + var_99_0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_8 + var_99_0
					end

					if var_99_3.prefab_name ~= "" and arg_96_1.actors_[var_99_3.prefab_name] ~= nil then
						local var_99_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_3.prefab_name].transform, "story_v_out_416191", "416191023", "story_v_out_416191.awb")

						arg_96_1:RecordAudio("416191023", var_99_9)
						arg_96_1:RecordAudio("416191023", var_99_9)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_416191", "416191023", "story_v_out_416191.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_416191", "416191023", "story_v_out_416191.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_10 = math.max(var_99_1, arg_96_1.talkMaxDuration)

			if var_99_0 <= arg_96_1.time_ and arg_96_1.time_ < var_99_0 + var_99_10 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_0) / var_99_10

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_0 + var_99_10 and arg_96_1.time_ < var_99_0 + var_99_10 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play416191024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 416191024
		arg_100_1.duration_ = 5.93

		local var_100_0 = {
			zh = 4.933,
			ja = 5.933
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
				arg_100_0:Play416191025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = 0
			local var_103_1 = 0.425

			if var_103_0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_0 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_2 = arg_100_1:FormatText(StoryNameCfg[36].name)

				arg_100_1.leftNameTxt_.text = var_103_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_3 = arg_100_1:GetWordFromCfg(416191024)
				local var_103_4 = arg_100_1:FormatText(var_103_3.content)

				arg_100_1.text_.text = var_103_4

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_5 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191024", "story_v_out_416191.awb") ~= 0 then
					local var_103_8 = manager.audio:GetVoiceLength("story_v_out_416191", "416191024", "story_v_out_416191.awb") / 1000

					if var_103_8 + var_103_0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_8 + var_103_0
					end

					if var_103_3.prefab_name ~= "" and arg_100_1.actors_[var_103_3.prefab_name] ~= nil then
						local var_103_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_3.prefab_name].transform, "story_v_out_416191", "416191024", "story_v_out_416191.awb")

						arg_100_1:RecordAudio("416191024", var_103_9)
						arg_100_1:RecordAudio("416191024", var_103_9)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_416191", "416191024", "story_v_out_416191.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_416191", "416191024", "story_v_out_416191.awb")
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
	Play416191025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 416191025
		arg_104_1.duration_ = 6

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play416191026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = 0

			if var_107_0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_0 + arg_107_0 then
				arg_104_1.mask_.enabled = true
				arg_104_1.mask_.raycastTarget = true

				arg_104_1:SetGaussion(false)
			end

			local var_107_1 = 1

			if var_107_0 <= arg_104_1.time_ and arg_104_1.time_ < var_107_0 + var_107_1 then
				local var_107_2 = (arg_104_1.time_ - var_107_0) / var_107_1
				local var_107_3 = Color.New(1, 1, 1)

				var_107_3.a = Mathf.Lerp(1, 0, var_107_2)
				arg_104_1.mask_.color = var_107_3
			end

			if arg_104_1.time_ >= var_107_0 + var_107_1 and arg_104_1.time_ < var_107_0 + var_107_1 + arg_107_0 then
				local var_107_4 = Color.New(1, 1, 1)
				local var_107_5 = 0

				arg_104_1.mask_.enabled = false
				var_107_4.a = var_107_5
				arg_104_1.mask_.color = var_107_4
			end

			local var_107_6 = 0

			if var_107_6 < arg_104_1.time_ and arg_104_1.time_ <= var_107_6 + arg_107_0 then
				local var_107_7 = manager.ui.mainCamera.transform.localPosition
				local var_107_8 = Vector3.New(0, 0, 10) + Vector3.New(var_107_7.x, var_107_7.y, 0)
				local var_107_9 = arg_104_1.bgs_.SS1608

				var_107_9.transform.localPosition = var_107_8
				var_107_9.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_107_10 = var_107_9:GetComponent("SpriteRenderer")

				if var_107_10 and var_107_10.sprite then
					local var_107_11 = (var_107_9.transform.localPosition - var_107_7).z
					local var_107_12 = manager.ui.mainCameraCom_
					local var_107_13 = 2 * var_107_11 * Mathf.Tan(var_107_12.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_107_14 = var_107_13 * var_107_12.aspect
					local var_107_15 = var_107_10.sprite.bounds.size.x
					local var_107_16 = var_107_10.sprite.bounds.size.y
					local var_107_17 = var_107_14 / var_107_15
					local var_107_18 = var_107_13 / var_107_16
					local var_107_19 = var_107_18 < var_107_17 and var_107_17 or var_107_18

					var_107_9.transform.localScale = Vector3.New(var_107_19, var_107_19, 0)
				end

				for iter_107_0, iter_107_1 in pairs(arg_104_1.bgs_) do
					if iter_107_0 ~= "SS1608" then
						iter_107_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_107_20 = 0.2
			local var_107_21 = 1

			if var_107_20 < arg_104_1.time_ and arg_104_1.time_ <= var_107_20 + arg_107_0 then
				local var_107_22 = "play"
				local var_107_23 = "effect"

				arg_104_1:AudioAction(var_107_22, var_107_23, "se_story_139", "se_story_139_metalhit02", "")
			end

			if arg_104_1.frameCnt_ <= 1 then
				arg_104_1.dialog_:SetActive(false)
			end

			local var_107_24 = 1
			local var_107_25 = 1.475

			if var_107_24 < arg_104_1.time_ and arg_104_1.time_ <= var_107_24 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0

				arg_104_1.dialog_:SetActive(true)

				arg_104_1.dialogCg_.alpha = 0

				local var_107_26 = LeanTween.value(arg_104_1.dialog_, 0, 1, 0.3)

				var_107_26:setOnUpdate(LuaHelper.FloatAction(function(arg_108_0)
					arg_104_1.dialogCg_.alpha = arg_108_0
				end))
				var_107_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_104_1.dialog_)
					var_107_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_104_1.duration_ = arg_104_1.duration_ + 0.3

				SetActive(arg_104_1.leftNameGo_, false)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_27 = arg_104_1:GetWordFromCfg(416191025)
				local var_107_28 = arg_104_1:FormatText(var_107_27.content)

				arg_104_1.text_.text = var_107_28

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_29 = 59
				local var_107_30 = utf8.len(var_107_28)
				local var_107_31 = var_107_29 <= 0 and var_107_25 or var_107_25 * (var_107_30 / var_107_29)

				if var_107_31 > 0 and var_107_25 < var_107_31 then
					arg_104_1.talkMaxDuration = var_107_31
					var_107_24 = var_107_24 + 0.3

					if var_107_31 + var_107_24 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_31 + var_107_24
					end
				end

				arg_104_1.text_.text = var_107_28
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_32 = var_107_24 + 0.3
			local var_107_33 = math.max(var_107_25, arg_104_1.talkMaxDuration)

			if var_107_32 <= arg_104_1.time_ and arg_104_1.time_ < var_107_32 + var_107_33 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_32) / var_107_33

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_32 + var_107_33 and arg_104_1.time_ < var_107_32 + var_107_33 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play416191026 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 416191026
		arg_110_1.duration_ = 8.4

		local var_110_0 = {
			zh = 3.8,
			ja = 8.4
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
				arg_110_0:Play416191027(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = 0
			local var_113_1 = 0.325

			if var_113_0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_0 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_2 = arg_110_1:FormatText(StoryNameCfg[36].name)

				arg_110_1.leftNameTxt_.text = var_113_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_3 = arg_110_1:GetWordFromCfg(416191026)
				local var_113_4 = arg_110_1:FormatText(var_113_3.content)

				arg_110_1.text_.text = var_113_4

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_5 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191026", "story_v_out_416191.awb") ~= 0 then
					local var_113_8 = manager.audio:GetVoiceLength("story_v_out_416191", "416191026", "story_v_out_416191.awb") / 1000

					if var_113_8 + var_113_0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_8 + var_113_0
					end

					if var_113_3.prefab_name ~= "" and arg_110_1.actors_[var_113_3.prefab_name] ~= nil then
						local var_113_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_3.prefab_name].transform, "story_v_out_416191", "416191026", "story_v_out_416191.awb")

						arg_110_1:RecordAudio("416191026", var_113_9)
						arg_110_1:RecordAudio("416191026", var_113_9)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_416191", "416191026", "story_v_out_416191.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_416191", "416191026", "story_v_out_416191.awb")
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
	Play416191027 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 416191027
		arg_114_1.duration_ = 5.37

		local var_114_0 = {
			zh = 2.5,
			ja = 5.366
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
				arg_114_0:Play416191028(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = 0
			local var_117_1 = 0.325

			if var_117_0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_0 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_2 = arg_114_1:FormatText(StoryNameCfg[1080].name)

				arg_114_1.leftNameTxt_.text = var_117_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_3 = arg_114_1:GetWordFromCfg(416191027)
				local var_117_4 = arg_114_1:FormatText(var_117_3.content)

				arg_114_1.text_.text = var_117_4

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_5 = 13
				local var_117_6 = utf8.len(var_117_4)
				local var_117_7 = var_117_5 <= 0 and var_117_1 or var_117_1 * (var_117_6 / var_117_5)

				if var_117_7 > 0 and var_117_1 < var_117_7 then
					arg_114_1.talkMaxDuration = var_117_7

					if var_117_7 + var_117_0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_7 + var_117_0
					end
				end

				arg_114_1.text_.text = var_117_4
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191027", "story_v_out_416191.awb") ~= 0 then
					local var_117_8 = manager.audio:GetVoiceLength("story_v_out_416191", "416191027", "story_v_out_416191.awb") / 1000

					if var_117_8 + var_117_0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_8 + var_117_0
					end

					if var_117_3.prefab_name ~= "" and arg_114_1.actors_[var_117_3.prefab_name] ~= nil then
						local var_117_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_3.prefab_name].transform, "story_v_out_416191", "416191027", "story_v_out_416191.awb")

						arg_114_1:RecordAudio("416191027", var_117_9)
						arg_114_1:RecordAudio("416191027", var_117_9)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_416191", "416191027", "story_v_out_416191.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_416191", "416191027", "story_v_out_416191.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_10 = math.max(var_117_1, arg_114_1.talkMaxDuration)

			if var_117_0 <= arg_114_1.time_ and arg_114_1.time_ < var_117_0 + var_117_10 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_0) / var_117_10

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_0 + var_117_10 and arg_114_1.time_ < var_117_0 + var_117_10 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play416191028 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 416191028
		arg_118_1.duration_ = 9.37

		local var_118_0 = {
			zh = 8.3,
			ja = 9.366
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
				arg_118_0:Play416191029(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = 0
			local var_121_1 = 0.7

			if var_121_0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_0 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_2 = arg_118_1:FormatText(StoryNameCfg[36].name)

				arg_118_1.leftNameTxt_.text = var_121_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_3 = arg_118_1:GetWordFromCfg(416191028)
				local var_121_4 = arg_118_1:FormatText(var_121_3.content)

				arg_118_1.text_.text = var_121_4

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_5 = 28
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

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191028", "story_v_out_416191.awb") ~= 0 then
					local var_121_8 = manager.audio:GetVoiceLength("story_v_out_416191", "416191028", "story_v_out_416191.awb") / 1000

					if var_121_8 + var_121_0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_8 + var_121_0
					end

					if var_121_3.prefab_name ~= "" and arg_118_1.actors_[var_121_3.prefab_name] ~= nil then
						local var_121_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_3.prefab_name].transform, "story_v_out_416191", "416191028", "story_v_out_416191.awb")

						arg_118_1:RecordAudio("416191028", var_121_9)
						arg_118_1:RecordAudio("416191028", var_121_9)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_416191", "416191028", "story_v_out_416191.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_416191", "416191028", "story_v_out_416191.awb")
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
	Play416191029 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 416191029
		arg_122_1.duration_ = 9.47

		local var_122_0 = {
			zh = 5.8,
			ja = 9.466
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
				arg_122_0:Play416191030(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = 0
			local var_125_1 = 0.575

			if var_125_0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_0 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_2 = arg_122_1:FormatText(StoryNameCfg[36].name)

				arg_122_1.leftNameTxt_.text = var_125_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_3 = arg_122_1:GetWordFromCfg(416191029)
				local var_125_4 = arg_122_1:FormatText(var_125_3.content)

				arg_122_1.text_.text = var_125_4

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_5 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191029", "story_v_out_416191.awb") ~= 0 then
					local var_125_8 = manager.audio:GetVoiceLength("story_v_out_416191", "416191029", "story_v_out_416191.awb") / 1000

					if var_125_8 + var_125_0 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_8 + var_125_0
					end

					if var_125_3.prefab_name ~= "" and arg_122_1.actors_[var_125_3.prefab_name] ~= nil then
						local var_125_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_3.prefab_name].transform, "story_v_out_416191", "416191029", "story_v_out_416191.awb")

						arg_122_1:RecordAudio("416191029", var_125_9)
						arg_122_1:RecordAudio("416191029", var_125_9)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_416191", "416191029", "story_v_out_416191.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_416191", "416191029", "story_v_out_416191.awb")
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
	Play416191030 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 416191030
		arg_126_1.duration_ = 4.23

		local var_126_0 = {
			zh = 4.2,
			ja = 4.233
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
				arg_126_0:Play416191031(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = 0
			local var_129_1 = 0.425

			if var_129_0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_0 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				local var_129_2 = arg_126_1:FormatText(StoryNameCfg[1080].name)

				arg_126_1.leftNameTxt_.text = var_129_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_3 = arg_126_1:GetWordFromCfg(416191030)
				local var_129_4 = arg_126_1:FormatText(var_129_3.content)

				arg_126_1.text_.text = var_129_4

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_5 = 17
				local var_129_6 = utf8.len(var_129_4)
				local var_129_7 = var_129_5 <= 0 and var_129_1 or var_129_1 * (var_129_6 / var_129_5)

				if var_129_7 > 0 and var_129_1 < var_129_7 then
					arg_126_1.talkMaxDuration = var_129_7

					if var_129_7 + var_129_0 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_7 + var_129_0
					end
				end

				arg_126_1.text_.text = var_129_4
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191030", "story_v_out_416191.awb") ~= 0 then
					local var_129_8 = manager.audio:GetVoiceLength("story_v_out_416191", "416191030", "story_v_out_416191.awb") / 1000

					if var_129_8 + var_129_0 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_8 + var_129_0
					end

					if var_129_3.prefab_name ~= "" and arg_126_1.actors_[var_129_3.prefab_name] ~= nil then
						local var_129_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_3.prefab_name].transform, "story_v_out_416191", "416191030", "story_v_out_416191.awb")

						arg_126_1:RecordAudio("416191030", var_129_9)
						arg_126_1:RecordAudio("416191030", var_129_9)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_416191", "416191030", "story_v_out_416191.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_416191", "416191030", "story_v_out_416191.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_10 = math.max(var_129_1, arg_126_1.talkMaxDuration)

			if var_129_0 <= arg_126_1.time_ and arg_126_1.time_ < var_129_0 + var_129_10 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_0) / var_129_10

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_0 + var_129_10 and arg_126_1.time_ < var_129_0 + var_129_10 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play416191031 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 416191031
		arg_130_1.duration_ = 6.3

		local var_130_0 = {
			zh = 6.3,
			ja = 4.366
		}
		local var_130_1 = manager.audio:GetLocalizationFlag()

		if var_130_0[var_130_1] ~= nil then
			arg_130_1.duration_ = var_130_0[var_130_1]
		end

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play416191032(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = 0
			local var_133_1 = 0.525

			if var_133_0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_0 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				local var_133_2 = arg_130_1:FormatText(StoryNameCfg[36].name)

				arg_130_1.leftNameTxt_.text = var_133_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_3 = arg_130_1:GetWordFromCfg(416191031)
				local var_133_4 = arg_130_1:FormatText(var_133_3.content)

				arg_130_1.text_.text = var_133_4

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_5 = 21
				local var_133_6 = utf8.len(var_133_4)
				local var_133_7 = var_133_5 <= 0 and var_133_1 or var_133_1 * (var_133_6 / var_133_5)

				if var_133_7 > 0 and var_133_1 < var_133_7 then
					arg_130_1.talkMaxDuration = var_133_7

					if var_133_7 + var_133_0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_7 + var_133_0
					end
				end

				arg_130_1.text_.text = var_133_4
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191031", "story_v_out_416191.awb") ~= 0 then
					local var_133_8 = manager.audio:GetVoiceLength("story_v_out_416191", "416191031", "story_v_out_416191.awb") / 1000

					if var_133_8 + var_133_0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_8 + var_133_0
					end

					if var_133_3.prefab_name ~= "" and arg_130_1.actors_[var_133_3.prefab_name] ~= nil then
						local var_133_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_3.prefab_name].transform, "story_v_out_416191", "416191031", "story_v_out_416191.awb")

						arg_130_1:RecordAudio("416191031", var_133_9)
						arg_130_1:RecordAudio("416191031", var_133_9)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_416191", "416191031", "story_v_out_416191.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_416191", "416191031", "story_v_out_416191.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_10 = math.max(var_133_1, arg_130_1.talkMaxDuration)

			if var_133_0 <= arg_130_1.time_ and arg_130_1.time_ < var_133_0 + var_133_10 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_0) / var_133_10

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_0 + var_133_10 and arg_130_1.time_ < var_133_0 + var_133_10 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play416191032 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 416191032
		arg_134_1.duration_ = 5

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play416191033(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = 0.15
			local var_137_1 = 1

			if var_137_0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_0 + arg_137_0 then
				local var_137_2 = "play"
				local var_137_3 = "effect"

				arg_134_1:AudioAction(var_137_2, var_137_3, "se_story_127", "se_story_127_hot", "")
			end

			local var_137_4 = 0
			local var_137_5 = 1.15

			if var_137_4 < arg_134_1.time_ and arg_134_1.time_ <= var_137_4 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, false)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_6 = arg_134_1:GetWordFromCfg(416191032)
				local var_137_7 = arg_134_1:FormatText(var_137_6.content)

				arg_134_1.text_.text = var_137_7

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_8 = 46
				local var_137_9 = utf8.len(var_137_7)
				local var_137_10 = var_137_8 <= 0 and var_137_5 or var_137_5 * (var_137_9 / var_137_8)

				if var_137_10 > 0 and var_137_5 < var_137_10 then
					arg_134_1.talkMaxDuration = var_137_10

					if var_137_10 + var_137_4 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_10 + var_137_4
					end
				end

				arg_134_1.text_.text = var_137_7
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)
				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_11 = math.max(var_137_5, arg_134_1.talkMaxDuration)

			if var_137_4 <= arg_134_1.time_ and arg_134_1.time_ < var_137_4 + var_137_11 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_4) / var_137_11

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_4 + var_137_11 and arg_134_1.time_ < var_137_4 + var_137_11 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play416191033 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 416191033
		arg_138_1.duration_ = 12

		local var_138_0 = {
			zh = 8.966,
			ja = 12
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
				arg_138_0:Play416191034(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = 0
			local var_141_1 = 1.025

			if var_141_0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_0 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				local var_141_2 = arg_138_1:FormatText(StoryNameCfg[36].name)

				arg_138_1.leftNameTxt_.text = var_141_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_3 = arg_138_1:GetWordFromCfg(416191033)
				local var_141_4 = arg_138_1:FormatText(var_141_3.content)

				arg_138_1.text_.text = var_141_4

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_5 = 41
				local var_141_6 = utf8.len(var_141_4)
				local var_141_7 = var_141_5 <= 0 and var_141_1 or var_141_1 * (var_141_6 / var_141_5)

				if var_141_7 > 0 and var_141_1 < var_141_7 then
					arg_138_1.talkMaxDuration = var_141_7

					if var_141_7 + var_141_0 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_7 + var_141_0
					end
				end

				arg_138_1.text_.text = var_141_4
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191033", "story_v_out_416191.awb") ~= 0 then
					local var_141_8 = manager.audio:GetVoiceLength("story_v_out_416191", "416191033", "story_v_out_416191.awb") / 1000

					if var_141_8 + var_141_0 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_8 + var_141_0
					end

					if var_141_3.prefab_name ~= "" and arg_138_1.actors_[var_141_3.prefab_name] ~= nil then
						local var_141_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_3.prefab_name].transform, "story_v_out_416191", "416191033", "story_v_out_416191.awb")

						arg_138_1:RecordAudio("416191033", var_141_9)
						arg_138_1:RecordAudio("416191033", var_141_9)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_416191", "416191033", "story_v_out_416191.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_416191", "416191033", "story_v_out_416191.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_10 = math.max(var_141_1, arg_138_1.talkMaxDuration)

			if var_141_0 <= arg_138_1.time_ and arg_138_1.time_ < var_141_0 + var_141_10 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_0) / var_141_10

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_0 + var_141_10 and arg_138_1.time_ < var_141_0 + var_141_10 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play416191034 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 416191034
		arg_142_1.duration_ = 14.77

		local var_142_0 = {
			zh = 10.766,
			ja = 14.766
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
				arg_142_0:Play416191035(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = 0
			local var_145_1 = 0.9

			if var_145_0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_0 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				local var_145_2 = arg_142_1:FormatText(StoryNameCfg[36].name)

				arg_142_1.leftNameTxt_.text = var_145_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_3 = arg_142_1:GetWordFromCfg(416191034)
				local var_145_4 = arg_142_1:FormatText(var_145_3.content)

				arg_142_1.text_.text = var_145_4

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_5 = 36
				local var_145_6 = utf8.len(var_145_4)
				local var_145_7 = var_145_5 <= 0 and var_145_1 or var_145_1 * (var_145_6 / var_145_5)

				if var_145_7 > 0 and var_145_1 < var_145_7 then
					arg_142_1.talkMaxDuration = var_145_7

					if var_145_7 + var_145_0 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_7 + var_145_0
					end
				end

				arg_142_1.text_.text = var_145_4
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191034", "story_v_out_416191.awb") ~= 0 then
					local var_145_8 = manager.audio:GetVoiceLength("story_v_out_416191", "416191034", "story_v_out_416191.awb") / 1000

					if var_145_8 + var_145_0 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_8 + var_145_0
					end

					if var_145_3.prefab_name ~= "" and arg_142_1.actors_[var_145_3.prefab_name] ~= nil then
						local var_145_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_3.prefab_name].transform, "story_v_out_416191", "416191034", "story_v_out_416191.awb")

						arg_142_1:RecordAudio("416191034", var_145_9)
						arg_142_1:RecordAudio("416191034", var_145_9)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_416191", "416191034", "story_v_out_416191.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_416191", "416191034", "story_v_out_416191.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_10 = math.max(var_145_1, arg_142_1.talkMaxDuration)

			if var_145_0 <= arg_142_1.time_ and arg_142_1.time_ < var_145_0 + var_145_10 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_0) / var_145_10

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_0 + var_145_10 and arg_142_1.time_ < var_145_0 + var_145_10 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play416191035 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 416191035
		arg_146_1.duration_ = 6.2

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play416191036(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = manager.ui.mainCamera.transform
			local var_149_1 = 0

			if var_149_1 < arg_146_1.time_ and arg_146_1.time_ <= var_149_1 + arg_149_0 then
				local var_149_2 = arg_146_1.var_.effect778
				local var_149_3
				local var_149_4 = var_149_0

				if not var_149_2 then
					var_149_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), var_149_4)
					var_149_2.name = "778"
					arg_146_1.var_.effect778 = var_149_2
				else
					var_149_2.transform:SetParent(var_149_4)
				end

				var_149_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_149_2.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_149_5 = manager.ui.mainCameraCom_
				local var_149_6 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_149_5.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_149_7 = var_149_2.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_149_8 = 15
				local var_149_9 = 2 * var_149_8 * Mathf.Tan(var_149_5.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_149_5.aspect
				local var_149_10 = 1
				local var_149_11 = 1.7777777777777777

				if var_149_11 < var_149_5.aspect then
					var_149_10 = var_149_9 / (2 * var_149_8 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_149_11)
				end

				for iter_149_0, iter_149_1 in ipairs(var_149_7) do
					local var_149_12 = iter_149_1.transform.localScale

					iter_149_1.transform.localScale = Vector3.New(var_149_12.x / var_149_6 * var_149_10, var_149_12.y / var_149_6, var_149_12.z)
				end
			end

			local var_149_13 = arg_146_1.bgs_.SS1608.transform
			local var_149_14 = 0

			if var_149_14 < arg_146_1.time_ and arg_146_1.time_ <= var_149_14 + arg_149_0 then
				arg_146_1.var_.moveOldPosSS1608 = var_149_13.localPosition
			end

			local var_149_15 = 0.001

			if var_149_14 <= arg_146_1.time_ and arg_146_1.time_ < var_149_14 + var_149_15 then
				local var_149_16 = (arg_146_1.time_ - var_149_14) / var_149_15
				local var_149_17 = Vector3.New(0, 1, 10)

				var_149_13.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPosSS1608, var_149_17, var_149_16)
			end

			if arg_146_1.time_ >= var_149_14 + var_149_15 and arg_146_1.time_ < var_149_14 + var_149_15 + arg_149_0 then
				var_149_13.localPosition = Vector3.New(0, 1, 10)
			end

			local var_149_18 = arg_146_1.bgs_.SS1608.transform
			local var_149_19 = 0.034

			if var_149_19 < arg_146_1.time_ and arg_146_1.time_ <= var_149_19 + arg_149_0 then
				arg_146_1.var_.moveOldPosSS1608 = var_149_18.localPosition
			end

			local var_149_20 = 1.83266666666667

			if var_149_19 <= arg_146_1.time_ and arg_146_1.time_ < var_149_19 + var_149_20 then
				local var_149_21 = (arg_146_1.time_ - var_149_19) / var_149_20
				local var_149_22 = Vector3.New(0, 1, 9)

				var_149_18.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPosSS1608, var_149_22, var_149_21)
			end

			if arg_146_1.time_ >= var_149_19 + var_149_20 and arg_146_1.time_ < var_149_19 + var_149_20 + arg_149_0 then
				var_149_18.localPosition = Vector3.New(0, 1, 9)
			end

			if arg_146_1.frameCnt_ <= 1 then
				arg_146_1.dialog_:SetActive(false)
			end

			local var_149_23 = 1.2
			local var_149_24 = 1.425

			if var_149_23 < arg_146_1.time_ and arg_146_1.time_ <= var_149_23 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0

				arg_146_1.dialog_:SetActive(true)

				arg_146_1.dialogCg_.alpha = 0

				local var_149_25 = LeanTween.value(arg_146_1.dialog_, 0, 1, 0.3)

				var_149_25:setOnUpdate(LuaHelper.FloatAction(function(arg_150_0)
					arg_146_1.dialogCg_.alpha = arg_150_0
				end))
				var_149_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_146_1.dialog_)
					var_149_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_146_1.duration_ = arg_146_1.duration_ + 0.3

				SetActive(arg_146_1.leftNameGo_, false)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_26 = arg_146_1:GetWordFromCfg(416191035)
				local var_149_27 = arg_146_1:FormatText(var_149_26.content)

				arg_146_1.text_.text = var_149_27

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_28 = 57
				local var_149_29 = utf8.len(var_149_27)
				local var_149_30 = var_149_28 <= 0 and var_149_24 or var_149_24 * (var_149_29 / var_149_28)

				if var_149_30 > 0 and var_149_24 < var_149_30 then
					arg_146_1.talkMaxDuration = var_149_30
					var_149_23 = var_149_23 + 0.3

					if var_149_30 + var_149_23 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_30 + var_149_23
					end
				end

				arg_146_1.text_.text = var_149_27
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)
				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_31 = var_149_23 + 0.3
			local var_149_32 = math.max(var_149_24, arg_146_1.talkMaxDuration)

			if var_149_31 <= arg_146_1.time_ and arg_146_1.time_ < var_149_31 + var_149_32 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_31) / var_149_32

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_31 + var_149_32 and arg_146_1.time_ < var_149_31 + var_149_32 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS1608",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1608",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.83266666666667,
				className = "StoryMoveNode",
				startTime = 0.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_146_1:InitPlayNodeList()
	end,
	Play416191036 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 416191036
		arg_152_1.duration_ = 6.73

		local var_152_0 = {
			zh = 5.133,
			ja = 6.733
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
				arg_152_0:Play416191037(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = 0
			local var_155_1 = 0.575

			if var_155_0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_0 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_2 = arg_152_1:FormatText(StoryNameCfg[1080].name)

				arg_152_1.leftNameTxt_.text = var_155_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_3 = arg_152_1:GetWordFromCfg(416191036)
				local var_155_4 = arg_152_1:FormatText(var_155_3.content)

				arg_152_1.text_.text = var_155_4

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_5 = 23
				local var_155_6 = utf8.len(var_155_4)
				local var_155_7 = var_155_5 <= 0 and var_155_1 or var_155_1 * (var_155_6 / var_155_5)

				if var_155_7 > 0 and var_155_1 < var_155_7 then
					arg_152_1.talkMaxDuration = var_155_7

					if var_155_7 + var_155_0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_7 + var_155_0
					end
				end

				arg_152_1.text_.text = var_155_4
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191036", "story_v_out_416191.awb") ~= 0 then
					local var_155_8 = manager.audio:GetVoiceLength("story_v_out_416191", "416191036", "story_v_out_416191.awb") / 1000

					if var_155_8 + var_155_0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_8 + var_155_0
					end

					if var_155_3.prefab_name ~= "" and arg_152_1.actors_[var_155_3.prefab_name] ~= nil then
						local var_155_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_3.prefab_name].transform, "story_v_out_416191", "416191036", "story_v_out_416191.awb")

						arg_152_1:RecordAudio("416191036", var_155_9)
						arg_152_1:RecordAudio("416191036", var_155_9)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_416191", "416191036", "story_v_out_416191.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_416191", "416191036", "story_v_out_416191.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_10 = math.max(var_155_1, arg_152_1.talkMaxDuration)

			if var_155_0 <= arg_152_1.time_ and arg_152_1.time_ < var_155_0 + var_155_10 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_0) / var_155_10

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_0 + var_155_10 and arg_152_1.time_ < var_155_0 + var_155_10 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play416191037 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 416191037
		arg_156_1.duration_ = 6.43

		local var_156_0 = {
			zh = 3.9,
			ja = 6.433
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
				arg_156_0:Play416191038(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = 0
			local var_159_1 = 0.325

			if var_159_0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_0 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_2 = arg_156_1:FormatText(StoryNameCfg[1080].name)

				arg_156_1.leftNameTxt_.text = var_159_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_3 = arg_156_1:GetWordFromCfg(416191037)
				local var_159_4 = arg_156_1:FormatText(var_159_3.content)

				arg_156_1.text_.text = var_159_4

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_5 = 13
				local var_159_6 = utf8.len(var_159_4)
				local var_159_7 = var_159_5 <= 0 and var_159_1 or var_159_1 * (var_159_6 / var_159_5)

				if var_159_7 > 0 and var_159_1 < var_159_7 then
					arg_156_1.talkMaxDuration = var_159_7

					if var_159_7 + var_159_0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_7 + var_159_0
					end
				end

				arg_156_1.text_.text = var_159_4
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191037", "story_v_out_416191.awb") ~= 0 then
					local var_159_8 = manager.audio:GetVoiceLength("story_v_out_416191", "416191037", "story_v_out_416191.awb") / 1000

					if var_159_8 + var_159_0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_8 + var_159_0
					end

					if var_159_3.prefab_name ~= "" and arg_156_1.actors_[var_159_3.prefab_name] ~= nil then
						local var_159_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_3.prefab_name].transform, "story_v_out_416191", "416191037", "story_v_out_416191.awb")

						arg_156_1:RecordAudio("416191037", var_159_9)
						arg_156_1:RecordAudio("416191037", var_159_9)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_416191", "416191037", "story_v_out_416191.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_416191", "416191037", "story_v_out_416191.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_10 = math.max(var_159_1, arg_156_1.talkMaxDuration)

			if var_159_0 <= arg_156_1.time_ and arg_156_1.time_ < var_159_0 + var_159_10 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_0) / var_159_10

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_0 + var_159_10 and arg_156_1.time_ < var_159_0 + var_159_10 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play416191038 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 416191038
		arg_160_1.duration_ = 7.67

		local var_160_0 = {
			zh = 7.666,
			ja = 5.7
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
				arg_160_0:Play416191039(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = 0
			local var_163_1 = 0.65

			if var_163_0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_0 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				local var_163_2 = arg_160_1:FormatText(StoryNameCfg[36].name)

				arg_160_1.leftNameTxt_.text = var_163_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_3 = arg_160_1:GetWordFromCfg(416191038)
				local var_163_4 = arg_160_1:FormatText(var_163_3.content)

				arg_160_1.text_.text = var_163_4

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_5 = 26
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

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191038", "story_v_out_416191.awb") ~= 0 then
					local var_163_8 = manager.audio:GetVoiceLength("story_v_out_416191", "416191038", "story_v_out_416191.awb") / 1000

					if var_163_8 + var_163_0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_8 + var_163_0
					end

					if var_163_3.prefab_name ~= "" and arg_160_1.actors_[var_163_3.prefab_name] ~= nil then
						local var_163_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_3.prefab_name].transform, "story_v_out_416191", "416191038", "story_v_out_416191.awb")

						arg_160_1:RecordAudio("416191038", var_163_9)
						arg_160_1:RecordAudio("416191038", var_163_9)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_416191", "416191038", "story_v_out_416191.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_416191", "416191038", "story_v_out_416191.awb")
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
	Play416191039 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 416191039
		arg_164_1.duration_ = 5.27

		local var_164_0 = {
			zh = 4.3,
			ja = 5.266
		}
		local var_164_1 = manager.audio:GetLocalizationFlag()

		if var_164_0[var_164_1] ~= nil then
			arg_164_1.duration_ = var_164_0[var_164_1]
		end

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play416191040(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = 0
			local var_167_1 = 0.425

			if var_167_0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_0 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				local var_167_2 = arg_164_1:FormatText(StoryNameCfg[1080].name)

				arg_164_1.leftNameTxt_.text = var_167_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_3 = arg_164_1:GetWordFromCfg(416191039)
				local var_167_4 = arg_164_1:FormatText(var_167_3.content)

				arg_164_1.text_.text = var_167_4

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_5 = 17
				local var_167_6 = utf8.len(var_167_4)
				local var_167_7 = var_167_5 <= 0 and var_167_1 or var_167_1 * (var_167_6 / var_167_5)

				if var_167_7 > 0 and var_167_1 < var_167_7 then
					arg_164_1.talkMaxDuration = var_167_7

					if var_167_7 + var_167_0 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_7 + var_167_0
					end
				end

				arg_164_1.text_.text = var_167_4
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191039", "story_v_out_416191.awb") ~= 0 then
					local var_167_8 = manager.audio:GetVoiceLength("story_v_out_416191", "416191039", "story_v_out_416191.awb") / 1000

					if var_167_8 + var_167_0 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_8 + var_167_0
					end

					if var_167_3.prefab_name ~= "" and arg_164_1.actors_[var_167_3.prefab_name] ~= nil then
						local var_167_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_3.prefab_name].transform, "story_v_out_416191", "416191039", "story_v_out_416191.awb")

						arg_164_1:RecordAudio("416191039", var_167_9)
						arg_164_1:RecordAudio("416191039", var_167_9)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_416191", "416191039", "story_v_out_416191.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_416191", "416191039", "story_v_out_416191.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_10 = math.max(var_167_1, arg_164_1.talkMaxDuration)

			if var_167_0 <= arg_164_1.time_ and arg_164_1.time_ < var_167_0 + var_167_10 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_0) / var_167_10

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_0 + var_167_10 and arg_164_1.time_ < var_167_0 + var_167_10 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play416191040 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 416191040
		arg_168_1.duration_ = 9.97

		local var_168_0 = {
			zh = 5.666,
			ja = 9.966
		}
		local var_168_1 = manager.audio:GetLocalizationFlag()

		if var_168_0[var_168_1] ~= nil then
			arg_168_1.duration_ = var_168_0[var_168_1]
		end

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play416191041(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = 0
			local var_171_1 = 0.525

			if var_171_0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_0 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				local var_171_2 = arg_168_1:FormatText(StoryNameCfg[1080].name)

				arg_168_1.leftNameTxt_.text = var_171_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_3 = arg_168_1:GetWordFromCfg(416191040)
				local var_171_4 = arg_168_1:FormatText(var_171_3.content)

				arg_168_1.text_.text = var_171_4

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_5 = 21
				local var_171_6 = utf8.len(var_171_4)
				local var_171_7 = var_171_5 <= 0 and var_171_1 or var_171_1 * (var_171_6 / var_171_5)

				if var_171_7 > 0 and var_171_1 < var_171_7 then
					arg_168_1.talkMaxDuration = var_171_7

					if var_171_7 + var_171_0 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_7 + var_171_0
					end
				end

				arg_168_1.text_.text = var_171_4
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191040", "story_v_out_416191.awb") ~= 0 then
					local var_171_8 = manager.audio:GetVoiceLength("story_v_out_416191", "416191040", "story_v_out_416191.awb") / 1000

					if var_171_8 + var_171_0 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_8 + var_171_0
					end

					if var_171_3.prefab_name ~= "" and arg_168_1.actors_[var_171_3.prefab_name] ~= nil then
						local var_171_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_3.prefab_name].transform, "story_v_out_416191", "416191040", "story_v_out_416191.awb")

						arg_168_1:RecordAudio("416191040", var_171_9)
						arg_168_1:RecordAudio("416191040", var_171_9)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_416191", "416191040", "story_v_out_416191.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_416191", "416191040", "story_v_out_416191.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_10 = math.max(var_171_1, arg_168_1.talkMaxDuration)

			if var_171_0 <= arg_168_1.time_ and arg_168_1.time_ < var_171_0 + var_171_10 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_0) / var_171_10

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_0 + var_171_10 and arg_168_1.time_ < var_171_0 + var_171_10 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play416191041 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 416191041
		arg_172_1.duration_ = 6.03

		local var_172_0 = {
			zh = 6.033,
			ja = 5.433
		}
		local var_172_1 = manager.audio:GetLocalizationFlag()

		if var_172_0[var_172_1] ~= nil then
			arg_172_1.duration_ = var_172_0[var_172_1]
		end

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play416191042(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = 0
			local var_175_1 = 0.275

			if var_175_0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_0 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				local var_175_2 = arg_172_1:FormatText(StoryNameCfg[36].name)

				arg_172_1.leftNameTxt_.text = var_175_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_3 = arg_172_1:GetWordFromCfg(416191041)
				local var_175_4 = arg_172_1:FormatText(var_175_3.content)

				arg_172_1.text_.text = var_175_4

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_5 = 11
				local var_175_6 = utf8.len(var_175_4)
				local var_175_7 = var_175_5 <= 0 and var_175_1 or var_175_1 * (var_175_6 / var_175_5)

				if var_175_7 > 0 and var_175_1 < var_175_7 then
					arg_172_1.talkMaxDuration = var_175_7

					if var_175_7 + var_175_0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_7 + var_175_0
					end
				end

				arg_172_1.text_.text = var_175_4
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191041", "story_v_out_416191.awb") ~= 0 then
					local var_175_8 = manager.audio:GetVoiceLength("story_v_out_416191", "416191041", "story_v_out_416191.awb") / 1000

					if var_175_8 + var_175_0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_8 + var_175_0
					end

					if var_175_3.prefab_name ~= "" and arg_172_1.actors_[var_175_3.prefab_name] ~= nil then
						local var_175_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_3.prefab_name].transform, "story_v_out_416191", "416191041", "story_v_out_416191.awb")

						arg_172_1:RecordAudio("416191041", var_175_9)
						arg_172_1:RecordAudio("416191041", var_175_9)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_416191", "416191041", "story_v_out_416191.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_416191", "416191041", "story_v_out_416191.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_10 = math.max(var_175_1, arg_172_1.talkMaxDuration)

			if var_175_0 <= arg_172_1.time_ and arg_172_1.time_ < var_175_0 + var_175_10 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_0) / var_175_10

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_0 + var_175_10 and arg_172_1.time_ < var_175_0 + var_175_10 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play416191042 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 416191042
		arg_176_1.duration_ = 6.67

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play416191043(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = 0.766666666666667

			if var_179_0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_0 + arg_179_0 then
				local var_179_1 = manager.ui.mainCamera.transform.localPosition
				local var_179_2 = Vector3.New(0, 0, 10) + Vector3.New(var_179_1.x, var_179_1.y, 0)
				local var_179_3 = arg_176_1.bgs_.STwhite

				var_179_3.transform.localPosition = var_179_2
				var_179_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_179_4 = var_179_3:GetComponent("SpriteRenderer")

				if var_179_4 and var_179_4.sprite then
					local var_179_5 = (var_179_3.transform.localPosition - var_179_1).z
					local var_179_6 = manager.ui.mainCameraCom_
					local var_179_7 = 2 * var_179_5 * Mathf.Tan(var_179_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_179_8 = var_179_7 * var_179_6.aspect
					local var_179_9 = var_179_4.sprite.bounds.size.x
					local var_179_10 = var_179_4.sprite.bounds.size.y
					local var_179_11 = var_179_8 / var_179_9
					local var_179_12 = var_179_7 / var_179_10
					local var_179_13 = var_179_12 < var_179_11 and var_179_11 or var_179_12

					var_179_3.transform.localScale = Vector3.New(var_179_13, var_179_13, 0)
				end

				for iter_179_0, iter_179_1 in pairs(arg_176_1.bgs_) do
					if iter_179_0 ~= "STwhite" then
						iter_179_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_179_14 = 0

			if var_179_14 < arg_176_1.time_ and arg_176_1.time_ <= var_179_14 + arg_179_0 then
				arg_176_1.mask_.enabled = true
				arg_176_1.mask_.raycastTarget = true

				arg_176_1:SetGaussion(false)
			end

			local var_179_15 = 0.766666666666667

			if var_179_14 <= arg_176_1.time_ and arg_176_1.time_ < var_179_14 + var_179_15 then
				local var_179_16 = (arg_176_1.time_ - var_179_14) / var_179_15
				local var_179_17 = Color.New(1, 1, 1)

				var_179_17.a = Mathf.Lerp(0, 1, var_179_16)
				arg_176_1.mask_.color = var_179_17
			end

			if arg_176_1.time_ >= var_179_14 + var_179_15 and arg_176_1.time_ < var_179_14 + var_179_15 + arg_179_0 then
				local var_179_18 = Color.New(1, 1, 1)

				var_179_18.a = 1
				arg_176_1.mask_.color = var_179_18
			end

			local var_179_19 = 0.766666666666667

			if var_179_19 < arg_176_1.time_ and arg_176_1.time_ <= var_179_19 + arg_179_0 then
				arg_176_1.mask_.enabled = true
				arg_176_1.mask_.raycastTarget = true

				arg_176_1:SetGaussion(false)
			end

			local var_179_20 = 1.23333333333333

			if var_179_19 <= arg_176_1.time_ and arg_176_1.time_ < var_179_19 + var_179_20 then
				local var_179_21 = (arg_176_1.time_ - var_179_19) / var_179_20
				local var_179_22 = Color.New(1, 1, 1)

				var_179_22.a = Mathf.Lerp(1, 0, var_179_21)
				arg_176_1.mask_.color = var_179_22
			end

			if arg_176_1.time_ >= var_179_19 + var_179_20 and arg_176_1.time_ < var_179_19 + var_179_20 + arg_179_0 then
				local var_179_23 = Color.New(1, 1, 1)
				local var_179_24 = 0

				arg_176_1.mask_.enabled = false
				var_179_23.a = var_179_24
				arg_176_1.mask_.color = var_179_23
			end

			local var_179_25 = 1.33333333333333
			local var_179_26 = 1

			if var_179_25 < arg_176_1.time_ and arg_176_1.time_ <= var_179_25 + arg_179_0 then
				local var_179_27 = "play"
				local var_179_28 = "effect"

				arg_176_1:AudioAction(var_179_27, var_179_28, "se_story_11", "se_story_11_fire", "")
			end

			if arg_176_1.frameCnt_ <= 1 then
				arg_176_1.dialog_:SetActive(false)
			end

			local var_179_29 = 1.66666666666667
			local var_179_30 = 1.475

			if var_179_29 < arg_176_1.time_ and arg_176_1.time_ <= var_179_29 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0

				arg_176_1.dialog_:SetActive(true)

				arg_176_1.dialogCg_.alpha = 0

				local var_179_31 = LeanTween.value(arg_176_1.dialog_, 0, 1, 0.3)

				var_179_31:setOnUpdate(LuaHelper.FloatAction(function(arg_180_0)
					arg_176_1.dialogCg_.alpha = arg_180_0
				end))
				var_179_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_176_1.dialog_)
					var_179_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_176_1.duration_ = arg_176_1.duration_ + 0.3

				SetActive(arg_176_1.leftNameGo_, false)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_32 = arg_176_1:GetWordFromCfg(416191042)
				local var_179_33 = arg_176_1:FormatText(var_179_32.content)

				arg_176_1.text_.text = var_179_33

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_34 = 59
				local var_179_35 = utf8.len(var_179_33)
				local var_179_36 = var_179_34 <= 0 and var_179_30 or var_179_30 * (var_179_35 / var_179_34)

				if var_179_36 > 0 and var_179_30 < var_179_36 then
					arg_176_1.talkMaxDuration = var_179_36
					var_179_29 = var_179_29 + 0.3

					if var_179_36 + var_179_29 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_36 + var_179_29
					end
				end

				arg_176_1.text_.text = var_179_33
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)
				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_37 = var_179_29 + 0.3
			local var_179_38 = math.max(var_179_30, arg_176_1.talkMaxDuration)

			if var_179_37 <= arg_176_1.time_ and arg_176_1.time_ < var_179_37 + var_179_38 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_37) / var_179_38

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_37 + var_179_38 and arg_176_1.time_ < var_179_37 + var_179_38 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play416191043 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 416191043
		arg_182_1.duration_ = 8.17

		local var_182_0 = {
			zh = 6.866,
			ja = 8.166
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
				arg_182_0:Play416191044(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = 0
			local var_185_1 = 0.525

			if var_185_0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_0 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				local var_185_2 = arg_182_1:FormatText(StoryNameCfg[1080].name)

				arg_182_1.leftNameTxt_.text = var_185_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, true)
				arg_182_1.iconController_:SetSelectedState("hero")

				arg_182_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1086_split_6")

				arg_182_1.callingController_:SetSelectedState("normal")

				arg_182_1.keyicon_.color = Color.New(1, 1, 1)
				arg_182_1.icon_.color = Color.New(1, 1, 1)

				local var_185_3 = arg_182_1:GetWordFromCfg(416191043)
				local var_185_4 = arg_182_1:FormatText(var_185_3.content)

				arg_182_1.text_.text = var_185_4

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_5 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191043", "story_v_out_416191.awb") ~= 0 then
					local var_185_8 = manager.audio:GetVoiceLength("story_v_out_416191", "416191043", "story_v_out_416191.awb") / 1000

					if var_185_8 + var_185_0 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_8 + var_185_0
					end

					if var_185_3.prefab_name ~= "" and arg_182_1.actors_[var_185_3.prefab_name] ~= nil then
						local var_185_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_3.prefab_name].transform, "story_v_out_416191", "416191043", "story_v_out_416191.awb")

						arg_182_1:RecordAudio("416191043", var_185_9)
						arg_182_1:RecordAudio("416191043", var_185_9)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_416191", "416191043", "story_v_out_416191.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_416191", "416191043", "story_v_out_416191.awb")
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
	Play416191044 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 416191044
		arg_186_1.duration_ = 5

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play416191045(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = 0
			local var_189_1 = 1.125

			if var_189_0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_0 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0

				arg_186_1.dialog_:SetActive(true)

				arg_186_1.dialogCg_.alpha = 0

				local var_189_2 = LeanTween.value(arg_186_1.dialog_, 0, 1, 0.3)

				var_189_2:setOnUpdate(LuaHelper.FloatAction(function(arg_190_0)
					arg_186_1.dialogCg_.alpha = arg_190_0
				end))
				var_189_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_186_1.dialog_)
					var_189_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_186_1.duration_ = arg_186_1.duration_ + 0.3

				SetActive(arg_186_1.leftNameGo_, false)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_3 = arg_186_1:GetWordFromCfg(416191044)
				local var_189_4 = arg_186_1:FormatText(var_189_3.content)

				arg_186_1.text_.text = var_189_4

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_5 = 45
				local var_189_6 = utf8.len(var_189_4)
				local var_189_7 = var_189_5 <= 0 and var_189_1 or var_189_1 * (var_189_6 / var_189_5)

				if var_189_7 > 0 and var_189_1 < var_189_7 then
					arg_186_1.talkMaxDuration = var_189_7
					var_189_0 = var_189_0 + 0.3

					if var_189_7 + var_189_0 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_7 + var_189_0
					end
				end

				arg_186_1.text_.text = var_189_4
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)
				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_8 = var_189_0 + 0.3
			local var_189_9 = math.max(var_189_1, arg_186_1.talkMaxDuration)

			if var_189_8 <= arg_186_1.time_ and arg_186_1.time_ < var_189_8 + var_189_9 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_8) / var_189_9

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_8 + var_189_9 and arg_186_1.time_ < var_189_8 + var_189_9 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play416191045 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 416191045
		arg_192_1.duration_ = 7.77

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play416191046(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = "F09f"

			if arg_192_1.bgs_[var_195_0] == nil then
				local var_195_1 = Object.Instantiate(arg_192_1.paintGo_)

				var_195_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_195_0)
				var_195_1.name = var_195_0
				var_195_1.transform.parent = arg_192_1.stage_.transform
				var_195_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_192_1.bgs_[var_195_0] = var_195_1
			end

			local var_195_2 = 1.33333333333333

			if var_195_2 < arg_192_1.time_ and arg_192_1.time_ <= var_195_2 + arg_195_0 then
				local var_195_3 = manager.ui.mainCamera.transform.localPosition
				local var_195_4 = Vector3.New(0, 0, 10) + Vector3.New(var_195_3.x, var_195_3.y, 0)
				local var_195_5 = arg_192_1.bgs_.F09f

				var_195_5.transform.localPosition = var_195_4
				var_195_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_195_6 = var_195_5:GetComponent("SpriteRenderer")

				if var_195_6 and var_195_6.sprite then
					local var_195_7 = (var_195_5.transform.localPosition - var_195_3).z
					local var_195_8 = manager.ui.mainCameraCom_
					local var_195_9 = 2 * var_195_7 * Mathf.Tan(var_195_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_195_10 = var_195_9 * var_195_8.aspect
					local var_195_11 = var_195_6.sprite.bounds.size.x
					local var_195_12 = var_195_6.sprite.bounds.size.y
					local var_195_13 = var_195_10 / var_195_11
					local var_195_14 = var_195_9 / var_195_12
					local var_195_15 = var_195_14 < var_195_13 and var_195_13 or var_195_14

					var_195_5.transform.localScale = Vector3.New(var_195_15, var_195_15, 0)
				end

				for iter_195_0, iter_195_1 in pairs(arg_192_1.bgs_) do
					if iter_195_0 ~= "F09f" then
						iter_195_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_195_16 = 0

			if var_195_16 < arg_192_1.time_ and arg_192_1.time_ <= var_195_16 + arg_195_0 then
				arg_192_1.allBtn_.enabled = false
			end

			local var_195_17 = 0.3

			if arg_192_1.time_ >= var_195_16 + var_195_17 and arg_192_1.time_ < var_195_16 + var_195_17 + arg_195_0 then
				arg_192_1.allBtn_.enabled = true
			end

			local var_195_18 = 0

			if var_195_18 < arg_192_1.time_ and arg_192_1.time_ <= var_195_18 + arg_195_0 then
				arg_192_1.mask_.enabled = true
				arg_192_1.mask_.raycastTarget = true

				arg_192_1:SetGaussion(false)
			end

			local var_195_19 = 1.33333333333333

			if var_195_18 <= arg_192_1.time_ and arg_192_1.time_ < var_195_18 + var_195_19 then
				local var_195_20 = (arg_192_1.time_ - var_195_18) / var_195_19
				local var_195_21 = Color.New(0, 0, 0)

				var_195_21.a = Mathf.Lerp(0, 1, var_195_20)
				arg_192_1.mask_.color = var_195_21
			end

			if arg_192_1.time_ >= var_195_18 + var_195_19 and arg_192_1.time_ < var_195_18 + var_195_19 + arg_195_0 then
				local var_195_22 = Color.New(0, 0, 0)

				var_195_22.a = 1
				arg_192_1.mask_.color = var_195_22
			end

			local var_195_23 = 1.33333333333333

			if var_195_23 < arg_192_1.time_ and arg_192_1.time_ <= var_195_23 + arg_195_0 then
				arg_192_1.mask_.enabled = true
				arg_192_1.mask_.raycastTarget = true

				arg_192_1:SetGaussion(false)
			end

			local var_195_24 = 1.53333333333333

			if var_195_23 <= arg_192_1.time_ and arg_192_1.time_ < var_195_23 + var_195_24 then
				local var_195_25 = (arg_192_1.time_ - var_195_23) / var_195_24
				local var_195_26 = Color.New(0, 0, 0)

				var_195_26.a = Mathf.Lerp(1, 0, var_195_25)
				arg_192_1.mask_.color = var_195_26
			end

			if arg_192_1.time_ >= var_195_23 + var_195_24 and arg_192_1.time_ < var_195_23 + var_195_24 + arg_195_0 then
				local var_195_27 = Color.New(0, 0, 0)
				local var_195_28 = 0

				arg_192_1.mask_.enabled = false
				var_195_27.a = var_195_28
				arg_192_1.mask_.color = var_195_27
			end

			local var_195_29 = 1.33333333333333
			local var_195_30 = 1

			if var_195_29 < arg_192_1.time_ and arg_192_1.time_ <= var_195_29 + arg_195_0 then
				local var_195_31 = "play"
				local var_195_32 = "effect"

				arg_192_1:AudioAction(var_195_31, var_195_32, "se_story_139", "se_story_139_metalhit03", "")
			end

			if arg_192_1.frameCnt_ <= 1 then
				arg_192_1.dialog_:SetActive(false)
			end

			local var_195_33 = 2.76666666666667
			local var_195_34 = 1.075

			if var_195_33 < arg_192_1.time_ and arg_192_1.time_ <= var_195_33 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0

				arg_192_1.dialog_:SetActive(true)

				arg_192_1.dialogCg_.alpha = 0

				local var_195_35 = LeanTween.value(arg_192_1.dialog_, 0, 1, 0.3)

				var_195_35:setOnUpdate(LuaHelper.FloatAction(function(arg_196_0)
					arg_192_1.dialogCg_.alpha = arg_196_0
				end))
				var_195_35:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_192_1.dialog_)
					var_195_35:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_192_1.duration_ = arg_192_1.duration_ + 0.3

				SetActive(arg_192_1.leftNameGo_, false)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_36 = arg_192_1:GetWordFromCfg(416191045)
				local var_195_37 = arg_192_1:FormatText(var_195_36.content)

				arg_192_1.text_.text = var_195_37

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_38 = 43
				local var_195_39 = utf8.len(var_195_37)
				local var_195_40 = var_195_38 <= 0 and var_195_34 or var_195_34 * (var_195_39 / var_195_38)

				if var_195_40 > 0 and var_195_34 < var_195_40 then
					arg_192_1.talkMaxDuration = var_195_40
					var_195_33 = var_195_33 + 0.3

					if var_195_40 + var_195_33 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_40 + var_195_33
					end
				end

				arg_192_1.text_.text = var_195_37
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)
				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_41 = var_195_33 + 0.3
			local var_195_42 = math.max(var_195_34, arg_192_1.talkMaxDuration)

			if var_195_41 <= arg_192_1.time_ and arg_192_1.time_ < var_195_41 + var_195_42 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_41) / var_195_42

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_41 + var_195_42 and arg_192_1.time_ < var_195_41 + var_195_42 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play416191046 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 416191046
		arg_198_1.duration_ = 6

		local var_198_0 = {
			zh = 6,
			ja = 3.1
		}
		local var_198_1 = manager.audio:GetLocalizationFlag()

		if var_198_0[var_198_1] ~= nil then
			arg_198_1.duration_ = var_198_0[var_198_1]
		end

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play416191047(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = "1028"

			if arg_198_1.actors_[var_201_0] == nil then
				local var_201_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1028")

				if not isNil(var_201_1) then
					local var_201_2 = Object.Instantiate(var_201_1, arg_198_1.canvasGo_.transform)

					var_201_2.transform:SetSiblingIndex(1)

					var_201_2.name = var_201_0
					var_201_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_198_1.actors_[var_201_0] = var_201_2

					local var_201_3 = var_201_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_198_1.isInRecall_ then
						for iter_201_0, iter_201_1 in ipairs(var_201_3) do
							iter_201_1.color = arg_198_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_201_4 = arg_198_1.actors_["1028"]
			local var_201_5 = 0

			if var_201_5 < arg_198_1.time_ and arg_198_1.time_ <= var_201_5 + arg_201_0 and not isNil(var_201_4) and arg_198_1.var_.actorSpriteComps1028 == nil then
				arg_198_1.var_.actorSpriteComps1028 = var_201_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_201_6 = 0.2

			if var_201_5 <= arg_198_1.time_ and arg_198_1.time_ < var_201_5 + var_201_6 and not isNil(var_201_4) then
				local var_201_7 = (arg_198_1.time_ - var_201_5) / var_201_6

				if arg_198_1.var_.actorSpriteComps1028 then
					for iter_201_2, iter_201_3 in pairs(arg_198_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_201_3 then
							if arg_198_1.isInRecall_ then
								local var_201_8 = Mathf.Lerp(iter_201_3.color.r, arg_198_1.hightColor1.r, var_201_7)
								local var_201_9 = Mathf.Lerp(iter_201_3.color.g, arg_198_1.hightColor1.g, var_201_7)
								local var_201_10 = Mathf.Lerp(iter_201_3.color.b, arg_198_1.hightColor1.b, var_201_7)

								iter_201_3.color = Color.New(var_201_8, var_201_9, var_201_10)
							else
								local var_201_11 = Mathf.Lerp(iter_201_3.color.r, 1, var_201_7)

								iter_201_3.color = Color.New(var_201_11, var_201_11, var_201_11)
							end
						end
					end
				end
			end

			if arg_198_1.time_ >= var_201_5 + var_201_6 and arg_198_1.time_ < var_201_5 + var_201_6 + arg_201_0 and not isNil(var_201_4) and arg_198_1.var_.actorSpriteComps1028 then
				for iter_201_4, iter_201_5 in pairs(arg_198_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_201_5 then
						if arg_198_1.isInRecall_ then
							iter_201_5.color = arg_198_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_201_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_198_1.var_.actorSpriteComps1028 = nil
			end

			local var_201_12 = arg_198_1.actors_["1028"].transform
			local var_201_13 = 0

			if var_201_13 < arg_198_1.time_ and arg_198_1.time_ <= var_201_13 + arg_201_0 then
				arg_198_1.var_.moveOldPos1028 = var_201_12.localPosition
				var_201_12.localScale = Vector3.New(1, 1, 1)

				arg_198_1:CheckSpriteTmpPos("1028", 3)

				local var_201_14 = var_201_12.childCount

				for iter_201_6 = 0, var_201_14 - 1 do
					local var_201_15 = var_201_12:GetChild(iter_201_6)

					if var_201_15.name == "split_2" or not string.find(var_201_15.name, "split") then
						var_201_15.gameObject:SetActive(true)
					else
						var_201_15.gameObject:SetActive(false)
					end
				end
			end

			local var_201_16 = 0.001

			if var_201_13 <= arg_198_1.time_ and arg_198_1.time_ < var_201_13 + var_201_16 then
				local var_201_17 = (arg_198_1.time_ - var_201_13) / var_201_16
				local var_201_18 = Vector3.New(0, -402.7, -156.1)

				var_201_12.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPos1028, var_201_18, var_201_17)
			end

			if arg_198_1.time_ >= var_201_13 + var_201_16 and arg_198_1.time_ < var_201_13 + var_201_16 + arg_201_0 then
				var_201_12.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			local var_201_19 = 0
			local var_201_20 = 0.25

			if var_201_19 < arg_198_1.time_ and arg_198_1.time_ <= var_201_19 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				local var_201_21 = arg_198_1:FormatText(StoryNameCfg[327].name)

				arg_198_1.leftNameTxt_.text = var_201_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_22 = arg_198_1:GetWordFromCfg(416191046)
				local var_201_23 = arg_198_1:FormatText(var_201_22.content)

				arg_198_1.text_.text = var_201_23

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_24 = 10
				local var_201_25 = utf8.len(var_201_23)
				local var_201_26 = var_201_24 <= 0 and var_201_20 or var_201_20 * (var_201_25 / var_201_24)

				if var_201_26 > 0 and var_201_20 < var_201_26 then
					arg_198_1.talkMaxDuration = var_201_26

					if var_201_26 + var_201_19 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_26 + var_201_19
					end
				end

				arg_198_1.text_.text = var_201_23
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191046", "story_v_out_416191.awb") ~= 0 then
					local var_201_27 = manager.audio:GetVoiceLength("story_v_out_416191", "416191046", "story_v_out_416191.awb") / 1000

					if var_201_27 + var_201_19 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_27 + var_201_19
					end

					if var_201_22.prefab_name ~= "" and arg_198_1.actors_[var_201_22.prefab_name] ~= nil then
						local var_201_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_22.prefab_name].transform, "story_v_out_416191", "416191046", "story_v_out_416191.awb")

						arg_198_1:RecordAudio("416191046", var_201_28)
						arg_198_1:RecordAudio("416191046", var_201_28)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_416191", "416191046", "story_v_out_416191.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_416191", "416191046", "story_v_out_416191.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_29 = math.max(var_201_20, arg_198_1.talkMaxDuration)

			if var_201_19 <= arg_198_1.time_ and arg_198_1.time_ < var_201_19 + var_201_29 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_19) / var_201_29

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_19 + var_201_29 and arg_198_1.time_ < var_201_19 + var_201_29 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_198_1:InitPlayNodeList()
	end,
	Play416191047 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 416191047
		arg_202_1.duration_ = 6.1

		local var_202_0 = {
			zh = 6.1,
			ja = 5.866
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
				arg_202_0:Play416191048(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = "1086"

			if arg_202_1.actors_[var_205_0] == nil then
				local var_205_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1086")

				if not isNil(var_205_1) then
					local var_205_2 = Object.Instantiate(var_205_1, arg_202_1.canvasGo_.transform)

					var_205_2.transform:SetSiblingIndex(1)

					var_205_2.name = var_205_0
					var_205_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_202_1.actors_[var_205_0] = var_205_2

					local var_205_3 = var_205_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_202_1.isInRecall_ then
						for iter_205_0, iter_205_1 in ipairs(var_205_3) do
							iter_205_1.color = arg_202_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_205_4 = arg_202_1.actors_["1086"]
			local var_205_5 = 0

			if var_205_5 < arg_202_1.time_ and arg_202_1.time_ <= var_205_5 + arg_205_0 and not isNil(var_205_4) and arg_202_1.var_.actorSpriteComps1086 == nil then
				arg_202_1.var_.actorSpriteComps1086 = var_205_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_205_6 = 0.2

			if var_205_5 <= arg_202_1.time_ and arg_202_1.time_ < var_205_5 + var_205_6 and not isNil(var_205_4) then
				local var_205_7 = (arg_202_1.time_ - var_205_5) / var_205_6

				if arg_202_1.var_.actorSpriteComps1086 then
					for iter_205_2, iter_205_3 in pairs(arg_202_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_205_3 then
							if arg_202_1.isInRecall_ then
								local var_205_8 = Mathf.Lerp(iter_205_3.color.r, arg_202_1.hightColor1.r, var_205_7)
								local var_205_9 = Mathf.Lerp(iter_205_3.color.g, arg_202_1.hightColor1.g, var_205_7)
								local var_205_10 = Mathf.Lerp(iter_205_3.color.b, arg_202_1.hightColor1.b, var_205_7)

								iter_205_3.color = Color.New(var_205_8, var_205_9, var_205_10)
							else
								local var_205_11 = Mathf.Lerp(iter_205_3.color.r, 1, var_205_7)

								iter_205_3.color = Color.New(var_205_11, var_205_11, var_205_11)
							end
						end
					end
				end
			end

			if arg_202_1.time_ >= var_205_5 + var_205_6 and arg_202_1.time_ < var_205_5 + var_205_6 + arg_205_0 and not isNil(var_205_4) and arg_202_1.var_.actorSpriteComps1086 then
				for iter_205_4, iter_205_5 in pairs(arg_202_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_205_5 then
						if arg_202_1.isInRecall_ then
							iter_205_5.color = arg_202_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_205_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_202_1.var_.actorSpriteComps1086 = nil
			end

			local var_205_12 = arg_202_1.actors_["1028"]
			local var_205_13 = 0

			if var_205_13 < arg_202_1.time_ and arg_202_1.time_ <= var_205_13 + arg_205_0 and not isNil(var_205_12) and arg_202_1.var_.actorSpriteComps1028 == nil then
				arg_202_1.var_.actorSpriteComps1028 = var_205_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_205_14 = 0.2

			if var_205_13 <= arg_202_1.time_ and arg_202_1.time_ < var_205_13 + var_205_14 and not isNil(var_205_12) then
				local var_205_15 = (arg_202_1.time_ - var_205_13) / var_205_14

				if arg_202_1.var_.actorSpriteComps1028 then
					for iter_205_6, iter_205_7 in pairs(arg_202_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_205_7 then
							if arg_202_1.isInRecall_ then
								local var_205_16 = Mathf.Lerp(iter_205_7.color.r, arg_202_1.hightColor2.r, var_205_15)
								local var_205_17 = Mathf.Lerp(iter_205_7.color.g, arg_202_1.hightColor2.g, var_205_15)
								local var_205_18 = Mathf.Lerp(iter_205_7.color.b, arg_202_1.hightColor2.b, var_205_15)

								iter_205_7.color = Color.New(var_205_16, var_205_17, var_205_18)
							else
								local var_205_19 = Mathf.Lerp(iter_205_7.color.r, 0.5, var_205_15)

								iter_205_7.color = Color.New(var_205_19, var_205_19, var_205_19)
							end
						end
					end
				end
			end

			if arg_202_1.time_ >= var_205_13 + var_205_14 and arg_202_1.time_ < var_205_13 + var_205_14 + arg_205_0 and not isNil(var_205_12) and arg_202_1.var_.actorSpriteComps1028 then
				for iter_205_8, iter_205_9 in pairs(arg_202_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_205_9 then
						if arg_202_1.isInRecall_ then
							iter_205_9.color = arg_202_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_205_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_202_1.var_.actorSpriteComps1028 = nil
			end

			local var_205_20 = arg_202_1.actors_["1028"].transform
			local var_205_21 = 0

			if var_205_21 < arg_202_1.time_ and arg_202_1.time_ <= var_205_21 + arg_205_0 then
				arg_202_1.var_.moveOldPos1028 = var_205_20.localPosition
				var_205_20.localScale = Vector3.New(1, 1, 1)

				arg_202_1:CheckSpriteTmpPos("1028", 7)

				local var_205_22 = var_205_20.childCount

				for iter_205_10 = 0, var_205_22 - 1 do
					local var_205_23 = var_205_20:GetChild(iter_205_10)

					if var_205_23.name == "" or not string.find(var_205_23.name, "split") then
						var_205_23.gameObject:SetActive(true)
					else
						var_205_23.gameObject:SetActive(false)
					end
				end
			end

			local var_205_24 = 0.001

			if var_205_21 <= arg_202_1.time_ and arg_202_1.time_ < var_205_21 + var_205_24 then
				local var_205_25 = (arg_202_1.time_ - var_205_21) / var_205_24
				local var_205_26 = Vector3.New(0, -2000, 0)

				var_205_20.localPosition = Vector3.Lerp(arg_202_1.var_.moveOldPos1028, var_205_26, var_205_25)
			end

			if arg_202_1.time_ >= var_205_21 + var_205_24 and arg_202_1.time_ < var_205_21 + var_205_24 + arg_205_0 then
				var_205_20.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_205_27 = arg_202_1.actors_["1086"].transform
			local var_205_28 = 0

			if var_205_28 < arg_202_1.time_ and arg_202_1.time_ <= var_205_28 + arg_205_0 then
				arg_202_1.var_.moveOldPos1086 = var_205_27.localPosition
				var_205_27.localScale = Vector3.New(1, 1, 1)

				arg_202_1:CheckSpriteTmpPos("1086", 3)

				local var_205_29 = var_205_27.childCount

				for iter_205_11 = 0, var_205_29 - 1 do
					local var_205_30 = var_205_27:GetChild(iter_205_11)

					if var_205_30.name == "split_6" or not string.find(var_205_30.name, "split") then
						var_205_30.gameObject:SetActive(true)
					else
						var_205_30.gameObject:SetActive(false)
					end
				end
			end

			local var_205_31 = 0.001

			if var_205_28 <= arg_202_1.time_ and arg_202_1.time_ < var_205_28 + var_205_31 then
				local var_205_32 = (arg_202_1.time_ - var_205_28) / var_205_31
				local var_205_33 = Vector3.New(0, -404.2, -237.9)

				var_205_27.localPosition = Vector3.Lerp(arg_202_1.var_.moveOldPos1086, var_205_33, var_205_32)
			end

			if arg_202_1.time_ >= var_205_28 + var_205_31 and arg_202_1.time_ < var_205_28 + var_205_31 + arg_205_0 then
				var_205_27.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_205_34 = 0
			local var_205_35 = 0.575

			if var_205_34 < arg_202_1.time_ and arg_202_1.time_ <= var_205_34 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				local var_205_36 = arg_202_1:FormatText(StoryNameCfg[1080].name)

				arg_202_1.leftNameTxt_.text = var_205_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_37 = arg_202_1:GetWordFromCfg(416191047)
				local var_205_38 = arg_202_1:FormatText(var_205_37.content)

				arg_202_1.text_.text = var_205_38

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_39 = 23
				local var_205_40 = utf8.len(var_205_38)
				local var_205_41 = var_205_39 <= 0 and var_205_35 or var_205_35 * (var_205_40 / var_205_39)

				if var_205_41 > 0 and var_205_35 < var_205_41 then
					arg_202_1.talkMaxDuration = var_205_41

					if var_205_41 + var_205_34 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_41 + var_205_34
					end
				end

				arg_202_1.text_.text = var_205_38
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191047", "story_v_out_416191.awb") ~= 0 then
					local var_205_42 = manager.audio:GetVoiceLength("story_v_out_416191", "416191047", "story_v_out_416191.awb") / 1000

					if var_205_42 + var_205_34 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_42 + var_205_34
					end

					if var_205_37.prefab_name ~= "" and arg_202_1.actors_[var_205_37.prefab_name] ~= nil then
						local var_205_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_37.prefab_name].transform, "story_v_out_416191", "416191047", "story_v_out_416191.awb")

						arg_202_1:RecordAudio("416191047", var_205_43)
						arg_202_1:RecordAudio("416191047", var_205_43)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_416191", "416191047", "story_v_out_416191.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_416191", "416191047", "story_v_out_416191.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_44 = math.max(var_205_35, arg_202_1.talkMaxDuration)

			if var_205_34 <= arg_202_1.time_ and arg_202_1.time_ < var_205_34 + var_205_44 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_34) / var_205_44

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_34 + var_205_44 and arg_202_1.time_ < var_205_34 + var_205_44 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_202_1:InitPlayNodeList()
	end,
	Play416191048 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 416191048
		arg_206_1.duration_ = 3.67

		local var_206_0 = {
			zh = 3.5,
			ja = 3.666
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
				arg_206_0:Play416191049(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = arg_206_1.actors_["1028"]
			local var_209_1 = 0

			if var_209_1 < arg_206_1.time_ and arg_206_1.time_ <= var_209_1 + arg_209_0 and not isNil(var_209_0) and arg_206_1.var_.actorSpriteComps1028 == nil then
				arg_206_1.var_.actorSpriteComps1028 = var_209_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_209_2 = 0.2

			if var_209_1 <= arg_206_1.time_ and arg_206_1.time_ < var_209_1 + var_209_2 and not isNil(var_209_0) then
				local var_209_3 = (arg_206_1.time_ - var_209_1) / var_209_2

				if arg_206_1.var_.actorSpriteComps1028 then
					for iter_209_0, iter_209_1 in pairs(arg_206_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_209_1 then
							if arg_206_1.isInRecall_ then
								local var_209_4 = Mathf.Lerp(iter_209_1.color.r, arg_206_1.hightColor1.r, var_209_3)
								local var_209_5 = Mathf.Lerp(iter_209_1.color.g, arg_206_1.hightColor1.g, var_209_3)
								local var_209_6 = Mathf.Lerp(iter_209_1.color.b, arg_206_1.hightColor1.b, var_209_3)

								iter_209_1.color = Color.New(var_209_4, var_209_5, var_209_6)
							else
								local var_209_7 = Mathf.Lerp(iter_209_1.color.r, 1, var_209_3)

								iter_209_1.color = Color.New(var_209_7, var_209_7, var_209_7)
							end
						end
					end
				end
			end

			if arg_206_1.time_ >= var_209_1 + var_209_2 and arg_206_1.time_ < var_209_1 + var_209_2 + arg_209_0 and not isNil(var_209_0) and arg_206_1.var_.actorSpriteComps1028 then
				for iter_209_2, iter_209_3 in pairs(arg_206_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_209_3 then
						if arg_206_1.isInRecall_ then
							iter_209_3.color = arg_206_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_209_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_206_1.var_.actorSpriteComps1028 = nil
			end

			local var_209_8 = arg_206_1.actors_["1086"]
			local var_209_9 = 0

			if var_209_9 < arg_206_1.time_ and arg_206_1.time_ <= var_209_9 + arg_209_0 and not isNil(var_209_8) and arg_206_1.var_.actorSpriteComps1086 == nil then
				arg_206_1.var_.actorSpriteComps1086 = var_209_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_209_10 = 0.2

			if var_209_9 <= arg_206_1.time_ and arg_206_1.time_ < var_209_9 + var_209_10 and not isNil(var_209_8) then
				local var_209_11 = (arg_206_1.time_ - var_209_9) / var_209_10

				if arg_206_1.var_.actorSpriteComps1086 then
					for iter_209_4, iter_209_5 in pairs(arg_206_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_209_5 then
							if arg_206_1.isInRecall_ then
								local var_209_12 = Mathf.Lerp(iter_209_5.color.r, arg_206_1.hightColor2.r, var_209_11)
								local var_209_13 = Mathf.Lerp(iter_209_5.color.g, arg_206_1.hightColor2.g, var_209_11)
								local var_209_14 = Mathf.Lerp(iter_209_5.color.b, arg_206_1.hightColor2.b, var_209_11)

								iter_209_5.color = Color.New(var_209_12, var_209_13, var_209_14)
							else
								local var_209_15 = Mathf.Lerp(iter_209_5.color.r, 0.5, var_209_11)

								iter_209_5.color = Color.New(var_209_15, var_209_15, var_209_15)
							end
						end
					end
				end
			end

			if arg_206_1.time_ >= var_209_9 + var_209_10 and arg_206_1.time_ < var_209_9 + var_209_10 + arg_209_0 and not isNil(var_209_8) and arg_206_1.var_.actorSpriteComps1086 then
				for iter_209_6, iter_209_7 in pairs(arg_206_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_209_7 then
						if arg_206_1.isInRecall_ then
							iter_209_7.color = arg_206_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_209_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_206_1.var_.actorSpriteComps1086 = nil
			end

			local var_209_16 = arg_206_1.actors_["1028"].transform
			local var_209_17 = 0

			if var_209_17 < arg_206_1.time_ and arg_206_1.time_ <= var_209_17 + arg_209_0 then
				arg_206_1.var_.moveOldPos1028 = var_209_16.localPosition
				var_209_16.localScale = Vector3.New(1, 1, 1)

				arg_206_1:CheckSpriteTmpPos("1028", 3)

				local var_209_18 = var_209_16.childCount

				for iter_209_8 = 0, var_209_18 - 1 do
					local var_209_19 = var_209_16:GetChild(iter_209_8)

					if var_209_19.name == "split_2" or not string.find(var_209_19.name, "split") then
						var_209_19.gameObject:SetActive(true)
					else
						var_209_19.gameObject:SetActive(false)
					end
				end
			end

			local var_209_20 = 0.001

			if var_209_17 <= arg_206_1.time_ and arg_206_1.time_ < var_209_17 + var_209_20 then
				local var_209_21 = (arg_206_1.time_ - var_209_17) / var_209_20
				local var_209_22 = Vector3.New(0, -402.7, -156.1)

				var_209_16.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos1028, var_209_22, var_209_21)
			end

			if arg_206_1.time_ >= var_209_17 + var_209_20 and arg_206_1.time_ < var_209_17 + var_209_20 + arg_209_0 then
				var_209_16.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			local var_209_23 = arg_206_1.actors_["1086"].transform
			local var_209_24 = 0

			if var_209_24 < arg_206_1.time_ and arg_206_1.time_ <= var_209_24 + arg_209_0 then
				arg_206_1.var_.moveOldPos1086 = var_209_23.localPosition
				var_209_23.localScale = Vector3.New(1, 1, 1)

				arg_206_1:CheckSpriteTmpPos("1086", 7)

				local var_209_25 = var_209_23.childCount

				for iter_209_9 = 0, var_209_25 - 1 do
					local var_209_26 = var_209_23:GetChild(iter_209_9)

					if var_209_26.name == "" or not string.find(var_209_26.name, "split") then
						var_209_26.gameObject:SetActive(true)
					else
						var_209_26.gameObject:SetActive(false)
					end
				end
			end

			local var_209_27 = 0.001

			if var_209_24 <= arg_206_1.time_ and arg_206_1.time_ < var_209_24 + var_209_27 then
				local var_209_28 = (arg_206_1.time_ - var_209_24) / var_209_27
				local var_209_29 = Vector3.New(0, -2000, 0)

				var_209_23.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos1086, var_209_29, var_209_28)
			end

			if arg_206_1.time_ >= var_209_24 + var_209_27 and arg_206_1.time_ < var_209_24 + var_209_27 + arg_209_0 then
				var_209_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_209_30 = 0
			local var_209_31 = 0.25

			if var_209_30 < arg_206_1.time_ and arg_206_1.time_ <= var_209_30 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				local var_209_32 = arg_206_1:FormatText(StoryNameCfg[327].name)

				arg_206_1.leftNameTxt_.text = var_209_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_33 = arg_206_1:GetWordFromCfg(416191048)
				local var_209_34 = arg_206_1:FormatText(var_209_33.content)

				arg_206_1.text_.text = var_209_34

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_35 = 10
				local var_209_36 = utf8.len(var_209_34)
				local var_209_37 = var_209_35 <= 0 and var_209_31 or var_209_31 * (var_209_36 / var_209_35)

				if var_209_37 > 0 and var_209_31 < var_209_37 then
					arg_206_1.talkMaxDuration = var_209_37

					if var_209_37 + var_209_30 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_37 + var_209_30
					end
				end

				arg_206_1.text_.text = var_209_34
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191048", "story_v_out_416191.awb") ~= 0 then
					local var_209_38 = manager.audio:GetVoiceLength("story_v_out_416191", "416191048", "story_v_out_416191.awb") / 1000

					if var_209_38 + var_209_30 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_38 + var_209_30
					end

					if var_209_33.prefab_name ~= "" and arg_206_1.actors_[var_209_33.prefab_name] ~= nil then
						local var_209_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_33.prefab_name].transform, "story_v_out_416191", "416191048", "story_v_out_416191.awb")

						arg_206_1:RecordAudio("416191048", var_209_39)
						arg_206_1:RecordAudio("416191048", var_209_39)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_416191", "416191048", "story_v_out_416191.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_416191", "416191048", "story_v_out_416191.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_40 = math.max(var_209_31, arg_206_1.talkMaxDuration)

			if var_209_30 <= arg_206_1.time_ and arg_206_1.time_ < var_209_30 + var_209_40 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_30) / var_209_40

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_30 + var_209_40 and arg_206_1.time_ < var_209_30 + var_209_40 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_206_1:InitPlayNodeList()
	end,
	Play416191049 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 416191049
		arg_210_1.duration_ = 5

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play416191050(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = arg_210_1.actors_["1028"]
			local var_213_1 = 0

			if var_213_1 < arg_210_1.time_ and arg_210_1.time_ <= var_213_1 + arg_213_0 and not isNil(var_213_0) and arg_210_1.var_.actorSpriteComps1028 == nil then
				arg_210_1.var_.actorSpriteComps1028 = var_213_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_213_2 = 0.2

			if var_213_1 <= arg_210_1.time_ and arg_210_1.time_ < var_213_1 + var_213_2 and not isNil(var_213_0) then
				local var_213_3 = (arg_210_1.time_ - var_213_1) / var_213_2

				if arg_210_1.var_.actorSpriteComps1028 then
					for iter_213_0, iter_213_1 in pairs(arg_210_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_213_1 then
							if arg_210_1.isInRecall_ then
								local var_213_4 = Mathf.Lerp(iter_213_1.color.r, arg_210_1.hightColor2.r, var_213_3)
								local var_213_5 = Mathf.Lerp(iter_213_1.color.g, arg_210_1.hightColor2.g, var_213_3)
								local var_213_6 = Mathf.Lerp(iter_213_1.color.b, arg_210_1.hightColor2.b, var_213_3)

								iter_213_1.color = Color.New(var_213_4, var_213_5, var_213_6)
							else
								local var_213_7 = Mathf.Lerp(iter_213_1.color.r, 0.5, var_213_3)

								iter_213_1.color = Color.New(var_213_7, var_213_7, var_213_7)
							end
						end
					end
				end
			end

			if arg_210_1.time_ >= var_213_1 + var_213_2 and arg_210_1.time_ < var_213_1 + var_213_2 + arg_213_0 and not isNil(var_213_0) and arg_210_1.var_.actorSpriteComps1028 then
				for iter_213_2, iter_213_3 in pairs(arg_210_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_213_3 then
						if arg_210_1.isInRecall_ then
							iter_213_3.color = arg_210_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_213_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_210_1.var_.actorSpriteComps1028 = nil
			end

			local var_213_8 = arg_210_1.actors_["1028"].transform
			local var_213_9 = 0

			if var_213_9 < arg_210_1.time_ and arg_210_1.time_ <= var_213_9 + arg_213_0 then
				arg_210_1.var_.moveOldPos1028 = var_213_8.localPosition
				var_213_8.localScale = Vector3.New(1, 1, 1)

				arg_210_1:CheckSpriteTmpPos("1028", 7)

				local var_213_10 = var_213_8.childCount

				for iter_213_4 = 0, var_213_10 - 1 do
					local var_213_11 = var_213_8:GetChild(iter_213_4)

					if var_213_11.name == "" or not string.find(var_213_11.name, "split") then
						var_213_11.gameObject:SetActive(true)
					else
						var_213_11.gameObject:SetActive(false)
					end
				end
			end

			local var_213_12 = 0.001

			if var_213_9 <= arg_210_1.time_ and arg_210_1.time_ < var_213_9 + var_213_12 then
				local var_213_13 = (arg_210_1.time_ - var_213_9) / var_213_12
				local var_213_14 = Vector3.New(0, -2000, 0)

				var_213_8.localPosition = Vector3.Lerp(arg_210_1.var_.moveOldPos1028, var_213_14, var_213_13)
			end

			if arg_210_1.time_ >= var_213_9 + var_213_12 and arg_210_1.time_ < var_213_9 + var_213_12 + arg_213_0 then
				var_213_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_213_15 = 0
			local var_213_16 = 1.475

			if var_213_15 < arg_210_1.time_ and arg_210_1.time_ <= var_213_15 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, false)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_17 = arg_210_1:GetWordFromCfg(416191049)
				local var_213_18 = arg_210_1:FormatText(var_213_17.content)

				arg_210_1.text_.text = var_213_18

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_19 = 59
				local var_213_20 = utf8.len(var_213_18)
				local var_213_21 = var_213_19 <= 0 and var_213_16 or var_213_16 * (var_213_20 / var_213_19)

				if var_213_21 > 0 and var_213_16 < var_213_21 then
					arg_210_1.talkMaxDuration = var_213_21

					if var_213_21 + var_213_15 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_21 + var_213_15
					end
				end

				arg_210_1.text_.text = var_213_18
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)
				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_22 = math.max(var_213_16, arg_210_1.talkMaxDuration)

			if var_213_15 <= arg_210_1.time_ and arg_210_1.time_ < var_213_15 + var_213_22 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_15) / var_213_22

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_15 + var_213_22 and arg_210_1.time_ < var_213_15 + var_213_22 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_210_1:InitPlayNodeList()
	end,
	Play416191050 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 416191050
		arg_214_1.duration_ = 5.83

		local var_214_0 = {
			zh = 5.366,
			ja = 5.833
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
				arg_214_0:Play416191051(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = arg_214_1.actors_["1028"]
			local var_217_1 = 0

			if var_217_1 < arg_214_1.time_ and arg_214_1.time_ <= var_217_1 + arg_217_0 and not isNil(var_217_0) and arg_214_1.var_.actorSpriteComps1028 == nil then
				arg_214_1.var_.actorSpriteComps1028 = var_217_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_217_2 = 0.2

			if var_217_1 <= arg_214_1.time_ and arg_214_1.time_ < var_217_1 + var_217_2 and not isNil(var_217_0) then
				local var_217_3 = (arg_214_1.time_ - var_217_1) / var_217_2

				if arg_214_1.var_.actorSpriteComps1028 then
					for iter_217_0, iter_217_1 in pairs(arg_214_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_217_1 then
							if arg_214_1.isInRecall_ then
								local var_217_4 = Mathf.Lerp(iter_217_1.color.r, arg_214_1.hightColor1.r, var_217_3)
								local var_217_5 = Mathf.Lerp(iter_217_1.color.g, arg_214_1.hightColor1.g, var_217_3)
								local var_217_6 = Mathf.Lerp(iter_217_1.color.b, arg_214_1.hightColor1.b, var_217_3)

								iter_217_1.color = Color.New(var_217_4, var_217_5, var_217_6)
							else
								local var_217_7 = Mathf.Lerp(iter_217_1.color.r, 1, var_217_3)

								iter_217_1.color = Color.New(var_217_7, var_217_7, var_217_7)
							end
						end
					end
				end
			end

			if arg_214_1.time_ >= var_217_1 + var_217_2 and arg_214_1.time_ < var_217_1 + var_217_2 + arg_217_0 and not isNil(var_217_0) and arg_214_1.var_.actorSpriteComps1028 then
				for iter_217_2, iter_217_3 in pairs(arg_214_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_217_3 then
						if arg_214_1.isInRecall_ then
							iter_217_3.color = arg_214_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_217_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_214_1.var_.actorSpriteComps1028 = nil
			end

			local var_217_8 = 0
			local var_217_9 = 0.475

			if var_217_8 < arg_214_1.time_ and arg_214_1.time_ <= var_217_8 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				local var_217_10 = arg_214_1:FormatText(StoryNameCfg[327].name)

				arg_214_1.leftNameTxt_.text = var_217_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, true)
				arg_214_1.iconController_:SetSelectedState("hero")

				arg_214_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1028_split_7")

				arg_214_1.callingController_:SetSelectedState("normal")

				arg_214_1.keyicon_.color = Color.New(1, 1, 1)
				arg_214_1.icon_.color = Color.New(1, 1, 1)

				local var_217_11 = arg_214_1:GetWordFromCfg(416191050)
				local var_217_12 = arg_214_1:FormatText(var_217_11.content)

				arg_214_1.text_.text = var_217_12

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_13 = 19
				local var_217_14 = utf8.len(var_217_12)
				local var_217_15 = var_217_13 <= 0 and var_217_9 or var_217_9 * (var_217_14 / var_217_13)

				if var_217_15 > 0 and var_217_9 < var_217_15 then
					arg_214_1.talkMaxDuration = var_217_15

					if var_217_15 + var_217_8 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_15 + var_217_8
					end
				end

				arg_214_1.text_.text = var_217_12
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191050", "story_v_out_416191.awb") ~= 0 then
					local var_217_16 = manager.audio:GetVoiceLength("story_v_out_416191", "416191050", "story_v_out_416191.awb") / 1000

					if var_217_16 + var_217_8 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_16 + var_217_8
					end

					if var_217_11.prefab_name ~= "" and arg_214_1.actors_[var_217_11.prefab_name] ~= nil then
						local var_217_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_11.prefab_name].transform, "story_v_out_416191", "416191050", "story_v_out_416191.awb")

						arg_214_1:RecordAudio("416191050", var_217_17)
						arg_214_1:RecordAudio("416191050", var_217_17)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_416191", "416191050", "story_v_out_416191.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_416191", "416191050", "story_v_out_416191.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_18 = math.max(var_217_9, arg_214_1.talkMaxDuration)

			if var_217_8 <= arg_214_1.time_ and arg_214_1.time_ < var_217_8 + var_217_18 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_8) / var_217_18

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_8 + var_217_18 and arg_214_1.time_ < var_217_8 + var_217_18 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play416191051 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 416191051
		arg_218_1.duration_ = 5

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play416191052(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = 0.233333333333333
			local var_221_1 = 1

			if var_221_0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_0 + arg_221_0 then
				local var_221_2 = "play"
				local var_221_3 = "effect"

				arg_218_1:AudioAction(var_221_2, var_221_3, "se_story_139", "se_story_139_metalhit01", "")
			end

			local var_221_4 = 0
			local var_221_5 = 1.625

			if var_221_4 < arg_218_1.time_ and arg_218_1.time_ <= var_221_4 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, false)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_6 = arg_218_1:GetWordFromCfg(416191051)
				local var_221_7 = arg_218_1:FormatText(var_221_6.content)

				arg_218_1.text_.text = var_221_7

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_8 = 65
				local var_221_9 = utf8.len(var_221_7)
				local var_221_10 = var_221_8 <= 0 and var_221_5 or var_221_5 * (var_221_9 / var_221_8)

				if var_221_10 > 0 and var_221_5 < var_221_10 then
					arg_218_1.talkMaxDuration = var_221_10

					if var_221_10 + var_221_4 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_10 + var_221_4
					end
				end

				arg_218_1.text_.text = var_221_7
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)
				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_11 = math.max(var_221_5, arg_218_1.talkMaxDuration)

			if var_221_4 <= arg_218_1.time_ and arg_218_1.time_ < var_221_4 + var_221_11 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_4) / var_221_11

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_4 + var_221_11 and arg_218_1.time_ < var_221_4 + var_221_11 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play416191052 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 416191052
		arg_222_1.duration_ = 6.73

		local var_222_0 = {
			zh = 6.733,
			ja = 4.466
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
				arg_222_0:Play416191053(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = arg_222_1.actors_["1028"]
			local var_225_1 = 0

			if var_225_1 < arg_222_1.time_ and arg_222_1.time_ <= var_225_1 + arg_225_0 and not isNil(var_225_0) and arg_222_1.var_.actorSpriteComps1028 == nil then
				arg_222_1.var_.actorSpriteComps1028 = var_225_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_225_2 = 0.2

			if var_225_1 <= arg_222_1.time_ and arg_222_1.time_ < var_225_1 + var_225_2 and not isNil(var_225_0) then
				local var_225_3 = (arg_222_1.time_ - var_225_1) / var_225_2

				if arg_222_1.var_.actorSpriteComps1028 then
					for iter_225_0, iter_225_1 in pairs(arg_222_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_225_1 then
							if arg_222_1.isInRecall_ then
								local var_225_4 = Mathf.Lerp(iter_225_1.color.r, arg_222_1.hightColor1.r, var_225_3)
								local var_225_5 = Mathf.Lerp(iter_225_1.color.g, arg_222_1.hightColor1.g, var_225_3)
								local var_225_6 = Mathf.Lerp(iter_225_1.color.b, arg_222_1.hightColor1.b, var_225_3)

								iter_225_1.color = Color.New(var_225_4, var_225_5, var_225_6)
							else
								local var_225_7 = Mathf.Lerp(iter_225_1.color.r, 1, var_225_3)

								iter_225_1.color = Color.New(var_225_7, var_225_7, var_225_7)
							end
						end
					end
				end
			end

			if arg_222_1.time_ >= var_225_1 + var_225_2 and arg_222_1.time_ < var_225_1 + var_225_2 + arg_225_0 and not isNil(var_225_0) and arg_222_1.var_.actorSpriteComps1028 then
				for iter_225_2, iter_225_3 in pairs(arg_222_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_225_3 then
						if arg_222_1.isInRecall_ then
							iter_225_3.color = arg_222_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_225_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_222_1.var_.actorSpriteComps1028 = nil
			end

			local var_225_8 = arg_222_1.actors_["1028"].transform
			local var_225_9 = 0

			if var_225_9 < arg_222_1.time_ and arg_222_1.time_ <= var_225_9 + arg_225_0 then
				arg_222_1.var_.moveOldPos1028 = var_225_8.localPosition
				var_225_8.localScale = Vector3.New(1, 1, 1)

				arg_222_1:CheckSpriteTmpPos("1028", 3)

				local var_225_10 = var_225_8.childCount

				for iter_225_4 = 0, var_225_10 - 1 do
					local var_225_11 = var_225_8:GetChild(iter_225_4)

					if var_225_11.name == "split_2" or not string.find(var_225_11.name, "split") then
						var_225_11.gameObject:SetActive(true)
					else
						var_225_11.gameObject:SetActive(false)
					end
				end
			end

			local var_225_12 = 0.001

			if var_225_9 <= arg_222_1.time_ and arg_222_1.time_ < var_225_9 + var_225_12 then
				local var_225_13 = (arg_222_1.time_ - var_225_9) / var_225_12
				local var_225_14 = Vector3.New(0, -402.7, -156.1)

				var_225_8.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos1028, var_225_14, var_225_13)
			end

			if arg_222_1.time_ >= var_225_9 + var_225_12 and arg_222_1.time_ < var_225_9 + var_225_12 + arg_225_0 then
				var_225_8.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			local var_225_15 = 0
			local var_225_16 = 0.65

			if var_225_15 < arg_222_1.time_ and arg_222_1.time_ <= var_225_15 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				local var_225_17 = arg_222_1:FormatText(StoryNameCfg[327].name)

				arg_222_1.leftNameTxt_.text = var_225_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_18 = arg_222_1:GetWordFromCfg(416191052)
				local var_225_19 = arg_222_1:FormatText(var_225_18.content)

				arg_222_1.text_.text = var_225_19

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_20 = 26
				local var_225_21 = utf8.len(var_225_19)
				local var_225_22 = var_225_20 <= 0 and var_225_16 or var_225_16 * (var_225_21 / var_225_20)

				if var_225_22 > 0 and var_225_16 < var_225_22 then
					arg_222_1.talkMaxDuration = var_225_22

					if var_225_22 + var_225_15 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_22 + var_225_15
					end
				end

				arg_222_1.text_.text = var_225_19
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191052", "story_v_out_416191.awb") ~= 0 then
					local var_225_23 = manager.audio:GetVoiceLength("story_v_out_416191", "416191052", "story_v_out_416191.awb") / 1000

					if var_225_23 + var_225_15 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_23 + var_225_15
					end

					if var_225_18.prefab_name ~= "" and arg_222_1.actors_[var_225_18.prefab_name] ~= nil then
						local var_225_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_18.prefab_name].transform, "story_v_out_416191", "416191052", "story_v_out_416191.awb")

						arg_222_1:RecordAudio("416191052", var_225_24)
						arg_222_1:RecordAudio("416191052", var_225_24)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_416191", "416191052", "story_v_out_416191.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_416191", "416191052", "story_v_out_416191.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_25 = math.max(var_225_16, arg_222_1.talkMaxDuration)

			if var_225_15 <= arg_222_1.time_ and arg_222_1.time_ < var_225_15 + var_225_25 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_15) / var_225_25

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_15 + var_225_25 and arg_222_1.time_ < var_225_15 + var_225_25 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_222_1:InitPlayNodeList()
	end,
	Play416191053 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 416191053
		arg_226_1.duration_ = 5.37

		local var_226_0 = {
			zh = 2.5,
			ja = 5.366
		}
		local var_226_1 = manager.audio:GetLocalizationFlag()

		if var_226_0[var_226_1] ~= nil then
			arg_226_1.duration_ = var_226_0[var_226_1]
		end

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play416191054(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = arg_226_1.actors_["1028"]
			local var_229_1 = 0

			if var_229_1 < arg_226_1.time_ and arg_226_1.time_ <= var_229_1 + arg_229_0 and not isNil(var_229_0) and arg_226_1.var_.actorSpriteComps1028 == nil then
				arg_226_1.var_.actorSpriteComps1028 = var_229_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_229_2 = 0.2

			if var_229_1 <= arg_226_1.time_ and arg_226_1.time_ < var_229_1 + var_229_2 and not isNil(var_229_0) then
				local var_229_3 = (arg_226_1.time_ - var_229_1) / var_229_2

				if arg_226_1.var_.actorSpriteComps1028 then
					for iter_229_0, iter_229_1 in pairs(arg_226_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_229_1 then
							if arg_226_1.isInRecall_ then
								local var_229_4 = Mathf.Lerp(iter_229_1.color.r, arg_226_1.hightColor2.r, var_229_3)
								local var_229_5 = Mathf.Lerp(iter_229_1.color.g, arg_226_1.hightColor2.g, var_229_3)
								local var_229_6 = Mathf.Lerp(iter_229_1.color.b, arg_226_1.hightColor2.b, var_229_3)

								iter_229_1.color = Color.New(var_229_4, var_229_5, var_229_6)
							else
								local var_229_7 = Mathf.Lerp(iter_229_1.color.r, 0.5, var_229_3)

								iter_229_1.color = Color.New(var_229_7, var_229_7, var_229_7)
							end
						end
					end
				end
			end

			if arg_226_1.time_ >= var_229_1 + var_229_2 and arg_226_1.time_ < var_229_1 + var_229_2 + arg_229_0 and not isNil(var_229_0) and arg_226_1.var_.actorSpriteComps1028 then
				for iter_229_2, iter_229_3 in pairs(arg_226_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_229_3 then
						if arg_226_1.isInRecall_ then
							iter_229_3.color = arg_226_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_229_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_226_1.var_.actorSpriteComps1028 = nil
			end

			local var_229_8 = 0
			local var_229_9 = 0.325

			if var_229_8 < arg_226_1.time_ and arg_226_1.time_ <= var_229_8 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				local var_229_10 = arg_226_1:FormatText(StoryNameCfg[1080].name)

				arg_226_1.leftNameTxt_.text = var_229_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, true)
				arg_226_1.iconController_:SetSelectedState("hero")

				arg_226_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1086_split_3")

				arg_226_1.callingController_:SetSelectedState("normal")

				arg_226_1.keyicon_.color = Color.New(1, 1, 1)
				arg_226_1.icon_.color = Color.New(1, 1, 1)

				local var_229_11 = arg_226_1:GetWordFromCfg(416191053)
				local var_229_12 = arg_226_1:FormatText(var_229_11.content)

				arg_226_1.text_.text = var_229_12

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_13 = 13
				local var_229_14 = utf8.len(var_229_12)
				local var_229_15 = var_229_13 <= 0 and var_229_9 or var_229_9 * (var_229_14 / var_229_13)

				if var_229_15 > 0 and var_229_9 < var_229_15 then
					arg_226_1.talkMaxDuration = var_229_15

					if var_229_15 + var_229_8 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_15 + var_229_8
					end
				end

				arg_226_1.text_.text = var_229_12
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191053", "story_v_out_416191.awb") ~= 0 then
					local var_229_16 = manager.audio:GetVoiceLength("story_v_out_416191", "416191053", "story_v_out_416191.awb") / 1000

					if var_229_16 + var_229_8 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_16 + var_229_8
					end

					if var_229_11.prefab_name ~= "" and arg_226_1.actors_[var_229_11.prefab_name] ~= nil then
						local var_229_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_11.prefab_name].transform, "story_v_out_416191", "416191053", "story_v_out_416191.awb")

						arg_226_1:RecordAudio("416191053", var_229_17)
						arg_226_1:RecordAudio("416191053", var_229_17)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_416191", "416191053", "story_v_out_416191.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_416191", "416191053", "story_v_out_416191.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_18 = math.max(var_229_9, arg_226_1.talkMaxDuration)

			if var_229_8 <= arg_226_1.time_ and arg_226_1.time_ < var_229_8 + var_229_18 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_8) / var_229_18

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_8 + var_229_18 and arg_226_1.time_ < var_229_8 + var_229_18 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play416191054 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 416191054
		arg_230_1.duration_ = 5.87

		local var_230_0 = {
			zh = 5.033,
			ja = 5.866
		}
		local var_230_1 = manager.audio:GetLocalizationFlag()

		if var_230_0[var_230_1] ~= nil then
			arg_230_1.duration_ = var_230_0[var_230_1]
		end

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play416191055(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = arg_230_1.actors_["1028"]
			local var_233_1 = 0

			if var_233_1 < arg_230_1.time_ and arg_230_1.time_ <= var_233_1 + arg_233_0 and not isNil(var_233_0) and arg_230_1.var_.actorSpriteComps1028 == nil then
				arg_230_1.var_.actorSpriteComps1028 = var_233_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_233_2 = 0.2

			if var_233_1 <= arg_230_1.time_ and arg_230_1.time_ < var_233_1 + var_233_2 and not isNil(var_233_0) then
				local var_233_3 = (arg_230_1.time_ - var_233_1) / var_233_2

				if arg_230_1.var_.actorSpriteComps1028 then
					for iter_233_0, iter_233_1 in pairs(arg_230_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_233_1 then
							if arg_230_1.isInRecall_ then
								local var_233_4 = Mathf.Lerp(iter_233_1.color.r, arg_230_1.hightColor1.r, var_233_3)
								local var_233_5 = Mathf.Lerp(iter_233_1.color.g, arg_230_1.hightColor1.g, var_233_3)
								local var_233_6 = Mathf.Lerp(iter_233_1.color.b, arg_230_1.hightColor1.b, var_233_3)

								iter_233_1.color = Color.New(var_233_4, var_233_5, var_233_6)
							else
								local var_233_7 = Mathf.Lerp(iter_233_1.color.r, 1, var_233_3)

								iter_233_1.color = Color.New(var_233_7, var_233_7, var_233_7)
							end
						end
					end
				end
			end

			if arg_230_1.time_ >= var_233_1 + var_233_2 and arg_230_1.time_ < var_233_1 + var_233_2 + arg_233_0 and not isNil(var_233_0) and arg_230_1.var_.actorSpriteComps1028 then
				for iter_233_2, iter_233_3 in pairs(arg_230_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_233_3 then
						if arg_230_1.isInRecall_ then
							iter_233_3.color = arg_230_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_233_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_230_1.var_.actorSpriteComps1028 = nil
			end

			local var_233_8 = 0
			local var_233_9 = 0.55

			if var_233_8 < arg_230_1.time_ and arg_230_1.time_ <= var_233_8 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				local var_233_10 = arg_230_1:FormatText(StoryNameCfg[327].name)

				arg_230_1.leftNameTxt_.text = var_233_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_11 = arg_230_1:GetWordFromCfg(416191054)
				local var_233_12 = arg_230_1:FormatText(var_233_11.content)

				arg_230_1.text_.text = var_233_12

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_13 = 22
				local var_233_14 = utf8.len(var_233_12)
				local var_233_15 = var_233_13 <= 0 and var_233_9 or var_233_9 * (var_233_14 / var_233_13)

				if var_233_15 > 0 and var_233_9 < var_233_15 then
					arg_230_1.talkMaxDuration = var_233_15

					if var_233_15 + var_233_8 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_15 + var_233_8
					end
				end

				arg_230_1.text_.text = var_233_12
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191054", "story_v_out_416191.awb") ~= 0 then
					local var_233_16 = manager.audio:GetVoiceLength("story_v_out_416191", "416191054", "story_v_out_416191.awb") / 1000

					if var_233_16 + var_233_8 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_16 + var_233_8
					end

					if var_233_11.prefab_name ~= "" and arg_230_1.actors_[var_233_11.prefab_name] ~= nil then
						local var_233_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_11.prefab_name].transform, "story_v_out_416191", "416191054", "story_v_out_416191.awb")

						arg_230_1:RecordAudio("416191054", var_233_17)
						arg_230_1:RecordAudio("416191054", var_233_17)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_416191", "416191054", "story_v_out_416191.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_416191", "416191054", "story_v_out_416191.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_18 = math.max(var_233_9, arg_230_1.talkMaxDuration)

			if var_233_8 <= arg_230_1.time_ and arg_230_1.time_ < var_233_8 + var_233_18 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_8) / var_233_18

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_8 + var_233_18 and arg_230_1.time_ < var_233_8 + var_233_18 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play416191055 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 416191055
		arg_234_1.duration_ = 6.43

		local var_234_0 = {
			zh = 3.9,
			ja = 6.433
		}
		local var_234_1 = manager.audio:GetLocalizationFlag()

		if var_234_0[var_234_1] ~= nil then
			arg_234_1.duration_ = var_234_0[var_234_1]
		end

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play416191056(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = arg_234_1.actors_["1028"]
			local var_237_1 = 0

			if var_237_1 < arg_234_1.time_ and arg_234_1.time_ <= var_237_1 + arg_237_0 and not isNil(var_237_0) and arg_234_1.var_.actorSpriteComps1028 == nil then
				arg_234_1.var_.actorSpriteComps1028 = var_237_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_237_2 = 0.2

			if var_237_1 <= arg_234_1.time_ and arg_234_1.time_ < var_237_1 + var_237_2 and not isNil(var_237_0) then
				local var_237_3 = (arg_234_1.time_ - var_237_1) / var_237_2

				if arg_234_1.var_.actorSpriteComps1028 then
					for iter_237_0, iter_237_1 in pairs(arg_234_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_237_1 then
							if arg_234_1.isInRecall_ then
								local var_237_4 = Mathf.Lerp(iter_237_1.color.r, arg_234_1.hightColor2.r, var_237_3)
								local var_237_5 = Mathf.Lerp(iter_237_1.color.g, arg_234_1.hightColor2.g, var_237_3)
								local var_237_6 = Mathf.Lerp(iter_237_1.color.b, arg_234_1.hightColor2.b, var_237_3)

								iter_237_1.color = Color.New(var_237_4, var_237_5, var_237_6)
							else
								local var_237_7 = Mathf.Lerp(iter_237_1.color.r, 0.5, var_237_3)

								iter_237_1.color = Color.New(var_237_7, var_237_7, var_237_7)
							end
						end
					end
				end
			end

			if arg_234_1.time_ >= var_237_1 + var_237_2 and arg_234_1.time_ < var_237_1 + var_237_2 + arg_237_0 and not isNil(var_237_0) and arg_234_1.var_.actorSpriteComps1028 then
				for iter_237_2, iter_237_3 in pairs(arg_234_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_237_3 then
						if arg_234_1.isInRecall_ then
							iter_237_3.color = arg_234_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_237_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_234_1.var_.actorSpriteComps1028 = nil
			end

			local var_237_8 = 0
			local var_237_9 = 0.325

			if var_237_8 < arg_234_1.time_ and arg_234_1.time_ <= var_237_8 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				local var_237_10 = arg_234_1:FormatText(StoryNameCfg[1080].name)

				arg_234_1.leftNameTxt_.text = var_237_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, true)
				arg_234_1.iconController_:SetSelectedState("hero")

				arg_234_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1086_split_6")

				arg_234_1.callingController_:SetSelectedState("normal")

				arg_234_1.keyicon_.color = Color.New(1, 1, 1)
				arg_234_1.icon_.color = Color.New(1, 1, 1)

				local var_237_11 = arg_234_1:GetWordFromCfg(416191055)
				local var_237_12 = arg_234_1:FormatText(var_237_11.content)

				arg_234_1.text_.text = var_237_12

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_13 = 13
				local var_237_14 = utf8.len(var_237_12)
				local var_237_15 = var_237_13 <= 0 and var_237_9 or var_237_9 * (var_237_14 / var_237_13)

				if var_237_15 > 0 and var_237_9 < var_237_15 then
					arg_234_1.talkMaxDuration = var_237_15

					if var_237_15 + var_237_8 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_15 + var_237_8
					end
				end

				arg_234_1.text_.text = var_237_12
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191055", "story_v_out_416191.awb") ~= 0 then
					local var_237_16 = manager.audio:GetVoiceLength("story_v_out_416191", "416191055", "story_v_out_416191.awb") / 1000

					if var_237_16 + var_237_8 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_16 + var_237_8
					end

					if var_237_11.prefab_name ~= "" and arg_234_1.actors_[var_237_11.prefab_name] ~= nil then
						local var_237_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_11.prefab_name].transform, "story_v_out_416191", "416191055", "story_v_out_416191.awb")

						arg_234_1:RecordAudio("416191055", var_237_17)
						arg_234_1:RecordAudio("416191055", var_237_17)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_416191", "416191055", "story_v_out_416191.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_416191", "416191055", "story_v_out_416191.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_18 = math.max(var_237_9, arg_234_1.talkMaxDuration)

			if var_237_8 <= arg_234_1.time_ and arg_234_1.time_ < var_237_8 + var_237_18 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_8) / var_237_18

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_8 + var_237_18 and arg_234_1.time_ < var_237_8 + var_237_18 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play416191056 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 416191056
		arg_238_1.duration_ = 5

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play416191057(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = arg_238_1.actors_["1028"].transform
			local var_241_1 = 0

			if var_241_1 < arg_238_1.time_ and arg_238_1.time_ <= var_241_1 + arg_241_0 then
				arg_238_1.var_.moveOldPos1028 = var_241_0.localPosition
				var_241_0.localScale = Vector3.New(1, 1, 1)

				arg_238_1:CheckSpriteTmpPos("1028", 7)

				local var_241_2 = var_241_0.childCount

				for iter_241_0 = 0, var_241_2 - 1 do
					local var_241_3 = var_241_0:GetChild(iter_241_0)

					if var_241_3.name == "" or not string.find(var_241_3.name, "split") then
						var_241_3.gameObject:SetActive(true)
					else
						var_241_3.gameObject:SetActive(false)
					end
				end
			end

			local var_241_4 = 0.001

			if var_241_1 <= arg_238_1.time_ and arg_238_1.time_ < var_241_1 + var_241_4 then
				local var_241_5 = (arg_238_1.time_ - var_241_1) / var_241_4
				local var_241_6 = Vector3.New(0, -2000, 0)

				var_241_0.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos1028, var_241_6, var_241_5)
			end

			if arg_238_1.time_ >= var_241_1 + var_241_4 and arg_238_1.time_ < var_241_1 + var_241_4 + arg_241_0 then
				var_241_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_241_7 = 0
			local var_241_8 = 1.45

			if var_241_7 < arg_238_1.time_ and arg_238_1.time_ <= var_241_7 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, false)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_9 = arg_238_1:GetWordFromCfg(416191056)
				local var_241_10 = arg_238_1:FormatText(var_241_9.content)

				arg_238_1.text_.text = var_241_10

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_11 = 58
				local var_241_12 = utf8.len(var_241_10)
				local var_241_13 = var_241_11 <= 0 and var_241_8 or var_241_8 * (var_241_12 / var_241_11)

				if var_241_13 > 0 and var_241_8 < var_241_13 then
					arg_238_1.talkMaxDuration = var_241_13

					if var_241_13 + var_241_7 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_13 + var_241_7
					end
				end

				arg_238_1.text_.text = var_241_10
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)
				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_14 = math.max(var_241_8, arg_238_1.talkMaxDuration)

			if var_241_7 <= arg_238_1.time_ and arg_238_1.time_ < var_241_7 + var_241_14 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_7) / var_241_14

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_7 + var_241_14 and arg_238_1.time_ < var_241_7 + var_241_14 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_238_1:InitPlayNodeList()
	end,
	Play416191057 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 416191057
		arg_242_1.duration_ = 7.5

		local var_242_0 = {
			zh = 7.5,
			ja = 5.8
		}
		local var_242_1 = manager.audio:GetLocalizationFlag()

		if var_242_0[var_242_1] ~= nil then
			arg_242_1.duration_ = var_242_0[var_242_1]
		end

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play416191058(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			local var_245_0 = arg_242_1.actors_["1028"]
			local var_245_1 = 0

			if var_245_1 < arg_242_1.time_ and arg_242_1.time_ <= var_245_1 + arg_245_0 and not isNil(var_245_0) and arg_242_1.var_.actorSpriteComps1028 == nil then
				arg_242_1.var_.actorSpriteComps1028 = var_245_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_245_2 = 0.2

			if var_245_1 <= arg_242_1.time_ and arg_242_1.time_ < var_245_1 + var_245_2 and not isNil(var_245_0) then
				local var_245_3 = (arg_242_1.time_ - var_245_1) / var_245_2

				if arg_242_1.var_.actorSpriteComps1028 then
					for iter_245_0, iter_245_1 in pairs(arg_242_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_245_1 then
							if arg_242_1.isInRecall_ then
								local var_245_4 = Mathf.Lerp(iter_245_1.color.r, arg_242_1.hightColor1.r, var_245_3)
								local var_245_5 = Mathf.Lerp(iter_245_1.color.g, arg_242_1.hightColor1.g, var_245_3)
								local var_245_6 = Mathf.Lerp(iter_245_1.color.b, arg_242_1.hightColor1.b, var_245_3)

								iter_245_1.color = Color.New(var_245_4, var_245_5, var_245_6)
							else
								local var_245_7 = Mathf.Lerp(iter_245_1.color.r, 1, var_245_3)

								iter_245_1.color = Color.New(var_245_7, var_245_7, var_245_7)
							end
						end
					end
				end
			end

			if arg_242_1.time_ >= var_245_1 + var_245_2 and arg_242_1.time_ < var_245_1 + var_245_2 + arg_245_0 and not isNil(var_245_0) and arg_242_1.var_.actorSpriteComps1028 then
				for iter_245_2, iter_245_3 in pairs(arg_242_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_245_3 then
						if arg_242_1.isInRecall_ then
							iter_245_3.color = arg_242_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_245_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_242_1.var_.actorSpriteComps1028 = nil
			end

			local var_245_8 = arg_242_1.actors_["1028"].transform
			local var_245_9 = 0

			if var_245_9 < arg_242_1.time_ and arg_242_1.time_ <= var_245_9 + arg_245_0 then
				arg_242_1.var_.moveOldPos1028 = var_245_8.localPosition
				var_245_8.localScale = Vector3.New(1, 1, 1)

				arg_242_1:CheckSpriteTmpPos("1028", 3)

				local var_245_10 = var_245_8.childCount

				for iter_245_4 = 0, var_245_10 - 1 do
					local var_245_11 = var_245_8:GetChild(iter_245_4)

					if var_245_11.name == "split_2" or not string.find(var_245_11.name, "split") then
						var_245_11.gameObject:SetActive(true)
					else
						var_245_11.gameObject:SetActive(false)
					end
				end
			end

			local var_245_12 = 0.001

			if var_245_9 <= arg_242_1.time_ and arg_242_1.time_ < var_245_9 + var_245_12 then
				local var_245_13 = (arg_242_1.time_ - var_245_9) / var_245_12
				local var_245_14 = Vector3.New(0, -402.7, -156.1)

				var_245_8.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos1028, var_245_14, var_245_13)
			end

			if arg_242_1.time_ >= var_245_9 + var_245_12 and arg_242_1.time_ < var_245_9 + var_245_12 + arg_245_0 then
				var_245_8.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			local var_245_15 = 0
			local var_245_16 = 0.4

			if var_245_15 < arg_242_1.time_ and arg_242_1.time_ <= var_245_15 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				local var_245_17 = arg_242_1:FormatText(StoryNameCfg[327].name)

				arg_242_1.leftNameTxt_.text = var_245_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_18 = arg_242_1:GetWordFromCfg(416191057)
				local var_245_19 = arg_242_1:FormatText(var_245_18.content)

				arg_242_1.text_.text = var_245_19

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_20 = 16
				local var_245_21 = utf8.len(var_245_19)
				local var_245_22 = var_245_20 <= 0 and var_245_16 or var_245_16 * (var_245_21 / var_245_20)

				if var_245_22 > 0 and var_245_16 < var_245_22 then
					arg_242_1.talkMaxDuration = var_245_22

					if var_245_22 + var_245_15 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_22 + var_245_15
					end
				end

				arg_242_1.text_.text = var_245_19
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191057", "story_v_out_416191.awb") ~= 0 then
					local var_245_23 = manager.audio:GetVoiceLength("story_v_out_416191", "416191057", "story_v_out_416191.awb") / 1000

					if var_245_23 + var_245_15 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_23 + var_245_15
					end

					if var_245_18.prefab_name ~= "" and arg_242_1.actors_[var_245_18.prefab_name] ~= nil then
						local var_245_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_18.prefab_name].transform, "story_v_out_416191", "416191057", "story_v_out_416191.awb")

						arg_242_1:RecordAudio("416191057", var_245_24)
						arg_242_1:RecordAudio("416191057", var_245_24)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_out_416191", "416191057", "story_v_out_416191.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_out_416191", "416191057", "story_v_out_416191.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_25 = math.max(var_245_16, arg_242_1.talkMaxDuration)

			if var_245_15 <= arg_242_1.time_ and arg_242_1.time_ < var_245_15 + var_245_25 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_15) / var_245_25

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_15 + var_245_25 and arg_242_1.time_ < var_245_15 + var_245_25 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_242_1:InitPlayNodeList()
	end,
	Play416191058 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 416191058
		arg_246_1.duration_ = 5.77

		local var_246_0 = {
			zh = 4.533,
			ja = 5.766
		}
		local var_246_1 = manager.audio:GetLocalizationFlag()

		if var_246_0[var_246_1] ~= nil then
			arg_246_1.duration_ = var_246_0[var_246_1]
		end

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play416191059(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = 0
			local var_249_1 = 0.5

			if var_249_0 < arg_246_1.time_ and arg_246_1.time_ <= var_249_0 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				local var_249_2 = arg_246_1:FormatText(StoryNameCfg[327].name)

				arg_246_1.leftNameTxt_.text = var_249_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_3 = arg_246_1:GetWordFromCfg(416191058)
				local var_249_4 = arg_246_1:FormatText(var_249_3.content)

				arg_246_1.text_.text = var_249_4

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_5 = 20
				local var_249_6 = utf8.len(var_249_4)
				local var_249_7 = var_249_5 <= 0 and var_249_1 or var_249_1 * (var_249_6 / var_249_5)

				if var_249_7 > 0 and var_249_1 < var_249_7 then
					arg_246_1.talkMaxDuration = var_249_7

					if var_249_7 + var_249_0 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_7 + var_249_0
					end
				end

				arg_246_1.text_.text = var_249_4
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191058", "story_v_out_416191.awb") ~= 0 then
					local var_249_8 = manager.audio:GetVoiceLength("story_v_out_416191", "416191058", "story_v_out_416191.awb") / 1000

					if var_249_8 + var_249_0 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_8 + var_249_0
					end

					if var_249_3.prefab_name ~= "" and arg_246_1.actors_[var_249_3.prefab_name] ~= nil then
						local var_249_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_246_1.actors_[var_249_3.prefab_name].transform, "story_v_out_416191", "416191058", "story_v_out_416191.awb")

						arg_246_1:RecordAudio("416191058", var_249_9)
						arg_246_1:RecordAudio("416191058", var_249_9)
					else
						arg_246_1:AudioAction("play", "voice", "story_v_out_416191", "416191058", "story_v_out_416191.awb")
					end

					arg_246_1:RecordHistoryTalkVoice("story_v_out_416191", "416191058", "story_v_out_416191.awb")
				end

				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_10 = math.max(var_249_1, arg_246_1.talkMaxDuration)

			if var_249_0 <= arg_246_1.time_ and arg_246_1.time_ < var_249_0 + var_249_10 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_0) / var_249_10

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_0 + var_249_10 and arg_246_1.time_ < var_249_0 + var_249_10 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play416191059 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 416191059
		arg_250_1.duration_ = 6.06

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play416191060(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = arg_250_1.actors_["1028"].transform
			local var_253_1 = 0

			if var_253_1 < arg_250_1.time_ and arg_250_1.time_ <= var_253_1 + arg_253_0 then
				arg_250_1.var_.moveOldPos1028 = var_253_0.localPosition
				var_253_0.localScale = Vector3.New(1, 1, 1)

				arg_250_1:CheckSpriteTmpPos("1028", 7)

				local var_253_2 = var_253_0.childCount

				for iter_253_0 = 0, var_253_2 - 1 do
					local var_253_3 = var_253_0:GetChild(iter_253_0)

					if var_253_3.name == "" or not string.find(var_253_3.name, "split") then
						var_253_3.gameObject:SetActive(true)
					else
						var_253_3.gameObject:SetActive(false)
					end
				end
			end

			local var_253_4 = 0.001

			if var_253_1 <= arg_250_1.time_ and arg_250_1.time_ < var_253_1 + var_253_4 then
				local var_253_5 = (arg_250_1.time_ - var_253_1) / var_253_4
				local var_253_6 = Vector3.New(0, -2000, 0)

				var_253_0.localPosition = Vector3.Lerp(arg_250_1.var_.moveOldPos1028, var_253_6, var_253_5)
			end

			if arg_250_1.time_ >= var_253_1 + var_253_4 and arg_250_1.time_ < var_253_1 + var_253_4 + arg_253_0 then
				var_253_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_253_7 = manager.ui.mainCamera.transform
			local var_253_8 = 0.166666666666667

			if var_253_8 < arg_250_1.time_ and arg_250_1.time_ <= var_253_8 + arg_253_0 then
				local var_253_9 = arg_250_1.var_.effect7777
				local var_253_10
				local var_253_11 = var_253_7

				if not var_253_9 then
					var_253_9 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_slash_01"), var_253_11)
					var_253_9.name = "7777"
					arg_250_1.var_.effect7777 = var_253_9
				else
					var_253_9.transform:SetParent(var_253_11)
				end

				var_253_9.transform.localPosition = Vector3.New(0, 0, 0.66)
				var_253_9.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_253_12 = manager.ui.mainCameraCom_
				local var_253_13 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_253_12.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_253_14 = var_253_9.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_253_15 = 15
				local var_253_16 = 2 * var_253_15 * Mathf.Tan(var_253_12.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_253_12.aspect
				local var_253_17 = 1
				local var_253_18 = 1.7777777777777777

				if var_253_18 < var_253_12.aspect then
					var_253_17 = var_253_16 / (2 * var_253_15 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_253_18)
				end

				for iter_253_1, iter_253_2 in ipairs(var_253_14) do
					local var_253_19 = iter_253_2.transform.localScale

					iter_253_2.transform.localScale = Vector3.New(var_253_19.x / var_253_13 * var_253_17, var_253_19.y / var_253_13, var_253_19.z)
				end
			end

			local var_253_20 = manager.ui.mainCamera.transform
			local var_253_21 = 0.533333333333333

			if var_253_21 < arg_250_1.time_ and arg_250_1.time_ <= var_253_21 + arg_253_0 then
				local var_253_22 = arg_250_1.var_.effect7777

				if var_253_22 then
					Object.Destroy(var_253_22)

					arg_250_1.var_.effect7777 = nil
				end
			end

			local var_253_23 = 0

			if var_253_23 < arg_250_1.time_ and arg_250_1.time_ <= var_253_23 + arg_253_0 then
				arg_250_1.allBtn_.enabled = false
			end

			local var_253_24 = 1.76666666666667

			if arg_250_1.time_ >= var_253_23 + var_253_24 and arg_250_1.time_ < var_253_23 + var_253_24 + arg_253_0 then
				arg_250_1.allBtn_.enabled = true
			end

			local var_253_25 = arg_250_1.actors_["1028"]
			local var_253_26 = 0

			if var_253_26 < arg_250_1.time_ and arg_250_1.time_ <= var_253_26 + arg_253_0 then
				local var_253_27 = var_253_25:GetComponentInChildren(typeof(CanvasGroup))

				if var_253_27 then
					arg_250_1.var_.alphaOldValue1028 = var_253_27.alpha
					arg_250_1.var_.characterEffect1028 = var_253_27
				end

				arg_250_1.var_.alphaOldValue1028 = 1
			end

			local var_253_28 = 0.433333333333333

			if var_253_26 <= arg_250_1.time_ and arg_250_1.time_ < var_253_26 + var_253_28 then
				local var_253_29 = (arg_250_1.time_ - var_253_26) / var_253_28
				local var_253_30 = Mathf.Lerp(arg_250_1.var_.alphaOldValue1028, 0, var_253_29)

				if arg_250_1.var_.characterEffect1028 then
					arg_250_1.var_.characterEffect1028.alpha = var_253_30
				end
			end

			if arg_250_1.time_ >= var_253_26 + var_253_28 and arg_250_1.time_ < var_253_26 + var_253_28 + arg_253_0 and arg_250_1.var_.characterEffect1028 then
				arg_250_1.var_.characterEffect1028.alpha = 0
			end

			local var_253_31 = manager.ui.mainCamera.transform
			local var_253_32 = 0.309470200352371

			if var_253_32 < arg_250_1.time_ and arg_250_1.time_ <= var_253_32 + arg_253_0 then
				local var_253_33 = arg_250_1.var_.effect244
				local var_253_34
				local var_253_35 = var_253_31

				if not var_253_33 then
					var_253_33 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Lightning_in"), var_253_35)
					var_253_33.name = "244"
					arg_250_1.var_.effect244 = var_253_33
				else
					var_253_33.transform:SetParent(var_253_35)
				end

				var_253_33.transform.localPosition = Vector3.New(0, 0, 0)
				var_253_33.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_253_36 = manager.ui.mainCameraCom_
				local var_253_37 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_253_36.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_253_38 = var_253_33.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_253_39 = 15
				local var_253_40 = 2 * var_253_39 * Mathf.Tan(var_253_36.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_253_36.aspect
				local var_253_41 = 1
				local var_253_42 = 1.7777777777777777

				if var_253_42 < var_253_36.aspect then
					var_253_41 = var_253_40 / (2 * var_253_39 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_253_42)
				end

				for iter_253_3, iter_253_4 in ipairs(var_253_38) do
					local var_253_43 = iter_253_4.transform.localScale

					iter_253_4.transform.localScale = Vector3.New(var_253_43.x / var_253_37 * var_253_41, var_253_43.y / var_253_37, var_253_43.z)
				end
			end

			local var_253_44 = manager.ui.mainCamera.transform
			local var_253_45 = 1.16666666666667

			if var_253_45 < arg_250_1.time_ and arg_250_1.time_ <= var_253_45 + arg_253_0 then
				local var_253_46 = arg_250_1.var_.effect244

				if var_253_46 then
					Object.Destroy(var_253_46)

					arg_250_1.var_.effect244 = nil
				end
			end

			local var_253_47 = 0.2
			local var_253_48 = 1

			if var_253_47 < arg_250_1.time_ and arg_250_1.time_ <= var_253_47 + arg_253_0 then
				local var_253_49 = "play"
				local var_253_50 = "effect"

				arg_250_1:AudioAction(var_253_49, var_253_50, "se_story_127", "se_story_127_thunder", "")
			end

			if arg_250_1.frameCnt_ <= 1 then
				arg_250_1.dialog_:SetActive(false)
			end

			local var_253_51 = 1.0571964663143
			local var_253_52 = 1.375

			if var_253_51 < arg_250_1.time_ and arg_250_1.time_ <= var_253_51 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0

				arg_250_1.dialog_:SetActive(true)

				arg_250_1.dialogCg_.alpha = 0

				local var_253_53 = LeanTween.value(arg_250_1.dialog_, 0, 1, 0.3)

				var_253_53:setOnUpdate(LuaHelper.FloatAction(function(arg_254_0)
					arg_250_1.dialogCg_.alpha = arg_254_0
				end))
				var_253_53:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_250_1.dialog_)
					var_253_53:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_250_1.duration_ = arg_250_1.duration_ + 0.3

				SetActive(arg_250_1.leftNameGo_, false)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_54 = arg_250_1:GetWordFromCfg(416191059)
				local var_253_55 = arg_250_1:FormatText(var_253_54.content)

				arg_250_1.text_.text = var_253_55

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_56 = 55
				local var_253_57 = utf8.len(var_253_55)
				local var_253_58 = var_253_56 <= 0 and var_253_52 or var_253_52 * (var_253_57 / var_253_56)

				if var_253_58 > 0 and var_253_52 < var_253_58 then
					arg_250_1.talkMaxDuration = var_253_58
					var_253_51 = var_253_51 + 0.3

					if var_253_58 + var_253_51 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_58 + var_253_51
					end
				end

				arg_250_1.text_.text = var_253_55
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)
				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_59 = var_253_51 + 0.3
			local var_253_60 = math.max(var_253_52, arg_250_1.talkMaxDuration)

			if var_253_59 <= arg_250_1.time_ and arg_250_1.time_ < var_253_59 + var_253_60 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_59) / var_253_60

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_59 + var_253_60 and arg_250_1.time_ < var_253_59 + var_253_60 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_250_1:InitPlayNodeList()
	end,
	Play416191060 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 416191060
		arg_256_1.duration_ = 12.23

		local var_256_0 = {
			zh = 7.9,
			ja = 12.233
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
				arg_256_0:Play416191061(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = arg_256_1.actors_["1028"]
			local var_259_1 = 0

			if var_259_1 < arg_256_1.time_ and arg_256_1.time_ <= var_259_1 + arg_259_0 and not isNil(var_259_0) and arg_256_1.var_.actorSpriteComps1028 == nil then
				arg_256_1.var_.actorSpriteComps1028 = var_259_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_259_2 = 0.2

			if var_259_1 <= arg_256_1.time_ and arg_256_1.time_ < var_259_1 + var_259_2 and not isNil(var_259_0) then
				local var_259_3 = (arg_256_1.time_ - var_259_1) / var_259_2

				if arg_256_1.var_.actorSpriteComps1028 then
					for iter_259_0, iter_259_1 in pairs(arg_256_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_256_1.time_ >= var_259_1 + var_259_2 and arg_256_1.time_ < var_259_1 + var_259_2 + arg_259_0 and not isNil(var_259_0) and arg_256_1.var_.actorSpriteComps1028 then
				for iter_259_2, iter_259_3 in pairs(arg_256_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_259_3 then
						if arg_256_1.isInRecall_ then
							iter_259_3.color = arg_256_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_259_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_256_1.var_.actorSpriteComps1028 = nil
			end

			local var_259_8 = arg_256_1.actors_["1028"].transform
			local var_259_9 = 0

			if var_259_9 < arg_256_1.time_ and arg_256_1.time_ <= var_259_9 + arg_259_0 then
				arg_256_1.var_.moveOldPos1028 = var_259_8.localPosition
				var_259_8.localScale = Vector3.New(1, 1, 1)

				arg_256_1:CheckSpriteTmpPos("1028", 3)

				local var_259_10 = var_259_8.childCount

				for iter_259_4 = 0, var_259_10 - 1 do
					local var_259_11 = var_259_8:GetChild(iter_259_4)

					if var_259_11.name == "split_2" or not string.find(var_259_11.name, "split") then
						var_259_11.gameObject:SetActive(true)
					else
						var_259_11.gameObject:SetActive(false)
					end
				end
			end

			local var_259_12 = 0.001

			if var_259_9 <= arg_256_1.time_ and arg_256_1.time_ < var_259_9 + var_259_12 then
				local var_259_13 = (arg_256_1.time_ - var_259_9) / var_259_12
				local var_259_14 = Vector3.New(0, -402.7, -156.1)

				var_259_8.localPosition = Vector3.Lerp(arg_256_1.var_.moveOldPos1028, var_259_14, var_259_13)
			end

			if arg_256_1.time_ >= var_259_9 + var_259_12 and arg_256_1.time_ < var_259_9 + var_259_12 + arg_259_0 then
				var_259_8.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			local var_259_15 = arg_256_1.actors_["1028"]
			local var_259_16 = 0

			if var_259_16 < arg_256_1.time_ and arg_256_1.time_ <= var_259_16 + arg_259_0 then
				local var_259_17 = var_259_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_259_17 then
					arg_256_1.var_.alphaOldValue1028 = var_259_17.alpha
					arg_256_1.var_.characterEffect1028 = var_259_17
				end

				arg_256_1.var_.alphaOldValue1028 = 0
			end

			local var_259_18 = 0.333333343267441

			if var_259_16 <= arg_256_1.time_ and arg_256_1.time_ < var_259_16 + var_259_18 then
				local var_259_19 = (arg_256_1.time_ - var_259_16) / var_259_18
				local var_259_20 = Mathf.Lerp(arg_256_1.var_.alphaOldValue1028, 1, var_259_19)

				if arg_256_1.var_.characterEffect1028 then
					arg_256_1.var_.characterEffect1028.alpha = var_259_20
				end
			end

			if arg_256_1.time_ >= var_259_16 + var_259_18 and arg_256_1.time_ < var_259_16 + var_259_18 + arg_259_0 and arg_256_1.var_.characterEffect1028 then
				arg_256_1.var_.characterEffect1028.alpha = 1
			end

			local var_259_21 = manager.ui.mainCamera.transform
			local var_259_22 = 0

			if var_259_22 < arg_256_1.time_ and arg_256_1.time_ <= var_259_22 + arg_259_0 then
				local var_259_23 = arg_256_1.var_.effect244

				if var_259_23 then
					Object.Destroy(var_259_23)

					arg_256_1.var_.effect244 = nil
				end
			end

			local var_259_24 = 0
			local var_259_25 = 0.725

			if var_259_24 < arg_256_1.time_ and arg_256_1.time_ <= var_259_24 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				local var_259_26 = arg_256_1:FormatText(StoryNameCfg[327].name)

				arg_256_1.leftNameTxt_.text = var_259_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_27 = arg_256_1:GetWordFromCfg(416191060)
				local var_259_28 = arg_256_1:FormatText(var_259_27.content)

				arg_256_1.text_.text = var_259_28

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_29 = 29
				local var_259_30 = utf8.len(var_259_28)
				local var_259_31 = var_259_29 <= 0 and var_259_25 or var_259_25 * (var_259_30 / var_259_29)

				if var_259_31 > 0 and var_259_25 < var_259_31 then
					arg_256_1.talkMaxDuration = var_259_31

					if var_259_31 + var_259_24 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_31 + var_259_24
					end
				end

				arg_256_1.text_.text = var_259_28
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191060", "story_v_out_416191.awb") ~= 0 then
					local var_259_32 = manager.audio:GetVoiceLength("story_v_out_416191", "416191060", "story_v_out_416191.awb") / 1000

					if var_259_32 + var_259_24 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_32 + var_259_24
					end

					if var_259_27.prefab_name ~= "" and arg_256_1.actors_[var_259_27.prefab_name] ~= nil then
						local var_259_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_27.prefab_name].transform, "story_v_out_416191", "416191060", "story_v_out_416191.awb")

						arg_256_1:RecordAudio("416191060", var_259_33)
						arg_256_1:RecordAudio("416191060", var_259_33)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_out_416191", "416191060", "story_v_out_416191.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_out_416191", "416191060", "story_v_out_416191.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_34 = math.max(var_259_25, arg_256_1.talkMaxDuration)

			if var_259_24 <= arg_256_1.time_ and arg_256_1.time_ < var_259_24 + var_259_34 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_24) / var_259_34

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_24 + var_259_34 and arg_256_1.time_ < var_259_24 + var_259_34 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
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
	Play416191061 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 416191061
		arg_260_1.duration_ = 5

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play416191062(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = arg_260_1.actors_["1028"]
			local var_263_1 = 0

			if var_263_1 < arg_260_1.time_ and arg_260_1.time_ <= var_263_1 + arg_263_0 and not isNil(var_263_0) and arg_260_1.var_.actorSpriteComps1028 == nil then
				arg_260_1.var_.actorSpriteComps1028 = var_263_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_263_2 = 0.2

			if var_263_1 <= arg_260_1.time_ and arg_260_1.time_ < var_263_1 + var_263_2 and not isNil(var_263_0) then
				local var_263_3 = (arg_260_1.time_ - var_263_1) / var_263_2

				if arg_260_1.var_.actorSpriteComps1028 then
					for iter_263_0, iter_263_1 in pairs(arg_260_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_263_1 then
							if arg_260_1.isInRecall_ then
								local var_263_4 = Mathf.Lerp(iter_263_1.color.r, arg_260_1.hightColor2.r, var_263_3)
								local var_263_5 = Mathf.Lerp(iter_263_1.color.g, arg_260_1.hightColor2.g, var_263_3)
								local var_263_6 = Mathf.Lerp(iter_263_1.color.b, arg_260_1.hightColor2.b, var_263_3)

								iter_263_1.color = Color.New(var_263_4, var_263_5, var_263_6)
							else
								local var_263_7 = Mathf.Lerp(iter_263_1.color.r, 0.5, var_263_3)

								iter_263_1.color = Color.New(var_263_7, var_263_7, var_263_7)
							end
						end
					end
				end
			end

			if arg_260_1.time_ >= var_263_1 + var_263_2 and arg_260_1.time_ < var_263_1 + var_263_2 + arg_263_0 and not isNil(var_263_0) and arg_260_1.var_.actorSpriteComps1028 then
				for iter_263_2, iter_263_3 in pairs(arg_260_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_263_3 then
						if arg_260_1.isInRecall_ then
							iter_263_3.color = arg_260_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_263_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_260_1.var_.actorSpriteComps1028 = nil
			end

			local var_263_8 = 0
			local var_263_9 = 1.25

			if var_263_8 < arg_260_1.time_ and arg_260_1.time_ <= var_263_8 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, false)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_10 = arg_260_1:GetWordFromCfg(416191061)
				local var_263_11 = arg_260_1:FormatText(var_263_10.content)

				arg_260_1.text_.text = var_263_11

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_12 = 50
				local var_263_13 = utf8.len(var_263_11)
				local var_263_14 = var_263_12 <= 0 and var_263_9 or var_263_9 * (var_263_13 / var_263_12)

				if var_263_14 > 0 and var_263_9 < var_263_14 then
					arg_260_1.talkMaxDuration = var_263_14

					if var_263_14 + var_263_8 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_14 + var_263_8
					end
				end

				arg_260_1.text_.text = var_263_11
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)
				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_15 = math.max(var_263_9, arg_260_1.talkMaxDuration)

			if var_263_8 <= arg_260_1.time_ and arg_260_1.time_ < var_263_8 + var_263_15 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_8) / var_263_15

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_8 + var_263_15 and arg_260_1.time_ < var_263_8 + var_263_15 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play416191062 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 416191062
		arg_264_1.duration_ = 5.53

		local var_264_0 = {
			zh = 5.533,
			ja = 5.1
		}
		local var_264_1 = manager.audio:GetLocalizationFlag()

		if var_264_0[var_264_1] ~= nil then
			arg_264_1.duration_ = var_264_0[var_264_1]
		end

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play416191063(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			local var_267_0 = arg_264_1.actors_["1028"]
			local var_267_1 = 0

			if var_267_1 < arg_264_1.time_ and arg_264_1.time_ <= var_267_1 + arg_267_0 and not isNil(var_267_0) and arg_264_1.var_.actorSpriteComps1028 == nil then
				arg_264_1.var_.actorSpriteComps1028 = var_267_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_267_2 = 0.2

			if var_267_1 <= arg_264_1.time_ and arg_264_1.time_ < var_267_1 + var_267_2 and not isNil(var_267_0) then
				local var_267_3 = (arg_264_1.time_ - var_267_1) / var_267_2

				if arg_264_1.var_.actorSpriteComps1028 then
					for iter_267_0, iter_267_1 in pairs(arg_264_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_267_1 then
							if arg_264_1.isInRecall_ then
								local var_267_4 = Mathf.Lerp(iter_267_1.color.r, arg_264_1.hightColor1.r, var_267_3)
								local var_267_5 = Mathf.Lerp(iter_267_1.color.g, arg_264_1.hightColor1.g, var_267_3)
								local var_267_6 = Mathf.Lerp(iter_267_1.color.b, arg_264_1.hightColor1.b, var_267_3)

								iter_267_1.color = Color.New(var_267_4, var_267_5, var_267_6)
							else
								local var_267_7 = Mathf.Lerp(iter_267_1.color.r, 1, var_267_3)

								iter_267_1.color = Color.New(var_267_7, var_267_7, var_267_7)
							end
						end
					end
				end
			end

			if arg_264_1.time_ >= var_267_1 + var_267_2 and arg_264_1.time_ < var_267_1 + var_267_2 + arg_267_0 and not isNil(var_267_0) and arg_264_1.var_.actorSpriteComps1028 then
				for iter_267_2, iter_267_3 in pairs(arg_264_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_267_3 then
						if arg_264_1.isInRecall_ then
							iter_267_3.color = arg_264_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_267_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_264_1.var_.actorSpriteComps1028 = nil
			end

			local var_267_8 = arg_264_1.actors_["1028"].transform
			local var_267_9 = 0

			if var_267_9 < arg_264_1.time_ and arg_264_1.time_ <= var_267_9 + arg_267_0 then
				arg_264_1.var_.moveOldPos1028 = var_267_8.localPosition
				var_267_8.localScale = Vector3.New(1, 1, 1)

				arg_264_1:CheckSpriteTmpPos("1028", 3)

				local var_267_10 = var_267_8.childCount

				for iter_267_4 = 0, var_267_10 - 1 do
					local var_267_11 = var_267_8:GetChild(iter_267_4)

					if var_267_11.name == "split_2" or not string.find(var_267_11.name, "split") then
						var_267_11.gameObject:SetActive(true)
					else
						var_267_11.gameObject:SetActive(false)
					end
				end
			end

			local var_267_12 = 0.001

			if var_267_9 <= arg_264_1.time_ and arg_264_1.time_ < var_267_9 + var_267_12 then
				local var_267_13 = (arg_264_1.time_ - var_267_9) / var_267_12
				local var_267_14 = Vector3.New(0, -402.7, -156.1)

				var_267_8.localPosition = Vector3.Lerp(arg_264_1.var_.moveOldPos1028, var_267_14, var_267_13)
			end

			if arg_264_1.time_ >= var_267_9 + var_267_12 and arg_264_1.time_ < var_267_9 + var_267_12 + arg_267_0 then
				var_267_8.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			local var_267_15 = 0
			local var_267_16 = 0.425

			if var_267_15 < arg_264_1.time_ and arg_264_1.time_ <= var_267_15 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				local var_267_17 = arg_264_1:FormatText(StoryNameCfg[327].name)

				arg_264_1.leftNameTxt_.text = var_267_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_18 = arg_264_1:GetWordFromCfg(416191062)
				local var_267_19 = arg_264_1:FormatText(var_267_18.content)

				arg_264_1.text_.text = var_267_19

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_20 = 17
				local var_267_21 = utf8.len(var_267_19)
				local var_267_22 = var_267_20 <= 0 and var_267_16 or var_267_16 * (var_267_21 / var_267_20)

				if var_267_22 > 0 and var_267_16 < var_267_22 then
					arg_264_1.talkMaxDuration = var_267_22

					if var_267_22 + var_267_15 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_22 + var_267_15
					end
				end

				arg_264_1.text_.text = var_267_19
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191062", "story_v_out_416191.awb") ~= 0 then
					local var_267_23 = manager.audio:GetVoiceLength("story_v_out_416191", "416191062", "story_v_out_416191.awb") / 1000

					if var_267_23 + var_267_15 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_23 + var_267_15
					end

					if var_267_18.prefab_name ~= "" and arg_264_1.actors_[var_267_18.prefab_name] ~= nil then
						local var_267_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_18.prefab_name].transform, "story_v_out_416191", "416191062", "story_v_out_416191.awb")

						arg_264_1:RecordAudio("416191062", var_267_24)
						arg_264_1:RecordAudio("416191062", var_267_24)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_out_416191", "416191062", "story_v_out_416191.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_out_416191", "416191062", "story_v_out_416191.awb")
				end

				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_25 = math.max(var_267_16, arg_264_1.talkMaxDuration)

			if var_267_15 <= arg_264_1.time_ and arg_264_1.time_ < var_267_15 + var_267_25 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_15) / var_267_25

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_15 + var_267_25 and arg_264_1.time_ < var_267_15 + var_267_25 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
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
	Play416191063 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 416191063
		arg_268_1.duration_ = 5.27

		local var_268_0 = {
			zh = 4.3,
			ja = 5.266
		}
		local var_268_1 = manager.audio:GetLocalizationFlag()

		if var_268_0[var_268_1] ~= nil then
			arg_268_1.duration_ = var_268_0[var_268_1]
		end

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play416191064(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			local var_271_0 = arg_268_1.actors_["1028"]
			local var_271_1 = 0

			if var_271_1 < arg_268_1.time_ and arg_268_1.time_ <= var_271_1 + arg_271_0 and not isNil(var_271_0) and arg_268_1.var_.actorSpriteComps1028 == nil then
				arg_268_1.var_.actorSpriteComps1028 = var_271_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_271_2 = 0.2

			if var_271_1 <= arg_268_1.time_ and arg_268_1.time_ < var_271_1 + var_271_2 and not isNil(var_271_0) then
				local var_271_3 = (arg_268_1.time_ - var_271_1) / var_271_2

				if arg_268_1.var_.actorSpriteComps1028 then
					for iter_271_0, iter_271_1 in pairs(arg_268_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_271_1 then
							if arg_268_1.isInRecall_ then
								local var_271_4 = Mathf.Lerp(iter_271_1.color.r, arg_268_1.hightColor2.r, var_271_3)
								local var_271_5 = Mathf.Lerp(iter_271_1.color.g, arg_268_1.hightColor2.g, var_271_3)
								local var_271_6 = Mathf.Lerp(iter_271_1.color.b, arg_268_1.hightColor2.b, var_271_3)

								iter_271_1.color = Color.New(var_271_4, var_271_5, var_271_6)
							else
								local var_271_7 = Mathf.Lerp(iter_271_1.color.r, 0.5, var_271_3)

								iter_271_1.color = Color.New(var_271_7, var_271_7, var_271_7)
							end
						end
					end
				end
			end

			if arg_268_1.time_ >= var_271_1 + var_271_2 and arg_268_1.time_ < var_271_1 + var_271_2 + arg_271_0 and not isNil(var_271_0) and arg_268_1.var_.actorSpriteComps1028 then
				for iter_271_2, iter_271_3 in pairs(arg_268_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_271_3 then
						if arg_268_1.isInRecall_ then
							iter_271_3.color = arg_268_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_271_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_268_1.var_.actorSpriteComps1028 = nil
			end

			local var_271_8 = 0
			local var_271_9 = 0.425

			if var_271_8 < arg_268_1.time_ and arg_268_1.time_ <= var_271_8 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				local var_271_10 = arg_268_1:FormatText(StoryNameCfg[1080].name)

				arg_268_1.leftNameTxt_.text = var_271_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, true)
				arg_268_1.iconController_:SetSelectedState("hero")

				arg_268_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1086_split_6")

				arg_268_1.callingController_:SetSelectedState("normal")

				arg_268_1.keyicon_.color = Color.New(1, 1, 1)
				arg_268_1.icon_.color = Color.New(1, 1, 1)

				local var_271_11 = arg_268_1:GetWordFromCfg(416191063)
				local var_271_12 = arg_268_1:FormatText(var_271_11.content)

				arg_268_1.text_.text = var_271_12

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_13 = 17
				local var_271_14 = utf8.len(var_271_12)
				local var_271_15 = var_271_13 <= 0 and var_271_9 or var_271_9 * (var_271_14 / var_271_13)

				if var_271_15 > 0 and var_271_9 < var_271_15 then
					arg_268_1.talkMaxDuration = var_271_15

					if var_271_15 + var_271_8 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_15 + var_271_8
					end
				end

				arg_268_1.text_.text = var_271_12
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191063", "story_v_out_416191.awb") ~= 0 then
					local var_271_16 = manager.audio:GetVoiceLength("story_v_out_416191", "416191063", "story_v_out_416191.awb") / 1000

					if var_271_16 + var_271_8 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_16 + var_271_8
					end

					if var_271_11.prefab_name ~= "" and arg_268_1.actors_[var_271_11.prefab_name] ~= nil then
						local var_271_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_268_1.actors_[var_271_11.prefab_name].transform, "story_v_out_416191", "416191063", "story_v_out_416191.awb")

						arg_268_1:RecordAudio("416191063", var_271_17)
						arg_268_1:RecordAudio("416191063", var_271_17)
					else
						arg_268_1:AudioAction("play", "voice", "story_v_out_416191", "416191063", "story_v_out_416191.awb")
					end

					arg_268_1:RecordHistoryTalkVoice("story_v_out_416191", "416191063", "story_v_out_416191.awb")
				end

				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_18 = math.max(var_271_9, arg_268_1.talkMaxDuration)

			if var_271_8 <= arg_268_1.time_ and arg_268_1.time_ < var_271_8 + var_271_18 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_8) / var_271_18

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_8 + var_271_18 and arg_268_1.time_ < var_271_8 + var_271_18 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play416191064 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 416191064
		arg_272_1.duration_ = 9.97

		local var_272_0 = {
			zh = 5.666,
			ja = 9.966
		}
		local var_272_1 = manager.audio:GetLocalizationFlag()

		if var_272_0[var_272_1] ~= nil then
			arg_272_1.duration_ = var_272_0[var_272_1]
		end

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play416191065(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			local var_275_0 = 0
			local var_275_1 = 0.525

			if var_275_0 < arg_272_1.time_ and arg_272_1.time_ <= var_275_0 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				local var_275_2 = arg_272_1:FormatText(StoryNameCfg[1080].name)

				arg_272_1.leftNameTxt_.text = var_275_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, true)
				arg_272_1.iconController_:SetSelectedState("hero")

				arg_272_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1086_split_6")

				arg_272_1.callingController_:SetSelectedState("normal")

				arg_272_1.keyicon_.color = Color.New(1, 1, 1)
				arg_272_1.icon_.color = Color.New(1, 1, 1)

				local var_275_3 = arg_272_1:GetWordFromCfg(416191064)
				local var_275_4 = arg_272_1:FormatText(var_275_3.content)

				arg_272_1.text_.text = var_275_4

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_5 = 21
				local var_275_6 = utf8.len(var_275_4)
				local var_275_7 = var_275_5 <= 0 and var_275_1 or var_275_1 * (var_275_6 / var_275_5)

				if var_275_7 > 0 and var_275_1 < var_275_7 then
					arg_272_1.talkMaxDuration = var_275_7

					if var_275_7 + var_275_0 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_7 + var_275_0
					end
				end

				arg_272_1.text_.text = var_275_4
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191064", "story_v_out_416191.awb") ~= 0 then
					local var_275_8 = manager.audio:GetVoiceLength("story_v_out_416191", "416191064", "story_v_out_416191.awb") / 1000

					if var_275_8 + var_275_0 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_8 + var_275_0
					end

					if var_275_3.prefab_name ~= "" and arg_272_1.actors_[var_275_3.prefab_name] ~= nil then
						local var_275_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_3.prefab_name].transform, "story_v_out_416191", "416191064", "story_v_out_416191.awb")

						arg_272_1:RecordAudio("416191064", var_275_9)
						arg_272_1:RecordAudio("416191064", var_275_9)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_out_416191", "416191064", "story_v_out_416191.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_out_416191", "416191064", "story_v_out_416191.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_10 = math.max(var_275_1, arg_272_1.talkMaxDuration)

			if var_275_0 <= arg_272_1.time_ and arg_272_1.time_ < var_275_0 + var_275_10 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_0) / var_275_10

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_0 + var_275_10 and arg_272_1.time_ < var_275_0 + var_275_10 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {}

		arg_272_1:InitPlayNodeList()
	end,
	Play416191065 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 416191065
		arg_276_1.duration_ = 4.9

		local var_276_0 = {
			zh = 4.9,
			ja = 4.766
		}
		local var_276_1 = manager.audio:GetLocalizationFlag()

		if var_276_0[var_276_1] ~= nil then
			arg_276_1.duration_ = var_276_0[var_276_1]
		end

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play416191066(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			local var_279_0 = arg_276_1.actors_["1028"]
			local var_279_1 = 0

			if var_279_1 < arg_276_1.time_ and arg_276_1.time_ <= var_279_1 + arg_279_0 and not isNil(var_279_0) and arg_276_1.var_.actorSpriteComps1028 == nil then
				arg_276_1.var_.actorSpriteComps1028 = var_279_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_279_2 = 0.2

			if var_279_1 <= arg_276_1.time_ and arg_276_1.time_ < var_279_1 + var_279_2 and not isNil(var_279_0) then
				local var_279_3 = (arg_276_1.time_ - var_279_1) / var_279_2

				if arg_276_1.var_.actorSpriteComps1028 then
					for iter_279_0, iter_279_1 in pairs(arg_276_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_279_1 then
							if arg_276_1.isInRecall_ then
								local var_279_4 = Mathf.Lerp(iter_279_1.color.r, arg_276_1.hightColor1.r, var_279_3)
								local var_279_5 = Mathf.Lerp(iter_279_1.color.g, arg_276_1.hightColor1.g, var_279_3)
								local var_279_6 = Mathf.Lerp(iter_279_1.color.b, arg_276_1.hightColor1.b, var_279_3)

								iter_279_1.color = Color.New(var_279_4, var_279_5, var_279_6)
							else
								local var_279_7 = Mathf.Lerp(iter_279_1.color.r, 1, var_279_3)

								iter_279_1.color = Color.New(var_279_7, var_279_7, var_279_7)
							end
						end
					end
				end
			end

			if arg_276_1.time_ >= var_279_1 + var_279_2 and arg_276_1.time_ < var_279_1 + var_279_2 + arg_279_0 and not isNil(var_279_0) and arg_276_1.var_.actorSpriteComps1028 then
				for iter_279_2, iter_279_3 in pairs(arg_276_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_279_3 then
						if arg_276_1.isInRecall_ then
							iter_279_3.color = arg_276_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_279_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_276_1.var_.actorSpriteComps1028 = nil
			end

			local var_279_8 = 0
			local var_279_9 = 0.45

			if var_279_8 < arg_276_1.time_ and arg_276_1.time_ <= var_279_8 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				local var_279_10 = arg_276_1:FormatText(StoryNameCfg[327].name)

				arg_276_1.leftNameTxt_.text = var_279_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_11 = arg_276_1:GetWordFromCfg(416191065)
				local var_279_12 = arg_276_1:FormatText(var_279_11.content)

				arg_276_1.text_.text = var_279_12

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_13 = 18
				local var_279_14 = utf8.len(var_279_12)
				local var_279_15 = var_279_13 <= 0 and var_279_9 or var_279_9 * (var_279_14 / var_279_13)

				if var_279_15 > 0 and var_279_9 < var_279_15 then
					arg_276_1.talkMaxDuration = var_279_15

					if var_279_15 + var_279_8 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_15 + var_279_8
					end
				end

				arg_276_1.text_.text = var_279_12
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191065", "story_v_out_416191.awb") ~= 0 then
					local var_279_16 = manager.audio:GetVoiceLength("story_v_out_416191", "416191065", "story_v_out_416191.awb") / 1000

					if var_279_16 + var_279_8 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_16 + var_279_8
					end

					if var_279_11.prefab_name ~= "" and arg_276_1.actors_[var_279_11.prefab_name] ~= nil then
						local var_279_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_276_1.actors_[var_279_11.prefab_name].transform, "story_v_out_416191", "416191065", "story_v_out_416191.awb")

						arg_276_1:RecordAudio("416191065", var_279_17)
						arg_276_1:RecordAudio("416191065", var_279_17)
					else
						arg_276_1:AudioAction("play", "voice", "story_v_out_416191", "416191065", "story_v_out_416191.awb")
					end

					arg_276_1:RecordHistoryTalkVoice("story_v_out_416191", "416191065", "story_v_out_416191.awb")
				end

				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_18 = math.max(var_279_9, arg_276_1.talkMaxDuration)

			if var_279_8 <= arg_276_1.time_ and arg_276_1.time_ < var_279_8 + var_279_18 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_8) / var_279_18

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_8 + var_279_18 and arg_276_1.time_ < var_279_8 + var_279_18 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	Play416191066 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 416191066
		arg_280_1.duration_ = 8.17

		local var_280_0 = {
			zh = 6.866,
			ja = 8.166
		}
		local var_280_1 = manager.audio:GetLocalizationFlag()

		if var_280_0[var_280_1] ~= nil then
			arg_280_1.duration_ = var_280_0[var_280_1]
		end

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play416191067(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			local var_283_0 = arg_280_1.actors_["1028"]
			local var_283_1 = 0

			if var_283_1 < arg_280_1.time_ and arg_280_1.time_ <= var_283_1 + arg_283_0 and not isNil(var_283_0) and arg_280_1.var_.actorSpriteComps1028 == nil then
				arg_280_1.var_.actorSpriteComps1028 = var_283_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_283_2 = 0.2

			if var_283_1 <= arg_280_1.time_ and arg_280_1.time_ < var_283_1 + var_283_2 and not isNil(var_283_0) then
				local var_283_3 = (arg_280_1.time_ - var_283_1) / var_283_2

				if arg_280_1.var_.actorSpriteComps1028 then
					for iter_283_0, iter_283_1 in pairs(arg_280_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_283_1 then
							if arg_280_1.isInRecall_ then
								local var_283_4 = Mathf.Lerp(iter_283_1.color.r, arg_280_1.hightColor2.r, var_283_3)
								local var_283_5 = Mathf.Lerp(iter_283_1.color.g, arg_280_1.hightColor2.g, var_283_3)
								local var_283_6 = Mathf.Lerp(iter_283_1.color.b, arg_280_1.hightColor2.b, var_283_3)

								iter_283_1.color = Color.New(var_283_4, var_283_5, var_283_6)
							else
								local var_283_7 = Mathf.Lerp(iter_283_1.color.r, 0.5, var_283_3)

								iter_283_1.color = Color.New(var_283_7, var_283_7, var_283_7)
							end
						end
					end
				end
			end

			if arg_280_1.time_ >= var_283_1 + var_283_2 and arg_280_1.time_ < var_283_1 + var_283_2 + arg_283_0 and not isNil(var_283_0) and arg_280_1.var_.actorSpriteComps1028 then
				for iter_283_2, iter_283_3 in pairs(arg_280_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_283_3 then
						if arg_280_1.isInRecall_ then
							iter_283_3.color = arg_280_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_283_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_280_1.var_.actorSpriteComps1028 = nil
			end

			local var_283_8 = 0
			local var_283_9 = 0.525

			if var_283_8 < arg_280_1.time_ and arg_280_1.time_ <= var_283_8 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				local var_283_10 = arg_280_1:FormatText(StoryNameCfg[1080].name)

				arg_280_1.leftNameTxt_.text = var_283_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, true)
				arg_280_1.iconController_:SetSelectedState("hero")

				arg_280_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1086_split_6")

				arg_280_1.callingController_:SetSelectedState("normal")

				arg_280_1.keyicon_.color = Color.New(1, 1, 1)
				arg_280_1.icon_.color = Color.New(1, 1, 1)

				local var_283_11 = arg_280_1:GetWordFromCfg(416191066)
				local var_283_12 = arg_280_1:FormatText(var_283_11.content)

				arg_280_1.text_.text = var_283_12

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_13 = 21
				local var_283_14 = utf8.len(var_283_12)
				local var_283_15 = var_283_13 <= 0 and var_283_9 or var_283_9 * (var_283_14 / var_283_13)

				if var_283_15 > 0 and var_283_9 < var_283_15 then
					arg_280_1.talkMaxDuration = var_283_15

					if var_283_15 + var_283_8 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_15 + var_283_8
					end
				end

				arg_280_1.text_.text = var_283_12
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191066", "story_v_out_416191.awb") ~= 0 then
					local var_283_16 = manager.audio:GetVoiceLength("story_v_out_416191", "416191066", "story_v_out_416191.awb") / 1000

					if var_283_16 + var_283_8 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_16 + var_283_8
					end

					if var_283_11.prefab_name ~= "" and arg_280_1.actors_[var_283_11.prefab_name] ~= nil then
						local var_283_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_280_1.actors_[var_283_11.prefab_name].transform, "story_v_out_416191", "416191066", "story_v_out_416191.awb")

						arg_280_1:RecordAudio("416191066", var_283_17)
						arg_280_1:RecordAudio("416191066", var_283_17)
					else
						arg_280_1:AudioAction("play", "voice", "story_v_out_416191", "416191066", "story_v_out_416191.awb")
					end

					arg_280_1:RecordHistoryTalkVoice("story_v_out_416191", "416191066", "story_v_out_416191.awb")
				end

				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_18 = math.max(var_283_9, arg_280_1.talkMaxDuration)

			if var_283_8 <= arg_280_1.time_ and arg_280_1.time_ < var_283_8 + var_283_18 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_8) / var_283_18

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_8 + var_283_18 and arg_280_1.time_ < var_283_8 + var_283_18 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play416191067 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 416191067
		arg_284_1.duration_ = 5.8

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play416191068(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			local var_287_0 = arg_284_1.actors_["1086"]
			local var_287_1 = 0

			if var_287_1 < arg_284_1.time_ and arg_284_1.time_ <= var_287_1 + arg_287_0 and not isNil(var_287_0) and arg_284_1.var_.actorSpriteComps1086 == nil then
				arg_284_1.var_.actorSpriteComps1086 = var_287_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_287_2 = 0.2

			if var_287_1 <= arg_284_1.time_ and arg_284_1.time_ < var_287_1 + var_287_2 and not isNil(var_287_0) then
				local var_287_3 = (arg_284_1.time_ - var_287_1) / var_287_2

				if arg_284_1.var_.actorSpriteComps1086 then
					for iter_287_0, iter_287_1 in pairs(arg_284_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_287_1 then
							if arg_284_1.isInRecall_ then
								local var_287_4 = Mathf.Lerp(iter_287_1.color.r, arg_284_1.hightColor2.r, var_287_3)
								local var_287_5 = Mathf.Lerp(iter_287_1.color.g, arg_284_1.hightColor2.g, var_287_3)
								local var_287_6 = Mathf.Lerp(iter_287_1.color.b, arg_284_1.hightColor2.b, var_287_3)

								iter_287_1.color = Color.New(var_287_4, var_287_5, var_287_6)
							else
								local var_287_7 = Mathf.Lerp(iter_287_1.color.r, 0.5, var_287_3)

								iter_287_1.color = Color.New(var_287_7, var_287_7, var_287_7)
							end
						end
					end
				end
			end

			if arg_284_1.time_ >= var_287_1 + var_287_2 and arg_284_1.time_ < var_287_1 + var_287_2 + arg_287_0 and not isNil(var_287_0) and arg_284_1.var_.actorSpriteComps1086 then
				for iter_287_2, iter_287_3 in pairs(arg_284_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_287_3 then
						if arg_284_1.isInRecall_ then
							iter_287_3.color = arg_284_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_287_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_284_1.var_.actorSpriteComps1086 = nil
			end

			local var_287_8 = arg_284_1.actors_["1028"].transform
			local var_287_9 = 0

			if var_287_9 < arg_284_1.time_ and arg_284_1.time_ <= var_287_9 + arg_287_0 then
				arg_284_1.var_.moveOldPos1028 = var_287_8.localPosition
				var_287_8.localScale = Vector3.New(1, 1, 1)

				arg_284_1:CheckSpriteTmpPos("1028", 7)

				local var_287_10 = var_287_8.childCount

				for iter_287_4 = 0, var_287_10 - 1 do
					local var_287_11 = var_287_8:GetChild(iter_287_4)

					if var_287_11.name == "" or not string.find(var_287_11.name, "split") then
						var_287_11.gameObject:SetActive(true)
					else
						var_287_11.gameObject:SetActive(false)
					end
				end
			end

			local var_287_12 = 0.001

			if var_287_9 <= arg_284_1.time_ and arg_284_1.time_ < var_287_9 + var_287_12 then
				local var_287_13 = (arg_284_1.time_ - var_287_9) / var_287_12
				local var_287_14 = Vector3.New(0, -2000, 0)

				var_287_8.localPosition = Vector3.Lerp(arg_284_1.var_.moveOldPos1028, var_287_14, var_287_13)
			end

			if arg_284_1.time_ >= var_287_9 + var_287_12 and arg_284_1.time_ < var_287_9 + var_287_12 + arg_287_0 then
				var_287_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_287_15 = manager.ui.mainCamera.transform
			local var_287_16 = 0

			if var_287_16 < arg_284_1.time_ and arg_284_1.time_ <= var_287_16 + arg_287_0 then
				arg_284_1.var_.shakeOldPos = var_287_15.localPosition
			end

			local var_287_17 = 0.566666666666667

			if var_287_16 <= arg_284_1.time_ and arg_284_1.time_ < var_287_16 + var_287_17 then
				local var_287_18 = (arg_284_1.time_ - var_287_16) / 0.066
				local var_287_19, var_287_20 = math.modf(var_287_18)

				var_287_15.localPosition = Vector3.New(var_287_20 * 0.13, var_287_20 * 0.13, var_287_20 * 0.13) + arg_284_1.var_.shakeOldPos
			end

			if arg_284_1.time_ >= var_287_16 + var_287_17 and arg_284_1.time_ < var_287_16 + var_287_17 + arg_287_0 then
				var_287_15.localPosition = arg_284_1.var_.shakeOldPos
			end

			local var_287_21 = 0.366666666666667

			if var_287_21 < arg_284_1.time_ and arg_284_1.time_ <= var_287_21 + arg_287_0 then
				arg_284_1.mask_.enabled = true
				arg_284_1.mask_.raycastTarget = true

				arg_284_1:SetGaussion(false)
			end

			local var_287_22 = 0.633333333333333

			if var_287_21 <= arg_284_1.time_ and arg_284_1.time_ < var_287_21 + var_287_22 then
				local var_287_23 = (arg_284_1.time_ - var_287_21) / var_287_22
				local var_287_24 = Color.New(1, 1, 1)

				var_287_24.a = Mathf.Lerp(1, 0, var_287_23)
				arg_284_1.mask_.color = var_287_24
			end

			if arg_284_1.time_ >= var_287_21 + var_287_22 and arg_284_1.time_ < var_287_21 + var_287_22 + arg_287_0 then
				local var_287_25 = Color.New(1, 1, 1)
				local var_287_26 = 0

				arg_284_1.mask_.enabled = false
				var_287_25.a = var_287_26
				arg_284_1.mask_.color = var_287_25
			end

			local var_287_27 = 0

			if var_287_27 < arg_284_1.time_ and arg_284_1.time_ <= var_287_27 + arg_287_0 then
				arg_284_1.allBtn_.enabled = false
			end

			local var_287_28 = 1

			if arg_284_1.time_ >= var_287_27 + var_287_28 and arg_284_1.time_ < var_287_27 + var_287_28 + arg_287_0 then
				arg_284_1.allBtn_.enabled = true
			end

			local var_287_29 = manager.ui.mainCamera.transform
			local var_287_30 = 0.366666666666667

			if var_287_30 < arg_284_1.time_ and arg_284_1.time_ <= var_287_30 + arg_287_0 then
				local var_287_31 = arg_284_1.var_.effect116
				local var_287_32
				local var_287_33 = var_287_29

				if not var_287_31 then
					var_287_31 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Lightning_keep"), var_287_33)
					var_287_31.name = "116"
					arg_284_1.var_.effect116 = var_287_31
				else
					var_287_31.transform:SetParent(var_287_33)
				end

				var_287_31.transform.localPosition = Vector3.New(0, 0, 0)
				var_287_31.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_287_34 = manager.ui.mainCameraCom_
				local var_287_35 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_287_34.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_287_36 = var_287_31.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_287_37 = 15
				local var_287_38 = 2 * var_287_37 * Mathf.Tan(var_287_34.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_287_34.aspect
				local var_287_39 = 1
				local var_287_40 = 1.7777777777777777

				if var_287_40 < var_287_34.aspect then
					var_287_39 = var_287_38 / (2 * var_287_37 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_287_40)
				end

				for iter_287_5, iter_287_6 in ipairs(var_287_36) do
					local var_287_41 = iter_287_6.transform.localScale

					iter_287_6.transform.localScale = Vector3.New(var_287_41.x / var_287_35 * var_287_39, var_287_41.y / var_287_35, var_287_41.z)
				end
			end

			local var_287_42 = 0.4
			local var_287_43 = 1

			if var_287_42 < arg_284_1.time_ and arg_284_1.time_ <= var_287_42 + arg_287_0 then
				local var_287_44 = "play"
				local var_287_45 = "effect"

				arg_284_1:AudioAction(var_287_44, var_287_45, "se_story_side_1028", "se_story_1028_thunder", "")
			end

			if arg_284_1.frameCnt_ <= 1 then
				arg_284_1.dialog_:SetActive(false)
			end

			local var_287_46 = 0.8
			local var_287_47 = 1.35

			if var_287_46 < arg_284_1.time_ and arg_284_1.time_ <= var_287_46 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0

				arg_284_1.dialog_:SetActive(true)

				arg_284_1.dialogCg_.alpha = 0

				local var_287_48 = LeanTween.value(arg_284_1.dialog_, 0, 1, 0.3)

				var_287_48:setOnUpdate(LuaHelper.FloatAction(function(arg_288_0)
					arg_284_1.dialogCg_.alpha = arg_288_0
				end))
				var_287_48:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_284_1.dialog_)
					var_287_48:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_284_1.duration_ = arg_284_1.duration_ + 0.3

				SetActive(arg_284_1.leftNameGo_, false)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_49 = arg_284_1:GetWordFromCfg(416191067)
				local var_287_50 = arg_284_1:FormatText(var_287_49.content)

				arg_284_1.text_.text = var_287_50

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_51 = 54
				local var_287_52 = utf8.len(var_287_50)
				local var_287_53 = var_287_51 <= 0 and var_287_47 or var_287_47 * (var_287_52 / var_287_51)

				if var_287_53 > 0 and var_287_47 < var_287_53 then
					arg_284_1.talkMaxDuration = var_287_53
					var_287_46 = var_287_46 + 0.3

					if var_287_53 + var_287_46 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_53 + var_287_46
					end
				end

				arg_284_1.text_.text = var_287_50
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)
				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_54 = var_287_46 + 0.3
			local var_287_55 = math.max(var_287_47, arg_284_1.talkMaxDuration)

			if var_287_54 <= arg_284_1.time_ and arg_284_1.time_ < var_287_54 + var_287_55 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_54) / var_287_55

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_54 + var_287_55 and arg_284_1.time_ < var_287_54 + var_287_55 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_284_1:InitPlayNodeList()
	end,
	Play416191068 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 416191068
		arg_290_1.duration_ = 6.97

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play416191069(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = 1

			if var_293_0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_0 + arg_293_0 then
				local var_293_1 = manager.ui.mainCamera.transform.localPosition
				local var_293_2 = Vector3.New(0, 0, 10) + Vector3.New(var_293_1.x, var_293_1.y, 0)
				local var_293_3 = arg_290_1.bgs_.STwhite

				var_293_3.transform.localPosition = var_293_2
				var_293_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_293_4 = var_293_3:GetComponent("SpriteRenderer")

				if var_293_4 and var_293_4.sprite then
					local var_293_5 = (var_293_3.transform.localPosition - var_293_1).z
					local var_293_6 = manager.ui.mainCameraCom_
					local var_293_7 = 2 * var_293_5 * Mathf.Tan(var_293_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_293_8 = var_293_7 * var_293_6.aspect
					local var_293_9 = var_293_4.sprite.bounds.size.x
					local var_293_10 = var_293_4.sprite.bounds.size.y
					local var_293_11 = var_293_8 / var_293_9
					local var_293_12 = var_293_7 / var_293_10
					local var_293_13 = var_293_12 < var_293_11 and var_293_11 or var_293_12

					var_293_3.transform.localScale = Vector3.New(var_293_13, var_293_13, 0)
				end

				for iter_293_0, iter_293_1 in pairs(arg_290_1.bgs_) do
					if iter_293_0 ~= "STwhite" then
						iter_293_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_293_14 = 1

			if var_293_14 < arg_290_1.time_ and arg_290_1.time_ <= var_293_14 + arg_293_0 then
				arg_290_1.allBtn_.enabled = false
			end

			local var_293_15 = 0.3

			if arg_290_1.time_ >= var_293_14 + var_293_15 and arg_290_1.time_ < var_293_14 + var_293_15 + arg_293_0 then
				arg_290_1.allBtn_.enabled = true
			end

			local var_293_16 = 0

			if var_293_16 < arg_290_1.time_ and arg_290_1.time_ <= var_293_16 + arg_293_0 then
				arg_290_1.mask_.enabled = true
				arg_290_1.mask_.raycastTarget = true

				arg_290_1:SetGaussion(false)
			end

			local var_293_17 = 1

			if var_293_16 <= arg_290_1.time_ and arg_290_1.time_ < var_293_16 + var_293_17 then
				local var_293_18 = (arg_290_1.time_ - var_293_16) / var_293_17
				local var_293_19 = Color.New(0, 0, 0)

				var_293_19.a = Mathf.Lerp(0, 1, var_293_18)
				arg_290_1.mask_.color = var_293_19
			end

			if arg_290_1.time_ >= var_293_16 + var_293_17 and arg_290_1.time_ < var_293_16 + var_293_17 + arg_293_0 then
				local var_293_20 = Color.New(0, 0, 0)

				var_293_20.a = 1
				arg_290_1.mask_.color = var_293_20
			end

			local var_293_21 = 1

			if var_293_21 < arg_290_1.time_ and arg_290_1.time_ <= var_293_21 + arg_293_0 then
				arg_290_1.mask_.enabled = true
				arg_290_1.mask_.raycastTarget = true

				arg_290_1:SetGaussion(false)
			end

			local var_293_22 = 1.36666666666667

			if var_293_21 <= arg_290_1.time_ and arg_290_1.time_ < var_293_21 + var_293_22 then
				local var_293_23 = (arg_290_1.time_ - var_293_21) / var_293_22
				local var_293_24 = Color.New(0, 0, 0)

				var_293_24.a = Mathf.Lerp(1, 0, var_293_23)
				arg_290_1.mask_.color = var_293_24
			end

			if arg_290_1.time_ >= var_293_21 + var_293_22 and arg_290_1.time_ < var_293_21 + var_293_22 + arg_293_0 then
				local var_293_25 = Color.New(0, 0, 0)
				local var_293_26 = 0

				arg_290_1.mask_.enabled = false
				var_293_25.a = var_293_26
				arg_290_1.mask_.color = var_293_25
			end

			local var_293_27 = manager.ui.mainCamera.transform
			local var_293_28 = 1

			if var_293_28 < arg_290_1.time_ and arg_290_1.time_ <= var_293_28 + arg_293_0 then
				local var_293_29 = arg_290_1.var_.effect116

				if var_293_29 then
					Object.Destroy(var_293_29)

					arg_290_1.var_.effect116 = nil
				end
			end

			local var_293_30 = 1.63333333333333
			local var_293_31 = 1

			if var_293_30 < arg_290_1.time_ and arg_290_1.time_ <= var_293_30 + arg_293_0 then
				local var_293_32 = "play"
				local var_293_33 = "effect"

				arg_290_1:AudioAction(var_293_32, var_293_33, "se_story_138", "se_story_138_elecskill01", "")
			end

			if arg_290_1.frameCnt_ <= 1 then
				arg_290_1.dialog_:SetActive(false)
			end

			local var_293_34 = 1.96666666666667
			local var_293_35 = 1.55

			if var_293_34 < arg_290_1.time_ and arg_290_1.time_ <= var_293_34 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0

				arg_290_1.dialog_:SetActive(true)

				arg_290_1.dialogCg_.alpha = 0

				local var_293_36 = LeanTween.value(arg_290_1.dialog_, 0, 1, 0.3)

				var_293_36:setOnUpdate(LuaHelper.FloatAction(function(arg_294_0)
					arg_290_1.dialogCg_.alpha = arg_294_0
				end))
				var_293_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_290_1.dialog_)
					var_293_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_290_1.duration_ = arg_290_1.duration_ + 0.3

				SetActive(arg_290_1.leftNameGo_, false)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_37 = arg_290_1:GetWordFromCfg(416191068)
				local var_293_38 = arg_290_1:FormatText(var_293_37.content)

				arg_290_1.text_.text = var_293_38

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_39 = 62
				local var_293_40 = utf8.len(var_293_38)
				local var_293_41 = var_293_39 <= 0 and var_293_35 or var_293_35 * (var_293_40 / var_293_39)

				if var_293_41 > 0 and var_293_35 < var_293_41 then
					arg_290_1.talkMaxDuration = var_293_41
					var_293_34 = var_293_34 + 0.3

					if var_293_41 + var_293_34 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_41 + var_293_34
					end
				end

				arg_290_1.text_.text = var_293_38
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)
				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_42 = var_293_34 + 0.3
			local var_293_43 = math.max(var_293_35, arg_290_1.talkMaxDuration)

			if var_293_42 <= arg_290_1.time_ and arg_290_1.time_ < var_293_42 + var_293_43 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_42) / var_293_43

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_42 + var_293_43 and arg_290_1.time_ < var_293_42 + var_293_43 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play416191069 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 416191069
		arg_296_1.duration_ = 8.37

		local var_296_0 = {
			zh = 8.366,
			ja = 7.933
		}
		local var_296_1 = manager.audio:GetLocalizationFlag()

		if var_296_0[var_296_1] ~= nil then
			arg_296_1.duration_ = var_296_0[var_296_1]
		end

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play416191070(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			local var_299_0 = 1

			if var_299_0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_0 + arg_299_0 then
				local var_299_1 = manager.ui.mainCamera.transform.localPosition
				local var_299_2 = Vector3.New(0, 0, 10) + Vector3.New(var_299_1.x, var_299_1.y, 0)
				local var_299_3 = arg_296_1.bgs_.F09f

				var_299_3.transform.localPosition = var_299_2
				var_299_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_299_4 = var_299_3:GetComponent("SpriteRenderer")

				if var_299_4 and var_299_4.sprite then
					local var_299_5 = (var_299_3.transform.localPosition - var_299_1).z
					local var_299_6 = manager.ui.mainCameraCom_
					local var_299_7 = 2 * var_299_5 * Mathf.Tan(var_299_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_299_8 = var_299_7 * var_299_6.aspect
					local var_299_9 = var_299_4.sprite.bounds.size.x
					local var_299_10 = var_299_4.sprite.bounds.size.y
					local var_299_11 = var_299_8 / var_299_9
					local var_299_12 = var_299_7 / var_299_10
					local var_299_13 = var_299_12 < var_299_11 and var_299_11 or var_299_12

					var_299_3.transform.localScale = Vector3.New(var_299_13, var_299_13, 0)
				end

				for iter_299_0, iter_299_1 in pairs(arg_296_1.bgs_) do
					if iter_299_0 ~= "F09f" then
						iter_299_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_299_14 = 1

			if var_299_14 < arg_296_1.time_ and arg_296_1.time_ <= var_299_14 + arg_299_0 then
				arg_296_1.allBtn_.enabled = false
			end

			local var_299_15 = 0.3

			if arg_296_1.time_ >= var_299_14 + var_299_15 and arg_296_1.time_ < var_299_14 + var_299_15 + arg_299_0 then
				arg_296_1.allBtn_.enabled = true
			end

			local var_299_16 = 0

			if var_299_16 < arg_296_1.time_ and arg_296_1.time_ <= var_299_16 + arg_299_0 then
				arg_296_1.mask_.enabled = true
				arg_296_1.mask_.raycastTarget = true

				arg_296_1:SetGaussion(false)
			end

			local var_299_17 = 1

			if var_299_16 <= arg_296_1.time_ and arg_296_1.time_ < var_299_16 + var_299_17 then
				local var_299_18 = (arg_296_1.time_ - var_299_16) / var_299_17
				local var_299_19 = Color.New(0, 0, 0)

				var_299_19.a = Mathf.Lerp(0, 1, var_299_18)
				arg_296_1.mask_.color = var_299_19
			end

			if arg_296_1.time_ >= var_299_16 + var_299_17 and arg_296_1.time_ < var_299_16 + var_299_17 + arg_299_0 then
				local var_299_20 = Color.New(0, 0, 0)

				var_299_20.a = 1
				arg_296_1.mask_.color = var_299_20
			end

			local var_299_21 = 1

			if var_299_21 < arg_296_1.time_ and arg_296_1.time_ <= var_299_21 + arg_299_0 then
				arg_296_1.mask_.enabled = true
				arg_296_1.mask_.raycastTarget = true

				arg_296_1:SetGaussion(false)
			end

			local var_299_22 = 2

			if var_299_21 <= arg_296_1.time_ and arg_296_1.time_ < var_299_21 + var_299_22 then
				local var_299_23 = (arg_296_1.time_ - var_299_21) / var_299_22
				local var_299_24 = Color.New(0, 0, 0)

				var_299_24.a = Mathf.Lerp(1, 0, var_299_23)
				arg_296_1.mask_.color = var_299_24
			end

			if arg_296_1.time_ >= var_299_21 + var_299_22 and arg_296_1.time_ < var_299_21 + var_299_22 + arg_299_0 then
				local var_299_25 = Color.New(0, 0, 0)
				local var_299_26 = 0

				arg_296_1.mask_.enabled = false
				var_299_25.a = var_299_26
				arg_296_1.mask_.color = var_299_25
			end

			local var_299_27 = arg_296_1.actors_["1086"]
			local var_299_28 = 1

			if var_299_28 < arg_296_1.time_ and arg_296_1.time_ <= var_299_28 + arg_299_0 and not isNil(var_299_27) and arg_296_1.var_.actorSpriteComps1086 == nil then
				arg_296_1.var_.actorSpriteComps1086 = var_299_27:GetComponentsInChildren(typeof(Image), true)
			end

			local var_299_29 = 0.2

			if var_299_28 <= arg_296_1.time_ and arg_296_1.time_ < var_299_28 + var_299_29 and not isNil(var_299_27) then
				local var_299_30 = (arg_296_1.time_ - var_299_28) / var_299_29

				if arg_296_1.var_.actorSpriteComps1086 then
					for iter_299_2, iter_299_3 in pairs(arg_296_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_299_3 then
							if arg_296_1.isInRecall_ then
								local var_299_31 = Mathf.Lerp(iter_299_3.color.r, arg_296_1.hightColor1.r, var_299_30)
								local var_299_32 = Mathf.Lerp(iter_299_3.color.g, arg_296_1.hightColor1.g, var_299_30)
								local var_299_33 = Mathf.Lerp(iter_299_3.color.b, arg_296_1.hightColor1.b, var_299_30)

								iter_299_3.color = Color.New(var_299_31, var_299_32, var_299_33)
							else
								local var_299_34 = Mathf.Lerp(iter_299_3.color.r, 1, var_299_30)

								iter_299_3.color = Color.New(var_299_34, var_299_34, var_299_34)
							end
						end
					end
				end
			end

			if arg_296_1.time_ >= var_299_28 + var_299_29 and arg_296_1.time_ < var_299_28 + var_299_29 + arg_299_0 and not isNil(var_299_27) and arg_296_1.var_.actorSpriteComps1086 then
				for iter_299_4, iter_299_5 in pairs(arg_296_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_299_5 then
						if arg_296_1.isInRecall_ then
							iter_299_5.color = arg_296_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_299_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_296_1.var_.actorSpriteComps1086 = nil
			end

			local var_299_35
			local var_299_36 = 1

			if var_299_36 < arg_296_1.time_ and arg_296_1.time_ <= var_299_36 + arg_299_0 then
				local var_299_37 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_299_37 then
					var_299_37.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_299_37.radialBlurScale = 0
					var_299_37.radialBlurGradient = 1
					var_299_37.radialBlurIntensity = 1

					if var_299_35 then
						var_299_37.radialBlurTarget = var_299_35.transform
					end
				end
			end

			local var_299_38 = 0.3

			if var_299_36 <= arg_296_1.time_ and arg_296_1.time_ < var_299_36 + var_299_38 then
				local var_299_39 = (arg_296_1.time_ - var_299_36) / var_299_38
				local var_299_40 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_299_40 then
					var_299_40.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_299_40.radialBlurScale = Mathf.Lerp(0, 0, var_299_39)
					var_299_40.radialBlurGradient = Mathf.Lerp(1, 1, var_299_39)
					var_299_40.radialBlurIntensity = Mathf.Lerp(1, 1, var_299_39)
				end
			end

			if arg_296_1.time_ >= var_299_36 + var_299_38 and arg_296_1.time_ < var_299_36 + var_299_38 + arg_299_0 then
				local var_299_41 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_299_41 then
					var_299_41.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_299_41.radialBlurScale = 0
					var_299_41.radialBlurGradient = 1
					var_299_41.radialBlurIntensity = 1
				end
			end

			local var_299_42 = 0
			local var_299_43 = 1

			if var_299_42 < arg_296_1.time_ and arg_296_1.time_ <= var_299_42 + arg_299_0 then
				local var_299_44 = "play"
				local var_299_45 = "effect"

				arg_296_1:AudioAction(var_299_44, var_299_45, "se_story_122_01", "se_story_122_01_dizzy_loop", "")
			end

			if arg_296_1.frameCnt_ <= 1 then
				arg_296_1.dialog_:SetActive(false)
			end

			local var_299_46 = 2.6
			local var_299_47 = 0.4

			if var_299_46 < arg_296_1.time_ and arg_296_1.time_ <= var_299_46 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0

				arg_296_1.dialog_:SetActive(true)

				arg_296_1.dialogCg_.alpha = 0

				local var_299_48 = LeanTween.value(arg_296_1.dialog_, 0, 1, 0.3)

				var_299_48:setOnUpdate(LuaHelper.FloatAction(function(arg_300_0)
					arg_296_1.dialogCg_.alpha = arg_300_0
				end))
				var_299_48:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_296_1.dialog_)
					var_299_48:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_296_1.duration_ = arg_296_1.duration_ + 0.3

				SetActive(arg_296_1.leftNameGo_, true)

				local var_299_49 = arg_296_1:FormatText(StoryNameCfg[1080].name)

				arg_296_1.leftNameTxt_.text = var_299_49

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, true)
				arg_296_1.iconController_:SetSelectedState("hero")

				arg_296_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1086_split_5")

				arg_296_1.callingController_:SetSelectedState("normal")

				arg_296_1.keyicon_.color = Color.New(1, 1, 1)
				arg_296_1.icon_.color = Color.New(1, 1, 1)

				local var_299_50 = arg_296_1:GetWordFromCfg(416191069)
				local var_299_51 = arg_296_1:FormatText(var_299_50.content)

				arg_296_1.text_.text = var_299_51

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_52 = 16
				local var_299_53 = utf8.len(var_299_51)
				local var_299_54 = var_299_52 <= 0 and var_299_47 or var_299_47 * (var_299_53 / var_299_52)

				if var_299_54 > 0 and var_299_47 < var_299_54 then
					arg_296_1.talkMaxDuration = var_299_54
					var_299_46 = var_299_46 + 0.3

					if var_299_54 + var_299_46 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_54 + var_299_46
					end
				end

				arg_296_1.text_.text = var_299_51
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191069", "story_v_out_416191.awb") ~= 0 then
					local var_299_55 = manager.audio:GetVoiceLength("story_v_out_416191", "416191069", "story_v_out_416191.awb") / 1000

					if var_299_55 + var_299_46 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_55 + var_299_46
					end

					if var_299_50.prefab_name ~= "" and arg_296_1.actors_[var_299_50.prefab_name] ~= nil then
						local var_299_56 = LuaForUtil.PlayVoiceWithCriLipsync(arg_296_1.actors_[var_299_50.prefab_name].transform, "story_v_out_416191", "416191069", "story_v_out_416191.awb")

						arg_296_1:RecordAudio("416191069", var_299_56)
						arg_296_1:RecordAudio("416191069", var_299_56)
					else
						arg_296_1:AudioAction("play", "voice", "story_v_out_416191", "416191069", "story_v_out_416191.awb")
					end

					arg_296_1:RecordHistoryTalkVoice("story_v_out_416191", "416191069", "story_v_out_416191.awb")
				end

				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_57 = var_299_46 + 0.3
			local var_299_58 = math.max(var_299_47, arg_296_1.talkMaxDuration)

			if var_299_57 <= arg_296_1.time_ and arg_296_1.time_ < var_299_57 + var_299_58 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_57) / var_299_58

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_57 + var_299_58 and arg_296_1.time_ < var_299_57 + var_299_58 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {}

		arg_296_1:InitPlayNodeList()
	end,
	Play416191070 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 416191070
		arg_302_1.duration_ = 5

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play416191071(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = 0
			local var_305_1 = 1

			if var_305_0 < arg_302_1.time_ and arg_302_1.time_ <= var_305_0 + arg_305_0 then
				local var_305_2 = "play"
				local var_305_3 = "effect"

				arg_302_1:AudioAction(var_305_2, var_305_3, "se_story_120_04", "se_story_120_04_clap", "")
			end

			local var_305_4 = 0
			local var_305_5 = 1

			if var_305_4 < arg_302_1.time_ and arg_302_1.time_ <= var_305_4 + arg_305_0 then
				local var_305_6 = "stop"
				local var_305_7 = "effect"

				arg_302_1:AudioAction(var_305_6, var_305_7, "se_story_122_01", "se_story_122_01_dizzy_loop", "")
			end

			local var_305_8 = 0
			local var_305_9 = 1.3

			if var_305_8 < arg_302_1.time_ and arg_302_1.time_ <= var_305_8 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, false)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_10 = arg_302_1:GetWordFromCfg(416191070)
				local var_305_11 = arg_302_1:FormatText(var_305_10.content)

				arg_302_1.text_.text = var_305_11

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_12 = 52
				local var_305_13 = utf8.len(var_305_11)
				local var_305_14 = var_305_12 <= 0 and var_305_9 or var_305_9 * (var_305_13 / var_305_12)

				if var_305_14 > 0 and var_305_9 < var_305_14 then
					arg_302_1.talkMaxDuration = var_305_14

					if var_305_14 + var_305_8 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_14 + var_305_8
					end
				end

				arg_302_1.text_.text = var_305_11
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)
				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_15 = math.max(var_305_9, arg_302_1.talkMaxDuration)

			if var_305_8 <= arg_302_1.time_ and arg_302_1.time_ < var_305_8 + var_305_15 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_8) / var_305_15

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_8 + var_305_15 and arg_302_1.time_ < var_305_8 + var_305_15 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {}

		arg_302_1:InitPlayNodeList()
	end,
	Play416191071 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 416191071
		arg_306_1.duration_ = 10.2

		local var_306_0 = {
			zh = 10.1996666666667,
			ja = 7.43266666666667
		}
		local var_306_1 = manager.audio:GetLocalizationFlag()

		if var_306_0[var_306_1] ~= nil then
			arg_306_1.duration_ = var_306_0[var_306_1]
		end

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play416191072(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = arg_306_1.actors_["1086"]
			local var_309_1 = 1.53333333333333

			if var_309_1 < arg_306_1.time_ and arg_306_1.time_ <= var_309_1 + arg_309_0 and not isNil(var_309_0) and arg_306_1.var_.actorSpriteComps1086 == nil then
				arg_306_1.var_.actorSpriteComps1086 = var_309_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_309_2 = 0.2

			if var_309_1 <= arg_306_1.time_ and arg_306_1.time_ < var_309_1 + var_309_2 and not isNil(var_309_0) then
				local var_309_3 = (arg_306_1.time_ - var_309_1) / var_309_2

				if arg_306_1.var_.actorSpriteComps1086 then
					for iter_309_0, iter_309_1 in pairs(arg_306_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_309_1 then
							if arg_306_1.isInRecall_ then
								local var_309_4 = Mathf.Lerp(iter_309_1.color.r, arg_306_1.hightColor1.r, var_309_3)
								local var_309_5 = Mathf.Lerp(iter_309_1.color.g, arg_306_1.hightColor1.g, var_309_3)
								local var_309_6 = Mathf.Lerp(iter_309_1.color.b, arg_306_1.hightColor1.b, var_309_3)

								iter_309_1.color = Color.New(var_309_4, var_309_5, var_309_6)
							else
								local var_309_7 = Mathf.Lerp(iter_309_1.color.r, 1, var_309_3)

								iter_309_1.color = Color.New(var_309_7, var_309_7, var_309_7)
							end
						end
					end
				end
			end

			if arg_306_1.time_ >= var_309_1 + var_309_2 and arg_306_1.time_ < var_309_1 + var_309_2 + arg_309_0 and not isNil(var_309_0) and arg_306_1.var_.actorSpriteComps1086 then
				for iter_309_2, iter_309_3 in pairs(arg_306_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_309_3 then
						if arg_306_1.isInRecall_ then
							iter_309_3.color = arg_306_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_309_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_306_1.var_.actorSpriteComps1086 = nil
			end

			local var_309_8 = arg_306_1.actors_["1086"].transform
			local var_309_9 = 1.53333333333333

			if var_309_9 < arg_306_1.time_ and arg_306_1.time_ <= var_309_9 + arg_309_0 then
				arg_306_1.var_.moveOldPos1086 = var_309_8.localPosition
				var_309_8.localScale = Vector3.New(1, 1, 1)

				arg_306_1:CheckSpriteTmpPos("1086", 3)

				local var_309_10 = var_309_8.childCount

				for iter_309_4 = 0, var_309_10 - 1 do
					local var_309_11 = var_309_8:GetChild(iter_309_4)

					if var_309_11.name == "split_5" or not string.find(var_309_11.name, "split") then
						var_309_11.gameObject:SetActive(true)
					else
						var_309_11.gameObject:SetActive(false)
					end
				end
			end

			local var_309_12 = 0.001

			if var_309_9 <= arg_306_1.time_ and arg_306_1.time_ < var_309_9 + var_309_12 then
				local var_309_13 = (arg_306_1.time_ - var_309_9) / var_309_12
				local var_309_14 = Vector3.New(0, -404.2, -237.9)

				var_309_8.localPosition = Vector3.Lerp(arg_306_1.var_.moveOldPos1086, var_309_14, var_309_13)
			end

			if arg_306_1.time_ >= var_309_9 + var_309_12 and arg_306_1.time_ < var_309_9 + var_309_12 + arg_309_0 then
				var_309_8.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_309_15
			local var_309_16 = 0

			if var_309_16 < arg_306_1.time_ and arg_306_1.time_ <= var_309_16 + arg_309_0 then
				local var_309_17 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_309_17 then
					var_309_17.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_309_17.radialBlurScale = 0
					var_309_17.radialBlurGradient = 1
					var_309_17.radialBlurIntensity = 1

					if var_309_15 then
						var_309_17.radialBlurTarget = var_309_15.transform
					end
				end
			end

			local var_309_18 = 0.833333333333333

			if var_309_16 <= arg_306_1.time_ and arg_306_1.time_ < var_309_16 + var_309_18 then
				local var_309_19 = (arg_306_1.time_ - var_309_16) / var_309_18
				local var_309_20 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_309_20 then
					var_309_20.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_309_20.radialBlurScale = Mathf.Lerp(0, 0, var_309_19)
					var_309_20.radialBlurGradient = Mathf.Lerp(1, 1, var_309_19)
					var_309_20.radialBlurIntensity = Mathf.Lerp(1, 1, var_309_19)
				end
			end

			if arg_306_1.time_ >= var_309_16 + var_309_18 and arg_306_1.time_ < var_309_16 + var_309_18 + arg_309_0 then
				local var_309_21 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_309_21 then
					var_309_21.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_309_21.radialBlurScale = 0
					var_309_21.radialBlurGradient = 1
					var_309_21.radialBlurIntensity = 1
				end
			end

			local var_309_22 = 0

			if var_309_22 < arg_306_1.time_ and arg_306_1.time_ <= var_309_22 + arg_309_0 then
				arg_306_1.mask_.enabled = true
				arg_306_1.mask_.raycastTarget = true

				arg_306_1:SetGaussion(false)
			end

			local var_309_23 = 1.73333333333333

			if var_309_22 <= arg_306_1.time_ and arg_306_1.time_ < var_309_22 + var_309_23 then
				local var_309_24 = (arg_306_1.time_ - var_309_22) / var_309_23
				local var_309_25 = Color.New(0, 0, 0)

				var_309_25.a = Mathf.Lerp(1, 0, var_309_24)
				arg_306_1.mask_.color = var_309_25
			end

			if arg_306_1.time_ >= var_309_22 + var_309_23 and arg_306_1.time_ < var_309_22 + var_309_23 + arg_309_0 then
				local var_309_26 = Color.New(0, 0, 0)
				local var_309_27 = 0

				arg_306_1.mask_.enabled = false
				var_309_26.a = var_309_27
				arg_306_1.mask_.color = var_309_26
			end

			local var_309_28 = arg_306_1.actors_["1086"]
			local var_309_29 = 1.53333333333333

			if var_309_29 < arg_306_1.time_ and arg_306_1.time_ <= var_309_29 + arg_309_0 then
				local var_309_30 = var_309_28:GetComponentInChildren(typeof(CanvasGroup))

				if var_309_30 then
					arg_306_1.var_.alphaOldValue1086 = var_309_30.alpha
					arg_306_1.var_.characterEffect1086 = var_309_30
				end

				arg_306_1.var_.alphaOldValue1086 = 0
			end

			local var_309_31 = 0.2

			if var_309_29 <= arg_306_1.time_ and arg_306_1.time_ < var_309_29 + var_309_31 then
				local var_309_32 = (arg_306_1.time_ - var_309_29) / var_309_31
				local var_309_33 = Mathf.Lerp(arg_306_1.var_.alphaOldValue1086, 1, var_309_32)

				if arg_306_1.var_.characterEffect1086 then
					arg_306_1.var_.characterEffect1086.alpha = var_309_33
				end
			end

			if arg_306_1.time_ >= var_309_29 + var_309_31 and arg_306_1.time_ < var_309_29 + var_309_31 + arg_309_0 and arg_306_1.var_.characterEffect1086 then
				arg_306_1.var_.characterEffect1086.alpha = 1
			end

			if arg_306_1.frameCnt_ <= 1 then
				arg_306_1.dialog_:SetActive(false)
			end

			local var_309_34 = 1.86666666666667
			local var_309_35 = 0.6

			if var_309_34 < arg_306_1.time_ and arg_306_1.time_ <= var_309_34 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0

				arg_306_1.dialog_:SetActive(true)

				arg_306_1.dialogCg_.alpha = 0

				local var_309_36 = LeanTween.value(arg_306_1.dialog_, 0, 1, 0.3)

				var_309_36:setOnUpdate(LuaHelper.FloatAction(function(arg_310_0)
					arg_306_1.dialogCg_.alpha = arg_310_0
				end))
				var_309_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_306_1.dialog_)
					var_309_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_306_1.duration_ = arg_306_1.duration_ + 0.3

				SetActive(arg_306_1.leftNameGo_, true)

				local var_309_37 = arg_306_1:FormatText(StoryNameCfg[1080].name)

				arg_306_1.leftNameTxt_.text = var_309_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_38 = arg_306_1:GetWordFromCfg(416191071)
				local var_309_39 = arg_306_1:FormatText(var_309_38.content)

				arg_306_1.text_.text = var_309_39

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_40 = 24
				local var_309_41 = utf8.len(var_309_39)
				local var_309_42 = var_309_40 <= 0 and var_309_35 or var_309_35 * (var_309_41 / var_309_40)

				if var_309_42 > 0 and var_309_35 < var_309_42 then
					arg_306_1.talkMaxDuration = var_309_42
					var_309_34 = var_309_34 + 0.3

					if var_309_42 + var_309_34 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_42 + var_309_34
					end
				end

				arg_306_1.text_.text = var_309_39
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191071", "story_v_out_416191.awb") ~= 0 then
					local var_309_43 = manager.audio:GetVoiceLength("story_v_out_416191", "416191071", "story_v_out_416191.awb") / 1000

					if var_309_43 + var_309_34 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_43 + var_309_34
					end

					if var_309_38.prefab_name ~= "" and arg_306_1.actors_[var_309_38.prefab_name] ~= nil then
						local var_309_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_306_1.actors_[var_309_38.prefab_name].transform, "story_v_out_416191", "416191071", "story_v_out_416191.awb")

						arg_306_1:RecordAudio("416191071", var_309_44)
						arg_306_1:RecordAudio("416191071", var_309_44)
					else
						arg_306_1:AudioAction("play", "voice", "story_v_out_416191", "416191071", "story_v_out_416191.awb")
					end

					arg_306_1:RecordHistoryTalkVoice("story_v_out_416191", "416191071", "story_v_out_416191.awb")
				end

				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_45 = var_309_34 + 0.3
			local var_309_46 = math.max(var_309_35, arg_306_1.talkMaxDuration)

			if var_309_45 <= arg_306_1.time_ and arg_306_1.time_ < var_309_45 + var_309_46 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_45) / var_309_46

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_45 + var_309_46 and arg_306_1.time_ < var_309_45 + var_309_46 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.53333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_306_1:InitPlayNodeList()
	end,
	Play416191072 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 416191072
		arg_312_1.duration_ = 10.13

		local var_312_0 = {
			zh = 6.033,
			ja = 10.133
		}
		local var_312_1 = manager.audio:GetLocalizationFlag()

		if var_312_0[var_312_1] ~= nil then
			arg_312_1.duration_ = var_312_0[var_312_1]
		end

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play416191073(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			local var_315_0 = arg_312_1.actors_["1028"]
			local var_315_1 = 0

			if var_315_1 < arg_312_1.time_ and arg_312_1.time_ <= var_315_1 + arg_315_0 and not isNil(var_315_0) and arg_312_1.var_.actorSpriteComps1028 == nil then
				arg_312_1.var_.actorSpriteComps1028 = var_315_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_315_2 = 0.2

			if var_315_1 <= arg_312_1.time_ and arg_312_1.time_ < var_315_1 + var_315_2 and not isNil(var_315_0) then
				local var_315_3 = (arg_312_1.time_ - var_315_1) / var_315_2

				if arg_312_1.var_.actorSpriteComps1028 then
					for iter_315_0, iter_315_1 in pairs(arg_312_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_315_1 then
							if arg_312_1.isInRecall_ then
								local var_315_4 = Mathf.Lerp(iter_315_1.color.r, arg_312_1.hightColor1.r, var_315_3)
								local var_315_5 = Mathf.Lerp(iter_315_1.color.g, arg_312_1.hightColor1.g, var_315_3)
								local var_315_6 = Mathf.Lerp(iter_315_1.color.b, arg_312_1.hightColor1.b, var_315_3)

								iter_315_1.color = Color.New(var_315_4, var_315_5, var_315_6)
							else
								local var_315_7 = Mathf.Lerp(iter_315_1.color.r, 1, var_315_3)

								iter_315_1.color = Color.New(var_315_7, var_315_7, var_315_7)
							end
						end
					end
				end
			end

			if arg_312_1.time_ >= var_315_1 + var_315_2 and arg_312_1.time_ < var_315_1 + var_315_2 + arg_315_0 and not isNil(var_315_0) and arg_312_1.var_.actorSpriteComps1028 then
				for iter_315_2, iter_315_3 in pairs(arg_312_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_315_3 then
						if arg_312_1.isInRecall_ then
							iter_315_3.color = arg_312_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_315_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_312_1.var_.actorSpriteComps1028 = nil
			end

			local var_315_8 = arg_312_1.actors_["1086"]
			local var_315_9 = 0

			if var_315_9 < arg_312_1.time_ and arg_312_1.time_ <= var_315_9 + arg_315_0 and not isNil(var_315_8) and arg_312_1.var_.actorSpriteComps1086 == nil then
				arg_312_1.var_.actorSpriteComps1086 = var_315_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_315_10 = 0.2

			if var_315_9 <= arg_312_1.time_ and arg_312_1.time_ < var_315_9 + var_315_10 and not isNil(var_315_8) then
				local var_315_11 = (arg_312_1.time_ - var_315_9) / var_315_10

				if arg_312_1.var_.actorSpriteComps1086 then
					for iter_315_4, iter_315_5 in pairs(arg_312_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_315_5 then
							if arg_312_1.isInRecall_ then
								local var_315_12 = Mathf.Lerp(iter_315_5.color.r, arg_312_1.hightColor2.r, var_315_11)
								local var_315_13 = Mathf.Lerp(iter_315_5.color.g, arg_312_1.hightColor2.g, var_315_11)
								local var_315_14 = Mathf.Lerp(iter_315_5.color.b, arg_312_1.hightColor2.b, var_315_11)

								iter_315_5.color = Color.New(var_315_12, var_315_13, var_315_14)
							else
								local var_315_15 = Mathf.Lerp(iter_315_5.color.r, 0.5, var_315_11)

								iter_315_5.color = Color.New(var_315_15, var_315_15, var_315_15)
							end
						end
					end
				end
			end

			if arg_312_1.time_ >= var_315_9 + var_315_10 and arg_312_1.time_ < var_315_9 + var_315_10 + arg_315_0 and not isNil(var_315_8) and arg_312_1.var_.actorSpriteComps1086 then
				for iter_315_6, iter_315_7 in pairs(arg_312_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_315_7 then
						if arg_312_1.isInRecall_ then
							iter_315_7.color = arg_312_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_315_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_312_1.var_.actorSpriteComps1086 = nil
			end

			local var_315_16 = arg_312_1.actors_["1028"].transform
			local var_315_17 = 0

			if var_315_17 < arg_312_1.time_ and arg_312_1.time_ <= var_315_17 + arg_315_0 then
				arg_312_1.var_.moveOldPos1028 = var_315_16.localPosition
				var_315_16.localScale = Vector3.New(1, 1, 1)

				arg_312_1:CheckSpriteTmpPos("1028", 2)

				local var_315_18 = var_315_16.childCount

				for iter_315_8 = 0, var_315_18 - 1 do
					local var_315_19 = var_315_16:GetChild(iter_315_8)

					if var_315_19.name == "" or not string.find(var_315_19.name, "split") then
						var_315_19.gameObject:SetActive(true)
					else
						var_315_19.gameObject:SetActive(false)
					end
				end
			end

			local var_315_20 = 0.001

			if var_315_17 <= arg_312_1.time_ and arg_312_1.time_ < var_315_17 + var_315_20 then
				local var_315_21 = (arg_312_1.time_ - var_315_17) / var_315_20
				local var_315_22 = Vector3.New(-390, -402.7, -156.1)

				var_315_16.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos1028, var_315_22, var_315_21)
			end

			if arg_312_1.time_ >= var_315_17 + var_315_20 and arg_312_1.time_ < var_315_17 + var_315_20 + arg_315_0 then
				var_315_16.localPosition = Vector3.New(-390, -402.7, -156.1)
			end

			local var_315_23 = arg_312_1.actors_["1086"].transform
			local var_315_24 = 0

			if var_315_24 < arg_312_1.time_ and arg_312_1.time_ <= var_315_24 + arg_315_0 then
				arg_312_1.var_.moveOldPos1086 = var_315_23.localPosition
				var_315_23.localScale = Vector3.New(1, 1, 1)

				arg_312_1:CheckSpriteTmpPos("1086", 4)

				local var_315_25 = var_315_23.childCount

				for iter_315_9 = 0, var_315_25 - 1 do
					local var_315_26 = var_315_23:GetChild(iter_315_9)

					if var_315_26.name == "split_5" or not string.find(var_315_26.name, "split") then
						var_315_26.gameObject:SetActive(true)
					else
						var_315_26.gameObject:SetActive(false)
					end
				end
			end

			local var_315_27 = 0.001

			if var_315_24 <= arg_312_1.time_ and arg_312_1.time_ < var_315_24 + var_315_27 then
				local var_315_28 = (arg_312_1.time_ - var_315_24) / var_315_27
				local var_315_29 = Vector3.New(390, -404.2, -237.9)

				var_315_23.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos1086, var_315_29, var_315_28)
			end

			if arg_312_1.time_ >= var_315_24 + var_315_27 and arg_312_1.time_ < var_315_24 + var_315_27 + arg_315_0 then
				var_315_23.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_315_30 = 0
			local var_315_31 = 0.525

			if var_315_30 < arg_312_1.time_ and arg_312_1.time_ <= var_315_30 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				local var_315_32 = arg_312_1:FormatText(StoryNameCfg[327].name)

				arg_312_1.leftNameTxt_.text = var_315_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_33 = arg_312_1:GetWordFromCfg(416191072)
				local var_315_34 = arg_312_1:FormatText(var_315_33.content)

				arg_312_1.text_.text = var_315_34

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_35 = 21
				local var_315_36 = utf8.len(var_315_34)
				local var_315_37 = var_315_35 <= 0 and var_315_31 or var_315_31 * (var_315_36 / var_315_35)

				if var_315_37 > 0 and var_315_31 < var_315_37 then
					arg_312_1.talkMaxDuration = var_315_37

					if var_315_37 + var_315_30 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_37 + var_315_30
					end
				end

				arg_312_1.text_.text = var_315_34
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191072", "story_v_out_416191.awb") ~= 0 then
					local var_315_38 = manager.audio:GetVoiceLength("story_v_out_416191", "416191072", "story_v_out_416191.awb") / 1000

					if var_315_38 + var_315_30 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_38 + var_315_30
					end

					if var_315_33.prefab_name ~= "" and arg_312_1.actors_[var_315_33.prefab_name] ~= nil then
						local var_315_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_312_1.actors_[var_315_33.prefab_name].transform, "story_v_out_416191", "416191072", "story_v_out_416191.awb")

						arg_312_1:RecordAudio("416191072", var_315_39)
						arg_312_1:RecordAudio("416191072", var_315_39)
					else
						arg_312_1:AudioAction("play", "voice", "story_v_out_416191", "416191072", "story_v_out_416191.awb")
					end

					arg_312_1:RecordHistoryTalkVoice("story_v_out_416191", "416191072", "story_v_out_416191.awb")
				end

				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_40 = math.max(var_315_31, arg_312_1.talkMaxDuration)

			if var_315_30 <= arg_312_1.time_ and arg_312_1.time_ < var_315_30 + var_315_40 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_30) / var_315_40

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_30 + var_315_40 and arg_312_1.time_ < var_315_30 + var_315_40 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_312_1:InitPlayNodeList()
	end,
	Play416191073 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 416191073
		arg_316_1.duration_ = 7.9

		local var_316_0 = {
			zh = 5.566,
			ja = 7.9
		}
		local var_316_1 = manager.audio:GetLocalizationFlag()

		if var_316_0[var_316_1] ~= nil then
			arg_316_1.duration_ = var_316_0[var_316_1]
		end

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play416191074(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			local var_319_0 = arg_316_1.actors_["1086"]
			local var_319_1 = 0

			if var_319_1 < arg_316_1.time_ and arg_316_1.time_ <= var_319_1 + arg_319_0 and not isNil(var_319_0) and arg_316_1.var_.actorSpriteComps1086 == nil then
				arg_316_1.var_.actorSpriteComps1086 = var_319_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_319_2 = 0.2

			if var_319_1 <= arg_316_1.time_ and arg_316_1.time_ < var_319_1 + var_319_2 and not isNil(var_319_0) then
				local var_319_3 = (arg_316_1.time_ - var_319_1) / var_319_2

				if arg_316_1.var_.actorSpriteComps1086 then
					for iter_319_0, iter_319_1 in pairs(arg_316_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_319_1 then
							if arg_316_1.isInRecall_ then
								local var_319_4 = Mathf.Lerp(iter_319_1.color.r, arg_316_1.hightColor1.r, var_319_3)
								local var_319_5 = Mathf.Lerp(iter_319_1.color.g, arg_316_1.hightColor1.g, var_319_3)
								local var_319_6 = Mathf.Lerp(iter_319_1.color.b, arg_316_1.hightColor1.b, var_319_3)

								iter_319_1.color = Color.New(var_319_4, var_319_5, var_319_6)
							else
								local var_319_7 = Mathf.Lerp(iter_319_1.color.r, 1, var_319_3)

								iter_319_1.color = Color.New(var_319_7, var_319_7, var_319_7)
							end
						end
					end
				end
			end

			if arg_316_1.time_ >= var_319_1 + var_319_2 and arg_316_1.time_ < var_319_1 + var_319_2 + arg_319_0 and not isNil(var_319_0) and arg_316_1.var_.actorSpriteComps1086 then
				for iter_319_2, iter_319_3 in pairs(arg_316_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_319_3 then
						if arg_316_1.isInRecall_ then
							iter_319_3.color = arg_316_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_319_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_316_1.var_.actorSpriteComps1086 = nil
			end

			local var_319_8 = arg_316_1.actors_["1028"]
			local var_319_9 = 0

			if var_319_9 < arg_316_1.time_ and arg_316_1.time_ <= var_319_9 + arg_319_0 and not isNil(var_319_8) and arg_316_1.var_.actorSpriteComps1028 == nil then
				arg_316_1.var_.actorSpriteComps1028 = var_319_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_319_10 = 0.2

			if var_319_9 <= arg_316_1.time_ and arg_316_1.time_ < var_319_9 + var_319_10 and not isNil(var_319_8) then
				local var_319_11 = (arg_316_1.time_ - var_319_9) / var_319_10

				if arg_316_1.var_.actorSpriteComps1028 then
					for iter_319_4, iter_319_5 in pairs(arg_316_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_319_5 then
							if arg_316_1.isInRecall_ then
								local var_319_12 = Mathf.Lerp(iter_319_5.color.r, arg_316_1.hightColor2.r, var_319_11)
								local var_319_13 = Mathf.Lerp(iter_319_5.color.g, arg_316_1.hightColor2.g, var_319_11)
								local var_319_14 = Mathf.Lerp(iter_319_5.color.b, arg_316_1.hightColor2.b, var_319_11)

								iter_319_5.color = Color.New(var_319_12, var_319_13, var_319_14)
							else
								local var_319_15 = Mathf.Lerp(iter_319_5.color.r, 0.5, var_319_11)

								iter_319_5.color = Color.New(var_319_15, var_319_15, var_319_15)
							end
						end
					end
				end
			end

			if arg_316_1.time_ >= var_319_9 + var_319_10 and arg_316_1.time_ < var_319_9 + var_319_10 + arg_319_0 and not isNil(var_319_8) and arg_316_1.var_.actorSpriteComps1028 then
				for iter_319_6, iter_319_7 in pairs(arg_316_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_319_7 then
						if arg_316_1.isInRecall_ then
							iter_319_7.color = arg_316_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_319_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_316_1.var_.actorSpriteComps1028 = nil
			end

			local var_319_16 = arg_316_1.actors_["1086"].transform
			local var_319_17 = 0

			if var_319_17 < arg_316_1.time_ and arg_316_1.time_ <= var_319_17 + arg_319_0 then
				arg_316_1.var_.moveOldPos1086 = var_319_16.localPosition
				var_319_16.localScale = Vector3.New(1, 1, 1)

				arg_316_1:CheckSpriteTmpPos("1086", 4)

				local var_319_18 = var_319_16.childCount

				for iter_319_8 = 0, var_319_18 - 1 do
					local var_319_19 = var_319_16:GetChild(iter_319_8)

					if var_319_19.name == "split_4" or not string.find(var_319_19.name, "split") then
						var_319_19.gameObject:SetActive(true)
					else
						var_319_19.gameObject:SetActive(false)
					end
				end
			end

			local var_319_20 = 0.001

			if var_319_17 <= arg_316_1.time_ and arg_316_1.time_ < var_319_17 + var_319_20 then
				local var_319_21 = (arg_316_1.time_ - var_319_17) / var_319_20
				local var_319_22 = Vector3.New(390, -404.2, -237.9)

				var_319_16.localPosition = Vector3.Lerp(arg_316_1.var_.moveOldPos1086, var_319_22, var_319_21)
			end

			if arg_316_1.time_ >= var_319_17 + var_319_20 and arg_316_1.time_ < var_319_17 + var_319_20 + arg_319_0 then
				var_319_16.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_319_23 = 0
			local var_319_24 = 0.45

			if var_319_23 < arg_316_1.time_ and arg_316_1.time_ <= var_319_23 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				local var_319_25 = arg_316_1:FormatText(StoryNameCfg[1080].name)

				arg_316_1.leftNameTxt_.text = var_319_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_26 = arg_316_1:GetWordFromCfg(416191073)
				local var_319_27 = arg_316_1:FormatText(var_319_26.content)

				arg_316_1.text_.text = var_319_27

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_28 = 18
				local var_319_29 = utf8.len(var_319_27)
				local var_319_30 = var_319_28 <= 0 and var_319_24 or var_319_24 * (var_319_29 / var_319_28)

				if var_319_30 > 0 and var_319_24 < var_319_30 then
					arg_316_1.talkMaxDuration = var_319_30

					if var_319_30 + var_319_23 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_30 + var_319_23
					end
				end

				arg_316_1.text_.text = var_319_27
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191073", "story_v_out_416191.awb") ~= 0 then
					local var_319_31 = manager.audio:GetVoiceLength("story_v_out_416191", "416191073", "story_v_out_416191.awb") / 1000

					if var_319_31 + var_319_23 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_31 + var_319_23
					end

					if var_319_26.prefab_name ~= "" and arg_316_1.actors_[var_319_26.prefab_name] ~= nil then
						local var_319_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_316_1.actors_[var_319_26.prefab_name].transform, "story_v_out_416191", "416191073", "story_v_out_416191.awb")

						arg_316_1:RecordAudio("416191073", var_319_32)
						arg_316_1:RecordAudio("416191073", var_319_32)
					else
						arg_316_1:AudioAction("play", "voice", "story_v_out_416191", "416191073", "story_v_out_416191.awb")
					end

					arg_316_1:RecordHistoryTalkVoice("story_v_out_416191", "416191073", "story_v_out_416191.awb")
				end

				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_33 = math.max(var_319_24, arg_316_1.talkMaxDuration)

			if var_319_23 <= arg_316_1.time_ and arg_316_1.time_ < var_319_23 + var_319_33 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_23) / var_319_33

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_23 + var_319_33 and arg_316_1.time_ < var_319_23 + var_319_33 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_316_1:InitPlayNodeList()
	end,
	Play416191074 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 416191074
		arg_320_1.duration_ = 7.17

		local var_320_0 = {
			zh = 5.266,
			ja = 7.166
		}
		local var_320_1 = manager.audio:GetLocalizationFlag()

		if var_320_0[var_320_1] ~= nil then
			arg_320_1.duration_ = var_320_0[var_320_1]
		end

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play416191075(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = arg_320_1.actors_["1028"]
			local var_323_1 = 0

			if var_323_1 < arg_320_1.time_ and arg_320_1.time_ <= var_323_1 + arg_323_0 and not isNil(var_323_0) and arg_320_1.var_.actorSpriteComps1028 == nil then
				arg_320_1.var_.actorSpriteComps1028 = var_323_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_323_2 = 0.2

			if var_323_1 <= arg_320_1.time_ and arg_320_1.time_ < var_323_1 + var_323_2 and not isNil(var_323_0) then
				local var_323_3 = (arg_320_1.time_ - var_323_1) / var_323_2

				if arg_320_1.var_.actorSpriteComps1028 then
					for iter_323_0, iter_323_1 in pairs(arg_320_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_323_1 then
							if arg_320_1.isInRecall_ then
								local var_323_4 = Mathf.Lerp(iter_323_1.color.r, arg_320_1.hightColor1.r, var_323_3)
								local var_323_5 = Mathf.Lerp(iter_323_1.color.g, arg_320_1.hightColor1.g, var_323_3)
								local var_323_6 = Mathf.Lerp(iter_323_1.color.b, arg_320_1.hightColor1.b, var_323_3)

								iter_323_1.color = Color.New(var_323_4, var_323_5, var_323_6)
							else
								local var_323_7 = Mathf.Lerp(iter_323_1.color.r, 1, var_323_3)

								iter_323_1.color = Color.New(var_323_7, var_323_7, var_323_7)
							end
						end
					end
				end
			end

			if arg_320_1.time_ >= var_323_1 + var_323_2 and arg_320_1.time_ < var_323_1 + var_323_2 + arg_323_0 and not isNil(var_323_0) and arg_320_1.var_.actorSpriteComps1028 then
				for iter_323_2, iter_323_3 in pairs(arg_320_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_323_3 then
						if arg_320_1.isInRecall_ then
							iter_323_3.color = arg_320_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_323_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_320_1.var_.actorSpriteComps1028 = nil
			end

			local var_323_8 = arg_320_1.actors_["1086"]
			local var_323_9 = 0

			if var_323_9 < arg_320_1.time_ and arg_320_1.time_ <= var_323_9 + arg_323_0 and not isNil(var_323_8) and arg_320_1.var_.actorSpriteComps1086 == nil then
				arg_320_1.var_.actorSpriteComps1086 = var_323_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_323_10 = 0.2

			if var_323_9 <= arg_320_1.time_ and arg_320_1.time_ < var_323_9 + var_323_10 and not isNil(var_323_8) then
				local var_323_11 = (arg_320_1.time_ - var_323_9) / var_323_10

				if arg_320_1.var_.actorSpriteComps1086 then
					for iter_323_4, iter_323_5 in pairs(arg_320_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_323_5 then
							if arg_320_1.isInRecall_ then
								local var_323_12 = Mathf.Lerp(iter_323_5.color.r, arg_320_1.hightColor2.r, var_323_11)
								local var_323_13 = Mathf.Lerp(iter_323_5.color.g, arg_320_1.hightColor2.g, var_323_11)
								local var_323_14 = Mathf.Lerp(iter_323_5.color.b, arg_320_1.hightColor2.b, var_323_11)

								iter_323_5.color = Color.New(var_323_12, var_323_13, var_323_14)
							else
								local var_323_15 = Mathf.Lerp(iter_323_5.color.r, 0.5, var_323_11)

								iter_323_5.color = Color.New(var_323_15, var_323_15, var_323_15)
							end
						end
					end
				end
			end

			if arg_320_1.time_ >= var_323_9 + var_323_10 and arg_320_1.time_ < var_323_9 + var_323_10 + arg_323_0 and not isNil(var_323_8) and arg_320_1.var_.actorSpriteComps1086 then
				for iter_323_6, iter_323_7 in pairs(arg_320_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_323_7 then
						if arg_320_1.isInRecall_ then
							iter_323_7.color = arg_320_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_323_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_320_1.var_.actorSpriteComps1086 = nil
			end

			local var_323_16 = 0
			local var_323_17 = 0.55

			if var_323_16 < arg_320_1.time_ and arg_320_1.time_ <= var_323_16 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, true)

				local var_323_18 = arg_320_1:FormatText(StoryNameCfg[327].name)

				arg_320_1.leftNameTxt_.text = var_323_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_19 = arg_320_1:GetWordFromCfg(416191074)
				local var_323_20 = arg_320_1:FormatText(var_323_19.content)

				arg_320_1.text_.text = var_323_20

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_21 = 22
				local var_323_22 = utf8.len(var_323_20)
				local var_323_23 = var_323_21 <= 0 and var_323_17 or var_323_17 * (var_323_22 / var_323_21)

				if var_323_23 > 0 and var_323_17 < var_323_23 then
					arg_320_1.talkMaxDuration = var_323_23

					if var_323_23 + var_323_16 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_23 + var_323_16
					end
				end

				arg_320_1.text_.text = var_323_20
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191074", "story_v_out_416191.awb") ~= 0 then
					local var_323_24 = manager.audio:GetVoiceLength("story_v_out_416191", "416191074", "story_v_out_416191.awb") / 1000

					if var_323_24 + var_323_16 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_24 + var_323_16
					end

					if var_323_19.prefab_name ~= "" and arg_320_1.actors_[var_323_19.prefab_name] ~= nil then
						local var_323_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_320_1.actors_[var_323_19.prefab_name].transform, "story_v_out_416191", "416191074", "story_v_out_416191.awb")

						arg_320_1:RecordAudio("416191074", var_323_25)
						arg_320_1:RecordAudio("416191074", var_323_25)
					else
						arg_320_1:AudioAction("play", "voice", "story_v_out_416191", "416191074", "story_v_out_416191.awb")
					end

					arg_320_1:RecordHistoryTalkVoice("story_v_out_416191", "416191074", "story_v_out_416191.awb")
				end

				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_26 = math.max(var_323_17, arg_320_1.talkMaxDuration)

			if var_323_16 <= arg_320_1.time_ and arg_320_1.time_ < var_323_16 + var_323_26 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_16) / var_323_26

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_16 + var_323_26 and arg_320_1.time_ < var_323_16 + var_323_26 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play416191075 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 416191075
		arg_324_1.duration_ = 5

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play416191076(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			local var_327_0 = arg_324_1.actors_["1028"]
			local var_327_1 = 0

			if var_327_1 < arg_324_1.time_ and arg_324_1.time_ <= var_327_1 + arg_327_0 and not isNil(var_327_0) and arg_324_1.var_.actorSpriteComps1028 == nil then
				arg_324_1.var_.actorSpriteComps1028 = var_327_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_327_2 = 0.2

			if var_327_1 <= arg_324_1.time_ and arg_324_1.time_ < var_327_1 + var_327_2 and not isNil(var_327_0) then
				local var_327_3 = (arg_324_1.time_ - var_327_1) / var_327_2

				if arg_324_1.var_.actorSpriteComps1028 then
					for iter_327_0, iter_327_1 in pairs(arg_324_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_327_1 then
							if arg_324_1.isInRecall_ then
								local var_327_4 = Mathf.Lerp(iter_327_1.color.r, arg_324_1.hightColor2.r, var_327_3)
								local var_327_5 = Mathf.Lerp(iter_327_1.color.g, arg_324_1.hightColor2.g, var_327_3)
								local var_327_6 = Mathf.Lerp(iter_327_1.color.b, arg_324_1.hightColor2.b, var_327_3)

								iter_327_1.color = Color.New(var_327_4, var_327_5, var_327_6)
							else
								local var_327_7 = Mathf.Lerp(iter_327_1.color.r, 0.5, var_327_3)

								iter_327_1.color = Color.New(var_327_7, var_327_7, var_327_7)
							end
						end
					end
				end
			end

			if arg_324_1.time_ >= var_327_1 + var_327_2 and arg_324_1.time_ < var_327_1 + var_327_2 + arg_327_0 and not isNil(var_327_0) and arg_324_1.var_.actorSpriteComps1028 then
				for iter_327_2, iter_327_3 in pairs(arg_324_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_327_3 then
						if arg_324_1.isInRecall_ then
							iter_327_3.color = arg_324_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_327_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_324_1.var_.actorSpriteComps1028 = nil
			end

			local var_327_8 = arg_324_1.actors_["1028"].transform
			local var_327_9 = 0

			if var_327_9 < arg_324_1.time_ and arg_324_1.time_ <= var_327_9 + arg_327_0 then
				arg_324_1.var_.moveOldPos1028 = var_327_8.localPosition
				var_327_8.localScale = Vector3.New(1, 1, 1)

				arg_324_1:CheckSpriteTmpPos("1028", 7)

				local var_327_10 = var_327_8.childCount

				for iter_327_4 = 0, var_327_10 - 1 do
					local var_327_11 = var_327_8:GetChild(iter_327_4)

					if var_327_11.name == "" or not string.find(var_327_11.name, "split") then
						var_327_11.gameObject:SetActive(true)
					else
						var_327_11.gameObject:SetActive(false)
					end
				end
			end

			local var_327_12 = 0.001

			if var_327_9 <= arg_324_1.time_ and arg_324_1.time_ < var_327_9 + var_327_12 then
				local var_327_13 = (arg_324_1.time_ - var_327_9) / var_327_12
				local var_327_14 = Vector3.New(0, -2000, 0)

				var_327_8.localPosition = Vector3.Lerp(arg_324_1.var_.moveOldPos1028, var_327_14, var_327_13)
			end

			if arg_324_1.time_ >= var_327_9 + var_327_12 and arg_324_1.time_ < var_327_9 + var_327_12 + arg_327_0 then
				var_327_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_327_15 = arg_324_1.actors_["1086"].transform
			local var_327_16 = 0

			if var_327_16 < arg_324_1.time_ and arg_324_1.time_ <= var_327_16 + arg_327_0 then
				arg_324_1.var_.moveOldPos1086 = var_327_15.localPosition
				var_327_15.localScale = Vector3.New(1, 1, 1)

				arg_324_1:CheckSpriteTmpPos("1086", 7)

				local var_327_17 = var_327_15.childCount

				for iter_327_5 = 0, var_327_17 - 1 do
					local var_327_18 = var_327_15:GetChild(iter_327_5)

					if var_327_18.name == "" or not string.find(var_327_18.name, "split") then
						var_327_18.gameObject:SetActive(true)
					else
						var_327_18.gameObject:SetActive(false)
					end
				end
			end

			local var_327_19 = 0.001

			if var_327_16 <= arg_324_1.time_ and arg_324_1.time_ < var_327_16 + var_327_19 then
				local var_327_20 = (arg_324_1.time_ - var_327_16) / var_327_19
				local var_327_21 = Vector3.New(0, -2000, 0)

				var_327_15.localPosition = Vector3.Lerp(arg_324_1.var_.moveOldPos1086, var_327_21, var_327_20)
			end

			if arg_324_1.time_ >= var_327_16 + var_327_19 and arg_324_1.time_ < var_327_16 + var_327_19 + arg_327_0 then
				var_327_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_327_22 = 0
			local var_327_23 = 1.3

			if var_327_22 < arg_324_1.time_ and arg_324_1.time_ <= var_327_22 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, false)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_324_1.iconTrs_.gameObject, false)
				arg_324_1.callingController_:SetSelectedState("normal")

				local var_327_24 = arg_324_1:GetWordFromCfg(416191075)
				local var_327_25 = arg_324_1:FormatText(var_327_24.content)

				arg_324_1.text_.text = var_327_25

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_26 = 52
				local var_327_27 = utf8.len(var_327_25)
				local var_327_28 = var_327_26 <= 0 and var_327_23 or var_327_23 * (var_327_27 / var_327_26)

				if var_327_28 > 0 and var_327_23 < var_327_28 then
					arg_324_1.talkMaxDuration = var_327_28

					if var_327_28 + var_327_22 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_28 + var_327_22
					end
				end

				arg_324_1.text_.text = var_327_25
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)
				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_29 = math.max(var_327_23, arg_324_1.talkMaxDuration)

			if var_327_22 <= arg_324_1.time_ and arg_324_1.time_ < var_327_22 + var_327_29 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_22) / var_327_29

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_22 + var_327_29 and arg_324_1.time_ < var_327_22 + var_327_29 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_324_1:InitPlayNodeList()
	end,
	Play416191076 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 416191076
		arg_328_1.duration_ = 5.4

		local var_328_0 = {
			zh = 4.066,
			ja = 5.4
		}
		local var_328_1 = manager.audio:GetLocalizationFlag()

		if var_328_0[var_328_1] ~= nil then
			arg_328_1.duration_ = var_328_0[var_328_1]
		end

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play416191077(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			local var_331_0 = arg_328_1.actors_["1028"]
			local var_331_1 = 0

			if var_331_1 < arg_328_1.time_ and arg_328_1.time_ <= var_331_1 + arg_331_0 and not isNil(var_331_0) and arg_328_1.var_.actorSpriteComps1028 == nil then
				arg_328_1.var_.actorSpriteComps1028 = var_331_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_331_2 = 0.2

			if var_331_1 <= arg_328_1.time_ and arg_328_1.time_ < var_331_1 + var_331_2 and not isNil(var_331_0) then
				local var_331_3 = (arg_328_1.time_ - var_331_1) / var_331_2

				if arg_328_1.var_.actorSpriteComps1028 then
					for iter_331_0, iter_331_1 in pairs(arg_328_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_331_1 then
							if arg_328_1.isInRecall_ then
								local var_331_4 = Mathf.Lerp(iter_331_1.color.r, arg_328_1.hightColor1.r, var_331_3)
								local var_331_5 = Mathf.Lerp(iter_331_1.color.g, arg_328_1.hightColor1.g, var_331_3)
								local var_331_6 = Mathf.Lerp(iter_331_1.color.b, arg_328_1.hightColor1.b, var_331_3)

								iter_331_1.color = Color.New(var_331_4, var_331_5, var_331_6)
							else
								local var_331_7 = Mathf.Lerp(iter_331_1.color.r, 1, var_331_3)

								iter_331_1.color = Color.New(var_331_7, var_331_7, var_331_7)
							end
						end
					end
				end
			end

			if arg_328_1.time_ >= var_331_1 + var_331_2 and arg_328_1.time_ < var_331_1 + var_331_2 + arg_331_0 and not isNil(var_331_0) and arg_328_1.var_.actorSpriteComps1028 then
				for iter_331_2, iter_331_3 in pairs(arg_328_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_331_3 then
						if arg_328_1.isInRecall_ then
							iter_331_3.color = arg_328_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_331_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_328_1.var_.actorSpriteComps1028 = nil
			end

			local var_331_8 = arg_328_1.actors_["1028"].transform
			local var_331_9 = 0

			if var_331_9 < arg_328_1.time_ and arg_328_1.time_ <= var_331_9 + arg_331_0 then
				arg_328_1.var_.moveOldPos1028 = var_331_8.localPosition
				var_331_8.localScale = Vector3.New(1, 1, 1)

				arg_328_1:CheckSpriteTmpPos("1028", 2)

				local var_331_10 = var_331_8.childCount

				for iter_331_4 = 0, var_331_10 - 1 do
					local var_331_11 = var_331_8:GetChild(iter_331_4)

					if var_331_11.name == "split_6" or not string.find(var_331_11.name, "split") then
						var_331_11.gameObject:SetActive(true)
					else
						var_331_11.gameObject:SetActive(false)
					end
				end
			end

			local var_331_12 = 0.001

			if var_331_9 <= arg_328_1.time_ and arg_328_1.time_ < var_331_9 + var_331_12 then
				local var_331_13 = (arg_328_1.time_ - var_331_9) / var_331_12
				local var_331_14 = Vector3.New(-390, -402.7, -156.1)

				var_331_8.localPosition = Vector3.Lerp(arg_328_1.var_.moveOldPos1028, var_331_14, var_331_13)
			end

			if arg_328_1.time_ >= var_331_9 + var_331_12 and arg_328_1.time_ < var_331_9 + var_331_12 + arg_331_0 then
				var_331_8.localPosition = Vector3.New(-390, -402.7, -156.1)
			end

			local var_331_15 = 0
			local var_331_16 = 0.55

			if var_331_15 < arg_328_1.time_ and arg_328_1.time_ <= var_331_15 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				local var_331_17 = arg_328_1:FormatText(StoryNameCfg[327].name)

				arg_328_1.leftNameTxt_.text = var_331_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, false)
				arg_328_1.callingController_:SetSelectedState("normal")

				local var_331_18 = arg_328_1:GetWordFromCfg(416191076)
				local var_331_19 = arg_328_1:FormatText(var_331_18.content)

				arg_328_1.text_.text = var_331_19

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_20 = 22
				local var_331_21 = utf8.len(var_331_19)
				local var_331_22 = var_331_20 <= 0 and var_331_16 or var_331_16 * (var_331_21 / var_331_20)

				if var_331_22 > 0 and var_331_16 < var_331_22 then
					arg_328_1.talkMaxDuration = var_331_22

					if var_331_22 + var_331_15 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_22 + var_331_15
					end
				end

				arg_328_1.text_.text = var_331_19
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191076", "story_v_out_416191.awb") ~= 0 then
					local var_331_23 = manager.audio:GetVoiceLength("story_v_out_416191", "416191076", "story_v_out_416191.awb") / 1000

					if var_331_23 + var_331_15 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_23 + var_331_15
					end

					if var_331_18.prefab_name ~= "" and arg_328_1.actors_[var_331_18.prefab_name] ~= nil then
						local var_331_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_328_1.actors_[var_331_18.prefab_name].transform, "story_v_out_416191", "416191076", "story_v_out_416191.awb")

						arg_328_1:RecordAudio("416191076", var_331_24)
						arg_328_1:RecordAudio("416191076", var_331_24)
					else
						arg_328_1:AudioAction("play", "voice", "story_v_out_416191", "416191076", "story_v_out_416191.awb")
					end

					arg_328_1:RecordHistoryTalkVoice("story_v_out_416191", "416191076", "story_v_out_416191.awb")
				end

				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_25 = math.max(var_331_16, arg_328_1.talkMaxDuration)

			if var_331_15 <= arg_328_1.time_ and arg_328_1.time_ < var_331_15 + var_331_25 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_15) / var_331_25

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_15 + var_331_25 and arg_328_1.time_ < var_331_15 + var_331_25 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_328_1:InitPlayNodeList()
	end,
	Play416191077 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 416191077
		arg_332_1.duration_ = 8.67

		local var_332_0 = {
			zh = 8.666,
			ja = 5.4
		}
		local var_332_1 = manager.audio:GetLocalizationFlag()

		if var_332_0[var_332_1] ~= nil then
			arg_332_1.duration_ = var_332_0[var_332_1]
		end

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play416191078(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			local var_335_0 = arg_332_1.actors_["1086"]
			local var_335_1 = 0

			if var_335_1 < arg_332_1.time_ and arg_332_1.time_ <= var_335_1 + arg_335_0 and not isNil(var_335_0) and arg_332_1.var_.actorSpriteComps1086 == nil then
				arg_332_1.var_.actorSpriteComps1086 = var_335_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_335_2 = 0.2

			if var_335_1 <= arg_332_1.time_ and arg_332_1.time_ < var_335_1 + var_335_2 and not isNil(var_335_0) then
				local var_335_3 = (arg_332_1.time_ - var_335_1) / var_335_2

				if arg_332_1.var_.actorSpriteComps1086 then
					for iter_335_0, iter_335_1 in pairs(arg_332_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_335_1 then
							if arg_332_1.isInRecall_ then
								local var_335_4 = Mathf.Lerp(iter_335_1.color.r, arg_332_1.hightColor1.r, var_335_3)
								local var_335_5 = Mathf.Lerp(iter_335_1.color.g, arg_332_1.hightColor1.g, var_335_3)
								local var_335_6 = Mathf.Lerp(iter_335_1.color.b, arg_332_1.hightColor1.b, var_335_3)

								iter_335_1.color = Color.New(var_335_4, var_335_5, var_335_6)
							else
								local var_335_7 = Mathf.Lerp(iter_335_1.color.r, 1, var_335_3)

								iter_335_1.color = Color.New(var_335_7, var_335_7, var_335_7)
							end
						end
					end
				end
			end

			if arg_332_1.time_ >= var_335_1 + var_335_2 and arg_332_1.time_ < var_335_1 + var_335_2 + arg_335_0 and not isNil(var_335_0) and arg_332_1.var_.actorSpriteComps1086 then
				for iter_335_2, iter_335_3 in pairs(arg_332_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_335_3 then
						if arg_332_1.isInRecall_ then
							iter_335_3.color = arg_332_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_335_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_332_1.var_.actorSpriteComps1086 = nil
			end

			local var_335_8 = arg_332_1.actors_["1028"]
			local var_335_9 = 0

			if var_335_9 < arg_332_1.time_ and arg_332_1.time_ <= var_335_9 + arg_335_0 and not isNil(var_335_8) and arg_332_1.var_.actorSpriteComps1028 == nil then
				arg_332_1.var_.actorSpriteComps1028 = var_335_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_335_10 = 0.2

			if var_335_9 <= arg_332_1.time_ and arg_332_1.time_ < var_335_9 + var_335_10 and not isNil(var_335_8) then
				local var_335_11 = (arg_332_1.time_ - var_335_9) / var_335_10

				if arg_332_1.var_.actorSpriteComps1028 then
					for iter_335_4, iter_335_5 in pairs(arg_332_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_335_5 then
							if arg_332_1.isInRecall_ then
								local var_335_12 = Mathf.Lerp(iter_335_5.color.r, arg_332_1.hightColor2.r, var_335_11)
								local var_335_13 = Mathf.Lerp(iter_335_5.color.g, arg_332_1.hightColor2.g, var_335_11)
								local var_335_14 = Mathf.Lerp(iter_335_5.color.b, arg_332_1.hightColor2.b, var_335_11)

								iter_335_5.color = Color.New(var_335_12, var_335_13, var_335_14)
							else
								local var_335_15 = Mathf.Lerp(iter_335_5.color.r, 0.5, var_335_11)

								iter_335_5.color = Color.New(var_335_15, var_335_15, var_335_15)
							end
						end
					end
				end
			end

			if arg_332_1.time_ >= var_335_9 + var_335_10 and arg_332_1.time_ < var_335_9 + var_335_10 + arg_335_0 and not isNil(var_335_8) and arg_332_1.var_.actorSpriteComps1028 then
				for iter_335_6, iter_335_7 in pairs(arg_332_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_335_7 then
						if arg_332_1.isInRecall_ then
							iter_335_7.color = arg_332_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_335_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_332_1.var_.actorSpriteComps1028 = nil
			end

			local var_335_16 = arg_332_1.actors_["1086"].transform
			local var_335_17 = 0

			if var_335_17 < arg_332_1.time_ and arg_332_1.time_ <= var_335_17 + arg_335_0 then
				arg_332_1.var_.moveOldPos1086 = var_335_16.localPosition
				var_335_16.localScale = Vector3.New(1, 1, 1)

				arg_332_1:CheckSpriteTmpPos("1086", 4)

				local var_335_18 = var_335_16.childCount

				for iter_335_8 = 0, var_335_18 - 1 do
					local var_335_19 = var_335_16:GetChild(iter_335_8)

					if var_335_19.name == "split_1" or not string.find(var_335_19.name, "split") then
						var_335_19.gameObject:SetActive(true)
					else
						var_335_19.gameObject:SetActive(false)
					end
				end
			end

			local var_335_20 = 0.001

			if var_335_17 <= arg_332_1.time_ and arg_332_1.time_ < var_335_17 + var_335_20 then
				local var_335_21 = (arg_332_1.time_ - var_335_17) / var_335_20
				local var_335_22 = Vector3.New(390, -404.2, -237.9)

				var_335_16.localPosition = Vector3.Lerp(arg_332_1.var_.moveOldPos1086, var_335_22, var_335_21)
			end

			if arg_332_1.time_ >= var_335_17 + var_335_20 and arg_332_1.time_ < var_335_17 + var_335_20 + arg_335_0 then
				var_335_16.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_335_23 = 0
			local var_335_24 = 0.65

			if var_335_23 < arg_332_1.time_ and arg_332_1.time_ <= var_335_23 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, true)

				local var_335_25 = arg_332_1:FormatText(StoryNameCfg[1080].name)

				arg_332_1.leftNameTxt_.text = var_335_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_332_1.leftNameTxt_.transform)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1.leftNameTxt_.text)
				SetActive(arg_332_1.iconTrs_.gameObject, false)
				arg_332_1.callingController_:SetSelectedState("normal")

				local var_335_26 = arg_332_1:GetWordFromCfg(416191077)
				local var_335_27 = arg_332_1:FormatText(var_335_26.content)

				arg_332_1.text_.text = var_335_27

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_28 = 26
				local var_335_29 = utf8.len(var_335_27)
				local var_335_30 = var_335_28 <= 0 and var_335_24 or var_335_24 * (var_335_29 / var_335_28)

				if var_335_30 > 0 and var_335_24 < var_335_30 then
					arg_332_1.talkMaxDuration = var_335_30

					if var_335_30 + var_335_23 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_30 + var_335_23
					end
				end

				arg_332_1.text_.text = var_335_27
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191077", "story_v_out_416191.awb") ~= 0 then
					local var_335_31 = manager.audio:GetVoiceLength("story_v_out_416191", "416191077", "story_v_out_416191.awb") / 1000

					if var_335_31 + var_335_23 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_31 + var_335_23
					end

					if var_335_26.prefab_name ~= "" and arg_332_1.actors_[var_335_26.prefab_name] ~= nil then
						local var_335_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_332_1.actors_[var_335_26.prefab_name].transform, "story_v_out_416191", "416191077", "story_v_out_416191.awb")

						arg_332_1:RecordAudio("416191077", var_335_32)
						arg_332_1:RecordAudio("416191077", var_335_32)
					else
						arg_332_1:AudioAction("play", "voice", "story_v_out_416191", "416191077", "story_v_out_416191.awb")
					end

					arg_332_1:RecordHistoryTalkVoice("story_v_out_416191", "416191077", "story_v_out_416191.awb")
				end

				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_33 = math.max(var_335_24, arg_332_1.talkMaxDuration)

			if var_335_23 <= arg_332_1.time_ and arg_332_1.time_ < var_335_23 + var_335_33 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_23) / var_335_33

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_23 + var_335_33 and arg_332_1.time_ < var_335_23 + var_335_33 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_332_1:InitPlayNodeList()
	end,
	Play416191078 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 416191078
		arg_336_1.duration_ = 8.6

		local var_336_0 = {
			zh = 4.266,
			ja = 8.6
		}
		local var_336_1 = manager.audio:GetLocalizationFlag()

		if var_336_0[var_336_1] ~= nil then
			arg_336_1.duration_ = var_336_0[var_336_1]
		end

		SetActive(arg_336_1.tipsGo_, false)

		function arg_336_1.onSingleLineFinish_()
			arg_336_1.onSingleLineUpdate_ = nil
			arg_336_1.onSingleLineFinish_ = nil
			arg_336_1.state_ = "waiting"
		end

		function arg_336_1.playNext_(arg_338_0)
			if arg_338_0 == 1 then
				arg_336_0:Play416191079(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			local var_339_0 = 0
			local var_339_1 = 0.4

			if var_339_0 < arg_336_1.time_ and arg_336_1.time_ <= var_339_0 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				local var_339_2 = arg_336_1:FormatText(StoryNameCfg[1080].name)

				arg_336_1.leftNameTxt_.text = var_339_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, false)
				arg_336_1.callingController_:SetSelectedState("normal")

				local var_339_3 = arg_336_1:GetWordFromCfg(416191078)
				local var_339_4 = arg_336_1:FormatText(var_339_3.content)

				arg_336_1.text_.text = var_339_4

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_5 = 16
				local var_339_6 = utf8.len(var_339_4)
				local var_339_7 = var_339_5 <= 0 and var_339_1 or var_339_1 * (var_339_6 / var_339_5)

				if var_339_7 > 0 and var_339_1 < var_339_7 then
					arg_336_1.talkMaxDuration = var_339_7

					if var_339_7 + var_339_0 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_7 + var_339_0
					end
				end

				arg_336_1.text_.text = var_339_4
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191078", "story_v_out_416191.awb") ~= 0 then
					local var_339_8 = manager.audio:GetVoiceLength("story_v_out_416191", "416191078", "story_v_out_416191.awb") / 1000

					if var_339_8 + var_339_0 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_8 + var_339_0
					end

					if var_339_3.prefab_name ~= "" and arg_336_1.actors_[var_339_3.prefab_name] ~= nil then
						local var_339_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_336_1.actors_[var_339_3.prefab_name].transform, "story_v_out_416191", "416191078", "story_v_out_416191.awb")

						arg_336_1:RecordAudio("416191078", var_339_9)
						arg_336_1:RecordAudio("416191078", var_339_9)
					else
						arg_336_1:AudioAction("play", "voice", "story_v_out_416191", "416191078", "story_v_out_416191.awb")
					end

					arg_336_1:RecordHistoryTalkVoice("story_v_out_416191", "416191078", "story_v_out_416191.awb")
				end

				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_10 = math.max(var_339_1, arg_336_1.talkMaxDuration)

			if var_339_0 <= arg_336_1.time_ and arg_336_1.time_ < var_339_0 + var_339_10 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_0) / var_339_10

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_0 + var_339_10 and arg_336_1.time_ < var_339_0 + var_339_10 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {}

		arg_336_1:InitPlayNodeList()
	end,
	Play416191079 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 416191079
		arg_340_1.duration_ = 5.2

		local var_340_0 = {
			zh = 4.833,
			ja = 5.2
		}
		local var_340_1 = manager.audio:GetLocalizationFlag()

		if var_340_0[var_340_1] ~= nil then
			arg_340_1.duration_ = var_340_0[var_340_1]
		end

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play416191080(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			local var_343_0 = arg_340_1.actors_["1028"]
			local var_343_1 = 0

			if var_343_1 < arg_340_1.time_ and arg_340_1.time_ <= var_343_1 + arg_343_0 and not isNil(var_343_0) and arg_340_1.var_.actorSpriteComps1028 == nil then
				arg_340_1.var_.actorSpriteComps1028 = var_343_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_343_2 = 0.2

			if var_343_1 <= arg_340_1.time_ and arg_340_1.time_ < var_343_1 + var_343_2 and not isNil(var_343_0) then
				local var_343_3 = (arg_340_1.time_ - var_343_1) / var_343_2

				if arg_340_1.var_.actorSpriteComps1028 then
					for iter_343_0, iter_343_1 in pairs(arg_340_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_343_1 then
							if arg_340_1.isInRecall_ then
								local var_343_4 = Mathf.Lerp(iter_343_1.color.r, arg_340_1.hightColor1.r, var_343_3)
								local var_343_5 = Mathf.Lerp(iter_343_1.color.g, arg_340_1.hightColor1.g, var_343_3)
								local var_343_6 = Mathf.Lerp(iter_343_1.color.b, arg_340_1.hightColor1.b, var_343_3)

								iter_343_1.color = Color.New(var_343_4, var_343_5, var_343_6)
							else
								local var_343_7 = Mathf.Lerp(iter_343_1.color.r, 1, var_343_3)

								iter_343_1.color = Color.New(var_343_7, var_343_7, var_343_7)
							end
						end
					end
				end
			end

			if arg_340_1.time_ >= var_343_1 + var_343_2 and arg_340_1.time_ < var_343_1 + var_343_2 + arg_343_0 and not isNil(var_343_0) and arg_340_1.var_.actorSpriteComps1028 then
				for iter_343_2, iter_343_3 in pairs(arg_340_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_343_3 then
						if arg_340_1.isInRecall_ then
							iter_343_3.color = arg_340_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_343_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_340_1.var_.actorSpriteComps1028 = nil
			end

			local var_343_8 = arg_340_1.actors_["1086"]
			local var_343_9 = 0

			if var_343_9 < arg_340_1.time_ and arg_340_1.time_ <= var_343_9 + arg_343_0 and not isNil(var_343_8) and arg_340_1.var_.actorSpriteComps1086 == nil then
				arg_340_1.var_.actorSpriteComps1086 = var_343_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_343_10 = 0.2

			if var_343_9 <= arg_340_1.time_ and arg_340_1.time_ < var_343_9 + var_343_10 and not isNil(var_343_8) then
				local var_343_11 = (arg_340_1.time_ - var_343_9) / var_343_10

				if arg_340_1.var_.actorSpriteComps1086 then
					for iter_343_4, iter_343_5 in pairs(arg_340_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_343_5 then
							if arg_340_1.isInRecall_ then
								local var_343_12 = Mathf.Lerp(iter_343_5.color.r, arg_340_1.hightColor2.r, var_343_11)
								local var_343_13 = Mathf.Lerp(iter_343_5.color.g, arg_340_1.hightColor2.g, var_343_11)
								local var_343_14 = Mathf.Lerp(iter_343_5.color.b, arg_340_1.hightColor2.b, var_343_11)

								iter_343_5.color = Color.New(var_343_12, var_343_13, var_343_14)
							else
								local var_343_15 = Mathf.Lerp(iter_343_5.color.r, 0.5, var_343_11)

								iter_343_5.color = Color.New(var_343_15, var_343_15, var_343_15)
							end
						end
					end
				end
			end

			if arg_340_1.time_ >= var_343_9 + var_343_10 and arg_340_1.time_ < var_343_9 + var_343_10 + arg_343_0 and not isNil(var_343_8) and arg_340_1.var_.actorSpriteComps1086 then
				for iter_343_6, iter_343_7 in pairs(arg_340_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_343_7 then
						if arg_340_1.isInRecall_ then
							iter_343_7.color = arg_340_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_343_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_340_1.var_.actorSpriteComps1086 = nil
			end

			local var_343_16 = arg_340_1.actors_["1028"].transform
			local var_343_17 = 0

			if var_343_17 < arg_340_1.time_ and arg_340_1.time_ <= var_343_17 + arg_343_0 then
				arg_340_1.var_.moveOldPos1028 = var_343_16.localPosition
				var_343_16.localScale = Vector3.New(1, 1, 1)

				arg_340_1:CheckSpriteTmpPos("1028", 2)

				local var_343_18 = var_343_16.childCount

				for iter_343_8 = 0, var_343_18 - 1 do
					local var_343_19 = var_343_16:GetChild(iter_343_8)

					if var_343_19.name == "split_7" or not string.find(var_343_19.name, "split") then
						var_343_19.gameObject:SetActive(true)
					else
						var_343_19.gameObject:SetActive(false)
					end
				end
			end

			local var_343_20 = 0.001

			if var_343_17 <= arg_340_1.time_ and arg_340_1.time_ < var_343_17 + var_343_20 then
				local var_343_21 = (arg_340_1.time_ - var_343_17) / var_343_20
				local var_343_22 = Vector3.New(-390, -402.7, -156.1)

				var_343_16.localPosition = Vector3.Lerp(arg_340_1.var_.moveOldPos1028, var_343_22, var_343_21)
			end

			if arg_340_1.time_ >= var_343_17 + var_343_20 and arg_340_1.time_ < var_343_17 + var_343_20 + arg_343_0 then
				var_343_16.localPosition = Vector3.New(-390, -402.7, -156.1)
			end

			local var_343_23 = 0
			local var_343_24 = 0.55

			if var_343_23 < arg_340_1.time_ and arg_340_1.time_ <= var_343_23 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, true)

				local var_343_25 = arg_340_1:FormatText(StoryNameCfg[327].name)

				arg_340_1.leftNameTxt_.text = var_343_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_340_1.leftNameTxt_.transform)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1.leftNameTxt_.text)
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_26 = arg_340_1:GetWordFromCfg(416191079)
				local var_343_27 = arg_340_1:FormatText(var_343_26.content)

				arg_340_1.text_.text = var_343_27

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_28 = 22
				local var_343_29 = utf8.len(var_343_27)
				local var_343_30 = var_343_28 <= 0 and var_343_24 or var_343_24 * (var_343_29 / var_343_28)

				if var_343_30 > 0 and var_343_24 < var_343_30 then
					arg_340_1.talkMaxDuration = var_343_30

					if var_343_30 + var_343_23 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_30 + var_343_23
					end
				end

				arg_340_1.text_.text = var_343_27
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191079", "story_v_out_416191.awb") ~= 0 then
					local var_343_31 = manager.audio:GetVoiceLength("story_v_out_416191", "416191079", "story_v_out_416191.awb") / 1000

					if var_343_31 + var_343_23 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_31 + var_343_23
					end

					if var_343_26.prefab_name ~= "" and arg_340_1.actors_[var_343_26.prefab_name] ~= nil then
						local var_343_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_340_1.actors_[var_343_26.prefab_name].transform, "story_v_out_416191", "416191079", "story_v_out_416191.awb")

						arg_340_1:RecordAudio("416191079", var_343_32)
						arg_340_1:RecordAudio("416191079", var_343_32)
					else
						arg_340_1:AudioAction("play", "voice", "story_v_out_416191", "416191079", "story_v_out_416191.awb")
					end

					arg_340_1:RecordHistoryTalkVoice("story_v_out_416191", "416191079", "story_v_out_416191.awb")
				end

				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_33 = math.max(var_343_24, arg_340_1.talkMaxDuration)

			if var_343_23 <= arg_340_1.time_ and arg_340_1.time_ < var_343_23 + var_343_33 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_23) / var_343_33

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_23 + var_343_33 and arg_340_1.time_ < var_343_23 + var_343_33 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_340_1:InitPlayNodeList()
	end,
	Play416191080 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 416191080
		arg_344_1.duration_ = 10.67

		local var_344_0 = {
			zh = 4.833,
			ja = 10.666
		}
		local var_344_1 = manager.audio:GetLocalizationFlag()

		if var_344_0[var_344_1] ~= nil then
			arg_344_1.duration_ = var_344_0[var_344_1]
		end

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play416191081(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			local var_347_0 = arg_344_1.actors_["1086"]
			local var_347_1 = 0

			if var_347_1 < arg_344_1.time_ and arg_344_1.time_ <= var_347_1 + arg_347_0 and not isNil(var_347_0) and arg_344_1.var_.actorSpriteComps1086 == nil then
				arg_344_1.var_.actorSpriteComps1086 = var_347_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_347_2 = 0.2

			if var_347_1 <= arg_344_1.time_ and arg_344_1.time_ < var_347_1 + var_347_2 and not isNil(var_347_0) then
				local var_347_3 = (arg_344_1.time_ - var_347_1) / var_347_2

				if arg_344_1.var_.actorSpriteComps1086 then
					for iter_347_0, iter_347_1 in pairs(arg_344_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_347_1 then
							if arg_344_1.isInRecall_ then
								local var_347_4 = Mathf.Lerp(iter_347_1.color.r, arg_344_1.hightColor1.r, var_347_3)
								local var_347_5 = Mathf.Lerp(iter_347_1.color.g, arg_344_1.hightColor1.g, var_347_3)
								local var_347_6 = Mathf.Lerp(iter_347_1.color.b, arg_344_1.hightColor1.b, var_347_3)

								iter_347_1.color = Color.New(var_347_4, var_347_5, var_347_6)
							else
								local var_347_7 = Mathf.Lerp(iter_347_1.color.r, 1, var_347_3)

								iter_347_1.color = Color.New(var_347_7, var_347_7, var_347_7)
							end
						end
					end
				end
			end

			if arg_344_1.time_ >= var_347_1 + var_347_2 and arg_344_1.time_ < var_347_1 + var_347_2 + arg_347_0 and not isNil(var_347_0) and arg_344_1.var_.actorSpriteComps1086 then
				for iter_347_2, iter_347_3 in pairs(arg_344_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_347_3 then
						if arg_344_1.isInRecall_ then
							iter_347_3.color = arg_344_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_347_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_344_1.var_.actorSpriteComps1086 = nil
			end

			local var_347_8 = arg_344_1.actors_["1028"]
			local var_347_9 = 0

			if var_347_9 < arg_344_1.time_ and arg_344_1.time_ <= var_347_9 + arg_347_0 and not isNil(var_347_8) and arg_344_1.var_.actorSpriteComps1028 == nil then
				arg_344_1.var_.actorSpriteComps1028 = var_347_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_347_10 = 0.2

			if var_347_9 <= arg_344_1.time_ and arg_344_1.time_ < var_347_9 + var_347_10 and not isNil(var_347_8) then
				local var_347_11 = (arg_344_1.time_ - var_347_9) / var_347_10

				if arg_344_1.var_.actorSpriteComps1028 then
					for iter_347_4, iter_347_5 in pairs(arg_344_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_347_5 then
							if arg_344_1.isInRecall_ then
								local var_347_12 = Mathf.Lerp(iter_347_5.color.r, arg_344_1.hightColor2.r, var_347_11)
								local var_347_13 = Mathf.Lerp(iter_347_5.color.g, arg_344_1.hightColor2.g, var_347_11)
								local var_347_14 = Mathf.Lerp(iter_347_5.color.b, arg_344_1.hightColor2.b, var_347_11)

								iter_347_5.color = Color.New(var_347_12, var_347_13, var_347_14)
							else
								local var_347_15 = Mathf.Lerp(iter_347_5.color.r, 0.5, var_347_11)

								iter_347_5.color = Color.New(var_347_15, var_347_15, var_347_15)
							end
						end
					end
				end
			end

			if arg_344_1.time_ >= var_347_9 + var_347_10 and arg_344_1.time_ < var_347_9 + var_347_10 + arg_347_0 and not isNil(var_347_8) and arg_344_1.var_.actorSpriteComps1028 then
				for iter_347_6, iter_347_7 in pairs(arg_344_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_347_7 then
						if arg_344_1.isInRecall_ then
							iter_347_7.color = arg_344_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_347_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_344_1.var_.actorSpriteComps1028 = nil
			end

			local var_347_16 = 0
			local var_347_17 = 0.5

			if var_347_16 < arg_344_1.time_ and arg_344_1.time_ <= var_347_16 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, true)

				local var_347_18 = arg_344_1:FormatText(StoryNameCfg[1080].name)

				arg_344_1.leftNameTxt_.text = var_347_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_19 = arg_344_1:GetWordFromCfg(416191080)
				local var_347_20 = arg_344_1:FormatText(var_347_19.content)

				arg_344_1.text_.text = var_347_20

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_21 = 20
				local var_347_22 = utf8.len(var_347_20)
				local var_347_23 = var_347_21 <= 0 and var_347_17 or var_347_17 * (var_347_22 / var_347_21)

				if var_347_23 > 0 and var_347_17 < var_347_23 then
					arg_344_1.talkMaxDuration = var_347_23

					if var_347_23 + var_347_16 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_23 + var_347_16
					end
				end

				arg_344_1.text_.text = var_347_20
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191080", "story_v_out_416191.awb") ~= 0 then
					local var_347_24 = manager.audio:GetVoiceLength("story_v_out_416191", "416191080", "story_v_out_416191.awb") / 1000

					if var_347_24 + var_347_16 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_24 + var_347_16
					end

					if var_347_19.prefab_name ~= "" and arg_344_1.actors_[var_347_19.prefab_name] ~= nil then
						local var_347_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_344_1.actors_[var_347_19.prefab_name].transform, "story_v_out_416191", "416191080", "story_v_out_416191.awb")

						arg_344_1:RecordAudio("416191080", var_347_25)
						arg_344_1:RecordAudio("416191080", var_347_25)
					else
						arg_344_1:AudioAction("play", "voice", "story_v_out_416191", "416191080", "story_v_out_416191.awb")
					end

					arg_344_1:RecordHistoryTalkVoice("story_v_out_416191", "416191080", "story_v_out_416191.awb")
				end

				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_26 = math.max(var_347_17, arg_344_1.talkMaxDuration)

			if var_347_16 <= arg_344_1.time_ and arg_344_1.time_ < var_347_16 + var_347_26 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_16) / var_347_26

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_16 + var_347_26 and arg_344_1.time_ < var_347_16 + var_347_26 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {}

		arg_344_1:InitPlayNodeList()
	end,
	Play416191081 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 416191081
		arg_348_1.duration_ = 8.7

		local var_348_0 = {
			zh = 6,
			ja = 8.7
		}
		local var_348_1 = manager.audio:GetLocalizationFlag()

		if var_348_0[var_348_1] ~= nil then
			arg_348_1.duration_ = var_348_0[var_348_1]
		end

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play416191082(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			local var_351_0 = arg_348_1.actors_["1028"]
			local var_351_1 = 0

			if var_351_1 < arg_348_1.time_ and arg_348_1.time_ <= var_351_1 + arg_351_0 and not isNil(var_351_0) and arg_348_1.var_.actorSpriteComps1028 == nil then
				arg_348_1.var_.actorSpriteComps1028 = var_351_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_351_2 = 0.2

			if var_351_1 <= arg_348_1.time_ and arg_348_1.time_ < var_351_1 + var_351_2 and not isNil(var_351_0) then
				local var_351_3 = (arg_348_1.time_ - var_351_1) / var_351_2

				if arg_348_1.var_.actorSpriteComps1028 then
					for iter_351_0, iter_351_1 in pairs(arg_348_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_351_1 then
							if arg_348_1.isInRecall_ then
								local var_351_4 = Mathf.Lerp(iter_351_1.color.r, arg_348_1.hightColor1.r, var_351_3)
								local var_351_5 = Mathf.Lerp(iter_351_1.color.g, arg_348_1.hightColor1.g, var_351_3)
								local var_351_6 = Mathf.Lerp(iter_351_1.color.b, arg_348_1.hightColor1.b, var_351_3)

								iter_351_1.color = Color.New(var_351_4, var_351_5, var_351_6)
							else
								local var_351_7 = Mathf.Lerp(iter_351_1.color.r, 1, var_351_3)

								iter_351_1.color = Color.New(var_351_7, var_351_7, var_351_7)
							end
						end
					end
				end
			end

			if arg_348_1.time_ >= var_351_1 + var_351_2 and arg_348_1.time_ < var_351_1 + var_351_2 + arg_351_0 and not isNil(var_351_0) and arg_348_1.var_.actorSpriteComps1028 then
				for iter_351_2, iter_351_3 in pairs(arg_348_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_351_3 then
						if arg_348_1.isInRecall_ then
							iter_351_3.color = arg_348_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_351_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_348_1.var_.actorSpriteComps1028 = nil
			end

			local var_351_8 = arg_348_1.actors_["1086"]
			local var_351_9 = 0

			if var_351_9 < arg_348_1.time_ and arg_348_1.time_ <= var_351_9 + arg_351_0 and not isNil(var_351_8) and arg_348_1.var_.actorSpriteComps1086 == nil then
				arg_348_1.var_.actorSpriteComps1086 = var_351_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_351_10 = 0.2

			if var_351_9 <= arg_348_1.time_ and arg_348_1.time_ < var_351_9 + var_351_10 and not isNil(var_351_8) then
				local var_351_11 = (arg_348_1.time_ - var_351_9) / var_351_10

				if arg_348_1.var_.actorSpriteComps1086 then
					for iter_351_4, iter_351_5 in pairs(arg_348_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_351_5 then
							if arg_348_1.isInRecall_ then
								local var_351_12 = Mathf.Lerp(iter_351_5.color.r, arg_348_1.hightColor2.r, var_351_11)
								local var_351_13 = Mathf.Lerp(iter_351_5.color.g, arg_348_1.hightColor2.g, var_351_11)
								local var_351_14 = Mathf.Lerp(iter_351_5.color.b, arg_348_1.hightColor2.b, var_351_11)

								iter_351_5.color = Color.New(var_351_12, var_351_13, var_351_14)
							else
								local var_351_15 = Mathf.Lerp(iter_351_5.color.r, 0.5, var_351_11)

								iter_351_5.color = Color.New(var_351_15, var_351_15, var_351_15)
							end
						end
					end
				end
			end

			if arg_348_1.time_ >= var_351_9 + var_351_10 and arg_348_1.time_ < var_351_9 + var_351_10 + arg_351_0 and not isNil(var_351_8) and arg_348_1.var_.actorSpriteComps1086 then
				for iter_351_6, iter_351_7 in pairs(arg_348_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_351_7 then
						if arg_348_1.isInRecall_ then
							iter_351_7.color = arg_348_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_351_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_348_1.var_.actorSpriteComps1086 = nil
			end

			local var_351_16 = arg_348_1.actors_["1028"].transform
			local var_351_17 = 0

			if var_351_17 < arg_348_1.time_ and arg_348_1.time_ <= var_351_17 + arg_351_0 then
				arg_348_1.var_.moveOldPos1028 = var_351_16.localPosition
				var_351_16.localScale = Vector3.New(1, 1, 1)

				arg_348_1:CheckSpriteTmpPos("1028", 2)

				local var_351_18 = var_351_16.childCount

				for iter_351_8 = 0, var_351_18 - 1 do
					local var_351_19 = var_351_16:GetChild(iter_351_8)

					if var_351_19.name == "" or not string.find(var_351_19.name, "split") then
						var_351_19.gameObject:SetActive(true)
					else
						var_351_19.gameObject:SetActive(false)
					end
				end
			end

			local var_351_20 = 0.001

			if var_351_17 <= arg_348_1.time_ and arg_348_1.time_ < var_351_17 + var_351_20 then
				local var_351_21 = (arg_348_1.time_ - var_351_17) / var_351_20
				local var_351_22 = Vector3.New(-390, -402.7, -156.1)

				var_351_16.localPosition = Vector3.Lerp(arg_348_1.var_.moveOldPos1028, var_351_22, var_351_21)
			end

			if arg_348_1.time_ >= var_351_17 + var_351_20 and arg_348_1.time_ < var_351_17 + var_351_20 + arg_351_0 then
				var_351_16.localPosition = Vector3.New(-390, -402.7, -156.1)
			end

			local var_351_23 = 0
			local var_351_24 = 0.45

			if var_351_23 < arg_348_1.time_ and arg_348_1.time_ <= var_351_23 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, true)

				local var_351_25 = arg_348_1:FormatText(StoryNameCfg[327].name)

				arg_348_1.leftNameTxt_.text = var_351_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_348_1.leftNameTxt_.transform)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1.leftNameTxt_.text)
				SetActive(arg_348_1.iconTrs_.gameObject, false)
				arg_348_1.callingController_:SetSelectedState("normal")

				local var_351_26 = arg_348_1:GetWordFromCfg(416191081)
				local var_351_27 = arg_348_1:FormatText(var_351_26.content)

				arg_348_1.text_.text = var_351_27

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_28 = 18
				local var_351_29 = utf8.len(var_351_27)
				local var_351_30 = var_351_28 <= 0 and var_351_24 or var_351_24 * (var_351_29 / var_351_28)

				if var_351_30 > 0 and var_351_24 < var_351_30 then
					arg_348_1.talkMaxDuration = var_351_30

					if var_351_30 + var_351_23 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_30 + var_351_23
					end
				end

				arg_348_1.text_.text = var_351_27
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191081", "story_v_out_416191.awb") ~= 0 then
					local var_351_31 = manager.audio:GetVoiceLength("story_v_out_416191", "416191081", "story_v_out_416191.awb") / 1000

					if var_351_31 + var_351_23 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_31 + var_351_23
					end

					if var_351_26.prefab_name ~= "" and arg_348_1.actors_[var_351_26.prefab_name] ~= nil then
						local var_351_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_348_1.actors_[var_351_26.prefab_name].transform, "story_v_out_416191", "416191081", "story_v_out_416191.awb")

						arg_348_1:RecordAudio("416191081", var_351_32)
						arg_348_1:RecordAudio("416191081", var_351_32)
					else
						arg_348_1:AudioAction("play", "voice", "story_v_out_416191", "416191081", "story_v_out_416191.awb")
					end

					arg_348_1:RecordHistoryTalkVoice("story_v_out_416191", "416191081", "story_v_out_416191.awb")
				end

				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_33 = math.max(var_351_24, arg_348_1.talkMaxDuration)

			if var_351_23 <= arg_348_1.time_ and arg_348_1.time_ < var_351_23 + var_351_33 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_23) / var_351_33

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_23 + var_351_33 and arg_348_1.time_ < var_351_23 + var_351_33 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_348_1:InitPlayNodeList()
	end,
	Play416191082 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 416191082
		arg_352_1.duration_ = 11.07

		local var_352_0 = {
			zh = 11.066,
			ja = 10.566
		}
		local var_352_1 = manager.audio:GetLocalizationFlag()

		if var_352_0[var_352_1] ~= nil then
			arg_352_1.duration_ = var_352_0[var_352_1]
		end

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play416191083(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			local var_355_0 = arg_352_1.actors_["1086"]
			local var_355_1 = 0

			if var_355_1 < arg_352_1.time_ and arg_352_1.time_ <= var_355_1 + arg_355_0 and not isNil(var_355_0) and arg_352_1.var_.actorSpriteComps1086 == nil then
				arg_352_1.var_.actorSpriteComps1086 = var_355_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_355_2 = 0.2

			if var_355_1 <= arg_352_1.time_ and arg_352_1.time_ < var_355_1 + var_355_2 and not isNil(var_355_0) then
				local var_355_3 = (arg_352_1.time_ - var_355_1) / var_355_2

				if arg_352_1.var_.actorSpriteComps1086 then
					for iter_355_0, iter_355_1 in pairs(arg_352_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_355_1 then
							if arg_352_1.isInRecall_ then
								local var_355_4 = Mathf.Lerp(iter_355_1.color.r, arg_352_1.hightColor1.r, var_355_3)
								local var_355_5 = Mathf.Lerp(iter_355_1.color.g, arg_352_1.hightColor1.g, var_355_3)
								local var_355_6 = Mathf.Lerp(iter_355_1.color.b, arg_352_1.hightColor1.b, var_355_3)

								iter_355_1.color = Color.New(var_355_4, var_355_5, var_355_6)
							else
								local var_355_7 = Mathf.Lerp(iter_355_1.color.r, 1, var_355_3)

								iter_355_1.color = Color.New(var_355_7, var_355_7, var_355_7)
							end
						end
					end
				end
			end

			if arg_352_1.time_ >= var_355_1 + var_355_2 and arg_352_1.time_ < var_355_1 + var_355_2 + arg_355_0 and not isNil(var_355_0) and arg_352_1.var_.actorSpriteComps1086 then
				for iter_355_2, iter_355_3 in pairs(arg_352_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_355_3 then
						if arg_352_1.isInRecall_ then
							iter_355_3.color = arg_352_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_355_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_352_1.var_.actorSpriteComps1086 = nil
			end

			local var_355_8 = arg_352_1.actors_["1028"].transform
			local var_355_9 = 0

			if var_355_9 < arg_352_1.time_ and arg_352_1.time_ <= var_355_9 + arg_355_0 then
				arg_352_1.var_.moveOldPos1028 = var_355_8.localPosition
				var_355_8.localScale = Vector3.New(1, 1, 1)

				arg_352_1:CheckSpriteTmpPos("1028", 7)

				local var_355_10 = var_355_8.childCount

				for iter_355_4 = 0, var_355_10 - 1 do
					local var_355_11 = var_355_8:GetChild(iter_355_4)

					if var_355_11.name == "split_2" or not string.find(var_355_11.name, "split") then
						var_355_11.gameObject:SetActive(true)
					else
						var_355_11.gameObject:SetActive(false)
					end
				end
			end

			local var_355_12 = 0.001

			if var_355_9 <= arg_352_1.time_ and arg_352_1.time_ < var_355_9 + var_355_12 then
				local var_355_13 = (arg_352_1.time_ - var_355_9) / var_355_12
				local var_355_14 = Vector3.New(0, -2000, 0)

				var_355_8.localPosition = Vector3.Lerp(arg_352_1.var_.moveOldPos1028, var_355_14, var_355_13)
			end

			if arg_352_1.time_ >= var_355_9 + var_355_12 and arg_352_1.time_ < var_355_9 + var_355_12 + arg_355_0 then
				var_355_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_355_15 = arg_352_1.actors_["1086"].transform
			local var_355_16 = 0

			if var_355_16 < arg_352_1.time_ and arg_352_1.time_ <= var_355_16 + arg_355_0 then
				arg_352_1.var_.moveOldPos1086 = var_355_15.localPosition
				var_355_15.localScale = Vector3.New(1, 1, 1)

				arg_352_1:CheckSpriteTmpPos("1086", 3)

				local var_355_17 = var_355_15.childCount

				for iter_355_5 = 0, var_355_17 - 1 do
					local var_355_18 = var_355_15:GetChild(iter_355_5)

					if var_355_18.name == "split_1" or not string.find(var_355_18.name, "split") then
						var_355_18.gameObject:SetActive(true)
					else
						var_355_18.gameObject:SetActive(false)
					end
				end
			end

			local var_355_19 = 0.001

			if var_355_16 <= arg_352_1.time_ and arg_352_1.time_ < var_355_16 + var_355_19 then
				local var_355_20 = (arg_352_1.time_ - var_355_16) / var_355_19
				local var_355_21 = Vector3.New(0, -404.2, -237.9)

				var_355_15.localPosition = Vector3.Lerp(arg_352_1.var_.moveOldPos1086, var_355_21, var_355_20)
			end

			if arg_352_1.time_ >= var_355_16 + var_355_19 and arg_352_1.time_ < var_355_16 + var_355_19 + arg_355_0 then
				var_355_15.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_355_22 = 0
			local var_355_23 = 0.775

			if var_355_22 < arg_352_1.time_ and arg_352_1.time_ <= var_355_22 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				local var_355_24 = arg_352_1:FormatText(StoryNameCfg[1080].name)

				arg_352_1.leftNameTxt_.text = var_355_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, false)
				arg_352_1.callingController_:SetSelectedState("normal")

				local var_355_25 = arg_352_1:GetWordFromCfg(416191082)
				local var_355_26 = arg_352_1:FormatText(var_355_25.content)

				arg_352_1.text_.text = var_355_26

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_27 = 31
				local var_355_28 = utf8.len(var_355_26)
				local var_355_29 = var_355_27 <= 0 and var_355_23 or var_355_23 * (var_355_28 / var_355_27)

				if var_355_29 > 0 and var_355_23 < var_355_29 then
					arg_352_1.talkMaxDuration = var_355_29

					if var_355_29 + var_355_22 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_29 + var_355_22
					end
				end

				arg_352_1.text_.text = var_355_26
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191082", "story_v_out_416191.awb") ~= 0 then
					local var_355_30 = manager.audio:GetVoiceLength("story_v_out_416191", "416191082", "story_v_out_416191.awb") / 1000

					if var_355_30 + var_355_22 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_30 + var_355_22
					end

					if var_355_25.prefab_name ~= "" and arg_352_1.actors_[var_355_25.prefab_name] ~= nil then
						local var_355_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_352_1.actors_[var_355_25.prefab_name].transform, "story_v_out_416191", "416191082", "story_v_out_416191.awb")

						arg_352_1:RecordAudio("416191082", var_355_31)
						arg_352_1:RecordAudio("416191082", var_355_31)
					else
						arg_352_1:AudioAction("play", "voice", "story_v_out_416191", "416191082", "story_v_out_416191.awb")
					end

					arg_352_1:RecordHistoryTalkVoice("story_v_out_416191", "416191082", "story_v_out_416191.awb")
				end

				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_32 = math.max(var_355_23, arg_352_1.talkMaxDuration)

			if var_355_22 <= arg_352_1.time_ and arg_352_1.time_ < var_355_22 + var_355_32 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_22) / var_355_32

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_22 + var_355_32 and arg_352_1.time_ < var_355_22 + var_355_32 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_352_1:InitPlayNodeList()
	end,
	Play416191083 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 416191083
		arg_356_1.duration_ = 15.03

		local var_356_0 = {
			zh = 11.6,
			ja = 15.033
		}
		local var_356_1 = manager.audio:GetLocalizationFlag()

		if var_356_0[var_356_1] ~= nil then
			arg_356_1.duration_ = var_356_0[var_356_1]
		end

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play416191084(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			local var_359_0 = arg_356_1.actors_["1086"].transform
			local var_359_1 = 0

			if var_359_1 < arg_356_1.time_ and arg_356_1.time_ <= var_359_1 + arg_359_0 then
				arg_356_1.var_.moveOldPos1086 = var_359_0.localPosition
				var_359_0.localScale = Vector3.New(1, 1, 1)

				arg_356_1:CheckSpriteTmpPos("1086", 3)

				local var_359_2 = var_359_0.childCount

				for iter_359_0 = 0, var_359_2 - 1 do
					local var_359_3 = var_359_0:GetChild(iter_359_0)

					if var_359_3.name == "split_6" or not string.find(var_359_3.name, "split") then
						var_359_3.gameObject:SetActive(true)
					else
						var_359_3.gameObject:SetActive(false)
					end
				end
			end

			local var_359_4 = 0.001

			if var_359_1 <= arg_356_1.time_ and arg_356_1.time_ < var_359_1 + var_359_4 then
				local var_359_5 = (arg_356_1.time_ - var_359_1) / var_359_4
				local var_359_6 = Vector3.New(0, -404.2, -237.9)

				var_359_0.localPosition = Vector3.Lerp(arg_356_1.var_.moveOldPos1086, var_359_6, var_359_5)
			end

			if arg_356_1.time_ >= var_359_1 + var_359_4 and arg_356_1.time_ < var_359_1 + var_359_4 + arg_359_0 then
				var_359_0.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_359_7 = 0
			local var_359_8 = 0.9

			if var_359_7 < arg_356_1.time_ and arg_356_1.time_ <= var_359_7 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, true)

				local var_359_9 = arg_356_1:FormatText(StoryNameCfg[1080].name)

				arg_356_1.leftNameTxt_.text = var_359_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_356_1.leftNameTxt_.transform)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1.leftNameTxt_.text)
				SetActive(arg_356_1.iconTrs_.gameObject, false)
				arg_356_1.callingController_:SetSelectedState("normal")

				local var_359_10 = arg_356_1:GetWordFromCfg(416191083)
				local var_359_11 = arg_356_1:FormatText(var_359_10.content)

				arg_356_1.text_.text = var_359_11

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_12 = 37
				local var_359_13 = utf8.len(var_359_11)
				local var_359_14 = var_359_12 <= 0 and var_359_8 or var_359_8 * (var_359_13 / var_359_12)

				if var_359_14 > 0 and var_359_8 < var_359_14 then
					arg_356_1.talkMaxDuration = var_359_14

					if var_359_14 + var_359_7 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_14 + var_359_7
					end
				end

				arg_356_1.text_.text = var_359_11
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191083", "story_v_out_416191.awb") ~= 0 then
					local var_359_15 = manager.audio:GetVoiceLength("story_v_out_416191", "416191083", "story_v_out_416191.awb") / 1000

					if var_359_15 + var_359_7 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_15 + var_359_7
					end

					if var_359_10.prefab_name ~= "" and arg_356_1.actors_[var_359_10.prefab_name] ~= nil then
						local var_359_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_356_1.actors_[var_359_10.prefab_name].transform, "story_v_out_416191", "416191083", "story_v_out_416191.awb")

						arg_356_1:RecordAudio("416191083", var_359_16)
						arg_356_1:RecordAudio("416191083", var_359_16)
					else
						arg_356_1:AudioAction("play", "voice", "story_v_out_416191", "416191083", "story_v_out_416191.awb")
					end

					arg_356_1:RecordHistoryTalkVoice("story_v_out_416191", "416191083", "story_v_out_416191.awb")
				end

				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_17 = math.max(var_359_8, arg_356_1.talkMaxDuration)

			if var_359_7 <= arg_356_1.time_ and arg_356_1.time_ < var_359_7 + var_359_17 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_7) / var_359_17

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_7 + var_359_17 and arg_356_1.time_ < var_359_7 + var_359_17 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_356_1:InitPlayNodeList()
	end,
	Play416191084 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 416191084
		arg_360_1.duration_ = 6.9

		local var_360_0 = {
			zh = 6.9,
			ja = 5.833
		}
		local var_360_1 = manager.audio:GetLocalizationFlag()

		if var_360_0[var_360_1] ~= nil then
			arg_360_1.duration_ = var_360_0[var_360_1]
		end

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play416191085(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			local var_363_0 = 0
			local var_363_1 = 0.475

			if var_363_0 < arg_360_1.time_ and arg_360_1.time_ <= var_363_0 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, true)

				local var_363_2 = arg_360_1:FormatText(StoryNameCfg[1080].name)

				arg_360_1.leftNameTxt_.text = var_363_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_360_1.leftNameTxt_.transform)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1.leftNameTxt_.text)
				SetActive(arg_360_1.iconTrs_.gameObject, false)
				arg_360_1.callingController_:SetSelectedState("normal")

				local var_363_3 = arg_360_1:GetWordFromCfg(416191084)
				local var_363_4 = arg_360_1:FormatText(var_363_3.content)

				arg_360_1.text_.text = var_363_4

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_5 = 19
				local var_363_6 = utf8.len(var_363_4)
				local var_363_7 = var_363_5 <= 0 and var_363_1 or var_363_1 * (var_363_6 / var_363_5)

				if var_363_7 > 0 and var_363_1 < var_363_7 then
					arg_360_1.talkMaxDuration = var_363_7

					if var_363_7 + var_363_0 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_7 + var_363_0
					end
				end

				arg_360_1.text_.text = var_363_4
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191084", "story_v_out_416191.awb") ~= 0 then
					local var_363_8 = manager.audio:GetVoiceLength("story_v_out_416191", "416191084", "story_v_out_416191.awb") / 1000

					if var_363_8 + var_363_0 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_8 + var_363_0
					end

					if var_363_3.prefab_name ~= "" and arg_360_1.actors_[var_363_3.prefab_name] ~= nil then
						local var_363_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_360_1.actors_[var_363_3.prefab_name].transform, "story_v_out_416191", "416191084", "story_v_out_416191.awb")

						arg_360_1:RecordAudio("416191084", var_363_9)
						arg_360_1:RecordAudio("416191084", var_363_9)
					else
						arg_360_1:AudioAction("play", "voice", "story_v_out_416191", "416191084", "story_v_out_416191.awb")
					end

					arg_360_1:RecordHistoryTalkVoice("story_v_out_416191", "416191084", "story_v_out_416191.awb")
				end

				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_10 = math.max(var_363_1, arg_360_1.talkMaxDuration)

			if var_363_0 <= arg_360_1.time_ and arg_360_1.time_ < var_363_0 + var_363_10 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_0) / var_363_10

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_0 + var_363_10 and arg_360_1.time_ < var_363_0 + var_363_10 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {}

		arg_360_1:InitPlayNodeList()
	end,
	Play416191085 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 416191085
		arg_364_1.duration_ = 11.83

		local var_364_0 = {
			zh = 9.233,
			ja = 11.833
		}
		local var_364_1 = manager.audio:GetLocalizationFlag()

		if var_364_0[var_364_1] ~= nil then
			arg_364_1.duration_ = var_364_0[var_364_1]
		end

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play416191086(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			local var_367_0 = arg_364_1.actors_["1086"].transform
			local var_367_1 = 0

			if var_367_1 < arg_364_1.time_ and arg_364_1.time_ <= var_367_1 + arg_367_0 then
				arg_364_1.var_.moveOldPos1086 = var_367_0.localPosition
				var_367_0.localScale = Vector3.New(1, 1, 1)

				arg_364_1:CheckSpriteTmpPos("1086", 3)

				local var_367_2 = var_367_0.childCount

				for iter_367_0 = 0, var_367_2 - 1 do
					local var_367_3 = var_367_0:GetChild(iter_367_0)

					if var_367_3.name == "split_5" or not string.find(var_367_3.name, "split") then
						var_367_3.gameObject:SetActive(true)
					else
						var_367_3.gameObject:SetActive(false)
					end
				end
			end

			local var_367_4 = 0.001

			if var_367_1 <= arg_364_1.time_ and arg_364_1.time_ < var_367_1 + var_367_4 then
				local var_367_5 = (arg_364_1.time_ - var_367_1) / var_367_4
				local var_367_6 = Vector3.New(0, -404.2, -237.9)

				var_367_0.localPosition = Vector3.Lerp(arg_364_1.var_.moveOldPos1086, var_367_6, var_367_5)
			end

			if arg_364_1.time_ >= var_367_1 + var_367_4 and arg_364_1.time_ < var_367_1 + var_367_4 + arg_367_0 then
				var_367_0.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_367_7 = 0
			local var_367_8 = 0.8

			if var_367_7 < arg_364_1.time_ and arg_364_1.time_ <= var_367_7 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				local var_367_9 = arg_364_1:FormatText(StoryNameCfg[1080].name)

				arg_364_1.leftNameTxt_.text = var_367_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, false)
				arg_364_1.callingController_:SetSelectedState("normal")

				local var_367_10 = arg_364_1:GetWordFromCfg(416191085)
				local var_367_11 = arg_364_1:FormatText(var_367_10.content)

				arg_364_1.text_.text = var_367_11

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_12 = 32
				local var_367_13 = utf8.len(var_367_11)
				local var_367_14 = var_367_12 <= 0 and var_367_8 or var_367_8 * (var_367_13 / var_367_12)

				if var_367_14 > 0 and var_367_8 < var_367_14 then
					arg_364_1.talkMaxDuration = var_367_14

					if var_367_14 + var_367_7 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_14 + var_367_7
					end
				end

				arg_364_1.text_.text = var_367_11
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191085", "story_v_out_416191.awb") ~= 0 then
					local var_367_15 = manager.audio:GetVoiceLength("story_v_out_416191", "416191085", "story_v_out_416191.awb") / 1000

					if var_367_15 + var_367_7 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_15 + var_367_7
					end

					if var_367_10.prefab_name ~= "" and arg_364_1.actors_[var_367_10.prefab_name] ~= nil then
						local var_367_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_364_1.actors_[var_367_10.prefab_name].transform, "story_v_out_416191", "416191085", "story_v_out_416191.awb")

						arg_364_1:RecordAudio("416191085", var_367_16)
						arg_364_1:RecordAudio("416191085", var_367_16)
					else
						arg_364_1:AudioAction("play", "voice", "story_v_out_416191", "416191085", "story_v_out_416191.awb")
					end

					arg_364_1:RecordHistoryTalkVoice("story_v_out_416191", "416191085", "story_v_out_416191.awb")
				end

				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_17 = math.max(var_367_8, arg_364_1.talkMaxDuration)

			if var_367_7 <= arg_364_1.time_ and arg_364_1.time_ < var_367_7 + var_367_17 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - var_367_7) / var_367_17

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= var_367_7 + var_367_17 and arg_364_1.time_ < var_367_7 + var_367_17 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_364_1:InitPlayNodeList()
	end,
	Play416191086 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 416191086
		arg_368_1.duration_ = 5

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play416191087(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			local var_371_0 = arg_368_1.actors_["1086"]
			local var_371_1 = 0

			if var_371_1 < arg_368_1.time_ and arg_368_1.time_ <= var_371_1 + arg_371_0 and not isNil(var_371_0) and arg_368_1.var_.actorSpriteComps1086 == nil then
				arg_368_1.var_.actorSpriteComps1086 = var_371_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_371_2 = 0.2

			if var_371_1 <= arg_368_1.time_ and arg_368_1.time_ < var_371_1 + var_371_2 and not isNil(var_371_0) then
				local var_371_3 = (arg_368_1.time_ - var_371_1) / var_371_2

				if arg_368_1.var_.actorSpriteComps1086 then
					for iter_371_0, iter_371_1 in pairs(arg_368_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_371_1 then
							if arg_368_1.isInRecall_ then
								local var_371_4 = Mathf.Lerp(iter_371_1.color.r, arg_368_1.hightColor2.r, var_371_3)
								local var_371_5 = Mathf.Lerp(iter_371_1.color.g, arg_368_1.hightColor2.g, var_371_3)
								local var_371_6 = Mathf.Lerp(iter_371_1.color.b, arg_368_1.hightColor2.b, var_371_3)

								iter_371_1.color = Color.New(var_371_4, var_371_5, var_371_6)
							else
								local var_371_7 = Mathf.Lerp(iter_371_1.color.r, 0.5, var_371_3)

								iter_371_1.color = Color.New(var_371_7, var_371_7, var_371_7)
							end
						end
					end
				end
			end

			if arg_368_1.time_ >= var_371_1 + var_371_2 and arg_368_1.time_ < var_371_1 + var_371_2 + arg_371_0 and not isNil(var_371_0) and arg_368_1.var_.actorSpriteComps1086 then
				for iter_371_2, iter_371_3 in pairs(arg_368_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_371_3 then
						if arg_368_1.isInRecall_ then
							iter_371_3.color = arg_368_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_371_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_368_1.var_.actorSpriteComps1086 = nil
			end

			local var_371_8 = 0
			local var_371_9 = 1.05

			if var_371_8 < arg_368_1.time_ and arg_368_1.time_ <= var_371_8 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, false)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_368_1.iconTrs_.gameObject, false)
				arg_368_1.callingController_:SetSelectedState("normal")

				local var_371_10 = arg_368_1:GetWordFromCfg(416191086)
				local var_371_11 = arg_368_1:FormatText(var_371_10.content)

				arg_368_1.text_.text = var_371_11

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_12 = 42
				local var_371_13 = utf8.len(var_371_11)
				local var_371_14 = var_371_12 <= 0 and var_371_9 or var_371_9 * (var_371_13 / var_371_12)

				if var_371_14 > 0 and var_371_9 < var_371_14 then
					arg_368_1.talkMaxDuration = var_371_14

					if var_371_14 + var_371_8 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_14 + var_371_8
					end
				end

				arg_368_1.text_.text = var_371_11
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)
				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_15 = math.max(var_371_9, arg_368_1.talkMaxDuration)

			if var_371_8 <= arg_368_1.time_ and arg_368_1.time_ < var_371_8 + var_371_15 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_8) / var_371_15

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_8 + var_371_15 and arg_368_1.time_ < var_371_8 + var_371_15 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {}

		arg_368_1:InitPlayNodeList()
	end,
	Play416191087 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 416191087
		arg_372_1.duration_ = 5.83

		local var_372_0 = {
			zh = 5.833,
			ja = 4.933
		}
		local var_372_1 = manager.audio:GetLocalizationFlag()

		if var_372_0[var_372_1] ~= nil then
			arg_372_1.duration_ = var_372_0[var_372_1]
		end

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play416191088(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			local var_375_0 = arg_372_1.actors_["1086"]
			local var_375_1 = 0

			if var_375_1 < arg_372_1.time_ and arg_372_1.time_ <= var_375_1 + arg_375_0 and not isNil(var_375_0) and arg_372_1.var_.actorSpriteComps1086 == nil then
				arg_372_1.var_.actorSpriteComps1086 = var_375_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_375_2 = 0.2

			if var_375_1 <= arg_372_1.time_ and arg_372_1.time_ < var_375_1 + var_375_2 and not isNil(var_375_0) then
				local var_375_3 = (arg_372_1.time_ - var_375_1) / var_375_2

				if arg_372_1.var_.actorSpriteComps1086 then
					for iter_375_0, iter_375_1 in pairs(arg_372_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_375_1 then
							if arg_372_1.isInRecall_ then
								local var_375_4 = Mathf.Lerp(iter_375_1.color.r, arg_372_1.hightColor1.r, var_375_3)
								local var_375_5 = Mathf.Lerp(iter_375_1.color.g, arg_372_1.hightColor1.g, var_375_3)
								local var_375_6 = Mathf.Lerp(iter_375_1.color.b, arg_372_1.hightColor1.b, var_375_3)

								iter_375_1.color = Color.New(var_375_4, var_375_5, var_375_6)
							else
								local var_375_7 = Mathf.Lerp(iter_375_1.color.r, 1, var_375_3)

								iter_375_1.color = Color.New(var_375_7, var_375_7, var_375_7)
							end
						end
					end
				end
			end

			if arg_372_1.time_ >= var_375_1 + var_375_2 and arg_372_1.time_ < var_375_1 + var_375_2 + arg_375_0 and not isNil(var_375_0) and arg_372_1.var_.actorSpriteComps1086 then
				for iter_375_2, iter_375_3 in pairs(arg_372_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_375_3 then
						if arg_372_1.isInRecall_ then
							iter_375_3.color = arg_372_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_375_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_372_1.var_.actorSpriteComps1086 = nil
			end

			local var_375_8 = arg_372_1.actors_["1086"].transform
			local var_375_9 = 0

			if var_375_9 < arg_372_1.time_ and arg_372_1.time_ <= var_375_9 + arg_375_0 then
				arg_372_1.var_.moveOldPos1086 = var_375_8.localPosition
				var_375_8.localScale = Vector3.New(1, 1, 1)

				arg_372_1:CheckSpriteTmpPos("1086", 3)

				local var_375_10 = var_375_8.childCount

				for iter_375_4 = 0, var_375_10 - 1 do
					local var_375_11 = var_375_8:GetChild(iter_375_4)

					if var_375_11.name == "split_1" or not string.find(var_375_11.name, "split") then
						var_375_11.gameObject:SetActive(true)
					else
						var_375_11.gameObject:SetActive(false)
					end
				end
			end

			local var_375_12 = 0.001

			if var_375_9 <= arg_372_1.time_ and arg_372_1.time_ < var_375_9 + var_375_12 then
				local var_375_13 = (arg_372_1.time_ - var_375_9) / var_375_12
				local var_375_14 = Vector3.New(0, -404.2, -237.9)

				var_375_8.localPosition = Vector3.Lerp(arg_372_1.var_.moveOldPos1086, var_375_14, var_375_13)
			end

			if arg_372_1.time_ >= var_375_9 + var_375_12 and arg_372_1.time_ < var_375_9 + var_375_12 + arg_375_0 then
				var_375_8.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_375_15 = 0
			local var_375_16 = 0.425

			if var_375_15 < arg_372_1.time_ and arg_372_1.time_ <= var_375_15 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, true)

				local var_375_17 = arg_372_1:FormatText(StoryNameCfg[1080].name)

				arg_372_1.leftNameTxt_.text = var_375_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_372_1.leftNameTxt_.transform)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1.leftNameTxt_.text)
				SetActive(arg_372_1.iconTrs_.gameObject, false)
				arg_372_1.callingController_:SetSelectedState("normal")

				local var_375_18 = arg_372_1:GetWordFromCfg(416191087)
				local var_375_19 = arg_372_1:FormatText(var_375_18.content)

				arg_372_1.text_.text = var_375_19

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_20 = 17
				local var_375_21 = utf8.len(var_375_19)
				local var_375_22 = var_375_20 <= 0 and var_375_16 or var_375_16 * (var_375_21 / var_375_20)

				if var_375_22 > 0 and var_375_16 < var_375_22 then
					arg_372_1.talkMaxDuration = var_375_22

					if var_375_22 + var_375_15 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_22 + var_375_15
					end
				end

				arg_372_1.text_.text = var_375_19
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191087", "story_v_out_416191.awb") ~= 0 then
					local var_375_23 = manager.audio:GetVoiceLength("story_v_out_416191", "416191087", "story_v_out_416191.awb") / 1000

					if var_375_23 + var_375_15 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_23 + var_375_15
					end

					if var_375_18.prefab_name ~= "" and arg_372_1.actors_[var_375_18.prefab_name] ~= nil then
						local var_375_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_372_1.actors_[var_375_18.prefab_name].transform, "story_v_out_416191", "416191087", "story_v_out_416191.awb")

						arg_372_1:RecordAudio("416191087", var_375_24)
						arg_372_1:RecordAudio("416191087", var_375_24)
					else
						arg_372_1:AudioAction("play", "voice", "story_v_out_416191", "416191087", "story_v_out_416191.awb")
					end

					arg_372_1:RecordHistoryTalkVoice("story_v_out_416191", "416191087", "story_v_out_416191.awb")
				end

				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_25 = math.max(var_375_16, arg_372_1.talkMaxDuration)

			if var_375_15 <= arg_372_1.time_ and arg_372_1.time_ < var_375_15 + var_375_25 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_15) / var_375_25

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_15 + var_375_25 and arg_372_1.time_ < var_375_15 + var_375_25 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_372_1:InitPlayNodeList()
	end,
	Play416191088 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 416191088
		arg_376_1.duration_ = 10.07

		local var_376_0 = {
			zh = 4.8,
			ja = 10.066
		}
		local var_376_1 = manager.audio:GetLocalizationFlag()

		if var_376_0[var_376_1] ~= nil then
			arg_376_1.duration_ = var_376_0[var_376_1]
		end

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play416191089(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			local var_379_0 = arg_376_1.actors_["1028"]
			local var_379_1 = 0

			if var_379_1 < arg_376_1.time_ and arg_376_1.time_ <= var_379_1 + arg_379_0 and not isNil(var_379_0) and arg_376_1.var_.actorSpriteComps1028 == nil then
				arg_376_1.var_.actorSpriteComps1028 = var_379_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_379_2 = 0.2

			if var_379_1 <= arg_376_1.time_ and arg_376_1.time_ < var_379_1 + var_379_2 and not isNil(var_379_0) then
				local var_379_3 = (arg_376_1.time_ - var_379_1) / var_379_2

				if arg_376_1.var_.actorSpriteComps1028 then
					for iter_379_0, iter_379_1 in pairs(arg_376_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_379_1 then
							if arg_376_1.isInRecall_ then
								local var_379_4 = Mathf.Lerp(iter_379_1.color.r, arg_376_1.hightColor1.r, var_379_3)
								local var_379_5 = Mathf.Lerp(iter_379_1.color.g, arg_376_1.hightColor1.g, var_379_3)
								local var_379_6 = Mathf.Lerp(iter_379_1.color.b, arg_376_1.hightColor1.b, var_379_3)

								iter_379_1.color = Color.New(var_379_4, var_379_5, var_379_6)
							else
								local var_379_7 = Mathf.Lerp(iter_379_1.color.r, 1, var_379_3)

								iter_379_1.color = Color.New(var_379_7, var_379_7, var_379_7)
							end
						end
					end
				end
			end

			if arg_376_1.time_ >= var_379_1 + var_379_2 and arg_376_1.time_ < var_379_1 + var_379_2 + arg_379_0 and not isNil(var_379_0) and arg_376_1.var_.actorSpriteComps1028 then
				for iter_379_2, iter_379_3 in pairs(arg_376_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_379_3 then
						if arg_376_1.isInRecall_ then
							iter_379_3.color = arg_376_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_379_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_376_1.var_.actorSpriteComps1028 = nil
			end

			local var_379_8 = arg_376_1.actors_["1086"]
			local var_379_9 = 0

			if var_379_9 < arg_376_1.time_ and arg_376_1.time_ <= var_379_9 + arg_379_0 and not isNil(var_379_8) and arg_376_1.var_.actorSpriteComps1086 == nil then
				arg_376_1.var_.actorSpriteComps1086 = var_379_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_379_10 = 0.2

			if var_379_9 <= arg_376_1.time_ and arg_376_1.time_ < var_379_9 + var_379_10 and not isNil(var_379_8) then
				local var_379_11 = (arg_376_1.time_ - var_379_9) / var_379_10

				if arg_376_1.var_.actorSpriteComps1086 then
					for iter_379_4, iter_379_5 in pairs(arg_376_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_379_5 then
							if arg_376_1.isInRecall_ then
								local var_379_12 = Mathf.Lerp(iter_379_5.color.r, arg_376_1.hightColor2.r, var_379_11)
								local var_379_13 = Mathf.Lerp(iter_379_5.color.g, arg_376_1.hightColor2.g, var_379_11)
								local var_379_14 = Mathf.Lerp(iter_379_5.color.b, arg_376_1.hightColor2.b, var_379_11)

								iter_379_5.color = Color.New(var_379_12, var_379_13, var_379_14)
							else
								local var_379_15 = Mathf.Lerp(iter_379_5.color.r, 0.5, var_379_11)

								iter_379_5.color = Color.New(var_379_15, var_379_15, var_379_15)
							end
						end
					end
				end
			end

			if arg_376_1.time_ >= var_379_9 + var_379_10 and arg_376_1.time_ < var_379_9 + var_379_10 + arg_379_0 and not isNil(var_379_8) and arg_376_1.var_.actorSpriteComps1086 then
				for iter_379_6, iter_379_7 in pairs(arg_376_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_379_7 then
						if arg_376_1.isInRecall_ then
							iter_379_7.color = arg_376_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_379_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_376_1.var_.actorSpriteComps1086 = nil
			end

			local var_379_16 = arg_376_1.actors_["1028"].transform
			local var_379_17 = 0

			if var_379_17 < arg_376_1.time_ and arg_376_1.time_ <= var_379_17 + arg_379_0 then
				arg_376_1.var_.moveOldPos1028 = var_379_16.localPosition
				var_379_16.localScale = Vector3.New(1, 1, 1)

				arg_376_1:CheckSpriteTmpPos("1028", 2)

				local var_379_18 = var_379_16.childCount

				for iter_379_8 = 0, var_379_18 - 1 do
					local var_379_19 = var_379_16:GetChild(iter_379_8)

					if var_379_19.name == "" or not string.find(var_379_19.name, "split") then
						var_379_19.gameObject:SetActive(true)
					else
						var_379_19.gameObject:SetActive(false)
					end
				end
			end

			local var_379_20 = 0.001

			if var_379_17 <= arg_376_1.time_ and arg_376_1.time_ < var_379_17 + var_379_20 then
				local var_379_21 = (arg_376_1.time_ - var_379_17) / var_379_20
				local var_379_22 = Vector3.New(-390, -402.7, -156.1)

				var_379_16.localPosition = Vector3.Lerp(arg_376_1.var_.moveOldPos1028, var_379_22, var_379_21)
			end

			if arg_376_1.time_ >= var_379_17 + var_379_20 and arg_376_1.time_ < var_379_17 + var_379_20 + arg_379_0 then
				var_379_16.localPosition = Vector3.New(-390, -402.7, -156.1)
			end

			local var_379_23 = arg_376_1.actors_["1086"].transform
			local var_379_24 = 0

			if var_379_24 < arg_376_1.time_ and arg_376_1.time_ <= var_379_24 + arg_379_0 then
				arg_376_1.var_.moveOldPos1086 = var_379_23.localPosition
				var_379_23.localScale = Vector3.New(1, 1, 1)

				arg_376_1:CheckSpriteTmpPos("1086", 4)

				local var_379_25 = var_379_23.childCount

				for iter_379_9 = 0, var_379_25 - 1 do
					local var_379_26 = var_379_23:GetChild(iter_379_9)

					if var_379_26.name == "" or not string.find(var_379_26.name, "split") then
						var_379_26.gameObject:SetActive(true)
					else
						var_379_26.gameObject:SetActive(false)
					end
				end
			end

			local var_379_27 = 0.001

			if var_379_24 <= arg_376_1.time_ and arg_376_1.time_ < var_379_24 + var_379_27 then
				local var_379_28 = (arg_376_1.time_ - var_379_24) / var_379_27
				local var_379_29 = Vector3.New(390, -404.2, -237.9)

				var_379_23.localPosition = Vector3.Lerp(arg_376_1.var_.moveOldPos1086, var_379_29, var_379_28)
			end

			if arg_376_1.time_ >= var_379_24 + var_379_27 and arg_376_1.time_ < var_379_24 + var_379_27 + arg_379_0 then
				var_379_23.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_379_30 = 0
			local var_379_31 = 0.575

			if var_379_30 < arg_376_1.time_ and arg_376_1.time_ <= var_379_30 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, true)

				local var_379_32 = arg_376_1:FormatText(StoryNameCfg[327].name)

				arg_376_1.leftNameTxt_.text = var_379_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_376_1.leftNameTxt_.transform)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1.leftNameTxt_.text)
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_33 = arg_376_1:GetWordFromCfg(416191088)
				local var_379_34 = arg_376_1:FormatText(var_379_33.content)

				arg_376_1.text_.text = var_379_34

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_35 = 23
				local var_379_36 = utf8.len(var_379_34)
				local var_379_37 = var_379_35 <= 0 and var_379_31 or var_379_31 * (var_379_36 / var_379_35)

				if var_379_37 > 0 and var_379_31 < var_379_37 then
					arg_376_1.talkMaxDuration = var_379_37

					if var_379_37 + var_379_30 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_37 + var_379_30
					end
				end

				arg_376_1.text_.text = var_379_34
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191088", "story_v_out_416191.awb") ~= 0 then
					local var_379_38 = manager.audio:GetVoiceLength("story_v_out_416191", "416191088", "story_v_out_416191.awb") / 1000

					if var_379_38 + var_379_30 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_38 + var_379_30
					end

					if var_379_33.prefab_name ~= "" and arg_376_1.actors_[var_379_33.prefab_name] ~= nil then
						local var_379_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_376_1.actors_[var_379_33.prefab_name].transform, "story_v_out_416191", "416191088", "story_v_out_416191.awb")

						arg_376_1:RecordAudio("416191088", var_379_39)
						arg_376_1:RecordAudio("416191088", var_379_39)
					else
						arg_376_1:AudioAction("play", "voice", "story_v_out_416191", "416191088", "story_v_out_416191.awb")
					end

					arg_376_1:RecordHistoryTalkVoice("story_v_out_416191", "416191088", "story_v_out_416191.awb")
				end

				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_40 = math.max(var_379_31, arg_376_1.talkMaxDuration)

			if var_379_30 <= arg_376_1.time_ and arg_376_1.time_ < var_379_30 + var_379_40 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_30) / var_379_40

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_30 + var_379_40 and arg_376_1.time_ < var_379_30 + var_379_40 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_376_1:InitPlayNodeList()
	end,
	Play416191089 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 416191089
		arg_380_1.duration_ = 5.2

		local var_380_0 = {
			zh = 3.666,
			ja = 5.2
		}
		local var_380_1 = manager.audio:GetLocalizationFlag()

		if var_380_0[var_380_1] ~= nil then
			arg_380_1.duration_ = var_380_0[var_380_1]
		end

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play416191090(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			local var_383_0 = arg_380_1.actors_["1086"]
			local var_383_1 = 0

			if var_383_1 < arg_380_1.time_ and arg_380_1.time_ <= var_383_1 + arg_383_0 and not isNil(var_383_0) and arg_380_1.var_.actorSpriteComps1086 == nil then
				arg_380_1.var_.actorSpriteComps1086 = var_383_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_383_2 = 0.2

			if var_383_1 <= arg_380_1.time_ and arg_380_1.time_ < var_383_1 + var_383_2 and not isNil(var_383_0) then
				local var_383_3 = (arg_380_1.time_ - var_383_1) / var_383_2

				if arg_380_1.var_.actorSpriteComps1086 then
					for iter_383_0, iter_383_1 in pairs(arg_380_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_383_1 then
							if arg_380_1.isInRecall_ then
								local var_383_4 = Mathf.Lerp(iter_383_1.color.r, arg_380_1.hightColor1.r, var_383_3)
								local var_383_5 = Mathf.Lerp(iter_383_1.color.g, arg_380_1.hightColor1.g, var_383_3)
								local var_383_6 = Mathf.Lerp(iter_383_1.color.b, arg_380_1.hightColor1.b, var_383_3)

								iter_383_1.color = Color.New(var_383_4, var_383_5, var_383_6)
							else
								local var_383_7 = Mathf.Lerp(iter_383_1.color.r, 1, var_383_3)

								iter_383_1.color = Color.New(var_383_7, var_383_7, var_383_7)
							end
						end
					end
				end
			end

			if arg_380_1.time_ >= var_383_1 + var_383_2 and arg_380_1.time_ < var_383_1 + var_383_2 + arg_383_0 and not isNil(var_383_0) and arg_380_1.var_.actorSpriteComps1086 then
				for iter_383_2, iter_383_3 in pairs(arg_380_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_383_3 then
						if arg_380_1.isInRecall_ then
							iter_383_3.color = arg_380_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_383_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_380_1.var_.actorSpriteComps1086 = nil
			end

			local var_383_8 = arg_380_1.actors_["1028"]
			local var_383_9 = 0

			if var_383_9 < arg_380_1.time_ and arg_380_1.time_ <= var_383_9 + arg_383_0 and not isNil(var_383_8) and arg_380_1.var_.actorSpriteComps1028 == nil then
				arg_380_1.var_.actorSpriteComps1028 = var_383_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_383_10 = 0.2

			if var_383_9 <= arg_380_1.time_ and arg_380_1.time_ < var_383_9 + var_383_10 and not isNil(var_383_8) then
				local var_383_11 = (arg_380_1.time_ - var_383_9) / var_383_10

				if arg_380_1.var_.actorSpriteComps1028 then
					for iter_383_4, iter_383_5 in pairs(arg_380_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_383_5 then
							if arg_380_1.isInRecall_ then
								local var_383_12 = Mathf.Lerp(iter_383_5.color.r, arg_380_1.hightColor2.r, var_383_11)
								local var_383_13 = Mathf.Lerp(iter_383_5.color.g, arg_380_1.hightColor2.g, var_383_11)
								local var_383_14 = Mathf.Lerp(iter_383_5.color.b, arg_380_1.hightColor2.b, var_383_11)

								iter_383_5.color = Color.New(var_383_12, var_383_13, var_383_14)
							else
								local var_383_15 = Mathf.Lerp(iter_383_5.color.r, 0.5, var_383_11)

								iter_383_5.color = Color.New(var_383_15, var_383_15, var_383_15)
							end
						end
					end
				end
			end

			if arg_380_1.time_ >= var_383_9 + var_383_10 and arg_380_1.time_ < var_383_9 + var_383_10 + arg_383_0 and not isNil(var_383_8) and arg_380_1.var_.actorSpriteComps1028 then
				for iter_383_6, iter_383_7 in pairs(arg_380_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_383_7 then
						if arg_380_1.isInRecall_ then
							iter_383_7.color = arg_380_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_383_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_380_1.var_.actorSpriteComps1028 = nil
			end

			local var_383_16 = arg_380_1.actors_["1086"].transform
			local var_383_17 = 0

			if var_383_17 < arg_380_1.time_ and arg_380_1.time_ <= var_383_17 + arg_383_0 then
				arg_380_1.var_.moveOldPos1086 = var_383_16.localPosition
				var_383_16.localScale = Vector3.New(1, 1, 1)

				arg_380_1:CheckSpriteTmpPos("1086", 4)

				local var_383_18 = var_383_16.childCount

				for iter_383_8 = 0, var_383_18 - 1 do
					local var_383_19 = var_383_16:GetChild(iter_383_8)

					if var_383_19.name == "split_4" or not string.find(var_383_19.name, "split") then
						var_383_19.gameObject:SetActive(true)
					else
						var_383_19.gameObject:SetActive(false)
					end
				end
			end

			local var_383_20 = 0.001

			if var_383_17 <= arg_380_1.time_ and arg_380_1.time_ < var_383_17 + var_383_20 then
				local var_383_21 = (arg_380_1.time_ - var_383_17) / var_383_20
				local var_383_22 = Vector3.New(390, -404.2, -237.9)

				var_383_16.localPosition = Vector3.Lerp(arg_380_1.var_.moveOldPos1086, var_383_22, var_383_21)
			end

			if arg_380_1.time_ >= var_383_17 + var_383_20 and arg_380_1.time_ < var_383_17 + var_383_20 + arg_383_0 then
				var_383_16.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_383_23 = 0
			local var_383_24 = 0.325

			if var_383_23 < arg_380_1.time_ and arg_380_1.time_ <= var_383_23 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, true)

				local var_383_25 = arg_380_1:FormatText(StoryNameCfg[1080].name)

				arg_380_1.leftNameTxt_.text = var_383_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_380_1.leftNameTxt_.transform)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1.leftNameTxt_.text)
				SetActive(arg_380_1.iconTrs_.gameObject, false)
				arg_380_1.callingController_:SetSelectedState("normal")

				local var_383_26 = arg_380_1:GetWordFromCfg(416191089)
				local var_383_27 = arg_380_1:FormatText(var_383_26.content)

				arg_380_1.text_.text = var_383_27

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_28 = 13
				local var_383_29 = utf8.len(var_383_27)
				local var_383_30 = var_383_28 <= 0 and var_383_24 or var_383_24 * (var_383_29 / var_383_28)

				if var_383_30 > 0 and var_383_24 < var_383_30 then
					arg_380_1.talkMaxDuration = var_383_30

					if var_383_30 + var_383_23 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_30 + var_383_23
					end
				end

				arg_380_1.text_.text = var_383_27
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191089", "story_v_out_416191.awb") ~= 0 then
					local var_383_31 = manager.audio:GetVoiceLength("story_v_out_416191", "416191089", "story_v_out_416191.awb") / 1000

					if var_383_31 + var_383_23 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_31 + var_383_23
					end

					if var_383_26.prefab_name ~= "" and arg_380_1.actors_[var_383_26.prefab_name] ~= nil then
						local var_383_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_380_1.actors_[var_383_26.prefab_name].transform, "story_v_out_416191", "416191089", "story_v_out_416191.awb")

						arg_380_1:RecordAudio("416191089", var_383_32)
						arg_380_1:RecordAudio("416191089", var_383_32)
					else
						arg_380_1:AudioAction("play", "voice", "story_v_out_416191", "416191089", "story_v_out_416191.awb")
					end

					arg_380_1:RecordHistoryTalkVoice("story_v_out_416191", "416191089", "story_v_out_416191.awb")
				end

				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_33 = math.max(var_383_24, arg_380_1.talkMaxDuration)

			if var_383_23 <= arg_380_1.time_ and arg_380_1.time_ < var_383_23 + var_383_33 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_23) / var_383_33

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_23 + var_383_33 and arg_380_1.time_ < var_383_23 + var_383_33 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_380_1:InitPlayNodeList()
	end,
	Play416191090 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 416191090
		arg_384_1.duration_ = 6.5

		local var_384_0 = {
			zh = 5,
			ja = 6.5
		}
		local var_384_1 = manager.audio:GetLocalizationFlag()

		if var_384_0[var_384_1] ~= nil then
			arg_384_1.duration_ = var_384_0[var_384_1]
		end

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play416191091(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			local var_387_0 = arg_384_1.actors_["1028"]
			local var_387_1 = 0

			if var_387_1 < arg_384_1.time_ and arg_384_1.time_ <= var_387_1 + arg_387_0 and not isNil(var_387_0) and arg_384_1.var_.actorSpriteComps1028 == nil then
				arg_384_1.var_.actorSpriteComps1028 = var_387_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_387_2 = 0.2

			if var_387_1 <= arg_384_1.time_ and arg_384_1.time_ < var_387_1 + var_387_2 and not isNil(var_387_0) then
				local var_387_3 = (arg_384_1.time_ - var_387_1) / var_387_2

				if arg_384_1.var_.actorSpriteComps1028 then
					for iter_387_0, iter_387_1 in pairs(arg_384_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_387_1 then
							if arg_384_1.isInRecall_ then
								local var_387_4 = Mathf.Lerp(iter_387_1.color.r, arg_384_1.hightColor1.r, var_387_3)
								local var_387_5 = Mathf.Lerp(iter_387_1.color.g, arg_384_1.hightColor1.g, var_387_3)
								local var_387_6 = Mathf.Lerp(iter_387_1.color.b, arg_384_1.hightColor1.b, var_387_3)

								iter_387_1.color = Color.New(var_387_4, var_387_5, var_387_6)
							else
								local var_387_7 = Mathf.Lerp(iter_387_1.color.r, 1, var_387_3)

								iter_387_1.color = Color.New(var_387_7, var_387_7, var_387_7)
							end
						end
					end
				end
			end

			if arg_384_1.time_ >= var_387_1 + var_387_2 and arg_384_1.time_ < var_387_1 + var_387_2 + arg_387_0 and not isNil(var_387_0) and arg_384_1.var_.actorSpriteComps1028 then
				for iter_387_2, iter_387_3 in pairs(arg_384_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_387_3 then
						if arg_384_1.isInRecall_ then
							iter_387_3.color = arg_384_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_387_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_384_1.var_.actorSpriteComps1028 = nil
			end

			local var_387_8 = arg_384_1.actors_["1086"]
			local var_387_9 = 0

			if var_387_9 < arg_384_1.time_ and arg_384_1.time_ <= var_387_9 + arg_387_0 and not isNil(var_387_8) and arg_384_1.var_.actorSpriteComps1086 == nil then
				arg_384_1.var_.actorSpriteComps1086 = var_387_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_387_10 = 0.2

			if var_387_9 <= arg_384_1.time_ and arg_384_1.time_ < var_387_9 + var_387_10 and not isNil(var_387_8) then
				local var_387_11 = (arg_384_1.time_ - var_387_9) / var_387_10

				if arg_384_1.var_.actorSpriteComps1086 then
					for iter_387_4, iter_387_5 in pairs(arg_384_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_387_5 then
							if arg_384_1.isInRecall_ then
								local var_387_12 = Mathf.Lerp(iter_387_5.color.r, arg_384_1.hightColor2.r, var_387_11)
								local var_387_13 = Mathf.Lerp(iter_387_5.color.g, arg_384_1.hightColor2.g, var_387_11)
								local var_387_14 = Mathf.Lerp(iter_387_5.color.b, arg_384_1.hightColor2.b, var_387_11)

								iter_387_5.color = Color.New(var_387_12, var_387_13, var_387_14)
							else
								local var_387_15 = Mathf.Lerp(iter_387_5.color.r, 0.5, var_387_11)

								iter_387_5.color = Color.New(var_387_15, var_387_15, var_387_15)
							end
						end
					end
				end
			end

			if arg_384_1.time_ >= var_387_9 + var_387_10 and arg_384_1.time_ < var_387_9 + var_387_10 + arg_387_0 and not isNil(var_387_8) and arg_384_1.var_.actorSpriteComps1086 then
				for iter_387_6, iter_387_7 in pairs(arg_384_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_387_7 then
						if arg_384_1.isInRecall_ then
							iter_387_7.color = arg_384_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_387_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_384_1.var_.actorSpriteComps1086 = nil
			end

			local var_387_16 = 0
			local var_387_17 = 0.55

			if var_387_16 < arg_384_1.time_ and arg_384_1.time_ <= var_387_16 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, true)

				local var_387_18 = arg_384_1:FormatText(StoryNameCfg[327].name)

				arg_384_1.leftNameTxt_.text = var_387_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_384_1.leftNameTxt_.transform)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1.leftNameTxt_.text)
				SetActive(arg_384_1.iconTrs_.gameObject, false)
				arg_384_1.callingController_:SetSelectedState("normal")

				local var_387_19 = arg_384_1:GetWordFromCfg(416191090)
				local var_387_20 = arg_384_1:FormatText(var_387_19.content)

				arg_384_1.text_.text = var_387_20

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_21 = 22
				local var_387_22 = utf8.len(var_387_20)
				local var_387_23 = var_387_21 <= 0 and var_387_17 or var_387_17 * (var_387_22 / var_387_21)

				if var_387_23 > 0 and var_387_17 < var_387_23 then
					arg_384_1.talkMaxDuration = var_387_23

					if var_387_23 + var_387_16 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_23 + var_387_16
					end
				end

				arg_384_1.text_.text = var_387_20
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191090", "story_v_out_416191.awb") ~= 0 then
					local var_387_24 = manager.audio:GetVoiceLength("story_v_out_416191", "416191090", "story_v_out_416191.awb") / 1000

					if var_387_24 + var_387_16 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_24 + var_387_16
					end

					if var_387_19.prefab_name ~= "" and arg_384_1.actors_[var_387_19.prefab_name] ~= nil then
						local var_387_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_384_1.actors_[var_387_19.prefab_name].transform, "story_v_out_416191", "416191090", "story_v_out_416191.awb")

						arg_384_1:RecordAudio("416191090", var_387_25)
						arg_384_1:RecordAudio("416191090", var_387_25)
					else
						arg_384_1:AudioAction("play", "voice", "story_v_out_416191", "416191090", "story_v_out_416191.awb")
					end

					arg_384_1:RecordHistoryTalkVoice("story_v_out_416191", "416191090", "story_v_out_416191.awb")
				end

				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_26 = math.max(var_387_17, arg_384_1.talkMaxDuration)

			if var_387_16 <= arg_384_1.time_ and arg_384_1.time_ < var_387_16 + var_387_26 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_16) / var_387_26

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_16 + var_387_26 and arg_384_1.time_ < var_387_16 + var_387_26 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {}

		arg_384_1:InitPlayNodeList()
	end,
	Play416191091 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 416191091
		arg_388_1.duration_ = 5

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
			arg_388_1.auto_ = false
		end

		function arg_388_1.playNext_(arg_390_0)
			arg_388_1.onStoryFinished_()
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			local var_391_0 = arg_388_1.actors_["1028"]
			local var_391_1 = 0

			if var_391_1 < arg_388_1.time_ and arg_388_1.time_ <= var_391_1 + arg_391_0 and not isNil(var_391_0) and arg_388_1.var_.actorSpriteComps1028 == nil then
				arg_388_1.var_.actorSpriteComps1028 = var_391_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_391_2 = 0.2

			if var_391_1 <= arg_388_1.time_ and arg_388_1.time_ < var_391_1 + var_391_2 and not isNil(var_391_0) then
				local var_391_3 = (arg_388_1.time_ - var_391_1) / var_391_2

				if arg_388_1.var_.actorSpriteComps1028 then
					for iter_391_0, iter_391_1 in pairs(arg_388_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_391_1 then
							if arg_388_1.isInRecall_ then
								local var_391_4 = Mathf.Lerp(iter_391_1.color.r, arg_388_1.hightColor2.r, var_391_3)
								local var_391_5 = Mathf.Lerp(iter_391_1.color.g, arg_388_1.hightColor2.g, var_391_3)
								local var_391_6 = Mathf.Lerp(iter_391_1.color.b, arg_388_1.hightColor2.b, var_391_3)

								iter_391_1.color = Color.New(var_391_4, var_391_5, var_391_6)
							else
								local var_391_7 = Mathf.Lerp(iter_391_1.color.r, 0.5, var_391_3)

								iter_391_1.color = Color.New(var_391_7, var_391_7, var_391_7)
							end
						end
					end
				end
			end

			if arg_388_1.time_ >= var_391_1 + var_391_2 and arg_388_1.time_ < var_391_1 + var_391_2 + arg_391_0 and not isNil(var_391_0) and arg_388_1.var_.actorSpriteComps1028 then
				for iter_391_2, iter_391_3 in pairs(arg_388_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_391_3 then
						if arg_388_1.isInRecall_ then
							iter_391_3.color = arg_388_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_391_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_388_1.var_.actorSpriteComps1028 = nil
			end

			local var_391_8 = arg_388_1.actors_["1028"].transform
			local var_391_9 = 0

			if var_391_9 < arg_388_1.time_ and arg_388_1.time_ <= var_391_9 + arg_391_0 then
				arg_388_1.var_.moveOldPos1028 = var_391_8.localPosition
				var_391_8.localScale = Vector3.New(1, 1, 1)

				arg_388_1:CheckSpriteTmpPos("1028", 7)

				local var_391_10 = var_391_8.childCount

				for iter_391_4 = 0, var_391_10 - 1 do
					local var_391_11 = var_391_8:GetChild(iter_391_4)

					if var_391_11.name == "" or not string.find(var_391_11.name, "split") then
						var_391_11.gameObject:SetActive(true)
					else
						var_391_11.gameObject:SetActive(false)
					end
				end
			end

			local var_391_12 = 0.001

			if var_391_9 <= arg_388_1.time_ and arg_388_1.time_ < var_391_9 + var_391_12 then
				local var_391_13 = (arg_388_1.time_ - var_391_9) / var_391_12
				local var_391_14 = Vector3.New(0, -2000, 0)

				var_391_8.localPosition = Vector3.Lerp(arg_388_1.var_.moveOldPos1028, var_391_14, var_391_13)
			end

			if arg_388_1.time_ >= var_391_9 + var_391_12 and arg_388_1.time_ < var_391_9 + var_391_12 + arg_391_0 then
				var_391_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_391_15 = arg_388_1.actors_["1086"].transform
			local var_391_16 = 0

			if var_391_16 < arg_388_1.time_ and arg_388_1.time_ <= var_391_16 + arg_391_0 then
				arg_388_1.var_.moveOldPos1086 = var_391_15.localPosition
				var_391_15.localScale = Vector3.New(1, 1, 1)

				arg_388_1:CheckSpriteTmpPos("1086", 7)

				local var_391_17 = var_391_15.childCount

				for iter_391_5 = 0, var_391_17 - 1 do
					local var_391_18 = var_391_15:GetChild(iter_391_5)

					if var_391_18.name == "" or not string.find(var_391_18.name, "split") then
						var_391_18.gameObject:SetActive(true)
					else
						var_391_18.gameObject:SetActive(false)
					end
				end
			end

			local var_391_19 = 0.001

			if var_391_16 <= arg_388_1.time_ and arg_388_1.time_ < var_391_16 + var_391_19 then
				local var_391_20 = (arg_388_1.time_ - var_391_16) / var_391_19
				local var_391_21 = Vector3.New(0, -2000, 0)

				var_391_15.localPosition = Vector3.Lerp(arg_388_1.var_.moveOldPos1086, var_391_21, var_391_20)
			end

			if arg_388_1.time_ >= var_391_16 + var_391_19 and arg_388_1.time_ < var_391_16 + var_391_19 + arg_391_0 then
				var_391_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_391_22 = 0
			local var_391_23 = 1.65

			if var_391_22 < arg_388_1.time_ and arg_388_1.time_ <= var_391_22 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, false)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_388_1.iconTrs_.gameObject, false)
				arg_388_1.callingController_:SetSelectedState("normal")

				local var_391_24 = arg_388_1:GetWordFromCfg(416191091)
				local var_391_25 = arg_388_1:FormatText(var_391_24.content)

				arg_388_1.text_.text = var_391_25

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_26 = 66
				local var_391_27 = utf8.len(var_391_25)
				local var_391_28 = var_391_26 <= 0 and var_391_23 or var_391_23 * (var_391_27 / var_391_26)

				if var_391_28 > 0 and var_391_23 < var_391_28 then
					arg_388_1.talkMaxDuration = var_391_28

					if var_391_28 + var_391_22 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_28 + var_391_22
					end
				end

				arg_388_1.text_.text = var_391_25
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)
				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_29 = math.max(var_391_23, arg_388_1.talkMaxDuration)

			if var_391_22 <= arg_388_1.time_ and arg_388_1.time_ < var_391_22 + var_391_29 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_22) / var_391_29

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_22 + var_391_29 and arg_388_1.time_ < var_391_22 + var_391_29 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_388_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STwhite",
		"TextureConfig/Background/SS1608",
		"TextureConfig/Background/F09f"
	},
	voices = {
		"story_v_out_416191.awb"
	}
}
