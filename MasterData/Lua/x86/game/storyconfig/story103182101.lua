return {
	Play318211001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 318211001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play318211002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.STblack == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_4_0.name = "STblack"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.STblack = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.STblack

				arg_1_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "STblack" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_5 = 2

			if var_4_4 <= arg_1_1.time_ and arg_1_1.time_ < var_4_4 + var_4_5 then
				local var_4_6 = Color.New(0, 0, 0)

				var_4_6.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_4) / var_4_5)
				arg_1_1.mask_.color = var_4_6
			end

			if arg_1_1.time_ >= var_4_4 + var_4_5 and arg_1_1.time_ < var_4_4 + var_4_5 + arg_4_0 then
				local var_4_7 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_7.a = 0
				arg_1_1.mask_.color = var_4_7
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_10 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_10 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_10

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_10
						arg_1_1.bgmTxt2_.text = var_4_10
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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_11 = 2
			local var_4_12 = 0.825

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_11 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_13 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_13:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_14 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(318211001).content)

				arg_1_1.text_.text = var_4_14

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_16 = 33 <= 0 and var_4_12 or var_4_12 * (utf8.len(var_4_14) / 33)

				if (33 <= 0 and var_4_12 or var_4_12 * (utf8.len(var_4_14) / 33)) > 0 and var_4_12 < var_4_16 then
					arg_1_1.talkMaxDuration = var_4_16
					var_4_11 = var_4_11 + 0.3

					if var_4_16 + var_4_11 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_16 + var_4_11
					end
				end

				arg_1_1.text_.text = var_4_14
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_17 = var_4_11 + 0.3
			local var_4_18 = math.max(var_4_12, arg_1_1.talkMaxDuration)

			if var_4_11 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_17 + var_4_18 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_17) / var_4_18

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_17 + var_4_18 and arg_1_1.time_ < var_4_17 + var_4_18 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play318211002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 318211002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play318211003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 1.275

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_1 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(318211002).content)

				arg_8_1.text_.text = var_11_1

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_3 = 51 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 51)

				if (51 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 51)) > 0 and var_11_0 < var_11_3 then
					arg_8_1.talkMaxDuration = var_11_3

					if var_11_3 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_3 + 0
					end
				end

				arg_8_1.text_.text = var_11_1
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_4 = math.max(var_11_0, arg_8_1.talkMaxDuration)

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_4 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - 0) / var_11_4

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= 0 + var_11_4 and arg_8_1.time_ < 0 + var_11_4 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play318211003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 318211003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play318211004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0.525

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_1 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(318211003).content)

				arg_12_1.text_.text = var_15_1

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_3 = 24 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 24)

				if (24 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 24)) > 0 and var_15_0 < var_15_3 then
					arg_12_1.talkMaxDuration = var_15_3

					if var_15_3 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_3 + 0
					end
				end

				arg_12_1.text_.text = var_15_1
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_4 = math.max(var_15_0, arg_12_1.talkMaxDuration)

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_4 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - 0) / var_15_4

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= 0 + var_15_4 and arg_12_1.time_ < 0 + var_15_4 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play318211004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 318211004
		arg_16_1.duration_ = 2

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play318211005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.fswbg_:SetActive(true)
				arg_16_1.dialog_:SetActive(false)

				arg_16_1.fswtw_.percent = 0
				arg_16_1.fswt_.text = arg_16_1:FormatText(arg_16_1:GetWordFromCfg(318211004).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.fswt_)

				arg_16_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_16_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_16_1.fswtw_:SetDirty()

				arg_16_1.typewritterCharCountI18N = 0

				SetActive(arg_16_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_16_1:ShowNextGo(false)
			end

			local var_19_0 = 0.033

			if 0.033 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				arg_16_1.var_.oldValueTypewriter = arg_16_1.fswtw_.percent

				SetActive(arg_16_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_16_1:ShowNextGo(false)
			end

			local var_19_1 = 12
			local var_19_2 = 0.8
			local var_19_3, var_19_4 = arg_16_1:GetPercentByPara(arg_16_1:FormatText(arg_16_1:GetWordFromCfg(318211004).content), 1)

			if var_19_0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0

				local var_19_5 = var_19_1 <= 0 and var_19_2 or var_19_2 * ((var_19_4 - arg_16_1.typewritterCharCountI18N) / var_19_1)

				if (var_19_1 <= 0 and var_19_2 or var_19_2 * ((var_19_4 - arg_16_1.typewritterCharCountI18N) / var_19_1)) > 0 and var_19_2 < var_19_5 then
					arg_16_1.talkMaxDuration = var_19_5

					if var_19_5 + var_19_0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_5 + var_19_0
					end
				end
			end

			local var_19_6 = math.max(0.8, arg_16_1.talkMaxDuration)

			if var_19_0 <= arg_16_1.time_ and arg_16_1.time_ < var_19_0 + var_19_6 then
				arg_16_1.fswtw_.percent = Mathf.Lerp(arg_16_1.var_.oldValueTypewriter, var_19_3, (arg_16_1.time_ - var_19_0) / var_19_6)
				arg_16_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_16_1.fswtw_:SetDirty()
			end

			if arg_16_1.time_ >= var_19_0 + var_19_6 and arg_16_1.time_ < var_19_0 + var_19_6 + arg_19_0 then
				arg_16_1.fswtw_.percent = var_19_3

				arg_16_1.fswtw_:SetDirty()
				arg_16_1:ShowNextGo(true)

				arg_16_1.typewritterCharCountI18N = var_19_4
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				local var_19_7 = arg_16_1.fswbg_.transform:Find("textbox/adapt/content") or arg_16_1.fswbg_.transform:Find("textbox/content")
				local var_19_8 = arg_16_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_19_9 = var_19_7:GetComponent("RectTransform")

				var_19_7:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_19_9.offsetMin = Vector2.New(0, 0)
				var_19_9.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play318211005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 318211005
		arg_20_1.duration_ = 2

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play318211006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.fswbg_:SetActive(true)
				arg_20_1.dialog_:SetActive(false)

				arg_20_1.fswtw_.percent = 0
				arg_20_1.fswt_.text = arg_20_1:FormatText(arg_20_1:GetWordFromCfg(318211005).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.fswt_)

				arg_20_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_20_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_20_1.fswtw_:SetDirty()

				arg_20_1.typewritterCharCountI18N = 0

				SetActive(arg_20_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_20_1:ShowNextGo(false)
			end

			local var_23_0 = 0.033

			if 0.033 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1.var_.oldValueTypewriter = arg_20_1.fswtw_.percent

				SetActive(arg_20_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_20_1:ShowNextGo(false)
			end

			local var_23_1 = 16
			local var_23_2 = 1.06666666666667
			local var_23_3, var_23_4 = arg_20_1:GetPercentByPara(arg_20_1:FormatText(arg_20_1:GetWordFromCfg(318211005).content), 1)

			if var_23_0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0

				local var_23_5 = var_23_1 <= 0 and var_23_2 or var_23_2 * ((var_23_4 - arg_20_1.typewritterCharCountI18N) / var_23_1)

				if (var_23_1 <= 0 and var_23_2 or var_23_2 * ((var_23_4 - arg_20_1.typewritterCharCountI18N) / var_23_1)) > 0 and var_23_2 < var_23_5 then
					arg_20_1.talkMaxDuration = var_23_5

					if var_23_5 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_5 + var_23_0
					end
				end
			end

			local var_23_6 = math.max(1.06666666666667, arg_20_1.talkMaxDuration)

			if var_23_0 <= arg_20_1.time_ and arg_20_1.time_ < var_23_0 + var_23_6 then
				arg_20_1.fswtw_.percent = Mathf.Lerp(arg_20_1.var_.oldValueTypewriter, var_23_3, (arg_20_1.time_ - var_23_0) / var_23_6)
				arg_20_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_20_1.fswtw_:SetDirty()
			end

			if arg_20_1.time_ >= var_23_0 + var_23_6 and arg_20_1.time_ < var_23_0 + var_23_6 + arg_23_0 then
				arg_20_1.fswtw_.percent = var_23_3

				arg_20_1.fswtw_:SetDirty()
				arg_20_1:ShowNextGo(true)

				arg_20_1.typewritterCharCountI18N = var_23_4
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				local var_23_7 = arg_20_1.fswbg_.transform:Find("textbox/adapt/content") or arg_20_1.fswbg_.transform:Find("textbox/content")
				local var_23_8 = arg_20_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_23_9 = var_23_7:GetComponent("RectTransform")

				var_23_7:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_23_9.offsetMin = Vector2.New(0, 0)
				var_23_9.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play318211006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 318211006
		arg_24_1.duration_ = 4.1

		local var_24_0 = {
			zh = 2.999999999999,
			ja = 4.1
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
				arg_24_0:Play318211007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 1 < arg_24_1.time_ and arg_24_1.time_ <= 1 + arg_27_0 then
				local var_27_0 = arg_24_1.bgs_.STblack

				arg_24_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_27_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_27_1 = var_27_0:GetComponent("SpriteRenderer")

				if var_27_1 and var_27_1.sprite then
					local var_27_2 = 2 * (var_27_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_27_0.transform.localScale = Vector3.New(var_27_2 / var_27_1.sprite.bounds.size.y < var_27_2 * manager.ui.mainCameraCom_.aspect / var_27_1.sprite.bounds.size.x and var_27_2 * manager.ui.mainCameraCom_.aspect / var_27_1.sprite.bounds.size.x or var_27_2 / var_27_1.sprite.bounds.size.y, var_27_2 / var_27_1.sprite.bounds.size.y < var_27_2 * manager.ui.mainCameraCom_.aspect / var_27_1.sprite.bounds.size.x and var_27_2 * manager.ui.mainCameraCom_.aspect / var_27_1.sprite.bounds.size.x or var_27_2 / var_27_1.sprite.bounds.size.y, 0)
				end

				for iter_27_0, iter_27_1 in pairs(arg_24_1.bgs_) do
					if iter_27_0 ~= "STblack" then
						iter_27_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_27_3 = "1199ui_story"

			if arg_24_1.actors_["1199ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1199ui_story"))) then
				local var_27_4 = Object.Instantiate(Asset.Load("Char/" .. "1199ui_story"), arg_24_1.stage_.transform)

				var_27_4.name = var_27_3
				var_27_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_24_1.actors_[var_27_3] = var_27_4

				local var_27_5 = var_27_4:GetComponentInChildren(typeof(CharacterEffect))

				var_27_5.enabled = true

				local var_27_6 = GameObjectTools.GetOrAddComponent(var_27_4, typeof(DynamicBoneHelper))

				if var_27_6 then
					var_27_6:EnableDynamicBone(false)
				end

				arg_24_1:ShowWeapon(var_27_5.transform, false)

				arg_24_1.var_[var_27_3 .. "Animator"] = var_27_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_24_1.var_[var_27_3 .. "Animator"].applyRootMotion = true
				arg_24_1.var_[var_27_3 .. "LipSync"] = var_27_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_27_7 = arg_24_1.actors_["1199ui_story"].transform

			if 1 < arg_24_1.time_ and arg_24_1.time_ <= 1 + arg_27_0 then
				arg_24_1.var_.moveOldPos1199ui_story = var_27_7.localPosition
			end

			local var_27_8 = 0.001

			if 1 <= arg_24_1.time_ and arg_24_1.time_ < 1 + var_27_8 then
				var_27_7.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1199ui_story, Vector3.New(0, -1.08, -5.9), (arg_24_1.time_ - 1) / var_27_8)
				var_27_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_7.position).x, (manager.ui.mainCamera.transform.position - var_27_7.position).y, (manager.ui.mainCamera.transform.position - var_27_7.position).z)
				var_27_7.localEulerAngles.z = 0
				var_27_7.localEulerAngles.x = 0
				var_27_7.localEulerAngles = var_27_7.localEulerAngles
			end

			if arg_24_1.time_ >= 1 + var_27_8 and arg_24_1.time_ < 1 + var_27_8 + arg_27_0 then
				var_27_7.localPosition = Vector3.New(0, -1.08, -5.9)
				var_27_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_7.position).x, (manager.ui.mainCamera.transform.position - var_27_7.position).y, (manager.ui.mainCamera.transform.position - var_27_7.position).z)
				var_27_7.localEulerAngles.z = 0
				var_27_7.localEulerAngles.x = 0
				var_27_7.localEulerAngles = var_27_7.localEulerAngles
			end

			local var_27_9 = arg_24_1.actors_["1199ui_story"]

			if 1 < arg_24_1.time_ and arg_24_1.time_ <= 1 + arg_27_0 and not isNil(var_27_9) and arg_24_1.var_.characterEffect1199ui_story == nil then
				arg_24_1.var_.characterEffect1199ui_story = var_27_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_10 = 0.200000002980232

			if 1 <= arg_24_1.time_ and arg_24_1.time_ < 1 + var_27_10 and not isNil(var_27_9) then
				if arg_24_1.var_.characterEffect1199ui_story and not isNil(var_27_9) then
					arg_24_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= 1 + var_27_10 and arg_24_1.time_ < 1 + var_27_10 + arg_27_0 and not isNil(var_27_9) and arg_24_1.var_.characterEffect1199ui_story then
				arg_24_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 1 < arg_24_1.time_ and arg_24_1.time_ <= 1 + arg_27_0 then
				arg_24_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1199/story1199action/1199action5_1")
			end

			if 1 < arg_24_1.time_ and arg_24_1.time_ <= 1 + arg_27_0 then
				arg_24_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			if 1 < arg_24_1.time_ and arg_24_1.time_ <= 1 + arg_27_0 then
				arg_24_1.fswbg_:SetActive(false)
				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_24_1:ShowNextGo(false)
			end

			local var_27_12 = 0

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_12 + arg_27_0 then
				arg_24_1.mask_.enabled = true
				arg_24_1.mask_.raycastTarget = true

				arg_24_1:SetGaussion(false)
			end

			local var_27_13 = 1

			if var_27_12 <= arg_24_1.time_ and arg_24_1.time_ < var_27_12 + var_27_13 then
				local var_27_14 = Color.New(0.0471698, 0.04516731, 0.04604959)

				var_27_14.a = Mathf.Lerp(0, 1, (arg_24_1.time_ - var_27_12) / var_27_13)
				arg_24_1.mask_.color = var_27_14
			end

			if arg_24_1.time_ >= var_27_12 + var_27_13 and arg_24_1.time_ < var_27_12 + var_27_13 + arg_27_0 then
				local var_27_15 = Color.New(0.0471698, 0.04516731, 0.04604959)

				var_27_15.a = 1
				arg_24_1.mask_.color = var_27_15
			end

			local var_27_16 = 1

			if 1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_16 + arg_27_0 then
				arg_24_1.mask_.enabled = true
				arg_24_1.mask_.raycastTarget = true

				arg_24_1:SetGaussion(false)
			end

			local var_27_17 = 1

			if var_27_16 <= arg_24_1.time_ and arg_24_1.time_ < var_27_16 + var_27_17 then
				local var_27_18 = Color.New(0, 0, 0)

				var_27_18.a = Mathf.Lerp(1, 0, (arg_24_1.time_ - var_27_16) / var_27_17)
				arg_24_1.mask_.color = var_27_18
			end

			if arg_24_1.time_ >= var_27_16 + var_27_17 and arg_24_1.time_ < var_27_16 + var_27_17 + arg_27_0 then
				local var_27_19 = Color.New(0, 0, 0)

				arg_24_1.mask_.enabled = false
				var_27_19.a = 0
				arg_24_1.mask_.color = var_27_19
			end

			local var_27_20 = 1
			local var_27_21 = 0.075

			if 1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_20 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_22 = arg_24_1:GetWordFromCfg(318211006)
				local var_27_23 = arg_24_1:FormatText(var_27_22.content)

				arg_24_1.text_.text = var_27_23

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_25 = 3 <= 0 and var_27_21 or var_27_21 * (utf8.len(var_27_23) / 3)

				if (3 <= 0 and var_27_21 or var_27_21 * (utf8.len(var_27_23) / 3)) > 0 and var_27_21 < var_27_25 then
					arg_24_1.talkMaxDuration = var_27_25

					if var_27_25 + var_27_20 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_25 + var_27_20
					end
				end

				arg_24_1.text_.text = var_27_23
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318211", "318211006", "story_v_out_318211.awb") ~= 0 then
					local var_27_26 = manager.audio:GetVoiceLength("story_v_out_318211", "318211006", "story_v_out_318211.awb") / 1000

					if var_27_26 + var_27_20 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_26 + var_27_20
					end

					if var_27_22.prefab_name ~= "" and arg_24_1.actors_[var_27_22.prefab_name] ~= nil then
						local var_27_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_22.prefab_name].transform, "story_v_out_318211", "318211006", "story_v_out_318211.awb")

						arg_24_1:RecordAudio("318211006", var_27_27)
						arg_24_1:RecordAudio("318211006", var_27_27)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_318211", "318211006", "story_v_out_318211.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_318211", "318211006", "story_v_out_318211.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_28 = math.max(var_27_21, arg_24_1.talkMaxDuration)

			if var_27_20 <= arg_24_1.time_ and arg_24_1.time_ < var_27_20 + var_27_28 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_20) / var_27_28

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_20 + var_27_28 and arg_24_1.time_ < var_27_20 + var_27_28 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play318211007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 318211007
		arg_28_1.duration_ = 3.63

		local var_28_0 = {
			zh = 2.366,
			ja = 3.633
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
				arg_28_0:Play318211008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0.225

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_1 = arg_28_1:GetWordFromCfg(318211007)
				local var_31_2 = arg_28_1:FormatText(var_31_1.content)

				arg_28_1.text_.text = var_31_2

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_4 = 9 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_2) / 9)

				if (9 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_2) / 9)) > 0 and var_31_0 < var_31_4 then
					arg_28_1.talkMaxDuration = var_31_4

					if var_31_4 + 0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_4 + 0
					end
				end

				arg_28_1.text_.text = var_31_2
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318211", "318211007", "story_v_out_318211.awb") ~= 0 then
					local var_31_5 = manager.audio:GetVoiceLength("story_v_out_318211", "318211007", "story_v_out_318211.awb") / 1000

					if var_31_5 + 0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_5 + 0
					end

					if var_31_1.prefab_name ~= "" and arg_28_1.actors_[var_31_1.prefab_name] ~= nil then
						local var_31_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_1.prefab_name].transform, "story_v_out_318211", "318211007", "story_v_out_318211.awb")

						arg_28_1:RecordAudio("318211007", var_31_6)
						arg_28_1:RecordAudio("318211007", var_31_6)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_318211", "318211007", "story_v_out_318211.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_318211", "318211007", "story_v_out_318211.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_7 = math.max(var_31_0, arg_28_1.talkMaxDuration)

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_7 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - 0) / var_31_7

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= 0 + var_31_7 and arg_28_1.time_ < 0 + var_31_7 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play318211008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 318211008
		arg_32_1.duration_ = 7

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play318211009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if arg_32_1.bgs_.ST69a == nil then
				local var_35_0 = Object.Instantiate(arg_32_1.paintGo_)

				var_35_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST69a")
				var_35_0.name = "ST69a"
				var_35_0.transform.parent = arg_32_1.stage_.transform
				var_35_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_32_1.bgs_.ST69a = var_35_0
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				local var_35_1 = arg_32_1.bgs_.ST69a

				arg_32_1.bgs_.ST69a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_35_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_35_2 = var_35_1:GetComponent("SpriteRenderer")

				if var_35_2 and var_35_2.sprite then
					local var_35_3 = 2 * (var_35_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_35_1.transform.localScale = Vector3.New(var_35_3 / var_35_2.sprite.bounds.size.y < var_35_3 * manager.ui.mainCameraCom_.aspect / var_35_2.sprite.bounds.size.x and var_35_3 * manager.ui.mainCameraCom_.aspect / var_35_2.sprite.bounds.size.x or var_35_3 / var_35_2.sprite.bounds.size.y, var_35_3 / var_35_2.sprite.bounds.size.y < var_35_3 * manager.ui.mainCameraCom_.aspect / var_35_2.sprite.bounds.size.x and var_35_3 * manager.ui.mainCameraCom_.aspect / var_35_2.sprite.bounds.size.x or var_35_3 / var_35_2.sprite.bounds.size.y, 0)
				end

				for iter_35_0, iter_35_1 in pairs(arg_32_1.bgs_) do
					if iter_35_0 ~= "ST69a" then
						iter_35_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_35_4 = 0

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_4 + arg_35_0 then
				arg_32_1.mask_.enabled = true
				arg_32_1.mask_.raycastTarget = true

				arg_32_1:SetGaussion(false)
			end

			local var_35_5 = 2

			if var_35_4 <= arg_32_1.time_ and arg_32_1.time_ < var_35_4 + var_35_5 then
				local var_35_6 = Color.New(1, 1, 1)

				var_35_6.a = Mathf.Lerp(1, 0, (arg_32_1.time_ - var_35_4) / var_35_5)
				arg_32_1.mask_.color = var_35_6
			end

			if arg_32_1.time_ >= var_35_4 + var_35_5 and arg_32_1.time_ < var_35_4 + var_35_5 + arg_35_0 then
				local var_35_7 = Color.New(1, 1, 1)

				arg_32_1.mask_.enabled = false
				var_35_7.a = 0
				arg_32_1.mask_.color = var_35_7
			end

			local var_35_8 = arg_32_1.actors_["1199ui_story"].transform

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos1199ui_story = var_35_8.localPosition
			end

			local var_35_9 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_9 then
				var_35_8.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1199ui_story, Vector3.New(0, 100, 0), (arg_32_1.time_ - 0) / var_35_9)
				var_35_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_8.position).x, (manager.ui.mainCamera.transform.position - var_35_8.position).y, (manager.ui.mainCamera.transform.position - var_35_8.position).z)
				var_35_8.localEulerAngles.z = 0
				var_35_8.localEulerAngles.x = 0
				var_35_8.localEulerAngles = var_35_8.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_9 and arg_32_1.time_ < 0 + var_35_9 + arg_35_0 then
				var_35_8.localPosition = Vector3.New(0, 100, 0)
				var_35_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_8.position).x, (manager.ui.mainCamera.transform.position - var_35_8.position).y, (manager.ui.mainCamera.transform.position - var_35_8.position).z)
				var_35_8.localEulerAngles.z = 0
				var_35_8.localEulerAngles.x = 0
				var_35_8.localEulerAngles = var_35_8.localEulerAngles
			end

			local var_35_10 = arg_32_1.actors_["1199ui_story"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_10) and arg_32_1.var_.characterEffect1199ui_story == nil then
				arg_32_1.var_.characterEffect1199ui_story = var_35_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_11 = 0.200000002980232

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_11 and not isNil(var_35_10) then
				if arg_32_1.var_.characterEffect1199ui_story and not isNil(var_35_10) then
					arg_32_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_32_1.time_ - 0) / var_35_11)
				end
			end

			if arg_32_1.time_ >= 0 + var_35_11 and arg_32_1.time_ < 0 + var_35_11 + arg_35_0 and not isNil(var_35_10) and arg_32_1.var_.characterEffect1199ui_story then
				arg_32_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_35_14 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_32_1.bgmTxt_.text ~= var_35_14 and arg_32_1.bgmTxt_.text ~= "" then
						if arg_32_1.bgmTxt2_.text ~= "" then
							arg_32_1.bgmTxt_.text = arg_32_1.bgmTxt2_.text
						end

						arg_32_1.bgmTxt2_.text = var_35_14

						arg_32_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_32_1.bgmTxt_.text = var_35_14
						arg_32_1.bgmTxt2_.text = var_35_14
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

			if 0.8 < arg_32_1.time_ and arg_32_1.time_ <= 0.8 + arg_35_0 then
				arg_32_1:AudioAction("play", "music", "bgm_activity_2_10_story_sasanamijyou", "bgm_activity_2_10_story_sasanamijyou", "bgm_activity_2_10_story_sasanamijyou.awb")

				local var_35_17 = manager.audio:GetAudioName("bgm_activity_2_10_story_sasanamijyou", "bgm_activity_2_10_story_sasanamijyou")

				if "" ~= "" then
					if arg_32_1.bgmTxt_.text ~= var_35_17 and arg_32_1.bgmTxt_.text ~= "" then
						if arg_32_1.bgmTxt2_.text ~= "" then
							arg_32_1.bgmTxt_.text = arg_32_1.bgmTxt2_.text
						end

						arg_32_1.bgmTxt2_.text = var_35_17

						arg_32_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_32_1.bgmTxt_.text = var_35_17
						arg_32_1.bgmTxt2_.text = var_35_17
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

			if arg_32_1.frameCnt_ <= 1 then
				arg_32_1.dialog_:SetActive(false)
			end

			local var_35_18 = 2
			local var_35_19 = 0.575

			if 2 < arg_32_1.time_ and arg_32_1.time_ <= var_35_18 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0

				arg_32_1.dialog_:SetActive(true)

				arg_32_1.dialogCg_.alpha = 0

				local var_35_20 = LeanTween.value(arg_32_1.dialog_, 0, 1, 0.3)

				var_35_20:setOnUpdate(LuaHelper.FloatAction(function(arg_38_0)
					arg_32_1.dialogCg_.alpha = arg_38_0
				end))
				var_35_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_32_1.dialog_)
					var_35_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_32_1.duration_ = arg_32_1.duration_ + 0.3

				SetActive(arg_32_1.leftNameGo_, false)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_21 = arg_32_1:FormatText(arg_32_1:GetWordFromCfg(318211008).content)

				arg_32_1.text_.text = var_35_21

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_23 = 23 <= 0 and var_35_19 or var_35_19 * (utf8.len(var_35_21) / 23)

				if (23 <= 0 and var_35_19 or var_35_19 * (utf8.len(var_35_21) / 23)) > 0 and var_35_19 < var_35_23 then
					arg_32_1.talkMaxDuration = var_35_23
					var_35_18 = var_35_18 + 0.3

					if var_35_23 + var_35_18 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_23 + var_35_18
					end
				end

				arg_32_1.text_.text = var_35_21
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_24 = var_35_18 + 0.3
			local var_35_25 = math.max(var_35_19, arg_32_1.talkMaxDuration)

			if var_35_18 + 0.3 <= arg_32_1.time_ and arg_32_1.time_ < var_35_24 + var_35_25 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_24) / var_35_25

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_24 + var_35_25 and arg_32_1.time_ < var_35_24 + var_35_25 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play318211009 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 318211009
		arg_40_1.duration_ = 2.97

		local var_40_0 = {
			zh = 1.999999999999,
			ja = 2.966
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
				arg_40_0:Play318211010(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if arg_40_1.actors_["1150ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1150ui_story"))) then
				local var_43_0 = Object.Instantiate(Asset.Load("Char/" .. "1150ui_story"), arg_40_1.stage_.transform)

				var_43_0.name = "1150ui_story"
				var_43_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_40_1.actors_["1150ui_story"] = var_43_0

				local var_43_1 = var_43_0:GetComponentInChildren(typeof(CharacterEffect))

				var_43_1.enabled = true

				local var_43_2 = GameObjectTools.GetOrAddComponent(var_43_0, typeof(DynamicBoneHelper))

				if var_43_2 then
					var_43_2:EnableDynamicBone(false)
				end

				arg_40_1:ShowWeapon(var_43_1.transform, false)

				arg_40_1.var_["1150ui_story" .. "Animator"] = var_43_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_40_1.var_["1150ui_story" .. "Animator"].applyRootMotion = true
				arg_40_1.var_["1150ui_story" .. "LipSync"] = var_43_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_43_3 = arg_40_1.actors_["1150ui_story"].transform

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos1150ui_story = var_43_3.localPosition
			end

			local var_43_4 = 0.001

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_4 then
				var_43_3.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1150ui_story, Vector3.New(0, -1.01, -6.2), (arg_40_1.time_ - 0) / var_43_4)
				var_43_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_3.position).x, (manager.ui.mainCamera.transform.position - var_43_3.position).y, (manager.ui.mainCamera.transform.position - var_43_3.position).z)
				var_43_3.localEulerAngles.z = 0
				var_43_3.localEulerAngles.x = 0
				var_43_3.localEulerAngles = var_43_3.localEulerAngles
			end

			if arg_40_1.time_ >= 0 + var_43_4 and arg_40_1.time_ < 0 + var_43_4 + arg_43_0 then
				var_43_3.localPosition = Vector3.New(0, -1.01, -6.2)
				var_43_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_3.position).x, (manager.ui.mainCamera.transform.position - var_43_3.position).y, (manager.ui.mainCamera.transform.position - var_43_3.position).z)
				var_43_3.localEulerAngles.z = 0
				var_43_3.localEulerAngles.x = 0
				var_43_3.localEulerAngles = var_43_3.localEulerAngles
			end

			local var_43_5 = arg_40_1.actors_["1150ui_story"]

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(var_43_5) and arg_40_1.var_.characterEffect1150ui_story == nil then
				arg_40_1.var_.characterEffect1150ui_story = var_43_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_6 = 0.200000002980232

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_6 and not isNil(var_43_5) then
				if arg_40_1.var_.characterEffect1150ui_story and not isNil(var_43_5) then
					arg_40_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= 0 + var_43_6 and arg_40_1.time_ < 0 + var_43_6 + arg_43_0 and not isNil(var_43_5) and arg_40_1.var_.characterEffect1150ui_story then
				arg_40_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action1_1")
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_43_8 = 0
			local var_43_9 = 0.175

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_8 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_10 = arg_40_1:GetWordFromCfg(318211009)
				local var_43_11 = arg_40_1:FormatText(var_43_10.content)

				arg_40_1.text_.text = var_43_11

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_13 = 7 <= 0 and var_43_9 or var_43_9 * (utf8.len(var_43_11) / 7)

				if (7 <= 0 and var_43_9 or var_43_9 * (utf8.len(var_43_11) / 7)) > 0 and var_43_9 < var_43_13 then
					arg_40_1.talkMaxDuration = var_43_13

					if var_43_13 + var_43_8 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_13 + var_43_8
					end
				end

				arg_40_1.text_.text = var_43_11
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318211", "318211009", "story_v_out_318211.awb") ~= 0 then
					local var_43_14 = manager.audio:GetVoiceLength("story_v_out_318211", "318211009", "story_v_out_318211.awb") / 1000

					if var_43_14 + var_43_8 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_14 + var_43_8
					end

					if var_43_10.prefab_name ~= "" and arg_40_1.actors_[var_43_10.prefab_name] ~= nil then
						local var_43_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_10.prefab_name].transform, "story_v_out_318211", "318211009", "story_v_out_318211.awb")

						arg_40_1:RecordAudio("318211009", var_43_15)
						arg_40_1:RecordAudio("318211009", var_43_15)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_318211", "318211009", "story_v_out_318211.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_318211", "318211009", "story_v_out_318211.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_16 = math.max(var_43_9, arg_40_1.talkMaxDuration)

			if var_43_8 <= arg_40_1.time_ and arg_40_1.time_ < var_43_8 + var_43_16 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_8) / var_43_16

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_8 + var_43_16 and arg_40_1.time_ < var_43_8 + var_43_16 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play318211010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 318211010
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play318211011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.moveOldPos1150ui_story = arg_44_1.actors_["1150ui_story"].transform.localPosition
			end

			local var_47_0 = 0.001

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_0 then
				arg_44_1.actors_["1150ui_story"].transform.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1150ui_story, Vector3.New(0, 100, 0), (arg_44_1.time_ - 0) / var_47_0)
				arg_44_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_44_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["1150ui_story"].transform.position).z)
				arg_44_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_44_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_44_1.actors_["1150ui_story"].transform.localEulerAngles = arg_44_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 then
				arg_44_1.actors_["1150ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_44_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_44_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["1150ui_story"].transform.position).z)
				arg_44_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_44_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_44_1.actors_["1150ui_story"].transform.localEulerAngles = arg_44_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			local var_47_1 = arg_44_1.actors_["1150ui_story"]

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(var_47_1) and arg_44_1.var_.characterEffect1150ui_story == nil then
				arg_44_1.var_.characterEffect1150ui_story = var_47_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_2 = 0.200000002980232

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_2 and not isNil(var_47_1) then
				if arg_44_1.var_.characterEffect1150ui_story and not isNil(var_47_1) then
					arg_44_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1150ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_44_1.time_ - 0) / var_47_2)
				end
			end

			if arg_44_1.time_ >= 0 + var_47_2 and arg_44_1.time_ < 0 + var_47_2 + arg_47_0 and not isNil(var_47_1) and arg_44_1.var_.characterEffect1150ui_story then
				arg_44_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1150ui_story.fillRatio = 0.5
			end

			local var_47_3 = 0
			local var_47_4 = 1.275

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_3 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, false)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_5 = arg_44_1:FormatText(arg_44_1:GetWordFromCfg(318211010).content)

				arg_44_1.text_.text = var_47_5

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_7 = 51 <= 0 and var_47_4 or var_47_4 * (utf8.len(var_47_5) / 51)

				if (51 <= 0 and var_47_4 or var_47_4 * (utf8.len(var_47_5) / 51)) > 0 and var_47_4 < var_47_7 then
					arg_44_1.talkMaxDuration = var_47_7

					if var_47_7 + var_47_3 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_7 + var_47_3
					end
				end

				arg_44_1.text_.text = var_47_5
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_8 = math.max(var_47_4, arg_44_1.talkMaxDuration)

			if var_47_3 <= arg_44_1.time_ and arg_44_1.time_ < var_47_3 + var_47_8 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_3) / var_47_8

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_3 + var_47_8 and arg_44_1.time_ < var_47_3 + var_47_8 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
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
	Play318211011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 318211011
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play318211012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0.7

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, false)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_1 = arg_48_1:FormatText(arg_48_1:GetWordFromCfg(318211011).content)

				arg_48_1.text_.text = var_51_1

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_3 = 28 <= 0 and var_51_0 or var_51_0 * (utf8.len(var_51_1) / 28)

				if (28 <= 0 and var_51_0 or var_51_0 * (utf8.len(var_51_1) / 28)) > 0 and var_51_0 < var_51_3 then
					arg_48_1.talkMaxDuration = var_51_3

					if var_51_3 + 0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_3 + 0
					end
				end

				arg_48_1.text_.text = var_51_1
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_4 = math.max(var_51_0, arg_48_1.talkMaxDuration)

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_4 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - 0) / var_51_4

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= 0 + var_51_4 and arg_48_1.time_ < 0 + var_51_4 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play318211012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 318211012
		arg_52_1.duration_ = 4.1

		local var_52_0 = {
			zh = 3.066,
			ja = 4.1
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
				arg_52_0:Play318211013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if arg_52_1.actors_["1093ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1093ui_story"))) then
				local var_55_0 = Object.Instantiate(Asset.Load("Char/" .. "1093ui_story"), arg_52_1.stage_.transform)

				var_55_0.name = "1093ui_story"
				var_55_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_52_1.actors_["1093ui_story"] = var_55_0

				local var_55_1 = var_55_0:GetComponentInChildren(typeof(CharacterEffect))

				var_55_1.enabled = true

				local var_55_2 = GameObjectTools.GetOrAddComponent(var_55_0, typeof(DynamicBoneHelper))

				if var_55_2 then
					var_55_2:EnableDynamicBone(false)
				end

				arg_52_1:ShowWeapon(var_55_1.transform, false)

				arg_52_1.var_["1093ui_story" .. "Animator"] = var_55_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_52_1.var_["1093ui_story" .. "Animator"].applyRootMotion = true
				arg_52_1.var_["1093ui_story" .. "LipSync"] = var_55_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_55_3 = arg_52_1.actors_["1093ui_story"].transform

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.var_.moveOldPos1093ui_story = var_55_3.localPosition
			end

			local var_55_4 = 0.001

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_4 then
				var_55_3.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_52_1.time_ - 0) / var_55_4)
				var_55_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_55_3.position).x, (manager.ui.mainCamera.transform.position - var_55_3.position).y, (manager.ui.mainCamera.transform.position - var_55_3.position).z)
				var_55_3.localEulerAngles.z = 0
				var_55_3.localEulerAngles.x = 0
				var_55_3.localEulerAngles = var_55_3.localEulerAngles
			end

			if arg_52_1.time_ >= 0 + var_55_4 and arg_52_1.time_ < 0 + var_55_4 + arg_55_0 then
				var_55_3.localPosition = Vector3.New(0, -1.11, -5.88)
				var_55_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_55_3.position).x, (manager.ui.mainCamera.transform.position - var_55_3.position).y, (manager.ui.mainCamera.transform.position - var_55_3.position).z)
				var_55_3.localEulerAngles.z = 0
				var_55_3.localEulerAngles.x = 0
				var_55_3.localEulerAngles = var_55_3.localEulerAngles
			end

			local var_55_5 = arg_52_1.actors_["1093ui_story"]

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(var_55_5) and arg_52_1.var_.characterEffect1093ui_story == nil then
				arg_52_1.var_.characterEffect1093ui_story = var_55_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_6 = 0.200000002980232

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_6 and not isNil(var_55_5) then
				if arg_52_1.var_.characterEffect1093ui_story and not isNil(var_55_5) then
					arg_52_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= 0 + var_55_6 and arg_52_1.time_ < 0 + var_55_6 + arg_55_0 and not isNil(var_55_5) and arg_52_1.var_.characterEffect1093ui_story then
				arg_52_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action8_1")
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_55_8 = 0
			local var_55_9 = 0.35

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_8 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_10 = arg_52_1:GetWordFromCfg(318211012)
				local var_55_11 = arg_52_1:FormatText(var_55_10.content)

				arg_52_1.text_.text = var_55_11

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_13 = 14 <= 0 and var_55_9 or var_55_9 * (utf8.len(var_55_11) / 14)

				if (14 <= 0 and var_55_9 or var_55_9 * (utf8.len(var_55_11) / 14)) > 0 and var_55_9 < var_55_13 then
					arg_52_1.talkMaxDuration = var_55_13

					if var_55_13 + var_55_8 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_13 + var_55_8
					end
				end

				arg_52_1.text_.text = var_55_11
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318211", "318211012", "story_v_out_318211.awb") ~= 0 then
					local var_55_14 = manager.audio:GetVoiceLength("story_v_out_318211", "318211012", "story_v_out_318211.awb") / 1000

					if var_55_14 + var_55_8 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_14 + var_55_8
					end

					if var_55_10.prefab_name ~= "" and arg_52_1.actors_[var_55_10.prefab_name] ~= nil then
						local var_55_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_10.prefab_name].transform, "story_v_out_318211", "318211012", "story_v_out_318211.awb")

						arg_52_1:RecordAudio("318211012", var_55_15)
						arg_52_1:RecordAudio("318211012", var_55_15)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_318211", "318211012", "story_v_out_318211.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_318211", "318211012", "story_v_out_318211.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_16 = math.max(var_55_9, arg_52_1.talkMaxDuration)

			if var_55_8 <= arg_52_1.time_ and arg_52_1.time_ < var_55_8 + var_55_16 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_8) / var_55_16

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_8 + var_55_16 and arg_52_1.time_ < var_55_8 + var_55_16 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play318211013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 318211013
		arg_56_1.duration_ = 4.23

		local var_56_0 = {
			zh = 4,
			ja = 4.233
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
				arg_56_0:Play318211014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.var_.moveOldPos1199ui_story = arg_56_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_59_0 = 0.001

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 then
				arg_56_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1199ui_story, Vector3.New(0, -1.08, -5.9), (arg_56_1.time_ - 0) / var_59_0)
				arg_56_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_56_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["1199ui_story"].transform.position).z)
				arg_56_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_56_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_56_1.actors_["1199ui_story"].transform.localEulerAngles = arg_56_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 then
				arg_56_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(0, -1.08, -5.9)
				arg_56_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_56_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["1199ui_story"].transform.position).z)
				arg_56_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_56_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_56_1.actors_["1199ui_story"].transform.localEulerAngles = arg_56_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			local var_59_1 = arg_56_1.actors_["1199ui_story"]

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(var_59_1) and arg_56_1.var_.characterEffect1199ui_story == nil then
				arg_56_1.var_.characterEffect1199ui_story = var_59_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_2 = 0.200000002980232

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_2 and not isNil(var_59_1) then
				if arg_56_1.var_.characterEffect1199ui_story and not isNil(var_59_1) then
					arg_56_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= 0 + var_59_2 and arg_56_1.time_ < 0 + var_59_2 + arg_59_0 and not isNil(var_59_1) and arg_56_1.var_.characterEffect1199ui_story then
				arg_56_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1199/story1199action/1199action1_1")
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_59_4 = arg_56_1.actors_["1093ui_story"].transform

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.var_.moveOldPos1093ui_story = var_59_4.localPosition
			end

			local var_59_5 = 0.001

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_5 then
				var_59_4.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_56_1.time_ - 0) / var_59_5)
				var_59_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_4.position).x, (manager.ui.mainCamera.transform.position - var_59_4.position).y, (manager.ui.mainCamera.transform.position - var_59_4.position).z)
				var_59_4.localEulerAngles.z = 0
				var_59_4.localEulerAngles.x = 0
				var_59_4.localEulerAngles = var_59_4.localEulerAngles
			end

			if arg_56_1.time_ >= 0 + var_59_5 and arg_56_1.time_ < 0 + var_59_5 + arg_59_0 then
				var_59_4.localPosition = Vector3.New(0, 100, 0)
				var_59_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_4.position).x, (manager.ui.mainCamera.transform.position - var_59_4.position).y, (manager.ui.mainCamera.transform.position - var_59_4.position).z)
				var_59_4.localEulerAngles.z = 0
				var_59_4.localEulerAngles.x = 0
				var_59_4.localEulerAngles = var_59_4.localEulerAngles
			end

			local var_59_6 = arg_56_1.actors_["1093ui_story"]

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(var_59_6) and arg_56_1.var_.characterEffect1093ui_story == nil then
				arg_56_1.var_.characterEffect1093ui_story = var_59_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_7 = 0.200000002980232

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_7 and not isNil(var_59_6) then
				if arg_56_1.var_.characterEffect1093ui_story and not isNil(var_59_6) then
					arg_56_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_56_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_56_1.time_ - 0) / var_59_7)
				end
			end

			if arg_56_1.time_ >= 0 + var_59_7 and arg_56_1.time_ < 0 + var_59_7 + arg_59_0 and not isNil(var_59_6) and arg_56_1.var_.characterEffect1093ui_story then
				arg_56_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_56_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_59_8 = 0
			local var_59_9 = 0.3

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_8 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_10 = arg_56_1:GetWordFromCfg(318211013)
				local var_59_11 = arg_56_1:FormatText(var_59_10.content)

				arg_56_1.text_.text = var_59_11

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_13 = 12 <= 0 and var_59_9 or var_59_9 * (utf8.len(var_59_11) / 12)

				if (12 <= 0 and var_59_9 or var_59_9 * (utf8.len(var_59_11) / 12)) > 0 and var_59_9 < var_59_13 then
					arg_56_1.talkMaxDuration = var_59_13

					if var_59_13 + var_59_8 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_13 + var_59_8
					end
				end

				arg_56_1.text_.text = var_59_11
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318211", "318211013", "story_v_out_318211.awb") ~= 0 then
					local var_59_14 = manager.audio:GetVoiceLength("story_v_out_318211", "318211013", "story_v_out_318211.awb") / 1000

					if var_59_14 + var_59_8 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_14 + var_59_8
					end

					if var_59_10.prefab_name ~= "" and arg_56_1.actors_[var_59_10.prefab_name] ~= nil then
						local var_59_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_10.prefab_name].transform, "story_v_out_318211", "318211013", "story_v_out_318211.awb")

						arg_56_1:RecordAudio("318211013", var_59_15)
						arg_56_1:RecordAudio("318211013", var_59_15)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_318211", "318211013", "story_v_out_318211.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_318211", "318211013", "story_v_out_318211.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_16 = math.max(var_59_9, arg_56_1.talkMaxDuration)

			if var_59_8 <= arg_56_1.time_ and arg_56_1.time_ < var_59_8 + var_59_16 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_8) / var_59_16

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_8 + var_59_16 and arg_56_1.time_ < var_59_8 + var_59_16 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play318211014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 318211014
		arg_60_1.duration_ = 7.1

		local var_60_0 = {
			zh = 4.966,
			ja = 7.1
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
				arg_60_0:Play318211015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.var_.moveOldPos1093ui_story = arg_60_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_63_0 = 0.001

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_0 then
				arg_60_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_60_1.time_ - 0) / var_63_0)
				arg_60_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_60_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["1093ui_story"].transform.position).z)
				arg_60_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_60_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_60_1.actors_["1093ui_story"].transform.localEulerAngles = arg_60_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_60_1.time_ >= 0 + var_63_0 and arg_60_1.time_ < 0 + var_63_0 + arg_63_0 then
				arg_60_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_60_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_60_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["1093ui_story"].transform.position).z)
				arg_60_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_60_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_60_1.actors_["1093ui_story"].transform.localEulerAngles = arg_60_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_63_1 = arg_60_1.actors_["1093ui_story"]

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(var_63_1) and arg_60_1.var_.characterEffect1093ui_story == nil then
				arg_60_1.var_.characterEffect1093ui_story = var_63_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_2 = 0.200000002980232

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_2 and not isNil(var_63_1) then
				if arg_60_1.var_.characterEffect1093ui_story and not isNil(var_63_1) then
					arg_60_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= 0 + var_63_2 and arg_60_1.time_ < 0 + var_63_2 + arg_63_0 and not isNil(var_63_1) and arg_60_1.var_.characterEffect1093ui_story then
				arg_60_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action486")
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_63_4 = arg_60_1.actors_["1199ui_story"].transform

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.var_.moveOldPos1199ui_story = var_63_4.localPosition
			end

			local var_63_5 = 0.001

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_5 then
				var_63_4.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1199ui_story, Vector3.New(0, 100, 0), (arg_60_1.time_ - 0) / var_63_5)
				var_63_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_63_4.position).x, (manager.ui.mainCamera.transform.position - var_63_4.position).y, (manager.ui.mainCamera.transform.position - var_63_4.position).z)
				var_63_4.localEulerAngles.z = 0
				var_63_4.localEulerAngles.x = 0
				var_63_4.localEulerAngles = var_63_4.localEulerAngles
			end

			if arg_60_1.time_ >= 0 + var_63_5 and arg_60_1.time_ < 0 + var_63_5 + arg_63_0 then
				var_63_4.localPosition = Vector3.New(0, 100, 0)
				var_63_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_63_4.position).x, (manager.ui.mainCamera.transform.position - var_63_4.position).y, (manager.ui.mainCamera.transform.position - var_63_4.position).z)
				var_63_4.localEulerAngles.z = 0
				var_63_4.localEulerAngles.x = 0
				var_63_4.localEulerAngles = var_63_4.localEulerAngles
			end

			local var_63_6 = arg_60_1.actors_["1199ui_story"]

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(var_63_6) and arg_60_1.var_.characterEffect1199ui_story == nil then
				arg_60_1.var_.characterEffect1199ui_story = var_63_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_7 = 0.200000002980232

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_7 and not isNil(var_63_6) then
				if arg_60_1.var_.characterEffect1199ui_story and not isNil(var_63_6) then
					arg_60_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_60_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_60_1.time_ - 0) / var_63_7)
				end
			end

			if arg_60_1.time_ >= 0 + var_63_7 and arg_60_1.time_ < 0 + var_63_7 + arg_63_0 and not isNil(var_63_6) and arg_60_1.var_.characterEffect1199ui_story then
				arg_60_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_60_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_63_8 = 0
			local var_63_9 = 0.675

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_8 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_10 = arg_60_1:GetWordFromCfg(318211014)
				local var_63_11 = arg_60_1:FormatText(var_63_10.content)

				arg_60_1.text_.text = var_63_11

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_13 = 27 <= 0 and var_63_9 or var_63_9 * (utf8.len(var_63_11) / 27)

				if (27 <= 0 and var_63_9 or var_63_9 * (utf8.len(var_63_11) / 27)) > 0 and var_63_9 < var_63_13 then
					arg_60_1.talkMaxDuration = var_63_13

					if var_63_13 + var_63_8 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_13 + var_63_8
					end
				end

				arg_60_1.text_.text = var_63_11
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318211", "318211014", "story_v_out_318211.awb") ~= 0 then
					local var_63_14 = manager.audio:GetVoiceLength("story_v_out_318211", "318211014", "story_v_out_318211.awb") / 1000

					if var_63_14 + var_63_8 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_14 + var_63_8
					end

					if var_63_10.prefab_name ~= "" and arg_60_1.actors_[var_63_10.prefab_name] ~= nil then
						local var_63_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_10.prefab_name].transform, "story_v_out_318211", "318211014", "story_v_out_318211.awb")

						arg_60_1:RecordAudio("318211014", var_63_15)
						arg_60_1:RecordAudio("318211014", var_63_15)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_318211", "318211014", "story_v_out_318211.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_318211", "318211014", "story_v_out_318211.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_16 = math.max(var_63_9, arg_60_1.talkMaxDuration)

			if var_63_8 <= arg_60_1.time_ and arg_60_1.time_ < var_63_8 + var_63_16 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_8) / var_63_16

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_8 + var_63_16 and arg_60_1.time_ < var_63_8 + var_63_16 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1199ui_story",
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
	Play318211015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 318211015
		arg_64_1.duration_ = 8.67

		local var_64_0 = {
			zh = 8.666,
			ja = 6.833
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
				arg_64_0:Play318211016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = 1.1

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_1 = arg_64_1:GetWordFromCfg(318211015)
				local var_67_2 = arg_64_1:FormatText(var_67_1.content)

				arg_64_1.text_.text = var_67_2

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_4 = 44 <= 0 and var_67_0 or var_67_0 * (utf8.len(var_67_2) / 44)

				if (44 <= 0 and var_67_0 or var_67_0 * (utf8.len(var_67_2) / 44)) > 0 and var_67_0 < var_67_4 then
					arg_64_1.talkMaxDuration = var_67_4

					if var_67_4 + 0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_4 + 0
					end
				end

				arg_64_1.text_.text = var_67_2
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318211", "318211015", "story_v_out_318211.awb") ~= 0 then
					local var_67_5 = manager.audio:GetVoiceLength("story_v_out_318211", "318211015", "story_v_out_318211.awb") / 1000

					if var_67_5 + 0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_5 + 0
					end

					if var_67_1.prefab_name ~= "" and arg_64_1.actors_[var_67_1.prefab_name] ~= nil then
						local var_67_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_1.prefab_name].transform, "story_v_out_318211", "318211015", "story_v_out_318211.awb")

						arg_64_1:RecordAudio("318211015", var_67_6)
						arg_64_1:RecordAudio("318211015", var_67_6)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_318211", "318211015", "story_v_out_318211.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_318211", "318211015", "story_v_out_318211.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_7 = math.max(var_67_0, arg_64_1.talkMaxDuration)

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_7 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - 0) / var_67_7

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= 0 + var_67_7 and arg_64_1.time_ < 0 + var_67_7 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play318211016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 318211016
		arg_68_1.duration_ = 4.2

		local var_68_0 = {
			zh = 3.033,
			ja = 4.2
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
				arg_68_0:Play318211017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.var_.moveOldPos1199ui_story = arg_68_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_71_0 = 0.001

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_0 then
				arg_68_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1199ui_story, Vector3.New(0, -1.08, -5.9), (arg_68_1.time_ - 0) / var_71_0)
				arg_68_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_68_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["1199ui_story"].transform.position).z)
				arg_68_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_68_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_68_1.actors_["1199ui_story"].transform.localEulerAngles = arg_68_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_68_1.time_ >= 0 + var_71_0 and arg_68_1.time_ < 0 + var_71_0 + arg_71_0 then
				arg_68_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(0, -1.08, -5.9)
				arg_68_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_68_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["1199ui_story"].transform.position).z)
				arg_68_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_68_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_68_1.actors_["1199ui_story"].transform.localEulerAngles = arg_68_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			local var_71_1 = arg_68_1.actors_["1199ui_story"]

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(var_71_1) and arg_68_1.var_.characterEffect1199ui_story == nil then
				arg_68_1.var_.characterEffect1199ui_story = var_71_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_2 = 0.200000002980232

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_2 and not isNil(var_71_1) then
				if arg_68_1.var_.characterEffect1199ui_story and not isNil(var_71_1) then
					arg_68_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= 0 + var_71_2 and arg_68_1.time_ < 0 + var_71_2 + arg_71_0 and not isNil(var_71_1) and arg_68_1.var_.characterEffect1199ui_story then
				arg_68_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1199/story1199action/1199action1_1")
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_71_4 = arg_68_1.actors_["1093ui_story"].transform

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.var_.moveOldPos1093ui_story = var_71_4.localPosition
			end

			local var_71_5 = 0.001

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_5 then
				var_71_4.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_68_1.time_ - 0) / var_71_5)
				var_71_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_71_4.position).x, (manager.ui.mainCamera.transform.position - var_71_4.position).y, (manager.ui.mainCamera.transform.position - var_71_4.position).z)
				var_71_4.localEulerAngles.z = 0
				var_71_4.localEulerAngles.x = 0
				var_71_4.localEulerAngles = var_71_4.localEulerAngles
			end

			if arg_68_1.time_ >= 0 + var_71_5 and arg_68_1.time_ < 0 + var_71_5 + arg_71_0 then
				var_71_4.localPosition = Vector3.New(0, 100, 0)
				var_71_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_71_4.position).x, (manager.ui.mainCamera.transform.position - var_71_4.position).y, (manager.ui.mainCamera.transform.position - var_71_4.position).z)
				var_71_4.localEulerAngles.z = 0
				var_71_4.localEulerAngles.x = 0
				var_71_4.localEulerAngles = var_71_4.localEulerAngles
			end

			local var_71_6 = arg_68_1.actors_["1093ui_story"]

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(var_71_6) and arg_68_1.var_.characterEffect1093ui_story == nil then
				arg_68_1.var_.characterEffect1093ui_story = var_71_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_7 = 0.200000002980232

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_7 and not isNil(var_71_6) then
				if arg_68_1.var_.characterEffect1093ui_story and not isNil(var_71_6) then
					arg_68_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_68_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_68_1.time_ - 0) / var_71_7)
				end
			end

			if arg_68_1.time_ >= 0 + var_71_7 and arg_68_1.time_ < 0 + var_71_7 + arg_71_0 and not isNil(var_71_6) and arg_68_1.var_.characterEffect1093ui_story then
				arg_68_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_68_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_71_8 = 0
			local var_71_9 = 0.25

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_8 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_10 = arg_68_1:GetWordFromCfg(318211016)
				local var_71_11 = arg_68_1:FormatText(var_71_10.content)

				arg_68_1.text_.text = var_71_11

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_13 = 10 <= 0 and var_71_9 or var_71_9 * (utf8.len(var_71_11) / 10)

				if (10 <= 0 and var_71_9 or var_71_9 * (utf8.len(var_71_11) / 10)) > 0 and var_71_9 < var_71_13 then
					arg_68_1.talkMaxDuration = var_71_13

					if var_71_13 + var_71_8 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_13 + var_71_8
					end
				end

				arg_68_1.text_.text = var_71_11
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318211", "318211016", "story_v_out_318211.awb") ~= 0 then
					local var_71_14 = manager.audio:GetVoiceLength("story_v_out_318211", "318211016", "story_v_out_318211.awb") / 1000

					if var_71_14 + var_71_8 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_14 + var_71_8
					end

					if var_71_10.prefab_name ~= "" and arg_68_1.actors_[var_71_10.prefab_name] ~= nil then
						local var_71_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_10.prefab_name].transform, "story_v_out_318211", "318211016", "story_v_out_318211.awb")

						arg_68_1:RecordAudio("318211016", var_71_15)
						arg_68_1:RecordAudio("318211016", var_71_15)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_318211", "318211016", "story_v_out_318211.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_318211", "318211016", "story_v_out_318211.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_16 = math.max(var_71_9, arg_68_1.talkMaxDuration)

			if var_71_8 <= arg_68_1.time_ and arg_68_1.time_ < var_71_8 + var_71_16 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_8) / var_71_16

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_8 + var_71_16 and arg_68_1.time_ < var_71_8 + var_71_16 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_68_1:InitPlayNodeList()
	end,
	Play318211017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 318211017
		arg_72_1.duration_ = 4.8

		local var_72_0 = {
			zh = 4.4,
			ja = 4.8
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
				arg_72_0:Play318211018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.var_.moveOldPos1093ui_story = arg_72_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_75_0 = 0.001

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_0 then
				arg_72_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_72_1.time_ - 0) / var_75_0)
				arg_72_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_72_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["1093ui_story"].transform.position).z)
				arg_72_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_72_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_72_1.actors_["1093ui_story"].transform.localEulerAngles = arg_72_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_72_1.time_ >= 0 + var_75_0 and arg_72_1.time_ < 0 + var_75_0 + arg_75_0 then
				arg_72_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_72_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_72_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["1093ui_story"].transform.position).z)
				arg_72_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_72_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_72_1.actors_["1093ui_story"].transform.localEulerAngles = arg_72_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_75_1 = arg_72_1.actors_["1093ui_story"]

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(var_75_1) and arg_72_1.var_.characterEffect1093ui_story == nil then
				arg_72_1.var_.characterEffect1093ui_story = var_75_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_2 = 0.200000002980232

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_2 and not isNil(var_75_1) then
				if arg_72_1.var_.characterEffect1093ui_story and not isNil(var_75_1) then
					arg_72_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= 0 + var_75_2 and arg_72_1.time_ < 0 + var_75_2 + arg_75_0 and not isNil(var_75_1) and arg_72_1.var_.characterEffect1093ui_story then
				arg_72_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_75_4 = arg_72_1.actors_["1199ui_story"].transform

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.var_.moveOldPos1199ui_story = var_75_4.localPosition
			end

			local var_75_5 = 0.001

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_5 then
				var_75_4.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1199ui_story, Vector3.New(0, 100, 0), (arg_72_1.time_ - 0) / var_75_5)
				var_75_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_75_4.position).x, (manager.ui.mainCamera.transform.position - var_75_4.position).y, (manager.ui.mainCamera.transform.position - var_75_4.position).z)
				var_75_4.localEulerAngles.z = 0
				var_75_4.localEulerAngles.x = 0
				var_75_4.localEulerAngles = var_75_4.localEulerAngles
			end

			if arg_72_1.time_ >= 0 + var_75_5 and arg_72_1.time_ < 0 + var_75_5 + arg_75_0 then
				var_75_4.localPosition = Vector3.New(0, 100, 0)
				var_75_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_75_4.position).x, (manager.ui.mainCamera.transform.position - var_75_4.position).y, (manager.ui.mainCamera.transform.position - var_75_4.position).z)
				var_75_4.localEulerAngles.z = 0
				var_75_4.localEulerAngles.x = 0
				var_75_4.localEulerAngles = var_75_4.localEulerAngles
			end

			local var_75_6 = arg_72_1.actors_["1199ui_story"]

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(var_75_6) and arg_72_1.var_.characterEffect1199ui_story == nil then
				arg_72_1.var_.characterEffect1199ui_story = var_75_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_7 = 0.200000002980232

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_7 and not isNil(var_75_6) then
				if arg_72_1.var_.characterEffect1199ui_story and not isNil(var_75_6) then
					arg_72_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_72_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_72_1.time_ - 0) / var_75_7)
				end
			end

			if arg_72_1.time_ >= 0 + var_75_7 and arg_72_1.time_ < 0 + var_75_7 + arg_75_0 and not isNil(var_75_6) and arg_72_1.var_.characterEffect1199ui_story then
				arg_72_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_72_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_75_8 = 0
			local var_75_9 = 0.5

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_8 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_10 = arg_72_1:GetWordFromCfg(318211017)
				local var_75_11 = arg_72_1:FormatText(var_75_10.content)

				arg_72_1.text_.text = var_75_11

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_13 = 20 <= 0 and var_75_9 or var_75_9 * (utf8.len(var_75_11) / 20)

				if (20 <= 0 and var_75_9 or var_75_9 * (utf8.len(var_75_11) / 20)) > 0 and var_75_9 < var_75_13 then
					arg_72_1.talkMaxDuration = var_75_13

					if var_75_13 + var_75_8 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_13 + var_75_8
					end
				end

				arg_72_1.text_.text = var_75_11
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318211", "318211017", "story_v_out_318211.awb") ~= 0 then
					local var_75_14 = manager.audio:GetVoiceLength("story_v_out_318211", "318211017", "story_v_out_318211.awb") / 1000

					if var_75_14 + var_75_8 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_14 + var_75_8
					end

					if var_75_10.prefab_name ~= "" and arg_72_1.actors_[var_75_10.prefab_name] ~= nil then
						local var_75_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_10.prefab_name].transform, "story_v_out_318211", "318211017", "story_v_out_318211.awb")

						arg_72_1:RecordAudio("318211017", var_75_15)
						arg_72_1:RecordAudio("318211017", var_75_15)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_318211", "318211017", "story_v_out_318211.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_318211", "318211017", "story_v_out_318211.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_16 = math.max(var_75_9, arg_72_1.talkMaxDuration)

			if var_75_8 <= arg_72_1.time_ and arg_72_1.time_ < var_75_8 + var_75_16 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_8) / var_75_16

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_8 + var_75_16 and arg_72_1.time_ < var_75_8 + var_75_16 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_72_1:InitPlayNodeList()
	end,
	Play318211018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 318211018
		arg_76_1.duration_ = 4.5

		local var_76_0 = {
			zh = 2.3,
			ja = 4.5
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
				arg_76_0:Play318211019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.var_.moveOldPos1093ui_story = arg_76_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_79_0 = 0.001

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_0 then
				arg_76_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_76_1.time_ - 0) / var_79_0)
				arg_76_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_76_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["1093ui_story"].transform.position).z)
				arg_76_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_76_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_76_1.actors_["1093ui_story"].transform.localEulerAngles = arg_76_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_76_1.time_ >= 0 + var_79_0 and arg_76_1.time_ < 0 + var_79_0 + arg_79_0 then
				arg_76_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_76_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_76_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["1093ui_story"].transform.position).z)
				arg_76_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_76_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_76_1.actors_["1093ui_story"].transform.localEulerAngles = arg_76_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_79_1 = arg_76_1.actors_["1093ui_story"]

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(var_79_1) and arg_76_1.var_.characterEffect1093ui_story == nil then
				arg_76_1.var_.characterEffect1093ui_story = var_79_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_2 = 0.200000002980232

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_2 and not isNil(var_79_1) then
				if arg_76_1.var_.characterEffect1093ui_story and not isNil(var_79_1) then
					arg_76_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= 0 + var_79_2 and arg_76_1.time_ < 0 + var_79_2 + arg_79_0 and not isNil(var_79_1) and arg_76_1.var_.characterEffect1093ui_story then
				arg_76_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action6_2")
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_79_4 = 0
			local var_79_5 = 0.275

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_4 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_6 = arg_76_1:GetWordFromCfg(318211018)
				local var_79_7 = arg_76_1:FormatText(var_79_6.content)

				arg_76_1.text_.text = var_79_7

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_9 = 11 <= 0 and var_79_5 or var_79_5 * (utf8.len(var_79_7) / 11)

				if (11 <= 0 and var_79_5 or var_79_5 * (utf8.len(var_79_7) / 11)) > 0 and var_79_5 < var_79_9 then
					arg_76_1.talkMaxDuration = var_79_9

					if var_79_9 + var_79_4 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_9 + var_79_4
					end
				end

				arg_76_1.text_.text = var_79_7
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318211", "318211018", "story_v_out_318211.awb") ~= 0 then
					local var_79_10 = manager.audio:GetVoiceLength("story_v_out_318211", "318211018", "story_v_out_318211.awb") / 1000

					if var_79_10 + var_79_4 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_10 + var_79_4
					end

					if var_79_6.prefab_name ~= "" and arg_76_1.actors_[var_79_6.prefab_name] ~= nil then
						local var_79_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_6.prefab_name].transform, "story_v_out_318211", "318211018", "story_v_out_318211.awb")

						arg_76_1:RecordAudio("318211018", var_79_11)
						arg_76_1:RecordAudio("318211018", var_79_11)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_318211", "318211018", "story_v_out_318211.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_318211", "318211018", "story_v_out_318211.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_12 = math.max(var_79_5, arg_76_1.talkMaxDuration)

			if var_79_4 <= arg_76_1.time_ and arg_76_1.time_ < var_79_4 + var_79_12 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_4) / var_79_12

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_4 + var_79_12 and arg_76_1.time_ < var_79_4 + var_79_12 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_76_1:InitPlayNodeList()
	end,
	Play318211019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 318211019
		arg_80_1.duration_ = 5.7

		local var_80_0 = {
			zh = 4.5,
			ja = 5.7
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
				arg_80_0:Play318211020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.var_.moveOldPos1150ui_story = arg_80_1.actors_["1150ui_story"].transform.localPosition
			end

			local var_83_0 = 0.001

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_0 then
				arg_80_1.actors_["1150ui_story"].transform.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1150ui_story, Vector3.New(0.7, -1.01, -6.2), (arg_80_1.time_ - 0) / var_83_0)
				arg_80_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_80_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["1150ui_story"].transform.position).z)
				arg_80_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_80_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_80_1.actors_["1150ui_story"].transform.localEulerAngles = arg_80_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			if arg_80_1.time_ >= 0 + var_83_0 and arg_80_1.time_ < 0 + var_83_0 + arg_83_0 then
				arg_80_1.actors_["1150ui_story"].transform.localPosition = Vector3.New(0.7, -1.01, -6.2)
				arg_80_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_80_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["1150ui_story"].transform.position).z)
				arg_80_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_80_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_80_1.actors_["1150ui_story"].transform.localEulerAngles = arg_80_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			local var_83_1 = arg_80_1.actors_["1150ui_story"]

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(var_83_1) and arg_80_1.var_.characterEffect1150ui_story == nil then
				arg_80_1.var_.characterEffect1150ui_story = var_83_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_2 = 0.200000002980232

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_2 and not isNil(var_83_1) then
				if arg_80_1.var_.characterEffect1150ui_story and not isNil(var_83_1) then
					arg_80_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= 0 + var_83_2 and arg_80_1.time_ < 0 + var_83_2 + arg_83_0 and not isNil(var_83_1) and arg_80_1.var_.characterEffect1150ui_story then
				arg_80_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action1_1")
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_83_4 = arg_80_1.actors_["1093ui_story"].transform

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.var_.moveOldPos1093ui_story = var_83_4.localPosition
			end

			local var_83_5 = 0.001

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_5 then
				var_83_4.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1093ui_story, Vector3.New(-0.7, -1.11, -5.88), (arg_80_1.time_ - 0) / var_83_5)
				var_83_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_4.position).x, (manager.ui.mainCamera.transform.position - var_83_4.position).y, (manager.ui.mainCamera.transform.position - var_83_4.position).z)
				var_83_4.localEulerAngles.z = 0
				var_83_4.localEulerAngles.x = 0
				var_83_4.localEulerAngles = var_83_4.localEulerAngles
			end

			if arg_80_1.time_ >= 0 + var_83_5 and arg_80_1.time_ < 0 + var_83_5 + arg_83_0 then
				var_83_4.localPosition = Vector3.New(-0.7, -1.11, -5.88)
				var_83_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_4.position).x, (manager.ui.mainCamera.transform.position - var_83_4.position).y, (manager.ui.mainCamera.transform.position - var_83_4.position).z)
				var_83_4.localEulerAngles.z = 0
				var_83_4.localEulerAngles.x = 0
				var_83_4.localEulerAngles = var_83_4.localEulerAngles
			end

			local var_83_6 = arg_80_1.actors_["1093ui_story"]

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(var_83_6) and arg_80_1.var_.characterEffect1093ui_story == nil then
				arg_80_1.var_.characterEffect1093ui_story = var_83_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_7 = 0.200000002980232

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_7 and not isNil(var_83_6) then
				if arg_80_1.var_.characterEffect1093ui_story and not isNil(var_83_6) then
					arg_80_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_80_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_80_1.time_ - 0) / var_83_7)
				end
			end

			if arg_80_1.time_ >= 0 + var_83_7 and arg_80_1.time_ < 0 + var_83_7 + arg_83_0 and not isNil(var_83_6) and arg_80_1.var_.characterEffect1093ui_story then
				arg_80_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_80_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_83_8 = 0
			local var_83_9 = 0.65

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_8 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_10 = arg_80_1:GetWordFromCfg(318211019)
				local var_83_11 = arg_80_1:FormatText(var_83_10.content)

				arg_80_1.text_.text = var_83_11

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_13 = 26 <= 0 and var_83_9 or var_83_9 * (utf8.len(var_83_11) / 26)

				if (26 <= 0 and var_83_9 or var_83_9 * (utf8.len(var_83_11) / 26)) > 0 and var_83_9 < var_83_13 then
					arg_80_1.talkMaxDuration = var_83_13

					if var_83_13 + var_83_8 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_13 + var_83_8
					end
				end

				arg_80_1.text_.text = var_83_11
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318211", "318211019", "story_v_out_318211.awb") ~= 0 then
					local var_83_14 = manager.audio:GetVoiceLength("story_v_out_318211", "318211019", "story_v_out_318211.awb") / 1000

					if var_83_14 + var_83_8 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_14 + var_83_8
					end

					if var_83_10.prefab_name ~= "" and arg_80_1.actors_[var_83_10.prefab_name] ~= nil then
						local var_83_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_10.prefab_name].transform, "story_v_out_318211", "318211019", "story_v_out_318211.awb")

						arg_80_1:RecordAudio("318211019", var_83_15)
						arg_80_1:RecordAudio("318211019", var_83_15)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_318211", "318211019", "story_v_out_318211.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_318211", "318211019", "story_v_out_318211.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_16 = math.max(var_83_9, arg_80_1.talkMaxDuration)

			if var_83_8 <= arg_80_1.time_ and arg_80_1.time_ < var_83_8 + var_83_16 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_8) / var_83_16

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_8 + var_83_16 and arg_80_1.time_ < var_83_8 + var_83_16 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_80_1:InitPlayNodeList()
	end,
	Play318211020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 318211020
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play318211021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(arg_84_1.actors_["1150ui_story"]) and arg_84_1.var_.characterEffect1150ui_story == nil then
				arg_84_1.var_.characterEffect1150ui_story = arg_84_1.actors_["1150ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_0 = 0.200000002980232

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_0 and not isNil(arg_84_1.actors_["1150ui_story"]) then
				if arg_84_1.var_.characterEffect1150ui_story and not isNil(arg_84_1.actors_["1150ui_story"]) then
					arg_84_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_84_1.var_.characterEffect1150ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_84_1.time_ - 0) / var_87_0)
				end
			end

			if arg_84_1.time_ >= 0 + var_87_0 and arg_84_1.time_ < 0 + var_87_0 + arg_87_0 and not isNil(arg_84_1.actors_["1150ui_story"]) and arg_84_1.var_.characterEffect1150ui_story then
				arg_84_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_84_1.var_.characterEffect1150ui_story.fillRatio = 0.5
			end

			local var_87_1 = 0
			local var_87_2 = 0.6

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, false)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_3 = arg_84_1:FormatText(arg_84_1:GetWordFromCfg(318211020).content)

				arg_84_1.text_.text = var_87_3

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_5 = 24 <= 0 and var_87_2 or var_87_2 * (utf8.len(var_87_3) / 24)

				if (24 <= 0 and var_87_2 or var_87_2 * (utf8.len(var_87_3) / 24)) > 0 and var_87_2 < var_87_5 then
					arg_84_1.talkMaxDuration = var_87_5

					if var_87_5 + var_87_1 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_5 + var_87_1
					end
				end

				arg_84_1.text_.text = var_87_3
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_6 = math.max(var_87_2, arg_84_1.talkMaxDuration)

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_6 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_1) / var_87_6

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_1 + var_87_6 and arg_84_1.time_ < var_87_1 + var_87_6 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play318211021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 318211021
		arg_88_1.duration_ = 7.37

		local var_88_0 = {
			zh = 5.766,
			ja = 7.366
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
				arg_88_0:Play318211022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(arg_88_1.actors_["1150ui_story"]) and arg_88_1.var_.characterEffect1150ui_story == nil then
				arg_88_1.var_.characterEffect1150ui_story = arg_88_1.actors_["1150ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_0 = 0.200000002980232

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_0 and not isNil(arg_88_1.actors_["1150ui_story"]) then
				if arg_88_1.var_.characterEffect1150ui_story and not isNil(arg_88_1.actors_["1150ui_story"]) then
					arg_88_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= 0 + var_91_0 and arg_88_1.time_ < 0 + var_91_0 + arg_91_0 and not isNil(arg_88_1.actors_["1150ui_story"]) and arg_88_1.var_.characterEffect1150ui_story then
				arg_88_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action4_1")
			end

			local var_91_2 = 0
			local var_91_3 = 0.825

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_2 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_4 = arg_88_1:GetWordFromCfg(318211021)
				local var_91_5 = arg_88_1:FormatText(var_91_4.content)

				arg_88_1.text_.text = var_91_5

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_7 = 33 <= 0 and var_91_3 or var_91_3 * (utf8.len(var_91_5) / 33)

				if (33 <= 0 and var_91_3 or var_91_3 * (utf8.len(var_91_5) / 33)) > 0 and var_91_3 < var_91_7 then
					arg_88_1.talkMaxDuration = var_91_7

					if var_91_7 + var_91_2 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_7 + var_91_2
					end
				end

				arg_88_1.text_.text = var_91_5
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318211", "318211021", "story_v_out_318211.awb") ~= 0 then
					local var_91_8 = manager.audio:GetVoiceLength("story_v_out_318211", "318211021", "story_v_out_318211.awb") / 1000

					if var_91_8 + var_91_2 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_8 + var_91_2
					end

					if var_91_4.prefab_name ~= "" and arg_88_1.actors_[var_91_4.prefab_name] ~= nil then
						local var_91_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_4.prefab_name].transform, "story_v_out_318211", "318211021", "story_v_out_318211.awb")

						arg_88_1:RecordAudio("318211021", var_91_9)
						arg_88_1:RecordAudio("318211021", var_91_9)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_318211", "318211021", "story_v_out_318211.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_318211", "318211021", "story_v_out_318211.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_10 = math.max(var_91_3, arg_88_1.talkMaxDuration)

			if var_91_2 <= arg_88_1.time_ and arg_88_1.time_ < var_91_2 + var_91_10 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_2) / var_91_10

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_2 + var_91_10 and arg_88_1.time_ < var_91_2 + var_91_10 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play318211022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 318211022
		arg_92_1.duration_ = 5.27

		local var_92_0 = {
			zh = 5.266,
			ja = 4.666
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
				arg_92_0:Play318211023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(arg_92_1.actors_["1093ui_story"]) and arg_92_1.var_.characterEffect1093ui_story == nil then
				arg_92_1.var_.characterEffect1093ui_story = arg_92_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_0 = 0.200000002980232

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_0 and not isNil(arg_92_1.actors_["1093ui_story"]) then
				if arg_92_1.var_.characterEffect1093ui_story and not isNil(arg_92_1.actors_["1093ui_story"]) then
					arg_92_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= 0 + var_95_0 and arg_92_1.time_ < 0 + var_95_0 + arg_95_0 and not isNil(arg_92_1.actors_["1093ui_story"]) and arg_92_1.var_.characterEffect1093ui_story then
				arg_92_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_95_2 = arg_92_1.actors_["1150ui_story"]

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(var_95_2) and arg_92_1.var_.characterEffect1150ui_story == nil then
				arg_92_1.var_.characterEffect1150ui_story = var_95_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_3 = 0.200000002980232

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_3 and not isNil(var_95_2) then
				if arg_92_1.var_.characterEffect1150ui_story and not isNil(var_95_2) then
					arg_92_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_92_1.var_.characterEffect1150ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_92_1.time_ - 0) / var_95_3)
				end
			end

			if arg_92_1.time_ >= 0 + var_95_3 and arg_92_1.time_ < 0 + var_95_3 + arg_95_0 and not isNil(var_95_2) and arg_92_1.var_.characterEffect1150ui_story then
				arg_92_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_92_1.var_.characterEffect1150ui_story.fillRatio = 0.5
			end

			local var_95_4 = 0
			local var_95_5 = 0.65

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_4 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_6 = arg_92_1:GetWordFromCfg(318211022)
				local var_95_7 = arg_92_1:FormatText(var_95_6.content)

				arg_92_1.text_.text = var_95_7

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_9 = 26 <= 0 and var_95_5 or var_95_5 * (utf8.len(var_95_7) / 26)

				if (26 <= 0 and var_95_5 or var_95_5 * (utf8.len(var_95_7) / 26)) > 0 and var_95_5 < var_95_9 then
					arg_92_1.talkMaxDuration = var_95_9

					if var_95_9 + var_95_4 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_9 + var_95_4
					end
				end

				arg_92_1.text_.text = var_95_7
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318211", "318211022", "story_v_out_318211.awb") ~= 0 then
					local var_95_10 = manager.audio:GetVoiceLength("story_v_out_318211", "318211022", "story_v_out_318211.awb") / 1000

					if var_95_10 + var_95_4 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_10 + var_95_4
					end

					if var_95_6.prefab_name ~= "" and arg_92_1.actors_[var_95_6.prefab_name] ~= nil then
						local var_95_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_6.prefab_name].transform, "story_v_out_318211", "318211022", "story_v_out_318211.awb")

						arg_92_1:RecordAudio("318211022", var_95_11)
						arg_92_1:RecordAudio("318211022", var_95_11)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_318211", "318211022", "story_v_out_318211.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_318211", "318211022", "story_v_out_318211.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_12 = math.max(var_95_5, arg_92_1.talkMaxDuration)

			if var_95_4 <= arg_92_1.time_ and arg_92_1.time_ < var_95_4 + var_95_12 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_4) / var_95_12

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_4 + var_95_12 and arg_92_1.time_ < var_95_4 + var_95_12 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play318211023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 318211023
		arg_96_1.duration_ = 7.97

		local var_96_0 = {
			zh = 3.2,
			ja = 7.966
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
				arg_96_0:Play318211024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(arg_96_1.actors_["1150ui_story"]) and arg_96_1.var_.characterEffect1150ui_story == nil then
				arg_96_1.var_.characterEffect1150ui_story = arg_96_1.actors_["1150ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_0 = 0.200000002980232

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_0 and not isNil(arg_96_1.actors_["1150ui_story"]) then
				if arg_96_1.var_.characterEffect1150ui_story and not isNil(arg_96_1.actors_["1150ui_story"]) then
					arg_96_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= 0 + var_99_0 and arg_96_1.time_ < 0 + var_99_0 + arg_99_0 and not isNil(arg_96_1.actors_["1150ui_story"]) and arg_96_1.var_.characterEffect1150ui_story then
				arg_96_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_99_2 = arg_96_1.actors_["1093ui_story"]

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(var_99_2) and arg_96_1.var_.characterEffect1093ui_story == nil then
				arg_96_1.var_.characterEffect1093ui_story = var_99_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_3 = 0.200000002980232

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_3 and not isNil(var_99_2) then
				if arg_96_1.var_.characterEffect1093ui_story and not isNil(var_99_2) then
					arg_96_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_96_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_96_1.time_ - 0) / var_99_3)
				end
			end

			if arg_96_1.time_ >= 0 + var_99_3 and arg_96_1.time_ < 0 + var_99_3 + arg_99_0 and not isNil(var_99_2) and arg_96_1.var_.characterEffect1093ui_story then
				arg_96_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_96_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_99_4 = 0
			local var_99_5 = 0.325

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_4 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_6 = arg_96_1:GetWordFromCfg(318211023)
				local var_99_7 = arg_96_1:FormatText(var_99_6.content)

				arg_96_1.text_.text = var_99_7

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_9 = 13 <= 0 and var_99_5 or var_99_5 * (utf8.len(var_99_7) / 13)

				if (13 <= 0 and var_99_5 or var_99_5 * (utf8.len(var_99_7) / 13)) > 0 and var_99_5 < var_99_9 then
					arg_96_1.talkMaxDuration = var_99_9

					if var_99_9 + var_99_4 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_9 + var_99_4
					end
				end

				arg_96_1.text_.text = var_99_7
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318211", "318211023", "story_v_out_318211.awb") ~= 0 then
					local var_99_10 = manager.audio:GetVoiceLength("story_v_out_318211", "318211023", "story_v_out_318211.awb") / 1000

					if var_99_10 + var_99_4 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_10 + var_99_4
					end

					if var_99_6.prefab_name ~= "" and arg_96_1.actors_[var_99_6.prefab_name] ~= nil then
						local var_99_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_6.prefab_name].transform, "story_v_out_318211", "318211023", "story_v_out_318211.awb")

						arg_96_1:RecordAudio("318211023", var_99_11)
						arg_96_1:RecordAudio("318211023", var_99_11)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_318211", "318211023", "story_v_out_318211.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_318211", "318211023", "story_v_out_318211.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_12 = math.max(var_99_5, arg_96_1.talkMaxDuration)

			if var_99_4 <= arg_96_1.time_ and arg_96_1.time_ < var_99_4 + var_99_12 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_4) / var_99_12

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_4 + var_99_12 and arg_96_1.time_ < var_99_4 + var_99_12 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play318211024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 318211024
		arg_100_1.duration_ = 3.97

		local var_100_0 = {
			zh = 3.966,
			ja = 1.999999999999
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
				arg_100_0:Play318211025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.var_.moveOldPos1199ui_story = arg_100_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_103_0 = 0.001

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_0 then
				arg_100_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos1199ui_story, Vector3.New(0, -1.08, -5.9), (arg_100_1.time_ - 0) / var_103_0)
				arg_100_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_100_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_100_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_100_1.actors_["1199ui_story"].transform.position).z)
				arg_100_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_100_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_100_1.actors_["1199ui_story"].transform.localEulerAngles = arg_100_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_100_1.time_ >= 0 + var_103_0 and arg_100_1.time_ < 0 + var_103_0 + arg_103_0 then
				arg_100_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(0, -1.08, -5.9)
				arg_100_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_100_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_100_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_100_1.actors_["1199ui_story"].transform.position).z)
				arg_100_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_100_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_100_1.actors_["1199ui_story"].transform.localEulerAngles = arg_100_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			local var_103_1 = arg_100_1.actors_["1199ui_story"]

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(var_103_1) and arg_100_1.var_.characterEffect1199ui_story == nil then
				arg_100_1.var_.characterEffect1199ui_story = var_103_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_2 = 0.200000002980232

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_2 and not isNil(var_103_1) then
				if arg_100_1.var_.characterEffect1199ui_story and not isNil(var_103_1) then
					arg_100_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_100_1.time_ >= 0 + var_103_2 and arg_100_1.time_ < 0 + var_103_2 + arg_103_0 and not isNil(var_103_1) and arg_100_1.var_.characterEffect1199ui_story then
				arg_100_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1199/story1199action/1199action1_1")
			end

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_103_4 = arg_100_1.actors_["1150ui_story"].transform

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.var_.moveOldPos1150ui_story = var_103_4.localPosition
			end

			local var_103_5 = 0.001

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_5 then
				var_103_4.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos1150ui_story, Vector3.New(0, 100, 0), (arg_100_1.time_ - 0) / var_103_5)
				var_103_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_103_4.position).x, (manager.ui.mainCamera.transform.position - var_103_4.position).y, (manager.ui.mainCamera.transform.position - var_103_4.position).z)
				var_103_4.localEulerAngles.z = 0
				var_103_4.localEulerAngles.x = 0
				var_103_4.localEulerAngles = var_103_4.localEulerAngles
			end

			if arg_100_1.time_ >= 0 + var_103_5 and arg_100_1.time_ < 0 + var_103_5 + arg_103_0 then
				var_103_4.localPosition = Vector3.New(0, 100, 0)
				var_103_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_103_4.position).x, (manager.ui.mainCamera.transform.position - var_103_4.position).y, (manager.ui.mainCamera.transform.position - var_103_4.position).z)
				var_103_4.localEulerAngles.z = 0
				var_103_4.localEulerAngles.x = 0
				var_103_4.localEulerAngles = var_103_4.localEulerAngles
			end

			local var_103_6 = arg_100_1.actors_["1150ui_story"]

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(var_103_6) and arg_100_1.var_.characterEffect1150ui_story == nil then
				arg_100_1.var_.characterEffect1150ui_story = var_103_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_7 = 0.200000002980232

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_7 and not isNil(var_103_6) then
				if arg_100_1.var_.characterEffect1150ui_story and not isNil(var_103_6) then
					arg_100_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_100_1.var_.characterEffect1150ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_100_1.time_ - 0) / var_103_7)
				end
			end

			if arg_100_1.time_ >= 0 + var_103_7 and arg_100_1.time_ < 0 + var_103_7 + arg_103_0 and not isNil(var_103_6) and arg_100_1.var_.characterEffect1150ui_story then
				arg_100_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_100_1.var_.characterEffect1150ui_story.fillRatio = 0.5
			end

			local var_103_8 = arg_100_1.actors_["1093ui_story"].transform

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.var_.moveOldPos1093ui_story = var_103_8.localPosition
			end

			local var_103_9 = 0.001

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_9 then
				var_103_8.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_100_1.time_ - 0) / var_103_9)
				var_103_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_103_8.position).x, (manager.ui.mainCamera.transform.position - var_103_8.position).y, (manager.ui.mainCamera.transform.position - var_103_8.position).z)
				var_103_8.localEulerAngles.z = 0
				var_103_8.localEulerAngles.x = 0
				var_103_8.localEulerAngles = var_103_8.localEulerAngles
			end

			if arg_100_1.time_ >= 0 + var_103_9 and arg_100_1.time_ < 0 + var_103_9 + arg_103_0 then
				var_103_8.localPosition = Vector3.New(0, 100, 0)
				var_103_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_103_8.position).x, (manager.ui.mainCamera.transform.position - var_103_8.position).y, (manager.ui.mainCamera.transform.position - var_103_8.position).z)
				var_103_8.localEulerAngles.z = 0
				var_103_8.localEulerAngles.x = 0
				var_103_8.localEulerAngles = var_103_8.localEulerAngles
			end

			local var_103_10 = 0
			local var_103_11 = 0.475

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_10 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_12 = arg_100_1:GetWordFromCfg(318211024)
				local var_103_13 = arg_100_1:FormatText(var_103_12.content)

				arg_100_1.text_.text = var_103_13

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_15 = 19 <= 0 and var_103_11 or var_103_11 * (utf8.len(var_103_13) / 19)

				if (19 <= 0 and var_103_11 or var_103_11 * (utf8.len(var_103_13) / 19)) > 0 and var_103_11 < var_103_15 then
					arg_100_1.talkMaxDuration = var_103_15

					if var_103_15 + var_103_10 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_15 + var_103_10
					end
				end

				arg_100_1.text_.text = var_103_13
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318211", "318211024", "story_v_out_318211.awb") ~= 0 then
					local var_103_16 = manager.audio:GetVoiceLength("story_v_out_318211", "318211024", "story_v_out_318211.awb") / 1000

					if var_103_16 + var_103_10 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_16 + var_103_10
					end

					if var_103_12.prefab_name ~= "" and arg_100_1.actors_[var_103_12.prefab_name] ~= nil then
						local var_103_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_12.prefab_name].transform, "story_v_out_318211", "318211024", "story_v_out_318211.awb")

						arg_100_1:RecordAudio("318211024", var_103_17)
						arg_100_1:RecordAudio("318211024", var_103_17)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_318211", "318211024", "story_v_out_318211.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_318211", "318211024", "story_v_out_318211.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_18 = math.max(var_103_11, arg_100_1.talkMaxDuration)

			if var_103_10 <= arg_100_1.time_ and arg_100_1.time_ < var_103_10 + var_103_18 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_10) / var_103_18

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_10 + var_103_18 and arg_100_1.time_ < var_103_10 + var_103_18 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_100_1:InitPlayNodeList()
	end,
	Play318211025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 318211025
		arg_104_1.duration_ = 13.2

		local var_104_0 = {
			zh = 10.633,
			ja = 13.2
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
				arg_104_0:Play318211026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.var_.moveOldPos1150ui_story = arg_104_1.actors_["1150ui_story"].transform.localPosition
			end

			local var_107_0 = 0.001

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_0 then
				arg_104_1.actors_["1150ui_story"].transform.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1150ui_story, Vector3.New(0.7, -1.01, -6.2), (arg_104_1.time_ - 0) / var_107_0)
				arg_104_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_104_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["1150ui_story"].transform.position).z)
				arg_104_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_104_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_104_1.actors_["1150ui_story"].transform.localEulerAngles = arg_104_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			if arg_104_1.time_ >= 0 + var_107_0 and arg_104_1.time_ < 0 + var_107_0 + arg_107_0 then
				arg_104_1.actors_["1150ui_story"].transform.localPosition = Vector3.New(0.7, -1.01, -6.2)
				arg_104_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_104_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["1150ui_story"].transform.position).z)
				arg_104_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_104_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_104_1.actors_["1150ui_story"].transform.localEulerAngles = arg_104_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			local var_107_1 = arg_104_1.actors_["1150ui_story"]

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(var_107_1) and arg_104_1.var_.characterEffect1150ui_story == nil then
				arg_104_1.var_.characterEffect1150ui_story = var_107_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_2 = 0.200000002980232

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_2 and not isNil(var_107_1) then
				if arg_104_1.var_.characterEffect1150ui_story and not isNil(var_107_1) then
					arg_104_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= 0 + var_107_2 and arg_104_1.time_ < 0 + var_107_2 + arg_107_0 and not isNil(var_107_1) and arg_104_1.var_.characterEffect1150ui_story then
				arg_104_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action4_1")
			end

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_107_4 = arg_104_1.actors_["1199ui_story"].transform

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.var_.moveOldPos1199ui_story = var_107_4.localPosition
			end

			local var_107_5 = 0.001

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_5 then
				var_107_4.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1199ui_story, Vector3.New(0, 100, 0), (arg_104_1.time_ - 0) / var_107_5)
				var_107_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_107_4.position).x, (manager.ui.mainCamera.transform.position - var_107_4.position).y, (manager.ui.mainCamera.transform.position - var_107_4.position).z)
				var_107_4.localEulerAngles.z = 0
				var_107_4.localEulerAngles.x = 0
				var_107_4.localEulerAngles = var_107_4.localEulerAngles
			end

			if arg_104_1.time_ >= 0 + var_107_5 and arg_104_1.time_ < 0 + var_107_5 + arg_107_0 then
				var_107_4.localPosition = Vector3.New(0, 100, 0)
				var_107_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_107_4.position).x, (manager.ui.mainCamera.transform.position - var_107_4.position).y, (manager.ui.mainCamera.transform.position - var_107_4.position).z)
				var_107_4.localEulerAngles.z = 0
				var_107_4.localEulerAngles.x = 0
				var_107_4.localEulerAngles = var_107_4.localEulerAngles
			end

			local var_107_6 = arg_104_1.actors_["1199ui_story"]

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(var_107_6) and arg_104_1.var_.characterEffect1199ui_story == nil then
				arg_104_1.var_.characterEffect1199ui_story = var_107_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_7 = 0.200000002980232

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_7 and not isNil(var_107_6) then
				if arg_104_1.var_.characterEffect1199ui_story and not isNil(var_107_6) then
					arg_104_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_104_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_104_1.time_ - 0) / var_107_7)
				end
			end

			if arg_104_1.time_ >= 0 + var_107_7 and arg_104_1.time_ < 0 + var_107_7 + arg_107_0 and not isNil(var_107_6) and arg_104_1.var_.characterEffect1199ui_story then
				arg_104_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_104_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_107_8 = arg_104_1.actors_["1093ui_story"].transform

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.var_.moveOldPos1093ui_story = var_107_8.localPosition
			end

			local var_107_9 = 0.001

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_9 then
				var_107_8.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1093ui_story, Vector3.New(-0.7, -1.11, -5.88), (arg_104_1.time_ - 0) / var_107_9)
				var_107_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_107_8.position).x, (manager.ui.mainCamera.transform.position - var_107_8.position).y, (manager.ui.mainCamera.transform.position - var_107_8.position).z)
				var_107_8.localEulerAngles.z = 0
				var_107_8.localEulerAngles.x = 0
				var_107_8.localEulerAngles = var_107_8.localEulerAngles
			end

			if arg_104_1.time_ >= 0 + var_107_9 and arg_104_1.time_ < 0 + var_107_9 + arg_107_0 then
				var_107_8.localPosition = Vector3.New(-0.7, -1.11, -5.88)
				var_107_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_107_8.position).x, (manager.ui.mainCamera.transform.position - var_107_8.position).y, (manager.ui.mainCamera.transform.position - var_107_8.position).z)
				var_107_8.localEulerAngles.z = 0
				var_107_8.localEulerAngles.x = 0
				var_107_8.localEulerAngles = var_107_8.localEulerAngles
			end

			local var_107_10 = 0
			local var_107_11 = 1.1

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_10 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_12 = arg_104_1:GetWordFromCfg(318211025)
				local var_107_13 = arg_104_1:FormatText(var_107_12.content)

				arg_104_1.text_.text = var_107_13

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_15 = 44 <= 0 and var_107_11 or var_107_11 * (utf8.len(var_107_13) / 44)

				if (44 <= 0 and var_107_11 or var_107_11 * (utf8.len(var_107_13) / 44)) > 0 and var_107_11 < var_107_15 then
					arg_104_1.talkMaxDuration = var_107_15

					if var_107_15 + var_107_10 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_15 + var_107_10
					end
				end

				arg_104_1.text_.text = var_107_13
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318211", "318211025", "story_v_out_318211.awb") ~= 0 then
					local var_107_16 = manager.audio:GetVoiceLength("story_v_out_318211", "318211025", "story_v_out_318211.awb") / 1000

					if var_107_16 + var_107_10 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_16 + var_107_10
					end

					if var_107_12.prefab_name ~= "" and arg_104_1.actors_[var_107_12.prefab_name] ~= nil then
						local var_107_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_12.prefab_name].transform, "story_v_out_318211", "318211025", "story_v_out_318211.awb")

						arg_104_1:RecordAudio("318211025", var_107_17)
						arg_104_1:RecordAudio("318211025", var_107_17)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_318211", "318211025", "story_v_out_318211.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_318211", "318211025", "story_v_out_318211.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_18 = math.max(var_107_11, arg_104_1.talkMaxDuration)

			if var_107_10 <= arg_104_1.time_ and arg_104_1.time_ < var_107_10 + var_107_18 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_10) / var_107_18

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_10 + var_107_18 and arg_104_1.time_ < var_107_10 + var_107_18 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_104_1:InitPlayNodeList()
	end,
	Play318211026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 318211026
		arg_108_1.duration_ = 4.43

		local var_108_0 = {
			zh = 1.966,
			ja = 4.433
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
				arg_108_0:Play318211027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 0.2

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_1 = arg_108_1:GetWordFromCfg(318211026)
				local var_111_2 = arg_108_1:FormatText(var_111_1.content)

				arg_108_1.text_.text = var_111_2

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_4 = 8 <= 0 and var_111_0 or var_111_0 * (utf8.len(var_111_2) / 8)

				if (8 <= 0 and var_111_0 or var_111_0 * (utf8.len(var_111_2) / 8)) > 0 and var_111_0 < var_111_4 then
					arg_108_1.talkMaxDuration = var_111_4

					if var_111_4 + 0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_4 + 0
					end
				end

				arg_108_1.text_.text = var_111_2
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318211", "318211026", "story_v_out_318211.awb") ~= 0 then
					local var_111_5 = manager.audio:GetVoiceLength("story_v_out_318211", "318211026", "story_v_out_318211.awb") / 1000

					if var_111_5 + 0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_5 + 0
					end

					if var_111_1.prefab_name ~= "" and arg_108_1.actors_[var_111_1.prefab_name] ~= nil then
						local var_111_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_1.prefab_name].transform, "story_v_out_318211", "318211026", "story_v_out_318211.awb")

						arg_108_1:RecordAudio("318211026", var_111_6)
						arg_108_1:RecordAudio("318211026", var_111_6)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_318211", "318211026", "story_v_out_318211.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_318211", "318211026", "story_v_out_318211.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_7 = math.max(var_111_0, arg_108_1.talkMaxDuration)

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_7 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - 0) / var_111_7

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= 0 + var_111_7 and arg_108_1.time_ < 0 + var_111_7 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play318211027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 318211027
		arg_112_1.duration_ = 9.4

		local var_112_0 = {
			zh = 6.1,
			ja = 9.4
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
				arg_112_0:Play318211028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(arg_112_1.actors_["1093ui_story"]) and arg_112_1.var_.characterEffect1093ui_story == nil then
				arg_112_1.var_.characterEffect1093ui_story = arg_112_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_0 = 0.200000002980232

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_0 and not isNil(arg_112_1.actors_["1093ui_story"]) then
				if arg_112_1.var_.characterEffect1093ui_story and not isNil(arg_112_1.actors_["1093ui_story"]) then
					arg_112_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_112_1.time_ >= 0 + var_115_0 and arg_112_1.time_ < 0 + var_115_0 + arg_115_0 and not isNil(arg_112_1.actors_["1093ui_story"]) and arg_112_1.var_.characterEffect1093ui_story then
				arg_112_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action6_1")
			end

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_115_2 = arg_112_1.actors_["1150ui_story"]

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(var_115_2) and arg_112_1.var_.characterEffect1150ui_story == nil then
				arg_112_1.var_.characterEffect1150ui_story = var_115_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_3 = 0.200000002980232

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_3 and not isNil(var_115_2) then
				if arg_112_1.var_.characterEffect1150ui_story and not isNil(var_115_2) then
					arg_112_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_112_1.var_.characterEffect1150ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_112_1.time_ - 0) / var_115_3)
				end
			end

			if arg_112_1.time_ >= 0 + var_115_3 and arg_112_1.time_ < 0 + var_115_3 + arg_115_0 and not isNil(var_115_2) and arg_112_1.var_.characterEffect1150ui_story then
				arg_112_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_112_1.var_.characterEffect1150ui_story.fillRatio = 0.5
			end

			local var_115_4 = 0
			local var_115_5 = 0.8

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_4 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_6 = arg_112_1:GetWordFromCfg(318211027)
				local var_115_7 = arg_112_1:FormatText(var_115_6.content)

				arg_112_1.text_.text = var_115_7

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_9 = 32 <= 0 and var_115_5 or var_115_5 * (utf8.len(var_115_7) / 32)

				if (32 <= 0 and var_115_5 or var_115_5 * (utf8.len(var_115_7) / 32)) > 0 and var_115_5 < var_115_9 then
					arg_112_1.talkMaxDuration = var_115_9

					if var_115_9 + var_115_4 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_9 + var_115_4
					end
				end

				arg_112_1.text_.text = var_115_7
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318211", "318211027", "story_v_out_318211.awb") ~= 0 then
					local var_115_10 = manager.audio:GetVoiceLength("story_v_out_318211", "318211027", "story_v_out_318211.awb") / 1000

					if var_115_10 + var_115_4 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_10 + var_115_4
					end

					if var_115_6.prefab_name ~= "" and arg_112_1.actors_[var_115_6.prefab_name] ~= nil then
						local var_115_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_6.prefab_name].transform, "story_v_out_318211", "318211027", "story_v_out_318211.awb")

						arg_112_1:RecordAudio("318211027", var_115_11)
						arg_112_1:RecordAudio("318211027", var_115_11)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_318211", "318211027", "story_v_out_318211.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_318211", "318211027", "story_v_out_318211.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_12 = math.max(var_115_5, arg_112_1.talkMaxDuration)

			if var_115_4 <= arg_112_1.time_ and arg_112_1.time_ < var_115_4 + var_115_12 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_4) / var_115_12

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_4 + var_115_12 and arg_112_1.time_ < var_115_4 + var_115_12 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play318211028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 318211028
		arg_116_1.duration_ = 9.3

		local var_116_0 = {
			zh = 7,
			ja = 9.3
		}
		local var_116_1 = manager.audio:GetLocalizationFlag()

		if var_116_0[var_116_1] ~= nil then
			arg_116_1.duration_ = var_116_0[var_116_1]
		end

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play318211029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.var_.moveOldPos1199ui_story = arg_116_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_119_0 = 0.001

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_0 then
				arg_116_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1199ui_story, Vector3.New(0, -1.08, -5.9), (arg_116_1.time_ - 0) / var_119_0)
				arg_116_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_116_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["1199ui_story"].transform.position).z)
				arg_116_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_116_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_116_1.actors_["1199ui_story"].transform.localEulerAngles = arg_116_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_116_1.time_ >= 0 + var_119_0 and arg_116_1.time_ < 0 + var_119_0 + arg_119_0 then
				arg_116_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(0, -1.08, -5.9)
				arg_116_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_116_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["1199ui_story"].transform.position).z)
				arg_116_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_116_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_116_1.actors_["1199ui_story"].transform.localEulerAngles = arg_116_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			local var_119_1 = arg_116_1.actors_["1199ui_story"]

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(var_119_1) and arg_116_1.var_.characterEffect1199ui_story == nil then
				arg_116_1.var_.characterEffect1199ui_story = var_119_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_2 = 0.200000002980232

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_2 and not isNil(var_119_1) then
				if arg_116_1.var_.characterEffect1199ui_story and not isNil(var_119_1) then
					arg_116_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= 0 + var_119_2 and arg_116_1.time_ < 0 + var_119_2 + arg_119_0 and not isNil(var_119_1) and arg_116_1.var_.characterEffect1199ui_story then
				arg_116_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1199/story1199action/1199action4_1")
			end

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_119_4 = arg_116_1.actors_["1093ui_story"].transform

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.var_.moveOldPos1093ui_story = var_119_4.localPosition
			end

			local var_119_5 = 0.001

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_5 then
				var_119_4.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_116_1.time_ - 0) / var_119_5)
				var_119_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_119_4.position).x, (manager.ui.mainCamera.transform.position - var_119_4.position).y, (manager.ui.mainCamera.transform.position - var_119_4.position).z)
				var_119_4.localEulerAngles.z = 0
				var_119_4.localEulerAngles.x = 0
				var_119_4.localEulerAngles = var_119_4.localEulerAngles
			end

			if arg_116_1.time_ >= 0 + var_119_5 and arg_116_1.time_ < 0 + var_119_5 + arg_119_0 then
				var_119_4.localPosition = Vector3.New(0, 100, 0)
				var_119_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_119_4.position).x, (manager.ui.mainCamera.transform.position - var_119_4.position).y, (manager.ui.mainCamera.transform.position - var_119_4.position).z)
				var_119_4.localEulerAngles.z = 0
				var_119_4.localEulerAngles.x = 0
				var_119_4.localEulerAngles = var_119_4.localEulerAngles
			end

			local var_119_6 = arg_116_1.actors_["1093ui_story"]

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(var_119_6) and arg_116_1.var_.characterEffect1093ui_story == nil then
				arg_116_1.var_.characterEffect1093ui_story = var_119_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_7 = 0.200000002980232

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_7 and not isNil(var_119_6) then
				if arg_116_1.var_.characterEffect1093ui_story and not isNil(var_119_6) then
					arg_116_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_116_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_116_1.time_ - 0) / var_119_7)
				end
			end

			if arg_116_1.time_ >= 0 + var_119_7 and arg_116_1.time_ < 0 + var_119_7 + arg_119_0 and not isNil(var_119_6) and arg_116_1.var_.characterEffect1093ui_story then
				arg_116_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_116_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_119_8 = arg_116_1.actors_["1150ui_story"].transform

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.var_.moveOldPos1150ui_story = var_119_8.localPosition
			end

			local var_119_9 = 0.001

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_9 then
				var_119_8.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1150ui_story, Vector3.New(0, 100, 0), (arg_116_1.time_ - 0) / var_119_9)
				var_119_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_119_8.position).x, (manager.ui.mainCamera.transform.position - var_119_8.position).y, (manager.ui.mainCamera.transform.position - var_119_8.position).z)
				var_119_8.localEulerAngles.z = 0
				var_119_8.localEulerAngles.x = 0
				var_119_8.localEulerAngles = var_119_8.localEulerAngles
			end

			if arg_116_1.time_ >= 0 + var_119_9 and arg_116_1.time_ < 0 + var_119_9 + arg_119_0 then
				var_119_8.localPosition = Vector3.New(0, 100, 0)
				var_119_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_119_8.position).x, (manager.ui.mainCamera.transform.position - var_119_8.position).y, (manager.ui.mainCamera.transform.position - var_119_8.position).z)
				var_119_8.localEulerAngles.z = 0
				var_119_8.localEulerAngles.x = 0
				var_119_8.localEulerAngles = var_119_8.localEulerAngles
			end

			local var_119_10 = 0
			local var_119_11 = 0.8

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_10 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_12 = arg_116_1:GetWordFromCfg(318211028)
				local var_119_13 = arg_116_1:FormatText(var_119_12.content)

				arg_116_1.text_.text = var_119_13

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_15 = 32 <= 0 and var_119_11 or var_119_11 * (utf8.len(var_119_13) / 32)

				if (32 <= 0 and var_119_11 or var_119_11 * (utf8.len(var_119_13) / 32)) > 0 and var_119_11 < var_119_15 then
					arg_116_1.talkMaxDuration = var_119_15

					if var_119_15 + var_119_10 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_15 + var_119_10
					end
				end

				arg_116_1.text_.text = var_119_13
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318211", "318211028", "story_v_out_318211.awb") ~= 0 then
					local var_119_16 = manager.audio:GetVoiceLength("story_v_out_318211", "318211028", "story_v_out_318211.awb") / 1000

					if var_119_16 + var_119_10 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_16 + var_119_10
					end

					if var_119_12.prefab_name ~= "" and arg_116_1.actors_[var_119_12.prefab_name] ~= nil then
						local var_119_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_12.prefab_name].transform, "story_v_out_318211", "318211028", "story_v_out_318211.awb")

						arg_116_1:RecordAudio("318211028", var_119_17)
						arg_116_1:RecordAudio("318211028", var_119_17)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_318211", "318211028", "story_v_out_318211.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_318211", "318211028", "story_v_out_318211.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_18 = math.max(var_119_11, arg_116_1.talkMaxDuration)

			if var_119_10 <= arg_116_1.time_ and arg_116_1.time_ < var_119_10 + var_119_18 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_10) / var_119_18

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_10 + var_119_18 and arg_116_1.time_ < var_119_10 + var_119_18 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_116_1:InitPlayNodeList()
	end,
	Play318211029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 318211029
		arg_120_1.duration_ = 2.63

		local var_120_0 = {
			zh = 2.366,
			ja = 2.633
		}
		local var_120_1 = manager.audio:GetLocalizationFlag()

		if var_120_0[var_120_1] ~= nil then
			arg_120_1.duration_ = var_120_0[var_120_1]
		end

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play318211030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 0.275

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_1 = arg_120_1:GetWordFromCfg(318211029)
				local var_123_2 = arg_120_1:FormatText(var_123_1.content)

				arg_120_1.text_.text = var_123_2

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_4 = 11 <= 0 and var_123_0 or var_123_0 * (utf8.len(var_123_2) / 11)

				if (11 <= 0 and var_123_0 or var_123_0 * (utf8.len(var_123_2) / 11)) > 0 and var_123_0 < var_123_4 then
					arg_120_1.talkMaxDuration = var_123_4

					if var_123_4 + 0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_4 + 0
					end
				end

				arg_120_1.text_.text = var_123_2
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318211", "318211029", "story_v_out_318211.awb") ~= 0 then
					local var_123_5 = manager.audio:GetVoiceLength("story_v_out_318211", "318211029", "story_v_out_318211.awb") / 1000

					if var_123_5 + 0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_5 + 0
					end

					if var_123_1.prefab_name ~= "" and arg_120_1.actors_[var_123_1.prefab_name] ~= nil then
						local var_123_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_1.prefab_name].transform, "story_v_out_318211", "318211029", "story_v_out_318211.awb")

						arg_120_1:RecordAudio("318211029", var_123_6)
						arg_120_1:RecordAudio("318211029", var_123_6)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_318211", "318211029", "story_v_out_318211.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_318211", "318211029", "story_v_out_318211.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_7 = math.max(var_123_0, arg_120_1.talkMaxDuration)

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_7 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - 0) / var_123_7

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= 0 + var_123_7 and arg_120_1.time_ < 0 + var_123_7 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play318211030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 318211030
		arg_124_1.duration_ = 5.87

		local var_124_0 = {
			zh = 5.1,
			ja = 5.866
		}
		local var_124_1 = manager.audio:GetLocalizationFlag()

		if var_124_0[var_124_1] ~= nil then
			arg_124_1.duration_ = var_124_0[var_124_1]
		end

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play318211031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.var_.moveOldPos1093ui_story = arg_124_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_127_0 = 0.001

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_0 then
				arg_124_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos1093ui_story, Vector3.New(0.7, -1.11, -5.88), (arg_124_1.time_ - 0) / var_127_0)
				arg_124_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_124_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["1093ui_story"].transform.position).z)
				arg_124_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_124_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_124_1.actors_["1093ui_story"].transform.localEulerAngles = arg_124_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_124_1.time_ >= 0 + var_127_0 and arg_124_1.time_ < 0 + var_127_0 + arg_127_0 then
				arg_124_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0.7, -1.11, -5.88)
				arg_124_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_124_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["1093ui_story"].transform.position).z)
				arg_124_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_124_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_124_1.actors_["1093ui_story"].transform.localEulerAngles = arg_124_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_127_1 = arg_124_1.actors_["1093ui_story"]

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(var_127_1) and arg_124_1.var_.characterEffect1093ui_story == nil then
				arg_124_1.var_.characterEffect1093ui_story = var_127_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_2 = 0.200000002980232

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_2 and not isNil(var_127_1) then
				if arg_124_1.var_.characterEffect1093ui_story and not isNil(var_127_1) then
					arg_124_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_124_1.time_ >= 0 + var_127_2 and arg_124_1.time_ < 0 + var_127_2 + arg_127_0 and not isNil(var_127_1) and arg_124_1.var_.characterEffect1093ui_story then
				arg_124_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_127_4 = arg_124_1.actors_["1199ui_story"].transform

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.var_.moveOldPos1199ui_story = var_127_4.localPosition
			end

			local var_127_5 = 0.001

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_5 then
				var_127_4.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos1199ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_124_1.time_ - 0) / var_127_5)
				var_127_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_127_4.position).x, (manager.ui.mainCamera.transform.position - var_127_4.position).y, (manager.ui.mainCamera.transform.position - var_127_4.position).z)
				var_127_4.localEulerAngles.z = 0
				var_127_4.localEulerAngles.x = 0
				var_127_4.localEulerAngles = var_127_4.localEulerAngles
			end

			if arg_124_1.time_ >= 0 + var_127_5 and arg_124_1.time_ < 0 + var_127_5 + arg_127_0 then
				var_127_4.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				var_127_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_127_4.position).x, (manager.ui.mainCamera.transform.position - var_127_4.position).y, (manager.ui.mainCamera.transform.position - var_127_4.position).z)
				var_127_4.localEulerAngles.z = 0
				var_127_4.localEulerAngles.x = 0
				var_127_4.localEulerAngles = var_127_4.localEulerAngles
			end

			local var_127_6 = arg_124_1.actors_["1199ui_story"]

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(var_127_6) and arg_124_1.var_.characterEffect1199ui_story == nil then
				arg_124_1.var_.characterEffect1199ui_story = var_127_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_7 = 0.200000002980232

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_7 and not isNil(var_127_6) then
				if arg_124_1.var_.characterEffect1199ui_story and not isNil(var_127_6) then
					arg_124_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_124_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_124_1.time_ - 0) / var_127_7)
				end
			end

			if arg_124_1.time_ >= 0 + var_127_7 and arg_124_1.time_ < 0 + var_127_7 + arg_127_0 and not isNil(var_127_6) and arg_124_1.var_.characterEffect1199ui_story then
				arg_124_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_124_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_127_8 = 0
			local var_127_9 = 0.7

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_8 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_10 = arg_124_1:GetWordFromCfg(318211030)
				local var_127_11 = arg_124_1:FormatText(var_127_10.content)

				arg_124_1.text_.text = var_127_11

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_13 = 28 <= 0 and var_127_9 or var_127_9 * (utf8.len(var_127_11) / 28)

				if (28 <= 0 and var_127_9 or var_127_9 * (utf8.len(var_127_11) / 28)) > 0 and var_127_9 < var_127_13 then
					arg_124_1.talkMaxDuration = var_127_13

					if var_127_13 + var_127_8 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_13 + var_127_8
					end
				end

				arg_124_1.text_.text = var_127_11
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318211", "318211030", "story_v_out_318211.awb") ~= 0 then
					local var_127_14 = manager.audio:GetVoiceLength("story_v_out_318211", "318211030", "story_v_out_318211.awb") / 1000

					if var_127_14 + var_127_8 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_14 + var_127_8
					end

					if var_127_10.prefab_name ~= "" and arg_124_1.actors_[var_127_10.prefab_name] ~= nil then
						local var_127_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_10.prefab_name].transform, "story_v_out_318211", "318211030", "story_v_out_318211.awb")

						arg_124_1:RecordAudio("318211030", var_127_15)
						arg_124_1:RecordAudio("318211030", var_127_15)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_318211", "318211030", "story_v_out_318211.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_318211", "318211030", "story_v_out_318211.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_16 = math.max(var_127_9, arg_124_1.talkMaxDuration)

			if var_127_8 <= arg_124_1.time_ and arg_124_1.time_ < var_127_8 + var_127_16 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_8) / var_127_16

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_8 + var_127_16 and arg_124_1.time_ < var_127_8 + var_127_16 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_124_1:InitPlayNodeList()
	end,
	Play318211031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 318211031
		arg_128_1.duration_ = 5.33

		local var_128_0 = {
			zh = 5.333,
			ja = 4.766
		}
		local var_128_1 = manager.audio:GetLocalizationFlag()

		if var_128_0[var_128_1] ~= nil then
			arg_128_1.duration_ = var_128_0[var_128_1]
		end

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play318211032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(arg_128_1.actors_["1093ui_story"]) and arg_128_1.var_.characterEffect1093ui_story == nil then
				arg_128_1.var_.characterEffect1093ui_story = arg_128_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_0 = 0.200000002980232

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_0 and not isNil(arg_128_1.actors_["1093ui_story"]) then
				if arg_128_1.var_.characterEffect1093ui_story and not isNil(arg_128_1.actors_["1093ui_story"]) then
					arg_128_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= 0 + var_131_0 and arg_128_1.time_ < 0 + var_131_0 + arg_131_0 and not isNil(arg_128_1.actors_["1093ui_story"]) and arg_128_1.var_.characterEffect1093ui_story then
				arg_128_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_131_2 = 0
			local var_131_3 = 0.75

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_2 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_4 = arg_128_1:GetWordFromCfg(318211031)
				local var_131_5 = arg_128_1:FormatText(var_131_4.content)

				arg_128_1.text_.text = var_131_5

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_7 = 30 <= 0 and var_131_3 or var_131_3 * (utf8.len(var_131_5) / 30)

				if (30 <= 0 and var_131_3 or var_131_3 * (utf8.len(var_131_5) / 30)) > 0 and var_131_3 < var_131_7 then
					arg_128_1.talkMaxDuration = var_131_7

					if var_131_7 + var_131_2 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_7 + var_131_2
					end
				end

				arg_128_1.text_.text = var_131_5
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318211", "318211031", "story_v_out_318211.awb") ~= 0 then
					local var_131_8 = manager.audio:GetVoiceLength("story_v_out_318211", "318211031", "story_v_out_318211.awb") / 1000

					if var_131_8 + var_131_2 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_8 + var_131_2
					end

					if var_131_4.prefab_name ~= "" and arg_128_1.actors_[var_131_4.prefab_name] ~= nil then
						local var_131_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_4.prefab_name].transform, "story_v_out_318211", "318211031", "story_v_out_318211.awb")

						arg_128_1:RecordAudio("318211031", var_131_9)
						arg_128_1:RecordAudio("318211031", var_131_9)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_318211", "318211031", "story_v_out_318211.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_318211", "318211031", "story_v_out_318211.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_10 = math.max(var_131_3, arg_128_1.talkMaxDuration)

			if var_131_2 <= arg_128_1.time_ and arg_128_1.time_ < var_131_2 + var_131_10 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_2) / var_131_10

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_2 + var_131_10 and arg_128_1.time_ < var_131_2 + var_131_10 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play318211032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 318211032
		arg_132_1.duration_ = 5.6

		local var_132_0 = {
			zh = 4.966,
			ja = 5.6
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
				arg_132_0:Play318211033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(arg_132_1.actors_["1093ui_story"]) and arg_132_1.var_.characterEffect1093ui_story == nil then
				arg_132_1.var_.characterEffect1093ui_story = arg_132_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_0 = 0.200000002980232

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_0 and not isNil(arg_132_1.actors_["1093ui_story"]) then
				if arg_132_1.var_.characterEffect1093ui_story and not isNil(arg_132_1.actors_["1093ui_story"]) then
					arg_132_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_132_1.time_ >= 0 + var_135_0 and arg_132_1.time_ < 0 + var_135_0 + arg_135_0 and not isNil(arg_132_1.actors_["1093ui_story"]) and arg_132_1.var_.characterEffect1093ui_story then
				arg_132_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_135_2 = 0
			local var_135_3 = 0.55

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_2 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_4 = arg_132_1:GetWordFromCfg(318211032)
				local var_135_5 = arg_132_1:FormatText(var_135_4.content)

				arg_132_1.text_.text = var_135_5

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_7 = 22 <= 0 and var_135_3 or var_135_3 * (utf8.len(var_135_5) / 22)

				if (22 <= 0 and var_135_3 or var_135_3 * (utf8.len(var_135_5) / 22)) > 0 and var_135_3 < var_135_7 then
					arg_132_1.talkMaxDuration = var_135_7

					if var_135_7 + var_135_2 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_7 + var_135_2
					end
				end

				arg_132_1.text_.text = var_135_5
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318211", "318211032", "story_v_out_318211.awb") ~= 0 then
					local var_135_8 = manager.audio:GetVoiceLength("story_v_out_318211", "318211032", "story_v_out_318211.awb") / 1000

					if var_135_8 + var_135_2 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_8 + var_135_2
					end

					if var_135_4.prefab_name ~= "" and arg_132_1.actors_[var_135_4.prefab_name] ~= nil then
						local var_135_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_4.prefab_name].transform, "story_v_out_318211", "318211032", "story_v_out_318211.awb")

						arg_132_1:RecordAudio("318211032", var_135_9)
						arg_132_1:RecordAudio("318211032", var_135_9)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_318211", "318211032", "story_v_out_318211.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_318211", "318211032", "story_v_out_318211.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_10 = math.max(var_135_3, arg_132_1.talkMaxDuration)

			if var_135_2 <= arg_132_1.time_ and arg_132_1.time_ < var_135_2 + var_135_10 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_2) / var_135_10

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_2 + var_135_10 and arg_132_1.time_ < var_135_2 + var_135_10 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play318211033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 318211033
		arg_136_1.duration_ = 5.07

		local var_136_0 = {
			zh = 3.566,
			ja = 5.066
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
				arg_136_0:Play318211034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(arg_136_1.actors_["1199ui_story"]) and arg_136_1.var_.characterEffect1199ui_story == nil then
				arg_136_1.var_.characterEffect1199ui_story = arg_136_1.actors_["1199ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_0 = 0.200000002980232

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_0 and not isNil(arg_136_1.actors_["1199ui_story"]) then
				if arg_136_1.var_.characterEffect1199ui_story and not isNil(arg_136_1.actors_["1199ui_story"]) then
					arg_136_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= 0 + var_139_0 and arg_136_1.time_ < 0 + var_139_0 + arg_139_0 and not isNil(arg_136_1.actors_["1199ui_story"]) and arg_136_1.var_.characterEffect1199ui_story then
				arg_136_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			local var_139_2 = arg_136_1.actors_["1093ui_story"]

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(var_139_2) and arg_136_1.var_.characterEffect1093ui_story == nil then
				arg_136_1.var_.characterEffect1093ui_story = var_139_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_3 = 0.200000002980232

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_3 and not isNil(var_139_2) then
				if arg_136_1.var_.characterEffect1093ui_story and not isNil(var_139_2) then
					arg_136_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_136_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_136_1.time_ - 0) / var_139_3)
				end
			end

			if arg_136_1.time_ >= 0 + var_139_3 and arg_136_1.time_ < 0 + var_139_3 + arg_139_0 and not isNil(var_139_2) and arg_136_1.var_.characterEffect1093ui_story then
				arg_136_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_136_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_139_4 = 0
			local var_139_5 = 0.4

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_4 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_6 = arg_136_1:GetWordFromCfg(318211033)
				local var_139_7 = arg_136_1:FormatText(var_139_6.content)

				arg_136_1.text_.text = var_139_7

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_9 = 16 <= 0 and var_139_5 or var_139_5 * (utf8.len(var_139_7) / 16)

				if (16 <= 0 and var_139_5 or var_139_5 * (utf8.len(var_139_7) / 16)) > 0 and var_139_5 < var_139_9 then
					arg_136_1.talkMaxDuration = var_139_9

					if var_139_9 + var_139_4 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_9 + var_139_4
					end
				end

				arg_136_1.text_.text = var_139_7
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318211", "318211033", "story_v_out_318211.awb") ~= 0 then
					local var_139_10 = manager.audio:GetVoiceLength("story_v_out_318211", "318211033", "story_v_out_318211.awb") / 1000

					if var_139_10 + var_139_4 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_10 + var_139_4
					end

					if var_139_6.prefab_name ~= "" and arg_136_1.actors_[var_139_6.prefab_name] ~= nil then
						local var_139_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_6.prefab_name].transform, "story_v_out_318211", "318211033", "story_v_out_318211.awb")

						arg_136_1:RecordAudio("318211033", var_139_11)
						arg_136_1:RecordAudio("318211033", var_139_11)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_318211", "318211033", "story_v_out_318211.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_318211", "318211033", "story_v_out_318211.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_12 = math.max(var_139_5, arg_136_1.talkMaxDuration)

			if var_139_4 <= arg_136_1.time_ and arg_136_1.time_ < var_139_4 + var_139_12 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_4) / var_139_12

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_4 + var_139_12 and arg_136_1.time_ < var_139_4 + var_139_12 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play318211034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 318211034
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play318211035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(arg_140_1.actors_["1199ui_story"]) and arg_140_1.var_.characterEffect1199ui_story == nil then
				arg_140_1.var_.characterEffect1199ui_story = arg_140_1.actors_["1199ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_0 = 0.200000002980232

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_0 and not isNil(arg_140_1.actors_["1199ui_story"]) then
				if arg_140_1.var_.characterEffect1199ui_story and not isNil(arg_140_1.actors_["1199ui_story"]) then
					arg_140_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_140_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_140_1.time_ - 0) / var_143_0)
				end
			end

			if arg_140_1.time_ >= 0 + var_143_0 and arg_140_1.time_ < 0 + var_143_0 + arg_143_0 and not isNil(arg_140_1.actors_["1199ui_story"]) and arg_140_1.var_.characterEffect1199ui_story then
				arg_140_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_140_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_143_1 = 0
			local var_143_2 = 0.45

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, false)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_3 = arg_140_1:FormatText(arg_140_1:GetWordFromCfg(318211034).content)

				arg_140_1.text_.text = var_143_3

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_5 = 18 <= 0 and var_143_2 or var_143_2 * (utf8.len(var_143_3) / 18)

				if (18 <= 0 and var_143_2 or var_143_2 * (utf8.len(var_143_3) / 18)) > 0 and var_143_2 < var_143_5 then
					arg_140_1.talkMaxDuration = var_143_5

					if var_143_5 + var_143_1 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_5 + var_143_1
					end
				end

				arg_140_1.text_.text = var_143_3
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_6 = math.max(var_143_2, arg_140_1.talkMaxDuration)

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_6 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_1) / var_143_6

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_1 + var_143_6 and arg_140_1.time_ < var_143_1 + var_143_6 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play318211035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 318211035
		arg_144_1.duration_ = 8.77

		local var_144_0 = {
			zh = 8.766,
			ja = 5.866
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
				arg_144_0:Play318211036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(arg_144_1.actors_["1199ui_story"]) and arg_144_1.var_.characterEffect1199ui_story == nil then
				arg_144_1.var_.characterEffect1199ui_story = arg_144_1.actors_["1199ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_0 = 0.200000002980232

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_0 and not isNil(arg_144_1.actors_["1199ui_story"]) then
				if arg_144_1.var_.characterEffect1199ui_story and not isNil(arg_144_1.actors_["1199ui_story"]) then
					arg_144_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_144_1.time_ >= 0 + var_147_0 and arg_144_1.time_ < 0 + var_147_0 + arg_147_0 and not isNil(arg_144_1.actors_["1199ui_story"]) and arg_144_1.var_.characterEffect1199ui_story then
				arg_144_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1199/story1199action/1199action4_2")
			end

			local var_147_2 = 0
			local var_147_3 = 1.025

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_2 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_4 = arg_144_1:GetWordFromCfg(318211035)
				local var_147_5 = arg_144_1:FormatText(var_147_4.content)

				arg_144_1.text_.text = var_147_5

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_7 = 41 <= 0 and var_147_3 or var_147_3 * (utf8.len(var_147_5) / 41)

				if (41 <= 0 and var_147_3 or var_147_3 * (utf8.len(var_147_5) / 41)) > 0 and var_147_3 < var_147_7 then
					arg_144_1.talkMaxDuration = var_147_7

					if var_147_7 + var_147_2 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_7 + var_147_2
					end
				end

				arg_144_1.text_.text = var_147_5
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318211", "318211035", "story_v_out_318211.awb") ~= 0 then
					local var_147_8 = manager.audio:GetVoiceLength("story_v_out_318211", "318211035", "story_v_out_318211.awb") / 1000

					if var_147_8 + var_147_2 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_8 + var_147_2
					end

					if var_147_4.prefab_name ~= "" and arg_144_1.actors_[var_147_4.prefab_name] ~= nil then
						local var_147_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_4.prefab_name].transform, "story_v_out_318211", "318211035", "story_v_out_318211.awb")

						arg_144_1:RecordAudio("318211035", var_147_9)
						arg_144_1:RecordAudio("318211035", var_147_9)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_318211", "318211035", "story_v_out_318211.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_318211", "318211035", "story_v_out_318211.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_10 = math.max(var_147_3, arg_144_1.talkMaxDuration)

			if var_147_2 <= arg_144_1.time_ and arg_144_1.time_ < var_147_2 + var_147_10 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_2) / var_147_10

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_2 + var_147_10 and arg_144_1.time_ < var_147_2 + var_147_10 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play318211036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 318211036
		arg_148_1.duration_ = 7.73

		local var_148_0 = {
			zh = 4.333,
			ja = 7.733
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
				arg_148_0:Play318211037(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = 0.525

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				arg_148_1.leftNameTxt_.text = arg_148_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_1 = arg_148_1:GetWordFromCfg(318211036)
				local var_151_2 = arg_148_1:FormatText(var_151_1.content)

				arg_148_1.text_.text = var_151_2

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_4 = 21 <= 0 and var_151_0 or var_151_0 * (utf8.len(var_151_2) / 21)

				if (21 <= 0 and var_151_0 or var_151_0 * (utf8.len(var_151_2) / 21)) > 0 and var_151_0 < var_151_4 then
					arg_148_1.talkMaxDuration = var_151_4

					if var_151_4 + 0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_4 + 0
					end
				end

				arg_148_1.text_.text = var_151_2
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318211", "318211036", "story_v_out_318211.awb") ~= 0 then
					local var_151_5 = manager.audio:GetVoiceLength("story_v_out_318211", "318211036", "story_v_out_318211.awb") / 1000

					if var_151_5 + 0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_5 + 0
					end

					if var_151_1.prefab_name ~= "" and arg_148_1.actors_[var_151_1.prefab_name] ~= nil then
						local var_151_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_1.prefab_name].transform, "story_v_out_318211", "318211036", "story_v_out_318211.awb")

						arg_148_1:RecordAudio("318211036", var_151_6)
						arg_148_1:RecordAudio("318211036", var_151_6)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_318211", "318211036", "story_v_out_318211.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_318211", "318211036", "story_v_out_318211.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_7 = math.max(var_151_0, arg_148_1.talkMaxDuration)

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_7 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - 0) / var_151_7

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= 0 + var_151_7 and arg_148_1.time_ < 0 + var_151_7 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play318211037 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 318211037
		arg_152_1.duration_ = 5.73

		local var_152_0 = {
			zh = 5.733,
			ja = 3.166
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
			arg_152_1.auto_ = false
		end

		function arg_152_1.playNext_(arg_154_0)
			arg_152_1.onStoryFinished_()
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = 0.675

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_1 = arg_152_1:GetWordFromCfg(318211037)
				local var_155_2 = arg_152_1:FormatText(var_155_1.content)

				arg_152_1.text_.text = var_155_2

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_4 = 27 <= 0 and var_155_0 or var_155_0 * (utf8.len(var_155_2) / 27)

				if (27 <= 0 and var_155_0 or var_155_0 * (utf8.len(var_155_2) / 27)) > 0 and var_155_0 < var_155_4 then
					arg_152_1.talkMaxDuration = var_155_4

					if var_155_4 + 0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_4 + 0
					end
				end

				arg_152_1.text_.text = var_155_2
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318211", "318211037", "story_v_out_318211.awb") ~= 0 then
					local var_155_5 = manager.audio:GetVoiceLength("story_v_out_318211", "318211037", "story_v_out_318211.awb") / 1000

					if var_155_5 + 0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_5 + 0
					end

					if var_155_1.prefab_name ~= "" and arg_152_1.actors_[var_155_1.prefab_name] ~= nil then
						local var_155_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_1.prefab_name].transform, "story_v_out_318211", "318211037", "story_v_out_318211.awb")

						arg_152_1:RecordAudio("318211037", var_155_6)
						arg_152_1:RecordAudio("318211037", var_155_6)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_318211", "318211037", "story_v_out_318211.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_318211", "318211037", "story_v_out_318211.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_7 = math.max(var_155_0, arg_152_1.talkMaxDuration)

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_7 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - 0) / var_155_7

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= 0 + var_155_7 and arg_152_1.time_ < 0 + var_155_7 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST69a"
	},
	voices = {
		"story_v_out_318211.awb"
	}
}
