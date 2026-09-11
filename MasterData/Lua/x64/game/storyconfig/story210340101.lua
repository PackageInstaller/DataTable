return {
	Play1103401001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1103401001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1103401002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.I11o == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I11o")
				var_4_0.name = "I11o"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.I11o = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.I11o

				arg_1_1.bgs_.I11o.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I11o" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
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

			if 0.5 < arg_1_1.time_ and arg_1_1.time_ <= 0.5 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_0_story_daily_quiet", "bgm_activity_3_0_story_daily_quiet", "bgm_activity_3_0_story_daily_quiet.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_activity_3_0_story_daily_quiet", "bgm_activity_3_0_story_daily_quiet")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_14 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_14

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_14
						arg_1_1.bgmTxt2_.text = var_4_14
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

			if 0.133333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.133333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_16", "se_story_16_street_loop", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_16 = 2
			local var_4_17 = 1.5

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_18 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_18:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_19 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(1103401001).content)

				arg_1_1.text_.text = var_4_19

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_21 = 60 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_19) / 60)

				if (60 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_19) / 60)) > 0 and var_4_17 < var_4_21 then
					arg_1_1.talkMaxDuration = var_4_21
					var_4_16 = var_4_16 + 0.3

					if var_4_21 + var_4_16 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_21 + var_4_16
					end
				end

				arg_1_1.text_.text = var_4_19
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_22 = var_4_16 + 0.3
			local var_4_23 = math.max(var_4_17, arg_1_1.talkMaxDuration)

			if var_4_16 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_22 + var_4_23 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_22) / var_4_23

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_22 + var_4_23 and arg_1_1.time_ < var_4_22 + var_4_23 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play1103401002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 1103401002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play1103401003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 1.35

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(1103401002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 54 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 54)

				if (54 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 54)) > 0 and var_12_0 < var_12_3 then
					arg_9_1.talkMaxDuration = var_12_3

					if var_12_3 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_3 + 0
					end
				end

				arg_9_1.text_.text = var_12_1
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_4 = math.max(var_12_0, arg_9_1.talkMaxDuration)

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - 0) / var_12_4

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play1103401003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 1103401003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play1103401004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:AudioAction("play", "effect", "se_story_128", "se_story_128_handcuffs", "")
			end

			local var_16_1 = 0
			local var_16_2 = 0.106832899153233

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_3 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(1103401003).content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 4 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_3) / 4)

				if (4 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_3) / 4)) > 0 and var_16_2 < var_16_5 then
					arg_13_1.talkMaxDuration = var_16_5

					if var_16_5 + var_16_1 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + var_16_1
					end
				end

				arg_13_1.text_.text = var_16_3
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_6 = math.max(var_16_2, arg_13_1.talkMaxDuration)

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_6 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_1) / var_16_6

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_1 + var_16_6 and arg_13_1.time_ < var_16_1 + var_16_6 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play1103401004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 1103401004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play1103401005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 1

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_1 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(1103401004).content)

				arg_17_1.text_.text = var_20_1

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_3 = 53 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 53)

				if (53 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 53)) > 0 and var_20_0 < var_20_3 then
					arg_17_1.talkMaxDuration = var_20_3

					if var_20_3 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_3 + 0
					end
				end

				arg_17_1.text_.text = var_20_1
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_4 = math.max(var_20_0, arg_17_1.talkMaxDuration)

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - 0) / var_20_4

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play1103401005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 1103401005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play1103401006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 1.575

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_1 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(1103401005).content)

				arg_21_1.text_.text = var_24_1

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_3 = 63 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 63)

				if (63 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 63)) > 0 and var_24_0 < var_24_3 then
					arg_21_1.talkMaxDuration = var_24_3

					if var_24_3 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_3 + 0
					end
				end

				arg_21_1.text_.text = var_24_1
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_4 = math.max(var_24_0, arg_21_1.talkMaxDuration)

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_4 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - 0) / var_24_4

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= 0 + var_24_4 and arg_21_1.time_ < 0 + var_24_4 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play1103401006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 1103401006
		arg_25_1.duration_ = 2.3

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play1103401007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if arg_25_1.actors_["1034ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1034ui_story"))) then
				local var_28_0 = Object.Instantiate(Asset.Load("Char/" .. "1034ui_story"), arg_25_1.stage_.transform)

				var_28_0.name = "1034ui_story"
				var_28_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_25_1.actors_["1034ui_story"] = var_28_0

				local var_28_1 = var_28_0:GetComponentInChildren(typeof(CharacterEffect))

				var_28_1.enabled = true

				local var_28_2 = GameObjectTools.GetOrAddComponent(var_28_0, typeof(DynamicBoneHelper))

				if var_28_2 then
					var_28_2:EnableDynamicBone(false)
				end

				arg_25_1:ShowWeapon(var_28_1.transform, false)

				arg_25_1.var_["1034ui_story" .. "Animator"] = var_28_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_25_1.var_["1034ui_story" .. "Animator"].applyRootMotion = true
				arg_25_1.var_["1034ui_story" .. "LipSync"] = var_28_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_28_3 = arg_25_1.actors_["1034ui_story"].transform

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1034ui_story = var_28_3.localPosition
			end

			local var_28_4 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_4 then
				var_28_3.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1034ui_story, Vector3.New(0, -0.93, -6.08), (arg_25_1.time_ - 0) / var_28_4)
				var_28_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_3.position).x, (manager.ui.mainCamera.transform.position - var_28_3.position).y, (manager.ui.mainCamera.transform.position - var_28_3.position).z)
				var_28_3.localEulerAngles.z = 0
				var_28_3.localEulerAngles.x = 0
				var_28_3.localEulerAngles = var_28_3.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_4 and arg_25_1.time_ < 0 + var_28_4 + arg_28_0 then
				var_28_3.localPosition = Vector3.New(0, -0.93, -6.08)
				var_28_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_3.position).x, (manager.ui.mainCamera.transform.position - var_28_3.position).y, (manager.ui.mainCamera.transform.position - var_28_3.position).z)
				var_28_3.localEulerAngles.z = 0
				var_28_3.localEulerAngles.x = 0
				var_28_3.localEulerAngles = var_28_3.localEulerAngles
			end

			local var_28_5 = arg_25_1.actors_["1034ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_5) and arg_25_1.var_.characterEffect1034ui_story == nil then
				arg_25_1.var_.characterEffect1034ui_story = var_28_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_6 = 0.2

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_6 and not isNil(var_28_5) then
				if arg_25_1.var_.characterEffect1034ui_story and not isNil(var_28_5) then
					arg_25_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_6 and arg_25_1.time_ < 0 + var_28_6 + arg_28_0 and not isNil(var_28_5) and arg_25_1.var_.characterEffect1034ui_story then
				arg_25_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action7_1")
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileF_biyan", "EmotionTimelineAnimator")
			end

			local var_28_8 = 0
			local var_28_9 = 0.225

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_8 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_10 = arg_25_1:GetWordFromCfg(1103401006)
				local var_28_11 = arg_25_1:FormatText(var_28_10.content)

				arg_25_1.text_.text = var_28_11

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_13 = 9 <= 0 and var_28_9 or var_28_9 * (utf8.len(var_28_11) / 9)

				if (9 <= 0 and var_28_9 or var_28_9 * (utf8.len(var_28_11) / 9)) > 0 and var_28_9 < var_28_13 then
					arg_25_1.talkMaxDuration = var_28_13

					if var_28_13 + var_28_8 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_13 + var_28_8
					end
				end

				arg_25_1.text_.text = var_28_11
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401006", "story_v_side_new_1103401.awb") ~= 0 then
					local var_28_14 = manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401006", "story_v_side_new_1103401.awb") / 1000

					if var_28_14 + var_28_8 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_14 + var_28_8
					end

					if var_28_10.prefab_name ~= "" and arg_25_1.actors_[var_28_10.prefab_name] ~= nil then
						local var_28_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_10.prefab_name].transform, "story_v_side_new_1103401", "1103401006", "story_v_side_new_1103401.awb")

						arg_25_1:RecordAudio("1103401006", var_28_15)
						arg_25_1:RecordAudio("1103401006", var_28_15)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_side_new_1103401", "1103401006", "story_v_side_new_1103401.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_side_new_1103401", "1103401006", "story_v_side_new_1103401.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_16 = math.max(var_28_9, arg_25_1.talkMaxDuration)

			if var_28_8 <= arg_25_1.time_ and arg_25_1.time_ < var_28_8 + var_28_16 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_8) / var_28_16

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_8 + var_28_16 and arg_25_1.time_ < var_28_8 + var_28_16 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play1103401007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 1103401007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play1103401008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["1034ui_story"]) and arg_29_1.var_.characterEffect1034ui_story == nil then
				arg_29_1.var_.characterEffect1034ui_story = arg_29_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_0 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["1034ui_story"]) then
				if arg_29_1.var_.characterEffect1034ui_story and not isNil(arg_29_1.actors_["1034ui_story"]) then
					arg_29_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_0)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["1034ui_story"]) and arg_29_1.var_.characterEffect1034ui_story then
				arg_29_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_32_1 = 0
			local var_32_2 = 1.3

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_3 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(1103401007).content)

				arg_29_1.text_.text = var_32_3

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 52 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_3) / 52)

				if (52 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_3) / 52)) > 0 and var_32_2 < var_32_5 then
					arg_29_1.talkMaxDuration = var_32_5

					if var_32_5 + var_32_1 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + var_32_1
					end
				end

				arg_29_1.text_.text = var_32_3
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_6 = math.max(var_32_2, arg_29_1.talkMaxDuration)

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_6 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_1) / var_32_6

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_1 + var_32_6 and arg_29_1.time_ < var_32_1 + var_32_6 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play1103401008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 1103401008
		arg_33_1.duration_ = 2

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play1103401009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["1034ui_story"]) and arg_33_1.var_.characterEffect1034ui_story == nil then
				arg_33_1.var_.characterEffect1034ui_story = arg_33_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 2

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["1034ui_story"]) then
				if arg_33_1.var_.characterEffect1034ui_story and not isNil(arg_33_1.actors_["1034ui_story"]) then
					arg_33_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["1034ui_story"]) and arg_33_1.var_.characterEffect1034ui_story then
				arg_33_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034actionlink/1034action476")
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_36_2 = 0
			local var_36_3 = 0.425

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_2 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_4 = arg_33_1:GetWordFromCfg(1103401008)
				local var_36_5 = arg_33_1:FormatText(var_36_4.content)

				arg_33_1.text_.text = var_36_5

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_7 = 17 <= 0 and var_36_3 or var_36_3 * (utf8.len(var_36_5) / 17)

				if (17 <= 0 and var_36_3 or var_36_3 * (utf8.len(var_36_5) / 17)) > 0 and var_36_3 < var_36_7 then
					arg_33_1.talkMaxDuration = var_36_7

					if var_36_7 + var_36_2 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_7 + var_36_2
					end
				end

				arg_33_1.text_.text = var_36_5
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401008", "story_v_side_new_1103401.awb") ~= 0 then
					local var_36_8 = manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401008", "story_v_side_new_1103401.awb") / 1000

					if var_36_8 + var_36_2 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_8 + var_36_2
					end

					if var_36_4.prefab_name ~= "" and arg_33_1.actors_[var_36_4.prefab_name] ~= nil then
						local var_36_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_4.prefab_name].transform, "story_v_side_new_1103401", "1103401008", "story_v_side_new_1103401.awb")

						arg_33_1:RecordAudio("1103401008", var_36_9)
						arg_33_1:RecordAudio("1103401008", var_36_9)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_side_new_1103401", "1103401008", "story_v_side_new_1103401.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_side_new_1103401", "1103401008", "story_v_side_new_1103401.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_10 = math.max(var_36_3, arg_33_1.talkMaxDuration)

			if var_36_2 <= arg_33_1.time_ and arg_33_1.time_ < var_36_2 + var_36_10 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_2) / var_36_10

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_2 + var_36_10 and arg_33_1.time_ < var_36_2 + var_36_10 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play1103401009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 1103401009
		arg_37_1.duration_ = 8.5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play1103401010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if arg_37_1.bgs_.STblack == nil then
				local var_40_0 = Object.Instantiate(arg_37_1.paintGo_)

				var_40_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_40_0.name = "STblack"
				var_40_0.transform.parent = arg_37_1.stage_.transform
				var_40_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_37_1.bgs_.STblack = var_40_0
			end

			if 2 < arg_37_1.time_ and arg_37_1.time_ <= 2 + arg_40_0 then
				local var_40_1 = arg_37_1.bgs_.STblack

				arg_37_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_40_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_40_2 = var_40_1:GetComponent("SpriteRenderer")

				if var_40_2 and var_40_2.sprite then
					local var_40_3 = 2 * (var_40_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_40_1.transform.localScale = Vector3.New(var_40_3 / var_40_2.sprite.bounds.size.y < var_40_3 * manager.ui.mainCameraCom_.aspect / var_40_2.sprite.bounds.size.x and var_40_3 * manager.ui.mainCameraCom_.aspect / var_40_2.sprite.bounds.size.x or var_40_3 / var_40_2.sprite.bounds.size.y, var_40_3 / var_40_2.sprite.bounds.size.y < var_40_3 * manager.ui.mainCameraCom_.aspect / var_40_2.sprite.bounds.size.x and var_40_3 * manager.ui.mainCameraCom_.aspect / var_40_2.sprite.bounds.size.x or var_40_3 / var_40_2.sprite.bounds.size.y, 0)
				end

				for iter_40_0, iter_40_1 in pairs(arg_37_1.bgs_) do
					if iter_40_0 ~= "STblack" then
						iter_40_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_40_4 = 3.5

			if 3.5 < arg_37_1.time_ and arg_37_1.time_ <= var_40_4 + arg_40_0 then
				arg_37_1.allBtn_.enabled = false
			end

			if arg_37_1.time_ >= var_40_4 + 0.1 and arg_37_1.time_ < var_40_4 + 0.1 + arg_40_0 then
				arg_37_1.allBtn_.enabled = true
			end

			local var_40_5 = 0

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_5 + arg_40_0 then
				arg_37_1.mask_.enabled = true
				arg_37_1.mask_.raycastTarget = true

				arg_37_1:SetGaussion(false)
			end

			local var_40_6 = 2

			if var_40_5 <= arg_37_1.time_ and arg_37_1.time_ < var_40_5 + var_40_6 then
				local var_40_7 = Color.New(0, 0, 0)

				var_40_7.a = Mathf.Lerp(0, 1, (arg_37_1.time_ - var_40_5) / var_40_6)
				arg_37_1.mask_.color = var_40_7
			end

			if arg_37_1.time_ >= var_40_5 + var_40_6 and arg_37_1.time_ < var_40_5 + var_40_6 + arg_40_0 then
				local var_40_8 = Color.New(0, 0, 0)

				var_40_8.a = 1
				arg_37_1.mask_.color = var_40_8
			end

			local var_40_9 = 2

			if 2 < arg_37_1.time_ and arg_37_1.time_ <= var_40_9 + arg_40_0 then
				arg_37_1.mask_.enabled = true
				arg_37_1.mask_.raycastTarget = true

				arg_37_1:SetGaussion(false)
			end

			local var_40_10 = 2

			if var_40_9 <= arg_37_1.time_ and arg_37_1.time_ < var_40_9 + var_40_10 then
				local var_40_11 = Color.New(0, 0, 0)

				var_40_11.a = Mathf.Lerp(1, 0, (arg_37_1.time_ - var_40_9) / var_40_10)
				arg_37_1.mask_.color = var_40_11
			end

			if arg_37_1.time_ >= var_40_9 + var_40_10 and arg_37_1.time_ < var_40_9 + var_40_10 + arg_40_0 then
				local var_40_12 = Color.New(0, 0, 0)

				arg_37_1.mask_.enabled = false
				var_40_12.a = 0
				arg_37_1.mask_.color = var_40_12
			end

			local var_40_13 = arg_37_1.actors_["1034ui_story"].transform

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1034ui_story = var_40_13.localPosition
			end

			local var_40_14 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_14 then
				var_40_13.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1034ui_story, Vector3.New(0, -0.93, -6), (arg_37_1.time_ - 0) / var_40_14)
				var_40_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_13.position).x, (manager.ui.mainCamera.transform.position - var_40_13.position).y, (manager.ui.mainCamera.transform.position - var_40_13.position).z)
				var_40_13.localEulerAngles.z = 0
				var_40_13.localEulerAngles.x = 0
				var_40_13.localEulerAngles = var_40_13.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_14 and arg_37_1.time_ < 0 + var_40_14 + arg_40_0 then
				var_40_13.localPosition = Vector3.New(0, -0.93, -6)
				var_40_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_13.position).x, (manager.ui.mainCamera.transform.position - var_40_13.position).y, (manager.ui.mainCamera.transform.position - var_40_13.position).z)
				var_40_13.localEulerAngles.z = 0
				var_40_13.localEulerAngles.x = 0
				var_40_13.localEulerAngles = var_40_13.localEulerAngles
			end

			local var_40_15 = arg_37_1.actors_["1034ui_story"].transform

			if 1.96599999815226 < arg_37_1.time_ and arg_37_1.time_ <= 1.96599999815226 + arg_40_0 then
				arg_37_1.var_.moveOldPos1034ui_story = var_40_15.localPosition
			end

			local var_40_16 = 0.001

			if 1.96599999815226 <= arg_37_1.time_ and arg_37_1.time_ < 1.96599999815226 + var_40_16 then
				var_40_15.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1034ui_story, Vector3.New(0, 100, 0), (arg_37_1.time_ - 1.96599999815226) / var_40_16)
				var_40_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_15.position).x, (manager.ui.mainCamera.transform.position - var_40_15.position).y, (manager.ui.mainCamera.transform.position - var_40_15.position).z)
				var_40_15.localEulerAngles.z = 0
				var_40_15.localEulerAngles.x = 0
				var_40_15.localEulerAngles = var_40_15.localEulerAngles
			end

			if arg_37_1.time_ >= 1.96599999815226 + var_40_16 and arg_37_1.time_ < 1.96599999815226 + var_40_16 + arg_40_0 then
				var_40_15.localPosition = Vector3.New(0, 100, 0)
				var_40_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_15.position).x, (manager.ui.mainCamera.transform.position - var_40_15.position).y, (manager.ui.mainCamera.transform.position - var_40_15.position).z)
				var_40_15.localEulerAngles.z = 0
				var_40_15.localEulerAngles.x = 0
				var_40_15.localEulerAngles = var_40_15.localEulerAngles
			end

			local var_40_17 = arg_37_1.actors_["1034ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_17) and arg_37_1.var_.characterEffect1034ui_story == nil then
				arg_37_1.var_.characterEffect1034ui_story = var_40_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_18 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_18 and not isNil(var_40_17) then
				if arg_37_1.var_.characterEffect1034ui_story and not isNil(var_40_17) then
					arg_37_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_18)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_18 and arg_37_1.time_ < 0 + var_40_18 + arg_40_0 and not isNil(var_40_17) and arg_37_1.var_.characterEffect1034ui_story then
				arg_37_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0.133333333333333 < arg_37_1.time_ and arg_37_1.time_ <= 0.133333333333333 + arg_40_0 then
				arg_37_1:AudioAction("stop", "effect", "se_story_16", "se_story_16_street_loop", "")
			end

			if 0.133333333333333 < arg_37_1.time_ and arg_37_1.time_ <= 0.133333333333333 + arg_40_0 then
				arg_37_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_40_22 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_37_1.bgmTxt_.text ~= var_40_22 and arg_37_1.bgmTxt_.text ~= "" then
						if arg_37_1.bgmTxt2_.text ~= "" then
							arg_37_1.bgmTxt_.text = arg_37_1.bgmTxt2_.text
						end

						arg_37_1.bgmTxt2_.text = var_40_22

						arg_37_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_37_1.bgmTxt_.text = var_40_22
						arg_37_1.bgmTxt2_.text = var_40_22
					end

					if arg_37_1.bgmTimer then
						arg_37_1.bgmTimer:Stop()

						arg_37_1.bgmTimer = nil
					end

					if arg_37_1.settingData.show_music_name == 1 then
						arg_37_1.musicController:SetSelectedState("show")
						arg_37_1.musicAnimator_:Play("open", 0, 0)

						if arg_37_1.settingData.music_time ~= 0 then
							arg_37_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_37_1.settingData.music_time), function()
								if arg_37_1 == nil or isNil(arg_37_1.bgmTxt_) then
									return
								end

								arg_37_1.musicController:SetSelectedState("hide")
								arg_37_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_37_1.frameCnt_ <= 1 then
				arg_37_1.dialog_:SetActive(false)
			end

			local var_40_23 = 3.5
			local var_40_24 = 0.466666666666667

			if 3.5 < arg_37_1.time_ and arg_37_1.time_ <= var_40_23 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0

				arg_37_1.dialog_:SetActive(true)

				arg_37_1.dialogCg_.alpha = 0

				local var_40_25 = LeanTween.value(arg_37_1.dialog_, 0, 1, 0.3)

				var_40_25:setOnUpdate(LuaHelper.FloatAction(function(arg_42_0)
					arg_37_1.dialogCg_.alpha = arg_42_0
				end))
				var_40_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_37_1.dialog_)
					var_40_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_37_1.duration_ = arg_37_1.duration_ + 0.3

				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_26 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(1103401009).content)

				arg_37_1.text_.text = var_40_26

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_28 = 5 <= 0 and var_40_24 or var_40_24 * (utf8.len(var_40_26) / 5)

				if (5 <= 0 and var_40_24 or var_40_24 * (utf8.len(var_40_26) / 5)) > 0 and var_40_24 < var_40_28 then
					arg_37_1.talkMaxDuration = var_40_28
					var_40_23 = var_40_23 + 0.3

					if var_40_28 + var_40_23 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_28 + var_40_23
					end
				end

				arg_37_1.text_.text = var_40_26
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_29 = var_40_23 + 0.3
			local var_40_30 = math.max(var_40_24, arg_37_1.talkMaxDuration)

			if var_40_23 + 0.3 <= arg_37_1.time_ and arg_37_1.time_ < var_40_29 + var_40_30 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_29) / var_40_30

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_29 + var_40_30 and arg_37_1.time_ < var_40_29 + var_40_30 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play1103401010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 1103401010
		arg_44_1.duration_ = 7

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play1103401011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_9000

			if arg_44_1.bgs_.ST01 == nil then
				local var_47_0 = Object.Instantiate(arg_44_1.paintGo_)

				var_47_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST01")
				var_47_0.name = "ST01"
				var_47_0.transform.parent = arg_44_1.stage_.transform
				var_47_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_44_1.bgs_.ST01 = var_47_0
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				local var_47_1 = arg_44_1.bgs_.ST01

				arg_44_1.bgs_.ST01.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_47_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_47_2 = var_47_1:GetComponent("SpriteRenderer")

				if var_47_2 and var_47_2.sprite then
					local var_47_3 = 2 * (var_47_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_47_1.transform.localScale = Vector3.New(var_47_3 / var_47_2.sprite.bounds.size.y < var_47_3 * manager.ui.mainCameraCom_.aspect / var_47_2.sprite.bounds.size.x and var_47_3 * manager.ui.mainCameraCom_.aspect / var_47_2.sprite.bounds.size.x or var_47_3 / var_47_2.sprite.bounds.size.y, var_47_3 / var_47_2.sprite.bounds.size.y < var_47_3 * manager.ui.mainCameraCom_.aspect / var_47_2.sprite.bounds.size.x and var_47_3 * manager.ui.mainCameraCom_.aspect / var_47_2.sprite.bounds.size.x or var_47_3 / var_47_2.sprite.bounds.size.y, 0)
				end

				for iter_47_0, iter_47_1 in pairs(arg_44_1.bgs_) do
					if iter_47_0 ~= "ST01" then
						iter_47_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_47_4 = 2

			if 2 < arg_44_1.time_ and arg_44_1.time_ <= var_47_4 + arg_47_0 then
				arg_44_1.allBtn_.enabled = false
			end

			if arg_44_1.time_ >= var_47_4 + 0.3 and arg_44_1.time_ < var_47_4 + 0.3 + arg_47_0 then
				arg_44_1.allBtn_.enabled = true
			end

			local var_47_5 = 0

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_5 + arg_47_0 then
				arg_44_1.mask_.enabled = true
				arg_44_1.mask_.raycastTarget = true

				arg_44_1:SetGaussion(false)
			end

			local var_47_6 = 2

			if var_47_5 <= arg_44_1.time_ and arg_44_1.time_ < var_47_5 + var_47_6 then
				local var_47_7 = Color.New(0, 0, 0)

				var_47_7.a = Mathf.Lerp(1, 0, (arg_44_1.time_ - var_47_5) / var_47_6)
				arg_44_1.mask_.color = var_47_7
			end

			if arg_44_1.time_ >= var_47_5 + var_47_6 and arg_44_1.time_ < var_47_5 + var_47_6 + arg_47_0 then
				local var_47_8 = Color.New(0, 0, 0)

				arg_44_1.mask_.enabled = false
				var_47_8.a = 0
				arg_44_1.mask_.color = var_47_8
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				local var_47_9 = arg_44_1.var_.effect7897987987897979

				if not arg_44_1.var_.effect7897987987897979 then
					var_47_9 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rain_heavymax_ui"), manager.ui.mainCamera.transform)
					var_47_9.name = "7897987987897979"
					arg_44_1.var_.effect7897987987897979 = var_47_9
				else
					var_47_9.transform:SetParent(var_47_9000)
				end

				var_47_9.transform.localPosition = Vector3.New(0, 0, 0)
				var_47_9.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_47_11 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_47_2, iter_47_3 in ipairs((var_47_9.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_47_3.transform.localScale = Vector3.New(iter_47_3.transform.localScale.x / var_47_11 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_47_3.transform.localScale.y / var_47_11, iter_47_3.transform.localScale.z)
				end
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_47_15 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_44_1.bgmTxt_.text ~= var_47_15 and arg_44_1.bgmTxt_.text ~= "" then
						if arg_44_1.bgmTxt2_.text ~= "" then
							arg_44_1.bgmTxt_.text = arg_44_1.bgmTxt2_.text
						end

						arg_44_1.bgmTxt2_.text = var_47_15

						arg_44_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_44_1.bgmTxt_.text = var_47_15
						arg_44_1.bgmTxt2_.text = var_47_15
					end

					if arg_44_1.bgmTimer then
						arg_44_1.bgmTimer:Stop()

						arg_44_1.bgmTimer = nil
					end

					if arg_44_1.settingData.show_music_name == 1 then
						arg_44_1.musicController:SetSelectedState("show")
						arg_44_1.musicAnimator_:Play("open", 0, 0)

						if arg_44_1.settingData.music_time ~= 0 then
							arg_44_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_44_1.settingData.music_time), function()
								if arg_44_1 == nil or isNil(arg_44_1.bgmTxt_) then
									return
								end

								arg_44_1.musicController:SetSelectedState("hide")
								arg_44_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.4 < arg_44_1.time_ and arg_44_1.time_ <= 0.4 + arg_47_0 then
				arg_44_1:AudioAction("play", "music", "bgm_side_daily01", "bgm_side_daily01", "bgm_side_daily01.awb")

				local var_47_18 = manager.audio:GetAudioName("bgm_side_daily01", "bgm_side_daily01")

				if "" ~= "" then
					if arg_44_1.bgmTxt_.text ~= var_47_18 and arg_44_1.bgmTxt_.text ~= "" then
						if arg_44_1.bgmTxt2_.text ~= "" then
							arg_44_1.bgmTxt_.text = arg_44_1.bgmTxt2_.text
						end

						arg_44_1.bgmTxt2_.text = var_47_18

						arg_44_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_44_1.bgmTxt_.text = var_47_18
						arg_44_1.bgmTxt2_.text = var_47_18
					end

					if arg_44_1.bgmTimer then
						arg_44_1.bgmTimer:Stop()

						arg_44_1.bgmTimer = nil
					end

					if arg_44_1.settingData.show_music_name == 1 then
						arg_44_1.musicController:SetSelectedState("show")
						arg_44_1.musicAnimator_:Play("open", 0, 0)

						if arg_44_1.settingData.music_time ~= 0 then
							arg_44_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_44_1.settingData.music_time), function()
								if arg_44_1 == nil or isNil(arg_44_1.bgmTxt_) then
									return
								end

								arg_44_1.musicController:SetSelectedState("hide")
								arg_44_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.2 < arg_44_1.time_ and arg_44_1.time_ <= 0.2 + arg_47_0 then
				arg_44_1:AudioAction("play", "effect", "se_story_143", "se_story_143_amb_room", "")
			end

			if arg_44_1.frameCnt_ <= 1 then
				arg_44_1.dialog_:SetActive(false)
			end

			local var_47_20 = 2
			local var_47_21 = 0.35

			if 2 < arg_44_1.time_ and arg_44_1.time_ <= var_47_20 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0

				arg_44_1.dialog_:SetActive(true)

				arg_44_1.dialogCg_.alpha = 0

				local var_47_22 = LeanTween.value(arg_44_1.dialog_, 0, 1, 0.3)

				var_47_22:setOnUpdate(LuaHelper.FloatAction(function(arg_50_0)
					arg_44_1.dialogCg_.alpha = arg_50_0
				end))
				var_47_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_44_1.dialog_)
					var_47_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_44_1.duration_ = arg_44_1.duration_ + 0.3

				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, true)
				arg_44_1.iconController_:SetSelectedState("hero")

				arg_44_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_44_1.callingController_:SetSelectedState("normal")

				arg_44_1.keyicon_.color = Color.New(1, 1, 1)
				arg_44_1.icon_.color = Color.New(1, 1, 1)

				local var_47_23 = arg_44_1:FormatText(arg_44_1:GetWordFromCfg(1103401010).content)

				arg_44_1.text_.text = var_47_23

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_25 = 14 <= 0 and var_47_21 or var_47_21 * (utf8.len(var_47_23) / 14)

				if (14 <= 0 and var_47_21 or var_47_21 * (utf8.len(var_47_23) / 14)) > 0 and var_47_21 < var_47_25 then
					arg_44_1.talkMaxDuration = var_47_25
					var_47_20 = var_47_20 + 0.3

					if var_47_25 + var_47_20 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_25 + var_47_20
					end
				end

				arg_44_1.text_.text = var_47_23
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_26 = var_47_20 + 0.3
			local var_47_27 = math.max(var_47_21, arg_44_1.talkMaxDuration)

			if var_47_20 + 0.3 <= arg_44_1.time_ and arg_44_1.time_ < var_47_26 + var_47_27 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_26) / var_47_27

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_26 + var_47_27 and arg_44_1.time_ < var_47_26 + var_47_27 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play1103401011 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 1103401011
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play1103401012(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 1.375

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, false)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_1 = arg_52_1:FormatText(arg_52_1:GetWordFromCfg(1103401011).content)

				arg_52_1.text_.text = var_55_1

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_3 = 55 <= 0 and var_55_0 or var_55_0 * (utf8.len(var_55_1) / 55)

				if (55 <= 0 and var_55_0 or var_55_0 * (utf8.len(var_55_1) / 55)) > 0 and var_55_0 < var_55_3 then
					arg_52_1.talkMaxDuration = var_55_3

					if var_55_3 + 0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_3 + 0
					end
				end

				arg_52_1.text_.text = var_55_1
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_4 = math.max(var_55_0, arg_52_1.talkMaxDuration)

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_4 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - 0) / var_55_4

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= 0 + var_55_4 and arg_52_1.time_ < 0 + var_55_4 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play1103401012 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 1103401012
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play1103401013(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0.525

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_1 = arg_56_1:FormatText(arg_56_1:GetWordFromCfg(1103401012).content)

				arg_56_1.text_.text = var_59_1

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_3 = 21 <= 0 and var_59_0 or var_59_0 * (utf8.len(var_59_1) / 21)

				if (21 <= 0 and var_59_0 or var_59_0 * (utf8.len(var_59_1) / 21)) > 0 and var_59_0 < var_59_3 then
					arg_56_1.talkMaxDuration = var_59_3

					if var_59_3 + 0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_3 + 0
					end
				end

				arg_56_1.text_.text = var_59_1
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_4 = math.max(var_59_0, arg_56_1.talkMaxDuration)

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_4 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - 0) / var_59_4

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= 0 + var_59_4 and arg_56_1.time_ < 0 + var_59_4 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play1103401013 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 1103401013
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play1103401014(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0.25

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, true)
				arg_60_1.iconController_:SetSelectedState("hero")

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_1 = arg_60_1:FormatText(arg_60_1:GetWordFromCfg(1103401013).content)

				arg_60_1.text_.text = var_63_1

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_3 = 10 <= 0 and var_63_0 or var_63_0 * (utf8.len(var_63_1) / 10)

				if (10 <= 0 and var_63_0 or var_63_0 * (utf8.len(var_63_1) / 10)) > 0 and var_63_0 < var_63_3 then
					arg_60_1.talkMaxDuration = var_63_3

					if var_63_3 + 0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_3 + 0
					end
				end

				arg_60_1.text_.text = var_63_1
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_4 = math.max(var_63_0, arg_60_1.talkMaxDuration)

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_4 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - 0) / var_63_4

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= 0 + var_63_4 and arg_60_1.time_ < 0 + var_63_4 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play1103401014 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 1103401014
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play1103401015(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0.8 < arg_64_1.time_ and arg_64_1.time_ <= 0.8 + arg_67_0 then
				arg_64_1:AudioAction("play", "effect", "se_story_side_1148", "se_story_1148_vibrate", "")
			end

			local var_67_1 = 0
			local var_67_2 = 1.45

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

				local var_67_3 = arg_64_1:FormatText(arg_64_1:GetWordFromCfg(1103401014).content)

				arg_64_1.text_.text = var_67_3

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_5 = 58 <= 0 and var_67_2 or var_67_2 * (utf8.len(var_67_3) / 58)

				if (58 <= 0 and var_67_2 or var_67_2 * (utf8.len(var_67_3) / 58)) > 0 and var_67_2 < var_67_5 then
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
	Play1103401015 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 1103401015
		arg_68_1.duration_ = 1

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"

			SetActive(arg_68_1.choicesGo_, true)

			for iter_69_0, iter_69_1 in ipairs(arg_68_1.choices_) do
				SetActive(iter_69_1.go, iter_69_0 <= 2)
			end

			arg_68_1.choices_[1].txt.text = arg_68_1:FormatText(StoryChoiceCfg[1443].name)
			arg_68_1.choices_[2].txt.text = arg_68_1:FormatText(StoryChoiceCfg[1444].name)
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play1103401018(arg_68_1)
			end

			if arg_70_0 == 2 then
				arg_68_0:Play1103401016(arg_68_1)
			end

			arg_68_1:RecordChoiceLog(1103401015, 1443, 1444)
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.allBtn_.enabled = false
			end

			if arg_68_1.time_ >= 0 + 0.5 and arg_68_1.time_ < 0 + 0.5 + arg_71_0 then
				arg_68_1.allBtn_.enabled = true
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play1103401018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 1103401018
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play1103401019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0.15

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, true)
				arg_72_1.iconController_:SetSelectedState("hero")

				arg_72_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_72_1.callingController_:SetSelectedState("normal")

				arg_72_1.keyicon_.color = Color.New(1, 1, 1)
				arg_72_1.icon_.color = Color.New(1, 1, 1)

				local var_75_1 = arg_72_1:FormatText(arg_72_1:GetWordFromCfg(1103401018).content)

				arg_72_1.text_.text = var_75_1

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_3 = 6 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_1) / 6)

				if (6 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_1) / 6)) > 0 and var_75_0 < var_75_3 then
					arg_72_1.talkMaxDuration = var_75_3

					if var_75_3 + 0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_3 + 0
					end
				end

				arg_72_1.text_.text = var_75_1
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_4 = math.max(var_75_0, arg_72_1.talkMaxDuration)

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_4 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - 0) / var_75_4

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= 0 + var_75_4 and arg_72_1.time_ < 0 + var_75_4 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play1103401019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 1103401019
		arg_76_1.duration_ = 7.63

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play1103401020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.var_.moveOldPos1034ui_story = arg_76_1.actors_["1034ui_story"].transform.localPosition
			end

			local var_79_0 = 0.001

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_0 then
				arg_76_1.actors_["1034ui_story"].transform.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1034ui_story, Vector3.New(0, -0.93, -6), (arg_76_1.time_ - 0) / var_79_0)
				arg_76_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_76_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["1034ui_story"].transform.position).z)
				arg_76_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_76_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_76_1.actors_["1034ui_story"].transform.localEulerAngles = arg_76_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			if arg_76_1.time_ >= 0 + var_79_0 and arg_76_1.time_ < 0 + var_79_0 + arg_79_0 then
				arg_76_1.actors_["1034ui_story"].transform.localPosition = Vector3.New(0, -0.93, -6)
				arg_76_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_76_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["1034ui_story"].transform.position).z)
				arg_76_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_76_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_76_1.actors_["1034ui_story"].transform.localEulerAngles = arg_76_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			local var_79_1 = arg_76_1.actors_["1034ui_story"]

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(var_79_1) and arg_76_1.var_.characterEffect1034ui_story == nil then
				arg_76_1.var_.characterEffect1034ui_story = var_79_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_2 = 0.200000002980232

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_2 and not isNil(var_79_1) then
				if arg_76_1.var_.characterEffect1034ui_story and not isNil(var_79_1) then
					arg_76_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= 0 + var_79_2 and arg_76_1.time_ < 0 + var_79_2 + arg_79_0 and not isNil(var_79_1) and arg_76_1.var_.characterEffect1034ui_story then
				arg_76_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action7_1")
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				if arg_76_1.var_.characterEffect1034ui_story == nil then
					arg_76_1.var_.characterEffect1034ui_story = arg_76_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_79_4 = arg_76_1.var_.characterEffect1034ui_story

				arg_76_1.var_.characterEffect1034ui_story.imageEffect:turnOff()

				var_79_4.interferenceEffect.enabled = true
				var_79_4.interferenceEffect.noise = 0.001
				var_79_4.interferenceEffect.simTimeScale = 1
				var_79_4.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				if arg_76_1.var_.characterEffect1034ui_story == nil then
					arg_76_1.var_.characterEffect1034ui_story = arg_76_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_76_1.var_.characterEffect1034ui_story.imageEffect:turnOn(false)
			end

			local var_79_6 = 0
			local var_79_7 = 0.95

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_6 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_8 = arg_76_1:GetWordFromCfg(1103401019)
				local var_79_9 = arg_76_1:FormatText(var_79_8.content)

				arg_76_1.text_.text = var_79_9

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_11 = 38 <= 0 and var_79_7 or var_79_7 * (utf8.len(var_79_9) / 38)

				if (38 <= 0 and var_79_7 or var_79_7 * (utf8.len(var_79_9) / 38)) > 0 and var_79_7 < var_79_11 then
					arg_76_1.talkMaxDuration = var_79_11

					if var_79_11 + var_79_6 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_11 + var_79_6
					end
				end

				arg_76_1.text_.text = var_79_9
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401019", "story_v_side_new_1103401.awb") ~= 0 then
					local var_79_12 = manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401019", "story_v_side_new_1103401.awb") / 1000

					if var_79_12 + var_79_6 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_12 + var_79_6
					end

					if var_79_8.prefab_name ~= "" and arg_76_1.actors_[var_79_8.prefab_name] ~= nil then
						local var_79_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_8.prefab_name].transform, "story_v_side_new_1103401", "1103401019", "story_v_side_new_1103401.awb")

						arg_76_1:RecordAudio("1103401019", var_79_13)
						arg_76_1:RecordAudio("1103401019", var_79_13)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_side_new_1103401", "1103401019", "story_v_side_new_1103401.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_side_new_1103401", "1103401019", "story_v_side_new_1103401.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_14 = math.max(var_79_7, arg_76_1.talkMaxDuration)

			if var_79_6 <= arg_76_1.time_ and arg_76_1.time_ < var_79_6 + var_79_14 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_6) / var_79_14

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_6 + var_79_14 and arg_76_1.time_ < var_79_6 + var_79_14 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_76_1:InitPlayNodeList()
	end,
	Play1103401020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 1103401020
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play1103401021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(arg_80_1.actors_["1034ui_story"]) and arg_80_1.var_.characterEffect1034ui_story == nil then
				arg_80_1.var_.characterEffect1034ui_story = arg_80_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_0 = 0.200000002980232

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_0 and not isNil(arg_80_1.actors_["1034ui_story"]) then
				if arg_80_1.var_.characterEffect1034ui_story and not isNil(arg_80_1.actors_["1034ui_story"]) then
					arg_80_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_80_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_80_1.time_ - 0) / var_83_0)
				end
			end

			if arg_80_1.time_ >= 0 + var_83_0 and arg_80_1.time_ < 0 + var_83_0 + arg_83_0 and not isNil(arg_80_1.actors_["1034ui_story"]) and arg_80_1.var_.characterEffect1034ui_story then
				arg_80_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_80_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_83_1 = 0
			local var_83_2 = 0.325

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, true)
				arg_80_1.iconController_:SetSelectedState("hero")

				arg_80_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_80_1.callingController_:SetSelectedState("normal")

				arg_80_1.keyicon_.color = Color.New(1, 1, 1)
				arg_80_1.icon_.color = Color.New(1, 1, 1)

				local var_83_3 = arg_80_1:FormatText(arg_80_1:GetWordFromCfg(1103401020).content)

				arg_80_1.text_.text = var_83_3

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_5 = 13 <= 0 and var_83_2 or var_83_2 * (utf8.len(var_83_3) / 13)

				if (13 <= 0 and var_83_2 or var_83_2 * (utf8.len(var_83_3) / 13)) > 0 and var_83_2 < var_83_5 then
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
	Play1103401021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 1103401021
		arg_84_1.duration_ = 5.83

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play1103401022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(arg_84_1.actors_["1034ui_story"]) and arg_84_1.var_.characterEffect1034ui_story == nil then
				arg_84_1.var_.characterEffect1034ui_story = arg_84_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_0 = 0.200000002980232

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_0 and not isNil(arg_84_1.actors_["1034ui_story"]) then
				if arg_84_1.var_.characterEffect1034ui_story and not isNil(arg_84_1.actors_["1034ui_story"]) then
					arg_84_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= 0 + var_87_0 and arg_84_1.time_ < 0 + var_87_0 + arg_87_0 and not isNil(arg_84_1.actors_["1034ui_story"]) and arg_84_1.var_.characterEffect1034ui_story then
				arg_84_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034actionlink/1034action475")
			end

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_87_2 = 0
			local var_87_3 = 0.825

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_2 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_4 = arg_84_1:GetWordFromCfg(1103401021)
				local var_87_5 = arg_84_1:FormatText(var_87_4.content)

				arg_84_1.text_.text = var_87_5

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_7 = 33 <= 0 and var_87_3 or var_87_3 * (utf8.len(var_87_5) / 33)

				if (33 <= 0 and var_87_3 or var_87_3 * (utf8.len(var_87_5) / 33)) > 0 and var_87_3 < var_87_7 then
					arg_84_1.talkMaxDuration = var_87_7

					if var_87_7 + var_87_2 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_7 + var_87_2
					end
				end

				arg_84_1.text_.text = var_87_5
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401021", "story_v_side_new_1103401.awb") ~= 0 then
					local var_87_8 = manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401021", "story_v_side_new_1103401.awb") / 1000

					if var_87_8 + var_87_2 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_8 + var_87_2
					end

					if var_87_4.prefab_name ~= "" and arg_84_1.actors_[var_87_4.prefab_name] ~= nil then
						local var_87_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_4.prefab_name].transform, "story_v_side_new_1103401", "1103401021", "story_v_side_new_1103401.awb")

						arg_84_1:RecordAudio("1103401021", var_87_9)
						arg_84_1:RecordAudio("1103401021", var_87_9)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_side_new_1103401", "1103401021", "story_v_side_new_1103401.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_side_new_1103401", "1103401021", "story_v_side_new_1103401.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_10 = math.max(var_87_3, arg_84_1.talkMaxDuration)

			if var_87_2 <= arg_84_1.time_ and arg_84_1.time_ < var_87_2 + var_87_10 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_2) / var_87_10

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_2 + var_87_10 and arg_84_1.time_ < var_87_2 + var_87_10 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play1103401022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 1103401022
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play1103401023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(arg_88_1.actors_["1034ui_story"]) and arg_88_1.var_.characterEffect1034ui_story == nil then
				arg_88_1.var_.characterEffect1034ui_story = arg_88_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_0 = 0.200000002980232

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_0 and not isNil(arg_88_1.actors_["1034ui_story"]) then
				if arg_88_1.var_.characterEffect1034ui_story and not isNil(arg_88_1.actors_["1034ui_story"]) then
					arg_88_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_88_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_88_1.time_ - 0) / var_91_0)
				end
			end

			if arg_88_1.time_ >= 0 + var_91_0 and arg_88_1.time_ < 0 + var_91_0 + arg_91_0 and not isNil(arg_88_1.actors_["1034ui_story"]) and arg_88_1.var_.characterEffect1034ui_story then
				arg_88_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_88_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_91_1 = 0
			local var_91_2 = 0.325

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, true)
				arg_88_1.iconController_:SetSelectedState("hero")

				arg_88_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_88_1.callingController_:SetSelectedState("normal")

				arg_88_1.keyicon_.color = Color.New(1, 1, 1)
				arg_88_1.icon_.color = Color.New(1, 1, 1)

				local var_91_3 = arg_88_1:FormatText(arg_88_1:GetWordFromCfg(1103401022).content)

				arg_88_1.text_.text = var_91_3

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_5 = 13 <= 0 and var_91_2 or var_91_2 * (utf8.len(var_91_3) / 13)

				if (13 <= 0 and var_91_2 or var_91_2 * (utf8.len(var_91_3) / 13)) > 0 and var_91_2 < var_91_5 then
					arg_88_1.talkMaxDuration = var_91_5

					if var_91_5 + var_91_1 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_5 + var_91_1
					end
				end

				arg_88_1.text_.text = var_91_3
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_6 = math.max(var_91_2, arg_88_1.talkMaxDuration)

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_6 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_1) / var_91_6

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_1 + var_91_6 and arg_88_1.time_ < var_91_1 + var_91_6 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play1103401023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 1103401023
		arg_92_1.duration_ = 3.93

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play1103401024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(arg_92_1.actors_["1034ui_story"]) and arg_92_1.var_.characterEffect1034ui_story == nil then
				arg_92_1.var_.characterEffect1034ui_story = arg_92_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_0 = 0.200000002980232

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_0 and not isNil(arg_92_1.actors_["1034ui_story"]) then
				if arg_92_1.var_.characterEffect1034ui_story and not isNil(arg_92_1.actors_["1034ui_story"]) then
					arg_92_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= 0 + var_95_0 and arg_92_1.time_ < 0 + var_95_0 + arg_95_0 and not isNil(arg_92_1.actors_["1034ui_story"]) and arg_92_1.var_.characterEffect1034ui_story then
				arg_92_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034actionlink/1034action457")
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_95_2 = 0
			local var_95_3 = 0.45

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_2 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_4 = arg_92_1:GetWordFromCfg(1103401023)
				local var_95_5 = arg_92_1:FormatText(var_95_4.content)

				arg_92_1.text_.text = var_95_5

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_7 = 18 <= 0 and var_95_3 or var_95_3 * (utf8.len(var_95_5) / 18)

				if (18 <= 0 and var_95_3 or var_95_3 * (utf8.len(var_95_5) / 18)) > 0 and var_95_3 < var_95_7 then
					arg_92_1.talkMaxDuration = var_95_7

					if var_95_7 + var_95_2 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_7 + var_95_2
					end
				end

				arg_92_1.text_.text = var_95_5
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401023", "story_v_side_new_1103401.awb") ~= 0 then
					local var_95_8 = manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401023", "story_v_side_new_1103401.awb") / 1000

					if var_95_8 + var_95_2 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_8 + var_95_2
					end

					if var_95_4.prefab_name ~= "" and arg_92_1.actors_[var_95_4.prefab_name] ~= nil then
						local var_95_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_4.prefab_name].transform, "story_v_side_new_1103401", "1103401023", "story_v_side_new_1103401.awb")

						arg_92_1:RecordAudio("1103401023", var_95_9)
						arg_92_1:RecordAudio("1103401023", var_95_9)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_side_new_1103401", "1103401023", "story_v_side_new_1103401.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_side_new_1103401", "1103401023", "story_v_side_new_1103401.awb")
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
	Play1103401024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 1103401024
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play1103401025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(arg_96_1.actors_["1034ui_story"]) and arg_96_1.var_.characterEffect1034ui_story == nil then
				arg_96_1.var_.characterEffect1034ui_story = arg_96_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_0 = 0.200000002980232

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_0 and not isNil(arg_96_1.actors_["1034ui_story"]) then
				if arg_96_1.var_.characterEffect1034ui_story and not isNil(arg_96_1.actors_["1034ui_story"]) then
					arg_96_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_96_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_96_1.time_ - 0) / var_99_0)
				end
			end

			if arg_96_1.time_ >= 0 + var_99_0 and arg_96_1.time_ < 0 + var_99_0 + arg_99_0 and not isNil(arg_96_1.actors_["1034ui_story"]) and arg_96_1.var_.characterEffect1034ui_story then
				arg_96_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_96_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_99_1 = 0
			local var_99_2 = 0.625

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, true)
				arg_96_1.iconController_:SetSelectedState("hero")

				arg_96_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_96_1.callingController_:SetSelectedState("normal")

				arg_96_1.keyicon_.color = Color.New(1, 1, 1)
				arg_96_1.icon_.color = Color.New(1, 1, 1)

				local var_99_3 = arg_96_1:FormatText(arg_96_1:GetWordFromCfg(1103401024).content)

				arg_96_1.text_.text = var_99_3

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_5 = 25 <= 0 and var_99_2 or var_99_2 * (utf8.len(var_99_3) / 25)

				if (25 <= 0 and var_99_2 or var_99_2 * (utf8.len(var_99_3) / 25)) > 0 and var_99_2 < var_99_5 then
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
	Play1103401025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 1103401025
		arg_100_1.duration_ = 7.37

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play1103401026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(arg_100_1.actors_["1034ui_story"]) and arg_100_1.var_.characterEffect1034ui_story == nil then
				arg_100_1.var_.characterEffect1034ui_story = arg_100_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_0 = 0.200000002980232

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_0 and not isNil(arg_100_1.actors_["1034ui_story"]) then
				if arg_100_1.var_.characterEffect1034ui_story and not isNil(arg_100_1.actors_["1034ui_story"]) then
					arg_100_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_100_1.time_ >= 0 + var_103_0 and arg_100_1.time_ < 0 + var_103_0 + arg_103_0 and not isNil(arg_100_1.actors_["1034ui_story"]) and arg_100_1.var_.characterEffect1034ui_story then
				arg_100_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034actionlink/1034action476")
			end

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_103_2 = 0
			local var_103_3 = 0.65

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_2 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_4 = arg_100_1:GetWordFromCfg(1103401025)
				local var_103_5 = arg_100_1:FormatText(var_103_4.content)

				arg_100_1.text_.text = var_103_5

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_7 = 26 <= 0 and var_103_3 or var_103_3 * (utf8.len(var_103_5) / 26)

				if (26 <= 0 and var_103_3 or var_103_3 * (utf8.len(var_103_5) / 26)) > 0 and var_103_3 < var_103_7 then
					arg_100_1.talkMaxDuration = var_103_7

					if var_103_7 + var_103_2 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_7 + var_103_2
					end
				end

				arg_100_1.text_.text = var_103_5
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401025", "story_v_side_new_1103401.awb") ~= 0 then
					local var_103_8 = manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401025", "story_v_side_new_1103401.awb") / 1000

					if var_103_8 + var_103_2 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_8 + var_103_2
					end

					if var_103_4.prefab_name ~= "" and arg_100_1.actors_[var_103_4.prefab_name] ~= nil then
						local var_103_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_4.prefab_name].transform, "story_v_side_new_1103401", "1103401025", "story_v_side_new_1103401.awb")

						arg_100_1:RecordAudio("1103401025", var_103_9)
						arg_100_1:RecordAudio("1103401025", var_103_9)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_side_new_1103401", "1103401025", "story_v_side_new_1103401.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_side_new_1103401", "1103401025", "story_v_side_new_1103401.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_10 = math.max(var_103_3, arg_100_1.talkMaxDuration)

			if var_103_2 <= arg_100_1.time_ and arg_100_1.time_ < var_103_2 + var_103_10 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_2) / var_103_10

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_2 + var_103_10 and arg_100_1.time_ < var_103_2 + var_103_10 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play1103401026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 1103401026
		arg_104_1.duration_ = 2

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"

			SetActive(arg_104_1.choicesGo_, true)

			for iter_105_0, iter_105_1 in ipairs(arg_104_1.choices_) do
				SetActive(iter_105_1.go, iter_105_0 <= 1)
			end

			arg_104_1.choices_[1].txt.text = arg_104_1:FormatText(StoryChoiceCfg[1445].name)
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play1103401027(arg_104_1)
			end

			arg_104_1:RecordChoiceLog(1103401026, 1445)
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(arg_104_1.actors_["1034ui_story"]) and arg_104_1.var_.characterEffect1034ui_story == nil then
				arg_104_1.var_.characterEffect1034ui_story = arg_104_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_0 = 0.200000002980232

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_0 and not isNil(arg_104_1.actors_["1034ui_story"]) then
				if arg_104_1.var_.characterEffect1034ui_story and not isNil(arg_104_1.actors_["1034ui_story"]) then
					arg_104_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_104_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_104_1.time_ - 0) / var_107_0)
				end
			end

			if arg_104_1.time_ >= 0 + var_107_0 and arg_104_1.time_ < 0 + var_107_0 + arg_107_0 and not isNil(arg_104_1.actors_["1034ui_story"]) and arg_104_1.var_.characterEffect1034ui_story then
				arg_104_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_104_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_107_1 = 0

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 then
				arg_104_1.allBtn_.enabled = false
			end

			if arg_104_1.time_ >= var_107_1 + 2 and arg_104_1.time_ < var_107_1 + 2 + arg_107_0 then
				arg_104_1.allBtn_.enabled = true
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play1103401027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 1103401027
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play1103401028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(arg_108_1.actors_["1034ui_story"]) and arg_108_1.var_.characterEffect1034ui_story == nil then
				arg_108_1.var_.characterEffect1034ui_story = arg_108_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_0 = 0.200000002980232

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_0 and not isNil(arg_108_1.actors_["1034ui_story"]) then
				if arg_108_1.var_.characterEffect1034ui_story and not isNil(arg_108_1.actors_["1034ui_story"]) then
					arg_108_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_108_1.time_ >= 0 + var_111_0 and arg_108_1.time_ < 0 + var_111_0 + arg_111_0 and not isNil(arg_108_1.actors_["1034ui_story"]) and arg_108_1.var_.characterEffect1034ui_story then
				arg_108_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileD", "EmotionTimelineAnimator")
			end

			local var_111_2 = 0
			local var_111_3 = 0.625

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_2 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_4 = arg_108_1:GetWordFromCfg(1103401027)
				local var_111_5 = arg_108_1:FormatText(var_111_4.content)

				arg_108_1.text_.text = var_111_5

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_7 = 25 <= 0 and var_111_3 or var_111_3 * (utf8.len(var_111_5) / 25)

				if (25 <= 0 and var_111_3 or var_111_3 * (utf8.len(var_111_5) / 25)) > 0 and var_111_3 < var_111_7 then
					arg_108_1.talkMaxDuration = var_111_7

					if var_111_7 + var_111_2 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_7 + var_111_2
					end
				end

				arg_108_1.text_.text = var_111_5
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401027", "story_v_side_new_1103401.awb") ~= 0 then
					local var_111_8 = manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401027", "story_v_side_new_1103401.awb") / 1000

					if var_111_8 + var_111_2 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_8 + var_111_2
					end

					if var_111_4.prefab_name ~= "" and arg_108_1.actors_[var_111_4.prefab_name] ~= nil then
						local var_111_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_4.prefab_name].transform, "story_v_side_new_1103401", "1103401027", "story_v_side_new_1103401.awb")

						arg_108_1:RecordAudio("1103401027", var_111_9)
						arg_108_1:RecordAudio("1103401027", var_111_9)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_side_new_1103401", "1103401027", "story_v_side_new_1103401.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_side_new_1103401", "1103401027", "story_v_side_new_1103401.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_10 = math.max(var_111_3, arg_108_1.talkMaxDuration)

			if var_111_2 <= arg_108_1.time_ and arg_108_1.time_ < var_111_2 + var_111_10 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_2) / var_111_10

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_2 + var_111_10 and arg_108_1.time_ < var_111_2 + var_111_10 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play1103401028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 1103401028
		arg_112_1.duration_ = 3.53

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play1103401029(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(arg_112_1.actors_["1034ui_story"]) and arg_112_1.var_.characterEffect1034ui_story == nil then
				arg_112_1.var_.characterEffect1034ui_story = arg_112_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_0 = 0.200000002980232

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_0 and not isNil(arg_112_1.actors_["1034ui_story"]) then
				if arg_112_1.var_.characterEffect1034ui_story and not isNil(arg_112_1.actors_["1034ui_story"]) then
					arg_112_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_112_1.time_ >= 0 + var_115_0 and arg_112_1.time_ < 0 + var_115_0 + arg_115_0 and not isNil(arg_112_1.actors_["1034ui_story"]) and arg_112_1.var_.characterEffect1034ui_story then
				arg_112_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_115_2 = 0
			local var_115_3 = 0.5

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_2 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_4 = arg_112_1:GetWordFromCfg(1103401028)
				local var_115_5 = arg_112_1:FormatText(var_115_4.content)

				arg_112_1.text_.text = var_115_5

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_7 = 20 <= 0 and var_115_3 or var_115_3 * (utf8.len(var_115_5) / 20)

				if (20 <= 0 and var_115_3 or var_115_3 * (utf8.len(var_115_5) / 20)) > 0 and var_115_3 < var_115_7 then
					arg_112_1.talkMaxDuration = var_115_7

					if var_115_7 + var_115_2 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_7 + var_115_2
					end
				end

				arg_112_1.text_.text = var_115_5
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401028", "story_v_side_new_1103401.awb") ~= 0 then
					local var_115_8 = manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401028", "story_v_side_new_1103401.awb") / 1000

					if var_115_8 + var_115_2 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_8 + var_115_2
					end

					if var_115_4.prefab_name ~= "" and arg_112_1.actors_[var_115_4.prefab_name] ~= nil then
						local var_115_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_4.prefab_name].transform, "story_v_side_new_1103401", "1103401028", "story_v_side_new_1103401.awb")

						arg_112_1:RecordAudio("1103401028", var_115_9)
						arg_112_1:RecordAudio("1103401028", var_115_9)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_side_new_1103401", "1103401028", "story_v_side_new_1103401.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_side_new_1103401", "1103401028", "story_v_side_new_1103401.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_10 = math.max(var_115_3, arg_112_1.talkMaxDuration)

			if var_115_2 <= arg_112_1.time_ and arg_112_1.time_ < var_115_2 + var_115_10 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_2) / var_115_10

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_2 + var_115_10 and arg_112_1.time_ < var_115_2 + var_115_10 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play1103401029 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 1103401029
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play1103401030(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(arg_116_1.actors_["1034ui_story"]) and arg_116_1.var_.characterEffect1034ui_story == nil then
				arg_116_1.var_.characterEffect1034ui_story = arg_116_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_0 = 0.200000002980232

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_0 and not isNil(arg_116_1.actors_["1034ui_story"]) then
				if arg_116_1.var_.characterEffect1034ui_story and not isNil(arg_116_1.actors_["1034ui_story"]) then
					arg_116_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_116_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_116_1.time_ - 0) / var_119_0)
				end
			end

			if arg_116_1.time_ >= 0 + var_119_0 and arg_116_1.time_ < 0 + var_119_0 + arg_119_0 and not isNil(arg_116_1.actors_["1034ui_story"]) and arg_116_1.var_.characterEffect1034ui_story then
				arg_116_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_116_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_119_1 = 0
			local var_119_2 = 0.675

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, true)
				arg_116_1.iconController_:SetSelectedState("hero")

				arg_116_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_116_1.callingController_:SetSelectedState("normal")

				arg_116_1.keyicon_.color = Color.New(1, 1, 1)
				arg_116_1.icon_.color = Color.New(1, 1, 1)

				local var_119_3 = arg_116_1:FormatText(arg_116_1:GetWordFromCfg(1103401029).content)

				arg_116_1.text_.text = var_119_3

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_5 = 27 <= 0 and var_119_2 or var_119_2 * (utf8.len(var_119_3) / 27)

				if (27 <= 0 and var_119_2 or var_119_2 * (utf8.len(var_119_3) / 27)) > 0 and var_119_2 < var_119_5 then
					arg_116_1.talkMaxDuration = var_119_5

					if var_119_5 + var_119_1 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_5 + var_119_1
					end
				end

				arg_116_1.text_.text = var_119_3
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_6 = math.max(var_119_2, arg_116_1.talkMaxDuration)

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_6 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_1) / var_119_6

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_1 + var_119_6 and arg_116_1.time_ < var_119_1 + var_119_6 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play1103401030 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 1103401030
		arg_120_1.duration_ = 5.33

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play1103401031(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(arg_120_1.actors_["1034ui_story"]) and arg_120_1.var_.characterEffect1034ui_story == nil then
				arg_120_1.var_.characterEffect1034ui_story = arg_120_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_0 = 0.200000002980232

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_0 and not isNil(arg_120_1.actors_["1034ui_story"]) then
				if arg_120_1.var_.characterEffect1034ui_story and not isNil(arg_120_1.actors_["1034ui_story"]) then
					arg_120_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_120_1.time_ >= 0 + var_123_0 and arg_120_1.time_ < 0 + var_123_0 + arg_123_0 and not isNil(arg_120_1.actors_["1034ui_story"]) and arg_120_1.var_.characterEffect1034ui_story then
				arg_120_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action6_2")
			end

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_123_2 = 0
			local var_123_3 = 0.7

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_2 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_4 = arg_120_1:GetWordFromCfg(1103401030)
				local var_123_5 = arg_120_1:FormatText(var_123_4.content)

				arg_120_1.text_.text = var_123_5

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_7 = 28 <= 0 and var_123_3 or var_123_3 * (utf8.len(var_123_5) / 28)

				if (28 <= 0 and var_123_3 or var_123_3 * (utf8.len(var_123_5) / 28)) > 0 and var_123_3 < var_123_7 then
					arg_120_1.talkMaxDuration = var_123_7

					if var_123_7 + var_123_2 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_7 + var_123_2
					end
				end

				arg_120_1.text_.text = var_123_5
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401030", "story_v_side_new_1103401.awb") ~= 0 then
					local var_123_8 = manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401030", "story_v_side_new_1103401.awb") / 1000

					if var_123_8 + var_123_2 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_8 + var_123_2
					end

					if var_123_4.prefab_name ~= "" and arg_120_1.actors_[var_123_4.prefab_name] ~= nil then
						local var_123_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_4.prefab_name].transform, "story_v_side_new_1103401", "1103401030", "story_v_side_new_1103401.awb")

						arg_120_1:RecordAudio("1103401030", var_123_9)
						arg_120_1:RecordAudio("1103401030", var_123_9)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_side_new_1103401", "1103401030", "story_v_side_new_1103401.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_side_new_1103401", "1103401030", "story_v_side_new_1103401.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_10 = math.max(var_123_3, arg_120_1.talkMaxDuration)

			if var_123_2 <= arg_120_1.time_ and arg_120_1.time_ < var_123_2 + var_123_10 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_2) / var_123_10

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_2 + var_123_10 and arg_120_1.time_ < var_123_2 + var_123_10 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play1103401031 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 1103401031
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play1103401032(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(arg_124_1.actors_["1034ui_story"]) and arg_124_1.var_.characterEffect1034ui_story == nil then
				arg_124_1.var_.characterEffect1034ui_story = arg_124_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_0 = 0.200000002980232

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_0 and not isNil(arg_124_1.actors_["1034ui_story"]) then
				if arg_124_1.var_.characterEffect1034ui_story and not isNil(arg_124_1.actors_["1034ui_story"]) then
					arg_124_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_124_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_124_1.time_ - 0) / var_127_0)
				end
			end

			if arg_124_1.time_ >= 0 + var_127_0 and arg_124_1.time_ < 0 + var_127_0 + arg_127_0 and not isNil(arg_124_1.actors_["1034ui_story"]) and arg_124_1.var_.characterEffect1034ui_story then
				arg_124_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_124_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_127_1 = 0
			local var_127_2 = 0.5

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, true)
				arg_124_1.iconController_:SetSelectedState("hero")

				arg_124_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_124_1.callingController_:SetSelectedState("normal")

				arg_124_1.keyicon_.color = Color.New(1, 1, 1)
				arg_124_1.icon_.color = Color.New(1, 1, 1)

				local var_127_3 = arg_124_1:FormatText(arg_124_1:GetWordFromCfg(1103401031).content)

				arg_124_1.text_.text = var_127_3

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_5 = 20 <= 0 and var_127_2 or var_127_2 * (utf8.len(var_127_3) / 20)

				if (20 <= 0 and var_127_2 or var_127_2 * (utf8.len(var_127_3) / 20)) > 0 and var_127_2 < var_127_5 then
					arg_124_1.talkMaxDuration = var_127_5

					if var_127_5 + var_127_1 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_5 + var_127_1
					end
				end

				arg_124_1.text_.text = var_127_3
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_6 = math.max(var_127_2, arg_124_1.talkMaxDuration)

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_6 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_1) / var_127_6

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_1 + var_127_6 and arg_124_1.time_ < var_127_1 + var_127_6 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play1103401032 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 1103401032
		arg_128_1.duration_ = 6.5

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play1103401033(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(arg_128_1.actors_["1034ui_story"]) and arg_128_1.var_.characterEffect1034ui_story == nil then
				arg_128_1.var_.characterEffect1034ui_story = arg_128_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_0 = 0.200000002980232

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_0 and not isNil(arg_128_1.actors_["1034ui_story"]) then
				if arg_128_1.var_.characterEffect1034ui_story and not isNil(arg_128_1.actors_["1034ui_story"]) then
					arg_128_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= 0 + var_131_0 and arg_128_1.time_ < 0 + var_131_0 + arg_131_0 and not isNil(arg_128_1.actors_["1034ui_story"]) and arg_128_1.var_.characterEffect1034ui_story then
				arg_128_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_131_2 = 0
			local var_131_3 = 0.55

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_2 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_4 = arg_128_1:GetWordFromCfg(1103401032)
				local var_131_5 = arg_128_1:FormatText(var_131_4.content)

				arg_128_1.text_.text = var_131_5

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_7 = 22 <= 0 and var_131_3 or var_131_3 * (utf8.len(var_131_5) / 22)

				if (22 <= 0 and var_131_3 or var_131_3 * (utf8.len(var_131_5) / 22)) > 0 and var_131_3 < var_131_7 then
					arg_128_1.talkMaxDuration = var_131_7

					if var_131_7 + var_131_2 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_7 + var_131_2
					end
				end

				arg_128_1.text_.text = var_131_5
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401032", "story_v_side_new_1103401.awb") ~= 0 then
					local var_131_8 = manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401032", "story_v_side_new_1103401.awb") / 1000

					if var_131_8 + var_131_2 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_8 + var_131_2
					end

					if var_131_4.prefab_name ~= "" and arg_128_1.actors_[var_131_4.prefab_name] ~= nil then
						local var_131_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_4.prefab_name].transform, "story_v_side_new_1103401", "1103401032", "story_v_side_new_1103401.awb")

						arg_128_1:RecordAudio("1103401032", var_131_9)
						arg_128_1:RecordAudio("1103401032", var_131_9)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_side_new_1103401", "1103401032", "story_v_side_new_1103401.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_side_new_1103401", "1103401032", "story_v_side_new_1103401.awb")
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
	Play1103401033 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 1103401033
		arg_132_1.duration_ = 5

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play1103401034(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(arg_132_1.actors_["1034ui_story"]) and arg_132_1.var_.characterEffect1034ui_story == nil then
				arg_132_1.var_.characterEffect1034ui_story = arg_132_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_0 = 0.200000002980232

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_0 and not isNil(arg_132_1.actors_["1034ui_story"]) then
				if arg_132_1.var_.characterEffect1034ui_story and not isNil(arg_132_1.actors_["1034ui_story"]) then
					arg_132_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_132_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_132_1.time_ - 0) / var_135_0)
				end
			end

			if arg_132_1.time_ >= 0 + var_135_0 and arg_132_1.time_ < 0 + var_135_0 + arg_135_0 and not isNil(arg_132_1.actors_["1034ui_story"]) and arg_132_1.var_.characterEffect1034ui_story then
				arg_132_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_132_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_wuyuA", "EmotionTimelineAnimator")
			end

			local var_135_1 = 0
			local var_135_2 = 0.075

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, true)
				arg_132_1.iconController_:SetSelectedState("hero")

				arg_132_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_132_1.callingController_:SetSelectedState("normal")

				arg_132_1.keyicon_.color = Color.New(1, 1, 1)
				arg_132_1.icon_.color = Color.New(1, 1, 1)

				local var_135_3 = arg_132_1:FormatText(arg_132_1:GetWordFromCfg(1103401033).content)

				arg_132_1.text_.text = var_135_3

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_5 = 3 <= 0 and var_135_2 or var_135_2 * (utf8.len(var_135_3) / 3)

				if (3 <= 0 and var_135_2 or var_135_2 * (utf8.len(var_135_3) / 3)) > 0 and var_135_2 < var_135_5 then
					arg_132_1.talkMaxDuration = var_135_5

					if var_135_5 + var_135_1 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_5 + var_135_1
					end
				end

				arg_132_1.text_.text = var_135_3
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)
				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_6 = math.max(var_135_2, arg_132_1.talkMaxDuration)

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_6 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_1) / var_135_6

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_1 + var_135_6 and arg_132_1.time_ < var_135_1 + var_135_6 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play1103401034 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 1103401034
		arg_136_1.duration_ = 4.13

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play1103401035(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(arg_136_1.actors_["1034ui_story"]) and arg_136_1.var_.characterEffect1034ui_story == nil then
				arg_136_1.var_.characterEffect1034ui_story = arg_136_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_0 = 0.200000002980232

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_0 and not isNil(arg_136_1.actors_["1034ui_story"]) then
				if arg_136_1.var_.characterEffect1034ui_story and not isNil(arg_136_1.actors_["1034ui_story"]) then
					arg_136_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= 0 + var_139_0 and arg_136_1.time_ < 0 + var_139_0 + arg_139_0 and not isNil(arg_136_1.actors_["1034ui_story"]) and arg_136_1.var_.characterEffect1034ui_story then
				arg_136_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action7_1")
			end

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_139_2 = 0
			local var_139_3 = 0.375

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_2 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_4 = arg_136_1:GetWordFromCfg(1103401034)
				local var_139_5 = arg_136_1:FormatText(var_139_4.content)

				arg_136_1.text_.text = var_139_5

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_7 = 15 <= 0 and var_139_3 or var_139_3 * (utf8.len(var_139_5) / 15)

				if (15 <= 0 and var_139_3 or var_139_3 * (utf8.len(var_139_5) / 15)) > 0 and var_139_3 < var_139_7 then
					arg_136_1.talkMaxDuration = var_139_7

					if var_139_7 + var_139_2 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_7 + var_139_2
					end
				end

				arg_136_1.text_.text = var_139_5
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401034", "story_v_side_new_1103401.awb") ~= 0 then
					local var_139_8 = manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401034", "story_v_side_new_1103401.awb") / 1000

					if var_139_8 + var_139_2 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_8 + var_139_2
					end

					if var_139_4.prefab_name ~= "" and arg_136_1.actors_[var_139_4.prefab_name] ~= nil then
						local var_139_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_4.prefab_name].transform, "story_v_side_new_1103401", "1103401034", "story_v_side_new_1103401.awb")

						arg_136_1:RecordAudio("1103401034", var_139_9)
						arg_136_1:RecordAudio("1103401034", var_139_9)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_side_new_1103401", "1103401034", "story_v_side_new_1103401.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_side_new_1103401", "1103401034", "story_v_side_new_1103401.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_10 = math.max(var_139_3, arg_136_1.talkMaxDuration)

			if var_139_2 <= arg_136_1.time_ and arg_136_1.time_ < var_139_2 + var_139_10 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_2) / var_139_10

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_2 + var_139_10 and arg_136_1.time_ < var_139_2 + var_139_10 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play1103401035 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 1103401035
		arg_140_1.duration_ = 9

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play1103401036(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if arg_140_1.bgs_.ST03 == nil then
				local var_143_0 = Object.Instantiate(arg_140_1.paintGo_)

				var_143_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST03")
				var_143_0.name = "ST03"
				var_143_0.transform.parent = arg_140_1.stage_.transform
				var_143_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_140_1.bgs_.ST03 = var_143_0
			end

			if 2 < arg_140_1.time_ and arg_140_1.time_ <= 2 + arg_143_0 then
				local var_143_1 = arg_140_1.bgs_.ST03

				arg_140_1.bgs_.ST03.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_143_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_143_2 = var_143_1:GetComponent("SpriteRenderer")

				if var_143_2 and var_143_2.sprite then
					local var_143_3 = 2 * (var_143_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_143_1.transform.localScale = Vector3.New(var_143_3 / var_143_2.sprite.bounds.size.y < var_143_3 * manager.ui.mainCameraCom_.aspect / var_143_2.sprite.bounds.size.x and var_143_3 * manager.ui.mainCameraCom_.aspect / var_143_2.sprite.bounds.size.x or var_143_3 / var_143_2.sprite.bounds.size.y, var_143_3 / var_143_2.sprite.bounds.size.y < var_143_3 * manager.ui.mainCameraCom_.aspect / var_143_2.sprite.bounds.size.x and var_143_3 * manager.ui.mainCameraCom_.aspect / var_143_2.sprite.bounds.size.x or var_143_3 / var_143_2.sprite.bounds.size.y, 0)
				end

				for iter_143_0, iter_143_1 in pairs(arg_140_1.bgs_) do
					if iter_143_0 ~= "ST03" then
						iter_143_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_143_4 = 4

			if 4 < arg_140_1.time_ and arg_140_1.time_ <= var_143_4 + arg_143_0 then
				arg_140_1.allBtn_.enabled = false
			end

			if arg_140_1.time_ >= var_143_4 + 0.3 and arg_140_1.time_ < var_143_4 + 0.3 + arg_143_0 then
				arg_140_1.allBtn_.enabled = true
			end

			local var_143_5 = 0

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_5 + arg_143_0 then
				arg_140_1.mask_.enabled = true
				arg_140_1.mask_.raycastTarget = true

				arg_140_1:SetGaussion(false)
			end

			local var_143_6 = 2

			if var_143_5 <= arg_140_1.time_ and arg_140_1.time_ < var_143_5 + var_143_6 then
				local var_143_7 = Color.New(0, 0, 0)

				var_143_7.a = Mathf.Lerp(0, 1, (arg_140_1.time_ - var_143_5) / var_143_6)
				arg_140_1.mask_.color = var_143_7
			end

			if arg_140_1.time_ >= var_143_5 + var_143_6 and arg_140_1.time_ < var_143_5 + var_143_6 + arg_143_0 then
				local var_143_8 = Color.New(0, 0, 0)

				var_143_8.a = 1
				arg_140_1.mask_.color = var_143_8
			end

			local var_143_9 = 2

			if 2 < arg_140_1.time_ and arg_140_1.time_ <= var_143_9 + arg_143_0 then
				arg_140_1.mask_.enabled = true
				arg_140_1.mask_.raycastTarget = true

				arg_140_1:SetGaussion(false)
			end

			local var_143_10 = 2

			if var_143_9 <= arg_140_1.time_ and arg_140_1.time_ < var_143_9 + var_143_10 then
				local var_143_11 = Color.New(0, 0, 0)

				var_143_11.a = Mathf.Lerp(1, 0, (arg_140_1.time_ - var_143_9) / var_143_10)
				arg_140_1.mask_.color = var_143_11
			end

			if arg_140_1.time_ >= var_143_9 + var_143_10 and arg_140_1.time_ < var_143_9 + var_143_10 + arg_143_0 then
				local var_143_12 = Color.New(0, 0, 0)

				arg_140_1.mask_.enabled = false
				var_143_12.a = 0
				arg_140_1.mask_.color = var_143_12
			end

			local var_143_13 = arg_140_1.actors_["1034ui_story"].transform

			if 1.98333333333333 < arg_140_1.time_ and arg_140_1.time_ <= 1.98333333333333 + arg_143_0 then
				arg_140_1.var_.moveOldPos1034ui_story = var_143_13.localPosition
			end

			local var_143_14 = 0.001

			if 1.98333333333333 <= arg_140_1.time_ and arg_140_1.time_ < 1.98333333333333 + var_143_14 then
				var_143_13.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos1034ui_story, Vector3.New(0, 100, 0), (arg_140_1.time_ - 1.98333333333333) / var_143_14)
				var_143_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_143_13.position).x, (manager.ui.mainCamera.transform.position - var_143_13.position).y, (manager.ui.mainCamera.transform.position - var_143_13.position).z)
				var_143_13.localEulerAngles.z = 0
				var_143_13.localEulerAngles.x = 0
				var_143_13.localEulerAngles = var_143_13.localEulerAngles
			end

			if arg_140_1.time_ >= 1.98333333333333 + var_143_14 and arg_140_1.time_ < 1.98333333333333 + var_143_14 + arg_143_0 then
				var_143_13.localPosition = Vector3.New(0, 100, 0)
				var_143_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_143_13.position).x, (manager.ui.mainCamera.transform.position - var_143_13.position).y, (manager.ui.mainCamera.transform.position - var_143_13.position).z)
				var_143_13.localEulerAngles.z = 0
				var_143_13.localEulerAngles.x = 0
				var_143_13.localEulerAngles = var_143_13.localEulerAngles
			end

			local var_143_15 = arg_140_1.actors_["1034ui_story"]

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(var_143_15) and arg_140_1.var_.characterEffect1034ui_story == nil then
				arg_140_1.var_.characterEffect1034ui_story = var_143_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_16 = 0.200000002980232

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_16 and not isNil(var_143_15) then
				if arg_140_1.var_.characterEffect1034ui_story and not isNil(var_143_15) then
					arg_140_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_140_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_140_1.time_ - 0) / var_143_16)
				end
			end

			if arg_140_1.time_ >= 0 + var_143_16 and arg_140_1.time_ < 0 + var_143_16 + arg_143_0 and not isNil(var_143_15) and arg_140_1.var_.characterEffect1034ui_story then
				arg_140_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_140_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				if arg_140_1.var_.effect7897987987897979 then
					Object.Destroy(arg_140_1.var_.effect7897987987897979)

					arg_140_1.var_.effect7897987987897979 = nil
				end
			end

			if 0.133333333333333 < arg_140_1.time_ and arg_140_1.time_ <= 0.133333333333333 + arg_143_0 then
				arg_140_1:AudioAction("stop", "effect", "se_story_143", "se_story_143_amb_room", "")
			end

			if 1.5 < arg_140_1.time_ and arg_140_1.time_ <= 1.5 + arg_143_0 then
				arg_140_1:AudioAction("play", "effect", "se_story_142", "se_story_142_amb_city_street", "")
			end

			if arg_140_1.frameCnt_ <= 1 then
				arg_140_1.dialog_:SetActive(false)
			end

			local var_143_20 = 4
			local var_143_21 = 2.075

			if 4 < arg_140_1.time_ and arg_140_1.time_ <= var_143_20 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0

				arg_140_1.dialog_:SetActive(true)

				arg_140_1.dialogCg_.alpha = 0

				local var_143_22 = LeanTween.value(arg_140_1.dialog_, 0, 1, 0.3)

				var_143_22:setOnUpdate(LuaHelper.FloatAction(function(arg_144_0)
					arg_140_1.dialogCg_.alpha = arg_144_0
				end))
				var_143_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_140_1.dialog_)
					var_143_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_140_1.duration_ = arg_140_1.duration_ + 0.3

				SetActive(arg_140_1.leftNameGo_, false)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_23 = arg_140_1:FormatText(arg_140_1:GetWordFromCfg(1103401035).content)

				arg_140_1.text_.text = var_143_23

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_25 = 83 <= 0 and var_143_21 or var_143_21 * (utf8.len(var_143_23) / 83)

				if (83 <= 0 and var_143_21 or var_143_21 * (utf8.len(var_143_23) / 83)) > 0 and var_143_21 < var_143_25 then
					arg_140_1.talkMaxDuration = var_143_25
					var_143_20 = var_143_20 + 0.3

					if var_143_25 + var_143_20 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_25 + var_143_20
					end
				end

				arg_140_1.text_.text = var_143_23
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_26 = var_143_20 + 0.3
			local var_143_27 = math.max(var_143_21, arg_140_1.talkMaxDuration)

			if var_143_20 + 0.3 <= arg_140_1.time_ and arg_140_1.time_ < var_143_26 + var_143_27 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_26) / var_143_27

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_26 + var_143_27 and arg_140_1.time_ < var_143_26 + var_143_27 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1.98333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_140_1:InitPlayNodeList()
	end,
	Play1103401036 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 1103401036
		arg_146_1.duration_ = 5

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play1103401037(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = 0.4

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				arg_146_1.leftNameTxt_.text = arg_146_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, true)
				arg_146_1.iconController_:SetSelectedState("hero")

				arg_146_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_146_1.callingController_:SetSelectedState("normal")

				arg_146_1.keyicon_.color = Color.New(1, 1, 1)
				arg_146_1.icon_.color = Color.New(1, 1, 1)

				local var_149_1 = arg_146_1:FormatText(arg_146_1:GetWordFromCfg(1103401036).content)

				arg_146_1.text_.text = var_149_1

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_3 = 16 <= 0 and var_149_0 or var_149_0 * (utf8.len(var_149_1) / 16)

				if (16 <= 0 and var_149_0 or var_149_0 * (utf8.len(var_149_1) / 16)) > 0 and var_149_0 < var_149_3 then
					arg_146_1.talkMaxDuration = var_149_3

					if var_149_3 + 0 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_3 + 0
					end
				end

				arg_146_1.text_.text = var_149_1
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)
				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_4 = math.max(var_149_0, arg_146_1.talkMaxDuration)

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_4 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - 0) / var_149_4

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= 0 + var_149_4 and arg_146_1.time_ < 0 + var_149_4 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play1103401037 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 1103401037
		arg_150_1.duration_ = 5

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play1103401038(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1.var_.moveOldPos1034ui_story = arg_150_1.actors_["1034ui_story"].transform.localPosition
			end

			local var_153_0 = 0.001

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_0 then
				arg_150_1.actors_["1034ui_story"].transform.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos1034ui_story, Vector3.New(0, 100, 0), (arg_150_1.time_ - 0) / var_153_0)
				arg_150_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_150_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_150_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_150_1.actors_["1034ui_story"].transform.position).z)
				arg_150_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_150_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_150_1.actors_["1034ui_story"].transform.localEulerAngles = arg_150_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			if arg_150_1.time_ >= 0 + var_153_0 and arg_150_1.time_ < 0 + var_153_0 + arg_153_0 then
				arg_150_1.actors_["1034ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_150_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_150_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_150_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_150_1.actors_["1034ui_story"].transform.position).z)
				arg_150_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_150_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_150_1.actors_["1034ui_story"].transform.localEulerAngles = arg_150_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			local var_153_1 = arg_150_1.actors_["1034ui_story"]

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 and not isNil(var_153_1) and arg_150_1.var_.characterEffect1034ui_story == nil then
				arg_150_1.var_.characterEffect1034ui_story = var_153_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_2 = 0.200000002980232

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_2 and not isNil(var_153_1) then
				if arg_150_1.var_.characterEffect1034ui_story and not isNil(var_153_1) then
					arg_150_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_150_1.time_ >= 0 + var_153_2 and arg_150_1.time_ < 0 + var_153_2 + arg_153_0 and not isNil(var_153_1) and arg_150_1.var_.characterEffect1034ui_story then
				arg_150_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				if arg_150_1.var_.characterEffect1034ui_story == nil then
					arg_150_1.var_.characterEffect1034ui_story = arg_150_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_153_4 = arg_150_1.var_.characterEffect1034ui_story

				arg_150_1.var_.characterEffect1034ui_story.imageEffect:turnOff()

				var_153_4.interferenceEffect.enabled = false
				var_153_4.interferenceEffect.noise = 1
				var_153_4.interferenceEffect.simTimeScale = 1
				var_153_4.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_153_5 = 0
			local var_153_6 = 0.475

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_5 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				arg_150_1.leftNameTxt_.text = arg_150_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, true)
				arg_150_1.iconController_:SetSelectedState("hero")

				arg_150_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034_split_1")

				arg_150_1.callingController_:SetSelectedState("calling")

				arg_150_1.keyicon_.color = Color.New(1, 1, 1)
				arg_150_1.icon_.color = Color.New(1, 1, 1)

				local var_153_7 = arg_150_1:GetWordFromCfg(1103401037)
				local var_153_8 = arg_150_1:FormatText(var_153_7.content)

				arg_150_1.text_.text = var_153_8

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_10 = 19 <= 0 and var_153_6 or var_153_6 * (utf8.len(var_153_8) / 19)

				if (19 <= 0 and var_153_6 or var_153_6 * (utf8.len(var_153_8) / 19)) > 0 and var_153_6 < var_153_10 then
					arg_150_1.talkMaxDuration = var_153_10

					if var_153_10 + var_153_5 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_10 + var_153_5
					end
				end

				arg_150_1.text_.text = var_153_8
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401037", "story_v_side_new_1103401.awb") ~= 0 then
					local var_153_11 = manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401037", "story_v_side_new_1103401.awb") / 1000

					if var_153_11 + var_153_5 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_11 + var_153_5
					end

					if var_153_7.prefab_name ~= "" and arg_150_1.actors_[var_153_7.prefab_name] ~= nil then
						local var_153_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_7.prefab_name].transform, "story_v_side_new_1103401", "1103401037", "story_v_side_new_1103401.awb")

						arg_150_1:RecordAudio("1103401037", var_153_12)
						arg_150_1:RecordAudio("1103401037", var_153_12)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_side_new_1103401", "1103401037", "story_v_side_new_1103401.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_side_new_1103401", "1103401037", "story_v_side_new_1103401.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_13 = math.max(var_153_6, arg_150_1.talkMaxDuration)

			if var_153_5 <= arg_150_1.time_ and arg_150_1.time_ < var_153_5 + var_153_13 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_5) / var_153_13

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_5 + var_153_13 and arg_150_1.time_ < var_153_5 + var_153_13 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
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
	Play1103401038 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 1103401038
		arg_154_1.duration_ = 5

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play1103401039(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_9000

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 and not isNil(arg_154_1.actors_["1034ui_story"]) and arg_154_1.var_.characterEffect1034ui_story == nil then
				arg_154_1.var_.characterEffect1034ui_story = arg_154_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_0 = 0.200000002980232

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_0 and not isNil(arg_154_1.actors_["1034ui_story"]) then
				if arg_154_1.var_.characterEffect1034ui_story and not isNil(arg_154_1.actors_["1034ui_story"]) then
					arg_154_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_154_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_154_1.time_ - 0) / var_157_0)
				end
			end

			if arg_154_1.time_ >= 0 + var_157_0 and arg_154_1.time_ < 0 + var_157_0 + arg_157_0 and not isNil(arg_154_1.actors_["1034ui_story"]) and arg_154_1.var_.characterEffect1034ui_story then
				arg_154_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_154_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				local var_157_1 = arg_154_1.var_.effectqwieuweqiuweq

				if not arg_154_1.var_.effectqwieuweqiuweq then
					var_157_1 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dust_1"), manager.ui.mainCamera.transform)
					var_157_1.name = "qwieuweqiuweq"
					arg_154_1.var_.effectqwieuweqiuweq = var_157_1
				else
					var_157_1.transform:SetParent(var_157_9000)
				end

				var_157_1.transform.localPosition = Vector3.New(0, 0, 0)
				var_157_1.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_157_3 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_157_0, iter_157_1 in ipairs((var_157_1.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_157_1.transform.localScale = Vector3.New(iter_157_1.transform.localScale.x / var_157_3 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_157_1.transform.localScale.y / var_157_3, iter_157_1.transform.localScale.z)
				end
			end

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1:AudioAction("play", "effect", "se_story_140", "se_story_140_car_brake", "")
			end

			local var_157_6 = 0
			local var_157_7 = 2.15

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_6 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, false)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_8 = arg_154_1:FormatText(arg_154_1:GetWordFromCfg(1103401038).content)

				arg_154_1.text_.text = var_157_8

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_10 = 86 <= 0 and var_157_7 or var_157_7 * (utf8.len(var_157_8) / 86)

				if (86 <= 0 and var_157_7 or var_157_7 * (utf8.len(var_157_8) / 86)) > 0 and var_157_7 < var_157_10 then
					arg_154_1.talkMaxDuration = var_157_10

					if var_157_10 + var_157_6 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_10 + var_157_6
					end
				end

				arg_154_1.text_.text = var_157_8
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)
				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_11 = math.max(var_157_7, arg_154_1.talkMaxDuration)

			if var_157_6 <= arg_154_1.time_ and arg_154_1.time_ < var_157_6 + var_157_11 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_6) / var_157_11

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_6 + var_157_11 and arg_154_1.time_ < var_157_6 + var_157_11 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ST03",
				frequency = 100,
				className = "StoryShakeNode",
				duration = 1,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.DIALOG,
				offset = Vector3.New(2, 0, 0)
			},
			{
				assetPath = "",
				actorName = "ST03",
				frequency = 100,
				className = "StoryShakeNode",
				duration = 1,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.SPRITE,
				offset = Vector3.New(0.05, 0, 0)
			}
		}

		arg_154_1:InitPlayNodeList()
	end,
	Play1103401039 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 1103401039
		arg_158_1.duration_ = 5.3

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play1103401040(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 and not isNil(arg_158_1.actors_["1034ui_story"]) and arg_158_1.var_.characterEffect1034ui_story == nil then
				arg_158_1.var_.characterEffect1034ui_story = arg_158_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_0 = 0.200000002980232

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_0 and not isNil(arg_158_1.actors_["1034ui_story"]) then
				if arg_158_1.var_.characterEffect1034ui_story and not isNil(arg_158_1.actors_["1034ui_story"]) then
					arg_158_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_158_1.time_ >= 0 + var_161_0 and arg_158_1.time_ < 0 + var_161_0 + arg_161_0 and not isNil(arg_158_1.actors_["1034ui_story"]) and arg_158_1.var_.characterEffect1034ui_story then
				arg_158_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action7_1")
			end

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_161_2 = 0
			local var_161_3 = 0.575

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_2 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				arg_158_1.leftNameTxt_.text = arg_158_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, true)
				arg_158_1.iconController_:SetSelectedState("hero")

				arg_158_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034")

				arg_158_1.callingController_:SetSelectedState("normal")

				arg_158_1.keyicon_.color = Color.New(1, 1, 1)
				arg_158_1.icon_.color = Color.New(1, 1, 1)

				local var_161_4 = arg_158_1:GetWordFromCfg(1103401039)
				local var_161_5 = arg_158_1:FormatText(var_161_4.content)

				arg_158_1.text_.text = var_161_5

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_7 = 23 <= 0 and var_161_3 or var_161_3 * (utf8.len(var_161_5) / 23)

				if (23 <= 0 and var_161_3 or var_161_3 * (utf8.len(var_161_5) / 23)) > 0 and var_161_3 < var_161_7 then
					arg_158_1.talkMaxDuration = var_161_7

					if var_161_7 + var_161_2 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_7 + var_161_2
					end
				end

				arg_158_1.text_.text = var_161_5
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401039", "story_v_side_new_1103401.awb") ~= 0 then
					local var_161_8 = manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401039", "story_v_side_new_1103401.awb") / 1000

					if var_161_8 + var_161_2 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_8 + var_161_2
					end

					if var_161_4.prefab_name ~= "" and arg_158_1.actors_[var_161_4.prefab_name] ~= nil then
						local var_161_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_4.prefab_name].transform, "story_v_side_new_1103401", "1103401039", "story_v_side_new_1103401.awb")

						arg_158_1:RecordAudio("1103401039", var_161_9)
						arg_158_1:RecordAudio("1103401039", var_161_9)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_side_new_1103401", "1103401039", "story_v_side_new_1103401.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_side_new_1103401", "1103401039", "story_v_side_new_1103401.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_10 = math.max(var_161_3, arg_158_1.talkMaxDuration)

			if var_161_2 <= arg_158_1.time_ and arg_158_1.time_ < var_161_2 + var_161_10 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_2) / var_161_10

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_2 + var_161_10 and arg_158_1.time_ < var_161_2 + var_161_10 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play1103401040 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 1103401040
		arg_162_1.duration_ = 5

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play1103401041(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = 0.15

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				arg_162_1.leftNameTxt_.text = arg_162_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, true)
				arg_162_1.iconController_:SetSelectedState("hero")

				arg_162_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_162_1.callingController_:SetSelectedState("normal")

				arg_162_1.keyicon_.color = Color.New(1, 1, 1)
				arg_162_1.icon_.color = Color.New(1, 1, 1)

				local var_165_1 = arg_162_1:FormatText(arg_162_1:GetWordFromCfg(1103401040).content)

				arg_162_1.text_.text = var_165_1

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_3 = 6 <= 0 and var_165_0 or var_165_0 * (utf8.len(var_165_1) / 6)

				if (6 <= 0 and var_165_0 or var_165_0 * (utf8.len(var_165_1) / 6)) > 0 and var_165_0 < var_165_3 then
					arg_162_1.talkMaxDuration = var_165_3

					if var_165_3 + 0 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_3 + 0
					end
				end

				arg_162_1.text_.text = var_165_1
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)
				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_4 = math.max(var_165_0, arg_162_1.talkMaxDuration)

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_4 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - 0) / var_165_4

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= 0 + var_165_4 and arg_162_1.time_ < 0 + var_165_4 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play1103401041 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 1103401041
		arg_166_1.duration_ = 3.5

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play1103401042(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 and not isNil(arg_166_1.actors_["1034ui_story"]) and arg_166_1.var_.characterEffect1034ui_story == nil then
				arg_166_1.var_.characterEffect1034ui_story = arg_166_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_0 = 0.200000002980232

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_0 and not isNil(arg_166_1.actors_["1034ui_story"]) then
				if arg_166_1.var_.characterEffect1034ui_story and not isNil(arg_166_1.actors_["1034ui_story"]) then
					arg_166_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_166_1.time_ >= 0 + var_169_0 and arg_166_1.time_ < 0 + var_169_0 + arg_169_0 and not isNil(arg_166_1.actors_["1034ui_story"]) and arg_166_1.var_.characterEffect1034ui_story then
				arg_166_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action5_1")
			end

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_zhayanR", "EmotionTimelineAnimator")
			end

			local var_169_2 = arg_166_1.actors_["1034ui_story"].transform

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1.var_.moveOldPos1034ui_story = var_169_2.localPosition
			end

			local var_169_3 = 0.001

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_3 then
				var_169_2.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos1034ui_story, Vector3.New(0, -0.93, -6), (arg_166_1.time_ - 0) / var_169_3)
				var_169_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_169_2.position).x, (manager.ui.mainCamera.transform.position - var_169_2.position).y, (manager.ui.mainCamera.transform.position - var_169_2.position).z)
				var_169_2.localEulerAngles.z = 0
				var_169_2.localEulerAngles.x = 0
				var_169_2.localEulerAngles = var_169_2.localEulerAngles
			end

			if arg_166_1.time_ >= 0 + var_169_3 and arg_166_1.time_ < 0 + var_169_3 + arg_169_0 then
				var_169_2.localPosition = Vector3.New(0, -0.93, -6)
				var_169_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_169_2.position).x, (manager.ui.mainCamera.transform.position - var_169_2.position).y, (manager.ui.mainCamera.transform.position - var_169_2.position).z)
				var_169_2.localEulerAngles.z = 0
				var_169_2.localEulerAngles.x = 0
				var_169_2.localEulerAngles = var_169_2.localEulerAngles
			end

			local var_169_4 = 0
			local var_169_5 = 0.625

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_4 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				arg_166_1.leftNameTxt_.text = arg_166_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_6 = arg_166_1:GetWordFromCfg(1103401041)
				local var_169_7 = arg_166_1:FormatText(var_169_6.content)

				arg_166_1.text_.text = var_169_7

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_9 = 25 <= 0 and var_169_5 or var_169_5 * (utf8.len(var_169_7) / 25)

				if (25 <= 0 and var_169_5 or var_169_5 * (utf8.len(var_169_7) / 25)) > 0 and var_169_5 < var_169_9 then
					arg_166_1.talkMaxDuration = var_169_9

					if var_169_9 + var_169_4 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_9 + var_169_4
					end
				end

				arg_166_1.text_.text = var_169_7
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401041", "story_v_side_new_1103401.awb") ~= 0 then
					local var_169_10 = manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401041", "story_v_side_new_1103401.awb") / 1000

					if var_169_10 + var_169_4 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_10 + var_169_4
					end

					if var_169_6.prefab_name ~= "" and arg_166_1.actors_[var_169_6.prefab_name] ~= nil then
						local var_169_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_6.prefab_name].transform, "story_v_side_new_1103401", "1103401041", "story_v_side_new_1103401.awb")

						arg_166_1:RecordAudio("1103401041", var_169_11)
						arg_166_1:RecordAudio("1103401041", var_169_11)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_side_new_1103401", "1103401041", "story_v_side_new_1103401.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_side_new_1103401", "1103401041", "story_v_side_new_1103401.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_12 = math.max(var_169_5, arg_166_1.talkMaxDuration)

			if var_169_4 <= arg_166_1.time_ and arg_166_1.time_ < var_169_4 + var_169_12 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_4) / var_169_12

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_4 + var_169_12 and arg_166_1.time_ < var_169_4 + var_169_12 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0333333333333333,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_166_1:InitPlayNodeList()
	end,
	Play1103401042 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 1103401042
		arg_170_1.duration_ = 4.1

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play1103401043(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = 0.55

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				arg_170_1.leftNameTxt_.text = arg_170_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_1 = arg_170_1:GetWordFromCfg(1103401042)
				local var_173_2 = arg_170_1:FormatText(var_173_1.content)

				arg_170_1.text_.text = var_173_2

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_4 = 22 <= 0 and var_173_0 or var_173_0 * (utf8.len(var_173_2) / 22)

				if (22 <= 0 and var_173_0 or var_173_0 * (utf8.len(var_173_2) / 22)) > 0 and var_173_0 < var_173_4 then
					arg_170_1.talkMaxDuration = var_173_4

					if var_173_4 + 0 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_4 + 0
					end
				end

				arg_170_1.text_.text = var_173_2
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401042", "story_v_side_new_1103401.awb") ~= 0 then
					local var_173_5 = manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401042", "story_v_side_new_1103401.awb") / 1000

					if var_173_5 + 0 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_5 + 0
					end

					if var_173_1.prefab_name ~= "" and arg_170_1.actors_[var_173_1.prefab_name] ~= nil then
						local var_173_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_1.prefab_name].transform, "story_v_side_new_1103401", "1103401042", "story_v_side_new_1103401.awb")

						arg_170_1:RecordAudio("1103401042", var_173_6)
						arg_170_1:RecordAudio("1103401042", var_173_6)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_side_new_1103401", "1103401042", "story_v_side_new_1103401.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_side_new_1103401", "1103401042", "story_v_side_new_1103401.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_7 = math.max(var_173_0, arg_170_1.talkMaxDuration)

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_7 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - 0) / var_173_7

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= 0 + var_173_7 and arg_170_1.time_ < 0 + var_173_7 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play1103401043 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 1103401043
		arg_174_1.duration_ = 5

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play1103401044(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 and not isNil(arg_174_1.actors_["1034ui_story"]) and arg_174_1.var_.characterEffect1034ui_story == nil then
				arg_174_1.var_.characterEffect1034ui_story = arg_174_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_0 = 0.200000002980232

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_0 and not isNil(arg_174_1.actors_["1034ui_story"]) then
				if arg_174_1.var_.characterEffect1034ui_story and not isNil(arg_174_1.actors_["1034ui_story"]) then
					arg_174_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_174_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_174_1.time_ - 0) / var_177_0)
				end
			end

			if arg_174_1.time_ >= 0 + var_177_0 and arg_174_1.time_ < 0 + var_177_0 + arg_177_0 and not isNil(arg_174_1.actors_["1034ui_story"]) and arg_174_1.var_.characterEffect1034ui_story then
				arg_174_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_174_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_177_1 = 0
			local var_177_2 = 0.3

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_1 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				arg_174_1.leftNameTxt_.text = arg_174_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, true)
				arg_174_1.iconController_:SetSelectedState("hero")

				arg_174_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_174_1.callingController_:SetSelectedState("normal")

				arg_174_1.keyicon_.color = Color.New(1, 1, 1)
				arg_174_1.icon_.color = Color.New(1, 1, 1)

				local var_177_3 = arg_174_1:FormatText(arg_174_1:GetWordFromCfg(1103401043).content)

				arg_174_1.text_.text = var_177_3

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_5 = 12 <= 0 and var_177_2 or var_177_2 * (utf8.len(var_177_3) / 12)

				if (12 <= 0 and var_177_2 or var_177_2 * (utf8.len(var_177_3) / 12)) > 0 and var_177_2 < var_177_5 then
					arg_174_1.talkMaxDuration = var_177_5

					if var_177_5 + var_177_1 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_5 + var_177_1
					end
				end

				arg_174_1.text_.text = var_177_3
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)
				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_6 = math.max(var_177_2, arg_174_1.talkMaxDuration)

			if var_177_1 <= arg_174_1.time_ and arg_174_1.time_ < var_177_1 + var_177_6 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_1) / var_177_6

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_1 + var_177_6 and arg_174_1.time_ < var_177_1 + var_177_6 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play1103401044 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 1103401044
		arg_178_1.duration_ = 4.23

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play1103401045(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 and not isNil(arg_178_1.actors_["1034ui_story"]) and arg_178_1.var_.characterEffect1034ui_story == nil then
				arg_178_1.var_.characterEffect1034ui_story = arg_178_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_0 = 0.200000002980232

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_0 and not isNil(arg_178_1.actors_["1034ui_story"]) then
				if arg_178_1.var_.characterEffect1034ui_story and not isNil(arg_178_1.actors_["1034ui_story"]) then
					arg_178_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_178_1.time_ >= 0 + var_181_0 and arg_178_1.time_ < 0 + var_181_0 + arg_181_0 and not isNil(arg_178_1.actors_["1034ui_story"]) and arg_178_1.var_.characterEffect1034ui_story then
				arg_178_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action5_2")
			end

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_181_2 = 0
			local var_181_3 = 0.5

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_2 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				arg_178_1.leftNameTxt_.text = arg_178_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_4 = arg_178_1:GetWordFromCfg(1103401044)
				local var_181_5 = arg_178_1:FormatText(var_181_4.content)

				arg_178_1.text_.text = var_181_5

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_7 = 20 <= 0 and var_181_3 or var_181_3 * (utf8.len(var_181_5) / 20)

				if (20 <= 0 and var_181_3 or var_181_3 * (utf8.len(var_181_5) / 20)) > 0 and var_181_3 < var_181_7 then
					arg_178_1.talkMaxDuration = var_181_7

					if var_181_7 + var_181_2 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_7 + var_181_2
					end
				end

				arg_178_1.text_.text = var_181_5
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401044", "story_v_side_new_1103401.awb") ~= 0 then
					local var_181_8 = manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401044", "story_v_side_new_1103401.awb") / 1000

					if var_181_8 + var_181_2 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_8 + var_181_2
					end

					if var_181_4.prefab_name ~= "" and arg_178_1.actors_[var_181_4.prefab_name] ~= nil then
						local var_181_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_4.prefab_name].transform, "story_v_side_new_1103401", "1103401044", "story_v_side_new_1103401.awb")

						arg_178_1:RecordAudio("1103401044", var_181_9)
						arg_178_1:RecordAudio("1103401044", var_181_9)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_side_new_1103401", "1103401044", "story_v_side_new_1103401.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_side_new_1103401", "1103401044", "story_v_side_new_1103401.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_10 = math.max(var_181_3, arg_178_1.talkMaxDuration)

			if var_181_2 <= arg_178_1.time_ and arg_178_1.time_ < var_181_2 + var_181_10 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_2) / var_181_10

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_2 + var_181_10 and arg_178_1.time_ < var_181_2 + var_181_10 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play1103401045 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 1103401045
		arg_182_1.duration_ = 3.7

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play1103401046(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action6_1")
			end

			local var_185_0 = 0
			local var_185_1 = 0.35

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_0 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				arg_182_1.leftNameTxt_.text = arg_182_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_2 = arg_182_1:GetWordFromCfg(1103401045)
				local var_185_3 = arg_182_1:FormatText(var_185_2.content)

				arg_182_1.text_.text = var_185_3

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_5 = 14 <= 0 and var_185_1 or var_185_1 * (utf8.len(var_185_3) / 14)

				if (14 <= 0 and var_185_1 or var_185_1 * (utf8.len(var_185_3) / 14)) > 0 and var_185_1 < var_185_5 then
					arg_182_1.talkMaxDuration = var_185_5

					if var_185_5 + var_185_0 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_5 + var_185_0
					end
				end

				arg_182_1.text_.text = var_185_3
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401045", "story_v_side_new_1103401.awb") ~= 0 then
					local var_185_6 = manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401045", "story_v_side_new_1103401.awb") / 1000

					if var_185_6 + var_185_0 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_6 + var_185_0
					end

					if var_185_2.prefab_name ~= "" and arg_182_1.actors_[var_185_2.prefab_name] ~= nil then
						local var_185_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_2.prefab_name].transform, "story_v_side_new_1103401", "1103401045", "story_v_side_new_1103401.awb")

						arg_182_1:RecordAudio("1103401045", var_185_7)
						arg_182_1:RecordAudio("1103401045", var_185_7)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_side_new_1103401", "1103401045", "story_v_side_new_1103401.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_side_new_1103401", "1103401045", "story_v_side_new_1103401.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_8 = math.max(var_185_1, arg_182_1.talkMaxDuration)

			if var_185_0 <= arg_182_1.time_ and arg_182_1.time_ < var_185_0 + var_185_8 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_0) / var_185_8

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_0 + var_185_8 and arg_182_1.time_ < var_185_0 + var_185_8 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play1103401046 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 1103401046
		arg_186_1.duration_ = 5

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play1103401047(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 and not isNil(arg_186_1.actors_["1034ui_story"]) and arg_186_1.var_.characterEffect1034ui_story == nil then
				arg_186_1.var_.characterEffect1034ui_story = arg_186_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_0 = 0.200000002980232

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_0 and not isNil(arg_186_1.actors_["1034ui_story"]) then
				if arg_186_1.var_.characterEffect1034ui_story and not isNil(arg_186_1.actors_["1034ui_story"]) then
					arg_186_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_186_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_186_1.time_ - 0) / var_189_0)
				end
			end

			if arg_186_1.time_ >= 0 + var_189_0 and arg_186_1.time_ < 0 + var_189_0 + arg_189_0 and not isNil(arg_186_1.actors_["1034ui_story"]) and arg_186_1.var_.characterEffect1034ui_story then
				arg_186_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_186_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			if 0.366666666666667 < arg_186_1.time_ and arg_186_1.time_ <= 0.366666666666667 + arg_189_0 then
				arg_186_1:AudioAction("play", "effect", "se_story_side_1034", "se_story_side_1034_car_door", "")
			end

			local var_189_2 = 0
			local var_189_3 = 1.175

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_2 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, false)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_4 = arg_186_1:FormatText(arg_186_1:GetWordFromCfg(1103401046).content)

				arg_186_1.text_.text = var_189_4

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_6 = 47 <= 0 and var_189_3 or var_189_3 * (utf8.len(var_189_4) / 47)

				if (47 <= 0 and var_189_3 or var_189_3 * (utf8.len(var_189_4) / 47)) > 0 and var_189_3 < var_189_6 then
					arg_186_1.talkMaxDuration = var_189_6

					if var_189_6 + var_189_2 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_6 + var_189_2
					end
				end

				arg_186_1.text_.text = var_189_4
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)
				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_7 = math.max(var_189_3, arg_186_1.talkMaxDuration)

			if var_189_2 <= arg_186_1.time_ and arg_186_1.time_ < var_189_2 + var_189_7 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_2) / var_189_7

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_2 + var_189_7 and arg_186_1.time_ < var_189_2 + var_189_7 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play1103401047 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 1103401047
		arg_190_1.duration_ = 3.3

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play1103401048(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 and not isNil(arg_190_1.actors_["1034ui_story"]) and arg_190_1.var_.characterEffect1034ui_story == nil then
				arg_190_1.var_.characterEffect1034ui_story = arg_190_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_0 = 0.200000002980232

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_0 and not isNil(arg_190_1.actors_["1034ui_story"]) then
				if arg_190_1.var_.characterEffect1034ui_story and not isNil(arg_190_1.actors_["1034ui_story"]) then
					arg_190_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_190_1.time_ >= 0 + var_193_0 and arg_190_1.time_ < 0 + var_193_0 + arg_193_0 and not isNil(arg_190_1.actors_["1034ui_story"]) and arg_190_1.var_.characterEffect1034ui_story then
				arg_190_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_193_2 = 0
			local var_193_3 = 0.3

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_2 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				arg_190_1.leftNameTxt_.text = arg_190_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_4 = arg_190_1:GetWordFromCfg(1103401047)
				local var_193_5 = arg_190_1:FormatText(var_193_4.content)

				arg_190_1.text_.text = var_193_5

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_7 = 12 <= 0 and var_193_3 or var_193_3 * (utf8.len(var_193_5) / 12)

				if (12 <= 0 and var_193_3 or var_193_3 * (utf8.len(var_193_5) / 12)) > 0 and var_193_3 < var_193_7 then
					arg_190_1.talkMaxDuration = var_193_7

					if var_193_7 + var_193_2 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_7 + var_193_2
					end
				end

				arg_190_1.text_.text = var_193_5
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401047", "story_v_side_new_1103401.awb") ~= 0 then
					local var_193_8 = manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401047", "story_v_side_new_1103401.awb") / 1000

					if var_193_8 + var_193_2 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_8 + var_193_2
					end

					if var_193_4.prefab_name ~= "" and arg_190_1.actors_[var_193_4.prefab_name] ~= nil then
						local var_193_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_4.prefab_name].transform, "story_v_side_new_1103401", "1103401047", "story_v_side_new_1103401.awb")

						arg_190_1:RecordAudio("1103401047", var_193_9)
						arg_190_1:RecordAudio("1103401047", var_193_9)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_side_new_1103401", "1103401047", "story_v_side_new_1103401.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_side_new_1103401", "1103401047", "story_v_side_new_1103401.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_10 = math.max(var_193_3, arg_190_1.talkMaxDuration)

			if var_193_2 <= arg_190_1.time_ and arg_190_1.time_ < var_193_2 + var_193_10 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_2) / var_193_10

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_2 + var_193_10 and arg_190_1.time_ < var_193_2 + var_193_10 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play1103401048 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 1103401048
		arg_194_1.duration_ = 8.4

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play1103401049(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			if 0.8 < arg_194_1.time_ and arg_194_1.time_ <= 0.8 + arg_197_0 then
				arg_194_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034actionlink/1034action463")
			end

			if 0.8 < arg_194_1.time_ and arg_194_1.time_ <= 0.8 + arg_197_0 then
				arg_194_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_197_0 = 0

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_0 + arg_197_0 then
				arg_194_1.mask_.enabled = true
				arg_194_1.mask_.raycastTarget = false

				arg_194_1:SetGaussion(false)
			end

			local var_197_1 = 0.166666666666667

			if var_197_0 <= arg_194_1.time_ and arg_194_1.time_ < var_197_0 + var_197_1 then
				local var_197_2 = Color.New(1, 1, 1)

				var_197_2.a = Mathf.Lerp(1, 0, (arg_194_1.time_ - var_197_0) / var_197_1)
				arg_194_1.mask_.color = var_197_2
			end

			if arg_194_1.time_ >= var_197_0 + var_197_1 and arg_194_1.time_ < var_197_0 + var_197_1 + arg_197_0 then
				local var_197_3 = Color.New(1, 1, 1)

				arg_194_1.mask_.enabled = false
				var_197_3.a = 0
				arg_194_1.mask_.color = var_197_3
			end

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1:AudioAction("play", "effect", "se_story_122_03", "se_story_122_03_camera", "")
			end

			local var_197_5 = 0
			local var_197_6 = 0.95

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_5 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				arg_194_1.leftNameTxt_.text = arg_194_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_7 = arg_194_1:GetWordFromCfg(1103401048)
				local var_197_8 = arg_194_1:FormatText(var_197_7.content)

				arg_194_1.text_.text = var_197_8

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_10 = 38 <= 0 and var_197_6 or var_197_6 * (utf8.len(var_197_8) / 38)

				if (38 <= 0 and var_197_6 or var_197_6 * (utf8.len(var_197_8) / 38)) > 0 and var_197_6 < var_197_10 then
					arg_194_1.talkMaxDuration = var_197_10

					if var_197_10 + var_197_5 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_10 + var_197_5
					end
				end

				arg_194_1.text_.text = var_197_8
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401048", "story_v_side_new_1103401.awb") ~= 0 then
					local var_197_11 = manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401048", "story_v_side_new_1103401.awb") / 1000

					if var_197_11 + var_197_5 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_11 + var_197_5
					end

					if var_197_7.prefab_name ~= "" and arg_194_1.actors_[var_197_7.prefab_name] ~= nil then
						local var_197_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_7.prefab_name].transform, "story_v_side_new_1103401", "1103401048", "story_v_side_new_1103401.awb")

						arg_194_1:RecordAudio("1103401048", var_197_12)
						arg_194_1:RecordAudio("1103401048", var_197_12)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_side_new_1103401", "1103401048", "story_v_side_new_1103401.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_side_new_1103401", "1103401048", "story_v_side_new_1103401.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_13 = math.max(var_197_6, arg_194_1.talkMaxDuration)

			if var_197_5 <= arg_194_1.time_ and arg_194_1.time_ < var_197_5 + var_197_13 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_5) / var_197_13

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_5 + var_197_13 and arg_194_1.time_ < var_197_5 + var_197_13 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play1103401049 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 1103401049
		arg_198_1.duration_ = 5.8

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play1103401050(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034actionlink/1034action436")
			end

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_201_0 = 0
			local var_201_1 = 0.65

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_0 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				arg_198_1.leftNameTxt_.text = arg_198_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_2 = arg_198_1:GetWordFromCfg(1103401049)
				local var_201_3 = arg_198_1:FormatText(var_201_2.content)

				arg_198_1.text_.text = var_201_3

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_5 = 26 <= 0 and var_201_1 or var_201_1 * (utf8.len(var_201_3) / 26)

				if (26 <= 0 and var_201_1 or var_201_1 * (utf8.len(var_201_3) / 26)) > 0 and var_201_1 < var_201_5 then
					arg_198_1.talkMaxDuration = var_201_5

					if var_201_5 + var_201_0 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_5 + var_201_0
					end
				end

				arg_198_1.text_.text = var_201_3
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401049", "story_v_side_new_1103401.awb") ~= 0 then
					local var_201_6 = manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401049", "story_v_side_new_1103401.awb") / 1000

					if var_201_6 + var_201_0 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_6 + var_201_0
					end

					if var_201_2.prefab_name ~= "" and arg_198_1.actors_[var_201_2.prefab_name] ~= nil then
						local var_201_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_2.prefab_name].transform, "story_v_side_new_1103401", "1103401049", "story_v_side_new_1103401.awb")

						arg_198_1:RecordAudio("1103401049", var_201_7)
						arg_198_1:RecordAudio("1103401049", var_201_7)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_side_new_1103401", "1103401049", "story_v_side_new_1103401.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_side_new_1103401", "1103401049", "story_v_side_new_1103401.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_8 = math.max(var_201_1, arg_198_1.talkMaxDuration)

			if var_201_0 <= arg_198_1.time_ and arg_198_1.time_ < var_201_0 + var_201_8 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_0) / var_201_8

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_0 + var_201_8 and arg_198_1.time_ < var_201_0 + var_201_8 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play1103401050 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 1103401050
		arg_202_1.duration_ = 5

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play1103401051(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 and not isNil(arg_202_1.actors_["1034ui_story"]) and arg_202_1.var_.characterEffect1034ui_story == nil then
				arg_202_1.var_.characterEffect1034ui_story = arg_202_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_0 = 0.200000002980232

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_0 and not isNil(arg_202_1.actors_["1034ui_story"]) then
				if arg_202_1.var_.characterEffect1034ui_story and not isNil(arg_202_1.actors_["1034ui_story"]) then
					arg_202_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_202_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_202_1.time_ - 0) / var_205_0)
				end
			end

			if arg_202_1.time_ >= 0 + var_205_0 and arg_202_1.time_ < 0 + var_205_0 + arg_205_0 and not isNil(arg_202_1.actors_["1034ui_story"]) and arg_202_1.var_.characterEffect1034ui_story then
				arg_202_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_202_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_205_1 = 0
			local var_205_2 = 0.35

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_1 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				arg_202_1.leftNameTxt_.text = arg_202_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, true)
				arg_202_1.iconController_:SetSelectedState("hero")

				arg_202_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_202_1.callingController_:SetSelectedState("normal")

				arg_202_1.keyicon_.color = Color.New(1, 1, 1)
				arg_202_1.icon_.color = Color.New(1, 1, 1)

				local var_205_3 = arg_202_1:FormatText(arg_202_1:GetWordFromCfg(1103401050).content)

				arg_202_1.text_.text = var_205_3

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_5 = 14 <= 0 and var_205_2 or var_205_2 * (utf8.len(var_205_3) / 14)

				if (14 <= 0 and var_205_2 or var_205_2 * (utf8.len(var_205_3) / 14)) > 0 and var_205_2 < var_205_5 then
					arg_202_1.talkMaxDuration = var_205_5

					if var_205_5 + var_205_1 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_5 + var_205_1
					end
				end

				arg_202_1.text_.text = var_205_3
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)
				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_6 = math.max(var_205_2, arg_202_1.talkMaxDuration)

			if var_205_1 <= arg_202_1.time_ and arg_202_1.time_ < var_205_1 + var_205_6 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_1) / var_205_6

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_1 + var_205_6 and arg_202_1.time_ < var_205_1 + var_205_6 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play1103401051 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 1103401051
		arg_206_1.duration_ = 2

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play1103401052(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 and not isNil(arg_206_1.actors_["1034ui_story"]) and arg_206_1.var_.characterEffect1034ui_story == nil then
				arg_206_1.var_.characterEffect1034ui_story = arg_206_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_209_0 = 0.200000002980232

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_0 and not isNil(arg_206_1.actors_["1034ui_story"]) then
				if arg_206_1.var_.characterEffect1034ui_story and not isNil(arg_206_1.actors_["1034ui_story"]) then
					arg_206_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_206_1.time_ >= 0 + var_209_0 and arg_206_1.time_ < 0 + var_209_0 + arg_209_0 and not isNil(arg_206_1.actors_["1034ui_story"]) and arg_206_1.var_.characterEffect1034ui_story then
				arg_206_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action6_2")
			end

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_209_2 = 0
			local var_209_3 = 0.225

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_2 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				arg_206_1.leftNameTxt_.text = arg_206_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_4 = arg_206_1:GetWordFromCfg(1103401051)
				local var_209_5 = arg_206_1:FormatText(var_209_4.content)

				arg_206_1.text_.text = var_209_5

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_7 = 9 <= 0 and var_209_3 or var_209_3 * (utf8.len(var_209_5) / 9)

				if (9 <= 0 and var_209_3 or var_209_3 * (utf8.len(var_209_5) / 9)) > 0 and var_209_3 < var_209_7 then
					arg_206_1.talkMaxDuration = var_209_7

					if var_209_7 + var_209_2 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_7 + var_209_2
					end
				end

				arg_206_1.text_.text = var_209_5
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401051", "story_v_side_new_1103401.awb") ~= 0 then
					local var_209_8 = manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401051", "story_v_side_new_1103401.awb") / 1000

					if var_209_8 + var_209_2 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_8 + var_209_2
					end

					if var_209_4.prefab_name ~= "" and arg_206_1.actors_[var_209_4.prefab_name] ~= nil then
						local var_209_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_4.prefab_name].transform, "story_v_side_new_1103401", "1103401051", "story_v_side_new_1103401.awb")

						arg_206_1:RecordAudio("1103401051", var_209_9)
						arg_206_1:RecordAudio("1103401051", var_209_9)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_side_new_1103401", "1103401051", "story_v_side_new_1103401.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_side_new_1103401", "1103401051", "story_v_side_new_1103401.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_10 = math.max(var_209_3, arg_206_1.talkMaxDuration)

			if var_209_2 <= arg_206_1.time_ and arg_206_1.time_ < var_209_2 + var_209_10 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_2) / var_209_10

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_2 + var_209_10 and arg_206_1.time_ < var_209_2 + var_209_10 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	Play1103401052 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 1103401052
		arg_210_1.duration_ = 5

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play1103401053(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 and not isNil(arg_210_1.actors_["1034ui_story"]) and arg_210_1.var_.characterEffect1034ui_story == nil then
				arg_210_1.var_.characterEffect1034ui_story = arg_210_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_0 = 0.200000002980232

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_0 and not isNil(arg_210_1.actors_["1034ui_story"]) then
				if arg_210_1.var_.characterEffect1034ui_story and not isNil(arg_210_1.actors_["1034ui_story"]) then
					arg_210_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_210_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_210_1.time_ - 0) / var_213_0)
				end
			end

			if arg_210_1.time_ >= 0 + var_213_0 and arg_210_1.time_ < 0 + var_213_0 + arg_213_0 and not isNil(arg_210_1.actors_["1034ui_story"]) and arg_210_1.var_.characterEffect1034ui_story then
				arg_210_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_210_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_213_1 = 0
			local var_213_2 = 0.45

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_1 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				arg_210_1.leftNameTxt_.text = arg_210_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, true)
				arg_210_1.iconController_:SetSelectedState("hero")

				arg_210_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_210_1.callingController_:SetSelectedState("normal")

				arg_210_1.keyicon_.color = Color.New(1, 1, 1)
				arg_210_1.icon_.color = Color.New(1, 1, 1)

				local var_213_3 = arg_210_1:FormatText(arg_210_1:GetWordFromCfg(1103401052).content)

				arg_210_1.text_.text = var_213_3

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_5 = 18 <= 0 and var_213_2 or var_213_2 * (utf8.len(var_213_3) / 18)

				if (18 <= 0 and var_213_2 or var_213_2 * (utf8.len(var_213_3) / 18)) > 0 and var_213_2 < var_213_5 then
					arg_210_1.talkMaxDuration = var_213_5

					if var_213_5 + var_213_1 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_5 + var_213_1
					end
				end

				arg_210_1.text_.text = var_213_3
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)
				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_6 = math.max(var_213_2, arg_210_1.talkMaxDuration)

			if var_213_1 <= arg_210_1.time_ and arg_210_1.time_ < var_213_1 + var_213_6 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_1) / var_213_6

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_1 + var_213_6 and arg_210_1.time_ < var_213_1 + var_213_6 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play1103401053 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 1103401053
		arg_214_1.duration_ = 2

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play1103401054(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action5_1")
			end

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileF_biyan", "EmotionTimelineAnimator")
			end

			local var_217_0 = arg_214_1.actors_["1034ui_story"]

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 and not isNil(var_217_0) and arg_214_1.var_.characterEffect1034ui_story == nil then
				arg_214_1.var_.characterEffect1034ui_story = var_217_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_1 = 0.0333333333333333

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_1 and not isNil(var_217_0) then
				if arg_214_1.var_.characterEffect1034ui_story and not isNil(var_217_0) then
					arg_214_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_214_1.time_ >= 0 + var_217_1 and arg_214_1.time_ < 0 + var_217_1 + arg_217_0 and not isNil(var_217_0) and arg_214_1.var_.characterEffect1034ui_story then
				arg_214_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_217_3 = arg_214_1.actors_["1034ui_story"]

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 and not isNil(var_217_3) and arg_214_1.var_.characterEffect1034ui_story == nil then
				arg_214_1.var_.characterEffect1034ui_story = var_217_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_4 = 0.200000002980232

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_4 and not isNil(var_217_3) then
				if arg_214_1.var_.characterEffect1034ui_story and not isNil(var_217_3) then
					arg_214_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_214_1.time_ >= 0 + var_217_4 and arg_214_1.time_ < 0 + var_217_4 + arg_217_0 and not isNil(var_217_3) and arg_214_1.var_.characterEffect1034ui_story then
				arg_214_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_217_6 = 0
			local var_217_7 = 0.125

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_6 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				arg_214_1.leftNameTxt_.text = arg_214_1:FormatText(StoryNameCfg[1384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, true)
				arg_214_1.iconController_:SetSelectedState("hero")

				arg_214_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_214_1.callingController_:SetSelectedState("normal")

				arg_214_1.keyicon_.color = Color.New(1, 1, 1)
				arg_214_1.icon_.color = Color.New(1, 1, 1)

				local var_217_8 = arg_214_1:GetWordFromCfg(1103401053)
				local var_217_9 = arg_214_1:FormatText(var_217_8.content)

				arg_214_1.text_.text = var_217_9

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_11 = 5 <= 0 and var_217_7 or var_217_7 * (utf8.len(var_217_9) / 5)

				if (5 <= 0 and var_217_7 or var_217_7 * (utf8.len(var_217_9) / 5)) > 0 and var_217_7 < var_217_11 then
					arg_214_1.talkMaxDuration = var_217_11

					if var_217_11 + var_217_6 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_11 + var_217_6
					end
				end

				arg_214_1.text_.text = var_217_9
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401053", "story_v_side_new_1103401.awb") ~= 0 then
					local var_217_12 = manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401053", "story_v_side_new_1103401.awb") / 1000

					if var_217_12 + var_217_6 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_12 + var_217_6
					end

					if var_217_8.prefab_name ~= "" and arg_214_1.actors_[var_217_8.prefab_name] ~= nil then
						local var_217_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_8.prefab_name].transform, "story_v_side_new_1103401", "1103401053", "story_v_side_new_1103401.awb")

						arg_214_1:RecordAudio("1103401053", var_217_13)
						arg_214_1:RecordAudio("1103401053", var_217_13)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_side_new_1103401", "1103401053", "story_v_side_new_1103401.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_side_new_1103401", "1103401053", "story_v_side_new_1103401.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_14 = math.max(var_217_7, arg_214_1.talkMaxDuration)

			if var_217_6 <= arg_214_1.time_ and arg_214_1.time_ < var_217_6 + var_217_14 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_6) / var_217_14

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_6 + var_217_14 and arg_214_1.time_ < var_217_6 + var_217_14 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play1103401054 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 1103401054
		arg_218_1.duration_ = 5

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play1103401055(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034actionlink/1034action457")
			end

			local var_221_0 = arg_218_1.actors_["1034ui_story"]

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 and not isNil(var_221_0) and arg_218_1.var_.characterEffect1034ui_story == nil then
				arg_218_1.var_.characterEffect1034ui_story = var_221_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_1 = 0.166666666666667

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_1 and not isNil(var_221_0) then
				if arg_218_1.var_.characterEffect1034ui_story and not isNil(var_221_0) then
					arg_218_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_218_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_218_1.time_ - 0) / var_221_1)
				end
			end

			if arg_218_1.time_ >= 0 + var_221_1 and arg_218_1.time_ < 0 + var_221_1 + arg_221_0 and not isNil(var_221_0) and arg_218_1.var_.characterEffect1034ui_story then
				arg_218_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_218_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_221_2 = 0
			local var_221_3 = 1.475

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_2 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, false)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_4 = arg_218_1:FormatText(arg_218_1:GetWordFromCfg(1103401054).content)

				arg_218_1.text_.text = var_221_4

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_6 = 59 <= 0 and var_221_3 or var_221_3 * (utf8.len(var_221_4) / 59)

				if (59 <= 0 and var_221_3 or var_221_3 * (utf8.len(var_221_4) / 59)) > 0 and var_221_3 < var_221_6 then
					arg_218_1.talkMaxDuration = var_221_6

					if var_221_6 + var_221_2 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_6 + var_221_2
					end
				end

				arg_218_1.text_.text = var_221_4
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)
				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_7 = math.max(var_221_3, arg_218_1.talkMaxDuration)

			if var_221_2 <= arg_218_1.time_ and arg_218_1.time_ < var_221_2 + var_221_7 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_2) / var_221_7

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_2 + var_221_7 and arg_218_1.time_ < var_221_2 + var_221_7 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play1103401055 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 1103401055
		arg_222_1.duration_ = 3.93

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play1103401056(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 and not isNil(arg_222_1.actors_["1034ui_story"]) and arg_222_1.var_.characterEffect1034ui_story == nil then
				arg_222_1.var_.characterEffect1034ui_story = arg_222_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_0 = 0.200000002980232

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_0 and not isNil(arg_222_1.actors_["1034ui_story"]) then
				if arg_222_1.var_.characterEffect1034ui_story and not isNil(arg_222_1.actors_["1034ui_story"]) then
					arg_222_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_222_1.time_ >= 0 + var_225_0 and arg_222_1.time_ < 0 + var_225_0 + arg_225_0 and not isNil(arg_222_1.actors_["1034ui_story"]) and arg_222_1.var_.characterEffect1034ui_story then
				arg_222_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_225_2 = 0
			local var_225_3 = 0.5

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_2 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				arg_222_1.leftNameTxt_.text = arg_222_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_4 = arg_222_1:GetWordFromCfg(1103401055)
				local var_225_5 = arg_222_1:FormatText(var_225_4.content)

				arg_222_1.text_.text = var_225_5

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_7 = 20 <= 0 and var_225_3 or var_225_3 * (utf8.len(var_225_5) / 20)

				if (20 <= 0 and var_225_3 or var_225_3 * (utf8.len(var_225_5) / 20)) > 0 and var_225_3 < var_225_7 then
					arg_222_1.talkMaxDuration = var_225_7

					if var_225_7 + var_225_2 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_7 + var_225_2
					end
				end

				arg_222_1.text_.text = var_225_5
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401055", "story_v_side_new_1103401.awb") ~= 0 then
					local var_225_8 = manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401055", "story_v_side_new_1103401.awb") / 1000

					if var_225_8 + var_225_2 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_8 + var_225_2
					end

					if var_225_4.prefab_name ~= "" and arg_222_1.actors_[var_225_4.prefab_name] ~= nil then
						local var_225_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_4.prefab_name].transform, "story_v_side_new_1103401", "1103401055", "story_v_side_new_1103401.awb")

						arg_222_1:RecordAudio("1103401055", var_225_9)
						arg_222_1:RecordAudio("1103401055", var_225_9)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_side_new_1103401", "1103401055", "story_v_side_new_1103401.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_side_new_1103401", "1103401055", "story_v_side_new_1103401.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_10 = math.max(var_225_3, arg_222_1.talkMaxDuration)

			if var_225_2 <= arg_222_1.time_ and arg_222_1.time_ < var_225_2 + var_225_10 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_2) / var_225_10

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_2 + var_225_10 and arg_222_1.time_ < var_225_2 + var_225_10 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play1103401056 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 1103401056
		arg_226_1.duration_ = 5

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play1103401057(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 and not isNil(arg_226_1.actors_["1034ui_story"]) and arg_226_1.var_.characterEffect1034ui_story == nil then
				arg_226_1.var_.characterEffect1034ui_story = arg_226_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_0 = 0.200000002980232

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_0 and not isNil(arg_226_1.actors_["1034ui_story"]) then
				if arg_226_1.var_.characterEffect1034ui_story and not isNil(arg_226_1.actors_["1034ui_story"]) then
					arg_226_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_226_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_226_1.time_ - 0) / var_229_0)
				end
			end

			if arg_226_1.time_ >= 0 + var_229_0 and arg_226_1.time_ < 0 + var_229_0 + arg_229_0 and not isNil(arg_226_1.actors_["1034ui_story"]) and arg_226_1.var_.characterEffect1034ui_story then
				arg_226_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_226_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_229_1 = 0
			local var_229_2 = 0.725

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_1 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				arg_226_1.leftNameTxt_.text = arg_226_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, true)
				arg_226_1.iconController_:SetSelectedState("hero")

				arg_226_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_226_1.callingController_:SetSelectedState("normal")

				arg_226_1.keyicon_.color = Color.New(1, 1, 1)
				arg_226_1.icon_.color = Color.New(1, 1, 1)

				local var_229_3 = arg_226_1:FormatText(arg_226_1:GetWordFromCfg(1103401056).content)

				arg_226_1.text_.text = var_229_3

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_5 = 29 <= 0 and var_229_2 or var_229_2 * (utf8.len(var_229_3) / 29)

				if (29 <= 0 and var_229_2 or var_229_2 * (utf8.len(var_229_3) / 29)) > 0 and var_229_2 < var_229_5 then
					arg_226_1.talkMaxDuration = var_229_5

					if var_229_5 + var_229_1 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_5 + var_229_1
					end
				end

				arg_226_1.text_.text = var_229_3
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)
				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_6 = math.max(var_229_2, arg_226_1.talkMaxDuration)

			if var_229_1 <= arg_226_1.time_ and arg_226_1.time_ < var_229_1 + var_229_6 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_1) / var_229_6

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_1 + var_229_6 and arg_226_1.time_ < var_229_1 + var_229_6 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play1103401057 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 1103401057
		arg_230_1.duration_ = 6.8

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play1103401058(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 and not isNil(arg_230_1.actors_["1034ui_story"]) and arg_230_1.var_.characterEffect1034ui_story == nil then
				arg_230_1.var_.characterEffect1034ui_story = arg_230_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_0 = 0.200000002980232

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_0 and not isNil(arg_230_1.actors_["1034ui_story"]) then
				if arg_230_1.var_.characterEffect1034ui_story and not isNil(arg_230_1.actors_["1034ui_story"]) then
					arg_230_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_230_1.time_ >= 0 + var_233_0 and arg_230_1.time_ < 0 + var_233_0 + arg_233_0 and not isNil(arg_230_1.actors_["1034ui_story"]) and arg_230_1.var_.characterEffect1034ui_story then
				arg_230_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_233_2 = 0
			local var_233_3 = 0.8

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_2 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				arg_230_1.leftNameTxt_.text = arg_230_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_4 = arg_230_1:GetWordFromCfg(1103401057)
				local var_233_5 = arg_230_1:FormatText(var_233_4.content)

				arg_230_1.text_.text = var_233_5

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_7 = 32 <= 0 and var_233_3 or var_233_3 * (utf8.len(var_233_5) / 32)

				if (32 <= 0 and var_233_3 or var_233_3 * (utf8.len(var_233_5) / 32)) > 0 and var_233_3 < var_233_7 then
					arg_230_1.talkMaxDuration = var_233_7

					if var_233_7 + var_233_2 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_7 + var_233_2
					end
				end

				arg_230_1.text_.text = var_233_5
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401057", "story_v_side_new_1103401.awb") ~= 0 then
					local var_233_8 = manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401057", "story_v_side_new_1103401.awb") / 1000

					if var_233_8 + var_233_2 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_8 + var_233_2
					end

					if var_233_4.prefab_name ~= "" and arg_230_1.actors_[var_233_4.prefab_name] ~= nil then
						local var_233_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_4.prefab_name].transform, "story_v_side_new_1103401", "1103401057", "story_v_side_new_1103401.awb")

						arg_230_1:RecordAudio("1103401057", var_233_9)
						arg_230_1:RecordAudio("1103401057", var_233_9)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_side_new_1103401", "1103401057", "story_v_side_new_1103401.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_side_new_1103401", "1103401057", "story_v_side_new_1103401.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_10 = math.max(var_233_3, arg_230_1.talkMaxDuration)

			if var_233_2 <= arg_230_1.time_ and arg_230_1.time_ < var_233_2 + var_233_10 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_2) / var_233_10

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_2 + var_233_10 and arg_230_1.time_ < var_233_2 + var_233_10 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play1103401058 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 1103401058
		arg_234_1.duration_ = 5

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play1103401059(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 and not isNil(arg_234_1.actors_["1034ui_story"]) and arg_234_1.var_.characterEffect1034ui_story == nil then
				arg_234_1.var_.characterEffect1034ui_story = arg_234_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_0 = 0.200000002980232

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_0 and not isNil(arg_234_1.actors_["1034ui_story"]) then
				if arg_234_1.var_.characterEffect1034ui_story and not isNil(arg_234_1.actors_["1034ui_story"]) then
					arg_234_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_234_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_234_1.time_ - 0) / var_237_0)
				end
			end

			if arg_234_1.time_ >= 0 + var_237_0 and arg_234_1.time_ < 0 + var_237_0 + arg_237_0 and not isNil(arg_234_1.actors_["1034ui_story"]) and arg_234_1.var_.characterEffect1034ui_story then
				arg_234_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_234_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_237_1 = 0
			local var_237_2 = 0.075

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_1 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				arg_234_1.leftNameTxt_.text = arg_234_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, true)
				arg_234_1.iconController_:SetSelectedState("hero")

				arg_234_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_234_1.callingController_:SetSelectedState("normal")

				arg_234_1.keyicon_.color = Color.New(1, 1, 1)
				arg_234_1.icon_.color = Color.New(1, 1, 1)

				local var_237_3 = arg_234_1:FormatText(arg_234_1:GetWordFromCfg(1103401058).content)

				arg_234_1.text_.text = var_237_3

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_5 = 3 <= 0 and var_237_2 or var_237_2 * (utf8.len(var_237_3) / 3)

				if (3 <= 0 and var_237_2 or var_237_2 * (utf8.len(var_237_3) / 3)) > 0 and var_237_2 < var_237_5 then
					arg_234_1.talkMaxDuration = var_237_5

					if var_237_5 + var_237_1 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_5 + var_237_1
					end
				end

				arg_234_1.text_.text = var_237_3
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)
				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_6 = math.max(var_237_2, arg_234_1.talkMaxDuration)

			if var_237_1 <= arg_234_1.time_ and arg_234_1.time_ < var_237_1 + var_237_6 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_1) / var_237_6

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_1 + var_237_6 and arg_234_1.time_ < var_237_1 + var_237_6 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play1103401059 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 1103401059
		arg_238_1.duration_ = 5.03

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play1103401060(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 and not isNil(arg_238_1.actors_["1034ui_story"]) and arg_238_1.var_.characterEffect1034ui_story == nil then
				arg_238_1.var_.characterEffect1034ui_story = arg_238_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_0 = 0.200000002980232

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_0 and not isNil(arg_238_1.actors_["1034ui_story"]) then
				if arg_238_1.var_.characterEffect1034ui_story and not isNil(arg_238_1.actors_["1034ui_story"]) then
					arg_238_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_238_1.time_ >= 0 + var_241_0 and arg_238_1.time_ < 0 + var_241_0 + arg_241_0 and not isNil(arg_238_1.actors_["1034ui_story"]) and arg_238_1.var_.characterEffect1034ui_story then
				arg_238_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034actionlink/1034action476")
			end

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_biyanbiaozhun", "EmotionTimelineAnimator")
			end

			local var_241_2 = 0
			local var_241_3 = 0.7

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_2 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				arg_238_1.leftNameTxt_.text = arg_238_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_4 = arg_238_1:GetWordFromCfg(1103401059)
				local var_241_5 = arg_238_1:FormatText(var_241_4.content)

				arg_238_1.text_.text = var_241_5

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_7 = 28 <= 0 and var_241_3 or var_241_3 * (utf8.len(var_241_5) / 28)

				if (28 <= 0 and var_241_3 or var_241_3 * (utf8.len(var_241_5) / 28)) > 0 and var_241_3 < var_241_7 then
					arg_238_1.talkMaxDuration = var_241_7

					if var_241_7 + var_241_2 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_7 + var_241_2
					end
				end

				arg_238_1.text_.text = var_241_5
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401059", "story_v_side_new_1103401.awb") ~= 0 then
					local var_241_8 = manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401059", "story_v_side_new_1103401.awb") / 1000

					if var_241_8 + var_241_2 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_8 + var_241_2
					end

					if var_241_4.prefab_name ~= "" and arg_238_1.actors_[var_241_4.prefab_name] ~= nil then
						local var_241_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_4.prefab_name].transform, "story_v_side_new_1103401", "1103401059", "story_v_side_new_1103401.awb")

						arg_238_1:RecordAudio("1103401059", var_241_9)
						arg_238_1:RecordAudio("1103401059", var_241_9)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_side_new_1103401", "1103401059", "story_v_side_new_1103401.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_side_new_1103401", "1103401059", "story_v_side_new_1103401.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_10 = math.max(var_241_3, arg_238_1.talkMaxDuration)

			if var_241_2 <= arg_238_1.time_ and arg_238_1.time_ < var_241_2 + var_241_10 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_2) / var_241_10

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_2 + var_241_10 and arg_238_1.time_ < var_241_2 + var_241_10 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play1103401060 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 1103401060
		arg_242_1.duration_ = 5.7

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play1103401061(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_245_0 = 0
			local var_245_1 = 0.8

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_0 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				arg_242_1.leftNameTxt_.text = arg_242_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_2 = arg_242_1:GetWordFromCfg(1103401060)
				local var_245_3 = arg_242_1:FormatText(var_245_2.content)

				arg_242_1.text_.text = var_245_3

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_5 = 32 <= 0 and var_245_1 or var_245_1 * (utf8.len(var_245_3) / 32)

				if (32 <= 0 and var_245_1 or var_245_1 * (utf8.len(var_245_3) / 32)) > 0 and var_245_1 < var_245_5 then
					arg_242_1.talkMaxDuration = var_245_5

					if var_245_5 + var_245_0 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_5 + var_245_0
					end
				end

				arg_242_1.text_.text = var_245_3
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401060", "story_v_side_new_1103401.awb") ~= 0 then
					local var_245_6 = manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401060", "story_v_side_new_1103401.awb") / 1000

					if var_245_6 + var_245_0 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_6 + var_245_0
					end

					if var_245_2.prefab_name ~= "" and arg_242_1.actors_[var_245_2.prefab_name] ~= nil then
						local var_245_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_2.prefab_name].transform, "story_v_side_new_1103401", "1103401060", "story_v_side_new_1103401.awb")

						arg_242_1:RecordAudio("1103401060", var_245_7)
						arg_242_1:RecordAudio("1103401060", var_245_7)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_side_new_1103401", "1103401060", "story_v_side_new_1103401.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_side_new_1103401", "1103401060", "story_v_side_new_1103401.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_8 = math.max(var_245_1, arg_242_1.talkMaxDuration)

			if var_245_0 <= arg_242_1.time_ and arg_242_1.time_ < var_245_0 + var_245_8 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_0) / var_245_8

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_0 + var_245_8 and arg_242_1.time_ < var_245_0 + var_245_8 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {}

		arg_242_1:InitPlayNodeList()
	end,
	Play1103401061 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 1103401061
		arg_246_1.duration_ = 5

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play1103401062(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 and not isNil(arg_246_1.actors_["1034ui_story"]) and arg_246_1.var_.characterEffect1034ui_story == nil then
				arg_246_1.var_.characterEffect1034ui_story = arg_246_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_249_0 = 0.200000002980232

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_0 and not isNil(arg_246_1.actors_["1034ui_story"]) then
				if arg_246_1.var_.characterEffect1034ui_story and not isNil(arg_246_1.actors_["1034ui_story"]) then
					arg_246_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_246_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_246_1.time_ - 0) / var_249_0)
				end
			end

			if arg_246_1.time_ >= 0 + var_249_0 and arg_246_1.time_ < 0 + var_249_0 + arg_249_0 and not isNil(arg_246_1.actors_["1034ui_story"]) and arg_246_1.var_.characterEffect1034ui_story then
				arg_246_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_246_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_249_1 = 0
			local var_249_2 = 0.6

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= var_249_1 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				arg_246_1.leftNameTxt_.text = arg_246_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, true)
				arg_246_1.iconController_:SetSelectedState("hero")

				arg_246_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_246_1.callingController_:SetSelectedState("normal")

				arg_246_1.keyicon_.color = Color.New(1, 1, 1)
				arg_246_1.icon_.color = Color.New(1, 1, 1)

				local var_249_3 = arg_246_1:FormatText(arg_246_1:GetWordFromCfg(1103401061).content)

				arg_246_1.text_.text = var_249_3

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_5 = 24 <= 0 and var_249_2 or var_249_2 * (utf8.len(var_249_3) / 24)

				if (24 <= 0 and var_249_2 or var_249_2 * (utf8.len(var_249_3) / 24)) > 0 and var_249_2 < var_249_5 then
					arg_246_1.talkMaxDuration = var_249_5

					if var_249_5 + var_249_1 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_5 + var_249_1
					end
				end

				arg_246_1.text_.text = var_249_3
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)
				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_6 = math.max(var_249_2, arg_246_1.talkMaxDuration)

			if var_249_1 <= arg_246_1.time_ and arg_246_1.time_ < var_249_1 + var_249_6 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_1) / var_249_6

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_1 + var_249_6 and arg_246_1.time_ < var_249_1 + var_249_6 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play1103401062 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 1103401062
		arg_250_1.duration_ = 4.5

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play1103401063(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 and not isNil(arg_250_1.actors_["1034ui_story"]) and arg_250_1.var_.characterEffect1034ui_story == nil then
				arg_250_1.var_.characterEffect1034ui_story = arg_250_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_253_0 = 0.200000002980232

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_0 and not isNil(arg_250_1.actors_["1034ui_story"]) then
				if arg_250_1.var_.characterEffect1034ui_story and not isNil(arg_250_1.actors_["1034ui_story"]) then
					arg_250_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_250_1.time_ >= 0 + var_253_0 and arg_250_1.time_ < 0 + var_253_0 + arg_253_0 and not isNil(arg_250_1.actors_["1034ui_story"]) and arg_250_1.var_.characterEffect1034ui_story then
				arg_250_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_253_2 = 0
			local var_253_3 = 0.525

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_2 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				arg_250_1.leftNameTxt_.text = arg_250_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_4 = arg_250_1:GetWordFromCfg(1103401062)
				local var_253_5 = arg_250_1:FormatText(var_253_4.content)

				arg_250_1.text_.text = var_253_5

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_7 = 21 <= 0 and var_253_3 or var_253_3 * (utf8.len(var_253_5) / 21)

				if (21 <= 0 and var_253_3 or var_253_3 * (utf8.len(var_253_5) / 21)) > 0 and var_253_3 < var_253_7 then
					arg_250_1.talkMaxDuration = var_253_7

					if var_253_7 + var_253_2 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_7 + var_253_2
					end
				end

				arg_250_1.text_.text = var_253_5
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401062", "story_v_side_new_1103401.awb") ~= 0 then
					local var_253_8 = manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401062", "story_v_side_new_1103401.awb") / 1000

					if var_253_8 + var_253_2 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_8 + var_253_2
					end

					if var_253_4.prefab_name ~= "" and arg_250_1.actors_[var_253_4.prefab_name] ~= nil then
						local var_253_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_4.prefab_name].transform, "story_v_side_new_1103401", "1103401062", "story_v_side_new_1103401.awb")

						arg_250_1:RecordAudio("1103401062", var_253_9)
						arg_250_1:RecordAudio("1103401062", var_253_9)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_side_new_1103401", "1103401062", "story_v_side_new_1103401.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_side_new_1103401", "1103401062", "story_v_side_new_1103401.awb")
				end

				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_10 = math.max(var_253_3, arg_250_1.talkMaxDuration)

			if var_253_2 <= arg_250_1.time_ and arg_250_1.time_ < var_253_2 + var_253_10 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_2) / var_253_10

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_2 + var_253_10 and arg_250_1.time_ < var_253_2 + var_253_10 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play1103401063 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 1103401063
		arg_254_1.duration_ = 2

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"

			SetActive(arg_254_1.choicesGo_, true)

			for iter_255_0, iter_255_1 in ipairs(arg_254_1.choices_) do
				SetActive(iter_255_1.go, iter_255_0 <= 2)
			end

			arg_254_1.choices_[1].txt.text = arg_254_1:FormatText(StoryChoiceCfg[1446].name)
			arg_254_1.choices_[2].txt.text = arg_254_1:FormatText(StoryChoiceCfg[1447].name)
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play1103401064(arg_254_1)
			end

			if arg_256_0 == 2 then
				arg_254_0:Play1103401066(arg_254_1)
			end

			arg_254_1:RecordChoiceLog(1103401063, 1446, 1447)
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 and not isNil(arg_254_1.actors_["1034ui_story"]) and arg_254_1.var_.characterEffect1034ui_story == nil then
				arg_254_1.var_.characterEffect1034ui_story = arg_254_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_257_0 = 0.200000002980232

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_0 and not isNil(arg_254_1.actors_["1034ui_story"]) then
				if arg_254_1.var_.characterEffect1034ui_story and not isNil(arg_254_1.actors_["1034ui_story"]) then
					arg_254_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_254_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_254_1.time_ - 0) / var_257_0)
				end
			end

			if arg_254_1.time_ >= 0 + var_257_0 and arg_254_1.time_ < 0 + var_257_0 + arg_257_0 and not isNil(arg_254_1.actors_["1034ui_story"]) and arg_254_1.var_.characterEffect1034ui_story then
				arg_254_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_254_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_257_1 = 0

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_1 + arg_257_0 then
				arg_254_1.allBtn_.enabled = false
			end

			if arg_254_1.time_ >= var_257_1 + 0.5 and arg_254_1.time_ < var_257_1 + 0.5 + arg_257_0 then
				arg_254_1.allBtn_.enabled = true
			end

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play1103401064 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 1103401064
		arg_258_1.duration_ = 4.83

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play1103401065(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 and not isNil(arg_258_1.actors_["1034ui_story"]) and arg_258_1.var_.characterEffect1034ui_story == nil then
				arg_258_1.var_.characterEffect1034ui_story = arg_258_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_0 = 0.200000002980232

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_0 and not isNil(arg_258_1.actors_["1034ui_story"]) then
				if arg_258_1.var_.characterEffect1034ui_story and not isNil(arg_258_1.actors_["1034ui_story"]) then
					arg_258_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_258_1.time_ >= 0 + var_261_0 and arg_258_1.time_ < 0 + var_261_0 + arg_261_0 and not isNil(arg_258_1.actors_["1034ui_story"]) and arg_258_1.var_.characterEffect1034ui_story then
				arg_258_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034actionlink/1034action467")
			end

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_261_2 = 0
			local var_261_3 = 0.75

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_2 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				arg_258_1.leftNameTxt_.text = arg_258_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_4 = arg_258_1:GetWordFromCfg(1103401064)
				local var_261_5 = arg_258_1:FormatText(var_261_4.content)

				arg_258_1.text_.text = var_261_5

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_7 = 30 <= 0 and var_261_3 or var_261_3 * (utf8.len(var_261_5) / 30)

				if (30 <= 0 and var_261_3 or var_261_3 * (utf8.len(var_261_5) / 30)) > 0 and var_261_3 < var_261_7 then
					arg_258_1.talkMaxDuration = var_261_7

					if var_261_7 + var_261_2 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_7 + var_261_2
					end
				end

				arg_258_1.text_.text = var_261_5
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401064", "story_v_side_new_1103401.awb") ~= 0 then
					local var_261_8 = manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401064", "story_v_side_new_1103401.awb") / 1000

					if var_261_8 + var_261_2 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_8 + var_261_2
					end

					if var_261_4.prefab_name ~= "" and arg_258_1.actors_[var_261_4.prefab_name] ~= nil then
						local var_261_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_4.prefab_name].transform, "story_v_side_new_1103401", "1103401064", "story_v_side_new_1103401.awb")

						arg_258_1:RecordAudio("1103401064", var_261_9)
						arg_258_1:RecordAudio("1103401064", var_261_9)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_side_new_1103401", "1103401064", "story_v_side_new_1103401.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_side_new_1103401", "1103401064", "story_v_side_new_1103401.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_10 = math.max(var_261_3, arg_258_1.talkMaxDuration)

			if var_261_2 <= arg_258_1.time_ and arg_258_1.time_ < var_261_2 + var_261_10 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_2) / var_261_10

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_2 + var_261_10 and arg_258_1.time_ < var_261_2 + var_261_10 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play1103401065 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 1103401065
		arg_262_1.duration_ = 3

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play1103401067(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034actionlink/1034action475")
			end

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_265_0 = 0
			local var_265_1 = 0.45

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_0 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				arg_262_1.leftNameTxt_.text = arg_262_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_2 = arg_262_1:GetWordFromCfg(1103401065)
				local var_265_3 = arg_262_1:FormatText(var_265_2.content)

				arg_262_1.text_.text = var_265_3

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_5 = 18 <= 0 and var_265_1 or var_265_1 * (utf8.len(var_265_3) / 18)

				if (18 <= 0 and var_265_1 or var_265_1 * (utf8.len(var_265_3) / 18)) > 0 and var_265_1 < var_265_5 then
					arg_262_1.talkMaxDuration = var_265_5

					if var_265_5 + var_265_0 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_5 + var_265_0
					end
				end

				arg_262_1.text_.text = var_265_3
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401065", "story_v_side_new_1103401.awb") ~= 0 then
					local var_265_6 = manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401065", "story_v_side_new_1103401.awb") / 1000

					if var_265_6 + var_265_0 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_6 + var_265_0
					end

					if var_265_2.prefab_name ~= "" and arg_262_1.actors_[var_265_2.prefab_name] ~= nil then
						local var_265_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_2.prefab_name].transform, "story_v_side_new_1103401", "1103401065", "story_v_side_new_1103401.awb")

						arg_262_1:RecordAudio("1103401065", var_265_7)
						arg_262_1:RecordAudio("1103401065", var_265_7)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_side_new_1103401", "1103401065", "story_v_side_new_1103401.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_side_new_1103401", "1103401065", "story_v_side_new_1103401.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_8 = math.max(var_265_1, arg_262_1.talkMaxDuration)

			if var_265_0 <= arg_262_1.time_ and arg_262_1.time_ < var_265_0 + var_265_8 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_0) / var_265_8

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_0 + var_265_8 and arg_262_1.time_ < var_265_0 + var_265_8 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play1103401067 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 1103401067
		arg_266_1.duration_ = 5

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play1103401068(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 and not isNil(arg_266_1.actors_["1034ui_story"]) and arg_266_1.var_.characterEffect1034ui_story == nil then
				arg_266_1.var_.characterEffect1034ui_story = arg_266_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_0 = 0.200000002980232

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_0 and not isNil(arg_266_1.actors_["1034ui_story"]) then
				if arg_266_1.var_.characterEffect1034ui_story and not isNil(arg_266_1.actors_["1034ui_story"]) then
					arg_266_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_266_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_266_1.time_ - 0) / var_269_0)
				end
			end

			if arg_266_1.time_ >= 0 + var_269_0 and arg_266_1.time_ < 0 + var_269_0 + arg_269_0 and not isNil(arg_266_1.actors_["1034ui_story"]) and arg_266_1.var_.characterEffect1034ui_story then
				arg_266_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_266_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1:AudioAction("play", "effect", "se_story_side_1034", "se_story_side_1034_car_door", "")
			end

			local var_269_2 = 0
			local var_269_3 = 1.9

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_2 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, false)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_4 = arg_266_1:FormatText(arg_266_1:GetWordFromCfg(1103401067).content)

				arg_266_1.text_.text = var_269_4

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_6 = 76 <= 0 and var_269_3 or var_269_3 * (utf8.len(var_269_4) / 76)

				if (76 <= 0 and var_269_3 or var_269_3 * (utf8.len(var_269_4) / 76)) > 0 and var_269_3 < var_269_6 then
					arg_266_1.talkMaxDuration = var_269_6

					if var_269_6 + var_269_2 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_6 + var_269_2
					end
				end

				arg_266_1.text_.text = var_269_4
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)
				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_7 = math.max(var_269_3, arg_266_1.talkMaxDuration)

			if var_269_2 <= arg_266_1.time_ and arg_266_1.time_ < var_269_2 + var_269_7 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_2) / var_269_7

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_2 + var_269_7 and arg_266_1.time_ < var_269_2 + var_269_7 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play1103401068 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 1103401068
		arg_270_1.duration_ = 5

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play1103401069(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action5_2")
			end

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_273_0 = 0
			local var_273_1 = 0.275

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_0 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				arg_270_1.leftNameTxt_.text = arg_270_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, true)
				arg_270_1.iconController_:SetSelectedState("hero")

				arg_270_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_270_1.callingController_:SetSelectedState("normal")

				arg_270_1.keyicon_.color = Color.New(1, 1, 1)
				arg_270_1.icon_.color = Color.New(1, 1, 1)

				local var_273_2 = arg_270_1:FormatText(arg_270_1:GetWordFromCfg(1103401068).content)

				arg_270_1.text_.text = var_273_2

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_4 = 11 <= 0 and var_273_1 or var_273_1 * (utf8.len(var_273_2) / 11)

				if (11 <= 0 and var_273_1 or var_273_1 * (utf8.len(var_273_2) / 11)) > 0 and var_273_1 < var_273_4 then
					arg_270_1.talkMaxDuration = var_273_4

					if var_273_4 + var_273_0 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_4 + var_273_0
					end
				end

				arg_270_1.text_.text = var_273_2
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)
				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_5 = math.max(var_273_1, arg_270_1.talkMaxDuration)

			if var_273_0 <= arg_270_1.time_ and arg_270_1.time_ < var_273_0 + var_273_5 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_0) / var_273_5

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_0 + var_273_5 and arg_270_1.time_ < var_273_0 + var_273_5 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play1103401069 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 1103401069
		arg_274_1.duration_ = 6.77

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play1103401070(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 and not isNil(arg_274_1.actors_["1034ui_story"]) and arg_274_1.var_.characterEffect1034ui_story == nil then
				arg_274_1.var_.characterEffect1034ui_story = arg_274_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_0 = 0.200000002980232

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_0 and not isNil(arg_274_1.actors_["1034ui_story"]) then
				if arg_274_1.var_.characterEffect1034ui_story and not isNil(arg_274_1.actors_["1034ui_story"]) then
					arg_274_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_274_1.time_ >= 0 + var_277_0 and arg_274_1.time_ < 0 + var_277_0 + arg_277_0 and not isNil(arg_274_1.actors_["1034ui_story"]) and arg_274_1.var_.characterEffect1034ui_story then
				arg_274_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action6_1")
			end

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_wuyuC", "EmotionTimelineAnimator")
			end

			local var_277_2 = 0
			local var_277_3 = 0.875

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_2 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				arg_274_1.leftNameTxt_.text = arg_274_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_4 = arg_274_1:GetWordFromCfg(1103401069)
				local var_277_5 = arg_274_1:FormatText(var_277_4.content)

				arg_274_1.text_.text = var_277_5

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_7 = 35 <= 0 and var_277_3 or var_277_3 * (utf8.len(var_277_5) / 35)

				if (35 <= 0 and var_277_3 or var_277_3 * (utf8.len(var_277_5) / 35)) > 0 and var_277_3 < var_277_7 then
					arg_274_1.talkMaxDuration = var_277_7

					if var_277_7 + var_277_2 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_7 + var_277_2
					end
				end

				arg_274_1.text_.text = var_277_5
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401069", "story_v_side_new_1103401.awb") ~= 0 then
					local var_277_8 = manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401069", "story_v_side_new_1103401.awb") / 1000

					if var_277_8 + var_277_2 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_8 + var_277_2
					end

					if var_277_4.prefab_name ~= "" and arg_274_1.actors_[var_277_4.prefab_name] ~= nil then
						local var_277_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_4.prefab_name].transform, "story_v_side_new_1103401", "1103401069", "story_v_side_new_1103401.awb")

						arg_274_1:RecordAudio("1103401069", var_277_9)
						arg_274_1:RecordAudio("1103401069", var_277_9)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_side_new_1103401", "1103401069", "story_v_side_new_1103401.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_side_new_1103401", "1103401069", "story_v_side_new_1103401.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_10 = math.max(var_277_3, arg_274_1.talkMaxDuration)

			if var_277_2 <= arg_274_1.time_ and arg_274_1.time_ < var_277_2 + var_277_10 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_2) / var_277_10

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_2 + var_277_10 and arg_274_1.time_ < var_277_2 + var_277_10 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play1103401070 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 1103401070
		arg_278_1.duration_ = 4.9

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play1103401071(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action6_2")
			end

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_281_0 = 0
			local var_281_1 = 0.55

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_0 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				arg_278_1.leftNameTxt_.text = arg_278_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_2 = arg_278_1:GetWordFromCfg(1103401070)
				local var_281_3 = arg_278_1:FormatText(var_281_2.content)

				arg_278_1.text_.text = var_281_3

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_5 = 22 <= 0 and var_281_1 or var_281_1 * (utf8.len(var_281_3) / 22)

				if (22 <= 0 and var_281_1 or var_281_1 * (utf8.len(var_281_3) / 22)) > 0 and var_281_1 < var_281_5 then
					arg_278_1.talkMaxDuration = var_281_5

					if var_281_5 + var_281_0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_5 + var_281_0
					end
				end

				arg_278_1.text_.text = var_281_3
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401070", "story_v_side_new_1103401.awb") ~= 0 then
					local var_281_6 = manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401070", "story_v_side_new_1103401.awb") / 1000

					if var_281_6 + var_281_0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_6 + var_281_0
					end

					if var_281_2.prefab_name ~= "" and arg_278_1.actors_[var_281_2.prefab_name] ~= nil then
						local var_281_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_278_1.actors_[var_281_2.prefab_name].transform, "story_v_side_new_1103401", "1103401070", "story_v_side_new_1103401.awb")

						arg_278_1:RecordAudio("1103401070", var_281_7)
						arg_278_1:RecordAudio("1103401070", var_281_7)
					else
						arg_278_1:AudioAction("play", "voice", "story_v_side_new_1103401", "1103401070", "story_v_side_new_1103401.awb")
					end

					arg_278_1:RecordHistoryTalkVoice("story_v_side_new_1103401", "1103401070", "story_v_side_new_1103401.awb")
				end

				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_8 = math.max(var_281_1, arg_278_1.talkMaxDuration)

			if var_281_0 <= arg_278_1.time_ and arg_278_1.time_ < var_281_0 + var_281_8 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_0) / var_281_8

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_0 + var_281_8 and arg_278_1.time_ < var_281_0 + var_281_8 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play1103401071 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 1103401071
		arg_282_1.duration_ = 5

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play1103401072(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_9000

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 and not isNil(arg_282_1.actors_["1034ui_story"]) and arg_282_1.var_.characterEffect1034ui_story == nil then
				arg_282_1.var_.characterEffect1034ui_story = arg_282_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_285_0 = 0.200000002980232

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_0 and not isNil(arg_282_1.actors_["1034ui_story"]) then
				if arg_282_1.var_.characterEffect1034ui_story and not isNil(arg_282_1.actors_["1034ui_story"]) then
					arg_282_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_282_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_282_1.time_ - 0) / var_285_0)
				end
			end

			if arg_282_1.time_ >= 0 + var_285_0 and arg_282_1.time_ < 0 + var_285_0 + arg_285_0 and not isNil(arg_282_1.actors_["1034ui_story"]) and arg_282_1.var_.characterEffect1034ui_story then
				arg_282_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_282_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action1_1")
			end

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_285_1 = arg_282_1.actors_["1034ui_story"].transform

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1.var_.moveOldPos1034ui_story = var_285_1.localPosition
			end

			local var_285_2 = 0.001

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_2 then
				var_285_1.localPosition = Vector3.Lerp(arg_282_1.var_.moveOldPos1034ui_story, Vector3.New(0, 100, 0), (arg_282_1.time_ - 0) / var_285_2)
				var_285_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_285_1.position).x, (manager.ui.mainCamera.transform.position - var_285_1.position).y, (manager.ui.mainCamera.transform.position - var_285_1.position).z)
				var_285_1.localEulerAngles.z = 0
				var_285_1.localEulerAngles.x = 0
				var_285_1.localEulerAngles = var_285_1.localEulerAngles
			end

			if arg_282_1.time_ >= 0 + var_285_2 and arg_282_1.time_ < 0 + var_285_2 + arg_285_0 then
				var_285_1.localPosition = Vector3.New(0, 100, 0)
				var_285_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_285_1.position).x, (manager.ui.mainCamera.transform.position - var_285_1.position).y, (manager.ui.mainCamera.transform.position - var_285_1.position).z)
				var_285_1.localEulerAngles.z = 0
				var_285_1.localEulerAngles.x = 0
				var_285_1.localEulerAngles = var_285_1.localEulerAngles
			end

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				local var_285_3 = arg_282_1.var_.effect254645618654

				if not arg_282_1.var_.effect254645618654 then
					var_285_3 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian02_in_keep"), manager.ui.mainCamera.transform)
					var_285_3.name = "254645618654"
					arg_282_1.var_.effect254645618654 = var_285_3
				else
					var_285_3.transform:SetParent(var_285_9000)
				end

				var_285_3.transform.localPosition = Vector3.New(0, 0, 0)
				var_285_3.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_285_5 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_285_0, iter_285_1 in ipairs((var_285_3.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_285_1.transform.localScale = Vector3.New(iter_285_1.transform.localScale.x / var_285_5 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_285_1.transform.localScale.y / var_285_5, iter_285_1.transform.localScale.z)
				end
			end

			if 0.0166666666666667 < arg_282_1.time_ and arg_282_1.time_ <= 0.0166666666666667 + arg_285_0 then
				arg_282_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_car02", "")
			end

			local var_285_8 = 0
			local var_285_9 = 1.675

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_8 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, false)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_10 = arg_282_1:FormatText(arg_282_1:GetWordFromCfg(1103401071).content)

				arg_282_1.text_.text = var_285_10

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_12 = 67 <= 0 and var_285_9 or var_285_9 * (utf8.len(var_285_10) / 67)

				if (67 <= 0 and var_285_9 or var_285_9 * (utf8.len(var_285_10) / 67)) > 0 and var_285_9 < var_285_12 then
					arg_282_1.talkMaxDuration = var_285_12

					if var_285_12 + var_285_8 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_12 + var_285_8
					end
				end

				arg_282_1.text_.text = var_285_10
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)
				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_13 = math.max(var_285_9, arg_282_1.talkMaxDuration)

			if var_285_8 <= arg_282_1.time_ and arg_282_1.time_ < var_285_8 + var_285_13 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_8) / var_285_13

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_8 + var_285_13 and arg_282_1.time_ < var_285_8 + var_285_13 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_282_1:InitPlayNodeList()
	end,
	Play1103401072 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 1103401072
		arg_286_1.duration_ = 8.4

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play1103401073(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			if 1.23333333333333 < arg_286_1.time_ and arg_286_1.time_ <= 1.23333333333333 + arg_289_0 then
				local var_289_0 = arg_286_1.bgs_.I11o

				arg_286_1.bgs_.I11o.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_289_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_289_1 = var_289_0:GetComponent("SpriteRenderer")

				if var_289_1 and var_289_1.sprite then
					local var_289_2 = 2 * (var_289_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_289_0.transform.localScale = Vector3.New(var_289_2 / var_289_1.sprite.bounds.size.y < var_289_2 * manager.ui.mainCameraCom_.aspect / var_289_1.sprite.bounds.size.x and var_289_2 * manager.ui.mainCameraCom_.aspect / var_289_1.sprite.bounds.size.x or var_289_2 / var_289_1.sprite.bounds.size.y, var_289_2 / var_289_1.sprite.bounds.size.y < var_289_2 * manager.ui.mainCameraCom_.aspect / var_289_1.sprite.bounds.size.x and var_289_2 * manager.ui.mainCameraCom_.aspect / var_289_1.sprite.bounds.size.x or var_289_2 / var_289_1.sprite.bounds.size.y, 0)
				end

				for iter_289_0, iter_289_1 in pairs(arg_286_1.bgs_) do
					if iter_289_0 ~= "I11o" then
						iter_289_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 1.4 < arg_286_1.time_ and arg_286_1.time_ <= 1.4 + arg_289_0 then
				local var_289_3 = arg_286_1.bgs_.I11o

				arg_286_1.bgs_.I11o.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_289_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_289_4 = var_289_3:GetComponent("SpriteRenderer")

				if var_289_4 and var_289_4.sprite then
					local var_289_5 = 2 * (var_289_3.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_289_3.transform.localScale = Vector3.New(var_289_5 / var_289_4.sprite.bounds.size.y < var_289_5 * manager.ui.mainCameraCom_.aspect / var_289_4.sprite.bounds.size.x and var_289_5 * manager.ui.mainCameraCom_.aspect / var_289_4.sprite.bounds.size.x or var_289_5 / var_289_4.sprite.bounds.size.y, var_289_5 / var_289_4.sprite.bounds.size.y < var_289_5 * manager.ui.mainCameraCom_.aspect / var_289_4.sprite.bounds.size.x and var_289_5 * manager.ui.mainCameraCom_.aspect / var_289_4.sprite.bounds.size.x or var_289_5 / var_289_4.sprite.bounds.size.y, 0)
				end

				for iter_289_2, iter_289_3 in pairs(arg_286_1.bgs_) do
					if iter_289_2 ~= "I11o" then
						iter_289_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_289_6 = 0

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_6 + arg_289_0 then
				arg_286_1.mask_.enabled = true
				arg_286_1.mask_.raycastTarget = true

				arg_286_1:SetGaussion(false)
			end

			local var_289_7 = 1

			if var_289_6 <= arg_286_1.time_ and arg_286_1.time_ < var_289_6 + var_289_7 then
				local var_289_8 = Color.New(0, 0, 0)

				var_289_8.a = Mathf.Lerp(0, 1, (arg_286_1.time_ - var_289_6) / var_289_7)
				arg_286_1.mask_.color = var_289_8
			end

			if arg_286_1.time_ >= var_289_6 + var_289_7 and arg_286_1.time_ < var_289_6 + var_289_7 + arg_289_0 then
				local var_289_9 = Color.New(0, 0, 0)

				var_289_9.a = 1
				arg_286_1.mask_.color = var_289_9
			end

			local var_289_10 = 1.4

			if 1.4 < arg_286_1.time_ and arg_286_1.time_ <= var_289_10 + arg_289_0 then
				arg_286_1.mask_.enabled = true
				arg_286_1.mask_.raycastTarget = true

				arg_286_1:SetGaussion(false)
			end

			local var_289_11 = 2

			if var_289_10 <= arg_286_1.time_ and arg_286_1.time_ < var_289_10 + var_289_11 then
				local var_289_12 = Color.New(0, 0, 0)

				var_289_12.a = Mathf.Lerp(1, 0, (arg_286_1.time_ - var_289_10) / var_289_11)
				arg_286_1.mask_.color = var_289_12
			end

			if arg_286_1.time_ >= var_289_10 + var_289_11 and arg_286_1.time_ < var_289_10 + var_289_11 + arg_289_0 then
				local var_289_13 = Color.New(0, 0, 0)

				arg_286_1.mask_.enabled = false
				var_289_13.a = 0
				arg_286_1.mask_.color = var_289_13
			end

			local var_289_14 = arg_286_1.bgs_.ST03.transform

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1.var_.moveOldPosST03 = var_289_14.localPosition
			end

			local var_289_15 = 1

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_15 then
				var_289_14.localPosition = Vector3.Lerp(arg_286_1.var_.moveOldPosST03, Vector3.New(0, 0, 0), (arg_286_1.time_ - 0) / var_289_15)
			end

			if arg_286_1.time_ >= 0 + var_289_15 and arg_286_1.time_ < 0 + var_289_15 + arg_289_0 then
				var_289_14.localPosition = Vector3.New(0, 0, 0)
			end

			local var_289_16 = arg_286_1.bgs_.I11o.transform

			if 1.2 < arg_286_1.time_ and arg_286_1.time_ <= 1.2 + arg_289_0 then
				arg_286_1.var_.moveOldPosI11o = var_289_16.localPosition
			end

			local var_289_17 = 0.2

			if 1.2 <= arg_286_1.time_ and arg_286_1.time_ < 1.2 + var_289_17 then
				var_289_16.localPosition = Vector3.Lerp(arg_286_1.var_.moveOldPosI11o, Vector3.New(0, 1, 10), (arg_286_1.time_ - 1.2) / var_289_17)
			end

			if arg_286_1.time_ >= 1.2 + var_289_17 and arg_286_1.time_ < 1.2 + var_289_17 + arg_289_0 then
				var_289_16.localPosition = Vector3.New(0, 1, 10)
			end

			if 1.4 < arg_286_1.time_ and arg_286_1.time_ <= 1.4 + arg_289_0 then
				if arg_286_1.var_.effect254645618654 then
					Object.Destroy(arg_286_1.var_.effect254645618654)

					arg_286_1.var_.effect254645618654 = nil
				end
			end

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_289_21 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_286_1.bgmTxt_.text ~= var_289_21 and arg_286_1.bgmTxt_.text ~= "" then
						if arg_286_1.bgmTxt2_.text ~= "" then
							arg_286_1.bgmTxt_.text = arg_286_1.bgmTxt2_.text
						end

						arg_286_1.bgmTxt2_.text = var_289_21

						arg_286_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_286_1.bgmTxt_.text = var_289_21
						arg_286_1.bgmTxt2_.text = var_289_21
					end

					if arg_286_1.bgmTimer then
						arg_286_1.bgmTimer:Stop()

						arg_286_1.bgmTimer = nil
					end

					if arg_286_1.settingData.show_music_name == 1 then
						arg_286_1.musicController:SetSelectedState("show")
						arg_286_1.musicAnimator_:Play("open", 0, 0)

						if arg_286_1.settingData.music_time ~= 0 then
							arg_286_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_286_1.settingData.music_time), function()
								if arg_286_1 == nil or isNil(arg_286_1.bgmTxt_) then
									return
								end

								arg_286_1.musicController:SetSelectedState("hide")
								arg_286_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.4 < arg_286_1.time_ and arg_286_1.time_ <= 1.4 + arg_289_0 then
				arg_286_1:AudioAction("play", "music", "bgm_activity_3_0_story_daily_quiet", "bgm_activity_3_0_story_daily_quiet", "bgm_activity_3_0_story_daily_quiet.awb")

				local var_289_24 = manager.audio:GetAudioName("bgm_activity_3_0_story_daily_quiet", "bgm_activity_3_0_story_daily_quiet")

				if "" ~= "" then
					if arg_286_1.bgmTxt_.text ~= var_289_24 and arg_286_1.bgmTxt_.text ~= "" then
						if arg_286_1.bgmTxt2_.text ~= "" then
							arg_286_1.bgmTxt_.text = arg_286_1.bgmTxt2_.text
						end

						arg_286_1.bgmTxt2_.text = var_289_24

						arg_286_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_286_1.bgmTxt_.text = var_289_24
						arg_286_1.bgmTxt2_.text = var_289_24
					end

					if arg_286_1.bgmTimer then
						arg_286_1.bgmTimer:Stop()

						arg_286_1.bgmTimer = nil
					end

					if arg_286_1.settingData.show_music_name == 1 then
						arg_286_1.musicController:SetSelectedState("show")
						arg_286_1.musicAnimator_:Play("open", 0, 0)

						if arg_286_1.settingData.music_time ~= 0 then
							arg_286_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_286_1.settingData.music_time), function()
								if arg_286_1 == nil or isNil(arg_286_1.bgmTxt_) then
									return
								end

								arg_286_1.musicController:SetSelectedState("hide")
								arg_286_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 2.77555756156289e-17 < arg_286_1.time_ and arg_286_1.time_ <= 2.77555756156289e-17 + arg_289_0 then
				arg_286_1:AudioAction("play", "effect", "se_story_side_1096", "se_story_1096_brake", "")
			end

			if 0.133333333333333 < arg_286_1.time_ and arg_286_1.time_ <= 0.133333333333333 + arg_289_0 then
				arg_286_1:AudioAction("stop", "effect", "se_story_142", "se_story_142_amb_city_street", "")
			end

			if 1.4 < arg_286_1.time_ and arg_286_1.time_ <= 1.4 + arg_289_0 then
				arg_286_1:AudioAction("play", "effect", "se_story_16", "se_story_16_street_loop", "")
			end

			if arg_286_1.frameCnt_ <= 1 then
				arg_286_1.dialog_:SetActive(false)
			end

			local var_289_28 = 3.4
			local var_289_29 = 1.8

			if 3.4 < arg_286_1.time_ and arg_286_1.time_ <= var_289_28 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0

				arg_286_1.dialog_:SetActive(true)

				arg_286_1.dialogCg_.alpha = 0

				local var_289_30 = LeanTween.value(arg_286_1.dialog_, 0, 1, 0.3)

				var_289_30:setOnUpdate(LuaHelper.FloatAction(function(arg_292_0)
					arg_286_1.dialogCg_.alpha = arg_292_0
				end))
				var_289_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_286_1.dialog_)
					var_289_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_286_1.duration_ = arg_286_1.duration_ + 0.3

				SetActive(arg_286_1.leftNameGo_, false)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_31 = arg_286_1:FormatText(arg_286_1:GetWordFromCfg(1103401072).content)

				arg_286_1.text_.text = var_289_31

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_33 = 72 <= 0 and var_289_29 or var_289_29 * (utf8.len(var_289_31) / 72)

				if (72 <= 0 and var_289_29 or var_289_29 * (utf8.len(var_289_31) / 72)) > 0 and var_289_29 < var_289_33 then
					arg_286_1.talkMaxDuration = var_289_33
					var_289_28 = var_289_28 + 0.3

					if var_289_33 + var_289_28 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_33 + var_289_28
					end
				end

				arg_286_1.text_.text = var_289_31
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)
				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_34 = var_289_28 + 0.3
			local var_289_35 = math.max(var_289_29, arg_286_1.talkMaxDuration)

			if var_289_28 + 0.3 <= arg_286_1.time_ and arg_286_1.time_ < var_289_34 + var_289_35 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_34) / var_289_35

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_34 + var_289_35 and arg_286_1.time_ < var_289_34 + var_289_35 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "ST03",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 0, 0),
					easeType = LeanTweenType.linear
				}
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "I11o",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.2,
				startTime = 1.2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 9.5),
					endPos = Vector3.New(0, 1, 10),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_286_1:InitPlayNodeList()
	end,
	Play1103401073 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 1103401073
		arg_294_1.duration_ = 4.23

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play1103401074(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1.var_.moveOldPos1034ui_story = arg_294_1.actors_["1034ui_story"].transform.localPosition
			end

			local var_297_0 = 0.001

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_0 then
				arg_294_1.actors_["1034ui_story"].transform.localPosition = Vector3.Lerp(arg_294_1.var_.moveOldPos1034ui_story, Vector3.New(0, -0.93, -6), (arg_294_1.time_ - 0) / var_297_0)
				arg_294_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_294_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_294_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_294_1.actors_["1034ui_story"].transform.position).z)
				arg_294_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_294_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_294_1.actors_["1034ui_story"].transform.localEulerAngles = arg_294_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			if arg_294_1.time_ >= 0 + var_297_0 and arg_294_1.time_ < 0 + var_297_0 + arg_297_0 then
				arg_294_1.actors_["1034ui_story"].transform.localPosition = Vector3.New(0, -0.93, -6)
				arg_294_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_294_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_294_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_294_1.actors_["1034ui_story"].transform.position).z)
				arg_294_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_294_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_294_1.actors_["1034ui_story"].transform.localEulerAngles = arg_294_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			local var_297_1 = arg_294_1.actors_["1034ui_story"]

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 and not isNil(var_297_1) and arg_294_1.var_.characterEffect1034ui_story == nil then
				arg_294_1.var_.characterEffect1034ui_story = var_297_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_297_2 = 0.200000002980232

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_2 and not isNil(var_297_1) then
				if arg_294_1.var_.characterEffect1034ui_story and not isNil(var_297_1) then
					arg_294_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_294_1.time_ >= 0 + var_297_2 and arg_294_1.time_ < 0 + var_297_2 + arg_297_0 and not isNil(var_297_1) and arg_294_1.var_.characterEffect1034ui_story then
				arg_294_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action7_1")
			end

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_297_4 = 0
			local var_297_5 = 0.6

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= var_297_4 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, true)

				arg_294_1.leftNameTxt_.text = arg_294_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_6 = arg_294_1:GetWordFromCfg(1103401073)
				local var_297_7 = arg_294_1:FormatText(var_297_6.content)

				arg_294_1.text_.text = var_297_7

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_9 = 24 <= 0 and var_297_5 or var_297_5 * (utf8.len(var_297_7) / 24)

				if (24 <= 0 and var_297_5 or var_297_5 * (utf8.len(var_297_7) / 24)) > 0 and var_297_5 < var_297_9 then
					arg_294_1.talkMaxDuration = var_297_9

					if var_297_9 + var_297_4 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_9 + var_297_4
					end
				end

				arg_294_1.text_.text = var_297_7
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401073", "story_v_side_new_1103401.awb") ~= 0 then
					local var_297_10 = manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401073", "story_v_side_new_1103401.awb") / 1000

					if var_297_10 + var_297_4 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_10 + var_297_4
					end

					if var_297_6.prefab_name ~= "" and arg_294_1.actors_[var_297_6.prefab_name] ~= nil then
						local var_297_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_294_1.actors_[var_297_6.prefab_name].transform, "story_v_side_new_1103401", "1103401073", "story_v_side_new_1103401.awb")

						arg_294_1:RecordAudio("1103401073", var_297_11)
						arg_294_1:RecordAudio("1103401073", var_297_11)
					else
						arg_294_1:AudioAction("play", "voice", "story_v_side_new_1103401", "1103401073", "story_v_side_new_1103401.awb")
					end

					arg_294_1:RecordHistoryTalkVoice("story_v_side_new_1103401", "1103401073", "story_v_side_new_1103401.awb")
				end

				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_12 = math.max(var_297_5, arg_294_1.talkMaxDuration)

			if var_297_4 <= arg_294_1.time_ and arg_294_1.time_ < var_297_4 + var_297_12 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_4) / var_297_12

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_4 + var_297_12 and arg_294_1.time_ < var_297_4 + var_297_12 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
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
	Play1103401074 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 1103401074
		arg_298_1.duration_ = 5

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play1103401075(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 and not isNil(arg_298_1.actors_["1034ui_story"]) and arg_298_1.var_.characterEffect1034ui_story == nil then
				arg_298_1.var_.characterEffect1034ui_story = arg_298_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_301_0 = 0.200000002980232

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_0 and not isNil(arg_298_1.actors_["1034ui_story"]) then
				if arg_298_1.var_.characterEffect1034ui_story and not isNil(arg_298_1.actors_["1034ui_story"]) then
					arg_298_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_298_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_298_1.time_ - 0) / var_301_0)
				end
			end

			if arg_298_1.time_ >= 0 + var_301_0 and arg_298_1.time_ < 0 + var_301_0 + arg_301_0 and not isNil(arg_298_1.actors_["1034ui_story"]) and arg_298_1.var_.characterEffect1034ui_story then
				arg_298_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_298_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_301_1 = 0
			local var_301_2 = 0.575

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= var_301_1 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, true)

				arg_298_1.leftNameTxt_.text = arg_298_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, true)
				arg_298_1.iconController_:SetSelectedState("hero")

				arg_298_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_298_1.callingController_:SetSelectedState("normal")

				arg_298_1.keyicon_.color = Color.New(1, 1, 1)
				arg_298_1.icon_.color = Color.New(1, 1, 1)

				local var_301_3 = arg_298_1:FormatText(arg_298_1:GetWordFromCfg(1103401074).content)

				arg_298_1.text_.text = var_301_3

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_5 = 23 <= 0 and var_301_2 or var_301_2 * (utf8.len(var_301_3) / 23)

				if (23 <= 0 and var_301_2 or var_301_2 * (utf8.len(var_301_3) / 23)) > 0 and var_301_2 < var_301_5 then
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
	Play1103401075 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 1103401075
		arg_302_1.duration_ = 4.87

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play1103401076(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 and not isNil(arg_302_1.actors_["1034ui_story"]) and arg_302_1.var_.characterEffect1034ui_story == nil then
				arg_302_1.var_.characterEffect1034ui_story = arg_302_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_305_0 = 0.200000002980232

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_0 and not isNil(arg_302_1.actors_["1034ui_story"]) then
				if arg_302_1.var_.characterEffect1034ui_story and not isNil(arg_302_1.actors_["1034ui_story"]) then
					arg_302_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_302_1.time_ >= 0 + var_305_0 and arg_302_1.time_ < 0 + var_305_0 + arg_305_0 and not isNil(arg_302_1.actors_["1034ui_story"]) and arg_302_1.var_.characterEffect1034ui_story then
				arg_302_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034actionlink/1034action476")
			end

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_wuyuC", "EmotionTimelineAnimator")
			end

			local var_305_2 = 0
			local var_305_3 = 0.5

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= var_305_2 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				arg_302_1.leftNameTxt_.text = arg_302_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_4 = arg_302_1:GetWordFromCfg(1103401075)
				local var_305_5 = arg_302_1:FormatText(var_305_4.content)

				arg_302_1.text_.text = var_305_5

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_7 = 20 <= 0 and var_305_3 or var_305_3 * (utf8.len(var_305_5) / 20)

				if (20 <= 0 and var_305_3 or var_305_3 * (utf8.len(var_305_5) / 20)) > 0 and var_305_3 < var_305_7 then
					arg_302_1.talkMaxDuration = var_305_7

					if var_305_7 + var_305_2 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_7 + var_305_2
					end
				end

				arg_302_1.text_.text = var_305_5
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401075", "story_v_side_new_1103401.awb") ~= 0 then
					local var_305_8 = manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401075", "story_v_side_new_1103401.awb") / 1000

					if var_305_8 + var_305_2 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_8 + var_305_2
					end

					if var_305_4.prefab_name ~= "" and arg_302_1.actors_[var_305_4.prefab_name] ~= nil then
						local var_305_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_302_1.actors_[var_305_4.prefab_name].transform, "story_v_side_new_1103401", "1103401075", "story_v_side_new_1103401.awb")

						arg_302_1:RecordAudio("1103401075", var_305_9)
						arg_302_1:RecordAudio("1103401075", var_305_9)
					else
						arg_302_1:AudioAction("play", "voice", "story_v_side_new_1103401", "1103401075", "story_v_side_new_1103401.awb")
					end

					arg_302_1:RecordHistoryTalkVoice("story_v_side_new_1103401", "1103401075", "story_v_side_new_1103401.awb")
				end

				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_10 = math.max(var_305_3, arg_302_1.talkMaxDuration)

			if var_305_2 <= arg_302_1.time_ and arg_302_1.time_ < var_305_2 + var_305_10 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_2) / var_305_10

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_2 + var_305_10 and arg_302_1.time_ < var_305_2 + var_305_10 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {}

		arg_302_1:InitPlayNodeList()
	end,
	Play1103401076 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 1103401076
		arg_306_1.duration_ = 5

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play1103401077(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 and not isNil(arg_306_1.actors_["1034ui_story"]) and arg_306_1.var_.characterEffect1034ui_story == nil then
				arg_306_1.var_.characterEffect1034ui_story = arg_306_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_309_0 = 0.200000002980232

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_0 and not isNil(arg_306_1.actors_["1034ui_story"]) then
				if arg_306_1.var_.characterEffect1034ui_story and not isNil(arg_306_1.actors_["1034ui_story"]) then
					arg_306_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_306_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_306_1.time_ - 0) / var_309_0)
				end
			end

			if arg_306_1.time_ >= 0 + var_309_0 and arg_306_1.time_ < 0 + var_309_0 + arg_309_0 and not isNil(arg_306_1.actors_["1034ui_story"]) and arg_306_1.var_.characterEffect1034ui_story then
				arg_306_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_306_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_309_1 = 0
			local var_309_2 = 0.45

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= var_309_1 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				arg_306_1.leftNameTxt_.text = arg_306_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, true)
				arg_306_1.iconController_:SetSelectedState("hero")

				arg_306_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_306_1.callingController_:SetSelectedState("normal")

				arg_306_1.keyicon_.color = Color.New(1, 1, 1)
				arg_306_1.icon_.color = Color.New(1, 1, 1)

				local var_309_3 = arg_306_1:FormatText(arg_306_1:GetWordFromCfg(1103401076).content)

				arg_306_1.text_.text = var_309_3

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_5 = 18 <= 0 and var_309_2 or var_309_2 * (utf8.len(var_309_3) / 18)

				if (18 <= 0 and var_309_2 or var_309_2 * (utf8.len(var_309_3) / 18)) > 0 and var_309_2 < var_309_5 then
					arg_306_1.talkMaxDuration = var_309_5

					if var_309_5 + var_309_1 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_5 + var_309_1
					end
				end

				arg_306_1.text_.text = var_309_3
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)
				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_6 = math.max(var_309_2, arg_306_1.talkMaxDuration)

			if var_309_1 <= arg_306_1.time_ and arg_306_1.time_ < var_309_1 + var_309_6 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_1) / var_309_6

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_1 + var_309_6 and arg_306_1.time_ < var_309_1 + var_309_6 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play1103401077 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 1103401077
		arg_310_1.duration_ = 5.5

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play1103401078(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 and not isNil(arg_310_1.actors_["1034ui_story"]) and arg_310_1.var_.characterEffect1034ui_story == nil then
				arg_310_1.var_.characterEffect1034ui_story = arg_310_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_313_0 = 0.200000002980232

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_0 and not isNil(arg_310_1.actors_["1034ui_story"]) then
				if arg_310_1.var_.characterEffect1034ui_story and not isNil(arg_310_1.actors_["1034ui_story"]) then
					arg_310_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_310_1.time_ >= 0 + var_313_0 and arg_310_1.time_ < 0 + var_313_0 + arg_313_0 and not isNil(arg_310_1.actors_["1034ui_story"]) and arg_310_1.var_.characterEffect1034ui_story then
				arg_310_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				arg_310_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_313_2 = 0
			local var_313_3 = 0.65

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= var_313_2 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				arg_310_1.leftNameTxt_.text = arg_310_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_4 = arg_310_1:GetWordFromCfg(1103401077)
				local var_313_5 = arg_310_1:FormatText(var_313_4.content)

				arg_310_1.text_.text = var_313_5

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_7 = 26 <= 0 and var_313_3 or var_313_3 * (utf8.len(var_313_5) / 26)

				if (26 <= 0 and var_313_3 or var_313_3 * (utf8.len(var_313_5) / 26)) > 0 and var_313_3 < var_313_7 then
					arg_310_1.talkMaxDuration = var_313_7

					if var_313_7 + var_313_2 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_7 + var_313_2
					end
				end

				arg_310_1.text_.text = var_313_5
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401077", "story_v_side_new_1103401.awb") ~= 0 then
					local var_313_8 = manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401077", "story_v_side_new_1103401.awb") / 1000

					if var_313_8 + var_313_2 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_8 + var_313_2
					end

					if var_313_4.prefab_name ~= "" and arg_310_1.actors_[var_313_4.prefab_name] ~= nil then
						local var_313_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_310_1.actors_[var_313_4.prefab_name].transform, "story_v_side_new_1103401", "1103401077", "story_v_side_new_1103401.awb")

						arg_310_1:RecordAudio("1103401077", var_313_9)
						arg_310_1:RecordAudio("1103401077", var_313_9)
					else
						arg_310_1:AudioAction("play", "voice", "story_v_side_new_1103401", "1103401077", "story_v_side_new_1103401.awb")
					end

					arg_310_1:RecordHistoryTalkVoice("story_v_side_new_1103401", "1103401077", "story_v_side_new_1103401.awb")
				end

				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_10 = math.max(var_313_3, arg_310_1.talkMaxDuration)

			if var_313_2 <= arg_310_1.time_ and arg_310_1.time_ < var_313_2 + var_313_10 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_2) / var_313_10

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_2 + var_313_10 and arg_310_1.time_ < var_313_2 + var_313_10 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play1103401078 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 1103401078
		arg_314_1.duration_ = 5

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play1103401079(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 and not isNil(arg_314_1.actors_["1034ui_story"]) and arg_314_1.var_.characterEffect1034ui_story == nil then
				arg_314_1.var_.characterEffect1034ui_story = arg_314_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_317_0 = 0.200000002980232

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_0 and not isNil(arg_314_1.actors_["1034ui_story"]) then
				if arg_314_1.var_.characterEffect1034ui_story and not isNil(arg_314_1.actors_["1034ui_story"]) then
					arg_314_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_314_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_314_1.time_ - 0) / var_317_0)
				end
			end

			if arg_314_1.time_ >= 0 + var_317_0 and arg_314_1.time_ < 0 + var_317_0 + arg_317_0 and not isNil(arg_314_1.actors_["1034ui_story"]) and arg_314_1.var_.characterEffect1034ui_story then
				arg_314_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_314_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 then
				arg_314_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_317_1 = 0
			local var_317_2 = 0.425

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= var_317_1 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				arg_314_1.leftNameTxt_.text = arg_314_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, true)
				arg_314_1.iconController_:SetSelectedState("hero")

				arg_314_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_314_1.callingController_:SetSelectedState("normal")

				arg_314_1.keyicon_.color = Color.New(1, 1, 1)
				arg_314_1.icon_.color = Color.New(1, 1, 1)

				local var_317_3 = arg_314_1:FormatText(arg_314_1:GetWordFromCfg(1103401078).content)

				arg_314_1.text_.text = var_317_3

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_5 = 17 <= 0 and var_317_2 or var_317_2 * (utf8.len(var_317_3) / 17)

				if (17 <= 0 and var_317_2 or var_317_2 * (utf8.len(var_317_3) / 17)) > 0 and var_317_2 < var_317_5 then
					arg_314_1.talkMaxDuration = var_317_5

					if var_317_5 + var_317_1 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_5 + var_317_1
					end
				end

				arg_314_1.text_.text = var_317_3
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)
				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_6 = math.max(var_317_2, arg_314_1.talkMaxDuration)

			if var_317_1 <= arg_314_1.time_ and arg_314_1.time_ < var_317_1 + var_317_6 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_1) / var_317_6

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_1 + var_317_6 and arg_314_1.time_ < var_317_1 + var_317_6 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play1103401079 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 1103401079
		arg_318_1.duration_ = 4.77

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play1103401080(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 and not isNil(arg_318_1.actors_["1034ui_story"]) and arg_318_1.var_.characterEffect1034ui_story == nil then
				arg_318_1.var_.characterEffect1034ui_story = arg_318_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_321_0 = 0.200000002980232

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_0 and not isNil(arg_318_1.actors_["1034ui_story"]) then
				if arg_318_1.var_.characterEffect1034ui_story and not isNil(arg_318_1.actors_["1034ui_story"]) then
					arg_318_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_318_1.time_ >= 0 + var_321_0 and arg_318_1.time_ < 0 + var_321_0 + arg_321_0 and not isNil(arg_318_1.actors_["1034ui_story"]) and arg_318_1.var_.characterEffect1034ui_story then
				arg_318_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034actionlink/1034action467")
			end

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_321_2 = 0
			local var_321_3 = 0.4

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= var_321_2 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				arg_318_1.leftNameTxt_.text = arg_318_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_4 = arg_318_1:GetWordFromCfg(1103401079)
				local var_321_5 = arg_318_1:FormatText(var_321_4.content)

				arg_318_1.text_.text = var_321_5

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_7 = 16 <= 0 and var_321_3 or var_321_3 * (utf8.len(var_321_5) / 16)

				if (16 <= 0 and var_321_3 or var_321_3 * (utf8.len(var_321_5) / 16)) > 0 and var_321_3 < var_321_7 then
					arg_318_1.talkMaxDuration = var_321_7

					if var_321_7 + var_321_2 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_7 + var_321_2
					end
				end

				arg_318_1.text_.text = var_321_5
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401079", "story_v_side_new_1103401.awb") ~= 0 then
					local var_321_8 = manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401079", "story_v_side_new_1103401.awb") / 1000

					if var_321_8 + var_321_2 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_8 + var_321_2
					end

					if var_321_4.prefab_name ~= "" and arg_318_1.actors_[var_321_4.prefab_name] ~= nil then
						local var_321_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_318_1.actors_[var_321_4.prefab_name].transform, "story_v_side_new_1103401", "1103401079", "story_v_side_new_1103401.awb")

						arg_318_1:RecordAudio("1103401079", var_321_9)
						arg_318_1:RecordAudio("1103401079", var_321_9)
					else
						arg_318_1:AudioAction("play", "voice", "story_v_side_new_1103401", "1103401079", "story_v_side_new_1103401.awb")
					end

					arg_318_1:RecordHistoryTalkVoice("story_v_side_new_1103401", "1103401079", "story_v_side_new_1103401.awb")
				end

				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_10 = math.max(var_321_3, arg_318_1.talkMaxDuration)

			if var_321_2 <= arg_318_1.time_ and arg_318_1.time_ < var_321_2 + var_321_10 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_2) / var_321_10

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_2 + var_321_10 and arg_318_1.time_ < var_321_2 + var_321_10 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play1103401080 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 1103401080
		arg_322_1.duration_ = 5

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play1103401081(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 and not isNil(arg_322_1.actors_["1034ui_story"]) and arg_322_1.var_.characterEffect1034ui_story == nil then
				arg_322_1.var_.characterEffect1034ui_story = arg_322_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_325_0 = 0.200000002980232

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_0 and not isNil(arg_322_1.actors_["1034ui_story"]) then
				if arg_322_1.var_.characterEffect1034ui_story and not isNil(arg_322_1.actors_["1034ui_story"]) then
					arg_322_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_322_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_322_1.time_ - 0) / var_325_0)
				end
			end

			if arg_322_1.time_ >= 0 + var_325_0 and arg_322_1.time_ < 0 + var_325_0 + arg_325_0 and not isNil(arg_322_1.actors_["1034ui_story"]) and arg_322_1.var_.characterEffect1034ui_story then
				arg_322_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_322_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_325_1 = 0
			local var_325_2 = 0.45

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= var_325_1 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				arg_322_1.leftNameTxt_.text = arg_322_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, true)
				arg_322_1.iconController_:SetSelectedState("hero")

				arg_322_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_322_1.callingController_:SetSelectedState("normal")

				arg_322_1.keyicon_.color = Color.New(1, 1, 1)
				arg_322_1.icon_.color = Color.New(1, 1, 1)

				local var_325_3 = arg_322_1:FormatText(arg_322_1:GetWordFromCfg(1103401080).content)

				arg_322_1.text_.text = var_325_3

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_5 = 18 <= 0 and var_325_2 or var_325_2 * (utf8.len(var_325_3) / 18)

				if (18 <= 0 and var_325_2 or var_325_2 * (utf8.len(var_325_3) / 18)) > 0 and var_325_2 < var_325_5 then
					arg_322_1.talkMaxDuration = var_325_5

					if var_325_5 + var_325_1 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_5 + var_325_1
					end
				end

				arg_322_1.text_.text = var_325_3
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)
				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_6 = math.max(var_325_2, arg_322_1.talkMaxDuration)

			if var_325_1 <= arg_322_1.time_ and arg_322_1.time_ < var_325_1 + var_325_6 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_1) / var_325_6

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_1 + var_325_6 and arg_322_1.time_ < var_325_1 + var_325_6 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play1103401081 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 1103401081
		arg_326_1.duration_ = 9.37

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play1103401082(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 and not isNil(arg_326_1.actors_["1034ui_story"]) and arg_326_1.var_.characterEffect1034ui_story == nil then
				arg_326_1.var_.characterEffect1034ui_story = arg_326_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_329_0 = 0.200000002980232

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_0 and not isNil(arg_326_1.actors_["1034ui_story"]) then
				if arg_326_1.var_.characterEffect1034ui_story and not isNil(arg_326_1.actors_["1034ui_story"]) then
					arg_326_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_326_1.time_ >= 0 + var_329_0 and arg_326_1.time_ < 0 + var_329_0 + arg_329_0 and not isNil(arg_326_1.actors_["1034ui_story"]) and arg_326_1.var_.characterEffect1034ui_story then
				arg_326_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034actionlink/1034action476")
			end

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_wuyuA", "EmotionTimelineAnimator")
			end

			local var_329_2 = 0
			local var_329_3 = 1.125

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= var_329_2 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				arg_326_1.leftNameTxt_.text = arg_326_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_4 = arg_326_1:GetWordFromCfg(1103401081)
				local var_329_5 = arg_326_1:FormatText(var_329_4.content)

				arg_326_1.text_.text = var_329_5

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_7 = 45 <= 0 and var_329_3 or var_329_3 * (utf8.len(var_329_5) / 45)

				if (45 <= 0 and var_329_3 or var_329_3 * (utf8.len(var_329_5) / 45)) > 0 and var_329_3 < var_329_7 then
					arg_326_1.talkMaxDuration = var_329_7

					if var_329_7 + var_329_2 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_7 + var_329_2
					end
				end

				arg_326_1.text_.text = var_329_5
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401081", "story_v_side_new_1103401.awb") ~= 0 then
					local var_329_8 = manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401081", "story_v_side_new_1103401.awb") / 1000

					if var_329_8 + var_329_2 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_8 + var_329_2
					end

					if var_329_4.prefab_name ~= "" and arg_326_1.actors_[var_329_4.prefab_name] ~= nil then
						local var_329_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_326_1.actors_[var_329_4.prefab_name].transform, "story_v_side_new_1103401", "1103401081", "story_v_side_new_1103401.awb")

						arg_326_1:RecordAudio("1103401081", var_329_9)
						arg_326_1:RecordAudio("1103401081", var_329_9)
					else
						arg_326_1:AudioAction("play", "voice", "story_v_side_new_1103401", "1103401081", "story_v_side_new_1103401.awb")
					end

					arg_326_1:RecordHistoryTalkVoice("story_v_side_new_1103401", "1103401081", "story_v_side_new_1103401.awb")
				end

				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_10 = math.max(var_329_3, arg_326_1.talkMaxDuration)

			if var_329_2 <= arg_326_1.time_ and arg_326_1.time_ < var_329_2 + var_329_10 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_2) / var_329_10

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_2 + var_329_10 and arg_326_1.time_ < var_329_2 + var_329_10 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play1103401082 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 1103401082
		arg_330_1.duration_ = 4

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play1103401083(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = 0.475

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				arg_330_1.leftNameTxt_.text = arg_330_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_1 = arg_330_1:GetWordFromCfg(1103401082)
				local var_333_2 = arg_330_1:FormatText(var_333_1.content)

				arg_330_1.text_.text = var_333_2

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_4 = 19 <= 0 and var_333_0 or var_333_0 * (utf8.len(var_333_2) / 19)

				if (19 <= 0 and var_333_0 or var_333_0 * (utf8.len(var_333_2) / 19)) > 0 and var_333_0 < var_333_4 then
					arg_330_1.talkMaxDuration = var_333_4

					if var_333_4 + 0 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_4 + 0
					end
				end

				arg_330_1.text_.text = var_333_2
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401082", "story_v_side_new_1103401.awb") ~= 0 then
					local var_333_5 = manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401082", "story_v_side_new_1103401.awb") / 1000

					if var_333_5 + 0 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_5 + 0
					end

					if var_333_1.prefab_name ~= "" and arg_330_1.actors_[var_333_1.prefab_name] ~= nil then
						local var_333_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_330_1.actors_[var_333_1.prefab_name].transform, "story_v_side_new_1103401", "1103401082", "story_v_side_new_1103401.awb")

						arg_330_1:RecordAudio("1103401082", var_333_6)
						arg_330_1:RecordAudio("1103401082", var_333_6)
					else
						arg_330_1:AudioAction("play", "voice", "story_v_side_new_1103401", "1103401082", "story_v_side_new_1103401.awb")
					end

					arg_330_1:RecordHistoryTalkVoice("story_v_side_new_1103401", "1103401082", "story_v_side_new_1103401.awb")
				end

				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_7 = math.max(var_333_0, arg_330_1.talkMaxDuration)

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_7 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - 0) / var_333_7

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= 0 + var_333_7 and arg_330_1.time_ < 0 + var_333_7 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play1103401083 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 1103401083
		arg_334_1.duration_ = 5

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play1103401084(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 and not isNil(arg_334_1.actors_["1034ui_story"]) and arg_334_1.var_.characterEffect1034ui_story == nil then
				arg_334_1.var_.characterEffect1034ui_story = arg_334_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_337_0 = 0.200000002980232

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_0 and not isNil(arg_334_1.actors_["1034ui_story"]) then
				if arg_334_1.var_.characterEffect1034ui_story and not isNil(arg_334_1.actors_["1034ui_story"]) then
					arg_334_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_334_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_334_1.time_ - 0) / var_337_0)
				end
			end

			if arg_334_1.time_ >= 0 + var_337_0 and arg_334_1.time_ < 0 + var_337_0 + arg_337_0 and not isNil(arg_334_1.actors_["1034ui_story"]) and arg_334_1.var_.characterEffect1034ui_story then
				arg_334_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_334_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_biyanbiaozhun", "EmotionTimelineAnimator")
			end

			local var_337_1 = 0
			local var_337_2 = 0.625

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= var_337_1 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				arg_334_1.leftNameTxt_.text = arg_334_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, true)
				arg_334_1.iconController_:SetSelectedState("hero")

				arg_334_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_334_1.callingController_:SetSelectedState("normal")

				arg_334_1.keyicon_.color = Color.New(1, 1, 1)
				arg_334_1.icon_.color = Color.New(1, 1, 1)

				local var_337_3 = arg_334_1:FormatText(arg_334_1:GetWordFromCfg(1103401083).content)

				arg_334_1.text_.text = var_337_3

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_5 = 25 <= 0 and var_337_2 or var_337_2 * (utf8.len(var_337_3) / 25)

				if (25 <= 0 and var_337_2 or var_337_2 * (utf8.len(var_337_3) / 25)) > 0 and var_337_2 < var_337_5 then
					arg_334_1.talkMaxDuration = var_337_5

					if var_337_5 + var_337_1 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_5 + var_337_1
					end
				end

				arg_334_1.text_.text = var_337_3
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)
				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_6 = math.max(var_337_2, arg_334_1.talkMaxDuration)

			if var_337_1 <= arg_334_1.time_ and arg_334_1.time_ < var_337_1 + var_337_6 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_1) / var_337_6

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_1 + var_337_6 and arg_334_1.time_ < var_337_1 + var_337_6 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play1103401084 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 1103401084
		arg_338_1.duration_ = 5.93

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play1103401085(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 and not isNil(arg_338_1.actors_["1034ui_story"]) and arg_338_1.var_.characterEffect1034ui_story == nil then
				arg_338_1.var_.characterEffect1034ui_story = arg_338_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_341_0 = 0.200000002980232

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_0 and not isNil(arg_338_1.actors_["1034ui_story"]) then
				if arg_338_1.var_.characterEffect1034ui_story and not isNil(arg_338_1.actors_["1034ui_story"]) then
					arg_338_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_338_1.time_ >= 0 + var_341_0 and arg_338_1.time_ < 0 + var_341_0 + arg_341_0 and not isNil(arg_338_1.actors_["1034ui_story"]) and arg_338_1.var_.characterEffect1034ui_story then
				arg_338_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034actionlink/1034action467")
			end

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_341_2 = 0
			local var_341_3 = 0.55

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= var_341_2 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				arg_338_1.leftNameTxt_.text = arg_338_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_4 = arg_338_1:GetWordFromCfg(1103401084)
				local var_341_5 = arg_338_1:FormatText(var_341_4.content)

				arg_338_1.text_.text = var_341_5

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_7 = 22 <= 0 and var_341_3 or var_341_3 * (utf8.len(var_341_5) / 22)

				if (22 <= 0 and var_341_3 or var_341_3 * (utf8.len(var_341_5) / 22)) > 0 and var_341_3 < var_341_7 then
					arg_338_1.talkMaxDuration = var_341_7

					if var_341_7 + var_341_2 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_7 + var_341_2
					end
				end

				arg_338_1.text_.text = var_341_5
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401084", "story_v_side_new_1103401.awb") ~= 0 then
					local var_341_8 = manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401084", "story_v_side_new_1103401.awb") / 1000

					if var_341_8 + var_341_2 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_8 + var_341_2
					end

					if var_341_4.prefab_name ~= "" and arg_338_1.actors_[var_341_4.prefab_name] ~= nil then
						local var_341_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_338_1.actors_[var_341_4.prefab_name].transform, "story_v_side_new_1103401", "1103401084", "story_v_side_new_1103401.awb")

						arg_338_1:RecordAudio("1103401084", var_341_9)
						arg_338_1:RecordAudio("1103401084", var_341_9)
					else
						arg_338_1:AudioAction("play", "voice", "story_v_side_new_1103401", "1103401084", "story_v_side_new_1103401.awb")
					end

					arg_338_1:RecordHistoryTalkVoice("story_v_side_new_1103401", "1103401084", "story_v_side_new_1103401.awb")
				end

				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_10 = math.max(var_341_3, arg_338_1.talkMaxDuration)

			if var_341_2 <= arg_338_1.time_ and arg_338_1.time_ < var_341_2 + var_341_10 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_2) / var_341_10

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_2 + var_341_10 and arg_338_1.time_ < var_341_2 + var_341_10 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {}

		arg_338_1:InitPlayNodeList()
	end,
	Play1103401085 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 1103401085
		arg_342_1.duration_ = 4.97

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play1103401086(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 then
				arg_342_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_wuyuC", "EmotionTimelineAnimator")
			end

			local var_345_0 = 0
			local var_345_1 = 0.625

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= var_345_0 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				arg_342_1.leftNameTxt_.text = arg_342_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, false)
				arg_342_1.callingController_:SetSelectedState("normal")

				local var_345_2 = arg_342_1:GetWordFromCfg(1103401085)
				local var_345_3 = arg_342_1:FormatText(var_345_2.content)

				arg_342_1.text_.text = var_345_3

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_5 = 25 <= 0 and var_345_1 or var_345_1 * (utf8.len(var_345_3) / 25)

				if (25 <= 0 and var_345_1 or var_345_1 * (utf8.len(var_345_3) / 25)) > 0 and var_345_1 < var_345_5 then
					arg_342_1.talkMaxDuration = var_345_5

					if var_345_5 + var_345_0 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_5 + var_345_0
					end
				end

				arg_342_1.text_.text = var_345_3
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401085", "story_v_side_new_1103401.awb") ~= 0 then
					local var_345_6 = manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401085", "story_v_side_new_1103401.awb") / 1000

					if var_345_6 + var_345_0 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_6 + var_345_0
					end

					if var_345_2.prefab_name ~= "" and arg_342_1.actors_[var_345_2.prefab_name] ~= nil then
						local var_345_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_342_1.actors_[var_345_2.prefab_name].transform, "story_v_side_new_1103401", "1103401085", "story_v_side_new_1103401.awb")

						arg_342_1:RecordAudio("1103401085", var_345_7)
						arg_342_1:RecordAudio("1103401085", var_345_7)
					else
						arg_342_1:AudioAction("play", "voice", "story_v_side_new_1103401", "1103401085", "story_v_side_new_1103401.awb")
					end

					arg_342_1:RecordHistoryTalkVoice("story_v_side_new_1103401", "1103401085", "story_v_side_new_1103401.awb")
				end

				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_8 = math.max(var_345_1, arg_342_1.talkMaxDuration)

			if var_345_0 <= arg_342_1.time_ and arg_342_1.time_ < var_345_0 + var_345_8 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_0) / var_345_8

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_0 + var_345_8 and arg_342_1.time_ < var_345_0 + var_345_8 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play1103401086 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 1103401086
		arg_346_1.duration_ = 5

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play1103401087(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 and not isNil(arg_346_1.actors_["1034ui_story"]) and arg_346_1.var_.characterEffect1034ui_story == nil then
				arg_346_1.var_.characterEffect1034ui_story = arg_346_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_349_0 = 0.200000002980232

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_0 and not isNil(arg_346_1.actors_["1034ui_story"]) then
				if arg_346_1.var_.characterEffect1034ui_story and not isNil(arg_346_1.actors_["1034ui_story"]) then
					arg_346_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_346_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_346_1.time_ - 0) / var_349_0)
				end
			end

			if arg_346_1.time_ >= 0 + var_349_0 and arg_346_1.time_ < 0 + var_349_0 + arg_349_0 and not isNil(arg_346_1.actors_["1034ui_story"]) and arg_346_1.var_.characterEffect1034ui_story then
				arg_346_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_346_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_349_1 = 0
			local var_349_2 = 1.825

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

				local var_349_3 = arg_346_1:FormatText(arg_346_1:GetWordFromCfg(1103401086).content)

				arg_346_1.text_.text = var_349_3

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_5 = 73 <= 0 and var_349_2 or var_349_2 * (utf8.len(var_349_3) / 73)

				if (73 <= 0 and var_349_2 or var_349_2 * (utf8.len(var_349_3) / 73)) > 0 and var_349_2 < var_349_5 then
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
	Play1103401087 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 1103401087
		arg_350_1.duration_ = 3.7

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play1103401088(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 and not isNil(arg_350_1.actors_["1034ui_story"]) and arg_350_1.var_.characterEffect1034ui_story == nil then
				arg_350_1.var_.characterEffect1034ui_story = arg_350_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_353_0 = 0.200000002980232

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_0 and not isNil(arg_350_1.actors_["1034ui_story"]) then
				if arg_350_1.var_.characterEffect1034ui_story and not isNil(arg_350_1.actors_["1034ui_story"]) then
					arg_350_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_350_1.time_ >= 0 + var_353_0 and arg_350_1.time_ < 0 + var_353_0 + arg_353_0 and not isNil(arg_350_1.actors_["1034ui_story"]) and arg_350_1.var_.characterEffect1034ui_story then
				arg_350_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 then
				arg_350_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_353_2 = 0
			local var_353_3 = 0.45

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= var_353_2 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				arg_350_1.leftNameTxt_.text = arg_350_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_350_1.leftNameTxt_.transform)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1.leftNameTxt_.text)
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_4 = arg_350_1:GetWordFromCfg(1103401087)
				local var_353_5 = arg_350_1:FormatText(var_353_4.content)

				arg_350_1.text_.text = var_353_5

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_7 = 18 <= 0 and var_353_3 or var_353_3 * (utf8.len(var_353_5) / 18)

				if (18 <= 0 and var_353_3 or var_353_3 * (utf8.len(var_353_5) / 18)) > 0 and var_353_3 < var_353_7 then
					arg_350_1.talkMaxDuration = var_353_7

					if var_353_7 + var_353_2 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_7 + var_353_2
					end
				end

				arg_350_1.text_.text = var_353_5
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401087", "story_v_side_new_1103401.awb") ~= 0 then
					local var_353_8 = manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401087", "story_v_side_new_1103401.awb") / 1000

					if var_353_8 + var_353_2 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_8 + var_353_2
					end

					if var_353_4.prefab_name ~= "" and arg_350_1.actors_[var_353_4.prefab_name] ~= nil then
						local var_353_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_350_1.actors_[var_353_4.prefab_name].transform, "story_v_side_new_1103401", "1103401087", "story_v_side_new_1103401.awb")

						arg_350_1:RecordAudio("1103401087", var_353_9)
						arg_350_1:RecordAudio("1103401087", var_353_9)
					else
						arg_350_1:AudioAction("play", "voice", "story_v_side_new_1103401", "1103401087", "story_v_side_new_1103401.awb")
					end

					arg_350_1:RecordHistoryTalkVoice("story_v_side_new_1103401", "1103401087", "story_v_side_new_1103401.awb")
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
	Play1103401088 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 1103401088
		arg_354_1.duration_ = 6.47

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play1103401089(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034actionlink/1034action475")
			end

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_zhayanR", "EmotionTimelineAnimator")
			end

			local var_357_0 = 0
			local var_357_1 = 0.85

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= var_357_0 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				arg_354_1.leftNameTxt_.text = arg_354_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_2 = arg_354_1:GetWordFromCfg(1103401088)
				local var_357_3 = arg_354_1:FormatText(var_357_2.content)

				arg_354_1.text_.text = var_357_3

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_5 = 34 <= 0 and var_357_1 or var_357_1 * (utf8.len(var_357_3) / 34)

				if (34 <= 0 and var_357_1 or var_357_1 * (utf8.len(var_357_3) / 34)) > 0 and var_357_1 < var_357_5 then
					arg_354_1.talkMaxDuration = var_357_5

					if var_357_5 + var_357_0 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_5 + var_357_0
					end
				end

				arg_354_1.text_.text = var_357_3
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401088", "story_v_side_new_1103401.awb") ~= 0 then
					local var_357_6 = manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401088", "story_v_side_new_1103401.awb") / 1000

					if var_357_6 + var_357_0 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_6 + var_357_0
					end

					if var_357_2.prefab_name ~= "" and arg_354_1.actors_[var_357_2.prefab_name] ~= nil then
						local var_357_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_354_1.actors_[var_357_2.prefab_name].transform, "story_v_side_new_1103401", "1103401088", "story_v_side_new_1103401.awb")

						arg_354_1:RecordAudio("1103401088", var_357_7)
						arg_354_1:RecordAudio("1103401088", var_357_7)
					else
						arg_354_1:AudioAction("play", "voice", "story_v_side_new_1103401", "1103401088", "story_v_side_new_1103401.awb")
					end

					arg_354_1:RecordHistoryTalkVoice("story_v_side_new_1103401", "1103401088", "story_v_side_new_1103401.awb")
				end

				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_8 = math.max(var_357_1, arg_354_1.talkMaxDuration)

			if var_357_0 <= arg_354_1.time_ and arg_354_1.time_ < var_357_0 + var_357_8 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_0) / var_357_8

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_0 + var_357_8 and arg_354_1.time_ < var_357_0 + var_357_8 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {}

		arg_354_1:InitPlayNodeList()
	end,
	Play1103401089 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 1103401089
		arg_358_1.duration_ = 6.47

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play1103401090(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			if arg_358_1.bgs_.ST02 == nil then
				local var_361_0 = Object.Instantiate(arg_358_1.paintGo_)

				var_361_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST02")
				var_361_0.name = "ST02"
				var_361_0.transform.parent = arg_358_1.stage_.transform
				var_361_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_358_1.bgs_.ST02 = var_361_0
			end

			if 2 < arg_358_1.time_ and arg_358_1.time_ <= 2 + arg_361_0 then
				local var_361_1 = arg_358_1.bgs_.ST02

				arg_358_1.bgs_.ST02.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_361_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_361_2 = var_361_1:GetComponent("SpriteRenderer")

				if var_361_2 and var_361_2.sprite then
					local var_361_3 = 2 * (var_361_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_361_1.transform.localScale = Vector3.New(var_361_3 / var_361_2.sprite.bounds.size.y < var_361_3 * manager.ui.mainCameraCom_.aspect / var_361_2.sprite.bounds.size.x and var_361_3 * manager.ui.mainCameraCom_.aspect / var_361_2.sprite.bounds.size.x or var_361_3 / var_361_2.sprite.bounds.size.y, var_361_3 / var_361_2.sprite.bounds.size.y < var_361_3 * manager.ui.mainCameraCom_.aspect / var_361_2.sprite.bounds.size.x and var_361_3 * manager.ui.mainCameraCom_.aspect / var_361_2.sprite.bounds.size.x or var_361_3 / var_361_2.sprite.bounds.size.y, 0)
				end

				for iter_361_0, iter_361_1 in pairs(arg_358_1.bgs_) do
					if iter_361_0 ~= "ST02" then
						iter_361_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_361_4 = 4

			if 4 < arg_358_1.time_ and arg_358_1.time_ <= var_361_4 + arg_361_0 then
				arg_358_1.allBtn_.enabled = false
			end

			if arg_358_1.time_ >= var_361_4 + 0.166666666666667 and arg_358_1.time_ < var_361_4 + 0.166666666666667 + arg_361_0 then
				arg_358_1.allBtn_.enabled = true
			end

			local var_361_5 = 0

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= var_361_5 + arg_361_0 then
				arg_358_1.mask_.enabled = true
				arg_358_1.mask_.raycastTarget = true

				arg_358_1:SetGaussion(false)
			end

			local var_361_6 = 2

			if var_361_5 <= arg_358_1.time_ and arg_358_1.time_ < var_361_5 + var_361_6 then
				local var_361_7 = Color.New(0, 0, 0)

				var_361_7.a = Mathf.Lerp(0, 1, (arg_358_1.time_ - var_361_5) / var_361_6)
				arg_358_1.mask_.color = var_361_7
			end

			if arg_358_1.time_ >= var_361_5 + var_361_6 and arg_358_1.time_ < var_361_5 + var_361_6 + arg_361_0 then
				local var_361_8 = Color.New(0, 0, 0)

				var_361_8.a = 1
				arg_358_1.mask_.color = var_361_8
			end

			local var_361_9 = 2

			if 2 < arg_358_1.time_ and arg_358_1.time_ <= var_361_9 + arg_361_0 then
				arg_358_1.mask_.enabled = true
				arg_358_1.mask_.raycastTarget = true

				arg_358_1:SetGaussion(false)
			end

			local var_361_10 = 2

			if var_361_9 <= arg_358_1.time_ and arg_358_1.time_ < var_361_9 + var_361_10 then
				local var_361_11 = Color.New(0, 0, 0)

				var_361_11.a = Mathf.Lerp(1, 0, (arg_358_1.time_ - var_361_9) / var_361_10)
				arg_358_1.mask_.color = var_361_11
			end

			if arg_358_1.time_ >= var_361_9 + var_361_10 and arg_358_1.time_ < var_361_9 + var_361_10 + arg_361_0 then
				local var_361_12 = Color.New(0, 0, 0)

				arg_358_1.mask_.enabled = false
				var_361_12.a = 0
				arg_358_1.mask_.color = var_361_12
			end

			local var_361_13 = arg_358_1.actors_["1034ui_story"].transform

			if 1.98333333333333 < arg_358_1.time_ and arg_358_1.time_ <= 1.98333333333333 + arg_361_0 then
				arg_358_1.var_.moveOldPos1034ui_story = var_361_13.localPosition
			end

			local var_361_14 = 0.001

			if 1.98333333333333 <= arg_358_1.time_ and arg_358_1.time_ < 1.98333333333333 + var_361_14 then
				var_361_13.localPosition = Vector3.Lerp(arg_358_1.var_.moveOldPos1034ui_story, Vector3.New(0, 100, 0), (arg_358_1.time_ - 1.98333333333333) / var_361_14)
				var_361_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_361_13.position).x, (manager.ui.mainCamera.transform.position - var_361_13.position).y, (manager.ui.mainCamera.transform.position - var_361_13.position).z)
				var_361_13.localEulerAngles.z = 0
				var_361_13.localEulerAngles.x = 0
				var_361_13.localEulerAngles = var_361_13.localEulerAngles
			end

			if arg_358_1.time_ >= 1.98333333333333 + var_361_14 and arg_358_1.time_ < 1.98333333333333 + var_361_14 + arg_361_0 then
				var_361_13.localPosition = Vector3.New(0, 100, 0)
				var_361_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_361_13.position).x, (manager.ui.mainCamera.transform.position - var_361_13.position).y, (manager.ui.mainCamera.transform.position - var_361_13.position).z)
				var_361_13.localEulerAngles.z = 0
				var_361_13.localEulerAngles.x = 0
				var_361_13.localEulerAngles = var_361_13.localEulerAngles
			end

			local var_361_15 = arg_358_1.actors_["1034ui_story"]

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 and not isNil(var_361_15) and arg_358_1.var_.characterEffect1034ui_story == nil then
				arg_358_1.var_.characterEffect1034ui_story = var_361_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_361_16 = 0.200000002980232

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_16 and not isNil(var_361_15) then
				if arg_358_1.var_.characterEffect1034ui_story and not isNil(var_361_15) then
					arg_358_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_358_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_358_1.time_ - 0) / var_361_16)
				end
			end

			if arg_358_1.time_ >= 0 + var_361_16 and arg_358_1.time_ < 0 + var_361_16 + arg_361_0 and not isNil(var_361_15) and arg_358_1.var_.characterEffect1034ui_story then
				arg_358_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_358_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 then
				arg_358_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileF_biyan", "EmotionTimelineAnimator")
			end

			if 0.133333333333333 < arg_358_1.time_ and arg_358_1.time_ <= 0.133333333333333 + arg_361_0 then
				arg_358_1:AudioAction("stop", "effect", "se_story_16", "se_story_16_street_loop", "")
			end

			if 1.5 < arg_358_1.time_ and arg_358_1.time_ <= 1.5 + arg_361_0 then
				arg_358_1:AudioAction("play", "effect", "se_story_side_1068", "se_story_1068_restaurant", "")
			end

			if arg_358_1.frameCnt_ <= 1 then
				arg_358_1.dialog_:SetActive(false)
			end

			local var_361_19 = 4
			local var_361_20 = 0.3

			if 4 < arg_358_1.time_ and arg_358_1.time_ <= var_361_19 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0

				arg_358_1.dialog_:SetActive(true)

				arg_358_1.dialogCg_.alpha = 0

				local var_361_21 = LeanTween.value(arg_358_1.dialog_, 0, 1, 0.3)

				var_361_21:setOnUpdate(LuaHelper.FloatAction(function(arg_362_0)
					arg_358_1.dialogCg_.alpha = arg_362_0
				end))
				var_361_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_358_1.dialog_)
					var_361_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_358_1.duration_ = arg_358_1.duration_ + 0.3

				SetActive(arg_358_1.leftNameGo_, true)

				arg_358_1.leftNameTxt_.text = arg_358_1:FormatText(StoryNameCfg[331].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, true)
				arg_358_1.iconController_:SetSelectedState("hero")

				arg_358_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowcitizenwc")

				arg_358_1.callingController_:SetSelectedState("normal")

				arg_358_1.keyicon_.color = Color.New(1, 1, 1)
				arg_358_1.icon_.color = Color.New(1, 1, 1)

				local var_361_22 = arg_358_1:GetWordFromCfg(1103401089)
				local var_361_23 = arg_358_1:FormatText(var_361_22.content)

				arg_358_1.text_.text = var_361_23

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_25 = 12 <= 0 and var_361_20 or var_361_20 * (utf8.len(var_361_23) / 12)

				if (12 <= 0 and var_361_20 or var_361_20 * (utf8.len(var_361_23) / 12)) > 0 and var_361_20 < var_361_25 then
					arg_358_1.talkMaxDuration = var_361_25
					var_361_19 = var_361_19 + 0.3

					if var_361_25 + var_361_19 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_25 + var_361_19
					end
				end

				arg_358_1.text_.text = var_361_23
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401089", "story_v_side_new_1103401.awb") ~= 0 then
					local var_361_26 = manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401089", "story_v_side_new_1103401.awb") / 1000

					if var_361_26 + var_361_19 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_26 + var_361_19
					end

					if var_361_22.prefab_name ~= "" and arg_358_1.actors_[var_361_22.prefab_name] ~= nil then
						local var_361_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_358_1.actors_[var_361_22.prefab_name].transform, "story_v_side_new_1103401", "1103401089", "story_v_side_new_1103401.awb")

						arg_358_1:RecordAudio("1103401089", var_361_27)
						arg_358_1:RecordAudio("1103401089", var_361_27)
					else
						arg_358_1:AudioAction("play", "voice", "story_v_side_new_1103401", "1103401089", "story_v_side_new_1103401.awb")
					end

					arg_358_1:RecordHistoryTalkVoice("story_v_side_new_1103401", "1103401089", "story_v_side_new_1103401.awb")
				end

				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_28 = var_361_19 + 0.3
			local var_361_29 = math.max(var_361_20, arg_358_1.talkMaxDuration)

			if var_361_19 + 0.3 <= arg_358_1.time_ and arg_358_1.time_ < var_361_28 + var_361_29 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_28) / var_361_29

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_28 + var_361_29 and arg_358_1.time_ < var_361_28 + var_361_29 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666666,
				className = "StoryMoveNode",
				startTime = 1.98333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_358_1:InitPlayNodeList()
	end,
	Play1103401090 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 1103401090
		arg_364_1.duration_ = 5

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play1103401091(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			local var_367_0 = 1.3

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, false)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_364_1.iconTrs_.gameObject, false)
				arg_364_1.callingController_:SetSelectedState("normal")

				local var_367_1 = arg_364_1:FormatText(arg_364_1:GetWordFromCfg(1103401090).content)

				arg_364_1.text_.text = var_367_1

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_3 = 52 <= 0 and var_367_0 or var_367_0 * (utf8.len(var_367_1) / 52)

				if (52 <= 0 and var_367_0 or var_367_0 * (utf8.len(var_367_1) / 52)) > 0 and var_367_0 < var_367_3 then
					arg_364_1.talkMaxDuration = var_367_3

					if var_367_3 + 0 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_3 + 0
					end
				end

				arg_364_1.text_.text = var_367_1
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)
				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_4 = math.max(var_367_0, arg_364_1.talkMaxDuration)

			if 0 <= arg_364_1.time_ and arg_364_1.time_ < 0 + var_367_4 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - 0) / var_367_4

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= 0 + var_367_4 and arg_364_1.time_ < 0 + var_367_4 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {}

		arg_364_1:InitPlayNodeList()
	end,
	Play1103401091 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 1103401091
		arg_368_1.duration_ = 5.6

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play1103401092(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 then
				arg_368_1.var_.moveOldPos1034ui_story = arg_368_1.actors_["1034ui_story"].transform.localPosition
			end

			local var_371_0 = 0.001

			if 0 <= arg_368_1.time_ and arg_368_1.time_ < 0 + var_371_0 then
				arg_368_1.actors_["1034ui_story"].transform.localPosition = Vector3.Lerp(arg_368_1.var_.moveOldPos1034ui_story, Vector3.New(0, -0.93, -6), (arg_368_1.time_ - 0) / var_371_0)
				arg_368_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_368_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_368_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_368_1.actors_["1034ui_story"].transform.position).z)
				arg_368_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_368_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_368_1.actors_["1034ui_story"].transform.localEulerAngles = arg_368_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			if arg_368_1.time_ >= 0 + var_371_0 and arg_368_1.time_ < 0 + var_371_0 + arg_371_0 then
				arg_368_1.actors_["1034ui_story"].transform.localPosition = Vector3.New(0, -0.93, -6)
				arg_368_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_368_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_368_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_368_1.actors_["1034ui_story"].transform.position).z)
				arg_368_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_368_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_368_1.actors_["1034ui_story"].transform.localEulerAngles = arg_368_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			local var_371_1 = arg_368_1.actors_["1034ui_story"]

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 and not isNil(var_371_1) and arg_368_1.var_.characterEffect1034ui_story == nil then
				arg_368_1.var_.characterEffect1034ui_story = var_371_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_371_2 = 0.200000002980232

			if 0 <= arg_368_1.time_ and arg_368_1.time_ < 0 + var_371_2 and not isNil(var_371_1) then
				if arg_368_1.var_.characterEffect1034ui_story and not isNil(var_371_1) then
					arg_368_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_368_1.time_ >= 0 + var_371_2 and arg_368_1.time_ < 0 + var_371_2 + arg_371_0 and not isNil(var_371_1) and arg_368_1.var_.characterEffect1034ui_story then
				arg_368_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 then
				arg_368_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action6_1")
			end

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 then
				arg_368_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_371_4 = 0
			local var_371_5 = 0.625

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= var_371_4 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, true)

				arg_368_1.leftNameTxt_.text = arg_368_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, false)
				arg_368_1.callingController_:SetSelectedState("normal")

				local var_371_6 = arg_368_1:GetWordFromCfg(1103401091)
				local var_371_7 = arg_368_1:FormatText(var_371_6.content)

				arg_368_1.text_.text = var_371_7

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_9 = 25 <= 0 and var_371_5 or var_371_5 * (utf8.len(var_371_7) / 25)

				if (25 <= 0 and var_371_5 or var_371_5 * (utf8.len(var_371_7) / 25)) > 0 and var_371_5 < var_371_9 then
					arg_368_1.talkMaxDuration = var_371_9

					if var_371_9 + var_371_4 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_9 + var_371_4
					end
				end

				arg_368_1.text_.text = var_371_7
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401091", "story_v_side_new_1103401.awb") ~= 0 then
					local var_371_10 = manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401091", "story_v_side_new_1103401.awb") / 1000

					if var_371_10 + var_371_4 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_10 + var_371_4
					end

					if var_371_6.prefab_name ~= "" and arg_368_1.actors_[var_371_6.prefab_name] ~= nil then
						local var_371_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_368_1.actors_[var_371_6.prefab_name].transform, "story_v_side_new_1103401", "1103401091", "story_v_side_new_1103401.awb")

						arg_368_1:RecordAudio("1103401091", var_371_11)
						arg_368_1:RecordAudio("1103401091", var_371_11)
					else
						arg_368_1:AudioAction("play", "voice", "story_v_side_new_1103401", "1103401091", "story_v_side_new_1103401.awb")
					end

					arg_368_1:RecordHistoryTalkVoice("story_v_side_new_1103401", "1103401091", "story_v_side_new_1103401.awb")
				end

				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_12 = math.max(var_371_5, arg_368_1.talkMaxDuration)

			if var_371_4 <= arg_368_1.time_ and arg_368_1.time_ < var_371_4 + var_371_12 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_4) / var_371_12

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_4 + var_371_12 and arg_368_1.time_ < var_371_4 + var_371_12 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_368_1:InitPlayNodeList()
	end,
	Play1103401092 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 1103401092
		arg_372_1.duration_ = 5

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play1103401093(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			if 0 < arg_372_1.time_ and arg_372_1.time_ <= 0 + arg_375_0 and not isNil(arg_372_1.actors_["1034ui_story"]) and arg_372_1.var_.characterEffect1034ui_story == nil then
				arg_372_1.var_.characterEffect1034ui_story = arg_372_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_375_0 = 0.200000002980232

			if 0 <= arg_372_1.time_ and arg_372_1.time_ < 0 + var_375_0 and not isNil(arg_372_1.actors_["1034ui_story"]) then
				if arg_372_1.var_.characterEffect1034ui_story and not isNil(arg_372_1.actors_["1034ui_story"]) then
					arg_372_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_372_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_372_1.time_ - 0) / var_375_0)
				end
			end

			if arg_372_1.time_ >= 0 + var_375_0 and arg_372_1.time_ < 0 + var_375_0 + arg_375_0 and not isNil(arg_372_1.actors_["1034ui_story"]) and arg_372_1.var_.characterEffect1034ui_story then
				arg_372_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_372_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_375_1 = 0
			local var_375_2 = 0.35

			if 0 < arg_372_1.time_ and arg_372_1.time_ <= var_375_1 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, true)

				arg_372_1.leftNameTxt_.text = arg_372_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_372_1.leftNameTxt_.transform)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1.leftNameTxt_.text)
				SetActive(arg_372_1.iconTrs_.gameObject, true)
				arg_372_1.iconController_:SetSelectedState("hero")

				arg_372_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_372_1.callingController_:SetSelectedState("normal")

				arg_372_1.keyicon_.color = Color.New(1, 1, 1)
				arg_372_1.icon_.color = Color.New(1, 1, 1)

				local var_375_3 = arg_372_1:FormatText(arg_372_1:GetWordFromCfg(1103401092).content)

				arg_372_1.text_.text = var_375_3

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_5 = 14 <= 0 and var_375_2 or var_375_2 * (utf8.len(var_375_3) / 14)

				if (14 <= 0 and var_375_2 or var_375_2 * (utf8.len(var_375_3) / 14)) > 0 and var_375_2 < var_375_5 then
					arg_372_1.talkMaxDuration = var_375_5

					if var_375_5 + var_375_1 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_5 + var_375_1
					end
				end

				arg_372_1.text_.text = var_375_3
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)
				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_6 = math.max(var_375_2, arg_372_1.talkMaxDuration)

			if var_375_1 <= arg_372_1.time_ and arg_372_1.time_ < var_375_1 + var_375_6 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_1) / var_375_6

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_1 + var_375_6 and arg_372_1.time_ < var_375_1 + var_375_6 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {}

		arg_372_1:InitPlayNodeList()
	end,
	Play1103401093 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 1103401093
		arg_376_1.duration_ = 9.3

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play1103401094(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 and not isNil(arg_376_1.actors_["1034ui_story"]) and arg_376_1.var_.characterEffect1034ui_story == nil then
				arg_376_1.var_.characterEffect1034ui_story = arg_376_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_379_0 = 0.200000002980232

			if 0 <= arg_376_1.time_ and arg_376_1.time_ < 0 + var_379_0 and not isNil(arg_376_1.actors_["1034ui_story"]) then
				if arg_376_1.var_.characterEffect1034ui_story and not isNil(arg_376_1.actors_["1034ui_story"]) then
					arg_376_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_376_1.time_ >= 0 + var_379_0 and arg_376_1.time_ < 0 + var_379_0 + arg_379_0 and not isNil(arg_376_1.actors_["1034ui_story"]) and arg_376_1.var_.characterEffect1034ui_story then
				arg_376_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 then
				arg_376_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_deyiB", "EmotionTimelineAnimator")
			end

			local var_379_2 = 0
			local var_379_3 = 0.925

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= var_379_2 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, true)

				arg_376_1.leftNameTxt_.text = arg_376_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_376_1.leftNameTxt_.transform)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1.leftNameTxt_.text)
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_4 = arg_376_1:GetWordFromCfg(1103401093)
				local var_379_5 = arg_376_1:FormatText(var_379_4.content)

				arg_376_1.text_.text = var_379_5

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_7 = 37 <= 0 and var_379_3 or var_379_3 * (utf8.len(var_379_5) / 37)

				if (37 <= 0 and var_379_3 or var_379_3 * (utf8.len(var_379_5) / 37)) > 0 and var_379_3 < var_379_7 then
					arg_376_1.talkMaxDuration = var_379_7

					if var_379_7 + var_379_2 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_7 + var_379_2
					end
				end

				arg_376_1.text_.text = var_379_5
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401093", "story_v_side_new_1103401.awb") ~= 0 then
					local var_379_8 = manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401093", "story_v_side_new_1103401.awb") / 1000

					if var_379_8 + var_379_2 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_8 + var_379_2
					end

					if var_379_4.prefab_name ~= "" and arg_376_1.actors_[var_379_4.prefab_name] ~= nil then
						local var_379_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_376_1.actors_[var_379_4.prefab_name].transform, "story_v_side_new_1103401", "1103401093", "story_v_side_new_1103401.awb")

						arg_376_1:RecordAudio("1103401093", var_379_9)
						arg_376_1:RecordAudio("1103401093", var_379_9)
					else
						arg_376_1:AudioAction("play", "voice", "story_v_side_new_1103401", "1103401093", "story_v_side_new_1103401.awb")
					end

					arg_376_1:RecordHistoryTalkVoice("story_v_side_new_1103401", "1103401093", "story_v_side_new_1103401.awb")
				end

				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_10 = math.max(var_379_3, arg_376_1.talkMaxDuration)

			if var_379_2 <= arg_376_1.time_ and arg_376_1.time_ < var_379_2 + var_379_10 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_2) / var_379_10

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_2 + var_379_10 and arg_376_1.time_ < var_379_2 + var_379_10 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {}

		arg_376_1:InitPlayNodeList()
	end,
	Play1103401094 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 1103401094
		arg_380_1.duration_ = 5

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play1103401095(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 and not isNil(arg_380_1.actors_["1034ui_story"]) and arg_380_1.var_.characterEffect1034ui_story == nil then
				arg_380_1.var_.characterEffect1034ui_story = arg_380_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_383_0 = 0.200000002980232

			if 0 <= arg_380_1.time_ and arg_380_1.time_ < 0 + var_383_0 and not isNil(arg_380_1.actors_["1034ui_story"]) then
				if arg_380_1.var_.characterEffect1034ui_story and not isNil(arg_380_1.actors_["1034ui_story"]) then
					arg_380_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_380_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_380_1.time_ - 0) / var_383_0)
				end
			end

			if arg_380_1.time_ >= 0 + var_383_0 and arg_380_1.time_ < 0 + var_383_0 + arg_383_0 and not isNil(arg_380_1.actors_["1034ui_story"]) and arg_380_1.var_.characterEffect1034ui_story then
				arg_380_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_380_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_383_1 = 0
			local var_383_2 = 0.775

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= var_383_1 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, true)

				arg_380_1.leftNameTxt_.text = arg_380_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_380_1.leftNameTxt_.transform)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1.leftNameTxt_.text)
				SetActive(arg_380_1.iconTrs_.gameObject, true)
				arg_380_1.iconController_:SetSelectedState("hero")

				arg_380_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_380_1.callingController_:SetSelectedState("normal")

				arg_380_1.keyicon_.color = Color.New(1, 1, 1)
				arg_380_1.icon_.color = Color.New(1, 1, 1)

				local var_383_3 = arg_380_1:FormatText(arg_380_1:GetWordFromCfg(1103401094).content)

				arg_380_1.text_.text = var_383_3

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_5 = 31 <= 0 and var_383_2 or var_383_2 * (utf8.len(var_383_3) / 31)

				if (31 <= 0 and var_383_2 or var_383_2 * (utf8.len(var_383_3) / 31)) > 0 and var_383_2 < var_383_5 then
					arg_380_1.talkMaxDuration = var_383_5

					if var_383_5 + var_383_1 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_5 + var_383_1
					end
				end

				arg_380_1.text_.text = var_383_3
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)
				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_6 = math.max(var_383_2, arg_380_1.talkMaxDuration)

			if var_383_1 <= arg_380_1.time_ and arg_380_1.time_ < var_383_1 + var_383_6 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_1) / var_383_6

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_1 + var_383_6 and arg_380_1.time_ < var_383_1 + var_383_6 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {}

		arg_380_1:InitPlayNodeList()
	end,
	Play1103401095 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 1103401095
		arg_384_1.duration_ = 5

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play1103401096(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 then
				arg_384_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action6_2")
			end

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 then
				arg_384_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_387_0 = 0
			local var_387_1 = 1.675

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= var_387_0 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, false)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_384_1.iconTrs_.gameObject, false)
				arg_384_1.callingController_:SetSelectedState("normal")

				local var_387_2 = arg_384_1:FormatText(arg_384_1:GetWordFromCfg(1103401095).content)

				arg_384_1.text_.text = var_387_2

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_4 = 67 <= 0 and var_387_1 or var_387_1 * (utf8.len(var_387_2) / 67)

				if (67 <= 0 and var_387_1 or var_387_1 * (utf8.len(var_387_2) / 67)) > 0 and var_387_1 < var_387_4 then
					arg_384_1.talkMaxDuration = var_387_4

					if var_387_4 + var_387_0 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_4 + var_387_0
					end
				end

				arg_384_1.text_.text = var_387_2
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)
				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_5 = math.max(var_387_1, arg_384_1.talkMaxDuration)

			if var_387_0 <= arg_384_1.time_ and arg_384_1.time_ < var_387_0 + var_387_5 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_0) / var_387_5

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_0 + var_387_5 and arg_384_1.time_ < var_387_0 + var_387_5 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {}

		arg_384_1:InitPlayNodeList()
	end,
	Play1103401096 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 1103401096
		arg_388_1.duration_ = 5

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play1103401097(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			local var_391_0 = 0.425

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, true)

				arg_388_1.leftNameTxt_.text = arg_388_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_388_1.leftNameTxt_.transform)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1.leftNameTxt_.text)
				SetActive(arg_388_1.iconTrs_.gameObject, true)
				arg_388_1.iconController_:SetSelectedState("hero")

				arg_388_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_388_1.callingController_:SetSelectedState("normal")

				arg_388_1.keyicon_.color = Color.New(1, 1, 1)
				arg_388_1.icon_.color = Color.New(1, 1, 1)

				local var_391_1 = arg_388_1:FormatText(arg_388_1:GetWordFromCfg(1103401096).content)

				arg_388_1.text_.text = var_391_1

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_3 = 17 <= 0 and var_391_0 or var_391_0 * (utf8.len(var_391_1) / 17)

				if (17 <= 0 and var_391_0 or var_391_0 * (utf8.len(var_391_1) / 17)) > 0 and var_391_0 < var_391_3 then
					arg_388_1.talkMaxDuration = var_391_3

					if var_391_3 + 0 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_3 + 0
					end
				end

				arg_388_1.text_.text = var_391_1
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)
				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_4 = math.max(var_391_0, arg_388_1.talkMaxDuration)

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_4 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - 0) / var_391_4

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= 0 + var_391_4 and arg_388_1.time_ < 0 + var_391_4 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {}

		arg_388_1:InitPlayNodeList()
	end,
	Play1103401097 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 1103401097
		arg_392_1.duration_ = 5

		SetActive(arg_392_1.tipsGo_, false)

		function arg_392_1.onSingleLineFinish_()
			arg_392_1.onSingleLineUpdate_ = nil
			arg_392_1.onSingleLineFinish_ = nil
			arg_392_1.state_ = "waiting"
		end

		function arg_392_1.playNext_(arg_394_0)
			if arg_394_0 == 1 then
				arg_392_0:Play1103401098(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			local var_395_0 = 0.65

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, true)

				arg_392_1.leftNameTxt_.text = arg_392_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_392_1.leftNameTxt_.transform)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1.leftNameTxt_.text)
				SetActive(arg_392_1.iconTrs_.gameObject, true)
				arg_392_1.iconController_:SetSelectedState("hero")

				arg_392_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_392_1.callingController_:SetSelectedState("normal")

				arg_392_1.keyicon_.color = Color.New(1, 1, 1)
				arg_392_1.icon_.color = Color.New(1, 1, 1)

				local var_395_1 = arg_392_1:FormatText(arg_392_1:GetWordFromCfg(1103401097).content)

				arg_392_1.text_.text = var_395_1

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_3 = 26 <= 0 and var_395_0 or var_395_0 * (utf8.len(var_395_1) / 26)

				if (26 <= 0 and var_395_0 or var_395_0 * (utf8.len(var_395_1) / 26)) > 0 and var_395_0 < var_395_3 then
					arg_392_1.talkMaxDuration = var_395_3

					if var_395_3 + 0 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_3 + 0
					end
				end

				arg_392_1.text_.text = var_395_1
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)
				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_4 = math.max(var_395_0, arg_392_1.talkMaxDuration)

			if 0 <= arg_392_1.time_ and arg_392_1.time_ < 0 + var_395_4 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - 0) / var_395_4

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= 0 + var_395_4 and arg_392_1.time_ < 0 + var_395_4 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {}

		arg_392_1:InitPlayNodeList()
	end,
	Play1103401098 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 1103401098
		arg_396_1.duration_ = 7.47

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"
		end

		function arg_396_1.playNext_(arg_398_0)
			if arg_398_0 == 1 then
				arg_396_0:Play1103401099(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 and not isNil(arg_396_1.actors_["1034ui_story"]) and arg_396_1.var_.characterEffect1034ui_story == nil then
				arg_396_1.var_.characterEffect1034ui_story = arg_396_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_399_0 = 0.200000002980232

			if 0 <= arg_396_1.time_ and arg_396_1.time_ < 0 + var_399_0 and not isNil(arg_396_1.actors_["1034ui_story"]) then
				if arg_396_1.var_.characterEffect1034ui_story and not isNil(arg_396_1.actors_["1034ui_story"]) then
					arg_396_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_396_1.time_ >= 0 + var_399_0 and arg_396_1.time_ < 0 + var_399_0 + arg_399_0 and not isNil(arg_396_1.actors_["1034ui_story"]) and arg_396_1.var_.characterEffect1034ui_story then
				arg_396_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 then
				arg_396_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action5_1")
			end

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 then
				arg_396_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_biyanbiaozhun", "EmotionTimelineAnimator")
			end

			local var_399_2 = 0
			local var_399_3 = 0.725

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= var_399_2 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, true)

				arg_396_1.leftNameTxt_.text = arg_396_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_396_1.leftNameTxt_.transform)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1.leftNameTxt_.text)
				SetActive(arg_396_1.iconTrs_.gameObject, false)
				arg_396_1.callingController_:SetSelectedState("normal")

				local var_399_4 = arg_396_1:GetWordFromCfg(1103401098)
				local var_399_5 = arg_396_1:FormatText(var_399_4.content)

				arg_396_1.text_.text = var_399_5

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_7 = 29 <= 0 and var_399_3 or var_399_3 * (utf8.len(var_399_5) / 29)

				if (29 <= 0 and var_399_3 or var_399_3 * (utf8.len(var_399_5) / 29)) > 0 and var_399_3 < var_399_7 then
					arg_396_1.talkMaxDuration = var_399_7

					if var_399_7 + var_399_2 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_7 + var_399_2
					end
				end

				arg_396_1.text_.text = var_399_5
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401098", "story_v_side_new_1103401.awb") ~= 0 then
					local var_399_8 = manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401098", "story_v_side_new_1103401.awb") / 1000

					if var_399_8 + var_399_2 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_8 + var_399_2
					end

					if var_399_4.prefab_name ~= "" and arg_396_1.actors_[var_399_4.prefab_name] ~= nil then
						local var_399_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_396_1.actors_[var_399_4.prefab_name].transform, "story_v_side_new_1103401", "1103401098", "story_v_side_new_1103401.awb")

						arg_396_1:RecordAudio("1103401098", var_399_9)
						arg_396_1:RecordAudio("1103401098", var_399_9)
					else
						arg_396_1:AudioAction("play", "voice", "story_v_side_new_1103401", "1103401098", "story_v_side_new_1103401.awb")
					end

					arg_396_1:RecordHistoryTalkVoice("story_v_side_new_1103401", "1103401098", "story_v_side_new_1103401.awb")
				end

				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_10 = math.max(var_399_3, arg_396_1.talkMaxDuration)

			if var_399_2 <= arg_396_1.time_ and arg_396_1.time_ < var_399_2 + var_399_10 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - var_399_2) / var_399_10

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= var_399_2 + var_399_10 and arg_396_1.time_ < var_399_2 + var_399_10 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {}

		arg_396_1:InitPlayNodeList()
	end,
	Play1103401099 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 1103401099
		arg_400_1.duration_ = 5

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play1103401100(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 and not isNil(arg_400_1.actors_["1034ui_story"]) and arg_400_1.var_.characterEffect1034ui_story == nil then
				arg_400_1.var_.characterEffect1034ui_story = arg_400_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_403_0 = 0.200000002980232

			if 0 <= arg_400_1.time_ and arg_400_1.time_ < 0 + var_403_0 and not isNil(arg_400_1.actors_["1034ui_story"]) then
				if arg_400_1.var_.characterEffect1034ui_story and not isNil(arg_400_1.actors_["1034ui_story"]) then
					arg_400_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_400_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_400_1.time_ - 0) / var_403_0)
				end
			end

			if arg_400_1.time_ >= 0 + var_403_0 and arg_400_1.time_ < 0 + var_403_0 + arg_403_0 and not isNil(arg_400_1.actors_["1034ui_story"]) and arg_400_1.var_.characterEffect1034ui_story then
				arg_400_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_400_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 then
				arg_400_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_403_1 = 0
			local var_403_2 = 0.6

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= var_403_1 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, true)

				arg_400_1.leftNameTxt_.text = arg_400_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_400_1.leftNameTxt_.transform)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1.leftNameTxt_.text)
				SetActive(arg_400_1.iconTrs_.gameObject, true)
				arg_400_1.iconController_:SetSelectedState("hero")

				arg_400_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_400_1.callingController_:SetSelectedState("normal")

				arg_400_1.keyicon_.color = Color.New(1, 1, 1)
				arg_400_1.icon_.color = Color.New(1, 1, 1)

				local var_403_3 = arg_400_1:FormatText(arg_400_1:GetWordFromCfg(1103401099).content)

				arg_400_1.text_.text = var_403_3

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_5 = 24 <= 0 and var_403_2 or var_403_2 * (utf8.len(var_403_3) / 24)

				if (24 <= 0 and var_403_2 or var_403_2 * (utf8.len(var_403_3) / 24)) > 0 and var_403_2 < var_403_5 then
					arg_400_1.talkMaxDuration = var_403_5

					if var_403_5 + var_403_1 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_5 + var_403_1
					end
				end

				arg_400_1.text_.text = var_403_3
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)
				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_6 = math.max(var_403_2, arg_400_1.talkMaxDuration)

			if var_403_1 <= arg_400_1.time_ and arg_400_1.time_ < var_403_1 + var_403_6 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - var_403_1) / var_403_6

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= var_403_1 + var_403_6 and arg_400_1.time_ < var_403_1 + var_403_6 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {}

		arg_400_1:InitPlayNodeList()
	end,
	Play1103401100 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 1103401100
		arg_404_1.duration_ = 5.73

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play1103401101(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 and not isNil(arg_404_1.actors_["1034ui_story"]) and arg_404_1.var_.characterEffect1034ui_story == nil then
				arg_404_1.var_.characterEffect1034ui_story = arg_404_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_407_0 = 0.200000002980232

			if 0 <= arg_404_1.time_ and arg_404_1.time_ < 0 + var_407_0 and not isNil(arg_404_1.actors_["1034ui_story"]) then
				if arg_404_1.var_.characterEffect1034ui_story and not isNil(arg_404_1.actors_["1034ui_story"]) then
					arg_404_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_404_1.time_ >= 0 + var_407_0 and arg_404_1.time_ < 0 + var_407_0 + arg_407_0 and not isNil(arg_404_1.actors_["1034ui_story"]) and arg_404_1.var_.characterEffect1034ui_story then
				arg_404_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 then
				arg_404_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action5_2")
			end

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 then
				arg_404_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_407_2 = 0
			local var_407_3 = 0.575

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= var_407_2 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, true)

				arg_404_1.leftNameTxt_.text = arg_404_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_404_1.leftNameTxt_.transform)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1.leftNameTxt_.text)
				SetActive(arg_404_1.iconTrs_.gameObject, false)
				arg_404_1.callingController_:SetSelectedState("normal")

				local var_407_4 = arg_404_1:GetWordFromCfg(1103401100)
				local var_407_5 = arg_404_1:FormatText(var_407_4.content)

				arg_404_1.text_.text = var_407_5

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_7 = 23 <= 0 and var_407_3 or var_407_3 * (utf8.len(var_407_5) / 23)

				if (23 <= 0 and var_407_3 or var_407_3 * (utf8.len(var_407_5) / 23)) > 0 and var_407_3 < var_407_7 then
					arg_404_1.talkMaxDuration = var_407_7

					if var_407_7 + var_407_2 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_7 + var_407_2
					end
				end

				arg_404_1.text_.text = var_407_5
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401100", "story_v_side_new_1103401.awb") ~= 0 then
					local var_407_8 = manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401100", "story_v_side_new_1103401.awb") / 1000

					if var_407_8 + var_407_2 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_8 + var_407_2
					end

					if var_407_4.prefab_name ~= "" and arg_404_1.actors_[var_407_4.prefab_name] ~= nil then
						local var_407_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_404_1.actors_[var_407_4.prefab_name].transform, "story_v_side_new_1103401", "1103401100", "story_v_side_new_1103401.awb")

						arg_404_1:RecordAudio("1103401100", var_407_9)
						arg_404_1:RecordAudio("1103401100", var_407_9)
					else
						arg_404_1:AudioAction("play", "voice", "story_v_side_new_1103401", "1103401100", "story_v_side_new_1103401.awb")
					end

					arg_404_1:RecordHistoryTalkVoice("story_v_side_new_1103401", "1103401100", "story_v_side_new_1103401.awb")
				end

				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_10 = math.max(var_407_3, arg_404_1.talkMaxDuration)

			if var_407_2 <= arg_404_1.time_ and arg_404_1.time_ < var_407_2 + var_407_10 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - var_407_2) / var_407_10

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= var_407_2 + var_407_10 and arg_404_1.time_ < var_407_2 + var_407_10 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {}

		arg_404_1:InitPlayNodeList()
	end,
	Play1103401101 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 1103401101
		arg_408_1.duration_ = 3.6

		SetActive(arg_408_1.tipsGo_, false)

		function arg_408_1.onSingleLineFinish_()
			arg_408_1.onSingleLineUpdate_ = nil
			arg_408_1.onSingleLineFinish_ = nil
			arg_408_1.state_ = "waiting"
		end

		function arg_408_1.playNext_(arg_410_0)
			if arg_410_0 == 1 then
				arg_408_0:Play1103401102(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 then
				arg_408_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action6_1")
			end

			local var_411_0 = 0
			local var_411_1 = 0.5

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= var_411_0 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, true)

				arg_408_1.leftNameTxt_.text = arg_408_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_408_1.leftNameTxt_.transform)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1.leftNameTxt_.text)
				SetActive(arg_408_1.iconTrs_.gameObject, false)
				arg_408_1.callingController_:SetSelectedState("normal")

				local var_411_2 = arg_408_1:GetWordFromCfg(1103401101)
				local var_411_3 = arg_408_1:FormatText(var_411_2.content)

				arg_408_1.text_.text = var_411_3

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_5 = 20 <= 0 and var_411_1 or var_411_1 * (utf8.len(var_411_3) / 20)

				if (20 <= 0 and var_411_1 or var_411_1 * (utf8.len(var_411_3) / 20)) > 0 and var_411_1 < var_411_5 then
					arg_408_1.talkMaxDuration = var_411_5

					if var_411_5 + var_411_0 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_5 + var_411_0
					end
				end

				arg_408_1.text_.text = var_411_3
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401101", "story_v_side_new_1103401.awb") ~= 0 then
					local var_411_6 = manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401101", "story_v_side_new_1103401.awb") / 1000

					if var_411_6 + var_411_0 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_6 + var_411_0
					end

					if var_411_2.prefab_name ~= "" and arg_408_1.actors_[var_411_2.prefab_name] ~= nil then
						local var_411_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_408_1.actors_[var_411_2.prefab_name].transform, "story_v_side_new_1103401", "1103401101", "story_v_side_new_1103401.awb")

						arg_408_1:RecordAudio("1103401101", var_411_7)
						arg_408_1:RecordAudio("1103401101", var_411_7)
					else
						arg_408_1:AudioAction("play", "voice", "story_v_side_new_1103401", "1103401101", "story_v_side_new_1103401.awb")
					end

					arg_408_1:RecordHistoryTalkVoice("story_v_side_new_1103401", "1103401101", "story_v_side_new_1103401.awb")
				end

				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_8 = math.max(var_411_1, arg_408_1.talkMaxDuration)

			if var_411_0 <= arg_408_1.time_ and arg_408_1.time_ < var_411_0 + var_411_8 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - var_411_0) / var_411_8

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= var_411_0 + var_411_8 and arg_408_1.time_ < var_411_0 + var_411_8 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {}

		arg_408_1:InitPlayNodeList()
	end,
	Play1103401102 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 1103401102
		arg_412_1.duration_ = 5

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play1103401103(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 and not isNil(arg_412_1.actors_["1034ui_story"]) and arg_412_1.var_.characterEffect1034ui_story == nil then
				arg_412_1.var_.characterEffect1034ui_story = arg_412_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_415_0 = 0.200000002980232

			if 0 <= arg_412_1.time_ and arg_412_1.time_ < 0 + var_415_0 and not isNil(arg_412_1.actors_["1034ui_story"]) then
				if arg_412_1.var_.characterEffect1034ui_story and not isNil(arg_412_1.actors_["1034ui_story"]) then
					arg_412_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_412_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_412_1.time_ - 0) / var_415_0)
				end
			end

			if arg_412_1.time_ >= 0 + var_415_0 and arg_412_1.time_ < 0 + var_415_0 + arg_415_0 and not isNil(arg_412_1.actors_["1034ui_story"]) and arg_412_1.var_.characterEffect1034ui_story then
				arg_412_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_412_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 then
				arg_412_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action6_2")
			end

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 then
				arg_412_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileF_biyan", "EmotionTimelineAnimator")
			end

			local var_415_1 = 0
			local var_415_2 = 1.475

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= var_415_1 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, false)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_412_1.iconTrs_.gameObject, false)
				arg_412_1.callingController_:SetSelectedState("normal")

				local var_415_3 = arg_412_1:FormatText(arg_412_1:GetWordFromCfg(1103401102).content)

				arg_412_1.text_.text = var_415_3

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_5 = 59 <= 0 and var_415_2 or var_415_2 * (utf8.len(var_415_3) / 59)

				if (59 <= 0 and var_415_2 or var_415_2 * (utf8.len(var_415_3) / 59)) > 0 and var_415_2 < var_415_5 then
					arg_412_1.talkMaxDuration = var_415_5

					if var_415_5 + var_415_1 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_5 + var_415_1
					end
				end

				arg_412_1.text_.text = var_415_3
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)
				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_6 = math.max(var_415_2, arg_412_1.talkMaxDuration)

			if var_415_1 <= arg_412_1.time_ and arg_412_1.time_ < var_415_1 + var_415_6 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - var_415_1) / var_415_6

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= var_415_1 + var_415_6 and arg_412_1.time_ < var_415_1 + var_415_6 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {}

		arg_412_1:InitPlayNodeList()
	end,
	Play1103401103 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 1103401103
		arg_416_1.duration_ = 5

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
		end

		function arg_416_1.playNext_(arg_418_0)
			if arg_418_0 == 1 then
				arg_416_0:Play1103401104(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 then
				arg_416_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_419_0 = 0
			local var_419_1 = 1.975

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= var_419_0 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, false)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_416_1.iconTrs_.gameObject, false)
				arg_416_1.callingController_:SetSelectedState("normal")

				local var_419_2 = arg_416_1:FormatText(arg_416_1:GetWordFromCfg(1103401103).content)

				arg_416_1.text_.text = var_419_2

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_4 = 79 <= 0 and var_419_1 or var_419_1 * (utf8.len(var_419_2) / 79)

				if (79 <= 0 and var_419_1 or var_419_1 * (utf8.len(var_419_2) / 79)) > 0 and var_419_1 < var_419_4 then
					arg_416_1.talkMaxDuration = var_419_4

					if var_419_4 + var_419_0 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_4 + var_419_0
					end
				end

				arg_416_1.text_.text = var_419_2
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)
				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_5 = math.max(var_419_1, arg_416_1.talkMaxDuration)

			if var_419_0 <= arg_416_1.time_ and arg_416_1.time_ < var_419_0 + var_419_5 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - var_419_0) / var_419_5

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= var_419_0 + var_419_5 and arg_416_1.time_ < var_419_0 + var_419_5 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {}

		arg_416_1:InitPlayNodeList()
	end,
	Play1103401104 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 1103401104
		arg_420_1.duration_ = 2

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"

			SetActive(arg_420_1.choicesGo_, true)

			for iter_421_0, iter_421_1 in ipairs(arg_420_1.choices_) do
				SetActive(iter_421_1.go, iter_421_0 <= 2)
			end

			arg_420_1.choices_[1].txt.text = arg_420_1:FormatText(StoryChoiceCfg[1448].name)
			arg_420_1.choices_[2].txt.text = arg_420_1:FormatText(StoryChoiceCfg[1449].name)
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play1103401105(arg_420_1)
			end

			if arg_422_0 == 2 then
				arg_420_0:Play1103401108(arg_420_1)
			end

			arg_420_1:RecordChoiceLog(1103401104, 1448, 1449)
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 then
				arg_420_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_deyiA", "EmotionTimelineAnimator")
			end

			local var_423_0 = 0

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= var_423_0 + arg_423_0 then
				arg_420_1.allBtn_.enabled = false
			end

			if arg_420_1.time_ >= var_423_0 + 0.733333333333333 and arg_420_1.time_ < var_423_0 + 0.733333333333333 + arg_423_0 then
				arg_420_1.allBtn_.enabled = true
			end
		end

		arg_420_1.nodeConfigList_ = {}

		arg_420_1:InitPlayNodeList()
	end,
	Play1103401105 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 1103401105
		arg_424_1.duration_ = 5.4

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
		end

		function arg_424_1.playNext_(arg_426_0)
			if arg_426_0 == 1 then
				arg_424_0:Play1103401106(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 and not isNil(arg_424_1.actors_["1034ui_story"]) and arg_424_1.var_.characterEffect1034ui_story == nil then
				arg_424_1.var_.characterEffect1034ui_story = arg_424_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_427_0 = 0.200000002980232

			if 0 <= arg_424_1.time_ and arg_424_1.time_ < 0 + var_427_0 and not isNil(arg_424_1.actors_["1034ui_story"]) then
				if arg_424_1.var_.characterEffect1034ui_story and not isNil(arg_424_1.actors_["1034ui_story"]) then
					arg_424_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_424_1.time_ >= 0 + var_427_0 and arg_424_1.time_ < 0 + var_427_0 + arg_427_0 and not isNil(arg_424_1.actors_["1034ui_story"]) and arg_424_1.var_.characterEffect1034ui_story then
				arg_424_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 then
				arg_424_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action7_1")
			end

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 then
				arg_424_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_deyiB", "EmotionTimelineAnimator")
			end

			local var_427_2 = 0
			local var_427_3 = 0.575

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= var_427_2 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0
				arg_424_1.dialogCg_.alpha = 1

				arg_424_1.dialog_:SetActive(true)
				SetActive(arg_424_1.leftNameGo_, true)

				arg_424_1.leftNameTxt_.text = arg_424_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_424_1.leftNameTxt_.transform)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1.leftNameTxt_.text)
				SetActive(arg_424_1.iconTrs_.gameObject, false)
				arg_424_1.callingController_:SetSelectedState("normal")

				local var_427_4 = arg_424_1:GetWordFromCfg(1103401105)
				local var_427_5 = arg_424_1:FormatText(var_427_4.content)

				arg_424_1.text_.text = var_427_5

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_7 = 23 <= 0 and var_427_3 or var_427_3 * (utf8.len(var_427_5) / 23)

				if (23 <= 0 and var_427_3 or var_427_3 * (utf8.len(var_427_5) / 23)) > 0 and var_427_3 < var_427_7 then
					arg_424_1.talkMaxDuration = var_427_7

					if var_427_7 + var_427_2 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_7 + var_427_2
					end
				end

				arg_424_1.text_.text = var_427_5
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401105", "story_v_side_new_1103401.awb") ~= 0 then
					local var_427_8 = manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401105", "story_v_side_new_1103401.awb") / 1000

					if var_427_8 + var_427_2 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_8 + var_427_2
					end

					if var_427_4.prefab_name ~= "" and arg_424_1.actors_[var_427_4.prefab_name] ~= nil then
						local var_427_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_424_1.actors_[var_427_4.prefab_name].transform, "story_v_side_new_1103401", "1103401105", "story_v_side_new_1103401.awb")

						arg_424_1:RecordAudio("1103401105", var_427_9)
						arg_424_1:RecordAudio("1103401105", var_427_9)
					else
						arg_424_1:AudioAction("play", "voice", "story_v_side_new_1103401", "1103401105", "story_v_side_new_1103401.awb")
					end

					arg_424_1:RecordHistoryTalkVoice("story_v_side_new_1103401", "1103401105", "story_v_side_new_1103401.awb")
				end

				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_10 = math.max(var_427_3, arg_424_1.talkMaxDuration)

			if var_427_2 <= arg_424_1.time_ and arg_424_1.time_ < var_427_2 + var_427_10 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - var_427_2) / var_427_10

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= var_427_2 + var_427_10 and arg_424_1.time_ < var_427_2 + var_427_10 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {}

		arg_424_1:InitPlayNodeList()
	end,
	Play1103401106 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 1103401106
		arg_428_1.duration_ = 5

		SetActive(arg_428_1.tipsGo_, false)

		function arg_428_1.onSingleLineFinish_()
			arg_428_1.onSingleLineUpdate_ = nil
			arg_428_1.onSingleLineFinish_ = nil
			arg_428_1.state_ = "waiting"
		end

		function arg_428_1.playNext_(arg_430_0)
			if arg_430_0 == 1 then
				arg_428_0:Play1103401107(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 and not isNil(arg_428_1.actors_["1034ui_story"]) and arg_428_1.var_.characterEffect1034ui_story == nil then
				arg_428_1.var_.characterEffect1034ui_story = arg_428_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_431_0 = 0.200000002980232

			if 0 <= arg_428_1.time_ and arg_428_1.time_ < 0 + var_431_0 and not isNil(arg_428_1.actors_["1034ui_story"]) then
				if arg_428_1.var_.characterEffect1034ui_story and not isNil(arg_428_1.actors_["1034ui_story"]) then
					arg_428_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_428_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_428_1.time_ - 0) / var_431_0)
				end
			end

			if arg_428_1.time_ >= 0 + var_431_0 and arg_428_1.time_ < 0 + var_431_0 + arg_431_0 and not isNil(arg_428_1.actors_["1034ui_story"]) and arg_428_1.var_.characterEffect1034ui_story then
				arg_428_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_428_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 then
				arg_428_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_deyiB", "EmotionTimelineAnimator")
			end

			local var_431_1 = 0
			local var_431_2 = 1.05

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= var_431_1 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0
				arg_428_1.dialogCg_.alpha = 1

				arg_428_1.dialog_:SetActive(true)
				SetActive(arg_428_1.leftNameGo_, false)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_428_1.iconTrs_.gameObject, false)
				arg_428_1.callingController_:SetSelectedState("normal")

				local var_431_3 = arg_428_1:FormatText(arg_428_1:GetWordFromCfg(1103401106).content)

				arg_428_1.text_.text = var_431_3

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_5 = 42 <= 0 and var_431_2 or var_431_2 * (utf8.len(var_431_3) / 42)

				if (42 <= 0 and var_431_2 or var_431_2 * (utf8.len(var_431_3) / 42)) > 0 and var_431_2 < var_431_5 then
					arg_428_1.talkMaxDuration = var_431_5

					if var_431_5 + var_431_1 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_5 + var_431_1
					end
				end

				arg_428_1.text_.text = var_431_3
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)
				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_6 = math.max(var_431_2, arg_428_1.talkMaxDuration)

			if var_431_1 <= arg_428_1.time_ and arg_428_1.time_ < var_431_1 + var_431_6 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - var_431_1) / var_431_6

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= var_431_1 + var_431_6 and arg_428_1.time_ < var_431_1 + var_431_6 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {}

		arg_428_1:InitPlayNodeList()
	end,
	Play1103401107 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 1103401107
		arg_432_1.duration_ = 6.8

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play1103401111(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 and not isNil(arg_432_1.actors_["1034ui_story"]) and arg_432_1.var_.characterEffect1034ui_story == nil then
				arg_432_1.var_.characterEffect1034ui_story = arg_432_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_435_0 = 0.200000002980232

			if 0 <= arg_432_1.time_ and arg_432_1.time_ < 0 + var_435_0 and not isNil(arg_432_1.actors_["1034ui_story"]) then
				if arg_432_1.var_.characterEffect1034ui_story and not isNil(arg_432_1.actors_["1034ui_story"]) then
					arg_432_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_432_1.time_ >= 0 + var_435_0 and arg_432_1.time_ < 0 + var_435_0 + arg_435_0 and not isNil(arg_432_1.actors_["1034ui_story"]) and arg_432_1.var_.characterEffect1034ui_story then
				arg_432_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 then
				arg_432_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034actionlink/1034action475")
			end

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 then
				arg_432_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_zhayanR", "EmotionTimelineAnimator")
			end

			local var_435_2 = 0
			local var_435_3 = 0.5

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= var_435_2 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0
				arg_432_1.dialogCg_.alpha = 1

				arg_432_1.dialog_:SetActive(true)
				SetActive(arg_432_1.leftNameGo_, true)

				arg_432_1.leftNameTxt_.text = arg_432_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_432_1.leftNameTxt_.transform)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1.leftNameTxt_.text)
				SetActive(arg_432_1.iconTrs_.gameObject, false)
				arg_432_1.callingController_:SetSelectedState("normal")

				local var_435_4 = arg_432_1:GetWordFromCfg(1103401107)
				local var_435_5 = arg_432_1:FormatText(var_435_4.content)

				arg_432_1.text_.text = var_435_5

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_7 = 20 <= 0 and var_435_3 or var_435_3 * (utf8.len(var_435_5) / 20)

				if (20 <= 0 and var_435_3 or var_435_3 * (utf8.len(var_435_5) / 20)) > 0 and var_435_3 < var_435_7 then
					arg_432_1.talkMaxDuration = var_435_7

					if var_435_7 + var_435_2 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_7 + var_435_2
					end
				end

				arg_432_1.text_.text = var_435_5
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401107", "story_v_side_new_1103401.awb") ~= 0 then
					local var_435_8 = manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401107", "story_v_side_new_1103401.awb") / 1000

					if var_435_8 + var_435_2 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_8 + var_435_2
					end

					if var_435_4.prefab_name ~= "" and arg_432_1.actors_[var_435_4.prefab_name] ~= nil then
						local var_435_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_432_1.actors_[var_435_4.prefab_name].transform, "story_v_side_new_1103401", "1103401107", "story_v_side_new_1103401.awb")

						arg_432_1:RecordAudio("1103401107", var_435_9)
						arg_432_1:RecordAudio("1103401107", var_435_9)
					else
						arg_432_1:AudioAction("play", "voice", "story_v_side_new_1103401", "1103401107", "story_v_side_new_1103401.awb")
					end

					arg_432_1:RecordHistoryTalkVoice("story_v_side_new_1103401", "1103401107", "story_v_side_new_1103401.awb")
				end

				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_10 = math.max(var_435_3, arg_432_1.talkMaxDuration)

			if var_435_2 <= arg_432_1.time_ and arg_432_1.time_ < var_435_2 + var_435_10 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - var_435_2) / var_435_10

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= var_435_2 + var_435_10 and arg_432_1.time_ < var_435_2 + var_435_10 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {}

		arg_432_1:InitPlayNodeList()
	end,
	Play1103401111 = function(arg_436_0, arg_436_1)
		arg_436_1.time_ = 0
		arg_436_1.frameCnt_ = 0
		arg_436_1.state_ = "playing"
		arg_436_1.curTalkId_ = 1103401111
		arg_436_1.duration_ = 5

		SetActive(arg_436_1.tipsGo_, false)

		function arg_436_1.onSingleLineFinish_()
			arg_436_1.onSingleLineUpdate_ = nil
			arg_436_1.onSingleLineFinish_ = nil
			arg_436_1.state_ = "waiting"
		end

		function arg_436_1.playNext_(arg_438_0)
			if arg_438_0 == 1 then
				arg_436_0:Play1103401112(arg_436_1)
			end
		end

		function arg_436_1.onSingleLineUpdate_(arg_439_0)
			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 and not isNil(arg_436_1.actors_["1034ui_story"]) and arg_436_1.var_.characterEffect1034ui_story == nil then
				arg_436_1.var_.characterEffect1034ui_story = arg_436_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_439_0 = 0.200000002980232

			if 0 <= arg_436_1.time_ and arg_436_1.time_ < 0 + var_439_0 and not isNil(arg_436_1.actors_["1034ui_story"]) then
				if arg_436_1.var_.characterEffect1034ui_story and not isNil(arg_436_1.actors_["1034ui_story"]) then
					arg_436_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_436_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_436_1.time_ - 0) / var_439_0)
				end
			end

			if arg_436_1.time_ >= 0 + var_439_0 and arg_436_1.time_ < 0 + var_439_0 + arg_439_0 and not isNil(arg_436_1.actors_["1034ui_story"]) and arg_436_1.var_.characterEffect1034ui_story then
				arg_436_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_436_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 then
				arg_436_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action5_2")
			end

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 then
				arg_436_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_439_1 = 0
			local var_439_2 = 1.4

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= var_439_1 + arg_439_0 then
				arg_436_1.talkMaxDuration = 0
				arg_436_1.dialogCg_.alpha = 1

				arg_436_1.dialog_:SetActive(true)
				SetActive(arg_436_1.leftNameGo_, false)

				arg_436_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_436_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_436_1:RecordName(arg_436_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_436_1.iconTrs_.gameObject, false)
				arg_436_1.callingController_:SetSelectedState("normal")

				local var_439_3 = arg_436_1:FormatText(arg_436_1:GetWordFromCfg(1103401111).content)

				arg_436_1.text_.text = var_439_3

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_5 = 56 <= 0 and var_439_2 or var_439_2 * (utf8.len(var_439_3) / 56)

				if (56 <= 0 and var_439_2 or var_439_2 * (utf8.len(var_439_3) / 56)) > 0 and var_439_2 < var_439_5 then
					arg_436_1.talkMaxDuration = var_439_5

					if var_439_5 + var_439_1 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_5 + var_439_1
					end
				end

				arg_436_1.text_.text = var_439_3
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)
				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_6 = math.max(var_439_2, arg_436_1.talkMaxDuration)

			if var_439_1 <= arg_436_1.time_ and arg_436_1.time_ < var_439_1 + var_439_6 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - var_439_1) / var_439_6

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= var_439_1 + var_439_6 and arg_436_1.time_ < var_439_1 + var_439_6 + arg_439_0 then
				arg_436_1.typewritter.percent = 1

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(true)
			end
		end

		arg_436_1.nodeConfigList_ = {}

		arg_436_1:InitPlayNodeList()
	end,
	Play1103401112 = function(arg_440_0, arg_440_1)
		arg_440_1.time_ = 0
		arg_440_1.frameCnt_ = 0
		arg_440_1.state_ = "playing"
		arg_440_1.curTalkId_ = 1103401112
		arg_440_1.duration_ = 5

		SetActive(arg_440_1.tipsGo_, false)

		function arg_440_1.onSingleLineFinish_()
			arg_440_1.onSingleLineUpdate_ = nil
			arg_440_1.onSingleLineFinish_ = nil
			arg_440_1.state_ = "waiting"
		end

		function arg_440_1.playNext_(arg_442_0)
			if arg_442_0 == 1 then
				arg_440_0:Play1103401113(arg_440_1)
			end
		end

		function arg_440_1.onSingleLineUpdate_(arg_443_0)
			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 then
				arg_440_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_443_0 = 0
			local var_443_1 = 1.1

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= var_443_0 + arg_443_0 then
				arg_440_1.talkMaxDuration = 0
				arg_440_1.dialogCg_.alpha = 1

				arg_440_1.dialog_:SetActive(true)
				SetActive(arg_440_1.leftNameGo_, true)

				arg_440_1.leftNameTxt_.text = arg_440_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_440_1.leftNameTxt_.transform)

				arg_440_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_440_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_440_1:RecordName(arg_440_1.leftNameTxt_.text)
				SetActive(arg_440_1.iconTrs_.gameObject, true)
				arg_440_1.iconController_:SetSelectedState("hero")

				arg_440_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_440_1.callingController_:SetSelectedState("normal")

				arg_440_1.keyicon_.color = Color.New(1, 1, 1)
				arg_440_1.icon_.color = Color.New(1, 1, 1)

				local var_443_2 = arg_440_1:FormatText(arg_440_1:GetWordFromCfg(1103401112).content)

				arg_440_1.text_.text = var_443_2

				LuaForUtil.ClearLinePrefixSymbol(arg_440_1.text_)

				local var_443_4 = 44 <= 0 and var_443_1 or var_443_1 * (utf8.len(var_443_2) / 44)

				if (44 <= 0 and var_443_1 or var_443_1 * (utf8.len(var_443_2) / 44)) > 0 and var_443_1 < var_443_4 then
					arg_440_1.talkMaxDuration = var_443_4

					if var_443_4 + var_443_0 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_4 + var_443_0
					end
				end

				arg_440_1.text_.text = var_443_2
				arg_440_1.typewritter.percent = 0

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(false)
				arg_440_1:RecordContent(arg_440_1.text_.text)
			end

			local var_443_5 = math.max(var_443_1, arg_440_1.talkMaxDuration)

			if var_443_0 <= arg_440_1.time_ and arg_440_1.time_ < var_443_0 + var_443_5 then
				arg_440_1.typewritter.percent = (arg_440_1.time_ - var_443_0) / var_443_5

				arg_440_1.typewritter:SetDirty()
			end

			if arg_440_1.time_ >= var_443_0 + var_443_5 and arg_440_1.time_ < var_443_0 + var_443_5 + arg_443_0 then
				arg_440_1.typewritter.percent = 1

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(true)
			end
		end

		arg_440_1.nodeConfigList_ = {}

		arg_440_1:InitPlayNodeList()
	end,
	Play1103401113 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 1103401113
		arg_444_1.duration_ = 5

		SetActive(arg_444_1.tipsGo_, false)

		function arg_444_1.onSingleLineFinish_()
			arg_444_1.onSingleLineUpdate_ = nil
			arg_444_1.onSingleLineFinish_ = nil
			arg_444_1.state_ = "waiting"
		end

		function arg_444_1.playNext_(arg_446_0)
			if arg_446_0 == 1 then
				arg_444_0:Play1103401114(arg_444_1)
			end
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			local var_447_0 = 0.4

			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 then
				arg_444_1.talkMaxDuration = 0
				arg_444_1.dialogCg_.alpha = 1

				arg_444_1.dialog_:SetActive(true)
				SetActive(arg_444_1.leftNameGo_, true)

				arg_444_1.leftNameTxt_.text = arg_444_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_444_1.leftNameTxt_.transform)

				arg_444_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_444_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_444_1:RecordName(arg_444_1.leftNameTxt_.text)
				SetActive(arg_444_1.iconTrs_.gameObject, true)
				arg_444_1.iconController_:SetSelectedState("hero")

				arg_444_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_444_1.callingController_:SetSelectedState("normal")

				arg_444_1.keyicon_.color = Color.New(1, 1, 1)
				arg_444_1.icon_.color = Color.New(1, 1, 1)

				local var_447_1 = arg_444_1:FormatText(arg_444_1:GetWordFromCfg(1103401113).content)

				arg_444_1.text_.text = var_447_1

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_3 = 16 <= 0 and var_447_0 or var_447_0 * (utf8.len(var_447_1) / 16)

				if (16 <= 0 and var_447_0 or var_447_0 * (utf8.len(var_447_1) / 16)) > 0 and var_447_0 < var_447_3 then
					arg_444_1.talkMaxDuration = var_447_3

					if var_447_3 + 0 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_3 + 0
					end
				end

				arg_444_1.text_.text = var_447_1
				arg_444_1.typewritter.percent = 0

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(false)
				arg_444_1:RecordContent(arg_444_1.text_.text)
			end

			local var_447_4 = math.max(var_447_0, arg_444_1.talkMaxDuration)

			if 0 <= arg_444_1.time_ and arg_444_1.time_ < 0 + var_447_4 then
				arg_444_1.typewritter.percent = (arg_444_1.time_ - 0) / var_447_4

				arg_444_1.typewritter:SetDirty()
			end

			if arg_444_1.time_ >= 0 + var_447_4 and arg_444_1.time_ < 0 + var_447_4 + arg_447_0 then
				arg_444_1.typewritter.percent = 1

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(true)
			end
		end

		arg_444_1.nodeConfigList_ = {}

		arg_444_1:InitPlayNodeList()
	end,
	Play1103401114 = function(arg_448_0, arg_448_1)
		arg_448_1.time_ = 0
		arg_448_1.frameCnt_ = 0
		arg_448_1.state_ = "playing"
		arg_448_1.curTalkId_ = 1103401114
		arg_448_1.duration_ = 4.4

		SetActive(arg_448_1.tipsGo_, false)

		function arg_448_1.onSingleLineFinish_()
			arg_448_1.onSingleLineUpdate_ = nil
			arg_448_1.onSingleLineFinish_ = nil
			arg_448_1.state_ = "waiting"
		end

		function arg_448_1.playNext_(arg_450_0)
			if arg_450_0 == 1 then
				arg_448_0:Play1103401115(arg_448_1)
			end
		end

		function arg_448_1.onSingleLineUpdate_(arg_451_0)
			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 and not isNil(arg_448_1.actors_["1034ui_story"]) and arg_448_1.var_.characterEffect1034ui_story == nil then
				arg_448_1.var_.characterEffect1034ui_story = arg_448_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_451_0 = 0.200000002980232

			if 0 <= arg_448_1.time_ and arg_448_1.time_ < 0 + var_451_0 and not isNil(arg_448_1.actors_["1034ui_story"]) then
				if arg_448_1.var_.characterEffect1034ui_story and not isNil(arg_448_1.actors_["1034ui_story"]) then
					arg_448_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_448_1.time_ >= 0 + var_451_0 and arg_448_1.time_ < 0 + var_451_0 + arg_451_0 and not isNil(arg_448_1.actors_["1034ui_story"]) and arg_448_1.var_.characterEffect1034ui_story then
				arg_448_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 then
				arg_448_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action7_1")
			end

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 then
				arg_448_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileF_biyan", "EmotionTimelineAnimator")
			end

			local var_451_2 = 0
			local var_451_3 = 0.55

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= var_451_2 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0
				arg_448_1.dialogCg_.alpha = 1

				arg_448_1.dialog_:SetActive(true)
				SetActive(arg_448_1.leftNameGo_, true)

				arg_448_1.leftNameTxt_.text = arg_448_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_448_1.leftNameTxt_.transform)

				arg_448_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_448_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_448_1:RecordName(arg_448_1.leftNameTxt_.text)
				SetActive(arg_448_1.iconTrs_.gameObject, false)
				arg_448_1.callingController_:SetSelectedState("normal")

				local var_451_4 = arg_448_1:GetWordFromCfg(1103401114)
				local var_451_5 = arg_448_1:FormatText(var_451_4.content)

				arg_448_1.text_.text = var_451_5

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.text_)

				local var_451_7 = 22 <= 0 and var_451_3 or var_451_3 * (utf8.len(var_451_5) / 22)

				if (22 <= 0 and var_451_3 or var_451_3 * (utf8.len(var_451_5) / 22)) > 0 and var_451_3 < var_451_7 then
					arg_448_1.talkMaxDuration = var_451_7

					if var_451_7 + var_451_2 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_7 + var_451_2
					end
				end

				arg_448_1.text_.text = var_451_5
				arg_448_1.typewritter.percent = 0

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401114", "story_v_side_new_1103401.awb") ~= 0 then
					local var_451_8 = manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401114", "story_v_side_new_1103401.awb") / 1000

					if var_451_8 + var_451_2 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_8 + var_451_2
					end

					if var_451_4.prefab_name ~= "" and arg_448_1.actors_[var_451_4.prefab_name] ~= nil then
						local var_451_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_448_1.actors_[var_451_4.prefab_name].transform, "story_v_side_new_1103401", "1103401114", "story_v_side_new_1103401.awb")

						arg_448_1:RecordAudio("1103401114", var_451_9)
						arg_448_1:RecordAudio("1103401114", var_451_9)
					else
						arg_448_1:AudioAction("play", "voice", "story_v_side_new_1103401", "1103401114", "story_v_side_new_1103401.awb")
					end

					arg_448_1:RecordHistoryTalkVoice("story_v_side_new_1103401", "1103401114", "story_v_side_new_1103401.awb")
				end

				arg_448_1:RecordContent(arg_448_1.text_.text)
			end

			local var_451_10 = math.max(var_451_3, arg_448_1.talkMaxDuration)

			if var_451_2 <= arg_448_1.time_ and arg_448_1.time_ < var_451_2 + var_451_10 then
				arg_448_1.typewritter.percent = (arg_448_1.time_ - var_451_2) / var_451_10

				arg_448_1.typewritter:SetDirty()
			end

			if arg_448_1.time_ >= var_451_2 + var_451_10 and arg_448_1.time_ < var_451_2 + var_451_10 + arg_451_0 then
				arg_448_1.typewritter.percent = 1

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(true)
			end
		end

		arg_448_1.nodeConfigList_ = {}

		arg_448_1:InitPlayNodeList()
	end,
	Play1103401115 = function(arg_452_0, arg_452_1)
		arg_452_1.time_ = 0
		arg_452_1.frameCnt_ = 0
		arg_452_1.state_ = "playing"
		arg_452_1.curTalkId_ = 1103401115
		arg_452_1.duration_ = 5

		SetActive(arg_452_1.tipsGo_, false)

		function arg_452_1.onSingleLineFinish_()
			arg_452_1.onSingleLineUpdate_ = nil
			arg_452_1.onSingleLineFinish_ = nil
			arg_452_1.state_ = "waiting"
		end

		function arg_452_1.playNext_(arg_454_0)
			if arg_454_0 == 1 then
				arg_452_0:Play1103401116(arg_452_1)
			end
		end

		function arg_452_1.onSingleLineUpdate_(arg_455_0)
			if 0 < arg_452_1.time_ and arg_452_1.time_ <= 0 + arg_455_0 and not isNil(arg_452_1.actors_["1034ui_story"]) and arg_452_1.var_.characterEffect1034ui_story == nil then
				arg_452_1.var_.characterEffect1034ui_story = arg_452_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_455_0 = 0.200000002980232

			if 0 <= arg_452_1.time_ and arg_452_1.time_ < 0 + var_455_0 and not isNil(arg_452_1.actors_["1034ui_story"]) then
				if arg_452_1.var_.characterEffect1034ui_story and not isNil(arg_452_1.actors_["1034ui_story"]) then
					arg_452_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_452_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_452_1.time_ - 0) / var_455_0)
				end
			end

			if arg_452_1.time_ >= 0 + var_455_0 and arg_452_1.time_ < 0 + var_455_0 + arg_455_0 and not isNil(arg_452_1.actors_["1034ui_story"]) and arg_452_1.var_.characterEffect1034ui_story then
				arg_452_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_452_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0 < arg_452_1.time_ and arg_452_1.time_ <= 0 + arg_455_0 then
				arg_452_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_455_1 = 0
			local var_455_2 = 0.325

			if 0 < arg_452_1.time_ and arg_452_1.time_ <= var_455_1 + arg_455_0 then
				arg_452_1.talkMaxDuration = 0
				arg_452_1.dialogCg_.alpha = 1

				arg_452_1.dialog_:SetActive(true)
				SetActive(arg_452_1.leftNameGo_, true)

				arg_452_1.leftNameTxt_.text = arg_452_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_452_1.leftNameTxt_.transform)

				arg_452_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_452_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_452_1:RecordName(arg_452_1.leftNameTxt_.text)
				SetActive(arg_452_1.iconTrs_.gameObject, true)
				arg_452_1.iconController_:SetSelectedState("hero")

				arg_452_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_452_1.callingController_:SetSelectedState("normal")

				arg_452_1.keyicon_.color = Color.New(1, 1, 1)
				arg_452_1.icon_.color = Color.New(1, 1, 1)

				local var_455_3 = arg_452_1:FormatText(arg_452_1:GetWordFromCfg(1103401115).content)

				arg_452_1.text_.text = var_455_3

				LuaForUtil.ClearLinePrefixSymbol(arg_452_1.text_)

				local var_455_5 = 13 <= 0 and var_455_2 or var_455_2 * (utf8.len(var_455_3) / 13)

				if (13 <= 0 and var_455_2 or var_455_2 * (utf8.len(var_455_3) / 13)) > 0 and var_455_2 < var_455_5 then
					arg_452_1.talkMaxDuration = var_455_5

					if var_455_5 + var_455_1 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_5 + var_455_1
					end
				end

				arg_452_1.text_.text = var_455_3
				arg_452_1.typewritter.percent = 0

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(false)
				arg_452_1:RecordContent(arg_452_1.text_.text)
			end

			local var_455_6 = math.max(var_455_2, arg_452_1.talkMaxDuration)

			if var_455_1 <= arg_452_1.time_ and arg_452_1.time_ < var_455_1 + var_455_6 then
				arg_452_1.typewritter.percent = (arg_452_1.time_ - var_455_1) / var_455_6

				arg_452_1.typewritter:SetDirty()
			end

			if arg_452_1.time_ >= var_455_1 + var_455_6 and arg_452_1.time_ < var_455_1 + var_455_6 + arg_455_0 then
				arg_452_1.typewritter.percent = 1

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(true)
			end
		end

		arg_452_1.nodeConfigList_ = {}

		arg_452_1:InitPlayNodeList()
	end,
	Play1103401116 = function(arg_456_0, arg_456_1)
		arg_456_1.time_ = 0
		arg_456_1.frameCnt_ = 0
		arg_456_1.state_ = "playing"
		arg_456_1.curTalkId_ = 1103401116
		arg_456_1.duration_ = 3.2

		SetActive(arg_456_1.tipsGo_, false)

		function arg_456_1.onSingleLineFinish_()
			arg_456_1.onSingleLineUpdate_ = nil
			arg_456_1.onSingleLineFinish_ = nil
			arg_456_1.state_ = "waiting"
		end

		function arg_456_1.playNext_(arg_458_0)
			if arg_458_0 == 1 then
				arg_456_0:Play1103401117(arg_456_1)
			end
		end

		function arg_456_1.onSingleLineUpdate_(arg_459_0)
			if 0 < arg_456_1.time_ and arg_456_1.time_ <= 0 + arg_459_0 and not isNil(arg_456_1.actors_["1034ui_story"]) and arg_456_1.var_.characterEffect1034ui_story == nil then
				arg_456_1.var_.characterEffect1034ui_story = arg_456_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_459_0 = 0.200000002980232

			if 0 <= arg_456_1.time_ and arg_456_1.time_ < 0 + var_459_0 and not isNil(arg_456_1.actors_["1034ui_story"]) then
				if arg_456_1.var_.characterEffect1034ui_story and not isNil(arg_456_1.actors_["1034ui_story"]) then
					arg_456_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_456_1.time_ >= 0 + var_459_0 and arg_456_1.time_ < 0 + var_459_0 + arg_459_0 and not isNil(arg_456_1.actors_["1034ui_story"]) and arg_456_1.var_.characterEffect1034ui_story then
				arg_456_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_456_1.time_ and arg_456_1.time_ <= 0 + arg_459_0 then
				arg_456_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034actionlink/1034action476")
			end

			if 0 < arg_456_1.time_ and arg_456_1.time_ <= 0 + arg_459_0 then
				arg_456_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_459_2 = 0
			local var_459_3 = 0.375

			if 0 < arg_456_1.time_ and arg_456_1.time_ <= var_459_2 + arg_459_0 then
				arg_456_1.talkMaxDuration = 0
				arg_456_1.dialogCg_.alpha = 1

				arg_456_1.dialog_:SetActive(true)
				SetActive(arg_456_1.leftNameGo_, true)

				arg_456_1.leftNameTxt_.text = arg_456_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_456_1.leftNameTxt_.transform)

				arg_456_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_456_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_456_1:RecordName(arg_456_1.leftNameTxt_.text)
				SetActive(arg_456_1.iconTrs_.gameObject, false)
				arg_456_1.callingController_:SetSelectedState("normal")

				local var_459_4 = arg_456_1:GetWordFromCfg(1103401116)
				local var_459_5 = arg_456_1:FormatText(var_459_4.content)

				arg_456_1.text_.text = var_459_5

				LuaForUtil.ClearLinePrefixSymbol(arg_456_1.text_)

				local var_459_7 = 15 <= 0 and var_459_3 or var_459_3 * (utf8.len(var_459_5) / 15)

				if (15 <= 0 and var_459_3 or var_459_3 * (utf8.len(var_459_5) / 15)) > 0 and var_459_3 < var_459_7 then
					arg_456_1.talkMaxDuration = var_459_7

					if var_459_7 + var_459_2 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_7 + var_459_2
					end
				end

				arg_456_1.text_.text = var_459_5
				arg_456_1.typewritter.percent = 0

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401116", "story_v_side_new_1103401.awb") ~= 0 then
					local var_459_8 = manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401116", "story_v_side_new_1103401.awb") / 1000

					if var_459_8 + var_459_2 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_8 + var_459_2
					end

					if var_459_4.prefab_name ~= "" and arg_456_1.actors_[var_459_4.prefab_name] ~= nil then
						local var_459_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_456_1.actors_[var_459_4.prefab_name].transform, "story_v_side_new_1103401", "1103401116", "story_v_side_new_1103401.awb")

						arg_456_1:RecordAudio("1103401116", var_459_9)
						arg_456_1:RecordAudio("1103401116", var_459_9)
					else
						arg_456_1:AudioAction("play", "voice", "story_v_side_new_1103401", "1103401116", "story_v_side_new_1103401.awb")
					end

					arg_456_1:RecordHistoryTalkVoice("story_v_side_new_1103401", "1103401116", "story_v_side_new_1103401.awb")
				end

				arg_456_1:RecordContent(arg_456_1.text_.text)
			end

			local var_459_10 = math.max(var_459_3, arg_456_1.talkMaxDuration)

			if var_459_2 <= arg_456_1.time_ and arg_456_1.time_ < var_459_2 + var_459_10 then
				arg_456_1.typewritter.percent = (arg_456_1.time_ - var_459_2) / var_459_10

				arg_456_1.typewritter:SetDirty()
			end

			if arg_456_1.time_ >= var_459_2 + var_459_10 and arg_456_1.time_ < var_459_2 + var_459_10 + arg_459_0 then
				arg_456_1.typewritter.percent = 1

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(true)
			end
		end

		arg_456_1.nodeConfigList_ = {}

		arg_456_1:InitPlayNodeList()
	end,
	Play1103401117 = function(arg_460_0, arg_460_1)
		arg_460_1.time_ = 0
		arg_460_1.frameCnt_ = 0
		arg_460_1.state_ = "playing"
		arg_460_1.curTalkId_ = 1103401117
		arg_460_1.duration_ = 4.53

		SetActive(arg_460_1.tipsGo_, false)

		function arg_460_1.onSingleLineFinish_()
			arg_460_1.onSingleLineUpdate_ = nil
			arg_460_1.onSingleLineFinish_ = nil
			arg_460_1.state_ = "waiting"
		end

		function arg_460_1.playNext_(arg_462_0)
			if arg_462_0 == 1 then
				arg_460_0:Play1103401118(arg_460_1)
			end
		end

		function arg_460_1.onSingleLineUpdate_(arg_463_0)
			if 0 < arg_460_1.time_ and arg_460_1.time_ <= 0 + arg_463_0 then
				arg_460_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034actionlink/1034action463")
			end

			if 0 < arg_460_1.time_ and arg_460_1.time_ <= 0 + arg_463_0 then
				arg_460_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_463_0 = arg_460_1.actors_["1034ui_story"]

			if 0 < arg_460_1.time_ and arg_460_1.time_ <= 0 + arg_463_0 and not isNil(var_463_0) and arg_460_1.var_.characterEffect1034ui_story == nil then
				arg_460_1.var_.characterEffect1034ui_story = var_463_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_463_1 = 0.200000002980232

			if 0 <= arg_460_1.time_ and arg_460_1.time_ < 0 + var_463_1 and not isNil(var_463_0) then
				if arg_460_1.var_.characterEffect1034ui_story and not isNil(var_463_0) then
					arg_460_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_460_1.time_ >= 0 + var_463_1 and arg_460_1.time_ < 0 + var_463_1 + arg_463_0 and not isNil(var_463_0) and arg_460_1.var_.characterEffect1034ui_story then
				arg_460_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_463_3 = 0
			local var_463_4 = 0.6

			if 0 < arg_460_1.time_ and arg_460_1.time_ <= var_463_3 + arg_463_0 then
				arg_460_1.talkMaxDuration = 0
				arg_460_1.dialogCg_.alpha = 1

				arg_460_1.dialog_:SetActive(true)
				SetActive(arg_460_1.leftNameGo_, true)

				arg_460_1.leftNameTxt_.text = arg_460_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_460_1.leftNameTxt_.transform)

				arg_460_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_460_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_460_1:RecordName(arg_460_1.leftNameTxt_.text)
				SetActive(arg_460_1.iconTrs_.gameObject, false)
				arg_460_1.callingController_:SetSelectedState("normal")

				local var_463_5 = arg_460_1:GetWordFromCfg(1103401117)
				local var_463_6 = arg_460_1:FormatText(var_463_5.content)

				arg_460_1.text_.text = var_463_6

				LuaForUtil.ClearLinePrefixSymbol(arg_460_1.text_)

				local var_463_8 = 24 <= 0 and var_463_4 or var_463_4 * (utf8.len(var_463_6) / 24)

				if (24 <= 0 and var_463_4 or var_463_4 * (utf8.len(var_463_6) / 24)) > 0 and var_463_4 < var_463_8 then
					arg_460_1.talkMaxDuration = var_463_8

					if var_463_8 + var_463_3 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_8 + var_463_3
					end
				end

				arg_460_1.text_.text = var_463_6
				arg_460_1.typewritter.percent = 0

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401117", "story_v_side_new_1103401.awb") ~= 0 then
					local var_463_9 = manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401117", "story_v_side_new_1103401.awb") / 1000

					if var_463_9 + var_463_3 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_9 + var_463_3
					end

					if var_463_5.prefab_name ~= "" and arg_460_1.actors_[var_463_5.prefab_name] ~= nil then
						local var_463_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_460_1.actors_[var_463_5.prefab_name].transform, "story_v_side_new_1103401", "1103401117", "story_v_side_new_1103401.awb")

						arg_460_1:RecordAudio("1103401117", var_463_10)
						arg_460_1:RecordAudio("1103401117", var_463_10)
					else
						arg_460_1:AudioAction("play", "voice", "story_v_side_new_1103401", "1103401117", "story_v_side_new_1103401.awb")
					end

					arg_460_1:RecordHistoryTalkVoice("story_v_side_new_1103401", "1103401117", "story_v_side_new_1103401.awb")
				end

				arg_460_1:RecordContent(arg_460_1.text_.text)
			end

			local var_463_11 = math.max(var_463_4, arg_460_1.talkMaxDuration)

			if var_463_3 <= arg_460_1.time_ and arg_460_1.time_ < var_463_3 + var_463_11 then
				arg_460_1.typewritter.percent = (arg_460_1.time_ - var_463_3) / var_463_11

				arg_460_1.typewritter:SetDirty()
			end

			if arg_460_1.time_ >= var_463_3 + var_463_11 and arg_460_1.time_ < var_463_3 + var_463_11 + arg_463_0 then
				arg_460_1.typewritter.percent = 1

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(true)
			end
		end

		arg_460_1.nodeConfigList_ = {}

		arg_460_1:InitPlayNodeList()
	end,
	Play1103401118 = function(arg_464_0, arg_464_1)
		arg_464_1.time_ = 0
		arg_464_1.frameCnt_ = 0
		arg_464_1.state_ = "playing"
		arg_464_1.curTalkId_ = 1103401118
		arg_464_1.duration_ = 5

		SetActive(arg_464_1.tipsGo_, false)

		function arg_464_1.onSingleLineFinish_()
			arg_464_1.onSingleLineUpdate_ = nil
			arg_464_1.onSingleLineFinish_ = nil
			arg_464_1.state_ = "waiting"
		end

		function arg_464_1.playNext_(arg_466_0)
			if arg_466_0 == 1 then
				arg_464_0:Play1103401119(arg_464_1)
			end
		end

		function arg_464_1.onSingleLineUpdate_(arg_467_0)
			if 0 < arg_464_1.time_ and arg_464_1.time_ <= 0 + arg_467_0 and not isNil(arg_464_1.actors_["1034ui_story"]) and arg_464_1.var_.characterEffect1034ui_story == nil then
				arg_464_1.var_.characterEffect1034ui_story = arg_464_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_467_0 = 0.200000002980232

			if 0 <= arg_464_1.time_ and arg_464_1.time_ < 0 + var_467_0 and not isNil(arg_464_1.actors_["1034ui_story"]) then
				if arg_464_1.var_.characterEffect1034ui_story and not isNil(arg_464_1.actors_["1034ui_story"]) then
					arg_464_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_464_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_464_1.time_ - 0) / var_467_0)
				end
			end

			if arg_464_1.time_ >= 0 + var_467_0 and arg_464_1.time_ < 0 + var_467_0 + arg_467_0 and not isNil(arg_464_1.actors_["1034ui_story"]) and arg_464_1.var_.characterEffect1034ui_story then
				arg_464_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_464_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_467_1 = 0
			local var_467_2 = 0.375

			if 0 < arg_464_1.time_ and arg_464_1.time_ <= var_467_1 + arg_467_0 then
				arg_464_1.talkMaxDuration = 0
				arg_464_1.dialogCg_.alpha = 1

				arg_464_1.dialog_:SetActive(true)
				SetActive(arg_464_1.leftNameGo_, true)

				arg_464_1.leftNameTxt_.text = arg_464_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_464_1.leftNameTxt_.transform)

				arg_464_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_464_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_464_1:RecordName(arg_464_1.leftNameTxt_.text)
				SetActive(arg_464_1.iconTrs_.gameObject, true)
				arg_464_1.iconController_:SetSelectedState("hero")

				arg_464_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_464_1.callingController_:SetSelectedState("normal")

				arg_464_1.keyicon_.color = Color.New(1, 1, 1)
				arg_464_1.icon_.color = Color.New(1, 1, 1)

				local var_467_3 = arg_464_1:FormatText(arg_464_1:GetWordFromCfg(1103401118).content)

				arg_464_1.text_.text = var_467_3

				LuaForUtil.ClearLinePrefixSymbol(arg_464_1.text_)

				local var_467_5 = 15 <= 0 and var_467_2 or var_467_2 * (utf8.len(var_467_3) / 15)

				if (15 <= 0 and var_467_2 or var_467_2 * (utf8.len(var_467_3) / 15)) > 0 and var_467_2 < var_467_5 then
					arg_464_1.talkMaxDuration = var_467_5

					if var_467_5 + var_467_1 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_5 + var_467_1
					end
				end

				arg_464_1.text_.text = var_467_3
				arg_464_1.typewritter.percent = 0

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(false)
				arg_464_1:RecordContent(arg_464_1.text_.text)
			end

			local var_467_6 = math.max(var_467_2, arg_464_1.talkMaxDuration)

			if var_467_1 <= arg_464_1.time_ and arg_464_1.time_ < var_467_1 + var_467_6 then
				arg_464_1.typewritter.percent = (arg_464_1.time_ - var_467_1) / var_467_6

				arg_464_1.typewritter:SetDirty()
			end

			if arg_464_1.time_ >= var_467_1 + var_467_6 and arg_464_1.time_ < var_467_1 + var_467_6 + arg_467_0 then
				arg_464_1.typewritter.percent = 1

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(true)
			end
		end

		arg_464_1.nodeConfigList_ = {}

		arg_464_1:InitPlayNodeList()
	end,
	Play1103401119 = function(arg_468_0, arg_468_1)
		arg_468_1.time_ = 0
		arg_468_1.frameCnt_ = 0
		arg_468_1.state_ = "playing"
		arg_468_1.curTalkId_ = 1103401119
		arg_468_1.duration_ = 4.43

		SetActive(arg_468_1.tipsGo_, false)

		function arg_468_1.onSingleLineFinish_()
			arg_468_1.onSingleLineUpdate_ = nil
			arg_468_1.onSingleLineFinish_ = nil
			arg_468_1.state_ = "waiting"
		end

		function arg_468_1.playNext_(arg_470_0)
			if arg_470_0 == 1 then
				arg_468_0:Play1103401120(arg_468_1)
			end
		end

		function arg_468_1.onSingleLineUpdate_(arg_471_0)
			if 0 < arg_468_1.time_ and arg_468_1.time_ <= 0 + arg_471_0 and not isNil(arg_468_1.actors_["1034ui_story"]) and arg_468_1.var_.characterEffect1034ui_story == nil then
				arg_468_1.var_.characterEffect1034ui_story = arg_468_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_471_0 = 0.200000002980232

			if 0 <= arg_468_1.time_ and arg_468_1.time_ < 0 + var_471_0 and not isNil(arg_468_1.actors_["1034ui_story"]) then
				if arg_468_1.var_.characterEffect1034ui_story and not isNil(arg_468_1.actors_["1034ui_story"]) then
					arg_468_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_468_1.time_ >= 0 + var_471_0 and arg_468_1.time_ < 0 + var_471_0 + arg_471_0 and not isNil(arg_468_1.actors_["1034ui_story"]) and arg_468_1.var_.characterEffect1034ui_story then
				arg_468_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_468_1.time_ and arg_468_1.time_ <= 0 + arg_471_0 then
				arg_468_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034actionlink/1034action432")
			end

			if 0 < arg_468_1.time_ and arg_468_1.time_ <= 0 + arg_471_0 then
				arg_468_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_gandong", "EmotionTimelineAnimator")
			end

			local var_471_2 = 0
			local var_471_3 = 0.575

			if 0 < arg_468_1.time_ and arg_468_1.time_ <= var_471_2 + arg_471_0 then
				arg_468_1.talkMaxDuration = 0
				arg_468_1.dialogCg_.alpha = 1

				arg_468_1.dialog_:SetActive(true)
				SetActive(arg_468_1.leftNameGo_, true)

				arg_468_1.leftNameTxt_.text = arg_468_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_468_1.leftNameTxt_.transform)

				arg_468_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_468_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_468_1:RecordName(arg_468_1.leftNameTxt_.text)
				SetActive(arg_468_1.iconTrs_.gameObject, false)
				arg_468_1.callingController_:SetSelectedState("normal")

				local var_471_4 = arg_468_1:GetWordFromCfg(1103401119)
				local var_471_5 = arg_468_1:FormatText(var_471_4.content)

				arg_468_1.text_.text = var_471_5

				LuaForUtil.ClearLinePrefixSymbol(arg_468_1.text_)

				local var_471_7 = 23 <= 0 and var_471_3 or var_471_3 * (utf8.len(var_471_5) / 23)

				if (23 <= 0 and var_471_3 or var_471_3 * (utf8.len(var_471_5) / 23)) > 0 and var_471_3 < var_471_7 then
					arg_468_1.talkMaxDuration = var_471_7

					if var_471_7 + var_471_2 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_7 + var_471_2
					end
				end

				arg_468_1.text_.text = var_471_5
				arg_468_1.typewritter.percent = 0

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401119", "story_v_side_new_1103401.awb") ~= 0 then
					local var_471_8 = manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401119", "story_v_side_new_1103401.awb") / 1000

					if var_471_8 + var_471_2 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_8 + var_471_2
					end

					if var_471_4.prefab_name ~= "" and arg_468_1.actors_[var_471_4.prefab_name] ~= nil then
						local var_471_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_468_1.actors_[var_471_4.prefab_name].transform, "story_v_side_new_1103401", "1103401119", "story_v_side_new_1103401.awb")

						arg_468_1:RecordAudio("1103401119", var_471_9)
						arg_468_1:RecordAudio("1103401119", var_471_9)
					else
						arg_468_1:AudioAction("play", "voice", "story_v_side_new_1103401", "1103401119", "story_v_side_new_1103401.awb")
					end

					arg_468_1:RecordHistoryTalkVoice("story_v_side_new_1103401", "1103401119", "story_v_side_new_1103401.awb")
				end

				arg_468_1:RecordContent(arg_468_1.text_.text)
			end

			local var_471_10 = math.max(var_471_3, arg_468_1.talkMaxDuration)

			if var_471_2 <= arg_468_1.time_ and arg_468_1.time_ < var_471_2 + var_471_10 then
				arg_468_1.typewritter.percent = (arg_468_1.time_ - var_471_2) / var_471_10

				arg_468_1.typewritter:SetDirty()
			end

			if arg_468_1.time_ >= var_471_2 + var_471_10 and arg_468_1.time_ < var_471_2 + var_471_10 + arg_471_0 then
				arg_468_1.typewritter.percent = 1

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(true)
			end
		end

		arg_468_1.nodeConfigList_ = {}

		arg_468_1:InitPlayNodeList()
	end,
	Play1103401120 = function(arg_472_0, arg_472_1)
		arg_472_1.time_ = 0
		arg_472_1.frameCnt_ = 0
		arg_472_1.state_ = "playing"
		arg_472_1.curTalkId_ = 1103401120
		arg_472_1.duration_ = 3.7

		SetActive(arg_472_1.tipsGo_, false)

		function arg_472_1.onSingleLineFinish_()
			arg_472_1.onSingleLineUpdate_ = nil
			arg_472_1.onSingleLineFinish_ = nil
			arg_472_1.state_ = "waiting"
		end

		function arg_472_1.playNext_(arg_474_0)
			if arg_474_0 == 1 then
				arg_472_0:Play1103401121(arg_472_1)
			end
		end

		function arg_472_1.onSingleLineUpdate_(arg_475_0)
			if 0 < arg_472_1.time_ and arg_472_1.time_ <= 0 + arg_475_0 then
				arg_472_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileF_biyan", "EmotionTimelineAnimator")
			end

			local var_475_0 = 0
			local var_475_1 = 0.475

			if 0 < arg_472_1.time_ and arg_472_1.time_ <= var_475_0 + arg_475_0 then
				arg_472_1.talkMaxDuration = 0
				arg_472_1.dialogCg_.alpha = 1

				arg_472_1.dialog_:SetActive(true)
				SetActive(arg_472_1.leftNameGo_, true)

				arg_472_1.leftNameTxt_.text = arg_472_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_472_1.leftNameTxt_.transform)

				arg_472_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_472_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_472_1:RecordName(arg_472_1.leftNameTxt_.text)
				SetActive(arg_472_1.iconTrs_.gameObject, false)
				arg_472_1.callingController_:SetSelectedState("normal")

				local var_475_2 = arg_472_1:GetWordFromCfg(1103401120)
				local var_475_3 = arg_472_1:FormatText(var_475_2.content)

				arg_472_1.text_.text = var_475_3

				LuaForUtil.ClearLinePrefixSymbol(arg_472_1.text_)

				local var_475_5 = 19 <= 0 and var_475_1 or var_475_1 * (utf8.len(var_475_3) / 19)

				if (19 <= 0 and var_475_1 or var_475_1 * (utf8.len(var_475_3) / 19)) > 0 and var_475_1 < var_475_5 then
					arg_472_1.talkMaxDuration = var_475_5

					if var_475_5 + var_475_0 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_5 + var_475_0
					end
				end

				arg_472_1.text_.text = var_475_3
				arg_472_1.typewritter.percent = 0

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401120", "story_v_side_new_1103401.awb") ~= 0 then
					local var_475_6 = manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401120", "story_v_side_new_1103401.awb") / 1000

					if var_475_6 + var_475_0 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_6 + var_475_0
					end

					if var_475_2.prefab_name ~= "" and arg_472_1.actors_[var_475_2.prefab_name] ~= nil then
						local var_475_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_472_1.actors_[var_475_2.prefab_name].transform, "story_v_side_new_1103401", "1103401120", "story_v_side_new_1103401.awb")

						arg_472_1:RecordAudio("1103401120", var_475_7)
						arg_472_1:RecordAudio("1103401120", var_475_7)
					else
						arg_472_1:AudioAction("play", "voice", "story_v_side_new_1103401", "1103401120", "story_v_side_new_1103401.awb")
					end

					arg_472_1:RecordHistoryTalkVoice("story_v_side_new_1103401", "1103401120", "story_v_side_new_1103401.awb")
				end

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
	Play1103401121 = function(arg_476_0, arg_476_1)
		arg_476_1.time_ = 0
		arg_476_1.frameCnt_ = 0
		arg_476_1.state_ = "playing"
		arg_476_1.curTalkId_ = 1103401121
		arg_476_1.duration_ = 5

		SetActive(arg_476_1.tipsGo_, false)

		function arg_476_1.onSingleLineFinish_()
			arg_476_1.onSingleLineUpdate_ = nil
			arg_476_1.onSingleLineFinish_ = nil
			arg_476_1.state_ = "waiting"
		end

		function arg_476_1.playNext_(arg_478_0)
			if arg_478_0 == 1 then
				arg_476_0:Play1103401122(arg_476_1)
			end
		end

		function arg_476_1.onSingleLineUpdate_(arg_479_0)
			if 0 < arg_476_1.time_ and arg_476_1.time_ <= 0 + arg_479_0 and not isNil(arg_476_1.actors_["1034ui_story"]) and arg_476_1.var_.characterEffect1034ui_story == nil then
				arg_476_1.var_.characterEffect1034ui_story = arg_476_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_479_0 = 0.200000002980232

			if 0 <= arg_476_1.time_ and arg_476_1.time_ < 0 + var_479_0 and not isNil(arg_476_1.actors_["1034ui_story"]) then
				if arg_476_1.var_.characterEffect1034ui_story and not isNil(arg_476_1.actors_["1034ui_story"]) then
					arg_476_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_476_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_476_1.time_ - 0) / var_479_0)
				end
			end

			if arg_476_1.time_ >= 0 + var_479_0 and arg_476_1.time_ < 0 + var_479_0 + arg_479_0 and not isNil(arg_476_1.actors_["1034ui_story"]) and arg_476_1.var_.characterEffect1034ui_story then
				arg_476_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_476_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0 < arg_476_1.time_ and arg_476_1.time_ <= 0 + arg_479_0 then
				arg_476_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_479_1 = 0
			local var_479_2 = 0.35

			if 0 < arg_476_1.time_ and arg_476_1.time_ <= var_479_1 + arg_479_0 then
				arg_476_1.talkMaxDuration = 0
				arg_476_1.dialogCg_.alpha = 1

				arg_476_1.dialog_:SetActive(true)
				SetActive(arg_476_1.leftNameGo_, true)

				arg_476_1.leftNameTxt_.text = arg_476_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_476_1.leftNameTxt_.transform)

				arg_476_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_476_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_476_1:RecordName(arg_476_1.leftNameTxt_.text)
				SetActive(arg_476_1.iconTrs_.gameObject, true)
				arg_476_1.iconController_:SetSelectedState("hero")

				arg_476_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_476_1.callingController_:SetSelectedState("normal")

				arg_476_1.keyicon_.color = Color.New(1, 1, 1)
				arg_476_1.icon_.color = Color.New(1, 1, 1)

				local var_479_3 = arg_476_1:FormatText(arg_476_1:GetWordFromCfg(1103401121).content)

				arg_476_1.text_.text = var_479_3

				LuaForUtil.ClearLinePrefixSymbol(arg_476_1.text_)

				local var_479_5 = 14 <= 0 and var_479_2 or var_479_2 * (utf8.len(var_479_3) / 14)

				if (14 <= 0 and var_479_2 or var_479_2 * (utf8.len(var_479_3) / 14)) > 0 and var_479_2 < var_479_5 then
					arg_476_1.talkMaxDuration = var_479_5

					if var_479_5 + var_479_1 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_5 + var_479_1
					end
				end

				arg_476_1.text_.text = var_479_3
				arg_476_1.typewritter.percent = 0

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(false)
				arg_476_1:RecordContent(arg_476_1.text_.text)
			end

			local var_479_6 = math.max(var_479_2, arg_476_1.talkMaxDuration)

			if var_479_1 <= arg_476_1.time_ and arg_476_1.time_ < var_479_1 + var_479_6 then
				arg_476_1.typewritter.percent = (arg_476_1.time_ - var_479_1) / var_479_6

				arg_476_1.typewritter:SetDirty()
			end

			if arg_476_1.time_ >= var_479_1 + var_479_6 and arg_476_1.time_ < var_479_1 + var_479_6 + arg_479_0 then
				arg_476_1.typewritter.percent = 1

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(true)
			end
		end

		arg_476_1.nodeConfigList_ = {}

		arg_476_1:InitPlayNodeList()
	end,
	Play1103401122 = function(arg_480_0, arg_480_1)
		arg_480_1.time_ = 0
		arg_480_1.frameCnt_ = 0
		arg_480_1.state_ = "playing"
		arg_480_1.curTalkId_ = 1103401122
		arg_480_1.duration_ = 8.5

		SetActive(arg_480_1.tipsGo_, false)

		function arg_480_1.onSingleLineFinish_()
			arg_480_1.onSingleLineUpdate_ = nil
			arg_480_1.onSingleLineFinish_ = nil
			arg_480_1.state_ = "waiting"
		end

		function arg_480_1.playNext_(arg_482_0)
			if arg_482_0 == 1 then
				arg_480_0:Play1103401123(arg_480_1)
			end
		end

		function arg_480_1.onSingleLineUpdate_(arg_483_0)
			if 0 < arg_480_1.time_ and arg_480_1.time_ <= 0 + arg_483_0 and not isNil(arg_480_1.actors_["1034ui_story"]) and arg_480_1.var_.characterEffect1034ui_story == nil then
				arg_480_1.var_.characterEffect1034ui_story = arg_480_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_483_0 = 0.200000002980232

			if 0 <= arg_480_1.time_ and arg_480_1.time_ < 0 + var_483_0 and not isNil(arg_480_1.actors_["1034ui_story"]) then
				if arg_480_1.var_.characterEffect1034ui_story and not isNil(arg_480_1.actors_["1034ui_story"]) then
					arg_480_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_480_1.time_ >= 0 + var_483_0 and arg_480_1.time_ < 0 + var_483_0 + arg_483_0 and not isNil(arg_480_1.actors_["1034ui_story"]) and arg_480_1.var_.characterEffect1034ui_story then
				arg_480_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_480_1.time_ and arg_480_1.time_ <= 0 + arg_483_0 then
				arg_480_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action2_2")
			end

			if 0 < arg_480_1.time_ and arg_480_1.time_ <= 0 + arg_483_0 then
				arg_480_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_483_2 = 0
			local var_483_3 = 1.05

			if 0 < arg_480_1.time_ and arg_480_1.time_ <= var_483_2 + arg_483_0 then
				arg_480_1.talkMaxDuration = 0
				arg_480_1.dialogCg_.alpha = 1

				arg_480_1.dialog_:SetActive(true)
				SetActive(arg_480_1.leftNameGo_, true)

				arg_480_1.leftNameTxt_.text = arg_480_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_480_1.leftNameTxt_.transform)

				arg_480_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_480_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_480_1:RecordName(arg_480_1.leftNameTxt_.text)
				SetActive(arg_480_1.iconTrs_.gameObject, false)
				arg_480_1.callingController_:SetSelectedState("normal")

				local var_483_4 = arg_480_1:GetWordFromCfg(1103401122)
				local var_483_5 = arg_480_1:FormatText(var_483_4.content)

				arg_480_1.text_.text = var_483_5

				LuaForUtil.ClearLinePrefixSymbol(arg_480_1.text_)

				local var_483_7 = 42 <= 0 and var_483_3 or var_483_3 * (utf8.len(var_483_5) / 42)

				if (42 <= 0 and var_483_3 or var_483_3 * (utf8.len(var_483_5) / 42)) > 0 and var_483_3 < var_483_7 then
					arg_480_1.talkMaxDuration = var_483_7

					if var_483_7 + var_483_2 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_7 + var_483_2
					end
				end

				arg_480_1.text_.text = var_483_5
				arg_480_1.typewritter.percent = 0

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401122", "story_v_side_new_1103401.awb") ~= 0 then
					local var_483_8 = manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401122", "story_v_side_new_1103401.awb") / 1000

					if var_483_8 + var_483_2 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_8 + var_483_2
					end

					if var_483_4.prefab_name ~= "" and arg_480_1.actors_[var_483_4.prefab_name] ~= nil then
						local var_483_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_480_1.actors_[var_483_4.prefab_name].transform, "story_v_side_new_1103401", "1103401122", "story_v_side_new_1103401.awb")

						arg_480_1:RecordAudio("1103401122", var_483_9)
						arg_480_1:RecordAudio("1103401122", var_483_9)
					else
						arg_480_1:AudioAction("play", "voice", "story_v_side_new_1103401", "1103401122", "story_v_side_new_1103401.awb")
					end

					arg_480_1:RecordHistoryTalkVoice("story_v_side_new_1103401", "1103401122", "story_v_side_new_1103401.awb")
				end

				arg_480_1:RecordContent(arg_480_1.text_.text)
			end

			local var_483_10 = math.max(var_483_3, arg_480_1.talkMaxDuration)

			if var_483_2 <= arg_480_1.time_ and arg_480_1.time_ < var_483_2 + var_483_10 then
				arg_480_1.typewritter.percent = (arg_480_1.time_ - var_483_2) / var_483_10

				arg_480_1.typewritter:SetDirty()
			end

			if arg_480_1.time_ >= var_483_2 + var_483_10 and arg_480_1.time_ < var_483_2 + var_483_10 + arg_483_0 then
				arg_480_1.typewritter.percent = 1

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(true)
			end
		end

		arg_480_1.nodeConfigList_ = {}

		arg_480_1:InitPlayNodeList()
	end,
	Play1103401123 = function(arg_484_0, arg_484_1)
		arg_484_1.time_ = 0
		arg_484_1.frameCnt_ = 0
		arg_484_1.state_ = "playing"
		arg_484_1.curTalkId_ = 1103401123
		arg_484_1.duration_ = 6.8

		SetActive(arg_484_1.tipsGo_, false)

		function arg_484_1.onSingleLineFinish_()
			arg_484_1.onSingleLineUpdate_ = nil
			arg_484_1.onSingleLineFinish_ = nil
			arg_484_1.state_ = "waiting"
		end

		function arg_484_1.playNext_(arg_486_0)
			if arg_486_0 == 1 then
				arg_484_0:Play1103401124(arg_484_1)
			end
		end

		function arg_484_1.onSingleLineUpdate_(arg_487_0)
			if 0 < arg_484_1.time_ and arg_484_1.time_ <= 0 + arg_487_0 then
				arg_484_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileF_biyan", "EmotionTimelineAnimator")
			end

			local var_487_0 = 0
			local var_487_1 = 0.625

			if 0 < arg_484_1.time_ and arg_484_1.time_ <= var_487_0 + arg_487_0 then
				arg_484_1.talkMaxDuration = 0
				arg_484_1.dialogCg_.alpha = 1

				arg_484_1.dialog_:SetActive(true)
				SetActive(arg_484_1.leftNameGo_, true)

				arg_484_1.leftNameTxt_.text = arg_484_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_484_1.leftNameTxt_.transform)

				arg_484_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_484_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_484_1:RecordName(arg_484_1.leftNameTxt_.text)
				SetActive(arg_484_1.iconTrs_.gameObject, false)
				arg_484_1.callingController_:SetSelectedState("normal")

				local var_487_2 = arg_484_1:GetWordFromCfg(1103401123)
				local var_487_3 = arg_484_1:FormatText(var_487_2.content)

				arg_484_1.text_.text = var_487_3

				LuaForUtil.ClearLinePrefixSymbol(arg_484_1.text_)

				local var_487_5 = 25 <= 0 and var_487_1 or var_487_1 * (utf8.len(var_487_3) / 25)

				if (25 <= 0 and var_487_1 or var_487_1 * (utf8.len(var_487_3) / 25)) > 0 and var_487_1 < var_487_5 then
					arg_484_1.talkMaxDuration = var_487_5

					if var_487_5 + var_487_0 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_5 + var_487_0
					end
				end

				arg_484_1.text_.text = var_487_3
				arg_484_1.typewritter.percent = 0

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401123", "story_v_side_new_1103401.awb") ~= 0 then
					local var_487_6 = manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401123", "story_v_side_new_1103401.awb") / 1000

					if var_487_6 + var_487_0 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_6 + var_487_0
					end

					if var_487_2.prefab_name ~= "" and arg_484_1.actors_[var_487_2.prefab_name] ~= nil then
						local var_487_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_484_1.actors_[var_487_2.prefab_name].transform, "story_v_side_new_1103401", "1103401123", "story_v_side_new_1103401.awb")

						arg_484_1:RecordAudio("1103401123", var_487_7)
						arg_484_1:RecordAudio("1103401123", var_487_7)
					else
						arg_484_1:AudioAction("play", "voice", "story_v_side_new_1103401", "1103401123", "story_v_side_new_1103401.awb")
					end

					arg_484_1:RecordHistoryTalkVoice("story_v_side_new_1103401", "1103401123", "story_v_side_new_1103401.awb")
				end

				arg_484_1:RecordContent(arg_484_1.text_.text)
			end

			local var_487_8 = math.max(var_487_1, arg_484_1.talkMaxDuration)

			if var_487_0 <= arg_484_1.time_ and arg_484_1.time_ < var_487_0 + var_487_8 then
				arg_484_1.typewritter.percent = (arg_484_1.time_ - var_487_0) / var_487_8

				arg_484_1.typewritter:SetDirty()
			end

			if arg_484_1.time_ >= var_487_0 + var_487_8 and arg_484_1.time_ < var_487_0 + var_487_8 + arg_487_0 then
				arg_484_1.typewritter.percent = 1

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(true)
			end
		end

		arg_484_1.nodeConfigList_ = {}

		arg_484_1:InitPlayNodeList()
	end,
	Play1103401124 = function(arg_488_0, arg_488_1)
		arg_488_1.time_ = 0
		arg_488_1.frameCnt_ = 0
		arg_488_1.state_ = "playing"
		arg_488_1.curTalkId_ = 1103401124
		arg_488_1.duration_ = 5

		SetActive(arg_488_1.tipsGo_, false)

		function arg_488_1.onSingleLineFinish_()
			arg_488_1.onSingleLineUpdate_ = nil
			arg_488_1.onSingleLineFinish_ = nil
			arg_488_1.state_ = "waiting"
		end

		function arg_488_1.playNext_(arg_490_0)
			if arg_490_0 == 1 then
				arg_488_0:Play1103401125(arg_488_1)
			end
		end

		function arg_488_1.onSingleLineUpdate_(arg_491_0)
			if 0 < arg_488_1.time_ and arg_488_1.time_ <= 0 + arg_491_0 and not isNil(arg_488_1.actors_["1034ui_story"]) and arg_488_1.var_.characterEffect1034ui_story == nil then
				arg_488_1.var_.characterEffect1034ui_story = arg_488_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_491_0 = 0.200000002980232

			if 0 <= arg_488_1.time_ and arg_488_1.time_ < 0 + var_491_0 and not isNil(arg_488_1.actors_["1034ui_story"]) then
				if arg_488_1.var_.characterEffect1034ui_story and not isNil(arg_488_1.actors_["1034ui_story"]) then
					arg_488_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_488_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_488_1.time_ - 0) / var_491_0)
				end
			end

			if arg_488_1.time_ >= 0 + var_491_0 and arg_488_1.time_ < 0 + var_491_0 + arg_491_0 and not isNil(arg_488_1.actors_["1034ui_story"]) and arg_488_1.var_.characterEffect1034ui_story then
				arg_488_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_488_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0 < arg_488_1.time_ and arg_488_1.time_ <= 0 + arg_491_0 then
				arg_488_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_491_1 = 0
			local var_491_2 = 0.325

			if 0 < arg_488_1.time_ and arg_488_1.time_ <= var_491_1 + arg_491_0 then
				arg_488_1.talkMaxDuration = 0
				arg_488_1.dialogCg_.alpha = 1

				arg_488_1.dialog_:SetActive(true)
				SetActive(arg_488_1.leftNameGo_, true)

				arg_488_1.leftNameTxt_.text = arg_488_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_488_1.leftNameTxt_.transform)

				arg_488_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_488_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_488_1:RecordName(arg_488_1.leftNameTxt_.text)
				SetActive(arg_488_1.iconTrs_.gameObject, true)
				arg_488_1.iconController_:SetSelectedState("hero")

				arg_488_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_488_1.callingController_:SetSelectedState("normal")

				arg_488_1.keyicon_.color = Color.New(1, 1, 1)
				arg_488_1.icon_.color = Color.New(1, 1, 1)

				local var_491_3 = arg_488_1:FormatText(arg_488_1:GetWordFromCfg(1103401124).content)

				arg_488_1.text_.text = var_491_3

				LuaForUtil.ClearLinePrefixSymbol(arg_488_1.text_)

				local var_491_5 = 13 <= 0 and var_491_2 or var_491_2 * (utf8.len(var_491_3) / 13)

				if (13 <= 0 and var_491_2 or var_491_2 * (utf8.len(var_491_3) / 13)) > 0 and var_491_2 < var_491_5 then
					arg_488_1.talkMaxDuration = var_491_5

					if var_491_5 + var_491_1 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_5 + var_491_1
					end
				end

				arg_488_1.text_.text = var_491_3
				arg_488_1.typewritter.percent = 0

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(false)
				arg_488_1:RecordContent(arg_488_1.text_.text)
			end

			local var_491_6 = math.max(var_491_2, arg_488_1.talkMaxDuration)

			if var_491_1 <= arg_488_1.time_ and arg_488_1.time_ < var_491_1 + var_491_6 then
				arg_488_1.typewritter.percent = (arg_488_1.time_ - var_491_1) / var_491_6

				arg_488_1.typewritter:SetDirty()
			end

			if arg_488_1.time_ >= var_491_1 + var_491_6 and arg_488_1.time_ < var_491_1 + var_491_6 + arg_491_0 then
				arg_488_1.typewritter.percent = 1

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(true)
			end
		end

		arg_488_1.nodeConfigList_ = {}

		arg_488_1:InitPlayNodeList()
	end,
	Play1103401125 = function(arg_492_0, arg_492_1)
		arg_492_1.time_ = 0
		arg_492_1.frameCnt_ = 0
		arg_492_1.state_ = "playing"
		arg_492_1.curTalkId_ = 1103401125
		arg_492_1.duration_ = 5

		SetActive(arg_492_1.tipsGo_, false)

		function arg_492_1.onSingleLineFinish_()
			arg_492_1.onSingleLineUpdate_ = nil
			arg_492_1.onSingleLineFinish_ = nil
			arg_492_1.state_ = "waiting"
		end

		function arg_492_1.playNext_(arg_494_0)
			if arg_494_0 == 1 then
				arg_492_0:Play1103401126(arg_492_1)
			end
		end

		function arg_492_1.onSingleLineUpdate_(arg_495_0)
			if 0 < arg_492_1.time_ and arg_492_1.time_ <= 0 + arg_495_0 then
				arg_492_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_495_0 = 0
			local var_495_1 = 0.15

			if 0 < arg_492_1.time_ and arg_492_1.time_ <= var_495_0 + arg_495_0 then
				arg_492_1.talkMaxDuration = 0
				arg_492_1.dialogCg_.alpha = 1

				arg_492_1.dialog_:SetActive(true)
				SetActive(arg_492_1.leftNameGo_, true)

				arg_492_1.leftNameTxt_.text = arg_492_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_492_1.leftNameTxt_.transform)

				arg_492_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_492_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_492_1:RecordName(arg_492_1.leftNameTxt_.text)
				SetActive(arg_492_1.iconTrs_.gameObject, true)
				arg_492_1.iconController_:SetSelectedState("hero")

				arg_492_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_492_1.callingController_:SetSelectedState("normal")

				arg_492_1.keyicon_.color = Color.New(1, 1, 1)
				arg_492_1.icon_.color = Color.New(1, 1, 1)

				local var_495_2 = arg_492_1:FormatText(arg_492_1:GetWordFromCfg(1103401125).content)

				arg_492_1.text_.text = var_495_2

				LuaForUtil.ClearLinePrefixSymbol(arg_492_1.text_)

				local var_495_4 = 6 <= 0 and var_495_1 or var_495_1 * (utf8.len(var_495_2) / 6)

				if (6 <= 0 and var_495_1 or var_495_1 * (utf8.len(var_495_2) / 6)) > 0 and var_495_1 < var_495_4 then
					arg_492_1.talkMaxDuration = var_495_4

					if var_495_4 + var_495_0 > arg_492_1.duration_ then
						arg_492_1.duration_ = var_495_4 + var_495_0
					end
				end

				arg_492_1.text_.text = var_495_2
				arg_492_1.typewritter.percent = 0

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(false)
				arg_492_1:RecordContent(arg_492_1.text_.text)
			end

			local var_495_5 = math.max(var_495_1, arg_492_1.talkMaxDuration)

			if var_495_0 <= arg_492_1.time_ and arg_492_1.time_ < var_495_0 + var_495_5 then
				arg_492_1.typewritter.percent = (arg_492_1.time_ - var_495_0) / var_495_5

				arg_492_1.typewritter:SetDirty()
			end

			if arg_492_1.time_ >= var_495_0 + var_495_5 and arg_492_1.time_ < var_495_0 + var_495_5 + arg_495_0 then
				arg_492_1.typewritter.percent = 1

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(true)
			end
		end

		arg_492_1.nodeConfigList_ = {}

		arg_492_1:InitPlayNodeList()
	end,
	Play1103401126 = function(arg_496_0, arg_496_1)
		arg_496_1.time_ = 0
		arg_496_1.frameCnt_ = 0
		arg_496_1.state_ = "playing"
		arg_496_1.curTalkId_ = 1103401126
		arg_496_1.duration_ = 5

		SetActive(arg_496_1.tipsGo_, false)

		function arg_496_1.onSingleLineFinish_()
			arg_496_1.onSingleLineUpdate_ = nil
			arg_496_1.onSingleLineFinish_ = nil
			arg_496_1.state_ = "waiting"
		end

		function arg_496_1.playNext_(arg_498_0)
			if arg_498_0 == 1 then
				arg_496_0:Play1103401127(arg_496_1)
			end
		end

		function arg_496_1.onSingleLineUpdate_(arg_499_0)
			if 0 < arg_496_1.time_ and arg_496_1.time_ <= 0 + arg_499_0 then
				arg_496_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_499_0 = 0
			local var_499_1 = 0.825

			if 0 < arg_496_1.time_ and arg_496_1.time_ <= var_499_0 + arg_499_0 then
				arg_496_1.talkMaxDuration = 0
				arg_496_1.dialogCg_.alpha = 1

				arg_496_1.dialog_:SetActive(true)
				SetActive(arg_496_1.leftNameGo_, true)

				arg_496_1.leftNameTxt_.text = arg_496_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_496_1.leftNameTxt_.transform)

				arg_496_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_496_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_496_1:RecordName(arg_496_1.leftNameTxt_.text)
				SetActive(arg_496_1.iconTrs_.gameObject, true)
				arg_496_1.iconController_:SetSelectedState("hero")

				arg_496_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_496_1.callingController_:SetSelectedState("normal")

				arg_496_1.keyicon_.color = Color.New(1, 1, 1)
				arg_496_1.icon_.color = Color.New(1, 1, 1)

				local var_499_2 = arg_496_1:FormatText(arg_496_1:GetWordFromCfg(1103401126).content)

				arg_496_1.text_.text = var_499_2

				LuaForUtil.ClearLinePrefixSymbol(arg_496_1.text_)

				local var_499_4 = 33 <= 0 and var_499_1 or var_499_1 * (utf8.len(var_499_2) / 33)

				if (33 <= 0 and var_499_1 or var_499_1 * (utf8.len(var_499_2) / 33)) > 0 and var_499_1 < var_499_4 then
					arg_496_1.talkMaxDuration = var_499_4

					if var_499_4 + var_499_0 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_4 + var_499_0
					end
				end

				arg_496_1.text_.text = var_499_2
				arg_496_1.typewritter.percent = 0

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(false)
				arg_496_1:RecordContent(arg_496_1.text_.text)
			end

			local var_499_5 = math.max(var_499_1, arg_496_1.talkMaxDuration)

			if var_499_0 <= arg_496_1.time_ and arg_496_1.time_ < var_499_0 + var_499_5 then
				arg_496_1.typewritter.percent = (arg_496_1.time_ - var_499_0) / var_499_5

				arg_496_1.typewritter:SetDirty()
			end

			if arg_496_1.time_ >= var_499_0 + var_499_5 and arg_496_1.time_ < var_499_0 + var_499_5 + arg_499_0 then
				arg_496_1.typewritter.percent = 1

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(true)
			end
		end

		arg_496_1.nodeConfigList_ = {}

		arg_496_1:InitPlayNodeList()
	end,
	Play1103401127 = function(arg_500_0, arg_500_1)
		arg_500_1.time_ = 0
		arg_500_1.frameCnt_ = 0
		arg_500_1.state_ = "playing"
		arg_500_1.curTalkId_ = 1103401127
		arg_500_1.duration_ = 3.2

		SetActive(arg_500_1.tipsGo_, false)

		function arg_500_1.onSingleLineFinish_()
			arg_500_1.onSingleLineUpdate_ = nil
			arg_500_1.onSingleLineFinish_ = nil
			arg_500_1.state_ = "waiting"
		end

		function arg_500_1.playNext_(arg_502_0)
			if arg_502_0 == 1 then
				arg_500_0:Play1103401128(arg_500_1)
			end
		end

		function arg_500_1.onSingleLineUpdate_(arg_503_0)
			if 0 < arg_500_1.time_ and arg_500_1.time_ <= 0 + arg_503_0 and not isNil(arg_500_1.actors_["1034ui_story"]) and arg_500_1.var_.characterEffect1034ui_story == nil then
				arg_500_1.var_.characterEffect1034ui_story = arg_500_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_503_0 = 0.200000002980232

			if 0 <= arg_500_1.time_ and arg_500_1.time_ < 0 + var_503_0 and not isNil(arg_500_1.actors_["1034ui_story"]) then
				if arg_500_1.var_.characterEffect1034ui_story and not isNil(arg_500_1.actors_["1034ui_story"]) then
					arg_500_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_500_1.time_ >= 0 + var_503_0 and arg_500_1.time_ < 0 + var_503_0 + arg_503_0 and not isNil(arg_500_1.actors_["1034ui_story"]) and arg_500_1.var_.characterEffect1034ui_story then
				arg_500_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_500_1.time_ and arg_500_1.time_ <= 0 + arg_503_0 then
				arg_500_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action6_1")
			end

			if 0 < arg_500_1.time_ and arg_500_1.time_ <= 0 + arg_503_0 then
				arg_500_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_503_2 = 0
			local var_503_3 = 0.55

			if 0 < arg_500_1.time_ and arg_500_1.time_ <= var_503_2 + arg_503_0 then
				arg_500_1.talkMaxDuration = 0
				arg_500_1.dialogCg_.alpha = 1

				arg_500_1.dialog_:SetActive(true)
				SetActive(arg_500_1.leftNameGo_, true)

				arg_500_1.leftNameTxt_.text = arg_500_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_500_1.leftNameTxt_.transform)

				arg_500_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_500_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_500_1:RecordName(arg_500_1.leftNameTxt_.text)
				SetActive(arg_500_1.iconTrs_.gameObject, false)
				arg_500_1.callingController_:SetSelectedState("normal")

				local var_503_4 = arg_500_1:GetWordFromCfg(1103401127)
				local var_503_5 = arg_500_1:FormatText(var_503_4.content)

				arg_500_1.text_.text = var_503_5

				LuaForUtil.ClearLinePrefixSymbol(arg_500_1.text_)

				local var_503_7 = 22 <= 0 and var_503_3 or var_503_3 * (utf8.len(var_503_5) / 22)

				if (22 <= 0 and var_503_3 or var_503_3 * (utf8.len(var_503_5) / 22)) > 0 and var_503_3 < var_503_7 then
					arg_500_1.talkMaxDuration = var_503_7

					if var_503_7 + var_503_2 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_7 + var_503_2
					end
				end

				arg_500_1.text_.text = var_503_5
				arg_500_1.typewritter.percent = 0

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401127", "story_v_side_new_1103401.awb") ~= 0 then
					local var_503_8 = manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401127", "story_v_side_new_1103401.awb") / 1000

					if var_503_8 + var_503_2 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_8 + var_503_2
					end

					if var_503_4.prefab_name ~= "" and arg_500_1.actors_[var_503_4.prefab_name] ~= nil then
						local var_503_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_500_1.actors_[var_503_4.prefab_name].transform, "story_v_side_new_1103401", "1103401127", "story_v_side_new_1103401.awb")

						arg_500_1:RecordAudio("1103401127", var_503_9)
						arg_500_1:RecordAudio("1103401127", var_503_9)
					else
						arg_500_1:AudioAction("play", "voice", "story_v_side_new_1103401", "1103401127", "story_v_side_new_1103401.awb")
					end

					arg_500_1:RecordHistoryTalkVoice("story_v_side_new_1103401", "1103401127", "story_v_side_new_1103401.awb")
				end

				arg_500_1:RecordContent(arg_500_1.text_.text)
			end

			local var_503_10 = math.max(var_503_3, arg_500_1.talkMaxDuration)

			if var_503_2 <= arg_500_1.time_ and arg_500_1.time_ < var_503_2 + var_503_10 then
				arg_500_1.typewritter.percent = (arg_500_1.time_ - var_503_2) / var_503_10

				arg_500_1.typewritter:SetDirty()
			end

			if arg_500_1.time_ >= var_503_2 + var_503_10 and arg_500_1.time_ < var_503_2 + var_503_10 + arg_503_0 then
				arg_500_1.typewritter.percent = 1

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(true)
			end
		end

		arg_500_1.nodeConfigList_ = {}

		arg_500_1:InitPlayNodeList()
	end,
	Play1103401128 = function(arg_504_0, arg_504_1)
		arg_504_1.time_ = 0
		arg_504_1.frameCnt_ = 0
		arg_504_1.state_ = "playing"
		arg_504_1.curTalkId_ = 1103401128
		arg_504_1.duration_ = 8.8

		SetActive(arg_504_1.tipsGo_, false)

		function arg_504_1.onSingleLineFinish_()
			arg_504_1.onSingleLineUpdate_ = nil
			arg_504_1.onSingleLineFinish_ = nil
			arg_504_1.state_ = "waiting"
		end

		function arg_504_1.playNext_(arg_506_0)
			if arg_506_0 == 1 then
				arg_504_0:Play1103401129(arg_504_1)
			end
		end

		function arg_504_1.onSingleLineUpdate_(arg_507_0)
			local var_507_0 = 1.1

			if 0 < arg_504_1.time_ and arg_504_1.time_ <= 0 + arg_507_0 then
				arg_504_1.talkMaxDuration = 0
				arg_504_1.dialogCg_.alpha = 1

				arg_504_1.dialog_:SetActive(true)
				SetActive(arg_504_1.leftNameGo_, true)

				arg_504_1.leftNameTxt_.text = arg_504_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_504_1.leftNameTxt_.transform)

				arg_504_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_504_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_504_1:RecordName(arg_504_1.leftNameTxt_.text)
				SetActive(arg_504_1.iconTrs_.gameObject, false)
				arg_504_1.callingController_:SetSelectedState("normal")

				local var_507_1 = arg_504_1:GetWordFromCfg(1103401128)
				local var_507_2 = arg_504_1:FormatText(var_507_1.content)

				arg_504_1.text_.text = var_507_2

				LuaForUtil.ClearLinePrefixSymbol(arg_504_1.text_)

				local var_507_4 = 44 <= 0 and var_507_0 or var_507_0 * (utf8.len(var_507_2) / 44)

				if (44 <= 0 and var_507_0 or var_507_0 * (utf8.len(var_507_2) / 44)) > 0 and var_507_0 < var_507_4 then
					arg_504_1.talkMaxDuration = var_507_4

					if var_507_4 + 0 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_4 + 0
					end
				end

				arg_504_1.text_.text = var_507_2
				arg_504_1.typewritter.percent = 0

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401128", "story_v_side_new_1103401.awb") ~= 0 then
					local var_507_5 = manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401128", "story_v_side_new_1103401.awb") / 1000

					if var_507_5 + 0 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_5 + 0
					end

					if var_507_1.prefab_name ~= "" and arg_504_1.actors_[var_507_1.prefab_name] ~= nil then
						local var_507_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_504_1.actors_[var_507_1.prefab_name].transform, "story_v_side_new_1103401", "1103401128", "story_v_side_new_1103401.awb")

						arg_504_1:RecordAudio("1103401128", var_507_6)
						arg_504_1:RecordAudio("1103401128", var_507_6)
					else
						arg_504_1:AudioAction("play", "voice", "story_v_side_new_1103401", "1103401128", "story_v_side_new_1103401.awb")
					end

					arg_504_1:RecordHistoryTalkVoice("story_v_side_new_1103401", "1103401128", "story_v_side_new_1103401.awb")
				end

				arg_504_1:RecordContent(arg_504_1.text_.text)
			end

			local var_507_7 = math.max(var_507_0, arg_504_1.talkMaxDuration)

			if 0 <= arg_504_1.time_ and arg_504_1.time_ < 0 + var_507_7 then
				arg_504_1.typewritter.percent = (arg_504_1.time_ - 0) / var_507_7

				arg_504_1.typewritter:SetDirty()
			end

			if arg_504_1.time_ >= 0 + var_507_7 and arg_504_1.time_ < 0 + var_507_7 + arg_507_0 then
				arg_504_1.typewritter.percent = 1

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(true)
			end
		end

		arg_504_1.nodeConfigList_ = {}

		arg_504_1:InitPlayNodeList()
	end,
	Play1103401129 = function(arg_508_0, arg_508_1)
		arg_508_1.time_ = 0
		arg_508_1.frameCnt_ = 0
		arg_508_1.state_ = "playing"
		arg_508_1.curTalkId_ = 1103401129
		arg_508_1.duration_ = 5

		SetActive(arg_508_1.tipsGo_, false)

		function arg_508_1.onSingleLineFinish_()
			arg_508_1.onSingleLineUpdate_ = nil
			arg_508_1.onSingleLineFinish_ = nil
			arg_508_1.state_ = "waiting"
		end

		function arg_508_1.playNext_(arg_510_0)
			if arg_510_0 == 1 then
				arg_508_0:Play1103401130(arg_508_1)
			end
		end

		function arg_508_1.onSingleLineUpdate_(arg_511_0)
			if 0 < arg_508_1.time_ and arg_508_1.time_ <= 0 + arg_511_0 and not isNil(arg_508_1.actors_["1034ui_story"]) and arg_508_1.var_.characterEffect1034ui_story == nil then
				arg_508_1.var_.characterEffect1034ui_story = arg_508_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_511_0 = 0.200000002980232

			if 0 <= arg_508_1.time_ and arg_508_1.time_ < 0 + var_511_0 and not isNil(arg_508_1.actors_["1034ui_story"]) then
				if arg_508_1.var_.characterEffect1034ui_story and not isNil(arg_508_1.actors_["1034ui_story"]) then
					arg_508_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_508_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_508_1.time_ - 0) / var_511_0)
				end
			end

			if arg_508_1.time_ >= 0 + var_511_0 and arg_508_1.time_ < 0 + var_511_0 + arg_511_0 and not isNil(arg_508_1.actors_["1034ui_story"]) and arg_508_1.var_.characterEffect1034ui_story then
				arg_508_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_508_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0 < arg_508_1.time_ and arg_508_1.time_ <= 0 + arg_511_0 then
				arg_508_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_511_1 = 0
			local var_511_2 = 0.075

			if 0 < arg_508_1.time_ and arg_508_1.time_ <= var_511_1 + arg_511_0 then
				arg_508_1.talkMaxDuration = 0
				arg_508_1.dialogCg_.alpha = 1

				arg_508_1.dialog_:SetActive(true)
				SetActive(arg_508_1.leftNameGo_, true)

				arg_508_1.leftNameTxt_.text = arg_508_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_508_1.leftNameTxt_.transform)

				arg_508_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_508_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_508_1:RecordName(arg_508_1.leftNameTxt_.text)
				SetActive(arg_508_1.iconTrs_.gameObject, true)
				arg_508_1.iconController_:SetSelectedState("hero")

				arg_508_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_508_1.callingController_:SetSelectedState("normal")

				arg_508_1.keyicon_.color = Color.New(1, 1, 1)
				arg_508_1.icon_.color = Color.New(1, 1, 1)

				local var_511_3 = arg_508_1:FormatText(arg_508_1:GetWordFromCfg(1103401129).content)

				arg_508_1.text_.text = var_511_3

				LuaForUtil.ClearLinePrefixSymbol(arg_508_1.text_)

				local var_511_5 = 3 <= 0 and var_511_2 or var_511_2 * (utf8.len(var_511_3) / 3)

				if (3 <= 0 and var_511_2 or var_511_2 * (utf8.len(var_511_3) / 3)) > 0 and var_511_2 < var_511_5 then
					arg_508_1.talkMaxDuration = var_511_5

					if var_511_5 + var_511_1 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_5 + var_511_1
					end
				end

				arg_508_1.text_.text = var_511_3
				arg_508_1.typewritter.percent = 0

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(false)
				arg_508_1:RecordContent(arg_508_1.text_.text)
			end

			local var_511_6 = math.max(var_511_2, arg_508_1.talkMaxDuration)

			if var_511_1 <= arg_508_1.time_ and arg_508_1.time_ < var_511_1 + var_511_6 then
				arg_508_1.typewritter.percent = (arg_508_1.time_ - var_511_1) / var_511_6

				arg_508_1.typewritter:SetDirty()
			end

			if arg_508_1.time_ >= var_511_1 + var_511_6 and arg_508_1.time_ < var_511_1 + var_511_6 + arg_511_0 then
				arg_508_1.typewritter.percent = 1

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(true)
			end
		end

		arg_508_1.nodeConfigList_ = {}

		arg_508_1:InitPlayNodeList()
	end,
	Play1103401130 = function(arg_512_0, arg_512_1)
		arg_512_1.time_ = 0
		arg_512_1.frameCnt_ = 0
		arg_512_1.state_ = "playing"
		arg_512_1.curTalkId_ = 1103401130
		arg_512_1.duration_ = 3.07

		SetActive(arg_512_1.tipsGo_, false)

		function arg_512_1.onSingleLineFinish_()
			arg_512_1.onSingleLineUpdate_ = nil
			arg_512_1.onSingleLineFinish_ = nil
			arg_512_1.state_ = "waiting"
		end

		function arg_512_1.playNext_(arg_514_0)
			if arg_514_0 == 1 then
				arg_512_0:Play1103401131(arg_512_1)
			end
		end

		function arg_512_1.onSingleLineUpdate_(arg_515_0)
			if 0 < arg_512_1.time_ and arg_512_1.time_ <= 0 + arg_515_0 and not isNil(arg_512_1.actors_["1034ui_story"]) and arg_512_1.var_.characterEffect1034ui_story == nil then
				arg_512_1.var_.characterEffect1034ui_story = arg_512_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_515_0 = 0.200000002980232

			if 0 <= arg_512_1.time_ and arg_512_1.time_ < 0 + var_515_0 and not isNil(arg_512_1.actors_["1034ui_story"]) then
				if arg_512_1.var_.characterEffect1034ui_story and not isNil(arg_512_1.actors_["1034ui_story"]) then
					arg_512_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_512_1.time_ >= 0 + var_515_0 and arg_512_1.time_ < 0 + var_515_0 + arg_515_0 and not isNil(arg_512_1.actors_["1034ui_story"]) and arg_512_1.var_.characterEffect1034ui_story then
				arg_512_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_512_1.time_ and arg_512_1.time_ <= 0 + arg_515_0 then
				arg_512_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034actionlink/1034action465")
			end

			if 0 < arg_512_1.time_ and arg_512_1.time_ <= 0 + arg_515_0 then
				arg_512_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_515_2 = 0
			local var_515_3 = 0.35

			if 0 < arg_512_1.time_ and arg_512_1.time_ <= var_515_2 + arg_515_0 then
				arg_512_1.talkMaxDuration = 0
				arg_512_1.dialogCg_.alpha = 1

				arg_512_1.dialog_:SetActive(true)
				SetActive(arg_512_1.leftNameGo_, true)

				arg_512_1.leftNameTxt_.text = arg_512_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_512_1.leftNameTxt_.transform)

				arg_512_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_512_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_512_1:RecordName(arg_512_1.leftNameTxt_.text)
				SetActive(arg_512_1.iconTrs_.gameObject, false)
				arg_512_1.callingController_:SetSelectedState("normal")

				local var_515_4 = arg_512_1:GetWordFromCfg(1103401130)
				local var_515_5 = arg_512_1:FormatText(var_515_4.content)

				arg_512_1.text_.text = var_515_5

				LuaForUtil.ClearLinePrefixSymbol(arg_512_1.text_)

				local var_515_7 = 14 <= 0 and var_515_3 or var_515_3 * (utf8.len(var_515_5) / 14)

				if (14 <= 0 and var_515_3 or var_515_3 * (utf8.len(var_515_5) / 14)) > 0 and var_515_3 < var_515_7 then
					arg_512_1.talkMaxDuration = var_515_7

					if var_515_7 + var_515_2 > arg_512_1.duration_ then
						arg_512_1.duration_ = var_515_7 + var_515_2
					end
				end

				arg_512_1.text_.text = var_515_5
				arg_512_1.typewritter.percent = 0

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401130", "story_v_side_new_1103401.awb") ~= 0 then
					local var_515_8 = manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401130", "story_v_side_new_1103401.awb") / 1000

					if var_515_8 + var_515_2 > arg_512_1.duration_ then
						arg_512_1.duration_ = var_515_8 + var_515_2
					end

					if var_515_4.prefab_name ~= "" and arg_512_1.actors_[var_515_4.prefab_name] ~= nil then
						local var_515_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_512_1.actors_[var_515_4.prefab_name].transform, "story_v_side_new_1103401", "1103401130", "story_v_side_new_1103401.awb")

						arg_512_1:RecordAudio("1103401130", var_515_9)
						arg_512_1:RecordAudio("1103401130", var_515_9)
					else
						arg_512_1:AudioAction("play", "voice", "story_v_side_new_1103401", "1103401130", "story_v_side_new_1103401.awb")
					end

					arg_512_1:RecordHistoryTalkVoice("story_v_side_new_1103401", "1103401130", "story_v_side_new_1103401.awb")
				end

				arg_512_1:RecordContent(arg_512_1.text_.text)
			end

			local var_515_10 = math.max(var_515_3, arg_512_1.talkMaxDuration)

			if var_515_2 <= arg_512_1.time_ and arg_512_1.time_ < var_515_2 + var_515_10 then
				arg_512_1.typewritter.percent = (arg_512_1.time_ - var_515_2) / var_515_10

				arg_512_1.typewritter:SetDirty()
			end

			if arg_512_1.time_ >= var_515_2 + var_515_10 and arg_512_1.time_ < var_515_2 + var_515_10 + arg_515_0 then
				arg_512_1.typewritter.percent = 1

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(true)
			end
		end

		arg_512_1.nodeConfigList_ = {}

		arg_512_1:InitPlayNodeList()
	end,
	Play1103401131 = function(arg_516_0, arg_516_1)
		arg_516_1.time_ = 0
		arg_516_1.frameCnt_ = 0
		arg_516_1.state_ = "playing"
		arg_516_1.curTalkId_ = 1103401131
		arg_516_1.duration_ = 7

		SetActive(arg_516_1.tipsGo_, false)

		function arg_516_1.onSingleLineFinish_()
			arg_516_1.onSingleLineUpdate_ = nil
			arg_516_1.onSingleLineFinish_ = nil
			arg_516_1.state_ = "waiting"
		end

		function arg_516_1.playNext_(arg_518_0)
			if arg_518_0 == 1 then
				arg_516_0:Play1103401132(arg_516_1)
			end
		end

		function arg_516_1.onSingleLineUpdate_(arg_519_0)
			if 0 < arg_516_1.time_ and arg_516_1.time_ <= 0 + arg_519_0 and not isNil(arg_516_1.actors_["1034ui_story"]) and arg_516_1.var_.characterEffect1034ui_story == nil then
				arg_516_1.var_.characterEffect1034ui_story = arg_516_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_519_0 = 0.200000002980232

			if 0 <= arg_516_1.time_ and arg_516_1.time_ < 0 + var_519_0 and not isNil(arg_516_1.actors_["1034ui_story"]) then
				if arg_516_1.var_.characterEffect1034ui_story and not isNil(arg_516_1.actors_["1034ui_story"]) then
					arg_516_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_516_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_516_1.time_ - 0) / var_519_0)
				end
			end

			if arg_516_1.time_ >= 0 + var_519_0 and arg_516_1.time_ < 0 + var_519_0 + arg_519_0 and not isNil(arg_516_1.actors_["1034ui_story"]) and arg_516_1.var_.characterEffect1034ui_story then
				arg_516_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_516_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0 < arg_516_1.time_ and arg_516_1.time_ <= 0 + arg_519_0 then
				arg_516_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_wuyuC", "EmotionTimelineAnimator")
			end

			local var_519_1 = 0
			local var_519_2 = 0.9

			if 0 < arg_516_1.time_ and arg_516_1.time_ <= var_519_1 + arg_519_0 then
				arg_516_1.talkMaxDuration = 0
				arg_516_1.dialogCg_.alpha = 1

				arg_516_1.dialog_:SetActive(true)
				SetActive(arg_516_1.leftNameGo_, false)

				arg_516_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_516_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_516_1:RecordName(arg_516_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_516_1.iconTrs_.gameObject, false)
				arg_516_1.callingController_:SetSelectedState("normal")

				local var_519_3 = arg_516_1:FormatText(arg_516_1:GetWordFromCfg(1103401131).content)

				arg_516_1.text_.text = var_519_3

				LuaForUtil.ClearLinePrefixSymbol(arg_516_1.text_)

				local var_519_5 = 36 <= 0 and var_519_2 or var_519_2 * (utf8.len(var_519_3) / 36)

				if (36 <= 0 and var_519_2 or var_519_2 * (utf8.len(var_519_3) / 36)) > 0 and var_519_2 < var_519_5 then
					arg_516_1.talkMaxDuration = var_519_5

					if var_519_5 + var_519_1 > arg_516_1.duration_ then
						arg_516_1.duration_ = var_519_5 + var_519_1
					end
				end

				arg_516_1.text_.text = var_519_3
				arg_516_1.typewritter.percent = 0

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(false)
				arg_516_1:RecordContent(arg_516_1.text_.text)
			end

			local var_519_6 = math.max(var_519_2, arg_516_1.talkMaxDuration)

			if var_519_1 <= arg_516_1.time_ and arg_516_1.time_ < var_519_1 + var_519_6 then
				arg_516_1.typewritter.percent = (arg_516_1.time_ - var_519_1) / var_519_6

				arg_516_1.typewritter:SetDirty()
			end

			if arg_516_1.time_ >= var_519_1 + var_519_6 and arg_516_1.time_ < var_519_1 + var_519_6 + arg_519_0 then
				arg_516_1.typewritter.percent = 1

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(true)
			end
		end

		arg_516_1.nodeConfigList_ = {}

		arg_516_1:InitPlayNodeList()
	end,
	Play1103401132 = function(arg_520_0, arg_520_1)
		arg_520_1.time_ = 0
		arg_520_1.frameCnt_ = 0
		arg_520_1.state_ = "playing"
		arg_520_1.curTalkId_ = 1103401132
		arg_520_1.duration_ = 4.9

		SetActive(arg_520_1.tipsGo_, false)

		function arg_520_1.onSingleLineFinish_()
			arg_520_1.onSingleLineUpdate_ = nil
			arg_520_1.onSingleLineFinish_ = nil
			arg_520_1.state_ = "waiting"
		end

		function arg_520_1.playNext_(arg_522_0)
			if arg_522_0 == 1 then
				arg_520_0:Play1103401133(arg_520_1)
			end
		end

		function arg_520_1.onSingleLineUpdate_(arg_523_0)
			if 0 < arg_520_1.time_ and arg_520_1.time_ <= 0 + arg_523_0 and not isNil(arg_520_1.actors_["1034ui_story"]) and arg_520_1.var_.characterEffect1034ui_story == nil then
				arg_520_1.var_.characterEffect1034ui_story = arg_520_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_523_0 = 0.200000002980232

			if 0 <= arg_520_1.time_ and arg_520_1.time_ < 0 + var_523_0 and not isNil(arg_520_1.actors_["1034ui_story"]) then
				if arg_520_1.var_.characterEffect1034ui_story and not isNil(arg_520_1.actors_["1034ui_story"]) then
					arg_520_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_520_1.time_ >= 0 + var_523_0 and arg_520_1.time_ < 0 + var_523_0 + arg_523_0 and not isNil(arg_520_1.actors_["1034ui_story"]) and arg_520_1.var_.characterEffect1034ui_story then
				arg_520_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_523_2 = 0
			local var_523_3 = 0.675

			if 0 < arg_520_1.time_ and arg_520_1.time_ <= var_523_2 + arg_523_0 then
				arg_520_1.talkMaxDuration = 0
				arg_520_1.dialogCg_.alpha = 1

				arg_520_1.dialog_:SetActive(true)
				SetActive(arg_520_1.leftNameGo_, true)

				arg_520_1.leftNameTxt_.text = arg_520_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_520_1.leftNameTxt_.transform)

				arg_520_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_520_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_520_1:RecordName(arg_520_1.leftNameTxt_.text)
				SetActive(arg_520_1.iconTrs_.gameObject, false)
				arg_520_1.callingController_:SetSelectedState("normal")

				local var_523_4 = arg_520_1:GetWordFromCfg(1103401132)
				local var_523_5 = arg_520_1:FormatText(var_523_4.content)

				arg_520_1.text_.text = var_523_5

				LuaForUtil.ClearLinePrefixSymbol(arg_520_1.text_)

				local var_523_7 = 27 <= 0 and var_523_3 or var_523_3 * (utf8.len(var_523_5) / 27)

				if (27 <= 0 and var_523_3 or var_523_3 * (utf8.len(var_523_5) / 27)) > 0 and var_523_3 < var_523_7 then
					arg_520_1.talkMaxDuration = var_523_7

					if var_523_7 + var_523_2 > arg_520_1.duration_ then
						arg_520_1.duration_ = var_523_7 + var_523_2
					end
				end

				arg_520_1.text_.text = var_523_5
				arg_520_1.typewritter.percent = 0

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401132", "story_v_side_new_1103401.awb") ~= 0 then
					local var_523_8 = manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401132", "story_v_side_new_1103401.awb") / 1000

					if var_523_8 + var_523_2 > arg_520_1.duration_ then
						arg_520_1.duration_ = var_523_8 + var_523_2
					end

					if var_523_4.prefab_name ~= "" and arg_520_1.actors_[var_523_4.prefab_name] ~= nil then
						local var_523_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_520_1.actors_[var_523_4.prefab_name].transform, "story_v_side_new_1103401", "1103401132", "story_v_side_new_1103401.awb")

						arg_520_1:RecordAudio("1103401132", var_523_9)
						arg_520_1:RecordAudio("1103401132", var_523_9)
					else
						arg_520_1:AudioAction("play", "voice", "story_v_side_new_1103401", "1103401132", "story_v_side_new_1103401.awb")
					end

					arg_520_1:RecordHistoryTalkVoice("story_v_side_new_1103401", "1103401132", "story_v_side_new_1103401.awb")
				end

				arg_520_1:RecordContent(arg_520_1.text_.text)
			end

			local var_523_10 = math.max(var_523_3, arg_520_1.talkMaxDuration)

			if var_523_2 <= arg_520_1.time_ and arg_520_1.time_ < var_523_2 + var_523_10 then
				arg_520_1.typewritter.percent = (arg_520_1.time_ - var_523_2) / var_523_10

				arg_520_1.typewritter:SetDirty()
			end

			if arg_520_1.time_ >= var_523_2 + var_523_10 and arg_520_1.time_ < var_523_2 + var_523_10 + arg_523_0 then
				arg_520_1.typewritter.percent = 1

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(true)
			end
		end

		arg_520_1.nodeConfigList_ = {}

		arg_520_1:InitPlayNodeList()
	end,
	Play1103401133 = function(arg_524_0, arg_524_1)
		arg_524_1.time_ = 0
		arg_524_1.frameCnt_ = 0
		arg_524_1.state_ = "playing"
		arg_524_1.curTalkId_ = 1103401133
		arg_524_1.duration_ = 2

		SetActive(arg_524_1.tipsGo_, false)

		function arg_524_1.onSingleLineFinish_()
			arg_524_1.onSingleLineUpdate_ = nil
			arg_524_1.onSingleLineFinish_ = nil
			arg_524_1.state_ = "waiting"
			arg_524_1.auto_ = false
		end

		function arg_524_1.playNext_(arg_526_0)
			arg_524_1.onStoryFinished_()
		end

		function arg_524_1.onSingleLineUpdate_(arg_527_0)
			if 0 < arg_524_1.time_ and arg_524_1.time_ <= 0 + arg_527_0 then
				arg_524_1.var_.moveOldPos1034ui_story = arg_524_1.actors_["1034ui_story"].transform.localPosition
			end

			local var_527_0 = 0.1

			if 0 <= arg_524_1.time_ and arg_524_1.time_ < 0 + var_527_0 then
				arg_524_1.actors_["1034ui_story"].transform.localPosition = Vector3.Lerp(arg_524_1.var_.moveOldPos1034ui_story, Vector3.New(0, -0.93, -6), (arg_524_1.time_ - 0) / var_527_0)
				arg_524_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_524_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_524_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_524_1.actors_["1034ui_story"].transform.position).z)
				arg_524_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_524_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_524_1.actors_["1034ui_story"].transform.localEulerAngles = arg_524_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			if arg_524_1.time_ >= 0 + var_527_0 and arg_524_1.time_ < 0 + var_527_0 + arg_527_0 then
				arg_524_1.actors_["1034ui_story"].transform.localPosition = Vector3.New(0, -0.93, -6)
				arg_524_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_524_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_524_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_524_1.actors_["1034ui_story"].transform.position).z)
				arg_524_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_524_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_524_1.actors_["1034ui_story"].transform.localEulerAngles = arg_524_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			if 0 < arg_524_1.time_ and arg_524_1.time_ <= 0 + arg_527_0 then
				arg_524_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034actionlink/1034action457")
			end

			if 0 < arg_524_1.time_ and arg_524_1.time_ <= 0 + arg_527_0 then
				arg_524_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_zhayanR", "EmotionTimelineAnimator")
			end

			local var_527_1 = arg_524_1.actors_["1034ui_story"]

			if 0 < arg_524_1.time_ and arg_524_1.time_ <= 0 + arg_527_0 and not isNil(var_527_1) and arg_524_1.var_.characterEffect1034ui_story == nil then
				arg_524_1.var_.characterEffect1034ui_story = var_527_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_527_2 = 0.200000002980232

			if 0 <= arg_524_1.time_ and arg_524_1.time_ < 0 + var_527_2 and not isNil(var_527_1) then
				if arg_524_1.var_.characterEffect1034ui_story and not isNil(var_527_1) then
					arg_524_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_524_1.time_ >= 0 + var_527_2 and arg_524_1.time_ < 0 + var_527_2 + arg_527_0 and not isNil(var_527_1) and arg_524_1.var_.characterEffect1034ui_story then
				arg_524_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_527_4 = 0
			local var_527_5 = 0.45

			if 0 < arg_524_1.time_ and arg_524_1.time_ <= var_527_4 + arg_527_0 then
				arg_524_1.talkMaxDuration = 0
				arg_524_1.dialogCg_.alpha = 1

				arg_524_1.dialog_:SetActive(true)
				SetActive(arg_524_1.leftNameGo_, true)

				arg_524_1.leftNameTxt_.text = arg_524_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_524_1.leftNameTxt_.transform)

				arg_524_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_524_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_524_1:RecordName(arg_524_1.leftNameTxt_.text)
				SetActive(arg_524_1.iconTrs_.gameObject, false)
				arg_524_1.callingController_:SetSelectedState("normal")

				local var_527_6 = arg_524_1:GetWordFromCfg(1103401133)
				local var_527_7 = arg_524_1:FormatText(var_527_6.content)

				arg_524_1.text_.text = var_527_7

				LuaForUtil.ClearLinePrefixSymbol(arg_524_1.text_)

				local var_527_9 = 16 <= 0 and var_527_5 or var_527_5 * (utf8.len(var_527_7) / 16)

				if (16 <= 0 and var_527_5 or var_527_5 * (utf8.len(var_527_7) / 16)) > 0 and var_527_5 < var_527_9 then
					arg_524_1.talkMaxDuration = var_527_9

					if var_527_9 + var_527_4 > arg_524_1.duration_ then
						arg_524_1.duration_ = var_527_9 + var_527_4
					end
				end

				arg_524_1.text_.text = var_527_7
				arg_524_1.typewritter.percent = 0

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401133", "story_v_side_new_1103401.awb") ~= 0 then
					local var_527_10 = manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401133", "story_v_side_new_1103401.awb") / 1000

					if var_527_10 + var_527_4 > arg_524_1.duration_ then
						arg_524_1.duration_ = var_527_10 + var_527_4
					end

					if var_527_6.prefab_name ~= "" and arg_524_1.actors_[var_527_6.prefab_name] ~= nil then
						local var_527_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_524_1.actors_[var_527_6.prefab_name].transform, "story_v_side_new_1103401", "1103401133", "story_v_side_new_1103401.awb")

						arg_524_1:RecordAudio("1103401133", var_527_11)
						arg_524_1:RecordAudio("1103401133", var_527_11)
					else
						arg_524_1:AudioAction("play", "voice", "story_v_side_new_1103401", "1103401133", "story_v_side_new_1103401.awb")
					end

					arg_524_1:RecordHistoryTalkVoice("story_v_side_new_1103401", "1103401133", "story_v_side_new_1103401.awb")
				end

				arg_524_1:RecordContent(arg_524_1.text_.text)
			end

			local var_527_12 = math.max(var_527_5, arg_524_1.talkMaxDuration)

			if var_527_4 <= arg_524_1.time_ and arg_524_1.time_ < var_527_4 + var_527_12 then
				arg_524_1.typewritter.percent = (arg_524_1.time_ - var_527_4) / var_527_12

				arg_524_1.typewritter:SetDirty()
			end

			if arg_524_1.time_ >= var_527_4 + var_527_12 and arg_524_1.time_ < var_527_4 + var_527_12 + arg_527_0 then
				arg_524_1.typewritter.percent = 1

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(true)
			end
		end

		arg_524_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_524_1:InitPlayNodeList()
	end,
	Play1103401108 = function(arg_528_0, arg_528_1)
		arg_528_1.time_ = 0
		arg_528_1.frameCnt_ = 0
		arg_528_1.state_ = "playing"
		arg_528_1.curTalkId_ = 1103401108
		arg_528_1.duration_ = 6.23

		SetActive(arg_528_1.tipsGo_, false)

		function arg_528_1.onSingleLineFinish_()
			arg_528_1.onSingleLineUpdate_ = nil
			arg_528_1.onSingleLineFinish_ = nil
			arg_528_1.state_ = "waiting"
		end

		function arg_528_1.playNext_(arg_530_0)
			if arg_530_0 == 1 then
				arg_528_0:Play1103401109(arg_528_1)
			end
		end

		function arg_528_1.onSingleLineUpdate_(arg_531_0)
			if arg_528_1.actors_["1034ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1034ui_story"))) then
				local var_531_0 = Object.Instantiate(Asset.Load("Char/" .. "1034ui_story"), arg_528_1.stage_.transform)

				var_531_0.name = "1034ui_story"
				var_531_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_528_1.actors_["1034ui_story"] = var_531_0

				local var_531_1 = var_531_0:GetComponentInChildren(typeof(CharacterEffect))

				var_531_1.enabled = true

				local var_531_2 = GameObjectTools.GetOrAddComponent(var_531_0, typeof(DynamicBoneHelper))

				if var_531_2 then
					var_531_2:EnableDynamicBone(false)
				end

				arg_528_1:ShowWeapon(var_531_1.transform, false)

				arg_528_1.var_["1034ui_story" .. "Animator"] = var_531_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_528_1.var_["1034ui_story" .. "Animator"].applyRootMotion = true
				arg_528_1.var_["1034ui_story" .. "LipSync"] = var_531_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_528_1.time_ and arg_528_1.time_ <= 0 + arg_531_0 then
				arg_528_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action7_1")
			end

			local var_531_3 = "1034ui_story"

			if arg_528_1.actors_["1034ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1034ui_story"))) then
				local var_531_4 = Object.Instantiate(Asset.Load("Char/" .. "1034ui_story"), arg_528_1.stage_.transform)

				var_531_4.name = var_531_3
				var_531_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_528_1.actors_[var_531_3] = var_531_4

				local var_531_5 = var_531_4:GetComponentInChildren(typeof(CharacterEffect))

				var_531_5.enabled = true

				local var_531_6 = GameObjectTools.GetOrAddComponent(var_531_4, typeof(DynamicBoneHelper))

				if var_531_6 then
					var_531_6:EnableDynamicBone(false)
				end

				arg_528_1:ShowWeapon(var_531_5.transform, false)

				arg_528_1.var_[var_531_3 .. "Animator"] = var_531_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_528_1.var_[var_531_3 .. "Animator"].applyRootMotion = true
				arg_528_1.var_[var_531_3 .. "LipSync"] = var_531_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_528_1.time_ and arg_528_1.time_ <= 0 + arg_531_0 then
				arg_528_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_531_7 = arg_528_1.actors_["1034ui_story"]

			if 0 < arg_528_1.time_ and arg_528_1.time_ <= 0 + arg_531_0 and not isNil(var_531_7) and arg_528_1.var_.characterEffect1034ui_story == nil then
				arg_528_1.var_.characterEffect1034ui_story = var_531_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_531_8 = 0.200000002980232

			if 0 <= arg_528_1.time_ and arg_528_1.time_ < 0 + var_531_8 and not isNil(var_531_7) then
				if arg_528_1.var_.characterEffect1034ui_story and not isNil(var_531_7) then
					arg_528_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_528_1.time_ >= 0 + var_531_8 and arg_528_1.time_ < 0 + var_531_8 + arg_531_0 and not isNil(var_531_7) and arg_528_1.var_.characterEffect1034ui_story then
				arg_528_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_531_10 = 0
			local var_531_11 = 0.825

			if 0 < arg_528_1.time_ and arg_528_1.time_ <= var_531_10 + arg_531_0 then
				arg_528_1.talkMaxDuration = 0
				arg_528_1.dialogCg_.alpha = 1

				arg_528_1.dialog_:SetActive(true)
				SetActive(arg_528_1.leftNameGo_, true)

				arg_528_1.leftNameTxt_.text = arg_528_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_528_1.leftNameTxt_.transform)

				arg_528_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_528_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_528_1:RecordName(arg_528_1.leftNameTxt_.text)
				SetActive(arg_528_1.iconTrs_.gameObject, false)
				arg_528_1.callingController_:SetSelectedState("normal")

				local var_531_12 = arg_528_1:GetWordFromCfg(1103401108)
				local var_531_13 = arg_528_1:FormatText(var_531_12.content)

				arg_528_1.text_.text = var_531_13

				LuaForUtil.ClearLinePrefixSymbol(arg_528_1.text_)

				local var_531_15 = 33 <= 0 and var_531_11 or var_531_11 * (utf8.len(var_531_13) / 33)

				if (33 <= 0 and var_531_11 or var_531_11 * (utf8.len(var_531_13) / 33)) > 0 and var_531_11 < var_531_15 then
					arg_528_1.talkMaxDuration = var_531_15

					if var_531_15 + var_531_10 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_15 + var_531_10
					end
				end

				arg_528_1.text_.text = var_531_13
				arg_528_1.typewritter.percent = 0

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401108", "story_v_side_new_1103401.awb") ~= 0 then
					local var_531_16 = manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401108", "story_v_side_new_1103401.awb") / 1000

					if var_531_16 + var_531_10 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_16 + var_531_10
					end

					if var_531_12.prefab_name ~= "" and arg_528_1.actors_[var_531_12.prefab_name] ~= nil then
						local var_531_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_528_1.actors_[var_531_12.prefab_name].transform, "story_v_side_new_1103401", "1103401108", "story_v_side_new_1103401.awb")

						arg_528_1:RecordAudio("1103401108", var_531_17)
						arg_528_1:RecordAudio("1103401108", var_531_17)
					else
						arg_528_1:AudioAction("play", "voice", "story_v_side_new_1103401", "1103401108", "story_v_side_new_1103401.awb")
					end

					arg_528_1:RecordHistoryTalkVoice("story_v_side_new_1103401", "1103401108", "story_v_side_new_1103401.awb")
				end

				arg_528_1:RecordContent(arg_528_1.text_.text)
			end

			local var_531_18 = math.max(var_531_11, arg_528_1.talkMaxDuration)

			if var_531_10 <= arg_528_1.time_ and arg_528_1.time_ < var_531_10 + var_531_18 then
				arg_528_1.typewritter.percent = (arg_528_1.time_ - var_531_10) / var_531_18

				arg_528_1.typewritter:SetDirty()
			end

			if arg_528_1.time_ >= var_531_10 + var_531_18 and arg_528_1.time_ < var_531_10 + var_531_18 + arg_531_0 then
				arg_528_1.typewritter.percent = 1

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(true)
			end
		end

		arg_528_1.nodeConfigList_ = {}

		arg_528_1:InitPlayNodeList()
	end,
	Play1103401109 = function(arg_532_0, arg_532_1)
		arg_532_1.time_ = 0
		arg_532_1.frameCnt_ = 0
		arg_532_1.state_ = "playing"
		arg_532_1.curTalkId_ = 1103401109
		arg_532_1.duration_ = 5

		SetActive(arg_532_1.tipsGo_, false)

		function arg_532_1.onSingleLineFinish_()
			arg_532_1.onSingleLineUpdate_ = nil
			arg_532_1.onSingleLineFinish_ = nil
			arg_532_1.state_ = "waiting"
		end

		function arg_532_1.playNext_(arg_534_0)
			if arg_534_0 == 1 then
				arg_532_0:Play1103401110(arg_532_1)
			end
		end

		function arg_532_1.onSingleLineUpdate_(arg_535_0)
			if 0 < arg_532_1.time_ and arg_532_1.time_ <= 0 + arg_535_0 and not isNil(arg_532_1.actors_["1034ui_story"]) and arg_532_1.var_.characterEffect1034ui_story == nil then
				arg_532_1.var_.characterEffect1034ui_story = arg_532_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_535_0 = 0.200000002980232

			if 0 <= arg_532_1.time_ and arg_532_1.time_ < 0 + var_535_0 and not isNil(arg_532_1.actors_["1034ui_story"]) then
				if arg_532_1.var_.characterEffect1034ui_story and not isNil(arg_532_1.actors_["1034ui_story"]) then
					arg_532_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_532_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_532_1.time_ - 0) / var_535_0)
				end
			end

			if arg_532_1.time_ >= 0 + var_535_0 and arg_532_1.time_ < 0 + var_535_0 + arg_535_0 and not isNil(arg_532_1.actors_["1034ui_story"]) and arg_532_1.var_.characterEffect1034ui_story then
				arg_532_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_532_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_535_1 = 0
			local var_535_2 = 1.175

			if 0 < arg_532_1.time_ and arg_532_1.time_ <= var_535_1 + arg_535_0 then
				arg_532_1.talkMaxDuration = 0
				arg_532_1.dialogCg_.alpha = 1

				arg_532_1.dialog_:SetActive(true)
				SetActive(arg_532_1.leftNameGo_, false)

				arg_532_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_532_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_532_1:RecordName(arg_532_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_532_1.iconTrs_.gameObject, false)
				arg_532_1.callingController_:SetSelectedState("normal")

				local var_535_3 = arg_532_1:FormatText(arg_532_1:GetWordFromCfg(1103401109).content)

				arg_532_1.text_.text = var_535_3

				LuaForUtil.ClearLinePrefixSymbol(arg_532_1.text_)

				local var_535_5 = 47 <= 0 and var_535_2 or var_535_2 * (utf8.len(var_535_3) / 47)

				if (47 <= 0 and var_535_2 or var_535_2 * (utf8.len(var_535_3) / 47)) > 0 and var_535_2 < var_535_5 then
					arg_532_1.talkMaxDuration = var_535_5

					if var_535_5 + var_535_1 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_5 + var_535_1
					end
				end

				arg_532_1.text_.text = var_535_3
				arg_532_1.typewritter.percent = 0

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(false)
				arg_532_1:RecordContent(arg_532_1.text_.text)
			end

			local var_535_6 = math.max(var_535_2, arg_532_1.talkMaxDuration)

			if var_535_1 <= arg_532_1.time_ and arg_532_1.time_ < var_535_1 + var_535_6 then
				arg_532_1.typewritter.percent = (arg_532_1.time_ - var_535_1) / var_535_6

				arg_532_1.typewritter:SetDirty()
			end

			if arg_532_1.time_ >= var_535_1 + var_535_6 and arg_532_1.time_ < var_535_1 + var_535_6 + arg_535_0 then
				arg_532_1.typewritter.percent = 1

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(true)
			end
		end

		arg_532_1.nodeConfigList_ = {}

		arg_532_1:InitPlayNodeList()
	end,
	Play1103401110 = function(arg_536_0, arg_536_1)
		arg_536_1.time_ = 0
		arg_536_1.frameCnt_ = 0
		arg_536_1.state_ = "playing"
		arg_536_1.curTalkId_ = 1103401110
		arg_536_1.duration_ = 3.5

		SetActive(arg_536_1.tipsGo_, false)

		function arg_536_1.onSingleLineFinish_()
			arg_536_1.onSingleLineUpdate_ = nil
			arg_536_1.onSingleLineFinish_ = nil
			arg_536_1.state_ = "waiting"
		end

		function arg_536_1.playNext_(arg_538_0)
			if arg_538_0 == 1 then
				arg_536_0:Play1103401111(arg_536_1)
			end
		end

		function arg_536_1.onSingleLineUpdate_(arg_539_0)
			if 0 < arg_536_1.time_ and arg_536_1.time_ <= 0 + arg_539_0 and not isNil(arg_536_1.actors_["1034ui_story"]) and arg_536_1.var_.characterEffect1034ui_story == nil then
				arg_536_1.var_.characterEffect1034ui_story = arg_536_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_539_0 = 0.200000002980232

			if 0 <= arg_536_1.time_ and arg_536_1.time_ < 0 + var_539_0 and not isNil(arg_536_1.actors_["1034ui_story"]) then
				if arg_536_1.var_.characterEffect1034ui_story and not isNil(arg_536_1.actors_["1034ui_story"]) then
					arg_536_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_536_1.time_ >= 0 + var_539_0 and arg_536_1.time_ < 0 + var_539_0 + arg_539_0 and not isNil(arg_536_1.actors_["1034ui_story"]) and arg_536_1.var_.characterEffect1034ui_story then
				arg_536_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_536_1.time_ and arg_536_1.time_ <= 0 + arg_539_0 then
				arg_536_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034actionlink/1034action475")
			end

			if 0 < arg_536_1.time_ and arg_536_1.time_ <= 0 + arg_539_0 then
				arg_536_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_zhayanR", "EmotionTimelineAnimator")
			end

			local var_539_2 = 0
			local var_539_3 = 0.45

			if 0 < arg_536_1.time_ and arg_536_1.time_ <= var_539_2 + arg_539_0 then
				arg_536_1.talkMaxDuration = 0
				arg_536_1.dialogCg_.alpha = 1

				arg_536_1.dialog_:SetActive(true)
				SetActive(arg_536_1.leftNameGo_, true)

				arg_536_1.leftNameTxt_.text = arg_536_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_536_1.leftNameTxt_.transform)

				arg_536_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_536_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_536_1:RecordName(arg_536_1.leftNameTxt_.text)
				SetActive(arg_536_1.iconTrs_.gameObject, false)
				arg_536_1.callingController_:SetSelectedState("normal")

				local var_539_4 = arg_536_1:GetWordFromCfg(1103401110)
				local var_539_5 = arg_536_1:FormatText(var_539_4.content)

				arg_536_1.text_.text = var_539_5

				LuaForUtil.ClearLinePrefixSymbol(arg_536_1.text_)

				local var_539_7 = 18 <= 0 and var_539_3 or var_539_3 * (utf8.len(var_539_5) / 18)

				if (18 <= 0 and var_539_3 or var_539_3 * (utf8.len(var_539_5) / 18)) > 0 and var_539_3 < var_539_7 then
					arg_536_1.talkMaxDuration = var_539_7

					if var_539_7 + var_539_2 > arg_536_1.duration_ then
						arg_536_1.duration_ = var_539_7 + var_539_2
					end
				end

				arg_536_1.text_.text = var_539_5
				arg_536_1.typewritter.percent = 0

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401110", "story_v_side_new_1103401.awb") ~= 0 then
					local var_539_8 = manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401110", "story_v_side_new_1103401.awb") / 1000

					if var_539_8 + var_539_2 > arg_536_1.duration_ then
						arg_536_1.duration_ = var_539_8 + var_539_2
					end

					if var_539_4.prefab_name ~= "" and arg_536_1.actors_[var_539_4.prefab_name] ~= nil then
						local var_539_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_536_1.actors_[var_539_4.prefab_name].transform, "story_v_side_new_1103401", "1103401110", "story_v_side_new_1103401.awb")

						arg_536_1:RecordAudio("1103401110", var_539_9)
						arg_536_1:RecordAudio("1103401110", var_539_9)
					else
						arg_536_1:AudioAction("play", "voice", "story_v_side_new_1103401", "1103401110", "story_v_side_new_1103401.awb")
					end

					arg_536_1:RecordHistoryTalkVoice("story_v_side_new_1103401", "1103401110", "story_v_side_new_1103401.awb")
				end

				arg_536_1:RecordContent(arg_536_1.text_.text)
			end

			local var_539_10 = math.max(var_539_3, arg_536_1.talkMaxDuration)

			if var_539_2 <= arg_536_1.time_ and arg_536_1.time_ < var_539_2 + var_539_10 then
				arg_536_1.typewritter.percent = (arg_536_1.time_ - var_539_2) / var_539_10

				arg_536_1.typewritter:SetDirty()
			end

			if arg_536_1.time_ >= var_539_2 + var_539_10 and arg_536_1.time_ < var_539_2 + var_539_10 + arg_539_0 then
				arg_536_1.typewritter.percent = 1

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(true)
			end
		end

		arg_536_1.nodeConfigList_ = {}

		arg_536_1:InitPlayNodeList()
	end,
	Play1103401066 = function(arg_540_0, arg_540_1)
		arg_540_1.time_ = 0
		arg_540_1.frameCnt_ = 0
		arg_540_1.state_ = "playing"
		arg_540_1.curTalkId_ = 1103401066
		arg_540_1.duration_ = 4.07

		SetActive(arg_540_1.tipsGo_, false)

		function arg_540_1.onSingleLineFinish_()
			arg_540_1.onSingleLineUpdate_ = nil
			arg_540_1.onSingleLineFinish_ = nil
			arg_540_1.state_ = "waiting"
		end

		function arg_540_1.playNext_(arg_542_0)
			if arg_542_0 == 1 then
				arg_540_0:Play1103401067(arg_540_1)
			end
		end

		function arg_540_1.onSingleLineUpdate_(arg_543_0)
			if arg_540_1.actors_["1034ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1034ui_story"))) then
				local var_543_0 = Object.Instantiate(Asset.Load("Char/" .. "1034ui_story"), arg_540_1.stage_.transform)

				var_543_0.name = "1034ui_story"
				var_543_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_540_1.actors_["1034ui_story"] = var_543_0

				local var_543_1 = var_543_0:GetComponentInChildren(typeof(CharacterEffect))

				var_543_1.enabled = true

				local var_543_2 = GameObjectTools.GetOrAddComponent(var_543_0, typeof(DynamicBoneHelper))

				if var_543_2 then
					var_543_2:EnableDynamicBone(false)
				end

				arg_540_1:ShowWeapon(var_543_1.transform, false)

				arg_540_1.var_["1034ui_story" .. "Animator"] = var_543_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_540_1.var_["1034ui_story" .. "Animator"].applyRootMotion = true
				arg_540_1.var_["1034ui_story" .. "LipSync"] = var_543_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_540_1.time_ and arg_540_1.time_ <= 0 + arg_543_0 then
				arg_540_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034actionlink/1034action465")
			end

			local var_543_3 = "1034ui_story"

			if arg_540_1.actors_["1034ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1034ui_story"))) then
				local var_543_4 = Object.Instantiate(Asset.Load("Char/" .. "1034ui_story"), arg_540_1.stage_.transform)

				var_543_4.name = var_543_3
				var_543_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_540_1.actors_[var_543_3] = var_543_4

				local var_543_5 = var_543_4:GetComponentInChildren(typeof(CharacterEffect))

				var_543_5.enabled = true

				local var_543_6 = GameObjectTools.GetOrAddComponent(var_543_4, typeof(DynamicBoneHelper))

				if var_543_6 then
					var_543_6:EnableDynamicBone(false)
				end

				arg_540_1:ShowWeapon(var_543_5.transform, false)

				arg_540_1.var_[var_543_3 .. "Animator"] = var_543_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_540_1.var_[var_543_3 .. "Animator"].applyRootMotion = true
				arg_540_1.var_[var_543_3 .. "LipSync"] = var_543_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_540_1.time_ and arg_540_1.time_ <= 0 + arg_543_0 then
				arg_540_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileF_biyan", "EmotionTimelineAnimator")
			end

			local var_543_7 = arg_540_1.actors_["1034ui_story"]

			if 0 < arg_540_1.time_ and arg_540_1.time_ <= 0 + arg_543_0 and not isNil(var_543_7) and arg_540_1.var_.characterEffect1034ui_story == nil then
				arg_540_1.var_.characterEffect1034ui_story = var_543_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_543_8 = 0.200000002980232

			if 0 <= arg_540_1.time_ and arg_540_1.time_ < 0 + var_543_8 and not isNil(var_543_7) then
				if arg_540_1.var_.characterEffect1034ui_story and not isNil(var_543_7) then
					arg_540_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_540_1.time_ >= 0 + var_543_8 and arg_540_1.time_ < 0 + var_543_8 + arg_543_0 and not isNil(var_543_7) and arg_540_1.var_.characterEffect1034ui_story then
				arg_540_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_543_10 = 0
			local var_543_11 = 0.475

			if 0 < arg_540_1.time_ and arg_540_1.time_ <= var_543_10 + arg_543_0 then
				arg_540_1.talkMaxDuration = 0
				arg_540_1.dialogCg_.alpha = 1

				arg_540_1.dialog_:SetActive(true)
				SetActive(arg_540_1.leftNameGo_, true)

				arg_540_1.leftNameTxt_.text = arg_540_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_540_1.leftNameTxt_.transform)

				arg_540_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_540_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_540_1:RecordName(arg_540_1.leftNameTxt_.text)
				SetActive(arg_540_1.iconTrs_.gameObject, false)
				arg_540_1.callingController_:SetSelectedState("normal")

				local var_543_12 = arg_540_1:GetWordFromCfg(1103401066)
				local var_543_13 = arg_540_1:FormatText(var_543_12.content)

				arg_540_1.text_.text = var_543_13

				LuaForUtil.ClearLinePrefixSymbol(arg_540_1.text_)

				local var_543_15 = 19 <= 0 and var_543_11 or var_543_11 * (utf8.len(var_543_13) / 19)

				if (19 <= 0 and var_543_11 or var_543_11 * (utf8.len(var_543_13) / 19)) > 0 and var_543_11 < var_543_15 then
					arg_540_1.talkMaxDuration = var_543_15

					if var_543_15 + var_543_10 > arg_540_1.duration_ then
						arg_540_1.duration_ = var_543_15 + var_543_10
					end
				end

				arg_540_1.text_.text = var_543_13
				arg_540_1.typewritter.percent = 0

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401066", "story_v_side_new_1103401.awb") ~= 0 then
					local var_543_16 = manager.audio:GetVoiceLength("story_v_side_new_1103401", "1103401066", "story_v_side_new_1103401.awb") / 1000

					if var_543_16 + var_543_10 > arg_540_1.duration_ then
						arg_540_1.duration_ = var_543_16 + var_543_10
					end

					if var_543_12.prefab_name ~= "" and arg_540_1.actors_[var_543_12.prefab_name] ~= nil then
						local var_543_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_540_1.actors_[var_543_12.prefab_name].transform, "story_v_side_new_1103401", "1103401066", "story_v_side_new_1103401.awb")

						arg_540_1:RecordAudio("1103401066", var_543_17)
						arg_540_1:RecordAudio("1103401066", var_543_17)
					else
						arg_540_1:AudioAction("play", "voice", "story_v_side_new_1103401", "1103401066", "story_v_side_new_1103401.awb")
					end

					arg_540_1:RecordHistoryTalkVoice("story_v_side_new_1103401", "1103401066", "story_v_side_new_1103401.awb")
				end

				arg_540_1:RecordContent(arg_540_1.text_.text)
			end

			local var_543_18 = math.max(var_543_11, arg_540_1.talkMaxDuration)

			if var_543_10 <= arg_540_1.time_ and arg_540_1.time_ < var_543_10 + var_543_18 then
				arg_540_1.typewritter.percent = (arg_540_1.time_ - var_543_10) / var_543_18

				arg_540_1.typewritter:SetDirty()
			end

			if arg_540_1.time_ >= var_543_10 + var_543_18 and arg_540_1.time_ < var_543_10 + var_543_18 + arg_543_0 then
				arg_540_1.typewritter.percent = 1

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(true)
			end
		end

		arg_540_1.nodeConfigList_ = {}

		arg_540_1:InitPlayNodeList()
	end,
	Play1103401016 = function(arg_544_0, arg_544_1)
		arg_544_1.time_ = 0
		arg_544_1.frameCnt_ = 0
		arg_544_1.state_ = "playing"
		arg_544_1.curTalkId_ = 1103401016
		arg_544_1.duration_ = 5

		SetActive(arg_544_1.tipsGo_, false)

		function arg_544_1.onSingleLineFinish_()
			arg_544_1.onSingleLineUpdate_ = nil
			arg_544_1.onSingleLineFinish_ = nil
			arg_544_1.state_ = "waiting"
		end

		function arg_544_1.playNext_(arg_546_0)
			if arg_546_0 == 1 then
				arg_544_0:Play1103401017(arg_544_1)
			end
		end

		function arg_544_1.onSingleLineUpdate_(arg_547_0)
			if 0 < arg_544_1.time_ and arg_544_1.time_ <= 0 + arg_547_0 then
				arg_544_1:AudioAction("play", "effect", "se_story_side_1148", "se_story_1148_vibrate", "")
			end

			local var_547_1 = 0
			local var_547_2 = 1.225

			if 0 < arg_544_1.time_ and arg_544_1.time_ <= var_547_1 + arg_547_0 then
				arg_544_1.talkMaxDuration = 0
				arg_544_1.dialogCg_.alpha = 1

				arg_544_1.dialog_:SetActive(true)
				SetActive(arg_544_1.leftNameGo_, false)

				arg_544_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_544_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_544_1:RecordName(arg_544_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_544_1.iconTrs_.gameObject, false)
				arg_544_1.callingController_:SetSelectedState("normal")

				local var_547_3 = arg_544_1:FormatText(arg_544_1:GetWordFromCfg(1103401016).content)

				arg_544_1.text_.text = var_547_3

				LuaForUtil.ClearLinePrefixSymbol(arg_544_1.text_)

				local var_547_5 = 49 <= 0 and var_547_2 or var_547_2 * (utf8.len(var_547_3) / 49)

				if (49 <= 0 and var_547_2 or var_547_2 * (utf8.len(var_547_3) / 49)) > 0 and var_547_2 < var_547_5 then
					arg_544_1.talkMaxDuration = var_547_5

					if var_547_5 + var_547_1 > arg_544_1.duration_ then
						arg_544_1.duration_ = var_547_5 + var_547_1
					end
				end

				arg_544_1.text_.text = var_547_3
				arg_544_1.typewritter.percent = 0

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(false)
				arg_544_1:RecordContent(arg_544_1.text_.text)
			end

			local var_547_6 = math.max(var_547_2, arg_544_1.talkMaxDuration)

			if var_547_1 <= arg_544_1.time_ and arg_544_1.time_ < var_547_1 + var_547_6 then
				arg_544_1.typewritter.percent = (arg_544_1.time_ - var_547_1) / var_547_6

				arg_544_1.typewritter:SetDirty()
			end

			if arg_544_1.time_ >= var_547_1 + var_547_6 and arg_544_1.time_ < var_547_1 + var_547_6 + arg_547_0 then
				arg_544_1.typewritter.percent = 1

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(true)
			end
		end

		arg_544_1.nodeConfigList_ = {}

		arg_544_1:InitPlayNodeList()
	end,
	Play1103401017 = function(arg_548_0, arg_548_1)
		arg_548_1.time_ = 0
		arg_548_1.frameCnt_ = 0
		arg_548_1.state_ = "playing"
		arg_548_1.curTalkId_ = 1103401017
		arg_548_1.duration_ = 5

		SetActive(arg_548_1.tipsGo_, false)

		function arg_548_1.onSingleLineFinish_()
			arg_548_1.onSingleLineUpdate_ = nil
			arg_548_1.onSingleLineFinish_ = nil
			arg_548_1.state_ = "waiting"
		end

		function arg_548_1.playNext_(arg_550_0)
			if arg_550_0 == 1 then
				arg_548_0:Play1103401018(arg_548_1)
			end
		end

		function arg_548_1.onSingleLineUpdate_(arg_551_0)
			local var_551_0 = 0.45

			if 0 < arg_548_1.time_ and arg_548_1.time_ <= 0 + arg_551_0 then
				arg_548_1.talkMaxDuration = 0
				arg_548_1.dialogCg_.alpha = 1

				arg_548_1.dialog_:SetActive(true)
				SetActive(arg_548_1.leftNameGo_, true)

				arg_548_1.leftNameTxt_.text = arg_548_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_548_1.leftNameTxt_.transform)

				arg_548_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_548_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_548_1:RecordName(arg_548_1.leftNameTxt_.text)
				SetActive(arg_548_1.iconTrs_.gameObject, true)
				arg_548_1.iconController_:SetSelectedState("hero")

				arg_548_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_548_1.callingController_:SetSelectedState("normal")

				arg_548_1.keyicon_.color = Color.New(1, 1, 1)
				arg_548_1.icon_.color = Color.New(1, 1, 1)

				local var_551_1 = arg_548_1:FormatText(arg_548_1:GetWordFromCfg(1103401017).content)

				arg_548_1.text_.text = var_551_1

				LuaForUtil.ClearLinePrefixSymbol(arg_548_1.text_)

				local var_551_3 = 18 <= 0 and var_551_0 or var_551_0 * (utf8.len(var_551_1) / 18)

				if (18 <= 0 and var_551_0 or var_551_0 * (utf8.len(var_551_1) / 18)) > 0 and var_551_0 < var_551_3 then
					arg_548_1.talkMaxDuration = var_551_3

					if var_551_3 + 0 > arg_548_1.duration_ then
						arg_548_1.duration_ = var_551_3 + 0
					end
				end

				arg_548_1.text_.text = var_551_1
				arg_548_1.typewritter.percent = 0

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(false)
				arg_548_1:RecordContent(arg_548_1.text_.text)
			end

			local var_551_4 = math.max(var_551_0, arg_548_1.talkMaxDuration)

			if 0 <= arg_548_1.time_ and arg_548_1.time_ < 0 + var_551_4 then
				arg_548_1.typewritter.percent = (arg_548_1.time_ - 0) / var_551_4

				arg_548_1.typewritter:SetDirty()
			end

			if arg_548_1.time_ >= 0 + var_551_4 and arg_548_1.time_ < 0 + var_551_4 + arg_551_0 then
				arg_548_1.typewritter.percent = 1

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(true)
			end
		end

		arg_548_1.nodeConfigList_ = {}

		arg_548_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I11o",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST01",
		"TextureConfig/Background/ST03",
		"TextureConfig/Background/ST02"
	},
	voices = {
		"story_v_side_new_1103401.awb"
	}
}
