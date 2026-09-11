return {
	Play319811001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 319811001
		arg_1_1.duration_ = 6.87

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play319811002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.I11m == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I11m")
				var_4_0.name = "I11m"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.I11m = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.I11m

				arg_1_1.bgs_.I11m.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I11m" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_4 + 0.3 and arg_1_1.time_ < var_4_4 + 0.3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_5 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_5 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_6 = 2

			if var_4_5 <= arg_1_1.time_ and arg_1_1.time_ < var_4_5 + var_4_6 then
				local var_4_7 = Color.New(0, 0, 0)

				var_4_7.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_5) / var_4_6)
				arg_1_1.mask_.color = var_4_7
			end

			if arg_1_1.time_ >= var_4_5 + var_4_6 and arg_1_1.time_ < var_4_5 + var_4_6 + arg_4_0 then
				local var_4_8 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_8.a = 0
				arg_1_1.mask_.color = var_4_8
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_11 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_12 = 1.86666666666667
			local var_4_13 = 0.85

			if 1.86666666666667 < arg_1_1.time_ and arg_1_1.time_ <= var_4_12 + arg_4_0 then
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

				local var_4_15 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(319811001).content)

				arg_1_1.text_.text = var_4_15

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_17 = 34 <= 0 and var_4_13 or var_4_13 * (utf8.len(var_4_15) / 34)

				if (34 <= 0 and var_4_13 or var_4_13 * (utf8.len(var_4_15) / 34)) > 0 and var_4_13 < var_4_17 then
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
	Play319811002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 319811002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play319811003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0.775

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

				local var_11_1 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(319811002).content)

				arg_8_1.text_.text = var_11_1

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_3 = 31 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 31)

				if (31 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 31)) > 0 and var_11_0 < var_11_3 then
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
	Play319811003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 319811003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play319811004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 1.075

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

				local var_15_1 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(319811003).content)

				arg_12_1.text_.text = var_15_1

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_3 = 43 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 43)

				if (43 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 43)) > 0 and var_15_0 < var_15_3 then
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
	Play319811004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 319811004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play319811005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 1.325

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

				local var_19_1 = arg_16_1:FormatText(arg_16_1:GetWordFromCfg(319811004).content)

				arg_16_1.text_.text = var_19_1

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_3 = 53 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_1) / 53)

				if (53 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_1) / 53)) > 0 and var_19_0 < var_19_3 then
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
	Play319811005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 319811005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play319811006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0.875

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, false)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_1 = arg_20_1:FormatText(arg_20_1:GetWordFromCfg(319811005).content)

				arg_20_1.text_.text = var_23_1

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_3 = 35 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_1) / 35)

				if (35 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_1) / 35)) > 0 and var_23_0 < var_23_3 then
					arg_20_1.talkMaxDuration = var_23_3

					if var_23_3 + 0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_3 + 0
					end
				end

				arg_20_1.text_.text = var_23_1
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_4 = math.max(var_23_0, arg_20_1.talkMaxDuration)

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_4 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - 0) / var_23_4

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= 0 + var_23_4 and arg_20_1.time_ < 0 + var_23_4 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play319811006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 319811006
		arg_24_1.duration_ = 7.57

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play319811007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if arg_24_1.bgs_.ST72a == nil then
				local var_27_0 = Object.Instantiate(arg_24_1.paintGo_)

				var_27_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST72a")
				var_27_0.name = "ST72a"
				var_27_0.transform.parent = arg_24_1.stage_.transform
				var_27_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_24_1.bgs_.ST72a = var_27_0
			end

			if 1 < arg_24_1.time_ and arg_24_1.time_ <= 1 + arg_27_0 then
				local var_27_1 = arg_24_1.bgs_.ST72a

				arg_24_1.bgs_.ST72a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_27_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_27_2 = var_27_1:GetComponent("SpriteRenderer")

				if var_27_2 and var_27_2.sprite then
					local var_27_3 = 2 * (var_27_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_27_1.transform.localScale = Vector3.New(var_27_3 / var_27_2.sprite.bounds.size.y < var_27_3 * manager.ui.mainCameraCom_.aspect / var_27_2.sprite.bounds.size.x and var_27_3 * manager.ui.mainCameraCom_.aspect / var_27_2.sprite.bounds.size.x or var_27_3 / var_27_2.sprite.bounds.size.y, var_27_3 / var_27_2.sprite.bounds.size.y < var_27_3 * manager.ui.mainCameraCom_.aspect / var_27_2.sprite.bounds.size.x and var_27_3 * manager.ui.mainCameraCom_.aspect / var_27_2.sprite.bounds.size.x or var_27_3 / var_27_2.sprite.bounds.size.y, 0)
				end

				for iter_27_0, iter_27_1 in pairs(arg_24_1.bgs_) do
					if iter_27_0 ~= "ST72a" then
						iter_27_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_27_4 = 0

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_4 + arg_27_0 then
				arg_24_1.allBtn_.enabled = false
			end

			if arg_24_1.time_ >= var_27_4 + 0.3 and arg_24_1.time_ < var_27_4 + 0.3 + arg_27_0 then
				arg_24_1.allBtn_.enabled = true
			end

			local var_27_5 = 0

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_5 + arg_27_0 then
				arg_24_1.mask_.enabled = true
				arg_24_1.mask_.raycastTarget = true

				arg_24_1:SetGaussion(false)
			end

			local var_27_6 = 1

			if var_27_5 <= arg_24_1.time_ and arg_24_1.time_ < var_27_5 + var_27_6 then
				local var_27_7 = Color.New(0, 0, 0)

				var_27_7.a = Mathf.Lerp(0, 1, (arg_24_1.time_ - var_27_5) / var_27_6)
				arg_24_1.mask_.color = var_27_7
			end

			if arg_24_1.time_ >= var_27_5 + var_27_6 and arg_24_1.time_ < var_27_5 + var_27_6 + arg_27_0 then
				local var_27_8 = Color.New(0, 0, 0)

				var_27_8.a = 1
				arg_24_1.mask_.color = var_27_8
			end

			local var_27_9 = 1

			if 1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_9 + arg_27_0 then
				arg_24_1.mask_.enabled = true
				arg_24_1.mask_.raycastTarget = true

				arg_24_1:SetGaussion(false)
			end

			local var_27_10 = 2

			if var_27_9 <= arg_24_1.time_ and arg_24_1.time_ < var_27_9 + var_27_10 then
				local var_27_11 = Color.New(0, 0, 0)

				var_27_11.a = Mathf.Lerp(1, 0, (arg_24_1.time_ - var_27_9) / var_27_10)
				arg_24_1.mask_.color = var_27_11
			end

			if arg_24_1.time_ >= var_27_9 + var_27_10 and arg_24_1.time_ < var_27_9 + var_27_10 + arg_27_0 then
				local var_27_12 = Color.New(0, 0, 0)

				arg_24_1.mask_.enabled = false
				var_27_12.a = 0
				arg_24_1.mask_.color = var_27_12
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_27_15 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_24_1.bgmTxt_.text ~= var_27_15 and arg_24_1.bgmTxt_.text ~= "" then
						if arg_24_1.bgmTxt2_.text ~= "" then
							arg_24_1.bgmTxt_.text = arg_24_1.bgmTxt2_.text
						end

						arg_24_1.bgmTxt2_.text = var_27_15

						arg_24_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_24_1.bgmTxt_.text = var_27_15
						arg_24_1.bgmTxt2_.text = var_27_15
					end

					if arg_24_1.bgmTimer then
						arg_24_1.bgmTimer:Stop()

						arg_24_1.bgmTimer = nil
					end

					if arg_24_1.settingData.show_music_name == 1 then
						arg_24_1.musicController:SetSelectedState("show")
						arg_24_1.musicAnimator_:Play("open", 0, 0)

						if arg_24_1.settingData.music_time ~= 0 then
							arg_24_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_24_1.settingData.music_time), function()
								if arg_24_1 == nil or isNil(arg_24_1.bgmTxt_) then
									return
								end

								arg_24_1.musicController:SetSelectedState("hide")
								arg_24_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.233333333333333 < arg_24_1.time_ and arg_24_1.time_ <= 0.233333333333333 + arg_27_0 then
				arg_24_1:AudioAction("play", "music", "bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad.awb")

				local var_27_18 = manager.audio:GetAudioName("bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad")

				if "" ~= "" then
					if arg_24_1.bgmTxt_.text ~= var_27_18 and arg_24_1.bgmTxt_.text ~= "" then
						if arg_24_1.bgmTxt2_.text ~= "" then
							arg_24_1.bgmTxt_.text = arg_24_1.bgmTxt2_.text
						end

						arg_24_1.bgmTxt2_.text = var_27_18

						arg_24_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_24_1.bgmTxt_.text = var_27_18
						arg_24_1.bgmTxt2_.text = var_27_18
					end

					if arg_24_1.bgmTimer then
						arg_24_1.bgmTimer:Stop()

						arg_24_1.bgmTimer = nil
					end

					if arg_24_1.settingData.show_music_name == 1 then
						arg_24_1.musicController:SetSelectedState("show")
						arg_24_1.musicAnimator_:Play("open", 0, 0)

						if arg_24_1.settingData.music_time ~= 0 then
							arg_24_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_24_1.settingData.music_time), function()
								if arg_24_1 == nil or isNil(arg_24_1.bgmTxt_) then
									return
								end

								arg_24_1.musicController:SetSelectedState("hide")
								arg_24_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_24_1.frameCnt_ <= 1 then
				arg_24_1.dialog_:SetActive(false)
			end

			local var_27_19 = 2.56666666666667
			local var_27_20 = 1.45

			if 2.56666666666667 < arg_24_1.time_ and arg_24_1.time_ <= var_27_19 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0

				arg_24_1.dialog_:SetActive(true)

				arg_24_1.dialogCg_.alpha = 0

				local var_27_21 = LeanTween.value(arg_24_1.dialog_, 0, 1, 0.3)

				var_27_21:setOnUpdate(LuaHelper.FloatAction(function(arg_30_0)
					arg_24_1.dialogCg_.alpha = arg_30_0
				end))
				var_27_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_24_1.dialog_)
					var_27_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_24_1.duration_ = arg_24_1.duration_ + 0.3

				SetActive(arg_24_1.leftNameGo_, false)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_22 = arg_24_1:FormatText(arg_24_1:GetWordFromCfg(319811006).content)

				arg_24_1.text_.text = var_27_22

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_24 = 58 <= 0 and var_27_20 or var_27_20 * (utf8.len(var_27_22) / 58)

				if (58 <= 0 and var_27_20 or var_27_20 * (utf8.len(var_27_22) / 58)) > 0 and var_27_20 < var_27_24 then
					arg_24_1.talkMaxDuration = var_27_24
					var_27_19 = var_27_19 + 0.3

					if var_27_24 + var_27_19 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_24 + var_27_19
					end
				end

				arg_24_1.text_.text = var_27_22
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_25 = var_27_19 + 0.3
			local var_27_26 = math.max(var_27_20, arg_24_1.talkMaxDuration)

			if var_27_19 + 0.3 <= arg_24_1.time_ and arg_24_1.time_ < var_27_25 + var_27_26 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_25) / var_27_26

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_25 + var_27_26 and arg_24_1.time_ < var_27_25 + var_27_26 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play319811007 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 319811007
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play319811008(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0.45

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[698].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_32_1.callingController_:SetSelectedState("normal")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_1 = arg_32_1:FormatText(arg_32_1:GetWordFromCfg(319811007).content)

				arg_32_1.text_.text = var_35_1

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_3 = 18 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_1) / 18)

				if (18 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_1) / 18)) > 0 and var_35_0 < var_35_3 then
					arg_32_1.talkMaxDuration = var_35_3

					if var_35_3 + 0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_3 + 0
					end
				end

				arg_32_1.text_.text = var_35_1
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_4 = math.max(var_35_0, arg_32_1.talkMaxDuration)

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_4 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - 0) / var_35_4

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= 0 + var_35_4 and arg_32_1.time_ < 0 + var_35_4 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play319811008 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 319811008
		arg_36_1.duration_ = 2.03

		local var_36_0 = {
			zh = 1.999999999999,
			ja = 2.033
		}
		local var_36_1 = manager.audio:GetLocalizationFlag()

		if var_36_0[var_36_1] ~= nil then
			arg_36_1.duration_ = var_36_0[var_36_1]
		end

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play319811009(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if arg_36_1.actors_["10069ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10069ui_story"))) then
				local var_39_0 = Object.Instantiate(Asset.Load("Char/" .. "10069ui_story"), arg_36_1.stage_.transform)

				var_39_0.name = "10069ui_story"
				var_39_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_36_1.actors_["10069ui_story"] = var_39_0

				local var_39_1 = var_39_0:GetComponentInChildren(typeof(CharacterEffect))

				var_39_1.enabled = true

				local var_39_2 = GameObjectTools.GetOrAddComponent(var_39_0, typeof(DynamicBoneHelper))

				if var_39_2 then
					var_39_2:EnableDynamicBone(false)
				end

				arg_36_1:ShowWeapon(var_39_1.transform, false)

				arg_36_1.var_["10069ui_story" .. "Animator"] = var_39_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_36_1.var_["10069ui_story" .. "Animator"].applyRootMotion = true
				arg_36_1.var_["10069ui_story" .. "LipSync"] = var_39_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_39_3 = arg_36_1.actors_["10069ui_story"].transform

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos10069ui_story = var_39_3.localPosition
			end

			local var_39_4 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_4 then
				var_39_3.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos10069ui_story, Vector3.New(0, -1.08, -6.33), (arg_36_1.time_ - 0) / var_39_4)
				var_39_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_3.position).x, (manager.ui.mainCamera.transform.position - var_39_3.position).y, (manager.ui.mainCamera.transform.position - var_39_3.position).z)
				var_39_3.localEulerAngles.z = 0
				var_39_3.localEulerAngles.x = 0
				var_39_3.localEulerAngles = var_39_3.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_4 and arg_36_1.time_ < 0 + var_39_4 + arg_39_0 then
				var_39_3.localPosition = Vector3.New(0, -1.08, -6.33)
				var_39_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_3.position).x, (manager.ui.mainCamera.transform.position - var_39_3.position).y, (manager.ui.mainCamera.transform.position - var_39_3.position).z)
				var_39_3.localEulerAngles.z = 0
				var_39_3.localEulerAngles.x = 0
				var_39_3.localEulerAngles = var_39_3.localEulerAngles
			end

			local var_39_5 = arg_36_1.actors_["10069ui_story"]

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(var_39_5) and arg_36_1.var_.characterEffect10069ui_story == nil then
				arg_36_1.var_.characterEffect10069ui_story = var_39_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_6 = 0.200000002980232

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_6 and not isNil(var_39_5) then
				if arg_36_1.var_.characterEffect10069ui_story and not isNil(var_39_5) then
					arg_36_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= 0 + var_39_6 and arg_36_1.time_ < 0 + var_39_6 + arg_39_0 and not isNil(var_39_5) and arg_36_1.var_.characterEffect10069ui_story then
				arg_36_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/story10056/story10056action/10056action1_1")
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_39_8 = 0
			local var_39_9 = 0.075

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_8 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[693].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_10 = arg_36_1:GetWordFromCfg(319811008)
				local var_39_11 = arg_36_1:FormatText(var_39_10.content)

				arg_36_1.text_.text = var_39_11

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_13 = 3 <= 0 and var_39_9 or var_39_9 * (utf8.len(var_39_11) / 3)

				if (3 <= 0 and var_39_9 or var_39_9 * (utf8.len(var_39_11) / 3)) > 0 and var_39_9 < var_39_13 then
					arg_36_1.talkMaxDuration = var_39_13

					if var_39_13 + var_39_8 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_13 + var_39_8
					end
				end

				arg_36_1.text_.text = var_39_11
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811008", "story_v_out_319811.awb") ~= 0 then
					local var_39_14 = manager.audio:GetVoiceLength("story_v_out_319811", "319811008", "story_v_out_319811.awb") / 1000

					if var_39_14 + var_39_8 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_14 + var_39_8
					end

					if var_39_10.prefab_name ~= "" and arg_36_1.actors_[var_39_10.prefab_name] ~= nil then
						local var_39_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_10.prefab_name].transform, "story_v_out_319811", "319811008", "story_v_out_319811.awb")

						arg_36_1:RecordAudio("319811008", var_39_15)
						arg_36_1:RecordAudio("319811008", var_39_15)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_319811", "319811008", "story_v_out_319811.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_319811", "319811008", "story_v_out_319811.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_16 = math.max(var_39_9, arg_36_1.talkMaxDuration)

			if var_39_8 <= arg_36_1.time_ and arg_36_1.time_ < var_39_8 + var_39_16 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_8) / var_39_16

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_8 + var_39_16 and arg_36_1.time_ < var_39_8 + var_39_16 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play319811009 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 319811009
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play319811010(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos10069ui_story = arg_40_1.actors_["10069ui_story"].transform.localPosition
			end

			local var_43_0 = 0.001

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 then
				arg_40_1.actors_["10069ui_story"].transform.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos10069ui_story, Vector3.New(0, 100, 0), (arg_40_1.time_ - 0) / var_43_0)
				arg_40_1.actors_["10069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_40_1.actors_["10069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["10069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["10069ui_story"].transform.position).z)
				arg_40_1.actors_["10069ui_story"].transform.localEulerAngles.z = 0
				arg_40_1.actors_["10069ui_story"].transform.localEulerAngles.x = 0
				arg_40_1.actors_["10069ui_story"].transform.localEulerAngles = arg_40_1.actors_["10069ui_story"].transform.localEulerAngles
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 then
				arg_40_1.actors_["10069ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_40_1.actors_["10069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_40_1.actors_["10069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["10069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["10069ui_story"].transform.position).z)
				arg_40_1.actors_["10069ui_story"].transform.localEulerAngles.z = 0
				arg_40_1.actors_["10069ui_story"].transform.localEulerAngles.x = 0
				arg_40_1.actors_["10069ui_story"].transform.localEulerAngles = arg_40_1.actors_["10069ui_story"].transform.localEulerAngles
			end

			local var_43_1 = arg_40_1.actors_["10069ui_story"]

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(var_43_1) and arg_40_1.var_.characterEffect10069ui_story == nil then
				arg_40_1.var_.characterEffect10069ui_story = var_43_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_2 = 0.200000002980232

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_2 and not isNil(var_43_1) then
				if arg_40_1.var_.characterEffect10069ui_story and not isNil(var_43_1) then
					arg_40_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_40_1.var_.characterEffect10069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_40_1.time_ - 0) / var_43_2)
				end
			end

			if arg_40_1.time_ >= 0 + var_43_2 and arg_40_1.time_ < 0 + var_43_2 + arg_43_0 and not isNil(var_43_1) and arg_40_1.var_.characterEffect10069ui_story then
				arg_40_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_40_1.var_.characterEffect10069ui_story.fillRatio = 0.5
			end

			local var_43_3 = 0
			local var_43_4 = 1.025

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_3 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, false)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_5 = arg_40_1:FormatText(arg_40_1:GetWordFromCfg(319811009).content)

				arg_40_1.text_.text = var_43_5

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_7 = 41 <= 0 and var_43_4 or var_43_4 * (utf8.len(var_43_5) / 41)

				if (41 <= 0 and var_43_4 or var_43_4 * (utf8.len(var_43_5) / 41)) > 0 and var_43_4 < var_43_7 then
					arg_40_1.talkMaxDuration = var_43_7

					if var_43_7 + var_43_3 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_7 + var_43_3
					end
				end

				arg_40_1.text_.text = var_43_5
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_8 = math.max(var_43_4, arg_40_1.talkMaxDuration)

			if var_43_3 <= arg_40_1.time_ and arg_40_1.time_ < var_43_3 + var_43_8 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_3) / var_43_8

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_3 + var_43_8 and arg_40_1.time_ < var_43_3 + var_43_8 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10069ui_story",
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
	Play319811010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 319811010
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play319811011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0.725

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, false)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_1 = arg_44_1:FormatText(arg_44_1:GetWordFromCfg(319811010).content)

				arg_44_1.text_.text = var_47_1

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_3 = 29 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_1) / 29)

				if (29 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_1) / 29)) > 0 and var_47_0 < var_47_3 then
					arg_44_1.talkMaxDuration = var_47_3

					if var_47_3 + 0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_3 + 0
					end
				end

				arg_44_1.text_.text = var_47_1
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_4 = math.max(var_47_0, arg_44_1.talkMaxDuration)

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_4 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - 0) / var_47_4

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= 0 + var_47_4 and arg_44_1.time_ < 0 + var_47_4 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play319811011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 319811011
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play319811012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 1.125

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

				local var_51_1 = arg_48_1:FormatText(arg_48_1:GetWordFromCfg(319811011).content)

				arg_48_1.text_.text = var_51_1

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_3 = 45 <= 0 and var_51_0 or var_51_0 * (utf8.len(var_51_1) / 45)

				if (45 <= 0 and var_51_0 or var_51_0 * (utf8.len(var_51_1) / 45)) > 0 and var_51_0 < var_51_3 then
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
	Play319811012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 319811012
		arg_52_1.duration_ = 3.23

		local var_52_0 = {
			zh = 1.999999999999,
			ja = 3.233
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
				arg_52_0:Play319811013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if arg_52_1.actors_["10058ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10058ui_story"))) then
				local var_55_0 = Object.Instantiate(Asset.Load("Char/" .. "10058ui_story"), arg_52_1.stage_.transform)

				var_55_0.name = "10058ui_story"
				var_55_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_52_1.actors_["10058ui_story"] = var_55_0

				local var_55_1 = var_55_0:GetComponentInChildren(typeof(CharacterEffect))

				var_55_1.enabled = true

				local var_55_2 = GameObjectTools.GetOrAddComponent(var_55_0, typeof(DynamicBoneHelper))

				if var_55_2 then
					var_55_2:EnableDynamicBone(false)
				end

				arg_52_1:ShowWeapon(var_55_1.transform, false)

				arg_52_1.var_["10058ui_story" .. "Animator"] = var_55_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_52_1.var_["10058ui_story" .. "Animator"].applyRootMotion = true
				arg_52_1.var_["10058ui_story" .. "LipSync"] = var_55_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_55_3 = arg_52_1.actors_["10058ui_story"].transform

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.var_.moveOldPos10058ui_story = var_55_3.localPosition
			end

			local var_55_4 = 0.001

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_4 then
				var_55_3.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_52_1.time_ - 0) / var_55_4)
				var_55_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_55_3.position).x, (manager.ui.mainCamera.transform.position - var_55_3.position).y, (manager.ui.mainCamera.transform.position - var_55_3.position).z)
				var_55_3.localEulerAngles.z = 0
				var_55_3.localEulerAngles.x = 0
				var_55_3.localEulerAngles = var_55_3.localEulerAngles
			end

			if arg_52_1.time_ >= 0 + var_55_4 and arg_52_1.time_ < 0 + var_55_4 + arg_55_0 then
				var_55_3.localPosition = Vector3.New(0, -0.98, -6.1)
				var_55_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_55_3.position).x, (manager.ui.mainCamera.transform.position - var_55_3.position).y, (manager.ui.mainCamera.transform.position - var_55_3.position).z)
				var_55_3.localEulerAngles.z = 0
				var_55_3.localEulerAngles.x = 0
				var_55_3.localEulerAngles = var_55_3.localEulerAngles
			end

			local var_55_5 = arg_52_1.actors_["10058ui_story"]

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(var_55_5) and arg_52_1.var_.characterEffect10058ui_story == nil then
				arg_52_1.var_.characterEffect10058ui_story = var_55_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_6 = 0.200000002980232

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_6 and not isNil(var_55_5) then
				if arg_52_1.var_.characterEffect10058ui_story and not isNil(var_55_5) then
					arg_52_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= 0 + var_55_6 and arg_52_1.time_ < 0 + var_55_6 + arg_55_0 and not isNil(var_55_5) and arg_52_1.var_.characterEffect10058ui_story then
				arg_52_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2202cva")
			end

			local var_55_8 = 0
			local var_55_9 = 0.225

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_8 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_10 = arg_52_1:GetWordFromCfg(319811012)
				local var_55_11 = arg_52_1:FormatText(var_55_10.content)

				arg_52_1.text_.text = var_55_11

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_13 = 9 <= 0 and var_55_9 or var_55_9 * (utf8.len(var_55_11) / 9)

				if (9 <= 0 and var_55_9 or var_55_9 * (utf8.len(var_55_11) / 9)) > 0 and var_55_9 < var_55_13 then
					arg_52_1.talkMaxDuration = var_55_13

					if var_55_13 + var_55_8 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_13 + var_55_8
					end
				end

				arg_52_1.text_.text = var_55_11
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811012", "story_v_out_319811.awb") ~= 0 then
					local var_55_14 = manager.audio:GetVoiceLength("story_v_out_319811", "319811012", "story_v_out_319811.awb") / 1000

					if var_55_14 + var_55_8 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_14 + var_55_8
					end

					if var_55_10.prefab_name ~= "" and arg_52_1.actors_[var_55_10.prefab_name] ~= nil then
						local var_55_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_10.prefab_name].transform, "story_v_out_319811", "319811012", "story_v_out_319811.awb")

						arg_52_1:RecordAudio("319811012", var_55_15)
						arg_52_1:RecordAudio("319811012", var_55_15)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_319811", "319811012", "story_v_out_319811.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_319811", "319811012", "story_v_out_319811.awb")
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
				actorName = "10058ui_story",
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
	Play319811013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 319811013
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play319811014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(arg_56_1.actors_["10058ui_story"]) and arg_56_1.var_.characterEffect10058ui_story == nil then
				arg_56_1.var_.characterEffect10058ui_story = arg_56_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_0 = 0.200000002980232

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 and not isNil(arg_56_1.actors_["10058ui_story"]) then
				if arg_56_1.var_.characterEffect10058ui_story and not isNil(arg_56_1.actors_["10058ui_story"]) then
					arg_56_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_56_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_56_1.time_ - 0) / var_59_0)
				end
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 and not isNil(arg_56_1.actors_["10058ui_story"]) and arg_56_1.var_.characterEffect10058ui_story then
				arg_56_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_56_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_59_1 = 0
			local var_59_2 = 0.125

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[698].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_3 = arg_56_1:FormatText(arg_56_1:GetWordFromCfg(319811013).content)

				arg_56_1.text_.text = var_59_3

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_5 = 5 <= 0 and var_59_2 or var_59_2 * (utf8.len(var_59_3) / 5)

				if (5 <= 0 and var_59_2 or var_59_2 * (utf8.len(var_59_3) / 5)) > 0 and var_59_2 < var_59_5 then
					arg_56_1.talkMaxDuration = var_59_5

					if var_59_5 + var_59_1 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_5 + var_59_1
					end
				end

				arg_56_1.text_.text = var_59_3
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_6 = math.max(var_59_2, arg_56_1.talkMaxDuration)

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_6 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_1) / var_59_6

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_1 + var_59_6 and arg_56_1.time_ < var_59_1 + var_59_6 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play319811014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 319811014
		arg_60_1.duration_ = 6.03

		local var_60_0 = {
			zh = 3.6,
			ja = 6.033
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
				arg_60_0:Play319811015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(arg_60_1.actors_["10058ui_story"]) and arg_60_1.var_.characterEffect10058ui_story == nil then
				arg_60_1.var_.characterEffect10058ui_story = arg_60_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_0 = 0.200000002980232

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_0 and not isNil(arg_60_1.actors_["10058ui_story"]) then
				if arg_60_1.var_.characterEffect10058ui_story and not isNil(arg_60_1.actors_["10058ui_story"]) then
					arg_60_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= 0 + var_63_0 and arg_60_1.time_ < 0 + var_63_0 + arg_63_0 and not isNil(arg_60_1.actors_["10058ui_story"]) and arg_60_1.var_.characterEffect10058ui_story then
				arg_60_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_63_2 = 0
			local var_63_3 = 0.375

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_2 + arg_63_0 then
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

				local var_63_4 = arg_60_1:GetWordFromCfg(319811014)
				local var_63_5 = arg_60_1:FormatText(var_63_4.content)

				arg_60_1.text_.text = var_63_5

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_7 = 15 <= 0 and var_63_3 or var_63_3 * (utf8.len(var_63_5) / 15)

				if (15 <= 0 and var_63_3 or var_63_3 * (utf8.len(var_63_5) / 15)) > 0 and var_63_3 < var_63_7 then
					arg_60_1.talkMaxDuration = var_63_7

					if var_63_7 + var_63_2 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_7 + var_63_2
					end
				end

				arg_60_1.text_.text = var_63_5
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811014", "story_v_out_319811.awb") ~= 0 then
					local var_63_8 = manager.audio:GetVoiceLength("story_v_out_319811", "319811014", "story_v_out_319811.awb") / 1000

					if var_63_8 + var_63_2 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_8 + var_63_2
					end

					if var_63_4.prefab_name ~= "" and arg_60_1.actors_[var_63_4.prefab_name] ~= nil then
						local var_63_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_4.prefab_name].transform, "story_v_out_319811", "319811014", "story_v_out_319811.awb")

						arg_60_1:RecordAudio("319811014", var_63_9)
						arg_60_1:RecordAudio("319811014", var_63_9)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_319811", "319811014", "story_v_out_319811.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_319811", "319811014", "story_v_out_319811.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_10 = math.max(var_63_3, arg_60_1.talkMaxDuration)

			if var_63_2 <= arg_60_1.time_ and arg_60_1.time_ < var_63_2 + var_63_10 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_2) / var_63_10

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_2 + var_63_10 and arg_60_1.time_ < var_63_2 + var_63_10 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play319811015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 319811015
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play319811016(arg_64_1)
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
			local var_67_2 = 0.45

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[698].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, true)
				arg_64_1.iconController_:SetSelectedState("hero")

				arg_64_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_64_1.callingController_:SetSelectedState("normal")

				arg_64_1.keyicon_.color = Color.New(1, 1, 1)
				arg_64_1.icon_.color = Color.New(1, 1, 1)

				local var_67_3 = arg_64_1:FormatText(arg_64_1:GetWordFromCfg(319811015).content)

				arg_64_1.text_.text = var_67_3

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_5 = 18 <= 0 and var_67_2 or var_67_2 * (utf8.len(var_67_3) / 18)

				if (18 <= 0 and var_67_2 or var_67_2 * (utf8.len(var_67_3) / 18)) > 0 and var_67_2 < var_67_5 then
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
	Play319811016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 319811016
		arg_68_1.duration_ = 7.77

		local var_68_0 = {
			zh = 3.466,
			ja = 7.766
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
				arg_68_0:Play319811017(arg_68_1)
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

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_1")
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_71_2 = 0
			local var_71_3 = 0.45

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_2 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_4 = arg_68_1:GetWordFromCfg(319811016)
				local var_71_5 = arg_68_1:FormatText(var_71_4.content)

				arg_68_1.text_.text = var_71_5

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_7 = 18 <= 0 and var_71_3 or var_71_3 * (utf8.len(var_71_5) / 18)

				if (18 <= 0 and var_71_3 or var_71_3 * (utf8.len(var_71_5) / 18)) > 0 and var_71_3 < var_71_7 then
					arg_68_1.talkMaxDuration = var_71_7

					if var_71_7 + var_71_2 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_7 + var_71_2
					end
				end

				arg_68_1.text_.text = var_71_5
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811016", "story_v_out_319811.awb") ~= 0 then
					local var_71_8 = manager.audio:GetVoiceLength("story_v_out_319811", "319811016", "story_v_out_319811.awb") / 1000

					if var_71_8 + var_71_2 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_8 + var_71_2
					end

					if var_71_4.prefab_name ~= "" and arg_68_1.actors_[var_71_4.prefab_name] ~= nil then
						local var_71_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_4.prefab_name].transform, "story_v_out_319811", "319811016", "story_v_out_319811.awb")

						arg_68_1:RecordAudio("319811016", var_71_9)
						arg_68_1:RecordAudio("319811016", var_71_9)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_319811", "319811016", "story_v_out_319811.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_319811", "319811016", "story_v_out_319811.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_10 = math.max(var_71_3, arg_68_1.talkMaxDuration)

			if var_71_2 <= arg_68_1.time_ and arg_68_1.time_ < var_71_2 + var_71_10 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_2) / var_71_10

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_2 + var_71_10 and arg_68_1.time_ < var_71_2 + var_71_10 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play319811017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 319811017
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play319811018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(arg_72_1.actors_["10058ui_story"]) and arg_72_1.var_.characterEffect10058ui_story == nil then
				arg_72_1.var_.characterEffect10058ui_story = arg_72_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_0 = 0.200000002980232

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_0 and not isNil(arg_72_1.actors_["10058ui_story"]) then
				if arg_72_1.var_.characterEffect10058ui_story and not isNil(arg_72_1.actors_["10058ui_story"]) then
					arg_72_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_72_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_72_1.time_ - 0) / var_75_0)
				end
			end

			if arg_72_1.time_ >= 0 + var_75_0 and arg_72_1.time_ < 0 + var_75_0 + arg_75_0 and not isNil(arg_72_1.actors_["10058ui_story"]) and arg_72_1.var_.characterEffect10058ui_story then
				arg_72_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_72_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_75_1 = 0
			local var_75_2 = 0.225

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[698].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, true)
				arg_72_1.iconController_:SetSelectedState("hero")

				arg_72_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_72_1.callingController_:SetSelectedState("normal")

				arg_72_1.keyicon_.color = Color.New(1, 1, 1)
				arg_72_1.icon_.color = Color.New(1, 1, 1)

				local var_75_3 = arg_72_1:FormatText(arg_72_1:GetWordFromCfg(319811017).content)

				arg_72_1.text_.text = var_75_3

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_5 = 9 <= 0 and var_75_2 or var_75_2 * (utf8.len(var_75_3) / 9)

				if (9 <= 0 and var_75_2 or var_75_2 * (utf8.len(var_75_3) / 9)) > 0 and var_75_2 < var_75_5 then
					arg_72_1.talkMaxDuration = var_75_5

					if var_75_5 + var_75_1 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_5 + var_75_1
					end
				end

				arg_72_1.text_.text = var_75_3
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_6 = math.max(var_75_2, arg_72_1.talkMaxDuration)

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_6 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_1) / var_75_6

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_1 + var_75_6 and arg_72_1.time_ < var_75_1 + var_75_6 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play319811018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 319811018
		arg_76_1.duration_ = 6

		local var_76_0 = {
			zh = 6,
			ja = 5.5
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
				arg_76_0:Play319811019(arg_76_1)
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

			local var_79_4 = 0
			local var_79_5 = 0.55

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

				local var_79_6 = arg_76_1:GetWordFromCfg(319811018)
				local var_79_7 = arg_76_1:FormatText(var_79_6.content)

				arg_76_1.text_.text = var_79_7

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_9 = 22 <= 0 and var_79_5 or var_79_5 * (utf8.len(var_79_7) / 22)

				if (22 <= 0 and var_79_5 or var_79_5 * (utf8.len(var_79_7) / 22)) > 0 and var_79_5 < var_79_9 then
					arg_76_1.talkMaxDuration = var_79_9

					if var_79_9 + var_79_4 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_9 + var_79_4
					end
				end

				arg_76_1.text_.text = var_79_7
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811018", "story_v_out_319811.awb") ~= 0 then
					local var_79_10 = manager.audio:GetVoiceLength("story_v_out_319811", "319811018", "story_v_out_319811.awb") / 1000

					if var_79_10 + var_79_4 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_10 + var_79_4
					end

					if var_79_6.prefab_name ~= "" and arg_76_1.actors_[var_79_6.prefab_name] ~= nil then
						local var_79_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_6.prefab_name].transform, "story_v_out_319811", "319811018", "story_v_out_319811.awb")

						arg_76_1:RecordAudio("319811018", var_79_11)
						arg_76_1:RecordAudio("319811018", var_79_11)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_319811", "319811018", "story_v_out_319811.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_319811", "319811018", "story_v_out_319811.awb")
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
	Play319811019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 319811019
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play319811020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(arg_80_1.actors_["10058ui_story"]) and arg_80_1.var_.characterEffect10058ui_story == nil then
				arg_80_1.var_.characterEffect10058ui_story = arg_80_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_0 = 0.200000002980232

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_0 and not isNil(arg_80_1.actors_["10058ui_story"]) then
				if arg_80_1.var_.characterEffect10058ui_story and not isNil(arg_80_1.actors_["10058ui_story"]) then
					arg_80_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_80_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_80_1.time_ - 0) / var_83_0)
				end
			end

			if arg_80_1.time_ >= 0 + var_83_0 and arg_80_1.time_ < 0 + var_83_0 + arg_83_0 and not isNil(arg_80_1.actors_["10058ui_story"]) and arg_80_1.var_.characterEffect10058ui_story then
				arg_80_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_80_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_83_1 = 0
			local var_83_2 = 0.225

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[698].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, true)
				arg_80_1.iconController_:SetSelectedState("hero")

				arg_80_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_80_1.callingController_:SetSelectedState("normal")

				arg_80_1.keyicon_.color = Color.New(1, 1, 1)
				arg_80_1.icon_.color = Color.New(1, 1, 1)

				local var_83_3 = arg_80_1:FormatText(arg_80_1:GetWordFromCfg(319811019).content)

				arg_80_1.text_.text = var_83_3

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_5 = 9 <= 0 and var_83_2 or var_83_2 * (utf8.len(var_83_3) / 9)

				if (9 <= 0 and var_83_2 or var_83_2 * (utf8.len(var_83_3) / 9)) > 0 and var_83_2 < var_83_5 then
					arg_80_1.talkMaxDuration = var_83_5

					if var_83_5 + var_83_1 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_5 + var_83_1
					end
				end

				arg_80_1.text_.text = var_83_3
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_6 = math.max(var_83_2, arg_80_1.talkMaxDuration)

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_6 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_1) / var_83_6

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_1 + var_83_6 and arg_80_1.time_ < var_83_1 + var_83_6 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play319811020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 319811020
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play319811021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0.925

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[698].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, true)
				arg_84_1.iconController_:SetSelectedState("hero")

				arg_84_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_84_1.callingController_:SetSelectedState("normal")

				arg_84_1.keyicon_.color = Color.New(1, 1, 1)
				arg_84_1.icon_.color = Color.New(1, 1, 1)

				local var_87_1 = arg_84_1:FormatText(arg_84_1:GetWordFromCfg(319811020).content)

				arg_84_1.text_.text = var_87_1

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_3 = 37 <= 0 and var_87_0 or var_87_0 * (utf8.len(var_87_1) / 37)

				if (37 <= 0 and var_87_0 or var_87_0 * (utf8.len(var_87_1) / 37)) > 0 and var_87_0 < var_87_3 then
					arg_84_1.talkMaxDuration = var_87_3

					if var_87_3 + 0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_3 + 0
					end
				end

				arg_84_1.text_.text = var_87_1
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_4 = math.max(var_87_0, arg_84_1.talkMaxDuration)

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_4 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - 0) / var_87_4

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= 0 + var_87_4 and arg_84_1.time_ < 0 + var_87_4 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play319811021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 319811021
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play319811022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 0.9

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[698].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, true)
				arg_88_1.iconController_:SetSelectedState("hero")

				arg_88_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_88_1.callingController_:SetSelectedState("normal")

				arg_88_1.keyicon_.color = Color.New(1, 1, 1)
				arg_88_1.icon_.color = Color.New(1, 1, 1)

				local var_91_1 = arg_88_1:FormatText(arg_88_1:GetWordFromCfg(319811021).content)

				arg_88_1.text_.text = var_91_1

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_3 = 36 <= 0 and var_91_0 or var_91_0 * (utf8.len(var_91_1) / 36)

				if (36 <= 0 and var_91_0 or var_91_0 * (utf8.len(var_91_1) / 36)) > 0 and var_91_0 < var_91_3 then
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
	Play319811022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 319811022
		arg_92_1.duration_ = 7.63

		local var_92_0 = {
			zh = 3.9,
			ja = 7.633
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
				arg_92_0:Play319811023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(arg_92_1.actors_["10058ui_story"]) and arg_92_1.var_.characterEffect10058ui_story == nil then
				arg_92_1.var_.characterEffect10058ui_story = arg_92_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_0 = 0.200000002980232

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_0 and not isNil(arg_92_1.actors_["10058ui_story"]) then
				if arg_92_1.var_.characterEffect10058ui_story and not isNil(arg_92_1.actors_["10058ui_story"]) then
					arg_92_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= 0 + var_95_0 and arg_92_1.time_ < 0 + var_95_0 + arg_95_0 and not isNil(arg_92_1.actors_["10058ui_story"]) and arg_92_1.var_.characterEffect10058ui_story then
				arg_92_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_2")
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_95_2 = 0
			local var_95_3 = 0.4

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_2 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_4 = arg_92_1:GetWordFromCfg(319811022)
				local var_95_5 = arg_92_1:FormatText(var_95_4.content)

				arg_92_1.text_.text = var_95_5

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_7 = 16 <= 0 and var_95_3 or var_95_3 * (utf8.len(var_95_5) / 16)

				if (16 <= 0 and var_95_3 or var_95_3 * (utf8.len(var_95_5) / 16)) > 0 and var_95_3 < var_95_7 then
					arg_92_1.talkMaxDuration = var_95_7

					if var_95_7 + var_95_2 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_7 + var_95_2
					end
				end

				arg_92_1.text_.text = var_95_5
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811022", "story_v_out_319811.awb") ~= 0 then
					local var_95_8 = manager.audio:GetVoiceLength("story_v_out_319811", "319811022", "story_v_out_319811.awb") / 1000

					if var_95_8 + var_95_2 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_8 + var_95_2
					end

					if var_95_4.prefab_name ~= "" and arg_92_1.actors_[var_95_4.prefab_name] ~= nil then
						local var_95_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_4.prefab_name].transform, "story_v_out_319811", "319811022", "story_v_out_319811.awb")

						arg_92_1:RecordAudio("319811022", var_95_9)
						arg_92_1:RecordAudio("319811022", var_95_9)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_319811", "319811022", "story_v_out_319811.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_319811", "319811022", "story_v_out_319811.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_10 = math.max(var_95_3, arg_92_1.talkMaxDuration)

			if var_95_2 <= arg_92_1.time_ and arg_92_1.time_ < var_95_2 + var_95_10 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_2) / var_95_10

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_2 + var_95_10 and arg_92_1.time_ < var_95_2 + var_95_10 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play319811023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 319811023
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play319811024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(arg_96_1.actors_["10058ui_story"]) and arg_96_1.var_.characterEffect10058ui_story == nil then
				arg_96_1.var_.characterEffect10058ui_story = arg_96_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_0 = 0.200000002980232

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_0 and not isNil(arg_96_1.actors_["10058ui_story"]) then
				if arg_96_1.var_.characterEffect10058ui_story and not isNil(arg_96_1.actors_["10058ui_story"]) then
					arg_96_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_96_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_96_1.time_ - 0) / var_99_0)
				end
			end

			if arg_96_1.time_ >= 0 + var_99_0 and arg_96_1.time_ < 0 + var_99_0 + arg_99_0 and not isNil(arg_96_1.actors_["10058ui_story"]) and arg_96_1.var_.characterEffect10058ui_story then
				arg_96_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_96_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_99_1 = 0
			local var_99_2 = 0.75

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[698].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, true)
				arg_96_1.iconController_:SetSelectedState("hero")

				arg_96_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_96_1.callingController_:SetSelectedState("normal")

				arg_96_1.keyicon_.color = Color.New(1, 1, 1)
				arg_96_1.icon_.color = Color.New(1, 1, 1)

				local var_99_3 = arg_96_1:FormatText(arg_96_1:GetWordFromCfg(319811023).content)

				arg_96_1.text_.text = var_99_3

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_5 = 30 <= 0 and var_99_2 or var_99_2 * (utf8.len(var_99_3) / 30)

				if (30 <= 0 and var_99_2 or var_99_2 * (utf8.len(var_99_3) / 30)) > 0 and var_99_2 < var_99_5 then
					arg_96_1.talkMaxDuration = var_99_5

					if var_99_5 + var_99_1 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_5 + var_99_1
					end
				end

				arg_96_1.text_.text = var_99_3
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_6 = math.max(var_99_2, arg_96_1.talkMaxDuration)

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_6 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_1) / var_99_6

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_1 + var_99_6 and arg_96_1.time_ < var_99_1 + var_99_6 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play319811024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 319811024
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play319811025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = 1.05

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[698].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, true)
				arg_100_1.iconController_:SetSelectedState("hero")

				arg_100_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_100_1.callingController_:SetSelectedState("normal")

				arg_100_1.keyicon_.color = Color.New(1, 1, 1)
				arg_100_1.icon_.color = Color.New(1, 1, 1)

				local var_103_1 = arg_100_1:FormatText(arg_100_1:GetWordFromCfg(319811024).content)

				arg_100_1.text_.text = var_103_1

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_3 = 42 <= 0 and var_103_0 or var_103_0 * (utf8.len(var_103_1) / 42)

				if (42 <= 0 and var_103_0 or var_103_0 * (utf8.len(var_103_1) / 42)) > 0 and var_103_0 < var_103_3 then
					arg_100_1.talkMaxDuration = var_103_3

					if var_103_3 + 0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_3 + 0
					end
				end

				arg_100_1.text_.text = var_103_1
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_4 = math.max(var_103_0, arg_100_1.talkMaxDuration)

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_4 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - 0) / var_103_4

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= 0 + var_103_4 and arg_100_1.time_ < 0 + var_103_4 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play319811025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 319811025
		arg_104_1.duration_ = 14.33

		local var_104_0 = {
			zh = 8.466,
			ja = 14.333
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
				arg_104_0:Play319811026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.var_.moveOldPos10058ui_story = arg_104_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_107_0 = 0.001

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_0 then
				arg_104_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_104_1.time_ - 0) / var_107_0)
				arg_104_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_104_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["10058ui_story"].transform.position).z)
				arg_104_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_104_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_104_1.actors_["10058ui_story"].transform.localEulerAngles = arg_104_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_104_1.time_ >= 0 + var_107_0 and arg_104_1.time_ < 0 + var_107_0 + arg_107_0 then
				arg_104_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_104_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_104_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["10058ui_story"].transform.position).z)
				arg_104_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_104_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_104_1.actors_["10058ui_story"].transform.localEulerAngles = arg_104_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_107_1 = arg_104_1.actors_["10058ui_story"]

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(var_107_1) and arg_104_1.var_.characterEffect10058ui_story == nil then
				arg_104_1.var_.characterEffect10058ui_story = var_107_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_2 = 0.200000002980232

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_2 and not isNil(var_107_1) then
				if arg_104_1.var_.characterEffect10058ui_story and not isNil(var_107_1) then
					arg_104_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= 0 + var_107_2 and arg_104_1.time_ < 0 + var_107_2 + arg_107_0 and not isNil(var_107_1) and arg_104_1.var_.characterEffect10058ui_story then
				arg_104_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_107_4 = 0
			local var_107_5 = 0.925

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_4 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_6 = arg_104_1:GetWordFromCfg(319811025)
				local var_107_7 = arg_104_1:FormatText(var_107_6.content)

				arg_104_1.text_.text = var_107_7

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_9 = 37 <= 0 and var_107_5 or var_107_5 * (utf8.len(var_107_7) / 37)

				if (37 <= 0 and var_107_5 or var_107_5 * (utf8.len(var_107_7) / 37)) > 0 and var_107_5 < var_107_9 then
					arg_104_1.talkMaxDuration = var_107_9

					if var_107_9 + var_107_4 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_9 + var_107_4
					end
				end

				arg_104_1.text_.text = var_107_7
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811025", "story_v_out_319811.awb") ~= 0 then
					local var_107_10 = manager.audio:GetVoiceLength("story_v_out_319811", "319811025", "story_v_out_319811.awb") / 1000

					if var_107_10 + var_107_4 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_10 + var_107_4
					end

					if var_107_6.prefab_name ~= "" and arg_104_1.actors_[var_107_6.prefab_name] ~= nil then
						local var_107_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_6.prefab_name].transform, "story_v_out_319811", "319811025", "story_v_out_319811.awb")

						arg_104_1:RecordAudio("319811025", var_107_11)
						arg_104_1:RecordAudio("319811025", var_107_11)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_319811", "319811025", "story_v_out_319811.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_319811", "319811025", "story_v_out_319811.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_12 = math.max(var_107_5, arg_104_1.talkMaxDuration)

			if var_107_4 <= arg_104_1.time_ and arg_104_1.time_ < var_107_4 + var_107_12 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_4) / var_107_12

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_4 + var_107_12 and arg_104_1.time_ < var_107_4 + var_107_12 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
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

		arg_104_1:InitPlayNodeList()
	end,
	Play319811026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 319811026
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play319811027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.var_.moveOldPos10058ui_story = arg_108_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_111_0 = 0.001

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_0 then
				arg_108_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_108_1.time_ - 0) / var_111_0)
				arg_108_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_108_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["10058ui_story"].transform.position).z)
				arg_108_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_108_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_108_1.actors_["10058ui_story"].transform.localEulerAngles = arg_108_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_108_1.time_ >= 0 + var_111_0 and arg_108_1.time_ < 0 + var_111_0 + arg_111_0 then
				arg_108_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_108_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_108_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["10058ui_story"].transform.position).z)
				arg_108_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_108_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_108_1.actors_["10058ui_story"].transform.localEulerAngles = arg_108_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_111_1 = arg_108_1.actors_["10058ui_story"]

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(var_111_1) and arg_108_1.var_.characterEffect10058ui_story == nil then
				arg_108_1.var_.characterEffect10058ui_story = var_111_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_2 = 0.200000002980232

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_2 and not isNil(var_111_1) then
				if arg_108_1.var_.characterEffect10058ui_story and not isNil(var_111_1) then
					arg_108_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_108_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_108_1.time_ - 0) / var_111_2)
				end
			end

			if arg_108_1.time_ >= 0 + var_111_2 and arg_108_1.time_ < 0 + var_111_2 + arg_111_0 and not isNil(var_111_1) and arg_108_1.var_.characterEffect10058ui_story then
				arg_108_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_108_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_111_3 = 0
			local var_111_4 = 0.725

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_3 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, false)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_5 = arg_108_1:FormatText(arg_108_1:GetWordFromCfg(319811026).content)

				arg_108_1.text_.text = var_111_5

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_7 = 29 <= 0 and var_111_4 or var_111_4 * (utf8.len(var_111_5) / 29)

				if (29 <= 0 and var_111_4 or var_111_4 * (utf8.len(var_111_5) / 29)) > 0 and var_111_4 < var_111_7 then
					arg_108_1.talkMaxDuration = var_111_7

					if var_111_7 + var_111_3 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_7 + var_111_3
					end
				end

				arg_108_1.text_.text = var_111_5
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_8 = math.max(var_111_4, arg_108_1.talkMaxDuration)

			if var_111_3 <= arg_108_1.time_ and arg_108_1.time_ < var_111_3 + var_111_8 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_3) / var_111_8

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_3 + var_111_8 and arg_108_1.time_ < var_111_3 + var_111_8 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {
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

		arg_108_1:InitPlayNodeList()
	end,
	Play319811027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 319811027
		arg_112_1.duration_ = 5

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play319811028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = 0.675

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[698].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, true)
				arg_112_1.iconController_:SetSelectedState("hero")

				arg_112_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_112_1.callingController_:SetSelectedState("normal")

				arg_112_1.keyicon_.color = Color.New(1, 1, 1)
				arg_112_1.icon_.color = Color.New(1, 1, 1)

				local var_115_1 = arg_112_1:FormatText(arg_112_1:GetWordFromCfg(319811027).content)

				arg_112_1.text_.text = var_115_1

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_3 = 27 <= 0 and var_115_0 or var_115_0 * (utf8.len(var_115_1) / 27)

				if (27 <= 0 and var_115_0 or var_115_0 * (utf8.len(var_115_1) / 27)) > 0 and var_115_0 < var_115_3 then
					arg_112_1.talkMaxDuration = var_115_3

					if var_115_3 + 0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_3 + 0
					end
				end

				arg_112_1.text_.text = var_115_1
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_4 = math.max(var_115_0, arg_112_1.talkMaxDuration)

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_4 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - 0) / var_115_4

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= 0 + var_115_4 and arg_112_1.time_ < 0 + var_115_4 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play319811028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 319811028
		arg_116_1.duration_ = 4.5

		local var_116_0 = {
			zh = 2.2,
			ja = 4.5
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
				arg_116_0:Play319811029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if arg_116_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_119_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_116_1.stage_.transform)

				var_119_0.name = "1084ui_story"
				var_119_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_116_1.actors_["1084ui_story"] = var_119_0

				local var_119_1 = var_119_0:GetComponentInChildren(typeof(CharacterEffect))

				var_119_1.enabled = true

				local var_119_2 = GameObjectTools.GetOrAddComponent(var_119_0, typeof(DynamicBoneHelper))

				if var_119_2 then
					var_119_2:EnableDynamicBone(false)
				end

				arg_116_1:ShowWeapon(var_119_1.transform, false)

				arg_116_1.var_["1084ui_story" .. "Animator"] = var_119_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_116_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_116_1.var_["1084ui_story" .. "LipSync"] = var_119_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_119_3 = arg_116_1.actors_["1084ui_story"].transform

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.var_.moveOldPos1084ui_story = var_119_3.localPosition

				arg_116_1:ShowWeapon(arg_116_1.var_["1084ui_story" .. "Animator"].transform, false)
			end

			local var_119_4 = 0.001

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_4 then
				var_119_3.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_116_1.time_ - 0) / var_119_4)
				var_119_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_119_3.position).x, (manager.ui.mainCamera.transform.position - var_119_3.position).y, (manager.ui.mainCamera.transform.position - var_119_3.position).z)
				var_119_3.localEulerAngles.z = 0
				var_119_3.localEulerAngles.x = 0
				var_119_3.localEulerAngles = var_119_3.localEulerAngles
			end

			if arg_116_1.time_ >= 0 + var_119_4 and arg_116_1.time_ < 0 + var_119_4 + arg_119_0 then
				var_119_3.localPosition = Vector3.New(0, -0.97, -6)
				var_119_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_119_3.position).x, (manager.ui.mainCamera.transform.position - var_119_3.position).y, (manager.ui.mainCamera.transform.position - var_119_3.position).z)
				var_119_3.localEulerAngles.z = 0
				var_119_3.localEulerAngles.x = 0
				var_119_3.localEulerAngles = var_119_3.localEulerAngles
			end

			local var_119_5 = arg_116_1.actors_["1084ui_story"]

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(var_119_5) and arg_116_1.var_.characterEffect1084ui_story == nil then
				arg_116_1.var_.characterEffect1084ui_story = var_119_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_6 = 0.200000002980232

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_6 and not isNil(var_119_5) then
				if arg_116_1.var_.characterEffect1084ui_story and not isNil(var_119_5) then
					arg_116_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= 0 + var_119_6 and arg_116_1.time_ < 0 + var_119_6 + arg_119_0 and not isNil(var_119_5) and arg_116_1.var_.characterEffect1084ui_story then
				arg_116_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_119_8 = 0
			local var_119_9 = 0.275

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_8 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_10 = arg_116_1:GetWordFromCfg(319811028)
				local var_119_11 = arg_116_1:FormatText(var_119_10.content)

				arg_116_1.text_.text = var_119_11

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_13 = 11 <= 0 and var_119_9 or var_119_9 * (utf8.len(var_119_11) / 11)

				if (11 <= 0 and var_119_9 or var_119_9 * (utf8.len(var_119_11) / 11)) > 0 and var_119_9 < var_119_13 then
					arg_116_1.talkMaxDuration = var_119_13

					if var_119_13 + var_119_8 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_13 + var_119_8
					end
				end

				arg_116_1.text_.text = var_119_11
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811028", "story_v_out_319811.awb") ~= 0 then
					local var_119_14 = manager.audio:GetVoiceLength("story_v_out_319811", "319811028", "story_v_out_319811.awb") / 1000

					if var_119_14 + var_119_8 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_14 + var_119_8
					end

					if var_119_10.prefab_name ~= "" and arg_116_1.actors_[var_119_10.prefab_name] ~= nil then
						local var_119_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_10.prefab_name].transform, "story_v_out_319811", "319811028", "story_v_out_319811.awb")

						arg_116_1:RecordAudio("319811028", var_119_15)
						arg_116_1:RecordAudio("319811028", var_119_15)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_319811", "319811028", "story_v_out_319811.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_319811", "319811028", "story_v_out_319811.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_16 = math.max(var_119_9, arg_116_1.talkMaxDuration)

			if var_119_8 <= arg_116_1.time_ and arg_116_1.time_ < var_119_8 + var_119_16 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_8) / var_119_16

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_8 + var_119_16 and arg_116_1.time_ < var_119_8 + var_119_16 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
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

		arg_116_1:InitPlayNodeList()
	end,
	Play319811029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 319811029
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play319811030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(arg_120_1.actors_["1084ui_story"]) and arg_120_1.var_.characterEffect1084ui_story == nil then
				arg_120_1.var_.characterEffect1084ui_story = arg_120_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_0 = 0.200000002980232

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_0 and not isNil(arg_120_1.actors_["1084ui_story"]) then
				if arg_120_1.var_.characterEffect1084ui_story and not isNil(arg_120_1.actors_["1084ui_story"]) then
					arg_120_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_120_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_120_1.time_ - 0) / var_123_0)
				end
			end

			if arg_120_1.time_ >= 0 + var_123_0 and arg_120_1.time_ < 0 + var_123_0 + arg_123_0 and not isNil(arg_120_1.actors_["1084ui_story"]) and arg_120_1.var_.characterEffect1084ui_story then
				arg_120_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_120_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_123_1 = 0
			local var_123_2 = 0.85

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, false)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_3 = arg_120_1:FormatText(arg_120_1:GetWordFromCfg(319811029).content)

				arg_120_1.text_.text = var_123_3

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_5 = 34 <= 0 and var_123_2 or var_123_2 * (utf8.len(var_123_3) / 34)

				if (34 <= 0 and var_123_2 or var_123_2 * (utf8.len(var_123_3) / 34)) > 0 and var_123_2 < var_123_5 then
					arg_120_1.talkMaxDuration = var_123_5

					if var_123_5 + var_123_1 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_5 + var_123_1
					end
				end

				arg_120_1.text_.text = var_123_3
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_6 = math.max(var_123_2, arg_120_1.talkMaxDuration)

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_6 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_1) / var_123_6

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_1 + var_123_6 and arg_120_1.time_ < var_123_1 + var_123_6 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play319811030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 319811030
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play319811031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 0.825

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[698].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, true)
				arg_124_1.iconController_:SetSelectedState("hero")

				arg_124_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_124_1.callingController_:SetSelectedState("normal")

				arg_124_1.keyicon_.color = Color.New(1, 1, 1)
				arg_124_1.icon_.color = Color.New(1, 1, 1)

				local var_127_1 = arg_124_1:FormatText(arg_124_1:GetWordFromCfg(319811030).content)

				arg_124_1.text_.text = var_127_1

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_3 = 33 <= 0 and var_127_0 or var_127_0 * (utf8.len(var_127_1) / 33)

				if (33 <= 0 and var_127_0 or var_127_0 * (utf8.len(var_127_1) / 33)) > 0 and var_127_0 < var_127_3 then
					arg_124_1.talkMaxDuration = var_127_3

					if var_127_3 + 0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_3 + 0
					end
				end

				arg_124_1.text_.text = var_127_1
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_4 = math.max(var_127_0, arg_124_1.talkMaxDuration)

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_4 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - 0) / var_127_4

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= 0 + var_127_4 and arg_124_1.time_ < 0 + var_127_4 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play319811031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 319811031
		arg_128_1.duration_ = 5

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play319811032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = 0.55

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[698].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, true)
				arg_128_1.iconController_:SetSelectedState("hero")

				arg_128_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_128_1.callingController_:SetSelectedState("normal")

				arg_128_1.keyicon_.color = Color.New(1, 1, 1)
				arg_128_1.icon_.color = Color.New(1, 1, 1)

				local var_131_1 = arg_128_1:FormatText(arg_128_1:GetWordFromCfg(319811031).content)

				arg_128_1.text_.text = var_131_1

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_3 = 22 <= 0 and var_131_0 or var_131_0 * (utf8.len(var_131_1) / 22)

				if (22 <= 0 and var_131_0 or var_131_0 * (utf8.len(var_131_1) / 22)) > 0 and var_131_0 < var_131_3 then
					arg_128_1.talkMaxDuration = var_131_3

					if var_131_3 + 0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_3 + 0
					end
				end

				arg_128_1.text_.text = var_131_1
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)
				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_4 = math.max(var_131_0, arg_128_1.talkMaxDuration)

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_4 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - 0) / var_131_4

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= 0 + var_131_4 and arg_128_1.time_ < 0 + var_131_4 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play319811032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 319811032
		arg_132_1.duration_ = 4.9

		local var_132_0 = {
			zh = 1.999999999999,
			ja = 4.9
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
				arg_132_0:Play319811033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.var_.moveOldPos1084ui_story = arg_132_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_135_0 = 0.001

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_0 then
				arg_132_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_132_1.time_ - 0) / var_135_0)
				arg_132_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_132_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["1084ui_story"].transform.position).z)
				arg_132_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_132_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_132_1.actors_["1084ui_story"].transform.localEulerAngles = arg_132_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_132_1.time_ >= 0 + var_135_0 and arg_132_1.time_ < 0 + var_135_0 + arg_135_0 then
				arg_132_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
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
				arg_132_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_2")
			end

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2201cva")
			end

			local var_135_4 = 0
			local var_135_5 = 0.1

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_4 + arg_135_0 then
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

				local var_135_6 = arg_132_1:GetWordFromCfg(319811032)
				local var_135_7 = arg_132_1:FormatText(var_135_6.content)

				arg_132_1.text_.text = var_135_7

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_9 = 4 <= 0 and var_135_5 or var_135_5 * (utf8.len(var_135_7) / 4)

				if (4 <= 0 and var_135_5 or var_135_5 * (utf8.len(var_135_7) / 4)) > 0 and var_135_5 < var_135_9 then
					arg_132_1.talkMaxDuration = var_135_9

					if var_135_9 + var_135_4 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_9 + var_135_4
					end
				end

				arg_132_1.text_.text = var_135_7
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811032", "story_v_out_319811.awb") ~= 0 then
					local var_135_10 = manager.audio:GetVoiceLength("story_v_out_319811", "319811032", "story_v_out_319811.awb") / 1000

					if var_135_10 + var_135_4 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_10 + var_135_4
					end

					if var_135_6.prefab_name ~= "" and arg_132_1.actors_[var_135_6.prefab_name] ~= nil then
						local var_135_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_6.prefab_name].transform, "story_v_out_319811", "319811032", "story_v_out_319811.awb")

						arg_132_1:RecordAudio("319811032", var_135_11)
						arg_132_1:RecordAudio("319811032", var_135_11)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_319811", "319811032", "story_v_out_319811.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_319811", "319811032", "story_v_out_319811.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_12 = math.max(var_135_5, arg_132_1.talkMaxDuration)

			if var_135_4 <= arg_132_1.time_ and arg_132_1.time_ < var_135_4 + var_135_12 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_4) / var_135_12

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_4 + var_135_12 and arg_132_1.time_ < var_135_4 + var_135_12 + arg_135_0 then
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
			}
		}

		arg_132_1:InitPlayNodeList()
	end,
	Play319811033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 319811033
		arg_136_1.duration_ = 5

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play319811034(arg_136_1)
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

			local var_139_1 = 0
			local var_139_2 = 0.125

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[698].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, true)
				arg_136_1.iconController_:SetSelectedState("hero")

				arg_136_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_136_1.callingController_:SetSelectedState("normal")

				arg_136_1.keyicon_.color = Color.New(1, 1, 1)
				arg_136_1.icon_.color = Color.New(1, 1, 1)

				local var_139_3 = arg_136_1:FormatText(arg_136_1:GetWordFromCfg(319811033).content)

				arg_136_1.text_.text = var_139_3

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_5 = 5 <= 0 and var_139_2 or var_139_2 * (utf8.len(var_139_3) / 5)

				if (5 <= 0 and var_139_2 or var_139_2 * (utf8.len(var_139_3) / 5)) > 0 and var_139_2 < var_139_5 then
					arg_136_1.talkMaxDuration = var_139_5

					if var_139_5 + var_139_1 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_5 + var_139_1
					end
				end

				arg_136_1.text_.text = var_139_3
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)
				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_6 = math.max(var_139_2, arg_136_1.talkMaxDuration)

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_6 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_1) / var_139_6

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_1 + var_139_6 and arg_136_1.time_ < var_139_1 + var_139_6 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play319811034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 319811034
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play319811035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1.var_.moveOldPos1084ui_story = arg_140_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_143_0 = 0.001

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_0 then
				arg_140_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_140_1.time_ - 0) / var_143_0)
				arg_140_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_140_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["1084ui_story"].transform.position).z)
				arg_140_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_140_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_140_1.actors_["1084ui_story"].transform.localEulerAngles = arg_140_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_140_1.time_ >= 0 + var_143_0 and arg_140_1.time_ < 0 + var_143_0 + arg_143_0 then
				arg_140_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_140_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_140_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["1084ui_story"].transform.position).z)
				arg_140_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_140_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_140_1.actors_["1084ui_story"].transform.localEulerAngles = arg_140_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_143_1 = 0
			local var_143_2 = 0.7

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

				local var_143_3 = arg_140_1:FormatText(arg_140_1:GetWordFromCfg(319811034).content)

				arg_140_1.text_.text = var_143_3

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_5 = 28 <= 0 and var_143_2 or var_143_2 * (utf8.len(var_143_3) / 28)

				if (28 <= 0 and var_143_2 or var_143_2 * (utf8.len(var_143_3) / 28)) > 0 and var_143_2 < var_143_5 then
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

		arg_140_1.nodeConfigList_ = {
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

		arg_140_1:InitPlayNodeList()
	end,
	Play319811035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 319811035
		arg_144_1.duration_ = 9.07

		local var_144_0 = {
			zh = 6.133,
			ja = 9.066
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
				arg_144_0:Play319811036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(arg_144_1.actors_["1084ui_story"]) and arg_144_1.var_.characterEffect1084ui_story == nil then
				arg_144_1.var_.characterEffect1084ui_story = arg_144_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_0 = 0.200000002980232

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_0 and not isNil(arg_144_1.actors_["1084ui_story"]) then
				if arg_144_1.var_.characterEffect1084ui_story and not isNil(arg_144_1.actors_["1084ui_story"]) then
					arg_144_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_144_1.time_ >= 0 + var_147_0 and arg_144_1.time_ < 0 + var_147_0 + arg_147_0 and not isNil(arg_144_1.actors_["1084ui_story"]) and arg_144_1.var_.characterEffect1084ui_story then
				arg_144_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_147_2 = arg_144_1.actors_["1084ui_story"].transform

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.var_.moveOldPos1084ui_story = var_147_2.localPosition
			end

			local var_147_3 = 0.001

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_3 then
				var_147_2.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_144_1.time_ - 0) / var_147_3)
				var_147_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_147_2.position).x, (manager.ui.mainCamera.transform.position - var_147_2.position).y, (manager.ui.mainCamera.transform.position - var_147_2.position).z)
				var_147_2.localEulerAngles.z = 0
				var_147_2.localEulerAngles.x = 0
				var_147_2.localEulerAngles = var_147_2.localEulerAngles
			end

			if arg_144_1.time_ >= 0 + var_147_3 and arg_144_1.time_ < 0 + var_147_3 + arg_147_0 then
				var_147_2.localPosition = Vector3.New(0, -0.97, -6)
				var_147_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_147_2.position).x, (manager.ui.mainCamera.transform.position - var_147_2.position).y, (manager.ui.mainCamera.transform.position - var_147_2.position).z)
				var_147_2.localEulerAngles.z = 0
				var_147_2.localEulerAngles.x = 0
				var_147_2.localEulerAngles = var_147_2.localEulerAngles
			end

			local var_147_4 = arg_144_1.actors_["1084ui_story"]

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(var_147_4) and arg_144_1.var_.characterEffect1084ui_story == nil then
				arg_144_1.var_.characterEffect1084ui_story = var_147_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_5 = 0.200000002980232

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_5 and not isNil(var_147_4) then
				if arg_144_1.var_.characterEffect1084ui_story and not isNil(var_147_4) then
					arg_144_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_144_1.time_ >= 0 + var_147_5 and arg_144_1.time_ < 0 + var_147_5 + arg_147_0 and not isNil(var_147_4) and arg_144_1.var_.characterEffect1084ui_story then
				arg_144_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_1")
			end

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2202cva")
			end

			local var_147_7 = 0
			local var_147_8 = 0.825

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_7 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_9 = arg_144_1:GetWordFromCfg(319811035)
				local var_147_10 = arg_144_1:FormatText(var_147_9.content)

				arg_144_1.text_.text = var_147_10

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_12 = 33 <= 0 and var_147_8 or var_147_8 * (utf8.len(var_147_10) / 33)

				if (33 <= 0 and var_147_8 or var_147_8 * (utf8.len(var_147_10) / 33)) > 0 and var_147_8 < var_147_12 then
					arg_144_1.talkMaxDuration = var_147_12

					if var_147_12 + var_147_7 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_12 + var_147_7
					end
				end

				arg_144_1.text_.text = var_147_10
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811035", "story_v_out_319811.awb") ~= 0 then
					local var_147_13 = manager.audio:GetVoiceLength("story_v_out_319811", "319811035", "story_v_out_319811.awb") / 1000

					if var_147_13 + var_147_7 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_13 + var_147_7
					end

					if var_147_9.prefab_name ~= "" and arg_144_1.actors_[var_147_9.prefab_name] ~= nil then
						local var_147_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_9.prefab_name].transform, "story_v_out_319811", "319811035", "story_v_out_319811.awb")

						arg_144_1:RecordAudio("319811035", var_147_14)
						arg_144_1:RecordAudio("319811035", var_147_14)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_319811", "319811035", "story_v_out_319811.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_319811", "319811035", "story_v_out_319811.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_15 = math.max(var_147_8, arg_144_1.talkMaxDuration)

			if var_147_7 <= arg_144_1.time_ and arg_144_1.time_ < var_147_7 + var_147_15 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_7) / var_147_15

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_7 + var_147_15 and arg_144_1.time_ < var_147_7 + var_147_15 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {
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

		arg_144_1:InitPlayNodeList()
	end,
	Play319811036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 319811036
		arg_148_1.duration_ = 9.07

		local var_148_0 = {
			zh = 7.966,
			ja = 9.066
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
				arg_148_0:Play319811037(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = 1

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				arg_148_1.leftNameTxt_.text = arg_148_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_1 = arg_148_1:GetWordFromCfg(319811036)
				local var_151_2 = arg_148_1:FormatText(var_151_1.content)

				arg_148_1.text_.text = var_151_2

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_4 = 40 <= 0 and var_151_0 or var_151_0 * (utf8.len(var_151_2) / 40)

				if (40 <= 0 and var_151_0 or var_151_0 * (utf8.len(var_151_2) / 40)) > 0 and var_151_0 < var_151_4 then
					arg_148_1.talkMaxDuration = var_151_4

					if var_151_4 + 0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_4 + 0
					end
				end

				arg_148_1.text_.text = var_151_2
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811036", "story_v_out_319811.awb") ~= 0 then
					local var_151_5 = manager.audio:GetVoiceLength("story_v_out_319811", "319811036", "story_v_out_319811.awb") / 1000

					if var_151_5 + 0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_5 + 0
					end

					if var_151_1.prefab_name ~= "" and arg_148_1.actors_[var_151_1.prefab_name] ~= nil then
						local var_151_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_1.prefab_name].transform, "story_v_out_319811", "319811036", "story_v_out_319811.awb")

						arg_148_1:RecordAudio("319811036", var_151_6)
						arg_148_1:RecordAudio("319811036", var_151_6)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_319811", "319811036", "story_v_out_319811.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_319811", "319811036", "story_v_out_319811.awb")
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
	Play319811037 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 319811037
		arg_152_1.duration_ = 6.93

		local var_152_0 = {
			zh = 6.933,
			ja = 6.633
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
				arg_152_0:Play319811038(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_2")
			end

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_155_0 = 0
			local var_155_1 = 0.875

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_0 + arg_155_0 then
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

				local var_155_2 = arg_152_1:GetWordFromCfg(319811037)
				local var_155_3 = arg_152_1:FormatText(var_155_2.content)

				arg_152_1.text_.text = var_155_3

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_5 = 35 <= 0 and var_155_1 or var_155_1 * (utf8.len(var_155_3) / 35)

				if (35 <= 0 and var_155_1 or var_155_1 * (utf8.len(var_155_3) / 35)) > 0 and var_155_1 < var_155_5 then
					arg_152_1.talkMaxDuration = var_155_5

					if var_155_5 + var_155_0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_5 + var_155_0
					end
				end

				arg_152_1.text_.text = var_155_3
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811037", "story_v_out_319811.awb") ~= 0 then
					local var_155_6 = manager.audio:GetVoiceLength("story_v_out_319811", "319811037", "story_v_out_319811.awb") / 1000

					if var_155_6 + var_155_0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_6 + var_155_0
					end

					if var_155_2.prefab_name ~= "" and arg_152_1.actors_[var_155_2.prefab_name] ~= nil then
						local var_155_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_2.prefab_name].transform, "story_v_out_319811", "319811037", "story_v_out_319811.awb")

						arg_152_1:RecordAudio("319811037", var_155_7)
						arg_152_1:RecordAudio("319811037", var_155_7)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_319811", "319811037", "story_v_out_319811.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_319811", "319811037", "story_v_out_319811.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_8 = math.max(var_155_1, arg_152_1.talkMaxDuration)

			if var_155_0 <= arg_152_1.time_ and arg_152_1.time_ < var_155_0 + var_155_8 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_0) / var_155_8

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_0 + var_155_8 and arg_152_1.time_ < var_155_0 + var_155_8 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play319811038 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 319811038
		arg_156_1.duration_ = 8.67

		local var_156_0 = {
			zh = 6.5,
			ja = 8.666
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
				arg_156_0:Play319811039(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = 0.825

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				arg_156_1.leftNameTxt_.text = arg_156_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_1 = arg_156_1:GetWordFromCfg(319811038)
				local var_159_2 = arg_156_1:FormatText(var_159_1.content)

				arg_156_1.text_.text = var_159_2

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_4 = 33 <= 0 and var_159_0 or var_159_0 * (utf8.len(var_159_2) / 33)

				if (33 <= 0 and var_159_0 or var_159_0 * (utf8.len(var_159_2) / 33)) > 0 and var_159_0 < var_159_4 then
					arg_156_1.talkMaxDuration = var_159_4

					if var_159_4 + 0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_4 + 0
					end
				end

				arg_156_1.text_.text = var_159_2
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811038", "story_v_out_319811.awb") ~= 0 then
					local var_159_5 = manager.audio:GetVoiceLength("story_v_out_319811", "319811038", "story_v_out_319811.awb") / 1000

					if var_159_5 + 0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_5 + 0
					end

					if var_159_1.prefab_name ~= "" and arg_156_1.actors_[var_159_1.prefab_name] ~= nil then
						local var_159_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_1.prefab_name].transform, "story_v_out_319811", "319811038", "story_v_out_319811.awb")

						arg_156_1:RecordAudio("319811038", var_159_6)
						arg_156_1:RecordAudio("319811038", var_159_6)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_319811", "319811038", "story_v_out_319811.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_319811", "319811038", "story_v_out_319811.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_7 = math.max(var_159_0, arg_156_1.talkMaxDuration)

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_7 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - 0) / var_159_7

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= 0 + var_159_7 and arg_156_1.time_ < 0 + var_159_7 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play319811039 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 319811039
		arg_160_1.duration_ = 4.87

		local var_160_0 = {
			zh = 3.533,
			ja = 4.866
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
				arg_160_0:Play319811040(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1.var_.moveOldPos1084ui_story = arg_160_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_163_0 = 0.001

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_0 then
				arg_160_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_160_1.time_ - 0) / var_163_0)
				arg_160_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_160_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_160_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_160_1.actors_["1084ui_story"].transform.position).z)
				arg_160_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_160_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_160_1.actors_["1084ui_story"].transform.localEulerAngles = arg_160_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_160_1.time_ >= 0 + var_163_0 and arg_160_1.time_ < 0 + var_163_0 + arg_163_0 then
				arg_160_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_160_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_160_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_160_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_160_1.actors_["1084ui_story"].transform.position).z)
				arg_160_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_160_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_160_1.actors_["1084ui_story"].transform.localEulerAngles = arg_160_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_163_1 = 0
			local var_163_2 = 0.525

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				arg_160_1.leftNameTxt_.text = arg_160_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_3 = arg_160_1:GetWordFromCfg(319811039)
				local var_163_4 = arg_160_1:FormatText(var_163_3.content)

				arg_160_1.text_.text = var_163_4

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_6 = 21 <= 0 and var_163_2 or var_163_2 * (utf8.len(var_163_4) / 21)

				if (21 <= 0 and var_163_2 or var_163_2 * (utf8.len(var_163_4) / 21)) > 0 and var_163_2 < var_163_6 then
					arg_160_1.talkMaxDuration = var_163_6

					if var_163_6 + var_163_1 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_6 + var_163_1
					end
				end

				arg_160_1.text_.text = var_163_4
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811039", "story_v_out_319811.awb") ~= 0 then
					local var_163_7 = manager.audio:GetVoiceLength("story_v_out_319811", "319811039", "story_v_out_319811.awb") / 1000

					if var_163_7 + var_163_1 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_7 + var_163_1
					end

					if var_163_3.prefab_name ~= "" and arg_160_1.actors_[var_163_3.prefab_name] ~= nil then
						local var_163_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_3.prefab_name].transform, "story_v_out_319811", "319811039", "story_v_out_319811.awb")

						arg_160_1:RecordAudio("319811039", var_163_8)
						arg_160_1:RecordAudio("319811039", var_163_8)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_319811", "319811039", "story_v_out_319811.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_319811", "319811039", "story_v_out_319811.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_9 = math.max(var_163_2, arg_160_1.talkMaxDuration)

			if var_163_1 <= arg_160_1.time_ and arg_160_1.time_ < var_163_1 + var_163_9 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_1) / var_163_9

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_1 + var_163_9 and arg_160_1.time_ < var_163_1 + var_163_9 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {
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

		arg_160_1:InitPlayNodeList()
	end,
	Play319811040 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 319811040
		arg_164_1.duration_ = 5

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play319811041(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 and not isNil(arg_164_1.actors_["1084ui_story"]) and arg_164_1.var_.characterEffect1084ui_story == nil then
				arg_164_1.var_.characterEffect1084ui_story = arg_164_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_0 = 0.200000002980232

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_0 and not isNil(arg_164_1.actors_["1084ui_story"]) then
				if arg_164_1.var_.characterEffect1084ui_story and not isNil(arg_164_1.actors_["1084ui_story"]) then
					arg_164_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_164_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_164_1.time_ - 0) / var_167_0)
				end
			end

			if arg_164_1.time_ >= 0 + var_167_0 and arg_164_1.time_ < 0 + var_167_0 + arg_167_0 and not isNil(arg_164_1.actors_["1084ui_story"]) and arg_164_1.var_.characterEffect1084ui_story then
				arg_164_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_164_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_167_1 = 0
			local var_167_2 = 1.05

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_1 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, false)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_3 = arg_164_1:FormatText(arg_164_1:GetWordFromCfg(319811040).content)

				arg_164_1.text_.text = var_167_3

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_5 = 42 <= 0 and var_167_2 or var_167_2 * (utf8.len(var_167_3) / 42)

				if (42 <= 0 and var_167_2 or var_167_2 * (utf8.len(var_167_3) / 42)) > 0 and var_167_2 < var_167_5 then
					arg_164_1.talkMaxDuration = var_167_5

					if var_167_5 + var_167_1 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_5 + var_167_1
					end
				end

				arg_164_1.text_.text = var_167_3
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)
				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_6 = math.max(var_167_2, arg_164_1.talkMaxDuration)

			if var_167_1 <= arg_164_1.time_ and arg_164_1.time_ < var_167_1 + var_167_6 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_1) / var_167_6

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_1 + var_167_6 and arg_164_1.time_ < var_167_1 + var_167_6 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play319811041 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 319811041
		arg_168_1.duration_ = 10.33

		local var_168_0 = {
			zh = 5.5,
			ja = 10.333
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
				arg_168_0:Play319811042(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1.var_.moveOldPos10058ui_story = arg_168_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_171_0 = 0.001

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_0 then
				arg_168_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos10058ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_168_1.time_ - 0) / var_171_0)
				arg_168_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_168_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_168_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_168_1.actors_["10058ui_story"].transform.position).z)
				arg_168_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_168_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_168_1.actors_["10058ui_story"].transform.localEulerAngles = arg_168_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_168_1.time_ >= 0 + var_171_0 and arg_168_1.time_ < 0 + var_171_0 + arg_171_0 then
				arg_168_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0.7, -0.98, -6.1)
				arg_168_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_168_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_168_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_168_1.actors_["10058ui_story"].transform.position).z)
				arg_168_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_168_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_168_1.actors_["10058ui_story"].transform.localEulerAngles = arg_168_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_171_1 = arg_168_1.actors_["10058ui_story"]

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 and not isNil(var_171_1) and arg_168_1.var_.characterEffect10058ui_story == nil then
				arg_168_1.var_.characterEffect10058ui_story = var_171_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_2 = 0.200000002980232

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_2 and not isNil(var_171_1) then
				if arg_168_1.var_.characterEffect10058ui_story and not isNil(var_171_1) then
					arg_168_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_168_1.time_ >= 0 + var_171_2 and arg_168_1.time_ < 0 + var_171_2 + arg_171_0 and not isNil(var_171_1) and arg_168_1.var_.characterEffect10058ui_story then
				arg_168_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_171_4 = arg_168_1.actors_["1084ui_story"].transform

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1.var_.moveOldPos1084ui_story = var_171_4.localPosition
			end

			local var_171_5 = 0.001

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_5 then
				var_171_4.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_168_1.time_ - 0) / var_171_5)
				var_171_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_171_4.position).x, (manager.ui.mainCamera.transform.position - var_171_4.position).y, (manager.ui.mainCamera.transform.position - var_171_4.position).z)
				var_171_4.localEulerAngles.z = 0
				var_171_4.localEulerAngles.x = 0
				var_171_4.localEulerAngles = var_171_4.localEulerAngles
			end

			if arg_168_1.time_ >= 0 + var_171_5 and arg_168_1.time_ < 0 + var_171_5 + arg_171_0 then
				var_171_4.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_171_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_171_4.position).x, (manager.ui.mainCamera.transform.position - var_171_4.position).y, (manager.ui.mainCamera.transform.position - var_171_4.position).z)
				var_171_4.localEulerAngles.z = 0
				var_171_4.localEulerAngles.x = 0
				var_171_4.localEulerAngles = var_171_4.localEulerAngles
			end

			local var_171_6 = 0
			local var_171_7 = 0.6

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_6 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				arg_168_1.leftNameTxt_.text = arg_168_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_8 = arg_168_1:GetWordFromCfg(319811041)
				local var_171_9 = arg_168_1:FormatText(var_171_8.content)

				arg_168_1.text_.text = var_171_9

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_11 = 24 <= 0 and var_171_7 or var_171_7 * (utf8.len(var_171_9) / 24)

				if (24 <= 0 and var_171_7 or var_171_7 * (utf8.len(var_171_9) / 24)) > 0 and var_171_7 < var_171_11 then
					arg_168_1.talkMaxDuration = var_171_11

					if var_171_11 + var_171_6 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_11 + var_171_6
					end
				end

				arg_168_1.text_.text = var_171_9
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811041", "story_v_out_319811.awb") ~= 0 then
					local var_171_12 = manager.audio:GetVoiceLength("story_v_out_319811", "319811041", "story_v_out_319811.awb") / 1000

					if var_171_12 + var_171_6 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_12 + var_171_6
					end

					if var_171_8.prefab_name ~= "" and arg_168_1.actors_[var_171_8.prefab_name] ~= nil then
						local var_171_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_8.prefab_name].transform, "story_v_out_319811", "319811041", "story_v_out_319811.awb")

						arg_168_1:RecordAudio("319811041", var_171_13)
						arg_168_1:RecordAudio("319811041", var_171_13)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_319811", "319811041", "story_v_out_319811.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_319811", "319811041", "story_v_out_319811.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_14 = math.max(var_171_7, arg_168_1.talkMaxDuration)

			if var_171_6 <= arg_168_1.time_ and arg_168_1.time_ < var_171_6 + var_171_14 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_6) / var_171_14

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_6 + var_171_14 and arg_168_1.time_ < var_171_6 + var_171_14 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {
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

		arg_168_1:InitPlayNodeList()
	end,
	Play319811042 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 319811042
		arg_172_1.duration_ = 2.33

		local var_172_0 = {
			zh = 2.333,
			ja = 1.999999999999
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
				arg_172_0:Play319811043(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 and not isNil(arg_172_1.actors_["10058ui_story"]) and arg_172_1.var_.characterEffect10058ui_story == nil then
				arg_172_1.var_.characterEffect10058ui_story = arg_172_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_0 = 0.200000002980232

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_0 and not isNil(arg_172_1.actors_["10058ui_story"]) then
				if arg_172_1.var_.characterEffect10058ui_story and not isNil(arg_172_1.actors_["10058ui_story"]) then
					arg_172_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_172_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_172_1.time_ - 0) / var_175_0)
				end
			end

			if arg_172_1.time_ >= 0 + var_175_0 and arg_172_1.time_ < 0 + var_175_0 + arg_175_0 and not isNil(arg_172_1.actors_["10058ui_story"]) and arg_172_1.var_.characterEffect10058ui_story then
				arg_172_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_172_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_175_1 = arg_172_1.actors_["1084ui_story"]

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 and not isNil(var_175_1) and arg_172_1.var_.characterEffect1084ui_story == nil then
				arg_172_1.var_.characterEffect1084ui_story = var_175_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_2 = 0.200000002980232

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_2 and not isNil(var_175_1) then
				if arg_172_1.var_.characterEffect1084ui_story and not isNil(var_175_1) then
					arg_172_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_172_1.time_ >= 0 + var_175_2 and arg_172_1.time_ < 0 + var_175_2 + arg_175_0 and not isNil(var_175_1) and arg_172_1.var_.characterEffect1084ui_story then
				arg_172_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_175_4 = 0
			local var_175_5 = 0.225

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_4 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				arg_172_1.leftNameTxt_.text = arg_172_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_6 = arg_172_1:GetWordFromCfg(319811042)
				local var_175_7 = arg_172_1:FormatText(var_175_6.content)

				arg_172_1.text_.text = var_175_7

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_9 = 9 <= 0 and var_175_5 or var_175_5 * (utf8.len(var_175_7) / 9)

				if (9 <= 0 and var_175_5 or var_175_5 * (utf8.len(var_175_7) / 9)) > 0 and var_175_5 < var_175_9 then
					arg_172_1.talkMaxDuration = var_175_9

					if var_175_9 + var_175_4 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_9 + var_175_4
					end
				end

				arg_172_1.text_.text = var_175_7
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811042", "story_v_out_319811.awb") ~= 0 then
					local var_175_10 = manager.audio:GetVoiceLength("story_v_out_319811", "319811042", "story_v_out_319811.awb") / 1000

					if var_175_10 + var_175_4 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_10 + var_175_4
					end

					if var_175_6.prefab_name ~= "" and arg_172_1.actors_[var_175_6.prefab_name] ~= nil then
						local var_175_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_6.prefab_name].transform, "story_v_out_319811", "319811042", "story_v_out_319811.awb")

						arg_172_1:RecordAudio("319811042", var_175_11)
						arg_172_1:RecordAudio("319811042", var_175_11)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_319811", "319811042", "story_v_out_319811.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_319811", "319811042", "story_v_out_319811.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_12 = math.max(var_175_5, arg_172_1.talkMaxDuration)

			if var_175_4 <= arg_172_1.time_ and arg_172_1.time_ < var_175_4 + var_175_12 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_4) / var_175_12

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_4 + var_175_12 and arg_172_1.time_ < var_175_4 + var_175_12 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play319811043 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 319811043
		arg_176_1.duration_ = 6.8

		local var_176_0 = {
			zh = 6.466,
			ja = 6.8
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
				arg_176_0:Play319811044(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 and not isNil(arg_176_1.actors_["10058ui_story"]) and arg_176_1.var_.characterEffect10058ui_story == nil then
				arg_176_1.var_.characterEffect10058ui_story = arg_176_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_0 = 0.200000002980232

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_0 and not isNil(arg_176_1.actors_["10058ui_story"]) then
				if arg_176_1.var_.characterEffect10058ui_story and not isNil(arg_176_1.actors_["10058ui_story"]) then
					arg_176_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_176_1.time_ >= 0 + var_179_0 and arg_176_1.time_ < 0 + var_179_0 + arg_179_0 and not isNil(arg_176_1.actors_["10058ui_story"]) and arg_176_1.var_.characterEffect10058ui_story then
				arg_176_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action7_1")
			end

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_179_2 = arg_176_1.actors_["1084ui_story"].transform

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1.var_.moveOldPos1084ui_story = var_179_2.localPosition
			end

			local var_179_3 = 0.001

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_3 then
				var_179_2.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_176_1.time_ - 0) / var_179_3)
				var_179_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_179_2.position).x, (manager.ui.mainCamera.transform.position - var_179_2.position).y, (manager.ui.mainCamera.transform.position - var_179_2.position).z)
				var_179_2.localEulerAngles.z = 0
				var_179_2.localEulerAngles.x = 0
				var_179_2.localEulerAngles = var_179_2.localEulerAngles
			end

			if arg_176_1.time_ >= 0 + var_179_3 and arg_176_1.time_ < 0 + var_179_3 + arg_179_0 then
				var_179_2.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_179_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_179_2.position).x, (manager.ui.mainCamera.transform.position - var_179_2.position).y, (manager.ui.mainCamera.transform.position - var_179_2.position).z)
				var_179_2.localEulerAngles.z = 0
				var_179_2.localEulerAngles.x = 0
				var_179_2.localEulerAngles = var_179_2.localEulerAngles
			end

			local var_179_4 = arg_176_1.actors_["1084ui_story"]

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 and not isNil(var_179_4) and arg_176_1.var_.characterEffect1084ui_story == nil then
				arg_176_1.var_.characterEffect1084ui_story = var_179_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_5 = 0.200000002980232

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_5 and not isNil(var_179_4) then
				if arg_176_1.var_.characterEffect1084ui_story and not isNil(var_179_4) then
					arg_176_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_176_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_176_1.time_ - 0) / var_179_5)
				end
			end

			if arg_176_1.time_ >= 0 + var_179_5 and arg_176_1.time_ < 0 + var_179_5 + arg_179_0 and not isNil(var_179_4) and arg_176_1.var_.characterEffect1084ui_story then
				arg_176_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_176_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_179_6 = 0
			local var_179_7 = 0.8

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_6 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				arg_176_1.leftNameTxt_.text = arg_176_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_8 = arg_176_1:GetWordFromCfg(319811043)
				local var_179_9 = arg_176_1:FormatText(var_179_8.content)

				arg_176_1.text_.text = var_179_9

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_11 = 32 <= 0 and var_179_7 or var_179_7 * (utf8.len(var_179_9) / 32)

				if (32 <= 0 and var_179_7 or var_179_7 * (utf8.len(var_179_9) / 32)) > 0 and var_179_7 < var_179_11 then
					arg_176_1.talkMaxDuration = var_179_11

					if var_179_11 + var_179_6 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_11 + var_179_6
					end
				end

				arg_176_1.text_.text = var_179_9
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811043", "story_v_out_319811.awb") ~= 0 then
					local var_179_12 = manager.audio:GetVoiceLength("story_v_out_319811", "319811043", "story_v_out_319811.awb") / 1000

					if var_179_12 + var_179_6 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_12 + var_179_6
					end

					if var_179_8.prefab_name ~= "" and arg_176_1.actors_[var_179_8.prefab_name] ~= nil then
						local var_179_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_8.prefab_name].transform, "story_v_out_319811", "319811043", "story_v_out_319811.awb")

						arg_176_1:RecordAudio("319811043", var_179_13)
						arg_176_1:RecordAudio("319811043", var_179_13)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_319811", "319811043", "story_v_out_319811.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_319811", "319811043", "story_v_out_319811.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_14 = math.max(var_179_7, arg_176_1.talkMaxDuration)

			if var_179_6 <= arg_176_1.time_ and arg_176_1.time_ < var_179_6 + var_179_14 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_6) / var_179_14

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_6 + var_179_14 and arg_176_1.time_ < var_179_6 + var_179_14 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {
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

		arg_176_1:InitPlayNodeList()
	end,
	Play319811044 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 319811044
		arg_180_1.duration_ = 5

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play319811045(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 and not isNil(arg_180_1.actors_["10058ui_story"]) and arg_180_1.var_.characterEffect10058ui_story == nil then
				arg_180_1.var_.characterEffect10058ui_story = arg_180_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_0 = 0.200000002980232

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_0 and not isNil(arg_180_1.actors_["10058ui_story"]) then
				if arg_180_1.var_.characterEffect10058ui_story and not isNil(arg_180_1.actors_["10058ui_story"]) then
					arg_180_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_180_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_180_1.time_ - 0) / var_183_0)
				end
			end

			if arg_180_1.time_ >= 0 + var_183_0 and arg_180_1.time_ < 0 + var_183_0 + arg_183_0 and not isNil(arg_180_1.actors_["10058ui_story"]) and arg_180_1.var_.characterEffect10058ui_story then
				arg_180_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_180_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_183_1 = 0
			local var_183_2 = 0.35

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				arg_180_1.leftNameTxt_.text = arg_180_1:FormatText(StoryNameCfg[698].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, true)
				arg_180_1.iconController_:SetSelectedState("hero")

				arg_180_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_180_1.callingController_:SetSelectedState("normal")

				arg_180_1.keyicon_.color = Color.New(1, 1, 1)
				arg_180_1.icon_.color = Color.New(1, 1, 1)

				local var_183_3 = arg_180_1:FormatText(arg_180_1:GetWordFromCfg(319811044).content)

				arg_180_1.text_.text = var_183_3

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_5 = 14 <= 0 and var_183_2 or var_183_2 * (utf8.len(var_183_3) / 14)

				if (14 <= 0 and var_183_2 or var_183_2 * (utf8.len(var_183_3) / 14)) > 0 and var_183_2 < var_183_5 then
					arg_180_1.talkMaxDuration = var_183_5

					if var_183_5 + var_183_1 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_5 + var_183_1
					end
				end

				arg_180_1.text_.text = var_183_3
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)
				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_6 = math.max(var_183_2, arg_180_1.talkMaxDuration)

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_6 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_1) / var_183_6

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_1 + var_183_6 and arg_180_1.time_ < var_183_1 + var_183_6 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play319811045 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 319811045
		arg_184_1.duration_ = 5.27

		local var_184_0 = {
			zh = 3.7,
			ja = 5.266
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
				arg_184_0:Play319811046(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1.var_.moveOldPos10058ui_story = arg_184_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_187_0 = 0.001

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_0 then
				arg_184_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos10058ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_184_1.time_ - 0) / var_187_0)
				arg_184_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_184_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_184_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_184_1.actors_["10058ui_story"].transform.position).z)
				arg_184_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_184_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_184_1.actors_["10058ui_story"].transform.localEulerAngles = arg_184_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_184_1.time_ >= 0 + var_187_0 and arg_184_1.time_ < 0 + var_187_0 + arg_187_0 then
				arg_184_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0.7, -0.98, -6.1)
				arg_184_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_184_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_184_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_184_1.actors_["10058ui_story"].transform.position).z)
				arg_184_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_184_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_184_1.actors_["10058ui_story"].transform.localEulerAngles = arg_184_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_187_1 = arg_184_1.actors_["10058ui_story"]

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 and not isNil(var_187_1) and arg_184_1.var_.characterEffect10058ui_story == nil then
				arg_184_1.var_.characterEffect10058ui_story = var_187_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_2 = 0.200000002980232

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_2 and not isNil(var_187_1) then
				if arg_184_1.var_.characterEffect10058ui_story and not isNil(var_187_1) then
					arg_184_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_184_1.time_ >= 0 + var_187_2 and arg_184_1.time_ < 0 + var_187_2 + arg_187_0 and not isNil(var_187_1) and arg_184_1.var_.characterEffect10058ui_story then
				arg_184_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action7_2")
			end

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_187_4 = 0
			local var_187_5 = 0.325

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_4 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				arg_184_1.leftNameTxt_.text = arg_184_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_6 = arg_184_1:GetWordFromCfg(319811045)
				local var_187_7 = arg_184_1:FormatText(var_187_6.content)

				arg_184_1.text_.text = var_187_7

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_9 = 13 <= 0 and var_187_5 or var_187_5 * (utf8.len(var_187_7) / 13)

				if (13 <= 0 and var_187_5 or var_187_5 * (utf8.len(var_187_7) / 13)) > 0 and var_187_5 < var_187_9 then
					arg_184_1.talkMaxDuration = var_187_9

					if var_187_9 + var_187_4 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_9 + var_187_4
					end
				end

				arg_184_1.text_.text = var_187_7
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811045", "story_v_out_319811.awb") ~= 0 then
					local var_187_10 = manager.audio:GetVoiceLength("story_v_out_319811", "319811045", "story_v_out_319811.awb") / 1000

					if var_187_10 + var_187_4 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_10 + var_187_4
					end

					if var_187_6.prefab_name ~= "" and arg_184_1.actors_[var_187_6.prefab_name] ~= nil then
						local var_187_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_6.prefab_name].transform, "story_v_out_319811", "319811045", "story_v_out_319811.awb")

						arg_184_1:RecordAudio("319811045", var_187_11)
						arg_184_1:RecordAudio("319811045", var_187_11)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_319811", "319811045", "story_v_out_319811.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_319811", "319811045", "story_v_out_319811.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_12 = math.max(var_187_5, arg_184_1.talkMaxDuration)

			if var_187_4 <= arg_184_1.time_ and arg_184_1.time_ < var_187_4 + var_187_12 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_4) / var_187_12

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_4 + var_187_12 and arg_184_1.time_ < var_187_4 + var_187_12 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {
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

		arg_184_1:InitPlayNodeList()
	end,
	Play319811046 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 319811046
		arg_188_1.duration_ = 5

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play319811047(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 and not isNil(arg_188_1.actors_["10058ui_story"]) and arg_188_1.var_.characterEffect10058ui_story == nil then
				arg_188_1.var_.characterEffect10058ui_story = arg_188_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_0 = 0.200000002980232

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_0 and not isNil(arg_188_1.actors_["10058ui_story"]) then
				if arg_188_1.var_.characterEffect10058ui_story and not isNil(arg_188_1.actors_["10058ui_story"]) then
					arg_188_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_188_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_188_1.time_ - 0) / var_191_0)
				end
			end

			if arg_188_1.time_ >= 0 + var_191_0 and arg_188_1.time_ < 0 + var_191_0 + arg_191_0 and not isNil(arg_188_1.actors_["10058ui_story"]) and arg_188_1.var_.characterEffect10058ui_story then
				arg_188_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_188_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_191_1 = 0
			local var_191_2 = 0.25

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_1 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				arg_188_1.leftNameTxt_.text = arg_188_1:FormatText(StoryNameCfg[698].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, true)
				arg_188_1.iconController_:SetSelectedState("hero")

				arg_188_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_188_1.callingController_:SetSelectedState("normal")

				arg_188_1.keyicon_.color = Color.New(1, 1, 1)
				arg_188_1.icon_.color = Color.New(1, 1, 1)

				local var_191_3 = arg_188_1:FormatText(arg_188_1:GetWordFromCfg(319811046).content)

				arg_188_1.text_.text = var_191_3

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_5 = 10 <= 0 and var_191_2 or var_191_2 * (utf8.len(var_191_3) / 10)

				if (10 <= 0 and var_191_2 or var_191_2 * (utf8.len(var_191_3) / 10)) > 0 and var_191_2 < var_191_5 then
					arg_188_1.talkMaxDuration = var_191_5

					if var_191_5 + var_191_1 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_5 + var_191_1
					end
				end

				arg_188_1.text_.text = var_191_3
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)
				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_6 = math.max(var_191_2, arg_188_1.talkMaxDuration)

			if var_191_1 <= arg_188_1.time_ and arg_188_1.time_ < var_191_1 + var_191_6 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_1) / var_191_6

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_1 + var_191_6 and arg_188_1.time_ < var_191_1 + var_191_6 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play319811047 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 319811047
		arg_192_1.duration_ = 5.9

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play319811048(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1.var_.moveOldPos10058ui_story = arg_192_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_195_0 = 0.001

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_0 then
				arg_192_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_192_1.time_ - 0) / var_195_0)
				arg_192_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_192_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_192_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_192_1.actors_["10058ui_story"].transform.position).z)
				arg_192_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_192_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_192_1.actors_["10058ui_story"].transform.localEulerAngles = arg_192_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_192_1.time_ >= 0 + var_195_0 and arg_192_1.time_ < 0 + var_195_0 + arg_195_0 then
				arg_192_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_192_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_192_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_192_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_192_1.actors_["10058ui_story"].transform.position).z)
				arg_192_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_192_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_192_1.actors_["10058ui_story"].transform.localEulerAngles = arg_192_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_195_1 = arg_192_1.actors_["1084ui_story"].transform

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1.var_.moveOldPos1084ui_story = var_195_1.localPosition
			end

			local var_195_2 = 0.001

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_2 then
				var_195_1.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_192_1.time_ - 0) / var_195_2)
				var_195_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_195_1.position).x, (manager.ui.mainCamera.transform.position - var_195_1.position).y, (manager.ui.mainCamera.transform.position - var_195_1.position).z)
				var_195_1.localEulerAngles.z = 0
				var_195_1.localEulerAngles.x = 0
				var_195_1.localEulerAngles = var_195_1.localEulerAngles
			end

			if arg_192_1.time_ >= 0 + var_195_2 and arg_192_1.time_ < 0 + var_195_2 + arg_195_0 then
				var_195_1.localPosition = Vector3.New(0, 100, 0)
				var_195_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_195_1.position).x, (manager.ui.mainCamera.transform.position - var_195_1.position).y, (manager.ui.mainCamera.transform.position - var_195_1.position).z)
				var_195_1.localEulerAngles.z = 0
				var_195_1.localEulerAngles.x = 0
				var_195_1.localEulerAngles = var_195_1.localEulerAngles
			end

			local var_195_3 = 0

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_3 + arg_195_0 then
				arg_192_1.mask_.enabled = true
				arg_192_1.mask_.raycastTarget = false

				arg_192_1:SetGaussion(false)
			end

			local var_195_4 = 0.666666666666667

			if var_195_3 <= arg_192_1.time_ and arg_192_1.time_ < var_195_3 + var_195_4 then
				local var_195_5 = Color.New(1, 1, 1)

				var_195_5.a = Mathf.Lerp(1, 0, (arg_192_1.time_ - var_195_3) / var_195_4)
				arg_192_1.mask_.color = var_195_5
			end

			if arg_192_1.time_ >= var_195_3 + var_195_4 and arg_192_1.time_ < var_195_3 + var_195_4 + arg_195_0 then
				local var_195_6 = Color.New(1, 1, 1)

				arg_192_1.mask_.enabled = false
				var_195_6.a = 0
				arg_192_1.mask_.color = var_195_6
			end

			if arg_192_1.frameCnt_ <= 1 then
				arg_192_1.dialog_:SetActive(false)
			end

			local var_195_7 = 0.9
			local var_195_8 = 1.05

			if 0.9 < arg_192_1.time_ and arg_192_1.time_ <= var_195_7 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0

				arg_192_1.dialog_:SetActive(true)

				arg_192_1.dialogCg_.alpha = 0

				local var_195_9 = LeanTween.value(arg_192_1.dialog_, 0, 1, 0.3)

				var_195_9:setOnUpdate(LuaHelper.FloatAction(function(arg_196_0)
					arg_192_1.dialogCg_.alpha = arg_196_0
				end))
				var_195_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_192_1.dialog_)
					var_195_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_192_1.duration_ = arg_192_1.duration_ + 0.3

				SetActive(arg_192_1.leftNameGo_, false)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_10 = arg_192_1:FormatText(arg_192_1:GetWordFromCfg(319811047).content)

				arg_192_1.text_.text = var_195_10

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_12 = 42 <= 0 and var_195_8 or var_195_8 * (utf8.len(var_195_10) / 42)

				if (42 <= 0 and var_195_8 or var_195_8 * (utf8.len(var_195_10) / 42)) > 0 and var_195_8 < var_195_12 then
					arg_192_1.talkMaxDuration = var_195_12
					var_195_7 = var_195_7 + 0.3

					if var_195_12 + var_195_7 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_12 + var_195_7
					end
				end

				arg_192_1.text_.text = var_195_10
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)
				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_13 = var_195_7 + 0.3
			local var_195_14 = math.max(var_195_8, arg_192_1.talkMaxDuration)

			if var_195_7 + 0.3 <= arg_192_1.time_ and arg_192_1.time_ < var_195_13 + var_195_14 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_13) / var_195_14

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_13 + var_195_14 and arg_192_1.time_ < var_195_13 + var_195_14 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {
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

		arg_192_1:InitPlayNodeList()
	end,
	Play319811048 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 319811048
		arg_198_1.duration_ = 2.17

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play319811049(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				local var_201_0 = arg_198_1.fswbg_.transform:Find("textbox/adapt/content") or arg_198_1.fswbg_.transform:Find("textbox/content")
				local var_201_1 = arg_198_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_201_2 = var_201_0:GetComponent("RectTransform")

				var_201_0:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_201_2.offsetMin = Vector2.New(0, 0)
				var_201_2.offsetMax = Vector2.New(0, 0)
			end

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1.fswbg_:SetActive(true)
				arg_198_1.dialog_:SetActive(false)

				arg_198_1.fswtw_.percent = 0
				arg_198_1.fswt_.text = arg_198_1:FormatText(arg_198_1:GetWordFromCfg(319811048).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.fswt_)

				arg_198_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_198_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_198_1.fswtw_:SetDirty()

				arg_198_1.typewritterCharCountI18N = 0

				SetActive(arg_198_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_198_1:ShowNextGo(false)
			end

			local var_201_3 = 0.733333333333333

			if 0.733333333333333 < arg_198_1.time_ and arg_198_1.time_ <= var_201_3 + arg_201_0 then
				arg_198_1.var_.oldValueTypewriter = arg_198_1.fswtw_.percent

				SetActive(arg_198_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_198_1:ShowNextGo(false)
			end

			local var_201_4 = 4
			local var_201_5 = 0.266666666666667
			local var_201_6, var_201_7 = arg_198_1:GetPercentByPara(arg_198_1:FormatText(arg_198_1:GetWordFromCfg(319811048).content), 1)

			if var_201_3 < arg_198_1.time_ and arg_198_1.time_ <= var_201_3 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0

				local var_201_8 = var_201_4 <= 0 and var_201_5 or var_201_5 * ((var_201_7 - arg_198_1.typewritterCharCountI18N) / var_201_4)

				if (var_201_4 <= 0 and var_201_5 or var_201_5 * ((var_201_7 - arg_198_1.typewritterCharCountI18N) / var_201_4)) > 0 and var_201_5 < var_201_8 then
					arg_198_1.talkMaxDuration = var_201_8

					if var_201_8 + var_201_3 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_8 + var_201_3
					end
				end
			end

			local var_201_9 = math.max(0.266666666666667, arg_198_1.talkMaxDuration)

			if var_201_3 <= arg_198_1.time_ and arg_198_1.time_ < var_201_3 + var_201_9 then
				arg_198_1.fswtw_.percent = Mathf.Lerp(arg_198_1.var_.oldValueTypewriter, var_201_6, (arg_198_1.time_ - var_201_3) / var_201_9)
				arg_198_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_198_1.fswtw_:SetDirty()
			end

			if arg_198_1.time_ >= var_201_3 + var_201_9 and arg_198_1.time_ < var_201_3 + var_201_9 + arg_201_0 then
				arg_198_1.fswtw_.percent = var_201_6

				arg_198_1.fswtw_:SetDirty()
				arg_198_1:ShowNextGo(true)

				arg_198_1.typewritterCharCountI18N = var_201_7
			end

			local var_201_10 = "STblack"

			if arg_198_1.bgs_.STblack == nil then
				local var_201_11 = Object.Instantiate(arg_198_1.paintGo_)

				var_201_11:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_201_10)
				var_201_11.name = var_201_10
				var_201_11.transform.parent = arg_198_1.stage_.transform
				var_201_11.transform.localPosition = Vector3.New(0, 100, 0)
				arg_198_1.bgs_[var_201_10] = var_201_11
			end

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				local var_201_12 = arg_198_1.bgs_.STblack

				arg_198_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_201_12.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_201_13 = var_201_12:GetComponent("SpriteRenderer")

				if var_201_13 and var_201_13.sprite then
					local var_201_14 = 2 * (var_201_12.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_201_12.transform.localScale = Vector3.New(var_201_14 / var_201_13.sprite.bounds.size.y < var_201_14 * manager.ui.mainCameraCom_.aspect / var_201_13.sprite.bounds.size.x and var_201_14 * manager.ui.mainCameraCom_.aspect / var_201_13.sprite.bounds.size.x or var_201_14 / var_201_13.sprite.bounds.size.y, var_201_14 / var_201_13.sprite.bounds.size.y < var_201_14 * manager.ui.mainCameraCom_.aspect / var_201_13.sprite.bounds.size.x and var_201_14 * manager.ui.mainCameraCom_.aspect / var_201_13.sprite.bounds.size.x or var_201_14 / var_201_13.sprite.bounds.size.y, 0)
				end

				for iter_201_0, iter_201_1 in pairs(arg_198_1.bgs_) do
					if iter_201_0 ~= "STblack" then
						iter_201_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_201_15 = 0.733333333333333
			local var_201_16 = manager.audio:GetVoiceLength("story_v_out_319811", "319811048", "story_v_out_319811.awb") / 1000

			if var_201_16 > 0 and 1.433 < var_201_16 and var_201_16 + var_201_15 > arg_198_1.duration_ then
				arg_198_1.duration_ = var_201_16 + var_201_15
			end

			if var_201_15 < arg_198_1.time_ and arg_198_1.time_ <= var_201_15 + arg_201_0 then
				arg_198_1:AudioAction("play", "voice", "story_v_out_319811", "319811048", "story_v_out_319811.awb")
			end

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1.cswbg_:SetActive(true)

				local var_201_18 = arg_198_1.cswt_:GetComponent("RectTransform")

				arg_198_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_201_18.offsetMin = Vector2.New(410, 330)
				var_201_18.offsetMax = Vector2.New(-400, -180)
				arg_198_1.cswt_.text = arg_198_1:FormatText(arg_198_1:GetWordFromCfg(419056).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.cswt_)

				arg_198_1.cswt_.fontSize = 175
				arg_198_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_198_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_198_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play319811049 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 319811049
		arg_202_1.duration_ = 4.1

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play319811050(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1.fswbg_:SetActive(true)
				arg_202_1.dialog_:SetActive(false)

				arg_202_1.fswtw_.percent = 0
				arg_202_1.fswt_.text = arg_202_1:FormatText(arg_202_1:GetWordFromCfg(319811049).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.fswt_)

				arg_202_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_202_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_202_1.fswtw_:SetDirty()

				arg_202_1.typewritterCharCountI18N = 0

				SetActive(arg_202_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_202_1:ShowNextGo(false)
			end

			local var_205_0 = 0.266666666666667

			if 0.266666666666667 < arg_202_1.time_ and arg_202_1.time_ <= var_205_0 + arg_205_0 then
				arg_202_1.var_.oldValueTypewriter = arg_202_1.fswtw_.percent

				SetActive(arg_202_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_202_1:ShowNextGo(false)
			end

			local var_205_1 = 18
			local var_205_2 = 1.2
			local var_205_3, var_205_4 = arg_202_1:GetPercentByPara(arg_202_1:FormatText(arg_202_1:GetWordFromCfg(319811049).content), 1)

			if var_205_0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_0 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0

				local var_205_5 = var_205_1 <= 0 and var_205_2 or var_205_2 * ((var_205_4 - arg_202_1.typewritterCharCountI18N) / var_205_1)

				if (var_205_1 <= 0 and var_205_2 or var_205_2 * ((var_205_4 - arg_202_1.typewritterCharCountI18N) / var_205_1)) > 0 and var_205_2 < var_205_5 then
					arg_202_1.talkMaxDuration = var_205_5

					if var_205_5 + var_205_0 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_5 + var_205_0
					end
				end
			end

			local var_205_6 = math.max(1.2, arg_202_1.talkMaxDuration)

			if var_205_0 <= arg_202_1.time_ and arg_202_1.time_ < var_205_0 + var_205_6 then
				arg_202_1.fswtw_.percent = Mathf.Lerp(arg_202_1.var_.oldValueTypewriter, var_205_3, (arg_202_1.time_ - var_205_0) / var_205_6)
				arg_202_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_202_1.fswtw_:SetDirty()
			end

			if arg_202_1.time_ >= var_205_0 + var_205_6 and arg_202_1.time_ < var_205_0 + var_205_6 + arg_205_0 then
				arg_202_1.fswtw_.percent = var_205_3

				arg_202_1.fswtw_:SetDirty()
				arg_202_1:ShowNextGo(true)

				arg_202_1.typewritterCharCountI18N = var_205_4
			end

			local var_205_7 = 0.266666666666667
			local var_205_8 = manager.audio:GetVoiceLength("story_v_out_319811", "319811049", "story_v_out_319811.awb") / 1000

			if var_205_8 > 0 and 3.833 < var_205_8 and var_205_8 + var_205_7 > arg_202_1.duration_ then
				arg_202_1.duration_ = var_205_8 + var_205_7
			end

			if var_205_7 < arg_202_1.time_ and arg_202_1.time_ <= var_205_7 + arg_205_0 then
				arg_202_1:AudioAction("play", "voice", "story_v_out_319811", "319811049", "story_v_out_319811.awb")
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play319811050 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 319811050
		arg_206_1.duration_ = 6.23

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play319811051(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				local var_209_0 = arg_206_1.bgs_.ST72a

				arg_206_1.bgs_.ST72a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_209_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_209_1 = var_209_0:GetComponent("SpriteRenderer")

				if var_209_1 and var_209_1.sprite then
					local var_209_2 = 2 * (var_209_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_209_0.transform.localScale = Vector3.New(var_209_2 / var_209_1.sprite.bounds.size.y < var_209_2 * manager.ui.mainCameraCom_.aspect / var_209_1.sprite.bounds.size.x and var_209_2 * manager.ui.mainCameraCom_.aspect / var_209_1.sprite.bounds.size.x or var_209_2 / var_209_1.sprite.bounds.size.y, var_209_2 / var_209_1.sprite.bounds.size.y < var_209_2 * manager.ui.mainCameraCom_.aspect / var_209_1.sprite.bounds.size.x and var_209_2 * manager.ui.mainCameraCom_.aspect / var_209_1.sprite.bounds.size.x or var_209_2 / var_209_1.sprite.bounds.size.y, 0)
				end

				for iter_209_0, iter_209_1 in pairs(arg_206_1.bgs_) do
					if iter_209_0 ~= "ST72a" then
						iter_209_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_209_3 = 0

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_3 + arg_209_0 then
				arg_206_1.allBtn_.enabled = false
			end

			if arg_206_1.time_ >= var_209_3 + 0.3 and arg_206_1.time_ < var_209_3 + 0.3 + arg_209_0 then
				arg_206_1.allBtn_.enabled = true
			end

			local var_209_4 = 0

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_4 + arg_209_0 then
				arg_206_1.mask_.enabled = true
				arg_206_1.mask_.raycastTarget = true

				arg_206_1:SetGaussion(false)
			end

			local var_209_5 = 1.66666666666667

			if var_209_4 <= arg_206_1.time_ and arg_206_1.time_ < var_209_4 + var_209_5 then
				local var_209_6 = Color.New(0, 0, 0)

				var_209_6.a = Mathf.Lerp(1, 0, (arg_206_1.time_ - var_209_4) / var_209_5)
				arg_206_1.mask_.color = var_209_6
			end

			if arg_206_1.time_ >= var_209_4 + var_209_5 and arg_206_1.time_ < var_209_4 + var_209_5 + arg_209_0 then
				local var_209_7 = Color.New(0, 0, 0)

				arg_206_1.mask_.enabled = false
				var_209_7.a = 0
				arg_206_1.mask_.color = var_209_7
			end

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1.fswbg_:SetActive(false)
				arg_206_1.dialog_:SetActive(false)
				SetActive(arg_206_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_206_1:ShowNextGo(false)
			end

			if 0.1 < arg_206_1.time_ and arg_206_1.time_ <= 0.1 + arg_209_0 then
				arg_206_1.fswbg_:SetActive(false)
				arg_206_1.dialog_:SetActive(false)
				SetActive(arg_206_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_206_1:ShowNextGo(false)
			end

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1.cswbg_:SetActive(false)
			end

			if arg_206_1.frameCnt_ <= 1 then
				arg_206_1.dialog_:SetActive(false)
			end

			local var_209_8 = 1.23333333333333
			local var_209_9 = 1.4

			if 1.23333333333333 < arg_206_1.time_ and arg_206_1.time_ <= var_209_8 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0

				arg_206_1.dialog_:SetActive(true)

				arg_206_1.dialogCg_.alpha = 0

				local var_209_10 = LeanTween.value(arg_206_1.dialog_, 0, 1, 0.3)

				var_209_10:setOnUpdate(LuaHelper.FloatAction(function(arg_210_0)
					arg_206_1.dialogCg_.alpha = arg_210_0
				end))
				var_209_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_206_1.dialog_)
					var_209_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_206_1.duration_ = arg_206_1.duration_ + 0.3

				SetActive(arg_206_1.leftNameGo_, false)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_11 = arg_206_1:FormatText(arg_206_1:GetWordFromCfg(319811050).content)

				arg_206_1.text_.text = var_209_11

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_13 = 56 <= 0 and var_209_9 or var_209_9 * (utf8.len(var_209_11) / 56)

				if (56 <= 0 and var_209_9 or var_209_9 * (utf8.len(var_209_11) / 56)) > 0 and var_209_9 < var_209_13 then
					arg_206_1.talkMaxDuration = var_209_13
					var_209_8 = var_209_8 + 0.3

					if var_209_13 + var_209_8 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_13 + var_209_8
					end
				end

				arg_206_1.text_.text = var_209_11
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)
				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_14 = var_209_8 + 0.3
			local var_209_15 = math.max(var_209_9, arg_206_1.talkMaxDuration)

			if var_209_8 + 0.3 <= arg_206_1.time_ and arg_206_1.time_ < var_209_14 + var_209_15 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_14) / var_209_15

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_14 + var_209_15 and arg_206_1.time_ < var_209_14 + var_209_15 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	Play319811051 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 319811051
		arg_212_1.duration_ = 8.17

		local var_212_0 = {
			zh = 7.166,
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
				arg_212_0:Play319811052(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			if arg_212_1.actors_["10037ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10037ui_story"))) then
				local var_215_0 = Object.Instantiate(Asset.Load("Char/" .. "10037ui_story"), arg_212_1.stage_.transform)

				var_215_0.name = "10037ui_story"
				var_215_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_212_1.actors_["10037ui_story"] = var_215_0

				local var_215_1 = var_215_0:GetComponentInChildren(typeof(CharacterEffect))

				var_215_1.enabled = true

				local var_215_2 = GameObjectTools.GetOrAddComponent(var_215_0, typeof(DynamicBoneHelper))

				if var_215_2 then
					var_215_2:EnableDynamicBone(false)
				end

				arg_212_1:ShowWeapon(var_215_1.transform, false)

				arg_212_1.var_["10037ui_story" .. "Animator"] = var_215_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_212_1.var_["10037ui_story" .. "Animator"].applyRootMotion = true
				arg_212_1.var_["10037ui_story" .. "LipSync"] = var_215_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_215_3 = arg_212_1.actors_["10037ui_story"].transform

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1.var_.moveOldPos10037ui_story = var_215_3.localPosition

				arg_212_1:ShowWeapon(arg_212_1.var_["10037ui_story" .. "Animator"].transform, false)
			end

			local var_215_4 = 0.001

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_4 then
				var_215_3.localPosition = Vector3.Lerp(arg_212_1.var_.moveOldPos10037ui_story, Vector3.New(0, -1.13, -6.2), (arg_212_1.time_ - 0) / var_215_4)
				var_215_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_215_3.position).x, (manager.ui.mainCamera.transform.position - var_215_3.position).y, (manager.ui.mainCamera.transform.position - var_215_3.position).z)
				var_215_3.localEulerAngles.z = 0
				var_215_3.localEulerAngles.x = 0
				var_215_3.localEulerAngles = var_215_3.localEulerAngles
			end

			if arg_212_1.time_ >= 0 + var_215_4 and arg_212_1.time_ < 0 + var_215_4 + arg_215_0 then
				var_215_3.localPosition = Vector3.New(0, -1.13, -6.2)
				var_215_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_215_3.position).x, (manager.ui.mainCamera.transform.position - var_215_3.position).y, (manager.ui.mainCamera.transform.position - var_215_3.position).z)
				var_215_3.localEulerAngles.z = 0
				var_215_3.localEulerAngles.x = 0
				var_215_3.localEulerAngles = var_215_3.localEulerAngles
			end

			local var_215_5 = arg_212_1.actors_["10037ui_story"]

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 and not isNil(var_215_5) and arg_212_1.var_.characterEffect10037ui_story == nil then
				arg_212_1.var_.characterEffect10037ui_story = var_215_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_6 = 0.200000002980232

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_6 and not isNil(var_215_5) then
				if arg_212_1.var_.characterEffect10037ui_story and not isNil(var_215_5) then
					arg_212_1.var_.characterEffect10037ui_story.fillFlat = false
				end
			end

			if arg_212_1.time_ >= 0 + var_215_6 and arg_212_1.time_ < 0 + var_215_6 + arg_215_0 and not isNil(var_215_5) and arg_212_1.var_.characterEffect10037ui_story then
				arg_212_1.var_.characterEffect10037ui_story.fillFlat = false
			end

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/story10037/story10037action/10037action1_1")
			end

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_215_8 = 0
			local var_215_9 = 0.625

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_8 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				arg_212_1.leftNameTxt_.text = arg_212_1:FormatText(StoryNameCfg[383].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_10 = arg_212_1:GetWordFromCfg(319811051)
				local var_215_11 = arg_212_1:FormatText(var_215_10.content)

				arg_212_1.text_.text = var_215_11

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_13 = 25 <= 0 and var_215_9 or var_215_9 * (utf8.len(var_215_11) / 25)

				if (25 <= 0 and var_215_9 or var_215_9 * (utf8.len(var_215_11) / 25)) > 0 and var_215_9 < var_215_13 then
					arg_212_1.talkMaxDuration = var_215_13

					if var_215_13 + var_215_8 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_13 + var_215_8
					end
				end

				arg_212_1.text_.text = var_215_11
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811051", "story_v_out_319811.awb") ~= 0 then
					local var_215_14 = manager.audio:GetVoiceLength("story_v_out_319811", "319811051", "story_v_out_319811.awb") / 1000

					if var_215_14 + var_215_8 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_14 + var_215_8
					end

					if var_215_10.prefab_name ~= "" and arg_212_1.actors_[var_215_10.prefab_name] ~= nil then
						local var_215_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_10.prefab_name].transform, "story_v_out_319811", "319811051", "story_v_out_319811.awb")

						arg_212_1:RecordAudio("319811051", var_215_15)
						arg_212_1:RecordAudio("319811051", var_215_15)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_319811", "319811051", "story_v_out_319811.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_319811", "319811051", "story_v_out_319811.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_16 = math.max(var_215_9, arg_212_1.talkMaxDuration)

			if var_215_8 <= arg_212_1.time_ and arg_212_1.time_ < var_215_8 + var_215_16 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_8) / var_215_16

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_8 + var_215_16 and arg_212_1.time_ < var_215_8 + var_215_16 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10037ui_story",
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
	Play319811052 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 319811052
		arg_216_1.duration_ = 3.5

		local var_216_0 = {
			zh = 1.999999999999,
			ja = 3.5
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
				arg_216_0:Play319811053(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1.var_.moveOldPos10058ui_story = arg_216_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_219_0 = 0.001

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_0 then
				arg_216_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_216_1.time_ - 0) / var_219_0)
				arg_216_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_216_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_216_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_216_1.actors_["10058ui_story"].transform.position).z)
				arg_216_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_216_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_216_1.actors_["10058ui_story"].transform.localEulerAngles = arg_216_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_216_1.time_ >= 0 + var_219_0 and arg_216_1.time_ < 0 + var_219_0 + arg_219_0 then
				arg_216_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_216_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_216_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_216_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_216_1.actors_["10058ui_story"].transform.position).z)
				arg_216_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_216_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_216_1.actors_["10058ui_story"].transform.localEulerAngles = arg_216_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_219_1 = arg_216_1.actors_["10058ui_story"]

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 and not isNil(var_219_1) and arg_216_1.var_.characterEffect10058ui_story == nil then
				arg_216_1.var_.characterEffect10058ui_story = var_219_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_2 = 0.200000002980232

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_2 and not isNil(var_219_1) then
				if arg_216_1.var_.characterEffect10058ui_story and not isNil(var_219_1) then
					arg_216_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_216_1.time_ >= 0 + var_219_2 and arg_216_1.time_ < 0 + var_219_2 + arg_219_0 and not isNil(var_219_1) and arg_216_1.var_.characterEffect10058ui_story then
				arg_216_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_219_4 = arg_216_1.actors_["10037ui_story"].transform

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1.var_.moveOldPos10037ui_story = var_219_4.localPosition
			end

			local var_219_5 = 0.001

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_5 then
				var_219_4.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPos10037ui_story, Vector3.New(0, 100, 0), (arg_216_1.time_ - 0) / var_219_5)
				var_219_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_219_4.position).x, (manager.ui.mainCamera.transform.position - var_219_4.position).y, (manager.ui.mainCamera.transform.position - var_219_4.position).z)
				var_219_4.localEulerAngles.z = 0
				var_219_4.localEulerAngles.x = 0
				var_219_4.localEulerAngles = var_219_4.localEulerAngles
			end

			if arg_216_1.time_ >= 0 + var_219_5 and arg_216_1.time_ < 0 + var_219_5 + arg_219_0 then
				var_219_4.localPosition = Vector3.New(0, 100, 0)
				var_219_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_219_4.position).x, (manager.ui.mainCamera.transform.position - var_219_4.position).y, (manager.ui.mainCamera.transform.position - var_219_4.position).z)
				var_219_4.localEulerAngles.z = 0
				var_219_4.localEulerAngles.x = 0
				var_219_4.localEulerAngles = var_219_4.localEulerAngles
			end

			local var_219_6 = arg_216_1.actors_["10037ui_story"]

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 and not isNil(var_219_6) and arg_216_1.var_.characterEffect10037ui_story == nil then
				arg_216_1.var_.characterEffect10037ui_story = var_219_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_7 = 0.200000002980232

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_7 and not isNil(var_219_6) then
				if arg_216_1.var_.characterEffect10037ui_story and not isNil(var_219_6) then
					arg_216_1.var_.characterEffect10037ui_story.fillFlat = true
					arg_216_1.var_.characterEffect10037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_216_1.time_ - 0) / var_219_7)
				end
			end

			if arg_216_1.time_ >= 0 + var_219_7 and arg_216_1.time_ < 0 + var_219_7 + arg_219_0 and not isNil(var_219_6) and arg_216_1.var_.characterEffect10037ui_story then
				arg_216_1.var_.characterEffect10037ui_story.fillFlat = true
				arg_216_1.var_.characterEffect10037ui_story.fillRatio = 0.5
			end

			local var_219_8 = 0
			local var_219_9 = 0.1

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= var_219_8 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				arg_216_1.leftNameTxt_.text = arg_216_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_10 = arg_216_1:GetWordFromCfg(319811052)
				local var_219_11 = arg_216_1:FormatText(var_219_10.content)

				arg_216_1.text_.text = var_219_11

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_13 = 4 <= 0 and var_219_9 or var_219_9 * (utf8.len(var_219_11) / 4)

				if (4 <= 0 and var_219_9 or var_219_9 * (utf8.len(var_219_11) / 4)) > 0 and var_219_9 < var_219_13 then
					arg_216_1.talkMaxDuration = var_219_13

					if var_219_13 + var_219_8 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_13 + var_219_8
					end
				end

				arg_216_1.text_.text = var_219_11
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811052", "story_v_out_319811.awb") ~= 0 then
					local var_219_14 = manager.audio:GetVoiceLength("story_v_out_319811", "319811052", "story_v_out_319811.awb") / 1000

					if var_219_14 + var_219_8 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_14 + var_219_8
					end

					if var_219_10.prefab_name ~= "" and arg_216_1.actors_[var_219_10.prefab_name] ~= nil then
						local var_219_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_10.prefab_name].transform, "story_v_out_319811", "319811052", "story_v_out_319811.awb")

						arg_216_1:RecordAudio("319811052", var_219_15)
						arg_216_1:RecordAudio("319811052", var_219_15)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_319811", "319811052", "story_v_out_319811.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_319811", "319811052", "story_v_out_319811.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_16 = math.max(var_219_9, arg_216_1.talkMaxDuration)

			if var_219_8 <= arg_216_1.time_ and arg_216_1.time_ < var_219_8 + var_219_16 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_8) / var_219_16

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_8 + var_219_16 and arg_216_1.time_ < var_219_8 + var_219_16 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {
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
				actorName = "10037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_216_1:InitPlayNodeList()
	end,
	Play319811053 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 319811053
		arg_220_1.duration_ = 3.67

		local var_220_0 = {
			zh = 3.566,
			ja = 3.666
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
				arg_220_0:Play319811054(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			if arg_220_1.actors_["4037ui_story"] == nil and not isNil((Asset.Load("Char/" .. "4037ui_story"))) then
				local var_223_0 = Object.Instantiate(Asset.Load("Char/" .. "4037ui_story"), arg_220_1.stage_.transform)

				var_223_0.name = "4037ui_story"
				var_223_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_220_1.actors_["4037ui_story"] = var_223_0

				local var_223_1 = var_223_0:GetComponentInChildren(typeof(CharacterEffect))

				var_223_1.enabled = true

				local var_223_2 = GameObjectTools.GetOrAddComponent(var_223_0, typeof(DynamicBoneHelper))

				if var_223_2 then
					var_223_2:EnableDynamicBone(false)
				end

				arg_220_1:ShowWeapon(var_223_1.transform, false)

				arg_220_1.var_["4037ui_story" .. "Animator"] = var_223_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_220_1.var_["4037ui_story" .. "Animator"].applyRootMotion = true
				arg_220_1.var_["4037ui_story" .. "LipSync"] = var_223_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_223_3 = arg_220_1.actors_["4037ui_story"].transform

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1.var_.moveOldPos4037ui_story = var_223_3.localPosition
			end

			local var_223_4 = 0.001

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_4 then
				var_223_3.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos4037ui_story, Vector3.New(0.7, -1.12, -6.2), (arg_220_1.time_ - 0) / var_223_4)
				var_223_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_223_3.position).x, (manager.ui.mainCamera.transform.position - var_223_3.position).y, (manager.ui.mainCamera.transform.position - var_223_3.position).z)
				var_223_3.localEulerAngles.z = 0
				var_223_3.localEulerAngles.x = 0
				var_223_3.localEulerAngles = var_223_3.localEulerAngles
			end

			if arg_220_1.time_ >= 0 + var_223_4 and arg_220_1.time_ < 0 + var_223_4 + arg_223_0 then
				var_223_3.localPosition = Vector3.New(0.7, -1.12, -6.2)
				var_223_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_223_3.position).x, (manager.ui.mainCamera.transform.position - var_223_3.position).y, (manager.ui.mainCamera.transform.position - var_223_3.position).z)
				var_223_3.localEulerAngles.z = 0
				var_223_3.localEulerAngles.x = 0
				var_223_3.localEulerAngles = var_223_3.localEulerAngles
			end

			local var_223_5 = arg_220_1.actors_["4037ui_story"]

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 and not isNil(var_223_5) and arg_220_1.var_.characterEffect4037ui_story == nil then
				arg_220_1.var_.characterEffect4037ui_story = var_223_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_6 = 0.200000002980232

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_6 and not isNil(var_223_5) then
				if arg_220_1.var_.characterEffect4037ui_story and not isNil(var_223_5) then
					arg_220_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_220_1.time_ >= 0 + var_223_6 and arg_220_1.time_ < 0 + var_223_6 + arg_223_0 and not isNil(var_223_5) and arg_220_1.var_.characterEffect4037ui_story then
				arg_220_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action2_1")
			end

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_223_8 = arg_220_1.actors_["10058ui_story"].transform

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1.var_.moveOldPos10058ui_story = var_223_8.localPosition
			end

			local var_223_9 = 0.001

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_9 then
				var_223_8.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos10058ui_story, Vector3.New(-0.7, -0.98, -6.1), (arg_220_1.time_ - 0) / var_223_9)
				var_223_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_223_8.position).x, (manager.ui.mainCamera.transform.position - var_223_8.position).y, (manager.ui.mainCamera.transform.position - var_223_8.position).z)
				var_223_8.localEulerAngles.z = 0
				var_223_8.localEulerAngles.x = 0
				var_223_8.localEulerAngles = var_223_8.localEulerAngles
			end

			if arg_220_1.time_ >= 0 + var_223_9 and arg_220_1.time_ < 0 + var_223_9 + arg_223_0 then
				var_223_8.localPosition = Vector3.New(-0.7, -0.98, -6.1)
				var_223_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_223_8.position).x, (manager.ui.mainCamera.transform.position - var_223_8.position).y, (manager.ui.mainCamera.transform.position - var_223_8.position).z)
				var_223_8.localEulerAngles.z = 0
				var_223_8.localEulerAngles.x = 0
				var_223_8.localEulerAngles = var_223_8.localEulerAngles
			end

			local var_223_10 = arg_220_1.actors_["10058ui_story"]

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 and not isNil(var_223_10) and arg_220_1.var_.characterEffect10058ui_story == nil then
				arg_220_1.var_.characterEffect10058ui_story = var_223_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_11 = 0.200000002980232

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_11 and not isNil(var_223_10) then
				if arg_220_1.var_.characterEffect10058ui_story and not isNil(var_223_10) then
					arg_220_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_220_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_220_1.time_ - 0) / var_223_11)
				end
			end

			if arg_220_1.time_ >= 0 + var_223_11 and arg_220_1.time_ < 0 + var_223_11 + arg_223_0 and not isNil(var_223_10) and arg_220_1.var_.characterEffect10058ui_story then
				arg_220_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_220_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_223_12 = 0
			local var_223_13 = 0.35

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= var_223_12 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				arg_220_1.leftNameTxt_.text = arg_220_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_14 = arg_220_1:GetWordFromCfg(319811053)
				local var_223_15 = arg_220_1:FormatText(var_223_14.content)

				arg_220_1.text_.text = var_223_15

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_17 = 14 <= 0 and var_223_13 or var_223_13 * (utf8.len(var_223_15) / 14)

				if (14 <= 0 and var_223_13 or var_223_13 * (utf8.len(var_223_15) / 14)) > 0 and var_223_13 < var_223_17 then
					arg_220_1.talkMaxDuration = var_223_17

					if var_223_17 + var_223_12 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_17 + var_223_12
					end
				end

				arg_220_1.text_.text = var_223_15
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811053", "story_v_out_319811.awb") ~= 0 then
					local var_223_18 = manager.audio:GetVoiceLength("story_v_out_319811", "319811053", "story_v_out_319811.awb") / 1000

					if var_223_18 + var_223_12 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_18 + var_223_12
					end

					if var_223_14.prefab_name ~= "" and arg_220_1.actors_[var_223_14.prefab_name] ~= nil then
						local var_223_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_14.prefab_name].transform, "story_v_out_319811", "319811053", "story_v_out_319811.awb")

						arg_220_1:RecordAudio("319811053", var_223_19)
						arg_220_1:RecordAudio("319811053", var_223_19)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_319811", "319811053", "story_v_out_319811.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_319811", "319811053", "story_v_out_319811.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_20 = math.max(var_223_13, arg_220_1.talkMaxDuration)

			if var_223_12 <= arg_220_1.time_ and arg_220_1.time_ < var_223_12 + var_223_20 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_12) / var_223_20

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_12 + var_223_20 and arg_220_1.time_ < var_223_12 + var_223_20 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
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

		arg_220_1:InitPlayNodeList()
	end,
	Play319811054 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 319811054
		arg_224_1.duration_ = 2.8

		local var_224_0 = {
			zh = 1.999999999999,
			ja = 2.8
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
				arg_224_0:Play319811055(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 and not isNil(arg_224_1.actors_["10058ui_story"]) and arg_224_1.var_.characterEffect10058ui_story == nil then
				arg_224_1.var_.characterEffect10058ui_story = arg_224_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_0 = 0.200000002980232

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_0 and not isNil(arg_224_1.actors_["10058ui_story"]) then
				if arg_224_1.var_.characterEffect10058ui_story and not isNil(arg_224_1.actors_["10058ui_story"]) then
					arg_224_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_224_1.time_ >= 0 + var_227_0 and arg_224_1.time_ < 0 + var_227_0 + arg_227_0 and not isNil(arg_224_1.actors_["10058ui_story"]) and arg_224_1.var_.characterEffect10058ui_story then
				arg_224_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_227_2 = arg_224_1.actors_["4037ui_story"]

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 and not isNil(var_227_2) and arg_224_1.var_.characterEffect4037ui_story == nil then
				arg_224_1.var_.characterEffect4037ui_story = var_227_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_3 = 0.200000002980232

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_3 and not isNil(var_227_2) then
				if arg_224_1.var_.characterEffect4037ui_story and not isNil(var_227_2) then
					arg_224_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_224_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_224_1.time_ - 0) / var_227_3)
				end
			end

			if arg_224_1.time_ >= 0 + var_227_3 and arg_224_1.time_ < 0 + var_227_3 + arg_227_0 and not isNil(var_227_2) and arg_224_1.var_.characterEffect4037ui_story then
				arg_224_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_224_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_227_4 = 0
			local var_227_5 = 0.15

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= var_227_4 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				arg_224_1.leftNameTxt_.text = arg_224_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_6 = arg_224_1:GetWordFromCfg(319811054)
				local var_227_7 = arg_224_1:FormatText(var_227_6.content)

				arg_224_1.text_.text = var_227_7

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_9 = 6 <= 0 and var_227_5 or var_227_5 * (utf8.len(var_227_7) / 6)

				if (6 <= 0 and var_227_5 or var_227_5 * (utf8.len(var_227_7) / 6)) > 0 and var_227_5 < var_227_9 then
					arg_224_1.talkMaxDuration = var_227_9

					if var_227_9 + var_227_4 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_9 + var_227_4
					end
				end

				arg_224_1.text_.text = var_227_7
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811054", "story_v_out_319811.awb") ~= 0 then
					local var_227_10 = manager.audio:GetVoiceLength("story_v_out_319811", "319811054", "story_v_out_319811.awb") / 1000

					if var_227_10 + var_227_4 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_10 + var_227_4
					end

					if var_227_6.prefab_name ~= "" and arg_224_1.actors_[var_227_6.prefab_name] ~= nil then
						local var_227_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_6.prefab_name].transform, "story_v_out_319811", "319811054", "story_v_out_319811.awb")

						arg_224_1:RecordAudio("319811054", var_227_11)
						arg_224_1:RecordAudio("319811054", var_227_11)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_319811", "319811054", "story_v_out_319811.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_319811", "319811054", "story_v_out_319811.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_12 = math.max(var_227_5, arg_224_1.talkMaxDuration)

			if var_227_4 <= arg_224_1.time_ and arg_224_1.time_ < var_227_4 + var_227_12 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_4) / var_227_12

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_4 + var_227_12 and arg_224_1.time_ < var_227_4 + var_227_12 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play319811055 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 319811055
		arg_228_1.duration_ = 8.23

		local var_228_0 = {
			zh = 6.133,
			ja = 8.233
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
				arg_228_0:Play319811056(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 and not isNil(arg_228_1.actors_["4037ui_story"]) and arg_228_1.var_.characterEffect4037ui_story == nil then
				arg_228_1.var_.characterEffect4037ui_story = arg_228_1.actors_["4037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_0 = 0.200000002980232

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_0 and not isNil(arg_228_1.actors_["4037ui_story"]) then
				if arg_228_1.var_.characterEffect4037ui_story and not isNil(arg_228_1.actors_["4037ui_story"]) then
					arg_228_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_228_1.time_ >= 0 + var_231_0 and arg_228_1.time_ < 0 + var_231_0 + arg_231_0 and not isNil(arg_228_1.actors_["4037ui_story"]) and arg_228_1.var_.characterEffect4037ui_story then
				arg_228_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_231_2 = arg_228_1.actors_["10058ui_story"]

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 and not isNil(var_231_2) and arg_228_1.var_.characterEffect10058ui_story == nil then
				arg_228_1.var_.characterEffect10058ui_story = var_231_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_3 = 0.200000002980232

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_3 and not isNil(var_231_2) then
				if arg_228_1.var_.characterEffect10058ui_story and not isNil(var_231_2) then
					arg_228_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_228_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_228_1.time_ - 0) / var_231_3)
				end
			end

			if arg_228_1.time_ >= 0 + var_231_3 and arg_228_1.time_ < 0 + var_231_3 + arg_231_0 and not isNil(var_231_2) and arg_228_1.var_.characterEffect10058ui_story then
				arg_228_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_228_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_231_4 = 0
			local var_231_5 = 0.675

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= var_231_4 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				arg_228_1.leftNameTxt_.text = arg_228_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_6 = arg_228_1:GetWordFromCfg(319811055)
				local var_231_7 = arg_228_1:FormatText(var_231_6.content)

				arg_228_1.text_.text = var_231_7

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_9 = 27 <= 0 and var_231_5 or var_231_5 * (utf8.len(var_231_7) / 27)

				if (27 <= 0 and var_231_5 or var_231_5 * (utf8.len(var_231_7) / 27)) > 0 and var_231_5 < var_231_9 then
					arg_228_1.talkMaxDuration = var_231_9

					if var_231_9 + var_231_4 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_9 + var_231_4
					end
				end

				arg_228_1.text_.text = var_231_7
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811055", "story_v_out_319811.awb") ~= 0 then
					local var_231_10 = manager.audio:GetVoiceLength("story_v_out_319811", "319811055", "story_v_out_319811.awb") / 1000

					if var_231_10 + var_231_4 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_10 + var_231_4
					end

					if var_231_6.prefab_name ~= "" and arg_228_1.actors_[var_231_6.prefab_name] ~= nil then
						local var_231_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_6.prefab_name].transform, "story_v_out_319811", "319811055", "story_v_out_319811.awb")

						arg_228_1:RecordAudio("319811055", var_231_11)
						arg_228_1:RecordAudio("319811055", var_231_11)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_out_319811", "319811055", "story_v_out_319811.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_out_319811", "319811055", "story_v_out_319811.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_12 = math.max(var_231_5, arg_228_1.talkMaxDuration)

			if var_231_4 <= arg_228_1.time_ and arg_228_1.time_ < var_231_4 + var_231_12 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_4) / var_231_12

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_4 + var_231_12 and arg_228_1.time_ < var_231_4 + var_231_12 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play319811056 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 319811056
		arg_232_1.duration_ = 4.8

		local var_232_0 = {
			zh = 1.999999999999,
			ja = 4.8
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
				arg_232_0:Play319811057(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1.var_.moveOldPos1084ui_story = arg_232_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_235_0 = 0.001

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_0 then
				arg_232_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_232_1.time_ - 0) / var_235_0)
				arg_232_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_232_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_232_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_232_1.actors_["1084ui_story"].transform.position).z)
				arg_232_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_232_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_232_1.actors_["1084ui_story"].transform.localEulerAngles = arg_232_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_232_1.time_ >= 0 + var_235_0 and arg_232_1.time_ < 0 + var_235_0 + arg_235_0 then
				arg_232_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_232_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_232_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_232_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_232_1.actors_["1084ui_story"].transform.position).z)
				arg_232_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_232_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_232_1.actors_["1084ui_story"].transform.localEulerAngles = arg_232_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_235_1 = arg_232_1.actors_["1084ui_story"]

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 and not isNil(var_235_1) and arg_232_1.var_.characterEffect1084ui_story == nil then
				arg_232_1.var_.characterEffect1084ui_story = var_235_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_235_2 = 0.200000002980232

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_2 and not isNil(var_235_1) then
				if arg_232_1.var_.characterEffect1084ui_story and not isNil(var_235_1) then
					arg_232_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_232_1.time_ >= 0 + var_235_2 and arg_232_1.time_ < 0 + var_235_2 + arg_235_0 and not isNil(var_235_1) and arg_232_1.var_.characterEffect1084ui_story then
				arg_232_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_235_4 = arg_232_1.actors_["4037ui_story"].transform

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1.var_.moveOldPos4037ui_story = var_235_4.localPosition
			end

			local var_235_5 = 0.001

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_5 then
				var_235_4.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos4037ui_story, Vector3.New(0, 100, 0), (arg_232_1.time_ - 0) / var_235_5)
				var_235_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_235_4.position).x, (manager.ui.mainCamera.transform.position - var_235_4.position).y, (manager.ui.mainCamera.transform.position - var_235_4.position).z)
				var_235_4.localEulerAngles.z = 0
				var_235_4.localEulerAngles.x = 0
				var_235_4.localEulerAngles = var_235_4.localEulerAngles
			end

			if arg_232_1.time_ >= 0 + var_235_5 and arg_232_1.time_ < 0 + var_235_5 + arg_235_0 then
				var_235_4.localPosition = Vector3.New(0, 100, 0)
				var_235_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_235_4.position).x, (manager.ui.mainCamera.transform.position - var_235_4.position).y, (manager.ui.mainCamera.transform.position - var_235_4.position).z)
				var_235_4.localEulerAngles.z = 0
				var_235_4.localEulerAngles.x = 0
				var_235_4.localEulerAngles = var_235_4.localEulerAngles
			end

			local var_235_6 = arg_232_1.actors_["4037ui_story"]

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 and not isNil(var_235_6) and arg_232_1.var_.characterEffect4037ui_story == nil then
				arg_232_1.var_.characterEffect4037ui_story = var_235_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_235_7 = 0.200000002980232

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_7 and not isNil(var_235_6) then
				if arg_232_1.var_.characterEffect4037ui_story and not isNil(var_235_6) then
					arg_232_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_232_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_232_1.time_ - 0) / var_235_7)
				end
			end

			if arg_232_1.time_ >= 0 + var_235_7 and arg_232_1.time_ < 0 + var_235_7 + arg_235_0 and not isNil(var_235_6) and arg_232_1.var_.characterEffect4037ui_story then
				arg_232_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_232_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_235_8 = arg_232_1.actors_["10058ui_story"].transform

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1.var_.moveOldPos10058ui_story = var_235_8.localPosition
			end

			local var_235_9 = 0.001

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_9 then
				var_235_8.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_232_1.time_ - 0) / var_235_9)
				var_235_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_235_8.position).x, (manager.ui.mainCamera.transform.position - var_235_8.position).y, (manager.ui.mainCamera.transform.position - var_235_8.position).z)
				var_235_8.localEulerAngles.z = 0
				var_235_8.localEulerAngles.x = 0
				var_235_8.localEulerAngles = var_235_8.localEulerAngles
			end

			if arg_232_1.time_ >= 0 + var_235_9 and arg_232_1.time_ < 0 + var_235_9 + arg_235_0 then
				var_235_8.localPosition = Vector3.New(0, 100, 0)
				var_235_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_235_8.position).x, (manager.ui.mainCamera.transform.position - var_235_8.position).y, (manager.ui.mainCamera.transform.position - var_235_8.position).z)
				var_235_8.localEulerAngles.z = 0
				var_235_8.localEulerAngles.x = 0
				var_235_8.localEulerAngles = var_235_8.localEulerAngles
			end

			local var_235_10 = 0
			local var_235_11 = 0.225

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= var_235_10 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				arg_232_1.leftNameTxt_.text = arg_232_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_12 = arg_232_1:GetWordFromCfg(319811056)
				local var_235_13 = arg_232_1:FormatText(var_235_12.content)

				arg_232_1.text_.text = var_235_13

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_15 = 9 <= 0 and var_235_11 or var_235_11 * (utf8.len(var_235_13) / 9)

				if (9 <= 0 and var_235_11 or var_235_11 * (utf8.len(var_235_13) / 9)) > 0 and var_235_11 < var_235_15 then
					arg_232_1.talkMaxDuration = var_235_15

					if var_235_15 + var_235_10 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_15 + var_235_10
					end
				end

				arg_232_1.text_.text = var_235_13
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811056", "story_v_out_319811.awb") ~= 0 then
					local var_235_16 = manager.audio:GetVoiceLength("story_v_out_319811", "319811056", "story_v_out_319811.awb") / 1000

					if var_235_16 + var_235_10 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_16 + var_235_10
					end

					if var_235_12.prefab_name ~= "" and arg_232_1.actors_[var_235_12.prefab_name] ~= nil then
						local var_235_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_12.prefab_name].transform, "story_v_out_319811", "319811056", "story_v_out_319811.awb")

						arg_232_1:RecordAudio("319811056", var_235_17)
						arg_232_1:RecordAudio("319811056", var_235_17)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_out_319811", "319811056", "story_v_out_319811.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_out_319811", "319811056", "story_v_out_319811.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_18 = math.max(var_235_11, arg_232_1.talkMaxDuration)

			if var_235_10 <= arg_232_1.time_ and arg_232_1.time_ < var_235_10 + var_235_18 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_10) / var_235_18

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_10 + var_235_18 and arg_232_1.time_ < var_235_10 + var_235_18 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {
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
				actorName = "4037ui_story",
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

		arg_232_1:InitPlayNodeList()
	end,
	Play319811057 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 319811057
		arg_236_1.duration_ = 3.2

		local var_236_0 = {
			zh = 3,
			ja = 3.2
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
				arg_236_0:Play319811058(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1.var_.moveOldPos4037ui_story = arg_236_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_239_0 = 0.001

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_0 then
				arg_236_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_236_1.var_.moveOldPos4037ui_story, Vector3.New(0, -1.12, -6.2), (arg_236_1.time_ - 0) / var_239_0)
				arg_236_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_236_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["4037ui_story"].transform.position).z)
				arg_236_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_236_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_236_1.actors_["4037ui_story"].transform.localEulerAngles = arg_236_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_236_1.time_ >= 0 + var_239_0 and arg_236_1.time_ < 0 + var_239_0 + arg_239_0 then
				arg_236_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(0, -1.12, -6.2)
				arg_236_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_236_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["4037ui_story"].transform.position).z)
				arg_236_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_236_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_236_1.actors_["4037ui_story"].transform.localEulerAngles = arg_236_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_239_1 = arg_236_1.actors_["4037ui_story"]

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 and not isNil(var_239_1) and arg_236_1.var_.characterEffect4037ui_story == nil then
				arg_236_1.var_.characterEffect4037ui_story = var_239_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_239_2 = 0.200000002980232

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_2 and not isNil(var_239_1) then
				if arg_236_1.var_.characterEffect4037ui_story and not isNil(var_239_1) then
					arg_236_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_236_1.time_ >= 0 + var_239_2 and arg_236_1.time_ < 0 + var_239_2 + arg_239_0 and not isNil(var_239_1) and arg_236_1.var_.characterEffect4037ui_story then
				arg_236_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037actionlink/4037action423")
			end

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_239_4 = arg_236_1.actors_["1084ui_story"]

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 and not isNil(var_239_4) and arg_236_1.var_.characterEffect1084ui_story == nil then
				arg_236_1.var_.characterEffect1084ui_story = var_239_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_239_5 = 0.200000002980232

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_5 and not isNil(var_239_4) then
				if arg_236_1.var_.characterEffect1084ui_story and not isNil(var_239_4) then
					arg_236_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_236_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_236_1.time_ - 0) / var_239_5)
				end
			end

			if arg_236_1.time_ >= 0 + var_239_5 and arg_236_1.time_ < 0 + var_239_5 + arg_239_0 and not isNil(var_239_4) and arg_236_1.var_.characterEffect1084ui_story then
				arg_236_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_236_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_239_6 = arg_236_1.actors_["1084ui_story"].transform

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1.var_.moveOldPos1084ui_story = var_239_6.localPosition
			end

			local var_239_7 = 0.001

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_7 then
				var_239_6.localPosition = Vector3.Lerp(arg_236_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_236_1.time_ - 0) / var_239_7)
				var_239_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_239_6.position).x, (manager.ui.mainCamera.transform.position - var_239_6.position).y, (manager.ui.mainCamera.transform.position - var_239_6.position).z)
				var_239_6.localEulerAngles.z = 0
				var_239_6.localEulerAngles.x = 0
				var_239_6.localEulerAngles = var_239_6.localEulerAngles
			end

			if arg_236_1.time_ >= 0 + var_239_7 and arg_236_1.time_ < 0 + var_239_7 + arg_239_0 then
				var_239_6.localPosition = Vector3.New(0, 100, 0)
				var_239_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_239_6.position).x, (manager.ui.mainCamera.transform.position - var_239_6.position).y, (manager.ui.mainCamera.transform.position - var_239_6.position).z)
				var_239_6.localEulerAngles.z = 0
				var_239_6.localEulerAngles.x = 0
				var_239_6.localEulerAngles = var_239_6.localEulerAngles
			end

			local var_239_8 = 0
			local var_239_9 = 0.2

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= var_239_8 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				arg_236_1.leftNameTxt_.text = arg_236_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_10 = arg_236_1:GetWordFromCfg(319811057)
				local var_239_11 = arg_236_1:FormatText(var_239_10.content)

				arg_236_1.text_.text = var_239_11

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_13 = 8 <= 0 and var_239_9 or var_239_9 * (utf8.len(var_239_11) / 8)

				if (8 <= 0 and var_239_9 or var_239_9 * (utf8.len(var_239_11) / 8)) > 0 and var_239_9 < var_239_13 then
					arg_236_1.talkMaxDuration = var_239_13

					if var_239_13 + var_239_8 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_13 + var_239_8
					end
				end

				arg_236_1.text_.text = var_239_11
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811057", "story_v_out_319811.awb") ~= 0 then
					local var_239_14 = manager.audio:GetVoiceLength("story_v_out_319811", "319811057", "story_v_out_319811.awb") / 1000

					if var_239_14 + var_239_8 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_14 + var_239_8
					end

					if var_239_10.prefab_name ~= "" and arg_236_1.actors_[var_239_10.prefab_name] ~= nil then
						local var_239_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_10.prefab_name].transform, "story_v_out_319811", "319811057", "story_v_out_319811.awb")

						arg_236_1:RecordAudio("319811057", var_239_15)
						arg_236_1:RecordAudio("319811057", var_239_15)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_out_319811", "319811057", "story_v_out_319811.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_out_319811", "319811057", "story_v_out_319811.awb")
				end

				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_16 = math.max(var_239_9, arg_236_1.talkMaxDuration)

			if var_239_8 <= arg_236_1.time_ and arg_236_1.time_ < var_239_8 + var_239_16 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_8) / var_239_16

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_8 + var_239_16 and arg_236_1.time_ < var_239_8 + var_239_16 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
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

		arg_236_1:InitPlayNodeList()
	end,
	Play319811058 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 319811058
		arg_240_1.duration_ = 5

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play319811059(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1.var_.moveOldPos4037ui_story = arg_240_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_243_0 = 0.001

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_0 then
				arg_240_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_240_1.var_.moveOldPos4037ui_story, Vector3.New(0, 100, 0), (arg_240_1.time_ - 0) / var_243_0)
				arg_240_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_240_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_240_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_240_1.actors_["4037ui_story"].transform.position).z)
				arg_240_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_240_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_240_1.actors_["4037ui_story"].transform.localEulerAngles = arg_240_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_240_1.time_ >= 0 + var_243_0 and arg_240_1.time_ < 0 + var_243_0 + arg_243_0 then
				arg_240_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_240_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_240_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_240_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_240_1.actors_["4037ui_story"].transform.position).z)
				arg_240_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_240_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_240_1.actors_["4037ui_story"].transform.localEulerAngles = arg_240_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_243_1 = arg_240_1.actors_["4037ui_story"]

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 and not isNil(var_243_1) and arg_240_1.var_.characterEffect4037ui_story == nil then
				arg_240_1.var_.characterEffect4037ui_story = var_243_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_243_2 = 0.200000002980232

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_2 and not isNil(var_243_1) then
				if arg_240_1.var_.characterEffect4037ui_story and not isNil(var_243_1) then
					arg_240_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_240_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_240_1.time_ - 0) / var_243_2)
				end
			end

			if arg_240_1.time_ >= 0 + var_243_2 and arg_240_1.time_ < 0 + var_243_2 + arg_243_0 and not isNil(var_243_1) and arg_240_1.var_.characterEffect4037ui_story then
				arg_240_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_240_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_243_3 = 0
			local var_243_4 = 1.125

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_3 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, false)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_5 = arg_240_1:FormatText(arg_240_1:GetWordFromCfg(319811058).content)

				arg_240_1.text_.text = var_243_5

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_7 = 45 <= 0 and var_243_4 or var_243_4 * (utf8.len(var_243_5) / 45)

				if (45 <= 0 and var_243_4 or var_243_4 * (utf8.len(var_243_5) / 45)) > 0 and var_243_4 < var_243_7 then
					arg_240_1.talkMaxDuration = var_243_7

					if var_243_7 + var_243_3 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_7 + var_243_3
					end
				end

				arg_240_1.text_.text = var_243_5
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)
				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_8 = math.max(var_243_4, arg_240_1.talkMaxDuration)

			if var_243_3 <= arg_240_1.time_ and arg_240_1.time_ < var_243_3 + var_243_8 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_3) / var_243_8

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_3 + var_243_8 and arg_240_1.time_ < var_243_3 + var_243_8 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_240_1:InitPlayNodeList()
	end,
	Play319811059 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 319811059
		arg_244_1.duration_ = 4.33

		local var_244_0 = {
			zh = 3.566,
			ja = 4.333
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
				arg_244_0:Play319811060(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1.var_.moveOldPos1084ui_story = arg_244_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_247_0 = 0.001

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_0 then
				arg_244_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_244_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_244_1.time_ - 0) / var_247_0)
				arg_244_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_244_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_244_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_244_1.actors_["1084ui_story"].transform.position).z)
				arg_244_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_244_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_244_1.actors_["1084ui_story"].transform.localEulerAngles = arg_244_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_244_1.time_ >= 0 + var_247_0 and arg_244_1.time_ < 0 + var_247_0 + arg_247_0 then
				arg_244_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_244_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_244_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_244_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_244_1.actors_["1084ui_story"].transform.position).z)
				arg_244_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_244_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_244_1.actors_["1084ui_story"].transform.localEulerAngles = arg_244_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_247_1 = arg_244_1.actors_["1084ui_story"]

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 and not isNil(var_247_1) and arg_244_1.var_.characterEffect1084ui_story == nil then
				arg_244_1.var_.characterEffect1084ui_story = var_247_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_2 = 0.200000002980232

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_2 and not isNil(var_247_1) then
				if arg_244_1.var_.characterEffect1084ui_story and not isNil(var_247_1) then
					arg_244_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_244_1.time_ >= 0 + var_247_2 and arg_244_1.time_ < 0 + var_247_2 + arg_247_0 and not isNil(var_247_1) and arg_244_1.var_.characterEffect1084ui_story then
				arg_244_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_247_4 = 0
			local var_247_5 = 0.5

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_4 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				arg_244_1.leftNameTxt_.text = arg_244_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_6 = arg_244_1:GetWordFromCfg(319811059)
				local var_247_7 = arg_244_1:FormatText(var_247_6.content)

				arg_244_1.text_.text = var_247_7

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_9 = 20 <= 0 and var_247_5 or var_247_5 * (utf8.len(var_247_7) / 20)

				if (20 <= 0 and var_247_5 or var_247_5 * (utf8.len(var_247_7) / 20)) > 0 and var_247_5 < var_247_9 then
					arg_244_1.talkMaxDuration = var_247_9

					if var_247_9 + var_247_4 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_9 + var_247_4
					end
				end

				arg_244_1.text_.text = var_247_7
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811059", "story_v_out_319811.awb") ~= 0 then
					local var_247_10 = manager.audio:GetVoiceLength("story_v_out_319811", "319811059", "story_v_out_319811.awb") / 1000

					if var_247_10 + var_247_4 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_10 + var_247_4
					end

					if var_247_6.prefab_name ~= "" and arg_244_1.actors_[var_247_6.prefab_name] ~= nil then
						local var_247_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_6.prefab_name].transform, "story_v_out_319811", "319811059", "story_v_out_319811.awb")

						arg_244_1:RecordAudio("319811059", var_247_11)
						arg_244_1:RecordAudio("319811059", var_247_11)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_319811", "319811059", "story_v_out_319811.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_319811", "319811059", "story_v_out_319811.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_12 = math.max(var_247_5, arg_244_1.talkMaxDuration)

			if var_247_4 <= arg_244_1.time_ and arg_244_1.time_ < var_247_4 + var_247_12 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_4) / var_247_12

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_4 + var_247_12 and arg_244_1.time_ < var_247_4 + var_247_12 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {
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

		arg_244_1:InitPlayNodeList()
	end,
	Play319811060 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 319811060
		arg_248_1.duration_ = 8.07

		local var_248_0 = {
			zh = 3.166,
			ja = 8.066
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
				arg_248_0:Play319811061(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1.var_.moveOldPos4037ui_story = arg_248_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_251_0 = 0.001

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_0 then
				arg_248_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_248_1.var_.moveOldPos4037ui_story, Vector3.New(0.7, -1.12, -6.2), (arg_248_1.time_ - 0) / var_251_0)
				arg_248_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_248_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["4037ui_story"].transform.position).z)
				arg_248_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_248_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_248_1.actors_["4037ui_story"].transform.localEulerAngles = arg_248_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_248_1.time_ >= 0 + var_251_0 and arg_248_1.time_ < 0 + var_251_0 + arg_251_0 then
				arg_248_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(0.7, -1.12, -6.2)
				arg_248_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_248_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["4037ui_story"].transform.position).z)
				arg_248_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_248_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_248_1.actors_["4037ui_story"].transform.localEulerAngles = arg_248_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_251_1 = arg_248_1.actors_["4037ui_story"]

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 and not isNil(var_251_1) and arg_248_1.var_.characterEffect4037ui_story == nil then
				arg_248_1.var_.characterEffect4037ui_story = var_251_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_251_2 = 0.200000002980232

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_2 and not isNil(var_251_1) then
				if arg_248_1.var_.characterEffect4037ui_story and not isNil(var_251_1) then
					arg_248_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_248_1.time_ >= 0 + var_251_2 and arg_248_1.time_ < 0 + var_251_2 + arg_251_0 and not isNil(var_251_1) and arg_248_1.var_.characterEffect4037ui_story then
				arg_248_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_251_4 = arg_248_1.actors_["1084ui_story"].transform

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1.var_.moveOldPos1084ui_story = var_251_4.localPosition
			end

			local var_251_5 = 0.001

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_5 then
				var_251_4.localPosition = Vector3.Lerp(arg_248_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_248_1.time_ - 0) / var_251_5)
				var_251_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_251_4.position).x, (manager.ui.mainCamera.transform.position - var_251_4.position).y, (manager.ui.mainCamera.transform.position - var_251_4.position).z)
				var_251_4.localEulerAngles.z = 0
				var_251_4.localEulerAngles.x = 0
				var_251_4.localEulerAngles = var_251_4.localEulerAngles
			end

			if arg_248_1.time_ >= 0 + var_251_5 and arg_248_1.time_ < 0 + var_251_5 + arg_251_0 then
				var_251_4.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_251_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_251_4.position).x, (manager.ui.mainCamera.transform.position - var_251_4.position).y, (manager.ui.mainCamera.transform.position - var_251_4.position).z)
				var_251_4.localEulerAngles.z = 0
				var_251_4.localEulerAngles.x = 0
				var_251_4.localEulerAngles = var_251_4.localEulerAngles
			end

			local var_251_6 = arg_248_1.actors_["1084ui_story"]

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 and not isNil(var_251_6) and arg_248_1.var_.characterEffect1084ui_story == nil then
				arg_248_1.var_.characterEffect1084ui_story = var_251_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_251_7 = 0.200000002980232

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_7 and not isNil(var_251_6) then
				if arg_248_1.var_.characterEffect1084ui_story and not isNil(var_251_6) then
					arg_248_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_248_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_248_1.time_ - 0) / var_251_7)
				end
			end

			if arg_248_1.time_ >= 0 + var_251_7 and arg_248_1.time_ < 0 + var_251_7 + arg_251_0 and not isNil(var_251_6) and arg_248_1.var_.characterEffect1084ui_story then
				arg_248_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_248_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action3_2")
			end

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_251_8 = 0
			local var_251_9 = 0.3

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_8 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				arg_248_1.leftNameTxt_.text = arg_248_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_10 = arg_248_1:GetWordFromCfg(319811060)
				local var_251_11 = arg_248_1:FormatText(var_251_10.content)

				arg_248_1.text_.text = var_251_11

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_13 = 12 <= 0 and var_251_9 or var_251_9 * (utf8.len(var_251_11) / 12)

				if (12 <= 0 and var_251_9 or var_251_9 * (utf8.len(var_251_11) / 12)) > 0 and var_251_9 < var_251_13 then
					arg_248_1.talkMaxDuration = var_251_13

					if var_251_13 + var_251_8 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_13 + var_251_8
					end
				end

				arg_248_1.text_.text = var_251_11
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811060", "story_v_out_319811.awb") ~= 0 then
					local var_251_14 = manager.audio:GetVoiceLength("story_v_out_319811", "319811060", "story_v_out_319811.awb") / 1000

					if var_251_14 + var_251_8 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_14 + var_251_8
					end

					if var_251_10.prefab_name ~= "" and arg_248_1.actors_[var_251_10.prefab_name] ~= nil then
						local var_251_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_10.prefab_name].transform, "story_v_out_319811", "319811060", "story_v_out_319811.awb")

						arg_248_1:RecordAudio("319811060", var_251_15)
						arg_248_1:RecordAudio("319811060", var_251_15)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_out_319811", "319811060", "story_v_out_319811.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_out_319811", "319811060", "story_v_out_319811.awb")
				end

				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_16 = math.max(var_251_9, arg_248_1.talkMaxDuration)

			if var_251_8 <= arg_248_1.time_ and arg_248_1.time_ < var_251_8 + var_251_16 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_8) / var_251_16

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_8 + var_251_16 and arg_248_1.time_ < var_251_8 + var_251_16 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
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

		arg_248_1:InitPlayNodeList()
	end,
	Play319811061 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 319811061
		arg_252_1.duration_ = 2

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play319811062(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 and not isNil(arg_252_1.actors_["1084ui_story"]) and arg_252_1.var_.characterEffect1084ui_story == nil then
				arg_252_1.var_.characterEffect1084ui_story = arg_252_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_255_0 = 0.200000002980232

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_0 and not isNil(arg_252_1.actors_["1084ui_story"]) then
				if arg_252_1.var_.characterEffect1084ui_story and not isNil(arg_252_1.actors_["1084ui_story"]) then
					arg_252_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_252_1.time_ >= 0 + var_255_0 and arg_252_1.time_ < 0 + var_255_0 + arg_255_0 and not isNil(arg_252_1.actors_["1084ui_story"]) and arg_252_1.var_.characterEffect1084ui_story then
				arg_252_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_2")
			end

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2202cva")
			end

			local var_255_2 = arg_252_1.actors_["4037ui_story"]

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 and not isNil(var_255_2) and arg_252_1.var_.characterEffect4037ui_story == nil then
				arg_252_1.var_.characterEffect4037ui_story = var_255_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_255_3 = 0.200000002980232

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_3 and not isNil(var_255_2) then
				if arg_252_1.var_.characterEffect4037ui_story and not isNil(var_255_2) then
					arg_252_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_252_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_252_1.time_ - 0) / var_255_3)
				end
			end

			if arg_252_1.time_ >= 0 + var_255_3 and arg_252_1.time_ < 0 + var_255_3 + arg_255_0 and not isNil(var_255_2) and arg_252_1.var_.characterEffect4037ui_story then
				arg_252_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_252_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_255_4 = 0
			local var_255_5 = 0.05

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_4 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				arg_252_1.leftNameTxt_.text = arg_252_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_6 = arg_252_1:GetWordFromCfg(319811061)
				local var_255_7 = arg_252_1:FormatText(var_255_6.content)

				arg_252_1.text_.text = var_255_7

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_9 = 2 <= 0 and var_255_5 or var_255_5 * (utf8.len(var_255_7) / 2)

				if (2 <= 0 and var_255_5 or var_255_5 * (utf8.len(var_255_7) / 2)) > 0 and var_255_5 < var_255_9 then
					arg_252_1.talkMaxDuration = var_255_9

					if var_255_9 + var_255_4 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_9 + var_255_4
					end
				end

				arg_252_1.text_.text = var_255_7
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811061", "story_v_out_319811.awb") ~= 0 then
					local var_255_10 = manager.audio:GetVoiceLength("story_v_out_319811", "319811061", "story_v_out_319811.awb") / 1000

					if var_255_10 + var_255_4 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_10 + var_255_4
					end

					if var_255_6.prefab_name ~= "" and arg_252_1.actors_[var_255_6.prefab_name] ~= nil then
						local var_255_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_6.prefab_name].transform, "story_v_out_319811", "319811061", "story_v_out_319811.awb")

						arg_252_1:RecordAudio("319811061", var_255_11)
						arg_252_1:RecordAudio("319811061", var_255_11)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_319811", "319811061", "story_v_out_319811.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_319811", "319811061", "story_v_out_319811.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_12 = math.max(var_255_5, arg_252_1.talkMaxDuration)

			if var_255_4 <= arg_252_1.time_ and arg_252_1.time_ < var_255_4 + var_255_12 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_4) / var_255_12

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_4 + var_255_12 and arg_252_1.time_ < var_255_4 + var_255_12 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play319811062 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 319811062
		arg_256_1.duration_ = 4.8

		local var_256_0 = {
			zh = 1.999999999999,
			ja = 4.8
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
				arg_256_0:Play319811063(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1.var_.moveOldPos4037ui_story = arg_256_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_259_0 = 0.001

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_0 then
				arg_256_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_256_1.var_.moveOldPos4037ui_story, Vector3.New(0, -1.12, -6.2), (arg_256_1.time_ - 0) / var_259_0)
				arg_256_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_256_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_256_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_256_1.actors_["4037ui_story"].transform.position).z)
				arg_256_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_256_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_256_1.actors_["4037ui_story"].transform.localEulerAngles = arg_256_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_256_1.time_ >= 0 + var_259_0 and arg_256_1.time_ < 0 + var_259_0 + arg_259_0 then
				arg_256_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(0, -1.12, -6.2)
				arg_256_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_256_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_256_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_256_1.actors_["4037ui_story"].transform.position).z)
				arg_256_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_256_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_256_1.actors_["4037ui_story"].transform.localEulerAngles = arg_256_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_259_1 = arg_256_1.actors_["4037ui_story"]

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 and not isNil(var_259_1) and arg_256_1.var_.characterEffect4037ui_story == nil then
				arg_256_1.var_.characterEffect4037ui_story = var_259_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_259_2 = 0.200000002980232

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_2 and not isNil(var_259_1) then
				if arg_256_1.var_.characterEffect4037ui_story and not isNil(var_259_1) then
					arg_256_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_256_1.time_ >= 0 + var_259_2 and arg_256_1.time_ < 0 + var_259_2 + arg_259_0 and not isNil(var_259_1) and arg_256_1.var_.characterEffect4037ui_story then
				arg_256_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2201cva")
			end

			local var_259_4 = arg_256_1.actors_["1084ui_story"].transform

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1.var_.moveOldPos1084ui_story = var_259_4.localPosition
			end

			local var_259_5 = 0.001

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_5 then
				var_259_4.localPosition = Vector3.Lerp(arg_256_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_256_1.time_ - 0) / var_259_5)
				var_259_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_259_4.position).x, (manager.ui.mainCamera.transform.position - var_259_4.position).y, (manager.ui.mainCamera.transform.position - var_259_4.position).z)
				var_259_4.localEulerAngles.z = 0
				var_259_4.localEulerAngles.x = 0
				var_259_4.localEulerAngles = var_259_4.localEulerAngles
			end

			if arg_256_1.time_ >= 0 + var_259_5 and arg_256_1.time_ < 0 + var_259_5 + arg_259_0 then
				var_259_4.localPosition = Vector3.New(0, 100, 0)
				var_259_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_259_4.position).x, (manager.ui.mainCamera.transform.position - var_259_4.position).y, (manager.ui.mainCamera.transform.position - var_259_4.position).z)
				var_259_4.localEulerAngles.z = 0
				var_259_4.localEulerAngles.x = 0
				var_259_4.localEulerAngles = var_259_4.localEulerAngles
			end

			local var_259_6 = arg_256_1.actors_["1084ui_story"]

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 and not isNil(var_259_6) and arg_256_1.var_.characterEffect1084ui_story == nil then
				arg_256_1.var_.characterEffect1084ui_story = var_259_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_259_7 = 0.200000002980232

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_7 and not isNil(var_259_6) then
				if arg_256_1.var_.characterEffect1084ui_story and not isNil(var_259_6) then
					arg_256_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_256_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_256_1.time_ - 0) / var_259_7)
				end
			end

			if arg_256_1.time_ >= 0 + var_259_7 and arg_256_1.time_ < 0 + var_259_7 + arg_259_0 and not isNil(var_259_6) and arg_256_1.var_.characterEffect1084ui_story then
				arg_256_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_256_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_259_8 = 0
			local var_259_9 = 0.075

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_8 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				arg_256_1.leftNameTxt_.text = arg_256_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_10 = arg_256_1:GetWordFromCfg(319811062)
				local var_259_11 = arg_256_1:FormatText(var_259_10.content)

				arg_256_1.text_.text = var_259_11

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_13 = 3 <= 0 and var_259_9 or var_259_9 * (utf8.len(var_259_11) / 3)

				if (3 <= 0 and var_259_9 or var_259_9 * (utf8.len(var_259_11) / 3)) > 0 and var_259_9 < var_259_13 then
					arg_256_1.talkMaxDuration = var_259_13

					if var_259_13 + var_259_8 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_13 + var_259_8
					end
				end

				arg_256_1.text_.text = var_259_11
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811062", "story_v_out_319811.awb") ~= 0 then
					local var_259_14 = manager.audio:GetVoiceLength("story_v_out_319811", "319811062", "story_v_out_319811.awb") / 1000

					if var_259_14 + var_259_8 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_14 + var_259_8
					end

					if var_259_10.prefab_name ~= "" and arg_256_1.actors_[var_259_10.prefab_name] ~= nil then
						local var_259_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_10.prefab_name].transform, "story_v_out_319811", "319811062", "story_v_out_319811.awb")

						arg_256_1:RecordAudio("319811062", var_259_15)
						arg_256_1:RecordAudio("319811062", var_259_15)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_out_319811", "319811062", "story_v_out_319811.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_out_319811", "319811062", "story_v_out_319811.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_16 = math.max(var_259_9, arg_256_1.talkMaxDuration)

			if var_259_8 <= arg_256_1.time_ and arg_256_1.time_ < var_259_8 + var_259_16 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_8) / var_259_16

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_8 + var_259_16 and arg_256_1.time_ < var_259_8 + var_259_16 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
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

		arg_256_1:InitPlayNodeList()
	end,
	Play319811063 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 319811063
		arg_260_1.duration_ = 3.1

		local var_260_0 = {
			zh = 3.1,
			ja = 2.033
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
				arg_260_0:Play319811064(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = 0.25

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				arg_260_1.leftNameTxt_.text = arg_260_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_1 = arg_260_1:GetWordFromCfg(319811063)
				local var_263_2 = arg_260_1:FormatText(var_263_1.content)

				arg_260_1.text_.text = var_263_2

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_4 = 10 <= 0 and var_263_0 or var_263_0 * (utf8.len(var_263_2) / 10)

				if (10 <= 0 and var_263_0 or var_263_0 * (utf8.len(var_263_2) / 10)) > 0 and var_263_0 < var_263_4 then
					arg_260_1.talkMaxDuration = var_263_4

					if var_263_4 + 0 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_4 + 0
					end
				end

				arg_260_1.text_.text = var_263_2
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811063", "story_v_out_319811.awb") ~= 0 then
					local var_263_5 = manager.audio:GetVoiceLength("story_v_out_319811", "319811063", "story_v_out_319811.awb") / 1000

					if var_263_5 + 0 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_5 + 0
					end

					if var_263_1.prefab_name ~= "" and arg_260_1.actors_[var_263_1.prefab_name] ~= nil then
						local var_263_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_260_1.actors_[var_263_1.prefab_name].transform, "story_v_out_319811", "319811063", "story_v_out_319811.awb")

						arg_260_1:RecordAudio("319811063", var_263_6)
						arg_260_1:RecordAudio("319811063", var_263_6)
					else
						arg_260_1:AudioAction("play", "voice", "story_v_out_319811", "319811063", "story_v_out_319811.awb")
					end

					arg_260_1:RecordHistoryTalkVoice("story_v_out_319811", "319811063", "story_v_out_319811.awb")
				end

				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_7 = math.max(var_263_0, arg_260_1.talkMaxDuration)

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_7 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - 0) / var_263_7

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= 0 + var_263_7 and arg_260_1.time_ < 0 + var_263_7 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play319811064 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 319811064
		arg_264_1.duration_ = 5

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play319811065(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1.var_.moveOldPos4037ui_story = arg_264_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_267_0 = 0.001

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_0 then
				arg_264_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_264_1.var_.moveOldPos4037ui_story, Vector3.New(0, 100, 0), (arg_264_1.time_ - 0) / var_267_0)
				arg_264_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_264_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_264_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_264_1.actors_["4037ui_story"].transform.position).z)
				arg_264_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_264_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_264_1.actors_["4037ui_story"].transform.localEulerAngles = arg_264_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_264_1.time_ >= 0 + var_267_0 and arg_264_1.time_ < 0 + var_267_0 + arg_267_0 then
				arg_264_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_264_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_264_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_264_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_264_1.actors_["4037ui_story"].transform.position).z)
				arg_264_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_264_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_264_1.actors_["4037ui_story"].transform.localEulerAngles = arg_264_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_267_1 = arg_264_1.actors_["4037ui_story"]

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 and not isNil(var_267_1) and arg_264_1.var_.characterEffect4037ui_story == nil then
				arg_264_1.var_.characterEffect4037ui_story = var_267_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_267_2 = 0.200000002980232

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_2 and not isNil(var_267_1) then
				if arg_264_1.var_.characterEffect4037ui_story and not isNil(var_267_1) then
					arg_264_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_264_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_264_1.time_ - 0) / var_267_2)
				end
			end

			if arg_264_1.time_ >= 0 + var_267_2 and arg_264_1.time_ < 0 + var_267_2 + arg_267_0 and not isNil(var_267_1) and arg_264_1.var_.characterEffect4037ui_story then
				arg_264_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_264_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_267_3 = 0
			local var_267_4 = 0.875

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= var_267_3 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, false)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_5 = arg_264_1:FormatText(arg_264_1:GetWordFromCfg(319811064).content)

				arg_264_1.text_.text = var_267_5

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_7 = 35 <= 0 and var_267_4 or var_267_4 * (utf8.len(var_267_5) / 35)

				if (35 <= 0 and var_267_4 or var_267_4 * (utf8.len(var_267_5) / 35)) > 0 and var_267_4 < var_267_7 then
					arg_264_1.talkMaxDuration = var_267_7

					if var_267_7 + var_267_3 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_7 + var_267_3
					end
				end

				arg_264_1.text_.text = var_267_5
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)
				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_8 = math.max(var_267_4, arg_264_1.talkMaxDuration)

			if var_267_3 <= arg_264_1.time_ and arg_264_1.time_ < var_267_3 + var_267_8 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_3) / var_267_8

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_3 + var_267_8 and arg_264_1.time_ < var_267_3 + var_267_8 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_264_1:InitPlayNodeList()
	end,
	Play319811065 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 319811065
		arg_268_1.duration_ = 7.47

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play319811066(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			if 1 < arg_268_1.time_ and arg_268_1.time_ <= 1 + arg_271_0 then
				local var_271_0 = arg_268_1.bgs_.ST72a

				arg_268_1.bgs_.ST72a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_271_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_271_1 = var_271_0:GetComponent("SpriteRenderer")

				if var_271_1 and var_271_1.sprite then
					local var_271_2 = 2 * (var_271_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_271_0.transform.localScale = Vector3.New(var_271_2 / var_271_1.sprite.bounds.size.y < var_271_2 * manager.ui.mainCameraCom_.aspect / var_271_1.sprite.bounds.size.x and var_271_2 * manager.ui.mainCameraCom_.aspect / var_271_1.sprite.bounds.size.x or var_271_2 / var_271_1.sprite.bounds.size.y, var_271_2 / var_271_1.sprite.bounds.size.y < var_271_2 * manager.ui.mainCameraCom_.aspect / var_271_1.sprite.bounds.size.x and var_271_2 * manager.ui.mainCameraCom_.aspect / var_271_1.sprite.bounds.size.x or var_271_2 / var_271_1.sprite.bounds.size.y, 0)
				end

				for iter_271_0, iter_271_1 in pairs(arg_268_1.bgs_) do
					if iter_271_0 ~= "ST72a" then
						iter_271_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_271_3 = 0

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= var_271_3 + arg_271_0 then
				arg_268_1.mask_.enabled = true
				arg_268_1.mask_.raycastTarget = true

				arg_268_1:SetGaussion(false)
			end

			local var_271_4 = 1

			if var_271_3 <= arg_268_1.time_ and arg_268_1.time_ < var_271_3 + var_271_4 then
				local var_271_5 = Color.New(0, 0, 0)

				var_271_5.a = Mathf.Lerp(0, 1, (arg_268_1.time_ - var_271_3) / var_271_4)
				arg_268_1.mask_.color = var_271_5
			end

			if arg_268_1.time_ >= var_271_3 + var_271_4 and arg_268_1.time_ < var_271_3 + var_271_4 + arg_271_0 then
				local var_271_6 = Color.New(0, 0, 0)

				var_271_6.a = 1
				arg_268_1.mask_.color = var_271_6
			end

			local var_271_7 = 1

			if 1 < arg_268_1.time_ and arg_268_1.time_ <= var_271_7 + arg_271_0 then
				arg_268_1.mask_.enabled = true
				arg_268_1.mask_.raycastTarget = true

				arg_268_1:SetGaussion(false)
			end

			local var_271_8 = 1.66666666666667

			if var_271_7 <= arg_268_1.time_ and arg_268_1.time_ < var_271_7 + var_271_8 then
				local var_271_9 = Color.New(0, 0, 0)

				var_271_9.a = Mathf.Lerp(1, 0, (arg_268_1.time_ - var_271_7) / var_271_8)
				arg_268_1.mask_.color = var_271_9
			end

			if arg_268_1.time_ >= var_271_7 + var_271_8 and arg_268_1.time_ < var_271_7 + var_271_8 + arg_271_0 then
				local var_271_10 = Color.New(0, 0, 0)

				arg_268_1.mask_.enabled = false
				var_271_10.a = 0
				arg_268_1.mask_.color = var_271_10
			end

			if arg_268_1.frameCnt_ <= 1 then
				arg_268_1.dialog_:SetActive(false)
			end

			local var_271_11 = 2.46666666666667
			local var_271_12 = 1.175

			if 2.46666666666667 < arg_268_1.time_ and arg_268_1.time_ <= var_271_11 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0

				arg_268_1.dialog_:SetActive(true)

				arg_268_1.dialogCg_.alpha = 0

				local var_271_13 = LeanTween.value(arg_268_1.dialog_, 0, 1, 0.3)

				var_271_13:setOnUpdate(LuaHelper.FloatAction(function(arg_272_0)
					arg_268_1.dialogCg_.alpha = arg_272_0
				end))
				var_271_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_268_1.dialog_)
					var_271_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_268_1.duration_ = arg_268_1.duration_ + 0.3

				SetActive(arg_268_1.leftNameGo_, false)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_14 = arg_268_1:FormatText(arg_268_1:GetWordFromCfg(319811065).content)

				arg_268_1.text_.text = var_271_14

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_16 = 47 <= 0 and var_271_12 or var_271_12 * (utf8.len(var_271_14) / 47)

				if (47 <= 0 and var_271_12 or var_271_12 * (utf8.len(var_271_14) / 47)) > 0 and var_271_12 < var_271_16 then
					arg_268_1.talkMaxDuration = var_271_16
					var_271_11 = var_271_11 + 0.3

					if var_271_16 + var_271_11 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_16 + var_271_11
					end
				end

				arg_268_1.text_.text = var_271_14
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)
				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_17 = var_271_11 + 0.3
			local var_271_18 = math.max(var_271_12, arg_268_1.talkMaxDuration)

			if var_271_11 + 0.3 <= arg_268_1.time_ and arg_268_1.time_ < var_271_17 + var_271_18 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_17) / var_271_18

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_17 + var_271_18 and arg_268_1.time_ < var_271_17 + var_271_18 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play319811066 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 319811066
		arg_274_1.duration_ = 10.23

		local var_274_0 = {
			zh = 7.333,
			ja = 10.233
		}
		local var_274_1 = manager.audio:GetLocalizationFlag()

		if var_274_0[var_274_1] ~= nil then
			arg_274_1.duration_ = var_274_0[var_274_1]
		end

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play319811067(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1.var_.moveOldPos10058ui_story = arg_274_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_277_0 = 0.001

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_0 then
				arg_274_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_274_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_274_1.time_ - 0) / var_277_0)
				arg_274_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_274_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_274_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_274_1.actors_["10058ui_story"].transform.position).z)
				arg_274_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_274_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_274_1.actors_["10058ui_story"].transform.localEulerAngles = arg_274_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_274_1.time_ >= 0 + var_277_0 and arg_274_1.time_ < 0 + var_277_0 + arg_277_0 then
				arg_274_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_274_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_274_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_274_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_274_1.actors_["10058ui_story"].transform.position).z)
				arg_274_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_274_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_274_1.actors_["10058ui_story"].transform.localEulerAngles = arg_274_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_277_1 = arg_274_1.actors_["10058ui_story"]

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 and not isNil(var_277_1) and arg_274_1.var_.characterEffect10058ui_story == nil then
				arg_274_1.var_.characterEffect10058ui_story = var_277_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_2 = 0.200000002980232

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_2 and not isNil(var_277_1) then
				if arg_274_1.var_.characterEffect10058ui_story and not isNil(var_277_1) then
					arg_274_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_274_1.time_ >= 0 + var_277_2 and arg_274_1.time_ < 0 + var_277_2 + arg_277_0 and not isNil(var_277_1) and arg_274_1.var_.characterEffect10058ui_story then
				arg_274_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_1")
			end

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_277_4 = 0
			local var_277_5 = 0.675

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_4 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				arg_274_1.leftNameTxt_.text = arg_274_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_6 = arg_274_1:GetWordFromCfg(319811066)
				local var_277_7 = arg_274_1:FormatText(var_277_6.content)

				arg_274_1.text_.text = var_277_7

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_9 = 27 <= 0 and var_277_5 or var_277_5 * (utf8.len(var_277_7) / 27)

				if (27 <= 0 and var_277_5 or var_277_5 * (utf8.len(var_277_7) / 27)) > 0 and var_277_5 < var_277_9 then
					arg_274_1.talkMaxDuration = var_277_9

					if var_277_9 + var_277_4 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_9 + var_277_4
					end
				end

				arg_274_1.text_.text = var_277_7
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811066", "story_v_out_319811.awb") ~= 0 then
					local var_277_10 = manager.audio:GetVoiceLength("story_v_out_319811", "319811066", "story_v_out_319811.awb") / 1000

					if var_277_10 + var_277_4 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_10 + var_277_4
					end

					if var_277_6.prefab_name ~= "" and arg_274_1.actors_[var_277_6.prefab_name] ~= nil then
						local var_277_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_6.prefab_name].transform, "story_v_out_319811", "319811066", "story_v_out_319811.awb")

						arg_274_1:RecordAudio("319811066", var_277_11)
						arg_274_1:RecordAudio("319811066", var_277_11)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_out_319811", "319811066", "story_v_out_319811.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_out_319811", "319811066", "story_v_out_319811.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_12 = math.max(var_277_5, arg_274_1.talkMaxDuration)

			if var_277_4 <= arg_274_1.time_ and arg_274_1.time_ < var_277_4 + var_277_12 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_4) / var_277_12

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_4 + var_277_12 and arg_274_1.time_ < var_277_4 + var_277_12 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {
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

		arg_274_1:InitPlayNodeList()
	end,
	Play319811067 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 319811067
		arg_278_1.duration_ = 4.7

		local var_278_0 = {
			zh = 2.933,
			ja = 4.7
		}
		local var_278_1 = manager.audio:GetLocalizationFlag()

		if var_278_0[var_278_1] ~= nil then
			arg_278_1.duration_ = var_278_0[var_278_1]
		end

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play319811068(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1.var_.moveOldPos1084ui_story = arg_278_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_281_0 = 0.001

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_0 then
				arg_278_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_278_1.time_ - 0) / var_281_0)
				arg_278_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_278_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_278_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_278_1.actors_["1084ui_story"].transform.position).z)
				arg_278_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_278_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_278_1.actors_["1084ui_story"].transform.localEulerAngles = arg_278_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_278_1.time_ >= 0 + var_281_0 and arg_278_1.time_ < 0 + var_281_0 + arg_281_0 then
				arg_278_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0.7, -0.97, -6)
				arg_278_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_278_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_278_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_278_1.actors_["1084ui_story"].transform.position).z)
				arg_278_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_278_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_278_1.actors_["1084ui_story"].transform.localEulerAngles = arg_278_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_281_1 = arg_278_1.actors_["1084ui_story"]

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 and not isNil(var_281_1) and arg_278_1.var_.characterEffect1084ui_story == nil then
				arg_278_1.var_.characterEffect1084ui_story = var_281_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_281_2 = 0.200000002980232

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_2 and not isNil(var_281_1) then
				if arg_278_1.var_.characterEffect1084ui_story and not isNil(var_281_1) then
					arg_278_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_278_1.time_ >= 0 + var_281_2 and arg_278_1.time_ < 0 + var_281_2 + arg_281_0 and not isNil(var_281_1) and arg_278_1.var_.characterEffect1084ui_story then
				arg_278_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2202cva")
			end

			local var_281_4 = arg_278_1.actors_["10058ui_story"].transform

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1.var_.moveOldPos10058ui_story = var_281_4.localPosition
			end

			local var_281_5 = 0.001

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_5 then
				var_281_4.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos10058ui_story, Vector3.New(-0.7, -0.98, -6.1), (arg_278_1.time_ - 0) / var_281_5)
				var_281_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_281_4.position).x, (manager.ui.mainCamera.transform.position - var_281_4.position).y, (manager.ui.mainCamera.transform.position - var_281_4.position).z)
				var_281_4.localEulerAngles.z = 0
				var_281_4.localEulerAngles.x = 0
				var_281_4.localEulerAngles = var_281_4.localEulerAngles
			end

			if arg_278_1.time_ >= 0 + var_281_5 and arg_278_1.time_ < 0 + var_281_5 + arg_281_0 then
				var_281_4.localPosition = Vector3.New(-0.7, -0.98, -6.1)
				var_281_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_281_4.position).x, (manager.ui.mainCamera.transform.position - var_281_4.position).y, (manager.ui.mainCamera.transform.position - var_281_4.position).z)
				var_281_4.localEulerAngles.z = 0
				var_281_4.localEulerAngles.x = 0
				var_281_4.localEulerAngles = var_281_4.localEulerAngles
			end

			local var_281_6 = arg_278_1.actors_["10058ui_story"]

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 and not isNil(var_281_6) and arg_278_1.var_.characterEffect10058ui_story == nil then
				arg_278_1.var_.characterEffect10058ui_story = var_281_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_281_7 = 0.200000002980232

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_7 and not isNil(var_281_6) then
				if arg_278_1.var_.characterEffect10058ui_story and not isNil(var_281_6) then
					arg_278_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_278_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_278_1.time_ - 0) / var_281_7)
				end
			end

			if arg_278_1.time_ >= 0 + var_281_7 and arg_278_1.time_ < 0 + var_281_7 + arg_281_0 and not isNil(var_281_6) and arg_278_1.var_.characterEffect10058ui_story then
				arg_278_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_278_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_281_8 = 0
			local var_281_9 = 0.425

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_8 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				arg_278_1.leftNameTxt_.text = arg_278_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_10 = arg_278_1:GetWordFromCfg(319811067)
				local var_281_11 = arg_278_1:FormatText(var_281_10.content)

				arg_278_1.text_.text = var_281_11

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_13 = 17 <= 0 and var_281_9 or var_281_9 * (utf8.len(var_281_11) / 17)

				if (17 <= 0 and var_281_9 or var_281_9 * (utf8.len(var_281_11) / 17)) > 0 and var_281_9 < var_281_13 then
					arg_278_1.talkMaxDuration = var_281_13

					if var_281_13 + var_281_8 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_13 + var_281_8
					end
				end

				arg_278_1.text_.text = var_281_11
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811067", "story_v_out_319811.awb") ~= 0 then
					local var_281_14 = manager.audio:GetVoiceLength("story_v_out_319811", "319811067", "story_v_out_319811.awb") / 1000

					if var_281_14 + var_281_8 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_14 + var_281_8
					end

					if var_281_10.prefab_name ~= "" and arg_278_1.actors_[var_281_10.prefab_name] ~= nil then
						local var_281_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_278_1.actors_[var_281_10.prefab_name].transform, "story_v_out_319811", "319811067", "story_v_out_319811.awb")

						arg_278_1:RecordAudio("319811067", var_281_15)
						arg_278_1:RecordAudio("319811067", var_281_15)
					else
						arg_278_1:AudioAction("play", "voice", "story_v_out_319811", "319811067", "story_v_out_319811.awb")
					end

					arg_278_1:RecordHistoryTalkVoice("story_v_out_319811", "319811067", "story_v_out_319811.awb")
				end

				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_16 = math.max(var_281_9, arg_278_1.talkMaxDuration)

			if var_281_8 <= arg_278_1.time_ and arg_278_1.time_ < var_281_8 + var_281_16 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_8) / var_281_16

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_8 + var_281_16 and arg_278_1.time_ < var_281_8 + var_281_16 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {
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

		arg_278_1:InitPlayNodeList()
	end,
	Play319811068 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 319811068
		arg_282_1.duration_ = 4.2

		local var_282_0 = {
			zh = 1.666,
			ja = 4.2
		}
		local var_282_1 = manager.audio:GetLocalizationFlag()

		if var_282_0[var_282_1] ~= nil then
			arg_282_1.duration_ = var_282_0[var_282_1]
		end

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play319811069(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = 0.25

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				arg_282_1.leftNameTxt_.text = arg_282_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_1 = arg_282_1:GetWordFromCfg(319811068)
				local var_285_2 = arg_282_1:FormatText(var_285_1.content)

				arg_282_1.text_.text = var_285_2

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_4 = 10 <= 0 and var_285_0 or var_285_0 * (utf8.len(var_285_2) / 10)

				if (10 <= 0 and var_285_0 or var_285_0 * (utf8.len(var_285_2) / 10)) > 0 and var_285_0 < var_285_4 then
					arg_282_1.talkMaxDuration = var_285_4

					if var_285_4 + 0 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_4 + 0
					end
				end

				arg_282_1.text_.text = var_285_2
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811068", "story_v_out_319811.awb") ~= 0 then
					local var_285_5 = manager.audio:GetVoiceLength("story_v_out_319811", "319811068", "story_v_out_319811.awb") / 1000

					if var_285_5 + 0 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_5 + 0
					end

					if var_285_1.prefab_name ~= "" and arg_282_1.actors_[var_285_1.prefab_name] ~= nil then
						local var_285_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_282_1.actors_[var_285_1.prefab_name].transform, "story_v_out_319811", "319811068", "story_v_out_319811.awb")

						arg_282_1:RecordAudio("319811068", var_285_6)
						arg_282_1:RecordAudio("319811068", var_285_6)
					else
						arg_282_1:AudioAction("play", "voice", "story_v_out_319811", "319811068", "story_v_out_319811.awb")
					end

					arg_282_1:RecordHistoryTalkVoice("story_v_out_319811", "319811068", "story_v_out_319811.awb")
				end

				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_7 = math.max(var_285_0, arg_282_1.talkMaxDuration)

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_7 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - 0) / var_285_7

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= 0 + var_285_7 and arg_282_1.time_ < 0 + var_285_7 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play319811069 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 319811069
		arg_286_1.duration_ = 7.33

		local var_286_0 = {
			zh = 6.6,
			ja = 7.333
		}
		local var_286_1 = manager.audio:GetLocalizationFlag()

		if var_286_0[var_286_1] ~= nil then
			arg_286_1.duration_ = var_286_0[var_286_1]
		end

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play319811070(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1.var_.moveOldPos10058ui_story = arg_286_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_289_0 = 0.001

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_0 then
				arg_286_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_286_1.var_.moveOldPos10058ui_story, Vector3.New(-0.7, -0.98, -6.1), (arg_286_1.time_ - 0) / var_289_0)
				arg_286_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_286_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_286_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_286_1.actors_["10058ui_story"].transform.position).z)
				arg_286_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_286_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_286_1.actors_["10058ui_story"].transform.localEulerAngles = arg_286_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_286_1.time_ >= 0 + var_289_0 and arg_286_1.time_ < 0 + var_289_0 + arg_289_0 then
				arg_286_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(-0.7, -0.98, -6.1)
				arg_286_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_286_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_286_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_286_1.actors_["10058ui_story"].transform.position).z)
				arg_286_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_286_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_286_1.actors_["10058ui_story"].transform.localEulerAngles = arg_286_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_289_1 = arg_286_1.actors_["10058ui_story"]

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 and not isNil(var_289_1) and arg_286_1.var_.characterEffect10058ui_story == nil then
				arg_286_1.var_.characterEffect10058ui_story = var_289_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_289_2 = 0.200000002980232

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_2 and not isNil(var_289_1) then
				if arg_286_1.var_.characterEffect10058ui_story and not isNil(var_289_1) then
					arg_286_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_286_1.time_ >= 0 + var_289_2 and arg_286_1.time_ < 0 + var_289_2 + arg_289_0 and not isNil(var_289_1) and arg_286_1.var_.characterEffect10058ui_story then
				arg_286_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_289_4 = arg_286_1.actors_["1084ui_story"]

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 and not isNil(var_289_4) and arg_286_1.var_.characterEffect1084ui_story == nil then
				arg_286_1.var_.characterEffect1084ui_story = var_289_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_289_5 = 0.200000002980232

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_5 and not isNil(var_289_4) then
				if arg_286_1.var_.characterEffect1084ui_story and not isNil(var_289_4) then
					arg_286_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_286_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_286_1.time_ - 0) / var_289_5)
				end
			end

			if arg_286_1.time_ >= 0 + var_289_5 and arg_286_1.time_ < 0 + var_289_5 + arg_289_0 and not isNil(var_289_4) and arg_286_1.var_.characterEffect1084ui_story then
				arg_286_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_286_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_289_6 = 0
			local var_289_7 = 0.725

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_6 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				arg_286_1.leftNameTxt_.text = arg_286_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_8 = arg_286_1:GetWordFromCfg(319811069)
				local var_289_9 = arg_286_1:FormatText(var_289_8.content)

				arg_286_1.text_.text = var_289_9

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_11 = 29 <= 0 and var_289_7 or var_289_7 * (utf8.len(var_289_9) / 29)

				if (29 <= 0 and var_289_7 or var_289_7 * (utf8.len(var_289_9) / 29)) > 0 and var_289_7 < var_289_11 then
					arg_286_1.talkMaxDuration = var_289_11

					if var_289_11 + var_289_6 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_11 + var_289_6
					end
				end

				arg_286_1.text_.text = var_289_9
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811069", "story_v_out_319811.awb") ~= 0 then
					local var_289_12 = manager.audio:GetVoiceLength("story_v_out_319811", "319811069", "story_v_out_319811.awb") / 1000

					if var_289_12 + var_289_6 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_12 + var_289_6
					end

					if var_289_8.prefab_name ~= "" and arg_286_1.actors_[var_289_8.prefab_name] ~= nil then
						local var_289_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_8.prefab_name].transform, "story_v_out_319811", "319811069", "story_v_out_319811.awb")

						arg_286_1:RecordAudio("319811069", var_289_13)
						arg_286_1:RecordAudio("319811069", var_289_13)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_out_319811", "319811069", "story_v_out_319811.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_out_319811", "319811069", "story_v_out_319811.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_14 = math.max(var_289_7, arg_286_1.talkMaxDuration)

			if var_289_6 <= arg_286_1.time_ and arg_286_1.time_ < var_289_6 + var_289_14 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_6) / var_289_14

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_6 + var_289_14 and arg_286_1.time_ < var_289_6 + var_289_14 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {
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

		arg_286_1:InitPlayNodeList()
	end,
	Play319811070 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 319811070
		arg_290_1.duration_ = 9.37

		local var_290_0 = {
			zh = 6.633,
			ja = 9.366
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
				arg_290_0:Play319811071(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 then
				arg_290_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_2")
			end

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 then
				arg_290_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_293_0 = 0
			local var_293_1 = 0.7

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_0 + arg_293_0 then
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

				local var_293_2 = arg_290_1:GetWordFromCfg(319811070)
				local var_293_3 = arg_290_1:FormatText(var_293_2.content)

				arg_290_1.text_.text = var_293_3

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_5 = 28 <= 0 and var_293_1 or var_293_1 * (utf8.len(var_293_3) / 28)

				if (28 <= 0 and var_293_1 or var_293_1 * (utf8.len(var_293_3) / 28)) > 0 and var_293_1 < var_293_5 then
					arg_290_1.talkMaxDuration = var_293_5

					if var_293_5 + var_293_0 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_5 + var_293_0
					end
				end

				arg_290_1.text_.text = var_293_3
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811070", "story_v_out_319811.awb") ~= 0 then
					local var_293_6 = manager.audio:GetVoiceLength("story_v_out_319811", "319811070", "story_v_out_319811.awb") / 1000

					if var_293_6 + var_293_0 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_6 + var_293_0
					end

					if var_293_2.prefab_name ~= "" and arg_290_1.actors_[var_293_2.prefab_name] ~= nil then
						local var_293_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_290_1.actors_[var_293_2.prefab_name].transform, "story_v_out_319811", "319811070", "story_v_out_319811.awb")

						arg_290_1:RecordAudio("319811070", var_293_7)
						arg_290_1:RecordAudio("319811070", var_293_7)
					else
						arg_290_1:AudioAction("play", "voice", "story_v_out_319811", "319811070", "story_v_out_319811.awb")
					end

					arg_290_1:RecordHistoryTalkVoice("story_v_out_319811", "319811070", "story_v_out_319811.awb")
				end

				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_8 = math.max(var_293_1, arg_290_1.talkMaxDuration)

			if var_293_0 <= arg_290_1.time_ and arg_290_1.time_ < var_293_0 + var_293_8 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_0) / var_293_8

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_0 + var_293_8 and arg_290_1.time_ < var_293_0 + var_293_8 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play319811071 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 319811071
		arg_294_1.duration_ = 5

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play319811072(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 and not isNil(arg_294_1.actors_["10058ui_story"]) and arg_294_1.var_.characterEffect10058ui_story == nil then
				arg_294_1.var_.characterEffect10058ui_story = arg_294_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_297_0 = 0.200000002980232

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_0 and not isNil(arg_294_1.actors_["10058ui_story"]) then
				if arg_294_1.var_.characterEffect10058ui_story and not isNil(arg_294_1.actors_["10058ui_story"]) then
					arg_294_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_294_1.time_ >= 0 + var_297_0 and arg_294_1.time_ < 0 + var_297_0 + arg_297_0 and not isNil(arg_294_1.actors_["10058ui_story"]) and arg_294_1.var_.characterEffect10058ui_story then
				arg_294_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_297_2 = arg_294_1.actors_["1084ui_story"].transform

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1.var_.moveOldPos1084ui_story = var_297_2.localPosition
			end

			local var_297_3 = 0.001

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_3 then
				var_297_2.localPosition = Vector3.Lerp(arg_294_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_294_1.time_ - 0) / var_297_3)
				var_297_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_297_2.position).x, (manager.ui.mainCamera.transform.position - var_297_2.position).y, (manager.ui.mainCamera.transform.position - var_297_2.position).z)
				var_297_2.localEulerAngles.z = 0
				var_297_2.localEulerAngles.x = 0
				var_297_2.localEulerAngles = var_297_2.localEulerAngles
			end

			if arg_294_1.time_ >= 0 + var_297_3 and arg_294_1.time_ < 0 + var_297_3 + arg_297_0 then
				var_297_2.localPosition = Vector3.New(0, 100, 0)
				var_297_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_297_2.position).x, (manager.ui.mainCamera.transform.position - var_297_2.position).y, (manager.ui.mainCamera.transform.position - var_297_2.position).z)
				var_297_2.localEulerAngles.z = 0
				var_297_2.localEulerAngles.x = 0
				var_297_2.localEulerAngles = var_297_2.localEulerAngles
			end

			local var_297_4 = arg_294_1.actors_["10058ui_story"].transform

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1.var_.moveOldPos10058ui_story = var_297_4.localPosition
			end

			local var_297_5 = 0.001

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_5 then
				var_297_4.localPosition = Vector3.Lerp(arg_294_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_294_1.time_ - 0) / var_297_5)
				var_297_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_297_4.position).x, (manager.ui.mainCamera.transform.position - var_297_4.position).y, (manager.ui.mainCamera.transform.position - var_297_4.position).z)
				var_297_4.localEulerAngles.z = 0
				var_297_4.localEulerAngles.x = 0
				var_297_4.localEulerAngles = var_297_4.localEulerAngles
			end

			if arg_294_1.time_ >= 0 + var_297_5 and arg_294_1.time_ < 0 + var_297_5 + arg_297_0 then
				var_297_4.localPosition = Vector3.New(0, 100, 0)
				var_297_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_297_4.position).x, (manager.ui.mainCamera.transform.position - var_297_4.position).y, (manager.ui.mainCamera.transform.position - var_297_4.position).z)
				var_297_4.localEulerAngles.z = 0
				var_297_4.localEulerAngles.x = 0
				var_297_4.localEulerAngles = var_297_4.localEulerAngles
			end

			local var_297_6 = 0
			local var_297_7 = 0.65

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= var_297_6 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, false)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_8 = arg_294_1:FormatText(arg_294_1:GetWordFromCfg(319811071).content)

				arg_294_1.text_.text = var_297_8

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_10 = 26 <= 0 and var_297_7 or var_297_7 * (utf8.len(var_297_8) / 26)

				if (26 <= 0 and var_297_7 or var_297_7 * (utf8.len(var_297_8) / 26)) > 0 and var_297_7 < var_297_10 then
					arg_294_1.talkMaxDuration = var_297_10

					if var_297_10 + var_297_6 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_10 + var_297_6
					end
				end

				arg_294_1.text_.text = var_297_8
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)
				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_11 = math.max(var_297_7, arg_294_1.talkMaxDuration)

			if var_297_6 <= arg_294_1.time_ and arg_294_1.time_ < var_297_6 + var_297_11 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_6) / var_297_11

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_6 + var_297_11 and arg_294_1.time_ < var_297_6 + var_297_11 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {
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

		arg_294_1:InitPlayNodeList()
	end,
	Play319811072 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 319811072
		arg_298_1.duration_ = 5

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play319811073(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 then
				arg_298_1:AudioAction("play", "effect", "se_story_130", "se_story_130_didi", "")
			end

			local var_301_1 = 0
			local var_301_2 = 1.1

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= var_301_1 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, false)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_3 = arg_298_1:FormatText(arg_298_1:GetWordFromCfg(319811072).content)

				arg_298_1.text_.text = var_301_3

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_5 = 44 <= 0 and var_301_2 or var_301_2 * (utf8.len(var_301_3) / 44)

				if (44 <= 0 and var_301_2 or var_301_2 * (utf8.len(var_301_3) / 44)) > 0 and var_301_2 < var_301_5 then
					arg_298_1.talkMaxDuration = var_301_5

					if var_301_5 + var_301_1 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_5 + var_301_1
					end
				end

				arg_298_1.text_.text = var_301_3
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)
				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_6 = math.max(var_301_2, arg_298_1.talkMaxDuration)

			if var_301_1 <= arg_298_1.time_ and arg_298_1.time_ < var_301_1 + var_301_6 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_1) / var_301_6

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_1 + var_301_6 and arg_298_1.time_ < var_301_1 + var_301_6 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	Play319811073 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 319811073
		arg_302_1.duration_ = 6.2

		local var_302_0 = {
			zh = 6.2,
			ja = 6
		}
		local var_302_1 = manager.audio:GetLocalizationFlag()

		if var_302_0[var_302_1] ~= nil then
			arg_302_1.duration_ = var_302_0[var_302_1]
		end

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
			arg_302_1.auto_ = false
		end

		function arg_302_1.playNext_(arg_304_0)
			arg_302_1.onStoryFinished_()
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1.var_.moveOldPos10058ui_story = arg_302_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_305_0 = 0.001

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_0 then
				arg_302_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_302_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_302_1.time_ - 0) / var_305_0)
				arg_302_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_302_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_302_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_302_1.actors_["10058ui_story"].transform.position).z)
				arg_302_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_302_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_302_1.actors_["10058ui_story"].transform.localEulerAngles = arg_302_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_302_1.time_ >= 0 + var_305_0 and arg_302_1.time_ < 0 + var_305_0 + arg_305_0 then
				arg_302_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_302_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_302_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_302_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_302_1.actors_["10058ui_story"].transform.position).z)
				arg_302_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_302_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_302_1.actors_["10058ui_story"].transform.localEulerAngles = arg_302_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_305_1 = arg_302_1.actors_["10058ui_story"]

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 and not isNil(var_305_1) and arg_302_1.var_.characterEffect10058ui_story == nil then
				arg_302_1.var_.characterEffect10058ui_story = var_305_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_305_2 = 0.200000002980232

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_2 and not isNil(var_305_1) then
				if arg_302_1.var_.characterEffect10058ui_story and not isNil(var_305_1) then
					arg_302_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_302_1.time_ >= 0 + var_305_2 and arg_302_1.time_ < 0 + var_305_2 + arg_305_0 and not isNil(var_305_1) and arg_302_1.var_.characterEffect10058ui_story then
				arg_302_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1:AudioAction("stop", "effect", "se_story_130", "se_story_130_didi", "")
			end

			local var_305_5 = 0
			local var_305_6 = 0.625

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= var_305_5 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				arg_302_1.leftNameTxt_.text = arg_302_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_7 = arg_302_1:GetWordFromCfg(319811073)
				local var_305_8 = arg_302_1:FormatText(var_305_7.content)

				arg_302_1.text_.text = var_305_8

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_10 = 25 <= 0 and var_305_6 or var_305_6 * (utf8.len(var_305_8) / 25)

				if (25 <= 0 and var_305_6 or var_305_6 * (utf8.len(var_305_8) / 25)) > 0 and var_305_6 < var_305_10 then
					arg_302_1.talkMaxDuration = var_305_10

					if var_305_10 + var_305_5 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_10 + var_305_5
					end
				end

				arg_302_1.text_.text = var_305_8
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811073", "story_v_out_319811.awb") ~= 0 then
					local var_305_11 = manager.audio:GetVoiceLength("story_v_out_319811", "319811073", "story_v_out_319811.awb") / 1000

					if var_305_11 + var_305_5 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_11 + var_305_5
					end

					if var_305_7.prefab_name ~= "" and arg_302_1.actors_[var_305_7.prefab_name] ~= nil then
						local var_305_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_302_1.actors_[var_305_7.prefab_name].transform, "story_v_out_319811", "319811073", "story_v_out_319811.awb")

						arg_302_1:RecordAudio("319811073", var_305_12)
						arg_302_1:RecordAudio("319811073", var_305_12)
					else
						arg_302_1:AudioAction("play", "voice", "story_v_out_319811", "319811073", "story_v_out_319811.awb")
					end

					arg_302_1:RecordHistoryTalkVoice("story_v_out_319811", "319811073", "story_v_out_319811.awb")
				end

				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_13 = math.max(var_305_6, arg_302_1.talkMaxDuration)

			if var_305_5 <= arg_302_1.time_ and arg_302_1.time_ < var_305_5 + var_305_13 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_5) / var_305_13

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_5 + var_305_13 and arg_302_1.time_ < var_305_5 + var_305_13 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {
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

		arg_302_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I11m",
		"TextureConfig/Background/ST72a",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_319811.awb"
	}
}
