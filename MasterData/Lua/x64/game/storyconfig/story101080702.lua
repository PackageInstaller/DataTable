return {
	Play108072001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 108072001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play108072002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.S0804 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "S0804")
				var_4_0.name = "S0804"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.S0804 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.S0804

				arg_1_1.bgs_.S0804.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "S0804" then
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
				arg_1_1:AudioAction("play", "music", "bgm_story_scheme", "bgm_story_scheme", "bgm_story_scheme.awb")

				local var_4_10 = manager.audio:GetAudioName("bgm_story_scheme", "bgm_story_scheme")

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

			local var_4_11 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_11 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_11 + 2 and arg_1_1.time_ < var_4_11 + 2 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_12 = 2
			local var_4_13 = 0.55

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

				local var_4_15 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(108072001).content)

				arg_1_1.text_.text = var_4_15

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_17 = 22 <= 0 and var_4_13 or var_4_13 * (utf8.len(var_4_15) / 22)

				if (22 <= 0 and var_4_13 or var_4_13 * (utf8.len(var_4_15) / 22)) > 0 and var_4_13 < var_4_17 then
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
	Play108072002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 108072002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play108072003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0.85

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

				local var_11_1 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(108072002).content)

				arg_8_1.text_.text = var_11_1

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_3 = 34 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 34)

				if (34 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 34)) > 0 and var_11_0 < var_11_3 then
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
	Play108072003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 108072003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play108072004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0.725

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

				local var_15_1 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(108072003).content)

				arg_12_1.text_.text = var_15_1

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_3 = 29 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 29)

				if (29 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 29)) > 0 and var_15_0 < var_15_3 then
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
	Play108072004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 108072004
		arg_16_1.duration_ = 6.2

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play108072006(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 2 < arg_16_1.time_ and arg_16_1.time_ <= 2 + arg_19_0 then
				arg_16_1.fswbg_:SetActive(true)
				arg_16_1.dialog_:SetActive(false)

				arg_16_1.fswtw_.percent = 0
				arg_16_1.fswt_.text = arg_16_1:FormatText(arg_16_1:GetWordFromCfg(108072004).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.fswt_)

				arg_16_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_16_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_16_1.fswtw_:SetDirty()

				arg_16_1.typewritterCharCountI18N = 0

				SetActive(arg_16_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_16_1:ShowNextGo(false)
			end

			local var_19_0 = 2.01666666666667

			if 2.01666666666667 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				arg_16_1.var_.oldValueTypewriter = arg_16_1.fswtw_.percent

				SetActive(arg_16_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_16_1:ShowNextGo(false)
			end

			local var_19_1 = 19
			local var_19_2 = 0.96
			local var_19_3, var_19_4 = arg_16_1:GetPercentByPara(arg_16_1:FormatText(arg_16_1:GetWordFromCfg(108072004).content), 1)

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

			local var_19_6 = math.max(0.96, arg_16_1.talkMaxDuration)

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

			local var_19_7 = 2
			local var_19_8 = manager.audio:GetVoiceLength("story_v_out_108072", "108072004", "story_v_out_108072.awb") / 1000

			if var_19_8 > 0 and 4.201 < var_19_8 and var_19_8 + var_19_7 > arg_16_1.duration_ then
				arg_16_1.duration_ = var_19_8 + var_19_7
			end

			if var_19_7 < arg_16_1.time_ and arg_16_1.time_ <= var_19_7 + arg_19_0 then
				arg_16_1:AudioAction("play", "voice", "story_v_out_108072", "108072004", "story_v_out_108072.awb")
			end

			local var_19_10 = 0

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_10 + arg_19_0 then
				arg_16_1.mask_.enabled = true
				arg_16_1.mask_.raycastTarget = true

				arg_16_1:SetGaussion(false)
			end

			local var_19_11 = 2

			if var_19_10 <= arg_16_1.time_ and arg_16_1.time_ < var_19_10 + var_19_11 then
				local var_19_12 = Color.New(0, 0, 0)

				var_19_12.a = Mathf.Lerp(0, 1, (arg_16_1.time_ - var_19_10) / var_19_11)
				arg_16_1.mask_.color = var_19_12
			end

			if arg_16_1.time_ >= var_19_10 + var_19_11 and arg_16_1.time_ < var_19_10 + var_19_11 + arg_19_0 then
				local var_19_13 = Color.New(0, 0, 0)

				var_19_13.a = 1
				arg_16_1.mask_.color = var_19_13
			end

			local var_19_14 = 2

			if 2 < arg_16_1.time_ and arg_16_1.time_ <= var_19_14 + arg_19_0 then
				arg_16_1.mask_.enabled = true
				arg_16_1.mask_.raycastTarget = true

				arg_16_1:SetGaussion(false)
			end

			local var_19_15 = 2

			if var_19_14 <= arg_16_1.time_ and arg_16_1.time_ < var_19_14 + var_19_15 then
				local var_19_16 = Color.New(0, 0, 0)

				var_19_16.a = Mathf.Lerp(1, 0, (arg_16_1.time_ - var_19_14) / var_19_15)
				arg_16_1.mask_.color = var_19_16
			end

			if arg_16_1.time_ >= var_19_14 + var_19_15 and arg_16_1.time_ < var_19_14 + var_19_15 + arg_19_0 then
				local var_19_17 = Color.New(0, 0, 0)

				arg_16_1.mask_.enabled = false
				var_19_17.a = 0
				arg_16_1.mask_.color = var_19_17
			end

			local var_19_18 = "S0809"

			if arg_16_1.bgs_.S0809 == nil then
				local var_19_19 = Object.Instantiate(arg_16_1.paintGo_)

				var_19_19:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_19_18)
				var_19_19.name = var_19_18
				var_19_19.transform.parent = arg_16_1.stage_.transform
				var_19_19.transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.bgs_[var_19_18] = var_19_19
			end

			if 2 < arg_16_1.time_ and arg_16_1.time_ <= 2 + arg_19_0 then
				local var_19_20 = arg_16_1.bgs_.S0809

				arg_16_1.bgs_.S0809.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_19_20.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_19_21 = var_19_20:GetComponent("SpriteRenderer")

				if var_19_21 and var_19_21.sprite then
					local var_19_22 = 2 * (var_19_20.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_19_20.transform.localScale = Vector3.New(var_19_22 / var_19_21.sprite.bounds.size.y < var_19_22 * manager.ui.mainCameraCom_.aspect / var_19_21.sprite.bounds.size.x and var_19_22 * manager.ui.mainCameraCom_.aspect / var_19_21.sprite.bounds.size.x or var_19_22 / var_19_21.sprite.bounds.size.y, var_19_22 / var_19_21.sprite.bounds.size.y < var_19_22 * manager.ui.mainCameraCom_.aspect / var_19_21.sprite.bounds.size.x and var_19_22 * manager.ui.mainCameraCom_.aspect / var_19_21.sprite.bounds.size.x or var_19_22 / var_19_21.sprite.bounds.size.y, 0)
				end

				for iter_19_0, iter_19_1 in pairs(arg_16_1.bgs_) do
					if iter_19_0 ~= "S0809" then
						iter_19_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play108072006 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 108072006
		arg_20_1.duration_ = 3.05

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play108072007(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.oldValueTypewriter = arg_20_1.fswtw_.percent

				SetActive(arg_20_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_20_1:ShowNextGo(false)
			end

			local var_23_0 = 13
			local var_23_1 = 0.66
			local var_23_2, var_23_3 = arg_20_1:GetPercentByPara(arg_20_1:FormatText(arg_20_1:GetWordFromCfg(108072004).content), 2)

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0

				local var_23_4 = var_23_0 <= 0 and var_23_1 or var_23_1 * ((var_23_3 - arg_20_1.typewritterCharCountI18N) / var_23_0)

				if (var_23_0 <= 0 and var_23_1 or var_23_1 * ((var_23_3 - arg_20_1.typewritterCharCountI18N) / var_23_0)) > 0 and var_23_1 < var_23_4 then
					arg_20_1.talkMaxDuration = var_23_4

					if var_23_4 + 0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_4 + 0
					end
				end
			end

			local var_23_5 = math.max(0.66, arg_20_1.talkMaxDuration)

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_5 then
				arg_20_1.fswtw_.percent = Mathf.Lerp(arg_20_1.var_.oldValueTypewriter, var_23_2, (arg_20_1.time_ - 0) / var_23_5)
				arg_20_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_20_1.fswtw_:SetDirty()
			end

			if arg_20_1.time_ >= 0 + var_23_5 and arg_20_1.time_ < 0 + var_23_5 + arg_23_0 then
				arg_20_1.fswtw_.percent = var_23_2

				arg_20_1.fswtw_:SetDirty()
				arg_20_1:ShowNextGo(true)

				arg_20_1.typewritterCharCountI18N = var_23_3
			end

			local var_23_6 = 0
			local var_23_7 = manager.audio:GetVoiceLength("story_v_out_108072", "108072006", "story_v_out_108072.awb") / 1000

			if var_23_7 > 0 and 3.053 < var_23_7 and var_23_7 + var_23_6 > arg_20_1.duration_ then
				arg_20_1.duration_ = var_23_7 + var_23_6
			end

			if var_23_6 < arg_20_1.time_ and arg_20_1.time_ <= var_23_6 + arg_23_0 then
				arg_20_1:AudioAction("play", "voice", "story_v_out_108072", "108072006", "story_v_out_108072.awb")
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play108072007 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 108072007
		arg_24_1.duration_ = 8.4

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play108072008(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.oldValueTypewriter = arg_24_1.fswtw_.percent

				SetActive(arg_24_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_24_1:ShowNextGo(false)
			end

			local var_27_0 = 40
			local var_27_1 = 2.28
			local var_27_2, var_27_3 = arg_24_1:GetPercentByPara(arg_24_1:FormatText(arg_24_1:GetWordFromCfg(108072004).content), 3)

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0

				local var_27_4 = var_27_0 <= 0 and var_27_1 or var_27_1 * ((var_27_3 - arg_24_1.typewritterCharCountI18N) / var_27_0)

				if (var_27_0 <= 0 and var_27_1 or var_27_1 * ((var_27_3 - arg_24_1.typewritterCharCountI18N) / var_27_0)) > 0 and var_27_1 < var_27_4 then
					arg_24_1.talkMaxDuration = var_27_4

					if var_27_4 + 0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_4 + 0
					end
				end
			end

			local var_27_5 = math.max(2.28, arg_24_1.talkMaxDuration)

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_5 then
				arg_24_1.fswtw_.percent = Mathf.Lerp(arg_24_1.var_.oldValueTypewriter, var_27_2, (arg_24_1.time_ - 0) / var_27_5)
				arg_24_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_24_1.fswtw_:SetDirty()
			end

			if arg_24_1.time_ >= 0 + var_27_5 and arg_24_1.time_ < 0 + var_27_5 + arg_27_0 then
				arg_24_1.fswtw_.percent = var_27_2

				arg_24_1.fswtw_:SetDirty()
				arg_24_1:ShowNextGo(true)

				arg_24_1.typewritterCharCountI18N = var_27_3
			end

			local var_27_6 = 0
			local var_27_7 = manager.audio:GetVoiceLength("story_v_out_108072", "108072007", "story_v_out_108072.awb") / 1000

			if var_27_7 > 0 and 8.396 < var_27_7 and var_27_7 + var_27_6 > arg_24_1.duration_ then
				arg_24_1.duration_ = var_27_7 + var_27_6
			end

			if var_27_6 < arg_24_1.time_ and arg_24_1.time_ <= var_27_6 + arg_27_0 then
				arg_24_1:AudioAction("play", "voice", "story_v_out_108072", "108072007", "story_v_out_108072.awb")
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play108072008 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 108072008
		arg_28_1.duration_ = 5.87

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play108072009(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.oldValueTypewriter = arg_28_1.fswtw_.percent

				SetActive(arg_28_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_28_1:ShowNextGo(false)
			end

			local var_31_0 = 26
			local var_31_1 = 1.5
			local var_31_2, var_31_3 = arg_28_1:GetPercentByPara(arg_28_1:FormatText(arg_28_1:GetWordFromCfg(108072004).content), 4)

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0

				local var_31_4 = var_31_0 <= 0 and var_31_1 or var_31_1 * ((var_31_3 - arg_28_1.typewritterCharCountI18N) / var_31_0)

				if (var_31_0 <= 0 and var_31_1 or var_31_1 * ((var_31_3 - arg_28_1.typewritterCharCountI18N) / var_31_0)) > 0 and var_31_1 < var_31_4 then
					arg_28_1.talkMaxDuration = var_31_4

					if var_31_4 + 0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_4 + 0
					end
				end
			end

			local var_31_5 = math.max(1.5, arg_28_1.talkMaxDuration)

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_5 then
				arg_28_1.fswtw_.percent = Mathf.Lerp(arg_28_1.var_.oldValueTypewriter, var_31_2, (arg_28_1.time_ - 0) / var_31_5)
				arg_28_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_28_1.fswtw_:SetDirty()
			end

			if arg_28_1.time_ >= 0 + var_31_5 and arg_28_1.time_ < 0 + var_31_5 + arg_31_0 then
				arg_28_1.fswtw_.percent = var_31_2

				arg_28_1.fswtw_:SetDirty()
				arg_28_1:ShowNextGo(true)

				arg_28_1.typewritterCharCountI18N = var_31_3
			end

			local var_31_6 = 0
			local var_31_7 = manager.audio:GetVoiceLength("story_v_out_108072", "108072008", "story_v_out_108072.awb") / 1000

			if var_31_7 > 0 and 5.866 < var_31_7 and var_31_7 + var_31_6 > arg_28_1.duration_ then
				arg_28_1.duration_ = var_31_7 + var_31_6
			end

			if var_31_6 < arg_28_1.time_ and arg_28_1.time_ <= var_31_6 + arg_31_0 then
				arg_28_1:AudioAction("play", "voice", "story_v_out_108072", "108072008", "story_v_out_108072.awb")
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play108072009 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 108072009
		arg_32_1.duration_ = 2.6

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play108072010(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.oldValueTypewriter = arg_32_1.fswtw_.percent

				SetActive(arg_32_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_32_1:ShowNextGo(false)
			end

			local var_35_0 = 15
			local var_35_1 = 0.72
			local var_35_2, var_35_3 = arg_32_1:GetPercentByPara(arg_32_1:FormatText(arg_32_1:GetWordFromCfg(108072004).content), 5)

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0

				local var_35_4 = var_35_0 <= 0 and var_35_1 or var_35_1 * ((var_35_3 - arg_32_1.typewritterCharCountI18N) / var_35_0)

				if (var_35_0 <= 0 and var_35_1 or var_35_1 * ((var_35_3 - arg_32_1.typewritterCharCountI18N) / var_35_0)) > 0 and var_35_1 < var_35_4 then
					arg_32_1.talkMaxDuration = var_35_4

					if var_35_4 + 0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_4 + 0
					end
				end
			end

			local var_35_5 = math.max(0.72, arg_32_1.talkMaxDuration)

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_5 then
				arg_32_1.fswtw_.percent = Mathf.Lerp(arg_32_1.var_.oldValueTypewriter, var_35_2, (arg_32_1.time_ - 0) / var_35_5)
				arg_32_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_32_1.fswtw_:SetDirty()
			end

			if arg_32_1.time_ >= 0 + var_35_5 and arg_32_1.time_ < 0 + var_35_5 + arg_35_0 then
				arg_32_1.fswtw_.percent = var_35_2

				arg_32_1.fswtw_:SetDirty()
				arg_32_1:ShowNextGo(true)

				arg_32_1.typewritterCharCountI18N = var_35_3
			end

			local var_35_6 = 0
			local var_35_7 = manager.audio:GetVoiceLength("story_v_out_108072", "108072009", "story_v_out_108072.awb") / 1000

			if var_35_7 > 0 and 2.598 < var_35_7 and var_35_7 + var_35_6 > arg_32_1.duration_ then
				arg_32_1.duration_ = var_35_7 + var_35_6
			end

			if var_35_6 < arg_32_1.time_ and arg_32_1.time_ <= var_35_6 + arg_35_0 then
				arg_32_1:AudioAction("play", "voice", "story_v_out_108072", "108072009", "story_v_out_108072.awb")
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play108072010 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 108072010
		arg_36_1.duration_ = 13.99

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play108072011(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.oldValueTypewriter = arg_36_1.fswtw_.percent

				SetActive(arg_36_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_36_1:ShowNextGo(false)
			end

			local var_39_0 = 51
			local var_39_1 = 2.28
			local var_39_2, var_39_3 = arg_36_1:GetPercentByPara(arg_36_1:FormatText(arg_36_1:GetWordFromCfg(108072004).content), 6)

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0

				local var_39_4 = var_39_0 <= 0 and var_39_1 or var_39_1 * ((var_39_3 - arg_36_1.typewritterCharCountI18N) / var_39_0)

				if (var_39_0 <= 0 and var_39_1 or var_39_1 * ((var_39_3 - arg_36_1.typewritterCharCountI18N) / var_39_0)) > 0 and var_39_1 < var_39_4 then
					arg_36_1.talkMaxDuration = var_39_4

					if var_39_4 + 0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_4 + 0
					end
				end
			end

			local var_39_5 = math.max(2.28, arg_36_1.talkMaxDuration)

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_5 then
				arg_36_1.fswtw_.percent = Mathf.Lerp(arg_36_1.var_.oldValueTypewriter, var_39_2, (arg_36_1.time_ - 0) / var_39_5)
				arg_36_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_36_1.fswtw_:SetDirty()
			end

			if arg_36_1.time_ >= 0 + var_39_5 and arg_36_1.time_ < 0 + var_39_5 + arg_39_0 then
				arg_36_1.fswtw_.percent = var_39_2

				arg_36_1.fswtw_:SetDirty()
				arg_36_1:ShowNextGo(true)

				arg_36_1.typewritterCharCountI18N = var_39_3
			end

			local var_39_6 = 0
			local var_39_7 = manager.audio:GetVoiceLength("story_v_out_108072", "108072010", "story_v_out_108072.awb") / 1000

			if var_39_7 > 0 and 13.991 < var_39_7 and var_39_7 + var_39_6 > arg_36_1.duration_ then
				arg_36_1.duration_ = var_39_7 + var_39_6
			end

			if var_39_6 < arg_36_1.time_ and arg_36_1.time_ <= var_39_6 + arg_39_0 then
				arg_36_1:AudioAction("play", "voice", "story_v_out_108072", "108072010", "story_v_out_108072.awb")
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play108072011 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 108072011
		arg_40_1.duration_ = 7.98

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play108072013(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.fswbg_:SetActive(true)
				arg_40_1.dialog_:SetActive(false)

				arg_40_1.fswtw_.percent = 0
				arg_40_1.fswt_.text = arg_40_1:FormatText(arg_40_1:GetWordFromCfg(108072011).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.fswt_)

				arg_40_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_40_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_40_1.fswtw_:SetDirty()

				arg_40_1.typewritterCharCountI18N = 0

				SetActive(arg_40_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_40_1:ShowNextGo(false)
			end

			local var_43_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_40_1.time_ and arg_40_1.time_ <= var_43_0 + arg_43_0 then
				arg_40_1.var_.oldValueTypewriter = arg_40_1.fswtw_.percent

				SetActive(arg_40_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_40_1:ShowNextGo(false)
			end

			local var_43_1 = 28
			local var_43_2 = 1.5
			local var_43_3, var_43_4 = arg_40_1:GetPercentByPara(arg_40_1:FormatText(arg_40_1:GetWordFromCfg(108072011).content), 1)

			if var_43_0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0

				local var_43_5 = var_43_1 <= 0 and var_43_2 or var_43_2 * ((var_43_4 - arg_40_1.typewritterCharCountI18N) / var_43_1)

				if (var_43_1 <= 0 and var_43_2 or var_43_2 * ((var_43_4 - arg_40_1.typewritterCharCountI18N) / var_43_1)) > 0 and var_43_2 < var_43_5 then
					arg_40_1.talkMaxDuration = var_43_5

					if var_43_5 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_5 + var_43_0
					end
				end
			end

			local var_43_6 = math.max(1.5, arg_40_1.talkMaxDuration)

			if var_43_0 <= arg_40_1.time_ and arg_40_1.time_ < var_43_0 + var_43_6 then
				arg_40_1.fswtw_.percent = Mathf.Lerp(arg_40_1.var_.oldValueTypewriter, var_43_3, (arg_40_1.time_ - var_43_0) / var_43_6)
				arg_40_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_40_1.fswtw_:SetDirty()
			end

			if arg_40_1.time_ >= var_43_0 + var_43_6 and arg_40_1.time_ < var_43_0 + var_43_6 + arg_43_0 then
				arg_40_1.fswtw_.percent = var_43_3

				arg_40_1.fswtw_:SetDirty()
				arg_40_1:ShowNextGo(true)

				arg_40_1.typewritterCharCountI18N = var_43_4
			end

			local var_43_7 = 0
			local var_43_8 = manager.audio:GetVoiceLength("story_v_out_108072", "108072011", "story_v_out_108072.awb") / 1000

			if var_43_8 > 0 and 7.977 < var_43_8 and var_43_8 + var_43_7 > arg_40_1.duration_ then
				arg_40_1.duration_ = var_43_8 + var_43_7
			end

			if var_43_7 < arg_40_1.time_ and arg_40_1.time_ <= var_43_7 + arg_43_0 then
				arg_40_1:AudioAction("play", "voice", "story_v_out_108072", "108072011", "story_v_out_108072.awb")
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play108072013 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 108072013
		arg_44_1.duration_ = 14.42

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play108072014(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.oldValueTypewriter = arg_44_1.fswtw_.percent

				SetActive(arg_44_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_44_1:ShowNextGo(false)
			end

			local var_47_0 = 40
			local var_47_1 = 2.22
			local var_47_2, var_47_3 = arg_44_1:GetPercentByPara(arg_44_1:FormatText(arg_44_1:GetWordFromCfg(108072011).content), 2)

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0

				local var_47_4 = var_47_0 <= 0 and var_47_1 or var_47_1 * ((var_47_3 - arg_44_1.typewritterCharCountI18N) / var_47_0)

				if (var_47_0 <= 0 and var_47_1 or var_47_1 * ((var_47_3 - arg_44_1.typewritterCharCountI18N) / var_47_0)) > 0 and var_47_1 < var_47_4 then
					arg_44_1.talkMaxDuration = var_47_4

					if var_47_4 + 0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_4 + 0
					end
				end
			end

			local var_47_5 = math.max(2.22, arg_44_1.talkMaxDuration)

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_5 then
				arg_44_1.fswtw_.percent = Mathf.Lerp(arg_44_1.var_.oldValueTypewriter, var_47_2, (arg_44_1.time_ - 0) / var_47_5)
				arg_44_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_44_1.fswtw_:SetDirty()
			end

			if arg_44_1.time_ >= 0 + var_47_5 and arg_44_1.time_ < 0 + var_47_5 + arg_47_0 then
				arg_44_1.fswtw_.percent = var_47_2

				arg_44_1.fswtw_:SetDirty()
				arg_44_1:ShowNextGo(true)

				arg_44_1.typewritterCharCountI18N = var_47_3
			end

			local var_47_6 = 0
			local var_47_7 = manager.audio:GetVoiceLength("story_v_out_108072", "108072013", "story_v_out_108072.awb") / 1000

			if var_47_7 > 0 and 14.425 < var_47_7 and var_47_7 + var_47_6 > arg_44_1.duration_ then
				arg_44_1.duration_ = var_47_7 + var_47_6
			end

			if var_47_6 < arg_44_1.time_ and arg_44_1.time_ <= var_47_6 + arg_47_0 then
				arg_44_1:AudioAction("play", "voice", "story_v_out_108072", "108072013", "story_v_out_108072.awb")
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play108072014 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 108072014
		arg_48_1.duration_ = 5.56

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play108072015(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.oldValueTypewriter = arg_48_1.fswtw_.percent

				SetActive(arg_48_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_48_1:ShowNextGo(false)
			end

			local var_51_0 = 20
			local var_51_1 = 1.08
			local var_51_2, var_51_3 = arg_48_1:GetPercentByPara(arg_48_1:FormatText(arg_48_1:GetWordFromCfg(108072011).content), 3)

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0

				local var_51_4 = var_51_0 <= 0 and var_51_1 or var_51_1 * ((var_51_3 - arg_48_1.typewritterCharCountI18N) / var_51_0)

				if (var_51_0 <= 0 and var_51_1 or var_51_1 * ((var_51_3 - arg_48_1.typewritterCharCountI18N) / var_51_0)) > 0 and var_51_1 < var_51_4 then
					arg_48_1.talkMaxDuration = var_51_4

					if var_51_4 + 0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_4 + 0
					end
				end
			end

			local var_51_5 = math.max(1.08, arg_48_1.talkMaxDuration)

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_5 then
				arg_48_1.fswtw_.percent = Mathf.Lerp(arg_48_1.var_.oldValueTypewriter, var_51_2, (arg_48_1.time_ - 0) / var_51_5)
				arg_48_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_48_1.fswtw_:SetDirty()
			end

			if arg_48_1.time_ >= 0 + var_51_5 and arg_48_1.time_ < 0 + var_51_5 + arg_51_0 then
				arg_48_1.fswtw_.percent = var_51_2

				arg_48_1.fswtw_:SetDirty()
				arg_48_1:ShowNextGo(true)

				arg_48_1.typewritterCharCountI18N = var_51_3
			end

			local var_51_6 = 0
			local var_51_7 = manager.audio:GetVoiceLength("story_v_out_108072", "108072014", "story_v_out_108072.awb") / 1000

			if var_51_7 > 0 and 5.56 < var_51_7 and var_51_7 + var_51_6 > arg_48_1.duration_ then
				arg_48_1.duration_ = var_51_7 + var_51_6
			end

			if var_51_6 < arg_48_1.time_ and arg_48_1.time_ <= var_51_6 + arg_51_0 then
				arg_48_1:AudioAction("play", "voice", "story_v_out_108072", "108072014", "story_v_out_108072.awb")
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play108072015 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 108072015
		arg_52_1.duration_ = 10.19

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play108072017(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.var_.oldValueTypewriter = arg_52_1.fswtw_.percent

				SetActive(arg_52_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_52_1:ShowNextGo(false)
			end

			local var_55_0 = 30
			local var_55_1 = 1.68
			local var_55_2, var_55_3 = arg_52_1:GetPercentByPara(arg_52_1:FormatText(arg_52_1:GetWordFromCfg(108072011).content), 4)

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0

				local var_55_4 = var_55_0 <= 0 and var_55_1 or var_55_1 * ((var_55_3 - arg_52_1.typewritterCharCountI18N) / var_55_0)

				if (var_55_0 <= 0 and var_55_1 or var_55_1 * ((var_55_3 - arg_52_1.typewritterCharCountI18N) / var_55_0)) > 0 and var_55_1 < var_55_4 then
					arg_52_1.talkMaxDuration = var_55_4

					if var_55_4 + 0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_4 + 0
					end
				end
			end

			local var_55_5 = math.max(1.68, arg_52_1.talkMaxDuration)

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_5 then
				arg_52_1.fswtw_.percent = Mathf.Lerp(arg_52_1.var_.oldValueTypewriter, var_55_2, (arg_52_1.time_ - 0) / var_55_5)
				arg_52_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_52_1.fswtw_:SetDirty()
			end

			if arg_52_1.time_ >= 0 + var_55_5 and arg_52_1.time_ < 0 + var_55_5 + arg_55_0 then
				arg_52_1.fswtw_.percent = var_55_2

				arg_52_1.fswtw_:SetDirty()
				arg_52_1:ShowNextGo(true)

				arg_52_1.typewritterCharCountI18N = var_55_3
			end

			local var_55_6 = 0
			local var_55_7 = manager.audio:GetVoiceLength("story_v_out_108072", "108072015", "story_v_out_108072.awb") / 1000

			if var_55_7 > 0 and 10.19 < var_55_7 and var_55_7 + var_55_6 > arg_52_1.duration_ then
				arg_52_1.duration_ = var_55_7 + var_55_6
			end

			if var_55_6 < arg_52_1.time_ and arg_52_1.time_ <= var_55_6 + arg_55_0 then
				arg_52_1:AudioAction("play", "voice", "story_v_out_108072", "108072015", "story_v_out_108072.awb")
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play108072017 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 108072017
		arg_56_1.duration_ = 12.87

		local var_56_0 = {
			ja = 11.266,
			ko = 8.633,
			zh = 9.766,
			en = 12.866
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
				arg_56_0:Play108072018(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 2 < arg_56_1.time_ and arg_56_1.time_ <= 2 + arg_59_0 then
				local var_59_0 = arg_56_1.bgs_.S0804

				arg_56_1.bgs_.S0804.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_59_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_59_1 = var_59_0:GetComponent("SpriteRenderer")

				if var_59_1 and var_59_1.sprite then
					local var_59_2 = 2 * (var_59_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_59_0.transform.localScale = Vector3.New(var_59_2 / var_59_1.sprite.bounds.size.y < var_59_2 * manager.ui.mainCameraCom_.aspect / var_59_1.sprite.bounds.size.x and var_59_2 * manager.ui.mainCameraCom_.aspect / var_59_1.sprite.bounds.size.x or var_59_2 / var_59_1.sprite.bounds.size.y, var_59_2 / var_59_1.sprite.bounds.size.y < var_59_2 * manager.ui.mainCameraCom_.aspect / var_59_1.sprite.bounds.size.x and var_59_2 * manager.ui.mainCameraCom_.aspect / var_59_1.sprite.bounds.size.x or var_59_2 / var_59_1.sprite.bounds.size.y, 0)
				end

				for iter_59_0, iter_59_1 in pairs(arg_56_1.bgs_) do
					if iter_59_0 ~= "S0804" then
						iter_59_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.fswbg_:SetActive(false)
				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_56_1:ShowNextGo(false)
			end

			local var_59_3 = 0

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_3 + arg_59_0 then
				arg_56_1.mask_.enabled = true
				arg_56_1.mask_.raycastTarget = true

				arg_56_1:SetGaussion(false)
			end

			local var_59_4 = 2

			if var_59_3 <= arg_56_1.time_ and arg_56_1.time_ < var_59_3 + var_59_4 then
				local var_59_5 = Color.New(0, 0, 0)

				var_59_5.a = Mathf.Lerp(0, 1, (arg_56_1.time_ - var_59_3) / var_59_4)
				arg_56_1.mask_.color = var_59_5
			end

			if arg_56_1.time_ >= var_59_3 + var_59_4 and arg_56_1.time_ < var_59_3 + var_59_4 + arg_59_0 then
				local var_59_6 = Color.New(0, 0, 0)

				var_59_6.a = 1
				arg_56_1.mask_.color = var_59_6
			end

			local var_59_7 = 2

			if 2 < arg_56_1.time_ and arg_56_1.time_ <= var_59_7 + arg_59_0 then
				arg_56_1.mask_.enabled = true
				arg_56_1.mask_.raycastTarget = true

				arg_56_1:SetGaussion(false)
			end

			local var_59_8 = 2

			if var_59_7 <= arg_56_1.time_ and arg_56_1.time_ < var_59_7 + var_59_8 then
				local var_59_9 = Color.New(0, 0, 0)

				var_59_9.a = Mathf.Lerp(1, 0, (arg_56_1.time_ - var_59_7) / var_59_8)
				arg_56_1.mask_.color = var_59_9
			end

			if arg_56_1.time_ >= var_59_7 + var_59_8 and arg_56_1.time_ < var_59_7 + var_59_8 + arg_59_0 then
				local var_59_10 = Color.New(0, 0, 0)

				arg_56_1.mask_.enabled = false
				var_59_10.a = 0
				arg_56_1.mask_.color = var_59_10
			end

			if arg_56_1.frameCnt_ <= 1 then
				arg_56_1.dialog_:SetActive(false)
			end

			local var_59_11 = 4
			local var_59_12 = 0.225

			if 4 < arg_56_1.time_ and arg_56_1.time_ <= var_59_11 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0

				arg_56_1.dialog_:SetActive(true)

				arg_56_1.dialogCg_.alpha = 0

				local var_59_13 = LeanTween.value(arg_56_1.dialog_, 0, 1, 0.3)

				var_59_13:setOnUpdate(LuaHelper.FloatAction(function(arg_60_0)
					arg_56_1.dialogCg_.alpha = arg_60_0
				end))
				var_59_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_56_1.dialog_)
					var_59_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_56_1.duration_ = arg_56_1.duration_ + 0.3

				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[96].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_14 = arg_56_1:GetWordFromCfg(108072017)
				local var_59_15 = arg_56_1:FormatText(var_59_14.content)

				arg_56_1.text_.text = var_59_15

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_17 = 9 <= 0 and var_59_12 or var_59_12 * (utf8.len(var_59_15) / 9)

				if (9 <= 0 and var_59_12 or var_59_12 * (utf8.len(var_59_15) / 9)) > 0 and var_59_12 < var_59_17 then
					arg_56_1.talkMaxDuration = var_59_17
					var_59_11 = var_59_11 + 0.3

					if var_59_17 + var_59_11 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_17 + var_59_11
					end
				end

				arg_56_1.text_.text = var_59_15
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108072", "108072017", "story_v_out_108072.awb") ~= 0 then
					local var_59_18 = manager.audio:GetVoiceLength("story_v_out_108072", "108072017", "story_v_out_108072.awb") / 1000

					if var_59_18 + var_59_11 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_18 + var_59_11
					end

					if var_59_14.prefab_name ~= "" and arg_56_1.actors_[var_59_14.prefab_name] ~= nil then
						local var_59_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_14.prefab_name].transform, "story_v_out_108072", "108072017", "story_v_out_108072.awb")

						arg_56_1:RecordAudio("108072017", var_59_19)
						arg_56_1:RecordAudio("108072017", var_59_19)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_108072", "108072017", "story_v_out_108072.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_108072", "108072017", "story_v_out_108072.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_20 = var_59_11 + 0.3
			local var_59_21 = math.max(var_59_12, arg_56_1.talkMaxDuration)

			if var_59_11 + 0.3 <= arg_56_1.time_ and arg_56_1.time_ < var_59_20 + var_59_21 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_20) / var_59_21

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_20 + var_59_21 and arg_56_1.time_ < var_59_20 + var_59_21 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play108072018 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 108072018
		arg_62_1.duration_ = 10.07

		local var_62_0 = {
			ja = 10.066,
			ko = 6.8,
			zh = 6.5,
			en = 7.6
		}
		local var_62_1 = manager.audio:GetLocalizationFlag()

		if var_62_0[var_62_1] ~= nil then
			arg_62_1.duration_ = var_62_0[var_62_1]
		end

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play108072019(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = 0.65

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				arg_62_1.leftNameTxt_.text = arg_62_1:FormatText(StoryNameCfg[96].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_1 = arg_62_1:GetWordFromCfg(108072018)
				local var_65_2 = arg_62_1:FormatText(var_65_1.content)

				arg_62_1.text_.text = var_65_2

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_4 = 18 <= 0 and var_65_0 or var_65_0 * (utf8.len(var_65_2) / 18)

				if (18 <= 0 and var_65_0 or var_65_0 * (utf8.len(var_65_2) / 18)) > 0 and var_65_0 < var_65_4 then
					arg_62_1.talkMaxDuration = var_65_4

					if var_65_4 + 0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_4 + 0
					end
				end

				arg_62_1.text_.text = var_65_2
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108072", "108072018", "story_v_out_108072.awb") ~= 0 then
					local var_65_5 = manager.audio:GetVoiceLength("story_v_out_108072", "108072018", "story_v_out_108072.awb") / 1000

					if var_65_5 + 0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_5 + 0
					end

					if var_65_1.prefab_name ~= "" and arg_62_1.actors_[var_65_1.prefab_name] ~= nil then
						local var_65_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_1.prefab_name].transform, "story_v_out_108072", "108072018", "story_v_out_108072.awb")

						arg_62_1:RecordAudio("108072018", var_65_6)
						arg_62_1:RecordAudio("108072018", var_65_6)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_108072", "108072018", "story_v_out_108072.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_108072", "108072018", "story_v_out_108072.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_7 = math.max(var_65_0, arg_62_1.talkMaxDuration)

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_7 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - 0) / var_65_7

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= 0 + var_65_7 and arg_62_1.time_ < 0 + var_65_7 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play108072019 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 108072019
		arg_66_1.duration_ = 6.33

		local var_66_0 = {
			ja = 5,
			ko = 5.5,
			zh = 6.333,
			en = 6.2
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
				arg_66_0:Play108072020(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = 0.55

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, true)
				arg_66_1.iconController_:SetSelectedState("hero")

				arg_66_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1050")

				arg_66_1.callingController_:SetSelectedState("normal")

				arg_66_1.keyicon_.color = Color.New(1, 1, 1)
				arg_66_1.icon_.color = Color.New(1, 1, 1)

				local var_69_1 = arg_66_1:GetWordFromCfg(108072019)
				local var_69_2 = arg_66_1:FormatText(var_69_1.content)

				arg_66_1.text_.text = var_69_2

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_4 = 22 <= 0 and var_69_0 or var_69_0 * (utf8.len(var_69_2) / 22)

				if (22 <= 0 and var_69_0 or var_69_0 * (utf8.len(var_69_2) / 22)) > 0 and var_69_0 < var_69_4 then
					arg_66_1.talkMaxDuration = var_69_4

					if var_69_4 + 0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_4 + 0
					end
				end

				arg_66_1.text_.text = var_69_2
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108072", "108072019", "story_v_out_108072.awb") ~= 0 then
					local var_69_5 = manager.audio:GetVoiceLength("story_v_out_108072", "108072019", "story_v_out_108072.awb") / 1000

					if var_69_5 + 0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_5 + 0
					end

					if var_69_1.prefab_name ~= "" and arg_66_1.actors_[var_69_1.prefab_name] ~= nil then
						local var_69_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_1.prefab_name].transform, "story_v_out_108072", "108072019", "story_v_out_108072.awb")

						arg_66_1:RecordAudio("108072019", var_69_6)
						arg_66_1:RecordAudio("108072019", var_69_6)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_108072", "108072019", "story_v_out_108072.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_108072", "108072019", "story_v_out_108072.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_7 = math.max(var_69_0, arg_66_1.talkMaxDuration)

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_7 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - 0) / var_69_7

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= 0 + var_69_7 and arg_66_1.time_ < 0 + var_69_7 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play108072020 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 108072020
		arg_70_1.duration_ = 3.37

		local var_70_0 = {
			ja = 2.9,
			ko = 2.9,
			zh = 3.2,
			en = 3.366
		}
		local var_70_1 = manager.audio:GetLocalizationFlag()

		if var_70_0[var_70_1] ~= nil then
			arg_70_1.duration_ = var_70_0[var_70_1]
		end

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play108072021(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = 0.25

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, true)
				arg_70_1.iconController_:SetSelectedState("hero")

				arg_70_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1099")

				arg_70_1.callingController_:SetSelectedState("normal")

				arg_70_1.keyicon_.color = Color.New(1, 1, 1)
				arg_70_1.icon_.color = Color.New(1, 1, 1)

				local var_73_1 = arg_70_1:GetWordFromCfg(108072020)
				local var_73_2 = arg_70_1:FormatText(var_73_1.content)

				arg_70_1.text_.text = var_73_2

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_4 = 10 <= 0 and var_73_0 or var_73_0 * (utf8.len(var_73_2) / 10)

				if (10 <= 0 and var_73_0 or var_73_0 * (utf8.len(var_73_2) / 10)) > 0 and var_73_0 < var_73_4 then
					arg_70_1.talkMaxDuration = var_73_4

					if var_73_4 + 0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_4 + 0
					end
				end

				arg_70_1.text_.text = var_73_2
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108072", "108072020", "story_v_out_108072.awb") ~= 0 then
					local var_73_5 = manager.audio:GetVoiceLength("story_v_out_108072", "108072020", "story_v_out_108072.awb") / 1000

					if var_73_5 + 0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_5 + 0
					end

					if var_73_1.prefab_name ~= "" and arg_70_1.actors_[var_73_1.prefab_name] ~= nil then
						local var_73_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_1.prefab_name].transform, "story_v_out_108072", "108072020", "story_v_out_108072.awb")

						arg_70_1:RecordAudio("108072020", var_73_6)
						arg_70_1:RecordAudio("108072020", var_73_6)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_108072", "108072020", "story_v_out_108072.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_108072", "108072020", "story_v_out_108072.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_7 = math.max(var_73_0, arg_70_1.talkMaxDuration)

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_7 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - 0) / var_73_7

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= 0 + var_73_7 and arg_70_1.time_ < 0 + var_73_7 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play108072021 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 108072021
		arg_74_1.duration_ = 9.8

		local var_74_0 = {
			ja = 8.866,
			ko = 6.5,
			zh = 9.8,
			en = 7
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
				arg_74_0:Play108072022(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0.675

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				arg_74_1.leftNameTxt_.text = arg_74_1:FormatText(StoryNameCfg[96].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_1 = arg_74_1:GetWordFromCfg(108072021)
				local var_77_2 = arg_74_1:FormatText(var_77_1.content)

				arg_74_1.text_.text = var_77_2

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_4 = 27 <= 0 and var_77_0 or var_77_0 * (utf8.len(var_77_2) / 27)

				if (27 <= 0 and var_77_0 or var_77_0 * (utf8.len(var_77_2) / 27)) > 0 and var_77_0 < var_77_4 then
					arg_74_1.talkMaxDuration = var_77_4

					if var_77_4 + 0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_4 + 0
					end
				end

				arg_74_1.text_.text = var_77_2
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108072", "108072021", "story_v_out_108072.awb") ~= 0 then
					local var_77_5 = manager.audio:GetVoiceLength("story_v_out_108072", "108072021", "story_v_out_108072.awb") / 1000

					if var_77_5 + 0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_5 + 0
					end

					if var_77_1.prefab_name ~= "" and arg_74_1.actors_[var_77_1.prefab_name] ~= nil then
						local var_77_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_1.prefab_name].transform, "story_v_out_108072", "108072021", "story_v_out_108072.awb")

						arg_74_1:RecordAudio("108072021", var_77_6)
						arg_74_1:RecordAudio("108072021", var_77_6)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_108072", "108072021", "story_v_out_108072.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_108072", "108072021", "story_v_out_108072.awb")
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
	Play108072022 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 108072022
		arg_78_1.duration_ = 19.3

		local var_78_0 = {
			ja = 19.3,
			ko = 10.333,
			zh = 15.9,
			en = 12.666
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
				arg_78_0:Play108072023(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = 1.075

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				arg_78_1.leftNameTxt_.text = arg_78_1:FormatText(StoryNameCfg[96].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_1 = arg_78_1:GetWordFromCfg(108072022)
				local var_81_2 = arg_78_1:FormatText(var_81_1.content)

				arg_78_1.text_.text = var_81_2

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_4 = 39 <= 0 and var_81_0 or var_81_0 * (utf8.len(var_81_2) / 39)

				if (39 <= 0 and var_81_0 or var_81_0 * (utf8.len(var_81_2) / 39)) > 0 and var_81_0 < var_81_4 then
					arg_78_1.talkMaxDuration = var_81_4

					if var_81_4 + 0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_4 + 0
					end
				end

				arg_78_1.text_.text = var_81_2
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108072", "108072022", "story_v_out_108072.awb") ~= 0 then
					local var_81_5 = manager.audio:GetVoiceLength("story_v_out_108072", "108072022", "story_v_out_108072.awb") / 1000

					if var_81_5 + 0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_5 + 0
					end

					if var_81_1.prefab_name ~= "" and arg_78_1.actors_[var_81_1.prefab_name] ~= nil then
						local var_81_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_1.prefab_name].transform, "story_v_out_108072", "108072022", "story_v_out_108072.awb")

						arg_78_1:RecordAudio("108072022", var_81_6)
						arg_78_1:RecordAudio("108072022", var_81_6)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_108072", "108072022", "story_v_out_108072.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_108072", "108072022", "story_v_out_108072.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_7 = math.max(var_81_0, arg_78_1.talkMaxDuration)

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_7 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - 0) / var_81_7

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= 0 + var_81_7 and arg_78_1.time_ < 0 + var_81_7 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play108072023 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 108072023
		arg_82_1.duration_ = 8.73

		local var_82_0 = {
			ja = 8.2,
			ko = 7.4,
			zh = 7.7,
			en = 8.733
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
				arg_82_0:Play108072024(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 0.3

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[96].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_1 = arg_82_1:GetWordFromCfg(108072023)
				local var_85_2 = arg_82_1:FormatText(var_85_1.content)

				arg_82_1.text_.text = var_85_2

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_4 = 12 <= 0 and var_85_0 or var_85_0 * (utf8.len(var_85_2) / 12)

				if (12 <= 0 and var_85_0 or var_85_0 * (utf8.len(var_85_2) / 12)) > 0 and var_85_0 < var_85_4 then
					arg_82_1.talkMaxDuration = var_85_4

					if var_85_4 + 0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_4 + 0
					end
				end

				arg_82_1.text_.text = var_85_2
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108072", "108072023", "story_v_out_108072.awb") ~= 0 then
					local var_85_5 = manager.audio:GetVoiceLength("story_v_out_108072", "108072023", "story_v_out_108072.awb") / 1000

					if var_85_5 + 0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_5 + 0
					end

					if var_85_1.prefab_name ~= "" and arg_82_1.actors_[var_85_1.prefab_name] ~= nil then
						local var_85_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_1.prefab_name].transform, "story_v_out_108072", "108072023", "story_v_out_108072.awb")

						arg_82_1:RecordAudio("108072023", var_85_6)
						arg_82_1:RecordAudio("108072023", var_85_6)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_108072", "108072023", "story_v_out_108072.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_108072", "108072023", "story_v_out_108072.awb")
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
	Play108072024 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 108072024
		arg_86_1.duration_ = 13.4

		local var_86_0 = {
			ja = 13.4,
			ko = 9.866,
			zh = 11.233,
			en = 8.6
		}
		local var_86_1 = manager.audio:GetLocalizationFlag()

		if var_86_0[var_86_1] ~= nil then
			arg_86_1.duration_ = var_86_0[var_86_1]
		end

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play108072025(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = 0.425

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[96].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_1 = arg_86_1:GetWordFromCfg(108072024)
				local var_89_2 = arg_86_1:FormatText(var_89_1.content)

				arg_86_1.text_.text = var_89_2

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_4 = 17 <= 0 and var_89_0 or var_89_0 * (utf8.len(var_89_2) / 17)

				if (17 <= 0 and var_89_0 or var_89_0 * (utf8.len(var_89_2) / 17)) > 0 and var_89_0 < var_89_4 then
					arg_86_1.talkMaxDuration = var_89_4

					if var_89_4 + 0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_4 + 0
					end
				end

				arg_86_1.text_.text = var_89_2
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108072", "108072024", "story_v_out_108072.awb") ~= 0 then
					local var_89_5 = manager.audio:GetVoiceLength("story_v_out_108072", "108072024", "story_v_out_108072.awb") / 1000

					if var_89_5 + 0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_5 + 0
					end

					if var_89_1.prefab_name ~= "" and arg_86_1.actors_[var_89_1.prefab_name] ~= nil then
						local var_89_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_1.prefab_name].transform, "story_v_out_108072", "108072024", "story_v_out_108072.awb")

						arg_86_1:RecordAudio("108072024", var_89_6)
						arg_86_1:RecordAudio("108072024", var_89_6)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_108072", "108072024", "story_v_out_108072.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_108072", "108072024", "story_v_out_108072.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_7 = math.max(var_89_0, arg_86_1.talkMaxDuration)

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_7 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - 0) / var_89_7

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= 0 + var_89_7 and arg_86_1.time_ < 0 + var_89_7 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play108072025 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 108072025
		arg_90_1.duration_ = 2.87

		local var_90_0 = {
			ja = 1.333,
			ko = 2.866,
			zh = 1.4,
			en = 1.5
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
				arg_90_0:Play108072026(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 0.05

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[96].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_1 = arg_90_1:GetWordFromCfg(108072025)
				local var_93_2 = arg_90_1:FormatText(var_93_1.content)

				arg_90_1.text_.text = var_93_2

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_4 = 2 <= 0 and var_93_0 or var_93_0 * (utf8.len(var_93_2) / 2)

				if (2 <= 0 and var_93_0 or var_93_0 * (utf8.len(var_93_2) / 2)) > 0 and var_93_0 < var_93_4 then
					arg_90_1.talkMaxDuration = var_93_4

					if var_93_4 + 0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_4 + 0
					end
				end

				arg_90_1.text_.text = var_93_2
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108072", "108072025", "story_v_out_108072.awb") ~= 0 then
					local var_93_5 = manager.audio:GetVoiceLength("story_v_out_108072", "108072025", "story_v_out_108072.awb") / 1000

					if var_93_5 + 0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_5 + 0
					end

					if var_93_1.prefab_name ~= "" and arg_90_1.actors_[var_93_1.prefab_name] ~= nil then
						local var_93_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_1.prefab_name].transform, "story_v_out_108072", "108072025", "story_v_out_108072.awb")

						arg_90_1:RecordAudio("108072025", var_93_6)
						arg_90_1:RecordAudio("108072025", var_93_6)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_108072", "108072025", "story_v_out_108072.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_108072", "108072025", "story_v_out_108072.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_7 = math.max(var_93_0, arg_90_1.talkMaxDuration)

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_7 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - 0) / var_93_7

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= 0 + var_93_7 and arg_90_1.time_ < 0 + var_93_7 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play108072026 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 108072026
		arg_94_1.duration_ = 5

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play108072027(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 0.25

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, false)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_1 = arg_94_1:FormatText(arg_94_1:GetWordFromCfg(108072026).content)

				arg_94_1.text_.text = var_97_1

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_3 = 10 <= 0 and var_97_0 or var_97_0 * (utf8.len(var_97_1) / 10)

				if (10 <= 0 and var_97_0 or var_97_0 * (utf8.len(var_97_1) / 10)) > 0 and var_97_0 < var_97_3 then
					arg_94_1.talkMaxDuration = var_97_3

					if var_97_3 + 0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_3 + 0
					end
				end

				arg_94_1.text_.text = var_97_1
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)
				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_4 = math.max(var_97_0, arg_94_1.talkMaxDuration)

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_4 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - 0) / var_97_4

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= 0 + var_97_4 and arg_94_1.time_ < 0 + var_97_4 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play108072027 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 108072027
		arg_98_1.duration_ = 6.5

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play108072028(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			if arg_98_1.bgs_.C04 == nil then
				local var_101_0 = Object.Instantiate(arg_98_1.paintGo_)

				var_101_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "C04")
				var_101_0.name = "C04"
				var_101_0.transform.parent = arg_98_1.stage_.transform
				var_101_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_98_1.bgs_.C04 = var_101_0
			end

			if 1.5 < arg_98_1.time_ and arg_98_1.time_ <= 1.5 + arg_101_0 then
				local var_101_1 = arg_98_1.bgs_.C04

				arg_98_1.bgs_.C04.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_101_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_101_2 = var_101_1:GetComponent("SpriteRenderer")

				if var_101_2 and var_101_2.sprite then
					local var_101_3 = 2 * (var_101_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_101_1.transform.localScale = Vector3.New(var_101_3 / var_101_2.sprite.bounds.size.y < var_101_3 * manager.ui.mainCameraCom_.aspect / var_101_2.sprite.bounds.size.x and var_101_3 * manager.ui.mainCameraCom_.aspect / var_101_2.sprite.bounds.size.x or var_101_3 / var_101_2.sprite.bounds.size.y, var_101_3 / var_101_2.sprite.bounds.size.y < var_101_3 * manager.ui.mainCameraCom_.aspect / var_101_2.sprite.bounds.size.x and var_101_3 * manager.ui.mainCameraCom_.aspect / var_101_2.sprite.bounds.size.x or var_101_3 / var_101_2.sprite.bounds.size.y, 0)
				end

				for iter_101_0, iter_101_1 in pairs(arg_98_1.bgs_) do
					if iter_101_0 ~= "C04" then
						iter_101_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				local var_101_4 = arg_98_1.bgs_.S0804:GetComponent("SpriteRenderer")

				if var_101_4 then
					arg_98_1.var_.alphaOldValueS0804 = var_101_4.color.a
					arg_98_1.var_.alphaMatValueS0804 = var_101_4
				end

				arg_98_1.var_.alphaOldValueS0804 = 1
			end

			local var_101_5 = 1.5

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_5 then
				if arg_98_1.var_.alphaMatValueS0804 then
					arg_98_1.var_.alphaMatValueS0804.color.a = Mathf.Lerp(arg_98_1.var_.alphaOldValueS0804, 0, (arg_98_1.time_ - 0) / var_101_5)
					arg_98_1.var_.alphaMatValueS0804.color = arg_98_1.var_.alphaMatValueS0804.color
				end
			end

			if arg_98_1.time_ >= 0 + var_101_5 and arg_98_1.time_ < 0 + var_101_5 + arg_101_0 and arg_98_1.var_.alphaMatValueS0804 then
				arg_98_1.var_.alphaMatValueS0804.color.a = 0
				arg_98_1.var_.alphaMatValueS0804.color = arg_98_1.var_.alphaMatValueS0804.color
			end

			if 1.5 < arg_98_1.time_ and arg_98_1.time_ <= 1.5 + arg_101_0 then
				local var_101_6 = arg_98_1.bgs_.C04:GetComponent("SpriteRenderer")

				if var_101_6 then
					arg_98_1.var_.alphaOldValueC04 = var_101_6.color.a
					arg_98_1.var_.alphaMatValueC04 = var_101_6
				end

				arg_98_1.var_.alphaOldValueC04 = 0
			end

			local var_101_7 = 1.5

			if 1.5 <= arg_98_1.time_ and arg_98_1.time_ < 1.5 + var_101_7 then
				if arg_98_1.var_.alphaMatValueC04 then
					arg_98_1.var_.alphaMatValueC04.color.a = Mathf.Lerp(arg_98_1.var_.alphaOldValueC04, 1, (arg_98_1.time_ - 1.5) / var_101_7)
					arg_98_1.var_.alphaMatValueC04.color = arg_98_1.var_.alphaMatValueC04.color
				end
			end

			if arg_98_1.time_ >= 1.5 + var_101_7 and arg_98_1.time_ < 1.5 + var_101_7 + arg_101_0 and arg_98_1.var_.alphaMatValueC04 then
				arg_98_1.var_.alphaMatValueC04.color.a = 1
				arg_98_1.var_.alphaMatValueC04.color = arg_98_1.var_.alphaMatValueC04.color
			end

			local var_101_8 = 0

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_8 + arg_101_0 then
				arg_98_1.allBtn_.enabled = false
			end

			if arg_98_1.time_ >= var_101_8 + 1.5 and arg_98_1.time_ < var_101_8 + 1.5 + arg_101_0 then
				arg_98_1.allBtn_.enabled = true
			end

			local var_101_9 = 1.5
			local var_101_10 = 0.65

			if 1.5 < arg_98_1.time_ and arg_98_1.time_ <= var_101_9 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, false)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_11 = arg_98_1:FormatText(arg_98_1:GetWordFromCfg(108072027).content)

				arg_98_1.text_.text = var_101_11

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_13 = 26 <= 0 and var_101_10 or var_101_10 * (utf8.len(var_101_11) / 26)

				if (26 <= 0 and var_101_10 or var_101_10 * (utf8.len(var_101_11) / 26)) > 0 and var_101_10 < var_101_13 then
					arg_98_1.talkMaxDuration = var_101_13

					if var_101_13 + var_101_9 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_13 + var_101_9
					end
				end

				arg_98_1.text_.text = var_101_11
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_14 = math.max(var_101_10, arg_98_1.talkMaxDuration)

			if var_101_9 <= arg_98_1.time_ and arg_98_1.time_ < var_101_9 + var_101_14 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_9) / var_101_14

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_9 + var_101_14 and arg_98_1.time_ < var_101_9 + var_101_14 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play108072028 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 108072028
		arg_102_1.duration_ = 5

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play108072029(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = 0.675

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, false)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_1 = arg_102_1:FormatText(arg_102_1:GetWordFromCfg(108072028).content)

				arg_102_1.text_.text = var_105_1

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_3 = 27 <= 0 and var_105_0 or var_105_0 * (utf8.len(var_105_1) / 27)

				if (27 <= 0 and var_105_0 or var_105_0 * (utf8.len(var_105_1) / 27)) > 0 and var_105_0 < var_105_3 then
					arg_102_1.talkMaxDuration = var_105_3

					if var_105_3 + 0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_3 + 0
					end
				end

				arg_102_1.text_.text = var_105_1
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)
				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_4 = math.max(var_105_0, arg_102_1.talkMaxDuration)

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_4 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - 0) / var_105_4

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= 0 + var_105_4 and arg_102_1.time_ < 0 + var_105_4 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play108072029 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 108072029
		arg_106_1.duration_ = 7.13

		local var_106_0 = {
			ja = 3.366,
			ko = 6.1,
			zh = 5.933,
			en = 7.133
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
				arg_106_0:Play108072030(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if arg_106_1.actors_["1099ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1099ui_story"))) then
				local var_109_0 = Object.Instantiate(Asset.Load("Char/" .. "1099ui_story"), arg_106_1.stage_.transform)

				var_109_0.name = "1099ui_story"
				var_109_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_106_1.actors_["1099ui_story"] = var_109_0

				local var_109_1 = var_109_0:GetComponentInChildren(typeof(CharacterEffect))

				var_109_1.enabled = true

				local var_109_2 = GameObjectTools.GetOrAddComponent(var_109_0, typeof(DynamicBoneHelper))

				if var_109_2 then
					var_109_2:EnableDynamicBone(false)
				end

				arg_106_1:ShowWeapon(var_109_1.transform, false)

				arg_106_1.var_["1099ui_story" .. "Animator"] = var_109_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_106_1.var_["1099ui_story" .. "Animator"].applyRootMotion = true
				arg_106_1.var_["1099ui_story" .. "LipSync"] = var_109_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_109_3 = arg_106_1.actors_["1099ui_story"].transform

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.var_.moveOldPos1099ui_story = var_109_3.localPosition
			end

			local var_109_4 = 0.001

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_4 then
				var_109_3.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos1099ui_story, Vector3.New(0, -1.08, -5.9), (arg_106_1.time_ - 0) / var_109_4)
				var_109_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_109_3.position).x, (manager.ui.mainCamera.transform.position - var_109_3.position).y, (manager.ui.mainCamera.transform.position - var_109_3.position).z)
				var_109_3.localEulerAngles.z = 0
				var_109_3.localEulerAngles.x = 0
				var_109_3.localEulerAngles = var_109_3.localEulerAngles
			end

			if arg_106_1.time_ >= 0 + var_109_4 and arg_106_1.time_ < 0 + var_109_4 + arg_109_0 then
				var_109_3.localPosition = Vector3.New(0, -1.08, -5.9)
				var_109_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_109_3.position).x, (manager.ui.mainCamera.transform.position - var_109_3.position).y, (manager.ui.mainCamera.transform.position - var_109_3.position).z)
				var_109_3.localEulerAngles.z = 0
				var_109_3.localEulerAngles.x = 0
				var_109_3.localEulerAngles = var_109_3.localEulerAngles
			end

			local var_109_5 = arg_106_1.actors_["1099ui_story"]

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(var_109_5) and arg_106_1.var_.characterEffect1099ui_story == nil then
				arg_106_1.var_.characterEffect1099ui_story = var_109_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_6 = 0.2

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_6 and not isNil(var_109_5) then
				if arg_106_1.var_.characterEffect1099ui_story and not isNil(var_109_5) then
					arg_106_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_106_1.time_ >= 0 + var_109_6 and arg_106_1.time_ < 0 + var_109_6 + arg_109_0 and not isNil(var_109_5) and arg_106_1.var_.characterEffect1099ui_story then
				arg_106_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action4_1")
			end

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_109_8 = 0
			local var_109_9 = 0.725

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_8 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_10 = arg_106_1:GetWordFromCfg(108072029)
				local var_109_11 = arg_106_1:FormatText(var_109_10.content)

				arg_106_1.text_.text = var_109_11

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_13 = 29 <= 0 and var_109_9 or var_109_9 * (utf8.len(var_109_11) / 29)

				if (29 <= 0 and var_109_9 or var_109_9 * (utf8.len(var_109_11) / 29)) > 0 and var_109_9 < var_109_13 then
					arg_106_1.talkMaxDuration = var_109_13

					if var_109_13 + var_109_8 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_13 + var_109_8
					end
				end

				arg_106_1.text_.text = var_109_11
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108072", "108072029", "story_v_out_108072.awb") ~= 0 then
					local var_109_14 = manager.audio:GetVoiceLength("story_v_out_108072", "108072029", "story_v_out_108072.awb") / 1000

					if var_109_14 + var_109_8 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_14 + var_109_8
					end

					if var_109_10.prefab_name ~= "" and arg_106_1.actors_[var_109_10.prefab_name] ~= nil then
						local var_109_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_10.prefab_name].transform, "story_v_out_108072", "108072029", "story_v_out_108072.awb")

						arg_106_1:RecordAudio("108072029", var_109_15)
						arg_106_1:RecordAudio("108072029", var_109_15)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_108072", "108072029", "story_v_out_108072.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_108072", "108072029", "story_v_out_108072.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_16 = math.max(var_109_9, arg_106_1.talkMaxDuration)

			if var_109_8 <= arg_106_1.time_ and arg_106_1.time_ < var_109_8 + var_109_16 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_8) / var_109_16

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_8 + var_109_16 and arg_106_1.time_ < var_109_8 + var_109_16 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_106_1:InitPlayNodeList()
	end,
	Play108072030 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 108072030
		arg_110_1.duration_ = 11.93

		local var_110_0 = {
			ja = 11.933,
			ko = 3.733,
			zh = 5.3,
			en = 5.466
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
			arg_110_1.auto_ = false
		end

		function arg_110_1.playNext_(arg_112_0)
			arg_110_1.onStoryFinished_()
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_113_0 = 0
			local var_113_1 = 0.5

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_0 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_2 = arg_110_1:GetWordFromCfg(108072030)
				local var_113_3 = arg_110_1:FormatText(var_113_2.content)

				arg_110_1.text_.text = var_113_3

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_5 = 20 <= 0 and var_113_1 or var_113_1 * (utf8.len(var_113_3) / 20)

				if (20 <= 0 and var_113_1 or var_113_1 * (utf8.len(var_113_3) / 20)) > 0 and var_113_1 < var_113_5 then
					arg_110_1.talkMaxDuration = var_113_5

					if var_113_5 + var_113_0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_5 + var_113_0
					end
				end

				arg_110_1.text_.text = var_113_3
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108072", "108072030", "story_v_out_108072.awb") ~= 0 then
					local var_113_6 = manager.audio:GetVoiceLength("story_v_out_108072", "108072030", "story_v_out_108072.awb") / 1000

					if var_113_6 + var_113_0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_6 + var_113_0
					end

					if var_113_2.prefab_name ~= "" and arg_110_1.actors_[var_113_2.prefab_name] ~= nil then
						local var_113_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_2.prefab_name].transform, "story_v_out_108072", "108072030", "story_v_out_108072.awb")

						arg_110_1:RecordAudio("108072030", var_113_7)
						arg_110_1:RecordAudio("108072030", var_113_7)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_108072", "108072030", "story_v_out_108072.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_108072", "108072030", "story_v_out_108072.awb")
				end

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
	assets = {
		"TextureConfig/Background/S0804",
		"TextureConfig/Background/S0809",
		"TextureConfig/Background/C04"
	},
	voices = {
		"story_v_out_108072.awb"
	}
}
