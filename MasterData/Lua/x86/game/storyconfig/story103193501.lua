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
			if 1.36666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.36666666666667 + arg_4_0 then
				local var_4_0 = arg_1_1.fswbg_.transform:Find("textbox/adapt/content") or arg_1_1.fswbg_.transform:Find("textbox/content")
				local var_4_1 = arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_4_2 = var_4_0:GetComponent("RectTransform")

				var_4_0:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_4_2.offsetMin = Vector2.New(0, 0)
				var_4_2.offsetMax = Vector2.New(0, 0)
			end

			if 1.36666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.36666666666667 + arg_4_0 then
				arg_1_1.fswbg_:SetActive(true)
				arg_1_1.dialog_:SetActive(false)

				arg_1_1.fswtw_.percent = 0
				arg_1_1.fswt_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(319351001).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.fswt_)

				arg_1_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_1_1.fswtw_:SetDirty()

				arg_1_1.typewritterCharCountI18N = 0

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_3 = 1.73333333333333

			if 1.73333333333333 < arg_1_1.time_ and arg_1_1.time_ <= var_4_3 + arg_4_0 then
				arg_1_1.var_.oldValueTypewriter = arg_1_1.fswtw_.percent

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_4 = 6
			local var_4_5 = 0.4
			local var_4_6, var_4_7 = arg_1_1:GetPercentByPara(arg_1_1:FormatText(arg_1_1:GetWordFromCfg(319351001).content), 1)

			if var_4_3 < arg_1_1.time_ and arg_1_1.time_ <= var_4_3 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				local var_4_8 = var_4_4 <= 0 and var_4_5 or var_4_5 * ((var_4_7 - arg_1_1.typewritterCharCountI18N) / var_4_4)

				if (var_4_4 <= 0 and var_4_5 or var_4_5 * ((var_4_7 - arg_1_1.typewritterCharCountI18N) / var_4_4)) > 0 and var_4_5 < var_4_8 then
					arg_1_1.talkMaxDuration = var_4_8

					if var_4_8 + var_4_3 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_8 + var_4_3
					end
				end
			end

			local var_4_9 = math.max(0.4, arg_1_1.talkMaxDuration)

			if var_4_3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_3 + var_4_9 then
				arg_1_1.fswtw_.percent = Mathf.Lerp(arg_1_1.var_.oldValueTypewriter, var_4_6, (arg_1_1.time_ - var_4_3) / var_4_9)
				arg_1_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_1_1.fswtw_:SetDirty()
			end

			if arg_1_1.time_ >= var_4_3 + var_4_9 and arg_1_1.time_ < var_4_3 + var_4_9 + arg_4_0 then
				arg_1_1.fswtw_.percent = var_4_6

				arg_1_1.fswtw_:SetDirty()
				arg_1_1:ShowNextGo(true)

				arg_1_1.typewritterCharCountI18N = var_4_7
			end

			if 1.36666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.36666666666667 + arg_4_0 then
				arg_1_1.cswbg_:SetActive(true)

				local var_4_10 = arg_1_1.cswt_:GetComponent("RectTransform")

				arg_1_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_4_10.offsetMin = Vector2.New(410, 330)
				var_4_10.offsetMax = Vector2.New(-400, -175)
				arg_1_1.cswt_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(419013).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.cswt_)

				arg_1_1.cswt_.fontSize = 180
				arg_1_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_1_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_1_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_4_11 = "STblack"

			if arg_1_1.bgs_.STblack == nil then
				local var_4_12 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_12:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_11)
				var_4_12.name = var_4_11
				var_4_12.transform.parent = arg_1_1.stage_.transform
				var_4_12.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_11] = var_4_12
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_13 = arg_1_1.bgs_.STblack

				arg_1_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_13.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_14 = var_4_13:GetComponent("SpriteRenderer")

				if var_4_14 and var_4_14.sprite then
					local var_4_15 = 2 * (var_4_13.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_13.transform.localScale = Vector3.New(var_4_15 / var_4_14.sprite.bounds.size.y < var_4_15 * manager.ui.mainCameraCom_.aspect / var_4_14.sprite.bounds.size.x and var_4_15 * manager.ui.mainCameraCom_.aspect / var_4_14.sprite.bounds.size.x or var_4_15 / var_4_14.sprite.bounds.size.y, var_4_15 / var_4_14.sprite.bounds.size.y < var_4_15 * manager.ui.mainCameraCom_.aspect / var_4_14.sprite.bounds.size.x and var_4_15 * manager.ui.mainCameraCom_.aspect / var_4_14.sprite.bounds.size.x or var_4_15 / var_4_14.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "STblack" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_17 = 2

			if var_4_16 <= arg_1_1.time_ and arg_1_1.time_ < var_4_16 + var_4_17 then
				local var_4_18 = Color.New(0, 0, 0)

				var_4_18.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_16) / var_4_17)
				arg_1_1.mask_.color = var_4_18
			end

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				local var_4_19 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_19.a = 0
				arg_1_1.mask_.color = var_4_19
			end

			local var_4_20 = 1.73333333333333
			local var_4_21 = manager.audio:GetVoiceLength("story_v_out_319351", "319351001", "story_v_out_319351.awb") / 1000

			if var_4_21 > 0 and 3.166 < var_4_21 and var_4_21 + var_4_20 > arg_1_1.duration_ then
				arg_1_1.duration_ = var_4_21 + var_4_20
			end

			if var_4_20 < arg_1_1.time_ and arg_1_1.time_ <= var_4_20 + arg_4_0 then
				arg_1_1:AudioAction("play", "voice", "story_v_out_319351", "319351001", "story_v_out_319351.awb")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_25 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_25 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_25

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_25
						arg_1_1.bgmTxt2_.text = var_4_25
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
			if arg_6_1.bgs_.I11o == nil then
				local var_9_0 = Object.Instantiate(arg_6_1.paintGo_)

				var_9_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I11o")
				var_9_0.name = "I11o"
				var_9_0.transform.parent = arg_6_1.stage_.transform
				var_9_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_6_1.bgs_.I11o = var_9_0
			end

			if 0 < arg_6_1.time_ and arg_6_1.time_ <= 0 + arg_9_0 then
				local var_9_1 = arg_6_1.bgs_.I11o

				arg_6_1.bgs_.I11o.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_9_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_9_2 = var_9_1:GetComponent("SpriteRenderer")

				if var_9_2 and var_9_2.sprite then
					local var_9_3 = 2 * (var_9_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_9_1.transform.localScale = Vector3.New(var_9_3 / var_9_2.sprite.bounds.size.y < var_9_3 * manager.ui.mainCameraCom_.aspect / var_9_2.sprite.bounds.size.x and var_9_3 * manager.ui.mainCameraCom_.aspect / var_9_2.sprite.bounds.size.x or var_9_3 / var_9_2.sprite.bounds.size.y, var_9_3 / var_9_2.sprite.bounds.size.y < var_9_3 * manager.ui.mainCameraCom_.aspect / var_9_2.sprite.bounds.size.x and var_9_3 * manager.ui.mainCameraCom_.aspect / var_9_2.sprite.bounds.size.x or var_9_3 / var_9_2.sprite.bounds.size.y, 0)
				end

				for iter_9_0, iter_9_1 in pairs(arg_6_1.bgs_) do
					if iter_9_0 ~= "I11o" then
						iter_9_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_9_4 = 0

			if 0 < arg_6_1.time_ and arg_6_1.time_ <= var_9_4 + arg_9_0 then
				arg_6_1.mask_.enabled = true
				arg_6_1.mask_.raycastTarget = true

				arg_6_1:SetGaussion(false)
			end

			local var_9_5 = 2

			if var_9_4 <= arg_6_1.time_ and arg_6_1.time_ < var_9_4 + var_9_5 then
				local var_9_6 = Color.New(0, 0, 0)

				var_9_6.a = Mathf.Lerp(1, 0, (arg_6_1.time_ - var_9_4) / var_9_5)
				arg_6_1.mask_.color = var_9_6
			end

			if arg_6_1.time_ >= var_9_4 + var_9_5 and arg_6_1.time_ < var_9_4 + var_9_5 + arg_9_0 then
				local var_9_7 = Color.New(0, 0, 0)

				arg_6_1.mask_.enabled = false
				var_9_7.a = 0
				arg_6_1.mask_.color = var_9_7
			end

			if 0 < arg_6_1.time_ and arg_6_1.time_ <= 0 + arg_9_0 then
				arg_6_1.fswbg_:SetActive(false)
				arg_6_1.dialog_:SetActive(false)
				SetActive(arg_6_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_6_1:ShowNextGo(false)
			end

			if 0.366666666666666 < arg_6_1.time_ and arg_6_1.time_ <= 0.366666666666666 + arg_9_0 then
				arg_6_1.fswbg_:SetActive(false)
				arg_6_1.dialog_:SetActive(false)
				SetActive(arg_6_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_6_1:ShowNextGo(false)
			end

			if 0 < arg_6_1.time_ and arg_6_1.time_ <= 0 + arg_9_0 then
				arg_6_1.cswbg_:SetActive(false)
			end

			if arg_6_1.frameCnt_ <= 1 then
				arg_6_1.dialog_:SetActive(false)
			end

			local var_9_8 = 1.63333333333333
			local var_9_9 = 1.025

			if 1.63333333333333 < arg_6_1.time_ and arg_6_1.time_ <= var_9_8 + arg_9_0 then
				arg_6_1.talkMaxDuration = 0

				arg_6_1.dialog_:SetActive(true)

				arg_6_1.dialogCg_.alpha = 0

				local var_9_10 = LeanTween.value(arg_6_1.dialog_, 0, 1, 0.3)

				var_9_10:setOnUpdate(LuaHelper.FloatAction(function(arg_10_0)
					arg_6_1.dialogCg_.alpha = arg_10_0
				end))
				var_9_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_6_1.dialog_)
					var_9_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_6_1.duration_ = arg_6_1.duration_ + 0.3

				SetActive(arg_6_1.leftNameGo_, false)

				arg_6_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_6_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_6_1:RecordName(arg_6_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_6_1.iconTrs_.gameObject, false)
				arg_6_1.callingController_:SetSelectedState("normal")

				local var_9_11 = arg_6_1:FormatText(arg_6_1:GetWordFromCfg(319351002).content)

				arg_6_1.text_.text = var_9_11

				LuaForUtil.ClearLinePrefixSymbol(arg_6_1.text_)

				local var_9_13 = 41 <= 0 and var_9_9 or var_9_9 * (utf8.len(var_9_11) / 41)

				if (41 <= 0 and var_9_9 or var_9_9 * (utf8.len(var_9_11) / 41)) > 0 and var_9_9 < var_9_13 then
					arg_6_1.talkMaxDuration = var_9_13
					var_9_8 = var_9_8 + 0.3

					if var_9_13 + var_9_8 > arg_6_1.duration_ then
						arg_6_1.duration_ = var_9_13 + var_9_8
					end
				end

				arg_6_1.text_.text = var_9_11
				arg_6_1.typewritter.percent = 0

				arg_6_1.typewritter:SetDirty()
				arg_6_1:ShowNextGo(false)
				arg_6_1:RecordContent(arg_6_1.text_.text)
			end

			local var_9_14 = var_9_8 + 0.3
			local var_9_15 = math.max(var_9_9, arg_6_1.talkMaxDuration)

			if var_9_8 + 0.3 <= arg_6_1.time_ and arg_6_1.time_ < var_9_14 + var_9_15 then
				arg_6_1.typewritter.percent = (arg_6_1.time_ - var_9_14) / var_9_15

				arg_6_1.typewritter:SetDirty()
			end

			if arg_6_1.time_ >= var_9_14 + var_9_15 and arg_6_1.time_ < var_9_14 + var_9_15 + arg_9_0 then
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
			local var_15_0 = 0.8

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

				local var_15_1 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(319351003).content)

				arg_12_1.text_.text = var_15_1

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_3 = 32 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 32)

				if (32 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 32)) > 0 and var_15_0 < var_15_3 then
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
			if arg_16_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_19_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_16_1.stage_.transform)

				var_19_0.name = "1084ui_story"
				var_19_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.actors_["1084ui_story"] = var_19_0

				local var_19_1 = var_19_0:GetComponentInChildren(typeof(CharacterEffect))

				var_19_1.enabled = true

				local var_19_2 = GameObjectTools.GetOrAddComponent(var_19_0, typeof(DynamicBoneHelper))

				if var_19_2 then
					var_19_2:EnableDynamicBone(false)
				end

				arg_16_1:ShowWeapon(var_19_1.transform, false)

				arg_16_1.var_["1084ui_story" .. "Animator"] = var_19_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_16_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_16_1.var_["1084ui_story" .. "LipSync"] = var_19_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_19_3 = arg_16_1.actors_["1084ui_story"].transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos1084ui_story = var_19_3.localPosition

				arg_16_1:ShowWeapon(arg_16_1.var_["1084ui_story" .. "Animator"].transform, false)
			end

			local var_19_4 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_4 then
				var_19_3.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_16_1.time_ - 0) / var_19_4)
				var_19_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_3.position).x, (manager.ui.mainCamera.transform.position - var_19_3.position).y, (manager.ui.mainCamera.transform.position - var_19_3.position).z)
				var_19_3.localEulerAngles.z = 0
				var_19_3.localEulerAngles.x = 0
				var_19_3.localEulerAngles = var_19_3.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_4 and arg_16_1.time_ < 0 + var_19_4 + arg_19_0 then
				var_19_3.localPosition = Vector3.New(0, -0.97, -6)
				var_19_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_3.position).x, (manager.ui.mainCamera.transform.position - var_19_3.position).y, (manager.ui.mainCamera.transform.position - var_19_3.position).z)
				var_19_3.localEulerAngles.z = 0
				var_19_3.localEulerAngles.x = 0
				var_19_3.localEulerAngles = var_19_3.localEulerAngles
			end

			local var_19_5 = arg_16_1.actors_["1084ui_story"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_5) and arg_16_1.var_.characterEffect1084ui_story == nil then
				arg_16_1.var_.characterEffect1084ui_story = var_19_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_6 = 0.200000002980232

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_6 and not isNil(var_19_5) then
				if arg_16_1.var_.characterEffect1084ui_story and not isNil(var_19_5) then
					arg_16_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= 0 + var_19_6 and arg_16_1.time_ < 0 + var_19_6 + arg_19_0 and not isNil(var_19_5) and arg_16_1.var_.characterEffect1084ui_story then
				arg_16_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_19_8 = 0
			local var_19_9 = 0.4

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_8 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_10 = arg_16_1:GetWordFromCfg(319351004)
				local var_19_11 = arg_16_1:FormatText(var_19_10.content)

				arg_16_1.text_.text = var_19_11

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_13 = 16 <= 0 and var_19_9 or var_19_9 * (utf8.len(var_19_11) / 16)

				if (16 <= 0 and var_19_9 or var_19_9 * (utf8.len(var_19_11) / 16)) > 0 and var_19_9 < var_19_13 then
					arg_16_1.talkMaxDuration = var_19_13

					if var_19_13 + var_19_8 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_13 + var_19_8
					end
				end

				arg_16_1.text_.text = var_19_11
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319351", "319351004", "story_v_out_319351.awb") ~= 0 then
					local var_19_14 = manager.audio:GetVoiceLength("story_v_out_319351", "319351004", "story_v_out_319351.awb") / 1000

					if var_19_14 + var_19_8 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_14 + var_19_8
					end

					if var_19_10.prefab_name ~= "" and arg_16_1.actors_[var_19_10.prefab_name] ~= nil then
						local var_19_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_10.prefab_name].transform, "story_v_out_319351", "319351004", "story_v_out_319351.awb")

						arg_16_1:RecordAudio("319351004", var_19_15)
						arg_16_1:RecordAudio("319351004", var_19_15)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_319351", "319351004", "story_v_out_319351.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_319351", "319351004", "story_v_out_319351.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_16 = math.max(var_19_9, arg_16_1.talkMaxDuration)

			if var_19_8 <= arg_16_1.time_ and arg_16_1.time_ < var_19_8 + var_19_16 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_8) / var_19_16

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_8 + var_19_16 and arg_16_1.time_ < var_19_8 + var_19_16 + arg_19_0 then
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
			if arg_20_1.actors_["10058ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10058ui_story"))) then
				local var_23_0 = Object.Instantiate(Asset.Load("Char/" .. "10058ui_story"), arg_20_1.stage_.transform)

				var_23_0.name = "10058ui_story"
				var_23_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_20_1.actors_["10058ui_story"] = var_23_0

				local var_23_1 = var_23_0:GetComponentInChildren(typeof(CharacterEffect))

				var_23_1.enabled = true

				local var_23_2 = GameObjectTools.GetOrAddComponent(var_23_0, typeof(DynamicBoneHelper))

				if var_23_2 then
					var_23_2:EnableDynamicBone(false)
				end

				arg_20_1:ShowWeapon(var_23_1.transform, false)

				arg_20_1.var_["10058ui_story" .. "Animator"] = var_23_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_20_1.var_["10058ui_story" .. "Animator"].applyRootMotion = true
				arg_20_1.var_["10058ui_story" .. "LipSync"] = var_23_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_23_3 = arg_20_1.actors_["10058ui_story"].transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos10058ui_story = var_23_3.localPosition
			end

			local var_23_4 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_4 then
				var_23_3.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos10058ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_20_1.time_ - 0) / var_23_4)
				var_23_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_3.position).x, (manager.ui.mainCamera.transform.position - var_23_3.position).y, (manager.ui.mainCamera.transform.position - var_23_3.position).z)
				var_23_3.localEulerAngles.z = 0
				var_23_3.localEulerAngles.x = 0
				var_23_3.localEulerAngles = var_23_3.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_4 and arg_20_1.time_ < 0 + var_23_4 + arg_23_0 then
				var_23_3.localPosition = Vector3.New(0.7, -0.98, -6.1)
				var_23_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_3.position).x, (manager.ui.mainCamera.transform.position - var_23_3.position).y, (manager.ui.mainCamera.transform.position - var_23_3.position).z)
				var_23_3.localEulerAngles.z = 0
				var_23_3.localEulerAngles.x = 0
				var_23_3.localEulerAngles = var_23_3.localEulerAngles
			end

			local var_23_5 = arg_20_1.actors_["10058ui_story"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_5) and arg_20_1.var_.characterEffect10058ui_story == nil then
				arg_20_1.var_.characterEffect10058ui_story = var_23_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_6 = 0.200000002980232

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_6 and not isNil(var_23_5) then
				if arg_20_1.var_.characterEffect10058ui_story and not isNil(var_23_5) then
					arg_20_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= 0 + var_23_6 and arg_20_1.time_ < 0 + var_23_6 + arg_23_0 and not isNil(var_23_5) and arg_20_1.var_.characterEffect10058ui_story then
				arg_20_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_23_8 = arg_20_1.actors_["1084ui_story"].transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos1084ui_story = var_23_8.localPosition
			end

			local var_23_9 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_9 then
				var_23_8.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_20_1.time_ - 0) / var_23_9)
				var_23_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_8.position).x, (manager.ui.mainCamera.transform.position - var_23_8.position).y, (manager.ui.mainCamera.transform.position - var_23_8.position).z)
				var_23_8.localEulerAngles.z = 0
				var_23_8.localEulerAngles.x = 0
				var_23_8.localEulerAngles = var_23_8.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_9 and arg_20_1.time_ < 0 + var_23_9 + arg_23_0 then
				var_23_8.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_23_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_8.position).x, (manager.ui.mainCamera.transform.position - var_23_8.position).y, (manager.ui.mainCamera.transform.position - var_23_8.position).z)
				var_23_8.localEulerAngles.z = 0
				var_23_8.localEulerAngles.x = 0
				var_23_8.localEulerAngles = var_23_8.localEulerAngles
			end

			local var_23_10 = arg_20_1.actors_["1084ui_story"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_10) and arg_20_1.var_.characterEffect1084ui_story == nil then
				arg_20_1.var_.characterEffect1084ui_story = var_23_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_11 = 0.200000002980232

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_11 and not isNil(var_23_10) then
				if arg_20_1.var_.characterEffect1084ui_story and not isNil(var_23_10) then
					arg_20_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_20_1.time_ - 0) / var_23_11)
				end
			end

			if arg_20_1.time_ >= 0 + var_23_11 and arg_20_1.time_ < 0 + var_23_11 + arg_23_0 and not isNil(var_23_10) and arg_20_1.var_.characterEffect1084ui_story then
				arg_20_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_23_12 = 0
			local var_23_13 = 0.3

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_12 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_14 = arg_20_1:GetWordFromCfg(319351005)
				local var_23_15 = arg_20_1:FormatText(var_23_14.content)

				arg_20_1.text_.text = var_23_15

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_17 = 12 <= 0 and var_23_13 or var_23_13 * (utf8.len(var_23_15) / 12)

				if (12 <= 0 and var_23_13 or var_23_13 * (utf8.len(var_23_15) / 12)) > 0 and var_23_13 < var_23_17 then
					arg_20_1.talkMaxDuration = var_23_17

					if var_23_17 + var_23_12 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_17 + var_23_12
					end
				end

				arg_20_1.text_.text = var_23_15
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319351", "319351005", "story_v_out_319351.awb") ~= 0 then
					local var_23_18 = manager.audio:GetVoiceLength("story_v_out_319351", "319351005", "story_v_out_319351.awb") / 1000

					if var_23_18 + var_23_12 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_18 + var_23_12
					end

					if var_23_14.prefab_name ~= "" and arg_20_1.actors_[var_23_14.prefab_name] ~= nil then
						local var_23_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_14.prefab_name].transform, "story_v_out_319351", "319351005", "story_v_out_319351.awb")

						arg_20_1:RecordAudio("319351005", var_23_19)
						arg_20_1:RecordAudio("319351005", var_23_19)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_319351", "319351005", "story_v_out_319351.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_319351", "319351005", "story_v_out_319351.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_20 = math.max(var_23_13, arg_20_1.talkMaxDuration)

			if var_23_12 <= arg_20_1.time_ and arg_20_1.time_ < var_23_12 + var_23_20 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_12) / var_23_20

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_12 + var_23_20 and arg_20_1.time_ < var_23_12 + var_23_20 + arg_23_0 then
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
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action7_1")
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_27_0 = 0
			local var_27_1 = 0.45

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_2 = arg_24_1:GetWordFromCfg(319351006)
				local var_27_3 = arg_24_1:FormatText(var_27_2.content)

				arg_24_1.text_.text = var_27_3

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_5 = 18 <= 0 and var_27_1 or var_27_1 * (utf8.len(var_27_3) / 18)

				if (18 <= 0 and var_27_1 or var_27_1 * (utf8.len(var_27_3) / 18)) > 0 and var_27_1 < var_27_5 then
					arg_24_1.talkMaxDuration = var_27_5

					if var_27_5 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_5 + var_27_0
					end
				end

				arg_24_1.text_.text = var_27_3
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319351", "319351006", "story_v_out_319351.awb") ~= 0 then
					local var_27_6 = manager.audio:GetVoiceLength("story_v_out_319351", "319351006", "story_v_out_319351.awb") / 1000

					if var_27_6 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_6 + var_27_0
					end

					if var_27_2.prefab_name ~= "" and arg_24_1.actors_[var_27_2.prefab_name] ~= nil then
						local var_27_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_2.prefab_name].transform, "story_v_out_319351", "319351006", "story_v_out_319351.awb")

						arg_24_1:RecordAudio("319351006", var_27_7)
						arg_24_1:RecordAudio("319351006", var_27_7)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_319351", "319351006", "story_v_out_319351.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_319351", "319351006", "story_v_out_319351.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_8 = math.max(var_27_1, arg_24_1.talkMaxDuration)

			if var_27_0 <= arg_24_1.time_ and arg_24_1.time_ < var_27_0 + var_27_8 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_0) / var_27_8

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_0 + var_27_8 and arg_24_1.time_ < var_27_0 + var_27_8 + arg_27_0 then
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
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(arg_28_1.actors_["10058ui_story"]) and arg_28_1.var_.characterEffect10058ui_story == nil then
				arg_28_1.var_.characterEffect10058ui_story = arg_28_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_0 = 0.200000002980232

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 and not isNil(arg_28_1.actors_["10058ui_story"]) then
				if arg_28_1.var_.characterEffect10058ui_story and not isNil(arg_28_1.actors_["10058ui_story"]) then
					arg_28_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_28_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_28_1.time_ - 0) / var_31_0)
				end
			end

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 and not isNil(arg_28_1.actors_["10058ui_story"]) and arg_28_1.var_.characterEffect10058ui_story then
				arg_28_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_28_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_31_1 = 0
			local var_31_2 = 0.75

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, false)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_3 = arg_28_1:FormatText(arg_28_1:GetWordFromCfg(319351007).content)

				arg_28_1.text_.text = var_31_3

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_5 = 30 <= 0 and var_31_2 or var_31_2 * (utf8.len(var_31_3) / 30)

				if (30 <= 0 and var_31_2 or var_31_2 * (utf8.len(var_31_3) / 30)) > 0 and var_31_2 < var_31_5 then
					arg_28_1.talkMaxDuration = var_31_5

					if var_31_5 + var_31_1 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_5 + var_31_1
					end
				end

				arg_28_1.text_.text = var_31_3
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_6 = math.max(var_31_2, arg_28_1.talkMaxDuration)

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_6 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_1) / var_31_6

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_1 + var_31_6 and arg_28_1.time_ < var_31_1 + var_31_6 + arg_31_0 then
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
			if arg_32_1.bgs_.ST74 == nil then
				local var_35_0 = Object.Instantiate(arg_32_1.paintGo_)

				var_35_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST74")
				var_35_0.name = "ST74"
				var_35_0.transform.parent = arg_32_1.stage_.transform
				var_35_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_32_1.bgs_.ST74 = var_35_0
			end

			if 2 < arg_32_1.time_ and arg_32_1.time_ <= 2 + arg_35_0 then
				local var_35_1 = arg_32_1.bgs_.ST74

				arg_32_1.bgs_.ST74.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_35_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_35_2 = var_35_1:GetComponent("SpriteRenderer")

				if var_35_2 and var_35_2.sprite then
					local var_35_3 = 2 * (var_35_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_35_1.transform.localScale = Vector3.New(var_35_3 / var_35_2.sprite.bounds.size.y < var_35_3 * manager.ui.mainCameraCom_.aspect / var_35_2.sprite.bounds.size.x and var_35_3 * manager.ui.mainCameraCom_.aspect / var_35_2.sprite.bounds.size.x or var_35_3 / var_35_2.sprite.bounds.size.y, var_35_3 / var_35_2.sprite.bounds.size.y < var_35_3 * manager.ui.mainCameraCom_.aspect / var_35_2.sprite.bounds.size.x and var_35_3 * manager.ui.mainCameraCom_.aspect / var_35_2.sprite.bounds.size.x or var_35_3 / var_35_2.sprite.bounds.size.y, 0)
				end

				for iter_35_0, iter_35_1 in pairs(arg_32_1.bgs_) do
					if iter_35_0 ~= "ST74" then
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
				local var_35_6 = Color.New(0, 0, 0)

				var_35_6.a = Mathf.Lerp(0, 1, (arg_32_1.time_ - var_35_4) / var_35_5)
				arg_32_1.mask_.color = var_35_6
			end

			if arg_32_1.time_ >= var_35_4 + var_35_5 and arg_32_1.time_ < var_35_4 + var_35_5 + arg_35_0 then
				local var_35_7 = Color.New(0, 0, 0)

				var_35_7.a = 1
				arg_32_1.mask_.color = var_35_7
			end

			local var_35_8 = 2

			if 2 < arg_32_1.time_ and arg_32_1.time_ <= var_35_8 + arg_35_0 then
				arg_32_1.mask_.enabled = true
				arg_32_1.mask_.raycastTarget = true

				arg_32_1:SetGaussion(false)
			end

			local var_35_9 = 2

			if var_35_8 <= arg_32_1.time_ and arg_32_1.time_ < var_35_8 + var_35_9 then
				local var_35_10 = Color.New(0, 0, 0)

				var_35_10.a = Mathf.Lerp(1, 0, (arg_32_1.time_ - var_35_8) / var_35_9)
				arg_32_1.mask_.color = var_35_10
			end

			if arg_32_1.time_ >= var_35_8 + var_35_9 and arg_32_1.time_ < var_35_8 + var_35_9 + arg_35_0 then
				local var_35_11 = Color.New(0, 0, 0)

				arg_32_1.mask_.enabled = false
				var_35_11.a = 0
				arg_32_1.mask_.color = var_35_11
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

			if 0.1 < arg_32_1.time_ and arg_32_1.time_ <= 0.1 + arg_35_0 then
				arg_32_1:AudioAction("play", "music", "bgm_activity_3_0_story_moon", "bgm_activity_3_0_story_moon", "bgm_activity_3_0_story_moon.awb")

				local var_35_17 = manager.audio:GetAudioName("bgm_activity_3_0_story_moon", "bgm_activity_3_0_story_moon")

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

			local var_35_18 = arg_32_1.actors_["10058ui_story"].transform

			if 2 < arg_32_1.time_ and arg_32_1.time_ <= 2 + arg_35_0 then
				arg_32_1.var_.moveOldPos10058ui_story = var_35_18.localPosition
			end

			local var_35_19 = 0.001

			if 2 <= arg_32_1.time_ and arg_32_1.time_ < 2 + var_35_19 then
				var_35_18.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_32_1.time_ - 2) / var_35_19)
				var_35_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_18.position).x, (manager.ui.mainCamera.transform.position - var_35_18.position).y, (manager.ui.mainCamera.transform.position - var_35_18.position).z)
				var_35_18.localEulerAngles.z = 0
				var_35_18.localEulerAngles.x = 0
				var_35_18.localEulerAngles = var_35_18.localEulerAngles
			end

			if arg_32_1.time_ >= 2 + var_35_19 and arg_32_1.time_ < 2 + var_35_19 + arg_35_0 then
				var_35_18.localPosition = Vector3.New(0, 100, 0)
				var_35_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_18.position).x, (manager.ui.mainCamera.transform.position - var_35_18.position).y, (manager.ui.mainCamera.transform.position - var_35_18.position).z)
				var_35_18.localEulerAngles.z = 0
				var_35_18.localEulerAngles.x = 0
				var_35_18.localEulerAngles = var_35_18.localEulerAngles
			end

			local var_35_20 = arg_32_1.actors_["1084ui_story"].transform

			if 2 < arg_32_1.time_ and arg_32_1.time_ <= 2 + arg_35_0 then
				arg_32_1.var_.moveOldPos1084ui_story = var_35_20.localPosition
			end

			local var_35_21 = 0.001

			if 2 <= arg_32_1.time_ and arg_32_1.time_ < 2 + var_35_21 then
				var_35_20.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_32_1.time_ - 2) / var_35_21)
				var_35_20.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_20.position).x, (manager.ui.mainCamera.transform.position - var_35_20.position).y, (manager.ui.mainCamera.transform.position - var_35_20.position).z)
				var_35_20.localEulerAngles.z = 0
				var_35_20.localEulerAngles.x = 0
				var_35_20.localEulerAngles = var_35_20.localEulerAngles
			end

			if arg_32_1.time_ >= 2 + var_35_21 and arg_32_1.time_ < 2 + var_35_21 + arg_35_0 then
				var_35_20.localPosition = Vector3.New(0, 100, 0)
				var_35_20.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_20.position).x, (manager.ui.mainCamera.transform.position - var_35_20.position).y, (manager.ui.mainCamera.transform.position - var_35_20.position).z)
				var_35_20.localEulerAngles.z = 0
				var_35_20.localEulerAngles.x = 0
				var_35_20.localEulerAngles = var_35_20.localEulerAngles
			end

			if arg_32_1.frameCnt_ <= 1 then
				arg_32_1.dialog_:SetActive(false)
			end

			local var_35_22 = 3.8
			local var_35_23 = 1.625

			if 3.8 < arg_32_1.time_ and arg_32_1.time_ <= var_35_22 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0

				arg_32_1.dialog_:SetActive(true)

				arg_32_1.dialogCg_.alpha = 0

				local var_35_24 = LeanTween.value(arg_32_1.dialog_, 0, 1, 0.3)

				var_35_24:setOnUpdate(LuaHelper.FloatAction(function(arg_38_0)
					arg_32_1.dialogCg_.alpha = arg_38_0
				end))
				var_35_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_32_1.dialog_)
					var_35_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_32_1.duration_ = arg_32_1.duration_ + 0.3

				SetActive(arg_32_1.leftNameGo_, false)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_25 = arg_32_1:FormatText(arg_32_1:GetWordFromCfg(319351008).content)

				arg_32_1.text_.text = var_35_25

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_27 = 65 <= 0 and var_35_23 or var_35_23 * (utf8.len(var_35_25) / 65)

				if (65 <= 0 and var_35_23 or var_35_23 * (utf8.len(var_35_25) / 65)) > 0 and var_35_23 < var_35_27 then
					arg_32_1.talkMaxDuration = var_35_27
					var_35_22 = var_35_22 + 0.3

					if var_35_27 + var_35_22 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_27 + var_35_22
					end
				end

				arg_32_1.text_.text = var_35_25
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_28 = var_35_22 + 0.3
			local var_35_29 = math.max(var_35_23, arg_32_1.talkMaxDuration)

			if var_35_22 + 0.3 <= arg_32_1.time_ and arg_32_1.time_ < var_35_28 + var_35_29 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_28) / var_35_29

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_28 + var_35_29 and arg_32_1.time_ < var_35_28 + var_35_29 + arg_35_0 then
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
			local var_43_0 = 1.25

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, false)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_1 = arg_40_1:FormatText(arg_40_1:GetWordFromCfg(319351009).content)

				arg_40_1.text_.text = var_43_1

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_3 = 50 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_1) / 50)

				if (50 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_1) / 50)) > 0 and var_43_0 < var_43_3 then
					arg_40_1.talkMaxDuration = var_43_3

					if var_43_3 + 0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_3 + 0
					end
				end

				arg_40_1.text_.text = var_43_1
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_4 = math.max(var_43_0, arg_40_1.talkMaxDuration)

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_4 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - 0) / var_43_4

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= 0 + var_43_4 and arg_40_1.time_ < 0 + var_43_4 + arg_43_0 then
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
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.moveOldPos1084ui_story = arg_44_1.actors_["1084ui_story"].transform.localPosition

				arg_44_1:ShowWeapon(arg_44_1.var_["1084ui_story" .. "Animator"].transform, false)
			end

			local var_47_0 = 0.001

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_0 then
				arg_44_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_44_1.time_ - 0) / var_47_0)
				arg_44_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_44_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["1084ui_story"].transform.position).z)
				arg_44_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_44_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_44_1.actors_["1084ui_story"].transform.localEulerAngles = arg_44_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 then
				arg_44_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_44_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_44_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["1084ui_story"].transform.position).z)
				arg_44_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_44_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_44_1.actors_["1084ui_story"].transform.localEulerAngles = arg_44_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_47_1 = arg_44_1.actors_["1084ui_story"]

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(var_47_1) and arg_44_1.var_.characterEffect1084ui_story == nil then
				arg_44_1.var_.characterEffect1084ui_story = var_47_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_2 = 0.200000002980232

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_2 and not isNil(var_47_1) then
				if arg_44_1.var_.characterEffect1084ui_story and not isNil(var_47_1) then
					arg_44_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= 0 + var_47_2 and arg_44_1.time_ < 0 + var_47_2 + arg_47_0 and not isNil(var_47_1) and arg_44_1.var_.characterEffect1084ui_story then
				arg_44_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_47_4 = 0
			local var_47_5 = 0.375

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_4 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_6 = arg_44_1:GetWordFromCfg(319351010)
				local var_47_7 = arg_44_1:FormatText(var_47_6.content)

				arg_44_1.text_.text = var_47_7

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_9 = 15 <= 0 and var_47_5 or var_47_5 * (utf8.len(var_47_7) / 15)

				if (15 <= 0 and var_47_5 or var_47_5 * (utf8.len(var_47_7) / 15)) > 0 and var_47_5 < var_47_9 then
					arg_44_1.talkMaxDuration = var_47_9

					if var_47_9 + var_47_4 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_9 + var_47_4
					end
				end

				arg_44_1.text_.text = var_47_7
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319351", "319351010", "story_v_out_319351.awb") ~= 0 then
					local var_47_10 = manager.audio:GetVoiceLength("story_v_out_319351", "319351010", "story_v_out_319351.awb") / 1000

					if var_47_10 + var_47_4 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_10 + var_47_4
					end

					if var_47_6.prefab_name ~= "" and arg_44_1.actors_[var_47_6.prefab_name] ~= nil then
						local var_47_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_6.prefab_name].transform, "story_v_out_319351", "319351010", "story_v_out_319351.awb")

						arg_44_1:RecordAudio("319351010", var_47_11)
						arg_44_1:RecordAudio("319351010", var_47_11)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_319351", "319351010", "story_v_out_319351.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_319351", "319351010", "story_v_out_319351.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_12 = math.max(var_47_5, arg_44_1.talkMaxDuration)

			if var_47_4 <= arg_44_1.time_ and arg_44_1.time_ < var_47_4 + var_47_12 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_4) / var_47_12

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_4 + var_47_12 and arg_44_1.time_ < var_47_4 + var_47_12 + arg_47_0 then
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
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(arg_48_1.actors_["10058ui_story"]) and arg_48_1.var_.characterEffect10058ui_story == nil then
				arg_48_1.var_.characterEffect10058ui_story = arg_48_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_0 = 0.200000002980232

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 and not isNil(arg_48_1.actors_["10058ui_story"]) then
				if arg_48_1.var_.characterEffect10058ui_story and not isNil(arg_48_1.actors_["10058ui_story"]) then
					arg_48_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 and not isNil(arg_48_1.actors_["10058ui_story"]) and arg_48_1.var_.characterEffect10058ui_story then
				arg_48_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_51_2 = arg_48_1.actors_["1084ui_story"]

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(var_51_2) and arg_48_1.var_.characterEffect1084ui_story == nil then
				arg_48_1.var_.characterEffect1084ui_story = var_51_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_3 = 0.200000002980232

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_3 and not isNil(var_51_2) then
				if arg_48_1.var_.characterEffect1084ui_story and not isNil(var_51_2) then
					arg_48_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_48_1.time_ - 0) / var_51_3)
				end
			end

			if arg_48_1.time_ >= 0 + var_51_3 and arg_48_1.time_ < 0 + var_51_3 + arg_51_0 and not isNil(var_51_2) and arg_48_1.var_.characterEffect1084ui_story then
				arg_48_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_51_4 = arg_48_1.actors_["10058ui_story"].transform

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.moveOldPos10058ui_story = var_51_4.localPosition
			end

			local var_51_5 = 0.001

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_5 then
				var_51_4.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos10058ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_48_1.time_ - 0) / var_51_5)
				var_51_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_4.position).x, (manager.ui.mainCamera.transform.position - var_51_4.position).y, (manager.ui.mainCamera.transform.position - var_51_4.position).z)
				var_51_4.localEulerAngles.z = 0
				var_51_4.localEulerAngles.x = 0
				var_51_4.localEulerAngles = var_51_4.localEulerAngles
			end

			if arg_48_1.time_ >= 0 + var_51_5 and arg_48_1.time_ < 0 + var_51_5 + arg_51_0 then
				var_51_4.localPosition = Vector3.New(0.7, -0.98, -6.1)
				var_51_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_4.position).x, (manager.ui.mainCamera.transform.position - var_51_4.position).y, (manager.ui.mainCamera.transform.position - var_51_4.position).z)
				var_51_4.localEulerAngles.z = 0
				var_51_4.localEulerAngles.x = 0
				var_51_4.localEulerAngles = var_51_4.localEulerAngles
			end

			local var_51_6 = arg_48_1.actors_["1084ui_story"].transform

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.moveOldPos1084ui_story = var_51_6.localPosition
			end

			local var_51_7 = 0.001

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_7 then
				var_51_6.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_48_1.time_ - 0) / var_51_7)
				var_51_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_6.position).x, (manager.ui.mainCamera.transform.position - var_51_6.position).y, (manager.ui.mainCamera.transform.position - var_51_6.position).z)
				var_51_6.localEulerAngles.z = 0
				var_51_6.localEulerAngles.x = 0
				var_51_6.localEulerAngles = var_51_6.localEulerAngles
			end

			if arg_48_1.time_ >= 0 + var_51_7 and arg_48_1.time_ < 0 + var_51_7 + arg_51_0 then
				var_51_6.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_51_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_6.position).x, (manager.ui.mainCamera.transform.position - var_51_6.position).y, (manager.ui.mainCamera.transform.position - var_51_6.position).z)
				var_51_6.localEulerAngles.z = 0
				var_51_6.localEulerAngles.x = 0
				var_51_6.localEulerAngles = var_51_6.localEulerAngles
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_51_8 = 0
			local var_51_9 = 0.85

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_8 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_10 = arg_48_1:GetWordFromCfg(319351011)
				local var_51_11 = arg_48_1:FormatText(var_51_10.content)

				arg_48_1.text_.text = var_51_11

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_13 = 34 <= 0 and var_51_9 or var_51_9 * (utf8.len(var_51_11) / 34)

				if (34 <= 0 and var_51_9 or var_51_9 * (utf8.len(var_51_11) / 34)) > 0 and var_51_9 < var_51_13 then
					arg_48_1.talkMaxDuration = var_51_13

					if var_51_13 + var_51_8 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_13 + var_51_8
					end
				end

				arg_48_1.text_.text = var_51_11
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319351", "319351011", "story_v_out_319351.awb") ~= 0 then
					local var_51_14 = manager.audio:GetVoiceLength("story_v_out_319351", "319351011", "story_v_out_319351.awb") / 1000

					if var_51_14 + var_51_8 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_14 + var_51_8
					end

					if var_51_10.prefab_name ~= "" and arg_48_1.actors_[var_51_10.prefab_name] ~= nil then
						local var_51_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_10.prefab_name].transform, "story_v_out_319351", "319351011", "story_v_out_319351.awb")

						arg_48_1:RecordAudio("319351011", var_51_15)
						arg_48_1:RecordAudio("319351011", var_51_15)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_319351", "319351011", "story_v_out_319351.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_319351", "319351011", "story_v_out_319351.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_16 = math.max(var_51_9, arg_48_1.talkMaxDuration)

			if var_51_8 <= arg_48_1.time_ and arg_48_1.time_ < var_51_8 + var_51_16 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_8) / var_51_16

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_8 + var_51_16 and arg_48_1.time_ < var_51_8 + var_51_16 + arg_51_0 then
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
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(arg_52_1.actors_["10058ui_story"]) and arg_52_1.var_.characterEffect10058ui_story == nil then
				arg_52_1.var_.characterEffect10058ui_story = arg_52_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_0 = 0.200000002980232

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 and not isNil(arg_52_1.actors_["10058ui_story"]) then
				if arg_52_1.var_.characterEffect10058ui_story and not isNil(arg_52_1.actors_["10058ui_story"]) then
					arg_52_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_52_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_52_1.time_ - 0) / var_55_0)
				end
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 and not isNil(arg_52_1.actors_["10058ui_story"]) and arg_52_1.var_.characterEffect10058ui_story then
				arg_52_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_52_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_55_1 = arg_52_1.actors_["1084ui_story"]

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(var_55_1) and arg_52_1.var_.characterEffect1084ui_story == nil then
				arg_52_1.var_.characterEffect1084ui_story = var_55_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_2 = 0.200000002980232

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_2 and not isNil(var_55_1) then
				if arg_52_1.var_.characterEffect1084ui_story and not isNil(var_55_1) then
					arg_52_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= 0 + var_55_2 and arg_52_1.time_ < 0 + var_55_2 + arg_55_0 and not isNil(var_55_1) and arg_52_1.var_.characterEffect1084ui_story then
				arg_52_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2202cva")
			end

			local var_55_4 = 0
			local var_55_5 = 0.6

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_4 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_6 = arg_52_1:GetWordFromCfg(319351012)
				local var_55_7 = arg_52_1:FormatText(var_55_6.content)

				arg_52_1.text_.text = var_55_7

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_9 = 24 <= 0 and var_55_5 or var_55_5 * (utf8.len(var_55_7) / 24)

				if (24 <= 0 and var_55_5 or var_55_5 * (utf8.len(var_55_7) / 24)) > 0 and var_55_5 < var_55_9 then
					arg_52_1.talkMaxDuration = var_55_9

					if var_55_9 + var_55_4 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_9 + var_55_4
					end
				end

				arg_52_1.text_.text = var_55_7
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319351", "319351012", "story_v_out_319351.awb") ~= 0 then
					local var_55_10 = manager.audio:GetVoiceLength("story_v_out_319351", "319351012", "story_v_out_319351.awb") / 1000

					if var_55_10 + var_55_4 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_10 + var_55_4
					end

					if var_55_6.prefab_name ~= "" and arg_52_1.actors_[var_55_6.prefab_name] ~= nil then
						local var_55_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_6.prefab_name].transform, "story_v_out_319351", "319351012", "story_v_out_319351.awb")

						arg_52_1:RecordAudio("319351012", var_55_11)
						arg_52_1:RecordAudio("319351012", var_55_11)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_319351", "319351012", "story_v_out_319351.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_319351", "319351012", "story_v_out_319351.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_12 = math.max(var_55_5, arg_52_1.talkMaxDuration)

			if var_55_4 <= arg_52_1.time_ and arg_52_1.time_ < var_55_4 + var_55_12 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_4) / var_55_12

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_4 + var_55_12 and arg_52_1.time_ < var_55_4 + var_55_12 + arg_55_0 then
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
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(arg_56_1.actors_["10058ui_story"]) and arg_56_1.var_.characterEffect10058ui_story == nil then
				arg_56_1.var_.characterEffect10058ui_story = arg_56_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_0 = 0.200000002980232

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 and not isNil(arg_56_1.actors_["10058ui_story"]) then
				if arg_56_1.var_.characterEffect10058ui_story and not isNil(arg_56_1.actors_["10058ui_story"]) then
					arg_56_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 and not isNil(arg_56_1.actors_["10058ui_story"]) and arg_56_1.var_.characterEffect10058ui_story then
				arg_56_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_59_2 = arg_56_1.actors_["1084ui_story"]

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(var_59_2) and arg_56_1.var_.characterEffect1084ui_story == nil then
				arg_56_1.var_.characterEffect1084ui_story = var_59_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_3 = 0.200000002980232

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_3 and not isNil(var_59_2) then
				if arg_56_1.var_.characterEffect1084ui_story and not isNil(var_59_2) then
					arg_56_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_56_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_56_1.time_ - 0) / var_59_3)
				end
			end

			if arg_56_1.time_ >= 0 + var_59_3 and arg_56_1.time_ < 0 + var_59_3 + arg_59_0 and not isNil(var_59_2) and arg_56_1.var_.characterEffect1084ui_story then
				arg_56_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_56_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_59_4 = 0
			local var_59_5 = 0.675

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_4 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_6 = arg_56_1:GetWordFromCfg(319351013)
				local var_59_7 = arg_56_1:FormatText(var_59_6.content)

				arg_56_1.text_.text = var_59_7

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_9 = 27 <= 0 and var_59_5 or var_59_5 * (utf8.len(var_59_7) / 27)

				if (27 <= 0 and var_59_5 or var_59_5 * (utf8.len(var_59_7) / 27)) > 0 and var_59_5 < var_59_9 then
					arg_56_1.talkMaxDuration = var_59_9

					if var_59_9 + var_59_4 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_9 + var_59_4
					end
				end

				arg_56_1.text_.text = var_59_7
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319351", "319351013", "story_v_out_319351.awb") ~= 0 then
					local var_59_10 = manager.audio:GetVoiceLength("story_v_out_319351", "319351013", "story_v_out_319351.awb") / 1000

					if var_59_10 + var_59_4 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_10 + var_59_4
					end

					if var_59_6.prefab_name ~= "" and arg_56_1.actors_[var_59_6.prefab_name] ~= nil then
						local var_59_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_6.prefab_name].transform, "story_v_out_319351", "319351013", "story_v_out_319351.awb")

						arg_56_1:RecordAudio("319351013", var_59_11)
						arg_56_1:RecordAudio("319351013", var_59_11)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_319351", "319351013", "story_v_out_319351.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_319351", "319351013", "story_v_out_319351.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_12 = math.max(var_59_5, arg_56_1.talkMaxDuration)

			if var_59_4 <= arg_56_1.time_ and arg_56_1.time_ < var_59_4 + var_59_12 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_4) / var_59_12

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_4 + var_59_12 and arg_56_1.time_ < var_59_4 + var_59_12 + arg_59_0 then
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
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.var_.moveOldPos10058ui_story = arg_60_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_63_0 = 0.001

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_0 then
				arg_60_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos10058ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_60_1.time_ - 0) / var_63_0)
				arg_60_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_60_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["10058ui_story"].transform.position).z)
				arg_60_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_60_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_60_1.actors_["10058ui_story"].transform.localEulerAngles = arg_60_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_60_1.time_ >= 0 + var_63_0 and arg_60_1.time_ < 0 + var_63_0 + arg_63_0 then
				arg_60_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0.7, -0.98, -6.1)
				arg_60_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_60_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["10058ui_story"].transform.position).z)
				arg_60_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_60_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_60_1.actors_["10058ui_story"].transform.localEulerAngles = arg_60_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_63_1 = arg_60_1.actors_["10058ui_story"]

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(var_63_1) and arg_60_1.var_.characterEffect10058ui_story == nil then
				arg_60_1.var_.characterEffect10058ui_story = var_63_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_2 = 0.200000002980232

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_2 and not isNil(var_63_1) then
				if arg_60_1.var_.characterEffect10058ui_story and not isNil(var_63_1) then
					arg_60_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= 0 + var_63_2 and arg_60_1.time_ < 0 + var_63_2 + arg_63_0 and not isNil(var_63_1) and arg_60_1.var_.characterEffect10058ui_story then
				arg_60_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_63_4 = 0
			local var_63_5 = 0.7

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_4 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_6 = arg_60_1:GetWordFromCfg(319351014)
				local var_63_7 = arg_60_1:FormatText(var_63_6.content)

				arg_60_1.text_.text = var_63_7

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_9 = 28 <= 0 and var_63_5 or var_63_5 * (utf8.len(var_63_7) / 28)

				if (28 <= 0 and var_63_5 or var_63_5 * (utf8.len(var_63_7) / 28)) > 0 and var_63_5 < var_63_9 then
					arg_60_1.talkMaxDuration = var_63_9

					if var_63_9 + var_63_4 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_9 + var_63_4
					end
				end

				arg_60_1.text_.text = var_63_7
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319351", "319351014", "story_v_out_319351.awb") ~= 0 then
					local var_63_10 = manager.audio:GetVoiceLength("story_v_out_319351", "319351014", "story_v_out_319351.awb") / 1000

					if var_63_10 + var_63_4 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_10 + var_63_4
					end

					if var_63_6.prefab_name ~= "" and arg_60_1.actors_[var_63_6.prefab_name] ~= nil then
						local var_63_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_6.prefab_name].transform, "story_v_out_319351", "319351014", "story_v_out_319351.awb")

						arg_60_1:RecordAudio("319351014", var_63_11)
						arg_60_1:RecordAudio("319351014", var_63_11)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_319351", "319351014", "story_v_out_319351.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_319351", "319351014", "story_v_out_319351.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_12 = math.max(var_63_5, arg_60_1.talkMaxDuration)

			if var_63_4 <= arg_60_1.time_ and arg_60_1.time_ < var_63_4 + var_63_12 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_4) / var_63_12

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_4 + var_63_12 and arg_60_1.time_ < var_63_4 + var_63_12 + arg_63_0 then
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
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(arg_64_1.actors_["10058ui_story"]) and arg_64_1.var_.characterEffect10058ui_story == nil then
				arg_64_1.var_.characterEffect10058ui_story = arg_64_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_0 = 0.200000002980232

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_0 and not isNil(arg_64_1.actors_["10058ui_story"]) then
				if arg_64_1.var_.characterEffect10058ui_story and not isNil(arg_64_1.actors_["10058ui_story"]) then
					arg_64_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_64_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_64_1.time_ - 0) / var_67_0)
				end
			end

			if arg_64_1.time_ >= 0 + var_67_0 and arg_64_1.time_ < 0 + var_67_0 + arg_67_0 and not isNil(arg_64_1.actors_["10058ui_story"]) and arg_64_1.var_.characterEffect10058ui_story then
				arg_64_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_64_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_67_1 = 0
			local var_67_2 = 1

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, false)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_3 = arg_64_1:FormatText(arg_64_1:GetWordFromCfg(319351015).content)

				arg_64_1.text_.text = var_67_3

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_5 = 40 <= 0 and var_67_2 or var_67_2 * (utf8.len(var_67_3) / 40)

				if (40 <= 0 and var_67_2 or var_67_2 * (utf8.len(var_67_3) / 40)) > 0 and var_67_2 < var_67_5 then
					arg_64_1.talkMaxDuration = var_67_5

					if var_67_5 + var_67_1 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_5 + var_67_1
					end
				end

				arg_64_1.text_.text = var_67_3
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_6 = math.max(var_67_2, arg_64_1.talkMaxDuration)

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_6 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_1) / var_67_6

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_1 + var_67_6 and arg_64_1.time_ < var_67_1 + var_67_6 + arg_67_0 then
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
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(arg_68_1.actors_["10058ui_story"]) and arg_68_1.var_.characterEffect10058ui_story == nil then
				arg_68_1.var_.characterEffect10058ui_story = arg_68_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_0 = 0.200000002980232

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_0 and not isNil(arg_68_1.actors_["10058ui_story"]) then
				if arg_68_1.var_.characterEffect10058ui_story and not isNil(arg_68_1.actors_["10058ui_story"]) then
					arg_68_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= 0 + var_71_0 and arg_68_1.time_ < 0 + var_71_0 + arg_71_0 and not isNil(arg_68_1.actors_["10058ui_story"]) and arg_68_1.var_.characterEffect10058ui_story then
				arg_68_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 1.36666666666667 < arg_68_1.time_ and arg_68_1.time_ <= 1.36666666666667 + arg_71_0 then
				local var_71_2 = arg_68_1.bgs_.STblack

				arg_68_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_71_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_71_3 = var_71_2:GetComponent("SpriteRenderer")

				if var_71_3 and var_71_3.sprite then
					local var_71_4 = 2 * (var_71_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_71_2.transform.localScale = Vector3.New(var_71_4 / var_71_3.sprite.bounds.size.y < var_71_4 * manager.ui.mainCameraCom_.aspect / var_71_3.sprite.bounds.size.x and var_71_4 * manager.ui.mainCameraCom_.aspect / var_71_3.sprite.bounds.size.x or var_71_4 / var_71_3.sprite.bounds.size.y, var_71_4 / var_71_3.sprite.bounds.size.y < var_71_4 * manager.ui.mainCameraCom_.aspect / var_71_3.sprite.bounds.size.x and var_71_4 * manager.ui.mainCameraCom_.aspect / var_71_3.sprite.bounds.size.x or var_71_4 / var_71_3.sprite.bounds.size.y, 0)
				end

				for iter_71_0, iter_71_1 in pairs(arg_68_1.bgs_) do
					if iter_71_0 ~= "STblack" then
						iter_71_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_71_5 = 0

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_5 + arg_71_0 then
				arg_68_1.mask_.enabled = true
				arg_68_1.mask_.raycastTarget = true

				arg_68_1:SetGaussion(false)
			end

			local var_71_6 = 1.36666666666667

			if var_71_5 <= arg_68_1.time_ and arg_68_1.time_ < var_71_5 + var_71_6 then
				local var_71_7 = Color.New(0, 0, 0)

				var_71_7.a = Mathf.Lerp(0, 1, (arg_68_1.time_ - var_71_5) / var_71_6)
				arg_68_1.mask_.color = var_71_7
			end

			if arg_68_1.time_ >= var_71_5 + var_71_6 and arg_68_1.time_ < var_71_5 + var_71_6 + arg_71_0 then
				local var_71_8 = Color.New(0, 0, 0)

				var_71_8.a = 1
				arg_68_1.mask_.color = var_71_8
			end

			local var_71_9 = 1.36666666666667

			if 1.36666666666667 < arg_68_1.time_ and arg_68_1.time_ <= var_71_9 + arg_71_0 then
				arg_68_1.mask_.enabled = true
				arg_68_1.mask_.raycastTarget = true

				arg_68_1:SetGaussion(false)
			end

			local var_71_10 = 2

			if var_71_9 <= arg_68_1.time_ and arg_68_1.time_ < var_71_9 + var_71_10 then
				local var_71_11 = Color.New(0, 0, 0)

				var_71_11.a = Mathf.Lerp(1, 0, (arg_68_1.time_ - var_71_9) / var_71_10)
				arg_68_1.mask_.color = var_71_11
			end

			if arg_68_1.time_ >= var_71_9 + var_71_10 and arg_68_1.time_ < var_71_9 + var_71_10 + arg_71_0 then
				local var_71_12 = Color.New(0, 0, 0)

				arg_68_1.mask_.enabled = false
				var_71_12.a = 0
				arg_68_1.mask_.color = var_71_12
			end

			local var_71_13 = arg_68_1.actors_["10058ui_story"].transform

			if 1.36666666666667 < arg_68_1.time_ and arg_68_1.time_ <= 1.36666666666667 + arg_71_0 then
				arg_68_1.var_.moveOldPos10058ui_story = var_71_13.localPosition
			end

			local var_71_14 = 0.001

			if 1.36666666666667 <= arg_68_1.time_ and arg_68_1.time_ < 1.36666666666667 + var_71_14 then
				var_71_13.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_68_1.time_ - 1.36666666666667) / var_71_14)
				var_71_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_71_13.position).x, (manager.ui.mainCamera.transform.position - var_71_13.position).y, (manager.ui.mainCamera.transform.position - var_71_13.position).z)
				var_71_13.localEulerAngles.z = 0
				var_71_13.localEulerAngles.x = 0
				var_71_13.localEulerAngles = var_71_13.localEulerAngles
			end

			if arg_68_1.time_ >= 1.36666666666667 + var_71_14 and arg_68_1.time_ < 1.36666666666667 + var_71_14 + arg_71_0 then
				var_71_13.localPosition = Vector3.New(0, 100, 0)
				var_71_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_71_13.position).x, (manager.ui.mainCamera.transform.position - var_71_13.position).y, (manager.ui.mainCamera.transform.position - var_71_13.position).z)
				var_71_13.localEulerAngles.z = 0
				var_71_13.localEulerAngles.x = 0
				var_71_13.localEulerAngles = var_71_13.localEulerAngles
			end

			local var_71_15 = arg_68_1.actors_["1084ui_story"].transform

			if 1.36666666666667 < arg_68_1.time_ and arg_68_1.time_ <= 1.36666666666667 + arg_71_0 then
				arg_68_1.var_.moveOldPos1084ui_story = var_71_15.localPosition
			end

			local var_71_16 = 0.001

			if 1.36666666666667 <= arg_68_1.time_ and arg_68_1.time_ < 1.36666666666667 + var_71_16 then
				var_71_15.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_68_1.time_ - 1.36666666666667) / var_71_16)
				var_71_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_71_15.position).x, (manager.ui.mainCamera.transform.position - var_71_15.position).y, (manager.ui.mainCamera.transform.position - var_71_15.position).z)
				var_71_15.localEulerAngles.z = 0
				var_71_15.localEulerAngles.x = 0
				var_71_15.localEulerAngles = var_71_15.localEulerAngles
			end

			if arg_68_1.time_ >= 1.36666666666667 + var_71_16 and arg_68_1.time_ < 1.36666666666667 + var_71_16 + arg_71_0 then
				var_71_15.localPosition = Vector3.New(0, 100, 0)
				var_71_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_71_15.position).x, (manager.ui.mainCamera.transform.position - var_71_15.position).y, (manager.ui.mainCamera.transform.position - var_71_15.position).z)
				var_71_15.localEulerAngles.z = 0
				var_71_15.localEulerAngles.x = 0
				var_71_15.localEulerAngles = var_71_15.localEulerAngles
			end

			if arg_68_1.frameCnt_ <= 1 then
				arg_68_1.dialog_:SetActive(false)
			end

			local var_71_17 = 2.43333333333333
			local var_71_18 = 0.25

			if 2.43333333333333 < arg_68_1.time_ and arg_68_1.time_ <= var_71_17 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0

				arg_68_1.dialog_:SetActive(true)

				arg_68_1.dialogCg_.alpha = 0

				local var_71_19 = LeanTween.value(arg_68_1.dialog_, 0, 1, 0.3)

				var_71_19:setOnUpdate(LuaHelper.FloatAction(function(arg_72_0)
					arg_68_1.dialogCg_.alpha = arg_72_0
				end))
				var_71_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_68_1.dialog_)
					var_71_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_68_1.duration_ = arg_68_1.duration_ + 0.3

				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[471].name)

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

				local var_71_20 = arg_68_1:GetWordFromCfg(319351016)
				local var_71_21 = arg_68_1:FormatText(var_71_20.content)

				arg_68_1.text_.text = var_71_21

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_23 = 10 <= 0 and var_71_18 or var_71_18 * (utf8.len(var_71_21) / 10)

				if (10 <= 0 and var_71_18 or var_71_18 * (utf8.len(var_71_21) / 10)) > 0 and var_71_18 < var_71_23 then
					arg_68_1.talkMaxDuration = var_71_23
					var_71_17 = var_71_17 + 0.3

					if var_71_23 + var_71_17 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_23 + var_71_17
					end
				end

				arg_68_1.text_.text = var_71_21
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319351", "319351016", "story_v_out_319351.awb") ~= 0 then
					local var_71_24 = manager.audio:GetVoiceLength("story_v_out_319351", "319351016", "story_v_out_319351.awb") / 1000

					if var_71_24 + var_71_17 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_24 + var_71_17
					end

					if var_71_20.prefab_name ~= "" and arg_68_1.actors_[var_71_20.prefab_name] ~= nil then
						local var_71_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_20.prefab_name].transform, "story_v_out_319351", "319351016", "story_v_out_319351.awb")

						arg_68_1:RecordAudio("319351016", var_71_25)
						arg_68_1:RecordAudio("319351016", var_71_25)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_319351", "319351016", "story_v_out_319351.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_319351", "319351016", "story_v_out_319351.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_26 = var_71_17 + 0.3
			local var_71_27 = math.max(var_71_18, arg_68_1.talkMaxDuration)

			if var_71_17 + 0.3 <= arg_68_1.time_ and arg_68_1.time_ < var_71_26 + var_71_27 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_26) / var_71_27

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_26 + var_71_27 and arg_68_1.time_ < var_71_26 + var_71_27 + arg_71_0 then
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
			local var_77_0 = 0.6

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				arg_74_1.leftNameTxt_.text = arg_74_1:FormatText(StoryNameCfg[696].name)

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

				local var_77_1 = arg_74_1:GetWordFromCfg(319351017)
				local var_77_2 = arg_74_1:FormatText(var_77_1.content)

				arg_74_1.text_.text = var_77_2

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_4 = 24 <= 0 and var_77_0 or var_77_0 * (utf8.len(var_77_2) / 24)

				if (24 <= 0 and var_77_0 or var_77_0 * (utf8.len(var_77_2) / 24)) > 0 and var_77_0 < var_77_4 then
					arg_74_1.talkMaxDuration = var_77_4

					if var_77_4 + 0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_4 + 0
					end
				end

				arg_74_1.text_.text = var_77_2
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319351", "319351017", "story_v_out_319351.awb") ~= 0 then
					local var_77_5 = manager.audio:GetVoiceLength("story_v_out_319351", "319351017", "story_v_out_319351.awb") / 1000

					if var_77_5 + 0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_5 + 0
					end

					if var_77_1.prefab_name ~= "" and arg_74_1.actors_[var_77_1.prefab_name] ~= nil then
						local var_77_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_1.prefab_name].transform, "story_v_out_319351", "319351017", "story_v_out_319351.awb")

						arg_74_1:RecordAudio("319351017", var_77_6)
						arg_74_1:RecordAudio("319351017", var_77_6)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_319351", "319351017", "story_v_out_319351.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_319351", "319351017", "story_v_out_319351.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_7 = math.max(var_77_0, arg_74_1.talkMaxDuration)

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_7 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - 0) / var_77_7

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= 0 + var_77_7 and arg_74_1.time_ < 0 + var_77_7 + arg_77_0 then
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
			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 and not isNil(arg_78_1.actors_["10058ui_story"]) and arg_78_1.var_.characterEffect10058ui_story == nil then
				arg_78_1.var_.characterEffect10058ui_story = arg_78_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_0 = 0.200000002980232

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_0 and not isNil(arg_78_1.actors_["10058ui_story"]) then
				if arg_78_1.var_.characterEffect10058ui_story and not isNil(arg_78_1.actors_["10058ui_story"]) then
					arg_78_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_78_1.time_ >= 0 + var_81_0 and arg_78_1.time_ < 0 + var_81_0 + arg_81_0 and not isNil(arg_78_1.actors_["10058ui_story"]) and arg_78_1.var_.characterEffect10058ui_story then
				arg_78_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_81_2 = arg_78_1.actors_["1084ui_story"]

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 and not isNil(var_81_2) and arg_78_1.var_.characterEffect1084ui_story == nil then
				arg_78_1.var_.characterEffect1084ui_story = var_81_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_3 = 0.200000002980232

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_3 and not isNil(var_81_2) then
				if arg_78_1.var_.characterEffect1084ui_story and not isNil(var_81_2) then
					arg_78_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_78_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_78_1.time_ - 0) / var_81_3)
				end
			end

			if arg_78_1.time_ >= 0 + var_81_3 and arg_78_1.time_ < 0 + var_81_3 + arg_81_0 and not isNil(var_81_2) and arg_78_1.var_.characterEffect1084ui_story then
				arg_78_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_78_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_81_4 = 0
			local var_81_5 = 0.25

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_4 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				arg_78_1.leftNameTxt_.text = arg_78_1:FormatText(StoryNameCfg[471].name)

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

				local var_81_6 = arg_78_1:GetWordFromCfg(319351018)
				local var_81_7 = arg_78_1:FormatText(var_81_6.content)

				arg_78_1.text_.text = var_81_7

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_9 = 10 <= 0 and var_81_5 or var_81_5 * (utf8.len(var_81_7) / 10)

				if (10 <= 0 and var_81_5 or var_81_5 * (utf8.len(var_81_7) / 10)) > 0 and var_81_5 < var_81_9 then
					arg_78_1.talkMaxDuration = var_81_9

					if var_81_9 + var_81_4 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_9 + var_81_4
					end
				end

				arg_78_1.text_.text = var_81_7
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319351", "319351018", "story_v_out_319351.awb") ~= 0 then
					local var_81_10 = manager.audio:GetVoiceLength("story_v_out_319351", "319351018", "story_v_out_319351.awb") / 1000

					if var_81_10 + var_81_4 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_10 + var_81_4
					end

					if var_81_6.prefab_name ~= "" and arg_78_1.actors_[var_81_6.prefab_name] ~= nil then
						local var_81_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_6.prefab_name].transform, "story_v_out_319351", "319351018", "story_v_out_319351.awb")

						arg_78_1:RecordAudio("319351018", var_81_11)
						arg_78_1:RecordAudio("319351018", var_81_11)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_319351", "319351018", "story_v_out_319351.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_319351", "319351018", "story_v_out_319351.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_12 = math.max(var_81_5, arg_78_1.talkMaxDuration)

			if var_81_4 <= arg_78_1.time_ and arg_78_1.time_ < var_81_4 + var_81_12 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_4) / var_81_12

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_4 + var_81_12 and arg_78_1.time_ < var_81_4 + var_81_12 + arg_81_0 then
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
			local var_85_0 = 0.575

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[471].name)

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

				local var_85_1 = arg_82_1:GetWordFromCfg(319351019)
				local var_85_2 = arg_82_1:FormatText(var_85_1.content)

				arg_82_1.text_.text = var_85_2

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_4 = 23 <= 0 and var_85_0 or var_85_0 * (utf8.len(var_85_2) / 23)

				if (23 <= 0 and var_85_0 or var_85_0 * (utf8.len(var_85_2) / 23)) > 0 and var_85_0 < var_85_4 then
					arg_82_1.talkMaxDuration = var_85_4

					if var_85_4 + 0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_4 + 0
					end
				end

				arg_82_1.text_.text = var_85_2
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319351", "319351019", "story_v_out_319351.awb") ~= 0 then
					local var_85_5 = manager.audio:GetVoiceLength("story_v_out_319351", "319351019", "story_v_out_319351.awb") / 1000

					if var_85_5 + 0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_5 + 0
					end

					if var_85_1.prefab_name ~= "" and arg_82_1.actors_[var_85_1.prefab_name] ~= nil then
						local var_85_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_1.prefab_name].transform, "story_v_out_319351", "319351019", "story_v_out_319351.awb")

						arg_82_1:RecordAudio("319351019", var_85_6)
						arg_82_1:RecordAudio("319351019", var_85_6)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_319351", "319351019", "story_v_out_319351.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_319351", "319351019", "story_v_out_319351.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_7 = math.max(var_85_0, arg_82_1.talkMaxDuration)

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_7 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - 0) / var_85_7

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= 0 + var_85_7 and arg_82_1.time_ < 0 + var_85_7 + arg_85_0 then
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
			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1:AudioAction("stop", "effect", "se_story_130", "se_story_130_didi", "")
			end

			local var_89_1 = arg_86_1.actors_["10058ui_story"]

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(var_89_1) and arg_86_1.var_.characterEffect10058ui_story == nil then
				arg_86_1.var_.characterEffect10058ui_story = var_89_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_2 = 0.200000002980232

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_2 and not isNil(var_89_1) then
				if arg_86_1.var_.characterEffect10058ui_story and not isNil(var_89_1) then
					arg_86_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_86_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_86_1.time_ - 0) / var_89_2)
				end
			end

			if arg_86_1.time_ >= 0 + var_89_2 and arg_86_1.time_ < 0 + var_89_2 + arg_89_0 and not isNil(var_89_1) and arg_86_1.var_.characterEffect10058ui_story then
				arg_86_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_86_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_89_3 = 0
			local var_89_4 = 0.875

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_3 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, false)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_5 = arg_86_1:FormatText(arg_86_1:GetWordFromCfg(319351020).content)

				arg_86_1.text_.text = var_89_5

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_7 = 35 <= 0 and var_89_4 or var_89_4 * (utf8.len(var_89_5) / 35)

				if (35 <= 0 and var_89_4 or var_89_4 * (utf8.len(var_89_5) / 35)) > 0 and var_89_4 < var_89_7 then
					arg_86_1.talkMaxDuration = var_89_7

					if var_89_7 + var_89_3 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_7 + var_89_3
					end
				end

				arg_86_1.text_.text = var_89_5
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_8 = math.max(var_89_4, arg_86_1.talkMaxDuration)

			if var_89_3 <= arg_86_1.time_ and arg_86_1.time_ < var_89_3 + var_89_8 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_3) / var_89_8

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_3 + var_89_8 and arg_86_1.time_ < var_89_3 + var_89_8 + arg_89_0 then
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
			if 3 < arg_90_1.time_ and arg_90_1.time_ <= 3 + arg_93_0 and not isNil(arg_90_1.actors_["10058ui_story"]) and arg_90_1.var_.characterEffect10058ui_story == nil then
				arg_90_1.var_.characterEffect10058ui_story = arg_90_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_0 = 0.200000002980232

			if 3 <= arg_90_1.time_ and arg_90_1.time_ < 3 + var_93_0 and not isNil(arg_90_1.actors_["10058ui_story"]) then
				if arg_90_1.var_.characterEffect10058ui_story and not isNil(arg_90_1.actors_["10058ui_story"]) then
					arg_90_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_90_1.time_ >= 3 + var_93_0 and arg_90_1.time_ < 3 + var_93_0 + arg_93_0 and not isNil(arg_90_1.actors_["10058ui_story"]) and arg_90_1.var_.characterEffect10058ui_story then
				arg_90_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 3 < arg_90_1.time_ and arg_90_1.time_ <= 3 + arg_93_0 then
				arg_90_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 3 < arg_90_1.time_ and arg_90_1.time_ <= 3 + arg_93_0 then
				arg_90_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_93_2 = arg_90_1.actors_["10058ui_story"].transform

			if 3 < arg_90_1.time_ and arg_90_1.time_ <= 3 + arg_93_0 then
				arg_90_1.var_.moveOldPos10058ui_story = var_93_2.localPosition
			end

			local var_93_3 = 0.001

			if 3 <= arg_90_1.time_ and arg_90_1.time_ < 3 + var_93_3 then
				var_93_2.localPosition = Vector3.Lerp(arg_90_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_90_1.time_ - 3) / var_93_3)
				var_93_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_93_2.position).x, (manager.ui.mainCamera.transform.position - var_93_2.position).y, (manager.ui.mainCamera.transform.position - var_93_2.position).z)
				var_93_2.localEulerAngles.z = 0
				var_93_2.localEulerAngles.x = 0
				var_93_2.localEulerAngles = var_93_2.localEulerAngles
			end

			if arg_90_1.time_ >= 3 + var_93_3 and arg_90_1.time_ < 3 + var_93_3 + arg_93_0 then
				var_93_2.localPosition = Vector3.New(0, -0.98, -6.1)
				var_93_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_93_2.position).x, (manager.ui.mainCamera.transform.position - var_93_2.position).y, (manager.ui.mainCamera.transform.position - var_93_2.position).z)
				var_93_2.localEulerAngles.z = 0
				var_93_2.localEulerAngles.x = 0
				var_93_2.localEulerAngles = var_93_2.localEulerAngles
			end

			if 1 < arg_90_1.time_ and arg_90_1.time_ <= 1 + arg_93_0 then
				local var_93_4 = arg_90_1.bgs_.ST74

				arg_90_1.bgs_.ST74.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_93_4.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_93_5 = var_93_4:GetComponent("SpriteRenderer")

				if var_93_5 and var_93_5.sprite then
					local var_93_6 = 2 * (var_93_4.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_93_4.transform.localScale = Vector3.New(var_93_6 / var_93_5.sprite.bounds.size.y < var_93_6 * manager.ui.mainCameraCom_.aspect / var_93_5.sprite.bounds.size.x and var_93_6 * manager.ui.mainCameraCom_.aspect / var_93_5.sprite.bounds.size.x or var_93_6 / var_93_5.sprite.bounds.size.y, var_93_6 / var_93_5.sprite.bounds.size.y < var_93_6 * manager.ui.mainCameraCom_.aspect / var_93_5.sprite.bounds.size.x and var_93_6 * manager.ui.mainCameraCom_.aspect / var_93_5.sprite.bounds.size.x or var_93_6 / var_93_5.sprite.bounds.size.y, 0)
				end

				for iter_93_0, iter_93_1 in pairs(arg_90_1.bgs_) do
					if iter_93_0 ~= "ST74" then
						iter_93_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_93_7 = 0

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_7 + arg_93_0 then
				arg_90_1.mask_.enabled = true
				arg_90_1.mask_.raycastTarget = true

				arg_90_1:SetGaussion(false)
			end

			local var_93_8 = 1

			if var_93_7 <= arg_90_1.time_ and arg_90_1.time_ < var_93_7 + var_93_8 then
				local var_93_9 = Color.New(0, 0, 0)

				var_93_9.a = Mathf.Lerp(0, 1, (arg_90_1.time_ - var_93_7) / var_93_8)
				arg_90_1.mask_.color = var_93_9
			end

			if arg_90_1.time_ >= var_93_7 + var_93_8 and arg_90_1.time_ < var_93_7 + var_93_8 + arg_93_0 then
				local var_93_10 = Color.New(0, 0, 0)

				var_93_10.a = 1
				arg_90_1.mask_.color = var_93_10
			end

			local var_93_11 = 1

			if 1 < arg_90_1.time_ and arg_90_1.time_ <= var_93_11 + arg_93_0 then
				arg_90_1.mask_.enabled = true
				arg_90_1.mask_.raycastTarget = true

				arg_90_1:SetGaussion(false)
			end

			local var_93_12 = 2

			if var_93_11 <= arg_90_1.time_ and arg_90_1.time_ < var_93_11 + var_93_12 then
				local var_93_13 = Color.New(0, 0, 0)

				var_93_13.a = Mathf.Lerp(1, 0, (arg_90_1.time_ - var_93_11) / var_93_12)
				arg_90_1.mask_.color = var_93_13
			end

			if arg_90_1.time_ >= var_93_11 + var_93_12 and arg_90_1.time_ < var_93_11 + var_93_12 + arg_93_0 then
				local var_93_14 = Color.New(0, 0, 0)

				arg_90_1.mask_.enabled = false
				var_93_14.a = 0
				arg_90_1.mask_.color = var_93_14
			end

			local var_93_15 = 2.66666666666667
			local var_93_16 = 0.925

			if 2.66666666666667 < arg_90_1.time_ and arg_90_1.time_ <= var_93_15 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_17 = arg_90_1:GetWordFromCfg(319351021)
				local var_93_18 = arg_90_1:FormatText(var_93_17.content)

				arg_90_1.text_.text = var_93_18

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_20 = 37 <= 0 and var_93_16 or var_93_16 * (utf8.len(var_93_18) / 37)

				if (37 <= 0 and var_93_16 or var_93_16 * (utf8.len(var_93_18) / 37)) > 0 and var_93_16 < var_93_20 then
					arg_90_1.talkMaxDuration = var_93_20

					if var_93_20 + var_93_15 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_20 + var_93_15
					end
				end

				arg_90_1.text_.text = var_93_18
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319351", "319351021", "story_v_out_319351.awb") ~= 0 then
					local var_93_21 = manager.audio:GetVoiceLength("story_v_out_319351", "319351021", "story_v_out_319351.awb") / 1000

					if var_93_21 + var_93_15 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_21 + var_93_15
					end

					if var_93_17.prefab_name ~= "" and arg_90_1.actors_[var_93_17.prefab_name] ~= nil then
						local var_93_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_17.prefab_name].transform, "story_v_out_319351", "319351021", "story_v_out_319351.awb")

						arg_90_1:RecordAudio("319351021", var_93_22)
						arg_90_1:RecordAudio("319351021", var_93_22)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_319351", "319351021", "story_v_out_319351.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_319351", "319351021", "story_v_out_319351.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_23 = math.max(var_93_16, arg_90_1.talkMaxDuration)

			if var_93_15 <= arg_90_1.time_ and arg_90_1.time_ < var_93_15 + var_93_23 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_15) / var_93_23

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_15 + var_93_23 and arg_90_1.time_ < var_93_15 + var_93_23 + arg_93_0 then
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
			local var_97_0 = 1.3

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_1 = arg_94_1:GetWordFromCfg(319351022)
				local var_97_2 = arg_94_1:FormatText(var_97_1.content)

				arg_94_1.text_.text = var_97_2

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_4 = 52 <= 0 and var_97_0 or var_97_0 * (utf8.len(var_97_2) / 52)

				if (52 <= 0 and var_97_0 or var_97_0 * (utf8.len(var_97_2) / 52)) > 0 and var_97_0 < var_97_4 then
					arg_94_1.talkMaxDuration = var_97_4

					if var_97_4 + 0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_4 + 0
					end
				end

				arg_94_1.text_.text = var_97_2
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319351", "319351022", "story_v_out_319351.awb") ~= 0 then
					local var_97_5 = manager.audio:GetVoiceLength("story_v_out_319351", "319351022", "story_v_out_319351.awb") / 1000

					if var_97_5 + 0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_5 + 0
					end

					if var_97_1.prefab_name ~= "" and arg_94_1.actors_[var_97_1.prefab_name] ~= nil then
						local var_97_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_1.prefab_name].transform, "story_v_out_319351", "319351022", "story_v_out_319351.awb")

						arg_94_1:RecordAudio("319351022", var_97_6)
						arg_94_1:RecordAudio("319351022", var_97_6)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_319351", "319351022", "story_v_out_319351.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_319351", "319351022", "story_v_out_319351.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_7 = math.max(var_97_0, arg_94_1.talkMaxDuration)

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_7 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - 0) / var_97_7

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= 0 + var_97_7 and arg_94_1.time_ < 0 + var_97_7 + arg_97_0 then
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
			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(arg_98_1.actors_["10058ui_story"]) and arg_98_1.var_.characterEffect10058ui_story == nil then
				arg_98_1.var_.characterEffect10058ui_story = arg_98_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_0 = 0.200000002980232

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_0 and not isNil(arg_98_1.actors_["10058ui_story"]) then
				if arg_98_1.var_.characterEffect10058ui_story and not isNil(arg_98_1.actors_["10058ui_story"]) then
					arg_98_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_98_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_98_1.time_ - 0) / var_101_0)
				end
			end

			if arg_98_1.time_ >= 0 + var_101_0 and arg_98_1.time_ < 0 + var_101_0 + arg_101_0 and not isNil(arg_98_1.actors_["10058ui_story"]) and arg_98_1.var_.characterEffect10058ui_story then
				arg_98_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_98_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_101_1 = arg_98_1.actors_["1084ui_story"].transform

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.var_.moveOldPos1084ui_story = var_101_1.localPosition

				arg_98_1:ShowWeapon(arg_98_1.var_["1084ui_story" .. "Animator"].transform, false)
			end

			local var_101_2 = 0.001

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_2 then
				var_101_1.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_98_1.time_ - 0) / var_101_2)
				var_101_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_101_1.position).x, (manager.ui.mainCamera.transform.position - var_101_1.position).y, (manager.ui.mainCamera.transform.position - var_101_1.position).z)
				var_101_1.localEulerAngles.z = 0
				var_101_1.localEulerAngles.x = 0
				var_101_1.localEulerAngles = var_101_1.localEulerAngles
			end

			if arg_98_1.time_ >= 0 + var_101_2 and arg_98_1.time_ < 0 + var_101_2 + arg_101_0 then
				var_101_1.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_101_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_101_1.position).x, (manager.ui.mainCamera.transform.position - var_101_1.position).y, (manager.ui.mainCamera.transform.position - var_101_1.position).z)
				var_101_1.localEulerAngles.z = 0
				var_101_1.localEulerAngles.x = 0
				var_101_1.localEulerAngles = var_101_1.localEulerAngles
			end

			local var_101_3 = arg_98_1.actors_["1084ui_story"]

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(var_101_3) and arg_98_1.var_.characterEffect1084ui_story == nil then
				arg_98_1.var_.characterEffect1084ui_story = var_101_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_4 = 0.200000002980232

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_4 and not isNil(var_101_3) then
				if arg_98_1.var_.characterEffect1084ui_story and not isNil(var_101_3) then
					arg_98_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_98_1.time_ >= 0 + var_101_4 and arg_98_1.time_ < 0 + var_101_4 + arg_101_0 and not isNil(var_101_3) and arg_98_1.var_.characterEffect1084ui_story then
				arg_98_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_101_6 = arg_98_1.actors_["10058ui_story"].transform

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.var_.moveOldPos10058ui_story = var_101_6.localPosition
			end

			local var_101_7 = 0.001

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_7 then
				var_101_6.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos10058ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_98_1.time_ - 0) / var_101_7)
				var_101_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_101_6.position).x, (manager.ui.mainCamera.transform.position - var_101_6.position).y, (manager.ui.mainCamera.transform.position - var_101_6.position).z)
				var_101_6.localEulerAngles.z = 0
				var_101_6.localEulerAngles.x = 0
				var_101_6.localEulerAngles = var_101_6.localEulerAngles
			end

			if arg_98_1.time_ >= 0 + var_101_7 and arg_98_1.time_ < 0 + var_101_7 + arg_101_0 then
				var_101_6.localPosition = Vector3.New(0.7, -0.98, -6.1)
				var_101_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_101_6.position).x, (manager.ui.mainCamera.transform.position - var_101_6.position).y, (manager.ui.mainCamera.transform.position - var_101_6.position).z)
				var_101_6.localEulerAngles.z = 0
				var_101_6.localEulerAngles.x = 0
				var_101_6.localEulerAngles = var_101_6.localEulerAngles
			end

			local var_101_8 = 0
			local var_101_9 = 0.225

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_8 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_10 = arg_98_1:GetWordFromCfg(319351023)
				local var_101_11 = arg_98_1:FormatText(var_101_10.content)

				arg_98_1.text_.text = var_101_11

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_13 = 9 <= 0 and var_101_9 or var_101_9 * (utf8.len(var_101_11) / 9)

				if (9 <= 0 and var_101_9 or var_101_9 * (utf8.len(var_101_11) / 9)) > 0 and var_101_9 < var_101_13 then
					arg_98_1.talkMaxDuration = var_101_13

					if var_101_13 + var_101_8 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_13 + var_101_8
					end
				end

				arg_98_1.text_.text = var_101_11
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319351", "319351023", "story_v_out_319351.awb") ~= 0 then
					local var_101_14 = manager.audio:GetVoiceLength("story_v_out_319351", "319351023", "story_v_out_319351.awb") / 1000

					if var_101_14 + var_101_8 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_14 + var_101_8
					end

					if var_101_10.prefab_name ~= "" and arg_98_1.actors_[var_101_10.prefab_name] ~= nil then
						local var_101_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_10.prefab_name].transform, "story_v_out_319351", "319351023", "story_v_out_319351.awb")

						arg_98_1:RecordAudio("319351023", var_101_15)
						arg_98_1:RecordAudio("319351023", var_101_15)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_319351", "319351023", "story_v_out_319351.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_319351", "319351023", "story_v_out_319351.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_16 = math.max(var_101_9, arg_98_1.talkMaxDuration)

			if var_101_8 <= arg_98_1.time_ and arg_98_1.time_ < var_101_8 + var_101_16 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_8) / var_101_16

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_8 + var_101_16 and arg_98_1.time_ < var_101_8 + var_101_16 + arg_101_0 then
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
			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(arg_102_1.actors_["10058ui_story"]) and arg_102_1.var_.characterEffect10058ui_story == nil then
				arg_102_1.var_.characterEffect10058ui_story = arg_102_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_0 = 0.200000002980232

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_0 and not isNil(arg_102_1.actors_["10058ui_story"]) then
				if arg_102_1.var_.characterEffect10058ui_story and not isNil(arg_102_1.actors_["10058ui_story"]) then
					arg_102_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= 0 + var_105_0 and arg_102_1.time_ < 0 + var_105_0 + arg_105_0 and not isNil(arg_102_1.actors_["10058ui_story"]) and arg_102_1.var_.characterEffect10058ui_story then
				arg_102_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_105_2 = arg_102_1.actors_["1084ui_story"]

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(var_105_2) and arg_102_1.var_.characterEffect1084ui_story == nil then
				arg_102_1.var_.characterEffect1084ui_story = var_105_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_3 = 0.200000002980232

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_3 and not isNil(var_105_2) then
				if arg_102_1.var_.characterEffect1084ui_story and not isNil(var_105_2) then
					arg_102_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_102_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_102_1.time_ - 0) / var_105_3)
				end
			end

			if arg_102_1.time_ >= 0 + var_105_3 and arg_102_1.time_ < 0 + var_105_3 + arg_105_0 and not isNil(var_105_2) and arg_102_1.var_.characterEffect1084ui_story then
				arg_102_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_102_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action6_1")
			end

			local var_105_4 = 0
			local var_105_5 = 0.825

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_4 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_6 = arg_102_1:GetWordFromCfg(319351024)
				local var_105_7 = arg_102_1:FormatText(var_105_6.content)

				arg_102_1.text_.text = var_105_7

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_9 = 33 <= 0 and var_105_5 or var_105_5 * (utf8.len(var_105_7) / 33)

				if (33 <= 0 and var_105_5 or var_105_5 * (utf8.len(var_105_7) / 33)) > 0 and var_105_5 < var_105_9 then
					arg_102_1.talkMaxDuration = var_105_9

					if var_105_9 + var_105_4 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_9 + var_105_4
					end
				end

				arg_102_1.text_.text = var_105_7
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319351", "319351024", "story_v_out_319351.awb") ~= 0 then
					local var_105_10 = manager.audio:GetVoiceLength("story_v_out_319351", "319351024", "story_v_out_319351.awb") / 1000

					if var_105_10 + var_105_4 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_10 + var_105_4
					end

					if var_105_6.prefab_name ~= "" and arg_102_1.actors_[var_105_6.prefab_name] ~= nil then
						local var_105_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_6.prefab_name].transform, "story_v_out_319351", "319351024", "story_v_out_319351.awb")

						arg_102_1:RecordAudio("319351024", var_105_11)
						arg_102_1:RecordAudio("319351024", var_105_11)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_319351", "319351024", "story_v_out_319351.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_319351", "319351024", "story_v_out_319351.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_12 = math.max(var_105_5, arg_102_1.talkMaxDuration)

			if var_105_4 <= arg_102_1.time_ and arg_102_1.time_ < var_105_4 + var_105_12 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_4) / var_105_12

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_4 + var_105_12 and arg_102_1.time_ < var_105_4 + var_105_12 + arg_105_0 then
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
			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.var_.moveOldPos1084ui_story = arg_106_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_109_0 = 0.001

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_0 then
				arg_106_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_106_1.time_ - 0) / var_109_0)
				arg_106_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_106_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["1084ui_story"].transform.position).z)
				arg_106_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_106_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_106_1.actors_["1084ui_story"].transform.localEulerAngles = arg_106_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_106_1.time_ >= 0 + var_109_0 and arg_106_1.time_ < 0 + var_109_0 + arg_109_0 then
				arg_106_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(-0.7, -0.97, -6)
				arg_106_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_106_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["1084ui_story"].transform.position).z)
				arg_106_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_106_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_106_1.actors_["1084ui_story"].transform.localEulerAngles = arg_106_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_109_1 = arg_106_1.actors_["1084ui_story"]

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(var_109_1) and arg_106_1.var_.characterEffect1084ui_story == nil then
				arg_106_1.var_.characterEffect1084ui_story = var_109_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_2 = 0.200000002980232

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_2 and not isNil(var_109_1) then
				if arg_106_1.var_.characterEffect1084ui_story and not isNil(var_109_1) then
					arg_106_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_106_1.time_ >= 0 + var_109_2 and arg_106_1.time_ < 0 + var_109_2 + arg_109_0 and not isNil(var_109_1) and arg_106_1.var_.characterEffect1084ui_story then
				arg_106_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_109_4 = arg_106_1.actors_["10058ui_story"]

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(var_109_4) and arg_106_1.var_.characterEffect10058ui_story == nil then
				arg_106_1.var_.characterEffect10058ui_story = var_109_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_5 = 0.200000002980232

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_5 and not isNil(var_109_4) then
				if arg_106_1.var_.characterEffect10058ui_story and not isNil(var_109_4) then
					arg_106_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_106_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_106_1.time_ - 0) / var_109_5)
				end
			end

			if arg_106_1.time_ >= 0 + var_109_5 and arg_106_1.time_ < 0 + var_109_5 + arg_109_0 and not isNil(var_109_4) and arg_106_1.var_.characterEffect10058ui_story then
				arg_106_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_106_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action437")
			end

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_109_6 = 0
			local var_109_7 = 0.6

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_6 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_8 = arg_106_1:GetWordFromCfg(319351025)
				local var_109_9 = arg_106_1:FormatText(var_109_8.content)

				arg_106_1.text_.text = var_109_9

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_11 = 24 <= 0 and var_109_7 or var_109_7 * (utf8.len(var_109_9) / 24)

				if (24 <= 0 and var_109_7 or var_109_7 * (utf8.len(var_109_9) / 24)) > 0 and var_109_7 < var_109_11 then
					arg_106_1.talkMaxDuration = var_109_11

					if var_109_11 + var_109_6 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_11 + var_109_6
					end
				end

				arg_106_1.text_.text = var_109_9
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319351", "319351025", "story_v_out_319351.awb") ~= 0 then
					local var_109_12 = manager.audio:GetVoiceLength("story_v_out_319351", "319351025", "story_v_out_319351.awb") / 1000

					if var_109_12 + var_109_6 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_12 + var_109_6
					end

					if var_109_8.prefab_name ~= "" and arg_106_1.actors_[var_109_8.prefab_name] ~= nil then
						local var_109_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_8.prefab_name].transform, "story_v_out_319351", "319351025", "story_v_out_319351.awb")

						arg_106_1:RecordAudio("319351025", var_109_13)
						arg_106_1:RecordAudio("319351025", var_109_13)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_319351", "319351025", "story_v_out_319351.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_319351", "319351025", "story_v_out_319351.awb")
				end

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
			local var_113_0 = 0.725

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_1 = arg_110_1:GetWordFromCfg(319351026)
				local var_113_2 = arg_110_1:FormatText(var_113_1.content)

				arg_110_1.text_.text = var_113_2

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_4 = 29 <= 0 and var_113_0 or var_113_0 * (utf8.len(var_113_2) / 29)

				if (29 <= 0 and var_113_0 or var_113_0 * (utf8.len(var_113_2) / 29)) > 0 and var_113_0 < var_113_4 then
					arg_110_1.talkMaxDuration = var_113_4

					if var_113_4 + 0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_4 + 0
					end
				end

				arg_110_1.text_.text = var_113_2
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319351", "319351026", "story_v_out_319351.awb") ~= 0 then
					local var_113_5 = manager.audio:GetVoiceLength("story_v_out_319351", "319351026", "story_v_out_319351.awb") / 1000

					if var_113_5 + 0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_5 + 0
					end

					if var_113_1.prefab_name ~= "" and arg_110_1.actors_[var_113_1.prefab_name] ~= nil then
						local var_113_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_1.prefab_name].transform, "story_v_out_319351", "319351026", "story_v_out_319351.awb")

						arg_110_1:RecordAudio("319351026", var_113_6)
						arg_110_1:RecordAudio("319351026", var_113_6)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_319351", "319351026", "story_v_out_319351.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_319351", "319351026", "story_v_out_319351.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_7 = math.max(var_113_0, arg_110_1.talkMaxDuration)

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_7 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - 0) / var_113_7

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= 0 + var_113_7 and arg_110_1.time_ < 0 + var_113_7 + arg_113_0 then
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
			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 and not isNil(arg_114_1.actors_["10058ui_story"]) and arg_114_1.var_.characterEffect10058ui_story == nil then
				arg_114_1.var_.characterEffect10058ui_story = arg_114_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_0 = 0.200000002980232

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_0 and not isNil(arg_114_1.actors_["10058ui_story"]) then
				if arg_114_1.var_.characterEffect10058ui_story and not isNil(arg_114_1.actors_["10058ui_story"]) then
					arg_114_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_114_1.time_ >= 0 + var_117_0 and arg_114_1.time_ < 0 + var_117_0 + arg_117_0 and not isNil(arg_114_1.actors_["10058ui_story"]) and arg_114_1.var_.characterEffect10058ui_story then
				arg_114_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_117_2 = arg_114_1.actors_["1084ui_story"]

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 and not isNil(var_117_2) and arg_114_1.var_.characterEffect1084ui_story == nil then
				arg_114_1.var_.characterEffect1084ui_story = var_117_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_3 = 0.200000002980232

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_3 and not isNil(var_117_2) then
				if arg_114_1.var_.characterEffect1084ui_story and not isNil(var_117_2) then
					arg_114_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_114_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_114_1.time_ - 0) / var_117_3)
				end
			end

			if arg_114_1.time_ >= 0 + var_117_3 and arg_114_1.time_ < 0 + var_117_3 + arg_117_0 and not isNil(var_117_2) and arg_114_1.var_.characterEffect1084ui_story then
				arg_114_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_114_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action6_2")
			end

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_117_4 = 0
			local var_117_5 = 0.075

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_4 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				arg_114_1.leftNameTxt_.text = arg_114_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_6 = arg_114_1:GetWordFromCfg(319351027)
				local var_117_7 = arg_114_1:FormatText(var_117_6.content)

				arg_114_1.text_.text = var_117_7

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_9 = 3 <= 0 and var_117_5 or var_117_5 * (utf8.len(var_117_7) / 3)

				if (3 <= 0 and var_117_5 or var_117_5 * (utf8.len(var_117_7) / 3)) > 0 and var_117_5 < var_117_9 then
					arg_114_1.talkMaxDuration = var_117_9

					if var_117_9 + var_117_4 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_9 + var_117_4
					end
				end

				arg_114_1.text_.text = var_117_7
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319351", "319351027", "story_v_out_319351.awb") ~= 0 then
					local var_117_10 = manager.audio:GetVoiceLength("story_v_out_319351", "319351027", "story_v_out_319351.awb") / 1000

					if var_117_10 + var_117_4 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_10 + var_117_4
					end

					if var_117_6.prefab_name ~= "" and arg_114_1.actors_[var_117_6.prefab_name] ~= nil then
						local var_117_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_6.prefab_name].transform, "story_v_out_319351", "319351027", "story_v_out_319351.awb")

						arg_114_1:RecordAudio("319351027", var_117_11)
						arg_114_1:RecordAudio("319351027", var_117_11)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_319351", "319351027", "story_v_out_319351.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_319351", "319351027", "story_v_out_319351.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_12 = math.max(var_117_5, arg_114_1.talkMaxDuration)

			if var_117_4 <= arg_114_1.time_ and arg_114_1.time_ < var_117_4 + var_117_12 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_4) / var_117_12

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_4 + var_117_12 and arg_114_1.time_ < var_117_4 + var_117_12 + arg_117_0 then
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
			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 and not isNil(arg_118_1.actors_["10058ui_story"]) and arg_118_1.var_.characterEffect10058ui_story == nil then
				arg_118_1.var_.characterEffect10058ui_story = arg_118_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_0 = 0.200000002980232

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_0 and not isNil(arg_118_1.actors_["10058ui_story"]) then
				if arg_118_1.var_.characterEffect10058ui_story and not isNil(arg_118_1.actors_["10058ui_story"]) then
					arg_118_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_118_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_118_1.time_ - 0) / var_121_0)
				end
			end

			if arg_118_1.time_ >= 0 + var_121_0 and arg_118_1.time_ < 0 + var_121_0 + arg_121_0 and not isNil(arg_118_1.actors_["10058ui_story"]) and arg_118_1.var_.characterEffect10058ui_story then
				arg_118_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_118_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_121_1 = arg_118_1.actors_["1084ui_story"]

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 and not isNil(var_121_1) and arg_118_1.var_.characterEffect1084ui_story == nil then
				arg_118_1.var_.characterEffect1084ui_story = var_121_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_2 = 0.200000002980232

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_2 and not isNil(var_121_1) then
				if arg_118_1.var_.characterEffect1084ui_story and not isNil(var_121_1) then
					arg_118_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_118_1.time_ >= 0 + var_121_2 and arg_118_1.time_ < 0 + var_121_2 + arg_121_0 and not isNil(var_121_1) and arg_118_1.var_.characterEffect1084ui_story then
				arg_118_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_121_4 = 0
			local var_121_5 = 0.075

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_4 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				arg_118_1.leftNameTxt_.text = arg_118_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_6 = arg_118_1:GetWordFromCfg(319351028)
				local var_121_7 = arg_118_1:FormatText(var_121_6.content)

				arg_118_1.text_.text = var_121_7

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_9 = 3 <= 0 and var_121_5 or var_121_5 * (utf8.len(var_121_7) / 3)

				if (3 <= 0 and var_121_5 or var_121_5 * (utf8.len(var_121_7) / 3)) > 0 and var_121_5 < var_121_9 then
					arg_118_1.talkMaxDuration = var_121_9

					if var_121_9 + var_121_4 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_9 + var_121_4
					end
				end

				arg_118_1.text_.text = var_121_7
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319351", "319351028", "story_v_out_319351.awb") ~= 0 then
					local var_121_10 = manager.audio:GetVoiceLength("story_v_out_319351", "319351028", "story_v_out_319351.awb") / 1000

					if var_121_10 + var_121_4 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_10 + var_121_4
					end

					if var_121_6.prefab_name ~= "" and arg_118_1.actors_[var_121_6.prefab_name] ~= nil then
						local var_121_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_6.prefab_name].transform, "story_v_out_319351", "319351028", "story_v_out_319351.awb")

						arg_118_1:RecordAudio("319351028", var_121_11)
						arg_118_1:RecordAudio("319351028", var_121_11)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_319351", "319351028", "story_v_out_319351.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_319351", "319351028", "story_v_out_319351.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_12 = math.max(var_121_5, arg_118_1.talkMaxDuration)

			if var_121_4 <= arg_118_1.time_ and arg_118_1.time_ < var_121_4 + var_121_12 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_4) / var_121_12

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_4 + var_121_12 and arg_118_1.time_ < var_121_4 + var_121_12 + arg_121_0 then
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
			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1.var_.moveOldPos10058ui_story = arg_122_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_125_0 = 0.001

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_0 then
				arg_122_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_122_1.time_ - 0) / var_125_0)
				arg_122_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_122_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_122_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_122_1.actors_["10058ui_story"].transform.position).z)
				arg_122_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_122_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_122_1.actors_["10058ui_story"].transform.localEulerAngles = arg_122_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_122_1.time_ >= 0 + var_125_0 and arg_122_1.time_ < 0 + var_125_0 + arg_125_0 then
				arg_122_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_122_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_122_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_122_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_122_1.actors_["10058ui_story"].transform.position).z)
				arg_122_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_122_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_122_1.actors_["10058ui_story"].transform.localEulerAngles = arg_122_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_125_1 = arg_122_1.actors_["10058ui_story"]

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 and not isNil(var_125_1) and arg_122_1.var_.characterEffect10058ui_story == nil then
				arg_122_1.var_.characterEffect10058ui_story = var_125_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_2 = 0.200000002980232

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_2 and not isNil(var_125_1) then
				if arg_122_1.var_.characterEffect10058ui_story and not isNil(var_125_1) then
					arg_122_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_122_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_122_1.time_ - 0) / var_125_2)
				end
			end

			if arg_122_1.time_ >= 0 + var_125_2 and arg_122_1.time_ < 0 + var_125_2 + arg_125_0 and not isNil(var_125_1) and arg_122_1.var_.characterEffect10058ui_story then
				arg_122_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_122_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_125_3 = arg_122_1.actors_["1084ui_story"].transform

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1.var_.moveOldPos1084ui_story = var_125_3.localPosition
			end

			local var_125_4 = 0.001

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_4 then
				var_125_3.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_122_1.time_ - 0) / var_125_4)
				var_125_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_125_3.position).x, (manager.ui.mainCamera.transform.position - var_125_3.position).y, (manager.ui.mainCamera.transform.position - var_125_3.position).z)
				var_125_3.localEulerAngles.z = 0
				var_125_3.localEulerAngles.x = 0
				var_125_3.localEulerAngles = var_125_3.localEulerAngles
			end

			if arg_122_1.time_ >= 0 + var_125_4 and arg_122_1.time_ < 0 + var_125_4 + arg_125_0 then
				var_125_3.localPosition = Vector3.New(0, 100, 0)
				var_125_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_125_3.position).x, (manager.ui.mainCamera.transform.position - var_125_3.position).y, (manager.ui.mainCamera.transform.position - var_125_3.position).z)
				var_125_3.localEulerAngles.z = 0
				var_125_3.localEulerAngles.x = 0
				var_125_3.localEulerAngles = var_125_3.localEulerAngles
			end

			local var_125_5 = arg_122_1.actors_["1084ui_story"]

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 and not isNil(var_125_5) and arg_122_1.var_.characterEffect1084ui_story == nil then
				arg_122_1.var_.characterEffect1084ui_story = var_125_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_6 = 0.200000002980232

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_6 and not isNil(var_125_5) then
				if arg_122_1.var_.characterEffect1084ui_story and not isNil(var_125_5) then
					arg_122_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_122_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_122_1.time_ - 0) / var_125_6)
				end
			end

			if arg_122_1.time_ >= 0 + var_125_6 and arg_122_1.time_ < 0 + var_125_6 + arg_125_0 and not isNil(var_125_5) and arg_122_1.var_.characterEffect1084ui_story then
				arg_122_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_122_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_125_7 = 0
			local var_125_8 = 1.15

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_7 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, false)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_9 = arg_122_1:FormatText(arg_122_1:GetWordFromCfg(319351029).content)

				arg_122_1.text_.text = var_125_9

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_11 = 46 <= 0 and var_125_8 or var_125_8 * (utf8.len(var_125_9) / 46)

				if (46 <= 0 and var_125_8 or var_125_8 * (utf8.len(var_125_9) / 46)) > 0 and var_125_8 < var_125_11 then
					arg_122_1.talkMaxDuration = var_125_11

					if var_125_11 + var_125_7 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_11 + var_125_7
					end
				end

				arg_122_1.text_.text = var_125_9
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_12 = math.max(var_125_8, arg_122_1.talkMaxDuration)

			if var_125_7 <= arg_122_1.time_ and arg_122_1.time_ < var_125_7 + var_125_12 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_7) / var_125_12

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_7 + var_125_12 and arg_122_1.time_ < var_125_7 + var_125_12 + arg_125_0 then
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
			if arg_126_1.actors_["1095ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1095ui_story"))) then
				local var_129_0 = Object.Instantiate(Asset.Load("Char/" .. "1095ui_story"), arg_126_1.stage_.transform)

				var_129_0.name = "1095ui_story"
				var_129_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_126_1.actors_["1095ui_story"] = var_129_0

				local var_129_1 = var_129_0:GetComponentInChildren(typeof(CharacterEffect))

				var_129_1.enabled = true

				local var_129_2 = GameObjectTools.GetOrAddComponent(var_129_0, typeof(DynamicBoneHelper))

				if var_129_2 then
					var_129_2:EnableDynamicBone(false)
				end

				arg_126_1:ShowWeapon(var_129_1.transform, false)

				arg_126_1.var_["1095ui_story" .. "Animator"] = var_129_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_126_1.var_["1095ui_story" .. "Animator"].applyRootMotion = true
				arg_126_1.var_["1095ui_story" .. "LipSync"] = var_129_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_129_3 = arg_126_1.actors_["1095ui_story"].transform

			if 2.36666666666667 < arg_126_1.time_ and arg_126_1.time_ <= 2.36666666666667 + arg_129_0 then
				arg_126_1.var_.moveOldPos1095ui_story = var_129_3.localPosition
			end

			local var_129_4 = 0.001

			if 2.36666666666667 <= arg_126_1.time_ and arg_126_1.time_ < 2.36666666666667 + var_129_4 then
				var_129_3.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_126_1.time_ - 2.36666666666667) / var_129_4)
				var_129_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_3.position).x, (manager.ui.mainCamera.transform.position - var_129_3.position).y, (manager.ui.mainCamera.transform.position - var_129_3.position).z)
				var_129_3.localEulerAngles.z = 0
				var_129_3.localEulerAngles.x = 0
				var_129_3.localEulerAngles = var_129_3.localEulerAngles
			end

			if arg_126_1.time_ >= 2.36666666666667 + var_129_4 and arg_126_1.time_ < 2.36666666666667 + var_129_4 + arg_129_0 then
				var_129_3.localPosition = Vector3.New(0, -0.98, -6.1)
				var_129_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_3.position).x, (manager.ui.mainCamera.transform.position - var_129_3.position).y, (manager.ui.mainCamera.transform.position - var_129_3.position).z)
				var_129_3.localEulerAngles.z = 0
				var_129_3.localEulerAngles.x = 0
				var_129_3.localEulerAngles = var_129_3.localEulerAngles
			end

			local var_129_5 = arg_126_1.actors_["1095ui_story"]

			if 2.36666666666667 < arg_126_1.time_ and arg_126_1.time_ <= 2.36666666666667 + arg_129_0 and not isNil(var_129_5) and arg_126_1.var_.characterEffect1095ui_story == nil then
				arg_126_1.var_.characterEffect1095ui_story = var_129_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_6 = 0.200000002980232

			if 2.36666666666667 <= arg_126_1.time_ and arg_126_1.time_ < 2.36666666666667 + var_129_6 and not isNil(var_129_5) then
				if arg_126_1.var_.characterEffect1095ui_story and not isNil(var_129_5) then
					arg_126_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_126_1.time_ >= 2.36666666666667 + var_129_6 and arg_126_1.time_ < 2.36666666666667 + var_129_6 + arg_129_0 and not isNil(var_129_5) and arg_126_1.var_.characterEffect1095ui_story then
				arg_126_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 2.36666666666667 < arg_126_1.time_ and arg_126_1.time_ <= 2.36666666666667 + arg_129_0 then
				arg_126_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 2.36666666666667 < arg_126_1.time_ and arg_126_1.time_ <= 2.36666666666667 + arg_129_0 then
				arg_126_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			if 1.4 < arg_126_1.time_ and arg_126_1.time_ <= 1.4 + arg_129_0 then
				local var_129_8 = arg_126_1.bgs_.ST74

				arg_126_1.bgs_.ST74.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_129_8.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_129_9 = var_129_8:GetComponent("SpriteRenderer")

				if var_129_9 and var_129_9.sprite then
					local var_129_10 = 2 * (var_129_8.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_129_8.transform.localScale = Vector3.New(var_129_10 / var_129_9.sprite.bounds.size.y < var_129_10 * manager.ui.mainCameraCom_.aspect / var_129_9.sprite.bounds.size.x and var_129_10 * manager.ui.mainCameraCom_.aspect / var_129_9.sprite.bounds.size.x or var_129_10 / var_129_9.sprite.bounds.size.y, var_129_10 / var_129_9.sprite.bounds.size.y < var_129_10 * manager.ui.mainCameraCom_.aspect / var_129_9.sprite.bounds.size.x and var_129_10 * manager.ui.mainCameraCom_.aspect / var_129_9.sprite.bounds.size.x or var_129_10 / var_129_9.sprite.bounds.size.y, 0)
				end

				for iter_129_0, iter_129_1 in pairs(arg_126_1.bgs_) do
					if iter_129_0 ~= "ST74" then
						iter_129_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_129_11 = 0

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_11 + arg_129_0 then
				arg_126_1.mask_.enabled = true
				arg_126_1.mask_.raycastTarget = true

				arg_126_1:SetGaussion(false)
			end

			local var_129_12 = 1.4

			if var_129_11 <= arg_126_1.time_ and arg_126_1.time_ < var_129_11 + var_129_12 then
				local var_129_13 = Color.New(0, 0, 0)

				var_129_13.a = Mathf.Lerp(0, 1, (arg_126_1.time_ - var_129_11) / var_129_12)
				arg_126_1.mask_.color = var_129_13
			end

			if arg_126_1.time_ >= var_129_11 + var_129_12 and arg_126_1.time_ < var_129_11 + var_129_12 + arg_129_0 then
				local var_129_14 = Color.New(0, 0, 0)

				var_129_14.a = 1
				arg_126_1.mask_.color = var_129_14
			end

			local var_129_15 = 1.4

			if 1.4 < arg_126_1.time_ and arg_126_1.time_ <= var_129_15 + arg_129_0 then
				arg_126_1.mask_.enabled = true
				arg_126_1.mask_.raycastTarget = true

				arg_126_1:SetGaussion(false)
			end

			local var_129_16 = 1.00066666851441

			if var_129_15 <= arg_126_1.time_ and arg_126_1.time_ < var_129_15 + var_129_16 then
				local var_129_17 = Color.New(0, 0, 0)

				var_129_17.a = Mathf.Lerp(1, 0, (arg_126_1.time_ - var_129_15) / var_129_16)
				arg_126_1.mask_.color = var_129_17
			end

			if arg_126_1.time_ >= var_129_15 + var_129_16 and arg_126_1.time_ < var_129_15 + var_129_16 + arg_129_0 then
				local var_129_18 = Color.New(0, 0, 0)

				arg_126_1.mask_.enabled = false
				var_129_18.a = 0
				arg_126_1.mask_.color = var_129_18
			end

			if arg_126_1.frameCnt_ <= 1 then
				arg_126_1.dialog_:SetActive(false)
			end

			local var_129_19 = 2.36666666666667
			local var_129_20 = 0.75

			if 2.36666666666667 < arg_126_1.time_ and arg_126_1.time_ <= var_129_19 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0

				arg_126_1.dialog_:SetActive(true)

				arg_126_1.dialogCg_.alpha = 0

				local var_129_21 = LeanTween.value(arg_126_1.dialog_, 0, 1, 0.3)

				var_129_21:setOnUpdate(LuaHelper.FloatAction(function(arg_130_0)
					arg_126_1.dialogCg_.alpha = arg_130_0
				end))
				var_129_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_126_1.dialog_)
					var_129_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_126_1.duration_ = arg_126_1.duration_ + 0.3

				SetActive(arg_126_1.leftNameGo_, true)

				arg_126_1.leftNameTxt_.text = arg_126_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_22 = arg_126_1:GetWordFromCfg(319351030)
				local var_129_23 = arg_126_1:FormatText(var_129_22.content)

				arg_126_1.text_.text = var_129_23

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_25 = 30 <= 0 and var_129_20 or var_129_20 * (utf8.len(var_129_23) / 30)

				if (30 <= 0 and var_129_20 or var_129_20 * (utf8.len(var_129_23) / 30)) > 0 and var_129_20 < var_129_25 then
					arg_126_1.talkMaxDuration = var_129_25
					var_129_19 = var_129_19 + 0.3

					if var_129_25 + var_129_19 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_25 + var_129_19
					end
				end

				arg_126_1.text_.text = var_129_23
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319351", "319351030", "story_v_out_319351.awb") ~= 0 then
					local var_129_26 = manager.audio:GetVoiceLength("story_v_out_319351", "319351030", "story_v_out_319351.awb") / 1000

					if var_129_26 + var_129_19 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_26 + var_129_19
					end

					if var_129_22.prefab_name ~= "" and arg_126_1.actors_[var_129_22.prefab_name] ~= nil then
						local var_129_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_22.prefab_name].transform, "story_v_out_319351", "319351030", "story_v_out_319351.awb")

						arg_126_1:RecordAudio("319351030", var_129_27)
						arg_126_1:RecordAudio("319351030", var_129_27)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_319351", "319351030", "story_v_out_319351.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_319351", "319351030", "story_v_out_319351.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_28 = var_129_19 + 0.3
			local var_129_29 = math.max(var_129_20, arg_126_1.talkMaxDuration)

			if var_129_19 + 0.3 <= arg_126_1.time_ and arg_126_1.time_ < var_129_28 + var_129_29 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_28) / var_129_29

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_28 + var_129_29 and arg_126_1.time_ < var_129_28 + var_129_29 + arg_129_0 then
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
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.var_.moveOldPos1084ui_story = arg_132_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_135_0 = 0.001

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_0 then
				arg_132_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_132_1.time_ - 0) / var_135_0)
				arg_132_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_132_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["1084ui_story"].transform.position).z)
				arg_132_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_132_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_132_1.actors_["1084ui_story"].transform.localEulerAngles = arg_132_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_132_1.time_ >= 0 + var_135_0 and arg_132_1.time_ < 0 + var_135_0 + arg_135_0 then
				arg_132_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(-0.7, -0.97, -6)
				arg_132_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_132_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["1084ui_story"].transform.position).z)
				arg_132_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_132_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_132_1.actors_["1084ui_story"].transform.localEulerAngles = arg_132_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_135_1 = arg_132_1.actors_["1084ui_story"]

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(var_135_1) and arg_132_1.var_.characterEffect1084ui_story == nil then
				arg_132_1.var_.characterEffect1084ui_story = var_135_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_2 = 0.200000002980232

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_2 and not isNil(var_135_1) then
				if arg_132_1.var_.characterEffect1084ui_story and not isNil(var_135_1) then
					arg_132_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_132_1.time_ >= 0 + var_135_2 and arg_132_1.time_ < 0 + var_135_2 + arg_135_0 and not isNil(var_135_1) and arg_132_1.var_.characterEffect1084ui_story then
				arg_132_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_135_4 = arg_132_1.actors_["1095ui_story"].transform

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.var_.moveOldPos1095ui_story = var_135_4.localPosition
			end

			local var_135_5 = 0.001

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_5 then
				var_135_4.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos1095ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_132_1.time_ - 0) / var_135_5)
				var_135_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_135_4.position).x, (manager.ui.mainCamera.transform.position - var_135_4.position).y, (manager.ui.mainCamera.transform.position - var_135_4.position).z)
				var_135_4.localEulerAngles.z = 0
				var_135_4.localEulerAngles.x = 0
				var_135_4.localEulerAngles = var_135_4.localEulerAngles
			end

			if arg_132_1.time_ >= 0 + var_135_5 and arg_132_1.time_ < 0 + var_135_5 + arg_135_0 then
				var_135_4.localPosition = Vector3.New(0.7, -0.98, -6.1)
				var_135_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_135_4.position).x, (manager.ui.mainCamera.transform.position - var_135_4.position).y, (manager.ui.mainCamera.transform.position - var_135_4.position).z)
				var_135_4.localEulerAngles.z = 0
				var_135_4.localEulerAngles.x = 0
				var_135_4.localEulerAngles = var_135_4.localEulerAngles
			end

			local var_135_6 = arg_132_1.actors_["1095ui_story"]

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(var_135_6) and arg_132_1.var_.characterEffect1095ui_story == nil then
				arg_132_1.var_.characterEffect1095ui_story = var_135_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_7 = 0.200000002980232

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_7 and not isNil(var_135_6) then
				if arg_132_1.var_.characterEffect1095ui_story and not isNil(var_135_6) then
					arg_132_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_132_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_132_1.time_ - 0) / var_135_7)
				end
			end

			if arg_132_1.time_ >= 0 + var_135_7 and arg_132_1.time_ < 0 + var_135_7 + arg_135_0 and not isNil(var_135_6) and arg_132_1.var_.characterEffect1095ui_story then
				arg_132_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_132_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_135_8 = 0
			local var_135_9 = 0.3

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_8 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_10 = arg_132_1:GetWordFromCfg(319351031)
				local var_135_11 = arg_132_1:FormatText(var_135_10.content)

				arg_132_1.text_.text = var_135_11

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_13 = 12 <= 0 and var_135_9 or var_135_9 * (utf8.len(var_135_11) / 12)

				if (12 <= 0 and var_135_9 or var_135_9 * (utf8.len(var_135_11) / 12)) > 0 and var_135_9 < var_135_13 then
					arg_132_1.talkMaxDuration = var_135_13

					if var_135_13 + var_135_8 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_13 + var_135_8
					end
				end

				arg_132_1.text_.text = var_135_11
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319351", "319351031", "story_v_out_319351.awb") ~= 0 then
					local var_135_14 = manager.audio:GetVoiceLength("story_v_out_319351", "319351031", "story_v_out_319351.awb") / 1000

					if var_135_14 + var_135_8 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_14 + var_135_8
					end

					if var_135_10.prefab_name ~= "" and arg_132_1.actors_[var_135_10.prefab_name] ~= nil then
						local var_135_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_10.prefab_name].transform, "story_v_out_319351", "319351031", "story_v_out_319351.awb")

						arg_132_1:RecordAudio("319351031", var_135_15)
						arg_132_1:RecordAudio("319351031", var_135_15)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_319351", "319351031", "story_v_out_319351.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_319351", "319351031", "story_v_out_319351.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_16 = math.max(var_135_9, arg_132_1.talkMaxDuration)

			if var_135_8 <= arg_132_1.time_ and arg_132_1.time_ < var_135_8 + var_135_16 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_8) / var_135_16

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_8 + var_135_16 and arg_132_1.time_ < var_135_8 + var_135_16 + arg_135_0 then
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
			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(arg_136_1.actors_["1084ui_story"]) and arg_136_1.var_.characterEffect1084ui_story == nil then
				arg_136_1.var_.characterEffect1084ui_story = arg_136_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_0 = 0.200000002980232

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_0 and not isNil(arg_136_1.actors_["1084ui_story"]) then
				if arg_136_1.var_.characterEffect1084ui_story and not isNil(arg_136_1.actors_["1084ui_story"]) then
					arg_136_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_136_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_136_1.time_ - 0) / var_139_0)
				end
			end

			if arg_136_1.time_ >= 0 + var_139_0 and arg_136_1.time_ < 0 + var_139_0 + arg_139_0 and not isNil(arg_136_1.actors_["1084ui_story"]) and arg_136_1.var_.characterEffect1084ui_story then
				arg_136_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_136_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_139_1 = arg_136_1.actors_["1095ui_story"]

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(var_139_1) and arg_136_1.var_.characterEffect1095ui_story == nil then
				arg_136_1.var_.characterEffect1095ui_story = var_139_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_2 = 0.200000002980232

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_2 and not isNil(var_139_1) then
				if arg_136_1.var_.characterEffect1095ui_story and not isNil(var_139_1) then
					arg_136_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= 0 + var_139_2 and arg_136_1.time_ < 0 + var_139_2 + arg_139_0 and not isNil(var_139_1) and arg_136_1.var_.characterEffect1095ui_story then
				arg_136_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_139_4 = 0
			local var_139_5 = 0.125

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_4 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_6 = arg_136_1:GetWordFromCfg(319351032)
				local var_139_7 = arg_136_1:FormatText(var_139_6.content)

				arg_136_1.text_.text = var_139_7

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_9 = 5 <= 0 and var_139_5 or var_139_5 * (utf8.len(var_139_7) / 5)

				if (5 <= 0 and var_139_5 or var_139_5 * (utf8.len(var_139_7) / 5)) > 0 and var_139_5 < var_139_9 then
					arg_136_1.talkMaxDuration = var_139_9

					if var_139_9 + var_139_4 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_9 + var_139_4
					end
				end

				arg_136_1.text_.text = var_139_7
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319351", "319351032", "story_v_out_319351.awb") ~= 0 then
					local var_139_10 = manager.audio:GetVoiceLength("story_v_out_319351", "319351032", "story_v_out_319351.awb") / 1000

					if var_139_10 + var_139_4 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_10 + var_139_4
					end

					if var_139_6.prefab_name ~= "" and arg_136_1.actors_[var_139_6.prefab_name] ~= nil then
						local var_139_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_6.prefab_name].transform, "story_v_out_319351", "319351032", "story_v_out_319351.awb")

						arg_136_1:RecordAudio("319351032", var_139_11)
						arg_136_1:RecordAudio("319351032", var_139_11)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_319351", "319351032", "story_v_out_319351.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_319351", "319351032", "story_v_out_319351.awb")
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
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(arg_140_1.actors_["1084ui_story"]) and arg_140_1.var_.characterEffect1084ui_story == nil then
				arg_140_1.var_.characterEffect1084ui_story = arg_140_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_0 = 0.200000002980232

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_0 and not isNil(arg_140_1.actors_["1084ui_story"]) then
				if arg_140_1.var_.characterEffect1084ui_story and not isNil(arg_140_1.actors_["1084ui_story"]) then
					arg_140_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_140_1.time_ >= 0 + var_143_0 and arg_140_1.time_ < 0 + var_143_0 + arg_143_0 and not isNil(arg_140_1.actors_["1084ui_story"]) and arg_140_1.var_.characterEffect1084ui_story then
				arg_140_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action478")
			end

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_143_2 = arg_140_1.actors_["1095ui_story"]

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(var_143_2) and arg_140_1.var_.characterEffect1095ui_story == nil then
				arg_140_1.var_.characterEffect1095ui_story = var_143_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_3 = 0.200000002980232

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_3 and not isNil(var_143_2) then
				if arg_140_1.var_.characterEffect1095ui_story and not isNil(var_143_2) then
					arg_140_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_140_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_140_1.time_ - 0) / var_143_3)
				end
			end

			if arg_140_1.time_ >= 0 + var_143_3 and arg_140_1.time_ < 0 + var_143_3 + arg_143_0 and not isNil(var_143_2) and arg_140_1.var_.characterEffect1095ui_story then
				arg_140_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_140_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_143_4 = 0
			local var_143_5 = 0.2

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_4 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_6 = arg_140_1:GetWordFromCfg(319351033)
				local var_143_7 = arg_140_1:FormatText(var_143_6.content)

				arg_140_1.text_.text = var_143_7

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_9 = 8 <= 0 and var_143_5 or var_143_5 * (utf8.len(var_143_7) / 8)

				if (8 <= 0 and var_143_5 or var_143_5 * (utf8.len(var_143_7) / 8)) > 0 and var_143_5 < var_143_9 then
					arg_140_1.talkMaxDuration = var_143_9

					if var_143_9 + var_143_4 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_9 + var_143_4
					end
				end

				arg_140_1.text_.text = var_143_7
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319351", "319351033", "story_v_out_319351.awb") ~= 0 then
					local var_143_10 = manager.audio:GetVoiceLength("story_v_out_319351", "319351033", "story_v_out_319351.awb") / 1000

					if var_143_10 + var_143_4 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_10 + var_143_4
					end

					if var_143_6.prefab_name ~= "" and arg_140_1.actors_[var_143_6.prefab_name] ~= nil then
						local var_143_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_6.prefab_name].transform, "story_v_out_319351", "319351033", "story_v_out_319351.awb")

						arg_140_1:RecordAudio("319351033", var_143_11)
						arg_140_1:RecordAudio("319351033", var_143_11)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_319351", "319351033", "story_v_out_319351.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_319351", "319351033", "story_v_out_319351.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_12 = math.max(var_143_5, arg_140_1.talkMaxDuration)

			if var_143_4 <= arg_140_1.time_ and arg_140_1.time_ < var_143_4 + var_143_12 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_4) / var_143_12

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_4 + var_143_12 and arg_140_1.time_ < var_143_4 + var_143_12 + arg_143_0 then
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
			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(arg_144_1.actors_["1084ui_story"]) and arg_144_1.var_.characterEffect1084ui_story == nil then
				arg_144_1.var_.characterEffect1084ui_story = arg_144_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_0 = 0.200000002980232

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_0 and not isNil(arg_144_1.actors_["1084ui_story"]) then
				if arg_144_1.var_.characterEffect1084ui_story and not isNil(arg_144_1.actors_["1084ui_story"]) then
					arg_144_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_144_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_144_1.time_ - 0) / var_147_0)
				end
			end

			if arg_144_1.time_ >= 0 + var_147_0 and arg_144_1.time_ < 0 + var_147_0 + arg_147_0 and not isNil(arg_144_1.actors_["1084ui_story"]) and arg_144_1.var_.characterEffect1084ui_story then
				arg_144_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_144_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_147_1 = arg_144_1.actors_["1095ui_story"]

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(var_147_1) and arg_144_1.var_.characterEffect1095ui_story == nil then
				arg_144_1.var_.characterEffect1095ui_story = var_147_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_2 = 0.200000002980232

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_2 and not isNil(var_147_1) then
				if arg_144_1.var_.characterEffect1095ui_story and not isNil(var_147_1) then
					arg_144_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_144_1.time_ >= 0 + var_147_2 and arg_144_1.time_ < 0 + var_147_2 + arg_147_0 and not isNil(var_147_1) and arg_144_1.var_.characterEffect1095ui_story then
				arg_144_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_147_4 = 0
			local var_147_5 = 1.125

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_4 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_6 = arg_144_1:GetWordFromCfg(319351034)
				local var_147_7 = arg_144_1:FormatText(var_147_6.content)

				arg_144_1.text_.text = var_147_7

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_9 = 45 <= 0 and var_147_5 or var_147_5 * (utf8.len(var_147_7) / 45)

				if (45 <= 0 and var_147_5 or var_147_5 * (utf8.len(var_147_7) / 45)) > 0 and var_147_5 < var_147_9 then
					arg_144_1.talkMaxDuration = var_147_9

					if var_147_9 + var_147_4 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_9 + var_147_4
					end
				end

				arg_144_1.text_.text = var_147_7
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319351", "319351034", "story_v_out_319351.awb") ~= 0 then
					local var_147_10 = manager.audio:GetVoiceLength("story_v_out_319351", "319351034", "story_v_out_319351.awb") / 1000

					if var_147_10 + var_147_4 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_10 + var_147_4
					end

					if var_147_6.prefab_name ~= "" and arg_144_1.actors_[var_147_6.prefab_name] ~= nil then
						local var_147_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_6.prefab_name].transform, "story_v_out_319351", "319351034", "story_v_out_319351.awb")

						arg_144_1:RecordAudio("319351034", var_147_11)
						arg_144_1:RecordAudio("319351034", var_147_11)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_319351", "319351034", "story_v_out_319351.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_319351", "319351034", "story_v_out_319351.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_12 = math.max(var_147_5, arg_144_1.talkMaxDuration)

			if var_147_4 <= arg_144_1.time_ and arg_144_1.time_ < var_147_4 + var_147_12 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_4) / var_147_12

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_4 + var_147_12 and arg_144_1.time_ < var_147_4 + var_147_12 + arg_147_0 then
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
			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_1")
			end

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_151_0 = 0
			local var_151_1 = 0.55

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_0 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				arg_148_1.leftNameTxt_.text = arg_148_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_2 = arg_148_1:GetWordFromCfg(319351035)
				local var_151_3 = arg_148_1:FormatText(var_151_2.content)

				arg_148_1.text_.text = var_151_3

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_5 = 22 <= 0 and var_151_1 or var_151_1 * (utf8.len(var_151_3) / 22)

				if (22 <= 0 and var_151_1 or var_151_1 * (utf8.len(var_151_3) / 22)) > 0 and var_151_1 < var_151_5 then
					arg_148_1.talkMaxDuration = var_151_5

					if var_151_5 + var_151_0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_5 + var_151_0
					end
				end

				arg_148_1.text_.text = var_151_3
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319351", "319351035", "story_v_out_319351.awb") ~= 0 then
					local var_151_6 = manager.audio:GetVoiceLength("story_v_out_319351", "319351035", "story_v_out_319351.awb") / 1000

					if var_151_6 + var_151_0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_6 + var_151_0
					end

					if var_151_2.prefab_name ~= "" and arg_148_1.actors_[var_151_2.prefab_name] ~= nil then
						local var_151_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_2.prefab_name].transform, "story_v_out_319351", "319351035", "story_v_out_319351.awb")

						arg_148_1:RecordAudio("319351035", var_151_7)
						arg_148_1:RecordAudio("319351035", var_151_7)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_319351", "319351035", "story_v_out_319351.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_319351", "319351035", "story_v_out_319351.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_8 = math.max(var_151_1, arg_148_1.talkMaxDuration)

			if var_151_0 <= arg_148_1.time_ and arg_148_1.time_ < var_151_0 + var_151_8 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_0) / var_151_8

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_0 + var_151_8 and arg_148_1.time_ < var_151_0 + var_151_8 + arg_151_0 then
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
			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 and not isNil(arg_152_1.actors_["1084ui_story"]) and arg_152_1.var_.characterEffect1084ui_story == nil then
				arg_152_1.var_.characterEffect1084ui_story = arg_152_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_0 = 0.200000002980232

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_0 and not isNil(arg_152_1.actors_["1084ui_story"]) then
				if arg_152_1.var_.characterEffect1084ui_story and not isNil(arg_152_1.actors_["1084ui_story"]) then
					arg_152_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= 0 + var_155_0 and arg_152_1.time_ < 0 + var_155_0 + arg_155_0 and not isNil(arg_152_1.actors_["1084ui_story"]) and arg_152_1.var_.characterEffect1084ui_story then
				arg_152_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_155_2 = arg_152_1.actors_["1095ui_story"]

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 and not isNil(var_155_2) and arg_152_1.var_.characterEffect1095ui_story == nil then
				arg_152_1.var_.characterEffect1095ui_story = var_155_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_3 = 0.200000002980232

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_3 and not isNil(var_155_2) then
				if arg_152_1.var_.characterEffect1095ui_story and not isNil(var_155_2) then
					arg_152_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_152_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_152_1.time_ - 0) / var_155_3)
				end
			end

			if arg_152_1.time_ >= 0 + var_155_3 and arg_152_1.time_ < 0 + var_155_3 + arg_155_0 and not isNil(var_155_2) and arg_152_1.var_.characterEffect1095ui_story then
				arg_152_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_152_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_2")
			end

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_155_4 = 0
			local var_155_5 = 0.075

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_4 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_6 = arg_152_1:GetWordFromCfg(319351036)
				local var_155_7 = arg_152_1:FormatText(var_155_6.content)

				arg_152_1.text_.text = var_155_7

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_9 = 3 <= 0 and var_155_5 or var_155_5 * (utf8.len(var_155_7) / 3)

				if (3 <= 0 and var_155_5 or var_155_5 * (utf8.len(var_155_7) / 3)) > 0 and var_155_5 < var_155_9 then
					arg_152_1.talkMaxDuration = var_155_9

					if var_155_9 + var_155_4 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_9 + var_155_4
					end
				end

				arg_152_1.text_.text = var_155_7
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319351", "319351036", "story_v_out_319351.awb") ~= 0 then
					local var_155_10 = manager.audio:GetVoiceLength("story_v_out_319351", "319351036", "story_v_out_319351.awb") / 1000

					if var_155_10 + var_155_4 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_10 + var_155_4
					end

					if var_155_6.prefab_name ~= "" and arg_152_1.actors_[var_155_6.prefab_name] ~= nil then
						local var_155_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_6.prefab_name].transform, "story_v_out_319351", "319351036", "story_v_out_319351.awb")

						arg_152_1:RecordAudio("319351036", var_155_11)
						arg_152_1:RecordAudio("319351036", var_155_11)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_319351", "319351036", "story_v_out_319351.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_319351", "319351036", "story_v_out_319351.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_12 = math.max(var_155_5, arg_152_1.talkMaxDuration)

			if var_155_4 <= arg_152_1.time_ and arg_152_1.time_ < var_155_4 + var_155_12 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_4) / var_155_12

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_4 + var_155_12 and arg_152_1.time_ < var_155_4 + var_155_12 + arg_155_0 then
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
			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 and not isNil(arg_156_1.actors_["1095ui_story"]) and arg_156_1.var_.characterEffect1095ui_story == nil then
				arg_156_1.var_.characterEffect1095ui_story = arg_156_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_0 = 0.200000002980232

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_0 and not isNil(arg_156_1.actors_["1095ui_story"]) then
				if arg_156_1.var_.characterEffect1095ui_story and not isNil(arg_156_1.actors_["1095ui_story"]) then
					arg_156_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_156_1.time_ >= 0 + var_159_0 and arg_156_1.time_ < 0 + var_159_0 + arg_159_0 and not isNil(arg_156_1.actors_["1095ui_story"]) and arg_156_1.var_.characterEffect1095ui_story then
				arg_156_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_159_2 = arg_156_1.actors_["1084ui_story"]

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 and not isNil(var_159_2) and arg_156_1.var_.characterEffect1084ui_story == nil then
				arg_156_1.var_.characterEffect1084ui_story = var_159_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_3 = 0.200000002980232

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_3 and not isNil(var_159_2) then
				if arg_156_1.var_.characterEffect1084ui_story and not isNil(var_159_2) then
					arg_156_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_156_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_156_1.time_ - 0) / var_159_3)
				end
			end

			if arg_156_1.time_ >= 0 + var_159_3 and arg_156_1.time_ < 0 + var_159_3 + arg_159_0 and not isNil(var_159_2) and arg_156_1.var_.characterEffect1084ui_story then
				arg_156_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_156_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_159_4 = 0
			local var_159_5 = 0.65

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_4 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				arg_156_1.leftNameTxt_.text = arg_156_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_6 = arg_156_1:GetWordFromCfg(319351037)
				local var_159_7 = arg_156_1:FormatText(var_159_6.content)

				arg_156_1.text_.text = var_159_7

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_9 = 26 <= 0 and var_159_5 or var_159_5 * (utf8.len(var_159_7) / 26)

				if (26 <= 0 and var_159_5 or var_159_5 * (utf8.len(var_159_7) / 26)) > 0 and var_159_5 < var_159_9 then
					arg_156_1.talkMaxDuration = var_159_9

					if var_159_9 + var_159_4 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_9 + var_159_4
					end
				end

				arg_156_1.text_.text = var_159_7
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319351", "319351037", "story_v_out_319351.awb") ~= 0 then
					local var_159_10 = manager.audio:GetVoiceLength("story_v_out_319351", "319351037", "story_v_out_319351.awb") / 1000

					if var_159_10 + var_159_4 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_10 + var_159_4
					end

					if var_159_6.prefab_name ~= "" and arg_156_1.actors_[var_159_6.prefab_name] ~= nil then
						local var_159_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_6.prefab_name].transform, "story_v_out_319351", "319351037", "story_v_out_319351.awb")

						arg_156_1:RecordAudio("319351037", var_159_11)
						arg_156_1:RecordAudio("319351037", var_159_11)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_319351", "319351037", "story_v_out_319351.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_319351", "319351037", "story_v_out_319351.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_12 = math.max(var_159_5, arg_156_1.talkMaxDuration)

			if var_159_4 <= arg_156_1.time_ and arg_156_1.time_ < var_159_4 + var_159_12 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_4) / var_159_12

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_4 + var_159_12 and arg_156_1.time_ < var_159_4 + var_159_12 + arg_159_0 then
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
			local var_163_0 = 0.525

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				arg_160_1.leftNameTxt_.text = arg_160_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_1 = arg_160_1:GetWordFromCfg(319351038)
				local var_163_2 = arg_160_1:FormatText(var_163_1.content)

				arg_160_1.text_.text = var_163_2

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_4 = 21 <= 0 and var_163_0 or var_163_0 * (utf8.len(var_163_2) / 21)

				if (21 <= 0 and var_163_0 or var_163_0 * (utf8.len(var_163_2) / 21)) > 0 and var_163_0 < var_163_4 then
					arg_160_1.talkMaxDuration = var_163_4

					if var_163_4 + 0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_4 + 0
					end
				end

				arg_160_1.text_.text = var_163_2
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319351", "319351038", "story_v_out_319351.awb") ~= 0 then
					local var_163_5 = manager.audio:GetVoiceLength("story_v_out_319351", "319351038", "story_v_out_319351.awb") / 1000

					if var_163_5 + 0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_5 + 0
					end

					if var_163_1.prefab_name ~= "" and arg_160_1.actors_[var_163_1.prefab_name] ~= nil then
						local var_163_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_1.prefab_name].transform, "story_v_out_319351", "319351038", "story_v_out_319351.awb")

						arg_160_1:RecordAudio("319351038", var_163_6)
						arg_160_1:RecordAudio("319351038", var_163_6)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_319351", "319351038", "story_v_out_319351.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_319351", "319351038", "story_v_out_319351.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_7 = math.max(var_163_0, arg_160_1.talkMaxDuration)

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_7 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - 0) / var_163_7

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= 0 + var_163_7 and arg_160_1.time_ < 0 + var_163_7 + arg_163_0 then
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
			if 1.36666666666667 < arg_164_1.time_ and arg_164_1.time_ <= 1.36666666666667 + arg_167_0 then
				local var_167_0 = arg_164_1.bgs_.STblack

				arg_164_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_167_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_167_1 = var_167_0:GetComponent("SpriteRenderer")

				if var_167_1 and var_167_1.sprite then
					local var_167_2 = 2 * (var_167_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_167_0.transform.localScale = Vector3.New(var_167_2 / var_167_1.sprite.bounds.size.y < var_167_2 * manager.ui.mainCameraCom_.aspect / var_167_1.sprite.bounds.size.x and var_167_2 * manager.ui.mainCameraCom_.aspect / var_167_1.sprite.bounds.size.x or var_167_2 / var_167_1.sprite.bounds.size.y, var_167_2 / var_167_1.sprite.bounds.size.y < var_167_2 * manager.ui.mainCameraCom_.aspect / var_167_1.sprite.bounds.size.x and var_167_2 * manager.ui.mainCameraCom_.aspect / var_167_1.sprite.bounds.size.x or var_167_2 / var_167_1.sprite.bounds.size.y, 0)
				end

				for iter_167_0, iter_167_1 in pairs(arg_164_1.bgs_) do
					if iter_167_0 ~= "STblack" then
						iter_167_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_167_3 = 0

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_3 + arg_167_0 then
				arg_164_1.mask_.enabled = true
				arg_164_1.mask_.raycastTarget = true

				arg_164_1:SetGaussion(false)
			end

			local var_167_4 = 1.36666666666667

			if var_167_3 <= arg_164_1.time_ and arg_164_1.time_ < var_167_3 + var_167_4 then
				local var_167_5 = Color.New(0, 0, 0)

				var_167_5.a = Mathf.Lerp(0, 1, (arg_164_1.time_ - var_167_3) / var_167_4)
				arg_164_1.mask_.color = var_167_5
			end

			if arg_164_1.time_ >= var_167_3 + var_167_4 and arg_164_1.time_ < var_167_3 + var_167_4 + arg_167_0 then
				local var_167_6 = Color.New(0, 0, 0)

				var_167_6.a = 1
				arg_164_1.mask_.color = var_167_6
			end

			local var_167_7 = 1.36666666666667

			if 1.36666666666667 < arg_164_1.time_ and arg_164_1.time_ <= var_167_7 + arg_167_0 then
				arg_164_1.mask_.enabled = true
				arg_164_1.mask_.raycastTarget = true

				arg_164_1:SetGaussion(false)
			end

			local var_167_8 = 1.26666666666667

			if var_167_7 <= arg_164_1.time_ and arg_164_1.time_ < var_167_7 + var_167_8 then
				local var_167_9 = Color.New(0, 0, 0)

				var_167_9.a = Mathf.Lerp(1, 0, (arg_164_1.time_ - var_167_7) / var_167_8)
				arg_164_1.mask_.color = var_167_9
			end

			if arg_164_1.time_ >= var_167_7 + var_167_8 and arg_164_1.time_ < var_167_7 + var_167_8 + arg_167_0 then
				local var_167_10 = Color.New(0, 0, 0)

				arg_164_1.mask_.enabled = false
				var_167_10.a = 0
				arg_164_1.mask_.color = var_167_10
			end

			local var_167_11 = arg_164_1.actors_["1095ui_story"].transform

			if 1.36666666666667 < arg_164_1.time_ and arg_164_1.time_ <= 1.36666666666667 + arg_167_0 then
				arg_164_1.var_.moveOldPos1095ui_story = var_167_11.localPosition
			end

			local var_167_12 = 0.001

			if 1.36666666666667 <= arg_164_1.time_ and arg_164_1.time_ < 1.36666666666667 + var_167_12 then
				var_167_11.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_164_1.time_ - 1.36666666666667) / var_167_12)
				var_167_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_167_11.position).x, (manager.ui.mainCamera.transform.position - var_167_11.position).y, (manager.ui.mainCamera.transform.position - var_167_11.position).z)
				var_167_11.localEulerAngles.z = 0
				var_167_11.localEulerAngles.x = 0
				var_167_11.localEulerAngles = var_167_11.localEulerAngles
			end

			if arg_164_1.time_ >= 1.36666666666667 + var_167_12 and arg_164_1.time_ < 1.36666666666667 + var_167_12 + arg_167_0 then
				var_167_11.localPosition = Vector3.New(0, 100, 0)
				var_167_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_167_11.position).x, (manager.ui.mainCamera.transform.position - var_167_11.position).y, (manager.ui.mainCamera.transform.position - var_167_11.position).z)
				var_167_11.localEulerAngles.z = 0
				var_167_11.localEulerAngles.x = 0
				var_167_11.localEulerAngles = var_167_11.localEulerAngles
			end

			local var_167_13 = arg_164_1.actors_["1084ui_story"].transform

			if 1.36666666666667 < arg_164_1.time_ and arg_164_1.time_ <= 1.36666666666667 + arg_167_0 then
				arg_164_1.var_.moveOldPos1084ui_story = var_167_13.localPosition
			end

			local var_167_14 = 0.001

			if 1.36666666666667 <= arg_164_1.time_ and arg_164_1.time_ < 1.36666666666667 + var_167_14 then
				var_167_13.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_164_1.time_ - 1.36666666666667) / var_167_14)
				var_167_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_167_13.position).x, (manager.ui.mainCamera.transform.position - var_167_13.position).y, (manager.ui.mainCamera.transform.position - var_167_13.position).z)
				var_167_13.localEulerAngles.z = 0
				var_167_13.localEulerAngles.x = 0
				var_167_13.localEulerAngles = var_167_13.localEulerAngles
			end

			if arg_164_1.time_ >= 1.36666666666667 + var_167_14 and arg_164_1.time_ < 1.36666666666667 + var_167_14 + arg_167_0 then
				var_167_13.localPosition = Vector3.New(0, 100, 0)
				var_167_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_167_13.position).x, (manager.ui.mainCamera.transform.position - var_167_13.position).y, (manager.ui.mainCamera.transform.position - var_167_13.position).z)
				var_167_13.localEulerAngles.z = 0
				var_167_13.localEulerAngles.x = 0
				var_167_13.localEulerAngles = var_167_13.localEulerAngles
			end

			if arg_164_1.frameCnt_ <= 1 then
				arg_164_1.dialog_:SetActive(false)
			end

			local var_167_15 = 2.63333333333333
			local var_167_16 = 1.3

			if 2.63333333333333 < arg_164_1.time_ and arg_164_1.time_ <= var_167_15 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0

				arg_164_1.dialog_:SetActive(true)

				arg_164_1.dialogCg_.alpha = 0

				local var_167_17 = LeanTween.value(arg_164_1.dialog_, 0, 1, 0.3)

				var_167_17:setOnUpdate(LuaHelper.FloatAction(function(arg_168_0)
					arg_164_1.dialogCg_.alpha = arg_168_0
				end))
				var_167_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_164_1.dialog_)
					var_167_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_164_1.duration_ = arg_164_1.duration_ + 0.3

				SetActive(arg_164_1.leftNameGo_, false)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_18 = arg_164_1:FormatText(arg_164_1:GetWordFromCfg(319351039).content)

				arg_164_1.text_.text = var_167_18

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_20 = 52 <= 0 and var_167_16 or var_167_16 * (utf8.len(var_167_18) / 52)

				if (52 <= 0 and var_167_16 or var_167_16 * (utf8.len(var_167_18) / 52)) > 0 and var_167_16 < var_167_20 then
					arg_164_1.talkMaxDuration = var_167_20
					var_167_15 = var_167_15 + 0.3

					if var_167_20 + var_167_15 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_20 + var_167_15
					end
				end

				arg_164_1.text_.text = var_167_18
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)
				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_21 = var_167_15 + 0.3
			local var_167_22 = math.max(var_167_16, arg_164_1.talkMaxDuration)

			if var_167_15 + 0.3 <= arg_164_1.time_ and arg_164_1.time_ < var_167_21 + var_167_22 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_21) / var_167_22

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_21 + var_167_22 and arg_164_1.time_ < var_167_21 + var_167_22 + arg_167_0 then
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
			local var_173_0 = 1.35

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, false)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_1 = arg_170_1:FormatText(arg_170_1:GetWordFromCfg(319351040).content)

				arg_170_1.text_.text = var_173_1

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_3 = 54 <= 0 and var_173_0 or var_173_0 * (utf8.len(var_173_1) / 54)

				if (54 <= 0 and var_173_0 or var_173_0 * (utf8.len(var_173_1) / 54)) > 0 and var_173_0 < var_173_3 then
					arg_170_1.talkMaxDuration = var_173_3

					if var_173_3 + 0 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_3 + 0
					end
				end

				arg_170_1.text_.text = var_173_1
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)
				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_4 = math.max(var_173_0, arg_170_1.talkMaxDuration)

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_4 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - 0) / var_173_4

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= 0 + var_173_4 and arg_170_1.time_ < 0 + var_173_4 + arg_173_0 then
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
			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1.mask_.enabled = true
				arg_174_1.mask_.raycastTarget = true

				arg_174_1:SetGaussion(false)
			end

			local var_177_0 = 0.7

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_0 then
				local var_177_1 = Color.New(0.7924528, 0.4269517, 0.1084016)

				var_177_1.a = Mathf.Lerp(1, 0, (arg_174_1.time_ - 0) / var_177_0)
				arg_174_1.mask_.color = var_177_1
			end

			if arg_174_1.time_ >= 0 + var_177_0 and arg_174_1.time_ < 0 + var_177_0 + arg_177_0 then
				local var_177_2 = Color.New(0.7924528, 0.4269517, 0.1084016)

				arg_174_1.mask_.enabled = false
				var_177_2.a = 0
				arg_174_1.mask_.color = var_177_2
			end

			local var_177_3 = 0.7

			if 0.7 < arg_174_1.time_ and arg_174_1.time_ <= var_177_3 + arg_177_0 then
				arg_174_1.mask_.enabled = true
				arg_174_1.mask_.raycastTarget = true

				arg_174_1:SetGaussion(false)
			end

			local var_177_4 = 0.8

			if var_177_3 <= arg_174_1.time_ and arg_174_1.time_ < var_177_3 + var_177_4 then
				local var_177_5 = Color.New(0.7924528, 0.4269517, 0.1084016)

				var_177_5.a = Mathf.Lerp(1, 0, (arg_174_1.time_ - var_177_3) / var_177_4)
				arg_174_1.mask_.color = var_177_5
			end

			if arg_174_1.time_ >= var_177_3 + var_177_4 and arg_174_1.time_ < var_177_3 + var_177_4 + arg_177_0 then
				local var_177_6 = Color.New(0.7924528, 0.4269517, 0.1084016)

				arg_174_1.mask_.enabled = false
				var_177_6.a = 0
				arg_174_1.mask_.color = var_177_6
			end

			local var_177_7 = 1.83333333333333
			local var_177_8 = 0.975

			if 1.83333333333333 < arg_174_1.time_ and arg_174_1.time_ <= var_177_7 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, false)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_9 = arg_174_1:FormatText(arg_174_1:GetWordFromCfg(319351041).content)

				arg_174_1.text_.text = var_177_9

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_11 = 39 <= 0 and var_177_8 or var_177_8 * (utf8.len(var_177_9) / 39)

				if (39 <= 0 and var_177_8 or var_177_8 * (utf8.len(var_177_9) / 39)) > 0 and var_177_8 < var_177_11 then
					arg_174_1.talkMaxDuration = var_177_11

					if var_177_11 + var_177_7 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_11 + var_177_7
					end
				end

				arg_174_1.text_.text = var_177_9
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)
				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_12 = math.max(var_177_8, arg_174_1.talkMaxDuration)

			if var_177_7 <= arg_174_1.time_ and arg_174_1.time_ < var_177_7 + var_177_12 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_7) / var_177_12

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_7 + var_177_12 and arg_174_1.time_ < var_177_7 + var_177_12 + arg_177_0 then
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
			if 3 < arg_178_1.time_ and arg_178_1.time_ <= 3 + arg_181_0 and not isNil(arg_178_1.actors_["1084ui_story"]) and arg_178_1.var_.characterEffect1084ui_story == nil then
				arg_178_1.var_.characterEffect1084ui_story = arg_178_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_0 = 0.200000002980232

			if 3 <= arg_178_1.time_ and arg_178_1.time_ < 3 + var_181_0 and not isNil(arg_178_1.actors_["1084ui_story"]) then
				if arg_178_1.var_.characterEffect1084ui_story and not isNil(arg_178_1.actors_["1084ui_story"]) then
					arg_178_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_178_1.time_ >= 3 + var_181_0 and arg_178_1.time_ < 3 + var_181_0 + arg_181_0 and not isNil(arg_178_1.actors_["1084ui_story"]) and arg_178_1.var_.characterEffect1084ui_story then
				arg_178_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 1 < arg_178_1.time_ and arg_178_1.time_ <= 1 + arg_181_0 then
				local var_181_2 = arg_178_1.bgs_.ST74

				arg_178_1.bgs_.ST74.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_181_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_181_3 = var_181_2:GetComponent("SpriteRenderer")

				if var_181_3 and var_181_3.sprite then
					local var_181_4 = 2 * (var_181_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_181_2.transform.localScale = Vector3.New(var_181_4 / var_181_3.sprite.bounds.size.y < var_181_4 * manager.ui.mainCameraCom_.aspect / var_181_3.sprite.bounds.size.x and var_181_4 * manager.ui.mainCameraCom_.aspect / var_181_3.sprite.bounds.size.x or var_181_4 / var_181_3.sprite.bounds.size.y, var_181_4 / var_181_3.sprite.bounds.size.y < var_181_4 * manager.ui.mainCameraCom_.aspect / var_181_3.sprite.bounds.size.x and var_181_4 * manager.ui.mainCameraCom_.aspect / var_181_3.sprite.bounds.size.x or var_181_4 / var_181_3.sprite.bounds.size.y, 0)
				end

				for iter_181_0, iter_181_1 in pairs(arg_178_1.bgs_) do
					if iter_181_0 ~= "ST74" then
						iter_181_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_181_5 = 0

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_5 + arg_181_0 then
				arg_178_1.mask_.enabled = true
				arg_178_1.mask_.raycastTarget = true

				arg_178_1:SetGaussion(false)
			end

			local var_181_6 = 1

			if var_181_5 <= arg_178_1.time_ and arg_178_1.time_ < var_181_5 + var_181_6 then
				local var_181_7 = Color.New(0, 0, 0)

				var_181_7.a = Mathf.Lerp(0, 1, (arg_178_1.time_ - var_181_5) / var_181_6)
				arg_178_1.mask_.color = var_181_7
			end

			if arg_178_1.time_ >= var_181_5 + var_181_6 and arg_178_1.time_ < var_181_5 + var_181_6 + arg_181_0 then
				local var_181_8 = Color.New(0, 0, 0)

				var_181_8.a = 1
				arg_178_1.mask_.color = var_181_8
			end

			local var_181_9 = 1

			if 1 < arg_178_1.time_ and arg_178_1.time_ <= var_181_9 + arg_181_0 then
				arg_178_1.mask_.enabled = true
				arg_178_1.mask_.raycastTarget = true

				arg_178_1:SetGaussion(false)
			end

			local var_181_10 = 2

			if var_181_9 <= arg_178_1.time_ and arg_178_1.time_ < var_181_9 + var_181_10 then
				local var_181_11 = Color.New(0, 0, 0)

				var_181_11.a = Mathf.Lerp(1, 0, (arg_178_1.time_ - var_181_9) / var_181_10)
				arg_178_1.mask_.color = var_181_11
			end

			if arg_178_1.time_ >= var_181_9 + var_181_10 and arg_178_1.time_ < var_181_9 + var_181_10 + arg_181_0 then
				local var_181_12 = Color.New(0, 0, 0)

				arg_178_1.mask_.enabled = false
				var_181_12.a = 0
				arg_178_1.mask_.color = var_181_12
			end

			local var_181_13 = arg_178_1.actors_["1084ui_story"].transform

			if 3 < arg_178_1.time_ and arg_178_1.time_ <= 3 + arg_181_0 then
				arg_178_1.var_.moveOldPos1084ui_story = var_181_13.localPosition
			end

			local var_181_14 = 0.001

			if 3 <= arg_178_1.time_ and arg_178_1.time_ < 3 + var_181_14 then
				var_181_13.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_178_1.time_ - 3) / var_181_14)
				var_181_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_181_13.position).x, (manager.ui.mainCamera.transform.position - var_181_13.position).y, (manager.ui.mainCamera.transform.position - var_181_13.position).z)
				var_181_13.localEulerAngles.z = 0
				var_181_13.localEulerAngles.x = 0
				var_181_13.localEulerAngles = var_181_13.localEulerAngles
			end

			if arg_178_1.time_ >= 3 + var_181_14 and arg_178_1.time_ < 3 + var_181_14 + arg_181_0 then
				var_181_13.localPosition = Vector3.New(0, -0.97, -6)
				var_181_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_181_13.position).x, (manager.ui.mainCamera.transform.position - var_181_13.position).y, (manager.ui.mainCamera.transform.position - var_181_13.position).z)
				var_181_13.localEulerAngles.z = 0
				var_181_13.localEulerAngles.x = 0
				var_181_13.localEulerAngles = var_181_13.localEulerAngles
			end

			local var_181_15 = 2.825
			local var_181_16 = 0.175

			if 2.825 < arg_178_1.time_ and arg_178_1.time_ <= var_181_15 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				arg_178_1.leftNameTxt_.text = arg_178_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_17 = arg_178_1:GetWordFromCfg(319351042)
				local var_181_18 = arg_178_1:FormatText(var_181_17.content)

				arg_178_1.text_.text = var_181_18

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_20 = 7 <= 0 and var_181_16 or var_181_16 * (utf8.len(var_181_18) / 7)

				if (7 <= 0 and var_181_16 or var_181_16 * (utf8.len(var_181_18) / 7)) > 0 and var_181_16 < var_181_20 then
					arg_178_1.talkMaxDuration = var_181_20

					if var_181_20 + var_181_15 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_20 + var_181_15
					end
				end

				arg_178_1.text_.text = var_181_18
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319351", "319351042", "story_v_out_319351.awb") ~= 0 then
					local var_181_21 = manager.audio:GetVoiceLength("story_v_out_319351", "319351042", "story_v_out_319351.awb") / 1000

					if var_181_21 + var_181_15 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_21 + var_181_15
					end

					if var_181_17.prefab_name ~= "" and arg_178_1.actors_[var_181_17.prefab_name] ~= nil then
						local var_181_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_17.prefab_name].transform, "story_v_out_319351", "319351042", "story_v_out_319351.awb")

						arg_178_1:RecordAudio("319351042", var_181_22)
						arg_178_1:RecordAudio("319351042", var_181_22)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_319351", "319351042", "story_v_out_319351.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_319351", "319351042", "story_v_out_319351.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_23 = math.max(var_181_16, arg_178_1.talkMaxDuration)

			if var_181_15 <= arg_178_1.time_ and arg_178_1.time_ < var_181_15 + var_181_23 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_15) / var_181_23

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_15 + var_181_23 and arg_178_1.time_ < var_181_15 + var_181_23 + arg_181_0 then
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
			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 and not isNil(arg_182_1.actors_["1084ui_story"]) and arg_182_1.var_.characterEffect1084ui_story == nil then
				arg_182_1.var_.characterEffect1084ui_story = arg_182_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_0 = 0.200000002980232

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_0 and not isNil(arg_182_1.actors_["1084ui_story"]) then
				if arg_182_1.var_.characterEffect1084ui_story and not isNil(arg_182_1.actors_["1084ui_story"]) then
					arg_182_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_182_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_182_1.time_ - 0) / var_185_0)
				end
			end

			if arg_182_1.time_ >= 0 + var_185_0 and arg_182_1.time_ < 0 + var_185_0 + arg_185_0 and not isNil(arg_182_1.actors_["1084ui_story"]) and arg_182_1.var_.characterEffect1084ui_story then
				arg_182_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_182_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_185_1 = arg_182_1.actors_["1095ui_story"]

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 and not isNil(var_185_1) and arg_182_1.var_.characterEffect1095ui_story == nil then
				arg_182_1.var_.characterEffect1095ui_story = var_185_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_2 = 0.200000002980232

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_2 and not isNil(var_185_1) then
				if arg_182_1.var_.characterEffect1095ui_story and not isNil(var_185_1) then
					arg_182_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_182_1.time_ >= 0 + var_185_2 and arg_182_1.time_ < 0 + var_185_2 + arg_185_0 and not isNil(var_185_1) and arg_182_1.var_.characterEffect1095ui_story then
				arg_182_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_2")
			end

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_185_4 = arg_182_1.actors_["1095ui_story"].transform

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1.var_.moveOldPos1095ui_story = var_185_4.localPosition
			end

			local var_185_5 = 0.001

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_5 then
				var_185_4.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPos1095ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_182_1.time_ - 0) / var_185_5)
				var_185_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_185_4.position).x, (manager.ui.mainCamera.transform.position - var_185_4.position).y, (manager.ui.mainCamera.transform.position - var_185_4.position).z)
				var_185_4.localEulerAngles.z = 0
				var_185_4.localEulerAngles.x = 0
				var_185_4.localEulerAngles = var_185_4.localEulerAngles
			end

			if arg_182_1.time_ >= 0 + var_185_5 and arg_182_1.time_ < 0 + var_185_5 + arg_185_0 then
				var_185_4.localPosition = Vector3.New(0.7, -0.98, -6.1)
				var_185_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_185_4.position).x, (manager.ui.mainCamera.transform.position - var_185_4.position).y, (manager.ui.mainCamera.transform.position - var_185_4.position).z)
				var_185_4.localEulerAngles.z = 0
				var_185_4.localEulerAngles.x = 0
				var_185_4.localEulerAngles = var_185_4.localEulerAngles
			end

			local var_185_6 = arg_182_1.actors_["1084ui_story"].transform

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1.var_.moveOldPos1084ui_story = var_185_6.localPosition
			end

			local var_185_7 = 0.001

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_7 then
				var_185_6.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_182_1.time_ - 0) / var_185_7)
				var_185_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_185_6.position).x, (manager.ui.mainCamera.transform.position - var_185_6.position).y, (manager.ui.mainCamera.transform.position - var_185_6.position).z)
				var_185_6.localEulerAngles.z = 0
				var_185_6.localEulerAngles.x = 0
				var_185_6.localEulerAngles = var_185_6.localEulerAngles
			end

			if arg_182_1.time_ >= 0 + var_185_7 and arg_182_1.time_ < 0 + var_185_7 + arg_185_0 then
				var_185_6.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_185_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_185_6.position).x, (manager.ui.mainCamera.transform.position - var_185_6.position).y, (manager.ui.mainCamera.transform.position - var_185_6.position).z)
				var_185_6.localEulerAngles.z = 0
				var_185_6.localEulerAngles.x = 0
				var_185_6.localEulerAngles = var_185_6.localEulerAngles
			end

			local var_185_8 = 0
			local var_185_9 = 0.35

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_8 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				arg_182_1.leftNameTxt_.text = arg_182_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_10 = arg_182_1:GetWordFromCfg(319351043)
				local var_185_11 = arg_182_1:FormatText(var_185_10.content)

				arg_182_1.text_.text = var_185_11

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_13 = 14 <= 0 and var_185_9 or var_185_9 * (utf8.len(var_185_11) / 14)

				if (14 <= 0 and var_185_9 or var_185_9 * (utf8.len(var_185_11) / 14)) > 0 and var_185_9 < var_185_13 then
					arg_182_1.talkMaxDuration = var_185_13

					if var_185_13 + var_185_8 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_13 + var_185_8
					end
				end

				arg_182_1.text_.text = var_185_11
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319351", "319351043", "story_v_out_319351.awb") ~= 0 then
					local var_185_14 = manager.audio:GetVoiceLength("story_v_out_319351", "319351043", "story_v_out_319351.awb") / 1000

					if var_185_14 + var_185_8 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_14 + var_185_8
					end

					if var_185_10.prefab_name ~= "" and arg_182_1.actors_[var_185_10.prefab_name] ~= nil then
						local var_185_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_10.prefab_name].transform, "story_v_out_319351", "319351043", "story_v_out_319351.awb")

						arg_182_1:RecordAudio("319351043", var_185_15)
						arg_182_1:RecordAudio("319351043", var_185_15)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_319351", "319351043", "story_v_out_319351.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_319351", "319351043", "story_v_out_319351.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_16 = math.max(var_185_9, arg_182_1.talkMaxDuration)

			if var_185_8 <= arg_182_1.time_ and arg_182_1.time_ < var_185_8 + var_185_16 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_8) / var_185_16

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_8 + var_185_16 and arg_182_1.time_ < var_185_8 + var_185_16 + arg_185_0 then
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
			if arg_186_1.bgs_.STwhite == nil then
				local var_189_0 = Object.Instantiate(arg_186_1.paintGo_)

				var_189_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STwhite")
				var_189_0.name = "STwhite"
				var_189_0.transform.parent = arg_186_1.stage_.transform
				var_189_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_186_1.bgs_.STwhite = var_189_0
			end

			if 2 < arg_186_1.time_ and arg_186_1.time_ <= 2 + arg_189_0 then
				local var_189_1 = arg_186_1.bgs_.STwhite

				arg_186_1.bgs_.STwhite.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_189_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_189_2 = var_189_1:GetComponent("SpriteRenderer")

				if var_189_2 and var_189_2.sprite then
					local var_189_3 = 2 * (var_189_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_189_1.transform.localScale = Vector3.New(var_189_3 / var_189_2.sprite.bounds.size.y < var_189_3 * manager.ui.mainCameraCom_.aspect / var_189_2.sprite.bounds.size.x and var_189_3 * manager.ui.mainCameraCom_.aspect / var_189_2.sprite.bounds.size.x or var_189_3 / var_189_2.sprite.bounds.size.y, var_189_3 / var_189_2.sprite.bounds.size.y < var_189_3 * manager.ui.mainCameraCom_.aspect / var_189_2.sprite.bounds.size.x and var_189_3 * manager.ui.mainCameraCom_.aspect / var_189_2.sprite.bounds.size.x or var_189_3 / var_189_2.sprite.bounds.size.y, 0)
				end

				for iter_189_0, iter_189_1 in pairs(arg_186_1.bgs_) do
					if iter_189_0 ~= "STwhite" then
						iter_189_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_189_4 = 0

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_4 + arg_189_0 then
				arg_186_1.mask_.enabled = true
				arg_186_1.mask_.raycastTarget = true

				arg_186_1:SetGaussion(false)
			end

			local var_189_5 = 2

			if var_189_4 <= arg_186_1.time_ and arg_186_1.time_ < var_189_4 + var_189_5 then
				local var_189_6 = Color.New(0, 0, 0)

				var_189_6.a = Mathf.Lerp(0, 1, (arg_186_1.time_ - var_189_4) / var_189_5)
				arg_186_1.mask_.color = var_189_6
			end

			if arg_186_1.time_ >= var_189_4 + var_189_5 and arg_186_1.time_ < var_189_4 + var_189_5 + arg_189_0 then
				local var_189_7 = Color.New(0, 0, 0)

				var_189_7.a = 1
				arg_186_1.mask_.color = var_189_7
			end

			local var_189_8 = 2

			if 2 < arg_186_1.time_ and arg_186_1.time_ <= var_189_8 + arg_189_0 then
				arg_186_1.mask_.enabled = true
				arg_186_1.mask_.raycastTarget = true

				arg_186_1:SetGaussion(false)
			end

			local var_189_9 = 2

			if var_189_8 <= arg_186_1.time_ and arg_186_1.time_ < var_189_8 + var_189_9 then
				local var_189_10 = Color.New(0, 0, 0)

				var_189_10.a = Mathf.Lerp(1, 0, (arg_186_1.time_ - var_189_8) / var_189_9)
				arg_186_1.mask_.color = var_189_10
			end

			if arg_186_1.time_ >= var_189_8 + var_189_9 and arg_186_1.time_ < var_189_8 + var_189_9 + arg_189_0 then
				local var_189_11 = Color.New(0, 0, 0)

				arg_186_1.mask_.enabled = false
				var_189_11.a = 0
				arg_186_1.mask_.color = var_189_11
			end

			local var_189_12 = arg_186_1.actors_["1095ui_story"].transform

			if 2 < arg_186_1.time_ and arg_186_1.time_ <= 2 + arg_189_0 then
				arg_186_1.var_.moveOldPos1095ui_story = var_189_12.localPosition
			end

			local var_189_13 = 0.001

			if 2 <= arg_186_1.time_ and arg_186_1.time_ < 2 + var_189_13 then
				var_189_12.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_186_1.time_ - 2) / var_189_13)
				var_189_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_189_12.position).x, (manager.ui.mainCamera.transform.position - var_189_12.position).y, (manager.ui.mainCamera.transform.position - var_189_12.position).z)
				var_189_12.localEulerAngles.z = 0
				var_189_12.localEulerAngles.x = 0
				var_189_12.localEulerAngles = var_189_12.localEulerAngles
			end

			if arg_186_1.time_ >= 2 + var_189_13 and arg_186_1.time_ < 2 + var_189_13 + arg_189_0 then
				var_189_12.localPosition = Vector3.New(0, 100, 0)
				var_189_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_189_12.position).x, (manager.ui.mainCamera.transform.position - var_189_12.position).y, (manager.ui.mainCamera.transform.position - var_189_12.position).z)
				var_189_12.localEulerAngles.z = 0
				var_189_12.localEulerAngles.x = 0
				var_189_12.localEulerAngles = var_189_12.localEulerAngles
			end

			local var_189_14 = arg_186_1.actors_["1095ui_story"]

			if 2 < arg_186_1.time_ and arg_186_1.time_ <= 2 + arg_189_0 and not isNil(var_189_14) and arg_186_1.var_.characterEffect1095ui_story == nil then
				arg_186_1.var_.characterEffect1095ui_story = var_189_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_15 = 0.200000002980232

			if 2 <= arg_186_1.time_ and arg_186_1.time_ < 2 + var_189_15 and not isNil(var_189_14) then
				if arg_186_1.var_.characterEffect1095ui_story and not isNil(var_189_14) then
					arg_186_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_186_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_186_1.time_ - 2) / var_189_15)
				end
			end

			if arg_186_1.time_ >= 2 + var_189_15 and arg_186_1.time_ < 2 + var_189_15 + arg_189_0 and not isNil(var_189_14) and arg_186_1.var_.characterEffect1095ui_story then
				arg_186_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_186_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_189_16 = arg_186_1.actors_["1084ui_story"]

			if 2 < arg_186_1.time_ and arg_186_1.time_ <= 2 + arg_189_0 and not isNil(var_189_16) and arg_186_1.var_.characterEffect1084ui_story == nil then
				arg_186_1.var_.characterEffect1084ui_story = var_189_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_17 = 0.200000002980232

			if 2 <= arg_186_1.time_ and arg_186_1.time_ < 2 + var_189_17 and not isNil(var_189_16) then
				if arg_186_1.var_.characterEffect1084ui_story and not isNil(var_189_16) then
					arg_186_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_186_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_186_1.time_ - 2) / var_189_17)
				end
			end

			if arg_186_1.time_ >= 2 + var_189_17 and arg_186_1.time_ < 2 + var_189_17 + arg_189_0 and not isNil(var_189_16) and arg_186_1.var_.characterEffect1084ui_story then
				arg_186_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_186_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_189_18 = arg_186_1.actors_["1084ui_story"].transform

			if 2 < arg_186_1.time_ and arg_186_1.time_ <= 2 + arg_189_0 then
				arg_186_1.var_.moveOldPos1084ui_story = var_189_18.localPosition
			end

			local var_189_19 = 0.001

			if 2 <= arg_186_1.time_ and arg_186_1.time_ < 2 + var_189_19 then
				var_189_18.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_186_1.time_ - 2) / var_189_19)
				var_189_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_189_18.position).x, (manager.ui.mainCamera.transform.position - var_189_18.position).y, (manager.ui.mainCamera.transform.position - var_189_18.position).z)
				var_189_18.localEulerAngles.z = 0
				var_189_18.localEulerAngles.x = 0
				var_189_18.localEulerAngles = var_189_18.localEulerAngles
			end

			if arg_186_1.time_ >= 2 + var_189_19 and arg_186_1.time_ < 2 + var_189_19 + arg_189_0 then
				var_189_18.localPosition = Vector3.New(0, 100, 0)
				var_189_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_189_18.position).x, (manager.ui.mainCamera.transform.position - var_189_18.position).y, (manager.ui.mainCamera.transform.position - var_189_18.position).z)
				var_189_18.localEulerAngles.z = 0
				var_189_18.localEulerAngles.x = 0
				var_189_18.localEulerAngles = var_189_18.localEulerAngles
			end

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_189_22 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_186_1.bgmTxt_.text ~= var_189_22 and arg_186_1.bgmTxt_.text ~= "" then
						if arg_186_1.bgmTxt2_.text ~= "" then
							arg_186_1.bgmTxt_.text = arg_186_1.bgmTxt2_.text
						end

						arg_186_1.bgmTxt2_.text = var_189_22

						arg_186_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_186_1.bgmTxt_.text = var_189_22
						arg_186_1.bgmTxt2_.text = var_189_22
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

			local var_189_23 = 4
			local var_189_24 = 0.35

			if 4 < arg_186_1.time_ and arg_186_1.time_ <= var_189_23 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0

				arg_186_1.dialog_:SetActive(true)

				arg_186_1.dialogCg_.alpha = 0

				local var_189_25 = LeanTween.value(arg_186_1.dialog_, 0, 1, 0.3)

				var_189_25:setOnUpdate(LuaHelper.FloatAction(function(arg_191_0)
					arg_186_1.dialogCg_.alpha = arg_191_0
				end))
				var_189_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_186_1.dialog_)
					var_189_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_186_1.duration_ = arg_186_1.duration_ + 0.3

				SetActive(arg_186_1.leftNameGo_, false)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_26 = arg_186_1:FormatText(arg_186_1:GetWordFromCfg(319351044).content)

				arg_186_1.text_.text = var_189_26

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_28 = 14 <= 0 and var_189_24 or var_189_24 * (utf8.len(var_189_26) / 14)

				if (14 <= 0 and var_189_24 or var_189_24 * (utf8.len(var_189_26) / 14)) > 0 and var_189_24 < var_189_28 then
					arg_186_1.talkMaxDuration = var_189_28
					var_189_23 = var_189_23 + 0.3

					if var_189_28 + var_189_23 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_28 + var_189_23
					end
				end

				arg_186_1.text_.text = var_189_26
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)
				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_29 = var_189_23 + 0.3
			local var_189_30 = math.max(var_189_24, arg_186_1.talkMaxDuration)

			if var_189_23 + 0.3 <= arg_186_1.time_ and arg_186_1.time_ < var_189_29 + var_189_30 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_29) / var_189_30

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_29 + var_189_30 and arg_186_1.time_ < var_189_29 + var_189_30 + arg_189_0 then
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
			if arg_193_1.bgs_.I11q == nil then
				local var_196_0 = Object.Instantiate(arg_193_1.paintGo_)

				var_196_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I11q")
				var_196_0.name = "I11q"
				var_196_0.transform.parent = arg_193_1.stage_.transform
				var_196_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_193_1.bgs_.I11q = var_196_0
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				local var_196_1 = arg_193_1.bgs_.I11q

				arg_193_1.bgs_.I11q.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_196_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_196_2 = var_196_1:GetComponent("SpriteRenderer")

				if var_196_2 and var_196_2.sprite then
					local var_196_3 = 2 * (var_196_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_196_1.transform.localScale = Vector3.New(var_196_3 / var_196_2.sprite.bounds.size.y < var_196_3 * manager.ui.mainCameraCom_.aspect / var_196_2.sprite.bounds.size.x and var_196_3 * manager.ui.mainCameraCom_.aspect / var_196_2.sprite.bounds.size.x or var_196_3 / var_196_2.sprite.bounds.size.y, var_196_3 / var_196_2.sprite.bounds.size.y < var_196_3 * manager.ui.mainCameraCom_.aspect / var_196_2.sprite.bounds.size.x and var_196_3 * manager.ui.mainCameraCom_.aspect / var_196_2.sprite.bounds.size.x or var_196_3 / var_196_2.sprite.bounds.size.y, 0)
				end

				for iter_196_0, iter_196_1 in pairs(arg_193_1.bgs_) do
					if iter_196_0 ~= "I11q" then
						iter_196_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_196_4 = 0

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_4 + arg_196_0 then
				arg_193_1.mask_.enabled = true
				arg_193_1.mask_.raycastTarget = true

				arg_193_1:SetGaussion(false)
			end

			local var_196_5 = 2.3921013015788

			if var_196_4 <= arg_193_1.time_ and arg_193_1.time_ < var_196_4 + var_196_5 then
				local var_196_6 = Color.New(1, 1, 1)

				var_196_6.a = Mathf.Lerp(1, 0, (arg_193_1.time_ - var_196_4) / var_196_5)
				arg_193_1.mask_.color = var_196_6
			end

			if arg_193_1.time_ >= var_196_4 + var_196_5 and arg_193_1.time_ < var_196_4 + var_196_5 + arg_196_0 then
				local var_196_7 = Color.New(1, 1, 1)

				arg_193_1.mask_.enabled = false
				var_196_7.a = 0
				arg_193_1.mask_.color = var_196_7
			end

			if arg_193_1.frameCnt_ <= 1 then
				arg_193_1.dialog_:SetActive(false)
			end

			local var_196_8 = 2.3921013015788
			local var_196_9 = 0.825

			if 2.3921013015788 < arg_193_1.time_ and arg_193_1.time_ <= var_196_8 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0

				arg_193_1.dialog_:SetActive(true)

				arg_193_1.dialogCg_.alpha = 0

				local var_196_10 = LeanTween.value(arg_193_1.dialog_, 0, 1, 0.3)

				var_196_10:setOnUpdate(LuaHelper.FloatAction(function(arg_197_0)
					arg_193_1.dialogCg_.alpha = arg_197_0
				end))
				var_196_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_193_1.dialog_)
					var_196_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_193_1.duration_ = arg_193_1.duration_ + 0.3

				SetActive(arg_193_1.leftNameGo_, false)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_11 = arg_193_1:FormatText(arg_193_1:GetWordFromCfg(319351045).content)

				arg_193_1.text_.text = var_196_11

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_13 = 33 <= 0 and var_196_9 or var_196_9 * (utf8.len(var_196_11) / 33)

				if (33 <= 0 and var_196_9 or var_196_9 * (utf8.len(var_196_11) / 33)) > 0 and var_196_9 < var_196_13 then
					arg_193_1.talkMaxDuration = var_196_13
					var_196_8 = var_196_8 + 0.3

					if var_196_13 + var_196_8 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_13 + var_196_8
					end
				end

				arg_193_1.text_.text = var_196_11
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_14 = var_196_8 + 0.3
			local var_196_15 = math.max(var_196_9, arg_193_1.talkMaxDuration)

			if var_196_8 + 0.3 <= arg_193_1.time_ and arg_193_1.time_ < var_196_14 + var_196_15 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_14) / var_196_15

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_14 + var_196_15 and arg_193_1.time_ < var_196_14 + var_196_15 + arg_196_0 then
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
			local var_202_0 = 0.725

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, false)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_1 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(319351046).content)

				arg_199_1.text_.text = var_202_1

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_3 = 29 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_1) / 29)

				if (29 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_1) / 29)) > 0 and var_202_0 < var_202_3 then
					arg_199_1.talkMaxDuration = var_202_3

					if var_202_3 + 0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_3 + 0
					end
				end

				arg_199_1.text_.text = var_202_1
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_4 = math.max(var_202_0, arg_199_1.talkMaxDuration)

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_4 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - 0) / var_202_4

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= 0 + var_202_4 and arg_199_1.time_ < 0 + var_202_4 + arg_202_0 then
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
			local var_206_0 = 0.5

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, false)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_1 = arg_203_1:FormatText(arg_203_1:GetWordFromCfg(319351047).content)

				arg_203_1.text_.text = var_206_1

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_3 = 20 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_1) / 20)

				if (20 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_1) / 20)) > 0 and var_206_0 < var_206_3 then
					arg_203_1.talkMaxDuration = var_206_3

					if var_206_3 + 0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_3 + 0
					end
				end

				arg_203_1.text_.text = var_206_1
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_4 = math.max(var_206_0, arg_203_1.talkMaxDuration)

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_4 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - 0) / var_206_4

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= 0 + var_206_4 and arg_203_1.time_ < 0 + var_206_4 + arg_206_0 then
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
