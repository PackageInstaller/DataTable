return {
	Play411051001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 411051001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play411051002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST74 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST74")
				var_4_0.name = "ST74"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST74 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST74

				arg_1_1.bgs_.ST74.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST74" then
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

			if 1.23333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 1.23333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_131", "se_story_131__opendoor", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_12 = 2
			local var_4_13 = 0.5

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_12 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_14 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_14:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_15 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(411051001).content)

				arg_1_1.text_.text = var_4_15

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_17 = 20 <= 0 and var_4_13 or var_4_13 * (utf8.len(var_4_15) / 20)

				if (20 <= 0 and var_4_13 or var_4_13 * (utf8.len(var_4_15) / 20)) > 0 and var_4_13 < var_4_17 then
					arg_1_1.talkMaxDuration = var_4_17
					var_4_12 = var_4_12 + 0.3

					if var_4_17 + var_4_12 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_17 + var_4_12
					end
				end

				arg_1_1.text_.text = var_4_15
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_18 = var_4_12 + 0.3
			local var_4_19 = math.max(var_4_13, arg_1_1.talkMaxDuration)

			if var_4_12 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_18 + var_4_19 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_18) / var_4_19

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_18 + var_4_19 and arg_1_1.time_ < var_4_18 + var_4_19 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play411051002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 411051002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play411051003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 1.075

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

				local var_11_1 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(411051002).content)

				arg_8_1.text_.text = var_11_1

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_3 = 43 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 43)

				if (43 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 43)) > 0 and var_11_0 < var_11_3 then
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
	Play411051003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 411051003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play411051004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 1.15

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

				local var_15_1 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(411051003).content)

				arg_12_1.text_.text = var_15_1

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_3 = 46 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 46)

				if (46 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 46)) > 0 and var_15_0 < var_15_3 then
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
	Play411051004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 411051004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play411051005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0.325

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_1 = arg_16_1:FormatText(arg_16_1:GetWordFromCfg(411051004).content)

				arg_16_1.text_.text = var_19_1

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_3 = 13 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_1) / 13)

				if (13 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_1) / 13)) > 0 and var_19_0 < var_19_3 then
					arg_16_1.talkMaxDuration = var_19_3

					if var_19_3 + 0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_3 + 0
					end
				end

				arg_16_1.text_.text = var_19_1
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_4 = math.max(var_19_0, arg_16_1.talkMaxDuration)

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_4 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - 0) / var_19_4

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= 0 + var_19_4 and arg_16_1.time_ < 0 + var_19_4 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play411051005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 411051005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play411051006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.fswbg_:SetActive(true)
				arg_20_1.dialog_:SetActive(false)

				arg_20_1.fswtw_.percent = 0
				arg_20_1.fswt_.text = arg_20_1:FormatText(arg_20_1:GetWordFromCfg(411051005).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.fswt_)

				arg_20_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_20_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_20_1.fswtw_:SetDirty()

				arg_20_1.typewritterCharCountI18N = 0

				SetActive(arg_20_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_20_1:ShowNextGo(false)
			end

			local var_23_0 = 0.333

			if 0.333 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1.var_.oldValueTypewriter = arg_20_1.fswtw_.percent

				SetActive(arg_20_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_20_1:ShowNextGo(false)
			end

			local var_23_1 = 16
			local var_23_2 = 1.06666666666667
			local var_23_3, var_23_4 = arg_20_1:GetPercentByPara(arg_20_1:FormatText(arg_20_1:GetWordFromCfg(411051005).content), 1)

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

			local var_23_7 = 0.333
			local var_23_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051005", "story_v_out_411051.awb") / 1000

			if var_23_8 > 0 and 1 < var_23_8 and var_23_8 + var_23_7 > arg_20_1.duration_ then
				arg_20_1.duration_ = var_23_8 + var_23_7
			end

			if var_23_7 < arg_20_1.time_ and arg_20_1.time_ <= var_23_7 + arg_23_0 then
				arg_20_1:AudioAction("play", "voice", "story_v_out_411051", "411051005", "story_v_out_411051.awb")
			end

			if 0.333 < arg_20_1.time_ and arg_20_1.time_ <= 0.333 + arg_23_0 then
				arg_20_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_23_12 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_20_1.bgmTxt_.text ~= var_23_12 and arg_20_1.bgmTxt_.text ~= "" then
						if arg_20_1.bgmTxt2_.text ~= "" then
							arg_20_1.bgmTxt_.text = arg_20_1.bgmTxt2_.text
						end

						arg_20_1.bgmTxt2_.text = var_23_12

						arg_20_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_20_1.bgmTxt_.text = var_23_12
						arg_20_1.bgmTxt2_.text = var_23_12
					end

					if arg_20_1.bgmTimer then
						arg_20_1.bgmTimer:Stop()

						arg_20_1.bgmTimer = nil
					end

					if arg_20_1.settingData.show_music_name == 1 then
						arg_20_1.musicController:SetSelectedState("show")
						arg_20_1.musicAnimator_:Play("open", 0, 0)

						if arg_20_1.settingData.music_time ~= 0 then
							arg_20_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_20_1.settingData.music_time), function()
								if arg_20_1 == nil or isNil(arg_20_1.bgmTxt_) then
									return
								end

								arg_20_1.musicController:SetSelectedState("hide")
								arg_20_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.833 < arg_20_1.time_ and arg_20_1.time_ <= 0.833 + arg_23_0 then
				arg_20_1:AudioAction("play", "music", "bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad.awb")

				local var_23_15 = manager.audio:GetAudioName("bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad")

				if "" ~= "" then
					if arg_20_1.bgmTxt_.text ~= var_23_15 and arg_20_1.bgmTxt_.text ~= "" then
						if arg_20_1.bgmTxt2_.text ~= "" then
							arg_20_1.bgmTxt_.text = arg_20_1.bgmTxt2_.text
						end

						arg_20_1.bgmTxt2_.text = var_23_15

						arg_20_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_20_1.bgmTxt_.text = var_23_15
						arg_20_1.bgmTxt2_.text = var_23_15
					end

					if arg_20_1.bgmTimer then
						arg_20_1.bgmTimer:Stop()

						arg_20_1.bgmTimer = nil
					end

					if arg_20_1.settingData.show_music_name == 1 then
						arg_20_1.musicController:SetSelectedState("show")
						arg_20_1.musicAnimator_:Play("open", 0, 0)

						if arg_20_1.settingData.music_time ~= 0 then
							arg_20_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_20_1.settingData.music_time), function()
								if arg_20_1 == nil or isNil(arg_20_1.bgmTxt_) then
									return
								end

								arg_20_1.musicController:SetSelectedState("hide")
								arg_20_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_23_16 = "STblack"

			if arg_20_1.bgs_.STblack == nil then
				local var_23_17 = Object.Instantiate(arg_20_1.paintGo_)

				var_23_17:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_23_16)
				var_23_17.name = var_23_16
				var_23_17.transform.parent = arg_20_1.stage_.transform
				var_23_17.transform.localPosition = Vector3.New(0, 100, 0)
				arg_20_1.bgs_[var_23_16] = var_23_17
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				local var_23_18 = arg_20_1.bgs_.STblack

				arg_20_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_23_18.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_23_19 = var_23_18:GetComponent("SpriteRenderer")

				if var_23_19 and var_23_19.sprite then
					local var_23_20 = 2 * (var_23_18.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_23_18.transform.localScale = Vector3.New(var_23_20 / var_23_19.sprite.bounds.size.y < var_23_20 * manager.ui.mainCameraCom_.aspect / var_23_19.sprite.bounds.size.x and var_23_20 * manager.ui.mainCameraCom_.aspect / var_23_19.sprite.bounds.size.x or var_23_20 / var_23_19.sprite.bounds.size.y, var_23_20 / var_23_19.sprite.bounds.size.y < var_23_20 * manager.ui.mainCameraCom_.aspect / var_23_19.sprite.bounds.size.x and var_23_20 * manager.ui.mainCameraCom_.aspect / var_23_19.sprite.bounds.size.x or var_23_20 / var_23_19.sprite.bounds.size.y, 0)
				end

				for iter_23_0, iter_23_1 in pairs(arg_20_1.bgs_) do
					if iter_23_0 ~= "STblack" then
						iter_23_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				local var_23_21 = arg_20_1.fswbg_.transform:Find("textbox/adapt/content") or arg_20_1.fswbg_.transform:Find("textbox/content")
				local var_23_22 = arg_20_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_23_23 = var_23_21:GetComponent("RectTransform")

				var_23_21:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleLeft
				var_23_23.offsetMin = Vector2.New(5.15, -270.1)
				var_23_23.offsetMax = Vector2.New(16.28, 6.8)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play411051006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 411051006
		arg_26_1.duration_ = 3.2

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play411051007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				arg_26_1.var_.oldValueTypewriter = arg_26_1.fswtw_.percent

				SetActive(arg_26_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_26_1:ShowNextGo(false)
			end

			local var_29_0 = 64
			local var_29_1 = 3.2
			local var_29_2, var_29_3 = arg_26_1:GetPercentByPara(arg_26_1:FormatText(arg_26_1:GetWordFromCfg(411051005).content), 2)

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0

				local var_29_4 = var_29_0 <= 0 and var_29_1 or var_29_1 * ((var_29_3 - arg_26_1.typewritterCharCountI18N) / var_29_0)

				if (var_29_0 <= 0 and var_29_1 or var_29_1 * ((var_29_3 - arg_26_1.typewritterCharCountI18N) / var_29_0)) > 0 and var_29_1 < var_29_4 then
					arg_26_1.talkMaxDuration = var_29_4

					if var_29_4 + 0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_4 + 0
					end
				end
			end

			local var_29_5 = math.max(3.2, arg_26_1.talkMaxDuration)

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_5 then
				arg_26_1.fswtw_.percent = Mathf.Lerp(arg_26_1.var_.oldValueTypewriter, var_29_2, (arg_26_1.time_ - 0) / var_29_5)
				arg_26_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_26_1.fswtw_:SetDirty()
			end

			if arg_26_1.time_ >= 0 + var_29_5 and arg_26_1.time_ < 0 + var_29_5 + arg_29_0 then
				arg_26_1.fswtw_.percent = var_29_2

				arg_26_1.fswtw_:SetDirty()
				arg_26_1:ShowNextGo(true)

				arg_26_1.typewritterCharCountI18N = var_29_3
			end

			local var_29_6 = 0
			local var_29_7 = manager.audio:GetVoiceLength("story_v_out_411051", "411051006", "story_v_out_411051.awb") / 1000

			if var_29_7 > 0 and 1 < var_29_7 and var_29_7 + var_29_6 > arg_26_1.duration_ then
				arg_26_1.duration_ = var_29_7 + var_29_6
			end

			if var_29_6 < arg_26_1.time_ and arg_26_1.time_ <= var_29_6 + arg_29_0 then
				arg_26_1:AudioAction("play", "voice", "story_v_out_411051", "411051006", "story_v_out_411051.awb")
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play411051007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 411051007
		arg_30_1.duration_ = 2.47

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play411051008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				arg_30_1.var_.oldValueTypewriter = arg_30_1.fswtw_.percent

				SetActive(arg_30_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_30_1:ShowNextGo(false)
			end

			local var_33_0 = 37
			local var_33_1 = 2.46666666666667
			local var_33_2, var_33_3 = arg_30_1:GetPercentByPara(arg_30_1:FormatText(arg_30_1:GetWordFromCfg(411051005).content), 3)

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0

				local var_33_4 = var_33_0 <= 0 and var_33_1 or var_33_1 * ((var_33_3 - arg_30_1.typewritterCharCountI18N) / var_33_0)

				if (var_33_0 <= 0 and var_33_1 or var_33_1 * ((var_33_3 - arg_30_1.typewritterCharCountI18N) / var_33_0)) > 0 and var_33_1 < var_33_4 then
					arg_30_1.talkMaxDuration = var_33_4

					if var_33_4 + 0 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_4 + 0
					end
				end
			end

			local var_33_5 = math.max(2.46666666666667, arg_30_1.talkMaxDuration)

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_5 then
				arg_30_1.fswtw_.percent = Mathf.Lerp(arg_30_1.var_.oldValueTypewriter, var_33_2, (arg_30_1.time_ - 0) / var_33_5)
				arg_30_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_30_1.fswtw_:SetDirty()
			end

			if arg_30_1.time_ >= 0 + var_33_5 and arg_30_1.time_ < 0 + var_33_5 + arg_33_0 then
				arg_30_1.fswtw_.percent = var_33_2

				arg_30_1.fswtw_:SetDirty()
				arg_30_1:ShowNextGo(true)

				arg_30_1.typewritterCharCountI18N = var_33_3
			end

			local var_33_6 = 0
			local var_33_7 = manager.audio:GetVoiceLength("story_v_out_411051", "411051007", "story_v_out_411051.awb") / 1000

			if var_33_7 > 0 and 1 < var_33_7 and var_33_7 + var_33_6 > arg_30_1.duration_ then
				arg_30_1.duration_ = var_33_7 + var_33_6
			end

			if var_33_6 < arg_30_1.time_ and arg_30_1.time_ <= var_33_6 + arg_33_0 then
				arg_30_1:AudioAction("play", "voice", "story_v_out_411051", "411051007", "story_v_out_411051.awb")
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play411051008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 411051008
		arg_34_1.duration_ = 2.67

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play411051009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1.var_.oldValueTypewriter = arg_34_1.fswtw_.percent

				SetActive(arg_34_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_34_1:ShowNextGo(false)
			end

			local var_37_0 = 40
			local var_37_1 = 2.66666666666667
			local var_37_2, var_37_3 = arg_34_1:GetPercentByPara(arg_34_1:FormatText(arg_34_1:GetWordFromCfg(411051005).content), 4)

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0

				local var_37_4 = var_37_0 <= 0 and var_37_1 or var_37_1 * ((var_37_3 - arg_34_1.typewritterCharCountI18N) / var_37_0)

				if (var_37_0 <= 0 and var_37_1 or var_37_1 * ((var_37_3 - arg_34_1.typewritterCharCountI18N) / var_37_0)) > 0 and var_37_1 < var_37_4 then
					arg_34_1.talkMaxDuration = var_37_4

					if var_37_4 + 0 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_4 + 0
					end
				end
			end

			local var_37_5 = math.max(2.66666666666667, arg_34_1.talkMaxDuration)

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_5 then
				arg_34_1.fswtw_.percent = Mathf.Lerp(arg_34_1.var_.oldValueTypewriter, var_37_2, (arg_34_1.time_ - 0) / var_37_5)
				arg_34_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_34_1.fswtw_:SetDirty()
			end

			if arg_34_1.time_ >= 0 + var_37_5 and arg_34_1.time_ < 0 + var_37_5 + arg_37_0 then
				arg_34_1.fswtw_.percent = var_37_2

				arg_34_1.fswtw_:SetDirty()
				arg_34_1:ShowNextGo(true)

				arg_34_1.typewritterCharCountI18N = var_37_3
			end

			local var_37_6 = 0
			local var_37_7 = manager.audio:GetVoiceLength("story_v_out_411051", "411051008", "story_v_out_411051.awb") / 1000

			if var_37_7 > 0 and 1 < var_37_7 and var_37_7 + var_37_6 > arg_34_1.duration_ then
				arg_34_1.duration_ = var_37_7 + var_37_6
			end

			if var_37_6 < arg_34_1.time_ and arg_34_1.time_ <= var_37_6 + arg_37_0 then
				arg_34_1:AudioAction("play", "voice", "story_v_out_411051", "411051008", "story_v_out_411051.awb")
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play411051009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 411051009
		arg_38_1.duration_ = 5

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play411051010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1.fswbg_:SetActive(true)
				arg_38_1.dialog_:SetActive(false)

				arg_38_1.fswtw_.percent = 0
				arg_38_1.fswt_.text = arg_38_1:FormatText(arg_38_1:GetWordFromCfg(411051009).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.fswt_)

				arg_38_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_38_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_38_1.fswtw_:SetDirty()

				arg_38_1.typewritterCharCountI18N = 0

				SetActive(arg_38_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_38_1:ShowNextGo(false)
			end

			local var_41_0 = 0.666666666666667

			if 0.666666666666667 < arg_38_1.time_ and arg_38_1.time_ <= var_41_0 + arg_41_0 then
				arg_38_1.var_.oldValueTypewriter = arg_38_1.fswtw_.percent

				SetActive(arg_38_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_38_1:ShowNextGo(false)
			end

			local var_41_1 = 9
			local var_41_2 = 0.6
			local var_41_3, var_41_4 = arg_38_1:GetPercentByPara(arg_38_1:FormatText(arg_38_1:GetWordFromCfg(411051009).content), 1)

			if var_41_0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_0 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0

				local var_41_5 = var_41_1 <= 0 and var_41_2 or var_41_2 * ((var_41_4 - arg_38_1.typewritterCharCountI18N) / var_41_1)

				if (var_41_1 <= 0 and var_41_2 or var_41_2 * ((var_41_4 - arg_38_1.typewritterCharCountI18N) / var_41_1)) > 0 and var_41_2 < var_41_5 then
					arg_38_1.talkMaxDuration = var_41_5

					if var_41_5 + var_41_0 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_5 + var_41_0
					end
				end
			end

			local var_41_6 = math.max(0.6, arg_38_1.talkMaxDuration)

			if var_41_0 <= arg_38_1.time_ and arg_38_1.time_ < var_41_0 + var_41_6 then
				arg_38_1.fswtw_.percent = Mathf.Lerp(arg_38_1.var_.oldValueTypewriter, var_41_3, (arg_38_1.time_ - var_41_0) / var_41_6)
				arg_38_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_38_1.fswtw_:SetDirty()
			end

			if arg_38_1.time_ >= var_41_0 + var_41_6 and arg_38_1.time_ < var_41_0 + var_41_6 + arg_41_0 then
				arg_38_1.fswtw_.percent = var_41_3

				arg_38_1.fswtw_:SetDirty()
				arg_38_1:ShowNextGo(true)

				arg_38_1.typewritterCharCountI18N = var_41_4
			end

			local var_41_7 = 0.5
			local var_41_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051009", "story_v_out_411051.awb") / 1000

			if var_41_8 > 0 and 1 < var_41_8 and var_41_8 + var_41_7 > arg_38_1.duration_ then
				arg_38_1.duration_ = var_41_8 + var_41_7
			end

			if var_41_7 < arg_38_1.time_ and arg_38_1.time_ <= var_41_7 + arg_41_0 then
				arg_38_1:AudioAction("play", "voice", "story_v_out_411051", "411051009", "story_v_out_411051.awb")
			end

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				local var_41_10 = arg_38_1.fswbg_.transform:Find("textbox/adapt/content") or arg_38_1.fswbg_.transform:Find("textbox/content")
				local var_41_11 = arg_38_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_41_12 = var_41_10:GetComponent("RectTransform")

				var_41_10:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleLeft
				var_41_12.offsetMin = Vector2.New(5.15, -270.1)
				var_41_12.offsetMax = Vector2.New(49.67, 6.8)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play411051010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 411051010
		arg_42_1.duration_ = 1.4

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play411051011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1.var_.oldValueTypewriter = arg_42_1.fswtw_.percent

				SetActive(arg_42_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_42_1:ShowNextGo(false)
			end

			local var_45_0 = 21
			local var_45_1 = 1.4
			local var_45_2, var_45_3 = arg_42_1:GetPercentByPara(arg_42_1:FormatText(arg_42_1:GetWordFromCfg(411051009).content), 2)

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0

				local var_45_4 = var_45_0 <= 0 and var_45_1 or var_45_1 * ((var_45_3 - arg_42_1.typewritterCharCountI18N) / var_45_0)

				if (var_45_0 <= 0 and var_45_1 or var_45_1 * ((var_45_3 - arg_42_1.typewritterCharCountI18N) / var_45_0)) > 0 and var_45_1 < var_45_4 then
					arg_42_1.talkMaxDuration = var_45_4

					if var_45_4 + 0 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_4 + 0
					end
				end
			end

			local var_45_5 = math.max(1.4, arg_42_1.talkMaxDuration)

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_5 then
				arg_42_1.fswtw_.percent = Mathf.Lerp(arg_42_1.var_.oldValueTypewriter, var_45_2, (arg_42_1.time_ - 0) / var_45_5)
				arg_42_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_42_1.fswtw_:SetDirty()
			end

			if arg_42_1.time_ >= 0 + var_45_5 and arg_42_1.time_ < 0 + var_45_5 + arg_45_0 then
				arg_42_1.fswtw_.percent = var_45_2

				arg_42_1.fswtw_:SetDirty()
				arg_42_1:ShowNextGo(true)

				arg_42_1.typewritterCharCountI18N = var_45_3
			end

			local var_45_6 = 0
			local var_45_7 = manager.audio:GetVoiceLength("story_v_out_411051", "411051010", "story_v_out_411051.awb") / 1000

			if var_45_7 > 0 and 1 < var_45_7 and var_45_7 + var_45_6 > arg_42_1.duration_ then
				arg_42_1.duration_ = var_45_7 + var_45_6
			end

			if var_45_6 < arg_42_1.time_ and arg_42_1.time_ <= var_45_6 + arg_45_0 then
				arg_42_1:AudioAction("play", "voice", "story_v_out_411051", "411051010", "story_v_out_411051.awb")
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play411051011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 411051011
		arg_46_1.duration_ = 3.27

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play411051012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1.var_.oldValueTypewriter = arg_46_1.fswtw_.percent

				SetActive(arg_46_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_46_1:ShowNextGo(false)
			end

			local var_49_0 = 49
			local var_49_1 = 3.26666666666667
			local var_49_2, var_49_3 = arg_46_1:GetPercentByPara(arg_46_1:FormatText(arg_46_1:GetWordFromCfg(411051009).content), 3)

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0

				local var_49_4 = var_49_0 <= 0 and var_49_1 or var_49_1 * ((var_49_3 - arg_46_1.typewritterCharCountI18N) / var_49_0)

				if (var_49_0 <= 0 and var_49_1 or var_49_1 * ((var_49_3 - arg_46_1.typewritterCharCountI18N) / var_49_0)) > 0 and var_49_1 < var_49_4 then
					arg_46_1.talkMaxDuration = var_49_4

					if var_49_4 + 0 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_4 + 0
					end
				end
			end

			local var_49_5 = math.max(3.26666666666667, arg_46_1.talkMaxDuration)

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_5 then
				arg_46_1.fswtw_.percent = Mathf.Lerp(arg_46_1.var_.oldValueTypewriter, var_49_2, (arg_46_1.time_ - 0) / var_49_5)
				arg_46_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_46_1.fswtw_:SetDirty()
			end

			if arg_46_1.time_ >= 0 + var_49_5 and arg_46_1.time_ < 0 + var_49_5 + arg_49_0 then
				arg_46_1.fswtw_.percent = var_49_2

				arg_46_1.fswtw_:SetDirty()
				arg_46_1:ShowNextGo(true)

				arg_46_1.typewritterCharCountI18N = var_49_3
			end

			local var_49_6 = 0
			local var_49_7 = manager.audio:GetVoiceLength("story_v_out_411051", "411051011", "story_v_out_411051.awb") / 1000

			if var_49_7 > 0 and 1 < var_49_7 and var_49_7 + var_49_6 > arg_46_1.duration_ then
				arg_46_1.duration_ = var_49_7 + var_49_6
			end

			if var_49_6 < arg_46_1.time_ and arg_46_1.time_ <= var_49_6 + arg_49_0 then
				arg_46_1:AudioAction("play", "voice", "story_v_out_411051", "411051011", "story_v_out_411051.awb")
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play411051012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 411051012
		arg_50_1.duration_ = 1.2

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play411051013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.var_.oldValueTypewriter = arg_50_1.fswtw_.percent

				SetActive(arg_50_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_50_1:ShowNextGo(false)
			end

			local var_53_0 = 18
			local var_53_1 = 1.2
			local var_53_2, var_53_3 = arg_50_1:GetPercentByPara(arg_50_1:FormatText(arg_50_1:GetWordFromCfg(411051009).content), 4)

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0

				local var_53_4 = var_53_0 <= 0 and var_53_1 or var_53_1 * ((var_53_3 - arg_50_1.typewritterCharCountI18N) / var_53_0)

				if (var_53_0 <= 0 and var_53_1 or var_53_1 * ((var_53_3 - arg_50_1.typewritterCharCountI18N) / var_53_0)) > 0 and var_53_1 < var_53_4 then
					arg_50_1.talkMaxDuration = var_53_4

					if var_53_4 + 0 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_4 + 0
					end
				end
			end

			local var_53_5 = math.max(1.2, arg_50_1.talkMaxDuration)

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_5 then
				arg_50_1.fswtw_.percent = Mathf.Lerp(arg_50_1.var_.oldValueTypewriter, var_53_2, (arg_50_1.time_ - 0) / var_53_5)
				arg_50_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_50_1.fswtw_:SetDirty()
			end

			if arg_50_1.time_ >= 0 + var_53_5 and arg_50_1.time_ < 0 + var_53_5 + arg_53_0 then
				arg_50_1.fswtw_.percent = var_53_2

				arg_50_1.fswtw_:SetDirty()
				arg_50_1:ShowNextGo(true)

				arg_50_1.typewritterCharCountI18N = var_53_3
			end

			local var_53_6 = 0
			local var_53_7 = manager.audio:GetVoiceLength("story_v_out_411051", "411051012", "story_v_out_411051.awb") / 1000

			if var_53_7 > 0 and 1 < var_53_7 and var_53_7 + var_53_6 > arg_50_1.duration_ then
				arg_50_1.duration_ = var_53_7 + var_53_6
			end

			if var_53_6 < arg_50_1.time_ and arg_50_1.time_ <= var_53_6 + arg_53_0 then
				arg_50_1:AudioAction("play", "voice", "story_v_out_411051", "411051012", "story_v_out_411051.awb")
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play411051013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 411051013
		arg_54_1.duration_ = 8.63

		local var_54_0 = {
			zh = 8.63400000184774,
			ja = 4.53400000184774
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
				arg_54_0:Play411051014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			if arg_54_1.actors_["10058ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10058ui_story"))) then
				local var_57_0 = Object.Instantiate(Asset.Load("Char/" .. "10058ui_story"), arg_54_1.stage_.transform)

				var_57_0.name = "10058ui_story"
				var_57_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_54_1.actors_["10058ui_story"] = var_57_0

				local var_57_1 = var_57_0:GetComponentInChildren(typeof(CharacterEffect))

				var_57_1.enabled = true

				local var_57_2 = GameObjectTools.GetOrAddComponent(var_57_0, typeof(DynamicBoneHelper))

				if var_57_2 then
					var_57_2:EnableDynamicBone(false)
				end

				arg_54_1:ShowWeapon(var_57_1.transform, false)

				arg_54_1.var_["10058ui_story" .. "Animator"] = var_57_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_54_1.var_["10058ui_story" .. "Animator"].applyRootMotion = true
				arg_54_1.var_["10058ui_story" .. "LipSync"] = var_57_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_57_3 = arg_54_1.actors_["10058ui_story"].transform

			if 2 < arg_54_1.time_ and arg_54_1.time_ <= 2 + arg_57_0 then
				arg_54_1.var_.moveOldPos10058ui_story = var_57_3.localPosition
			end

			local var_57_4 = 0.001

			if 2 <= arg_54_1.time_ and arg_54_1.time_ < 2 + var_57_4 then
				var_57_3.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_54_1.time_ - 2) / var_57_4)
				var_57_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_57_3.position).x, (manager.ui.mainCamera.transform.position - var_57_3.position).y, (manager.ui.mainCamera.transform.position - var_57_3.position).z)
				var_57_3.localEulerAngles.z = 0
				var_57_3.localEulerAngles.x = 0
				var_57_3.localEulerAngles = var_57_3.localEulerAngles
			end

			if arg_54_1.time_ >= 2 + var_57_4 and arg_54_1.time_ < 2 + var_57_4 + arg_57_0 then
				var_57_3.localPosition = Vector3.New(0, -0.98, -6.1)
				var_57_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_57_3.position).x, (manager.ui.mainCamera.transform.position - var_57_3.position).y, (manager.ui.mainCamera.transform.position - var_57_3.position).z)
				var_57_3.localEulerAngles.z = 0
				var_57_3.localEulerAngles.x = 0
				var_57_3.localEulerAngles = var_57_3.localEulerAngles
			end

			local var_57_5 = arg_54_1.actors_["10058ui_story"]

			if 2 < arg_54_1.time_ and arg_54_1.time_ <= 2 + arg_57_0 and not isNil(var_57_5) and arg_54_1.var_.characterEffect10058ui_story == nil then
				arg_54_1.var_.characterEffect10058ui_story = var_57_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_6 = 0.200000002980232

			if 2 <= arg_54_1.time_ and arg_54_1.time_ < 2 + var_57_6 and not isNil(var_57_5) then
				if arg_54_1.var_.characterEffect10058ui_story and not isNil(var_57_5) then
					arg_54_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_54_1.time_ >= 2 + var_57_6 and arg_54_1.time_ < 2 + var_57_6 + arg_57_0 and not isNil(var_57_5) and arg_54_1.var_.characterEffect10058ui_story then
				arg_54_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 2 < arg_54_1.time_ and arg_54_1.time_ <= 2 + arg_57_0 then
				arg_54_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 2 < arg_54_1.time_ and arg_54_1.time_ <= 2 + arg_57_0 then
				arg_54_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0.766666669646899 < arg_54_1.time_ and arg_54_1.time_ <= 0.766666669646899 + arg_57_0 then
				arg_54_1.fswbg_:SetActive(false)
				arg_54_1.dialog_:SetActive(false)
				SetActive(arg_54_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_54_1:ShowNextGo(false)
			end

			if 0.766666669646899 < arg_54_1.time_ and arg_54_1.time_ <= 0.766666669646899 + arg_57_0 then
				local var_57_8 = arg_54_1.bgs_.ST74

				arg_54_1.bgs_.ST74.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_57_8.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_57_9 = var_57_8:GetComponent("SpriteRenderer")

				if var_57_9 and var_57_9.sprite then
					local var_57_10 = 2 * (var_57_8.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_57_8.transform.localScale = Vector3.New(var_57_10 / var_57_9.sprite.bounds.size.y < var_57_10 * manager.ui.mainCameraCom_.aspect / var_57_9.sprite.bounds.size.x and var_57_10 * manager.ui.mainCameraCom_.aspect / var_57_9.sprite.bounds.size.x or var_57_10 / var_57_9.sprite.bounds.size.y, var_57_10 / var_57_9.sprite.bounds.size.y < var_57_10 * manager.ui.mainCameraCom_.aspect / var_57_9.sprite.bounds.size.x and var_57_10 * manager.ui.mainCameraCom_.aspect / var_57_9.sprite.bounds.size.x or var_57_10 / var_57_9.sprite.bounds.size.y, 0)
				end

				for iter_57_0, iter_57_1 in pairs(arg_54_1.bgs_) do
					if iter_57_0 ~= "ST74" then
						iter_57_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_57_11 = 0

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_11 + arg_57_0 then
				arg_54_1.mask_.enabled = true
				arg_54_1.mask_.raycastTarget = true

				arg_54_1:SetGaussion(false)
			end

			local var_57_12 = 0.766666669646899

			if var_57_11 <= arg_54_1.time_ and arg_54_1.time_ < var_57_11 + var_57_12 then
				local var_57_13 = Color.New(0, 0, 0)

				var_57_13.a = Mathf.Lerp(0, 1, (arg_54_1.time_ - var_57_11) / var_57_12)
				arg_54_1.mask_.color = var_57_13
			end

			if arg_54_1.time_ >= var_57_11 + var_57_12 and arg_54_1.time_ < var_57_11 + var_57_12 + arg_57_0 then
				local var_57_14 = Color.New(0, 0, 0)

				var_57_14.a = 1
				arg_54_1.mask_.color = var_57_14
			end

			local var_57_15 = 0.766666669646899

			if 0.766666669646899 < arg_54_1.time_ and arg_54_1.time_ <= var_57_15 + arg_57_0 then
				arg_54_1.mask_.enabled = true
				arg_54_1.mask_.raycastTarget = true

				arg_54_1:SetGaussion(false)
			end

			local var_57_16 = 1.33333333333333

			if var_57_15 <= arg_54_1.time_ and arg_54_1.time_ < var_57_15 + var_57_16 then
				local var_57_17 = Color.New(0, 0, 0)

				var_57_17.a = Mathf.Lerp(1, 0, (arg_54_1.time_ - var_57_15) / var_57_16)
				arg_54_1.mask_.color = var_57_17
			end

			if arg_54_1.time_ >= var_57_15 + var_57_16 and arg_54_1.time_ < var_57_15 + var_57_16 + arg_57_0 then
				local var_57_18 = Color.New(0, 0, 0)

				arg_54_1.mask_.enabled = false
				var_57_18.a = 0
				arg_54_1.mask_.color = var_57_18
			end

			if arg_54_1.frameCnt_ <= 1 then
				arg_54_1.dialog_:SetActive(false)
			end

			local var_57_19 = 2.03400000184774
			local var_57_20 = 0.525

			if 2.03400000184774 < arg_54_1.time_ and arg_54_1.time_ <= var_57_19 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0

				arg_54_1.dialog_:SetActive(true)

				arg_54_1.dialogCg_.alpha = 0

				local var_57_21 = LeanTween.value(arg_54_1.dialog_, 0, 1, 0.3)

				var_57_21:setOnUpdate(LuaHelper.FloatAction(function(arg_58_0)
					arg_54_1.dialogCg_.alpha = arg_58_0
				end))
				var_57_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_54_1.dialog_)
					var_57_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_54_1.duration_ = arg_54_1.duration_ + 0.3

				SetActive(arg_54_1.leftNameGo_, true)

				arg_54_1.leftNameTxt_.text = arg_54_1:FormatText(StoryNameCfg[695].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_22 = arg_54_1:GetWordFromCfg(411051013)
				local var_57_23 = arg_54_1:FormatText(var_57_22.content)

				arg_54_1.text_.text = var_57_23

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_25 = 21 <= 0 and var_57_20 or var_57_20 * (utf8.len(var_57_23) / 21)

				if (21 <= 0 and var_57_20 or var_57_20 * (utf8.len(var_57_23) / 21)) > 0 and var_57_20 < var_57_25 then
					arg_54_1.talkMaxDuration = var_57_25
					var_57_19 = var_57_19 + 0.3

					if var_57_25 + var_57_19 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_25 + var_57_19
					end
				end

				arg_54_1.text_.text = var_57_23
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051013", "story_v_out_411051.awb") ~= 0 then
					local var_57_26 = manager.audio:GetVoiceLength("story_v_out_411051", "411051013", "story_v_out_411051.awb") / 1000

					if var_57_26 + var_57_19 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_26 + var_57_19
					end

					if var_57_22.prefab_name ~= "" and arg_54_1.actors_[var_57_22.prefab_name] ~= nil then
						local var_57_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_22.prefab_name].transform, "story_v_out_411051", "411051013", "story_v_out_411051.awb")

						arg_54_1:RecordAudio("411051013", var_57_27)
						arg_54_1:RecordAudio("411051013", var_57_27)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_411051", "411051013", "story_v_out_411051.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_411051", "411051013", "story_v_out_411051.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_28 = var_57_19 + 0.3
			local var_57_29 = math.max(var_57_20, arg_54_1.talkMaxDuration)

			if var_57_19 + 0.3 <= arg_54_1.time_ and arg_54_1.time_ < var_57_28 + var_57_29 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_28) / var_57_29

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_28 + var_57_29 and arg_54_1.time_ < var_57_28 + var_57_29 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_54_1:InitPlayNodeList()
	end,
	Play411051014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 411051014
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play411051015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(arg_60_1.actors_["10058ui_story"]) and arg_60_1.var_.characterEffect10058ui_story == nil then
				arg_60_1.var_.characterEffect10058ui_story = arg_60_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_0 = 0.200000002980232

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_0 and not isNil(arg_60_1.actors_["10058ui_story"]) then
				if arg_60_1.var_.characterEffect10058ui_story and not isNil(arg_60_1.actors_["10058ui_story"]) then
					arg_60_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_60_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_60_1.time_ - 0) / var_63_0)
				end
			end

			if arg_60_1.time_ >= 0 + var_63_0 and arg_60_1.time_ < 0 + var_63_0 + arg_63_0 and not isNil(arg_60_1.actors_["10058ui_story"]) and arg_60_1.var_.characterEffect10058ui_story then
				arg_60_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_60_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_63_1 = 0
			local var_63_2 = 1.475

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, false)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_3 = arg_60_1:FormatText(arg_60_1:GetWordFromCfg(411051014).content)

				arg_60_1.text_.text = var_63_3

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_5 = 59 <= 0 and var_63_2 or var_63_2 * (utf8.len(var_63_3) / 59)

				if (59 <= 0 and var_63_2 or var_63_2 * (utf8.len(var_63_3) / 59)) > 0 and var_63_2 < var_63_5 then
					arg_60_1.talkMaxDuration = var_63_5

					if var_63_5 + var_63_1 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_5 + var_63_1
					end
				end

				arg_60_1.text_.text = var_63_3
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_6 = math.max(var_63_2, arg_60_1.talkMaxDuration)

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_6 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_1) / var_63_6

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_1 + var_63_6 and arg_60_1.time_ < var_63_1 + var_63_6 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play411051015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 411051015
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play411051016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = 0.7

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, false)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_1 = arg_64_1:FormatText(arg_64_1:GetWordFromCfg(411051015).content)

				arg_64_1.text_.text = var_67_1

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_3 = 28 <= 0 and var_67_0 or var_67_0 * (utf8.len(var_67_1) / 28)

				if (28 <= 0 and var_67_0 or var_67_0 * (utf8.len(var_67_1) / 28)) > 0 and var_67_0 < var_67_3 then
					arg_64_1.talkMaxDuration = var_67_3

					if var_67_3 + 0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_3 + 0
					end
				end

				arg_64_1.text_.text = var_67_1
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_4 = math.max(var_67_0, arg_64_1.talkMaxDuration)

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_4 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - 0) / var_67_4

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= 0 + var_67_4 and arg_64_1.time_ < 0 + var_67_4 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play411051016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 411051016
		arg_68_1.duration_ = 9.1

		local var_68_0 = {
			zh = 8.633,
			ja = 9.1
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
				arg_68_0:Play411051017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 1.025

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[670].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, true)
				arg_68_1.iconController_:SetSelectedState("hero")

				arg_68_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10071")

				arg_68_1.callingController_:SetSelectedState("normal")

				arg_68_1.keyicon_.color = Color.New(1, 1, 1)
				arg_68_1.icon_.color = Color.New(1, 1, 1)

				local var_71_1 = arg_68_1:GetWordFromCfg(411051016)
				local var_71_2 = arg_68_1:FormatText(var_71_1.content)

				arg_68_1.text_.text = var_71_2

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_4 = 41 <= 0 and var_71_0 or var_71_0 * (utf8.len(var_71_2) / 41)

				if (41 <= 0 and var_71_0 or var_71_0 * (utf8.len(var_71_2) / 41)) > 0 and var_71_0 < var_71_4 then
					arg_68_1.talkMaxDuration = var_71_4

					if var_71_4 + 0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_4 + 0
					end
				end

				arg_68_1.text_.text = var_71_2
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051016", "story_v_out_411051.awb") ~= 0 then
					local var_71_5 = manager.audio:GetVoiceLength("story_v_out_411051", "411051016", "story_v_out_411051.awb") / 1000

					if var_71_5 + 0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_5 + 0
					end

					if var_71_1.prefab_name ~= "" and arg_68_1.actors_[var_71_1.prefab_name] ~= nil then
						local var_71_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_1.prefab_name].transform, "story_v_out_411051", "411051016", "story_v_out_411051.awb")

						arg_68_1:RecordAudio("411051016", var_71_6)
						arg_68_1:RecordAudio("411051016", var_71_6)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_411051", "411051016", "story_v_out_411051.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_411051", "411051016", "story_v_out_411051.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_7 = math.max(var_71_0, arg_68_1.talkMaxDuration)

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_7 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - 0) / var_71_7

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= 0 + var_71_7 and arg_68_1.time_ < 0 + var_71_7 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play411051017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 411051017
		arg_72_1.duration_ = 7.9

		local var_72_0 = {
			zh = 6.8,
			ja = 7.9
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
				arg_72_0:Play411051018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0.85

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[670].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, true)
				arg_72_1.iconController_:SetSelectedState("hero")

				arg_72_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10071")

				arg_72_1.callingController_:SetSelectedState("normal")

				arg_72_1.keyicon_.color = Color.New(1, 1, 1)
				arg_72_1.icon_.color = Color.New(1, 1, 1)

				local var_75_1 = arg_72_1:GetWordFromCfg(411051017)
				local var_75_2 = arg_72_1:FormatText(var_75_1.content)

				arg_72_1.text_.text = var_75_2

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_4 = 34 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_2) / 34)

				if (34 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_2) / 34)) > 0 and var_75_0 < var_75_4 then
					arg_72_1.talkMaxDuration = var_75_4

					if var_75_4 + 0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_4 + 0
					end
				end

				arg_72_1.text_.text = var_75_2
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051017", "story_v_out_411051.awb") ~= 0 then
					local var_75_5 = manager.audio:GetVoiceLength("story_v_out_411051", "411051017", "story_v_out_411051.awb") / 1000

					if var_75_5 + 0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_5 + 0
					end

					if var_75_1.prefab_name ~= "" and arg_72_1.actors_[var_75_1.prefab_name] ~= nil then
						local var_75_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_1.prefab_name].transform, "story_v_out_411051", "411051017", "story_v_out_411051.awb")

						arg_72_1:RecordAudio("411051017", var_75_6)
						arg_72_1:RecordAudio("411051017", var_75_6)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_411051", "411051017", "story_v_out_411051.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_411051", "411051017", "story_v_out_411051.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_7 = math.max(var_75_0, arg_72_1.talkMaxDuration)

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_7 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - 0) / var_75_7

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= 0 + var_75_7 and arg_72_1.time_ < 0 + var_75_7 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play411051018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 411051018
		arg_76_1.duration_ = 7.57

		local var_76_0 = {
			zh = 7.566,
			ja = 6.766
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
				arg_76_0:Play411051019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.var_.moveOldPos10058ui_story = arg_76_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_79_0 = 0.001

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_0 then
				arg_76_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_76_1.time_ - 0) / var_79_0)
				arg_76_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_76_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["10058ui_story"].transform.position).z)
				arg_76_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_76_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_76_1.actors_["10058ui_story"].transform.localEulerAngles = arg_76_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_76_1.time_ >= 0 + var_79_0 and arg_76_1.time_ < 0 + var_79_0 + arg_79_0 then
				arg_76_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_76_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_76_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["10058ui_story"].transform.position).z)
				arg_76_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_76_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_76_1.actors_["10058ui_story"].transform.localEulerAngles = arg_76_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_79_1 = arg_76_1.actors_["10058ui_story"]

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(var_79_1) and arg_76_1.var_.characterEffect10058ui_story == nil then
				arg_76_1.var_.characterEffect10058ui_story = var_79_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_2 = 0.200000002980232

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_2 and not isNil(var_79_1) then
				if arg_76_1.var_.characterEffect10058ui_story and not isNil(var_79_1) then
					arg_76_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= 0 + var_79_2 and arg_76_1.time_ < 0 + var_79_2 + arg_79_0 and not isNil(var_79_1) and arg_76_1.var_.characterEffect10058ui_story then
				arg_76_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_79_4 = 0
			local var_79_5 = 0.525

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_4 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_6 = arg_76_1:GetWordFromCfg(411051018)
				local var_79_7 = arg_76_1:FormatText(var_79_6.content)

				arg_76_1.text_.text = var_79_7

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_9 = 21 <= 0 and var_79_5 or var_79_5 * (utf8.len(var_79_7) / 21)

				if (21 <= 0 and var_79_5 or var_79_5 * (utf8.len(var_79_7) / 21)) > 0 and var_79_5 < var_79_9 then
					arg_76_1.talkMaxDuration = var_79_9

					if var_79_9 + var_79_4 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_9 + var_79_4
					end
				end

				arg_76_1.text_.text = var_79_7
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051018", "story_v_out_411051.awb") ~= 0 then
					local var_79_10 = manager.audio:GetVoiceLength("story_v_out_411051", "411051018", "story_v_out_411051.awb") / 1000

					if var_79_10 + var_79_4 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_10 + var_79_4
					end

					if var_79_6.prefab_name ~= "" and arg_76_1.actors_[var_79_6.prefab_name] ~= nil then
						local var_79_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_6.prefab_name].transform, "story_v_out_411051", "411051018", "story_v_out_411051.awb")

						arg_76_1:RecordAudio("411051018", var_79_11)
						arg_76_1:RecordAudio("411051018", var_79_11)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_411051", "411051018", "story_v_out_411051.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_411051", "411051018", "story_v_out_411051.awb")
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
				actorName = "10058ui_story",
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
	Play411051019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 411051019
		arg_80_1.duration_ = 10

		local var_80_0 = {
			zh = 6.833,
			ja = 10
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
				arg_80_0:Play411051020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0.6

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_1 = arg_80_1:GetWordFromCfg(411051019)
				local var_83_2 = arg_80_1:FormatText(var_83_1.content)

				arg_80_1.text_.text = var_83_2

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_4 = 24 <= 0 and var_83_0 or var_83_0 * (utf8.len(var_83_2) / 24)

				if (24 <= 0 and var_83_0 or var_83_0 * (utf8.len(var_83_2) / 24)) > 0 and var_83_0 < var_83_4 then
					arg_80_1.talkMaxDuration = var_83_4

					if var_83_4 + 0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_4 + 0
					end
				end

				arg_80_1.text_.text = var_83_2
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051019", "story_v_out_411051.awb") ~= 0 then
					local var_83_5 = manager.audio:GetVoiceLength("story_v_out_411051", "411051019", "story_v_out_411051.awb") / 1000

					if var_83_5 + 0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_5 + 0
					end

					if var_83_1.prefab_name ~= "" and arg_80_1.actors_[var_83_1.prefab_name] ~= nil then
						local var_83_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_1.prefab_name].transform, "story_v_out_411051", "411051019", "story_v_out_411051.awb")

						arg_80_1:RecordAudio("411051019", var_83_6)
						arg_80_1:RecordAudio("411051019", var_83_6)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_411051", "411051019", "story_v_out_411051.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_411051", "411051019", "story_v_out_411051.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_7 = math.max(var_83_0, arg_80_1.talkMaxDuration)

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_7 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - 0) / var_83_7

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= 0 + var_83_7 and arg_80_1.time_ < 0 + var_83_7 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play411051020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 411051020
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play411051021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(arg_84_1.actors_["10058ui_story"]) and arg_84_1.var_.characterEffect10058ui_story == nil then
				arg_84_1.var_.characterEffect10058ui_story = arg_84_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_0 = 0.200000002980232

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_0 and not isNil(arg_84_1.actors_["10058ui_story"]) then
				if arg_84_1.var_.characterEffect10058ui_story and not isNil(arg_84_1.actors_["10058ui_story"]) then
					arg_84_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_84_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_84_1.time_ - 0) / var_87_0)
				end
			end

			if arg_84_1.time_ >= 0 + var_87_0 and arg_84_1.time_ < 0 + var_87_0 + arg_87_0 and not isNil(arg_84_1.actors_["10058ui_story"]) and arg_84_1.var_.characterEffect10058ui_story then
				arg_84_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_84_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_87_1 = 0
			local var_87_2 = 1.275

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

				local var_87_3 = arg_84_1:FormatText(arg_84_1:GetWordFromCfg(411051020).content)

				arg_84_1.text_.text = var_87_3

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_5 = 51 <= 0 and var_87_2 or var_87_2 * (utf8.len(var_87_3) / 51)

				if (51 <= 0 and var_87_2 or var_87_2 * (utf8.len(var_87_3) / 51)) > 0 and var_87_2 < var_87_5 then
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
	Play411051021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 411051021
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play411051022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 0.7

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, false)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_1 = arg_88_1:FormatText(arg_88_1:GetWordFromCfg(411051021).content)

				arg_88_1.text_.text = var_91_1

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_3 = 28 <= 0 and var_91_0 or var_91_0 * (utf8.len(var_91_1) / 28)

				if (28 <= 0 and var_91_0 or var_91_0 * (utf8.len(var_91_1) / 28)) > 0 and var_91_0 < var_91_3 then
					arg_88_1.talkMaxDuration = var_91_3

					if var_91_3 + 0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_3 + 0
					end
				end

				arg_88_1.text_.text = var_91_1
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_4 = math.max(var_91_0, arg_88_1.talkMaxDuration)

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_4 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - 0) / var_91_4

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= 0 + var_91_4 and arg_88_1.time_ < 0 + var_91_4 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play411051022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 411051022
		arg_92_1.duration_ = 8.1

		local var_92_0 = {
			zh = 8.1,
			ja = 7.8
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
				arg_92_0:Play411051023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if arg_92_1.bgs_.ST03 == nil then
				local var_95_0 = Object.Instantiate(arg_92_1.paintGo_)

				var_95_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST03")
				var_95_0.name = "ST03"
				var_95_0.transform.parent = arg_92_1.stage_.transform
				var_95_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_92_1.bgs_.ST03 = var_95_0
			end

			if 2 < arg_92_1.time_ and arg_92_1.time_ <= 2 + arg_95_0 then
				local var_95_1 = arg_92_1.bgs_.ST03

				arg_92_1.bgs_.ST03.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_95_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_95_2 = var_95_1:GetComponent("SpriteRenderer")

				if var_95_2 and var_95_2.sprite then
					local var_95_3 = 2 * (var_95_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_95_1.transform.localScale = Vector3.New(var_95_3 / var_95_2.sprite.bounds.size.y < var_95_3 * manager.ui.mainCameraCom_.aspect / var_95_2.sprite.bounds.size.x and var_95_3 * manager.ui.mainCameraCom_.aspect / var_95_2.sprite.bounds.size.x or var_95_3 / var_95_2.sprite.bounds.size.y, var_95_3 / var_95_2.sprite.bounds.size.y < var_95_3 * manager.ui.mainCameraCom_.aspect / var_95_2.sprite.bounds.size.x and var_95_3 * manager.ui.mainCameraCom_.aspect / var_95_2.sprite.bounds.size.x or var_95_3 / var_95_2.sprite.bounds.size.y, 0)
				end

				for iter_95_0, iter_95_1 in pairs(arg_92_1.bgs_) do
					if iter_95_0 ~= "ST03" then
						iter_95_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_95_4 = 0

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_4 + arg_95_0 then
				arg_92_1.mask_.enabled = true
				arg_92_1.mask_.raycastTarget = true

				arg_92_1:SetGaussion(false)
			end

			local var_95_5 = 2

			if var_95_4 <= arg_92_1.time_ and arg_92_1.time_ < var_95_4 + var_95_5 then
				local var_95_6 = Color.New(0, 0, 0)

				var_95_6.a = Mathf.Lerp(0, 1, (arg_92_1.time_ - var_95_4) / var_95_5)
				arg_92_1.mask_.color = var_95_6
			end

			if arg_92_1.time_ >= var_95_4 + var_95_5 and arg_92_1.time_ < var_95_4 + var_95_5 + arg_95_0 then
				local var_95_7 = Color.New(0, 0, 0)

				var_95_7.a = 1
				arg_92_1.mask_.color = var_95_7
			end

			local var_95_8 = 2

			if 2 < arg_92_1.time_ and arg_92_1.time_ <= var_95_8 + arg_95_0 then
				arg_92_1.mask_.enabled = true
				arg_92_1.mask_.raycastTarget = true

				arg_92_1:SetGaussion(false)
			end

			local var_95_9 = 1.8

			if var_95_8 <= arg_92_1.time_ and arg_92_1.time_ < var_95_8 + var_95_9 then
				local var_95_10 = Color.New(0, 0, 0)

				var_95_10.a = Mathf.Lerp(1, 0, (arg_92_1.time_ - var_95_8) / var_95_9)
				arg_92_1.mask_.color = var_95_10
			end

			if arg_92_1.time_ >= var_95_8 + var_95_9 and arg_92_1.time_ < var_95_8 + var_95_9 + arg_95_0 then
				local var_95_11 = Color.New(0, 0, 0)

				arg_92_1.mask_.enabled = false
				var_95_11.a = 0
				arg_92_1.mask_.color = var_95_11
			end

			local var_95_12 = arg_92_1.actors_["10058ui_story"].transform

			if 1.96599999815226 < arg_92_1.time_ and arg_92_1.time_ <= 1.96599999815226 + arg_95_0 then
				arg_92_1.var_.moveOldPos10058ui_story = var_95_12.localPosition
			end

			local var_95_13 = 0.001

			if 1.96599999815226 <= arg_92_1.time_ and arg_92_1.time_ < 1.96599999815226 + var_95_13 then
				var_95_12.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_92_1.time_ - 1.96599999815226) / var_95_13)
				var_95_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_95_12.position).x, (manager.ui.mainCamera.transform.position - var_95_12.position).y, (manager.ui.mainCamera.transform.position - var_95_12.position).z)
				var_95_12.localEulerAngles.z = 0
				var_95_12.localEulerAngles.x = 0
				var_95_12.localEulerAngles = var_95_12.localEulerAngles
			end

			if arg_92_1.time_ >= 1.96599999815226 + var_95_13 and arg_92_1.time_ < 1.96599999815226 + var_95_13 + arg_95_0 then
				var_95_12.localPosition = Vector3.New(0, 100, 0)
				var_95_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_95_12.position).x, (manager.ui.mainCamera.transform.position - var_95_12.position).y, (manager.ui.mainCamera.transform.position - var_95_12.position).z)
				var_95_12.localEulerAngles.z = 0
				var_95_12.localEulerAngles.x = 0
				var_95_12.localEulerAngles = var_95_12.localEulerAngles
			end

			local var_95_14 = arg_92_1.actors_["10058ui_story"].transform

			if 3.8 < arg_92_1.time_ and arg_92_1.time_ <= 3.8 + arg_95_0 then
				arg_92_1.var_.moveOldPos10058ui_story = var_95_14.localPosition
			end

			local var_95_15 = 0.001

			if 3.8 <= arg_92_1.time_ and arg_92_1.time_ < 3.8 + var_95_15 then
				var_95_14.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_92_1.time_ - 3.8) / var_95_15)
				var_95_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_95_14.position).x, (manager.ui.mainCamera.transform.position - var_95_14.position).y, (manager.ui.mainCamera.transform.position - var_95_14.position).z)
				var_95_14.localEulerAngles.z = 0
				var_95_14.localEulerAngles.x = 0
				var_95_14.localEulerAngles = var_95_14.localEulerAngles
			end

			if arg_92_1.time_ >= 3.8 + var_95_15 and arg_92_1.time_ < 3.8 + var_95_15 + arg_95_0 then
				var_95_14.localPosition = Vector3.New(0, -0.98, -6.1)
				var_95_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_95_14.position).x, (manager.ui.mainCamera.transform.position - var_95_14.position).y, (manager.ui.mainCamera.transform.position - var_95_14.position).z)
				var_95_14.localEulerAngles.z = 0
				var_95_14.localEulerAngles.x = 0
				var_95_14.localEulerAngles = var_95_14.localEulerAngles
			end

			local var_95_16 = arg_92_1.actors_["10058ui_story"]

			if 3.8 < arg_92_1.time_ and arg_92_1.time_ <= 3.8 + arg_95_0 and not isNil(var_95_16) and arg_92_1.var_.characterEffect10058ui_story == nil then
				arg_92_1.var_.characterEffect10058ui_story = var_95_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_17 = 0.200000002980232

			if 3.8 <= arg_92_1.time_ and arg_92_1.time_ < 3.8 + var_95_17 and not isNil(var_95_16) then
				if arg_92_1.var_.characterEffect10058ui_story and not isNil(var_95_16) then
					arg_92_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= 3.8 + var_95_17 and arg_92_1.time_ < 3.8 + var_95_17 + arg_95_0 and not isNil(var_95_16) and arg_92_1.var_.characterEffect10058ui_story then
				arg_92_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 3.8 < arg_92_1.time_ and arg_92_1.time_ <= 3.8 + arg_95_0 then
				arg_92_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 3.8 < arg_92_1.time_ and arg_92_1.time_ <= 3.8 + arg_95_0 then
				arg_92_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if arg_92_1.frameCnt_ <= 1 then
				arg_92_1.dialog_:SetActive(false)
			end

			local var_95_19 = 3.8
			local var_95_20 = 0.375

			if 3.8 < arg_92_1.time_ and arg_92_1.time_ <= var_95_19 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0

				arg_92_1.dialog_:SetActive(true)

				arg_92_1.dialogCg_.alpha = 0

				local var_95_21 = LeanTween.value(arg_92_1.dialog_, 0, 1, 0.3)

				var_95_21:setOnUpdate(LuaHelper.FloatAction(function(arg_96_0)
					arg_92_1.dialogCg_.alpha = arg_96_0
				end))
				var_95_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_92_1.dialog_)
					var_95_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_92_1.duration_ = arg_92_1.duration_ + 0.3

				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_22 = arg_92_1:GetWordFromCfg(411051022)
				local var_95_23 = arg_92_1:FormatText(var_95_22.content)

				arg_92_1.text_.text = var_95_23

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_25 = 15 <= 0 and var_95_20 or var_95_20 * (utf8.len(var_95_23) / 15)

				if (15 <= 0 and var_95_20 or var_95_20 * (utf8.len(var_95_23) / 15)) > 0 and var_95_20 < var_95_25 then
					arg_92_1.talkMaxDuration = var_95_25
					var_95_19 = var_95_19 + 0.3

					if var_95_25 + var_95_19 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_25 + var_95_19
					end
				end

				arg_92_1.text_.text = var_95_23
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051022", "story_v_out_411051.awb") ~= 0 then
					local var_95_26 = manager.audio:GetVoiceLength("story_v_out_411051", "411051022", "story_v_out_411051.awb") / 1000

					if var_95_26 + var_95_19 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_26 + var_95_19
					end

					if var_95_22.prefab_name ~= "" and arg_92_1.actors_[var_95_22.prefab_name] ~= nil then
						local var_95_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_22.prefab_name].transform, "story_v_out_411051", "411051022", "story_v_out_411051.awb")

						arg_92_1:RecordAudio("411051022", var_95_27)
						arg_92_1:RecordAudio("411051022", var_95_27)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_411051", "411051022", "story_v_out_411051.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_411051", "411051022", "story_v_out_411051.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_28 = var_95_19 + 0.3
			local var_95_29 = math.max(var_95_20, arg_92_1.talkMaxDuration)

			if var_95_19 + 0.3 <= arg_92_1.time_ and arg_92_1.time_ < var_95_28 + var_95_29 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_28) / var_95_29

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_28 + var_95_29 and arg_92_1.time_ < var_95_28 + var_95_29 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_92_1:InitPlayNodeList()
	end,
	Play411051023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 411051023
		arg_98_1.duration_ = 4.1

		local var_98_0 = {
			zh = 3.266,
			ja = 4.1
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
				arg_98_0:Play411051024(arg_98_1)
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

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_101_3 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_98_1.bgmTxt_.text ~= var_101_3 and arg_98_1.bgmTxt_.text ~= "" then
						if arg_98_1.bgmTxt2_.text ~= "" then
							arg_98_1.bgmTxt_.text = arg_98_1.bgmTxt2_.text
						end

						arg_98_1.bgmTxt2_.text = var_101_3

						arg_98_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_98_1.bgmTxt_.text = var_101_3
						arg_98_1.bgmTxt2_.text = var_101_3
					end

					if arg_98_1.bgmTimer then
						arg_98_1.bgmTimer:Stop()

						arg_98_1.bgmTimer = nil
					end

					if arg_98_1.settingData.show_music_name == 1 then
						arg_98_1.musicController:SetSelectedState("show")
						arg_98_1.musicAnimator_:Play("open", 0, 0)

						if arg_98_1.settingData.music_time ~= 0 then
							arg_98_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_98_1.settingData.music_time), function()
								if arg_98_1 == nil or isNil(arg_98_1.bgmTxt_) then
									return
								end

								arg_98_1.musicController:SetSelectedState("hide")
								arg_98_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_101_4 = 0
			local var_101_5 = 0.35

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_4 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, true)
				arg_98_1.iconController_:SetSelectedState("hero")

				arg_98_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10014")

				arg_98_1.callingController_:SetSelectedState("calling")

				arg_98_1.keyicon_.color = Color.New(1, 1, 1)
				arg_98_1.icon_.color = Color.New(1, 1, 1)

				local var_101_6 = arg_98_1:GetWordFromCfg(411051023)
				local var_101_7 = arg_98_1:FormatText(var_101_6.content)

				arg_98_1.text_.text = var_101_7

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_9 = 14 <= 0 and var_101_5 or var_101_5 * (utf8.len(var_101_7) / 14)

				if (14 <= 0 and var_101_5 or var_101_5 * (utf8.len(var_101_7) / 14)) > 0 and var_101_5 < var_101_9 then
					arg_98_1.talkMaxDuration = var_101_9

					if var_101_9 + var_101_4 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_9 + var_101_4
					end
				end

				arg_98_1.text_.text = var_101_7
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051023", "story_v_out_411051.awb") ~= 0 then
					local var_101_10 = manager.audio:GetVoiceLength("story_v_out_411051", "411051023", "story_v_out_411051.awb") / 1000

					if var_101_10 + var_101_4 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_10 + var_101_4
					end

					if var_101_6.prefab_name ~= "" and arg_98_1.actors_[var_101_6.prefab_name] ~= nil then
						local var_101_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_6.prefab_name].transform, "story_v_out_411051", "411051023", "story_v_out_411051.awb")

						arg_98_1:RecordAudio("411051023", var_101_11)
						arg_98_1:RecordAudio("411051023", var_101_11)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_411051", "411051023", "story_v_out_411051.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_411051", "411051023", "story_v_out_411051.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_12 = math.max(var_101_5, arg_98_1.talkMaxDuration)

			if var_101_4 <= arg_98_1.time_ and arg_98_1.time_ < var_101_4 + var_101_12 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_4) / var_101_12

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_4 + var_101_12 and arg_98_1.time_ < var_101_4 + var_101_12 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play411051024 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 411051024
		arg_103_1.duration_ = 2

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play411051025(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_106_0 = arg_103_1.actors_["10058ui_story"]

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.characterEffect10058ui_story == nil then
				arg_103_1.var_.characterEffect10058ui_story = var_106_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_1 = 0.200000002980232

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_1 and not isNil(var_106_0) then
				if arg_103_1.var_.characterEffect10058ui_story and not isNil(var_106_0) then
					arg_103_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= 0 + var_106_1 and arg_103_1.time_ < 0 + var_106_1 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.characterEffect10058ui_story then
				arg_103_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_106_3 = 0
			local var_106_4 = 0.05

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_3 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_5 = arg_103_1:GetWordFromCfg(411051024)
				local var_106_6 = arg_103_1:FormatText(var_106_5.content)

				arg_103_1.text_.text = var_106_6

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_8 = 2 <= 0 and var_106_4 or var_106_4 * (utf8.len(var_106_6) / 2)

				if (2 <= 0 and var_106_4 or var_106_4 * (utf8.len(var_106_6) / 2)) > 0 and var_106_4 < var_106_8 then
					arg_103_1.talkMaxDuration = var_106_8

					if var_106_8 + var_106_3 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_8 + var_106_3
					end
				end

				arg_103_1.text_.text = var_106_6
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051024", "story_v_out_411051.awb") ~= 0 then
					local var_106_9 = manager.audio:GetVoiceLength("story_v_out_411051", "411051024", "story_v_out_411051.awb") / 1000

					if var_106_9 + var_106_3 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_9 + var_106_3
					end

					if var_106_5.prefab_name ~= "" and arg_103_1.actors_[var_106_5.prefab_name] ~= nil then
						local var_106_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_5.prefab_name].transform, "story_v_out_411051", "411051024", "story_v_out_411051.awb")

						arg_103_1:RecordAudio("411051024", var_106_10)
						arg_103_1:RecordAudio("411051024", var_106_10)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_411051", "411051024", "story_v_out_411051.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_411051", "411051024", "story_v_out_411051.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_11 = math.max(var_106_4, arg_103_1.talkMaxDuration)

			if var_106_3 <= arg_103_1.time_ and arg_103_1.time_ < var_106_3 + var_106_11 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_3) / var_106_11

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_3 + var_106_11 and arg_103_1.time_ < var_106_3 + var_106_11 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play411051025 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 411051025
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play411051026(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(arg_107_1.actors_["10058ui_story"]) and arg_107_1.var_.characterEffect10058ui_story == nil then
				arg_107_1.var_.characterEffect10058ui_story = arg_107_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_0 = 0.200000002980232

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 and not isNil(arg_107_1.actors_["10058ui_story"]) then
				if arg_107_1.var_.characterEffect10058ui_story and not isNil(arg_107_1.actors_["10058ui_story"]) then
					arg_107_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_107_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_107_1.time_ - 0) / var_110_0)
				end
			end

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 and not isNil(arg_107_1.actors_["10058ui_story"]) and arg_107_1.var_.characterEffect10058ui_story then
				arg_107_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_107_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_110_1 = arg_107_1.actors_["10058ui_story"].transform

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos10058ui_story = var_110_1.localPosition
			end

			local var_110_2 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_2 then
				var_110_1.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_107_1.time_ - 0) / var_110_2)
				var_110_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_110_1.position).x, (manager.ui.mainCamera.transform.position - var_110_1.position).y, (manager.ui.mainCamera.transform.position - var_110_1.position).z)
				var_110_1.localEulerAngles.z = 0
				var_110_1.localEulerAngles.x = 0
				var_110_1.localEulerAngles = var_110_1.localEulerAngles
			end

			if arg_107_1.time_ >= 0 + var_110_2 and arg_107_1.time_ < 0 + var_110_2 + arg_110_0 then
				var_110_1.localPosition = Vector3.New(0, 100, 0)
				var_110_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_110_1.position).x, (manager.ui.mainCamera.transform.position - var_110_1.position).y, (manager.ui.mainCamera.transform.position - var_110_1.position).z)
				var_110_1.localEulerAngles.z = 0
				var_110_1.localEulerAngles.x = 0
				var_110_1.localEulerAngles = var_110_1.localEulerAngles
			end

			local var_110_3 = 0
			local var_110_4 = 0.95

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_3 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, false)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_5 = arg_107_1:FormatText(arg_107_1:GetWordFromCfg(411051025).content)

				arg_107_1.text_.text = var_110_5

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_7 = 38 <= 0 and var_110_4 or var_110_4 * (utf8.len(var_110_5) / 38)

				if (38 <= 0 and var_110_4 or var_110_4 * (utf8.len(var_110_5) / 38)) > 0 and var_110_4 < var_110_7 then
					arg_107_1.talkMaxDuration = var_110_7

					if var_110_7 + var_110_3 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_7 + var_110_3
					end
				end

				arg_107_1.text_.text = var_110_5
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_8 = math.max(var_110_4, arg_107_1.talkMaxDuration)

			if var_110_3 <= arg_107_1.time_ and arg_107_1.time_ < var_110_3 + var_110_8 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_3) / var_110_8

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_3 + var_110_8 and arg_107_1.time_ < var_110_3 + var_110_8 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
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

		arg_107_1:InitPlayNodeList()
	end,
	Play411051026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 411051026
		arg_111_1.duration_ = 5.57

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play411051027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_9000

			if arg_111_1.bgs_.I07 == nil then
				local var_114_0 = Object.Instantiate(arg_111_1.paintGo_)

				var_114_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I07")
				var_114_0.name = "I07"
				var_114_0.transform.parent = arg_111_1.stage_.transform
				var_114_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_111_1.bgs_.I07 = var_114_0
			end

			if 0.566666666666667 < arg_111_1.time_ and arg_111_1.time_ <= 0.566666666666667 + arg_114_0 then
				local var_114_1 = arg_111_1.bgs_.I07

				arg_111_1.bgs_.I07.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_114_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_114_2 = var_114_1:GetComponent("SpriteRenderer")

				if var_114_2 and var_114_2.sprite then
					local var_114_3 = 2 * (var_114_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_114_1.transform.localScale = Vector3.New(var_114_3 / var_114_2.sprite.bounds.size.y < var_114_3 * manager.ui.mainCameraCom_.aspect / var_114_2.sprite.bounds.size.x and var_114_3 * manager.ui.mainCameraCom_.aspect / var_114_2.sprite.bounds.size.x or var_114_3 / var_114_2.sprite.bounds.size.y, var_114_3 / var_114_2.sprite.bounds.size.y < var_114_3 * manager.ui.mainCameraCom_.aspect / var_114_2.sprite.bounds.size.x and var_114_3 * manager.ui.mainCameraCom_.aspect / var_114_2.sprite.bounds.size.x or var_114_3 / var_114_2.sprite.bounds.size.y, 0)
				end

				for iter_114_0, iter_114_1 in pairs(arg_111_1.bgs_) do
					if iter_114_0 ~= "I07" then
						iter_114_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				local var_114_4 = arg_111_1.var_.effect112345

				if not arg_111_1.var_.effect112345 then
					var_114_4 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), manager.ui.mainCamera.transform)
					var_114_4.name = "112345"
					arg_111_1.var_.effect112345 = var_114_4
				else
					var_114_4.transform:SetParent(var_114_9000)
				end

				var_114_4.transform.localPosition = Vector3.New(0, 0, 0)
				var_114_4.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_114_8 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_111_1.bgmTxt_.text ~= var_114_8 and arg_111_1.bgmTxt_.text ~= "" then
						if arg_111_1.bgmTxt2_.text ~= "" then
							arg_111_1.bgmTxt_.text = arg_111_1.bgmTxt2_.text
						end

						arg_111_1.bgmTxt2_.text = var_114_8

						arg_111_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_111_1.bgmTxt_.text = var_114_8
						arg_111_1.bgmTxt2_.text = var_114_8
					end

					if arg_111_1.bgmTimer then
						arg_111_1.bgmTimer:Stop()

						arg_111_1.bgmTimer = nil
					end

					if arg_111_1.settingData.show_music_name == 1 then
						arg_111_1.musicController:SetSelectedState("show")
						arg_111_1.musicAnimator_:Play("open", 0, 0)

						if arg_111_1.settingData.music_time ~= 0 then
							arg_111_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_111_1.settingData.music_time), function()
								if arg_111_1 == nil or isNil(arg_111_1.bgmTxt_) then
									return
								end

								arg_111_1.musicController:SetSelectedState("hide")
								arg_111_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.6 < arg_111_1.time_ and arg_111_1.time_ <= 0.6 + arg_114_0 then
				arg_111_1:AudioAction("play", "music", "bgm_activity_3_0_story_northblock", "bgm_activity_3_0_story_northblock", "bgm_activity_3_0_story_northblock.awb")

				local var_114_11 = manager.audio:GetAudioName("bgm_activity_3_0_story_northblock", "bgm_activity_3_0_story_northblock")

				if "" ~= "" then
					if arg_111_1.bgmTxt_.text ~= var_114_11 and arg_111_1.bgmTxt_.text ~= "" then
						if arg_111_1.bgmTxt2_.text ~= "" then
							arg_111_1.bgmTxt_.text = arg_111_1.bgmTxt2_.text
						end

						arg_111_1.bgmTxt2_.text = var_114_11

						arg_111_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_111_1.bgmTxt_.text = var_114_11
						arg_111_1.bgmTxt2_.text = var_114_11
					end

					if arg_111_1.bgmTimer then
						arg_111_1.bgmTimer:Stop()

						arg_111_1.bgmTimer = nil
					end

					if arg_111_1.settingData.show_music_name == 1 then
						arg_111_1.musicController:SetSelectedState("show")
						arg_111_1.musicAnimator_:Play("open", 0, 0)

						if arg_111_1.settingData.music_time ~= 0 then
							arg_111_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_111_1.settingData.music_time), function()
								if arg_111_1 == nil or isNil(arg_111_1.bgmTxt_) then
									return
								end

								arg_111_1.musicController:SetSelectedState("hide")
								arg_111_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1:AudioAction("play", "effect", "se_story_130", "se_story_130_noise", "")
			end

			if arg_111_1.frameCnt_ <= 1 then
				arg_111_1.dialog_:SetActive(false)
			end

			local var_114_13 = 0.566666666666667
			local var_114_14 = 1.15

			if 0.566666666666667 < arg_111_1.time_ and arg_111_1.time_ <= var_114_13 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0

				arg_111_1.dialog_:SetActive(true)

				arg_111_1.dialogCg_.alpha = 0

				local var_114_15 = LeanTween.value(arg_111_1.dialog_, 0, 1, 0.3)

				var_114_15:setOnUpdate(LuaHelper.FloatAction(function(arg_117_0)
					arg_111_1.dialogCg_.alpha = arg_117_0
				end))
				var_114_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_111_1.dialog_)
					var_114_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_111_1.duration_ = arg_111_1.duration_ + 0.3

				SetActive(arg_111_1.leftNameGo_, false)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_16 = arg_111_1:FormatText(arg_111_1:GetWordFromCfg(411051026).content)

				arg_111_1.text_.text = var_114_16

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_18 = 46 <= 0 and var_114_14 or var_114_14 * (utf8.len(var_114_16) / 46)

				if (46 <= 0 and var_114_14 or var_114_14 * (utf8.len(var_114_16) / 46)) > 0 and var_114_14 < var_114_18 then
					arg_111_1.talkMaxDuration = var_114_18
					var_114_13 = var_114_13 + 0.3

					if var_114_18 + var_114_13 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_18 + var_114_13
					end
				end

				arg_111_1.text_.text = var_114_16
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_19 = var_114_13 + 0.3
			local var_114_20 = math.max(var_114_14, arg_111_1.talkMaxDuration)

			if var_114_13 + 0.3 <= arg_111_1.time_ and arg_111_1.time_ < var_114_19 + var_114_20 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_19) / var_114_20

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_19 + var_114_20 and arg_111_1.time_ < var_114_19 + var_114_20 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play411051027 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 411051027
		arg_119_1.duration_ = 4.63

		local var_119_0 = {
			zh = 2.4,
			ja = 4.633
		}
		local var_119_1 = manager.audio:GetLocalizationFlag()

		if var_119_0[var_119_1] ~= nil then
			arg_119_1.duration_ = var_119_0[var_119_1]
		end

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play411051028(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos10058ui_story = arg_119_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_122_0 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_0 then
				arg_119_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos10058ui_story, Vector3.New(-0.7, -0.98, -6.1), (arg_119_1.time_ - 0) / var_122_0)
				arg_119_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_119_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["10058ui_story"].transform.position).z)
				arg_119_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_119_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_119_1.actors_["10058ui_story"].transform.localEulerAngles = arg_119_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_119_1.time_ >= 0 + var_122_0 and arg_119_1.time_ < 0 + var_122_0 + arg_122_0 then
				arg_119_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(-0.7, -0.98, -6.1)
				arg_119_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_119_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["10058ui_story"].transform.position).z)
				arg_119_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_119_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_119_1.actors_["10058ui_story"].transform.localEulerAngles = arg_119_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_122_1 = arg_119_1.actors_["10058ui_story"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_1) and arg_119_1.var_.characterEffect10058ui_story == nil then
				arg_119_1.var_.characterEffect10058ui_story = var_122_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_2 = 0.200000002980232

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_2 and not isNil(var_122_1) then
				if arg_119_1.var_.characterEffect10058ui_story and not isNil(var_122_1) then
					arg_119_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= 0 + var_122_2 and arg_119_1.time_ < 0 + var_122_2 + arg_122_0 and not isNil(var_122_1) and arg_119_1.var_.characterEffect10058ui_story then
				arg_119_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_122_4 = "10014ui_story"

			if arg_119_1.actors_["10014ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10014ui_story"))) then
				local var_122_5 = Object.Instantiate(Asset.Load("Char/" .. "10014ui_story"), arg_119_1.stage_.transform)

				var_122_5.name = var_122_4
				var_122_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_119_1.actors_[var_122_4] = var_122_5

				local var_122_6 = var_122_5:GetComponentInChildren(typeof(CharacterEffect))

				var_122_6.enabled = true

				local var_122_7 = GameObjectTools.GetOrAddComponent(var_122_5, typeof(DynamicBoneHelper))

				if var_122_7 then
					var_122_7:EnableDynamicBone(false)
				end

				arg_119_1:ShowWeapon(var_122_6.transform, false)

				arg_119_1.var_[var_122_4 .. "Animator"] = var_122_6.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_119_1.var_[var_122_4 .. "Animator"].applyRootMotion = true
				arg_119_1.var_[var_122_4 .. "LipSync"] = var_122_6.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_122_8 = arg_119_1.actors_["10014ui_story"].transform

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos10014ui_story = var_122_8.localPosition
			end

			local var_122_9 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_9 then
				var_122_8.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos10014ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_119_1.time_ - 0) / var_122_9)
				var_122_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_122_8.position).x, (manager.ui.mainCamera.transform.position - var_122_8.position).y, (manager.ui.mainCamera.transform.position - var_122_8.position).z)
				var_122_8.localEulerAngles.z = 0
				var_122_8.localEulerAngles.x = 0
				var_122_8.localEulerAngles = var_122_8.localEulerAngles
			end

			if arg_119_1.time_ >= 0 + var_122_9 and arg_119_1.time_ < 0 + var_122_9 + arg_122_0 then
				var_122_8.localPosition = Vector3.New(0.7, -1.06, -6.2)
				var_122_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_122_8.position).x, (manager.ui.mainCamera.transform.position - var_122_8.position).y, (manager.ui.mainCamera.transform.position - var_122_8.position).z)
				var_122_8.localEulerAngles.z = 0
				var_122_8.localEulerAngles.x = 0
				var_122_8.localEulerAngles = var_122_8.localEulerAngles
			end

			local var_122_10 = arg_119_1.actors_["10014ui_story"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_10) and arg_119_1.var_.characterEffect10014ui_story == nil then
				arg_119_1.var_.characterEffect10014ui_story = var_122_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_11 = 0.183333336313566

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_11 and not isNil(var_122_10) then
				if arg_119_1.var_.characterEffect10014ui_story and not isNil(var_122_10) then
					arg_119_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_119_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_119_1.time_ - 0) / var_122_11)
				end
			end

			if arg_119_1.time_ >= 0 + var_122_11 and arg_119_1.time_ < 0 + var_122_11 + arg_122_0 and not isNil(var_122_10) and arg_119_1.var_.characterEffect10014ui_story then
				arg_119_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_119_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				if arg_119_1.var_.effect112345 then
					Object.Destroy(arg_119_1.var_.effect112345)

					arg_119_1.var_.effect112345 = nil
				end
			end

			local var_122_13 = 0
			local var_122_14 = 0.325

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_13 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_15 = arg_119_1:GetWordFromCfg(411051027)
				local var_122_16 = arg_119_1:FormatText(var_122_15.content)

				arg_119_1.text_.text = var_122_16

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_18 = 13 <= 0 and var_122_14 or var_122_14 * (utf8.len(var_122_16) / 13)

				if (13 <= 0 and var_122_14 or var_122_14 * (utf8.len(var_122_16) / 13)) > 0 and var_122_14 < var_122_18 then
					arg_119_1.talkMaxDuration = var_122_18

					if var_122_18 + var_122_13 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_18 + var_122_13
					end
				end

				arg_119_1.text_.text = var_122_16
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051027", "story_v_out_411051.awb") ~= 0 then
					local var_122_19 = manager.audio:GetVoiceLength("story_v_out_411051", "411051027", "story_v_out_411051.awb") / 1000

					if var_122_19 + var_122_13 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_19 + var_122_13
					end

					if var_122_15.prefab_name ~= "" and arg_119_1.actors_[var_122_15.prefab_name] ~= nil then
						local var_122_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_15.prefab_name].transform, "story_v_out_411051", "411051027", "story_v_out_411051.awb")

						arg_119_1:RecordAudio("411051027", var_122_20)
						arg_119_1:RecordAudio("411051027", var_122_20)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_411051", "411051027", "story_v_out_411051.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_411051", "411051027", "story_v_out_411051.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_21 = math.max(var_122_14, arg_119_1.talkMaxDuration)

			if var_122_13 <= arg_119_1.time_ and arg_119_1.time_ < var_122_13 + var_122_21 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_13) / var_122_21

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_13 + var_122_21 and arg_119_1.time_ < var_122_13 + var_122_21 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
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
				actorName = "10014ui_story",
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
	Play411051028 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 411051028
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play411051029(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(arg_123_1.actors_["10058ui_story"]) and arg_123_1.var_.characterEffect10058ui_story == nil then
				arg_123_1.var_.characterEffect10058ui_story = arg_123_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_0 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_0 and not isNil(arg_123_1.actors_["10058ui_story"]) then
				if arg_123_1.var_.characterEffect10058ui_story and not isNil(arg_123_1.actors_["10058ui_story"]) then
					arg_123_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_123_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_123_1.time_ - 0) / var_126_0)
				end
			end

			if arg_123_1.time_ >= 0 + var_126_0 and arg_123_1.time_ < 0 + var_126_0 + arg_126_0 and not isNil(arg_123_1.actors_["10058ui_story"]) and arg_123_1.var_.characterEffect10058ui_story then
				arg_123_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_123_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_126_1 = 0
			local var_126_2 = 1.025

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_3 = arg_123_1:FormatText(arg_123_1:GetWordFromCfg(411051028).content)

				arg_123_1.text_.text = var_126_3

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_5 = 41 <= 0 and var_126_2 or var_126_2 * (utf8.len(var_126_3) / 41)

				if (41 <= 0 and var_126_2 or var_126_2 * (utf8.len(var_126_3) / 41)) > 0 and var_126_2 < var_126_5 then
					arg_123_1.talkMaxDuration = var_126_5

					if var_126_5 + var_126_1 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_5 + var_126_1
					end
				end

				arg_123_1.text_.text = var_126_3
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_6 = math.max(var_126_2, arg_123_1.talkMaxDuration)

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_6 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_1) / var_126_6

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_1 + var_126_6 and arg_123_1.time_ < var_126_1 + var_126_6 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play411051029 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 411051029
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play411051030(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0.9

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, false)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_1 = arg_127_1:FormatText(arg_127_1:GetWordFromCfg(411051029).content)

				arg_127_1.text_.text = var_130_1

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_3 = 36 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_1) / 36)

				if (36 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_1) / 36)) > 0 and var_130_0 < var_130_3 then
					arg_127_1.talkMaxDuration = var_130_3

					if var_130_3 + 0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_3 + 0
					end
				end

				arg_127_1.text_.text = var_130_1
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_4 = math.max(var_130_0, arg_127_1.talkMaxDuration)

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_4 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - 0) / var_130_4

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= 0 + var_130_4 and arg_127_1.time_ < 0 + var_130_4 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play411051030 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 411051030
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play411051031(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 1.125

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, false)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_1 = arg_131_1:FormatText(arg_131_1:GetWordFromCfg(411051030).content)

				arg_131_1.text_.text = var_134_1

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_3 = 46 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_1) / 46)

				if (46 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_1) / 46)) > 0 and var_134_0 < var_134_3 then
					arg_131_1.talkMaxDuration = var_134_3

					if var_134_3 + 0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_3 + 0
					end
				end

				arg_131_1.text_.text = var_134_1
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_4 = math.max(var_134_0, arg_131_1.talkMaxDuration)

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_4 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - 0) / var_134_4

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= 0 + var_134_4 and arg_131_1.time_ < 0 + var_134_4 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play411051031 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 411051031
		arg_135_1.duration_ = 5.43

		local var_135_0 = {
			zh = 4.033,
			ja = 5.433
		}
		local var_135_1 = manager.audio:GetLocalizationFlag()

		if var_135_0[var_135_1] ~= nil then
			arg_135_1.duration_ = var_135_0[var_135_1]
		end

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play411051032(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos10014ui_story = arg_135_1.actors_["10014ui_story"].transform.localPosition
			end

			local var_138_0 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 then
				arg_135_1.actors_["10014ui_story"].transform.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos10014ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_135_1.time_ - 0) / var_138_0)
				arg_135_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_135_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["10014ui_story"].transform.position).z)
				arg_135_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_135_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_135_1.actors_["10014ui_story"].transform.localEulerAngles = arg_135_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 then
				arg_135_1.actors_["10014ui_story"].transform.localPosition = Vector3.New(0.7, -1.06, -6.2)
				arg_135_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_135_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["10014ui_story"].transform.position).z)
				arg_135_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_135_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_135_1.actors_["10014ui_story"].transform.localEulerAngles = arg_135_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			local var_138_1 = arg_135_1.actors_["10014ui_story"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_1) and arg_135_1.var_.characterEffect10014ui_story == nil then
				arg_135_1.var_.characterEffect10014ui_story = var_138_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_2 = 0.200000002980232

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_2 and not isNil(var_138_1) then
				if arg_135_1.var_.characterEffect10014ui_story and not isNil(var_138_1) then
					arg_135_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= 0 + var_138_2 and arg_135_1.time_ < 0 + var_138_2 + arg_138_0 and not isNil(var_138_1) and arg_135_1.var_.characterEffect10014ui_story then
				arg_135_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action1_1")
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_138_4 = 0
			local var_138_5 = 0.475

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_4 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_6 = arg_135_1:GetWordFromCfg(411051031)
				local var_138_7 = arg_135_1:FormatText(var_138_6.content)

				arg_135_1.text_.text = var_138_7

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_9 = 19 <= 0 and var_138_5 or var_138_5 * (utf8.len(var_138_7) / 19)

				if (19 <= 0 and var_138_5 or var_138_5 * (utf8.len(var_138_7) / 19)) > 0 and var_138_5 < var_138_9 then
					arg_135_1.talkMaxDuration = var_138_9

					if var_138_9 + var_138_4 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_9 + var_138_4
					end
				end

				arg_135_1.text_.text = var_138_7
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051031", "story_v_out_411051.awb") ~= 0 then
					local var_138_10 = manager.audio:GetVoiceLength("story_v_out_411051", "411051031", "story_v_out_411051.awb") / 1000

					if var_138_10 + var_138_4 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_10 + var_138_4
					end

					if var_138_6.prefab_name ~= "" and arg_135_1.actors_[var_138_6.prefab_name] ~= nil then
						local var_138_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_6.prefab_name].transform, "story_v_out_411051", "411051031", "story_v_out_411051.awb")

						arg_135_1:RecordAudio("411051031", var_138_11)
						arg_135_1:RecordAudio("411051031", var_138_11)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_411051", "411051031", "story_v_out_411051.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_411051", "411051031", "story_v_out_411051.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_12 = math.max(var_138_5, arg_135_1.talkMaxDuration)

			if var_138_4 <= arg_135_1.time_ and arg_135_1.time_ < var_138_4 + var_138_12 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_4) / var_138_12

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_4 + var_138_12 and arg_135_1.time_ < var_138_4 + var_138_12 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_135_1:InitPlayNodeList()
	end,
	Play411051032 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 411051032
		arg_139_1.duration_ = 4.1

		local var_139_0 = {
			zh = 2.6,
			ja = 4.1
		}
		local var_139_1 = manager.audio:GetLocalizationFlag()

		if var_139_0[var_139_1] ~= nil then
			arg_139_1.duration_ = var_139_0[var_139_1]
		end

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play411051033(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos10058ui_story = arg_139_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_142_0 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 then
				arg_139_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos10058ui_story, Vector3.New(-0.7, -0.98, -6.1), (arg_139_1.time_ - 0) / var_142_0)
				arg_139_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["10058ui_story"].transform.position).z)
				arg_139_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["10058ui_story"].transform.localEulerAngles = arg_139_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 then
				arg_139_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(-0.7, -0.98, -6.1)
				arg_139_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["10058ui_story"].transform.position).z)
				arg_139_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["10058ui_story"].transform.localEulerAngles = arg_139_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_142_1 = arg_139_1.actors_["10058ui_story"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_1) and arg_139_1.var_.characterEffect10058ui_story == nil then
				arg_139_1.var_.characterEffect10058ui_story = var_142_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_2 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_2 and not isNil(var_142_1) then
				if arg_139_1.var_.characterEffect10058ui_story and not isNil(var_142_1) then
					arg_139_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= 0 + var_142_2 and arg_139_1.time_ < 0 + var_142_2 + arg_142_0 and not isNil(var_142_1) and arg_139_1.var_.characterEffect10058ui_story then
				arg_139_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_142_4 = arg_139_1.actors_["10014ui_story"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_4) and arg_139_1.var_.characterEffect10014ui_story == nil then
				arg_139_1.var_.characterEffect10014ui_story = var_142_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_5 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_5 and not isNil(var_142_4) then
				if arg_139_1.var_.characterEffect10014ui_story and not isNil(var_142_4) then
					arg_139_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_139_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_139_1.time_ - 0) / var_142_5)
				end
			end

			if arg_139_1.time_ >= 0 + var_142_5 and arg_139_1.time_ < 0 + var_142_5 + arg_142_0 and not isNil(var_142_4) and arg_139_1.var_.characterEffect10014ui_story then
				arg_139_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_139_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_142_6 = 0
			local var_142_7 = 0.35

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_6 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_8 = arg_139_1:GetWordFromCfg(411051032)
				local var_142_9 = arg_139_1:FormatText(var_142_8.content)

				arg_139_1.text_.text = var_142_9

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_11 = 14 <= 0 and var_142_7 or var_142_7 * (utf8.len(var_142_9) / 14)

				if (14 <= 0 and var_142_7 or var_142_7 * (utf8.len(var_142_9) / 14)) > 0 and var_142_7 < var_142_11 then
					arg_139_1.talkMaxDuration = var_142_11

					if var_142_11 + var_142_6 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_11 + var_142_6
					end
				end

				arg_139_1.text_.text = var_142_9
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051032", "story_v_out_411051.awb") ~= 0 then
					local var_142_12 = manager.audio:GetVoiceLength("story_v_out_411051", "411051032", "story_v_out_411051.awb") / 1000

					if var_142_12 + var_142_6 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_12 + var_142_6
					end

					if var_142_8.prefab_name ~= "" and arg_139_1.actors_[var_142_8.prefab_name] ~= nil then
						local var_142_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_8.prefab_name].transform, "story_v_out_411051", "411051032", "story_v_out_411051.awb")

						arg_139_1:RecordAudio("411051032", var_142_13)
						arg_139_1:RecordAudio("411051032", var_142_13)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_411051", "411051032", "story_v_out_411051.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_411051", "411051032", "story_v_out_411051.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_14 = math.max(var_142_7, arg_139_1.talkMaxDuration)

			if var_142_6 <= arg_139_1.time_ and arg_139_1.time_ < var_142_6 + var_142_14 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_6) / var_142_14

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_6 + var_142_14 and arg_139_1.time_ < var_142_6 + var_142_14 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
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

		arg_139_1:InitPlayNodeList()
	end,
	Play411051033 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 411051033
		arg_143_1.duration_ = 9.17

		local var_143_0 = {
			zh = 8.966,
			ja = 9.166
		}
		local var_143_1 = manager.audio:GetLocalizationFlag()

		if var_143_0[var_143_1] ~= nil then
			arg_143_1.duration_ = var_143_0[var_143_1]
		end

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play411051034(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(arg_143_1.actors_["10058ui_story"]) and arg_143_1.var_.characterEffect10058ui_story == nil then
				arg_143_1.var_.characterEffect10058ui_story = arg_143_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_0 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 and not isNil(arg_143_1.actors_["10058ui_story"]) then
				if arg_143_1.var_.characterEffect10058ui_story and not isNil(arg_143_1.actors_["10058ui_story"]) then
					arg_143_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_143_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_143_1.time_ - 0) / var_146_0)
				end
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 and not isNil(arg_143_1.actors_["10058ui_story"]) and arg_143_1.var_.characterEffect10058ui_story then
				arg_143_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_143_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_146_1 = arg_143_1.actors_["10014ui_story"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect10014ui_story == nil then
				arg_143_1.var_.characterEffect10014ui_story = var_146_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_2 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_2 and not isNil(var_146_1) then
				if arg_143_1.var_.characterEffect10014ui_story and not isNil(var_146_1) then
					arg_143_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= 0 + var_146_2 and arg_143_1.time_ < 0 + var_146_2 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect10014ui_story then
				arg_143_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_146_4 = 0
			local var_146_5 = 1.125

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_4 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_6 = arg_143_1:GetWordFromCfg(411051033)
				local var_146_7 = arg_143_1:FormatText(var_146_6.content)

				arg_143_1.text_.text = var_146_7

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_9 = 45 <= 0 and var_146_5 or var_146_5 * (utf8.len(var_146_7) / 45)

				if (45 <= 0 and var_146_5 or var_146_5 * (utf8.len(var_146_7) / 45)) > 0 and var_146_5 < var_146_9 then
					arg_143_1.talkMaxDuration = var_146_9

					if var_146_9 + var_146_4 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_9 + var_146_4
					end
				end

				arg_143_1.text_.text = var_146_7
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051033", "story_v_out_411051.awb") ~= 0 then
					local var_146_10 = manager.audio:GetVoiceLength("story_v_out_411051", "411051033", "story_v_out_411051.awb") / 1000

					if var_146_10 + var_146_4 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_10 + var_146_4
					end

					if var_146_6.prefab_name ~= "" and arg_143_1.actors_[var_146_6.prefab_name] ~= nil then
						local var_146_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_6.prefab_name].transform, "story_v_out_411051", "411051033", "story_v_out_411051.awb")

						arg_143_1:RecordAudio("411051033", var_146_11)
						arg_143_1:RecordAudio("411051033", var_146_11)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_411051", "411051033", "story_v_out_411051.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_411051", "411051033", "story_v_out_411051.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_12 = math.max(var_146_5, arg_143_1.talkMaxDuration)

			if var_146_4 <= arg_143_1.time_ and arg_143_1.time_ < var_146_4 + var_146_12 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_4) / var_146_12

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_4 + var_146_12 and arg_143_1.time_ < var_146_4 + var_146_12 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play411051034 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 411051034
		arg_147_1.duration_ = 4

		local var_147_0 = {
			zh = 1.033,
			ja = 4
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
				arg_147_0:Play411051035(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(arg_147_1.actors_["10058ui_story"]) and arg_147_1.var_.characterEffect10058ui_story == nil then
				arg_147_1.var_.characterEffect10058ui_story = arg_147_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_0 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 and not isNil(arg_147_1.actors_["10058ui_story"]) then
				if arg_147_1.var_.characterEffect10058ui_story and not isNil(arg_147_1.actors_["10058ui_story"]) then
					arg_147_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 and not isNil(arg_147_1.actors_["10058ui_story"]) and arg_147_1.var_.characterEffect10058ui_story then
				arg_147_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_150_2 = arg_147_1.actors_["10014ui_story"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_2) and arg_147_1.var_.characterEffect10014ui_story == nil then
				arg_147_1.var_.characterEffect10014ui_story = var_150_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_3 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_3 and not isNil(var_150_2) then
				if arg_147_1.var_.characterEffect10014ui_story and not isNil(var_150_2) then
					arg_147_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_147_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_147_1.time_ - 0) / var_150_3)
				end
			end

			if arg_147_1.time_ >= 0 + var_150_3 and arg_147_1.time_ < 0 + var_150_3 + arg_150_0 and not isNil(var_150_2) and arg_147_1.var_.characterEffect10014ui_story then
				arg_147_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_147_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_150_4 = 0
			local var_150_5 = 0.125

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_4 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_6 = arg_147_1:GetWordFromCfg(411051034)
				local var_150_7 = arg_147_1:FormatText(var_150_6.content)

				arg_147_1.text_.text = var_150_7

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_9 = 5 <= 0 and var_150_5 or var_150_5 * (utf8.len(var_150_7) / 5)

				if (5 <= 0 and var_150_5 or var_150_5 * (utf8.len(var_150_7) / 5)) > 0 and var_150_5 < var_150_9 then
					arg_147_1.talkMaxDuration = var_150_9

					if var_150_9 + var_150_4 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_9 + var_150_4
					end
				end

				arg_147_1.text_.text = var_150_7
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051034", "story_v_out_411051.awb") ~= 0 then
					local var_150_10 = manager.audio:GetVoiceLength("story_v_out_411051", "411051034", "story_v_out_411051.awb") / 1000

					if var_150_10 + var_150_4 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_10 + var_150_4
					end

					if var_150_6.prefab_name ~= "" and arg_147_1.actors_[var_150_6.prefab_name] ~= nil then
						local var_150_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_6.prefab_name].transform, "story_v_out_411051", "411051034", "story_v_out_411051.awb")

						arg_147_1:RecordAudio("411051034", var_150_11)
						arg_147_1:RecordAudio("411051034", var_150_11)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_411051", "411051034", "story_v_out_411051.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_411051", "411051034", "story_v_out_411051.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_12 = math.max(var_150_5, arg_147_1.talkMaxDuration)

			if var_150_4 <= arg_147_1.time_ and arg_147_1.time_ < var_150_4 + var_150_12 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_4) / var_150_12

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_4 + var_150_12 and arg_147_1.time_ < var_150_4 + var_150_12 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play411051035 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 411051035
		arg_151_1.duration_ = 6.3

		local var_151_0 = {
			zh = 4.3,
			ja = 6.3
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
				arg_151_0:Play411051036(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_154_0 = 0
			local var_154_1 = 0.575

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_2 = arg_151_1:GetWordFromCfg(411051035)
				local var_154_3 = arg_151_1:FormatText(var_154_2.content)

				arg_151_1.text_.text = var_154_3

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_5 = 23 <= 0 and var_154_1 or var_154_1 * (utf8.len(var_154_3) / 23)

				if (23 <= 0 and var_154_1 or var_154_1 * (utf8.len(var_154_3) / 23)) > 0 and var_154_1 < var_154_5 then
					arg_151_1.talkMaxDuration = var_154_5

					if var_154_5 + var_154_0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_5 + var_154_0
					end
				end

				arg_151_1.text_.text = var_154_3
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051035", "story_v_out_411051.awb") ~= 0 then
					local var_154_6 = manager.audio:GetVoiceLength("story_v_out_411051", "411051035", "story_v_out_411051.awb") / 1000

					if var_154_6 + var_154_0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_6 + var_154_0
					end

					if var_154_2.prefab_name ~= "" and arg_151_1.actors_[var_154_2.prefab_name] ~= nil then
						local var_154_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_2.prefab_name].transform, "story_v_out_411051", "411051035", "story_v_out_411051.awb")

						arg_151_1:RecordAudio("411051035", var_154_7)
						arg_151_1:RecordAudio("411051035", var_154_7)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_411051", "411051035", "story_v_out_411051.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_411051", "411051035", "story_v_out_411051.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_8 = math.max(var_154_1, arg_151_1.talkMaxDuration)

			if var_154_0 <= arg_151_1.time_ and arg_151_1.time_ < var_154_0 + var_154_8 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_0) / var_154_8

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_0 + var_154_8 and arg_151_1.time_ < var_154_0 + var_154_8 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play411051036 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 411051036
		arg_155_1.duration_ = 3.93

		local var_155_0 = {
			zh = 2.033,
			ja = 3.933
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
				arg_155_0:Play411051037(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.var_.moveOldPos10014ui_story = arg_155_1.actors_["10014ui_story"].transform.localPosition
			end

			local var_158_0 = 0.001

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_0 then
				arg_155_1.actors_["10014ui_story"].transform.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos10014ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_155_1.time_ - 0) / var_158_0)
				arg_155_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_155_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["10014ui_story"].transform.position).z)
				arg_155_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_155_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_155_1.actors_["10014ui_story"].transform.localEulerAngles = arg_155_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			if arg_155_1.time_ >= 0 + var_158_0 and arg_155_1.time_ < 0 + var_158_0 + arg_158_0 then
				arg_155_1.actors_["10014ui_story"].transform.localPosition = Vector3.New(0.7, -1.06, -6.2)
				arg_155_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_155_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["10014ui_story"].transform.position).z)
				arg_155_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_155_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_155_1.actors_["10014ui_story"].transform.localEulerAngles = arg_155_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			local var_158_1 = arg_155_1.actors_["10014ui_story"]

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(var_158_1) and arg_155_1.var_.characterEffect10014ui_story == nil then
				arg_155_1.var_.characterEffect10014ui_story = var_158_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_2 = 0.200000002980232

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_2 and not isNil(var_158_1) then
				if arg_155_1.var_.characterEffect10014ui_story and not isNil(var_158_1) then
					arg_155_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= 0 + var_158_2 and arg_155_1.time_ < 0 + var_158_2 + arg_158_0 and not isNil(var_158_1) and arg_155_1.var_.characterEffect10014ui_story then
				arg_155_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action3_1")
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_158_4 = arg_155_1.actors_["10058ui_story"]

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(var_158_4) and arg_155_1.var_.characterEffect10058ui_story == nil then
				arg_155_1.var_.characterEffect10058ui_story = var_158_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_5 = 0.200000002980232

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_5 and not isNil(var_158_4) then
				if arg_155_1.var_.characterEffect10058ui_story and not isNil(var_158_4) then
					arg_155_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_155_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_155_1.time_ - 0) / var_158_5)
				end
			end

			if arg_155_1.time_ >= 0 + var_158_5 and arg_155_1.time_ < 0 + var_158_5 + arg_158_0 and not isNil(var_158_4) and arg_155_1.var_.characterEffect10058ui_story then
				arg_155_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_155_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_158_6 = 0
			local var_158_7 = 0.25

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_6 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_8 = arg_155_1:GetWordFromCfg(411051036)
				local var_158_9 = arg_155_1:FormatText(var_158_8.content)

				arg_155_1.text_.text = var_158_9

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_11 = 10 <= 0 and var_158_7 or var_158_7 * (utf8.len(var_158_9) / 10)

				if (10 <= 0 and var_158_7 or var_158_7 * (utf8.len(var_158_9) / 10)) > 0 and var_158_7 < var_158_11 then
					arg_155_1.talkMaxDuration = var_158_11

					if var_158_11 + var_158_6 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_11 + var_158_6
					end
				end

				arg_155_1.text_.text = var_158_9
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051036", "story_v_out_411051.awb") ~= 0 then
					local var_158_12 = manager.audio:GetVoiceLength("story_v_out_411051", "411051036", "story_v_out_411051.awb") / 1000

					if var_158_12 + var_158_6 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_12 + var_158_6
					end

					if var_158_8.prefab_name ~= "" and arg_155_1.actors_[var_158_8.prefab_name] ~= nil then
						local var_158_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_8.prefab_name].transform, "story_v_out_411051", "411051036", "story_v_out_411051.awb")

						arg_155_1:RecordAudio("411051036", var_158_13)
						arg_155_1:RecordAudio("411051036", var_158_13)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_411051", "411051036", "story_v_out_411051.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_411051", "411051036", "story_v_out_411051.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_14 = math.max(var_158_7, arg_155_1.talkMaxDuration)

			if var_158_6 <= arg_155_1.time_ and arg_155_1.time_ < var_158_6 + var_158_14 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_6) / var_158_14

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_6 + var_158_14 and arg_155_1.time_ < var_158_6 + var_158_14 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_155_1:InitPlayNodeList()
	end,
	Play411051037 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 411051037
		arg_159_1.duration_ = 3.03

		local var_159_0 = {
			zh = 3.033,
			ja = 1.8
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
				arg_159_0:Play411051038(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(arg_159_1.actors_["10014ui_story"]) and arg_159_1.var_.characterEffect10014ui_story == nil then
				arg_159_1.var_.characterEffect10014ui_story = arg_159_1.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_0 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 and not isNil(arg_159_1.actors_["10014ui_story"]) then
				if arg_159_1.var_.characterEffect10014ui_story and not isNil(arg_159_1.actors_["10014ui_story"]) then
					arg_159_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_159_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_159_1.time_ - 0) / var_162_0)
				end
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 and not isNil(arg_159_1.actors_["10014ui_story"]) and arg_159_1.var_.characterEffect10014ui_story then
				arg_159_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_159_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_162_1 = arg_159_1.actors_["10058ui_story"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_1) and arg_159_1.var_.characterEffect10058ui_story == nil then
				arg_159_1.var_.characterEffect10058ui_story = var_162_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_2 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_2 and not isNil(var_162_1) then
				if arg_159_1.var_.characterEffect10058ui_story and not isNil(var_162_1) then
					arg_159_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= 0 + var_162_2 and arg_159_1.time_ < 0 + var_162_2 + arg_162_0 and not isNil(var_162_1) and arg_159_1.var_.characterEffect10058ui_story then
				arg_159_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_162_4 = 0
			local var_162_5 = 0.35

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_4 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_6 = arg_159_1:GetWordFromCfg(411051037)
				local var_162_7 = arg_159_1:FormatText(var_162_6.content)

				arg_159_1.text_.text = var_162_7

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_9 = 14 <= 0 and var_162_5 or var_162_5 * (utf8.len(var_162_7) / 14)

				if (14 <= 0 and var_162_5 or var_162_5 * (utf8.len(var_162_7) / 14)) > 0 and var_162_5 < var_162_9 then
					arg_159_1.talkMaxDuration = var_162_9

					if var_162_9 + var_162_4 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_9 + var_162_4
					end
				end

				arg_159_1.text_.text = var_162_7
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051037", "story_v_out_411051.awb") ~= 0 then
					local var_162_10 = manager.audio:GetVoiceLength("story_v_out_411051", "411051037", "story_v_out_411051.awb") / 1000

					if var_162_10 + var_162_4 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_10 + var_162_4
					end

					if var_162_6.prefab_name ~= "" and arg_159_1.actors_[var_162_6.prefab_name] ~= nil then
						local var_162_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_6.prefab_name].transform, "story_v_out_411051", "411051037", "story_v_out_411051.awb")

						arg_159_1:RecordAudio("411051037", var_162_11)
						arg_159_1:RecordAudio("411051037", var_162_11)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_411051", "411051037", "story_v_out_411051.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_411051", "411051037", "story_v_out_411051.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_12 = math.max(var_162_5, arg_159_1.talkMaxDuration)

			if var_162_4 <= arg_159_1.time_ and arg_159_1.time_ < var_162_4 + var_162_12 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_4) / var_162_12

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_4 + var_162_12 and arg_159_1.time_ < var_162_4 + var_162_12 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play411051038 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 411051038
		arg_163_1.duration_ = 11.5

		local var_163_0 = {
			zh = 11.5,
			ja = 8
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
				arg_163_0:Play411051039(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(arg_163_1.actors_["10014ui_story"]) and arg_163_1.var_.characterEffect10014ui_story == nil then
				arg_163_1.var_.characterEffect10014ui_story = arg_163_1.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_0 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 and not isNil(arg_163_1.actors_["10014ui_story"]) then
				if arg_163_1.var_.characterEffect10014ui_story and not isNil(arg_163_1.actors_["10014ui_story"]) then
					arg_163_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 and not isNil(arg_163_1.actors_["10014ui_story"]) and arg_163_1.var_.characterEffect10014ui_story then
				arg_163_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_166_2 = arg_163_1.actors_["10058ui_story"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_2) and arg_163_1.var_.characterEffect10058ui_story == nil then
				arg_163_1.var_.characterEffect10058ui_story = var_166_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_3 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_3 and not isNil(var_166_2) then
				if arg_163_1.var_.characterEffect10058ui_story and not isNil(var_166_2) then
					arg_163_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_163_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_163_1.time_ - 0) / var_166_3)
				end
			end

			if arg_163_1.time_ >= 0 + var_166_3 and arg_163_1.time_ < 0 + var_166_3 + arg_166_0 and not isNil(var_166_2) and arg_163_1.var_.characterEffect10058ui_story then
				arg_163_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_163_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_166_4 = 0
			local var_166_5 = 1.3

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_4 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_6 = arg_163_1:GetWordFromCfg(411051038)
				local var_166_7 = arg_163_1:FormatText(var_166_6.content)

				arg_163_1.text_.text = var_166_7

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_9 = 52 <= 0 and var_166_5 or var_166_5 * (utf8.len(var_166_7) / 52)

				if (52 <= 0 and var_166_5 or var_166_5 * (utf8.len(var_166_7) / 52)) > 0 and var_166_5 < var_166_9 then
					arg_163_1.talkMaxDuration = var_166_9

					if var_166_9 + var_166_4 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_9 + var_166_4
					end
				end

				arg_163_1.text_.text = var_166_7
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051038", "story_v_out_411051.awb") ~= 0 then
					local var_166_10 = manager.audio:GetVoiceLength("story_v_out_411051", "411051038", "story_v_out_411051.awb") / 1000

					if var_166_10 + var_166_4 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_10 + var_166_4
					end

					if var_166_6.prefab_name ~= "" and arg_163_1.actors_[var_166_6.prefab_name] ~= nil then
						local var_166_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_6.prefab_name].transform, "story_v_out_411051", "411051038", "story_v_out_411051.awb")

						arg_163_1:RecordAudio("411051038", var_166_11)
						arg_163_1:RecordAudio("411051038", var_166_11)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_411051", "411051038", "story_v_out_411051.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_411051", "411051038", "story_v_out_411051.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_12 = math.max(var_166_5, arg_163_1.talkMaxDuration)

			if var_166_4 <= arg_163_1.time_ and arg_163_1.time_ < var_166_4 + var_166_12 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_4) / var_166_12

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_4 + var_166_12 and arg_163_1.time_ < var_166_4 + var_166_12 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play411051039 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 411051039
		arg_167_1.duration_ = 8.23

		local var_167_0 = {
			zh = 5.8,
			ja = 8.233
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
				arg_167_0:Play411051040(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0.75

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_1 = arg_167_1:GetWordFromCfg(411051039)
				local var_170_2 = arg_167_1:FormatText(var_170_1.content)

				arg_167_1.text_.text = var_170_2

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_4 = 30 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_2) / 30)

				if (30 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_2) / 30)) > 0 and var_170_0 < var_170_4 then
					arg_167_1.talkMaxDuration = var_170_4

					if var_170_4 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_4 + 0
					end
				end

				arg_167_1.text_.text = var_170_2
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051039", "story_v_out_411051.awb") ~= 0 then
					local var_170_5 = manager.audio:GetVoiceLength("story_v_out_411051", "411051039", "story_v_out_411051.awb") / 1000

					if var_170_5 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_5 + 0
					end

					if var_170_1.prefab_name ~= "" and arg_167_1.actors_[var_170_1.prefab_name] ~= nil then
						local var_170_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_1.prefab_name].transform, "story_v_out_411051", "411051039", "story_v_out_411051.awb")

						arg_167_1:RecordAudio("411051039", var_170_6)
						arg_167_1:RecordAudio("411051039", var_170_6)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_411051", "411051039", "story_v_out_411051.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_411051", "411051039", "story_v_out_411051.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_7 = math.max(var_170_0, arg_167_1.talkMaxDuration)

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_7 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - 0) / var_170_7

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= 0 + var_170_7 and arg_167_1.time_ < 0 + var_170_7 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play411051040 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 411051040
		arg_171_1.duration_ = 4.6

		local var_171_0 = {
			zh = 2.666,
			ja = 4.6
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
				arg_171_0:Play411051041(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos10058ui_story = arg_171_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_174_0 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 then
				arg_171_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos10058ui_story, Vector3.New(-0.7, -0.98, -6.1), (arg_171_1.time_ - 0) / var_174_0)
				arg_171_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_171_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["10058ui_story"].transform.position).z)
				arg_171_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_171_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_171_1.actors_["10058ui_story"].transform.localEulerAngles = arg_171_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 then
				arg_171_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(-0.7, -0.98, -6.1)
				arg_171_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_171_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["10058ui_story"].transform.position).z)
				arg_171_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_171_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_171_1.actors_["10058ui_story"].transform.localEulerAngles = arg_171_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_174_1 = arg_171_1.actors_["10058ui_story"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_1) and arg_171_1.var_.characterEffect10058ui_story == nil then
				arg_171_1.var_.characterEffect10058ui_story = var_174_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_2 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_2 and not isNil(var_174_1) then
				if arg_171_1.var_.characterEffect10058ui_story and not isNil(var_174_1) then
					arg_171_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= 0 + var_174_2 and arg_171_1.time_ < 0 + var_174_2 + arg_174_0 and not isNil(var_174_1) and arg_171_1.var_.characterEffect10058ui_story then
				arg_171_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_174_4 = arg_171_1.actors_["10014ui_story"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_4) and arg_171_1.var_.characterEffect10014ui_story == nil then
				arg_171_1.var_.characterEffect10014ui_story = var_174_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_5 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_5 and not isNil(var_174_4) then
				if arg_171_1.var_.characterEffect10014ui_story and not isNil(var_174_4) then
					arg_171_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_171_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_171_1.time_ - 0) / var_174_5)
				end
			end

			if arg_171_1.time_ >= 0 + var_174_5 and arg_171_1.time_ < 0 + var_174_5 + arg_174_0 and not isNil(var_174_4) and arg_171_1.var_.characterEffect10014ui_story then
				arg_171_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_171_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_174_6 = 0
			local var_174_7 = 0.225

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_6 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_8 = arg_171_1:GetWordFromCfg(411051040)
				local var_174_9 = arg_171_1:FormatText(var_174_8.content)

				arg_171_1.text_.text = var_174_9

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_11 = 9 <= 0 and var_174_7 or var_174_7 * (utf8.len(var_174_9) / 9)

				if (9 <= 0 and var_174_7 or var_174_7 * (utf8.len(var_174_9) / 9)) > 0 and var_174_7 < var_174_11 then
					arg_171_1.talkMaxDuration = var_174_11

					if var_174_11 + var_174_6 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_11 + var_174_6
					end
				end

				arg_171_1.text_.text = var_174_9
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051040", "story_v_out_411051.awb") ~= 0 then
					local var_174_12 = manager.audio:GetVoiceLength("story_v_out_411051", "411051040", "story_v_out_411051.awb") / 1000

					if var_174_12 + var_174_6 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_12 + var_174_6
					end

					if var_174_8.prefab_name ~= "" and arg_171_1.actors_[var_174_8.prefab_name] ~= nil then
						local var_174_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_8.prefab_name].transform, "story_v_out_411051", "411051040", "story_v_out_411051.awb")

						arg_171_1:RecordAudio("411051040", var_174_13)
						arg_171_1:RecordAudio("411051040", var_174_13)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_411051", "411051040", "story_v_out_411051.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_411051", "411051040", "story_v_out_411051.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_14 = math.max(var_174_7, arg_171_1.talkMaxDuration)

			if var_174_6 <= arg_171_1.time_ and arg_171_1.time_ < var_174_6 + var_174_14 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_6) / var_174_14

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_6 + var_174_14 and arg_171_1.time_ < var_174_6 + var_174_14 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
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

		arg_171_1:InitPlayNodeList()
	end,
	Play411051041 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 411051041
		arg_175_1.duration_ = 6.9

		local var_175_0 = {
			zh = 6.9,
			ja = 6.666
		}
		local var_175_1 = manager.audio:GetLocalizationFlag()

		if var_175_0[var_175_1] ~= nil then
			arg_175_1.duration_ = var_175_0[var_175_1]
		end

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play411051042(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(arg_175_1.actors_["10058ui_story"]) and arg_175_1.var_.characterEffect10058ui_story == nil then
				arg_175_1.var_.characterEffect10058ui_story = arg_175_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_0 = 0.200000002980232

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 and not isNil(arg_175_1.actors_["10058ui_story"]) then
				if arg_175_1.var_.characterEffect10058ui_story and not isNil(arg_175_1.actors_["10058ui_story"]) then
					arg_175_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_175_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_175_1.time_ - 0) / var_178_0)
				end
			end

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 and not isNil(arg_175_1.actors_["10058ui_story"]) and arg_175_1.var_.characterEffect10058ui_story then
				arg_175_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_175_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_178_1 = arg_175_1.actors_["10014ui_story"]

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(var_178_1) and arg_175_1.var_.characterEffect10014ui_story == nil then
				arg_175_1.var_.characterEffect10014ui_story = var_178_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_2 = 0.200000002980232

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_2 and not isNil(var_178_1) then
				if arg_175_1.var_.characterEffect10014ui_story and not isNil(var_178_1) then
					arg_175_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_175_1.time_ >= 0 + var_178_2 and arg_175_1.time_ < 0 + var_178_2 + arg_178_0 and not isNil(var_178_1) and arg_175_1.var_.characterEffect10014ui_story then
				arg_175_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_178_4 = 0
			local var_178_5 = 0.875

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_4 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_6 = arg_175_1:GetWordFromCfg(411051041)
				local var_178_7 = arg_175_1:FormatText(var_178_6.content)

				arg_175_1.text_.text = var_178_7

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_9 = 35 <= 0 and var_178_5 or var_178_5 * (utf8.len(var_178_7) / 35)

				if (35 <= 0 and var_178_5 or var_178_5 * (utf8.len(var_178_7) / 35)) > 0 and var_178_5 < var_178_9 then
					arg_175_1.talkMaxDuration = var_178_9

					if var_178_9 + var_178_4 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_9 + var_178_4
					end
				end

				arg_175_1.text_.text = var_178_7
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051041", "story_v_out_411051.awb") ~= 0 then
					local var_178_10 = manager.audio:GetVoiceLength("story_v_out_411051", "411051041", "story_v_out_411051.awb") / 1000

					if var_178_10 + var_178_4 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_10 + var_178_4
					end

					if var_178_6.prefab_name ~= "" and arg_175_1.actors_[var_178_6.prefab_name] ~= nil then
						local var_178_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_6.prefab_name].transform, "story_v_out_411051", "411051041", "story_v_out_411051.awb")

						arg_175_1:RecordAudio("411051041", var_178_11)
						arg_175_1:RecordAudio("411051041", var_178_11)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_411051", "411051041", "story_v_out_411051.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_411051", "411051041", "story_v_out_411051.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_12 = math.max(var_178_5, arg_175_1.talkMaxDuration)

			if var_178_4 <= arg_175_1.time_ and arg_175_1.time_ < var_178_4 + var_178_12 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_4) / var_178_12

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_4 + var_178_12 and arg_175_1.time_ < var_178_4 + var_178_12 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play411051042 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 411051042
		arg_179_1.duration_ = 13.53

		local var_179_0 = {
			zh = 8.466,
			ja = 13.533
		}
		local var_179_1 = manager.audio:GetLocalizationFlag()

		if var_179_0[var_179_1] ~= nil then
			arg_179_1.duration_ = var_179_0[var_179_1]
		end

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play411051043(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 1

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_1 = arg_179_1:GetWordFromCfg(411051042)
				local var_182_2 = arg_179_1:FormatText(var_182_1.content)

				arg_179_1.text_.text = var_182_2

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_4 = 40 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_2) / 40)

				if (40 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_2) / 40)) > 0 and var_182_0 < var_182_4 then
					arg_179_1.talkMaxDuration = var_182_4

					if var_182_4 + 0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_4 + 0
					end
				end

				arg_179_1.text_.text = var_182_2
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051042", "story_v_out_411051.awb") ~= 0 then
					local var_182_5 = manager.audio:GetVoiceLength("story_v_out_411051", "411051042", "story_v_out_411051.awb") / 1000

					if var_182_5 + 0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_5 + 0
					end

					if var_182_1.prefab_name ~= "" and arg_179_1.actors_[var_182_1.prefab_name] ~= nil then
						local var_182_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_1.prefab_name].transform, "story_v_out_411051", "411051042", "story_v_out_411051.awb")

						arg_179_1:RecordAudio("411051042", var_182_6)
						arg_179_1:RecordAudio("411051042", var_182_6)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_411051", "411051042", "story_v_out_411051.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_411051", "411051042", "story_v_out_411051.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_7 = math.max(var_182_0, arg_179_1.talkMaxDuration)

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_7 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - 0) / var_182_7

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= 0 + var_182_7 and arg_179_1.time_ < 0 + var_182_7 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play411051043 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 411051043
		arg_183_1.duration_ = 3.73

		local var_183_0 = {
			zh = 3.666,
			ja = 3.733
		}
		local var_183_1 = manager.audio:GetLocalizationFlag()

		if var_183_0[var_183_1] ~= nil then
			arg_183_1.duration_ = var_183_0[var_183_1]
		end

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play411051044(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0.425

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_1 = arg_183_1:GetWordFromCfg(411051043)
				local var_186_2 = arg_183_1:FormatText(var_186_1.content)

				arg_183_1.text_.text = var_186_2

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_4 = 17 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_2) / 17)

				if (17 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_2) / 17)) > 0 and var_186_0 < var_186_4 then
					arg_183_1.talkMaxDuration = var_186_4

					if var_186_4 + 0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_4 + 0
					end
				end

				arg_183_1.text_.text = var_186_2
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051043", "story_v_out_411051.awb") ~= 0 then
					local var_186_5 = manager.audio:GetVoiceLength("story_v_out_411051", "411051043", "story_v_out_411051.awb") / 1000

					if var_186_5 + 0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_5 + 0
					end

					if var_186_1.prefab_name ~= "" and arg_183_1.actors_[var_186_1.prefab_name] ~= nil then
						local var_186_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_1.prefab_name].transform, "story_v_out_411051", "411051043", "story_v_out_411051.awb")

						arg_183_1:RecordAudio("411051043", var_186_6)
						arg_183_1:RecordAudio("411051043", var_186_6)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_411051", "411051043", "story_v_out_411051.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_411051", "411051043", "story_v_out_411051.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_7 = math.max(var_186_0, arg_183_1.talkMaxDuration)

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_7 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - 0) / var_186_7

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= 0 + var_186_7 and arg_183_1.time_ < 0 + var_186_7 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play411051044 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 411051044
		arg_187_1.duration_ = 1.33

		local var_187_0 = {
			zh = 1.333,
			ja = 1.2
		}
		local var_187_1 = manager.audio:GetLocalizationFlag()

		if var_187_0[var_187_1] ~= nil then
			arg_187_1.duration_ = var_187_0[var_187_1]
		end

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play411051045(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(arg_187_1.actors_["10014ui_story"]) and arg_187_1.var_.characterEffect10014ui_story == nil then
				arg_187_1.var_.characterEffect10014ui_story = arg_187_1.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_0 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_0 and not isNil(arg_187_1.actors_["10014ui_story"]) then
				if arg_187_1.var_.characterEffect10014ui_story and not isNil(arg_187_1.actors_["10014ui_story"]) then
					arg_187_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_187_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_187_1.time_ - 0) / var_190_0)
				end
			end

			if arg_187_1.time_ >= 0 + var_190_0 and arg_187_1.time_ < 0 + var_190_0 + arg_190_0 and not isNil(arg_187_1.actors_["10014ui_story"]) and arg_187_1.var_.characterEffect10014ui_story then
				arg_187_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_187_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_190_1 = arg_187_1.actors_["10058ui_story"]

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(var_190_1) and arg_187_1.var_.characterEffect10058ui_story == nil then
				arg_187_1.var_.characterEffect10058ui_story = var_190_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_2 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_2 and not isNil(var_190_1) then
				if arg_187_1.var_.characterEffect10058ui_story and not isNil(var_190_1) then
					arg_187_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= 0 + var_190_2 and arg_187_1.time_ < 0 + var_190_2 + arg_190_0 and not isNil(var_190_1) and arg_187_1.var_.characterEffect10058ui_story then
				arg_187_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_190_4 = 0
			local var_190_5 = 0.125

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_4 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_6 = arg_187_1:GetWordFromCfg(411051044)
				local var_190_7 = arg_187_1:FormatText(var_190_6.content)

				arg_187_1.text_.text = var_190_7

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_9 = 5 <= 0 and var_190_5 or var_190_5 * (utf8.len(var_190_7) / 5)

				if (5 <= 0 and var_190_5 or var_190_5 * (utf8.len(var_190_7) / 5)) > 0 and var_190_5 < var_190_9 then
					arg_187_1.talkMaxDuration = var_190_9

					if var_190_9 + var_190_4 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_9 + var_190_4
					end
				end

				arg_187_1.text_.text = var_190_7
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051044", "story_v_out_411051.awb") ~= 0 then
					local var_190_10 = manager.audio:GetVoiceLength("story_v_out_411051", "411051044", "story_v_out_411051.awb") / 1000

					if var_190_10 + var_190_4 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_10 + var_190_4
					end

					if var_190_6.prefab_name ~= "" and arg_187_1.actors_[var_190_6.prefab_name] ~= nil then
						local var_190_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_6.prefab_name].transform, "story_v_out_411051", "411051044", "story_v_out_411051.awb")

						arg_187_1:RecordAudio("411051044", var_190_11)
						arg_187_1:RecordAudio("411051044", var_190_11)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_411051", "411051044", "story_v_out_411051.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_411051", "411051044", "story_v_out_411051.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_12 = math.max(var_190_5, arg_187_1.talkMaxDuration)

			if var_190_4 <= arg_187_1.time_ and arg_187_1.time_ < var_190_4 + var_190_12 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_4) / var_190_12

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_4 + var_190_12 and arg_187_1.time_ < var_190_4 + var_190_12 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play411051045 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 411051045
		arg_191_1.duration_ = 9.7

		local var_191_0 = {
			zh = 7,
			ja = 9.7
		}
		local var_191_1 = manager.audio:GetLocalizationFlag()

		if var_191_0[var_191_1] ~= nil then
			arg_191_1.duration_ = var_191_0[var_191_1]
		end

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play411051046(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.var_.moveOldPos10014ui_story = arg_191_1.actors_["10014ui_story"].transform.localPosition
			end

			local var_194_0 = 0.001

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_0 then
				arg_191_1.actors_["10014ui_story"].transform.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos10014ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_191_1.time_ - 0) / var_194_0)
				arg_191_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["10014ui_story"].transform.position).z)
				arg_191_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["10014ui_story"].transform.localEulerAngles = arg_191_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			if arg_191_1.time_ >= 0 + var_194_0 and arg_191_1.time_ < 0 + var_194_0 + arg_194_0 then
				arg_191_1.actors_["10014ui_story"].transform.localPosition = Vector3.New(0.7, -1.06, -6.2)
				arg_191_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["10014ui_story"].transform.position).z)
				arg_191_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["10014ui_story"].transform.localEulerAngles = arg_191_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			local var_194_1 = arg_191_1.actors_["10014ui_story"]

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(var_194_1) and arg_191_1.var_.characterEffect10014ui_story == nil then
				arg_191_1.var_.characterEffect10014ui_story = var_194_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_2 = 0.200000002980232

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_2 and not isNil(var_194_1) then
				if arg_191_1.var_.characterEffect10014ui_story and not isNil(var_194_1) then
					arg_191_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= 0 + var_194_2 and arg_191_1.time_ < 0 + var_194_2 + arg_194_0 and not isNil(var_194_1) and arg_191_1.var_.characterEffect10014ui_story then
				arg_191_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action3_2")
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_194_4 = arg_191_1.actors_["10058ui_story"]

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(var_194_4) and arg_191_1.var_.characterEffect10058ui_story == nil then
				arg_191_1.var_.characterEffect10058ui_story = var_194_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_5 = 0.200000002980232

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_5 and not isNil(var_194_4) then
				if arg_191_1.var_.characterEffect10058ui_story and not isNil(var_194_4) then
					arg_191_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_191_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_191_1.time_ - 0) / var_194_5)
				end
			end

			if arg_191_1.time_ >= 0 + var_194_5 and arg_191_1.time_ < 0 + var_194_5 + arg_194_0 and not isNil(var_194_4) and arg_191_1.var_.characterEffect10058ui_story then
				arg_191_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_191_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_194_6 = 0
			local var_194_7 = 0.925

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_6 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_8 = arg_191_1:GetWordFromCfg(411051045)
				local var_194_9 = arg_191_1:FormatText(var_194_8.content)

				arg_191_1.text_.text = var_194_9

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_11 = 37 <= 0 and var_194_7 or var_194_7 * (utf8.len(var_194_9) / 37)

				if (37 <= 0 and var_194_7 or var_194_7 * (utf8.len(var_194_9) / 37)) > 0 and var_194_7 < var_194_11 then
					arg_191_1.talkMaxDuration = var_194_11

					if var_194_11 + var_194_6 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_11 + var_194_6
					end
				end

				arg_191_1.text_.text = var_194_9
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051045", "story_v_out_411051.awb") ~= 0 then
					local var_194_12 = manager.audio:GetVoiceLength("story_v_out_411051", "411051045", "story_v_out_411051.awb") / 1000

					if var_194_12 + var_194_6 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_12 + var_194_6
					end

					if var_194_8.prefab_name ~= "" and arg_191_1.actors_[var_194_8.prefab_name] ~= nil then
						local var_194_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_8.prefab_name].transform, "story_v_out_411051", "411051045", "story_v_out_411051.awb")

						arg_191_1:RecordAudio("411051045", var_194_13)
						arg_191_1:RecordAudio("411051045", var_194_13)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_411051", "411051045", "story_v_out_411051.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_411051", "411051045", "story_v_out_411051.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_14 = math.max(var_194_7, arg_191_1.talkMaxDuration)

			if var_194_6 <= arg_191_1.time_ and arg_191_1.time_ < var_194_6 + var_194_14 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_6) / var_194_14

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_6 + var_194_14 and arg_191_1.time_ < var_194_6 + var_194_14 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
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
	Play411051046 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 411051046
		arg_195_1.duration_ = 3.5

		local var_195_0 = {
			zh = 2.5,
			ja = 3.5
		}
		local var_195_1 = manager.audio:GetLocalizationFlag()

		if var_195_0[var_195_1] ~= nil then
			arg_195_1.duration_ = var_195_0[var_195_1]
		end

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play411051047(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.var_.moveOldPos10058ui_story = arg_195_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_198_0 = 0.001

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_0 then
				arg_195_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos10058ui_story, Vector3.New(-0.7, -0.98, -6.1), (arg_195_1.time_ - 0) / var_198_0)
				arg_195_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_195_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["10058ui_story"].transform.position).z)
				arg_195_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_195_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_195_1.actors_["10058ui_story"].transform.localEulerAngles = arg_195_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_195_1.time_ >= 0 + var_198_0 and arg_195_1.time_ < 0 + var_198_0 + arg_198_0 then
				arg_195_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(-0.7, -0.98, -6.1)
				arg_195_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_195_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["10058ui_story"].transform.position).z)
				arg_195_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_195_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_195_1.actors_["10058ui_story"].transform.localEulerAngles = arg_195_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_198_1 = arg_195_1.actors_["10058ui_story"]

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(var_198_1) and arg_195_1.var_.characterEffect10058ui_story == nil then
				arg_195_1.var_.characterEffect10058ui_story = var_198_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_2 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_2 and not isNil(var_198_1) then
				if arg_195_1.var_.characterEffect10058ui_story and not isNil(var_198_1) then
					arg_195_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_195_1.time_ >= 0 + var_198_2 and arg_195_1.time_ < 0 + var_198_2 + arg_198_0 and not isNil(var_198_1) and arg_195_1.var_.characterEffect10058ui_story then
				arg_195_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095actionlink/1095action423")
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_198_4 = arg_195_1.actors_["10014ui_story"]

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(var_198_4) and arg_195_1.var_.characterEffect10014ui_story == nil then
				arg_195_1.var_.characterEffect10014ui_story = var_198_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_5 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_5 and not isNil(var_198_4) then
				if arg_195_1.var_.characterEffect10014ui_story and not isNil(var_198_4) then
					arg_195_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_195_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_195_1.time_ - 0) / var_198_5)
				end
			end

			if arg_195_1.time_ >= 0 + var_198_5 and arg_195_1.time_ < 0 + var_198_5 + arg_198_0 and not isNil(var_198_4) and arg_195_1.var_.characterEffect10014ui_story then
				arg_195_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_195_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_198_6 = 0
			local var_198_7 = 0.325

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_6 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_8 = arg_195_1:GetWordFromCfg(411051046)
				local var_198_9 = arg_195_1:FormatText(var_198_8.content)

				arg_195_1.text_.text = var_198_9

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_11 = 13 <= 0 and var_198_7 or var_198_7 * (utf8.len(var_198_9) / 13)

				if (13 <= 0 and var_198_7 or var_198_7 * (utf8.len(var_198_9) / 13)) > 0 and var_198_7 < var_198_11 then
					arg_195_1.talkMaxDuration = var_198_11

					if var_198_11 + var_198_6 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_11 + var_198_6
					end
				end

				arg_195_1.text_.text = var_198_9
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051046", "story_v_out_411051.awb") ~= 0 then
					local var_198_12 = manager.audio:GetVoiceLength("story_v_out_411051", "411051046", "story_v_out_411051.awb") / 1000

					if var_198_12 + var_198_6 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_12 + var_198_6
					end

					if var_198_8.prefab_name ~= "" and arg_195_1.actors_[var_198_8.prefab_name] ~= nil then
						local var_198_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_8.prefab_name].transform, "story_v_out_411051", "411051046", "story_v_out_411051.awb")

						arg_195_1:RecordAudio("411051046", var_198_13)
						arg_195_1:RecordAudio("411051046", var_198_13)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_411051", "411051046", "story_v_out_411051.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_411051", "411051046", "story_v_out_411051.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_14 = math.max(var_198_7, arg_195_1.talkMaxDuration)

			if var_198_6 <= arg_195_1.time_ and arg_195_1.time_ < var_198_6 + var_198_14 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_6) / var_198_14

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_6 + var_198_14 and arg_195_1.time_ < var_198_6 + var_198_14 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
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

		arg_195_1:InitPlayNodeList()
	end,
	Play411051047 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 411051047
		arg_199_1.duration_ = 4

		local var_199_0 = {
			zh = 3.9,
			ja = 4
		}
		local var_199_1 = manager.audio:GetLocalizationFlag()

		if var_199_0[var_199_1] ~= nil then
			arg_199_1.duration_ = var_199_0[var_199_1]
		end

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play411051048(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(arg_199_1.actors_["10058ui_story"]) and arg_199_1.var_.characterEffect10058ui_story == nil then
				arg_199_1.var_.characterEffect10058ui_story = arg_199_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_0 = 0.200000002980232

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 and not isNil(arg_199_1.actors_["10058ui_story"]) then
				if arg_199_1.var_.characterEffect10058ui_story and not isNil(arg_199_1.actors_["10058ui_story"]) then
					arg_199_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_199_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_199_1.time_ - 0) / var_202_0)
				end
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 and not isNil(arg_199_1.actors_["10058ui_story"]) and arg_199_1.var_.characterEffect10058ui_story then
				arg_199_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_199_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_202_1 = arg_199_1.actors_["10014ui_story"]

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(var_202_1) and arg_199_1.var_.characterEffect10014ui_story == nil then
				arg_199_1.var_.characterEffect10014ui_story = var_202_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_2 = 0.200000002980232

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_2 and not isNil(var_202_1) then
				if arg_199_1.var_.characterEffect10014ui_story and not isNil(var_202_1) then
					arg_199_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_199_1.time_ >= 0 + var_202_2 and arg_199_1.time_ < 0 + var_202_2 + arg_202_0 and not isNil(var_202_1) and arg_199_1.var_.characterEffect10014ui_story then
				arg_199_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_202_4 = 0
			local var_202_5 = 0.35

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_4 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_6 = arg_199_1:GetWordFromCfg(411051047)
				local var_202_7 = arg_199_1:FormatText(var_202_6.content)

				arg_199_1.text_.text = var_202_7

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_9 = 14 <= 0 and var_202_5 or var_202_5 * (utf8.len(var_202_7) / 14)

				if (14 <= 0 and var_202_5 or var_202_5 * (utf8.len(var_202_7) / 14)) > 0 and var_202_5 < var_202_9 then
					arg_199_1.talkMaxDuration = var_202_9

					if var_202_9 + var_202_4 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_9 + var_202_4
					end
				end

				arg_199_1.text_.text = var_202_7
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051047", "story_v_out_411051.awb") ~= 0 then
					local var_202_10 = manager.audio:GetVoiceLength("story_v_out_411051", "411051047", "story_v_out_411051.awb") / 1000

					if var_202_10 + var_202_4 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_10 + var_202_4
					end

					if var_202_6.prefab_name ~= "" and arg_199_1.actors_[var_202_6.prefab_name] ~= nil then
						local var_202_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_6.prefab_name].transform, "story_v_out_411051", "411051047", "story_v_out_411051.awb")

						arg_199_1:RecordAudio("411051047", var_202_11)
						arg_199_1:RecordAudio("411051047", var_202_11)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_411051", "411051047", "story_v_out_411051.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_411051", "411051047", "story_v_out_411051.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_12 = math.max(var_202_5, arg_199_1.talkMaxDuration)

			if var_202_4 <= arg_199_1.time_ and arg_199_1.time_ < var_202_4 + var_202_12 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_4) / var_202_12

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_4 + var_202_12 and arg_199_1.time_ < var_202_4 + var_202_12 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play411051048 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 411051048
		arg_203_1.duration_ = 8.8

		local var_203_0 = {
			zh = 6.9,
			ja = 8.8
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
				arg_203_0:Play411051049(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(arg_203_1.actors_["10058ui_story"]) and arg_203_1.var_.characterEffect10058ui_story == nil then
				arg_203_1.var_.characterEffect10058ui_story = arg_203_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_0 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 and not isNil(arg_203_1.actors_["10058ui_story"]) then
				if arg_203_1.var_.characterEffect10058ui_story and not isNil(arg_203_1.actors_["10058ui_story"]) then
					arg_203_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 and not isNil(arg_203_1.actors_["10058ui_story"]) and arg_203_1.var_.characterEffect10058ui_story then
				arg_203_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_206_2 = arg_203_1.actors_["10014ui_story"]

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(var_206_2) and arg_203_1.var_.characterEffect10014ui_story == nil then
				arg_203_1.var_.characterEffect10014ui_story = var_206_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_3 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_3 and not isNil(var_206_2) then
				if arg_203_1.var_.characterEffect10014ui_story and not isNil(var_206_2) then
					arg_203_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_203_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_203_1.time_ - 0) / var_206_3)
				end
			end

			if arg_203_1.time_ >= 0 + var_206_3 and arg_203_1.time_ < 0 + var_206_3 + arg_206_0 and not isNil(var_206_2) and arg_203_1.var_.characterEffect10014ui_story then
				arg_203_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_203_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_206_4 = 0
			local var_206_5 = 0.8

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_4 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_6 = arg_203_1:GetWordFromCfg(411051048)
				local var_206_7 = arg_203_1:FormatText(var_206_6.content)

				arg_203_1.text_.text = var_206_7

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_9 = 32 <= 0 and var_206_5 or var_206_5 * (utf8.len(var_206_7) / 32)

				if (32 <= 0 and var_206_5 or var_206_5 * (utf8.len(var_206_7) / 32)) > 0 and var_206_5 < var_206_9 then
					arg_203_1.talkMaxDuration = var_206_9

					if var_206_9 + var_206_4 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_9 + var_206_4
					end
				end

				arg_203_1.text_.text = var_206_7
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051048", "story_v_out_411051.awb") ~= 0 then
					local var_206_10 = manager.audio:GetVoiceLength("story_v_out_411051", "411051048", "story_v_out_411051.awb") / 1000

					if var_206_10 + var_206_4 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_10 + var_206_4
					end

					if var_206_6.prefab_name ~= "" and arg_203_1.actors_[var_206_6.prefab_name] ~= nil then
						local var_206_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_6.prefab_name].transform, "story_v_out_411051", "411051048", "story_v_out_411051.awb")

						arg_203_1:RecordAudio("411051048", var_206_11)
						arg_203_1:RecordAudio("411051048", var_206_11)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_411051", "411051048", "story_v_out_411051.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_411051", "411051048", "story_v_out_411051.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_12 = math.max(var_206_5, arg_203_1.talkMaxDuration)

			if var_206_4 <= arg_203_1.time_ and arg_203_1.time_ < var_206_4 + var_206_12 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_4) / var_206_12

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_4 + var_206_12 and arg_203_1.time_ < var_206_4 + var_206_12 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play411051049 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 411051049
		arg_207_1.duration_ = 14.57

		local var_207_0 = {
			zh = 8.2,
			ja = 14.566
		}
		local var_207_1 = manager.audio:GetLocalizationFlag()

		if var_207_0[var_207_1] ~= nil then
			arg_207_1.duration_ = var_207_0[var_207_1]
		end

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play411051050(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(arg_207_1.actors_["10058ui_story"]) and arg_207_1.var_.characterEffect10058ui_story == nil then
				arg_207_1.var_.characterEffect10058ui_story = arg_207_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_0 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_0 and not isNil(arg_207_1.actors_["10058ui_story"]) then
				if arg_207_1.var_.characterEffect10058ui_story and not isNil(arg_207_1.actors_["10058ui_story"]) then
					arg_207_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_207_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_207_1.time_ - 0) / var_210_0)
				end
			end

			if arg_207_1.time_ >= 0 + var_210_0 and arg_207_1.time_ < 0 + var_210_0 + arg_210_0 and not isNil(arg_207_1.actors_["10058ui_story"]) and arg_207_1.var_.characterEffect10058ui_story then
				arg_207_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_207_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_210_1 = arg_207_1.actors_["10014ui_story"]

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(var_210_1) and arg_207_1.var_.characterEffect10014ui_story == nil then
				arg_207_1.var_.characterEffect10014ui_story = var_210_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_2 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_2 and not isNil(var_210_1) then
				if arg_207_1.var_.characterEffect10014ui_story and not isNil(var_210_1) then
					arg_207_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_207_1.time_ >= 0 + var_210_2 and arg_207_1.time_ < 0 + var_210_2 + arg_210_0 and not isNil(var_210_1) and arg_207_1.var_.characterEffect10014ui_story then
				arg_207_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_210_4 = 0
			local var_210_5 = 1.05

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_4 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_6 = arg_207_1:GetWordFromCfg(411051049)
				local var_210_7 = arg_207_1:FormatText(var_210_6.content)

				arg_207_1.text_.text = var_210_7

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_9 = 42 <= 0 and var_210_5 or var_210_5 * (utf8.len(var_210_7) / 42)

				if (42 <= 0 and var_210_5 or var_210_5 * (utf8.len(var_210_7) / 42)) > 0 and var_210_5 < var_210_9 then
					arg_207_1.talkMaxDuration = var_210_9

					if var_210_9 + var_210_4 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_9 + var_210_4
					end
				end

				arg_207_1.text_.text = var_210_7
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051049", "story_v_out_411051.awb") ~= 0 then
					local var_210_10 = manager.audio:GetVoiceLength("story_v_out_411051", "411051049", "story_v_out_411051.awb") / 1000

					if var_210_10 + var_210_4 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_10 + var_210_4
					end

					if var_210_6.prefab_name ~= "" and arg_207_1.actors_[var_210_6.prefab_name] ~= nil then
						local var_210_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_6.prefab_name].transform, "story_v_out_411051", "411051049", "story_v_out_411051.awb")

						arg_207_1:RecordAudio("411051049", var_210_11)
						arg_207_1:RecordAudio("411051049", var_210_11)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_411051", "411051049", "story_v_out_411051.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_411051", "411051049", "story_v_out_411051.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_12 = math.max(var_210_5, arg_207_1.talkMaxDuration)

			if var_210_4 <= arg_207_1.time_ and arg_207_1.time_ < var_210_4 + var_210_12 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_4) / var_210_12

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_4 + var_210_12 and arg_207_1.time_ < var_210_4 + var_210_12 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play411051050 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 411051050
		arg_211_1.duration_ = 11.13

		local var_211_0 = {
			zh = 9.933,
			ja = 11.133
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
				arg_211_0:Play411051051(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 1.175

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_1 = arg_211_1:GetWordFromCfg(411051050)
				local var_214_2 = arg_211_1:FormatText(var_214_1.content)

				arg_211_1.text_.text = var_214_2

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_4 = 47 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_2) / 47)

				if (47 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_2) / 47)) > 0 and var_214_0 < var_214_4 then
					arg_211_1.talkMaxDuration = var_214_4

					if var_214_4 + 0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_4 + 0
					end
				end

				arg_211_1.text_.text = var_214_2
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051050", "story_v_out_411051.awb") ~= 0 then
					local var_214_5 = manager.audio:GetVoiceLength("story_v_out_411051", "411051050", "story_v_out_411051.awb") / 1000

					if var_214_5 + 0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_5 + 0
					end

					if var_214_1.prefab_name ~= "" and arg_211_1.actors_[var_214_1.prefab_name] ~= nil then
						local var_214_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_1.prefab_name].transform, "story_v_out_411051", "411051050", "story_v_out_411051.awb")

						arg_211_1:RecordAudio("411051050", var_214_6)
						arg_211_1:RecordAudio("411051050", var_214_6)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_411051", "411051050", "story_v_out_411051.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_411051", "411051050", "story_v_out_411051.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_7 = math.max(var_214_0, arg_211_1.talkMaxDuration)

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_7 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - 0) / var_214_7

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= 0 + var_214_7 and arg_211_1.time_ < 0 + var_214_7 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play411051051 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 411051051
		arg_215_1.duration_ = 1.53

		local var_215_0 = {
			zh = 0.999999999999,
			ja = 1.533
		}
		local var_215_1 = manager.audio:GetLocalizationFlag()

		if var_215_0[var_215_1] ~= nil then
			arg_215_1.duration_ = var_215_0[var_215_1]
		end

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play411051052(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.var_.moveOldPos10058ui_story = arg_215_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_218_0 = 0.001

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_0 then
				arg_215_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos10058ui_story, Vector3.New(-0.7, -0.98, -6.1), (arg_215_1.time_ - 0) / var_218_0)
				arg_215_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_215_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["10058ui_story"].transform.position).z)
				arg_215_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_215_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_215_1.actors_["10058ui_story"].transform.localEulerAngles = arg_215_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_215_1.time_ >= 0 + var_218_0 and arg_215_1.time_ < 0 + var_218_0 + arg_218_0 then
				arg_215_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(-0.7, -0.98, -6.1)
				arg_215_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_215_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["10058ui_story"].transform.position).z)
				arg_215_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_215_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_215_1.actors_["10058ui_story"].transform.localEulerAngles = arg_215_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_218_1 = arg_215_1.actors_["10058ui_story"]

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(var_218_1) and arg_215_1.var_.characterEffect10058ui_story == nil then
				arg_215_1.var_.characterEffect10058ui_story = var_218_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_2 = 0.200000002980232

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_2 and not isNil(var_218_1) then
				if arg_215_1.var_.characterEffect10058ui_story and not isNil(var_218_1) then
					arg_215_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_215_1.time_ >= 0 + var_218_2 and arg_215_1.time_ < 0 + var_218_2 + arg_218_0 and not isNil(var_218_1) and arg_215_1.var_.characterEffect10058ui_story then
				arg_215_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_218_4 = arg_215_1.actors_["10014ui_story"]

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(var_218_4) and arg_215_1.var_.characterEffect10014ui_story == nil then
				arg_215_1.var_.characterEffect10014ui_story = var_218_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_5 = 0.200000002980232

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_5 and not isNil(var_218_4) then
				if arg_215_1.var_.characterEffect10014ui_story and not isNil(var_218_4) then
					arg_215_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_215_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_215_1.time_ - 0) / var_218_5)
				end
			end

			if arg_215_1.time_ >= 0 + var_218_5 and arg_215_1.time_ < 0 + var_218_5 + arg_218_0 and not isNil(var_218_4) and arg_215_1.var_.characterEffect10014ui_story then
				arg_215_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_215_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_218_6 = 0
			local var_218_7 = 0.1

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_6 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_8 = arg_215_1:GetWordFromCfg(411051051)
				local var_218_9 = arg_215_1:FormatText(var_218_8.content)

				arg_215_1.text_.text = var_218_9

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_11 = 4 <= 0 and var_218_7 or var_218_7 * (utf8.len(var_218_9) / 4)

				if (4 <= 0 and var_218_7 or var_218_7 * (utf8.len(var_218_9) / 4)) > 0 and var_218_7 < var_218_11 then
					arg_215_1.talkMaxDuration = var_218_11

					if var_218_11 + var_218_6 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_11 + var_218_6
					end
				end

				arg_215_1.text_.text = var_218_9
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051051", "story_v_out_411051.awb") ~= 0 then
					local var_218_12 = manager.audio:GetVoiceLength("story_v_out_411051", "411051051", "story_v_out_411051.awb") / 1000

					if var_218_12 + var_218_6 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_12 + var_218_6
					end

					if var_218_8.prefab_name ~= "" and arg_215_1.actors_[var_218_8.prefab_name] ~= nil then
						local var_218_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_8.prefab_name].transform, "story_v_out_411051", "411051051", "story_v_out_411051.awb")

						arg_215_1:RecordAudio("411051051", var_218_13)
						arg_215_1:RecordAudio("411051051", var_218_13)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_411051", "411051051", "story_v_out_411051.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_411051", "411051051", "story_v_out_411051.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_14 = math.max(var_218_7, arg_215_1.talkMaxDuration)

			if var_218_6 <= arg_215_1.time_ and arg_215_1.time_ < var_218_6 + var_218_14 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_6) / var_218_14

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_6 + var_218_14 and arg_215_1.time_ < var_218_6 + var_218_14 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
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

		arg_215_1:InitPlayNodeList()
	end,
	Play411051052 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 411051052
		arg_219_1.duration_ = 12.13

		local var_219_0 = {
			zh = 9.9,
			ja = 12.133
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
				arg_219_0:Play411051053(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.var_.moveOldPos10014ui_story = arg_219_1.actors_["10014ui_story"].transform.localPosition
			end

			local var_222_0 = 0.001

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_0 then
				arg_219_1.actors_["10014ui_story"].transform.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos10014ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_219_1.time_ - 0) / var_222_0)
				arg_219_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_219_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["10014ui_story"].transform.position).z)
				arg_219_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_219_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_219_1.actors_["10014ui_story"].transform.localEulerAngles = arg_219_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			if arg_219_1.time_ >= 0 + var_222_0 and arg_219_1.time_ < 0 + var_222_0 + arg_222_0 then
				arg_219_1.actors_["10014ui_story"].transform.localPosition = Vector3.New(0.7, -1.06, -6.2)
				arg_219_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_219_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["10014ui_story"].transform.position).z)
				arg_219_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_219_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_219_1.actors_["10014ui_story"].transform.localEulerAngles = arg_219_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			local var_222_1 = arg_219_1.actors_["10014ui_story"]

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(var_222_1) and arg_219_1.var_.characterEffect10014ui_story == nil then
				arg_219_1.var_.characterEffect10014ui_story = var_222_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_2 = 0.200000002980232

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_2 and not isNil(var_222_1) then
				if arg_219_1.var_.characterEffect10014ui_story and not isNil(var_222_1) then
					arg_219_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_219_1.time_ >= 0 + var_222_2 and arg_219_1.time_ < 0 + var_222_2 + arg_222_0 and not isNil(var_222_1) and arg_219_1.var_.characterEffect10014ui_story then
				arg_219_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action1_1")
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_222_4 = arg_219_1.actors_["10058ui_story"]

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(var_222_4) and arg_219_1.var_.characterEffect10058ui_story == nil then
				arg_219_1.var_.characterEffect10058ui_story = var_222_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_5 = 0.200000002980232

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_5 and not isNil(var_222_4) then
				if arg_219_1.var_.characterEffect10058ui_story and not isNil(var_222_4) then
					arg_219_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_219_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_219_1.time_ - 0) / var_222_5)
				end
			end

			if arg_219_1.time_ >= 0 + var_222_5 and arg_219_1.time_ < 0 + var_222_5 + arg_222_0 and not isNil(var_222_4) and arg_219_1.var_.characterEffect10058ui_story then
				arg_219_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_219_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_222_6 = 0
			local var_222_7 = 1.075

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_6 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_8 = arg_219_1:GetWordFromCfg(411051052)
				local var_222_9 = arg_219_1:FormatText(var_222_8.content)

				arg_219_1.text_.text = var_222_9

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_11 = 43 <= 0 and var_222_7 or var_222_7 * (utf8.len(var_222_9) / 43)

				if (43 <= 0 and var_222_7 or var_222_7 * (utf8.len(var_222_9) / 43)) > 0 and var_222_7 < var_222_11 then
					arg_219_1.talkMaxDuration = var_222_11

					if var_222_11 + var_222_6 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_11 + var_222_6
					end
				end

				arg_219_1.text_.text = var_222_9
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051052", "story_v_out_411051.awb") ~= 0 then
					local var_222_12 = manager.audio:GetVoiceLength("story_v_out_411051", "411051052", "story_v_out_411051.awb") / 1000

					if var_222_12 + var_222_6 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_12 + var_222_6
					end

					if var_222_8.prefab_name ~= "" and arg_219_1.actors_[var_222_8.prefab_name] ~= nil then
						local var_222_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_8.prefab_name].transform, "story_v_out_411051", "411051052", "story_v_out_411051.awb")

						arg_219_1:RecordAudio("411051052", var_222_13)
						arg_219_1:RecordAudio("411051052", var_222_13)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_411051", "411051052", "story_v_out_411051.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_411051", "411051052", "story_v_out_411051.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_14 = math.max(var_222_7, arg_219_1.talkMaxDuration)

			if var_222_6 <= arg_219_1.time_ and arg_219_1.time_ < var_222_6 + var_222_14 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_6) / var_222_14

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_6 + var_222_14 and arg_219_1.time_ < var_222_6 + var_222_14 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_219_1:InitPlayNodeList()
	end,
	Play411051053 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 411051053
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play411051054(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(arg_223_1.actors_["10014ui_story"]) and arg_223_1.var_.characterEffect10014ui_story == nil then
				arg_223_1.var_.characterEffect10014ui_story = arg_223_1.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_0 = 0.200000002980232

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_0 and not isNil(arg_223_1.actors_["10014ui_story"]) then
				if arg_223_1.var_.characterEffect10014ui_story and not isNil(arg_223_1.actors_["10014ui_story"]) then
					arg_223_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_223_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_223_1.time_ - 0) / var_226_0)
				end
			end

			if arg_223_1.time_ >= 0 + var_226_0 and arg_223_1.time_ < 0 + var_226_0 + arg_226_0 and not isNil(arg_223_1.actors_["10014ui_story"]) and arg_223_1.var_.characterEffect10014ui_story then
				arg_223_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_223_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_226_1 = 0
			local var_226_2 = 0.9

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, false)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_3 = arg_223_1:FormatText(arg_223_1:GetWordFromCfg(411051053).content)

				arg_223_1.text_.text = var_226_3

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_5 = 36 <= 0 and var_226_2 or var_226_2 * (utf8.len(var_226_3) / 36)

				if (36 <= 0 and var_226_2 or var_226_2 * (utf8.len(var_226_3) / 36)) > 0 and var_226_2 < var_226_5 then
					arg_223_1.talkMaxDuration = var_226_5

					if var_226_5 + var_226_1 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_5 + var_226_1
					end
				end

				arg_223_1.text_.text = var_226_3
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_6 = math.max(var_226_2, arg_223_1.talkMaxDuration)

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_6 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_1) / var_226_6

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_1 + var_226_6 and arg_223_1.time_ < var_226_1 + var_226_6 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play411051054 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 411051054
		arg_227_1.duration_ = 2

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play411051055(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.var_.moveOldPos10058ui_story = arg_227_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_230_0 = 0.001

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_0 then
				arg_227_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos10058ui_story, Vector3.New(-0.7, -0.98, -6.1), (arg_227_1.time_ - 0) / var_230_0)
				arg_227_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_227_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["10058ui_story"].transform.position).z)
				arg_227_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_227_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_227_1.actors_["10058ui_story"].transform.localEulerAngles = arg_227_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_227_1.time_ >= 0 + var_230_0 and arg_227_1.time_ < 0 + var_230_0 + arg_230_0 then
				arg_227_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(-0.7, -0.98, -6.1)
				arg_227_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_227_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["10058ui_story"].transform.position).z)
				arg_227_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_227_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_227_1.actors_["10058ui_story"].transform.localEulerAngles = arg_227_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_230_1 = arg_227_1.actors_["10058ui_story"]

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(var_230_1) and arg_227_1.var_.characterEffect10058ui_story == nil then
				arg_227_1.var_.characterEffect10058ui_story = var_230_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_2 = 0.200000002980232

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_2 and not isNil(var_230_1) then
				if arg_227_1.var_.characterEffect10058ui_story and not isNil(var_230_1) then
					arg_227_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_227_1.time_ >= 0 + var_230_2 and arg_227_1.time_ < 0 + var_230_2 + arg_230_0 and not isNil(var_230_1) and arg_227_1.var_.characterEffect10058ui_story then
				arg_227_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_2")
			end

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_230_4 = 0
			local var_230_5 = 0.2

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_4 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_6 = arg_227_1:GetWordFromCfg(411051054)
				local var_230_7 = arg_227_1:FormatText(var_230_6.content)

				arg_227_1.text_.text = var_230_7

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_9 = 8 <= 0 and var_230_5 or var_230_5 * (utf8.len(var_230_7) / 8)

				if (8 <= 0 and var_230_5 or var_230_5 * (utf8.len(var_230_7) / 8)) > 0 and var_230_5 < var_230_9 then
					arg_227_1.talkMaxDuration = var_230_9

					if var_230_9 + var_230_4 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_9 + var_230_4
					end
				end

				arg_227_1.text_.text = var_230_7
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051054", "story_v_out_411051.awb") ~= 0 then
					local var_230_10 = manager.audio:GetVoiceLength("story_v_out_411051", "411051054", "story_v_out_411051.awb") / 1000

					if var_230_10 + var_230_4 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_10 + var_230_4
					end

					if var_230_6.prefab_name ~= "" and arg_227_1.actors_[var_230_6.prefab_name] ~= nil then
						local var_230_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_6.prefab_name].transform, "story_v_out_411051", "411051054", "story_v_out_411051.awb")

						arg_227_1:RecordAudio("411051054", var_230_11)
						arg_227_1:RecordAudio("411051054", var_230_11)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_411051", "411051054", "story_v_out_411051.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_411051", "411051054", "story_v_out_411051.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_12 = math.max(var_230_5, arg_227_1.talkMaxDuration)

			if var_230_4 <= arg_227_1.time_ and arg_227_1.time_ < var_230_4 + var_230_12 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_4) / var_230_12

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_4 + var_230_12 and arg_227_1.time_ < var_230_4 + var_230_12 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {
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

		arg_227_1:InitPlayNodeList()
	end,
	Play411051055 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 411051055
		arg_231_1.duration_ = 6.33

		local var_231_0 = {
			zh = 2.7,
			ja = 6.333
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
				arg_231_0:Play411051056(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(arg_231_1.actors_["10058ui_story"]) and arg_231_1.var_.characterEffect10058ui_story == nil then
				arg_231_1.var_.characterEffect10058ui_story = arg_231_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_0 = 0.200000002980232

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_0 and not isNil(arg_231_1.actors_["10058ui_story"]) then
				if arg_231_1.var_.characterEffect10058ui_story and not isNil(arg_231_1.actors_["10058ui_story"]) then
					arg_231_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_231_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_231_1.time_ - 0) / var_234_0)
				end
			end

			if arg_231_1.time_ >= 0 + var_234_0 and arg_231_1.time_ < 0 + var_234_0 + arg_234_0 and not isNil(arg_231_1.actors_["10058ui_story"]) and arg_231_1.var_.characterEffect10058ui_story then
				arg_231_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_231_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_234_1 = arg_231_1.actors_["10014ui_story"]

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(var_234_1) and arg_231_1.var_.characterEffect10014ui_story == nil then
				arg_231_1.var_.characterEffect10014ui_story = var_234_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_2 = 0.200000002980232

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_2 and not isNil(var_234_1) then
				if arg_231_1.var_.characterEffect10014ui_story and not isNil(var_234_1) then
					arg_231_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_231_1.time_ >= 0 + var_234_2 and arg_231_1.time_ < 0 + var_234_2 + arg_234_0 and not isNil(var_234_1) and arg_231_1.var_.characterEffect10014ui_story then
				arg_231_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_234_4 = 0
			local var_234_5 = 0.4

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_4 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_6 = arg_231_1:GetWordFromCfg(411051055)
				local var_234_7 = arg_231_1:FormatText(var_234_6.content)

				arg_231_1.text_.text = var_234_7

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_9 = 16 <= 0 and var_234_5 or var_234_5 * (utf8.len(var_234_7) / 16)

				if (16 <= 0 and var_234_5 or var_234_5 * (utf8.len(var_234_7) / 16)) > 0 and var_234_5 < var_234_9 then
					arg_231_1.talkMaxDuration = var_234_9

					if var_234_9 + var_234_4 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_9 + var_234_4
					end
				end

				arg_231_1.text_.text = var_234_7
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051055", "story_v_out_411051.awb") ~= 0 then
					local var_234_10 = manager.audio:GetVoiceLength("story_v_out_411051", "411051055", "story_v_out_411051.awb") / 1000

					if var_234_10 + var_234_4 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_10 + var_234_4
					end

					if var_234_6.prefab_name ~= "" and arg_231_1.actors_[var_234_6.prefab_name] ~= nil then
						local var_234_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_6.prefab_name].transform, "story_v_out_411051", "411051055", "story_v_out_411051.awb")

						arg_231_1:RecordAudio("411051055", var_234_11)
						arg_231_1:RecordAudio("411051055", var_234_11)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_411051", "411051055", "story_v_out_411051.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_411051", "411051055", "story_v_out_411051.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_12 = math.max(var_234_5, arg_231_1.talkMaxDuration)

			if var_234_4 <= arg_231_1.time_ and arg_231_1.time_ < var_234_4 + var_234_12 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_4) / var_234_12

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_4 + var_234_12 and arg_231_1.time_ < var_234_4 + var_234_12 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play411051056 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 411051056
		arg_235_1.duration_ = 6.97

		local var_235_0 = {
			zh = 6.966,
			ja = 5.666
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
				arg_235_0:Play411051057(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 0.875

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_1 = arg_235_1:GetWordFromCfg(411051056)
				local var_238_2 = arg_235_1:FormatText(var_238_1.content)

				arg_235_1.text_.text = var_238_2

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_4 = 35 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_2) / 35)

				if (35 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_2) / 35)) > 0 and var_238_0 < var_238_4 then
					arg_235_1.talkMaxDuration = var_238_4

					if var_238_4 + 0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_4 + 0
					end
				end

				arg_235_1.text_.text = var_238_2
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051056", "story_v_out_411051.awb") ~= 0 then
					local var_238_5 = manager.audio:GetVoiceLength("story_v_out_411051", "411051056", "story_v_out_411051.awb") / 1000

					if var_238_5 + 0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_5 + 0
					end

					if var_238_1.prefab_name ~= "" and arg_235_1.actors_[var_238_1.prefab_name] ~= nil then
						local var_238_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_1.prefab_name].transform, "story_v_out_411051", "411051056", "story_v_out_411051.awb")

						arg_235_1:RecordAudio("411051056", var_238_6)
						arg_235_1:RecordAudio("411051056", var_238_6)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_411051", "411051056", "story_v_out_411051.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_411051", "411051056", "story_v_out_411051.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_7 = math.max(var_238_0, arg_235_1.talkMaxDuration)

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_7 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - 0) / var_238_7

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= 0 + var_238_7 and arg_235_1.time_ < 0 + var_238_7 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play411051057 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 411051057
		arg_239_1.duration_ = 4.13

		local var_239_0 = {
			zh = 3.4,
			ja = 4.133
		}
		local var_239_1 = manager.audio:GetLocalizationFlag()

		if var_239_0[var_239_1] ~= nil then
			arg_239_1.duration_ = var_239_0[var_239_1]
		end

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play411051058(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(arg_239_1.actors_["10058ui_story"]) and arg_239_1.var_.characterEffect10058ui_story == nil then
				arg_239_1.var_.characterEffect10058ui_story = arg_239_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_0 = 0.200000002980232

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_0 and not isNil(arg_239_1.actors_["10058ui_story"]) then
				if arg_239_1.var_.characterEffect10058ui_story and not isNil(arg_239_1.actors_["10058ui_story"]) then
					arg_239_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_239_1.time_ >= 0 + var_242_0 and arg_239_1.time_ < 0 + var_242_0 + arg_242_0 and not isNil(arg_239_1.actors_["10058ui_story"]) and arg_239_1.var_.characterEffect10058ui_story then
				arg_239_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_242_2 = arg_239_1.actors_["10014ui_story"]

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(var_242_2) and arg_239_1.var_.characterEffect10014ui_story == nil then
				arg_239_1.var_.characterEffect10014ui_story = var_242_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_3 = 0.200000002980232

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_3 and not isNil(var_242_2) then
				if arg_239_1.var_.characterEffect10014ui_story and not isNil(var_242_2) then
					arg_239_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_239_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_239_1.time_ - 0) / var_242_3)
				end
			end

			if arg_239_1.time_ >= 0 + var_242_3 and arg_239_1.time_ < 0 + var_242_3 + arg_242_0 and not isNil(var_242_2) and arg_239_1.var_.characterEffect10014ui_story then
				arg_239_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_239_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_242_4 = 0
			local var_242_5 = 0.45

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_4 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_6 = arg_239_1:GetWordFromCfg(411051057)
				local var_242_7 = arg_239_1:FormatText(var_242_6.content)

				arg_239_1.text_.text = var_242_7

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_9 = 18 <= 0 and var_242_5 or var_242_5 * (utf8.len(var_242_7) / 18)

				if (18 <= 0 and var_242_5 or var_242_5 * (utf8.len(var_242_7) / 18)) > 0 and var_242_5 < var_242_9 then
					arg_239_1.talkMaxDuration = var_242_9

					if var_242_9 + var_242_4 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_9 + var_242_4
					end
				end

				arg_239_1.text_.text = var_242_7
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051057", "story_v_out_411051.awb") ~= 0 then
					local var_242_10 = manager.audio:GetVoiceLength("story_v_out_411051", "411051057", "story_v_out_411051.awb") / 1000

					if var_242_10 + var_242_4 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_10 + var_242_4
					end

					if var_242_6.prefab_name ~= "" and arg_239_1.actors_[var_242_6.prefab_name] ~= nil then
						local var_242_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_6.prefab_name].transform, "story_v_out_411051", "411051057", "story_v_out_411051.awb")

						arg_239_1:RecordAudio("411051057", var_242_11)
						arg_239_1:RecordAudio("411051057", var_242_11)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_411051", "411051057", "story_v_out_411051.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_411051", "411051057", "story_v_out_411051.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_12 = math.max(var_242_5, arg_239_1.talkMaxDuration)

			if var_242_4 <= arg_239_1.time_ and arg_239_1.time_ < var_242_4 + var_242_12 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_4) / var_242_12

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_4 + var_242_12 and arg_239_1.time_ < var_242_4 + var_242_12 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play411051058 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 411051058
		arg_243_1.duration_ = 7.17

		local var_243_0 = {
			zh = 7.166,
			ja = 6.5
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
				arg_243_0:Play411051059(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.var_.moveOldPos10014ui_story = arg_243_1.actors_["10014ui_story"].transform.localPosition
			end

			local var_246_0 = 0.001

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_0 then
				arg_243_1.actors_["10014ui_story"].transform.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos10014ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_243_1.time_ - 0) / var_246_0)
				arg_243_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_243_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["10014ui_story"].transform.position).z)
				arg_243_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_243_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_243_1.actors_["10014ui_story"].transform.localEulerAngles = arg_243_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			if arg_243_1.time_ >= 0 + var_246_0 and arg_243_1.time_ < 0 + var_246_0 + arg_246_0 then
				arg_243_1.actors_["10014ui_story"].transform.localPosition = Vector3.New(0.7, -1.06, -6.2)
				arg_243_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_243_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["10014ui_story"].transform.position).z)
				arg_243_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_243_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_243_1.actors_["10014ui_story"].transform.localEulerAngles = arg_243_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			local var_246_1 = arg_243_1.actors_["10014ui_story"]

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(var_246_1) and arg_243_1.var_.characterEffect10014ui_story == nil then
				arg_243_1.var_.characterEffect10014ui_story = var_246_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_2 = 0.200000002980232

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_2 and not isNil(var_246_1) then
				if arg_243_1.var_.characterEffect10014ui_story and not isNil(var_246_1) then
					arg_243_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_243_1.time_ >= 0 + var_246_2 and arg_243_1.time_ < 0 + var_246_2 + arg_246_0 and not isNil(var_246_1) and arg_243_1.var_.characterEffect10014ui_story then
				arg_243_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action1_1")
			end

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_246_4 = arg_243_1.actors_["10058ui_story"]

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(var_246_4) and arg_243_1.var_.characterEffect10058ui_story == nil then
				arg_243_1.var_.characterEffect10058ui_story = var_246_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_5 = 0.0166666666666667

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_5 and not isNil(var_246_4) then
				if arg_243_1.var_.characterEffect10058ui_story and not isNil(var_246_4) then
					arg_243_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_243_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_243_1.time_ - 0) / var_246_5)
				end
			end

			if arg_243_1.time_ >= 0 + var_246_5 and arg_243_1.time_ < 0 + var_246_5 + arg_246_0 and not isNil(var_246_4) and arg_243_1.var_.characterEffect10058ui_story then
				arg_243_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_243_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_246_6 = 0
			local var_246_7 = 0.9

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_6 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_8 = arg_243_1:GetWordFromCfg(411051058)
				local var_246_9 = arg_243_1:FormatText(var_246_8.content)

				arg_243_1.text_.text = var_246_9

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_11 = 36 <= 0 and var_246_7 or var_246_7 * (utf8.len(var_246_9) / 36)

				if (36 <= 0 and var_246_7 or var_246_7 * (utf8.len(var_246_9) / 36)) > 0 and var_246_7 < var_246_11 then
					arg_243_1.talkMaxDuration = var_246_11

					if var_246_11 + var_246_6 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_11 + var_246_6
					end
				end

				arg_243_1.text_.text = var_246_9
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051058", "story_v_out_411051.awb") ~= 0 then
					local var_246_12 = manager.audio:GetVoiceLength("story_v_out_411051", "411051058", "story_v_out_411051.awb") / 1000

					if var_246_12 + var_246_6 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_12 + var_246_6
					end

					if var_246_8.prefab_name ~= "" and arg_243_1.actors_[var_246_8.prefab_name] ~= nil then
						local var_246_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_8.prefab_name].transform, "story_v_out_411051", "411051058", "story_v_out_411051.awb")

						arg_243_1:RecordAudio("411051058", var_246_13)
						arg_243_1:RecordAudio("411051058", var_246_13)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_411051", "411051058", "story_v_out_411051.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_411051", "411051058", "story_v_out_411051.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_14 = math.max(var_246_7, arg_243_1.talkMaxDuration)

			if var_246_6 <= arg_243_1.time_ and arg_243_1.time_ < var_246_6 + var_246_14 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_6) / var_246_14

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_6 + var_246_14 and arg_243_1.time_ < var_246_6 + var_246_14 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_243_1:InitPlayNodeList()
	end,
	Play411051059 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 411051059
		arg_247_1.duration_ = 11.1

		local var_247_0 = {
			zh = 11.1,
			ja = 7.566
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
				arg_247_0:Play411051060(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = 1.325

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_1 = arg_247_1:GetWordFromCfg(411051059)
				local var_250_2 = arg_247_1:FormatText(var_250_1.content)

				arg_247_1.text_.text = var_250_2

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_4 = 53 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_2) / 53)

				if (53 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_2) / 53)) > 0 and var_250_0 < var_250_4 then
					arg_247_1.talkMaxDuration = var_250_4

					if var_250_4 + 0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_4 + 0
					end
				end

				arg_247_1.text_.text = var_250_2
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051059", "story_v_out_411051.awb") ~= 0 then
					local var_250_5 = manager.audio:GetVoiceLength("story_v_out_411051", "411051059", "story_v_out_411051.awb") / 1000

					if var_250_5 + 0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_5 + 0
					end

					if var_250_1.prefab_name ~= "" and arg_247_1.actors_[var_250_1.prefab_name] ~= nil then
						local var_250_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_1.prefab_name].transform, "story_v_out_411051", "411051059", "story_v_out_411051.awb")

						arg_247_1:RecordAudio("411051059", var_250_6)
						arg_247_1:RecordAudio("411051059", var_250_6)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_411051", "411051059", "story_v_out_411051.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_411051", "411051059", "story_v_out_411051.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_7 = math.max(var_250_0, arg_247_1.talkMaxDuration)

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_7 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - 0) / var_250_7

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= 0 + var_250_7 and arg_247_1.time_ < 0 + var_250_7 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play411051060 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 411051060
		arg_251_1.duration_ = 1.57

		local var_251_0 = {
			zh = 1.3,
			ja = 1.566
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
				arg_251_0:Play411051061(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = 0.15

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_1 = arg_251_1:GetWordFromCfg(411051060)
				local var_254_2 = arg_251_1:FormatText(var_254_1.content)

				arg_251_1.text_.text = var_254_2

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_4 = 6 <= 0 and var_254_0 or var_254_0 * (utf8.len(var_254_2) / 6)

				if (6 <= 0 and var_254_0 or var_254_0 * (utf8.len(var_254_2) / 6)) > 0 and var_254_0 < var_254_4 then
					arg_251_1.talkMaxDuration = var_254_4

					if var_254_4 + 0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_4 + 0
					end
				end

				arg_251_1.text_.text = var_254_2
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051060", "story_v_out_411051.awb") ~= 0 then
					local var_254_5 = manager.audio:GetVoiceLength("story_v_out_411051", "411051060", "story_v_out_411051.awb") / 1000

					if var_254_5 + 0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_5 + 0
					end

					if var_254_1.prefab_name ~= "" and arg_251_1.actors_[var_254_1.prefab_name] ~= nil then
						local var_254_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_1.prefab_name].transform, "story_v_out_411051", "411051060", "story_v_out_411051.awb")

						arg_251_1:RecordAudio("411051060", var_254_6)
						arg_251_1:RecordAudio("411051060", var_254_6)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_411051", "411051060", "story_v_out_411051.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_411051", "411051060", "story_v_out_411051.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_7 = math.max(var_254_0, arg_251_1.talkMaxDuration)

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_7 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - 0) / var_254_7

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= 0 + var_254_7 and arg_251_1.time_ < 0 + var_254_7 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play411051061 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 411051061
		arg_255_1.duration_ = 3.97

		local var_255_0 = {
			zh = 3.7,
			ja = 3.966
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
				arg_255_0:Play411051062(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(arg_255_1.actors_["10014ui_story"]) and arg_255_1.var_.characterEffect10014ui_story == nil then
				arg_255_1.var_.characterEffect10014ui_story = arg_255_1.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_0 = 0.200000002980232

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_0 and not isNil(arg_255_1.actors_["10014ui_story"]) then
				if arg_255_1.var_.characterEffect10014ui_story and not isNil(arg_255_1.actors_["10014ui_story"]) then
					arg_255_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_255_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_255_1.time_ - 0) / var_258_0)
				end
			end

			if arg_255_1.time_ >= 0 + var_258_0 and arg_255_1.time_ < 0 + var_258_0 + arg_258_0 and not isNil(arg_255_1.actors_["10014ui_story"]) and arg_255_1.var_.characterEffect10014ui_story then
				arg_255_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_255_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_258_1 = arg_255_1.actors_["10058ui_story"]

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(var_258_1) and arg_255_1.var_.characterEffect10058ui_story == nil then
				arg_255_1.var_.characterEffect10058ui_story = var_258_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_2 = 0.200000002980232

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_2 and not isNil(var_258_1) then
				if arg_255_1.var_.characterEffect10058ui_story and not isNil(var_258_1) then
					arg_255_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_255_1.time_ >= 0 + var_258_2 and arg_255_1.time_ < 0 + var_258_2 + arg_258_0 and not isNil(var_258_1) and arg_255_1.var_.characterEffect10058ui_story then
				arg_255_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_258_4 = 0
			local var_258_5 = 0.45

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_4 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_6 = arg_255_1:GetWordFromCfg(411051061)
				local var_258_7 = arg_255_1:FormatText(var_258_6.content)

				arg_255_1.text_.text = var_258_7

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_9 = 18 <= 0 and var_258_5 or var_258_5 * (utf8.len(var_258_7) / 18)

				if (18 <= 0 and var_258_5 or var_258_5 * (utf8.len(var_258_7) / 18)) > 0 and var_258_5 < var_258_9 then
					arg_255_1.talkMaxDuration = var_258_9

					if var_258_9 + var_258_4 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_9 + var_258_4
					end
				end

				arg_255_1.text_.text = var_258_7
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051061", "story_v_out_411051.awb") ~= 0 then
					local var_258_10 = manager.audio:GetVoiceLength("story_v_out_411051", "411051061", "story_v_out_411051.awb") / 1000

					if var_258_10 + var_258_4 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_10 + var_258_4
					end

					if var_258_6.prefab_name ~= "" and arg_255_1.actors_[var_258_6.prefab_name] ~= nil then
						local var_258_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_6.prefab_name].transform, "story_v_out_411051", "411051061", "story_v_out_411051.awb")

						arg_255_1:RecordAudio("411051061", var_258_11)
						arg_255_1:RecordAudio("411051061", var_258_11)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_411051", "411051061", "story_v_out_411051.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_411051", "411051061", "story_v_out_411051.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_12 = math.max(var_258_5, arg_255_1.talkMaxDuration)

			if var_258_4 <= arg_255_1.time_ and arg_255_1.time_ < var_258_4 + var_258_12 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_4) / var_258_12

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_4 + var_258_12 and arg_255_1.time_ < var_258_4 + var_258_12 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play411051062 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 411051062
		arg_259_1.duration_ = 3.73

		local var_259_0 = {
			zh = 2.1,
			ja = 3.733
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
				arg_259_0:Play411051063(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.var_.moveOldPos10058ui_story = arg_259_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_262_0 = 0.001

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_0 then
				arg_259_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos10058ui_story, Vector3.New(-0.7, -0.98, -6.1), (arg_259_1.time_ - 0) / var_262_0)
				arg_259_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_259_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["10058ui_story"].transform.position).z)
				arg_259_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_259_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_259_1.actors_["10058ui_story"].transform.localEulerAngles = arg_259_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_259_1.time_ >= 0 + var_262_0 and arg_259_1.time_ < 0 + var_262_0 + arg_262_0 then
				arg_259_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(-0.7, -0.98, -6.1)
				arg_259_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_259_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["10058ui_story"].transform.position).z)
				arg_259_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_259_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_259_1.actors_["10058ui_story"].transform.localEulerAngles = arg_259_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_262_1 = 0
			local var_262_2 = 0.325

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_1 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_3 = arg_259_1:GetWordFromCfg(411051062)
				local var_262_4 = arg_259_1:FormatText(var_262_3.content)

				arg_259_1.text_.text = var_262_4

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_6 = 13 <= 0 and var_262_2 or var_262_2 * (utf8.len(var_262_4) / 13)

				if (13 <= 0 and var_262_2 or var_262_2 * (utf8.len(var_262_4) / 13)) > 0 and var_262_2 < var_262_6 then
					arg_259_1.talkMaxDuration = var_262_6

					if var_262_6 + var_262_1 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_6 + var_262_1
					end
				end

				arg_259_1.text_.text = var_262_4
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051062", "story_v_out_411051.awb") ~= 0 then
					local var_262_7 = manager.audio:GetVoiceLength("story_v_out_411051", "411051062", "story_v_out_411051.awb") / 1000

					if var_262_7 + var_262_1 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_7 + var_262_1
					end

					if var_262_3.prefab_name ~= "" and arg_259_1.actors_[var_262_3.prefab_name] ~= nil then
						local var_262_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_3.prefab_name].transform, "story_v_out_411051", "411051062", "story_v_out_411051.awb")

						arg_259_1:RecordAudio("411051062", var_262_8)
						arg_259_1:RecordAudio("411051062", var_262_8)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_411051", "411051062", "story_v_out_411051.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_411051", "411051062", "story_v_out_411051.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_9 = math.max(var_262_2, arg_259_1.talkMaxDuration)

			if var_262_1 <= arg_259_1.time_ and arg_259_1.time_ < var_262_1 + var_262_9 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_1) / var_262_9

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_1 + var_262_9 and arg_259_1.time_ < var_262_1 + var_262_9 + arg_262_0 then
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
			}
		}

		arg_259_1:InitPlayNodeList()
	end,
	Play411051063 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 411051063
		arg_263_1.duration_ = 14.47

		local var_263_0 = {
			zh = 7,
			ja = 14.466
		}
		local var_263_1 = manager.audio:GetLocalizationFlag()

		if var_263_0[var_263_1] ~= nil then
			arg_263_1.duration_ = var_263_0[var_263_1]
		end

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play411051064(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(arg_263_1.actors_["10058ui_story"]) and arg_263_1.var_.characterEffect10058ui_story == nil then
				arg_263_1.var_.characterEffect10058ui_story = arg_263_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_0 = 0.200000002980232

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_0 and not isNil(arg_263_1.actors_["10058ui_story"]) then
				if arg_263_1.var_.characterEffect10058ui_story and not isNil(arg_263_1.actors_["10058ui_story"]) then
					arg_263_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_263_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_263_1.time_ - 0) / var_266_0)
				end
			end

			if arg_263_1.time_ >= 0 + var_266_0 and arg_263_1.time_ < 0 + var_266_0 + arg_266_0 and not isNil(arg_263_1.actors_["10058ui_story"]) and arg_263_1.var_.characterEffect10058ui_story then
				arg_263_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_263_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_266_1 = arg_263_1.actors_["10014ui_story"]

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(var_266_1) and arg_263_1.var_.characterEffect10014ui_story == nil then
				arg_263_1.var_.characterEffect10014ui_story = var_266_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_2 = 0.200000002980232

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_2 and not isNil(var_266_1) then
				if arg_263_1.var_.characterEffect10014ui_story and not isNil(var_266_1) then
					arg_263_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_263_1.time_ >= 0 + var_266_2 and arg_263_1.time_ < 0 + var_266_2 + arg_266_0 and not isNil(var_266_1) and arg_263_1.var_.characterEffect10014ui_story then
				arg_263_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_266_4 = 0
			local var_266_5 = 0.825

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_4 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_6 = arg_263_1:GetWordFromCfg(411051063)
				local var_266_7 = arg_263_1:FormatText(var_266_6.content)

				arg_263_1.text_.text = var_266_7

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_9 = 33 <= 0 and var_266_5 or var_266_5 * (utf8.len(var_266_7) / 33)

				if (33 <= 0 and var_266_5 or var_266_5 * (utf8.len(var_266_7) / 33)) > 0 and var_266_5 < var_266_9 then
					arg_263_1.talkMaxDuration = var_266_9

					if var_266_9 + var_266_4 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_9 + var_266_4
					end
				end

				arg_263_1.text_.text = var_266_7
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051063", "story_v_out_411051.awb") ~= 0 then
					local var_266_10 = manager.audio:GetVoiceLength("story_v_out_411051", "411051063", "story_v_out_411051.awb") / 1000

					if var_266_10 + var_266_4 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_10 + var_266_4
					end

					if var_266_6.prefab_name ~= "" and arg_263_1.actors_[var_266_6.prefab_name] ~= nil then
						local var_266_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_6.prefab_name].transform, "story_v_out_411051", "411051063", "story_v_out_411051.awb")

						arg_263_1:RecordAudio("411051063", var_266_11)
						arg_263_1:RecordAudio("411051063", var_266_11)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_411051", "411051063", "story_v_out_411051.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_411051", "411051063", "story_v_out_411051.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_12 = math.max(var_266_5, arg_263_1.talkMaxDuration)

			if var_266_4 <= arg_263_1.time_ and arg_263_1.time_ < var_266_4 + var_266_12 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_4) / var_266_12

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_4 + var_266_12 and arg_263_1.time_ < var_266_4 + var_266_12 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play411051064 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 411051064
		arg_267_1.duration_ = 5.5

		local var_267_0 = {
			zh = 4.8,
			ja = 5.5
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
				arg_267_0:Play411051065(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(arg_267_1.actors_["10058ui_story"]) and arg_267_1.var_.characterEffect10058ui_story == nil then
				arg_267_1.var_.characterEffect10058ui_story = arg_267_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_0 = 0.200000002980232

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_0 and not isNil(arg_267_1.actors_["10058ui_story"]) then
				if arg_267_1.var_.characterEffect10058ui_story and not isNil(arg_267_1.actors_["10058ui_story"]) then
					arg_267_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_267_1.time_ >= 0 + var_270_0 and arg_267_1.time_ < 0 + var_270_0 + arg_270_0 and not isNil(arg_267_1.actors_["10058ui_story"]) and arg_267_1.var_.characterEffect10058ui_story then
				arg_267_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_270_2 = arg_267_1.actors_["10014ui_story"]

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(var_270_2) and arg_267_1.var_.characterEffect10014ui_story == nil then
				arg_267_1.var_.characterEffect10014ui_story = var_270_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_3 = 0.200000002980232

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_3 and not isNil(var_270_2) then
				if arg_267_1.var_.characterEffect10014ui_story and not isNil(var_270_2) then
					arg_267_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_267_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_267_1.time_ - 0) / var_270_3)
				end
			end

			if arg_267_1.time_ >= 0 + var_270_3 and arg_267_1.time_ < 0 + var_270_3 + arg_270_0 and not isNil(var_270_2) and arg_267_1.var_.characterEffect10014ui_story then
				arg_267_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_267_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_270_4 = 0
			local var_270_5 = 0.525

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_4 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				arg_267_1.leftNameTxt_.text = arg_267_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_6 = arg_267_1:GetWordFromCfg(411051064)
				local var_270_7 = arg_267_1:FormatText(var_270_6.content)

				arg_267_1.text_.text = var_270_7

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_9 = 21 <= 0 and var_270_5 or var_270_5 * (utf8.len(var_270_7) / 21)

				if (21 <= 0 and var_270_5 or var_270_5 * (utf8.len(var_270_7) / 21)) > 0 and var_270_5 < var_270_9 then
					arg_267_1.talkMaxDuration = var_270_9

					if var_270_9 + var_270_4 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_9 + var_270_4
					end
				end

				arg_267_1.text_.text = var_270_7
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051064", "story_v_out_411051.awb") ~= 0 then
					local var_270_10 = manager.audio:GetVoiceLength("story_v_out_411051", "411051064", "story_v_out_411051.awb") / 1000

					if var_270_10 + var_270_4 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_10 + var_270_4
					end

					if var_270_6.prefab_name ~= "" and arg_267_1.actors_[var_270_6.prefab_name] ~= nil then
						local var_270_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_6.prefab_name].transform, "story_v_out_411051", "411051064", "story_v_out_411051.awb")

						arg_267_1:RecordAudio("411051064", var_270_11)
						arg_267_1:RecordAudio("411051064", var_270_11)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_411051", "411051064", "story_v_out_411051.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_411051", "411051064", "story_v_out_411051.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_12 = math.max(var_270_5, arg_267_1.talkMaxDuration)

			if var_270_4 <= arg_267_1.time_ and arg_267_1.time_ < var_270_4 + var_270_12 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_4) / var_270_12

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_4 + var_270_12 and arg_267_1.time_ < var_270_4 + var_270_12 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play411051065 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 411051065
		arg_271_1.duration_ = 9.3

		local var_271_0 = {
			zh = 4.1,
			ja = 9.3
		}
		local var_271_1 = manager.audio:GetLocalizationFlag()

		if var_271_0[var_271_1] ~= nil then
			arg_271_1.duration_ = var_271_0[var_271_1]
		end

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play411051066(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(arg_271_1.actors_["10014ui_story"]) and arg_271_1.var_.characterEffect10014ui_story == nil then
				arg_271_1.var_.characterEffect10014ui_story = arg_271_1.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_0 = 0.200000002980232

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_0 and not isNil(arg_271_1.actors_["10014ui_story"]) then
				if arg_271_1.var_.characterEffect10014ui_story and not isNil(arg_271_1.actors_["10014ui_story"]) then
					arg_271_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_271_1.time_ >= 0 + var_274_0 and arg_271_1.time_ < 0 + var_274_0 + arg_274_0 and not isNil(arg_271_1.actors_["10014ui_story"]) and arg_271_1.var_.characterEffect10014ui_story then
				arg_271_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action5_1")
			end

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_274_2 = arg_271_1.actors_["10058ui_story"]

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(var_274_2) and arg_271_1.var_.characterEffect10058ui_story == nil then
				arg_271_1.var_.characterEffect10058ui_story = var_274_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_3 = 0.200000002980232

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_3 and not isNil(var_274_2) then
				if arg_271_1.var_.characterEffect10058ui_story and not isNil(var_274_2) then
					arg_271_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_271_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_271_1.time_ - 0) / var_274_3)
				end
			end

			if arg_271_1.time_ >= 0 + var_274_3 and arg_271_1.time_ < 0 + var_274_3 + arg_274_0 and not isNil(var_274_2) and arg_271_1.var_.characterEffect10058ui_story then
				arg_271_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_271_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_274_4 = 0
			local var_274_5 = 0.475

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_4 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_6 = arg_271_1:GetWordFromCfg(411051065)
				local var_274_7 = arg_271_1:FormatText(var_274_6.content)

				arg_271_1.text_.text = var_274_7

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_9 = 19 <= 0 and var_274_5 or var_274_5 * (utf8.len(var_274_7) / 19)

				if (19 <= 0 and var_274_5 or var_274_5 * (utf8.len(var_274_7) / 19)) > 0 and var_274_5 < var_274_9 then
					arg_271_1.talkMaxDuration = var_274_9

					if var_274_9 + var_274_4 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_9 + var_274_4
					end
				end

				arg_271_1.text_.text = var_274_7
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051065", "story_v_out_411051.awb") ~= 0 then
					local var_274_10 = manager.audio:GetVoiceLength("story_v_out_411051", "411051065", "story_v_out_411051.awb") / 1000

					if var_274_10 + var_274_4 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_10 + var_274_4
					end

					if var_274_6.prefab_name ~= "" and arg_271_1.actors_[var_274_6.prefab_name] ~= nil then
						local var_274_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_6.prefab_name].transform, "story_v_out_411051", "411051065", "story_v_out_411051.awb")

						arg_271_1:RecordAudio("411051065", var_274_11)
						arg_271_1:RecordAudio("411051065", var_274_11)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_411051", "411051065", "story_v_out_411051.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_411051", "411051065", "story_v_out_411051.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_12 = math.max(var_274_5, arg_271_1.talkMaxDuration)

			if var_274_4 <= arg_271_1.time_ and arg_271_1.time_ < var_274_4 + var_274_12 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_4) / var_274_12

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_4 + var_274_12 and arg_271_1.time_ < var_274_4 + var_274_12 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play411051066 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 411051066
		arg_275_1.duration_ = 3.43

		local var_275_0 = {
			zh = 2.833,
			ja = 3.433
		}
		local var_275_1 = manager.audio:GetLocalizationFlag()

		if var_275_0[var_275_1] ~= nil then
			arg_275_1.duration_ = var_275_0[var_275_1]
		end

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play411051067(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(arg_275_1.actors_["10014ui_story"]) and arg_275_1.var_.characterEffect10014ui_story == nil then
				arg_275_1.var_.characterEffect10014ui_story = arg_275_1.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_0 = 0.200000002980232

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_0 and not isNil(arg_275_1.actors_["10014ui_story"]) then
				if arg_275_1.var_.characterEffect10014ui_story and not isNil(arg_275_1.actors_["10014ui_story"]) then
					arg_275_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_275_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_275_1.time_ - 0) / var_278_0)
				end
			end

			if arg_275_1.time_ >= 0 + var_278_0 and arg_275_1.time_ < 0 + var_278_0 + arg_278_0 and not isNil(arg_275_1.actors_["10014ui_story"]) and arg_275_1.var_.characterEffect10014ui_story then
				arg_275_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_275_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_278_1 = arg_275_1.actors_["10058ui_story"]

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(var_278_1) and arg_275_1.var_.characterEffect10058ui_story == nil then
				arg_275_1.var_.characterEffect10058ui_story = var_278_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_2 = 0.200000002980232

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_2 and not isNil(var_278_1) then
				if arg_275_1.var_.characterEffect10058ui_story and not isNil(var_278_1) then
					arg_275_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_275_1.time_ >= 0 + var_278_2 and arg_275_1.time_ < 0 + var_278_2 + arg_278_0 and not isNil(var_278_1) and arg_275_1.var_.characterEffect10058ui_story then
				arg_275_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_278_4 = 0
			local var_278_5 = 0.275

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_4 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_6 = arg_275_1:GetWordFromCfg(411051066)
				local var_278_7 = arg_275_1:FormatText(var_278_6.content)

				arg_275_1.text_.text = var_278_7

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_9 = 11 <= 0 and var_278_5 or var_278_5 * (utf8.len(var_278_7) / 11)

				if (11 <= 0 and var_278_5 or var_278_5 * (utf8.len(var_278_7) / 11)) > 0 and var_278_5 < var_278_9 then
					arg_275_1.talkMaxDuration = var_278_9

					if var_278_9 + var_278_4 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_9 + var_278_4
					end
				end

				arg_275_1.text_.text = var_278_7
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051066", "story_v_out_411051.awb") ~= 0 then
					local var_278_10 = manager.audio:GetVoiceLength("story_v_out_411051", "411051066", "story_v_out_411051.awb") / 1000

					if var_278_10 + var_278_4 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_10 + var_278_4
					end

					if var_278_6.prefab_name ~= "" and arg_275_1.actors_[var_278_6.prefab_name] ~= nil then
						local var_278_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_6.prefab_name].transform, "story_v_out_411051", "411051066", "story_v_out_411051.awb")

						arg_275_1:RecordAudio("411051066", var_278_11)
						arg_275_1:RecordAudio("411051066", var_278_11)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_411051", "411051066", "story_v_out_411051.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_411051", "411051066", "story_v_out_411051.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_12 = math.max(var_278_5, arg_275_1.talkMaxDuration)

			if var_278_4 <= arg_275_1.time_ and arg_275_1.time_ < var_278_4 + var_278_12 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_4) / var_278_12

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_4 + var_278_12 and arg_275_1.time_ < var_278_4 + var_278_12 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play411051067 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 411051067
		arg_279_1.duration_ = 9

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play411051068(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				local var_282_0 = arg_279_1.bgs_.I07

				arg_279_1.bgs_.I07.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_282_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_282_1 = var_282_0:GetComponent("SpriteRenderer")

				if var_282_1 and var_282_1.sprite then
					local var_282_2 = 2 * (var_282_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_282_0.transform.localScale = Vector3.New(var_282_2 / var_282_1.sprite.bounds.size.y < var_282_2 * manager.ui.mainCameraCom_.aspect / var_282_1.sprite.bounds.size.x and var_282_2 * manager.ui.mainCameraCom_.aspect / var_282_1.sprite.bounds.size.x or var_282_2 / var_282_1.sprite.bounds.size.y, var_282_2 / var_282_1.sprite.bounds.size.y < var_282_2 * manager.ui.mainCameraCom_.aspect / var_282_1.sprite.bounds.size.x and var_282_2 * manager.ui.mainCameraCom_.aspect / var_282_1.sprite.bounds.size.x or var_282_2 / var_282_1.sprite.bounds.size.y, 0)
				end

				for iter_282_0, iter_282_1 in pairs(arg_279_1.bgs_) do
					if iter_282_0 ~= "I07" then
						iter_282_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 2 < arg_279_1.time_ and arg_279_1.time_ <= 2 + arg_282_0 then
				local var_282_3 = arg_279_1.bgs_.ST03

				arg_279_1.bgs_.ST03.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_282_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_282_4 = var_282_3:GetComponent("SpriteRenderer")

				if var_282_4 and var_282_4.sprite then
					local var_282_5 = 2 * (var_282_3.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_282_3.transform.localScale = Vector3.New(var_282_5 / var_282_4.sprite.bounds.size.y < var_282_5 * manager.ui.mainCameraCom_.aspect / var_282_4.sprite.bounds.size.x and var_282_5 * manager.ui.mainCameraCom_.aspect / var_282_4.sprite.bounds.size.x or var_282_5 / var_282_4.sprite.bounds.size.y, var_282_5 / var_282_4.sprite.bounds.size.y < var_282_5 * manager.ui.mainCameraCom_.aspect / var_282_4.sprite.bounds.size.x and var_282_5 * manager.ui.mainCameraCom_.aspect / var_282_4.sprite.bounds.size.x or var_282_5 / var_282_4.sprite.bounds.size.y, 0)
				end

				for iter_282_2, iter_282_3 in pairs(arg_279_1.bgs_) do
					if iter_282_2 ~= "ST03" then
						iter_282_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_282_6 = 0

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_6 + arg_282_0 then
				arg_279_1.mask_.enabled = true
				arg_279_1.mask_.raycastTarget = true

				arg_279_1:SetGaussion(false)
			end

			local var_282_7 = 2

			if var_282_6 <= arg_279_1.time_ and arg_279_1.time_ < var_282_6 + var_282_7 then
				local var_282_8 = Color.New(0, 0, 0)

				var_282_8.a = Mathf.Lerp(0, 1, (arg_279_1.time_ - var_282_6) / var_282_7)
				arg_279_1.mask_.color = var_282_8
			end

			if arg_279_1.time_ >= var_282_6 + var_282_7 and arg_279_1.time_ < var_282_6 + var_282_7 + arg_282_0 then
				local var_282_9 = Color.New(0, 0, 0)

				var_282_9.a = 1
				arg_279_1.mask_.color = var_282_9
			end

			local var_282_10 = 2

			if 2 < arg_279_1.time_ and arg_279_1.time_ <= var_282_10 + arg_282_0 then
				arg_279_1.mask_.enabled = true
				arg_279_1.mask_.raycastTarget = true

				arg_279_1:SetGaussion(false)
			end

			local var_282_11 = 2

			if var_282_10 <= arg_279_1.time_ and arg_279_1.time_ < var_282_10 + var_282_11 then
				local var_282_12 = Color.New(0, 0, 0)

				var_282_12.a = Mathf.Lerp(1, 0, (arg_279_1.time_ - var_282_10) / var_282_11)
				arg_279_1.mask_.color = var_282_12
			end

			if arg_279_1.time_ >= var_282_10 + var_282_11 and arg_279_1.time_ < var_282_10 + var_282_11 + arg_282_0 then
				local var_282_13 = Color.New(0, 0, 0)

				arg_279_1.mask_.enabled = false
				var_282_13.a = 0
				arg_279_1.mask_.color = var_282_13
			end

			local var_282_14 = arg_279_1.actors_["10058ui_story"]

			if 2 < arg_279_1.time_ and arg_279_1.time_ <= 2 + arg_282_0 and not isNil(var_282_14) and arg_279_1.var_.characterEffect10058ui_story == nil then
				arg_279_1.var_.characterEffect10058ui_story = var_282_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_15 = 0.200000002980232

			if 2 <= arg_279_1.time_ and arg_279_1.time_ < 2 + var_282_15 and not isNil(var_282_14) then
				if arg_279_1.var_.characterEffect10058ui_story and not isNil(var_282_14) then
					arg_279_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_279_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_279_1.time_ - 2) / var_282_15)
				end
			end

			if arg_279_1.time_ >= 2 + var_282_15 and arg_279_1.time_ < 2 + var_282_15 + arg_282_0 and not isNil(var_282_14) and arg_279_1.var_.characterEffect10058ui_story then
				arg_279_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_279_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_282_16 = arg_279_1.actors_["10058ui_story"].transform

			if 2 < arg_279_1.time_ and arg_279_1.time_ <= 2 + arg_282_0 then
				arg_279_1.var_.moveOldPos10058ui_story = var_282_16.localPosition
			end

			local var_282_17 = 0.001

			if 2 <= arg_279_1.time_ and arg_279_1.time_ < 2 + var_282_17 then
				var_282_16.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_279_1.time_ - 2) / var_282_17)
				var_282_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_282_16.position).x, (manager.ui.mainCamera.transform.position - var_282_16.position).y, (manager.ui.mainCamera.transform.position - var_282_16.position).z)
				var_282_16.localEulerAngles.z = 0
				var_282_16.localEulerAngles.x = 0
				var_282_16.localEulerAngles = var_282_16.localEulerAngles
			end

			if arg_279_1.time_ >= 2 + var_282_17 and arg_279_1.time_ < 2 + var_282_17 + arg_282_0 then
				var_282_16.localPosition = Vector3.New(0, 100, 0)
				var_282_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_282_16.position).x, (manager.ui.mainCamera.transform.position - var_282_16.position).y, (manager.ui.mainCamera.transform.position - var_282_16.position).z)
				var_282_16.localEulerAngles.z = 0
				var_282_16.localEulerAngles.x = 0
				var_282_16.localEulerAngles = var_282_16.localEulerAngles
			end

			local var_282_18 = arg_279_1.actors_["10014ui_story"].transform

			if 2 < arg_279_1.time_ and arg_279_1.time_ <= 2 + arg_282_0 then
				arg_279_1.var_.moveOldPos10014ui_story = var_282_18.localPosition
			end

			local var_282_19 = 0.001

			if 2 <= arg_279_1.time_ and arg_279_1.time_ < 2 + var_282_19 then
				var_282_18.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos10014ui_story, Vector3.New(0, 100, 0), (arg_279_1.time_ - 2) / var_282_19)
				var_282_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_282_18.position).x, (manager.ui.mainCamera.transform.position - var_282_18.position).y, (manager.ui.mainCamera.transform.position - var_282_18.position).z)
				var_282_18.localEulerAngles.z = 0
				var_282_18.localEulerAngles.x = 0
				var_282_18.localEulerAngles = var_282_18.localEulerAngles
			end

			if arg_279_1.time_ >= 2 + var_282_19 and arg_279_1.time_ < 2 + var_282_19 + arg_282_0 then
				var_282_18.localPosition = Vector3.New(0, 100, 0)
				var_282_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_282_18.position).x, (manager.ui.mainCamera.transform.position - var_282_18.position).y, (manager.ui.mainCamera.transform.position - var_282_18.position).z)
				var_282_18.localEulerAngles.z = 0
				var_282_18.localEulerAngles.x = 0
				var_282_18.localEulerAngles = var_282_18.localEulerAngles
			end

			local var_282_20 = arg_279_1.actors_["10014ui_story"]

			if 2 < arg_279_1.time_ and arg_279_1.time_ <= 2 + arg_282_0 and not isNil(var_282_20) and arg_279_1.var_.characterEffect10014ui_story == nil then
				arg_279_1.var_.characterEffect10014ui_story = var_282_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_21 = 0.200000002980232

			if 2 <= arg_279_1.time_ and arg_279_1.time_ < 2 + var_282_21 and not isNil(var_282_20) then
				if arg_279_1.var_.characterEffect10014ui_story and not isNil(var_282_20) then
					arg_279_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_279_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_279_1.time_ - 2) / var_282_21)
				end
			end

			if arg_279_1.time_ >= 2 + var_282_21 and arg_279_1.time_ < 2 + var_282_21 + arg_282_0 and not isNil(var_282_20) and arg_279_1.var_.characterEffect10014ui_story then
				arg_279_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_279_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			if arg_279_1.frameCnt_ <= 1 then
				arg_279_1.dialog_:SetActive(false)
			end

			local var_282_22 = 4
			local var_282_23 = 0.825

			if 4 < arg_279_1.time_ and arg_279_1.time_ <= var_282_22 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0

				arg_279_1.dialog_:SetActive(true)

				arg_279_1.dialogCg_.alpha = 0

				local var_282_24 = LeanTween.value(arg_279_1.dialog_, 0, 1, 0.3)

				var_282_24:setOnUpdate(LuaHelper.FloatAction(function(arg_283_0)
					arg_279_1.dialogCg_.alpha = arg_283_0
				end))
				var_282_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_279_1.dialog_)
					var_282_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_279_1.duration_ = arg_279_1.duration_ + 0.3

				SetActive(arg_279_1.leftNameGo_, false)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_25 = arg_279_1:FormatText(arg_279_1:GetWordFromCfg(411051067).content)

				arg_279_1.text_.text = var_282_25

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_27 = 33 <= 0 and var_282_23 or var_282_23 * (utf8.len(var_282_25) / 33)

				if (33 <= 0 and var_282_23 or var_282_23 * (utf8.len(var_282_25) / 33)) > 0 and var_282_23 < var_282_27 then
					arg_279_1.talkMaxDuration = var_282_27
					var_282_22 = var_282_22 + 0.3

					if var_282_27 + var_282_22 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_27 + var_282_22
					end
				end

				arg_279_1.text_.text = var_282_25
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)
				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_28 = var_282_22 + 0.3
			local var_282_29 = math.max(var_282_23, arg_279_1.talkMaxDuration)

			if var_282_22 + 0.3 <= arg_279_1.time_ and arg_279_1.time_ < var_282_28 + var_282_29 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_28) / var_282_29

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_28 + var_282_29 and arg_279_1.time_ < var_282_28 + var_282_29 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {
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
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_279_1:InitPlayNodeList()
	end,
	Play411051068 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 411051068
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play411051069(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_288_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_285_1.bgmTxt_.text ~= var_288_2 and arg_285_1.bgmTxt_.text ~= "" then
						if arg_285_1.bgmTxt2_.text ~= "" then
							arg_285_1.bgmTxt_.text = arg_285_1.bgmTxt2_.text
						end

						arg_285_1.bgmTxt2_.text = var_288_2

						arg_285_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_285_1.bgmTxt_.text = var_288_2
						arg_285_1.bgmTxt2_.text = var_288_2
					end

					if arg_285_1.bgmTimer then
						arg_285_1.bgmTimer:Stop()

						arg_285_1.bgmTimer = nil
					end

					if arg_285_1.settingData.show_music_name == 1 then
						arg_285_1.musicController:SetSelectedState("show")
						arg_285_1.musicAnimator_:Play("open", 0, 0)

						if arg_285_1.settingData.music_time ~= 0 then
							arg_285_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_285_1.settingData.music_time), function()
								if arg_285_1 == nil or isNil(arg_285_1.bgmTxt_) then
									return
								end

								arg_285_1.musicController:SetSelectedState("hide")
								arg_285_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_288_3 = 0
			local var_288_4 = 1.3

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_3 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, false)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_5 = arg_285_1:FormatText(arg_285_1:GetWordFromCfg(411051068).content)

				arg_285_1.text_.text = var_288_5

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_7 = 52 <= 0 and var_288_4 or var_288_4 * (utf8.len(var_288_5) / 52)

				if (52 <= 0 and var_288_4 or var_288_4 * (utf8.len(var_288_5) / 52)) > 0 and var_288_4 < var_288_7 then
					arg_285_1.talkMaxDuration = var_288_7

					if var_288_7 + var_288_3 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_7 + var_288_3
					end
				end

				arg_285_1.text_.text = var_288_5
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_8 = math.max(var_288_4, arg_285_1.talkMaxDuration)

			if var_288_3 <= arg_285_1.time_ and arg_285_1.time_ < var_288_3 + var_288_8 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_3) / var_288_8

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_3 + var_288_8 and arg_285_1.time_ < var_288_3 + var_288_8 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play411051069 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 411051069
		arg_290_1.duration_ = 2.03

		local var_290_0 = {
			zh = 1.999999999999,
			ja = 2.033
		}
		local var_290_1 = manager.audio:GetLocalizationFlag()

		if var_290_0[var_290_1] ~= nil then
			arg_290_1.duration_ = var_290_0[var_290_1]
		end

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play411051070(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 then
				arg_290_1.var_.moveOldPos10058ui_story = arg_290_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_293_0 = 0.001

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_0 then
				arg_290_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_290_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_290_1.time_ - 0) / var_293_0)
				arg_290_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_290_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_290_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_290_1.actors_["10058ui_story"].transform.position).z)
				arg_290_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_290_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_290_1.actors_["10058ui_story"].transform.localEulerAngles = arg_290_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_290_1.time_ >= 0 + var_293_0 and arg_290_1.time_ < 0 + var_293_0 + arg_293_0 then
				arg_290_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_290_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_290_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_290_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_290_1.actors_["10058ui_story"].transform.position).z)
				arg_290_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_290_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_290_1.actors_["10058ui_story"].transform.localEulerAngles = arg_290_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_293_1 = arg_290_1.actors_["10058ui_story"]

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 and not isNil(var_293_1) and arg_290_1.var_.characterEffect10058ui_story == nil then
				arg_290_1.var_.characterEffect10058ui_story = var_293_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_293_2 = 0.200000002980232

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_2 and not isNil(var_293_1) then
				if arg_290_1.var_.characterEffect10058ui_story and not isNil(var_293_1) then
					arg_290_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_290_1.time_ >= 0 + var_293_2 and arg_290_1.time_ < 0 + var_293_2 + arg_293_0 and not isNil(var_293_1) and arg_290_1.var_.characterEffect10058ui_story then
				arg_290_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 then
				arg_290_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 then
				arg_290_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_293_4 = 0
			local var_293_5 = 0.15

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_4 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				arg_290_1.leftNameTxt_.text = arg_290_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_6 = arg_290_1:GetWordFromCfg(411051069)
				local var_293_7 = arg_290_1:FormatText(var_293_6.content)

				arg_290_1.text_.text = var_293_7

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_9 = 6 <= 0 and var_293_5 or var_293_5 * (utf8.len(var_293_7) / 6)

				if (6 <= 0 and var_293_5 or var_293_5 * (utf8.len(var_293_7) / 6)) > 0 and var_293_5 < var_293_9 then
					arg_290_1.talkMaxDuration = var_293_9

					if var_293_9 + var_293_4 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_9 + var_293_4
					end
				end

				arg_290_1.text_.text = var_293_7
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051069", "story_v_out_411051.awb") ~= 0 then
					local var_293_10 = manager.audio:GetVoiceLength("story_v_out_411051", "411051069", "story_v_out_411051.awb") / 1000

					if var_293_10 + var_293_4 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_10 + var_293_4
					end

					if var_293_6.prefab_name ~= "" and arg_290_1.actors_[var_293_6.prefab_name] ~= nil then
						local var_293_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_290_1.actors_[var_293_6.prefab_name].transform, "story_v_out_411051", "411051069", "story_v_out_411051.awb")

						arg_290_1:RecordAudio("411051069", var_293_11)
						arg_290_1:RecordAudio("411051069", var_293_11)
					else
						arg_290_1:AudioAction("play", "voice", "story_v_out_411051", "411051069", "story_v_out_411051.awb")
					end

					arg_290_1:RecordHistoryTalkVoice("story_v_out_411051", "411051069", "story_v_out_411051.awb")
				end

				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_12 = math.max(var_293_5, arg_290_1.talkMaxDuration)

			if var_293_4 <= arg_290_1.time_ and arg_290_1.time_ < var_293_4 + var_293_12 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_4) / var_293_12

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_4 + var_293_12 and arg_290_1.time_ < var_293_4 + var_293_12 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {
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

		arg_290_1:InitPlayNodeList()
	end,
	Play411051070 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 411051070
		arg_294_1.duration_ = 5

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play411051071(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 and not isNil(arg_294_1.actors_["10058ui_story"]) and arg_294_1.var_.characterEffect10058ui_story == nil then
				arg_294_1.var_.characterEffect10058ui_story = arg_294_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_297_0 = 0.200000002980232

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_0 and not isNil(arg_294_1.actors_["10058ui_story"]) then
				if arg_294_1.var_.characterEffect10058ui_story and not isNil(arg_294_1.actors_["10058ui_story"]) then
					arg_294_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_294_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_294_1.time_ - 0) / var_297_0)
				end
			end

			if arg_294_1.time_ >= 0 + var_297_0 and arg_294_1.time_ < 0 + var_297_0 + arg_297_0 and not isNil(arg_294_1.actors_["10058ui_story"]) and arg_294_1.var_.characterEffect10058ui_story then
				arg_294_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_294_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_297_1 = 0
			local var_297_2 = 0.7

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= var_297_1 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, false)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_3 = arg_294_1:FormatText(arg_294_1:GetWordFromCfg(411051070).content)

				arg_294_1.text_.text = var_297_3

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_5 = 28 <= 0 and var_297_2 or var_297_2 * (utf8.len(var_297_3) / 28)

				if (28 <= 0 and var_297_2 or var_297_2 * (utf8.len(var_297_3) / 28)) > 0 and var_297_2 < var_297_5 then
					arg_294_1.talkMaxDuration = var_297_5

					if var_297_5 + var_297_1 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_5 + var_297_1
					end
				end

				arg_294_1.text_.text = var_297_3
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)
				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_6 = math.max(var_297_2, arg_294_1.talkMaxDuration)

			if var_297_1 <= arg_294_1.time_ and arg_294_1.time_ < var_297_1 + var_297_6 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_1) / var_297_6

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_1 + var_297_6 and arg_294_1.time_ < var_297_1 + var_297_6 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play411051071 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 411051071
		arg_298_1.duration_ = 6.7

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play411051072(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			if arg_298_1.bgs_.B10a == nil then
				local var_301_0 = Object.Instantiate(arg_298_1.paintGo_)

				var_301_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B10a")
				var_301_0.name = "B10a"
				var_301_0.transform.parent = arg_298_1.stage_.transform
				var_301_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_298_1.bgs_.B10a = var_301_0
			end

			if 2 < arg_298_1.time_ and arg_298_1.time_ <= 2 + arg_301_0 then
				local var_301_1 = arg_298_1.bgs_.B10a

				arg_298_1.bgs_.B10a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_301_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_301_2 = var_301_1:GetComponent("SpriteRenderer")

				if var_301_2 and var_301_2.sprite then
					local var_301_3 = 2 * (var_301_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_301_1.transform.localScale = Vector3.New(var_301_3 / var_301_2.sprite.bounds.size.y < var_301_3 * manager.ui.mainCameraCom_.aspect / var_301_2.sprite.bounds.size.x and var_301_3 * manager.ui.mainCameraCom_.aspect / var_301_2.sprite.bounds.size.x or var_301_3 / var_301_2.sprite.bounds.size.y, var_301_3 / var_301_2.sprite.bounds.size.y < var_301_3 * manager.ui.mainCameraCom_.aspect / var_301_2.sprite.bounds.size.x and var_301_3 * manager.ui.mainCameraCom_.aspect / var_301_2.sprite.bounds.size.x or var_301_3 / var_301_2.sprite.bounds.size.y, 0)
				end

				for iter_301_0, iter_301_1 in pairs(arg_298_1.bgs_) do
					if iter_301_0 ~= "B10a" then
						iter_301_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_301_4 = 0

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= var_301_4 + arg_301_0 then
				arg_298_1.mask_.enabled = true
				arg_298_1.mask_.raycastTarget = true

				arg_298_1:SetGaussion(false)
			end

			local var_301_5 = 2

			if var_301_4 <= arg_298_1.time_ and arg_298_1.time_ < var_301_4 + var_301_5 then
				local var_301_6 = Color.New(0, 0, 0)

				var_301_6.a = Mathf.Lerp(0, 1, (arg_298_1.time_ - var_301_4) / var_301_5)
				arg_298_1.mask_.color = var_301_6
			end

			if arg_298_1.time_ >= var_301_4 + var_301_5 and arg_298_1.time_ < var_301_4 + var_301_5 + arg_301_0 then
				local var_301_7 = Color.New(0, 0, 0)

				var_301_7.a = 1
				arg_298_1.mask_.color = var_301_7
			end

			local var_301_8 = 2

			if 2 < arg_298_1.time_ and arg_298_1.time_ <= var_301_8 + arg_301_0 then
				arg_298_1.mask_.enabled = true
				arg_298_1.mask_.raycastTarget = true

				arg_298_1:SetGaussion(false)
			end

			local var_301_9 = 2

			if var_301_8 <= arg_298_1.time_ and arg_298_1.time_ < var_301_8 + var_301_9 then
				local var_301_10 = Color.New(0, 0, 0)

				var_301_10.a = Mathf.Lerp(1, 0, (arg_298_1.time_ - var_301_8) / var_301_9)
				arg_298_1.mask_.color = var_301_10
			end

			if arg_298_1.time_ >= var_301_8 + var_301_9 and arg_298_1.time_ < var_301_8 + var_301_9 + arg_301_0 then
				local var_301_11 = Color.New(0, 0, 0)

				arg_298_1.mask_.enabled = false
				var_301_11.a = 0
				arg_298_1.mask_.color = var_301_11
			end

			local var_301_12 = arg_298_1.actors_["10058ui_story"].transform

			if 2 < arg_298_1.time_ and arg_298_1.time_ <= 2 + arg_301_0 then
				arg_298_1.var_.moveOldPos10058ui_story = var_301_12.localPosition
			end

			local var_301_13 = 0.001

			if 2 <= arg_298_1.time_ and arg_298_1.time_ < 2 + var_301_13 then
				var_301_12.localPosition = Vector3.Lerp(arg_298_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_298_1.time_ - 2) / var_301_13)
				var_301_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_301_12.position).x, (manager.ui.mainCamera.transform.position - var_301_12.position).y, (manager.ui.mainCamera.transform.position - var_301_12.position).z)
				var_301_12.localEulerAngles.z = 0
				var_301_12.localEulerAngles.x = 0
				var_301_12.localEulerAngles = var_301_12.localEulerAngles
			end

			if arg_298_1.time_ >= 2 + var_301_13 and arg_298_1.time_ < 2 + var_301_13 + arg_301_0 then
				var_301_12.localPosition = Vector3.New(0, 100, 0)
				var_301_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_301_12.position).x, (manager.ui.mainCamera.transform.position - var_301_12.position).y, (manager.ui.mainCamera.transform.position - var_301_12.position).z)
				var_301_12.localEulerAngles.z = 0
				var_301_12.localEulerAngles.x = 0
				var_301_12.localEulerAngles = var_301_12.localEulerAngles
			end

			local var_301_14 = arg_298_1.actors_["10058ui_story"]

			if 2 < arg_298_1.time_ and arg_298_1.time_ <= 2 + arg_301_0 and not isNil(var_301_14) and arg_298_1.var_.characterEffect10058ui_story == nil then
				arg_298_1.var_.characterEffect10058ui_story = var_301_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_301_15 = 0.200000002980232

			if 2 <= arg_298_1.time_ and arg_298_1.time_ < 2 + var_301_15 and not isNil(var_301_14) then
				if arg_298_1.var_.characterEffect10058ui_story and not isNil(var_301_14) then
					arg_298_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_298_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_298_1.time_ - 2) / var_301_15)
				end
			end

			if arg_298_1.time_ >= 2 + var_301_15 and arg_298_1.time_ < 2 + var_301_15 + arg_301_0 and not isNil(var_301_14) and arg_298_1.var_.characterEffect10058ui_story then
				arg_298_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_298_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 then
				arg_298_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_301_18 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_298_1.bgmTxt_.text ~= var_301_18 and arg_298_1.bgmTxt_.text ~= "" then
						if arg_298_1.bgmTxt2_.text ~= "" then
							arg_298_1.bgmTxt_.text = arg_298_1.bgmTxt2_.text
						end

						arg_298_1.bgmTxt2_.text = var_301_18

						arg_298_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_298_1.bgmTxt_.text = var_301_18
						arg_298_1.bgmTxt2_.text = var_301_18
					end

					if arg_298_1.bgmTimer then
						arg_298_1.bgmTimer:Stop()

						arg_298_1.bgmTimer = nil
					end

					if arg_298_1.settingData.show_music_name == 1 then
						arg_298_1.musicController:SetSelectedState("show")
						arg_298_1.musicAnimator_:Play("open", 0, 0)

						if arg_298_1.settingData.music_time ~= 0 then
							arg_298_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_298_1.settingData.music_time), function()
								if arg_298_1 == nil or isNil(arg_298_1.bgmTxt_) then
									return
								end

								arg_298_1.musicController:SetSelectedState("hide")
								arg_298_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.466666666666667 < arg_298_1.time_ and arg_298_1.time_ <= 0.466666666666667 + arg_301_0 then
				arg_298_1:AudioAction("play", "music", "bgm_story_v1_qiaolin", "bgm_story_v1_qiaolin", "bgm_story_v1_qiaolin.awb")

				local var_301_21 = manager.audio:GetAudioName("bgm_story_v1_qiaolin", "bgm_story_v1_qiaolin")

				if "" ~= "" then
					if arg_298_1.bgmTxt_.text ~= var_301_21 and arg_298_1.bgmTxt_.text ~= "" then
						if arg_298_1.bgmTxt2_.text ~= "" then
							arg_298_1.bgmTxt_.text = arg_298_1.bgmTxt2_.text
						end

						arg_298_1.bgmTxt2_.text = var_301_21

						arg_298_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_298_1.bgmTxt_.text = var_301_21
						arg_298_1.bgmTxt2_.text = var_301_21
					end

					if arg_298_1.bgmTimer then
						arg_298_1.bgmTimer:Stop()

						arg_298_1.bgmTimer = nil
					end

					if arg_298_1.settingData.show_music_name == 1 then
						arg_298_1.musicController:SetSelectedState("show")
						arg_298_1.musicAnimator_:Play("open", 0, 0)

						if arg_298_1.settingData.music_time ~= 0 then
							arg_298_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_298_1.settingData.music_time), function()
								if arg_298_1 == nil or isNil(arg_298_1.bgmTxt_) then
									return
								end

								arg_298_1.musicController:SetSelectedState("hide")
								arg_298_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 4 < arg_298_1.time_ and arg_298_1.time_ <= 4 + arg_301_0 then
				arg_298_1:AudioAction("play", "effect", "se_story_130", "se_story_130_robot", "")
			end

			if arg_298_1.frameCnt_ <= 1 then
				arg_298_1.dialog_:SetActive(false)
			end

			local var_301_23 = 4
			local var_301_24 = 0.15

			if 4 < arg_298_1.time_ and arg_298_1.time_ <= var_301_23 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0

				arg_298_1.dialog_:SetActive(true)

				arg_298_1.dialogCg_.alpha = 0

				local var_301_25 = LeanTween.value(arg_298_1.dialog_, 0, 1, 0.3)

				var_301_25:setOnUpdate(LuaHelper.FloatAction(function(arg_304_0)
					arg_298_1.dialogCg_.alpha = arg_304_0
				end))
				var_301_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_298_1.dialog_)
					var_301_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_298_1.duration_ = arg_298_1.duration_ + 0.3

				SetActive(arg_298_1.leftNameGo_, true)

				arg_298_1.leftNameTxt_.text = arg_298_1:FormatText(StoryNameCfg[674].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, true)
				arg_298_1.iconController_:SetSelectedState("hero")

				arg_298_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2022")

				arg_298_1.callingController_:SetSelectedState("normal")

				arg_298_1.keyicon_.color = Color.New(1, 1, 1)
				arg_298_1.icon_.color = Color.New(1, 1, 1)

				local var_301_26 = arg_298_1:GetWordFromCfg(411051071)
				local var_301_27 = arg_298_1:FormatText(var_301_26.content)

				arg_298_1.text_.text = var_301_27

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_29 = 6 <= 0 and var_301_24 or var_301_24 * (utf8.len(var_301_27) / 6)

				if (6 <= 0 and var_301_24 or var_301_24 * (utf8.len(var_301_27) / 6)) > 0 and var_301_24 < var_301_29 then
					arg_298_1.talkMaxDuration = var_301_29
					var_301_23 = var_301_23 + 0.3

					if var_301_29 + var_301_23 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_29 + var_301_23
					end
				end

				arg_298_1.text_.text = var_301_27
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051071", "story_v_out_411051.awb") ~= 0 then
					local var_301_30 = manager.audio:GetVoiceLength("story_v_out_411051", "411051071", "story_v_out_411051.awb") / 1000

					if var_301_30 + var_301_23 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_30 + var_301_23
					end

					if var_301_26.prefab_name ~= "" and arg_298_1.actors_[var_301_26.prefab_name] ~= nil then
						local var_301_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_298_1.actors_[var_301_26.prefab_name].transform, "story_v_out_411051", "411051071", "story_v_out_411051.awb")

						arg_298_1:RecordAudio("411051071", var_301_31)
						arg_298_1:RecordAudio("411051071", var_301_31)
					else
						arg_298_1:AudioAction("play", "voice", "story_v_out_411051", "411051071", "story_v_out_411051.awb")
					end

					arg_298_1:RecordHistoryTalkVoice("story_v_out_411051", "411051071", "story_v_out_411051.awb")
				end

				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_32 = var_301_23 + 0.3
			local var_301_33 = math.max(var_301_24, arg_298_1.talkMaxDuration)

			if var_301_23 + 0.3 <= arg_298_1.time_ and arg_298_1.time_ < var_301_32 + var_301_33 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_32) / var_301_33

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_32 + var_301_33 and arg_298_1.time_ < var_301_32 + var_301_33 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_298_1:InitPlayNodeList()
	end,
	Play411051072 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 411051072
		arg_306_1.duration_ = 5

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play411051073(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = 0.825

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, false)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_1 = arg_306_1:FormatText(arg_306_1:GetWordFromCfg(411051072).content)

				arg_306_1.text_.text = var_309_1

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_3 = 32 <= 0 and var_309_0 or var_309_0 * (utf8.len(var_309_1) / 32)

				if (32 <= 0 and var_309_0 or var_309_0 * (utf8.len(var_309_1) / 32)) > 0 and var_309_0 < var_309_3 then
					arg_306_1.talkMaxDuration = var_309_3

					if var_309_3 + 0 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_3 + 0
					end
				end

				arg_306_1.text_.text = var_309_1
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)
				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_4 = math.max(var_309_0, arg_306_1.talkMaxDuration)

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_4 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - 0) / var_309_4

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= 0 + var_309_4 and arg_306_1.time_ < 0 + var_309_4 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play411051073 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 411051073
		arg_310_1.duration_ = 6.9

		local var_310_0 = {
			zh = 3.866,
			ja = 6.9
		}
		local var_310_1 = manager.audio:GetLocalizationFlag()

		if var_310_0[var_310_1] ~= nil then
			arg_310_1.duration_ = var_310_0[var_310_1]
		end

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play411051074(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			local var_313_0 = 0.35

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				arg_310_1.leftNameTxt_.text = arg_310_1:FormatText(StoryNameCfg[674].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, true)
				arg_310_1.iconController_:SetSelectedState("hero")

				arg_310_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2022")

				arg_310_1.callingController_:SetSelectedState("normal")

				arg_310_1.keyicon_.color = Color.New(1, 1, 1)
				arg_310_1.icon_.color = Color.New(1, 1, 1)

				local var_313_1 = arg_310_1:GetWordFromCfg(411051073)
				local var_313_2 = arg_310_1:FormatText(var_313_1.content)

				arg_310_1.text_.text = var_313_2

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_4 = 14 <= 0 and var_313_0 or var_313_0 * (utf8.len(var_313_2) / 14)

				if (14 <= 0 and var_313_0 or var_313_0 * (utf8.len(var_313_2) / 14)) > 0 and var_313_0 < var_313_4 then
					arg_310_1.talkMaxDuration = var_313_4

					if var_313_4 + 0 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_4 + 0
					end
				end

				arg_310_1.text_.text = var_313_2
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051073", "story_v_out_411051.awb") ~= 0 then
					local var_313_5 = manager.audio:GetVoiceLength("story_v_out_411051", "411051073", "story_v_out_411051.awb") / 1000

					if var_313_5 + 0 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_5 + 0
					end

					if var_313_1.prefab_name ~= "" and arg_310_1.actors_[var_313_1.prefab_name] ~= nil then
						local var_313_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_310_1.actors_[var_313_1.prefab_name].transform, "story_v_out_411051", "411051073", "story_v_out_411051.awb")

						arg_310_1:RecordAudio("411051073", var_313_6)
						arg_310_1:RecordAudio("411051073", var_313_6)
					else
						arg_310_1:AudioAction("play", "voice", "story_v_out_411051", "411051073", "story_v_out_411051.awb")
					end

					arg_310_1:RecordHistoryTalkVoice("story_v_out_411051", "411051073", "story_v_out_411051.awb")
				end

				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_7 = math.max(var_313_0, arg_310_1.talkMaxDuration)

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_7 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - 0) / var_313_7

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= 0 + var_313_7 and arg_310_1.time_ < 0 + var_313_7 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play411051074 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 411051074
		arg_314_1.duration_ = 2.5

		local var_314_0 = {
			zh = 2.5,
			ja = 1.833
		}
		local var_314_1 = manager.audio:GetLocalizationFlag()

		if var_314_0[var_314_1] ~= nil then
			arg_314_1.duration_ = var_314_0[var_314_1]
		end

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play411051075(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			local var_317_0 = 0.075

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				arg_314_1.leftNameTxt_.text = arg_314_1:FormatText(StoryNameCfg[675].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, true)
				arg_314_1.iconController_:SetSelectedState("hero")

				arg_314_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_314_1.callingController_:SetSelectedState("normal")

				arg_314_1.keyicon_.color = Color.New(1, 1, 1)
				arg_314_1.icon_.color = Color.New(1, 1, 1)

				local var_317_1 = arg_314_1:GetWordFromCfg(411051074)
				local var_317_2 = arg_314_1:FormatText(var_317_1.content)

				arg_314_1.text_.text = var_317_2

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_4 = 3 <= 0 and var_317_0 or var_317_0 * (utf8.len(var_317_2) / 3)

				if (3 <= 0 and var_317_0 or var_317_0 * (utf8.len(var_317_2) / 3)) > 0 and var_317_0 < var_317_4 then
					arg_314_1.talkMaxDuration = var_317_4

					if var_317_4 + 0 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_4 + 0
					end
				end

				arg_314_1.text_.text = var_317_2
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051074", "story_v_out_411051.awb") ~= 0 then
					local var_317_5 = manager.audio:GetVoiceLength("story_v_out_411051", "411051074", "story_v_out_411051.awb") / 1000

					if var_317_5 + 0 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_5 + 0
					end

					if var_317_1.prefab_name ~= "" and arg_314_1.actors_[var_317_1.prefab_name] ~= nil then
						local var_317_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_314_1.actors_[var_317_1.prefab_name].transform, "story_v_out_411051", "411051074", "story_v_out_411051.awb")

						arg_314_1:RecordAudio("411051074", var_317_6)
						arg_314_1:RecordAudio("411051074", var_317_6)
					else
						arg_314_1:AudioAction("play", "voice", "story_v_out_411051", "411051074", "story_v_out_411051.awb")
					end

					arg_314_1:RecordHistoryTalkVoice("story_v_out_411051", "411051074", "story_v_out_411051.awb")
				end

				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_7 = math.max(var_317_0, arg_314_1.talkMaxDuration)

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_7 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - 0) / var_317_7

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= 0 + var_317_7 and arg_314_1.time_ < 0 + var_317_7 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play411051075 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 411051075
		arg_318_1.duration_ = 5

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play411051076(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = 1.65

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, false)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_1 = arg_318_1:FormatText(arg_318_1:GetWordFromCfg(411051075).content)

				arg_318_1.text_.text = var_321_1

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_3 = 66 <= 0 and var_321_0 or var_321_0 * (utf8.len(var_321_1) / 66)

				if (66 <= 0 and var_321_0 or var_321_0 * (utf8.len(var_321_1) / 66)) > 0 and var_321_0 < var_321_3 then
					arg_318_1.talkMaxDuration = var_321_3

					if var_321_3 + 0 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_3 + 0
					end
				end

				arg_318_1.text_.text = var_321_1
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)
				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_4 = math.max(var_321_0, arg_318_1.talkMaxDuration)

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_4 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - 0) / var_321_4

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= 0 + var_321_4 and arg_318_1.time_ < 0 + var_321_4 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play411051076 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 411051076
		arg_322_1.duration_ = 5

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play411051077(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = 1.175

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, false)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_1 = arg_322_1:FormatText(arg_322_1:GetWordFromCfg(411051076).content)

				arg_322_1.text_.text = var_325_1

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_3 = 47 <= 0 and var_325_0 or var_325_0 * (utf8.len(var_325_1) / 47)

				if (47 <= 0 and var_325_0 or var_325_0 * (utf8.len(var_325_1) / 47)) > 0 and var_325_0 < var_325_3 then
					arg_322_1.talkMaxDuration = var_325_3

					if var_325_3 + 0 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_3 + 0
					end
				end

				arg_322_1.text_.text = var_325_1
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)
				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_4 = math.max(var_325_0, arg_322_1.talkMaxDuration)

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_4 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - 0) / var_325_4

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= 0 + var_325_4 and arg_322_1.time_ < 0 + var_325_4 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play411051077 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 411051077
		arg_326_1.duration_ = 11

		local var_326_0 = {
			zh = 10.733,
			ja = 11
		}
		local var_326_1 = manager.audio:GetLocalizationFlag()

		if var_326_0[var_326_1] ~= nil then
			arg_326_1.duration_ = var_326_0[var_326_1]
		end

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play411051078(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = 0.925

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				arg_326_1.leftNameTxt_.text = arg_326_1:FormatText(StoryNameCfg[675].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, true)
				arg_326_1.iconController_:SetSelectedState("hero")

				arg_326_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_326_1.callingController_:SetSelectedState("normal")

				arg_326_1.keyicon_.color = Color.New(1, 1, 1)
				arg_326_1.icon_.color = Color.New(1, 1, 1)

				local var_329_1 = arg_326_1:GetWordFromCfg(411051077)
				local var_329_2 = arg_326_1:FormatText(var_329_1.content)

				arg_326_1.text_.text = var_329_2

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_4 = 37 <= 0 and var_329_0 or var_329_0 * (utf8.len(var_329_2) / 37)

				if (37 <= 0 and var_329_0 or var_329_0 * (utf8.len(var_329_2) / 37)) > 0 and var_329_0 < var_329_4 then
					arg_326_1.talkMaxDuration = var_329_4

					if var_329_4 + 0 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_4 + 0
					end
				end

				arg_326_1.text_.text = var_329_2
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051077", "story_v_out_411051.awb") ~= 0 then
					local var_329_5 = manager.audio:GetVoiceLength("story_v_out_411051", "411051077", "story_v_out_411051.awb") / 1000

					if var_329_5 + 0 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_5 + 0
					end

					if var_329_1.prefab_name ~= "" and arg_326_1.actors_[var_329_1.prefab_name] ~= nil then
						local var_329_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_326_1.actors_[var_329_1.prefab_name].transform, "story_v_out_411051", "411051077", "story_v_out_411051.awb")

						arg_326_1:RecordAudio("411051077", var_329_6)
						arg_326_1:RecordAudio("411051077", var_329_6)
					else
						arg_326_1:AudioAction("play", "voice", "story_v_out_411051", "411051077", "story_v_out_411051.awb")
					end

					arg_326_1:RecordHistoryTalkVoice("story_v_out_411051", "411051077", "story_v_out_411051.awb")
				end

				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_7 = math.max(var_329_0, arg_326_1.talkMaxDuration)

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_7 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - 0) / var_329_7

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= 0 + var_329_7 and arg_326_1.time_ < 0 + var_329_7 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play411051078 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 411051078
		arg_330_1.duration_ = 5

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play411051079(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = 0.975

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, false)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_1 = arg_330_1:FormatText(arg_330_1:GetWordFromCfg(411051078).content)

				arg_330_1.text_.text = var_333_1

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_3 = 39 <= 0 and var_333_0 or var_333_0 * (utf8.len(var_333_1) / 39)

				if (39 <= 0 and var_333_0 or var_333_0 * (utf8.len(var_333_1) / 39)) > 0 and var_333_0 < var_333_3 then
					arg_330_1.talkMaxDuration = var_333_3

					if var_333_3 + 0 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_3 + 0
					end
				end

				arg_330_1.text_.text = var_333_1
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)
				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_4 = math.max(var_333_0, arg_330_1.talkMaxDuration)

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_4 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - 0) / var_333_4

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= 0 + var_333_4 and arg_330_1.time_ < 0 + var_333_4 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play411051079 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 411051079
		arg_334_1.duration_ = 5.27

		local var_334_0 = {
			zh = 3.666,
			ja = 5.266
		}
		local var_334_1 = manager.audio:GetLocalizationFlag()

		if var_334_0[var_334_1] ~= nil then
			arg_334_1.duration_ = var_334_0[var_334_1]
		end

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play411051080(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			if arg_334_1.actors_["1095ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1095ui_story"))) then
				local var_337_0 = Object.Instantiate(Asset.Load("Char/" .. "1095ui_story"), arg_334_1.stage_.transform)

				var_337_0.name = "1095ui_story"
				var_337_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_334_1.actors_["1095ui_story"] = var_337_0

				local var_337_1 = var_337_0:GetComponentInChildren(typeof(CharacterEffect))

				var_337_1.enabled = true

				local var_337_2 = GameObjectTools.GetOrAddComponent(var_337_0, typeof(DynamicBoneHelper))

				if var_337_2 then
					var_337_2:EnableDynamicBone(false)
				end

				arg_334_1:ShowWeapon(var_337_1.transform, false)

				arg_334_1.var_["1095ui_story" .. "Animator"] = var_337_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_334_1.var_["1095ui_story" .. "Animator"].applyRootMotion = true
				arg_334_1.var_["1095ui_story" .. "LipSync"] = var_337_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_337_3 = arg_334_1.actors_["1095ui_story"].transform

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1.var_.moveOldPos1095ui_story = var_337_3.localPosition
			end

			local var_337_4 = 0.001

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_4 then
				var_337_3.localPosition = Vector3.Lerp(arg_334_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_334_1.time_ - 0) / var_337_4)
				var_337_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_337_3.position).x, (manager.ui.mainCamera.transform.position - var_337_3.position).y, (manager.ui.mainCamera.transform.position - var_337_3.position).z)
				var_337_3.localEulerAngles.z = 0
				var_337_3.localEulerAngles.x = 0
				var_337_3.localEulerAngles = var_337_3.localEulerAngles
			end

			if arg_334_1.time_ >= 0 + var_337_4 and arg_334_1.time_ < 0 + var_337_4 + arg_337_0 then
				var_337_3.localPosition = Vector3.New(0, -0.98, -6.1)
				var_337_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_337_3.position).x, (manager.ui.mainCamera.transform.position - var_337_3.position).y, (manager.ui.mainCamera.transform.position - var_337_3.position).z)
				var_337_3.localEulerAngles.z = 0
				var_337_3.localEulerAngles.x = 0
				var_337_3.localEulerAngles = var_337_3.localEulerAngles
			end

			local var_337_5 = arg_334_1.actors_["1095ui_story"]

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 and not isNil(var_337_5) and arg_334_1.var_.characterEffect1095ui_story == nil then
				arg_334_1.var_.characterEffect1095ui_story = var_337_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_337_6 = 0.200000002980232

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_6 and not isNil(var_337_5) then
				if arg_334_1.var_.characterEffect1095ui_story and not isNil(var_337_5) then
					arg_334_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_334_1.time_ >= 0 + var_337_6 and arg_334_1.time_ < 0 + var_337_6 + arg_337_0 and not isNil(var_337_5) and arg_334_1.var_.characterEffect1095ui_story then
				arg_334_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_337_8 = 0
			local var_337_9 = 0.375

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= var_337_8 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				arg_334_1.leftNameTxt_.text = arg_334_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_10 = arg_334_1:GetWordFromCfg(411051079)
				local var_337_11 = arg_334_1:FormatText(var_337_10.content)

				arg_334_1.text_.text = var_337_11

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_13 = 15 <= 0 and var_337_9 or var_337_9 * (utf8.len(var_337_11) / 15)

				if (15 <= 0 and var_337_9 or var_337_9 * (utf8.len(var_337_11) / 15)) > 0 and var_337_9 < var_337_13 then
					arg_334_1.talkMaxDuration = var_337_13

					if var_337_13 + var_337_8 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_13 + var_337_8
					end
				end

				arg_334_1.text_.text = var_337_11
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051079", "story_v_out_411051.awb") ~= 0 then
					local var_337_14 = manager.audio:GetVoiceLength("story_v_out_411051", "411051079", "story_v_out_411051.awb") / 1000

					if var_337_14 + var_337_8 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_14 + var_337_8
					end

					if var_337_10.prefab_name ~= "" and arg_334_1.actors_[var_337_10.prefab_name] ~= nil then
						local var_337_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_334_1.actors_[var_337_10.prefab_name].transform, "story_v_out_411051", "411051079", "story_v_out_411051.awb")

						arg_334_1:RecordAudio("411051079", var_337_15)
						arg_334_1:RecordAudio("411051079", var_337_15)
					else
						arg_334_1:AudioAction("play", "voice", "story_v_out_411051", "411051079", "story_v_out_411051.awb")
					end

					arg_334_1:RecordHistoryTalkVoice("story_v_out_411051", "411051079", "story_v_out_411051.awb")
				end

				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_16 = math.max(var_337_9, arg_334_1.talkMaxDuration)

			if var_337_8 <= arg_334_1.time_ and arg_334_1.time_ < var_337_8 + var_337_16 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_8) / var_337_16

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_8 + var_337_16 and arg_334_1.time_ < var_337_8 + var_337_16 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {
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

		arg_334_1:InitPlayNodeList()
	end,
	Play411051080 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 411051080
		arg_338_1.duration_ = 3.33

		local var_338_0 = {
			zh = 3.333,
			ja = 1.6
		}
		local var_338_1 = manager.audio:GetLocalizationFlag()

		if var_338_0[var_338_1] ~= nil then
			arg_338_1.duration_ = var_338_0[var_338_1]
		end

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play411051081(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 and not isNil(arg_338_1.actors_["1095ui_story"]) and arg_338_1.var_.characterEffect1095ui_story == nil then
				arg_338_1.var_.characterEffect1095ui_story = arg_338_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_341_0 = 0.200000002980232

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_0 and not isNil(arg_338_1.actors_["1095ui_story"]) then
				if arg_338_1.var_.characterEffect1095ui_story and not isNil(arg_338_1.actors_["1095ui_story"]) then
					arg_338_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_338_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_338_1.time_ - 0) / var_341_0)
				end
			end

			if arg_338_1.time_ >= 0 + var_341_0 and arg_338_1.time_ < 0 + var_341_0 + arg_341_0 and not isNil(arg_338_1.actors_["1095ui_story"]) and arg_338_1.var_.characterEffect1095ui_story then
				arg_338_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_338_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_341_1 = 0
			local var_341_2 = 0.225

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= var_341_1 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				arg_338_1.leftNameTxt_.text = arg_338_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, true)
				arg_338_1.iconController_:SetSelectedState("hero")

				arg_338_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_338_1.callingController_:SetSelectedState("normal")

				arg_338_1.keyicon_.color = Color.New(1, 1, 1)
				arg_338_1.icon_.color = Color.New(1, 1, 1)

				local var_341_3 = arg_338_1:GetWordFromCfg(411051080)
				local var_341_4 = arg_338_1:FormatText(var_341_3.content)

				arg_338_1.text_.text = var_341_4

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_6 = 9 <= 0 and var_341_2 or var_341_2 * (utf8.len(var_341_4) / 9)

				if (9 <= 0 and var_341_2 or var_341_2 * (utf8.len(var_341_4) / 9)) > 0 and var_341_2 < var_341_6 then
					arg_338_1.talkMaxDuration = var_341_6

					if var_341_6 + var_341_1 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_6 + var_341_1
					end
				end

				arg_338_1.text_.text = var_341_4
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051080", "story_v_out_411051.awb") ~= 0 then
					local var_341_7 = manager.audio:GetVoiceLength("story_v_out_411051", "411051080", "story_v_out_411051.awb") / 1000

					if var_341_7 + var_341_1 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_7 + var_341_1
					end

					if var_341_3.prefab_name ~= "" and arg_338_1.actors_[var_341_3.prefab_name] ~= nil then
						local var_341_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_338_1.actors_[var_341_3.prefab_name].transform, "story_v_out_411051", "411051080", "story_v_out_411051.awb")

						arg_338_1:RecordAudio("411051080", var_341_8)
						arg_338_1:RecordAudio("411051080", var_341_8)
					else
						arg_338_1:AudioAction("play", "voice", "story_v_out_411051", "411051080", "story_v_out_411051.awb")
					end

					arg_338_1:RecordHistoryTalkVoice("story_v_out_411051", "411051080", "story_v_out_411051.awb")
				end

				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_9 = math.max(var_341_2, arg_338_1.talkMaxDuration)

			if var_341_1 <= arg_338_1.time_ and arg_338_1.time_ < var_341_1 + var_341_9 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_1) / var_341_9

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_1 + var_341_9 and arg_338_1.time_ < var_341_1 + var_341_9 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {}

		arg_338_1:InitPlayNodeList()
	end,
	Play411051081 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 411051081
		arg_342_1.duration_ = 4

		local var_342_0 = {
			zh = 3.366,
			ja = 4
		}
		local var_342_1 = manager.audio:GetLocalizationFlag()

		if var_342_0[var_342_1] ~= nil then
			arg_342_1.duration_ = var_342_0[var_342_1]
		end

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play411051082(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 and not isNil(arg_342_1.actors_["1095ui_story"]) and arg_342_1.var_.characterEffect1095ui_story == nil then
				arg_342_1.var_.characterEffect1095ui_story = arg_342_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_345_0 = 0.200000002980232

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_0 and not isNil(arg_342_1.actors_["1095ui_story"]) then
				if arg_342_1.var_.characterEffect1095ui_story and not isNil(arg_342_1.actors_["1095ui_story"]) then
					arg_342_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_342_1.time_ >= 0 + var_345_0 and arg_342_1.time_ < 0 + var_345_0 + arg_345_0 and not isNil(arg_342_1.actors_["1095ui_story"]) and arg_342_1.var_.characterEffect1095ui_story then
				arg_342_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_345_2 = 0
			local var_345_3 = 0.4

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= var_345_2 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				arg_342_1.leftNameTxt_.text = arg_342_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, false)
				arg_342_1.callingController_:SetSelectedState("normal")

				local var_345_4 = arg_342_1:GetWordFromCfg(411051081)
				local var_345_5 = arg_342_1:FormatText(var_345_4.content)

				arg_342_1.text_.text = var_345_5

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_7 = 16 <= 0 and var_345_3 or var_345_3 * (utf8.len(var_345_5) / 16)

				if (16 <= 0 and var_345_3 or var_345_3 * (utf8.len(var_345_5) / 16)) > 0 and var_345_3 < var_345_7 then
					arg_342_1.talkMaxDuration = var_345_7

					if var_345_7 + var_345_2 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_7 + var_345_2
					end
				end

				arg_342_1.text_.text = var_345_5
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051081", "story_v_out_411051.awb") ~= 0 then
					local var_345_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051081", "story_v_out_411051.awb") / 1000

					if var_345_8 + var_345_2 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_8 + var_345_2
					end

					if var_345_4.prefab_name ~= "" and arg_342_1.actors_[var_345_4.prefab_name] ~= nil then
						local var_345_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_342_1.actors_[var_345_4.prefab_name].transform, "story_v_out_411051", "411051081", "story_v_out_411051.awb")

						arg_342_1:RecordAudio("411051081", var_345_9)
						arg_342_1:RecordAudio("411051081", var_345_9)
					else
						arg_342_1:AudioAction("play", "voice", "story_v_out_411051", "411051081", "story_v_out_411051.awb")
					end

					arg_342_1:RecordHistoryTalkVoice("story_v_out_411051", "411051081", "story_v_out_411051.awb")
				end

				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_10 = math.max(var_345_3, arg_342_1.talkMaxDuration)

			if var_345_2 <= arg_342_1.time_ and arg_342_1.time_ < var_345_2 + var_345_10 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_2) / var_345_10

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_2 + var_345_10 and arg_342_1.time_ < var_345_2 + var_345_10 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play411051082 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 411051082
		arg_346_1.duration_ = 5

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play411051083(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 and not isNil(arg_346_1.actors_["1095ui_story"]) and arg_346_1.var_.characterEffect1095ui_story == nil then
				arg_346_1.var_.characterEffect1095ui_story = arg_346_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_349_0 = 0.200000002980232

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_0 and not isNil(arg_346_1.actors_["1095ui_story"]) then
				if arg_346_1.var_.characterEffect1095ui_story and not isNil(arg_346_1.actors_["1095ui_story"]) then
					arg_346_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_346_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_346_1.time_ - 0) / var_349_0)
				end
			end

			if arg_346_1.time_ >= 0 + var_349_0 and arg_346_1.time_ < 0 + var_349_0 + arg_349_0 and not isNil(arg_346_1.actors_["1095ui_story"]) and arg_346_1.var_.characterEffect1095ui_story then
				arg_346_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_346_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_349_1 = 0
			local var_349_2 = 1.175

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= var_349_1 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, false)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_3 = arg_346_1:FormatText(arg_346_1:GetWordFromCfg(411051082).content)

				arg_346_1.text_.text = var_349_3

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_5 = 47 <= 0 and var_349_2 or var_349_2 * (utf8.len(var_349_3) / 47)

				if (47 <= 0 and var_349_2 or var_349_2 * (utf8.len(var_349_3) / 47)) > 0 and var_349_2 < var_349_5 then
					arg_346_1.talkMaxDuration = var_349_5

					if var_349_5 + var_349_1 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_5 + var_349_1
					end
				end

				arg_346_1.text_.text = var_349_3
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)
				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_6 = math.max(var_349_2, arg_346_1.talkMaxDuration)

			if var_349_1 <= arg_346_1.time_ and arg_346_1.time_ < var_349_1 + var_349_6 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_1) / var_349_6

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_1 + var_349_6 and arg_346_1.time_ < var_349_1 + var_349_6 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {}

		arg_346_1:InitPlayNodeList()
	end,
	Play411051083 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 411051083
		arg_350_1.duration_ = 2.17

		local var_350_0 = {
			zh = 1.3,
			ja = 2.166
		}
		local var_350_1 = manager.audio:GetLocalizationFlag()

		if var_350_0[var_350_1] ~= nil then
			arg_350_1.duration_ = var_350_0[var_350_1]
		end

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play411051084(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 and not isNil(arg_350_1.actors_["1095ui_story"]) and arg_350_1.var_.characterEffect1095ui_story == nil then
				arg_350_1.var_.characterEffect1095ui_story = arg_350_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_353_0 = 0.200000002980232

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_0 and not isNil(arg_350_1.actors_["1095ui_story"]) then
				if arg_350_1.var_.characterEffect1095ui_story and not isNil(arg_350_1.actors_["1095ui_story"]) then
					arg_350_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_350_1.time_ >= 0 + var_353_0 and arg_350_1.time_ < 0 + var_353_0 + arg_353_0 and not isNil(arg_350_1.actors_["1095ui_story"]) and arg_350_1.var_.characterEffect1095ui_story then
				arg_350_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_353_2 = 0
			local var_353_3 = 0.125

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= var_353_2 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				arg_350_1.leftNameTxt_.text = arg_350_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_350_1.leftNameTxt_.transform)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1.leftNameTxt_.text)
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_4 = arg_350_1:GetWordFromCfg(411051083)
				local var_353_5 = arg_350_1:FormatText(var_353_4.content)

				arg_350_1.text_.text = var_353_5

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_7 = 5 <= 0 and var_353_3 or var_353_3 * (utf8.len(var_353_5) / 5)

				if (5 <= 0 and var_353_3 or var_353_3 * (utf8.len(var_353_5) / 5)) > 0 and var_353_3 < var_353_7 then
					arg_350_1.talkMaxDuration = var_353_7

					if var_353_7 + var_353_2 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_7 + var_353_2
					end
				end

				arg_350_1.text_.text = var_353_5
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051083", "story_v_out_411051.awb") ~= 0 then
					local var_353_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051083", "story_v_out_411051.awb") / 1000

					if var_353_8 + var_353_2 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_8 + var_353_2
					end

					if var_353_4.prefab_name ~= "" and arg_350_1.actors_[var_353_4.prefab_name] ~= nil then
						local var_353_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_350_1.actors_[var_353_4.prefab_name].transform, "story_v_out_411051", "411051083", "story_v_out_411051.awb")

						arg_350_1:RecordAudio("411051083", var_353_9)
						arg_350_1:RecordAudio("411051083", var_353_9)
					else
						arg_350_1:AudioAction("play", "voice", "story_v_out_411051", "411051083", "story_v_out_411051.awb")
					end

					arg_350_1:RecordHistoryTalkVoice("story_v_out_411051", "411051083", "story_v_out_411051.awb")
				end

				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_10 = math.max(var_353_3, arg_350_1.talkMaxDuration)

			if var_353_2 <= arg_350_1.time_ and arg_350_1.time_ < var_353_2 + var_353_10 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_2) / var_353_10

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_2 + var_353_10 and arg_350_1.time_ < var_353_2 + var_353_10 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {}

		arg_350_1:InitPlayNodeList()
	end,
	Play411051084 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 411051084
		arg_354_1.duration_ = 6.57

		local var_354_0 = {
			zh = 5.166,
			ja = 6.566
		}
		local var_354_1 = manager.audio:GetLocalizationFlag()

		if var_354_0[var_354_1] ~= nil then
			arg_354_1.duration_ = var_354_0[var_354_1]
		end

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play411051085(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			local var_357_0 = 0.625

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				arg_354_1.leftNameTxt_.text = arg_354_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, true)
				arg_354_1.iconController_:SetSelectedState("hero")

				arg_354_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_354_1.callingController_:SetSelectedState("normal")

				arg_354_1.keyicon_.color = Color.New(1, 1, 1)
				arg_354_1.icon_.color = Color.New(1, 1, 1)

				local var_357_1 = arg_354_1:GetWordFromCfg(411051084)
				local var_357_2 = arg_354_1:FormatText(var_357_1.content)

				arg_354_1.text_.text = var_357_2

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_4 = 25 <= 0 and var_357_0 or var_357_0 * (utf8.len(var_357_2) / 25)

				if (25 <= 0 and var_357_0 or var_357_0 * (utf8.len(var_357_2) / 25)) > 0 and var_357_0 < var_357_4 then
					arg_354_1.talkMaxDuration = var_357_4

					if var_357_4 + 0 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_4 + 0
					end
				end

				arg_354_1.text_.text = var_357_2
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051084", "story_v_out_411051.awb") ~= 0 then
					local var_357_5 = manager.audio:GetVoiceLength("story_v_out_411051", "411051084", "story_v_out_411051.awb") / 1000

					if var_357_5 + 0 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_5 + 0
					end

					if var_357_1.prefab_name ~= "" and arg_354_1.actors_[var_357_1.prefab_name] ~= nil then
						local var_357_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_354_1.actors_[var_357_1.prefab_name].transform, "story_v_out_411051", "411051084", "story_v_out_411051.awb")

						arg_354_1:RecordAudio("411051084", var_357_6)
						arg_354_1:RecordAudio("411051084", var_357_6)
					else
						arg_354_1:AudioAction("play", "voice", "story_v_out_411051", "411051084", "story_v_out_411051.awb")
					end

					arg_354_1:RecordHistoryTalkVoice("story_v_out_411051", "411051084", "story_v_out_411051.awb")
				end

				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_7 = math.max(var_357_0, arg_354_1.talkMaxDuration)

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_7 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - 0) / var_357_7

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= 0 + var_357_7 and arg_354_1.time_ < 0 + var_357_7 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {}

		arg_354_1:InitPlayNodeList()
	end,
	Play411051085 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 411051085
		arg_358_1.duration_ = 6.53

		local var_358_0 = {
			zh = 5.933,
			ja = 6.533
		}
		local var_358_1 = manager.audio:GetLocalizationFlag()

		if var_358_0[var_358_1] ~= nil then
			arg_358_1.duration_ = var_358_0[var_358_1]
		end

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play411051086(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 and not isNil(arg_358_1.actors_["1095ui_story"]) and arg_358_1.var_.characterEffect1095ui_story == nil then
				arg_358_1.var_.characterEffect1095ui_story = arg_358_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_361_0 = 0.200000002980232

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_0 and not isNil(arg_358_1.actors_["1095ui_story"]) then
				if arg_358_1.var_.characterEffect1095ui_story and not isNil(arg_358_1.actors_["1095ui_story"]) then
					arg_358_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_358_1.time_ >= 0 + var_361_0 and arg_358_1.time_ < 0 + var_361_0 + arg_361_0 and not isNil(arg_358_1.actors_["1095ui_story"]) and arg_358_1.var_.characterEffect1095ui_story then
				arg_358_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_361_2 = 0
			local var_361_3 = 0.7

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= var_361_2 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, true)

				arg_358_1.leftNameTxt_.text = arg_358_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, false)
				arg_358_1.callingController_:SetSelectedState("normal")

				local var_361_4 = arg_358_1:GetWordFromCfg(411051085)
				local var_361_5 = arg_358_1:FormatText(var_361_4.content)

				arg_358_1.text_.text = var_361_5

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_7 = 28 <= 0 and var_361_3 or var_361_3 * (utf8.len(var_361_5) / 28)

				if (28 <= 0 and var_361_3 or var_361_3 * (utf8.len(var_361_5) / 28)) > 0 and var_361_3 < var_361_7 then
					arg_358_1.talkMaxDuration = var_361_7

					if var_361_7 + var_361_2 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_7 + var_361_2
					end
				end

				arg_358_1.text_.text = var_361_5
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051085", "story_v_out_411051.awb") ~= 0 then
					local var_361_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051085", "story_v_out_411051.awb") / 1000

					if var_361_8 + var_361_2 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_8 + var_361_2
					end

					if var_361_4.prefab_name ~= "" and arg_358_1.actors_[var_361_4.prefab_name] ~= nil then
						local var_361_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_358_1.actors_[var_361_4.prefab_name].transform, "story_v_out_411051", "411051085", "story_v_out_411051.awb")

						arg_358_1:RecordAudio("411051085", var_361_9)
						arg_358_1:RecordAudio("411051085", var_361_9)
					else
						arg_358_1:AudioAction("play", "voice", "story_v_out_411051", "411051085", "story_v_out_411051.awb")
					end

					arg_358_1:RecordHistoryTalkVoice("story_v_out_411051", "411051085", "story_v_out_411051.awb")
				end

				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_10 = math.max(var_361_3, arg_358_1.talkMaxDuration)

			if var_361_2 <= arg_358_1.time_ and arg_358_1.time_ < var_361_2 + var_361_10 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_2) / var_361_10

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_2 + var_361_10 and arg_358_1.time_ < var_361_2 + var_361_10 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {}

		arg_358_1:InitPlayNodeList()
	end,
	Play411051086 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 411051086
		arg_362_1.duration_ = 5.3

		local var_362_0 = {
			zh = 5.3,
			ja = 5.1
		}
		local var_362_1 = manager.audio:GetLocalizationFlag()

		if var_362_0[var_362_1] ~= nil then
			arg_362_1.duration_ = var_362_0[var_362_1]
		end

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play411051087(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			local var_365_0 = 0.7

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				arg_362_1.leftNameTxt_.text = arg_362_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, false)
				arg_362_1.callingController_:SetSelectedState("normal")

				local var_365_1 = arg_362_1:GetWordFromCfg(411051086)
				local var_365_2 = arg_362_1:FormatText(var_365_1.content)

				arg_362_1.text_.text = var_365_2

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_4 = 28 <= 0 and var_365_0 or var_365_0 * (utf8.len(var_365_2) / 28)

				if (28 <= 0 and var_365_0 or var_365_0 * (utf8.len(var_365_2) / 28)) > 0 and var_365_0 < var_365_4 then
					arg_362_1.talkMaxDuration = var_365_4

					if var_365_4 + 0 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_4 + 0
					end
				end

				arg_362_1.text_.text = var_365_2
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051086", "story_v_out_411051.awb") ~= 0 then
					local var_365_5 = manager.audio:GetVoiceLength("story_v_out_411051", "411051086", "story_v_out_411051.awb") / 1000

					if var_365_5 + 0 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_5 + 0
					end

					if var_365_1.prefab_name ~= "" and arg_362_1.actors_[var_365_1.prefab_name] ~= nil then
						local var_365_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_362_1.actors_[var_365_1.prefab_name].transform, "story_v_out_411051", "411051086", "story_v_out_411051.awb")

						arg_362_1:RecordAudio("411051086", var_365_6)
						arg_362_1:RecordAudio("411051086", var_365_6)
					else
						arg_362_1:AudioAction("play", "voice", "story_v_out_411051", "411051086", "story_v_out_411051.awb")
					end

					arg_362_1:RecordHistoryTalkVoice("story_v_out_411051", "411051086", "story_v_out_411051.awb")
				end

				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_7 = math.max(var_365_0, arg_362_1.talkMaxDuration)

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_7 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - 0) / var_365_7

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= 0 + var_365_7 and arg_362_1.time_ < 0 + var_365_7 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {}

		arg_362_1:InitPlayNodeList()
	end,
	Play411051087 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 411051087
		arg_366_1.duration_ = 2.33

		local var_366_0 = {
			zh = 2.2,
			ja = 2.333
		}
		local var_366_1 = manager.audio:GetLocalizationFlag()

		if var_366_0[var_366_1] ~= nil then
			arg_366_1.duration_ = var_366_0[var_366_1]
		end

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play411051088(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 and not isNil(arg_366_1.actors_["1095ui_story"]) and arg_366_1.var_.characterEffect1095ui_story == nil then
				arg_366_1.var_.characterEffect1095ui_story = arg_366_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_369_0 = 0.200000002980232

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_0 and not isNil(arg_366_1.actors_["1095ui_story"]) then
				if arg_366_1.var_.characterEffect1095ui_story and not isNil(arg_366_1.actors_["1095ui_story"]) then
					arg_366_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_366_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_366_1.time_ - 0) / var_369_0)
				end
			end

			if arg_366_1.time_ >= 0 + var_369_0 and arg_366_1.time_ < 0 + var_369_0 + arg_369_0 and not isNil(arg_366_1.actors_["1095ui_story"]) and arg_366_1.var_.characterEffect1095ui_story then
				arg_366_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_366_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_369_1 = 0
			local var_369_2 = 0.15

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= var_369_1 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, true)

				arg_366_1.leftNameTxt_.text = arg_366_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_366_1.leftNameTxt_.transform)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1.leftNameTxt_.text)
				SetActive(arg_366_1.iconTrs_.gameObject, true)
				arg_366_1.iconController_:SetSelectedState("hero")

				arg_366_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_366_1.callingController_:SetSelectedState("normal")

				arg_366_1.keyicon_.color = Color.New(1, 1, 1)
				arg_366_1.icon_.color = Color.New(1, 1, 1)

				local var_369_3 = arg_366_1:GetWordFromCfg(411051087)
				local var_369_4 = arg_366_1:FormatText(var_369_3.content)

				arg_366_1.text_.text = var_369_4

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_6 = 6 <= 0 and var_369_2 or var_369_2 * (utf8.len(var_369_4) / 6)

				if (6 <= 0 and var_369_2 or var_369_2 * (utf8.len(var_369_4) / 6)) > 0 and var_369_2 < var_369_6 then
					arg_366_1.talkMaxDuration = var_369_6

					if var_369_6 + var_369_1 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_6 + var_369_1
					end
				end

				arg_366_1.text_.text = var_369_4
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051087", "story_v_out_411051.awb") ~= 0 then
					local var_369_7 = manager.audio:GetVoiceLength("story_v_out_411051", "411051087", "story_v_out_411051.awb") / 1000

					if var_369_7 + var_369_1 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_7 + var_369_1
					end

					if var_369_3.prefab_name ~= "" and arg_366_1.actors_[var_369_3.prefab_name] ~= nil then
						local var_369_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_366_1.actors_[var_369_3.prefab_name].transform, "story_v_out_411051", "411051087", "story_v_out_411051.awb")

						arg_366_1:RecordAudio("411051087", var_369_8)
						arg_366_1:RecordAudio("411051087", var_369_8)
					else
						arg_366_1:AudioAction("play", "voice", "story_v_out_411051", "411051087", "story_v_out_411051.awb")
					end

					arg_366_1:RecordHistoryTalkVoice("story_v_out_411051", "411051087", "story_v_out_411051.awb")
				end

				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_9 = math.max(var_369_2, arg_366_1.talkMaxDuration)

			if var_369_1 <= arg_366_1.time_ and arg_366_1.time_ < var_369_1 + var_369_9 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - var_369_1) / var_369_9

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= var_369_1 + var_369_9 and arg_366_1.time_ < var_369_1 + var_369_9 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {}

		arg_366_1:InitPlayNodeList()
	end,
	Play411051088 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 411051088
		arg_370_1.duration_ = 5

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play411051089(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 and not isNil(arg_370_1.actors_["1095ui_story"]) and arg_370_1.var_.characterEffect1095ui_story == nil then
				arg_370_1.var_.characterEffect1095ui_story = arg_370_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_373_0 = 0.200000002980232

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_0 and not isNil(arg_370_1.actors_["1095ui_story"]) then
				if arg_370_1.var_.characterEffect1095ui_story and not isNil(arg_370_1.actors_["1095ui_story"]) then
					arg_370_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_370_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_370_1.time_ - 0) / var_373_0)
				end
			end

			if arg_370_1.time_ >= 0 + var_373_0 and arg_370_1.time_ < 0 + var_373_0 + arg_373_0 and not isNil(arg_370_1.actors_["1095ui_story"]) and arg_370_1.var_.characterEffect1095ui_story then
				arg_370_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_370_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_373_1 = 0
			local var_373_2 = 0.825

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= var_373_1 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, false)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_370_1.iconTrs_.gameObject, false)
				arg_370_1.callingController_:SetSelectedState("normal")

				local var_373_3 = arg_370_1:FormatText(arg_370_1:GetWordFromCfg(411051088).content)

				arg_370_1.text_.text = var_373_3

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_5 = 33 <= 0 and var_373_2 or var_373_2 * (utf8.len(var_373_3) / 33)

				if (33 <= 0 and var_373_2 or var_373_2 * (utf8.len(var_373_3) / 33)) > 0 and var_373_2 < var_373_5 then
					arg_370_1.talkMaxDuration = var_373_5

					if var_373_5 + var_373_1 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_5 + var_373_1
					end
				end

				arg_370_1.text_.text = var_373_3
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)
				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_6 = math.max(var_373_2, arg_370_1.talkMaxDuration)

			if var_373_1 <= arg_370_1.time_ and arg_370_1.time_ < var_373_1 + var_373_6 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - var_373_1) / var_373_6

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= var_373_1 + var_373_6 and arg_370_1.time_ < var_373_1 + var_373_6 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {}

		arg_370_1:InitPlayNodeList()
	end,
	Play411051089 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 411051089
		arg_374_1.duration_ = 5.47

		local var_374_0 = {
			zh = 4.833,
			ja = 5.466
		}
		local var_374_1 = manager.audio:GetLocalizationFlag()

		if var_374_0[var_374_1] ~= nil then
			arg_374_1.duration_ = var_374_0[var_374_1]
		end

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play411051090(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			local var_377_0 = 0.575

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, true)

				arg_374_1.leftNameTxt_.text = arg_374_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, true)
				arg_374_1.iconController_:SetSelectedState("hero")

				arg_374_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_374_1.callingController_:SetSelectedState("normal")

				arg_374_1.keyicon_.color = Color.New(1, 1, 1)
				arg_374_1.icon_.color = Color.New(1, 1, 1)

				local var_377_1 = arg_374_1:GetWordFromCfg(411051089)
				local var_377_2 = arg_374_1:FormatText(var_377_1.content)

				arg_374_1.text_.text = var_377_2

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_4 = 23 <= 0 and var_377_0 or var_377_0 * (utf8.len(var_377_2) / 23)

				if (23 <= 0 and var_377_0 or var_377_0 * (utf8.len(var_377_2) / 23)) > 0 and var_377_0 < var_377_4 then
					arg_374_1.talkMaxDuration = var_377_4

					if var_377_4 + 0 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_4 + 0
					end
				end

				arg_374_1.text_.text = var_377_2
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051089", "story_v_out_411051.awb") ~= 0 then
					local var_377_5 = manager.audio:GetVoiceLength("story_v_out_411051", "411051089", "story_v_out_411051.awb") / 1000

					if var_377_5 + 0 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_5 + 0
					end

					if var_377_1.prefab_name ~= "" and arg_374_1.actors_[var_377_1.prefab_name] ~= nil then
						local var_377_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_374_1.actors_[var_377_1.prefab_name].transform, "story_v_out_411051", "411051089", "story_v_out_411051.awb")

						arg_374_1:RecordAudio("411051089", var_377_6)
						arg_374_1:RecordAudio("411051089", var_377_6)
					else
						arg_374_1:AudioAction("play", "voice", "story_v_out_411051", "411051089", "story_v_out_411051.awb")
					end

					arg_374_1:RecordHistoryTalkVoice("story_v_out_411051", "411051089", "story_v_out_411051.awb")
				end

				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_7 = math.max(var_377_0, arg_374_1.talkMaxDuration)

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_7 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - 0) / var_377_7

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= 0 + var_377_7 and arg_374_1.time_ < 0 + var_377_7 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {}

		arg_374_1:InitPlayNodeList()
	end,
	Play411051090 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 411051090
		arg_378_1.duration_ = 1.3

		local var_378_0 = {
			zh = 1.1,
			ja = 1.3
		}
		local var_378_1 = manager.audio:GetLocalizationFlag()

		if var_378_0[var_378_1] ~= nil then
			arg_378_1.duration_ = var_378_0[var_378_1]
		end

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play411051091(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 and not isNil(arg_378_1.actors_["1095ui_story"]) and arg_378_1.var_.characterEffect1095ui_story == nil then
				arg_378_1.var_.characterEffect1095ui_story = arg_378_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_381_0 = 0.200000002980232

			if 0 <= arg_378_1.time_ and arg_378_1.time_ < 0 + var_381_0 and not isNil(arg_378_1.actors_["1095ui_story"]) then
				if arg_378_1.var_.characterEffect1095ui_story and not isNil(arg_378_1.actors_["1095ui_story"]) then
					arg_378_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_378_1.time_ >= 0 + var_381_0 and arg_378_1.time_ < 0 + var_381_0 + arg_381_0 and not isNil(arg_378_1.actors_["1095ui_story"]) and arg_378_1.var_.characterEffect1095ui_story then
				arg_378_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_381_2 = 0
			local var_381_3 = 0.1

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= var_381_2 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, true)

				arg_378_1.leftNameTxt_.text = arg_378_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, false)
				arg_378_1.callingController_:SetSelectedState("normal")

				local var_381_4 = arg_378_1:GetWordFromCfg(411051090)
				local var_381_5 = arg_378_1:FormatText(var_381_4.content)

				arg_378_1.text_.text = var_381_5

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_7 = 4 <= 0 and var_381_3 or var_381_3 * (utf8.len(var_381_5) / 4)

				if (4 <= 0 and var_381_3 or var_381_3 * (utf8.len(var_381_5) / 4)) > 0 and var_381_3 < var_381_7 then
					arg_378_1.talkMaxDuration = var_381_7

					if var_381_7 + var_381_2 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_7 + var_381_2
					end
				end

				arg_378_1.text_.text = var_381_5
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051090", "story_v_out_411051.awb") ~= 0 then
					local var_381_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051090", "story_v_out_411051.awb") / 1000

					if var_381_8 + var_381_2 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_8 + var_381_2
					end

					if var_381_4.prefab_name ~= "" and arg_378_1.actors_[var_381_4.prefab_name] ~= nil then
						local var_381_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_378_1.actors_[var_381_4.prefab_name].transform, "story_v_out_411051", "411051090", "story_v_out_411051.awb")

						arg_378_1:RecordAudio("411051090", var_381_9)
						arg_378_1:RecordAudio("411051090", var_381_9)
					else
						arg_378_1:AudioAction("play", "voice", "story_v_out_411051", "411051090", "story_v_out_411051.awb")
					end

					arg_378_1:RecordHistoryTalkVoice("story_v_out_411051", "411051090", "story_v_out_411051.awb")
				end

				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_10 = math.max(var_381_3, arg_378_1.talkMaxDuration)

			if var_381_2 <= arg_378_1.time_ and arg_378_1.time_ < var_381_2 + var_381_10 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_2) / var_381_10

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_2 + var_381_10 and arg_378_1.time_ < var_381_2 + var_381_10 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {}

		arg_378_1:InitPlayNodeList()
	end,
	Play411051091 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 411051091
		arg_382_1.duration_ = 8.3

		local var_382_0 = {
			zh = 4.833,
			ja = 8.3
		}
		local var_382_1 = manager.audio:GetLocalizationFlag()

		if var_382_0[var_382_1] ~= nil then
			arg_382_1.duration_ = var_382_0[var_382_1]
		end

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play411051092(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 and not isNil(arg_382_1.actors_["1095ui_story"]) and arg_382_1.var_.characterEffect1095ui_story == nil then
				arg_382_1.var_.characterEffect1095ui_story = arg_382_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_385_0 = 0.200000002980232

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_0 and not isNil(arg_382_1.actors_["1095ui_story"]) then
				if arg_382_1.var_.characterEffect1095ui_story and not isNil(arg_382_1.actors_["1095ui_story"]) then
					arg_382_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_382_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_382_1.time_ - 0) / var_385_0)
				end
			end

			if arg_382_1.time_ >= 0 + var_385_0 and arg_382_1.time_ < 0 + var_385_0 + arg_385_0 and not isNil(arg_382_1.actors_["1095ui_story"]) and arg_382_1.var_.characterEffect1095ui_story then
				arg_382_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_382_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_385_1 = 0
			local var_385_2 = 0.575

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= var_385_1 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, true)

				arg_382_1.leftNameTxt_.text = arg_382_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_382_1.leftNameTxt_.transform)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1.leftNameTxt_.text)
				SetActive(arg_382_1.iconTrs_.gameObject, true)
				arg_382_1.iconController_:SetSelectedState("hero")

				arg_382_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_382_1.callingController_:SetSelectedState("normal")

				arg_382_1.keyicon_.color = Color.New(1, 1, 1)
				arg_382_1.icon_.color = Color.New(1, 1, 1)

				local var_385_3 = arg_382_1:GetWordFromCfg(411051091)
				local var_385_4 = arg_382_1:FormatText(var_385_3.content)

				arg_382_1.text_.text = var_385_4

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_6 = 23 <= 0 and var_385_2 or var_385_2 * (utf8.len(var_385_4) / 23)

				if (23 <= 0 and var_385_2 or var_385_2 * (utf8.len(var_385_4) / 23)) > 0 and var_385_2 < var_385_6 then
					arg_382_1.talkMaxDuration = var_385_6

					if var_385_6 + var_385_1 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_6 + var_385_1
					end
				end

				arg_382_1.text_.text = var_385_4
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051091", "story_v_out_411051.awb") ~= 0 then
					local var_385_7 = manager.audio:GetVoiceLength("story_v_out_411051", "411051091", "story_v_out_411051.awb") / 1000

					if var_385_7 + var_385_1 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_7 + var_385_1
					end

					if var_385_3.prefab_name ~= "" and arg_382_1.actors_[var_385_3.prefab_name] ~= nil then
						local var_385_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_382_1.actors_[var_385_3.prefab_name].transform, "story_v_out_411051", "411051091", "story_v_out_411051.awb")

						arg_382_1:RecordAudio("411051091", var_385_8)
						arg_382_1:RecordAudio("411051091", var_385_8)
					else
						arg_382_1:AudioAction("play", "voice", "story_v_out_411051", "411051091", "story_v_out_411051.awb")
					end

					arg_382_1:RecordHistoryTalkVoice("story_v_out_411051", "411051091", "story_v_out_411051.awb")
				end

				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_9 = math.max(var_385_2, arg_382_1.talkMaxDuration)

			if var_385_1 <= arg_382_1.time_ and arg_382_1.time_ < var_385_1 + var_385_9 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_1) / var_385_9

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_1 + var_385_9 and arg_382_1.time_ < var_385_1 + var_385_9 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {}

		arg_382_1:InitPlayNodeList()
	end,
	Play411051092 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 411051092
		arg_386_1.duration_ = 13.33

		local var_386_0 = {
			zh = 7.8,
			ja = 13.333
		}
		local var_386_1 = manager.audio:GetLocalizationFlag()

		if var_386_0[var_386_1] ~= nil then
			arg_386_1.duration_ = var_386_0[var_386_1]
		end

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play411051093(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 and not isNil(arg_386_1.actors_["1095ui_story"]) and arg_386_1.var_.characterEffect1095ui_story == nil then
				arg_386_1.var_.characterEffect1095ui_story = arg_386_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_389_0 = 0.200000002980232

			if 0 <= arg_386_1.time_ and arg_386_1.time_ < 0 + var_389_0 and not isNil(arg_386_1.actors_["1095ui_story"]) then
				if arg_386_1.var_.characterEffect1095ui_story and not isNil(arg_386_1.actors_["1095ui_story"]) then
					arg_386_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_386_1.time_ >= 0 + var_389_0 and arg_386_1.time_ < 0 + var_389_0 + arg_389_0 and not isNil(arg_386_1.actors_["1095ui_story"]) and arg_386_1.var_.characterEffect1095ui_story then
				arg_386_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 then
				arg_386_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_1")
			end

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 then
				arg_386_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_389_2 = 0
			local var_389_3 = 0.95

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= var_389_2 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, true)

				arg_386_1.leftNameTxt_.text = arg_386_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_386_1.leftNameTxt_.transform)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1.leftNameTxt_.text)
				SetActive(arg_386_1.iconTrs_.gameObject, false)
				arg_386_1.callingController_:SetSelectedState("normal")

				local var_389_4 = arg_386_1:GetWordFromCfg(411051092)
				local var_389_5 = arg_386_1:FormatText(var_389_4.content)

				arg_386_1.text_.text = var_389_5

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_7 = 38 <= 0 and var_389_3 or var_389_3 * (utf8.len(var_389_5) / 38)

				if (38 <= 0 and var_389_3 or var_389_3 * (utf8.len(var_389_5) / 38)) > 0 and var_389_3 < var_389_7 then
					arg_386_1.talkMaxDuration = var_389_7

					if var_389_7 + var_389_2 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_7 + var_389_2
					end
				end

				arg_386_1.text_.text = var_389_5
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051092", "story_v_out_411051.awb") ~= 0 then
					local var_389_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051092", "story_v_out_411051.awb") / 1000

					if var_389_8 + var_389_2 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_8 + var_389_2
					end

					if var_389_4.prefab_name ~= "" and arg_386_1.actors_[var_389_4.prefab_name] ~= nil then
						local var_389_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_386_1.actors_[var_389_4.prefab_name].transform, "story_v_out_411051", "411051092", "story_v_out_411051.awb")

						arg_386_1:RecordAudio("411051092", var_389_9)
						arg_386_1:RecordAudio("411051092", var_389_9)
					else
						arg_386_1:AudioAction("play", "voice", "story_v_out_411051", "411051092", "story_v_out_411051.awb")
					end

					arg_386_1:RecordHistoryTalkVoice("story_v_out_411051", "411051092", "story_v_out_411051.awb")
				end

				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_10 = math.max(var_389_3, arg_386_1.talkMaxDuration)

			if var_389_2 <= arg_386_1.time_ and arg_386_1.time_ < var_389_2 + var_389_10 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_2) / var_389_10

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_2 + var_389_10 and arg_386_1.time_ < var_389_2 + var_389_10 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {}

		arg_386_1:InitPlayNodeList()
	end,
	Play411051093 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 411051093
		arg_390_1.duration_ = 13.47

		local var_390_0 = {
			zh = 8.2,
			ja = 13.466
		}
		local var_390_1 = manager.audio:GetLocalizationFlag()

		if var_390_0[var_390_1] ~= nil then
			arg_390_1.duration_ = var_390_0[var_390_1]
		end

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play411051094(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			local var_393_0 = 0.875

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				arg_390_1.leftNameTxt_.text = arg_390_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_1 = arg_390_1:GetWordFromCfg(411051093)
				local var_393_2 = arg_390_1:FormatText(var_393_1.content)

				arg_390_1.text_.text = var_393_2

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_4 = 35 <= 0 and var_393_0 or var_393_0 * (utf8.len(var_393_2) / 35)

				if (35 <= 0 and var_393_0 or var_393_0 * (utf8.len(var_393_2) / 35)) > 0 and var_393_0 < var_393_4 then
					arg_390_1.talkMaxDuration = var_393_4

					if var_393_4 + 0 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_4 + 0
					end
				end

				arg_390_1.text_.text = var_393_2
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051093", "story_v_out_411051.awb") ~= 0 then
					local var_393_5 = manager.audio:GetVoiceLength("story_v_out_411051", "411051093", "story_v_out_411051.awb") / 1000

					if var_393_5 + 0 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_5 + 0
					end

					if var_393_1.prefab_name ~= "" and arg_390_1.actors_[var_393_1.prefab_name] ~= nil then
						local var_393_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_390_1.actors_[var_393_1.prefab_name].transform, "story_v_out_411051", "411051093", "story_v_out_411051.awb")

						arg_390_1:RecordAudio("411051093", var_393_6)
						arg_390_1:RecordAudio("411051093", var_393_6)
					else
						arg_390_1:AudioAction("play", "voice", "story_v_out_411051", "411051093", "story_v_out_411051.awb")
					end

					arg_390_1:RecordHistoryTalkVoice("story_v_out_411051", "411051093", "story_v_out_411051.awb")
				end

				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_7 = math.max(var_393_0, arg_390_1.talkMaxDuration)

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_7 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - 0) / var_393_7

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= 0 + var_393_7 and arg_390_1.time_ < 0 + var_393_7 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {}

		arg_390_1:InitPlayNodeList()
	end,
	Play411051094 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 411051094
		arg_394_1.duration_ = 9.7

		local var_394_0 = {
			zh = 9.7,
			ja = 6.366
		}
		local var_394_1 = manager.audio:GetLocalizationFlag()

		if var_394_0[var_394_1] ~= nil then
			arg_394_1.duration_ = var_394_0[var_394_1]
		end

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play411051095(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 and not isNil(arg_394_1.actors_["1095ui_story"]) and arg_394_1.var_.characterEffect1095ui_story == nil then
				arg_394_1.var_.characterEffect1095ui_story = arg_394_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_397_0 = 0.200000002980232

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_0 and not isNil(arg_394_1.actors_["1095ui_story"]) then
				if arg_394_1.var_.characterEffect1095ui_story and not isNil(arg_394_1.actors_["1095ui_story"]) then
					arg_394_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_394_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_394_1.time_ - 0) / var_397_0)
				end
			end

			if arg_394_1.time_ >= 0 + var_397_0 and arg_394_1.time_ < 0 + var_397_0 + arg_397_0 and not isNil(arg_394_1.actors_["1095ui_story"]) and arg_394_1.var_.characterEffect1095ui_story then
				arg_394_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_394_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_397_1 = 0
			local var_397_2 = 0.95

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= var_397_1 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, true)

				arg_394_1.leftNameTxt_.text = arg_394_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_394_1.leftNameTxt_.transform)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1.leftNameTxt_.text)
				SetActive(arg_394_1.iconTrs_.gameObject, true)
				arg_394_1.iconController_:SetSelectedState("hero")

				arg_394_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_394_1.callingController_:SetSelectedState("normal")

				arg_394_1.keyicon_.color = Color.New(1, 1, 1)
				arg_394_1.icon_.color = Color.New(1, 1, 1)

				local var_397_3 = arg_394_1:GetWordFromCfg(411051094)
				local var_397_4 = arg_394_1:FormatText(var_397_3.content)

				arg_394_1.text_.text = var_397_4

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_6 = 37 <= 0 and var_397_2 or var_397_2 * (utf8.len(var_397_4) / 37)

				if (37 <= 0 and var_397_2 or var_397_2 * (utf8.len(var_397_4) / 37)) > 0 and var_397_2 < var_397_6 then
					arg_394_1.talkMaxDuration = var_397_6

					if var_397_6 + var_397_1 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_6 + var_397_1
					end
				end

				arg_394_1.text_.text = var_397_4
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051094", "story_v_out_411051.awb") ~= 0 then
					local var_397_7 = manager.audio:GetVoiceLength("story_v_out_411051", "411051094", "story_v_out_411051.awb") / 1000

					if var_397_7 + var_397_1 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_7 + var_397_1
					end

					if var_397_3.prefab_name ~= "" and arg_394_1.actors_[var_397_3.prefab_name] ~= nil then
						local var_397_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_394_1.actors_[var_397_3.prefab_name].transform, "story_v_out_411051", "411051094", "story_v_out_411051.awb")

						arg_394_1:RecordAudio("411051094", var_397_8)
						arg_394_1:RecordAudio("411051094", var_397_8)
					else
						arg_394_1:AudioAction("play", "voice", "story_v_out_411051", "411051094", "story_v_out_411051.awb")
					end

					arg_394_1:RecordHistoryTalkVoice("story_v_out_411051", "411051094", "story_v_out_411051.awb")
				end

				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_9 = math.max(var_397_2, arg_394_1.talkMaxDuration)

			if var_397_1 <= arg_394_1.time_ and arg_394_1.time_ < var_397_1 + var_397_9 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_1) / var_397_9

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_1 + var_397_9 and arg_394_1.time_ < var_397_1 + var_397_9 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {}

		arg_394_1:InitPlayNodeList()
	end,
	Play411051095 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 411051095
		arg_398_1.duration_ = 7.43

		local var_398_0 = {
			zh = 5.533,
			ja = 7.433
		}
		local var_398_1 = manager.audio:GetLocalizationFlag()

		if var_398_0[var_398_1] ~= nil then
			arg_398_1.duration_ = var_398_0[var_398_1]
		end

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play411051096(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 and not isNil(arg_398_1.actors_["1095ui_story"]) and arg_398_1.var_.characterEffect1095ui_story == nil then
				arg_398_1.var_.characterEffect1095ui_story = arg_398_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_401_0 = 0.200000002980232

			if 0 <= arg_398_1.time_ and arg_398_1.time_ < 0 + var_401_0 and not isNil(arg_398_1.actors_["1095ui_story"]) then
				if arg_398_1.var_.characterEffect1095ui_story and not isNil(arg_398_1.actors_["1095ui_story"]) then
					arg_398_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_398_1.time_ >= 0 + var_401_0 and arg_398_1.time_ < 0 + var_401_0 + arg_401_0 and not isNil(arg_398_1.actors_["1095ui_story"]) and arg_398_1.var_.characterEffect1095ui_story then
				arg_398_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_401_2 = 0
			local var_401_3 = 0.55

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= var_401_2 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, true)

				arg_398_1.leftNameTxt_.text = arg_398_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_398_1.leftNameTxt_.transform)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1.leftNameTxt_.text)
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_4 = arg_398_1:GetWordFromCfg(411051095)
				local var_401_5 = arg_398_1:FormatText(var_401_4.content)

				arg_398_1.text_.text = var_401_5

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_7 = 22 <= 0 and var_401_3 or var_401_3 * (utf8.len(var_401_5) / 22)

				if (22 <= 0 and var_401_3 or var_401_3 * (utf8.len(var_401_5) / 22)) > 0 and var_401_3 < var_401_7 then
					arg_398_1.talkMaxDuration = var_401_7

					if var_401_7 + var_401_2 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_7 + var_401_2
					end
				end

				arg_398_1.text_.text = var_401_5
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051095", "story_v_out_411051.awb") ~= 0 then
					local var_401_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051095", "story_v_out_411051.awb") / 1000

					if var_401_8 + var_401_2 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_8 + var_401_2
					end

					if var_401_4.prefab_name ~= "" and arg_398_1.actors_[var_401_4.prefab_name] ~= nil then
						local var_401_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_398_1.actors_[var_401_4.prefab_name].transform, "story_v_out_411051", "411051095", "story_v_out_411051.awb")

						arg_398_1:RecordAudio("411051095", var_401_9)
						arg_398_1:RecordAudio("411051095", var_401_9)
					else
						arg_398_1:AudioAction("play", "voice", "story_v_out_411051", "411051095", "story_v_out_411051.awb")
					end

					arg_398_1:RecordHistoryTalkVoice("story_v_out_411051", "411051095", "story_v_out_411051.awb")
				end

				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_10 = math.max(var_401_3, arg_398_1.talkMaxDuration)

			if var_401_2 <= arg_398_1.time_ and arg_398_1.time_ < var_401_2 + var_401_10 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - var_401_2) / var_401_10

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= var_401_2 + var_401_10 and arg_398_1.time_ < var_401_2 + var_401_10 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {}

		arg_398_1:InitPlayNodeList()
	end,
	Play411051096 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 411051096
		arg_402_1.duration_ = 3

		local var_402_0 = {
			zh = 1.4,
			ja = 3
		}
		local var_402_1 = manager.audio:GetLocalizationFlag()

		if var_402_0[var_402_1] ~= nil then
			arg_402_1.duration_ = var_402_0[var_402_1]
		end

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play411051097(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 and not isNil(arg_402_1.actors_["1095ui_story"]) and arg_402_1.var_.characterEffect1095ui_story == nil then
				arg_402_1.var_.characterEffect1095ui_story = arg_402_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_405_0 = 0.200000002980232

			if 0 <= arg_402_1.time_ and arg_402_1.time_ < 0 + var_405_0 and not isNil(arg_402_1.actors_["1095ui_story"]) then
				if arg_402_1.var_.characterEffect1095ui_story and not isNil(arg_402_1.actors_["1095ui_story"]) then
					arg_402_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_402_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_402_1.time_ - 0) / var_405_0)
				end
			end

			if arg_402_1.time_ >= 0 + var_405_0 and arg_402_1.time_ < 0 + var_405_0 + arg_405_0 and not isNil(arg_402_1.actors_["1095ui_story"]) and arg_402_1.var_.characterEffect1095ui_story then
				arg_402_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_402_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_405_1 = 0
			local var_405_2 = 0.175

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= var_405_1 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, true)

				arg_402_1.leftNameTxt_.text = arg_402_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, true)
				arg_402_1.iconController_:SetSelectedState("hero")

				arg_402_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_402_1.callingController_:SetSelectedState("normal")

				arg_402_1.keyicon_.color = Color.New(1, 1, 1)
				arg_402_1.icon_.color = Color.New(1, 1, 1)

				local var_405_3 = arg_402_1:GetWordFromCfg(411051096)
				local var_405_4 = arg_402_1:FormatText(var_405_3.content)

				arg_402_1.text_.text = var_405_4

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_6 = 7 <= 0 and var_405_2 or var_405_2 * (utf8.len(var_405_4) / 7)

				if (7 <= 0 and var_405_2 or var_405_2 * (utf8.len(var_405_4) / 7)) > 0 and var_405_2 < var_405_6 then
					arg_402_1.talkMaxDuration = var_405_6

					if var_405_6 + var_405_1 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_6 + var_405_1
					end
				end

				arg_402_1.text_.text = var_405_4
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051096", "story_v_out_411051.awb") ~= 0 then
					local var_405_7 = manager.audio:GetVoiceLength("story_v_out_411051", "411051096", "story_v_out_411051.awb") / 1000

					if var_405_7 + var_405_1 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_7 + var_405_1
					end

					if var_405_3.prefab_name ~= "" and arg_402_1.actors_[var_405_3.prefab_name] ~= nil then
						local var_405_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_402_1.actors_[var_405_3.prefab_name].transform, "story_v_out_411051", "411051096", "story_v_out_411051.awb")

						arg_402_1:RecordAudio("411051096", var_405_8)
						arg_402_1:RecordAudio("411051096", var_405_8)
					else
						arg_402_1:AudioAction("play", "voice", "story_v_out_411051", "411051096", "story_v_out_411051.awb")
					end

					arg_402_1:RecordHistoryTalkVoice("story_v_out_411051", "411051096", "story_v_out_411051.awb")
				end

				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_9 = math.max(var_405_2, arg_402_1.talkMaxDuration)

			if var_405_1 <= arg_402_1.time_ and arg_402_1.time_ < var_405_1 + var_405_9 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - var_405_1) / var_405_9

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= var_405_1 + var_405_9 and arg_402_1.time_ < var_405_1 + var_405_9 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {}

		arg_402_1:InitPlayNodeList()
	end,
	Play411051097 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 411051097
		arg_406_1.duration_ = 6.03

		local var_406_0 = {
			zh = 5.033,
			ja = 6.033
		}
		local var_406_1 = manager.audio:GetLocalizationFlag()

		if var_406_0[var_406_1] ~= nil then
			arg_406_1.duration_ = var_406_0[var_406_1]
		end

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play411051098(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 and not isNil(arg_406_1.actors_["1095ui_story"]) and arg_406_1.var_.characterEffect1095ui_story == nil then
				arg_406_1.var_.characterEffect1095ui_story = arg_406_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_409_0 = 0.200000002980232

			if 0 <= arg_406_1.time_ and arg_406_1.time_ < 0 + var_409_0 and not isNil(arg_406_1.actors_["1095ui_story"]) then
				if arg_406_1.var_.characterEffect1095ui_story and not isNil(arg_406_1.actors_["1095ui_story"]) then
					arg_406_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_406_1.time_ >= 0 + var_409_0 and arg_406_1.time_ < 0 + var_409_0 + arg_409_0 and not isNil(arg_406_1.actors_["1095ui_story"]) and arg_406_1.var_.characterEffect1095ui_story then
				arg_406_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_409_2 = 0
			local var_409_3 = 0.65

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= var_409_2 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, true)

				arg_406_1.leftNameTxt_.text = arg_406_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_406_1.leftNameTxt_.transform)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1.leftNameTxt_.text)
				SetActive(arg_406_1.iconTrs_.gameObject, false)
				arg_406_1.callingController_:SetSelectedState("normal")

				local var_409_4 = arg_406_1:GetWordFromCfg(411051097)
				local var_409_5 = arg_406_1:FormatText(var_409_4.content)

				arg_406_1.text_.text = var_409_5

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_7 = 26 <= 0 and var_409_3 or var_409_3 * (utf8.len(var_409_5) / 26)

				if (26 <= 0 and var_409_3 or var_409_3 * (utf8.len(var_409_5) / 26)) > 0 and var_409_3 < var_409_7 then
					arg_406_1.talkMaxDuration = var_409_7

					if var_409_7 + var_409_2 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_7 + var_409_2
					end
				end

				arg_406_1.text_.text = var_409_5
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051097", "story_v_out_411051.awb") ~= 0 then
					local var_409_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051097", "story_v_out_411051.awb") / 1000

					if var_409_8 + var_409_2 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_8 + var_409_2
					end

					if var_409_4.prefab_name ~= "" and arg_406_1.actors_[var_409_4.prefab_name] ~= nil then
						local var_409_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_406_1.actors_[var_409_4.prefab_name].transform, "story_v_out_411051", "411051097", "story_v_out_411051.awb")

						arg_406_1:RecordAudio("411051097", var_409_9)
						arg_406_1:RecordAudio("411051097", var_409_9)
					else
						arg_406_1:AudioAction("play", "voice", "story_v_out_411051", "411051097", "story_v_out_411051.awb")
					end

					arg_406_1:RecordHistoryTalkVoice("story_v_out_411051", "411051097", "story_v_out_411051.awb")
				end

				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_10 = math.max(var_409_3, arg_406_1.talkMaxDuration)

			if var_409_2 <= arg_406_1.time_ and arg_406_1.time_ < var_409_2 + var_409_10 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - var_409_2) / var_409_10

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= var_409_2 + var_409_10 and arg_406_1.time_ < var_409_2 + var_409_10 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {}

		arg_406_1:InitPlayNodeList()
	end,
	Play411051098 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 411051098
		arg_410_1.duration_ = 11.17

		local var_410_0 = {
			zh = 10.2,
			ja = 11.166
		}
		local var_410_1 = manager.audio:GetLocalizationFlag()

		if var_410_0[var_410_1] ~= nil then
			arg_410_1.duration_ = var_410_0[var_410_1]
		end

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play411051099(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			local var_413_0 = 1.3

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, true)

				arg_410_1.leftNameTxt_.text = arg_410_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_410_1.leftNameTxt_.transform)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1.leftNameTxt_.text)
				SetActive(arg_410_1.iconTrs_.gameObject, false)
				arg_410_1.callingController_:SetSelectedState("normal")

				local var_413_1 = arg_410_1:GetWordFromCfg(411051098)
				local var_413_2 = arg_410_1:FormatText(var_413_1.content)

				arg_410_1.text_.text = var_413_2

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_4 = 52 <= 0 and var_413_0 or var_413_0 * (utf8.len(var_413_2) / 52)

				if (52 <= 0 and var_413_0 or var_413_0 * (utf8.len(var_413_2) / 52)) > 0 and var_413_0 < var_413_4 then
					arg_410_1.talkMaxDuration = var_413_4

					if var_413_4 + 0 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_4 + 0
					end
				end

				arg_410_1.text_.text = var_413_2
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051098", "story_v_out_411051.awb") ~= 0 then
					local var_413_5 = manager.audio:GetVoiceLength("story_v_out_411051", "411051098", "story_v_out_411051.awb") / 1000

					if var_413_5 + 0 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_5 + 0
					end

					if var_413_1.prefab_name ~= "" and arg_410_1.actors_[var_413_1.prefab_name] ~= nil then
						local var_413_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_410_1.actors_[var_413_1.prefab_name].transform, "story_v_out_411051", "411051098", "story_v_out_411051.awb")

						arg_410_1:RecordAudio("411051098", var_413_6)
						arg_410_1:RecordAudio("411051098", var_413_6)
					else
						arg_410_1:AudioAction("play", "voice", "story_v_out_411051", "411051098", "story_v_out_411051.awb")
					end

					arg_410_1:RecordHistoryTalkVoice("story_v_out_411051", "411051098", "story_v_out_411051.awb")
				end

				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_7 = math.max(var_413_0, arg_410_1.talkMaxDuration)

			if 0 <= arg_410_1.time_ and arg_410_1.time_ < 0 + var_413_7 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - 0) / var_413_7

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= 0 + var_413_7 and arg_410_1.time_ < 0 + var_413_7 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {}

		arg_410_1:InitPlayNodeList()
	end,
	Play411051099 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 411051099
		arg_414_1.duration_ = 10.53

		local var_414_0 = {
			zh = 10.533,
			ja = 7
		}
		local var_414_1 = manager.audio:GetLocalizationFlag()

		if var_414_0[var_414_1] ~= nil then
			arg_414_1.duration_ = var_414_0[var_414_1]
		end

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play411051100(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			local var_417_0 = 1.275

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, true)

				arg_414_1.leftNameTxt_.text = arg_414_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_414_1.leftNameTxt_.transform)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1.leftNameTxt_.text)
				SetActive(arg_414_1.iconTrs_.gameObject, false)
				arg_414_1.callingController_:SetSelectedState("normal")

				local var_417_1 = arg_414_1:GetWordFromCfg(411051099)
				local var_417_2 = arg_414_1:FormatText(var_417_1.content)

				arg_414_1.text_.text = var_417_2

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_4 = 51 <= 0 and var_417_0 or var_417_0 * (utf8.len(var_417_2) / 51)

				if (51 <= 0 and var_417_0 or var_417_0 * (utf8.len(var_417_2) / 51)) > 0 and var_417_0 < var_417_4 then
					arg_414_1.talkMaxDuration = var_417_4

					if var_417_4 + 0 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_4 + 0
					end
				end

				arg_414_1.text_.text = var_417_2
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051099", "story_v_out_411051.awb") ~= 0 then
					local var_417_5 = manager.audio:GetVoiceLength("story_v_out_411051", "411051099", "story_v_out_411051.awb") / 1000

					if var_417_5 + 0 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_5 + 0
					end

					if var_417_1.prefab_name ~= "" and arg_414_1.actors_[var_417_1.prefab_name] ~= nil then
						local var_417_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_414_1.actors_[var_417_1.prefab_name].transform, "story_v_out_411051", "411051099", "story_v_out_411051.awb")

						arg_414_1:RecordAudio("411051099", var_417_6)
						arg_414_1:RecordAudio("411051099", var_417_6)
					else
						arg_414_1:AudioAction("play", "voice", "story_v_out_411051", "411051099", "story_v_out_411051.awb")
					end

					arg_414_1:RecordHistoryTalkVoice("story_v_out_411051", "411051099", "story_v_out_411051.awb")
				end

				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_7 = math.max(var_417_0, arg_414_1.talkMaxDuration)

			if 0 <= arg_414_1.time_ and arg_414_1.time_ < 0 + var_417_7 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - 0) / var_417_7

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= 0 + var_417_7 and arg_414_1.time_ < 0 + var_417_7 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {}

		arg_414_1:InitPlayNodeList()
	end,
	Play411051100 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 411051100
		arg_418_1.duration_ = 5.9

		local var_418_0 = {
			zh = 5.9,
			ja = 5.433
		}
		local var_418_1 = manager.audio:GetLocalizationFlag()

		if var_418_0[var_418_1] ~= nil then
			arg_418_1.duration_ = var_418_0[var_418_1]
		end

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play411051101(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 then
				arg_418_1.var_.moveOldPos1095ui_story = arg_418_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_421_0 = 0.001

			if 0 <= arg_418_1.time_ and arg_418_1.time_ < 0 + var_421_0 then
				arg_418_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_418_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_418_1.time_ - 0) / var_421_0)
				arg_418_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_418_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_418_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_418_1.actors_["1095ui_story"].transform.position).z)
				arg_418_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_418_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_418_1.actors_["1095ui_story"].transform.localEulerAngles = arg_418_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_418_1.time_ >= 0 + var_421_0 and arg_418_1.time_ < 0 + var_421_0 + arg_421_0 then
				arg_418_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_418_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_418_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_418_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_418_1.actors_["1095ui_story"].transform.position).z)
				arg_418_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_418_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_418_1.actors_["1095ui_story"].transform.localEulerAngles = arg_418_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_421_1 = arg_418_1.actors_["1095ui_story"]

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 and not isNil(var_421_1) and arg_418_1.var_.characterEffect1095ui_story == nil then
				arg_418_1.var_.characterEffect1095ui_story = var_421_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_421_2 = 0.200000002980232

			if 0 <= arg_418_1.time_ and arg_418_1.time_ < 0 + var_421_2 and not isNil(var_421_1) then
				if arg_418_1.var_.characterEffect1095ui_story and not isNil(var_421_1) then
					arg_418_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_418_1.time_ >= 0 + var_421_2 and arg_418_1.time_ < 0 + var_421_2 + arg_421_0 and not isNil(var_421_1) and arg_418_1.var_.characterEffect1095ui_story then
				arg_418_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 then
				arg_418_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095actionlink/1095action436")
			end

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 then
				arg_418_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_421_4 = 0
			local var_421_5 = 0.7

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= var_421_4 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0
				arg_418_1.dialogCg_.alpha = 1

				arg_418_1.dialog_:SetActive(true)
				SetActive(arg_418_1.leftNameGo_, true)

				arg_418_1.leftNameTxt_.text = arg_418_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_418_1.leftNameTxt_.transform)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1.leftNameTxt_.text)
				SetActive(arg_418_1.iconTrs_.gameObject, false)
				arg_418_1.callingController_:SetSelectedState("normal")

				local var_421_6 = arg_418_1:GetWordFromCfg(411051100)
				local var_421_7 = arg_418_1:FormatText(var_421_6.content)

				arg_418_1.text_.text = var_421_7

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_9 = 28 <= 0 and var_421_5 or var_421_5 * (utf8.len(var_421_7) / 28)

				if (28 <= 0 and var_421_5 or var_421_5 * (utf8.len(var_421_7) / 28)) > 0 and var_421_5 < var_421_9 then
					arg_418_1.talkMaxDuration = var_421_9

					if var_421_9 + var_421_4 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_9 + var_421_4
					end
				end

				arg_418_1.text_.text = var_421_7
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051100", "story_v_out_411051.awb") ~= 0 then
					local var_421_10 = manager.audio:GetVoiceLength("story_v_out_411051", "411051100", "story_v_out_411051.awb") / 1000

					if var_421_10 + var_421_4 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_10 + var_421_4
					end

					if var_421_6.prefab_name ~= "" and arg_418_1.actors_[var_421_6.prefab_name] ~= nil then
						local var_421_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_418_1.actors_[var_421_6.prefab_name].transform, "story_v_out_411051", "411051100", "story_v_out_411051.awb")

						arg_418_1:RecordAudio("411051100", var_421_11)
						arg_418_1:RecordAudio("411051100", var_421_11)
					else
						arg_418_1:AudioAction("play", "voice", "story_v_out_411051", "411051100", "story_v_out_411051.awb")
					end

					arg_418_1:RecordHistoryTalkVoice("story_v_out_411051", "411051100", "story_v_out_411051.awb")
				end

				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_12 = math.max(var_421_5, arg_418_1.talkMaxDuration)

			if var_421_4 <= arg_418_1.time_ and arg_418_1.time_ < var_421_4 + var_421_12 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - var_421_4) / var_421_12

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= var_421_4 + var_421_12 and arg_418_1.time_ < var_421_4 + var_421_12 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {
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

		arg_418_1:InitPlayNodeList()
	end,
	Play411051101 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 411051101
		arg_422_1.duration_ = 1.7

		local var_422_0 = {
			zh = 0.999999999999,
			ja = 1.7
		}
		local var_422_1 = manager.audio:GetLocalizationFlag()

		if var_422_0[var_422_1] ~= nil then
			arg_422_1.duration_ = var_422_0[var_422_1]
		end

		SetActive(arg_422_1.tipsGo_, false)

		function arg_422_1.onSingleLineFinish_()
			arg_422_1.onSingleLineUpdate_ = nil
			arg_422_1.onSingleLineFinish_ = nil
			arg_422_1.state_ = "waiting"
		end

		function arg_422_1.playNext_(arg_424_0)
			if arg_424_0 == 1 then
				arg_422_0:Play411051102(arg_422_1)
			end
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			if 0 < arg_422_1.time_ and arg_422_1.time_ <= 0 + arg_425_0 and not isNil(arg_422_1.actors_["1095ui_story"]) and arg_422_1.var_.characterEffect1095ui_story == nil then
				arg_422_1.var_.characterEffect1095ui_story = arg_422_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_425_0 = 0.200000002980232

			if 0 <= arg_422_1.time_ and arg_422_1.time_ < 0 + var_425_0 and not isNil(arg_422_1.actors_["1095ui_story"]) then
				if arg_422_1.var_.characterEffect1095ui_story and not isNil(arg_422_1.actors_["1095ui_story"]) then
					arg_422_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_422_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_422_1.time_ - 0) / var_425_0)
				end
			end

			if arg_422_1.time_ >= 0 + var_425_0 and arg_422_1.time_ < 0 + var_425_0 + arg_425_0 and not isNil(arg_422_1.actors_["1095ui_story"]) and arg_422_1.var_.characterEffect1095ui_story then
				arg_422_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_422_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_425_1 = 0
			local var_425_2 = 0.075

			if 0 < arg_422_1.time_ and arg_422_1.time_ <= var_425_1 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0
				arg_422_1.dialogCg_.alpha = 1

				arg_422_1.dialog_:SetActive(true)
				SetActive(arg_422_1.leftNameGo_, true)

				arg_422_1.leftNameTxt_.text = arg_422_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_422_1.leftNameTxt_.transform)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1.leftNameTxt_.text)
				SetActive(arg_422_1.iconTrs_.gameObject, true)
				arg_422_1.iconController_:SetSelectedState("hero")

				arg_422_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_422_1.callingController_:SetSelectedState("normal")

				arg_422_1.keyicon_.color = Color.New(1, 1, 1)
				arg_422_1.icon_.color = Color.New(1, 1, 1)

				local var_425_3 = arg_422_1:GetWordFromCfg(411051101)
				local var_425_4 = arg_422_1:FormatText(var_425_3.content)

				arg_422_1.text_.text = var_425_4

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_6 = 3 <= 0 and var_425_2 or var_425_2 * (utf8.len(var_425_4) / 3)

				if (3 <= 0 and var_425_2 or var_425_2 * (utf8.len(var_425_4) / 3)) > 0 and var_425_2 < var_425_6 then
					arg_422_1.talkMaxDuration = var_425_6

					if var_425_6 + var_425_1 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_6 + var_425_1
					end
				end

				arg_422_1.text_.text = var_425_4
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051101", "story_v_out_411051.awb") ~= 0 then
					local var_425_7 = manager.audio:GetVoiceLength("story_v_out_411051", "411051101", "story_v_out_411051.awb") / 1000

					if var_425_7 + var_425_1 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_7 + var_425_1
					end

					if var_425_3.prefab_name ~= "" and arg_422_1.actors_[var_425_3.prefab_name] ~= nil then
						local var_425_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_422_1.actors_[var_425_3.prefab_name].transform, "story_v_out_411051", "411051101", "story_v_out_411051.awb")

						arg_422_1:RecordAudio("411051101", var_425_8)
						arg_422_1:RecordAudio("411051101", var_425_8)
					else
						arg_422_1:AudioAction("play", "voice", "story_v_out_411051", "411051101", "story_v_out_411051.awb")
					end

					arg_422_1:RecordHistoryTalkVoice("story_v_out_411051", "411051101", "story_v_out_411051.awb")
				end

				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_9 = math.max(var_425_2, arg_422_1.talkMaxDuration)

			if var_425_1 <= arg_422_1.time_ and arg_422_1.time_ < var_425_1 + var_425_9 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - var_425_1) / var_425_9

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= var_425_1 + var_425_9 and arg_422_1.time_ < var_425_1 + var_425_9 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {}

		arg_422_1:InitPlayNodeList()
	end,
	Play411051102 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 411051102
		arg_426_1.duration_ = 11.47

		local var_426_0 = {
			zh = 7.866,
			ja = 11.466
		}
		local var_426_1 = manager.audio:GetLocalizationFlag()

		if var_426_0[var_426_1] ~= nil then
			arg_426_1.duration_ = var_426_0[var_426_1]
		end

		SetActive(arg_426_1.tipsGo_, false)

		function arg_426_1.onSingleLineFinish_()
			arg_426_1.onSingleLineUpdate_ = nil
			arg_426_1.onSingleLineFinish_ = nil
			arg_426_1.state_ = "waiting"
		end

		function arg_426_1.playNext_(arg_428_0)
			if arg_428_0 == 1 then
				arg_426_0:Play411051103(arg_426_1)
			end
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			if 0 < arg_426_1.time_ and arg_426_1.time_ <= 0 + arg_429_0 and not isNil(arg_426_1.actors_["1095ui_story"]) and arg_426_1.var_.characterEffect1095ui_story == nil then
				arg_426_1.var_.characterEffect1095ui_story = arg_426_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_429_0 = 0.200000002980232

			if 0 <= arg_426_1.time_ and arg_426_1.time_ < 0 + var_429_0 and not isNil(arg_426_1.actors_["1095ui_story"]) then
				if arg_426_1.var_.characterEffect1095ui_story and not isNil(arg_426_1.actors_["1095ui_story"]) then
					arg_426_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_426_1.time_ >= 0 + var_429_0 and arg_426_1.time_ < 0 + var_429_0 + arg_429_0 and not isNil(arg_426_1.actors_["1095ui_story"]) and arg_426_1.var_.characterEffect1095ui_story then
				arg_426_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_429_2 = 0
			local var_429_3 = 0.9

			if 0 < arg_426_1.time_ and arg_426_1.time_ <= var_429_2 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0
				arg_426_1.dialogCg_.alpha = 1

				arg_426_1.dialog_:SetActive(true)
				SetActive(arg_426_1.leftNameGo_, true)

				arg_426_1.leftNameTxt_.text = arg_426_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_426_1.leftNameTxt_.transform)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1.leftNameTxt_.text)
				SetActive(arg_426_1.iconTrs_.gameObject, false)
				arg_426_1.callingController_:SetSelectedState("normal")

				local var_429_4 = arg_426_1:GetWordFromCfg(411051102)
				local var_429_5 = arg_426_1:FormatText(var_429_4.content)

				arg_426_1.text_.text = var_429_5

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_7 = 36 <= 0 and var_429_3 or var_429_3 * (utf8.len(var_429_5) / 36)

				if (36 <= 0 and var_429_3 or var_429_3 * (utf8.len(var_429_5) / 36)) > 0 and var_429_3 < var_429_7 then
					arg_426_1.talkMaxDuration = var_429_7

					if var_429_7 + var_429_2 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_7 + var_429_2
					end
				end

				arg_426_1.text_.text = var_429_5
				arg_426_1.typewritter.percent = 0

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051102", "story_v_out_411051.awb") ~= 0 then
					local var_429_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051102", "story_v_out_411051.awb") / 1000

					if var_429_8 + var_429_2 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_8 + var_429_2
					end

					if var_429_4.prefab_name ~= "" and arg_426_1.actors_[var_429_4.prefab_name] ~= nil then
						local var_429_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_426_1.actors_[var_429_4.prefab_name].transform, "story_v_out_411051", "411051102", "story_v_out_411051.awb")

						arg_426_1:RecordAudio("411051102", var_429_9)
						arg_426_1:RecordAudio("411051102", var_429_9)
					else
						arg_426_1:AudioAction("play", "voice", "story_v_out_411051", "411051102", "story_v_out_411051.awb")
					end

					arg_426_1:RecordHistoryTalkVoice("story_v_out_411051", "411051102", "story_v_out_411051.awb")
				end

				arg_426_1:RecordContent(arg_426_1.text_.text)
			end

			local var_429_10 = math.max(var_429_3, arg_426_1.talkMaxDuration)

			if var_429_2 <= arg_426_1.time_ and arg_426_1.time_ < var_429_2 + var_429_10 then
				arg_426_1.typewritter.percent = (arg_426_1.time_ - var_429_2) / var_429_10

				arg_426_1.typewritter:SetDirty()
			end

			if arg_426_1.time_ >= var_429_2 + var_429_10 and arg_426_1.time_ < var_429_2 + var_429_10 + arg_429_0 then
				arg_426_1.typewritter.percent = 1

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(true)
			end
		end

		arg_426_1.nodeConfigList_ = {}

		arg_426_1:InitPlayNodeList()
	end,
	Play411051103 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 411051103
		arg_430_1.duration_ = 8.8

		local var_430_0 = {
			zh = 8.8,
			ja = 4.566
		}
		local var_430_1 = manager.audio:GetLocalizationFlag()

		if var_430_0[var_430_1] ~= nil then
			arg_430_1.duration_ = var_430_0[var_430_1]
		end

		SetActive(arg_430_1.tipsGo_, false)

		function arg_430_1.onSingleLineFinish_()
			arg_430_1.onSingleLineUpdate_ = nil
			arg_430_1.onSingleLineFinish_ = nil
			arg_430_1.state_ = "waiting"
		end

		function arg_430_1.playNext_(arg_432_0)
			if arg_432_0 == 1 then
				arg_430_0:Play411051104(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			local var_433_0 = 0.85

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, true)

				arg_430_1.leftNameTxt_.text = arg_430_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_430_1.leftNameTxt_.transform)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1.leftNameTxt_.text)
				SetActive(arg_430_1.iconTrs_.gameObject, false)
				arg_430_1.callingController_:SetSelectedState("normal")

				local var_433_1 = arg_430_1:GetWordFromCfg(411051103)
				local var_433_2 = arg_430_1:FormatText(var_433_1.content)

				arg_430_1.text_.text = var_433_2

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_4 = 34 <= 0 and var_433_0 or var_433_0 * (utf8.len(var_433_2) / 34)

				if (34 <= 0 and var_433_0 or var_433_0 * (utf8.len(var_433_2) / 34)) > 0 and var_433_0 < var_433_4 then
					arg_430_1.talkMaxDuration = var_433_4

					if var_433_4 + 0 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_4 + 0
					end
				end

				arg_430_1.text_.text = var_433_2
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051103", "story_v_out_411051.awb") ~= 0 then
					local var_433_5 = manager.audio:GetVoiceLength("story_v_out_411051", "411051103", "story_v_out_411051.awb") / 1000

					if var_433_5 + 0 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_5 + 0
					end

					if var_433_1.prefab_name ~= "" and arg_430_1.actors_[var_433_1.prefab_name] ~= nil then
						local var_433_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_430_1.actors_[var_433_1.prefab_name].transform, "story_v_out_411051", "411051103", "story_v_out_411051.awb")

						arg_430_1:RecordAudio("411051103", var_433_6)
						arg_430_1:RecordAudio("411051103", var_433_6)
					else
						arg_430_1:AudioAction("play", "voice", "story_v_out_411051", "411051103", "story_v_out_411051.awb")
					end

					arg_430_1:RecordHistoryTalkVoice("story_v_out_411051", "411051103", "story_v_out_411051.awb")
				end

				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_7 = math.max(var_433_0, arg_430_1.talkMaxDuration)

			if 0 <= arg_430_1.time_ and arg_430_1.time_ < 0 + var_433_7 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - 0) / var_433_7

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= 0 + var_433_7 and arg_430_1.time_ < 0 + var_433_7 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {}

		arg_430_1:InitPlayNodeList()
	end,
	Play411051104 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 411051104
		arg_434_1.duration_ = 5

		SetActive(arg_434_1.tipsGo_, false)

		function arg_434_1.onSingleLineFinish_()
			arg_434_1.onSingleLineUpdate_ = nil
			arg_434_1.onSingleLineFinish_ = nil
			arg_434_1.state_ = "waiting"
		end

		function arg_434_1.playNext_(arg_436_0)
			if arg_436_0 == 1 then
				arg_434_0:Play411051105(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 and not isNil(arg_434_1.actors_["1095ui_story"]) and arg_434_1.var_.characterEffect1095ui_story == nil then
				arg_434_1.var_.characterEffect1095ui_story = arg_434_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_437_0 = 0.200000002980232

			if 0 <= arg_434_1.time_ and arg_434_1.time_ < 0 + var_437_0 and not isNil(arg_434_1.actors_["1095ui_story"]) then
				if arg_434_1.var_.characterEffect1095ui_story and not isNil(arg_434_1.actors_["1095ui_story"]) then
					arg_434_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_434_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_434_1.time_ - 0) / var_437_0)
				end
			end

			if arg_434_1.time_ >= 0 + var_437_0 and arg_434_1.time_ < 0 + var_437_0 + arg_437_0 and not isNil(arg_434_1.actors_["1095ui_story"]) and arg_434_1.var_.characterEffect1095ui_story then
				arg_434_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_434_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_437_1 = 0
			local var_437_2 = 1.05

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= var_437_1 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, false)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_434_1.iconTrs_.gameObject, false)
				arg_434_1.callingController_:SetSelectedState("normal")

				local var_437_3 = arg_434_1:FormatText(arg_434_1:GetWordFromCfg(411051104).content)

				arg_434_1.text_.text = var_437_3

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_5 = 42 <= 0 and var_437_2 or var_437_2 * (utf8.len(var_437_3) / 42)

				if (42 <= 0 and var_437_2 or var_437_2 * (utf8.len(var_437_3) / 42)) > 0 and var_437_2 < var_437_5 then
					arg_434_1.talkMaxDuration = var_437_5

					if var_437_5 + var_437_1 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_5 + var_437_1
					end
				end

				arg_434_1.text_.text = var_437_3
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)
				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_6 = math.max(var_437_2, arg_434_1.talkMaxDuration)

			if var_437_1 <= arg_434_1.time_ and arg_434_1.time_ < var_437_1 + var_437_6 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - var_437_1) / var_437_6

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= var_437_1 + var_437_6 and arg_434_1.time_ < var_437_1 + var_437_6 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {}

		arg_434_1:InitPlayNodeList()
	end,
	Play411051105 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 411051105
		arg_438_1.duration_ = 2.43

		local var_438_0 = {
			zh = 2.433,
			ja = 1.999999999999
		}
		local var_438_1 = manager.audio:GetLocalizationFlag()

		if var_438_0[var_438_1] ~= nil then
			arg_438_1.duration_ = var_438_0[var_438_1]
		end

		SetActive(arg_438_1.tipsGo_, false)

		function arg_438_1.onSingleLineFinish_()
			arg_438_1.onSingleLineUpdate_ = nil
			arg_438_1.onSingleLineFinish_ = nil
			arg_438_1.state_ = "waiting"
		end

		function arg_438_1.playNext_(arg_440_0)
			if arg_440_0 == 1 then
				arg_438_0:Play411051106(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			if 0 < arg_438_1.time_ and arg_438_1.time_ <= 0 + arg_441_0 and not isNil(arg_438_1.actors_["1095ui_story"]) and arg_438_1.var_.characterEffect1095ui_story == nil then
				arg_438_1.var_.characterEffect1095ui_story = arg_438_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_441_0 = 0.200000002980232

			if 0 <= arg_438_1.time_ and arg_438_1.time_ < 0 + var_441_0 and not isNil(arg_438_1.actors_["1095ui_story"]) then
				if arg_438_1.var_.characterEffect1095ui_story and not isNil(arg_438_1.actors_["1095ui_story"]) then
					arg_438_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_438_1.time_ >= 0 + var_441_0 and arg_438_1.time_ < 0 + var_441_0 + arg_441_0 and not isNil(arg_438_1.actors_["1095ui_story"]) and arg_438_1.var_.characterEffect1095ui_story then
				arg_438_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_438_1.time_ and arg_438_1.time_ <= 0 + arg_441_0 then
				arg_438_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action6_2")
			end

			if 0 < arg_438_1.time_ and arg_438_1.time_ <= 0 + arg_441_0 then
				arg_438_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_441_2 = 0
			local var_441_3 = 0.175

			if 0 < arg_438_1.time_ and arg_438_1.time_ <= var_441_2 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, true)

				arg_438_1.leftNameTxt_.text = arg_438_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_438_1.leftNameTxt_.transform)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1.leftNameTxt_.text)
				SetActive(arg_438_1.iconTrs_.gameObject, false)
				arg_438_1.callingController_:SetSelectedState("normal")

				local var_441_4 = arg_438_1:GetWordFromCfg(411051105)
				local var_441_5 = arg_438_1:FormatText(var_441_4.content)

				arg_438_1.text_.text = var_441_5

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_7 = 7 <= 0 and var_441_3 or var_441_3 * (utf8.len(var_441_5) / 7)

				if (7 <= 0 and var_441_3 or var_441_3 * (utf8.len(var_441_5) / 7)) > 0 and var_441_3 < var_441_7 then
					arg_438_1.talkMaxDuration = var_441_7

					if var_441_7 + var_441_2 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_7 + var_441_2
					end
				end

				arg_438_1.text_.text = var_441_5
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051105", "story_v_out_411051.awb") ~= 0 then
					local var_441_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051105", "story_v_out_411051.awb") / 1000

					if var_441_8 + var_441_2 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_8 + var_441_2
					end

					if var_441_4.prefab_name ~= "" and arg_438_1.actors_[var_441_4.prefab_name] ~= nil then
						local var_441_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_438_1.actors_[var_441_4.prefab_name].transform, "story_v_out_411051", "411051105", "story_v_out_411051.awb")

						arg_438_1:RecordAudio("411051105", var_441_9)
						arg_438_1:RecordAudio("411051105", var_441_9)
					else
						arg_438_1:AudioAction("play", "voice", "story_v_out_411051", "411051105", "story_v_out_411051.awb")
					end

					arg_438_1:RecordHistoryTalkVoice("story_v_out_411051", "411051105", "story_v_out_411051.awb")
				end

				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_10 = math.max(var_441_3, arg_438_1.talkMaxDuration)

			if var_441_2 <= arg_438_1.time_ and arg_438_1.time_ < var_441_2 + var_441_10 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - var_441_2) / var_441_10

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= var_441_2 + var_441_10 and arg_438_1.time_ < var_441_2 + var_441_10 + arg_441_0 then
				arg_438_1.typewritter.percent = 1

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(true)
			end
		end

		arg_438_1.nodeConfigList_ = {}

		arg_438_1:InitPlayNodeList()
	end,
	Play411051106 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 411051106
		arg_442_1.duration_ = 4.17

		local var_442_0 = {
			zh = 1.9,
			ja = 4.166
		}
		local var_442_1 = manager.audio:GetLocalizationFlag()

		if var_442_0[var_442_1] ~= nil then
			arg_442_1.duration_ = var_442_0[var_442_1]
		end

		SetActive(arg_442_1.tipsGo_, false)

		function arg_442_1.onSingleLineFinish_()
			arg_442_1.onSingleLineUpdate_ = nil
			arg_442_1.onSingleLineFinish_ = nil
			arg_442_1.state_ = "waiting"
		end

		function arg_442_1.playNext_(arg_444_0)
			if arg_444_0 == 1 then
				arg_442_0:Play411051107(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			if 0 < arg_442_1.time_ and arg_442_1.time_ <= 0 + arg_445_0 and not isNil(arg_442_1.actors_["1095ui_story"]) and arg_442_1.var_.characterEffect1095ui_story == nil then
				arg_442_1.var_.characterEffect1095ui_story = arg_442_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_445_0 = 0.200000002980232

			if 0 <= arg_442_1.time_ and arg_442_1.time_ < 0 + var_445_0 and not isNil(arg_442_1.actors_["1095ui_story"]) then
				if arg_442_1.var_.characterEffect1095ui_story and not isNil(arg_442_1.actors_["1095ui_story"]) then
					arg_442_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_442_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_442_1.time_ - 0) / var_445_0)
				end
			end

			if arg_442_1.time_ >= 0 + var_445_0 and arg_442_1.time_ < 0 + var_445_0 + arg_445_0 and not isNil(arg_442_1.actors_["1095ui_story"]) and arg_442_1.var_.characterEffect1095ui_story then
				arg_442_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_442_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_445_1 = 0
			local var_445_2 = 0.275

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= var_445_1 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0
				arg_442_1.dialogCg_.alpha = 1

				arg_442_1.dialog_:SetActive(true)
				SetActive(arg_442_1.leftNameGo_, true)

				arg_442_1.leftNameTxt_.text = arg_442_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_442_1.leftNameTxt_.transform)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1.leftNameTxt_.text)
				SetActive(arg_442_1.iconTrs_.gameObject, true)
				arg_442_1.iconController_:SetSelectedState("hero")

				arg_442_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_442_1.callingController_:SetSelectedState("normal")

				arg_442_1.keyicon_.color = Color.New(1, 1, 1)
				arg_442_1.icon_.color = Color.New(1, 1, 1)

				local var_445_3 = arg_442_1:GetWordFromCfg(411051106)
				local var_445_4 = arg_442_1:FormatText(var_445_3.content)

				arg_442_1.text_.text = var_445_4

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_6 = 11 <= 0 and var_445_2 or var_445_2 * (utf8.len(var_445_4) / 11)

				if (11 <= 0 and var_445_2 or var_445_2 * (utf8.len(var_445_4) / 11)) > 0 and var_445_2 < var_445_6 then
					arg_442_1.talkMaxDuration = var_445_6

					if var_445_6 + var_445_1 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_6 + var_445_1
					end
				end

				arg_442_1.text_.text = var_445_4
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051106", "story_v_out_411051.awb") ~= 0 then
					local var_445_7 = manager.audio:GetVoiceLength("story_v_out_411051", "411051106", "story_v_out_411051.awb") / 1000

					if var_445_7 + var_445_1 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_7 + var_445_1
					end

					if var_445_3.prefab_name ~= "" and arg_442_1.actors_[var_445_3.prefab_name] ~= nil then
						local var_445_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_442_1.actors_[var_445_3.prefab_name].transform, "story_v_out_411051", "411051106", "story_v_out_411051.awb")

						arg_442_1:RecordAudio("411051106", var_445_8)
						arg_442_1:RecordAudio("411051106", var_445_8)
					else
						arg_442_1:AudioAction("play", "voice", "story_v_out_411051", "411051106", "story_v_out_411051.awb")
					end

					arg_442_1:RecordHistoryTalkVoice("story_v_out_411051", "411051106", "story_v_out_411051.awb")
				end

				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_9 = math.max(var_445_2, arg_442_1.talkMaxDuration)

			if var_445_1 <= arg_442_1.time_ and arg_442_1.time_ < var_445_1 + var_445_9 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - var_445_1) / var_445_9

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= var_445_1 + var_445_9 and arg_442_1.time_ < var_445_1 + var_445_9 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {}

		arg_442_1:InitPlayNodeList()
	end,
	Play411051107 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 411051107
		arg_446_1.duration_ = 11.93

		local var_446_0 = {
			zh = 11.933,
			ja = 9.2
		}
		local var_446_1 = manager.audio:GetLocalizationFlag()

		if var_446_0[var_446_1] ~= nil then
			arg_446_1.duration_ = var_446_0[var_446_1]
		end

		SetActive(arg_446_1.tipsGo_, false)

		function arg_446_1.onSingleLineFinish_()
			arg_446_1.onSingleLineUpdate_ = nil
			arg_446_1.onSingleLineFinish_ = nil
			arg_446_1.state_ = "waiting"
		end

		function arg_446_1.playNext_(arg_448_0)
			if arg_448_0 == 1 then
				arg_446_0:Play411051108(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			local var_449_0 = 1.225

			if 0 < arg_446_1.time_ and arg_446_1.time_ <= 0 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0
				arg_446_1.dialogCg_.alpha = 1

				arg_446_1.dialog_:SetActive(true)
				SetActive(arg_446_1.leftNameGo_, true)

				arg_446_1.leftNameTxt_.text = arg_446_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_446_1.leftNameTxt_.transform)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1.leftNameTxt_.text)
				SetActive(arg_446_1.iconTrs_.gameObject, true)
				arg_446_1.iconController_:SetSelectedState("hero")

				arg_446_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_446_1.callingController_:SetSelectedState("normal")

				arg_446_1.keyicon_.color = Color.New(1, 1, 1)
				arg_446_1.icon_.color = Color.New(1, 1, 1)

				local var_449_1 = arg_446_1:GetWordFromCfg(411051107)
				local var_449_2 = arg_446_1:FormatText(var_449_1.content)

				arg_446_1.text_.text = var_449_2

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_4 = 49 <= 0 and var_449_0 or var_449_0 * (utf8.len(var_449_2) / 49)

				if (49 <= 0 and var_449_0 or var_449_0 * (utf8.len(var_449_2) / 49)) > 0 and var_449_0 < var_449_4 then
					arg_446_1.talkMaxDuration = var_449_4

					if var_449_4 + 0 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_4 + 0
					end
				end

				arg_446_1.text_.text = var_449_2
				arg_446_1.typewritter.percent = 0

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051107", "story_v_out_411051.awb") ~= 0 then
					local var_449_5 = manager.audio:GetVoiceLength("story_v_out_411051", "411051107", "story_v_out_411051.awb") / 1000

					if var_449_5 + 0 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_5 + 0
					end

					if var_449_1.prefab_name ~= "" and arg_446_1.actors_[var_449_1.prefab_name] ~= nil then
						local var_449_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_446_1.actors_[var_449_1.prefab_name].transform, "story_v_out_411051", "411051107", "story_v_out_411051.awb")

						arg_446_1:RecordAudio("411051107", var_449_6)
						arg_446_1:RecordAudio("411051107", var_449_6)
					else
						arg_446_1:AudioAction("play", "voice", "story_v_out_411051", "411051107", "story_v_out_411051.awb")
					end

					arg_446_1:RecordHistoryTalkVoice("story_v_out_411051", "411051107", "story_v_out_411051.awb")
				end

				arg_446_1:RecordContent(arg_446_1.text_.text)
			end

			local var_449_7 = math.max(var_449_0, arg_446_1.talkMaxDuration)

			if 0 <= arg_446_1.time_ and arg_446_1.time_ < 0 + var_449_7 then
				arg_446_1.typewritter.percent = (arg_446_1.time_ - 0) / var_449_7

				arg_446_1.typewritter:SetDirty()
			end

			if arg_446_1.time_ >= 0 + var_449_7 and arg_446_1.time_ < 0 + var_449_7 + arg_449_0 then
				arg_446_1.typewritter.percent = 1

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(true)
			end
		end

		arg_446_1.nodeConfigList_ = {}

		arg_446_1:InitPlayNodeList()
	end,
	Play411051108 = function(arg_450_0, arg_450_1)
		arg_450_1.time_ = 0
		arg_450_1.frameCnt_ = 0
		arg_450_1.state_ = "playing"
		arg_450_1.curTalkId_ = 411051108
		arg_450_1.duration_ = 12.5

		local var_450_0 = {
			zh = 12.5,
			ja = 6.7
		}
		local var_450_1 = manager.audio:GetLocalizationFlag()

		if var_450_0[var_450_1] ~= nil then
			arg_450_1.duration_ = var_450_0[var_450_1]
		end

		SetActive(arg_450_1.tipsGo_, false)

		function arg_450_1.onSingleLineFinish_()
			arg_450_1.onSingleLineUpdate_ = nil
			arg_450_1.onSingleLineFinish_ = nil
			arg_450_1.state_ = "waiting"
		end

		function arg_450_1.playNext_(arg_452_0)
			if arg_452_0 == 1 then
				arg_450_0:Play411051109(arg_450_1)
			end
		end

		function arg_450_1.onSingleLineUpdate_(arg_453_0)
			local var_453_0 = 1.375

			if 0 < arg_450_1.time_ and arg_450_1.time_ <= 0 + arg_453_0 then
				arg_450_1.talkMaxDuration = 0
				arg_450_1.dialogCg_.alpha = 1

				arg_450_1.dialog_:SetActive(true)
				SetActive(arg_450_1.leftNameGo_, true)

				arg_450_1.leftNameTxt_.text = arg_450_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_450_1.leftNameTxt_.transform)

				arg_450_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_450_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_450_1:RecordName(arg_450_1.leftNameTxt_.text)
				SetActive(arg_450_1.iconTrs_.gameObject, true)
				arg_450_1.iconController_:SetSelectedState("hero")

				arg_450_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_450_1.callingController_:SetSelectedState("normal")

				arg_450_1.keyicon_.color = Color.New(1, 1, 1)
				arg_450_1.icon_.color = Color.New(1, 1, 1)

				local var_453_1 = arg_450_1:GetWordFromCfg(411051108)
				local var_453_2 = arg_450_1:FormatText(var_453_1.content)

				arg_450_1.text_.text = var_453_2

				LuaForUtil.ClearLinePrefixSymbol(arg_450_1.text_)

				local var_453_4 = 55 <= 0 and var_453_0 or var_453_0 * (utf8.len(var_453_2) / 55)

				if (55 <= 0 and var_453_0 or var_453_0 * (utf8.len(var_453_2) / 55)) > 0 and var_453_0 < var_453_4 then
					arg_450_1.talkMaxDuration = var_453_4

					if var_453_4 + 0 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_4 + 0
					end
				end

				arg_450_1.text_.text = var_453_2
				arg_450_1.typewritter.percent = 0

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051108", "story_v_out_411051.awb") ~= 0 then
					local var_453_5 = manager.audio:GetVoiceLength("story_v_out_411051", "411051108", "story_v_out_411051.awb") / 1000

					if var_453_5 + 0 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_5 + 0
					end

					if var_453_1.prefab_name ~= "" and arg_450_1.actors_[var_453_1.prefab_name] ~= nil then
						local var_453_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_450_1.actors_[var_453_1.prefab_name].transform, "story_v_out_411051", "411051108", "story_v_out_411051.awb")

						arg_450_1:RecordAudio("411051108", var_453_6)
						arg_450_1:RecordAudio("411051108", var_453_6)
					else
						arg_450_1:AudioAction("play", "voice", "story_v_out_411051", "411051108", "story_v_out_411051.awb")
					end

					arg_450_1:RecordHistoryTalkVoice("story_v_out_411051", "411051108", "story_v_out_411051.awb")
				end

				arg_450_1:RecordContent(arg_450_1.text_.text)
			end

			local var_453_7 = math.max(var_453_0, arg_450_1.talkMaxDuration)

			if 0 <= arg_450_1.time_ and arg_450_1.time_ < 0 + var_453_7 then
				arg_450_1.typewritter.percent = (arg_450_1.time_ - 0) / var_453_7

				arg_450_1.typewritter:SetDirty()
			end

			if arg_450_1.time_ >= 0 + var_453_7 and arg_450_1.time_ < 0 + var_453_7 + arg_453_0 then
				arg_450_1.typewritter.percent = 1

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(true)
			end
		end

		arg_450_1.nodeConfigList_ = {}

		arg_450_1:InitPlayNodeList()
	end,
	Play411051109 = function(arg_454_0, arg_454_1)
		arg_454_1.time_ = 0
		arg_454_1.frameCnt_ = 0
		arg_454_1.state_ = "playing"
		arg_454_1.curTalkId_ = 411051109
		arg_454_1.duration_ = 15

		local var_454_0 = {
			zh = 15,
			ja = 11.066
		}
		local var_454_1 = manager.audio:GetLocalizationFlag()

		if var_454_0[var_454_1] ~= nil then
			arg_454_1.duration_ = var_454_0[var_454_1]
		end

		SetActive(arg_454_1.tipsGo_, false)

		function arg_454_1.onSingleLineFinish_()
			arg_454_1.onSingleLineUpdate_ = nil
			arg_454_1.onSingleLineFinish_ = nil
			arg_454_1.state_ = "waiting"
		end

		function arg_454_1.playNext_(arg_456_0)
			if arg_456_0 == 1 then
				arg_454_0:Play411051110(arg_454_1)
			end
		end

		function arg_454_1.onSingleLineUpdate_(arg_457_0)
			local var_457_0 = 1.6

			if 0 < arg_454_1.time_ and arg_454_1.time_ <= 0 + arg_457_0 then
				arg_454_1.talkMaxDuration = 0
				arg_454_1.dialogCg_.alpha = 1

				arg_454_1.dialog_:SetActive(true)
				SetActive(arg_454_1.leftNameGo_, true)

				arg_454_1.leftNameTxt_.text = arg_454_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_454_1.leftNameTxt_.transform)

				arg_454_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_454_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_454_1:RecordName(arg_454_1.leftNameTxt_.text)
				SetActive(arg_454_1.iconTrs_.gameObject, true)
				arg_454_1.iconController_:SetSelectedState("hero")

				arg_454_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_454_1.callingController_:SetSelectedState("normal")

				arg_454_1.keyicon_.color = Color.New(1, 1, 1)
				arg_454_1.icon_.color = Color.New(1, 1, 1)

				local var_457_1 = arg_454_1:GetWordFromCfg(411051109)
				local var_457_2 = arg_454_1:FormatText(var_457_1.content)

				arg_454_1.text_.text = var_457_2

				LuaForUtil.ClearLinePrefixSymbol(arg_454_1.text_)

				local var_457_4 = 64 <= 0 and var_457_0 or var_457_0 * (utf8.len(var_457_2) / 64)

				if (64 <= 0 and var_457_0 or var_457_0 * (utf8.len(var_457_2) / 64)) > 0 and var_457_0 < var_457_4 then
					arg_454_1.talkMaxDuration = var_457_4

					if var_457_4 + 0 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_4 + 0
					end
				end

				arg_454_1.text_.text = var_457_2
				arg_454_1.typewritter.percent = 0

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051109", "story_v_out_411051.awb") ~= 0 then
					local var_457_5 = manager.audio:GetVoiceLength("story_v_out_411051", "411051109", "story_v_out_411051.awb") / 1000

					if var_457_5 + 0 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_5 + 0
					end

					if var_457_1.prefab_name ~= "" and arg_454_1.actors_[var_457_1.prefab_name] ~= nil then
						local var_457_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_454_1.actors_[var_457_1.prefab_name].transform, "story_v_out_411051", "411051109", "story_v_out_411051.awb")

						arg_454_1:RecordAudio("411051109", var_457_6)
						arg_454_1:RecordAudio("411051109", var_457_6)
					else
						arg_454_1:AudioAction("play", "voice", "story_v_out_411051", "411051109", "story_v_out_411051.awb")
					end

					arg_454_1:RecordHistoryTalkVoice("story_v_out_411051", "411051109", "story_v_out_411051.awb")
				end

				arg_454_1:RecordContent(arg_454_1.text_.text)
			end

			local var_457_7 = math.max(var_457_0, arg_454_1.talkMaxDuration)

			if 0 <= arg_454_1.time_ and arg_454_1.time_ < 0 + var_457_7 then
				arg_454_1.typewritter.percent = (arg_454_1.time_ - 0) / var_457_7

				arg_454_1.typewritter:SetDirty()
			end

			if arg_454_1.time_ >= 0 + var_457_7 and arg_454_1.time_ < 0 + var_457_7 + arg_457_0 then
				arg_454_1.typewritter.percent = 1

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(true)
			end
		end

		arg_454_1.nodeConfigList_ = {}

		arg_454_1:InitPlayNodeList()
	end,
	Play411051110 = function(arg_458_0, arg_458_1)
		arg_458_1.time_ = 0
		arg_458_1.frameCnt_ = 0
		arg_458_1.state_ = "playing"
		arg_458_1.curTalkId_ = 411051110
		arg_458_1.duration_ = 11.57

		local var_458_0 = {
			zh = 11.433,
			ja = 11.566
		}
		local var_458_1 = manager.audio:GetLocalizationFlag()

		if var_458_0[var_458_1] ~= nil then
			arg_458_1.duration_ = var_458_0[var_458_1]
		end

		SetActive(arg_458_1.tipsGo_, false)

		function arg_458_1.onSingleLineFinish_()
			arg_458_1.onSingleLineUpdate_ = nil
			arg_458_1.onSingleLineFinish_ = nil
			arg_458_1.state_ = "waiting"
		end

		function arg_458_1.playNext_(arg_460_0)
			if arg_460_0 == 1 then
				arg_458_0:Play411051111(arg_458_1)
			end
		end

		function arg_458_1.onSingleLineUpdate_(arg_461_0)
			local var_461_0 = 1.125

			if 0 < arg_458_1.time_ and arg_458_1.time_ <= 0 + arg_461_0 then
				arg_458_1.talkMaxDuration = 0
				arg_458_1.dialogCg_.alpha = 1

				arg_458_1.dialog_:SetActive(true)
				SetActive(arg_458_1.leftNameGo_, true)

				arg_458_1.leftNameTxt_.text = arg_458_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_458_1.leftNameTxt_.transform)

				arg_458_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_458_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_458_1:RecordName(arg_458_1.leftNameTxt_.text)
				SetActive(arg_458_1.iconTrs_.gameObject, true)
				arg_458_1.iconController_:SetSelectedState("hero")

				arg_458_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_458_1.callingController_:SetSelectedState("normal")

				arg_458_1.keyicon_.color = Color.New(1, 1, 1)
				arg_458_1.icon_.color = Color.New(1, 1, 1)

				local var_461_1 = arg_458_1:GetWordFromCfg(411051110)
				local var_461_2 = arg_458_1:FormatText(var_461_1.content)

				arg_458_1.text_.text = var_461_2

				LuaForUtil.ClearLinePrefixSymbol(arg_458_1.text_)

				local var_461_4 = 45 <= 0 and var_461_0 or var_461_0 * (utf8.len(var_461_2) / 45)

				if (45 <= 0 and var_461_0 or var_461_0 * (utf8.len(var_461_2) / 45)) > 0 and var_461_0 < var_461_4 then
					arg_458_1.talkMaxDuration = var_461_4

					if var_461_4 + 0 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_4 + 0
					end
				end

				arg_458_1.text_.text = var_461_2
				arg_458_1.typewritter.percent = 0

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051110", "story_v_out_411051.awb") ~= 0 then
					local var_461_5 = manager.audio:GetVoiceLength("story_v_out_411051", "411051110", "story_v_out_411051.awb") / 1000

					if var_461_5 + 0 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_5 + 0
					end

					if var_461_1.prefab_name ~= "" and arg_458_1.actors_[var_461_1.prefab_name] ~= nil then
						local var_461_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_458_1.actors_[var_461_1.prefab_name].transform, "story_v_out_411051", "411051110", "story_v_out_411051.awb")

						arg_458_1:RecordAudio("411051110", var_461_6)
						arg_458_1:RecordAudio("411051110", var_461_6)
					else
						arg_458_1:AudioAction("play", "voice", "story_v_out_411051", "411051110", "story_v_out_411051.awb")
					end

					arg_458_1:RecordHistoryTalkVoice("story_v_out_411051", "411051110", "story_v_out_411051.awb")
				end

				arg_458_1:RecordContent(arg_458_1.text_.text)
			end

			local var_461_7 = math.max(var_461_0, arg_458_1.talkMaxDuration)

			if 0 <= arg_458_1.time_ and arg_458_1.time_ < 0 + var_461_7 then
				arg_458_1.typewritter.percent = (arg_458_1.time_ - 0) / var_461_7

				arg_458_1.typewritter:SetDirty()
			end

			if arg_458_1.time_ >= 0 + var_461_7 and arg_458_1.time_ < 0 + var_461_7 + arg_461_0 then
				arg_458_1.typewritter.percent = 1

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(true)
			end
		end

		arg_458_1.nodeConfigList_ = {}

		arg_458_1:InitPlayNodeList()
	end,
	Play411051111 = function(arg_462_0, arg_462_1)
		arg_462_1.time_ = 0
		arg_462_1.frameCnt_ = 0
		arg_462_1.state_ = "playing"
		arg_462_1.curTalkId_ = 411051111
		arg_462_1.duration_ = 8.63

		local var_462_0 = {
			zh = 4.133,
			ja = 8.633
		}
		local var_462_1 = manager.audio:GetLocalizationFlag()

		if var_462_0[var_462_1] ~= nil then
			arg_462_1.duration_ = var_462_0[var_462_1]
		end

		SetActive(arg_462_1.tipsGo_, false)

		function arg_462_1.onSingleLineFinish_()
			arg_462_1.onSingleLineUpdate_ = nil
			arg_462_1.onSingleLineFinish_ = nil
			arg_462_1.state_ = "waiting"
		end

		function arg_462_1.playNext_(arg_464_0)
			if arg_464_0 == 1 then
				arg_462_0:Play411051112(arg_462_1)
			end
		end

		function arg_462_1.onSingleLineUpdate_(arg_465_0)
			if 0 < arg_462_1.time_ and arg_462_1.time_ <= 0 + arg_465_0 and not isNil(arg_462_1.actors_["1095ui_story"]) and arg_462_1.var_.characterEffect1095ui_story == nil then
				arg_462_1.var_.characterEffect1095ui_story = arg_462_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_465_0 = 0.200000002980232

			if 0 <= arg_462_1.time_ and arg_462_1.time_ < 0 + var_465_0 and not isNil(arg_462_1.actors_["1095ui_story"]) then
				if arg_462_1.var_.characterEffect1095ui_story and not isNil(arg_462_1.actors_["1095ui_story"]) then
					arg_462_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_462_1.time_ >= 0 + var_465_0 and arg_462_1.time_ < 0 + var_465_0 + arg_465_0 and not isNil(arg_462_1.actors_["1095ui_story"]) and arg_462_1.var_.characterEffect1095ui_story then
				arg_462_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_465_2 = 0
			local var_465_3 = 0.45

			if 0 < arg_462_1.time_ and arg_462_1.time_ <= var_465_2 + arg_465_0 then
				arg_462_1.talkMaxDuration = 0
				arg_462_1.dialogCg_.alpha = 1

				arg_462_1.dialog_:SetActive(true)
				SetActive(arg_462_1.leftNameGo_, true)

				arg_462_1.leftNameTxt_.text = arg_462_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_462_1.leftNameTxt_.transform)

				arg_462_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_462_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_462_1:RecordName(arg_462_1.leftNameTxt_.text)
				SetActive(arg_462_1.iconTrs_.gameObject, false)
				arg_462_1.callingController_:SetSelectedState("normal")

				local var_465_4 = arg_462_1:GetWordFromCfg(411051111)
				local var_465_5 = arg_462_1:FormatText(var_465_4.content)

				arg_462_1.text_.text = var_465_5

				LuaForUtil.ClearLinePrefixSymbol(arg_462_1.text_)

				local var_465_7 = 18 <= 0 and var_465_3 or var_465_3 * (utf8.len(var_465_5) / 18)

				if (18 <= 0 and var_465_3 or var_465_3 * (utf8.len(var_465_5) / 18)) > 0 and var_465_3 < var_465_7 then
					arg_462_1.talkMaxDuration = var_465_7

					if var_465_7 + var_465_2 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_7 + var_465_2
					end
				end

				arg_462_1.text_.text = var_465_5
				arg_462_1.typewritter.percent = 0

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051111", "story_v_out_411051.awb") ~= 0 then
					local var_465_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051111", "story_v_out_411051.awb") / 1000

					if var_465_8 + var_465_2 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_8 + var_465_2
					end

					if var_465_4.prefab_name ~= "" and arg_462_1.actors_[var_465_4.prefab_name] ~= nil then
						local var_465_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_462_1.actors_[var_465_4.prefab_name].transform, "story_v_out_411051", "411051111", "story_v_out_411051.awb")

						arg_462_1:RecordAudio("411051111", var_465_9)
						arg_462_1:RecordAudio("411051111", var_465_9)
					else
						arg_462_1:AudioAction("play", "voice", "story_v_out_411051", "411051111", "story_v_out_411051.awb")
					end

					arg_462_1:RecordHistoryTalkVoice("story_v_out_411051", "411051111", "story_v_out_411051.awb")
				end

				arg_462_1:RecordContent(arg_462_1.text_.text)
			end

			local var_465_10 = math.max(var_465_3, arg_462_1.talkMaxDuration)

			if var_465_2 <= arg_462_1.time_ and arg_462_1.time_ < var_465_2 + var_465_10 then
				arg_462_1.typewritter.percent = (arg_462_1.time_ - var_465_2) / var_465_10

				arg_462_1.typewritter:SetDirty()
			end

			if arg_462_1.time_ >= var_465_2 + var_465_10 and arg_462_1.time_ < var_465_2 + var_465_10 + arg_465_0 then
				arg_462_1.typewritter.percent = 1

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(true)
			end
		end

		arg_462_1.nodeConfigList_ = {}

		arg_462_1:InitPlayNodeList()
	end,
	Play411051112 = function(arg_466_0, arg_466_1)
		arg_466_1.time_ = 0
		arg_466_1.frameCnt_ = 0
		arg_466_1.state_ = "playing"
		arg_466_1.curTalkId_ = 411051112
		arg_466_1.duration_ = 8.37

		local var_466_0 = {
			zh = 8.366,
			ja = 2.966
		}
		local var_466_1 = manager.audio:GetLocalizationFlag()

		if var_466_0[var_466_1] ~= nil then
			arg_466_1.duration_ = var_466_0[var_466_1]
		end

		SetActive(arg_466_1.tipsGo_, false)

		function arg_466_1.onSingleLineFinish_()
			arg_466_1.onSingleLineUpdate_ = nil
			arg_466_1.onSingleLineFinish_ = nil
			arg_466_1.state_ = "waiting"
		end

		function arg_466_1.playNext_(arg_468_0)
			if arg_468_0 == 1 then
				arg_466_0:Play411051113(arg_466_1)
			end
		end

		function arg_466_1.onSingleLineUpdate_(arg_469_0)
			if 0 < arg_466_1.time_ and arg_466_1.time_ <= 0 + arg_469_0 and not isNil(arg_466_1.actors_["1095ui_story"]) and arg_466_1.var_.characterEffect1095ui_story == nil then
				arg_466_1.var_.characterEffect1095ui_story = arg_466_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_469_0 = 0.200000002980232

			if 0 <= arg_466_1.time_ and arg_466_1.time_ < 0 + var_469_0 and not isNil(arg_466_1.actors_["1095ui_story"]) then
				if arg_466_1.var_.characterEffect1095ui_story and not isNil(arg_466_1.actors_["1095ui_story"]) then
					arg_466_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_466_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_466_1.time_ - 0) / var_469_0)
				end
			end

			if arg_466_1.time_ >= 0 + var_469_0 and arg_466_1.time_ < 0 + var_469_0 + arg_469_0 and not isNil(arg_466_1.actors_["1095ui_story"]) and arg_466_1.var_.characterEffect1095ui_story then
				arg_466_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_466_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_469_1 = 0
			local var_469_2 = 1

			if 0 < arg_466_1.time_ and arg_466_1.time_ <= var_469_1 + arg_469_0 then
				arg_466_1.talkMaxDuration = 0
				arg_466_1.dialogCg_.alpha = 1

				arg_466_1.dialog_:SetActive(true)
				SetActive(arg_466_1.leftNameGo_, true)

				arg_466_1.leftNameTxt_.text = arg_466_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_466_1.leftNameTxt_.transform)

				arg_466_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_466_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_466_1:RecordName(arg_466_1.leftNameTxt_.text)
				SetActive(arg_466_1.iconTrs_.gameObject, true)
				arg_466_1.iconController_:SetSelectedState("hero")

				arg_466_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_466_1.callingController_:SetSelectedState("normal")

				arg_466_1.keyicon_.color = Color.New(1, 1, 1)
				arg_466_1.icon_.color = Color.New(1, 1, 1)

				local var_469_3 = arg_466_1:GetWordFromCfg(411051112)
				local var_469_4 = arg_466_1:FormatText(var_469_3.content)

				arg_466_1.text_.text = var_469_4

				LuaForUtil.ClearLinePrefixSymbol(arg_466_1.text_)

				local var_469_6 = 40 <= 0 and var_469_2 or var_469_2 * (utf8.len(var_469_4) / 40)

				if (40 <= 0 and var_469_2 or var_469_2 * (utf8.len(var_469_4) / 40)) > 0 and var_469_2 < var_469_6 then
					arg_466_1.talkMaxDuration = var_469_6

					if var_469_6 + var_469_1 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_6 + var_469_1
					end
				end

				arg_466_1.text_.text = var_469_4
				arg_466_1.typewritter.percent = 0

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051112", "story_v_out_411051.awb") ~= 0 then
					local var_469_7 = manager.audio:GetVoiceLength("story_v_out_411051", "411051112", "story_v_out_411051.awb") / 1000

					if var_469_7 + var_469_1 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_7 + var_469_1
					end

					if var_469_3.prefab_name ~= "" and arg_466_1.actors_[var_469_3.prefab_name] ~= nil then
						local var_469_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_466_1.actors_[var_469_3.prefab_name].transform, "story_v_out_411051", "411051112", "story_v_out_411051.awb")

						arg_466_1:RecordAudio("411051112", var_469_8)
						arg_466_1:RecordAudio("411051112", var_469_8)
					else
						arg_466_1:AudioAction("play", "voice", "story_v_out_411051", "411051112", "story_v_out_411051.awb")
					end

					arg_466_1:RecordHistoryTalkVoice("story_v_out_411051", "411051112", "story_v_out_411051.awb")
				end

				arg_466_1:RecordContent(arg_466_1.text_.text)
			end

			local var_469_9 = math.max(var_469_2, arg_466_1.talkMaxDuration)

			if var_469_1 <= arg_466_1.time_ and arg_466_1.time_ < var_469_1 + var_469_9 then
				arg_466_1.typewritter.percent = (arg_466_1.time_ - var_469_1) / var_469_9

				arg_466_1.typewritter:SetDirty()
			end

			if arg_466_1.time_ >= var_469_1 + var_469_9 and arg_466_1.time_ < var_469_1 + var_469_9 + arg_469_0 then
				arg_466_1.typewritter.percent = 1

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(true)
			end
		end

		arg_466_1.nodeConfigList_ = {}

		arg_466_1:InitPlayNodeList()
	end,
	Play411051113 = function(arg_470_0, arg_470_1)
		arg_470_1.time_ = 0
		arg_470_1.frameCnt_ = 0
		arg_470_1.state_ = "playing"
		arg_470_1.curTalkId_ = 411051113
		arg_470_1.duration_ = 7.7

		local var_470_0 = {
			zh = 7.7,
			ja = 6.2
		}
		local var_470_1 = manager.audio:GetLocalizationFlag()

		if var_470_0[var_470_1] ~= nil then
			arg_470_1.duration_ = var_470_0[var_470_1]
		end

		SetActive(arg_470_1.tipsGo_, false)

		function arg_470_1.onSingleLineFinish_()
			arg_470_1.onSingleLineUpdate_ = nil
			arg_470_1.onSingleLineFinish_ = nil
			arg_470_1.state_ = "waiting"
		end

		function arg_470_1.playNext_(arg_472_0)
			if arg_472_0 == 1 then
				arg_470_0:Play411051114(arg_470_1)
			end
		end

		function arg_470_1.onSingleLineUpdate_(arg_473_0)
			local var_473_0 = 0.625

			if 0 < arg_470_1.time_ and arg_470_1.time_ <= 0 + arg_473_0 then
				arg_470_1.talkMaxDuration = 0
				arg_470_1.dialogCg_.alpha = 1

				arg_470_1.dialog_:SetActive(true)
				SetActive(arg_470_1.leftNameGo_, true)

				arg_470_1.leftNameTxt_.text = arg_470_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_470_1.leftNameTxt_.transform)

				arg_470_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_470_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_470_1:RecordName(arg_470_1.leftNameTxt_.text)
				SetActive(arg_470_1.iconTrs_.gameObject, true)
				arg_470_1.iconController_:SetSelectedState("hero")

				arg_470_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_470_1.callingController_:SetSelectedState("normal")

				arg_470_1.keyicon_.color = Color.New(1, 1, 1)
				arg_470_1.icon_.color = Color.New(1, 1, 1)

				local var_473_1 = arg_470_1:GetWordFromCfg(411051113)
				local var_473_2 = arg_470_1:FormatText(var_473_1.content)

				arg_470_1.text_.text = var_473_2

				LuaForUtil.ClearLinePrefixSymbol(arg_470_1.text_)

				local var_473_4 = 25 <= 0 and var_473_0 or var_473_0 * (utf8.len(var_473_2) / 25)

				if (25 <= 0 and var_473_0 or var_473_0 * (utf8.len(var_473_2) / 25)) > 0 and var_473_0 < var_473_4 then
					arg_470_1.talkMaxDuration = var_473_4

					if var_473_4 + 0 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_4 + 0
					end
				end

				arg_470_1.text_.text = var_473_2
				arg_470_1.typewritter.percent = 0

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051113", "story_v_out_411051.awb") ~= 0 then
					local var_473_5 = manager.audio:GetVoiceLength("story_v_out_411051", "411051113", "story_v_out_411051.awb") / 1000

					if var_473_5 + 0 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_5 + 0
					end

					if var_473_1.prefab_name ~= "" and arg_470_1.actors_[var_473_1.prefab_name] ~= nil then
						local var_473_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_470_1.actors_[var_473_1.prefab_name].transform, "story_v_out_411051", "411051113", "story_v_out_411051.awb")

						arg_470_1:RecordAudio("411051113", var_473_6)
						arg_470_1:RecordAudio("411051113", var_473_6)
					else
						arg_470_1:AudioAction("play", "voice", "story_v_out_411051", "411051113", "story_v_out_411051.awb")
					end

					arg_470_1:RecordHistoryTalkVoice("story_v_out_411051", "411051113", "story_v_out_411051.awb")
				end

				arg_470_1:RecordContent(arg_470_1.text_.text)
			end

			local var_473_7 = math.max(var_473_0, arg_470_1.talkMaxDuration)

			if 0 <= arg_470_1.time_ and arg_470_1.time_ < 0 + var_473_7 then
				arg_470_1.typewritter.percent = (arg_470_1.time_ - 0) / var_473_7

				arg_470_1.typewritter:SetDirty()
			end

			if arg_470_1.time_ >= 0 + var_473_7 and arg_470_1.time_ < 0 + var_473_7 + arg_473_0 then
				arg_470_1.typewritter.percent = 1

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(true)
			end
		end

		arg_470_1.nodeConfigList_ = {}

		arg_470_1:InitPlayNodeList()
	end,
	Play411051114 = function(arg_474_0, arg_474_1)
		arg_474_1.time_ = 0
		arg_474_1.frameCnt_ = 0
		arg_474_1.state_ = "playing"
		arg_474_1.curTalkId_ = 411051114
		arg_474_1.duration_ = 14.97

		local var_474_0 = {
			zh = 11.966,
			ja = 14.966
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
				arg_474_0:Play411051115(arg_474_1)
			end
		end

		function arg_474_1.onSingleLineUpdate_(arg_477_0)
			if 0 < arg_474_1.time_ and arg_474_1.time_ <= 0 + arg_477_0 then
				arg_474_1.var_.moveOldPos1095ui_story = arg_474_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_477_0 = 0.001

			if 0 <= arg_474_1.time_ and arg_474_1.time_ < 0 + var_477_0 then
				arg_474_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_474_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_474_1.time_ - 0) / var_477_0)
				arg_474_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_474_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_474_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_474_1.actors_["1095ui_story"].transform.position).z)
				arg_474_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_474_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_474_1.actors_["1095ui_story"].transform.localEulerAngles = arg_474_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_474_1.time_ >= 0 + var_477_0 and arg_474_1.time_ < 0 + var_477_0 + arg_477_0 then
				arg_474_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_474_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_474_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_474_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_474_1.actors_["1095ui_story"].transform.position).z)
				arg_474_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_474_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_474_1.actors_["1095ui_story"].transform.localEulerAngles = arg_474_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_477_1 = arg_474_1.actors_["1095ui_story"]

			if 0 < arg_474_1.time_ and arg_474_1.time_ <= 0 + arg_477_0 and not isNil(var_477_1) and arg_474_1.var_.characterEffect1095ui_story == nil then
				arg_474_1.var_.characterEffect1095ui_story = var_477_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_477_2 = 0.200000002980232

			if 0 <= arg_474_1.time_ and arg_474_1.time_ < 0 + var_477_2 and not isNil(var_477_1) then
				if arg_474_1.var_.characterEffect1095ui_story and not isNil(var_477_1) then
					arg_474_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_474_1.time_ >= 0 + var_477_2 and arg_474_1.time_ < 0 + var_477_2 + arg_477_0 and not isNil(var_477_1) and arg_474_1.var_.characterEffect1095ui_story then
				arg_474_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_474_1.time_ and arg_474_1.time_ <= 0 + arg_477_0 then
				arg_474_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_474_1.time_ and arg_474_1.time_ <= 0 + arg_477_0 then
				arg_474_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_477_4 = 0
			local var_477_5 = 1.5

			if 0 < arg_474_1.time_ and arg_474_1.time_ <= var_477_4 + arg_477_0 then
				arg_474_1.talkMaxDuration = 0
				arg_474_1.dialogCg_.alpha = 1

				arg_474_1.dialog_:SetActive(true)
				SetActive(arg_474_1.leftNameGo_, true)

				arg_474_1.leftNameTxt_.text = arg_474_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_474_1.leftNameTxt_.transform)

				arg_474_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_474_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_474_1:RecordName(arg_474_1.leftNameTxt_.text)
				SetActive(arg_474_1.iconTrs_.gameObject, false)
				arg_474_1.callingController_:SetSelectedState("normal")

				local var_477_6 = arg_474_1:GetWordFromCfg(411051114)
				local var_477_7 = arg_474_1:FormatText(var_477_6.content)

				arg_474_1.text_.text = var_477_7

				LuaForUtil.ClearLinePrefixSymbol(arg_474_1.text_)

				local var_477_9 = 60 <= 0 and var_477_5 or var_477_5 * (utf8.len(var_477_7) / 60)

				if (60 <= 0 and var_477_5 or var_477_5 * (utf8.len(var_477_7) / 60)) > 0 and var_477_5 < var_477_9 then
					arg_474_1.talkMaxDuration = var_477_9

					if var_477_9 + var_477_4 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_9 + var_477_4
					end
				end

				arg_474_1.text_.text = var_477_7
				arg_474_1.typewritter.percent = 0

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051114", "story_v_out_411051.awb") ~= 0 then
					local var_477_10 = manager.audio:GetVoiceLength("story_v_out_411051", "411051114", "story_v_out_411051.awb") / 1000

					if var_477_10 + var_477_4 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_10 + var_477_4
					end

					if var_477_6.prefab_name ~= "" and arg_474_1.actors_[var_477_6.prefab_name] ~= nil then
						local var_477_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_474_1.actors_[var_477_6.prefab_name].transform, "story_v_out_411051", "411051114", "story_v_out_411051.awb")

						arg_474_1:RecordAudio("411051114", var_477_11)
						arg_474_1:RecordAudio("411051114", var_477_11)
					else
						arg_474_1:AudioAction("play", "voice", "story_v_out_411051", "411051114", "story_v_out_411051.awb")
					end

					arg_474_1:RecordHistoryTalkVoice("story_v_out_411051", "411051114", "story_v_out_411051.awb")
				end

				arg_474_1:RecordContent(arg_474_1.text_.text)
			end

			local var_477_12 = math.max(var_477_5, arg_474_1.talkMaxDuration)

			if var_477_4 <= arg_474_1.time_ and arg_474_1.time_ < var_477_4 + var_477_12 then
				arg_474_1.typewritter.percent = (arg_474_1.time_ - var_477_4) / var_477_12

				arg_474_1.typewritter:SetDirty()
			end

			if arg_474_1.time_ >= var_477_4 + var_477_12 and arg_474_1.time_ < var_477_4 + var_477_12 + arg_477_0 then
				arg_474_1.typewritter.percent = 1

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(true)
			end
		end

		arg_474_1.nodeConfigList_ = {
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

		arg_474_1:InitPlayNodeList()
	end,
	Play411051115 = function(arg_478_0, arg_478_1)
		arg_478_1.time_ = 0
		arg_478_1.frameCnt_ = 0
		arg_478_1.state_ = "playing"
		arg_478_1.curTalkId_ = 411051115
		arg_478_1.duration_ = 10.97

		local var_478_0 = {
			zh = 8.833,
			ja = 10.966
		}
		local var_478_1 = manager.audio:GetLocalizationFlag()

		if var_478_0[var_478_1] ~= nil then
			arg_478_1.duration_ = var_478_0[var_478_1]
		end

		SetActive(arg_478_1.tipsGo_, false)

		function arg_478_1.onSingleLineFinish_()
			arg_478_1.onSingleLineUpdate_ = nil
			arg_478_1.onSingleLineFinish_ = nil
			arg_478_1.state_ = "waiting"
		end

		function arg_478_1.playNext_(arg_480_0)
			if arg_480_0 == 1 then
				arg_478_0:Play411051116(arg_478_1)
			end
		end

		function arg_478_1.onSingleLineUpdate_(arg_481_0)
			local var_481_0 = 1.075

			if 0 < arg_478_1.time_ and arg_478_1.time_ <= 0 + arg_481_0 then
				arg_478_1.talkMaxDuration = 0
				arg_478_1.dialogCg_.alpha = 1

				arg_478_1.dialog_:SetActive(true)
				SetActive(arg_478_1.leftNameGo_, true)

				arg_478_1.leftNameTxt_.text = arg_478_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_478_1.leftNameTxt_.transform)

				arg_478_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_478_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_478_1:RecordName(arg_478_1.leftNameTxt_.text)
				SetActive(arg_478_1.iconTrs_.gameObject, false)
				arg_478_1.callingController_:SetSelectedState("normal")

				local var_481_1 = arg_478_1:GetWordFromCfg(411051115)
				local var_481_2 = arg_478_1:FormatText(var_481_1.content)

				arg_478_1.text_.text = var_481_2

				LuaForUtil.ClearLinePrefixSymbol(arg_478_1.text_)

				local var_481_4 = 43 <= 0 and var_481_0 or var_481_0 * (utf8.len(var_481_2) / 43)

				if (43 <= 0 and var_481_0 or var_481_0 * (utf8.len(var_481_2) / 43)) > 0 and var_481_0 < var_481_4 then
					arg_478_1.talkMaxDuration = var_481_4

					if var_481_4 + 0 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_4 + 0
					end
				end

				arg_478_1.text_.text = var_481_2
				arg_478_1.typewritter.percent = 0

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051115", "story_v_out_411051.awb") ~= 0 then
					local var_481_5 = manager.audio:GetVoiceLength("story_v_out_411051", "411051115", "story_v_out_411051.awb") / 1000

					if var_481_5 + 0 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_5 + 0
					end

					if var_481_1.prefab_name ~= "" and arg_478_1.actors_[var_481_1.prefab_name] ~= nil then
						local var_481_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_478_1.actors_[var_481_1.prefab_name].transform, "story_v_out_411051", "411051115", "story_v_out_411051.awb")

						arg_478_1:RecordAudio("411051115", var_481_6)
						arg_478_1:RecordAudio("411051115", var_481_6)
					else
						arg_478_1:AudioAction("play", "voice", "story_v_out_411051", "411051115", "story_v_out_411051.awb")
					end

					arg_478_1:RecordHistoryTalkVoice("story_v_out_411051", "411051115", "story_v_out_411051.awb")
				end

				arg_478_1:RecordContent(arg_478_1.text_.text)
			end

			local var_481_7 = math.max(var_481_0, arg_478_1.talkMaxDuration)

			if 0 <= arg_478_1.time_ and arg_478_1.time_ < 0 + var_481_7 then
				arg_478_1.typewritter.percent = (arg_478_1.time_ - 0) / var_481_7

				arg_478_1.typewritter:SetDirty()
			end

			if arg_478_1.time_ >= 0 + var_481_7 and arg_478_1.time_ < 0 + var_481_7 + arg_481_0 then
				arg_478_1.typewritter.percent = 1

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(true)
			end
		end

		arg_478_1.nodeConfigList_ = {}

		arg_478_1:InitPlayNodeList()
	end,
	Play411051116 = function(arg_482_0, arg_482_1)
		arg_482_1.time_ = 0
		arg_482_1.frameCnt_ = 0
		arg_482_1.state_ = "playing"
		arg_482_1.curTalkId_ = 411051116
		arg_482_1.duration_ = 8.6

		local var_482_0 = {
			zh = 8.2,
			ja = 8.6
		}
		local var_482_1 = manager.audio:GetLocalizationFlag()

		if var_482_0[var_482_1] ~= nil then
			arg_482_1.duration_ = var_482_0[var_482_1]
		end

		SetActive(arg_482_1.tipsGo_, false)

		function arg_482_1.onSingleLineFinish_()
			arg_482_1.onSingleLineUpdate_ = nil
			arg_482_1.onSingleLineFinish_ = nil
			arg_482_1.state_ = "waiting"
		end

		function arg_482_1.playNext_(arg_484_0)
			if arg_484_0 == 1 then
				arg_482_0:Play411051117(arg_482_1)
			end
		end

		function arg_482_1.onSingleLineUpdate_(arg_485_0)
			if 0 < arg_482_1.time_ and arg_482_1.time_ <= 0 + arg_485_0 and not isNil(arg_482_1.actors_["1095ui_story"]) and arg_482_1.var_.characterEffect1095ui_story == nil then
				arg_482_1.var_.characterEffect1095ui_story = arg_482_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_485_0 = 0.200000002980232

			if 0 <= arg_482_1.time_ and arg_482_1.time_ < 0 + var_485_0 and not isNil(arg_482_1.actors_["1095ui_story"]) then
				if arg_482_1.var_.characterEffect1095ui_story and not isNil(arg_482_1.actors_["1095ui_story"]) then
					arg_482_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_482_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_482_1.time_ - 0) / var_485_0)
				end
			end

			if arg_482_1.time_ >= 0 + var_485_0 and arg_482_1.time_ < 0 + var_485_0 + arg_485_0 and not isNil(arg_482_1.actors_["1095ui_story"]) and arg_482_1.var_.characterEffect1095ui_story then
				arg_482_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_482_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_485_1 = 0
			local var_485_2 = 0.65

			if 0 < arg_482_1.time_ and arg_482_1.time_ <= var_485_1 + arg_485_0 then
				arg_482_1.talkMaxDuration = 0
				arg_482_1.dialogCg_.alpha = 1

				arg_482_1.dialog_:SetActive(true)
				SetActive(arg_482_1.leftNameGo_, true)

				arg_482_1.leftNameTxt_.text = arg_482_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_482_1.leftNameTxt_.transform)

				arg_482_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_482_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_482_1:RecordName(arg_482_1.leftNameTxt_.text)
				SetActive(arg_482_1.iconTrs_.gameObject, true)
				arg_482_1.iconController_:SetSelectedState("hero")

				arg_482_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_482_1.callingController_:SetSelectedState("normal")

				arg_482_1.keyicon_.color = Color.New(1, 1, 1)
				arg_482_1.icon_.color = Color.New(1, 1, 1)

				local var_485_3 = arg_482_1:GetWordFromCfg(411051116)
				local var_485_4 = arg_482_1:FormatText(var_485_3.content)

				arg_482_1.text_.text = var_485_4

				LuaForUtil.ClearLinePrefixSymbol(arg_482_1.text_)

				local var_485_6 = 26 <= 0 and var_485_2 or var_485_2 * (utf8.len(var_485_4) / 26)

				if (26 <= 0 and var_485_2 or var_485_2 * (utf8.len(var_485_4) / 26)) > 0 and var_485_2 < var_485_6 then
					arg_482_1.talkMaxDuration = var_485_6

					if var_485_6 + var_485_1 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_6 + var_485_1
					end
				end

				arg_482_1.text_.text = var_485_4
				arg_482_1.typewritter.percent = 0

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051116", "story_v_out_411051.awb") ~= 0 then
					local var_485_7 = manager.audio:GetVoiceLength("story_v_out_411051", "411051116", "story_v_out_411051.awb") / 1000

					if var_485_7 + var_485_1 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_7 + var_485_1
					end

					if var_485_3.prefab_name ~= "" and arg_482_1.actors_[var_485_3.prefab_name] ~= nil then
						local var_485_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_482_1.actors_[var_485_3.prefab_name].transform, "story_v_out_411051", "411051116", "story_v_out_411051.awb")

						arg_482_1:RecordAudio("411051116", var_485_8)
						arg_482_1:RecordAudio("411051116", var_485_8)
					else
						arg_482_1:AudioAction("play", "voice", "story_v_out_411051", "411051116", "story_v_out_411051.awb")
					end

					arg_482_1:RecordHistoryTalkVoice("story_v_out_411051", "411051116", "story_v_out_411051.awb")
				end

				arg_482_1:RecordContent(arg_482_1.text_.text)
			end

			local var_485_9 = math.max(var_485_2, arg_482_1.talkMaxDuration)

			if var_485_1 <= arg_482_1.time_ and arg_482_1.time_ < var_485_1 + var_485_9 then
				arg_482_1.typewritter.percent = (arg_482_1.time_ - var_485_1) / var_485_9

				arg_482_1.typewritter:SetDirty()
			end

			if arg_482_1.time_ >= var_485_1 + var_485_9 and arg_482_1.time_ < var_485_1 + var_485_9 + arg_485_0 then
				arg_482_1.typewritter.percent = 1

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(true)
			end
		end

		arg_482_1.nodeConfigList_ = {}

		arg_482_1:InitPlayNodeList()
	end,
	Play411051117 = function(arg_486_0, arg_486_1)
		arg_486_1.time_ = 0
		arg_486_1.frameCnt_ = 0
		arg_486_1.state_ = "playing"
		arg_486_1.curTalkId_ = 411051117
		arg_486_1.duration_ = 6.4

		local var_486_0 = {
			zh = 4.266,
			ja = 6.4
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
				arg_486_0:Play411051118(arg_486_1)
			end
		end

		function arg_486_1.onSingleLineUpdate_(arg_489_0)
			if 0 < arg_486_1.time_ and arg_486_1.time_ <= 0 + arg_489_0 and not isNil(arg_486_1.actors_["1095ui_story"]) and arg_486_1.var_.characterEffect1095ui_story == nil then
				arg_486_1.var_.characterEffect1095ui_story = arg_486_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_489_0 = 0.200000002980232

			if 0 <= arg_486_1.time_ and arg_486_1.time_ < 0 + var_489_0 and not isNil(arg_486_1.actors_["1095ui_story"]) then
				if arg_486_1.var_.characterEffect1095ui_story and not isNil(arg_486_1.actors_["1095ui_story"]) then
					arg_486_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_486_1.time_ >= 0 + var_489_0 and arg_486_1.time_ < 0 + var_489_0 + arg_489_0 and not isNil(arg_486_1.actors_["1095ui_story"]) and arg_486_1.var_.characterEffect1095ui_story then
				arg_486_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_489_2 = 0
			local var_489_3 = 0.55

			if 0 < arg_486_1.time_ and arg_486_1.time_ <= var_489_2 + arg_489_0 then
				arg_486_1.talkMaxDuration = 0
				arg_486_1.dialogCg_.alpha = 1

				arg_486_1.dialog_:SetActive(true)
				SetActive(arg_486_1.leftNameGo_, true)

				arg_486_1.leftNameTxt_.text = arg_486_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_486_1.leftNameTxt_.transform)

				arg_486_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_486_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_486_1:RecordName(arg_486_1.leftNameTxt_.text)
				SetActive(arg_486_1.iconTrs_.gameObject, false)
				arg_486_1.callingController_:SetSelectedState("normal")

				local var_489_4 = arg_486_1:GetWordFromCfg(411051117)
				local var_489_5 = arg_486_1:FormatText(var_489_4.content)

				arg_486_1.text_.text = var_489_5

				LuaForUtil.ClearLinePrefixSymbol(arg_486_1.text_)

				local var_489_7 = 22 <= 0 and var_489_3 or var_489_3 * (utf8.len(var_489_5) / 22)

				if (22 <= 0 and var_489_3 or var_489_3 * (utf8.len(var_489_5) / 22)) > 0 and var_489_3 < var_489_7 then
					arg_486_1.talkMaxDuration = var_489_7

					if var_489_7 + var_489_2 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_7 + var_489_2
					end
				end

				arg_486_1.text_.text = var_489_5
				arg_486_1.typewritter.percent = 0

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051117", "story_v_out_411051.awb") ~= 0 then
					local var_489_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051117", "story_v_out_411051.awb") / 1000

					if var_489_8 + var_489_2 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_8 + var_489_2
					end

					if var_489_4.prefab_name ~= "" and arg_486_1.actors_[var_489_4.prefab_name] ~= nil then
						local var_489_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_486_1.actors_[var_489_4.prefab_name].transform, "story_v_out_411051", "411051117", "story_v_out_411051.awb")

						arg_486_1:RecordAudio("411051117", var_489_9)
						arg_486_1:RecordAudio("411051117", var_489_9)
					else
						arg_486_1:AudioAction("play", "voice", "story_v_out_411051", "411051117", "story_v_out_411051.awb")
					end

					arg_486_1:RecordHistoryTalkVoice("story_v_out_411051", "411051117", "story_v_out_411051.awb")
				end

				arg_486_1:RecordContent(arg_486_1.text_.text)
			end

			local var_489_10 = math.max(var_489_3, arg_486_1.talkMaxDuration)

			if var_489_2 <= arg_486_1.time_ and arg_486_1.time_ < var_489_2 + var_489_10 then
				arg_486_1.typewritter.percent = (arg_486_1.time_ - var_489_2) / var_489_10

				arg_486_1.typewritter:SetDirty()
			end

			if arg_486_1.time_ >= var_489_2 + var_489_10 and arg_486_1.time_ < var_489_2 + var_489_10 + arg_489_0 then
				arg_486_1.typewritter.percent = 1

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(true)
			end
		end

		arg_486_1.nodeConfigList_ = {}

		arg_486_1:InitPlayNodeList()
	end,
	Play411051118 = function(arg_490_0, arg_490_1)
		arg_490_1.time_ = 0
		arg_490_1.frameCnt_ = 0
		arg_490_1.state_ = "playing"
		arg_490_1.curTalkId_ = 411051118
		arg_490_1.duration_ = 8.8

		local var_490_0 = {
			zh = 8.8,
			ja = 5.333
		}
		local var_490_1 = manager.audio:GetLocalizationFlag()

		if var_490_0[var_490_1] ~= nil then
			arg_490_1.duration_ = var_490_0[var_490_1]
		end

		SetActive(arg_490_1.tipsGo_, false)

		function arg_490_1.onSingleLineFinish_()
			arg_490_1.onSingleLineUpdate_ = nil
			arg_490_1.onSingleLineFinish_ = nil
			arg_490_1.state_ = "waiting"
		end

		function arg_490_1.playNext_(arg_492_0)
			if arg_492_0 == 1 then
				arg_490_0:Play411051119(arg_490_1)
			end
		end

		function arg_490_1.onSingleLineUpdate_(arg_493_0)
			local var_493_0 = 1.075

			if 0 < arg_490_1.time_ and arg_490_1.time_ <= 0 + arg_493_0 then
				arg_490_1.talkMaxDuration = 0
				arg_490_1.dialogCg_.alpha = 1

				arg_490_1.dialog_:SetActive(true)
				SetActive(arg_490_1.leftNameGo_, true)

				arg_490_1.leftNameTxt_.text = arg_490_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_490_1.leftNameTxt_.transform)

				arg_490_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_490_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_490_1:RecordName(arg_490_1.leftNameTxt_.text)
				SetActive(arg_490_1.iconTrs_.gameObject, false)
				arg_490_1.callingController_:SetSelectedState("normal")

				local var_493_1 = arg_490_1:GetWordFromCfg(411051118)
				local var_493_2 = arg_490_1:FormatText(var_493_1.content)

				arg_490_1.text_.text = var_493_2

				LuaForUtil.ClearLinePrefixSymbol(arg_490_1.text_)

				local var_493_4 = 43 <= 0 and var_493_0 or var_493_0 * (utf8.len(var_493_2) / 43)

				if (43 <= 0 and var_493_0 or var_493_0 * (utf8.len(var_493_2) / 43)) > 0 and var_493_0 < var_493_4 then
					arg_490_1.talkMaxDuration = var_493_4

					if var_493_4 + 0 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_4 + 0
					end
				end

				arg_490_1.text_.text = var_493_2
				arg_490_1.typewritter.percent = 0

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051118", "story_v_out_411051.awb") ~= 0 then
					local var_493_5 = manager.audio:GetVoiceLength("story_v_out_411051", "411051118", "story_v_out_411051.awb") / 1000

					if var_493_5 + 0 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_5 + 0
					end

					if var_493_1.prefab_name ~= "" and arg_490_1.actors_[var_493_1.prefab_name] ~= nil then
						local var_493_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_490_1.actors_[var_493_1.prefab_name].transform, "story_v_out_411051", "411051118", "story_v_out_411051.awb")

						arg_490_1:RecordAudio("411051118", var_493_6)
						arg_490_1:RecordAudio("411051118", var_493_6)
					else
						arg_490_1:AudioAction("play", "voice", "story_v_out_411051", "411051118", "story_v_out_411051.awb")
					end

					arg_490_1:RecordHistoryTalkVoice("story_v_out_411051", "411051118", "story_v_out_411051.awb")
				end

				arg_490_1:RecordContent(arg_490_1.text_.text)
			end

			local var_493_7 = math.max(var_493_0, arg_490_1.talkMaxDuration)

			if 0 <= arg_490_1.time_ and arg_490_1.time_ < 0 + var_493_7 then
				arg_490_1.typewritter.percent = (arg_490_1.time_ - 0) / var_493_7

				arg_490_1.typewritter:SetDirty()
			end

			if arg_490_1.time_ >= 0 + var_493_7 and arg_490_1.time_ < 0 + var_493_7 + arg_493_0 then
				arg_490_1.typewritter.percent = 1

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(true)
			end
		end

		arg_490_1.nodeConfigList_ = {}

		arg_490_1:InitPlayNodeList()
	end,
	Play411051119 = function(arg_494_0, arg_494_1)
		arg_494_1.time_ = 0
		arg_494_1.frameCnt_ = 0
		arg_494_1.state_ = "playing"
		arg_494_1.curTalkId_ = 411051119
		arg_494_1.duration_ = 1.57

		local var_494_0 = {
			zh = 1.466,
			ja = 1.566
		}
		local var_494_1 = manager.audio:GetLocalizationFlag()

		if var_494_0[var_494_1] ~= nil then
			arg_494_1.duration_ = var_494_0[var_494_1]
		end

		SetActive(arg_494_1.tipsGo_, false)

		function arg_494_1.onSingleLineFinish_()
			arg_494_1.onSingleLineUpdate_ = nil
			arg_494_1.onSingleLineFinish_ = nil
			arg_494_1.state_ = "waiting"
		end

		function arg_494_1.playNext_(arg_496_0)
			if arg_496_0 == 1 then
				arg_494_0:Play411051120(arg_494_1)
			end
		end

		function arg_494_1.onSingleLineUpdate_(arg_497_0)
			local var_497_0 = 0.125

			if 0 < arg_494_1.time_ and arg_494_1.time_ <= 0 + arg_497_0 then
				arg_494_1.talkMaxDuration = 0
				arg_494_1.dialogCg_.alpha = 1

				arg_494_1.dialog_:SetActive(true)
				SetActive(arg_494_1.leftNameGo_, true)

				arg_494_1.leftNameTxt_.text = arg_494_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_494_1.leftNameTxt_.transform)

				arg_494_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_494_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_494_1:RecordName(arg_494_1.leftNameTxt_.text)
				SetActive(arg_494_1.iconTrs_.gameObject, true)
				arg_494_1.iconController_:SetSelectedState("hero")

				arg_494_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_494_1.callingController_:SetSelectedState("normal")

				arg_494_1.keyicon_.color = Color.New(1, 1, 1)
				arg_494_1.icon_.color = Color.New(1, 1, 1)

				local var_497_1 = arg_494_1:GetWordFromCfg(411051119)
				local var_497_2 = arg_494_1:FormatText(var_497_1.content)

				arg_494_1.text_.text = var_497_2

				LuaForUtil.ClearLinePrefixSymbol(arg_494_1.text_)

				local var_497_4 = 5 <= 0 and var_497_0 or var_497_0 * (utf8.len(var_497_2) / 5)

				if (5 <= 0 and var_497_0 or var_497_0 * (utf8.len(var_497_2) / 5)) > 0 and var_497_0 < var_497_4 then
					arg_494_1.talkMaxDuration = var_497_4

					if var_497_4 + 0 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_4 + 0
					end
				end

				arg_494_1.text_.text = var_497_2
				arg_494_1.typewritter.percent = 0

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051119", "story_v_out_411051.awb") ~= 0 then
					local var_497_5 = manager.audio:GetVoiceLength("story_v_out_411051", "411051119", "story_v_out_411051.awb") / 1000

					if var_497_5 + 0 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_5 + 0
					end

					if var_497_1.prefab_name ~= "" and arg_494_1.actors_[var_497_1.prefab_name] ~= nil then
						local var_497_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_494_1.actors_[var_497_1.prefab_name].transform, "story_v_out_411051", "411051119", "story_v_out_411051.awb")

						arg_494_1:RecordAudio("411051119", var_497_6)
						arg_494_1:RecordAudio("411051119", var_497_6)
					else
						arg_494_1:AudioAction("play", "voice", "story_v_out_411051", "411051119", "story_v_out_411051.awb")
					end

					arg_494_1:RecordHistoryTalkVoice("story_v_out_411051", "411051119", "story_v_out_411051.awb")
				end

				arg_494_1:RecordContent(arg_494_1.text_.text)
			end

			local var_497_7 = math.max(var_497_0, arg_494_1.talkMaxDuration)

			if 0 <= arg_494_1.time_ and arg_494_1.time_ < 0 + var_497_7 then
				arg_494_1.typewritter.percent = (arg_494_1.time_ - 0) / var_497_7

				arg_494_1.typewritter:SetDirty()
			end

			if arg_494_1.time_ >= 0 + var_497_7 and arg_494_1.time_ < 0 + var_497_7 + arg_497_0 then
				arg_494_1.typewritter.percent = 1

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(true)
			end
		end

		arg_494_1.nodeConfigList_ = {}

		arg_494_1:InitPlayNodeList()
	end,
	Play411051120 = function(arg_498_0, arg_498_1)
		arg_498_1.time_ = 0
		arg_498_1.frameCnt_ = 0
		arg_498_1.state_ = "playing"
		arg_498_1.curTalkId_ = 411051120
		arg_498_1.duration_ = 8.43

		local var_498_0 = {
			zh = 8.433,
			ja = 6.9
		}
		local var_498_1 = manager.audio:GetLocalizationFlag()

		if var_498_0[var_498_1] ~= nil then
			arg_498_1.duration_ = var_498_0[var_498_1]
		end

		SetActive(arg_498_1.tipsGo_, false)

		function arg_498_1.onSingleLineFinish_()
			arg_498_1.onSingleLineUpdate_ = nil
			arg_498_1.onSingleLineFinish_ = nil
			arg_498_1.state_ = "waiting"
		end

		function arg_498_1.playNext_(arg_500_0)
			if arg_500_0 == 1 then
				arg_498_0:Play411051121(arg_498_1)
			end
		end

		function arg_498_1.onSingleLineUpdate_(arg_501_0)
			if 0 < arg_498_1.time_ and arg_498_1.time_ <= 0 + arg_501_0 then
				arg_498_1.var_.moveOldPos1095ui_story = arg_498_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_501_0 = 0.001

			if 0 <= arg_498_1.time_ and arg_498_1.time_ < 0 + var_501_0 then
				arg_498_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_498_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_498_1.time_ - 0) / var_501_0)
				arg_498_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_498_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_498_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_498_1.actors_["1095ui_story"].transform.position).z)
				arg_498_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_498_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_498_1.actors_["1095ui_story"].transform.localEulerAngles = arg_498_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_498_1.time_ >= 0 + var_501_0 and arg_498_1.time_ < 0 + var_501_0 + arg_501_0 then
				arg_498_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_498_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_498_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_498_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_498_1.actors_["1095ui_story"].transform.position).z)
				arg_498_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_498_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_498_1.actors_["1095ui_story"].transform.localEulerAngles = arg_498_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_501_1 = arg_498_1.actors_["1095ui_story"]

			if 0 < arg_498_1.time_ and arg_498_1.time_ <= 0 + arg_501_0 and not isNil(var_501_1) and arg_498_1.var_.characterEffect1095ui_story == nil then
				arg_498_1.var_.characterEffect1095ui_story = var_501_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_501_2 = 0.200000002980232

			if 0 <= arg_498_1.time_ and arg_498_1.time_ < 0 + var_501_2 and not isNil(var_501_1) then
				if arg_498_1.var_.characterEffect1095ui_story and not isNil(var_501_1) then
					arg_498_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_498_1.time_ >= 0 + var_501_2 and arg_498_1.time_ < 0 + var_501_2 + arg_501_0 and not isNil(var_501_1) and arg_498_1.var_.characterEffect1095ui_story then
				arg_498_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_498_1.time_ and arg_498_1.time_ <= 0 + arg_501_0 then
				arg_498_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_498_1.time_ and arg_498_1.time_ <= 0 + arg_501_0 then
				arg_498_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_501_4 = 0
			local var_501_5 = 0.875

			if 0 < arg_498_1.time_ and arg_498_1.time_ <= var_501_4 + arg_501_0 then
				arg_498_1.talkMaxDuration = 0
				arg_498_1.dialogCg_.alpha = 1

				arg_498_1.dialog_:SetActive(true)
				SetActive(arg_498_1.leftNameGo_, true)

				arg_498_1.leftNameTxt_.text = arg_498_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_498_1.leftNameTxt_.transform)

				arg_498_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_498_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_498_1:RecordName(arg_498_1.leftNameTxt_.text)
				SetActive(arg_498_1.iconTrs_.gameObject, false)
				arg_498_1.callingController_:SetSelectedState("normal")

				local var_501_6 = arg_498_1:GetWordFromCfg(411051120)
				local var_501_7 = arg_498_1:FormatText(var_501_6.content)

				arg_498_1.text_.text = var_501_7

				LuaForUtil.ClearLinePrefixSymbol(arg_498_1.text_)

				local var_501_9 = 35 <= 0 and var_501_5 or var_501_5 * (utf8.len(var_501_7) / 35)

				if (35 <= 0 and var_501_5 or var_501_5 * (utf8.len(var_501_7) / 35)) > 0 and var_501_5 < var_501_9 then
					arg_498_1.talkMaxDuration = var_501_9

					if var_501_9 + var_501_4 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_9 + var_501_4
					end
				end

				arg_498_1.text_.text = var_501_7
				arg_498_1.typewritter.percent = 0

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051120", "story_v_out_411051.awb") ~= 0 then
					local var_501_10 = manager.audio:GetVoiceLength("story_v_out_411051", "411051120", "story_v_out_411051.awb") / 1000

					if var_501_10 + var_501_4 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_10 + var_501_4
					end

					if var_501_6.prefab_name ~= "" and arg_498_1.actors_[var_501_6.prefab_name] ~= nil then
						local var_501_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_498_1.actors_[var_501_6.prefab_name].transform, "story_v_out_411051", "411051120", "story_v_out_411051.awb")

						arg_498_1:RecordAudio("411051120", var_501_11)
						arg_498_1:RecordAudio("411051120", var_501_11)
					else
						arg_498_1:AudioAction("play", "voice", "story_v_out_411051", "411051120", "story_v_out_411051.awb")
					end

					arg_498_1:RecordHistoryTalkVoice("story_v_out_411051", "411051120", "story_v_out_411051.awb")
				end

				arg_498_1:RecordContent(arg_498_1.text_.text)
			end

			local var_501_12 = math.max(var_501_5, arg_498_1.talkMaxDuration)

			if var_501_4 <= arg_498_1.time_ and arg_498_1.time_ < var_501_4 + var_501_12 then
				arg_498_1.typewritter.percent = (arg_498_1.time_ - var_501_4) / var_501_12

				arg_498_1.typewritter:SetDirty()
			end

			if arg_498_1.time_ >= var_501_4 + var_501_12 and arg_498_1.time_ < var_501_4 + var_501_12 + arg_501_0 then
				arg_498_1.typewritter.percent = 1

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(true)
			end
		end

		arg_498_1.nodeConfigList_ = {
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

		arg_498_1:InitPlayNodeList()
	end,
	Play411051121 = function(arg_502_0, arg_502_1)
		arg_502_1.time_ = 0
		arg_502_1.frameCnt_ = 0
		arg_502_1.state_ = "playing"
		arg_502_1.curTalkId_ = 411051121
		arg_502_1.duration_ = 8

		local var_502_0 = {
			zh = 8,
			ja = 6.266
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
				arg_502_0:Play411051122(arg_502_1)
			end
		end

		function arg_502_1.onSingleLineUpdate_(arg_505_0)
			if 0 < arg_502_1.time_ and arg_502_1.time_ <= 0 + arg_505_0 and not isNil(arg_502_1.actors_["1095ui_story"]) and arg_502_1.var_.characterEffect1095ui_story == nil then
				arg_502_1.var_.characterEffect1095ui_story = arg_502_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_505_0 = 0.200000002980232

			if 0 <= arg_502_1.time_ and arg_502_1.time_ < 0 + var_505_0 and not isNil(arg_502_1.actors_["1095ui_story"]) then
				if arg_502_1.var_.characterEffect1095ui_story and not isNil(arg_502_1.actors_["1095ui_story"]) then
					arg_502_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_502_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_502_1.time_ - 0) / var_505_0)
				end
			end

			if arg_502_1.time_ >= 0 + var_505_0 and arg_502_1.time_ < 0 + var_505_0 + arg_505_0 and not isNil(arg_502_1.actors_["1095ui_story"]) and arg_502_1.var_.characterEffect1095ui_story then
				arg_502_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_502_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_505_1 = 0
			local var_505_2 = 0.875

			if 0 < arg_502_1.time_ and arg_502_1.time_ <= var_505_1 + arg_505_0 then
				arg_502_1.talkMaxDuration = 0
				arg_502_1.dialogCg_.alpha = 1

				arg_502_1.dialog_:SetActive(true)
				SetActive(arg_502_1.leftNameGo_, true)

				arg_502_1.leftNameTxt_.text = arg_502_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_502_1.leftNameTxt_.transform)

				arg_502_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_502_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_502_1:RecordName(arg_502_1.leftNameTxt_.text)
				SetActive(arg_502_1.iconTrs_.gameObject, true)
				arg_502_1.iconController_:SetSelectedState("hero")

				arg_502_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_502_1.callingController_:SetSelectedState("normal")

				arg_502_1.keyicon_.color = Color.New(1, 1, 1)
				arg_502_1.icon_.color = Color.New(1, 1, 1)

				local var_505_3 = arg_502_1:GetWordFromCfg(411051121)
				local var_505_4 = arg_502_1:FormatText(var_505_3.content)

				arg_502_1.text_.text = var_505_4

				LuaForUtil.ClearLinePrefixSymbol(arg_502_1.text_)

				local var_505_6 = 35 <= 0 and var_505_2 or var_505_2 * (utf8.len(var_505_4) / 35)

				if (35 <= 0 and var_505_2 or var_505_2 * (utf8.len(var_505_4) / 35)) > 0 and var_505_2 < var_505_6 then
					arg_502_1.talkMaxDuration = var_505_6

					if var_505_6 + var_505_1 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_6 + var_505_1
					end
				end

				arg_502_1.text_.text = var_505_4
				arg_502_1.typewritter.percent = 0

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051121", "story_v_out_411051.awb") ~= 0 then
					local var_505_7 = manager.audio:GetVoiceLength("story_v_out_411051", "411051121", "story_v_out_411051.awb") / 1000

					if var_505_7 + var_505_1 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_7 + var_505_1
					end

					if var_505_3.prefab_name ~= "" and arg_502_1.actors_[var_505_3.prefab_name] ~= nil then
						local var_505_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_502_1.actors_[var_505_3.prefab_name].transform, "story_v_out_411051", "411051121", "story_v_out_411051.awb")

						arg_502_1:RecordAudio("411051121", var_505_8)
						arg_502_1:RecordAudio("411051121", var_505_8)
					else
						arg_502_1:AudioAction("play", "voice", "story_v_out_411051", "411051121", "story_v_out_411051.awb")
					end

					arg_502_1:RecordHistoryTalkVoice("story_v_out_411051", "411051121", "story_v_out_411051.awb")
				end

				arg_502_1:RecordContent(arg_502_1.text_.text)
			end

			local var_505_9 = math.max(var_505_2, arg_502_1.talkMaxDuration)

			if var_505_1 <= arg_502_1.time_ and arg_502_1.time_ < var_505_1 + var_505_9 then
				arg_502_1.typewritter.percent = (arg_502_1.time_ - var_505_1) / var_505_9

				arg_502_1.typewritter:SetDirty()
			end

			if arg_502_1.time_ >= var_505_1 + var_505_9 and arg_502_1.time_ < var_505_1 + var_505_9 + arg_505_0 then
				arg_502_1.typewritter.percent = 1

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(true)
			end
		end

		arg_502_1.nodeConfigList_ = {}

		arg_502_1:InitPlayNodeList()
	end,
	Play411051122 = function(arg_506_0, arg_506_1)
		arg_506_1.time_ = 0
		arg_506_1.frameCnt_ = 0
		arg_506_1.state_ = "playing"
		arg_506_1.curTalkId_ = 411051122
		arg_506_1.duration_ = 7.77

		local var_506_0 = {
			zh = 6.433,
			ja = 7.766
		}
		local var_506_1 = manager.audio:GetLocalizationFlag()

		if var_506_0[var_506_1] ~= nil then
			arg_506_1.duration_ = var_506_0[var_506_1]
		end

		SetActive(arg_506_1.tipsGo_, false)

		function arg_506_1.onSingleLineFinish_()
			arg_506_1.onSingleLineUpdate_ = nil
			arg_506_1.onSingleLineFinish_ = nil
			arg_506_1.state_ = "waiting"
		end

		function arg_506_1.playNext_(arg_508_0)
			if arg_508_0 == 1 then
				arg_506_0:Play411051123(arg_506_1)
			end
		end

		function arg_506_1.onSingleLineUpdate_(arg_509_0)
			if 0 < arg_506_1.time_ and arg_506_1.time_ <= 0 + arg_509_0 and not isNil(arg_506_1.actors_["1095ui_story"]) and arg_506_1.var_.characterEffect1095ui_story == nil then
				arg_506_1.var_.characterEffect1095ui_story = arg_506_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_509_0 = 0.200000002980232

			if 0 <= arg_506_1.time_ and arg_506_1.time_ < 0 + var_509_0 and not isNil(arg_506_1.actors_["1095ui_story"]) then
				if arg_506_1.var_.characterEffect1095ui_story and not isNil(arg_506_1.actors_["1095ui_story"]) then
					arg_506_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_506_1.time_ >= 0 + var_509_0 and arg_506_1.time_ < 0 + var_509_0 + arg_509_0 and not isNil(arg_506_1.actors_["1095ui_story"]) and arg_506_1.var_.characterEffect1095ui_story then
				arg_506_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_509_2 = 0
			local var_509_3 = 0.575

			if 0 < arg_506_1.time_ and arg_506_1.time_ <= var_509_2 + arg_509_0 then
				arg_506_1.talkMaxDuration = 0
				arg_506_1.dialogCg_.alpha = 1

				arg_506_1.dialog_:SetActive(true)
				SetActive(arg_506_1.leftNameGo_, true)

				arg_506_1.leftNameTxt_.text = arg_506_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_506_1.leftNameTxt_.transform)

				arg_506_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_506_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_506_1:RecordName(arg_506_1.leftNameTxt_.text)
				SetActive(arg_506_1.iconTrs_.gameObject, false)
				arg_506_1.callingController_:SetSelectedState("normal")

				local var_509_4 = arg_506_1:GetWordFromCfg(411051122)
				local var_509_5 = arg_506_1:FormatText(var_509_4.content)

				arg_506_1.text_.text = var_509_5

				LuaForUtil.ClearLinePrefixSymbol(arg_506_1.text_)

				local var_509_7 = 23 <= 0 and var_509_3 or var_509_3 * (utf8.len(var_509_5) / 23)

				if (23 <= 0 and var_509_3 or var_509_3 * (utf8.len(var_509_5) / 23)) > 0 and var_509_3 < var_509_7 then
					arg_506_1.talkMaxDuration = var_509_7

					if var_509_7 + var_509_2 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_7 + var_509_2
					end
				end

				arg_506_1.text_.text = var_509_5
				arg_506_1.typewritter.percent = 0

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051122", "story_v_out_411051.awb") ~= 0 then
					local var_509_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051122", "story_v_out_411051.awb") / 1000

					if var_509_8 + var_509_2 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_8 + var_509_2
					end

					if var_509_4.prefab_name ~= "" and arg_506_1.actors_[var_509_4.prefab_name] ~= nil then
						local var_509_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_506_1.actors_[var_509_4.prefab_name].transform, "story_v_out_411051", "411051122", "story_v_out_411051.awb")

						arg_506_1:RecordAudio("411051122", var_509_9)
						arg_506_1:RecordAudio("411051122", var_509_9)
					else
						arg_506_1:AudioAction("play", "voice", "story_v_out_411051", "411051122", "story_v_out_411051.awb")
					end

					arg_506_1:RecordHistoryTalkVoice("story_v_out_411051", "411051122", "story_v_out_411051.awb")
				end

				arg_506_1:RecordContent(arg_506_1.text_.text)
			end

			local var_509_10 = math.max(var_509_3, arg_506_1.talkMaxDuration)

			if var_509_2 <= arg_506_1.time_ and arg_506_1.time_ < var_509_2 + var_509_10 then
				arg_506_1.typewritter.percent = (arg_506_1.time_ - var_509_2) / var_509_10

				arg_506_1.typewritter:SetDirty()
			end

			if arg_506_1.time_ >= var_509_2 + var_509_10 and arg_506_1.time_ < var_509_2 + var_509_10 + arg_509_0 then
				arg_506_1.typewritter.percent = 1

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(true)
			end
		end

		arg_506_1.nodeConfigList_ = {}

		arg_506_1:InitPlayNodeList()
	end,
	Play411051123 = function(arg_510_0, arg_510_1)
		arg_510_1.time_ = 0
		arg_510_1.frameCnt_ = 0
		arg_510_1.state_ = "playing"
		arg_510_1.curTalkId_ = 411051123
		arg_510_1.duration_ = 5.6

		local var_510_0 = {
			zh = 5.6,
			ja = 5.566
		}
		local var_510_1 = manager.audio:GetLocalizationFlag()

		if var_510_0[var_510_1] ~= nil then
			arg_510_1.duration_ = var_510_0[var_510_1]
		end

		SetActive(arg_510_1.tipsGo_, false)

		function arg_510_1.onSingleLineFinish_()
			arg_510_1.onSingleLineUpdate_ = nil
			arg_510_1.onSingleLineFinish_ = nil
			arg_510_1.state_ = "waiting"
		end

		function arg_510_1.playNext_(arg_512_0)
			if arg_512_0 == 1 then
				arg_510_0:Play411051124(arg_510_1)
			end
		end

		function arg_510_1.onSingleLineUpdate_(arg_513_0)
			if 0 < arg_510_1.time_ and arg_510_1.time_ <= 0 + arg_513_0 and not isNil(arg_510_1.actors_["1095ui_story"]) and arg_510_1.var_.characterEffect1095ui_story == nil then
				arg_510_1.var_.characterEffect1095ui_story = arg_510_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_513_0 = 0.200000002980232

			if 0 <= arg_510_1.time_ and arg_510_1.time_ < 0 + var_513_0 and not isNil(arg_510_1.actors_["1095ui_story"]) then
				if arg_510_1.var_.characterEffect1095ui_story and not isNil(arg_510_1.actors_["1095ui_story"]) then
					arg_510_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_510_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_510_1.time_ - 0) / var_513_0)
				end
			end

			if arg_510_1.time_ >= 0 + var_513_0 and arg_510_1.time_ < 0 + var_513_0 + arg_513_0 and not isNil(arg_510_1.actors_["1095ui_story"]) and arg_510_1.var_.characterEffect1095ui_story then
				arg_510_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_510_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_513_1 = 0
			local var_513_2 = 0.5

			if 0 < arg_510_1.time_ and arg_510_1.time_ <= var_513_1 + arg_513_0 then
				arg_510_1.talkMaxDuration = 0
				arg_510_1.dialogCg_.alpha = 1

				arg_510_1.dialog_:SetActive(true)
				SetActive(arg_510_1.leftNameGo_, true)

				arg_510_1.leftNameTxt_.text = arg_510_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_510_1.leftNameTxt_.transform)

				arg_510_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_510_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_510_1:RecordName(arg_510_1.leftNameTxt_.text)
				SetActive(arg_510_1.iconTrs_.gameObject, true)
				arg_510_1.iconController_:SetSelectedState("hero")

				arg_510_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_510_1.callingController_:SetSelectedState("normal")

				arg_510_1.keyicon_.color = Color.New(1, 1, 1)
				arg_510_1.icon_.color = Color.New(1, 1, 1)

				local var_513_3 = arg_510_1:GetWordFromCfg(411051123)
				local var_513_4 = arg_510_1:FormatText(var_513_3.content)

				arg_510_1.text_.text = var_513_4

				LuaForUtil.ClearLinePrefixSymbol(arg_510_1.text_)

				local var_513_6 = 20 <= 0 and var_513_2 or var_513_2 * (utf8.len(var_513_4) / 20)

				if (20 <= 0 and var_513_2 or var_513_2 * (utf8.len(var_513_4) / 20)) > 0 and var_513_2 < var_513_6 then
					arg_510_1.talkMaxDuration = var_513_6

					if var_513_6 + var_513_1 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_6 + var_513_1
					end
				end

				arg_510_1.text_.text = var_513_4
				arg_510_1.typewritter.percent = 0

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051123", "story_v_out_411051.awb") ~= 0 then
					local var_513_7 = manager.audio:GetVoiceLength("story_v_out_411051", "411051123", "story_v_out_411051.awb") / 1000

					if var_513_7 + var_513_1 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_7 + var_513_1
					end

					if var_513_3.prefab_name ~= "" and arg_510_1.actors_[var_513_3.prefab_name] ~= nil then
						local var_513_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_510_1.actors_[var_513_3.prefab_name].transform, "story_v_out_411051", "411051123", "story_v_out_411051.awb")

						arg_510_1:RecordAudio("411051123", var_513_8)
						arg_510_1:RecordAudio("411051123", var_513_8)
					else
						arg_510_1:AudioAction("play", "voice", "story_v_out_411051", "411051123", "story_v_out_411051.awb")
					end

					arg_510_1:RecordHistoryTalkVoice("story_v_out_411051", "411051123", "story_v_out_411051.awb")
				end

				arg_510_1:RecordContent(arg_510_1.text_.text)
			end

			local var_513_9 = math.max(var_513_2, arg_510_1.talkMaxDuration)

			if var_513_1 <= arg_510_1.time_ and arg_510_1.time_ < var_513_1 + var_513_9 then
				arg_510_1.typewritter.percent = (arg_510_1.time_ - var_513_1) / var_513_9

				arg_510_1.typewritter:SetDirty()
			end

			if arg_510_1.time_ >= var_513_1 + var_513_9 and arg_510_1.time_ < var_513_1 + var_513_9 + arg_513_0 then
				arg_510_1.typewritter.percent = 1

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(true)
			end
		end

		arg_510_1.nodeConfigList_ = {}

		arg_510_1:InitPlayNodeList()
	end,
	Play411051124 = function(arg_514_0, arg_514_1)
		arg_514_1.time_ = 0
		arg_514_1.frameCnt_ = 0
		arg_514_1.state_ = "playing"
		arg_514_1.curTalkId_ = 411051124
		arg_514_1.duration_ = 4.1

		local var_514_0 = {
			zh = 3,
			ja = 4.1
		}
		local var_514_1 = manager.audio:GetLocalizationFlag()

		if var_514_0[var_514_1] ~= nil then
			arg_514_1.duration_ = var_514_0[var_514_1]
		end

		SetActive(arg_514_1.tipsGo_, false)

		function arg_514_1.onSingleLineFinish_()
			arg_514_1.onSingleLineUpdate_ = nil
			arg_514_1.onSingleLineFinish_ = nil
			arg_514_1.state_ = "waiting"
		end

		function arg_514_1.playNext_(arg_516_0)
			if arg_516_0 == 1 then
				arg_514_0:Play411051125(arg_514_1)
			end
		end

		function arg_514_1.onSingleLineUpdate_(arg_517_0)
			if 0 < arg_514_1.time_ and arg_514_1.time_ <= 0 + arg_517_0 and not isNil(arg_514_1.actors_["1095ui_story"]) and arg_514_1.var_.characterEffect1095ui_story == nil then
				arg_514_1.var_.characterEffect1095ui_story = arg_514_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_517_0 = 0.200000002980232

			if 0 <= arg_514_1.time_ and arg_514_1.time_ < 0 + var_517_0 and not isNil(arg_514_1.actors_["1095ui_story"]) then
				if arg_514_1.var_.characterEffect1095ui_story and not isNil(arg_514_1.actors_["1095ui_story"]) then
					arg_514_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_514_1.time_ >= 0 + var_517_0 and arg_514_1.time_ < 0 + var_517_0 + arg_517_0 and not isNil(arg_514_1.actors_["1095ui_story"]) and arg_514_1.var_.characterEffect1095ui_story then
				arg_514_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_517_2 = 0
			local var_517_3 = 0.375

			if 0 < arg_514_1.time_ and arg_514_1.time_ <= var_517_2 + arg_517_0 then
				arg_514_1.talkMaxDuration = 0
				arg_514_1.dialogCg_.alpha = 1

				arg_514_1.dialog_:SetActive(true)
				SetActive(arg_514_1.leftNameGo_, true)

				arg_514_1.leftNameTxt_.text = arg_514_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_514_1.leftNameTxt_.transform)

				arg_514_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_514_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_514_1:RecordName(arg_514_1.leftNameTxt_.text)
				SetActive(arg_514_1.iconTrs_.gameObject, false)
				arg_514_1.callingController_:SetSelectedState("normal")

				local var_517_4 = arg_514_1:GetWordFromCfg(411051124)
				local var_517_5 = arg_514_1:FormatText(var_517_4.content)

				arg_514_1.text_.text = var_517_5

				LuaForUtil.ClearLinePrefixSymbol(arg_514_1.text_)

				local var_517_7 = 15 <= 0 and var_517_3 or var_517_3 * (utf8.len(var_517_5) / 15)

				if (15 <= 0 and var_517_3 or var_517_3 * (utf8.len(var_517_5) / 15)) > 0 and var_517_3 < var_517_7 then
					arg_514_1.talkMaxDuration = var_517_7

					if var_517_7 + var_517_2 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_7 + var_517_2
					end
				end

				arg_514_1.text_.text = var_517_5
				arg_514_1.typewritter.percent = 0

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051124", "story_v_out_411051.awb") ~= 0 then
					local var_517_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051124", "story_v_out_411051.awb") / 1000

					if var_517_8 + var_517_2 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_8 + var_517_2
					end

					if var_517_4.prefab_name ~= "" and arg_514_1.actors_[var_517_4.prefab_name] ~= nil then
						local var_517_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_514_1.actors_[var_517_4.prefab_name].transform, "story_v_out_411051", "411051124", "story_v_out_411051.awb")

						arg_514_1:RecordAudio("411051124", var_517_9)
						arg_514_1:RecordAudio("411051124", var_517_9)
					else
						arg_514_1:AudioAction("play", "voice", "story_v_out_411051", "411051124", "story_v_out_411051.awb")
					end

					arg_514_1:RecordHistoryTalkVoice("story_v_out_411051", "411051124", "story_v_out_411051.awb")
				end

				arg_514_1:RecordContent(arg_514_1.text_.text)
			end

			local var_517_10 = math.max(var_517_3, arg_514_1.talkMaxDuration)

			if var_517_2 <= arg_514_1.time_ and arg_514_1.time_ < var_517_2 + var_517_10 then
				arg_514_1.typewritter.percent = (arg_514_1.time_ - var_517_2) / var_517_10

				arg_514_1.typewritter:SetDirty()
			end

			if arg_514_1.time_ >= var_517_2 + var_517_10 and arg_514_1.time_ < var_517_2 + var_517_10 + arg_517_0 then
				arg_514_1.typewritter.percent = 1

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(true)
			end
		end

		arg_514_1.nodeConfigList_ = {}

		arg_514_1:InitPlayNodeList()
	end,
	Play411051125 = function(arg_518_0, arg_518_1)
		arg_518_1.time_ = 0
		arg_518_1.frameCnt_ = 0
		arg_518_1.state_ = "playing"
		arg_518_1.curTalkId_ = 411051125
		arg_518_1.duration_ = 9.17

		local var_518_0 = {
			zh = 9.166,
			ja = 6.5
		}
		local var_518_1 = manager.audio:GetLocalizationFlag()

		if var_518_0[var_518_1] ~= nil then
			arg_518_1.duration_ = var_518_0[var_518_1]
		end

		SetActive(arg_518_1.tipsGo_, false)

		function arg_518_1.onSingleLineFinish_()
			arg_518_1.onSingleLineUpdate_ = nil
			arg_518_1.onSingleLineFinish_ = nil
			arg_518_1.state_ = "waiting"
		end

		function arg_518_1.playNext_(arg_520_0)
			if arg_520_0 == 1 then
				arg_518_0:Play411051126(arg_518_1)
			end
		end

		function arg_518_1.onSingleLineUpdate_(arg_521_0)
			if 0 < arg_518_1.time_ and arg_518_1.time_ <= 0 + arg_521_0 and not isNil(arg_518_1.actors_["1095ui_story"]) and arg_518_1.var_.characterEffect1095ui_story == nil then
				arg_518_1.var_.characterEffect1095ui_story = arg_518_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_521_0 = 0.200000002980232

			if 0 <= arg_518_1.time_ and arg_518_1.time_ < 0 + var_521_0 and not isNil(arg_518_1.actors_["1095ui_story"]) then
				if arg_518_1.var_.characterEffect1095ui_story and not isNil(arg_518_1.actors_["1095ui_story"]) then
					arg_518_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_518_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_518_1.time_ - 0) / var_521_0)
				end
			end

			if arg_518_1.time_ >= 0 + var_521_0 and arg_518_1.time_ < 0 + var_521_0 + arg_521_0 and not isNil(arg_518_1.actors_["1095ui_story"]) and arg_518_1.var_.characterEffect1095ui_story then
				arg_518_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_518_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_521_1 = 0
			local var_521_2 = 0.95

			if 0 < arg_518_1.time_ and arg_518_1.time_ <= var_521_1 + arg_521_0 then
				arg_518_1.talkMaxDuration = 0
				arg_518_1.dialogCg_.alpha = 1

				arg_518_1.dialog_:SetActive(true)
				SetActive(arg_518_1.leftNameGo_, true)

				arg_518_1.leftNameTxt_.text = arg_518_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_518_1.leftNameTxt_.transform)

				arg_518_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_518_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_518_1:RecordName(arg_518_1.leftNameTxt_.text)
				SetActive(arg_518_1.iconTrs_.gameObject, true)
				arg_518_1.iconController_:SetSelectedState("hero")

				arg_518_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_518_1.callingController_:SetSelectedState("normal")

				arg_518_1.keyicon_.color = Color.New(1, 1, 1)
				arg_518_1.icon_.color = Color.New(1, 1, 1)

				local var_521_3 = arg_518_1:GetWordFromCfg(411051125)
				local var_521_4 = arg_518_1:FormatText(var_521_3.content)

				arg_518_1.text_.text = var_521_4

				LuaForUtil.ClearLinePrefixSymbol(arg_518_1.text_)

				local var_521_6 = 38 <= 0 and var_521_2 or var_521_2 * (utf8.len(var_521_4) / 38)

				if (38 <= 0 and var_521_2 or var_521_2 * (utf8.len(var_521_4) / 38)) > 0 and var_521_2 < var_521_6 then
					arg_518_1.talkMaxDuration = var_521_6

					if var_521_6 + var_521_1 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_6 + var_521_1
					end
				end

				arg_518_1.text_.text = var_521_4
				arg_518_1.typewritter.percent = 0

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051125", "story_v_out_411051.awb") ~= 0 then
					local var_521_7 = manager.audio:GetVoiceLength("story_v_out_411051", "411051125", "story_v_out_411051.awb") / 1000

					if var_521_7 + var_521_1 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_7 + var_521_1
					end

					if var_521_3.prefab_name ~= "" and arg_518_1.actors_[var_521_3.prefab_name] ~= nil then
						local var_521_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_518_1.actors_[var_521_3.prefab_name].transform, "story_v_out_411051", "411051125", "story_v_out_411051.awb")

						arg_518_1:RecordAudio("411051125", var_521_8)
						arg_518_1:RecordAudio("411051125", var_521_8)
					else
						arg_518_1:AudioAction("play", "voice", "story_v_out_411051", "411051125", "story_v_out_411051.awb")
					end

					arg_518_1:RecordHistoryTalkVoice("story_v_out_411051", "411051125", "story_v_out_411051.awb")
				end

				arg_518_1:RecordContent(arg_518_1.text_.text)
			end

			local var_521_9 = math.max(var_521_2, arg_518_1.talkMaxDuration)

			if var_521_1 <= arg_518_1.time_ and arg_518_1.time_ < var_521_1 + var_521_9 then
				arg_518_1.typewritter.percent = (arg_518_1.time_ - var_521_1) / var_521_9

				arg_518_1.typewritter:SetDirty()
			end

			if arg_518_1.time_ >= var_521_1 + var_521_9 and arg_518_1.time_ < var_521_1 + var_521_9 + arg_521_0 then
				arg_518_1.typewritter.percent = 1

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(true)
			end
		end

		arg_518_1.nodeConfigList_ = {}

		arg_518_1:InitPlayNodeList()
	end,
	Play411051126 = function(arg_522_0, arg_522_1)
		arg_522_1.time_ = 0
		arg_522_1.frameCnt_ = 0
		arg_522_1.state_ = "playing"
		arg_522_1.curTalkId_ = 411051126
		arg_522_1.duration_ = 14.3

		local var_522_0 = {
			zh = 14.3,
			ja = 4.766
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
				arg_522_0:Play411051127(arg_522_1)
			end
		end

		function arg_522_1.onSingleLineUpdate_(arg_525_0)
			local var_525_0 = 1.425

			if 0 < arg_522_1.time_ and arg_522_1.time_ <= 0 + arg_525_0 then
				arg_522_1.talkMaxDuration = 0
				arg_522_1.dialogCg_.alpha = 1

				arg_522_1.dialog_:SetActive(true)
				SetActive(arg_522_1.leftNameGo_, true)

				arg_522_1.leftNameTxt_.text = arg_522_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_522_1.leftNameTxt_.transform)

				arg_522_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_522_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_522_1:RecordName(arg_522_1.leftNameTxt_.text)
				SetActive(arg_522_1.iconTrs_.gameObject, true)
				arg_522_1.iconController_:SetSelectedState("hero")

				arg_522_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_522_1.callingController_:SetSelectedState("normal")

				arg_522_1.keyicon_.color = Color.New(1, 1, 1)
				arg_522_1.icon_.color = Color.New(1, 1, 1)

				local var_525_1 = arg_522_1:GetWordFromCfg(411051126)
				local var_525_2 = arg_522_1:FormatText(var_525_1.content)

				arg_522_1.text_.text = var_525_2

				LuaForUtil.ClearLinePrefixSymbol(arg_522_1.text_)

				local var_525_4 = 57 <= 0 and var_525_0 or var_525_0 * (utf8.len(var_525_2) / 57)

				if (57 <= 0 and var_525_0 or var_525_0 * (utf8.len(var_525_2) / 57)) > 0 and var_525_0 < var_525_4 then
					arg_522_1.talkMaxDuration = var_525_4

					if var_525_4 + 0 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_4 + 0
					end
				end

				arg_522_1.text_.text = var_525_2
				arg_522_1.typewritter.percent = 0

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051126", "story_v_out_411051.awb") ~= 0 then
					local var_525_5 = manager.audio:GetVoiceLength("story_v_out_411051", "411051126", "story_v_out_411051.awb") / 1000

					if var_525_5 + 0 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_5 + 0
					end

					if var_525_1.prefab_name ~= "" and arg_522_1.actors_[var_525_1.prefab_name] ~= nil then
						local var_525_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_522_1.actors_[var_525_1.prefab_name].transform, "story_v_out_411051", "411051126", "story_v_out_411051.awb")

						arg_522_1:RecordAudio("411051126", var_525_6)
						arg_522_1:RecordAudio("411051126", var_525_6)
					else
						arg_522_1:AudioAction("play", "voice", "story_v_out_411051", "411051126", "story_v_out_411051.awb")
					end

					arg_522_1:RecordHistoryTalkVoice("story_v_out_411051", "411051126", "story_v_out_411051.awb")
				end

				arg_522_1:RecordContent(arg_522_1.text_.text)
			end

			local var_525_7 = math.max(var_525_0, arg_522_1.talkMaxDuration)

			if 0 <= arg_522_1.time_ and arg_522_1.time_ < 0 + var_525_7 then
				arg_522_1.typewritter.percent = (arg_522_1.time_ - 0) / var_525_7

				arg_522_1.typewritter:SetDirty()
			end

			if arg_522_1.time_ >= 0 + var_525_7 and arg_522_1.time_ < 0 + var_525_7 + arg_525_0 then
				arg_522_1.typewritter.percent = 1

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(true)
			end
		end

		arg_522_1.nodeConfigList_ = {}

		arg_522_1:InitPlayNodeList()
	end,
	Play411051127 = function(arg_526_0, arg_526_1)
		arg_526_1.time_ = 0
		arg_526_1.frameCnt_ = 0
		arg_526_1.state_ = "playing"
		arg_526_1.curTalkId_ = 411051127
		arg_526_1.duration_ = 4.4

		local var_526_0 = {
			zh = 4.4,
			ja = 3.1
		}
		local var_526_1 = manager.audio:GetLocalizationFlag()

		if var_526_0[var_526_1] ~= nil then
			arg_526_1.duration_ = var_526_0[var_526_1]
		end

		SetActive(arg_526_1.tipsGo_, false)

		function arg_526_1.onSingleLineFinish_()
			arg_526_1.onSingleLineUpdate_ = nil
			arg_526_1.onSingleLineFinish_ = nil
			arg_526_1.state_ = "waiting"
		end

		function arg_526_1.playNext_(arg_528_0)
			if arg_528_0 == 1 then
				arg_526_0:Play411051128(arg_526_1)
			end
		end

		function arg_526_1.onSingleLineUpdate_(arg_529_0)
			if 0 < arg_526_1.time_ and arg_526_1.time_ <= 0 + arg_529_0 and not isNil(arg_526_1.actors_["1095ui_story"]) and arg_526_1.var_.characterEffect1095ui_story == nil then
				arg_526_1.var_.characterEffect1095ui_story = arg_526_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_529_0 = 0.200000002980232

			if 0 <= arg_526_1.time_ and arg_526_1.time_ < 0 + var_529_0 and not isNil(arg_526_1.actors_["1095ui_story"]) then
				if arg_526_1.var_.characterEffect1095ui_story and not isNil(arg_526_1.actors_["1095ui_story"]) then
					arg_526_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_526_1.time_ >= 0 + var_529_0 and arg_526_1.time_ < 0 + var_529_0 + arg_529_0 and not isNil(arg_526_1.actors_["1095ui_story"]) and arg_526_1.var_.characterEffect1095ui_story then
				arg_526_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_529_2 = 0
			local var_529_3 = 0.525

			if 0 < arg_526_1.time_ and arg_526_1.time_ <= var_529_2 + arg_529_0 then
				arg_526_1.talkMaxDuration = 0
				arg_526_1.dialogCg_.alpha = 1

				arg_526_1.dialog_:SetActive(true)
				SetActive(arg_526_1.leftNameGo_, true)

				arg_526_1.leftNameTxt_.text = arg_526_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_526_1.leftNameTxt_.transform)

				arg_526_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_526_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_526_1:RecordName(arg_526_1.leftNameTxt_.text)
				SetActive(arg_526_1.iconTrs_.gameObject, false)
				arg_526_1.callingController_:SetSelectedState("normal")

				local var_529_4 = arg_526_1:GetWordFromCfg(411051127)
				local var_529_5 = arg_526_1:FormatText(var_529_4.content)

				arg_526_1.text_.text = var_529_5

				LuaForUtil.ClearLinePrefixSymbol(arg_526_1.text_)

				local var_529_7 = 21 <= 0 and var_529_3 or var_529_3 * (utf8.len(var_529_5) / 21)

				if (21 <= 0 and var_529_3 or var_529_3 * (utf8.len(var_529_5) / 21)) > 0 and var_529_3 < var_529_7 then
					arg_526_1.talkMaxDuration = var_529_7

					if var_529_7 + var_529_2 > arg_526_1.duration_ then
						arg_526_1.duration_ = var_529_7 + var_529_2
					end
				end

				arg_526_1.text_.text = var_529_5
				arg_526_1.typewritter.percent = 0

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051127", "story_v_out_411051.awb") ~= 0 then
					local var_529_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051127", "story_v_out_411051.awb") / 1000

					if var_529_8 + var_529_2 > arg_526_1.duration_ then
						arg_526_1.duration_ = var_529_8 + var_529_2
					end

					if var_529_4.prefab_name ~= "" and arg_526_1.actors_[var_529_4.prefab_name] ~= nil then
						local var_529_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_526_1.actors_[var_529_4.prefab_name].transform, "story_v_out_411051", "411051127", "story_v_out_411051.awb")

						arg_526_1:RecordAudio("411051127", var_529_9)
						arg_526_1:RecordAudio("411051127", var_529_9)
					else
						arg_526_1:AudioAction("play", "voice", "story_v_out_411051", "411051127", "story_v_out_411051.awb")
					end

					arg_526_1:RecordHistoryTalkVoice("story_v_out_411051", "411051127", "story_v_out_411051.awb")
				end

				arg_526_1:RecordContent(arg_526_1.text_.text)
			end

			local var_529_10 = math.max(var_529_3, arg_526_1.talkMaxDuration)

			if var_529_2 <= arg_526_1.time_ and arg_526_1.time_ < var_529_2 + var_529_10 then
				arg_526_1.typewritter.percent = (arg_526_1.time_ - var_529_2) / var_529_10

				arg_526_1.typewritter:SetDirty()
			end

			if arg_526_1.time_ >= var_529_2 + var_529_10 and arg_526_1.time_ < var_529_2 + var_529_10 + arg_529_0 then
				arg_526_1.typewritter.percent = 1

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(true)
			end
		end

		arg_526_1.nodeConfigList_ = {}

		arg_526_1:InitPlayNodeList()
	end,
	Play411051128 = function(arg_530_0, arg_530_1)
		arg_530_1.time_ = 0
		arg_530_1.frameCnt_ = 0
		arg_530_1.state_ = "playing"
		arg_530_1.curTalkId_ = 411051128
		arg_530_1.duration_ = 4.4

		local var_530_0 = {
			zh = 4.4,
			ja = 4.3
		}
		local var_530_1 = manager.audio:GetLocalizationFlag()

		if var_530_0[var_530_1] ~= nil then
			arg_530_1.duration_ = var_530_0[var_530_1]
		end

		SetActive(arg_530_1.tipsGo_, false)

		function arg_530_1.onSingleLineFinish_()
			arg_530_1.onSingleLineUpdate_ = nil
			arg_530_1.onSingleLineFinish_ = nil
			arg_530_1.state_ = "waiting"
		end

		function arg_530_1.playNext_(arg_532_0)
			if arg_532_0 == 1 then
				arg_530_0:Play411051129(arg_530_1)
			end
		end

		function arg_530_1.onSingleLineUpdate_(arg_533_0)
			local var_533_0 = 0.55

			if 0 < arg_530_1.time_ and arg_530_1.time_ <= 0 + arg_533_0 then
				arg_530_1.talkMaxDuration = 0
				arg_530_1.dialogCg_.alpha = 1

				arg_530_1.dialog_:SetActive(true)
				SetActive(arg_530_1.leftNameGo_, true)

				arg_530_1.leftNameTxt_.text = arg_530_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_530_1.leftNameTxt_.transform)

				arg_530_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_530_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_530_1:RecordName(arg_530_1.leftNameTxt_.text)
				SetActive(arg_530_1.iconTrs_.gameObject, false)
				arg_530_1.callingController_:SetSelectedState("normal")

				local var_533_1 = arg_530_1:GetWordFromCfg(411051128)
				local var_533_2 = arg_530_1:FormatText(var_533_1.content)

				arg_530_1.text_.text = var_533_2

				LuaForUtil.ClearLinePrefixSymbol(arg_530_1.text_)

				local var_533_4 = 22 <= 0 and var_533_0 or var_533_0 * (utf8.len(var_533_2) / 22)

				if (22 <= 0 and var_533_0 or var_533_0 * (utf8.len(var_533_2) / 22)) > 0 and var_533_0 < var_533_4 then
					arg_530_1.talkMaxDuration = var_533_4

					if var_533_4 + 0 > arg_530_1.duration_ then
						arg_530_1.duration_ = var_533_4 + 0
					end
				end

				arg_530_1.text_.text = var_533_2
				arg_530_1.typewritter.percent = 0

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051128", "story_v_out_411051.awb") ~= 0 then
					local var_533_5 = manager.audio:GetVoiceLength("story_v_out_411051", "411051128", "story_v_out_411051.awb") / 1000

					if var_533_5 + 0 > arg_530_1.duration_ then
						arg_530_1.duration_ = var_533_5 + 0
					end

					if var_533_1.prefab_name ~= "" and arg_530_1.actors_[var_533_1.prefab_name] ~= nil then
						local var_533_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_530_1.actors_[var_533_1.prefab_name].transform, "story_v_out_411051", "411051128", "story_v_out_411051.awb")

						arg_530_1:RecordAudio("411051128", var_533_6)
						arg_530_1:RecordAudio("411051128", var_533_6)
					else
						arg_530_1:AudioAction("play", "voice", "story_v_out_411051", "411051128", "story_v_out_411051.awb")
					end

					arg_530_1:RecordHistoryTalkVoice("story_v_out_411051", "411051128", "story_v_out_411051.awb")
				end

				arg_530_1:RecordContent(arg_530_1.text_.text)
			end

			local var_533_7 = math.max(var_533_0, arg_530_1.talkMaxDuration)

			if 0 <= arg_530_1.time_ and arg_530_1.time_ < 0 + var_533_7 then
				arg_530_1.typewritter.percent = (arg_530_1.time_ - 0) / var_533_7

				arg_530_1.typewritter:SetDirty()
			end

			if arg_530_1.time_ >= 0 + var_533_7 and arg_530_1.time_ < 0 + var_533_7 + arg_533_0 then
				arg_530_1.typewritter.percent = 1

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(true)
			end
		end

		arg_530_1.nodeConfigList_ = {}

		arg_530_1:InitPlayNodeList()
	end,
	Play411051129 = function(arg_534_0, arg_534_1)
		arg_534_1.time_ = 0
		arg_534_1.frameCnt_ = 0
		arg_534_1.state_ = "playing"
		arg_534_1.curTalkId_ = 411051129
		arg_534_1.duration_ = 2.3

		local var_534_0 = {
			zh = 2.3,
			ja = 2.133
		}
		local var_534_1 = manager.audio:GetLocalizationFlag()

		if var_534_0[var_534_1] ~= nil then
			arg_534_1.duration_ = var_534_0[var_534_1]
		end

		SetActive(arg_534_1.tipsGo_, false)

		function arg_534_1.onSingleLineFinish_()
			arg_534_1.onSingleLineUpdate_ = nil
			arg_534_1.onSingleLineFinish_ = nil
			arg_534_1.state_ = "waiting"
			arg_534_1.auto_ = false
		end

		function arg_534_1.playNext_(arg_536_0)
			arg_534_1.onStoryFinished_()
		end

		function arg_534_1.onSingleLineUpdate_(arg_537_0)
			if 0 < arg_534_1.time_ and arg_534_1.time_ <= 0 + arg_537_0 and not isNil(arg_534_1.actors_["1095ui_story"]) and arg_534_1.var_.characterEffect1095ui_story == nil then
				arg_534_1.var_.characterEffect1095ui_story = arg_534_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_537_0 = 0.200000002980232

			if 0 <= arg_534_1.time_ and arg_534_1.time_ < 0 + var_537_0 and not isNil(arg_534_1.actors_["1095ui_story"]) then
				if arg_534_1.var_.characterEffect1095ui_story and not isNil(arg_534_1.actors_["1095ui_story"]) then
					arg_534_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_534_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_534_1.time_ - 0) / var_537_0)
				end
			end

			if arg_534_1.time_ >= 0 + var_537_0 and arg_534_1.time_ < 0 + var_537_0 + arg_537_0 and not isNil(arg_534_1.actors_["1095ui_story"]) and arg_534_1.var_.characterEffect1095ui_story then
				arg_534_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_534_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_537_1 = 0
			local var_537_2 = 0.2

			if 0 < arg_534_1.time_ and arg_534_1.time_ <= var_537_1 + arg_537_0 then
				arg_534_1.talkMaxDuration = 0
				arg_534_1.dialogCg_.alpha = 1

				arg_534_1.dialog_:SetActive(true)
				SetActive(arg_534_1.leftNameGo_, true)

				arg_534_1.leftNameTxt_.text = arg_534_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_534_1.leftNameTxt_.transform)

				arg_534_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_534_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_534_1:RecordName(arg_534_1.leftNameTxt_.text)
				SetActive(arg_534_1.iconTrs_.gameObject, true)
				arg_534_1.iconController_:SetSelectedState("hero")

				arg_534_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_534_1.callingController_:SetSelectedState("normal")

				arg_534_1.keyicon_.color = Color.New(1, 1, 1)
				arg_534_1.icon_.color = Color.New(1, 1, 1)

				local var_537_3 = arg_534_1:GetWordFromCfg(411051129)
				local var_537_4 = arg_534_1:FormatText(var_537_3.content)

				arg_534_1.text_.text = var_537_4

				LuaForUtil.ClearLinePrefixSymbol(arg_534_1.text_)

				local var_537_6 = 8 <= 0 and var_537_2 or var_537_2 * (utf8.len(var_537_4) / 8)

				if (8 <= 0 and var_537_2 or var_537_2 * (utf8.len(var_537_4) / 8)) > 0 and var_537_2 < var_537_6 then
					arg_534_1.talkMaxDuration = var_537_6

					if var_537_6 + var_537_1 > arg_534_1.duration_ then
						arg_534_1.duration_ = var_537_6 + var_537_1
					end
				end

				arg_534_1.text_.text = var_537_4
				arg_534_1.typewritter.percent = 0

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051129", "story_v_out_411051.awb") ~= 0 then
					local var_537_7 = manager.audio:GetVoiceLength("story_v_out_411051", "411051129", "story_v_out_411051.awb") / 1000

					if var_537_7 + var_537_1 > arg_534_1.duration_ then
						arg_534_1.duration_ = var_537_7 + var_537_1
					end

					if var_537_3.prefab_name ~= "" and arg_534_1.actors_[var_537_3.prefab_name] ~= nil then
						local var_537_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_534_1.actors_[var_537_3.prefab_name].transform, "story_v_out_411051", "411051129", "story_v_out_411051.awb")

						arg_534_1:RecordAudio("411051129", var_537_8)
						arg_534_1:RecordAudio("411051129", var_537_8)
					else
						arg_534_1:AudioAction("play", "voice", "story_v_out_411051", "411051129", "story_v_out_411051.awb")
					end

					arg_534_1:RecordHistoryTalkVoice("story_v_out_411051", "411051129", "story_v_out_411051.awb")
				end

				arg_534_1:RecordContent(arg_534_1.text_.text)
			end

			local var_537_9 = math.max(var_537_2, arg_534_1.talkMaxDuration)

			if var_537_1 <= arg_534_1.time_ and arg_534_1.time_ < var_537_1 + var_537_9 then
				arg_534_1.typewritter.percent = (arg_534_1.time_ - var_537_1) / var_537_9

				arg_534_1.typewritter:SetDirty()
			end

			if arg_534_1.time_ >= var_537_1 + var_537_9 and arg_534_1.time_ < var_537_1 + var_537_9 + arg_537_0 then
				arg_534_1.typewritter.percent = 1

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(true)
			end
		end

		arg_534_1.nodeConfigList_ = {}

		arg_534_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST74",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST03",
		"TextureConfig/Background/I07",
		"TextureConfig/Background/B10a"
	},
	voices = {
		"story_v_out_411051.awb"
	}
}
